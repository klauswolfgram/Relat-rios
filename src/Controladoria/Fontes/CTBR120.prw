/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr120.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	17	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR120  ³ Autor ³ Cicero J. Silva   	³ Data ³ 01.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete por Item                      			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Ctbr120        											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR120()

Local aArea := GetArea()
Local oReport          
Local lOk := .T.
Local aCtbMoeda		:= {}
Local aSetOfBook
Local nDivide		:= 1
Local lAtSlComp		:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local cFilIni		:= cFilAnt

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR120"
PRIVATE nomeProg  	:= "CTBR120"
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE nTotMov	:= 0
PRIVATE titulo		:= "" 
PRIVATE aSelFil	:= {} 

If Type("lExterno") == "U"
	PRIVATE lExterno
EndIf       
		
Pergunte( cPerg, .T. )
				
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra tela de aviso - atualizacao de saldos				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMensagem := OemToAnsi(STR0022)+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += OemToAnsi(STR0023)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += OemToAnsi(STR0024)+chr(13)  		//"rodar a rotina de atualizacao de saldos "

IF !lAtSlComp
	If !MsgYesNo(cMensagem,OemToAnsi(STR0025))	//"ATEN€O"
		lOk := .F.
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par06) // Set Of Books
	lOk := .F.
Else
	aSetOfBook := CTBSetOf(mv_par06)		
EndIf 

If mv_par20 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par20 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par20 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide) // Moeda?
	If Empty(aCtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		lOk := .F.
	Endif
Endif

If lOk .And. mv_par23 == 1 .And. Len( aSelFil ) <= 0
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		lOk := .F.
	EndIf 
EndIf  

If lOk
	oReport := ReportDef(aSetOfBook,aCtbMoeda,nDivide)
	oReport:PrintDialog()
EndIf


//Limpa os arquivos temporários 
CTBGerClean()

RestArea(aArea)
cFilAnt := cFilIni

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  01/08/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aCtbMoeda  - Matriz ref. a moeda                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(aSetOfBook,aCtbMoeda,nDivide)

Local oReport
Local oSCtrItem                        

Local cSayItem		:= CtbSayApro("CTD")
Local cDesc1 		:= OemToAnsi(STR0001)+ Alltrim(Upper(cSayItem)) +" "	//"Este programa ira imprimir o Balancete de  "
Local cDesc2 		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"

Local aTamItem  	:= TAMSX3("CTD_ITEM")
Local aTamItRes 	:= TAMSX3("CTD_RES")    
Local nTamItem		:= Len(CriaVar("CTD->CTD_DESC"+mv_par08))
 
Local lPula			:= Iif(mv_par17==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par19==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)

Local cSegAte 	   	:= mv_par11 // Imprimir ate o Segmento?
Local nDigitAte		:= 0
Local cSepara1		:= ""
Local cMascItem		:= IIF (Empty(aSetOfBook[7]),GetMv("MV_MASCCTD"),RetMasCtb(aSetOfBook[7],@cSepara1))// Mascara do Item Contabil
Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)
Local cDescMoeda 	:= aCtbMoeda[2]
Local lMov 			:= IIF(mv_par16==1,.T.,.F.) // Imprime movimento ?
Local bCondITEM 	:= {|| IIF(cArqTmp->TIPOITEM=="1","","  ")+EntidadeCTB(cArqTmp->ITEM,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.) }
Local bCondITEMRES := {|| IIF(cArqTmp->TIPOITEM=="1",	EntidadeCTB(cArqTmp->ITEM,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.),;
	  										"  " + EntidadeCTB(cArqTmp->ITEMRES,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.) ) }
