#ifdef SPANISH
	#define STR0001 "AGUARDANDO CRUCE EN FRONTERA"
	#define STR0002 "Intervalo sin datos para impresion"
	#define STR0003 "Aviso"
	#define STR0004 "Fecha Inicial"
	#define STR0005 "Fecha Final"
	#define STR0006 "Realizado por"
	#define STR0007 "Fecha"
	#define STR0008 "Fecha Final no puede ser menor que Fecha Inicial"
	#define STR0009 "1-No Embarcadas"
	#define STR0010 "2-Embarcadas"
	#define STR0011 "Informe de Mercaderias Facturadas"
	#define STR0012 "Tipo de Informe"
	#define STR0013 "DE "
	#define STR0014 " A "
	#define STR0015 "A PARTIR DE "
	#define STR0016 "A "
	#define STR0017 "TODOS"
	#define STR0018 "Procesando Archivo Temporal"
	#define STR0019 "Intervalo sin datos p/ impresion"
	#define STR0020 "Imprimiendo:"
#else
	#ifdef ENGLISH
		#define STR0001 "AWAITING FOR BORDER CROSSING"
		#define STR0002 "Interval has no data to print"
		#define STR0003 "Warning"
		#define STR0004 "Initial Date"
		#define STR0005 "Final Date"
		#define STR0006 "Made by"
		#define STR0007 "Date"
		#define STR0008 "Final Date cannot be prior to the Initial Date"
		#define STR0009 "1-Not Shipped"
		#define STR0010 "2-Shipped"
		#define STR0011 "Report on Invoiced Goods"
		#define STR0012 "Report Type"
		#define STR0013 "FROM "
		#define STR0014 " TO "
		#define STR0015 "STARTING FROM "
		#define STR0016 "UNTIL "
		#define STR0017 "ALL"
		#define STR0018 "Processing Temporary File"
		#define STR0019 "Interval has no data to print"
		#define STR0020 "Printing:"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "A Aguardar Cruze Em Fonteira", "AGUARDANDO CRUZE EM FONTEIRA" )
		#define STR0002 "Intervalo sem dados para impressão"
		#define STR0003 "Aviso"
		#define STR0004 "Data Inicial"
		#define STR0005 "Data Final"
		#define STR0006 "Feito por"
		#define STR0007 "Data"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "1-não Embarcadas", "1-Nao Embarcadas" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "2-embarcadas", "2-Embarcadas" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Relatório De Mercadorias Facturadas", "Relatorio de Mercadorias Faturadas" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Tipo Do Relatório", "Tipo do Relatorio" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "De ", "DE " )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", " até ", " ATE " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "A partir de ", "A PARTIR DE " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Até ", "ATE " )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Todos", "TODOS" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "A Processar Ficheiro Temporário", "Processando Arquivo Temporario" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Intervalo sem dados p/ impressão", "Intervalo sem dados p/ impressao" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "A imprimir:", "Imprimindo:" )
	#endif
#endif
