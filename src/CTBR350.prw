/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR350.CH"
#Include "PROTHEUS.CH"

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

// 17/08/2009 -- Filial com mais de 2 caracteres
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFunao    ณ Ctbr350	ณ Autor ณ Simone Mie Sato       ณ Data ณ 25.04.02 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescriao ณ Comparativo de Tp Saldos (Conta)                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ U_Ctbr350()                                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณNenhum                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Generico                                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum                                                     ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Ctbr350()

U_CTBR350R4()

//Limpa os arquivos temporแrios 
CTBGerClean()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR350R4 บAutor  ณPaulo Carnelossi    บ Data ณ  06/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctbr350R4()

Local aArea        := GetArea()
LOCAL cString		:= "CT1"
Local cTitulo 		:= Upper(STR0013)	//"Comparativo de Conta"

Private NomeProg := FunName()

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

Pergunte("CTR350",.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros					  	   		ณ
//ณ mv_par01				// Data Inicial              	       		ณ
//ณ mv_par02				// Data Final                          		ณ
//ณ mv_par03				// Conta Inicial                       		ณ
//ณ mv_par04				// Conta Final  					   		ณ
//ณ mv_par05				// Imprime Contas: Sintet/Analit/Ambas 		ณ
//ณ mv_par06				// Set Of Books				    	   		ณ	
//ณ mv_par07				// Considera Variacao 0.00 			  		ณ
//ณ mv_par08				// Moeda?          			     	   		ณ
//ณ mv_par09				// Pagina Inicial  		     		   		ณ
//ณ mv_par10				// Tipo de Saldo 1                    		ณ
//ณ mv_par11				// Tipo de Saldo 2                    		ณ
//ณ mv_par12				// Imprimir ate o Segmento?			   		ณ
//ณ mv_par13				// Filtra Segmento?					   		ณ
//ณ mv_par14				// Conteudo Inicial Segmento?		   		ณ
//ณ mv_par15				// Conteudo Final Segmento?		       		ณ
//ณ mv_par16				// Conteudo Contido em?				   		ณ
//ณ mv_par17				// Salta linha sintetica ?			    	ณ
//ณ mv_par18				// Imprime valor 0.00    ?			    	ณ
//ณ mv_par19				// Divide por ?                   			ณ
//ณ mv_par20				// Imprime Cod. Conta ? Normal/Reduzido 	ณ
//ณ mv_par21				// Quebra por Grupo Contabil?           	ณ
//ณ mv_par22				// Dados da Conta?                          ณ
//ณ                                        1-Codigo 2-Descricao 3-Ambos ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInterface de impressao                                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := ReportDef(cString, cTitulo)

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
ฑฑบPrograma  ณCTBR350R4 บAutor  ณPaulo Carnelossi    บ Data ณ  06/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Construcao Release 4                                       บฑฑ
ฑฑบ          ณ Definicao das colunas do relatorio                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportDef( cString, cTitulo)

Local cPerg		:= "CTR350"
LOCAL cDesc1 		:= STR0001	//"Este programa ira imprimir o Comparativo de Tipos de Saldos de Contas"
LOCAL cDesc2 		:= STR0002  //"de acordo com os parametros solicitados pelo Usuario"
Local cDesc3 		:= ""
Local oReport
Local oConta
Local aOrdem 		:= {}
Local aCtbMoeda  	:= CtbMoeda(mv_par08)
Local cDescMoeda 	:= aCtbMoeda[2]
Local cMascara
Local nTamConta		:= 0
Local aTamConta		:= TAMSX3("CT1_CONTA")
Local aSetOfBook 	:= CTBSetOf(mv_par06)
Local cSeparador	:= ""


If Empty(aSetOfBook[2])
	cMascara	:= GetMv("MV_MASCARA")	
Else
	cMascara	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascara)


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

oReport := TReport():New("CTBR350",cTitulo, cPerg, ;
			{|oReport| If(!ct040Valid(mv_par06), oReport:CancelPrint(), ReportPrint(oReport, cString, cTitulo))},;
			cDesc1+CRLF+cDesc2+CRLF+cDesc3 )

