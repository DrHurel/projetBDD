
-- Proprietaire
INSERT INTO Proprietaire (id_proprietaire) VALUES
    (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
    (11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
    (21), (22), (23), (24), (25), (26), (27), (28), (29), (30);


-- Insert into Modele_Objet table
INSERT INTO Modele_Objet (id_objet, nom, statut, prix, masse) VALUES
(1, 'Quantum Drive', 'LEGAL', 5000, 20),
(2, 'Plasma Cannon', 'ILLEGAL', 800, 15),
(3, 'Shield Generator Mk II', 'LEGAL', 3000, 30),
(4, 'Contraband Data Chip', 'ILLEGAL', 1000, 5),
(5, 'Medkit', 'LEGAL', 200, 2),
(6, 'EMP Device', 'ILLEGAL', 1200, 10),
(7, 'Quantum Fuel', 'LEGAL', 150, 25),
(8, 'Stealth Cloak', 'ILLEGAL', 2500, 18),
(9, 'Mining Laser', 'LEGAL', 3500, 40),
(10, 'Prototype AI Module', 'ILLEGAL', 5000, 12),
(11, 'Aegis Avenger Stalker Module', 'LEGAL', 2000, 15),
(12, 'Mantis GT-220 Plasma Cannon', 'ILLEGAL', 1200, 8),
(13, 'Origin 3M Shield Generator', 'LEGAL', 4000, 25),
(14, 'Crusader Mercury Star Runner Data Chip', 'ILLEGAL', 800, 10),
(15, 'RSI Apollo Medkit', 'LEGAL', 700, 5),
(16, 'Archer EMP Device', 'ILLEGAL', 1500, 12),
(17, 'CryAstro Quantum Fuel', 'LEGAL', 1000, 18),
(18, 'Sabre Raven Stealth Cloak', 'ILLEGAL', 3000, 30),
(19, 'RSI Orion Mining Laser', 'LEGAL', 250, 8),
(20, 'Vanduul Blade Prototype AI Module', 'ILLEGAL', 4000, 15);



-- Insert into Entreprise table
-- Entreprise
INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (11, 'Aegis Dynamics', '2023-01-01'),
    (12, 'Anvil Aerospace', '2023-02-15'),
    (13, 'Origin Jumpworks', '2023-03-10'),
    (14, 'Consolidated Outland', '2023-04-20'),
    (15, 'Drake Interplanetary', '2023-05-05'),
    (16, 'Esperia', '2023-06-30'),
    (17, 'RSI (Roberts Space Industries)', '2023-07-18'),
    (18, 'MISC (Musashi Industrial & Starflight Concern)', '2023-08-25'),
    (19, 'Crusader Industries', '2023-09-08'),
    (20, 'Argo Astronautics', '2023-10-12'),
    (21, 'MicroTech', '2023-11-15'),
    (22, 'Hurston Dynamics', '2023-12-20'),
    (24, 'ArcCorp', '2024-01-25'),
    (25, 'Aopoa', '2024-03-10');






-- Insert into Entreprise_Vaisseau table
INSERT INTO Entreprise_Vaisseau (id_entreprise, categorie) VALUES
    (11,'Combat'), (12,'Transport'), (13,'Exploration'), (14,'Industrial'), (15,'Support'), (16,'Competition'), (17,'Ground'), (18,'Multi'), (19,'Exploration'), (20,'Transport');

-- Insert into Entreprise_Objet table
INSERT INTO Entreprise_Objet (id_entreprise) VALUES
    (11), (12), (13), (14), (15), (16), (17), (18), (19), (20);


INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant) VALUES
(1, 'Constellation', 1000, 500, 30, 20, 11),
(2, 'Sabre', 1200, 600, 35, 25, 12),
(3, 'Carrack', 1500, 700, 40, 30, 13),
(4, 'Hammerhead', 1800, 800, 45, 35, 14),
(5, 'Starfarer', 2000, 900, 50, 40, 15),
(6, 'Cutlass Black', 2200, 1000, 55, 45, 16),
(7, 'Herald', 2500, 1100, 60, 50, 17),
(8, 'Freelancer MAX', 2800, 1200, 65, 55, 18),
(9, 'Reclaimer', 3000, 1300, 70, 60, 19),
(10, 'Pioneer', 3500, 1400, 75, 65, 20);


-- Insert into Equipage table
-- Equipage
INSERT INTO Equipage (id_equipage, nom, date_creation, id_vaisseau) VALUES
    (1, 'Explorer Expedition Team', '2023-01-10', 1),
    (2, 'Starlight Recon Squadron', '2023-02-20', 2),
    (3, 'Astro Navigator Crew', '2023-03-15', 3),
    (4, 'Tech Innovators', '2023-04-25', 4),
    (5, 'Guardian Security Team', '2023-05-10', 5),
    (6, 'MedBay Response Unit', '2023-06-25', 6),
    (7, 'Quantum Research Team', '2023-07-20', 7),
    (8, 'Comms Connection Crew', '2023-08-30', 8),
    (9, 'MasterChef and Engineers', '2023-09-12', 9),
    (10, 'Stellar Engineering Corps', '2023-10-15', 10);


-- Insert into Personne table
-- Personne
INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_entreprise, id_equipage) VALUES
    (1, 'Smith', 'John', 'Engineer', '1993-05-20', 11, 1),
    (2, 'Johnson', 'Jane', 'Pilot', '1988-10-15', 12, 2),
    (3, 'Williams', 'Bob', 'Navigator', '1995-03-08', 13, 3),
    (4, 'Davis', 'Alice', 'Technician', '1990-07-18', 14, 4),
    (5, 'Miller', 'Charlie', 'Security', '1996-01-30', 15, 5),
    (6, 'Martinez', 'Eva', 'Medic', '1982-12-05', 16, 6),
    (7, 'Anderson', 'David', 'Scientist', '1989-04-22', 17, 7),
    (8, 'Brown', 'Sophie', 'Communications', '1991-09-10', 18, 8),
    (9, 'Smith', 'Michael', 'Chef', '1978-06-15', 19, 9),
    (10, 'Taylor', 'Olivia', 'Engineer', '1994-11-28', 20, 10);

