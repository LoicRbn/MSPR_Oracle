load data
   infile 	'entreprise.txt'
   badfile 	'entreprise.bad'
   discardfile 	'entreprise.dsc'
INSERT
into table ENTREPRISE
fields terminated by ';'
trailing nullcols ( SIRET,
		    RAISONSOCIALE,
		    NORUEENTR,
		    RUEENTR,
		    CPOSTALENTR,
		    VILLEENTR,
		    NOTEL,
		    CONTACT )
