#ifdef SPANISH
	#define STR0001 "Importador"
	#define STR0002 "Fecha Pedido"
	#define STR0003 "Pedido"
	#define STR0004 "Plazo Entrega"
	#define STR0005 "Codigo"
	#define STR0006 "Descripcion"
	#define STR0007 "Si"
	#define STR0008 "No"
	#define STR0009 "TODOS"
	#define STR0010 " A "
	#define STR0011 "/ IMPORTADOR: "
	#define STR0012 "Intervalo sin datos para impresion"
	#define STR0013 "Aviso"
	#define STR0014 "Fecha Inicial"
	#define STR0015 "Fecha Final"
	#define STR0016 "Fabricante"
	#define STR0017 "Exportador"
	#define STR0018 "Pais Importador"
	#define STR0019 "Ordenar por"
	#define STR0020 "Producto"
	#define STR0021 "Pedidos Finiquitados"
	#define STR0022 "Fecha Final no puede ser menor que Fecha Inicial"
	#define STR0023 "Unidad del Total"
	#define STR0024 "Moneda del Total"
#else
	#ifdef ENGLISH
		#define STR0001 "Importer"
		#define STR0002 "Order Date"
		#define STR0003 "Order"
		#define STR0004 "Delivery Term"
		#define STR0005 "Code"
		#define STR0006 "Description"
		#define STR0007 "Yes"
		#define STR0008 "No"
		#define STR0009 "ALL"
		#define STR0010 " TO "
		#define STR0011 "/ IMPORTER: "
		#define STR0012 "Interval without data for printing"
		#define STR0013 "Warning"
		#define STR0014 "Initial Date"
		#define STR0015 "Final Date"
		#define STR0016 "Manufacturer"
		#define STR0017 "Exporter"
		#define STR0018 "Importing Country"
		#define STR0019 "Order by"
		#define STR0020 "Product"
		#define STR0021 "Exempt Orders"
		#define STR0022 "Final Date cannot be lower than Initial Date"
		#define STR0023 "Total unit "
		#define STR0024 "Total currency"
	#else
		#define STR0001 "Importador"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Data Do Pedido", "Data Pedido" )
		#define STR0003 "Pedido"
		#define STR0004 "Prazo Entrega"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Código", "Codigo" )
		#define STR0006 "Descrição"
		#define STR0007 "Sim"
		#define STR0008 "Não"
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Todos", "TODOS" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", " até ", " ATE " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "/ importador: ", "/ IMPORTADOR: " )
		#define STR0012 "Intervalo sem dados para impressão"
		#define STR0013 "Aviso"
		#define STR0014 "Data Inicial"
		#define STR0015 "Data Final"
		#define STR0016 "Fabricante"
		#define STR0017 "Exportador"
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "País Importador", "Pais Importador" )
		#define STR0019 "Ordenar por"
		#define STR0020 "Produto"
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Pedidos Liquidados", "Pedidos Quitados" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "Unidade Do Total", "Unidade do Total" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Moeda Do Total", "Moeda do Total" )
	#endif
#endif
