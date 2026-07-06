#ifdef SPANISH
	#define STR0001 "¿Integracion Efectiva?"
	#define STR0002 "Apertura de Archivos"
	#define STR0003 "Espere... Actualizando Datos"
	#define STR0004 "Espere... Verificando Pagos Anticipados"
	#define STR0005 "Generacion concluida. Haga clic en OK para continuar ..."
	#define STR0006 "Registros Procesos: "
	#define STR0007 "INVOICE SIN HEADER "
	#define STR0008 " - "
	#define STR0009 " POR FAVOR ANOTAR Y PULSAR ENTER"
	#define STR0010 "INVOICE SIN PORTADA "
	#define STR0011 " POR FAVOR ANOTAR"
	#define STR0012 "Informacion"
	#define STR0013 "No fue posible abrir el archivo "
	#define STR0014 "Atencion"
	#define STR0015 "FECHA INICIAL MAYOR QUE FECHA FINAL"
	#define STR0016 "IMPORTADOR NO REGISTRADO"
	#define STR0017 "No hay importadores seleccionados"
	#define STR0018 "Invoice : "
	#define STR0019 "Pedido : "
	#define STR0020 "¿Pregunta?"
#else
	#ifdef ENGLISH
		#define STR0001 "Effective Integration?"
		#define STR0002 "Files Opening"
		#define STR0003 "Wait...Updating Data"
		#define STR0004 "Wait... Calculating Advanced Payments"
		#define STR0005 "Generation concluded. Click OK to continue ..."
		#define STR0006 "Records Processes: "
		#define STR0007 "INVOICE W/O HEADER "
		#define STR0008 " - "
		#define STR0009 " NOTE DOWN AND PRESS ENTER"
		#define STR0010 "INVOICE W/O COVER"
		#define STR0011 " PLEASE NOTE DOWN"
		#define STR0012 "Information"
		#define STR0013 "Couldn´t open the file "
		#define STR0014 "Attention"
		#define STR0015 "INITIAL DATE HIGHER THAN FINAL DATE"
		#define STR0016 "IMPORTER NOT REGISTERED"
		#define STR0017 "There are not selected importers"
		#define STR0018 "Invoice : "
		#define STR0019 "Order : "
		#define STR0020 "Question?"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Integração efectiva ?", "Integração Efetiva ?" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Abertura De Arquivos", "Abertura de Arquivos" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Aguarde... A Actualizar Dados", "Aguarde... Atualizando Dados" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Aguarde... A Apurar Pagamentos Antecipados", "Aguarde... Apurando Pagamentos Antecipados" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Criação concluída. clique em ok para continuar ...", "Geração concluída. Clique OK para continuar ..." )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Registos processos: ", "Registros Processos: " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Factura sem cabeçalho ", "INVOICE SEM HEADER " )
		#define STR0008 " - "
		#define STR0009 If( cPaisLoc $ "ANG|PTG", " Favor Anotar E Teclar Enter", " FAVOR ANOTAR E TECLAR ENTER" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Factura sem quadro ", "INVOICE SEM CAPA " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", " Favor Anotar", " FAVOR ANOTAR" )
		#define STR0012 "Informação"
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Não foi possível abrir o ficheiro ", "Não foi possivel abrir o arquivo " )
		#define STR0014 "Atenção"
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Data Inicial Maior Que A Data Final", "DATA INICIAL MAIOR QUE A DATA FINAL" )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Importador Não Registado", "IMPORTADOR NÃO CADASTRADO" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Não há importadores seleccionados", "Não há importadores selecionado" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Factura : ", "Invoice : " )
		#define STR0019 "Pedido : "
		#define STR0020 "Questão ?"
	#endif
#endif
