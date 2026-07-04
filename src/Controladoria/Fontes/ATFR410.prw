/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR410.CH"
#include "Protheus.ch"


STATIC lPerAcm 		:= .F.
STATIC lVlrTstImp 	:= .F.
STATIC lCPerRev     := .F.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR410  ³ Autor ³ Acacio Egas           ³ Data ³ 23/12/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao do valor recuperavel de ativos                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe 	 ³ ATFR410                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR410()

Local oReport
Local lRetorno	:= .T.

Private cTipoGer := SuperGetMv( "MV_ATFTIOA", .F., "12" )
Private aSelFil		:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01            // a partir da data                  ³
//³ mv_par02            // ate a data                        ³
//³ mv_par03            // da conta                          ³
//³ mv_par04            // ate a conta                       ³
//³ mv_par05            // do centro de custo                ³
//³ mv_par06            // ate o centro de custo             ³
//³ mv_par07            // valores na moeda                  ³
//³ mv_par08            // Considera itens baixados			 ³
//³ mv_par09            // Considera filiais abaixo			 ³
//³ mv_par10            // filial de						 		 ³
//³ mv_par11            // filial ate						 		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := ReportDef()

// Verificacao de seguranca para executar versao R4
If Valtype(oReport) == 'O'
	oReport:PrintDialog()
Else
	lRetorno := .F.
EndIf

oReport := Nil

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Acacio Egas           ³ Data ³23/12/09    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os   ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			 |		         |                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(cRespINI,cRespFIM,cCBASEINI,cItemINI,cCBaseFIM,cItemFIM)

Local oReport, oSection1
Local cReport 	:= "ATFR410"
Local cTitulo 	:= STR0003 // "Relacao dos bens adquiridos"
Local cDescri 	:= STR0001 + " " + STR0002 // "Este programa ira' emitir a rela‡„o do valor recuperavel de ativos efetuadas"##" dentro de um periodo."

// Definicao do Titulo do Relatorio no momento da impressao
Local bReport 	:= { |oReport|	cMoeda := Str(mv_par07,1),;
										oReport:SetTitle(oReport:Title() + OemToAnsi(STR0009)+; // " por "
										aOrd[oSection1:nOrder] + OemToAnsi(STR0010) +; //" em "
										Getmv("MV_MOEDA" + ALLTRIM(cMoeda)) + OemToAnsi(STR0011) +; //" entre "
										DTOC(mv_par01) + OemToAnsi(STR0012) + DTOC(mv_par02)),; // " a "
									 	ReportPrint( oReport ) }
Local cMoeda 	:= ""
Local aOrd 		:= {}
Local aArea		:= GetArea()
Local aAreaSX3 	:= SX3->(GetArea())

// Forca a abertura do SN1
DbSelectArea("SN1")

aOrd := {OemToAnsi(STR0004),; // "Conta"
		 OemToAnsi(STR0005),; // "C Custo"
		 OemToAnsi(STR0006)}  // "Data Aquisicao"


Pergunte("AFR410",.T., NIL , NIL, NIL, NIL, NIL, NIL, NIL, .F. )
//Pergunte( "AFR410" , .F. )

cMoeda := Str(mv_par07,1)

DbSelectArea("SN3")
lPerAcm := SN3->(FieldPos("N3_PERACM"+ALLTRIM(cMoeda))) > 0 .and. SN3->(FieldPos("N3_REVACM"+ ALLTRIM(cMoeda))) > 0 .and. SN3->(FieldPos("N3_PERACM1")) > 0
DbSelectArea("SNJ")
lVlrTstImp := SNJ->(FieldPos("NJ_VLRIMPT")) > 0
lCPerRev   := SNJ->(FieldPos("NJ_CPERREV")) > 0

