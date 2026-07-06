#ifdef SPANISH
	#define STR0001 "CP "
	#define STR0002 "Empresa"
	#define STR0003 "Contacto"
	#define STR0004 "Firmante"
#else
	#ifdef ENGLISH
		#define STR0001 "ZIP CODE "
		#define STR0002 "Company"
		#define STR0003 "Contact"
		#define STR0004 "Subscriber"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Código postal ", "CEP " )
		#define STR0002 "Empresa"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Contacto", "Contato" )
		#define STR0004 "Assinante"
	#endif
#endif
