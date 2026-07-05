/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR185.Ch"
#Include "PROTHEUS.Ch"
#DEFINE TAM_VALOR 21

// 17/08/2009 -- Filial com mais de 2 caracteres

//-------------------------------------RELEASE 4------------------------------------//

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR185   ºAutor  ³Paulo Carnelossi    º Data ³  04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Balancete Centro de Custo/Conta/Item                        º±±
±±º          ³Release 4                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CtbR185()
Private NomeProg := FunName()

U_CTBR185R4()

//Limpa os arquivos temporários 
CTBGerClean()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR185   ºAutor  ³Paulo Carnelossi    º Data ³  04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Balancete Centro de Custo/Conta/Item                        º±±
±±º          ³Release 4                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CtbR185R4()
Local aArea := GetArea()

Local nQuadro

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

Private aQuadro := { "","","","","","","",""}              

For nQuadro :=1 To Len(aQuadro)
	aQuadro[nQuadro] := Space(Len(CriaVar("CT1_CONTA")))
Next

CtbCarTxt()

Pergunte("CTR185",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					  	   	³
//³ mv_par01				// Data Inicial              	       	³
//³ mv_par02				// Data Final                          	³
//³ mv_par03				// Conta Inicial                       	³
//³ mv_par04				// Conta Final  					   	³
//³ mv_par05				// Do Centro de Custo                  	³
//³ mv_par06				// Ate Centro de Custo                 	³
//³ mv_par07				// Do Item                             	³
//³ mv_par08				// Ate o Item                          	³
//³ mv_par09				// Imprime Contas: Sintet/Analit/Ambas 	³
//³ mv_par10				// Configuracao de Livros			  	³	
//³ mv_par11				// Moeda?          			     	   	³
//³ mv_par12				// Pagina Inicial  		     		   	³
//³ mv_par13				// Saldos? Reais / Orcados	/Gerenciais	³
//³ mv_par14				// Quebra por Grupo Contabil?		   	³
//³ mv_par15				// Imprimir ate o Segmento?			   	³
//³ mv_par16				// Filtra Segmento?					   	³
//³ mv_par17				// Conteudo Inicial Segmento?		   	³
//³ mv_par18				// Conteudo Final Segmento?		       	³
//³ mv_par19				// Conteudo Contido em?				   	³
//³ mv_par20				// Imprime Coluna Mov ?				   	³
//³ mv_par21				// Pula Pagina                         	³
//³ mv_par22				// Salta linha sintetica ?			    ³
//³ mv_par23				// Imprime valor 0.00    ?			    ³
//³ mv_par24				// Imprimir CC?Normal / Reduzido       	³
//³ mv_par25				// Imprimir Item?Normal / Reduzido		³                                                                     
//³ mv_par26				// Divide por ?                   		³                                                                     
//³ mv_par27				// Posicao Ant. L/P? Sim / Nao         	³
//³ mv_par28 				// Data Lucros/Perdas?                	³
//³ mv_par29 				// Impr. Quadros Demonstrativos?      	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf	

oReport:PrintDialog()

RestArea(aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Carnelossi    º Data ³  04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Balancete Centro de Custo/Conta/Item                        º±±
±±º          ³Definicao das secoes - mRelease 4                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()
Local cPerg			:= "CTR185"
Local cSayCC		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cString		:= "CT1"
Local cTitulo 		:= STR0003+ Upper(cSayCC)+ " / " +  Upper(STR0021)+" / "+Upper(cSayItem)	//"Balancete de Verificacao  / Conta / "
Local cDesc1 		:= STR0001+ Upper(cSayCC)+ " / " + Upper(STR0021)+" / "+Upper(cSayItem	) //"Este programa ira imprimir o Balancete de  / Conta  / "
Local cDesc2 		:= STR0002  //"de acordo com os parametros solicitados pelo Usuario"
Local cDesc3 		:= ""


Local oReport
Local oCC
Local oItemCtb
Local nX
Local aOrdem := {}


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := TReport():New("CTBR185",cTitulo, cPerg, ;
			{|oReport| If(!ct040Valid(mv_par10), oReport:CancelPrint(), ReportPrint(oReport, cSayCC, cSayItem, cString, cTitulo))},;
			cDesc1+CRLF+cDesc2+CRLF+cDesc3 )

oReport:SetLandScape()

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

oCC := TRSection():New(oReport, Capital(cSayCC), { "cArqTmp", "CTT" }, aOrdem /*{}*/, .F., .F.)  //"Item Contabil"
TRCell():New(oCC, "CTT_CUSTO"	,"CTT",Capital(STR0040+"  "+cSayCC)/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Codigo"###"Centro de Custo"
TRCell():New(oCC, "CTT_DESC01"	,"CTT",Capital(STR0041)/*Titulo*/,/*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Descricao"
oCC:Cell("CTT_DESC01"):SetLineBreak()
oCC:SetLineStyle()
oCC:SetNoFilter({ "cArqTmp", "CTT" })

oItemCtb := TRSection():New(oReport, Capital(Alltrim(STR0021)), { "cArqTmp", "CTD", "CT1"}, aOrdem /*{}*/, .F., .F.)  //"Item Contabil"

TRCell():New(oItemCtb,	"CT1_CONTA"		,"CT1"	,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) 
TRCell():New(oItemCtb,	"CT1_RES"		,"CT1"	,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  
TRCell():New(oItemCtb,	"CTD_ITEM"		,"CTD"	,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  
TRCell():New(oItemCtb,	"CTD_DESC01"	,"CTD"	,Capital(STR0041)/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Descricao"
TRCell():New(oItemCtb,	"SALDO_ANT"		,""		,Capital(STR0042)/*Titulo*/,/*Picture*/,TAM_VALOR+2/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")  //"Saldo Anterior"
TRCell():New(oItemCtb,	"DEBITO"		,""		,Capital(STR0043)/*Titulo*/,/*Picture*/,TAM_VALOR+2/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT") //"Debito"
TRCell():New(oItemCtb,	"CREDITO"		,""		,Capital(STR0044)/*Titulo*/,/*Picture*/,TAM_VALOR+2/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")  //"Credito"
TRCell():New(oItemCtb,	"MOV_PERIODO"	,""		,Capital(STR0045)/*Titulo*/,/*Picture*/,TAM_VALOR+2/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT") //"Mov.Periodo"
TRCell():New(oItemCtb,	"SALDO_ATUAL"	,""		,Capital(STR0046)/*Titulo*/,/*Picture*/,TAM_VALOR+2/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT") //"Saldo Atual"
oItemCtb:SetHeaderPage() 
oItemCtb:SetLinesBefore(0)
oItemCtb:SetNoFilter({ "cArqTmp", "CTD", "CTT"})

oItemCtb:Cell("MOV_PERIODO"):Disable()
oItemCtb:Cell("CTD_DESC01"):SetLineBreak()
oItemCtb:OnPrintLine({||If( (mv_par22=1)/*lPula*/.And. cArqTmp->TIPOCONTA=="1", oReport:SkipLine(),NIL) })

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor  ³Paulo Carnelossi   º Data ³ 04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Balancete Centro de Custo/Conta/Item                        º±±
±±º          ³Release 4                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint(oReport, cSayCC, cSayItem, cString, cTitulo)
Local oCC		:= oReport:Section(1)
Local oItemCtb	:= oReport:Section(2)

Local nDivide := 1
Local CbTxt			:= Space(10)
Local CbCont		:= 0
Local tamanho		:= "G"
Local limite		:= 220
Local cabec1  		:= ""
Local cabec2		:= ""

Local aColunas

Local cSepara1  	:= ""
Local cSepara2      := ""
Local cSepara3		:= ""
Local cPicture
Local cDescMoeda
Local cMascara1
Local cMascara2          
Local cMascara3
Local cGrupo		:= ""
Local cItemAnt		:= ""
Local cItemRes		:= ""
Local cSegAte   	:= mv_par15
Local cArqTmp		:= ""
Local cCCSup		:= ""//Centro de Custo Superior do centro de custo atual
Local cAntCCSup		:= ""//Centro de Custo Superior do centro de custo anterior
Local lCCNormal		:= Iif(mv_par24 == 1,.T.,.F.)

Local dDataLP		:= mv_par28
Local dDataFim		:= mv_par02

Local lImpAntLP		:= Iif(mv_par27 == 1,.T.,.F.)
Local lFirstPage	:= .T.
Local lPula			:= Iif(mv_par22==1,.T.,.F.) 
Local lJaPulou		:= .F.
Local lPrintZero	:= Iif(mv_par23==1,.T.,.F.)
Local lImpMov		:= .F.
Local lSaltaPag		:= .F.
Local lPulaPag		:= Iif(mv_par21==1,.T.,.F.)

Local nDecimais
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotMov		:= 0
Local nCCTMov 		:= 0
Local nTotCCDeb		:= 0
Local nTotCCCrd		:= 0
Local nCCSldAnt		:= 0
Local nCCSldAtu		:= 0
Local nTotSldAnt	:= 0
Local nTotSldAtu	:= 0
Local nDigitAte		:= 0
Local nDigCCAte		:= 0
Local nRegTmp		:= 0	
Local n
Local oBreak, oBreakGrupo
Local oTotDebito, oTotCredito, oTotMovPer
Local oImpDebito, oImpCredito, oImpMovPer
Local bLineCondition := {|| R185FilImp(cSegAte, nDigitAte) }

Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.) // Parameter to activate Red Storn



aSetOfBook := CTBSetOf(mv_par10)

If mv_par26 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par26 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par26 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

aCtbMoeda  	:= CtbMoeda(mv_par11,nDivide)
If Empty(aCtbMoeda[1])                       
	Help(" ",1,"NOMOEDA")
	oReport:CancelPrint()
	Return
Endif

cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par11)

// Mascara do Centro de Custo
If Empty(aSetOfBook[6])
	cMascara1 := GetMv("MV_MASCCUS")
Else
	cMascara1 := RetMasCtb(aSetOfBook[6],@cSepara1)
EndIf

//Mascara da Conta
If Empty(aSetOfBook[2])
	cMascara2 := GetMv("MV_MASCARA")
Else
	cMascara2 	:= RetMasCtb(aSetOfBook[2],@cSepara2)
EndIf             

//Mascara do Item 
If !Empty(aSetOfBook[7])
	cMascara3	:= RetMasCtb(aSetOfBook[7],@cSepara3)
Else
	cMascara3	:= ""
EndIf          

cPicture 		:= aSetOfBook[4]

lImpMov	:= Iif(mv_par20 == 1,.T.,.F.)

If lImpMov
	cabec1 	:= STR0004  //"|  CODIGO              | COD. REDUZIDO |   
	cabec1	+= SPACE(5)+ UPPER(cSayItem) +SPACE(5)
	cabec1	+= STR0005  //"|  D E S C R I C A O                          |    SALDO ANTERIOR              |    DEBITO       |      CREDITO      |    MOVIMENTO DO PERIODO       |         SALDO ATUAL               |"
Else
	cabec1 	:= STR0004  //"|  CODIGO              | COD. REDUZIDO |   
	cabec1	+= SPACE(5)+UPPER(cSayItem)+SPACE(5) 
	cabec1	+= STR0012  //"|  D E S C R I C A O                          |    SALDO ANTERIOR              |    DEBITO       |      CREDITO      |    SALDO ATUAL               |"
EndIf             

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par09 == 1
	cTitulo:=	STR0006 + Upper(cSayCC) + "/" + Upper(STR0021) + "/" + Upper(cSayItem) //"BALANCETE ANALITICO DE  "
ElseIf mv_par09 == 2
	cTitulo:=	STR0007 + Upper(cSayCC) + "/" + Upper(STR0021) + "/" + Upper(cSayItem) //"BALANCETE SINTETICO DE  "
ElseIf mv_par09 == 3
	cTitulo:=	STR0008 + Upper(cSayCC)	+  "/" + Upper(STR0021) + "/" + Upper(cSayItem) //"BALANCETE DE  "
EndIf

cTitulo += 	STR0009 + DTOC(mv_par01) + STR0010 + Dtoc(mv_par02) + 	STR0011 + cDescMoeda

If mv_par13 > "1"
	cTitulo += " (" + Tabela("SL", mv_par13, .F.) + ")"
EndIf

If nDivide > 1			
	cTitulo += " (" + STR0022 + Alltrim(Str(nDivide)) + ")"
EndIf	

oReport:SetTitle(cTitulo)
oReport:SetPageNumber(mv_par12)
oReport:SetCustomText({|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao					     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

MsgMeter({|	oMeter, oText, oDlg, lEnd | ;                        
			CTGerPlan(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			mv_par01,mv_par02,"CT4","",mv_par03,mv_par04,mv_par05,mv_par06,mv_par07,mv_par08,,,mv_par11,;
			mv_par13,aSetOfBook,mv_par16,mv_par17,mv_par18,mv_par19,;
			.F.,.T.,,"CTT",lImpAntLP,dDataLP, nDivide,.F.,,,,,,,,,,,,,,,oItemCtb:GetAdvplExp("CT1")/*aReturn[7]*/,,,,.T.)},;
			(STR0014),;  //"Criando Arquivo Tempor rio..."
			(STR0003)+Upper(cSayCC)+ " / "+Upper(STR0021)+ " / " + Upper(cSayItem))      //"Balancete Verificacao "
			

// Verifica Se existe filtragem Ate o Segmento
 If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara1) 	
EndIf		

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()        

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])                                       
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	oReport:CancelPrint()
	Return
Endif

oReport:SetMeter(RecCount())

oCC:Cell("CTT_CUSTO")			:SetBlock( {|| If(lCCNormal .or. cArqTMP->TIPOCC == "1", EntidadeCTB(cArqTMP->CUSTO,,,30,.F.,cMascara1,cSepara1,,,,,.F.), EntidadeCTB(cArqTMP->CCRES,,,,.F.,cMascara1,cSepara1,,,,,.F.) ) })
oCC:Cell("CTT_DESC01")			:SetBlock( {|| cArqTMP->DESCCC })

oItemCtb:Cell("CT1_CONTA")		:SetBlock( {|| If(Empty(cArqTMP->ITEM), EntidadeCTB(cArqTMP->CONTA,,,30,.F.,cMascara2,cSepara2,,,,,.F.), "") } )
oItemCtb:Cell("CT1_RES")		:SetBlock( {|| If(Empty(cArqTMP->ITEM), cArqTMP->CTARES, "") } )
oItemCtb:Cell("CTD_ITEM")		:SetBlock( {|| If(mv_par25 == 1 .or. cArqTMP->TIPOITEM == "1", ;
											EntidadeCTB(cArqTMP->ITEM,,,,.F.,cMascara3,cSepara3,,,,,.F.)	 , ;
											EntidadeCTB(cArqTMP->ITEMRES,,,,.F.,,,cSepara1,,,,.F.) ) } )
oItemCtb:Cell("CTD_DESC01")		:SetBlock( {|| If(!Empty(cArqTMP->ITEM), Substr(cArqTMP->DESCITEM,1,31)	, Substr(cArqTMP->DESCCTA,1,31) ) })
oItemCtb:Cell("SALDO_ANT")		:SetBlock( {|| ValorCTB(cArqTMP->SALDOANT,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTMP->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) })
oItemCtb:Cell("DEBITO")			:SetBlock( {|| ValorCTB(cArqTMP->SALDODEB,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTMP->NORMAL, , , , , ,lPrintZero,.F./*lSay*/,lColDbCr) })
oItemCtb:Cell("CREDITO")		:SetBlock( {|| ValorCTB(cArqTMP->SALDOCRD,,,TAM_VALOR,nDecimais,.F.,cPicture,cArqTMP->NORMAL, , , , , ,lPrintZero,.F./*lSay*/,lColDbCr) })
oItemCtb:Cell("MOV_PERIODO")	:SetBlock( {|| ValorCTB(cArqTMP->MOVIMENTO,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTMP->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) })
oItemCtb:Cell("SALDO_ATUAL")	:SetBlock( {|| ValorCTB(cArqTMP->SALDOATU,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cArqTMP->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) })

If lImpMov
	oItemCtb:Cell("MOV_PERIODO"):Enable()
EndIf

If mv_par14 == 1				// Grupo Diferente
	oBreakGrupo := TRBreak():New(oCC, {|| cArqTMP->GRUPO },{||Capital(STR0047)+" : "+cGrupo })  //"Grupo"
	oBreakGrupo:SetPageBreak()
EndIf

oBreak:= TRBreak():New(oItemCtb,{||.T.},	{|| Capital(STR0020+cSayCC)+" : " +;
												 If(lCCNormal .or. cArqTMP->TIPOCC == "1", ;
															EntidadeCTB(cCCAnt,,,40,.F.,cMascara1,cSepara1,,,,,.F.) , ;
															EntidadeCTB(cCCAntRes,,,40,.F.,cMascara1,cSepara1,,,,,.F.)	) } )
//Para pular de pagina quando centro de custo for diferente
If lPulaPag
	oBreak:SetPageBreak(.T.)
Endif

//totalizadores acumuladores 
oTotDebito		:=TRFunction():New(oItemCtb:Cell("DEBITO")		, Capital(STR0043), "SUM",oBreak,/*cTitle*/,/*cPicture*/,{||R185RetVlrCol("SALDODEB")}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Debito"
oTotCredito		:=TRFunction():New(oItemCtb:Cell("CREDITO")	, Capital(STR0044), "SUM",oBreak,/*cTitle*/,/*cPicture*/,{||R185RetVlrCol("SALDOCRD")}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Credito"
If lRedStorn
	oTotMovPer		:=TRFunction():New(oItemCtb:Cell("MOV_PERIODO"), Capital(STR0045), "SUM",oBreak,/*cTitle*/,/*cPicture*/,{|| RedStorTt(R185RetVlrCol("SALDODEB"),R185RetVlrCol("SALDOCRD"),,,"T")}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Mov.Periodo"
Else
	oTotMovPer		:=TRFunction():New(oItemCtb:Cell("MOV_PERIODO"), Capital(STR0045), "SUM",oBreak,/*cTitle*/,/*cPicture*/,{||R185RetVlrCol("SALDOCRD")-R185RetVlrCol("SALDODEB")}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Mov.Periodo"
Endif	
oTotDebito		:Disable()
oTotCredito		:Disable()
oTotMovPer		:Disable()
//totalizadores para impressao
oImpDebito		:=TRFunction():New(oItemCtb:Cell("DEBITO")		, Capital(STR0043), "ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Debito"
oImpCredito		:=TRFunction():New(oItemCtb:Cell("CREDITO")	, Capital(STR0044), "ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Credito"
oImpMovPer		:=TRFunction():New(oItemCtb:Cell("MOV_PERIODO"), Capital(STR0045), "ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Mov.Periodo"
oImpDebito		:SetFormula( {|| ValorCTB(oTotDebito:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr) } )
oImpCredito		:SetFormula( {|| ValorCTB(oTotCredito:GetValue(),,,TAM_VALOR,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr) } )

If lRedStorn
	oImpMovPer		:SetFormula( {|| nTotMov := oTotMovPer:GetValue(), ValorCTB(nTotMov,,,TAM_VALOR-2,nDecimais,.T.,cPicture,Iif(nTotMov<0,"1","2"), , , , , ,lPrintZero,.F./*lSay*/,lColDbCr) } )
Else
	oImpMovPer		:SetFormula( {|| nTotMov := oTotMovPer:GetValue(), If(Round(NoRound(nTotMov,3),2) < 0, ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/), If(Round(NoRound(nTotMov,3),2) > 0,ValorCTB(nTotMov,,,21,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero,.F./*lSay*/),"")) } )
Endif	

cCCAnt := cArqTmp->CUSTO
cGrupo := cArqTmp->GRUPO
dbSelectArea("cArqTmp")

oCC:Init()

While !Eof()

	If oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()
		
	cCCAnt 		:= cArqTmp->CUSTO
	cCCAntRes 	:= cArqTmp->CCRES
	
	If ! Eval(bLineCondition)
		cArqTmp->(dbSkip())
		Loop
	EndIf	
		
	oCC:PrintLine()
   
	oItemCtb:Init()
	
	While !Eof() .And. cCCAnt == cArqTmp->CUSTO

		If ! Eval(bLineCondition)
			cArqTmp->(dbSkip())
			Loop
		EndIf	

      	oItemCtb:PrintLine()

		cArqTmp->(dbSkip())
		
    EndDo
    
    oItemCtb:Finish()

	nTotCCDeb := 0
	nTotCCCrd := 0                     
		
     	nRegTmp	:= cArqTmp->(Recno())	

	If mv_par29 ==1    
		oItemCtb:SetHeaderSection(.F.)
		oReport:EndPage()
		U_Ctb185_ImpQ(oReport, Tamanho,X3USO("CT2_DCD"),dDataFim,mv_par11,aQuadro,cDescMoeda,nomeprog,(If (lImpAntLP,dDataLP,cTod(""))),cPicture,nDecimais,lPrintZero,mv_par13,cCCAnt,cMascara2,cSepara2)
		oReport:EndPage()
		oItemCtb:SetHeaderSection(.T.)
	EndIf 

	dbSelectArea("cArqTmp")
	dbGoto(nRegTmp)	            			

EndDO                           

oCC:Finish()

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()

If Select("cArqTmp") == 0
	Ferase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
EndIf	

dbselectArea("CT2")

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o	  ³Ctb185_ImpQ ³ Autor ³ Simone Mie Sato	 ³ Data ³ 13/08/04 ³±±
±±³       	  ³            ³       ³ Paulo Carnelossi(R4)³      ³ 05/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Impressao dos Quadros finais do balancete                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³U_Ctb185_ImpQ()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		  ³ SIGACTB 												   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctb185_ImpQ(oReport, Tamanho,lDigVer,dData,cMoeda,aQuadro,cDescMoeda,nomeprog,dDataLP,cPicture,nDecimais,lPrintZero,cTpSald,cCusto,cMascara2,cSepara2)

Local aSaveArea	:= GetArea()
Local cData 	:=	StrZero(Month(dData),2) +"/" + Str(Year(dData),4)
Local nTotMov	:=	0
Local nResult	:=	0
Local nPtmCorr := 0
Local nPtmLiq  := 0
Local nReceita := 0
Local nDespesa := 0
Local nVal1		:= 0
Local nVal2		:= 0
Local nRectmp	:= 0
Local bSepara 	:= {|x, y| oReport:PrintText("|", x, y), oReport:SkipLine() }
Local lColDbCr 		:= IIf(cPaisLoc $ "RUS",.T.,.F.) // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local lRedStorn		:= IIf(cPaisLoc $ "RUS",SuperGetMV("MV_REDSTOR",.F.,.F.),.F.) // Parameter to activate Red Storn

oReport:PrintText(STR0023) // "QUADROS DEMONSTRATIVOS"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quadro 1: Totais do Ativo / Passivo.                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
oReport:ThinLine()
Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

oReport:PrintText(STR0024, oReport:Row(), 1400)  //"TOTAIS DO ATIVO / PASSIVO"

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

oReport:ThinLine()
Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

DbSelectArea("CT1")
dbSeek( xFilial("CT1") +  aQuadro[1] ) // Totalizadora do Ativo - mv _par08
Eval(bSepara, oReport:Row(), 10)

If lDigVer 
	oReport:PrintText(EntidadeCTB(aQuadro[1],,,,.F.,cMascara2,cSepara2,,,,,.F.), oReport:Row(), 50)
Else                                                     
	oReport:PrintText(EntidadeCTB(CT1->CT1_CONTA,,,28,.F.,cMascara2,cSepara2,,,,,.F.), oReport:Row(), 50)
EndIf	

oReport:PrintText(STR0025, oReport:Row(), 350) // "Total do Ativo"

dbSelectArea("cArqTmp")
dbSetOrder(1)
nRecTmp	:= Recno()

MsSeek(cCusto+aQuadro[1])
If lRedStorn
	nTotMov := cArqTmp->SALDOANT + Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)
Else	
	nTotMov	:= cArqTMP->SALDOATU
Endif
oReport:PrintText(ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)

dbGoto(nRecTmp)	

Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

DbSelectArea("CT1")
MsSeek( xFilial("CT1")+ aQuadro[2]) // Totalizadora do Passivo - mv_par09
Eval(bSepara, oReport:Row(), 10)

If lDigVer 
	oReport:PrintText(EntidadeCTB(Alltrim(CT1->CT1_CONTA+CT1->CT1_DC),,,28,.F.,cMascara2,cSepara2,,,,,.F.), oReport:Row(), 50)
Else
	oReport:PrintText(EntidadeCTB(Alltrim(CT1->CT1_CONTA),,,28,.F.,cMascara2,cSepara2,,,,,.F.), oReport:Row(), 50)
EndIf

oReport:PrintText(STR0026, oReport:Row(), 350) // "Total do Passivo"

dbSelectArea("cArqTmp")
dbSetOrder(1)
nRecTmp	:= Recno()
If MsSeek(cCusto+aQuadro[2])
	If lRedStorn
		nTotMov := cArqTmp->SALDOANT + Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)
	Else	
		nTotMov	:= cArqTMP->SALDOATU
	Endif
	oReport:PrintText(ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
EndIf	         

Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

dbGoto(nRecTmp)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)
oReport:ThinLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quadro 2: Demonstracao de resultados                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
oReport:SkipLine()
oReport:ThinLine()
Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

oReport:PrintText(STR0027, oReport:Row(), 1400)  // "DEMONSTRATIVO DE RESULTADOS - MENSAL"

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)
oReport:ThinLine()
Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

DbSelectArea("CT1")
dbSeek( xFilial("CT1") + aQuadro[3] ) // Resultado a debito

Eval(bSepara, oReport:Row(), 10)

If lDigVer 
	oReport:PrintText(EntidadeCTB(Alltrim(CT1->CT1_CONTA+CT1->CT1_DC),,,28,.F.,cMascara2,cSepara2,,,,,.F.), oReport:Row(), 50)
Else
	oReport:PrintText(EntidadeCTB(CT1->CT1_CONTA,,,28,.F.,cMascara2,cSepara2,,,,,.F.), oReport:Row(), 50)
EndIf	

oReport:PrintText(OemToAnsi(STR0028)  + OemToAnsi(STR0039), oReport:Row(), 400) // "CONTAS DE RESULTADO - "

DbSelectArea("cArqTmp")
DbSetOrder(1)
If MsSeek(cCusto+aQuadro[3])
	If lRedStorn
		nTotMov	:= Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)
		nVal1	:= cArqTmp->SALDOANT + Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)		
	Else	
		nTotMov	:= cArqTMP->MOVIMENTO
		nVal1 	:= cArqTMP->SALDOATU
	Endif
	oReport:PrintText(ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
Endif	
nResult := nTotMov

Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

DbSelectArea("CT1")
MsSeek( xFilial("CT1") + aQuadro[4] ) // Resultado a credito

Eval(bSepara, oReport:Row(), 10)
If lDigVer 
	oReport:PrintText(EntidadeCTB(Alltrim(CT1->CT1_CONTA+CT1->CT1_DC),,,28,.F.,cMascara2,cSepara2,,,,,.F.), oReport:Row(), 50)
Else
	oReport:PrintText(EntidadeCTB(CT1->CT1_CONTA,,,28,.F.,cMascara2,cSepara2,,,,,.F.), oReport:Row(), 50)
EndIf	

oReport:PrintText(STR0028  + STR0029, oReport:Row(), 400) // "CONTAS DE RESULTADO - "

DbSelectArea("cArqTmp")
DbSetOrder(1)
If MsSeek(cCusto+aQuadro[4])
	If lRedStorn
		nTotMov	:= Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)
		nVal2	:= cArqTmp->SALDOANT + Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)		
	Else	
		nTotMov	:= cArqTMP->MOVIMENTO
		nVal2 	:= cArqTMP->SALDOATU
	Endif
Else
	nTotMov	:= 0 
Endif                  
oReport:PrintText(ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)

nResult	+= nTotMov

DbSelectArea("CT1")
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)
Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(STR0030 + cData, oReport:Row(), 50) // "RESULTADO DO MES "

oReport:PrintText(ValorCTB(nResult,,,TAM_VALOR,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(STR0031 + cData, oReport:Row(), 50) // "RESULTADO ACUMULADO ATE "

nTotMov	:= nVal1+nVal2
oReport:PrintText(ValorCTB(nTotMov,,,TAM_VALOR,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)
oReport:ThinLine()
oReport:EndPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quadro 3: Demonstracao de Patrimonio Liquido destacado       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
oReport:PrintText(STR0023) // "QUADROS DEMONSTRATIVOS"

oReport:ThinLine()
Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(STR0032, oReport:Row(), 400)  // "DEMONSTRACAO DO PATRIMONIO LIQUIDO DESTACADO"
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(STR0033 + cData, oReport:Row(), 400)  // "PARA O MES "
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)
oReport:ThinLine()
Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Procura a conta de patrimonio Liquido.                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
MsSeek( xFilial("CT1") + aQuadro[5] )

Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(Alltrim(StrTran(STR0034,"|","")), oReport:Row(), 400)  // "| PATRIMONIO LIQUIDO"

DbSelectArea("cArqTmp")
DbSetOrder(1)
If MsSeek(cCusto+aQuadro[5])
	If lRedStorn
		nPtmLiq	:= cArqTmp->SALDOANT + Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)		
	Else	
		nPtmLiq	:= cArqTMP->SALDOATU
	Endif
	oReport:PrintText(ValorCTB(nPtmLiq,,,TAM_VALOR,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
Endif	               
DbSelectArea("CT1")
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Procura a conta de receita.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
dbSeek( xFilial("CT1") + aQuadro[6] )

Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(Alltrim(StrTran(STR0035,"|","")), oReport:Row(), 400)  // "| TOTAL DA RECEITA"

DbSelectArea("cArqTmp")
DbSetOrder(1)
If MsSeek(cCusto+aQuadro[6])
	If lRedStorn
		nReceita	:= cArqTmp->SALDOANT + Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)		
	Else	
		nReceita	:= cArqTMP->SALDOATU
	Endif
	oReport:PrintText(ValorCTB(nReceita,,,TAM_VALOR,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
Endif
DbSelectArea("CT1")	
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Procura a conta de despesa.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
MsSeek( xFilial("CT1") + aQuadro[7] )

Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(Alltrim(StrTran(STR0036,"|","")), oReport:Row(), 400)  // "| TOTAL DA DESPESA"

DbselectArea("cArqTmp")
DbSetOrder(1)
If MsSeek(cCusto+aQuadro[7])
	If lRedStorn
		nDespesa	:= cArqTmp->SALDOANT + Iif(cArqTMP->NORMAL=="1",cArqTmp->SALDODEB - cArqTmp->SALDOCRD,cArqTmp->SALDOCRD - cArqTmp->SALDODEB)		
	Else	
		nDespesa	:= cArqTMP->SALDOATU
	Endif
	oReport:PrintText(ValorCTB(nDespesa,,,TAM_VALOR,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
Endif
DbSelectArea("CT1")	
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula o patrimonio liquido corrigido.                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
nPtmCorr := nPtmLiq + nReceita + nDespesa
Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(Alltrim(StrTran(STR0037+cData,"|","")), oReport:Row(), 400)  // "| PATRIMONIO LIQUIDO CORRIGIDO " + cData
oReport:PrintText(ValorCTB(nPtmCorr,,,TAM_VALOR,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula Lancamento de Correcao		                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
nLctoCorr := nPtmLiq + ( nReceita + nDespesa )

Eval(bSepara, oReport:Row(), 10)
oReport:PrintText(Alltrim(StrTran(STR0038,"|","")), oReport:Row(), 400)  // "| LANCAMENTO DE CORRECAO"
oReport:PrintText(ValorCTB(nLctoCorr,,,TAM_VALOR,nDecimais,.T.,cPicture,"2", , , , , ,lPrintZero,.F./*lSay*/,lColDbCr), oReport:Row(), oReport:PageWidth() - 1000)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

Eval(bSepara, oReport:Row(), 10)
Eval(bSepara, oReport:Row(), oReport:PageWidth()-35)

oReport:ThinLine()

/* Modo de construcao do quadro 3 - conforme analise SBPS
1 - Patrimonio liquido
6.0.0.00.00.2

2 - Receita
7.0.0.00.00.9

3 - Despesa
8.0.0.00.00.6

4 - Patrimonio Liquido corrigido ate a data
1 + 2 + 3

6 - Lancamento de correcao
1 + ( 2 + 3 ) 
*/

RestArea(aSaveArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R185FilImp  ºAutor  ³Paulo Carnelossi   º Data ³ 04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Balancete Centro de Custo/Conta/Item                        º±±
±±º          ³Filtro para impressao - SetLineCondition - Release 4        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
 
Static Function R185FilImp(cSegAte, nDigitAte)
Local lRet := .T.

If mv_par09 == 1					// So imprime Sinteticas
	If cArqTMP->TIPOCONTA == "2" 
		lRet := .F.
	EndIf
ElseIf mv_par09 == 2				// So imprime Analiticas
	If cArqTMP->TIPOCONTA == "1" 
		lRet := .F.
	EndIf
EndIf

//Somente sera impresso centro de custo analitico	
If TIPOCC == "1"
	lRet := .F.
EndIf	

//Filtragem ate o Segmento da Conta( antigo nivel do SIGACON)		
If !Empty(cSegAte)
	If Len(Alltrim(cArqTMP->CONTA)) > nDigitAte
		lRet := .F.
	Endif
EndIf

dbSelectArea("cArqTmp")

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R185RetVlrCol ºAutor ³Paulo Carnelossi  º Data ³ 04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Balancete Centro de Custo/Conta/Item                        º±±
±±º          ³Retorna Valor p/ TrFunction  - SetLineCondition - Release 4 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R185RetVlrCol(cCampo)
Local nRetorno 	:= 0
Local nPosCpo  	:= cArqTmp->(FieldPos(cCampo))
Local cSegAte 	:= mv_par17

If nPosCpo > 0
	If Empty(cArqTmp->ITEM)		
		If mv_par09 == 1					// So imprime Sinteticas - Soma Sinteticas
			If cArqTmp->TIPOCONTA == "1"
				If cArqTmp->NIVEL1
					nRetorno := cArqTmp->(FieldGet(nPosCpo))
				EndIf
			EndIf
		Else									// Soma Analiticas
			If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
				If cArqTmp->TIPOCONTA == "2"
					nRetorno := cArqTmp->(FieldGet(nPosCpo))
				EndIf
			Else							//Se tiver filtragem, somo somente as sinteticas
				If cArqTmp->TIPOCONTA == "1"
					If cArqTmp->NIVEL1
						nRetorno := cArqTmp->(FieldGet(nPosCpo))
					EndIf
				EndIf	
	    	Endif			
		EndIf
	EndIf					
EndIf
	
Return(nRetorno)
