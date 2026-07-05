/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr310.Ch"
#Include "PROTHEUS.Ch"

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

// 17/08/2009 -- Filial com mais de 2 caracteres

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณ Ctbr310  ณ Autor ณ Simone Mie Sato       ณ Data ณ 09.04.02 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Balancete Comparativo de Cl.Vlr  x Item s/ 6 meses. 		  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ Ctbr310				      								  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno	 ณ Nenhum       											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso 		 ณ SIGACTB      											  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum									  				  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Ctbr310()

U_CTBR310R4()

//Limpa os arquivos temporแrios 
CTBGerClean()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR310R4 บAutor  ณPaulo Carnelossi    บ Data ณ  06/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctbr310R4()

Local aArea 		:= GetArea()
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
LOCAL cString		:= "CTH"
Local lAtSlComp	:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local cMensagem	:= ""
Local cTitulo 		:= OemToAnsi(STR0003)+Upper(Alltrim(cSayClVl))+" / "+ Upper(Alltrim(cSayItem)) 	//"Comparativo de"
Private aoTotCal, aoTotImp, _NORMAL, _CLVL
Private aoTotGerCal, aoTotGerImp
Private NomeProg := FunName()

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Mostra tela de aviso - processar exclusivo					 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cMensagem := OemToAnsi(STR0021)+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += OemToAnsi(STR0022)+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += OemToAnsi(STR0023)+chr(13)  		//"rodar a rotina de atualizacao de saldos "

IF !lAtSlComp
	IF !MsgYesNo(cMensagem,OemToAnsi(STR0009))	//"ATEN€O"
		Return
	Endif
EndIF

