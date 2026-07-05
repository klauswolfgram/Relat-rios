/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.Ch"
#Include "ctbr047.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ctbr047   ºAutor  ³Patricia Ikari      º Data ³  18/05/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Balancete de Verificacao                                   º±±
±±º          ³ Impresso somente em modo Grafico (R4) e Paisagem           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ sigactb                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ctbr047()
Private titulo		:= ""
Private nomeprog	:= "CTBR047"
Private oReport		:= Nil
Private aSelFil		:= {}

If ! FindFunction( "TRepInUse" ) .And. TRepInUse()
	MsgAlert( STR0004 ) // 'Informe Impreso solamente en modo grafico'
	Return .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transforma parametros Range em expressao (intervalo) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr( "CTR047" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a montagem do relatorio                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := U_ReportDf()

If Valtype( oReport ) == 'O'

	If ! Empty( oReport:uParam )
		Pergunte( oReport:uParam, .F. )
	EndIf

	oReport:PrintDialog()
Endif

oReport := Nil

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDf  ºAutor  ³Patricia Ikari      º Data ³  18/05/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Balancete de Verificacao                                   º±±
±±º          ³ Impresso somente em modo Grafico (R4) e Paisagem           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ sigactb                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ReportDf()

Local cReport		:= "CTBR047"
Local cDesc			:= OemToAnsi(STR0001) + OemToAnsi(STR0002) + OemToAnsi(STR0003)//' Este programa imprimira el Balance Parcial de Verificacion (MODO HORIZONTAL), la' ##  'cuenta se imprime limitando a 20 caracteres y su descripcion esta limitada a 40 caracteres.' ## 'BALANCE PARCIAL DE VERIFICACION'
Local cPerg	   		:= "CTR047"
Local cMascara		:= ""
Local cSeparador	:= ""
Local aSetOfBook

cTitulo	:= STR0003 //'BALANCE PARCIAL DE VERIFICACION'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Efetua a pergunta antes de montar a configuração do      ³
//³ relatorio, afim de poder definir o layout a ser impresso ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte( "CTR047" , .f. )
makesqlexpr("CTR047")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)	    	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! Ct040Valid( mv_par07 )
	Return .F.
Else
   aSetOfBook := CTBSetOf( mv_par07 )
Endif

cMascara := RetMasCtb( aSetOfBook[2], @cSeparador )

cPicture := aSetOfBook[4]

