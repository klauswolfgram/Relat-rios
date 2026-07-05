/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr320.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	16

STATIC lIsRussia	:= If(cPaisLoc$"RUS",.T.,.F.)

// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR320  ³ Autor ³ Cicero J. Silva   	³ Data ³ 04.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete C.Custo / Cl.Valor            		 	 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR320      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR320()

Local aArea := GetArea()
Local oReport          

Local lOk := .T.
Local aCtbMoeda		:= {}
Local nDivide		:= 1           

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR320"
PRIVATE nomeProg  	:= "CTBR320"  
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE oTRF3
PRIVATE oTRF4
PRIVATE nTotMov	:= 0
PRIVATE nTotdbt	:= 0
PRIVATE nTotcrt	:= 0
PRIVATE titulo

Pergunte(cPerg,.T.) // Precisa ativar as perguntas antes das definicoes.

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	lOk := .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
		Help(" ",1,"NOMOEDA")
		lOk := .F.
	Endif
Endif

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
Local oSection2 
Local oBreak

Local cSayCusto		:= CtbSayApro("CTT") 
Local cSayClVl		:= CtbSayApro("CTH")

Local cDesc1 		:= OemToAnsi(STR0001)+ Alltrim(Upper(cSayCusto))+" / "+ Alltrim(Upper(cSayClVl))	//"Este programa ira imprimir o Balancete de  "
Local cDesc2 		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"

Local aTamClVl  	:= TAMSX3("CTH_CLVL")
Local aTamCvRes 	:= TAMSX3("CTH_RES")
Local aTamCC    	:= TAMSX3("CTT_CUSTO")
Local aTamCCRes 	:= TAMSX3("CTT_RES")
                                            
Local nTamClVl		:= Len(CriaVar("CTH->CTH_DESC"+mv_par10))
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+mv_par10))

Local lSaltaPag		:= Iif(mv_par19==1,.T.,.F.)
Local lPula			:= Iif(mv_par22==1,.T.,.F.)
Local lClVlNormal	:= Iif(mv_par21==1,.T.,.F.)
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
Local aSetOfBook := CTBSetOf(mv_par08)	
	
Local cMascCC		:= IIF (Empty(aSetOfBook[6]),GetMv("MV_MASCCUS"),RetMasCtb(aSetOfBook[6],@cSepara1))//Mascara do Centro de Custo
Local cMascClVl		:= IIF (Empty(aSetOfBook[8]),"",RetMasCtb(aSetOfBook[8],@cSepara2))//Mascara da Classe de Valor

Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)
Local cDescMoeda 	:= aCtbMoeda[2]

Local bCdCVRL	:= {|| EntidadeCTB(cArqTmp->CLVL,0,0,20,.F.,cMascClVl,cSepara2,,,,,.F.) }
Local bCdCVRES	:= {|| EntidadeCTB(cArqTmp->CLVLRES,0,0,20,.F.,cMascClVl,cSepara2,,,,,.F.) }

Local bCdCUSTO	:= {|| EntidadeCTB(cArqTmp->CUSTO,0,0,20,.F.,cMascCC,cSepara1,,,,,.F.) }
Local bCdCCRES	:= {|| EntidadeCTB(cArqTmp->CCRES,0,0,20,.F.,cMascCC,cSepara1,,,,,.F.) }
Local cCustoAnt			:= ""
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn  	:= SuperGetMV("MV_REDSTOR",.F.,.F.) // CAZARINI - 20/06/2017 - Parameter to activate Red Storn

	titulo 		:= OemToAnsi(STR0003)+Alltrim(Upper(cSayCusto))+" / " +Alltrim(Upper(cSayClVl)) 	//"Balancete de Verificacao"

oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,cSayCusto,nDivide)},cDesc1+cDesc2)
oReport:ParamReadOnly()

If lImpMov //Imprime Coluna Movimento!!
	oReport:SetLandScape(.T.)
Else
	oReport:SetPortrait(.T.)
EndIf

