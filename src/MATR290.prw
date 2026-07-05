/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR290.CH"
#INCLUDE "PROTHEUS.CH"
//#INCLUDE "FWLIBVERSION.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR290  ³ Autor ³ Ricardo Berti         ³ Data ³18.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao da Analise de Estoques                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAEST                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR290()

Local oReport

Static __l290VLib
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Ricardo Berti 		³ Data ³18.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR290                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local lVEIC     := UPPER(GETMV("MV_VEICULO"))=="S" // Se = "S" Nao ha' ordem por Consumo
Local aOrdem    :={STR0005, STR0006, STR0007, STR0008} //" Por Codigo         "###" Por Tipo           "###" Por Descricao     "###" Por Grupo         "
Local cAliasTOP := "SB1"
Local cAliasSB3 := "SB3"
Local cPerg     := "MTR290"
Local oReport
Local oSection1
Local nSaldoPro := 0
Local aTabelas

__l290VLib	:= .T. //If(__l290VLib == NIL,FWLibVersion() >= "20211116",__l290VLib)
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
If !lVeic
	Aadd(aOrdem,STR0020)  //" Por Consumo      "
EndIf

oReport := TReport():New("MATR290",STR0001,cPerg, {|oReport| ReportPrint(oReport,lVeic,@cAliasTOP,@cAliasSB3,@nSaldoPro)},STR0002+" "+STR0003+" "+STR0004) //"Relacao para Analise dos Estoques"##"Este relatorio demonstra a situacao de cada item em relacao ao"###"seu saldo , seu empenho , suas entradas previstas e sua classe"###"ABC."
oReport:SetLandScape()
oReport:SetTotalInLine(.F.)
oReport:SetTotalText(STR0016) //"T o t a l   G e r a l :"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Produto de                                   ³
//³ mv_par02     // Produto ate                                  ³
//³ mv_par03     // tipo de                                      ³
//³ mv_par04     // tipo ate                                     ³
//³ mv_par05     // grupo de                                     ³
//³ mv_par06     // grupo ate                                    ³
//³ mv_par07     // descricao de                                 ³
//³ mv_par08     // descricao ate                                ³
//³ mv_par09     // Tudo ou so a Comprar                         ³
//³ mv_par10     // Subtrai empenho para Calculo Saldo           ³
//³ mv_par11     // Lista apenas itens obsoletos                 ³
//³ mv_par12     // data limite p/itens obsoletos                ³
//³ mv_par13     // Cons. Saldo do Almox. Processo ?  Sim , Nao  ³
//³ mv_par14     // Desconsidera P.V. que N Atu.Est.? Sim , Nao  ³
//³ mv_par15     // Lista produto com Saldo zerado  ? Sim , Nao  ³
//³ mv_par16     // Considera OPs 1- Firmes 2- Previstas 3- Ambas³
//³ mv_par17     // Almoxarifado De  ?                           ³
//³ mv_par18     // Almoxarifado Ate ?                           ³
//³ mv_par19     // Consid Residuos PV ?  Sim, Nao               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//-- Só adiciona SB1 no personalizável quando não compartilhado ou sem gestão de empresas
//-- Isto para habilitar o recurso de impressão em N filiais (botão Gestão de Empresas)
If FWModeAccess("SB1",1) == "E" .Or. (At("E",FWSM0Layout()) == 0 .And. At("U",FWSM0Layout()) == 0)
	aTabelas := {"SB1","SB3"}
Else
	aTabelas := {"SB3"}
