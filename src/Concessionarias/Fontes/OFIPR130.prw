/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Ofipr130.ch"
#include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIPR130 ³ Autor ³ Thiago                ³ Data ³ 01/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Demonstrativo de Itens Bloqueados/Reservados               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIPR130
U_OFPR130R3() // Executa versão anterior do fonte
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFPR130R3³ Autor ³  Thiago        ³ Data ³ 21/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Demonstrativo de Metas de Vendas                    |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFPR130R3()
Private aReturn := { STR0001, 1, STR0002, 2, 2, 1, "", 1 } //"Zebrado"###"Administracao"{"Zebrado", 1,"Administracao", 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private cTitulo := STR0051 // Itens Bloqueados/Reservados/Requisitados
Private cPerg   := "OPR1302"

// AADD(aRegs, {STR0043, STR0043, STR0043, "MV_CH1", "N", 01, 0, 0, "C", "", "MV_PAR01", STR0045, STR0045, STR0045, "", "", STR0046, STR0046, STR0046, "", "",; // Tipo de Relatorio ? / Item Bloqueado / Item Reservado
// 	STR0061, STR0061, STR0061, "", "", STR0064, STR0064, STR0064, "", "", "", "", "", "", "", "", "", "",; // Item Requisitado // Todos
// 	{ "Permite selecionar o tipo de",;
// 		"relatório desejado."},;
// 	{}, {}})
// 
// AADD(aRegs, {STR0044, STR0044, STR0044, "MV_CH2", "N", 01, 0, 0, "C", "", "MV_PAR02", STR0037, STR0037, STR0037, "", "", STR0038, STR0038, STR0038, "", "",; // Valor Considerar ? / Valor Custo / Valor Venda
// 	"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",;
// 	{ "Permite selecionar o valor a ser",;
// 		"considerado no relatório."},;
// 	{}, {}})
// 
// AADD(aRegs, {STR0068, STR0068, STR0068, "MV_CH3", "N", 01, 0, 0, "C", "", "MV_PAR03", STR0070, STR0070, STR0070, "", "", STR0071, STR0071, STR0071, "", "",; // Agrupar por ? / Orc. / OS / Vend. / Consu.
// 	STR0052, STR0052, STR0052, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",; // Peça
// 	{ "Permite selecionar o agrupamento a ser",;
// 		"considerado no relatório."},;
// 	{}, {}})

// Mesmo passando a pergunte para o TReport
// preciso carregar para as MV_PAR existirem
PERGUNTE(cPerg, .f.)

OPR1300016_ChamadaImpressao()
Return

/*/{Protheus.doc} OPR1300016_ChamadaImpressao
Chamada para impressão dos Demonstrativos
@author Fernando Vitor Cavani
@since 22/08/2018
@version undefined
@type function
/*/
Static Function OPR1300016_ChamadaImpressao()
Local oReport

oReport := ReportDef() // Nesta função nós definimos a estrutura do relatório, por exemplo as seções, campos, totalizadores e etc.
oReport:SetPortrait()  // Define orientação de página do relatório como retrato.
oReport:PrintDialog()  // Essa função serve para disparar a impressão do TReport, ela que faz com que seja exibida a tela de configuração de impressora e os botões de parâmetros.
Return

/*/{Protheus.doc} ReportDef
Criando o padrão para impressão dos Demonstrativos
@author Fernando Vitor Cavani
@since 22/08/2018
@version undefined
@return oReport, objeto, Impressao
@type function
/*/
Static Function ReportDef()
Local cDesc := ""
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4
Local oSection5
Local oSection6
Local oSection7
Local oSection8

cTitGru := ""
cPeca   := cPDes := cNumOS := ""
cNomVen := cNQtd := cNVlr  := ""
cTTit   := cTQtd := cTVlr  := ""
dData   := CtoD("")

// Descrição
cDesc := STR0062 // Este programa tem como objetivo imprimir os demonstrativos de itens bloqueados, reservados ou requisitados

// TReport
oReport := TReport():New(                             ;
	"OPR130",                                         ;
	cTitulo,                                          ;
	cPerg,                                            ;
	{|oReport| OPR1300026_GerenciaImpressao(oReport)},;
	cDesc)

// Título / Grupo
oSection1 := TRSection():New(oReport, "oTitulo")

oReport:Section(1):SetLineStyle() // Define se imprime as células da seção em linhas
oSection1:SetLinesBefore(1)       // Define a quantidade de linhas que serão saltadas antes da impressão da seção

TRCell():New(oSection1, "oTitGru",, "", "@!", 100,, {|| cTitGru },,,,,,,,, .t.) // Título / Grupo

///////
// Peça
///////
oSection2 := TRSection():New(oReport, "oPeca")

oSection2:SetLinesBefore(1) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

TRCell():New(oSection2, "oPeca",, STR0052, "@!", 100,, {|| cPeca },,,,,,,,,) // Peça
TRCell():New(oSection2, "oPDes",, STR0023, "@!", 100,, {|| cPDes },,,,,,,,,) // Descrição

// Dados
oSection3 := TRSection():New(oReport, "oDadosP")

oSection3:SetLeftMargin(2)  // Define o tamanho da margem a esquerda
oSection3:SetLinesBefore(0) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

TRCell():New(oSection3, "oNumOS" ,, STR0053, "@!"               , 100,, {|| cNumOS },,,        ,,,,,,) // Num. Orc. / Num. OS
TRCell():New(oSection3, "oNomVen",, STR0065, "@!"               , 100,, {|| cNomVen },,,       ,,,,,,) // Vendedor / Consultor
TRCell():New(oSection3, "oData"  ,, STR0031, "@D"               ,  25,, {|| dData },,,         ,,,,,,) // Data
TRCell():New(oSection3, "oNQtd"  ,, STR0054, "@!"               ,  10,, {|| cNQtd },,,  "RIGHT",,,,,,) // Quantidade
TRCell():New(oSection3, "oNVlr"  ,, STR0034, "@E 999,999,999.99",  20,, {|| cNVlr },,,  "RIGHT",,,,,,) // Valor
///////
// Peça
///////

