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
