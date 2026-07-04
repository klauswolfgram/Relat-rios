/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr403.Ch"
#Include "PROTHEUS.Ch"

Static lCtbIsCube := FindFunction("CtbIsCube")
Static __lBlind  := IsBlind()
Static lAutomato := IsBlind()
STATIC __queryEvent	:= NIL
Static _oJsonHist := Nil
Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr403	³ Autor ³ TOTVS             	³ Data ³ 09/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Razao por entidade                   			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr403()                              			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR403( cNomeConf )
	PRIVATE titulo		:= ""
	Private nomeprog	:= "CTBR403"
	Private oReport		:= Nil
	Private cPlano		:= "01" // Usado pela consulta padrao CV01
	Private cCodigo		:= ""   // Usado pela consulta padrao CV01

	U_CTBR403R4( cNomeConf )

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR048R4 ³ Autor³ Daniel Sakavicius		³ Data ³ 01/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico Sintetico Modelo 1 - R4                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR048R4												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR403R4( cNomeConf )
	//Cria matriz para armazenar os parametros do filtro por entidades
	Local  nTam_CPOCHV 	:= 0
	Local  cQuery 		:= ''
	Local  cAlias403 	:= getNextAlias()

	Private nQtdEntid	:= CtbQtdEntd() //sao 4 entidades padroes -> conta /centro custo /item contabil/ classe de valor
	Private aEntidades 	:= {}	//Array( nQtdEntid * 2)
	Private aEstrCT0	:= {}
	Private aParCubo	:= {}
	Private cArqObjeto	:= ""
	Private nTamCelulas	:= 0
	Private aSelFil		:= {}

	Default cNomeConf := 'CTBR403'

	If !lCtbIsCube .And. !CtbIsCube()
		Return()
	EndIf

	cQuery := " SELECT CT0_ID, CT0_CPOCHV, CT0_DSCRES, CT0_F3ENTI "
	cQuery += " FROM "+RetSqlName("CT0")
	cQuery += " WHERE CT0_FILIAL = '"+xFilial('CT0')+"' "
	cQuery += " AND CT0_CPOCHV != ' ' "
	cQuery += " AND D_E_L_E_T_ = ' ' "

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery), cAlias403 ,.T.,.F.)

	While (cAlias403)->(!Eof())
		nTam_CPOCHV := TamSx3( (cAlias403)->CT0_CPOCHV)[1]
		AADD( aEstrCT0,{ (cAlias403)->CT0_ID , nTam_CPOCHV , (cAlias403)->CT0_DSCRES , (cAlias403)->CT0_F3ENTI } )
		AADD( aEntidades , Space( nTam_CPOCHV ) )		// Parametro entidade inicio
		AADD( aEntidades , Space( nTam_CPOCHV ) )		// Parametro entidade fim

		(cAlias403)->(DbSkip())
	EndDo

	(cAlias403)->(dbCloseArea())

	DbSelectArea('CT0')
	DbSetOrder(1)
	CtbParCubo(.T.,cNomeConf)

	oReport := ReportDef( cNomeConf )

	If Valtype( oReport ) == 'O'
		If ! Empty( oReport:uParam )
			//Pergunte( oReport:uParam, .F. )
		EndIf

		oReport:PrintDialog()
	Endif

	oReport := Nil

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Daniel Sakavicius		³ Data ³ 28/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo relatorio.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef( cNomeConf )
	Local CREPORT		:= "CTBR403"
	Local CTITULO		:= STR0006				   			// "Emissao do Relat. Conf. Dig. "
	Local CDESC			:= OemToAnsi(STR0001)+OemToAnsi(STR0002)+OemToAnsi(STR0003)			// "Este programa ira imprimir o Relatorio para Conferencia"
	Local aTamConta		:= TAMSX3("CT1_CONTA")

	Local aTamVal		:= TAMSX3("CT2_VALOR")
	Local cMascara		:= ""
	Local cSeparador	:= ""
	Local nTamConta		:= TAMSX3("CT1_CONTA")[1]
	Local aSetOfBook
	Local cPerg	   		:= "CTR403"
	Local nTamLote		:= Len(CriaVar("CT2_LOTE")+CriaVar("CT2_SBLOTE")+CriaVar("CT2_DOC")+CriaVar("CT2_LINHA"))
	Local nQtdeEntid	:= Len(aEstrCT0)
	Local nEntidades	:= 0
	Local lEntidade1
	Local lEntidade2
	Local lEntidade3
	Local lEntidade4
	Local lEntidade5
	Local lEntidade6
	Local lEntidade7
	Local lEntidade8
	Local lEntidade9

	aPergs              := {}

	If !Pergunte(CPERG,.T.)
		Return
	EndIf
	nEntidades	:= Val(Mv_par07)

	If nEntidades > nQtdeEntid
		Help( " " , 1 , "nQtdeEntid" ,, STR0057 + " :" + Mv_par07 ,3,0)  //"Entidade não parametrizado"
		Return
	Endif

	If Mv_Par05 < 11 //Minimo
		ShowHelpDlg("MINQTDELIN", {STR0058,STR0059},5,{STR0060,STR0061},5)     //"Valor informado inválido do"##"'Num. linhas p/ o razão'"##"Favor preencher uma quantidade"##"mínima de 11 linhas"
		Return
	EndIf

	If Mv_Par08 == 1
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			ShowHelpDlg("MINSELFIL", {STR0062},5,{STR0063},5)   //"Seleção de filial inválido."##"Favor selecionar no mínimo de uma filial."
			Return
		EndIf
	EndIf

	If Empty(mv_par07) // validação para Parâmetro mv_par07 se vier vazio para barrar a tela de config param
		Help(NIL, NIL, "ImpriEntVazia", NIL, STR0075, 1, 0, NIL, NIL, NIL, NIL, NIL, {STR0076})
		Return
	Endif

	lEntidade1	:= nEntidades >=1
	lEntidade2	:= nEntidades >=2
	lEntidade3	:= nEntidades >=3
	lEntidade4	:= nEntidades >=4
	lEntidade5	:= nEntidades >=5
	lEntidade6	:= nEntidades >=6
	lEntidade7	:= nEntidades >=7
	lEntidade8	:= nEntidades >=8
	lEntidade9	:= nEntidades ==9

	aParCubo := CtbCfCubo(Mv_par07,cNomeConf)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
	//³ Gerencial -> montagem especifica para impressao)	    	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSetOfBook := CTBSetOf( "" )
	cMascara := RetMasCtb( aSetOfBook[2], @cSeparador )

	If ! Empty( cMascara )
		nTamConta := aTamConta[1] + ( Len( Alltrim( cMascara ) ) / 2 )
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
	oReport	:= TReport():New( cReport,Capital(CTITULO),CPERG, { |oReport| /*Pergunte(cPerg , .F. ),*/ If(! ReportPrint( oReport ), oReport:CancelPrint(), .T. ) }, CDESC )
	oReport:SetLandScape(.T.)
	oReport:DisableOrientation()
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
	oSection1  := TRSection():New( oReport, STR0027, {"cArqTmp"},, .F., .F. ) //"Plano de contas"

	// Entidades
	If lEntidade1
		TRCell():New( oSection1, "NIV01"	,,aEstrCT0[1][3]/*Titulo*/	,/*Picture*/, aEstrCT0[1][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV01}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV01"):GetSize()
	EndIf
	If lEntidade2
		TRCell():New( oSection1, "NIV02"	,,aEstrCT0[2][3]/*Titulo*/	,/*Picture*/, aEstrCT0[2][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV02}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV02"):GetSize()
	EndIf
	If lEntidade3
		TRCell():New( oSection1, "NIV03"	,,aEstrCT0[3][3]/*Titulo*/	,/*Picture*/, aEstrCT0[3][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV03}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV03"):GetSize()
	EndIf
	If lEntidade4
		TRCell():New( oSection1, "NIV04"	,,aEstrCT0[4][3]/*Titulo*/	,/*Picture*/, aEstrCT0[4][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV04}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV04"):GetSize()
	EndIf
	If lEntidade5
		TRCell():New( oSection1, "NIV05"	,,aEstrCT0[5][3]/*Titulo*/	,/*Picture*/, aEstrCT0[5][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV05}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV05"):GetSize()
	EndIf
	If lEntidade6
		TRCell():New( oSection1, "NIV06"	,,aEstrCT0[6][3]/*Titulo*/	,/*Picture*/, aEstrCT0[6][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV06}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV06"):GetSize()
	EndIf
	If lEntidade7
		TRCell():New( oSection1, "NIV07"	,,aEstrCT0[7][3]/*Titulo*/	,/*Picture*/, aEstrCT0[7][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV07}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV07"):GetSize()
	EndIf
	If lEntidade8
		TRCell():New( oSection1, "NIV08"	,,aEstrCT0[8][3]/*Titulo*/	,/*Picture*/, aEstrCT0[8][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV08}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV08"):GetSize()
	EndIf
	If lEntidade9
		TRCell():New( oSection1, "NIV09"	,,aEstrCT0[9][3]/*Titulo*/	,/*Picture*/, aEstrCT0[9][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->NIV09}/*CodeBlock*/  )
		nTamCelulas += oSection1:Cell("NIV09"):GetSize()
	EndIf

	TRCell():New( oSection1,"CT2_DATA" 	,,STR0069/*Titulo*/			,/*Picture*/, 10/*Tamanho*/, /*lPixel*/, {||cArqTmp->CT2_DATA}/*CodeBlock*/)//"Data"
	TRCell():New( oSection1,"DOCUMENTO"	,,STR0070		,/*Picture*/,If(nTamLote < 20, 20,nTamLote),/*lPixel*/,{|| cArqTmp->CT2_LOTE+cArqTmp->CT2_SBLOTE+cArqTmp->CT2_DOC+cArqTmp->CT2_LINHA },/*"LEFT"*/,,/*"LEFT"*/,,,.F.)//"LOTE/SUB/DOC/LINHA"
	TRCell():New( oSection1,"VLRDEB"  	,,STR0071/*Titulo*/		,/*Picture*/, aTamVal[1] + 2/*Tamanho*/, /*lPixel*/, /*CodeBlock*/,"RIGHT",,"RIGHT")//"Debito"
	TRCell():New( oSection1,"VLRCRED" 	,,STR0072/*Titulo*/		,/*Picture*/, aTamVal[1] + 2/*Tamanho*/, /*lPixel*/, /*CodeBlock*/,"RIGHT",,"RIGHT") //"Credito"
	TRCell():New( oSection1,"VLRSLDATU"	,,STR0073/*Titulo*/	,/*Picture*/, aTamVal[1] + 2/*Tamanho*/, /*lPixel*/, /*CodeBlock*/,"RIGHT",,"RIGHT")//"Saldo Atual"

	//TRPosition():New( oSection1,/*"CT1"*/, 1, {|| DbGoTop() })

	oSection1:SetTotalInLine(.F.)
	oSection1:SetTotalText('') //STR0011) //"T O T A I S  D O  P E R I O D O: "
	oSection1:SetHeaderPage(.T.)
	//********************************
	// Imprime linha saldo anterior  *
	//********************************

	//oSection1_1 - Totalizadores Conta

	oSection1_1 := TRSection():New(oReport,STR0050,/*{"cArqTmp","CT2"}*/,/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)

	// Tamanho da coluna descrição da seção Section1_1
	//nTamDesc := nTamData + nTamLote + nTamHist

	TRCell():New(oSection1_1,"DESCRSALDOANT","cArqTmp","",/*Picture*/,nTamCelulas,/*lPixel*/,{|| })
	TRCell():New(oSection1_1,"SALDOANT"	,"cArqTmp","",/*Picture*/,aTamVal[1] + 20,/*lPixel*/,{|| },"RIGHT",,"RIGHT")

	oSection1_1:SetHeaderSection(.F.)
	oSection1_1:SetReadOnly()


Return( oReport )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Daniel Sakavicius	³ Data ³ 28/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±³          ³Nesta funcao deve ser criada a query das secoes se SQL ou   ³±±
±±³          ³definido o relacionamento e filtros das tabelas em CodeBase.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportPrint(oReport)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
	Local oSection1 	:= oReport:Section(1)
	Local oSection1_1	:= oReport:Section(2)
	Local aSetOfBook
	Local dDataFim 		:= MV_PAR02
	Local lFirstPage	:= .T.
	Local lJaPulou		:= .F.
	Local lRet			:= .T.
	Local lPrintZero	:= .T. //IIF(MV_PAR07==1,.T.,.F.)
	Local lPula			:= .F. //IIF(MV_PAR09==1,.T.,.F.)
	Local lNormal		:= .T.
	Local lVlrZerado	:= .F. //IIF(MV_PAR03==1,.T.,.F.)
	Local lQbGrupo		:= .T.
	Local lQbConta		:= .T.
	Local l132			:= .T.
	Local nDecimais
	Local nDivide		:= 1
	Local nTotDeb		:= 0
	Local nTotCrd		:= 0
	Local nTotMov		:= 0
	Local nGrpDeb		:= 0
	Local nGrpCrd		:= 0
	Local cSegAte   	:= ""
	Local nDigitAte		:= 0
	Local lImpSint		:= .T.
	Local n
	Local oMeter
	Local oText
	Local oDlg
	Local oBreak
	Local lImpPaisgm	:= .F.
	Local nMaxLin   	:=  MV_PAR05
	Local nLinReport	:= 8
	Local cMoedaDsc		:=  MV_PAR06
	Local aCtbMoeda		:= {}
	Local aCtbMoedadsc	:= {}
	Local CCOLBAR		:= "|"
	Local cTipoAnt		:= ""
	Local cGrupoAnt		:= ""
	Local cArqTmp		:= ""
	Local Tamanho		:= "M"
	Local cSeparador	:= ""
	Local aTamVal		:= TAMSX3("CT2_VALOR")
	Local oTotDeb
	Local oTotCrd
	Local oTotGerDeb
	Local oTotGerCrd
	Local cPicture
	Local cContaSint
	Local cBreak		:= "2"
	Local cGrupo		:= ""
	Local nTotGerDeb	:= 0
	Local nTotGerCrd	:= 0
	Local nTotGerMov	:= 0
	Local nCont			:= 0
	Local cFilUser		:= ""
	Local cRngFil		:= ""
	Local nMasc			:= 0
	Local cMasc			:= ""
	Local cNormal		:= ""
	Local cCpoNiv		:= ""
	Local aEntidIni		:= {}
	Local aEntidFim		:= {}
	Local nX			:= 0
	Local nResult		:= 0
	Local aSaldoAnt		:= {} //{0,0,0,0,0,1200}
	Local bBloco 		:= Nil
	Local cEntiAtual	:= ""
	Local aNiveis
	Local aEntParIni	:= {}
	Local aEntParFim	:= {}
	Local cTmpCT2Fil
	Local cTmpCVXFil   := ""
	Local lRetProc := .F.
	Local cExec := ""
	Local nRet  := 0
	Local nSaldAnt := 0
	Local aResult  := {}
	Local cTpValor := GetMV("MV_TPVALOR")
	Local cKey		:= ""
	Local lColDbCr 	:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
	Local lJsonOk	:= .F.

	Private cCpoQuebra	:= ""


	_oJsonHist := JsonObject():New()
	lJsonOk := R403SldAnt( aSelFil,  @cTmpCVXFil )
	lRetProc	:= .t.


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
	//³ Gerencial -> montagem especifica para impressao)	    	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSetOfBook := CTBSetOf( "" )

	If lRet
		aCtbMoeda := CtbMoeda(  MV_PAR03 , nDivide )

		If Empty(aCtbMoeda[1])
			Help(" ",1,"NOMOEDA")
			lRet := .F.
			Return lRet
		Endif

		// validação da descrição da moeda
		if lRet .And. ! Empty(  MV_PAR06 ) .and.  MV_PAR06 <> nil
			aCtbMoedadsc := CtbMoeda(  MV_PAR06 , nDivide )

			If Empty( aCtbMoedadsc[1] )
				Help( " " , 1 , "NOMOEDA")
				lRet := .F.
				Return lRet
			Endif
		Endif
	Endif

	aCtbMoeda  	:= CtbMoeda( MV_PAR03,nDivide)

	cDescMoeda 	:= Alltrim( aCtbMoeda[2] )
	nDecimais 	:= DecimalCTB( aSetOfBook , MV_PAR03 )

	If Empty(aSetOfBook[2])
		cMascara := GetMv("MV_MASCARA")
	Else
		cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
	EndIf
	cPicture 		:= aSetOfBook[4]

	lPrintZero	:= .T. //Iif( MV_PAR07==1,.T.,.F.)

	Titulo:=	OemToAnsi("RAZÃO ")
	Titulo += 	DTOC(MV_PAR01) + OemToAnsi(STR0007) + Dtoc(MV_PAR02) + ;
		OemToAnsi(STR0008) + cDescMoeda + CtbTitSaldo(MV_PAR04)

	oReport:SetCustomText( {|| nCtCGCCabTR(dDataFim, MV_PAR01,titulo,oReport)})

	oSection1:OnPrintLine( {|| CTR403Maxl(@nMaxLin,@nLinReport)} )
	oSection1_1:OnPrintLine( {|| CTR403Maxl(@nMaxLin,@nLinReport)} )

	oReport:OnPageBreak( {|| CTR403Maxl(@nMaxLin,@nLinReport)} )

	cFilUser := oSection1:GetAdvplExpr("CT2")
	If Empty(cFilUser)
		cFilUser := ".T."
	EndIf

	For nX:=1 To Len(aParCubo)
		AADD( aEntidIni,If(MsAscii(aParCubo[nX][1])== 13,"",aParCubo[nX][1]))
		AADD( aEntidFim,If(MsAscii(aParCubo[nX][2])== 13,"",aParCubo[nX][2]))
	Next nX

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao			  		     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
		U_R403PROC(aEntidIni,aEntidFim,Mv_Par01,Mv_Par02,MV_PAR10,MV_PAR03,MV_PAR04,aSelFil,@cTmpCT2Fil)},;
		OemToAnsi(OemToAnsi(STR0015)),;    //"Criando Arquivo Tempor rio..."
		OemToAnsi(STR0064))   //"Ficha Razão"

	nCount := cArqTmp->(RecCount())

	oReport:SetMeter(nCont)

	lRet := !(nCount == 0 .And. !Empty(aSetOfBook[5]))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao do Saldo Anterior do Centro de Custo³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1_1:Cell("DESCRSALDOANT"):SetBlock( {|| STR0074 } ) //"SALDO ANTERIOR: "
	//oSection1_1:Cell("SALDOANT"):SetBlock( {|| ValorCTB(aSaldoAnt[6],,,aTamVal[1],nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )

	oSection1_1:Cell("DESCRSALDOANT"):HideHeader()
	oSection1_1:Cell("SALDOANT"):HideHeader()

	//******************************
	// Total Geral do relatorio    *
	//******************************
	oBrkConta 	:= TRBreak():New( oSection1, { || cEntiAtual == Eval(&bBloco) }, OemToAnsi(STR0067), )   //" T O T A I S "

	oTotDeb 	:= TRFunction():New( oSection1:Cell("VLRDEB")	, ,"ONPRINT", oBrkConta,/*Titulo*/,cPicture,;
		{ || ValorCTB(nTotDeb  ,,,aTamVal[1] + 2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection1)


	oTotCred	:= TRFunction():New( oSection1:Cell("VLRCRED")	, ,"ONPRINT", oBrkConta,/*Titulo*/,cPicture,;
		{ || ValorCTB(nTotCrd  ,,,aTamVal[1] + 2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection1)

	oBrkEnd 	:= TRBreak():New( oReport, { || /*cArqTmp->(Eof())*/	}, OemToAnsi(STR0068), )  //"T O T A L  G E R A L  ==> "
	oTotGerDeb 	:= TRFunction():New( oSection1:Cell("VLRDEB")	, ,"ONPRINT", oBrkEnd,/*Titulo*/,cPicture,;
		{ || ValorCTB(nTotGerDeb  ,,,aTamVal[1] + 2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection1)
	oTotGerCred	:= TRFunction():New( oSection1:Cell("VLRCRED")	, ,"ONPRINT", oBrkEnd,/*Titulo*/,cPicture,;
		{ || ValorCTB(nTotGerCrd  ,,,aTamVal[1] + 2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection1)

	If lRet

		If cArqTmp->(EoF())
			Aviso(STR0065,STR0066,{"Ok"})  //"Atencao"###"Nao existem dados para os parâmetros especificados."
			oReport:CancelPrint()
			// Se o arquivo temporario de trabalho esta aberto
			If ( Select ( "cArqTmp" ) > 0 )
				cArqTmp->(dbCloseArea())
			EndIf
			Return
		Else
			cArqTmp->(dbGoTop())
			While cArqTmp->(!Eof()) .And. !oReport:Cancel()
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³INICIO DA 1a SECAO             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If oReport:Cancel()
					Exit
				EndIf

				dDataAnt := cArqTmp->CT2_DATA - 1
				bBloco	:= '{||'+cCpoQuebra+' }'

				cEntiAtual := Eval(&bBloco)

				oSection1:Init()
				IF lJsonOk
					nResult	:= 0
					cKey	:= &(cCpoQuebra)
					_oJsonHist:GetJsonValue(cKey, @nResult)
					nSaldAnt := nResult
					nSaldoAtu := nResult
				ELSE
					aNiveis := StrToKArr( cCpoQuebra, "+" )
					aEntParIni:= {}
					aEntParFim:= {}
					aEval(aNiveis,{|z| AADD(aEntParIni,&(z)) } )
					aEntParFim := aClone(aEntParIni)
					aSaldoAnt := CtbSldCubo(aEntParIni,aEntParFim,Mv_Par01,Mv_Par02,MV_PAR03,MV_PAR04,aSelFil, .T.)
					nSaldAnt := aSaldoAnt[6]
					nSaldoAtu := aSaldoAnt[6]
				Endif

				oSection1_1:Cell("SALDOANT"):SetBlock( {|| ValorCTB(nSaldAnt,,,aTamVal[1],nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )

				oSection1_1:Init()
				nLin := 2
				oSection1_1:PrintLine()
				oSection1_1:Finish()

				nTotDeb	:= 0
				nTotCrd := 0

				While cArqTmp->(!Eof()) .And. !oReport:Cancel() .And. cEntiAtual == Eval(&bBloco)

					nSaldoAtu 	:= nSaldoAtu - cArqTmp->VLRDEB + cArqTmp->VLRCRED

					nTotDeb		+= cArqTmp->VLRDEB
					nTotCrd		+= cArqTmp->VLRCRED
					nTotGerDeb	+= cArqTmp->VLRDEB
					nTotGerCrd	+= cArqTmp->VLRCRED

					oSection1:Cell("VLRDEB"):SetBlock( { || ValorCTB(cArqTmp->VLRDEB,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
					oSection1:Cell("VLRCRED"):SetBlock( { || ValorCTB(cArqTmp->VLRCRED,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
					If lIsRedStor
						oSection1:Cell("VLRSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,aTamVal[1],nDecimais,.T.,cPicture,cNormal,cArqTmp->NIV01,,,cTpValor,,lPrintZero,.F.) } )
					Else
						oSection1:Cell("VLRSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,aTamVal[1],nDecimais,.T.,cPicture,cNormal,,,,cTpValor,,lPrintZero,.F.) } )
					Endif

					oSection1:PrintLine()

					oReport:IncMeter()

					cArqTmp->(DbSkip())

				EndDo

				oSection1:Finish()

			EndDo
		EndIf
	EndIf

	If FindFunction("CtbDelArq")
		CtbDelArq()
	Endif

	If lJsonOk
		__queryEvent:Destroy()
	Endif

	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
	CtbTmpErase(cTmpCT2Fil)
	CtbTmpErase(cTmpCVXFil)
	If Select("cArqTmp") == 0
		FErase(cArqTmp+GetDBExtension())
		FErase(cArqTmp+OrdBagExt())
	EndIF

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ct403Valid³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 24.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida Perguntas                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ct048Valid(cSetOfBook)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T./.F.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Codigo da Config. Relatorio                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr403Valid(cSetOfBook)

	Local aSaveArea:= GetArea()
	Local lRet		:= .T.

	If !Empty(cSetOfBook)
		dbSelectArea("CTN")
		dbSetOrder(1)
		If !dbSeek(xfilial()+cSetOfBook)
			aSetOfBook := ("","",0,"","")
			Help(" ",1,"NOSETOF")
			lRet := .F.
		EndIf
	EndIf

	RestArea(aSaveArea)

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTR403MaxLºAutor ³ Eduardo Nunes Cirqueira º Data ³  31/01/07 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Baseado no parametro MV_PAR11 ("Num.linhas p/ o Balancete      º±±
±±º          ³ Modelo 1"), cujo conteudo esta na variavel "nMaxLin", controla º±±
±±º          ³ a quebra de pagina no TReport                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTR403MaxL(nMaxLin,nLinReport)

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
±±ºPrograma  ³ nCtCGCCabTR  º Autor ³ Fabio Jadao Caires      º Data ³ 31/01/07º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Chama a funcao padrao CtCGCCabTR reiniciando o contador de      º±±
±±º          ³ linhas para o controle do relatorio.                            º±±
±±º          ³                                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION nCtCGCCabTR(dDataFim,dDataIni,titulo,oReport)

	nLinReport := 10

RETURN CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport,,,,,,,,,,dDataIni)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R403PROC    ºAutor  ³TOTVS               º Data ³  08/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                              º±±
±±º          ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R403PROC(aEntdIni,aEntdFim,dDataIni,dDataFim,cCodCubo,cMoeda,cTpSald,aSelFil,cTmpCT2Fil)
	Local nY		:= 0
	Local nEntidade	:= Len(aEntdIni)
	Local cQry		:= ""
	Local cQryDeb	:= ""
	Local cQryCre	:= ""
	Local cQryEntDeb:= ""
	Local cQryEntCre:= ""
	Local cQryOrder	:= ""
	Local aTam		:= TamSx3('CT2_VALOR')
	Local cQryFil	:= ""
	Local cCodEntInicial
	Local cCodEntFinal
	Local nTamCT2_DEB	:= TamSx3('CT2_DEBITO')[1]
	Local nTamCT2_CC 	:= TamSx3('CT2_CCD')[1]
	Local nTamCT2_IT	:= TamSx3('CT2_ITEMD')[1]
	Local nTamCT2_CL	:= TamSx3('CT2_CLVLDB')[1]
	// trataviva para o filtro de multifiliais
	cQryFil := " CT2_FILIAL " + GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil )

	For nY:=1 To nEntidade
		If nY == 1
			cQryDeb += "CT2_DEBITO NIV01,"
			cQryCre += "CT2_CREDIT NIV01,"
			cCpoQuebra += "cArqTmp->NIV01+"
			cQryOrder += "NIV01,"
			cCodEntInicial	:= If(Empty(aEntdIni[nY]),Space(nTamCT2_DEB),aEntdIni[nY])
			cCodEntFinal	:= If(Empty(aEntdFim[nY]),Repl('z',TamSx3('CT2_DEBITO')[1]),aEntdFim[nY])
			cQryEntDeb += "AND CT2_DEBITO BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' "  + CRLF
			cQryEntCre += "AND CT2_CREDIT BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
		ElseIf nY == 2
			cQryDeb += "CT2_CCD NIV02,"
			cQryCre += "CT2_CCC NIV02,"
			cCpoQuebra += "cArqTmp->NIV02+"
			cQryOrder += "NIV02,"
			cCodEntInicial	:= If(Empty(aEntdIni[nY]),Space(nTamCT2_CC),aEntdIni[nY])
			cCodEntFinal	:= If(Empty(aEntdFim[nY]),Repl('z',TamSx3('CT2_CCD')[1]),aEntdFim[nY])
			cQryEntDeb += "AND CT2_CCD BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
			cQryEntCre += "AND CT2_CCC BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
		ElseIf nY == 3
			cQryDeb += "CT2_ITEMD NIV03,"
			cQryCre += "CT2_ITEMC NIV03,"
			cCpoQuebra += "cArqTmp->NIV03+"
			cQryOrder += "NIV03,"
			cCodEntInicial	:= If(Empty(aEntdIni[nY]),Space(nTamCT2_IT),aEntdIni[nY])
			cCodEntFinal	:= If(Empty(aEntdFim[nY]),Repl('z',TamSx3('CT2_ITEMD')[1]),aEntdFim[nY])
			cQryEntDeb += "AND CT2_ITEMD BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
			cQryEntCre += "AND CT2_ITEMC BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
		ElseIf nY == 4
			cQryDeb += "CT2_CLVLDB NIV04,"
			cQryCre += "CT2_CLVLCR NIV04,"
			cCpoQuebra += "cArqTmp->NIV04+"
			cQryOrder += "NIV04,"
			cCodEntInicial	:= If(Empty(aEntdIni[nY]),Space(nTamCT2_CL),aEntdIni[nY])
			cCodEntFinal	:= If(Empty(aEntdFim[nY]),Repl('z',TamSx3('CT2_CLVLDB')[1]),aEntdFim[nY])
			cQryEntDeb += "AND CT2_CLVLDB BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
			cQryEntCre += "AND CT2_CLVLCR BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
		Else
			cQryDeb += "CT2_EC"+StrZero(nY,2)+"DB NIV"+StrZero(nY,2)+","
			cQryCre += "CT2_EC"+StrZero(nY,2)+"CR NIV"+StrZero(nY,2)+","
			cCpoQuebra += "cArqTmp->NIV"+StrZero(nY,2)+"+"
			cQryOrder += "NIV"+StrZero(nY,2)+","
			cCodEntInicial	:= If(Empty(aEntdIni[nY]),Space(TamSx3("CT2_EC"+StrZero(nY,2)+"DB")[1]),aEntdIni[nY])
			cCodEntFinal	:= If(Empty(aEntdFim[nY]),Repl('z',TamSx3("CT2_EC"+StrZero(nY,2)+"DB")[1]),aEntdFim[nY])
			cQryEntDeb += "AND "+"CT2_EC"+StrZero(nY,2)+"DB BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
			cQryEntCre += "AND "+"CT2_EC"+StrZero(nY,2)+"CR BETWEEN '"+cCodEntInicial+"' AND '"+cCodEntFinal+"' " + CRLF
		EndIF

	Next nY

	cCpoQuebra := Substr(cCpoQuebra,1,Len(cCpoQuebra)-1)
	cQryOrder += "CT2_FILIAL,CT2_DATA,CT2_LOTE,CT2_SBLOTE,CT2_DOC,CT2_LINHA"
	cQry += "SELECT CT2_FILIAL,CT2_DATA,CT2_LOTE,CT2_SBLOTE,CT2_DOC,CT2_LINHA,"
	cQry += cQryDeb + "CT2_VALOR VLRDEB, 0 VLRCRED" + CRLF
	cQry += " FROM " + RetSqlName('CT2') + CRLF
	cQry += " WHERE " + cQryFil
	cQry += " AND CT2_DATA >= '"+DTOS(dDataIni)+ "' AND CT2_DATA <= '"+DTOS(dDataFim)+"'"
	cQry += " AND CT2_TPSALD = '"+ cTpSald + "'"
	cQry += " AND CT2_MOEDLC = '" + cMoeda +"'"
	cQry += " AND (CT2_DC = '1' OR CT2_DC = '3') AND CT2_VALOR <> 0 " + cQryEntDeb + " AND D_E_L_E_T_ = ' ' "
	cQry += " UNION ALL " + CRLF
	cQry += " SELECT CT2_FILIAL,CT2_DATA,CT2_LOTE,CT2_SBLOTE,CT2_DOC,CT2_LINHA,"
	cQry += cQryCre + "0 VLRDEB, CT2_VALOR VLRCRED"+ CRLF
	cQry += " FROM " + RetSqlName('CT2') + CRLF
	cQry += " WHERE " + cQryFil
	cQry += " AND CT2_DATA >= '"+DTOS(dDataIni)+ "' AND CT2_DATA <= '"+DTOS(dDataFim)+"'"
	cQry += " AND CT2_TPSALD = '"+ cTpSald + "'"
	cQry += " AND CT2_MOEDLC = '" + cMoeda +"'"
	cQry += " AND (CT2_DC = '2' OR CT2_DC = '3') AND CT2_VALOR <> 0 " + cQryEntCre + " AND D_E_L_E_T_ = ' ' "
	cQry += " ORDER BY " + CRLF
	cQry += cQryOrder

	// Se o arquivo temporario de trabalho esta aberto
	If ( Select ( "cArqTmp" ) > 0 )
		cArqTmp->(dbCloseArea())
	EndIf

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTmp",.T.,.F.)

	TCSetField("cArqTmp","CT2_DATA", "D",8,0)
	TCSetField("cArqTmp","VLRDEB", "N",aTam[1],aTam[2])
	TCSetField("cArqTmp","VLRCRED","N",aTam[1],aTam[2])

	DbSelectArea("cArqTmp")

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ R403SldAnt³ Autor ³ TOTVS            	³ Data ³ 08/01/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria e instala procedure que busca o Saldo anterior		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R403SldAnt( aSelFil,  cTmpCVXFil )
	Local cQuery  := ""
	Local nEntidades	:= Val(Mv_par07)
	Local nX := 0
	Local lRet  := .F.
	Local cQryFil := ""
	Local cConfig	:= strzero(nEntidades,2)
	Local cData   := DtoS(mv_par01)
	Local cTpSald := Mv_par04
	Local cKey		:= ""
	Local cMoeda	:= MV_PAR03
	Local cAliasQry	:= ""
	Local cChave	:= ""

	cQryFil := GetRngFil( aSelFil, "CT2", .T., @cTmpCVXFil )
	cQuery+="        SELECT "
	For nX := 1 to nEntidades
		cQuery	+= "        CVX_NIV"+StrZero(nX,2)+","
		cKey	+= "        CVX_NIV"+StrZero(nX,2)+"+"
	Next
	cKey := substr(cKey,1,len(cKey)-1)
	cQuery+="  COALESCE(COALESCE(SUM(CVX_SLDCRD),0) - COALESCE(SUM(CVX_SLDDEB),0) ,0) SALDANT "+CRLF
	cQuery+="             From "+RetSqlName("CVX")+CRLF
	cQuery+="            WHERE D_E_L_E_T_ = ' '"+CRLF
	cQuery+="              AND CVX_FILIAL "+cQryFil+CRLF
	cQuery+="              AND CVX_CONFIG = ? "+CRLF  //-- se niv 1 e niv2 cubo 2
	cQuery+="              AND CVX_MOEDA  = ? "+CRLF
	cQuery+="              AND CVX_DATA   < ? "+CRLF
	cQuery+="              AND CVX_TPSALD = ? "+CRLF
	cQuery+="           GROUP BY "
	For nX := 1 To nEntidades
		cQuery +="CVX_NIV"+StrZero(nX,2)+", "
	Next
	cQuery+="CVX_CONFIG"+CRLF
	cQuery := ChangeQuery(cQuery)
	__queryEvent := FwExecStatement():New(cQuery)

	__queryEvent:SetString(1, cConfig)	//P1 filial
	__queryEvent:SetString(2, cMoeda) 	//P2 MOEDA
	__queryEvent:SetString(3, cData)	//P2 DATA
	__queryEvent:SetString(4, cTpSald)	//P2 TIPO SALDO

	cAliasQry := __queryEvent:OpenAlias(GetNextAlias())

	WHILE (cAliasQry)->( !EOF() )
		lRet := .t.
		cChave:= &((cAliasQry)+"->("+cKey+")")
		_oJsonHist[cChave ] := (cAliasQry)->SALDANT
		(cAliasQry)->(dbSkip())
	ENDDO
	(cAliasQry)->(dbCloseArea())

Return(lRet)

