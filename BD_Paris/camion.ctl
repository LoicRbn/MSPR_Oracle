load data
   infile 	'camion.txt'
   badfile 	'camion.bad'
   discardfile 	'camion.dsc'
INSERT
into table CAMION
fields terminated by ';'
trailing nullcols ( NOIMMATRIC,
		    DATEACHAT,
		    MODELE,
		    MARQUE )
