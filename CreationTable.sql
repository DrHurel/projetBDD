
CREATE TABLE Proprietaire (
    id_proprietaire INT,
    CONSTRAINT PK_Proprietaire_id_proprietaire PRIMARY KEY(id_proprietaire)
);
    
-- a verif
CREATE TABLE Equipage (
    id_equipage INT,
    nom VARCHAR(50),
    date_creation DATE,
    id_entreprise INT,
    CONSTRAINT PK_Equipe_id_equipage PRIMARY KEY(id_equipage),
    CONSTRAINT FK_Equipage_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise_Vaisseau(id_entreprise) 
);
-- a verif
CREATE TABLE Vaisseau(
    id_vaisseau INT,
    prix INT,
    poids INT,
    longueur INT,
    largeur INT,
    id_fabriquant INT,

    CONSTRAINT PK_Vaisseau PRIMARY KEY(id_vaisseau),
    CONSTRAINT FK_Vaisseau_id_fabriquant FOREIGN KEY(id_fabriquant) REFERENCES Entreprise_Vaisseau(id_entreprise)
);
-- a verif
CREATE TABLE Personne(
    id_personne INT,
    nom VARCHAR(50),
    prenom VAR(50),
    poste VARCHAR(15),
    age INT,
    date_naissance DATE,
    id_entreprise INT,
    id_equipage INT,

    CONSTRAINT FK_Personne_id_proprietaire FOREIGN KEY(id_personne) REFERENCES Proprietaire(id_proprietaire),
    CONSTRAINT PK_Personne PRIMARY KEY(id_personne),
    CONSTRAINT FK_Personne_id_Entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise),
    CONSTRAINT FK_Personne_id_equipage FOREIGN KEY(id_equipage) REFERENCES Equipage(id_equipage)
);

CREATE TABLE Entreprise(
    id_entreprise INT,
    nom_entreprise VARCHAR(50),
    data_creation DATE,
    CONSTRAINT FK_Entreprise_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Proprietaire(id_proprietaire),
    CONSTRAINT PK_Entreprise PRIMARY KEY(id_entreprise),
    
); 

CREATE TABLE Entreprise_Vaisseau(
    id_entreprise INT,
    CONSTRAINT FK_Entreprise_Vaisseau_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise),
    CONSTRAINT PK_Entreprise_Vaisseau PRIMARY KEY(id_entreprise)
    

);



CREATE TABLE Entreprise_Objet(
    id_entreprise INT,
    CONSTRAINT FK_Entreprise_Objet_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise(id_entreprise),
    CONSTRAINT PK_Entreprise_Objet PRIMARY KEY(id_entreprise)
    
);

CREATE TABLE Modele_Objet(
    id_objet INT,
    nom VARCHAR(64),
    statut VARCHAR(7),
    prix INT,
    CONSTRAINT TYPE_OBJET CHECK (statut IN ('LEGAL','ILLEGAL')),
    CONSTRAINT PK_Modele_Objet_id_objet PRIMARY KEY(id_objet)
);

CREATE TABLE Gamme_Vente_Objet(
    id_fabriquant INT,
    id_objet INT,
    CONSTRAINT FK_Gamme_Vente_Objet_id_fabriquant FOREIGN KEY(id_fabriquant) REFERENCES Entreprise_Objet(id_entreprise),
    CONSTRAINT FK_Gamme_Vente_Objet_id_objet FOREIGN KEY(id_objet) REFERENCES Modele_Objet(id_objet),
    CONSTRAINT PK_Gamme_Vente_Objet PRIMARY KEY(id_objet,id_fabriquant)   
);


CREATE TABLE Inventaire_Vaisseau(
    id_vaisseau INT,
    id_objet INT,
    quantite INT,
    CONSTRAINT FK_Inventaire_Vaisseau_id_objet FOREIGN KEY(id_objet) REFERENCES Modele_Objet(id_objet),
    CONSTRAINT FK_Inventaire_Vaisseau_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau),
    CONSTRAINT PK_Inventaire_Vaisseau PRIMARY KEY(id_objet,id_vaisseau)   
); 


CREATE TABLE Chef_Entreprise(
    date_debut DATE,
    date_fin DATE,
    id_entreprise INT,
    id_personne INT,
    CONSTRAINT FK_Chef_Entreprise_id_personne FOREIGN KEY (id_personne) REFERENCES Personne(id_personne),
    CONSTRAINT FK_Chef_Entreprise_ID_Entreprise FOREIGN KEY (id_entreprise) REFERENCES Entreprise(id_entreprise),
    CONSTRAINT PK_Chef_Entreprise PRIMARY KEY(id_entreprise,id_personne,date_debut)   
    
    
);

CREATE TABLE Historique_Proprio(
    id_vaisseau INT,
    id_proprietaire INT,
    date_debut DATE,
    date_fin DATE,

    CONSTRAINT PK_Historique_Proprio PRIMARY KEY(date_debut,date_fin,id_proprietaire,id_vaisseau),
    CONSTRAINT FK_Historique_Proprio_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau),
    CONSTRAINT FK_Historique_Proprio_id_proprietaire FOREIGN KEY(id_proprietaire) REFERENCES Proprietaire(id_proprietaire)
    
    
);

CREATE TABLE Historique_Vente_Vaisseau(
    id_vaisseau INT,
    id_entreprise INT,
    id_proprietaire INT,
    date_vente DATE,
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_vaisseau FOREIGN KEY(id_vaisseau) REFERENCES Vaisseau(id_vaisseau),
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_proprietaire FOREIGN KEY(id_proprietaire) REFERENCES Proprietaire(id_proprietaire),
    CONSTRAINT FK_Historique_Vente_Vaisseau_id_entreprise FOREIGN KEY(id_entreprise) REFERENCES Entreprise_Vaisseau(id_entreprise),
    CONSTRAINT PK_Historique_Vente_Vaisseau PRIMARY KEY(id_vaisseau,id_entreprise,id_proprietaire)
);
