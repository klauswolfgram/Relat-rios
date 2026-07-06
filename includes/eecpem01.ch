#ifdef SPANISH
	#define STR0001 "Impresion de retirada Anulada"
	#define STR0002 "Atencion"
#else
	#ifdef ENGLISH
		#define STR0001 "Draft Printing has been cancelled  !"
		#define STR0002 "Warning"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Impressão do saque cancelada !", "Impressão do Saque cancelada !" )
		#define STR0002 "Atenção"
	#endif
#endif
