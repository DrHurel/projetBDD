--test trigger age chef entreprise

INSERT INTO Proprietaire (id_proprietaire)
VALUES (100020), (100021);


INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant)
VALUES (42000,
        'Constellation',
        1000,
        500,
        30,
        20,
        11);


INSERT INTO Equipage (id_equipage, nom, date_creation, id_vaisseau)
VALUES (6600,
        'Explorer Expedition Team 2',
        '2023-02-10',
        42000);


INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation)
VALUES (100021,
        'pas legale',
        '2023-12-24');


INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_entreprise, id_equipage)
VALUES (100020,
        'Duban',
        'Mathis',
        'Ecolier',
        '2023-05-20',
        100021,
        6600);


INSERT INTO Chef_Entreprise (date_debut, date_fin,id_personne,id_entreprise)
VALUES ('2023-08-01',
        NULL,
        100020,
        100021);

--test trigger masse inventaire vaisseau qui passe car moins de la moitier de la masse

INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant)
VALUES (42042,
        'VULTURE',
        1000,
        500,
        30,
        20,
        14); --500 de masse kg

INSERT INTO Inventaire_Vaisseau (id_vaisseau, id_objet, quantite)
VALUES(42042,
       13,
       1); --25 de masse g

--test trigger masse inventaire vaisseau qui passe pas car plus de la moitier de la masse

INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant)
VALUES (42642,
        'CORSAIR',
        1000,
        500,
        30,
        20,
        14); --500 de masse kg

INSERT INTO Inventaire_Vaisseau (id_vaisseau, id_objet, quantite)
VALUES(42642,
       13,
       15000); --25 de masse g, donc 25 * 15 = 375 g, donc * 1000 = 375 kg

--test trigger masse inventaire vaisseau qui passe pas car c'est la moitier pile de la masse

INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant)
VALUES (42342, 
        'C1',
        1000,
        500,
        30,
        20,
        14); --500 de masse kg

INSERT INTO Inventaire_Vaisseau (id_vaisseau, id_objet, quantite)
VALUES(42342,
       13,
       10000); --25 de masse g, donc 25 * 10 = 250 g, donc * 1000 = 250 kg

-- test trigger is_not_used_by_personne qui passe car pas utilisé par une personne

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation)
VALUES (101,
        'Aegis Dynamics',
        '2023-01-01');

-- test trigger is_not_used_by_entreprise qui passe car pas utilisé par une entreprise

INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_equipage)
VALUES (110,
        'Smith',
        'John',
        'Engineer',
        '1993-05-20',
        1);

-- Test trigger is_not_used_by_entreprise qui passe pas car utilisé par une entreprise

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation)
VALUES (1200,
        'Aegis Dynamics',
        '2023-01-01');


INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance)
VALUES (1200,
        'Smith',
        'John',
        'Engineer',
        '1993-05-20');

-- Test trigger is_not_used_by_personne qui passe pas car utilisé par une personne
INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance) VALUES
    (1000, 'Smith', 'John', 'Engineer', '1993-05-20');

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (1000, 'Aegis Dynamics', '2023-01-01');


-- test trigger update_age insert sans age
INSERT INTO Personne(id_personne,nom,prenom,date_naissance) VALUES  (121, 'Smith', 'Howard','1993-05-20');

-- test trigger update_age insert avec age incorrect
INSERT INTO Personne(id_personne,nom,prenom,age,date_naissance) VALUES  (122, 'Smith', 'Ethan',1120,'1993-05-20');