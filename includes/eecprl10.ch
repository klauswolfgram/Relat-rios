#ifdef SPANISH
	#define STR0001 "NO"
	#define STR0002 "SI"
	#define STR0003 "Proceso"
	#define STR0004 "Volumen"
	#define STR0005 "Pendiente"
#else
	#ifdef ENGLISH
		#define STR0001 "NO"
		#define STR0002 "YES"
		#define STR0003 "No actions/documents to be printed."
		#define STR0004 "Note"
		#define STR0005 "Pending"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Não", "NAO" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Sim", "SIM" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Não existem actividades/documentos a ser impressos.", "Nao ha atividades/documentos a serem impressos." )
		#define STR0004 "Aviso"
		#define STR0005 "Pendente"
	#endif
#endif
