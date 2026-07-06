#ifdef SPANISH
	#define STR0001 "Procesando Archivo Temporal"
	#define STR0002 "Pendiente - Embarcado"
	#define STR0003 "Pendiente - Prevision de Emb."
	#define STR0004 "Pendiente - Ambos"
	#define STR0005 "Liquidados"
	#define STR0006 "Si"
	#define STR0007 "No"
	#define STR0008 "Follow-up de Cambio"
	#define STR0009 "Imprimiendo registros ..."
	#define STR0010 "Intervalo sin datos para impresion"
	#define STR0011 "Aviso"
	#define STR0012 "Cambios"
	#define STR0013 "Cliente"
	#define STR0014 "Fecha Inicial"
	#define STR0015 "Fecha Final"
	#define STR0016 "Fecha Final no puede ser menor que Fecha Inicial"
	#define STR0017 "Verificar Proceso: "
	#define STR0018 "CAMBIO PENDIENTE - EMBARCADO"
	#define STR0019 "PENDIENTE - PREVISION DE EMBARQUE"
	#define STR0020 "LIQUIDADOS"
	#define STR0021 "De Vencimientos  "
	#define STR0022 "  A  "
	#define STR0023 "De Vencimientos previstos "
	#define STR0024 "De Pagos  "
	#define STR0025 "Vencimientos a partir de  "
	#define STR0026 "Vencimientos previstos a partir de  "
	#define STR0027 "Pagos a partir de  "
	#define STR0028 "A Vencimentos  "
	#define STR0029 "A Vencimientos previstos  "
	#define STR0030 "A Pagos"
	#define STR0031 " Todos "
	#define STR0032 "Imprimiendo: "
	#define STR0033 "Todos"
	#define STR0034 "PENDIENTE - AMBOS"
	#define STR0035 "Titulo"
	#define STR0036 "Moneda"
	#define STR0037 "Proveedor"
	#define STR0038 "Descripcion"
	#define STR0039 "Por pagar"
	#define STR0040 "Por cobrar"
	#define STR0041 "Liquidados"
	#define STR0042 "Filtros"
	#define STR0043 "LIQUIDADOS"
	#define STR0044 " - TITULOS POR PAGAR"
	#define STR0045 " - TITULOS POR COBRAR"
	#define STR0046 "MONEDA:"
	#define STR0047 "Todas"
	#define STR0048 "CLIENTE:"
	#define STR0049 "PROVEEDOR:"
	#define STR0050 "IMPORTADOR:"
	#define STR0051 "Importador"
	#define STR0052 "¡Importador Invalido! "
	#define STR0053 "Seleccionar un Importador que este registrado como "
	#define STR0054 "¡Importador o Todos!"
	#define STR0055 "¡Proveedor Invalido! "
	#define STR0056 "Seleccionar un proveedor que este registrado como "
	#define STR0057 "¡Exportador o Todos!"
	#define STR0058 "Evento"
	#define STR0059 "¡Codigo Invalido! Seleccione un codigo valido."
	#define STR0060 "EVENTO:"
