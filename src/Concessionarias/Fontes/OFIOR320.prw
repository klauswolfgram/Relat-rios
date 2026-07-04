/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 19     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#INCLUDE "ofior320.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIOR320 ³ Autor ³ Thiago                ³ Data ³ 04/02/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Itens com Locacao                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR320
	Private cAliasSB1      := "SQLSB1"
	Private cTamB5_LOCALI2 := Space(TamSX3("B5_LOCALI2")[1])
	Private cTamBZ_LOCALI2 := IIF(SBZ->(FieldPos("BZ_LOCALI2")) > 0, Space(TamSX3("BZ_LOCALI2")[1]), " ")
	Private lSBZ           := (SuperGetMV("MV_ARQPROD", .F., "SB1") == "SBZ")
	Private lLocSoSBZ      := ( lSBZ .and. GetNewPar("MV_MIL0096","S") == "N" ) // A locação da peça também deve ser considerada na tabela SB5 quando o parâmetro MV_ARQPROD estiver configurado com SBZ? ( S=Considera / N=Não Considera )

	OFR320R3() // Executa versão anterior do fonte
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³OFR320R3  ºAutor  ³Fabio               º Data ³  09/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impresao do relatorio.                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OFR320R3()
	Private aReturn := {STR0002, 1, STR0003, 2, 2, 1, "", 1} // Itens X Locação / Administracao
	Private cPerg   := "OFR320"
	Private cTitulo := STR0004 // Itens com Locacao

	ValidPerg()

	// Mesmo passando a pergunte para o TReport
	// preciso carregar para as MV_PAR existirem
	PERGUNTE(cPerg, .f.)

	OFR3200016_ChamadaImpressaoItensLocacao()
Return

/*/{Protheus.doc} OPR1300016_ChamadaImpressaoDemonstrativo
Chamada para impressão dos Demonstrativos
@author Fernando Vitor Cavani
@since 04/03/2019
@version undefined
@type function
/*/
Static Function OFR3200016_ChamadaImpressaoItensLocacao()
	Local oReport

	oReport := ReportDef() // Nesta função nós definimos a estrutura do relatório, por exemplo as seções, campos, totalizadores e etc.
	oReport:SetPortrait()  // Define orientação de página do relatório como retrato.
	oReport:PrintDialog()  // Essa função serve para disparar a impressão do TReport, ela que faz com que seja exibida a tela de configuração de impressora e os botões de parâmetros.
Return

