/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "PROTHEUS.Ch"
#include "ctbr541.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR541   บAutor  ณ Totvs              บ Data ณ  27/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctbr541()

If TRepInUse()
	U_CTBR541R4()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR541R4 บAutor  ณ Totvs              บ Data ณ  27/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctbr541R4()
Local aArea := GetArea()

Private NomeProg := FunName()

// Acesso somente pelo SIGACTB
If !AMIIn( 34 )
	Return
EndIf


If !Pergunte( "CTR541", .T. )
	Return
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros					  		ณ
//ณ MV_PAR01				// Data referencia                		ณ
//ณ MV_PAR02				// Configuracao de livros			    ณ
//ณ MV_PAR03				// Moeda?          			     	    ณ
//ณ MV_PAR04				// Usa Data referencia ou periodo De Ate*
//ณ MV_PAR05				// Periodo De            				ณ
//ณ MV_PAR06				// Periodo Ate     			     	    ณ 
//ณ MV_PAR07				// Folha Inicial    			     	ณ
//ณ MV_PAR08				// Imprime Arq. Termo Auxiliar?			ณ
//ณ MV_PAR09				// Arq.Termo Auxiliar ?					ณ 
//ณ MV_PAR10				// Consid. % em relacao ao 1o nivel?    ณ 
//ณ MV_PAR11				// Tipo de Saldo?                       ณ 
//ณ MV_PAR12				// Titulo como nome da Visao?           ณ 
//ณ MV_PAR13				// Mov. do Periodo?                     ณ 
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

// faz a valida็ใo do livro
If !VdSetOfBook( MV_PAR02 , .T. )
   Return .F.
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInterface de impressao                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := ReportDef()

If ValType( oReport ) == 'O'
	If !Empty( oReport:uParam )
		Pergunte( oReport:uParam , .F. )
	EndIf	
	
	oReport:PrintDialog()
EndIf

oReport := Nil

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR541R4 บAutor  ณ Totvs              บ Data ณ  27/09/10   บฑฑ
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
Local cPerg			:= "CTR541"
Local cReport		:= "CTBR541"
Local cTitulo		:= STR0002
Local cDesc			:= STR0016 + STR0017	//	"Este programa ira imprimir o Demonstrativo de Renda, "
                                            //	"de acordo com os parโmetros informados pelo usuแrio. "
Local oReport
Local oDemRenda
Local aOrdem 		:= {}
Local aTamVal		:= TamSX3( "CT2_VALOR" )

Local aSetOfBook	:= CTBSetOf( MV_PAR02 )

cTitulo		:= If( !Empty( aSetOfBook[10] ), aSetOfBook[10], cTitulo )		// Titulo definido SetOfBook
If ValType( MV_PAR12 ) == "N" .And. MV_PAR12 == 1
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
oReport := TReport():New( 	cReport, cTitulo, cPerg,;
							{ |oReport| Pergunte( cPerg, .F. ), If( !Ct040Valid( MV_PAR02 ), oReport:CancelPrint(), ReportPrint( oReport ) ) },;
							cDesc )

oReport:SetLandScape( .T. )
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
oDemRenda := TRSection():New( oReport, STR0018, {  "cArqTmp" }, aOrdem /*{}*/, .F., .F. )  //"Detalhe"
TRCell():New( oDemRenda, "CONTA"		, "", STR0021/*Titulo*/	,/*Picture*/, TamSX3( "CT1_CONTA" )[1] 	/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)					//	"Conta"
TRCell():New( oDemRenda, "CLN_CONTA"	, "", STR0019/*Titulo*/	,/*Picture*/, 50 						/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)					//	"Descricao da Conta"
TRCell():New( oDemRenda, "SUPERIOR"		, "", STR0022/*Titulo*/	,/*Picture*/, TamSX3( "CT1_CONTA" )[1] 	/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)					//	"Conta Superior"

