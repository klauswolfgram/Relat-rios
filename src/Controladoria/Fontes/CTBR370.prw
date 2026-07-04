/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR370.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE TAM_VALOR		16

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR370  ³ Autor ³ Eduardo Nunes Cirqueira ³ Data ³ 04.09.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Comparativo de Tp Saldos (CCusto, Item ou Classe Valor)      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_CTBR370()    								                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       								                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      								                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum										                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CtbR370()

Local aSetOfBook
Local aCtbMoeda		:= {}

Local lRet			:= .T.
Local nDivide		:= 1
Local lSchedule		:= IsBlind()
Local nPos			:= 0
Local nDigitos		:= 0
Local cCodMasc


PRIVATE nLastKey 	:= 0
PRIVATE cPerg	 	:= "CTR370"
PRIVATE aReturn 	:= { STR0004, 1,STR0005, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeProg	:= "CTBR370"
PRIVATE cTipoAnt	:= ""
PRIVATE oFT1
PRIVATE oFT2
PRIVATE nTotSld1
PRIVATE nTotSld2



	If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
		Return
	EndIf
	
	
	If !FwGetRunSchedule()
      Pergunte("CTR370", !lSchedule)
	EndIf
	
	DO CASE
	CASE mv_par03 == 1
		cString := "CTT"
	CASE mv_par03 == 2
		cString := "CTD"
	CASE mv_par03 == 3
		cString := "CTH"	
	ENDCASE
	
	If !ct040Valid(mv_par07)
		lRet := .F.
	Else
	   aSetOfBook := CTBSetOf(mv_par07)
	Endif
	
	If lRet
		If mv_par20 == 2			// Divide por cem
			nDivide := 100
		ElseIf mv_par20 == 3		// Divide por mil
			nDivide := 1000
		ElseIf mv_par20 == 4		// Divide por milhao
			nDivide := 1000000
		EndIf	

		aCtbMoeda  	:= CtbMoeda(mv_par09,nDivide)
		If Empty(aCtbMoeda[1])
			If ! lSchedule
	      	Help(" ",1,"NOMOEDA")
	  		EndIf
	      lRet := .F.
	   Endif

		If lRet .And. !Empty(mv_par14)			//// FILTRA O SEGMENTO Nº
			If Empty(mv_par07)		//// VALIDA SE O CÓDIGO DE CONFIGURAÇÃO DE LIVROS ESTÁ CONFIGURADO
		      If ! lSchedule
					HELP("",1,"CTM_CODIGO")
				EndIf
				lRet := .F.
			Endif
			cCodMasc		:= aSetOfBook[ mvpar03+5 ]
			dbSelectArea("CTM")
			dbSetOrder(1)
			If MsSeek(xFilial()+cCodMasc)
				While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == cCodMasc
					nPos += Val(CTM->CTM_DIGITO)
					If CTM->CTM_SEGMEN == STRZERO(val(mv_par14),2)
						nPos -= Val(CTM->CTM_DIGITO)
						nPos ++
						nDigitos := Val(CTM->CTM_DIGITO)
						Exit
					EndIf
					dbSkip()
				EndDo
			Else             
				If ! lSchedule
					HELP("",1,"CTN_CODIGO")
				EndIf
				lRet := .F.
			EndIf
		EndIf
		
      If lRet
			oReport := ReportDef(aCtbMoeda,nDivide,nPos,nDigitos,lSchedule)
			oReport:PrintDialog()
		EndIf
	Endif

//Limpa os arquivos temporários 
CTBGerClean()

Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Eduardo Nunes      º Data ³  04/09/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aCtbMoeda = Matriz ref. a moeda                            º±±
±±º          ³ nDivide   = Indice para divisao do valor (100,1000,1000000)º±±
±±º          ³ nPos      = Indica a posicao do digito na entidade         º±±
±±º          ³ nDigitos  = Indica quantos digitos serao filtrados         º±±
±±º          ³ lSchedule = Indica se esta executando em Schedule          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(aCtbMoeda,nDivide,nPos,nDigitos,lSchedule)

Local oReport
Local oSection1

Local cDesc1 		:= STR0001	//"Este programa ira imprimir o Comparativo de Tipos de Saldos de Centro de Custo, Item ou Classe de Valor"
Local cDesc2 		:= STR0002  //"de acordo com os parametros solicitados pelo Usuario"
Local cDesc3		:= ""

Local Titulo 		:= Upper(STR0013)	//"Comparativo de Saldo"

Local aTamCC		:= TAMSX3("CTT_CUSTO")
Local aTamCCRes	:= TAMSX3("CTT_RES")
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+mv_par09))

