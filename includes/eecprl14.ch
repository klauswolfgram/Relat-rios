#ifdef SPANISH
	#define STR0001 "No Embarcados"
	#define STR0002 "Embarcados"
	#define STR0003 "Informe de Embarques"
	#define STR0004 "Intervalo sin datos para impresion"
	#define STR0005 "Aviso"
	#define STR0006 " a "
	#define STR0007 "Todos"
	#define STR0008 "Imprimiendo: "
	#define STR0009 "Opciones:"
	#define STR0010 "Fecha Inicial"
	#define STR0011 "Fecha Final"
	#define STR0012 "Fecha Final no puede ser menor que Fecha Inicial"
#else
	#ifdef ENGLISH
		#define STR0001 "Not Shipped"
		#define STR0002 "Shipped"
		#define STR0003 "Shipment Report"
		#define STR0004 "Interval without data for printing"
		#define STR0005 "Warning"
		#define STR0006 " to "
		#define STR0007 "All"
		#define STR0008 "Printing: "
		#define STR0009 "Options:"
		#define STR0010 "Initial Date"
		#define STR0011 "Final Date"
		#define STR0012 "Final Date cannot be lower than Initial Date"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Não Embarcados", "Nao Embarcados" )
		#define STR0002 "Embarcados"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Relatório De Embfichues", "Relatório de Embarques" )
		#define STR0004 "Intervalo sem dados para impressão"
		#define STR0005 "Aviso"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", " até ", " ate " )
		#define STR0007 "Todos"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "A imprimir: ", "Imprimindo: " )
		#define STR0009 "Opções:"
		#define STR0010 "Data Inicial"
		#define STR0011 "Data Final"
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
	#endif
#endif
