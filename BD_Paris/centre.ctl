load data
   infile 	'centre.txt'
   badfile 	'centre.bad'
   discardfile 	'centre.dsc'
INSERT
into table CENTRETRAITEMENT
fields terminated by ';'
trailing nullcols ( NOCENTRE   "seq_centre.nextval",
		    NOMCENTRE,
		    NORUECENTRE,
		    RUECENTRE,
		    CPOSTALCENTRE,
		    VILLECENTRE )
