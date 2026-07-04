/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma pr·tica e de f·cil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.Ch"
#Include "Ctbr300.Ch"

//TraduÁ„o PTG 20080721

// 17/08/2009 -- Filial com mais de 2 caracteres

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema


/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo	 ≥ Ctbr300  ≥ Autor ≥ Simone Mie Sato       ≥ Data ≥ 06.05.02 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Balancete Comparativo de Item s/ 6 Cl. Valores      		  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe	 ≥ Ctbr300	      											  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno	 ≥ Nenhum   				    							  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso 		 ≥ SIGACTB      											  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ Nenhum													  ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
User Function Ctbr300()

U_CTBR300R4()

//Limpa os arquivos tempor·rios
CTBGerClean()

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CTBR300R4 ∫Autor  ≥Paulo Carnelossi    ∫ Data ≥  06/09/06   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Construcao Release 4                                       ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function Ctbr300R4()

Local aArea 		:= GetArea()
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
LOCAL cString		:= "CTD"
Local lAtSlComp	:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local cMensagem	:= ""
Local cTitulo 		:= OemToAnsi(STR0004)+Upper(Alltrim(cSayItem))+ UPPER(OemToAnsi(STR0010))+ " 6 "+ Upper(Alltrim(cSayClVl))  	//"Comparativo de" "ATE"

Private nDecim_ 	:= 2
Private cPict_ 	:= ""
Private lZeroPrint:= .F.
Private oBreak, oTotal1, oTotal2, oTotal3, oTotal4, oTotal5, oTotal6, oTotal7
Private lCharSinal	:= .F.


If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Mostra tela de aviso - Atualizacao de saldos				 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
cMensagem := OemToAnsi(STR0021)+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += OemToAnsi(STR0022)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += OemToAnsi(STR0023)+chr(13)  		//"rodar a rotina de atualizacao de saldos "

IF !lAtSlComp
	IF !MsgYesNo(cMensagem,OemToAnsi(STR0025))	//"ATENÄéO"
		Return
	Endif
EndIf

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Variaveis utilizadas para parametros					       ≥
//≥ mv_par01				// Data Inicial              	       ≥
//≥ mv_par02				// Data Final                          ≥
//≥ mv_par03				// Item Inicial                        ≥
//≥ mv_par04				// Item Final   					   ≥
//≥ mv_par05				// Cl.Valor 01                         ≥
//≥ mv_par06				// Cl.Valor 02                         ≥
//≥ mv_par07				// Cl.Valor 03                         ≥
//≥ mv_par08				// Cl.Valor 04                         ≥
//≥ mv_par09				// Cl.Valor 05                         ≥
//≥ mv_par10				// Cl.Valor 06                         ≥
//≥ mv_par11				// Imprime Itens:Sintet/Analit/Ambas   ≥
//≥ mv_par12				// Cod. Config. Livros			 	   ≥
//≥ mv_par13				// Saldos Zerados?			     	   ≥
//≥ mv_par14				// Moeda?          			     	   ≥
//≥ mv_par15				// Pagina Inicial  		     		   ≥
//≥ mv_par16				// Saldos? Reais / Orcados/Gerenciais  ≥
//≥ mv_par17				// Imprimir ate o Segmento?			   ≥
//≥ mv_par18				// Filtra Segmento?					   ≥
//≥ mv_par19				// Conteudo Inicial Segmento?		   ≥
//≥ mv_par20				// Conteudo Final Segmento?		       ≥
//≥ mv_par21				// Conteudo Contido em?				   ≥
//≥ mv_par22				// Imprime Cod.ClVlr? Normal/Reduzido  ≥
//≥ mv_par23				// Imprime Cod. Item? Normal/Reduzido  ≥
//≥ mv_par24				// Salta linha sintetica?              ≥
//≥ mv_par25 				// Imprime Valor 0.00?                 ≥
//≥ mv_par26 				// Divide por?                         ≥
//≥ mv_par27				// Posicao Ant. L/P? Sim / Nao         ≥
//≥ mv_par28				// Data Lucros/Perdas?                 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Interface de impressao                                                  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
oReport := ReportDef( cSayItem, cSayClVl, cString, cTitulo)