oReport:SetTotalInLine(.F.)
oReport:SetLandScape()

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
oConta := TRSection():New(oReport, STR0024, {cSTring,"cArqTmp"}, aOrdem, .F., .F.)  //"Plano de Contas"

TRCell():New(oConta,"CT1_CONTA"		,"CT1"	,/*Titulo*/         ,/*Picture*/,  nTamConta,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Codigo"###"Centro de Custo"
TRCell():New(oConta,"CT1_DESC01"	,"CT1"	,STR0023 			,/*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Descricao"
TRCell():New(oConta,"MOVIM_01"		,""		,STR0021 + " (01)"	,/*Picture*/,18/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"CENTER")   //"Saldo"
TRCell():New(oConta,"MOVIM_02"		,""		,STR0021 + " (02)"	,/*Picture*/,18/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"CENTER")   //"Saldo"
TRCell():New(oConta,"VARIACAO"		,""		,STR0019 + " %"	 	,/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"CENTER") //"Variacao"###"Em"
TRCell():New(oConta,"DIFERENCA"		,""		,STR0019 + " "+STR0020+" "+Capital(cDescMoeda),/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT") //"Variacao"###"Em"

oConta:Cell("CT1_DESC01"):SetLineBreak()
oConta:SetTotalInLine(.F.)
//oConta:SetHeaderPage(.T.)
//oConta:SetTotalText(STR0012)

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

Static Function ReportPrint(oReport, cString, cTitulo)

Local nX
Local aSetOfBook	:= {}
Local aCtbMoeda	:= {}
Local cDescMoeda
Local nTamConta		:= 0
Local oConta		:= oReport:Section(1)
Local nDivide		:= 1
Local cMascara1  	:=	""
Local cSepara1		:=	""
Local cPicture		:=	""     
Local cTpSld1		:=	mv_par10		//Tipo de Saldo 1
Local cTpSld2		:=	mv_par11	    //Tipo de Saldo 2   
Local cDescSld1		:=	Tabela("SL",mv_par10,.F.)
Local cDescSld2		:=	Tabela("SL",mv_par11,.F.)
Local cArqTmp		:=	""
Local cSegAte   	:= mv_par12
Local cGrupo		:= ""
Local nDecimais 	:=	2
Local nMovSld1		:=	0
Local nMovSld2		:=	0
Local nGrupo1		:= 	0
Local nGrupo2		:= 	0                     
Local nTotSld1		:=	0
Local nTotSld2		:=	0
Local nDigitAte		:=	0
Local lVar0			:= Iif(mv_par07 == 1,.T.,.F.)
Local lJaPulou		:= .F.
Local lPrintZero	:= Iif(mv_par18==1,.T.,.F.)
Local lPulaSint		:= Iif(mv_par17==1,.T.,.F.) 
Local lFirstPage	:= .T.
Local dDataFim 		:= mv_par02
Local lCt1Sint		:= If(mv_par05==2,.F.,.T.)
Local nPos 			:= 0
Local nDigitos 		:= 0         
Local cTipoLanc   	:= ""   //na quebra de sintetica pular uma linha
Local cTpValor		:= GetMV("MV_TPVALOR")
//montar filtro para impressao da linha
Local bLineCondition := {|| R350FiltroLinha(nDigitAte, nPos, nDigitos) }
Local oBreakPer,oBreakMov, oTotMov1, oTotMov2, oTotPer1, oTotPer2
Local _NORMAL, _NNIVEL01                               
Local aTamVal := TAMSX3("CT2_VALOR") 
Local nTot1 := 0
Local nTot2 := 0 

Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local bNormal 		:= {|| cArqTmp->TIPOCONTA }
Local lCharSinal	:= .F.
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local cSeparador := ""
Local aPergunte := {}
Local lConsiVar	:= .F.

DbSelectArea("CT1")
DbSetOrder(1)

If lIsRedStor
	bNormal	:= {|| cArqTmp->NORMAL }
Endif

aPergunte := Ctr350Pg("CTR350")
lConsiVar := Len( aPergunte[2] ) > 22 .And. AllTrim( aPergunte[2][23]:CX1_VAR01 ) == "mv_par23"
Iif(lConsiVar == .T.,lConsiVar := Iif(MV_PAR23 == 2,.T.,.F.), .F.)
		
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se usa Set Of Books + Plano Gerencial (Se usar Planoณ
//ณ Gerencial -> montagem especifica para impressao)				  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aSetOfBook := CTBSetOf(mv_par06)

If Empty(aSetOfBook[2])
	cMascara	:= GetMv("MV_MASCARA")	
Else
	cMascara	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascara)

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
	oReport:CancelPrint()
	Return
Endif

cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par08)

If Empty(aSetOfBook[2])
	cMascara1	:= GetMv("MV_MASCARA")
Else
	cMascara1	:= RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf
cPicture 	:= aSetOfBook[4]

cTitulo += SPACE(01)+"( "+cDescSld1+" / "+cDescSld2+" ) "
cTitulo	+= STR0014+ Alltrim(cDescMoeda)+STR0015+Dtoc(mv_par01)
cTitulo	+= STR0016+ Dtoc(mv_par02) 

If nDivide > 1
	cTitulo  += " (" + STR0017 + Alltrim(Str(nDivide)) + ")"
EndIf

oReport:SetTitle(cTitulo)
oReport:SetPageNumber(mv_par09)
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

oConta:Cell("CT1_CONTA"	):SetTitle(UPPER(STR0022))  //"Conta"
oConta:Cell("CT1_DESC01"):SetTitle(UPPER(STR0023))  //"Descricao"
oConta:Cell("MOVIM_01"	):SetTitle(UPPER(Alltrim(cDescSld1))+CRLF+"(01)")
oConta:Cell("MOVIM_02"	):SetTitle(UPPER(Alltrim(cDescSld2))+CRLF+"(02)")
If lConsiVar 
	oConta:Cell("VARIACAO"	):SetTitle(UPPER(Alltrim(STR0027))+CRLF+Alltrim(STR0029)+STR0020+" "+Alltrim(STR0030))   //"Valor (02/01) Real"###"Em"
	oConta:Cell("DIFERENCA"	):SetTitle(UPPER(Alltrim(STR0028)+" "+STR0020+CRLF+Alltrim(cDescMoeda)+Alltrim(STR0029)))//"Valor (02/01) "###"Em Real"
Else
	oConta:Cell("VARIACAO"	):SetTitle(UPPER(Alltrim(STR0019))+CRLF+"(01/02) "+STR0020+" %")   //"Variacao"###"Em"
	oConta:Cell("DIFERENCA"	):SetTitle(UPPER(STR0019+" "+STR0020+CRLF+Alltrim(cDescMoeda)+" (01-02)"))//"Variacao"###"Em"
Endif 

If !Empty(mv_par13)			//// FILTRA O SEGMENTO Nบ
	If Empty(mv_par06)		//// VALIDA SE O CำDIGO DE CONFIGURAวรO DE LIVROS ESTม CONFIGURADO
		help("",1,"CTN_CODIGO")
		oReport:CancelPrint()
		Return
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+aSetOfBook[2])
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == aSetOfBook[2]
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(val(mv_par13),2)
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
		Return
	EndIf
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao					     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CtbGerCmp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
			mv_par01,mv_par02,"CT7",mv_par03,mv_par04,,,,,,,;
			mv_par08,cTpSld1,cTpSld2,aSetOfBook,mv_par13,mv_par14,mv_par15,mv_par16,;
			mv_par12,lVar0,nDivide,mv_par21,,,lCt1Sint,cString,oConta:GetAdvplExp()/*aReturn[7]*/)},;
			STR0010,;  //"Criando Arquivo Tempor rio..."
			STR0006)  				//"Comparativo de Tipo de Saldos "		
					
