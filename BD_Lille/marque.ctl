load data
   infile 	'marque.txt'
   badfile 	'marque.bad'
   discardfile 	'marque.dsc'
INSERT
into table MARQUE
fields terminated by ';'
trailing nullcols ( NOMARQUE   "seq_marque.nextval",
		    NOMMARQUE )
