#ifdef SPANISH
	#define STR0001 "Denominacion de las Mercaderias"
	#define STR0002 "Comun FIEP"
#else
	#ifdef ENGLISH
		#define STR0001 "Denomination of Goods"
		#define STR0002 "Common FIEP"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Denominação Das Mercadorias", "Denominação das Mercadorias" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Comum Fiep", "Comum FIEP" )
	#endif
#endif
