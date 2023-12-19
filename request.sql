SELECT id_entreprise,Count(*) as Nombre_Employes  FROM Personne GROUP BY id_entreprise; -- Nombre de personne dans une entreprise

SELECT * FROM Vaisseau WHERE id_vaisseau NOT IN (SELECT id_vaisseau FROM Equipage GROUP BY id_vaisseau); -- tout les vaisseau qui n'ont pas d'équipages






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
WHERE id_vaisseau NOT IN (
    SELECT id_vaisseau
    FROM Inventaire_Vaisseau
    GROUP BY id_vaisseau
    HAVING COUNT(*) > 0
    AND COUNT(*) = (
        SELECT COUNT(*)
        FROM Inventaire_Vaisseau iv
        JOIN Modele_Objet mo ON iv.id_objet = mo.id_objet
        WHERE mo.statut = 'LEGAL'
        AND iv.id_vaisseau = Vaisseau.id_vaisseau
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