// Verifica Se existe filtragem Ate o Segmento
If !Empty(mv_par12)
	nDigitAte := CtbRelDig(mv_par12,cMascara1) 	
EndIf		

If Select("cArqTmp") == 0
	oReport:CancelPrint()
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
	oReport:CancelPrint()
	Return
Endif

If mv_par21 == 1  // Grupo Diferente - Totaliza e Quebra
	oBreakMov:= TRBreak():New(oConta, {|| cArqTmp->GRUPO }, {|| AllTrim(STR0011) + " ("+ cGrupo + ")" } )
	oBreakMov:OnBreak( { |x| cGrupo := x } )
	oBreakMov:SetPageBreak(.T.)

	// Imprime total do Movimento 01
	oTotMov1 := TRFunction():New( oConta:Cell("MOVIM_01"), ,"ONPRINT", oBreakMov,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.,oConta)
	oTotMov1:SetFormula( { || ValorCTB(nGrupo1,,,16,nDecimais,.T.,""/*cPicture*/,cArqTmp->TIPOCONTA, , , ,cTpValor , ,lPrintZero,.F./*lSay*/) } )
	
	// Imprime total do Movimento 02
	oTotMov2 := TRFunction():New( oConta:Cell("MOVIM_02"), ,"ONPRINT", oBreakMov,/*Titulo*/,/*cPicture*/,/*uForumla*/,.F.,.F.,.F.,oConta)
	oTotMov2:SetFormula( { || ValorCTB(nGrupo2,,,16,nDecimais,.T.,""/*cPicture*/,cArqTmp->TIPOCONTA, , , ,cTpValor , ,lPrintZero,.F./*lSay*/) } )