Local aTamItem 	:= TAMSX3("CTD_ITEM")
Local aTamItRes 	:= TAMSX3("CTD_RES")    
Local nTamItem		:= Len(CriaVar("CTD->CTD_DESC"+mv_par09))

Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local aTamCvRes 	:= TAMSX3("CTH_RES")
Local nTamClVl		:= Len(CriaVar("CTH->CTH_DESC"+mv_par09))

Local lPulaSint	:= Iif(mv_par18==1,.T.,.F.) 
Local lAnalitica	:= Iif(mv_par21==2,.T.,.F.)

Local lPrintZero	:= Iif(mv_par19==1,.T.,.F.)
Local cSegAte 	   := mv_par13 // Imprimir ate o Segmento?

Local nDigitAte	:= 0 
Local cClasse		:= ""
Local cSeparador	:= ""
Local cMascara1	:= ""

Local aSetOfBook	:= CTBSetOf(mv_par07)
Local cPicture 	:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par09)
Local cDescMoeda 	:= aCtbMoeda[2]
Local cDescEnt		:=	""
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local bNormal 		:= {|| cArqTmp->NORMAL }
Local lCharSinal	:= .F.

If mv_par03 == 1
	cIdent   := "CTT"
	cCodMasc := aSetOfBook[6]
	cMVMasc  := "MV_MASCCUS"
	nPosMasc := 6
	cClasse	:= "TIPOCC"
	If lIsRedStor
		bNormal := {|| GetAdvFVal("CTT","CTT_NORMAL",xFilial("CTT")+cArqTmp->CUSTO,1,"1") }
	Endif
ElseIf mv_par03 == 2
   cIdent   := "CTD"
	cCodMasc	:= aSetOfBook[7]
	cMVMasc  := "MV_MASCCTD"
	nPosMasc	:= 7
	cClasse	:= "TIPOITEM"
	If lIsRedStor
		bNormal := {|| GetAdvFVal("CTD","CTD_NORMAL",xFilial("CTD")+cArqTmp->ITEM,1,"1") }
	Endif
Else
   cIdent   := "CTH"
   cCodMasc	:= aSetOfBook[8]
	cMVMasc  := "MV_MASCCTH"
	nPosMasc	:= 8	
	cClasse	:= "TIPOCLVL"
	If lIsRedStor
		bNormal := {|| GetAdvFVal("CTH","CTH_NORMAL",xFilial("CTH")+cArqTmp->CLVL,1,"1") }
	Endif
EndIf

If Empty(aSetOfBook[nPosMasc])
	cMascara1	:= GetNewPar(cMVMasc,"")
Else
	cMascara1	:= RetMasCtb(cCodMasc,@cSeparador)
EndIf

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara1)
EndIf

oReport := TReport():New(nomeProg,Titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,nDivide,lSchedule)},cDesc1+cDesc2+cDesc3)
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)

oReport:SetLandScape(.T.)
oReport:ParamReadOnly() 

cDescEnt	:=	CtbsayApro(cIdent)

