/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.Ch"
#Include "CTBR140.Ch"

#DEFINE TAM_VALOR	20

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema


// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR140  ³ Autor ³ Cicero J. Silva   	³ Data ³ 04.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Conta/Item.                   			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR140      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR140()

Local aArea := GetArea()
Local oReport          

Local lOk := .T.
Local aCtbMoeda		:= {}
Local nDivide		:= 1

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR140"
PRIVATE nomeProg  	:= "CTBR140"  
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE oTRF3
PRIVATE oTRF4
PRIVATE oTRF5
PRIVATE oTRF6
PRIVATE nTotMov	:= 0
PRIVATE nTotdbt	:= 0
PRIVATE nTotcrt	:= 0
PRIVATE titulo
PRIVATE nTotAnt	:= 0
PRIVATE nTotAtu	:= 0
PRIVATE aSelFil	:= {}

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

If lOk .And. mv_par28 == 1 .And. Len( aSelFil ) <= 0
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		lOk := .F.
	EndIf 
EndIf     

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par10) // Moeda?
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

Local cSayItem		:= CtbSayApro("CTD")

LOCAL cDesc1 		:= OemToAnsi(STR0001)+ Upper(cSayItem)	//"Este programa ira imprimir o Balancete de Conta / "
LOCAL cDesc2 		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"

Local aTamItem  	:= TAMSX3("CTD_ITEM")
Local aTamItRes 	:= TAMSX3("CTD_RES")    
Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
                                            
Local nTamItem		:= Len(CriaVar("CTD->CTD_DESC"+mv_par10))
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+mv_par10))

Local lSaltaPag		:= Iif(mv_par20==1,.T.,.F.)
Local lPula			:= Iif(mv_par21==1,.T.,.F.)
Local lItemNormal	:= Iif(mv_par23==1,.T.,.F.)
Local lContaNormal	:= Iif(mv_par25==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)

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
	
Local cMascara1		:= IIF (Empty(aSetOfBook[7]),"",RetMasCtb(aSetOfBook[7],@cSepara1))//Mascara do Centro de Custo
Local cMascara2		:= IIF (Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSepara2))//Mascara da Conta

Local cPicture 		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)
Local cDescMoeda 	:= aCtbMoeda[2]

Local bCdITEM	:= {|| EntidadeCTB(cArqTmp->ITEM,0,0,20,.F.,cMascara1,cSepara1,,,,,.F.) }
Local bCdITRES	:= {|| EntidadeCTB(cArqTmp->ITEMRES,0,0,20,.F.,cMascara1,cSepara1,,,,,.F.) }

Local bCdCONTA	:= {|| EntidadeCTB(cArqTmp->CONTA,0,0,25 ,.F.,cMascara2,cSepara2,,,,,.F.)}
Local bCdCTRES	:= {|| EntidadeCTB(cArqTmp->CTARES,0,0,20,.F.,cMascara2,cSepara2,,,,,.F.)}

Local bNormal 	:= {|| Posicione("CTD",1,xFilial("CTD")+cArqTmp->ITEM,"CTD_NORMAL") }
Local cNormal	:= ''

Local lColDbCr 		:= lIsRedStor // Disconsider cTipo in ValorCTB function, setting cTipo to empty

If lIsRedStor
	bNormal 	:= {|| cArqTmp->NORMAL }
Endif

titulo	:= STR0003+ Upper(cSayItem) 	//"Balancete de Verificacao Conta / "


oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,cSayItem,nDivide)},cDesc1+cDesc2)
oReport:SetLandScape(.T.)

