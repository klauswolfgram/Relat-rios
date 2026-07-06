#ifdef SPANISH
	#define STR0001 "Orden"
	#define STR0002 "Cod. NALADI / SH"
	#define STR0003 "Descripcion"
	#define STR0004 "Peso Neto o Ctd."
	#define STR0005 "Valor Fob en Dolares"
	#define STR0006 "Normas de Origen"
#else
	#ifdef ENGLISH
		#define STR0001 "Order"
		#define STR0002 "NALADI/SH Cod."
		#define STR0003 "Descriptn"
		#define STR0004 "Net Weight or Qty."
		#define STR0005 "FOBValue in Dollar"
		#define STR0006 "Norms of Origin"
	#else
		#define STR0001 "Ordem"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Cod.naladi/sh", "Cod.NALADI/SH" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Peso Liq. Ou Qtde.", "Peso Liq. ou Qtde." )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Valor Fob Em Dolar", "Valor Fob em Dolar" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Normas De Origem", "Normas de Origem" )
	#endif
#endif
