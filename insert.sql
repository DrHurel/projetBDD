

-- Insert into Proprietaire table
INSERT INTO Proprietaire (id_proprietaire) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

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
(10, 'Prototype AI Module', 'ILLEGAL', 5000, 12);


-- Insert into Entreprise table
INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
(1, 'Company1', '2023-01-01'),
(2, 'Company2', '2023-02-15'),
(3, 'Company3', '2023-03-10'),
(4, 'Company4', '2023-04-20'),
(5, 'Company5', '2023-05-05'),
(6, 'Company6', '2023-06-30'),
(7, 'Company7', '2023-07-18'),
(8, 'Company8', '2023-08-25'),
(9, 'Company9', '2023-09-08'),
(10, 'Company10', '2023-10-12');



-- Insert into Entreprise_Vaisseau table
INSERT INTO Entreprise_Vaisseau (id_entreprise) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert into Entreprise_Objet table
INSERT INTO Entreprise_Objet (id_entreprise) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO Vaisseau (id_vaisseau, nom, prix, poids, longueur, largeur, id_fabriquant) VALUES
(1, 'Constellation', 1000, 500, 30, 20, 1),
(2, 'Sabre', 1200, 600, 35, 25, 2),
(3, 'Carrack', 1500, 700, 40, 30, 3),
(4, 'Hammerhead', 1800, 800, 45, 35, 4),
(5, 'Starfarer', 2000, 900, 50, 40, 5),
(6, 'Cutlass Black', 2200, 1000, 55, 45, 6),
(7, 'Herald', 2500, 1100, 60, 50, 7),
(8, 'Freelancer MAX', 2800, 1200, 65, 55, 8),
(9, 'Reclaimer', 3000, 1300, 70, 60, 9),
(10, 'Pioneer', 3500, 1400, 75, 65, 10);


-- Insert into Equipage table
INSERT INTO Equipage (id_equipage, nom, date_creation, id_vaisseau) VALUES
(1, 'Crew1', '2023-01-10', 1),
(2, 'Crew2', '2023-02-20', 2),
(3, 'Crew3', '2023-03-15', 3),
(4, 'Crew4', '2023-04-25', 4),
(5, 'Crew5', '2023-05-10', 5),
(6, 'Crew6', '2023-06-25', 6),
(7, 'Crew7', '2023-07-20', 7),
(8, 'Crew8', '2023-08-30', 8),
(9, 'Crew9', '2023-09-12', 9),
(10, 'Crew10', '2023-10-15', 10);

-- Insert into Personne table
-- Personne
INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_entreprise, id_equipage) VALUES
    (1, 'Smith', 'John', 'Engineer', '1993-05-20', 1, 1),
    (2, 'Johnson', 'Jane', 'Pilot', '1988-10-15', 2, 2),
    (3, 'Williams', 'Bob', 'Navigator', '1995-03-08', 3, 3),
    (4, 'Davis', 'Alice', 'Technician', '1990-07-18', 4, 4),
    (5, 'Miller', 'Charlie', 'Security', '1996-01-30', 5, 5),
    (6, 'Martinez', 'Eva', 'Medic', '1982-12-05', 6, 6),
    (7, 'Anderson', 'David', 'Scientist', '1989-04-22', 7, 7),
    (8, 'Brown', 'Sophie', 'Communications', '1991-09-10', 8, 8),
    (9, 'Smith', 'Michael', 'Chef', '1978-06-15', 9, 9),
    (10, 'Taylor', 'Olivia', 'Engineer', '1994-11-28', 10, 10);

-- Insert into Vaisseau table


-- Insert into Chef_Entreprise table
INSERT INTO Chef_Entreprise (date_debut, date_fin, id_entreprise, id_personne) VALUES
('2023-01-01', '2023-03-01', 1, 1),
('2023-02-15', '2023-04-15', 2, 2),
('2023-03-10', '2023-05-10', 3, 3),
('2023-04-20', '2023-06-20', 4, 4),
('2023-05-05', '2023-07-05', 5, 5),
('2023-06-30', '2023-08-30', 6, 6),
('2023-07-18', '2023-09-18', 7, 7),
('2023-08-25', '2023-10-25', 8, 8),
('2023-09-08', '2023-11-08', 9, 9),
('2023-10-12', '2023-12-12', 10, 10);

-- Insert into Gamme_Vente_Objet table
INSERT INTO Gamme_Vente_Objet (id_fabriquant, id_objet) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

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
(1, 1, 1, '2023-01-15'),
(2, 2, 2, '2023-02-28'),
(3, 3, 3, '2023-03-25'),
(4, 4, 4, '2023-04-28'),
(5, 5, 5, '2023-05-15'),
(6, 6, 6, '2023-06-30'),
(7, 7, 7, '2023-07-28'),
(8, 8, 8, '2023-08-30'),
(9, 9, 9, '2023-09-15'),
(10, 10, 10, '2023-10-20');