// Sessao 1
oSection1 := TRSection():New(oReport,STR0023+" x "+cSayItem ,{"cArqTmp","CT1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/) //"Conta"
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)

//Somente sera impresso centro de custo analitico	
TRCell():New(oSection1,"CONTA"		,"cArqTmp",STR0024	,/*Picture*/,aTamConta[1]	,/*lPixel*/, bCdCONTA )// Codigo da Conta //"Código"
TRCell():New(oSection1,"CTARES"		,"cArqTmp",STR0025	,/*Picture*/,aTamCtaRes[1]	,/*lPixel*/, bCdCTRES )// Codigo Reduzido da Conta //"Cód. reduzido"
TRCell():New(oSection1,"DESCCTA"	,"cArqTmp",STR0026	,/*Picture*/,nTamCta		,/*lPixel*/,/*{|| }*/ )// Descricao da Conta //"Descrição"

TRPosition():New( oSection1, "CT1", 1, {|| xFilial("CT1") + cArqTMP->CONTA })

If lContaNormal
	oSection1:Cell("CTARES"):Disable()
Else
	oSection1:Cell("CONTA" ):Disable() 
EndIf

If lSaltaPag
	oSection1:SetPageBreak(.T.)
EndIf

oSection1:SetLineCondition({|| IIF(cArqTmp->TIPOCONTA == "1",.F.,.T.) })

// Sessao 2
oSection2 := TRSection():New(oSection1,cSayItem,{"cArqTmp","CTD"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage()

TRCell():New(oSection2,"ITEM"		,"cArqTmp"	,"Código"  	  		,/*Picture*/,aTamItem[1]+5	,/*lPixel*/, bCdITEM  )// Codigo do Item          
TRCell():New(oSection2,"ITEMRES"	,"cArqTmp"	,STR0025   	  		,/*Picture*/,aTamItRes[1]	,/*lPixel*/, bCdITRES )// Codigo Reduzido do Item //"Cód. reduzido"
TRCell():New(oSection2,"DESCITEM"	,"cArqTmp"	,STR0027   	   		,/*Picture*/,nTamItem		,/*lPixel*/,/*{|| }*/) //"Descricao"
TRCell():New(oSection2,"SALDOANT"	,"cArqTmp"	,STR0028   	   		,/*Picture*/,TAM_VALOR+2	,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)}		, /*"RIGHT"*/,,"RIGHT",,,.F.)// Saldo Anterior //"Saldo anterior"
TRCell():New(oSection2,"SALDODEB"	,"cArqTmp"	,STR0029   			,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr)}					, /*"RIGHT"*/,,"RIGHT",,,.F.)// Debito //"Débito"
TRCell():New(oSection2,"SALDOCRD"	,"cArqTmp"	,STR0030	   		,/*Picture*/,TAM_VALOR		,/*lPixel*/,{|| ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,nDecimais,.F.,cPicture,,,,,,,lPrintZero,.F.,lColDbCr)}					, /*"RIGHT"*/,,"RIGHT",,,.F.)// Credito //"Crédito"

If lImpMov //Imprime Coluna Movimento!!
	TRCell():New(oSection2,"MOVIMENTO","cArqTmp",STR0031  			,/*Picture*/,TAM_VALOR+2		,/*lPixel*/,{|| ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)}		, /*"RIGHT"*/,,"RIGHT",,,.F.)// Movimento do Periodo //"Movimento do periodo"
EndIf

TRCell():New(oSection2,	"SALDOATU"	,"cArqTmp"	,STR0032			,/*Picture*/,TAM_VALOR+2		, /*lPixel*/,{|| ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR,nDecimais,.T.,cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)}		, /*"RIGHT"*/,,"RIGHT",,,.F.)// Saldo Atual //"Saldo atual"

TRCell():New(oSection2,"TIPOITEM"	,"cArqTmp"	,STR0033+cSayItem	,/*Picture*/,01		   		,/*lPixel*/,/*{|| }*/)// Centro Custo / Sintetica            //"Tipo "
TRCell():New(oSection2,"TIPOCONTA"	,"cArqTmp"	,STR0033+STR0023	,/*Picture*/,01		   		,/*lPixel*/,/*{|| }*/)// Conta Analitica / Sintetica            //"Tipo "###"Conta"
TRCell():New(oSection2,"NIVEL1"		,"cArqTmp"	,STR0034			,/*Picture*/,01		   		,/*lPixel*/,/*{|| }*/)// Logico para identificar se  //"Nivel 1"	

oSection2:Cell("TIPOITEM" 	):Disable()
oSection2:Cell("TIPOCONTA"	):Disable()
oSection2:Cell("NIVEL1"  	):Disable()

oSection2:Cell("SALDOANT"):lHeaderSize	:= .F.
oSection2:Cell("SALDODEB"):lHeaderSize	:= .F.
oSection2:Cell("SALDOCRD"):lHeaderSize	:= .F.

If lImpMov //Imprime Coluna Movimento!!
	oSection2:Cell("MOVIMENTO"):lHeaderSize	:= .F.
Endif

oSection2:Cell("SALDOATU"):lHeaderSize	:= .F.  

TRPosition():New( oSection2, "CTD", 1, {|| xFilial("CTD") + cArqTMP->ITEM })

If lItemNormal
	oSection2:Cell("ITEMRES"	):Disable()
Else
	oSection2:Cell("ITEM"	):Disable() 
