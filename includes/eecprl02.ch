#ifdef SPANISH
	#define STR0001 "Intervalo sin datos para impresion"
	#define STR0002 "Aviso"
	#define STR0003 "Fecha Inicial"
	#define STR0004 "Fecha Final"
	#define STR0005 "Pais"
	#define STR0006 "Familia"
	#define STR0007 "Cliente"
	#define STR0008 "Producto"
	#define STR0009 "Destinatario"
	#define STR0010 "Fax"
	#define STR0011 "Copia 1 para"
	#define STR0012 "Fax 1"
	#define STR0013 "Copia 2 para"
	#define STR0014 "Fax 2"
	#define STR0015 "Fecha Final no puede ser menor que Fecha Inicial"
#else
	#ifdef ENGLISH
		#define STR0001 "Interval without data for printing"
		#define STR0002 "Warning"
		#define STR0003 "Initial Date"
		#define STR0004 "Final Date"
		#define STR0005 "Country"
		#define STR0006 "Family"
		#define STR0007 "Customer"
		#define STR0008 "Product"
		#define STR0009 "Receiver"
		#define STR0010 "Fax"
		#define STR0011 "Copy 1 to"
		#define STR0012 "Fax 1"
		#define STR0013 "Copy 2 to"
		#define STR0014 "Fax 2"
		#define STR0015 "Final Date cannot be lower than Initial Date"
	#else
		#define STR0001 "Intervalo sem dados para impressão"
		#define STR0002 "Aviso"
		#define STR0003 "Data Inicial"
		#define STR0004 "Data Final"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "País", "Pais" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Família", "Familia" )
		#define STR0007 "Cliente"
		#define STR0008 "Produto"
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Destinatário", "Destinatario" )
		#define STR0010 "Fax"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Cópia 1 para", "Copia 1 para" )
		#define STR0012 "Fax 1"
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Cópia 2 para", "Copia 2 para" )
		#define STR0014 "Fax 2"
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
	#endif
#endif