oReport	 := TReport():New( cReport,Capital( cTitulo ),cPerg, { |oReport| Pergunte(cPerg , .F. ), If(! ReportPrint( oReport ), oReport:CancelPrint(), .T. ) }, cDesc )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Relatorio impresso somente em modo paisagem              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetLandScape(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da estrutura do relatorio                       |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1  := TRSection():New( oReport, STR0004, { "cArqTmp" , "CT1" } ,, .F., .F. ) //'Informe Impreso solamente en modo grafico'

TRCell():New( oSection1, "CONTA"      ,,STR0007							 /*Titulo*/	,/*Picture*/, 20/*Tamanho*/, /*lPixel*/, /*CodeBlock*/) //'Cuenta'
TRCell():New( oSection1, "DESCCTA"    ,,STR0008							 /*Titulo*/	,/*Picture*/, 40/*Tamanho*/, /*lPixel*/, /*CodeBlock*/) //'Denominación'
TRCell():New( oSection1, "SALDOANTDB" ,,STR0009+Chr(13)+Chr(10)+STR0013/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection1, "SALDOANTCR" ,,STR0009+Chr(13)+Chr(10)+STR0014/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection1, "SALDODEB"   ,,STR0010+Chr(13)+Chr(10)+STR0013/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER") //STR0010
TRCell():New( oSection1, "SALDOCRD"   ,,STR0010+Chr(13)+Chr(10)+STR0014/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER") //STR0010
TRCell():New( oSection1, "SALDOATUDB" ,,"Suma Del Mayor"+Chr(13)+Chr(10)+STR0013/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")//STR0011
TRCell():New( oSection1, "SALDOATUCR" ,,"Suma Del Mayor"+Chr(13)+Chr(10)+STR0014/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")//STR0011

TRCell():New( oSection1, "SALDO31DB" ,,"Saldo al 31 Dic"+Chr(13)+Chr(10)+STR0013/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")//STR0021
TRCell():New( oSection1, "SALDO31CR" ,,"Saldo al 31 Dic"+Chr(13)+Chr(10)+STR0014/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")//STR0021

TRCell():New( oSection1, "SALDOBALAC" ,,"Cuenta Balance"+Chr(13)+Chr(10)+STR0023/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")//STR0021
TRCell():New( oSection1, "SALDOBALPA" ,,"Cuenta Balance"+Chr(13)+Chr(10)+STR0024/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")//STR0021
TRCell():New( oSection1, "SALDOFUCPE" ,,"Resultado Natur."+Chr(13)+Chr(10)+STR0025/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER") //STR0022
TRCell():New( oSection1, "SALDOFUCGA" ,,"Resultado Natur."+Chr(13)+Chr(10)+STR0026/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")//STR0022

oSection2  := TRSection():New( oReport, STR0021, { "" } ,, .F., .F. ) //

TRCell():New( oSection2, "TOTAL"     ,,/*Titulo*/	,/*Picture*/, 20/*Tamanho*/, /*lPixel*/, {|| STR0015}/*CodeBlock*/)
TRCell():New( oSection2, "DUMMY"     ,,/*Titulo*/	,/*Picture*/, 38/*Tamanho*/, /*lPixel*/, {||""}/*CodeBlock*/)
TRCell():New( oSection2, "SOMAANTDB" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMAANTCR" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMADEB"   ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMACRD"   ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMAATUDB" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMAATUCR" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")

TRCell():New( oSection2, "SOMASAL31D" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMASAL31C" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")

TRCell():New( oSection2, "SOMABALAC" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMABALPA" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMAFUCPE" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
TRCell():New( oSection2, "SOMAFUCGA" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"CENTER")
oSection2:SetHeaderSection(.F.)

TRPosition():New( oSection1, "CT1", 1, {|| xFilial( "CT1" ) + cArqTMP->CONTA })

oSection1:SetTotalInLine(.F.)
oSection1:SetTotalText( '' )

Return( oReport )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |ReportPrintºAutor  ³Patricia Ikari     º Data ³  18/05/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Efetua a impressao do relatorio							  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SigaCTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint( oReport )
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local aSetOfBook
Local lRet			:= .T.
Local lPrintZero	:= (mv_par14==1)
Local lPula			:= (mv_par13==1)
Local lNormal		:= .T.
Local lVlrZerado	:= (mv_par08==1)
Local nDecimais
Local nDivide		:= 1
Local lImpAntLP		:= (mv_par16 == 1)
Local dDataLP		:= mv_par17
Local lImpSint		:= Iif(mv_par06=1 .Or. mv_par06 ==3,.T.,.F.)
Local lRecDesp0		:= (mv_par18 == 1)
Local cRecDesp		:= mv_par19
Local dDtZeraRD		:= mv_par20
Local oMeter
Local oText
Local oDlg
Local aCtbMoeda		:= {}
Local cArqTmp		:= ""
Local cSeparador	:= ""
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local cPicture
Local nCont			:= 0
Local cFilUser		:= ""
Local cRngFil	 // range de filiais para a impressão do relatorio
Local dDtCorte	 	:= mv_par03
Local nSomaAntDB	:= 0
Local nSomaAntCR	:= 0
Local nSomaDB		:= 0
Local nSomaCR		:= 0
Local nSomaAtuDB	:= 0
Local nSomaAtuCR	:= 0
Local nSSal31CR	    := 0
Local nSSal31DB	    := 0
Local nSomaBalAc	:= 0
Local nSomaBalPa	:= 0
Local nSomaFucPe	:= 0
Local nSomaFucGa	:= 0
Local nSal1         := 0
Local nSal2         := 0

If mv_par21 == 1 .And. Len( aSelFil ) <= 0  .And. !IsBlind()
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		Return
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratativa para os parametros que irão funcionar somente para ³
//³ TOPCONN                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFNDEF TOP
	cRngFil	   		:= xFilial( "CT7" )
	dDtCorte	 	:= CTOD("  /  /  ")
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! ct040Valid( mv_par07 )
	Return .F.
Else
   aSetOfBook := CTBSetOf(mv_par07)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validação das moedas do CTB                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCtbMoeda := CtbMoeda( mv_par09 , nDivide )

If Empty(aCtbMoeda[1])
	Help(" ",1,"NOMOEDA")
	Return .F.
Endif

cDescMoeda 	:= Alltrim(aCtbMoeda[2])
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par09)

If Empty( aSetOfBook[2] )
	cMascara := GetMv( "MV_MASCARA" )
Else
	cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf
cPicture 		:= aSetOfBook[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seta o numero da pagina                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetPageNumber( mv_par12 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Titulo do Relatorio                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cPaisLoc == "PER"
	Titulo += 	STR0027 //"Balance de comprobacion"
Else
	Titulo += 	STR0003 + STR0005 + DTOC(MV_PAR01) +;	// 'BALANCE PARCIAL DE VERIFICACION' # "DE"
				STR0006 + DTOC(MV_PAR02) + " " + CtbTitSaldo(mv_par10)	+ " " + cDescMoeda // 'A'
EndIf

oReport:SetTitle(Titulo)

oReport:SetCustomText( {|| CtCGCCabTR(,,,,,MV_PAR02,oReport:Title(),,,,,oReport,,,,,,,,,,MV_PAR01) } )  // CtCGCCabTR funcion ubicada en CTBXREL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro de usuario                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilUser := oSection1:GetAdvplExpr( "CT1" )

If Empty(cFilUser)
	cFilUser := ".T."
EndIf

MakeSqlExpr( "CTR047" )
cRngFil		:= mv_par21

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao			  		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(	oMeter, oText, oDlg, @lEnd,@cArqTmp,mv_par01,mv_par02,"CT7","",mv_par04,;
						mv_par05,,,,,,,mv_par09,mv_par10,aSetOfBook,,,,,;
						.F.,.F.,mv_par12,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFilUser,lRecDesp0,;
						cRecDesp,dDtZeraRD,,,,,,,,,aSelFil,dDtCorte)},;
						OemToAnsi(OemToAnsi(STR0003)),;//"Criando Arquivo Tempor rio..."
						OemToAnsi(STR0004))  			//"Balancete de Escrituração"

nCount := cArqTmp->( RecCount() )

oReport:SetMeter( nCont )

lRet := !( nCount == 0 .And. !Empty(aSetOfBook[5]))

If lRet
	cArqTmp->(dbGoTop())

	// define se ao imprimir uma linha a proxima é pulada
	oSection1:OnPrintLine( {|| IIf( lPula , oReport:SkipLine(),NIL) } )

	If lNormal
		oSection1:Cell("CONTA"):SetBlock( {|| EntidadeCTB(cArqTmp->CONTA,000,000,030,.F.,cMascara,cSeparador,,,.F.,,.F.)} )
	Else
		oSection1:Cell("CONTA"):SetBlock( {|| cArqTmp->CTARES } )
	EndIf

	oSection1:Cell("DESCCTA"):SetBlock( { || cArqTMp->DESCCTA } )

	oSection1:Cell("SALDOANTDB"):SetBlock( { || ValorCTB(cArqTmp->(IIf(SALDOANTDB > SALDOANTCR, SALDOANTDB - SALDOANTCR, 0))  ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } ) //SALDO INICIAL DEUDOR  cq0
	oSection1:Cell("SALDOANTCR"):SetBlock( { || ValorCTB(cArqTmp->(IIf(SALDOANTDB < SALDOANTCR, SALDOANTCR - SALDOANTDB, 0))  ,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } ) //SALDO INICIAL ACREDDOR cq0
	oSection1:Cell("SALDODEB")  :SetBlock( { || ValorCTB(cArqTmp->SALDODEB,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } ) //MOVIMIENTOS DEUDOR  cq0
	oSection1:Cell("SALDOCRD")  :SetBlock( { || ValorCTB(cArqTmp->SALDOCRD,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } ) //MOVIMIENTOS ACREEDOR cq0
	oSection1:Cell("SALDOATUDB"):SetBlock( { || ValorCTB(cArqTmp->SALDOATUDB,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )//SUMA DE MAYOR DEUDOR
	oSection1:Cell("SALDOATUCR"):SetBlock( { || ValorCTB(cArqTmp->SALDOATUCR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )//SUMA DE MAYOR ACREEDOR

	//Saldos al 31 de Dic
	if cArqTmp->NATCTA == '04'//si es cuenta de resultados
		oSection1:Cell("SALDO31DB"):SetBlock( { || ValorCTB(IIF(  cArqTmp->SALDODEB-cArqTmp->SALDOCRD >=0 ,   cArqTmp->SALDODEB-cArqTmp->SALDOCRD ,0 ),,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )//SALDO AL 31 DIC
		oSection1:Cell("SALDO31CR"):SetBlock( { || ValorCTB(IIF(  cArqTmp->SALDODEB-cArqTmp->SALDOCRD < 0 , ( cArqTmp->SALDODEB-cArqTmp->SALDOCRD)*-1 ,0 ),,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )//SALDO AL 31 DIC
	else
		oSection1:Cell("SALDO31DB"):SetBlock( { || ValorCTB(IIF( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR >=0 ,  cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR ,0 ),,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )//SALDO AL 31 DIC
		oSection1:Cell("SALDO31CR"):SetBlock( { || ValorCTB(IIF( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR < 0 , (cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR)*-1 ,0 ),,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )//SALDO AL 31 DIC
	endif

	//cuentas de balance
   	oSection1:Cell("SALDOBALAC"):SetBlock( { || ValorCTB(IIF( cArqTmp->NATCTA == '01'   .and. cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR >=0 ,   cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR ,0 )  ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )//CUENTAS DE BALANCE  ACTIVO.
    oSection1:Cell("SALDOBALPA"):SetBlock( { || ValorCTB(IIF( cArqTmp->NATCTA $ '02/03' .and. cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR < 0 , ( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR)*-1 ,0 )  ,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )//CUENTAS DE BALANCE  PASIVO.

    //cuentas de resultados
    oSection1:Cell("SALDOFUCPE"):SetBlock( { || ValorCTB(IIF( cArqTmp->NATCTA == '04' .and. cArqTmp->NORMAL == '1' .and. cArqTmp->SALDODEB-cArqTmp->SALDOCRD >=0 ,   cArqTmp->SALDODEB-cArqTmp->SALDOCRD ,0 ) ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )//RESULTADOS POR NATURALEZA  ACTIVO.  Si CT1_NATCTA=04 cuenta de resultado Y CONDICION DEUDORA
	oSection1:Cell("SALDOFUCGA"):SetBlock( { || ValorCTB(IIF( cArqTmp->NATCTA == '04' .and. cArqTmp->NORMAL == '2' .and. cArqTmp->SALDODEB-cArqTmp->SALDOCRD < 0 , ( cArqTmp->SALDODEB-cArqTmp->SALDOCRD)*-1 ,0 ),,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )//RESULTADOS POR NATURALEZA   PASIVO. Si CT1_NATCTA=04 cuenta de resultado Y CONDICION ACREEDORA

    //Totales
	oSection2:Cell("SOMAANTDB"):SetBlock( { || ValorCTB(nSomaAntDB,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMAANTCR"):SetBlock( { || ValorCTB(nSomaAntCR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMADEB"  ):SetBlock( { || ValorCTB(nSomaDB,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMACRD"  ):SetBlock( { || ValorCTB(nSomaCR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMAATUDB"):SetBlock( { || ValorCTB(nSomaAtuDB ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMAATUCR"):SetBlock( { || ValorCTB(nSomaAtuCR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )

	oSection2:Cell("SOMASAL31D"):SetBlock( { || ValorCTB(nSSal31DB ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMASAL31C"):SetBlock( { || ValorCTB(nSSal31CR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )

	oSection2:Cell("SOMABALAC"):SetBlock( { || ValorCTB(nSomaBalAc,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMABALPA"):SetBlock( { || ValorCTB(nSomaBalPa,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMAFUCPE"):SetBlock( { || ValorCTB(nSomaFucPe ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
	oSection2:Cell("SOMAFUCGA"):SetBlock( { || ValorCTB(nSomaFucGa,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )

    oSection1:Init()

	cArqTmp->(dbGoTop())

	While cArqTmp->(!Eof())

		If (lImpSint .AND. cArqTmp->NIVEL1) .OR. (!lImpSint .AND. cArqTmp->TIPOCONTA == "2")

			nSomaAntDB	+= cArqTmp->(IIf(SALDOANTDB > SALDOANTCR, SALDOANTDB - SALDOANTCR, 0))
			nSomaAntCR	+= cArqTmp->(IIf(SALDOANTDB < SALDOANTCR, SALDOANTCR - SALDOANTDB, 0))
			nSomaDB 	+= cArqTmp->SALDODEB
			nSomaCR		+= cArqTmp->SALDOCRD
		    nSomaAtuDB	+= cArqTmp->SALDOATUDB
			nSomaAtuCR	+= cArqTmp->SALDOATUCR

			//Saldos al 31
			nSal1:=0;nSal2:=0
			if cArqTmp->NATCTA == '04'//si es cuenta de resultados
					nSal1:=IIF( cArqTmp->SALDODEB-cArqTmp->SALDOCRD >=0 ,  cArqTmp->SALDODEB-cArqTmp->SALDOCRD ,0 )
					nSal2:=IIF( cArqTmp->SALDODEB-cArqTmp->SALDOCRD < 0 , (cArqTmp->SALDODEB-cArqTmp->SALDOCRD)*-1 ,0 )
			else
					nSal1:=IIF( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR >=0 ,  cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR ,0 )
					nSal2:=IIF( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR < 0 , (cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR)*-1 ,0 )
			endif
			nSSal31DB   += nSal1
			nSSal31CR   += nSal2

			//Cuentas de Balance
			nSal1:=IIF( cArqTmp->NATCTA == '01'   .and. cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR >=0 ,   cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR ,0 )
			nSal2:=IIF( cArqTmp->NATCTA $ '02/03' .and. cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR < 0 , ( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR)*-1 ,0 )
			nSomaBalAc += nSal1
	      		nSomaBalPa += nSal2
		 	//Cuentas de resultado
			nSal1:=IIF( cArqTmp->NATCTA == '04' .and. cArqTmp->NORMAL == '1' .and. cArqTmp->SALDODEB-cArqTmp->SALDOCRD >=0 ,  cArqTmp->SALDODEB-cArqTmp->SALDOCRD ,0 )
			nSal2:=IIF( cArqTmp->NATCTA == '04' .and. cArqTmp->NORMAL == '2' .and. cArqTmp->SALDODEB-cArqTmp->SALDOCRD < 0 , ( cArqTmp->SALDODEB-cArqTmp->SALDOCRD)*-1 ,0 )
   			nSomaFucPe += nSal1
			nSomaFucGa += nSal2
		Endif

		oSection1:PrintLine()

		cArqTmp->(dbSkip())

	EndDo

	oSection1:Finish()

	oSection2:Init()
	oReport:SkipLine()

	oSection2:PrintLine()
	oSection2:Finish()
EndIf

If MV_PAR22 == 1    //Si ¿Generar archivo TXT?  Si
	Processa({|| GerArq(AllTrim(MV_PAR23),"cArqTmp")},,STR0032) // "Generando archivo..."
EndIf

dbSelectArea( "cArqTmp" )
Set Filter TO
dbCloseArea()

If Select( "cArqTmp" ) == 0
	FErase( cArqTmp + GetDBExtension())
	FErase( cArqTmp + OrdBagExt())
EndIF

Return .T.


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao     ³ GerArq   ³ Autor ³                     ³ Data ³ 10.05.2016 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao  ³ 3.3, 3.4, 3.5, 3.6, 3.11 LIBRO DE INVENTARIOS Y BALANCES   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³ cDir - Diretorio de criacao do arquivo.                    ³±±
±±³            ³ cArq - Nome do arquivo com extensao do arquivo.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³ Nulo                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso        ³ Fiscal Peru                  - Arquivo Magnetico           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GerArq(cDir,cArqTmp)

Local nHdl  := 0
Local cLin  := ""
Local cSep  := "|"
Local nCont := 0
Local cArq  := ""
Local nMes 	:= Month(MV_PAR02)
Local cDateFmt := SET(_SET_DATEFORMAT)
Local nSal1 := 0
Local nSal2 := 0

FOR nCont:=LEN(ALLTRIM(cDir)) TO 1 STEP -1
	IF SUBSTR(cDir,nCont,1)=='\'
		cDir:=Substr(cDir,1,nCont)
		EXIT
	ENDIF
NEXT

DBSelectArea(cArqTmp)
DBGOTOP()

cArq += "LE"                                  // Fixo  'LE'
cArq +=  AllTrim(SM0->M0_CGC)                 // Ruc
cArq +=  AllTrim(Str(Year(MV_PAR02)))         // Ano
cArq +=  AllTrim(Strzero(Month(MV_PAR02),2))  // Mes
cArq +=  AllTrim(Strzero(Day(MV_PAR02),2))    // Dia
cArq += "031700" 						  // Fixo '031200'
//Código de Oportunidad
If nMes == 12
	cArq += "01"
ElseIf nMes == 1
	cArq += "02"
ElseIf nMes == 6
	cArq += "04"
Else
	cArq += "07"
EndIf
cArq += "1"
cArq += "1"
cArq += "1"
cArq += "1"
cArq += ".TXT" // Extensao

nHdl := fCreate(cDir+cArq)
If nHdl <= 0
	ApMsgStop(STR0034)// "Ocurrió un error al crear el archivo Txt."
Else
	SET(_SET_DATEFORMAT, "DD/MM/YYYY")
	DO WHILE (cArqTmp)->(!Eof())
				cLin := ""
				//01 - Periodo
				cLin += SubStr(DTOS(mv_par02),1,8)
				cLin += cSep

				//02 - Código de la cuenta contable utilizado en el Balance de Comprobación
				cLin += ALLTRIM(CONTA)
				cLin += cSep

				nSal1 := IIf(SALDOANTDB > SALDOANTCR, SALDOANTDB - SALDOANTCR, 0)
				nSal2 := IIf(SALDOANTDB < SALDOANTCR, SALDOANTCR - SALDOANTDB, 0)

				//03 - Saldo Iniciales Debe
				cLin += IIF(ALLTRIM(STR(nSal1)) == "0" , "0.00" , (ALLTRIM(STR(nSal1))))
				cLin += cSep

				//04 - Salds Iniciales Haber
				cLin += IIF(ALLTRIM(STR(nSal2)) == "0" , "0.00" , (ALLTRIM(STR(nSal2))))
				cLin += cSep

				//05 - Movimiento del ejercicio o periodo - Debe
				cLin += IIF(ALLTRIM(STR(SALDODEB)) == "0" , "0.00" , (ALLTRIM(STR(SALDODEB))))
				cLin += cSep

				//06 - Movimiento del ejercicio o periodo - Haber
				cLin += IIF(ALLTRIM(STR(SALDOCRD)) == "0" , "0.00" , (ALLTRIM(STR(SALDOCRD))))
				cLin += cSep

				//07 - Sumas de Mayor - Debe
				cLin += IIF(ALLTRIM(STR(SALDOATUDB)) == "0" , "0.00" , (ALLTRIM(STR(SALDOATUDB))))
				cLin += cSep

				 //08 - Sumas de Mayor - Haber
				cLin += IIF(ALLTRIM(STR(SALDOATUCR)) == "0" , "0.00" , (ALLTRIM(STR(SALDOATUCR))))
				cLin += cSep

				//Saldos al 31
				nSal1:=0;nSal2:=0

				if cArqTmp->NATCTA == '04'//si es cuenta de resultados
					nSal1:=IIF( cArqTmp->SALDODEB-cArqTmp->SALDOCRD >=0 ,  cArqTmp->SALDODEB-cArqTmp->SALDOCRD ,0 )
					nSal2:=IIF( cArqTmp->SALDODEB-cArqTmp->SALDOCRD < 0 , (cArqTmp->SALDODEB-cArqTmp->SALDOCRD)*-1 ,0 )
				else
					nSal1:=IIF( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR >=0 ,  cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR ,0 )
					nSal2:=IIF( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR < 0 , (cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR)*-1 ,0 )
				endif

				//09 - Saldos al 31 de Diciembte - Deudor

				cLin += IIF(ALLTRIM(STR(nSal1)) == "0" , "0.00" , (ALLTRIM(STR(nSal1))))
				cLin += cSep

				 //10 - Saldos al 31 de Diciembre - Acreedor
				cLin += IIF(ALLTRIM(STR(nSal2)) == "0" , "0.00" , (ALLTRIM(STR(nSal2))))
				cLin += cSep

				//11 - Transferencia y Cancelaciones - Debe
				cLin += "0.00"
				cLin += cSep

				//12 - Transferencias y Cancelaciones - Haber
				cLin += "0.00"
				cLin += cSep

				//Cuentas de Balance
				nSal1:=IIF( cArqTmp->NATCTA == '01'   .and. cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR >=0 ,   cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR ,0 )
				nSal2:=IIF( cArqTmp->NATCTA $ '02/03' .and. cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR < 0 , ( cArqTmp->SALDOATUDB-cArqTmp->SALDOATUCR)*-1 ,0 )

				//13 -Cuentas de Balance - Activo
				cLin += IIF(ALLTRIM(STR(nSal1)) == "0" , "0.00" , (ALLTRIM(STR(nSal1))))
				cLin += cSep

				//14 -Cuentas de Balance - Pasivo
				cLin += IIF(ALLTRIM(STR(nSal2)) == "0" , "0.00" , (ALLTRIM(STR(nSal2))))
				cLin += cSep

				//Cuentas de resultado
				nSal1:=IIF( cArqTmp->NATCTA == '04' .and. cArqTmp->NORMAL == '1' .and. cArqTmp->SALDODEB-cArqTmp->SALDOCRD >=0 ,  cArqTmp->SALDODEB-cArqTmp->SALDOCRD ,0 )
				nSal2:=IIF( cArqTmp->NATCTA == '04' .and. cArqTmp->NORMAL == '2' .and. cArqTmp->SALDODEB-cArqTmp->SALDOCRD < 0 , (cArqTmp->SALDODEB-cArqTmp->SALDOCRD)*-1 ,0 )

				//15 - Resultado por Naturaleza - Pérdidas
				cLin += IIF(ALLTRIM(STR(nSal1)) == "0" , "0.00" , (ALLTRIM(STR(nSal1))))
				cLin += cSep

				//16 - Resultado por Naturaleza - Ganancias
				cLin += IIF(ALLTRIM(STR(nSal2)) == "0" , "0.00" , (ALLTRIM(STR(nSal2))))
				cLin += cSep

				//17 - Adiciones
				cLin += "0.00"
				cLin += cSep

				//18 - Deducciones
				cLin += "0.00"
				cLin += cSep

				//19 - Indica el estado de la operación
				cLin += "1"
				cLin += cSep

				cLin += chr(13)+chr(10)
				fWrite(nHdl,cLin)
				dbSelectArea(cArqTmp)
				dbSkip()
		EndDo

		SET(_SET_DATEFORMAT,cDateFmt)
		fClose(nHdl)
		MsgAlert(STR0033)// "Archivo Txt generado con éxito."
EndIf

Return Nil
