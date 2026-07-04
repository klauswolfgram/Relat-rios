/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr051.Ch"
#Include "PROTHEUS.Ch"

Static lCtbIsCube := FindFunction("CtbIsCube")
Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema
Static lAutomato  := IsBlind()
//amarracao

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr051	³ Autor ³ TOTVS             	³ Data ³ 09/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico localizado.       			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr051()                              			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr051()
PRIVATE titulo		:= ""
Private nomeprog	:= "CTBR051"
Private oReport		:= Nil
Private cPlano		:= "01" // Usado pela consulta padrao CV01
Private cCodigo		:= ""   // Usado pela consulta padrao CV01

U_CTBR051R4()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR048R4 ³ Autor³ Daniel Sakavicius		³ Data ³ 01/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico Sintetico Modelo 1 - R4                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR048R4												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR051R4()
//Cria matriz para armazenar os parametros do filtro por entidades

Private nQtdEntid	:= CtbQtdEntd() //sao 4 entidades padroes -> conta /centro custo /item contabil/ classe de valor
Private aEntidades 	:= {}	//Array( nQtdEntid * 2)  
Private aEstrCT0	:= {}            
Private aParCubo	:= {}            
Private cArqObjeto	:= ""
Private aSelFil  	:= {} 

If !lCtbIsCube .And. !CtbIsCube()
	Return()
EndIf

DbSelectArea('CT0') 
DbSetOrder(1)
If DbSeek( xFilial('CT0') ) 
	While CT0->(!Eof()) .AND. xFilial('CT0') == CT0->CT0_FILIAL 
		If ! Empty(CT0->CT0_CPOCHV)
			AADD( aEstrCT0,{ CT0->CT0_ID,TamSx3(CT0->CT0_CPOCHV)[1],CT0->CT0_DSCRES,CT0->CT0_F3ENTI } )	
			AADD( aEntidades , Space(TamSx3(CT0->CT0_CPOCHV)[1]) )		// Parametro entidade inicio		 
			AADD( aEntidades , Space(TamSx3(CT0->CT0_CPOCHV)[1]) )		// Parametro entidade fim			
		EndIf
		CT0->(DbSkip())   
	EndDo
EndIf           

CtbParCubo(.t.)

oReport := ReportDef()

If Valtype( oReport ) == 'O'
	If ! Empty( oReport:uParam )
		//Pergunte( oReport:uParam, .F. )
	EndIf	
	
	oReport:PrintDialog()   
Endif
	
oReport := Nil

Return                                

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Daniel Sakavicius		³ Data ³ 28/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo relatorio.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
local aArea	   		:= GetArea()   
Local CREPORT		:= "CTBR051"
Local CTITULO		:= STR0006				   			// "Emissao do Relat. Conf. Dig. "
Local CDESC			:= OemToAnsi(STR0001)+OemToAnsi(STR0002)+OemToAnsi(STR0003)			// "Este programa ira imprimir o Relatorio para Conferencia"
Local CCOLBAR		:= "|"                   
Local aTamConta		:= TAMSX3("CT1_CONTA")    

Local aTamVal		:= {18,2}
Local aTamDesc		:= TAMSX3("CT1_CONTA")
Local cPictVal 		:= PesqPict("CT2","CT2_VALOR")
Local nDecimais
Local cMascara		:= ""
Local cSeparador	:= ""
Local nTamConta		:= TAMSX3("CT1_CONTA")[1]
Local nTamEC05		:= TAMSX3("CV0_CODIGO")[1]
Local aSetOfBook
Local nMaskFator 	:= 1
Local aParam		:= {}
Local cPerg	   		:= "CTR051" 
Local aPergunte     := {}
Local lSelFilial      := .F.

Local nQtdeEntid	:= Len(aEstrCT0)
Local lEntidade1	
Local lEntidade2	
Local lEntidade3	
Local lEntidade4	
Local lEntidade5	
Local lEntidade6	
Local lEntidade7	
Local lEntidade8	
Local lEntidade9	

If !Pergunte(cPerg,.T.)
	Return
EndIf

