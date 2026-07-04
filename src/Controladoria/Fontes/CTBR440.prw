/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR440.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR  20
#DEFINE TAM_CONTA  20

Static _cAliQry := NIL
Static _aChvLct := NIL
Static _aSelFil := NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณ CTBR440  ณ Autor ณ Cicero J. Silva   	ณ Data ณ 04.08.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Razao Centro de Custo/Conta          			 		  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ U_CTBR440()    											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno	 ณ Nenhum       											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso 		 ณ SIGACTB      											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum													  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTBR440(cCustoIni, cCustoFim, dDataIni, dDataFim, cMoeda, cSaldo,;
			cBook, cContaIni, cContaFim, lItem, cItemIni, cItemFim, lCLVL,;
			cCLVLIni, cCLVLFim,lSalLin,aSelFil)

Local aArea := GetArea()
Local aCtbMoeda		:= {}

Local lOk := .T.
Local lExterno		:= cContaIni <> Nil
Local lSchedule		:= IsBlind()
Local lTodasFil 	:= .F.

Default lItem		:= .F.
Default lCLVL		:= .F.
Default lSalLin		:= .T.
Default aSelFil	:= {}

Private cPerg	 	:= "CTR440"
Private nomeProg  	:= "CTBR440"
Private nSldTransp	:= 0 // Esta variavel eh utilizada para calcular o valor de transporte
Private lSaltLin	:= .T.
Private nTamFilial 	:= Len(CT2->CT2_FILIAL)
Private lAutomR440  := FWIsInCallStack("UTSTARTRPT") .And. cPerg == "CTR440" //Controle de Automa็ใo
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01            // do Centro de Custo                    ณ
//ณ mv_par02            // Ate Centro de Custo                   ณ
//ณ mv_par03            // da data                               ณ
//ณ mv_par04            // Ate a data                            ณ
//ณ mv_par05            // Moeda			                     ณ
//ณ mv_par06            // Saldos		                         ณ
//ณ mv_par07            // Set Of Books                          ณ
//ณ mv_par08            // Analitico ou Resumido dia (resumo)    ณ
//ณ mv_par09            // Imprime conta sem movimento?          ณ
//ณ mv_par10            // Imprime Cod (Normal / Reduzida)       ณ
//ณ mv_par11            // Totaliza tb por Conta?                ณ
//ณ mv_par12            // Da Conta                              ณ
//ณ mv_par13            // Ate a Conta                           ณ
//ณ mv_par14            // Imprime Item?	                     ณ
//ณ mv_par15            // Do Item                               ณ
//ณ mv_par16            // Ate Item                              ณ
//ณ mv_par17            // Imprime Classe de Valor?              ณ
//ณ mv_par18            // Da Classe de Valor                    ณ
//ณ mv_par19            // Ate a Classe de Valor                 ณ
//ณ mv_par20            // Salta folha por c.c.?                 ณ
//ณ mv_par21            // Pagina Inicial                        ณ
//ณ mv_par22            // Pagina Final                          ณ
//ณ mv_par23            // Numero da Pag p/ Reiniciar            ณ
//ณ mv_par24            // Imprime Cod. CCusto(Normal/Reduzido)  ณ
//ณ mv_par25            // Imprime Cod. Item (Normal/Reduzido)   ณ
//ณ mv_par26            // Imprime Cod. Cl.Valor(Normal/Reduzido)ณ
//ณ mv_par27            // Imprime Valor 0.00					 ณ
//ณ mv_par28            // Salta linha            				 ณ
//ณ mv_par29            // Seleciona filiais ?				     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

_cAliQry := NIL
_aChvLct := NIL

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	lOk := .F.
EndIf

If !lExterno .And. lOk .AND. !lAutomR440
	If ! Pergunte(cPerg, .T.)
		lOk := .F.
	Endif
	// Se aFil nao foi enviada, exibe tela para selecao das filiais
	If lOk .And. mv_par29 == 1 .And. Len( aSelFil ) <= 0
		If !IsBlind()
			aSelFil := AdmGetFil(@lTodasFil)
		EndIf
		If Len( aSelFil ) <= 0
			lOk := .F.
		EndIf
	EndIf
Else
	Pergunte(cPerg, .F.)
Endif


If lOk
	//Verifica se o relatorio foi chamado a partir de outro programa. Ex. CTBC400
	If !lExterno
		lItem		:= Iif(mv_par14 == 1,.T.,.F.)
		lCLVL		:= Iif(mv_par17 == 1,.T.,.F.)
	Else  //Caso seja externo, atualiza os parametros do relatorio com os dados passados como parametros.
		mv_par01 := cCustoIni
		mv_par02 := cCustoFim
		mv_par03 := dDataIni
		mv_par04 := dDataFim
		mv_par05 := cMoeda
		mv_par06 := cSaldo
		mv_par07 := cBook
		mv_par12 := cContaIni
		mv_par13 := cContaFim
		mv_par14 := If(lItem, 1, 2)
		mv_par15 := cItemIni
		mv_par16 := cItemFim
		mv_par17 := If(lClVl, 1, 2)
		mv_par18 := cClVlIni
		mv_par19 := cClVlFim
		MV_PAR28 := Iif(lSalLin == .T.,1,2)
	Endif

	aCtbMoeda  	:= CtbMoeda(mv_par05) // Moeda?

	If Empty(aCtbMoeda[1])
    	Help(" ",1,"NOMOEDA")
		lOk := .F.
	Endif
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
//ณ Gerencial -> montagem especifica para impressao)			 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If ! Empty( mv_par07 )
	If ! VdSetOfBook( mv_par07 , .F. )
		lOk := .F.
	Endif
Endif

If lOk
	CTBR440R4(aCtbMoeda,lItem,lCLVL,aSelFil,lTodasFil)
EndIf

If Select("cArqTmp") > 0
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
EndIf

//Limpa os arquivos temporแrios
CtbRazClean()

_cAliQry := NIL
_aChvLct := NIL
_aSelFil := NIL

RestArea(aArea)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ CTBR440R4 บ Autor ณ                    บ Data ณ  15/09/09  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณImpressao do relatorio em R4                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGACTB                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTBR440R4(aCtbMoeda,lItem,lCLVL,aSelFil,lTodasFil)
Local oReport := Nil

oReport := ReportDef(aCtbMoeda,lItem,lCLVL,aSelFil,lTodasFil)
oReport:PrintDialog()
oReport := Nil

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ ReportDef บ Autor ณ Cicero J. Silva    บ Data ณ  01/08/06  บฑฑ
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
Static Function ReportDef(aCtbMoeda,lItem,lCLVL,aSelFil,lTodasFil)

Local oReport
Local oSection1
Local oSection2
Local oSection3

Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")

Local cDesc1		:= STR0001+Alltrim(cSayCusto) 	//"Este programa ir  imprimir o Razao Contabil por "
Local cDesc2		:= STR0002	//"de Custo de acordo com os parametros solicitados"
Local cDesc3		:= STR0003	//"pelo usuario"
Local titulo		:= STR0006 + Alltrim(cSayCusto)	//"Emissao do Razao Contabil por Centro de Custo"

