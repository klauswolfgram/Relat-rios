/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr045.Ch"
#Include "PROTHEUS.Ch"

#DEFINE 	TAM_VALOR           14

// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณU_Ctbr045()	ณ Autor ณ Cicero J. Silva   	ณ Data ณ 21.07.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Balancete Convertido								 		  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ U_Ctbr045()                               			 		  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno	 ณ Nenhum       											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso 	     ณ Generico     											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum													  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function CTBR045(wnRel)

Local aArea := GetArea()

Local oReport

Local aSetOfBook    
Local aCtbMoeda	  := {}
Local lOk := .T.
Local nDivide	  := 1                 
Local nQuadro

Local lExterno 	:= wnRel <> Nil

PRIVATE aQuadro	:= { "","","","","","","",""}              
PRIVATE cPerg	 	:= "CTR045"
PRIVATE cTipoAnt	:= ""
PRIVATE nomeProg  	:= "CTBR045"
PRIVATE titulo

	
	If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
		lOk := .F. 
	EndIf
	
	For nQuadro :=1 To Len(aQuadro)
		aQuadro[nQuadro] := Space(Len(CriaVar("CT1_CONTA")))
	Next	
	
	CtbCarTxt()
	
	Pergunte("CTR045",.T.) // Precisa ativar as perguntas antes das definicoes.
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
	//ณ Gerencial -> montagem especifica para impressao)				  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !ct040Valid(mv_par06)
		lOk := .F.
	Else
	   aSetOfBook := CTBSetOf(mv_par06)
	Endif

	If lOk
	    If !empty(aSetOfBook[5])
			if !MsgYesNo ( OemToAnsi(STR0034)+ Chr(13) + Chr(10) + OemToAnsi(STR0035)) //'Livro possui visao gerencial amarrada a conversao de valores nao sera realizada.'//Deseja Continuar?
				lOk := .F.
			EndiF
		EndiF
	Endif
	
	If mv_par21 == 2			// Divide por cem
		nDivide := 100
	ElseIf mv_par21 == 3		// Divide por mil
		nDivide := 1000
	ElseIf mv_par21 == 4		// Divide por milhao
		nDivide := 1000000
	EndIf	
	
	If lOk
		aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide)
		If Empty(aCtbMoeda[1])                       
	      Help(" ",1,"NOMOEDA")
	      lOk := .F.
	   Endif
	Endif
	
	If lOk
		oReport := ReportDef(aSetOfBook,aQuadro,aCtbMoeda,nDivide)
		oReport:PrintDialog()
	EndIf

//Limpa os arquivos temporแrios 
CTBGerClean()

RestArea(aArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ ReportDef บ Autor ณ Cicero J. Silva    บ Data ณ  07/07/06  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Definicao do objeto do relatorio personalizavel e das      บฑฑ
ฑฑบ          ณ secoes que serao utilizadas                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณParametrosณ aSetOfBook - Matriz ref. Config. Relatorio                 ณฑฑ
ฑฑบ          ณ aQuadro    - Contas para formar os quadros de resultados   บฑฑ
ฑฑณ          ณ aCtbMoeda  - Matriz ref. a moeda                           ณฑฑ
ฑฑณ          ณ nDivide    - Valor para divisao de valores                 ณฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ReportDef(aSetOfBook,aQuadro,aCtbMoeda,nDivide)

Local oReport
Local oPlcontas

Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aTamCtaRes	:= TAMSX3("CT1_RES")
Local nTamGrupo		:= Len(CriaVar("CT1->CT1_GRUPO"))
Local nTamCta 		:= Len(CriaVar("CT1->CT1_DESC"+mv_par08)) 
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)// Parameter to activate Red Storn