If cPaisLoc $ "COL|PER" 
	aSelFil := {cFilAnt}
	aPergunte := Ctr051Pg("CTR051")
	lSelFilial := Len( aPergunte[2] ) > 13 .And. AllTrim( aPergunte[2][14]:CX1_VAR01 ) == "mv_par14"
	If  lSelFilial .And. mv_par14 == 1 
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Help( " " , 1 , "MINSELFIL" ,, STR0058 + STR0059,3,0)  //"Seleção de filial inválido." ### "Favor selecionar no mínimo de uma filial."
			Return
		EndIf
	EndIf
Else
	aPergunte := Ctr051Pg("CTR051")
	lSelFilial := Len( aPergunte[2] ) > 10 .And. AllTrim( aPergunte[2][11]:CX1_VAR01 ) == "mv_par14"
	If  lSelFilial .And. mv_par11 == 1 
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Help( " " , 1 , "MINSELFIL" ,, STR0058 + STR0059,3,0)  //"Seleção de filial inválido." ### "Favor selecionar no mínimo de uma filial."
			Return
		EndIf
	Else
		aSelFil := {cFilAnt}
	EndIf
EndIf

If Val(Mv_par10) > nQtdeEntid .or. Empty(Alltrim(Mv_par10))
	Help( " " , 1 , "nQtdeEntid" ,, STR0057 + " :" + Mv_par10 ,3,0)//"Entidade não parametrizado"
	Return
EndIf 

lEntidade1	:= Val(Mv_par10) >=1 
lEntidade2	:= Val(Mv_par10) >=2
lEntidade3	:= Val(Mv_par10) >=3
lEntidade4	:= Val(Mv_par10) >=4
lEntidade5	:= Val(Mv_par10) >=5
lEntidade6	:= Val(Mv_par10) >=6
lEntidade7	:= Val(Mv_par10) >=7
lEntidade8	:= Val(Mv_par10) >=8
lEntidade9	:= Val(Mv_par10) ==9

aParCubo := CtbCfCubo(Mv_par10)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)	    	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSetOfBook := CTBSetOf( "" )
cMascara := RetMasCtb( aSetOfBook[2], @cSeparador )

If ! Empty( cMascara )
	nTamConta := aTamConta[1] + ( Len( Alltrim( cMascara ) ) / 2 )
Else
	nTamConta := aTamConta[1]
EndIf

