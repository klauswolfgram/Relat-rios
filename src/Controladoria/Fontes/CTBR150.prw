/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR150.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	16
#DEFINE TAM_TOTAIS  17

// 17/08/2009 -- Filial com mais de 2 caracteres

// TRADUCAO DE CH'S PARA PORTUGAL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณ Ctbr150	ณ Autor ณ Cicero J. Silva	    ณ Data ณ 28.07.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Balanco Geral Modelo 1				 					  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ U_CTBR150(void)											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno	 ณ Nenhum        											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		 ณ Generico 												  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณNenhum         											  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Ctbr150(wnRel)

Local aArea := GetArea()
Local oReport
Local lOk := .T.
Local lExterno 		:= ( wnRel <> Nil )
Local aCtbMoeda		:= {}

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR150"
PRIVATE nomeProg  	:= "CTBR150"
PRIVATE titulo
PRIVATE m_pag

		Pergunte(cPerg,.T.) // Precisa ativar as perguntas antes das definicoes.
	
		If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
			lOk := .F.
		EndIf
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
		//ณ Gerencial -> montagem especifica para impressao)			 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If !ct040Valid(mv_par06)
			lOk := .F.
		EndIf 
		
		If lOk
			aCtbMoeda  	:= CtbMoeda(mv_par08)
		   If Empty(aCtbMoeda[1])
		      Help(" ",1,"NOMOEDA")
		      lOk := .F.
		   Endif
		Endif

		If lOk
			oReport := ReportDef(aCtbMoeda)
			oReport:PrintDialog()
		EndIf

//Limpa os arquivos temporแrios 
CTBGerClean()
	
RestArea(aArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ ReportDef บ Autor ณ Cicero J. Silva    บ Data ณ  07/07/06  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Definicao do objeto do relatorio personalizavel e das      บฑฑ
ฑฑบ          ณ secoes que serao utilizadas                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ aCtbMoeda  - Matriz ref. a moeda                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGACTB                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ReportDef(aCtbMoeda)

Local oReport
Local oTotais

Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+mv_par08))
Local cSegAte   	:= mv_par20
Local dDataFim 		:= mv_par02
Local lImpRes		:= Iif(mv_par18 == 1,.F.,.T.)	
Local lPrintZero	:= Iif(mv_par17==1,.T.,.F.)
Local lPula			:= Iif(mv_par16==1,.T.,.F.) 

Local nSaldo		:= 0
Local cSepara		:= ""
Local aSetOfBook	:= CTBSetOf(mv_par06)
Local cDescMoeda 	:= aCtbMoeda[2]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)
Local cMascara		:= IIf (Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara))
Local cPicture 		:= aSetOfBook[4]
Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Carrega titulo do relatorio: Analitico / Sintetico			  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
IF mv_par05 == 1
	titulo:=	OemToAnsi(STR0009)	//"BALANCO GERAL SINTETICO DE "
ElseIf mv_par05 == 2
	titulo:=	OemToAnsi(STR0010)	//"BALANCO GERAL ANALITICO DE "
ElseIf mv_par05 == 3
	titulo:=	OemToAnsi(STR0011)	//"BALANCO GERAL DE "
EndIf

titulo += 	DTOC(mv_par01) + OemToAnsi(STR0012) + Dtoc(mv_par02) + ;
			OemToAnsi(STR0013) + cDescMoeda + CtbTitSaldo(mv_par10)

