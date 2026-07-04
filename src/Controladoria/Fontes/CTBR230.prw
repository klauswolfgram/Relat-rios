/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr230.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	16


// 17/08/2009 -- Filial com mais de 2 caracteres


//Tradu็ใo PTG

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณ CTBR230  ณ Autor ณ Cicero J. Silva   	ณ Data ณ 01.08.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Balancete Cl.Valor / Item            		 	 		  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ Ctbr230        											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno	 ณ Nenhum       											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso 		 ณ SIGACTB      											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum													  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function CTBR230()

Local aArea := GetArea()
Local oReport          

Local lOk := .T.
Local aCtbMoeda		:= {}
Local aSetOfBook
Local nDivide		:= 1
Local lAtSlComp		:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)

PRIVATE cTipoAnt	:= ""
PRIVATE cClVlAnt	:= ""
PRIVATE cPerg	 	:= "CTR230"
PRIVATE nomeProg  	:= "CTBR230"
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE oTRF3
PRIVATE oTRF4
PRIVATE aSelFil	    := {}
PRIVATE lTodasFil   := .f.
PRIVATE nTotdbt	:= 0
PRIVATE nTotcrt	:= 0

If Type("lExterno") == "U"
	PRIVATE lExterno
EndIf
	
Pergunte(cPerg,.T.) // Precisa ativar as perguntas antes das definicoes.
If mv_par27 == 1 .And. Len( aSelFil ) <= 0
	aSelFil := AdmGetFil(@lTodasFil)
	If Len( aSelFil ) <= 0
		Return
	Endif
EndIf 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Mostra tela de aviso - atualizacao de saldos				 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cMensagem := OemToAnsi(STR0021)+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += OemToAnsi(STR0022)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += OemToAnsi(STR0023)+chr(13)  		//"rodar a rotina de atualizacao de saldos "
IF !lAtSlComp
	If !MsgYesNo(cMensagem,OemToAnsi(STR0024))	//"ATEN€O"
		lOk := .F.
	EndIf
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
//ณ Gerencial -> montagem especifica para impressao)			 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !ct040Valid(mv_par08) // Set Of Books
	lOk := .F.
Else
   aSetOfBook := CTBSetOf(mv_par08)		
EndIf 

If mv_par24 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par24 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par24 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par10,nDivide) // Moeda?
   If Empty(aCtbMoeda[1])
      Help(" ",1,"NOMOEDA")
      lOk := .F.
   Endif
Endif

If lOk
	oReport := ReportDef(aSetOfBook,aCtbMoeda,nDivide)
	oReport:PrintDialog()
EndIf

//Limpa os arquivos temporแrios 
CTBGerClean()
	
RestArea(aArea)

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
Static Function ReportDef(aSetOfBook,aCtbMoeda,nDivide)

Local oReport
Local oSClsValor
Local oSCtrItem                        

Local cSayClVl		:= CtbSayApro("CTH")
Local cSayItem		:= CtbSayApro("CTD")
Local cDesc1 		:= OemToAnsi(STR0001)+ Alltrim(Upper(cSayClVl))+" / "+ Alltrim(Upper(cSayItem))	//"Este programa ira imprimir o Balancete de  "
Local cDesc2 		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"
LOCAL cString		:= "CTH"
Local titulo 		:= OemToAnsi(STR0003)+Alltrim(Upper(cSayClVl))+" / " +Alltrim(Upper(cSayItem)) 	//"Balancete de Verificacao"

Local aTamItem  	:= TAMSX3("CTD_ITEM")
Local aTamItRes 	:= TAMSX3("CTD_RES")    
Local nTamItem		:= Len(CriaVar("CTD->CTD_DESC"+mv_par10))
Local aTamCVRes 	:= TAMSX3("CTH_RES")
Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local nTamClVl		:= Len(CriaVar("CTH->CTH_DESC"+mv_par10))
 
Local lMov 			:= IIF(mv_par18==1,.T.,.F.) // Imprime movimento ?
Local lPula			:= Iif(mv_par22==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par20==1,.T.,.F.)
Local lNormalCVlr	:= Iif(mv_par21==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par23==1,.T.,.F.)
Local lSaltaSec		:= Iif(mv_par19==1,.T.,.F.)
Local cSegAte 	   	:= mv_par13 // Imprimir ate o Segmento?
Local nDigitAte		:= 0
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cMascItem		:= IIF (Empty(aSetOfBook[7]),"",RetMasCtb(aSetOfBook[8],@cSepara1))// Mascara do Item Contabil
Local cMascClVl		:= IIF (Empty(aSetOfBook[8]),"",RetMasCtb(aSetOfBook[8],@cSepara2))//Mascara da Classe de Valor
Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)
Local cDescMoeda 	:= aCtbMoeda[2]
Local bCondITEM 	:= {|| IIF(cArqTmp->TIPOITEM=="1","","  ")+EntidadeCTB(cArqTmp->ITEM,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.) }
Local bCondITEMRES := {|| IIF(cArqTmp->TIPOITEM=="1",	EntidadeCTB(cArqTmp->ITEM,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.),;
	  										"  " + EntidadeCTB(cArqTmp->ITEMRES,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.) ) }
