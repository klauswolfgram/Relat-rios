/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr245.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	16


// 17/08/2009 -- Filial com mais de 2 caracteres
// 09/09/2011 - Alterado tradução das colunas de Debito e Credito para Pais Mexico

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR245  ³ Autor ³ Cicero J. Silva   	³ Data ³ 09.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete 1 Entidade filtrada por conta 			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_ctbr245()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR245()

Local aArea := GetArea()
Local oReport          

Local lOk := .T.
Local aCtbMoeda		:= {}
Local nDivide		:= 1


PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR245"
PRIVATE nomeProg  	:= "CTBR245"  
PRIVATE oFT1
PRIVATE oFT2
PRIVATE oFT3
PRIVATE nTotMov
PRIVATE nTotcrt
PRIVATE nTotdbt

Pergunte(cPerg,.T.) // Precisa ativar as perguntas antes das definicoes.

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	lOk := .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par09) // Set Of Books
	lOk := .F.
EndIf 

If mv_par23 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par23 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par23 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par11,nDivide) // Moeda?
   If Empty(aCtbMoeda[1])
      Help(" ",1,"NOMOEDA")
      lOk := .F.
   Endif
Endif
If lOk
	If (mv_par30 == 1) .and. ( Empty(mv_par31) .or. Empty(mv_par32) )
		cMensagem	:= STR0028	// "Favor preencher os parametros Grupos Receitas/Despesas e Data Sld Ant. Receitas/Despesas ou "
		cMensagem	+= STR0029	// "deixar o parametro Ignora Sl Ant.Rec/Des = Nao "
		MsgAlert(cMensagem,"Ignora Sl Ant.Rec/Des")	
		lOk	:= .F.	
    EndIf
EndIf
                
If lOk
	oReport := ReportDef(aCtbMoeda,nDivide)
	oReport:PrintDialog()
EndIf

//Limpa os arquivos temporários 
CTBGerClean()
	
RestArea(aArea)

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
Static Function ReportDef(aCtbMoeda,nDivide)

Local oReport
Local oSection1

LOCAL cDesc1 		:= STR0001	//"Este programa ira imprimir o balancete de uma entidade com filtro por "
LOCAL cDesc2 		:= STR0002  //"outras entidades de acordo com os parametros solicitados pelo usuario. "
Local cDesc3		:= ""

Local titulo 		:= STR0003 	//"Balancete de uma entidade filtrada por outra entidade"

Local aTamCC		:= TAMSX3("CTT_CUSTO")
Local aTamCCRes		:= TAMSX3("CTT_RES")
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+mv_par11))

Local aTamItem 		:= TAMSX3("CTD_ITEM")
Local aTamItRes 	:= TAMSX3("CTD_RES")    
Local nTamItem		:= Len(CriaVar("CTD->CTD_DESC"+mv_par11))

Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local aTamCvRes 	:= TAMSX3("CTH_RES")
Local nTamClVl		:= Len(CriaVar("CTH->CTH_DESC"+mv_par11))

Local lMov 			:= IIF(mv_par19==1,.T.,.F.) //l132 := .T. Imprime movimento ?
Local lPula	  		:= Iif(mv_par20==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par22==1,.T.,.F.)

Local lPrintZero	:= Iif(mv_par21==1,.T.,.F.)
Local cSegAte 	   	:= mv_par14 // Imprimir ate o Segmento?

Local nDigitAte		:= 0 
Local cClasse		:= ""
Local cSeparador	:= ""
Local cMascara		:= ""

Local aSetOfBook := CTBSetOf(mv_par09)	
Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par11)
Local cDescMoeda 	:= aCtbMoeda[2]
Local lColDbCr 		:= If(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= If(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.) // CAZARINI - 20/06/2017 - Parameter
Local bNormal		:= { || cArqTmp->NORMAL }

	Do Case
	Case mv_par03 == 1
		cMascara	:= IIF (Empty(aSetOfBook[6]),"",RetMasCtb(aSetOfBook[6],@cSeparador)) // Mascara do Centro de Custo
		cClasse	:= "TIPOCC"
	Case mv_par03 == 2
		cMascara	:= IIF (Empty(aSetOfBook[7]),"",RetMasCtb(aSetOfBook[7],@cSeparador)) // Mascara do Item
		cClasse	:= "TIPOITEM"
	Case mv_par03 == 3
		cMascara	:= IIF (Empty(aSetOfBook[8]),"",RetMasCtb(aSetOfBook[8],@cSeparador)) // Mascara da Classe Valor
		cClasse	:= "TIPOCLVL"
	EndCase

oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,nDivide)},cDesc1+cDesc2+cDesc3)
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)
	If lMov
		oReport:SetLandScape(.T.)
	Else
		oReport:SetPortrait(.T.)
	EndIf

