/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr285.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR  17

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

//Tradução PTG 20080721

// 17/08/2009 -- Filial com mais de 2 caracteres
Static nTamCdoCusto := 20

//--------------------------RELEASE 04------------------------------------------------//
User Function Ctbr285()

	U_CTBR285R4()

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ctbr285R4 ºAutor  ³Paulo Carnelossi    º Data ³  16/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Ctbr285R4()
Local aArea 		:= GetArea()
Local cMensagem		:= ""

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra tela de aviso - Atualizacao de saldos				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMensagem := STR0021+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += STR0022+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += STR0023+chr(13)  		//"rodar a rotina de atualizacao de saldos "

Pergunte("CTR285",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					       ³
//³ mv_par01				// Data Inicial              	       ³
//³ mv_par02				// Data Final                          ³
//³ mv_par03				// C.C. Inicial         		       ³
//³ mv_par04				// C.C. Final   					   ³
//³ mv_par05				// Conta Inicial                       ³
//³ mv_par06				// Conta Final   					   ³
//³ mv_par07				// Imprime Contas:Sintet/Analit/Ambas  ³
//³ mv_par08				// Set Of Books				    	   ³
//³ mv_par09				// Saldos Zerados?			     	   ³
//³ mv_par10				// Moeda?          			     	   ³
//³ mv_par11				// Pagina Inicial  		     		   ³
//³ mv_par12				// Saldos? Reais / Orcados/Gerenciais  ³
//³ mv_par13				// Imprimir ate o Segmento?			   ³
//³ mv_par14				// Filtra Segmento?					   ³
//³ mv_par15				// Conteudo Inicial Segmento?		   ³
//³ mv_par16				// Conteudo Final Segmento?		       ³
//³ mv_par17				// Conteudo Contido em?				   ³
//³ mv_par18				// Pula Pagina                         ³
//³ mv_par19				// Imprime Cod. C.Custo? Normal/Red.   ³
//³ mv_par20				// Imprime Cod. Conta? Normal/Reduzido ³
//³ mv_par21				// Salta linha sintetica?              ³
//³ mv_par22 				// Imprime Valor 0.00?                 ³
//³ mv_par23 				// Divide por?                         ³
//³ mv_par24				// Posicao Ant. L/P? Sim / Nao         ³
//³ mv_par25				// Data Lucros/Perdas?                 ³
//³ mv_par26				// Totaliza periodo ?                  ³
//³ mv_par27				// Se Totalizar ?                  	   ³
//³ mv_par28				// Imprime C.C?Sintet/Analit/Ambas 	   ³
//³ mv_par29				// Imprime Totalizacao de C.C. Sintet. ³
//³ mv_par30				// Tipo de Comparativo?(Movimento/Acumulado)  ³
//³ mv_par31				// Quebra por Grupo Contabil?		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf	

oReport:PrintDialog()

//Limpa os arquivos temporários 
CTBGerClean()

RestArea(aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ctbr285R4 ºAutor  ³Paulo Carnelossi    º Data ³  16/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local cPerg	 	    := "CTR285"
Local cSayCC		:= CtbSayApro("CTT")
LOCAL cString		:= "CTT"
Local cTitulo 		:= STR0003+Upper(Alltrim(cSayCC))+" / "+ STR0011 	//"Comparativo de" " Conta "
Local cDesc1 		:= STR0001			//"Este programa ira imprimir o Balancete Comparativo "
Local cDesc2 		:= Upper(Alltrim(cSayCC)) +" / "+ STR0011	// " Conta "
Local cDesc3 		:= STR0002  //"de acordo com os parametros solicitados pelo Usuario"

Local oReport
Local oCentroCusto
Local nX
Local aOrdem := {}

Local aTamConta	:= TAMSX3("CT1_CONTA")
Local cMascara
Local nTamConta		:= 0
Local aSetOfBook 	:= CTBSetOf(mv_par08)
Local cSeparador	:= ""

If Empty(aSetOfBook[2])
	cMascara	:= GetMv("MV_MASCARA")	
Else
	cMascara	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascara)

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

oReport := TReport():New("CTBR285",cTitulo, cPerg, ;
			{|oReport| If(!ct040Valid(mv_par08), oReport:CancelPrint(), ReportPrint(oReport,cSayCC, cString, cTitulo))},;
			cDesc1+CRLF+cDesc2+CRLF+cDesc3 )

If TamSx3("CTT_CUSTO")[1]> 9
	nTamCdoCusto := 25
EndIf			

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

oCentroCusto := TRSection():New(oReport, cSayCC, {"CTT", "CT1"}, aOrdem /*{}*/, .F., .F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oCentroCusto,	"CTT_CUSTO"	,"CTT",/*Titulo*/,/*Picture*/, 0 /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oCentroCusto,	"CT1_CONTA"	,"CT1",/*Titulo*/,/*Picture*/,nTamConta /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oCentroCusto,	"CTT_DESC01","CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

For nX := 1 To 12
	TRCell():New(oCentroCusto,	"VALOR_PER"+StrZero(nX,2),"",STR0031+StrZero(nX,2)/*Titulo*/,/*Picture*/,TAM_VALOR +1 /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
Next

TRCell():New(oCentroCusto,	"VALOR_TOTAL","",STR0028/*Titulo*/,/*Picture*/,TAM_VALOR/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
oCentroCusto:Cell("VALOR_TOTAL"):Disable()
oCentroCusto:Cell("CTT_CUSTO"):SetLineBreak()
oCentroCusto:Cell("CT1_CONTA"):SetLineBreak()
oCentroCusto:Cell("CTT_CUSTO"):HideHeader() 
oCentroCusto:Cell("CTT_DESC01"):SetLineBreak()
oCentroCusto:Cell("CTT_DESC01"):disable()
oCentroCusto:SetColSpace(0)
oCentroCusto:SetHeaderPage()
oCentroCusto:SetLineBreak()

TRPosition():New(oCentroCusto,'CTT',1,{ || xFilial('CTT')+cArqTmp->CUSTO } )
TRPosition():New(oCentroCusto,'CT1',1,{ || xFilial('CT1')+cArqTmp->CONTA } )

//-----------total do centro custo
oTotCenCusto := TRSection():New(oReport, STR0032+AllTrim(cSayCC), {"CTT", "CT1"}, aOrdem /*{}*/, .F., .F.)	//	"Total - "

TRCell():New(oTotCenCusto,	"CTT_CUSTO"	,"CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTotCenCusto,	"CT1_CONTA"	,"CT1",/*Titulo*/,/*Picture*/,nTamConta /*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTotCenCusto,	"CTT_DESC01","CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

For nX := 1 To 12
	TRCell():New(oTotCenCusto,	"VALOR_PER"+StrZero(nX,2),"",STR0031+StrZero(nX,2)/*Titulo*/,/*Picture*/,TAM_VALOR + 1/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)	//	"PERIODO "
Next

TRCell():New(oTotCenCusto,	"VALOR_TOTAL","",STR0028/*Titulo*/,/*Picture*/,TAM_VALOR/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)	//	"TOTAL PERIODO"
oTotCenCusto:Cell("CTT_CUSTO"):SetLineBreak()
oTotCenCusto:Cell("CTT_DESC01"):SetLineBreak()
oTotCenCusto:Cell("CTT_CUSTO"):Hide()
oTotCenCusto:Cell("CTT_DESC01"):Hide()
oTotCenCusto:Cell("VALOR_TOTAL"):Disable()
oTotCenCusto:SetColSpace(0)
oTotCenCusto:SetLineBreak()
                                 
oTotCenCusto:SetNoFilter({"CTT","CT1"})

//-----------total do centro custo superior
oTotSupCusto := TRSection():New(oReport, STR0032+AllTrim(cSayCC)+STR0034, {"CTT", "CT1"}, aOrdem /*{}*/, .F., .F.)	//	"Total - " + cSayCC + " Superior"

TRCell():New(oTotSupCusto,	"CTT_CUSTO"	,"CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTotSupCusto,	"CTT_DESC01","CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

For nX := 1 To 12
	TRCell():New(oTotSupCusto,	"VALOR_PER"+StrZero(nX,2),"",STR0031+StrZero(nX,2)/*Titulo*/,/*Picture*/,TAM_VALOR +1/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)	//	"PERIODO "
Next

TRCell():New(oTotSupCusto,	"VALOR_TOTAL","",STR0028/*Titulo*/,/*Picture*/,TAM_VALOR/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)	//	"TOTAL PERIODO"
oTotSupCusto:Cell("CTT_CUSTO"):SetLineBreak()
oTotSupCusto:Cell("CTT_DESC01"):SetLineBreak()
oTotSupCusto:Cell("CTT_CUSTO"):Hide()
oTotSupCusto:Cell("CTT_DESC01"):Hide()
oTotSupCusto:Cell("VALOR_TOTAL"):Disable()
oTotSupCusto:SetColSpace(0)
oTotSupCusto:SetLineBreak()

oTotSupCusto:SetNoFilter({"CTT","CT1"})

//---total geral
oTotGerCusto := TRSection():New(oReport, STR0033+AllTrim(cSayCC), {"CTT", "CT1"}, aOrdem /*{}*/, .F., .F.)	//	"Total Geral - "+cSayCC

TRCell():New(oTotGerCusto,	"CTT_CUSTO"	,"CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTotGerCusto,	"CT1_CONTA","CT1",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTotGerCusto,	"CTT_DESC01","CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

For nX := 1 To 12
	TRCell():New(oTotGerCusto,	"VALOR_PER"+StrZero(nX,2),"",STR0031+StrZero(nX,2)/*Titulo*/,/*Picture*/,TAM_VALOR + 1/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)	//	"PERIODO"
Next

TRCell():New(oTotGerCusto,	"VALOR_TOTAL","",STR0028/*Titulo*/,/*Picture*/,TAM_VALOR/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)	//	"TOTAL PERIODO"
oTotGerCusto:Cell("CTT_CUSTO"):SetLineBreak()
oTotGerCusto:Cell("CTT_DESC01"):SetLineBreak()
oTotGerCusto:Cell("CTT_CUSTO"):Hide()
oTotGerCusto:Cell("CTT_DESC01"):Hide()
oTotGerCusto:Cell("VALOR_TOTAL"):Disable()
oTotGerCusto:SetColSpace(0)
oTotGerCusto:SetLineBreak()
                           
oTotGerCusto:SetNoFilter({"CTT","CT1"})

//-----------total do grupo
oTotGrupo := TRSection():New(oReport, STR0032+STR0035, {"CTT", "CT1"}, aOrdem /*{}*/, .F., .F.)

TRCell():New(oTotGrupo,	"CTT_CUSTO"	,"CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTotGrupo,	"CT1_CONTA","CT1",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTotGrupo,	"CTT_DESC01","CTT",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

For nX := 1 To 12
	TRCell():New(oTotGrupo,	"VALOR_PER"+StrZero(nX,2),"",STR0031+StrZero(nX,2)/*Titulo*/,/*Picture*/,TAM_VALOR + 1/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)	//	"PERIODO "
Next

TRCell():New(oTotGrupo,	"VALOR_TOTAL","",STR0028/*Titulo*/,/*Picture*/,TAM_VALOR/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
oTotGrupo:Cell("CTT_CUSTO"):SetLineBreak()
oTotGrupo:Cell("CTT_DESC01"):SetLineBreak()
oTotGrupo:Cell("CTT_CUSTO"):Hide()
oTotGrupo:Cell("CTT_DESC01"):Hide()
oTotGrupo:Cell("VALOR_TOTAL"):Disable()
oTotGrupo:SetColSpace(0)
oTotGrupo:SetLineBreak()
             
oTotGrupo:SetNoFilter({"CTT","CT1"})

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ctbr285R4 ºAutor  ³Paulo Carnelossi    º Data ³  16/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint(oReport,cSayCC, cString, cTitulo)

Local oSection1 	:= oReport:Section(1)
                       
Local aSetOfBook
Local aCtbMoeda	:= {}
Local lRet			:= .T.    
Local nDivide		:= 1
Local cPicture
Local cDescMoeda
Local cCodMasc		:= ""
Local cMascara		:= ""
Local cMascCC		:= ""           
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cGrupo		:= ""
Local cGrupoAnt	:= ""
Local lFirstPage	:= .T.
Local nDecimais
Local cCustoAnt		:= ""
Local cCCResAnt		:= ""
Local lImpConta		:= .F.
Local lImpCusto		:= .T.
Local cCtaIni		:= mv_par05
Local cCtaFim		:= mv_par06
Local nPosAte		:= 0
Local nDigitAte		:= 0
Local cSegAte   	:= mv_par13
Local cArqTmp   	:= ""
Local cCCSup		:= ""//Centro de Custo Superior do centro de custo atual
Local cAntCCSup		:= ""//Centro de Custo Superior do centro de custo anterior
Local lPula			:= Iif(mv_par21==1,.T.,.F.) 
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)
Local lImpAntLP		:= Iif(mv_par24 == 1,.T.,.F.)
Local lVlrZerado	:= Iif(mv_par09==1,.T.,.F.)
Local dDataLP  		:= mv_par25
Local aMeses		:= {}          
Local dDataFim 		:= mv_par02
Local lJaPulou		:= .F.
Local nMeses		:= 1
Local aTotCol		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local aTotCC		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local aTotCCSup		:= {}
Local nTotLinha		:= 0
Local nCont			:= 0
Local aTotGrupo		:= {0,0,0,0,0,0,0,0,0,0,0,0}
Local nTotLinGrp	:= 0

Local lImpSint 		:= Iif(mv_par07 != 2,.T.,.F.)
Local lCT1Sint		:= Iif(mv_par07 != 2,.T.,.F.)
Local lCTTSint		:= Iif(MV_PAR28 != 2,.T.,.F.)
Local lImpTotS		:= Iif(mv_par29 == 1,.T.,.F.)
Local lImpCCSint	:= .T.
Local lNivel1		:= .F. 

Local nPos 			:= 0
Local nDigitos 		:= 0
Local n				:= 0
Local nVezes		:= 0
Local nPosCC		:= 0 
Local nTamaTotCC	:= 0
Local nAtuTotCC		:= 0 
Local cTpComp		:= If( mv_par30 == 1,"M","S" )	//	Comparativo : "M"ovimento ou "S"aldo Acumulado
Local oCentroCusto  := oReport:Section(1)
Local oTotCenCusto  := oReport:Section(2)
Local oTotSupCusto  := oReport:Section(3)
Local oTotGerCusto  := oReport:Section(4)
Local oTotGrupo	 	:= oReport:Section(5)
Local cText_CC
Local cText_CCSup
Local cText_CCGer
Local cText_Grupo
Local Titulo
Local nRegTmp       := 1
Local nColTam		:= IIF(CtbSinalMov(),15,16)
Local bNormal 		:= {|| cArqTmp->NORMAL }
Local cNomeTab		:= ""
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local nTamConta	:= 0

If lIsRedStor
	bNormal 	:= {|| GetAdvFVal("CT1","CT1_NORMAL",xFilial("CT1")+cArqTmp->CONTA,1,"1") }
Endif


PRIVATE nomeProg  	:= "CTBR285"

oReport:SetLandscape()

aSetOfBook := CTBSetOf(mv_par08)

If mv_par23 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par23 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par23 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

If lRet
	aCtbMoeda  	:= CtbMoeda(mv_par10,nDivide)
	If Empty(aCtbMoeda[1])                        
      Help(" ",1,"NOMOEDA")
      oReport:CancelPrint()
      Return
   Endif
Endif


If oReport:lXlsTable 
     Alert('Formato de impressão Relatório em Formato de Tabela não suportado neste relatório')  
     oReport:CancelPrint() 
     Return 
Endif


cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par10)
cPicture		:= aSetOfBook[4]

aPeriodos := ctbPeriodos(mv_par10, mv_par01, mv_par02, .T., .F.)

For nCont := 1 to len(aPeriodos)       
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If aPeriodos[nCont][1] >= mv_par01 .And. aPeriodos[nCont][2] <= mv_par02 
		If nMeses <= 12
			AADD(aMeses,{StrZero(nMeses,2),aPeriodos[nCont][1],aPeriodos[nCont][2]})	
		EndIf
		nMeses += 1           					
	EndIf
Next                                                                   

//Mascara do Centro de Custo
If Empty(aSetOfBook[6])
	cMascCC :=  GetMv("MV_MASCCUS")
Else
	cMascCC := RetMasCtb(aSetOfBook[6],@cSepara1)
EndIf

// Mascara da Conta Contabil
If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
Else
	cMascara := RetMasCtb(aSetOfBook[2],@cSepara2)
EndIf

//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascara)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par07 == 1
	Titulo:=	STR0006+ Upper(Alltrim(cSayCC)) + " / "+ STR0011 		//"COMPARATIVO SINTETICO DE  "
ElseIf mv_par07 == 2
	Titulo:=	STR0005 + Upper(Alltrim(cSayCC)) + " / "+ STR0011		//"COMPARATIVO ANALITICO DE  "
ElseIf mv_par07 == 3
	Titulo:=	STR0007 + Upper(Alltrim(cSayCC)) + " / "+ STR0011		//"COMPARATIVO DE  "
EndIf

Titulo += 	STR0008 + DTOC(mv_par01) + STR0009 + Dtoc(mv_par02) + 	STR0010 + cDescMoeda

If mv_par12 > "1"			
	Titulo += " (" + Tabela("SL", mv_par12, .F.) + ")"
Endif

If mv_par30 = 2
	mv_par26 := 2
	Titulo := AllTrim(Titulo) + " - " + STR0029
EndIf
oReport:SetTitle(Titulo)
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport) } )

If mv_par26 = 1		// Com total, nao imprime descricao
	oCentroCusto:Cell("VALOR_TOTAL"):Enable()
	oTotCenCusto:Cell("VALOR_TOTAL"):Enable()
	oTotSupCusto:Cell("VALOR_TOTAL"):Enable()
	oTotGerCusto:Cell("VALOR_TOTAL"):Enable()
	oTotGrupo:Cell("VALOR_TOTAL"):Enable()

	oCentroCusto:Cell("CTT_DESC01"):Disable()
	oTotCenCusto:Cell("CTT_DESC01"):Disable()
	oTotSupCusto:Cell("CTT_DESC01"):Disable()
	oTotGerCusto:Cell("CTT_DESC01"):Disable()
	oTotGrupo:Cell("CTT_DESC01"):Disable()
Else
	oCentroCusto:Cell("VALOR_TOTAL"):Disable()
	oTotCenCusto:Cell("VALOR_TOTAL"):Disable()
	oTotSupCusto:Cell("VALOR_TOTAL"):Disable()
	oTotGerCusto:Cell("VALOR_TOTAL"):Disable()
	oTotGrupo:Cell("VALOR_TOTAL"):Disable()

	oCentroCusto:Cell("CTT_DESC01"):Enable()
	oTotCenCusto:Cell("CTT_DESC01"):Enable()
	oTotSupCusto:Cell("CTT_DESC01"):Enable()
	oTotGerCusto:Cell("CTT_DESC01"):Enable()
	oTotGrupo:Cell("CTT_DESC01"):Enable()
Endif

For nCont := 1 to Len(aMeses)
	cabec2 := SPACE(1)+Strzero(Day(aMeses[nCont][2]),2)+"/"+Strzero(Month(aMeses[nCont][2]),2)+ " - "
	cabec2 += Strzero(Day(aMeses[nCont][3]),2)+"/"+Strzero(Month(aMeses[nCont][3]),2)
	oCentroCusto:Cell("VALOR_PER"+StrZero(nCont,2)):SetTitle(STR0031+StrZero(nCont,2)+CRLF+cabec2)
Next

oReport:SetPageNumber(mv_par11)


// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
//	For n := 1 to Val(cSegAte)
	//	nDigitAte += Val(Subs(cMascara,n,1))	
	//Next
	nDigitAte	:= CtbRelDig(cSegAte,cMascara)
EndIf		

If !Empty(mv_par14)			//// FILTRA O SEGMENTO Nº
	If Empty(mv_par08)		//// VALIDA SE O CÓDIGO DE CONFIGURAÇÃO DE LIVROS ESTÁ CONFIGURADO
		help("",1,"CTN_CODIGO")
	    oReport:CancelPrint()
	    Return
	Else
		If !Empty(aSetOfBook[5])
			MsgInfo(STR0012+CHR(10)+STR0024,STR0025)
		    oReport:CancelPrint()
		    Return
		Endif
	Endif
	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+aSetOfBook[2])
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == aSetOfBook[2]
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
		help("",1,"CTM_CODIGO")
	    oReport:CancelPrint()
	    Return
	EndIf
EndIf

cFilter := oCentroCusto:GetSQLExp('CTT')

If !Empty(oCentroCusto:GetAdvplExp())
	cString:=oCentroCusto:AUSERFILTER[1][1]
EndIf 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CT3","",mv_par05,mv_par06,mv_par03,mv_par04,,,,,mv_par10,;
				mv_par12,aSetOfBook,mv_par14,mv_par15,mv_par16,mv_par17,;
				.F.,.F.,,"CTT",lImpAntLP,dDataLP,nDivide,cTpComp,.F.,,.T.,aMeses,lVlrZerado,,,lImpSint,cString,oCentroCusto:GetAdvplExp(), (lImpTotS .And. (lCT1Sint .Or. lCTTSint) );
				,,,,,,,,,,,@cNomeTab )},;		
				STR0013,;  //"Criando Arquivo Temporario..."
				STR0003+Upper(Alltrim(cSayCC)) +" / " +  STR0011 )     //"Balancete Verificacao C.CUSTO / CONTA			

