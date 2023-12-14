CREATE OR REPLACE PROCEDURE afficher_informations_equipage(IN vaisseau_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    equipage_id INT;
    personne_info RECORD;
BEGIN
    -- Obtenir l'identifiant de l'équipage associé au vaisseau donné
    SELECT id_equipage INTO equipage_id
    FROM Equipage
    WHERE id_vaisseau = vaisseau_id;

    -- Vérifier si un équipage est associé à ce vaisseau
    IF equipage_id IS NOT NULL THEN
        -- Afficher les informations des membres de l'équipage sous forme de tableau
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

CREATE OR REPLACE PROCEDURE afficher_informations_equipage_de_tout_les_vaisseaux()
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