// Sessao 1
oSection1 := TRSection():New(oReport,STR0030 /*"P E R I O D O"*/ ,{"cArqTmp"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oSection1:SetTotalInLine(.F.)


	If mv_par03 == 1
		TRCell():New(oSection1,"CUSTO"		,"cArqTmp",STR0031/*"CODIGO"*/				,/*Picture*/, aTamCC[1]		,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CUSTO,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) })// Codigo do Centro de Custo
		TRCell():New(oSection1,"CCRES"		,"cArqTmp",STR0032/*"CODIGO REDUZIDO"*/	,/*Picture*/, aTamCCRes[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CCRES,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) })	// Codigo Reduzido do Centro de Custo
		TRCell():New(oSection1,"DESCCC" 	,"cArqTmp",STR0033/*"D E S C R I C A O"*/	,/*Picture*/, nTamCC		,/*lPixel*/,/*{|| }*/)	// Descricao do Centro de Custo
			If lNormal
				oSection1:Cell("CCRES"):Disable()
			Else
				oSection1:Cell("CUSTO"):Disable()
			EndIf
			If lRedStorn
				bNormal := {|| Posicione("CTT",1,xFilial("CTT")+cArqTmp->CUSTO,"CTT_NORMAL") }		
			Endif
	ElseIf mv_par03 == 2
		TRCell():New(oSection1,"ITEM"		,"cArqTmp",STR0031/*"CODIGO"*/				,/*Picture*/, aTamItem[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->ITEM   ,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) })// Codigo do Item          
		TRCell():New(oSection1,"ITEMRES" 	,"cArqTmp",STR0032/*"CODIGO REDUZIDO"*/		,/*Picture*/, aTamItRes[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->ITEMRES,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) })// Codigo Reduzido do Item
		TRCell():New(oSection1,"DESCITEM"	,"cArqTmp",STR0033/*"D E S C R I C A O"*/	,/*Picture*/, nTamItem		,/*lPixel*/,/*{|| }*/)// Descricao do Item
		If lNormal
			oSection1:Cell("ITEMRES"	):Disable()
		Else
			oSection1:Cell("ITEM"	):Disable()
		EndIf
		If lRedStorn
			bNormal := {|| Posicione("CTD",1,xFilial("CTD")+cArqTmp->ITEM,"CTD_NORMAL") }		
		Endif
	ElseIf mv_par03 == 3
		TRCell():New(oSection1,"CLVL"		,"cArqTmp",STR0031/*"CODIGO"*/				,/*Picture*/, aTamClVl[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CLVL   ,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) })// Codigo da Classe de Valor
		TRCell():New(oSection1,"CLVLRES"	,"cArqTmp",STR0032/*"CODIGO REDUZIDO"*/		,/*Picture*/, aTamCVRes[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CLVLRES,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) })// Cod. Red. Classe de Valor
		TRCell():New(oSection1,"DESCCLVL"	,"cArqTmp",STR0033/*"D E S C R I C A O"*/	,/*Picture*/, nTamClVl		,/*lPixel*/,/*{|| }*/)// Descricao da Classe de Valor
		If lNormal
			oSection1:Cell("CLVLRES"	):Disable()
		Else
			oSection1:Cell("CLVL"	):Disable()
		EndIf
		If lRedStorn
			bNormal := {|| Posicione("CTH",1,xFilial("CTH")+cArqTmp->CLVL,"CTH_NORMAL") }		
		Endif
	EndIf
	TRCell():New(oSection1,"SALDOANT"		,"cArqTmp",STR0034 /*"SALDO ANTERIOR      ."*/	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})// Saldo Anterior
	TRCell():New(oSection1,"SALDODEB"		,"cArqTmp",STR0035 /*"DEBITO              ."*/	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.,lColDbCr)})// Debito
	TRCell():New(oSection1,"SALDOCRD"		,"cArqTmp",STR0036 /*"CREDITO             ."*/	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.,lColDbCr)})// Credito

	If lMov //Imprime Coluna Movimento!!
		TRCell():New(oSection1,"MOVIMENTO"		,"cArqTmp",STR0037 /*"MOVIMENTO PERIODO   ."*/	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})// Movimento do Periodo
	EndIf

	TRCell():New(oSection1,"SALDOATU"		,"cArqTmp",STR0038 /*"SALDO ATUAL         ."*/	,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})// Saldo Atual
	TRCell():New(oSection1,"TIPOCC"			,"cArqTmp",STR0039 /*"TIPOCC"*/					,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Centro Custo / Sintetica           
	TRCell():New(oSection1,"TIPOITEM"		,"cArqTmp",STR0040 /*"TIPOITEM"*/	   			,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Conta Analitica / Sintetica           
	TRCell():New(oSection1,"TIPOCLVL"		,"cArqTmp",STR0041 /*"TIPOCLVL"*/				,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Conta Analitica / Sintetica           
	TRCell():New(oSection1,"NIVEL1"			,"cArqTmp",STR0042 /*"NIVEL1"*/					,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Logico para identificar se 

	oSection1:Cell("TIPOCC"	):Disable()
	oSection1:Cell("TIPOITEM"	):Disable()
	oSection1:Cell("TIPOCLVL"	):Disable()
	oSection1:Cell("NIVEL1"	):Disable()
	

	oSection1:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->&(cClasse) == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->&(cClasse);
								)  })
	
	oSection1:SetLineCondition({|| f245Fil(cSegAte, nDigitAte,cMascara) })

	TRFunction():New(oSection1:Cell("SALDOANT"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ""},.T.,.F.,.F.,oSection1)
	
	oFT1 :=	TRFunction():New(oSection1:Cell("SALDODEB"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f245Soma("D",cSegAte) },.F.,.F.,.F.,oSection1)
			TRFunction():New(oSection1:Cell("SALDODEB"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || (nTotdbt := oFT1:GetValue(),ValorCTB(nTotdbt,,,TAM_VALOR,nDecimais,.F.,cPicture,/*"1"*/,,,,,,lPrintZero,.F.,lColDbCr)) },.T.,.F.,.F.,oSection1)
	
	oFT2 :=	TRFunction():New(oSection1:Cell("SALDOCRD"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f245Soma("C",cSegAte) },.F.,.F.,.F.,oSection1)
					TRFunction():New(oSection1:Cell("SALDOCRD"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || (nTotcrt := oFT2:GetValue(),ValorCTB(nTotcrt,,,TAM_VALOR,nDecimais,.F.,cPicture,/*"2"*/,,,,,,lPrintZero,.F.,lColDbCr)) },.T.,.F.,.F.,oSection1)
	
	If lMov //Imprime Coluna Movimento!!
		If lRedStorn
			TRFunction():New(oSection1:Cell("MOVIMENTO"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := RedStorTt(nTotdbt,nTotcrt,,,"T"),;
				 ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(nTotMov,"1","2"),,,,,,lPrintZero,.F.,lColDbCr))},.T.,.F.,.F.,oSection1)
		Else
			TRFunction():New(oSection1:Cell("MOVIMENTO"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := (nTotcrt - nTotdbt),;
			IIF ( nTotMov < 0,;
				 ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),;
				 IIF ( nTotMov > 0,ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.),nil) ))},.T.,.F.,.F.,oSection1)
		Endif
	EndIf

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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,nDivide)

