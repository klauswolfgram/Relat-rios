#ifdef SPANISH
	#define STR0001 "Procesando Archivo Temporal"
	#define STR0002 "Imprimiendo archivos ..."
	#define STR0003 "Intervalo sin datos para impresion"
	#define STR0004 "Aviso"
	#define STR0005 "Imprimiendo: "
	#define STR0006 "Importador"
	#define STR0007 "Descripcion"
	#define STR0008 "Moneda"
	#define STR0009 "Todos"
	#define STR0010 "Todas"
	#define STR0011 "¡Importador Invalido! "
	#define STR0012 "Seleccionar un Importador que este registrado como "
	#define STR0013 "¡Importador o Todos!"
#else
	#ifdef ENGLISH
		#define STR0001 "Processing temporary file     "
		#define STR0002 "Printing records...     "
		#define STR0003 "Range without data to be printed  "
		#define STR0004 "Warn "
		#define STR0005 "Printing:   "
		#define STR0006 "Importer  "
		#define STR0007 "Descript."
		#define STR0008 "Currency"
		#define STR0009 "All  "
		#define STR0010 "All  "
		#define STR0011 "Invalid importer!    "
		#define STR0012 "Select an importer registered as                    "
		#define STR0013 "Importer or all!    "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "A Processar Ficheiro Temporário", "Processando Arquivo Temporario" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "A imprimir os registos ...", "Imprimindo registros ..." )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Intervalo sem dados para impressão", "Intervalo sem dados para impressäo" )
		#define STR0004 "Aviso"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "A imprimir: ", "Imprimindo: " )
		#define STR0006 "Importador"
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricäo" )
		#define STR0008 "Moeda"
		#define STR0009 "Todos"
		#define STR0010 "Todas"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Importador inválido! ", "Importador Invalido! " )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Seleccionar um importador que esteja registado como ", "Selecionar um Importador que esteja cadastrado como " )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Importador Ou Todos!", "Importador ou Todos!" )
	#endif
#endif