/////////
// Orc/OS
/////////
oSection4 := TRSection():New(oReport, "oOrcOS")

oSection4:SetLinesBefore(1) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

TRCell():New(oSection4, "oNumOS",, STR0053, "@!", 100,, {|| cNumOS },,,,,,,,,) // Num. Orc. / Num. OS
TRCell():New(oSection4, "oONada",, ""     , "@!", 100,, {|| "" },,,,,,,,,)

// Dados
oSection5 := TRSection():New(oReport, "oDadosO")

oSection5:SetLeftMargin(2)  // Define o tamanho da margem a esquerda
oSection5:SetLinesBefore(0) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

TRCell():New(oSection5, "oPeca"  ,, STR0052, "@!"               , 100,, {|| cPeca },,,         ,,,,,,) // Peça
TRCell():New(oSection5, "oNomVen",, STR0065, "@!"               , 100,, {|| cNomVen },,,       ,,,,,,) // Vendedor / Consultor
TRCell():New(oSection5, "oData"  ,, STR0031, "@D"               ,  25,, {|| dData },,,         ,,,,,,) // Data
TRCell():New(oSection5, "oNQtd"  ,, STR0054, "@!"               ,  10,, {|| cNQtd },,,  "RIGHT",,,,,,) // Quantidade
TRCell():New(oSection5, "oNVlr"  ,, STR0034, "@E 999,999,999.99",  20,, {|| cNVlr },,,  "RIGHT",,,,,,) // Valor
/////////
// Orc/OS
/////////

///////////////////////
// Vendedor / Consultor
///////////////////////
oSection6 := TRSection():New(oReport, "oVend")

oSection6:SetLinesBefore(1) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

TRCell():New(oSection6, "oNomVen",, STR0065, "@!", 100,, {|| cNomVen },,,,,,,,,) // Vendedor / Consultor
TRCell():New(oSection6, "oONada" ,, ""     , "@!", 100,, {|| "" },,,,,,,,,)

// Dados
oSection7 := TRSection():New(oReport, "oDadosV")

oSection7:SetLeftMargin(2)  // Define o tamanho da margem a esquerda
oSection7:SetLinesBefore(0) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

TRCell():New(oSection7, "oNumOS",, STR0053, "@!"               , 100,, {|| cNumOS },,,       ,,,,,,) // Num. Orc. / Num. OS
TRCell():New(oSection7, "oPeca" ,, STR0052, "@!"               , 100,, {|| cPeca },,,        ,,,,,,) // Peça
TRCell():New(oSection7, "oData" ,, STR0031, "@D"               ,  25,, {|| dData },,,        ,,,,,,) // Data
TRCell():New(oSection7, "oNQtd" ,, STR0054, "@!"               ,  10,, {|| cNQtd },,, "RIGHT",,,,,,) // Quantidade
TRCell():New(oSection7, "oNVlr" ,, STR0034, "@E 999,999,999.99",  20,, {|| cNVlr },,, "RIGHT",,,,,,) // Valor
///////////////////////
// Vendedor / Consultor
///////////////////////

// Totais
oSection8 := TRSection():New(oReport, "oTotais")

oSection8:SetLeftMargin(2)  // Define o tamanho da margem a esquerda
oSection8:SetLinesBefore(0) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

TRCell():New(oSection8, "oTTit" ,, "", "@!"               , 100,, {|| cTTit },,,        ,,,,,, .t.) // Sub Total / Total Geral
TRCell():New(oSection8, "oTNada",, "", "@!"               , 100,, {|| },,,              ,,,,,, .t.)
TRCell():New(oSection8, "oTQtd" ,, "", "@!"               ,  10,, {|| cTQtd },,, "RIGHT",,,,,, .t.) // Quantidade
TRCell():New(oSection8, "oTVlr" ,, "", "@E 999,999,999.99",  20,, {|| cTVlr },,, "RIGHT",,,,,, .t.) // Valor
Return(oReport)

/*/{Protheus.doc} OPR1300026_GerenciaImpressao
Gerenciando a montagem da impressão dos Demonstrativos
@author Fernando Vitor Cavani
@since 24/01/2019
@version undefined
@param oReport, objeto, Impressao
@type function
/*/
Static Function OPR1300026_GerenciaImpressao(oReport)
Private cBlqIte   := Padr(GETMV("MV_BLQITE"), TamSx3("B2_LOCAL")[1])
Private cResite   := Padr(GETMV("MV_RESITE"), TamSx3("B2_LOCAL")[1])
Private cReqs     := ""
Private aDadosImp := {}

If MV_PAR01 == 3 .Or. MV_PAR01 == 4
	// Requisitados / Todos
	OPR1300036_MontarStringRequisitados()
	OPR1300046_MontarArrayRequisitados()
EndIf

If MV_PAR01 <> 3
	// Bloqueados / Reservados / Todos
	OPR1300056_MontarArrayBloqueadosReservados()
EndIf

If !Empty(aDadosImp)
	// Ordernar o array
	If MV_PAR01 == 4
		// Todos
		If MV_PAR03 == 1
			// Orçamento/OS (VE6.VE6_NUMOSV/VE6.VE6_NUMORC, SB2.B2_LOCAL, VE6.VE6_ORIREQ)
			aSort(aDadosImp,,, {|x,y| x[7] + x[1] + x[8] < y[7] + y[1] + y[8]})
		ElseIf MV_PAR03 == 3
			// Peças (SB1.B1_GRUPO, SB1.B1_CODITE, SB2.B2_LOCAL, VE6.VE6_ORIREQ)
			aSort(aDadosImp,,, {|x,y| x[2] + x[3] + x[1] + x[8] < y[2] + y[3] + y[1] + y[8]})
		Else
			// Vendedor / Consultor (SA3.A3_NOME, SB2.B2_LOCAL, VE6.VE6_NUMOSV/VE6.VE6_NUMORC, VE6.VE6_ORIREQ)
			aSort(aDadosImp,,, {|x,y| x[11] + x[7] + x[1] + x[8] < y[11] + y[7] + y[1] + y[8]})
		EndIf
	EndIf

	// Imprimir o array
	If MV_PAR03 == 1
		// Orçamento/OS
		OPR1300076_ImprimirArrayOSOrc(oReport)
	ElseIf MV_PAR03 == 3
		// Peças
		OPR1300066_ImprimirArrayPecas(oReport)
	Else
		// Vendedor / Consultor
		OPR1300086_ImprimirArrayVendedor(oReport)
	EndIf
