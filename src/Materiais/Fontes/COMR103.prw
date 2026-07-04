/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "comr103.ch"

/*/{Protheus.doc} COMR103
Relatório de controle de compras com entrega futura.

@author  Felipe Raposo
@version P12.1.17
@since   13/06/2018
/*/
User Function COMR103()

Local oReport
Local cPerg      := "COMR103"

If Pergunte(cPerg, .T.)
	oReport := ReportDef(cPerg)
	oReport:PrintDialog()
EndIf

Return

/*/{Protheus.doc} ReportDef
Função auxiliar para montagem do relatório.

@author  Felipe Raposo
@version P12.1.17
@since   13/06/2018
/*/
Static Function ReportDef(cPerg)

Local oReport, oSection1
Local cTitle     := STR0001  // "Compra com entrega futura"
Local aOrdem     := {}
Local cAliasTOP  := GetNextAlias()

oReport := TReport():New("COMR103", cTitle, cPerg, {|oReport| ReportPrint(oReport, cPerg, cAliasTOP)}, STR0002)  // "Relação de saldo de compra com entrega futura."
oReport:SetLandscape()
oReport:SetTotalInLine(.T.)
oReport:SetPageFooter(3,{|| ImpRoda(oReport)})  // define rodape
Pergunte(cPerg, .F.)

oSection1 := TRSection():New(oReport, STR0003, {"DHQ", "SD1", "SB1", "SF4"}, aOrdem)  // "Processos"
oSection1:SetHeaderPage()
TRCell():New(oSection1, "DHQ_TIPO",   "DHQ",STR0014) // Tipo
TRCell():New(oSection1, "DHQ_DOC",    "DHQ",STR0015) // N.F
TRCell():New(oSection1, "DHQ_SERIE",  "DHQ",STR0016) // Serie
TRCell():New(oSection1, "DHQ_ITEM",   "DHQ",STR0017) // Item
TRCell():New(oSection1, "DHQ_FORNEC", "DHQ",STR0018) // Fornecedor
TRCell():New(oSection1, "DHQ_LOJA",   "DHQ",STR0019) // Loja
TRCell():New(oSection1, "D1_PEDIDO",  "SD1",STR0020) // Pedido
TRCell():New(oSection1, "D1_ITEMPC",  "SD1",STR0021) // It. Pedido
TRCell():New(oSection1, "D1_COD",     "SD1",STR0022) // Produto
TRCell():New(oSection1, "B1_DESC",    "SB1",STR0023) // Descricao
TRCell():New(oSection1, "D1_UM",      "SD1", STR0011) // "U.M."
TRCell():New(oSection1, "DHQ_QTORI",  "DHQ", STR0004) // "Faturada"
TRCell():New(oSection1, "DHQ_QTREC",  "DHQ", STR0005) // "Remessa"
TRCell():New(oSection1, "SALDO",      "   ", STR0006, PesqPict("SD1", "D1_QUANT"), TamSX3("D1_QUANT")[1],, {|| DHQ->(If(DHQ_TIPO = "1" .and. DHQ_DESFAZ  = ' ', DHQ_QTORI - DHQ_QTREC, 0))},,, "RIGHT")  // "Saldo"
TRCell():New(oSection1, "D1_VUNIT",   "SD1")
TRCell():New(oSection1, "D1_TOTAL",   "SD1")
TRCell():New(oSection1, "D1_TES",     "SD1", STR0007)  // "TES"
TRCell():New(oSection1, "D1_CF",      "SD1", STR0008)  // "CFOP"
TRCell():New(oSection1, "D1_QTSEGUM", "SD1")
TRCell():New(oSection1, "CUSTO",      "   ", STR0009, PesqPict("SD1", "D1_CUSTO"), TamSX3("D1_CUSTO")[1],,,,, "RIGHT")  // "Custo"

Return(oReport)


/*/{Protheus.doc} ReportPrint
Função auxiliar para montagem do relatório.

@author  Felipe Raposo
@version P12.1.17
@since   13/06/2018
/*/
Static Function ReportPrint(oReport, cPerg, cAliasTOP)

Local oSection1  := oReport:Section(1)
Local oBreak1    := nil
Local cQuery     := ""
Local nQuebra    := 0