#else
	#ifdef ENGLISH
		#define STR0001 "Processing Temporary File"
		#define STR0002 "Open - Shipped"
		#define STR0003 "Open - Ship. Estm."
		#define STR0004 "Pending - Both"
		#define STR0005 "Settled"
		#define STR0006 "Yes"
		#define STR0007 "No"
		#define STR0008 "Exchange Follow-up"
		#define STR0009 "Printing records ..."
		#define STR0010 "Interval without data for printing"
		#define STR0011 "Warning"
		#define STR0012 "Exchanges"
		#define STR0013 "Customer"
		#define STR0014 "Initial Date"
		#define STR0015 "Final Date"
		#define STR0016 "Final Date cannot be lower than the Initial One"
		#define STR0017 "Check Process:  "
		#define STR0018 "OPEN EXCHANGE -SHIPPED"
		#define STR0019 "OPEN - SHIPMENT ESTIMATION"
		#define STR0020 "SETTLED"
		#define STR0021 "From maturity   "
		#define STR0022 "  To   "
		#define STR0023 "From estimated maturities   "
		#define STR0024 "Payments from "
		#define STR0025 "From maturities   "
		#define STR0026 "From estimated maturities   "
		#define STR0027 "From payments   "
		#define STR0028 "Due Dates to "
		#define STR0029 "To estimated maturities   "
		#define STR0030 "Payments to "
		#define STR0031 " All "
		#define STR0032 "Printing: "
		#define STR0033 "All"
		#define STR0034 "OPEN - BOTH"
		#define STR0035 "Bill  "
		#define STR0036 "Currency"
		#define STR0037 "Supplier  "
		#define STR0038 "Descript."
		#define STR0039 "Payable"
		#define STR0040 "Receivable"
		#define STR0041 "Settled"
		#define STR0042 "Filters"
		#define STR0043 "SETTLED"
		#define STR0044 " - BILLS PAYABLE  "
		#define STR0045 " - BILLS RECEIVABLE "
		#define STR0046 "CURRENCY:"
		#define STR0047 "All  "
		#define STR0048 "CUSTOMER"
		#define STR0049 "SUPPLIER:  "
		#define STR0050 "IMPORTER:  "
		#define STR0051 "Importer  "
		#define STR0052 "Invalid Importer!    "
		#define STR0053 "Select an importer registered as                    "
		#define STR0054 "Importer or All!    "
		#define STR0055 "Invalid supplier!     "
		#define STR0056 "Select a supplier registered as                     "
		#define STR0057 "Exporter or All!    "
		#define STR0058 "Event "
		#define STR0059 "Invalid code! Select a valid code.          "
		#define STR0060 "EVENT: "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "A Processar Ficheiro Temporário", "Processando Arquivo Temporario" )
		#define STR0002 "Em Aberto - Embarcado"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Em Aberto - Previsão De Emb.", "Em Aberto - Previsäo de Emb." )
		#define STR0004 "Em Aberto - Ambos"
		#define STR0005 "Liquidados"
		#define STR0006 "Sim"
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Não", "Nao" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Follow-up De Câmbio", "Follow-up de Cambio" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "A imprimir os registos ...", "Imprimindo registros ..." )
		#define STR0010 "Intervalo sem dados para impressão"
		#define STR0011 "Aviso"
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Câmbios", "Cambios" )
		#define STR0013 "Cliente"
		#define STR0014 "Data Inicial"
		#define STR0015 "Data Final"
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Verificar processo: ", "Verificar Processo: " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Câmbio Em Aberto - Embarcado", "CAMBIO EM ABERTO - EMBARCADO" )
		#define STR0019 "EM ABERTO - PREVISÄO DE EMBARQUE"
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Liquidados", "LIQUIDADOS" )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", " vencimentos de", "Vencimentos de  " )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "  até  ", "  Até  " )
		#define STR0023 "Vencimentos previstos de  "
		#define STR0024 "Pagamentos de  "
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Vencimentos a partir de", "Vencimentos a partir de  " )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", " vencimentos previstos a partir de  ", "Vencimentos previstos a partir de  " )
		#define STR0027 "Pagamentos a partir de  "
		#define STR0028 "Vencimentos até  "
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "Validades previstas até  ", "Vencimentos previstos até  " )
		#define STR0030 "Pagamentos até  "
		#define STR0031 If( cPaisLoc $ "ANG|PTG", " todos ", " Todos " )
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "A imprimir: ", "Imprimindo: " )
		#define STR0033 "Todos"
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Em Aberto - Ambos", "EM ABERTO - AMBOS" )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Título", "Titulo" )
		#define STR0036 "Moeda"
		#define STR0037 "Fornecedor"
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricäo" )
		#define STR0039 "A pagar"
		#define STR0040 "A receber"
		#define STR0041 "Liquidados"
		#define STR0042 "Filtros"
		#define STR0043 If( cPaisLoc $ "ANG|PTG", "Liquidados", "LIQUIDADOS" )
		#define STR0044 If( cPaisLoc $ "ANG|PTG", " - Títulos A Pagar", " - TITULOS A PAGAR" )
		#define STR0045 If( cPaisLoc $ "ANG|PTG", " - Títulos A Receber", " - TITULOS A RECEBER" )
		#define STR0046 If( cPaisLoc $ "ANG|PTG", "Moeda:", "MOEDA:" )
		#define STR0047 "Todas"
		#define STR0048 If( cPaisLoc $ "ANG|PTG", "Cliente:", "CLIENTE:" )
		#define STR0049 If( cPaisLoc $ "ANG|PTG", "Fornecedor:", "FORNECEDOR:" )
		#define STR0050 If( cPaisLoc $ "ANG|PTG", "Importador:", "IMPORTADOR:" )
		#define STR0051 "Importador"
		#define STR0052 If( cPaisLoc $ "ANG|PTG", "Importador inválido! ", "Importador Invalido! " )
		#define STR0053 If( cPaisLoc $ "ANG|PTG", "Seleccionar um importador que esteja registado como ", "Selecionar um Importador que esteja cadastrado como " )
		#define STR0054 If( cPaisLoc $ "ANG|PTG", "Importador Ou Todos!", "Importador ou Todos!" )
		#define STR0055 If( cPaisLoc $ "ANG|PTG", "Fornecedor inválido! ", "Fornecedor Invalido! " )
		#define STR0056 If( cPaisLoc $ "ANG|PTG", "Seleccionar um fornecedor que esteja registado como ", "Selecionar um Fornecedor que esteja cadastrado como " )
		#define STR0057 If( cPaisLoc $ "ANG|PTG", "Exportador Ou Todos!", "Exportador ou Todos!" )
		#define STR0058 "Evento"
		#define STR0059 If( cPaisLoc $ "ANG|PTG", "Código inválido! seleccione um código válido.", "Codigo Invalido! Selecione um codigo valido." )
		#define STR0060 If( cPaisLoc $ "ANG|PTG", "Evento:", "EVENTO:" )
	#endif
#endif
