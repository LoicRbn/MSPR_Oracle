load data
   infile 	'typedechet.txt'
   badfile 	'typedechet.bad'
   discardfile 	'typedechet.dsc'
INSERT
into table TYPEDECHET
fields terminated by ';'
trailing nullcols ( NOTYPEDECHET   "seq_typedechet.nextval",
		    NOMTYPEDECHET,
		    NIV_DANGER )