// Define a quebra de processo com totalizador.
If mv_par14 = 1
	oBreak1 := TRBreak():New(oSection1, {|| (cAliasTOP)->DHQaRecNo}, STR0010)  // "Total do processo"
	TRFunction():New(oSection1:Cell("DHQ_QTORI"),, "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("DHQ_QTREC"),, "SUM", oBreak1,,, {|| DHQ->(If(DHQ_TIPO = "2", DHQ_QTREC, 0))}, .F., .F.)
EndIf

Pergunte(cPerg, .F.)
cQuery := "select SB1.R_E_C_N_O_ SB1RecNo, " + cQuery
cQuery += "SD1a.R_E_C_N_O_ SD1aRecNo, SF4a.R_E_C_N_O_ SF4aRecNo, DHQa.R_E_C_N_O_ DHQaRecNo, " + CRLF
cQuery += "SD1b.R_E_C_N_O_ SD1bRecNo, SF4b.R_E_C_N_O_ SF4bRecNo, DHQb.R_E_C_N_O_ DHQbRecNo " + CRLF

cQuery += "from " + RetSQLName("DHQ") + " DHQa " + CRLF

cQuery += "inner join " + RetSQLName("SD1") + " SD1a on SD1a.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "and SD1a.D1_FILIAL  = '" + xFilial("SD1") + "' " + CRLF
cQuery += "and SD1a.D1_DOC     = DHQa.DHQ_DOC " + CRLF
cQuery += "and SD1a.D1_SERIE   = DHQa.DHQ_SERIE " + CRLF
cQuery += "and SD1a.D1_FORNECE = DHQa.DHQ_FORNEC " + CRLF
cQuery += "and SD1a.D1_LOJA    = DHQa.DHQ_LOJA " + CRLF
cQuery += "and SD1a.D1_ITEM    = DHQa.DHQ_ITEM " + CRLF

cQuery += "left  join " + RetSQLName("SF4") + " SF4a on SF4a.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "and SF4a.F4_FILIAL  = '" + xFilial("SF4") + "' " + CRLF
cQuery += "and SF4a.F4_CODIGO  = SD1a.D1_TES " + CRLF

cQuery += "left  join " + RetSQLName("DHQ") + " DHQb on DHQb.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "and DHQb.DHQ_FILIAL = '" + xFilial("DHQ") + "' " + CRLF
cQuery += "and DHQb.DHQ_IDENT  = DHQa.DHQ_IDENT " + CRLF
cQuery += "and DHQb.DHQ_TIPO   <> '1' " + CRLF  // O que for entrega ou desfazimento.

cQuery += "left  join " + RetSQLName("SD1") + " SD1b on SD1b.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "and SD1b.D1_FILIAL  = '" + xFilial("SD1") + "' " + CRLF
cQuery += "and SD1b.D1_DOC     = DHQb.DHQ_DOC " + CRLF
cQuery += "and SD1b.D1_SERIE   = DHQb.DHQ_SERIE " + CRLF
cQuery += "and SD1b.D1_FORNECE = DHQb.DHQ_FORNEC " + CRLF
cQuery += "and SD1b.D1_LOJA    = DHQb.DHQ_LOJA " + CRLF
cQuery += "and SD1b.D1_ITEM    = DHQb.DHQ_ITEM " + CRLF

cQuery += "left  join " + RetSQLName("SF4") + " SF4b on SF4b.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "and SF4b.F4_FILIAL  = '" + xFilial("SF4") + "' " + CRLF
cQuery += "and SF4b.F4_CODIGO  = SD1b.D1_TES " + CRLF

cQuery += "inner join " + RetSQLName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "and SB1.B1_FILIAL  = '" + xFilial("SB1") + "' " + CRLF
cQuery += "and SB1.B1_COD     = SD1a.D1_COD " + CRLF

cQuery += "where DHQa.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "and DHQa.DHQ_FILIAL = '" + xFilial("DHQ") + "' " + CRLF
cQuery += "and DHQa.DHQ_FORNEC >= '" + mv_par01 + "'       and DHQa.DHQ_LOJA >= '" + mv_par02 + "'        and DHQa.DHQ_FORNEC <= '" + mv_par03 + "'        and DHQa.DHQ_LOJA <= '" + mv_par04 + "' " + CRLF
cQuery += "and DHQa.DHQ_COD    >= '" + mv_par05 + "'       and DHQa.DHQ_COD    <= '" + mv_par06 + "' " + CRLF
cQuery += "and DHQa.DHQ_DTREC  >= '" + dtos(mv_par07) + "' and DHQa.DHQ_DTREC  <= '" + dtos(mv_par08) + "' " + CRLF

If mv_par09 = 2  // Somente em aberto.
	cQuery += "and DHQa.DHQ_STATUS = '1' " + CRLF
	cQuery += "and DHQa.DHQ_QTORI  > DHQa.DHQ_QTREC " + CRLF  // 1-Aberto.
	cQuery += "and DHQa.DHQ_DESFAZ  = ' ' " + CRLF
EndIf

If mv_par09 = 3 //Encerrado
	cQuery += "and DHQa.DHQ_TIPO   = '1' " + CRLF  // 1-Compra futura.
	cQuery += "and DHQa.DHQ_STATUS = '9' " + CRLF 
EndIf

If mv_par09 = 1 //Todos
	cQuery += "and DHQa.DHQ_TIPO   = '1' " + CRLF  // 1-Compra futura.
EndIf

cQuery += "order by DHQa.DHQ_DTREC, DHQa.DHQ_DOC, DHQa.DHQ_SERIE, DHQa.DHQ_ITEM, " + CRLF
cQuery += "DHQb.DHQ_DTREC, DHQb.DHQ_TIPO, DHQb.DHQ_DOC, DHQb.DHQ_SERIE, DHQb.DHQ_ITEM "

cQuery := ChangeQuery(cQuery)
MPSysOpenQuery(cQuery, cAliasTOP)
 
If (cAliasTOP)->(!eof())
	// Imprime as notas de entrega futura.
	oSection1:Init()

	// Lista pedido
	If mv_par10 == 2
		oSection1:Cell("D1_PEDIDO"):Disable()
		oSection1:Cell("D1_ITEMPC"):Disable()
	EndIf

	// Se desejado, não imprime segunda unidade de medida.
	If mv_par11 = 2
		oSection1:Cell("D1_QTSEGUM"):Disable()
	EndIf

	// Define como será impresso o custo.
	If mv_par12 = 2
		oSection1:Cell("CUSTO"):Disable()
	ElseIf mv_par13 = 1
		oSection1:Cell("CUSTO"):SetBlock({|| SD1->D1_CUSTO})
		oSection1:Cell("CUSTO"):GetFieldInfo("D1_CUSTO")
	Else
		oSection1:Cell("CUSTO"):SetBlock({|| SD1->&("D1_CUSTO" + cValToChar(mv_par13))})
		oSection1:Cell("CUSTO"):GetFieldInfo("D1_CUSTO" + cValToChar(mv_par13))
	EndIf

	// Habilita e desabilita algumas colunas.
	oSection1:Cell("DHQ_QTORI"):Show()
	oSection1:Cell("DHQ_QTREC"):Hide()
	oSection1:Cell("SALDO"):Show()

	Do While (cAliasTOP)->(!eof())
		DHQ->(dbGoTo((cAliasTOP)->DHQaRecNo))
		SD1->(dbGoTo((cAliasTOP)->SD1aRecNo))
		SF4->(dbGoTo((cAliasTOP)->SF4aRecNo))
		SB1->(dbGoTo((cAliasTOP)->SB1RecNo))
		oSection1:PrintLine()

		// Imprime os consumos, se houver.
		If (cAliasTOP)->DHQbRecNo > 0
			oSection1:Cell("DHQ_QTORI"):Hide()
			oSection1:Cell("SALDO"):Hide()

			nQuebra := (cAliasTOP)->DHQaRecNo
			Do While (cAliasTOP)->(!eof() .and. nQuebra == DHQaRecNo)
				DHQ->(dbGoTo((cAliasTOP)->DHQbRecNo))
				SD1->(dbGoTo((cAliasTOP)->SD1bRecNo))
				SF4->(dbGoTo((cAliasTOP)->SF4bRecNo))

				If DHQ->DHQ_TIPO = "9"  // 9-Desfazimento.
					oSection1:Cell("DHQ_QTREC"):Hide()
				Else
					oSection1:Cell("DHQ_QTREC"):Show()
				EndIf
				oSection1:PrintLine()

				(cAliasTOP)->(dbSkip())
			EndDo
			oSection1:Cell("DHQ_QTORI"):Show()
			oSection1:Cell("DHQ_QTREC"):Hide()
			oSection1:Cell("SALDO"):Show()
		Else
			(cAliasTOP)->(dbSkip())
		EndIf
		oReport:ThinLine()
	EndDo
	oSection1:Finish()
EndIf
(cAliasTOP)->(dbCloseArea())

Return

/*/{Protheus.doc} ImpRoda
Impressao do rodape

@author  Felipe Raposo
@version P12.1.17
@since   13/06/2018
/*/
Static Function ImpRoda(oReport)

oReport:ThinLine()
oReport:PrintText(STR0012) // "* O termpo Desfazimento refere-se ao cancelamento do contrato com o fornecedor sendo que não ocorrerá mais remessa de mercadoria."
oReport:PrintText(STR0013) // "Neste caso, o saldo relacionado ao processo de compra com entrega futura é encerrado."

Return