If Select("cArqTmp") == 0
	oReport:CancelPrint()
	Return
EndIf

If lImpTotS	//Se totaliza centro de custo 
	aTotCCSup := C285TotSin(cNomeTab,aMeses)
EndIf

dbSelectArea("cArqTmp")
cArqTmp->(dbSetOrder(1))
cArqTmp->(dbGoTop())

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If cArqTmp->(LastRec()) == 0 .And. !Empty(aSetOfBook[5])                                       
	//----------------------------
	// Exclusao da tabela cArqTmp
	//----------------------------
	CTBGerClean()
	oReport:CancelPrint()
	Return
Endif

//linha detalhe
//Se totaliza e mostra a descricao
If mv_par26 = 1 .And. mv_par27 = 2
	oCentroCusto:Cell("CT1_CONTA"):SetBlock({||Left(cArqTmp->DESCCTA,18)})
Else 
	If mv_par20 == 1 //Codigo Normal
		oCentroCusto:Cell("CT1_CONTA"):SetBlock({|| EntidadeCTB(Subs(cArqTmp->CONTA,1,nTamConta),,,nTamConta,.F.,cMascara,cSepara2,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )	
	Else //Codigo Reduzido
		oCentroCusto:Cell("CT1_CONTA"):SetBlock({|| EntidadeCTB(cArqTmp->CTARES,,,nTamConta,.F.,cMascara,cSepara2,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
	Endif
Endif	

// Se nao totalizar ou se totalizar e mostrar a descricao da conta
If mv_par26 == 2 
	oCentroCusto:Cell("CTT_DESC01"):SetBlock({|| Left(cArqTmp->DESCCTA,19) })
Endif           

oCentroCusto:Cell("VALOR_PER01"):SetBlock({|| ValorCTB(cArqTmp->COLUNA1,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER02"):SetBlock({|| ValorCTB(cArqTmp->COLUNA2,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER03"):SetBlock({|| ValorCTB(cArqTmp->COLUNA3,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER04"):SetBlock({|| ValorCTB(cArqTmp->COLUNA4,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER05"):SetBlock({|| ValorCTB(cArqTmp->COLUNA5,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER06"):SetBlock({|| ValorCTB(cArqTmp->COLUNA6,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER07"):SetBlock({|| ValorCTB(cArqTmp->COLUNA7,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER08"):SetBlock({|| ValorCTB(cArqTmp->COLUNA8,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER09"):SetBlock({|| ValorCTB(cArqTmp->COLUNA9,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER10"):SetBlock({|| ValorCTB(cArqTmp->COLUNA10,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER11"):SetBlock({|| ValorCTB(cArqTmp->COLUNA11,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
oCentroCusto:Cell("VALOR_PER12"):SetBlock({|| ValorCTB(cArqTmp->COLUNA12,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )

If mv_par26 == 1   
	oCentroCusto:Cell("VALOR_TOTAL"):enable()
	oCentroCusto:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(nTotLinha,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
EndIf
//------------------total do centro de custo
If mv_par26 == 2
	If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
		oTotCenCusto:Cell("CTT_CUSTO"):SetBlock({|| "" })
		oTotCenCusto:Cell("CTT_DESC01"):SetBlock({|| STR0018+ Upper(Alltrim(cSayCC))+ " : " +EntidadeCTB(cCCResAnt,,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) })
	Else //Se Imprime cod. normal do Centro de Custo
		oTotCenCusto:Cell("CTT_CUSTO"):SetBlock({|| "" })
		oTotCenCusto:Cell("CTT_DESC01"):SetBlock({|| STR0018+ Upper(Alltrim(cSayCC))+ " : "+ EntidadeCTB(cCustoAnt,,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)	 })
	Endif 	   
Else
	oTotCenCusto:Cell("CTT_CUSTO"):SetBlock({|| "" })
	oTotCenCusto:Cell("CTT_DESC01"):SetBlock({||STR0026+;
										If(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2'/*Se Imprime cod. reduzido do centro de Custo e eh analitico*/,;
												Subs(cCCResAnt,1,10),;
												Subs(cCustoAnt,1,10);
											) })  //"TOTAIS: "						
EndIf
If lIsRedStor
	oTotCenCusto:Cell("VALOR_PER01"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 1],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER02"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 2],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER03"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 3],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER04"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 4],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER05"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 5],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER06"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 6],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER07"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 7],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER08"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 8],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER09"):SetBlock({|| StrTran(ValorCTB(aTotCC[ 9],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER10"):SetBlock({|| StrTran(ValorCTB(aTotCC[10],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER11"):SetBlock({|| StrTran(ValorCTB(aTotCC[11],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotCenCusto:Cell("VALOR_PER12"):SetBlock({|| StrTran(ValorCTB(aTotCC[12],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
Else

	If oReport:nDevice == 4
		oTotCenCusto:Cell("CT1_CONTA"):SetBlock({|| "" })
	Else
		oTotCenCusto:Cell("CT1_CONTA"):disable()
	EndIf
	
	oTotCenCusto:Cell("VALOR_PER01"):SetBlock({|| ValorCTB(aTotCC[ 1],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER02"):SetBlock({|| ValorCTB(aTotCC[ 2],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER03"):SetBlock({|| ValorCTB(aTotCC[ 3],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER04"):SetBlock({|| ValorCTB(aTotCC[ 4],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER05"):SetBlock({|| ValorCTB(aTotCC[ 5],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER06"):SetBlock({|| ValorCTB(aTotCC[ 6],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER07"):SetBlock({|| ValorCTB(aTotCC[ 7],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER08"):SetBlock({|| ValorCTB(aTotCC[ 8],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER09"):SetBlock({|| ValorCTB(aTotCC[ 9],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER10"):SetBlock({|| ValorCTB(aTotCC[10],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER11"):SetBlock({|| ValorCTB(aTotCC[11],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotCenCusto:Cell("VALOR_PER12"):SetBlock({|| ValorCTB(aTotCC[12],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
EndIF

If mv_par26 == 1   
	oTotCenCusto:Cell("VALOR_TOTAL"):enable()
	If lIsRedStor
		oTotCenCusto:Cell("VALOR_TOTAL"):SetBlock({|| StrTran(ValorCTB(nTotLinha,,,nColTam,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	Else
		oTotCenCusto:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(nTotLinha,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	EndIf
EndIf
//------------------total do centro de custo superior
If mv_par26 == 2
	If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
		oTotSupCusto:Cell("CTT_CUSTO"):SetBlock({|| STR0018+ Upper(Alltrim(cSayCC))+ " : "+EntidadeCTB(cCCResAnt,,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) })
	Else //Se Imprime cod. normal do Centro de Custo
		oTotSupCusto:Cell("CTT_CUSTO"):SetBlock({|| STR0018+ Upper(Alltrim(cSayCC))+ " : "+EntidadeCTB(cAntCCSup,,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) })
	Endif
Else
	If mv_par19 == 2	.And. cArqTmp->TIPOCC == '2'//Se Imprime cod. reduzido do centro de Custo e eh analitico
		oTotSupCusto:Cell("CTT_CUSTO"):SetBlock({|| STR0026 + Subs(cCCResAnt,1,10)})
	Else //Se Imprime cod. normal do Centro de Custo
		oTotSupCusto:Cell("CTT_CUSTO"):SetBlock({|| STR0026 + Subs(cAntCCSup,1,10)})
	Endif								
EndIf
If lIsRedStor
	oTotSupCusto:Cell("VALOR_PER01"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 1],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER02"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 2],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER03"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 3],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER04"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 4],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER05"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 5],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER06"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 6],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER07"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 7],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER08"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 8],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER09"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][ 9],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER10"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][10],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER11"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][11],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotSupCusto:Cell("VALOR_PER12"):SetBlock({|| StrTran(ValorCTB(aTotCCSup[nPosCC][2][12],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
Else
	oTotSupCusto:Cell("VALOR_PER01"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 1],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER02"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 2],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER03"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 3],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER04"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 4],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER05"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 5],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER06"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 6],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER07"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 7],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER08"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 8],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER09"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][ 9],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER10"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][10],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER11"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][11],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotSupCusto:Cell("VALOR_PER12"):SetBlock({|| ValorCTB(aTotCCSup[nPosCC][2][12],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
EndIf

If mv_par26 == 1   
	oTotSupCusto:Cell("VALOR_TOTAL"):enable()
	If lIsRedStor
		oTotSupCusto:Cell("VALOR_TOTAL"):SetBlock({|| StrTran(ValorCTB(nTotLinha,,,nColTam,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	Else
		oTotSupCusto:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(nTotLinha,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	EndIF
EndIf

//------------------total Geral
If mv_par26 == 2
	oTotGerCusto:Cell("CTT_CUSTO"):SetBlock({|| STR0017 })   //"T O T A I S  D O  P E R I O D O : "
Else //Se Imprime cod. normal do Centro de Custo
	oTotGerCusto:Cell("CTT_CUSTO"):SetBlock({|| STR0027 })   //"TOTAIS  DO  PERIODO: "
EndIf
If lIsRedStor
	oTotGerCusto:Cell("VALOR_PER01"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 1],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER02"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 2],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER03"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 3],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER04"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 4],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER05"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 5],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER06"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 6],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER07"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 7],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER08"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 8],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER09"):SetBlock({|| StrTran(ValorCTB(aTotCol[ 9],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER10"):SetBlock({|| StrTran(ValorCTB(aTotCol[10],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER11"):SetBlock({|| StrTran(ValorCTB(aTotCol[11],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGerCusto:Cell("VALOR_PER12"):SetBlock({|| StrTran(ValorCTB(aTotCol[12],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
Else

	If oReport:nDevice == 4
		oTotGerCusto:Cell("CT1_CONTA"):SetBlock({||''})
	Else
		oTotGerCusto:Cell("CT1_CONTA"):disable()
	EndIf
	
	oTotGerCusto:Cell("VALOR_PER01"):SetBlock({|| ValorCTB(aTotCol[ 1],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER02"):SetBlock({|| ValorCTB(aTotCol[ 2],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER03"):SetBlock({|| ValorCTB(aTotCol[ 3],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER04"):SetBlock({|| ValorCTB(aTotCol[ 4],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER05"):SetBlock({|| ValorCTB(aTotCol[ 5],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER06"):SetBlock({|| ValorCTB(aTotCol[ 6],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER07"):SetBlock({|| ValorCTB(aTotCol[ 7],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER08"):SetBlock({|| ValorCTB(aTotCol[ 8],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER09"):SetBlock({|| ValorCTB(aTotCol[ 9],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER10"):SetBlock({|| ValorCTB(aTotCol[10],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER11"):SetBlock({|| ValorCTB(aTotCol[11],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGerCusto:Cell("VALOR_PER12"):SetBlock({|| ValorCTB(aTotCol[12],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
EndIf

If mv_par26 == 1   
	oTotGerCusto:Cell("VALOR_TOTAL"):enable()
	If lIsRedStor
		oTotGerCusto:Cell("VALOR_TOTAL"):SetBlock({|| StrTran(ValorCTB(nTotGeral,,,nColTam,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	Else
		oTotGerCusto:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(nTotGeral,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	Endif
EndIf


//------------------total do grupo
If mv_par31 == 1
	oTotGrupo:Cell("CTT_CUSTO"):SetBlock({|| "" })
	oTotGrupo:Cell("CTT_DESC01"):SetBlock({|| STR0030 + Left(cGrupo,10) + ")" })		//"GRUPO ("
EndIf
If lIsRedStor
	oTotGrupo:Cell("VALOR_PER01"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 1],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER02"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 2],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER03"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 3],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER04"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 4],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER05"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 5],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER06"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 6],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER07"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 7],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER08"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 8],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER09"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[ 9],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER10"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[10],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER11"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[11],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
	oTotGrupo:Cell("VALOR_PER12"):SetBlock({|| StrTran(ValorCTB(aTotGrupo[12],,,nColTam,nDecimais,CtbSinalMov(),cPicture,"1" , , , , , ,lPrintZero,.F./*lSay*/),"D","") } )
Else

	If oReport:nDevice == 4
		oTotGrupo:Cell("CT1_CONTA"):SetBlock({|| "" })
	Else
		oTotGrupo:Cell("CT1_CONTA"):disable()
	EndIf
	
	oTotGrupo:Cell("VALOR_PER01"):SetBlock({|| ValorCTB(aTotGrupo[ 1],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER02"):SetBlock({|| ValorCTB(aTotGrupo[ 2],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER03"):SetBlock({|| ValorCTB(aTotGrupo[ 3],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER04"):SetBlock({|| ValorCTB(aTotGrupo[ 4],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER05"):SetBlock({|| ValorCTB(aTotGrupo[ 5],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER06"):SetBlock({|| ValorCTB(aTotGrupo[ 6],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER07"):SetBlock({|| ValorCTB(aTotGrupo[ 7],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER08"):SetBlock({|| ValorCTB(aTotGrupo[ 8],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER09"):SetBlock({|| ValorCTB(aTotGrupo[ 9],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER10"):SetBlock({|| ValorCTB(aTotGrupo[10],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER11"):SetBlock({|| ValorCTB(aTotGrupo[11],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
	oTotGrupo:Cell("VALOR_PER12"):SetBlock({|| ValorCTB(aTotGrupo[12],,,nColTam,nDecimais,CtbSinalMov(),cPicture, , , , , , ,lPrintZero,.F./*lSay*/) } )
EndIf
If mv_par26 == 1
	oTotGrupo:Cell("VALOR_TOTAL"):enable()
	If lIsRedStor
		oTotGrupo:Cell("VALOR_TOTAL"):SetBlock({|| StrTran(ValorCTB(nTotLinGrp,,,nColTam,nDecimais,CtbSinalMov(),cPicture, "1", , , , , ,lPrintZero,.F./*lSay*/),"D","") } )		
	Else
		oTotGrupo:Cell("VALOR_TOTAL"):SetBlock({|| ValorCTB(nTotLinGrp,,,nColTam,nDecimais,CtbSinalMov(),cPicture, cArqTmp->NORMAL, , , , , ,lPrintZero,.F./*lSay*/) } )
	EndIF
EndIf

//------------------inicio do relatorio
dbSelectArea("cArqTmp")
cArqTmp->(dbGoTop())
oReport:SetMeter(cArqTmp->(LastRec()))
oCentroCusto:Init()

cGrupo    := cArqTmp->GRUPO

While !Eof()

	If oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()

	cText_CC 	:= ""
	cText_CCSup := ""
	cText_CCGer	:= ""
	cText_Grupo	:= ""

	******************** "FILTRAGEM" PARA IMPRESSAO *************************
	

	If mv_par28 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCC == "2"
			cArqTmp->(dbSkip())
			Loop
		EndIf
	ElseIf mv_par28 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCC == "1"
			cArqTmp->(dbSkip())
			Loop
		EndIf
	EndIf	

	If mv_par07 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCONTA == "2"
			cArqTmp->(dbSkip())
			Loop
		EndIf
	ElseIf mv_par07 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCONTA == "1"
			cArqTmp->(dbSkip())
			Loop
		EndIf
	EndIf
	
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
			cArqTmp->(dbSkip())
			Loop
		Endif
	EndIf

	dbSelectArea("cArqTmp")
	If lVlrZerado	.And. ;
	(Abs(cArqTmp->COLUNA1)+Abs(cArqTmp->COLUNA2)+Abs(cArqTmp->COLUNA3)+Abs(cArqTmp->COLUNA4)+Abs(cArqTmp->COLUNA5)+Abs(cArqTmp->COLUNA6)+Abs(cArqTmp->COLUNA7)+Abs(cArqTmp->COLUNA8)+;
		Abs(cArqTmp->COLUNA9)+Abs(cArqTmp->COLUNA10)+Abs(cArqTmp->COLUNA11)+Abs(cArqTmp->COLUNA12)) == 0	    
			If CtbExDtFim("CTT")  
				dbSelectArea("CTT")
				CTT->(dbSetOrder(1))
				If CTT->(MsSeek(xFilial("CTT")+ cArqTmp->CUSTO))			
					If !CtbVlDtFim("CTT",mv_par01) 
						dbSelectArea("cArqTmp")
						cArqTmp->(dbSkip())
						Loop
					EndIf			
				EndIf
			EndIf			
			
			If CtbExDtFim("CT1")
				dbSelectArea("CT1")
				CT1->(dbSetOrder(1))
				If CT1->(MsSeek(xFilial("CT1")+ cArqTmp->CONTA))
					If !CtbVlDtFim("CT1",mv_par01) 
						dbSelectArea("cArqTmp")
						cArqTmp->(dbSkip())			
						Loop
					EndIf						
				EndIf
			EndIf
		dbSelectArea("cArqTmp")
	EndIf
		
	//Caso faca filtragem por segmento de Conta,verifico se esta dentro 
	//da solicitacao feita pelo usuario. 
	/*If !Empty(mv_par14)
		If Empty(mv_par15) .And. Empty(mv_par16) .And. !Empty(mv_par17)
			If  !(Substr(cArqTMP->CONTA,nPos,nDigitos) $ (mv_par17) ) 
				dbSkip()
				Loop
			EndIf	
		Else
			If Substr(cArqTMP->CONTA,nPos,nDigitos) < Alltrim(mv_par15) .Or. Substr(cArqTMP->CONTA,nPos,nDigitos) > Alltrim(mv_par16)
				dbSkip()
				Loop
			EndIf	
		Endif
	EndIf*/	                                        
	
	************************* ROTINA DE IMPRESSAO *************************

	If mv_par31 == 1														// Quebra por Grupo Contabil

		If !lFirstPage .And.;
		   (cGrupo <> cArqTmp->GRUPO) .Or.;										// Grupo Diferente ou
		   ((cCustoAnt <> cArqTmp->CUSTO) .And. ! Empty(cCustoAnt))				// Centro de Custo Diferente

			oReport:ThinLine()

			nTotLinGrp	:= 0
			For nVezes := 1 to Len(aTotGrupo)
				nTotLinGrp	+= aTotGrupo[nVezes]
			Next

			oTotGrupo:Init()
			oTotGrupo:lPrintHeader := .F.
			cText_Grupo := STR0030 + Left(cGrupo,10) + ")"		//"GRUPO ("

        	oReport:PrintText(cText_Grupo, oReport:Row(), 5)
			oReport:SkipLine()
	        oReport:ThinLine()
			oTotGrupo:PrintLine()
			oTotGrupo:Finish()

			cGrupo		:= cArqTmp->GRUPO
			aTotGrupo	:= {0,0,0,0,0,0,0,0,0,0,0,0}
		EndIf

	Else																					// Nao quebra por Grupo

		If (cCustoAnt <> cArqTmp->CUSTO) .And. ! Empty(cCustoAnt)
			oReport:ThinLine()

			dbSelectArea("CTT")
			CTT->(dbSetOrder(1))
			If CTT->(MsSeek(xFilial("CTT")+cArqTmp->CUSTO))
				cCCSup	:= CTT->CTT_CCSUP
			Else
				cCCSup	:= ""
			EndIf
			
			dbSelectArea("CTT")
			CTT->(dbSetOrder(1))
			If CTT->(MsSeek(xFilial("CTT")+cCustoAnt))
				cAntCCSup	:= CTT->CTT_CCSUP
			Else
				cAntCCSup	:= ""
			EndIf
	
			//Total da Linha 
			nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais 
			For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
				nTotLinha	+= aTotCC[nVezes]
			Next
	        
	        oTotCenCusto:Init()
	        oTotCenCusto:lPrintHeader := .F.
	
			If mv_par26 == 2
				cText_CC := STR0018+ Upper(Alltrim(cSayCC))+ " : " +EntidadeCTB( If(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2' /* Se Imprime cod. reduzido do centro de Custo e eh analitico */,;
				                                                                 cCCResAnt,cCustoAnt),,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)
			Else
		        cText_CC := STR0026+If( mv_par19 == 2 .And. cArqTmp->TIPOCC == '2'/*Se Imprime cod. reduzido do centro de Custo e eh analitico*/,;
			                            Subs(cCCResAnt,1,10),;
										Subs(cCustoAnt,1,10))
			EndIf		
	
	        oReport:PrintText(cText_CC, oReport:Row(), 5)
	        oReport:SkipLine()
	        oReport:ThinLine()
	        oTotCenCusto:PrintLine()
	        //oReport:SkipLine()
	        oTotCenCusto:Finish()
	
			aTotCC 	:= {0,0,0,0,0,0,0,0,0,0,0,0}
	
			If lImpTotS .And. cCCSup <> cAntCCSup .And. !Empty(cAntCCSup) //Se for centro de custo superior diferente
				oReport:SkipLine()
	
				//Total da Linha
				nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
	
				nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]== cAntCCSup })
				If  nPosCC > 0
					For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
						nTotLinha	+= aTotCCSup[nPosCC][2][nVezes]
					Next
			        oTotSupCusto:Init()
					oTotSupCusto:lPrintHeader := .F.
					If mv_par26 == 2
						cText_CCSup := STR0018+Upper(Alltrim(cSayCC))+ " : "+EntidadeCTB( If(mv_par19 == 2,cCCResAnt,cAntCCSup) ,,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)
					Else
						cText_CCSup :=  STR0026 + Subs( IF(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2' /*Se Imprime cod. reduzido do centro de Custo e eh analitico*/,;
						                                   cCCResAnt,;
						                                   cAntCCSup) ,1,10)
					EndIf
	
			        oReport:PrintText(cText_CCSup, oReport:Row(), 5)
	        		oReport:SkipLine()
	        		oReport:ThinLine()
			        oTotSupCusto:PrintLine()
			        oTotSupCusto:Finish()
	
					dbSelectArea("cArqTmp")
					nRegTmp	:= cArqTmp->(Recno())
					dbSelectArea("CTT")
					lImpCCSint	:= .T.
				EndIf
	
				While lImpCCSint
					dbSelectArea("CTT")
					If MsSeek(xFilial()+cAntCCSup) .And. !Empty(CTT->CTT_CCSUP)
						cAntCCSup	:= CTT->CTT_CCSUP
						dbSelectArea("cArqTmp")
						
						//Total da Linha
						nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
						nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]== cAntCCSup })			
						If  nPosCC > 0 							
							For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
								nTotLinha	+= aTotCCSup[nPosCC][2][nVezes]
							Next
					        oTotSupCusto:Init()
							oTotSupCusto:lPrintHeader := .F.
					        
							If mv_par26 == 2
								cText_CCSup := STR0018+Upper(Alltrim(cSayCC))+ " : "+EntidadeCTB( If(mv_par19 == 2,cCCResAnt,cAntCCSup) ,,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)
							Else
								cText_CCSup :=  STR0026 + Subs( IF(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2' /*Se Imprime cod. reduzido do centro de Custo e eh analitico*/,;
								                                   cCCResAnt,;
								                                   cAntCCSup) ,1,10)
							EndIf
	
					        oReport:PrintText(cText_CCSup, oReport:Row(), 5)
					        oReport:SkipLine()
	        				oReport:ThinLine()
					        oTotSupCusto:PrintLine()
	
			        		oTotSupCusto:Finish()
							lImpCCSint	:= .T. 
						EndIF
					Else
						lImpCCSint	:= .F.
					EndIf
				End
				cAntCCSup		:= ""
				cCCSup			:= ""
				dbSelectArea("cArqTmp")
				cArqTmp->(dbGoto(nRegTmp))
			EndIf
		Endif
	    
	EndIf

	If mv_par31 == 1									// Quebra por Grupo Contabil
		If cGrupo != cArqTmp->GRUPO .And. !lFirstPage		// Grupo Diferente
			oReport:EndPage()
		EndIf
	Else
		If mv_par18 == 1 .And. ! Empty(cCustoAnt)
			If cCustoAnt <> cArqTmp->CUSTO //Se o CC atual for diferente do CC anterior
				oReport:EndPage()
			EndIf
		Endif
	EndIf


	//Se mudar de centro de custo
	If 	(cArqTmp->CUSTO <> cCustoAnt .And. !Empty(cCustoAnt)) .Or. lFirstPage .Or. ;
		(mv_par31 == 1 .And. cGrupoAnt <> cArqTmp->GRUPO)

		//Imprime titulo do centro de custo
		oReport:SkipLine()
		oReport:ThinLine()

		//Imprime titulo do centro de custo
		oReport:PrintText(Upper(cSayCC), oReport:Row(), oReport:Col())
		If mv_par19 == 2 .And. cArqTmp->TIPOCC == '2'//Se Imprime Cod Reduzido do C.Custo e eh analitico
			oReport:PrintText(EntidadeCTB(cArqTMP->CCRES,,,25,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/), oReport:Row(), oReport:Col()+200)
		Else //Se Imprime Cod. Normal do C.Custo
			oReport:PrintText(EntidadeCTB(cArqTMP->CUSTO,,,25,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/), oReport:Row(), oReport:Col()+200)
		Endif
		oReport:PrintText(" - " +cArqTMP->DESCCC, oReport:Row(), oReport:Col()+500)

		oReport:SkipLine()
		oReport:ThinLine()
		lFirstPage := .F.
	Endif


	dbSelectArea("cArqTmp")
	//Total da Linha
	nTotLinha	:= cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6+COLUNA7+COLUNA8+COLUNA9+COLUNA10+COLUNA11+COLUNA12)
	If oReport:nDevice != 4	
		oCentroCusto:Cell("CTT_CUSTO"):HideHeader() 
		oCentroCusto:Cell("CTT_CUSTO"):Disable()
	EndIf
	
    oCentroCusto:PrintLine()

	lJaPulou := .F.
	If lPula .And. cArqTmp->TIPOCONTA == "1"				// Pula linha entre sinteticas
		oReport:SkipLine()
		oReport:SkipLine()
		lJaPulou := .T.
	Else
		oReport:SkipLine()
	EndIf			

	************************* FIM   DA  IMPRESSAO *************************

	If mv_par07 != 1					// Imprime Analiticas ou Ambas
		If cArqTmp->TIPOCONTA == "2"
			If (mv_par28 != 1 .And. cArqTmp->TIPOCC == "2")
				For nVezes := 1 to Len(aMeses)
					aTotCol[nVezes]	+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))					
				Next
			ElseIf (mv_par28 == 1 .And. cArqTmp->TIPOCC != "2"	)	//Imprime centro de custo sintetico
				If mv_par07 == 2 	//Imprime contas analiticas
					For nVezes := 1 to Len(aMeses)            
						If Empty(cArqTmp->CCSUP)
							aTotCol[nVezes]	+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))					
						EndIf
					Next         
				ElseIf mv_par07 == 3	//Imprime contas sinteticas e analiticas
					If Empty(cArqTmp->CCSUP)      //Somar somente o centro de custo sintetico
						For nVezes := 1 to Len(aMeses)
							aTotCol[nVezes]	+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))											
						Next         					
					EndIf				
				EndIf
			EndIf	
			For nVezes := 1 to Len(aMeses)
				aTotCC[nVezes] 		+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))									
				aTotGrupo[nVezes]	+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))
			Next	
		Endif
	Else
		If (cArqTmp->TIPOCONTA == "1" .And. Empty(cArqTmp->CTASUP))
			If (mv_par28 != 1 .And. cArqTmp->TIPOCC == "2")
				For nVezes := 1 to Len(aMeses)
					aTotCol[nVezes] 	+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))					
				Next
			ElseIf (mv_par28 == 1 .And. cArqTmp->TIPOCC != "2"	)
				If Empty(cArqTmp->CCSUP)
					For nVezes := 1 to Len(aMeses)
						aTotCol[nVezes] 	+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))			
					Next
				EndIf
			EndIf	
			For nVezes := 1 to Len(aMeses)
				aTotCC[nVezes] 		+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))
				aTotGrupo[nVezes]	+=&("cArqTmp->COLUNA"+Alltrim(Str(nVezes,2)))
			Next
		EndIf		
	Endif

	cCustoAnt := cArqTmp->CUSTO
	cCCResAnt := cArqTmp->CCRES
	cGrupoAnt := cArqTmp->GRUPO
	cGrupo 	  := cArqTmp->GRUPO

	dbSelectarea("cArqTmp")
	cArqTmp->(dbSkip())
	
	If lPula .And. cArqTmp->TIPOCONTA == "1" 			// Pula linha entre sinteticas
		If !lJaPulou
			oReport:SkipLine()
		EndIf	
	EndIf	
EndDO

oCentroCusto:Finish()


IF mv_par31 == 1				// Quebra por Grupo Contabil
    If cGrupo <> cArqTmp->GRUPO
		oReport:ThinLine()

		nTotLinGrp	:= 0
		For nVezes := 1 to Len(aTotGrupo)
			nTotLinGrp	+= aTotGrupo[nVezes]
		Next

		oTotGrupo:Init()
		oTotGrupo:lPrintHeader := .F.
		cText_Grupo := STR0030 + Left(cGrupo,10) + ")"		//"GRUPO ("
	
		oReport:PrintText(cText_Grupo, oReport:Row(), 5)
		oReport:SkipLine()
		oReport:ThinLine()
		oTotGrupo:PrintLine()
		oTotGrupo:Finish()
    EndIf
ELSE

	//Imprime o total do ultimo Conta a ser impresso.
	oReport:ThinLine()
	
	dbSelectArea("CTT")
	CTT->(dbSetOrder(1))
	If CTT->(MsSeek(xFilial("CTT")+cArqTmp->CUSTO))
		cCCSup	:= CTT->CTT_CCSUP	//Centro de Custo Superior
	Else
		cCCSup	:= ""
	EndIf
	
	If MsSeek(xFilial("CTT")+cCustoAnt)
		cAntCCSup := CTT->CTT_CCSUP	//Centro de Custo Superior do Centro de custo anterior.
		cCCRes	  := CTT->CTT_RES
	Else
		cAntCCSup := ""
	EndIf
	
	dbSelectArea("cArqTmp")
	
	//Total da Linha
	nTotLinha	:= 0
	For nVezes := 1 to Len(aMeses)
		nTotLinha	+= aTotCC[nVezes]
	Next
	
	oTotCenCusto:Init()
	oTotCenCusto:lPrintHeader := .F.
	
	If mv_par26 == 2
		cText_CC := STR0018+ Upper(Alltrim(cSayCC))+ " : " +EntidadeCTB( If(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2' /*Se Imprime cod. reduzido do centro de Custo e eh analitico*/,;
		                                                                 cCCResAnt,cCustoAnt),,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)
	Else
	    cText_CC := STR0026+If( mv_par19 == 2 .And. cArqTmp->TIPOCC == '2'/*Se Imprime cod. reduzido do centro de Custo e eh analitico*/,;
	                            Subs(cCCResAnt,1,10),;
								Subs(cCustoAnt,1,10))
	EndIf		
	oReport:PrintText(cText_CC, oReport:Row(), 5)
	oReport:SkipLine()
	oReport:ThinLine()
	oTotCenCusto:PrintLine()
	
	oTotCenCusto:Finish()
	
	If (cArqTmp->TIPOCC == "1" .And. !Empty(cArqTmp->CCSUP)) .Or. (cArqTmp->TIPOCC == "2")	
		aTotCC 	:= {0,0,0,0,0,0,0,0,0,0,0,0}
	EndIf
	
	If lImpTotS .And. cCCSup <> cAntCCSup .And. !Empty(cAntCCSup) //Se for centro de custo superior diferente
	
		//Total da Linha
		nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
		nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]== cAntCCSup })			
		If  nPosCC > 0 							
			For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
				nTotLinha	+= aTotCCSup[nPosCC][2][nVezes]
			Next
	
			oTotSupCusto:Init()
			oTotSupCusto:lPrintHeader := .F.

			If mv_par26 == 2
				cText_CCSup := STR0018+Upper(Alltrim(cSayCC))+ " : "+EntidadeCTB( If(mv_par19 == 2,cCCResAnt,cAntCCSup) ,,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)
			Else
				cText_CCSup :=  STR0026 + Subs( IF(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2' /* Se Imprime cod. reduzido do centro de Custo e eh analitico*/,;
				                                   cCCResAnt,;
				                                   cAntCCSup) ,1,10)
			EndIf
	
	        oReport:PrintText(cText_CCSup, oReport:Row(), 5)
	        oReport:SkipLine()
			oReport:ThinLine()
			oTotSupCusto:PrintLine()	
			oTotSupCusto:Finish()

			dbSelectArea("CTT")
			lImpCCSint	:= .T.
	    EndIf
		
		While lImpCCSint
			dbSelectArea("CTT")
			If CTT->(MsSeek(xFilial("CTT")+cAntCCSup)) .And. !Empty(CTT->CTT_CCSUP)
				cAntCCSup	:= CTT->CTT_CCSUP
				dbSelectArea("cArqTmp")

				//Total da Linha
				nTotLinha	:= 0     			// Incluso esta linha para impressao dos totais
				nPosCC	:= ASCAN(aTotCCSup,{|x| x[1]== cAntCCSup })			
				If  nPosCC > 0 							
					For nVezes := 1 to Len(aMeses)	// por periodo em 09/06/2004 por Otacilio
						nTotLinha	+= aTotCCSup[nPosCC][2][nVezes]
					Next
					
					oTotSupCusto:Init()
					oTotSupCusto:lPrintHeader := .F.

					If mv_par26 == 2
						cText_CCSup := STR0018+Upper(Alltrim(cSayCC))+ " : "+EntidadeCTB( If(mv_par19 == 2,cCCResAnt,cAntCCSup) ,,,nTamCdoCusto,.F.,cMascCC,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)
					Else
						cText_CCSup :=  STR0026 + Subs( IF(mv_par19 == 2 .And. cArqTmp->TIPOCC == '2' /*Se Imprime cod. reduzido do centro de Custo e eh analitico*/,;
						                                   cCCResAnt,;
						                                   cAntCCSup) ,1,10)
					EndIf
	
			        oReport:PrintText(cText_CCSup, oReport:Row(), 5)
			        oReport:SkipLine()
	        		oReport:ThinLine()
			        oTotSupCusto:PrintLine()

					oTotSupCusto:Finish()
					
					lImpCCSint	:= .T.
				EndIf
			Else
				lImpCCSint	:= .F.
			EndIf
		End
		cAntCCSup		:= ""
		cCCSup			:= ""
		dbSelectArea("cArqTmp")
	EndIf

ENDIF

IF ! oReport:Cancel()
	oReport:ThinLine()

	//TOTAL GERAL
	nTotGeral	:= aTotCol[1]+aTotCol[2]+aTotCol[3]+aTotCol[4]+aTotCol[5]+aTotCol[6]+aTotCol[7]
	nTotGeral 	+= aTotCol[8]+aTotCol[9]+aTotCol[10]+aTotCol[11]+aTotCol[12]

	oTotGerCusto:Init()
	oTotGerCusto:lPrintHeader := .F.

	If mv_par26 == 2	//	Se NAO Totaliza Periodo
		cText_CCGer := STR0017		//"T O T A I S  D O  P E R I O D O : "
	Else
		cText_CCGer := STR0027		//"TOTAIS  DO  PERIODO: "
	EndIf

	oReport:PrintText(cText_CCGer, oReport:Row(), 5)
    oReport:SkipLine()
	oReport:ThinLine()
	oTotGerCusto:PrintLine()

	oTotGerCusto:Finish()

	nTotGeral	:= 0

    oReport:ThinLine()

	Set Filter To

EndIF

ASize(aTotCCSup,0)
aTotCCSup := Nil

//----------------------------
// Exclusao da tabela cArqTmp
//----------------------------
CTBGerClean()

dbselectArea("CT2")

Return

//--------------------------------------------------
/*/{Protheus.doc} C285TotSin
Totalização dos valores sintéticos

@author TOTVS
@since 08/07/2018
@version P12.1.17

@param cNomeTab ,caracter,Nome da tabela no banco com os dados a serem processador
@param aMeses   ,array   ,Meses a serem processados

@return aRet    ,array   ,Array com os centros totalizados
/*/
//--------------------------------------------------
Static Function C285TotSin(cNomeTab,aMeses)
Local aSaveArea		:= GetArea()
Local cQryTotSin	:= ""
Local cTabTotSin	:= ""
Local aSupCC		:= {}
Local nVezes		:= 0
Local aRet			:= {}

cTabTotSin := GetNextAlias()

cQryTotSin := " SELECT "
cQryTotSin += "     CUSTO, CCSUP, SUM(COLUNA1) COLUNA1 ,SUM(COLUNA2) COLUNA2 ,SUM(COLUNA3) COLUNA3 ,SUM(COLUNA4) COLUNA4   ,SUM(COLUNA5) COLUNA5   ,SUM(COLUNA6) COLUNA6, "	
cQryTotSin += "                   SUM(COLUNA7) COLUNA7 ,SUM(COLUNA8) COLUNA8 ,SUM(COLUNA9) COLUNA9 ,SUM(COLUNA10) COLUNA10 ,SUM(COLUNA11) COLUNA11 ,SUM(COLUNA12) COLUNA12 "
cQryTotSin += " FROM "
cQryTotSin += "     " + cNomeTab + " ARQ "
cQryTotSin += " WHERE "

cQryTotSin += "     ARQ.CCSUP <> ' ' "

If MV_PAR07 == 2
	cQryTotSin += " AND ARQ.TIPOCONTA = '2' "
Else
	cQryTotSin += " AND ARQ.TIPOCONTA = '1' "
	cQryTotSin += " AND ARQ.CTASUP = ' ' "
EndIf

If  MV_PAR28 <> 3

	cQryTotSin += " AND ( "

	If MV_PAR28 == 2
		cQryTotSin += " ARQ.TIPOCC = '2' "
	ElseIf MV_PAR28 == 1
		cQryTotSin += " ARQ.TIPOCC = '1' "
	EndIf

	cQryTotSin += " OR EXISTS(SELECT CTT_CUSTO FROM " + RetSQLName("CTT") + " CTT WHERE CTT.CTT_FILIAL = '" + XFilial("CTT")  + "' AND CTT.CTT_CUSTO = ARQ.CCSUP AND CTT.CTT_CCSUP = ' ' AND CTT.D_E_L_E_T_ = ' ' ) "

	cQryTotSin += " ) "

EndIf

cQryTotSin += " GROUP BY ARQ.CUSTO, ARQ.CCSUP "

cQryTotSin := ChangeQuery(cQryTotSin)

DBUseArea(.T., "TOPCONN", TCGenQry(,,cQryTotSin), cTabTotSin, .T., .T.)

While (cTabTotSin)->(!Eof())		       

	nPosCC	:= ASCAN(aRet,{|x| x[1]==(cTabTotSin)->CCSUP})

	If  nPosCC == 0 				

		aSupCC := {}

		For nVezes := 1 to Len(aMeses)	
			aAdd(aSupCC,&(cTabTotSin+"->COLUNA"+Alltrim(Str(nVezes,2))))
		Next nVezes

		If Len(aMeses) < 12
			For nVezes := Len(aMeses)+1 to 12
            	aAdd(aSupCC,0)
			Next nVezes
		EndIf

		AADD(aRet,{(cTabTotSin)->CCSUP,aSupCC})

	Else

		For nVezes := 1 to Len(aMeses)				
			aRet[nPosCC][2][nVezes] += &(cTabTotSin+"->COLUNA"+Alltrim(Str(nVezes,2)))
		Next nVezes										

	EndIf

	(cTabTotSin)->(DBSkip())

End

(cTabTotSin)->(DBCloseArea())

RestArea(aSaveArea)

Return aRet

