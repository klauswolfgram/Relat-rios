/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "ctbr044.ch"        
#INCLUDE "report.ch"   
#INCLUDE "protheus.ch"   

// 17/08/2009 -- Filial com mais de 2 caracteres

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณctbr044   บAutor  ณRenato F. Campos    บ Data ณ  18/05/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Balancete de Escritura็ใo                                  บฑฑ
ฑฑบ          ณ Impresso somente em modo Grafico (R4) e Paisagem           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ sigactb                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ctbr044()
Private titulo		:= ""             
Private nomeprog	:= "CTBR044"
Private oReport		:= Nil 
Private aSelFil		:= {}
                                                                                     
Pergunte( "CTR044" , .T. ) // efetuo o pergunte antes para a defini็ใo do modelo a ser impresso 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Transforma parametros Range em expressao (intervalo) ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MakeSqlExpr( "CTR044" )	  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Inicializa a montagem do relatorio                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := ReportDef()

If Valtype( oReport ) == 'O'

	If ! Empty( oReport:uParam )
		Pergunte( oReport:uParam, .F. )
	EndIf	
	
	oReport:PrintDialog()      
Endif
	
oReport := Nil

//Limpa os arquivos temporแrios 
CTBGerClean()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณRenato F. Campos    บ Data ณ  18/05/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Balancete de Escritura็ใo                                  บฑฑ
ฑฑบ          ณ Impresso somente em modo Grafico (R4) e Paisagem           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ sigactb                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
 
Static Function ReportDef()
Local aGetArea	   	:= GetArea()   
Local cReport		:= "CTBR044"
Local cDesc			:= OemToAnsi(STR0001) + OemToAnsi(STR0002) + OemToAnsi(STR0003)
Local cPerg	   		:= "CTR044" 
Local cPictVal 		:= PesqPict("CT2","CT2_VALOR")
Local nDecimais
Local cMascara		:= ""
Local cSeparador	:= ""
Local aSetOfBook    
Local lImprime		:= .T.
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local nTamVal		:= Iif(cPaisLoc $ "RUS",aTamVal[1],17)

cTitulo	:= STR0003

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Efetua a pergunta antes de montar a configura็ใo do      ณ
//ณ relatorio, afim de poder definir o layout a ser impresso ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte( "CTR044" , .F. )   

If mv_par20 == 1 .And. Len( aSelFil ) <= 0  .And. !IsBlind()
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		Return
	EndIf 
EndIf
      
makesqlexpr("CTR044")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
//ณ Gerencial -> montagem especifica para impressao)	    	 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If ! Ct040Valid( mv_par06 )
	Return .F.
Else
   aSetOfBook := CTBSetOf( mv_par06 )
Endif
                                                                          
cMascara := RetMasCtb( aSetOfBook[2], @cSeparador )

cPicture := aSetOfBook[4]

oReport	 := TReport():New( cReport,Capital( cTitulo ),cPerg, { |oReport| Pergunte(cPerg , .F. ), If(! ReportPrint( oReport ), oReport:CancelPrint(), .T. ) }, cDesc )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Apos a definicao do relatorio, nao sera possivel alterar |
//| os parametros.                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport:ParamReadOnly()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Relatorio impresso somente em modo paisagem              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport:SetLandScape(.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Montagem da estrutura do relatorio                       |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection1  := TRSection():New( oReport, STR0004, { "cArqTmp" , "CT1" } ,, .F., .F. ) //"Plano de contas"

