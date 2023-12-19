SELECT id_entreprise,Count(*) as Nombre_Employes  FROM Personne GROUP BY id_entreprise; -- Nombre de personne dans une entreprise

SELECT * FROM Vaisseau WHERE id_vaisseau IN (SELECT id_vaisseau FROM Equipage GROUP BY id_vaisseau); -- tout les vaisseau qui on un équipage

SELECT * FROM Entreprise 
WHERE id_entreprise 
IN (
    SELECT * FROM Entreprise_Objet AS eo 
    WHERE EXISTS (
        SELECT * FROM Gamme_Vente_Objet AS gvo JOIN Modele_Objet AS mo ON gvo.id_objet=mo.id_objet
        WHERE eo.id_entreprise = gvo.id_fabriquant AND mo.statut='ILLEGAL')); -- tout les entreprise objet qui vendent des choses illégal 
