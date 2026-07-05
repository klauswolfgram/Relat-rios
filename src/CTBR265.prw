/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr265.Ch"
#Include "PROTHEUS.Ch"

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_CONTA 			2
#DEFINE 	COL_SEPARA2			3
#DEFINE 	COL_DESCRICAO		4
#DEFINE 	COL_SEPARA3			5
#DEFINE 	COL_COLUNA1       	6
#DEFINE 	COL_SEPARA4			7
#DEFINE 	COL_COLUNA2       	8
#DEFINE 	COL_SEPARA5			9
#DEFINE 	COL_COLUNA3       	10
#DEFINE 	COL_SEPARA6			11
#DEFINE 	COL_COLUNA4   		12
#DEFINE 	COL_SEPARA7			13
#DEFINE 	COL_COLUNA5   		14
#DEFINE 	COL_SEPARA8			15
#DEFINE 	COL_COLUNA6   		16
#DEFINE 	COL_SEPARA9			17
#DEFINE 	COL_COLUNA7			18
#DEFINE 	COL_SEPARA10		19
#DEFINE 	COL_COLUNA8			20
#DEFINE 	COL_SEPARA11		21
#DEFINE 	COL_COLUNA9			22
#DEFINE 	COL_SEPARA12		23
#DEFINE 	COL_COLUNA10		24
#DEFINE 	COL_SEPARA13		25
#DEFINE 	COL_COLUNA11		26
#DEFINE 	COL_SEPARA14		27
#DEFINE 	COL_COLUNA12		28
#DEFINE 	COL_SEPARA15		29
#DEFINE 	TAM_VALOR 			20

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

// 17/08/2009 -- Filial com mais de 2 caracteres

//Tradução PTG


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr265	³ Autor ³ Simone Mie Sato   	³ Data ³ 30.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Comparativo de Movim. de Contas x 12 Colunas	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr265()                               			 		  ³±±
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
User Function Ctbr265()

Private Titulo		:= ""
Private NomeProg	:= "CTBR265"
Private aSelFil    := {}

U_CTBR265R4()

//Limpa os arquivos temporários 
CTBGerClean()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR266R4 ³ Autor³ Daniel Sakavicius		³ Data ³ 04/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Comparativo de Movim. de Contas x 12 Colunas - R4³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR266R4												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR265R4() 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()      

If !Empty( oReport:uParam )
	Pergunte( oReport:uParam, .F. )	
EndIf	

oReport:PrintDialog()      
Return                                

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Daniel Sakavicius		³ Data ³ 04/09/06 ³±±
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
Local cREPORT		:= "CTBR265"
Local cTITULO		:= Capital(STR0003)							//	"Comparativo de Contas Contabeis"
Local cDESC			:= OemToAnsi(STR0001)+OemtoAnsi(STR0002)	//	"Este programa ira imprimir o Comparativo de Contas Contabeis."
                                                                //	"Os valores sao ref. a movimentacao do periodo solicitado. "
Local cPerg	   		:= "CTR265"
Local aTamConta		:= {26}	//	TAMSX3("CT1_CONTA" + MV_MASCARA)
Local aTamDesc		:= {20}
Local aTamVal		:= {12}
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
oReport	:= TReport():New( cReport,cTITULO,cPERG, { |oReport| ReportPrint( oReport ) }, cDESC )
oReport:SetLandScape(.T.)
oReport:DisableOrientation()

// Define o tamanho da fonte a ser impressa no relatorio
oReport:nFontBody := 4

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
oSection1  := TRSection():New( oReport, STR0029, {"cArqTmp","CT1"},, .F., .F. )        
TRCell():New( oSection1, "CONTA"   , ,STR0030/*Titulo*/,/*Picture*/,aTamConta[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection1, "DESCCTA" , ,STR0031/*Titulo*/,/*Picture*/,aTamDesc[1] /*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection1, "COLUNA1" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA2" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA3" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA4" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA5" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA6" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA7" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA8" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA9" , ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA10", ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA11", ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNA12", ,       /*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")
TRCell():New( oSection1, "COLUNAT" , ,STR0028/*Titulo*/,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,,,"RIGHT")

oSection1:Cell( "COLUNA1" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA2" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA3" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA4" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA5" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA6" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA7" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA8" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA9" ):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA10"):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA11"):lHeaderSize		:= .F.
oSection1:Cell( "COLUNA12"):lHeaderSize		:= .F.
oSection1:Cell( "COLUNAT" ):lHeaderSize		:= .F.