// Inicio da construcao do layout do relatorio
oReport  := TReport():New( cReport, cTitulo, "AFR410" , bReport, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0021, {"SN3","NAOUSADO" } , aOrd ) // "Dados do Bem"
TRCell():New( oSection1, "N3_CBASE"  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_ITEM"   	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_TIPO"		, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_DESCRIC"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_AQUISIC"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_TPSALDO"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_QUANTD" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_NFISCAL"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_CHAPA"	  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_GRUPO"	  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCUSTO" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_LOCAL"	  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_FORNEC" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_LOJA"   	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A2_NREDUZ" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_DINDEPR"	, ,STR0026,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_TXDEPR"	, ,STR0027,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N3_VORIG"		, ,STR0028,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_VRDACM"	, ,STR0029,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_VRCACM"	, ,STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_DTBAIXA"  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCONTAB"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCORREC"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CDEPREC"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCDEPR"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CDESP"		, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If lPerAcm
	TRCell():New( oSection1, "IMP_ACUMULADO", ,STR0031,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf
If lVlrTstImp
	TRCell():New( oSection1, "VLR_TST_IMPAIR",,STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf	
If lCPerRev
	TRCell():New( oSection1, "CONTA_PERREV" , ,STR0033,/*Picture*/,TamSx3("NJ_CPERREV")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf

oSection1:SetLineBreak()
oSection1:SetTotalInLine(.T.)
oSection1:SetHeaderPage(.T.)

oReport:SetLandScape()

RestArea(aAreaSx3)
RestArea(aArea)

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Acacio Egas         º Data ³  23/12/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport as Object)

Local oSection1 as Object
Local cChave as Character
Local cChaveSQL as Character
Local cQuery as Character
Local nOrder as Numeric
Local cMoeda as Character
Local cWhere as Character
Local cBemAnt as Character
Local bTitle as Block
Local cFilDe as Character
Local cFilAte as Character
Local oBreak1 as Object
Local oBreak2 as Object
Local bVOrig as Block
Local oTotOrdem as Object
Local oTotFil as Object
Local oTotGer as Object
Local cFilRep as Character
Local cFilBrk as Character
Local cContaBrk as Character
Local cCustoBrk as Character
Local dAquisBrk as Date
Local cAliasSN3 as Character
Local cFiltro as Character
Local cFilterUser as Character
Local lQuery as Logical 
Local lTpSaldo as Logical
Local nRegSM0 as Numeric
Local lGestao as Logical
Local lAtClDepr as Logical // Verificação da classificação de Ativo se sofre depreciação
Local nRecSNJ as Numeric
Local nVlImp  as Numeric
Local cCPerRev as Character

DEFAULT oReport := Nil

oSection1   := oReport:Section(1)
cChave      := ""
cChaveSQL   := ""
cQuery      := ""
nOrder      := oSection1:nOrder
cMoeda      := Str(mv_par07,2)
cWhere      := ""       
cBemAnt     := ""
bTitle      := { |cCampo| SX3->(DbSetOrder(2)), SX3->(MsSeek(cCampo)), X3Titulo() }
cFilDe      := ""
cFilAte     := ""
oBreak1     := Nil
oBreak2     := Nil
bVOrig      := {||}
oTotOrdem   := Nil
oTotFil     := Nil
oTotGer     := Nil
cFilRep     := ""
cFilBrk     := "" 
cContaBrk   := ""
cCustoBrk 	:= ""
dAquisBrk 	:= CTOD('')
cAliasSN3   := "SN3"
cFiltro     := ""
cFilterUser := ""
lQuery		:= .F. //variavel de controle para execucao de query
lTpSaldo    := .F.

nRegSM0     := SM0->(Recno())
lGestao     := ( FWSizeFilial() > 2 ) 	// Indica se usa Gestao Corporativa
lAtClDepr 	:= .F. // Verificação da classificação de Ativo se sofre depreciação

If MV_PAR13 <> Nil .And. Valtype(MV_PAR13) <> 'N' .And. ( MV_PAR13 <> 1 .Or. MV_PAR13 <> 2)
	MV_PAR13 := 2
EndIf 

If MV_PAR13 == 1 // Seleciona Filiais
	If FindFunction("FwSelectGC") .AND. lGestao
		aSelFil := FwSelectGC()
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SN3")
	Endif
Else
	aSelFil := {cFilAnt}
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

SM0->(DbGoTo(nRegSM0))
lQuery := !(TcSrvType() == "AS/400" .or. TcSrvType() == "iSeries") // somente ira executar a query se nao for AS400

/*
 * Verifica se trata o tipo de saldo para utilização da redução de valor recuperável com o tipo 10 - Gerencial
 */
DbSelectArea("SNJ")
lTpSaldo   := SNJ->(FieldPos("NJ_TPSALDO")) > 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza registro inicial                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cChave := GetChave( lQuery, nOrder )

// Retorna o o filtro escolhido pelo usuario
cUserFilter := oSection1:GetAdvplExp( "SN3" )

// Efetua o filtro para o relatorio
U_Atf410Tmp( @cAliasSN3, @cChave, @cFiltro, cUserFilter )

// Montagem da quebra do relatorio
IF nOrder == 1
	SN3->(dbSetOrder(2))
	oBreak1 := TRBreak():New( oSection1, {|| (cAliasSN3)->(N3_FILIAL+N3_CCONTAB)}, STR0022 + " : " + (cAliasSN3)->N3_CCONTAB) // "Total da Conta"
	
ElseIf nOrder == 2
	SN3->(dbSetOrder(3))
	oBreak1 := TRBreak():New( oSection1, {|| (cAliasSN3)->(N3_FILIAL+N3_CCUSTO)}, STR0023 + " : " + (cAliasSN3)->N3_CCUSTO) // "Total do Centro de Custo"

ElseIf nOrder == 3
	If !lQuery
		SN3->( dbSetOrder( U_Atfr410Idx( "SN3" , cChave, lQuery ) ) ) //seta indice por data em dbf
	EndIf
	oBreak1 := TRBreak():New( oSection1, {|| (cAliasSN3)->(N3_FILIAL+DTOS(N3_AQUISIC))}, STR0024 + " : " + DTOS((cAliasSN3)->N3_AQUISIC)) // "Total da Data de Aquisição"
	
EndIf

oBreak2:= TRBreak():New(oSection1, {|| (cAliasSN3)->(N3_FILIAL) }, {|| STR0025+(cAliasSN3)->(N3_FILIAL) } ) //"TOTAL FILIAL:
oSection1:SetLineCondition({|| If(	(cAliasSN3)->(N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO) != cBemAnt,;
									(cBemAnt := (cAliasSN3)->(N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO), .T.),.F.) } )
          
If lQuery //top
	// Verificação da classificação de Ativo se sofre depreciação

	bVOrig := { ||lAtClDepr := Iif(FindFunction("AtClssVer"),AtClssVer((cAliasSN3)->N1_PATRIM),(cAliasSN3)->N1_PATRIM $ "NID") 	,;
					cFilBrk 	:= (cAliasSN3)->N3_FILIAL, cContaBrk 	:= (cAliasSN3)->N3_CCONTAB, cCustoBrk 	:= (cAliasSN3)->N3_CCUSTO,;
				 	dAquisBrk 	:= (cAliasSN3)->N3_AQUISIC,;
					nValor 		:= 	Af410VOrig((cAliasSN3)->N3_FILIAL,cMoeda,(cAliasSN3)->N3_CBASE,(cAliasSN3)->N3_ITEM,(cAliasSN3)->N3_TIPO, (cAliasSN3)->N3_BAIXA, (cAliasSN3)->N3_SEQ),;
					Iif(lAtClDepr .OR. (cAliasSN3)->N1_PATRIM $ " P",nValor,nValor*(-1)) }
Else //dbf
	// Verificação da classificação de Ativo se sofre depreciação
	//
	
	oSection1:SetFilter(cFiltro,cChave)

	TRPosition():New(oSection1,"SN1",1,{|| xFilial("SN1")+SN3->(N3_CBASE+N3_ITEM) })
	TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+SN1->(N1_FORNEC+N1_LOJA)})

	bVOrig := { ||lAtClDepr := Iif(FindFunction("AtClssVer"),AtClssVer(SN1->N1_PATRIM),SN1->N1_PATRIM $ "NID"),;
				 	cFilBrk 	:= (cAliasSN3)->N3_FILIAL, cContaBrk 	:= (cAliasSN3)->N3_CCONTAB, cCustoBrk 	:= (cAliasSN3)->N3_CCUSTO,;
				 	dAquisBrk 	:= (cAliasSN3)->N3_AQUISIC,;
					nValor 		:= 	Af410VOrig((cAliasSN3)->N3_FILIAL,cMoeda,(cAliasSN3)->N3_CBASE,(cAliasSN3)->N3_ITEM,(cAliasSN3)->N3_TIPO),;
					Iif(lAtClDepr .OR. SN1->N1_PATRIM $ " P",nValor,nValor*(-1)) }
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas com os campos das tabelas A2 e N1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cAliasSN3 == 'SN3'
	oSection1:Cell("A2_NREDUZ" 	):SetBlock( {|| SA2->A2_NREDUZ  	})
	oSection1:Cell("N1_DESCRIC"	):SetBlock( {|| SN1->N1_DESCRIC		})
	oSection1:Cell("N1_QUANTD" 	):SetBlock( {|| SN1->N1_QUANTD 		})
	oSection1:Cell("N1_NFISCAL"	):SetBlock( {|| SN1->N1_NFISCAL		})
	oSection1:Cell("N1_CHAPA"	):SetBlock( {|| SN1->N1_CHAPA		})
	oSection1:Cell("N1_GRUPO"	):SetBlock( {|| SN1->N1_GRUPO		})
	oSection1:Cell("N1_Local"	):SetBlock( {|| SN1->N1_Local		})
	oSection1:Cell("N1_FORNEC" 	):SetBlock( {|| SN1->N1_FORNEC 		})
	oSection1:Cell("N1_LOJA"   	):SetBlock( {|| SN1->N1_LOJA   		})
Else
	oSection1:Cell("A2_NREDUZ" 	):SetBlock( {|| (cAliasSN3)->A2_NREDUZ })
	oSection1:Cell("N1_DESCRIC"	):SetBlock( {|| (cAliasSN3)->N1_DESCRIC})
	oSection1:Cell("N1_QUANTD" 	):SetBlock( {|| (cAliasSN3)->N1_QUANTD })
	oSection1:Cell("N1_NFISCAL"	):SetBlock( {|| (cAliasSN3)->N1_NFISCAL})
	oSection1:Cell("N1_CHAPA"	):SetBlock( {|| (cAliasSN3)->N1_CHAPA	})
	oSection1:Cell("N1_GRUPO"	):SetBlock( {|| (cAliasSN3)->N1_GRUPO	})
	oSection1:Cell("N1_Local"	):SetBlock( {|| (cAliasSN3)->N1_Local	})
	oSection1:Cell("N1_FORNEC" 	):SetBlock( {|| (cAliasSN3)->N1_FORNEC })
	oSection1:Cell("N1_LOJA"   	):SetBlock( {|| (cAliasSN3)->N1_LOJA   })
EndIf

oSection1:Cell("N3_CBASE"  	):SetBlock( {|| (cAliasSN3)->N3_CBASE  	})
oSection1:Cell("N3_ITEM"   	):SetBlock( {|| (cAliasSN3)->N3_ITEM   	})
oSection1:Cell("N3_AQUISIC"	):SetBlock( {|| (cAliasSN3)->N3_AQUISIC	})
oSection1:Cell("N3_DTBAIXA"	):SetBlock( {|| (cAliasSN3)->N3_DTBAIXA	})
/*
 * Controle de Tipo de Saldo no processo de redução de valor recuperável
 */
If lTpSaldo
	oSection1:Cell("N3_TPSALDO"	):SetBlock( {|| GetAdvFVal("SX5","X5_DESCRI"\,xFilial("SX5")+"SL"+(cAliasSN3)->N3_TPSALDO)	})
EndIf
oSection1:Cell("N3_CCUSTO" 	):SetBlock( {|| (cAliasSN3)->N3_CCUSTO 	})
oSection1:Cell("N3_DINDEPR"	):SetBlock( {|| (cAliasSN3)->N3_DINDEPR	})
oSection1:Cell("N3_TXDEPR"	):SetBlock( {|| &(cAliasSN3 + "->N3_TXDEPR" + ALLTRIM(cMoeda))})
oSection1:Cell("N3_VORIG"	):SetBlock( {|| &(cAliasSN3 + "->N3_VORIG"  + ALLTRIM(cMoeda))})
oSection1:Cell("N3_VRDACM"	):SetBlock( {|| &(cAliasSN3 + "->N3_VRDACM" + ALLTRIM(cMoeda))})
oSection1:Cell("N3_VRCACM"	):SetBlock( {|| (cAliasSN3)->N3_VRCACM1 })
oSection1:Cell("N3_CCONTAB"	):SetBlock( {|| (cAliasSN3)->N3_CCONTAB	})
oSection1:Cell("N3_CCORREC"	):SetBlock( {|| (cAliasSN3)->N3_CCORREC	})
oSection1:Cell("N3_CDEPREC"	):SetBlock( {|| (cAliasSN3)->N3_CDEPREC	})
oSection1:Cell("N3_CCDEPR"	):SetBlock( {|| (cAliasSN3)->N3_CCDEPR 	})
oSection1:Cell("N3_CDESP"	):SetBlock( {|| (cAliasSN3)->N3_CDESP	})
oSection1:Cell("N3_TIPO"	):SetBlock( {|| (cAliasSN3)->N3_TIPO	})
If lPerAcm 
	oSection1:Cell("IMP_ACUMULADO"	):SetBlock( {|| Iif( (cAliasSN3)->N3_PERACM1 > 0, (&(cAliasSN3 + "->N3_PERACM" + ALLTRIM(cMoeda)) - &(cAliasSN3 + "->N3_REVACM" + ALLTRIM(cMoeda))),;
											Iif((cAliasSN3)->N3_TIPO == cTipoGer,;
										    Iif(Len(aImp:=AF380REVER((cAliasSN3)->N3_CBASE,(cAliasSN3)->N3_ITEM,ALLTRIM(cMoeda),(cAliasSN3)->N3_FILIAL ))>0,aImp[2]-aImp[3],0),0))})
										
EndIf
If lVlrTstImp
	oSection1:Cell("VLR_TST_IMPAIR"	):SetBlock( {||nVlImp })
EndIf
If lCPerRev
	oSection1:Cell("CONTA_PERREV"	):SetBlock( {||cCPerRev })	
EndIf

oSection1:SetLineBreak()
oBreak1:SetTotalText( { ||  Iif(nOrder == 1, STR0022+" : "+cContaBrk, Iif(nOrder == 2, STR0023+" : "+cCustoBrk, STR0024+" : "+DTOC(dAquisBrk)))} )
oBreak2:SetTotalText( { ||  STR0025+cFilBrk } )

oReport:SetTotalInLine(.F.)

If MV_PAR13 <> 1
	oTotOrdem	:= TRFunction():New(oSection1:Cell("N3_VORIG")	,, "SUM"	,oBreak1 	,/*cTitle*/,/*cPicture*/,bVOrig		,.F./*lEndSection*/,.F./*lEndReport*/							,.F./*lEndPage*/,oSection1)
	oTotFil		:= TRFunction():New(oSection1:Cell("N3_VORIG")	,, "SUM"	,oBreak2 	,/*cTitle*/,/*cPicture*/,bVOrig		,.F./*lEndSection*/,/*Iif(!Empty(aSelFil),.T.,.F.)lEndReport*/.F.		,.F./*lEndPage*/,oSection1)
	oTotGer		:= TRFunction():New(oSection1:Cell("N3_VORIG")	,, "SUM"	,/*oBreak1	oBreak*/	,/*cTitle*/" ",/*cPicture*/,/*bVOrig	bBreak*/	,.T./*lEndSection*/,/*Iif(!Empty(aSelFil),.T.,.F.)lEndReport*/	.F.	,.F./*lEndPage*/)
	oTotGer:oParent:bTotalText := { ||  STR0017 }
Else
	oTotFil		:= TRFunction():New(oSection1:Cell("N3_VORIG")	,, "SUM"	,oBreak2 	,/*cTitle*/,/*cPicture*/,bVOrig		,.F./*lEndSection*/,/*Iif(!Empty(aSelFil),.T.,.F.)lEndReport*/	.F.	,.F./*lEndPage*/)
	oTotGer		:= TRFunction():New(oSection1:Cell("N3_VORIG")	,, "SUM"	,/*oBreak1*/		,/*cTitle*/" ",/*cPicture*/,/*bVOrig	bBreak*/	,.T./*lEndSection*/,/*Iif(!Empty(aSelFil),.T.,.F.)lEndReport*/	.F.	,.F./*Iif(Empty(aSelFil),.T.,.F.)lEndPage*/)
	oTotGer:oParent:bTotalText := { ||  STR0017 }
EndIf

oReport:SetMeter(RecCount())                  

If lQuery
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While (cAliasSN3)->(!Eof())	
		If oReport:Cancel()
			Exit
		EndIf

		oSection1:Init()
		cFilRep := (cAliasSN3)->N3_FILIAL	
	
		While (cAliasSN3)->(!Eof()) .And. (cAliasSN3)->N3_FILIAL == cFilRep
			cQuebra := (cAliasSN3)->(&cChave)
			While (cAliasSN3)->(!Eof()) .And. (cAliasSN3)->(&cChave) == cQuebra
	
				If !lQuery
					SN1->(DbSeek((cAliasSN3)->N3_FILIAL + (cAliasSN3)->N3_CBASE + (cAliasSN3)->N3_ITEM))			
				EndIf

				If lVlrTstImp .or. lCPerRev
					nVlImp  	:= 0
					cCPerRev    := ""
					nRecSNJ:= AFR410SNJ((cAliasSN3)->N3_FILIAL,(cAliasSN3)->N3_CBASE,(cAliasSN3)->N3_ITEM,(cAliasSN3)->N3_TIPO,(cAliasSN3)->N3_VORIG1,(cAliasSN3)->N3_SEQ)
					If nRecSNJ > 0
						DbSelectArea("SNJ")
						SNJ->(DbGoTo(nRecSNJ))
						If lVlrTstImp
							nVlImp   := SNJ->NJ_VLRIMPT
						EndIf
						If lCPerRev
							cCPerRev := SNJ->NJ_CPERREV
						EndIf
					EndIf
				EndIf
				
				oSection1:PrintLine()
	
				If nOrder == 1
					SN3->(dbSetOrder(2))
				ElseIf nOrder == 2
					SN3->(dbSetOrder(5))
				End
	
				(cAliasSN3)->(DbSkip())
			EndDo
		EndDo
		oReport:SkipLine()
		oReport:IncMeter()
	EndDo
	oSection1:Finish()
	oReport:EndPage()
Else
	oSection1:Init()
	oSection1:Print()
	oSection1:Finish()
EndIf	

Return Nil                                                             
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Af410VOrig³ Autor ³ Claudio D. de Souza   ³ Data ³ 23/12/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o valor original do bem                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ ATFR410                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Af410VOrig(cFilSN3,cMoeda,cBase,cItem,cTipo, cBaixa, cSeq)
Local aAreaSn3 := SN3->(GetArea())
Local nVOrig := 0
                                        
SN3->(DbSetOrder(1))
SN3->(MsSeek(cFilSN3+cBase+cItem+cTipo+cBaixa+cSeq))

While SN3->(!Eof()) .And. SN3->(N3_FILIAL+N3_CBASE+N3_ITEM+SN3->N3_TIPO+SN3->N3_BAIXA+SN3->N3_SEQ) == cFilSN3+cBase+cItem+cTipo+cBaixa+cSeq
	nVOrig += SN3->&("N3_VORIG"+ALLTRIM(cMoeda))
	SN3->(DbSkip())
End			
SN3->(RestArea(aAreaSn3))

Return nVOrig
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Atf410Tmp ºAutor  ³Renato		         º Data ³  23/12/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de retorno do conteudo a ser impresso pelo relatorioº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR410                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Atf410Tmp( cAliasTMP, cChave, cFiltro, cUserFilter )
Local aArea		:= GetArea()
Local lQuery	:= .F.
Local cCampos	:= ""
Local cQuery	:= ""
Local cFilDe	:= ""
Local cFilAte	:= ""
Local aStruSn1	:= {}
Local aStruSn3	:= {}
Local nI		:= 0
Local cDBMS     := Upper(TCGetDB())
Local cSubQuery := ""
Local cQryTip12 := ""
Local oSx1      := FWSX1Util():New()
Local aPergRel  := {}

DEFAULT cChave		:= ""
DEFAULT cFiltro		:= ""

oSx1:AddGroup("AFR410")
oSx1:SearchGroup()
aPergRel := oSx1:GetGroup("AFR410")

lQuery := !(TcSrvType() == "AS/400" .or. TcSrvType() == "iSeries") // somente ira executar a query se nao for AS400

If lQuery //TOP
	cAliasTMP := "cAtfTmp"

	If Select( cAliasTMP ) > 0
		DbSelectArea( cAliasTMP )
		DbCloseArea()
	Endif
Else //DBF
	cAliasTMP := 'SN3'
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis ref a filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  mv_par13 == 2
	// Verifica modo de compartilhamento para filtro de filiais
	If FWModeAccess("SN3") == "C"
		cFilDe  := " "
		cFilAte := " "
	Else
		If MV_PAR09 == 1
			cFilDe  := MV_PAR10
			cFilAte := MV_PAR11
		Else
			cFilDe  := cFilAnt
			cFilAte := cFilAnt
		EndIf
	EndIf
ELSE
	cFilDe := aSelFil[1]	// Todas as filiais
	cFilAte:= aSelFil[len(aSelFil)]
Endif

If lQuery //TOP
	// montagem da query para SN1
	aStruSn1 := SN1->( dbStruct() )
	For nI := 1 to Len( aStruSn1 )
		If !Empty( cCampos )
			cCampos += ", "
		Endif
	
		cCampos += aStruSn1[nI,1]
	Next ni	  		  	
	
	// montagem da query para SN3
	aStruSn3 := SN3->( dbStruct() )
	For nI := 1 to Len( aStruSn3 )
		If !Empty( cCampos )
			cCampos += ", "
		Endif
	
		cCampos += aStruSn3[nI,1]
	Next ni	  		  	
	
	cQuery := "SELECT " 
	cQuery += cCampos + ", SA2.A2_NREDUZ, SN3.R_E_C_N_O_ RECNOSN3 "
	cQuery += " FROM " + RetSqlName( "SN3" ) + " SN3"

	cQuery += " 	LEFT JOIN " + RetSqlName( "SN1" ) + " SN1 ON "
	cQuery += " 		SN1.N1_FILIAL  = SN3.N3_FILIAL AND " 
	cQuery += "			SN1.N1_CBASE   = SN3.N3_CBASE AND "
	cQuery += " 		SN1.N1_ITEM    = SN3.N3_ITEM AND "
	cQuery += "			SN1.D_E_L_E_T_ = ' ' "

	// concatenacao de tabelas - SN1 --> SA2
	cQuery += " 	LEFT JOIN " + RetSqlName( "SA2" ) + " SA2 ON "
	cQuery += " 		SA2.A2_COD = SN1.N1_FORNEC AND SA2.A2_LOJA = SN1.N1_LOJA AND SA2.D_E_L_E_T_ = ' '"

	// clausulas do filtro
	cQuery += " WHERE "

	// faixa de filiais
	If !Empty( cFilDe )
		cQuery += "SN3.N3_FILIAL >= '" + cFilDe + "' AND "
	Endif
	If !Empty( cFilAte )
		cQuery += "SN3.N3_FILIAL <= '" + cFilAte+ "' AND "
	Endif

	// faixa de contas contabeis
	If !Empty( mv_par03 )
		cQuery += "SN3.N3_CCONTAB >= '" + mv_par03 + "' AND "
	Endif
	If !Empty( mv_par04 )
		cQuery += "SN3.N3_CCONTAB <= '" + mv_par04 + "' AND "
	Endif

	// faixa de centros de custo
	If !Empty( mv_par05 )
		cQuery += "SN3.N3_CCUSTO  >= '" + mv_par05 + "' AND "
	Endif
	If !Empty( mv_par06 )
		cQuery += "SN3.N3_CCUSTO  <= '" + mv_par06 + "' AND "
	Endif

	// faixa de aquisicoes
	If !Empty( mv_par01 )
		cQuery += "SN3.N3_AQUISIC >= '" + DTOS( mv_par01 ) + "' AND "
	Endif
	If !Empty( mv_par02 )
		cQuery += "SN3.N3_AQUISIC <= '" + DTOS( mv_par02 ) + "' AND "
	Endif
	
	// Tipo de Saldo
	If !Empty( mv_par12 )
		cQuery += "SN3.N3_TPSALDO = '" +  mv_par12 + "' AND "
	Endif
	
	If Len(aPergRel) > 0 .And. Len(aPergRel[2]) >= 14

		cQryTip12 := "FROM " + RetSqlName("SN3") + " SN3_TIPO12 "
		cQryTip12 += "WHERE "
		cQryTip12 += "SN3_TIPO12.N3_FILIAL = SN3.N3_FILIAL AND " // Ordens dos campos no WHERE baseado na ordem 1 (N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA+N3_SEQ)
		cQryTip12 += "SN3_TIPO12.N3_CBASE = SN3.N3_CBASE AND "
		cQryTip12 += "SN3_TIPO12.N3_ITEM = SN3.N3_ITEM AND "
		cQryTip12 += "SN3_TIPO12.N3_TIPO = '"+cTipoGer+"' AND "
		cQryTip12 += "SN3_TIPO12.D_E_L_E_T_ = ' ' "
		//Retornar Inclusive Ativos que não movimentaram SN3 por IMPAIRMENT
		cQrySNJ := "FROM " + RetSqlName("SNI") + " NI "
		cQrySNJ += "INNER JOIN " + RetSqlName("SNJ") + " NJ ON NI_FILIAL = NJ_FILIAL AND NI_PROC = NJ_PROC "
		cQrySNJ += "WHERE NJ_FILIAL = SN3.N3_FILIAL"
		cQrySNJ += " AND NJ_BEM = SN3.N3_CBASE 
		cQrySNJ += " AND NJ_ITBEM = SN3.N3_ITEM  "
		cQrySNJ += " AND NJ_TPSALDO = SN3.N3_TPSALDO "
		cQrySNJ += " AND NJ_TIPO = SN3.N3_TIPO "
		cQrySNJ += " AND NI_STATUS = '2' "
		cQrySNJ += " AND NJ_VLORI01 - NJ_VLREC01 = 0 "
		cQrySNJ += " AND NI.D_E_L_E_T_ = ' ' AND NJ.D_E_L_E_T_ = ' ' "
		
		If cDBMS == 'ORACLE'
			cSubQuery := "SELECT N3_TIPO " + cQryTip12 + " AND ROWNUM < 2"
			cSubSNJ   := "SELECT NJ_TIPO " + cQrySNJ   + " AND ROWNUM < 2"
		ElseIf cDBMS == 'POSTGRES'
			cSubQuery := "SELECT N3_TIPO " + cQryTip12 + " LIMIT 1"
			cSubSNJ := "SELECT NJ_TIPO " + cQrySNJ   + " LIMIT 1"
		Else
			cSubQuery := "SELECT TOP 1 N3_TIPO " + cQryTip12
			cSubSNJ := "SELECT TOP 1 NJ_TIPO " + cQrySNJ
		EndIf

		// faixa de itens
		If MV_PAR14 == 1 // Somente depreciação fiscal, mas só pode imprimir se houver um registro de Valor Recuperável no mesmo ativo imobilizado.
			cQuery += "SN3.N3_TIPO = '01' AND "
			cQuery += "( EXISTS  "
			cQuery += "( "+ cSubQuery + " ) "
			cQuery += "OR EXISTS  "
			cQuery += "( "+ cSubSNJ + " ) "	
			cQuery += ") AND "
		ElseIf MV_PAR14 == 2 // Somente valor recuperável.
			cQuery += "SN3.N3_TIPO ='"+cTipoGer+"' AND "
		ElseIf MV_PAR14 == 3 // Depreciação contábil e valor recuperável.
			cQuery += "SN3.N3_TIPO IN ('"+cTipoGer+"', '12', '10') AND " // Fixado os tipos 12 e 10, pois pode acontecer do parametro MV_ATFTIOA estar configurado com outro tipo difente de 12 e 10.
			cQuery += "( EXISTS  "
			cQuery += "( "+ cSubQuery + " ) "
			cQuery += "OR EXISTS  "
			cQuery += "( "+ cSubSNJ + " ) "	
			cQuery += ") AND "
		Else // Todos.
			cQuery += "SN3.N3_TIPO IN ('"+cTipoGer+"', '12', '10', '01') AND " // Fixado os tipos 12 e 10, pois pode acontecer do parametro MV_ATFTIOA estar configurado com outro tipo difente de 12 e 10.
			cQuery += "( EXISTS  "
			cQuery += "( "+ cSubQuery + " ) "
			cQuery += "OR EXISTS  "
			cQuery += "( "+ cSubSNJ + " ) "	
			cQuery += ") AND "
		EndIf

	Else
		cQuery += "SN3.N3_TIPO ='"+GetMv( "MV_ATFTIOA", .F., "12" )+"' AND "
	EndIf

	// Se nao considera itens baixados, filtra na query
	If mv_par08 == 2
		cQuery += "SN3.N3_BAIXA = '0' AND "
	Endif	

	// filtro dos nao deletados
	cQuery += "SN3.D_E_L_E_T_ = ' '"

	// efetua o filtro do usuario	
	If !Empty( cUserFilter )
		cQuery += " AND " + ADMParSQL( cUserFilter ) // funcao de Parse na query
	Endif

	// ordem baseada na chave passada
	If !Empty( cChave )
		cQuery += " ORDER BY " + STRTRAN( cChave , "+" , "," )
	Endif
                                   
	//retira os espacos em branco da query e transforma no padrao ANSI
	cQuery := ChangeQuery( cQuery )
		
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasTMP, .T., .T.)
	
	// reconstruo o tipo do campo, conforme estrutura da tabela
	For nI := 1 to Len( aStruSn1 )
		If aStruSn1[nI,2] != "C"
			TCSetField( cAliasTMP, aStruSn1[nI,1] /*Nome*/, aStruSn1[nI,2]/*tipo*/,aStruSn1[nI,3]/*tamanho*/,aStruSn1[nI,4] /*precisao*/ )	
		Endif
	Next
	For nI := 1 to Len( aStruSn3 )
		If aStruSn3[nI,2] != "C" 
			TCSetField( cAliasTMP, aStruSn3[nI,1] /*Nome*/, aStruSn3[nI,2]/*tipo*/,aStruSn3[nI,3]/*tamanho*/,aStruSn3[nI,4] /*precisao*/ )	
		Endif
	Next

	If Select( cAliasTMP ) <= 0
		Conout( 'Erro na montagem da query'	+ CRLF + cQuery )
	Endif
