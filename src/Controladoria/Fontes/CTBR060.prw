/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr060.Ch"
#Include "PROTHEUS.Ch"

#DEFINE 	TAM_VALOR    TAMSX3('CT7_DEBITO')[1] + 6

// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³U_Ctbr060()	³ Autor ³ Cicero J. Silva   	³ Data ³ 18.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico Sintetico Modelo 3   		  		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr060()                               		 		  	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 	     ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR060()

Local oReport

Local aSetOfBook
Local aCtbMoeda 	:= {}
Local lOk			:= .T.
Local nDivide		:= 1
Local nQuadro

Private cPerg	 := "CTR060"
Private aQuadro := { "","","","","","","",""}              
PRIVATE nomeProg  := "CTBR060"
PRIVATE titulo
PRIVATE aSelFil	:= {}

	If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
		lOk	:= .F.
	EndIf       

	For nQuadro :=1 To Len(aQuadro)
		aQuadro[nQuadro] := Space(Len(CriaVar("CT1_CONTA")))
	Next	

	CtbCarTxt()

	Pergunte("CTR060",.T.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
	//³ Gerencial -> montagem especifica para impressao)		     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !ct040Valid(mv_par06)
		lOk	:= .F.
	Else
	   aSetOfBook := CTBSetOf(mv_par06)
	Endif
	
	If lOk .And. mv_par30 == 1 .And. Len( aSelFil ) <= 0
  		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			lOk	:= .F.
		EndIf 
	EndIf
	
	If mv_par21 == 2			// Divide por cem
		nDivide := 100
	ElseIf mv_par21 == 3		// Divide por mil
		nDivide := 1000
	ElseIf mv_par21 == 4		// Divide por milhao
		nDivide := 1000000
	EndIf	
	
	If lOk
		aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide)
		If Empty(aCtbMoeda[1])                       
	      Help(" ",1,"NOMOEDA")
	      lOk := .F.
	   Endif
	   If lOk .and. !Empty(mv_par29)
			aCtbMoeda  	:= CtbMoeda(mv_par29,nDivide)
			If Empty(aCtbMoeda[1])                       
				Help(" ",1,"NOMOEDA")
				lOk := .F.
			Endif
	   EndIf
	Endif
	
	If lOk
		If (mv_par26 == 1) .and. ( Empty(mv_par27) .or. Empty(mv_par28) )// Rec./Desp. Anterior Zeradas? ## Grupo Receitas/Despesas? ## Data de Zeramento Receita/Despesas? 
			cMensagem	:= STR0024	// "Favor preencher os parametros Grupos Receitas/Despesas e Data Sld Ant. Receitas/Despesas ou "
			cMensagem	+= STR0025	// "deixar o parametro Ignora Sl Ant.Rec/Des = Nao "
			MsgAlert(cMensagem,"Ignora Sl Ant.Rec/Des")	
			lOk	:= .F.	
	    EndIf
	EndIf

	If lOk
		oReport := ReportDef(aSetOfBook,aQuadro,aCtbMoeda,nDivide)
		oReport:PrintDialog()
	EndIf

//Limpa os arquivos temporários 
CTBGerClean()

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  07/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aSetOfBook - Matriz ref. Config. Relatorio                 º±±
±±º          ³ aQuadro    - Contas para formar os quadros de resultados   º±±
±±º          ³ aCtbMoeda  - Matriz ref. a moeda                           º±±
±±º          ³ nDivide    - Valor a ser usado para divisao de valores     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(aSetOfBook,aQuadro,aCtbMoeda,nDivide)

Local oReport
Local oPlcontas
Local oTotais

Local nDecimais                                 
Local cSeparador	:= "" 
Local cMascara		:= ""
Local cPicture		:= ""