Local lColDbCr 		:= If(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= If(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.) // CAZARINI - 20/06/2017 - Parameter to activate Red Storn

oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,cSayItem,nDivide)},cDesc1+cDesc2)

If lMov
	oReport:SetLandScape(.T.)
Else
	oReport:SetPortrait(.T.)
EndIf

// Sessao 1
oSClsValor := TRSection():New(oReport, Capital(cSayClVl) ,{"cArqTmp"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)
oSClsValor:SetNoFilter({"cArqTmp"})
oSClsValor:SetLineStyle()

TRCell():New(oSClsValor,"CLVL"		,"cArqTmp"	, STR0027			,/*Picture*/,aTamClVl[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CLVL ,0,0,20,.F.,cMascClVl,cSepara1,,,,,.F.) })  //"CODIGO"
TRCell():New(oSClsValor,"CLVLRES"	,"cArqTmp"	, STR0028			,/*Picture*/,aTamCVRes[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CLVL ,0,0,20,.F.,cMascClVl,cSepara1,,,,,.F.) })  //"CODIGO REDUZIDO"
TRCell():New(oSClsValor,"DESCCLVL"	,"cArqTmp"	, STR0029			,/*Picture*/,nTamClVl		,/*lPixel*/,/*{|| }*/)  //"DESCRICAO"

If lNormalCVlr
	oSClsValor:Cell("CLVLRES"	):Disable()
Else
	oSClsValor:Cell("CLVL"		):Disable() 
EndIf

If lSaltaSec
	oSClsValor:SetPageBreak(.T.)
EndIf

// Sessao 2
oSCtrItem := TRSection():New(oSClsValor, Capital(cSayItem) ,{"cArqTmp", "CTD"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oSCtrItem:SetTotalInLine(.F.)
oSCtrItem:SetHeaderPage()
oSCtrItem:SetNoFilter({"cArqTmp"})

TRCell():New(oSCtrItem,"ITEM"		,"cArqTmp"	, STR0030	,/*Picture*/,aTamItem[1]		,/*lPixel*/, bCondITEM )  //"COD. DO ITEM"
TRCell():New(oSCtrItem,"ITEMRES"	,"cArqTmp"	, STR0031	,/*Picture*/,aTamItRes[1]	,/*lPixel*/, bCondITEMRES )  //"COD. RED. DO ITEM"
TRCell():New(oSCtrItem,"DESCITEM"	,"cArqTmp"	, STR0032	,/*Picture*/,nTamItem			,/*lPixel*/,/*{|| }*/)  // "DESCRICAO DO ITEM"
TRCell():New(oSCtrItem,"SALDOANT"	,"cArqTmp"	, STR0033	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lRedStorn,cArqTmp->ITNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")  //"SALDO ANTERIOR"
TRCell():New(oSCtrItem,"SALDODEB"	,"cArqTmp"	, STR0034	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,Iif(lRedStorn,cArqTmp->ITNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")  //"DEBITO"
TRCell():New(oSCtrItem,"SALDOCRD"	,"cArqTmp"	, STR0035	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,Iif(lRedStorn,cArqTmp->ITNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")  //"CREDITO"
TRCell():New(oSCtrItem,"MOVIMENTO"	,"cArqTmp"	, STR0036	,/*Picture*/,TAM_VALOR+6,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR+6,nDecimais,.T.,cPicture,Iif(lRedStorn,cArqTmp->ITNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")  //"MOVIMENTO PERIODO"
TRCell():New(oSCtrItem,"SALDOATU"	,"cArqTmp"	, STR0037	,/*Picture*/,TAM_VALOR+6,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR+6,nDecimais,.T.,cPicture,Iif(lRedStorn,cArqTmp->ITNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")  //"SALDO ATUAL"

If lNormal //Se Imprime Codigo Reduzido
	oSCtrItem:Cell("ITEMRES"):Disable()
Else
	oSCtrItem:Cell("ITEM"):Disable()	
EndIf

If !lMov //Nao Imprime Coluna Movimento!!
	oSCtrItem:Cell("MOVIMENTO"):Disable()	
EndIf

oSCtrItem:SetTotalText({|| STR0020 + " : "+ cSayClVl })

oSCtrItem:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOITEM == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
								 cTipoAnt := cArqTmp->TIPOITEM;
							)  })

oSCtrItem:SetLineCondition({|| f230Fil(cSegAte, nDigitAte,cMascItem) })

oBreak:= TRBreak():New(oSCtrItem,{ || cArqTmp->CLVL },,.F.)

oBreak:OnBreak({ || nTotdbt := oTRF1:GetValue(),nTotcrt := oTRF2:GetValue() })

oTRF1 := TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f230Soma("D",cSegAte) },.T.,.F.,.F.,oSCtrItem)
oTRF1:disable()
 		 TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotdbt,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSCtrItem)

oTRF2 := TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f230Soma("C",cSegAte) },.T.,.F.,.F.,oSCtrItem)
oTRF2:disable()
		 TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSCtrItem)
		 
// Total geral

oTRF3 := TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f230Soma("D",cSegAte) },.F.,.F.,.F.,oSCtrItem)
oTRF3:disable()
		TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF3:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSCtrItem)