Else 
	cFiltro := 'N3_FILIAL >= "'+xFilial("SN3",cFilDe)+'" .And. '
	cFiltro := 'N3_FILIAL <= "'+xFilial("SN3",cFilAte)+'" .And. '
	cFiltro += 'N3_CCONTAB>= "'+mv_par03+'" .And. '
	cFiltro += 'N3_CCONTAB<= "'+mv_par04+'" .And. '
	cFiltro += 'N3_CCUSTO >= "'+mv_par05+'" .And. '
	cFiltro += 'N3_CCUSTO <= "'+mv_par06+'" .And. '
	cFiltro += 'DTOS(N3_AQUISIC) >= "'+DTOS(mv_par01)+'" .And. '
	cFiltro += 'DTOS(N3_AQUISIC) <= "'+DTOS(mv_par02)+'" .And. '

	cFiltro += 'N3_TIPO = "'+Alltrim(cTipoGer)+'"'

	// Se nao considera itens baixados, filtra na query
	If mv_par08 == 2
		cFiltro += ' .AND. N3_BAIXA == "0" '
	Endif	

	// efetua o filtro do usuario
	If !Empty( cUserFilter )
		cFiltro += " .AND. " + cUserFilter
	Endif
Endif

RestArea( aArea )

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Atfr410IdxºAutor  ³Renato F. Campos    º Data ³  23/12/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que gera um indice por data dos bens cadastrados    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR410                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Atfr410Idx( cAliasTMP, cChave, lQuery)
Local aArea := GetArea()
Local cArqInd
Local nIndex	:= 0

