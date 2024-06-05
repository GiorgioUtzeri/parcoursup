
/*==============================================================*/
/* TELECHARGEMENT DU FICHIER                                    */
/*==============================================================*/

\! echo 'Début du téléchargement du fichier de données'
\! rm -f csv\?lang\=fr*
\! rm -f fr-esr-parcoursup.csv
\! $(wget https://data.enseignementsup-recherche.gouv.fr/api/explore/v2.1/catalog/datasets/fr-esr-parcoursup/exports/csv?lang=fr&timezone=Europe%2FBerlin&use_labels=true&delimiter=%3B)
\! mv csv\?lang\=fr fr-esr-parcoursup.csv
\! echo 'Fichier téléchargé avec succès'

/*==============================================================*/
/* IMPORTATION DES DONNEES                                      */
/*==============================================================*/

/* SUPPRESSION DE LA TABLE D'IMPORTATION SI ELLE EXISTE */
DROP TABLE IF EXISTS import;

/* CREATION D'UN TABLE TEMPORAIRE D'IMPORTATION */
CREATE TEMP TABLE import (
	n1 INT,
	n2 VARCHAR(50),
	n3 VARCHAR(8),
	n4 VARCHAR(200),
	n5 VARCHAR(3),
	n6 VARCHAR(50),
	n7 VARCHAR(50),
	n8 VARCHAR(50),
	n9 VARCHAR(40),
	n10 VARCHAR(300),
	n11 VARCHAR(50),
	n12 VARCHAR(50),
	n13 VARCHAR(500),
	n14 VARCHAR(100),
	n15 VARCHAR(200),
	n16 VARCHAR(200),
	n17 VARCHAR(30),
	n18 INT,
	n19 INT,
	n20 INT,
	n21 INT,
	n22 INT,
	n23 INT,
	n24 INT,
	n25 INT,
	n26 INT,
	n27 INT,
	n28 INT,
	n29 INT,
	n30 INT,
	n31 INT,
	n32 INT,
	n33 INT,
	n34 INT,
	n35 INT,
	n36 INT,
	n37 INT,
	n38 INT,
	n39 INT,
	n40 INT,
	n41 INT,
	n42 INT,
	n43 INT,
	n44 INT,
	n45 INT,
	n46 INT,
	n47 INT,
	n48 INT,
	n49 INT,
	n50 INT,
	n51 NUMERIC,
	n52 NUMERIC,
	n53 NUMERIC,
	n54 INT,
	n55 INT,
	n56 INT,
	n57 INT,
	n58 INT,
	n59 INT,
	n60 INT,
	n61 INT,
	n62 INT,
	n63 INT,
	n64 INT,
	n65 INT,
	n66 NUMERIC(5,2),
	n67 INT,
	n68 INT,
	n69 INT,
	n70 INT,
	n71 INT,
	n72 INT,
	n73 INT,
	n74 NUMERIC(5,2),
	n75 NUMERIC(5,2),
	n76 NUMERIC(5,2),
	n77 NUMERIC(5,2),
	n78 NUMERIC(5,2),
	n79 NUMERIC(5,2),
	n80 NUMERIC(5,2),
	n81 NUMERIC(5,2),
	n82 NUMERIC(5,2),
	n83 NUMERIC(5,2),
	n84 NUMERIC(5,2),
	n85 NUMERIC(5,2),
	n86 NUMERIC(5,2),
	n87 NUMERIC(5,2),
	n88 NUMERIC(5,2),
	n89 NUMERIC(5,2),
	n90 NUMERIC(5,2),
	n91 NUMERIC(5,2),
	n92 NUMERIC(5,2),
	n93 NUMERIC(5,2),
	n94 NUMERIC(5,2),
	n95 NUMERIC(5,1),
	n96 NUMERIC(5,2),
	n97 NUMERIC(5,2),
	n98 NUMERIC(5,2),
	n99 NUMERIC(5,2),
	n100 NUMERIC(5,2),
	n101 NUMERIC,
	n102 VARCHAR(50),
	n103 NUMERIC,
	n104 VARCHAR(50),
	n105 INT,
	n106 VARCHAR(50),
	n107 INT,
	n108 VARCHAR(100),
	n109 VARCHAR(20),
	n110 INT,
	n111 TEXT,
	n112 TEXT,
	n113 NUMERIC(5,2),
	n114 NUMERIC(5,2),
	n115 NUMERIC(5,2),
	n116 NUMERIC(5,2),
	n117 VARCHAR(10),
	n118 VARCHAR(10)
);

\echo 'Création de la table import vide effectuée.'

/* IMPORTATION DES DONNEES DANS LA TABLE IMPORT */

\COPY import FROM './fr-esr-parcoursup.csv' WITH (DELIMITER ';', NULL '', HEADER) -- MODIFIER LE CHEMIN QUAND RENDU !
\echo 'Importation des données effectué dans la table "import".'

/*==============================================================*/
/* CREATION DES TABLES                                          */
/*==============================================================*/

/* SUPPRESSION DES TABLES SI ELLES EXISTENT */

DROP TABLE IF EXISTS Mentions;
DROP TABLE IF EXISTS Boursiers;
DROP TABLE IF EXISTS Candidatures;
DROP TABLE IF EXISTS Formations;
DROP TABLE IF EXISTS Etablissements;
DROP TABLE IF EXISTS Departements;
\echo 'Suppression des tables si elles existent.'

/* CREATION DE LA TABLE DEPARTEMENTS */

CREATE TABLE Departements (
	codeDepartement VARCHAR(3),
	departement VARCHAR(50),
	region VARCHAR(50),
	aca VARCHAR(50),
    CONSTRAINT pK_Departements PRIMARY KEY(codeDepartement)
);
\echo 'Création de la table Departements effectuée.'

/* CREATION DE LA TABLE ETABLISSEMENTS */

CREATE TABLE Etablissements (
	statutEtaFilForm VARCHAR(50),
	codeUAI VARCHAR(8),
	eta VARCHAR(200),
    codeDepartement VARCHAR(3),
    CONSTRAINT pK_Etablissements PRIMARY KEY(codeUAI),
    CONSTRAINT fK_CodeDepartement FOREIGN KEY(codeDepartement) REFERENCES Departements(codeDepartement)
		ON UPDATE CASCADE ON DELETE SET NULL
);
\echo 'Création de la table Etablissements effectuée.'

/* CREATION DE LA TABLE FORMATIONS */

CREATE TABLE Formations (
    codeForm INT,
	codeUAI VARCHAR(8),
	filForm VARCHAR(300),
	selectivite VARCHAR(50),
	filFormTresDet VARCHAR(50),
	filFormDet VARCHAR(500),
	filFormBis VARCHAR(100),
	filFormDetBis VARCHAR(200),
	filFormTresDetBIs VARCHAR(200),
	coorGPS VARCHAR(30),
	capaciteEtaForm INT,
    CONSTRAINT pK_Formations PRIMARY KEY(codeForm),
	CONSTRAINT fK_CodeUAI FOREIGN KEY(codeUAI) REFERENCES Etablissements(codeUAI)
		ON UPDATE CASCADE ON DELETE SET NULL
);
\echo 'Création de la table Formations effectuée.'

/* CREATION DE LA TABLE CANDIDATURES */

CREATE TABLE Candidatures (
    cid SERIAL,
    codeForm INT,
	nbTotCandForm INT,
	nbCandidatesForm INT,
	nbCandPostuleInternat INT,
	nbCandNeoBacGenPrinc INT,
	nbCandNeoBacTecPrinc INT,
	nbCandNeoBacProPrinc INT,
	nbAutresCandPrinc INT,
	nbTotCandComp INT,
	nbCandNeoBacGenComp INT,
	nbCandNeoBacTecComp INT,
	nbCandNeoBacProComp INT,
	nbAutresCandComp INT,
	nbTotCandClassEtaPrinc INT,
	nbCandClassEtaComp INT,
	nbCandClassEtaINTernatCPGE INT,
	nbCandClassEtaHorsINTernatCPGE INT,
	nbCandNeoBacGenClassEta INT,
	nbCandNeoBacTecClassEta INT,
	nbCandNeoBacProClassEta INT,
	nbAutresCandClassEta INT,
	nbTotCandPropAdm INT,
	nbTotCandAcceptePropAdm INT,
	nbCandidatesAdmises INT,
	nbAdmPrinc INT,
	nbAdmComp INT,
	nbAdmRecuPropAdmOuvertureProcPrinc INT,
	nbAdmRecuPropAdmAvantBacc INT,
	nbAdmRecuPropAdmAvantFinProcPrinc INT,
	nbAdmINTernat INT,
	nbAdmNeoBac INT,
	nbAdmNeoBacGen INT,
	nbAdmNeoBacTec INT,
	nbAdmNeoBacPro INT,
	nbAutresCandAdm INT,
	nbAdmIssusMemeEtaBTS_CPGE INT,
	nbAdmisesIssuesMemeEtaBTS_CPGE INT,
	nbAdmIssusMemeAca INT,
	nbAdmIssusMemeAcaParisCreteilVersaillesReunies INT,
	nbCandTermGenRecuPropAdm INT,
	nbCandTermTecRecuPropAdm INT,
	nbCandTermProRecuPropAdm INT,
	nbAutresCandRecuPropAdm INT,
	reGROUPement1EffectueFormClass VARCHAR(50),
	rangDernierAppeleGROUPe1 INT,
	reGROUPement2EffectueFormClass VARCHAR(50),
	rangDernierAppeleGROUPe2 INT,
	reGROUPement3EffectueFormClass VARCHAR(50),
	rangDernierAppeleGROUPe3 INT,
	tauxAcces INT,
	partTermsGenPropPrinc NUMERIC(5,2),
	partTermsTecPropPrinc NUMERIC(5,2),
	partTermsProPropPrinc NUMERIC(5,2),
    CONSTRAINT pK_Candidatures PRIMARY KEY(cid),
	CONSTRAINT fK_codeForm FOREIGN KEY(codeForm) REFERENCES Formations(codeForm)
		ON UPDATE CASCADE ON DELETE SET NULL
);
\echo 'Création de la table Candidatures effectuée.'

/* CREATION DE LA TABLE BOURSIERS */

CREATE TABLE Boursiers (
	bid SERIAL,
	codeForm INT,
	nbCandBoursiersNeoBacGenPrinc INT,
	nbCandBoursiersNeoBacTecPrinc INT,
	nbCandBoursiersNeoBacProPrinc INT,
	nbCandBoursiersNeoBacGenClassEta INT,
	nbCandBoursiersNeoBacTecClassEta INT,
	nbCandBoursiersNeoBacProClassEta INT,
	nbAdmBoursiersNeoBac INT,
	nbCandBoursiersTermGenRecuPropAdm INT,
	nbCandBoursiersTermTecRecuPropAdm INT,
	nbCandBoursiersTermGenProRecuPropAdm INT,
	CONSTRAINT pK_Boursiers PRIMARY KEY(bid),
	CONSTRAINT fK_codeForm FOREIGN KEY(codeForm) REFERENCES Formations(codeForm)
		ON UPDATE CASCADE ON DELETE SET NULL
);
\echo 'Création de la table Boursiers effectuée.'

/* CREATION TABLES MENTIONS */

CREATE TABLE Mentions (
	mid SERIAL,
	codeForm INT,
	nbAdmNeoBacSansInfoMenBac INT,
	nbAdmNeoBacSansMenBac INT,
	nbAdmNeoBacAvecMenABac INT,
	nbAdmNeoBacAvecMenBBac INT,
	nbAdmNeoBacAvecMenTBac INT,
	nbAdmNeoBacAvecMenTFeliBac INT,
	nbAdmNeoBacGenMenBac INT,
	nbAdmNeoBacTecMenBac INT,
	nbAdmNeoBacProMenBac INT,
	CONSTRAINT pK_Mentions PRIMARY KEY(mid),
	CONSTRAINT fK_codeForm FOREIGN KEY(codeForm) REFERENCES Formations(codeForm)
		ON UPDATE CASCADE ON DELETE SET NULL
);
\echo 'Création de la table Mentions effectuée.'

/*==============================================================*/
/* VENTILATION DES DONNEES                                      */
/*==============================================================*/

/* Ventilation de la table Departements */

INSERT INTO Departements (codeDepartement, departement, region, aca) SELECT distinct n5, n6, n7, n8 FROM import;

/* Ventilation de la table Etablissements */

INSERT INTO Etablissements (statutetafilform, codeuai, eta, codedepartement) SELECT n2, n3, n4, n5 FROM import GROUP BY n2,n3,n4,n5;

/* Ventilation de la table Formations */

INSERT INTO Formations (codeForm, filForm, codeUAI, selectivite, filFormTresDet, filFormDet, filFormBis, filFormDetBis, filFormTresDetBIs, coorGPS, capaciteEtaForm) SELECT n110,n10,n3,n11,n12,n13,n14,n15,n16,n17,n18 FROM import;

/* Ventilation de la table Candidatures */

INSERT INTO Candidatures (
    codeForm,nbTotCandForm,nbCandidatesForm,
    nbCandPostuleInternat,nbCandNeoBacGenPrinc,
    nbCandNeoBacTecPrinc,nbCandNeoBacProPrinc,
    nbAutresCandPrinc,nbTotCandComp,nbCandNeoBacGenComp,
    nbCandNeoBacTecComp,nbCandNeoBacProComp,nbAutresCandComp,
    nbTotCandClassEtaPrinc,nbCandClassEtaComp,nbCandClassEtaInternatCPGE,
    nbCandClassEtaHorsInternatCPGE,nbCandNeoBacGenClassEta,
    nbCandNeoBacTecClassEta,nbCandNeoBacProClassEta,nbAutresCandClassEta,
    nbTotCandPropAdm,nbTotCandAcceptePropAdm,nbCandidatesAdmises,
    nbAdmPrinc,nbAdmComp,nbAdmRecuPropAdmOuvertureProcPrinc,
    nbAdmRecuPropAdmAvantBacc,nbAdmRecuPropAdmAvantFinProcPrinc,nbAdmInternat,
    nbAdmNeoBac,nbAdmNeoBacGen,nbAdmNeoBacTec,nbAdmNeoBacPro,nbAutresCandAdm,
    nbAdmIssusMemeEtaBTS_CPGE,nbAdmisesIssuesMemeEtaBTS_CPGE,nbAdmIssusMemeAca,
    nbAdmIssusMemeAcaParisCreteilVersaillesReunies,nbCandTermGenRecuPropAdm,
    nbCandTermTecRecuPropAdm,nbCandTermProRecuPropAdm,nbAutresCandRecuPropAdm,
    reGROUPement1EffectueFormClass,rangDernierAppeleGROUPe1,reGROUPement2EffectueFormClass,
    rangDernierAppeleGROUPe2,reGROUPement3EffectueFormClass,rangDernierAppeleGROUPe3,
    tauxAcces,partTermsGenPropPrinc,partTermsTecPropPrinc,partTermsProPropPrinc
)
SELECT 
    f.codeForm,n19,n20,n22,n23,n25,n27,n29,n30,n31,n32,n33,n34,n35,n36,n37,n38,n39,n41,n43,n45,n46,n47,n48,n49,n50,n51,n52,n53,n54,n56,n57,n58,n59,n60,n70,n71,n72,n73,n95,n97,n99,n101,n102,n103,n104,n105,n106,n107,n113,n114,n115,n116
FROM 
    import as i
JOIN
    Formations as f ON i.n110 = f.codeForm;


/* Ventilation de la table Boursiers */

INSERT INTO Boursiers (codeForm,nbCandBoursiersNeoBacGenPrinc,nbCandBoursiersNeoBacTecPrinc,nbCandBoursiersNeoBacProPrinc,nbCandBoursiersNeoBacGenClassEta,nbCandBoursiersNeoBacTecClassEta,nbCandBoursiersNeoBacProClassEta,nbAdmBoursiersNeoBac,nbCandBoursiersTermGenRecuPropAdm,nbCandBoursiersTermTecRecuPropAdm,nbCandBoursiersTermGenProRecuPropAdm)
SELECT f.codeForm,n24,n26,n28,n40,n42,n44,n55,n96,n98,n100
FROM import as i
JOIN Formations as f ON i.n110 = f.codeForm;

/* Ventilation de la table Mentions */

INSERT INTO Mentions (codeForm,nbAdmNeoBacSansInfoMenBac,nbAdmNeoBacSansMenBac,nbAdmNeoBacAvecMenABac,nbAdmNeoBacAvecMenBBac,nbAdmNeoBacAvecMenTBac,nbAdmNeoBacAvecMenTFeliBac,nbAdmNeoBacGenMenBac,nbAdmNeoBacTecMenBac,nbAdmNeoBacProMenBac)
SELECT f.codeForm,n61,n62,n63,n64,n65,n66,n67,n68,n69
FROM import as i
JOIN Formations as f ON i.n110 = f.codeForm;

\echo 'Ventilation des tables effectuée avec succès.'

/*==============================================================*/
/* CREATION D'INDEXS                                            */
/*==============================================================*/

/* SUPPRESSION DES INDEXS S'ILS EXISTENT */

DROP INDEX IF EXISTS idxCandidaturesPk;
DROP INDEX IF EXISTS idxCandidaturesFk;
DROP INDEX IF EXISTS idxFormationsPk;
DROP INDEX IF EXISTS idxDepartementsPk;
DROP INDEX IF EXISTS idxEtablissementsPk;
DROP INDEX IF EXISTS idxEtablissementsFk;

/* CREATION DES INDEXS */

CREATE INDEX idxCandidaturesPk ON Candidatures(cid);
CREATE INDEX idxCandidaturesFk ON Candidatures(codeForm);
CREATE INDEX idxFormationsPk ON Formations(codeForm);
CREATE INDEX idxDepartementsPk ON Departements(codeDepartement);
CREATE INDEX idxEtablissementsPk ON Etablissements(codeUAI);
CREATE INDEX idxEtablissementsFk ON Etablissements(codeDepartement);

/*==============================================================*/
/* CREATION DES FICHIERS EXTERNE                                */
/*==============================================================*/

\! rm -rdf results
\! mkdir results

\COPY Departements to 'results/departements.csv' WITH (DELIMITER ';', NULL '');
\COPY Etablissements to 'results/etablissements.csv' WITH (DELIMITER ';', NULL '');
\COPY Formations to 'results/formations.csv' WITH (DELIMITER ';', NULL '');
\COPY Candidatures to 'results/candidatures.csv' WITH (DELIMITER ';', NULL '');
\COPY Boursiers to 'results/boursiers.csv' WITH (DELIMITER ';', NULL '');
\COPY Mentions to 'results/mentions.csv' WITH (DELIMITER ';', NULL '');

\echo 'Données exportées dans les fichiers csv contenus dans le nouveau répertoire results'