Local oSection1 	:= oReport:Section(1)

Local cArqTmp   	:= ""                  
Local cFiltro		:= oSection1:GetAdvplExp()  /*aReturn[7]*/
Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")

Local dDataLP  		:= mv_par25
Local dDataFim 		:= mv_par02

Local lImpConta		:= .F.
Local lImpAntLP		:= Iif(mv_par24==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par21==1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par10==1,.T.,.F.) 
Local l132 			:= IIF(mv_par22==1,.F.,.T.) // Invertido para atende a necessidade da rotina geradora do cArqTmp
Local lImpSint		:= Iif(mv_par08=1 .Or. mv_par08 ==3,.T.,.F.)

Local lRecDesp0		:= Iif(mv_par30==1,.T.,.F.)
Local cRecDesp		:= mv_par31
Local dDtZeraRD		:= mv_par32

Local cCtaIni		:= mv_par06
Local cCtaFim		:= mv_par07
Local cCCIni		:= ""
Local cCCFim		:= ""
Local cItemIni		:= ""
Local cItemFim		:= ""
Local cClVlIni		:= ""
Local cClVlFim		:= ""
Local cSegAte   	:= mv_par14
Local cAlias		:= ""
Local cClasse		:= ""

	If mv_par03 == 1
		cAlias	:= "CT3"                    
		cCCIni	:= mv_par04
		cCCFim	:= mv_par05
	ElseIf mv_par03 == 2
		cAlias	:= "CT4"   
		cItemIni:= mv_par04
		cItemFim:= mv_par05	
		cCCIni	:= mv_par26
		cCCFim	:= mv_par27
	ElseIf mv_par03 == 3
		cAlias	:= "CTI"   
		cClVlIni:= mv_par04
		cClVlFim:= mv_par05
		cCCIni	:= mv_par26
		cCCFim	:= mv_par27
		cItemIni := mv_par28
		cItemFim := mv_par29
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF mv_par08 == 1
		Titulo:=	STR0006 	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par08 == 2
		Titulo:=	STR0007 	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par08 == 3
		Titulo:=	STR0008 	//"BALANCETE DE  "
	EndIf
	
	If mv_par03 == 1
		Titulo	+= Upper(cSayCusto)
	ElseIf mv_par03 == 2
		Titulo	+= Upper(cSayItem)
	ElseIf mv_par03 ==3 
		Titulo	+= Upper(cSayClVl)
	EndIf
	
	Titulo += 	STR0009 + DTOC(mv_par01) + STR0010 + Dtoc(mv_par02) + ;
					STR0011 + cDescMoeda
	
	If mv_par13 > "1"
		Titulo += " (" + Tabela("SL", mv_par13, .F.) + ")"
	EndIf
	
	If nDivide > 1			
		Titulo += " (" + STR0021 + Alltrim(Str(nDivide)) + ")"
	EndIf	
	
	oReport:SetTitle(Titulo)
	oReport:SetPageNumber(mv_par12) // Pagina Inicial
	oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao							  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			 mv_par01,mv_par02,cAlias,"",cCtaIni,cCtaFim,cCCIni,cCCFim,cItemIni,cItemFim,cClVlIni,cClVlFim,mv_par11,;
			  mv_par13,aSetOfBook,mv_par15,mv_par16,mv_par17,mv_par18,;
			   l132,lImpConta,,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro,lRecDesp0,;
				cRecDesp,dDtZeraRD)},;				
				 STR0014,;  //"Criando Arquivo Tempor rio..."
				  STR0003)     //""Balancete de uma entidade filtrada por outra entidade""

	If !(Select("cArqTmp") <= 0)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia a impressao do relatorio                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("cArqTmp")
		dbGotop()
		
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f245Soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR245                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f245Soma(cTipo,cSegAte)

