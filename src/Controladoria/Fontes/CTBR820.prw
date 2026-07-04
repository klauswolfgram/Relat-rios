/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR820.CH"
#Include "PROTHEUS.CH"

#DEFINE COL_SEPARA1		1
#DEFINE COL_CONTA		2
#DEFINE COL_SEPARA2		3
#DEFINE COL_DESCRICAO	4
#DEFINE COL_SEPARA3		5
#DEFINE COL_SALDO_ANT	6
#DEFINE COL_SEPARA4		7
#DEFINE COL_VLR_DEBITO	8
#DEFINE COL_SEPARA5		9
#DEFINE COL_VLR_CREDITO	10
#DEFINE COL_SEPARA6		11
#DEFINE COL_MOVIMENTO	12
#DEFINE COL_SEPARA7		13
#DEFINE COL_SALDO_ATU	14
#DEFINE COL_SEPARA8		15

Static __aTmpTCFil	:= {}
Static lFWCodFil	:= FindFunction("FWCodFil")

Static aCubsCTB
Static lCtbIsCube	:= FindFunction("CtbIsCube")
Static __Release  :=  Iif(GetRPORelease() >= "12.1.2210", .T., .F.)   //.and. CTS->(FieldPos(CTS_COLUN2)> 0),.T.,.F.)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR820  ³ Autor ³ Marco A. Gonzalez     ³ Data ³ 26/04/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balance Patrimonial (COL)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR820()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ N/A                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ N/A                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³  Data  ³    BOPS   ³         Motivo de Alteracion        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³  Marco A.  ³28/11/16³   MMI-67  ³ Se agrega al reporte la impresion   ³±±
±±³            ³        ³           ³ de la informacion en forma          ³±±
±±³            ³        ³           ³ sintetica, analitica y ambas. Debido³±±
±±³            ³        ³           ³ a que solo imprimia de forma        ³±±
±±³            ³        ³           ³ analitica. (COL)                    ³±±
±±³  Marco A   ³06/01/17³  MMI-4622 ³ Replica para V12.1.7 - Colombia     ³±±
±±³  Marco A   ³09/01/16³  MMI-4632 ³ Replica para V12.1.14 - Colombia    ³±±
±±³  Marco A.  ³09/01/16³ SERINN001 ³Se aplican los cambios de Ctree en   ³±±
±±³            ³        ³ -112      ³los CriaTrab que crean tablas        ³±±
±±³            ³        ³           ³temporales fisicas. (COL)            ³±±
±±³Verónica Flo³05/12/18³DMINA-4961 ³Recompilación de la fuente           ³±±
±±³            ³        ³           ³ Colombia.                           ³±±
±±³José Glez   ³16/07/20³DMINA-9405 ³Se cambia el total de cuenta de la   ³±±
±±³            ³        ³           ³columna Movimientos a SaldoActual COL³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR820()

	Private cTitulo		:= STR0001		//"Balance Patrimonial"
	Private cNomeProg	:= "CTBR820"	//Nombre del programa
	Private cPlano		:= "01"			//Usado pela consulta padrao CV01
	Private cCodigo		:= "" 			//Usado pela consulta padrao CV01

	Private oReport		:= Nil

	U_CTBR820R4()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR820R4 ³ Autor³ Marco A. Gonzalez		³ Data ³ 26/04/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balance Analitico Sintetico Modelo 1 - R4   (COL)          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CTBR048R4                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGACTB                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR820R4()

	Local oReport := Nil

	oReport := ReportDef()

	If ValType(oReport) == 'O'
		oReport:PrintDialog()
	EndIf

	oReport := Nil

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco A. Gonzalez		³ Data ³ 26/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcion tiene como objetivo definir las secciones,     ³±±
±±³          ³celdas y totalizadores en el reporte, que pueden ser        ³±±
±±³          ³configurados por el reporte. (COL)                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACTB                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

	Local aTamConta		:= TAMSX3("CT1_CONTA")
	Local aTamVal		:= TAMSX3("CT2_VALOR")
	Local aTamDesc		:= TAMSX3("CT1_CONTA")
	Local nTamCols		:= aTamVal[1] + 25
	Local aSetOfBook	:= {}

	Local cReport		:= cNomeProg
	Local cTitulo		:= STR0002 //"Emisión del Reporte Conf. Dig."
	Local cDesc			:= STR0003 //"Este programa imprimirá el Reporte de la Conferencia"
	Local cMascara		:= ""
	Local cSeparador	:= ""
	Local cPerg			:= "CTBR820"

	Local oSection1		:= Nil
	Local oSection2		:= Nil
	Local oSection3		:= Nil

	Local nTamConta		:= TAMSX3("CT1_CONTA")[1]
	Local nTamEC05		:= TAMSX3("CV0_CODIGO")[1] + 14

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³mv_par01 - Fecha Inicial?             ³
	//³mv_par02 - Fecha Final?               ³
	//³mv_par03 - Cuenta Inicial?            ³
	//³mv_par04 - Cuenta Final?              ³
	//³mv_par05 - Saldo en Cero?             ³
	//³mv_par06 - Moneda?                    ³
	//³mv_par07 - Tipo de Saldo?             ³
	//³mv_par08 - Imprime Columna Mov.?      ³
	//³mv_par09 - Salta Linea Sintet.?       ³
	//³mv_par10 - Imprime Valor 0,00?        ³
	//³mv_par11 - No. Lineas P/Balance?      ³
	//³mv_par12 - Descrip. de la Moneda?     ³
	//³mv_par13 - N.I.T. Inicial?            ³
	//³mv_par14 - N.I.T. Final?              ³
	//³mv_par15 - Total por Cuenta?          ³
	//³mv_par16 - Imprime Cuentas?           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	Pergunte(cPerg, .F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
	//³ Gerencial -> montagem especifica para impressao)             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSetOfBook := CTBSetOf("")
	cMascara := RetMasCtb(aSetOfBook[2], @cSeparador)

	If !Empty( cMascara )
		nTamConta := aTamConta[1] + (Len(Alltrim(cMascara)) / 2)
	Else
		nTamConta := aTamConta[1]
	EndIf

	cPicture := aSetOfBook[4]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao do componente de impressao                                      ³
	//³                                                                        ³
	//³TReport():New                                                           ³
	//³ExpC1 : Nome do relatorio                                               ³
	//³ExpC2 : Titulo                                                          ³
	//³ExpC3 : Pergunte                                                        ³
	//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
	//³ExpC5 : Descricao                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//"Este programa tem o objetivo de emitir o Cadastro de Itens Classe de Valor "
	//"Sera impresso de acordo com os parametros solicitados pelo"
	//"usuario"
	oReport	:= TReport():New(cReport, Capital(cTitulo), cPerg, {|oReport| If(!CTBR820Rep(oReport), oReport:CancelPrint(), .T. )}, cDesc)

	oReport:SetEdit(.F.)


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao da secao utilizada pelo relatorio                               ³
	//³                                                                        ³
	//³TRSection():New                                                         ³
	//³ExpO1 : Objeto TReport que a secao pertence                             ³
	//³ExpC2 : Descricao da seçao                                              ³
	//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
	//³        sera considerada como principal para a seção.                   ³
	//³ExpA4 : Array com as Ordens do relatório                                ³
	//³ExpL5 : Carrega campos do SX3 como celulas                              ³
	//³        Default : False                                                 ³
	//³ExpL6 : Carrega ordens do Sindex                                        ³
	//³        Default : False                                                 ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	// Seccion 1
	oSection1:= TRSection():New(oReport, STR0020, {"cArqTmp"}, /*aOrder*/, /*lLoadCells*/, /*lLoadOrder*/)	//"Cuenta"
	oSection1:SetHeaderPage(.T.)
	oSection1:SetReadOnly()

	TRCell():New(oSection1, "ECX"		, , STR0021, /*Picture*/, nTamConta		, /*lPixel*/, /*CodeBlock*/) //"CUENTA"
	TRCell():New(oSection1, "ECXDESC"	, , STR0022, /*Picture*/, aTamDesc[1]	, /*lPixel*/, /*CodeBlock*/) //"DESCRIPCION"
	TRCell():New(oSection1, "ECY"		, , STR0023, /*Picture*/, nTamEC05		, /*lPixel*/, /*CodeBlock*/) //"NIT"
	TRCell():New(oSection1, "ECYDESC"	, , STR0022, /*Picture*/, 20			, /*lPixel*/, /*CodeBlock*/) //"DESCRIPCION"
	TRCell():New(oSection1, "SALDOANT"	, , STR0024, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"SALDO ANTERIOR"
	TRCell():New(oSection1, "SALDODEB"	, , STR0025, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"DEBITO
	TRCell():New(oSection1, "SALDOCRD"	, , STR0026, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"CREDITO"
	TRCell():New(oSection1, "MOVIMENTO"	, , STR0027, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"MOVIMIENTO"
	TRCell():New(oSection1, "SALDOATU"	, , STR0028, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"SALDO ACTUAL"

	oSection1:SetReadOnly()

	oSection1:Cell("ECX"		):Hide()
	oSection1:Cell("ECXDESC"	):Hide()
	oSection1:Cell("ECY"		):Hide()
	oSection1:Cell("ECYDESC"	):Hide()
	oSection1:Cell("SALDOANT"	):Hide()
	oSection1:Cell("SALDODEB"	):Hide()
	oSection1:Cell("SALDOCRD"	):Hide()
	oSection1:Cell("MOVIMENTO"	):Hide()
	oSection1:Cell("SALDOATU"	):Hide()
	oSection1:SetTotalInLine(.T.)
	oSection1:SetTotalText(STR0004) //"T O T A L  G E N E R A L ==>>"

	// Seccion 2
	oSection2:= TRSection():New( oReport,STR0005, {"cArqTmp","CT1"},, .F., .F. ) //"Plan de cuentas"
	oSection2:SetHeaderSection(.F.)
	oSection2:SetReadOnly()

	// Detalle Cuentas
	TRCell():New(oSection2, "ECX"		, , STR0021, /*Picture*/, nTamConta		, /*lPixel*/, /*CodeBlock*/) //"CUENTA"
	TRCell():New(oSection2, "ECXDESC"	, , STR0022, /*Picture*/, aTamDesc[1]	, /*lPixel*/, /*CodeBlock*/) //"DESCRIPCION"
	TRCell():New(oSection2, "ECY"		, , STR0023, /*Picture*/, nTamEC05		, /*lPixel*/, /*CodeBlock*/) //"NIT"
	TRCell():New(oSection2, "ECYDESC"	, , STR0022, /*Picture*/, 20			, /*lPixel*/, /*CodeBlock*/) //"DESCRIPCION"
	TRCell():New(oSection2, "SALDOANT"	, , STR0024, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"SALDO ANTERIOR"
	TRCell():New(oSection2, "SALDODEB"	, , STR0025, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"DEBITO
	TRCell():New(oSection2, "SALDOCRD"	, , STR0026, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"CREDITO"
	TRCell():New(oSection2, "MOVIMENTO"	, , STR0027, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"MOVIMIENTO"
	TRCell():New(oSection2, "SALDOATU"	, , STR0028, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"SALDO ACTUAL"

	TRPosition():New( oSection2, "CT1", 1, {|| xFilial( "CT1" ) + cArqTMP->ECX })

	oSection2:SetTotalInLine(.T.)
	oSection2:SetTotalText(STR0004) //"T O T A L  G E N E R A L ==>>"

	oSection2:Cell("ECX"		):HideHeader()
	oSection2:Cell("ECXDESC"	):HideHeader()
	oSection2:Cell("ECY"		):HideHeader()
	oSection2:Cell("ECYDESC"	):HideHeader()
	oSection2:Cell("SALDOANT"	):HideHeader()
	oSection2:Cell("SALDODEB"	):HideHeader()
	oSection2:Cell("SALDOCRD"	):HideHeader()
	oSection2:Cell("MOVIMENTO"	):HideHeader()
	oSection2:Cell("SALDOATU"	):HideHeader()

	// Seccion 3
	oSection3:= TRSection():New( oReport,STR0005, {"cArqTmp","CT1"},, .F., .F. ) //"Plan de cuentas"
	oSection3:SetHeaderSection(.F.)
	oSection3:SetReadOnly()

	// Detalle Cuentas
	TRCell():New(oSection3, "ECX"		, , STR0021, /*Picture*/, nTamConta		, /*lPixel*/, /*CodeBlock*/) //"CUENTA"
	TRCell():New(oSection3, "ECXDESC"	, , STR0022, /*Picture*/, aTamDesc[1]	, /*lPixel*/, /*CodeBlock*/) //"DESCRIPCION"
	TRCell():New(oSection3, "ECY"		, , STR0023, /*Picture*/, nTamEC05		, /*lPixel*/, /*CodeBlock*/) //"NIT"
	TRCell():New(oSection3, "ECYDESC"	, , STR0022, /*Picture*/, 20			, /*lPixel*/, /*CodeBlock*/) //"DESCRIPCION"
	TRCell():New(oSection3, "SALDOANT"	, , STR0024, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"SALDO ANTERIOR"
	TRCell():New(oSection3, "SALDODEB"	, , STR0025, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"DEBITO
	TRCell():New(oSection3, "SALDOCRD"	, , STR0026, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"CREDITO"
	TRCell():New(oSection3, "MOVIMENTO"	, , STR0027, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"MOVIMIENTO"
	TRCell():New(oSection3, "SALDOATU"	, , STR0028, /*Picture*/, nTamCols		, /*lPixel*/, /*CodeBlock*/, "RIGHT", , "RIGHT") //"SALDO ACTUAL"

	TRPosition():New(oSection3, "CT1", 1, {|| xFilial( "CT1" ) + cArqTMP->ECX})

	oSection3:SetTotalInLine(.T.)
	oSection3:SetTotalText(STR0004) //"T O T A L  G E N E R A L ==>>"

	oSection3:Cell("ECX"		):HideHeader()
	oSection3:Cell("ECXDESC"	):HideHeader()
	oSection3:Cell("ECY"		):HideHeader()
	oSection3:Cell("ECYDESC"	):HideHeader()
	oSection3:Cell("SALDOANT"	):HideHeader()
	oSection3:Cell("SALDODEB"	):HideHeader()
	oSection3:Cell("SALDOCRD"	):HideHeader()
	oSection3:Cell("MOVIMENTO"	):HideHeader()
	oSection3:Cell("SALDOATU"	):HideHeader()

Return (oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CTBR820Rep    ³ Autor ³ Marco A. Gonzalez ³ Data ³ 26/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime el informe definido por el usuario de acuerdo con   ³±±
±±³          ³las secciones/celdas creadas en la funcion ReportDef() (COL)³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CTBR820Rep(ExpO1)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto Reporte                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTBR820Rep( oReport )

	Local oSection1		:= oReport:Section(1)
	Local oSection2		:= oReport:Section(2)
	Local oSection3		:= oReport:Section(3)
	Local oMeter		:= Nil
	Local oText			:= Nil
	Local oDlg			:= Nil
	Local oTotGerAnt	:= Nil
	Local oTotGerDeb	:= Nil
	Local oTotGerCrd	:= Nil
	Local oTotGerMov	:= Nil
	Local oTotGerSA 	:= Nil

	Local aSetOfBook	:= {}
	Local aCtbMoeda		:= {}
	Local aCtbMoedadsc	:= {}
	Local aTamVal		:= TAMSX3("CT2_VALOR")
	Local nTamTots		:= aTamVal[1] + 20
	Local nTamCols		:= aTamVal[1] + 20

	Local lExterno		:= .F.
	Local lRet			:= .T.
	Local lPrintZero	:= IIf(MV_PAR10 == 1, .T., .F.)
	Local lPula			:= IIf(MV_PAR09 == 1, .T., .F.)
	Local lVlrZerado	:= IIf(MV_PAR05 == 1, .T., .F.)
	Local lQbConta		:= .T.
	Local lImpSint		:= IIf(MV_PAR16 == 1 .Or. mv_par05 == 3, .T., .F.)
	Local lImpMov		:= IIf(MV_PAR08 == 1, .T., .F.)

	Local nDecimais
	Local nDivide		:= 1
	Local nTotDeb		:= 0
	Local nTotSAn		:= 0
	Local nTotCrd		:= 0
	Local nTotMov		:= 0
	Local nMaxLin		:=  MV_PAR11
	Local nTotSldAtu	:= 0
	Local nTotSldAnt	:= 0
	Local nSldAtu		:= 0
	Local nSldAnt		:= 0
	Local nTotGerAnt	:= 0
	Local nTotGerDeb	:= 0
	Local nTotGerCrd	:= 0
	Local nTotGerMov	:= 0
	Local nCount		:= 0
	Local nTipoRep		:= MV_PAR16
	Local nTotDebAna	:= 0
	Local nTotCrdAna	:= 0
	Local nTotMovAna	:= 0
	Local nTotAtuAna	:= 0

	Local cMoedaDsc		:= MV_PAR12
	Local cTipoAnt		:= ""
	Local cArqTmp		:= ""
	Local cSeparador	:= ""
	Local cPicture		:= ""
	Local cFilUser		:= ""
	Local cRngFil		:= ""
	Local cCtaNomSup	:= ""
	Local cCtaDesSup	:= ""
	Local cCtaNomInf	:= ""
	Local cCtaDesInf	:= ""
	Local cNITNomInf	:= ""
	Local cNITDesInf	:= ""
	Local cFilCT1       := xFilial("CT1")

	Local dDataFim		:= MV_PAR02
	Local dDtCorte		:= Stod(cValtoChar(year(mv_par01)) + "0101") //Data de corte pora virada de saldo anual
	Local lImpAntLP		:= (MV_PAR17==1)							// Posición Ant. Ganan./Perd.
	Local dDataLP		:= IIf(lImpAntLP,MV_PAR18,CtoD(""))			// Fecha Ganancias/Pérdidas
	Local oBreak1
	Local cMascara		:= ""

	Private nLinReport	:= 9
	Private oTmpTable	:= Nil

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
	//³ Gerencial -> montagem especifica para impressao)             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSetOfBook := CTBSetOf( "" )

	If lRet
		aCtbMoeda := CtbMoeda(  MV_PAR06 , nDivide )

		If Empty(aCtbMoeda[1])
			Help(" ",1,"NOMOEDA")
			lRet := .F.
			Return lRet
		EndIf

		// validação da descrição da moeda
		If lRet .And. ! Empty(  MV_PAR12 ) .and.  MV_PAR12 <> nil
			aCtbMoedadsc := CtbMoeda(  MV_PAR12 , nDivide )

			If Empty( aCtbMoedadsc[1] )
				Help( " " , 1 , "NOMOEDA")
				lRet := .F.
				Return lRet
			EndIf
		EndIf
	EndIf

	aCtbMoeda	:= CtbMoeda( MV_PAR06,nDivide)
	cDescMoeda	:= Alltrim(aCtbMoeda[2])
	nDecimais	:= DecimalCTB(aSetOfBook,MV_PAR06)

	If Empty(aSetOfBook[2])
		cMascara := GetMv("MV_MASCARA")
	Else
		cMascara := RetMasCtb(aSetOfBook[2],@cSeparador)
	EndIf

	cPicture1	:= aSetOfBook[4]
	cPicture    := aSetOfBook[4] //"@E 9,999,999,999,999.99" //aSetOfBook[4]

	lPrintZero	:= IIf( MV_PAR10 == 1, .T., .F.)

	cTitulo:=	OemToAnsi(STR0006)	//"BALANCE DE VERIFICACION DE "
	cTitulo += 	DTOC(MV_PAR01) + OemToAnsi(STR0007) + Dtoc(MV_PAR02) + ; //" HASTA "
	OemToAnsi(STR0008) + cDescMoeda + CtbTitSaldo(MV_PAR07) //" MONEDA "

	oReport:SetCustomText( {|| CTBR820nTR(dDataFim, MV_PAR01,cTitulo,oReport)})

	cFilUser := oSection2:GetAdvplExpr("CT1")
	If Empty(cFilUser)
		cFilUser := ".T."
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If lExterno .Or. IsBlind()
		CTBR820GerPla(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
						mv_par01,mv_par02,"CVY","",mv_par03,mv_par04,MV_PAR13,MV_PAR14,,,,,mv_par06,;
						mv_par07,aSetOfBook,,,,,;
						.F.,.F.,,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFilUser,,;
						,,,,,,,,cMoedaDsc,,cRngFil,dDtCorte)
	Else
		MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
					CTBR820GerPla(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
					mv_par01,mv_par02,"CVY","",mv_par03,mv_par04,MV_PAR13,MV_PAR14,,,,,mv_par06,;
					mv_par07,aSetOfBook,,,,,;
					.F.,.F.,,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFilUser,,;
					,,,,,,,,cMoedaDsc,,cRngFil,dDtCorte)},;
					OemToAnsi(OemToAnsi(STR0009)),;	//"Creando Archivo Temporal..."
					OemToAnsi(STR0010))	//"Verificación de Balance"
	EndIf

	nCount := cArqTmp->(RecCount())
	oReport:SetMeter(nCount)
	lRet := !(nCount == 0 .And. !Empty(aSetOfBook[5]))

	If lRet
		cArqTmp->(dbGoTop())

			If nTipoRep == 2 //Si es Reporte Analitico

				oSection2:Cell("ECX"):SetBlock( {|| EntidadeCTB(cArqTmp->ECX,000,000,030,.F.,cMascara,cSeparador,,,.F.,,.F.)} )
				oSection2:Cell("ECXDESC"):SetBlock( { || cArqTmp->ECXDESC } )

				oSection2:Cell("ECY"):SetBlock( {|| cArqTmp->ECY } )
				oSection2:Cell("ECYDESC"):SetBlock( { || cNITDesInf } )

				oSection2:Cell("SALDOANT"):SetBlock( { || ValorCTB(cArqTmp->SALDOANT,,,nTamCols,nDecimais,.T.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )
				oSection2:Cell("SALDODEB"):SetBlock( { || ValorCTB(cArqTmp->SALDODEB,,,nTamCols,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )
				oSection2:Cell("SALDOCRD"):SetBlock( { || ValorCTB(cArqTmp->SALDOCRD,,,nTamCols,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )
				// Imprime Movimento
				If lImpMov
					oSection2:Cell("MOVIMENTO"):SetBlock( { || ValorCTB(cArqTmp->MOVIMENTO,,,nTamCols,nDecimais,.T.,cPicture,cArqTmp->ECXNORMAL,,,,,, lPrintZero,.F.) } )
				Else
					oSection1:Cell("MOVIMENTO"):Disable()
					oSection2:Cell("MOVIMENTO"):Disable()
				EndIf
				oSection2:Cell("SALDOATU"):SetBlock( { || ValorCTB(cArqTmp->SALDOATU,,,nTamCols,nDecimais,.T.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )
				oSection1:Cell("SALDODEB"):SetBlock( { || ValorCTB(cArqTmp->SALDODEB,,,nTamCols,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )
				oSection1:Cell("SALDOCRD"):SetBlock( { || ValorCTB(cArqTmp->SALDOCRD,,,nTamCols,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )

				//****************************
				// Total Geral do relatorio  *
				//****************************

				If mv_par15 == 1 //Si Imprime Total General

					//Totales por cuenta
				oBreak1 := TRBreak():New( oSection2, {|| cArqTmp->ECX }, OemToAnsi(STR0011) ) //"Total Cuenta"

				TRFunction():New(oSection2:Cell("SALDODEB"),,"ONPRINT",oBreak1/*oBreak*/,""/*Titulo*/,cPicture,;
				{ || ValorCTB(nTotDeb,,,nTamTots,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2 )
				TRFunction():New(oSection2:Cell("SALDOCRD"),,"ONPRINT",oBreak1/*oBreak*/,""/*Titulo*/,cPicture,;
				{ || ValorCTB(nTotCrd,,,nTamTots,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2 )

				TRFunction():New(oSection2:Cell("SALDOATU"),,"ONPRINT",oBreak1/*oBreak*/,""/*Titulo*/,cPicture,;
				{ || ValorCTB(nTotMov,,,nTamTots,nDecimais,.T.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2 )


				//Total General
				oBrkGeral := TRBreak():New(oSection1, { || /*cArqTmp->(!Eof())*/ },{|| STR0004 },,,.F.) //" T O T A L  G E N E R A L  ==> "	//	" T O T A I S "

				oTotGerDeb :=	TRFunction():New( oSection1:Cell("SALDODEB")	, ,"ONPRINT", oBrkGeral,"" /*Titulo*/,cPicture,;
				{ || ValorCTB(nTotGerDeb  ,,,nTamTots,nDecimais,.F.,cPicture1,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1)
				oTotGerCrd :=	TRFunction():New( oSection1:Cell("SALDOCRD")	, ,"ONPRINT", oBrkGeral,"" /*Titulo*/,cPicture,;
				{ || ValorCTB(nTotGerCrd  ,,,nTamTots,nDecimais,.F.,cPicture1,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1)
				If lImpMov
					oTotGerCrd :=	TRFunction():New( oSection1:Cell("MOVIMENTO")	, ,"ONPRINT", oBrkGeral,"" /*Titulo*/,cPicture,;
					{ || ValorCTB(nTotGerMov  ,,,nTamTots,nDecimais,.T.,cPicture1,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1)

				EndIf
			Else
				oBrkGeral := TRBreak():New(oSection2, { || cArqTmp->(!Eof()) },{|| STR0012 },,,.F.)	//"  T O T A L  "
				oTotGerDeb := TRFunction():New(oSection2:Cell("SALDODEB"),,"SUM",oBrkGeral /*oBreak*/,""/*Titulo*/,/*cPicture*/,;
				{ || IIf(cArqTmp->TIPOECX == "1",0,cArqTmp->SALDODEB) },.F.,.F.,.F.,oSection2)
				oTotGerDeb:Disable()
				oTotGerCrd := TRFunction():New(oSection2:Cell("SALDOCRD"),,"SUM", oBrkGeral/*oBreak*/,""/*Titulo*/,/*cPicture*/,;
				{ || IIf(cArqTmp->TIPOECX == "1",0,cArqTmp->SALDOCRD) },.F.,.F.,.F.,oSection2)
				oTotGerCrd:Disable()
				TRFunction():New(oSection2:Cell("SALDODEB"),,"ONPRINT",oBrkGeral/*oBreak*/,""/*Titulo*/,/*cPicture*/,;
				{ || ValorCTB(oTotGerDeb:GetValue(),,,nTamTots,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2 )
				TRFunction():New(oSection2:Cell("SALDOCRD"),,"ONPRINT",oBrkGeral/*oBreak*/,""/*Titulo*/,/*cPicture*/,;
				{ || ValorCTB(oTotGerCrd:GetValue(),,,nTamTots,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2 )
			EndIf

			ElseIf nTipoRep == 1 //Si es Reporte Sintetico

				oSection2:Cell("ECX"):SetBlock({|| EntidadeCTB(cCtaNomSup, 000, 000, 030, .F., cMascara, cSeparador, , , .F., , .F.)})

				oSection2:Cell("ECXDESC"):SetBlock({|| cCtaDesSup})

				//Se deshabilita Columna NIT
				oSection2:Cell("ECY"):Disable()
				oSection2:Cell("ECYDESC"):Disable()
				//Se deshabilita Columna Descripcion NIT
				oSection1:Cell("ECY"):Disable()
				oSection1:Cell("ECYDESC"):Disable()

				oSection2:Cell("SALDOANT"):SetBlock({|| ValorCTB(nSldAnt, , , nTamCols, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})
				oSection2:Cell("SALDODEB"):SetBlock({|| ValorCTB(nTotDeb, , , nTamCols, nDecimais, .F., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})
				oSection2:Cell("SALDOCRD"):SetBlock({|| ValorCTB(nTotCrd, , , nTamCols, nDecimais, .F., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})
				//Si Imprime Movimiento
				If lImpMov
					oSection2:Cell("MOVIMENTO"):SetBlock({ || ValorCTB(nTotMov, , , nTamCols, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})
				Else
					oSection1:Cell("MOVIMENTO"):Disable()
					oSection2:Cell("MOVIMENTO"):Disable()
				EndIf
				oSection2:Cell("SALDOATU"):SetBlock({|| ValorCTB(nSldAtu, , , nTamCols, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})

				If mv_par15 == 1 //Imprime Saldo Actual por cuenta y Total General
						oBrkGeral := TRBreak():New(oSection1, {|| /*cArqTmp->(!Eof())*/ },{|| STR0004 },,,.F.) //" T O T A L  G E N E R A L  --> "

						oTotGerDeb :=	TRFunction():New(oSection1:Cell("SALDODEB"), ,"ONPRINT", oBrkGeral,"" /*Titulo*/,cPicture,;
						{|| ValorCTB(nTotGerDeb, , , nTamTots, nDecimais, .F., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)
						oTotGerCrd :=	TRFunction():New(oSection1:Cell("SALDOCRD"), , "ONPRINT", oBrkGeral, "", cPicture, ;
						{|| ValorCTB(nTotGerCrd, , , nTamTots, nDecimais, .F., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)
						If lImpMov
							oTotGerMov :=	TRFunction():New(oSection1:Cell("MOVIMENTO"), , "ONPRINT", oBrkGeral, "", cPicture, ;
							{|| ValorCTB(nTotGerMov, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)
						EndIf
				Else // Si no imprime Saldo Actual y Total General
					oBrkGeral := TRBreak():New(oSection2, {|| cArqTmp->(!Eof())}, {|| STR0012}, , , .F.) //"  T O T A L  "
					oTotGerDeb := TRFunction():New(oSection2:Cell("SALDODEB"), , "SUM", oBrkGeral, "", /*cPicture*/, ;
					{|| IIf(cArqTmp->TIPOECX == "2", 0, cArqTmp->SALDODEB)}, .F., .F., .F., oSection2)
					oTotGerDeb:Disable()
					oTotGerCrd := TRFunction():New(oSection2:Cell("SALDOCRD"), , "SUM", oBrkGeral, "", /*cPicture*/, ;
					{|| IIf(cArqTmp->TIPOECX == "2", 0, cArqTmp->SALDOCRD)}, .F., .F., .F., oSection2)
					oTotGerCrd:Disable()
					TRFunction():New(oSection2:Cell("SALDODEB"), , "ONPRINT", oBrkGeral, "", /*cPicture*/, ;
					{|| ValorCTB(oTotGerDeb:GetValue(), , , nTamTots, nDecimais, .F., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection2)
					TRFunction():New(oSection2:Cell("SALDOCRD"), , "ONPRINT", oBrkGeral, "", /*cPicture*/, ;
					{|| ValorCTB(oTotGerCrd:GetValue(), , , nTamTots, nDecimais, .F., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection2)
				EndIf

			Else //Si es Reporte Analitico-Sintetico
				//Impresion Detalle Cuentas Sinteticas
				oSection2:Cell("ECX"):SetBlock({|| EntidadeCTB(cCtaNomSup, 000, 000, 030, .F., cMascara, cSeparador, , , .F., , .F.)})
				oSection2:Cell("ECXDESC"):SetBlock({|| cCtaDesSup})

				//Se deshabilita Columna NIT y Descripcion de NIT de Seccion 1
				oSection2:Cell("ECY"):SetBlock({|| Space(Len(cArqTmp->ECY))}) //NIT
				oSection2:Cell("ECYDESC"):SetBlock({|| Space(Len(cArqTmp->ECYDESC))})//Descripcin NIT
				oSection2:Cell("SALDOANT"):SetBlock({|| ValorCTB(nTotSalAnt, , , nTamCols, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})
				oSection2:Cell("SALDODEB"):SetBlock({|| ValorCTB(nTotDebAna, , , nTamCols, nDecimais, .F., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})
				oSection2:Cell("SALDOCRD"):SetBlock({|| ValorCTB(nTotCrdAna, , , nTamCols, nDecimais, .F., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})
				If lImpMov //Si Imprime Movimiento
					oSection2:Cell("MOVIMENTO"):SetBlock({ || ValorCTB(nTotMovAna, , , nTamCols, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})
				Else
					oSection1:Cell("MOVIMENTO"):Disable()
					oSection2:Cell("MOVIMENTO"):Disable()
					oSection3:Cell("MOVIMENTO"):Disable()
				EndIf
				oSection2:Cell("SALDOATU"):SetBlock({|| ValorCTB(nTotAtuAna, , , nTamCols, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)})

				//Impresion Detalle Cuentas Analiticas
				oSection3:Cell("ECX"):SetBlock( {|| EntidadeCTB(cCtaNomInf,000,000,030,.F.,cMascara,cSeparador,,,.F.,,.F.)} )
				oSection3:Cell("ECXDESC"):SetBlock( { || cCtaDesInf } )

				//Se deshabilita Columna NIT
				oSection3:Cell("ECY"):SetBlock( {|| cArqTmp->ECY } ) //NIT
				oSection3:Cell("ECYDESC"):SetBlock( { || cNITDesInf } )//Descripcin NIT
				oSection1:Cell("ECY"):SetBlock({|| Space(Len(cArqTmp->ECY))})
				oSection1:Cell("ECYDESC"):SetBlock({|| Space(Len(cArqTmp->ECYDESC))})
				oSection3:Cell("SALDOANT"):SetBlock( { || ValorCTB(cArqTmp->SALDOANT,,,nTamCols,nDecimais,.T.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )
				oSection3:Cell("SALDODEB"):SetBlock( { || ValorCTB(cArqTmp->SALDODEB,,,nTamCols,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )
				oSection3:Cell("SALDOCRD"):SetBlock( { || ValorCTB(cArqTmp->SALDOCRD,,,nTamCols,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )

				//Si Imprime Movimiento
				If lImpMov
					oSection3:Cell("MOVIMENTO"):SetBlock({ || ValorCTB(cArqTmp->MOVIMENTO, , , nTamCols, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}) //nTotMovAna
				Else
					oSection1:Cell("MOVIMENTO"):Disable()
					oSection2:Cell("MOVIMENTO"):Disable()
					oSection3:Cell("MOVIMENTO"):Disable()
				EndIf
				oSection3:Cell("SALDOATU"):SetBlock( { || ValorCTB(cArqTmp->SALDOATU,,,nTamCols,nDecimais,.T.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) } )
				If mv_par15 == 1 //Imprime Saldo Actual por cuenta y Total General

					//Totales por cuenta
					oBreak1 := TRBreak():New( oSection3, {|| cArqTmp->ECX }, OemToAnsi(STR0011) ) //"Total Cuenta"

					TRFunction():New(oSection3:Cell("SALDOANT"),,"ONPRINT",oBreak1/*oBreak*/,""/*Titulo*/,cPicture,;
					{ || ValorCTB(nTotSAn,,,nTamTots,nDecimais,.T.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection3 )
					TRFunction():New(oSection3:Cell("SALDODEB"),,"ONPRINT",oBreak1/*oBreak*/,""/*Titulo*/,cPicture,;
					{ || ValorCTB(nTotDeb,,,nTamTots,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection3 )
					TRFunction():New(oSection3:Cell("SALDOCRD"),,"ONPRINT",oBreak1/*oBreak*/,""/*Titulo*/,cPicture,;
					{ || ValorCTB(nTotCrd,,,nTamTots,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection3 )

					TRFunction():New(oSection3:Cell("MOVIMENTO"),,"ONPRINT",oBreak1/*oBreak*/,""/*Titulo*/,cPicture,;
					{ || ValorCTB(nTotMov,,,nTamTots,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection3 )

					TRFunction():New(oSection3:Cell("SALDOATU"),,"ONPRINT",oBreak1/*oBreak*/,""/*Titulo*/,cPicture,;
					{ || ValorCTB(nSldAtu,,,nTamTots,nDecimais,.F.,cPicture,cArqTmp->ECXNORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection3 )

					oBrkGeral := TRBreak():New(oSection1, {|| /*cArqTmp->(!Eof())*/ },{|| STR0004 },,,.F.) //" T O T A L  G E N E R A L  --> "

					oTotGerAnt :=	TRFunction():New(oSection1:Cell("SALDOANT"), ,"ONPRINT", oBrkGeral,"" /*Titulo*/,cPicture,;
					{|| ValorCTB(nTotGerAnt, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)
					oTotGerDeb :=	TRFunction():New(oSection1:Cell("SALDODEB"), ,"ONPRINT", oBrkGeral,"" /*Titulo*/,cPicture,;
					{|| ValorCTB(nTotGerDeb, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)
					oTotGerCrd :=	TRFunction():New(oSection1:Cell("SALDOCRD"), , "ONPRINT", oBrkGeral, "", cPicture, ;
					{|| ValorCTB(nTotGerCrd, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)
					oTotGerSA :=	TRFunction():New(oSection1:Cell("SALDOATU"), , "ONPRINT", oBrkGeral, "", cPicture, ;
					{|| ValorCTB(nTotSldAtu, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)

					If lImpMov
						oTotGerMov :=	TRFunction():New(oSection1:Cell("MOVIMENTO"), , "ONPRINT", oBrkGeral, "", cPicture, ;
						{|| ValorCTB(nTotGerMov, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)

					EndIf
				Else // Si no imprime Saldo Actual y Total General
					oBrkGeral := TRBreak():New(oSection1, {|| /*cArqTmp->(!Eof())*/ },{|| STR0004 },,,.F.) //" T O T A L  G E N E R A L  --> "

					oTotGerDeb :=	TRFunction():New(oSection1:Cell("SALDODEB"), ,"ONPRINT", oBrkGeral,"" /*Titulo*/,cPicture,;
					{|| ValorCTB(nTotGerDeb, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)
					oTotGerCrd :=	TRFunction():New(oSection1:Cell("SALDOCRD"), , "ONPRINT", oBrkGeral, "", cPicture, ;
					{|| ValorCTB(nTotGerCrd, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)

					If lImpMov
						oTotGerMov :=	TRFunction():New(oSection1:Cell("MOVIMENTO"), , "ONPRINT", oBrkGeral, "", cPicture, ;
						{|| ValorCTB(nTotGerMov, , , nTamTots, nDecimais, .T., cPicture, cArqTmp->ECXNORMAL, , , , , , lPrintZero, .F.)}, .F., .F., .F., oSection1)

					EndIf
				EndIf
		EndIf

			If cArqTmp->(EoF())
				Aviso(STR0013,STR0014,{"Ok"}) //"Atención" //"No existen datos para los parámetros especificados."
				cArqTmp->(dbCloseArea())
				oReport:CancelPrint()
				Return
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³INICIO DA IMPRESSAO DA 1A SECAO³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oSection1:Init()

				oSection1:PrintLine()

				If nTipoRep <> 1 .And. nTipoRep <> 2
					oSection2:Init()
				EndIf
				dbselectarea("CV0")
				CV0->(dbsetorder(2))
				If nTipoRep == 1 //Sintético
					While !cArqTmp->(Eof()) .And. !oReport:Cancel()

						If oReport:Cancel()
							cArqTmp->(dbCloseArea())
							Exit
						EndIf

						cTipoAnt := cArqTmp->TIPOECX

						// Verifica salto de linha para conta sintetica (MV_PAR09)
						If lPula .And. (cTipoAnt == "1" .Or. (cTipoAnt == "1" .And. cTipoAnt == "2"))
							oReport:SkipLine()
						EndIf

						// Verifica numero maximo de linhas por pagina (MV_PAR11)
						If !Empty(nMaxLin)
							CTBR820Max(nMaxLin,@nLinReport)
						EndIf

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³INICIO DA IMPRESSAO DA 2A SECAO³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

						oSection2:Init()

						cContaAnt	:= cArqTmp->ECXSUP
						cCondic		:= "cArqTmp->ECXSUP"

						Do While cArqTmp->(!Eof() .And. &cCondic == cContaAnt ) .And. !oReport:Cancel()

							If oReport:Cancel()
								cArqTmp->(dbCloseArea())
								Exit
							EndIf

							// Verifica quebra de pagina por conta (mv_par11)
							If lQbConta .And. cArqTmp->NIVEL1
								oReport:EndPage()
								nLinReport := 9
								Return
							EndIf

							cCtaNomSup	:= cArqTmp->ECXSUP
							cCtaDesSup	:= CTBR820DES(cFilCT1, cArqTmp->ECXSUP, "CT1")

							nTotDeb	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->SALDODEB)
							nTotCrd	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->SALDOCRD)
							nTotMov	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->MOVIMENTO)

							nSldAtu += cArqTmp->SALDOANT - cArqTmp->SALDODEB + cArqTmp->SALDOCRD
							nSldAnt += cArqTmp->SALDOANT

							nTotGerDeb	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->SALDODEB)
							nTotGerCrd	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->SALDOCRD)
							nTotGerMov	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->MOVIMENTO)
							nTotSldAtu += cArqTmp->SALDOANT - cArqTmp->SALDODEB + cArqTmp->SALDOCRD
							nTotSldAnt  += cArqTmp->SALDOANT

							oReport:IncMeter()

							cArqTmp->(dbSkip())
						EndDo

						oSection2:PrintLine()
						oSection2:Finish()

						nTotDeb	:= 0
						nTotCrd	:= 0
						nTotMov	:= 0
						nSldAtu	:= 0
						nSldAnt	:= 0

						oReport:SkipLine()
						nLinReport++
					EndDo

				ElseIf nTipoRep == 2 //Analítico
					While !cArqTmp->(Eof()) .And. !oReport:Cancel()

						If oReport:Cancel()
							cArqTmp->(dbCloseArea())
							Exit
						EndIf

						cTipoAnt := cArqTmp->TIPOECX

						// Verifica salto de linha para conta sintetica (MV_PAR09)
						If lPula .And. (cTipoAnt == "1" .Or. (cTipoAnt == "1" .And. cTipoAnt == "2"))
							oReport:SkipLine()
						EndIf

						// Verifica numero maximo de linhas por pagina (MV_PAR11)
						If !Empty(nMaxLin)
							CTBR820Max(nMaxLin,@nLinReport)
						EndIf

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³INICIO DA IMPRESSAO DA 2A SECAO³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						oSection2:Init()

						cContaAnt	:= cArqTmp->ECX
						cCondic		:= "cArqTmp->ECX"

						Do While cArqTmp->(!Eof() .And. &cCondic == cContaAnt ) .And. !oReport:Cancel()

							If oReport:Cancel()
								cArqTmp->(dbCloseArea())
								Exit
							EndIf

							// Verifica quebra de pagina por conta (mv_par11)
							If lQbConta .And. cArqTmp->NIVEL1
								oReport:EndPage()
								nLinReport := 9
								Return
							EndIf

							nTotDeb	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->SALDODEB)
							nTotCrd	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->SALDOCRD)
							nTotMov	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->MOVIMENTO)

							nSldAtu += cArqTmp->SALDOANT - cArqTmp->SALDODEB + cArqTmp->SALDOCRD
							nSldAnt += cArqTmp->SALDOANT

							nTotGerDeb	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->SALDODEB)
							nTotGerCrd	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->SALDOCRD)
							nTotSldAtu += cArqTmp->SALDOANT - cArqTmp->SALDODEB + cArqTmp->SALDOCRD
							nTotGerMov	+= If(cArqTmp->TIPOECX == "1", 0, cArqTmp->MOVIMENTO)
							nTotSldAnt  += cArqTmp->SALDOANT

							cNITDesInf	:= cArqTmp->ECYSUP

							oSection2:PrintLine()
							oReport:IncMeter()

							cArqTmp->(dbSkip())
						EndDo

						oSection2:Finish()

						nTotDeb	:= 0
						nTotCrd	:= 0
						nTotMov	:= 0
						nSldAtu	:= 0
						nSldAnt	:= 0

						oReport:SkipLine()
						nLinReport++
					EndDo

				ElseIf nTipoRep == 3 //Ambos (Analítico-Sintético)
					While !cArqTmp->(Eof()) .And. !oReport:Cancel()

						If oReport:Cancel()
							cArqTmp->(dbCloseArea())
							Exit
						EndIf

						// Verifica numero maximo de linhas por pagina (MV_PAR11)
						If !(Empty(nMaxLin))
							CTBR820Max(nMaxLin,@nLinReport)
						EndIf

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³INICIO DA IMPRESSAO DA 2A SECAO³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

						cContaAnt	:= cArqTmp->ECXSUP
						cCondic		:= "cArqTmp->ECXSUP"

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³INICIO DA IMPRESSAO DA 3A SECAO³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						cCtaAnalit := cArqTmp->ECX
						cCondicAna := "cArqTmp->ECX"

						If cArqTmp->TIPOECX == "1"
							cCtaNomSup	:= cArqTmp->ECX
							cCtaDesSup	:= cArqTmp->ECXDESC
							nTotSalAnt  := cArqTmp->SALDOANT
							nTotDebAna  := cArqTmp->SALDODEB
							nTotCrdAna  := cArqTmp->SALDOCRD
							nTotAtuAna  := cArqTmp->SALDOATU
							nTotMovAna  := cArqTmp->MOVIMENTO
							oReport:IncMeter()
							oSection2:PrintLine()

							If lPula
								oReport:SkipLine()
							EndIf
							cArqTmp->(dbSkip())
						Else
							oSection3:PrintLine()

							oSection3:Init()

							cContaAnt	:= cArqTmp->ECX
							cCondic		:= "cArqTmp->ECX"

							Do While cArqTmp->(!(Eof()) .And. &cCondic == cContaAnt) .And. !oReport:Cancel()

								//Totales Analitica
								cCtaNomInf	:= cArqTmp->ECX
								cCtaDesInf	:= cArqTmp->ECXDESC
								cNITNomInf	:= cArqTmp->ECY
								cNITDesInf	:= cArqTmp->ECYSUP

								nTotSAn += cArqTmp->SALDOANTDB - cArqTmp->SALDOANTCR
								nTotDeb	+= cArqTmp->SALDODEB
								nTotCrd	+= cArqTmp->SALDOCRD
								nTotMov	+= (cArqTmp->SALDODEB - cArqTmp->SALDOCRD)
								nSldAtu	+= (cArqTmp->SALDOANTDB - cArqTmp->SALDOANTCR) + (cArqTmp->SALDODEB - cArqTmp->SALDOCRD)

								nTotGerAnt  += cArqTmp->SALDOANTDB - cArqTmp->SALDOANTCR
								nTotGerDeb	+= cArqTmp->SALDODEB
								nTotGerCrd	+= cArqTmp->SALDOCRD
								nTotGerMov	+= (cArqTmp->SALDODEB - cArqTmp->SALDOCRD)
								nTotSldAtu  += (cArqTmp->SALDOANTDB - cArqTmp->SALDOANTCR) + (cArqTmp->SALDODEB - cArqTmp->SALDOCRD)
								nTotSldAnt  += cArqTmp->SALDOANT

								oSection3:PrintLine()
								cArqTmp->(dbSkip())
								oReport:IncMeter()

							EndDo
							oSection3:Finish()
						EndIf

						nTotSAn := 0
						nTotDeb	:= 0
						nTotCrd	:= 0
						nTotMov := 0
						nSldAtu	:= 0
						nSldAnt	:= 0

						nLinReport++
					EndDo
				EndIf

				If nTipoRep != 1 .And. nTipoRep != 2 //1-Sistetica //2-Analitica
					oSection2:Finish()
					oSection3:Finish()
				EndIf
				oSection1:Finish()
			EndIf
	EndIf

	dbSelectArea("cArqTmp")
	Set Filter To
	cArqTmp->(dbCloseArea())

	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil
	EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR820Maxº Autor ³ Marco A. Gonzalez       º Data ³  26/04/16  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ En base en el parametro MV_PAR11 ("Num. Lineas p/Balance       º±±
±±º          ³ Modelo 1"), cuyo contenido esta en la variable "nMaxLin",      º±±
±±º          ³ controla el salto de pagina en tReport. (COL)                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR820                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTBR820Max(nMaxLin,nLinReport)

	nLinReport++

	If nLinReport > nMaxLin
		oReport:EndPage()
		nLinReport := 10
	EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CTBR820nTR   º Autor ³ Marco A. Gonzalez       º Data ³ 26/04/16º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Llama a la funcion estandar CtCGCCabTR() reiniciando el contadorº±±
±±º          ³ de lineas para el control del informe. (COL)                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR820                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTBR820nTR(dDataFim,dDataIni,cTitulo,oReport)

	nLinReport := 10

Return CtCGCCabTR(,,,,,dDataFim,cTitulo,,,,,oReport,,,,,,,,,,dDataIni)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CTBR820GerPla³ Autor ³ Marco A. Gonzalez            ³ Data ³ 26/04/16³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Genera el archivo temporal para el Balance. (COL)                    |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTBR820GerPla(ExpO1,ExpO2,ExpO3,ExpL1,ExpC1,ExpD1,ExpD2,ExpC2,ExpC3, ³±±
±±³          ³              ExpC4,ExpC5,ExpC6,ExpC7,ExpC8,ExpC9,ExpC10,ExpC11,     ³±±
±±³          ³              ExpC12,ExpC13,ExpA1,ExpC14,ExpC15,ExpC16,ExpC17,ExpC18,³±±
±±³          ³              ExpL2,ExpL3,ExpN1,ExpC19,ExpL3,ExpD3,ExpN2,ExpL4,      ³±±
±±³          ³              ExpC20,ExpC21,ExpC22,ExpC23,ExpC24,ExpC25,ExpL5,ExpC26,³±±
±±³          ³              ExpC27,ExpN3,ExpA1,ExpL6,ExpL7,ExpC28,ExpL8,ExpC29,    ³±±
±±³          ³              ExpD5,ExpL9,ExpL10,ExpL11,ExpL12,ExpL13,ExpL14,ExpC30, ³±±
±±³          ³              ExpL15,ExpA2,ExpD6,ExpL16,ExpL17,ExpL18,ExpC31,ExpL19, ³±±
±±³          ³              ExpC32,ExpL20,ExpC33,ExpA3,ExpC34)                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1    = Regla de Control                                         ³±±
±±³          ³ ExpO2    = Regla de Control                                         ³±±
±±³          ³ ExpO3    = Ventana                                                  ³±±
±±³          ³ ExpL1    = Regla de Control -> Finalizar                            ³±±
±±³          ³ ExpC1    = Archivo Temporal                                         ³±±
±±³          ³ ExpD1    = Fecha Inicial de procesamiento                           ³±±
±±³          ³ ExpD2    = Fecha Final de procesamiento                             ³±±
±±³          ³ ExpC2    = Alias del archivo                                        ³±±
±±³          ³ ExpC3    = Identificador del archivo a ser procesado                ³±±
±±³          ³ ExpC4    = Cuenta Inicial                                           ³±±
±±³          ³ ExpC5    = Cuenta Final                                             ³±±
±±³          ³ ExpC6    = Centro de Costo Inicial                                  ³±±
±±³          ³ ExpC7    = Centro de Costo Final                                    ³±±
±±³          ³ ExpC8    = Item Inicial                                             ³±±
±±³          ³ ExpC9    = Item Final                                               ³±±
±±³          ³ ExpC10   = Valor Inicial de la Clase                                ³±±
±±³          ³ ExpC11   = Valor Final de la Clase                                  ³±±
±±³          ³ ExpC12   = Moneda                                                   ³±±
±±³          ³ ExpC13   = Tipos de Saldo a ser procesados                          ³±±
±±³          ³ ExpC14   = Matriz de Configuracion de Libros                        ³±±
±±³          ³ ExpC15   = Indica que segmento sera filtrado                        ³±±
±±³          ³ ExpC16   = Contenido Inicial del Segmento                           ³±±
±±³          ³ ExpC17   = Contenido Final del Segmento                             ³±±
±±³          ³ ExpC18   = Filtrar por Segmento                                     ³±±
±±³          ³ ExpL2    = Si imprime la entidad sin movimiento                     ³±±
±±³          ³ ExpL3    = Si imprime la cuenta                                     ³±±
±±³          ³ ExpN1    = Grupo                                                    ³±±
±±³          ³ ExpC19   = Identifica cual es la entidad principal                  ³±±
±±³          ³ ExpL3    = Imprime perdidas y ganancias                             ³±±
±±³          ³ ExpD3    = Fecha de ultima aparicion de perdidad y ganancias        ³±±
±±³          ³ ExpN2    = Divide valores por (100,1000,1000000)                    ³±±
±±³          ³ ExpL4    = Graba o no los valores reducidos a cero en Archivo       ³±±
±±³          ³            temporal                                                 ³±±
±±³          ³ ExpC20   = Entidad Gerencial que servira de filtro dentro           ³±±
±±³          ³            de otra Entidad Gerencial. Ex.: Centro de Costo          ³±±
±±³          ³            siendo filtrado por Item Contable (CTH)                  ³±±
±±³          ³ ExpC21   = Codigo de Entidad Gerencial utilizada como filtro        ³±±
±±³          ³ ExpC22   = Filtra por Segmento Gerencial (CC/Item o ClVl)           ³±±
±±³          ³ ExpC23   = Segmento Gerencial Inicial                               ³±±
±±³          ³ ExpC24   = Segmento Gerencial Final                                 ³±±
±±³          ³ ExpC25   = Segmento Gerencial Contenido en                          ³±±
±±³          ³ ExpL5    = Si el balance de comprobacion y convers. de moneda       ³±±
±±³          ³ ExpC26   = Moneda para la cual buscara un criterio de               ³±±
±±³          ³            conversion en Pl. Cuentas                                ³±±
±±³          ³ ExpC27   = Criterio de convers. utilizado: 1-Diario, 2-Medio,       ³±±
±±³          ³            3-Mensual, 4-Informada, 5-Plan de Cuentas                ³±±
±±³          ³ ExpD4    = Fecha de Conversion                                      ³±±
±±³          ³ ExpN3    = Tarifa de Conversion                                     ³±±
±±³          ³ ExpA1    = Matriz que almacena los compositores del Pl. Geren.      ³±±
±±³          ³            para efectuar el filtro del informe.                     ³±±
±±³          ³ ExpL6    = No utilizado                                             ³±±
±±³          ³ ExpL7    = Si la actualizacion es sintetica                         ³±±
±±³          ³ ExpC28   = Filtro informado por el usuario                          ³±±
±±³          ³ ExpL8    = Si imprime saldo del periodo anterior de                 ³±±
±±³          ³            restablecimiento                                         ³±±
±±³          ³ ExpC29   = Ingresos y Gastos del Grupo                              ³±±
±±³          ³ ExpD5    = Fecha de gastos e ingresos de restablecimiento           ³±±
±±³          ³ ExpL9    = Si el Balance C.Custo / Conta / Item                     ³±±
±±³          ³ ExpL10   = Si el Balance por CC x Cta x Item x Cl.Valor             ³±±
±±³          ³ ExpL11   = Si el Balance de Entidad (C.Custo/Item/Cl.Vlr            ³±±
±±³          ³            por Entid. Gerencial)                                    ³±±
±±³          ³ ExpL12   = Si considera el filtro de preguntas para C.Custo         ³±±
±±³          ³ ExpL13   = Si considera el filtro de preguntas para Item            ³±±
±±³          ³ ExpL14   = Si considera el filtro de preguntas para Cl.Valor        ³±±
±±³          ³ ExpC30   = Codigo de moneda para descripcion de entidades           ³±±
±±³          ³ ExpL15   = Si imprime movimento de periodo anterior                 ³±±
±±³          ³ ExpA2    = Array de filiales                                        ³±±
±±³          ³ ExpD6    = Fecha de corte para calculo de saldo anterior            ³±±
±±³          ³ ExpL16   = Imprime vision gerencial sintetica? Estandar .F.         ³±±
±±³          ³ ExpL17   = Consulta saldo ? Estandar .F.                            ³±±
±±³          ³ ExpL18   = Consulta saldo entre entidades? Estandar .F.             ³±±
±±³          ³ ExpC31   = Arquivo auxiliar permitindo a recursividade              ³±±
±±³          ³ ExpL19   = Usa nombre de Vision Gerencial? Estandar .F.             ³±±
±±³          ³ ExpC32   = Nombre de Vis. Gerencial (Retorno, pasar por ref.)       ³±±
±±³          ³ ExpL20   = Indica si imprime o no C. Costo Sintetico 	           ³±±
±±³          ³ ExpC33   = Codigo de Tabla de Contabilidad                          ³±±
±±³          ³ ExpA3    = Array con las entidades de inicio y fin                  ³±±
±±³          ³            Ex. {'Cta Ent. 05 Inicio','Cta. Ent. 05 Final'}          ³±±
±±³          ³ ExpC34   = Codigo de Entidad                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T. / .F.                                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CTBR820GerPla(oMeter,oText,oDlg,lEnd,cArqtmp,dDataIni,dDataFim,cAlias,cIdent,cContaIni,cContaFim,;
						cCCIni,cCCFim,cItemIni,cItemFim,cClvlIni,cClVlFim,cMoeda,cSaldos,aSetOfBook,cSegmento,;
						cSegIni,cSegFim,cFiltSegm,lNImpMov,lImpConta,nGrupo,cHeader,lImpAntLP,dDataLP,;
						nDivide,lVlrZerado,cFiltroEnt,cCodFilEnt,cSegmentoG,cSegIniG,cSegFimG,cFiltSegmG,;
						lUsGaap,cMoedConv,cConsCrit,dDataConv,nTaxaConv,aGeren,lImpMov,lImpSint,cFilUSU,lRecDesp0,;
						cRecDesp,dDtZeraRD,lImp3Ent,lImp4Ent,lImpEntGer,lFiltraCC,lFiltraIt,lFiltraCV,cMoedaDsc,;
						lMovPeriodo,aSelFil,dDtCorte,lPlGerSint,lConsSaldo,lCompEnt,cArqAux,lUsaNmVis,cNomeVis,lCttSint,;
						lTodasFil,cQuadroCTB,aEntidades,cCodEntidade)

	Local aTamConta		:= TamSX3("CT1_CONTA")
	Local aTamCtaRes	:= TamSX3("CT1_RES")
	Local aTamCC		:= TamSX3("CTT_CUSTO")
	Local aTamCCRes		:= TamSX3("CTT_RES")
	Local aTamVal		:= TamSX3("CT2_VALOR")
	Local aCtbMoeda		:= {}
	Local aCampos		:= {}
	Local aTmpFil		:= {}
	Local aSaveArea		:= GetArea()

	Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC" + cMoeda))
	Local nTamCC		:= Len(CriaVar("CTT->CTT_DESC" + cMoeda))
	Local nTamGrupo		:= Len(CriaVar("CT1->CT1_GRUPO"))
	Local nTamDNIT		:= Len(CriaVar("CV0->CV0_DESC"))
	Local nDecimais		:= 0
	Local nCampoLP		:= 0
	Local nX			:= 0
	Local nTamFilial	:= IIf(lFWCodFil, FWGETTAMFILIAL, 2)
	Local nMeter		:= 0

	Local cChave		:= ""
	Local cEntidIni		:= ""
	Local cEntidFim		:= ""
	Local cCodMasc		:= ""

	Local lAtSldBase	:= IIf(GetMV("MV_ATUSAL")== "S",.T.,.F.)
	Local lTemQuery		:= .F.
	Local lCriaInd		:= .F.
	Local lImpSup		:= IIf(MV_PAR16 == 3, .T., .F.) //Tipo de Reporte
	Local lAgrega       := .F.
	Local CFILCV0       := xFilial("CV0")

	Local aStruTmp	:= {}
	Local lTemQry	:= .F.
	Local nTrb		:= 0

	//Variaveis para atualizar a regua desde as rotinas de geracao do arquivo temporario
	Private oMeter1 	:= oMeter
	Private oText1 		:= oText

	Default aEntidades		:= {}
	Default aSelFil			:= {}

	Default lConsSaldo		:= .F.
	Default lPlGerSint		:= .F.
	Default lUsGaap			:= .F.
	Default lImpSint		:= .T.
	Default lImpMov			:= .T.
	Default lRecDesp0		:= .F.
	Default lImp3Ent		:= .F.
	Default lImp4Ent		:= .F.
	Default lImpEntGer		:= .F.
	Default lImpConta		:= .T.
	Default lFiltraCC		:= .F.
	Default lFiltraIt		:= .F.
	Default lFiltraCV		:= .F.
	Default lMovPeriodo		:= .F.
	Default lCompEnt		:= .F.
	Default lUsaNmVis		:= .F.
	Default lCttSint		:= .F.
	Default lTodasFil		:= .F.

	Default cSegmentoG		:= ""
	Default cMoedConv		:= ""
	Default cConsCrit		:= ""
	Default cFilUsu			:= ".T."
	Default cRecDesp		:= ""
	Default cMoedaDsc		:= '01'
	Default cSegmento		:= ""
	Default cArqAux			:= "cArqTmp"
	Default cArqTmp			:= Nil
	Default cQuadroCTB		:= ""
	Default cCodEntidade	:= ""

	Default dDataConv		:= CTOD("  /  /  ")
	Default dDtZeraRD		:= CTOD("  /  /  ")
	Default dDtCorte		:= CTOD("  /  /  ")

	Default nTaxaConv		:= 0

	__aTmpTCFil	:=	{}

	cIdent		:= IIf(cIdent == Nil		, ''	, cIdent)
	nGrupo		:= IIf(nGrupo == Nil		, 2		, nGrupo)
	cHeader		:= IIf(cHeader == Nil		, ''	, cHeader)
	cFiltroEnt	:= IIf(cFiltroEnt == Nil	, ""	, cFiltroEnt)
	cCodFilEnt	:= IIf(cCodFilEnt == Nil	, ""	, cCodFilEnt)

	Private nMin	:= 0
	Private nMax	:= 0

	// Retorna Decimais
	aCtbMoeda	:= CTbMoeda(cMoeda)
	nDecimais	:= aCtbMoeda[5]
	dMinData	:= CTOD("")

	If ExistBlock("ESPGERPLAN")
		ExecBlock("ESPGERPLAN",.F.,.F.,{oMeter,oText,oDlg,lEnd,cArqtmp,dDataIni,dDataFim,cAlias,cIdent,cContaIni,cContaFim,;
			cCCIni,cCCFim,cItemIni,cItemFim,cClvlIni,cClVlFim,cMoeda,cSaldos,aSetOfBook,cSegmento,cSegIni,;
			cSegFim,cFiltSegm,lNImpMov,lImpConta,nGrupo,cHeader,lImpAntLP,dDataLP,nDivide,lVlrZerado,;
			cFiltroEnt,cCodFilEnt,cSegmentoG,cSegIniG,cSegFimG,cFiltSegmG,lUsGaap,cMoedConv,;
			cConsCrit,dDataConv,nTaxaConv,aGeren,lImpMov,lImpSint,cFilUSU,lRecDesp0,;
			cRecDesp,dDtZeraRD,lImp3Ent,lImp4Ent,lImpEntGer,lFiltraCC,lFiltraIt,lFiltraCV,aSelFil,dDtCorte,cQuadroCTB })

		Return(cArqTmp)
	EndIf

	aCampos := {{ "ECX"			, "C", aTamConta[1]	, 0			},;	// Codigo da Conta
		{ "ECXSUP"		, "C", aTamConta[1]	, 0			},;	// Conta Superior
		{ "ECXNORMAL"	, "C", 01			, 0			},;	// Situacao
		{ "ECXRES"		, "C", aTamCtaRes[1], 0			},;	// Codigo Reduzido da Conta
		{ "ECXDESC"		, "C", nTamCta		, 0			},;	// Descricao da Conta
		{ "ECY"			, "C", aTamCC[1]+14	, 0			},;	// Codigo do Centro de Custo
		{ "ECYSUP"		, "C", nTamDNIT	, 0			    },;	// Conta Superior
		{ "ECYNORMAL"	, "C", 01			, 0			},;	// Situacao
		{ "ECYRES"		, "C", aTamCCRes[1]	, 0			},;	// Codigo Reduzido do Centro de Custo
		{ "ECYDESC"		, "C", nTamCC		, 0			},;	// Descricao do Centro de Custo
		{ "SALDOANT"	, "N", aTamVal[1]+2	, nDecimais	},;	// Saldo Anterior
		{ "SALDOANTDB"	, "N", aTamVal[1]+2	, nDecimais },;	// Saldo Anterior Debito
		{ "SALDOANTCR"	, "N", aTamVal[1]+2	, nDecimais },;	// Saldo Anterior Credito
		{ "SALDODEB"	, "N", aTamVal[1]+2	, nDecimais },;	// Debito
		{ "SALDOCRD"	, "N", aTamVal[1]+2	, nDecimais },;	// Credito
		{ "SALDOATU"	, "N", aTamVal[1]+1	, nDecimais },;	// Saldo Atual
		{ "SALDOATUDB"	, "N", aTamVal[1]+2	, nDecimais },;	// Saldo Atual Debito
		{ "SALDOATUCR"	, "N", aTamVal[1]+2	, nDecimais },;	// Saldo Atual Credito
		{ "MOVIMENTO"	, "N", aTamVal[1]+2	, nDecimais },;	// Movimento do Periodo
		{ "TIPOECX"		, "C", 01			, 0			},;	// Conta Analitica / Sintetica
		{ "TIPOECY"		, "C", 01			, 0			},;	// Centro de Custo Analitico / Sintetico
		{ "ORDEM"		, "C", 10			, 0			},;	// Ordem
		{ "GRUPO"		, "C", nTamGrupo	, 0			},;	// Grupo Contabil
		{ "IDENTIFI"	, "C", 01			, 0			},;
		{ "TOTVIS"		, "C", 01			, 0			},;
		{ "SLDENT"		, "C", 01			, 0			},;
		{ "FATSLD"		, "C", 01			, 0			},;
		{ "VISENT"		, "C", 01			, 0			},;
		{ "ESTOUR"		, "C", 01			, 0			},;	//Define se a conta esta estourada ou nao
		{ "NIVEL1"		, "L", 01			, 0			},;
		{ "NATCTA"		, "C", 02			, 0			}}	//NATCTA -campo de natureza da conta para relatorio CTBR047

	aAdd(aCampos, {"FILIAL", "C", nTamFilial, 0}) // Cria Filial do Sistema
	If __Release .and. CTS->(FieldPos("CTS_COLUN2")) > 0
		aAdd(aCampos, { "COLUNA"   	, "N", 01			, 0 })
	Else
		If CTS->(FieldPos("CTS_COLUNA")) > 0
			aAdd(aCampos, { "COLUNA"   	, "N", 01			, 0 })
		EndIf
	EndIf
	If 	Type("dSemestre") # "U" .And. ValType(dSemestre) = "D"
		aAdd(aCampos, {"SALDOSEM", "N", 17, nDecimais}) // Saldo semestre
	EndIf

	If Type("dPeriodo0") # "U" .And. ValType(dPeriodo0) = "D"
		aAdd(aCampos, {"SALDOPER", "N", 17, nDecimais }) // Saldo Periodo determinado
		aAdd(aCampos, {"MOVIMPER", "N", 17, nDecimais }) // Saldo Periodo determinado
	EndIf

	If Type("lComNivel") # "U" .And. ValType(lComNivel) = "L"
		aAdd(aCampos, {"NIVEL", "N", 02, 0 }) // Nivel hieraquirco - Quanto maior mais analitico
	EndIf

	If lMovPeriodo
		aAdd(aCampos, {"MOVPERANT", "N", 17, nDecimais}) // Saldo Periodo Anterior
	EndIf

	// TRATAMENTO PARA ATUALIZACION DE SALDO BASE
	//Se os saldos basicos nao foram atualizados na dig. lancamentos
	If !lAtSldBase
		dIniRep := ctod("")
		If Need2Reproc(dDataFim,cMoeda,cSaldos,@dIniRep)
			//Chama Rotina de Atualizacao de Saldos Basicos.
			oProcess := MsNewProcess():New({|lEnd|	CTBA190(.T.,dIniRep,dDataFim,cFilAnt,cFilAnt,cSaldos,.T.,cMoeda) },"","",.F.)
			oProcess:Activate()
		EndIf
	EndIf

	//************************************
	// Consulta saldo pelo cubo contabil *
	//************************************
	cEntidIni	:= cContaIni
	cEntidFim	:= cContaFim
	cCodMasc	:= aSetOfBook[2]
	cChave		:= "ECX+ECYSUP"

	//Se nao tiver plano gerencial.
	If Empty(aSetOfBook[5])
		// EXECUTA QUERY RETORNANDO A ESTRUTURA E SALDOS NO ALIAS TRBTMP
		If cFilUsu == ".T."
			cFilUsu := ""
		EndIf
		CTBR820Ctb(dDataIni,dDataFim,cAlias,cEntidIni,cEntidFim,cCCIni,cCCFim,cMoeda,;
		cSaldos,aSetOfBook,lImpMov,lVlrZerado,lImpAntLp,dDataLP,cFilUsu,cMoedaDsc,aSelFil,dDtCorte,lTodasFil,aTmpFil)
		If Empty(cFilUSU)
			cFILUSU := ".T."
		EndIf
		lTemQuery := .T.
	EndIf

	If !(Empty(aSetOfBook[5]))				// Indica qual o Plano Gerencial Anexado
		cChave := "ECX+ECY"
	EndIf

	If Empty(aCampos)
		ConOut(STR0019) //"Error en la creación de la tabla temporal"
		Return .F.
	EndIf

	aOrdem1	:= StrTokArr(cChave, "+")
	aOrdem2 := {"ORDEM"}

	oTmpTable := FWTemporaryTable():New(cArqAux)
	oTmpTable:SetFields(aCampos)
	oTmpTable:AddIndex("IN1", aOrdem1)
	oTmpTable:AddIndex("IN2", aOrdem2)
	oTmpTable:Create()

	lCriaInd := .T.

	DbSelectarea(cArqAux)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Indice Temporario do Arquivo de Trabalho 1.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lCriaInd
		DBSetOrder(1)

		If !(Empty(aSetOfBook[5]))	// Indica qual o Plano Gerencial Anexado
			DBSetOrder(2)
		EndIf
	EndIf

	If lTemQuery .and. Select("TRBTMP") > 0 	// E O ALIAS TRBTMP ESTIVER ABERTO (INDICANDO QUE A QUERY FOI EXECUTADA)
		dbSelectArea("TRBTMP")
		aStruTMP := dbStruct()	// OBTEM A ESTRUTURA DO TMP
		nCampoLP := Ascan(aStruTMP,{|x| x[1]=="SLDLPANTDB"})

		If ValType(oMeter) == "O"
			oMeter:SetTotal(TRBTMP->(RecCount()))
			oMeter:Set(0)
		EndIf

		lAgrega := Empty(cFILUSU)
		If !lAgrega
			lAgrega := &("TRBTMP->("+cFILUSU+")")
		EndIf

		TRBTMP->(dbGoTop())	// POSICIONA NO 1º REGISTRO DO TMP
		While TRBTMP->(!Eof())	// REPLICA OS DADOS DA QUERY (TRBTMP) PARA P/ O TEMPORARIO EM DISCO
			//Se nao considera apuracao de L/P sera verificado na propria query
			dbSelectArea("TRBTMP")
			If !lVlrZerado .And. lImpAntLP .And. nCampoLP > 0
				If TRBTMP->((SALDOANTDB - SLDLPANTDB) - (SALDOANTCR - SLDLPANTCR)) == 0 .And. TRBTMP->SALDODEB == 0 .And. TRBTMP->SALDOCRD == 0
					TRBTMP->(dbSkip())
					Loop
				EndIf
			ElseIf !lVlrZerado
				If TRBTMP->(SALDOANTDB - SALDOANTCR) == 0 .And. TRBTMP->SALDODEB == 0 .And. TRBTMP->SALDOCRD == 0
					TRBTMP->(dbSkip())
					Loop
				EndIf
			EndIf

			If lAgrega
				RecLock(cArqAux,.T.)

				For nTRB := 1 to Len(aStruTMP)
					Field->&(aStruTMP[nTRB,1]) := TRBTMP->&(aStruTMP[nTRB,1])
					If Subs(aStruTmp[nTRB][1],1,6) $ "SALDODEB/SALDOCRD/SALDOANTDB/SALDOANTCR/SLDLPANTCR/SLDLPANTDB/MOVLPDEB/MOVLPCRD" .And. nDivide > 0
						Field->&(aStruTMP[nTRB,1])	:=((TRBTMP->&(aStruTMP[nTRB,1])))/ndivide
					EndIf
				Next

				(cArqAux)->Filial := cFilAnt
				(cArqAux)->ECYSUP  := CTBR820DES(cFilCV0, cArqTmp->ECY,"CV0")

				If lImpAntLP .And. nCampoLP > 0
					(cArqAux)->SALDOANTDB	:= SALDOANTDB - SLDLPANTDB
					(cArqAux)->SALDOANTCR	:= SALDOANTCR - SLDLPANTCR
				Else
					(cArqAux)->SALDOANTDB	:= SALDOANTDB
					(cArqAux)->SALDOANTCR	:= SALDOANTCR
				EndIf

				(cArqAux)->SALDOANT		:= SALDOANTCR - SALDOANTDB
				(cArqAux)->SALDOATUDB	:= SALDOANTDB + SALDODEB
				(cArqAux)->SALDOATUCR	:= SALDOANTCR + SALDOCRD
				(cArqAux)->SALDOATU		:= SALDOATUCR - SALDOATUDB
				(cArqAux)->MOVIMENTO	:= SALDOCRD   - SALDODEB

				IF (cArqAux)->(FieldPos("NATCTA")) > 0
					(cArqAux)->NATCTA := NATCTA   // Faz retorno do campo CT1_NATCTA
				EndIf

				(cArqAux)->(MsUnlock())
			EndIf

			TRBTMP->(dbSkip())
			nMeter++

			If nMeter%1000 = 0
				If ValType(oMeter) == "O"
					oMeter:Set(nMeter)
				EndIf
			EndIf
		Enddo

		dbSelectArea("TRBTMP")
		TRBTMP->(dbCloseArea())	// FECHA O TRBTMP (RETORNADO DA QUERY)
		lTemQry := .T.
	EndIf

	dbSelectArea(cArqAux)
	dbSetOrder(1)

	If lImpSup //Se imprime para opción Ambas
		//Atualizacao de sinteticas para codebase e topconnect
		CTBR820CS(oMeter,lImpMov,cMoeda,cMoedaDsc)
	EndIf

	dbSelectArea(cArqAux)

	CTDelTmpFil()
	For nX := 1 TO Len(aTmpFil)
		CtbTmpErase(aTmpFil[nX])
	Next

	RestArea(aSaveArea)

Return cArqTmp

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR820Ctb    ºAutor  ³Marco A. Glz.   º Data ³  26/04/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Devuelve alias TRB TMP con la composicion de los saldos     º±±
±±º          ³Cuenta X Item Contable. (COL)                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSintaxe   ³ CTBR820Ctb(ExpD1,ExpD1,ExpC1,ExpC2,ExpC3,ExpC4,ExpC5,ExpC6,º±±
±±º          ³            ExpC7,ExpA1,ExpL1,ExpL2,ExpL3,ExpD3,ExpC8,ExpC9,º±±
±±º          ³            ExpA2,ExpD4,ExpL4,ExpA3)                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ ExpD1 = Fecha Inicial                                      º±±
±±º          ³ ExpD2 = Fecha Final                                        º±±
±±º          ³ ExpC1 = Alias de Filial                                    º±±
±±º          ³ ExpC2 = Cuenta Inicial                                     º±±
±±º          ³ ExpC3 = Cuenta Final                                       º±±
±±º          ³ ExpC4 = EC05 Inicial                                       º±±
±±º          ³ ExpC5 = EC05 Final                                         º±±
±±º          ³ ExpC6 = Moneda                                             º±±
±±º          ³ ExpC7 = Tp. Saldo                                          º±±
±±º          ³ ExpA1 = Matriz Set Of Book                                 º±±
±±º          ³ ExpL1 = Si Imp. Movimiento                                 º±±
±±º          ³ ExpL2 = Si Valor Reajustado                                º±±
±±º          ³ ExpL3 = Si Imprime Anterior LP                             º±±
±±º          ³ ExpD3 = Fecha LP                                           º±±
±±º          ³ ExpC8 = Filial USU                                         º±±
±±º          ³ ExpC9 = Descripcion Monea                                  º±±
±±º          ³ ExpA2 = Matriz Filial                                      º±±
±±º          ³ ExpD4 = Fecha Corte                                        º±±
±±º          ³ ExpL4 = Si Todas las Filiales                              º±±
±±º          ³ ExpA3 = Matriz Tmp Filial                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR820                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTBR820Ctb(dDataIni,dDataFim,cAlias,cContaIni,cContaFim,cEC05Ini,cEC05Fim,cMoeda,cTpSald,aSetOfBook,lImpMov,;
			lVlrZerado,lImpAntLP,dDataLP,cFilUsu,cMoedaDsc,aSelFil,dDtCorte,lTodasFil,aTmpFil)

	Local aAreaQry		:= GetArea()
	Local aTamVlr		:= TamSX3("QL7_DEBITO")
	Local cQuery		:= ""
	Local cTmpQL7Fil	:= ""
	Local cQryFil		:= ""
	Local nTipoRep		:= MV_PAR16 //Tipo de Reporte
	Local cFilQL7		:= xFilial("QL7")
	Local cNameQL7		:= RetSqlName("QL7")

	Default lImpAntLP	:= .F.
	Default lTodasFil	:= .F.

	Default dDataLP		:= CTOD("  /  /  ")
	Default dDtCorte	:= CTOD("  /  /  ")

	Default cMoedaDsc	:= '01'

	Default aSelFil		:= {}
	Default aTmpFil		:= {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratativa para o filtro de filiais  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lTodasFil
		cQryFil := " QL7_FILIAL " + GetRngFil( aSelFil, "QL7", .T., @cTmpQL7Fil )
		aAdd(aTmpFil, cTmpQL7Fil)
	EndIf

	If nTipoRep == 1
		cQuery := "SELECT QL7.QL7_CONTA, CT1.CT1_NORMAL ECXNORMAL, CT1.CT1_CLASSE TIPOECX, CT1.CT1_RES ECXRES, CT1.CT1_CTASUP ECXSUP, CT1.CT1_DESC01 ECXDESC,"
	Else
		cQuery := "SELECT QL7.QL7_CONTA ECX, QL7.QL7_ENT05 ECY, CT1.CT1_NORMAL ECXNORMAL, CT1.CT1_CLASSE TIPOECX, CT1.CT1_RES ECXRES, CT1.CT1_CTASUP ECXSUP, CT1.CT1_DESC01 ECXDESC,"
	EndIf

	//Saldo Débito Anterior
	cQuery += " (SELECT SUM(QL7DT.QL7_DEBITO)"
	cQuery += " FROM " + cNameQL7 + " QL7DT"
	cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
	//Cuenta
	cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
	cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
	//NIT
	If nTipoRep == 1
		cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	Else
		cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
		cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	EndIf
	cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
	cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
	cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
	cQuery += " AND (QL7DT.QL7_DATA < '"	+ DTOS(dDataIni) + "')"
	cQuery += " ) SALDOANTDB,"

	If lImpAntLP
		//Saldo Débito Anterior antes de cálculo de resultados / Cierre de balance
		cQuery += " (SELECT SUM(QL7DT.QL7_DEBITO)"
		cQuery += " FROM " + cNameQL7 + " QL7DT"
		cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
		//Cuenta
		cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
		cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
		//NIT
		If nTipoRep == 1
			cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		Else
			cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
			cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		EndIf
		cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
		cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
		cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
		cQuery += " AND (QL7DT.QL7_DATA < '"	+ DTOS(dDataIni) + "')"
		cQuery += " AND (QL7DT.QL7_LP = 'Z' AND ((QL7DT.QL7_DTLP <> ' ' AND QL7DT.QL7_DTLP >= '"+DTOS(dDataLP)+"') OR (QL7DT.QL7_DTLP = '' AND QL7DT.QL7_DATA >= '"+DTOS(dDataLP)+"')))"
		cQuery += " ) SLDLPANTDB,"
	EndIf

	//Saldo Crédito Anterior
	cQuery += " (SELECT SUM(QL7DT.QL7_CREDIT)"
	cQuery += " FROM " + cNameQL7 + " QL7DT"
	cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
	//Cuenta
	cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
	cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
	//NIT
	If nTipoRep == 1
		cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	Else
		cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
		cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	EndIf
	cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
	cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
	cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
	cQuery += " AND (QL7DT.QL7_DATA < '"	+ DTOS(dDataIni) + "')"
	cQuery += " ) SALDOANTCR,"

	If lImpAntLP
		//Saldo Crédito Anterior antes de cálculo de resultados / Cierre de balance
		cQuery += " (SELECT SUM(QL7DT.QL7_CREDIT)"
		cQuery += " FROM " + cNameQL7 + " QL7DT"
		cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
		//Cuenta
		cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
		cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
		//NIT
		If nTipoRep == 1
			cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		Else
			cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
			cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		EndIf
		cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
		cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
		cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
		cQuery += " AND (QL7DT.QL7_DATA < '"	+ DTOS(dDataIni) + "')"
		cQuery += " AND (QL7DT.QL7_LP = 'Z' AND ((QL7DT.QL7_DTLP <> ' ' AND QL7DT.QL7_DTLP >= '"+DTOS(dDataLP)+"') OR (QL7DT.QL7_DTLP = '' AND QL7DT.QL7_DATA >= '"+DTOS(dDataLP)+"')))"
		cQuery += " ) SLDLPANTCR,"
	EndIf

	//Saldo Débito Actual
	cQuery += " (SELECT SUM(QL7DT.QL7_DEBITO)"
	cQuery += " FROM " + cNameQL7 + " QL7DT"
	cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
	//Cuenta
	cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
	cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
	//NIT
	If nTipoRep == 1
		cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	Else
		cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
		cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	EndIf
	cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
	cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
	cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
	cQuery += " AND QL7DT.QL7_DATA BETWEEN '" + DTOS(dDataIni) + "' AND '"+ DTOS(dDataFim) + "'"
	cQuery += " ) SALDODEB,"

	//Saldo Crédito Actual
	cQuery += " (SELECT SUM(QL7DT.QL7_CREDIT)"
	cQuery += " FROM " + cNameQL7 + " QL7DT"
	cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
	//Cuenta
	cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
	cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
	//NIT
	If nTipoRep == 1
		cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	Else
		cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
		cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	EndIf
	cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
	cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
	cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
	cQuery += " AND QL7DT.QL7_DATA BETWEEN '" + DTOS(dDataIni) + "' AND '"+ DTOS(dDataFim) + "'"
	cQuery += " ) SALDOCRD"

	cQuery += " FROM " + cNameQL7 + " QL7"
	cQuery += " INNER JOIN " + RetSqlName("CT1") + " CT1 ON (QL7.QL7_CONTA = CT1.CT1_CONTA AND CT1.CT1_CLASSE = '2' AND CT1.D_E_L_E_T_ = ' ')"
	cQuery += " WHERE QL7.QL7_FILIAL = '" + cFilQL7 + "'"
	cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
	cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
	cQuery += " AND (QL7.QL7_MOEDA = '"	+ cMoeda + "')"
	cQuery += " AND (QL7.QL7_TPSALD = '"	+ cTpSald + "')"
	cQuery += " AND (QL7.D_E_L_E_T_ = ' ')"

	If !(nTipoRep == 1)
		cQuery += " AND (SELECT COUNT(CV0.CV0_CODIGO) FROM " + RetSqlName("CV0") + " CV0 WHERE CV0.CV0_CODIGO = QL7.QL7_ENT05 AND CV0.CV0_CLASSE= '2' AND CV0.D_E_L_E_T_ = ' ') > 0"
	EndIf

	If !lVlrZerado .And. !lImpAntLP
		cQuery += " AND ((SELECT ROUND(SUM(QL7DT.QL7_DEBITO), 2) - ROUND(SUM(QL7DT.QL7_CREDIT), 2)"
		cQuery += " FROM " + cNameQL7 + " QL7DT"
		cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
		//Cuenta
		cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
		cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
		//NIT
		If nTipoRep == 1
			cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		Else
			cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
			cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		EndIF
		cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
		cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
		cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
		cQuery += " AND (QL7DT.QL7_DATA < '"	+ DTOS(dDataIni) + "')"
		cQuery += " ) <> 0"

		cQuery += " OR"

		cQuery += " (SELECT SUM(QL7DT.QL7_DEBITO)"
		cQuery += " FROM " + cNameQL7 + " QL7DT"
		cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
		//Cuenta
		cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
		cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
		//NIT
		If nTipoRep == 1
			cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		Else
			cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
			cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		EndIf
		cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
		cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
		cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
		cQuery += " AND QL7DT.QL7_DATA BETWEEN '" + DTOS(dDataIni) + "' AND '"+ DTOS(dDataFim) + "'"
		cQuery += " ) <> 0"

		cQuery += " OR"

		cQuery += " (SELECT SUM(QL7DT.QL7_CREDIT)"
		cQuery += " FROM " + cNameQL7 + " QL7DT"
		cQuery += " WHERE QL7DT.QL7_FILIAL = '" + cFilQL7 + "'"
		//Cuenta
		cQuery += " AND QL7DT.QL7_CONTA = QL7.QL7_CONTA"
		cQuery += " AND (QL7.QL7_CONTA BETWEEN '" + cContaIni + "' AND '" + cContaFim + "')"
		//NIT
		If nTipoRep == 1
			cQuery += " AND (QL7DT.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		Else
			cQuery += " AND QL7DT.QL7_ENT05 = QL7.QL7_ENT05"
			cQuery += " AND (QL7.QL7_ENT05 BETWEEN '" + cEC05Ini + "' AND '" + cEC05Fim + "')"
		EndIf
		cQuery += " AND (QL7DT.QL7_MOEDA = '"	+ cMoeda + "')"
		cQuery += " AND (QL7DT.QL7_TPSALD = '"	+ cTpSald + "')"
		cQuery += " AND (QL7DT.D_E_L_E_T_ = ' ')"
		cQuery += " AND QL7DT.QL7_DATA BETWEEN '" + DTOS(dDataIni) + "' AND '"+ DTOS(dDataFim) + "'"
		cQuery += " ) <> 0)"
	EndIf

	If nTipoRep == 1
		cQuery += " GROUP BY QL7_CONTA,CT1_NORMAL,CT1_CLASSE,CT1_RES,CT1_CTASUP,CT1_DESC01"
	Else
		cQuery += " GROUP BY QL7_CONTA,QL7_ENT05,CT1_NORMAL,CT1_CLASSE,CT1_RES,CT1_CTASUP,CT1_DESC01"
	EndIf

	cQuery := ChangeQuery(cQuery)

	If Select("TRBTMP") > 0
		dbSelectArea("TRBTMP")
		TRBTMP->(dbCloseArea())
	EndIf

	dbUseArea(.T., "TOPCONN", TcGenQry( , , cQuery), "TRBTMP", .T., .F.)

	TcSetField("TRBTMP", "SALDOANTDB"	, "N", aTamVlr[1], aTamVlr[2])
	TcSetField("TRBTMP", "SALDOANTCR"	, "N", aTamVlr[1], aTamVlr[2])
	TcSetField("TRBTMP", "SALDODEB"		, "N", aTamVlr[1], aTamVlr[2])
	TcSetField("TRBTMP", "SALDOCRD"		, "N", aTamVlr[1], aTamVlr[2])

	If lImpAntLP
		TcSetField("TRBTMP", "SLDLPANTDB"	, "N", aTamVlr[1], aTamVlr[2])
		TcSetField("TRBTMP", "SLDLPANTCR"	, "N", aTamVlr[1], aTamVlr[2])
	EndIf

	RestArea (aAreaQry)
Return

/*/{Protheus.doc} CTBR820CS
// Obtiene descripción de tablas CV0,CT1
@author Luis Eduardo Enríquez Mata
@since 04/11/2020
@version 1.0
@param oMeter, objeto, Control de regua
@param lNImpMov, lógica, Imprime movimiento Si = .T. o No = .F.
@param cMoeda, caracter, Código de la moneda
@return cMoedaDsc, caracter, Código de la moneda para descripción
/*/
Static Function CTBR820CS(oMeter,lNImpMov,cMoeda,cMoedaDsc)
	Local aSaveArea	:= GetArea()
	Local cContaSup	:= ""
	Local cDesc		:= ""
	Local nSaldoAnt	:= 0
	Local nSaldoAtu	:= 0
	Local nSaldoDeb	:= 0
	Local nSaldoCrd	:= 0
	Local nMovimento:= 0
	Local nSaldoAntD:= 0
	Local nSaldoAntC:= 0
	Local nSaldoAtuD:= 0
	Local nsaldoAtuC:= 0
	Local nRegTmp	:= 0
	Local nMeter	:= 0
	Local lSemestre := FieldPos("SALDOSEM") > 0		// Saldo por semestre
	Local lPeriodo0	:= FieldPos("SALDOPER") > 0		// Saldo dois periodos anteriores
	Local cNatCta	:= ""
	Local cFilCT1   := xFilial("CT1")

	Default cMoedaDsc	:= '01'

	nSaldoAnt	:= cArqTmp->SALDOANT
	nSaldoAtu	:= cArqTmp->SALDOATU
	nSaldoDeb	:= cArqTmp->SALDODEB
	nSaldoCrd	:= cArqTmp->SALDOCRD
	nMovimento	:= cArqTmp->MOVIMENTO

	nSaldoAtuD	:= cArqTmp->SALDOATUDB
	nSaldoAtuC	:= cArqTmp->SALDOATUCR

	//Graba cuentas sintéticas
	dbSelectArea("cArqTmp")
	cArqTmp->(dbGoTop())

	If ValType(oMeter) == "O"
		oMeter:SetTotal(cArqTmp->(RecCount()))
		oMeter:Set(0)
	EndIf

	While cArqTmp->(!Eof())

		If cArqTmp->TIPOECX == "1"
			cArqTmp->(dbSkip())
			Loop
		EndIf

		nRegTmp	    := Recno()
		nSaldoAnt	:= cArqTmp->SALDOANT
		nSaldoAtu	:= cArqTmp->SALDOATU
		nSaldoDeb	:= cArqTmp->SALDODEB
		nSaldoCrd	:= cArqTmp->SALDOCRD
		nMovimento	:= cArqTmp->MOVIMENTO
		nSaldoAtuD	:= cArqTmp->SALDOATUDB
		nSaldoAtuC	:= cArqTmp->SALDOATUCR

		dbSelectArea("CT1")
		CT1->(dbSetOrder(1))

		cContaSup := cArqTmp->ECXSUP
		If Empty(cContaSup)
			dbSelectArea("cArqTmp")
			NIVEL1 := .T.
			dbSelectArea("CT1")
		EndIf

		MsSeek(cFilCT1 + cContaSup)

		While !Eof() .And. CT1->CT1_FILIAL == cFilCT1

			If Empty(cMoedaDsc)
				cDesc := &("CT1->CT1_DESC"+cMoeda)
			Else
				cDesc := &("CT1->CT1_DESC"+cMoedaDsc)
			EndIf

			If Empty(cDesc)		// Caso nao preencher descricao da moeda selecionada
				cDesc := CT1->CT1_DESC01
			Endif

	   		dbSelectArea("cArqTmp")
			dbSetOrder(1)

			If cArqTmp->( FieldPos( "NATCTA" ) ) > 0
				cNatCta := cArqTmp->NATCTA
			EndIf

			If !MsSeek(cContaSup)
				dbAppend()
				cArqTmp->ECX		:= cContaSup
				cArqTmp->ECXSUP	    := CT1->CT1_CTASUP
				cArqTmp->ECXDESC	:= cDesc
				cArqTmp->TIPOECX 	:= CT1->CT1_CLASSE
				cArqTmp->ECXRES    	:= CT1->CT1_RES
				cArqTmp->ECXNORMAL  := CT1->CT1_NORMAL
				cArqTmp->GRUPO		:= CT1->CT1_GRUPO
				If cArqTmp->( FieldPos( "NATCTA" ) ) > 0
					cArqTmp->NATCTA		:= cNatCta
				EndIf
			EndIf

			cArqTmp->SALDOANT 	:= SALDOANT + nSaldoAnt
			cArqTmp->SALDOANTDB := SALDOANTDB + nSaldoAntD
			cArqTmp->SALDOANTCR	:= SALDOANTCR + nSaldoAntC
			cArqTmp->SALDOATU 	:= SALDOATU + nSaldoAtu
			cArqTmp->SALDOATUDB	:= SALDOATUDB + nSaldoAtuD
			cArqTmp->SALDOATUCR	:= SALDOATUCR + nsaldoAtuC
			cArqTmp->SALDODEB 	:= SALDODEB + nSaldoDeb
			cArqTmp->SALDOCRD 	:= SALDOCRD + nSaldoCrd

			If lNImpMov
				cArqTmp->MOVIMENTO := MOVIMENTO + nMovimento
			EndIf

			If lSemestre		// Saldo por semestre
				cArqTmp->SALDOSEM := SALDOSEM 	+ nSaldoSEM
			EndIf

	   		If lPeriodo0		// Saldo dois periodos anteriores
				cArqTmp->SALDOPER := SALDOPER 	+ nSaldoSEM
			EndIf

			dbSelectArea("CT1")
			cContaSup := CT1->CT1_CTASUP
			If Empty(CT1->CT1_CTASUP)
				dbSelectArea("cArqTmp")
				cArqTmp-> NIVEL1 := .T.
				dbSelectArea("CT1")
				Exit
			EndIf
			MsSeek(cFilCT1 + cContaSup)
		EndDo

		dbSelectArea("cArqTmp")
		dbGoto(nRegTmp)
		cArqTmp->(dbSkip())
		nMeter++
		If nMeter%1000 = 0
			If ValType(oMeter) == "O"
		   		oMeter:Set(nMeter)
		  	EndIf
	  	EndIf
	EndDo

	RestArea(aSaveArea)
Return

/*/{Protheus.doc} CTBR820DES
// Obtiene descripción de tablas CV0,CT1
@author Luis Eduardo Enríquez Mata
@since 04/11/2020
@version 1.0
@param cFilTab, caracter, Filial de la tabla
@param cCodigo, caracter, Código a buscar en la tabla
@param cTab, caracter, Tabla sobre la cual se realizará la busqueda
@return cDesc, caracter, Descripción del código de busqueda
/*/
Static Function CTBR820DES(cFilTab, cCodigo, cTab)
	Local aArea	:= GetArea()
	Local cDesc := "Descripción inválida"

	If cTab == "CV0"
		dbSelectArea("CV0")
		CV0->(dbSetOrder(2)) //CV0_FILIAL + CV0_CODIGO

		If CV0->(dbseek(cFilTab + cCodigo))
			cDesc := CV0->CV0_DESC
		EndIf
	ElseIf cTab == "CT1"
		dbSelectArea("CT1")
		CT1->(dbSetOrder(1)) //CT1_FILIAL + CT1_CONTA

		If CT1->(dbseek(cFilTab + cCodigo))
			cDesc := CT1->CT1_DESC01
		EndIf
	EndIf
	RestArea(aArea)
Return cDesc