Pergunte("CTR310",.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros					       ณ
//ณ mv_par01				// Data Inicial              	       ณ
//ณ mv_par02				// Data Final                          ณ
//ณ mv_par03				// Cl.Valor Inicial     		       ณ
//ณ mv_par04				// Cl.Valor Final				   ณ
//ณ mv_par05				// Item Inicial                        ณ
//ณ mv_par06				// Item Final   					   ณ
//ณ mv_par07				// Imprime Itens:Sintet/Analit/Ambas   ณ
//ณ mv_par08				// Set Of Books				    	   ณ
//ณ mv_par09				// Saldos Zerados?			     	   ณ
//ณ mv_par10				// Moeda?          			     	   ณ
//ณ mv_par11				// Pagina Inicial  		     		   ณ
//ณ mv_par12				// Saldos? Reais / Orcados/Gerenciais  ณ
//ณ mv_par13				// Imprimir ate o Segmento?			   ณ
//ณ mv_par14				// Filtra Segmento?					   ณ
//ณ mv_par15				// Conteudo Inicial Segmento?		   ณ
//ณ mv_par16				// Conteudo Final Segmento?		       ณ
//ณ mv_par17				// Conteudo Contido em?				   ณ
//ณ mv_par18				// Pula Pagina                         ณ
//ณ mv_par19				// Imprime Cod. Cl.Vlr ? Normal/Red.   ณ
//ณ mv_par20				// Imprime Cod. Item? Normal/Reduzido  ณ
//ณ mv_par21				// Salta linha sintetica?              ณ
//ณ mv_par22 				// Imprime Valor 0.00?                 ณ
//ณ mv_par23 				// Divide por?                         ณ
//ณ mv_par24				// Posicao Ant. L/P? Sim / Nao         ณ
//ณ mv_par25				// Data Lucros/Perdas?                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInterface de impressao                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := ReportDef( cSayItem, cSayClVl, cString, cTitulo)

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf	

oReport:PrintDialog()

RestArea(aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR310R4 บAutor  ณPaulo Carnelossi    บ Data ณ  06/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ Definicao das colunas do relatorio                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef( cSayItem, cSayClVl, cString, cTitulo)

Local cPerg			:= "CTR310"
Local cDesc1 		:= OemToAnsi(STR0001)			//"Este programa ira imprimir o Balancete Comparativo "
Local cDesc2 		:= Upper(Alltrim(cSayClVl)) +" / "+ Upper(Alltrim(cSayItem))
Local cDesc3 		:= OemToansi(STR0002)  //"de acordo com os parametros solicitados pelo Usuario"
Local oReport
Local oItemCtb
Local oBreak
Local aOrdem := {}
Local nTam	 := 17 + iif(lIsRedStor,2,0)


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

oReport := TReport():New("CTBR310",cTitulo, cPerg, ;
			{|oReport| If(!ct040Valid(mv_par08), oReport:CancelPrint(), ReportPrint(oReport, cSayItem, cSayClVl, cString, cTitulo))},;
			cDesc1+CRLF+cDesc2+CRLF+cDesc3 )

oReport:SetLandScape()
oReport:SetTotalInLine(.F.)
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

oClValor := TRSection():New(oReport, cSayClVl, {"CTH"}, aOrdem /*{}*/, .F., .F.)

TRCell():New(oClValor,	"CTH_CLVL"	,"CTH",STR0024/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"CODIGO"
TRCell():New(oClValor,	"CTH_DESC01","CTH",STR0025/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"DESCRICAO"

oClValor:SetLineStyle()

oItemCtb := TRSection():New(oClValor, cSayItem,, aOrdem /*{}*/, .F., .F.)

TRCell():New(oItemCtb,	"CTD_ITEM"	,"CTD",STR0024/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oItemCtb,	"CTD_DESC01","CTD",STR0025/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oItemCtb,	"VALOR_COL01",""	,STR0026+" 01"/*Titulo*/,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"MOV. PERIODO"
TRCell():New(oItemCtb,	"VALOR_COL02",""	,STR0026+" 02"/*Titulo*/,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"MOV. PERIODO"
TRCell():New(oItemCtb,	"VALOR_COL03",""	,STR0026+" 03"/*Titulo*/,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"MOV. PERIODO"
TRCell():New(oItemCtb,	"VALOR_COL04",""	,STR0026+" 04"/*Titulo*/,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"MOV. PERIODO"
TRCell():New(oItemCtb,	"VALOR_COL05",""	,STR0026+" 05"/*Titulo*/,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"MOV. PERIODO"
TRCell():New(oItemCtb,	"VALOR_COL06",""	,STR0026+" 06"/*Titulo*/,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"MOV. PERIODO"
TRCell():New(oItemCtb,	"VALOR_TOTAL",""	,STR0027/*Titulo*/,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"TOTAL GERAL"

oItemCtb:SetHeaderPage()
oItemCtb:Cell("CTD_DESC01"):SetLineBreak()

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint บAutor ณPaulo Carnelossi   บ Data ณ  06/09/06   บฑฑ
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
Static Function ReportPrint(oReport, cSayItem, cSayClVl, cString, cTitulo)

Local oClValor 	:= oReport:Section(1)
Local oItemCtb 	:= oReport:Section(1):Section(1)
Local nX
Local aSetOfBook
Local aCtbMoeda	:= {}
Local nDivide		:= 1
Local aColunas		:= {}
Local CbTxt			:= Space(10)
Local CbCont		:= 0
Local limite		:= 220
Local cabec1  		:= ""
Local cabec2		:= ""
Local cPicture
Local cDescMoeda
Local cCodMasc
Local cMascItem	:= ""
Local cMascClVl	:= ""           
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cGrupo		:= ""
Local lFirstPage	:= .T.
Local nDecimais
Local cClVlAnt		:= ""
Local cCVResAnt	:= ""
Local nTamConta	:= Len(CriaVar("CT1_CONTA"))
Local cCtaIni		:= Space(nTamConta)
Local cCtaFim		:= Repl('Z',nTamConta)            
Local nDigitAte	:= 0
Local cSegAte   	:= mv_par13
Local cArqTmp   	:= ""
Local lPula			:= Iif(mv_par21==1,.T.,.F.) 
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)
Local lImpAntLP	:= Iif(mv_par24 == 1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par09==1,.T.,.F.)
Local dDataLP  	:= mv_par25
Local aMeses		:= {}          
Local dDataFim 	:= mv_par02
Local lJaPulou		:= .F.
Local nMeses		:= 1
Local aTotCol		:= {0,0,0,0,0,0}
Local aTotClVl		:= {0,0,0,0,0,0}	
Local nTotLinha	:= 0
Local nCont			:= 0
Local lImpSint 	:= If(mv_par07==2,.F.,.T.)
Local nVezes		:= 0
Local nDigitos 	:= 0
Local nPos 			:= 0
Local cTipoLanc   //na quebra de sintetica pular uma linha

//montar filtro para impressao da linha
Local bLineCondition := {|| R310FiltroLinha(lVlrZerado, cSegAte, nDigitAte, nPos, nDigitos) }

Local bNormal 		:= {|| cArqTmp->NORMAL }

If lIsRedStor
	bNormal 	:= {|| GetAdvFVal("CTD","CTD_NORMAL",xFilial("CTD")+cArqTmp->ITEM,1,"1") }
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
//ณ Gerencial -> montagem especifica para impressao)				  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aSetOfBook := CTBSetOf(mv_par08)

If mv_par23 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par23 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par23 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

aCtbMoeda  	:= CtbMoeda(mv_par10,nDivide)
If Empty(aCtbMoeda[1])                        
	Help(" ",1,"NOMOEDA")
	oReport:CancelPrint()
	Return
Endif

cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)

aPeriodos := ctbPeriodos(mv_par10, mv_par01, mv_par02, .T., .F.)

For nCont := 1 to len(aPeriodos)       
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If aPeriodos[nCont][1] >= mv_par01 .And. aPeriodos[nCont][2] <= mv_par02 
		If nMeses <= 6
			AADD(aMeses,{StrZero(nMeses,2),aPeriodos[nCont][1],aPeriodos[nCont][2]})	
		EndIf
		nMeses += 1           					
	EndIf
Next                                                                   

//Se o periodo solicitado for maior que 6 meses, eh exibido uma mensagem que sera im-
//presso somente de 6 meses
If nMeses > 7                  
	cMensagem := OemToAnsi(STR0019)+OemToAnsi(STR0020)			
	MsgAlert(cMensagem)
EndIf                                                      

// Mascara do Item Contabil
If Empty(aSetOfBook[7])
	cMascItem := ""
Else
	cMascItem := RetMasCtb(aSetOfBook[7],@cSepara1)
EndIf

//Mascara da Classe de Valor
If !Empty(aSetOfBook[8])
	cMascClVl:= RetMasCtb(aSetOfBook[8],@cSepara2)
EndIf

cPicture 		:= aSetOfBook[4]

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Carrega titulo do relatorio: Analitico / Sintetico			 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
IF mv_par07 == 1
	cTitulo	:=	OemToAnsi(STR0006) + Upper(Alltrim(cSayClVl)) + " / "+ Upper(Alltrim(cSayItem))	//"COMPARATIVO SINTETICO DE  "
ElseIf mv_par07 == 2
	cTitulo	:=	OemToAnsi(STR0005)+ Upper(Alltrim(cSayClVl)) + " / "+Upper(Alltrim(cSayItem)) 		//"COMPARATIVO ANALITICO DE  "
ElseIf mv_par07 == 3
	cTitulo	:=	OemToAnsi(STR0007) + Upper(Alltrim(cSayClVl)) + " / "+ Upper(Alltrim(cSayItem))	//"COMPARATIVO DE  "
EndIf

cTitulo += 	OemToAnsi(STR0008) + DTOC(mv_par01) + OemToAnsi(STR0009) + Dtoc(mv_par02) + ;
				OemToAnsi(STR0010) + cDescMoeda

If mv_par12 > "1"			
	cTitulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
Endif

oReport:SetTitle(cTitulo)
oReport:SetPageNumber(mv_par11)
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

For nCont := 1 to Len(aMeses)
    oItemCtb:Cell("VALOR_COL"+StrZero(nCont,2)):SetTitle(oItemCtb:Cell("VALOR_COL"+StrZero(nCont,2)):Title()+CRLF+DTOC(aMeses[nCont][2])+"-"+DTOC(aMeses[nCont][3])) 
Next

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascItem) 	
EndIf		

//// VALIDA FILTRAGEM DE SEGMENTOS
If !Empty(mv_par14)			//// FILTRA O SEGMENTO Nบ
	If Empty(mv_par08)		//// VALIDA SE O CำDIGO DE CONFIGURAวรO DE LIVROS ESTม CONFIGURADO
		HELP("",1,"CTN_CODIGO")
		oReport:CancelPrint()
		Return
	Else
		If !Empty(aSetOfBook[5])
			MsgInfo("O plano gerencial ainda nใo estแ disponํvel para este relat๓rio."+CHR(10)+"Altere a configura็ใo de livros...","Config. de Livros...")
			oReport:CancelPrint()
			Return
		Endif
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+aSetOfBook[7])
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == aSetOfBook[7]
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(val(mv_par14),2)
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
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao							  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CTX","",,,,,mv_par05,mv_par06,mv_par03,mv_par04,mv_par10,;
				mv_par12,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17,;
				.F.,.F.,,"CTH",lImpAntLP,dDataLP,nDivide,"M",.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,cString,oClValor:GetAdvplExp()/*aReturn[7]*/)},;
				OemToAnsi(OemToAnsi(STR0013)),;  //"Criando Arquivo Tempor rio..."
				OemToAnsi(STR0003)+Upper(Alltrim(cSayClVl)) +" / " +  Upper(Alltrim(cSayItem)) )     //"Balancete Verificacao CL.VALOR /ITEM				

If Select("cArqTmp") == 0
	oReport:CancelPrint()
	Return
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

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()

TRPosition():New( oClValor, "CTH", 1, {|| xFilial("CTH") + cArqTmp->CLVL  })
TRPosition():New( oClValor, "CTD", 1, {|| xFilial("CTD") + cArqTmp->ITEM  })

If mv_par19 == 2 	//Se Imprime Cod Reduzido da Cl.Valor
	oClValor:Cell("CTH_CLVL"):SetBlock({||EntidadeCTB(cArqTmp->CLVLRES,,,20,.F.,cMascClVl,cSepara2,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
Else //Se Imprime Cod. Normal da Cl.Valor
	oClValor:Cell("CTH_CLVL"):SetBlock({||EntidadeCTB(cArqTmp->CLVL,,,20,.F.,cMascClVl,cSepara2,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
Endif          
oClValor:Cell("CTH_DESC01"):SetBlock({|| cArqTMP->DESCCLVL})

If mv_par20 == 1       //Codigo Normal Item
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
oItemCtb:Cell("VALOR_COL01"):SetBlock({|| ValorCTB(cArqTmp->COLUNA1,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
oItemCtb:Cell("VALOR_COL02"):SetBlock({|| ValorCTB(cArqTmp->COLUNA2,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
oItemCtb:Cell("VALOR_COL03"):SetBlock({|| ValorCTB(cArqTmp->COLUNA3,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
oItemCtb:Cell("VALOR_COL04"):SetBlock({|| ValorCTB(cArqTmp->COLUNA4,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
oItemCtb:Cell("VALOR_COL05"):SetBlock({|| ValorCTB(cArqTmp->COLUNA5,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
oItemCtb:Cell("VALOR_COL06"):SetBlock({|| ValorCTB(cArqTmp->COLUNA6,,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )
oItemCtb:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6),,,17,nDecimais,CtbSinalMov(),cPicture, Eval(bNormal), , , , , ,lPrintZero,.F./*lSay*/) } )

//criacao da quebra para imprimir apos finish da secao
oBreak:= TRBreak():New(oReport, {|| _CLVL }, {||STR0018+ Upper(cSayClVl)+ " : "+cClVlAnt} )//"T O T A I S  D O  "

If mv_par18 == 2			
	oBreak:SetPageBreak(.F.)
Else
	oBreak:SetPageBreak(.T.)
EndIf

oBreak1:= TRBreak():New(oReport, {|| .T. }, STR0017 )  //"T O T A I S  D O  P E R I O D O: "

//criacao dos totalizadores 
aoTotCal := {}
aoTotImp := {}
aoTotGerCal := {0,0,0,0,0,0,0}
aoTotGerImp := {}

For nX := 1 TO 6
	aAdd(aoTotCal, TRFunction():New(oItemCtb:Cell("VALOR_COL"+StrZero(nX,2)),STR0028+" "+StrZero(nX,2)	,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))  //"TOTAL DA COLUNA"
	aoTotCal[Len(aoTotCal)]:Disable()
	aAdd(aoTotImp, TRFunction():New(oItemCtb:Cell("VALOR_COL"+StrZero(nX,2)),STR0028+" "+StrZero(nX,2)	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))  //"TOTAL DA COLUNA"
	aAdd(aoTotGerImp, TRFunction():New(oItemCtb:Cell("VALOR_COL"+StrZero(nX,2)),STR0028+" "+StrZero(nX,2)	,"ONPRINT",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))  //"TOTAL DA COLUNA"
	aoTotGerImp[Len(aoTotGerImp)]:Disable()

Next
aAdd(aoTotCal, TRFunction():New(oItemCtb:Cell("VALOR_TOTAL"),STR0028+" "+StrZero(nX,2)	,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))  //"TOTAL DA COLUNA"
aoTotCal[Len(aoTotCal)]:Disable()
aAdd(aoTotImp, TRFunction():New(oItemCtb:Cell("VALOR_TOTAL"),STR0028+" "+StrZero(nX,2)	,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))  //"TOTAL DA COLUNA"
aAdd(aoTotGerImp, TRFunction():New(oItemCtb:Cell("VALOR_TOTAL"),STR0028+" "+StrZero(nX,2)	,"ONPRINT",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))  //"TOTAL DA COLUNA"
aoTotGerImp[Len(aoTotGerImp)]:Disable()

//setar as formulas para trfunction
aoTotCal[01]:SetFormula({||R310RetVlrCol(01)})
aoTotCal[02]:SetFormula({||R310RetVlrCol(02)})
aoTotCal[03]:SetFormula({||R310RetVlrCol(03)})
aoTotCal[04]:SetFormula({||R310RetVlrCol(04)})
aoTotCal[05]:SetFormula({||R310RetVlrCol(05)})
aoTotCal[06]:SetFormula({||R310RetVlrCol(06)})
aoTotCal[07]:SetFormula({||R310RetVlrCol(01)+R310RetVlrCol(02)+R310RetVlrCol(03)+R310RetVlrCol(04)+R310RetVlrCol(05)+R310RetVlrCol(06)})

aoTotImp[01]:SetFormula({||aoTotGerCal[01] += aoTotCal[01]:GetValue() ,ValorCTB(aoTotCal[01]:GetValue(),,,17,nDecimais,.F.,cPicture,IIf(lIsRedStor,"1",_NORMAL), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotImp[02]:SetFormula({||aoTotGerCal[02] += aoTotCal[02]:GetValue() ,ValorCTB(aoTotCal[02]:GetValue(),,,17,nDecimais,.F.,cPicture,IIf(lIsRedStor,"1",_NORMAL), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotImp[03]:SetFormula({||aoTotGerCal[03] += aoTotCal[03]:GetValue() ,ValorCTB(aoTotCal[03]:GetValue(),,,17,nDecimais,.F.,cPicture,IIf(lIsRedStor,"1",_NORMAL), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotImp[04]:SetFormula({||aoTotGerCal[04] += aoTotCal[04]:GetValue() ,ValorCTB(aoTotCal[04]:GetValue(),,,17,nDecimais,.F.,cPicture,IIf(lIsRedStor,"1",_NORMAL), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotImp[05]:SetFormula({||aoTotGerCal[05] += aoTotCal[05]:GetValue() ,ValorCTB(aoTotCal[05]:GetValue(),,,17,nDecimais,.F.,cPicture,IIf(lIsRedStor,"1",_NORMAL), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotImp[06]:SetFormula({||aoTotGerCal[06] += aoTotCal[06]:GetValue() ,ValorCTB(aoTotCal[06]:GetValue(),,,17,nDecimais,.F.,cPicture,IIf(lIsRedStor,"1",_NORMAL), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotImp[07]:SetFormula({||aoTotGerCal[07] += aoTotCal[07]:GetValue() ,ValorCTB(aoTotCal[07]:GetValue(),,,17,nDecimais,.F.,cPicture,IIf(lIsRedStor,"1",_NORMAL), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})


aoTotGerImp[01]:SetFormula({||ValorCTB(aoTotGerCal[01] ,,,17,nDecimais,CtbSinalMov(),cPicture,IIf(lIsRedStor,"1",""), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotGerImp[02]:SetFormula({||ValorCTB(aoTotGerCal[02] ,,,17,nDecimais,CtbSinalMov(),cPicture,IIf(lIsRedStor,"1",""), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotGerImp[03]:SetFormula({||ValorCTB(aoTotGerCal[03] ,,,17,nDecimais,CtbSinalMov(),cPicture,IIf(lIsRedStor,"1",""), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotGerImp[04]:SetFormula({||ValorCTB(aoTotGerCal[04] ,,,17,nDecimais,CtbSinalMov(),cPicture,IIf(lIsRedStor,"1",""), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotGerImp[05]:SetFormula({||ValorCTB(aoTotGerCal[05] ,,,17,nDecimais,CtbSinalMov(),cPicture,IIf(lIsRedStor,"1",""), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotGerImp[06]:SetFormula({||ValorCTB(aoTotGerCal[06] ,,,17,nDecimais,CtbSinalMov(),cPicture,IIf(lIsRedStor,"1",""), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})
aoTotGerImp[07]:SetFormula({||ValorCTB(aoTotGerCal[07] ,,,17,nDecimais,CtbSinalMov(),cPicture,IIf(lIsRedStor,"1",""), , , , , ,lPrintZero,.F./*lSay*/,,.F.)})


oItemCtb:OnPrintLine({||(If( (mv_par21==1)/*lPula*/.And. (cTipoLanc=="1".Or. (cArqTmp->TIPOITEM == "1" .And. cTipoLanc == "2")), oReport:SkipLine(),NIL), cTipoLanc := cArqTmp->TIPOITEM) })

oReport:SetMeter(RecCount())

oClValor:Init()

_CLVL := cArqTmp->CLVL 
_NORMAL := cArqTmp->NORMAL

While !Eof()

	cClVlAnt		:= cArqTmp->CLVL

	If oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()

	If Eval(bLineCondition)

		oClValor:PrintLine()
		oReport:FatLine()
		oReport:SkipLine()
	
		oItemCtb:Init()
		
		While ! Eof() .And. cArqTmp->CLVL == cClVlAnt
		
			oItemCtb:PrintLine()
	
		    dbSelectArea("cArqTmp")
			dbSkip()
		
		EndDo

		oItemCtb:Finish()
		

    Else

	    dbSelectArea("cArqTmp")
		dbSkip()
    
	EndIf
	
	_NORMAL := cArqTmp->NORMAL
	_CLVL   := cArqTmp->CLVL
	
EndDO
oClValor:Finish()

For nX := 1 TO 7
	aoTotGerImp[nX]:Enable()
Next

dbSelectArea("cArqTmp")
dbClearFilter()
dbCloseArea()
Ferase(cArqTmp+GetDBExtension())
Ferase("cArqInd"+OrdBagExt())
dbselectArea("CT2")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออหอออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณR310FiltroLinha บAutorณPaulo Carnelossi  บ Data ณ 06/09/06  บฑฑ
ฑฑฬออออออออออุออออออออออออออออสอออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ Filtro da Linha a ser impressa                             บฑฑ
ฑฑบ          ณ Retorno : .F. - nao imprime    .T. - imprime linha         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R310FiltroLinha(lVlrZerado, cSegAte, nDigitAte, nPos, nDigitos)
Local lRet := .T.

If lRet
	If mv_par07 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOITEM == "2"
			lRet := .F.
		EndIf
	ElseIf mv_par07 == 2				// So imprime Analiticas
		If cArqTmp->TIPOITEM == "1"
			lRet := .F.
		EndIf
	EndIf
EndIf

If lRet	
	If lVlrZerado	.And. cArqTmp->(Abs(COLUNA1)+Abs(COLUNA2)+Abs(COLUNA3)+Abs(COLUNA4)+Abs(COLUNA5)+Abs(COLUNA6)) == 0	    
		If CtbExDtFim("CTH")  
			dbSelectArea("CTH")
			dbSetOrder(1)
			If MsSeek(xFilial()+ cArqTmp->CLVL)			
				If !CtbVlDtFim("CTH",mv_par01) 
					lRet := .F.
				EndIf			
			EndIf
		EndIf			
	EndIf			
EndIf

If lRet			
	If CtbExDtFim("CTD")
		dbSelectArea("CTD")
		dbSetOrder(1)
		If MsSeek(xFilial()+ cArqTmp->ITEM)					
			If !CtbVlDtFim("CTD",mv_par01) 
				lRet := .F.
			EndIf						
		EndIf
	EndIf
EndIf

If lRet		
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->ITEM)) > nDigitAte
			lRet := .F.
		Endif
	EndIf
EndIf

/*If lRet	
	//Caso faca filtragem por segmento de item,verifico se esta dentro 
	//da solicitacao feita pelo usuario. 
	If !Empty(mv_par14)
		If Empty(mv_par15) .And. Empty(mv_par16) .And. !Empty(mv_par17)
			If  !(Substr(cArqTMP->ITEM,nPos,nDigitos) $ (mv_par17) ) 
				lRet := .F.
			EndIf	
		Else
			If Substr(cArqTMP->ITEM,nPos,nDigitos) < Alltrim(mv_par15) .Or. Substr(cArqTMP->ITEM,nPos,nDigitos) > Alltrim(mv_par16)
				lRet := .F.
			EndIf	
		Endif
	EndIf	                                      
EndIf*/	                                      
	
dbSelectArea("cArqTmp")

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหออออออัอออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณR310RetVlrCol บAutor ณPaulo Carnelossi   บ Data ณ 06/09/06  บฑฑ
ฑฑฬออออออออออุออออออออออออออสออออออฯอออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ Retorna o valor da coluna para trfunction                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function R310RetVlrCol(nColuna)
Local cCampo 	:= "COLUNA"+If(nColuna<10, Str(nColuna,1), StrZero(nColuna,2))
Local nRetorno 	:= 0
Local nPosCpo  	:= cArqTmp->(FieldPos(cCampo))

If nPosCpo > 0
	If mv_par07 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOITEM == "1"
			If cArqTmp->NIVEL1
				nRetorno := cArqTmp->(FieldGet(nPosCpo))
			EndIf
		EndIf
	Else								// Soma Analiticas
		If Empty(mv_par13)				//Se nao tiver filtragem ate o nivel
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