dbSelectArea(cAliasTMP)

cArqInd	:= CriaTrab(Nil, .F.)

IndRegua( cAliasTMP,cArqInd,STRTRAN( cChave , "," , "+" ),,,OemToAnsi(STR0020))  //"Selecionando Registros..."

dbSelectArea(cAliasTMP)

IF lQuery
	DbClearIndex()
Endif

dbSetIndex(cArqInd+OrdBagExt())

If lQuery
	nIndex  := RetIndex(cAliasTMP)
Endif

nIndex++

RestArea( aArea )

Return nIndex
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR410   ºAutor  ³Microsiga           º Data ³  23/12/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetChave( lQuery, nOrder )
/*Local Declarations*/
Local lResult	:= .T.
Local cChave	:= ""

/*Initialization*/
Default nOrder	:= 1       
Default lQuery	:= .F.

/*Implementation*/
If lResult
	If lQuery //TOP
		IF		nOrder == 1
			cChave	:= "N3_FILIAL,N3_CCONTAB,N3_CBASE,N3_ITEM"
		ElseIF	nOrder == 2
			cChave	:= "N3_FILIAL,N3_CCUSTO,N3_CBASE,N3_ITEM"
		ElseIF	nOrder == 3
			cChave	:= "N3_FILIAL,N3_AQUISIC,N3_CBASE,N3_ITEM"
		EndIf
	Else //DBF
		IF		nOrder == 1
			cChave	:= "N3_FILIAL+N3_CCONTAB+N3_CBASE+N3_ITEM"
		ElseIF	nOrder == 2
			cChave	:= "N3_FILIAL+N3_CCUSTO+N3_CBASE+N3_ITEM"
		ElseIF	nOrder == 3
			cChave	:= "N3_FILIAL+DTOS(N3_AQUISIC)+N3_CBASE+N3_ITEM"
		EndIf
	Endif
