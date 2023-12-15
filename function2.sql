
CREATE OR REPLACE FUNCTION ListeCreuxDansLesIdPropietaire() 
RETURNS SETOF INTEGER;
LANGUAGE plpgsql
AS $$
DECLARE 
    current_id:= 0
    pres_id:= 0
    id_proprietaire INT;
    list_id RECORD;
BEGIN
    FOR id_proprietaire IN 
        SELECT * 
        FROM Proprietaire 
        ORDER BY id
    LOOP
        current_id := id_proprietaire;
        WHILE current_id - pres_id > 1 LOOP
            current_id := current_id +1
            RETURN NEXT current_id;
        END LOOP;
        pres_id := current_id;
    END LOOP;
    RETURN;
END;
$$;