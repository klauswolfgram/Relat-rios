#ifdef SPANISH
	#define STR0001 "FAC SIMILE NUMBER: "
	#define STR0002 "FECHA: "
	#define STR0003 "PARA..: "
	#define STR0004 "ATTN: "
	#define STR0005 "REF. INSPECCION: "
	#define STR0006 "DE: "
	#define STR0007 "ANEXA COPIA DE LOS DOCUMENTOS REFERENTES A LA FACTURA DE EMBARQUE. "
	#define STR0008 "FACTURA Nº  "
	#define STR0009 "PACKING LIST "
	#define STR0010 "B / L "
	#define STR0011 "CERTIFICADO ANALISIS"
	#define STR0012 "POR FAVOR PROVIDENCIAR CERTIFICADO DE INSPECCION"
	#define STR0013 "SALUDOS"
	#define STR0014 "NUESTRO FAX Nº"
	#define STR0015 "SI USTED NO RECIBE TODAS LAS PAGINAS, POR FAVOR LLAME AL"
	#define STR0016 "TELEFONO"
#else
	#ifdef ENGLISH
		#define STR0001 "FAC SIMILE NUMBER: "
		#define STR0002 "DATE: "
		#define STR0003 "TO..: "
		#define STR0004 "ATTN: "
		#define STR0005 "INSPECTION REFERENCE: "
		#define STR0006 "FROM: "
		#define STR0007 "ATTACHED DOCUMENT COPY REFERRING TO THE INVOICE SHIPMENT. "
		#define STR0008 "INVOICE NO.   "
		#define STR0009 "PACKING LIST "
		#define STR0010 "B/L "
		#define STR0011 "ANALYSIS CERTIFICATE"
		#define STR0012 "PLEASE PROVIDE THE INSPECTION CERTIFICATE"
		#define STR0013 "REGARDS"
		#define STR0014 "OUR FAX No. "
		#define STR0015 "IF YOU DO NOT RECEIVE ALL PAGES, PLEASE CALL US "
		#define STR0016 "PHONE "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Número do fac simile: ", "FAC SIMILE NUMBER: " )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Data: ", "DATE: " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "To..: ", "TO..: " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Atn.: ", "ATTN: " )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Ref. inspecção: ", "REF. INSPECAO: " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "De: ", "FROM: " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Segue em anexo cópia dos documentos referentes ao embfichue da n/fact. ", "SEGUE ANEXO COPIA DOS DOCUMENTOS REFERENTE EMBARQUE DE N/FAT. " )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Factura nr.   ", "FATURA NR.   " )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Packing list ", "PACKING LIST " )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "B/l ", "B/L " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Certificado Análise", "CERTIFICADO ANALISE" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Por Favor Providencie Declaração De Inspecção", "FAVOR PROVIDENCIAR CERTIFICADO DE INSPECAO" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Cumprimentos", "SAUDACOES" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Nosso fax nr. ", "NOSSO FAX NR " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Se não receber todas as páginas, por favor contacte-nos ", "IF YOU NOT RECEIVE ALL PAGES, PLEASE CALL US " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Telefone ", "PHONE " )
	#endif
#endif
