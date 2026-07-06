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
	#define STR0010 "No se encontraron datos para impresion."
	#define STR0011 "Atencion"
#else
	#ifdef ENGLISH
		#define STR0001 "Packing List Printing"
		#define STR0002 "Packing List"
		#define STR0003 "Parameters"
		#define STR0004 "Signature"
		#define STR0005 "Details"
		#define STR0006 "Unit of measurement"
		#define STR0007 "Responsible"
		#define STR0008 "Company"
		#define STR0009 "Position"
		#define STR0010 "No data found to print."
		#define STR0011 "Attention"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Impressão Da Lista De Embalagem", "Impressão do Packing List" )
		#define STR0002 "Packing List"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Parâmetros", "Parametros" )
		#define STR0004 "Assinatura"
		#define STR0005 "Detalhes"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Unidade De Medida", "Unidade de Medida" )
		#define STR0007 "Responsável"
		#define STR0008 "Empresa"
		#define STR0009 "Cargo"
		#define STR0010 "Não foram encontrados dados para impressão."
		#define STR0011 "Atenção"
	#endif
#endif
