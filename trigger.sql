CREATE OR REPLACE FUNCTION check_masse()
RETURNS TRIGGER AS $$
DECLARE
    masse_objet integer := 0;
    masse_inventaire integer := 0;
    masse_vaisseau integer := 0;
BEGIN
    SELECT SUM(iv.quantite * md.masse) INTO masse_inventaire
    FROM Inventaire_Vaisseau iv
    JOIN Modele_Objet md ON md.id_objet = iv.id_objet
    WHERE iv.id_vaisseau = NEW.id_vaisseau AND iv.id_objet <> NEW.id_objet;

    SELECT masse INTO masse_objet
    FROM Modele_Objet
    WHERE id_objet = NEW.id_objet;

    SELECT masse INTO masse_vaisseau
    FROM Vaisseau
    WHERE id_vaisseau = NEW.id_vaisseau;

    IF ((masse_inventaire + (NEW.quantite * masse_objet)) >= (masse_vaisseau / 2) * 1000) THEN
        RAISE NOTICE 'masse inventaire overcharge';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur
CREATE TRIGGER trigger_vaisseau_check_masse_objet
AFTER INSERT OR UPDATE ON Inventaire_Vaisseau
FOR EACH ROW
EXECUTE FUNCTION check_masse();
