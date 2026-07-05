/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr130.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	16

// 17/08/2009 -- Filial com mais de 2 caracteres

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณ CTBR130  ณ Autor ณ Cicero J. Silva   	ณ Data ณ 04.08.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Balancete C.Custo /Item                  		 		  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ CTBR130      											  ณฑฑ
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
User Function CTBR130()

Local aArea := GetArea()
Local oReport          

Local lOk := .T.
Local aCtbMoeda		:= {}
Local nDivide		:= 1           
Local lAtSlComp		:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local lSchedule		:= IsBlind()

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR130"
PRIVATE nomeProg  	:= "CTBR130"  
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE oTRF3
PRIVATE oTRF4
PRIVATE nTotMov	:= 0
PRIVATE nTotdbt	:= 0
PRIVATE nTotcrt	:= 0
PRIVATE titulo

If !FWGetRunSchedule()	
	Pergunte(cPerg,.T.) // Precisa ativar as perguntas antes das definicoes.
EndIf

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	lOk := .F.
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Mostra tela de aviso - atualizacao de saldos				 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cMensagem := OemToAnsi(STR0021)+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += OemToAnsi(STR0022)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += OemToAnsi(STR0023)+chr(13)  		//"rodar a rotina de atualizacao de saldos "

IF !lAtSlComp .and. ! lSchedule
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
EndIf 

If mv_par24 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par24 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par24 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par10,nDivide)
	If Empty(aCtbMoeda[1])                        
		If ! lSchedule
			Help(" ",1,"NOMOEDA")
		EndIf
		lOk := .F.
	Endif
Endif

If lOk
	oReport := ReportDef(aCtbMoeda,nDivide,lSchedule)
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
Static Function ReportDef(aCtbMoeda,nDivide,lSchedule)

Local oReport
Local oSection1
Local oSection2 
Local oBreak
Local cSayItem		:= CtbSayApro("CTD")
Local cSayCC		:= CtbSayApro("CTT")
Local cDesc1 		:= OemToAnsi(STR0001)+ Upper(Alltrim(cSayCC)) +" / "+ Upper(Alltrim(cSayItem) )+ " "	//"Este programa ira imprimir o Balancete de  "
Local cDesc2 		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"
Local aTamItem  	:= TAMSX3("CTD_ITEM")
Local aTamItRes 	:= TAMSX3("CTD_RES")    
Local aTamCC    	:= TAMSX3("CTT_CUSTO")
Local aTamCCRes 	:= TAMSX3("CTT_RES")
Local nTamItem		:= Len(CriaVar("CTD->CTD_DESC"+mv_par10))
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+mv_par10))
Local lSaltaPag		:= Iif(mv_par19==1,.T.,.F.)
Local lPula			:= Iif(mv_par22==1,.T.,.F.)
Local lItemNormal	:= Iif(mv_par21==1,.T.,.F.)
Local lContaNormal	:= Iif(mv_par20==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par23==1,.T.,.F.)
Local cSegAte 	   	:= mv_par13 // Imprimir ate o Segmento?
Local cSegmento		:= mv_par14
Local cSegIni		:= mv_par15
Local cSegFim		:= mv_par16
Local cFiltSegm		:= mv_par17
Local nDigitAte		:= 0
Local nPos			:= 0
Local nDigitos		:= 0
Local lImpMov		:= IIF(mv_par18 == 1,.T.,.F.) // Imprime movimento ?
Local cSepara1		:= ""
Local cSepara2		:= ""
Local aSetOfBook 	:= CTBSetOf(mv_par08)	
Local cMascItem		:= IIF (Empty(aSetOfBook[7]),"",RetMasCtb(aSetOfBook[7],@cSepara1))//Mascara do Centro de Custo
Local cMascCC		:= IIF (Empty(aSetOfBook[6]),GetMv("MV_MASCCUS"),RetMasCtb(aSetOfBook[6],@cSepara2))//Mascara da Conta
Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)
Local cDescMoeda 	:= aCtbMoeda[2]
Local bCdITEM		:= {|| EntidadeCTB(cArqTmp->ITEM,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.) }
Local bCdITRES		:= {|| EntidadeCTB(cArqTmp->ITEMRES,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.) }
Local bCdCUSTO		:= {|| EntidadeCTB(cArqTmp->CUSTO,0,0,20,.F.,cMascCC,cSepara2,,,,,.F.) }
Local bCdCCRES		:= {|| EntidadeCTB(cArqTmp->CCRES,0,0,20,.F.,cMascCC,cSepara2,,,,,.F.) }
Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)// Parameter to activate Red Storn

