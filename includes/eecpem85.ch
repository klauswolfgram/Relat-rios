#ifdef SPANISH
	#define STR0001 "Impresion del Packing List"
	#define STR0002 "Packing List"
	#define STR0003 "Parametros"
	#define STR0004 "Firma"
	#define STR0005 "Detalles"
	#define STR0006 "Unidad de Medida"
	#define STR0007 "Responsable"
	#define STR0008 "Empresa"
	#define STR0009 "Cargo"
	#define STR0010 "No se encontraron datos para la impresion."
	#define STR0011 "Atencion"
#else
	#ifdef ENGLISH
		#define STR0001 "Packing List Printing"
		#define STR0002 "Packing List"
		#define STR0003 "Parameters"
		#define STR0004 "Signature"
		#define STR0005 "Details"
		#define STR0006 "Unit of Measurement"
		#define STR0007 "Responsible Party"
		#define STR0008 "Company"
		#define STR0009 "Position"
		#define STR0010 "No data was found for printing."
		#define STR0011 "Attention"
	#else
		#define STR0001 "Impressão do Packing List"
		#define STR0002 "Packing List"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Parâmetros", "Parametros" )
		#define STR0004 "Assinatura"
		#define STR0005 "Detalhes"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Unidade de medida", "Unidade de Medida" )
		#define STR0007 "Responsável"
		#define STR0008 "Empresa"
		#define STR0009 "Cargo"
		#define STR0010 "Não foram encontrados dados para impressão."
		#define STR0011 "Atenção"
	#endif
#endif
