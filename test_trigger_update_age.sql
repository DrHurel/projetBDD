BEGIN TRANSACTION; --insert sans age

INSERT INTO Proprietaire (id_proprietaire) VALUES (121);

INSERT INTO Personne(id_personne,nom,prenom,date_naissance) VALUES  (121, 'Smith', 'Howard','1993-05-20');
SELECT id_personne,age,date_naissance FROM Personne;

ROLLBACK;

BEGIN TRANSACTION; --insert avec mauvais age

INSERT INTO Proprietaire (id_proprietaire) VALUES (122);

INSERT INTO Personne(id_personne,nom,prenom,age,date_naissance) VALUES  (122, 'Smith', 'Ethan',1120,'1993-05-20');
SELECT id_personne,age,date_naissance FROM Personne;

ROLLBACK;