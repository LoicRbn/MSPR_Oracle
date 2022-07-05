alter session set "_ORACLE_SCRIPT"=true;
SET SERVEROUTPUT ON
/* requete 1 */
create or replace PROCEDURE totalDechet (dateDeb in DATE, dateFin in DATE, numSite in INTEGER, typeDechet in VARCHAR) as
totalDechet int;
    BEGIN
    select sum(quantitedepot) into totaldechet from detaildepot,typedechet,tournee
    where typedechet.notypedechet = detaildepot.notypedechet
    and tournee.notournee = detaildepot.notournee
    and typedechet.nomtypedechet = typeDechet
    and detaildepot.nocentre = numSite
    and tournee.datetournee BETWEEN datedeb AND datefin;
    DBMS_OUTPUT.PUT_LINE(totaldechet);
    END;
/
commit;

call totaldechet('10/09/18','21/10/18',1,'Papier');

/* requete 2 */
CREATE OR REPLACE FUNCTION totalDechetForOneType (dateDeb in DATE, dateFin in DATE,typeDechet in VARCHAR) return integer is
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

call totaldechet();
call totaldechetforonetype();

commit;