IF ValType( oReport ) == 'O'
	If ! Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf

	oReport:PrintDialog()
Endif

RestArea(aArea)

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ReportDef ∫Autor  ≥Paulo Carnelossi    ∫ Data ≥  06/09/06   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Construcao Release 4                                       ∫±±
±±∫          ≥ Definicao das colunas do relatorio                         ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ReportDef( cSayItem, cSayClVl, cString, cTitulo)

Local cPerg			:= "CTR300"
Local cDesc1 		:= OemToAnsi(STR0001)			//"Este programa ira imprimir o Balancete Comparativo de "
Local cDesc2 		:= Upper(Alltrim(cSayItem)) + OemToAnsi(STR0002) +  " 6 " + Upper(Alltrim(cSayClVl)) //" sobre "
Local cDesc3 		:= OemToansi(STR0003)  //"de acordo com os parametros solicitados pelo Usuario"

Local oReport
Local oItemCtb
Local nX
Local aOrdem := {}

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Criacao do componente de impressao                                      ≥
//≥                                                                        ≥
//≥TReport():New                                                           ≥
//≥ExpC1 : Nome do relatorio                                               ≥
//≥ExpC2 : Titulo                                                          ≥
//≥ExpC3 : Pergunte                                                        ≥
//≥ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ≥
//≥ExpC5 : Descricao                                                       ≥
//≥                                                                        ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

oReport := TReport():New("CTBR300",cTitulo, cPerg, ;
			{|oReport| If(!ct040Valid(mv_par12), oReport:CancelPrint(), ReportPrint(oReport, cSayItem, cSayClVl, cString, cTitulo))},;
			cDesc1+CRLF+cDesc2+CRLF+cDesc3 )

oReport:SetLandScape()

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Criacao da secao utilizada pelo relatorio                               ≥
//≥                                                                        ≥
//≥TRSection():New                                                         ≥
//≥ExpO1 : Objeto TReport que a secao pertence                             ≥
//≥ExpC2 : Descricao da seÁao                                              ≥
//≥ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ≥
//≥        sera considerada como principal para a seÁ„o.                   ≥
//≥ExpA4 : Array com as Ordens do relatÛrio                                ≥
//≥ExpL5 : Carrega campos do SX3 como celulas                              ≥
//≥        Default : False                                                 ≥
//≥ExpL6 : Carrega ordens do Sindex                                        ≥
//≥        Default : False                                                 ≥
//≥                                                                        ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
//adiciona ordens do relatorio

oItemCtb := TRSection():New(oReport, STR0027, {"CTD"}, aOrdem /*{}*/, .F., .F.)  //"Item Contabil"

