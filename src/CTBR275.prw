/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma pr·tica e de f·cil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr275.Ch"
#Include "PROTHEUS.Ch"

#DEFINE 	COL_SEPARA1			1
#DEFINE 	COL_DESC  			2
#DEFINE 	COL_SEPARA2			3
#DEFINE 	COL_COLUNA1       	4
#DEFINE 	COL_SEPARA3			5
#DEFINE 	COL_COLUNA2       	6
#DEFINE 	COL_SEPARA4			7
#DEFINE 	COL_COLUNA3       	8
#DEFINE 	COL_SEPARA5			9
#DEFINE 	COL_COLUNA4   		10
#DEFINE 	COL_SEPARA6			11
#DEFINE 	COL_COLUNA5   		12
#DEFINE 	COL_SEPARA7			13
#DEFINE 	COL_COLUNA6   		14
#DEFINE 	COL_SEPARA8 		15
#DEFINE 	COL_COLUNA7			16
#DEFINE 	COL_SEPARA9			17
#DEFINE 	COL_COLUNA8			18
#DEFINE 	COL_SEPARA10		19
#DEFINE 	COL_COLUNA9			20
#DEFINE 	COL_SEPARA11		21
#DEFINE 	COL_COLUNA10		22
#DEFINE 	COL_SEPARA12		23
#DEFINE 	COL_COLUNA11		24
#DEFINE 	COL_SEPARA13		25
#DEFINE 	COL_COLUNA12		26
#DEFINE 	COL_SEPARA14		27
#DEFINE 	COL_TOTAL			28
#DEFINE 	COL_SEPARA15		29


//TraduÁ„o PTG 20080721

// 17/08/2009 -- Filial com mais de 2 caracteres


/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo	 ≥ Ctbr275	≥ Autor ≥ Simone Mie Sato   	≥ Data ≥ 25.04.05 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Comparativo de 4 entidades.                            	  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe   ≥ U_Ctbr275()                               			 		  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno	 ≥ Nenhum       											  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso    	 ≥ Generico     											  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ Nenhum													  ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
User Function Ctbr275()

Local aSetOfBook
Local aCtbMoeda		:= {}
Local cDesc1 		:= STR0001	//"Este programa ira imprimir o Comparativo de Movimento ou Saldos Acumulados "
Local cDesc2 		:= STR0002  //"das 4 entidades contabeis possibilitando escolher a ordem das entidades."
Local cDesc3		:= ""
Local wnrel
Local cString		:= "CTI"
Local titulo 		:= STR0003 	//"Comparativo de Saldos/Mov. de 4 Entidades"
Local lRet			:= .T.
Local nDivide		:= 1
Local lAtSlBase		:= Iif(GETMV("MV_ATUSAL")== "S",.T.,.F.)

PRIVATE Tamanho		:="G"
PRIVATE nLastKey 	:= 0
PRIVATE cPerg	 	:= "CTR275"
PRIVATE aReturn 	:= { STR0013, 1,STR0014, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE aLinha		:= {}
PRIVATE nomeProg  	:= "CTBR275"

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

li 		:= 80
m_pag	:= 1

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Mostra tela de aviso - processar exclusivo					 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
cMensagem := STR0017+chr(13)  		//"Caso nao atualize os saldos  basicos  na"
cMensagem += STR0018+chr(13)  		//"digitacao dos lancamentos (MV_ATUSAL='N'),"
cMensagem += STR0019+chr(13)  		//"rodar a rotina de atualizacao de saldos "
cMensagem += STR0020+chr(13)  		//"para todas as filiais solicitadas nesse "
cMensagem += STR0021+chr(13)  		//"relatorio."

IF !lAtSlBase
	IF !MsgYesNo(cMensagem,STR0009)	//"ATENÄéO"
		Return
	Endif
EndIf

Pergunte("CTR275",.F.)
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Variaveis utilizadas para parametros					       ≥
//≥ mv_par01				// Data Inicial              	       ≥
//≥ mv_par02				// Data Final                          ≥
//≥ mv_par03				// Conta Inicial                       ≥
//≥ mv_par04				// Conta Final   					   ≥
//≥ mv_par05				// C.C. Inicial         		       ≥
//≥ mv_par06				// C.C. Final   					   ≥
//≥ mv_par07				// Item Inicial                        ≥
//≥ mv_par08				// Item Final   					   ≥
//≥ mv_par09				// Classe de Valor Inicial             ≥
//≥ mv_par10				// Classe de Valor Final			   ≥
//≥ mv_par11				// 1a. Entidade   					   ≥
//≥ mv_par12				// 2a. Entidade   					   ≥
//≥ mv_par13				// 3a. Entidade   					   ≥
//≥ mv_par14				// 4a. Entidade   					   ≥
//≥ mv_par15				// Moeda?          			     	   ≥
//≥ mv_par16				// Saldos? Reais / Orcados/Gerenciais  ≥
//≥ mv_par17				// Configuracao de Livros			   ≥
//≥ mv_par18				// Compara? (Mov.Periodo/Saldo.Acum.)  ≥
//≥ mv_par19				// Pagina Inicial  		     		   ≥
//≥ mv_par20				// Pula pagina     		     		   ≥
//≥ mv_par21				// Imprime Cod. Conta? Normal/Reduzido ≥
//≥ mv_par22				// Imprime Cod. C.Custo? Normal/Red.   ≥
//≥ mv_par23				// Imprime Cod. Item ? Normal/Red.     ≥
//≥ mv_par24				// Imprime Cod. Cl.Vlr? Normal/Red.    ≥
//≥ mv_par25 				// Imprime Valor 0.00?                 ≥
//≥ mv_par26 				// Divide por?                         ≥
//≥ mv_par27				// Posicao Ant. L/P? Sim / Nao         ≥
//≥ mv_par28				// Data Lucros/Perdas?                 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
wnrel	:= "CTBR275"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
	Set Filter To
	Return
Endif

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano≥
//≥ Gerencial -> montagem especifica para impressao)			 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
If !ct040Valid(mv_par17)
	lRet := .F.
Else
   aSetOfBook := CTBSetOf(mv_par17)
Endif

If mv_par26 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par26 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par26 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par15,nDivide)
	If Empty(aCtbMoeda[1])                       
      Help(" ",1,"NOMOEDA")
      lRet := .F.
   Endif
