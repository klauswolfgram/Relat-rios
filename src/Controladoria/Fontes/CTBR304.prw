/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTR304.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	24

//AMARRACAO
Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR304  ³ Autor ³ Jonathan Gonzalez   	³ Data ³11/04/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balance por Clase de Valor en 2 Monedas                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CTBR304                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR304()

Local aArea 		:= GetArea()
Local oReport          

Local lOk 			:= .T.
Local aCtbMoeda	:= {}
Local aSetOfBook
Local lRet				:= .T.
Local nDivide		:= 1
Local lAtSlComp	:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local cFilIni		:= cFilAnt 
Local cFilCTP 		:= xfilial("CTP")

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR304"
PRIVATE nomeProg  := "CTBR304"

PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE oTRF3
PRIVATE oTRF4

PRIVATE titulo		:= ""
PRIVATE aSelFil	:= {} 

Private cTipoMoneda	:= "01"
Private nTaxa 			:=0

	Pergunte( cPerg, .T. )			
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mostra tela de aviso - atualizacao de saldos             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cMensagem := OemToAnsi(STR0012)+chr(13)  		//"Caso nao atualize os saldos compostos na"
	cMensagem += OemToAnsi(STR0013)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
	cMensagem += OemToAnsi(STR0014)+chr(13)  		//"rodar a rotina de atualizacao de saldos "
	
	IF !lAtSlComp
		If !MsgYesNo(cMensagem,OemToAnsi(STR0015))	//"ATEN€O"
			Return
		EndIf
	Endif

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//Valida que la moneda sea diferente de "01" y que no se a nula
If lRet

	If EMPTY(mv_par08) 
	
		cMensagem	:= STR0028	//"el campo de Comparar con moneda es requerido"
		MsgAlert(cMensagem,STR0029)//MONEDA
		lRet    	:= .F.	
	    Return lRet
	    
	elseif mv_par08 == "01"
	
		cMensagem	:= STR0030	//"Se va a comparar con el mismo tipo de moneda, seleccionar otra.""
		MsgAlert(cMensagem,STR0029) //MONEDA
		lRet    	:= .F.	
	    Return lRet   
	    	
    EndIf
    
EndIf
	
DbSelectArea("CTP") 
DbSetOrder(2) 
If lRet
	If DbSeek(cFilCTP + MV_PAR08 + DTOS(MV_PAR16))
		nTaxa := CTP_TAXA
	else
		MsgAlert(STR0031,STR0029) // "No se encontro tipo de cambio" , //moneda
		lRet    	:= .F.	
	    Return lRet
    EndIf
EndIf
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


	If lOk
		aCtbMoeda  	:= CtbMoeda(MV_PAR08,nDivide) // Moeda?
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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Jonathan Gonzalez  º Data ³ 11/04/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicion de las secciones de reporte y las configuracion º±±
±±º          ³ para la impresion                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aCtbMoeda  - Matriz ref. a moeda                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(aSetOfBook,aCtbMoeda,nDivide)

Local oReport
Local oSection1                        

Local cSayClVl		:= CtbSayApro("CTH")
LOCAL cDesc1		:= OemToAnsi(STR0001)+ Upper(cSayClVl)+ " "	//"Este programa ira imprimir o Balancete de  "
LOCAL cDesc2		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"

Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local aTamCVRes 	:= TAMSX3("CTH_RES")
Local nTamClVl		:= Len(CriaVar("CTH->CTH_DESC"+cTipoMoneda))
 
Local lPula		:= Iif(mv_par17==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par19==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)

Local cSegAte 	   	:= mv_par11 // Imprimir ate o Segmento?
Local nDigitAte	:= 0
Local cSeparador	:= ""
Local cMascara		:= IIF (Empty(aSetOfBook[8]),"",RetMasCtb(aSetOfBook[8],@cSeparador))// Mascara do Item Contabil
Local cPicture 	:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,cTipoMoneda)
Local cDescMoeda 	:= aCtbMoeda[2]

Local bCdCVRL		:= {|| IIF(cArqTmp->TIPOCLVL=="1","","  ")+EntidadeCTB(cArqTmp->CLVL,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) }
Local bCdCVRES 	:= {|| IIF(cArqTmp->TIPOCLVL=="1",	EntidadeCTB(cArqTmp->CLVL,0,0,20,.F.,cMascara,cSeparador,,,,,.F.),;
	  										"  " + EntidadeCTB(cArqTmp->CLVLRES,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) ) }

Local cMoneda := MV_PAR08
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local cFilCTP 		:= xfilial("CTP")
DbSelectArea("CTP") 
DbSetOrder(2) 
If DbSeek(cFilCTP + MV_PAR08 + DTOS(MV_PAR16))
	nTaxa := CTP_TAXA
