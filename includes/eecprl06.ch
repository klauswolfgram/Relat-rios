#ifdef SPANISH
	#define STR0001 "TODOS"
	#define STR0002 " A "
	#define STR0003 "Intervalo sin datos para impresion"
	#define STR0004 "Aviso"
	#define STR0005 "Fecha Inicial"
	#define STR0006 "Fecha Final"
	#define STR0007 "Fabricante"
	#define STR0008 "Exportador"
	#define STR0009 "P. Embarque"
	#define STR0010 "Ordenar por"
	#define STR0011 "Fecha Final no puede ser menor que Fecha Inicial"
#else
	#ifdef ENGLISH
		#define STR0001 "ALL"
		#define STR0002 " TO "
		#define STR0003 "Interval without data for printing"
		#define STR0004 "Warning"
		#define STR0005 "Initial Date"
		#define STR0006 "Final Date"
		#define STR0007 "Manufacturer"
		#define STR0008 "Exporter"
		#define STR0009 "P. Shipment"
		#define STR0010 "Order by"
		#define STR0011 "Final Date cannot be lower than Initial Date"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Todos", "TODOS" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", " até ", " ATE " )
		#define STR0003 "Intervalo sem dados para impressão"
		#define STR0004 "Aviso"
		#define STR0005 "Data Inicial"
		#define STR0006 "Data Final"
		#define STR0007 "Fabricante"
		#define STR0008 "Exportador"
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "P. Embfichue", "P. Embarque" )
		#define STR0010 "Ordenar por"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
	#endif
#endif
