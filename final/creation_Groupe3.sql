/*
Duban Mathis [ 2210226 ]
Bernardon Vincent [ 22009116 ]
Hurel Jérémy [ 21907809 ]
*/

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
    CONSTRAINT FK_Entreprise_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Proprietaire(id_proprietaire) ON DELETE CASCADE,
    CONSTRAINT PK_Entreprise PRIMARY KEY(id_entreprise)
); 

CREATE TABLE Entreprise_Vaisseau(
    id_entreprise INT,
    specialite VARCHAR(50) NOT NULL,
    CONSTRAINT Specialite_Entreprise_Vaisseau CHECK(specialite IN ('Combat','Transport','Exploration','Industrial','Support','Competition','Ground','Multi')),
    CONSTRAINT FK_Entreprise_Vaisseau_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise) ON DELETE CASCADE,
    CONSTRAINT PK_Entreprise_Vaisseau PRIMARY KEY(id_entreprise)
);

CREATE TABLE Entreprise_Objet(
    id_entreprise INT,
    categorie VARCHAR(50),
    CONSTRAINT FK_Entreprise_Objet_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise) ON DELETE CASCADE,
    CONSTRAINT PK_Entreprise_Objet PRIMARY KEY(id_entreprise)
);

CREATE TABLE Vaisseau(
    id_vaisseau INT,
    nom VARCHAR(50),
    prix INT NOT NULL,
    masse INT NOT NULL,
    longueur INT NOT NULL,
    largeur INT NOT NULL,
    id_fabriquant INT NOT NULL,
    CONSTRAINT PK_Vaisseau PRIMARY KEY(id_vaisseau),
    CONSTRAINT FK_Vaisseau_id_fabriquant FOREIGN KEY(id_fabriquant) REFERENCES Entreprise_Vaisseau(id_entreprise) ON DELETE CASCADE
);


CREATE TABLE Equipage (
    id_equipage INT,
    nom VARCHAR(50) NOT NULL,
    date_creation DATE NOT NULL,
    id_vaisseau INT NOT NULL,
    CONSTRAINT PK_Equipe_id_equipage PRIMARY KEY(id_equipage),
    CONSTRAINT FK_Equipage_id_entreprise FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau) ON DELETE CASCADE
);

CREATE TABLE Personne(
    id_personne INT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    poste VARCHAR(15),
    age INT,
    date_naissance DATE NOT NULL,
    id_entreprise INT,
    id_equipage INT,
    CONSTRAINT FK_Personne_id_proprietaire FOREIGN KEY(id_personne) REFERENCES Proprietaire(id_proprietaire) ON DELETE CASCADE,
    CONSTRAINT PK_Personne PRIMARY KEY(id_personne),
    CONSTRAINT FK_Personne_id_Entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise) ON DELETE CASCADE,
    CONSTRAINT FK_Personne_id_equipage FOREIGN KEY(id_equipage) REFERENCES Equipage(id_equipage) ON DELETE CASCADE
);
    

CREATE TABLE Chef_Entreprise(
    date_debut DATE NOT NULL,
    date_fin DATE,
    id_entreprise INT NOT NULL,
    id_personne INT NOT NULL,
    CONSTRAINT FK_Chef_Entreprise_id_personne FOREIGN KEY (id_personne) REFERENCES Personne(id_personne) ON DELETE CASCADE,
    CONSTRAINT FK_Chef_Entreprise_ID_Entreprise FOREIGN KEY (id_entreprise) REFERENCES Entreprise(id_entreprise) ON DELETE CASCADE,
    CONSTRAINT PK_Chef_Entreprise PRIMARY KEY(id_entreprise,id_personne,date_debut)   
);

CREATE TABLE Gamme_Vente_Objet(
    id_fabriquant INT,
    id_objet INT,
    CONSTRAINT FK_Gamme_Vente_Objet_id_fabriquant FOREIGN KEY(id_fabriquant) REFERENCES Entreprise_Objet(id_entreprise) ON DELETE CASCADE,
    CONSTRAINT FK_Gamme_Vente_Objet_id_objet FOREIGN KEY(id_objet) REFERENCES Modele_Objet(id_objet) ON DELETE CASCADE,
    CONSTRAINT PK_Gamme_Vente_Objet PRIMARY KEY(id_objet,id_fabriquant)   
);

