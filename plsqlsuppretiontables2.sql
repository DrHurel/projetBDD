prompt "Suppression des relations"

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
        EXECUTE 'DROP TABLE Vaisseau';
    EXCEPTION
        WHEN SQLSTATE '42P01' THEN
            RAISE NOTICE 'Table Vaisseau does not exist';
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