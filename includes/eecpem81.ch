#ifdef SPANISH
	#define STR0001 "Orden"
	#define STR0002 "Cod.NALADI/SH"
	#define STR0003 "Descripcion"
	#define STR0004 "Normas de Origen"
	#define STR0005 "Peru"
#else
	#ifdef ENGLISH
		#define STR0001 "Order"
		#define STR0002 "NALADI/SH Code"
		#define STR0003 "Description"
		#define STR0004 "Origin Regulations"
		#define STR0005 "Peru"
	#else
		#define STR0001 "Ordem"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Cód.NALADI/SH", "Cod.NALADI/SH" )
		#define STR0003 "Descrição"
		#define STR0004 "Normas de Origem"
		#define STR0005 "Peru"
	#endif
#endif