EndIf
Return

/*/{Protheus.doc} OPR1300036_MontarStringRequisitados
Montando a string dos armazéns (Requisitados)
@author Fernando Vitor Cavani
@since 24/01/2019
@version undefined
@type function
/*/
Static Function OPR1300036_MontarStringRequisitados()
Local cQAlVOI := "SQLVOI" // sql filtrar VOI
Local cQuery  := ""

// Requisitados (montar string Armazéns)
cQuery := "SELECT DISTINCT(VOI.VOI_CODALM) "
cQuery += "FROM " + RetSqlName( "VOI" ) + " VOI "
cQuery += "WHERE VOI.VOI_FILIAL = '" + xFilial("VOI") + "' "
cQuery += "  AND (VOI.VOI_CODALM <> ' ' AND VOI.VOI_CODALM NOT IN('" + cBlqIte +"','" + cResite +"')) "
cQuery += "  AND VOI.D_E_L_E_T_ = ' ' "
dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlVOI, .T., .T.)

While !(cQAlVOI)->(Eof())
	cReqs += Iif(Empty(cReqs), "", ",") + "'" + (cQAlVOI)->(VOI_CODALM) + "'"

	(cQAlVOI)->(DbSkip())
EndDo

(cQAlVOI)->(dbCloseArea())

dbSelectArea("VOI")
Return

/*/{Protheus.doc} OPR1300046_MontarArrayRequisitados
Montando o array de impressão (Requisitados)
@author Fernando Vitor Cavani
@since 23/01/2019
@version undefined
@type function
/*/
Static Function OPR1300046_MontarArrayRequisitados()
Local cQAlVO3 := "SQLVO3" // sql filtrar VO3
Local cQuery  := ""
Local nQtdIte := 0
Local cValIte := ""

// Requisitados / Todos
cQuery := "SELECT SB2.B2_QATU, SB2.B2_LOCAL, SB2.B2_CM1, B1_GRUPO, B1_CODITE, B1_DESC, BM_DESC, VO1.VO1_DATABE, VO3.VO3_NUMOSV, "
cQuery += "  VO3.VO3_VALPEC, SUM(CASE VO2.VO2_DEVOLU WHEN '0' THEN (VO3_QTDREQ * -1) ELSE VO3_QTDREQ END) VO3_QTDREQ, SA3.A3_NOME "
cQuery += "FROM " + RetSqlName("SB2") + " SB2 "
cQuery += "JOIN " + RetSqlName("SB1") + " SB1 ON SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND SB2.B2_COD = SB1.B1_COD AND SB1.D_E_L_E_T_ = ' ' "
cQuery += "JOIN " + RetSqlName("SBM") + " SBM ON SBM.BM_FILIAL = '" + xFilial("SBM") + "' AND SBM.BM_GRUPO = SB1.B1_GRUPO AND SBM.D_E_L_E_T_ = ' ' "
cQuery += "JOIN " + RetSqlName("VO3") + " VO3 ON VO3.VO3_FILIAL = '" + xFilial("VO3") + "' AND VO3.VO3_GRUITE = SB1.B1_GRUPO "
cQuery += "  AND VO3.VO3_CODITE = SB1.B1_CODITE AND VO3.D_E_L_E_T_ = ' ' "
cQuery += "JOIN " + RetSqlName("VO2") + " VO2 ON VO2.VO2_FILIAL = '" + xFilial("VO2") + "' AND VO2.VO2_NOSNUM = VO3.VO3_NOSNUM "
cQuery += "  AND VO2.VO2_TIPREQ = 'P' AND VO2.D_E_L_E_T_ = ' ' "
cQuery += "JOIN " + RetSqlName("VOI") + " VOI ON VOI.VOI_FILIAL = '" + xFilial("VOI") + "' AND VOI.VOI_TIPTEM = VO3.VO3_TIPTEM "
cQuery += "  AND VOI.VOI_CODALM = SB2.B2_LOCAL AND VOI.D_E_L_E_T_ = ' ' "
cQuery += "JOIN " + RetSqlName("SF4") + " SF4 ON SF4.F4_FILIAL = '" + xFilial("SF4") + "' AND SF4.F4_CODIGO = VO3.VO3_CODTES AND SF4.D_E_L_E_T_ = ' ' "
cQuery += "LEFT JOIN " + RetSqlName("VO1") + " VO1 ON VO1.VO1_FILIAL = '" + xFilial("VO1") + "' AND VO1.VO1_NUMOSV = VO3.VO3_NUMOSV AND VO1.D_E_L_E_T_ = ' ' "
cQuery += "LEFT JOIN " + RetSqlName("SA3") + " SA3 ON SA3.A3_FILIAL = '" + xFilial("SA3") + "' AND SA3.A3_COD = VO1.VO1_FUNABE AND SA3.D_E_L_E_T_ = ' ' "
cQuery += "WHERE VO3.VO3_QTDREQ <> 0 AND VO3.VO3_NUMNFI = '          ' AND VO3.VO3_DATCAN = '        ' AND VO3.VO3_DATFEC = '        ' "
cQuery += "  AND SF4.F4_ESTOQUE = 'S' AND SB2.B2_FILIAL = '" + xFilial("SB2") + "' "
cQuery += "  AND SB2.B2_LOCAL IN(" + Iif(Empty(cReqs), "'0'", cReqs) + ") AND SB2.B2_QATU > 0 AND SB2.D_E_L_E_T_ = ' ' "
cQuery += "GROUP BY SB2.B2_QATU, SB2.B2_LOCAL, SB2.B2_CM1, B1_GRUPO, B1_CODITE, B1_DESC, BM_DESC, VO1.VO1_DATABE, VO3.VO3_NUMOSV, VO3.VO3_VALPEC, SA3.A3_NOME "