oSection1:SetTotalInLine(.F.)          
oSection1:SetTotalText(STR0011)	//	"T O T A I S  D O  P E R I O D O: "

Return(oReport)     

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Daniel Sakavicius	³ Data ³ 02/09/06 ³±±
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

Local oTotCol1, oTotCol2, oTotCol3, oTotCol4 , oTotCol5 , oTotCol6 ,;
      oTotCol7, oTotCol8, oTotCol9, oTotCol10, oTotCol11, oTotCol12,;
      oTotColTot

Local oTotGrp1,	oTotGrp2, oTotGrp3, oTotGrp4 , oTotGrp5 , oTotGrp6 ,;
      oTotGrp7,	oTotGrp8, oTotGrp9, oTotGrp10, oTotGrp11, oTotGrp12,;
      oTotGrpTot, oBreakGrp

Local aCtbMoeda		:= {}
Local cSeparador	:= ""
Local cPicture
Local cDescMoeda
Local nDivide		:= 1
Local cString		:= "CT1"

Local cCodMasc		:= ""
Local cGrupo		:= ""
Local cArqTmp            
Local dDataIni		:= mv_par01
Local dDataFim 		:= mv_par02

Local lFirstPage	:= .T.
Local lJaPulou		:= .F.
Local lQbGrupo		:= Iif(mv_par11==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par17==1,.T.,.F.)
Local lPula			:= Iif(mv_par16==1,.T.,.F.) 
Local lNormal		:= Iif(mv_par18==1,.T.,.F.)
Local nDecimais

Local cSegmento		:= mv_par12
Local cSegIni		:= mv_par13
Local cSegFim		:= mv_par14
Local cFiltSegm		:= mv_par15
Local cSegAte   	:= mv_par20
Local nDigitAte		:= 0

Local lImpAntLP		:= Iif(mv_par21 == 1,.T.,.F.)
Local dDataLP		:= mv_par22
Local nMeses		:= 0
Local nCont			:= 0
Local nDigitos		:= 0
Local nVezes		:= 0
Local nPos			:= 0 
Local lVlrZerado	:= Iif(mv_par07 == 1,.T.,.F.)
Local lImpSint		:= Iif(mv_par05 = 2,.F.,.T.)
Local cHeader 		:= ""
Local cTpComp		:= If( mv_par25 == 1,"M","S" )	//	Comparativo : "M"ovimento ou "S"aldo Acumulado
Local lAtSlBase		:= Iif(GETMV("MV_ATUSAL")== "S",.T.,.F.)
Local cFilter		:= ""
Local cTipoAnt		:= ""
Local cFilUser		:= ""
Local cDifZero		:= ""
Local cEspaco
Local bCond
Local nMesAux := 0

Local aTamConta		:= {26}	//	TAMSX3("CT1_CONTA" + MV_MASCARA)
Local aTamDesc		:= {20}
Local aTamVal		:= {12}
Local aMeses		:= {}          
Local aPeriodos
Local lPlanilha 	:= .F.

If oReport:nDevice == 4
	lPlanilha := .T.
EndIf 

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf
          

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra tela de aviso - processar exclusivo					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMensagem := STR0017+chr(13)  		//"Caso nao atualize os saldos  basicos  na"
cMensagem += STR0018+chr(13)  		//"digitacao dos lancamentos (MV_ATUSAL='N'),"
cMensagem += STR0019+chr(13)  		//"rodar a rotina de atualizacao de saldos "
cMensagem += STR0020+chr(13)  		//"para todas as filiais solicitadas nesse "
cMensagem += STR0021+chr(13)  		//"relatorio."

IF !lAtSlBase
	IF !MsgYesNo(cMensagem,STR0009)	//"ATEN€ŽO"
		Return
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par06)
	Return
Else
   aSetOfBook := CTBSetOf(mv_par06)
Endif

If mv_par19 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par19 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par19 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

aCtbMoeda  	:= CtbMoeda(mv_par08,nDivide)
If Empty(aCtbMoeda[1])                       
   Help(" ",1,"NOMOEDA")
   Return
Endif

