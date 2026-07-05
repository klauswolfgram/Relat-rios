/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR570.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMSR570   ³ Autor ³Rodolfo K. Rosseto     ³ Data ³23/05/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Romaneio de Coleta                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMSR570()

Local oReport
Local aArea   := GetArea()

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
Local oAjudante
Local oObs
Local cAliasDT6   := GetNextAlias()
Local cAliasDTQ   := GetNextAlias()

Private cFilOri   := ''
Private cViagem   := ''
Private cCodVei   := ''
Private cItem     := ''

oReport := TReport():New("TMSR570",STR0001,"TMR570", {|oReport| ReportPrint(oReport,cAliasDT6,cAliasDTQ)},STR0002) //"Romaneio de Coleta" ### "Este programa ira listar o Romaneio de Coleta"
oReport:SetTotalInLine(.F.)
Pergunte("TMR570",.F.)

oViagem := TRSection():New(oReport,STR0003,{"DTQ","DA8"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Viagem"
oViagem:SetTotalInLine(.F.)
oViagem :SetPageBreak()
TRCell():New(oViagem,"DTQ_FILORI"  	,"DTQ",STR0005,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Fil.Origem"
TRCell():New(oViagem,"DTQ_VIAGEM"  	,"DTQ",STR0003,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Viagem"
TRCell():New(oViagem,"DA8_COD"		,"DA8",STR0004,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Rota"
TRCell():New(oViagem,"DA8_DESC"		,"DA8",STR0006,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Praca Princ."

oVeiculo := TRSection():New(oViagem,STR0007,{"DTQ","DA3"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Veiculo"
oVeiculo:SetTotalInLine(.F.)
TRCell():New(oVeiculo,"DA3_COD"   	,"DA3",STR0007,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Veiculo"
TRCell():New(oVeiculo,"DA3_DESC"   	,"DA3",STR0008,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descricao"
TRCell():New(oVeiculo,"DA3_PLACA" 	,"DA3",STR0009,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Placa"
TRCell():New(oVeiculo,"DA3_CAPACM" 	,"DA3",STR0010,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Capacidade"
TRCell():New(oVeiculo,"DUT_DESCRI" 	,"DUT",STR0011,/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Tipo Veic"
TRCell():New(oVeiculo,"KMSAIDA" 		,"   ",STR0012,/*Picture*/,15/*Tamanho*/,/*lPixel*/,{|| "_______________" }) //"KM Saida"
TRCell():New(oVeiculo,"KMCHEGADA" 	,"   ",STR0013,/*Picture*/,15/*Tamanho*/,/*lPixel*/,{|| "_______________" }) //"KM Chegada"

oMotorista := TRSection():New(oVeiculo,STR0014,{"DA4"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Motorista"
oMotorista:SetTotalInLine(.F.)
TRCell():New(oMotorista,"DA4_NREDUZ","DA4",STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Motorista"

oAjudante := TRSection():New(oVeiculo,STR0015,{"DAU"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Ajudante"
oAjudante:SetTotalInLine(.F.)
TRCell():New(oAjudante,"DAU_NREDUZ"	,"DA4",STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Ajudante"

oDocumento := TRSection():New(oViagem,STR0016,{"DT6","DUE"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Documento"
oDocumento:SetTotalInLine(.F.)
TRCell():New(oDocumento,"DT6_FILDOC"  	,"DT6",STR0005,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Fil.Origem"
TRCell():New(oDocumento,"DT6_DOC"   	,"DT6",STR0016,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Documento"
TRCell():New(oDocumento,"DT6_SERIE"   	,"DT6",STR0017,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Serie"
TRCell():New(oDocumento,"DUE_NOME"  	,"DUE",STR0018,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Solicitante"
TRCell():New(oDocumento,"DUE_END"   	,"DUE",STR0019,/*Picture*/,15/*Tamanho*/,/*lPixel*/,{|| If(Empty((cAliasDT6)->DT5_SEQEND),(cAliasDT6)->DUE_END,(cAliasDT6)->DUL_END) }) //"Endereco"
TRCell():New(oDocumento,"DUE_BAIRRO"	,"DUE",STR0020,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If(Empty((cAliasDT6)->DT5_SEQEND),(cAliasDT6)->DUE_BAIRRO,(cAliasDT6)->DUL_BAIRRO) }) //"Bairro"
TRCell():New(oDocumento,"DT6_QTDVOL"  	,"DT6",STR0021,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Vols"
TRCell():New(oDocumento,"DT6_PESO"   	,"DT6",STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Peso"
TRCell():New(oDocumento,"CHEGADA"		,"   ",STR0023,/*Picture*/,14/*Tamanho*/,/*lPixel*/,{|| "____/____/____" }) //"Chegada"
TRCell():New(oDocumento,"HORACHEGADA"	,"   ",STR0024,/*Picture*/,9/*Tamanho*/,/*lPixel*/,{|| "____:____" }) //"Hora Chg"
TRCell():New(oDocumento,"SAIDA"			,"   ",STR0025,/*Picture*/,14/*Tamanho*/,/*lPixel*/,{|| "____/____/____" }) //"Saida"
TRCell():New(oDocumento,"HORASAIDA"		,"   ",STR0026,/*Picture*/,9/*Tamanho*/,/*lPixel*/,{|| "____:____" }) //"Hora Sai"

TRFunction():New(oDocumento:Cell("DT6_DOC"),/* cID */,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDocumento:Cell("DT6_PESO"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDocumento:Cell("DT6_QTDVOL"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)

oObs := TRSection():New(oViagem,STR0027,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Observacao"
oObs :SetTotalInLine(.F.)
TRCell():New(oObs,"OBSVIAGEM"	,"   ",STR0028,/*Picture*/,80,/*lPixel*/,{|| If(!Empty((cAliasDTQ)->DTQ_CODOBS),MSMM((cAliasDTQ)->DTQ_CODOBS),"") }) //"Obs Viagem"

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
Static Function ReportPrint(oReport,cAliasDT6,cAliasDTQ)

Local cAliasDA3 := ''
Local cAliasDAU := ''
Local cAliasDA4 := ''
Local aMot      := {}
Local aAju      := {}
Local nCont     := 0
Local lTercRbq  := DTR->(ColumnPos("DTR_CODRB3")) > 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Viagens                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()

BeginSql Alias cAliasDTQ

	SELECT DTQ_FILORI, DTQ_VIAGEM, DTQ_CODOBS, DA8_COD, DA8_DESC
	
	FROM %table:DTQ% DTQ, %table:DA8% DA8

		WHERE DTQ_FILIAL = %xFilial:DTQ%
			AND DTQ_FILORI = %Exp:cFilAnt%
			AND DTQ_SERTMS = '1' //Coleta
			AND DTQ.%NotDel%
  			AND DA8_FILIAL = %xFilial:DA8%  			
  			AND DA8_COD = DTQ_ROTA
  			AND DA8.%NotDel%
			
	EndSql 

oReport:Section(1):EndQuery({MV_PAR01})
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao 2 - Veiculos                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oReport:Section(1):Section(1)
	
	cAliasDA3 := GetNextAlias()
	If lTercRbq
		BeginSql Alias cAliasDA3
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DTR% DTR, %table:DA3% DA3
	
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3_COD = DTR_CODVEI
				AND DA3.%NotDel%		
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDTQ)->DTQ_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDTQ)->DTQ_VIAGEM%
				AND DTR.%NotDel%
	
			UNION ALL
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DTR% DTR, %table:DA3% DA3
	
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3_COD = DTR_CODRB1
				AND DA3.%NotDel%		
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDTQ)->DTQ_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDTQ)->DTQ_VIAGEM%
				AND DTR.%NotDel%
	
			UNION ALL
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DTR% DTR, %table:DA3% DA3
	
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3_COD = DTR_CODRB2
				AND DA3.%NotDel%		
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDTQ)->DTQ_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDTQ)->DTQ_VIAGEM%
				AND DTR.%NotDel%
				
			UNION ALL
			
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DTR% DTR, %table:DA3% DA3
	
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3_COD = DTR_CODRB3
				AND DA3.%NotDel%		
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDTQ)->DTQ_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDTQ)->DTQ_VIAGEM%
				AND DTR.%NotDel%
			ORDER BY DTR_FILIAL, DTR_ITEM
	
		EndSql
	Else
		BeginSql Alias cAliasDA3

			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DTR% DTR, %table:DA3% DA3
	
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3_COD = DTR_CODVEI
				AND DA3.%NotDel%		
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDTQ)->DTQ_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDTQ)->DTQ_VIAGEM%
				AND DTR.%NotDel%
	
			UNION ALL
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DTR% DTR, %table:DA3% DA3
	
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3_COD = DTR_CODRB1
				AND DA3.%NotDel%		
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDTQ)->DTQ_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDTQ)->DTQ_VIAGEM%
				AND DTR.%NotDel%
	
			UNION ALL
	
			SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI, 
					 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI
	
			FROM %table:DTR% DTR, %table:DA3% DA3
	
			WHERE DA3_FILIAL = %xFilial:DA3%
				AND DA3_COD = DTR_CODRB2
				AND DA3.%NotDel%		
				AND DTR_FILIAL = %xFilial:DTR%
				AND DTR_FILORI = %report_param:(cAliasDTQ)->DTQ_FILORI%
				AND DTR_VIAGEM = %report_param:(cAliasDTQ)->DTQ_VIAGEM%
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
			AND DUP_VIAGEM = %report_param:cViagem%
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
//³Query do relatório da secao - Documentos                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oReport:Section(1):Section(2)
	
	BeginSql Alias cAliasDT6

		SELECT DT6_FILDOC, DT6_DOC, DT6_SERIE, DT6_PESO, DT6_QTDVOL, DUE_NOME, DUE_END,
			    DUL_END, DUE_BAIRRO, DUL_BAIRRO, DT5_SEQEND

		FROM %table:DT6% DT6

		JOIN %table:DUD% DUD ON
			DUD_FILIAL = %xFilial:DUD%
			AND DUD_FILORI = %report_param:(cAliasDTQ)->DTQ_FILORI%
			AND DUD_VIAGEM = %report_param:(cAliasDTQ)->DTQ_VIAGEM%
			AND DUD.%NotDel%

		JOIN %table:DT5% DT5 ON
			DT5_FILIAL = %xFilial:DT5%
			AND DT5_FILDOC = DUD_FILDOC
			AND DT5_DOC    = DUD_DOC
			AND DT5_SERIE  = DUD_SERIE
			AND DT5.%NotDel%

		JOIN %table:DUE% DUE ON
			DUE_FILIAL  = %xFilial:DUE%
			AND DUE_CODSOL = DT5_CODSOL
			AND DUE.%NotDel%

		LEFT JOIN %table:DUL% DUL ON
			DUL_FILIAL = %xFilial:DUL%
			AND DUL_CODSOL = DT5_CODSOL
			AND DUL_SEQEND = DT5_SEQEND
			AND DUL.%NotDel%

		WHERE DT6_FILIAL = %xFilial:DT6%
			AND DT6_DOCTMS  = '1' //Coleta
			AND DT6_FILDOC  = DUD_FILDOC
			AND DT6_DOC     = DUD_DOC
			AND DT6_SERIE   = DUD_SERIE
			AND DT6.%NotDel%

	EndSql

END REPORT QUERY oReport:Section(1):Section(2)

TRPosition():New(oReport:Section(1):Section(1),"DUT",1,{|| xFilial("DUT")+(cAliasDA3)->DA3_TIPVEI })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(DTQ->(LastRec()))

dbSelectArea(cAliasDTQ)
While !oReport:Cancel() .And. !(cAliasDTQ)->(Eof())
	
	//Viagem
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
	dbSelectArea(cAliasDT6)
	While !oReport:Cancel() .And. !(cAliasDT6)->(Eof())
		oReport:Section(1):Section(2):Init()
		oReport:Section(1):Section(2):PrintLine()
				
		dbSelectArea(cAliasDT6)
		(cAliasDT6)->(dbSkip())
				
	EndDo
	oReport:Section(1):Section(2):Finish()
	
	//Impressao dos motoristas, com quebra a cada 3 motoristas
	If Len(aMot) > 0
   	oReport:SkipLine(2)
		oReport:PrintText("Data" + ":____________________",oReport:Row(),100) //"Data"
		nCol := 0
		For nCont := 1 to Len(aMot)
			nCol += 750 //Tamanho em Pixel
			oReport:PrintText(aMot[nCont] + ":_________________________",oReport:Row(),nCol)
			If Mod(nCont,3) == 0 .And. Len(aMot) <> nCont
				nCol := 0
				oReport:SkipLine(2)
				oReport:PrintText("Data" + ":____________________",oReport:Row(),100) //"Data"
			EndIf
		Next nCont
	EndIf

	//Impressao dos ajudantes, com quebra a cada 3 ajudantes
   If Len(aAju) > 0
		oReport:SkipLine(2)
		oReport:PrintText("Data" +":____________________",oReport:Row(),100) //"Data"
		nCol := 0
		For nCont := 1 to Len(aAju)
			nCol += 750 //Tamanho em Pixel
			oReport:PrintText(aAju[nCont] + ":_________________________",oReport:Row(),nCol)
			If Mod(nCont,3) == 0 .And. Len(aAju) <> nCont
				nCol := 0
				oReport:SkipLine(2)
				oReport:PrintText("Data" +":____________________",oReport:Row(),100) //"Data"
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

	dbSelectArea(cAliasDTQ)
	(cAliasDTQ)->(dbSkip())
	oReport:IncMeter()
EndDo

Return
