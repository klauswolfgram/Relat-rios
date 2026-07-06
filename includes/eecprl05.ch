#ifdef SPANISH
	#define STR0001 "TODOS"
	#define STR0002 " A "
	#define STR0003 " A "
	#define STR0004 "Intervalo sin datos para impresion"
	#define STR0005 "Aviso"
	#define STR0006 "Fecha Inicial"
	#define STR0007 "Fecha Final"
	#define STR0008 "Fabricante"
	#define STR0009 "Exportador"
	#define STR0010 "R. E."
	#define STR0011 "S. D."
	#define STR0012 "Fecha Final no puede ser menor que Fecha Inicial"
#else
	#ifdef ENGLISH
		#define STR0001 "ALL"
		#define STR0002 " TO "
		#define STR0003 " TO "
		#define STR0004 "Interval without data for printing"
		#define STR0005 "Warning"
		#define STR0006 "Initial Date"
		#define STR0007 "Final Date"
		#define STR0008 "Manufacturer"
		#define STR0009 "Exporter"
		#define STR0010 "R.E."
		#define STR0011 "S.D."
		#define STR0012 "Final Date cannot be lower than Initial Date"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Todos", "TODOS" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", " até ", " ATE " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", " a ", " A " )
		#define STR0004 "Intervalo sem dados para impressão"
		#define STR0005 "Aviso"
		#define STR0006 "Data Inicial"
		#define STR0007 "Data Final"
		#define STR0008 "Fabricante"
		#define STR0009 "Exportador"
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "R.e.", "R.E." )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "S.d.", "S.D." )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
	#endif
#endif