Endif  

If lRet
	//Verificar se existe repeticao de entidade. As 4 entidades devem ser diferentes.
	If 	mv_par11 == mv_par12 .Or. mv_par11 == mv_par13 .Or. mv_par11 == mv_par14 .Or. ;
		mv_par12 == mv_par13 .Or. mv_par12 == mv_par14 .Or. mv_par13 == mv_par14 
		lRet	:= .F.
		MsgAlert(STR0028)//"Favor verificar as entidades contabeis escolhidas. N„o podem se repetir.."
	EndIf
EndIf  

If !lRet
	Set Filter To
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| CTR275Imp(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda,nDivide,lAtSlBase)})

Return

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Program   ≥CTR275IMP ≥ Autor ≥ Simone Mie Sato       ≥ Data ≥ 25.04.05 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Imprime relatorio  									      ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe   ≥CTR275Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda)          ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno   ≥ Nenhum                                                     ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ Generico                                                   ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ lEnd    	  - Aáao do Codeblock                             ≥±±
±±≥          ≥ WnRel   	  - T°tulo do relat¢rio                           ≥±±
±±≥          ≥ cString 	  - Mensagem                                      ≥±±
±±≥          ≥ aSetOfBook - Matriz ref. Config. Relatorio                 ≥±±
±±≥          ≥ aCtbMoeda  - Matriz ref. a moeda                           ≥±±
±±≥          ≥ nDivde     - Fator de divisao para impressao dos valores   ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function CTR275Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda,nDivide,lAtSlBase)

Local aColunas		:= {}
Local aTotCol		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local aTotal		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local aMeses		:= {}          
Local aPeriodos

Local CbTxt			:= Space(10)
Local cabec1   		:= ""
Local cabec2   		:= ""
Local cMoeda		:= mv_par15
Local cPicture
Local cDescMoeda
Local cArqTmp
Local c1aEnt		:= ""
Local c2aEnt		:= ""
Local c3aEnt		:= ""
Local c4aEnt		:= ""
Local cMensagem		:= ""
Local cTpRel		:= Iif(mv_par18 == 1,"M","S")
Local cDescEnt1		:= ""
Local cDescEnt2		:= ""
Local cDescEnt3		:= ""
Local cDescEnt4		:= ""
Local cCodRes1		:= ""
Local cCodRes2		:= ""
Local cCodRes3		:= ""
Local cCodRes4		:= ""
Local cDesc1aEnt	:= ""	
Local cDesc2aEnt	:= ""	
Local cDesc3aEnt	:= ""	
Local cDesc4aEnt	:= ""	     
Local c1aEntAnt		:= ""
Local cMascara1		:= ""
Local cMascara2		:= ""
Local cMascara3		:= ""
Local cMascara4		:= ""
Local cCodMasc1		:= ""
Local cCodMasc2		:= ""
Local cCodMasc3		:= ""
Local cCodMasc4		:= ""
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cSepara3		:= ""
Local cSepara4		:= ""

Local CbCont		:= 0
Local limite		:= 220
Local nDecimais
Local nTotGeral		:= 0
Local nMeses		:= 1
Local nCont			:= 0
Local nDigitos		:= 0
Local nVezes		:= 0
Local nPos			:= 0 
Local nEnt			:= 1
Local nTotLinha		:= 0 
Local nTotal		:= 0 

Local dDataFim 		:= mv_par02
Local dDataLP		:= mv_par28

Local lFirstPage	:= .T.
Local lJaPulou		:= .F.
Local lPrintZero	:= Iif(mv_par25==1,.T.,.F.)
Local lImpAntLP		:= Iif(mv_par27 == 1,.T.,.F.)
Local lSinalMov		:= CtbSinalMov()
Local l1aEntRes		:= .F.
Local l2aEntRes		:= .F.
Local l3aEntRes		:= .F.
Local l4aEntRes		:= .F.

//1a. Entidade
If mv_par11 == 1
	c1aEnt		:= "CONTA"
	cDesc1aEnt	:= "CONTA"
	l1aEntRes	:= Iif(mv_par21 == 2,.T.,.F.)
	cArqEnt1	:= "CT1"
	If Empty(aSetOfBook[2])
		cMascara1 := ""
		cCodMasc1 := ""
	Else
		cMascara1 	:= RetMasCtb(aSetOfBook[2],@cSepara1)
		cCodMasc1	:= aSetOfBook[2]		
	EndIf     	
