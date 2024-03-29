--test trigger age chef entreprise
INSERT INTO Proprietaire (id_proprietaire) VALUES (100020), (100021);
INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant) VALUES (42000, 'Constellation', 1000, 500, 30, 20, 11);
INSERT INTO Equipage (id_equipage, nom, date_creation, id_vaisseau) VALUES (6600, 'Explorer Expedition Team 2', '2023-02-10', 42000);
INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES (100021, 'pas legale','2023-12-24');
INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_entreprise, id_equipage) VALUES (100020, 'Duban', 'Mathis', 'Ecolier', '2023-05-20', 100021, 6600);
INSERT INTO Chef_Entreprise (date_debut, date_fin,id_personne,id_entreprise) VALUES ('2023-08-01', NULL, 100020, 100021);


--test trigger masse inventaire vaisseau qui passe car moins de la moitier de la masse
INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant) VALUES (42042, 'VULTURE', 1000, 500, 30, 20, 14); --500 de masse kg
INSERT INTO Inventaire_Vaisseau (id_vaisseau, id_objet, quantite) VALUES(42042, 13, 1); --25 de masse g

--test trigger masse inventaire vaisseau qui passe pas car plus de la moitier de la masse
INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant) VALUES (42642, 'CORSAIR', 1000, 500, 30, 20, 14); --500 de masse kg
INSERT INTO Inventaire_Vaisseau (id_vaisseau, id_objet, quantite) VALUES(42642, 13, 15000); --25 de masse g, donc 25 * 15 = 375 g, donc * 1000 = 375 kg

--test trigger masse inventaire vaisseau qui passe pas car c'est la moitier pile de la masse
INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant) VALUES (42342, 'C1', 1000, 500, 30, 20, 14); --500 de masse kg
INSERT INTO Inventaire_Vaisseau (id_vaisseau, id_objet, quantite) VALUES(42342, 13, 10000); --25 de masse g, donc 25 * 10 = 250 g, donc * 1000 = 250 kg



--test procedure afficher_informations_equipage
call afficher_informations_equipage(6);

--test procedure afficher_informations_equipage_de_tous_les_vaisseaux
call afficher_informations_equipage_de_tous_les_vaisseaux();

--test fonction NombreObjetsIllegauxEntreprise, entreprise avec des objets illégaux
select NombreObjetsIllegauxEntreprise(22);

--test fonction NombreObjetsIllegauxEntreprise, entreprise sans objets illégaux
select NombreObjetsIllegauxEntreprise(21);

--test procedure TransfertVaisseau
INSERT INTO Proprietaire (id_proprietaire) VALUES (100113),(100114);
INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES (100113, 'torp cher','2023-04-12'),(100114, 'merci','2023-07-04');
INSERT INTO Entreprise_Vaisseau (id_entreprise, specialite) VALUES (100113,'Combat'),(100114,'Industrial');
INSERT INTO Vaisseau (id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant) VALUES (42942, 'M2', 1000, 500, 30, 20, 100113);
INSERT INTO Historique_Proprio (id_vaisseau, id_proprietaire, date_debut, date_fin) VALUES (42942, 100113, '2023-01-01', NULL);

select * 
from Historique_Vente_Vaisseau
where id_vaisseau = 42942 AND id_entreprise=100113 AND id_proprietaire=100114 AND date_vente='2023-12-19';

call TransfertVaisseau(42942,100113,100114,'2023-12-19');

select * 
from Historique_Vente_Vaisseau
where id_vaisseau = 42942 AND id_entreprise=100113 AND id_proprietaire=100114 AND date_vente='2023-12-19';

