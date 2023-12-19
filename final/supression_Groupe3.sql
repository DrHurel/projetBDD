DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP TRIGGER IF EXISTS trigger_vaisseau_check_masse_objet ON Inventaire_Vaisseau';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Trigger trigger_vaisseau_check_masse_objet does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP TRIGGER IF EXISTS trigger_check_chef_entreprise_majeur_insert ON Chef_Entreprise';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Trigger trigger_check_chef_entreprise_majeur_insert does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP TRIGGER IF EXISTS trigger_update_age ON Personne';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Trigger trigger_update_age does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP TRIGGER IF EXISTS trigger_is_not_used_by_personne ON Entreprise';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Trigger trigger_is_not_used_by_personne does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP TRIGGER IF EXISTS trigger_is_not_used_by_entreprise ON Personne';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Trigger trigger_is_not_used_by_entreprise does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP TRIGGER IF EXISTS trigger_is_not_used_by_entreprise_objet ON Entreprise_Vaisseau';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Trigger trigger_is_not_used_by_entreprise_objet does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP TRIGGER IF EXISTS trigger_is_not_used_by_entreprise_vaisseau ON Entreprise_Objet';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Trigger trigger_is_not_used_by_entreprise_vaisseau does not exist';
    END;
END $$;

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

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS check_masse()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function check_masse does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS check_chef_entreprise_majeur()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function check_chef_entreprise_majeur does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS update_age()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function update_age does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS is_not_used_by_personne()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function is_not_used_by_personne does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS is_not_used_by_entreprise()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function is_not_used_by_entreprise does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS is_not_used_by_entrepise_objet()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function is_not_used_by_entrepise_objet does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS is_not_used_by_entreprise_vaisseau()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function is_not_used_by_entreprise_vaisseau does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS NombreObjetsIllegauxEntreprise (IN INT)';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function NombreObjetsIllegauxEntreprise does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS listFreeId()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function listFreeId does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP FUNCTION IF EXISTS ecart_type_age_entreprise(IN INT)';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Function ecart_type_age_entreprise does not exist';
    END;
END $$;


DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP PROCEDURE IF EXISTS afficher_informations_equipage(IN INT)';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Procedure afficher_informations_equipage does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP PROCEDURE IF EXISTS afficher_informations_equipage_de_tous_les_vaisseaux()';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Procedure afficher_informations_equipage_de_tous_les_vaisseaux does not exist';
    END;
END $$;

DO $$
BEGIN 
    BEGIN
        EXECUTE 'DROP PROCEDURE IF EXISTS TransfertVaisseau(IN INT, IN INT, IN INT, IN DATE)';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN 
            RAISE NOTICE 'Procedure TransfertVaisseau does not exist';
    END;
END $$;