cDescMoeda 	:= Alltrim(aCtbMoeda[2])

If !Empty(aCtbMoeda[6])
	cDescMoeda += STR0007 + aCtbMoeda[6]			// Indica o divisor
EndIf	

nDecimais := DecimalCTB(aSetOfBook,mv_par08)
cPicture  := AllTrim( Right(AllTrim(aSetOfBook[4]),12) )

aPeriodos := ctbPeriodos(mv_par08, mv_par01, mv_par02, .T., .F.)
aSort( aPeriodos,,, {|x,y| DTOS(x[1]) < DTOS(y[1]) } )

For nCont := 1 to len(aPeriodos)       
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If ( Year(mv_par01) == Year(mv_par02) .And. StrZero(Year(aPeriodos[nCont][1]),4)+StrZero(Month(aPeriodos[nCont][1]),2) >= StrZero(Year(mv_par01),4)+StrZero(Month(mv_par01),2) .And. StrZero(Year(aPeriodos[nCont][2]),4)+StrZero(Month(aPeriodos[nCont][2]),2) <= StrZero(Year(mv_par02),4)+StrZero(Month(mv_par02),2) ) .OR. ;
		( Year(aPeriodos[nCont][2]) < Year(mv_par02) .And. StrZero(Year(aPeriodos[nCont][1]),4)+StrZero(Month(aPeriodos[nCont][1]),2) >= StrZero(Year(mv_par01),4)+StrZero(Month(mv_par01),2) ) .OR. ;
		( Year(aPeriodos[nCont][2]) > Year(mv_par01) .And. StrZero(Year(aPeriodos[nCont][2]),4)+StrZero(Month(aPeriodos[nCont][2]),2) <= StrZero(Year(mv_par02),4)+StrZero(Month(mv_par02),2) )

		//Verificação para calendários quinzenais, semanais
		If nMeses > 0 .And. Month( aPeriodos[ nCont ][ 1 ] ) == Month( aPeriodos[ nCont ][ 2 ] )
			nMesAux := Len( aMeses )
			//Mês igual ao anterior, atualiza as datas do array
			If Month( aMeses[ nMesAux ][ 2 ] ) == Month( aMeses[ nMesAux ][ 3 ] ) .And. Month( aMeses[ nMesAux ][ 2 ] ) == Month( aPeriodos[ nCont ][ 2 ] )
				aMeses[ nMesAux ][ 2 ] := Max( Min( aMeses[ nMesAux ][ 2 ] , aPeriodos[ nCont ][ 1 ] ) , mv_par01 )
				aMeses[ nMesAux ][ 3 ] := Min( Max( aMeses[ nMesAux ][ 3 ] , aPeriodos[ nCont ][ 2 ] ) , mv_par02 )
			Else
				nMeses += 1
				If nMeses <= 12
					AADD(aMeses,{StrZero(nMeses,2),Max(aPeriodos[nCont][1],mv_par01),Min(aPeriodos[nCont][2],mv_par02)})	
				EndIf
			EndIf
		Else
			nMeses += 1
			If nMeses <= 12
				AADD(aMeses,{StrZero(nMeses,2),Max(aPeriodos[nCont][1],mv_par01),Min(aPeriodos[nCont][2],mv_par02)})	
			EndIf
		EndIf
	EndIf
Next nCont                                                                   

If nMeses == 0
	cMensagem := STR0022	//"Por favor, verifique se o calend.contabil e a amarracao moeda/calendario "
	cMensagem += STR0023	//"foram cadastrados corretamente..."		
	MsgAlert(cMensagem)
	Return
EndIf

If nMeses > 12
	cMensagem := STR0033  //"Por favor, verifique o periodo informado."
	cMensagem += STR0034  //"Maximo de 12 meses permitido."		
	MsgAlert(cMensagem)
	Return
EndIf                                                      

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
	cCodMasc := ""
Else
	cCodmasc	:= aSetOfBook[2]
	cMascara 	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf     

If !Empty(cSegAte)                
    nDigitAte	:= CtbRelDig(cSegAte,cMascara) 	
EndIf

