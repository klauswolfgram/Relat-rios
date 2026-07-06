#ifdef SPANISH
	#define STR0001 "Impresion Lista Empaque"
#else
	#ifdef ENGLISH
		#define STR0001 "Packing List Printing"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Impressão da lista de embalagem", "Impressão do Packing List" )
	#endif
#endif
