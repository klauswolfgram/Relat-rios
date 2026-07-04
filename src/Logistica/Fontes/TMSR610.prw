/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TMSR610.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMSR610   ³ Autor ³Rodolfo K. Rosseto     ³ Data ³30/05/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao da Relacao de Agendamentos                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMSR610()

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
Local oAgend
Local oItens
Local oProd
Local cAliasQry   := GetNextAlias()

oReport := TReport():New("TMSR610",STR0001,"TMR610A", {|oReport| ReportPrint(oReport,cAliasQry)},STR0002)
oReport:SetTotalInLine(.F.)
Pergunte("TMR610A",.F.)

oAgend := TRSection():New(oReport,STR0003,{"DF0","DUE"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oAgend:SetPageBreak(.T.)
oAgend:SetTotalInLine(.F.)
TRCell():New(oAgend,"DF0_NUMAGE"	,"DF0",STR0003,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oAgend,"DF0_DATCAD"	,"DF0",STR0004,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oAgend,"DF0_CODSOL"	,"DF0",STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oAgend,"DUE_DDD"		,"DUE",STR0005,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oAgend,"DUE_TEL"		,"DUE",STR0006,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oAgend,"DUE_NOME"		,"DUE",STR0007,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oAgend,"DUE_CONTAT"	,"DUE",STR0008,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oAgend,"DUE_END"		,"DUE",STR0009,/*Picture*/,20,/*lPixel*/,{|| IIf(Empty((cAliasQry)->DF0_SEQEND),(cAliasQry)->DUE_END,(cAliasQry)->DUL_END) })
TRCell():New(oAgend,"DUE_BAIRRO"	,"DUE",STR0010,/*Picture*/,15,/*lPixel*/,{|| IIf(Empty((cAliasQry)->DF0_SEQEND),(cAliasQry)->DUE_BAIRRO,(cAliasQry)->DUL_BAIRRO) })
TRCell():New(oAgend,"DUE_MUN"		,"DUE",STR0011,/*Picture*/,10,/*lPixel*/,{|| IIf(Empty((cAliasQry)->DF0_SEQEND),(cAliasQry)->DUE_MUN,(cAliasQry)->DUL_MUN) })
TRCell():New(oAgend,"DUE_EST"		,"DUE",STR0012,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(Empty((cAliasQry)->DF0_SEQEND),(cAliasQry)->DUE_EST,(cAliasQry)->DUL_EST) })
TRCell():New(oAgend,"DUE_CEP"		,"DUE",STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(Empty((cAliasQry)->DF0_SEQEND),(cAliasQry)->DUE_CEP,(cAliasQry)->DUL_CEP) })