If !Empty(cSegmento)
	If Empty(mv_par06)
		Help("",1,"CTN_CODIGO")
		Return
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+cCodMasc)
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == cCodMasc
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(val(cSegmento),2)
				nPos -= Val(CTM->CTM_DIGITO)
				nPos ++
				nDigitos := Val(CTM->CTM_DIGITO)      
				Exit
			EndIf	
			dbSkip()
		EndDo	
	Else
		Help("",1,"CTM_CODIGO")
		Return
	EndIf	
EndIf	

// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par25 == 2
	cHeader := "SLD"			/// Indica que deverá obter o saldo na 1ª coluna (Comparativo de Saldo Acumulado)
	mv_par23 := 2				/// NÃO DEVE TOTALIZAR (O ULTIMO PERIODO É A POSICAO FINAL)
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par05 == 1
	Titulo:=	STR0008	//"COMPARATIVO SINTETICO DE "
ElseIf mv_par05 == 2
	Titulo:=	STR0005	//"COMPARATIVO ANALITICO DE "
ElseIf mv_par05 == 3
	Titulo:=	STR0012 //"COMPARATIVO DE "
EndIf

Titulo += 	DTOC(mv_par01) + STR0006 + Dtoc(aMeses[Len(aMeses)][3]) + ;
				STR0007 + cDescMoeda

If mv_par25 == 2
	Titulo += " - "+STR0026
Endif				
If mv_par10 > "1"			
	Titulo += " (" + Tabela("SL", mv_par10, .F.) + ")"
Endif                     

oReport:SetPageNumber( mv_par09 ) // numeração da pagina
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )

DbSelectArea("CT1")
cFilUser := oSection1:GetAdvplExp("CT1")

If Empty(cFilUser)
	cFilUser := ".T."
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If ( !IsBlind() )

	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
				mv_par10,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				.F.,.F.,mv_par11,cHeader,lImpAntLP,dDataLP,nDivide,cTpComp,.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,cString,cFilUser)},;
				STR0015, STR0003)//"Criando Arquivo Tempor rio..."				 	//"Comparativo de Contas Contabeis "

Else

	CTGerComp(, , , ,@cArqTmp,;
				mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par08,;
				mv_par10,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				.F.,.F.,mv_par11,cHeader,lImpAntLP,dDataLP,nDivide,cTpComp,.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,cString,cFilUser)
EndIf

oReport:NoUserFilter()

TRPosition():New(oSection1,"CT1",1,{|| xFilial("CT1")+cArqTmp->CONTA })
If Select("cArqTmp") == 0
	Return
EndIf			
				
dbSelectArea("cArqTmp")
dbGoTop()        

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])                                       
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	Return
Endif

oSection1:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOCONTA == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
								 cTipoAnt := cArqTmp->TIPOCONTA;
							)  })       

cDifZero := " (cArqTmp->COLUNA1  <> 0 .OR. cArqTmp->COLUNA2  <> 0 .OR. cArqTmp->COLUNA3  <> 0 .OR. "
cDifZero += "  cArqTmp->COLUNA4  <> 0 .OR. cArqTmp->COLUNA5  <> 0 .OR. cArqTmp->COLUNA6  <> 0 .OR. "
cDifZero += "  cArqTmp->COLUNA7  <> 0 .OR. cArqTmp->COLUNA8  <> 0 .OR. cArqTmp->COLUNA9  <> 0 .OR. "
cDifZero += "  cArqTmp->COLUNA10 <> 0 .OR. cArqTmp->COLUNA11 <> 0 .OR. cArqTmp->COLUNA12 <> 0)"
							           
If mv_par05 == 1					// So imprime Sinteticas
	cFilter := "cArqTmp->TIPOCONTA  <>  '2'  "
	If !lVlrZerado
		cFilter += " .AND. " + cDifZero
	EndIf
ElseIf mv_par05 == 2				// So imprime Analiticas
	cFilter := "cArqTmp->TIPOCONTA  <>  '1'  "
	If !lVlrZerado
		cFilter += " .AND. " + cDifZero
	EndIf	
EndIf

If !lVlrZerado
	If Empty(cFilter)
		cFilter := cDifZero
	Endif
EndIf

// Verifica Se existe filtragem Ate o Segmento
If ! Empty( cSegAte )
	If !Empty(cFilter)
		cFilter += " .And. "
	EndIf	 	
		 	
	cFilter += ( 'Len(Alltrim(cArqTmp->CONTA)) <= ' + alltrim( Str( nDigitAte )) )  
EndIf	 

