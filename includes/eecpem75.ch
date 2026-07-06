#ifdef SPANISH
	#define STR0001 "Package"
	#define STR0002 "Ctd. Emb. Descripcion"
	#define STR0003 "Criterio de Origen"
	#define STR0004 "Peso Bruto"
	#define STR0005 "Factura / Fecha"
	#define STR0006 "GSTP"
	#define STR0007 "Orden"
#else
	#ifdef ENGLISH
		#define STR0001 "Package"
		#define STR0002 "Qty.Pkg.Description"
		#define STR0003 "Origin Criterion"
		#define STR0004 "Gross weight"
		#define STR0005 "Bill N./Date"
		#define STR0006 "GSTP"
		#define STR0007 "Order"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Embalagem", "Package" )
		#define STR0002 "Qtd. Emb. Descrição"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Critério De Origem", "Critério de Origem" )
		#define STR0004 "Peso Bruto"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "N.factura/data", "N.Fatura/Data" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Gstp", "GSTP" )
		#define STR0007 "Ordem"
	#endif
#endif
