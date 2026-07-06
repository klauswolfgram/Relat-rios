#ifdef SPANISH
	#define STR0001 "REF: N/EXPORTACION: "
	#define STR0002 "     CLIENTE.....: "
	#define STR0003 "     PAIS........: "
	#define STR0004 "Para ATENCION DEL Pedido DE EXPORTACION EN REFERENCIA ENVIAR"
	#define STR0005 "A ESTE SECTOR CERTIFICADO DE ANALISIS."
	#define STR0006 " PRODUCTO                                           LOTE"
	#define STR0007 " -------                                           ----"
	#define STR0008 "OBS: LOS ANTERIORES CERTIFICADOS DEBEN SER EMITIDOS EN EL PLAZO MAXIMO DE 48 HORAS."
	#define STR0009 "     POR FAVOR ENVIAR ORIGINALES MEDIANTE SACO POSTAL."
#else
	#ifdef ENGLISH
		#define STR0001 "REF: EXPORT NO.: "
		#define STR0002 "     CUSTOMER.....: "
		#define STR0003 "     COUNTRY........: "
		#define STR0004 "FOR A BETTER EXPORT ORDER SERVICE, SEND THE ANALYSIS REPORT"
		#define STR0005 "TO THIS DEPARTMENT."
		#define STR0006 " PRODUCT                                           LOT"
		#define STR0007 " -------                                           ----"
		#define STR0008 "NOTE: THE ABOVE CERTIFICATES SHOULD BE ISSUED AT A MAXIMUM TERM OF 48 HOURS."
		#define STR0009 "     PLEASE SEND THE ORIGINAL ONES BY SMALL TRUNK."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Ref.: n/exportação: ", "REF: N/EXPORTACAO: " )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "     cliente.....: ", "     CLIENTE.....: " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "     país........: ", "     PAIS........: " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Para Atendimento Do Pedido De Exportação Em Referência Enviar", "PARA ATENDIMENTO DO PEDIDO DE EXPORTACAO EM REFERENCIA ENVIAR" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "A Este Departamento Relatório De Análise.", "A ESTE DEPARTAMENTO LAUDO DE ANALISE." )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", " Artigo                                           Lote", " PRODUTO                                           LOTE" )
		#define STR0007 " -------                                           ----"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Obs.: Os Certificados Acima Deverão Ser Emitidos No Prazo Máximo De 48 Horas.", "OBS: OS CERTIFICADOS ACIMA DEVERAO SER EMITIDOS NO PRAZO MAXIMO DE 48 HORAS." )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "     Por Favor Enviar Originais Via Malote.", "     FAVOR ENVIAR ORIGINAIS VIA MALOTE." )
	#endif
#endif