Local cDescMoeda
Local dDataFim 		:= mv_par02
Local lImpSint		:= Iif(mv_par05==1 .Or. mv_par05 ==3,.T.,.F.)// Imprime Contas: 1=Sintet/2=Analit/3=Ambas
Local lImpConta		:= Iif(mv_par11==1,.T.,.F.) // Imprime da Conta? Codigo / Descricao
Local lMov			:= Iif(mv_par17==1,.T.,.F.) // Imprime Coluna Mov ?
Local lNormal		:= Iif(mv_par20==1,.T.,.F.)	// Imprimir Codigo? Normal / Reduzido
Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+mv_par08))
Local nTamGrupo		:= Len(CriaVar("CT1->CT1_GRUPO"))
Local nTamDescr		:= 0

//"Este programa ira imprimir o Balancete de Verificacao Modelo 3 (132 Colunas), e"
//"opcional a impressao do codigo da conta ou sua descricao, sao tambem impressos,"
//"saldo anterior, debito, credito e saldo atual do periodo."
Local cDesc			:= STR0001+STR0002+STR0016

// Retorna Decimais
cDescMoeda 	:= Alltrim(aCtbMoeda[2])
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
Else
	cMascara := RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf
cPicture := aSetOfBook[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par05 == 1      
	titulo := STR0035  // "Balancete de Verificacao Sintetico de "
ElseIf mv_par05 == 2
	titulo := STR0034  // "Balancete de Verificacao Analitico de "
ElseIf mv_par05 == 3
	titulo := STR0036  // "Balancete de Verificacao de "
EndIf

titulo += DTOC(mv_par01)+ OemToAnsi(STR0037)+ Dtoc(mv_par02)+Lower(OemToAnsi(STR0008))+cDescMoeda
titulo += IIF (mv_par10 > "1"," (" + Tabela("SL", mv_par10, .F.) + ")","")
titulo += IIF (nDivide  >  1 ," (" + OemToAnsi(STR0023) + Alltrim(Str(nDivide)) + ")", "")	

oReport := TReport():New(nomeProg,titulo,"CTR060",{|oReport| ReportPrint(oReport,aSetOfBook,aQuadro,aCtbMoeda,nDivide,cMascara,cPicture)},cDesc)


If lMov
	oReport:SetLandScape(.T.)
Else
	oReport:SetPortrait(.T.)
EndIf

// Sessao 1
oPlcontas := TRSection():New(oReport,STR0033,{"cArqTmp","CT1"},/*aOrder*/,.F./*lLoadCells*/,.F./*lLoadOrder*/)	//"Plano de contas"

TRCell():New(oPlcontas,"CONTA"		,"cArqTmp",	STR0026,/*Picture*/,aTamConta[1],/*lPixel*/,{|| EntidadeCTB(cArqTmp->CONTA ,0,0,70,.F.,cMascara,cSeparador,,,,,.F.) })// "C O D I G O   D A   C O N T A"
TRCell():New(oPlcontas,"CTARES"		,"cArqTmp", STR0026,/*Picture*/,aTamCtaRes[1],/*lPixel*/,{|| EntidadeCTB(cArqTmp->CTARES,0,0,70,.F.,cMascara,cSeparador,,,,,.F.) })// "C O D I G O   D A   C O N T A"
TRCell():New(oPlcontas,"DESCCTA"	,"cArqTmp", STR0027,/*Picture*/,nTamCta,/*lPixel*/,/*{|| }*/)// "D E S C R I C A O  D A  C O N T A"
TRCell():New(oPlcontas,"SALDOANT"	,"cArqTmp", STR0028,/*Picture*/,TAM_VALOR+2,/*lPixel*/,,/*"RIGHT"*/,,"RIGHT",,,.F.)// "SALDO ANTERIOR"
TRCell():New(oPlcontas,"SALDODEB"	,"cArqTmp", STR0029,/*Picture*/,TAM_VALOR+2,/*lPixel*/,,/*"RIGHT"*/,,"RIGHT",,,.F.)// "DEBITO"
TRCell():New(oPlcontas,"SALDOCRD"	,"cArqTmp", STR0030,/*Picture*/,TAM_VALOR+2,/*lPixel*/,,/*"RIGHT"*/,,"RIGHT",,,.F.)// "CREDITO"
TRCell():New(oPlcontas,"MOVIMENTO"	,"cArqTmp", STR0031,/*Picture*/,TAM_VALOR+2,/*lPixel*/,,/*"RIGHT"*/,,"RIGHT",,,.F.)// "MOVIMENTO PERIODO"
TRCell():New(oPlcontas,"SALDOATU"	,"cArqTmp", STR0032,/*Picture*/,TAM_VALOR+2,/*lPixel*/,,/*"RIGHT"*/,,"RIGHT",,,.F.)// "SALDO ATUAL"

oPlcontas:Cell("SALDOANT"):lHeaderSize  := .F.
oPlcontas:Cell("SALDODEB"):lHeaderSize  := .F.
oPlcontas:Cell("SALDOCRD"):lHeaderSize  := .F.
oPlcontas:Cell("MOVIMENTO"):lHeaderSize := .F.
oPlcontas:Cell("SALDOATU"):lHeaderSize  := .F.

TRPosition():New( oPlcontas, "CT1", 1, {|| xFilial("CT1") + cArqTMP->CONTA })    
    
nTamDescr := oPlcontas:Cell("CONTA"):GetSize() + oPlcontas:Cell("CTARES"):GetSize() + oPlcontas:Cell("DESCCTA"):GetSize() + oPlcontas:Cell("SALDOANT"):GetSize() + 1

If lNormal
	oPlcontas:Cell("CTARES"):Disable()    
	nTamDescr -= oPlcontas:Cell("CTARES"):GetSize()
Else
	oPlcontas:Cell("CONTA" ):Disable()
	nTamDescr -= oPlcontas:Cell("CONTA"):GetSize()
EndIf

If lImpConta
	oPlcontas:Cell("DESCCTA"):Disable()
	nTamDescr -= oPlcontas:Cell("DESCCTA"):GetSize()	
Else
	oPlcontas:Cell("CONTA"  ):Disable()
	oPlcontas:Cell("CTARES" ):Disable()
	nTamDescr -= (oPlcontas:Cell("CONTA"):GetSize() + oPlcontas:Cell("CTARES"):GetSize())
EndIf 

// Sessao totalizadora 
oTotais := TRSection():New(oReport,STR0038,{""},/*aOrder*/,.F./*lLoadCells*/,.F./*lLoadOrder*/)	//"Totais"

TRCell():New(oTotais,"DESCRICAO"	,"", STR0039,/*Picture*/,nTamDescr ,/*lPixel*/,)
TRCell():New(oTotais,"DEBITO"		,"", STR0029,/*Picture*/,TAM_VALOR+2 ,/*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"RIGHT",,,.F.)
TRCell():New(oTotais,"CREDITO"		,"", STR0030,/*Picture*/,TAM_VALOR+2 ,/*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"RIGHT",,,.F.)
TRCell():New(oTotais,"MOVIMENTO"	,"", STR0031,/*Picture*/,TAM_VALOR+2 ,/*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"RIGHT",,,.F.)
oTotais:SetHeaderSection(.F.) 

If !lMov
	oPlcontas:Cell("MOVIMENTO"):Disable()  
	oTotais:Cell("MOVIMENTO"):Disable()
EndIf

oPlcontas:SetHeaderPage()
oReport:ParamReadOnly()

Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintº Autor ³ Cicero J. Silva    º Data ³  14/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,aSetOfBook,aQuadro,aCtbMoeda,nDivide,cMascara,cPicture)

Local oPlcontas := oReport:Section(1)
Local oTotais := oReport:Section(2) 

Local lOk			:= .T.
Local cArqTmp
Local nDigitAte		:= 0
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotMov		:= 0
Local nGrpDeb		:= 0
Local nGrpCrd		:= 0                     
Local cTpContaAnt  := "1"
Local cGrupoAnt		:= ""

Local cFiltro	:= oPlcontas:GetAdvplExp()

Local lFirstPage	:= .T.
Local lJaPulou		:= .F.
Local dDataFim 		:= mv_par02
Local lImpSint		:= (mv_par05=1 .Or. mv_par05 ==3)// Imprime Contas: Sintet/Analit/Ambas
Local lVlrZerado	:= (mv_par07==1)	// Saldos Zerados?
Local lImpConta		:= (mv_par11==1)	// Imprime da Conta? Codigo / Descricao
Local lMov			:= (mv_par17==1)	// Imprime Coluna Mov ?
Local lPula			:= (mv_par18==1)	// Salta linha sintetica ?
Local lPrintZero	:= (mv_par19==1)	// Imprime valor 0.00?
Local cSegAte   	:= mv_par22						// Imprimir Ate o segmento?  
Local lImpAntLP		:= (mv_par23==1)	// Posicao Ant. L/P? Sim / Nao 
Local dDataLP		:= mv_par24						// Data Lucros/Perdas?
Local lRecDesp0		:= (mv_par26==1)	// Rec./Desp. Anterior Zeradas?  
Local cRecDesp		:= mv_par27						// Grupo Receitas/Despesas?
Local dDtZeraRD		:= mv_par28						// Data de Zeramento Receita/Despesas?
Local cMoedaDsc		:= mv_par29
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)
Local nSizeDeb		:=	oPlContas:Cell("SALDODEB"):nSize
Local nSizeCrd		:=	oPlContas:Cell("SALDOCRD"):nSize
Local nSizeMov		:=	oPlContas:Cell("MOVIMENTO"):nSize   
Local lFinaliza		:= .F.
Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)// Parameter to activate Red Storn
Local nTotMov1		:= 0
Local nTotMov2		:= 0
Local cTipo			:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Davi Torchio - 10/07/2007                                     ³
//³Controle de numeração de pagina para o relatorio personalizado³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nPagIni		:= MV_PAR09 // parametro da pagina inicial
Private nPagFim		:= 999999 	// parametro da pagina final
Private nReinicia	:= 0    	// parametro de reinicio de pagina
Private l1StQb		:= .T.		// primeira quebra
Private lNewVars	:= .T.		// inicializa as variaveis
Private m_pag		:= MV_PAR09 // controle de numeração de pagina
Private nBloco      := 1		// controle do bloco a ser impresso
Private nBlCount	:= 0		// contador do bloco impresso

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao	    			     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
						 mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
						 mv_par10,aSetOfBook,mv_par13,mv_par14,mv_par15,mv_par16,;
						 .F.,.F.,mv_par12,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro,lRecDesp0,;
						 cRecDesp,dDtZeraRD,,,,,,,cMoedaDsc,,aSelFil)},;
			OemToAnsi(OemToAnsi(STR0015)),;  //"Criando Arquivo Tempor rio..."
			OemToAnsi(STR0003))  				//"Balancete Verificacao"

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara) 	
EndIf		

oReport:SetPageNumber( mv_par09 )
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport,/*.T.controle do cabeçalho pela rotina*/) } )

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()
oReport:SetMeter( RecCount() )