ElseIf mv_par11 == 2
	c1aEnt		:= "CUSTO"
	cDesc1aEnt	:= CtbSayApro("CTT")         
	l1aEntRes	:= Iif(mv_par22 == 2,.T.,.F.)	
	cArqEnt1	:= "CTT"	
	If Empty(aSetOfBook[6])
		cMascara1 := ""
	Else
		cMascara1 := RetMasCtb(aSetOfBook[6],@cSepara1)
	EndIf			
ElseIf mv_par11	== 3
	c1aEnt	:= "ITEM"               
	cDesc1aEnt	:= CtbSayApro("CTD")	
	l1aEntRes	:= Iif(mv_par23 == 2,.T.,.F.)	
	cArqEnt1	:= "CTD"	
	If Empty(aSetOfBook[7])
		cMascara1 := ""
	Else
		cMascara1 := RetMasCtb(aSetOfBook[7],@cSepara1)
	EndIf	
ElseIf mv_par11 == 4
	c1aEnt	:= "CLVL"               
	cDesc1aEnt	:= CtbSayApro("CTH")	
	l1aEntRes	:= Iif(mv_par24 == 2,.T.,.F.)	
	cArqEnt1	:= "CTH"	
	If Empty(aSetOfBook[8])
		cMascara1 := ""
	Else
		cMascara1 := RetMasCtb(aSetOfBook[8],@cSepara1)
	EndIf		
EndIf

//2a. Entidade
If mv_par12 == 1
	c2aEnt		:= "CONTA"
	cDesc2aEnt	:= "CONTA"	                  
	l2aEntRes	:= Iif(mv_par21 == 2,.T.,.F.)	
	cArqEnt2	:= "CT1"
	If Empty(aSetOfBook[2])
		cMascara2 := ""
		cCodMasc2 := ""
	Else
		cMascara2 	:= RetMasCtb(aSetOfBook[2],@cSepara2)
		cCodMasc2	:= aSetOfBook[2]		
	EndIf     	
ElseIf mv_par12 == 2
	c2aEnt	:= "CUSTO"
	cDesc2aEnt	:= CtbSayApro("CTT")	        
	l2aEntRes	:= Iif(mv_par22 == 2,.T.,.F.)		
	cArqEnt2	:= "CTT"
	If Empty(aSetOfBook[6])
		cMascara2 := ""
	Else
		cMascara2 := RetMasCtb(aSetOfBook[6],@cSepara2)
	EndIf	
ElseIf mv_par12	== 3
	c2aEnt	:= "ITEM"
	cDesc2aEnt	:= CtbSayApro("CTD")		    
	l2aEntRes	:= Iif(mv_par23 == 2,.T.,.F.)		
	cArqEnt2	:= "CTD"	
	If Empty(aSetOfBook[7])
		cMascara2 := ""
	Else
		cMascara2 := RetMasCtb(aSetOfBook[7],@cSepara2)
	EndIf		
ElseIf mv_par12 == 4
	c2aEnt	:= "CLVL"
	cDesc2aEnt	:= CtbSayApro("CTH")	        
	l2aEntRes	:= Iif(mv_par24 == 2,.T.,.F.)		
	cArqEnt2	:= "CTH"	
	If Empty(aSetOfBook[8])
		cMascara2 := ""
	Else
		cMascara2 := RetMasCtb(aSetOfBook[8],@cSepara2)
	EndIf		
	
EndIf     

//3a. Entidade
If mv_par13 == 1
	c3aEnt	:= "CONTA"     
	cDesc3aEnt	:= "CONTA"		
	l3aEntRes	:= Iif(mv_par21 == 2,.T.,.F.)		
	cArqEnt3	:= "CT1"	
	If Empty(aSetOfBook[2])
		cMascara3 := ""
		cCodMasc3 := ""
	Else
		cMascara3 	:= RetMasCtb(aSetOfBook[2],@cSepara3)
		cCodMasc3	:= aSetOfBook[2]		
	EndIf     	
ElseIf mv_par13 == 2
	c3aEnt	:= "CUSTO"
	cDesc3aEnt	:= CtbSayApro("CTT")	
	l3aEntRes	:= Iif(mv_par22 == 2,.T.,.F.)			
	cArqEnt3	:= "CTT"	
	If Empty(aSetOfBook[6])
		cMascara3 := ""
	Else
		cMascara3 := RetMasCtb(aSetOfBook[6],@cSepara3)
	EndIf		
ElseIf mv_par13	== 3
	c3aEnt	:= "ITEM"
	cDesc3aEnt	:= CtbSayApro("CTD")			
	l3aEntRes	:= Iif(mv_par23 == 2,.T.,.F.)				
	cArqEnt3	:= "CTD"	
	If Empty(aSetOfBook[7])
		cMascara3 := ""
	Else
		cMascara3 := RetMasCtb(aSetOfBook[7],@cSepara3)
	EndIf		
