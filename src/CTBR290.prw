/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR290.Ch"
#Include "PROTHEUS.Ch"

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

//Tradução PTG 20080721

// 17/08/2009 -- Filial com mais de 2 caracteres
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr290	³ Autor ³ Simone Mie Sato   	³ Data ³ 18.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Comparativo de Item s/ 6 C.Custos.        		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Ctbr290				      								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       							  		  		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 		 ³ SIGACTB      							  				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum									  				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctbr290()

U_CTBR290R4()

//Limpa os arquivos temporários 
CTBGerClean()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR290R4 ºAutor  ³Paulo Carnelossi    º Data ³  06/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Construcao Release 4                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Ctbr290R4()

Local aArea 		:= GetArea()
Local cSayItem		:= CtbSayApro("CTD")
Local cSayCC		:= CtbSayApro("CTT")
LOCAL cString		:= "CTD"
Local cTitulo 		:= OemToAnsi(STR0004)+Upper(Alltrim(cSayItem))+ UPPER(OemToAnsi(STR0010))+ " 6 "+ Upper(Alltrim(cSayCC))  	//"Comparativo de" "ATE"
Local lAtSlComp	:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local cMensagem	:= ""

Private NomeProg := FunName()

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra tela de aviso - processar exclusivo					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMensagem := OemToAnsi(STR0021)+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += OemToAnsi(STR0022)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += OemToAnsi(STR0023)+chr(13)  		//"rodar a rotina de atualizacao de saldos "

IF !lAtSlComp
	IF !MsgYesNo(cMensagem,OemToAnsi(STR0025))	//"ATEN€O"
		Return
	Endif
EndIf

