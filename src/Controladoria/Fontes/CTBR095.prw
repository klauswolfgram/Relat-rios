/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR095.Ch"
#Include "PROTHEUS.Ch"

#define TAM_DESCRICAO  	50
#define TAM_TIPO		01
#define TAM_DATAL		10
#define TAM_LOTE		06
#define TAM_SUBLOTE	    03
#define TAM_DOC		    06
#define TAM_LINHA		03
#define TAM_LINRUS		LEN(CT2->CT2_LINHA)
#define TAM_NUMERO		TAM_LOTE+TAM_SUBLOTE+TAM_DOC+TAM_LINHA+3
#define TAM_NUMRUS		TAM_LOTE+TAM_SUBLOTE+TAM_DOC+TAM_LINRUS+3
#define TAM_SEQLAN		03
#define TAM_SQLRUS		LEN(CT2->CT2_SEQLAN)+1
#define TAM_SEQHIST  	03
#define TAM_EMPORI		03
#define TAM_FILORI		03
#define TAM_VALOR		20
#define TAM_TOTAL		161
#define TAM_CONTA      	Len(CriaVar("CT1_CONTA"))
#define TAM_HIST       	30 //Len(CriaVar("CT2_HIST"))
 
STATIC __oTempTable
Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

// 17/08/2009 -- Filial com mais de 2 caracteres

//Tradução PTG 

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR095	³ Autor ³ Cicero J. Silva   	³ Data ³ 14.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Relat. Lancamentos por Centro de Custo          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_CTBR095()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 	     ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR095()

Local aCtbMoeda		:= {}
Local aSetOfBook	:= {}
Local lOk := .T.

Local oReport

Private cPerg  := "CTR095"

// Acesso somente pelo SIGACTB                
If ( !AMIIn(34) ) 
	lOk := .F.
EndIf

If ! Pergunte("CTR095", .T. )
	lOk := .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books -> Conf. da Mascara / Valores   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Ct040Valid(mv_par09)
	lOk := .F.
Else
	aSetOfBook := CTBSetOf(mv_par09)
EndIf

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par07)
	If Empty(aCtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		lOk := .F.
	Endif
Endif

If lOk
	oReport := ReportDef(aSetOfBook,aCtbMoeda)
	oReport:PrintDialog()
EndIf

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  07/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aSetOfBook - Array de configuracao set of book             º±±
±±º          ³ aCtbMoeda  - Array ref. a moeda solicitada                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(aSetOfBook,aCtbMoeda)

Local oReport
Local cReport	   := "CTBR095"
Local cSayCusto	   := CtbSayApro("CTT")
Local cMoeda	   := mv_par07

// Retorna Decimais
aCtbMoeda := CTbMoeda(cMoeda)
nDecimais := aCtbMoeda[5]

// VERIFICAR A NECESSIDADE
oReport := TReport():New(cReport,STR0006 + Alltrim(cSayCusto),cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,aCtbMoeda)},STR0001+Alltrim(cSayCusto)+STR0002+STR0003)//"Emissao do Relatorio de Lançamentos por "+centro de custo ### "Este programa ira imprimir o Relatorio de Lancamentos por "+centro de custo ### " de acordo com os parametros sugeridos " ### "pelo usuario"
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.F.)