EndIf

oSection2:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOITEM == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
								 cTipoAnt := cArqTmp->TIPOITEM,cNormal:=cArqTmp->NORMAL, conout(cArqTmp->NORMAL);
							)  })

oSection2:SetLineCondition({|| f140Fil(cSegAte,cSegmento,nDigitAte,cSegIni,cSegFim,cFiltSegm,nPos,nDigitos,cMascara1) })

// Totais das sessoes
oBreak:= TRBreak():New(oSection2,{ || cArqTmp->CONTA },STR0020,.F.)
oBreak:OnBreak({ || nTotAnt := oTRF1:GetValue(),nTotdbt := oTRF2:GetValue(),nTotcrt := oTRF3:GetValue(),nTotAtu :=oTRF4:GetValue()})

oTRF1 := TRFunction():New(oSection2:Cell("SALDOANT"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f140Soma("A",cSegAte) },.F.,.F.,.F.,oSection2)
oTRF2 := TRFunction():New(oSection2:Cell("SALDODEB"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f140Soma("D",cSegAte) },.F.,.F.,.F.,oSection2)
oTRF3 := TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f140Soma("C",cSegAte) },.F.,.F.,.F.,oSection2)
oTRF4 := TRFunction():New(oSection2:Cell("SALDOATU"),nil,"SUM",oBreak,/*Titulo*/,/*cPicture*/,{ || f140Soma("T",cSegAte) },.F.,.F.,.F.,oSection2)

oTRF1:disable()
oTRF2:disable()
oTRF3:disable()
oTRF4:disable()

TRFunction():New(oSection2:Cell("SALDOANT"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotAnt,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.,/*lColDbCr*/) },.F.,.F.,.F.,oSection2)
TRFunction():New(oSection2:Cell("SALDODEB"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotdbt,,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection2)
TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt,,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection2)

If lImpMov
	If lIsRedStor
		TRFunction():New(oSection2:Cell("MOVIMENTO"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt - nTotdbt,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.,/*lColDbCr*/)},.F.,.F.,.F.,oSection2)
	Else
		TRFunction():New(oSection2:Cell("MOVIMENTO"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotcrt - nTotdbt,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.)},.F.,.F.,.F.,oSection2)
	Endif
EndIf  

TRFunction():New(oSection2:Cell("SALDOATU"),nil,"ONPRINT",oBreak,/*Titulo*/,/*cPicture*/,{ || ValorCTB(nTotAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.,) },.F.,.F.,.F.,oSection2)

// Total Geral
oTRF5 := TRFunction():New(oSection2:Cell("SALDODEB"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f140Soma("D",cSegAte) },.F.,.F.,.F.,oSection2)
oTRF6 := TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || f140Soma("C",cSegAte) },.F.,.F.,.F.,oSection2)

oTRF5:disable()
oTRF6:disable()