Pergunte("CTR290",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					       ³
//³ mv_par01				// Data Inicial              	       ³
//³ mv_par02				// Data Final                          ³
//³ mv_par03				// Item Inicial                        ³
//³ mv_par04				// Item Final   					   ³
//³ mv_par05				// C.Custo 01                          ³
//³ mv_par06				// C.Custo 02                          ³
//³ mv_par07				// C.Custo 03                          ³
//³ mv_par08				// C.Custo 04                          ³
//³ mv_par09				// C.Custo 05                          ³
//³ mv_par10				// C.Custo 06                          ³
//³ mv_par11				// Imprime Itens:Sintet/Analit/Ambas   ³
//³ mv_par12				// Cod. Config. Livros			 	   ³
//³ mv_par13				// Saldos Zerados?			     	   ³
//³ mv_par14				// Moeda?          			     	   ³
//³ mv_par15				// Pagina Inicial  		     		   ³
//³ mv_par16				// Saldos? Reais / Orcados/Gerenciais  ³
//³ mv_par17				// Imprimir ate o Segmento?			   ³
//³ mv_par18				// Filtra Segmento?					   ³
//³ mv_par19				// Conteudo Inicial Segmento?		   ³
//³ mv_par20				// Conteudo Final Segmento?		       ³
//³ mv_par21				// Conteudo Contido em?				   ³
//³ mv_par22				// Imprime Cod. CC  ? Normal/Reduzido  ³
//³ mv_par23				// Imprime Cod. Item? Normal/Reduzido  ³
//³ mv_par24				// Salta linha sintetica?              ³
//³ mv_par25 				// Imprime Valor 0.00?                 ³
//³ mv_par26 				// Divide por?                         ³
//³ mv_par27				// Posicao Ant. L/P? Sim / Nao         ³
//³ mv_par28				// Data Lucros/Perdas?                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef(cSayCC, cSayItem, cString, cTitulo)

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
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Carnelossi    º Data ³  06/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Construcao Release 4                                       º±±
±±º          ³ Definicao das colunas do relatorio                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(cSayCC, cSayItem, cString, cTitulo)

Local cPerg	 	:= "CTR290"
Local cDesc1 		:= OemToAnsi(STR0001)			//"Este programa ira imprimir o Balancete Comparativo de "
Local cDesc2 		:= Upper(Alltrim(cSayItem)) + OemToAnsi(STR0002) +  " 6 " + Upper(Alltrim(cSayCC)) //" sobre "
Local cDesc3 		:= OemToansi(STR0003)  //"de acordo com os parametros solicitados pelo Usuario"

Local oReport
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

oReport := TReport():New("CTBR290",cTitulo, cPerg, ;
			{|oReport| If(!ct040Valid(mv_par12), oReport:CancelPrint(), ReportPrint(oReport,cSayCC, cSayItem, cString, cTitulo))},;
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
//adiciona ordens do relatorio

oItemCtb := TRSection():New(oReport, STR0027 , {"CTD"}, aOrdem /*{}*/, .F., .F.)  //"Item Contabil"

TRCell():New(oItemCtb,	"CTD_ITEM"	,"CTD",STR0028/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"CODIGO"
TRCell():New(oItemCtb,	"CTD_DESC01","CTD",STR0029/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"DESCRICAO"
For nX := 1 To 6
	TRCell():New(oItemCtb,	"VALOR_MOV"+StrZero(nX,2),"",STR0024+Upper(Alltrim(cSayCC))+" "+StrZero(nX,2)/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")  //" MOV. "
Next
TRCell():New(oItemCtb,	"VALOR_TOTAL","",STR0031/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")  //"TOTAL   DO   PERIODO "

oItemCtb:SetHeaderPage()

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor ³Paulo Carnelossi   º Data ³  06/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Construcao Release 4                                       º±±
±±º          ³ Funcao de impressao do relatorio acionado pela execucao    º±±
±±º          ³ do botao <OK> da PrintDialog()                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport,cSayCC, cSayItem, cString, cTitulo)

Local oItemCtb := oReport:Section(1)
Local oBreak,oTotPer // Oblejtos totalizadores
Local aTotCc := Array(6)
Local aSetOfBook
Local aCtbMoeda	:= {}
Local lRet			:= .T.    
Local nDivide		:= 1

Local aTotCol		:= {0,0,0,0,0,0}
Local nTotGeral		:= 0
Local aCC			:= {}          
Local aCCRes		:= {}
Local aTamCC		:= TAMSX3("CTT_CUSTO")
Local aTamCCRes		:=	TAMSX3("CTT_RES")

Local CbTxt			:= Space(10)
Local cabec1  		:= ""
Local cabec2		:= ""
Local cPicture
Local cDescMoeda
Local cCodMasc		:= ""
Local cMascItem		:= ""
Local cMascCC		:= ""
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cGrupo		:= ""
Local cCustoAnt		:= ""
Local cCCResAnt		:= ""
Local cArqTmp   	:= ""
Local cPergCC		:= ""
Local cCCIni		:= ""
Local cCCFim		:= ""
Local cSegAte   	:= mv_par17
Local cSegmento		:= mv_par18
Local cSegIni		:= mv_par19
Local cSegFim		:= mv_par20
Local cFiltSegm		:= mv_par21

Local CbCont		:= 0
Local limite		:= 220
Local nDecimais
Local nDigitAte		:= 0
Local nTotLinha		:= 0
Local nPergCC		:= 4 //Definido com 4, porque a primeira perg. de c.custo eh o mv_par05
Local nTamCC		:= aTamCC[1]
Local nTamCCRes	:= aTamCCRes[1]
Local nTamCusto	:= 0
Local nSpace		:= 0
Local nSpaceAnt	:= 0
Local nSpaceDep	:= 0
Local nTamDescCC	:= Len(Alltrim(cSayCC))
Local nCont			:= 0
Local nDigitos		:= 0
Local nVezes		:= 0
Local nPos			:= 0

Local lPula			:= Iif(mv_par24=1,.T.,.F.) 
Local lPrintZero	:= Iif(mv_par25=1,.T.,.F.)
Local lImpAntLP		:= Iif(mv_par27 == 1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par13==1,.T.,.F.)
Local lJaPulou		:= .F.

Local dDataLP  		:= mv_par28
Local dDataFim 		:= mv_par02

Local lImpSint		:= If(mv_par11==2,.F.,.T.)

aSetOfBook := CTBSetOf(mv_par12)

If mv_par26 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par26 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par26 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par14,nDivide)
	If Empty(aCtbMoeda[1])                        
      Help(" ",1,"NOMOEDA")
      oReport:CancelPrint()
      Return
   Endif
Endif

cDescMoeda 			:= aCtbMoeda[2]
nDecimais 			:= DecimalCTB(aSetOfBook,mv_par14)
cCCIni				:= Space(nTamCC)
cCCFim				:= Repl("Z",nTamCC)



For nCont := 1 to 6       	
	cPergCC	:= &("mv_par"+Strzero(nPergCC+nCont,2))		
	If Empty(cPergCC)            
		AADD(aCC,space(nTamCC))
	Else
		AADD(aCC,cPergCC)
	EndIf                 	
Next                      
             
If mv_par22 == 2 //Se Imprime Codigo Reduzido C.Custo. 
	For nCont := 1 to Len(aCC)	
		dbSelectArea("CTT")
		dbSetOrder(1)
		If (!Empty(aCC[nCont])) .And. (MsSeek(xFilial("CTT")+aCC[nCont])) 
			AADD(aCCRes,CTT->CTT_RES)				
		Else     
			AADD(aCCRes,Space(nTamCCRes))					
		EndIf
	Next
EndIf        

// Mascara do Item Contabil
If Empty(aSetOfBook[7])
	cMascItem := ""
	cCodMasc  := ""
Else
	cMascItem := RetMasCtb(aSetOfBook[7],@cSepara1)
	cCodmasc	:= aSetOfBook[7]
EndIf    

//Mascara do C.Custo
If Empty(aSetOfBook[6])
	cMascCC	:= ""
Else
	cMascCC	:= RetMasCtb(aSetOfBook[6],@cSepara2)
EndIf

cPicture 		:= aSetOfBook[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par11 == 1
	cTitulo:=	OemToAnsi(STR0007) + Upper(Alltrim(cSayItem)) + OemToAnsi(STR0010) + " 6 " + Upper(Alltrim(cSayCC))		//"COMPARATIVO SINTETICO DE  "//"ATE"
ElseIf mv_par11 == 2
	cTitulo:=	OemToAnsi(STR0006) + Upper(Alltrim(cSayItem)) + OemToAnsi(STR0010) + " 6 " + Upper(Alltrim(cSayCC)) 	//"COMPARATIVO ANALITICO DE  " //"ATE"
ElseIf mv_par11 == 3
	cTitulo:=	OemToAnsi(STR0008) + Upper(Alltrim(cSayItem)) + OemToAnsi(STR0010) + " 6 " + Upper(Alltrim(cSayCC))		//"COMPARATIVO DE  "//"ATE"
EndIf

cTitulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + Upper(OemToAnsi(STR0010)) + Dtoc(mv_par02) + ;
				OemToAnsi(STR0011) + cDescMoeda

If mv_par16 > "1"			
	cTitulo += " (" + Tabela("SL", mv_par16, .F.) + ")"
Endif

oReport:SetTitle(cTitulo)
oReport:SetLandscape()

oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

For nCont := 1 to Len(aCC)                                        	
	If !Empty(aCC[nCont])	//Se a coluna estiver com o Centro de Custo Preenchido
		If mv_par22 == 1	//Se for Cod.Normal CC
			oItemCtb:Cell("VALOR_MOV"+StrZero(nCont,2)):SetTitle(oItemCtb:Cell("VALOR_MOV"+StrZero(nCont,2)):Title()+CRLF+Alltrim(aCC[nCont]))
		Else				//Se for Cod. Reduzido CC
			oItemCtb:Cell("VALOR_MOV"+StrZero(nCont,2)):SetTitle(oItemCtb:Cell("VALOR_MOV"+StrZero(nCont,2)):Title()+CRLF+AllTrim(aCCRes[nCont]))
		EndIf	                                
	EndIf	
Next

oReport:SetPageNumber(mv_par15)

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara) 	
EndIf		

If !Empty(cSegmento)
	If Empty(cCodMasc)
		help("",1,"CTN_CODIGO")
		oReport:CancelPrint()
	Else
		dbSelectArea("CTM")
		dbSetOrder(1)
		If MsSeek(xFilial()+cCodMasc)
			While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == cCodMasc
				nPos += Val(CTM->CTM_DIGITO)
				If CTM->CTM_SEGMEN == strzero(val(cSegmento),2)
					nPos -= Val(CTM->CTM_DIGITO)
					nPos ++
					nDigitos := Val(CTM->CTM_DIGITO)      
					Exit
				EndIf	
				dbSkip()
			EndDo	
		Else
			help("",1,"CTM_CODIGO")
			oReport:CancelPrint()
		Endif	
	EndIf	
EndIf	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CTV","",,,cCCIni,cCCFim,mv_par03,mv_par04,,,mv_par14,;
				mv_par16,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				.F.,.F.,,"CTD",lImpAntLP,dDataLP,nDivide,"M",.F.,,.F.,,lVlrZerado,.T.,aCC,lImpSint,cString,oItemCtb:GetAdvplExp()/*aReturn[7]*/)},;
				OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor rio..."
				OemToAnsi(STR0004) +  Upper(Alltrim(cSayItem)+ OemToAnsi(STR0010)+ "6 "+Upper(Alltrim(cSayCC)) ) )     
			
If Select("cArqTmp") == 0
	oReport:CancelPrint()
EndIf							

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()        

TRPosition():New(oItemCtb,"CTD",1,{|| xFilial("CTD") + cArqTmp->ITEM})

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])                                       
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	oReport:CancelPrint()
Endif