// Secao 1
oSection1 := TRSection():New(oReport,cDescEnt,{"cArqTmp",cIdent},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oSection1:SetTotalInLine(.F.)


If mv_par03 == 1
	TRCell():New(oSection1,"CUSTO"		,"cArqTmp",STR0019	,/*Picture*/, aTamCC[1]		,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CUSTO,0,0,20,.F.,cMascara1,cSeparador,,,,,.F.) })// Codigo do Centro de Custo "CODIGO"
	TRCell():New(oSection1,"CCRES"		,"cArqTmp",STR0020	,/*Picture*/, aTamCCRes[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CCRES,0,0,20,.F.,cMascara1,cSeparador,,,,,.F.) })	// Codigo Reduzido do Centro de Custo"CODIGO REDUZIDO"
	TRCell():New(oSection1,"DESCCC" 		,"cArqTmp",STR0021	,/*Picture*/, nTamCC	 		,/*lPixel*/,/*{|| }*/)	// Descricao do Centro de Custo "D E S C R I C A O"
	If lAnalitica
		oSection1:Cell("CUSTO"):Disable()
	Else
		oSection1:Cell("CCRES"):Disable()
	EndIf

ElseIf mv_par03 == 2
	TRCell():New(oSection1,"ITEM"			,"cArqTmp",STR0019	,/*Picture*/, aTamItem[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->ITEM   ,0,0,20,.F.,cMascara1,cSeparador,,,,,.F.) })// Codigo do Item          
	TRCell():New(oSection1,"ITEMRES" 	,"cArqTmp",STR0020	,/*Picture*/, aTamItRes[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->ITEMRES,0,0,20,.F.,cMascara1,cSeparador,,,,,.F.) })// Codigo Reduzido do Item
	TRCell():New(oSection1,"DESCITEM"	,"cArqTmp",STR0021	,/*Picture*/, nTamItem		,/*lPixel*/,/*{|| }*/)// Descricao do Item
	If lAnalitica
		oSection1:Cell("ITEM"):Disable()
	Else
		oSection1:Cell("ITEMRES"):Disable()
	EndIf

ElseIf mv_par03 == 3
	TRCell():New(oSection1,"CLVL"			,"cArqTmp",STR0019	,/*Picture*/, aTamClVl[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CLVL   ,0,0,20,.F.,cMascara1,cSeparador,,,,,.F.) })// Codigo da Classe de Valor
	TRCell():New(oSection1,"CLVLRES"		,"cArqTmp",STR0020	,/*Picture*/, aTamCVRes[1]	,/*lPixel*/,{|| EntidadeCTB(cArqTmp->CLVLRES,0,0,20,.F.,cMascara1,cSeparador,,,,,.F.) })// Cod. Red. Classe de Valor
	TRCell():New(oSection1,"DESCCLVL"	,"cArqTmp",STR0021	,/*Picture*/, nTamClVl		,/*lPixel*/,/*{|| }*/)// Descricao da Classe de Valor
	If lAnalitica
		oSection1:Cell("CLVL"):Disable()
	Else
		oSection1:Cell("CLVLRES"):Disable()
	EndIf
EndIf

