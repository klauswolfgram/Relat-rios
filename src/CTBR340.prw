/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr340.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	16


// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณ Ctbr340  ณ Autor ณ Cicero J. Silva   	ณ Data ณ 01.08.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Balancete Cl.Valor / C.Custo            		 	 		  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ Ctbr340        											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno	 ณ Nenhum       											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso 		 ณ SIGACTB      											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum													  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function CTBR340()

Local aArea := GetArea()
Local oReport          

Local lOk := .T.
Local aCtbMoeda		:= {}
Local aSetOfBook
Local nDivide		:= 1

PRIVATE cTipoAnt	:= ""
PRIVATE cClVlAnt	:= ""
PRIVATE cPerg	 	:= "CTR340"
PRIVATE nomeProg  	:= "CTBR340"
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE oTRF3
PRIVATE oTRF4
PRIVATE aSelFil	    := {}
PRIVATE lTodasFil   := .f.
PRIVATE nTotdbt	:= 0
PRIVATE nTotcrt	:= 0


Pergunte(cPerg,.T.) // Precisa ativar as perguntas antes das definicoes.

If mv_par27 == 1 .And. Len( aSelFil ) <= 0
	aSelFil := AdmGetFil(@lTodasFil)
	If Len( aSelFil ) <= 0
		Return
	Endif
EndIf 

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
Local oBreak
Local oSClsValor
Local oSCtrCusto                        

Local cSayClVl		:= CtbSayApro("CTH")
Local cSayCusto		:= CtbSayApro("CTT")
Local cDesc1 		:= OemToAnsi(STR0001)+ Alltrim(Upper(cSayClVl))+" / "+ Alltrim(Upper(cSayCusto))	//"Este programa ira imprimir o Balancete de  "
Local cDesc2 		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"
LOCAL cString		:= "CTH"
Local titulo 		:= OemToAnsi(STR0003)+Alltrim(Upper(cSayClVl))+" / " +Alltrim(Upper(cSayCusto)) 	//"Balancete de Verificacao"

Local aTamCC		:= TAMSX3("CTT_CUSTO")
Local aTamCCRes 	:= TAMSX3("CTT_RES")
Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local aTamCVRes 	:= TAMSX3("CTH_RES")
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+mv_par10))
Local nTamClVl		:= Len(CriaVar("CTH->CTH_DESC"+mv_par10))

Local lMov 			:= IIF(mv_par18 == 1,.T.,.F.) // Imprime movimento ?
Local lPula			:= Iif(mv_par22==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par21==1,.T.,.F.)
Local lNormalCVlr	:= Iif(mv_par20==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par23==1,.T.,.F.)
Local lSaltaSec		:= Iif(mv_par19==1,.T.,.F.)
Local cSegAte 	   	:= mv_par13 // Imprimir ate o Segmento?
Local nDigitAte		:= 0
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cMascClVl		:= IIF (Empty(aSetOfBook[8]),"",RetMasCtb(aSetOfBook[8],@cSepara1) )//Mascara da Classe de Valor
Local cMascCC		:= IIF (Empty(aSetOfBook[6]),GetMv("MV_MASCCUS"),RetMasCtb(aSetOfBook[6],@cSepara2))// Mascara do Centro de Custo
Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)
Local cDescMoeda 	:= aCtbMoeda[2]

Local bCondCUSTO := {|| IIF(cArqTmp->TIPOCC=="1","","  ")+EntidadeCTB(cArqTmp->CUSTO,0,0,20,.F.,cMascCC,cSepara2,,,,,.F.) }
Local bCondCCRES := {|| IIF(cArqTmp->TIPOCC=="1",	EntidadeCTB(cArqTmp->CUSTO,0,0,20,.F.,cMascClvl,cSepara2,,,,,.F.),;
	  										"  " + EntidadeCTB(cArqTmp->CCRES,0,0,20,.F.,cMascClvl,cSepara2,,,,,.F.) ) }

Local cCLVL,cCLVLRES

Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty

oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,cSayCusto,nDivide)},cDesc1+cDesc2)
oReport:ParamReadOnly()

If lMov
	oReport:SetLandScape(.T.)
Else
	oReport:SetPortrait(.T.)
EndIf

// Sessao 1
oSClsValor := TRSection():New(oReport,CtbsayApro("CTH") ,{"cArqTmp"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)
oSClsValor:SetLineStyle()
oSClsValor:SetNoFilter({"cArqTmp", "CTH"})

TRCell():New(oSClsValor,"CLVL"		,"cArqTmp",STR0021	,/*Picture*/,aTamClVl[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CLVL ,,,20,.F.,cMascClVl,cSepara1,,,,,.F.) }) //"Codigo"
TRCell():New(oSClsValor,"CLVLRES"	,"cArqTmp",STR0028  ,/*Picture*/,aTamCVRes[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CLVL ,0,0,20,.F.,cMascClVl,cSepara1,,,,,.F.) }) //"Codigo reduzido"
TRCell():New(oSClsValor,"DESCCLVL"	,"cArqTmp",STR0022	,/*Picture*/,nTamClVl		,/*lPixel*/,/*{|| }*/)                                    //"Descricao"

If lNormalCVlr
	oSClsValor:Cell("CLVLRES"	):Disable()
Else
	oSClsValor:Cell("CLVL"		):Disable() 
EndIf

If lSaltaSec
	oSClsValor:SetPageBreak(.T.)
EndIf

