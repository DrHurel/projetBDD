prompt "Suppression des relations"

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Historique_Vente_Vaisseau';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Historique_Proprio';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Inventaire_Vaisseau';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Gamme_Vente_Objet';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Chef_Entreprise';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Vaisseau';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Personne';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/


BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Equipage';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Entreprise_Objet';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Entreprise_Vaisseau';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Entreprise';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Modele_Objet';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Proprietaire';
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE != -942 THEN
RAISE;
END IF;
END;
/

