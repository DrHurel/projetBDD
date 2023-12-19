CREATE OR REPLACE FUNCTION check_masse()
RETURNS TRIGGER AS $$
DECLARE
    masse_objet integer := 0;
    masse_inventaire integer := 0;
    masse_vaisseau integer := 0;
    total_masse_inventaire integer := 0;
    val_tuple RECORD;
BEGIN
    --calcule de la masse déja présent dans l'inventaire avant l'ajout
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

    --attention la masse des vaisseaux est en kg alors que les objets sont en g
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

-- Création du trigger pour INSERT
CREATE TRIGGER trigger_check_chef_entreprise_majeur_insert
BEFORE INSERT OR UPDATE ON Chef_Entreprise
FOR EACH ROW
EXECUTE FUNCTION check_chef_entreprise_majeur();
