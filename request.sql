SELECT id_entreprise,Count(*) as Nombre_Employes  FROM Personne GROUP BY id_entreprise; -- Combien compte t-on d’employés pour chaque entreprise?

SELECT * FROM Vaisseau WHERE id_vaisseau NOT IN (SELECT id_vaisseau FROM Equipage GROUP BY id_vaisseau); -- Quels sont les vaisseaux n’ayant pas d'équipage ?


SELECT e.id_equipage,e.nom AS nom_equipage,AVG(EXTRACT(YEAR FROM age(p.date_naissance))) AS moyenne_age -- quelle est la moyenne d'âge des membres de chaque équipage?
FROM Equipage e
JOIN Personne p ON e.id_equipage = p.id_equipage
GROUP BY e.id_equipage, e.nom
ORDER BY moyenne_age DESC;




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