EndIf
oSection1 := TRSection():New(oReport,STR0034,aTabelas,aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oSection1:SetHeaderPage()

TRCell():New(oSection1, "B1_COD"   , "SB1", /*Titulo*/          , /*Picture*/, /*Tamanho*/, /*lPixel*/, /*{|| code-block de impressao }*/                                                              , /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/)
TRCell():New(oSection1, "B1_CODITE", "SB1")
TRCell():New(oSection1, "B1_DESC"  , "SB1")
TRCell():New(oSection1, "B1_TIPO"  , "SB1", STR0035)
TRCell():New(oSection1, "B1_GRUPO" , "SB1")
TRCell():New(oSection1, "B1_UM"    , "SB1", STR0036)
TRCell():New(oSection1, 'B2_QATU'  , 'SB2')
TRCell():New(oSection1, 'B2_QEMP'  , 'SB2')
TRCell():New(oSection1, 'C1_QUANT' , 'SC1', STR0024+CRLF+STR0025) //"SCs"###"Colocadas"
TRCell():New(oSection1, 'C7_QUANT' , 'SC7', STR0026+CRLF+STR0027) //"PCs"###"Colocados"
TRCell():New(oSection1, 'C2_QUANT' , 'SC2', STR0028+CRLF+STR0025) //"OPs"###"Colocadas"
TRCell():New(oSection1, 'C6_QTDVEN', 'SC6', STR0029+CRLF+STR0027) //"PVs"###"Colocados"
TRCell():New(oSection1, 'B1_EMIN'  , 'SB1',                     ,            ,            ,           , {|| RetFldProd((cAliasTop)->B1_COD,"B1_EMIN",cAliasTop)})
TRCell():New(oSection1, 'B1_LE'    , 'SB1',                     ,            ,            ,           , {|| RetFldProd((cAliasTop)->B1_COD,"B1_LE",cAliasTop)})
TRCell():New(oSection1, 'B1_PE'    , 'SB1',                     ,            ,            ,           , {|| CalcPrazo((cAliasTop)->B1_COD,RetFldProd((cAliasTop)->B1_COD,"B1_LE",cAliasTop))})
TRCell():New(oSection1, 'B1_TIPE'  , 'SB1', " "                 ,            ,            ,           , {|| RetFldProd((cAliasTop)->B1_COD,"B1_TIPE",cAliasTop)})
TRCell():New(oSection1, 'ESTMES'   , '   ', STR0030+CRLF+STR0031,            ,            ,           , {|| If((cAliasSB3)->B3_MEDIA != 0,Transform(nSaldoPro/(cAliasSB3)->B3_MEDIA,"99999"),STR0032)}) //"Estoque"###"em Meses"###"  N/D"
TRCell():New(oSection1, 'B3_MEDIA' , 'SB3')
TRCell():New(oSection1, 'B2_USAI'  , 'SB2')
// B3_CLASSE e' combo e precisa de code-block de impressao, p/ inibir a impressao descritiva automatica
TRCell():New(oSection1, 'CLASSE'   , 'SB3', STR0033             ,            ,            ,           , {||(cAliasSB3)->B3_CLASSE }) //"CL"

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Ricardo Berti         ³ Data ³18.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³ExpL1: Se .T. = gestao de Concessionarias(MV_VEICULO ="S")  ³±±
±±³          ³ExpL2: Se .T. = base TOP 									  ³±±
±±³          ³ExpC1: Alias do arquivo SB1								  ³±±
±±³          ³ExpC2: Alias do arquivo SB3								  ³±±
±±³          ³ExpN1: var.calculada do saldo em estoque					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR290                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,lVeic,cAliasTOP,cAliasSB3,nSaldoPro)

Local XSB1, XSB2, XSB3, XSC1, XSC2, XSC6, XSC7, XSC9, XSF4
Local oSection1 := oReport:Section(1)
Local cOrdem
Local nOrdem    := oReport:Section(1):GetOrder()
Local oBreak
Local nEmpPro,nSCPro,nPCPro,nOPPro,nPVPro
Local dUsai,nSaldo,nEmin,lT
Local cLocProc  := GetMvNNR( 'MV_LOCPROC' , '99' )
Local cCondicao
Local cOrderBy
Local cWhere
Local lTemB2    := .F.
Local cQuery    := ""
Local cQrySC1   := ""
Local cQrySC9   := ""
Local oStatSC1
Local oTmpSC6
Local oTmpSC7
Local oStatSC9
Local cAliasSC1 := ""
Local nSldSC2 := 0

Private cVar ,cCondSec

If nOrdem == 1
	cOrdem := STR0005
ElseIf nOrdem == 2
	cOrdem := STR0006
ElseIf nOrdem == 3
	cOrdem := STR0007
ElseIf nOrdem == 4
	cOrdem := STR0008
ElseIf nOrdem == 5
	cOrdem := STR0020
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title()+" ("+AllTrim(cOrdem)+")" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa os Arquivos e Ordens a serem utilizados           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF4")
dbSetOrder(1)
XSF4	:= XFILIAL("SF4")

dbSelectArea("SC9")
dbSetOrder(1)
XSC9	:= XFILIAL("SC9")

dbSelectArea("SC7")
dbSetOrder(1)
XSC7	:= XFILIAL("SC7")

dbSelectArea("SC6")
dbSetOrder(1)
XSC6	:= XFILIAL("SC6")

dbSelectArea("SC2")
dbSetOrder(1)
XSC2	:= XFILIAL("SC2")

dbSelectArea("SC1")
dbSetOrder(1)
XSC1	:= XFILIAL("SC1")

dbSelectArea("SB3")
dbSetOrder(1)
XSB3	:= XFILIAL("SB3")

dbSelectArea("SB2")
dbSetOrder(1)
XSB2	:= XFILIAL("SB2")

dbSelectArea("SB1")
dbSetOrder(1)
XSB1	:= XFILIAL("SB1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	Visualizacao de colunas conforme parametrizacao				  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lVeic
	oSection1:Cell('B1_COD'):Disable()
	oSection1:Cell('C2_QUANT'):Disable()
Else
	oSection1:Cell('B1_CODITE'):Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:GetParam())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCondicao := "!Eof()"
cWhere := "%"
If lVeic
	cWhere += " AND SB1.B1_CODITE >= '" + mv_par01 + "' AND SB1.B1_CODITE <='" + mv_par02 + "' "
Else
	cWhere += " AND SB1.B1_COD    >= '" + mv_par01 + "' AND SB1.B1_COD    <='" + mv_par02 + "' "
EndIf
cWhere += "%"