// Sessao 1
oCcusto := TRSection():New(oReport,STR0032,{"cArqTmp","CTT"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	//"Centro de Custo"
TRCell():New(oCcusto,"CCUSTO"   ,"cArqTmp",cSayCusto,/*Picture*/,TAM_CONTA,/*lPixel*/,/*{|| code-block de impressao }*/)//Centro de Custo
TRCell():New(oCcusto,"DESCCUSTO",         ,STR0038  ,/*Picture*/,TAM_DESCRICAO,/*lPixel*/,/*{|| code-block de impressao }*/)//Descricao de Custo

//campos abaixo sao somente para acerto de layout - nao serao impressos
TRCell():New(oCcusto,"XPARTIDA" ,"cArqTmp",STR0039,/*Picture*/,TAM_CONTA,/*lPixel*/	,{|| "" })//Contra Partida
TRCell():New(oCcusto,"TIPO"     ,"cArqTmp",STR0040,/*Picture*/,TAM_TIPO,/*lPixel*/		,{|| "" })//Tipo do Registro (Debito/Credito/Continuacao)
If lIsRedStor
	TRCell():New(oCcusto,"NUMERO"   ,         ,STR0041,/*Picture*/,TAM_NUMRUS,/*lPixel*/	,{|| "" })//Numero ->LOTE+SUB-LOTE+DOC+LINHA
Else
	TRCell():New(oCcusto,"NUMERO"   ,         ,STR0041,/*Picture*/,TAM_NUMERO,/*lPixel*/	,{|| "" })//Numero ->LOTE+SUB-LOTE+DOC+LINHA
EndIF
TRCell():New(oCcusto,"DATAL"    ,"cArqTmp",STR0037,/*Picture*/,TAM_DATAL,/*lPixel*/	,{|| "" })//Data
TRCell():New(oCcusto,"HISTORICO","cArqTmp",STR0042,/*Picture*/,TAM_HIST,/*lPixel*/		,{|| "" })//Historico		
TRCell():New(oCcusto,"VALORLANC","cArqTmp",STR0043,/*Picture*/,TAM_VALOR,/*lPixel*/	,{|| "" })//Valor do lancamento
//
TRCell():New(oCcusto,"SALCCAT",	     	,STR0044,/*Picture*/,TAM_VALOR-1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")//Saldo atual

TRPosition():New( oCCusto, "CTT", 1, {|| xFilial("CTT") + cArqTMP->CCUSTO})
                                                
oCCusto:Cell("SALCCAT"):HideHeader()
//para nao imprimir os campos abaixo
oCCusto:Cell("XPARTIDA"):HideHeader()
oCCusto:Cell("XPARTIDA"):Hide()
oCCusto:Cell("TIPO"):HideHeader()
oCCusto:Cell("TIPO"):Hide()
oCCusto:Cell("NUMERO"):HideHeader()
oCCusto:Cell("NUMERO"):Hide()
oCCusto:Cell("DATAL"):HideHeader()
oCCusto:Cell("DATAL"):Hide()
oCCusto:Cell("HISTORICO"):HideHeader()
oCCusto:Cell("HISTORICO"):Hide()
oCCusto:Cell("VALORLANC"):HideHeader()
oCCusto:Cell("VALORLANC"):Hide()

// Sessao 2
oSalAnt := TRSection():New(oReport,STR0033,{"cArqTmp"},, .F., .F. )	// Saldo Anterior
//campos abaixo sao somente para acerto de layout - nao serao impressos
TRCell():New(oSalAnt,"CCUSTO"   ,"cArqTmp",cSayCusto,/*Picture*/,TAM_CONTA,/*lPixel*/,/*{|| code-block de impressao }*/)//Centro de Custo
TRCell():New(oSalAnt,"DESCCUSTO",         ,STR0038  ,/*Picture*/,TAM_DESCRICAO,/*lPixel*/,/*{|| code-block de impressao }*/)//Descricao de Custo
TRCell():New(oSalAnt,"XPARTIDA" ,"cArqTmp",STR0039,/*Picture*/,TAM_CONTA,/*lPixel*/	,{|| "" })//Contra Partida
TRCell():New(oSalAnt,"TIPO"     ,"cArqTmp",STR0040,/*Picture*/,TAM_TIPO,/*lPixel*/		,{|| "" })//Tipo do Registro (Debito/Credito/Continuacao)
If lIsRedStor
	TRCell():New(oSalAnt,"NUMERO"   ,         ,STR0041,/*Picture*/,TAM_NUMRUS,/*lPixel*/	,{|| "" })//Numero ->LOTE+SUB-LOTE+DOC+LINHA
Else
	TRCell():New(oSalAnt,"NUMERO"   ,         ,STR0041,/*Picture*/,TAM_NUMERO,/*lPixel*/	,{|| "" })//Numero ->LOTE+SUB-LOTE+DOC+LINHA
Endif
TRCell():New(oSalAnt,"DATAL"    ,"cArqTmp",STR0037,/*Picture*/,TAM_DATAL,/*lPixel*/	,{|| "" })//Data
TRCell():New(oSalAnt,"HISTORICO","cArqTmp",STR0042,/*Picture*/,TAM_HIST,/*lPixel*/		,{|| "" })//Historico		
TRCell():New(oSalAnt,"VALORLANC","cArqTmp",STR0043,/*Picture*/,TAM_VALOR,/*lPixel*/	,{|| "" })//Valor do lancamento
//
TRCell():New(oSalAnt,"LANCANTER",,"",/*Picture*/,TAM_VALOR-1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT")//"S a l d o  a n t e r i o r  d a  C o n t a  => "

//para nao imprimir os campos abaixo
oSalAnt:Cell("CCUSTO"):HideHeader()
oSalAnt:Cell("CCUSTO"):Hide()
oSalAnt:Cell("DESCCUSTO"):HideHeader()
oSalAnt:Cell("XPARTIDA"):HideHeader()
oSalAnt:Cell("XPARTIDA"):Hide()
oSalAnt:Cell("TIPO"):HideHeader()
oSalAnt:Cell("TIPO"):Hide()
oSalAnt:Cell("NUMERO"):HideHeader()
oSalAnt:Cell("NUMERO"):Hide()
oSalAnt:Cell("DATAL"):HideHeader()
oSalAnt:Cell("DATAL"):Hide()
oSalAnt:Cell("HISTORICO"):HideHeader()
oSalAnt:Cell("HISTORICO"):Hide()
oSalAnt:Cell("VALORLANC"):HideHeader()
oSalAnt:Cell("VALORLANC"):Hide()

// Sessao 3
oLanc := TRSection():New(oReport,STR0034,{"cArqTmp","CTT","CT1"},, .F., .F. )	// "Lancamentos"
TRCell():New(oLanc,"CONTA"    ,"cArqTmp",STR0036,/*Picture*/,TAM_CONTA,/*lPixel*/,/*{|| code-block de impressao }*/)//Codigo da Conta
TRCell():New(oLanc,"DESCRICAO",         ,STR0038,/*Picture*/,TAM_DESCRICAO,/*lPixel*/,/*{|| code-block de impressao }*/)//Descrição
TRCell():New(oLanc,"XPARTIDA" ,"cArqTmp",STR0039,/*Picture*/,TAM_CONTA,/*lPixel*/,/*{|| code-block de impressao }*/)//Contra Partida
TRCell():New(oLanc,"TIPO"     ,"cArqTmp",STR0040,/*Picture*/,TAM_TIPO,/*lPixel*/,/*{|| code-block de impressao }*/)//Tipo do Registro (Debito/Credito/Continuacao)
If lIsRedStor
	TRCell():New(oLanc,"NUMERO"   ,         ,STR0041,/*Picture*/,TAM_NUMRUS,/*lPixel*/,/*{|| code-block de impressao }*/)//Numero ->LOTE+SUB-LOTE+DOC+LINHA
Else
	TRCell():New(oLanc,"NUMERO"   ,         ,STR0041,/*Picture*/,TAM_NUMERO,/*lPixel*/,/*{|| code-block de impressao }*/)//Numero ->LOTE+SUB-LOTE+DOC+LINHA
EndIF
TRCell():New(oLanc,"DATAL"    ,"cArqTmp",STR0037,/*Picture*/,TAM_DATAL,/*lPixel*/,/*{|| code-block de impressao }*/)//Data
TRCell():New(oLanc,"HISTORICO","cArqTmp",STR0042,/*Picture*/,TAM_HIST,/*lPixel*/,/*{|| code-block de impressao }*/)//Historico		
TRCell():New(oLanc,"VALORLANC","cArqTmp",STR0043,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")//Valor do lancamento
TRCell():New(oLanc,"SALDOSCR" ,"cArqTmp",STR0044,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")//Saldo atual

TRCell():New(oLanc,"LOTE"     ,"cArqTmp",STR0045,/*Picture*/,TAM_LOTE   ,/*lPixel*/,/*{|| code-block de impressao }*/)//Lote
TRCell():New(oLanc,"SUBLOTE"  ,"cArqTmp",STR0046,/*Picture*/,TAM_SUBLOTE,/*lPixel*/,/*{|| code-block de impressao }*/)//Sub-Lote
TRCell():New(oLanc,"DOC"      ,"cArqTmp",STR0047,/*Picture*/,TAM_DOC    ,/*lPixel*/,/*{|| code-block de impressao }*/)//Documento
If lIsRedStor
	TRCell():New(oLanc,"LINHA"    ,"cArqTmp",STR0048,/*Picture*/,TAM_LINRUS  ,/*lPixel*/,/*{|| code-block de impressao }*/)//Linha
Else
	TRCell():New(oLanc,"LINHA"    ,"cArqTmp",STR0048,/*Picture*/,TAM_LINHA  ,/*lPixel*/,/*{|| code-block de impressao }*/)//Linha
Endif 
If lIsRedStor
	TRCell():New(oLanc,"SEQLAN"   ,"cArqTmp",STR0049,/*Picture*/,TAM_SQLRUS ,/*lPixel*/,/*{|| code-block de impressao }*/)//Sequencia do Lancamento
Else
	TRCell():New(oLanc,"SEQLAN"   ,"cArqTmp",STR0049,/*Picture*/,TAM_SEQLAN ,/*lPixel*/,/*{|| code-block de impressao }*/)//Sequencia do Lancamento
Endif 
TRCell():New(oLanc,"SEQHIST"  ,"cArqTmp",STR0050,/*Picture*/,TAM_SEQHIST,/*lPixel*/,/*{|| code-block de impressao }*/)//Seq do Historico
TRCell():New(oLanc,"EMPORI"   ,"cArqTmp",STR0051,/*Picture*/,TAM_EMPORI ,/*lPixel*/,/*{|| code-block de impressao }*/)//Empresa Original
TRCell():New(oLanc,"FILORI"   ,"cArqTmp",STR0052,/*Picture*/,TAM_FILORI ,/*lPixel*/,/*{|| code-block de impressao }*/)//Filial Original

TRPosition():New( oLanc, "CT1", 1, {|| xFilial("CT1") + cArqTMP->CONTA })
TRPosition():New( oLanc, "CTT", 1, {|| xFilial("CTT") + cArqTMP->CCUSTO})
//Ja esta filtrado na secao oCCusto
oLanc:SetNoFilter({'CTT'})          

oLanc:Cell("LOTE"   ):Disable()
oLanc:Cell("SUBLOTE"):Disable()
oLanc:Cell("DOC"    ):Disable()
oLanc:Cell("LINHA"  ):Disable()
oLanc:Cell("SEQLAN" ):Disable()
oLanc:Cell("SEQHIST"):Disable()
oLanc:Cell("EMPORI" ):Disable()
oLanc:Cell("FILORI" ):Disable()

oLanc:SetHeaderPage()

// Sessao 4
oTotais := TRSection():New( oReport,STR0035,,, .F., .F. )		// Total
TRCell():New(oTotais, "QUEBRA"    ,,,/*Picture*/,TAM_TOTAL,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotais, "TOT_CONTA" ,,,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT")
TRCell():New(oTotais, "TOT_CCUSTO",,,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT")
TRCell():New(oTotais, "TOT_SALDO" ,,,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT")
TRCell():New(oTotais, "TOT_GERAL" ,,,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT")

oTotais:Cell("QUEBRA"   ):HideHeader()
oTotais:Cell("TOT_CONTA"):HideHeader()
oTotais:Cell("TOT_CCUSTO"):HideHeader()
oTotais:Cell("TOT_SALDO"):HideHeader()
oTotais:Cell("TOT_GERAL" ):HideHeader()
                  
oTotais:Cell("TOT_CONTA" ):Disable()
oTotais:Cell("TOT_CCUSTO"):Disable()
oTotais:Cell("TOT_SALDO" ):Disable()
oTotais:Cell("TOT_GERAL" ):Disable()

Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintº Autor ³ Cicero J. Silva    º Data ³  14/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,aSetOfBook,aCtbMoeda)

Local oCcusto   := oReport:Section(1)
Local oSalAnt   := oReport:Section(2)
Local oLanc     := oReport:Section(3)
Local oTotais   := oReport:Section(4)
Local oCompHist := oReport:Section(5)

Local cArqTmp		:= ""
Local cMascara1		:= ""
Local cSepara1		:= ""
Local cMascara2		:= ""
Local cSepara2		:= ""
Local cPicture		:= ""
Local cSayCusto		:= CtbSayApro("CTT")

Local dDataIni		:= mv_par01
Local dDataFim		:= mv_par02
Local cCustoIni		:= mv_par03
Local cCustoFim		:= mv_par04
Local cContaIni		:= mv_par05
Local cContaFIm		:= mv_par06
Local cMoeda		:= mv_par07
Local cSaldo		:= mv_par08
Local lTotalConta  	:= (mv_par12==1)
Local lSalto		:= (mv_par13==1)
Local lImpCCRes		:= (mv_par10==2)
Local lImpCtaRes	:= (mv_par11==2)
Local lFirstCta		:= .T.
Local cDescMoeda	:= Alltrim(aCtbMoeda[2])
Local nDecimais 	:= DecimalCTB(aSetOfBook,cMoeda)
Local cCustoAnt		:= ""
Local cContaAnt     := ""
Local dDataAnt      := ""
Local titulo		:= ""

Local nTotCta		:= 0
Local nTotCC		:= 0 
Local nSaldoCC		:= 0 
Local nSldCCCta		:= 0 
Local nTotalGeral	:= 0

Local aSaldoCC		:= {}
Local aSldCCCta		:= {}

Local lOk           := .T.
Local cFiltCTT		:=	oCCusto:GetAdvPlExp('CTT')
Local cFiltCT1		:=	oLanc:GetAdvPlExp('CT1')
Local bNormal		:= { || nil }
Local bNormalAnt	:= { || nil }

Private nomeprog	:= "CTBR095"

If lIsRedStor
	bNormal 	:= {|| Posicione("CT1",1,xFilial("CT1")+cArqTmp->CONTA,"CT1_NORMAL") }
	bNormalAnt	:= {|| Posicione("CT1",1,xFilial("CT1")+cContaAnt,"CT1_NORMAL") }
Endif	

If oReport:GetOrientation() == 1
	If Aviso(STR0053, STR0054, { STR0055, STR0056 } ) == 2  //"Atencao"##"Este relatorio deve ser emitido em paisagem. Confirma impressão ?"##"Confirma"##"Abandona"
		oReport:CancelPrint()
		Return
	Else
		If Aviso(STR0053, STR0057, { STR0058, STR0059 } ) == 1 //"Atencao"##"Sera excluido as colunas de descricao e historico do relatorio. Confirma Exclusao ?"##"Sim"##"Nao"
			oCCusto:Cell("DESCCUSTO"):disable()
			oCCusto:Cell("HISTORICO"):disable()
			oSalAnt:Cell("DESCCUSTO"):disable()
			oSalAnt:Cell("HISTORICO"):disable()
			oLanc:Cell("DESCRICAO"):disable()
			oLanc:Cell("HISTORICO"):disable()
			oTotais:Cell("QUEBRA"):SetSize(80, .F.)
		EndIf
	EndIf	
EndIf

// Mascara da Conta
If Empty(aSetOfBook[2])
	cMascara1 := GetMv("MV_MASCARA")
Else
	cMascara1	:= RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf

// Mascara do Centro de Custo
If Empty(aSetOfBook[6])
	cMascara2 := GetMv("MV_MASCCUS")
Else
	cMascara2	:= RetMasCtb(aSetOfBook[6],@cSepara2)
EndIf                                                

cPicture 	:= aSetOfBook[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			U_CTBGerLanc(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
			cMoeda,dDataIni,dDataFim,aSetOfBook,cSaldo,cFiltCTT,cFiltCT1)},;
			STR0018,;		// "Criando Arquivo Temporario..."
			STR0006 + Alltrim(cSayCusto))// "Emissao do Razao"

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()
oLanc:SetMeter( RecCount() )

oLanc:NoUserFilter()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Se tiver parametrizado com Plano Gerencial, exibe a mensagem³
//³que o Plano Gerencial nao esta disponivel e sai da rotina.  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If RecCount() == 0 .And. !Empty(aSetOfBook[5])                                       
	lOk := .F.
Endif

If lOk            
                                                                               
	Titulo	:=	STR0007	+ Upper(Alltrim(cSayCusto))//"RAZAO POR "
	Titulo  += 	Space(01)+cDescMoeda + space(01)+STR0009 + space(01)+DTOC(dDataIni) +;	// "DE"
				space(01)+STR0010 + space(01)+ DTOC(dDataFim)							// "ATE"
	    
	oReport:SetCustomText({|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport)} )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a impressao do relatorio                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oLanc:Init()

	CTT->(dbSetOrder(1))
	
	Do While !Eof() .And. !oLanc:Cancel()

	    oLanc:IncMeter()

	   If oLanc:Cancel()
	   	Exit
	   EndIf        
        
		If !lFirstCta .And. lSalto .And. cCustoAnt <> cArqTmp->CCUSTO // Salta por centro de custo
			oReport:EndPage(.T.) // Quebra direto
		ElseIf !lTotalConta
	  		lFirstCta := .F.
	  	EndIf
        
        //Imprime Section(1)
		If cCustoAnt <> cArqTmp->CCUSTO
			// Calcula o saldo anterior do centro de custo atual
			aSaldoCC	:= SaldTotCT3(cArqTmp->CCUSTO,cArqTmp->CCUSTO,cContaIni,cContaFim,dDataIni,cMoeda,cSaldo)

			If lImpCCRes // Imprime Codigo Reduzido de Centro de Custo
				oCcusto:Cell("CCUSTO"):SetBlock( { || EntidadeCTB(CTT->CTT_RES,0,0,Len(CriaVar("CTT_RES")),.F.,cMascara2,cSepara2,,,,,.F.) } )
			Else                                                                     
				oCcusto:Cell("CCUSTO"):SetBlock( { || EntidadeCTB(cArqTmp->CCUSTO,0,0,Len(CriaVar("CT3_CUSTO")),.F.,cMascara2,cSepara2,,,,,.F.) } )
			Endif                     
	   		oCcusto:Cell("SALCCAT"):SetBlock( { || ValorCTB(aSaldoCC[6],,,TAM_VALOR-3,nDecimais,.T.,,/*cTipo*/,,,,,,,.F.) } )
			oCcusto:Cell("DESCCUSTO"):SetBlock( { || CtbDescMoeda ("CTT->CTT_DESC"+cMoeda) })
        
    	 	nSaldoCC := aSaldoCC[6]

			oCcusto:Init()       
	     	oCcusto:PrintLine()  //Section(1)
	     	oReport:ThinLine()    
		  	oCcusto:Finish()
     	EndIf
        //Imprime Section(2)
      If  lTotalConta .And. (cArqTmp->CCUSTO <> cCustoAnt .Or. cArqTmp->CONTA <> cContaAnt)
			aSldCCCta	:= SaldoCT3(cArqTmp->CONTA,cArqTmp->CCUSTO,dDataIni,cMoeda,cSaldo,,.F.)				
			oSalAnt:Cell("LANCANTER"):SetBlock( { || ValorCTB(aSldCCCta[6],,,TAM_VALOR-3,nDecimais,.T.,,,,,,,,,.F.) } )
	  		oSalAnt:Cell("DESCCUSTO"):SetBlock( { || STR0021 })
			nSldCCCta	:= aSldCCCta[6]

			//Se for a primeira conta e totaliza por conta, imprime o saldo anterior do centro 
			//de custo x conta. 
			If lFirstCta
				lFirstCta	:= .F.						
    	    EndIf
	       	oSalAnt:Init()       
	     	oSalAnt:PrintLine()  //Section(1)
	     	oReport:ThinLine()    
		   oSalAnt:Finish()
      EndIf

		//Imprime lancamentos
		dbSelectArea("CT1")
		dbSetOrder(1)
		MsSeek(xFilial()+cArqTmp->CONTA)
		
		// CONTA
		If lImpCtaRes
			oLanc:Cell("CONTA"):SetBlock( { || EntidadeCTB(CT1->CT1_RES,0,0,20,.F.,cMascara1,cSepara1,,,,,.F.) } )
		Else
			oLanc:Cell("CONTA"):SetBlock( { || EntidadeCTB(cArqTmp->CONTA,0,0,20,.F.,cMascara1,cSepara1,,,,,.F.) } )
		Endif                                       
		oLanc:Cell("DESCRICAO"):SetBlock( { || CtbDescMoeda ("CT1->CT1_DESC"+cMoeda) })

    	// CONTRA PARTIDA
		If lImpCtaRes
			MsSeek(xFilial()+cArqTmp->CONTA)
			oLanc:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(CT1->CT1_RES,0,0,20,.F.,cMascara1,cSepara1,,,,,.F.) } )
        Else 
			oLanc:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(cArqTmp->XPARTIDA,0,0,20,.F.,cMascara1,cSepara1,,,,,.F.) } )
        EndIf
		oLanc:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(cArqTmp->XPARTIDA,0,0,20,.F.,cMascara1,cSepara1,,,,,.F.) } )
		oLanc:Cell("NUMERO"):SetBlock( { || cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA } )
		If lIsRedStor
			oLanc:Cell("VALORLANC"):SetBlock( { || TRIM ( ValorCTB(iif(Eval(bNormal)='1',iif(Eval(bNormal)='1',-cArqTmp->VALORLANC,cArqTmp->VALORLANC),cArqTmp->VALORLANC),,,TAM_VALOR-3,nDecimais,.T.,,Eval(bNormal)/*cTipo*/,,,,,,,.F.) ) } )
		Else
			oLanc:Cell("VALORLANC"):SetBlock( { || TRIM ( ValorCTB(iif(cArqTmp->TIPO='1',-cArqTmp->VALORLANC,cArqTmp->VALORLANC),,,TAM_VALOR-3,nDecimais,.T.,,/*cTipo*/,,,,,,,.F.) ) } )
		EndIF

		If cArqTmp->TIPO == "1"
            nSaldoCC	-= cArqTmp->VALORLANC
            nSldCCCta	-= cArqTmp->VALORLANC 
  		Else
            nSaldoCC	+= cArqTmp->VALORLANC
            nSldCCCta	+= cArqTmp->VALORLANC 	            
        EndIf
		If lTotalConta //Se totaliza tambem por conta, imprime o saldo CC x Cta.
			oLanc:Cell("SALDOSCR"):SetBlock( { || ValorCTB(nSldCCCta,,,TAM_VALOR-3,nDecimais,.T.,,Eval(bNormal)/*cTipo*/,,,,,,,.F.) } )
		Else
			oLanc:Cell("SALDOSCR"):SetBlock( { || ValorCTB(nSaldoCC,,,TAM_VALOR-3,nDecimais,.T.,,Eval(bNormal)/*cTipo*/,,,,,,,.F.) } )			
		EndIf
		If cArqTmp->TIPO == "1"
			nTotCta		-=	cArqTmp->VALORLANC
			nTotCC		-=	cArqTmp->VALORLANC
			nTotalGeral -=	cArqTmp->VALORLANC
		Else
			nTotCta		+=  cArqTmp->VALORLANC			
			nTotCC		+=	cArqTmp->VALORLANC	   
			nTotalGeral +=	cArqTmp->VALORLANC 							
		EndIf

    	oLanc:PrintLine() //Section(3)    

		// Procura pelo complemento de historico
		dbSelectArea("CT2")
		dbSetOrder(10)
		If MsSeek(xFilial()+DTOS(cArqTMP->DATAL)+cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->SEQLAN)			
			dbSkip()
			If CT2->CT2_DC == "4"
				While !Eof() .And.;
					    CT2->CT2_FILIAL == xFilial() .And.;
						 CT2->CT2_LOTE   == cArqTMP->LOTE .And.;
						  CT2->CT2_DOC    == cArqTmp->DOC   .And.;
						   CT2->CT2_SEQLAN == cArqTmp->SEQLAN .And.;
						    CT2->CT2_DC     == "4" .And.;
						     DTOS(CT2->CT2_DATA) == DTOS(cArqTmp->DATAL)
					oReport:PrintText(CT2->CT2_LOTE+CT2->CT2_SBLOTE+CT2->CT2_DOC+CT2->CT2_LINHA,oReport:Row(),(oLanc:Cell("NUMERO"):ColPos())-12)
					oReport:PrintText(CT2->CT2_HIST,oReport:Row(),(oLanc:Cell("HISTORICO"):ColPos())-20)
					oReport:SkipLine()
   				
					dbSkip()
				EndDo	
			EndIf	
		EndIf	

		dbSelectArea("cArqTmp")		                                                                  
  		cCustoAnt := cArqTmp->CCUSTO
  		cContaAnt := cArqTmp->CONTA
		dDataAnt  := cArqTmp->DATAL		

		dbSkip()

		//Imprime Section(4)
		If (cArqTmp->CCUSTO <> cCustoAnt .Or. cArqTmp->CONTA <> cContaAnt) // Totaliza tb por Conta

			If lTotalConta // Imprimir total da conta
				oTotais:Cell("QUEBRA"    ):SetBlock( { ||  STR0020 } )
				oTotais:Cell("TOT_CONTA" ):SetBlock( { ||  ValorCTB(nTotCta  ,,,TAM_VALOR-3,nDecimais,.T.,,Eval(bNormalAnt)/*cTipo*/,,,,,,,.F.)} )        				
				oTotais:Cell("TOT_SALDO" ):SetBlock( { ||  ValorCtb(nSldCCCta,,,TAM_VALOR-3,nDecimais,.T.,,Eval(bNormalAnt)/*cTipo*/,,,,,,,.F.)} )
			   	oTotais:Init()       
		     	//oReport:ThinLine()
		     	oTotais:Cell("TOT_CONTA" ):Enable()
		     	oTotais:Cell("TOT_SALDO" ):Enable()    
		     	oTotais:PrintLine()
		     	oReport:ThinLine()                    
				oTotais:Cell("TOT_CONTA" ):Disable()
				oTotais:Cell("TOT_SALDO" ):Disable()
				oTotais:Finish()
				nTotCta		:= 0
            	nSldCCCta	:= 0
			EndIf   
            
			If cArqTmp->CCUSTO <> cCustoAnt
				If lImpCCRes // Imprime Codigo Reduzido de Centro de Custo
					CTT->( MsSeek(xFilial()+cCustoAnt) )
					oTotais:Cell("QUEBRA"):SetBlock( { || Upper(AllTrim(STR0017 + cSayCusto)) + " ==>    ( " +;
						EntidadeCTB(CTT->CTT_RES,0,0,Len(CriaVar("CTT_RES")),.F.,cMascara2,cSepara2,,,,,.F.) + " )" } )
				Else                                                                     
					oTotais:Cell("QUEBRA"):SetBlock( { || Upper(AllTrim(STR0017 + cSayCusto)) + " ==>    ( " +;
						EntidadeCTB(cCustoAnt,0,0,Len(CriaVar("CT3_CUSTO")),.F.,cMascara2,cSepara2,,,,,.F.) + " )" } )
				Endif                   
	
				// Imprimir total do ccusto
				If lIsRedStor
					oTotais:Cell("TOT_CCUSTO"):SetBlock( { || ValorCTB(nTotCC,,,TAM_VALOR-3,nDecimais,.T.,,"1"/*cTipo*/,,,,,,,.F.,,.F.) } )
					oTotais:Cell("TOT_SALDO" ):SetBlock( { || ValorCtb(nSaldoCC,,,TAM_VALOR-3,nDecimais,.T.,,"1"/*cTipo*/,,,,,,,.F.,,.F.)} )
				Else
					oTotais:Cell("TOT_CCUSTO"):SetBlock( { ||  ValorCTB(nTotCC,,,TAM_VALOR-3,nDecimais,.T.,,,,,,,,,.F.) } )
					oTotais:Cell("TOT_SALDO" ):SetBlock( { ||  ValorCtb(nSaldoCC,,,TAM_VALOR-3,nDecimais,.T.,,,,,,,,,.F.)} )
				Endif	
	   	 		oTotais:Init()     
				oTotais:Cell("TOT_CCUSTO"):Enable()
				oTotais:Cell("TOT_SALDO" ):Enable()    
		     	oTotais:PrintLine()
			   oTotais:Finish()
				oTotais:Cell("TOT_CCUSTO"):Disable()
				oTotais:Cell("TOT_SALDO" ):Disable()
				nTotCC   := 0
	         nSaldoCC := 0
			EndIf
				
		EndIf
	    
	EndDo	// Principal
	//IMPRESSAO DO TOTAL GERAL 
	oTotais:Cell("QUEBRA"   ):SetBlock( { || STR0022 } )
	If lIsRedStor
		oTotais:Cell("TOT_GERAL"):SetBlock( { ||  ValorCTB(nTotalGeral,,,TAM_VALOR-3,nDecimais,.T.,,"1"/*cTipo*/,,,,,,,.F.,,.F.) } )
	Else
		oTotais:Cell("TOT_GERAL"):SetBlock( { ||  ValorCTB(nTotalGeral,,,TAM_VALOR-3,nDecimais,.T.,,,,,,,,,.F.) } )
	Endif	
 	oTotais:Init()       
	oTotais:Cell("TOT_GERAL"):Enable()    
  	oTotais:PrintLine()
	oTotais:Finish()
	
   oLanc:Finish()
EndIf // lOk

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()

If __oTempTable <> Nil
	__oTempTable:Delete()
	__oTempTable := Nil
Endif

dbselectArea("CT2") 

Return                                                                          

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CtbGerLanc³ Autor ³ Simone Mie Sato       ³ Data ³ 08/04/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Cria Arquivo Temporario para imprimir o Rel. Lanc. C.Custo  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³U_CtbGerLanc(oMeter,oText,oDlg,lEnd,cArqTmp,cContaIni,		   ³±±
±±³			  ³cContaFim,cCustoIni,cCustoFim,cMoeda,dDataIni,dDataFim,	   ³±±
±±³			  ³aSetOfBook)						                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nome do arquivo temporario                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Acao do Codeblock                                  ³±±
±±³           ³ ExpC1 = Arquivo temporario                                 ³±±
±±³           ³ ExpC2 = Conta Inicial                                      ³±±
±±³           ³ ExpC3 = Conta Final                                        ³±±
±±³           ³ ExpC4 = C.Custo Inicial                                    ³±±
±±³           ³ ExpC5 = C.Custo Final                                      ³±±
±±³           ³ ExpC6 = Moeda                                              ³±±
±±³           ³ ExpD1 = Data Inicial                                       ³±±
±±³           ³ ExpD2 = Data Final                                         ³±±
±±³           ³ ExpA1 = Matriz aSetOfBook                                  ³±±
±±³           ³ ExpC7 = Tipo de Saldo                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBGerLanc(oMeter,oText,oDlg,lEnd,cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
					cMoeda,dDataIni,dDataFim,aSetOfBook,cSaldo,cFiltCTT,cFiltCT1)
			
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local aTamCusto	:= TAMSX3("CT3_CUSTO")  
Local aTamVal	:= TAMSX3("CT2_VALOR")
Local aCtbMoeda	:= {}
Local aSaveArea := GetArea()
Local aCampos

Local nTamHist	:= Len(CriaVar("CT2_HIST"))
Local nDecimais	:= 0
Local cMensagem		:= STR0030// O plano gerencial nao esta disponivel nesse relatorio. 

// Retorna Decimais
aCtbMoeda := CTbMoeda(cMoeda)
nDecimais := aCtbMoeda[5]

If lIsRedStor 
	aCampos :={	{ "CCUSTO"		, "C", aTamCusto[1], 0 },;			// Centro de Custo
				{ "CONTA"		, "C", aTamConta[1], 0 },;  		// Codigo da Conta
				{ "XPARTIDA"   	, "C", aTamConta[1], 0 },;			// Contra Partida			
				{ "TIPO"       	, "C", 01			, 0 },;			// Tipo do Registro (Debito/Credito/Continuacao)
				{ "VALORLANC"	, "N", aTamVal[1]+2, nDecimais },;// Valor do Lancamento
				{ "SALDOSCR"	, "N", aTamVal[1]+2	, nDecimais },;	// Saldo
				{ "HISTORICO"	, "C", nTamHist   	, 0 },;			// Historico			
				{ "DATAL"		, "D", 10			, 0 },;			// Data do Lancamento
				{ "LOTE" 		, "C", 06			, 0 },;			// Lote
				{ "SUBLOTE" 	, "C", 03			, 0 },;			// Sub-Lote
				{ "DOC" 		, "C", 06			, 0 },;			// Documento
				{ "LINHA"		, "C", LEN(CT2->CT2_LINHA), 0 },;			// Linha  03
				{ "SEQLAN"		, "C", LEN(CT2->CT2_SEQLAN), 0 },;			// Sequencia do Lancamento  03
				{ "SEQHIST"		, "C", 03			, 0 },;			// Seq do Historico
				{ "EMPORI"		, "C", 02			, 0 },;			// Empresa Original
				{ "FILORI"		, "C", 02			, 0 }}			// Filial Original
Else
	aCampos :={	{ "CCUSTO"		, "C", aTamCusto[1], 0 },;			// Centro de Custo
				{ "CONTA"		, "C", aTamConta[1], 0 },;  		// Codigo da Conta
				{ "XPARTIDA"   	, "C", aTamConta[1], 0 },;			// Contra Partida			
				{ "TIPO"       	, "C", 01			, 0 },;			// Tipo do Registro (Debito/Credito/Continuacao)
				{ "VALORLANC"	, "N", aTamVal[1]+2, nDecimais },;// Valor do Lancamento
				{ "SALDOSCR"	, "N", aTamVal[1]+2	, nDecimais },;	// Saldo
				{ "HISTORICO"	, "C", nTamHist   	, 0 },;			// Historico			
				{ "DATAL"		, "D", 10			, 0 },;			// Data do Lancamento
				{ "LOTE" 		, "C", 06			, 0 },;			// Lote
				{ "SUBLOTE" 	, "C", 03			, 0 },;			// Sub-Lote
				{ "DOC" 		, "C", 06			, 0 },;			// Documento
				{ "LINHA"		, "C", 03			, 0 },;			// Linha
				{ "SEQLAN"		, "C", 03			, 0 },;			// Sequencia do Lancamento
				{ "SEQHIST"		, "C", 03			, 0 },;			// Seq do Historico
				{ "EMPORI"		, "C", 02			, 0 },;			// Empresa Original
				{ "FILORI"		, "C", 02			, 0 }}			// Filial Original
Endif

If cPaisLoc = "CHI"
	Aadd(aCampos,{"SEGOFI","C",TamSx3("CT2_SEGOFI")[1],0})
EndIf

If __oTempTable <> Nil
	__oTempTable:Delete()
	__oTempTable := Nil
Endif

__oTempTable := FWTemporaryTable():New( "cArqTmp" )  
__oTempTable:SetFields(aCampos) 
__oTempTable:AddIndex("1", {"CCUSTO","CONTA","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"})

//------------------
//Criação da tabela temporaria
//------------------
__oTempTable:Create()  

dbSelectArea("cArqTmp")

dbSetOrder(1)

If !Empty(aSetOfBook[5])
	MsgAlert(cMensagem)	
	Return
EndIf

U_CtbGeraLan(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
			cMoeda,dDataIni,dDataFim,aSetOfBook,cSaldo,cFiltCTT,cFiltCT1)        				
			
RestArea(aSaveArea)

Return cArqTmp

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CtbGeraLan³ Autor ³ Simone Mie Sato       ³ Data ³ 08/04/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Grava registros no arq temporario                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_CtbGeraLan(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,	   ³±±
±±³			  ³	cCustoIni,cCustoFim,cMoeda,dDataIni,dDataFim,aSetOfBook,   ³±±
±±³			  ³	cSaldo)                             				   	   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Acao do Codeblock                                  ³±±
±±³           ³ ExpC1 = Arquivo temporario                                 ³±±
±±³           ³ ExpC2 = Conta Inicial                                      ³±±
±±³           ³ ExpC3 = Conta Final                                        ³±±
±±³           ³ ExpC4 = C.Custo Inicial                                    ³±±
±±³           ³ ExpC5 = C.Custo Final                                      ³±±
±±³           ³ ExpC6 = Moeda                                              ³±±
±±³           ³ ExpD1 = Data Inicial                                       ³±±
±±³           ³ ExpD2 = Data Final                                         ³±±
±±³           ³ ExpA1 = Matriz aSetOfBook                                  ³±±
±±³           ³ ExpC7 = Tipo de Saldo                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbGeraLan(oMeter,oText,oDlg,lEnd,cContaIni,cContaFim,cCustoIni,cCustoFim,;
				cMoeda,dDataIni,dDataFim,aSetOfBook,cSaldo,cFiltCTT,cFiltCT1)        								
				
Local aSaveArea := GetArea()
Local nMoeda	:= Val(cMoeda)
Local cChave	:= ""
Local cCustoF	:= cCustoFim
Local cContaF 	:= cContaFim

oMeter:nTotal := CT1->(RecCount())

dbSelectArea("CTT")
dbSetOrder(2)
MSSeek(xFilial()+"2"+cCustoIni,.T.)
	
While !Eof() .And. CTT->CTT_FILIAL == xFilial() .And. CTT->CTT_CUSTO <= cCustoF .And. CTT->CTT_CLASSE == "2"

   // ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   // ³ Obt‚m os d‚bitos ³
   // ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cFiltCTT <> Nil .And. !Empty(cFiltCTT)
		DbSelectArea('CTT')
		If !&(cFiltCTT)
			DbSkip()
			Loop
		Endif				
	Endif

	dbSelectArea("CT2")
	dbSetOrder(4)
	MsSeek(xFilial()+CTT->CTT_CUSTO+ DTOS(dDataIni),.t.)
	While !Eof() .and. CT2->CT2_FILIAL == xFilial() .And. ;
		CT2->CT2_CCD == CTT->CTT_CUSTO.And.	;
		CT2->CT2_DATA >= dDataIni .And. CT2->CT2_DATA <= dDataFim 

		If 	CT2->CT2_VALOR == 0 .Or. CT2->CT2_TPSALD != cSaldo .Or. ;
			CT2->CT2_MOEDLC <> cMoeda		
			dbSkip()
			Loop
		EndIf

		If (CT2->CT2_DEBITO < cContaIni 	.Or. CT2->CT2_DEBITO > cContaFim) 	.Or.;
			(CT2->CT2_CCD < cCustoIni 		.Or. CT2->CT2_CCD > cCustoFim) 	
			dbSkip()
			Loop
		Endif
		//Filtra por conta
		If cFiltCT1 <> Nil .And. !Empty(cFiltCT1)
			CT1->(dbSetOrder(1))
			Ct1->(MsSeek(xFilial('CT1')+CT2->CT2_DEBITO))
			If !CT1->(&(cFiltCT1))
				DbSelectArea('CT2')
				dbSetOrder(4)		        
				DbSkip()
				Loop
			Endif				
		Endif

		U_CtbGrvLanc(cMoeda,cSaldo,"1")

		dbSelectArea("CT2")
		dbSetOrder(4)		        
		dbSkip()
	Enddo
	
   // ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   // ³ Obt‚m os creditos³
   // ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("CT2")
	dbSetOrder(5)
	MsSeek(xFilial()+CTT->CTT_CUSTO+ DTOS(dDataIni),.t.)

	While !Eof() .and. CT2->CT2_FILIAL == xFilial() .And. ;
		CT2->CT2_CCC == CTT->CTT_CUSTO .And.	;
		CT2->CT2_DATA >= dDataIni .And. CT2->CT2_DATA <= dDataFim 

		If 	CT2->CT2_VALOR == 0 .Or. CT2->CT2_TPSALD != cSaldo .Or. ;
			CT2->CT2_MOEDLC <> cMoeda				
			dbSkip()
			Loop
		EndIf
          
		If (CT2->CT2_CREDIT < cContaIni .Or. CT2->CT2_CREDIT > cContaFim) .Or.;
			(CT2->CT2_CCC < cCustoIni .Or. CT2->CT2_CCC > cCustoFim)
			dbSkip()
			Loop
		Endif

		//Filtra por conta
		If cFiltCT1 <> Nil .And. !Empty(cFiltCT1)
			CT1->(dbSetOrder(1))
			CT1->(MsSeek(xFilial('CT1')+CT2->CT2_CREDIT))
			If !CT1->(&(cFiltCT1))
				DbSelectArea('CT2')
				dbSetOrder(4)		        
				DbSkip()
				Loop
			Endif				
		Endif


		U_CtbGrvLanc(cMoeda,cSaldo,"2")
		
		DbSelectArea("CT2")
		dbSetOrder(5)		   
		dbSkip()		
	Enddo

	dbSelectArea("CTT")
	dbSetOrder(2)  
    dbSkip()
EndDo

Return                        

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CtbGrvLanc³ Autor ³ Simone Mie Sato       ³ Data ³ 12/04/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Grava registros no arquivo temporario.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³U_CtbGrvLanc(oMeter,oText,oDlg,lEnd,cArqTmp,cContaIni,		   ³±±
±±³			  ³cContaFim,cCustoIni,cCustoFim,cMoeda,dDataIni,dDataFim,	   ³±±
±±³			  ³aSetOfBook)						                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nome do arquivo temporario                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Acao do Codeblock                                  ³±±
±±³           ³ ExpC1 = Arquivo temporario                                 ³±±
±±³           ³ ExpC2 = Conta Inicial                                      ³±±
±±³           ³ ExpC3 = Conta Final                                        ³±±
±±³           ³ ExpC4 = C.Custo Inicial                                    ³±±
±±³           ³ ExpC5 = C.Custo Final                                      ³±±
±±³           ³ ExpC6 = Moeda                                              ³±±
±±³           ³ ExpD1 = Data Inicial                                       ³±±
±±³           ³ ExpD2 = Data Final                                         ³±±
±±³           ³ ExpA1 = Matriz aSetOfBook                                  ³±±
±±³           ³ ExpC7 = Tipo de Saldo                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbGrvLanc(cMoeda,cSaldo,cTipo)		


Local cConta
Local cContra
Local cCusto

If cTipo == "1"
	cConta 	:= CT2->CT2_DEBITO
	cContra	:= CT2->CT2_CREDIT
	cCusto	:= CT2->CT2_CCD
EndIf	

If cTipo == "2"
	cConta 	:= CT2->CT2_CREDIT
	cContra := CT2->CT2_DEBITO
	cCusto	:= CT2->CT2_CCC
EndIf		           

dbSelectArea("cArqTmp")
dbSetOrder(1)	
RecLock("cArqTmp",.T.)

Replace DATAL		With CT2->CT2_DATA
Replace TIPO		With cTipo
Replace LOTE		With CT2->CT2_LOTE
Replace SUBLOTE		With CT2->CT2_SBLOTE
Replace DOC			With CT2->CT2_DOC
Replace LINHA		With CT2->CT2_LINHA
Replace CONTA		With cConta
Replace XPARTIDA	With cContra
Replace CCUSTO		With cCusto
Replace HISTORICO	With CT2->CT2_HIST
Replace EMPORI		With CT2->CT2_EMPORI
Replace FILORI		With CT2->CT2_FILORI
Replace SEQHIST		With CT2->CT2_SEQHIS
Replace SEQLAN		With CT2->CT2_SEQLAN
Replace VALORLANC	With CT2->CT2_VALOR

If cPaisLoc == "CHI"
	Replace SEGOFI With CT2->CT2_SEGOFI// Correlativo para Chile
EndIf

If CT2->CT2_DC == "3"
	Replace TIPO	With cTipo
Else
	Replace TIPO 	With CT2->CT2_DC
EndIf		
MsUnlock()

Return