ElseIf mv_par13 == 4
	c3aEnt	:= "CLVL"
	cDesc3aEnt	:= CtbSayApro("CTH")		
	l3aEntRes	:= Iif(mv_par24 == 2,.T.,.F.)			
	cArqEnt3	:= "CTH"	
	If Empty(aSetOfBook[8])
		cMascara3 := ""
	Else
		cMascara3 := RetMasCtb(aSetOfBook[8],@cSepara3)
	EndIf			
EndIf

//4a. Entidade
If mv_par14 == 1
	c4aEnt	:= "CONTA"
	cDesc4aEnt	:= "CONTA"		
	l4aEntRes	:= Iif(mv_par21 == 2,.T.,.F.)			
	cArqEnt4	:= "CT1"	
	If Empty(aSetOfBook[2])
		cMascara4 := ""
		cCodMasc4 := ""
	Else
		cMascara4 	:= RetMasCtb(aSetOfBook[2],@cSepara4)
		cCodMasc4	:= aSetOfBook[2]		
	EndIf     	
ElseIf mv_par14 == 2
	c4aEnt	:= "CUSTO"         
	cDesc4aEnt	:= CtbSayApro("CTT")	
	l4aEntRes	:= Iif(mv_par22 == 2,.T.,.F.)				
	cArqEnt4	:= "CTT"	
	If Empty(aSetOfBook[6])
		cMascara4 := ""
	Else
		cMascara4 := RetMasCtb(aSetOfBook[6],@cSepara4)
	EndIf		
ElseIf mv_par14	== 3
	c4aEnt	:= "ITEM"          
	cDesc4aEnt	:= CtbSayApro("CTD")				
	l4aEntRes	:= Iif(mv_par23 == 2,.T.,.F.)				
	cArqEnt4	:= "CTD"		
	If Empty(aSetOfBook[7])
		cMascara4 := ""
	Else
		cMascara4 := RetMasCtb(aSetOfBook[7],@cSepara4)
	EndIf		
ElseIf mv_par14 == 4
	c4aEnt	:= "CLVL"
	cDesc4aEnt	:= CtbSayApro("CTH")			
	l4aEntRes	:= Iif(mv_par24 == 2,.T.,.F.)				
	cArqEnt4	:= "CTH"		
	If Empty(aSetOfBook[8])
		cMascara4 := ""
	Else
		cMascara4 := RetMasCtb(aSetOfBook[8],@cSepara4)
	EndIf			
EndIf		

cDescMoeda 	:= Alltrim(aCtbMoeda[2])

If !Empty(aCtbMoeda[6])
	cDescMoeda += STR0007 + aCtbMoeda[6]			// Indica o divisor
EndIf	

nDecimais	:= 2

aPeriodos := ctbPeriodos(mv_par15, mv_par01, mv_par02, .T., .F.)

For nCont := 1 to len(aPeriodos)       
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If aPeriodos[nCont][1] >= mv_par01 .And. aPeriodos[nCont][2] <= mv_par02 
		If nMeses <= 12
			AADD(aMeses,{StrZero(nMeses,2),aPeriodos[nCont][1],aPeriodos[nCont][2]})	
			nMeses += 1           					
		EndIf
	EndIf
Next                                                                   

If nMeses == 1
	cMensagem := STR0022	//"Por favor, verifique se o calend.contabil e a amarracao moeda/calendario "
	cMensagem += STR0023	//"foram cadastrados corretamente..."		
	MsgAlert(cMensagem)
	Return
EndIf                                                      

Titulo:=	STR0008	//"COMPARATIVO  DE "
If mv_par18 == 1    	
	Titulo += STR0012	 //MOVIMENTO
ElseIf mv_par18 == 2	
	Titulo += STR0026 	//SALDO ACUMULADO
EndIf

Titulo += STR0027 		// "  DE  "

Titulo += 	DTOC(mv_par01) + STR0006 + Dtoc(aMeses[Len(aMeses)][3]) + ;
				STR0007 + cDescMoeda

If mv_par16 > "1"			
	Titulo += " (" + Tabela("SL", mv_par16, .F.) + ")"
Endif                     

If mv_par18 == 1	//Se imprime movimento, imprime o total da linha
	cabec1 := STR0004  //"|                  |  PERIODO 01  |  PERIODO 02  |  PERIODO 03  |  PERIODO 04  |  PERIODO 05  |  PERIODO 06  |  PERIODO 07  |  PERIODO 08  |  PERIODO 09  |  PERIODO 10  |  PERIODO 11  |  PERIODO 12  | TOTAL             |"
	aColunas := { 000, 001, 019, 020, 034, 035, 049, 050, 064, 065, 079, 080, 094, 095, 109, 110, 124, 125, 139, 140, 154, 155, 169, 170, 184, 185 , 199, 200, 219} 	
	cabec2	:= "|                  |"
ElseIf mv_par18 == 2	//Se imprime saldo acumulado, nao imprime o total da linha
	cabec1 := STR0005  //"|                          |  PERIODO 01   |  PERIODO 02   |  PERIODO 03   |  PERIODO 04   |  PERIODO 05   |  PERIODO 06   |  PERIODO 07   |  PERIODO 08   |  PERIODO 09   |  PERIODO 10   |  PERIODO 11   |  PERIODO 12   |"
	aColunas := { 000, 001, 027, 028, 043, 044, 059, 060, 075, 076, 091, 092, 107, 108, 124,  125, 139, 140, 155, 156, 171, 172, 187, 188, 203, 204,  219} 		
	cabec2	:= "|                          |"	
