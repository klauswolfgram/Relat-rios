#ifdef SPANISH
	#define STR0001 "Orden"
	#define STR0002 "Codigo NCM"
	#define STR0003 "Descripcion"
	#define STR0004 "Peso Neto o Cant."
	#define STR0005 "Valor FOB en Dolar"
	#define STR0006 "Normas de Origen"
	#define STR0007 "Mercosur"
#else
	#ifdef ENGLISH
		#define STR0001 "Order"
		#define STR0002 "NCM code"
		#define STR0003 "Description"
		#define STR0004 "Net Weight or Qty."
		#define STR0005 "FOB amount in Dollars"
		#define STR0006 "Norms of Origin"
		#define STR0007 "Mercosur"
	#else
		#define STR0001 "Ordem"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Código NCM", "Codigo NCM" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Peso Liq. Ou Qtde.", "Peso Liq. ou Qtde." )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Valor Fob Em Dolar", "Valor Fob em Dolar" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Normas De Origem", "Normas de Origem" )
		#define STR0007 "Mercosul"
	#endif
#endif