oReport := TReport():New(nomeProg,STR0003,cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,aCtbMoeda,aQuadro,nDivide)},STR0001+STR0002+STR0016)
						        //"Balancete Conversao Moedas"##"Este programa ira imprimir o Balancete Conversao Moedas, a"##"conta eh impressa limitando-se a 20 caracteres e sua descricao 30 caracteres,"##"os valores impressao sao saldo anterior, debito, credito e saldo atual do periodo."

If lRedStorn
	oReport:SetLandScape(.T.)
	oReport:DisableOrientation()
Endif

// Sessao 1
oPlcontas := TRSection():New(oReport,STR0029,{"cArqTmp","CT1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/) // "Periodos"
oPlcontas:SetTotalInLine(.F.)
oPlcontas:SetHeaderPage()

TRCell():New(oPlcontas,"CONTA"		,"cArqTmp",STR0022,/*Picture*/,aTamConta[1]	,/*lPixel*/,/*bCodeBlock*/)// "C O D I G O   D A   C O N T A"
TRCell():New(oPlcontas,"CTARES"		,"cArqTmp",STR0022,/*Picture*/,aTamCtaRes[1],/*lPixel*/,/*bCodeBlock*/)// "C O D I G O   D A   C O N T A"
TRCell():New(oPlcontas,"DESCCTA"	,"cArqTmp",STR0023,/*Picture*/,nTamCta  ,/*lPixel*/,/*bCodeBlock*/)// "D E S C R I C A O  D A  C O N T A"
TRCell():New(oPlcontas,"SALDOANT"	,"cArqTmp",STR0024,/*Picture*/,TAM_VALOR+2,/*lPixel*/,/*bCodeBlock*/,/*"RIGHT"*/,,"CENTER")// "SALDO ANTERIOR"
TRCell():New(oPlcontas,"SALDODEB"	,"cArqTmp",STR0025,/*Picture*/,TAM_VALOR,/*lPixel*/,/*bCodeBlock*/,/*"RIGHT"*/,,"CENTER")// "DEBITO"
TRCell():New(oPlcontas,"SALDOCRD"	,"cArqTmp",STR0026,/*Picture*/,TAM_VALOR,/*lPixel*/,/*bCodeBlock*/,/*"RIGHT"*/,,"CENTER")// "CREDITO"
TRCell():New(oPlcontas,"MOVIMENTO"	,"cArqTmp",STR0027,/*Picture*/,TAM_VALOR+2,/*lPixel*/,/*bCodeBlock*/,/*"RIGHT"*/,,"CENTER")// "MOVIMENTO PERIODO"
TRCell():New(oPlcontas,"SALDOATU"	,"cArqTmp",STR0028,/*Picture*/,TAM_VALOR+2,/*lPixel*/,/*bCodeBlock*/,/*"RIGHT"*/,,"CENTER")// "SALDO ATUAL"

oPlcontas:OnPrintLine( {|| ( IIf( (mv_par18 == 1) .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),; // mv_par18	-	Salta linha sintetica ?
								 cTipoAnt := cArqTmp->TIPOCONTA	)  })

TRPosition():New(oPlcontas,"CT1",1,{|| xFilial("CT1")+cArqTmp->CONTA })

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
Static Function ReportPrint(oReport,aSetOfBook,aCtbMoeda,aQuadro,nDivide)

Local oPlcontas		:= oReport:Section(1)

Local cArqTmp		:= ""
Local cPicture		:= aSetOfBook[4]
Local cSeparador	:= ""
Local cMascara		:= IIf( Empty(aSetOfBook[2]),GetMv("MV_MASCARA"),RetMasCtb(aSetOfBook[2],@cSeparador))                             
Local lImpSint		:= Iif(mv_par05==1 .Or. mv_par05 ==3,.T.,.F.)// Imprime Contas: Sintet/Analit/Ambas
Local lNormal		:= Iif(mv_par20==1,.T.,.F.)	// Imprimir Codigo? Normal / Reduzido
Local lImpAntLP		:= Iif(mv_par23 == 1,.T.,.F.)	// Posicao Ant. L/P? Sim / Nao
Local dDataLP		:= mv_par24						// Data Lucros/Perdas?
Local lVlrZerado	:= Iif(mv_par07==1,.T.,.F.)	// Saldos Zerados?
Local cMoedConv		:= mv_par09						// Moeda Destino?
Local cConsCrit		:= Str(mv_par26,1)				// Considera Criterio?Plano de Contas/Medio/Mensal/Informada
Local dDataConv		:= mv_par27						// Data de Conversao 
Local nTaxaConv		:= mv_par28						// Taxa de Conversao
Local lPrintZero	:= Iif(mv_par19==1,.T.,.F.)	// Imprime valor 0.00    ?
Local dDataFim	 	:= mv_par02							// Data Final
Local nDigitAte		:= 0
Local cDescMoeda 	:= Alltrim(aCtbMoeda[2])
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)
Local cSegAte   	:= mv_par22						// Imprimir Ate o segmento?
Local lmov			:= Iif(mv_par17==1,.T.,.F.)	// Imprime Coluna Mov ?

// verificar necessidade
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotMov		:= 0
Local nGrpDeb		:= 0
Local nGrpCrd		:= 0                     
Local cGrupoAnt		:= ""
Local cFiltro		:= oPlcontas:GetAdvplExp()
Local lColDbCr 		:= If(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= If(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.)// Parameter to activate Red Storn
Local nGrpSalRS		:= 0
Local nTotSalRS		:= 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Carrega titulo do relatorio: Analitico / Sintetico			  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
IF mv_par05 == 1      
	titulo := STR0009  //"BALANCETE CONVERSAO MOEDAS SINTETICO DE "
ElseIf mv_par05 == 2
	titulo := STR0006  //"BALANCETE CONVERSAO MOEDAS SINTETICO DE "
ElseIf mv_par05 == 3
	titulo := STR0017  //"BALANCETE CONVERSAO MOEDAS DE "
EndIf
titulo += 	DTOC(mv_par01) + OemToAnsi(STR0007) + Dtoc(mv_par02) + ;
			OemToAnsi(STR0008) + cDescMoeda + CtbTitSaldo(mv_par11)
			
If nDivide > 1			
	titulo += " (" + OemToAnsi(STR0021) + Alltrim(Str(nDivide)) + ")"
EndIf	

If lNormal
	oPlcontas:Cell("CTARES"):Disable()
Else
	oPlcontas:Cell("CONTA" ):Disable()
EndIf

If !lMov
	oPlcontas:Cell("MOVIMENTO"):Disable()
	oReport:SetPortrait(.T.)
Else
	oReport:SetLandScape(.T.)
EndIf

oPlcontas:Cell("CONTA"):SetBlock( { || Iif(cArqTmp->TIPOCONTA=="2","  ","")+EntidadeCTB(cArqTmp->CONTA ,0,0,70,.F.,cMascara,cSeparador,,,,,.F.) } )

If mv_par12 == 2 
	oBreak:= TRBreak():New( oPlcontas, {|| Substr(cArqTmp->CONTA,1,1) } )
	oBreak:SetPageBreak(.T.)
EndIf

oPlcontas:Cell("CTARES"):SetBlock( { || Iif(cArqTmp->TIPOCONTA=="2","  ","")+EntidadeCTB(cArqTmp->CTARES,0,0,70,.F.,cMascara,cSeparador,,,,,.F.) } )

oPlcontas:Cell("SALDOANT" ):SetBlock( { || ValorCTB(cArqTmp->SALDOANT ,,,TAM_VALOR,2,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) })
oPlcontas:Cell("SALDODEB" ):SetBlock( { || ValorCTB(cArqTmp->SALDODEB ,,,TAM_VALOR,2,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F., lColDbCr) })
oPlcontas:Cell("SALDOCRD" ):SetBlock( { || ValorCTB(cArqTmp->SALDOCRD ,,,TAM_VALOR,2,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F., lColDbCr) })
oPlcontas:Cell("MOVIMENTO"):SetBlock( { || ValorCTB(cArqTmp->MOVIMENTO,,,TAM_VALOR,2,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) })
oPlcontas:Cell("SALDOATU" ):SetBlock( { || ValorCTB(cArqTmp->SALDOATU ,,,TAM_VALOR,2,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) })

oReport:SetCustomText( { || CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )

oReport:SetPageNumber(mv_par10)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao					     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			 CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			  mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
			   mv_par11,aSetOfBook,mv_par13,mv_par14,mv_par14,mv_par16,;
			    .F.,.F.,mv_par12,,lImpAntLP,dDataLP,nDivide,lVlrZerado,,,,,,,.T.,cMoedConv,;
				 cConsCrit,dDataConv,nTaxaConv,,,lImpSint,cFiltro)},;
				  OemToAnsi(OemToAnsi(STR0015)),;  //"Criando Arquivo Tempor rio..."
				   OemToAnsi(STR0003))  				//"Balancete Verificacao"

