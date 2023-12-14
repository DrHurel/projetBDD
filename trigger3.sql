CREATE OR REPLACE FUNCTION is_not_used_by_personne()
RETURNS TRIGGER AS $$

BEGIN
    
    IF EXISTS  SELECT id FROM Personne WHERE id=NEW.id THEN
        RAISE NOTICE 'already a personne';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE TRIGGER trigger_is_not_used_by_personne
AFTER INSERT OR UPDATE ON Vaisseau
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_personne();

CREATE OR REPLACE FUNCTION is_not_used_by_vaisseau()
RETURNS TRIGGER AS $$

BEGIN


    IF EXISTS  SELECT id FROM Vaisseau WHERE id=NEW.id THEN
        RAISE NOTICE 'already a vaisseau';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE TRIGGER trigger_is_not_used_by_vaisseau
AFTER INSERT OR UPDATE ON Personne
FOR EACH ROW
EXECUTE FUNCTION is_not_used_by_vaisseau();
