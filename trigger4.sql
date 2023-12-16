CREATE OR REPLACE FUNCTION is_not_used_by_entrepise_objet()
RETURNS TRIGGER AS $$

BEGIN
    IF NOT EXISTS (SELECT id_entreprise FROM Entreprise WHERE id_entreprise=NEW.id_entreprise) THEN
        INSERT INTO Entreprise (id_entreprise) VALUES (NEW.id_entreprise);
        RETURN NEW;
    END IF;

    IF EXISTS (SELECT id_entreprise FROM Entreprise_Objet WHERE id_entreprise=NEW.id_entreprise) THEN
        RAISE NOTICE 'already a Entreprise Objet';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE OR REPLACE TRIGGER trigger_is_not_used_by_entreprise_objet
BEFORE INSERT OR UPDATE ON Entreprise_Vaisseau
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_entrepise_objet();

CREATE OR REPLACE FUNCTION is_not_used_by_entreprise_vaisseau()
RETURNS TRIGGER AS $$

BEGIN
    IF NOT EXISTS (SELECT id_entreprise FROM Entreprise WHERE id_entreprise=NEW.id_entreprise) THEN
        INSERT INTO Entreprise (id_entreprise) VALUES (NEW.id_entreprise);
        RETURN NEW;
    END IF;

    IF EXISTS (SELECT id_entreprise FROM Entreprise_Vaisseau WHERE id_entreprise=NEW.id_entreprise) THEN
        RAISE NOTICE 'already a enterprise vaisseau';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE OR REPLACE TRIGGER trigger_is_not_used_by_entreprise_vaisseau
BEFORE INSERT OR UPDATE ON Entreprise_Objet
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_entreprise_vaisseau();