cPicture := aSetOfBook[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//"Este programa tem o objetivo de emitir o Cadastro de Itens Classe de Valor "
//"Sera impresso de acordo com os parametros solicitados pelo"
//"usuario"
oReport	:= TReport():New( cReport,Capital(CTITULO),CPERG, { |oReport| /*Pergunte(cPerg , .F. ),*/ If(! ReportPrint( oReport ), oReport:CancelPrint(), .T. ) }, CDESC ) 
oReport:SetLandScape(.T.)
oReport:DisableOrientation()
oReport:SetEdit(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1  := TRSection():New( oReport, STR0027, {"cArqTmp"},, .F., .F. ) //"Plano de contas"                   

// Entidades
If lEntidade1
	TRCell():New( oSection1, "CVX_NIV01"	,,aEstrCT0[1][3]/*Titulo*/	,/*Picture*/, aEstrCT0[1][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV01}/*CodeBlock*/  )
EndIf	
If lEntidade2
	TRCell():New( oSection1, "CVX_NIV02"	,,aEstrCT0[2][3]/*Titulo*/	,/*Picture*/, aEstrCT0[2][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV02}/*CodeBlock*/  )
EndIf		
If lEntidade3
	TRCell():New( oSection1, "CVX_NIV03"	,,aEstrCT0[3][3]/*Titulo*/	,/*Picture*/, aEstrCT0[3][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV03}/*CodeBlock*/  )
EndIf		
If lEntidade4
	TRCell():New( oSection1, "CVX_NIV04"	,,aEstrCT0[4][3]/*Titulo*/	,/*Picture*/, aEstrCT0[4][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV04}/*CodeBlock*/  )
EndIf		
If lEntidade5
	TRCell():New( oSection1, "CVX_NIV05"	,,aEstrCT0[5][3]/*Titulo*/	,/*Picture*/, aEstrCT0[5][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV05}/*CodeBlock*/  )
EndIf		
If lEntidade6
	TRCell():New( oSection1, "CVX_NIV06"	,,aEstrCT0[6][3]/*Titulo*/	,/*Picture*/, aEstrCT0[6][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV06}/*CodeBlock*/  )
EndIf		
If lEntidade7
	TRCell():New( oSection1, "CVX_NIV07"	,,aEstrCT0[7][3]/*Titulo*/	,/*Picture*/, aEstrCT0[7][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV07}/*CodeBlock*/  ) 
EndIf		
If lEntidade8	
	TRCell():New( oSection1, "CVX_NIV08"	,,aEstrCT0[8][3]/*Titulo*/	,/*Picture*/, aEstrCT0[8][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV08}/*CodeBlock*/  )
EndIf		
If lEntidade9	
	TRCell():New( oSection1, "CVX_NIV09"	,,aEstrCT0[9][3]/*Titulo*/	,/*Picture*/, aEstrCT0[9][2] /*Tamanho*/, /*lPixel*/, {||cArqTmp->CVX_NIV09}/*CodeBlock*/  )		
EndIf		

TRCell():New( oSection1,"CVX_SALD01" /*"SALDOANT"*/ ,,STR0030/*Titulo*/	,/*Picture*/, aTamVal[1] + 2/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"RIGHT")
TRCell():New( oSection1,"CVX_SLDB02" /*"SALDODEB"*/ ,,STR0031/*Titulo*/	,/*Picture*/, aTamVal[1]    /*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"RIGHT")
TRCell():New( oSection1,"CVX_SLCR02" /*"SALDOCRD"*/ ,,STR0032/*Titulo*/	,/*Picture*/, aTamVal[1]    /*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"RIGHT")
TRCell():New( oSection1,"CVX_SALD02" /*"MOVIMENTO"*/,,STR0033/*Titulo*/	,/*Picture*/, aTamVal[1] + 2/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"RIGHT")
TRCell():New( oSection1,"CVX_SLDATU" /*"SALDOATU"*/ ,,STR0034/*Titulo*/	,/*Picture*/, aTamVal[1] + 2/*Tamanho*/, /*lPixel*/, /*CodeBlock*/, "RIGHT",,"RIGHT")
                                                                                 
oSection1:SetTotalInLine(.F.)          
oSection1:SetTotalText('') //STR0011) //"T O T A I S  D O  P E R I O D O: "

Return( oReport )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Daniel Sakavicius	³ Data ³ 28/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±³          ³Nesta funcao deve ser criada a query das secoes se SQL ou   ³±±
±±³          ³definido o relacionamento e filtros das tabelas em CodeBase.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportPrint(oReport)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )  
Local oSection1 	:= oReport:Section(1) 
Local lExterno		:= .F.   
Local aSetOfBook
Local dDataFim 		:= MV_PAR02
Local lFirstPage	:= .T.
Local lJaPulou		:= .F.
Local lRet			:= .T.
Local lPrintZero	:=  IIF(MV_PAR07==1,.T.,.F.) 
Local lPula			:=  .f. //IIF(MV_PAR09==1,.T.,.F.) 
Local lNormal		:= .T. 
Local lVlrZerado	:=  IIF(MV_PAR03==1,.T.,.F.)
Local lQbGrupo		:= .T. 
Local lQbConta		:= .T.
Local l132			:= .T.
Local nDecimais
Local nDivide		:= 1
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotMov		:= 0
Local nGrpDeb		:= 0
Local nGrpCrd		:= 0                     
Local cSegAte   	:= "" 
Local nDigitAte		:= 0
Local lImpSint		:= .T.
Local lImpMov		:= IIF(MV_PAR06==1,.T.,.F.)
Local n
Local oMeter
Local oText
Local oDlg
Local oBreak
Local lImpPaisgm	:= .F.	
Local nMaxLin   	:=  MV_PAR08
Local cMoedaDsc		:=  MV_PAR09 
Local aCtbMoeda		:= {}
Local aCtbMoedadsc	:= {}
Local CCOLBAR		:= "|"                   
Local cTipoAnt		:= ""
Local cGrupoAnt		:= ""
Local cArqTmp		:= ""
Local Tamanho		:= "M"
Local cSeparador	:= ""
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local oTotDeb		
Local oTotCrd
Local oTotGerDeb		
Local oTotGerCrd
Local cPicture
Local cContaSint
Local cBreak		:= "2"
Local cGrupo		:= ""
Local nTotGerDeb	:= 0
Local nTotGerCrd	:= 0
Local nTotGerMov	:= 0
Local nCont			:= 0
Local cFilUser		:= ""
Local cRngFil		:= "" 
Local nMasc			:= 0
Local cMasc			:= ""

Local aEntidIni		:= {}
Local aEntidFim		:= {}
Local nX			:= 0
Local oObjCubo

Local lColDbCr 		:= lIsRedStor // Disconsider cTipo in ValorCTB function, setting cTipo to empty only used in Russia
Private nLinReport    := 9

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)	    	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSetOfBook := CTBSetOf( "" )