oReport:NoUserFilter()

dbSelectArea("cArqTmp")	
dbSetOrder(1)
dbGoTop()
oReport:SetMeter( RecCount() )

//******************************
// Totalizadores do relatorio  *
//******************************

If mv_par12 == 1 // mv_par11 - Quebra por Grupo Contabil? 
	// Totais por grupo
	oBrkGrp 	:= TRBreak():New( oPlcontas, { || cArqTmp->GRUPO	}, "" , )
	oBrkGrp:OnBreak( {|cGrupo| oBrkGrp:SetTitle(OemToAnsi(STR0020) + cGrupo + " )") } )

	oTotGrpDe 	:= TRFunction():New( oPlcontas:Cell("SALDODEB")	, ,"ONPRINT", oBrkGrp,/*Titulo*/,cPicture,;
	{|| ValorCTB(nGrpDeb,,,TAM_VALOR,2,.F.,cPicture,"1",,,,,,lPrintZero,.F., lColDbCr) },.F.,.F.,.F.,oPlcontas)

	oTotGrpCr	:= TRFunction():New( oPlcontas:Cell("SALDOCRD")	, ,"ONPRINT", oBrkGrp,/*Titulo*/,cPicture,;
	{ || ValorCTB(nGrpCrd,,,TAM_VALOR,2,.F.,cPicture,"2",,,,,,lPrintZero,.F., lColDbCr) },.F.,.F.,.F.,oPlcontas)

	if lMov
		If lRedStorn
			oTotGrpCr	:= TRFunction():New( oPlcontas:Cell("MOVIMENTO")	, ,"ONPRINT", oBrkGrp,/*Titulo*/,cPicture,;
			{ || ValorCTB(nGrpSalRS,,,TAM_VALOR,2,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oPlcontas)
		Else
			oTotGrpCr	:= TRFunction():New( oPlcontas:Cell("MOVIMENTO")	, ,"ONPRINT", oBrkGrp,/*Titulo*/,cPicture,;
			{ || ValorCTB(nGrpCrd - nGrpDeb,,,TAM_VALOR,2,.F.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oPlcontas)
		Endif
	EndIf

Endif

oBrkEnd 	:= TRBreak():New( oPlcontas, { || cArqTmp->(Eof())	}, OemToAnsi(STR0011), )//"T O T A I S  D O  M E S : "

oTotDeb 	:= TRFunction():New( oPlcontas:Cell("SALDODEB")	, ,"ONPRINT", oBrkEnd,/*Titulo*/,cPicture,;
{ || ValorCTB(nTotDeb,,,TAM_VALOR,2,.F.,cPicture,"1",,,,,,lPrintZero,.F., lColDbCr) },.F.,.F.,.F.,oPlcontas)

oTotCred	:= TRFunction():New( oPlcontas:Cell("SALDOCRD")	, ,"ONPRINT", oBrkEnd,/*Titulo*/,cPicture,;
{ || ValorCTB(nTotCrd,,,TAM_VALOR,2,.F.,cPicture,"2",,,,,,lPrintZero,.F., lColDbCr) },.F.,.F.,.F.,oPlcontas)

	if lMov
		If lRedStorn
			oTotGrpMv	:= TRFunction():New( oPlcontas:Cell("MOVIMENTO")	, ,"ONPRINT", oBrkEnd,/*Titulo*/,cPicture,;
			{ || ValorCTB(nTotSalRS,,,TAM_VALOR,2,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oPlcontas)
		Else
			oTotGrpMv	:= TRFunction():New( oPlcontas:Cell("MOVIMENTO")	, ,"ONPRINT", oBrkEnd,/*Titulo*/,cPicture,;
			{ || ValorCTB(nTotCrd - nTotDeb,,,TAM_VALOR,2,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oPlcontas)
		Endif
	EndIf

//*********************************
// Fim Totalizadores do relatorio *
//*********************************

oPlcontas:Init()

Do While !Eof() .And. !oReport:Cancel()

	oReport:IncMeter()

    If oReport:Cancel()
    	Exit
    EndIf       
    
	If R45Fil(cSegAte, nDigitAte,cMascara)
		dbSkip()
		Loop
	EndIf     
	
	oPlcontas:PrintLine() //Section(1)
	
	nTotDeb += R45Soma("D",cSegAte)
	nGrpDeb += R45Soma("D",cSegAte)
	nTotCrd += R45Soma("C",cSegAte)
	nGrpCrd += R45Soma("C",cSegAte)

    dbSkip()

EndDo

If cPaisLoc $ "RUS"
	nGrpSalRS := RedStorTt(nGrpDeb,nGrpCrd,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
	nTotSalRS := RedStorTt(nTotDeb,nTotCrd,cArqTmp->TIPOCONTA,cArqTmp->NORMAL,"T")
Endif

oPlContas:Finish()

oReport:SkipLine()
	
If mv_par25 ==1
	oReport:Section(1):SetHeaderSection(.F.)
	ImpQuadro(0,X3USO("CT2_DCD"),dDataFim,mv_par08,aQuadro,cDescMoeda,oReport:ClassName(),(If (lImpAntLP,dDataLP,cTod(""))),cPicture,nDecimais,lPrintZero,mv_par11,oReport)
EndIf	

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea() 
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF	
dbselectArea("CT2")

Return                                                                          

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณR45Soma   บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR045                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function R45Soma(cTipo,cSegAte)

Local nRetValor := 0

If mv_par05 == 1	// So imprime Sinteticas - Soma Sinteticas
	If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1            
		If cTipo == "D"
			nRetValor := cArqTmp->SALDODEB                             	
		ElseIf cTipo == "C"
			nRetValor := cArqTmp->SALDOCRD
		EndIf
	EndIf
Else	// Soma Analiticas
	If Empty(cSegAte)	//Se nao tiver filtragem ate o nivel
		If cArqTmp->TIPOCONTA == "2"
			If cTipo == "D"
				nRetValor := cArqTmp->SALDODEB
			ElseIf cTipo == "C"
				nRetValor := cArqTmp->SALDOCRD
			EndIf
		EndIf
	Else							//Se tiver filtragem, somo somente as sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณR45Fil    บAutor  ณCicero J. Silva     บ Data ณ  24/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR045                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function R45Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa := .F.

If mv_par05 == 1					// So imprime Sinteticas
	If cArqTmp->TIPOCONTA == "2"
		lDeixa := .T.
	EndIf
ElseIf mv_par05 == 2				// So imprime Analiticas
	If cArqTmp->TIPOCONTA == "1"
		lDeixa := .T.
	EndIf
EndIf

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara) 	
EndIf		
	
//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
If !Empty(cSegAte)
	If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
		lDeixa := .T.
	Endif
EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)