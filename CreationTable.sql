CREATE TABLE Proprietaire (
    id_proprietaire INT,
    CONSTRAINT PK_Proprietaire_id_proprietaire PRIMARY KEY(id_proprietaire)
);

CREATE TABLE Modele_Objet(
    id_objet INT,
    nom VARCHAR(64) NOT NULL,
    statut VARCHAR(7) NOT NULL,
    prix INT NOT NULL,
    masse INT NOT NULL,
    CONSTRAINT TYPE_OBJET CHECK (statut IN ('LEGAL','ILLEGAL')),
    CONSTRAINT PK_Modele_Objet_id_objet PRIMARY KEY(id_objet)
);

CREATE TABLE Entreprise(
    id_entreprise INT,
    nom_entreprise VARCHAR(50) NOT NULL,
    data_creation DATE NOT NULL,
    CONSTRAINT FK_Entreprise_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Proprietaire(id_proprietaire),
    CONSTRAINT PK_Entreprise PRIMARY KEY(id_entreprise)
); 

CREATE TABLE Entreprise_Vaisseau(
    id_entreprise INT,
    CONSTRAINT FK_Entreprise_Vaisseau_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise),
    CONSTRAINT PK_Entreprise_Vaisseau PRIMARY KEY(id_entreprise)
);

CREATE TABLE Entreprise_Objet(
    id_entreprise INT,
    CONSTRAINT FK_Entreprise_Objet_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise),
    CONSTRAINT PK_Entreprise_Objet PRIMARY KEY(id_entreprise)
);

CREATE TABLE Vaisseau(
    id_vaisseau INT,
    nom VARCHAR(50),
    prix INT NOT NULL,
    poids INT NOT NULL,
    longueur INT NOT NULL,
    largeur INT NOT NULL,
    id_fabriquant INT NOT NULL,
    CONSTRAINT PK_Vaisseau PRIMARY KEY(id_vaisseau),
    CONSTRAINT FK_Vaisseau_id_fabriquant FOREIGN KEY(id_fabriquant) REFERENCES Entreprise_Vaisseau(id_entreprise)
);


CREATE TABLE Equipage (
    id_equipage INT,
    nom VARCHAR(50) NOT NULL,
    date_creation DATE NOT NULL,
    id_vaisseau INT NOT NULL,
    CONSTRAINT PK_Equipe_id_equipage PRIMARY KEY(id_equipage),
    CONSTRAINT FK_Equipage_id_entreprise FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau) 
);

CREATE TABLE Personne(
    id_personne INT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    poste VARCHAR(15) NOT NULL,
    age INT,
    date_naissance DATE NOT NULL,
    id_entreprise INT,
    id_equipage INT,
    CONSTRAINT FK_Personne_id_proprietaire FOREIGN KEY(id_personne) REFERENCES Proprietaire(id_proprietaire),
    CONSTRAINT PK_Personne PRIMARY KEY(id_personne),
    CONSTRAINT FK_Personne_id_Entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise),
    CONSTRAINT FK_Personne_id_equipage FOREIGN KEY(id_equipage) REFERENCES Equipage(id_equipage)
);
    

CREATE TABLE Chef_Entreprise(
    date_debut DATE NOT NULL,
    date_fin DATE,
    id_entreprise INT NOT NULL,
    id_personne INT NOT NULL,
    CONSTRAINT FK_Chef_Entreprise_id_personne FOREIGN KEY (id_personne) REFERENCES Personne(id_personne),
    CONSTRAINT FK_Chef_Entreprise_ID_Entreprise FOREIGN KEY (id_entreprise) REFERENCES Entreprise(id_entreprise),
    CONSTRAINT PK_Chef_Entreprise PRIMARY KEY(id_entreprise,id_personne,date_debut)   
);