CREATE TABLE Inventaire_Vaisseau(
    id_vaisseau INT,
    id_objet INT,
    quantite INT,
    CONSTRAINT FK_Inventaire_Vaisseau_id_objet FOREIGN KEY(id_objet) REFERENCES Modele_Objet(id_objet) ON DELETE CASCADE,
    CONSTRAINT FK_Inventaire_Vaisseau_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau)ON DELETE CASCADE,
    CONSTRAINT PK_Inventaire_Vaisseau PRIMARY KEY(id_objet,id_vaisseau),
    CONSTRAINT Valeur_Quantite CHECK(quantite>0)
); 

CREATE TABLE Historique_Proprio(
    id_vaisseau INT,
    id_proprietaire INT,
    date_debut DATE,
    date_fin DATE,
    CONSTRAINT PK_Historique_Proprio PRIMARY KEY(date_debut,id_proprietaire,id_vaisseau),
    CONSTRAINT FK_Historique_Proprio_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau) ON DELETE CASCADE,
    CONSTRAINT FK_Historique_Proprio_id_proprietaire FOREIGN KEY(id_proprietaire) REFERENCES Proprietaire(id_proprietaire) ON DELETE CASCADE
);

CREATE TABLE Historique_Vente_Vaisseau(
    id_vaisseau INT,
    id_entreprise INT,
    id_proprietaire INT,
    date_vente DATE,
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau) ON DELETE CASCADE,
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_proprietaire FOREIGN KEY(id_proprietaire) REFERENCES Proprietaire(id_proprietaire) ON DELETE CASCADE,
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise_Vaisseau(id_entreprise) ON DELETE CASCADE,
    CONSTRAINT PK_Historique_Vente_Vaisseau PRIMARY KEY(id_vaisseau,id_entreprise,id_proprietaire,date_vente)
);

-- TRIGGERS


-- CHECK MASSE INVENTAIRE/2 < MASSE VAISSEAU
CREATE OR REPLACE FUNCTION check_masse()
RETURNS TRIGGER AS $$
DECLARE
    masse_objet integer := 0;
    masse_inventaire integer := 0;
    masse_vaisseau integer := 0;
    total_masse_inventaire integer := 0;
    val_tuple RECORD;
BEGIN
    
    FOR val_tuple IN
        SELECT iv.quantite, md.masse
        FROM Inventaire_Vaisseau iv
        JOIN Modele_Objet md ON md.id_objet = iv.id_objet
        WHERE iv.id_vaisseau = NEW.id_vaisseau AND iv.id_objet <> NEW.id_objet
    LOOP
        total_masse_inventaire := total_masse_inventaire + (val_tuple.quantite * val_tuple.masse);
    END LOOP;


    SELECT masse INTO masse_objet
    FROM Modele_Objet
    WHERE id_objet = NEW.id_objet;

    SELECT masse INTO masse_vaisseau
    FROM Vaisseau
    WHERE id_vaisseau = NEW.id_vaisseau;


    masse_inventaire := total_masse_inventaire;
    --l'unité de la masse des objets étant en g et la masse des vaisseaux étant en Kg , nous devons multiplier par 1000
    IF ((masse_inventaire + (NEW.quantite * masse_objet)) >= (masse_vaisseau / 2) * 1000) THEN
        RAISE EXCEPTION 'masse inventaire overcharge';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_vaisseau_check_masse_objet
AFTER INSERT OR UPDATE ON Inventaire_Vaisseau
FOR EACH ROW
EXECUTE FUNCTION check_masse();

-- CHECK age futur chef entreprise > 18
CREATE OR REPLACE FUNCTION check_chef_entreprise_majeur()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.date_debut IS NOT NULL THEN
        IF (SELECT age FROM Personne WHERE id_personne = NEW.id_personne) < 18 THEN
            RAISE EXCEPTION 'Le chef d''entreprise doit être une personne majeure';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_check_chef_entreprise_majeur_insert
