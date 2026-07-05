/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTR303.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	19	

//AMARRACAO
Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR303  ³ Autor ³ Jonathan Gonzalez     ³ Data ³11/04/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balance por Item en 2 monedas           			 		    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CTBR302                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR303()

Local aArea := GetArea()
Local oReport          

Local lOk := .T.
Local aCtbMoeda		:= {}
Local aSetOfBook
Local nDivide			:= 1
Local lAtSlComp		:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local cFilIni			:= cFilAnt

Local lRet				:= .T.
Local cFilCTP 			:= xfilial("CTP")

PRIVATE cTipoAnt		:= ""
PRIVATE cPerg	 		:= "CTR303"
PRIVATE nomeProg 	 	:= "CTBR303"

PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE oTRF3
PRIVATE oTRF4

PRIVATE titulo			:= "" 
PRIVATE aSelFil		:= {} 

Private cTipoMoneda	:= "01"
Private nTaxa 			:=0


	Pergunte( cPerg, .T. )
  				  
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mostra tela de aviso - atualizacao de saldos            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cMensagem := OemToAnsi(STR0012)+chr(13)  		//"Caso nao atualize os saldos compostos na"
	cMensagem += OemToAnsi(STR0013)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
	cMensagem += OemToAnsi(STR0014)+chr(13)  		//"rodar a rotina de atualizacao de saldos "
	IF !lAtSlComp
		If !MsgYesNo(cMensagem,OemToAnsi(STR0015))	//"ATEN€O"
			lOk := .F.
		EndIf
	Endif
	
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//Valida que la moneda sea diferente de "01" y que no se a nula
If lRet

	If EMPTY(mv_par08) 
	
		cMensagem	:= STR0027	//"el campo de Comparar con moneda es requerido"
		MsgAlert(cMensagem,STR0028)//MONEDA
		lRet    	:= .F.	
	    Return lRet
	    
	elseif mv_par08 == "01"
	
		cMensagem	:= STR0029	//"Se va a comparar con el mismo tipo de moneda, seleccionar otra.""
		MsgAlert(cMensagem,STR0028) //MONEDA
		lRet    	:= .F.	
	    Return lRet   
	    	
    EndIf
    
EndIf
	
DbSelectArea("CTP") 
DbSetOrder(2) 
If lRet
	If DbSeek(cFilCTP + mv_par08 + DTOS(mv_par16))
		nTaxa := CTP_TAXA
	else
		MsgAlert(STR0030,STR0028) // "No se encontro tipo de cambio" , //moneda
		lRet    	:= .F.	
	    Return lRet
    EndIf
EndIf
If lIsRedStor .and. nTaxa == 0
	nTaxa := 1
Endif

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
	//³ Gerencial -> montagem especifica para impressao)             ³
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
	
	//Comprueba el tipo de moneda con la que se comparara
	If lOk
		aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide) // Moeda?
	   If Empty(aCtbMoeda[1])
	      Help(" ",1,"NOMOEDA")
	      lOk := .F.
	   Endif
	Endif
   
   //comprueba si se tiene que seleccionar empresa
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

RestArea(aArea)
cFilAnt := cFilIni

//Limpa os arquivos temporários 
CTBGerClean()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Jonathan Gonzalez  º Data ³ 11/04/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicion de las secciones, parametros y titulos del      º±±
±±º          ³ reporte balance de item en 2 monedas que seran utlizadas   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aCtbMoeda  - Matriz ref. a moeda                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(aSetOfBook,aCtbMoeda,nDivide)

Local oReport
Local oSCtrItem                        

Local cSayItem			:= CtbSayApro("CTD")
Local cDesc1 			:= OemToAnsi(STR0001)+ Alltrim(Upper(cSayItem)) +" "	//"Este programa ira imprimir o Balancete de  "
Local cDesc2 			:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"

Local aTamItem  		:= TAMSX3("CTD_ITEM")
Local aTamItRes 		:= TAMSX3("CTD_RES")    
Local nTamItem			:= Len(CriaVar("CTD->CTD_DESC"+cTipoMoneda))

Local lPula			:= Iif(mv_par17==1,.T.,.F.) 
Local lNormal			:= Iif(mv_par19==1,.T.,.F.)
Local lPrintZero		:= Iif(mv_par18==1,.T.,.F.)