/*/{Protheus.doc} ReportDef
Criando o padrão para impressão dos Itens com Locação
@author Fernando Vitor Cavani
@since 04/03/2019
@version undefined
@type function
/*/
Static Function ReportDef()
	Local cDesc := ""
	Local oReport
	Local oSection1
	Local oSection2

	cTit := ""
	cLoc := cGrp := cCod := cDes := cQtd := ""

	// Descrição
	cDesc := STR0030 // Este programa tem como objetivo imprimir os itens com locação ou com estoque e sem locação

	// TReport
	oReport := TReport():New(           ;
		"OFIOR320",                       ;
		cTitulo,                        ;
		cPerg,                          ;
		{|oReport| OFIR320IMP(oReport)},;
		cDesc)

	// Título
	oSection1 := TRSection():New(oReport, "oTitulo")

	oReport:Section(1):SetLineStyle() // Define se imprime as células da seção em linhas
	oSection1:SetLinesBefore(1)       // Define a quantidade de linhas que serão saltadas antes da impressão da seção

	TRCell():New(oSection1, "oTit",, "", "@!", 80,, {|| cTit },,,,,,,,, .t.) // Título

	// Dados
	oSection2 := TRSection():New(oReport, "oDados")

	oSection2:SetLinesBefore(1) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

	TRCell():New(oSection2, "oLoc",, STR0021, "@!"        ,  80,, {|| cLoc },,,        ,,,,,,) // Locação
	TRCell():New(oSection2, "oGrp",, STR0022, "@!"        ,  10,, {|| cGrp },,,        ,,,,,,) // Grupo
	TRCell():New(oSection2, "oCod",, STR0023, "@!"        ,  80,, {|| cCod },,,        ,,,,,,) // Código do Item
	TRCell():New(oSection2, "oDes",, STR0024, "@!"        , 120,, {|| cDes },,,        ,,,,,,) // Descrição
	TRCell():New(oSection2, "oQtd",, STR0025, "@E 999,999",  20,, {|| cQtd },,, "RIGHT",,,,,,) // Quantidade
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³OFIR320IMPºAutor  ³Thiago              º Data ³  09/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do relatorio.                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OFIR320IMP(oReport)
	Local oSection1 := oReport:Section(1)
	Local cGruVei   := Left(GetNewPar("MV_GRUVEI", "VEI") + Space(10), Len(SB1->B1_GRUPO))
	Local cGruSrv   := Left(GetNewPar("MV_GRUSRV", "SRVC") + Space(10), Len(SB1->B1_GRUPO))

	Private oSection2 := oReport:Section(2)

	lSBZ := (SuperGetMV("MV_ARQPROD", .F., "SB1") == "SBZ")

	// Título
	oSection1:Init()

	If MV_PAR01 == 1
		cTit := STR0004 // Itens com Locacao
	ElseIf MV_PAR01 == 2
		cTit := STR0006 // Itens com Estoque e sem Locacao
	Else
		cTit := STR0031 // Itens (Todos)
	EndIf

	oSection1:PrintLine()
	oSection1:Finish()

	// Dados
	oSection2:Init()

	// Itens com Locação ou Ambos
	If MV_PAR01 == 1 .Or. MV_PAR01 == 3
		OFR3200026_ImpItensComLocacao(oReport, cGruVei, cGruSrv)
	EndIf

	// Autor Thiago
	// Data  04/02/02
	// Itens com Estoque e sem Locação ou Ambos
	If MV_PAR01 == 2 .Or. MV_PAR01 == 3
		OFR3200036_ImpItensComEstoqueSemLocacao(oReport, cGruVei, cGruSrv)
	EndIf

	oSection2:Finish()
Return

