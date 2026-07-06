#ifdef SPANISH
	#define STR0001 "¡Tipo de Informe invalido!"
	#define STR0002 "Aviso"
	#define STR0003 "¡No existen registros para la seleccion actual!"
	#define STR0004 "Follow-up de Cambio"
#else
	#ifdef ENGLISH
		#define STR0001 "Invalid Report Type  !"
		#define STR0002 "Warning"
		#define STR0003 "There are no records for the current selection  !"
		#define STR0004 "Exchange Follow-up"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Tipo de relatório inválido !", "Tipo de Relatório inválido !" )
		#define STR0002 "Aviso"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Não existem registos para a selecção actual !", "Não existem registros para a seleção atual !" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Follow-up De Câmbio", "Follow-up de Câmbio" )
	#endif
#endif
