load data
   infile 	'demande.txt'
   badfile 	'demande.bad'
   discardfile 	'demande.dsc'
INSERT
into table DEMANDE
fields terminated by ';'
trailing nullcols ( NODEMANDE  "seq_demande.nextval",
		    DATEDEMANDE,
		    DATEENLEVEMENT,
		    SIRET,
		    NOTOURNEE )
