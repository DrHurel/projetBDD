/*
Duban Mathis [ 2210226 ]
Bernardon Vincent [ 22009116 ]
Hurel Jérémy [ 21907809 ]
*/

--test trigger age chef entreprise

INSERT INTO Proprietaire (id_proprietaire)
VALUES (120), (121);


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
VALUES (121,
        'pas legale',
        '2023-12-24');


INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_entreprise, id_equipage)
VALUES (120,
        'Duban',
        'Mathis',
        'Ecolier',
        '2023-05-20',
        121,
        6600);


INSERT INTO Chef_Entreprise (date_debut, date_fin,id_personne,id_entreprise)
VALUES ('2023-08-01',
        NULL,
        120,
        121);

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
VALUES (150,
        'Aegis Dynamics',
        '2023-01-01');


INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance)
VALUES (150,
        'Smith',
        'John',
        'Engineer',
        '1993-05-20');

-- Test trigger is_not_used_by_personne qui passe pas car utilisé par une personne
INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance) VALUES
    (111, 'Smith', 'John', 'Engineer', '1993-05-20');

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (111, 'Aegis Dynamics', '2023-01-01');


-- test trigger update_age insert sans age
INSERT INTO Personne(id_personne,nom,prenom,date_naissance) VALUES  (131, 'Smith', 'Howard','1993-05-20');

-- test trigger update_age insert avec age incorrect
INSERT INTO Personne(id_personne,nom,prenom,age,date_naissance) VALUES  (104, 'Smith', 'Ethan',1120,'1993-05-20');


-- TEST FONCTION


SELECT listFreeId();

CALL afficher_informations_equipage(1);
CALL afficher_informations_equipage(100);

--test fonction NombreObjetsIllegauxEntreprise, entreprise avec des objets illégaux
select NombreObjetsIllegauxEntreprise(22);

--test fonction NombreObjetsIllegauxEntreprise, entreprise sans objets illégaux
select NombreObjetsIllegauxEntreprise(21);


--test procedure afficher_informations_equipage_de_tous_les_vaisseaux
call afficher_informations_equipage_de_tous_les_vaisseaux();

--test procedure TransfertVaisseau
INSERT INTO Proprietaire (id_proprietaire) VALUES (75),(76);
INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES (75, 'torp cher','2023-04-12'),(76, 'merci','2023-07-04');
INSERT INTO Entreprise_Vaisseau (id_entreprise, specialite) VALUES (75,'Combat'),(76,'Industrial');
INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant) VALUES (42942, 'M2', 1000, 500, 30, 20, 75);
INSERT INTO Historique_Proprio (id_vaisseau, id_proprietaire, date_debut, date_fin) VALUES (42942, 75, '2023-01-01', NULL);

select * 
from Historique_Vente_Vaisseau
where id_vaisseau = 42942 AND id_entreprise=75 AND id_proprietaire=76 AND date_vente='2023-12-19';

call TransfertVaisseau(42942,75,76,'2023-12-19');

select * 
from Historique_Vente_Vaisseau
where id_vaisseau = 42942 AND id_entreprise=75 AND id_proprietaire=76 AND date_vente='2023-12-19';


--test procedure ecrat type
SELECT ecart_type_age_entreprise(11);