BEFORE INSERT OR UPDATE ON Chef_Entreprise
FOR EACH ROW
EXECUTE FUNCTION check_chef_entreprise_majeur();


-- Met à jour la valeur de l'age d'une personne lors de l'insert (doit être couplet à une tache cron pour garder cette valeur à jour)
CREATE OR REPLACE FUNCTION update_age()
RETURNS TRIGGER AS $$
DECLARE
    age_result INTEGER;
    
    annee_current INTEGER;
    mois_current INTEGER;
    jour_current INTEGER;
    
BEGIN
    SELECT EXTRACT(YEAR FROM CURRENT_DATE),EXTRACT(MONTH FROM CURRENT_DATE),EXTRACT(DAY FROM CURRENT_DATE) INTO annee_current,mois_current,jour_current;
    
    age_result := annee_current- EXTRACT(YEAR FROM NEW.date_naissance);
    IF mois_current> EXTRACT(MONTH FROM NEW.date_naissance) THEN
        NEW.age := age_result -1;
        RETURN NEW;
    END IF;

    IF mois_current= EXTRACT(MONTH FROM NEW.date_naissance)  AND jour_current> EXTRACT(DAY FROM NEW.date_naissance) THEN
        NEW.age := age_result -1;
        RETURN NEW;
    END IF;

    RETURN NEW;
    
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE OR REPLACE TRIGGER trigger_update_age
BEFORE INSERT OR UPDATE ON Personne
FOR EACH ROW
EXECUTE FUNCTION update_age();



-- Garanti qu'un id propiétaire ne peux pas être utilisé à la fois par une personne et une entreprise et en ajoute un si pas éxistant à l'origine
CREATE OR REPLACE FUNCTION is_not_used_by_personne()
RETURNS TRIGGER AS $$

BEGIN
    IF NOT EXISTS (SELECT id_proprietaire FROM Proprietaire WHERE id_proprietaire=NEW.id_entreprise) THEN
        INSERT INTO Proprietaire (id_proprietaire) VALUES (NEW.id_entreprise);
        RETURN NEW;
    END IF;

    IF EXISTS (SELECT id_personne FROM Personne WHERE id_personne=NEW.id_entreprise) THEN
        RAISE NOTICE 'already a personne';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_is_not_used_by_personne
BEFORE INSERT OR UPDATE ON Entreprise
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_personne();


-- Garanti qu'un id propiétaire ne peux pas être utilisé à la fois par une entreprise et une personne et en ajoute un si pas éxistant à l'origine
CREATE OR REPLACE FUNCTION is_not_used_by_entreprise()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT id_proprietaire FROM Proprietaire WHERE id_proprietaire=NEW.id_personne) THEN
        INSERT INTO Proprietaire (id_proprietaire) VALUES (NEW.id_personne);
        RETURN NEW;
    END IF;

    IF EXISTS (SELECT id_entreprise FROM Entreprise WHERE id_entreprise=NEW.id_personne) THEN
        RAISE NOTICE 'already a enterprise';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_is_not_used_by_entreprise
BEFORE INSERT OR UPDATE ON Personne
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_Entreprise();

-- Garanti qu'un id propiétaire ne peux pas être utilisé à la fois par une entreprise_objet et une entreprise_vaisseau
CREATE OR REPLACE FUNCTION is_not_used_by_entrepise_objet()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT id_entreprise FROM Entreprise_Objet WHERE id_entreprise=NEW.id_entreprise) THEN
        RAISE NOTICE 'already a Entreprise Objet';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_is_not_used_by_entreprise_objet
BEFORE INSERT OR UPDATE ON Entreprise_Vaisseau
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_entrepise_objet();


-- Garanti qu'un id propiétaire ne peux pas être utilisé à la fois par une entreprise_objet et une entreprise_vaisseau
CREATE OR REPLACE FUNCTION is_not_used_by_entreprise_vaisseau()
RETURNS TRIGGER AS $$

BEGIN

    IF EXISTS (SELECT id_entreprise FROM Entreprise_Vaisseau WHERE id_entreprise=NEW.id_entreprise) THEN
        RAISE NOTICE 'already a enterprise vaisseau';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_is_not_used_by_entreprise_vaisseau
