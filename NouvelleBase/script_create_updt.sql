CREATE TABLE Fonction(
   NOFONCTION INT,
   LIBELLE VARCHAR(50),
   PRIMARY KEY(NOFONCTION)
);

CREATE TABLE Site(
   NOSITE INT,
   LIBELLE VARCHAR(50),
   PRIMARY KEY(NOSITE)
);

CREATE TABLE CentreTraitement(
   NOCENTRE INT,
   NOMCENTRE VARCHAR(50),
   NORUECENTRE INT,
   CPOSTALCENTRE CHAR(50),
   VILLECENTRE VARCHAR(50),
   PRIMARY KEY(NOCENTRE)
);

CREATE TABLE Entreprise(
   SIRET INT,
   RAISONSOCIALE VARCHAR(50),
   NORUEENT VARCHAR(50),
   CPOSTALENTR VARCHAR(50),
   VILLEENTRE VARCHAR(50),
   NOTEL INT,
   CONTACT VARCHAR(50),
   PRIMARY KEY(SIRET)
);

CREATE TABLE TypeDechet(
   NOTYPEDECHET INT,
   NOMTYPEDECHET VARCHAR(50),
   NIV_DANGER INT,
   TARIF_FORFETAIRE INT,
   TARIF_LOT INT,
   PRIMARY KEY(NOTYPEDECHET)
);

CREATE TABLE LICENCIER(
   ID INT,
   NOM VARCHAR(50),
   PRENOM VARCHAR(50),
   DATENAISS VARCHAR(50),
   DATELICENCIMENT DATE,
   DATEEMBAUCHE DATE,
   SALAIRE INT,
   PRIMARY KEY(ID)
);

CREATE TABLE Employe(
   NOEMPLOYE INT,
   NOM VARCHAR(50),
   PRENOM VARCHAR(50),
   DATENAISS DATE,
   SALAIRE DECIMAL(15,2),
   DATEEMBAUCHE DATE,
   NOSITE INT NOT NULL,
   NOFONCTION INT NOT NULL,
   PRIMARY KEY(NOEMPLOYE),
   FOREIGN KEY(NOSITE) REFERENCES Site(NOSITE),
   FOREIGN KEY(NOFONCTION) REFERENCES Fonction(NOFONCTION)
);

CREATE TABLE Camion(
   NOIMMATRIC INT,
   DATEACHAT DATE,
   MARQUE VARCHAR(50),
   MODELE VARCHAR(50),
   NOSITE INT NOT NULL,
   PRIMARY KEY(NOIMMATRIC),
   FOREIGN KEY(NOSITE) REFERENCES Site(NOSITE)
);

CREATE TABLE Tournee(
   NOTOURNEE INT,
   DATETOURNEE DATE,
   ETAT VARCHAR(50),
   NOEMPLOYE INT NOT NULL,
   NOIMMATRIC INT NOT NULL,
   PRIMARY KEY(NOTOURNEE),
   FOREIGN KEY(NOEMPLOYE) REFERENCES Employe(NOEMPLOYE),
   FOREIGN KEY(NOIMMATRIC) REFERENCES Camion(NOIMMATRIC)
);

CREATE TABLE Demande(
   NODEMANDE INT,
   DATEDEMANDE DATE,
   DATEENLEVEMENT DATE,
   SIRET VARCHAR(50),
   WEB_O_N VARCHAR(50),
   NOSITE INT NOT NULL,
   NOTOURNEE INT,
   SIRET_1 INT NOT NULL,
   PRIMARY KEY(NODEMANDE),
   FOREIGN KEY(NOSITE) REFERENCES Site(NOSITE),
   FOREIGN KEY(NOTOURNEE) REFERENCES Tournee(NOTOURNEE),
   FOREIGN KEY(SIRET_1) REFERENCES Entreprise(SIRET)
);

CREATE TABLE INDISPONIBILITER(
   ID INT,
   DATE_DEBUT_INDISPONIBILITE DATE,
   DATE_FIN_INDISPONIBILITER DATE,
   NOEMPLOYE INT NOT NULL,
   PRIMARY KEY(ID),
   FOREIGN KEY(NOEMPLOYE) REFERENCES Employe(NOEMPLOYE)
);

CREATE TABLE DETAILDEMANDE(
   NODEMANDE INT,
   NOTYPEDECHET INT,
   QUANTITEENLEVEE INT,
   REMARQUE VARCHAR(50),
   PRIMARY KEY(NODEMANDE, NOTYPEDECHET),
   FOREIGN KEY(NODEMANDE) REFERENCES Demande(NODEMANDE),
   FOREIGN KEY(NOTYPEDECHET) REFERENCES TypeDechet(NOTYPEDECHET)
);

CREATE TABLE DETAILDEPOT(
   NOTOURNEE INT,
   NOCENTRE INT,
   NOTYPEDECHET INT,
   QUANTITEDEPOT INT,
   PRIMARY KEY(NOTOURNEE, NOCENTRE, NOTYPEDECHET),
   FOREIGN KEY(NOTOURNEE) REFERENCES Tournee(NOTOURNEE),
   FOREIGN KEY(NOCENTRE) REFERENCES CentreTraitement(NOCENTRE),
   FOREIGN KEY(NOTYPEDECHET) REFERENCES TypeDechet(NOTYPEDECHET)
);

CREATE TABLE DEMANDEATRAITER(
   NODEMANDEATRAITER INT,
   DATEDEMANDE INT,
   NODEMANDE INT,
   PRIMARY KEY(NODEMANDEATRAITER)
);