Endif

Return ( cChave )
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AdmAbreSM0³ Autor ³ Orizio                ³ Data ³ 22/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AdmAbreSM0()
	Local aArea			:= SM0->( GetArea() )
	Local aAux			:= {}
	Local aRetSM0		:= {}
	Local lFWLoadSM0	:= FindFunction( "FWLoadSM0" )
	Local lFWCodFilSM0 	:= FindFunction( "FWCodFil" )

	If lFWLoadSM0
		aRetSM0	:= FWLoadSM0()
	Else
		DbSelectArea( "SM0" )
		SM0->( DbGoTop() )
		While SM0->( !Eof() )
			aAux := { 	SM0->M0_CODIGO,;
						IIf( lFWCodFilSM0, FWGETCODFILIAL, SM0->M0_CODFIL ),;
						"",;
						"",;
						"",;
						SM0->M0_NOME,;
						SM0->M0_FILIAL }

			aAdd( aRetSM0, aClone( aAux ) )
			SM0->( DbSkip() )
		End
	EndIf

	RestArea( aArea )
Return aRetSM0



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    AFR410SNJ Autor ³ Ewerton Franklin       ³ Data ³ 20/08/2024 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna o Valor do Último Teste de Impairment do bem        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AFR410SNJ(cFil as Character,cBaseSNJ as Character,cItemSNJ as Character, cTipoSNJ as Character, nVlOrig as Numeric,cSeq as Character) as Numeric