CREATE TABLE Gamme_Vente_Objet(
    id_fabriquant INT,
    id_objet INT,
    CONSTRAINT FK_Gamme_Vente_Objet_id_fabriquant FOREIGN KEY(id_fabriquant) REFERENCES Entreprise_Objet(id_entreprise),
    CONSTRAINT FK_Gamme_Vente_Objet_id_objet FOREIGN KEY(id_objet) REFERENCES Modele_Objet(id_objet),
    CONSTRAINT PK_Gamme_Vente_Objet PRIMARY KEY(id_objet,id_fabriquant)   
);

CREATE TABLE Inventaire_Vaisseau(
    id_vaisseau INT,
    id_objet INT,
    quantite INT,
    CONSTRAINT FK_Inventaire_Vaisseau_id_objet FOREIGN KEY(id_objet) REFERENCES Modele_Objet(id_objet),
    CONSTRAINT FK_Inventaire_Vaisseau_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau),
    CONSTRAINT PK_Inventaire_Vaisseau PRIMARY KEY(id_objet,id_vaisseau),
    CONSTRAINT Valeur_Quantite CHECK(quantite>0)
); 

CREATE TABLE Historique_Proprio(
    id_vaisseau INT,
    id_proprietaire INT,
    date_debut DATE,
    date_fin DATE,
    CONSTRAINT PK_Historique_Proprio PRIMARY KEY(date_debut,id_proprietaire,id_vaisseau),
    CONSTRAINT FK_Historique_Proprio_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau),
    CONSTRAINT FK_Historique_Proprio_id_proprietaire FOREIGN KEY(id_proprietaire) REFERENCES Proprietaire(id_proprietaire)
);

CREATE TABLE Historique_Vente_Vaisseau(
    id_vaisseau INT,
    id_entreprise INT,
    id_proprietaire INT,
    date_vente DATE,
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau),
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_proprietaire FOREIGN KEY(id_proprietaire) REFERENCES Proprietaire(id_proprietaire),
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise_Vaisseau(id_entreprise),
    CONSTRAINT PK_Historique_Vente_Vaisseau PRIMARY KEY(id_vaisseau,id_entreprise,id_proprietaire,date_vente)
);



-- Insert into Proprietaire table
INSERT INTO Proprietaire (id_proprietaire) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert into Modele_Objet table
INSERT INTO Modele_Objet (id_objet, nom, statut, prix) VALUES
(1, 'Model1', 'LEGAL', 1000),
(2, 'Model2', 'ILLEGAL', 1500),
(3, 'Model3', 'LEGAL', 1200),
(4, 'Model4', 'ILLEGAL', 1800),
(5, 'Model5', 'LEGAL', 900),
(6, 'Model6', 'ILLEGAL', 2000),
(7, 'Model7', 'LEGAL', 1100),
(8, 'Model8', 'ILLEGAL', 1600),
(9, 'Model9', 'LEGAL', 1300),
(10, 'Model10', 'ILLEGAL', 1700);

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
INSERT INTO Personne (id_personne, nom, prenom, poste, age, date_naissance, id_entreprise, id_equipage) VALUES
(1, 'Person1', 'John', 'Engineer', 30, '1993-05-20', 1, 1),
(2, 'Person2', 'Jane', 'Pilot', 35, '1988-10-15', 2, 2),
(3, 'Person3', 'Bob', 'Navigator', 28, '1995-03-08', 3, 3),
(4, 'Person4', 'Alice', 'Technician', 32, '1990-07-18', 4, 4),
(5, 'Person5', 'Charlie', 'Security', 27, '1996-01-30', 5, 5),
(6, 'Person6', 'Eva', 'Medic', 40, '1982-12-05', 6, 6),
(7, 'Person7', 'David', 'Scientist', 33, '1989-04-22', 7, 7),
(8, 'Person8', 'Sophie', 'Communications', 31, '1991-09-10', 8, 8),
(9, 'Person9', 'Michael', 'Chef', 45, '1978-06-15', 9, 9),
(10, 'Person10', 'Olivia', 'Engineer', 29, '1994-11-28', 10, 10);

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