TRCell():New(oSection1,"MOVIMENTO1"			,"cArqTmp",STR0022					,/*Picture*/,TAM_VALOR +2	,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO1 ,,,TAM_VALOR,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})// Movimento no primeiro Saldo
TRCell():New(oSection1,"MOVIMENTO2"			,"cArqTmp",STR0023					,/*Picture*/,TAM_VALOR +2	,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO2 ,,,TAM_VALOR,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})// Movimento no segundo  Saldo "MOVIMENTO2          ."
TRCell():New(oSection1,"VARIACAO"			,"cArqTmp",STR0024					,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB((cArqTmp->MOVIMENTO1/cArqTmp->MOVIMENTO2)*100,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)})// Variacao em %"VARIACAO %          ."	
TRCell():New(oSection1,"VARIACAO VALOR"	,"cArqTmp",STR0025					,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO1-cArqTmp->MOVIMENTO2,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,lColDbCr)})// Variacao em Valor "VARIACAO VALOR      ."
TRCell():New(oSection1,"TIPOCC"				,"cArqTmp",STR0026+" "+	CtbsayApro("CTT")	,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Custo Analitico  / Sintetico
TRCell():New(oSection1,"TIPOITEM"			,"cArqTmp",STR0026+" "+	CtbsayApro("CTD")	,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Item   Analitico / Sintetica
TRCell():New(oSection1,"TIPOCLVL"			,"cArqTmp",STR0026+" "+	CtbsayApro("CTH")	,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Classe Analitica / Sintetica
TRCell():New(oSection1,"NIVEL1"				,"cArqTmp",STR0027					,/*Picture*/,01			,/*lPixel*/,/*{|| }*/)// Logico para identificar se

oSection1:Cell("TIPOCC"	 ):Disable()
oSection1:Cell("TIPOITEM"):Disable()
oSection1:Cell("TIPOCLVL"):Disable()
oSection1:Cell("NIVEL1"	 ):Disable()

If mv_par23 <> 1  //  Imprime Variacao por Valor
	oSection1:Cell("VARIACAO VALOR"):Disable()
EndIf

oSection1:OnPrintLine( {|| ( IIf(	lPulaSint .And. (cTipoAnt == "1" .Or. (cArqTmp->&(cClasse) == "1" .And. cTipoAnt == "2")),;
												oReport:SkipLine(),;
												NIL	),;
												cTipoAnt := cArqTmp->&(cClasse)	)  } )

oSection1:SetLineCondition({|| F370Fil( cSegAte,nDigitAte,cMascara1,nPos,nDigitos ) })
oSection1:SetHeaderPage()
If lIsRedStor
	oFT1 :=	TRFunction():New(oSection1:Cell("MOVIMENTO1"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || F370Soma("1",cSegAte) },.F.,.F.,.F.,oSection1)
				TRFunction():New(oSection1:Cell("MOVIMENTO1"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || (nTotSld1 := oFT1:GetValue(),ValorCTB(nTotSld1,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.,,lCharSinal)) },.T.,.F.,.F.,oSection1)

	oFT2 :=	TRFunction():New(oSection1:Cell("MOVIMENTO2"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || F370Soma("2",cSegAte) },.F.,.F.,.F.,oSection1)
				TRFunction():New(oSection1:Cell("MOVIMENTO2"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || (nTotSld2 := oFT2:GetValue(),ValorCTB(nTotSld2,,,TAM_VALOR,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.,,lCharSinal)) },.T.,.F.,.F.,oSection1)
Else
	oFT1 :=	TRFunction():New(oSection1:Cell("MOVIMENTO1"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || F370Soma("1",cSegAte) },.F.,.F.,.F.,oSection1)
				TRFunction():New(oSection1:Cell("MOVIMENTO1"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || (nTotSld1 := oFT1:GetValue(),ValorCTB(nTotSld1,,,TAM_VALOR,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.)) },.T.,.F.,.F.,oSection1)

	oFT2 :=	TRFunction():New(oSection1:Cell("MOVIMENTO2"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || F370Soma("2",cSegAte) },.F.,.F.,.F.,oSection1)
				TRFunction():New(oSection1:Cell("MOVIMENTO2"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || (nTotSld2 := oFT2:GetValue(),ValorCTB(nTotSld2,,,TAM_VALOR,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.)) },.T.,.F.,.F.,oSection1)
EndIF


Return oReport


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint³ Autor ³ Eduardo Nunes      ³ Data ³  05/09/06  º±±
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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,nDivide,lSchedule)

Local oSection1 	:= oReport:Section(1)
Local cFiltro		:= oSection1:GetAdvplExp()  /*aReturn[7]*/

Local cTpSld1		:=	mv_par11		// Tipo de Saldo 1
Local cTpSld2		:= mv_par12		// Tipo de Saldo 2
Local cDescSld1		:=	Tabela("SL",mv_par11,.F.)
Local cDescSld2		:=	Tabela("SL",mv_par12,.F.)
Local cArqTmp		:=	""
Local lVar0			:= Iif(mv_par08 == 1,.T.,.F.)
Local dDataFim 		:= mv_par02
Local cIdent		:= ""
Local lImpSint		:= If(mv_par06==2,.F.,.T.)
Local lEnd 			:= .F.
Local oMeter
Local oText
Local oDlg

If mv_par03 == 1
	cIdent   := "CTT"
ElseIf mv_par03 == 2
	cIdent   := "CTD"
Else
   cIdent   := "CTH"
EndIf

Titulo 	:= Upper(STR0013) + SPACE(01)+"( "+cDescSld1+" / "+cDescSld2+" ) "
Titulo	+= STR0014+ Alltrim(cDescMoeda)+STR0015+Dtoc(mv_par01)
Titulo	+= STR0016+ Dtoc(mv_par02) 

If nDivide > 1
	Titulo  += " (" + STR0017 + Alltrim(Str(nDivide)) + ")"
EndIf

oReport:SetTitle(Titulo)
oReport:SetPageNumber(mv_par10) // Pagina Inicial
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

oSection1:Cell("MOVIMENTO1"):SetTitle(cDescSld1)
oSection1:Cell("MOVIMENTO2"):SetTitle(cDescSld2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao					        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lSchedule
	CtbGerCmp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CTU",mv_par04,mv_par05,mv_par04,mv_par05,mv_par04,mv_par05,mv_par04,mv_par05,;
				mv_par09,cTpSld1,cTpSld2,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17,;
				mv_par13,lVar0,nDivide,mv_par22,,cIdent,lImpSint,cString,cFiltro)
Else
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CtbGerCmp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CTU",mv_par04,mv_par05,mv_par04,mv_par05,mv_par04,mv_par05,mv_par04,mv_par05,;
				mv_par09,cTpSld1,cTpSld2,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17,;
				mv_par13,lVar0,nDivide,mv_par22,,cIdent,lImpSint,cString,cFiltro)},;
				STR0010,;  //"Criando Arquivo Tempor rio..."
				STR0006)   //"Comparativo de Tipo de Saldos "		
