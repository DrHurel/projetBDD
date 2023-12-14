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
    ELSE
        RAISE NOTICE 'Ce vaisseau n''est associé à aucun équipage.';
    END IF;
END;
$$;