Endif

For nCont := 1 to Len(aMeses)
	If mv_par18 == 2	/// SE FOR ACUMULADO … O SALDO ATE A DATA FINAL
		cabec2 += " "+STR0006+" -  "	//"ATE"
	Else
		cabec2 += SPACE(1)+Strzero(Day(aMeses[nCont][2]),2)+"/"+Strzero(Month(aMeses[nCont][2]),2)+ " - "	
	Endif
	cabec2 += Strzero(Day(aMeses[nCont][3]),2)+"/"+Strzero(Month(aMeses[nCont][3]),2)+"|"
Next

For nCont:= Len(aMeses) to 12	
	If mv_par18 == 2
		If nCont < 12	//Nao considerar a ultima coluna, porque nao tem coluna de total
			cabec2+=SPACE(15)+"|"		
		EndIf
	Else
		If nCont == 12        
			cabec2+=SPACE(19)+"|"	
		Else	
			cabec2+=SPACE(14)+"|"
		EndIf
	EndIf
Next         

m_pag := mv_par19

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta Arquivo Temporario para Impressao							  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CTI","",mv_par03,mv_par04,mv_par05,mv_par06,mv_par07,mv_par08,mv_par09,mv_par10,;
				mv_par15,mv_par16,aSetOfBook,,,,,;
				.F.,.F.,,,lImpAntLP,dDataLP,nDivide,cTpRel,.F.,,.T.,aMeses,.F.,,,.F.,cString,aReturn[7],,.T.,;
				c1aEnt,c2aEnt,c3aEnt,c4aEnt,lAtSlBase)},;
				STR0015, STR0003)//"Criando Arquivo Tempor†rio..."				 	//"Comparativo de Contas Contabeis "

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

SetRegua(RecCount())

dbSelectArea("cArqTmp")