If MV_PAR03 == 1
	// Orçamento/OS
	cQuery += "ORDER BY VO3.VO3_NUMOSV, SB2.B2_LOCAL "
ElseIf MV_PAR03 == 3
	// Peças
	cQuery += "ORDER BY SB1.B1_GRUPO, SB1.B1_CODITE, SB2.B2_LOCAL "
Else
	// Vendedor / Consultor
	cQuery += "ORDER BY SA3.A3_NOME, VO3.VO3_NUMOSV, SB2.B2_LOCAL "
EndIf
dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlVO3, .T., .T.)

While !(cQAlVO3)->(Eof())
	If (cQAlVO3)->(B2_QATU) > 0
		// Reserva do item
		nQtdIte := (cQAlVO3)->(VO3_QTDREQ)

		If (MV_PAR02 == 2)
			// Valor Venda
			cValIte := nQtdIte * (cQAlVO3)->(VO3_VALPEC)
		Else
			// valor CM1
			cValIte := nQtdIte * (cQAlVO3)->(B2_CM1)
		EndIf

		// Montar Array para Impressão
		aAdd(aDadosImp, {           ;
			(cQAlVO3)->(B2_LOCAL),  ;
			(cQAlVO3)->(B1_GRUPO),  ;
			(cQAlVO3)->(B1_CODITE), ;
			(cQAlVO3)->(B1_DESC),   ;
			(cQAlVO3)->(BM_DESC),   ;
			(cQAlVO3)->(VO1_DATABE),;
			(cQAlVO3)->(VO3_NUMOSV),;
			"",                     ;
			nQtdIte,                ;
			cValIte,                ;
			""                      ;
		})
	EndIf

	(cQAlVO3)->(DbSkip())
EndDo

(cQAlVO3)->(dbCloseArea())

DbSelectArea("VO3")
Return

/*/{Protheus.doc} OPR1300056_MontarArrayBloqueadosReservados
Montando o array de impressão (Bloqueados/Reservados)
@author Fernando Vitor Cavani
@since 23/01/2019
@version undefined
@type function
/*/
Static Function OPR1300056_MontarArrayBloqueadosReservados()
Local cQAlVE6 := "SQLVE6" // sql filtrar VE6
Local cQuery  := ""
Local cNumero := ""
Local nQtdIte := 0
Local cValIte := ""

// Bloqueados / Reservados / Todos
cQuery := "SELECT SB2.B2_QATU, SB2.B2_LOCAL, SB2.B2_CM1, B1_GRUPO, B1_CODITE, B1_DESC, BM_DESC, VE6.VE6_DATREG, "
cQuery += "  VE6.VE6_NUMOSV, VE6.VE6_NUMORC, VE6.VE6_QTDITE, VE6.VE6_QTDBLQ, VE6.VE6_QTDATE, VE6.VE6_VALPEC, "
cQuery += "  VE6.VE6_QTDEST, VE6.VE6_ORIREQ, VE6.VE6_INDREG, SA3.A3_NOME "
cQuery += "FROM " + RetSqlName("SB2") + " SB2 "
cQuery += "JOIN " + RetSqlName("SB1") + " SB1 ON SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND SB2.B2_COD = SB1.B1_COD AND SB1.D_E_L_E_T_ = ' ' "
cQuery += "JOIN " + RetSqlName("SBM") + " SBM ON SBM.BM_FILIAL = '" + xFilial("SBM") + "' AND SBM.BM_GRUPO = SB1.B1_GRUPO AND SBM.D_E_L_E_T_ = ' ' "
cQuery += "JOIN " + RetSQLName("VE6") + " VE6 ON VE6.VE6_FILIAL = '" + xFilial("VE6") + "' AND VE6.VE6_GRUITE = SB1.B1_GRUPO "
cQuery += "  AND VE6.VE6_CODITE = SB1.B1_CODITE AND VE6.D_E_L_E_T_ = ' ' "
cQuery += "LEFT JOIN " + RetSQLName("VO1") + " VO1 ON VO1.VO1_FILIAL = '" + xFilial("VO1") + "' AND VO1.VO1_NUMOSV = VE6.VE6_NUMOSV AND VO1.D_E_L_E_T_ = ' ' "
cQuery += "LEFT JOIN " + RetSQLName("VS1") + " VS1 ON VS1.VS1_FILIAL = '" + xFilial("VS1") + "' AND VS1.VS1_NUMORC = VE6.VE6_NUMORC AND VS1.D_E_L_E_T_ = ' ' "
cQuery += "LEFT JOIN " + RetSQLName("SA3") + " SA3 ON SA3.A3_FILIAL = '" + xFilial("SA3") + "' "
cQuery += " AND SA3.A3_COD = CASE VE6.VE6_ORIREQ WHEN '1' THEN VS1.VS1_CODVEN ElSE VO1.VO1_FUNABE END AND SA3.D_E_L_E_T_ = ' ' "

If MV_PAR01 == 1
	// Bloqueados
	cQuery += "WHERE VE6.VE6_INDREG = '2' AND VE6.VE6_QTDBLQ > 0 " // 2-Bloqueio do item
	cQuery += "  AND SB2.B2_LOCAL = '" + cBlqIte + "' "
ElseIf MV_PAR01 == 2
	// Reservados
	cQuery += "WHERE VE6.VE6_INDREG = '3' AND VE6.VE6_DATATE = '" + Space(8) + "' " // 3-Reserva do item
	cQuery += "  AND SB2.B2_LOCAL = '" + cResite + "' "
Else
	// Todos
	cQuery += "WHERE SB2.B2_LOCAL IN('" + cBlqIte + "','" + cResite + "') "
EndIf