Local cQuery  := ""  as Character
Local nParam  := 1   as numeric
Local cAlias  := ""  as Character
Local nRecno := 0   as numeric
Local oQryExec	     as Object
Local cDBMS   := Upper(TCGetDB()) as Character

Default cFil 	:= FWxFilial("SN3")
Default cBaseSNJ:= ""
Default cItemSNJ:= ""
Default cTipoSNJ:= ""
Default nVlOrig:= ""
Default cSeq	:= ""

If cDBMS == 'ORACLE'
	cQuery := " SELECT R_E_C_N_O_ REC  "
	cQuery += "FROM ( 				   "
	cQuery += "	SELECT NJ.R_E_C_N_O_,  "
	cQuery += "		NI.NI_DTIOA        "
	cQuery += "	FROM ? NI         "
	cQuery += "	INNER JOIN ? NJ ON NI.NI_FILIAL = NJ.NJ_FILIAL AND NI.NI_PROC = NJ.NJ_PROC "
	cQuery += "	WHERE NJ_FILIAL = ? AND NJ.NJ_BEM = ? AND NJ_ITBEM = ?  "
	cQuery += " AND ( NJ_TIPO = ? OR NJ_SEQSN3 = ? )  "
	cQuery += " AND NJ.NJ_VLREC01 = ? "
	cQuery += " AND NI.NI_STATUS = ? "
	cQuery += "	AND NI.D_E_L_E_T_ = ? "
	cQuery += "	AND NJ.D_E_L_E_T_ = ? "

	cQuery += "	ORDER BY NJ.R_E_C_N_O_ DESC "
	cQuery += " )
	cQuery += " WHERE ROWNUM = 1; "