If lRet
	aCtbMoeda := CtbMoeda(  MV_PAR04 , nDivide )

	If Empty(aCtbMoeda[1])                       
		Help(" ",1,"NOMOEDA")
		lRet := .F.
		Return lRet
	Endif

    // validação da descrição da moeda
	if lRet .And. ! Empty(  MV_PAR09 ) .and.  MV_PAR09 <> nil
		aCtbMoedadsc := CtbMoeda(  MV_PAR09 , nDivide )

		If Empty( aCtbMoedadsc[1] )                       
    		Help( " " , 1 , "NOMOEDA")
	        lRet := .F.
    	    Return lRet
	    Endif
	Endif
Endif

aCtbMoeda  	:= CtbMoeda( MV_PAR04,nDivide)                

cDescMoeda 	:= Alltrim(aCtbMoeda[2])
nDecimais 	:= DecimalCTB(aSetOfBook,MV_PAR04)

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
Else
	cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf
cPicture 		:= aSetOfBook[4]

lPrintZero	:= Iif( MV_PAR07==1,.T.,.F.)

Titulo:=	OemToAnsi(STR0017)	//"BALANCETE DE VERIFICACAO DE "
Titulo += 	DTOC(MV_PAR01) + OemToAnsi(STR0007) + Dtoc(MV_PAR02) + ;
			OemToAnsi(STR0008) + cDescMoeda + CtbTitSaldo(MV_PAR05)           

oReport:SetCustomText( {|| nCtCGCCabTR(dDataFim, MV_PAR01,titulo,oReport)})

cFilUser := oSection1:GetAdvplExpr("CVX")
If Empty(cFilUser)
	cFilUser := ".T."
EndIf	

If !lAutomato

	For nX:=1 To Len(aParCubo)
		AADD( aEntidIni,If(MsAscii(aParCubo[nX][1])== 13,Space(Len(aParCubo[nX][1])),aParCubo[nX][1]))
		AADD( aEntidFim,If(MsAscii(aParCubo[nX][2])== 13,Space(Len(aParCubo[nX][2])),aParCubo[nX][2]))
	Next nX 		
	
Else

	For nX:=1 To Len(aParCubo) 
		AADD( aEntidIni,aAuxRoboIni[nx])
		AADD( aEntidFim,aAuxRoboFin[nx])
	Next nX

EndIf 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao			  		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If lExterno  .or. lAutomato
		U_R051PROC(aEntidIni,aEntidFim,Mv_Par01,Mv_Par02,MV_PAR10,MV_PAR04,MV_PAR05,aSelFil,@oObjCubo) 
	Else
		MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
					U_R051PROC(aEntidIni,aEntidFim,Mv_Par01,Mv_Par02,MV_PAR10,MV_PAR04,MV_PAR05,aSelFil,@oObjCubo)},;
					OemToAnsi(OemToAnsi(STR0015)),;  //"Criando Arquivo Tempor rio..."
					OemToAnsi(STR0003))  				//"Balancete Verificacao"
	EndIf
                                                          
                
nCount := cArqTmp->(RecCount())

oReport:SetMeter(nCont)

lRet := !(nCount == 0 .And. !Empty(aSetOfBook[5]))