cOrderBy := "%"
If ! lVEIC
	If nOrdem == 5
		cOrderBy += " B3_MEDIA"
	ElseIf nOrdem == 4
		cOrderBy += " B1_GRUPO, B1_COD"   // Por Grupo, Codigo
	ElseIf nOrdem == 3
		cOrderBy += " B1_DESC, B1_COD"   // Por Descricao, Codigo
	ElseIf nOrdem == 2
		cOrderBy += " B1_TIPO, B1_COD"   // Por Tipo, Codigo
	Else
		cOrderBy += " B1_COD"      // Por Codigo
	EndIf
Else
	If nOrdem == 4
		cOrderBy += " B1_GRUPO, B1_CODITE"   // Por Grupo, Codite
	ElseIf nOrdem == 3
		cOrderBy += " B1_DESC, B1_CODITE"   // Por Descricao, Codite
	ElseIf nOrdem == 2
		cOrderBy += " B1_TIPO, B1_CODITE"   // Por Tipo, Codite
	Else
		cOrderBy += " B1_CODITE"      // Por Codite
	Endif
EndIf
cOrderBy += "%"

oReport:Section(1):BeginQuery()

cAliasTOP := GetNextAlias()
cAliasSB3 := cAliasTOP

If nOrdem <> 5

	BeginSql Alias cAliasTOP

	SELECT B1_FILIAL,B1_COD,B1_CODITE,B1_DESC,B1_TIPO,B1_GRUPO,B1_UM,B1_EMIN,B1_LE,B1_TIPE,B1_LOCPAD,
				B3_FILIAL,B3_COD,B3_MEDIA,B3_CLASSE

	FROM %table:SB1% SB1
		LEFT JOIN %table:SB3% SB3
		ON	B3_FILIAL = %xFilial:SB3% AND
			B3_COD = B1_COD AND
			SB3.%NotDel%

		WHERE	B1_FILIAL  = %xFilial:SB1% AND
			B1_TIPO   >= %Exp:mv_par03% AND
			B1_TIPO   <= %Exp:mv_par04% AND
			B1_GRUPO  >= %Exp:mv_par05% AND
			B1_GRUPO  <= %Exp:mv_par06% AND
			B1_DESC   >= %Exp:mv_par07% AND
			B1_DESC   <= %Exp:mv_par08% AND
			SB1.%NotDel%
			%Exp:cWhere%

		ORDER BY %Exp:cOrderBy%

	EndSql

Else
	BeginSql Alias cAliasTOP

	SELECT B1_FILIAL,B1_COD,B1_CODITE,B1_DESC,B1_TIPO,B1_GRUPO,B1_UM,B1_EMIN,B1_LE,B1_TIPE,B1_LOCPAD,
				B3_FILIAL,B3_COD,B3_MEDIA,B3_CLASSE

	FROM %table:SB1% SB1
		RIGHT JOIN %table:SB3% SB3
		ON	B3_FILIAL = %xFilial:SB3% AND
			B3_COD = B1_COD AND
			SB3.%NotDel%

		WHERE	B1_FILIAL  = %xFilial:SB1% AND
			B1_TIPO   >= %Exp:mv_par03% AND
			B1_TIPO   <= %Exp:mv_par04% AND
			B1_GRUPO  >= %Exp:mv_par05% AND
			B1_GRUPO  <= %Exp:mv_par06% AND
			B1_DESC   >= %Exp:mv_par07% AND
			B1_DESC   <= %Exp:mv_par08% AND
			SB1.%NotDel%
			%Exp:cWhere%

		ORDER BY %Exp:cOrderBy%

	EndSql

EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatorio para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definindo a quebra do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 2
	oBreak := TRBreak():New(oSection1,oSection1:Cell('B1_TIPO'),STR0014,.F.) //"T o t a l  d o   T i p o : "
