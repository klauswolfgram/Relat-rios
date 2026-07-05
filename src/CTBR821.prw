/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR821.CH"
#Include "PROTHEUS.CH"

#DEFINE TAM_VALOR  20
#DEFINE TAM_CONTA  17

Static lFWCodFil := FindFunction("FWCodFil")
Static lCtbIsCube := FindFunction("CtbIsCube")
Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

//amarracao

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR821  ³ Autor ³ Marco A. Gonzalez     ³ Data ³ 27/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Auxiliar por Terceros                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR821(ExpC1,ExpC2,ExpD1,ExpD2,ExpC3,ExpC4,ExpC5,ExpL1,   ³±±
±±³          ³         ExpC6,ExpC7,ExpL2,ExpC8,ExpC9,ExpL3,ExpC10,ExpC11, ³±±
±±³          ³         ExpL4,ExpC12,ExpA1)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Cuenta Inicial                                     ³±±
±±³          ³ ExpC2 = Cuenta Final                                       ³±±
±±³          ³ ExpD1 = Fecha Inicial                                      ³±±
±±³          ³ ExpD2 = Fecha Final                                        ³±±
±±³          ³ ExpC3 = Moneda                                             ³±±
±±³          ³ ExpC4 = Saldo                                              ³±±
±±³          ³ ExpC5 = Set of Book                                        ³±±
±±³          ³ ExpL1 = Si C. Costo                                        ³±±
±±³          ³ ExpC6 = Costo Inicial                                      ³±±
±±³          ³ ExpC7 = Costo Final                                        ³±±
±±³          ³ ExpL2 = Si Item                                            ³±±
±±³          ³ ExpC8 = Item Inicial                                       ³±±
±±³          ³ ExpC9 = Item Final                                         ³±±
±±³          ³ ExpL3 = Si NIT                                             ³±±
±±³          ³ ExpC10 = NIT Inicial                                       ³±±
±±³          ³ ExpC11 = NIT Final                                         ³±±
±±³          ³ ExpL4 = Si salto de Linea                                  ³±±
±±³          ³ ExpC12 = Descripcion de Moneda                             ³±±
±±³          ³ ExpA1 = Matriz Filial                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³Data    ³ BOPS     ³ Motivo da Alteracao                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Alf. Medrano³02/12/16³SERINN001-113³excluye creacion de tabla temporal ³±±
±±³            ³        ³          ³-y se asigna FWTemporaryTable se asig ³±±
±±³            ³        ³          ³nan indices a un array en funcion     ³±±
±±³            ³        ³          ³CTBR821NIT. Se inicializa y se limpia ³±±
±±³            ³        ³          ³objeto de tabla en Func CTBR821       ³±±
±±³Alf. Medrano³13/12/16³SERINN001-113³merge 12.1.15 vs Main              ³±±
±±³Diego Rivera³06/08/19³DMINA-7129³Se pasa parámetro dDataIni en llamada ³±±
±±³            ³        ³          ³a la función CtCGCCabTR. Se mueven va-³±±
±±³            ³        ³          ³lidaciones referentes a las preguntas ³±±
±±³            ³        ³          ³iniciales (parámetros) fuera de un ci-³±±
±±³            ³        ³          ³clo para mejorar el tiempo de genera- ³±±
±±³            ³        ³          ³ción del informe en la función        ³±±
±±³            ³        ³          ³CTBR821REP. Se incrementa espacio para³±±
±±³            ³        ³          ³las columnas Débito y Crédito, incre- ³±±
±±³            ³        ³          ³mentando TAM_VALOR para que los valo- ³±±
±±³            ³        ³          ³res no se empalmen, también se aumenta³±±
±±³            ³        ³          ³espacio para columna Historico incre- ³±±
±±³            ³        ³          ³mentando nTamHist para reducir canti- ³±±
±±³            ³        ³          ³dad de hojas, en la función CTBR821DEF³±±
±±³            ³        ³          ³Se realizan correcciones por buenas   ³±±
±±³            ³        ³          ³practicas. Se pasa la información     ³±±
±±³            ³        ³          ³correspondiente de Lote, Sublote,     ³±±
±±³            ³        ³          ³Documento y Linea para ser impresa en ³±±
±±³            ³        ³          ³la columna Lote/Sublote/Doc/Linea     ³±±
±±³            ³        ³          ³(Correlativo). Col.                   ³±±
±±³Eduardo Prz.³16/01/20³DMINA-7939|Modificacion de mascara para impresion|±±
±±³            |        |          |de campo N.I.T en funcion CTBR821Rep  |±±
±±³Alf. Medrano³02/06/20³DMINA-9139³En fun ReportDef,CTBR821Rep,CTBR821Imp³±±
±±³            ³        ³          ³CTBR821GrR,CTBR821Qry y CTBR821NIT se ³±±
±±³            ³        ³          ³asigna valor de campos CT2_CLVLDB o  ³±±
±±³            ³        ³          ³CT2_CLVLCR para mostrar Clase Valor  ³±±
±±³            ³        ³          ³en el informe. COL                    ³±±
±±³Alf. Medrano³04/06/20³DMINA-9139³En fun ReportDef se asigna etiqueta CH³±±
±±³            ³        ³          ³COL                                   ³±±
±±³Eduardo Prz ³24/11/20³DMINA-10655³Para columna SALDO ACTUAL(CTPSLDATU) ³±±
±±³            ³        ³          ³se modifica el tamaño enviado en fun  ³±±
±±³            ³        ³          ³ ValorCTB() usado para la propiedad   ³±±
±±³            ³        ³          ³ cPicture                             ³±±
±±³LuisEnríquez³12/01/21³DMINA-10491³Ajustes varios para evitar practicas ³±±
±±³            ³        ³          ³que afectan performance y buenas prac-³±±
±±³            ³        ³          ³ticas (COL)                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR821(	cContaIni, cContaFim, dDataIni, dDataFim, cMoeda, cSaldos,;
		cBook, lCusto, cCustoIni, cCustoFim, lItem, cItemIni, cItemFim,;
		lNit, cNitIni, cNitFim, lSaltLin, cMoedaDesc, aSelFil )

	Local aArea			:= GetArea()
	Local aCtbMoeda		:= {}

	Local cArqTmp			:= ""
	Local lOk				:= .T.
	Local lExterno		:= cContaIni <> Nil

	Private cTipoAnt		:= ""
	Private cNomeProg		:= STR0001 //"CTBR821"
	Private cPerg			:= "CTBR821"
	Private nSldTransp	:= 0 // Es utilizada para calcular el valor del transporte
	Private oReport
	Private nLin			:= 0

	DbSelectArea("CT0")
	CT0->(DbSetOrder(1)) //CT0_FILIAL+CT0_ID
	CT0->(DbSeek(xFilial("CT0")+ "05" ))

	Private cPlano		:= CT0->CT0_ENTIDA
	Private cCodigo		:= ""
	Private oTmpTable

	Default lCusto		:= .F.
	Default lItem			:= .F.
	Default lNit			:= .F.
	Default lSaltLin		:= .T.
	Default cMoedaDesc	:= cMoeda
	Default aSelFil		:= {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³mv_par01 - De Cuenta?                 ³
	//³mv_par02 - A Cuenta?                  ³
	//³mv_par03 - De Fecha?                  ³
	//³mv_par04 - A Fecha?                   ³
	//³mv_par05 - Moneda?                    ³
	//³mv_par06 - Tipo de Saldo?             ³
	//³mv_par07 - Cod. Config. Libros?       ³
	//³mv_par08 - Tipo Informe?              ³
	//³mv_par09 - Impr. Cta. S/Movimiento?   ³
	//³mv_par10 - Union C.C. Contable?       ³
	//³mv_par11 - Imp. Cod. Cuenta?          ³
	//³mv_par12 - Imprime C.C. Extra?        ³
	//³mv_par13 - De Centro de Costo?        ³
	//³mv_par14 - A Centro de Costo?         ³
	//³mv_par15 - Imprime Item Contable?     ³
	//³mv_par16 - De Item Contable?          ³
	//³mv_par17 - A Item Contable?           ³
	//³mv_par18 - Imprime N.I.T. Valor?      ³
	//³mv_par19 - De N.I.T. Valor?           ³
	//³mv_par20 - A N.I.T. Valor?            ³
	//³mv_par21 - Salta Pagina por Cta.?     ³
	//³mv_par22 - Pagina Inicial?            ³
	//³mv_par23 - Pagina Final?              ³
	//³mv_par24 - Pagina al Reiniciar?       ³
	//³mv_par25 - Imprime Cod. C. Costo?     ³
	//³mv_par26 - Imprime Cod. Item?         ³
	//³mv_par27 - Imprime Codigo NIT Valor?  ³
	//³mv_par28 - Imprime Total General?     ³
	//³mv_par29 - Imprime?                   ³
	//³mv_par30 - Imprime Valor 0,00?        ³
	//³mv_par31 - Salta Linea entre Cuenta?  ³
	//³mv_par32 - Num. Linea P/Razon?        ³
	//³mv_par33 - Sld. Ant. Nivel?           ³
	//³mv_par34 - Descripcion de la Moneda?  ³
	//³mv_par35 - Cons. Tamano Total de Ente?³
	//³mv_par36 - Selecciona Sucursales?     ³
	//³mv_par37 - Genera archivo TXT?        ³
	//³mv_par38 - Ruta para archivo TXT?     ³
	//³mv_par39 - Ordene por?                ³
	//³mv_par40 - imprime Clase Valor?       ³
	//³mv_par41 - De Clase Valor?            ³
	//³mv_par42 - A Clase Valor?             ³
	//³mv_par43 - Posición Ant. Ganan./Pérd.?³
	//³mv_par44 - Fecha Ganancias/Pérdidas?  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	lOk := AMIIn(34)	// Acceso solo para SIGACTB

	If lOk
		Pergunte(cPerg, .F.)
		If !lExterno
			lOk := Pergunte(cPerg, .T.)
		Endif
	Endif

	If lOk
		//Verifica si el informe fue llamado a partir de otro programa.
		If !lExterno
			lCusto	:= Iif(mv_par12 == 1,.T.,.F.)
			lItem	:= Iif(mv_par15 == 1,.T.,.F.)
			lNit	:= Iif(mv_par18 == 1,.T.,.F.)
			// Si la Filial no fue seleccionada, muestra la ventana para seleccionar las filiales
			If lOk .And. mv_par36 == 1 .And. Len( aSelFil ) <= 0
				aSelFil := AdmGetFil()

				If Len( aSelFil ) <= 0
					lOk := .F.
				EndIf
			EndIf
		Else  // En caso de que no sea externo, se actualizan los parametros por los pasados por referencia
			mv_par01 := cContaIni
			mv_par02 := cContaFim
			mv_par03 := dDataIni
			mv_par04 := dDataFim
			mv_par05 := cMoeda
			mv_par06 := cSaldos
			mv_par07 := cBook
			mv_par12 := If(lCusto =.T.,1,2)
			mv_par13 := cCustoIni
			mv_par14 := cCustoFim
			mv_par15 := If(lItem =.T.,1,2)
			mv_par16 := cItemIni
			mv_par17 := cItemFim
			mv_par18 := If(lNit =.T.,1,2)
			mv_par19 := cNitIni
			mv_par20 := cNitFim
			mv_par31 := If(lSaltLin==.T.,1,2)
			mv_par32 := 56
			mv_par34 := cMoedaDesc
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica si usa Set Of Books + Plann Gerencial³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! ct040Valid(mv_par07) // Set Of Books
		lOk := .F.
	EndIf

	If lOk .And. mv_par32 < 10
		ShowHelpDlg("MINQTDELIN", {STR0002,STR0003},5,{STR0004,STR0005},5) //"Valor informado inválido " - "'Número de Lineas p/ Motivo' " - "Por favor, Introduzca una cantidad " - " mínimo 10 líneas"
		lOk := .F.
	EndIf

	If lOk
		aCtbMoeda	:= CtbMoeda(MV_PAR05) // Moneda?
		If Empty( aCtbMoeda[1] )
			Help(" ",1,"NOMOEDA")
			lOk := .F.
		Endif

		IF lOk .And. ! Empty( mv_par34 )
			aCtbMoeddesc := CtbMoeda(mv_par34) // Moneda?

			If Empty( aCtbMoeddesc[1] )
				Help(" ",1,"NOMOEDA")
				lOk := .F.
			Endif
			aCtbMoeddesc := nil
		Endif
	Endif

	If lOk
		U_CTBR821R4(aCtbMoeda,lCusto,lItem,lNit,@cArqTmp,aSelFil )
	Endif

	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil
	Endif

	RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CTBR821R4 º Autor ³ Marco A. Gonzalez  º Data ³  27/04/16  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Impresion del informe en R4                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSintaxe   ³ U_CTBR821R4(ExpA1,ExpL1,ExpL2,ExpL3,ExpC1,ExpA2)             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ ExpA1 = Matriz Moneda                                      º±±
±±º          ³ ExpL1 = Si Costo                                           º±±
±±º          ³ ExpL2 = Si Item                                            º±±
±±º          ³ ExpL3 = Si NIT                                             º±±
±±º          ³ ExpC1 = Archivo Temporal                                   º±±
±±º          ³ ExpA2 = Matriz Filial                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR821R4(aCtbMoeda,lCusto,lItem,lNit,cArqTmp,aSelFil )

	oReport := ReportDef(aCtbMoeda,lCusto,lItem,lNit,@cArqTmp,aSelFil)
	oReport:PrintDialog()

	oReport := Nil

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Marco A. Gonzalez  º Data ³  27/04/16  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicion del objeto informe y secciones personalizables  º±±
±±º          ³ que seran utilizadas.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSintaxe   ³ ReportDef(ExpA1,ExpL1,ExpL2,ExpL3,ExpC1,ExpA2)             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ ExpA1 = Matriz Moneda                                      º±±
±±º          ³ ExpL1 = Si Costo                                           º±±
±±º          ³ ExpL2 = Si Item                                            º±±
±±º          ³ ExpL3 = Si NIT                                             º±±
±±º          ³ ExpC1 = Archivo Temporal                                   º±±
±±º          ³ ExpA2 = Matriz Filial                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(aCtbMoeda,lCusto,lItem,lNit,cArqTmp,aSelFil)

	Local oReport
	Local oSection1
	Local oSection1_1
	Local oSection2
	Local oSection3
	Local cDesc1		:= STR0006 //"Este programa ira  imprimir el libro Mayor,"
	Local cDesc2		:= STR0007 //" de acuerdo con los parámetros solicitados por"
	Local cDesc3		:= STR0008 //" el usuario."
	Local cTitulo		:= STR0009 //"Emision del Libro Mayor"
	Local cPerg		:= "CTBR821"
	Local aTamConta	:= TAMSX3("CT1_CONTA")
	Local aTamCusto	:= TAMSX3("CT3_CUSTO")
	Local nTamConta	:= Len(CriaVar("CT1_CONTA"))
	Local nTamHist	:= If(cPaisLoc$"CHI|ARG",29,Len(CriaVar("CT2_HIST")))
	Local nTamItem	:= Len(CriaVar("CTD_ITEM"))
	Local nTamClVl	:= Len(CriaVar("CT2_CLVLDB"))
	Local nTamNit		:= Len(CriaVar("CV0_CODIGO"))
	Local nTamSegOfi	:= Len(CriaVar("CT2_SEGOFI"))
	Local nTamData	:= 10

	Local lAnalitico	:= Iif(mv_par08==1,.T.,.F.)	// Dia analitico o resumido
	Local lPrintZero	:= IIf(mv_par30==1,.T.,.F.)	// Imprime valor 0.00    ?
	Local lSalto		:= Iif(mv_par21==1,.T.,.F.)	// Salto de pagina

	Local cSayCusto	:= CtbSayApro("CTT")
	Local cSayItem	:= CtbSayApro("CTD")
	Local cSayClVl	:= STR0047 //"Cl.VaLor"
	Local cSayNit		:= STR0048 //"N.I.T."
	Local aSetOfBook	:= CTBSetOf(mv_par07)	// Set Of Books
	Local cPicture	:= aSetOfBook[4]
	Local cDescMoeda	:= IIf(!IsBlind(),aCtbMoeda[2],CtbMoeda(MV_PAR05)[2])
	Local nDecimais	:= DecimalCTB(aSetOfBook,mv_par05)	// Moneda
	Local nTamTransp	:= 0
	Local cSaySldIni := STR0049 //"Sld. Ini "
	Local cSayCuenta := STR0050 //Cuenta

	If MV_PAR35 == 1 // Coloca las entidades de tamano maximo 20 para impresion correcta de mascaras
		aTamCusto[1]	:= 20
		nTamItem		:= 20
		nTamNit		:= 20
	EndIf

	If mv_par11 == 3	// Si el punto de referencia del codigo es de impresion
		nTamConta := Len(CT1->CT1_CODIMP)	// Usa el tamano de campo de codigo de impresion
	Else
		If lAnalitico
			If (lCusto .Or. lItem .Or. lNit)
				nTamConta := 30	// Tamano disponible en el informe para impresion
			Else
				nTamConta := 40 	// Tamano disponible en el informe para impresion
			Endif
		EndIf
	Endif

	If cPaisLoc = "PER"
		cSayNit := "R.U.C."
	Endif

	oReport := TReport():New(cNomeProg,cTitulo,cPerg, {|oReport| CTBR821Rep(oReport,aCtbMoeda,aSetOfBook,cPicture,cDescMoeda,nDecimais,nTamConta,lAnalitico,lCusto,lItem,lNit,cArqTmp,aSelFil)},cDesc1+cDesc2+cDesc3)

	oReport:SetTotalInLine(.F.)
	oReport:EndPage(.T.)

	If lAnalitico
		oReport:SetLandScape(.T.)
	Else
		oReport:SetPortrait(.T.)
	EndIf
	oReport:lFooterVisible 	:= .F.	// No imprime el pie de pagina de Protheus
	// oSection1
	oSection1 := TRSection():New(oReport,STR0010,{"cArqTmp"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	//"Cuenta"

	If lSalto
		oSection1:SetPageBreak(.T.)
	EndIf

	If mv_par39 = 2
		TRCell():New(oSection1,"NIT"	,"cArqTmp",Upper(cSayNit)   ,/*Picture*/,nTamNit     ,/*lPixel*/,,/*"LEFT"*/,,/*"LEFT"*/)// Classe de Valor
		oSection1:SetReadOnly()
	Else
		TRCell():New(oSection1,"CONTA"	,"cArqTmp",STR0011,/*Picture*/,aTamConta[1],/*lPixel*/,/*{|| }*/)	//"CUENTA"
		TRCell():New(oSection1,"DESCCC"	,"cArqTmp",STR0012,/*Picture*/,nTamConta+20,/*lPixel*/,/*{|| }*/)	//"DESCRIPCION"
		oSection1:SetReadOnly()
	EndIf

	// oSection2
	oSection2 := TRSection():New(oReport,STR0013,{"cArqTmp","CT2"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	//"Costo"
	oSection2:SetHeaderPage(.T.)
	oSection2:SetReadOnly()

	TRCell():New(oSection2, "DATAL"			, "cArqTmp"	, STR0014,/*Picture*/,nTamData+3,/*lPixel*/,/*{|| }*/,/*"LEFT"*/,,/*"LEFT"*/,,,.F.)	// "FECHA"
	TRCell():New(oSection2, "CORRELATIVO"	, ""			, STR0015,/*Picture*/,If(nTamSegOfi < 20, 20+10,nTamSegOfi+8),/*lPixel*/,{|| cArqTmp->SEGOFI },/*"LEFT"*/,,/*"LEFT"*/,,,.F.)	// "LOTE/SUB/DOC/LINEA"

	TRCell():New(oSection2, "HISTORICO"	, ""			, STR0016,/*Picture*/,55,/*lPixel*/,{|| cArqTmp->HISTORICO},/*"LEFT"*/,.T.,/*"LEFT"*/,,,.F.)	// "HISTORICO"
	TRCell():New(oSection2, "XPARTIDA"		, "cArqTmp"	, STR0017,/*Picture*/,20,/*lPixel*/,/*{|| }*/,/*"LEFT"*/,,/*"LEFT"*/,,,.F.)	// "XPARTIDA"

	TRCell():New(oSection2, "CCUSTO"		, "cArqTmp"	, Upper(cSayCusto),/*Picture*/,aTamCusto[1],/*lPixel*/,{|| IIF(lCusto == .T.,cArqTmp->CCUSTO,Nil) },/*"LEFT"*/,,/*"LEFT"*/,,,.F.)// Centro de Custo
	TRCell():New(oSection2, "ITEM"			, "cArqTmp"	, Upper(cSayItem) ,/*Picture*/,nTamItem,/*lPixel*/,{|| IIF(lItem == .T.,cArqTmp->ITEM,Nil) },/*"LEFT"*/,,/*"LEFT"*/,,,.F.)// Item Contabil
	TRCell():New(oSection2, "CLVAL"		, "cArqTmp"	, Upper(cSayClVl),/*Picture*/,nTamClVl,/*lPixel*/,{|| cArqTmp->CLVAL},/*"LEFT"*/,,/*"LEFT"*/,,,.F.)// Clase Valor
	If lAnalitico
		TRCell():New(oSection2, "SLDNIT"		, ""	, Upper(cSaySldIni) ,/*Picture*/,TAM_VALOR+5,/*lPixel*/,{|| ValorCTB(nSldTotNit,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },/*"RIGHT"*/,,"CENTER",,,.F.)
	EndIf
	If mv_par39 = 1
		TRCell():New(oSection2, "NIT"			, "cArqTmp"	, Upper(cSayNit) ,/*Picture*/,nTamNit,/*lPixel*/,{|| IIF(lNit == .T.,cArqTmp->NIT,Nil) },/*"LEFT"*/,,/*"LEFT"*/,,,.F.)// Classe de Valor
	Else
		TRCell():New(oSection2, "NIT"			, "cArqTmp"	, Upper(cSayCuenta) ,/*Picture*/,nTamNit,/*lPixel*/,{|| IIF(lNit == .T.,cArqTmp->NIT,Nil) },/*"LEFT"*/,,/*"LEFT"*/,,,.F.)// Classe de Valor
	EndIF
	TRCell():New(oSection2, "CLANCDEB"		, "cArqTmp"	, STR0018,/*Picture*/,TAM_VALOR+8,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCDEB,,,TAM_VALOR+8,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },/*"RIGHT"*/,,"CENTER",,,.F.)	// "DEBITO"
	TRCell():New(oSection2, "CLANCCRD"		, "cArqTmp"	, STR0019,/*Picture*/,TAM_VALOR+10 ,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCCRD,,,TAM_VALOR+8,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },/*"RIGHT"*/,,"CENTER",,,.F.)	// "CREDITO"
	TRCell():New(oSection2, "CTPSLDATU"	, "cArqTmp"	, STR0020,/*Picture*/,TAM_VALOR+2,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,,"CENTER",,,.F.)	// "SALDO ATUAL"

	If cPaisLoc $ "CHI|ARG|PER"
		TRCell():New(oSection2,"SEGOFI"	,"cArqTmp","SEGOFI",/*Picture*/,TamSx3("CT2_SEGOFI")[1],/*lPixel*/,{|| cArqTmp->SEGOFI })
	EndIf

	//*************************************************************
	// Tratamento do campo SEGOFI para Chile e Argentina          *
	// Caso o relatorio seja resumido imprime na coluna historico *
	// Caso seja analitico imprime em uma nova coluna.            *
	//*************************************************************

	If cPaisLoc $ "CHI|ARG|PER" .and. lAnalitico //Se for relatorio analitico

		oSection2:Cell("HISTORICO"):SetSize(29)
		oSection2:Cell("HISTORICO"):SetBlock( { || Subs(cArqTmp->HISTORICO,1,29)})

	ElseIf cPaisLoc $ "CHI|ARG|PER" .and. !lAnalitico //Se for relatorio Resumido

		oSection2:Cell("SEGOFI"):Hide()
		oSection2:Cell("SEGOFI"):HideHeader()

		oSection2:Cell("CORRELATIVO"):SetTitle(" " + " - " + "SEGOFI")
		oSection2:Cell("CORRELATIVO"):SetSize(oSection2:Cell("CORRELATIVO"):GetSize() + Len(CriaVar("CT2_SEGOFI")) )
		oSection2:Cell("CORRELATIVO"):SetBlock( { || cArqTmp->SEGOFI+" - "+cArqTmp->SEGOFI } )
		oSection2:Cell("HISTORICO"):SetBlock( { || Subs(cArqTmp->HISTORICO,1,40)})
	EndIf

	//****************************************
	// Oculta campos para relatorio resumido *
	//****************************************
	If !lAnalitico // Resumido

		oSection2:Cell("CORRELATIVO"):Hide()
		oSection2:Cell("CORRELATIVO"):SetTitle('')

		oSection2:Cell("HISTORICO"):Hide()
		oSection2:Cell("HISTORICO"):SetTitle('')

		oSection2:Cell("XPARTIDA"):Disable()

	EndIf

	// Inibir a coluna FILIAL do relatorio quando utiliza multi-filiais
	If !lAnalitico
		nTamTransp := oSection2:Cell("DATAL"):GetSize() + oSection2:Cell("CORRELATIVO"):GetSize() + oSection2:Cell("HISTORICO"):GetSize();
			+ oSection2:Cell("CLANCDEB"):GetSize() + oSection2:Cell("CLANCCRD"):GetSize()+3
	Else
		nTamTransp := oSection2:Cell("DATAL"):GetSize() + oSection2:Cell("CORRELATIVO"):GetSize() + oSection2:Cell("HISTORICO"):GetSize();
			+ oSection2:Cell("XPARTIDA"):GetSize() + oSection2:Cell("CCUSTO"):GetSize();
			+ oSection2:Cell("ITEM"):GetSize() + oSection2:Cell("SLDNIT"):GetSize() + oSection2:Cell("NIT"):GetSize() + oSection2:Cell("CLANCDEB"):GetSize();
			+ oSection2:Cell("CLANCCRD"):GetSize() + 4
	Endif

	oSection2:Cell("DATAL"):lHeaderSize		:= .F.
	oSection2:Cell("CORRELATIVO"):lHeaderSize	:= .F.
	oSection2:Cell("CLANCDEB"):lHeaderSize		:= .F.
	oSection2:Cell("CLANCCRD"):lHeaderSize		:= .F.
	oSection2:Cell("CTPSLDATU"):lHeaderSize	:= .F.

	//********************************
	// Imprime linha saldo anterior  *
	//********************************

	//oSection1_1 - Totalizadores Conta
	oSection1_1 := TRSection():New(oReport,STR0021,/*{"cArqTmp","CT2"}*/,/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/) //"Total  "
	// Tamanho da coluna descrição da seção Section1_1
	nTamDesc := nTamData + nTamSegOfi + nTamHist

	TRCell():New(oSection1_1,"DESCRICAO","cArqTmp","",/*Picture*/,nTamDesc,/*lPixel*/,{|| })


	TRCell():New(oSection1_1,"SALDOANT"	,"cArqTmp","",/*Picture*/,TAM_VALOR + 20,/*lPixel*/,{|| },"RIGHT",,"RIGHT")

	oSection1_1:SetHeaderSection(.F.)
	oSection1_1:SetReadOnly()

	//oSection3 - Totalizadores Transporte
	oSection3 := TRSection():New(oReport,STR0021,/*Alias*/,/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/,,,,,,.F.,,,)	//" Total Transporte"

	TRCell():New(oSection3,"CTRANSP"	,/*Alias*/,/*titulo*/,/*Picture*/,nTamTransp,/*lPixel*/,/*{||}*/,,,,,,.F.)
	TRCell():New(oSection3,"CSLDATU"	,/*Alias*/,/*titulo*/,/*Picture*/,TAM_VALOR+2,/*lPixel*/,/*{||}*/,,,/*"RIGHT"*/,,,.F.)
	oSection3:SetHeaderSection(.F.)
	oSection3:SetReadOnly()

	oSection3:Cell("CTRANSP"):lHeaderSize := .F.
	oSection3:Cell("CSLDATU"):lHeaderSize := .F.

Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR821Rep º Autor ³ Marco A. Gonzalez  º Data ³  14/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime el informe definido por el usuario de acuerdo con  º±±
±±º          ³ las secciones/celdas creadas en la funcion ReportDef()     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSintaxe   ³ CTBR821Rep(ExpO1,ExpA1,ExpA2,ExpC1,ExpC2,ExpN1,ExpN2,ExpL1,º±±
±±º          ³            ExpL2,ExpL3,ExpC3,ExpA3)                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ ExpO1 = Objeto Reporte                                     º±±
±±º          ³ ExpA1 = Matriz Moneda                                      º±±
±±º          ³ ExpA2 = Matriz Set Of Book                                 º±±
±±º          ³ ExpC1 = Picture                                            º±±
±±º          ³ ExpC2 = Descripcion Moneda                                 º±±
±±º          ³ ExpN1 = Decimales                                          º±±
±±º          ³ ExpN2 = Tamano Cuenta                                      º±±
±±º          ³ ExpL1 = Si Analitico                                       º±±
±±º          ³ ExpL2 = Si Costo                                           º±±
±±º          ³ ExpL3 = Si Item                                            º±±
±±º          ³ ExpL4 = Si NIT                                             º±±
±±º          ³ ExpC3 = Archivo Temporal                                   º±±
±±º          ³ ExpA3 = Matriz Filial                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³  CTBR821                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CTBR821Rep(oReport,aCtbMoeda,aSetOfBook,cPicture,cDescMoeda,nDecimais,nTamConta,lAnalitico,lCusto,lItem,lNIt,cArqTmp,aSelFil)

	Local oSection1	:= oReport:Section(1)
	Local oSection2	:= oReport:Section(2)
	Local oSection1_1	:= oReport:Section(3)
	Local oSection3	:= oReport:Section(4)

	Local cFiltro		:= oSection2:GetAdvplExp()

	Local aSaldo		:= {}
	Local aSaldoAnt	:= {}

	Local cContaIni	:= mv_par01 // De cuenta
	Local cContaFim	:= mv_par02 // A cuenta
	Local cMoeda		:= mv_par05 // Moneda
	Local cSaldo		:= mv_par06 // Saldos
	Local cCustoIni	:= mv_par13 // De Centro de Costo
	Local cCustoFim	:= mv_par14 // A Centro de Costo
	Local cItemIni	:= mv_par16 // De Item
	Local cItemFim	:= mv_par17 // A Item
	Local cNitIni		:= mv_par19 // Imprime Clase de Valor?
	Local cNitFim		:= mv_par20 // A Clase de Valor
	Local cContaAnt	:= ""
	Local cDescConta	:= ""
	Local cCodRes		:= ""
	Local cDescSint	:= ""
	Local cContaSint	:= ""
	Local cNormal		:= ""

	Local xConta		:= ""

	Local cSepara1	:= ""
	Local cSepara2	:= ""
	Local cSepara3	:= ""
	Local cSepara4	:= ""
	Local cSpra4ClV	:= ""
	Local cMascara1	:= ""
	Local cMascara2	:= ""
	Local cMascara3	:= ""
	Local cMascara4	:= ""
	Local cMsc4ClV	:= ""

	Local dDataAnt	:= CTOD("  /  /  ")
	Local dDataIni	:= mv_par03 // De fecha
	Local dDataFim	:= mv_par04 // A fecha

	Local nTotDeb		:= 0
	Local nTotCrd		:= 0
	Local nTotGerDeb	:= 0
	Local nTotGerCrd	:= 0
	Local nVlrDeb		:= 0
	Local nVlrCrd		:= 0
	Local nCont		:= 0

	Local lNoMov		:= Iif(mv_par09==1,.T.,.F.) // Imprime cuenta sin movimento?
	Local lSldAnt		:= Iif(mv_par09==3,.T.,.F.) // Imprime cuenta sin movimento?
	Local lJunta		:= Iif(mv_par10==1,.T.,.F.) // Cuentas con mismo C. Costo?
	Local lPrintZero	:= Iif(mv_par30==1,.T.,.F.) // Imprime valor 0.00    ?
	Local lImpLivro	:= .t.
	Local lImpTermos	:= .f.
	Local lSldAntCC	:= Iif(mv_par33 == 2, .T.,.F.)	// Saldo Ant. nivel?Cta/C.C/Item/Cl.Vlr
	Local lSldAntIt	:= Iif(mv_par33 == 3, .T.,.F.)	// Saldo Ant. nivel?Cta/C.C/Item/Cl.Vlr

	Local cMoedaDesc	:= Iif( Empty( mv_par34 ) , cMoeda , mv_par34 ) // RFC - 18/01/07 | BOPS 103653
	Local nMaxLin		:= mv_par32 // Num. lineas p/ Razon?
	Local nLinReport	:= 8
	Local lResetPag	:= .T.
	Local m_pag		:= 1	// Control de numeracion de paginas
	Local l1StQb		:= .T.
	Local nPagIni		:= mv_par22
	Local nPagFim		:= mv_par23
	Local nReinicia	:= mv_par24
	Local nBloco		:= 0
	Local nBlCount	:= 1
	Local nX
	Local cTituloRep	:= ""

	Local aEntidIni		:= {}
	Local aEntidFim		:= {}
	Local oObjCubo
	Local aClValTam := TAMSX3("CTH_CLVL")

	Local nposNit := 0
	Local aSlIniNIT := {}
	Local nSldTotNit := 0
	Local nSaldoAtu := 0
	Local cChaveNitTmp := ""
	Local nContaTam := TAM_CONTA
	Local aTmpSal	:= {}
	Local nPos := 0
	Local cFilCT2 := xFilial("CT2")
	Local cFilCT0 := xFilial('CT0')
	Local nImpCodC := MV_PAR11 //Imprime código de Cuenta (1-Normal, 2-Reducido, 3-Impresión)
	Local nOrden   := MV_PAR39 //Ordenado por (1-Cuenta, 2-N.I.T.)
	Local nTamDesCta := 0
	Local oObjX1:= FWSX1Util():New()
	Local nA:=0

	Private nQtdEntid	:= CtbQtdEntd() //sao 4 entidades padroes -> conta /centro custo /item contabil/ classe de valor
	Private aEntidades 	:= {}	//Array( nQtdEntid * 2)
	Private aEstrCT0	:= {}
	Private aParCubo	:= {}
	Private cArqObjeto	:= ""
	Private cClValIni	:= mv_par41 // de Clase Valor
	Private cClValFim	:= mv_par42 // a Clase Valor
	Private lPosAntLP	:= (cPaisLoc == "COL" .And. !Empty(MV_PAR43) .And. MV_PAR43==1)
	Private dDataLP		:= IIF(lPosAntLP .And. !Empty(MV_PAR44), MV_PAR44, dDataIni-1)

	If !lCtbIsCube .And. !CtbIsCube()
		Return()
	EndIf

	DbSelectArea('CT0')
	CT0->(DbSetOrder(1)) //CT0_FILIAL + CT0_ID
	If CT0->(MsSeek( cFilCT0 ))
		While CT0->(!Eof()) .AND. cFilCT0 == CT0->CT0_FILIAL
			If !Empty(CT0->CT0_CPOCHV)
				AADD( aEstrCT0,{ CT0->CT0_ID,TamSx3(CT0->CT0_CPOCHV)[1],CT0->CT0_DSCRES,CT0->CT0_F3ENTI } )
				AADD( aEntidades , Space(TamSx3(CT0->CT0_CPOCHV)[1]) )		// Parametro entidade inicio
				AADD( aEntidades , Space(TamSx3(CT0->CT0_CPOCHV)[1]) )		// Parametro entidade fim
			EndIf
			CT0->(DbSkip())
		EndDo
	EndIf

	CtbParCubo(.T.)

	AADD( aParCubo,{cContaIni,cContaFim})
	AADD( aParCubo,{cCustoIni,cCustoFim})
	AADD( aParCubo,{cItemIni,cItemFim})
	AADD( aParCubo,{Space( aClValTam[1]),"ZZZZZZZZZ"})
	AADD( aParCubo,{cNitIni,cNitFim})

	For nX:=1 To Len(aParCubo)
		AADD( aEntidIni,If(MsAscii(aParCubo[nX][1])== 13,Space(Len(aParCubo[nX][1])),aParCubo[nX][1]))
		AADD( aEntidFim,If(MsAscii(aParCubo[nX][2])== 13,Space(Len(aParCubo[nX][2])),aParCubo[nX][2]))
	Next nX

	IF mv_par36 == 1 .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
		U_R821PROC(aEntidIni,aEntidFim,dDataIni,dDataFim,"05",MV_PAR05,MV_PAR06,aSelFil,@oObjCubo)
	else
		U_R821PROC(aEntidIni,aEntidFim,dDataIni,dDataFim,"05",MV_PAR05,MV_PAR06,{cFilAnt},@oObjCubo)
	EndIf

    While cArqTmp2->(!EOF())

	    aadd(aSlIniNIT,{AllTrim(cArqTmp2->CVX_NIV01)+ "-" + AllTrim(cArqTmp2->CVX_NIV05),cArqTmp2->CVX_SALD01})

	    cArqTmp2->(dbSkip())
    EndDo
    cArqTmp2->(dbclosearea())

	If oReport:GetOrientation() == 1 .or. !lAnalitico // Orientación vertical o tipo Resumido

		nTransp := oSection2:Cell("DATAL"):GetSize() + oSection2:Cell("CORRELATIVO"):GetSize() + oSection2:Cell("HISTORICO"):GetSize();
			+ oSection2:Cell("XPARTIDA"):GetSize()+ oSection2:Cell("CLANCDEB"):GetSize();
			+ oSection2:Cell("CLANCCRD"):GetSize()+6

		If oReport:nDevice == 1
			nTransp -= 20
		Endif

		oSection3:Cell("CTRANSP"):SetSize(nTransp)
		oSection2:Cell("CCUSTO"):Disable()
		oSection2:Cell("ITEM"):Disable()
		oSection2:Cell("CLVAL"):Disable()
		oSection2:Cell("NIT"):Disable()
		If lAnalitico
			oSection2:Cell("SLDNIT"):Disable()
		EndIf

		MsgAlert(STR0023)	// "Atención, las columnas de entidades Valor CI, C. Costo e Ítem Contable no serán impresas en modo Vertical u opción Resumido"

	Endif

	// Mascara de Cuonta
	cMascara1 := IIf (Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara1) )

	If lCusto .Or. lItem .Or. lNit
		// Mascara de Centro de Costo
		cMascara2 := IIf ( Empty(aSetOfBook[6]),GetMv("MV_MASCCUS"),RetMasCtb(aSetOfBook[6],@cSepara2) )
		// Mascara de Item Contable
		dbSelectArea("CTD")
		cMascara3 := IIf ( Empty(aSetOfBook[7]),ALLTRIM(STR(Len(CTD->CTD_ITEM))) , RetMasCtb(aSetOfBook[7],@cSepara3) )
		// Mascara de Clase de Valor
		dbSelectArea("CV0")
		cMascara4 := "1"
	EndIf

	cMsc4ClV := IIf ( Empty(aSetOfBook[8]),GetMv("MV_MASCCTH"),RetMasCtb(aSetOfBook[8],@cSpra4ClV) )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impresion de Termo / Livro³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case mv_par29==1 ; lImpLivro:=.t. ; lImpTermos:=.f.
		Case mv_par29==2 ; lImpLivro:=.t. ; lImpTermos:=.t.
		Case mv_par29==3 ; lImpLivro:=.f. ; lImpTermos:=.t.
	EndCase

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Titulo del Reporte ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If oReport:Title() == oReport:cRealTitle //If Type("NewHead")== "U"
		IF lAnalitico
			cTitulo	:= Iif(cPaisLoc=="PER", STR0024, STR0024)	//"RAZÓN ANALÍTICO EN "
			cTituloRep	:= cTitulo
		Else
			cTitulo	:=	Iif(cPaisLoc=="PER", STR0025, STR0025)	//"RAZÓN SINTÉTICO EN "
			cTituloRep	:= cTitulo+	cDescMoeda + STR0026 + DTOC(dDataIni) +;	// " DE "
			STR0027 + DTOC(dDataFim) + CtbTitSaldo(mv_par06)	// " HASTA "
		EndIf
	Else
		cTituloRep	:= oReport:Title()
		cTitulo	:= cTituloRep

	EndIf

	If FindFunction("CABRELPER") .and.  cPaisLoc=="PER"
		oReport:SetTitle(cTitulo)
		oReport:SetCustomText({|| CABRELPER( , , , , , dDataFim, oReport:Title(), , , , , oReport, .T., @lResetPag, @nPagIni, @nPagFim, @nReinicia, @m_pag, @nBloco, @nBlCount, @l1StQb, ,cTitulo)})
	Else
		oReport:SetTitle(cTituloRep)
		oReport:SetCustomText( {|| CtCGCCabTR( , , , , , dDataFim, oReport:Title(), , , , , oReport, .T., @lResetPag, @nPagIni, @nPagFim, @nReinicia, @m_pag, @nBloco, @nBlCount, @l1StQb, @dDataIni)})
	Endif

	oSection1:OnPrintLine( {|| CTBR821Max(@nMaxLin,@nLinReport)} )
	oSection1_1:OnPrintLine( {|| CTBR821Max(@nMaxLin,@nLinReport)} )
	oSection2:OnPrintLine( {|| CTBR821Max(@nMaxLin,@nLinReport)} )

	oReport:OnPageBreak( {|| CTBR821Max(@nMaxLin,@nLinReport)} )

	If lImpLivro
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta archivo temporal para impresion ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MsgMeter({|	oMeter, oText, oDlg, lEnd | U_CTBR821NIT(	oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
			cItemIni,cItemFim,cNitIni,cNitFim,cMoeda,dDataIni,dDataFim,;
			aSetOfBook,lNoMov,cSaldo,lJunta,IIF(mv_par39==1 .OR. cPaisLoc != "COL","1","4"),lAnalitico,,,cFiltro,lSldAnt,aSelFil) },;
			STR0028,; //STR	// "Creando Archivo Temporal..."
			STR0029)	//STR	// "Emisión del Motivo"

		dbSelectArea("cArqTmp")
		dbGoTop()

		oReport:SetMeter( RecCount() )
		oReport:NoUserFilter()

	Endif

	If nOrden = 2
		oBrkConta 	:= TRBreak():New( oSection2, { || cArqTmp->NIT }, OemToAnsi(STR0030), ) //"Total NIT"

		oTotDeb 	:= TRFunction():New( oSection2:Cell("CLANCDEB")	, ,"ONPRINT", oBrkConta,/*Titulo*/,cPicture,;
			{ || ValorCTB(nTotDeb  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
		oTotCred	:= TRFunction():New( oSection2:Cell("CLANCCRD")	, ,"ONPRINT", oBrkConta,/*Titulo*/,cPicture,;
			{ || ValorCTB(nTotCrd  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
		oTotTpSld 	:= TRFunction():New( oSection2:Cell("CTPSLDATU")	, ,"ONPRINT", oBrkConta,/*Titulo*/,cPicture,;
			{ || ValorCTB(nSaldoAtu,,,TAM_VALOR+2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
	Else
		oBrkConta 	:= TRBreak():New( oSection2, { || cArqTmp->CONTA }, OemToAnsi(STR0031), ) //"Total Cuenta"

		oTotDeb 	:= TRFunction():New( oSection2:Cell("CLANCDEB")	, ,"ONPRINT", oBrkConta,/*Titulo*/,cPicture,;
			{ || ValorCTB(nTotDeb  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
		oTotCred	:= TRFunction():New( oSection2:Cell("CLANCCRD")	, ,"ONPRINT", oBrkConta,/*Titulo*/,cPicture,;
			{ || ValorCTB(nTotCrd  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
		oTotTpSld 	:= TRFunction():New( oSection2:Cell("CTPSLDATU")	, ,"ONPRINT", oBrkConta,/*Titulo*/,cPicture,;
			{ || ValorCTB(nSaldoAtu,,,TAM_VALOR+2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
	EndIf

	If lImpLivro .And. mv_par28 == 1	//Imprime total Geral

		oBrkEnd 	:= TRBreak():New( oReport, { || /*cArqTmp->(Eof())*/	}, OemToAnsi(STR0032), )	//"T O T A L  G E R A L  ==> "
		oTotGerDeb 	:= TRFunction():New( oSection2:Cell("CLANCDEB")	, ,"ONPRINT", oBrkEnd,/*Titulo*/,cPicture,;
			{ || ValorCTB(nTotGerDeb  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
		oTotGerCred	:= TRFunction():New( oSection2:Cell("CLANCCRD")	, ,"ONPRINT", oBrkEnd,/*Titulo*/,cPicture,;
			{ || ValorCTB(nTotGerCrd  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)

	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impresion de saldo anterior de Centro de Costo³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1_1:Cell("DESCRICAO"):SetBlock( {|| xConta } )

	If nOrden = 2
		oSection1_1:Cell("SALDOANT"):SetBlock( {|| STR0033 + ValorCTB(nSaldoAtu,,,TAM_VALOR+2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )	//"SALDO ANTERIOR: "
	Else
		oSection1_1:Cell("SALDOANT"):SetBlock( {|| STR0033 + ValorCTB(aSaldoAnt[6],,,TAM_VALOR+2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )	//"SALDO ANTERIOR: "
	EndIF

	oSection1_1:Cell("DESCRICAO"):HideHeader()
	oSection1_1:Cell("SALDOANT"):HideHeader()

	//Si ha parametrizado con Plan Gerencial, muestra un mensaje de error y sale de la rutina
	If lImpLivro
		If cArqTmp->(EoF())
			// Atencao ### "Nao existem dados para os parâmetros especificados."
			Aviso(STR0034,STR0035,{STR0036}) //STR
			oReport:CancelPrint()
			Return
		Else
			aTmpSal := {}
			While lImpLivro .And. cArqTmp->(!Eof()) .And. !oReport:Cancel()
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³INICIO de 1a SECCION ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If oReport:Cancel()
					Exit
				EndIf

				If lSldAntCC
					aSaldo    := SaldTotCT3(cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)
					aSaldoAnt := SaldTotCT3(cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,aSelFil,,,,lPosAntLP,dDataLP)
				ElseIf lSldAntIt
					aSaldo    := SaldTotCT4(cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)
					aSaldoAnt := SaldTotCT4(cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,aSelFil,,,,lPosAntLP,dDataLP)
				Else
					nPos := ASCAN(aTmpSal, {|x| x[1] == cArqTmp->CONTA + DToS(cArqTmp->DATAL) + cMoeda + cSaldo})
					If nPos <> 0
						aSaldo := aTmpSal[nPos][2]
					Else
						aSaldo	:= SaldoCT7Fil(cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo,,,,aSelFil)
						aAdd(aTmpSal, {cArqTmp->CONTA+DToS(cArqTmp->DATAL)+cMoeda+cSaldo,aSaldo})
					EndIf
					aSaldoAnt	:= SaldoCT7Fil(cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,"CTBR821",lPosAntLP,dDataLP,aSelFil)
				EndIf

				If CTBR821Fil(lNoMov,aSaldo,dDataIni,dDataFim)
					dbSkip()
					Loop
				EndIf

				If nOrden = 2
					oSection1:Cell("NIT"):SetValue( { || EntidadeCTB(cArqTmp->NIT,0,0,TAM_CONTA,.F.,cMascara4,cSepara4,,,,,.F.) } ) //cambio
				Else
					// Cuenta sintetica
					cContaSint := U_CTBR821Snt(cArqTmp->CONTA,@cDescSint,cMoeda,@cDescConta,@cCodRes,cMoedaDesc)
					oSection1:Cell("DESCCC"):SetValue( { || " - " + cDescSint } )
					oSection1:Cell("DESCCC"):SetSize(Len(cDescSint) + 3)
					If nImpCodC == 3
						nTamDesCta := LEN(CT1->CT1_CODIMP)
						oSection1:Cell("CONTA" ):SetValue( { || EntidadeCTB(CT1->CT1_CODIMP,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.) } )
					Else
						nTamDesCta := LEN(cContaSint)
						oSection1:Cell("CONTA" ):SetValue( { || EntidadeCTB(cContaSint,0,0,nTamDesCta,.F.,cMascara1,cSepara1,,,,,.F.) } )
					Endif

				EndIf

				oSection3:Cell("CTRANSP"):SetValue( { || Iif(nLinReport == 11,  STR0037, STR0037)}) //"Transporte"
				oSection3:Cell("CSLDATU"):SetBlock( { || ValorCTB(nSldTransp,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) })

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Inicio de Impresion de 1a SECCION³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oSection1:Init()
				nLin := 3

				oSection1:PrintLine()
				oSection1:Finish()

				If nOrden = 1
					xConta := STR0038 //"CUENTA - "
					If nImpCodC == 1	// Imprime Cod Normal
						xConta += EntidadeCTB(cArqTmp->CONTA,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
					Else
						dbSelectArea("CT1")
						CT1->(dbSetOrder(1)) //CT1_FILIAL+CT1_CONTA
						MsSeek(xFilial("CT1")+cArqTMP->CONTA,.F.)
						If nImpCodC == 3 // Imprime Codigo de Impressao
							xConta += EntidadeCTB(CT1->CT1_CODIMP,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
						Else										// Caso contrário usa codigo reduzido
							xConta += EntidadeCTB(CT1->CT1_RES,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
						EndIf
						cDescConta := &("CT1->CT1_DESC" + cMoedaDesc )
					Endif

					If !lAnalitico
						xConta +=  " - " + Left(cDescConta,30)
					Else
						xConta +=  " - " + Left(cDescConta,40)
					Endif
				EndIf

				dbSelectArea("cArqTmp")

				cContaAnt:= IIF( nOrden==1, cArqTmp->CONTA, cArqTmp->NIT )


				If nOrden == 1
					cCondic := "CONTA"
					nSaldoAtu := aSaldoAnt[6]
				Else
					cCondic := "NIT"
					nposNit :=  Ascan(aSlIniNIT, {|e| e[1] == AllTrim(cArqTmp->CONTA)+ "-" +AllTrim(cContaAnt)})

					If nposNit > 0
					nSaldoAtu := aSlIniNIT[nposNit,2]

					EndIF
				EndIf

				oSection1_1:Init()
				nLin := 2
				oSection1_1:PrintLine()
				oSection1_1:Finish()


				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³FIN de 1a SECCION³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³INICIO de 2a SECCION³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				dDataAnt	:= CTOD("  /  /  ")
				oSection2:Init()

				Do While cArqTmp->(!Eof() .And. &cCondic == cContaAnt ) .And. !oReport:Cancel()

					If oReport:Cancel()
						Exit
					EndIf

					If dDataAnt <> cArqTmp->DATAL
						If ( cArqTmp->LANCDEB <> 0 .Or. cArqTmp->LANCCRD <> 0 )
							oSection2:Cell("DATAL"):SetBlock( { || dDataAnt } )
						Endif
						dDataAnt := cArqTmp->DATAL
					EndIf

					oSection2:Cell("CORRELATIVO"):SetBlock( { || cArqTMP->LOTE+"/"+cArqTMP->SUBLOTE+"/"+cArqTmp->DOC+"/"+cArqTmp->SEQLAN } )

					If lAnalitico //Si es informe analitico

						nSaldoAtu 	:= nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD
						nTotDeb		+= cArqTmp->LANCDEB
						nTotCrd		+= cArqTmp->LANCCRD
						nTotGerDeb	+= cArqTmp->LANCDEB
						nTotGerCrd	+= cArqTmp->LANCCRD

						nposNit := 0
						If nOrden == 1
							cChaveNitTmp := AllTrim(cContaAnt) + "-" + AllTrim(cArqTmp->NIT)
						Else
							cChaveNitTmp := AllTrim(cArqTmp->CONTA) + "-" + AllTrim(cContaAnt)
						EndIf

						nposNit :=  Ascan(aSlIniNIT, {|e| e[1] == cChaveNitTmp})

						If nposNit > 0
							nSldTotNit := aSlIniNIT[nposNit,2]
							aSlIniNIT[nposNit,2] := nSldTotNit - cArqTmp->LANCDEB + cArqTmp->LANCCRD
						EndIF

						//Imprime Código de Cuenta
						oSection2:Cell("XPARTIDA"):SetValue( { || EntidadeCTB(cArqTmp->XPARTIDA,0,0,nContaTam,.F.,cMascara1,cSepara1,,,,,.F.) } )

				   		If lCusto
				   			//Imprime Código de Centro de Costo
							oSection2:Cell("CCUSTO"):SetValue( { || EntidadeCTB(cArqTmp->CCUSTO,0,0,nContaTam,.F.,cMascara2,cSepara2,,,,,.F.) } )
						EndIf

						//Imprime Código de ítem
						If lItem
							oSection2:Cell("ITEM"):SetValue( { || EntidadeCTB(cArqTmp->ITEM,0,0,nContaTam,.F.,cMascara3,cSepara3,,,,,.F.) } )
						EndIf

						oSection2:Cell("CLVAL"):SetValue( { || EntidadeCTB(cArqTmp->CLVAL,0,0,nContaTam,.F.,cMsc4ClV,cSpra4ClV,,,,,.F.) } )

						oSection2:Cell("SLDNIT"):SetBlock( { || ValorCTB(nSldTotNit,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) } )

						If lNIt .and. nImpCodC == 1//Si imprime clase de valor
							oSection2:Cell("NIT"):SetValue( { || EntidadeCTB(cArqTmp->NIT,0,0,nContaTam,.F.,cMascara4,cSepara4,,,,,.F.) } )
						Else
							oSection2:Cell("NIT"):SetValue( { || EntidadeCTB(cArqTmp->CONTA,0,0,nContaTam,.F.,cMascara4,cSepara4,,,,,.F.) } )
						Endif

						oSection2:Cell("CTPSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) } )
						nLin := 1

						nSldTransp := nSaldoAtu // Valor a Transportar - 1

						oReport:IncMeter()

						// Busca complemento historio e imprime
						CTBR821Imp( oSection2, cFilCT2 ) // oReport)

						cArqTmp->(dbSkip())

					Else // !lAnalitico -- Si fue resumido

						dbSelectArea("cArqTmp")

						While dDataAnt == cArqTmp->DATAL .And. cContaAnt == cArqTmp->CONTA
							nVlrDeb	+= cArqTmp->LANCDEB
							nVlrCrd	+= cArqTmp->LANCCRD
							nTotGerDeb	+= cArqTmp->LANCDEB
							nTotGerCrd	+= cArqTmp->LANCCRD
							cArqTmp->(dbSkip())
						EndDo

						nSaldoAtu	:= nSaldoAtu - nVlrDeb + nVlrCrd
						oSection2:Cell("CLANCDEB"):SetBlock( { || ValorCTB(nVlrDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) })// Debito
						oSection2:Cell("CLANCCRD"):SetBlock( { || ValorCTB(nVlrCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) })// Credito
						oSection2:Cell("CTPSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR+2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) })// Senala saldo actual => Consulta Razon

						//	Imprime Section(1) - Resumida.
						nLin := 1
						oSection2:PrintLine()
						oReport:IncMeter()

						nSldTransp := nSaldoAtu // Valor a Transportar

						nTotDeb	+= nVlrDeb
						nTotCrd	+= nVlrCrd
						nVlrDeb	:= 0
						nVlrCrd	:= 0
					Endif // lAnalitico
				EndDo //cArqTmp->(!Eof()) .And. cArqTmp->CONTA == cContaAnt

				If nSldTransp != 0
					nLinReport+=3
				Endif

				oSection2:Finish()

				nSldTransp  := 0
				nSaldoAtu   := 0
				nTotDeb	    := 0
				nTotCrd	    := 0

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³FIN De 2a SECCION³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			EndDo //lImpLivro .And. !cArqTmp->(Eof())
		EndIf //!(cArqTmp->(RecCount()) == 0 .And. !Empty(aSetOfBook[5]))
	EndIf // lImpLivro

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao dos Termos ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lImpTermos	// Impresion de los terminos

		oSection2:SetHeaderPage(.F.) // Deshabilita la impresion

		cArqAbert:=GetNewPar("MV_LRAZABE","")
		cArqEncer:=GetNewPar("MV_LRAZENC","")

		If Empty(cArqAbert)
			ApMsgAlert(STR0039 +; //"Deben ser creados los parámetros MV_LRAZABE y MV_LRAZEN. "
			STR0040) //"Utilice como base el parámetro MV_LDIARAB."
		Endif
	Endif

	If lImpTermos .And. ! Empty(cArqAbert)
		dbSelectArea("SM0")
		aVariaveis:={}

		For nCont:=1 to FCount()
			If FieldName(nCont)=="M0_CGC"
				AADD(aVariaveis,{FieldName(nCont),Transform(FieldGet(nCont),"@!R NN.NNN.NNN/NNNN-99")})
			Else
				If FieldName(nCont)=="M0_NOME"
					Loop
				EndIf
				AADD(aVariaveis,{FieldName(nCont),FieldGet(nCont)})
			Endif
		Next

		oObjX1:AddGroup(STR0001)
    	oObjX1:SearchGroup()
		IF LEN(oObjX1:GetGroup(STR0001))>0
			FOR nA:= 1 to Len(oObjX1:aGrupo[1][2])
				AADD(aVariaveis,{Rtrim(Upper(oObjX1:aGrupo[1][2][nA]:CX1_VAR01)),&(oObjX1:aGrupo[1][2][nA]:CX1_VAR01)})
			NEXT nA
		ENDIF	
    
		If AliasIndic( "CVB" )
			dbSelectArea( "CVB" )
			CVB->(dbSeek( xFilial( "CVB" ) ))
			For nCont:=1 to FCount()
				If FieldName(nCont)=="CVB_CGC"
					AADD(aVariaveis,{FieldName(nCont),Transform(FieldGet(nCont),"@!R NN.NNN.NNN/NNNN-99")})
				ElseIf FieldName(nCont)=="CVB_CPF"
					AADD(aVariaveis,{FieldName(nCont),Transform(FieldGet(nCont),"@R 999.999.999-99")})
				Else
					AADD(aVariaveis,{FieldName(nCont),FieldGet(nCont)})
				Endif
			Next
		EndIf

		AADD(aVariaveis,{"M_DIA",StrZero(Day(dDataBase),2)})
		AADD(aVariaveis,{"M_MES",MesExtenso()})
		AADD(aVariaveis,{"M_ANO",StrZero(Year(dDataBase),4)})

		If !File(cArqAbert)
			aSavSet:=__SetSets()
			cArqAbert:=CFGX024(,STR0041) // Editor de Termos de Livros //STR -> "Razón"
			__SetSets(aSavSet)
			Set(24,Set(24),.t.)
		Endif

		If !File(cArqEncer)
			aSavSet:=__SetSets()
			cArqEncer:=CFGX024(,STR0041) // Editor de Termos de Livros //STR -> "Razón"
			__SetSets(aSavSet)
			Set(24,Set(24),.t.)
		Endif

		If cArqAbert#NIL
			oReport:EndPage()
			ImpTerm2(cArqAbert,aVariaveis,,,,oReport)
		Endif
		If cArqEncer#NIL
			oReport:EndPage()
			ImpTerm2(cArqEncer,aVariaveis,,,,oReport)
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gera arquivo TXT ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR37 == 1
		CTBR821Ger(AllTrim(MV_PAR38))
	EndIf

	dbselectArea("CT2")
	If !Empty(dbFilter())
		dbClearFilter()
	Endif

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR821MaxºAutor  ³ Marco A. Gonzalez  º Data ³  25/05/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³En base en el parametro MV_PAR31, cuyo contenido esta en la º±±
±±º          ³variable "nMaxLin",controla el salto de pagina en tReport.  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSintaxe   ³ CTBR821Max(ExpN1,ExpN2)                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ ExpN1 = Numero de Lineas por Razon                         º±±
±±º          ³ ExpN2 = Lineas de Reporte                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR820                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CTBR821Max(nMaxLin, nLinReport)

	Local oSection1	:= oReport:Section(1)
	Local oSection3	:= oReport:Section(4)
	Local lSalLin		:= IIf(mv_par31==1,.T.,.F.)//"Salta linha entre contas?"

	If oSection1:Printing() .AND. lSalLin
		oReport:SkipLine()
		nLinReport++
	Endif

	nLinReport+=nLin

	If nLinReport >= nMaxLin

		If nSldTransp != 0
			oSection3:Init()
			oSection3:PrintLine()
			oReport:EndPage()

			nLinReport := 11
			oSection3:PrintLine()
			oReport:SkipLine()
			oSection3:Finish()
		Else
			oReport:EndPage()
			nLinReport := 9 + nLin
		Endif
	Endif

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR821Impº Autor ³Marco A. Gonzalez   º Data ³  27/04/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Regresa la descripcion de: cuenta contable, item, cento de  º±±
±±º          ³costo o clase valor                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSintaxe   ³ CTBR821Imp(ExpO1)                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ ExpO1 = Objeto Seccion                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR821                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CTBR821Imp(oSection2, cFilCT2)
	Local lDev4		:= oReport:nDevice == 4	//Impresion mediante opcion 4 - Planilla
	Local cAliasQry := GetNextAlias()
	Local cDC       := "4"
	Local cHisto := ""

	Default cFilCT2 := xFilial("CT2")

	If lDev4
		oSection2:Cell("HISTORICO"):SetValue( { || cArqTmp->HISTORICO } )
	Else
		oSection2:Cell("HISTORICO"):SetValue( { || Substr(cArqTmp->HISTORICO,1,40) } )
	EndIf

	oSection2:Cell("DATAL"		):Show()
	oSection2:Cell("CORRELATIVO"):Show()
	oSection2:Cell("XPARTIDA"	):Show()
	oSection2:Cell("CCUSTO"		):Show()
	oSection2:Cell("ITEM"		):Show()
	oSection2:Cell("CLVAL"		):Show()
	oSection2:Cell("NIT"		):Show()
	oSection2:Cell("CLANCDEB"	):Show()
	oSection2:Cell("CLANCCRD"	):Show()
	oSection2:Cell("CTPSLDATU"	):Show()
	oSection2:Cell("SLDNIT"		):Show()
	oSection2:PrintLine()

	// Procura pelo complemento de historico
	BeginSQL Alias cAliasQry
	SELECT CT2_HIST FROM %Table:CT2% CT2
		WHERE  CT2.CT2_FILIAL = %Exp:cFilCT2%
			AND CT2.CT2_LOTE = %Exp:cArqTMP->LOTE%
			AND CT2.CT2_SBLOTE = %Exp:cArqTMP->SUBLOTE%
			AND CT2.CT2_DOC = %Exp:cArqTmp->DOC%
			AND CT2.CT2_SEQLAN = %Exp:cArqTmp->SEQLAN%
			AND CT2.CT2_EMPORI = %Exp:cArqTmp->EMPORI%
			AND CT2.CT2_FILORI = %Exp:cArqTmp->FILORI%
			AND CT2.CT2_DC = %Exp:cDC%
			AND CT2.CT2_DATA = %Exp:cArqTmp->DATAL%
			AND CT2.%NotDel%
	EndSQL

	While !(cAliasQry)->(Eof())
		cHisto := (cAliasQry)->CT2_HIST
		(cAliasQry)->(dbSkip())
		oSection2:Cell("HISTORICO"):SetBlock({|| cHisto } )
		oSection2:Cell("DATAL"		):Hide()
		oSection2:Cell("CORRELATIVO"):Hide()
		oSection2:Cell("XPARTIDA"	):Hide()
		oSection2:Cell("CCUSTO"		):Hide()
		oSection2:Cell("ITEM"		):Hide()
		oSection2:Cell("CLVAL"		):Hide()
		oSection2:Cell("NIT"		):Hide()
		oSection2:Cell("CLANCDEB"	):Hide()
		oSection2:Cell("CLANCCRD"	):Hide()
		oSection2:Cell("CTPSLDATU"	):Hide()
	    oSection2:Cell("SLDNIT"		):Hide()
		oSection2:PrintLine()
	ENDDO

	(cAliasQry)->(dbCloseArea())
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR821FilºAutor  ³Marco A. Gonzalez   º Data ³  27/04/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica si se imprime cuentas con movimiento basado en el º±±
±±º          ³ plan de cuenta.                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSintaxe   ³ CTBR821Fil(ExpL1,ExpA2,ExpD3,ExpD4)                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ ExpL1 = Indica si imprime movimiento reajustado            º±±
±±º          ³ ExpA2 = Saldo                                              º±±
±±º          ³ ExpD3 = Fecha Inicial                                      º±±
±±º          ³ ExpD4 = Fecha Final                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR821                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTBR821Fil(lNoMov,aSaldo,dDataIni,dDataFim)

	Local lDeixa	:= .F.

	If !lNoMov //Si imprime cuenta sin movimento
		If aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0
			lDeixa	:= .T.
		Endif
	Endif

	If lNoMov .And. aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0
		If CtbExDtFim("CT1")
			dbSelectArea("CT1")
			CT1->(dbSetOrder(1)) //CT1_FILIAL+CT1_CONTA
			If MsSeek(xFilial()+cArqTmp->CONTA)
				If !CtbVlDtFim("CT1",dDataIni)
					lDeixa	:= .T.
				EndIf

				If !CtbVlDtIni("CT1",dDataFim)
					lDeixa	:= .T.
				EndIf

			EndIf
		EndIf
	EndIf

	dbSelectArea("cArqTmp")

Return (lDeixa)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CTBR821NIT³ Autor ³ Marco A. Gonzalez     ³ Data ³ 27/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Crea Archivo Temporal para imprimir la razon                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³U_CTBR821NIT(ExpO1,ExpO2,ExpO3,ExpL1,ExpC1,ExpC2,ExpC3,ExpC4, ³±±
±±³           ³           ExpC5,ExpC6,ExpC7,ExpC8,ExpC9,ExpD1,ExpD1,ExpA1, ³±±
±±³           ³           ExpL2,ExpC10,ExpL3,ExpC11,ExpL4,ExpC11,ExpC12,   ³±±
±±³           ³           ExpL5,ExpA2)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ Nombre del Archivo Temporal                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Accion de Codeblock                                ³±±
±±³           ³ ExpC1 = Archivo Temporal                                   ³±±
±±³           ³ ExpC2 = Cuenta Inicial                                     ³±±
±±³           ³ ExpC3 = Cuenta Final                                       ³±±
±±³           ³ ExpC4 = C.Costo Inicial                                    ³±±
±±³           ³ ExpC5 = C.Costo Final                                      ³±±
±±³           ³ ExpC6 = Item Inicial                                       ³±±
±±³           ³ ExpC7 = Cl.Valor Inicial                                   ³±±
±±³           ³ ExpC8 = Cl.Valor Final                                     ³±±
±±³           ³ ExpC9 = Moneda                                             ³±±
±±³           ³ ExpD1 = Fecha Inicial                                      ³±±
±±³           ³ ExpD2 = Fecha Final                                        ³±±
±±³           ³ ExpA1 = Matriz Set Of Book                                 ³±±
±±³           ³ ExpL2 = Indica si imprime movimento reajustado o no.       ³±±
±±³           ³ ExpC10= Tipo de Saldo                                      ³±±
±±³           ³ ExpL3 = Indica si junta CC o no.                           ³±±
±±³           ³ ExpC11= Tipo de lanzamiento                                ³±±
±±³           ³ ExpL4 = Indica si imprime analitico o sintetico            ³±±
±±³           ³ ExpC11 = Indica moneda 2 para ser incluida en el informe   ³±±
±±³           ³ ExpC12 = Contenido Txt con el filtro del usuario (CT2)     ³±±
±±³           ³ ExpL5 = Si Saldo Anterior                                  ³±±
±±³           ³ ExpA2 = Matriz Filial                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR821NIT(oMeter,oText,oDlg,lEnd,cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
		cItemIni,cItemFim,cNitIni,cNitFim,cMoeda,dDataIni,dDataFim,;
		aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,lAnalit,c2Moeda,;
		nTipo,cUFilter,lSldAnt,aSelFil)

	Local aTamConta	:= TAMSX3("CT1_CONTA")
	Local aTamCusto	:= TAMSX3("CT3_CUSTO")
	Local aTamVal		:= TAMSX3("CT2_VALOR")
	Local aCtbMoeda	:= {}
	Local aSaveArea	:= GetArea()
	Local aCampos
	Local aChave		:= {}
	Local nTamHist	:= Len(CriaVar("CT2_HIST"))
	Local nTamItem	:= Len(CriaVar("CTD_ITEM"))
	Local nTamNit		:= Len(CriaVar("CV0_CODIGO"))
	Local nTamClVl	:= Len(CriaVar("CT2_CLVLDB"))
	Local nTamDCta	:= GetSX3Cache("CT1_DESC01","X3_TAMANHO")
	Local nTamNorm	:= GetSX3Cache("CT1_NORMAL","X3_TAMANHO")
	Local nDecimais	:= 0
	Local cMensagem	:= STR0042	//STR // "El Plan Gerencial no está disponible en este informe."
	Local nTamFilial	:= IIf( lFWCodFil, FWGETTAMFILIAL, TamSx3( "CT2_FILIAL" )[1] )
	Local nTamSegOfi	:= Len(CriaVar("CT2_SEGOFI"))

	Default c2Moeda	:= ""
	Default nTipo		:= 1
	Default cUFilter	:= ""
	Default lSldAnt	:= .F.
	Default aSelFil	:= {}

	If cTipo == "1" .And. FunName() == 'CTBR821' .And. TCGetDb() $ "MSSQL7/MSSQL"
		DEFAULT cUFilter	:= ".T."
	Else
		Default cUFilter	:= ""
	Endif


	// Retorna Decimais
	aCtbMoeda := CTbMoeda(cMoeda)
	nDecimais := aCtbMoeda[5]

	aCampos :={{ "CONTA"		, "C", aTamConta[1]	, 0				},;	// Codigo da Conta
				{ "XPARTIDA"	, "C", aTamConta[1]	, 0				},;	// Contra Partida
				{ "TIPO"		, "C", 01				, 0				},;	// Tipo do Registro (Debito/Credito/Continuacao)
				{ "LANCDEB"	, "N", aTamVal[1]+2	, nDecimais	},;	// Debito
				{ "LANCCRD"	, "N", aTamVal[1]+2	, nDecimais	},;	// Credito
				{ "SALDOSCR"	, "N", aTamVal[1]+2	, nDecimais	},;	// Saldo
				{ "TPSLDANT"	, "C", 01				, 0				},;	// Sinal do Saldo Anterior => Consulta Razao
				{ "TPSLDATU"	, "C", 01				, 0				},;	// Sinal do Saldo Atual => Consulta Razao
				{ "HISTORICO"	, "C", nTamHist		, 0				},;	// Historico
				{ "CCUSTO"		, "C", aTamCusto[1]	, 0				},;	// Centro de Custo
				{ "ITEM"		, "C", nTamItem		, 0				},;	// Item Contabil
				{ "SLDNIT"		, "N", aTamVal[1]+2	, nDecimais			, 0				},;	// Saldo Nit
				{ "NIT"		, "C", nTamNit		, 0				},;	// Classe de Valor
				{ "DATAL"		, "D", 10				, 0				},;	// Data do Lancamento
				{ "LOTE" 		, "C", 06				, 0				},;	// Lote
				{ "SUBLOTE" 	, "C", 03				, 0				},;	// Sub-Lote
				{ "DOC" 		, "C", 06				, 0				},;	// Documento
				{ "LINHA"		, "C", 03				, 0				},;	// Linha
				{ "SEQLAN"		, "C", 03				, 0				},;	// Sequencia do Lancamento
				{ "SEQHIST"	, "C", 03				, 0				},;	// Seq do Historico
				{ "EMPORI"		, "C", 02				, 0				},;	// Empresa Original
				{ "FILORI"		, "C", nTamFilial		, 0				},;	// Filial Original
				{ "NOMOV"		, "L", 01				, 0				},;	// Conta Sem Movimento
				{ "FILIAL"		, "C", nTamFilial		, 0				},;	// Filial do sistema
				{ "SEGOFI"		, "C", nTamSegOfi		, 0				},;	// Numero do Correlativo
				{ "CLVAL"       , "C", nTamClVl         , 0             },; // Clase Valor
				{ "DESCTA"      , "C", nTamDCta         , 0             },; // Desc.Cuenta
				{ "NORMAL"      , "C", nTamNorm         , 0             }} // Normal

	If ! Empty(c2Moeda)
		Aadd(aCampos, { "LANCDEB_1"	, "N", aTamVal[1]+2, nDecimais }) // Debito
		Aadd(aCampos, { "LANCCRD_1"	, "N", aTamVal[1]+2, nDecimais }) // Credito
		Aadd(aCampos, { "TXDEBITO"	, "N", aTamVal[1]+2, 6 }) // Taxa Debito
		Aadd(aCampos, { "TXCREDITO"	, "N", aTamVal[1]+2, 6 }) // Taxa Credito
	Endif

	// Se o arquivo temporario de trabalho esta aberto
	If ( Select ( "cArqTmp" ) > 0 )
		cArqTmp->(dbCloseArea())
	EndIf

	oTmpTable := FWTemporaryTable():New("cArqTmp")
	oTmpTable:SetFields( aCampos )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Indice Temporario do Arquivo de Trabalho 1.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cTipo == "1"	// Razao por Conta
		If FunName() <> "CTBC402"
			aChave   := {"CONTA","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"}
		Else
			aChave   := {"CONTA","DATAL","LOTE","SUBLOTE","DOC","EMPORI","FILORI","LINHA"}
		EndIf
	ElseIf cTipo == "2"	// Razao por Centro de Custo
		If lAnalit	// Se o relatorio for analitico
			If FunName() <> "CTBC440"
				aChave 	:= {"CCUSTO","CONTA","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"}
			Else
				aChave 	:= {"CCUSTO","CONTA","DATAL","LOTE","SUBLOTE","DOC","EMPORI","FILORI","LINHA"}
			EndIf
		Else
			aChave 	:= {"CCUSTO","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"}
		Endif
	ElseIf cTipo == "3"	//Razao por Item Contabil
		If lAnalit	// Se o relatorio for analitico
			If FunName() <> "CTBC480"
				aChave 	:= {"ITEM","CONTA","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"}
			Else
				aChave 	:= {"ITEM","CONTA","DATAL","LOTE","SUBLOTE","DOC","EMPORI","FILORI","LINHA"}
			Endif
		Else
			aChave 	:= {"ITEM","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"}
		Endif
	ElseIf cTipo == "4"	//Razao por Classe de Valor
		If lAnalit	// Se o relatorio for analitico
			If FunName() <> "CTBC490"
				aChave 	:= {"NIT","CONTA","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"}
			Else
				aChave 	:= {"NIT","CONTA","DATAL","LOTE","SUBLOTE","DOC","EMPORI","FILORI","LINHA"}
			EndIf
		Else
			aChave 	:= {"NIT","CONTA","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"}
		Endif
	EndIf

	//Creacion de la tabla
	oTmpTable:AddIndex('T1ORD', aChave)
	oTmpTable:Create()
	dbSelectArea("cArqTmp")

	dbSetOrder(1)

	If !Empty(aSetOfBook[5])
		MsgAlert(cMensagem)
		Return
	EndIf

	//CT2->(dbGotop())

	If cTipo == "1" .And. FunName() == 'CTBR821' .And. TCGetDb() $ "MSSQL7/MSSQL"
		U_CTBR821Qry(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
			cItemIni,cItemFim,cNitIni,cNitFim,cMoeda,dDataIni,dDataFim,;
			aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,c2Moeda,cUFilter,lSldAnt,aSelFil)
	Else
		// Monta Arquivo para gerar o Razao
		U_CTBR821Raz(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
			cItemIni,cItemFim,cNitIni,cNitFim,cMoeda,dDataIni,dDataFim,;
			aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,c2Moeda,nTipo,cUFilter,lSldAnt,aSelFil)
	EndIf

	RestArea(aSaveArea)

Return cArqTmp

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CTBR821Raz³ Autor ³ Marco A. Gonzalez     ³ Data ³ 27/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Realiza el filtrado de registros de razon                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_CTBR821Raz(ExpO1,ExpO2,ExpO3,ExpL1,ExpC2,ExpC3,ExpC4,ExpC5, ³±±
±±³				³           ExpC6,ExpC7,ExpC8,ExpC9,ExpD1,ExpD2,ExpA1,ExpL2, ³±±
±±³				³           ExpC10,ExpL3,ExpC11,ExpC12,ExpN1,ExpC13,ExpL4,   ³±±
±±³				³           ExpA2)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Accion de Codeblock                                ³±±
±±³           ³ ExpC2 = Cuenta Inicial                                     ³±±
±±³           ³ ExpC3 = Cuenta Final                                       ³±±
±±³           ³ ExpC4 = C.Costo Inicial                                    ³±±
±±³           ³ ExpC5 = C.Costo Final                                      ³±±
±±³           ³ ExpC6 = Item Inicial                                       ³±±
±±³           ³ ExpC7 = Cl.Valor Inicial                                   ³±±
±±³           ³ ExpC8 = Cl.Valor Final                                     ³±±
±±³           ³ ExpC9 = Moneda                                             ³±±
±±³           ³ ExpD1 = Fecha Inicial                                      ³±±
±±³           ³ ExpD2 = Fecha Final                                        ³±±
±±³           ³ ExpA1 = Matriz Set Of Book                                 ³±±
±±³           ³ ExpL2 = Indica se imprime movimento reajustado o no.       ³±±
±±³           ³ ExpC10= Tipo de Saldo                                      ³±±
±±³           ³ ExpL3 = Indica si junta CC o no.                           ³±±
±±³           ³ ExpC11= Tipo de lanzamiento                                ³±±
±±³           ³ ExpC12 = Indica moneda 2 para ser incluida en el informe   ³±±
±±³           ³ ExpN1 = Numero Tipo Lanzamiento                            ³±±
±±³           ³ ExpC13 = Contenido Txt con el Filtro de Usuario (CT2)      ³±±
±±³           ³ ExpL4 = Si saldo Anterior                                  ³±±
±±³           ³ ExpA2 = Matriz Filial                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR821Raz(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
		cItemIni,cItemFim,cNitIni,cNitFim,cMoeda,dDataIni,dDataFim,;
		aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,c2Moeda,nTipo,cUFilter,lSldAnt,aSelFil)

	Local cCpoChave	:= ""
	Local cTmpChave	:= ""
	Local cContaI		:= ""
	Local cContaF		:= ""
	Local cCustoI		:= ""
	Local cCustoF		:= ""
	Local cItemI		:= ""
	Local cItemF		:= ""
	Local cNitI		:= ""
	Local cNitF		:= ""
	Local cVldEnt		:= ""
	Local cAlias		:= ""
	Local lUFilter	:= !Empty(cUFilter)	// SE O FILTRO DE USUÁRIO NÃO ESTIVER VAZIO - TEM FILTRO DE USUÁRIO
	Local cFilMoeda	:= ""
	Local cAliasCT2	:= "CT2"
	Local bCond		:= {||.T.}
	Local cQryFil		:= '' // variavel de condicional da query
	Local cTmpCT2Fil


	Local cQuery		:= ""
	Local cOrderBy	:= ""
	Local nI			:= 0
	Local aStru		:= {}


	Default cUFilter	:= ".T."
	Default lSldAnt	:= .F.
	Default aSelFil	:= {}

	cQryFil := " CT2_FILIAL " + GetRngFil( aSelFil ,"CT2", .T., @cTmpCT2Fil)

	cCustoI	:= cCustoIni
	cCustoF	:= cCustoFim
	cContaI	:= cContaIni
	cContaF	:= cContaFim
	cItemI		:= cItemIni
	cItemF		:= cItemFim
	cNitI		:= cNitIni
	cNitF		:= cNitFim

	If !Empty(c2Moeda)
		cFilMoeda	:= " (CT2_MOEDLC = '" + cMoeda + "' OR "
		cFilMoeda	+= " CT2_MOEDLC = '" + c2Moeda + "') "
	Else
		cFilMoeda	:= " CT2_MOEDLC = '" + cMoeda + "' "
	EndIf
	
	If !isBlind()
		oMeter:nTotal := CT1->(RecCount())
	EndIf	

	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³ Obt‚m os d‚bitos ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cTipo <> "1"
		If cTipo = "2" .And. Empty(cCustoIni)
			CTT->(DbSeek(xFilial("CTT")))
			cCustoIni := CTT->CTT_CUSTO
		Endif
		If cTipo = "3" .And. Empty(cItemIni)
			CTD->(DbSeek(xFilial("CTD")))
			cItemIni := CTD->CTD_ITEM
		Endif
		If cTipo = "4" .And. Empty(cNitIni)
			CV0->(DbSeek(xFilial("CV0")+"01"))
			cClVlIni := CV0->CV0_CODIGO
		Endif
	Endif

	If cTipo == "1"
		dbSelectArea("CT2")
		CT2->(dbSetOrder(2)) //CT2_FILIAL+CT2_DEBITO+DTOS(CT2_DATA)
		cValid	:= 	"CT2_DEBITO>='" + cContaIni + "' AND " +;
					"CT2_DEBITO<='" + cContaFim + "'"
		cVldEnt := "CT2_CCD>='" + cCustoIni + "' AND " +;
					"CT2_CCD<='"		+ cCustoFim	+ "' AND " + ;
					IIf(cPaisLoc == "COL", "CT2_CLVLDB>='"	+ ;
					cClValIni + "' AND " + "CT2_CLVLDB<='"	+ cClValFim	+ "' AND " ,"") + ;
					"CT2_ITEMD>='"	+ cItemIni		+ "' AND " +;
					"CT2_ITEMD<='"	+ cItemFim		+ "' AND " +;
					"CT2_EC05DB>='"	+ cNitIni		+ "' AND " +;
					"CT2_EC05DB<='"	+ cNitFim		+ "'"
		cOrderBy := " CT2_FILIAL, CT2_DEBITO, CT2_DATA "
	ElseIf cTipo == "2"
		dbSelectArea("CT2")
		CT2->(dbSetOrder(4)) //CT2_FILIAL+CT2_CCD+DTOS(CT2_DATA)
		cValid	:= 	"CT2_CCD >= '" + cCustoIni + "'  AND  " +;
					"CT2_CCD <= '" + cCustoFim + "'"
		cVldEnt := "CT2_DEBITO >= '" + cContaIni + "'  AND  " +;
					"CT2_DEBITO <= '"	+ cContaFim	+ "'  AND  " +;
					"CT2_ITEMD >= '"	+ cItemIni		+ "'  AND  " +;
					"CT2_ITEMD <= '"	+ cItemFim		+ "'  AND  " +;
					"CT2_EC05DB >= '"	+ cNitIni		+ "'  AND  " +;
					"CT2_EC05DB <= '"	+ cNitFim		+ "'"
		cOrderBy := " CT2_FILIAL, CT2_CCD, CT2_DATA "
	ElseIf cTipo == "3"
		dbSelectArea("CT2")
		CT2->(dbSetOrder(6)) //CT2_FILIAL+CT2_ITEMD+DTOS(CT2_DATA)
		cValid := 	"CT2_ITEMD >= '" + cItemIni + "'  AND  " +;
					"CT2_ITEMD <= '" + cItemFim + "'"
		cVldEnt := "CT2_DEBITO >= '" + cContaIni + "'  AND  " +;
					"CT2_DEBITO <= '"	+ cContaFim	+ "'  AND  " +;
					"CT2_CCD >= '"	+ cCustoIni	+ "'  AND  " +;
					"CT2_CCD <= '"	+ cCustoFim	+ "'  AND  " +;
					"CT2_EC05DB >= '"	+ cNitIni		+ "'  AND  " +;
					"CT2_EC05DB <= '"	+ cNitFim		+ "'"
		cOrderBy := " CT2_FILIAL, CT2_ITEMD, CT2_DATA "
	ElseIf cTipo == "4"
		dbSelectArea("CT2")
		CT2->(dbSetOrder(8)) //CT2_FILIAL+CT2_CLVLDB+DTOS(CT2_DATA)
		cValid := "CT2_EC05DB >= '" + cNitIni + "'  AND  " +;
					"CT2_EC05DB <= '" + cNitFim + "'"
		cVldEnt := "CT2_DEBITO >= '" + cContaIni + "'  AND  " +;
					"CT2_DEBITO <= '"	+ cContaFim	+ "'  AND  " +;
					"CT2_CCD >= '"	+ cCustoIni	+ "'  AND  " +;
					"CT2_CCD <= '"	+ cCustoFim	+ "'  AND  " +;
					"CT2_ITEMD >= '"	+ cItemIni		+ "'  AND  " +;
					"CT2_ITEMD <= '"	+ cItemFim		+ "'"
		cOrderBy := " CT2_FILIAL, CT2_EC05DB, CT2_DATA "
	EndIf

	cAliasCT2 := "cAliasCT2"

	cQuery	:= " SELECT * "
	cQuery	+= " FROM " + RetSqlName("CT2")
	cQuery	+= " WHERE " + cQryFil + " AND "
	cQuery	+= cValid + " AND "
	cQuery	+= " CT2_DATA >= '" + DTOS(dDataIni) + "' AND "
	cQuery	+= " CT2_DATA <= '" + DTOS(dDataFim) + "' AND "
	cQuery	+= cVldEnt+ " AND "
	cQuery	+= cFilMoeda + " AND "
	cQuery	+= " CT2_TPSALD = '"+ cSaldo + "'"
	cQuery	+= " AND (CT2_DC = '1' OR CT2_DC = '3')"
	cQuery	+= " AND CT2_VALOR <> 0 "
	cQuery	+= " AND D_E_L_E_T_ = ' ' "
	cQuery	+= " ORDER BY "+ cOrderBy
	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasCT2,.T.,.F.)
	aStru := CT2->(dbStruct())

	For ni := 1 to Len(aStru)
		If aStru[ni,2] != 'C'
			TCSetField(cAliasCT2, aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
		Endif
	Next ni

	If lUFilter	// ADICIONA O FILTRO DEFINIDO PELO USUÁRIO SE NÃO ESTIVER EM BRANCO
		If !Empty(cVldEnt)
			cVldEnt  += " AND "	// SE JÁ TIVER CONTEUDO, ADICIONA "AND"
			cVldEnt  += cUFilter	// ADICIONA O FILTRO DE USUÁRIO
		EndIf
	EndIf

	If (!lUFilter) .or. Empty(cUFilter)
		cUFilter := ".T."
	EndIf

	dbSelectArea(cAliasCT2)
	While !Eof()
		If &cUFilter
			U_CTBR821GrR(lJunta,cMoeda,cSaldo,"1",c2Moeda,cAliasCT2,nTipo)
			dbSelectArea(cAliasCT2)
		EndIf
		cAliasCT2->(dbSkip())
	EndDo
	If ( Select ( "cAliasCT2" ) <> 0 )
		dbSelectArea ( "cAliasCT2" )
		cAliasCT2->(dbCloseArea ())
	Endif

	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³ Obt‚m os creditos³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cTipo == "1"
		dbSelectArea("CT2")
		CT2->(dbSetOrder(3)) //CT2_FILIAL+CT2_CREDIT+DTOS(CT2_DATA)
	ElseIf cTipo == "2"
		dbSelectArea("CT2")
		CT2->(dbSetOrder(5)) //CT2_FILIAL+CT2_CCC+DTOS(CT2_DATA)
	ElseIf cTipo == "3"
		dbSelectArea("CT2")
		CT2->(dbSetOrder(7)) //CT2_FILIAL+CT2_ITEMC+DTOS(CT2_DATA)
	ElseIf cTipo == "4"
		dbSelectArea("CT2")
		CT2->(dbSetOrder(9)) //CT2_FILIAL+CT2_CLVLCR+DTOS(CT2_DATA)
	EndIf

	If cTipo == "1"
		cValid	:= 	"CT2_CREDIT>='" + cContaIni + "' AND " +;
			"CT2_CREDIT<='" + cContaFim + "'"
		cVldEnt := "CT2_CCC>='" + cCustoIni + "' AND " +;
			"CT2_CCC<='"		+ cCustoFim	+ "' AND " +;
			IIf(cPaisLoc == "COL", "CT2_CLVLDB>='"	+ ;
			cClValIni + "' AND " + "CT2_CLVLDB<='"	+ cClValFim	+ "' AND " ,"") + ;
			"CT2_ITEMC>='"	+ cItemIni		+ "' AND " +;
			"CT2_ITEMC<='"	+ cItemFim		+ "' AND " +;
			"CT2_EC05CR>='"	+ cNitIni		+ "' AND " +;
			"CT2_EC05CR<='"	+ cNitFim		+ "'"
		cOrderBy := " CT2_FILIAL, CT2_CREDIT, CT2_DATA "
	ElseIf cTipo == "2"
		cValid := 	"CT2_CCC >= '" + cCustoIni + "'  AND  " +;
			"CT2_CCC <= '" + cCustoFim + "'"
		cVldEnt := "CT2_CREDIT >= '" + cContaIni + "'  AND  " +;
			"CT2_CREDIT <= '"	+ cContaFim	+ "'  AND  " +;
			"CT2_ITEMC >= '"	+ cItemIni		+ "'  AND  " +;
			"CT2_ITEMC <= '"	+ cItemFim		+ "'  AND  " +;
			"CT2_EC05CR >= '"	+ cNitIni		+ "'  AND  " +;
			"CT2_EC05CR <= '"	+ cNitFim		+ "'"
		cOrderBy := " CT2_FILIAL, CT2_CCC, CT2_DATA "
	ElseIf cTipo == "3"
		cValid	:= "CT2_ITEMC >= '" + cItemIni + "'  AND  " +;
			"CT2_ITEMC <= '" + cItemFim + "'"
		cVldEnt  := "CT2_CREDIT >= '" + cContaIni + "'  AND  " +;
			"CT2_CREDIT <= '"	+ cContaFim	+ "'  AND  " +;
			"CT2_CCC >= '"	+ cCustoIni	+ "'  AND  " +;
			"CT2_CCC <= '"	+ cCustoFim	+ "'  AND  " +;
			"CT2_EC05CR >= '"	+ cNitIni		+ "'  AND  " +;
			"CT2_EC05CR <= '"	+ cNitFim		+ "'"
		cOrderBy := " CT2_FILIAL, CT2_ITEMC, CT2_DATA "
	ElseIf cTipo == "4"
		cValid := "CT2_EC05CR >= '" + cNitIni + "'  AND  " +;
			"CT2_EC05CR <= '" + cNitFim + "'"
		cVldEnt := "CT2_CREDIT >= '" + cContaIni + "'  AND  " +;
			"CT2_CREDIT <= '"	+ cContaFim	+ "'  AND  " +;
			"CT2_CCC >= '"	+ cCustoIni	+ "'  AND  " +;
			"CT2_CCC <= '"	+ cCustoFim	+ "'  AND  " +;
			"CT2_ITEMC >= '"	+ cItemIni		+ "'  AND  " +;
			"CT2_ITEMC <= '"	+ cItemFim		+ "'"
		cOrderBy := " CT2_FILIAL, CT2_EC05CR, CT2_DATA "
	EndIf

	cAliasCT2	:= "cAliasCT2"

	cQuery	:= " SELECT * "
	cQuery	+= " FROM " + RetSqlName("CT2")
	cQuery	+= " WHERE " + cQryFil + " AND "
	cQuery	+= cValid + " AND "
	cQuery	+= " CT2_DATA >= '" + DTOS(dDataIni) + "' AND "
	cQuery	+= " CT2_DATA <= '" + DTOS(dDataFim) + "' AND "
	cQuery	+= cVldEnt+ " AND "
	cQuery	+= cFilMoeda + " AND "
	cQuery	+= " CT2_TPSALD = '"+ cSaldo + "' AND "
	cQuery	+= " (CT2_DC = '2' OR CT2_DC = '3') AND "
	cQuery	+= " CT2_VALOR <> 0 AND "
	cQuery	+= " D_E_L_E_T_ = ' ' "
	cQuery	+= " ORDER BY "+ cOrderBy
	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasCT2,.T.,.F.)

	aStru := CT2->(dbStruct())

	For ni := 1 to Len(aStru)
		If aStru[ni,2] != 'C'
			TCSetField(cAliasCT2, aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
		Endif
	Next ni

	If lUFilter	// ADICIONA O FILTRO DEFINIDO PELO USUÁRIO SE NÃO ESTIVER EM BRANCO
		If !Empty(cVldEnt)
			cVldEnt  += " AND "	// SE JÁ TIVER CONTEUDO, ADICIONA "AND"
			cVldEnt  += cUFilter	// ADICIONA O FILTRO DE USUÁRIO
		EndIf
	EndIf

	If (!lUFilter) .or. Empty(cUFilter)
		cUFilter := ".T."
	EndIf

	dbSelectArea(cAliasCT2)
	While !Eof()
		If &cUFilter
			U_CTBR821GrR(lJunta,cMoeda,cSaldo,"2",c2Moeda,cAliasCT2,nTipo)
			dbSelectArea(cAliasCT2)
		EndIf
		cAliasCT2->(dbSkip())
	EndDo

	If ( Select ( "cAliasCT2" ) <> 0 )
		dbSelectArea ( "cAliasCT2" )
		cAliasCT2->(dbCloseArea ())
	Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CTBR821GrR³ Autor ³ Marco A. Gonzalez     ³ Data ³ 27/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Guarda registros en archivo temporal - Razon               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³ U_CTBR821GrR(ExpL1,ExpC1,ExpC2,ExpC3,ExpC4,ExpC5,ExpN1)      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpL1 = Si junta CC o no                                   ³±±
±±³           ³ ExpC1 = Moneda                                             ³±±
±±³           ³ ExpC2 = Tipo de saldo                                      ³±±
±±            ³ ExpC3 = Tipo de lanzamiento                                ³±±
±±³           ³ ExpC4 = Indica moneda 2 para ser incluida en el informe    ³±±
±±³           ³ ExpC5 = Alias con el conteudo seleccionado de CT2          ³±±
±±³           ³ ExpN1 = Tipo                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR821GrR(lJunta,cMoeda,cSaldo,cTipo,c2Moeda,cAliasCT2,nTipo)

	Local cConta
	Local cContra
	Local cCCosto
	Local cItem
	Local cClVal
	Local cNit
	Local cChave			:= ""
	Local lImpCPartida	:= GetNewPar("MV_IMPCPAR",.T.)	// Se .T., IMPRIME Contra-Partida para TODOS os tipos de lançamento (Débito, Credito e Partida-Dobrada),
                                                  		// se .F., NÃO IMPRIME Contra-Partida para NENHUM   tipo  de lançamento.
	Default cAliasCT2		:= "CT2"

	If !Empty(c2Moeda)
		If cTipo == "1"
			cChave	:=	(cAliasCT2)->(CT2_DEBITO+DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA+CT2_EMPORI+CT2_FILORI)
		Else
			cChave	:=	(cAliasCT2)->(CT2_CREDIT+DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA+CT2_EMPORI+CT2_FILORI)
		EndIf
	EndIf

	If cTipo == "1"
		cConta		:= (cAliasCT2)->CT2_DEBITO
		cContra	:= (cAliasCT2)->CT2_CREDIT
		cCCosto		:= (cAliasCT2)->CT2_CCD
		cItem		:= (cAliasCT2)->CT2_ITEMD
		cNit		:= (cAliasCT2)->CT2_EC05DB
		cClVal		:= (cAliasCT2)->CT2_CLVLDB
	EndIf
	If cTipo == "2"
		cConta		:= (cAliasCT2)->CT2_CREDIT
		cContra	:= (cAliasCT2)->CT2_DEBITO
		cCCosto		:= (cAliasCT2)->CT2_CCC
		cItem		:= (cAliasCT2)->CT2_ITEMC
		cNit		:= (cAliasCT2)->CT2_EC05CR
		cClVal		:= (cAliasCT2)->CT2_CLVLCR
	EndIf

	dbSelectArea("cArqTmp")
	dbSetOrder(1)
	If !Empty(c2Moeda)
		If MsSeek(cChave,.F.)
			Reclock("cArqTmp",.F.)
		Else
			RecLock("cArqTmp",.T.)
		EndIf
	Else
		RecLock("cArqTmp",.T.)
	EndIf

	DATAL		:= (cAliasCT2)->CT2_DATA
	TIPO		:= cTipo
	LOTE		:= (cAliasCT2)->CT2_LOTE
	SUBLOTE	:= (cAliasCT2)->CT2_SBLOTE
	DOC		:= (cAliasCT2)->CT2_DOC
	LINHA		:= (cAliasCT2)->CT2_LINHA
	CONTA		:= cConta

	If lImpCPartida
		 XPARTIDA	:= cContra
	EndIf

	CCUSTO	:= cCCosto
	ITEM	:= cItem
	CLVAL	:= cClVal
	NIT		:= cNit
	HISTORICO	:= (cAliasCT2)->CT2_HIST
	EMPORI	:= (cAliasCT2)->CT2_EMPORI
	FILORI	:= (cAliasCT2)->CT2_FILORI
	SEQHIST	:= (cAliasCT2)->CT2_SEQHIST
	SEQLAN	:= (cAliasCT2)->CT2_SEQLAN
	NOMOV		:= .F.	// Conta com movimento
	SEGOFI	:= (cAliasCT2)->CT2_SEGOFI	// Conta com movimento

	If cPaisLoc $ "CHI|ARG"
		SEGOFI := (cAliasCT2)->CT2_SEGOFI	// Correlativo para Chile
	EndIf

	If Empty(c2Moeda)	//Se nao for Razao em 2 Moedas
		If cTipo == "1"
			LANCDEB	:= LANCDEB + (cAliasCT2)->CT2_VALOR
		EndIf
		If cTipo == "2"
			LANCCRD	:= LANCCRD + (cAliasCT2)->CT2_VALOR
		EndIf
		If (cAliasCT2)->CT2_DC == "3"
			TIPO	:= cTipo
		Else
			TIPO 	:= (cAliasCT2)->CT2_DC
		EndIf
	Else	//Se for Razao em 2 Moedas
		If (nTipo = 1 .Or. nTipo = 3) .And. (cAliasCT2)->CT2_MOEDLC = cMoeda	//Se Imprime Valor na Moeda ou ambos
			If cTipo == "1"
				LANCDEB := (cAliasCT2)->CT2_VALOR
			Else
				LANCCRD := (cAliasCT2)->CT2_VALOR
			EndIf
		EndIf
		If (nTipo = 2 .Or. nTipo = 3) .And. (cAliasCT2)->CT2_MOEDLC = c2Moeda	//Se Imprime Moeda Corrente ou Ambas
			If cTipo == "1"
				LANCDEB_1	:= (cAliasCT2)->CT2_VALOR
			Else
				LANCCRD_1	:= (cAliasCT2)->CT2_VALOR
			Endif
		EndIf
		If LANCDEB_1 <> 0 .And. LANCDEB <> 0
			TXDEBITO  	:= LANCDEB_1 / LANCDEB
		Endif
		If LANCCRD_1 <> 0 .And. LANCCRD <> 0
			TXCREDITO 	:= LANCCRD_1 / LANCCRD
		EndIf
		If (cAliasCT2)->CT2_DC == "3"
			TIPO	:= cTipo
		Else
			TIPO 	:= (cAliasCT2)->CT2_DC
		EndIf
	EndIf

	If nTipo = 1 .And. (LANCDEB + LANCCRD) = 0
		DbDelete()
	ElseIf nTipo = 2 .And. (LANCDEB_1 + LANCCRD_1) = 0
		DbDelete()
	Endif
	If ! Empty(c2Moeda) .And. LANCDEB + LANCDEB_1 + LANCCRD + LANCCRD_1 = 0
		DbDelete()
	Endif
	MsUnlock()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³ CTBR821GrN ³ Autor ³ Marco A. Gonzalez   ³ Data ³ 27/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Guarda registros en archivo temporal sin movimiento.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³ U_CTBR821GrN(ExpC1,ExpD1,ExpC2)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpC1 = Contenido a ser guardado en el campo clave de      ³±±
±±³           ³         a cuerdo con la razon de impresion.                ³±±
±±³           ³ ExpD1 = Fecha para verificacion de movimiento de cuenta.   ³±±
±±³           ³ ExpC2 = Nombre del campo a escribir temporal.              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR821GrN(cConteudo,dDataL,cCpoTmp)

	dbSelectArea("cArqTmp")
	dbSetOrder(1)

	RecLock("cArqTmp",.T.)
	Replace &(cCpoTmp)	With cConteudo
	If cCpoTmp = "CONTA"
		Replace HISTORICO		With STR0044	//"CUENTA SIN MOVIMIENTO EN EL PERIODO"
	ElseIf cCpoTmp = "CCUSTO"
		Replace HISTORICO		With Upper(AllTrim(CtbSayApro("CTT"))) + " "  + STR0045	//"SIN MOVIMIENTO EN EL PERIODO"
	ElseIf cCpoTmp = "ITEM"
		Replace HISTORICO		With Upper(AllTrim(CtbSayApro("CTD"))) + " "  + STR0045	//"SIN MOVIMIENTO EN EL PERIODO"
	ElseIf cCpoTmp = "NIT"
		Replace HISTORICO		With Upper(AllTrim("NIT")) + " "  + STR0045	//"SIN MOVIMIENTO EN EL PERIODO"
	Endif
	Replace DATAL 			WITH dDataL
	// Grava filial do sistema para uso no relatorio
	Replace FILORI		With cFilAnt
	MsUnlock()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CTBR821Snt³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 05/02/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Imprime cuenta sintetica de cuenta razon                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³ U_CTBR821Snt(ExpC1,ExpC2,ExpC3,ExpC4,ExpC5,ExpC6)            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ Cuenta Sintetica	                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpC1 = Cuenta                                             ³±±
±±³           ³ ExpC2 = Descripcion de Cuenta Sintetica                    ³±±
±±³           ³ ExpC3 = Moneda                                             ³±±
±±³           ³ ExpC4 = Descripcion de Cuenta                              ³±±
±±³           ³ ExpC5 = Codigo reducido                                    ³±±
±±³           ³ ExpC6 = Descripcion de Moneda                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR821Snt(cConta,cDescSint,cMoeda,cDescConta,cCodRes,cMoedaDesc)

	Local aSaveArea		:= GetArea()

	Local nPosCT1	//Guarda a posicao no CT1
	Local cContaPai		:= ""
	Local cContaSint		:= ""

	// seta o default da descrição da moeda para a moeda corrente
	Default cMoedaDesc	:= cMoeda

	dbSelectArea("CT1")
	CT1->(dbSetOrder(1)) //CT1_FILIAL+CT1_CONTA
	If CT1->(dbSeek(xFilial("CT1")+cConta))
		nPosCT1	:= Recno()
		cDescConta	:= &("CT1->CT1_DESC" + cMoedaDesc )

		If Empty( cDescConta )
			cDescConta  := CT1->CT1_DESC01
		Endif

		cCodRes	:= CT1->CT1_RES
		cContaPai	:= CT1->CT1_CTASUP

		If CT1->(dbSeek(xFilial("CT1")+cContaPai))
			cContaSint	:= CT1->CT1_CONTA
			cDescSint	:= &("CT1->CT1_DESC" + cMoedaDesc )

			If Empty(cDescSint)
				cDescSint := CT1->CT1_DESC01
			Endif
		EndIf

		dbGoto(nPosCT1)
	EndIf

	RestArea(aSaveArea)

Return cContaSint

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CTBR821Qry³ Autor ³ Marco A. Gonzalez     ³ Data ³ 27/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Realiza la filtracion de los registros de razon             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_CTBR821Qry(ExpO1,ExpO2,ExpO3,ExpL1,cContaIni,cContaFim,     ³±±
±±³           ³   cCustoIni,cCustoFim, cItemIni,cItemFim,cNitIni,cNitFim,  ³±±
±±³           ³   cMoeda,dDataIni,dDataFim,aSetOfBook,lNoMov,cSaldo,lJunta,³±±
±±³           ³   cTipo)                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Acao do Codeblock                                  ³±±
±±³           ³ ExpC2 = Conta Inicial                                      ³±±
±±³           ³ ExpC3 = Conta Final                                        ³±±
±±³           ³ ExpC4 = C.Custo Inicial                                    ³±±
±±³           ³ ExpC5 = C.Custo Final                                      ³±±
±±³           ³ ExpC6 = Item Inicial                                       ³±±
±±³           ³ ExpC7 = Cl.Valor Inicial                                   ³±±
±±³           ³ ExpC8 = Cl.Valor Final                                     ³±±
±±³           ³ ExpC9 = Moeda                                              ³±±
±±³           ³ ExpD1 = Data Inicial                                       ³±±
±±³           ³ ExpD2 = Data Final                                         ³±±
±±³           ³ ExpA1 = Matriz aSetOfBook                                  ³±±
±±³           ³ ExpL2 = Indica se imprime movimento zerado ou nao.         ³±±
±±³           ³ ExpC10= Tipo de Saldo                                      ³±±
±±³           ³ ExpL3 = Indica se junta CC ou nao.                         ³±±
±±³           ³ ExpC11= Tipo do lancamento                                 ³±±
±±³           ³ c2Moeda = Indica moeda 2 a ser incluida no relatorio       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR821Qry(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
		cItemIni,cItemFim,cNitIni,cNitFim,cMoeda,dDataIni,dDataFim,;
		aSetOfBook,lNoMov,cSaldo,lJunta,cTipo,c2Moeda,cUFilter,lSldAnt,aSelFil)

	Local aSaveArea		:= GetArea()
	Local nMeter			:= 0
	Local cQuery			:= ""
	Local aTamVlr			:= TAMSX3("CT2_VALOR")
	Local lNoMovim		:= .F.
	Local cContaAnt		:= ""
	Local cCampUSU		:= ""
	Local aStrSTRU		:= {}
	Local nStr				:= 0
	Local cQryFil			:= '' // variavel de condicional da query
	Local lImpCPartida	:= GetNewPar( "MV_IMPCPAR" , .T.)	// Se .T., IMPRIME Contra-Partida para TODOS os tipos de lançamento (Débito, Credito e Partida-Dobrada),
																	// se .F., NÃO IMPRIME Contra-Partida para NENHUM   tipo  de lançamento.
	Local cTmpCT2Fil
	Local lDev4		:= oReport:nDevice == 4	//Impresion mediante opcion 4 - Planilla
	Local lAgrega   := .F.
	Local lExDTFim  := CtbExDtFim("CT1")
	Local nImpCodC := MV_PAR11 //Imprime código de Cuenta (1-Normal, 2-Reducido, 3-Impresión)
	Local nImpCC   := MV_PAR25 //Imprime código de Centro Costo (1-Normal, 2-Reducido)
	Local nImpItem := MV_PAR26 //Imprime código de Ítem (1-Normal, 2-Reducido)
	Local nImpCVal := MV_PAR40 //Imprime código de Clase Valor (1-Normal, 2-Reducido)
	Local cFilCT1  := xFilial("CT1")
	Local cFilCTT := xFilial('CTT')
	Local cFilCTD := xFilial('CTD')
	Local cFilCTH := xFilial('CTH')

	Default lSldAnt		:= .F.
	Default aSelFil		:= {}

	// trataviva para o filtro de multifiliais
	cQryFil := " CT2.CT2_FILIAL " + GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil )

	oMeter:SetTotal(CT2->(RecCount()))
	oMeter:Set(0)

	cQuery	:= " SELECT CT1_CONTA CONTA, CT1_DESC01 DESCTA, CT1_NORMAL NORMAL, ISNULL(CT2_CCD,'') CUSTO,ISNULL(CT2_ITEMD,'') ITEM, ISNULL(CT2_EC05DB,'') NIT, ISNULL(CT2_DATA,'') DDATA, ISNULL(CT2_TPSALD,'') TPSALD, "
	cQuery	+= " ISNULL(CT2_DC,'') DC, ISNULL(CT2_LOTE,'') LOTE, ISNULL(CT2_SBLOTE,'') SUBLOTE, ISNULL(CT2_DOC,'') DOC, ISNULL(CT2_LINHA,'') LINHA, ISNULL(CT2_CREDIT,'') XPARTIDA, ISNULL(CT2_HIST,'') HIST, ISNULL(CT2_SEQHIS,'') SEQHIS, ISNULL(CT2_SEQLAN,'') SEQLAN, '1' TIPOLAN, "

	//****************************************************
	//* TRATAMENTO PARA O FILTRO DE USUÁRIO NO RELATORIO *
	//****************************************************
	cCampUSU := ""	// DECLARA VARIAVEL COM OS CAMPOS DO FILTRO DE USUÁRIO
	If !Empty(cUFilter)	// SE O FILTRO DE USUÁRIO NAO ESTIVER VAZIO
		aStrSTRU := CT2->(dbStruct())	// OBTEM A ESTRUTURA DA TABELA USADA NA FILTRAGEM
		nStruLen := Len(aStrSTRU)
		For nStr := 1 to nStruLen	// LE A ESTRUTURA DA TABELA
			cCampUSU += aStrSTRU[nStr][1]+","	// ADICIONANDO OS CAMPOS PARA FILTRAGEM POSTERIOR
		Next
	Endif
	cQuery	+= cCampUSU	// ADICIONA OS CAMPOS NA QUERY

	cQuery	+= " ISNULL(CT2_VALOR,0) VALOR, ISNULL(CT2_EMPORI,'') EMPORI, ISNULL(CT2_FILORI,'') FILORI,  ISNULL(CT2_CLVLDB,'') CLVAL"
	If cPaisLoc $ "CHI|ARG|PER"
		cQuery	+= ", ISNULL(CT2_SEGOFI,'') SEGOFI"
	EndIf

	cQuery += " FROM "+ RetSqlName("CT1") + " CT1 LEFT JOIN " + RetSqlName("CT2") + " CT2 "
	cQuery += " ON " + cQryFil

	cQuery	+= " AND CT2.CT2_DEBITO = CT1.CT1_CONTA"
	cQuery	+= " AND CT2.CT2_DATA >= '"		+ DTOS(dDataIni)	+ "' AND CT2.CT2_DATA 	<= '"		+ DTOS(dDataFim)	+ "'"
	cQuery	+= " AND CT2.CT2_CCD >= '"		+ cCustoIni			+ "' AND CT2.CT2_CCD 	<= '"		+ cCustoFim			+ "'"
	cQuery	+= " AND CT2.CT2_CLVLDB >= '"	+ cClValIni			+ "' AND CT2.CT2_CLVLDB <= '"		+ cClValFim			+ "'"
	cQuery	+= " AND CT2.CT2_ITEMD >= '"	+ cItemIni			+ "' AND CT2.CT2_ITEMD 	<= '"		+ cItemFim			+ "'"
	cQuery	+= " AND CT2.CT2_EC05DB >= '"	+ cNitIni			+ "' AND CT2.CT2_EC05DB <= '"		+ cNitFim			+ "'"
	cQuery	+= " AND CT2.CT2_TPSALD = '"	+ cSaldo			+ "'"
	cQuery	+= " AND CT2.CT2_MOEDLC = '"	+ cMoeda			+ "'"
	cQuery	+= " AND (CT2.CT2_DC = '1' OR CT2.CT2_DC = '3') "
	cQuery	+= " AND CT2_VALOR <> 0 "
	cQuery	+= " AND CT2.D_E_L_E_T_ = ' ' "
	cQuery	+= " WHERE CT1.CT1_FILIAL = '"	+ xFilial("CT1")	+ "' "
	cQuery	+= " AND CT1.CT1_CLASSE = '2' "
	cQuery	+= " AND CT1.CT1_CONTA >= '"	+ cContaIni + "' AND CT1.CT1_CONTA <= '" + cContaFim + "'"
	cQuery	+= " AND CT1.D_E_L_E_T_ = '' "
	cQuery	+= " UNION "
	cQuery	+= " SELECT CT1_CONTA CONTA, CT1_DESC01 DESCTA, CT1_NORMAL NORMAL, ISNULL(CT2_CCC,'') CUSTO, ISNULL(CT2_ITEMC,'') ITEM, ISNULL(CT2_EC05CR,'') NIT, ISNULL(CT2_DATA,'') DDATA, ISNULL(CT2_TPSALD,'') TPSALD, "
	cQuery	+= " ISNULL(CT2_DC,'') DC, ISNULL(CT2_LOTE,'') LOTE, ISNULL(CT2_SBLOTE,'')SUBLOTE, ISNULL(CT2_DOC,'') DOC, ISNULL(CT2_LINHA,'') LINHA, ISNULL(CT2_DEBITO,'') XPARTIDA, ISNULL(CT2_HIST,'') HIST, ISNULL(CT2_SEQHIS,'') SEQHIS, ISNULL(CT2_SEQLAN,'') SEQLAN, '2' TIPOLAN, "

	//****************************************************
	//* TRATAMENTO PARA O FILTRO DE USUÁRIO NO RELATORIO *
	//****************************************************
	cCampUSU  := ""	// DECLARA VARIAVEL COM OS CAMPOS DO FILTRO DE USUÁRIO
	If !Empty(cUFilter)	// SE O FILTRO DE USUÁRIO NAO ESTIVER VAZIO
		aStrSTRU := CT2->(dbStruct())	// OBTEM A ESTRUTURA DA TABELA USADA NA FILTRAGEM
		nStruLen := Len(aStrSTRU)
		For nStr := 1 to nStruLen	// LE A ESTRUTURA DA TABELA
			cCampUSU += aStrSTRU[nStr][1]+","	// ADICIONANDO OS CAMPOS PARA FILTRAGEM POSTERIOR
		Next
	Endif

	cQuery	+= cCampUSU	// ADICIONA OS CAMPOS NA QUERY
	cQuery	+= " ISNULL(CT2_VALOR,0) VALOR, ISNULL(CT2_EMPORI,'') EMPORI, ISNULL(CT2_FILORI,'') FILORI, ISNULL(CT2_CLVLCR,'') CLVAL"

	If cPaisLoc $ "CHI|ARG|PER"
		cQuery	+= ", ISNULL(CT2_SEGOFI,'') SEGOFI"
	EndIf

	cQuery += " FROM "+RetSqlName("CT1")+ ' CT1 LEFT JOIN '+ RetSqlName("CT2") + ' CT2 '
	cQuery += " ON " + cQryFil
	cQuery	+= " AND CT2.CT2_CREDIT =  CT1.CT1_CONTA "
	cQuery	+= " AND CT2.CT2_DATA >= '"		+ DTOS(dDataIni)	+ "' AND CT2.CT2_DATA <= '"		+ DTOS(dDataFim)	+ "'"
	cQuery	+= " AND CT2.CT2_CCC >= '"	 	+ cCustoIni			+ "' AND CT2.CT2_CCC <= '"		+ cCustoFim		+ "'"
	cQuery	+= " AND CT2.CT2_CLVLCR >= '"	+ cClValIni			+ "' AND CT2.CT2_CLVLCR <= '"	+ cClValFim		+ "'"
	cQuery	+= " AND CT2.CT2_ITEMC >= '" 	+ cItemIni			+ "' AND CT2.CT2_ITEMC <= '"	+ cItemFim			+ "'"
	cQuery	+= " AND CT2.CT2_EC05CR >= '"	+ cNitIni			+ "' AND CT2.CT2_EC05CR <= '"	+ cNitFim			+ "'"
	cQuery	+= " AND CT2.CT2_TPSALD = '"	+ cSaldo			+ "'"
	cQuery	+= " AND CT2.CT2_MOEDLC = '"	+ cMoeda			+ "'"
	cQuery	+= " AND (CT2.CT2_DC = '2' OR CT2.CT2_DC = '3') "
	cQuery	+= " AND CT2_VALOR <> 0 "
	cQuery	+= " AND CT2.D_E_L_E_T_ = ' ' "
	cQuery	+= " WHERE CT1.CT1_FILIAL = '"	+ xFilial("CT1")	+ "' "
	cQuery	+= " AND CT1.CT1_CLASSE = '2' "
	cQuery	+= " AND CT1.CT1_CONTA >= '"	+ cContaIni		+ "' AND CT1.CT1_CONTA <= '"	+ cContaFim	+ "'"
	cQuery	+= " AND CT1.D_E_L_E_T_ = ''"

	cQuery := ChangeQuery(cQuery)

	//MemoWrite( 'c:\CTBR821.txt', cQuery )
	If Select("cArqCT2") > 0
		dbSelectArea("cArqCT2")
		cArqCT2->(dbCloseArea())
	Endif

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cArqCT2",.T.,.F.)

	TcSetField("cArqCT2","CT2_VLR"+cMoeda,"N",aTamVlr[1],aTamVlr[2])
	TcSetField("cArqCT2","DDATA","D",8,0)

	If !Empty(cUFilter)	// SE O FILTRO DE USUÁRIO NAO ESTIVER VAZIO
		For nStr := 1 to nStruLen	// LE A ESTRUTURA DA TABELA
			If aStrSTRU[nStr][2] <> "C" .and. cArqCT2->(FieldPos(aStrSTRU[nStr][1])) > 0
				TcSetField("cArqCT2",aStrSTRU[nStr][1],aStrSTRU[nStr][2],aStrSTRU[nStr][3],aStrSTRU[nStr][4])
			EndIf
		Next
	Endif

	dbSelectarea("cArqCT2")

	dbSelectarea("cArqCT2")
	If Empty(cUFilter)
		cUFilter := ".T."
	Endif

	lAgrega := Empty(cUFilter)
	If !lAgrega
	    lAgrega := &("cArqCT2->("+cUFilter+")")
	EndIf
	While !Eof()
		If Empty(cArqCT2->DDATA) //Se nao existe movimento
			cContaAnt	:= cArqCT2->CONTA
			cArqCT2->(dbSkip())
			If Empty(cArqCT2->DDATA) .And. cContaAnt == cArqCT2->CONTA
				lNoMovim	:= .T.
			EndIf
		Endif

		If lAgrega
			If lNoMovim
				If lNoMov
					If lExDTFim
						dbSelectArea("CT1")
						CT1->(dbSetOrder(1)) //CT1_FILIAL+CT1_CONTA
						If MsSeek(xFilial()+cArqCT2->CONTA)
							If CtbVlDtFim("CT1",dDataIni)
								U_CTBR821GrN(cArqCT2->CONTA,dDataIni,"CONTA")	//Esta sendo passado "CONTA" fixo, porque essa funcao esta sendo
							EndIf	//chamada somente para o CTBR821
						EndIf
					Else
						U_CTBR821GrN(cArqCT2->CONTA,dDataIni,"CONTA")	//Esta sendo passado "CONTA" fixo, porque essa funcao esta sendo
					EndIf	//chamada somente para o CTBR821
				ElseIf lSldAnt
					If SaldoCT7Fil(cArqCT2->CONTA,dDataIni,cMoeda,cSaldo,'CTBR821',lPosAntLP,dDataLP)[6] <> 0 .and. cArqTMP->CONTA <> cArqCT2->CONTA
						U_CTBR821GrN(cArqCT2->CONTA,dDataIni,"CONTA")
					Endif
				EndIf
			Else
				RecLock("cArqTmp",.T.)
				Replace DATAL		With cArqCT2->DDATA
				Replace TIPO		With cArqCT2->DC
				Replace LOTE		With cArqCT2->LOTE
				Replace SUBLOTE	With cArqCT2->SUBLOTE
				Replace DOC		With cArqCT2->DOC
				Replace LINHA		With cArqCT2->LINHA
				Replace CONTA		With cArqCT2->CONTA
				DESCTA := cArqCT2->DESCTA
				NORMAL := cArqCT2->NORMAL
				If nImpCC == 1 //Normal
					cCentroC := cArqCT2->CUSTO
				Else //Reducido
					cCentroC := CTBR821DES(cFilCTT, cArqCT2->CUSTO, "CTT", 1)
				EndIf
				Replace CCUSTO	With cCentroC
				If nImpItem == 1 //Normal
					cCodItem := cArqCT2->ITEM
				Else //Reducido
					cCodItem := CTBR821DES(cFilCTD, cArqCT2->ITEM, "CTD", 1)
				EndIf
				Replace ITEM		With cCodItem
				If nImpCVal == 1 //Normal
					cClaseVal := cArqCT2->CLVAL
				Else //Reducido
					cClaseVal := CTBR821DES(cFilCTH, cArqCT2->CLVAL, "CTH", 1)
				EndIf
				Replace CLVAL	With cClaseVal
				Replace NIT		With cArqCT2->NIT

				If lImpCPartida
					If nImpCodC == 1 //Normal
						cCuenta := cArqCT2->XPARTIDA
					ElseIf nImpCodC == 3 //Impresión
						cCuenta := CTBR821DES(cFilCT1, cArqCT2->XPARTIDA, "CT1", 1)
					Else //Redicido
						cCuenta := CTBR821DES(cFilCT1, cArqCT2->XPARTIDA, "CT1", 2)
					EndIf
					Replace XPARTIDA	With cCuenta
				EndIf

				Replace HISTORICO	With iif(lDev4,cArqCT2->HIST,Substr(cArqCT2->HIST,1,40) )
				Replace EMPORI	With cArqCT2->EMPORI
				Replace FILORI	With cArqCT2->FILORI
				Replace SEQHIST	With cArqCT2->SEQHIS
				Replace SEQLAN	With cArqCT2->SEQLAN

				If cPaisLoc $ "CHI|ARG|PER"
					Replace SEGOFI With cArqCT2->SEGOFI// Correlativo para Chile
				EndIf

				If cArqCT2->TIPOLAN = '1'
					Replace LANCDEB	With LANCDEB + cArqCT2->VALOR
				EndIf
				If cArqCT2->TIPOLAN = '2'
					Replace LANCCRD	With LANCCRD + cArqCT2->VALOR
				EndIf
				MsUnlock()
			Endif
		EndIf
		lNoMovim	:= .F.
		dbSelectArea("cArqCT2")
		cArqCT2->(dbSkip())
		nMeter++
		oMeter:Set(nMeter)
	Enddo

	CtbTmpErase(cTmpCT2Fil)

	RestArea(aSaveArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao     ³CTBR821Ger³ Autor ³ Marco A. Gonzalez   ³ Data ³ 27/04/16   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao  ³ Gera o arquivo magnético do Diario contabil                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³ cDir - Diretorio de criacao do arquivo.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³ Nulo                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso        ³ Fiscal Peru - Diario contabil - Arquivo Magnetico          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTBR821Ger(cDir)

	Local nHdl    := 0
	Local cLin    := ""
	Local cSep    := "|"
	Local n		:= 0
	Local cArq    := ""
	Local nCont   := 0

	FOR nCont := LEN(ALLTRIM(cDir)) TO 1 STEP -1
		IF SUBSTR(cDir,nCont,1) == '\'
			cDir:=Substr(cDir,1,nCont)
			EXIT
		ENDIF
	NEXT

	//Nome do arquivo TXT conforme layout (7_2Nombres) - SUNAT
	cArq += "LE"										// Fixo  'LE'
	cArq += AllTrim(SM0->M0_CGC)					// Ruc
	cArq += AllTrim(Str(Year(MV_PAR03)))			// Ano
	cArq += AllTrim(Strzero(Month(MV_PAR03),2))	// Mes
	cArq += "00"		// Fixo '00'
	cArq += "060100"	// Fixo '060100'
	cArq += "00"		// Fixo '00'
	cArq += "1"
	cArq += "1"
	cArq += "1"
	cArq += "1"
	cArq += ".TXT"	// Extensao

	nHdl := fCreate(cDir+cArq)
	If nHdl <= 0
		ApMsgStop(STR0046)	//"Ocurrió un error al crear el archivo"
	Else

		dbSelectArea("cArqTmp")
		cArqTmp->(dbGoTop())
		Do While cArqTmp->(!EOF())
			if cArqTmp->LANCDEB > 0 .or. cArqTmp->LANCCRD > 0
				//01 - Periodo
				cLin :=""
				cLin += SubStr(DTOS(cArqTmp->DATAL),1,6)+"00"
				cLin += cSep

				//02 - Num correlativo
				cLin += AllTrim(cArqTmp->SEGOFI)+cArqTmp->LINHA+IIF(cArqTmp->LANCDEB>0,'D','H')
				cLin += cSep

				//03 - Codigo da conta contabil
				cLin += cArqTmp->CONTA
				cLin += cSep

				//04  - Data da contabilizacao
				cLin += SubStr(DTOC(cArqTmp->DATAL),1,6)+SubStr(DTOS(cArqTmp->DATAL),1,4)
				cLin += cSep

				//05 - Historico
				cLin += cArqTmp->HISTORICO
				cLin += cSep

				//06  - Conta Debito
				cLin += cArqTmp->(Alltrim(Str(cArqTmp->LANCDEB)))
				cLin += cSep

				//07 - Conta Credito
				cLin += cArqTmp->(Alltrim(Str(cArqTmp->LANCCRD)))
				cLin += cSep

				//08 - Estado da Operacao
				cLin += '1'
				cLin += cSep

				cLin += chr(13)+chr(10)
				fWrite(nHdl,cLin)
			endif
			cArqTmp->(dbSkip())
			n:=n+1
		EndDo
		fClose(nHdl)

	EndIf

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R051PROC    ºAutor  ³TOTVS               º Data ³  08/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                              º±±
±±º          ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R821PROC(aEntdIni,aEntdFim,dDataIni,dDataFim,cCodCubo,cMoeda,cTpSald,aSelFil, oObjCubo)
Local aDataIni	:= {}
Local aDataFim	:= {}
Local cArqTemp	:= ""
Local cQry		:= ""
Local cQryField := ""
Local nX		:= 0
Local nY		:= 0
Local nEntidade	:= Len(aEntdIni)
Local aTam		:= TamSx3('CT2_VALOR')
Local lVlrZerado:=  IIF(MV_PAR30==1,.T.,.F.)

Default aSelFil := {cFilAnt}

// Variavel data inicial
AADD(aDataIni,Ctod("01/01/80"))		// Data Anterior
AADD(aDataIni,dDataIni)				// Data Atual

AADD(aDataFim,dDataIni-1)			// Data Anterior
AADD(aDataFim,dDataFim)				// Data Atual

/* Cria Classe Ctb_Exec_Cube Objeto --> oObjCubo */
oObjCubo := Ctb_Exec_Cube():New(cCodCubo,cMoeda,cTpSald,nEntidade,Len(aDataFim),,lPosAntLP,dDataLP,"QL7")
oObjCubo:lZerado := lVlrZerado

/* Cria arquivo temporario no TOP retornando nome do arquivo */
cArqTemp :=  oObjCubo:CtbCriaTemp()

For nY:=1 To nEntidade
	oObjCubo:Set_Level_Cube(nY)

	oObjCubo:oStructCube:Ctb_Set_IniParam(nY, aEntdIni[nY])          //aqui colocado parametro inicial
	oObjCubo:oStructCube:Ctb_Set_FimParam(nY, aEntdFim[nY])			// parametro final
	If nY >= 5
		//não filtrar as entidades 5 a 9 em branco
		oObjCubo:oStructCube:aVazio[nY] := .F.
	EndIf
	/* Atualiza a propriedade aQueryDim */
	oObjCubo:CtbCriaQueryDim()
Next nY

oObjCubo:Set_Level_Cube(nEntidade)

oObjCubo:Set_aSelFil(aSelFil)

/* Monta query com a propriedade aQueryDim */
oObjCubo:CtbCriaQry(.T./*lMovimento*/, aDataIni/*aDtIni*/, aDataFim/*aDtFim*/, cArqTemp, .T./*lAllNiveis*/, .F./* lFechamento*/)

/* Popular tabela temporaria */
oObjCubo:CtbPopulaTemp(cArqTemp)

cQryField := ""
FOR nX := 1 TO 5
	cQryField += "CVX_NIV0"+ AllTrim(Str(nX)) + ", "
Next

cQry += "Select CVX_FILIAL, "
cQry += "       CVX_CONFIG, "
cQry += "       CVX_MOEDA , "
cQry += "       CVX_TPSALD, "
cQry += cQryField
If lIsRedStor
	cQry += " CT1.CT1_NORMAL AS NORMAL, "
Endif
cQry += "       CVX_PROC ,  "
cQry += "       CVX_NIVEL,  "
cQry += "       CVX_IDPAI,  "
cQry += "       SUM( CVX_SLCR01 ) CVX_SLCR01, "
cQry += "       SUM( CVX_SLDB01 ) CVX_SLDB01, "
cQry += "       SUM( CVX_SALD01 ) CVX_SALD01, "
cQry += "       SUM( CVX_SLCR02 ) CVX_SLCR02, "
cQry += "       SUM( CVX_SLDB02 ) CVX_SLDB02, "
cQry += "       SUM( CVX_SALD02 ) CVX_SALD02, "
cQry += "       SUM( CVX_SALD02 + CVX_SALD01 ) CVX_SLDATU "
cQry += " FROM "+cArqTemp
If lIsRedStor
	cQry += ", " + RetSqlName("CT1") + " CT1 "
	cQry += " WHERE CT1.CT1_FILIAL = '" + xFILIAL("CT1") + "' AND CT1.CT1_CONTA = " + alltrim(cArqTemp) + ".CVX_NIV01 AND CT1.D_E_L_E_T_ = ' ' "
Endif
cQry += " GROUP BY CVX_FILIAL, "
cQry += "          CVX_CONFIG, "
cQry += "          CVX_MOEDA , "
cQry += "          CVX_TPSALD, "
cQry += cQryField
If lIsRedStor
	cQry += " CT1.CT1_NORMAL, "
Endif
cQry += "          CVX_PROC , "
cQry += "          CVX_NIVEL, "
cQry += "          CVX_IDPAI  "

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTmp2",.T.,.F.)

TCSetField("cArqTmp2","CVX_SLCR01", "N",aTam[1],aTam[2])
TCSetField("cArqTmp2","CVX_SLDB01", "N",aTam[1],aTam[2])
TCSetField("cArqTmp2","CVX_SALD01", "N",aTam[1],aTam[2])

TCSetField("cArqTmp2","CVX_SLCR02", "N",aTam[1],aTam[2])
TCSetField("cArqTmp2","CVX_SLDB02", "N",aTam[1],aTam[2])
TCSetField("cArqTmp2","CVX_SALD02", "N",aTam[1],aTam[2])
TCSetField("cArqTmp2","CVX_SLDATU", "N",aTam[1],aTam[2])

DbSelectArea("cArqTmp2")
DbGoTop()

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  CTBR821DES    ºAutor  Luis Enríquez       º Data ³  11/01/21   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Obtiene descripción de campos de acuerdo a código de tabla.º±±
±±º          ³                                                              º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³ cFilTab - Filial de la tabla.                              ³±±
±±³            ³ cCod - Código del registro a buscar.                       ³±±
±±³            ³ cTabla - C+odigo de la tabla para busqueda.                ³±±
±±³            ³ nOpc - Opción para validación de retorno dentro de una mis-³±±
±±³            ³ ma tabla.                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³ cDesc - Descripción de registro de tabla.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso        ³ CTBR821                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTBR821DES(cFilTab, cCod, cTabla, nOpc)
	Local aArea	 := GetArea()
	Local cDesc  := "Descripción Inválida"

	Default nOpc := 1

	If cTabla == "CTT"
		dbSelectArea("CTT")
		CTT->(dbSetOrder(1)) //CTT_FILIAL + CTT_CUSTO
		If CTT->(MsSeek(cFilTab + cCod))
			cDesc := CTT->CTT_RES
		EndIf
	ElseIf cTabla == "CT1"
		dbSelectArea("CT1")
		CT1->(dbSetOrder(1)) //CT1_FILIAL + CT1_CONTA
		If CT1->(MsSeek(cFilTab + cCod))
			If nOpc == 1
				cDesc := CT1->CT1_CODIMP
			Else
				cDesc := CT1->CT1_RES
			EndIf
		EndIf
	ElseIf cTabla == "CTD"
		dbSelectArea("CTD")
		CTD->(dbSetOrder(1)) //CTD_FILIAL + CTD_ITEM
		If CTD->(MsSeek(cFilTab + cCod))
			cDesc := CTD->CTD_RES
		EndIf
	ElseIf cTabla == "CTH"
		dbSelectArea("CTH")
		CTH->(dbSetOrder(1)) //CTH_FILIAL + CTH_CLVL
		If CTH->(dbSeek(cFilTab + cCod))
			cDesc := CTH->CTH_RES
		EndIf
	EndIf
	RestArea(aArea)
Return cDesc