oReport := TReport():New(nomeProg,Capital(titulo),cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,aCtbMoeda,cMascara,cPicture,cSegAte,nDecimais)},STR0001+STR0002+STR0003)//"Este programa ira imprimir o Balanco Geral Modelo 1 (132) Colunas."##//"A conta eh impressa limitando-se a 30 caracteres e sua descricao 40 caracteres,"##//"sao tambem impressos colunas do saldo a debito e a credito do periodo."
oReport:SetPortrait(.T.)
oReport:SetCustomText( { || CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )
// Sessao 1
oPlcontas := TRSection():New(oReport,STR0028,{"cArqTmp", "CT1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)  //"Balanco Modelo I"
oPlcontas:SetTotalInLine(.F.)
oPlcontas:SetNoFilter({"cArqTmp"})

TRCell():New(oPlcontas,"CONTA"			,"cArqTmp",STR0023	,/*Picture*/,aTamConta[1]	,/*lPixel*/,{|| IIF(cArqTmp->TIPOCONTA=="2","  ","")+EntidadeCTB(cArqTmp->CONTA ,0,0,70,.F.,cMascara,cSepara,,,,,.F.) })//"CONTA"
TRCell():New(oPlcontas,"CTARES"			,"cArqTmp",STR0024	,/*Picture*/,aTamCtaRes[1]	,/*lPixel*/,{|| IIF(cArqTmp->TIPOCONTA=="2","  ","")+EntidadeCTB(cArqTmp->CTARES,0,0,70,.F.,cMascara,cSepara,,,,,.F.) })//"CODIGO REDUZIDO"
TRCell():New(oPlcontas,"DESCCTA"		,"cArqTmp",STR0025	,/*Picture*/,nTamCta		,/*lPixel*/,/*{|| }*/)//"DESCRICAO DA CONTA"

If lRedStorn
	TRCell():New(oPlcontas,"COL_DEB"		,"       ",STR0026	,/*Picture*/,22/*17*/,/*lPixel*/,{|| ValorCTB(Iif(cArqTmp->NORMAL=="1",cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR,0),,,TAM_VALOR,nDecimais,.F.,cPicture," ",,,,,,lPrintZero,.F.,lColDbCr) },"RIGHT",,"RIGHT")// "D E B I T O"
	TRCell():New(oPlcontas,"COL_CRD"		,"       ",STR0027	,/*Picture*/,22/*17*/,/*lPixel*/,{|| ValorCTB(Iif(cArqTmp->NORMAL=="2",cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB,0),,,TAM_VALOR,nDecimais,.F.,cPicture," ",,,,,,lPrintZero,.F.,lColDbCr) },"RIGHT",,"RIGHT")//"C R E D I T O"
Else
	TRCell():New(oPlcontas,"COL_DEB"		,"       ",STR0026	,/*Picture*/,22/*17*/,/*lPixel*/,{|| ValorCTB(IIF( cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB < 0,ABS(cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB),0),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) },"RIGHT",,"RIGHT")// "D E B I T O"
	TRCell():New(oPlcontas,"COL_CRD"		,"       ",STR0027	,/*Picture*/,22/*17*/,/*lPixel*/,{|| ValorCTB(IIF( cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB > 0,ABS(cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB),0),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) },"RIGHT",,"RIGHT")//"C R E D I T O"
EndIF

If mv_par18 == 2 //Se Imprime Codigo Reduzido
	oPlcontas:Cell("CONTA"):Disable()	
Else
	oPlcontas:Cell("CTARES"):Disable()
EndIf

oPlcontas:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;//Salta linha sintetica ?
								 cTipoAnt := cArqTmp->TIPOCONTA;
							)  })