// Apresenta as colunas de saldo anterio e movimento do periodo
If MV_PAR13 == 1
	TRCell():New( oDemRenda, "SALDOANT" , "", STR0023/*Titulo*/	,/*Picture*/, aTamVal[1]+2/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	"Saldo Anterior"
EndIf

TRCell():New( oDemRenda, "CLN_VLRPER_0" , "", STR0013/*Titulo*/	,/*Picture*/, aTamVal[1]+2 /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	"Periodo"
TRCell():New( oDemRenda, "CLN_VLRPERCE" , "", STR0014/*Titulo*/	,/*Picture*/, 8            /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	" % "
TRCell():New( oDemRenda, "CLN_VLRACUMU" , "", STR0009/*Titulo*/	,/*Picture*/, aTamVal[1]+2/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	"Acumulado"
TRCell():New( oDemRenda, "CLN_VLRPERACU", "", STR0014/*Titulo*/	,/*Picture*/, 8            /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	" % "

oDemRenda:Cell( "CLN_CONTA" ):SetLineBreak()
oDemRenda:SetHeaderPage()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint บAutor ณ TOtvs             บ Data ณ  27/09/10   บฑฑ
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
Local oDemRenda		:= oReport:Section( 1 )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aSetOfBook	:= CTBSetOf( MV_PAR02 )
Local aCtbMoeda		:= {}
Local cArqTmp
Local cPicture
Local aTotal 		:= {}
Local nTotal		:= 0
Local nTotMes		:= 0
Local nTotAtu		:= 0
Local nTotVisA		:= 0
Local nTotVisM		:= 0
Local aColunas		:= {}
Local nColuna
Local cTpValor		:= GetMV( "MV_TPVALOR" )
Local lImpTrmAux	:= IIf( MV_PAR08 == 1, .T., .F. )
Local cArqTrm		:= ""
Local cProcesso     := STR0002
Local aTamVal		:= TamSX3( "CT2_VALOR" )
Local cTitAux
Local lCharSinal	:= .F.

Private dInicio
Private dFinal
Private dPeriodo0
Private cTitulo

If MV_PAR04 == 2 
	dInicio  	:= MV_PAR05
	dFinal		:= MV_PAR06
	dPeriodo0	:= CtbPeriodos( MV_PAR03, dInicio, dFinal, .F., .F. )[1][2]
	cTitAux		:= STR0012 + DtoC( dInicio ) + STR0011 + DtoC( dFinal )
Else
	dInicio  	:= CtoD( "01/" + Subs( DtoC( MV_PAR01 ), 4 ) )
	dFinal		:= MV_PAR01
	dPeriodo0 	:= CtoD( Str( Day( LastDay( MV_PAR01 ) ), 2 ) + "/" + Subs( DtoC( MV_PAR01 ), 4 ) )
	cTitAux 	:= ""
EndIf	

aCtbMoeda := CtbMoeda( MV_PAR03, aSetOfBook[9] )
If Empty( aCtbMoeda[1] )
	Help( " ", 1, "NOMOEDA" )
	oReport:CancelPrint()
    Return .F.
EndIf

nDecimais 	:= DecimalCTB( aSetOfBook, MV_PAR03 )
cPicture 	:= aSetOfBook[4]
If !Empty( cPicture ) .And. Len( Trans( 0, cPicture ) ) > 15
	cPicture := ""
EndIf

oReport:SetTitle( oReport:Title() + cTitAux )
oReport:SetPageNumber( MV_PAR07 )
oReport:SetCustomText( {|| CtCGCCabTR( ,,,,, dDataBase, oReport:Title(),,,,, oReport ) } )

oDemRenda:Cell( "CONTA" ):SetBorder( "LEFT" )
oDemRenda:Cell( "CLN_CONTA" ):SetBorder( "LEFT" )
oDemRenda:Cell( "SUPERIOR" ):SetBorder( "LEFT" )
oDemRenda:Cell( "CLN_VLRPER_0" ):SetBorder( "LEFT" )
oDemRenda:Cell( "CLN_VLRPERCE" ):SetBorder( "LEFT" )

// Apresenta as colunas de saldo anterio e movimento do periodo
If MV_PAR13 == 1
	oDemRenda:Cell( "SALDOANT" ):SetBorder( "LEFT" )
EndIf

oDemRenda:Cell( "CLN_VLRACUMU" ):SetBorder( "LEFT" )
oDemRenda:Cell( "CLN_VLRPERACU" ):SetBorder( "LEFT" )
oDemRenda:Cell( "CLN_VLRPERACU" ):SetBorder( "RIGHT" )

If MV_PAR04 == 2
	oDemRenda:Cell( "CLN_VLRPER_0" ):SetTitle( STR0013 )  //"Periodo "
	oDemRenda:Cell( "CLN_VLRPERCE" ):SetTitle( STR0014 )  //"% "
	oDemRenda:Cell( "CLN_VLRACUMU" ):SetTitle( STR0009 )  //Acumulado
	oDemRenda:Cell( "CLN_VLRPERACU" ):SetTitle( STR0014 ) //"% "
Else
	oDemRenda:Cell( "CLN_VLRPER_0" ):SetTitle( DtoC( MV_PAR01 ) ) 
	oDemRenda:Cell( "CLN_VLRPERCE" ):SetTitle( STR0008 )  //"% Tot"
	oDemRenda:Cell( "CLN_VLRACUMU" ):SetTitle( STR0007 + Subs( DtoC( MV_PAR01 ), 4 ) )  //"Mes "	
	oDemRenda:Cell( "CLN_VLRPERACU" ):SetTitle( STR0008 ) //"% "
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao						 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter( {|	oMeter, oText, oDlg, lEnd | ;
				CTGerPlan( oMeter, oText, oDlg, @lEnd, @cArqTmp,;
				dInicio, dFinal, "", "", "", Repl( "Z", Len( CT1->CT1_CONTA ) ),;
				"", Repl( "Z", Len( CTT->CTT_CUSTO ) ), "", Repl( "Z", Len( CTD->CTD_ITEM ) ),;
				"", Repl( "Z", Len( CTH->CTH_CLVL ) ), MV_PAR03,;
				MV_PAR11, aSetOfBook, Space(2), Space(20), Repl( "Z", 20 ), Space(30) ) },;
				STR0006, cProcesso ) //"Criando Arquivo Temporario..."

dbSelectArea( "cArqTmp" )
dbGoTop()

While cArqTmp->( !Eof() )
	Aadd( aColunas, RecNo() )

	If cArqTmp->IDENTIFI = "4" .OR. ( MV_PAR10 == 1 .AND. !Empty( cArqTmp->SUPERIOR ) )
		nTotal := aScan( aTotal, { |x| x[1] = cArqTmp->CONTA } )
		If nTotal = 0
			Aadd( aTotal, { cArqTmp->CONTA, 0, 0 } )
			nTotal := Len( aTotal )
		EndIf

		aTotal[nTotal][2]	+= cArqTmp->SALDOPER
		aTotal[nTotal][3]	+= cArqTmp->(SALDOATU - SALDOANT)
	EndIf

	If cArqTmp->TOTVIS == "1"
		nTotVisM := cArqTmp->SALDOPER
		nTotVisA := cArqTmp->(SALDOATU - SALDOANT)
	EndIf
	
	cArqTmp->( DbSkip() )
End

If Len( aTotal ) == 0
	aTotal := { { "", 0, 0 } }
EndIf

oDemRenda:Cell( "CONTA" ):SetBlock( { || cArqTmp->CONTA } )
oDemRenda:Cell( "CLN_CONTA" ):SetBlock( { || cArqTmp->DESCCTA } )
oDemRenda:Cell( "SUPERIOR" ):SetBlock( { || cArqTmp->SUPERIOR } )

// Apresenta as colunas de saldo anterio e movimento do periodo
If MV_PAR13 == 1
	oDemRenda:Cell( "SALDOANT" ):SetBlock( { || ValorCTB(cArqTmp->SALDOANT,,,aTamVal[1],nDecimais,.T.,cPicture, cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F.,,lCharSinal) } )
EndIf

If MV_PAR10 < 3
	oDemRenda:Cell( "CLN_VLRPER_0" ):SetBlock( { || ValorCTB(cArqTmp->(SALDOATU - SALDOANT),,,aTamVal[1],nDecimais,.T.,cPicture, cArqTmp->NORMAL, cArqTmp->CONTA,,,cTpValor,,, .F.,,lCharSinal) })
	oDemRenda:Cell( "CLN_VLRPERCE" ):SetBlock( { || Transform((cArqTmp->(SALDOATU - SALDOANT) / nTotAtu) * 100, "@E 9999.99") })
	oDemRenda:Cell( "CLN_VLRACUMU" ):SetBlock( { || ValorCTB(cArqTmp->SALDOPER,,,aTamVal[1],nDecimais,.T.,cPicture, cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F.,,lCharSinal) } )
	oDemRenda:Cell( "CLN_VLRPERACU" ):SetBlock( { || Transform(cArqTmp->(SALDOPER / nTotMes) * 100, "@E 9999.99")})
Else
	oDemRenda:Cell( "CLN_VLRPER_0" ):SetBlock( { || ValorCTB(cArqTmp->(SALDOATU - SALDOANT),,,aTamVal[1],nDecimais,.T.,cPicture, cArqTmp->NORMAL, cArqTmp->CONTA,,,cTpValor,,, .F.,,lCharSinal) })
	oDemRenda:Cell( "CLN_VLRPERCE" ):SetBlock( { || Transform( cArqTmp->(SALDOATU - SALDOANT) * 100 / nTotVisA, "@E 9999.99") })
	oDemRenda:Cell( "CLN_VLRACUMU" ):SetBlock( { || ValorCTB(cArqTmp->SALDOPER,,,aTamVal[1],nDecimais,.T.,cPicture, cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F.,,lCharSinal) } )
	oDemRenda:Cell( "CLN_VLRPERACU" ):SetBlock( { || Transform( cArqTmp->SALDOPER * 100 / nTotVisM, "@E 9999.99")})
EndIf

oDemRenda:Init()

For nColuna := 1 To Len( aColunas )
	cArqTmp->( MsGoto( aColunas[nColuna] ) )

	If cArqTmp->DESCCTA = "-"
		oReport:ThinLine()   	// horizontal
	Else
		nTotal := aScan( aTotal, { |x| x[1] = cArqTmp->SUPERIOR } )
		If MV_PAR10 == 1		//Se considerar o % na sintetica local
			If Empty( cArqTmp->SUPERIOR ) .OR. cArqTmp->TIPOCONTA == "1"
				nTotMes := cArqTmp->SALDOPER
				nTotAtu := cArqTmp->( SALDOATU - SALDOANT )
			ElseIf nTotal > 0
				nTotMes := aTotal[nTotal][2]
				nTotAtu := aTotal[nTotal][3]
			EndIf

		ElseIf MV_PAR10 == 2	//Se considerar o % do total em relacao a conta de nivel 1
			If Empty( cArqTmp->SUPERIOR )
				nTotMes := cArqTmp->SALDOPER
				nTotAtu := cArqTmp->( SALDOATU - SALDOANT )
			EndIf					

		EndIf
		
		oDemRenda:PrintLine()	
	EndIf
Next

oDemRenda:Finish()
oReport:ThinLine()

If lImpTrmAux
	cArqTRM 	:= MV_PAR09
	aVariaveis	:= {}

    // Buscando os parโmetros do relatorio (a partir do SX1) para serem impressaos do Termo (arquivos *.TRM)
	SX1->( DbSeek( PadR( "CTR500" , Len( X1_GRUPO ) , ' ' ) + "01" ) )

	While SX1->X1_GRUPO == PadR( "CTR500" , Len( SX1->X1_GRUPO ) , ' ' )
		AADD( aVariaveis,{ Rtrim( Upper( SX1->X1_VAR01 ) ), &( SX1->X1_VAR01 ) } )
		SX1->( dbSkip() )
	End
	
	If !File( cArqTRM )
		aSavSet := __SetSets()
		cArqTRM := CFGX024( cArqTRM, STR0015 ) // "Responsแveis..."
		__SetSets( aSavSet )
		Set( 24, Set( 24 ), .T. )
	EndIf

	If cArqTRM # NIL
		ImpTerm2( cArqTRM, aVariaveis,,,, oReport )
	EndIf	 
EndIf

DbSelectArea( "cArqTmp" )
Set Filter To
dbCloseArea() 
If Select( "cArqTmp" ) == 0
	FErase( cArqTmp + GetDBExtension() )
	FErase( cArqTmp + OrdBagExt() )
EndIf	

dbselectArea( "CT2" )

Return