cQuery += "  AND VE6.VE6_ORIREQ IN ('1','2') " // 1-Balcao / 2-Oficina
cQuery += "  AND SB2.B2_FILIAL = '" + xFilial("SB2") + "' AND SB2.B2_QATU > 0 AND SB2.D_E_L_E_T_ = ' ' "
cQuery += "GROUP BY SB2.B2_QATU, SB2.B2_LOCAL, SB2.B2_CM1, B1_GRUPO, B1_CODITE, B1_DESC, BM_DESC, VE6.VE6_DATREG, "
cQuery += "  VE6.VE6_NUMOSV, VE6.VE6_NUMORC, VE6.VE6_QTDITE, VE6.VE6_QTDBLQ, VE6.VE6_QTDATE, VE6.VE6_VALPEC, "
cQuery += "  VE6.VE6_QTDEST, VE6.VE6_ORIREQ, VE6.VE6_CODIGO, VE6.VE6_INDREG, SA3.A3_NOME "

If MV_PAR03 == 1
	// Orçamento/OS
	cQuery += "ORDER BY VE6.VE6_NUMOSV, VE6.VE6_NUMORC, SB2.B2_LOCAL, VE6.VE6_ORIREQ "
ElseIf MV_PAR03 == 3
	// Peças
	cQuery += "ORDER BY SB1.B1_GRUPO, SB1.B1_CODITE, SB2.B2_LOCAL, VE6.VE6_ORIREQ "
Else
	// Vendedor / Consultor
	cQuery += "ORDER BY SA3.A3_NOME, VE6.VE6_NUMOSV, VE6.VE6_NUMORC, SB2.B2_LOCAL, VE6.VE6_ORIREQ "
EndIf
dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlVE6, .T., .T.)

While !(cQAlVE6)->(Eof())
	If (cQAlVE6)->(B2_QATU) > 0
		If (cQAlVE6)->(VE6_ORIREQ) == "2" .and. MV_PAR01 == 1
			// Bloqueio do item / Bloqueados
			If (cQAlVE6)->(VE6_QTDATE) + (cQAlVE6)->(VE6_QTDEST) > (cQAlVE6)->(VE6_QTDBLQ)
				(cQAlVE6)->(DbSkip())
				Loop
			EndIf
		EndIf

		If (cQAlVE6)->(VE6_INDREG) == "2"
			// Bloqueio do item
			nQtdIte := (cQAlVE6)->(VE6_QTDBLQ)

			If (MV_PAR02 == 2)
				// Valor Venda
				cValIte := (cQAlVE6)->(VE6_QTDBLQ) * (cQAlVE6)->(VE6_VALPEC)
			Else
				// valor CM1
				cValIte := (cQAlVE6)->(VE6_QTDBLQ) * (cQAlVE6)->(B2_CM1)
			EndIf
		ElseIf (cQAlVE6)->(VE6_INDREG) == "3"
			// Reserva do item
			nQtdIte := (cQAlVE6)->(VE6_QTDITE) - (cQAlVE6)->(VE6_QTDATE) - (cQAlVE6)->(VE6_QTDEST)

			If (MV_PAR02 == 2)
				// Valor Venda
				cValIte := nQtdIte * (cQAlVE6)->(VE6_VALPEC)
			Else
				// valor CM1
				cValIte := nQtdIte * (cQAlVE6)->(B2_CM1)
			EndIf
		EndIf

		If nQtdIte <= 0
			(cQAlVE6)->(DbSkip())
			Loop
		EndIf

		// Orçamento/OS
		cNumero := Iif((cQAlVE6)->(VE6_ORIREQ) == "1", (cQAlVE6)->(VE6_NUMORC), (cQAlVE6)->(VE6_NUMOSV))

		// Montar Array para Impressão
		aAdd(aDadosImp, {           ;
			(cQAlVE6)->(B2_LOCAL),  ;
			(cQAlVE6)->(B1_GRUPO),  ;
			(cQAlVE6)->(B1_CODITE), ;
			(cQAlVE6)->(B1_DESC),   ;
			(cQAlVE6)->(BM_DESC),   ;
			(cQAlVE6)->(VE6_DATREG),;
			cNumero,                ;
			(cQAlVE6)->(VE6_ORIREQ),;
			nQtdIte,                ;
			cValIte,                ;
			(cQAlVE6)->(A3_NOME)    ;
		})
	EndIf

	(cQAlVE6)->(DbSkip())
EndDo

(cQAlVE6)->(dbCloseArea())

DbSelectArea("VE6")
Return

