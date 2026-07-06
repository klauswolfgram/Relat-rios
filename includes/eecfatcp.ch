#ifdef SPANISH
	#define STR0001 "Solicitud de Fact. Complementaria"
	#define STR0002 "Factura Gasto"
	#define STR0003 "Fact. Compl. Cambiaria"
	#define STR0004 "Confirma "
	#define STR0005 "reversion Fact. "
	#define STR0006 " Serie "
	#define STR0007 "la generacion?"
	#define STR0008 "Numero de Factura de Complemento de Precio: "
	#define STR0009 "Aviso"
	#define STR0010 "Gener. Fact. Compl. &Gastos"
	#define STR0011 "Gener. Fact. Compl. &Cambiaria"
	#define STR0012 "Rev. Fact. Compl. Cambiaria"
	#define STR0013 "Gener. Fact. Compl. Cambiaria"
	#define STR0014 "Gener. Fact. Compl. Gasto"
	#define STR0015 "Rev. Fact. Compl. Gasto"
	#define STR0016 "En Procesamiento ..."
	#define STR0017 "Pedido Nº "
	#define STR0018 " ya Facturado!"
	#define STR0019 "Leyenda"
	#define STR0020 "Procesos embarcados"
	#define STR0021 "Procesos no embarcados"
	#define STR0022 "¿Confirma reversion de Fact. Compl. Cambiaria"
	#define STR0023 "¿Confirma generacion de Fact. Compl. Cambiaria?"
	#define STR0024 "¿Confirma generacion de Fact. Compl. de gastos?"
	#define STR0025 "¿Confirma reversion de Fact. Compl. de gastos?"
	#define STR0026 "¡Variacion Cambiaria negativa!"
	#define STR0027 "¡No pudo generarse Factura Complementaria!"
	#define STR0028 "¡Factura Revertida!"
	#define STR0029 "¡Aviso!"
	#define STR0030 "Factura Complementaria"
	#define STR0031 "Buscar"
	#define STR0032 " - Gastos"
	#define STR0033 "No se embargo Proceso o esta anulado."
	#define STR0034 "Atencion"
	#define STR0035 "Este Proceso no tiene gastos."
	#define STR0036 "Proceso con variacion de gastos negativa."
	#define STR0037 "¡Factura Complementaria de Gasto revertida!"
	#define STR0038 "El proceso esta anulado."
	#define STR0039 "O INCOTERMS utilizado prevê lançamento de Despesas que ainda não foram lançadas no processo."
	#define STR0040 "Deseja prosseguir com a geração da Nota Fiscal Complementar de Embarque?"
	#define STR0041 "despues de la emision de la Factura complementaria de Gastos."
	#define STR0042 "¡Solo se permitira revertir la Factura Complementaria de Gasto,"
	#define STR0043 " despues de la reversion de la Factura Complementaria de Embarque!"
	#define STR0044 "Generando Fact. Compl. Cambiaria"
	#define STR0045 "Generacion de Factura Complementaria Cambiaria"
	#define STR0046 "¡Factura Cambiaria no puede generarse para cuota no liquidada !"
	#define STR0047 "¡Problema de lock en la grabacion del flag de generacion !"
	#define STR0048 "No hubo Diferencia Cambiaria."
	#define STR0049 "¡Cliente no registrado !"
	#define STR0050 "¡Importador no registrado !"
	#define STR0051 "¡El campo Cond. Pago en el SIGAFAT no se relleno!"
	#define STR0052 "Por favor, selec. el TES que se utilizara para la "
	#define STR0053 "generacion de todas las facturas complementarias de cambio"
	#define STR0054 "Selec. de TES"
	#define STR0055 "El TES selec., esta configur. para generar Fact. de Cred. ¿Desea continuar?"
	#define STR0056 "Esta rutina solo podrá utilizarse con entornos integrados a la facturación del Protheus."
	#define STR0057 "Para utilizar la rutina, habilite el parámetro MV_EECFAT."