/*/{Protheus.doc} OFR3200026_ImpItensComLocacao
Impressão dos Itens com Locação
@author Fernando Vitor Cavani
@since 04/03/2019
@version undefined
@param oReport, objeto  , Impressao
@param cGruVei, caracter, Parâmetro MV_GRUVEI
@param cGruSrv, caracter, Parâmetro MV_GRUSRV
@type function
/*/
Static Function OFR3200026_ImpItensComLocacao(oReport, cGruVei, cGruSrv)
	// Vinicius Gati - 19/11/14

	If lSBZ .And. SBZ->(FieldPos("BZ_LOCALI2")) > 0
		If lLocSoSBZ
			cQuery := " SELECT "
			cQuery += " 	SB1.B1_COD, "
			cQuery += " 	SB1.B1_GRUPO, "
			cQuery += " 	SB1.B1_CODITE, "
			cQuery += " 	SB1.B1_DESC, "
			cQuery += " 	SBZ.BZ_LOCALI2 LOCALI2, "
			cQuery += " 	SUM(SB2.B2_QATU) QTD "
			cQuery += " FROM "
			cQuery += " 	" + RetSqlName("SBZ") + " SBZ JOIN " + RetSqlName("SB1") + " SB1 "
			cQuery += " 	ON "
			cQuery += " 		BZ_FILIAL = '" + xFilial("SBZ") + "' "
			cQuery += " 		AND B1_FILIAL = '" + xFilial("SB1") + "' "
			cQuery += " 		AND B1_COD = BZ_COD "
			cQuery += " 		AND B1_GRUPO NOT IN ('" + cGruVei + "', '" + cGruSrv + "') "
			cQuery += " 		AND SBZ.BZ_LOCALI2 <> '" + cTamBZ_LOCALI2 + "' "
			cQuery += " 		AND B1_MSBLQL = '2' "
			cQuery += " 		AND SBZ.BZ_LOCALI2 >= '" + AllTrim(MV_PAR02) + "' "
			cQuery += " 		AND SBZ.BZ_LOCALI2 <= '" + AllTrim(MV_PAR03) + "' "
			cQuery += " 		AND SBZ.D_E_L_E_T_ = ' ' "
			cQuery += " 		AND SB1.D_E_L_E_T_ = ' ' "
			cQuery += " 	JOIN " + RetSqlName("SB2") + " SB2 "
			cQuery += " 	ON "
			cQuery += " 		B2_FILIAL = '" + xFilial("SB2") + "' "
			cQuery += " 		AND SB2.B2_COD = SB1.B1_COD "
			cQuery += " 		AND SB2.B2_LOCAL <= '50' "
			cQuery += " 		AND SB2.D_E_L_E_T_ = ' ' "
			cQuery += " GROUP BY "
			cQuery += " 	SB1.B1_COD, "
			cQuery += " 	SB1.B1_GRUPO, "
			cQuery += " 	SB1.B1_CODITE, "
			cQuery += " 	SB1.B1_DESC, "
			cQuery += " 	SBZ.BZ_LOCALI2 "
		Else
			cQuery := " SELECT "
			cQuery += " 	SB1.B1_COD, "
			cQuery += " 	SB1.B1_GRUPO, "
			cQuery += " 	SB1.B1_CODITE, "
			cQuery += " 	SB1.B1_DESC, "
			cQuery += " 	CASE
			cQuery += " 		WHEN (SBZ.BZ_LOCALI2 IS NULL OR SBZ.BZ_LOCALI2 = '" + cTamBZ_LOCALI2 + "') THEN SB5.B5_LOCALI2 "
			cQuery += " 		ELSE SBZ.BZ_LOCALI2 "
			cQuery += " 	END LOCALI2, "
			cQuery += " 	SUM(SB2.B2_QATU) QTD "
			cQuery += " FROM "
			cQuery += " 	" + RetSqlName("SB1") + " SB1 JOIN " + RetSqlName("SB2") + " SB2 "
			cQuery += " 	ON "
			cQuery += " 		B1_FILIAL = '" + xFilial("SB1") + "' "
			cQuery += " 		AND SB2.B2_FILIAL = '" + xFilial('SB2') + "' "
			cQuery += " 		AND SB2.B2_COD = SB1.B1_COD "
			cQuery += " 		AND SB2.B2_LOCAL <= '50' "
			cQuery += " 		AND SB1.B1_GRUPO NOT IN ('" + cGruVei + "', '" + cGruSrv + "') "
			cQuery += " 		AND B1_MSBLQL = '2' "
			cQuery += " 		AND SB2.D_E_L_E_T_ = ' ' "
			cQuery += "  		AND SB1.D_E_L_E_T_ = ' ' "
			cQuery += " 	LEFT JOIN " + RetSqlName("SBZ") + " SBZ "
			cQuery += " 	ON "
			cQuery += " 		SBZ.BZ_FILIAL = '" + xFilial("SBZ") + "' "
			cQuery += " 		AND SBZ.BZ_COD = SB1.B1_COD "
			cQuery += " 		AND SBZ.BZ_LOCALI2 >= '" + AllTrim(MV_PAR02) + "' "
			cQuery += " 		AND SBZ.BZ_LOCALI2 <= '" + AllTrim(MV_PAR03) + "' "
			cQuery += " 		AND SBZ.BZ_LOCALI2 <> '" + cTamBZ_LOCALI2 + "' "
			cQuery += " 		AND SBZ.D_E_L_E_T_ = ' ' "
			cQuery += " 	LEFT JOIN " + RetSqlName("SB5") + " SB5 "
			cQuery += " 	ON "
			cQuery += " 		SB5.B5_FILIAL = '" + xFilial("SB5") + "' "
			cQuery += " 		AND SB5.B5_COD = SB1.B1_COD "
			cQuery += " 		AND SB5.B5_LOCALI2 >= '" + AllTrim(MV_PAR02) + "' "
			cQuery += " 		AND SB5.B5_LOCALI2 <= '" + AllTrim(MV_PAR03) + "' "
			cQuery += " 		AND SB5.B5_LOCALI2 <> '" + cTamBZ_LOCALI2 + "' "
			cQuery += " 		AND SB5.D_E_L_E_T_ = ' ' "
			cQuery += " GROUP BY "
			cQuery += " 	SB1.B1_COD, "
			cQuery += " 	SB1.B1_GRUPO, "
			cQuery += " 	SB1.B1_CODITE, "
			cQuery += " 	SB1.B1_DESC, "
			cQuery += " 	CASE "
			cQuery += " 		WHEN (SBZ.BZ_LOCALI2 IS NULL OR SBZ.BZ_LOCALI2 = '" + cTamBZ_LOCALI2 + "') THEN SB5.B5_LOCALI2 "
			cQuery += " 		ELSE SBZ.BZ_LOCALI2 "
			cQuery += " 	END "
		Endif
	Else
		cQuery := " SELECT "
		cQuery += " 	SB1.B1_COD, "
		cQuery += " 	SB1.B1_GRUPO, "
		cQuery += " 	SB1.B1_CODITE, "
		cQuery += " 	SB1.B1_DESC, "
		cQuery += " 	SB5.B5_LOCALI2 LOCALI2, "
		cQuery += " 	SUM(SB2.B2_QATU) QTD "
		cQuery += " FROM "
		cQuery += " 	" + RetSqlName("SB5") + " SB5 JOIN " + RetSqlName("SB1") + " SB1 "
		cQuery += " 	ON "
		cQuery += " 		B5_FILIAL = '" + xFilial("SB5") + "' "
		cQuery += " 		AND B1_FILIAL = '" + xFilial("SB1") + "' "
		cQuery += " 		AND B5_COD = B1_COD "
		cQuery += " 		AND SB5.B5_LOCALI2 >= '" + AllTrim(MV_PAR02) + "' "
		cQuery += " 		AND SB5.B5_LOCALI2 <= '" + AllTrim(MV_PAR03) + "' "
		cQuery += " 		AND SB5.B5_LOCALI2 <> '" + cTamB5_LOCALI2 + "' "
		cQuery += " 		AND SB1.B1_GRUPO NOT IN ('" + cGruVei + "', '" + cGruSrv + "') "
		cQuery += " 		AND B1_MSBLQL = '2' "
		cQuery += " 		AND SB5.D_E_L_E_T_ = ' ' "
		cQuery += " 		AND SB1.D_E_L_E_T_ = ' ' "
		cQuery += " 	JOIN " + RetSqlName("SB2") + " SB2 "
		cQuery += " 	ON "
		cQuery += " 		B2_FILIAL = '" + xFilial("SB2") + "' "
		cQuery += " 		AND SB1.B1_COD = SB2.B2_COD "
		cQuery += " 		AND SB2.B2_LOCAL <= '50' "
		cQuery += " 		AND SB2.D_E_L_E_T_ = ' ' "
		cQuery += " GROUP BY "
		cQuery += " 	SB1.B1_COD, "
		cQuery += " 	SB1.B1_GRUPO, "
		cQuery += " 	SB1.B1_CODITE, "
		cQuery += " 	SB1.B1_DESC, "
		cQuery += " 	SB5.B5_LOCALI2 "
	EndIf


	If MV_PAR04 == 1 // Ordenação (Item)
		cQuery += " ORDER BY "
		cQUery += " 	2, "
		cQUery += " 	3 " // Ordena a coluna 2 e 3 (Grupo e Código)
	ElseIf MV_PAR04 == 2 // Ordenação (Locação)
		cQuery += " ORDER BY "
		cQuery += " 	5 " // Ordena a coluna 5 (Endereço DMS)
	EndIf
		
	dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cAliasSB1, .T., .T.)
	Do While !(cAliasSB1)->(Eof())
		cLoc := (cAliasSB1)->LOCALI2
		cGrp := (cAliasSB1)->B1_GRUPO
		cCod := (cAliasSB1)->B1_CODITE
		cDes := (cAliasSB1)->B1_DESC
		cQtd := (cAliasSB1)->QTD

		oSection2:PrintLine()

		DbSelectArea(cAliasSB1)

		(cAliasSB1)->(DbSkip())
	EndDo

	(cAliasSB1)->(dbCloseArea())
