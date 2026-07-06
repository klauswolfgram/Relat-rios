#ifdef SPANISH
	#define STR0001 "N.Factura"
	#define STR0002 "Ctd. Tipo Emb."
	#define STR0003 "Especificacion de las Mercaderias"
	#define STR0004 "Peso (Bruto y Neto)"
	#define STR0005 "Comun"
	#define STR0006 " KG"
	#define STR0007 " KGS"
	#define STR0008 "Item"
#else
	#ifdef ENGLISH
		#define STR0001 "Invoice No."
		#define STR0002 "Ship. Qty. Type"
		#define STR0003 "Goods Specification"
		#define STR0004 "Weight (Gross and Net)"
		#define STR0005 "Common"
		#define STR0006 " KG"
		#define STR0007 " KGS"
		#define STR0008 "Item"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "N.factura", "N.Fatura" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Qtd. Pedido Emb.", "Qtde. Tipo Emb." )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Especificação Das Mercadorias", "Especificacao das Mercadorias" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Peso (bruto E Líquido)", "Peso (Bruto e Liquido)" )
		#define STR0005 "Comum"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", " Kg", " KG" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", " Kgs", " KGS" )
		#define STR0008 "Item"
	#endif
#endif