Local nRetValor		:= 0  
Local cClasse		:= ""
	
	If mv_par03 == 1
		cClasse	:= cArqTmp->TIPOCC
	ElseIf mv_par03 == 2
		cClasse	:= cArqTmp->TIPOITEM
	ElseIf mv_par03 == 3
		cClasse	:= cArqTmp->TIPOCLVL
	EndIf

	If mv_par08 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cClasse == "1" .And. cArqTmp->NIVEL1
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		EndIf
	Else								// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If cClasse == "2"
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cClasse == "1" .And. cArqTmp->NIVEL1
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
±±ºPrograma  ³f245Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR245                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f245Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa	:= .T.
Local nCont    := 0
Local cClasse		:= ""
	
	If mv_par03 == 1
		cClasse	:= cArqTmp->TIPOCC
	ElseIf mv_par03 == 2
		cClasse	:= cArqTmp->TIPOITEM
	ElseIf mv_par03 == 3
		cClasse	:= cArqTmp->TIPOCLVL
	EndIf

	If mv_par08 == 1					// So imprime Sinteticas
		If cClasse == "2"
			lDeixa := .F.
		EndIf
	ElseIf mv_par08 == 2				// So imprime Analiticas
		If cClasse == "1"
			lDeixa := .F.
		EndIf
	EndIf

	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		For nCont := 1 to Val(cSegAte)
			nDigitAte += Val(Subs(cMascara,nCont,1))	
		Next
		If Len(Alltrim(cClasse)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)