Local lAnalitico	:= Iif(mv_par08==1,.T.,.F.)// Analitico ou Resumido dia (resumo)
Local lPrintZero	:= IIf(mv_par27==1,.T.,.F.)// Imprime valor 0.00    ?
Local lSalto		:= Iif(mv_par20==1,.T.,.F.)// Salto de pagina                       ณ

Local aSetOfBook := CTBSetOf(mv_par07)// Set Of Books

Local cSepara1		:= ""
Local cSepara2		:= ""
Local cSepara3		:= ""
Local cSepara4		:= ""

// Mascara da Conta
Local cMascara1 := IIf ( Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara1) )
// Mascara do Centro de Custo
Local cMascara2 := IIf ( Empty(aSetOfBook[6]),GetMv("MV_MASCCUS"),RetMasCtb(aSetOfBook[6],@cSepara2) )
// Mascara do Item Contabil
Local cMascara3 := IIf ( lItem .And. Empty(aSetOfBook[7]), GetMv("MV_MASCCTD"), RetMasCtb(aSetOfBook[7],@cSepara3) )
// Mascara da Classe de Valor
Local cMascara4 := IIf ( lCLVL .And. Empty(aSetOfBook[8]), GetMv("MV_MASCCTH"), RetMasCtb(aSetOfBook[8],@cSepara4) )

Local aTamCusto	:= TAMSX3("CT3_CUSTO")
Local nTamConta	:= 5 + U_TamCpoMask( "CT1_CONTA" , cMascara1 ) // Len(CriaVar("CT1_CONTA"))
Local nTamCusto	:= 5 + U_TamCpoMask( "CT3_CUSTO" , cMascara2 ) // Len(CriaVar("CT3_CUSTO"))
Local nTamItem	:= 5 + U_TamCpoMask( "CTD_ITEM"  , cMascara3 ) // Len(CriaVar("CTD_ITEM"))
Local nTamCLVL	:= 5 + U_TamCpoMask( "CTH_CLVL"  , cMascara4 ) // Len(CriaVar("CTH_CLVL"))

Local nTamHist	:= 50 // chumbo o tamanho do historico para nใo dar problema na impressใo do relatorio

Local cPicture 		:= aSetOfBook[4]
Local cDescMoeda 	:= aCtbMoeda[2]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par05)// Moeda


oReport := TReport():New(nomeProg,titulo,cPerg, {|oReport| ;//			Pergunte(cPerg,.F.),;
			Iif( ReportPrint(oReport,aCtbMoeda,aSetOfBook,cPicture,cDescMoeda,nDecimais,nTamConta,lAnalitico,lItem,lCLVL,aSelFil,lTodasFil), .T., oReport:CancelPrint())},cDesc1+cDesc2+cDesc3)

oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)

IF GETNEWPAR("MV_CTBPOFF",.T.)
	oReport:SetEdit(.F.)
ENDIF

If lAnalitico
	oReport:SetLandScape(.T.)
	oReport:lDisableOrientation := .T.  // Desabilita a altera็ใo da orienta็ใo do papel, evitando desalinhamento por falta de espa็o
Else
	oReport:SetPortrait(.T.)
EndIf

