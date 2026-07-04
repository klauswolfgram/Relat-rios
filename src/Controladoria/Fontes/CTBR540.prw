/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR540.CH"
#INCLUDE "PROTHEUS.CH"

//Tradu็ใo PTG 20080721

//-----------------------------------RELEASE 4-------------------------------------//

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR540   บAutor  ณPaulo Carnelossi    บ Data ณ  14/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctbr540()

U_CTBR540R4()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR540R4 บAutor  ณPaulo Carnelossi    บ Data ณ  14/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctbr540R4()
Local aArea := GetArea()

Private NomeProg := FunName()

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf


If !Pergunte("CTR540",.T.)
	Return
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros					  		ณ
//ณ mv_par01				// Data referencia                		ณ
//ณ mv_par02				// Configuracao de livros			    ณ
//ณ mv_par03				// Moeda?          			     	    ณ
//ณ mv_par04				// Usa Data referencia ou periodo De Ate*
//ณ mv_par05				// Periodo De            				ณ
//ณ mv_par06				// Periodo Ate     			     	    ณ 
//ณ mv_par07				// Folha Inicial    			     	ณ
//ณ mv_par08				// Imprime Arq. Termo Auxiliar?			ณ
//ณ mv_par09				// Arq.Termo Auxiliar ?					ณ 
//ณ mv_par10				// Consid. % em relacao ao 1o nivel?    ณ 
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

// faz a valida็ใo do livro
if ! VdSetOfBook( mv_par02 , .T. )
   return .F.
endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInterface de impressao                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := ReportDef()

If ValType( oReport ) == 'O'
	If ! Empty( oReport:uParam )
		Pergunte( oReport:uParam , .F. )
	EndIf	
	
	oReport:PrintDialog()
Endif

oReport := Nil

RestArea( aArea )
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR540R4 บAutor  ณPaulo Carnelossi    บ Data ณ  14/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ Definicao das colunas do relatorio                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportDef()
Local cPerg			:= "CTR540"
Local cReport		:= "CTBR540"
Local cTitulo		:= STR0002
Local cDesc			:= STR0016 + STR0017	//	"Este programa ira imprimir o Demonstrativo de Renda, "
                                            //	"de acordo com os parโmetros informados pelo usuแrio. "
Local oReport
Local oDemRenda
Local aOrdem 		:= {}
Local aTamVal		:= TAMSX3("CT2_VALOR")

Local aSetOfBook	:= CTBSetOf(mv_par02)

cTitulo		:= If(! Empty(aSetOfBook[10]), aSetOfBook[10], cTitulo)		// Titulo definido SetOfBook
If Valtype(mv_par12)=="N" .And. (mv_par12 == 1)
	cTitulo := CTBNomeVis( aSetOfBook[5] )
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao do componente de impressao                                      ณ
//ณ                                                                        ณ
//ณTReport():New                                                           ณ
//ณExpC1 : Nome do relatorio                                               ณ
//ณExpC2 : Titulo                                                          ณ
//ณExpC3 : Pergunte                                                        ณ
//ณExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ณ
//ณExpC5 : Descricao                                                       ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//STR0002 "Demonstrativo de Renda"
oReport := TReport():New(cReport,cTitulo, cPerg, ;
			{|oReport| Pergunte(cPerg,.F.), If(!ct040Valid(mv_par02), oReport:CancelPrint(), ReportPrint(oReport)) },;
			cDesc )
