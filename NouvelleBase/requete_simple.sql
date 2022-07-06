-- Chercher les demandes qui ont été faites après une date donnée:
SELECT * FROM DEMANDE WHERE DATEDEMANDE >= DATE '2017-12-31';
-- validée

-- Pour une demande donnée, afficher la raison sociale de l’entreprise, la tournée correspondante et la quantité à récupérer pour chaque type de déchet:
SELECT b.RAISONSOCIALE, c.NOTOURNEE, e.NOMTYPEDECHET, sum(d.QUANTITEENLEVEE) as QuantiteeRecup
FROM DEMANDE a INNER JOIN ENTREPRISE b ON a.SIRET = b.SIRET
INNER JOIN TOURNEE c ON a.NOTOURNEE = c.NOTOURNEE
INNER JOIN DETAILDEMANDE d ON a.NODEMANDE = d.NODEMANDE
INNER JOIN TYPEDECHET e ON d.NOTYPEDECHET = e.NOTYPEDECHET
WHERE a.NODEMANDE = 1 -- demande donnée
GROUP BY  b.RAISONSOCIALE, c.NOTOURNEE, e.NOMTYPEDECHET;
-- corrigée

-- Afficher la quantité totale récupérée par type de déchet pour un mois/année donné:
SELECT TYPEDECHET.NOMTYPEDECHET, SUM(DETAILDEMANDE.QUANTITEENLEVEE) as SommeQuantite
FROM DETAILDEMANDE INNER JOIN DEMANDE ON DEMANDE.NODEMANDE = DETAILDEMANDE.NODEMANDE
INNER JOIN TYPEDECHET ON TYPEDECHET.NOTYPEDECHET = DETAILDEMANDE.NOTYPEDECHET
WHERE DEMANDE.DATEDEMANDE >= DATE '2018-01-01' AND DATEDEMANDE <= DATE '2018-12-31'
GROUP BY TYPEDECHET.NOMTYPEDECHET;
-- corrigée

-- Afficher les employés ayant réalisé moins de n tournées. Triez le résultat sur le nombre de tournées. N étant un nombre de votre choix
SELECT *, COUNT(NOTOURNEE) as nbtournees
FROM EMPLOYE INNER JOIN TOURNEE ON EMPLOYE.NOEMPLOYE = TOURNEE.NOEMPLOYE
WHERE nbtournees = n
ORDER BY nbtournees DESC;
-- correction
SELECT EMPLOYE.NOEMPLOYE, EMPLOYE.NOM, EMPLOYE.PRENOM, COUNT(TOURNEE.NOTOURNEE) as nbtournees
FROM EMPLOYE INNER JOIN TOURNEE ON EMPLOYE.NOEMPLOYE = TOURNEE.NOEMPLOYE
GROUP BY EMPLOYE.NOEMPLOYE, EMPLOYE.NOM, EMPLOYE.PRENOM
HAVING COUNT(TOURNEE.NOTOURNEE) < 10 -- n = 10
ORDER BY nbtournees DESC;

--Affichez les informations de l’entreprise qui a réalisé plus de demandes que l’entreprise Formalys (ouune autre entreprise dont vous fournissez le nom).
SELECT b.RAISONSOCIALE, COUNT(a.NODEMANDE) as NumDemande
FROM DEMANDE a INNER JOIN ENTREPRISE b ON a.SIRET = b.SIRET
GROUP BY b.RAISONSOCIALE
HAVING COUNT(a.NODEMANDE) > (SELECT COUNT(NODEMANDE) FROM DEMANDE INNER JOIN ENTREPRISE ON DEMANDE.SIRET = ENTREPRISE.SIRET WHERE RAISONSOCIALE = 'Formalys')
ORDER BY NumDemande desc;

--Affichez les informations de l’entreprise qui a réalisé plus de demandes que l’entreprise Formalys (ouune autre entreprise dont vous fournissez le nom).
CREATE OR REPLACE FUNCTION f_nb_demande_superieure_a(raison_sociale VARCHAR2) RETURN VARCHAR2 IS
    entr_avec_plus_de_demande VARCHAR2(50);
BEGIN
    SELECT RAISONSOCIALE INTO entr_avec_plus_de_demande
    FROM DEMANDE d INNER JOIN ENTREPRISE e ON d.SIRET = e.SIRET
    GROUP BY RAISONSOCIALE
    HAVING COUNT(d.NODEMANDE) > (SELECT COUNT(NODEMANDE) FROM DEMANDE d INNER JOIN ENTREPRISE e ON d.SIRET = e.SIRET WHERE RAISONSOCIALE = raison_sociale)
    ORDER BY COUNT(NODEMANDE) DESC
    FETCH FIRST 1 ROW ONLY;

    return entr_avec_plus_de_demande;
END;
/
SELECT f_nb_demande_superieure_a('Formalys') FROM DUAL;

-- Affichez les informations des demandes qui ne sont pas encore inscrites dans une tournée
-- OK
SELECT * FROM DEMANDE
WHERE NOTOURNEE IS NULL;
