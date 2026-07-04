/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR170.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR           23
#DEFINE	TAM_TOTAIS			17

// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณCTBR170	ณ Autor ณ Cicero J. Silva   	ณ Data ณ 03.08.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Balancete 6 Colunas                         	 		      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ U_CTBR170()    											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno	 ณ Nenhum       											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso 	     ณ Generico     											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum													  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function CTBR170()

Local aArea := GetArea()

Local oReport

Local aCtbMoeda	  := {}
Local lOk := .T.

PRIVATE cPerg	 	:= "CTR170" 
PRIVATE nomeProg	:= "CTBR170"
PRIVATE cTipoAnt	:= ""
PRIVATE aSelFil	:= {}

	If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
		lOk := .F. 
	EndIf
	
	Pergunte(cPerg,.T.) // Precisa ativar as perguntas antes das definicoes.
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
	//ณ Gerencial -> montagem especifica para impressao)				  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !U_ct170Valid(mv_par06)
		lOk := .F.
	Endif
	
	If lOk
		aCtbMoeda  	:= CtbMoeda(mv_par08)
		If Empty(aCtbMoeda[1])                       
	      Help(" ",1,"NOMOEDA")
	      lOk := .F.
	   Endif
	Endif
	
	If mv_par24 == 1 .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			lOk := .F.
		EndIf 
	EndIf
	
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
ฑฑณParametrosณ aCtbMoeda  - Matriz ref. a moeda                           ณฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ReportDef(aCtbMoeda)

Local oReport
Local oPlcontas
Local oTotais

Local cDesc1 	 := OemToAnsi(STR0001)	//"Este programa ira imprimir o Balancete de Verificacao de 6 colunas. As colunas"
Local cDesc2 	 := OemToansi(STR0002)	//"impressas sao conta, descricao, debito, credito, tambem saldo anterior e saldo"
Local cDesc3	 := OemToansi(STR0016)	//"atual do periodo que sao demonstrados separadamente a debito e a credito."
Local titulo 	 := OemToAnsi(STR0003)	//"Balancete de Verificacao"

Local aSetOfBook	:= CTBSetOf(mv_par06)
Local cSeparador	:= "" 
Local cMascara		:= IIf( Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSeparador))
Local cPicture		:= IIf( Empty(aSetOfBook[4]),PesqPict("CT2","CT2_VALOR"),aSetOfBook[4])
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)

Local lmov			:= Iif(mv_par16==1,.T.,.F.)	// Imprime Coluna Mov ?
Local lNormal		:= Iif(mv_par19==1,.T.,.F.)	// Imprimir Codigo? Normal / Reduzido
Local lPula			:= Iif(mv_par17==1,.T.,.F.)	// Salta linha sintetica ? 
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)	// Imprime valor 0.00    ?
Local cSegAte   	:= mv_par21						// Imprimir Ate o segmento?
Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local nTamGrupo		:= Len(CriaVar("CT1->CT1_GRUPO"))
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+mv_par08)) 
Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.) // Parameter to activate Red Storn