Local lColDbCr 		:= If(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= If(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)// Parameter to activate Red Storn

	titulo			:= OemToAnsi(STR0003)+Alltrim(Upper(cSayItem)) 	//"Balancete de Verificacao Conta / "

	
	oReport := TReport():New(nomeProg,titulo,,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayItem,nDivide)},cDesc1+cDesc2)
	oReport:SetTotalInLine(.F.)
	oReport:EndPage(.T.)
	
	If lMov
		oReport:SetLandScape(.T.)
	Else
		oReport:SetPortrait(.T.)
	EndIf
	
	// Sessao 1
	oSCtrItem := TRSection():New(oReport,cSayItem,{"cArqTmp","CTD"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
	oSCtrItem:SetTotalInLine(.F.)
	oSCtrItem:SetHeaderPage()
	
	TRCell():New(oSCtrItem,"ITEM"			,"cArqTmp",STR0026	,/*Picture*/,aTamItem[1] + 4	,/*lPixel*/, bCondITEM)// Codigo da Conta
	TRCell():New(oSCtrItem,"ITEMRES"		,"cArqTmp",STR0027 	,/*Picture*/,aTamItRes[1]	,/*lPixel*/, bCondITEMRES )// Codigo Reduzido da Conta
	TRCell():New(oSCtrItem,"DESCITEM"	,"cArqTmp",STR0028 	,/*Picture*/,nTamItem		,/*lPixel*/,/*{|| }*/)// Descricao do Item
	TRCell():New(oSCtrItem,"SALDOANT"	,"cArqTmp",STR0029 	,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR-3,nDecimais,.T.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"CENTER")// Saldo Anterior
	TRCell():New(oSCtrItem,"SALDODEB"	,"cArqTmp",STR0030 	,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR-3,nDecimais,.F.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"RIGHT"*/,,"CENTER")// Debito
	TRCell():New(oSCtrItem,"SALDOCRD"	,"cArqTmp",STR0031 	,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR-3,nDecimais,.F.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"RIGHT"*/,,"CENTER")// Credito
	TRCell():New(oSCtrItem,"MOVIMENTO"	,"cArqTmp",STR0032 	,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR-3,nDecimais,.T.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"CENTER")// Movimento do Periodo
	TRCell():New(oSCtrItem,"SALDOATU"	,"cArqTmp",STR0033  	,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR-3,nDecimais,.T.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.)},/*"RIGHT"*/,,"CENTER")// Saldo Atual
//	TRCell():New(oSCtrItem,"TIPOCLVL"	,"cArqTmp","TIPOCLVL"		,/*Picture*/,01		,/*lPixel*/,/*{|| }*/)// Situacao
	TRCell():New(oSCtrItem,"TIPOITEM"	,"cArqTmp",STR0034 	,/*Picture*/,01				,/*lPixel*/,/*{|| }*/)// Conta Analitica / Sintetica           
	TRCell():New(oSCtrItem,"NIVEL1"		,"cArqTmp",STR0035 	,/*Picture*/,01				,/*lPixel*/,/*{|| }*/)// Logico para identificar se 
	
	oSCtrItem:Cell("SALDOANT"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDODEB"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDOCRD"):lHeaderSize  := .F.
	oSCtrItem:Cell("MOVIMENTO"):lHeaderSize := .F.
	oSCtrItem:Cell("SALDOATU"):lHeaderSize  := .F.

	TRPosition():New( oSCtrItem, "CTD", 1, {|| xFilial("CTD") + cArqTMP->ITEM  })
	
	oSCtrItem:Cell("TIPOITEM" 	):Disable()
	oSCtrItem:Cell("NIVEL1"  	):Disable()
	
	If lNormal //Se Imprime Codigo Reduzido
		oSCtrItem:Cell("ITEMRES"):Disable()
	Else
		oSCtrItem:Cell("ITEM"):Disable()	
	EndIf
	
	If !lMov //Nao Imprime Coluna Movimento!!
		oSCtrItem:Cell("MOVIMENTO"):Disable()	
	EndIf
	
	oSCtrItem:OnPrintLine( {|| cFilAnt := cArqTmp->FILIAL, ;
								( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOITEM == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->TIPOITEM;
								)  })
	
	oSCtrItem:SetLineCondition({|| cFilAnt := cArqTmp->FILIAL, f120Fil(cSegAte, nDigitAte,cMascItem) })
	
	oTRF1 := TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f120Soma("D",cSegAte) },.F.,.F.,.F.,oSCtrItem)
	 		 TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF1:GetValue(),,,TAM_VALOR-3,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F., lColDbCr) },.T.,.F.,.F.,oSCtrItem)

	oTRF2 := TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f120Soma("C",cSegAte) },.F.,.F.,.F.,oSCtrItem)
	 		 TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF2:GetValue(),,,TAM_VALOR-3,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F., lColDbCr) },.T.,.F.,.F.,oSCtrItem)
	
	If lMov
		If lRedStorn
			TRFunction():New(oSCtrItem:Cell("MOVIMENTO"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := RedStorTt(oTRF1:GetValue(),oTRF2:GetValue(),cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T"),;
					ValorCTB(nTotMov,,,TAM_VALOR-3,nDecimais,.T.,cPicture,Iif(nTotMov<0,"1","2"),,,,,,lPrintZero,.F.,lColDbCr),;
					)},.T.,.F.,.F.,oSCtrItem)
		Else
			TRFunction():New(oSCtrItem:Cell("MOVIMENTO"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := (oTRF2:GetValue() - oTRF1:GetValue()),;
			IIF ( nTotMov < 0,;
					ValorCTB(nTotMov,,,TAM_VALOR-3,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr),;
			IIF ( nTotMov > 0,;
					ValorCTB(nTotMov,,,TAM_VALOR-3,nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr),;
					nil) ) )},.T.,.F.,.F.,oSCtrItem)
		Endif
	EndIf 
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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayItem,nDivide)

