-- TEST FILE SHOULD NOT BE USED IN PROD DATABASE

-- MIN TABLES REQUIRE

CREATE TABLE Proprietaire (
    id_proprietaire INT,
    CONSTRAINT PK_Proprietaire_id_proprietaire PRIMARY KEY(id_proprietaire)
);


CREATE TABLE Equipage (
    id_equipage INT,
    CONSTRAINT PK_Equipe_id_equipage PRIMARY KEY(id_equipage)
);

CREATE TABLE Entreprise(
    id_entreprise INT,
    CONSTRAINT PK_Entreprise PRIMARY KEY(id_entreprise)
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

-- TRIGGER TESTED 

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

CREATE OR REPLACE TRIGGER trigger_update_age
BEFORE INSERT OR UPDATE ON Personne
FOR EACH ROW
EXECUTE FUNCTION update_age();

-- TEST

BEGIN TRANSACTION; --insert sans age

INSERT INTO Proprietaire (id_proprietaire) VALUES (1);

INSERT INTO Personne(id_personne,nom,prenom,date_naissance) VALUES  (1, 'Smith', 'John','1993-05-20');
SELECT id_personne,age,date_naissance FROM Personne;

ROLLBACK;

BEGIN TRANSACTION; --insert avec mauvais age

INSERT INTO Proprietaire (id_proprietaire) VALUES (1);

INSERT INTO Personne(id_personne,nom,prenom,age,date_naissance) VALUES  (1, 'Smith', 'John',1120,'1993-05-20');
SELECT id_personne,age,date_naissance FROM Personne;

ROLLBACK;