Else
	If cDBMS == 'POSTGRES'
		cQuery := " SELECT NJ.R_E_C_N_O_ REC "
	Else
		cQuery := " SELECT TOP 1 NJ.R_E_C_N_O_  REC"
	EndIf
	cQuery += " FROM ? NI "
	cQuery += " INNER JOIN ? NJ ON NI.NI_FILIAL = NJ.NJ_FILIAL AND NI.NI_PROC = NJ.NJ_PROC "
	cQuery += " WHERE  NJ_FILIAL = ? AND NJ.NJ_BEM = ? AND NJ_ITBEM = ?   "
	cQuery += " AND ( NJ_TIPO = ? OR NJ_SEQSN3 = ? )  "
	cQuery += " AND NJ.NJ_VLREC01 = ? "
	cQuery += " AND NI.NI_STATUS = ? "
	cQuery += " AND NI.D_E_L_E_T_ = ? "
	cQuery += " AND NJ.D_E_L_E_T_ = ? "

	cQuery += " ORDER BY NJ.R_E_C_N_O_ DESC "
	If cDBMS == 'POSTGRES'
		cQuery += " LIMIT 1;
	EndIf

EndIf

cQuery := ChangeQuery(cQuery)

oQryExec := FWExecStatement():New(cQuery)

oQryExec:SetUnsafe(nParam++, RetSQLName("SNI"))
oQryExec:SetUnsafe(nParam++, RetSQLName("SNJ"))
oQryExec:SetString(nParam++, cFil)
oQryExec:SetString(nParam++, cBaseSNJ)
oQryExec:SetString(nParam++, cItemSNJ)
oQryExec:SetString(nParam++, cTipoSNJ)
oQryExec:SetString(nParam++, cSeq)
oQryExec:SetNumeric(nParam++, nVlOrig)
oQryExec:SetString(nParam++, '2')
oQryExec:SetString(nParam++, Space(1)) 
oQryExec:SetString(nParam++, Space(1)) 

cAlias := oQryExec:OpenAlias(GetNextAlias())

If (cAlias)->(! Eof() )
	nRecno	:= (cAlias)->REC
EndIf

(cAlias)->(DbCloseArea())
oQryExec:Destroy()
oQryExec:=Nil


Return nRecno