oReport := TReport():New(nomeProg,titulo,"CTR170",{|oReport| ReportPrint(oReport,aSetOfBook,aCtbMoeda,cMascara,cPicture,cSegAte,nDecimais)},cDesc1+cDesc2+cDesc3)
oReport:SetLandScape(.T.)
oReport:nFontBody := 4
// Sessao 1
oPlcontas := TRSection():New(oReport,STR0021,{"cArqTmp","CT1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)//"Periodos"
oPlcontas:SetTotalInLine(.F.)

TRCell():New(oPlcontas,"CONTA"		,"cArqTmp"	,STR0022		,/*Picture*/,aTamConta[1]	,/*lPixel*/,{|| IIF(cArqTmp->TIPOCONTA=="2","  ","")+EntidadeCTB(cArqTmp->CONTA ,0,0,70,.F.,cMascara,cSeparador,,,,,.F.) })// Codigo da Conta
TRCell():New(oPlcontas,"CTARES"		,"cArqTmp"	,STR0023		,/*Picture*/,aTamCtaRes[1]	,/*lPixel*/,{|| IIF(cArqTmp->TIPOCONTA=="2","  ","")+EntidadeCTB(cArqTmp->CTARES,0,0,70,.F.,cMascara,cSeparador,,,,,.F.) })// Codigo Reduzido da Conta
TRCell():New(oPlcontas,"DESCCTA"	,"cArqTmp"	,STR0024		,/*Picture*/,nTamCta		,/*lPixel*/,/*{|| }*/)// Descricao da Conta
TRCell():New(oPlcontas,"SLDANTDEB"	," "		,AnsiToOem(NoAcento(STR0025))		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| IIF(cArqTmp->SALDOANT < 0 .or. lRedStorn,ValorCTB(cArqTmp->SALDOANT,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr),IIF(cArqTmp->SALDOANT > 0 .and. !lRedStorn,ValorCTB(0,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr),ValorCTB(0,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)) )},"RIGHT",,"RIGHT" )// Saldo Anterior
TRCell():New(oPlcontas,"SLDANTCRD"	," "		,AnsiToOem(NoAcento(STR0026))		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| IIF(cArqTmp->SALDOANT < 0 .and. !lRedStorn,ValorCTB(0,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr),IIF(cArqTmp->SALDOANT > 0 .or. lRedStorn,ValorCTB(cArqTmp->SALDOANT,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr),ValorCTB(0,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)) )},"RIGHT",,"RIGHT" )// Saldo Anterior
TRCell():New(oPlcontas,"SALDODEB"	,"cArqTmp"	,AnsiToOem(NoAcento(STR0027))		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,2,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT" )// Debito
TRCell():New(oPlcontas,"SALDOCRD"	,"cArqTmp"	,AnsiToOem(NoAcento(STR0028))		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,2,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT" )// Credito
TRCell():New(oPlcontas,"MOVIMENTO"	,"cArqTmp"	,STR0029					,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,2,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT" )// Movimento do Periodo

If lRedStorn
	TRCell():New(oPlcontas,"SLDATUDEB"	," "		,NoAcento(AnsiToOem(STR0030))		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(Iif(cArqTmp->NORMAL=="1",cArqTmp->SALDOATU,0),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr,lCharSinal) },"RIGHT",,"RIGHT")// Saldo Atual
	TRCell():New(oPlcontas,"SLDATUCRD"	," "		,NoAcento(AnsiToOem(STR0031))		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(Iif(cArqTmp->NORMAL=="2",cArqTmp->SALDOATU,0),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr,lCharSinal) },"RIGHT",,"RIGHT")// Saldo Atual
Else
	TRCell():New(oPlcontas,"SLDATUDEB"	," "		,AnsiToOem(NoAcento(STR0030))		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| IIF(cArqTmp->SALDOATU < 0,ValorCTB(cArqTmp->SALDOATU,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.),IIF(cArqTmp->SALDOATU > 0,ValorCTB(0,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.),ValorCTB(0,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)) )},"RIGHT",,"RIGHT")// Saldo Atual
	TRCell():New(oPlcontas,"SLDATUCRD"	," "		,AnsiToOem(NoAcento(STR0031))		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| IIF(cArqTmp->SALDOATU < 0,ValorCTB(0,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.),IIF(cArqTmp->SALDOATU > 0,ValorCTB(cArqTmp->SALDOATU,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.),ValorCTB(0,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)) )},"RIGHT",,"RIGHT")// Saldo Atual
Endif

