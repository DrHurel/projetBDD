--test trigger age
INSERT INTO Proprietaire (id_proprietaire) VALUES (100020), (100021);

INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant) VALUES (42000, 'Constellation', 1000, 500, 30, 20, 11);

INSERT INTO Equipage (id_equipage, nom, date_creation, id_vaisseau) VALUES (6600, 'Explorer Expedition Team 2', '2023-02-10', 42000);

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES (100021, 'pas legale','2023-12-24');

INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_entreprise, id_equipage) VALUES (100020, 'Duban', 'Mathis', 'Ecolier', '2023-05-20', 100021, 6600);

INSERT INTO Chef_Entreprise (date_debut, date_fin,id_personne,id_entreprise) VALUES ('2023-08-01', NULL, 100020, 100021);