EndIf

//Desabilita o filtro de usuario
oReport:NoUserFilter()
//Amarra a tabela temporaria a tabela de filtros e colunas adicionais
If mv_par03 ==1
	oSection1:SetRelation({|| xFilial(cIdent)+cArqTmp->CUSTO},cIdent,1,.T.)
ElseIf mv_par03 == 2
	oSection1:SetRelation({|| xFilial(cIdent)+cArqTmp->ITEM },cIdent,1,.T.)
ElseIf mv_par03 == 3
	oSection1:SetRelation({|| xFilial(cIdent)+cArqTmp->CLVL },cIdent,1,.T.)
Endif

If ( Select( "cArqTmp" ) > 0 )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("cArqTmp")
	dbGotop()
	
	oSection1:Print()
	
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	dbselectArea("CT1")
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F370Soma  ºAutor  ³Eduardo Nunes       º Data ³  05/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR370                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function F370Soma(cTipo,cSegAte)

Local nRetValor	:= 0  
Local cClasse		:= ""
	
If mv_par03 == 1
	cClasse	:= cArqTmp->TIPOCC
ElseIf mv_par03 == 2
	cClasse	:= cArqTmp->TIPOITEM
ElseIf mv_par03 == 3
	cClasse	:= cArqTmp->TIPOCLVL
EndIf

If mv_par06 == 1					// So imprime Sinteticas - Soma Sinteticas
	If cClasse == "1" .And. cArqTmp->NIVEL1
		If cTipo == "1"
			nRetValor := cArqTmp->MOVIMENTO1
		ElseIf cTipo == "2"
			nRetValor := cArqTmp->MOVIMENTO2
		EndIf
	EndIf