TRCell():New( oSection1, "CONTA"      ,,STR0007							 /*Titulo*/	,/*Picture*/, 20/*Tamanho*/, /*lPixel*/, /*CodeBlock*/)
TRCell():New( oSection1, "DESCCTA"    ,,STR0008							 /*Titulo*/	,/*Picture*/, 40/*Tamanho*/, /*lPixel*/, /*CodeBlock*/)
TRCell():New( oSection1, "SALDOANTDB" ,,STR0010+Chr(13)+Chr(10)+STR0013/*Titulo*/	,/*Picture*/, nTamVal/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection1, "SALDOANTCR" ,,STR0010+Chr(13)+Chr(10)+STR0014/*Titulo*/	,/*Picture*/, nTamVal/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection1, "SALDODEB"   ,,STR0009+Chr(13)+Chr(10)+STR0013/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection1, "SALDOCRD"   ,,STR0009+Chr(13)+Chr(10)+STR0014/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection1, "MOVIMENTOD" ,,STR0012+Chr(13)+Chr(10)+STR0013/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection1, "MOVIMENTOC" ,,STR0012+Chr(13)+Chr(10)+STR0014/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")

oSection2  := TRSection():New( oReport, STR0021, { "" } ,, .F., .F. ) //

TRCell():New( oSection2, "TOTAL"      ,,/*Titulo*/	,/*Picture*/, 61/*Tamanho*/, /*lPixel*/, {|| STR0022}/*CodeBlock*/)
TRCell():New( oSection2, "SOMAANTDB" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection2, "SOMAANTCR" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection2, "SOMADEB"   ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection2, "SOMACRD"   ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection2, "SOMAMOVDB" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
TRCell():New( oSection2, "SOMAMOVCR" ,,/*Titulo*/	,/*Picture*/, 17/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, /*"RIGHT"*/,,"CENTER")
oSection2:SetHeaderSection(.F.)

TRPosition():New( oSection1, "CT1", 1, {|| xFilial( "CT1" ) + cArqTMP->CONTA })  

If mv_par21 == 2

	oSection1:SetHeaderSection(.F.)

	oSection1:Cell("CONTA"):Hide()
	oSection1:Cell("DESCCTA"):Hide()
	oSection1:Cell("SALDOANTDB"):Hide()
	oSection1:Cell("SALDOANTCR"):Hide()
	oSection1:Cell("SALDODEB"):Hide()
	oSection1:Cell("SALDOCRD"):Hide()
	oSection1:Cell("MOVIMENTOD"):Hide()
	oSection1:Cell("MOVIMENTOC"):Hide()
	oSection2:Cell("TOTAL"):Hide()
	oSection2:Cell("SOMAANTDB"):Hide()
	oSection2:Cell("SOMAANTCR"):Hide()
	oSection2:Cell("SOMADEB"):Hide()
	oSection2:Cell("SOMACRD"):Hide()
	oSection2:Cell("SOMAMOVDB"):Hide()
	oSection2:Cell("SOMAMOVCR"):Hide()

	oReport:OnPageBreak( { || oReport:SkipLine(8)}) 
	
	lImprime := .F.   

Elseif mv_par21 == 3
         
	oReport:HideHeader() 
	oReport:OnPageBreak( { || oReport:SkipLine(6)})   
	 
Endif     

	 
Return( oReport )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |ReportPrintบAutor  ณRenato F. Campos   บ Data ณ  18/05/08   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Efetua a impressao do relatorio							  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SigaCTB                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportPrint( oReport )
Local oSection1 	:= oReport:Section(1) 
Local oSection2 	:= oReport:Section(2) 
Local aSetOfBook
Local dDataFim 		:= mv_par02
Local lRet			:= .T.
Local lPrintZero	:= (mv_par13==1)
Local lPula			:= (mv_par12==1) 
Local lNormal		:= .T.
Local lVlrZerado	:= (mv_par07==1)
Local lQbGrupo		:= (mv_par10==1) 
Local lQbConta		:= (mv_par10==2)
Local nDecimais
Local nDivide		:= 1
Local lImpAntLP		:= (mv_par15 == 1)
Local dDataLP		:= mv_par16
Local lImpSint		:= Iif(mv_par05=1 .Or. mv_par05 ==3,.T.,.F.)
Local lRecDesp0		:= (mv_par17 == 1)
Local cRecDesp		:= mv_par18
Local dDtZeraRD		:= mv_par19
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
Local cRngFil	 // range de filiais para a impressใo do relatorio
Local dDtCorte	 	:= CTOD("  /  /  ") //mv_par01 //If ( cPaisLoc == "PTG" , mv_par03 , CTOD("  /  /  ") ) // data de corte - usado em Portugal
Local nSomaAntDB	:= 0
Local nSomaAntCR	:= 0
Local nSomaDB		:= 0
Local nSomaCR		:= 0
Local nSomaMovDB	:= 0
Local nSomaMovCR	:= 0
Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
//ณ Gerencial -> montagem especifica para impressao)             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If ! ct040Valid( mv_par06 )
	Return .F.
Else
   aSetOfBook := CTBSetOf(mv_par06)
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Valida็ใo das moedas do CTB                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aCtbMoeda := CtbMoeda( mv_par08 , nDivide )

If Empty(aCtbMoeda[1])                       
	Help(" ",1,"NOMOEDA")
	Return .F.
Endif

If cPaisLoc == 'RUS'
	cDescMoeda 	:= Alltrim(aCtbMoeda[3])
Else
	cDescMoeda 	:= Alltrim(aCtbMoeda[2])
EndIf
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)

If Empty( aSetOfBook[2] )
	cMascara := GetMv( "MV_MASCARA" )
Else
	cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf
cPicture 		:= aSetOfBook[4]

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Seta o numero da pagina                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport:SetPageNumber( mv_par11 )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTitulo do Relatorio                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Titulo += 	AllTrim(STR0003) + ", " + AllTrim(STR0005) + " " + DTOC(MV_PAR01) + " " + ;	// "DE"
			AllTrim(STR0006) + " " + DTOC(MV_PAR02) + ", " + CtbTitSaldo(mv_par09) + AllTrim(STR0023) + " " + cDescMoeda// "ATE"

oReport:SetTitle(Titulo) 

oReport:SetCustomText( {|| CtCGCCabTR(,,,,,MV_PAR02,oReport:Title(),,,,,oReport) } )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Filtro de usuario                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cFilUser := oSection1:GetAdvplExpr( "CT1" )

If Empty(cFilUser)
	cFilUser := ".T."
EndIf	

MakeSqlExpr( "CTR044" )	  
cRngFil		:= mv_par20

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao			  		     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(	oMeter, oText, oDlg, @lEnd,@cArqTmp,mv_par01,mv_par02,"CT7","",mv_par03,;
						mv_par04,,,,,,,mv_par08,mv_par09,aSetOfBook,,,,,;
						.F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,,,,,,,,lImpSint,cFilUser,lRecDesp0,;
						cRecDesp,dDtZeraRD,,,,,,,,,aSelFil/*cRngFil*/,/*dDtCorte*/)},;
						OemToAnsi(OemToAnsi(STR0020)),;//"Criando Arquivo Tempor rio..."
						OemToAnsi(STR0004))  			//"Balancete de Escritura็ใo"
                
