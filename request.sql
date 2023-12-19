SELECT id_entreprise,Count(*) as Nombre_Employes  FROM Personne GROUP BY id_entreprise; -- Combien compte t-on d’employés pour chaque entreprise?

SELECT * FROM Vaisseau WHERE id_vaisseau NOT IN (SELECT id_vaisseau FROM Equipage GROUP BY id_vaisseau); -- Quels sont les vaisseaux n’ayant pas d'équipage ?






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

--Quels sont les vaisseaux ayant un prix supérieur à la moyenne des prix des autres vaisseaux?
SELECT *
FROM Vaisseau
WHERE prix > (
    SELECT AVG(prix)
    FROM Vaisseau
);

-- Quels sont les vaisseaux qui ne possèdent que des objets illégaux dans leur inventaire?
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



--Quelles sont les entreprises dont le nombre de gammes d'objets proposés à la vente dépasse la moyenne du nombre de gammes d'objets proposés à la vente par les autres entreprises ?
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
    )
);

