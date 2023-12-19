CREATE OR REPLACE PROCEDURE afficher_informations_equipage(IN vaisseau_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    equipage_id INT;
    personne_info RECORD;
BEGIN

    SELECT id_equipage INTO equipage_id
    FROM Equipage
    WHERE id_vaisseau = vaisseau_id;

    
    IF equipage_id IS NOT NULL THEN
    
        RAISE NOTICE '+----------------------------Equipage---------------------------------+';
        RAISE NOTICE '+------+-------------+----------+-----------+------+------------------+';
        RAISE NOTICE '| ID   | Nom         | Prénom   | Poste     | Âge  | Date de naissance|';
        RAISE NOTICE '+------+-------------+----------+-----------+------+------------------+';
        FOR personne_info IN
            SELECT id_personne, nom, prenom, poste, age, date_naissance
            FROM Personne
            WHERE id_equipage = equipage_id
        LOOP
            RAISE NOTICE '| % | % | % | % | % | % |',
                lpad(personne_info.id_personne::text, 4, ' '),
                lpad(personne_info.nom, 12, ' '),
                lpad(personne_info.prenom, 9, ' '),
                lpad(personne_info.poste, 10, ' '),
                lpad(personne_info.age::text, 4, ' '),
                personne_info.date_naissance;
        END LOOP;
        RAISE NOTICE '+------+-------------+----------+-----------+------+------------------+';
        RAISE NOTICE ' ';
        RAISE NOTICE ' ';
        RAISE NOTICE ' ';

    ELSE
        RAISE NOTICE 'Ce vaisseau n''est associé à aucun équipage.';
        RAISE NOTICE ' ';
        RAISE NOTICE ' ';
        RAISE NOTICE ' ';

    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE afficher_informations_equipage_de_tous_les_vaisseaux()
LANGUAGE plpgsql
AS $$
DECLARE
    vaisseaux_info RECORD;
    equipage_bool BOOLEAN := FALSE;
BEGIN
    FOR vaisseaux_info IN
        SELECT id_vaisseau, nom, prix, masse, longueur, largeur, id_fabriquant
        FROM Vaisseau
    LOOP
        SELECT TRUE INTO equipage_bool 
        FROM equipage 
        WHERE id_vaisseau=vaisseaux_info.id_vaisseau;

        IF equipage_bool THEN
            RAISE NOTICE '+----------------------------Vaisseau---------------------------------+';
            RAISE NOTICE '+--------------------------%-----------------------------+',
                lpad(vaisseaux_info.nom, 10, ' ');
            RAISE NOTICE '+------+-------------+----------+-----------+---------+---------------+';
            RAISE NOTICE '| ID   | Prix        | Masse    | Longueur  | Largeur | ID_fabriquant |';
            RAISE NOTICE '+------+-------------+----------+-----------+---------+---------------+';
            RAISE NOTICE '| % | % | % | % | % | % |',
                lpad(vaisseaux_info.id_vaisseau::text, 4, ' '),
                lpad(vaisseaux_info.prix::text, 10, ' '),
                lpad(vaisseaux_info.masse::text, 7, ' '),
                lpad(vaisseaux_info.longueur::text, 8, ' '),
                lpad(vaisseaux_info.largeur::text, 6, ' '),
                lpad(vaisseaux_info.id_fabriquant::text, 12, ' ');
            CALL afficher_informations_equipage(vaisseaux_info.id_vaisseau);
        ELSE
            RAISE NOTICE '|Aucun équipage pour ce vaisseau|';
        END IF;
    END LOOP;
    RAISE NOTICE '+------+-------------+----------+-----------+--------+----------------+';
END;
$$;





CREATE OR REPLACE FUNCTION NombreObjetsIllegauxEntreprise (entreprise_id INT) 
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE 
    nb_objet INT := 0;
BEGIN
    SELECT COUNT(*) INTO nb_objet
    FROM Modele_Objet mo
    INNER JOIN Gamme_Vente_Objet gvo ON mo.id_objet = gvo.id_objet
    WHERE mo.statut = 'ILLEGAL' AND gvo.id_fabriquant = entreprise_id;
    /*RAISE NOTICE '| % |',
        lpad(nb_objet::text, 4, ' ');*/
    RETURN nb_objet;
END;
$$;



--Procédure pour transférer un vaisseau d'une entreprise à une autre avec mise à jour de l'historique :


CREATE OR REPLACE PROCEDURE TransfertVaisseau (IN vaisseau_idD INT,IN source_id INT,IN destination_id INT,IN date_transfer DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Historique_Proprio
    SET date_fin = date_transfer
    WHERE id_vaisseau = vaisseau_idD AND date_fin IS NULL;

    INSERT INTO Historique_Vente_Vaisseau (id_vaisseau, id_entreprise, id_proprietaire, date_vente)
    VALUES (vaisseau_idD, source_id,destination_id, date_transfer);
END;
$$;


CREATE OR REPLACE FUNCTION calculer_prix_total_objets_entreprise(IN entreprise_idD INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    prix_total INTEGER := 0;
BEGIN
    SELECT COALESCE(SUM(mo.prix), 0)
    INTO prix_total
    FROM Entreprise_Objet eo 
    JOIN Gamme_Vente_Objet gvo on eo.id_entreprise = gvo.id_fabriquant
    JOIN Modele_Objet mo ON gvo.id_objet = mo.id_objet
    WHERE eo.id_entreprise = entreprise_idD;

    RETURN prix_total;
END;
$$;