If lRet
	                          
	cArqTmp->(dbGoTop())
	
	If lIsRedStor
		oSection1:Cell("CVX_SALD01"):SetBlock( { || ValorCTB(cArqTmp->CVX_SALD01,,,aTamVal[1],nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) } )
		oSection1:Cell("CVX_SLDB02"):SetBlock( { || ValorCTB(cArqTmp->CVX_SLDB02,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) } )
		oSection1:Cell("CVX_SLCR02"):SetBlock( { || ValorCTB(cArqTmp->CVX_SLCR02,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) } )
		oSection1:Cell("CVX_SLDATU"):SetBlock( { || ValorCTB(cArqTmp->CVX_SLDATU,,,aTamVal[1],nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) } )
	Else
		oSection1:Cell("CVX_SALD01"):SetBlock( { || ValorCTB(cArqTmp->CVX_SALD01,,,aTamVal[1],nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.) } )
		oSection1:Cell("CVX_SLDB02"):SetBlock( { || ValorCTB(cArqTmp->CVX_SLDB02,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) } )
		oSection1:Cell("CVX_SLCR02"):SetBlock( { || ValorCTB(cArqTmp->CVX_SLCR02,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) } )
		oSection1:Cell("CVX_SLDATU"):SetBlock( { || ValorCTB(cArqTmp->CVX_SLDATU,,,aTamVal[1],nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.) } )
	EndIf
	    
	// Imprime Movimento
	If !lImpMov
		oSection1:Cell("CVX_SALD02"):Disable()
	Else
		If lIsRedStor
			oSection1:Cell("CVX_SALD02"):SetBlock( { || ValorCTB(cArqTmp->CVX_SALD02,,,aTamVal[1],nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,, lPrintZero,.F.) } )				
		Else
			oSection1:Cell("CVX_SALD02"):SetBlock( { || ValorCTB(cArqTmp->CVX_SALD02,,,aTamVal[1],nDecimais,.T.,cPicture,,,,,,, lPrintZero,.F.) } )
		Endif
	EndIf

	//******************************
	// Total Geral do relatorio    *
	//******************************
	oBrkGeral := TRBreak():New(oSection1, { || cArqTmp->(!Eof()) },{|| STR0011 },,,.F.)	//	" T O T A I S "

	// Totaliza
	oTotGerDeb := TRFunction():New(oSection1:Cell("CVX_SLDB02"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || cArqTmp->CVX_SLDB02 },.F.,.F.,.F.,oSection1)
	oTotGerDeb:Disable()

	oTotGerCrd := TRFunction():New(oSection1:Cell("CVX_SLCR02"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || cArqTmp->CVX_SLCR02 },.F.,.F.,.F.,oSection1)
	oTotGerCrd:Disable()

	If lIsRedStor
		TRFunction():New(oSection1:Cell("CVX_SLDB02"),,"ONPRINT",oBrkGeral/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGerDeb:GetValue(),,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection1 )	
	Else
		TRFunction():New(oSection1:Cell("CVX_SLDB02"),,"ONPRINT",oBrkGeral/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGerDeb:GetValue(),,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	EndIF
	
	// Imprime
	If lIsRedStor
		TRFunction():New(oSection1:Cell("CVX_SLCR02"),,"ONPRINT",oBrkGeral/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGerCrd:GetValue(),,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("CVX_SLCR02"),,"ONPRINT",oBrkGeral/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGerCrd:GetValue(),,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.) },.F.,.F.,.F.,oSection1 )
	Endif 
	                                                                        
	oSection1:OnPrintLine( {|| 	U_CTR051OnPrint( lPula, lQbConta, nMaxLin, @cTipoAnt, @nLinReport, @cGrupoAnt ) } )
                                                               
	oSection1:Print()
	
EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF	

oObjCubo:ErasedFiles()
Return .T.
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTR051OnPrint ºAutor ³ Gustavo Henrique º Data ³ 07/02/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Executa acoes especificadas nos parametros do relatorio,   º±±
±±º          ³ antes de imprimir cada linha.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPL1 - Indicar se deve saltar linha entre conta sintetica º±±
±±º          ³ EXPL2 - Indicar se deve quebrar pagina por conta           º±±
±±º          ³ EXPN3 - Informar o total de linhas por pagina do balancete º±±
±±º          ³ EXPC4 - Guardar o tipo da conta impressa (sint./analitica) º±±
±±º          ³ EXPN5 - Guardar linha atual do relatorio para validacao    º±±
±±º          ³         com o valor do parametro EXPN3.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ EXPL1 - Indicar se deve imprimir a linha (.T.)             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Contabilidade Gerencial                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTR051OnPrint( lPula, lQbConta, nMaxLin, cTipoAnt, nLinReport )
                                                                        
