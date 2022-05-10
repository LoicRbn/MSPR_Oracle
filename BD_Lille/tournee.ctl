load data
   infile 	'tournee.txt'
   badfile 	'tournee.bad'
   discardfile 	'tournee.dsc'
INSERT
into table TOURNEE
fields terminated by ';'
trailing nullcols ( NOTOURNEE  "seq_tournee.nextval",
		    DATETOURNEE,
		    NOIMMATRIC,
		    NOEMPLOYE )