Else									// Soma Analiticas
	If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
		If cClasse == "2"
			If cTipo == "1"
				nRetValor := cArqTmp->MOVIMENTO1
			ElseIf cTipo == "2"
				nRetValor := cArqTmp->MOVIMENTO2
			EndIf
		EndIf
	Else								//Se tiver filtragem, somo somente as sinteticas
		If cClasse == "1" .And. cArqTmp->NIVEL1
			If cTipo == "1"
				nRetValor := cArqTmp->MOVIMENTO1
			ElseIf cTipo == "2"
				nRetValor := cArqTmp->MOVIMENTO2
			EndIf
		EndIf
  	Endif
EndIf



Return nRetValor



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F370Fil   ºAutor  ³Eduardo Nunes       º Data ³  04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Faz a filtragem para impressao, validando o registro       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR370                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function F370Fil(cSegAte,nDigitAte,cMascara,nPos,nDigitos)

Local lDeixa	:= .T.
Local nCont    := 0
Local cClasse	:= ""
Local cIdent   := ""
Local cEntiNom := ""

If mv_par03 == 1
	cClasse	:= cArqTmp->TIPOCC
	cIdent   := "CTT"
  	cEntiNom := "cArqTmp->CUSTO"
ElseIf mv_par03 == 2
	cClasse	:= cArqTmp->TIPOITEM
   cIdent   := "CTD"
  	cEntiNom := "cArqTmp->ITEM"
Else
	cClasse	:= cArqTmp->TIPOCLVL
   cIdent   := "CTH"
  	cEntiNom := "cArqTmp->CLVL"
EndIf
	

If mv_par06 == 1					// So imprime Sinteticas
	If cClasse == "2"
		lDeixa := .F.
	EndIf

ElseIf mv_par06 == 2				// So imprime Analiticas
	If cClasse == "1"
		lDeixa := .F.
	EndIf
EndIf

//Filtragem ate o Segmento da Entidade( antigo nivel do SIGACON)		
If !Empty(cSegAte)
	For nCont := 1 to Val(cSegAte)
		nDigitAte += Val(Subs(cMascara,nCont,1))	
	Next
	If Len(Alltrim(cClasse)) > nDigitAte
		lDeixa := .F.
	Endif
EndIf

If mv_par08 == 1	//	Considera Variacao 0.00
	If MOVIMENTO1 == 0 .And. MOVIMENTO2 == 0
		If CtbExDtFim(cIdent) 
			dbSelectArea(cIdent)
			dbSetOrder(1)
			If MsSeek(xFilial()+&(cEntiNom))
				If !CtbVlDtFim(cIdent,mv_par01) 
		     		lDeixa := .F.
				EndIf
			EndIf		
		EndIf
	EndIf			
EndIf


//Caso faca filtragem por segmento de item, verifico se esta dentro 
//da solicitacao feita pelo usuario. 
If !Empty(mv_par14)
	If Empty(mv_par15) .And. Empty(mv_par16) .And. !Empty(mv_par17)
		If  !(Substr(&(cEntiNom),nPos,nDigitos) $ (mv_par17) ) 
			lDeixa := .F.
		EndIf	
	Else
		If Substr(&(cEntiNom),nPos,nDigitos) < Alltrim(mv_par15) .Or. Substr(&(cEntiNom),nPos,nDigitos) > Alltrim(mv_par16)
			lDeixa := .F.
		EndIf	
	Endif
EndIf	
	

dbSelectArea("cArqTmp")

Return (lDeixa)

//-------------------------------------------------------------------
/*/{Protheus.doc} ScheDef()

Definição de Static Function SchedDef para o novo Schedule

@author TOTVS
@since 03/06/2021
@version MP12
/*/
//-------------------------------------------------------------------

Static Function SchedDef()

Local aParam := {}

aParam := { "R",;            // Tipo R para relatório P para processo
			"CTR370",;       // Pergunte do relatório, caso não use, passar ParamDef
			,;               // Alias     
			,;               // Array de ordens
			STR0028 }        // Título 


Return aParam

