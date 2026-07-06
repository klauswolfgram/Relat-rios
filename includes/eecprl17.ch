#ifdef SPANISH
	#define STR0001 "Espere"
	#define STR0002 "Grabando archivo temporal..."
	#define STR0003 "Intervalo sin datos para impresion"
	#define STR0004 "Aviso"
	#define STR0005 "Procesando Archivo Temporal"
	#define STR0006 "Generando informe ..."
	#define STR0007 "Fecha Final no puede ser menor que Fecha Inicial"
	#define STR0008 "Importador"
	#define STR0009 "Fecha Inicial"
	#define STR0010 "Fecha Final"
	#define STR0011 "ALL"
	#define STR0012 " TO "
	#define STR0013 "Periodo"
	#define STR0014 "Moneda"
	#define STR0015 "Descripcion"
	#define STR0016 "¡Importador Invalido! "
	#define STR0017 "Seleccionar un Importador que este registrado como "
	#define STR0018 "¡Importador o Todos!"
	#define STR0019 "International Receivable Account Statement"
#else
	#ifdef ENGLISH
		#define STR0001 "Please, wait..."
		#define STR0002 "Saving temporary file........."
		#define STR0003 "Interval without data for printing"
		#define STR0004 "Warning"
		#define STR0005 "Processing Temporary File"
		#define STR0006 "Generating report ..."
		#define STR0007 "Final Date cannot be lower than Initial Date"
		#define STR0008 "Importer"
		#define STR0009 "Initial Date"
		#define STR0010 "Final Date"
		#define STR0011 "ALL"
		#define STR0012 " TO "
		#define STR0013 "Period"
		#define STR0014 "Currency"
		#define STR0015 "Descrption"
		#define STR0016 "Invalid importer!    "
		#define STR0017 "Select an importer registered as                    "
		#define STR0018 "Importer or All!    "
		#define STR0019 "International Receivable Account Statement"
	#else
		#define STR0001 "Aguarde"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "A gravar ficheiro temporário...", "Gravando arquivo temporário..." )
		#define STR0003 "Intervalo sem dados para impressão"
		#define STR0004 "Aviso"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "A Processar Ficheiro Temporário", "Processando Arquivo Temporario" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "A criar relatório ...", "Gerando relatório ..." )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final Não Pode Ser Menor Que Data Inicial" )
		#define STR0008 "Importador"
		#define STR0009 "Data Inicial"
		#define STR0010 "Data Final"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "All", "ALL" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", " to ", " TO " )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Período", "Periodo" )
		#define STR0014 "Moeda"
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricäo" )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Importador inválido! ", "Importador Invalido! " )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Seleccionar um importador que esteja registado como ", "Selecionar um Importador que esteja cadastrado como " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Importador Ou Todos!", "Importador ou Todos!" )
		#define STR0019 "International Receivable Account Statement"
	#endif
#endif