// Sessao 1
oSection1 := TRSection():New(oReport,Capital(STR0021),{"cArqTmp", "CTT"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)  //"CENTRO DE CUSTO"
oReport:SetTotalInLine(.F.)
oReport:SetTotalText(Capital(STR0018))
oReport:EndPage(.T.)

//Somente sera impresso centro de custo analitico	
TRCell():New(oSection1,"CUSTO"		,"cArqTmp",Capital(STR0021),/*Picture*/,aTamCC[1]		,/*lPixel*/,bCdCUSTO)  //"CENTRO DE CUSTO"
TRCell():New(oSection1,"CCRES"		,"cArqTmp",Capital(STR0022),/*Picture*/,aTamCCRes[1]	,/*lPixel*/,bCdCCRES)  //"CODIGO RED. C. CUSTO"
TRCell():New(oSection1,"DESCCC"		,"cArqTmp",Capital(STR0030)	,/*Picture*/,nTamCC			,/*lPixel*/,/*{|| }*/)  //"DESCRICAO"
oSection1:SetLineStyle()
oSection1:SetNoFilter({"cArqTmp", "CTT"})
TRPosition():New( oSection1, "CTT", 1, {|| xFilial("CTT") + cArqTMP->CUSTO })

If lContaNormal
	oSection1:Cell("CCRES"	):Disable()
Else
	oSection1:Cell("CUSTO"	):Disable() 
EndIf

If lSaltaPag
	oSection1:SetPageBreak(.T.)
EndIf

// Sessao 2
oSection2 := TRSection():New(oSection1,Capital(STR0023),{"cArqTmp", "CTH"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)  //"CLASSE DE VALOR"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage()
oSection2:SetLinesBefore(0)
oSection2:SetNoFilter({"cArqTmp"})

If !lIsRussia
	TRCell():New(oSection2,"CLVL"		,"cArqTmp",Capital(STR0023)	,/*Picture*/,aTamClVl[1]		,/*lPixel*/, bCdCVRL  )//"CLASSE DE VALOR"
	TRCell():New(oSection2,"CLVLRES"	,"cArqTmp",Capital(STR0024)	,/*Picture*/,aTamCVRes[1]		,/*lPixel*/, bCdCVRES )// "CL. VALOR. RES"
	TRCell():New(oSection2,"DESCCLVL"	,"cArqTmp",Capital(STR0030),/*Picture*/,nTamClVl			,/*lPixel*/,/*{|| }*/)//"DESCRICAO"
	TRCell():New(oSection2,"SALDOANT"	,"cArqTmp",Capital(STR0025)	,/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT") //"SALDO ANTERIOR"
	TRCell():New(oSection2,"SALDODEB"	,"cArqTmp",Capital(STR0026),/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT") //"DEBITO"			
	TRCell():New(oSection2,"SALDOCRD"	,"cArqTmp",Capital(STR0027),/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT") //"CREDITO"		
	If lImpMov //Imprime Coluna Movimento!!
		TRCell():New(oSection2,"MOVIMENTO","cArqTmp",Capital(STR0028),/*Picture*/,TAM_VALOR+2,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT") //"MOVIMENTO DO PERIODO"
	EndIf
	TRCell():New(oSection2,"SALDOATU"	,"cArqTmp",Capital(STR0029),/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT") //"SALDO ATUAL"	
	TRPosition():New( oSection2, "CTH", 1, {|| xFilial("CTH") + cArqTMP->CLVL })
	
	If lClVlNormal
		oSection2:Cell("CLVLRES"	):Disable()
	Else
		oSection2:Cell("CLVL"	):Disable() 
	EndIf
	
	oSection2:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCLVL == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->TIPOCLVL;
								)  })
	
	oSection2:SetLineCondition({|| (cCustoAnt := cArqTmp->CUSTO,f320Fil(cSegAte,cSegmento,nDigitAte,cSegIni,cSegFim,cFiltSegm,nPos,nDigitos)) })

// Totais das sessoes	
	oBreak:= TRBreak():New(oSection2,{ || cArqTmp->CUSTO },{||Capital(STR0020+" "+cSayCusto+" : "+cCustoAnt)},.F.)
	
	oBreak:OnBreak({ || nTotdbt := oTRF1:GetValue(),nTotcrt := oTRF2:GetValue() })

	oTRF1 := TRFunction():New(oSection2:Cell("SALDODEB"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f320Soma("D",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF1:disable()
	 		 TRFunction():New(oSection2:Cell("SALDODEB"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotdbt,,,TAM_VALOR+2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
	
	oTRF2 := TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f320Soma("C",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF2:disable()
			 TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt,,,TAM_VALOR+2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection2)
	
	If .F. //lImpMov
	
		TRFunction():New(oSection2:Cell("MOVIMENTO"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ( nTotMov := (nTotcrt - nTotdbt),;
		IIF ( nTotMov < 0,;
	         ValorCTB(nTotMov,,,TAM_VALOR+2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),;
		     IIF ( nTotMov > 0,ValorCTB(nTotMov,,,TAM_VALOR+2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),nil) ))},.F.,.F.,.F.,oSection2)

	EndIf
// Total geral

	oTRF3 := TRFunction():New(oSection2:Cell("SALDODEB"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f320Soma("D",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF3:disable()
			 TRFunction():New(oSection2:Cell("SALDODEB"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF3:GetValue(),,,TAM_VALOR+2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection2)

	oTRF4 := TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f320Soma("C",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF4:disable()
			 TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF4:GetValue(),,,TAM_VALOR+2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.F.,.T.,.F.,oSection2)
Else
	TRCell():New(oSection2,"CLVL"		,"cArqTmp",Capital(STR0023)	,/*Picture*/,aTamClVl[1]		,/*lPixel*/, bCdCVRL  )//"CLASSE DE VALOR"
	TRCell():New(oSection2,"CLVLRES"	,"cArqTmp",Capital(STR0024)	,/*Picture*/,aTamCVRes[1]		,/*lPixel*/, bCdCVRES )// "CL. VALOR. RES"
	TRCell():New(oSection2,"DESCCLVL"	,"cArqTmp",Capital(STR0030),/*Picture*/,nTamClVl			,/*lPixel*/,/*{|| }*/)//"DESCRICAO"
	TRCell():New(oSection2,"SALDOANT"	,"cArqTmp",Capital(STR0025)	,/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lRedStorn,cArqTmp->CLNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT") //"SALDO ANTERIOR"
	TRCell():New(oSection2,"SALDODEB"	,"cArqTmp",Capital(STR0026),/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,Iif(lRedStorn,cArqTmp->CLNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT") //"DEBITO"			
	TRCell():New(oSection2,"SALDOCRD"	,"cArqTmp",Capital(STR0027),/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,Iif(lRedStorn,cArqTmp->CLNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT") //"CREDITO"		
	If lImpMov //Imprime Coluna Movimento!!
		TRCell():New(oSection2,"MOVIMENTO","cArqTmp",Capital(STR0028),/*Picture*/,TAM_VALOR+2,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lRedStorn,cArqTmp->CLNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT") //"MOVIMENTO DO PERIODO"
	EndIf
	TRCell():New(oSection2,"SALDOATU"	,"cArqTmp",Capital(STR0029),/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lRedStorn,cArqTmp->CLNORMAL,cArqTmp->NORMAL),,,,,,lPrintZero,.F.)},"RIGHT",,"RIGHT") //"SALDO ATUAL"	
	TRPosition():New( oSection2, "CTH", 1, {|| xFilial("CTH") + cArqTMP->CLVL })
	
	If lClVlNormal
		oSection2:Cell("CLVLRES"	):Disable()
	Else
		oSection2:Cell("CLVL"	):Disable() 
	EndIf
	
	oSection2:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCLVL == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
									 cTipoAnt := cArqTmp->TIPOCLVL;
								)  })
	
	oSection2:SetLineCondition({|| (cCustoAnt := cArqTmp->CUSTO,f320Fil(cSegAte,cSegmento,nDigitAte,cSegIni,cSegFim,cFiltSegm,nPos,nDigitos)) })

// Totais das sessoes	
	oBreak:= TRBreak():New(oSection2,{ || cArqTmp->CUSTO },{||Capital(STR0020+" "+cSayCusto+" : "+cCustoAnt)},.F.)
	
	oBreak:OnBreak({ || nTotdbt := oTRF1:GetValue(),nTotcrt := oTRF2:GetValue() })

	oTRF1 := TRFunction():New(oSection2:Cell("SALDODEB"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f320Soma("D",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF1:disable()
	 		 TRFunction():New(oSection2:Cell("SALDODEB"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotdbt,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection2)
	
	oTRF2 := TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f320Soma("C",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF2:disable()
			 TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection2)
	
// Total geral
	 TRFunction():New(oSection2:Cell("DESCCLVL"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ""},.F.,.T.,.F.,oSection2)
	 TRFunction():New(oSection2:Cell("SALDOANT"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || "" },.F.,.T.,.F.,oSection2)

	oTRF3 := TRFunction():New(oSection2:Cell("SALDODEB"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f320Soma("D",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF3:disable()
			 TRFunction():New(oSection2:Cell("SALDODEB"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF3:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSection2)

	oTRF4 := TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f320Soma("C",cSegAte) },.F.,.F.,.F.,oSection2)
	oTRF4:disable()
			 TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF4:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSection2)

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
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayClVl,cSayCusto,nDivide)

Local oSection1 	:= oReport:Section(1)
Local oSection2		:= oReport:Section(1):Section(1)

Local cArqTmp		:= ""
Local cFiltro		:= oSection1:GetAdvplExp()

Local dDataLP		:= mv_par26
Local dDataFim		:= mv_par02
Local cMascClVl		:= IIF (Empty(aSetOfBook[7]),"",aSetOfBook[7])//Mascara do Centro de Custo
Local cMascCta		:= IIF (Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),aSetOfBook[2])//Mascara da Conta
Local lImpSint		:= Iif(mv_par07==1 .Or. mv_par07 ==3,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par09==1,.T.,.F.)
Local lImpMov		:= Iif(mv_par18==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)
Local lImpAntLP		:= Iif(mv_par25==1,.T.,.F.)
Local lImpConta		:= .F.
Local cConta		:= Space(Len(CriaVar("CT1_CONTA")))
Local cItem			:= Len(CriaVar("CTD_ITEM"))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF mv_par07 == 1
		Titulo:=	OemToAnsi(STR0006)+ Alltrim(Upper(cSayCusto)) + " / " + Alltrim(Upper(cSayClvl)) 	//"BALANCETE ANALITICO DE  "
	ElseIf mv_par07 == 2                                  
		Titulo:=	OemToAnsi(STR0007) + Alltrim(Upper(cSayCusto)) + " / " + Alltrim(Upper(cSayclvl))	//"BALANCETE SINTETICO DE  "
	ElseIf mv_par07 == 3
		Titulo:=	OemToAnsi(STR0008) + Alltrim(Upper(cSayCusto)) + " / " + Alltrim(Upper(cSayClVl))	//"BALANCETE DE  "
	EndIf
	
	Titulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + OemToAnsi(STR0010) + Dtoc(mv_par02) + ;
					OemToAnsi(STR0011) + cDescMoeda
	
	If mv_par12 > "1"			
		Titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
	Endif
	
	oReport:SetPageNumber(mv_par11) //mv_par14	-	Pagina Inicial
	oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao							  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CTW","",cConta,cConta,mv_par03,mv_par04,cItem,cItem,;
				mv_par05,mv_par06,mv_par10,mv_par12,aSetOfBook,mv_par14,;
				mv_par15,mv_par16,mv_par17,!lImpMov,.F.,2,"CTT",lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,,cFiltro/*aReturn[7]*/)},;
				OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor rio..."
				OemToAnsi(STR0003)+Alltrim(Upper(cSayCusto)) + " / " + Alltrim(Upper(cSayClVl)))     //"Balancete Verificacao "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f320Soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR320                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f320Soma(cTipo,cSegAte)

Local nRetValor		:= 0

	If mv_par07 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOCLVL == "1" .And. cArqTmp->NIVEL1
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		Endif                   
	Else
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOCLVL == "2"
				If cTipo == "D"
					nRetValor := cArqTmp->SALDODEB
				ElseIf cTipo == "C"
					nRetValor := cArqTmp->SALDOCRD
				EndIf
			Endif
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOCLVL == "1" .And. cArqTmp->NIVEL1
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f320Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR320                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f320Fil(cSegAte,cSegmento,nDigitAte,cSegIni,cSegFim,cFiltSegm,nPos,nDigitos)

Local lDeixa	:= .T.
Local nCont    := 0

	If mv_par07 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCLVL == "2"
			lDeixa := .F.
		EndIf
	ElseIf mv_par07 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCLVL == "1"
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
			nDigitAte += Val(Subs(cMascClVl,nCont,1))	
		Next
	EndIf		

	//Filtragem ate o Segmento do centro de custo(antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->CLVL)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)