Return

/*/{Protheus.doc} OFR3200036_ImpItensComEstoqueSemLocacao
Impressão dos Itens com Estoque e sem Locação
@author Fernando Vitor Cavani
@since 04/03/2019
@version undefined
@param oReport, objeto  , Impressao
@param cGruVei, caracter, Parâmetro MV_GRUVEI
@param cGruSrv, caracter, Parâmetro MV_GRUSRV
@type function
/*/
Static Function OFR3200036_ImpItensComEstoqueSemLocacao(oReport, cGruVei, cGruSrv)
	// Vinicius Gati - 19/11/14 (Se usa BZ é feito JOIN com BZ e o segundo SELECT são sempre para os registros que não estão no BZ nem no B5)
	If lSBZ .And. SBZ->(FieldPos("BZ_LOCALI2")) > 0
		If lLocSoSBZ
			cQuery := " SELECT "
			cQuery += " 	SB1.B1_COD, "
			cQuery += " 	SB1.B1_GRUPO, "
			cQuery += " 	SB1.B1_CODITE, "
			cQuery += " 	SB1.B1_DESC, "
			cQuery += " 	SUM(SB2.B2_QATU) QTD "
			cQuery += " FROM "
			cQuery += " 	" + RetSqlName("SBZ") + " SBZ JOIN " + RetSqlName("SB1") + " SB1 "
			cQuery += " 	ON "
			cQuery += " 		SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
			cQuery += " 		AND SBZ.BZ_FILIAL = '" + xFilial("SBZ") + "' "
			cQuery += " 		AND SB1.B1_COD = SBZ.BZ_COD "
			cQuery += " 		AND SB1.B1_GRUPO NOT IN ('" + cGruVei + "', '" + cGruSrv + "') "
			cQuery += " 		AND SBZ.BZ_LOCALI2 = '" + cTamBZ_LOCALI2 + "' "
			cQuery += " 		AND B1_MSBLQL = '2' "
			cQuery += " 		AND SBZ.D_E_L_E_T_ = ' ' "
			cQuery += " 		AND SB1.D_E_L_E_T_ = ' ' "
			cQuery += " 	JOIN " + RetSqlName("SB2") + " SB2 "
			cQuery += " 	ON "
			cQuery += " 		SB2.B2_FILIAL = '" + xFilial('SB2') + "' "
			cQuery += " 		AND SB2.B2_COD = SB1.B1_COD "
			cQuery += " 		AND SB2.B2_LOCAL <= '50' "
			cQuery += " 		AND SB2.B2_QATU > 0 "
			cQuery += " 		AND SB2.D_E_L_E_T_ = ' ' "
		Else
			cQuery := " SELECT "
			cQuery += " 	SB1.B1_COD, "
			cQuery += " 	SB1.B1_GRUPO, "
			cQuery += " 	SB1.B1_CODITE, "
			cQuery += " 	SB1.B1_DESC, "
			cQuery += " 	SUM(SB2.B2_QATU) QTD "
			cQuery += " FROM "
			cQuery += " 	" + RetSqlName("SB1") + " SB1 JOIN " + RetSqlName("SB2") + " SB2 "
			cQuery += " 	ON "
			cQuery += " 		SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
			cQuery += " 		AND SB2.B2_FILIAL = '" + xFilial('SB2') + "' "
			cQuery += " 		AND SB2.B2_COD = SB1.B1_COD "
			cQuery += " 		AND SB1.B1_GRUPO NOT IN ('" + cGruVei + "', '" + cGruSrv + "') "
			cQuery += " 		AND SB2.B2_LOCAL <= '50' "
			cQuery += " 		AND SB2.B2_QATU > 0 "
			cQuery += " 		AND B1_MSBLQL = '2' "
			cQuery += " 		AND SB1.D_E_L_E_T_ = ' ' "
			cQuery += " 		AND SB2.D_E_L_E_T_ = ' ' "
			cQuery += " 	LEFT JOIN "+ RetSqlName("SBZ") + " SBZ "
			cQuery += " 	ON "
			cQuery += " 		SBZ.BZ_FILIAL = '" + xFilial("SBZ") + "' "
			cQuery += " 		AND SBZ.BZ_COD = SB1.B1_COD "
			cQuery += " 		AND SBZ.BZ_LOCALI2 = '" + cTamBZ_LOCALI2 + "' "
			cQuery += " 		AND SBZ.D_E_L_E_T_ = ' ' "
			cQuery += " 	LEFT JOIN " + RetSqlName("SB5") + " SB5 "
			cQuery += " 	ON "
			cQuery += " 		SB5.B5_FILIAL = '" + xFilial("SB5") + "' "
			cQuery += " 		AND SB5.B5_COD = SB1.B1_COD "
			cQuery += " 		AND SB5.B5_LOCALI2 = '" + cTamBZ_LOCALI2 + "' "
			cQuery += " 		AND SB5.D_E_L_E_T_ = ' ' "
		Endif
	Else
		cQuery := " SELECT "
		cQuery += " 	SB1.B1_COD, "
		cQuery += " 	SB1.B1_GRUPO, "
		cQuery += " 	SB1.B1_CODITE, "
		cQuery += " 	SB1.B1_DESC, "
		cQuery += " 	SUM(SB2.B2_QATU) QTD "
		cQuery += " FROM "
		cQuery += " 	" + RetSqlName("SB5") + " SB5 JOIN " + RetSqlName("SB1") + " SB1 "
		cQuery += " 	ON "
		cQuery += " 		SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
		cQuery += " 		AND SB5.B5_FILIAL = '" + xFilial("SB5") + "' "
		cQuery += " 		AND SB1.B1_COD = SB5.B5_COD "
		cQuery += " 		AND SB5.B5_LOCALI2 = '" + cTamB5_LOCALI2 + "' "
		cQuery += " 		AND B1_MSBLQL = '2' "
		cQuery += " 		AND SB1.B1_GRUPO NOT IN ('" + cGruVei + "', '" + cGruSrv + "') "
		cQuery += " 		AND SB1.D_E_L_E_T_ = ' ' "
		cQuery += " 		AND SB5.D_E_L_E_T_ = ' ' "
		cQuery += " 	JOIN " + RetSqlName("SB2") + " SB2 "
		cQuery += " 	ON "
		cQuery += " 		SB2.B2_FILIAL = '" + xFilial("SB2") + "' "
		cQuery += " 		AND SB2.B2_COD = SB1.B1_COD "
		cQuery += " 		AND SB2.B2_LOCAL <= '50' "
		cQuery += " 		AND SB2.D_E_L_E_T_ = ' ' "
		cQuery += " 		AND SB2.B2_QATU > 0 "
		cQuery += " GROUP BY "
		cQuery += " 	SB1.B1_COD, "
		cQuery += " 	SB1.B1_GRUPO, "
		cQuery += " 	SB1.B1_CODITE, "
		cQuery += " 	SB1.B1_DESC "

		cQuery += " UNION ALL "

		cQuery += " SELECT "
		cQuery += " 	SB1.B1_COD, "
		cQuery += " 	SB1.B1_GRUPO, "
		cQuery += " 	SB1.B1_CODITE, "
		cQUery += " 	SB1.B1_DESC, "
		cQuery += " 	SUM(B2_QATU) QTD "
		cQuery += " FROM "
		cQuery += " 	" + RetSqlName("SB1") + " SB1 JOIN " + RetSqlName("SB2") + " SB2 "
		cQuery += " 	ON "
		cQuery += " 		SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
		cQuery += " 		AND SB2.B2_FILIAL = '" + xFilial("SB2") + "' "
		cQuery += " 		AND SB2.B2_COD = SB1.B1_COD "
		cQuery += " 		AND SB2.B2_QATU > 0 "
		cQuery += " 		AND SB1.B1_GRUPO NOT IN ('" + cGruVei + "', '" + cGruSrv + "') "
		cQuery += " 		AND B1_MSBLQL = '2' "
		cQuery += " 		AND SB2.B2_LOCAL <= '50' "
		cQuery += " 		AND SB1.D_E_L_E_T_ = ' ' "
		cQuery += " 		AND SB2.D_E_L_E_T_ = ' ' "
		cQuery += " WHERE "
		cQuery += " 	SB1.B1_COD NOT IN "
		cQuery += " 	(SELECT DISTINCT B5_COD FROM " + RetSqlName("SB5") + " B5 WHERE B5.D_E_L_E_T_ = ' ' AND B5.B5_FILIAL = '" + xFilial("SB5") + "') "
	EndIf
	cQuery += " 	GROUP BY "
	cQuery += " 		SB1.B1_COD, "
	cQuery += " 		SB1.B1_GRUPO, "
	cQuery += " 		SB1.B1_CODITE, "
	cQuery += " 		SB1.B1_DESC "

	If MV_PAR04 == 1 // Ordenação (Item)
		cQuery += " ORDER BY "
		cQuery += " 	2, "
		cQuery += " 	3 " // Ordena a coluna 2 e 3 (Grupo e Código)
	EndIf

	DbSelectArea("SB5")
	dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cAliasSB1, .T., .T.)
	Do While !(cAliasSB1)->(Eof())

		SB5->(DbSeek(xFilial("SB5")+(cAliasSB1)->B1_COD)) // faz esse posicionamento apenas para poder usar o FM_PRODSBZ corretamente, porque sem o Posicionamento do SB5, quando o conteúdo é Branco, a fun~ção pode estar pegando de qualquer registro posicionado
		cLoc := FM_PRODSBZ((cAliasSB1)->B1_COD, "SB5->B5_LOCALI2")
		If !Empty(cLoc)
			(cAliasSB1)->(DbSkip())
			Loop
		Endif
		cGrp := (cAliasSB1)->B1_GRUPO
		cCod := (cAliasSB1)->B1_CODITE
		cDes := (cAliasSB1)->B1_DESC
		cQtd := (cAliasSB1)->QTD

		oSection2:PrintLine()

		DbSelectArea(cAliasSB1)

		(cAliasSB1)->(DbSkip())
	EndDo

	(cAliasSB1)->(dbCloseArea())
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ Ricardo Farinelli  º Data ³  05/07/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg
	Local _sAlias := Alias()
	Local aRegs   := {}
	Local i, j

	dbSelectArea("SX1")
	dbSetOrder(1)
	cPerg := "OFR320"
	cPerg := PADR(cPerg, LEN(SX1->X1_GRUPO))

	// Endereço De
	aAdd(aRegs, {cPerg, "02", STR0018, "", "", "MV_CH2", "C", 50, 0, 0, "G", "", "MV_PAR02", "", "", "", "", "", "", "", "",; // Endereço De
		"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})

	// Endereço Ate
	aAdd(aRegs, {cPerg, "03", STR0019, "", "", "MV_CH3", "C", 50, 0, 0, "G", "", "MV_PAR03", "", "", "", "", "", "", "", "",; // Endereço Ate
		"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})

	// Ordernar por: 
	aAdd(aRegs, {cPerg, "04", STR0027, "", "", "MV_CH4", "N",  1, 0, 1, "C", "", "MV_PAR04", STR0028, STR0028, STR0028, "", "", STR0029, STR0029, STR0029,; // Ordernar por: / Item / Locacao
		"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})

	For i := 1 to Len(aRegs)
		If !dbSeek(cPerg + aRegs[i,2])
			RecLock("SX1", .T.)

			For j := 1 to FCount()
				If j <= Len(aRegs[i])
					FieldPut(j, aRegs[i,j])
				EndIf
			Next

			MsUnlock()
		EndIf
	Next

	dbSelectArea(_sAlias)
Return