CREATE OR REPLACE FUNCTION is_not_used_by_personne()
RETURNS TRIGGER AS $$

BEGIN
    
    IF EXISTS (SELECT id_personne FROM Personne WHERE id_personne=NEW.id_entreprise) THEN
        RAISE NOTICE 'already a personne';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE OR REPLACE TRIGGER trigger_is_not_used_by_personne
AFTER INSERT OR UPDATE ON Entreprise
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_personne();

CREATE OR REPLACE FUNCTION is_not_used_by_entreprise()
RETURNS TRIGGER AS $$

BEGIN


    IF EXISTS (SELECT id_entreprise FROM Entreprise WHERE id_entreprise=NEW.id_personne) THEN
        RAISE NOTICE 'already a vaisseau';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE OR REPLACE TRIGGER trigger_is_not_used_by_vaisseau
AFTER INSERT OR UPDATE ON Personne
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_Entreprise();