TRFunction():New(oSection2:Cell("SALDODEB"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF5:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSection2)
TRFunction():New(oSection2:Cell("SALDOCRD"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ValorCTB(oTRF6:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.T.,.F.,oSection2)
    	
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

Local oSection1 	:= oReport:Section(1)
Local oSection2	:= oReport:Section(1):Section(1)

Local cArqTmp		:= ""
Local cFiltro	:= oSection1:GetAdvplExp('CT1')

Local dDataLP		:= mv_par27
Local dDataFim		:= mv_par02
Local cMascItem		:= IIF (Empty(aSetOfBook[7]),"",aSetOfBook[7])//Mascara do Centro de Custo
Local cMascCta		:= IIF (Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),aSetOfBook[2])//Mascara da Conta
Local lImpSint		:= Iif(mv_par07==1 .Or. mv_par07 ==3,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par09==1,.T.,.F.)
Local lImpMov		:= Iif(mv_par18==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)
Local lImpAntLP		:= Iif(mv_par26==1,.T.,.F.)
Local cSegmento		:= mv_par14
Local nDigitAte		:= 0
Local nPos			:= 0
Local nDigitos		:= 0


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF mv_par07 == 1
		Titulo:=	OemToAnsi(STR0006) + Upper(cSayItem)	//"BALANCETE ANALITICO DE CONTA / "
	ElseIf mv_par07 == 2
		Titulo:=	OemToAnsi(STR0007) + Upper(cSayItem)	//"BALANCETE SINTETICO DE CONTA / "
	ElseIf mv_par07 == 3
		Titulo:=	OemToAnsi(STR0008) + Upper(cSayItem)	//"BALANCETE DE CONTA / "
	EndIf
	
	Titulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + OemToAnsi(STR0010) + Dtoc(mv_par02) + ;
					OemToAnsi(STR0011) + cDescMoeda
	
	If mv_par12 > "1"
		Titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
	EndIf
	
	If nDivide > 1			
		Titulo += " (" + OemToAnsi(STR0022) + Alltrim(Str(nDivide)) + ")"
	EndIf	
	
	oReport:SetPageNumber(mv_par11) //mv_par14	-	Pagina Inicial
	oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao					  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				 mv_par01,mv_par02,"CT4","",mv_par03,mv_par04,,,mv_par05,mv_par06,,,mv_par10,;
				  mv_par12,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17, !lImpMov,.T.,,"CT1",;
				   lImpAntLP,dDataLP, nDivide,lVlrZerado,,,,,,,,,,,,,lImpMov,lImpSint,cFiltro,,,,,,,,,,,,aSelFil)},;
					OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor rio..."
					 OemToAnsi(STR0003)+cSayItem)     //"Balancete Verificacao Conta /"


	If !Empty(cSegmento)
		dbSelectArea("CTM")
		dbSetOrder(1)
		If MsSeek(xFilial()+cMascItem)  
			While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == cMascItem
				nPos += Val(CTM->CTM_DIGITO)
				If CTM->CTM_SEGMEN == cSegmento
					nPos -= Val(CTM->CTM_DIGITO)
					nPos ++
					nDigitos := Val(CTM->CTM_DIGITO)      
					Exit
				EndIf	
				dbSkip()
			EndDo	
		EndIf	
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("cArqTmp")
	dbSetOrder(1)	
	dbGotop()
	//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
	//nao esta disponivel e sai da rotina.
	If !( RecCount() == 0 .And. !Empty(aSetOfBook[5]) )
		
		oSection2:SetParentFilter( { |cParam| cArqTmp->CONTA == cParam },{ || cArqTmp->CONTA })// SERVE PARA IMPRIMIR O TITULO DA SECAO PAI

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
±±ºPrograma  ³f140Soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR140                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f140Soma(cTipo,cSegAte)

Local nRetValor		:= 0

If mv_par07 != 1					// Imprime Analiticas ou Ambas
	If cArqTmp->TIPOITEM == "2"
		If cArqTmp->TIPOCONTA== "2"
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			ElseIf cTipo == "A"
				nRetValor := cArqTmp->SALDOANT
			ElseIf cTipo == "T"
				nRetValor := cArqTmp->SALDOATU
			EndIf
		EndIf
		If cTipo == "D"
			nRetValor := cArqTmp->SALDODEB
		ElseIf cTipo == "C"
			nRetValor := cArqTmp->SALDOCRD
		ElseIf cTipo == "A"
			nRetValor := cArqTmp->SALDOANT
		ElseIf cTipo == "T"
			nRetValor := cArqTmp->SALDOATU
		EndIf
	Endif
Else
	If cArqTmp->TIPOITEM == "1" .And. cArqTmp->NIVEL1
		If cTipo == "D"
			nRetValor := cArqTmp->SALDODEB
		ElseIf cTipo == "C"
			nRetValor := cArqTmp->SALDOCRD
		ElseIf cTipo == "A"
			nRetValor := cArqTmp->SALDOANT
		ElseIf cTipo == "T"
			nRetValor := cArqTmp->SALDOATU
		EndIf
	Endif
	If cArqTmp->TIPOITEM == "1" .And. Empty(cArqTmp->ITSUP)
		If cTipo == "D"
			nRetValor := cArqTmp->SALDODEB
		ElseIf cTipo == "C"
			nRetValor := cArqTmp->SALDOCRD
		ElseIf cTipo == "A"
			nRetValor := cArqTmp->SALDOANT
		ElseIf cTipo == "T"
			nRetValor := cArqTmp->SALDOATU
		EndIf
	Endif
Endif

Return nRetValor                                                                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f140Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR140                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f140Fil(cSegAte,cSegmento,nDigitAte,cSegIni,cSegFim,cFiltSegm,nPos,nDigitos,cMascara1)

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

	// Verifica Se existe filtragem Ate o Segmento
	If !Empty(cSegAte)
		nDigitAte := CtbRelDig( cSegAte, cMascara1 )
	EndIf		

	//Filtragem ate o Segmento do centro de custo(antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->ITEM)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)