oTRF4 := TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f230Soma("C",cSegAte) },.F.,.F.,.F.,oSCtrItem)
oTRF4:disable()
		TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF4:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSCtrItem)


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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,cSayItem,nDivide)

Local oSClasseVlr	:= oReport:Section(1)
Local oSCtrItem 	:= oReport:Section(1):Section(1)

Local cArqTmp		:= ""
Local cTipo			:= ""
Local cConta		:= Space(Len(CriaVar("CT1_CONTA")))
Local cCusto  		:= Space(Len(CriaVar("CTT_CUSTO")))                  

Local dDataFim 		:= mv_par02
Local lImpAntLP		:= Iif(mv_par25==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par23==1,.T.,.F.)
Local dDataLP  		:= mv_par26
Local l132			:= IIF(mv_par18 == 1,.F.,.T.)// Se imprime saldo movimento do periodo
Local cFiltro	:= oSClasseVlr:GetAdvplExp()

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza titulo do relatorio: Analitico / Sintetico			 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF mv_par07 == 1
		titulo :=	OemToAnsi(STR0006)+ Alltrim(Upper(cSayClVl)) + " / " + Alltrim(Upper(cSayItem)) 	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par07 == 2                                  
		titulo :=	OemToAnsi(STR0007) + Alltrim(Upper(cSayClVl)) + " / " + Alltrim(Upper(cSayItem))	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par07 == 3
		titulo :=	OemToAnsi(STR0008) + Alltrim(Upper(cSayClVl)) + " / " + Alltrim(Upper(cSayItem))	//"BALANCETE DE  "
	EndIf
	
	titulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + OemToAnsi(STR0010) + Dtoc(mv_par02) + OemToAnsi(STR0011) + cDescMoeda
	
	If mv_par12 > "1"
		titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
	Endif
	
	oReport:SetTitle(titulo)
	oReport:SetPageNumber(mv_par11) //mv_par11	-	Pagina Inicial
	oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta Arquivo Temporario para Impressao					     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				 mv_par01,mv_par02,"CTX","",cConta,cConta,cCusto,cCusto,mv_par05,mv_par06,;
				  mv_par03,mv_par04,mv_par10,mv_par12,aSetOfBook,mv_par14,;
				   mv_par15,mv_par16,mv_par17,l132,.F.,2,"CTH",lImpAntLP,dDataLP,nDivide,,,,,,,,,,,,,,,,cFiltro/*aReturn[7]*/ ,;
				   ,,,,,,,,,,,aSelFil,,,,,,,,,lTodasFil)},;				
					OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor rio..."
					 OemToAnsi(STR0003)+Alltrim(Upper(cSayClVl)) + " / " + Alltrim(Upper(cSayItem)))     //"Balancete Verificacao "
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Inicia a impressao do relatorio                                               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oReport:NoUserFilter()

	dbSelectArea("cArqTmp")
	dbGotop()

	oSCtrItem:SetParentFilter( { |cParam| cArqTmp->CLVL == cParam },{ || cArqTmp->CLVL })// SERVE PARA IMPRIMIR O TITULO DA SECAO PAI
		
	oSClasseVlr:Print()

dbSelectArea("cArqTmp")
dbClearFilter()
dbCloseArea()
Ferase(cArqTmp+GetDBExtension())
FErase("cArqInd"+OrdBagExt())
dbselectArea("CT2")

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณf230Soma  บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR230                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function f230Soma(cTipo,cSegAte)

Local nRetValor		:= 0

	If mv_par07 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOITEM == "1" .And. cArqTmp->NIVEL1
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		EndIf
	Else								// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOITEM == "2"
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOITEM == "1" .And. cArqTmp->NIVEL1
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
ฑฑบPrograma  ณf230Fil   บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR230                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function f230Fil(cSegAte, nDigitAte,cMascItem)

Local lDeixa	:= .T.
Local nCont    := 0

	If mv_par07 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOITEM == "2"
			lDeixa := .F.
		EndIf
	ElseIf mv_par07 == 2				// So imprime Analiticas
		If cArqTmp->TIPOITEM == "1"
			lDeixa := .F.
		EndIf
	EndIf
	If mv_par09 == 2 // Saldos Zerados nao serao impressos
		If (Abs(cArqTmp->SALDOANT)+Abs(cArqTmp->SALDOATU)+Abs(cArqTmp->SALDODEB)+Abs(cArqTmp->SALDOCRD)) == 0
			lDeixa := .F.
		EndIf
	EndIf                                        
	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		For nCont := 1 to Val(cSegAte)
			nDigitAte += Val(Subs(cMascItem,nCont,1))	
		Next
		If Len(Alltrim(cArqTmp->ITEM)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)