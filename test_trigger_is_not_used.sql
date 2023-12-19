BEGIN TRANSACTION;

-- TEST INSERT cas -> Pas d'id dans la table propriétaire

INSERT INTO Equipage (id_equipage) VALUES (1);

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (101, 'Aegis Dynamics', '2023-01-01');

INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_equipage) VALUES
    (110, 'Smith', 'John', 'Engineer', '1993-05-20', 1);


SELECT * FROM Personne WHERE id_personne=110; 
SELECT * FROM Entreprise WHERE id_entreprise=101;
SELECT * FROM Proprietaire WHERE id_proprietaire=101 OR id_proprietaire=110;
ROLLBACK;

-- TEST INSERT cas -> Même id pour les 2 inserts
BEGIN;

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (1200, 'Aegis Dynamics', '2023-01-01');

INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance) VALUES
    (1200, 'Smith', 'John', 'Engineer', '1993-05-20');

SELECT * FROM Personne WHERE id_personne=1200; 
SELECT * FROM Entreprise WHERE id_entreprise=1200;
SELECT * FROM Proprietaire WHERE id_proprietaire=1200;
END;


-- TEST INSERT cas -> Même id pour les 2 inserts mais ordre inverse
BEGIN;

INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance) VALUES
    (1000, 'Smith', 'John', 'Engineer', '1993-05-20');

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (1000, 'Aegis Dynamics', '2023-01-01');
SELECT * FROM Personne WHERE id_personne=1000; 
SELECT * FROM Entreprise WHERE id_entreprise=1000;
SELECT * FROM Proprietaire WHERE id_proprietaire=1000;

END;

-- TEST INSERT cas -> insert with existing id
BEGIN;
INSERT INTO Proprietaire (id_proprietaire) VALUES (113);
INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance) VALUES
    (113, 'Smith', 'John', 'Engineer', '1993-05-20');
END;