If RecCount() == 0
	lOk := .F.
Endif

oReport:NoUserFilter()

If lOk            
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cGrupoAnt := cArqTmp->GRUPO

	oPlContas:Cell("SALDOANT" ):SetBlock( { || Iif( !lPrintZero .And. cArqTmp->SALDOANT == 0, "",;
		ValorCTB(cArqTmp->SALDOANT ,,,oPlContas:Cell("SALDOANT" ):nSize,nDecimais,.T.,aSetOfBook[4],cArqTmp->NORMAL,,,,,,lPrintZero,.F.) ) } )
	oPlContas:Cell("SALDODEB" ):SetBlock( { || Iif( !lPrintZero .And. cArqTmp->SALDODEB == 0, "",;
		ValorCTB(cArqTmp->SALDODEB ,,,nSizeDeb,nDecimais,.F.,aSetOfBook[4],cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr) ) } )
	oPlContas:Cell("SALDOCRD" ):SetBlock( { || Iif( !lPrintZero .And. cArqTmp->SALDOCRD == 0, "",;
		ValorCTB(cArqTmp->SALDOCRD ,,,nSizeCrd,nDecimais,.F.,aSetOfBook[4],cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr) ) } )
	oPlContas:Cell("MOVIMENTO"):SetBlock( { || Iif( !lPrintZero .And. cArqTmp->MOVIMENTO == 0, "",;
		ValorCTB(cArqTmp->MOVIMENTO,,,nSizeMov,nDecimais,.T.,aSetOfBook[4],cArqTmp->NORMAL,,,,,,lPrintZero,.F.) ) } )
	oPlContas:Cell("SALDOATU" ):SetBlock( { || Iif( !lPrintZero .And. cArqTmp->SALDOATU == 0, "",;
		ValorCTB(cArqTmp->SALDOATU ,,,oPlContas:Cell("SALDOATU" ):nSize,nDecimais,.T.,aSetOfBook[4],cArqTmp->NORMAL,,,,,,lPrintZero,.F.) ) } )
	oPlContas:Cell("SALDOANT" ):SetAlign("RIGHT")
	oPlContas:Cell("SALDODEB" ):SetAlign("RIGHT")
	oPlContas:Cell("SALDOCRD" ):SetAlign("RIGHT")