#else
	#ifdef ENGLISH
		#define STR0001 "Complementary Inv. Requisition"
		#define STR0002 "Expense Invoice"
		#define STR0003 "Exch.Compl.Invoice"
		#define STR0004 "Confirm "
		#define STR0005 "reverse Invoice "
		#define STR0006 " Series "
		#define STR0007 "the generation ?"
		#define STR0008 "Price Complement Invoice Number: "
		#define STR0009 "Warning"
		#define STR0010 "Generate &Expenses NFC"
		#define STR0011 "Generate &Exchange NFC"
		#define STR0012 "Est. Exchange NFC"
		#define STR0013 "Gener. Exchange NFC"
		#define STR0014 "Gener. Exchange NFC"
		#define STR0015 "Est. Exchange NFC"
		#define STR0016 "Processing ..."
		#define STR0017 "Order No. "
		#define STR0018 " already Invoiced !"
		#define STR0019 "Title"
		#define STR0020 "Processes shipped"
		#define STR0021 "Processes not invoiced"
		#define STR0022 "Confirm the reversal of Exch.NFC?"
		#define STR0023 "Confirm the generation of Exch.NFC?"
		#define STR0024 "Confirm the generation of Exp.NFC?"
		#define STR0025 "Confirm the reversal of Exp.NFC?"
		#define STR0026 "Exchange Variation is negative !"
		#define STR0027 "Complementary Invoice cannot be generated!"
		#define STR0028 "Invoice Reversed !"
		#define STR0029 "Warning !"
		#define STR0030 "Complementary Invoice"
		#define STR0031 "Search"
		#define STR0032 " - Expenses"
		#define STR0033 "Process not shipped or cancelled."
		#define STR0034 "Attention"
		#define STR0035 "Process has no expenses."
		#define STR0036 "Process has negative expenses variation."
		#define STR0037 "Expenses Complementary Invoice reversed !"
		#define STR0038 "The process is canceled."
		#define STR0039 "O INCOTERMS utilizado prevê lançamento de Despesas que ainda não foram lançadas no processo."
		#define STR0040 "Deseja prosseguir com a geração da Nota Fiscal Complementar de Embarque?"
		#define STR0041 " after issuing expense supplementary invoice.           "
		#define STR0042 "Reversing an expense supplementary invoice is only allowed       "
		#define STR0043 " after reversing shipping supplementary invoice!       "
		#define STR0044 "Generating exch.NFC"
		#define STR0045 "Generation of exchange complementary invoice"
		#define STR0046 "Exchange invoice cannot be generated for an unliquidated installment"
		#define STR0047 "Lock problem saving generation flag!"
		#define STR0048 "No exchange difference. "
		#define STR0049 "Customer not registered!"
		#define STR0050 "Importer not registered!   "
		#define STR0051 "The field payment condition in SIGAFAT is blank!"
		#define STR0052 "Please, select the TIO to be used for "
		#define STR0053 "generation of all complementary exchange invoices "
		#define STR0054 "TIO selection "
		#define STR0055 "The selected TIO is configured to generate a trade note. Will you continue?"
		#define STR0056 "This routine can only be used with environments integrated to Protheus billing."
		#define STR0057 "To use this routine, enable parameter MV_EECFAT."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Solicitação De Factura Complementar", "Solicitação de N.F. Complementar" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Nº Fiscal Despesa", "N.Fiscal Despesa" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Fact.  Compl. Cambial", "N.F. Compl. Cambial" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Cofacturairma ", "Confirma " )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Estorno da fact. ", "estorno da N.F. " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", " série ", " Serie " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "A criar ?", "a geração ?" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Número da factura de complemento de preço: ", "Número da Nota Fiscal de Complemento de Preço: " )
		#define STR0009 "Aviso"
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Gera nfc despesas", "Gera NFC &Despesas" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Gera nfc cambial", "Gera NFC &Cambial" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Est. Nfc Cambial", "Est. NFC Cambial" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Criar Nfc Cambial", "Gera NFC Cambial" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Criar Nfc Despesa", "Gera NFC Despesa" )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Est. Nfc Despesa", "Est. NFC Despesa" )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Em processamento ...", "Em Processamento ..." )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Pedido nº ", "Pedido Nro. " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", " já facturado !", " já Faturado !" )
		#define STR0019 "Legenda"
		#define STR0020 "Processos embarcados"
		#define STR0021 "Processos não embarcados"
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Confirmar a devolução da nfc cambial ?", "Confirma o estorno da NFC Cambial ?" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "Confirmar a criação da nfc cambial ?", "Confirma a geração da NFC Cambial ?" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Confirmar a criação da nfc de despesas ?", "Confirma a geração da NFC de despesas ?" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Confirmar a devolução da nfc de despesas ?", "Confirma o estorno da NFC de despesas ?" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Variação cambial negativa !", "Variação Cambial negativa !" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "Factura complementar não pode ser gerada!", "Nota Fiscal Complementar não pode ser gerada!" )
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Factura estornada !", "Nota Fiscal Estornada !" )
		#define STR0029 "Aviso !"
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Factura Complementar", "Nota Fiscal Complementar" )
		#define STR0031 "Pesquisar"
		#define STR0032 " - Despesas"
		#define STR0033 "Processo não foi embarcado ou está cancelado."
		#define STR0034 "Atenção"
		#define STR0035 "Processo não possui despesas."
		#define STR0036 If( cPaisLoc $ "ANG|PTG", "Processo com variação de despesas negativo.", "Processo com variação de despesas negativa." )
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "Factura complementar de despesa estornada !", "Nota Fiscal Complementar de Despesa estornada !" )
		#define STR0038 "O processo está cancelado."
		#define STR0039 "O INCOTERMS utilizado prevê lançamento de Despesas que ainda não foram lançadas no processo."
		#define STR0040 "Deseja prosseguir com a geração da Nota Fiscal Complementar de Embarque?"
		#define STR0041 If( cPaisLoc $ "ANG|PTG", " Após A Emissão Da Factura Complementar De Despesas.", " após a emissão da nota fiscal complementar de Despesas." )
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "Só Será Permitido Estornar A Factura Complementar De Despesa", "Só será permitido estornar a Nota Fiscal Complementar de Despesa," )
		#define STR0043 If( cPaisLoc $ "ANG|PTG", " Após O Estorno Da Factura Complementar De Embarque!", " após o estorno da Nota fiscal Complementar de Embarque!" )
		#define STR0044 If( cPaisLoc $ "ANG|PTG", "Gerando Nfc Cambial", "Gerando NFC Cambial" )
		#define STR0045 If( cPaisLoc $ "ANG|PTG", "Criação de factura   complementar cambial", "Geração de Nota Fiscal Complementar Cambial" )
		#define STR0046 If( cPaisLoc $ "ANG|PTG", "Factura   cambial não pode ser criada para parcela não liquidada !", "Nota Fiscal Cambial não pode ser gerada para parcela não liquidada !" )
		#define STR0047 If( cPaisLoc $ "ANG|PTG", "Problema de bloqueio na gravação da marca de criação !", "Problema de lock na gravação da flag de geração !" )
		#define STR0048 If( cPaisLoc $ "ANG|PTG", "Não houve diferenca cambial.", "Não Houve Diferença Cambial." )
		#define STR0049 If( cPaisLoc $ "ANG|PTG", "Cliente não registado !", "Cliente não cadastrado !" )
		#define STR0050 If( cPaisLoc $ "ANG|PTG", "Importador não registado !", "Importador não cadastrado !" )
		#define STR0051 If( cPaisLoc $ "ANG|PTG", "O campo cond.pgt no sigafat não foi preenchido!", "O campo Cond.Pagto no SIGAFAT não foi preenchido!" )
		#define STR0052 If( cPaisLoc $ "ANG|PTG", "Por favor, seleccione a tes que será utilizada para a ", "Por favor, selecione a TES que será utilizada para a " )
		#define STR0053 "geração de todas notas fiscais complementares de câmbio"
		#define STR0054 If( cPaisLoc $ "ANG|PTG", "Selecção Da Tes", "Seleção da TES" )
		#define STR0055 If( cPaisLoc $ "ANG|PTG", "A tes seleccionada, está configurada para criar duplicado. deseja continuar?", "A TES selecionada, está configurada para gerar duplicata. Deseja continuar?" )
		#define STR0056 "Esta rotina só poderá ser utilizada com ambientes integrados ao faturamento do Protheus."
		#define STR0057 "Para utilizar a rotina, habilite o parâmetro MV_EECFAT."
	#endif
#endif