BEFORE INSERT OR UPDATE ON Entreprise_Objet
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_entreprise_vaisseau();




-- FONCTION et PROCEDURE 

-- Met en forme les information d'un equipage en fonction du vaisseau associé
CREATE OR REPLACE PROCEDURE afficher_informations_equipage(IN vaisseau_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    equipage_id INT;
    personne_info RECORD;
BEGIN

    SELECT id_equipage INTO equipage_id
    FROM Equipage
    WHERE id_vaisseau = vaisseau_id;

    
    IF equipage_id IS NOT NULL THEN
    
        RAISE NOTICE '+----------------------------Equipage---------------------------------+';
        RAISE NOTICE '+------+-------------+----------+-----------+------+------------------+';
        RAISE NOTICE '| ID   | Nom         | Prénom   | Poste     | Âge  | Date de naissance|';
        RAISE NOTICE '+------+-------------+----------+-----------+------+------------------+';
        FOR personne_info IN
            SELECT id_personne, nom, prenom, poste, age, date_naissance
            FROM Personne
            WHERE id_equipage = equipage_id
        LOOP
            RAISE NOTICE '| % | % | % | % | % | % |',
                lpad(personne_info.id_personne::text, 4, ' '),
                lpad(personne_info.nom, 12, ' '),
                lpad(personne_info.prenom, 9, ' '),
                lpad(personne_info.poste, 10, ' '),
                lpad(personne_info.age::text, 4, ' '),
                personne_info.date_naissance;
        END LOOP;
        RAISE NOTICE '+------+-------------+----------+-----------+------+------------------+';
        RAISE NOTICE ' ';
        RAISE NOTICE ' ';
        RAISE NOTICE ' ';

    ELSE
        RAISE NOTICE 'Ce vaisseau n''est associé à aucun équipage.';
        RAISE NOTICE ' ';
        RAISE NOTICE ' ';
        RAISE NOTICE ' ';

    END IF;
END;
$$;


-- Met en forme les information de tout les équipages associé à un vaisseau
CREATE OR REPLACE PROCEDURE afficher_informations_equipage_de_tous_les_vaisseaux()
LANGUAGE plpgsql
AS $$
DECLARE
    vaisseaux_info RECORD;
    equipage_bool BOOLEAN := FALSE;
BEGIN
    FOR vaisseaux_info IN
        SELECT id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant
        FROM Vaisseau
    LOOP
        SELECT TRUE INTO equipage_bool 
        FROM equipage 
        WHERE id_vaisseau=vaisseaux_info.id_vaisseau;
        RAISE NOTICE '+----------------------------Vaisseau---------------------------------+';
        RAISE NOTICE '+--------------------------%-----------------------------+',
            lpad(vaisseaux_info.nom, 14, ' ');
        IF equipage_bool THEN
            RAISE NOTICE '+------+-------------+----------+-----------+---------+---------------+';
            RAISE NOTICE '| ID   | Prix        | Masse    | Longueur  | Largeur | ID_fabriquant |';
            RAISE NOTICE '+------+-------------+----------+-----------+---------+---------------+';
            RAISE NOTICE '| % | % | % | % | % | % |',
                lpad(vaisseaux_info.id_vaisseau::text, 4, ' '),
                lpad(vaisseaux_info.prix::text, 10, ' '),
                lpad(vaisseaux_info.masse::text, 7, ' '),
                lpad(vaisseaux_info.longueur::text, 8, ' '),
                lpad(vaisseaux_info.largeur::text, 6, ' '),
                lpad(vaisseaux_info.id_fabriquant::text, 12, ' ');
            CALL afficher_informations_equipage(vaisseaux_info.id_vaisseau);
        ELSE
            RAISE NOTICE '|                  Aucun équipage pour ce vaisseau                   |';
        END IF;
    END LOOP;
    RAISE NOTICE '+------+-------------+----------+-----------+--------+----------------+';
END;
$$;




-- Donne le nombre de model d'objet illégaux vendu par une entreprise
CREATE OR REPLACE FUNCTION NombreObjetsIllegauxEntreprise (entreprise_id INT) 
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE 
    nb_objet INT := 0;
BEGIN
    SELECT COUNT(*) INTO nb_objet
    FROM Modele_Objet mo
    INNER JOIN Gamme_Vente_Objet gvo ON mo.id_objet = gvo.id_objet
    WHERE mo.statut = 'ILLEGAL' AND gvo.id_fabriquant = entreprise_id;
    /*RAISE NOTICE '| % |',
        lpad(nb_objet::text, 4, ' ');*/
    RETURN nb_objet;
END;
$$;



--Procédure pour transférer un vaisseau d'un propriétaire à un autre.
CREATE OR REPLACE PROCEDURE TransfertVaisseau(IN vaisseau_idD INT,IN source_id INT,IN destination_id INT,IN date_transfer DATE)
LANGUAGE plpgsql
AS $$
DECLARE
    checkIfProprio RECORD;
    ok BOOLEAN := TRUE;
BEGIN
   
    FOR checkIfProprio IN SELECT * FROM Historique_Proprio WHERE id_vaisseau=vaisseau_idD AND id_proprietaire=source_id AND date_fin IS NULL
    LOOP
        IF ok THEN
            UPDATE Historique_Proprio SET date_fin = date_transfer WHERE id_vaisseau = vaisseau_idD AND date_fin IS NULL;
            INSERT 
            INTO 
            Historique_Proprio (id_vaisseau, id_proprietaire, date_debut) 
            VALUES (vaisseau_idD, destination_id, date_transfer);
            ok := FALSE;
        ELSE
            RETURN;
        END IF;
    END LOOP;
END;
$$;


-- Retourne l'écart type de l'age des employé d'une entreprise.
CREATE OR REPLACE FUNCTION ecart_type_age_entreprise(IN entreprise_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    age_employer INT;
    count INT := 0;
    mean_age INT;
    sum INT := 0;
BEGIN
    SELECT AVG(age) INTO mean_age FROM Personne WHERE id_entreprise= entreprise_id GROUP BY id_entreprise;

    FOR age_employer IN 
        SELECT age  FROM Personne WHERE id_entreprise= entreprise_id
    LOOP
        count := count+1;
        sum := sum + (mean_age - age_employer)*(mean_age - age_employer);

    END LOOP;

    IF count=0 THEN 
        RAISE NOTICE 'pas d employé dans cette entreprise';
    
    ELSE
        RETURN SQRT(sum/count);
    END IF;
END;
$$;


-- Retourne la liste de tout les id libre pour identifié un propriétaire entre l'id min et l'id max
CREATE OR REPLACE FUNCTION listFreeId() 
RETURNS SETOF INTEGER
LANGUAGE plpgsql
AS $$
DECLARE 
    current_id INT := 0;
    pres_id INT := 0;
    id_proprietaire INT;
BEGIN
    FOR id_proprietaire IN 
        SELECT * 
        FROM Proprietaire 
        ORDER BY id_proprietaire
    LOOP
        current_id := id_proprietaire;

        IF NOT EXISTS (SELECT id_personne FROM Personne WHERE id_personne=current_id) 
            AND 
            NOT EXISTS (SELECT id_entreprise FROM Entreprise WHERE id_entreprise=current_id) 
        THEN
            RETURN NEXT current_id;
        END IF;

        WHILE (current_id - pres_id) > 1 LOOP
            pres_id := pres_id +1;
            RETURN NEXT pres_id;
        END LOOP;
        pres_id := current_id;
    END LOOP;
    RETURN;
END;
$$;

-- INSERT 


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
    (23, 'Snappy Food', '2023-12-20'),
    (24, 'ArcCorp', '2024-01-25'),
    (25, 'Aopoa', '2024-03-10'),
    (26, 'IllegalCorp','2024-08-11'),
    (27, 'CNOU (Consolidated Navy of United)', '2024-09-05'),
    (28, 'Banu Souli', '2024-10-18'),
    (29, 'Tumbril Land Systems', '2024-11-30'),
    (30, 'Xi An Aerospace', '2024-12-15');





-- Insert into Entreprise_Vaisseau table
INSERT INTO Entreprise_Vaisseau (id_entreprise, specialite) VALUES
    (11,'Combat'), (12,'Transport'), (13,'Exploration'), (14,'Industrial'), (15,'Support'), (16,'Competition'), (17,'Ground'), (18,'Multi'), (19,'Exploration'), (20,'Transport');

-- Insert into Entreprise_Objet table
INSERT INTO Entreprise_Objet (id_entreprise) VALUES
    (21), (22), (23), (24), (25) , (26);

-- Insert into Entreprise_Objet table
INSERT INTO Entreprise_Objet (id_entreprise,categorie) VALUES
    (27,'PNJ'), (28,'PNJ'), (29,'JOUEUR'), (30,'PNJ');


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
(10, 'Pioneer', 3500, 1400, 75, 65, 20),
(11, 'Black Market Ship', 5000, 1500, 80, 60, 12);


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
(21, 1),
(21, 3),
(21, 5),
(21, 7),
(21, 9),
(22, 2),
(22, 4),
(22, 6),
(22, 8),
(22, 10),
(23, 3),
(23, 1),
(23, 2),
(24, 4),
(24, 1),
(25, 5),
(26, 2),
(26, 4), 
(26, 6), 
(26, 8),
(26, 10);


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
(10, 10, 95),
(11, 2, 100),  
(11, 4, 80),   
(11, 6, 150), 
(11, 8, 100), 
(11, 10, 95);  


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


-- REQUEST
SELECT id_entreprise,Count(*) as Nombre_Employes  FROM Personne GROUP BY id_entreprise; -- Combien compte t-on d’employés pour chaque entreprise?

SELECT * FROM Vaisseau WHERE id_vaisseau NOT IN (SELECT id_vaisseau FROM Equipage GROUP BY id_vaisseau); -- Quels sont les vaisseaux n’ayant pas d'équipage ?


SELECT e.id_equipage,e.nom AS nom_equipage,AVG(EXTRACT(YEAR FROM age(p.date_naissance))) AS moyenne_age -- quelle est la moyenne d'âge des membres de chaque équipage?
FROM Equipage e
JOIN Personne p ON e.id_equipage = p.id_equipage
GROUP BY e.id_equipage, e.nom
ORDER BY moyenne_age DESC;




--Quels sont les vaisseaux ayant un prix supérieur à la moyenne des prix des autres vaisseaux?
SELECT *
FROM Vaisseau
WHERE prix > (
    SELECT AVG(prix)
    FROM Vaisseau
);

-- Quels sont les vaisseaux qui ne possèdent que des objets illégaux dans leur inventaire?
SELECT id_vaisseau, nom
FROM Vaisseau
WHERE id_vaisseau NOT IN (
    SELECT id_vaisseau
    FROM Inventaire_Vaisseau
    GROUP BY id_vaisseau
    HAVING COUNT(*) > 0
    AND COUNT(*) = (
        SELECT COUNT(*)
        FROM Inventaire_Vaisseau iv
        JOIN Modele_Objet mo ON iv.id_objet = mo.id_objet
        WHERE mo.statut = 'LEGAL'
        AND iv.id_vaisseau = Vaisseau.id_vaisseau
    )
);



--Quelles sont les entreprises dont le nombre de gammes d'objets proposés à la vente dépasse la moyenne du nombre de gammes d'objets proposés à la vente par les autres entreprises ?
SELECT id_entreprise, nom_entreprise
FROM Entreprise E1
WHERE (
    SELECT COUNT(*)
    FROM Gamme_Vente_Objet GVO
    WHERE GVO.id_fabriquant = E1.id_entreprise
) > (
    SELECT AVG(nombre_objets)
    FROM (
        SELECT COUNT(*) AS nombre_objets
        FROM Gamme_Vente_Objet
        GROUP BY id_fabriquant
    )
);

-- la somme des prix des objets vendu part une entreprise objet
SELECT COALESCE(SUM(mo.prix), 0) 
    FROM Entreprise_Objet eo 
    JOIN Gamme_Vente_Objet gvo on eo.id_entreprise = gvo.id_fabriquant
    JOIN Modele_Objet mo ON gvo.id_objet = mo.id_objet
    WHERE eo.id_entreprise = 22;