TRCell():New(oItemCtb,	"CTD_ITEM"	,"CTD",STR0031/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"CODIGO"
TRCell():New(oItemCtb,	"CTD_DESC01","CTD",STR0032/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"DESCRICAO"
TRCell():New(oItemCtb,	"VALOR_COL01",""	,STR0028+" 01"/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "MOV.COD CLASSE VAL"
TRCell():New(oItemCtb,	"VALOR_COL02",""	,STR0028+" 02"/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "MOV.COD CLASSE VAL"
TRCell():New(oItemCtb,	"VALOR_COL03",""	,STR0028+" 03"/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "MOV.COD CLASSE VAL"
TRCell():New(oItemCtb,	"VALOR_COL04",""	,STR0028+" 04"/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "MOV.COD CLASSE VAL"
TRCell():New(oItemCtb,	"VALOR_COL05",""	,STR0028+" 05"/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "MOV.COD CLASSE VAL"
TRCell():New(oItemCtb,	"VALOR_COL06",""	,STR0028+" 06"/*Titulo*/,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "MOV.COD CLASSE VAL"
TRCell():New(oItemCtb,	"VALOR_TOTAL",""	,STR0029/*Titulo*/		,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")  //"TOTAL GERAL"

oItemCtb:SetHeaderPage()
oItemCtb:Cell("CTD_DESC01"):SetLineBreak()
oItemCtb:OnPrintLine({||If( (mv_par24=1)/*lPula*/.And. cArqTmp->TIPOITEM=="1", oReport:SkipLine(),NIL) })

oBreak:= TRBreak():New(oItemCtb,{||.T.},STR0018)

oTotal1:=TRFunction():New(oItemCtb:Cell("VALOR_COL01"),STR0030+" 01","SUM",oBreak,/*cTitle*/,/*cPicture*/,{||RetVlrCol(01)}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
oTotal2:=TRFunction():New(oItemCtb:Cell("VALOR_COL02"),STR0030+" 02","SUM",oBreak,/*cTitle*/,/*cPicture*/,{||RetVlrCol(02)}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
oTotal3:=TRFunction():New(oItemCtb:Cell("VALOR_COL03"),STR0030+" 03","SUM",oBreak,/*cTitle*/,/*cPicture*/,{||RetVlrCol(03)}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
oTotal4:=TRFunction():New(oItemCtb:Cell("VALOR_COL04"),STR0030+" 04","SUM",oBreak,/*cTitle*/,/*cPicture*/,{||RetVlrCol(04)}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
oTotal5:=TRFunction():New(oItemCtb:Cell("VALOR_COL05"),STR0030+" 05","SUM",oBreak,/*cTitle*/,/*cPicture*/,{||RetVlrCol(05)}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
oTotal6:=TRFunction():New(oItemCtb:Cell("VALOR_COL06"),STR0030+" 06","SUM",oBreak,/*cTitle*/,/*cPicture*/,{||RetVlrCol(06)}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
oTotal7:=TRFunction():New(oItemCtb:Cell("VALOR_TOTAL"),STR0029		,"SUM",oBreak,/*cTitle*/,/*cPicture*/,{||RetVlrCol(01)+RetVlrCol(02)+RetVlrCol(03)+RetVlrCol(04)+RetVlrCol(05)+RetVlrCol(06)}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL GERAL"

oTotal1:Disable()
oTotal2:Disable()
oTotal3:Disable()
oTotal4:Disable()
oTotal5:Disable()
oTotal6:Disable()
oTotal7:Disable()
If lIsRedStor
	oTotal_1:=TRFunction():New(oItemCtb:Cell("VALOR_COL01"),STR0030+" 01"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal1:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,'1',,,,,,lZeroPrint,.F.,,lCharSinal) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_2:=TRFunction():New(oItemCtb:Cell("VALOR_COL02"),STR0030+" 02"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal2:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,'1',,,,,,lZeroPrint,.F.,,lCharSinal) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_3:=TRFunction():New(oItemCtb:Cell("VALOR_COL03"),STR0030+" 03"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal3:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,'1',,,,,,lZeroPrint,.F.,,lCharSinal) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_4:=TRFunction():New(oItemCtb:Cell("VALOR_COL04"),STR0030+" 04"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal4:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,'1',,,,,,lZeroPrint,.F.,,lCharSinal) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_5:=TRFunction():New(oItemCtb:Cell("VALOR_COL05"),STR0030+" 05"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal5:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,'1',,,,,,lZeroPrint,.F.,,lCharSinal) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_6:=TRFunction():New(oItemCtb:Cell("VALOR_COL06"),STR0030+" 06"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal6:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,'1',,,,,,lZeroPrint,.F.,,lCharSinal) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_7:=TRFunction():New(oItemCtb:Cell("VALOR_TOTAL"),STR0029			,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal7:GetValue(),,,18,nDecim_,CtbSinalMov(),cPict_,'1',,,,,,lZeroPrint,.F.,,lCharSinal) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL GERAL"
Else
	oTotal_1:=TRFunction():New(oItemCtb:Cell("VALOR_COL01"),STR0030+" 01"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal1:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,,,,,,,lZeroPrint,.F.) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_2:=TRFunction():New(oItemCtb:Cell("VALOR_COL02"),STR0030+" 02"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal2:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,,,,,,,lZeroPrint,.F.) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_3:=TRFunction():New(oItemCtb:Cell("VALOR_COL03"),STR0030+" 03"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal3:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,,,,,,,lZeroPrint,.F.) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_4:=TRFunction():New(oItemCtb:Cell("VALOR_COL04"),STR0030+" 04"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal4:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,,,,,,,lZeroPrint,.F.) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_5:=TRFunction():New(oItemCtb:Cell("VALOR_COL05"),STR0030+" 05"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal5:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,,,,,,,lZeroPrint,.F.) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_6:=TRFunction():New(oItemCtb:Cell("VALOR_COL06"),STR0030+" 06"	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal6:GetValue(),,,17,nDecim_,CtbSinalMov(),cPict_,,,,,,,lZeroPrint,.F.) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL DA COLUNA"
	oTotal_7:=TRFunction():New(oItemCtb:Cell("VALOR_TOTAL"),STR0029			,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(oTotal7:GetValue(),,,18,nDecim_,CtbSinalMov(),cPict_,,,,,,,lZeroPrint,.F.) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"TOTAL GERAL"
EndIf

Return(oReport)

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ReportPrint ∫Autor ≥Paulo Carnelossi   ∫ Data ≥  06/09/06   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Construcao Release 4                                       ∫±±
±±∫          ≥ Funcao de impressao do relatorio acionado pela execucao    ∫±±
±±∫          ≥ do botao <OK> da PrintDialog()                             ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ReportPrint(oReport, cSayItem, cSayClVl, cString, cTitulo)

Local oItemCtb 	:= oReport:Section(1)
Local aClVl			:= {}
Local aClVlRes		:= {}
Local aTamClVl		:=	TAMSX3("CTH_CLVL")
Local aTamCVRes	:=	TAMSX3("CTH_RES")
Local nDivide 		:= 1
Local cPicture
Local cDescMoeda
Local cMascItem	:= ""
Local cMascClVl	:= ""
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cGrupo		:= ""
Local cClVlAnt		:= ""
Local cCVResAnt	:= ""
Local cArqTmp   	:= ""
Local cPergClVl	:= ""
Local cClVlIni		:= ""
Local cClVlFim		:= ""
Local cSegAte   	:= mv_par17
Local cSegmento	:= mv_par18
Local cSegIni		:= mv_par19
Local cSegFim		:= mv_par20
Local cFiltSegm	:= mv_par21
Local nDecimais
Local nDigitAte	:= 0
Local nTotLinha	:= 0
Local nPergClVl	:= 4 //Definido com 4, porque a primeira perg. de cl.valor eh o mv_par05
Local nTamClVl		:= aTamClVl[1]
Local nTamDescCv	:= Len(Alltrim(cSayClvl))
Local nTamCVRes	:= aTamCVRes[1]
Local nSpace		:= 0
Local nSpaceAnt	:= 0
Local nSpaceDep	:= 0
Local nCont			:= 0
Local nVezes		:= 0
Local nDigitos    := 0
Local nPos			:= 0
Local cCodMasc		:= ""

Local lPrintZero	:= Iif(mv_par25=1,.T.,.F.)
Local lImpAntLP	:= Iif(mv_par27 == 1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par13==1,.T.,.F.)

Local dDataLP  		:= mv_par28
Local dDataFim 		:= mv_par02

Local lImpSint		:= If(mv_par11==2,.F.,.T.)
Local aSetOfBook
Local aCtbMoeda	:= {}
Local lRet			:= .T.    , nX//aqui
Local bNormal 		:= {|| cArqTmp->NORMAL }

If lIsRedStor
	bNormal 	:= {|| GetAdvFVal("CTD","CTD_NORMAL",xFilial("CTD")+cArqTmp->ITEM,1,"1") }
Endif


aSetOfBook := CTBSetOf(mv_par12)

If mv_par26 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par26 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par26 == 4		// Divide por milhao
	nDivide := 1000000
EndIf

aCtbMoeda  	:= CtbMoeda(mv_par14,nDivide)
If Empty(aCtbMoeda[1])
	Help(" ",1,"NOMOEDA")
	Return .F.
Endif

cDescMoeda 			:= aCtbMoeda[2]
nDecimais 			:= DecimalCTB(aSetOfBook,mv_par14)
nDecim_				:= nDecimais
cClVlIni			:= Space(nTamClVl)
cClVlFim			:= Repl("Z",nTamClVl)

For nCont := 1 to 6
	cPergClVl	:= &("mv_par"+Strzero(nPergClVl+nCont,2))
	If Empty(cPergClVl)
		AADD(aClVl,space(nTamClVl))
	Else
		AADD(aClVl,cPergClVl)
	EndIf
Next

If mv_par22 == 2 //Se Imprime Codigo Reduzido Cl.Valor
	For nCont := 1 to Len(aClVl)
		dbSelectArea("CTH")
		dbSetOrder(1)
		If (!Empty(aClVl[nCont])) .And. (MsSeek(xFilial("CTH")+aClVl[nCont]))
			AADD(aClVlRes,CTH->CTH_RES)
		Else
			AADD(aClVlRes,Space(nTamCVRes))
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

//Mascara da Cl.Valor
If Empty(aSetOfBook[7])
	cMascClVl	:= ""
Else
	cMascClVl	:= RetMasCtb(aSetOfBook[7],@cSepara2)
EndIf

cPicture 		:= aSetOfBook[4]
cPict_ 			:= cPicture
lZeroPrint      := lPrintZero

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Carrega titulo do relatorio: Analitico / Sintetico			 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
IF mv_par11 == 1
	cTitulo:=	OemToAnsi(STR0007) + Upper(Alltrim(cSayItem)) + OemToAnsi(STR0010) + " 6 " + Upper(Alltrim(cSayClVl))		//"COMPARATIVO SINTETICO DE  "//"ATE"
ElseIf mv_par11 == 2
	cTitulo:=	OemToAnsi(STR0006) + Upper(Alltrim(cSayItem)) + OemToAnsi(STR0010) + " 6 " + Upper(Alltrim(cSayClVl)) 	//"COMPARATIVO ANALITICO DE  " //"ATE"
ElseIf mv_par11 == 3
	cTitulo:=	OemToAnsi(STR0008) + Upper(Alltrim(cSayItem)) + OemToAnsi(STR0010) + " 6 " + Upper(Alltrim(cSayClVl))		//"COMPARATIVO DE  "//"ATE"
EndIf

cTitulo += 	OemToAnsi(STR0009) + DTOC(mv_par01) + Upper(OemToAnsi(STR0010)) + Dtoc(mv_par02) + ;
				OemToAnsi(STR0011) + cDescMoeda

If mv_par16 > "1"
	cTitulo += " (" + Tabela("SL", mv_par16, .F.) + ")"
Endif

oReport:SetTitle(cTitulo)
oReport:SetPageNumber(mv_par15)

For nCont := 1 to Len(aClVl)
	If !Empty(aClVl[nCont])	//Se a coluna estiver com a Classe de Valor Preenchida
		If mv_par22 == 1	//Se for Cod.Normal Cl.Valor
			oItemCtb:Cell("VALOR_COL"+StrZero(nCont,2)):SetTitle(oItemCtb:Cell("VALOR_COL"+StrZero(nCont,2)):Title()+CRLF+Alltrim(aClVl[nCont]))
		Else				//Se for Cod. Reduzido Cl.Valor
			oItemCtb:Cell("VALOR_COL"+StrZero(nCont,2)):SetTitle(oItemCtb:Cell("VALOR_COL"+StrZero(nCont,2)):Title()+CRLF+AllTrim(aClVlRes[nCont]))
		EndIf
	EndIf
Next

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara)
EndIf

If !Empty(cSegmento)
	If Empty(cCodMasc)
		HELP("",1,"CTN_CODIGO")
		oReport:CancelPrint()
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
		HELP("",1,"CTM_CODIGO")
		oReport:CancelPrint()
		Return
	EndIf
EndIf
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta Arquivo Temporario para Impressao							  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CTX","",,,,,mv_par03,mv_par04,cClVlIni,cClVlFim,mv_par14,;
				mv_par16,aSetOfBook,cSegmento,cSegIni,cSegFim,cFiltSegm,;
				.F.,.F.,,"CTD",lImpAntLP,dDataLP,nDivide,"M",.F.,,.F.,,lVlrZerado,.T.,aClVl,lImpSint,cString,oItemCtb:GetAdvplExp()/*aReturn[7]*/)},;
				OemToAnsi(OemToAnsi(STR0014)),;  //"Criando Arquivo Tempor†rio..."
				OemToAnsi(STR0004) +  Upper(Alltrim(cSayItem)+ OemToAnsi(STR0010)+ "6 "+Upper(Alltrim(cSayClVl)) ) )

If Select("cArqTmp") == 0
	oReport:CancelPrint()
	Return
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
	Return
Endif

If mv_par23 == 1       //Codigo Normal Item
	If TIPOITEM == '1'
		oItemCtb:Cell("CTD_ITEM"):SetBlock({|| EntidadeCTB(cArqTmp->ITEM,,,20,.F.,cMascItem,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	Else //desloca 2 posicoes
		oItemCtb:Cell("CTD_ITEM"):SetBlock({|| Space(2)+EntidadeCTB(cArqTmp->ITEM,,,20,.F.,cMascItem,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	EndIf
Else //Codigo Reduzido
	If 	TIPOITEM == '1'
		oItemCtb:Cell("CTD_ITEM"):SetBlock({|| EntidadeCTB(cArqTmp->ITEMRES,,,20,.F.,cMascItem,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	Else //desloca 2 posicoes
		oItemCtb:Cell("CTD_ITEM"):SetBlock({|| Space(2)+EntidadeCTB(cArqTmp->ITEMRES,,,20,.F.,cMascItem,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	EndIf
Endif

oItemCtb:Cell("CTD_DESC01"):SetBlock({|| Substr(cArqTmp->DESCITEM,1,31)})
If lIsRedStor
	oItemCtb:Cell("VALOR_COL01"):SetBlock({|| ValorCTB(cArqTmp->COLUNA1,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL02"):SetBlock({|| ValorCTB(cArqTmp->COLUNA2,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL03"):SetBlock({|| ValorCTB(cArqTmp->COLUNA3,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL04"):SetBlock({|| ValorCTB(cArqTmp->COLUNA4,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL05"):SetBlock({|| ValorCTB(cArqTmp->COLUNA5,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL06"):SetBlock({|| ValorCTB(cArqTmp->COLUNA6,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6),,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
Else
	oItemCtb:Cell("VALOR_COL01"):SetBlock({|| ValorCTB(cArqTmp->COLUNA1,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL02"):SetBlock({|| ValorCTB(cArqTmp->COLUNA2,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL03"):SetBlock({|| ValorCTB(cArqTmp->COLUNA3,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL04"):SetBlock({|| ValorCTB(cArqTmp->COLUNA4,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL05"):SetBlock({|| ValorCTB(cArqTmp->COLUNA5,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_COL06"):SetBlock({|| ValorCTB(cArqTmp->COLUNA6,,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	oItemCtb:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6),,,17,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
Endif

//montar filtro
oItemCtb:SetLineCondition({|| R300FilImp(cSegAte, nDigitAte,cSegmento, cSegIni, cSegFim, cFiltSegm, nPos, nDigitos, lVlrZerado) })

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()

oReport:SetMeter(RecCount())

oItemCtb:Init()

While ! Eof()

	If oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()

	oItemCtb:PrintLine()

	dbSelectArea("cArqTmp")
	dbSkip()

EndDo

oItemCtb:Finish()

dbSelectArea("cArqTmp")
dbClearFilter()
dbCloseArea()
Ferase(cArqTmp+GetDBExtension())
Ferase("cArqInd"+OrdBagExt())
dbselectArea("CT2")

Return



Static Function R300FilImp(cSegAte, nDigitAte,cSegmento, cSegIni, cSegFim, cFiltSegm, nPos, nDigitos, lVlrZerado)
Local lRet := .T.

If mv_par11 == 1					// So imprime Sinteticas
	If TIPOITEM == "2"
		lRet := .F.
	EndIf
ElseIf mv_par11 == 2				// So imprime Analiticas
	If TIPOITEM == "1"
		lRet := .F.
	EndIf
EndIf

If lRet
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)
	If !Empty(cSegAte)
		If Len(Alltrim(ITEM)) > nDigitAte
           lRet := .F.
		Endif
	EndIf
EndIf

If lRet
	If !Empty(cSegmento)
		If Empty(cSegIni) .And. Empty(cSegFim) .And. !Empty(cFiltSegm)
			If  !(Substr(cArqTmp->ITEM,nPos,nDigitos) $ (cFiltSegm) )
				lRet := .F.
			EndIf
		Else
			If Substr(cArqTmp->ITEM,nPos,nDigitos) < Alltrim(cSegIni) .Or. ;
				Substr(cArqTmp->ITEM,nPos,nDigitos) > Alltrim(cSegFim)
				lRet := .F.
			EndIf
		Endif
	EndIf
EndIf

If lRet
	If lVlrZerado  .And. (Abs(cArqTmp->COLUNA1)+Abs(cArqTmp->COLUNA2)+Abs(cArqTmp->COLUNA3)+Abs(cArqTmp->COLUNA4)+Abs(cArqTmp->COLUNA5)+Abs(cArqTmp->COLUNA6))==0
		If CtbExDtFim("CTD")
			dbSelectArea("CTD")
			dbSetOrder(1)
			If MsSeek(xFilial()+cArqTmp->ITEM)
				If !CtbVlDtFim("CTD",mv_par01)
					lRet := .F.
				EndIf
			EndIf
		EndIf
	EndIF
EndIf

dbSelectArea("cArqTmp")

Return(lRet)

Static Function RetVlrCol(nColuna)
Local cCampo 	:= "COLUNA"+If(nColuna<10, Str(nColuna,1), StrZero(nColuna,2))
Local nRetorno 	:= 0
Local nPosCpo  	:= cArqTmp->(FieldPos(cCampo))
Local cSegAte 	:= mv_par17
If nPosCpo > 0
	If mv_par11 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOITEM == "1"
			If cArqTmp->NIVEL1
				nRetorno := cArqTmp->(FieldGet(nPosCpo))
			EndIf
		EndIf
	Else								// Soma Analiticas
		If Empty(cSegAte)				//Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOITEM == "2"
				nRetorno := cArqTmp->(FieldGet(nPosCpo))
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOITEM == "1"
				If cArqTmp->NIVEL1
					nRetorno := cArqTmp->(FieldGet(nPosCpo))
				EndIf
			EndIf
	   	Endif
	EndIf
EndIf

Return(nRetorno)