ElseIf nOrdem == 4
	oBreak := TRBreak():New(oSection1,oSection1:Cell('B1_GRUPO'),STR0015,.F.) //"T o t a l   d o   G r u p o : "
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definindo os totalizadores do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRFunction():New(oSection1:Cell('B2_QATU'  ),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell('B2_QEMP'  ),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell('C1_QUANT' ),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell('C7_QUANT' ),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell('C2_QUANT' ),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell('C6_QTDVEN'),NIL,"SUM",oBreak,NIL,/*Picture*/,/*uFormula*/,.F.,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona os indices dos arquivos consultados                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF4")
dbSetOrder(1)

dbSelectArea("SC1")
dbSetOrder(2)

dbSelectArea("SC2")
dbSetOrder(2)

dbSelectArea("SC6")
dbSetOrder(2)

dbSelectArea("SC7")
dbSetOrder(2)

dbSelectArea("SC9")
dbSetOrder(1)

//
// STATEMENT SC1
//
cQuery := ""
cQuery += "SELECT C1_QUANT ,C1_QUJE, C1_TPOP "
cQuery += "FROM " +RetSQLName("SC1")+ " SC1 "
cQuery += "WHERE SC1.C1_FILIAL = ? "
cQuery += "AND SC1.C1_PRODUTO = ? "
cQuery += "AND SC1.C1_LOCAL >= ? AND SC1.C1_LOCAL <= ? "
cQuery += "AND SC1.C1_RESIDUO <> 'S' "
cQuery += "AND SC1.C1_QUJE < SC1.C1_QUANT "
cQuery += "AND SC1.D_E_L_E_T_ = ' ' "
cQrySC1 := ChangeQuery(cQuery)

	If __l290VLib
		oStatSC1 := FwExecStatement():New(cQuery)
	Else
		oStatSC1 := FWPreparedStatement():New()
		oStatSC1:SetQuery(cQrySC1)
	EndIf 

cAliasSC1 := GetNextAlias()

//
// STATEMENT SC6
//
oTmpSC6 := GeraSC6Tmp(xSC6,xSF4,xSB1)

//
// STATEMENT SC7
//
oTmpSC7 := GeraSC7Tmp(xSC7,xSF4,xSB1)

//
// STATEMENT SC9
//
cQuery := ""
cQuery += "SELECT SUM(SC9.C9_QTDLIB) C9_QTDLIB "
cQuery += "FROM " +RetSQLName("SC9")+ " SC9 "
cQuery += "WHERE SC9.C9_FILIAL = ? "
cQuery += "AND SC9.C9_PEDIDO = ? "
cQuery += "AND SC9.C9_ITEM = ? "
cQuery += "AND SC9.C9_PRODUTO = ? "
cQuery += "AND SC9.C9_LOCAL >= ? AND SC9.C9_LOCAL <= ? "
cQuery += "AND (SC9.C9_BLEST = '10' OR ( SC9.C9_BLEST = '"+ space(len(SC9->C9_BLEST)) +"' AND SC9.C9_BLCRED = '"+ space(len(SC9->C9_BLCRED)) +"' )) "
cQuery += "AND SC9.D_E_L_E_T_ = ' ' "
cQrySC9 := ChangeQuery(cQuery)

	If __l290VLib
		oStatSC9 := FwExecStatement():New(cQrySC9)
	Else
		oStatSC9 := FWPreparedStatement():New()
		oStatSC9:SetQuery(cQrySC9)
	EndIf 
// limpa
cQuery := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter( SB1->(LastRec()) )

dbSelectArea(cAliasTOP)
cCondicao += ".and.B1_FILIAL=='" + xSB1 + "'"

oSection1:Init()
While !oReport:Cancel() .And. &(cCondicao)
	cCondSec := "B1_FILIAL=='" + xSB1 + "' .And. "
	if ! lVEIC
		If nOrdem == 4
			cVar     := B1_GRUPO
			cCondSec += "B1_GRUPO == cVar"
		ElseIf nOrdem == 3
			cVar     := B1_DESC
			cCondSec += "B1_DESC == cVar"
		ElseIf nOrdem == 2
			cVar     := B1_TIPO
			cCondSec += "B1_TIPO == cVar"
		Else
			cVar     := B1_COD
			cCondSec += "B1_COD == cVar"
		Endif
	ELSE
		If nOrdem == 4
			cVar     := B1_GRUPO
			cCondSec += "B1_GRUPO == cVar"
		ElseIf nOrdem == 3
			cVar     := B1_DESC
			cCondSec += "B1_DESC == cVar"
		ElseIf nOrdem == 2
			cVar     := B1_TIPO
			cCondSec += "B1_TIPO == cVar"
		Else
			cVar     := B1_CODITE
			cCondSec += "B1_CODITE == cVar"
		Endif
	ENDIF

	DO While !oReport:Cancel() .And. &(cCondicao) .And. &(cCondSec)

		oReport:IncMeter()

		lT := .F.
		If ! lVEIC
			If B1_COD < mv_par01 .Or. B1_COD > mv_par02
	   			lT := .T.
	        endif
		Else
			if B1_CODITE < mv_par01 .Or. B1_CODITE > mv_par02
	   			lT := .T.
			endif
		EndIf
		If lT .Or. B1_TIPO < mv_par03 .Or. B1_TIPO > mv_par04 .Or.;
			   B1_GRUPO < mv_par05 .Or. B1_GRUPO > mv_par06 .Or.;
			   B1_DESC < mv_par07 .Or. B1_DESC > mv_par08
			dbSkip()
			Loop
		EndIf

		Store 0 To nSaldoPro,nEmpPro,nSCPro,nPCPro,nOPPro,nPVPro

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Soma os saldos iniciais e os empenhos do SB2                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SB2")
		Seek xSB2 + (cAliasTop)->B1_COD
		dUsai := B2_USAI
		lTemB2 := .F.
		Do While !oReport:Cancel() .And. !Eof() .And. B2_FILIAL + B2_COD == xSB2 + (cAliasTop)->B1_COD

			IF B2_LOCAL == cLocProc .and. mv_par13 == 2
				dbSkip()
				Loop
			Endif

			If B2_LOCAL < mv_par17 .Or. B2_LOCAL > mv_par18
				dbSkip()
				Loop
			EndIf

			nSaldoPro += B2_QATU
			nEmpPro   += If(mv_par16==1,B2_QEMP,If(mv_par16==2,B2_QEMPPRE,B2_QEMP+B2_QEMPPRE))
			nEmpPro   += If(mv_par20==1,B2_QEMPPRJ,0)
			nEmpPro   += B2_RESERVA+B2_QEMPSA
			If dUsai < B2_USAI
				dUsai := B2_USAI
			EndIf
			IF B2_LOCAL >= mv_par17 .And. B2_LOCAL <= mv_par18
				lTemB2 := .T.
			EndIF
			dbSkip()

		EndDo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o relatorio foi interrompido pelo usuario        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If oReport:Cancel()
			Exit
		EndIf

		If !( lTemB2 )
			dbSelectArea(cAliasTop)
			If ( mv_par09 == 2 .And. mv_par11 == 2 )
				(cAliasTop)->( dbSkip() ) ; Loop
			EndIf

			If !( (cAliasTop)->B1_LOCPAD >= mv_par17 .And. (cAliasTop)->B1_LOCPAD <= mv_par18 )
				(cAliasTop)->( dbSkip() ) ; Loop
			EndIf

		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se deve subtrair empenho do saldo atual             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par10 == 1
			nSaldoPro -= nEmpPro
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se deve listar apenas os obsoletos                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par11 == 1
			If lTemB2 .and. (Empty(dUsai) .Or. dUsai > mv_par12)
				dbSelectArea(cAliasTop)
				dbSkip()
				Loop
			EndIf
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Aglutina as Solicitacos de Compra sem pedido colocado        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nSCPro := AglutSC(@oReport,@oStatSC1,cAliasSC1,xSC1,(cAliasTop)->B1_COD)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o relatorio foi interrompido pelo usuario        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If oReport:Cancel()
			Exit
		EndIf

		if ! lVEIC
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina as Ordens de Producao em aberto                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SC2")
			dbSeek(xSC2 + (cAliasTop)->B1_COD)

			Do While !oReport:Cancel() .And. !Eof() .And. C2_FILIAL + C2_PRODUTO == xSC2 + (cAliasTop)->B1_COD

				If C2_LOCAL < mv_par17 .Or. C2_LOCAL > mv_par18
					dbSkip()
					Loop
				EndIf

				If Empty(C2_DATRF) .And. MtrAvalOp(mv_par16)
					nSldSC2 := aSC2Sld()
					If nSldSC2 > 0
						nOPPro += nSldSC2
					EndIf
				EndIf
				dbSkip()

			EndDo
		endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o relatorio foi interrompido pelo usuario        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If oReport:Cancel()
			Exit
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Aglutina os Pedidos de Vendas ainda nao entregues            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPvPro := AglutPV(@oReport, @oTmpSC6, @oStatSC9, (cAliasTop)->B1_COD, xSC9, mv_par17, mv_par18)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o relatorio foi interrompido pelo usuario        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If oReport:Cancel()
			Exit
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Aglutina os Pedidos de Compra ainda nao entregues            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPCPro := AglutPC(@oReport, @oTmpSC7, (cAliasTop)->B1_COD, MV_PAR16)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o relatorio foi interrompido pelo usuario        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If oReport:Cancel()
			Exit
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica deve listar apenas os itens a comprar               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par09 == 2
			nSaldo	:= nSaldoPro+nSCPro+nPCPro+nOPPro
			nEmin	:= RetFldProd((cAliasTop)->B1_COD,"B1_EMIN",cAliasTop)
			If nSaldo > nEmin .Or. (nEmin == 0 .And. nSaldo == 0)
				dbSelectArea(cAliasTop)
				dbSkip()
				Loop
			EndIf
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica deve listar saldo de produto zerado                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par15 == 2 .And. nSaldoPro == 0
			dbSelectArea(cAliasTop)
			dbSkip()
			Loop
		Endif

		dbSelectArea(cAliasTop)
		oSection1:Cell('B2_QATU'   ):SetValue( nSaldoPro )
		oSection1:Cell('B2_QEMP'   ):SetValue( nEmpPro )
		oSection1:Cell('C1_QUANT'  ):SetValue( nSCPro )
		oSection1:Cell('C7_QUANT'  ):SetValue( nPCPro )
		If !lVeic
			oSection1:Cell('C2_QUANT'  ):SetValue( nOPPro )
		EndIf
		oSection1:Cell('C6_QTDVEN' ):SetValue( nPVPro )
		oSection1:Cell('B2_USAI' ):SetValue( dUsai )

		oSection1:PrintLine()

		dbSelectArea(cAliasTop)
		dbSkip()

	EndDo
	dbSelectArea(cAliasTop)

EndDo

oSection1:Finish()

oStatSC1:Destroy()
FWFreeObj(oStatSC1)

oStatSC9:Destroy()
FWFreeObj(oStatSC9)

oTmpSC6:Delete()
FWFreeObj(oTmpSC6)

oTmpSC7:Delete()
FWFreeObj(oTmpSC7)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original dos arquivos			         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC1")
dbSetOrder(1)
dbSelectArea("SC2")
dbSetOrder(1)
dbSelectArea("SC6")
dbSetOrder(1)
dbSelectArea("SC7")
dbSetOrder(1)

Return Nil

/*/{Protheus.doc} AglutSC
	Totaliza a quantidade do produto nas solicitaç?es de compra
	@type  Function
	@author reynaldo
	@since 25/06/2021
	@version 1.0
	@param oReport, objeto, Objeto da classe TReport utilizado
	@param oStatSC1, objeto, Objeto da classe FWPreparedStatement com a seleção das solicitações de compra e de acordo com a parametrização do relatorio.
	@param cAliasSC1, caracter, alias temporario para referencia do statment SELECT a ser executado
	@param xSC1, caracter, código da filial corrente da tabela solicitacao de compra
	@param cProduto, caracter, código do produto a ser pesquisado
	@return nSCPro , numerico, Quantidade de produto nos pedidos de vendas não entregue
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function AglutSC(oReport,oStatSC1,cAliasSC1,xSC1,cProduto)
LOCAL cQrySC1
LOCAL nSCPro

	dbSelectArea("SC1")
	oStatSC1:SetString(1, xSC1)
	oStatSC1:SetString(2, cProduto)
	oStatSC1:SetString(3, mv_par17)
	oStatSC1:SetString(4, mv_par18)
	
	If __l290VLib
		oStatSC1:OpenAlias(cAliasSC1)
	Else
		cQrySC1 := oStatSC1:GetFixQuery()
		MPSysOpenQuery(cQrySC1, cAliasSC1 )
	EndIf 

	nSCPro := 0
	Do While !oReport:Cancel() .And. (cAliasSC1)->(!Eof())

		If MtrAvalOp(mv_par16,"SC1",cAliasSC1)
			nSCPro += ((cAliasSC1)->C1_QUANT - (cAliasSC1)->C1_QUJE)
		EndIf

		(cAliasSC1)->(dbSkip())

	EndDo
	(cAliasSC1)->(dbCloseArea())

RETURN nSCPro

/*/{Protheus.doc} GeraSC7Tmp
	Cria e alimenta uma tabela temporaria de itens de pedido de venda baseados nos parametros do pergunte do relatorio
	@type  Function
	@author reynaldo
	@since 25/06/2021
	@version 1.0
	@param xSC6, caracter, código da filial corrente da tabela pedido de vendas
	@param xSF4, caracter, código da filial corrente da tabela Tipo de Entrada Saida
	@param xSB1, caracter, código da filial corrente da tabela Produtos
	@return oTempSC6 , objeto, objeto criado pela classe FWTemporaryTable
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function GeraSC6Tmp(xSC6,xSF4,xSB1)
Local cAliTMPSC6
Local aFieldSC6
Local aTmpFields
Local nX
Local cSX3Campo
Local aStruField
Local oTempSC6
Local cSC6Table
Local cQuery
Local cQryFields
Local cQrySelect

	cAliTMPSC6 := CriaTrab(NIL,.F.)

	aFieldSC6 := {"C6_NUM","C6_ITEM","C6_PRODUTO","C6_QTDVEN"}

	aTmpFields := {}

	For nX := 1 to len(aFieldSC6)
		cSX3Campo := aFieldSC6[nX]
		aStruField := FWSX3Util():GetFieldStruct(cSX3Campo)
		aadd(aTmpFields,aStruField)
	Next nX

	//-------------------
	//Criaç?o do objeto
	//-------------------
	oTempSC6 := FWTemporaryTable():New( cAliTMPSC6 )
	//--------------------------
	//Monta os campos da tabela
	//--------------------------
	oTempSC6:SetFields( aTmpFields )

	//--------------------------
	//Monta os indices da tabela
	//--------------------------
	oTempSC6:AddIndex("01", {"C6_PRODUTO","C6_NUM","C6_ITEM"} )

	//------------------
	//Criaç?o da tabela
	//------------------
	oTempSC6:Create()

	cSC6Table := oTempSC6:GetRealName()

   cQuery := ""
   cQuery += "SELECT SC6.C6_NUM, SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_QTDVEN "
   cQuery += "FROM " +RetSqlName("SC6")+ " SC6 "

	cQuery += "INNER JOIN ( "
	cQuery += "SELECT SB1a.B1_COD  "
   cQuery += "FROM " +RetSqlName("SB1")+ " SB1a "
   cQuery += "WHERE SB1a.B1_FILIAL = '"+xSB1+ "' "
   cQuery += "AND SB1a.B1_COD   >= '" +mv_par01 + "' "
   cQuery += "AND SB1a.B1_COD   <='" + mv_par02 + "' "
   cQuery += "AND SB1a.B1_TIPO  >= '" +mv_par03+ "' "
   cQuery += "AND SB1a.B1_TIPO  <= '" +mv_par04+ "' "
   cQuery += "AND SB1a.B1_GRUPO >= '" +mv_par05+ "' "
   cQuery += "AND SB1a.B1_GRUPO <= '" +mv_par06+ "' "
   cQuery += "AND SB1a.B1_DESC  >= '" +mv_par07+ "' "
   cQuery += "AND SB1a.B1_DESC  <= '" +mv_par08+ "' "
   cQuery += "AND SB1a.D_E_L_E_T_ = ' ' ) SB1 "
	cQuery += "ON SB1.B1_COD = SC6.C6_PRODUTO "

   If mv_par14 == 1
      cQuery += "INNER JOIN " +RetSqlName("SF4")+ " SF4 "
      cQuery += "ON SF4.F4_FILIAL = '"+xSF4+ "' "
      cQuery += "AND SF4.F4_CODIGO = SC6.C6_TES "
      cQuery += "AND SF4.F4_ESTOQUE = 'S' "
      cQuery += "AND SF4.D_E_L_E_T_ = ' ' "

   EndIf

   cQuery += "WHERE SC6.C6_FILIAL = '" +xSC6+ "' "
   cQuery += "AND SC6.C6_LOCAL >= '" +mv_par17+ "' AND SC6.C6_LOCAL <= '" +mv_par18+ "' "

   If mv_par19 == 2
      cQuery += "AND SC6.C6_BLQ <> 'R' "
   EndIf
   cQuery += "AND SC6.D_E_L_E_T_ = ' ' "
	cQrySelect := ChangeQuery(cQuery)

	cQryFields := ""
	For nX := 1 to len(aTmpFields)
		cQryFields += aTmpFields[nX,1] + " ,"
	Next nX
	cQryFields := left(cQryFields, len(cQryFields)-1)

	cQuery := "INSERT INTO "
	cQuery += cSC6Table
	cQuery += " ( "
	cQuery += cQryFields
	cQuery +=" ) "
	cQuery += cQrySelect

	If TcSqlExec(cQuery) < 0
		UserException( TCSQLError() )
	EndIf

	FWFreeArray(aFieldSC6)
	FWFreeArray(aTmpFields)
	FWFreeArray(aStruField)

Return oTempSC6

/*/{Protheus.doc} AglutPV
	Totaliza a quantidade do produto de Pedidos de Vendas ainda nao entregues
	@type  Function
	@author reynaldo
	@since 25/06/2021
	@version 1.0
	@param oReport, objeto, Objeto da classe TReport utilizado
	@param oTmpSC6, objeto, Objeto da classe fwTemporaryTable com os pedidos de venda de acordo com a parametrização do relatorio.
	@param oStatSC9, objeto, Objeto da classe FWPreparedStatement com a seleção dos pedidos de venda liberados e de acordo com a parametrização do relatorio.
	@param cProduto, caracter, código do produto a ser pesquisado
	@param xSC9, caracter, código da filial corrente da tabela pedido liberados
	@param cLocalDe, caracter, código de inicio do range do local de estoque
	@param cLocalAte, caracter, código de final do range do local de estoque
	@return nPvPro , numerico, Quantidade de produto nos pedidos de vendas não entregue
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function AglutPV(oReport, oTmpSC6, oStatSC9, cProduto, cFilSC9, cLocalDe, cLocalAte)
Local cAliasSC6
Local cQrySC9
Local nC9_QTDLIB := 0
Local nPvPro := 0

	cAliasSC6 := oTmpSC6:GetAlias()

	(cAliasSC6)->(dbSeek(cProduto))
	Do While !oReport:Cancel() .And. (cAliasSC6)->(!Eof() .And. C6_PRODUTO == cProduto)

		nPVPro += (cAliasSC6)->C6_QTDVEN

		//
		// busca na SC9
		//
		oStatSC9:SetString(1, cFilSC9)
		oStatSC9:SetString(2, (cAliasSC6)->C6_NUM)
		oStatSC9:SetString(3, (cAliasSC6)->C6_ITEM)
		oStatSC9:SetString(4, cProduto)
		oStatSC9:SetString(5, cLocalDe)
		oStatSC9:SetString(6, cLocalAte)
		
		If __l290VLib
			nC9_QTDLIB := oStatSC9:ExecScalar("C9_QTDLIB")
		Else
			cQrySC9 := oStatSC9:GetFixQuery()
			nC9_QTDLIB := MpSysExecScalar(cQrySC9,"C9_QTDLIB")
		EndIf 

		

		nPvPro -= nC9_QTDLIB

		nPVPro := Max(0,nPVPro)

		(cAliasSC6)->(dbSkip())

	EndDo

Return nPVPro

/*/{Protheus.doc} GeraSC7Tmp
	Cria e alimenta uma tabela temporaria de itens de pedido de compra baseados nos parametros do pergunte do relatorio
	@type  Function
	@author reynaldo
	@since 25/06/2021
	@version 1.0
	@param xSC7, caracter, código da filial corrente da tabela pedido de compras
	@param xSF4, caracter, código da filial corrente da tabela Tipo de Entrada Saida
	@param xSB1, caracter, código da filial corrente da tabela Produtos
	@return oTempSC7 , objeto, objeto criado pela classe FWTemporaryTable
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function GeraSC7Tmp(xSC7,xSF4,xSB1)
Local cAliTMPSC7
Local aFieldSC7
Local aTmpFields
Local nX
Local cSX3Campo
Local aStruField
Local oTempSC7
Local cSC7Table
Local cQuery
Local cQryFields
Local cQrySelect

	cAliTMPSC7 := CriaTrab(NIL,.F.)

	aFieldSC7 := {"C7_PRODUTO", "C7_TPOP", "C7_QUANT", "C7_QUJE"}

	aTmpFields := {}

	For nX := 1 to len(aFieldSC7)
		cSX3Campo := aFieldSC7[nX]
		aStruField := FWSX3Util():GetFieldStruct(cSX3Campo)
		aadd(aTmpFields,aStruField)
	Next nX

	//-------------------
	//Criaç?o do objeto
	//-------------------
	oTempSC7 := FWTemporaryTable():New( cAliTMPSC7 )
	//--------------------------
	//Monta os campos da tabela
	//--------------------------
	oTempSC7:SetFields( aTmpFields )

	//--------------------------
	//Monta os indices da tabela
	//--------------------------
	oTempSC7:AddIndex("01", {"C7_PRODUTO","C7_TPOP"} )

	//------------------
	//Criaç?o da tabela
	//------------------
	oTempSC7:Create()

	cSC7Table := oTempSC7:GetRealName()

	cQuery := ""
	cQuery += "SELECT SC7.C7_PRODUTO, SC7.C7_TPOP, SC7.C7_QUANT, SC7.C7_QUJE "
	cQuery += "FROM " +RetSQLName("SC7")+ " SC7 "

	cQuery += "INNER JOIN ( "
	cQuery += "SELECT SB1a.B1_COD  "
   cQuery += "FROM " +RetSqlName("SB1")+ " SB1a "
   cQuery += "WHERE SB1a.B1_FILIAL = '"+xSB1+ "' "
   cQuery += "AND SB1a.B1_COD   >= '" +mv_par01 + "' "
   cQuery += "AND SB1a.B1_COD   <='" + mv_par02 + "' "
   cQuery += "AND SB1a.B1_TIPO  >= '" +mv_par03+ "' "
   cQuery += "AND SB1a.B1_TIPO  <= '" +mv_par04+ "' "
   cQuery += "AND SB1a.B1_GRUPO >= '" +mv_par05+ "' "
   cQuery += "AND SB1a.B1_GRUPO <= '" +mv_par06+ "' "
   cQuery += "AND SB1a.B1_DESC  >= '" +mv_par07+ "' "
   cQuery += "AND SB1a.B1_DESC  <= '" +mv_par08+ "' "
   cQuery += "AND SB1a.D_E_L_E_T_ = ' ' ) SB1 "
	cQuery += "ON SB1.B1_COD = SC7.C7_PRODUTO "

	cQuery += "WHERE SC7.C7_FILIAL = '" +xSC7+ "' "
	cQuery += "AND SC7.C7_LOCAL >= '" +mv_par17+ "' AND SC7.C7_LOCAL <= '" +mv_par18+ "' "
	cQuery += "AND SC7.C7_RESIDUO = '" +space(len(SC7->C7_RESIDUO))+"' "
	cQuery += "AND (SC7.C7_QUANT-SC7.C7_QUJE) > 0 "
	cQuery += "AND SC7.D_E_L_E_T_ = ' ' "

	cQrySelect := ChangeQuery(cQuery)

	cQryFields := ""
	For nX := 1 to len(aTmpFields)
		cQryFields += aTmpFields[nX,1] + " ,"
	Next nX
	cQryFields := left(cQryFields, len(cQryFields)-1)

	cQuery := "INSERT INTO "
	cQuery += cSC7Table
	cQuery += " ( "
	cQuery += cQryFields
	cQuery +=" ) "
	cQuery += cQrySelect

	If TcSqlExec(cQuery) < 0
		UserException( TCSQLError() )
	EndIf

	FWFreeArray(aFieldSC7)
	FWFreeArray(aTmpFields)
	FWFreeArray(aStruField)

Return oTempSC7

/*/{Protheus.doc} AglutPC
	Totaliza a quantidade do produto nas Ordens de produção
	@type  Function
	@author reynaldo
	@since 25/06/2021
	@version 1.0
	@param oReport, objeto, Objeto da classe TReport utilizado
	@param oTmpSC7, objeto, Objeto da classe fwTemporaryTable com os pedidos de compra de acordo com a parametrização do relatorio.
	@param cProduto, caracter, código do produto a ser pesquisado
	@param cTipoOP, caracter, Se é OP Firmes, previstas ou os dois
	@return nPCPro , numerico, Quantidade de produto nos pedidos de compras
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function AglutPC(oReport, oTmpSC7, cProduto, cTipoOP)
Local cAliasSC7
Local nPCPro := 0

	dbSelectArea("SC7")

	cAliasSC7 := oTmpSC7:GetAlias()
	(cAliasSC7)->(dbSeek(cProduto))
	Do While !oReport:Cancel() .And. (cAliasSC7)->(!Eof() .And. C7_PRODUTO == cProduto)

		If MtrAvalOp(cTipoOP, "SC7", cAliasSC7)
			nPCPro += ((cAliasSC7)->C7_QUANT-(cAliasSC7)->C7_QUJE)
		EndIf
		(cAliasSC7)->(dbSkip())

	EndDo

Return nPCPro
