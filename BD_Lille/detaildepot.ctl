load data
   infile 	'detaildepot.txt'
   badfile 	'detaildepot.bad'
   discardfile 	'detaildepot.dsc'
INSERT
into table DETAILDEPOT
fields terminated by ';'
trailing nullcols ( QUANTITEDEPOSEE,
		    NOTOURNEE,
		    NOTYPEDECHET,
		    NOCENTRE )
