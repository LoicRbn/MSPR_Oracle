load data
   infile 	'modele.txt'
   badfile 	'modele.bad'
   discardfile 	'modele.dsc'
INSERT
into table MODELE
fields terminated by ';'
trailing nullcols ( NOMODELE  "seq_modele.nextval",
		    NOMMODELE,
		    NOMARQUE )
