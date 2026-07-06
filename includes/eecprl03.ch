#ifdef SPANISH
	#define STR0001 "Produto + Medio"
	#define STR0002 "Fabricante + Local de Destino"
	#define STR0003 "Codigo"
	#define STR0004 "Descripcion"
	#define STR0005 "TODOS"
	#define STR0006 " A "
	#define STR0007 "Intervalo sin datos para impresion"
	#define STR0008 "Aviso"
	#define STR0009 "Fecha Inicial"
	#define STR0010 "Fecha Final"
	#define STR0011 "Puerto Destino"
	#define STR0012 "Fabricante"
	#define STR0013 "Exportador"
	#define STR0014 "Familia"
	#define STR0015 "Producto"
	#define STR0016 "Orden"
	#define STR0017 "Fecha Final no puede ser menor que Fecha Inicial"
#else
	#ifdef ENGLISH
		#define STR0001 "Product + Via"
		#define STR0002 "Manufacturer + Target Place"
		#define STR0003 "Code"
		#define STR0004 "Description"
		#define STR0005 "ALL"
		#define STR0006 " TO "
		#define STR0007 "Interval without data for printing"
		#define STR0008 "Warning"
		#define STR0009 "Initial Date"
		#define STR0010 "Final Date"
		#define STR0011 "Target Harbor"
		#define STR0012 "Manufacturer"
		#define STR0013 "Exporter"
		#define STR0014 "Family"
		#define STR0015 "Product"
		#define STR0016 "Sequence"
		#define STR0017 "Final Date cannot be lower than Initial Date"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Artigo + Via", "Produto + Via" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Fabricante + Local De Destino", "Fabricante + Local de Destino" )
		#define STR0003 "Código"
		#define STR0004 "Descrição"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Todos", "TODOS" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", " até ", " ATE " )
		#define STR0007 "Intervalo sem dados para impressão"
		#define STR0008 "Aviso"
		#define STR0009 "Data Inicial"
		#define STR0010 "Data Final"
		#define STR0011 "Porto Destino"
		#define STR0012 "Fabricante"
		#define STR0013 "Exportador"
		#define STR0014 "Família"
		#define STR0015 "Produto"
		#define STR0016 "Ordem"
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
	#endif
#endif
