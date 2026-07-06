#ifdef SPANISH
	#define STR0001 "CP "
	#define STR0002 "Firmante"
#else
	#ifdef ENGLISH
		#define STR0001 "ZIP CODE "
		#define STR0002 "Subscriber"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Código postal ", "CEP " )
		#define STR0002 "Assinante"
	#endif
#endif
