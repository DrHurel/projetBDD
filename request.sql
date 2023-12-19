SELECT id_entreprise,Count(*) as Nombre_Employes  FROM Personne GROUP BY id_entreprise; -- Nombre de personne dans une entreprise

SELECT * FROM Vaisseau WHERE id_vaisseau IN (SELECT id_vaisseau FROM Equipage GROUP BY id_vaisseau); -- tout les vaisseau qui on un équipage

SELECT * FROM Entreprise 
WHERE id_entreprise 
IN (
    SELECT * FROM Entreprise_Objet AS eo 
    WHERE EXISTS (
        SELECT * FROM Gamme_Vente_Objet AS gvo JOIN Modele_Objet AS mo ON gvo.id_objet=mo.id_objet
        WHERE eo.id_entreprise = gvo.id_fabriquant AND mo.statut='ILLEGAL')); -- tout les entreprise objet qui vendent des choses illégal 




-- trouver les entreprises qui vendent uniquement des objets illégaux
SELECT DISTINCT E.id_entreprise, E.nom_entreprise
FROM Entreprise E
LEFT JOIN Gamme_Vente_Objet GVO ON E.id_entreprise = GVO.id_fabriquant
LEFT JOIN Modele_Objet MO ON GVO.id_objet = MO.id_objet
WHERE MO.statut = 'ILLEGAL'
AND NOT EXISTS (
    SELECT 1
    FROM Gamme_Vente_Objet GVO2
    LEFT JOIN Modele_Objet MO2 ON GVO2.id_objet = MO2.id_objet
    WHERE E.id_entreprise = GVO2.id_fabriquant
    AND MO2.statut = 'LEGAL'
);

--les vaisseaux qui ont un prix > à la moyenne des prix de tout les vaisseaux
SELECT *
FROM Vaisseau
WHERE prix > (
    SELECT AVG(prix)
    FROM Vaisseau
);

-- tout les vaisseaux qui n'ont  que des objets illégal dans leur inventaire 
SELECT id_vaisseau, nom
FROM Vaisseau
WHERE id_vaisseau IN (
    SELECT id_vaisseau
    FROM Inventaire_Vaisseau
    GROUP BY id_vaisseau
    HAVING COUNT(DISTINCT id_objet) = (
        SELECT COUNT(DISTINCT id_objet)
        FROM Modele_Objet
        WHERE statut = 'ILLEGAL'
    )
);


--entreprises dont le nombre d'objets vendus est supérieur à la moyenne du nombre d'objets vendus par les autres entreprises
SELECT id_entreprise, nom_entreprise
FROM Entreprise E1
WHERE (
    SELECT COUNT(*)
    FROM Gamme_Vente_Objet GVO
    WHERE GVO.id_fabriquant = E1.id_entreprise
) > (
    SELECT AVG(nombre_objets)
    FROM (
        SELECT COUNT(*) AS nombre_objets
        FROM Gamme_Vente_Objet
        GROUP BY id_fabriquant
    ) AS subquery
);

