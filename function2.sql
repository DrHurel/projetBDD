CREATE OR REPLACE FUNCTION listFreeId() 
RETURNS SETOF INTEGER
LANGUAGE plpgsql
AS $$
DECLARE 
    current_id INT := 0;
    pres_id INT := 0;
    id_proprietaire INT;
BEGIN
    FOR id_proprietaire IN 
        SELECT * 
        FROM Proprietaire 
        ORDER BY id_proprietaire
    LOOP
        current_id := id_proprietaire;

        IF NOT EXISTS (SELECT id_personne FROM Personne WHERE id_personne=current_id) 
            AND 
            NOT EXISTS (SELECT id_entreprise FROM Entreprise WHERE id_entreprise=current_id) 
        THEN
            RETURN NEXT current_id;
        END IF;

        WHILE (current_id - pres_id) > 1 LOOP
            pres_id := pres_id +1;
            RETURN NEXT pres_id;
        END LOOP;
        pres_id := current_id;
    END LOOP;
    RETURN;
END;
$$;