/*/{Protheus.doc} OPR1300066_ImprimirArrayPecas
Imprimindo o array de Demonstrativos por Peças
@author Fernando Vitor Cavani
@since 24/01/2019
@version undefined
@param oReport, objeto, Impressao
@type function
/*/
Static Function OPR1300066_ImprimirArrayPecas(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local oSection8 := oReport:Section(8)

Local lImpOK  := .f.
Local nCont   := 0
Local nQtdTip := nQtdPec := nQtdGru := nQtdGrl := 0
Local nSubTip := nSubPec := nSubGru := nTolGrl := 0
Local cGruIte := cCodIte := cLocal  := ""

// Título
If MV_PAR01 == 1
	// Bloqueados
	cTitGru := STR0003 // Demonstrativo de Itens Bloqueados
ElseIf MV_PAR01 == 2
	// Reservados
	cTitGru := STR0004 // Demonstrativo de Itens Reservados
ElseIf MV_PAR01 == 3
	// Requisitados
	cTitGru := STR0059 // Demonstrativo de Itens Requisitados
Else
	// Todos
	cTitGru := STR0063 // Demonstrativo de Itens (Todos)
EndIf

cLocal  := " "
cCodIte := " "
cGruIte := " "

// Título / Grupo
oSection1:Init()

cTitGru += " - " + Iif(MV_PAR02 == 1, STR0037, STR0038) // Valor Custo / Valor Venda

oSection1:PrintLine()
oSection1:Finish()

If !Empty(aDadosImp)
	For nCont := 1 To Len(aDadosImp)
		If aDadosImp[nCont,9] > 0
			lImpOK := .t.

			// Tipo
			If (aDadosImp[nCont,1] <> cLocal .And. aDadosImp[nCont,8] <> cLocal) .Or. aDadosImp[nCont,3] <> cCodIte
				If cLocal # " "
					// Dados
					oSection3:Finish()

					// Totais
					oSection8:Init()

					If cLocal == "1"
						cTTit := STR0057 + " " + STR0040 // Sub Total / Orçamento - Balcão
					ElseIf cLocal == "2"
						cTTit := STR0057 + " " + STR0041 // Sub Total / Ordem de Serviço - Oficina
					Else
						cTTit := STR0057 + " " + STR0060 + " " + cLocal // Sub Total / Armazém
					EndIf

					cTQtd := nQtdTip
					cTVlr := nSubTip

					oSection8:PrintLine()
					oSection8:Finish()

					oReport:SkipLine(1)

					// Total por Peça
					nQtdPec += nQtdTip
					nSubPec += nSubTip

					nQtdTip := 0
					nSubTip := 0
				EndIf
			EndIf

			// Peça
			If aDadosImp[nCont,3] <> cCodIte
				If cCodIte # " "
					// Totais
					oSection8:Init()

					cTTit := STR0055 + " " + cCodIte // Total Peça
					cTQtd := nQtdPec
					cTVlr := nSubPec

					oSection8:PrintLine()
					oSection8:Finish()

					oReport:SkipLine(1)

					// Total por Grupo
					nQtdGru += nQtdPec
					nSubGru += nSubPec

					nQtdPec := 0
					nSubPec := 0
				EndIf
			EndIf

			// Grupo
			If aDadosImp[nCont,2] <> cGruIte
				If cGruIte # " "
					// Totais
					oSection8:Init()

					cTTit := STR0056 + " " + cGruIte // Total Grupo
					cTQtd := nQtdGru
					cTVlr := nSubGru

					oSection8:PrintLine()
					oSection8:Finish()

					oReport:SkipLine(1)

					// Total Geral
					nQtdGrl += nQtdGru
					nTolGrl += nSubGru

					nQtdGru := 0
					nSubGru := 0
				EndIf

				// Título / Grupo
				oReport:SkipLine(1)

				oSection1:Init()

				cTitGru := aDadosImp[nCont,2] + " " + aDadosImp[nCont,5]

				oSection1:PrintLine()
				oSection1:Finish()
			EndIf

			// Iniciando a Impressão
			cCodIte := aDadosImp[nCont,3]
			cGruIte := aDadosImp[nCont,2]

			If nQtdTip == 0
				// Peça
				oSection2:Init()

				cPeca := cGruIte + " " + substr(cCodIte, 1, 23)
				cPDes := substr(aDadosImp[nCont,4], 1, 20)

				oSection2:PrintLine()
				oSection2:Finish()

				// Tipo
				// Título / Grupo
				oSection1:Init()

				If aDadosImp[nCont,8] == "1"
					cLocal  := "1"
					cTitGru := STR0040 // Orçamento - Balcão
				ElseIf aDadosImp[nCont,8] == "2"
					cLocal  := "2"
					cTitGru := STR0041 // Ordem de Serviço - Oficina
				Else
					cLocal  := aDadosImp[nCont,1]
					cTitGru := STR0060 + " " + cLocal // Armazém
				EndIf

				oSection1:PrintLine()
				oSection1:Finish()

				// Dados
				oSection3:Init()
			EndIf

			cNumOS  := aDadosImp[nCont,7]
			cNomVen := aDadosImp[nCont,11]
			dData   := StoD(aDadosImp[nCont,6])
			cNQtd   := aDadosImp[nCont,9]
			cNVlr   := aDadosImp[nCont,10]

			oSection3:PrintLine()

			// Total por Tipo
			nQtdTip += aDadosImp[nCont,9]
			nSubTip += aDadosImp[nCont,10]
		EndIf
	Next

	If lImpOK
		// Dados
		oSection3:Finish()

		// Totais
		oSection8:Init()

		If aDadosImp[Len(aDadosImp),8] == "1"
			cTTit := STR0057 + " " + STR0040 // Sub Total / Orçamento - Balcão
		ElseIf aDadosImp[Len(aDadosImp),8] == "2"
			cTTit := STR0057 + " " + STR0041 // Sub Total / Ordem de Serviço - Oficina
		Else
			cTTit := STR0057 + " " + STR0060 + " " + cLocal // Sub Total / Armazém
		EndIf
		cTQtd := nQtdTip
		cTVlr := nSubTip

		oSection8:PrintLine()
		oSection8:Finish()

		oReport:SkipLine(1)

		oSection8:Init()

		cTTit := STR0055 + " " + cCodIte // Total Peça
		cTQtd := nQtdPec + nQtdTip
		cTVlr := nSubPec + nSubTip

		oSection8:PrintLine()
		oSection8:Finish()

		oReport:SkipLine(1)

		oSection8:Init()

		cTTit := STR0056 + " " + cGruIte // Total Grupo
		cTQtd := nQtdGru + nQtdPec + nQtdTip
		cTVlr := nSubGru + nSubPec + nSubTip

		oSection8:PrintLine()
		oSection8:Finish()

		oReport:SkipLine(1)

		oSection8:Init()

		cTTit := STR0058 // Total Geral
		cTQtd := nQtdGrl + nQtdGru + nQtdPec + nQtdTip
		cTVlr := nTolGrl + nSubGru + nSubPec + nSubTip

		oSection8:PrintLine()
		oSection8:Finish()
	EndIf
EndIf
Return

/*/{Protheus.doc} OPR1300076_ImprimirArrayOSOrc
Imprimindo o array de Demonstrativos por Num. Orc. / Num. OS
@author Fernando Vitor Cavani
@since 28/01/2019
@version undefined
@param oReport, objeto, Impressao
@type function
/*/
Static Function OPR1300076_ImprimirArrayOSOrc(oReport)
Local oSection1 := oReport:Section(1)
Local oSection4 := oReport:Section(4)
Local oSection5 := oReport:Section(5)
Local oSection8 := oReport:Section(8)

Local lImpOK    := .f.
Local nCont     := 0
Local nQtdTip   := nQtdGru := nQtdGrl := 0
Local nSubTip   := nSubGru := nTolGrl := 0
Local cNumOSOrc := cLocal  := ""

// Título
If MV_PAR01 == 1
	// Bloqueados
	cTitGru := STR0003 // Demonstrativo de Itens Bloqueados
ElseIf MV_PAR01 == 2
	// Reservados
	cTitGru := STR0004 // Demonstrativo de Itens Reservados
ElseIf MV_PAR01 == 3
	// Requisitados
	cTitGru := STR0059 // Demonstrativo de Itens Requisitados
Else
	// Todos
	cTitGru := STR0063 // Demonstrativo de Itens (Todos)
EndIf

cLocal    := " "
cNumOSOrc := " "

// Título / Grupo
oSection1:Init()

cTitGru += " - " + Iif(MV_PAR02 == 1, STR0037, STR0038) // Valor Custo / Valor Venda

oSection1:PrintLine()
oSection1:Finish()

If !Empty(aDadosImp)
	For nCont := 1 To Len(aDadosImp)
		If aDadosImp[nCont,9] > 0
			lImpOK := .t.

			// Tipo
			If (aDadosImp[nCont,1] <> cLocal .And. aDadosImp[nCont,8] <> cLocal) .Or. aDadosImp[nCont,7] <> cNumOSOrc
				If cLocal # " "
					// Dados
					oSection5:Finish()

					// Totais
					oSection8:Init()

					If cLocal == "1"
						cTTit := STR0057 + " " + STR0040 // Sub Total / Orçamento - Balcão
					ElseIf cLocal == "2"
						cTTit := STR0057 + " " + STR0041 // Sub Total / Ordem de Serviço - Oficina
					Else
						cTTit := STR0057 + " " + STR0060 + " " + cLocal // Sub Total / Armazém
					EndIf

					cTQtd := nQtdTip
					cTVlr := nSubTip

					oSection8:PrintLine()
					oSection8:Finish()

					oReport:SkipLine(1)

					// Total por Num. Orc. / Num. OS
					nQtdGru += nQtdTip
					nSubGru += nSubTip

					nQtdTip := 0
					nSubTip := 0
				EndIf
			EndIf

			// Num. Orc. / Num. OS
			If aDadosImp[nCont,7] <> cNumOSOrc
				If cNumOSOrc # " "
					// Totais
					oSection8:Init()

					cTTit := STR0066 + " " + cNumOSOrc // Total Num. Orc. / Num. OS
					cTQtd := nQtdGru
					cTVlr := nSubGru

					oSection8:PrintLine()
					oSection8:Finish()

					oReport:SkipLine(1)

					// Total Geral
					nQtdGrl += nQtdGru
					nTolGrl += nSubGru

					nQtdGru := 0
					nSubGru := 0
				EndIf

				// Num. Orc. / Num. OS
				oReport:SkipLine(1)

				oSection4:Init()

				cNumOS := aDadosImp[nCont,7]

				oSection4:PrintLine()
				oSection4:Finish()
			EndIf

			// Iniciando a Impressão
			cNumOSOrc := aDadosImp[nCont,7]

			If nQtdTip == 0
				// Tipo
				// Título / Grupo
				oSection1:Init()

				If aDadosImp[nCont,8] == "1"
					cLocal  := "1"
					cTitGru := STR0040 // Orçamento - Balcão
				ElseIf aDadosImp[nCont,8] == "2"
					cLocal  := "2"
					cTitGru := STR0041 // Ordem de Serviço - Oficina
				Else
					cLocal  := aDadosImp[nCont,1]
					cTitGru := STR0060 + " " + cLocal // Armazém
				EndIf

				oSection1:PrintLine()
				oSection1:Finish()

				// Dados
				oSection5:Init()
			EndIf

			cPeca   := aDadosImp[nCont,2] + " " + substr(aDadosImp[nCont,3], 1, 23) + " " + substr(aDadosImp[nCont,4], 1, 20)
			cNomVen := aDadosImp[nCont,11]
			dData   := StoD(aDadosImp[nCont,6])
			cNQtd   := aDadosImp[nCont,9]
			cNVlr   := aDadosImp[nCont,10]

			oSection5:PrintLine()

			// Total por Tipo
			nQtdTip += aDadosImp[nCont,9]
			nSubTip += aDadosImp[nCont,10]
		EndIf
	Next

	If lImpOK
		// Dados
		oSection5:Finish()

		// Totais
		oSection8:Init()

		If aDadosImp[Len(aDadosImp),8] == "1"
			cTTit := STR0057 + " " + STR0040 // Sub Total / Orçamento - Balcão
		ElseIf aDadosImp[Len(aDadosImp),8] == "2"
			cTTit := STR0057 + " " + STR0041 // Sub Total / Ordem de Serviço - Oficina
		Else
			cTTit := STR0057 + " " + STR0060 + " " + cLocal // Sub Total / Armazém
		EndIf
		cTQtd := nQtdTip
		cTVlr := nSubTip

		oSection8:PrintLine()
		oSection8:Finish()

		oReport:SkipLine(1)

		oSection8:Init()

		cTTit := STR0066 + " " + cNumOSOrc // Total Num. Orc. / Num. OS
		cTQtd := nQtdGru + nQtdTip
		cTVlr := nSubGru + nSubTip

		oSection8:PrintLine()
		oSection8:Finish()

		oReport:SkipLine(1)

		oSection8:Init()

		cTTit := STR0058 // Total Geral
		cTQtd := nQtdGrl + nQtdGru + nQtdTip
		cTVlr := nTolGrl + nSubGru + nSubTip

		oSection8:PrintLine()
		oSection8:Finish()
	EndIf
EndIf
Return

/*/{Protheus.doc} OPR1300086_ImprimirArrayVendedor
Imprimindo o array de Demonstrativos por Vendedor / Consultor
@author Fernando Vitor Cavani
@since 28/01/2019
@version undefined
@param oReport, objeto, Impressao
@type function
/*/
Static Function OPR1300086_ImprimirArrayVendedor(oReport)
Local oSection1 := oReport:Section(1)
Local oSection6 := oReport:Section(6)
Local oSection7 := oReport:Section(7)
Local oSection8 := oReport:Section(8)

Local lImpOK  := .f.
Local nCont   := 0
Local nQtdTip := nQtdGru := nQtdGrl := 0
Local nSubTip := nSubGru := nTolGrl := 0
Local cNomeV  := cLocal  := ""

// Título
If MV_PAR01 == 1
	// Bloqueados
	cTitGru := STR0003 // Demonstrativo de Itens Bloqueados
ElseIf MV_PAR01 == 2
	// Reservados
	cTitGru := STR0004 // Demonstrativo de Itens Reservados
ElseIf MV_PAR01 == 3
	// Requisitados
	cTitGru := STR0059 // Demonstrativo de Itens Requisitados
Else
	// Todos
	cTitGru := STR0063 // Demonstrativo de Itens (Todos)
EndIf

cLocal := " "
cNomeV := " "

// Título / Grupo
oSection1:Init()

cTitGru += " - " + Iif(MV_PAR02 == 1, STR0037, STR0038) // Valor Custo / Valor Venda

oSection1:PrintLine()
oSection1:Finish()

If !Empty(aDadosImp)
	For nCont := 1 To Len(aDadosImp)
		If aDadosImp[nCont,9] > 0
			lImpOK := .t.

			// Tipo
			If (aDadosImp[nCont,1] <> cLocal .And. aDadosImp[nCont,8] <> cLocal) .Or. aDadosImp[nCont,11] <> cNomeV
				If cLocal # " "
					// Dados
					oSection7:Finish()

					// Totais
					oSection8:Init()

					If cLocal == "1"
						cTTit := STR0057 + " " + STR0040 // Sub Total / Orçamento - Balcão
					ElseIf cLocal == "2"
						cTTit := STR0057 + " " + STR0041 // Sub Total / Ordem de Serviço - Oficina
					Else
						cTTit := STR0057 + " " + STR0060 + " " + cLocal // Sub Total / Armazém
					EndIf

					cTQtd := nQtdTip
					cTVlr := nSubTip

					oSection8:PrintLine()
					oSection8:Finish()

					oReport:SkipLine(1)

					// Total por Num. Orc. / Num. OS
					nQtdGru += nQtdTip
					nSubGru += nSubTip

					nQtdTip := 0
					nSubTip := 0
				EndIf
			EndIf

			// Vendedor / Consultor
			If aDadosImp[nCont,11] <> cNomeV
				If cNomeV # " "
					// Totais
					oSection8:Init()

					cTTit := STR0067 + " " + cNomeV // Total Vendedor / Consultor
					cTQtd := nQtdGru
					cTVlr := nSubGru

					oSection8:PrintLine()
					oSection8:Finish()

					oReport:SkipLine(1)

					// Total Geral
					nQtdGrl += nQtdGru
					nTolGrl += nSubGru

					nQtdGru := 0
					nSubGru := 0
				EndIf

				// Vendedor / Consultor
				oReport:SkipLine(1)

				oSection6:Init()

				cNomVen := aDadosImp[nCont,11]

				oSection6:PrintLine()
				oSection6:Finish()
			EndIf

			// Iniciando a Impressão
			cNomeV := aDadosImp[nCont,11]

			If nQtdTip == 0
				// Tipo
				// Título / Grupo
				oSection1:Init()

				If aDadosImp[nCont,8] == "1"
					cLocal  := "1"
					cTitGru := STR0040 // Orçamento - Balcão
				ElseIf aDadosImp[nCont,8] == "2"
					cLocal  := "2"
					cTitGru := STR0041 // Ordem de Serviço - Oficina
				Else
					cLocal  := aDadosImp[nCont,1]
					cTitGru := STR0060 + " " + cLocal // Armazém
				EndIf

				oSection1:PrintLine()
				oSection1:Finish()

				// Dados
				oSection7:Init()
			EndIf

			cNumOS := aDadosImp[nCont,7]
			cPeca  := aDadosImp[nCont,2] + " " + substr(aDadosImp[nCont,3], 1, 23) + " " + substr(aDadosImp[nCont,4], 1, 20)
			dData  := StoD(aDadosImp[nCont,6])
			cNQtd  := aDadosImp[nCont,9]
			cNVlr  := aDadosImp[nCont,10]

			oSection7:PrintLine()

			// Total por Tipo
			nQtdTip += aDadosImp[nCont,9]
			nSubTip += aDadosImp[nCont,10]
		EndIf
	Next

	If lImpOK
		// Dados
		oSection7:Finish()

		// Totais
		oSection8:Init()

		If aDadosImp[Len(aDadosImp),8] == "1"
			cTTit := STR0057 + " " + STR0040 // Sub Total / Orçamento - Balcão
		ElseIf aDadosImp[Len(aDadosImp),8] == "2"
			cTTit := STR0057 + " " + STR0041 // Sub Total / Ordem de Serviço - Oficina
		Else
			cTTit := STR0057 + " " + STR0060 + " " + cLocal // Sub Total / Armazém
		EndIf
		cTQtd := nQtdTip
		cTVlr := nSubTip

		oSection8:PrintLine()
		oSection8:Finish()

		oReport:SkipLine(1)

		oSection8:Init()

		cTTit := STR0067 + " " + cNomeV // Total Vendedor / Consultor
		cTQtd := nQtdGru + nQtdTip
		cTVlr := nSubGru + nSubTip

		oSection8:PrintLine()
		oSection8:Finish()

		oReport:SkipLine(1)

		oSection8:Init()

		cTTit := STR0058 // Total Geral
		cTQtd := nQtdGrl + nQtdGru + nQtdTip
		cTVlr := nTolGrl + nSubGru + nSubTip

		oSection8:PrintLine()
		oSection8:Finish()
	EndIf
EndIf
Return
