#ifdef SPANISH
	#define STR0001 "Procesando Archivo Temporal"
	#define STR0002 "Imprimiendo registros ..."
	#define STR0003 "Intervalo sin datos para impresion"
	#define STR0004 "Aviso"
	#define STR0005 "De Vencimientos "
	#define STR0006 "  A  "
	#define STR0007 "Vencimientos a partir de  "
	#define STR0008 "A Vencimientos "
	#define STR0009 "Todos"
	#define STR0010 "Imprimiendo: "
	#define STR0011 "Fecha Inicial"
	#define STR0012 "Fecha Final"
	#define STR0013 "Fecha Final no puede ser menor que Fecha Inicial"
	#define STR0014 "Tasa PTAX"
	#define STR0015 "Moneda"
	#define STR0016 "Importador"
	#define STR0017 "Descripcion"
	#define STR0018 "Todas"
	#define STR0019 "¡Importador Invalido! "
	#define STR0020 "Seleccionar un Importador que este registrado como "
	#define STR0021 "¡Importador o Todos!"
#else
	#ifdef ENGLISH
		#define STR0001 "Processing Temporary File"
		#define STR0002 "Printing records ..."
		#define STR0003 "Interval without data for printing"
		#define STR0004 "Warning"
		#define STR0005 "Due Dates from  "
		#define STR0006 "  To  "
		#define STR0007 "Due Dates from  "
		#define STR0008 "Due dates until  "
		#define STR0009 "All"
		#define STR0010 "Printing: "
		#define STR0011 "Initial Date"
		#define STR0012 "Final Date"
		#define STR0013 "Final Date cannot be lower than Initial Date"
		#define STR0014 "RATE PTAX"
		#define STR0015 "Currency"
		#define STR0016 "Importer  "
		#define STR0017 "Descript."
		#define STR0018 "All  "
		#define STR0019 "invalid importer!     "
		#define STR0020 "Select an importer registered as                    "
		#define STR0021 "Importer or All!    "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "A Processar Ficheiro Temporário", "Processando Arquivo Temporario" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "A imprimir os registos ...", "Imprimindo registros ..." )
		#define STR0003 "Intervalo sem dados para impressão"
		#define STR0004 "Aviso"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", " vencimentos de", "Vencimentos de  " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "  até  ", "  Até  " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Vencimentos a partir de", "Vencimentos a partir de  " )
		#define STR0008 "Vencimentos até  "
		#define STR0009 "Todos"
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "A imprimir: ", "Imprimindo: " )
		#define STR0011 "Data Inicial"
		#define STR0012 "Data Final"
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Taxa Ptax", "Taxa PTAX" )
		#define STR0015 "Moeda"
		#define STR0016 "Importador"
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricäo" )
		#define STR0018 "Todas"
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Importador inválido! ", "Importador Invalido! " )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Seleccionar um importador que esteja registado como ", "Selecionar um Importador que esteja cadastrado como " )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Importador Ou Todos!", "Importador ou Todos!" )
	#endif
#endif
