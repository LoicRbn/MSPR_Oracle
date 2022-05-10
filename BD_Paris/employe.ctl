load data
   infile 	'employe.txt'
   badfile 	'employe.bad'
   discardfile 	'employe.dsc'
INSERT
into table EMPLOYE
fields terminated by ';'
trailing nullcols ( NOEMPLOYE   "seq_employe.nextval",
		    NOM,
		    PRENOM,
		    DATENAISS,
		    DATEEMBAUCHE,
		    SALAIRE,
		    FONCTION )