// oSection1
oSection1 := TRSection():New(oReport,STR0028,{"cArqTmp"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	//"Conta"

If lSalto
	oSection1:SetPageBreak(.T.)
EndIf

TRCell():New(oSection1,"CUSTO"		,"cArqTmp",Upper(STR0028),/*Picture*/,nTamCusto + 5 ,/*lPixel*/,/*{|| }*/)
TRCell():New(oSection1,"DESCCC"	    ,""		  ,,/*Picture*/,70 + nTamconta + nTamItem + nTamCLVL + (TAM_VALOR * 2) - nTamCusto,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,.T.,/*"RIGHT"*/,,,.T.)	//"DESCRICAO"
TRCell():New(oSection1,"TPSLDANT"	,""       ,STR0026,/*Picture*/, TAM_VALOR+12	,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// Sinal do Saldo Atual => Consulta Razao	 ### "SALDO ATERIOR"

oSection1:Cell("DESCCC"):HideHeader()
oSection1:Cell("TPSLDANT"):lHeaderSize	:= .F.

// oSection2
oSection2 := TRSection():New(oSection1,STR0027,{"cArqTmp","CT2"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	// Custo
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage(.T.)

TRCell():New(oSection2,"CONTA"		,"cArqTmp", STR0039			,/*Picture*/ ,nTamConta + 5 ,/*lPixel*/,/*{|| }*/)
TRCell():New(oSection2,"DESCCON"    ,""		  , STR0040			,/*Picture*/ ,70 + nTamconta + nTamItem + nTamCLVL + (TAM_VALOR * 2) - nTamCusto,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,.T.,/*"RIGHT"*/,,,.T.)	//"DESCRICAO"
TRCell():New(oSection2,"DATAL"		,"cArqTmp" ,STR0019			,/*Picture*/ ,10		    ,/*lPixel*/ ,/*{|| }*/)// Data do Lancamento
TRCell():New(oSection2,"DOCUMENTO"	,""        ,STR0029			,/*Picture*/ ,20			,/*lPixel*/ ,{|| cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA })//"LOTE/SUB/DOC/LINHA"
TRCell():New(oSection2,"FILIAL"		,""        ,"FL"			,/*Picture*/ ,nTamFilial	,/*lPixel*/ ,{|| cArqTmp->FILIAL})//"FILIAL"
TRCell():New(oSection2,"HISTORICO"	,"cArqTmp" ,STR0030			,/*Picture*/ ,nTamHist		,/*lPixel*/ ,{||Alltrim(cArqTmp->HISTORICO)+Space(1)+ImpCompl() },/*"LEFT"*/,.T.,"LEFT",.T.,,.F.)// "HISTORICO"
If lAnalitico
	TRCell():New(oSection2,"XPARTIDA"	,"cArqTmp" ,STR0031			,/*Picture*/ ,nTamConta 	,/*lPixel*/ ,/*{|| }*/)// Contra Partida
	TRCell():New(oSection2,"ITEM"		,"cArqTmp" ,Upper(cSayItem) ,/*Picture*/ ,nTamItem  	,/*lPixel*/ ,/*{|| }*/)// Item Contabil
	TRCell():New(oSection2,"CLVL"		,"cArqTmp" ,Upper(cSayClVl) ,/*Picture*/ ,nTamCLVL  	,/*lPixel*/ ,/*{|| }*/)// Classe de Valor
EndIf
TRCell():New(oSection2,"LANCDEB"	,"cArqTmp" ,STR0032			,/*Picture*/ ,TAM_VALOR		,/*lPixel*/ ,{|| ValorCTB(cArqTmp->LANCDEB,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },"RIGHT",,"RIGHT")// Debito
TRCell():New(oSection2,"LANCCRD"	,"cArqTmp" ,STR0033			,/*Picture*/ ,TAM_VALOR		,/*lPixel*/ ,{|| ValorCTB(cArqTmp->LANCCRD,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },"RIGHT",,"RIGHT")// Credito
TRCell():New(oSection2,"TPSLDATU"	,"cArqTmp" ,STR0034			,/*Picture*/ ,TAM_VALOR+12  ,/*lPixel*/ ,/*{|| }*/,"RIGHT",,"RIGHT")// Sinal do Saldo Atual => Consulta Razao ### SALDO ATUAL

oSection2:Cell("LANCDEB"	):lHeaderSize	:= .F.
oSection2:Cell("LANCCRD"	):lHeaderSize	:= .F.
oSection2:Cell("TPSLDATU"	):lHeaderSize	:= .F.

If lAnalitico
	If !lItem
		oSection2:Cell("ITEM"	):Hide()
		oSection2:Cell("ITEM"	):HideHeader()
	EndIf
	If !lCLVL
		oSection2:Cell("CLVL"	):Hide()
		oSection2:Cell("CLVL"	):HideHeader()
	EndIf

Else // Resumido
	oSection2:Cell("DOCUMENTO"	):Hide()
	oSection2:Cell("DOCUMENTO"	):HideHeader()
	//oSection2:Cell("XPARTIDA"	):Hide()
	//oSection2:Cell("XPARTIDA"	):HideHeader()
	//oSection2:Cell("ITEM"		):Hide()
	//oSection2:Cell("ITEM"		):HideHeader()
	//oSection2:Cell("CLVL"		):Hide()
	//oSection2:Cell("CLVL"		):HideHeader()	
	oSection2:Cell("HISTORICO"	):Hide()
	oSection2:Cell("HISTORICO"	):HideHeader()
EndIf

oSection2:Cell("DATAL"		):lHeaderSize	:= .F.
oSection2:Cell("DOCUMENTO"	):lHeaderSize	:= .F.
oSection2:Cell("FILIAL"		):lHeaderSize	:= .F.
oSection2:Cell("HISTORICO"	):lHeaderSize	:= .F.

If lAnalitico
	oSection2:Cell("XPARTIDA"	):lHeaderSize	:= .F.
	oSection2:Cell("ITEM"		):lHeaderSize	:= .F.
	oSection2:Cell("CLVL"		):lHeaderSize	:= .F.
EndIf
// oSection3 - Totais das sessoes
oSection3 := TRSection():New( oSection1,STR0035,,, .F., .F. )	// Total


TRCell():New(oSection3,"DATAL"		,"cArqTmp" 	,STR0019		,/*Picture*/ , 10	    	,/*lPixel*/ ,/*{|| }*/)// Data do Lancamento
TRCell():New(oSection3,"DOCUMENTO"	,"" 		,STR0029		,/*Picture*/ , 20			,/*lPixel*/,{|| "" })
TRCell():New(oSection3,"FILIAL"		,"" 		,""				,/*Picture*/ , nTamFilial	,/*lPixel*/,{|| "" })
TRCell():New(oSection3,"HISTORICO"	,"cArqTmp" 	,STR0030		,/*Picture*/ , nTamHist		,/*lPixel*/,{|| "" },/*"LEFT"*/,.T.,"LEFT",.T.,,.F.)// "HISTORICO"
If lAnalitico
	TRCell():New(oSection3,"XPARTIDA"	,"cArqTmp" 	,STR0031		,/*Picture*/ 	, nTamConta		,/*lPixel*/,{|| "" })	
	TRCell():New(oSection3,"ITEM"		,"cArqTmp" 	,Upper(cSayItem),/*Picture*/ 	, nTamItem  	,/*lPixel*/,{|| "" })// Item Contabil
	TRCell():New(oSection3,"CLVL"		,"cArqTmp"  ,"" 			,/*Picture*/	, nTamCLVL  	,/*lPixel*/,{|| "" })// Classe de Valor
EndIf
TRCell():New(oSection3,"TOT_DEBITO"	,""			,STR0032 		,/*Picture*/ , TAM_VALOR		,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")	//"CREDITO
TRCell():New(oSection3,"TOT_CREDITO","" 		,STR0033 		,/*Picture*/ , TAM_VALOR		,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")	//"DEBITO"
TRCell():New(oSection3,"TOT_ATU"	,"" 		,STR0034 		,/*Picture*/ , TAM_VALOR+12	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")	// "SALDO ATUAL"


oSection3:Cell( "DATAL"			):Hide()
oSection3:Cell( "DATAL"			):HideHeader()
oSection3:Cell( "DOCUMENTO"		):Hide()
oSection3:Cell( "DOCUMENTO"		):HideHeader()
oSection3:Cell( "FILIAL"		):Hide()
oSection3:Cell( "FILIAL"		):HideHeader()

oSection3:Cell( "HISTORICO"		):HideHeader()

If lAnalitico
	oSection3:Cell( "XPARTIDA"		):Hide()
	oSection3:Cell( "XPARTIDA"		):HideHeader()
	oSection3:Cell( "ITEM"			):Hide()
	oSection3:Cell( "ITEM"			):HideHeader()
	oSection3:Cell( "CLVL"			):Hide()
	oSection3:Cell( "CLVL"			):HideHeader()
EndIf
oSection3:Cell( "TOT_DEBITO"	):HideHeader()
oSection3:Cell( "TOT_CREDITO"	):HideHeader()
oSection3:Cell( "TOT_ATU"		):HideHeader()

oSection3:Cell("TOT_DEBITO"	):lHeaderSize	:= .F.
oSection3:Cell("TOT_CREDITO"):lHeaderSize	:= .F.
oSection3:Cell("TOT_ATU"	):lHeaderSize	:= .F.

oSection1:SetEdit(.F.)
oSection2:SetEdit(.F.)
oSection3:SetEdit(.F.)

oReport:ParamReadOnly()

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
Static Function ReportPrint(oReport,aCtbMoeda,aSetOfBook,cPicture,cDescMoeda,nDecimais,nTamConta,lAnalitico,lItem,lCLVL,aSelFil,lTodasFil)

Local oSection1 	:= oReport:Section(1)
Local oSection2		:= oReport:Section(1):Section(1)
Local oSection3		:= oReport:Section(1):Section(2)

Local cArqTmp		:= ""
Local cFiltro		:= oSection2:GetAdvplExp()

Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")

Local aSaldo		:= {}
Local aSaldoAnt		:= {}

Local cContaIni		:= mv_par12 // da conta
Local cContaFIm		:= mv_par13 // ate a conta
Local cMoeda		:= mv_par05 // Moeda
Local cSaldo		:= mv_par06 // Saldos
Local cCustoIni		:= mv_par01 // Do Centro de Custo
Local cCustoFim		:= mv_par02 // At o Centro de Custo
Local cItemIni		:= mv_par15 // Do Item
Local cItemFim		:= mv_par16 // Ate Item
Local cCLVLIni		:= mv_par18 // Imprime Classe de Valor?
Local cCLVLFim		:= mv_par19 // Ate a Classe de Valor
Local lSalLin		:= IIf(MV_PAR28==1,.T.,.F.)//"Salta linha entre contas?"
Local cContaAnt		:= ""
Local cCodRes		:= ""
Local cResCC		:= ""
Local cResItem		:= ""
Local cResCLVL		:= ""

Local cConta		:= ""
Local cCtaAux		:= ""

Local cSepara1		:= ""
Local cSepara2		:= ""
Local cSepara3		:= ""
Local cSepara4		:= ""
// Mascara da Conta
Local cMascara1 := IIf (Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara1) )
// Mascara do Centro de Custo
Local cMascara2 := IIf ( Empty(aSetOfBook[6]),GetMv("MV_MASCCUS"),RetMasCtb(aSetOfBook[6],@cSepara2) )
// Mascara do Item Contabil
Local cMascara3 := IIf ( lItem .And. Empty(aSetOfBook[7]), GetMv("MV_MASCCTD") , RetMasCtb(aSetOfBook[7],@cSepara3) )
// Mascara da Classe de Valor
Local cMascara4 := IIf ( lCLVL .And. Empty(aSetOfBook[8]), GetMv("MV_MASCCTH") , RetMasCtb(aSetOfBook[8],@cSepara4) )

Local dDataAnt		:= CTOD("  /  /  ")
Local dDataIni		:= mv_par03 // da data
Local dDataFim		:= mv_par04 // Ate a data

Local nReinicia 	:= mv_par23 // Numero da Pag p/ Reiniciar
Local nPagFim		:= mv_par22 // Pagina Final
Local nTamCusto:= Len(CriaVar("CTT->CTT_DESC"+mv_par05))

Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nVlrDeb		:= 0
Local nVlrCrd		:= 0
Local nTotCtaDeb	:= 0
Local nTotCtaCrd	:= 0

Local lCtaCpo		:= oReport:nDevice == 4 .And. oReport:lXlsTable
Local lNoMov		:= Iif(mv_par09==1,.T.,.F.) // Imprime conta sem movimento?
Local lPrintZero	:= Iif(mv_par27==1,.T.,.F.) // Imprime valor 0.00    ?
Local lEmissUnica	:= If(GetNewPar("MV_CTBQBPG","M") == "M",.T.,.F.)			/// U=Quebra ๚nica (.F.) ; M=Multiplas quebras (.T.)
Local lOk			:= .T.
Local cNormal 		:= ""

Local nTamItem	:= 5 + U_TamCpoMask( "CTD_ITEM"  , cMascara3 ) // Len(CriaVar("CTD_ITEM"))
Local nTamCLVL	:= 5 + U_TamCpoMask( "CTH_CLVL"  , cMascara4 ) // Len(CriaVar("CTH_CLVL"))
Local nTamHist	:= 50 // chumbo o tamanho do historico para nใo dar problema na impressใo do relatorio

Local cFilOld := cFilAnt
Local cArq
Local nX
Local cFil := ""
Local cFilRazao,cFilAuxStr
Local cDescCT1 := ""

_aSelFil := aClone(aSelFil)

If !lCtaCpo
	oSection2:Cell("CONTA"	):Disable()
	oSection2:Cell("DESCCON"):Disable()
EndIf 
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTitulo do Relatorio                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Type("NewHead")== "U"
	Titulo	:=	STR0007	+ Upper(Alltrim(cSayCusto))//"RAZAO POR "
	IF lAnalitico
		Titulo	+=  STR0008 	//"ANALITICO EM"
	Else
		Titulo	+=	STR0014		//"SINTETICO EM"
	EndIf
	Titulo += 	AllTrim(cDescMoeda) + space(01)+STR0009 + space(01)+DTOC(dDataIni) +;	// "DE"
				space(01)+STR0010 + space(01)+ DTOC(dDataFim)						// "ATE"

	If mv_par06 > "1"
		Titulo += " (" + Tabela("SL", mv_par06, .F.) + ")"
	EndIf
Else
	Titulo := NewHead
EndIf

oReport:SetTitle(Titulo)
oReport:SetPageNumber(mv_par21) //mv_par21	-	Pagina Inicial
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

If lAnalitico
	If !lItem
		oSection2:Cell("ITEM"):Hide()
		oSection2:Cell("ITEM"):HideHeader()
		oSection2:Cell("ITEM"):SetBlock( { || " " } )

	EndIf
	If !lCLVL
		oSection2:Cell("CLVL"):Hide()
		oSection2:Cell("CLVL"):HideHeader()
		oSection2:Cell("CLVL"):SetBlock( { || " " } )
	EndIf
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao							  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If (IsBlind())
	CTBGerRaz(, , , , @cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
								cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
								aSetOfBook,lNoMov,cSaldo,.t.,"2",lAnalitico,,,cFiltro,,aSelFil, .T.)
Else
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
					CTBGerRaz(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
								cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
								aSetOfBook,lNoMov,cSaldo,.t.,"2",lAnalitico,,,cFiltro,,aSelFil, .T.)},;
					STR0018,;		// "Criando Arquivo Temporario..."
					STR0006 + Alltrim(cSayCusto))						// "Emissao do Razao"
EndIf

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()
oReport:SetMeter( RecCount() )
oReport:NoUserFilter()

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial
//nao esta disponivel e sai da rotina.
lOk := !(cArqTmp->(RecCount()) == 0 .And. !Empty(aSetOfBook[5]))
If lOk
	While !cArqTmp->(Eof() .And. !oReport:Cancel())

		If cArqTmp->FILORI <> cFilAnt
			cFilAnt := cArqTmp->FILORI					
		EndIf

		If oReport:Cancel()
    		Exit
		EndIf
	  	oSection1:Init()

		// Calcula o saldo anterior do centro de custo atual
		aSaldoAnt	:= SaldTotCT3(cArqTmp->CCUSTO,cArqTmp->CCUSTO,cContaIni,cContaFim,dDataIni,cMoeda,cSaldo,xFilial("CT3",CFILANT),,,,,,,,@lTodasFil)
		aSaldo		:= SaldTotCT3(cArqTmp->CCUSTO,cArqTmp->CCUSTO,cContaIni,cContaFim,cArqTmp->DATAL,cMoeda,cSaldo,xFilial("CT3",CFILANT))

		If f440Fil(lNoMov,aSaldo,dDataIni)
			dbSkip()
			Loop
		EndIf

		nSaldoAtu:= 0
		nTotDeb	:= 0
		nTotCrd	:= 0

		// Conta Sintetica
		dbSelectArea("CTT")
		dbSetOrder(1)
		dbSeek(xFilial()+cArqTMP->CCUSTO)
		cResCC := CTT->CTT_RES

		oSection1:Cell("CUSTO"):SetTitle(Upper(Alltrim(cSayCusto)))
		If mv_par24 == 1// Imprime Codigo Normal de Centro de Custo
			oSection1:Cell("CUSTO"):SetBlock( { || EntidadeCTB(cArqTmp->CCUSTO,0,0,nTamCusto,.F.,cMascara2,cSepara2,,,,,.F.) } )
		Else
			oSection1:Cell("CUSTO" ):SetBlock( { || EntidadeCTB(cResCC,0,0,Len(cResCC),.F.,cMascara2,cSepara2,,,,,.F.) } )
		Endif
		oSection1:Cell("DESCCC"):SetBlock( { || CtbDescMoeda("CTT->CTT_DESC"+cMoeda) } ) 
		oSection1:Cell("TPSLDANT"):SetTitle(STR0026)
		oSection1:Cell("TPSLDANT"):SetBlock( { || ValorCTB(aSaldoAnt[6],,,TAM_VALOR+12,nDecimais,.T.,cPicture,	cNormal ,,,,,,lPrintZero,.F.) } )

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImpressao do Saldo Anterior do Centro de Custoณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oSection1:PrintLine()

		nSaldoAtu := aSaldoAnt[6]

		dbSelectArea("cArqTmp")
		bPrint := { || ValorCTB(nSldTransp,,,TAM_VALOR+12,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.)}
		oReport:SetPageFooter(06, {|| PrintTransp(oReport, nSldTransp, .F., bPrint)} ) // A TRANSPORTAR
		oReport:OnPageBreak( {|| PrintTransp(oReport, nSldTransp, .T., bPrint)} )      // DE TRANSPORTE

		cFilRazao := cArqTmp->FILIAL
		cCustoAnt := cArqTmp->CCUSTO

	   	oSection2:Init()

		While !oReport:Cancel() .And. cArqTmp->( !Eof() .And. FILIAL+CCUSTO == cFilRazao+cCustoAnt )

			If oReport:Cancel()
				Exit
			EndIf

			cContaAnt	:= cArqTmp->CONTA
			dDataAnt	:= cArqTmp->DATAL

	  		If lItem .or. lClvl .Or. Empty(cArqTmp->FILIAL)
				cFilAuxStr := ""
			Else
				cFilAuxStr := STR0037+":"+cArqTmp->FILIAL+Space(1)
			EndIf

			If lAnalitico

				nTotCtaDeb  := 0
				nTotCtaCrd	:= 0
				If ! Empty(cArqTmp->CONTA)

					cConta := cFilAuxStr+STR0024 //"CONTA - "

					dbSelectArea("CT1")
					dbSetOrder(1)
					If MsSeek(xFilial("CT1")+cArqTMP->CONTA,.T.)
						cCodRes := CT1->CT1_RES
						cNormal := CT1->CT1_NORMAL
						If mv_par10 == 1 // Imprime Codigo de Impressao
							cConta += EntidadeCTB(cArqTmp->CONTA,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
						Else // Caso contrแrio usa codigo reduzido
							cConta += EntidadeCTB(cCodRes,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
						EndIf
						cConta += CtbDescMoeda("CT1->CT1_DESC"+cMoeda)
						cCtaAux := CtbDescMoeda("CT1->CT1_DESC"+cMoeda)
					Endif
				EndIf

				oReport:PrintText(cConta)

				If lSalLin
					oReport:SkipLine()
				Endif

				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณINICIO DA 2a SECAOณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				dbSelectArea("cArqTmp")

				While !oReport:Cancel() .And. cArqTmp->(!Eof() .And. FILIAL+CCUSTO+CONTA == cFilRazao+cCustoAnt+cContaAnt )

					If oReport:Cancel()
						Exit
					EndIf

					oReport:IncMeter()

					cDescCT1    := ""
   					nSaldoAtu 	:= nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD
					nTotDeb		+= cArqTmp->LANCDEB
					nTotCrd		+= cArqTmp->LANCCRD
					nTotCtaDeb	+= cArqTmp->LANCDEB
					nTotCtaCrd	+= cArqTmp->LANCCRD					

					If lCtaCpo	
						If ! Empty(cArqTmp->CONTA) 
							dbSelectArea("CT1")
							dbSetOrder(1)
							If MsSeek(xFilial("CT1")+cArqTMP->CONTA,.T.)
								cDescCT1 := CtbDescMoeda("CT1->CT1_DESC"+cMoeda)
								cCodRes  := CT1->CT1_RES
								cNormal  := CT1->CT1_NORMAL
								If mv_par10 == 1 // Imprime Codigo de Impressao
									oSection2:Cell("CONTA"):SetBlock( { || EntidadeCTB(cArqTmp->CONTA,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.) } )
									cCtaAux := EntidadeCTB(cArqTmp->CONTA,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
								Else // Caso contrแrio usa codigo reduzido
									oSection2:Cell("CONTA"):SetBlock( { || EntidadeCTB(cCodRes,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.) } )
									cCtaAux := EntidadeCTB(cCodRes,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.)
								EndIf
								oSection2:Cell("DESCCON"):SetBlock( { || cDescCT1 } )
							Endif
						EndIf
					EndIf

					If dDataAnt <> cArqTmp->DATAL
						oSection2:Cell("DATAL"):SetValue( { || cArqTmp->DATAL } )
						dDataAnt := cArqTmp->DATAL
					Else
						oSection2:Cell("DATAL"):SetValue( { || dDataAnt } )
					EndIf

					dbSelectArea("CT1")
					dbSetOrder(1)
					MsSeek(xFilial("CT1")+cArqTmp->XPARTIDA)
					cCodRes := CT1->CT1_RES
					dbSelectArea("cArqTmp")

					If mv_par10 == 1 // Impr Cod (Normal/Reduzida/Cod.Impress)
						oSection2:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(cArqTmp->XPARTIDA,0,0,nTamConta,.F.,cMascara1,cSepara1,,,,,.F.) } )
					Else
						oSection2:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(cCodRes,0,0,TAM_CONTA,.F.,cMascara1,cSepara1,,,,,.F.) } )
					Endif

					If lItem 						//Se imprime item
						If mv_par25 == 1 //Imprime Codigo Normal Item Contabl
							oSection2:Cell("ITEM"):SetBlock( { || EntidadeCTB(cArqTmp->ITEM,0,0,TAM_CONTA,.F.,cMascara3,cSepara3,,,,,.F.) } )
						Else
							dbSelectArea("CTD")
							dbSetOrder(1)
							dbSeek(xFilial("CTD")+cArqTmp->ITEM)
							cResItem := CTD->CTD_RES
							oSection2:Cell("ITEM"):SetBlock( { || EntidadeCTB(cResItem,0,0,TAM_CONTA,.F.,cMascara3,cSepara3,,,,,.F.) } )
							dbSelectArea("cArqTmp")
						Endif
					Endif
					If lCLVL //Se imprime classe de valor
						If mv_par26 == 1 //Imprime Cod. Normal Classe de Valor
							oSection2:Cell("CLVL"):SetBlock( { || EntidadeCTB(cArqTmp->CLVL,0,0,TAM_CONTA,.F.,cMascara4,cSepara4,,,,,.F.) } )
						Else
							dbSelectArea("CTH")
							dbSetOrder(1)
							dbSeek(xFilial("CTH")+cArqTmp->CLVL)
							cResClVl := CTH->CTH_RES
							oSection2:Cell("CLVL"):SetBlock( { || EntidadeCTB(cResClVl,0,0,TAM_CONTA,.F.,cMascara4,cSepara4,,,,,.F.) } )
							dbSelectArea("cArqTmp")
						Endif
					Endif

					// Sinal do Saldo Atual => Consulta Razao
					oSection2:Cell("TPSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR+12,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) })

					oSection2:PrintLine()
					nSldTransp := nSaldoAtu

				    lTotConta := ! Empty(cArqTmp->CONTA)
					dbSelectArea("cArqTmp")
					dDataAnt := cArqTmp->DATAL
					dbSkip()
				EndDo //cArqTmp->(!Eof() .And. FILIAL+CCUSTO+CONTA == cFilRazao+cCustoAnt+cContaAnt )

				If lTotConta .And. mv_par11 == 1	// Totaliza tb por Conta
		   			
					//IMPRIME TITULO DO SUBTOTAL / TOTAL DA CONTA NA COLUNA HISTORICO
					If lCtaCpo
						oSection3:Cell("HISTORICO"	):SetBlock( { || STR0020 + " ==> "+Alltrim(cCtaAux) } )//"T o t a i s  d o  C e n t r o  d e  C u s t o  ==> "
					Else
						oSection3:Cell("HISTORICO"	):SetBlock( { || OemToAnsi(STR0020) } )//"Totais Conta  ==> "
					EndIf

					oSection3:Cell("TOT_DEBITO"	):SetBlock( { || ValorCTB(nTotCtaDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
					oSection3:Cell("TOT_CREDITO"):SetBlock( { || ValorCTB(nTotCtaCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )
					oSection3:Cell("TOT_ATU" 	):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR+12,nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.) } )

					// Imprime totalizado
					oSection3:Init() // oSection3 - Totalizadora
					oSection3:PrintLine()
					oSection3:Finish()

					oReport:SkipLine()

					nSldTransp := nSaldoAtu

					nTotCtaDeb := 0
					nTotCtaCrd := 0

				EndIf

			Else // !lAnalitico	 -- Se for resumido.
				oReport:IncMeter()

				dbSelectArea("cArqTmp")
				If ! Empty(cArqTmp->CONTA)
					CT1->(dbSeek(xFilial()+cArqTmp->CONTA))
					cCodRes := CT1->CT1_RES
					cNormal := CT1->CT1_NORMAL
				Else
					cNormal := ""
				Endif

				While !oReport:Cancel() .And.  cArqTmp->( ! Eof() .And. dDataAnt == DATAL .And. FILIAL+CCUSTO == cFilRazao+cCustoAnt )
					If oReport:Cancel()
						Exit
					EndIf
					nVlrDeb	+= cArqTmp->LANCDEB
					nVlrCrd	+= cArqTmp->LANCCRD
					cFilRazao := cArqTmp->FILIAL
					dbSkip()
				EndDo
				If dDataAnt <> cArqTmp->DATAL
					oSection2:Cell("DATAL"):SetValue( { || dDataAnt } )
					oSection2:Cell("FILIAL"):SetValue( { || cFilRazao } )
				EndIf
				nSaldoAtu	:= nSaldoAtu - nVlrDeb + nVlrCrd

				oSection2:Cell("LANCDEB"):SetBlock( { || ValorCTB(nVlrDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) })// Debito
				oSection2:Cell("LANCCRD"):SetBlock( { || ValorCTB(nVlrCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) })// Credito
				oSection2:Cell("TPSLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR+12,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) })// Sinal do Saldo Atual => Consulta Razao

				//Imprime Section(1) - resumida.

				oSection2:PrintLine()
				nSldTransp := nSaldoAtu

				nTotDeb	+= nVlrDeb
				nTotCrd	+= nVlrCrd
				nVlrDeb	:= 0
				nVlrCrd	:= 0
			Endif // lAnalitico

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณFIM DA 2a SECAOณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
        EndDo //cArqTmp->( !Eof() .And. FILIAL+CCUSTO == cFilRazao+cCustoAnt )

		oSection2:Finish()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณINICIO DA 3a SECAO - Totais da Conta ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If ! oReport:Cancel()
			cCCusto := "( "
			If lAnalitico
				If mv_par24 == 1 // Se imprime cod. normal de Centro de Custo
					cCCusto += Alltrim( EntidadeCTB(cCustoAnt,0,0,nTamCusto,.F.,cMascara2,cSepara2,,,,,.F.) )
				Else
					dbSelectArea("CTT")
					dbSetOrder(1)
					dbSeek(xFilial()+cCustoAnt)
					cResCC := CTT->CTT_RES
					cCCusto += Alltrim( EntidadeCTB(cResCC,0,0,nTamCusto,.F.,cMascara2,cSepara2,,,,,.F.) )
				Endif
			Else
				If mv_par24 == 1
					cCCusto += Alltrim( EntidadeCTB(cCustoAnt,0,0,nTamCusto,.F.,cMascara2,cSepara2,,,,,.F.) ) 
				Else
					dbSelectArea("CTT")
					dbSetOrder(1)
					dbSeek(xFilial()+cCustoAnt)
					cResCC := CTT->CTT_RES
					cCCusto += Alltrim( EntidadeCTB(cResCC,0,0,nTamCusto,.F.,cMascara2,cSepara2,,,,,.F.) )
				Endif
			Endif
			cCCusto +=" )"

			//COLOCAR NA SECTION 3 A DESCRICAO DO SUBTOTAL / TOTAL DO CENTRO DE CUSTO
			If lCtaCpo
				oSection3:Cell("HISTORICO"	):SetBlock( { || STR0017+ Upper(Alltrim(cSayCusto)) + " ==> "+Alltrim(cCCusto) } )//"T o t a i s  d o  C e n t r o  d e  C u s t o  ==> "
			Else
				oSection3:Cell("HISTORICO"	):SetBlock( { || STR0017+ Upper(Alltrim(cSayCusto)) + " ==> "+Alltrim(cCCusto) } )//"T o t a i s  d o  C e n t r o  d e  C u s t o  ==> "
			EndIf
			
			oSection3:Cell("TOT_DEBITO"	):SetBlock(	{ || ValorCTB(nTotDeb  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
			oSection3:Cell("TOT_CREDITO"):SetBlock(	{ || ValorCTB(nTotCrd  ,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )
			oSection3:Cell("TOT_ATU"	):SetBlock(	{ || ValorCTB(nSaldoAtu,,,TAM_VALOR+12,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )

			// Imprime totalizado
			oSection3:Init()
			nSldTransp := 0
			oSection3:PrintLine()
			oSection3:Finish()
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณFIM DA 3a SECAO - Totais da Contaณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		EndIf
		oSection1:Finish()
	EndDo //lImpLivro .And. !cArqTmp->(Eof())

	oReport:SetPageFooter( 0, {||.T.})
	oReport:OnPageBreak( {|| .T.})
EndIf //!(cArqTmp->(RecCount()) == 0 .And. !Empty(aSetOfBook[5]))

cFilAnt := cFilOld
dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()

dbselectArea("CT2")

Return lOk

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpCompl  บAutor  ณCicero J. Silva     บ Data ณ  27/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a descricao, da conta contabil, item, centro de     บฑฑ
ฑฑบ          ณcusto ou classe valor                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR390                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function ImpCompl()
Local cRetHist := ""
Local cxFilCT2  := xFilial("CT2")
Local lContHis := .F.
Local nX

If mv_par04 - mv_par03 > 100  //se for maior ou igual a xxx dias faz pelo processo normal

	If _cAliQry == NIL  //para fazer query uma unica vez
		_cAliQry := CriaTrab(,.F.)

		If _aSelFil != NIL .And. Len(_aSelFil) > 0 
			For nX := 1 TO Len(_aSelFil)
				cxFilCT2 := xFilial("CT2", _aSelFil[nX])
				Ctb_CtHis( cxFilCT2, mv_par03, mv_par04 )
			Next
		Else
			Ctb_CtHis( cxFilCT2,mv_par03, mv_par04 )
		EndIf
	EndIf

	If _aChvLct != NIL .And. Len(_aChvLct) > 0  //ARRAY STATIC montado na funcao Ctb_CtHis() 
		//procura ver se tem historico para o lancto
		lContHis := aScan( _aChvLct, cArqTMP->FILIAL+DTOS(cArqTMP->DATAL)+cArqTMP->LOTE+cArqTMP->SUBLOTE+cArqTMP->DOC+cArqTMP->SEQLAN+cArqTMP->EMPORI+cArqTMP->FILORI+'01') > 0
	Else
		lContHis := .T.  //faz chamada sempre para ver se existe cont. historico
	EndIf
Else
	lContHis := .T.  //faz chamada sempre para ver se existe cont. historico
EndIf

If lContHis
	// Procura pelo complemento de historico
	dbSelectArea("CT2")
	dbSetOrder(10)
	If MsSeek(cArqTMP->FILIAL+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN+EMPORI+FILORI),.F.)
		dbSkip()

		If CT2->CT2_DC == "4"			//// TRATAMENTO PARA IMPRESSAO DAS CONTINUACOES DE HISTORICO
			While !CT2->(Eof()) .And.;
					CT2->CT2_FILIAL == cArqTMP->FILIAL .And.;
					 CT2->CT2_LOTE == cArqTMP->LOTE .And.;
					  CT2->CT2_SBLOTE == cArqTMP->SUBLOTE .And.;
					   CT2->CT2_DOC == cArqTmp->DOC .And.;
						CT2->CT2_SEQLAN == cArqTmp->SEQLAN .And.;
						 CT2->CT2_EMPORI == cArqTmp->EMPORI .And.;
						  CT2->CT2_FILORI == cArqTmp->FILORI .And.;
						   CT2->CT2_DC == "4" .And.;
				    	    DTOS(CT2->CT2_DATA) == DTOS(cArqTmp->DATAL)

				cRetHist += Alltrim(CT2->CT2_HIST)+Space(1)

				CT2->(dbSkip())
			EndDo
		EndIf
	EndIf
EndIf

dbSelectArea("cArqTmp")

Return(cRetHist)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณf440Fil   บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR440                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function f440Fil(lNoMov,aSaldo,dDataIni)

Local lDeixa	:= .F.

	If !lNoMov //Se imprime conta sem movimento
		If aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0
			lDeixa	:= .T.
		Endif
	Endif

	If lNoMov .And. aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0
		If CtbExDtFim("CTT")
			dbSelectArea("CTT")
			dbSetOrder(1)
			If MsSeek(xFilial()+cArqTmp->CCUSTO)
				If !CtbVlDtFim("CTT",dDataIni)
					lDeixa	:= .T.
	            EndIf
		    EndIf
		EndIf
	EndIf

	dbSelectArea("cArqTmp")

Return (lDeixa)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR440   บAutor  ณRenato F. Campos    บ Data ณ  02/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Calcula o tamanho real do campo deacordo com o campo infor-บฑฑ
ฑฑบ          ณmado e a mascara informada                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TamCpoMask( cCodigo , cMascara )
Local nTamanho

// codigo nใo informado pelo programador
If Empty( cCodigo )
	Return 0
Endif

// pega o tamanho do campo informado
nTamanho := Len( CriaVar( cCodigo ) )

If ! Empty( cMascara )
	nTamanho := nTamanho + ( Len( Alltrim( cMascara ) ) / 2 )
EndIf

RETURN nTamanho


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR440   บAutor  ณDaniel Fonseca Lira บ Data ณ  04/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o transporte no relatorio tanto na quebra de       บฑฑ
ฑฑบ          ณ pagina como no redape da pagina                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณ oReport    - relatorio em uso para imprimir as informacoes บฑฑ
ฑฑบ          ณ nSldTransp - valor do saldo (caso zero nao imprimi nada)   บฑฑ
ฑฑบ          ณ lBreak     - informa se ้ cabecalho (.T.) ou rodape (.F.)  บฑฑ
ฑฑบ          ณ bPrint     - bloco de codigo que retornara o que imprimir  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Interno no relatorio                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintTransp(oReport, nSldTransp, lBreak, bPrint)
	Local cDeouA
	If nSldTransp != 0
		cDeouA := IIf(lBreak, STR0023, STR0022)  // De transporte ## a Transportar
		oReport:PrtLeft(cDeouA)
		oReport:PrtRight(Eval(bPrint)+Space(9))  //9 ESPACOS A DIREITA PARA ALINHAR
		oReport:SkipLine()
		IIf(lBreak .And. MV_PAR28==1, oReport:SkipLine(),)
	EndIf
Return

//--------------------------------------------------
/*/{Protheus.doc} Ctb_CtHis( )
Retorna array com as chaves dos lancamentos que possuem continuacao de historico do lancamento

@author TOTVS
@since 10/10/2019
@version P12.1.17

@return array de recnos da continuacao de historico
/*/
//--------------------------------------------------
Static Function Ctb_CtHis( cxFilCT2, dDataIni, dDataFim)
Local cQuery 	:= ""
Local cAliasQry := ""

If _aChvLct == NIL
	_aChvLct 	:= {}
EndIf

cAliasQry := _cAliQry  //artificio para nao ficar invocando criaTrab toda execucao desta funcao
                       //a variavel static _cAliQry e resetada na saida da consulta
//QUERY
cQuery 	:= " SELECT CT2DB.CT2_FILIAL CT2_FILIAL, CT2DB.CT2_DATA CT2_DATA, CT2DB.CT2_LOTE CT2_LOTE, CT2DB.CT2_SBLOTE CT2_SBLOTE, CT2DB.CT2_DOC CT2_DOC, CT2DB.CT2_SEQLAN CT2_SEQLAN, CT2DB.CT2_EMPORI CT2_EMPORI, CT2DB.CT2_FILORI CT2_FILORI, CT2DB.CT2_MOEDLC CT2_MOEDLC"
cQuery 	+= " FROM "+RetSqlName("CT2")+" CT2DB , "+RetSqlName("CT2")+" HISD "
cQuery 	+= " WHERE "
//condicao para lancamentos a DEBITO na conta informada
cQuery 	+= "     CT2DB.CT2_FILIAL 	= '"+cxFilCT2+"'"
cQuery 	+= " AND CT2DB.CT2_DC IN ('1', '3') "  //DEBITO E PARTIDA DOBRADA
cQuery 	+= " AND CT2DB.CT2_DATA BETWEEN '"+DTOS(dDataIni)+"' AND '"+DTOS(dDataFim)+"'"
cQuery 	+= " AND CT2DB.CT2_MOEDLC 	= '01'" //moeda eh sempre na 01
cQuery 	+= " AND CT2DB.D_E_L_E_T_ 	= ' '"
//somente debitos do periodo
cQuery 	+= " AND CT2DB.CT2_DEBITO 	!= ' ' "

//link/join com tabela de lan็amentos com continuacao de historico
cQuery 	+= " AND CT2DB.CT2_FILIAL	= HISD.CT2_FILIAL"
cQuery 	+= " AND CT2DB.CT2_DATA		= HISD.CT2_DATA"
cQuery 	+= " AND CT2DB.CT2_LOTE		= HISD.CT2_LOTE"
cQuery 	+= " AND CT2DB.CT2_SBLOTE	= HISD.CT2_SBLOTE"
cQuery 	+= " AND CT2DB.CT2_DOC		= HISD.CT2_DOC"
cQuery 	+= " AND CT2DB.CT2_SEQLAN	= HISD.CT2_SEQLAN"
cQuery 	+= " AND CT2DB.CT2_EMPORI	= HISD.CT2_EMPORI"
cQuery 	+= " AND CT2DB.CT2_FILORI	= HISD.CT2_FILORI"
cQuery 	+= " AND CT2DB.CT2_MOEDLC	= HISD.CT2_MOEDLC"
//condicao da continuacao de historico
cQuery 	+= " AND HISD.CT2_FILIAL 	= '"+cxFilCT2+"'"
cQuery 	+= " AND HISD.CT2_MOEDLC 	= '01' " //moeda eh sempre na 01
cQuery 	+= " AND HISD.CT2_DC 		= '4'" //4 = Continuacao de historico e as entidades contabeis estao em branco
cQuery 	+= " AND HISD.CT2_DATA BETWEEN '"+DTOS(dDataIni)+"' AND '"+DTOS(dDataFim)+"'"
cQuery 	+= " AND HISD.D_E_L_E_T_ 	= ' '"
cQuery 	+= " GROUP BY CT2DB.CT2_FILIAL, CT2DB.CT2_DATA, CT2DB.CT2_LOTE, CT2DB.CT2_SBLOTE, CT2DB.CT2_DOC, CT2DB.CT2_SEQLAN, CT2DB.CT2_EMPORI, CT2DB.CT2_FILORI, CT2DB.CT2_MOEDLC"

cQuery 	+= " UNION  "//Para nao apresentar chaves duplicadas

cQuery 	+= " SELECT CT2CR.CT2_FILIAL CT2_FILIAL, CT2CR.CT2_DATA CT2_DATA, CT2CR.CT2_LOTE CT2_LOTE, CT2CR.CT2_SBLOTE CT2_SBLOTE, CT2CR.CT2_DOC CT2_DOC, CT2CR.CT2_SEQLAN CT2_SEQLAN, CT2CR.CT2_EMPORI CT2_EMPORI, CT2CR.CT2_FILORI CT2_FILORI, CT2CR.CT2_MOEDLC CT2_MOEDLC"
cQuery 	+= " FROM "+RetSqlName("CT2")+" CT2CR , "+RetSqlName("CT2")+" HISC "
cQuery 	+= " WHERE "
//condicao para lancamentos a CREDITO na conta informada
cQuery 	+= " 	 CT2CR.CT2_FILIAL 	= '"+cxFilCT2+"'"
cQuery 	+= " AND CT2CR.CT2_DC IN ('2', '3')"  //CREDITO E PARTIDA DOBRADA
cQuery 	+= " AND CT2CR.CT2_DATA BETWEEN '"+DTOS(dDataIni)+"' AND '"+DTOS(dDataFim)+"'"
cQuery 	+= " AND CT2CR.CT2_MOEDLC 	= '01'" //moeda eh sempre na 01
cQuery 	+= " AND CT2CR.D_E_L_E_T_ 	= ' '"

//somente creditos 
cQuery 	+= " AND CT2CR.CT2_CREDIT 	!= ' ' "

//link/join com tabela de lan็amentos com continuacao de historico
cQuery 	+= " AND CT2CR.CT2_FILIAL	= HISC.CT2_FILIAL"
cQuery 	+= " AND CT2CR.CT2_DATA		= HISC.CT2_DATA"
cQuery 	+= " AND CT2CR.CT2_LOTE		= HISC.CT2_LOTE"
cQuery 	+= " AND CT2CR.CT2_SBLOTE	= HISC.CT2_SBLOTE"
cQuery 	+= " AND CT2CR.CT2_DOC		= HISC.CT2_DOC"
cQuery 	+= " AND CT2CR.CT2_SEQLAN	= HISC.CT2_SEQLAN"
cQuery 	+= " AND CT2CR.CT2_EMPORI	= HISC.CT2_EMPORI"
cQuery 	+= " AND CT2CR.CT2_FILORI	= HISC.CT2_FILORI"
cQuery 	+= " AND CT2CR.CT2_MOEDLC	= HISC.CT2_MOEDLC"
//condicao da continuacao de historico
cQuery 	+= " AND HISC.CT2_FILIAL 	= '"+cxFilCT2+"'"
cQuery 	+= " AND HISC.CT2_MOEDLC 	= '01'" //moeda eh sempre na 01
cQuery 	+= " AND HISC.CT2_DC 		= '4'"  //4 = Continuacao de historico e as entidades contabeis estao em branco
cQuery 	+= " AND HISC.CT2_DATA BETWEEN '"+DTOS(dDataIni)+"' AND '"+DTOS(dDataFim)+"'"
cQuery 	+= " AND HISC.D_E_L_E_T_ 	= ' '"
cQuery 	+= " GROUP BY CT2CR.CT2_FILIAL, CT2CR.CT2_DATA, CT2CR.CT2_LOTE, CT2CR.CT2_SBLOTE, CT2CR.CT2_DOC, CT2CR.CT2_SEQLAN, CT2CR.CT2_EMPORI, CT2CR.CT2_FILORI, CT2CR.CT2_MOEDLC"
//Ordena pela chave do agrupamento
cQuery 	+= " ORDER BY CT2_FILIAL, CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_SEQLAN, CT2_EMPORI, CT2_FILORI, CT2_MOEDLC"

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.F.)
	
//laco para result da query
While (cAliasQry)->( ! Eof() )
    //a chave eh o proprio agrupamento da query e a data nao precisa ser feito tratamento com tcSetField pois ja retorna no formato caracter AAAAMMDD
	aAdd(_aChvLct, (cAliasQry)->CT2_FILIAL + (cAliasQry)->CT2_DATA + (cAliasQry)->CT2_LOTE + (cAliasQry)->CT2_SBLOTE + (cAliasQry)->CT2_DOC + (cAliasQry)->CT2_SEQLAN + (cAliasQry)->CT2_EMPORI + (cAliasQry)->CT2_FILORI + (cAliasQry)->CT2_MOEDLC )
	(cAliasQry)->( dbSkip() )

EndDo

(cAliasQry)->( dbCloseArea() )

Return
