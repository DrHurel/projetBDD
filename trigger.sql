CREATE OR REPLACE FUNCTION tirgger_vaisseau_check_masse_objet(id_vaisseauD integer,id_objetD integer, quantiteD integer) RETURNS trigger AS $tirgger_vaisseau_check_masse_objet$
    DECLARE
        masse_objet integer := 0
        masse_inventaire integer := 0
        masse_vaisseau integer := 0

    BEGIN
        
        select SUM(iv.quantite*md.masse) INTO masse_inventaire
        from Inventaire_Vaisseau iv
        join Modele_Objet md on md.id_objet=iv.id_objet
        where iv.id_vaisseau=id_vaisseauD and iv.id_objet<>id_objetD;

        SELECT masse INTO masse_objet
        FROM Modele_Objet 
        where id_objet=id_objetD;

        select masse INTO masse_vaisseau 
        from Vaisseau 
        where id_vaisseau=id_vaisseauD;

        IF((masse_inventaire + (quantiteD * masse_objet))>=(masse_vaisseau/2)*1000) THEN
            RAISE NOTICE 'masse inventaire overcharge';
        END;
    END;
$tirgger_vaisseau_check_masse_objet$ 
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tirgger_vaisseau_check_masse_objet BEFORE INSERT OR UPDATE ON Inventaire_Vaisseau
    FOR EACH ROW EXECUTE FUNCTION tirgger_vaisseau_check_masse_objet(NEW.id_vaisseau, NEW.id_objet, NEW.quantite);