// Sessao 2
oSCtrCusto := TRSection():New(oSClsValor,cSayCusto,{"cArqTmp","CTT"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oSCtrCusto:SetTotalInLine(.F.)
oSCtrCusto:SetHeaderPage()
oSCtrCusto:SetNoFilter({"cArqTmp", "CTT"})

TRCell():New(oSCtrCusto,"CUSTO"		,"cArqTmp",STR0021		,/*Picture*/,aTamCC[1]+20		,/*lPixel*/, bCondCUSTO )// Codigo da Conta
TRCell():New(oSCtrCusto,"CCRES"		,"cArqTmp",STR0028		,/*Picture*/,aTamCCRes[1]	,/*lPixel*/, bCondCCRES )// Codigo Reduzido da Conta
TRCell():New(oSCtrCusto,"DESCCC"	,"cArqTmp",STR0022 		,/*Picture*/,nTamCC			,/*lPixel*/,/*{|| }*/)

If cPaisLoc == "RUS"
	TRCell():New(oSCtrCusto,"SALDOANT"	,"cArqTmp",STR0023     	,/*Picture*/,TAM_VALOR+2	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CCNORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")// Saldo Anterior
	TRCell():New(oSCtrCusto,"SALDODEB"	,"cArqTmp",STR0024     	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->CCNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")// Debito
	TRCell():New(oSCtrCusto,"SALDOCRD"	,"cArqTmp",STR0025  	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->CCNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")// Credito
	TRCell():New(oSCtrCusto,"MOVIMENTO"	,"cArqTmp",STR0026 		,/*Picture*/,TAM_VALOR+2	,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CCNORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")// Movimento do Periodo
	TRCell():New(oSCtrCusto,"SALDOATU"	,"cArqTmp",STR0027     	,/*Picture*/,TAM_VALOR+2	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CCNORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")// Saldo Atual
Else
	TRCell():New(oSCtrCusto,"SALDOANT"	,"cArqTmp",STR0023     	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->TIPOCC,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")// Saldo Anterior
	TRCell():New(oSCtrCusto,"SALDODEB"	,"cArqTmp",STR0024     	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCC,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")// Debito
	TRCell():New(oSCtrCusto,"SALDOCRD"	,"cArqTmp",STR0025  	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->TIPOCC,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")// Credito
	TRCell():New(oSCtrCusto,"MOVIMENTO"	,"cArqTmp",STR0026 		,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->TIPOCC,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")// Movimento do Periodo
	TRCell():New(oSCtrCusto,"SALDOATU"	,"cArqTmp",STR0027     	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->TIPOCC,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT")// Saldo Atual
EndIf

If lNormal //Se Imprime Codigo Reduzido
	oSCtrCusto:Cell("CCRES"):Disable()
Else
	oSCtrCusto:Cell("CUSTO"):Disable()	
EndIf

If !lMov //Nao Imprime Coluna Movimento!!
	oSCtrCusto:Cell("MOVIMENTO"):Disable()	
EndIf

oSCtrCusto:SetTotalText({|| STR0020 + cSayClVl + " : " + IIF(lNormalCVlr,cCLVL,cCLVLRES) })

oSCtrCusto:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCC == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
								 cTipoAnt := cArqTmp->TIPOCC;
							)  })

oSCtrCusto:SetLineCondition({|| cCLVL := cArqTmp->CLVL, cCLVLRES := cArqTmp->CLVLRES, f340Fil(cSegAte, nDigitAte,cMascCC) })

oBreak:= TRBreak():New(oSCtrCusto,{ || cArqTmp->CLVL},,.F.)

oBreak:OnBreak({ || nTotdbt := oTRF1:GetValue(),nTotcrt := oTRF2:GetValue() })

//TRFunction():New(oSCtrCusto:Cell("SALDODEB"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f340Soma("D",cSegAte) },.T.,.T.,.F.,oSCtrCusto)

oTRF1 := TRFunction():New(oSCtrCusto:Cell("SALDODEB"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f340Soma("D",cSegAte) },.T.,.F.,.F.,oSCtrCusto)
oTRF1:disable()
		TRFunction():New(oSCtrCusto:Cell("SALDODEB"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotdbt,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSCtrCusto)

//TRFunction():New(oSCtrCusto:Cell("SALDOCRD"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f340Soma("C",cSegAte) },.T.,.T.,.F.,oSCtrCusto)
oTRF2 := TRFunction():New(oSCtrCusto:Cell("SALDOCRD"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f340Soma("C",cSegAte) },.T.,.F.,.F.,oSCtrCusto)
oTRF2:disable()
		 TRFunction():New(oSCtrCusto:Cell("SALDOCRD"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSCtrCusto)

oReport:SetTotalText(STR0018)		//"T O T A I S  D O  P E R I O D O: "

// Total geral

If cPaisLoc == "RUS"
	TRFunction():New(oSCtrCusto:Cell("DESCCC"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || "" },.F.,.T.,.F.,oSCtrCusto)
	TRFunction():New(oSCtrCusto:Cell("SALDOANT"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || "" },.F.,.T.,.F.,oSCtrCusto)
EndIf

oTRF3 := TRFunction():New(oSCtrCusto:Cell("SALDODEB"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f340Soma("D",cSegAte) },.F.,.F.,.F.,oSCtrCusto)
oTRF3:disable()
		TRFunction():New(oSCtrCusto:Cell("SALDODEB"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF3:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSCtrCusto)

oTRF4 := TRFunction():New(oSCtrCusto:Cell("SALDOCRD"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f340Soma("C",cSegAte) },.F.,.F.,.F.,oSCtrCusto)
oTRF4:disable()
		TRFunction():New(oSCtrCusto:Cell("SALDOCRD"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF4:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSCtrCusto)


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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,cSayCusto,nDivide)

Local oSClassseVlr	:= oReport:Section(1)
Local oSCtrCusto 	:= oReport:Section(1):Section(1)

Local cArqTmp		:= ""
Local cTipo			:= ""
Local cConta		:= Space(Len(CriaVar("CT1_CONTA")))
Local cItem  		:= Space(Len(CriaVar("CTD_ITEM")))                  

Local dDataFim 		:= mv_par02
Local lImpAntLP		:= Iif(mv_par25 == 1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par09==1,.T.,.F.) 
Local lPrintZero	:= Iif(mv_par23==1,.T.,.F.)
Local dDataLP  		:= mv_par26
Local l132			:= IIF(mv_par18 == 1,.F.,.T.)// Se imprime saldo movimento do periodo

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza titulo do relatorio: Analitico / Sintetico			 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF mv_par07 == 1
		titulo :=	OemToAnsi(STR0006)+ Alltrim(Upper(cSayClVl)) + " / " + Alltrim(Upper(cSayCusto)) 	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par07 == 2                                  
		titulo :=	OemToAnsi(STR0007) + Alltrim(Upper(cSayClVl)) + " / " + Alltrim(Upper(cSayCusto))	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par07 == 3
		titulo :=	OemToAnsi(STR0008) + Alltrim(Upper(cSayClVl)) + " / " + Alltrim(Upper(cSayCusto))	//"BALANCETE DE  "
	EndIf
	
	titulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + OemToAnsi(STR0010) + Dtoc(mv_par02) + OemToAnsi(STR0011) + cDescMoeda
	
	If mv_par12 > "1"
		titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
	Endif
	
	oReport:SetTitle(titulo)
	oReport:SetPageNumber(mv_par11) //mv_par11	-	Pagina Inicial
	oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta Arquivo Temporario para Impressao	    				 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				 mv_par01,mv_par02,"CTW","",cConta,cConta,mv_par05,mv_par06,cItem,cItem,;
				  mv_par03,mv_par04,mv_par10,mv_par12,aSetOfBook,mv_par14,;
				   mv_par15,mv_par16,mv_par17,l132,.F.,2,"CTH",lImpAntLP,dDataLP,nDivide,lVlrZerado,;
					/*cFiltroEnt*/,/*cCodFilEnt*/, /*cSegmentoG*/,/*cSegIniG*/,/*cSegFimG*/,/*cFiltSegmG*/,/*lUsGaap*/,/*cMoedConv*/,;
						/*cConsCrit*/,/*dDataConv*/,/*nTaxaConv*/,/*aGeren*/,/*lImpMov*/,/*lImpSint*/,oSClassseVlr:GetAdvplExp(),;
						,,,,,,,,,,,aSelFil,,,,,,,,,lTodasFil)},;				
				    OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor rio..."
					 OemToAnsi(STR0003)+Alltrim(Upper(cSayClVl)) + " / " + Alltrim(Upper(cSayCusto)))     //"Balancete Verificacao "

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Inicia a impressao do relatorio                                               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	
	If Select("cArqTmp") <= 0
		Return
	Endif				

  	dbSelectArea("cArqTmp")
	dbGotop()

	oSCtrCusto:SetParentFilter( { |cParam| cArqTmp->CLVL == cParam },{ || cArqTmp->CLVL })// SERVE PARA IMPRIMIR O TITULO DA SECAO PAI
		
	//Desabilita o filtro de usuario
	oReport:NoUserFilter()

	oSClassseVlr:SetRelation({|| xFilial("CTT")+cArqTmp->CUSTO},"CTT",1,.T.)
	oSClassseVlr:SetRelation({|| xFilial("CTH")+cArqTmp->CLVL },"CTH",1,.T.)
	
	oSClassseVlr:Print()
	
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
ฑฑบPrograma  ณf340Soma  บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR380                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function f340Soma(cTipo,cSegAte)

Local nRetValor		:= 0

	If mv_par07 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOCC == "1" .And. cArqTmp->NIVEL1
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		EndIf
	Else								// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOCC == "2"
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOCC == "1" .And. cArqTmp->NIVEL1
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
ฑฑบPrograma  ณf340Fil   บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR340                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function f340Fil(cSegAte, nDigitAte,cMascCC)

Local lDeixa	:= .T.
Local nCont    := 0

	If mv_par07 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCC == "2"
			lDeixa := .F.
		EndIf
	ElseIf mv_par07 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCC == "1"
			lDeixa := .F.
		EndIf
	EndIf

	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		For nCont := 1 to Val(cSegAte)
			nDigitAte += Val(Subs(cMascCC,nCont,1))	
		Next
		If Len(Alltrim(cArqTmp->CUSTO)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)