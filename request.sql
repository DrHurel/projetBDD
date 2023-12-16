SELECT Count(*) FROM Personne GROUP BY id_entreprise; -- Nombre de personne dans une entreprise

SELECT * FROM Vaisseau WHERE id_vaisseau IN SELECT id_vaisseau FROM Equipage GROUP BY id_vaisseau; -- tout les vaisseau qui on un équipage

SELECT * FROM Entreprise WHERE id_entreprise IN SELECT * FROM Entreprise_Objet eo WHERE EXISTS (SELECT * FROM Modele_Objet mo WHERE eo.id_entreprise=mo.id_entreprise AND mo.statut='Illegal'); -- tout les entreprise objet qui vendent des choses illégal 