//	oPlContas:Cell("MOVIMENTO"):SetAlign("RIGHT")	
//	oPlContas:Cell("SALDOATU" ):SetAlign("RIGHT")			
	oTotais:Cell("DESCRICAO" ):SetBlock( { || Iif(lFinaliza, OemToAnsi(STR0011), OemToAnsi(STR0020) + cGrupoAnt + ") : ") } ) 
	oTotais:Cell("DEBITO"):SetBlock( { || ValorCTB(Iif(lFinaliza, nTotDeb,nGrpDeb),,,nSizeDeb,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr)}) 
	oTotais:Cell("CREDITO"):SetBlock( { || ValorCTB(Iif(lFinaliza,nTotCrd,nGrpCrd),,,nSizeCrd,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr)}) 
	oTotais:Cell("MOVIMENTO"):SetBlock( { || ValorCTB(nTotMov,,,nSizeCrd,nDecimais,.F.,cPicture,Iif(Round(NoRound(nTotMov,3),2) < 0,"1","2"),,,,,,lPrintZero,.F.,lColDbCr)}) 	
	oTotais:Cell("DEBITO"):SetAlign("RIGHT")			
	oTotais:Cell("CREDITO"):SetAlign("RIGHT")				
//	oTotais:Cell("MOVIMENTO"):SetAlign("RIGHT")				
	oPlcontas:Init() 
	
	Do While !Eof() .And. !oReport:Cancel()

	    oReport:IncMeter()

	    If oReport:Cancel()
	    	Exit
	    EndIf     
	       
		If mv_par05 == 1					// So imprime Sinteticas
			If cArqTmp->TIPOCONTA == "2"
				dbSkip()
				Loop
			EndIf
		ElseIf mv_par05 == 2				// So imprime Analiticas
			If cArqTmp->TIPOCONTA == "1"
				dbSkip()
				Loop
			EndIf
		EndIf

		//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
		If !Empty(cSegAte)
			If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
				dbSkip()
				Loop
			Endif
		EndIf

		cTipo := cArqTmp->NORMAL
		
     	oPlcontas:PrintLine() //Section(1)

		If mv_par05 == 1 // So imprime Sinteticas - Soma Sinteticas
			If cArqTmp->TIPOCONTA == "1"
				If cArqTmp->NIVEL1
					nTotDeb += cArqTmp->SALDODEB
					nTotCrd += cArqTmp->SALDOCRD
					nGrpDeb += cArqTmp->SALDODEB
					nGrpCrd += cArqTmp->SALDOCRD
					
					If cPaisLoc $ "RUS"
						nTotMov1 +=  RedStorTt(cArqTmp->SALDODEB,cArqTmp->SALDOCRD,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
						nTotMov2 +=  RedStorTt(cArqTmp->SALDODEB,cArqTmp->SALDOCRD,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
					Endif
					
				EndIf
			EndIf
		Else			// Soma Analiticas
			If Empty(cSegAte)	//Se nao tiver filtragem ate o nivel
				If cArqTmp->TIPOCONTA == "2"
					nTotDeb += cArqTmp->SALDODEB
					nTotCrd += cArqTmp->SALDOCRD
					nGrpDeb += cArqTmp->SALDODEB
					nGrpCrd += cArqTmp->SALDOCRD
					
					If cPaisLoc $ "RUS"
						nTotMov1 +=  RedStorTt(cArqTmp->SALDODEB,cArqTmp->SALDOCRD,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
						nTotMov2 +=  RedStorTt(cArqTmp->SALDODEB,cArqTmp->SALDOCRD,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
					Endif
					
				EndIf
			Else	//Se tiver filtragem, somo somente as sinteticas
				If cArqTmp->TIPOCONTA == "1"
					If cArqTmp->NIVEL1
						nTotDeb += cArqTmp->SALDODEB
						nTotCrd += cArqTmp->SALDOCRD
						nGrpDeb += cArqTmp->SALDODEB
						nGrpCrd += cArqTmp->SALDOCRD
						
						If cPaisLoc $ "RUS"
							nTotMov1 +=  RedStorTt(cArqTmp->SALDODEB,cArqTmp->SALDOCRD,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
							nTotMov2 +=  RedStorTt(cArqTmp->SALDODEB,cArqTmp->SALDOCRD,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
						Endif
						
					EndIf
				EndIf	
	    	Endif			
		EndIf

  		dbSkip()         

		If lPula
			If cArqTmp->TIPOCONTA == "1"
				oReport:SkipLine() 
				cTpContaAnt := cArqTmp->TIPOCONTA
			ElseIf cTpContaAnt == "1"
				oReport:SkipLine() 
				cTpContaAnt := cArqTmp->TIPOCONTA
			EndIf
		EndIf 

		If mv_par12 == 1
			If cGrupoAnt <> cArqTmp->GRUPO	// Grupo Diferente - Totaliza e Quebra

				oReport:SkipLine()                      
		     	oReport:ThinLine()    
				oReport:SkipLine() 
				
				If lRedStorn
					nTotMov := RedStorTt(nGrpDeb,nGrpCrd,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
				Else
					nTotMov := nGrpCrd - nGrpDeb
				Endif	
   
			    oTotais:Init()
			    oTotais:PrintLine()     
			   	oReport:ThinLine()    
			    oTotais:Finish()

				cGrupoAnt	:= cArqTmp->GRUPO
				nGrpDeb		:= 0
				nGrpCrd		:= 0
				nTotMov1	:= 0
                
				If cArqTmp->( !EoF() )
					oReport:EndPage() // Quebra direto - Comando .T. retirado para corrigir contador das paginas
				EndIf	

			EndIf		
		Else
			If cArqTmp->( !EoF() ) .And. cArqTmp->NIVEL1 	// Sintetica de 1o. grupo
				oReport:EndPage() // Quebra direto - Comando .T. retirado para corrigir contador das paginas
			EndIf
	    EndIf
    EndDo

	oPlcontas:Finish()

   	oReport:ThinLine()
	oReport:SkipLine() 

	If mv_par12 == 1 .And. cGrupoAnt <> cArqTmp->GRUPO // Grupo Diferente - Totaliza e Quebra

		If lRedStorn
			nTotMov :=  nTotMov1
		Else
			nTotMov :=  nGrpCrd - nGrpDeb
		Endif	
		
	    oTotais:Init()
	    oTotais:PrintLine()     
	   	oReport:ThinLine()    
		oReport:SkipLine() 
	    oTotais:Finish()

	EndIf  
	
	lFinaliza := .T.

	If lRedStorn
		nTotMov :=  nTotMov2
	Else
		nTotMov :=  nTotCrd - nTotDeb
	Endif	
	
    oTotais:Init()
    oTotais:PrintLine()     
   	oReport:ThinLine()    
    oTotais:Finish()

	If mv_par25 ==1 
		oReport:Section(1):SetHeaderSection(.F.)
		ImpQuadro(0,X3USO("CT2_DCD"),dDataFim,mv_par08,aQuadro,Alltrim(aCtbMoeda[2]),oReport:ClassName(),(IIF(lImpAntLP,dDataLP,CtoD(""))),cPicture,DecimalCTB(aSetOfBook,mv_par08),lPrintZero,mv_par10,oReport)
	EndIf	

EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea() 
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF	
dbselectArea("CT2")

Return                                                                          
