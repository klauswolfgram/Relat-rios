#ifdef SPANISH
	#define STR0001 " A "
	#define STR0002 "Intervalo sin datos para impresion"
	#define STR0003 "Aviso"
	#define STR0004 "Fecha Inicial"
	#define STR0005 "Fecha Final"
	#define STR0006 "Proveedor"
	#define STR0007 "Remarks"
	#define STR0008 "Fecha Final no puede ser menor que Fecha Inicial"
#else
	#ifdef ENGLISH
		#define STR0001 " TO "
		#define STR0002 "Interval without data for printing"
		#define STR0003 "Warning"
		#define STR0004 "Initial Date"
		#define STR0005 "Final Date"
		#define STR0006 "Supplier"
		#define STR0007 "Remarks"
		#define STR0008 "Final Date cannot be lower than Initial Date"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", " até ", " ATE " )
		#define STR0002 "Intervalo sem dados para impressão"
		#define STR0003 "Aviso"
		#define STR0004 "Data Inicial"
		#define STR0005 "Data Final"
		#define STR0006 "Fornecedor"
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Observações", "Remarks" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
	#endif
#endif
