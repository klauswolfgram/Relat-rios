#ifdef SPANISH
	#define STR0001 "Emision de Instruccion de Despacho"
	#define STR0002 "Mensajes"
	#define STR0004 "Informacion"
	#define STR0006 "Enviamos con esta comunicacion, documentos referentes al despacho aduanero para que sean, tanto el transporte como el despacho, instruidos conforme los siguientes datos"
	#define STR0007 "Instruccion de Despacho"
	#define STR0008 "Imprimiendo..."
	#define STR0009 "NO SOLICITADA"
	#define STR0010 "DONDE: L. I. Nº"
	#define STR0011 "LEYENDA DE REGIMEN: "
	#define STR0012 "VALOR DEL FLETE: "
	#define STR0013 "CNPJ: "
	#define STR0014 "FORMA DE PAGO: "
	#define STR0015 "BARCO: "
	#define STR0016 "EMB.: "
	#define STR0017 "LLEG.: "
	#define STR0018 "DOCUMENTOS ADJUNTOS:"
	#define STR0019 "ATENTAMENTE,"
	#define STR0020 "DPTO. DE IMPORTACION"
	#define STR0021 "CTD."
	#define STR0022 "PRODUCTO"
	#define STR0023 "NCM"
	#define STR0024 "L. I."
	#define STR0025 "REG"
	#define STR0026 "DESTINO"
	#define STR0027 "NEC. FAB."
	#define STR0028 ' "INSTRUCCION DE DESPACHO" '
	#define STR0029 "SAO PAULO (SP),"
	#define STR0030 "PUERTO :"
	#define STR0031 "Proceso:"
	#define STR0032 "IMPORTADOR: "
	#define STR0033 "TOTAL: "
	#define STR0034 "CONHECIMENTO: "
	#define STR0035 "FACTURAS: "
	#define STR0036 "FLETE PP: "
	#define STR0037 "FLETE CC: "
	#define STR0038 "FLETE TN: "
#else
	#ifdef ENGLISH
		#define STR0001 "Dispatch Instructions Issue"
		#define STR0002 "Messages"
		#define STR0004 "Information"
		#define STR0006 "With this communication, we forward documents related to customs clearance. This way, transportation and clearance can be attached according the following data"
		#define STR0007 "Dispatch Instruction"
		#define STR0008 "Printing..."
		#define STR0009 "NOT REQUIRED"
		#define STR0010 "BEING: L.I. Nr."
		#define STR0011 "REGIMEN TITLE: "
		#define STR0012 "FREIGHT VALUE: "
		#define STR0013 "C.N.P.J.: "
		#define STR0014 "MODE OF PAYMENT: "
		#define STR0015 "SHIP: "
		#define STR0016 "PAC.: "
		#define STR0017 "ARR.: "
		#define STR0018 "ANNEX DOCUMENTS:"
		#define STR0019 "Sincerely,"
		#define STR0020 "IMPORT DEPT."
		#define STR0021 "QTTY."
		#define STR0022 "PRODUCT"
		#define STR0023 "C.N.M."
		#define STR0024 "L.I."
		#define STR0025 "REG"
		#define STR0026 "DESTINATION"
		#define STR0027 "MAN.NEC."
		#define STR0028 " 'DISPATCH INSTRUCTION' "
		#define STR0029 "SAO PAULO (SP),"
		#define STR0030 "PORT :"
		#define STR0031 "PROCESS:"
		#define STR0032 "IMPORTER: "
		#define STR0033 "TOTAL: "
		#define STR0034 "WAYBILL: "
		#define STR0035 "INVOICES: "
		#define STR0036 "PP FREIGHT: "
		#define STR0037 "CC FREIGHT: "
		#define STR0038 "TN FREIGHT: "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Emissão da instrução de despacho", "Emissão da Instrução de Despacho" )
		#define STR0002 "Mensagens"
		#define STR0004 "Informação"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Encaminhamos com esta comunicação, documentos referentes ao desembaraço aduaneiro para que o transporte e o desembaraço sejam instruídos conforme dados a seguir", "Encaminhamos com esta comunicação, documentos referentes ao desembaraço aduaneiro para que seja, o transporte e o desembaraço intruídos conforme dados a seguir" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Instrução De Envio", "Instrução de Despacho" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "A imprimir...", "Imprimindo..." )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Não Necessária", "NÃO REQUERIDA" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Sendo: L.i. Nº", "SENDO: L.I. Nr." )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Legenda de regime: ", "LEGENDA DE REGIME: " )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Valor do frete: ", "VALOR DO FRETE: " )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Nr. contribuinte.: ", "C.N.P.J.: " )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Forma de pagamento: ", "FORMA DE PAGAMENTO: " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Navio: ", "NAVIO: " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Emb.: ", "EMB.: " )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Cheg.: ", "CHEG.: " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Documentos Anexos:", "DOCUMENTOS ANEXOS:" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Atenciosamente,", "ATENCIOSAMENTE," )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Depto. de importação", "DEPTO. DE IMPORTAÇÃO" )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Qtd.", "QTD." )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Produto", "PRODUTO" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "N.c.m.", "N.C.M." )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "L.i.", "L.I." )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Reg.", "REG" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Destino", "DESTINO" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "Nec.fab.", "NEC.FAB." )
		#define STR0028 If( cPaisLoc $ "ANG|PTG", ' "INSTRUCÇÃO DE DESPACHO" ', ' "INSTRUÇÃO DE DESPACHO" ' )
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "São paulo (sp),", "SÃO PAULO (SP)," )
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Porto :", "PORTO :" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "PROCESSO:", "PROCESSO :" )
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Importador: ", "IMPORTADOR: " )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "Total: ", "TOTAL: " )
		#define STR0034 "CONHECIMENTO: "
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "FACTURAS : ", "FATURAS : " )
		#define STR0036 If( cPaisLoc $ "ANG|PTG", "Frete pp: ", "FRETE PP: " )
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "Frete cc: ", "FRETE CC: " )
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "Frete tn: ", "FRETE TN: " )
	#endif
#endif
