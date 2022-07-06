alter session set "_ORACLE_SCRIPT"=true;
SET SERVEROUTPUT ON

/* requete 1 */
CREATE OR REPLACE PROCEDURE totalDechet (dateDeb in DATE, dateFin in DATE, numSite in INTEGER, typeDechet in VARCHAR) as
totalDechet int;
    BEGIN
    select sum(quantitedepot) into totaldechet from detaildepot, typedechet,tournee,SITE,EMPLOYE
    where typedechet.notypedechet = detaildepot.notypedechet
    and site.nosite = employe.nosite
    and employe.noemploye = tournee.noemploye
    and tournee.notournee = detaildepot.notournee
    and typedechet.nomtypedechet = typeDechet
    and site.nosite = numSite
    and tournee.datetournee BETWEEN datedeb AND datefin;
    RETURN totaldechet;
    DBMS_OUTPUT.PUT_LINE(totaldechet);
    END;
/
commit;

call totaldechet('10/09/18','21/10/18',1,'Papier');

/* requete 2 */
CREATE OR REPLACE PROCEDURE totalDechetNoSite (dateDeb in DATE, dateFin in DATE, typeDechet in VARCHAR) as
BEGIN
DECLARE
typeDechet int;
    BEGIN
    SELECT SUM(QUANTITEENLEVEE) into typeDechet
    FROM DETAILDEMANDE
    INNER JOIN DEMANDE ON DEMANDE.NODEMANDE = DETAILDEMANDE.NODEMANDE
    WHERE DETAILDEMANDE.NOTYPEDECHET LIKE typeDechet
    AND DEMANDE.DATEENLEVEMENT BETWEEN dateDeb AND dateFin;
    return typeDechet;
    END;
  END;
/

call totalDechetNoSite('10/09/18','21/10/18','Papier');

/* requete 3 */

CREATE OR REPLACE PROCEDURE updateNullTournee(numDemande NUMBER, numTournee NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('je suis sur le point');
   UPDATE demande t SET t.NOTOURNEE = numTournee WHERE t.NODEMANDE = numDemande;
END;
/

CREATE OR REPLACE PROCEDURE insertNullTourneeInJournal(numDemande NUMBER)
IS
BEGIN
   INSERT INTO demandeatraiter (NOTOURNEE) VALUES (numDemande);
END;
/



CREATE OR REPLACE FUNCTION checkIfDateAvailable(dateToCheck DATE)
RETURN INT
IS numTournee INT;
BEGIN
   SELECT NOTOURNEE INTO numTournee from TOURNEE WHERE DATETOURNEE= dateToCheck;
   IF numTournee IS NULL
      THEN
       SELECT NOTOURNEE INTO numTournee from TOURNEE WHERE DATETOURNEE=dateToCheck+1;
       IF numTournee IS NULL
          THEN
           SELECT NOTOURNEE INTO numTournee FROM TOURNEE WHERE DATETOURNEE=dateToCheck+2;
           ELSE return NULL;
        end if;
   end if;
   RETURN numTournee;
END;
/


DECLARE
    CURSOR c_fournisseur IS
        SELECT NODEMANDE, DATEENLEVEMENT
        FROM Demande
        WHERE NOTOURNEE IS NULL;
    numTournee INTEGER;
    BEGIN
        FOR v_fournisseur IN c_fournisseur LOOP
           SELECT checkIfDateAvailable(v_fournisseur.DATEENLEVEMENT) INTO numTournee FROM DUAL;
            IF numTournee IS NOT NULL THEN
                updateNullTournee(v_fournisseur.NODEMANDE, numTournee);
            ELSE
                insertNullTourneeInJournal(v_fournisseur.NODEMANDE);
            end if;
        END LOOP;
END;
/



/* requete 4 */
CREATE OR REPLACE TRIGGER verificationTotalDechet
BEFORE INSERT on detaildepot
FOR EACH ROW
DECLARE
quantiteCollecter integer;
BEGIN
    SELECT SUM(d.quantiteenlevee) as total_qte INTO quantiteCollecter
    FROM DETAILDEPOT a INNER JOIN TOURNEE b ON a.NOTOURNEE = b.notournee
    INNER JOIN demande c ON b.NOTOURNEE = c.notournee
    INNER JOIN DETAILDEMANDE d ON c.nodemande = d.nodemande
    WHERE a.notournee = :new.NOTOURNEE;
    if quantiteCollecter < :new.QUANTITEDEPOT THEN
        RAISE_APPLICATION_ERROR(-20010, 'La quantite dépose est supérieure à la quantité collecter');
    end if;
END;
/

insert into detaildepot(notournee, nocentre,notypedechet,quantitedepot) values (1,1,7,500000);