oReport:SetLandScape(.T.)
oReport:ParamReadOnly()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao da secao utilizada pelo relatorio                               ณ
//ณ                                                                        ณ
//ณTRSection():New                                                         ณ
//ณExpO1 : Objeto TReport que a secao pertence                             ณ
//ณExpC2 : Descricao da se็ao                                              ณ
//ณExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ณ
//ณ        sera considerada como principal para a se็ใo.                   ณ
//ณExpA4 : Array com as Ordens do relat๓rio                                ณ
//ณExpL5 : Carrega campos do SX3 como celulas                              ณ
//ณ        Default : False                                                 ณ
//ณExpL6 : Carrega ordens do Sindex                                        ณ
//ณ        Default : False                                                 ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//adiciona ordens do relatorio
oDemRenda := TRSection():New(oReport, STR0018, {  "cArqTmp" }, aOrdem /*{}*/, .F., .F.)  //"Detalhe"
TRCell():New(oDemRenda,"CLN_CONTA"    ,"",STR0019/*Titulo*/	,/*Picture*/,50           /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)					//	"Conta"
TRCell():New(oDemRenda,"CLN_VLRPER_0" ,"",STR0013/*Titulo*/	,/*Picture*/,aTamVal[1]+2 /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	"Periodo"
TRCell():New(oDemRenda,"CLN_VLRPERCE" ,"",STR0014/*Titulo*/	,/*Picture*/,8            /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	" % "
TRCell():New(oDemRenda,"CLN_VLRACUMU" ,"",STR0009/*Titulo*/	,/*Picture*/,aTamVal[1] +2/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	"Acumulado"
TRCell():New(oDemRenda,"CLN_VLRPERACU","",STR0014/*Titulo*/	,/*Picture*/,8            /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	" % "
oDemRenda:Cell("CLN_CONTA"):SetLineBreak()
oDemRenda:SetHeaderPage()

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint บAutor ณPaulo Carnelossi   บ Data ณ  14/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ Funcao de impressao do relatorio acionado pela execucao    บฑฑ
ฑฑบ          ณ do botao <OK> da PrintDialog()                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportPrint(oReport)

Local oDemRenda	:= oReport:Section(1)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local aSetOfBook	:= CTBSetOf(mv_par02)
Local aCtbMoeda		:= {}
Local lin 			:= 3001
Local cArqTmp
Local cPicture
Local cDescMoeda
Local lFirstPage	:= .T.               
Local nTraco		:= 0
Local aTotal 		:= {}
Local nTotal		:= 0
Local nTotMes		:= 0
Local nTotAtu		:= 0
Local aColunas		:= {}, nColuna
Local cTpValor		:= GETMV("MV_TPVALOR")
Local lImpTrmAux	:= Iif(mv_par08 == 1,.T.,.F.)
Local cArqTrm		:= ""
Local nTotPer		:= 0 
Local cProcesso     := STR0002
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local cTitAux

Private dInicio
Private dFinal
Private dPeriodo0
Private cTitulo

If mv_par04 == 2 
	dInicio  	:= mv_par05
	dFinal		:= mv_par06
	dPeriodo0	:= CtbPeriodos(mv_par03,dInicio,dFinal,.F.,.F.)[1][2]
	cTitAux		:= STR0012 + dToc(dInicio) + STR0011 + dToc(dFinal)
Else
	dInicio  	:= Ctod("01/" + Subs(Dtoc(mv_par01), 4))
	dFinal		:= mv_par01
	dPeriodo0 	:= Ctod(Str(Day(LastDay(mv_par01)), 2) + "/" + Subs(Dtoc(mv_par01), 4))
	cTitAux 	:= ""
EndIf	

aCtbMoeda := CtbMoeda(mv_par03, aSetOfBook[9])
If Empty(aCtbMoeda[1])                       
	Help(" ",1,"NOMOEDA")
	oReport:CancelPrint()
    Return .F.
Endif

cDescMoeda 	:= AllTrim(aCtbMoeda[3])
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par03)

cPicture 	:= aSetOfBook[4]
If ! Empty(cPicture) .And. Len(Trans(0, cPicture)) > 15		// Bops 59240
	cPicture := ""
Endif

oReport:SetTitle(oReport:Title()+cTitAux)
oReport:SetPageNumber(mv_par07)
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataBase,oReport:Title(),,,,,oReport) } )

oDemRenda:Cell("CLN_CONTA"):SetBorder("LEFT")
oDemRenda:Cell("CLN_VLRPER_0"):SetBorder("LEFT")
oDemRenda:Cell("CLN_VLRPERCE"):SetBorder("LEFT")
oDemRenda:Cell("CLN_VLRACUMU"):SetBorder("LEFT")
oDemRenda:Cell("CLN_VLRPERACU"):SetBorder("LEFT")
oDemRenda:Cell("CLN_VLRPERACU"):SetBorder("RIGHT")

If mv_par04 == 2

	oDemRenda:Cell("CLN_VLRPER_0"):SetTitle(STR0013)  //"Periodo "
	oDemRenda:Cell("CLN_VLRPERCE"):SetTitle(STR0014)  //"% "
	oDemRenda:Cell("CLN_VLRACUMU"):SetTitle(STR0009)  //Acumulado
	oDemRenda:Cell("CLN_VLRPERACU"):SetTitle(STR0014) //"% "
	
Else

	oDemRenda:Cell("CLN_VLRPER_0"):SetTitle(Dtoc(mv_par01)) 
	oDemRenda:Cell("CLN_VLRPERCE"):SetTitle(STR0008)  //"% Tot"
	oDemRenda:Cell("CLN_VLRACUMU"):SetTitle(STR0007 + Subs(Dtoc(mv_par01), 4))  //"Mes "	
	oDemRenda:Cell("CLN_VLRPERACU"):SetTitle(STR0008) //"% "

EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao							  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			dInicio,dFinal,"","","",Repl("Z", Len(CT1->CT1_CONTA)),;
			"",Repl("Z", Len(CTT->CTT_CUSTO)),"",Repl("Z", Len(CTD->CTD_ITEM)),;
			"",Repl("Z", Len(CTH->CTH_CLVL)),mv_par03,;
			MV_PAR11,aSetOfBook,Space(2),Space(20),Repl("Z", 20),Space(30))},;
			STR0006, cProcesso) //"Criando Arquivo Temporario..."

dbSelectArea("cArqTmp")
dbGoTop()

While cArqTmp->(! Eof())
	Aadd(aColunas, Recno())
	If cArqTmp->IDENTIFI = "4"
		nTotal := Ascan(aTotal, { |x| x[1] = cArqTmp->CONTA })
		If nTotal = 0
			Aadd(aTotal, { cArqTmp->CONTA, 0, 0 })
			nTotal := Len(aTotal)
		Endif
		aTotal[nTotal][2] += cArqTmp->SALDOPER
		aTotal[nTotal][3] += cArqTmp->(SALDOATU - SALDOANT)
	Endif
	cArqTmp->(DbSkip())
EndDo
If Len(aTotal) = 0
	aTotal := { {"", 0, 0 }}
Endif

oDemRenda:Cell("CLN_CONTA"):SetBlock({|| cArqTmp->DESCCTA})
oDemRenda:Cell("CLN_VLRPER_0"):SetBlock({|| ValorCTB(cArqTmp->(SALDOATU - SALDOANT),,,aTamVal[1],nDecimais,.T.,cPicture, cArqTmp->NORMAL, cArqTmp->CONTA,,,cTpValor,,, .F.) })
oDemRenda:Cell("CLN_VLRPERCE"):SetBlock({|| Transform((cArqTmp->(SALDOATU - SALDOANT) / nTotAtu) * 100, "@E 9999.99") })
oDemRenda:Cell("CLN_VLRACUMU"):SetBlock({|| ValorCTB(cArqTmp->SALDOPER,,,aTamVal[1],nDecimais,.T.,cPicture, cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F.) } )
oDemRenda:Cell("CLN_VLRPERACU"):SetBlock({|| Transform(cArqTmp->(SALDOPER / nTotMes) * 100, "@E 9999.99")})

oDemRenda:Init()

For nColuna := 1 To Len(aColunas)
	cArqTmp->(MsGoto(aColunas[nColuna]))
    
	If cArqTmp->DESCCTA = "-"
		oReport:ThinLine()   	// horizontal
	Else
		nTotal := Ascan(aTotal, { |x| x[1] = cArqTmp->SUPERIOR })
		If mv_par10 == 1	//Se considerar o % do total em relacao a conta de nivel 1
			If Empty(cArqTmp->SUPERIOR)			
				nTotMes := cArqTmp->SALDOPER
				nTotAtu := cArqTmp->(SALDOATU - SALDOANT)
			EndIf					
		Else	
			If Empty(cArqTmp->SUPERIOR) .Or. cArqTmp->IDENTIFI = "4"
				nTotMes := cArqTmp->SALDOPER
				nTotAtu := cArqTmp->(SALDOATU - SALDOANT)
			ElseIf nTotal = 0
				nTotMes := nTotAtu := 0
			Else
				nTotMes := aTotal[nTotal][2]
				nTotAtu := aTotal[nTotal][3]
			Endif
		EndIF
		
		oDemRenda:PrintLine()	

	Endif

Next

oDemRenda:Finish()
oReport:ThinLine()

If lImpTrmAux

	cArqTRM 	:= mv_par09
	aVariaveis	:= {}
	
    // Buscando os parโmetros do relatorio (a partir do SX1) para serem impressaos do Termo (arquivos *.TRM)
	SX1->( dbSeek( padr( "CTR500" , Len( X1_GRUPO ) , ' ' ) + "01" ) )

	Do While SX1->X1_GRUPO == padr( "CTR500" , Len( SX1->X1_GRUPO ) , ' ' )
		AADD(aVariaveis,{Rtrim(Upper(SX1->X1_VAR01)),&(SX1->X1_VAR01)})
		SX1->( dbSkip() )
	EndDo
	
	If ! File(cArqTRM)
		aSavSet:=__SetSets()
		cArqTRM := CFGX024(cArqTRM,STR0015) // "Responsแveis..."
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If cArqTRM#NIL
		ImpTerm2(cArqTRM,aVariaveis,,,,oReport)
	Endif	 
Endif

DbSelectArea("cArqTmp")
Set Filter To
dbCloseArea() 
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF	
dbselectArea("CT2")

Return