EndIf

oBreakPer:= TRBreak():New(oConta, {|| } , {|| AllTrim(STR0012) } )
oBreakPer:OnBreak( { || cArqTmp->(Eof()) } )
//oBreakPer:SetPageBreak(.T.)

// Imprime total do Periodo 01
oTotPer1 := TRFunction():New( oConta:Cell("MOVIM_01"), ,"ONPRINT", oBreakPer,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.,.F.,oConta)
oTotPer1:SetFormula( { || ValorCTB(nTotSld1,,,16,nDecimais,.T.,""/*cPicture*/,cArqTmp->TIPOCONTA, , , ,cTpValor , ,lPrintZero,.F./*lSay*/) } )

// Imprime total do Periodo 02
oTotPer2 := TRFunction():New( oConta:Cell("MOVIM_02"), ,"ONPRINT", oBreakPer,/*Titulo*/,/*cPicture*/,/*uForumla*/,.F.,.F.,.F.,oConta)
oTotPer2:SetFormula( { || ValorCTB(nTotSld2,,,16,nDecimais,.T.,""/*cPicture*/,cArqTmp->TIPOCONTA, , , ,cTpValor , ,lPrintZero,.F./*lSay*/) } )


oConta:OnPrintLine({||(If( lPulaSint .and. cArqTmp->TIPOCONTA == "2" .And. cTipoLanc=="1", oReport:SkipLine(),NIL), cTipoLanc := cArqTmp->TIPOCONTA ) })

If mv_par22 == 2
	oConta:Cell("CT1_CONTA"):Disable()