TRCell():New(oPlcontas,"NORMAL"		,"cArqTmp"	,STR0032		,/*Picture*/,01				,/*lPixel*/,/*{|| }*/)// Situacao
TRCell():New(oPlcontas,"TIPOCONTA"	,"cArqTmp"	,STR0033		,/*Picture*/,01				,/*lPixel*/,/*{|| }*/)// Conta Analitica / Sintetica           
TRCell():New(oPlcontas,"GRUPO"		,"cArqTmp"	,STR0034		,/*Picture*/,nTamGrupo		,/*lPixel*/,/*{|| }*/)// Grupo Contabil
TRCell():New(oPlcontas,"NIVEL1"		,"cArqTmp"	,STR0035		,/*Picture*/,01				,/*lPixel*/,/*{|| }*/)// Logico para identificar se 

oPlcontas:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),; // mv_par17	-	Salta linha sintetica ?
								 cTipoAnt := cArqTmp->TIPOCONTA;
							)  })

TRPosition():New( oPlcontas, "CT1", 1, {|| xFilial("CT1") + cArqTMP->CONTA })

oPlcontas:Cell("NORMAL"   ):Disable()
oPlcontas:Cell("TIPOCONTA"):Disable()
oPlcontas:Cell("GRUPO"    ):Disable()
oPlcontas:Cell("NIVEL1"   ):Disable()

If lNormal
	oPlcontas:Cell("CTARES"):Disable()
Else
	oPlcontas:Cell("CONTA" ):Disable()
EndIf

If !lMov
	oPlcontas:Cell("MOVIMENTO"):Disable()
EndIf

oPlcontas:SetHeaderPage()

oTotais := TRSection():New( oReport,STR0036,,, .F., .F. ) //"Total"
TRCell():New( oTotais, "TOT"				,,""						,/*Picture*/,aTamConta[1]+nTamCta,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais, "TOT_DEBITO"		,,AnsiToOem(NoAcento(STR0037)),/*Picture*/,TAM_TOTAIS+3,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais, "TOT_CREDITO"	,,AnsiToOem(NoAcento(STR0038)),/*Picture*/,TAM_TOTAIS+3,/*lPixel*/,/*{|| code-block de impressao }*/)

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
Static Function ReportPrint(oReport,aSetOfBook,aCtbMoeda,cMascara,cPicture,cSegAte,nDecimais)

Local oPlcontas		:= oReport:Section(1)
Local oTotais	 	:= oReport:Section(2)  