Local lRet := .T.           

If MV_PAR03 == 2 //NAO IMPRIME ZERADO
	If cArqTmp->CVX_SALD01 == 0 .And. cArqTmp->CVX_SLDB02 == 0  .And. cArqTmp->CVX_SLCR02 == 0 .And. cArqTmp->CVX_SLDATU  == 0
		lRet := .F. 
		Return(lRet)
	EndIf
EndIf

// Verifica numero maximo de linhas por pagina (MV_PAR11)
If !Empty(nMaxLin)
	CTR051MaxL(nMaxLin,@nLinReport)
EndIf	

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CT048Valid³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 24.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida Perguntas                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ct048Valid(cSetOfBook)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T./.F.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Codigo da Config. Relatorio                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ct051Valid(cSetOfBook)

Local aSaveArea:= GetArea()
Local lRet		:= .T.	

If !Empty(cSetOfBook)
	dbSelectArea("CTN")
	dbSetOrder(1)
	If !dbSeek(xfilial()+cSetOfBook)
		aSetOfBook := ("","",0,"","")
		Help(" ",1,"NOSETOF")
		lRet := .F.
	EndIf
EndIf
	
RestArea(aSaveArea)

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CTR051MAXL ºAutor ³ Eduardo Nunes Cirqueira º Data ³  31/01/07 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Baseado no parametro MV_PAR11 ("Num.linhas p/ o Balancete      º±±
±±º          ³ Modelo 1"), cujo conteudo esta na variavel "nMaxLin", controla º±±
±±º          ³ a quebra de pagina no TReport                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTR051MaxL(nMaxLin,nLinReport)

nLinReport++

If nLinReport > nMaxLin
	oReport:EndPage()
	nLinReport := 10
EndIf

Return Nil
                                                                          

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ nCtCGCCabTR  º Autor ³ Fabio Jadao Caires      º Data ³ 31/01/07º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Chama a funcao padrao CtCGCCabTR reiniciando o contador de      º±±
±±º          ³ linhas para o controle do relatorio.                            º±±
±±º          ³                                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION nCtCGCCabTR(dDataFim,dDataIni,titulo,oReport)

nLinReport := 10

RETURN CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport,,,,,,,,,,dDataIni)   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R051PROC    ºAutor  ³TOTVS               º Data ³  08/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                              º±±
±±º          ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R051PROC(aEntdIni,aEntdFim,dDataIni,dDataFim,cCodCubo,cMoeda,cTpSald,aSelFil, oObjCubo)
Local aDataIni	:= {}
Local aDataFim	:= {}
Local cArqTemp	:= ""   
Local cQry		:= "" 
Local cQryField := ""                  
Local nX		:= 0
Local nY		:= 0
Local nEntidade	:= Len(aEntdIni)
Local aTam		:= TamSx3('CT2_VALOR')  
Local lVlrZerado:=  IIF(MV_PAR03==1,.T.,.F.)

Default aSelFil := {cFilAnt}

// Variavel data inicial
AADD(aDataIni,Ctod("01/01/80"))		// Data Anterior 
AADD(aDataIni,dDataIni)				// Data Atual
                                             
AADD(aDataFim,dDataIni-1)			// Data Anterior 
AADD(aDataFim,dDataFim)				// Data Atual

/* Cria Classe Ctb_Exec_Cube Objeto --> oObjCubo */
oObjCubo := Ctb_Exec_Cube():New(cCodCubo,cMoeda,cTpSald,nEntidade,Len(aDataFim))
oObjCubo:lZerado := lVlrZerado

/* Cria arquivo temporario no TOP retornando nome do arquivo */
cArqTemp :=  oObjCubo:CtbCriaTemp() 
                                             
For nY:=1 To nEntidade
	oObjCubo:Set_Level_Cube(nY)
                                                                                                     
	oObjCubo:oStructCube:Ctb_Set_IniParam(nY, aEntdIni[nY])          //aqui colocado parametro inicial
	oObjCubo:oStructCube:Ctb_Set_FimParam(nY, aEntdFim[nY])			// parametro final	
	If nY >= 5
		//não filtrar as entidades 5 a 9 em branco
		oObjCubo:oStructCube:aVazio[nY] := .F.
	EndIf
	/* Atualiza a propriedade aQueryDim */	
	oObjCubo:CtbCriaQueryDim()