oSection1:SetFilter( cFilter )                                                

For nCont := 1 to Len(aMeses)     
	cColVal := "COLUNA"+Alltrim(Str(nCont))
	cDtCab := Strzero(Day(aMeses[nCont][2]),2)+"/"+Strzero(Month(aMeses[nCont][2]),2)+ " - "
	cDtCab += Strzero(Day(aMeses[nCont][3]),2)+"/"+Strzero(Month(aMeses[nCont][3]),2)	

	oSection1:Cell(cColVal):SetTitle(Substr(STR0004,43,07)+" "+Alltrim(Str(nCont)+CRLF+cDtCab))	
Next

For nCont:= Len(aMeses)+1 to 12
	cColVal := "COLUNA"+Alltrim(Str(nCont))
	oSection1:Cell(cColVal):SetTitle(Substr(STR0004,43,07)+" "+Alltrim(Str(nCont))	)
Next       
                                  
//	23-Imprime coluna "Total Periodo" (totalizando por linha)	( 1-Sim )
//  24-Imprime a descricao da conta								( 2-Nao )

IF mv_par23 = 2
	oSection1:Cell("DESCCTA"):SetBlock ( { || (cArqTmp->DESCCTA) })	//	Imprime a Descricao
	oSection1:Cell("CONTA"  ):SetBlock( {|| IF( cArqTmp->TIPOCONTA == "2" .And. mv_par05 <> 2,	cEspaco:=SPACE(02),	cEspaco:="" ),	/*Fazer um recuo nas contas analíticas em relação à sintética*/;
		                                    IF( lNormal,	cEspaco + EntidadeCTB(cArqTmp->CONTA,0,0,70,.F.,cMascara,cSeparador,,,,,.F.),	    /*Se Imprime Codigo Normal da Conta*/;
	       		                                    			IF( cArqTmp->TIPOCONTA == "1",	AllTrim(cArqTmp->CONTA),	cEspaco + AllTrim(cArqTmp->CTARES) ) ) } )	//Conta Sintética
ElseIf mv_par23 = 1 .and. MV_PAR24 = 2
	oSection1:Cell("CONTA"  ):Disable()								//	Desabilita Codigo da Conta
	oSection1:Cell("DESCCTA"):SetBlock ( { || (cArqTmp->DESCCTA) })	//	Imprime a Descricao	       		                                    			
Else
	oSection1:Cell("DESCCTA"):Disable()								//	Desabilita Descricao da Conta
	oSection1:Cell("CONTA"  ):SetBlock( {|| IF( cArqTmp->TIPOCONTA == "2" .And. mv_par05 <> 2,	cEspaco:=SPACE(02),	cEspaco:="" ),	/*Fazer um recuo nas contas analíticas em relação à sintética*/;
   		                                    IF( lNormal,	cEspaco + EntidadeCTB(cArqTmp->CONTA,0,0,70,.F.,cMascara,cSeparador,,,,,.F.),	    /*Se Imprime Codigo Normal da Conta*/;
       		                                    			IF( cArqTmp->TIPOCONTA == "1",	AllTrim(cArqTmp->CONTA),	cEspaco + AllTrim(cArqTmp->CTARES) ) ) } )	//Conta Sintética
EndIf

