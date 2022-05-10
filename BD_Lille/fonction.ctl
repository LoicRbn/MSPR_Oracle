load data
   infile 	'fonction.txt'
   badfile 	'fonction.bad'
   discardfile 	'fonction.dsc'
INSERT
into table FONCTION
fields terminated by ';'
trailing nullcols ( NOFONCTION,
		    NOMFONCTION )
