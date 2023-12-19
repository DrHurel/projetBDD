DROP TRIGGER IF EXISTS trigger_vaisseau_check_masse_objet ON Inventaire_Vaisseau;


DROP TRIGGER IF EXISTS trigger_check_chef_entreprise_majeur_insert ON Chef_Entreprise;


DROP TRIGGER IF EXISTS trigger_update_age ON Personne;


DROP TRIGGER IF EXISTS trigger_is_not_used_by_personne ON Entreprise;


DROP TRIGGER IF EXISTS trigger_is_not_used_by_entreprise ON Personne;


DROP TRIGGER IF EXISTS trigger_is_not_used_by_entreprise_objet ON Entreprise_Vaisseau;


DROP TRIGGER IF EXISTS trigger_is_not_used_by_entreprise_vaisseau ON Entreprise_Objet;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Historique_Vente_Vaisseau';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Historique_Vente_Vaisseau does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Historique_Proprio';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Historique_Proprio does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Inventaire_Vaisseau';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Inventaire_Vaisseau does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Gamme_Vente_Objet';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Gamme_Vente_Objet does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Chef_Entreprise';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Chef_Entreprise does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Personne';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Personne does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Equipage';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Equipage does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Vaisseau';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Vaisseau does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Entreprise_Objet';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Entreprise_Objet does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Entreprise_Vaisseau';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Entreprise_Vaisseau does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Entreprise';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Entreprise does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Modele_Objet';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Modele_Objet does not exist';
    END;
END $$;

DO $$
BEGIN
    BEGIN
        EXECUTE 'DROP TABLE Proprietaire';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Proprietaire does not exist';
    END;
END $$;


DROP FUNCTION IF EXISTS check_masse();

DROP FUNCTION IF EXISTS check_chef_entreprise_majeur();

DROP FUNCTION IF EXISTS update_age();


DROP FUNCTION IF EXISTS is_not_used_by_personne();


DROP FUNCTION IF EXISTS is_not_used_by_entreprise();


DROP FUNCTION IF EXISTS is_not_used_by_entrepise_objet();


DROP FUNCTION IF EXISTS is_not_used_by_entreprise_vaisseau();


DROP PROCEDURE IF EXISTS afficher_informations_equipage(IN INT);


DROP PROCEDURE IF EXISTS afficher_informations_equipage_de_tous_les_vaisseaux();


DROP FUNCTION IF EXISTS NombreObjetsIllegauxEntreprise (IN INT);


DROP PROCEDURE IF EXISTS TransfertVaisseau(IN INT, IN INT, IN INT, IN DATE);


DROP FUNCTION IF EXISTS calculer_prix_total_objets_entreprise(IN INT);


DROP FUNCTION IF EXISTS listFreeId();