nCount := cArqTmp->( RecCount() )

oReport:SetMeter( nCont )

lRet := !( nCount == 0 .And. !Empty(aSetOfBook[5]))

If lRet
	cArqTmp->(dbGoTop())
	
	// define se ao imprimir uma linha a proxima ้ pulada
   	oSection1:OnPrintLine( {|| U_CTR044OnPrint( lPula, lQbConta ) } )
	
	If lNormal
		oSection1:Cell("CONTA"):SetBlock( {|| EntidadeCTB(cArqTmp->CONTA,000,000,030,.F.,cMascara,cSeparador,,,.F.,,.F.)} )
	Else
		oSection1:Cell("CONTA"):SetBlock( {|| cArqTmp->CTARES } )
	EndIf	
	
	oSection1:Cell("DESCCTA"):SetBlock( { || cArqTMp->DESCCTA } )
	
	If lRedStorn
		oSection1:Cell("SALDOANTDB"):SetBlock( { || ValorCTB(Iif(cArqTmp->NORMAL="1",cArqTmp->SALDOANT,0),,,aTamVal[1],nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,/*lColDbCr*/) } )
		oSection1:Cell("SALDOANTCR"):SetBlock( { || ValorCTB(Iif(cArqTmp->NORMAL="1",0,cArqTmp->SALDOANT),,,aTamVal[1],nDecimais,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,/*lColDbCr*/) } )
	Else	
		oSection1:Cell("SALDOANTDB"):SetBlock( { || ValorCTB(cArqTmp->SALDOANTDB,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
		oSection1:Cell("SALDOANTCR"):SetBlock( { || ValorCTB(cArqTmp->SALDOANTCR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
	Endif
	oSection1:Cell("SALDODEB"  ):SetBlock( { || ValorCTB(cArqTmp->SALDODEB  ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
	oSection1:Cell("SALDOCRD"  ):SetBlock( { || ValorCTB(cArqTmp->SALDOCRD  ,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
	If lRedStorn
		oSection1:Cell("MOVIMENTOD"):SetBlock( { || ValorCTB(IIF( cArqTmp->NORMAL="1" , RedStorTt(cArqTmp->SALDOATUDB,cArqTmp->SALDOATUCR,,cArqTmp->NORMAL,"D"), 0 ),,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
		oSection1:Cell("MOVIMENTOC"):SetBlock( { || ValorCTB(IIF( cArqTmp->NORMAL="2" , RedStorTt(cArqTmp->SALDOATUDB,cArqTmp->SALDOATUCR,,cArqTmp->NORMAL,"D"), 0 ),,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
	Else
		oSection1:Cell("MOVIMENTOD"):SetBlock( { || ValorCTB(IIF( (cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR) > 0 , cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR,0 ) ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
		oSection1:Cell("MOVIMENTOC"):SetBlock( { || ValorCTB(IIF( (cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR) < 0 , cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR,0 ),,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
	Endif
	oSection2:Cell("SOMAANTDB"):SetBlock( { || ValorCTB(nSomaAntDB,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
	oSection2:Cell("SOMAANTCR"):SetBlock( { || ValorCTB(nSomaAntCR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
	oSection2:Cell("SOMADEB"  ):SetBlock( { || ValorCTB(nSomaDB,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
	oSection2:Cell("SOMACRD"  ):SetBlock( { || ValorCTB(nSomaCR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
	oSection2:Cell("SOMAMOVDB"):SetBlock( { || ValorCTB(nSomaMovDB ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
	oSection2:Cell("SOMAMOVCR"):SetBlock( { || ValorCTB(nSomaMovCR,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )

	oSection1:Init()
                            
	cArqTmp->(dbGoTop()) 
	
	While cArqTmp->(!Eof())
	
		If (lImpSint .AND. cArqTmp->NIVEL1) .OR. (!lImpSint .AND. cArqTmp->TIPOCONTA == "2")
			nSomaAntDB	+= cArqTmp->SALDOANTDB
			nSomaAntCR	+= cArqTmp->SALDOANTCR
			nSomaDB 	+= cArqTmp->SALDODEB
			nSomaCR		+= cArqTmp->SALDOCRD 
		
			If lRedStorn
				If cArqTmp->NORMAL="1"
					nSomaMovDB += RedStorTt(cArqTmp->SALDOATUDB,cArqTmp->SALDOATUCR,,cArqTmp->NORMAL,"D")
				Endif
				
				If cArqTmp->NORMAL="2"
					nSomaMovCR += RedStorTt(cArqTmp->SALDOATUDB,cArqTmp->SALDOATUCR,,cArqTmp->NORMAL,"D")
				Endif	
			Else
				If (cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR) > 0 
					nSomaMovDB += (cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR)
				Endif
			
				If (cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR) < 0 
					nSomaMovCR += (cArqTmp->SALDOATUDB - cArqTmp->SALDOATUCR)
				Endif
			Endif
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

dbSelectArea( "cArqTmp" )
Set Filter TO
dbCloseArea()

If Select( "cArqTmp" ) == 0
	FErase( cArqTmp + GetDBExtension())
	FErase( cArqTmp + OrdBagExt())
EndIF	

Return .T. 

User Function CTR044OnPrint( lPula, lQbConta)
                                                                        
Local lRet := .T.           

// Verifica salto de linha para conta sintetica
If lPula 
	oReport:SkipLine()
EndIf	

// Verifica quebra de pagina por conta
If lQbConta .And. cArqTmp->NIVEL1
	oReport:EndPage()
	nLinReport := 9
	Return
EndIf	

If mv_par05 == 1		// Apenas sinteticas
	lRet := (cArqTmp->TIPOCONTA == "1")
ElseIf mv_par05 == 2	// Apenas analiticas
	lRet := (cArqTmp->TIPOCONTA == "2")
EndIf

Return lRet 
