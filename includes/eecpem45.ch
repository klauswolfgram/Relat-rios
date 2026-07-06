#ifdef SPANISH
	#define STR0001 "Especificacion de las Mercaderias"
	#define STR0002 "Arabe"
	#define STR0003 "KGS"
	#define STR0004 " WITH:"
	#define STR0005 " GROSS"
	#define STR0006 " CONTAINING"
	#define STR0007 " NET"
	#define STR0008 " OF "
	#define STR0009 "MANUFACTURER / EXPORTER: "
	#define STR0010 "LETTER OF CREDIT NO.: DOK "
	#define STR0011 " ISSUED ON "
	#define STR0012 " BY"
	#define STR0013 " - DOKKI BRANCH"
	#define STR0014 "NATIONALITY OF THE MANUFACTURER / EXPORTER: BRAZILIAN"
#else
	#ifdef ENGLISH
		#define STR0001 "Goods Specification"
		#define STR0002 "Arab"
		#define STR0003 "KGS"
		#define STR0004 " WITH:"
		#define STR0005 " GROSS"
		#define STR0006 " CONTAINING"
		#define STR0007 " NET"
		#define STR0008 " OF "
		#define STR0009 "MANUFACTURER/EXPORTER: "
		#define STR0010 "LETTER OF CREDIT NO.: DOK "
		#define STR0011 " ISSUED ON "
		#define STR0012 " BY"
		#define STR0013 " - DOKKI BRANCH"
		#define STR0014 "NATIONALITY OF THE MANUFACTURER/EXPORTER: BRAZILIAN"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Especificação Das Mercadorias", "Especificação das Mercadorias" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "árabe", "Arabe" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Kgs", "KGS" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", " Com:", " WITH:" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", " Bruto", " GROSS" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", " Contendo", " CONTAINING" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", " Líquido", " NET" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", " of ", " OF " )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Fabricante/exportador: ", "MANUFACTURER/EXPORTER: " )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Letra de crédito no.: doc ", "LETTER OF CREDIT NO.: DOK " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", " issued on ", " ISSUED ON " )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", " Através De", " BY" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", " – Filial Dokki ", " - DOKKI BRANCH" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Nacionalidade Do Fabricante/exportador: Brasileiro", "NATIONALITY OF THE MANUFACTURER/EXPORTER: BRAZILIAN" )
	#endif
#endif
