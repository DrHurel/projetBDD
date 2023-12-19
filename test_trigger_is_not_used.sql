-- TEST FILE SHOULD NOT BE USED IN PROD DATABASE

-- MIN DATABASE TABLES REQUIRE

CREATE TABLE Proprietaire (
    id_proprietaire INT,
    CONSTRAINT PK_Proprietaire_id_proprietaire PRIMARY KEY(id_proprietaire)
);


CREATE TABLE Entreprise(
    id_entreprise INT,
    nom_entreprise VARCHAR(50) NOT NULL,
    data_creation DATE NOT NULL,
    CONSTRAINT FK_Entreprise_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Proprietaire(id_proprietaire) ON DELETE CASCADE,
    CONSTRAINT PK_Entreprise PRIMARY KEY(id_entreprise)
); 




CREATE TABLE Equipage (
    id_equipage INT,
    CONSTRAINT PK_Equipe_id_equipage PRIMARY KEY(id_equipage)
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
    CONSTRAINT FK_Personne_id_proprietaire FOREIGN KEY(id_personne) REFERENCES Proprietaire(id_proprietaire) ON DELETE CASCADE,
    CONSTRAINT PK_Personne PRIMARY KEY(id_personne),
    CONSTRAINT FK_Personne_id_Entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise) ON DELETE CASCADE,
    CONSTRAINT FK_Personne_id_equipage FOREIGN KEY(id_equipage) REFERENCES Equipage(id_equipage) ON DELETE CASCADE
);


-- TRIGGER TESTED 

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

CREATE OR REPLACE FUNCTION is_not_used_by_entreprise()
RETURNS TRIGGER AS $$

BEGIN
    IF NOT EXISTS (SELECT id_proprietaire FROM Proprietaire WHERE id_proprietaire=NEW.id_personne) THEN
        INSERT INTO Proprietaire (id_proprietaire) VALUES (NEW.id_personne);
        RETURN NEW;
    END IF;

    IF EXISTS (SELECT id_entreprise FROM Entreprise WHERE id_entreprise=NEW.id_personne) THEN
        RAISE NOTICE 'already an enterprise';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_is_not_used_by_entreprise
BEFORE INSERT OR UPDATE ON Personne
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_Entreprise();


BEGIN TRANSACTION;

-- TEST INSERT cas -> Pas d'id dans la table propriétaire

INSERT INTO Equipage (id_equipage) VALUES (1);

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (11, 'Aegis Dynamics', '2023-01-01');

INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance, id_equipage) VALUES
    (1, 'Smith', 'John', 'Engineer', '1993-05-20', 1);

SELECT * FROM Personne;
SELECT * FROM Entreprise;
SELECT * FROM Proprietaire;
ROLLBACK;




-- TEST INSERT cas -> Même id pour les 2 inserts
BEGIN;

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (1, 'Aegis Dynamics', '2023-01-01');

INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance) VALUES
    (1, 'Smith', 'John', 'Engineer', '1993-05-20');


SELECT * FROM Personne;
SELECT * FROM Entreprise;
SELECT * FROM Proprietaire;

DELETE FROM Proprietaire WHERE id_proprietaire=1;

SELECT * FROM Personne;
SELECT * FROM Entreprise;
SELECT * FROM Proprietaire;
END;


-- TEST INSERT cas -> Même id pour les 2 inserts mais ordre inverse
BEGIN;

INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance) VALUES
    (1, 'Smith', 'John', 'Engineer', '1993-05-20');

INSERT INTO Entreprise (id_entreprise, nom_entreprise, data_creation) VALUES
    (1, 'Aegis Dynamics', '2023-01-01');
SELECT * FROM Personne;
SELECT * FROM Entreprise;
SELECT * FROM Proprietaire;
DELETE FROM Proprietaire WHERE id_proprietaire=1;
SELECT * FROM Personne;
SELECT * FROM Entreprise;
SELECT * FROM Proprietaire;
END;

-- TEST INSERT cas -> insert with existing id
BEGIN;
INSERT INTO Proprietaire (id_proprietaire) VALUES (1);
INSERT INTO Personne (id_personne, nom, prenom, poste, date_naissance) VALUES
    (1, 'Smith', 'John', 'Engineer', '1993-05-20');
SELECT * FROM Personne;
SELECT * FROM Entreprise;
SELECT * FROM Proprietaire;

DELETE FROM Proprietaire WHERE id_proprietaire=1;

SELECT * FROM Personne;
SELECT * FROM Entreprise;
SELECT * FROM Proprietaire;
END;
