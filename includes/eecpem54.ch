#ifdef SPANISH
	#define STR0001 "Unidad de medida "
	#define STR0002 " no registrada en "
	#define STR0003 "Aviso"
#else
	#ifdef ENGLISH
		#define STR0001 "Unit of Measure "
		#define STR0002 " not registered on "
		#define STR0003 "Warning"
	#else
		#define STR0001 "Unidade de medida "
		#define STR0002 If( cPaisLoc $ "ANG|PTG", " não registada em ", " nao cadastrada em " )
		#define STR0003 "Aviso"
	#endif
#endif
