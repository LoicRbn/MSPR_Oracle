load data
   infile 	'detaildemande.txt'
   badfile 	'detaildemande.bad'
   discardfile 	'detaildemande.dsc'
INSERT
into table DETAILDEMANDE
fields terminated by ';'
trailing nullcols ( QUANTITEENLEVEE,
		    REMARQUE,
		    NODEMANDE,
		    NOTYPEDECHET )