Local oSCtrItem 	:= oReport:Section(1)

Local cArqTmp		:= ""
Local cFiltro		:= oSCtrItem:GetAdvplExp()
Local cCtaIni		:= Space(Len(CriaVar("CT1_CONTA")))
Local cCtaFim		:= Repl('Z',Len(CriaVar("CT1_CONTA")))            
Local lImpSint		:= Iif(mv_par05=1 .Or. mv_par05 ==3,.T.,.F.)
Local dDataFim 		:= mv_par02
Local lImpAntLP		:= Iif(mv_par21==1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par07==1,.T.,.F.) 
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)
Local dDataLP  		:= mv_par22
Local l132			:= IIF(mv_par16 == 1,.F.,.T.)// Se imprime saldo movimento do periodo
Local lImpConta		:= .F.   
Local nK			:= 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza titulo do relatorio: Analitico / Sintetico			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF mv_par05 == 1
		titulo :=	OemToAnsi(STR0006)+ Alltrim(Upper(cSayItem)) 	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par05 == 2                                  
		titulo :=	OemToAnsi(STR0007) + Alltrim(Upper(cSayItem))	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par05 == 3
		titulo :=	OemToAnsi(STR0008) + Alltrim(Upper(cSayItem))	//"BALANCETE DE  "
	EndIf
	
	titulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + OemToAnsi(STR0010) + Dtoc(mv_par02) + OemToAnsi(STR0011) + cDescMoeda
	
	If mv_par10 > "1"
		titulo += " (" + Tabela("SL", mv_par10, .F.) + ")"
	EndIf
	
	If nDivide > 1			
		titulo += " (" + OemToAnsi(STR0021) + Alltrim(Str(nDivide)) + ")"
	EndIf	
	
	oReport:SetPageNumber(mv_par09) // Pagina Inicial
	oReport:SetCustomText( { || CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao							   ;
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;				
				CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				 mv_par01,mv_par02,"CTU","CTD",cCtaIni,cCtaFim,,,mv_par03,mv_par04,,,mv_par08,;
				  mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,;
				   l132,lImpConta,,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro,,,,,,,,,,,,aSelFil) },;
					OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor rio..."
					 OemToAnsi(STR0003)+cSayItem)     //"Balancete Verificacao Conta /" 
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Select("cArqTmp") == 0  //se nao conseguiu criar arquivo retorna
		Return
	EndIf

	dbSelectArea("cArqTmp")
	dbGotop()
	
	oSCtrItem:NoUserFilter()
	
	oSCtrItem:Print()

	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
	If Select("cArqTmp") == 0
		FErase(cArqTmp+GetDBExtension())
		FErase("cArqInd"+OrdBagExt())
	EndIf
	dbselectArea("CT2")

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f120Soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f120Soma(cTipo,cSegAte)

Local nRetValor		:= 0

	If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f120Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f120Fil(cSegAte, nDigitAte,cMascItem)

Local lDeixa	:= .T.


	If mv_par05 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOITEM == "2"
			lDeixa := .F.
		EndIf
	ElseIf mv_par05 == 2				// So imprime Analiticas
		If cArqTmp->TIPOITEM == "1"
			lDeixa := .F.
		EndIf
	EndIf
	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)

		nDigitAte := CtbRelDig(cSegAte,cMascItem) 	

		If Len(Alltrim(cArqTmp->ITEM)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)

