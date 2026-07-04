/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR560.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMSR560   ³ Autor ³Rodolfo K. Rosseto     ³ Data ³10/05/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Romaneio de Entrega                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMSR560()

Local oReport
Local aArea := GetArea()

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf

RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oViagem
Local oVeiculo
Local oMotorista
Local oDocto
Local oObs
Local oAjudante
Local cAliasDUD   := GetNextAlias()

Private cItem   := ''
Private cFilOri := ''
Private cViagem := ''
Private cCodVei := ''

oReport := TReport():New("TMSR560",STR0001,"TMR560", {|oReport| ReportPrint(oReport,cAliasDUD)},STR0002,.T.) //"Romaneio de Entrega" ### "Este programa ira listar o Romaneio de Entrega"
oReport:SetTotalInLine(.F.)
Pergunte("TMR560",.F.)

oViagem := TRSection():New(oReport,STR0003,{"DUD","DTQ","DA8"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Viagem"
oViagem :SetTotalInLine(.F.)
oViagem :SetPageBreak()
TRCell():New(oViagem,"DUD_FILORI"	,"DUD",STR0004,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Fil.Ori."
TRCell():New(oViagem,"DUD_VIAGEM"	,"DUD",STR0003,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Viagem"
TRCell():New(oViagem,"DTQ_ROTA"		,"DTQ",STR0005,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Rota"
TRCell():New(oViagem,"DA8_DESC"		,"DTQ",STR0006,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descricao"

oVeiculo := TRSection():New(oViagem,STR0007,{"DA3","DUT"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //Veiculo
oVeiculo :SetTotalInLine(.F.)
TRCell():New(oVeiculo,"DA3_COD"		,"DA3",STR0007,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Veiculo"
TRCell():New(oVeiculo,"DA3_DESC"		,"DA3",STR0006,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descricao"
TRCell():New(oVeiculo,"DA3_PLACA"	,"DA3",STR0008,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Placa"
TRCell():New(oVeiculo,"DA3_CAPACM"	,"DA3",STR0009,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Capacidade"
TRCell():New(oVeiculo,"DUT_DESCRI"	,"DUT",STR0010,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/) //"Tipo Veic"
TRCell():New(oVeiculo,"KMSAIDA"		,"   ",STR0011,/*Picture*/,20,/*lPixel*/,{|| "____________________" }) //"Km Saida"
TRCell():New(oVeiculo,"KMCHEGADA"	,"   ",STR0012,/*Picture*/,20,/*lPixel*/,{|| "____________________" }) //"Km Chegada"

oMotorista := TRSection():New(oVeiculo,STR0013,{"DA4"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //Motorista
oMotorista :SetTotalInLine(.F.)
TRCell():New(oMotorista,"DA4_NREDUZ","DA4",STR0013,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Motorista"

oAjudante := TRSection():New(oVeiculo,STR0014,{"DAU"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //Ajudante
oAjudante :SetTotalInLine(.F.)
TRCell():New(oAjudante,"DAU_NREDUZ","DAU",STR0014,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Ajudante"

oDocto := TRSection():New(oViagem,STR0015,{"DUD","SA1","DT6"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/,,,,,,.T.) //"Documentos"
oDocto :SetTotalInLine(.F.)
TRCell():New(oDocto,"DUD_FILDOC"	,"DUD",STR0004,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Fil.Ori."
TRCell():New(oDocto,"DUD_DOC"		,"DUD",STR0016,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Documento"
TRCell():New(oDocto,"DUD_SERIE"	,"DUD",STR0017,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Serie"
TRCell():New(oDocto,"A1_NOME"		,"DUD",STR0018,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Cliente"
TRCell():New(oDocto,"A1_END"		,"DUD",STR0019,/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.) //"Endereco"
TRCell():New(oDocto,"A1_BAIRRO"	,"DUD",STR0020,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.) //"Bairro"
TRCell():New(oDocto,"A1_MUN"	,"DUD",STR0028,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.) //"Municipio"
TRCell():New(oDocto,"A1_EST"	,"DUD",STR0029,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"UF"
TRCell():New(oDocto,"DT6_QTDVOL"	,"DUD",STR0021,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Vols."
TRCell():New(oDocto,"DT6_PESO"	,"DUD",STR0022,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Peso"
TRCell():New(oDocto,"DT6_PESOM3"	,"DUD",STR0026,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Peso Cubado"
TRCell():New(oDocto,"DT6_VALTOT"	,"DUD",STR0027,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor Total"

TRFunction():New(oDocto:Cell("DUD_DOC")		,,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_PESO")		,,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_PESOM3")	,,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_QTDVOL")	,,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_VALTOT")	,,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

oObs := TRSection():New(oViagem,STR0023,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Observacao"
oObs :SetTotalInLine(.F.)
TRCell():New(oObs,"OBSVIAGEM"	,"   ",STR0025,/*Picture*/,80,/*lPixel*/,{|| If(!Empty((cAliasDUD)->DTQ_CODOBS),MSMM((cAliasDUD)->DTQ_CODOBS),"") }) //"Obs Viagem"

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo Riera          ³ Data ³04.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasDUD)

Local cAliasDA3   := ''
Local cAliasDA4   := ''
Local cAliasDAU   := ''
Local cAliasDocto := ''
Local aMot        := {}
Local aAju        := {}
Local nCont       := 0
Local nCol        := 0
Local lTercRbq    := DTR->(ColumnPos("DTR_CODRB3")) > 0
Local cInDOCTMS   := ""


// Verifica se o MV_PAR02 referente aos tipos de documento existe e monta a string com os valores
If ValType(MV_PAR02) == "C"
	cInDOCTMS := StrInDcTms(MV_PAR02)
EndIf

// Caso a String de valores esteja vazia prenche com os valores antigos da rotina --> Compatibilidade
If Empty(cInDOCTMS)
	cInDOCTMS := "'2','5'"
EndIf

// Trata para correto funcionamento com o BeginSql
cInDOCTMS := '%' + cInDOCTMS + '%'


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Viagens				                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()

	BeginSql Alias cAliasDUD

		SELECT DUD_FILORI, DUD_VIAGEM, MIN(DTQ_ROTA) DTQ_ROTA, MIN(DA8_DESC) DA8_DESC, MIN(DTQ_CODOBS) DTQ_CODOBS
	
		FROM %table:DUD% DUD, %table:DA8% DA8, %table:DTQ% DTQ, %table:DT6% DT6

		WHERE DUD_FILIAL  = %xFilial:DUD%
			AND DUD_VIAGEM <> ' '
	  		AND DTQ_FILIAL = %xFilial:DTQ%
			AND DA8_FILIAL = %xFilial:DA8%
	  		AND DTQ_ROTA   = DA8_COD
			AND DTQ_VIAGEM = DUD_VIAGEM
			AND DT6_FILIAL = %xFilial:DT6%
			AND DT6_FILDOC = DUD_FILDOC
			AND DT6_DOC    = DUD_DOC
			AND DT6_SERIE  = DUD_SERIE
			AND DT6_DOCTMS IN (%exp:cInDOCTMS%)
			AND DT6.%NotDel%
			AND DUD.%NotDel%
			AND DTQ.%NotDel%
			AND DA8.%NotDel%

			GROUP BY DUD_FILORI, DUD_VIAGEM, DTQ_ROTA, DA8_DESC
			
	EndSql 

oReport:Section(1):EndQuery({MV_PAR01}/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Veiculos            					         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oReport:Section(1):Section(1)

	cAliasDA3 := GetNextAlias()
	If lTercRbq
		BeginSql Alias cAliasDA3
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DA3% DA3, %table:DTR% DTR
		
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3.%NotDel%
				AND DA3_COD = DTR_CODVEI
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDUD)->DUD_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDUD)->DUD_VIAGEM%
				AND DTR.%NotDel%
	  		
			UNION ALL	
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI,
					 DTR_VIAGEM, DTR_ITEM, DTR_CODRB1 DTR_CODVEI
	
			FROM %table:DA3% DA3, %table:DTR% DTR
		
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3.%NotDel%
				AND DA3_COD = DTR_CODRB1
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDUD)->DUD_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDUD)->DUD_VIAGEM%
				AND DTR.%NotDel%
	
			UNION ALL
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI,
					 DTR_VIAGEM, DTR_ITEM, DTR_CODRB2 DTR_CODVEI
	
			FROM %table:DA3% DA3, %table:DTR% DTR
		
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3.%NotDel%
				AND DA3_COD = DTR_CODRB2
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDUD)->DUD_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDUD)->DUD_VIAGEM%
				AND DTR.%NotDel%
	
			UNION ALL
			
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI,
					 DTR_VIAGEM, DTR_ITEM, DTR_CODRB3 DTR_CODVEI
	
			FROM %table:DA3% DA3, %table:DTR% DTR
		
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3.%NotDel%
				AND DA3_COD = DTR_CODRB3
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDUD)->DUD_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDUD)->DUD_VIAGEM%
				AND DTR.%NotDel%
			ORDER BY DTR_FILIAL, DTR_ITEM
	
		EndSql 
	Else 
		BeginSql Alias cAliasDA3

			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DA3% DA3, %table:DTR% DTR
		
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3.%NotDel%
				AND DA3_COD = DTR_CODVEI
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDUD)->DUD_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDUD)->DUD_VIAGEM%
				AND DTR.%NotDel%
	  		
			UNION ALL	
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI,
					 DTR_VIAGEM, DTR_ITEM, DTR_CODRB1 DTR_CODVEI
	
			FROM %table:DA3% DA3, %table:DTR% DTR
		
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3.%NotDel%
				AND DA3_COD = DTR_CODRB1
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDUD)->DUD_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDUD)->DUD_VIAGEM%
				AND DTR.%NotDel%
	
			UNION ALL
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI,
					 DTR_VIAGEM, DTR_ITEM, DTR_CODRB2 DTR_CODVEI
	
			FROM %table:DA3% DA3, %table:DTR% DTR
		
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3.%NotDel%
				AND DA3_COD = DTR_CODRB2
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDUD)->DUD_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDUD)->DUD_VIAGEM%
				AND DTR.%NotDel%
			ORDER BY DTR_FILIAL, DTR_ITEM
	
		EndSql
	EndIf 
END REPORT QUERY oReport:Section(1):Section(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Motoristas            					         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oReport:Section(1):Section(1):Section(1)

	cAliasDA4 := GetNextAlias()

	BeginSql Alias cAliasDA4		

		SELECT DA4_NREDUZ

		FROM %table:DA4% DA4, %table:DUP% DUP

		WHERE DA4_FILIAL = %xFilial:DA4%
			AND DA4.%NotDel%
			AND DUP_FILIAL = %xFilial:DUP%
			AND DUP_FILORI = %report_param:cFilOri%
			AND DUP_VIAGEM = %report_param:cVIagem%
			AND DUP_CODVEI = %report_param:cCodVei%
			AND DUP_CODMOT = DA4_COD
			AND DUP.%NotDel%

	EndSql 

END REPORT QUERY oReport:Section(1):Section(1):Section(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Ajudantes            					         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oReport:Section(1):Section(1):Section(2)

	cAliasDAU := GetNextAlias()

	BeginSql Alias cAliasDAU

		SELECT DAU_NREDUZ

		FROM %table:DAU% DAU, %table:DUQ% DUQ

		WHERE DAU_FILIAL = %xFilial:DAU%
			AND DUQ_FILORI = %report_param:cFilOri%
			AND DUQ_VIAGEM = %report_param:cViagem%
			AND DUQ_CODVEI = %report_param:cCodVei%
			AND DUQ_CODAJU = DAU_COD
			AND DUQ.%NotDel%
			AND DAU.%NotDel%

	EndSql 

END REPORT QUERY oReport:Section(1):Section(1):Section(2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Documentos 		                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

BEGIN REPORT QUERY oReport:Section(1):Section(2)

	oReport:Section(1):Section(2):BeginQuery()

	cAliasDocto := GetNextAlias()

	BeginSql Alias cAliasDocto

		SELECT DUD_FILDOC, DUD_DOC, DUD_SERIE, A1_NOME, A1_END, A1_BAIRRO, A1_MUN, A1_EST, DT6_QTDVOL, DT6_PESO, DT6_PESOM3, DT6_VALTOT
	
			FROM %table:DT6% DT6, %table:DUD% DUD, %table:SA1% SA1

			WHERE DUD_FILIAL = %xFilial:DUD%
				AND DUD_FILORI = %report_param:(cAliasDUD)->DUD_FILORI%
				AND DUD_VIAGEM = %report_param:(cAliasDUD)->DUD_VIAGEM%
				AND DUD.%NotDel%
				AND DT6_FILIAL = %xFilial:DT6%
				AND DT6_FILDOC = DUD_FILDOC
				AND DT6_DOC = DUD_DOC
				AND DT6_SERIE = DUD_SERIE
				AND DT6_CLIDES = A1_COD
				AND DT6_LOJDES = A1_LOJA
				AND DT6.%NotDel%
				AND SA1.%NotDel%
			
	EndSql

END REPORT QUERY oReport:Section(1):Section(2)

TRPosition():New(oReport:Section(1):Section(1),"DUT",1,{|| xFilial("DUT")+(cAliasDA3)->DA3_TIPVEI })

oReport:SetMeter(DUD->(LastRec()))

dbSelectArea(cAliasDUD)
While !oReport:Cancel() .And. !(cAliasDUD)->(Eof())
	
	//Viagens		
	oReport:Section(1):Init()
	oReport:Section(1):PrintLine()
	oReport:Section(1):Finish()
               
	//Veiculos
	oReport:Section(1):Section(1):ExecSql()
	dbSelectArea(cAliasDA3)	
	While !oReport:Cancel() .And. !(cAliasDA3)->(Eof())
		cFilOri := (cAliasDA3)->DTR_FILORI
		cViagem := (cAliasDA3)->DTR_VIAGEM
		cCodVei := (cAliasDA3)->DTR_CODVEI
		cItem   := (cAliasDA3)->DTR_ITEM
		
		oReport:Section(1):Section(1):Init()		
		While cItem == (cAliasDA3)->DTR_ITEM
		
			oReport:Section(1):Section(1):PrintLine()

			dbSelectArea(cAliasDA3)
			(cAliasDA3)->(dbSkip())

      EndDo
      oReport:Section(1):Section(1):Finish()
      
		//Motoristas
		oReport:Section(1):Section(1):Section(1):ExecSql()
		dbSelectArea(cAliasDA4)
		While !oReport:Cancel() .And. !(cAliasDA4)->(Eof())
			oReport:Section(1):Section(1):Section(1):Init()
			oReport:Section(1):Section(1):Section(1):PrintLine()
			 
			Aadd(aMot,(cAliasDA4)->DA4_NREDUZ)
					
			dbSelectArea(cAliasDA4)
			(cAliasDA4)->(dbSkip())
				
		EndDo
		oReport:Section(1):Section(1):Section(1):Finish()
		
		//Ajudantes
		oReport:Section(1):Section(1):Section(2):ExecSql()
		dbSelectArea(cAliasDAU)
		While !oReport:Cancel() .And. !(cAliasDAU)->(Eof())
			oReport:Section(1):Section(1):Section(2):Init()
			oReport:Section(1):Section(1):Section(2):PrintLine()
			
			Aadd(aAju,(cAliasDAU)->DAU_NREDUZ)
				
			dbSelectArea(cAliasDAU)
			(cAliasDAU)->(dbSkip())
				
		EndDo
		oReport:Section(1):Section(1):Section(2):Finish()

	EndDo

	//Documentos
	oReport:Section(1):Section(2):ExecSql()
	dbSelectArea(cAliasDocto)
	While !oReport:Cancel() .And. !(cAliasDocto)->(Eof())
		oReport:Section(1):Section(2):Init()
		oReport:Section(1):Section(2):PrintLine()
				
		dbSelectArea(cAliasDocto)
		(cAliasDocto)->(dbSkip())
				
	EndDo
	oReport:Section(1):Section(2):Finish()
	
	//Impressao dos motoristas, com quebra a cada 3 motoristas
	If Len(aMot) > 0
   	oReport:SkipLine(2)
		oReport:PrintText(STR0024 + ":____________________",oReport:Row(),100) //"Data"
		nCol := 0
		For nCont := 1 to Len(aMot)
			nCol += 750 //Tamanho em Pixel
			oReport:PrintText(aMot[nCont] + ":_________________________",oReport:Row(),nCol)
			If Mod(nCont,3) == 0 .And. Len(aMot) <> nCont
				nCol := 0
				oReport:SkipLine(2)
				oReport:PrintText(STR0024 + ":____________________",oReport:Row(),100) //"Data"
			EndIf
		Next nCont
	EndIf

	//Impressao dos ajudantes, com quebra a cada 3 ajudantes
   If Len(aAju) > 0
		oReport:SkipLine(2)
		oReport:PrintText(STR0024 +":____________________",oReport:Row(),100) //"Data"
		nCol := 0
		For nCont := 1 to Len(aAju)
			nCol += 750 //Tamanho em Pixel
			oReport:PrintText(aAju[nCont] + ":_________________________",oReport:Row(),nCol)
			If Mod(nCont,3) == 0 .And. Len(aAju) <> nCont
				nCol := 0
				oReport:SkipLine(2)
				oReport:PrintText(STR0024 +":____________________",oReport:Row(),100) //"Data"
			EndIf
		Next nCont
	EndIf

	aMot := {}
	aAju := {}

	//Impressao da Observacao da Viagem
	oReport:Section(1):Section(3):Init()
	oReport:SkipLine()
	oReport:Section(1):Section(3):PrintLine()
	oReport:Section(1):Section(3):Finish()

	dbSelectArea(cAliasDUD)
	(cAliasDUD)->(dbSkip())
	oReport:IncMeter()
EndDo

Return

//+--------------------------------------------------------------------------
/*{Protheus.doc}
StrInDcTms
Description
Retorna os tipos de documento de transporte separado por ',' para utilização na clausula IN da query
@owner paulo.henrique
@author paulo.henrique
@since 22/12/2017
@param Params
		cEntrada =  Paramentro com itens de entrada
		
@return cRet = Condição convertida
@sample StrInDcTms(cEntrada)
@project Projects
@menu Menu
@version Version
@obs Obs
@history History
/*/
//+--------------------------------------------------------------------------
Static Function StrInDcTms(cEntrada)
	Local cRet       := ""          // Recebe o Retorno
	Local aItens     := {}          // Recebe os itens separados da string
	Local nCount     := 0           // Recebe o contador 1
	Local nCount2    := 0           // Recebe o contador 2
	Local nPos       := 0           // Recebe a posição do hifen
	Local aListaVal  := {}          // Recebe a lista de valores da função TMSValField
	Local cDe        := ""          // Recebe a string de busca De
	Local cAte       := ""          // Recebe a string de busca Ate
	Local nPosDe     := 0           // Recebe a Posição de busca De da lista de valores da função TMSValField
    Local nPosAte    := 0           // Recebe a Posição de busca Ate da lista de valores da função TMSValField 

	Default cEntrada := ""          // Recebe os valores de entrada

	// Busca os tipos de documento que fazem parte da impressão do romaneio de entrega
	aListaVal := TMSValField("TMSDOCROMANEIO",,,,.T.)
	
	// Caso não possua valores, considera todos os tipos
	If Empty(cEntrada)
		cEntrada := aListaVal[1][1] + "-" + aListaVal[Len(aListaVal)][1]
	EndIf

	aItens := StrTokArr2(cEntrada,';')
	
	// Varre o array de Itens
	For nCount:= 1 to Len(aItens)

		If !Empty(aItens[nCount])

			// Busca se existe o hifen no item
			If	(nPos := AT( '-', aItens[nCount] ) ) > 0

				// Busca os itens separados por hifen
				cDe  := ALLTRIM(SUBSTR( aItens[nCount], 1, nPos-1))
				cAte := ALLTRIM(SUBSTR( aItens[nCount], nPos+1))

				// busca no array do TMSValField as posição dos valores separados por hifen
				nPosDe  := Ascan( aListaVal, { |x| AllTrim(x[1]) == cDe })
				nPosAte := Ascan( aListaVal, { |x| AllTrim(x[1]) == cAte })

				// Varre o intervalo de valores separados por hifen	
				For nCount2 := nPosDe to nPosAte

					// Adiciona o valor na string de retorno
					cRet += "'"+ aListaVal[nCount2][1] +"'"

					// Adiciona a ','
					If nCount2 < nPosAte .AND. !Empty(aListaVal[nCount2+1][1])
						cRet += ","
					EndIf
				Next nCount2

			Else	
				// Adiciona o valor na string de retorno
				If AT( "'", aItens[nCount]  ) == 0
					cRet += "'"+ AllTrim(aItens[nCount]) +"'"
				Else
					cRet += aItens[nCount]
				EndIf
			EndIf

			// Adiciona a ','
			If nCount <  Len(aItens) .AND. !Empty(aItens[nCount+1])
				cRet += ","
			EndIf
		EndIf
	Next nCount

Return cRet
