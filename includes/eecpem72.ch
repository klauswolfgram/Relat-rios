#ifdef SPANISH
	#define STR0001 "Orden"
	#define STR0002 "Cod. NALADI / SH"
	#define STR0003 "Descripcion"
	#define STR0004 "Normas de Origen"
	#define STR0005 "Aladi"
#else
	#ifdef ENGLISH
		#define STR0001 "Order"
		#define STR0002 "NALADI/SH code"
		#define STR0003 "Description"
		#define STR0004 "Source norms "
		#define STR0005 "ALADI"
	#else
		#define STR0001 "Ordem"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Cod.naladi/sh", "Cod.NALADI/SH" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Normas De Origem", "Normas de Origem" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "ALADI", "Aladi" )
	#endif
#endif