titulo := OemToAnsi(STR0003)+Upper(Alltrim(cSayCC))+" / "+ Upper(Alltrim(cSayItem)) 	//"Balancete de Verificacao"

oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayCC,cSayItem,nDivide,lSchedule)},cDesc1+cDesc2)
oReport:SetLandScape(.T.)

// Sessao 1
oSection1 := TRSection():New(oReport,cSayCC ,{"cArqTmp","CTT"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)

//Somente sera impresso centro de custo analitico	
TRCell():New(oSection1,"CUSTO"	,"cArqTmp",STR0025	,/*Picture*/,aTamCC[1]		,/*lPixel*/,bCdCUSTO) //"C๓digo"
TRCell():New(oSection1,"CCRES"	,"cArqTmp",STR0026	,/*Picture*/,aTamCCRes[1]	,/*lPixel*/,bCdCCRES) //"C๓d. reduzido"
TRCell():New(oSection1,"DESCCC"	,"cArqTmp",STR0027	,/*Picture*/,nTamCC			,/*lPixel*/,/*{|| }*/) //"Descricao"

TRPosition():New( oSection1, "CTT", 1, {|| xFilial("CTT") + cArqTMP->CUSTO })

If lContaNormal
	oSection1:Cell("CCRES"	):Disable()
Else
	oSection1:Cell("CUSTO"	):Disable() 
EndIf

If lSaltaPag
	oSection1:SetPageBreak(.T.)
EndIf

//oSection1:SetLineCondition({|| IIF(cArqTmp->TIPOCONTA == "1",.F.,.T.) })

// Sessao 2
oSection2 := TRSection():New(oSection1,cSayItem,{"cArqTmp","CTD"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage()

	TRCell():New(oSection2,"ITEM"		,"cArqTmp",STR0025	,/*Picture*/,aTamItem[1]+5	,/*lPixel*/, bCdITEM  )// Codigo do Item          //"C๓digo"
	TRCell():New(oSection2,"ITEMRES" 	,"cArqTmp",STR0026	,/*Picture*/,aTamItRes[1]	,/*lPixel*/, bCdITRES )// Codigo Reduzido do Item //"C๓d. reduzido"
	TRCell():New(oSection2,"DESCITEM"	,"cArqTmp",STR0027	,/*Picture*/,nTamItem		,/*lPixel*/,/*{|| }*/) //"Descricao"
	TRCell():New(oSection2,"SALDOANT"	,"cArqTmp",STR0028	,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,iif(lRedStorn,cArqTmp->CCNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"RIGHT")// Saldo Anterior //"Saldo anterior"
	TRCell():New(oSection2,"SALDODEB"	,"cArqTmp",STR0029	,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,iif(lRedStorn,cArqTmp->CCNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.,lColDbCr)},/*"RIGHT"*/,,"RIGHT")// Debito //"D้bito"
	TRCell():New(oSection2,"SALDOCRD"	,"cArqTmp",STR0030	,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,iif(lRedStorn,cArqTmp->CCNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.,lColDbCr)},/*"RIGHT"*/,,"RIGHT")// Credito //"Cr้dito"
	If lImpMov //Imprime Coluna Movimento!!
		TRCell():New(oSection2,"MOVIMENTO","cArqTmp",STR0031	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR-2,nDecimais,.T.,cPicture,iif(lRedStorn,cArqTmp->CCNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"RIGHT")// Movimento do Periodo //"Movimento do periodo"
	EndIf
	TRCell():New(oSection2,"SALDOATU"	,"cArqTmp",STR0032	,/*Picture*/,TAM_VALOR	    ,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,iif(lRedStorn,cArqTmp->CCNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"RIGHT")// Saldo Atual //"Saldo atual"

	TRPosition():New( oSection2, "CTD", 1, {|| xFilial("CTD") + cArqTMP->ITEM })
	
	If lItemNormal
		oSection2:Cell("ITEMRES"	):Disable()
	Else
		oSection2:Cell("ITEM"	):Disable() 
	EndIf
	
	oSection2:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOITEM == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->TIPOITEM;
								)  })
	
	oSection2:SetLineCondition({|| f140Fil(cSegAte,cSegmento,nDigitAte,cSegIni,cSegFim,cFiltSegm,nPos,nDigitos) })

// Totais das sessoes	
	oBreak:= TRBreak():New(oSection2,{ || cArqTmp->CUSTO },STR0020,.F.)
	
	oBreak:OnBreak({ || nTotdbt := oTRF1:GetValue(),nTotcrt := oTRF2:GetValue() })

	oTRF1 := TRFunction():New(oSection2:Cell("SALDODEB"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ || f140Soma("D",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF1:disable()
	 		 TRFunction():New(oSection2:Cell("SALDODEB"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotdbt,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection2)	
	oTRF2 := TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ || f140Soma("C",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF2:disable()
			 TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection2)
	
	If lImpMov	
		If lRedStorn
			TRFunction():New(oSection2:Cell("MOVIMENTO"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := RedStorTt(nTotdbt,nTotcrt,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T"),;
							   ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture," ",,,,,,lPrintZero,.F.,lColDbCr),)},.F.,.F.,.F.,oSection2)
		Else
			TRFunction():New(oSection2:Cell("MOVIMENTO"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := (nTotcrt - nTotdbt),;
			/*IIF ( lImpMov,*/ 	IIF ( nTotMov < 0, ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr),;
							   		IIF ( nTotMov > 0, ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr),nil) )/*, nil)*/ )},.F.,.F.,.F.,oSection2)
		Endif
	EndIf     
	
// Total geral
	oTRF3 := TRFunction():New(oSection2:Cell("SALDODEB"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f140Soma("D",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF3:disable()
			 TRFunction():New(oSection2:Cell("SALDODEB"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF3:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSection2)

	oTRF4 := TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f140Soma("C",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF4:disable()
			 TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF4:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSection2)
	
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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayCC,cSayItem,nDivide,lSchedule)

Local oSection1 	:= oReport:Section(1)
Local oSection2		:= oReport:Section(1):Section(1)
Local oMeter		:= NIL
Local oText			:= NIL
Local oDlg 			:= NIL
Local cArqTmp		:= ""
Local cFiltro		:= oSection1:GetAdvplExp('CTD')
Local dDataLP		:= mv_par26
Local dDataFim		:= mv_par02
Local lImpMov		:= Iif(mv_par18==1,.T.,.F.)
Local lImpAntLP		:= Iif(mv_par25==1,.T.,.F.)
Local lImpConta		:= .F.
Local cCtaIni		:= Space(Len(CriaVar("CT1_CONTA")))
Local cCtaFim		:= Repl('Z',Len(CriaVar("CT1_CONTA")))      
Local lEnd 			:= .F.
Local nPage			:= Iif(Empty(mv_par11) .Or. mv_par11 < 1, 1, mv_par11)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Carrega titulo do relatorio: Analitico / Sintetico			 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF mv_par07 == 1
		Titulo:=	OemToAnsi(STR0006)+ Upper(Alltrim(cSayCC)) + " / "+Upper(Alltrim(cSayItem)) 	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par07 == 2
		Titulo:=	OemToAnsi(STR0007) + Upper(Alltrim(cSayCC)) + " / "+ Upper(Alltrim(cSayItem))	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par07 == 3
		Titulo:=	OemToAnsi(STR0008) + Upper(Alltrim(cSayCC)) + " / "+ Upper(Alltrim(cSayItem))	//"BALANCETE DE  "
	EndIf
	
	Titulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + OemToAnsi(STR0010) + Dtoc(mv_par02) + ;
					OemToAnsi(STR0011) + cDescMoeda
	
	If mv_par12 > "1"			
		Titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
	Endif
	
	oReport:SetPageNumber(nPage) //mv_par14	-	Pagina Inicial
	oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta Arquivo Temporario para Impressao							  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lSchedule
		CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			mv_par01,mv_par02,"CTV","",cCtaIni,cCtaFim,mv_par03,mv_par04,;
			 mv_par05,mv_par06,,,mv_par10,mv_par12,aSetOfBook,mv_par14,;
			  mv_par15,mv_par16,mv_par17,!lImpMov,lImpConta,2,"CTT",lImpAntLP,dDataLP,nDivide)
	Else
		MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			 mv_par01,mv_par02,"CTV","",cCtaIni,cCtaFim,mv_par03,mv_par04,;
			  mv_par05,mv_par06,,,mv_par10,mv_par12,aSetOfBook,mv_par14,;
			   mv_par15,mv_par16,mv_par17,!lImpMov,lImpConta,2,"CTT",lImpAntLP,dDataLP,;
				nDivide,,,,,,,,,,,,,,,,cFiltro)},;				
				 OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor rio..."
				  OemToAnsi(STR0003)+Upper(Alltrim(cSayCC)) +" / " +  Upper(Alltrim(cSayItem)) )     //"Balancete Verificacao C.CUSTO /ITEM
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Inicia a impressao do relatorio                                               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("cArqTmp")
	dbGotop()
	//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
	//nao esta disponivel e sai da rotina.
	If !( RecCount() == 0 .And. !Empty(aSetOfBook[5]) )		
		oSection2:SetParentFilter( { |cParam| cArqTmp->CUSTO == cParam },{ || cArqTmp->CUSTO })// SERVE PARA IMPRIMIR O TITULO DA SECAO PAI
		oSection1:Print()		
	EndIf
	
dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
If Select("cArqTmp") == 0
//	Ferase(cArqTmp+GetDBExtension())
//	FErase("cArqInd"+OrdBagExt())
EndIf	
dbselectArea("CT2")


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณf140Soma  บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR130                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function f140Soma(cTipo,cSegAte)

Local nRetValor		:= 0

	If mv_par07 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOITEM == "1" .And. cArqTmp->NIVEL1
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		Endif                   
	Else
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOITEM == "2"
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			Endif
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOITEM == "1" .And. cArqTmp->NIVEL1
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
		EndIf
	Endif	
	
Return nRetValor                                                                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณf140Fil   บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR130                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function f140Fil(cSegAte,cSegmento,nDigitAte,cSegIni,cSegFim,cFiltSegm,nPos,nDigitos)
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

	If mv_par09 == 2						// Saldos Zerados nao serao impressos
		If (Abs(cArqTmp->SALDOANT)+Abs(cArqTmp->SALDOATU)+Abs(cArqTmp->SALDODEB)+Abs(cArqTmp->SALDOCRD)) == 0
			lDeixa := .F.
		EndIf
	EndIf                                        
	
	// Verifica Se existe filtragem Ate o Segmento
	If !Empty(cSegAte)
		For nCont := 1 to Val(cSegAte)
			nDigitAte += Val(Subs(cMascItem,nCont,1))	
		Next
	EndIf		

	//Filtragem ate o Segmento do centro de custo(antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->ITEM)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)


//-------------------------------------------------------------------
/*/{Protheus.doc} ScheDef()

Defini็ใo de Static Function SchedDef para o novo Schedule

@author TOTVS
@since 03/06/2021
@version MP12
/*/
//-------------------------------------------------------------------

Static Function SchedDef()

Local aParam := {}

aParam := { "R",;            // Tipo R para relat๓rio P para processo
			"CTR130",;       // Pergunte do relat๓rio, caso nใo use, passar ParamDef
			,;               // Alias     
			,;               // Array de ordens
			STR0033 }        // Tํtulo 


Return aParam
