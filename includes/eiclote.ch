#ifdef SPANISH
	#define STR0002 "PGI: "
	#define STR0003 "PO: "
	#define STR0004 "CC: "
	#define STR0005 "SI: "
	#define STR0006 "Cod. Item: "
	#define STR0007 "Ctd: "
	#define STR0008 "Atencion"
	#define STR0009 "Lote            Cantidad   Validez"
	#define STR0010 "=============== =============== ========"
	#define STR0011 "Comprobando Lotes, Item: "
#else
	#ifdef ENGLISH
		#define STR0002 "PGI: "
		#define STR0003 "PO: "
		#define STR0004 "CC: "
		#define STR0005 "SI: "
		#define STR0006 "Item Code: "
		#define STR0007 "Qtty: "
		#define STR0008 "Attention"
		#define STR0009 "Lot               Quantity Maturity"
		#define STR0010 "========== =============== ========"
		#define STR0011 "Checking Lots, Item: "
	#else
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Pgi: ", "PGI: " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Encomenda: ", "PO: " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Cc: ", "CC: " )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Si: ", "SI: " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Cód.item: ", "Cod.Item: " )
		#define STR0007 "Qtde: "
		#define STR0008 "Atenção"
		#define STR0009 "Lote            Quantidade Validade"
		#define STR0010 "=============== =============== ========"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "A verificar lotes, elemento: ", "Verificando Lotes, Item: " )
	#endif
#endif
