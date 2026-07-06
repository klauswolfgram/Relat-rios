#ifdef SPANISH
	#define STR0001 "Unidad de medida "
	#define STR0002 " no registrada en "
	#define STR0003 "Aviso"
	#define STR0004 "Configuraciones"
	#define STR0005 "Unidades de Medida"
	#define STR0006 "U. M. Ctd.:"
	#define STR0007 "U. M. Peso:"
#else
	#ifdef ENGLISH
		#define STR0001 "Unit of Measure "
		#define STR0002 " not registered in "
		#define STR0003 "Warning"
		#define STR0004 "Configurations"
		#define STR0005 "Unit of Measurement"
		#define STR0006 "Qty. U.M. :"
		#define STR0007 "Weight U.M. :"
	#else
		#define STR0001 "Unidade de medida "
		#define STR0002 If( cPaisLoc $ "ANG|PTG", " não registada em ", " nao cadastrada em " )
		#define STR0003 "Aviso"
		#define STR0004 "Configurações"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Unidades De Medida", "Unidades de Medida" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "U.m. Qtde.:", "U.M. Qtde.:" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "U.m. Peso.:", "U.M. Peso.:" )
	#endif
#endif