-- Insert into Vaisseau table


-- Insert into Chef_Entreprise table
INSERT INTO Chef_Entreprise (date_debut, date_fin,id_personne,id_entreprise) VALUES
('2023-01-01', '2023-03-01', 1, 11),
('2023-02-15', '2023-04-15', 2, 12),
('2023-03-10', '2023-05-10', 3, 13),
('2023-04-20', '2023-06-20', 4, 14),
('2023-05-05', '2023-07-05', 5, 15),
('2023-06-30', '2023-08-30', 6, 16),
('2023-07-18', '2023-09-18', 7, 17),
('2023-08-25', '2023-10-25', 8, 18),
('2023-09-08', '2023-11-08', 9, 19),
('2023-10-12', '2023-12-12', 10, 20);

-- Insert into Gamme_Vente_Objet table
INSERT INTO Gamme_Vente_Objet (id_fabriquant, id_objet) VALUES
(11, 1),
(11, 3),
(11, 5),
(11, 7),
(11, 9),
(12, 2),
(12, 4),
(12, 6),
(12, 8),
(12, 10),
(13, 3),
(13, 1),
(13, 2),
(14, 4),
(14, 1),
(15, 5),
(16, 6),
(16, 1),
(16, 3),
(17, 7),
(18, 8),
(18, 5),
(19, 9),
(20, 10),
(20, 9);


-- Insert into Inventaire_Vaisseau table
INSERT INTO Inventaire_Vaisseau (id_vaisseau, id_objet, quantite) VALUES
(1, 1, 100),
(2, 2, 75),
(3, 3, 120),
(4, 4, 90),
(5, 5, 80),
(6, 6, 150),
(7, 7, 110),
(8, 8, 100),
(9, 9, 130),
(10, 10, 95);

-- Insert into Historique_Proprio table
INSERT INTO Historique_Proprio (id_vaisseau, id_proprietaire, date_debut, date_fin) VALUES
(1, 1, '2023-01-01', '2023-02-01'),
(2, 2, '2023-02-15', '2023-03-15'),
(3, 3, '2023-03-10', '2023-04-10'),
(4, 4, '2023-04-20', '2023-05-20'),
(5, 5, '2023-05-05', '2023-06-05'),
(6, 6, '2023-06-30', '2023-07-30'),
(7, 7, '2023-07-18', '2023-08-18'),
(8, 8, '2023-08-25', '2023-09-25'),
(9, 9, '2023-09-08', '2023-10-08'),
(10, 10, '2023-10-12', '2023-11-12');

-- Insert into Historique_Vente_Vaisseau table
INSERT INTO Historique_Vente_Vaisseau (id_vaisseau, id_entreprise, id_proprietaire, date_vente) VALUES
    (1, 11, 1, '2023-01-15'),
    (2, 12, 2, '2023-02-28'),
    (3, 13, 1, '2023-03-25'),
    (4, 14, 4, '2023-04-28'),
    (5, 15, 5, '2023-05-15'),
    (6, 16, 6, '2023-06-30'),
    (7, 17, 2, '2023-07-28'),
    (8, 17, 18, '2023-08-30'),
    (9, 11, 19, '2023-09-15'),
    (10, 18, 20, '2023-10-20');

