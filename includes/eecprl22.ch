#ifdef SPANISH
	#define STR0001 "El informe de calculo previo no podra generarse."
	#define STR0002 "Detalles:"
	#define STR0003 "El entorno no dispone del proceso de calculo previo para la fase "
	#define STR0004 "de embarques habilitados."
	#define STR0005 "Atencion"
	#define STR0006 "No hay datos que se ajusten a estas condiciones."
	#define STR0007 "Impresion de Gastos ..."
	#define STR0008 "TODOS"
	#define STR0009 "TODAS"
	#define STR0010 "Impresion del proceso : "
	#define STR0011 "Informe de Calculo Previo"
	#define STR0012 "Filtros Iniciales"
#else
	#ifdef ENGLISH
		#define STR0001 "The Pre-Calculation report cannot be generated."
		#define STR0002 "Details: "
		#define STR0003 "Environment does not have pre-calculation treatments for the phase"
		#define STR0004 "of authorized shipments."
		#define STR0005 "Attention"
		#define STR0006 "No data available satisfying the conditions."
		#define STR0007 "Printing expenses ..."
		#define STR0008 "ALL "
		#define STR0009 "ALL "
		#define STR0010 "Printing process: "
		#define STR0011 "Pre-calculation Report"
		#define STR0012 "Initial filters "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "O relatório de pré-cálculo não poderá ser criado.", "O relatório de Pré-Calculo não poderá ser gerado." )
		#define STR0002 "Detalhes:"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "O ambiente não possui os tratamentos de pré-cálculo para a fase ", "O ambiente não possui os tratamentos de pré-calculo para a fase " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "De embarque instalados.", "de embarque habilitados." )
		#define STR0005 "Atenção"
		#define STR0006 "Não há dados que satisfaçam as condições."
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "A imprimir despesas ...", "Imprimindo Despesas ..." )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Todos", "TODOS" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Todas", "TODAS" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "A imprimir processo : ", "Imprimindo processo : " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Relatório De Pré-cálculo", "Relatório de Pré-Calculo" )
		#define STR0012 "Filtros Iniciais"
	#endif
#endif