else
	MsgAlert(STR0031,STR0029) // "No se encontro tipo de cambio" , //moneda
	lRet    	:= .F.	
    Return lRet
EndIf
If lIsRedStor .and. nTaxa == 0
	nTaxa := 1
Endif


	titulo			:= OemToAnsi(STR0003)+Alltrim(Upper(cSayClVl)) 	//"Balancete de Verificacao Conta / "

	oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,nDivide)},cDesc1+cDesc2)
	oReport:SetLandScape()
	oReport:SetTotalInLine(.F.)
	oReport:EndPage(.T.)
	
	// Sessao 1
	oSection1 := TRSection():New(oReport,cSayClVl,{"cArqTmp","CTH"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
	oSection1:SetTotalInLine(.F.)
	oSection1:SetHeaderPage()

	TRCell():New(oSection1, "CLVL"	 	, "cArqTmp" , STR0016 ,/*Picture*/, aTamClVl[1]	,/*lPixel*/, bCdCVRL  )// Codigo da Classe de Valor
	TRCell():New(oSection1, "CLVLRES" 	, "cArqTmp" , STR0017 ,/*Picture*/, aTamCVRes[1] 	,/*lPixel*/, bCdCVRES )// Cod. Red. Classe de Valor
	TRCell():New(oSection1, "DESCCLVL"	, "cArqTmp" , STR0018 ,/*Picture*/, nTamClVl		,/*lPixel*/,/*{|| }*/ , /*"CENTER"*/,.T.,/*"CENTER"*/,,,.F.)// Descricao da Conta	
	
	If lIsRedStor
		TRCell():New(oSection1, "SALDOANT"	, "cArqTmp" , STR0019 			,/*Pic*/, TAM_VALOR+2 ,/*lPx*/,{|| ValorCTB(cArqTmp->SALDOANT         ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Saldo Ant
		TRCell():New(oSection1, "SALDOANC"	, "cArqTmp" , STR0019 + cMoneda	,/*Pic*/, TAM_VALOR+2 ,/*lPx*/,{|| ValorCTB(round(cArqTmp->SALDOANT/nTaxa,nDecimais),,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Saldo Ant 02
		TRCell():New(oSection1, "SALDODEB"	, "cArqTmp" , STR0032				,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB(cArqTmp->SALDODEB         ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"CENTER"*/,,"CENTER",,,.F.)// Debito
		TRCell():New(oSection1, "SALDODEC"	, "cArqTmp" , STR0032 + cMoneda	,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB(round(cArqTmp->SALDODEB/nTaxa,nDecimais),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"CENTER"*/,,"CENTER",,,.F.)// Debito 02
		TRCell():New(oSection1, "SALDOCRD"	, "cArqTmp" , STR0033			 	,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB(cArqTmp->SALDOCRD         ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"CENTER"*/,,"CENTER",,,.F.)// Credito
		TRCell():New(oSection1, "SALDOCRC"	, "cArqTmp" , STR0033 + cMoneda	,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB(round(cArqTmp->SALDOCRD/nTaxa,nDecimais),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.,lColDbCr)},/*"CENTER"*/,,"CENTER",,,.F.)// Credito	02
		TRCell():New(oSection1, "SALDOATU"	, "cArqTmp" , STR0023 			,/*Pic*/, TAM_VALOR+2 ,/*lPx*/,{|| ValorCTB(cArqTmp->SALDOATU         ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Saldo Atu
		TRCell():New(oSection1, "SALDOATC"	, "cArqTmp" , STR0023 + cMoneda	,/*Pic*/, TAM_VALOR+2 ,/*lPx*/,{|| ValorCTB(round(cArqTmp->SALDOATU/nTaxa,nDecimais),,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->CLNORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Saldo Atu 02
	Else
		TRCell():New(oSection1, "SALDOANT"	, "cArqTmp" , STR0019 			,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB(cArqTmp->SALDOANT         ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Saldo Ant
		TRCell():New(oSection1, "SALDOANC"	, "cArqTmp" , STR0019 + cMoneda	,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB((cArqTmp->SALDOANT*nTaxa),,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Saldo Ant 02
		TRCell():New(oSection1, "SALDODEB"	, "cArqTmp" , STR0032				,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB(cArqTmp->SALDODEB         ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Debito
		TRCell():New(oSection1, "SALDODEC"	, "cArqTmp" , STR0032 + cMoneda	,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB((cArqTmp->SALDODEB*nTaxa),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Debito 02
		TRCell():New(oSection1, "SALDOCRD"	, "cArqTmp" , STR0033			 	,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB(cArqTmp->SALDOCRD         ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Credito
		TRCell():New(oSection1, "SALDOCRC"	, "cArqTmp" , STR0033 + cMoneda	,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB((cArqTmp->SALDOCRD*nTaxa),,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Credito	02
		TRCell():New(oSection1, "SALDOATU"	, "cArqTmp" , STR0023 			,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB(cArqTmp->SALDOATU         ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Saldo Atu
		TRCell():New(oSection1, "SALDOATC"	, "cArqTmp" , STR0023 + cMoneda	,/*Pic*/, TAM_VALOR ,/*lPx*/,{|| ValorCTB((cArqTmp->SALDOATU*nTaxa),,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},/*"CENTER"*/,,"CENTER",,,.F.)// Saldo Atu 02
	Endif
	
	TRCell():New(oSection1, "TIPOCLVL"	, "cArqTmp" , STR0024 ,/*Picture*/, 01	,/*lPixel*/,/*{|| }*/)// Situacao
	TRCell():New(oSection1, "NIVEL1"	, "cArqTmp" , STR0025 ,/*Picture*/, 01	,/*lPixel*/,/*{|| }*/)// Logico para identificar se 
	
    oSection1:Cell("SALDOANT"):lHeaderSize  := .F.
    oSection1:Cell("SALDOANC"):lHeaderSize  := .F.
    oSection1:Cell("SALDODEB"):lHeaderSize  := .F.
    oSection1:Cell("SALDODEC"):lHeaderSize  := .F.
    oSection1:Cell("SALDOCRD"):lHeaderSize  := .F.
    oSection1:Cell("SALDOCRC"):lHeaderSize  := .F.
    oSection1:Cell("SALDOATU"):lHeaderSize  := .F.
    oSection1:Cell("SALDOATC"):lHeaderSize  := .F.
	
	TRPosition():New( oSection1, "CTH", 1, {|| xFilial("CTH") + cArqTMP->CLVL  })
	oSection1:Cell("TIPOCLVL"	):Disable() 
	oSection1:Cell("NIVEL1"  	):Disable()
	
	If lNormal //Se Imprime Codigo Reduzido
		oSection1:Cell("CLVLRES"):Disable()
	Else
		oSection1:Cell("CLVL"):Disable()	
	EndIf 
	
	
	oSection1:OnPrintLine( {|| cFilAnt := cArqTmp->FILIAL, ;
						 ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCLVL == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->TIPOCLVL;
								)  })
	
	oSection1:SetLineCondition({|| cFilAnt := cArqTmp->FILIAL, f304Fil(cSegAte, nDigitAte,cMascara) })

// Totais das sessoes	
	If lIsRedStor
		TRFunction():New(oSection1:Cell("SALDOANT"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || "" },.T.,.F.,.F.,oSection1)

		oTRF1 := TRFunction():New(oSection1:Cell("SALDODEB"),nil,"SUM"	 	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f304Soma("D",cSegAte) },.F.,.F.,.F.,oSection1)
				  TRFunction():New(oSection1:Cell("SALDODEB"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF1:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSection1)

		oTRF2 := TRFunction():New(oSection1:Cell("SALDODEC"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f304Soma("D",cSegAte) },.F.,.F.,.F.,oSection1)
				  TRFunction():New(oSection1:Cell("SALDODEC"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(round(oTRF2:GetValue()/nTaxa,nDecimais),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSection1)
					
		oTRF3 := TRFunction():New(oSection1:Cell("SALDOCRD"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f304Soma("C",cSegAte) },.F.,.F.,.F.,oSection1)
				  TRFunction():New(oSection1:Cell("SALDOCRD"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF3:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSection1)
		
		oTRF4 := TRFunction():New(oSection1:Cell("SALDOCRC"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f304Soma("C",cSegAte) },.F.,.F.,.F.,oSection1)
				  TRFunction():New(oSection1:Cell("SALDOCRC"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(round(oTRF4:GetValue()/nTaxa,nDecimais),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.T.,.F.,.F.,oSection1)
	Else
		oTRF1 := TRFunction():New(oSection1:Cell("SALDODEB"),nil,"SUM"	 	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f304Soma("D",cSegAte) },.F.,.F.,.F.,oSection1)
				  TRFunction():New(oSection1:Cell("SALDODEB"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF1:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oSection1)

		oTRF2 := TRFunction():New(oSection1:Cell("SALDODEC"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f304Soma("D",cSegAte) },.F.,.F.,.F.,oSection1)
				  TRFunction():New(oSection1:Cell("SALDODEC"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB((oTRF2:GetValue()*nTaxa),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oSection1)
					
		oTRF3 := TRFunction():New(oSection1:Cell("SALDOCRD"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f304Soma("C",cSegAte) },.F.,.F.,.F.,oSection1)
				  TRFunction():New(oSection1:Cell("SALDOCRD"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF3:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oSection1)
		
		oTRF4 := TRFunction():New(oSection1:Cell("SALDOCRC"),nil,"SUM"		,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f304Soma("C",cSegAte) },.F.,.F.,.F.,oSection1)
				  TRFunction():New(oSection1:Cell("SALDOCRC"),nil,"ONPRINT"	,/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB((oTRF4:GetValue()*nTaxa),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oSection1)
	EndIf
		

oReport:ParamReadOnly()

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintº Autor ³ Jonathan Gonzalez  º Data ³ 11/04/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rutina de impresion de reporte de acuerdo a la config.     º±±
±±º          ³ de ReportDef() y los pramt.del grupo de preg. CTR304       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,nDivide)

Local oSection1 	:= oReport:Section(1)

Local cArqTmp		:= ""
Local cFiltro		:= oSection1:GetAdvplExp()
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

DbSeek(cFilCTP + MV_PAR08 + DTOS(MV_PAR16))
nTipoCambio := CTP_TAXA



If oReport:GetOrientation() == 1 
	oSection1:Cell("DESCCLVL"):SetSize(20)
EndIf


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF mv_par05 == 1 
		Titulo:=	OemToAnsi(STR0005) + Upper(cSayClVl) 	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par05 == 2 
		Titulo:=	OemToAnsi(STR0004) + Upper(cSayClVl)	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par05 == 3
		Titulo:=	OemToAnsi(STR0006) + Upper(cSayClVl)	//"BALANCETE DE  "
	EndIf
	
	
	//BALANCE DE CENTRO DE COSTOS EN 2 MONEDAS DE 99/99/9999 A 99/99/9999 EN CDESCMOEDA. TIPOD E CAMBIO A 99/99/9999		
	Titulo += 	OemToAnsi(STR0007) + DTOC(mv_par01) + OemToAnsi(STR0008) + Dtoc(mv_par02) + ;
				OemToAnsi(STR0009) + RTRIM(cDescMoeda) + OemToAnsi (STR0026) + DTOC(MV_PAR16) +  OemToAnsi (STR0027) + ALLTRIM(STR(nTipoCambio))
				

	If mv_par10 > "1"
		Titulo += " (" + Tabela("SL", mv_par10, .F.) + ")"
	EndIf
	
	If nDivide > 1			
		Titulo += " (" + OemToAnsi(STR0011) + Alltrim(Str(nDivide)) + ")"  //DIV.
	EndIf	
	
	oReport:SetPageNumber(mv_par09) //mv_par09	-	Pagina Inicial
	oReport:SetCustomText( { || CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra tabela CTH com dbSetFilter, independente se RPO Top ou CodeBase, pois ³
	//³ existem campos na CTH que nao estao na tabela temporaria em que eh aplicado  ³
	//³ o filtro e isto gerava mensagem de erro.log de campo nao encontrado.         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If ! Empty(cFiltro)
    	CTH->( dbSetFilter( { || &cFiltro }, cFiltro ) )
    EndIf
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;				   
				cArqTmp := CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				 mv_par01,mv_par02,"CTU","CTH",cCtaIni,cCtaFim,,,,,mv_par03,mv_par04,;
				  cTipoMoneda,mv_par10,aSetOfBook,mv_par12,;
				   mv_par13,mv_par14,mv_par15,,lImpConta,,,lImpAntLP,dDataLP,;
					nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFiltro,,,,,,,,,,,,aSelFil) },;
					 OemToAnsi(OemToAnsi(STR0010)),;  //"Criando Arquivo Tempor rio..."
					  OemToAnsi(STR0003)+cSayClVl)     //"Balancete de Verificacao por " 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Select("cArqTmp") > 0
		dbSelectArea("cArqTmp")
		dbGotop()
	
		oSection1:Print()
	
		dbSelectArea("cArqTmp")
		Set Filter To
		dbCloseArea()
		FErase(cArqTmp+GetDBExtension())
		FErase("cArqInd"+OrdBagExt())
	EndIf

	dbSelectArea("CTH")
	dbClearFilter()

	dbselectArea("CT2")
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f304Soma  ºAutor  ³Jonathan Gonzalez   º Data ³ 11/04/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function f304Soma(cTipo,cSegAte)

Local nRetValor		:= 0

	If mv_par05 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOCLVL == "1" .And. cArqTmp->NIVEL1
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		EndIf
	Else								// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOCLVL == "2"
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOCLVL == "1" .And. cArqTmp->NIVEL1
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
±±ºPrograma  ³f304Fil   ºAutor  ³Jonathan Gonzalez   º Data ³ 11/04/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function f304Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa	:= .T.

	If mv_par05 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCLVL == "2"
			lDeixa := .F.
		EndIf
	ElseIf mv_par05 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCLVL == "1"
			lDeixa := .F.
		EndIf
	EndIf
	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)

		nDigitAte := CtbRelDig(cSegAte,cMascara) 	

		If Len(Alltrim(cArqTmp->CLVL)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)