oSection1:Cell("COLUNA1"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA1 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA2"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA2 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA3"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA3 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA4"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA4 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA5"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA5 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA6"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA6 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA7"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA7 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA8"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA8 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA9"):SetBlock ( { || ValorCTB(cArqTmp->COLUNA9 ,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA10"):SetBlock( { || ValorCTB(cArqTmp->COLUNA10,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA11"):SetBlock( { || ValorCTB(cArqTmp->COLUNA11,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
oSection1:Cell("COLUNA12"):SetBlock( { || ValorCTB(cArqTmp->COLUNA12,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.,,,lPlanilha) } )
           
//	Imprime coluna "Total Periodo" (totalizando por linha)
If mv_par23 == 1
	oSection1:Cell("COLUNAT"):SetBlock( { || ValorCTB(cArqTmp->(COLUNA1+COLUNA2+COLUNA3+;
	                                                            COLUNA4+COLUNA5+COLUNA6+;
	                                                            COLUNA7+COLUNA8+COLUNA9+;
	                                                            COLUNA10+COLUNA11+COLUNA12),,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTmp->NORMAL, , , , , ,lPrintZero,.F.,,,lPlanilha) } )
Else
	oSection1:Cell("COLUNAT"):Disable()
Endif


bCond := {|| Iif( cArqTmp->TIPOCONTA="1"/*Conta Sintetica*/, IF( mv_par05 <> 1	/*Analiticas ou ambas*/,;
                                                                 .F.,;
                                                                 IF(cArqTmp->NIVEL1 /*Maior Conta superiora*/,.T.,.F.) ),;
                                                             .T. ) }


// Quebra por Grupo
If lQbGrupo

	//Totais do Grupo
	oBreakGrp := TRBreak():New(oSection1, { || cArqTmp->GRUPO },{|| STR0016+" "+ RTrim( Upper(AllTrim(cGrupo) )) + " )" },,,.F.)	//	"T O T A I S  D O  G R U P O ("
	oBreakGrp:OnBreak( { |x| cGrupo := x } )

	oTotGrp1 := TRFunction():New(oSection1:Cell("COLUNA1"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA1, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp2 := TRFunction():New(oSection1:Cell("COLUNA2"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA2, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp3 := TRFunction():New(oSection1:Cell("COLUNA3"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA3, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp4 := TRFunction():New(oSection1:Cell("COLUNA4"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA4, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp5 := TRFunction():New(oSection1:Cell("COLUNA5"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA5, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp6 := TRFunction():New(oSection1:Cell("COLUNA6"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA6, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp7 := TRFunction():New(oSection1:Cell("COLUNA7"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA7, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp8 := TRFunction():New(oSection1:Cell("COLUNA8"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA8, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp9 := TRFunction():New(oSection1:Cell("COLUNA9"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA9, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp10 := TRFunction():New(oSection1:Cell("COLUNA10"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA10, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp11 := TRFunction():New(oSection1:Cell("COLUNA11"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA11, 0 ) },.F.,.F.,.F.,oSection1)

	oTotGrp12 := TRFunction():New(oSection1:Cell("COLUNA12"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->COLUNA12, 0 ) },.F.,.F.,.F.,oSection1)

	If lIsRedStor
		TRFunction():New(oSection1:Cell("COLUNA1"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp1:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA1"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp1:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA2"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp2:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA2"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp2:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA3"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp3:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA3"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp3:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA4"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp4:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA4"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp4:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA5"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp5:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA5"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp5:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA6"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp6:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA6"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp6:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA7"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp7:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA7"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp7:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif


	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA8"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp8:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA8"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp8:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA9"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp9:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA9"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp9:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA10"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp10:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA10"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp10:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA11"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp11:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA11"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp11:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	If lIsRedStor	
		TRFunction():New(oSection1:Cell("COLUNA12"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || StrTran(ValorCTB(oTotGrp12:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNA12"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
			{ || ValorCTB(oTotGrp12:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
	Endif

	//	Imprime coluna "Total Periodo" (totalizando por linha)
	If mv_par23 == 1
		oTotGrpTot := TRFunction():New(oSection1:Cell("COLUNAT"),,"SUM",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	                             { || If( Eval(bCond), cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+;
                                                                 COLUNA5+COLUNA6+COLUNA7+COLUNA8+;
                                                                 COLUNA9+COLUNA10+COLUNA11+COLUNA12), 0 ) },.F.,.F.,.F.,oSection1)
        If lIsRedStor
        	TRFunction():New(oSection1:Cell("COLUNAT"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
        	{ || StrTran(ValorCTB(oTotGrpTot:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.F.,.F.,oSection1 )
        Else
        	TRFunction():New(oSection1:Cell("COLUNAT"),,"ONPRINT",oBreakGrp/*oBreak*/,/*Titulo*/,/*cPicture*/,;
        	{ || ValorCTB(oTotGrpTot:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.F.,.F.,oSection1 )
        Endif	

		oTotGrpTot:Disable()
	EndIf

	oTotGrp1:Disable()
	oTotGrp2:Disable()
	oTotGrp3:Disable()
	oTotGrp4:Disable()
	oTotGrp5:Disable()
	oTotGrp6:Disable()
	oTotGrp7:Disable()
	oTotGrp8:Disable()
	oTotGrp9:Disable()
	oTotGrp10:Disable()
	oTotGrp11:Disable()
	oTotGrp12:Disable()
EndIf


// Total
oTotCol1  := TRFunction():New(oSection1:Cell("COLUNA1"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA1, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol2  := TRFunction():New(oSection1:Cell("COLUNA2"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA2, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol3  := TRFunction():New(oSection1:Cell("COLUNA3"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA3, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol4  := TRFunction():New(oSection1:Cell("COLUNA4"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA4, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol5  := TRFunction():New(oSection1:Cell("COLUNA5"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA5, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol6  := TRFunction():New(oSection1:Cell("COLUNA6"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA6, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol7  := TRFunction():New(oSection1:Cell("COLUNA7"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA7, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol8  := TRFunction():New(oSection1:Cell("COLUNA8"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA8, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol9  := TRFunction():New(oSection1:Cell("COLUNA9"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA9, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol10 := TRFunction():New(oSection1:Cell("COLUNA10"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA10, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol11 := TRFunction():New(oSection1:Cell("COLUNA11"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA11, 0 ) },.F.,.T.,.F.,oSection1)
oTotCol12 := TRFunction():New(oSection1:Cell("COLUNA12"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                             { || If( Eval(bCond), cArqTmp->COLUNA12, 0 ) },.F.,.T.,.F.,oSection1)

//	Imprime coluna "Total Periodo" (totalizando por linha)
If mv_par23 == 1
	oTotColTot := TRFunction():New(oSection1:Cell("COLUNAT"),,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
                                   { || If( Eval(bCond), cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6+;
                                                                   COLUNA7+COLUNA8+COLUNA9+COLUNA10+COLUNA11+COLUNA12), 0 ) },.F.,.T.,.F.,oSection1)
EndIf
                                                                     
If lIsRedStor                                                                      
	TRFunction():New(oSection1:Cell("COLUNA1"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol1:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA1"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol1:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA2"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol2:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA2"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol2:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA3"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol3:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA3"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol3:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA4"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol4:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA4"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol4:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA5"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol5:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA5"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol5:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA6"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol6:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA6"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol6:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA7"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol7:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA7"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol7:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA8"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol8:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA8"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol8:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA9"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol9:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA9"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol9:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA10"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol10:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA10"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol10:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA11"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol11:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA11"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol11:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif

If lIsRedStor	
	TRFunction():New(oSection1:Cell("COLUNA12"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotCol12:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
Else
	TRFunction():New(oSection1:Cell("COLUNA12"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotCol12:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
Endif
// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par23 == 1
	If lIsRedStor
		TRFunction():New(oSection1:Cell("COLUNAT"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(oTotColTot:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.F.,.T.,.F.,oSection1 )
	Else
		TRFunction():New(oSection1:Cell("COLUNAT"),,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(oTotColTot:GetValue(),,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.,,,lPlanilha) },.F.,.T.,.F.,oSection1 )
	Endif
EndIf

oTotCol1:Disable()
oTotCol2:Disable()
oTotCol3:Disable()
oTotCol4:Disable()
oTotCol5:Disable()
oTotCol6:Disable()
oTotCol7:Disable()
oTotCol8:Disable()
oTotCol9:Disable()
oTotCol10:Disable()
oTotCol11:Disable()
oTotCol12:Disable()

// Comparar "1-Mov. Periodo" / "2-Saldo Acumulado"
If mv_par23 == 1
	oTotColTot:Disable()
EndIf
                     
oReport:SetTotalInLine(.F.)	
oReport:SetTotalText(STR0011)	//	"T O T A I S  D O  P E R I O D O: "
oSection1:Print()

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea() 
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF	

Return


/*/{Protheus.doc} SchedDef
Uso - Execucao da rotina via Schedule.

Permite usar o botao Parametros da nova rotina de Schedule
para definir os parametros(SX1) que serao passados a rotina agendada.

@return  aParam
/*/

Static Function SchedDef()

Local aParam := {}

aParam := {	"R",;		//Tipo R para relatorio P para processo
			"CTR265",;	//Nome do grupo de perguntas (SX1)
			nil	,;		//cAlias (para Relatorio)
			nil	,;		//aArray (para Relatorio)
			nil}		//Titulo (para Relatorio)

Return aParam