Local cArqTmp
Local cFiltro		:= oPlcontas:GetAdvPlExp('CT1') 
Local lImpAntLP		:= Iif(mv_par22 == 1,.T.,.F.)	// Posicao Ant. L/P? Sim / Nao
Local dDataLP		:= mv_par23						// Data Lucros/Perdas?
Local lVlrZerado	:= Iif(mv_par07==1,.T.,.F.)	// Saldos Zerados?
Local dDataFim	 	:= mv_par02							// Data Final
Local lImpSint		:= Iif(mv_par05=1 .Or. mv_par05 ==3,.T.,.F.)
Local nDivide		:= mv_par20
Local cDescMoeda 	:= Alltrim(aCtbMoeda[2])
Local l132			:= .T.
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)	// Imprime valor 0.00    ?
Local nDigitate		:= 0
Local nTotDeb		:= 0
Local nGrpDeb		:= 0
Local nTotCrd		:= 0
Local nGrpCrd		:= 0
Local lNImpMov		:= Iif(mv_par16==1,.F.,.T.)

Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Carrega titulo do relatorio: Analitico / Sintetico			  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF mv_par05 == 1      
		Titulo := STR0009  //"BALANCETE CONVERSAO MOEDAS SINTETICO DE "
	ElseIf mv_par05 == 2
		Titulo := STR0006  //"BALANCETE CONVERSAO MOEDAS SINTETICO DE "
	ElseIf mv_par05 == 3
		Titulo := STR0017  //"BALANCETE CONVERSAO MOEDAS DE "
	EndIf
	Titulo += 	DTOC(mv_par01) + OemToAnsi(STR0007) + Dtoc(mv_par02) + ;
					OemToAnsi(STR0008) + cDescMoeda
	
	If mv_par10 > "1"
		Titulo += " (" + Tabela("SL", mv_par10, .F.) + ")"
	EndIf
		
	If mv_par20 == 2			// Divide por cem
		nDivide := 100
	ElseIf mv_par20 == 3		// Divide por mil
		nDivide := 1000
	ElseIf mv_par20 == 4		// Divide por milhao
		nDivide := 1000000
	EndIf
		
	oReport:SetTitle(Titulo)
	oReport:SetPageNumber(mv_par09)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta Arquivo Temporario para Impressao					     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			 mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
			  mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
			   lNImpMov,.F.,mv_par11,,lImpAntLP,dDataLP, nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro /*aReturn[7]*/,,,,,,,,,,,,aSelFil)},;				
				OemToAnsi(OemToAnsi(STR0015)),;  //"Criando Arquivo Tempor rio..."
				 OemToAnsi(STR0003))  				//"Balancete Verificacao"
	
	
	dbSelectArea("cArqTmp")
	dbGoTop()

	oPlcontas:SetMeter( RecCount() )
	cGrupoAnt := AllTrim(cArqTmp->GRUPO)

	oPlcontas:NoUserFilter()

	oPlcontas:Init()
   While !Eof()           

      If oPlcontas:Cancel()
	    	Exit
    	EndIf        

	    oPlcontas:IncMeter() 

		If R170Fil(cSegAte, nDigitAte,cMascara)
			dbSkip()
			Loop
		EndIf

    	oPlcontas:Printline()

		nTotDeb += R170Soma("D",cSegAte)
		nGrpDeb += R170Soma("D",cSegAte)
		nTotCrd += R170Soma("C",cSegAte)
		nGrpCrd += R170Soma("C",cSegAte)

    	dbSkip()

   		If mv_par11 == 1 // mv_par11 - Quebra por Grupo Contabil? 
			If cGrupoAnt <> AllTrim(cArqTmp->GRUPO)

				oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0020) + cGrupoAnt + " )")
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

	oTotais:Cell("TOT"):SetTitle(OemToAnsi(STR0011))  		// T O T A I S  D O  P E R I O D O:
	oTotais:Cell("TOT_DEBITO"):SetBlock( { || ValorCTB(nTotDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
	oTotais:Cell("TOT_CREDITO"):SetBlock( { || ValorCTB(nTotCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
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

Return                                                                          
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณR170Soma  บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR045                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R170Soma(cTipo,cSegAte)

Local nRetValor := 0

	If mv_par05 == 1	// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1            
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		EndIf
	Else	// Soma Analiticas
		If Empty(cSegAte)	//Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOCONTA == "2"
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf	
    	Endif			
	EndIf

Return nRetValor                                                                         
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณR170Fil   บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR170                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function R170Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa := .F.

	If mv_par05 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCONTA == "2"
			lDeixa := .T.
		EndIf
	ElseIf mv_par05 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCONTA == "1"
			lDeixa := .T.
		EndIf
	EndIf                
	
	If mv_par07 == 2	// Saldos Zerados nao serao impressos
		If (Abs(cArqTmp->SALDOANT)+Abs(cArqTmp->SALDOATU)+Abs(cArqTmp->SALDODEB)+Abs(cArqTmp->SALDOCRD)) == 0
			lDeixa := .T.
		EndIf
	EndIf

	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		// Verifica Se existe filtragem Ate o Segmento
		nDigitAte := CtbRelDig(cSegAte,cMascara) 	

		If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
			lDeixa := .T.
		Endif
	EndIf

//dbSelectArea("cArqTmp")

Return (lDeixa)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณProgram   ณCT170Validณ Autor ณ Pilar S. / Gustavo H. ณ Data ณ 23.08.01 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Valida Perguntas                                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ U_ct170Valid(cSetOfBook)                                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ .T./.F.                                                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ generico                                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Expc1 = Codigo do Set of Book                              ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Ct170Valid(cSetOfBook)
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