oReport:SetMeter(RecCount())

If mv_par23 == 1       //Codigo Normal Item
	If TIPOITEM == '1'
		oItemCtb:Cell("CTD_ITEM"):SetBlock({|| EntidadeCTB(cArqTmp->ITEM,,,20,.F.,cMascItem,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	Else //desloca 2 posicoes                                                                        
		oItemCtb:Cell("CTD_ITEM"):SetBlock({|| EntidadeCTB(cArqTmp->ITEM,,,20,.F.,cMascItem,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	EndIf
Else //Codigo Reduzido
	If 	TIPOITEM == '1'
		oItemCtb:Cell("CTD_ITEM"):SetBlock({|| EntidadeCTB(cArqTmp->ITEMRES,,,20,.F.,cMascItem,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	Else //desloca 2 posicoes
		oItemCtb:Cell("CTD_ITEM"):SetBlock({|| EntidadeCTB(cArqTmp->ITEMRES,,,20,.F.,cMascItem,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	EndIf		
Endif

oItemCtb:Cell("CTD_DESC01"):SetBlock({|| Substr(cArqTmp->DESCITEM,1,31)})
If lIsRedStor
	oItemCtb:Cell("VALOR_MOV01"):SetBlock({|| StrTran(ValorCTB(cArqTmp->COLUNA1,,,17,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oItemCtb:Cell("VALOR_MOV02"):SetBlock({|| StrTran(ValorCTB(cArqTmp->COLUNA2,,,17,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oItemCtb:Cell("VALOR_MOV03"):SetBlock({|| StrTran(ValorCTB(cArqTmp->COLUNA3,,,17,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oItemCtb:Cell("VALOR_MOV04"):SetBlock({|| StrTran(ValorCTB(cArqTmp->COLUNA4,,,17,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oItemCtb:Cell("VALOR_MOV05"):SetBlock({|| StrTran(ValorCTB(cArqTmp->COLUNA5,,,17,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oItemCtb:Cell("VALOR_MOV06"):SetBlock({|| StrTran(ValorCTB(cArqTmp->COLUNA6,,,17,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oItemCtb:Cell("VALOR_TOTAL"):SetBlock({|| StrTran(ValorCTB(nTotLinha		,,,17,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
Else
	oItemCtb:Cell("VALOR_MOV01"):SetBlock({|| ValorCTB(cArqTmp->COLUNA1,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_MOV02"):SetBlock({|| ValorCTB(cArqTmp->COLUNA2,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_MOV03"):SetBlock({|| ValorCTB(cArqTmp->COLUNA3,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_MOV04"):SetBlock({|| ValorCTB(cArqTmp->COLUNA4,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_MOV05"):SetBlock({|| ValorCTB(cArqTmp->COLUNA5,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_MOV06"):SetBlock({|| ValorCTB(cArqTmp->COLUNA6,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(nTotLinha		,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
Endif

//------------------Total Geral-----------------------------------------------------//
oBreak:= TRBreak():New(oItemCtb, {|| } , {|| AllTrim(STR0018) } )
oBreak:OnBreak( { || cArqTmp->(Eof()) } )
oBreak:SetPageBreak(.T.)

// Imprime total
aTotCc[1] := TRFunction():New( oItemCtb:Cell("VALOR_MOV01"), ,"ONPRINT", oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.,oItemCtb)
aTotCc[1]:SetFormula( {|| ValorCTB(aTotCol[1],,,15,nDecimais,.T.,cPicture,, , , , , ,lPrintZero,.F./*lSay*/) })
aTotCc[2] := TRFunction():New( oItemCtb:Cell("VALOR_MOV02"), ,"ONPRINT", oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.,oItemCtb)
aTotCc[2]:SetFormula( {|| ValorCTB(aTotCol[2],,,15,nDecimais,.T.,cPicture,, , , , , ,lPrintZero,.F./*lSay*/) })
aTotCc[3] := TRFunction():New( oItemCtb:Cell("VALOR_MOV03"), ,"ONPRINT", oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.,oItemCtb)
aTotCc[3]:SetFormula( {|| ValorCTB(aTotCol[3],,,15,nDecimais,.T.,cPicture,, , , , , ,lPrintZero,.F./*lSay*/) })
aTotCc[4] := TRFunction():New( oItemCtb:Cell("VALOR_MOV04"), ,"ONPRINT", oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.,oItemCtb)
aTotCc[4]:SetFormula( {|| ValorCTB(aTotCol[4],,,15,nDecimais,.T.,cPicture,, , , , , ,lPrintZero,.F./*lSay*/) })
aTotCc[5] := TRFunction():New( oItemCtb:Cell("VALOR_MOV05"), ,"ONPRINT", oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.,oItemCtb)
aTotCc[5]:SetFormula( {|| ValorCTB(aTotCol[5],,,15,nDecimais,.T.,cPicture,, , , , , ,lPrintZero,.F./*lSay*/) })
aTotCc[6] := TRFunction():New( oItemCtb:Cell("VALOR_MOV06"), ,"ONPRINT", oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.,oItemCtb)
aTotCc[6]:SetFormula( {|| ValorCTB(aTotCol[6],,,15,nDecimais,.T.,cPicture,, , , , , ,lPrintZero,.F./*lSay*/) })

// Imprime total Geral
oTotPer := TRFunction():New( oItemCtb:Cell("VALOR_TOTAL"), ,"ONPRINT", oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.,.F.,oItemCtb)
If lIsRedStor
	aTotCc[1]:SetFormula( {|| StrTran(ValorCTB(aTotCol[1],,,15,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/),"D","") })
	aTotCc[2]:SetFormula( {|| StrTran(ValorCTB(aTotCol[2],,,15,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/),"D","") })
	aTotCc[3]:SetFormula( {|| StrTran(ValorCTB(aTotCol[3],,,15,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/),"D","") })
	aTotCc[4]:SetFormula( {|| StrTran(ValorCTB(aTotCol[4],,,15,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/),"D","") })
	aTotCc[5]:SetFormula( {|| StrTran(ValorCTB(aTotCol[5],,,15,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/),"D","") })
	aTotCc[6]:SetFormula( {|| StrTran(ValorCTB(aTotCol[6],,,15,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/),"D","") })
	
	oTotPer:SetFormula( {|| StrTran(ValorCTB(nTotGeral,,,15,nDecimais,.T.,cPicture,"1", , , , , ,lPrintZero,.F./*lSay*/),"D","") })
Else
	oTotPer:SetFormula( {|| ValorCTB(nTotGeral,,,15,nDecimais,.T.,cPicture,, , , , , ,lPrintZero,.F./*lSay*/) })
Endif

oItemCtb:Init()

While !Eof()

	If oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()

	******************** "FILTRAGEM" PARA IMPRESSAO *************************

	If mv_par11 == 1					// So imprime Sinteticas
		If TIPOITEM == "2"
			dbSkip()
			Loop
		EndIf
	ElseIf mv_par11 == 2				// So imprime Analiticas
		If TIPOITEM == "1"
			dbSkip()
			Loop
		EndIf
	EndIf

	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(ITEM)) > nDigitAte
			dbSkip()
			Loop
		Endif
	EndIf
	
	If !Empty(cSegmento)
		If Empty(cSegIni) .And. Empty(cSegFim) .And. !Empty(cFiltSegm)
			If  !(Substr(cArqTmp->ITEM,nPos,nDigitos) $ (cFiltSegm) ) 
				dbSkip()
				Loop
			EndIf	
		Else
			If Substr(cArqTmp->ITEM,nPos,nDigitos) < Alltrim(cSegIni) .Or. ;
				Substr(cArqTmp->ITEM,nPos,nDigitos) > Alltrim(cSegFim)
				dbSkip()
				Loop
			EndIf	
		Endif
	EndIf	
	            
	If lVlrZerado  .And. (Abs(cArqTmp->COLUNA1)+Abs(cArqTmp->COLUNA2)+Abs(cArqTmp->COLUNA3)+Abs(cArqTmp->COLUNA4)+Abs(cArqTmp->COLUNA5)+Abs(cArqTmp->COLUNA6))==0
		If CtbExDtFim("CTD") 
			dbSelectArea("CTD")
			dbSetOrder(1)
			If MsSeek(xFilial()+cArqTmp->ITEM)
				If !CtbVlDtFim("CTD",mv_par01) 
					dbSelectArea("cArqTmp")
					dbSkip()
					Loop
				EndIf						
			EndIf
			dbSelectArea("cArqTmp")
		EndIf
	EndIF
	
	************************* ROTINA DE IMPRESSAO *************************
	dbSelectArea("cArqTmp")

	//Total da Linha
	nTotLinha	:= cArqTmp->COLUNA1+cArqTmp->COLUNA2+cArqTmp->COLUNA3+cArqTmp->COLUNA4+cArqTmp->COLUNA5+cArqTmp->COLUNA6
	
	oItemCtb:PrintLine()
	nTotLinha	:= 0
	lJaPulou := .F.

	If lPula .And. TIPOITEM == "1"				// Pula linha entre sinteticas
		oReport:SkipLine()
		lJaPulou := .T.
	EndIf			

	************************* FIM   DA  IMPRESSAO *************************

	If mv_par11 == 1					// So imprime Sinteticas - Soma Sinteticas
		If TIPOITEM == "1"
			If NIVEL1
				For nVezes := 1 to Len(aCC)
					aTotCol[nVezes]	+=&("COLUNA"+Str(nVezes,1))				
				Next	
			EndIf
		EndIf
	Else								// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If TIPOITEM == "2"
				For nVezes := 1 to Len(aCC)
					aTotCol[nVezes] +=&("COLUNA"+Str(nVezes,1))
				Next							
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If TIPOITEM == "1"
				If NIVEL1
					For nVezes := 1 to Len(aCC)
						aTotCol[nVezes] +=&("COLUNA"+Str(nVezes,1))				
					Next
				EndIf
			EndIf
    	Endif
	EndIf                     

	//TOTAL GERAL
	nTotGeral	:= aTotCol[1]+aTotCol[2]+aTotCol[3]+aTotCol[4]+aTotCol[5]+aTotCol[6]

	dbSelectArea("cArqTmp")
	dbSkip()	

	If lPula .And. TIPOITEM == "1" 			// Pula linha entre sinteticas
		If !lJaPulou
			oReport:SkipLine()
		EndIf	
	EndIf	

EndDO

oItemCtb:Finish()

IF ! oReport:Cancel()
	oReport:ThinLine()
	oReport:ThinLine()

	oItemCtb:PrintLine()

EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
Ferase(cArqTmp+GetDBExtension())
Ferase("cArqInd"+OrdBagExt())
dbselectArea("CT2")

Return