Else    //	Se imprime o Codigo da Conta
	If mv_par20 == 2 //Se Imprime Codigo Reduzido
		oConta:Cell("CT1_CONTA"):SetBlock( { || EntidadeCTB(cArqTmp->CTARES,,,nTamConta,.F.,cMascara1,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	Else    //Se Imprime Codigo Normal  
		oConta:Cell("CT1_CONTA"):SetBlock( { || EntidadeCTB(cArqTmp->CONTA,,,nTamConta,.F.,cMascara1,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)})
	EndIf
EndIf

If mv_par22 == 1
	oConta:Cell("CT1_DESC01"):Disable()
Else	
	oConta:Cell("CT1_DESC01"):SetBlock( { || Substr(cArqTmp->DESCCTA,1,40) })
EndIf

oConta:Cell("MOVIM_01"	):SetBlock( { || ValorCTB(cArqTmp->MOVIMENTO1,,,16,nDecimais,.T.,cPicture,Eval(bNormal), , , ,cTpValor , ,lPrintZero,.F./*lSay*/) } )
oConta:Cell("MOVIM_02"	):SetBlock( { || ValorCTB(cArqTmp->MOVIMENTO2,,,16,nDecimais,.T.,cPicture,Eval(bNormal), , , ,cTpValor , ,lPrintZero,.F./*lSay*/) } )
If lIsRedStor
	oConta:Cell("VARIACAO"	):SetBlock( { || ValorCTB(Iif(Eval(bNormal)=='1',cArqTmp->(MOVIMENTO2/MOVIMENTO1),cArqTmp->(MOVIMENTO1/MOVIMENTO2))*100,,,17,nDecimais,.F.,cPicture,, , , ,cTpValor , ,lPrintZero,.F./*lSay*/,lColDbCr) } )
	oConta:Cell("DIFERENCA"	):SetBlock( { || ValorCTB(Iif(Eval(bNormal)=='1',cArqTmp->(MOVIMENTO2-MOVIMENTO1),cArqTmp->(MOVIMENTO1-MOVIMENTO2)),,,17,nDecimais,.T.,cPicture,, , , ,cTpValor , ,lPrintZero,.F./*lSay*/,lColDbCr) } )
Else
	oConta:Cell("VARIACAO"	):SetBlock( { || ValorCTB(Iif(lConsiVar,cArqTmp->(MOVIMENTO2/MOVIMENTO1),cArqTmp->(MOVIMENTO1/MOVIMENTO2))*100,,,17,nDecimais,.F.,cPicture,Eval(bNormal), , , ,cTpValor , ,lPrintZero,.F./*lSay*/,lColDbCr) } )
	oConta:Cell("DIFERENCA"	):SetBlock( { || ValorCTB(cArqTmp->(MOVIMENTO1-MOVIMENTO2),,,17,nDecimais,.T.,cPicture,Eval(bNormal), , , ,cTpValor , ,lPrintZero,.F./*lSay*/,lColDbCr) } )
Endif

nTot1 := cArqTmp->MOVIMENTO1
nTot2 := cArqTmp->MOVIMENTO2

oReport:SetMeter(RecCount())
oConta:Init()

cGrupo 	 := cArqTmp->GRUPO
_NNIVEL01 := cArqTmp->NIVEL1

dbSelectArea("cArqTmp")
DbGotop()

_NORMAL := cArqTmp->NORMAL 
cGrupo := cArqTmp->GRUPO

While cArqTmp->( ! Eof() )

	If oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()
	
	CT1->(dbseek(xFilial("CT1")+cArqtmp->CONTA))
	//Atualizacao de totalizadores 
	
	CTR350Tot(@nTotSld1,@nTotSld2,@nGrupo1,@nGrupo2)
	            
	If ! Eval(bLineCondition)

		cArqTmp->(dbSkip())
		
		_NORMAL := cArqTmp->NORMAL 
		cGrupo := cArqTmp->GRUPO

		Loop
	EndIf
    
	oConta:PrintLine()
    
	If(cArqTmp->NIVEL1)
		_NNIVEL01 := cArqTmp->NIVEL1
	EndIf	
    
	cArqTmp->(dbSkip())        

	IF Alltrim(cGrupo) <> Alltrim(cArqTmp->GRUPO) 
       	IF ! EMPTY(cArqTmp->CONTA)
			If Eval(bLineCondition)   // adicionada valida็ใo para ao trocar de grupo validar se a linha deve ser impressa 
				oConta:PrintLine() 
			EndIf
			// Zera Grupos
			nGrupo1	:= 0
			nGrupo2	:= 0
			CTR350Tot(@nTotSld1,@nTotSld2,@nGrupo1,@nGrupo2)
			cArqTmp->(dbSkip())
		ENDIF		
    ENDIF
   
	_NORMAL := cArqTmp->NORMAL 
	cGrupo := cArqTmp->GRUPO
EndDo

oConta:Finish()

dbSelectArea("cArqTmp")
dbClearFilter()
dbCloseArea()
FErase(cArqTmp+GetDBExtension())
FErase("cArqInd"+OrdBagExt())
dbselectArea("CT1")


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออหอออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณR350FiltroLinha บAutorณPaulo Carnelossi  บ Data ณ 06/09/06  บฑฑ
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
Static Function R350FiltroLinha(nDigitAte, nPos, nDigitos)
Local lRet := .T.

If mv_par05 == 1					// So imprime Sinteticas
	If cArqTmp->TIPOCONTA == "2"
		lRet := .F.
	EndIf
ElseIf mv_par05 == 2				// So imprime Analiticas
	If cArqTmp->TIPOCONTA == "1"
		lRet := .F.
	EndIf
EndIf
	
If lRet	
	If mv_par07 == 1 
		If cArqTmp->MOVIMENTO1 == 0 .And. cArqTmp->MOVIMENTO2 == 0
			If CtbExDtFim("CT1") 
				dbSelectArea("CT1")
				dbSetOrder(1)
				If MsSeek(xFilial()+cArqTmp->CONTA)
					If !CtbVlDtFim("CT1",mv_par01) 
			     		dbSelectArea("cArqTmp")
						lRet := .F.
					EndIf
				EndIf		
			EndIf
			dbSelectArea("cArqTmp")		
		EndIf	
	EndIf
EndIf

If lRet	
	//Filtragem ate o Segmento da Conta( antigo nivel do SIGACON)		
	If !Empty(mv_par12)
		If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
			lRet := .F.
		Endif
	EndIf
EndIf	

/*If lRet	
	If !Empty(mv_par13)
		If Empty(mv_par14) .And. Empty(mv_par15) .And. !Empty(mv_par16)
			If  !(Substr(cArqTMP->CONTA,nPos,nDigitos) $ (mv_par16) ) 
				lRet := .F.
			EndIf	
		Else
			If Substr(cArqTMP->CONTA,nPos,nDigitos) < Alltrim(mv_par14) .Or. ;
				Substr(cArqTMP->CONTA,nPos,nDigitos) > Alltrim(mv_par15)
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
ฑฑษออออออออออัออออออออออออออออหอออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCTR350Tot  บAutorณAlvaro Camillo neto Data ณ 10/06/13       บฑฑ
ฑฑฬออออออออออุออออออออออออออออสอออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para totaliza็ใo dos Valores                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CTR350Tot(nTotSld1,nTotSld2,nGrupo1,nGrupo2)
	            
If mv_par05 == 1	// So imprime Sinteticas  - Soma Sinteticas
	If cArqTmp->TIPOCONTA == "1"
		If cArqTmp->NIVEL1
			nTotSld1 	+= cArqTmp->MOVIMENTO1
			nTotSld2 	+= cArqTmp->MOVIMENTO2
			nGrupo1	+= cArqTmp->MOVIMENTO1
			nGrupo2	+= cArqTmp->MOVIMENTO2
		EndIf
	EndIf
Else         //Se soma as analiticas ou ambas
	If Empty(mv_par12)  //Se nao tiver filtragem ate o nivel
		If cArqTmp->TIPOCONTA == "2"
			nTotSld1 	+= cArqTmp->MOVIMENTO1
			nTotSld2 	+= cArqTmp->MOVIMENTO2
			nGrupo1	+= cArqTmp->MOVIMENTO1
			nGrupo2	+= cArqTmp->MOVIMENTO2
		EndIf                                              
	Else		//Se tiver filtragem ate o nivel, somo somente as sinteticas
		If cArqTmp->TIPOCONTA == "1"
			If cArqTmp->NIVEL1
				nTotSld1 	+= cArqTmp->MOVIMENTO1
				nTotSld2 	+= cArqTmp->MOVIMENTO2
				nGrupo1	+= cArqTmp->MOVIMENTO1
				nGrupo2	+= cArqTmp->MOVIMENTO2
			EndIf
		Endif
	EndIf	
EndIf
	
Return
       
//-------------------------------------------------------------------
/*{Protheus.doc} Ctr350Pg("CTR350")
Retorna array com o pergunte

@author Totvs
   
@version P12
@since   07/02/2023
@return  Nil
@obs	 
*/
//------------------------------------------------------------------
Static Function Ctr350Pg(cPerg)
//Verifica se a nova pergunta realmente foi criada, para nใo dar error log no cliente
Local oPerg	:= FWSX1Util():New()
Local aPergunte
oPerg:AddGroup(cPerg)
oPerg:SearchGroup()
aPergunte := oPerg:GetGroup(cPerg)

Return(aPergunte)