Local cSegAte 	  	 	:= mv_par11 // Imprimir ate o Segmento?
Local nDigitAte		:= 0
Local cSepara1			:= ""
Local cMascItem		:= IIF (Empty(aSetOfBook[7]),GetMv("MV_MASCCTD"),RetMasCtb(aSetOfBook[7],@cSepara1))// Mascara do Item Contabil
Local cPicture 		:= Iif(!Empty(aSetOfBook[4]),"@E 9,999,999,999.99","")
Local nDecimais 		:= DecimalCTB(aSetOfBook,cTipoMoneda)
Local cDescMoeda 		:= aCtbMoeda[2]
Local bCondITEM 		:= {|| IIF(cArqTmp->TIPOITEM=="1","","  ")+EntidadeCTB(cArqTmp->ITEM,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.) }
Local bCondITEMRES 	:= {|| IIF(cArqTmp->TIPOITEM=="1",	EntidadeCTB(cArqTmp->ITEM,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.),;
	  										"  " + EntidadeCTB(cArqTmp->ITEMRES,0,0,20,.F.,cMascItem,cSepara1,,,,,.F.) ) }
Local cMoneda := mv_par08
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty

	titulo	:= OemToAnsi(STR0003)+Alltrim(Upper(cSayItem)) 	//"Balancete de Verificacao Conta / "
	
	oReport := TReport():New(nomeProg,titulo,,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayItem,nDivide)},cDesc1+cDesc2)
	oReport:SetTotalInLine(.F.)
	oReport:EndPage(.T.)
	oReport:SetLandScape()
	
	// Sessao 1
	oSCtrItem := TRSection():New(oReport,cSayItem,{"cArqTmp","CTD"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
	oSCtrItem:SetTotalInLine(.F.)
	oSCtrItem:SetHeaderPage()
	
	TRCell():New(oSCtrItem, "ITEM"		, "cArqTmp" , STR0016				,/*Pct*/, aTamItem[1] + 4, /*lPx*/ , bCondITEM)// Codigo da Conta
	TRCell():New(oSCtrItem, "ITEMRES"	, "cArqTmp" , STR0017 			,/*Pct*/, aTamItRes[1]	, /*lPx*/ , bCondITEMRES)// Codigo Reduzido da Conta
	TRCell():New(oSCtrItem, "DESCITEM"	, "cArqTmp" , STR0018 			,/*Pct*/, nTamItem		, /*lPx*/ ,)// Descricao do Item
	
	If lIsRedStor
		TRCell():New(oSCtrItem, "SALDOANT"	, "cArqTmp" , STR0019		     	,/*Pct*/, TAM_VALOR+2		, /*lPx*/ ,{|| ValorCTB(cArqTmp->SALDOANT			,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Saldo Anterior
		TRCell():New(oSCtrItem, "SALDOANC"	, "cArqTmp" , STR0019+cMoneda,/*Pct*/, TAM_VALOR+2		, /*lPx*/ ,{|| ValorCTB(round(cArqTmp->SALDOANT/nTaxa,nDecimais)	,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Saldo Ant 02	
		TRCell():New(oSCtrItem, "SALDODEB"	, "cArqTmp" , STR0031				,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB(cArqTmp->SALDODEB			,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"R"*/,,"CENTER")// Debito
		TRCell():New(oSCtrItem, "SALDODEC"	, "cArqTmp" , STR0031+cMoneda	,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB(round(cArqTmp->SALDODEB/nTaxa,nDecimais)	,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"R"*/,,"CENTER")// Debito 02
		TRCell():New(oSCtrItem, "SALDOCRD"	, "cArqTmp" , STR0032 			,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB(cArqTmp->SALDOCRD			,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"R"*/,,"CENTER")// Credito
		TRCell():New(oSCtrItem, "SALDOCRC"	, "cArqTmp" , STR0032+cMoneda,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB(round(cArqTmp->SALDOCRD/nTaxa,nDecimais)	,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"R"*/,,"CENTER")// Credito 02
		TRCell():New(oSCtrItem, "SALDOATU"	, "cArqTmp" , STR0022  			,/*Pct*/, TAM_VALOR+2		, /*lPx*/ ,{|| ValorCTB(cArqTmp->SALDOATU			,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Saldo Atual
		TRCell():New(oSCtrItem, "SALDOATC"	, "cArqTmp" , STR0022+cMoneda	,/*Pct*/, TAM_VALOR+2		, /*lPx*/ ,{|| ValorCTB(round(cArqTmp->SALDOATU/nTaxa,nDecimais)	,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->ITNORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Saldo Atual 02
	Else
		TRCell():New(oSCtrItem, "SALDOANT"	, "cArqTmp" , STR0019		     	,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB(cArqTmp->SALDOANT			,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Saldo Anterior
		TRCell():New(oSCtrItem, "SALDOANC"	, "cArqTmp" , STR0019+cMoneda	,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB((cArqTmp->SALDOANT*nTaxa)	,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Saldo Ant 02	
		TRCell():New(oSCtrItem, "SALDODEB"	, "cArqTmp" , STR0031				,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB(cArqTmp->SALDODEB			,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Debito
		TRCell():New(oSCtrItem, "SALDODEC"	, "cArqTmp" , STR0031+cMoneda	,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB((cArqTmp->SALDODEB*nTaxa)	,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Debito 02
		TRCell():New(oSCtrItem, "SALDOCRD"	, "cArqTmp" , STR0032 			,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB(cArqTmp->SALDOCRD			,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Credito
		TRCell():New(oSCtrItem, "SALDOCRC"	, "cArqTmp" , STR0032+cMoneda	,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB((cArqTmp->SALDOCRD*nTaxa)	,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Credito 02
		TRCell():New(oSCtrItem, "SALDOATU"	, "cArqTmp" , STR0022  			,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB(cArqTmp->SALDOATU			,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Saldo Atual
		TRCell():New(oSCtrItem, "SALDOATC"	, "cArqTmp" , STR0022+cMoneda	,/*Pct*/, TAM_VALOR		, /*lPx*/ ,{|| ValorCTB((cArqTmp->SALDOATU*nTaxa)	,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"R"*/,,"CENTER")// Saldo Atual 02
	Endif
	
	TRCell():New(oSCtrItem, "TIPOITEM"	, "cArqTmp" , STR0023				,/*Pct*/, 01				, /*lPx*/ ,)// Conta Analitica / Sintetica
	TRCell():New(oSCtrItem, "NIVEL1"	, "cArqTmp" , STR0025				,/*Pct*/, 01				, /*lPx*/ ,)// Logico para identificar se 
	

	oSCtrItem:Cell("SALDOANT"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDOANC"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDODEB"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDODEC"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDOCRD"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDOCRC"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDOATU"):lHeaderSize  := .F.
	oSCtrItem:Cell("SALDOATC"):lHeaderSize  := .F.
	
	TRPosition():New( oSCtrItem, "CTD", 1, {|| xFilial("CTD") + cArqTMP->ITEM  })
	
	oSCtrItem:Cell("TIPOITEM"):Disable()
	oSCtrItem:Cell("NIVEL1"  ):Disable()
	
	If lNormal //Se Imprime Codigo Reduzido
		oSCtrItem:Cell("ITEMRES"):Disable()
	Else
		oSCtrItem:Cell("ITEM"):Disable()	
	EndIf
	
	oSCtrItem:OnPrintLine( {|| cFilAnt := cArqTmp->FILIAL, ;
								( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOITEM == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->TIPOITEM)})
	
	oSCtrItem:SetLineCondition({|| cFilAnt := cArqTmp->FILIAL, f303Fil(cSegAte, nDigitAte,cMascItem) })
	
	If lIsRedStor 
		TRFunction():New(oSCtrItem:Cell("SALDOANT"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || "" },.T.,.F.,.F.,oSCtrItem)
		oTRF1 := TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f303Soma("D",cSegAte) },.F.,.F.,.F.,oSCtrItem)
				  TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF1:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSCtrItem)
		
	//	oTRF3 := TRFunction():New(oSCtrItem:Cell("SALDODEC"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f303Soma("D",cSegAte) },.F.,.F.,.F.,oSCtrItem)
				  TRFunction():New(oSCtrItem:Cell("SALDODEC"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(round(oTRF1:GetValue()/nTaxa,nDecimais),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSCtrItem)
		
		oTRF2 := TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f303Soma("C",cSegAte) },.F.,.F.,.F.,oSCtrItem)
				  TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF2:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSCtrItem)
		
	//	oTRF4 := TRFunction():New(oSCtrItem:Cell("SALDOCRC"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f303Soma("C",cSegAte) },.F.,.F.,.F.,oSCtrItem)
				  TRFunction():New(oSCtrItem:Cell("SALDOCRC"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(round(oTRF2:GetValue()/nTaxa,nDecimais),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSCtrItem)
	
	Else
		oTRF1 := TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f303Soma("D",cSegAte) },.F.,.F.,.F.,oSCtrItem)
				  TRFunction():New(oSCtrItem:Cell("SALDODEB"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF1:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oSCtrItem)
		
		oTRF3 := TRFunction():New(oSCtrItem:Cell("SALDODEC"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f303Soma("D",cSegAte) },.F.,.F.,.F.,oSCtrItem)
				  TRFunction():New(oSCtrItem:Cell("SALDODEC"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB((oTRF3:GetValue()*nTaxa),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oSCtrItem)
		
		oTRF2 := TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f303Soma("C",cSegAte) },.F.,.F.,.F.,oSCtrItem)
				  TRFunction():New(oSCtrItem:Cell("SALDOCRD"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF2:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oSCtrItem)
		
		oTRF4 := TRFunction():New(oSCtrItem:Cell("SALDOCRC"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f303Soma("C",cSegAte) },.F.,.F.,.F.,oSCtrItem)
				  TRFunction():New(oSCtrItem:Cell("SALDOCRC"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB((oTRF4:GetValue()*nTaxa),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oSCtrItem)			  
	Endif


oReport:ParamReadOnly()	
	
Return oReport


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintº Autor ³ Jonathan Gonzalez  º Data ³ 11/04/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impresion del reporte de acuerdo a los configuraciones de  º±±
±±º          ³ ReportDef() y los parmet. del grupo de preg. CTR303        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayItem,nDivide)

Local oSCtrItem 	:= oReport:Section(1)

Local cArqTmp		:= ""
Local cFiltro		:= oSCtrItem:GetAdvplExp()
Local cCtaIni		:= Space(Len(CriaVar("CT1_CONTA")))
Local cCtaFim		:= Repl('Z',Len(CriaVar("CT1_CONTA")))            
Local lImpSint		:= Iif(mv_par05=1 .Or. mv_par05 ==3,.T.,.F.)
Local dDataFim 	:= mv_par02
Local lImpAntLP	:= Iif(mv_par21==1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par07==1,.T.,.F.) 
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)
Local dDataLP  	:= mv_par22

Local lImpConta	:= .F.   
Local cFilCTP 		:= xfilial("CTP")
local nTipoCambio

DbSelectArea("CTP") 
DbSetOrder(2) 

DbSeek(cFilCTP + mv_par08 + DTOS(mv_par16))
nTipoCambio := CTP_TAXA

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza titulo do relatorio: Analitico / Sintetico			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF mv_par05 == 1
		titulo :=	OemToAnsi(STR0004)+ Alltrim(Upper(cSayItem)) 	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par05 == 2                                  
		titulo :=	OemToAnsi(STR0005) + Alltrim(Upper(cSayItem))	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par05 == 3
		titulo :=	OemToAnsi(STR0006) + Alltrim(Upper(cSayItem))	//"BALANCETE DE  "
	EndIf
	
//BALANCE DE CENTRO DE COSTOS EN 2 MONEDAS DE 99/99/9999 A 99/99/9999 EN CDESCMOEDA. TIPOD E CAMBIO A 99/99/9999	
	titulo += 	OemToAnsi(STR0007) + DTOC(mv_par01) + OemToAnsi(STR0008) + Dtoc(mv_par02) + OemToAnsi(STR0009) + ;
		RTRIM(cDescMoeda) + OemToAnsi (STR0025) + DTOC(mv_par16) +  OemToAnsi (STR0026) + ALLTRIM(STR(nTipoCambio))

	If mv_par10 > "1"
		titulo += " (" + Tabela("SL", mv_par10, .F.) + ")"
	EndIf
	
	If nDivide > 1			
		titulo += " (" + OemToAnsi(STR0011) + Alltrim(Str(nDivide)) + ")"
	EndIf	
	
	oReport:SetPageNumber(mv_par09) // Pagina Inicial
	oReport:SetCustomText( { || CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao							   ;
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;				
				CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
					mv_par01,mv_par02,"CTU","CTD",cCtaIni,cCtaFim,,,mv_par03,mv_par04,,,cTipoMoneda,;
						mv_par10,aSetOfBook,mv_par12,mv_par13,mv_par14,mv_par15,,;
							lImpConta,,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro,,,,,,,,,,,,aSelFil) },;
								OemToAnsi(OemToAnsi(STR0010)),;  //"Criando Arquivo Tempor rio..."
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


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f303Soma  ºAutor  ³Jonathan Gonzalez   º Data ³ 11/04/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR303                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function f303Soma(cTipo,cSegAte)

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


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f303Fil   ºAutor  ³Jonathan Gonzalez   º Data ³ 11/04/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR303                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function f303Fil(cSegAte, nDigitAte,cMascItem)

Local lDeixa	:= .T.
Local cMascara

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

		nDigitAte := CtbRelDig(cSegAte,cMascara) 	

		If Len(Alltrim(cArqTmp->ITEM)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)