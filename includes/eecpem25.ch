#ifdef SPANISH
	#define STR0001 "No existe Aseguradora para este Proceso"
	#define STR0002 "Atencion"
	#define STR0003 "N/ REFERENCIA.: "
	#define STR0004 "MERCADERIA"
	#define STR0005 " EMBALAJE                 CANTIDAD"
	#define STR0006 "MOD. EMBARQUE: "
	#define STR0007 "DESTINO......: "
	#define STR0008 "BARCO........: "
	#define STR0009 "VALOR "
	#define STR0010 "TASA.........: "
	#define STR0011 "SALUDOS,"
	#define STR0012 "Tasa"
#else
	#ifdef ENGLISH
		#define STR0001 "There is no Insurance Company for this Process"
		#define STR0002 "Warning"
		#define STR0003 "REFERENCE NO.:  "
		#define STR0004 "GGODS"
		#define STR0005 " PACKAGE                      QUANTITY  "
		#define STR0006 "SHIPMENT CATEGORY:  "
		#define STR0007 "TARGET......: "
		#define STR0008 "SHIP........: "
		#define STR0009 "VALUE "
		#define STR0010 "RATE.........: "
		#define STR0011 "REGARDS,"
		#define STR0012 "Rate"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Não Existe Seguradora Para Este Processo", "Não existe Seguradora para este Processo" )
		#define STR0002 "Atenção"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "N/referência.: ", "N/REFERENCIA.: " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Mercadoria", "MERCADORIA" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", " Embalagem                 Quantidade", " EMBALAGEM                 QUANTIDADE" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Mod. embfichue: ", "MOD. EMBARQUE: " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Destino......: ", "DESTINO......: " )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Navio........: ", "NAVIO........: " )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Valor ", "VALOR " )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Taxa.........: ", "TAXA.........: " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Cumprimentos,", "SAUDACOES," )
		#define STR0012 "Taxa"
	#endif
#endif
