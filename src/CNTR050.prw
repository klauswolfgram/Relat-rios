/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CNTR050.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Fun‡…o    ³ CNTR050  ³ Autor ³ Microsiga S/A         ³ Data ³23/04/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Listagem de Medicao X Notas Fiscais                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T. / .F.                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CNTR050()
	Local aArea 	:= GetArea()
	Local oReport
		
	oReport:= ReportDef()
	
	If(oReport <> Nil)
		oReport:PrintDialog()
	EndIf
	
	oReport := Nil
	RestArea(aArea)
Return

/*/±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Microsiga S/A         ³ Data ³23.04.2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
Static Function ReportDef()

Local oReport
Local oMedicao
Local oMedicao2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01         // Numero inicial da medicao ?          ³
//³ mv_par02         // Numero Final da medicao ?            ³
//³ mv_par03         // Numero inicial do contrato ?         ³
//³ mv_par04         // Numero final do contrato ?           ³
//³ mv_par05         // Codigo inicial do fornecedor ?       ³
//³ mv_par06         // Codigo final do fornecedor ?         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("CNT050",.F.)

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
oReport:= TReport():New("CNTR050",STR0001,"CNT050", {|oReport| ReportPrint(oReport)},STR0002) //"Este relatorio emite uma relacao de medicoes por notas fiscais geradas"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 1 - Medicao x Notas Fiscais - Compra                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMedicao := TRSection():New(oReport,STR0003,{"CND","CNE","SD1"})
oMedicao:SetTotalInLine(.F.)
oMedicao:SetNoFilter("SD1")
oMedicao:SetNoFilter("CNE")
oMedicao:SetReadOnly()

// Numero do Contrato
TRCell():New(oMedicao,'CND_CONTRA'	,'CND',STR0004+CRLF+STR0005,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
// Numero da Medicao
TRCell():New(oMedicao,'CND_NUMMED'	,'CND',STR0006+CRLF+STR0007,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
// Valor da Medicao
TRCell():New(oMedicao,'CNE_VLTOT'	,'CNE',STR0008+CRLF+STR0007,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
// Numero da Nota Fiscal
TRCell():New(oMedicao,'D1_DOC'		,'SD1',STR0009+CRLF+STR0010,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
// Serie da Nota Fiscal
TRCell():New(oMedicao,'D1_SERIE'	,'SD1',STR0011+CRLF+STR0010,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
// Valor Total da Nota Fiscal
TRCell():New(oMedicao,'D1_TOTAL'	,'SD1',STR0008+CRLF+STR0010,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
// Valor Total Pago (Titulo)
TRCell():New(oMedicao,'E2_SALDO'	,'SE2',STR0008+CRLF+STR0012,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
// Valor da Retencao (Titulo)
TRCell():New(oMedicao,'E2_RETCNTR'	,'SE2',STR0008+CRLF+STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

oMedicao:SetTotalText(STR0016)  //"Total Geral :"
TRFunction():New(oMedicao:Cell("CNE_VLTOT")	,NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oMedicao:Cell("D1_TOTAL")		,NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oMedicao:Cell("E2_SALDO")		,NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oMedicao:Cell("E2_RETCNTR")	,NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 2 - Medicao x Notas Fiscais - Venda                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMedicao2 := TRSection():New(oReport,STR0018,{"CND","CNE","SD2"})
oMedicao2:SetTotalInLine(.F.)
oMedicao2:SetNoFilter("SD2")
oMedicao2:SetNoFilter("CNE")
oMedicao2:SetEdit(.F.)
oMedicao2:SetReadOnly()

// Numero do Contrato
TRCell():New(oMedicao2,'CND_CONTRA'	,'CND',STR0004+CRLF+STR0005,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
// Numero da Medicao
TRCell():New(oMedicao2,'CND_NUMMED'	,'CND',STR0006+CRLF+STR0007,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
// Valor da Medicao
TRCell():New(oMedicao2,'CNE_VLTOT'	,'CNE',STR0008+CRLF+STR0007,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
// Numero da Nota Fiscal
TRCell():New(oMedicao2,'D2_DOC'		,'SD1',STR0009+CRLF+STR0010,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
// Serie da Nota Fiscal
TRCell():New(oMedicao2,'D2_SERIE'		,'SD1',STR0011+CRLF+STR0010,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
// Valor Total da Nota Fiscal
TRCell():New(oMedicao2,'D2_TOTAL'		,'SD1',STR0008+CRLF+STR0010,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
// Valor Total Pago (Titulo)
TRCell():New(oMedicao2,'E1_SALDO'		,'SE2',STR0008+CRLF+STR0012,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
// Valor da Retencao (Titulo)
TRCell():New(oMedicao2,'E1_RETCNTR'	,'SE2',STR0008+CRLF+STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")


oMedicao2:SetTotalText(STR0016)  //"Total Geral :"
TRFunction():New(oMedicao2:Cell("CNE_VLTOT")	,NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oMedicao2:Cell("D2_TOTAL")		,NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oMedicao2:Cell("E1_SALDO")		,NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oMedicao2:Cell("E1_RETCNTR")	,NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.)


Return(oReport)

/*/±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±³Programa  ³ReportPrin³ Autor ³ Microsiga S/A         ³ Data ³23.04.2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
Static Function ReportPrint(oReport)
	Local oMedicao := oReport:Section(1)
	Local oMedicao2:= oReport:Section(2)
	Local cAliasRel:= GetNextAlias()
	Local cAliasSE2:= GetNextAlias()
	Local cAliasSE1:= GetNextAlias()
	Local cNumDoc  := ''
	Local cSerie   := ''
	Local lFstCpr  := .T.
	Local lFstVnd  := .T.
	Local oBreak01
	Local oBreak02
	Local cFornece := ''
	Local cLoja    := ''
	Local nMoedaD  := 1
	Local dDataRef := IIF(Empty(MV_PAR09),dDataBase,MV_PAR09)
	Local nPorcent := 0
	Local cJoinCND:= "%" + FWJoinFilial("CND", "CNE") + "%"
	Local cJoinCN1:= "%" + FWJoinFilial("CN1", "CN9") + "%"
	Local cJoinSC7:= "%" + FWJoinFilial("SC7", "CNE") + "%"
	Local cJoinSD1:= "%" + FWJoinFilial("SD1", "SC7") + "%"	
	Local cJoinSC5:= "%" + FWJoinFilial("SC5", "CNE") + "%"
	Local cJoinSD2:= "%" + FWJoinFilial("SD2", "SC5") + "%"	
	Local cTipo   := ""
	Local cChave  := ""
	Local cRevAtu := Space(GetSx3Cache("CN9_REVATU","X3_TAMANHO"))
	Local cFilterUser := IIF(Empty(oMedicao:getSqlExp("CND")),"%%", "% AND " + oMedicao:getSqlExp("CND") + " %")
	Local nVlTotDoc := 0
	Local cQueryTit := ""
	Local oQuery := Nil
	Local jQueries := JsonObject():New()
	Local cChvMed := ""
	Local nCNEVlTot := 0

	// Quebra por Contrato
	If mv_par05 == 1
	
		// Sub-Totais por Contrato
		oBreak01 := TRBreak():New(oMedicao,oMedicao:Cell("CND_CONTRA"),STR0017,.F.) //"Sub-Total por Contrato :"
		TRFunction():New(oMedicao:Cell("CNE_VLTOT")	,NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oMedicao:Cell("D1_TOTAL")	,NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oMedicao:Cell("E2_SALDO")	,NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oMedicao:Cell("E2_RETCNTR"),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	
		// Sub-Totais por Contrato
		oBreak02 := TRBreak():New(oMedicao2,oMedicao2:Cell("CND_CONTRA"),STR0017,.F.) //"Sub-Total por Contrato :"
		TRFunction():New(oMedicao2:Cell("CNE_VLTOT")	,NIL,"SUM",oBreak02,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oMedicao2:Cell("D2_TOTAL")	,NIL,"SUM",oBreak02,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oMedicao2:Cell("E1_SALDO")	,NIL,"SUM",oBreak02,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
		TRFunction():New(oMedicao2:Cell("E1_RETCNTR"),NIL,"SUM",oBreak02,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	
	EndIf
	
	cTipo := "%' '"
	Do Case
		Case (MV_PAR06 == 2)//Compra
			cTipo += ",'1'%"
		Case (MV_PAR06 == 3)//Venda
			cTipo += ",'2'%"
		OtherWise //Ambos
			cTipo += ",'1','2'%"
	EndCase
	
	oMedicao:BeginQuery()
		BeginSql Alias cAliasRel
			
			SELECT CNE_FILIAL,CNE_CONTRA,CNE_NUMMED,CNE_NUMERO,D1_DOC DOC,D1_SERIE SERIE,D1_FORNECE FORCLI,D1_LOJA LOJA ,F1_VALMERC TOTAL,
			SUM(CNE_VLTOT) CNE_VLTOT,CNE_PEDIDO PEDIDO,CN1_ESPCTR,CND_MOEDA,CN9_MOEDA 
			 
			FROM %table:CNE% CNE
					
			INNER JOIN %table:CND% CND ON (%exp:cJoinCND% AND CND_NUMMED = CNE_NUMMED AND CND_CONTRA = CNE_CONTRA  
			AND CND_REVISA = CNE_REVISA AND CND.%NotDel%)
			
			INNER JOIN %table:CN9% CN9 ON (CN9_FILCTR = CND_FILCTR AND CN9_NUMERO = CND_CONTRA AND CN9_REVISA = CND_REVISA AND CN9.%NotDel%)
			INNER JOIN %table:CN1% CN1 ON (%exp:cJoinCN1% AND CN1_CODIGO = CN9_TPCTO AND CN1_ESPCTR IN (%Exp:cTipo%) AND CN1.%NotDel%)
			INNER JOIN %table:SC7% SC7 ON (%exp:cJoinSC7% AND C7_MEDICAO = CNE_NUMMED AND C7_NUM = CNE_PEDIDO AND C7_PLANILH = CNE_NUMERO AND C7_ITEMED = CNE_ITEM AND  SC7.%NotDel%)
			INNER JOIN %table:SD1% SD1 ON (%exp:cJoinSD1% AND D1_PEDIDO = C7_NUM AND D1_ITEMPC = C7_ITEM AND C7_FORNECE = D1_FORNECE AND C7_LOJA = D1_LOJA  AND SD1.%NotDel%)		
			
			INNER JOIN %table:SF1% SF1 ON (SD1.D1_FILIAL = SF1.F1_FILIAL AND D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND F1_FORNECE = D1_FORNECE AND F1_LOJA = D1_LOJA AND SF1.%NotDel%)		
			
			WHERE 
			CNE.%NotDel%
			AND (CNE_FILIAL = %xFilial:CNE%)
			AND (CNE_NUMMED >=  %Exp:MV_PAR03% AND CNE_NUMMED <=  %Exp:MV_PAR04%)
			AND (CNE_CONTRA >=  %Exp:MV_PAR01% AND CNE_CONTRA <=  %Exp:MV_PAR02%)
			AND (CN9_REVATU = %Exp:cRevAtu%)
			%exp:cFilterUser%

			GROUP BY 
			CNE_FILIAL, CNE_CONTRA, CNE_NUMMED, CNE_NUMERO, CND_MOEDA, CN9_MOEDA, CN1_ESPCTR,CNE_PEDIDO,D1_DOC, D1_SERIE,D1_FORNECE, D1_LOJA, F1_VALMERC 
			
			UNION
			
			SELECT CNE_FILIAL,CNE_CONTRA,CNE_NUMMED,CNE_NUMERO,D2_DOC DOC ,D2_SERIE SERIE, D2_CLIENTE FORCLI, D2_LOJA LOJA, SUM(D2_TOTAL) TOTAL,
			SUM(CNE_VLTOT) CNE_VLTOT,C5_NUM PEDIDO,CN1_ESPCTR,CND_MOEDA,CN9_MOEDA 
			 
			FROM %table:CNE% CNE
					
			INNER JOIN %table:CND% CND ON (%exp:cJoinCND% AND CND_NUMMED = CNE_NUMMED AND CND_CONTRA = CNE_CONTRA  
			AND CND_REVISA = CNE_REVISA AND CND.%NotDel%)
			
			INNER JOIN %table:CN9% CN9 ON (CN9_FILCTR = CND_FILCTR AND CN9_NUMERO = CND_CONTRA AND CN9_REVISA = CND_REVISA AND CN9.%NotDel%)
			INNER JOIN %table:CN1% CN1 ON (%exp:cJoinCN1% AND CN1_CODIGO = CN9_TPCTO AND CN1_ESPCTR IN (%Exp:cTipo%) AND CN1.%NotDel%)
			
			INNER JOIN %table:SC5% SC5 ON (%exp:cJoinSC5% AND C5_MDNUMED = CNE_NUMMED AND C5_MDPLANI = CNE_NUMERO AND SC5.%NotDel%)
			INNER JOIN %table:SC6% SC6 ON (SC6.C6_FILIAL = SC5.C5_FILIAL AND C5_CLIENT = C6_CLI AND C5_LOJACLI = C6_LOJA AND C6_NUM = C5_NUM AND C6_ITEMED = CNE_ITEM AND SC6.%NotDel%) 
			INNER JOIN %table:SD2% SD2 ON (%exp:cJoinSD2% AND D2_PEDIDO = C5_NUM AND D2_ITEMPV = C6_ITEM AND C5_CLIENT = D2_CLIENTE AND D2_LOJA = C5_LOJACLI AND SD2.%NotDel%)		
			
			WHERE 
			CNE.%NotDel%
			AND (CNE_FILIAL = %xFilial:CNE%)
			AND (CNE_NUMMED >=  %Exp:MV_PAR03% AND CNE_NUMMED <=  %Exp:MV_PAR04%)
			AND (CNE_CONTRA >=  %Exp:MV_PAR01% AND CNE_CONTRA <=  %Exp:MV_PAR02%)
			AND (CN9_REVATU = %Exp:cRevAtu%)
			%exp:cFilterUser%
			
			GROUP BY 
			CNE_FILIAL, CNE_CONTRA, CND_REVISA, CNE_NUMMED, CNE_NUMERO, D2_DOC, D2_SERIE,D2_CLIENTE, D2_LOJA, CND_MOEDA, CN9_MOEDA, C5_NUM, CN1_ESPCTR
			
			ORDER BY CN1_ESPCTR,CNE_CONTRA,CNE_NUMMED
			
		EndSql
	oMedicao:EndQuery()
	
	If MV_PAR07 == 4
		nMoedaD := mv_par08 + 1
		oReport:SetTitle(oReport:Title() +STR0019 + AllTrim(GetMv("MV_SIMB" +Ltrim(Str(nMoedaD)))) +")")
	EndIf
	
	(cAliasRel)->(dbGoTop())
	Do While !oReport:Cancel() .And. !(cAliasRel)->(Eof())

		If MV_PAR07 == 1
			nMoedaD := (cAliasRel)->CND_MOEDA
		ElseIf MV_PAR07 == 2
			nMoedaD := (cAliasRel)->CN9_MOEDA
		EndIf
	
		oReport:IncMeter()
	
		If ( (cAliasRel)->( CN1_ESPCTR == '1' .Or. Empty(CN1_ESPCTR) ) )
		
			If lFstCpr
				oMedicao:Init()
				lFstCpr := .F.
			EndIf

			nCNEVlTot := 0
			oMedicao:Cell('CND_CONTRA'):SetValue((cAliasRel)->CNE_CONTRA)
			oMedicao:Cell('CND_NUMMED'):SetValue((cAliasRel)->CNE_NUMMED)
			If (Empty(cChvMed) .Or. cChvMed != (cAliasRel)->(CNE_CONTRA + CNE_NUMMED) )
				cChvMed 	:= (cAliasRel)->(CNE_CONTRA + CNE_NUMMED)
				nCNEVlTot	:= Round(xMoeda((cAliasRel)->CNE_VLTOT,(cAliasRel)->CND_MOEDA,nMoedaD,dDataRef,6),GetSx3Cache('CNE_VLTOT','X3_TAMANHO'))
			EndIf
			oMedicao:Cell('CNE_VLTOT' ):SetValue(nCNEVlTot)
			
			If(Empty(cChave) .Or. cChave != (cAliasRel)->(DOC + SERIE + FORCLI + LOJA))
				cChave := (cAliasRel)->(DOC + SERIE + FORCLI + LOJA)
				cNumDoc := (cAliasRel)->DOC
				cSerie  := (cAliasRel)->SERIE
				cFornece:= (cAliasRel)->FORCLI
				cLoja   := (cAliasRel)->LOJA
				nPorcent:= (cAliasRel)->(CNE_VLTOT / TOTAL)
				
				If !(jQueries:HasProperty('query-se2'))
					//³Query utilizada para compor o valor total do titulo - SE2               ³
					cQueryTit := "SELECT SUM(E2_VALOR) E2_VALOR,SUM(E2_SALDO) E2_SALDO,SUM(E2_RETCNTR) E2_RETCNTR, E2_MOEDA
					cQueryTit += " FROM "+ RetSqlName("SE2") +" SE2"
					cQueryTit += " WHERE E2_FILIAL = ?"
					cQueryTit += " AND E2_NUM = ?"
					cQueryTit += " AND E2_PREFIXO = ?"
					cQueryTit += " AND E2_FORNECE = ?"
					cQueryTit += " AND E2_LOJA    = ?"
					cQueryTit += " AND SE2.D_E_L_E_T_ = ?"
					cQueryTit += " GROUP BY E2_PREFIXO,E2_NUM,E2_MOEDA"
					cQueryTit := ChangeQuery(cQueryTit)

					jQueries['query-se2'] := FWExecStatement():New(cQueryTit)
				EndIf
				oQuery := jQueries['query-se2'] 				
				oQuery:SetString(1, xFilial("SE2") )
				oQuery:SetString(2, cNumDoc)
				oQuery:SetString(3, cSerie)
				oQuery:SetString(4, cFornece)
				oQuery:SetString(5, cLoja)
				oQuery:SetString(6, Space(1))

				cAliasSE2 := oQuery:OpenAlias()

				nVlTotDoc := Round(xMoeda((cAliasRel)->TOTAL,1,nMoedaD,dDataRef,6),GetSx3Cache('D1_TOTAL','X3_TAMANHO'))
				If (cAliasSE2)->( !Eof() )
					Do While (cAliasSE2)->( !Eof() )					
						oMedicao:Cell('D1_DOC'    ):SetValue((cAliasRel)->DOC)
						oMedicao:Cell('D1_SERIE'  ):SetValue(cSerie)
						oMedicao:Cell('D1_TOTAL'  ):SetValue(nVlTotDoc)					
						oMedicao:Cell('E2_SALDO'  ):SetValue(Round(xMoeda((cAliasSE2)->( E2_VALOR - E2_SALDO ) * nPorcent,(cAliasSE2)->E2_MOEDA,nMoedaD,dDataRef,6),GetSx3Cache('E2_SALDO','X3_TAMANHO')))
						oMedicao:Cell('E2_RETCNTR'):SetValue(Round(xMoeda((cAliasSE2)->E2_RETCNTR,(cAliasSE2)->E2_MOEDA,nMoedaD,dDataRef,6),GetSx3Cache('E2_RETCNTR','X3_TAMANHO')))
						(cAliasSE2)->(dbSkip())
					EndDo		
				Else
					oMedicao:Cell('D1_DOC'    ):SetValue((cAliasRel)->DOC)
					oMedicao:Cell('D1_SERIE'  ):SetValue(cSerie)
					oMedicao:Cell('D1_TOTAL'  ):SetValue(nVlTotDoc)
					oMedicao:Cell('E2_SALDO'  ):SetValue(0)
					oMedicao:Cell('E2_RETCNTR'):SetValue(0)
				EndIf				
				(cAliasSE2)->(dbCloseArea())// Fecha o alias da query
			Else
				oMedicao:Cell('D1_DOC'    ):SetValue(PadC("-",GetSx3Cache('D1_DOC','X3_TAMANHO')))
				oMedicao:Cell('D1_SERIE'  ):SetValue(PadC("-",GetSx3Cache('D1_SERIE','X3_TAMANHO')))
				oMedicao:Cell('D1_TOTAL'  ):SetValue(0)
				oMedicao:Cell('E2_SALDO'  ):SetValue(0)
				oMedicao:Cell('E2_SALDO'  ):SetValue(0)
				oMedicao:Cell('E2_RETCNTR'):SetValue(0)
			EndIf			
			oMedicao:PrintLine()			
					
		Else
		
			If lFstVnd
				If !lFstCpr
					oMedicao:Finish()
					lFstCpr:=.T.
				EndIf
	
				oMedicao2:Init()
				lFstVnd := .F.
			EndIf

			nCNEVlTot := 0
			oMedicao2:Cell('CND_CONTRA'):SetValue((cAliasRel)->CNE_CONTRA)
			oMedicao2:Cell('CND_NUMMED'):SetValue((cAliasRel)->CNE_NUMMED)
			If (Empty(cChvMed) .Or. cChvMed != (cAliasRel)->(CNE_CONTRA + CNE_NUMMED) )
				cChvMed 	:= (cAliasRel)->(CNE_CONTRA + CNE_NUMMED)
				nCNEVlTot	:= Round(xMoeda((cAliasRel)->CNE_VLTOT,(cAliasRel)->CND_MOEDA,nMoedaD,dDataRef,6),GetSx3Cache('CNE_VLTOT','X3_TAMANHO'))
			EndIf
			oMedicao2:Cell('CNE_VLTOT' ):SetValue(nCNEVlTot)
			
			If(Empty(cChave) .Or. cChave != (cAliasRel)->(DOC + SERIE + FORCLI + LOJA))
				cChave := (cAliasRel)->(DOC + SERIE + FORCLI + LOJA)
				cNumDoc := (cAliasRel)->DOC
				cSerie  := (cAliasRel)->SERIE

				If !(jQueries:HasProperty('query-se1'))
					//³Query utilizada para compor o valor total do titulo - SE1
					cQueryTit := "SELECT SUM(E1_VALOR) E1_VALOR,SUM(E1_SALDO) E1_SALDO,SUM(E1_RETCNTR) E1_RETCNTR, E1_MOEDA"
					cQueryTit += " FROM "+ RetSqlName("SE1") +" SE1"
					cQueryTit += " WHERE E1_FILIAL = ?"
					cQueryTit += " AND E1_NUM = ?"
					cQueryTit += " AND E1_SERIE = ?"
					cQueryTit += " AND SE1.D_E_L_E_T_ = ?"
					cQueryTit += " GROUP BY E1_PREFIXO,E1_NUM,E1_MOEDA"
					cQueryTit := ChangeQuery(cQueryTit)

					jQueries['query-se1'] := FWExecStatement():New(cQueryTit)
				EndIf
				oQuery := jQueries['query-se1'] 				
				oQuery:SetString(1, xFilial("SE1") )
				oQuery:SetString(2, cNumDoc)
				oQuery:SetString(3, cSerie)				
				oQuery:SetString(4, Space(1))
				cAliasSE1 := oQuery:OpenAlias()		
				
				nVlTotDoc := Round(xMoeda((cAliasRel)->TOTAL,1,nMoedaD,dDataRef,6),GetSx3Cache('D1_TOTAL','X3_TAMANHO'))
				If (cAliasSE1)->( !Eof() )
					Do While (cAliasSE1)->( !Eof() )						
						oMedicao2:Cell('D2_DOC'    ):SetValue((cAliasRel)->DOC)
						oMedicao2:Cell('D2_SERIE'  ):SetValue(cSerie)
						oMedicao2:Cell('D2_TOTAL'  ):SetValue(nVlTotDoc)
						oMedicao2:Cell('E1_SALDO'  ):SetValue(Round(xMoeda((cAliasSE1)->E1_VALOR - (cAliasSE1)->E1_SALDO,(cAliasSE1)->E1_MOEDA,nMoedaD,dDataRef,6),GetSx3Cache('E1_SALDO','X3_TAMANHO')))
						oMedicao2:Cell('E1_RETCNTR'):SetValue(Round(xMoeda((cAliasSE1)->E1_RETCNTR,(cAliasSE1)->E1_MOEDA,nMoedaD,dDataRef,6),GetSx3Cache('E1_RETCNTR','X3_TAMANHO')))
						(cAliasSE1)->(dbSkip())
					EndDo					
				Else
					oMedicao2:Cell('D2_DOC'    ):SetValue((cAliasRel)->DOC)
					oMedicao2:Cell('D2_SERIE'  ):SetValue(cSerie)
					oMedicao2:Cell('D2_TOTAL'  ):SetValue(nVlTotDoc)
					oMedicao2:Cell('E1_SALDO'  ):SetValue(0)
					oMedicao2:Cell('E1_RETCNTR'):SetValue(0)
				EndIf
				(cAliasSE1)->(dbCloseArea())// Fecha o alias da query		
			Else
				oMedicao2:Cell('D2_DOC'    ):SetValue(PadC("-",GetSx3Cache('D2_DOC','X3_TAMANHO')))
				oMedicao2:Cell('D2_SERIE'  ):SetValue(PadC("-",GetSx3Cache('D2_SERIE','X3_TAMANHO')))
				oMedicao2:Cell('D2_TOTAL'  ):SetValue(0)
				oMedicao2:Cell('E1_SALDO'  ):SetValue(0)
				oMedicao2:Cell('E1_RETCNTR'):SetValue(0)
			EndIf
		 	oMedicao2:PrintLine()			
		EndIf
		
		(cAliasRel)->(dbSkip())
	EndDo
	
	If !lFstCpr
		oMedicao:Finish()
	EndIf
	
	If !lFstVnd
		oMedicao2:Finish()
	EndIf
Return