oTotais := TRSection():New( oReport,STR0029,,, .F., .F. )  //"Total"
TRCell():New( oTotais, "TOT"				,,""		,/*Picture*/,aTamConta[1]+nTamCta,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais, "TOT_DEBITO"			,,STR0026	,/*Picture*/,6+TAM_TOTAIS,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")  //"D E B I T O"	
TRCell():New( oTotais, "TOT_CREDITO"		,,STR0027	,/*Picture*/,6+TAM_TOTAIS,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT") //"C R E D I T O"

Return oReport				 

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrintบ Autor ณ Cicero J. Silva    บ Data ณ  14/07/06  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Definicao do objeto do relatorio personalizavel e das      บฑฑ
ฑฑบ          ณ secoes que serao utilizadas                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function	ReportPrint(oReport,aSetOfBook,aCtbMoeda,cMascara,cPicture,cSegAte,nDecimais)

Local oPlcontas		:= oReport:Section(1)
Local oTotais		:= oReport:Section(2)

Local cArqTmp		:=	""
LOCAL limite		:= 132
Local lImpLivro		:=.T.
Local lImpTermos	:=.F.
Local lImpAntLP		:= Iif(mv_par21 == 1,.T.,.F.)
Local dDataLP		:= mv_par22
Local lVlrZerado	:= Iif(mv_par07==1,.T.,.F.)
Local lImpSint		:= Iif(mv_par05=1 .Or. mv_par05 ==3,.T.,.F.)
Local lTotGSint		:= Iif(mv_par24==2,.T.,.F.)	//Define se ira imprimir o total geral pelas contas analiticas ou sinteticas
Local lPrintZero	:= Iif(mv_par17==1,.T.,.F.)
Local nDigitAte		:= 0
Local nDivide		:= 1
Local cFiltro	:= oPlcontas:GetAdvplExp()

Local nGrpDeb := 0
Local nTotDeb := 0
Local nGrpCrd := 0
Local nTotCrd := 0

Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)

	oReport:SetPageNumber(mv_par09) //mv_par08	-	Pagina Inicial
	
	If mv_par19 == 2			// Divide por cem
		nDivide := 100
	ElseIf mv_par19 == 3		// Divide por mil
		nDivide := 1000
	ElseIf mv_par19 == 4		// Divide por milhao
		nDivide := 1000000
	EndIf	

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao de Termo / Livro                                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Do Case
		Case mv_par23==1 ; lImpLivro:=.t. ; lImpTermos:=.f.
		Case mv_par23==2 ; lImpLivro:=.t. ; lImpTermos:=.t.
		Case mv_par23==3 ; lImpLivro:=.f. ; lImpTermos:=.t.
	EndCase

	If lImpLivro
		MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				  mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
					mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
					  .F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro/*aReturn[7]*/ )},;				
						OemToAnsi(OemToAnsi(STR0016)),;  //"Criando Arquivo Tempor rio..."
						  OemToAnsi(STR0004))  				//"Balanco Geral"				
	
		dbSelectArea("cArqTmp")
		dbGoTop()
		oPlcontas:SetMeter( RecCount() )
		cGrupoAnt := AllTrim(cArqTmp->GRUPO)
		
	EndIf

	oReport:NoUserFilter()

	oPlcontas:Init()
	
	// Verifica Se existe filtragem Ate o Segmento
	If !Empty(cSegAte)
		nDigitAte := CtbRelDig(cSegAte,cMascara) 	
	EndIf		
	
    While lImpLivro .And. !Eof()           
    
        If oPlcontas:Cancel()
	    	Exit
    	EndIf        

	    oPlcontas:IncMeter() 

		If fR150Fil(cSegAte, nDigitAte,cMascara)
			dbSkip()
			Loop
		EndIf
	    
    	oPlcontas:Printline()

		If lRedStorn
			nTotDeb += f150RSsum("D",cSegAte,lTotGSint)
			nGrpDeb += f150RSsum("D",cSegAte,lTotGSint)
			nTotCrd += f150RSsum("C",cSegAte,lTotGSint)
			nGrpCrd += f150RSsum("C",cSegAte,lTotGSint)
		Else
			nTotDeb += f150Soma("D",cSegAte,lTotGSint)
			nGrpDeb += f150Soma("D",cSegAte,lTotGSint)
			nTotCrd += f150Soma("C",cSegAte,lTotGSint)
			nGrpCrd += f150Soma("C",cSegAte,lTotGSint)
		EndIF
		
    	dbSkip()

   		If mv_par11 == 1 // mv_par11 - Quebra por Grupo Contabil? 
			If cGrupoAnt <> AllTrim(cArqTmp->GRUPO)

				oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0021) + cGrupoAnt + " )")
				oTotais:Cell( "TOT_DEBITO"	):SetBlock( { || ValorCTB(nGrpDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
				oTotais:Cell( "TOT_CREDITO"	):SetBlock( { || ValorCTB(nGrpCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )

				oTotais:Init()
					oTotais:PrintLine()
				oTotais:Finish()
				oReport:SkipLine()
				
				oReport:EndPage()
				
				nGrpDeb	:= 0
				nGrpCrd	:= 0		
				cGrupoAnt := AllTrim(cArqTmp->GRUPO)
			EndIf
		Else
			If cArqTmp->NIVEL1				// Sintetica de 1o. grupo
				oReport:EndPage()
			EndIf
		EndIf

	EndDo

	oPlcontas:Finish()

	If lImpLivro

		If Round(nTotDeb,nDecimais) != Round(nTotCrd,nDecimais)
	
			nDifer := Round(nTotDeb,nDecimais)-Round(nTotCrd,nDecimais)
			oTotais:Cell("TOT"):Hide()
			oTotais:Cell("TOT_DEBITO"):Hide()
	
			oTotais:Cell("TOT"):SetTitle("")
			oTotais:Cell("TOT_DEBITO"):SetTitle("")
			
			If nDifer > 0
				oTotais:Cell("TOT_CREDITO"):SetTitle(SUBS(STR0019,1,14))//"DEBITO A MAIOR:"
			ElseIf nDifer < 0
				oTotais:Cell("TOT_CREDITO"):SetTitle(SUBS(STR0020,1,15))//"CREDITO A MAIOR:"
			EndIF

			oTotais:Cell("TOT_CREDITO"):SetBlock( { || ValorCTB(Abs(nDifer),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) } )
			
			oTotais:Init()
				oTotais:PrintLine()
			oTotais:Finish()
	
		EndIf	
		
		oTotais:SetLineStyle(.F.)
		oTotais:Cell("TOT"):Show()                              
		oTotais:Cell("TOT_DEBITO"):Show()                              
		oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0022))//"T O T A I S : "

		If lRedStorn
			oTotais:Cell("TOT_DEBITO"):SetTitle("D E B I T O      ")
			oTotais:Cell("TOT_DEBITO"):SetBlock( { || ValorCTB(nTotDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
			oTotais:Cell("TOT_CREDITO"):SetTitle("C R E D I T O    ")
			oTotais:Cell("TOT_CREDITO"):SetBlock( { || ValorCTB(nTotCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
		Else
			oTotais:Cell("TOT_DEBITO"):SetTitle("D E B I T O      ")			
			oTotais:Cell("TOT_DEBITO"):SetBlock( { || ValorCTB(nTotDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) } )
			oTotais:Cell("TOT_CREDITO"):SetTitle("C R E D I T O    ")
			oTotais:Cell("TOT_CREDITO"):SetBlock( { || ValorCTB(nTotCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCONTA,,,,,,lPrintZero,.F.,lColDbCr) } )
		Endif	
	
		oTotais:Init()
			oTotais:PrintLine()
		oTotais:Finish()
			
		dbSelectArea("cArqTmp")
		   
		Set Filter To
		dbCloseArea()
		If Select("cArqTmp") == 0
			FErase(cArqTmp+GetDBExtension())
			FErase(cArqTmp+OrdBagExt())
		EndIF	
		dbselectArea("CT2")

	EndIf

If lImpTermos 							// Impressao dos Termos
	U_Ctr150Termos("CTR150", Limite, oReport)
Endif


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณf150Soma  บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR380                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function f150Soma(cTipo,cSegAte,lTotGSint)

Local nRetValor		:= 0
Local nValor		:= 0

	nValor := cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB

	If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1  
				If nValor < 0 .And. cTipo == "D"					
					nRetValor := Abs(nValor)
				ElseIf  nValor > 0 .And. cTipo == "C"					
					nRetValor := Abs(nValor)
				EndIf
		EndIf
	Else	// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel	
			If mv_par05 == 2		//Se imprime so as analiticas
				If cArqTmp->TIPOCONTA == "2"
					If nValor < 0 .And. cTipo == "D" 								
						nRetValor := Abs(nValor)
					ElseIf nValor > 0 .And. cTipo == "C" 								
						nRetValor := Abs(nValor)
					EndIf
				EndIf
			ElseIf mv_par05 == 3		//Se imprime as analiticas e sinteticas
				If lTotGSint		//Se totaliza pelas sinteticas
					If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1  
						If (nValor) < 0 .And. cTipo == "D"  					
							nRetValor := Abs(nValor)
						ElseIf  nValor > 0 .And. cTipo == "C"  					
							nRetValor := Abs(nValor)
						EndIf
					EndIf				
				Else				//Se totaliza pelas analiticas
					If cArqTmp->TIPOCONTA == "2"
						If (nValor) < 0 .And. cTipo == "D"
							nRetValor := Abs(nValor)
						ElseIf nValor > 0 .And. cTipo == "C" 
							nRetValor := Abs(nValor)
						EndIf
					EndIf
			    EndIf
			EndIf
		Else	//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1                                                       
				If nValor < 0 .And. cTipo == "D"
					nRetValor := Abs(nValor)
				ElseIf  nValor > 0 .And. cTipo == "C"
					nRetValor := Abs(nValor)
				EndIf
			EndIf
    	Endif
	EndIf

Return nRetValor                                                                         


//-------------------------------------------------------------------
/*{Protheus.doc} f150RSsum()

Totalize moviment value according to CT1->CT1_NORMAL if RedStorn 
is activated

@author Fabio Cazarini
   
@version P12
@since   11/05/2017
@return  nRetValor
@obs	 
*/
//-------------------------------------------------------------------
Static Function f150RSsum(cTipo,cSegAte,lTotGSint)
Local nRetValor		:= 0
Local nValor		:= 0

If cTipo == "D" .and. cArqTmp->NORMAL == "1" 
	nValor := cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR
Elseif cTipo == "C" .and. cArqTmp->NORMAL == "2" 
	nValor := cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB
Endif

If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
	If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1  
		nRetValor := nValor
	EndIf
Else	// Soma Analiticas
	If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel	
		If mv_par05 == 2		//Se imprime so as analiticas
			If cArqTmp->TIPOCONTA == "2"
				nRetValor := nValor
			EndIf
		ElseIf mv_par05 == 3		//Se imprime as analiticas e sinteticas
			If lTotGSint		//Se totaliza pelas sinteticas
				If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1  
					nRetValor := nValor
				EndIf				
			Else				//Se totaliza pelas analiticas
				If cArqTmp->TIPOCONTA == "2"
					nRetValor := nValor
				EndIf
		    EndIf
		EndIf
	Else	//Se tiver filtragem, somo somente as sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1                                                       
			nRetValor := nValor
		EndIf
	Endif
EndIf

Return nRetValor                                                                         


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfR150Fil  บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR150                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fR150Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa	:= .F.

	If mv_par05 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCONTA == "2"
			lDeixa := .T.
		EndIf
	ElseIf mv_par05 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCONTA == "1"
			lDeixa := .T.
		EndIf
	EndIf

	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
			lDeixa := .T.
		Endif
	EndIf
	If mv_par07 == 2						// Saldos Zerados nao serao impressos
		If ( cArqTmp->SALDOATUCR - cArqTmp->SALDOATUDB ) == 0
			lDeixa := .T.
		EndIf
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณ Fun…o	  ณCTR150Termosณ Autor ณ Wagner Mobile Costa | Data ณ 11/07/02 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Descri…o ณ Impressao dos termos dos balancos						   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Sintaxe   ณ U_CTR150Termos(cGrupo, Limite) 							   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Retorno   ณ Nenhum                         					  		   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		  ณ SIGACTB 												   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametros ณ cGrupo  - Nome do grupo de perguntas do SX1                ณฑฑ
ฑฑณ           ณ Limite  - Tamanho do formulario                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CTR150Termos(cGrupo, Limite, oReport)

Local cArqAbert:=GetMv("MV_LBALABE")
Local cArqEncer:=GetMv("MV_LBALFEC")
Local i
Local lObjAtivo := IIF(oReport <> nil,.T.,.F.)

dbSelectArea("SM0")
aVariaveis:={}
	
For i:=1 to FCount()	
	If FieldName(i)=="M0_CGC"
		AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R! NN.NNN.NNN/NNNN-99")})
	Else
		If FieldName(i)=="M0_NOME"
			Loop
		EndIf
		AADD(aVariaveis,{FieldName(i),FieldGet(i)})
	Endif
Next

dbSelectArea("SX1")
dbSeek( padr( cGrupo , Len( X1_GRUPO ) , ' ' ) + "01" )

While SX1->X1_GRUPO == padr( cGrupo , Len( X1_GRUPO ) , ' ' )
	AADD(aVariaveis,{Rtrim(Upper(X1_VAR01)),&(X1_VAR01)})
	dbSkip()
End

If !File(cArqAbert)
	aSavSet:=__SetSets()
	cArqAbert:=CFGX024(," Balano Geral.") // Editor de Termos de Livros
	__SetSets(aSavSet)
	Set(24,Set(24),.t.)
Endif

If !File(cArqEncer)
	aSavSet:=__SetSets()
	cArqEncer:=CFGX024(," Balano Geral.") // Editor de Termos de Livros
	__SetSets(aSavSet)
	Set(24,Set(24),.t.)
Endif

If lObjAtivo
	If cArqAbert#NIL
		oReport:EndPage()
		ImpTerm2(cArqAbert,aVariaveis,,,,oReport)
	Endif
	
	If cArqEncer#NIL
		oReport:EndPage()
		ImpTerm2(cArqEncer,aVariaveis,,,,oReport)
	Endif	 
Else
	If cArqAbert#NIL
		ImpTerm(cArqAbert,aVariaveis,AvalImp(Limite))
	Endif
	
	If cArqEncer#NIL
		ImpTerm(cArqEncer,aVariaveis,AvalImp(Limite))
	Endif	 
EndIf

Return
