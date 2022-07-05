alter session set "_ORACLE_SCRIPT"=true;
SET SERVEROUTPUT ON;

/* requete 1 */
CREATE OR REPLACE PROCEDURE totalDechet (dateDeb in DATE, dateFin in DATE, numSite in INTEGER, typeDechet in VARCHAR) as
totalDechet int;
    BEGIN
    select sum(quantitedepot) into totaldechet from detaildepot,typedechet,tournee
    where typedechet.notypedechet = detaildepot.notypedechet
    and tournee.notournee = detaildepot.notournee
    and typedechet.nomtypedechet = typeDechet
    and tournee.datetournee BETWEEN datedeb AND datefin;
    DBMS_OUTPUT.PUT_LINE(totaldechet);
    END;
/
commit;

call totaldechet('10/09/18','21/10/18',1,'Papier');

/* requete 2 */
CREATE OR REPLACE PROCEDURE totalDechetNoSite (dateDeb in DATE, dateFin in DATE, typeDechet in VARCHAR) as
totalDechet int;
    BEGIN
    select sum(quantitedepot) into totaldechet from detaildepot,typedechet,tournee
    where typedechet.notypedechet = detaildepot.notypedechet
    and tournee.notournee = detaildepot.notournee
    and typedechet.nomtypedechet = typeDechet
    and tournee.datetournee BETWEEN datedeb AND datefin;
    DBMS_OUTPUT.PUT_LINE(totaldechet);
    END;
/
commit;



CREATE OR REPLACE PROCEDURE updateNullTournee(numDemande NUMBER, numTournee NUMBER)
IS
BEGIN
   UPDATE DEMANDE SET NOTOURNEE = numTournee where NODEMANDE=numDemande;
END;

CREATE OR REPLACE PROCEDURE insertNullTourneeInJournal(numDemande NUMBER)
IS
BEGIN
   INSERT INTO JOURNALDEMANDE VALUES (numDemande);
END;

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

DECLARE
    CURSOR c_fournisseur IS
        SELECT *
        FROM Demande
        WHERE NOTOURNEE IS NULL;
    numTournee INTEGER;
    BEGIN
    OPEN c_fournisseur;
        FOR v_fournisseur IN c_fournisseur LOOP
            numTournee := checkIfDateAvailable(v_fournisseur.DATEENLEVEMENT);
            IF numTournee IS NOT NULL
                THEN
                updateNullTournee(v_fournisseur.NODEMANDE);
            ELSE insertNullTourneeInJournal(v_fournisseur.NODEMANDE, v_fournisseur.NOTOURNEE);
            end if;
        END LOOP;
    CLOSE c_fournisseur;
    END;
