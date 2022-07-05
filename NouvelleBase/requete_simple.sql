-- Chercher les demandes qui ont été faites après une date donnée:
SELECT * FROM DEMANDE WHERE DATEDEMANDE <= DATE '2021-12-31';
-- validée

-- Pour une demande donnée, afficher la raison sociale de l’entreprise, la tournée correspondante et la quantité à récupérer pour chaque type de déchet:
SELECT ENTREPRISE.RAISONSOCIALE,
FROM DEMANDE INNER JOIN ENTREPRISE ON ENTREPRISE.SIRET = DEMANDE.SIRET
WHERE DEMANDE.NODEMANDE = 1;

-- Afficher la quantité totale récupérée par type de déchet pour un mois/année donné:
SELECT TYPEDECHET.NOMTYPEDECHET, SUM(DETAILDEMANDE.QUANTITEENLEVEE) as SommeQuantite
FROM DETAILDEMANDE INNER JOIN DEMANDE ON DEMANDE.NODEMANDE = DETAILDEMANDE.NODEMANDE
INNER JOIN TYPEDECHET ON TYPEDECHET.NOTYPEDECHET = DETAILDEMANDE.NOTYPEDECHET
WHERE DEMANDE.DATEDEMANDE >= DATE '2018-01-01' AND DATEDEMANDE <= DATE '2018-12-31'
GROUP BY TYPEDECHET.NOMTYPEDECHET;


-- Afficher les employés ayant réalisé moins de n tournées. Triez le résultat sur le nombre de tournées. N étant un nombre de votre choix
SELECT *, COUNT(NOTOURNEE) as nbtournees
FROM EMPLOYE INNER JOIN TOURNEE ON EMPLOYE.NOEMPLOYE = TOURNEE.NOEMPLOYE
WHERE nbtournees = n
ORDER BY nbtournees DESC;
-- correction
SELECT EMPLOYE.NOEMPLOYE, EMPLOYE.NOM, EMPLOYE.PRENOM, COUNT(TOURNEE.NOTOURNEE) as nbtournees
FROM EMPLOYE INNER JOIN TOURNEE ON EMPLOYE.NOEMPLOYE = TOURNEE.NOEMPLOYE
GROUP BY EMPLOYE.NOEMPLOYE, EMPLOYE.NOM, EMPLOYE.PRENOM
HAVING COUNT(TOURNEE.NOTOURNEE) < 10
ORDER BY nbtournees DESC;


--Affichez les informations de l’entreprise qui a réalisé plus de demandes que l’entreprise Formalys (ouune autre entreprise dont vous fournissez le nom).
SELECT a.RAISONSOCIALE, COUNT(b.NODEMANDE) as nbdemande
FROM ENTREPRISE a INNER JOIN DEMANDE b ON a.SIRET = b.SIRET
WHERE nbdemande > (SELECT COUNT(*) FROM ENTREPRISE a INNER JOIN DEMANDE b ON a.SIRET = b.SIRET WHERE a.RAISONSOCIALE = 'Formalys');

--• Affichez les informations des demandes qui ne sont pas encore inscrites dans une tournée
SELECT *, COUNT(NOTOURNEE) as nbtournee FROM DEMANDE
INNER JOIN TOURNEE ON DEMANDE.NOTOURNEE = TOURNEE.NOTOURNEE
WHERE nbtournee = 0

--2ème solution
SELECT * FROM DEMANDE
WHERE NOTOURNEE IS NULL;
