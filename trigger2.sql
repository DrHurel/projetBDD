CREATE OR REPLACE FUNCTION update_age()
RETURNS TRIGGER AS $$
DECLARE
    age_result INTEGER;
    
    annee_current INTEGER;
    mois_current INTEGER;
    jour_current INTEGER;
    
BEGIN
    SELECT YEAR(CURRENT_DATE),MONTH(CURRENT_DATE),DAY(CURRENT_DATE) INTO annee_current,mois_current,jour_current;
    
    age_result := annee_current-YEAR(NEW.date_naissance);
    IF mois_current> MONTH(NEW.date_naissance) THEN
        NEW.age := age_result -1;
        RETURN NEW;
    END IF;

    IF mois_current== MONTH(NEW.date_naissance) AND jour_current> DAY(NEW.date_naissance) THEN
        NEW.age := age_result -1;
        RETURN NEW;
    END IF;
    
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE TRIGGER trigger_update_age
BEFORE INSERT OR UPDATE ON Personne
FOR EACH ROW
EXECUTE FUNCTION update_age();