Next nY	

oObjCubo:Set_Level_Cube(nEntidade) 

oObjCubo:Set_aSelFil(aSelFil) 
                                    
/* Monta query com a propriedade aQueryDim */
oObjCubo:CtbCriaQry(.T./*lMovimento*/, aDataIni/*aDtIni*/, aDataFim/*aDtFim*/, cArqTemp, .T./*lAllNiveis*/, .F./* lFechamento*/)

/* Popular tabela temporaria */
oObjCubo:CtbPopulaTemp(cArqTemp) 

cQryField := ""
FOR nX := 1 TO Val(MV_PAR10)
	cQryField += "CVX_NIV0"+ AllTrim(Str(nX)) + ", "
Next   

cQry += "Select CVX_FILIAL, "
cQry += "       CVX_CONFIG, "
cQry += "       CVX_MOEDA , "
cQry += "       CVX_TPSALD, "   
cQry += cQryField              
If lIsRedStor
	cQry += " CT1.CT1_NORMAL AS NORMAL, "
Endif 	
cQry += "       CVX_PROC ,  "       
cQry += "       CVX_NIVEL,  " 
cQry += "       CVX_IDPAI,  "
cQry += "       SUM( CVX_SLCR01 ) CVX_SLCR01, " 
cQry += "       SUM( CVX_SLDB01 ) CVX_SLDB01, " 
cQry += "       SUM( CVX_SALD01 ) CVX_SALD01, " 
cQry += "       SUM( CVX_SLCR02 ) CVX_SLCR02, " 
cQry += "       SUM( CVX_SLDB02 ) CVX_SLDB02, " 
cQry += "       SUM( CVX_SALD02 ) CVX_SALD02, " 
cQry += "       SUM( CVX_SALD02 + CVX_SALD01 ) CVX_SLDATU "
cQry += " FROM "+cArqTemp   
If lIsRedStor
	cQry += ", " + RetSqlName("CT1") + " CT1 "   
	cQry += " WHERE CT1.CT1_FILIAL = '" + xFILIAL("CT1") + "' AND CT1.CT1_CONTA = " + alltrim(cArqTemp) + ".CVX_NIV01 AND CT1.D_E_L_E_T_ = ' ' "
Endif
cQry += " GROUP BY CVX_FILIAL, "
cQry += "          CVX_CONFIG, "
cQry += "          CVX_MOEDA , "
cQry += "          CVX_TPSALD, "   
cQry += cQryField              
If lIsRedStor
	cQry += " CT1.CT1_NORMAL, "
Endif	
cQry += "          CVX_PROC , "       
cQry += "          CVX_NIVEL, " 
cQry += "          CVX_IDPAI  " 

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTmp",.T.,.F.)

TCSetField("cArqTmp","CVX_SLCR01", "N",aTam[1],aTam[2])	 
TCSetField("cArqTmp","CVX_SLDB01", "N",aTam[1],aTam[2])	
TCSetField("cArqTmp","CVX_SALD01", "N",aTam[1],aTam[2])	
 
TCSetField("cArqTmp","CVX_SLCR02", "N",aTam[1],aTam[2])	 
TCSetField("cArqTmp","CVX_SLDB02", "N",aTam[1],aTam[2])	
TCSetField("cArqTmp","CVX_SALD02", "N",aTam[1],aTam[2])	 
TCSetField("cArqTmp","CVX_SLDATU", "N",aTam[1],aTam[2])		

DbSelectArea("cArqTmp")
DbGoTop()

Return()

//-------------------------------------------------------------------
/*{Protheus.doc} Ctr051Pg("CTR051")
Retorna array com o pergunte

@author Totvs
   
@version P12
@since   05/09/2022
@return  Nil
@obs	 
*/
//------------------------------------------------------------------
Static Function Ctr051Pg(cPerg)
//Verifica se a nova pergunta realmente foi criada, para não dar error log no cliente
Local oPerg	:= FWSX1Util():New()
Local aPergunte
oPerg:AddGroup(cPerg)
oPerg:SearchGroup()
aPergunte := oPerg:GetGroup(cPerg)

Return(aPergunte)