#ifdef SPANISH
	#define STR0001 " - TELEF: "
	#define STR0002 "CC  : "
	#define STR0003 "      AT: "
	#define STR0004 "      FAX: "
	#define STR0005 "FACSIMIL NUMERO: "
	#define STR0006 "FECHA: "
	#define STR0007 "PARA  : "
	#define STR0008 "ATTN: "
	#define STR0009 "DE: "
	#define STR0010 "SOLICITAMOS PROVIDENCIAR INSPECCION EN LA SIGUIENTE MERCADERIA:"
	#define STR0011 "REF. INSPECCION Nº"
	#define STR0012 "1) CLIENTE............: "
	#define STR0013 "2) PUERTO DE EMBARQUE..: "
	#define STR0014 "3) DESTINO............: "
	#define STR0015 "4) PRODUCTO............: "
	#define STR0016 "5) P. NETO ............: "
	#define STR0017 "   P. BRUTO...........: "
	#define STR0018 "6) EMBALAJE ..........: "
	#define STR0019 "7) POR CARRETERA......: "
	#define STR0020 "7) AIRFREIGHT.........: "
	#define STR0021 "7) BARCO..............: "
	#define STR0022 "8) FECHA EMBARQUE.....: "
	#define STR0023 "9) LOCAL..............: "
	#define STR0024 "10) CONTACTO..........: "
	#define STR0025 "11) FECHA PARA INSPECCION: "
	#define STR0026 "OBS. .................: ANEXO COPIA FACTURA Y PACKING LIST"
	#define STR0027 "NUESTRA REFERENCIA....: "
	#define STR0028 "ESTAMOS A SU COMPLETA DISPOSICION PARA CUALQUIER ACLARACION QUE"
	#define STR0029 "SEA NECESARIA."
	#define STR0030 "SALUDOS"
	#define STR0031 "NUESTRO FAX Nº "
	#define STR0032 "SI USTED NO RECIBE TODAS LAS PAGINAS, POR FAVOR LLAME AL "
	#define STR0033 "TELEFONO "
#else
	#ifdef ENGLISH
		#define STR0001 " - Tel.No.: "
		#define STR0002 "CC  : "
		#define STR0003 "      AT: "
		#define STR0004 "      FAX: "
		#define STR0005 "FAC SIMILE NUMBER: "
		#define STR0006 "DATE: "
		#define STR0007 "TO  : "
		#define STR0008 "ATTN: "
		#define STR0009 "FROM: "
		#define STR0010 "WE REQUEST INSPECTION ON  GOODS BELOW MENTIONED"
		#define STR0011 "INSPECTION REF.NO. "
		#define STR0012 "1) CUSTOMER............: "
		#define STR0013 "2) SHIPMENT HARBOUR..: "
		#define STR0014 "3) TARGET............: "
		#define STR0015 "4) PRODUCT............: "
		#define STR0016 "5) NET WT..........: "
		#define STR0017 "   GROSS WT........: "
		#define STR0018 "6) PACKAGE..........: "
		#define STR0019 "7) BY ROAD.........: "
		#define STR0020 "7) AIRFREIGHT.........: "
		#define STR0021 "7) SHIP..............: "
		#define STR0022 "8) SHIPMENT DATE......: "
		#define STR0023 "9) PLACE..............: "
		#define STR0024 "10) CONTACT...........: "
		#define STR0025 "11) DATE FOR INSPECTION: "
		#define STR0026 "NOTE. .................: INVOICE COPY AND  PACKING LIST ATTACHED"
		#define STR0027 "OUR REFERENCE......: "
		#define STR0028 "WE ARE AT YOUR DISPOSAL FOR ANY FURTHER INFORMATION"
		#define STR0029 "YOU REGARD BEING NECESSARY."
		#define STR0030 "REGARDS"
		#define STR0031 "OUR FAX No. "
		#define STR0032 "IF YOU DO NOT RECEIVE ALL PAGES, PLEASE CALL US "
		#define STR0033 "PHONE "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", " - telefone: ", " - FONE: " )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Cc.  : ", "CC  : " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "      at: ", "      AT: " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "      fax: ", "      FAX: " )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Número do fac simile: ", "FAC SIMILE NUMBER: " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Data: ", "DATE: " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Para  : ", "TO  : " )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Atn.: ", "ATTN: " )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "De: ", "FROM: " )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Solicitamos Providenciar Inspecção Da Mercadoria Abaixo:", "SOLICITAMOS PROVIDENCIAR INSPECAO NA MERCADORIA ABAIXO:" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Ref. inspecção nº ", "REF. INSPECAO NR " )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "1) cliente............: ", "1) CLIENTE............: " )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "2) porto de embfichue..: ", "2) PORTO DE EMBARQUE..: " )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "3) destino............: ", "3) DESTINO............: " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "4) artigo............: ", "4) PRODUTO............: " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "5) p.líquido..........: ", "5) P.LIQUIDO..........: " )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "   p. bruto...........: ", "   P. BRUTO...........: " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "6) embalagem..........: ", "6) EMBALAGEM..........: " )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "7) rodoviário.........: ", "7) RODOVIARIO.........: " )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "7) transporte aéreo.........: ", "7) AIRFREIGHT.........: " )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "7) navio..............: ", "7) NAVIO..............: " )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "8) data embfichue......: ", "8) DATA EMBARQUE......: " )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "9) local..............: ", "9) LOCAL..............: " )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "10) contacto...........: ", "10) CONTATO...........: " )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "11) data para inspecção: ", "11) DATA PARA INSPECAO: " )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Obs. .................: Anexo Cópia Factura E Nota De Embalagem", "OBS. .................: ANEXO COPIA FATURA E PACKING LIST" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "Nossa referência......: ", "NOSSA REFERENCIA......: " )
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Estamos à Sua Inteira Disposição Para Quaisquer Esclarecimentos Que", "ESTAMOS A SUA INTEIRA DISPOSICAO PARA QUAISQUER ESCLARECIMENTOS QUE" )
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "Venham A Ser Necessários.", "VENHAM A SER NECESSARIOS." )
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Cumprimentos", "SAUDACOES" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Nosso fax nr. ", "NOSSO FAX NR " )
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Se não receber todas as páginas, por favor contacte-nos ", "IF YOU NOT RECEIVE ALL PAGES, PLEASE CALL US " )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "Telefone ", "PHONE " )
	#endif
#endif