While !Eof()

	If lEnd
		@Prow()+1,0 PSAY STR0010   //"***** CANCELADO PELO OPERADOR *****"
		Exit
	EndIf

	IncRegua()

	******************** "FILTRAGEM" PARA IMPRESSAO *************************

	

	************************* ROTINA DE IMPRESSAO *************************
	If li > 58 
		If !lFirstPage 
			@ Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
		lFirstPage := .F.		
	Endif                 

	If (c1aEntAnt <> cArqTmp->&(c1aEnt)) .And. ! Empty(c1aEntAnt)
		@li,aColunas[COL_SEPARA1] PSAY "|"
		@li,aColunas[COL_DESC] PSAY STR0016+ Upper(Alltrim(cDesc1aEnt)) //"TOTAIS "			
		@ li,aColunas[COL_SEPARA2] PSAY "|"
		ValorCTB(aTotal[1],li,aColunas[COL_COLUNA1],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA3] PSAY "|"
		ValorCTB(aTotal[2],li,aColunas[COL_COLUNA2],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA4]	PSAY "|"
		ValorCTB(aTotal[3],li,aColunas[COL_COLUNA3],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA5]	PSAY "|"
		ValorCTB(aTotal[4],li,aColunas[COL_COLUNA4],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA6] PSAY "|"	
		ValorCTB(aTotal[5],li,aColunas[COL_COLUNA5],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA7] PSAY "|"
		ValorCTB(aTotal[6],li,aColunas[COL_COLUNA6],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA8] PSAY "|"
		ValorCTB(aTotal[7],li,aColunas[COL_COLUNA7],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA9] PSAY "|"
		ValorCTB(aTotal[8],li,aColunas[COL_COLUNA8],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA10] PSAY "|"
		ValorCTB(aTotal[9],li,aColunas[COL_COLUNA9],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA11] PSAY "|"
		ValorCTB(aTotal[10],li,aColunas[COL_COLUNA10],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA12] PSAY "|"
		ValorCTB(aTotal[11],li,aColunas[COL_COLUNA11],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA13] PSAY "|"
		ValorCTB(aTotal[12],li,aColunas[COL_COLUNA12],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
		@ li,aColunas[COL_SEPARA14] PSAY "|"			
		If mv_par18 == 1	//Se imprime movimento, imprime a coluna de total		
			nTotal	:= aTotal[1]+aTotal[2]+aTotal[3]+aTotal[4]+aTotal[5]+aTotal[6]+aTotal[7]+aTotal[8]+aTotal[9]+aTotal[10]+aTotal[11]+aTotal[12]
			ValorCTB(nTotal,li,aColunas[COL_TOTAL],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
			@ li,aColunas[COL_SEPARA15] PSAY "|"		
		EndIf
		aTotal 	:= {0,0,0,0,0,0,0,0,0,0,0,0}
		li++                             
	Endif	  
	
	If mv_par20 == 1 .And. !Empty(c1aEntAnt)	//Se pula pagina
		If c1aEntAnt <> cArqTmp->&(c1aEnt) //Se o codigo da 1a Entid. for diferente do codigo da 1a Entid. anterior
			li 	:= 60
		EndIf
	Endif
	
	If li > 58 
		If !lFirstPage 
			@ Prow()+1,00 PSAY	Replicate("-",limite)
		EndIf
		CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
		lFirstPage := .F.		
	Endif                        
	
	//Se mudar o codigo da 1a Entidade
	If cArqTmp->&(c1aEnt) <> c1aEntAnt	
		//Imprime titulo da 1a Entidade		
		@li,00 PSAY REPLICATE("-",limite)					
		li++
		@ li,aColunas[COL_SEPARA1] PSAY "|"
		@ li,aColunas[COL_DESC]PSAY Upper(Alltrim(cDesc1aEnt))+":"
		                                  
		U_Ctbr275Cad(cArqEnt1,cArqTmp->&(c1aEnt),@cDescEnt1,@cCodRes1,cMoeda)			
		
		If l1aEntRes                      
			EntidadeCTB(cCodRes1,li,aColunas[COL_SEPARA1]+Len(Alltrim(cDesc1aEnt))+2,Len(Alltrim(cCodRes1)),.F.,cMascara1,cSepara1)			
			@ li,aColunas[COL_SEPARA1]+Len(Alltrim(cDesc1aEnt))+2+Len(Alltrim(cCodRes1)) PSAY " - " +cDescEnt1			
		Else //Se Imprime Cod. Normal da 1a Entidade
			EntidadeCTB(cArqTmp->&(c1aEnt),li,aColunas[COL_SEPARA1]+Len(Alltrim(cDesc1aEnt))+2,Len(Alltrim(cArqTmp->&(c1aEnt)))+Len(cSepara1),.F.,cMascara1,cSepara1,"CT1")			
			@ li,aColunas[COL_SEPARA1]+Len(Alltrim(cDesc1aEnt))+2+Len(Alltrim(cArqTmp->&(c1aEnt)))+Len(cSepara1) PSAY " - " +Subs(cDescEnt1,1,30)						
		Endif                     
		If mv_par18 == 1	//Se imprime movimento, imprime a coluna de total		
			@ li,aColunas[COL_SEPARA15] PSAY "|"		                            
		Else
			@ li,aColunas[COL_SEPARA14] PSAY "|"		                            		
		EndIf
		li++                                               
		@li,00 PSAY REPLICATE("-",limite)					
		li++
	EndIf
		
	//Imprime a 2a Entidade
	@ li,aColunas[COL_SEPARA1] 	PSAY "|"                           
	@ li,aColunas[COL_DESC]PSAY Upper(Alltrim(cDesc2aEnt))+":"	
	U_Ctbr275Cad(cArqEnt2,cArqTmp->&(c2aEnt),@cDescEnt2,@cCodRes2,cMoeda)				
	If l2aEntRes                      
		EntidadeCTB(cCodRes2,li,aColunas[COL_SEPARA1]+Len(Alltrim(cDesc2aEnt))+2,Len(Alltrim(cCodRes2)),.F.,cMascara2,cSepara2)			
		@ li,aColunas[COL_SEPARA1]+Len(Alltrim(cDesc2aEnt))+2+Len(Alltrim(cCodRes2)) PSAY " - " +cDescEnt2			
	Else //Se Imprime Cod. Normal da 1a Entidade
		EntidadeCTB(cArqTmp->&(c2aEnt),li,aColunas[COL_SEPARA1]+Len(Alltrim(cDesc2aEnt))+2,Len(Alltrim(cArqTmp->&(c2aEnt)))+Len(cSepara2),.F.,cMascara2,cSepara2,"CTT")			
		@ li,aColunas[COL_SEPARA1]+Len(Alltrim(cDesc2aEnt))+2+Len(Alltrim(cArqTmp->&(c2aEnt)))+Len(cSepara2) PSAY " - " +Subs(cDescEnt2,1,30)						
	EndIf          
	
	//Imprime a 3a Entidade
	@ li,aColunas[COL_COLUNA4]PSAY Upper(Alltrim(cDesc3aEnt))+":"	
	U_Ctbr275Cad(cArqEnt3,cArqTmp->&(c3aEnt),@cDescEnt3,@cCodRes3,cMoeda)				
	If l3aEntRes                      
		EntidadeCTB(cCodRes3,li,aColunas[COL_SEPARA5]+Len(Alltrim(cDesc3aEnt))+2,Len(Alltrim(cCodRes3)),.F.,cMascara3,cSepara3)			
		@ li,aColunas[COL_SEPARA5]+Len(Alltrim(cDesc3aEnt))+2+Len(Alltrim(cCodRes3)) PSAY " - " +cDescEnt3			
	Else //Se Imprime Cod. Normal da 1a Entidade
		EntidadeCTB(cArqTmp->&(c3aEnt),li,aColunas[COL_SEPARA5]+Len(Alltrim(cDesc3aEnt))+2,Len(Alltrim(cArqTmp->&(c3aEnt)))+Len(cSepara3),.F.,cMascara3,cSepara3,"CTD")			
		@ li,aColunas[COL_SEPARA5]+Len(Alltrim(cDesc3aEnt))+2+Len(Alltrim(cArqTmp->&(c3aEnt)))+Len(cSepara3) PSAY " - " +Subs(cDescEnt3,1,30)						
	EndIf          	
	
	//Imprime a 4a Entidade
	@ li,aColunas[COL_COLUNA8] PSAY Upper(Alltrim(cDesc4aEnt))+":"	
	U_Ctbr275Cad(cArqEnt4,cArqTmp->&(c4aEnt),@cDescEnt4,@cCodRes4,cMoeda)				
	If l4aEntRes                      
		EntidadeCTB(cCodRes4,li,aColunas[COL_SEPARA9]+Len(Alltrim(cDesc4aEnt))+2,Len(Alltrim(cCodRes4)),.F.,cMascara4,cSepara4)			
		@ li,aColunas[COL_SEPARA9]+Len(Alltrim(cDesc4aEnt))+2+Len(Alltrim(cCodRes4)) PSAY " - " +cDescEnt4			
	Else //Se Imprime Cod. Normal da 1a Entidade
		EntidadeCTB(cArqTmp->&(c4aEnt),li,aColunas[COL_SEPARA9]+Len(Alltrim(cDesc4aEnt))+2,Len(Alltrim(cArqTmp->&(c4aEnt)))+Len(cSepara4),.F.,cMascara4,cSepara4,"CTH")			
		@ li,aColunas[COL_SEPARA9]+Len(Alltrim(cDesc4aEnt))+2+Len(Alltrim(cArqTmp->&(c4aEnt)))+Len(cSepara4) PSAY " - " +Subs(cDescEnt4,1,30)						
	EndIf	          	          
	If mv_par18 == 1 //Se imprime movimento, imprime o total da linha	
		@ li,aColunas[COL_SEPARA15] PSAY "|"		
	Else 
		@ li,aColunas[COL_SEPARA14] PSAY "|"				
	EndIf
	li++	

	@ li,aColunas[COL_SEPARA1] PSAY "|"	
	@ li,aColunas[COL_SEPARA2] PSAY "|"	
	ValorCTB(COLUNA1,li,aColunas[COL_COLUNA1],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA3]	PSAY "|"
	ValorCTB(COLUNA2,li,aColunas[COL_COLUNA2],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA4]	PSAY "|"
	ValorCTB(COLUNA3,li,aColunas[COL_COLUNA3],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA5]	PSAY "|"
	ValorCTB(COLUNA4,li,aColunas[COL_COLUNA4],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA6] PSAY "|"	
	ValorCTB(COLUNA5,li,aColunas[COL_COLUNA5],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA7] PSAY "|"
	ValorCTB(COLUNA6,li,aColunas[COL_COLUNA6],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA8] PSAY "|"
	ValorCTB(COLUNA7,li,aColunas[COL_COLUNA7],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA9] PSAY "|"
	ValorCTB(COLUNA8,li,aColunas[COL_COLUNA8],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA10] PSAY "|"
	ValorCTB(COLUNA9,li,aColunas[COL_COLUNA9],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA11] PSAY "|"
	ValorCTB(COLUNA10,li,aColunas[COL_COLUNA10],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA12] PSAY "|"
	ValorCTB(COLUNA11,li,aColunas[COL_COLUNA11],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA13] PSAY "|"
	ValorCTB(COLUNA12,li,aColunas[COL_COLUNA12],12,nDecimais,lSinalMov,cPicture, NORMAL, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA14] PSAY "|"
	If mv_par18 == 1	//Se imprime movimento, imprime a coluna de total
		//Total da Linha
		nTotLinha	:= COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6+COLUNA7+COLUNA8+COLUNA9+COLUNA10+COLUNA11+COLUNA12
	
		ValorCTB(nTotLinha,li,aColunas[COL_TOTAL],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)		
		@ li,aColunas[COL_SEPARA15] PSAY "|"			                              
	EndIf
	
	li++	         
 	If li <=  58 
		@li,00 PSAY REPLICATE("-",limite)						
		li++
	EndIf
	
	
	************************* FIM   DA  IMPRESSAO *************************
                
	For nVezes := 1 to Len(aMeses)                                 
		aTotCol[nVezes] +=&("COLUNA"+Alltrim(Str(nVezes,2)))				
		aTotal[nVezes]	+=&("COLUNA"+Alltrim(Str(nVezes,2)))				
	Next
	
	c1aEntAnt := cArqTmp->&(c1aEnt)
	
	dbSelectArea("cArqTmp")
	dbSkip()	
EndDO

If li > 50
	If !lFirstPage 
		@ Prow()+1,00 PSAY	Replicate("-",limite)
	EndIf
	CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
Endif                        
    

//Imprime o total da ultima 1a entidade
@li,aColunas[COL_SEPARA1] PSAY "|"
@li,aColunas[COL_DESC] PSAY STR0016+ Upper(Alltrim(cDesc1aEnt)) //"TOTAIS "			
@ li,aColunas[COL_SEPARA2] PSAY "|"
ValorCTB(aTotal[1],li,aColunas[COL_COLUNA1],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA3]		PSAY "|"
ValorCTB(aTotal[2],li,aColunas[COL_COLUNA2],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA4]		PSAY "|"
ValorCTB(aTotal[3],li,aColunas[COL_COLUNA3],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA5]		PSAY "|"
ValorCTB(aTotal[4],li,aColunas[COL_COLUNA4],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA6] PSAY "|"	
ValorCTB(aTotal[5],li,aColunas[COL_COLUNA5],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA7] PSAY "|"
ValorCTB(aTotal[6],li,aColunas[COL_COLUNA6],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA8] PSAY "|"
ValorCTB(aTotal[7],li,aColunas[COL_COLUNA7],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA9] PSAY "|"		
ValorCTB(aTotal[8],li,aColunas[COL_COLUNA8],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA10] PSAY "|"
ValorCTB(aTotal[9],li,aColunas[COL_COLUNA9],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA11] PSAY "|"
ValorCTB(aTotal[10],li,aColunas[COL_COLUNA10],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA12] PSAY "|"
ValorCTB(aTotal[11],li,aColunas[COL_COLUNA11],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA13] PSAY "|"			
ValorCTB(aTotal[12],li,aColunas[COL_COLUNA12],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
@ li,aColunas[COL_SEPARA14] PSAY "|"			
If mv_par18 == 1	//Se imprime movimento, imprime o total da linha	
	nTotal	:= aTotal[1]+aTotal[2]+aTotal[3]+aTotal[4]+aTotal[5]+aTotal[6]+aTotal[7]+aTotal[8]+aTotal[9]+aTotal[10]+aTotal[11]+aTotal[12]
	ValorCTB(nTotal,li,aColunas[COL_TOTAL],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA15] PSAY "|"		
EndIf
aTotal 	:= {0,0,0,0,0,0,0,0,0,0,0,0}

li++

IF li != 80 .And. !lEnd
	@li,00 PSAY REPLICATE("-",limite)
	li++
	@li,00 PSAY REPLICATE("-",limite)	
	li++
	@li,aColunas[COL_SEPARA1] PSAY "|"
	@li,aColunas[COL_DESC]   PSAY STR0024  		//"TOTAL DO PERIODO: "
	@ li,aColunas[COL_SEPARA2]		PSAY "|"
	ValorCTB(aTotCol[1],li,aColunas[COL_COLUNA1],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA3]		PSAY "|"
	ValorCTB(aTotCol[2],li,aColunas[COL_COLUNA2],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA4]		PSAY "|"
	ValorCTB(aTotCol[3],li,aColunas[COL_COLUNA3],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA5]		PSAY "|"
	ValorCTB(aTotCol[4],li,aColunas[COL_COLUNA4],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA6] PSAY "|"	
	ValorCTB(aTotCol[5],li,aColunas[COL_COLUNA5],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA7] PSAY "|"
	ValorCTB(aTotCol[6],li,aColunas[COL_COLUNA6],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA8] PSAY "|"                                                                       
	ValorCTB(aTotCol[7],li,aColunas[COL_COLUNA7],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA9] PSAY "|"                                                                      
	ValorCTB(aTotCol[8],li,aColunas[COL_COLUNA8],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA10] PSAY "|"                                                                       
	ValorCTB(aTotCol[9],li,aColunas[COL_COLUNA9],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA11] PSAY "|"                                                                       
	ValorCTB(aTotCol[10],li,aColunas[COL_COLUNA10],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA12] PSAY "|"                                                                       
	ValorCTB(aTotCol[11],li,aColunas[COL_COLUNA11],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA13] PSAY "|"                                                                       
	ValorCTB(aTotCol[12],li,aColunas[COL_COLUNA12],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)
	@ li,aColunas[COL_SEPARA14] PSAY "|"                                                                       
	
	If mv_par18 == 1	//Se imprime movimento, imprime o total da linha	
		//TOTAL GERAL
		nTotGeral	:= aTotCol[1]+aTotCol[2]+aTotCol[3]+aTotCol[4]+aTotCol[5]+aTotCol[6]+aTotCol[7]+aTotCol[8]+aTotCol[9]+aTotCol[10]+aTotCol[11]+aTotCol[12]	
		ValorCTB(nTotGeral,li,aColunas[COL_TOTAL],12,nDecimais,lSinalMov,cPicture,, , , , , ,lPrintZero)		
		@ li,aColunas[COL_SEPARA15] PSAY "|"                                                                       	
		nTotGeral	:= 0				
	EndIf
	
	li++
	@li,00 PSAY REPLICATE("-",limite)	
	li++
	@li,0 PSAY " "	
	roda(cbcont,cbtxt,"M")
	dbClearFilter()
EndIF


If aReturn[5] = 1
	Set Printer To
	Commit
	Ourspool(wnrel)
EndIf

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea() 
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF	
dbselectArea("CT2")

MS_FLUSH()

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ Ctbr275Cad   ≥Autor ≥Simone Mie Sato       ≥Data≥ 25/04/05 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Retorna o codigo reduzido da entidade contabil.            ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function Ctbr275Cad(cArqEnt1,cCodigo,cDescEnt,cCodRes,cMoeda)			

Local aSaveArea	:= GetArea()

dbSelectArea(cArqEnt1)
dbSetOrder(1)
If MsSeek(xFilial()+cCodigo)
	cCodRes	:= &(cArqEnt1+"_RES")
EndIf			

cDescEnt	:= &(cArqEnt1+"_DESC"+cMoeda) 
If Empty(cDescEnt)
	cDescEnt	:= &(cArqEnt1+"_DESC01") 
EndIf
                            
RestArea(aSaveArea)

Return()