oItens := TRSection():New(oAgend,STR0014,{"DF1","SA1","DUT"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oItens:SetTotalInLine(.F.)
TRCell():New(oItens,"DF1_ITEAGE","DF1",STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"DF1_STACOL","DF1",STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"DF1_STAENT","DF1",STR0016,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"DF1_LOCCOL","DF1",STR0017,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"A1_NOME","SA1",STR0018,/*Picture*/,20,/*lPixel*/,{|| (cAliasQry)->NOMEREM })
TRCell():New(oItens,"A1_NOME","SA1",STR0019,/*Picture*/,20,/*lPixel*/,{|| (cAliasQry)->NOMEDES })
TRCell():New(oItens,"A1_MUN","SA1",STR0020,/*Picture*/,10,/*lPixel*/,{|| (cAliasQry)->MUNREM })
TRCell():New(oItens,"A1_MUN","SA1",STR0021,/*Picture*/,10,/*lPixel*/,{|| (cAliasQry)->MUNDES })
TRCell():New(oItens,"DF1_DATPRC","DF1",STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"DF1_HORPRC","DF1",STR0023,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"DF1_DATPRE","DF1",STR0024,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"DF1_HORPRE","DF1",STR0025,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"DUT_DESCRI","DUT",STR0026,/*Picture*/,10,/*lPixel*/,{|| (cAliasQry)->DUT_DESCRI })

oProd := TRSection():New(oItens,STR0027,{"DF2","SB1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oProd:SetTotalInLine(.F.)
TRCell():New(oProd,"B1_DESC"		,"SB1",STR0027,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProd,"DF2_CODEMB"	,"DF2",STR0028,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProd,"DF2_QTDVOL"	,"DF2",STR0029,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProd,"DF2_QTDUNI"	,"DF2",STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProd,"DF2_PESO"		,"DF2",STR0031,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProd,"DF2_PESOM3"	,"DF2",STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProd,"DF2_VALMER"	,"DF2",STR0033,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

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
Static Function ReportPrint(oReport,cAliasQry)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao Manifestos                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()

	BeginSql Alias cAliasQry

		SELECT DF0_NUMAGE, MAX(DF0_DATCAD) DF0_DATCAD, MAX(DF0_CODSOL) DF0_CODSOL, MAX(DUE_DDD) DUE_DDD, MAX(DUE_TEL) DUE_TEL, 
				 MAX(DF0_SEQEND) DF0_SEQEND, DF1_ITEAGE, MAX(DF1_STACOL) DF1_STACOL, MAX(DF1_STAENT) DF1_STAENT,
				 MAX(DF1_LOCCOL) DF1_LOCCOL, MAX(SA11.A1_NOME) NOMEREM, MAX(SA11.A1_MUN) MUNREM, 
				 MAX(SA12.A1_NOME) NOMEDES, MAX(SA12.A1_MUN) MUNDES, MAX(DF1_DATPRC) DF1_DATPRC, 
				 MAX(DF1_HORPRC) DF1_HORPRC, MAX(DF1_DATPRE) DF1_DATPRE, MAX(DF1_HORPRE) DF1_HORPRE, 
				 MAX(B1_DESC) B1_DESC, MAX(X5_DESCRI) X5_DESCRI, MAX(DF2_QTDVOL) DF2_QTDVOL, 
				 MAX(DF2_QTDUNI) DF2_QTDUNI, MAX(DF2_PESO) DF2_PESO, MAX(DF2_PESOM3) DF2_PESOM3,
				 MAX(DF2_VALMER) DF2_VALMER, MAX(DUT_DESCRI) DUT_DESCRI, MAX(DUE_NOME) DUE_NOME,
				 MAX(DUE_CONTAT) DUE_CONTAT, MAX(DUE_END) DUE_END, MAX(DUE_BAIRRO) DUE_BAIRRO,
				 MAX(DUE_MUN) DUE_MUN, MAX(DUE_EST) DUE_EST, MAX(DUE_CEP) DUE_CEP, MAX(DF0_SEQEND) DF0_SEQEND,
				 MAX(DUL_END) DUL_END, MAX(DUL_BAIRRO) DUL_BAIRRO, MAX(DUL_MUN) DUL_MUN, MAX(DUL_EST) DUL_EST,
				 MAX(DUL_CEP) DUL_CEP

		FROM %table:DF0% DF0

 		JOIN %table:DF1% DF1 ON
 		DF1_FILIAL = %xFilial:DF1%
 		AND DF1_NUMAGE = DF0_NUMAGE
 		AND DF1.%NotDel%
 		
 		JOIN %table:SA1% SA11 ON
 		SA11.A1_FILIAL = %xFilial:SA1%
 		AND SA11.A1_COD    = DF1_CLIREM
 		AND SA11.A1_LOJA   = DF1_LOJREM
 		AND SA11.%NotDel%
 		
 		JOIN %table:SA1% SA12 ON
		SA12.A1_FILIAL = %xFilial:SA1%
 		AND SA12.A1_COD    = DF1_CLIDES
 		AND SA12.A1_LOJA   = DF1_LOJDES
 		AND SA12.%NotDel%
 		
		JOIN %table:DUE% DUE ON
      DUE_FILIAL = %xFilial:DUE%
      AND DUE_CODSOL = DF0_CODSOL
      AND DUE.%NotDel%
 		
		LEFT JOIN %table:DF2% DF2 ON
 		DF2_FILIAL = %xFilial:DF2%
  		AND DF2_NUMAGE = DF1_NUMAGE
  		AND DF2_ITEAGE = DF1_ITEAGE
  		AND DF2.%NotDel%

		LEFT JOIN %table:DF5% DF5 ON
		DF5_FILIAL = %xFilial:DF5%
		AND DF5_NUMAGE = DF1_NUMAGE
		AND DF5_ITEAGE = DF1_ITEAGE
		AND DF5.%NotDel%

		LEFT JOIN %table:SB1% SB1 ON
		B1_FILIAL = %xFilial:SB1%
		AND B1_COD = DF2_CODPRO 
		AND SB1.%NotDel%

		LEFT JOIN %table:SX5% SX5 ON
		X5_FILIAL = %xFilial:SX5%
		AND X5_TABELA = 'MG'
		AND X5_CHAVE = DF2_CODEMB 
		AND SX5.%NotDel%

		LEFT JOIN %table:DUT% DUT ON
		DUT_FILIAL = %xFilial:DUT%
		AND DUT_TIPVEI = DF5_TIPVEI 
		AND DUT.%NotDel%
		
		LEFT JOIN %table:DUL% DUL ON
      DUL_FILIAL = %xFilial:DUL%
      AND DUL_CODSOL  = DF0_CODSOL
      AND DUL_SEQEND = DF0_SEQEND
      AND DUL.%NotDel%

		WHERE DF0.DF0_FILIAL = %xFilial:DF0%
			AND DF0_CODSOL BETWEEN %Exp:mv_par02% AND %Exp:mv_par03%
			AND DF0_STATUS BETWEEN %Exp:StrZero(mv_par05,Len(DF0->DF0_STATUS))% AND %Exp:StrZero(mv_par06,Len(DF0->DF0_STATUS))%

		GROUP BY DF0_FILIAL, DF0_NUMAGE, DF1_ITEAGE, DUT_DESCRI, B1_DESC, X5_DESCRI
		ORDER BY DF0_FILIAL, DF0_NUMAGE, DF1_ITEAGE, DUT_DESCRI, B1_DESC, X5_DESCRI

	EndSql

oReport:Section(1):EndQuery({MV_PAR01,MV_PAR04})

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter({ |cParam| DF0_NUMAGE == cParam },{ || (cAliasQry)->DF0_NUMAGE })
oReport:Section(1):Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):Section(1):SetParentFilter({ |cParam| (cAliasQry)->DF0_NUMAGE+(cAliasQry)->DF1_ITEAGE == cParam },{ || (cAliasQry)->DF0_NUMAGE+(cAliasQry)->DF1_ITEAGE })
oReport:Section(1):Print()

oReport:SetMeter(DF0->(LastRec()))

Return
