#ifdef SPANISH
	#define STR0001 "FAC SIMILE NUMBER: "
	#define STR0002 "FECHA: "
	#define STR0003 "PARA: "
	#define STR0004 "ATTN: "
	#define STR0005 "DE  : "
	#define STR0006 "NUMERO TOTAL DE PAGINAS INCLUYENDO LA PORTADA: 1"
	#define STR0007 "MENSAJE"
	#define STR0008 "REF.: N/EXPORTACION: "
	#define STR0009 "      CLIENTE.....: "
	#define STR0010 "POR FAVOR PALETIZAR Y PLASTIFICAR LOS PRODUCTOS RELACIONADOS A CONTINUACION:"
	#define STR0011 "PRODUCTO"
	#define STR0012 "CANTIDAD"
	#define STR0013 "LOTE "
	#define STR0014 "EMBARQUE PREVISTO: "
	#define STR0015 "TRANSPORTADOR / BARCO: "
	#define STR0016 "OBSERVACIONES:"
	#define STR0017 "RESERVA  NUM: "
	#define STR0018 "DE EMBARQUE: "
	#define STR0019 "CONFECCIONAR "
	#define STR0020 "SALUDOS,"
	#define STR0021 " SI USTED NO RECIBE TODAS LAS PAGINAS, POR FAVOR LLAME AL TELEFONO "
	#define STR0022 "MARCAS: "
#else
	#ifdef ENGLISH
		#define STR0001 "FAC SIMILE NUMBER: "
		#define STR0002 "DATE: "
		#define STR0003 "TO  : "
		#define STR0004 "ATTN: "
		#define STR0005 "FROM: "
		#define STR0006 "TOTAL NUMBER PAGES INCLUDING THIS COVER: 1"
		#define STR0007 "MESSAGE"
		#define STR0008 "REF.: EXPORT NO.: "
		#define STR0009 "      CUSTOMER.....: "
		#define STR0010 "PLEASE PALLETIZE AND PLASTIFY THE PRODUCTS BELOW MENTIONED:"
		#define STR0011 "PRODUCT"
		#define STR0012 "QUANTITY"
		#define STR0013 "LOT "
		#define STR0014 "ESTIMATED SHIPMENT: "
		#define STR0015 "CARRIER / SHIP: "
		#define STR0016 "NOTES:"
		#define STR0017 "RESERVATION NO.:   "
		#define STR0018 "SHIPMENT FROM:  "
		#define STR0019 "SET UP "
		#define STR0020 "REGARDS,"
		#define STR0021 " IF YOU DO NOT RECEIVE ALL PAGES, PLEASE CALL US PHONE "
		#define STR0022 "TRADEMARKS: "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Número do fac simile: ", "FAC SIMILE NUMBER: " )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Data: ", "DATE: " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Para  : ", "TO  : " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Atn.: ", "ATTN: " )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "De: ", "FROM: " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Número total de páginas incluindo esta: 1", "TOTAL NUMBER PAGES INCLUDING THIS COVER: 1" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Mensagem", "MESSAGE" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Ref.: n/exportação: ", "REF.: N/EXPORTACAO: " )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "      cliente.....: ", "      CLIENTE.....: " )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Por Favor Coloque Em Paletes E Plastifique Os Artigos Abaixo Relacionados:", "FAVOR PALETIZAR E PLASTIFICAR OS PRODUTOS ABAIXO RELACIONADOS:" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Artigo", "PRODUCT" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Quantidade", "QUANTITY" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Lote ", "LOTE " )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Embfichue previsto: ", "EMBARQUE PREVISTO: " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Transportadora / navio: ", "TRANSPORTADORA / NAVIO: " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Observações:", "OBSERVACOES:" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Reserva  nr.: ", "RESERVA  NR: " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Embfichue de: ", "EMBARQUE DE: " )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Confeccionar ", "CONFECCIONAR " )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Cumprimentos,", "SAUDACOES," )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", " se não receber todas as páginas, por favor ligue-nos ", " IF YOU NOT RECEIVE ALL PAGES, PLEASE CALL US PHONE " )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Marcas: ", "MARCAS: " )
	#endif
#endif
