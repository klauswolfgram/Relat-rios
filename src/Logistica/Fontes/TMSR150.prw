/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR150.CH"
#include "protheus.ch"
#include "report.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMSR150   ³ Autor ³Rodolfo K. Rosseto     ³ Data ³09/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime ocorrencias de entrega por filial.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMSR150()

Local oReport
Local aArea := GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

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
Local oFilial
Local oOcorren
Local oTotFil
Local cAliasQry   := GetNextAlias()
Local cAliasTot   := GetNextAlias()

Pergunte("TMR150",.F.)

DEFINE REPORT oReport NAME "TMSR150" TITLE STR0016 DESCRIPTION STR0017 PARAMETER "TMR150" LANDSCAPE ACTION {|oReport| ReportPrint(oReport,cAliasQry,cAliasTot)}

	DEFINE SECTION oFilial OF oReport TITLE STR0024 TABLES "DUA"

		DEFINE CELL NAME "DUA_FILOCO" OF oFilial ALIAS "DUA"
		
	DEFINE SECTION oOcorren OF oFilial TITLE STR0022 TABLES "DUA" TOTAL IN COLUMN
		
		DEFINE CELL NAME "DUA_CODOCO" OF oOcorren ALIAS "DUA"
		DEFINE CELL NAME "DT2_DESCRI" OF oOcorren ALIAS "DT2"
		DEFINE CELL NAME "QTDTOTAL"	OF oOcorren ALIAS "   " TITLE STR0018	SIZE 3 BLOCK { || (cAliasQry)->MES+(cAliasQry)->ANT }
		DEFINE CELL NAME "QTDMES" 		OF oOcorren ALIAS "   " TITLE STR0019	SIZE 3 BLOCK { || (cAliasQry)->MES }
		DEFINE CELL NAME "QTDANTER" 	OF oOcorren ALIAS "   " TITLE STR0020	SIZE 3 BLOCK { || (cAliasQry)->ANT }
		DEFINE CELL NAME "PERC" 		OF oOcorren ALIAS "   " TITLE STR0021	SIZE 3 BLOCK { || ( ((cAliasQry)->MES+(cAliasQry)->ANT)/ U_TMSR150Cnt((cAliasQry)->DUA_FILOCO)) * 100 }

		DEFINE FUNCTION FROM oOcorren:Cell("QTDTOTAL") 	FUNCTION SUM NO END REPORT
		DEFINE FUNCTION FROM oOcorren:Cell("QTDMES") 	FUNCTION SUM NO END REPORT
		DEFINE FUNCTION FROM oOcorren:Cell("QTDANTER") 	FUNCTION SUM NO END REPORT
		DEFINE FUNCTION FROM oOcorren:Cell("PERC") 		FUNCTION SUM NO END REPORT
		
	DEFINE SECTION oTotFil OF oFilial TITLE STR0023 TABLES "DUA" TOTAL TEXT STR0023 TOTAL IN COLUMN

		DEFINE CELL NAME "DUA_CODOCO" OF oTotFil ALIAS "DUA" BLOCK { || (cAliasTot)->DUA_CODOCO }
		DEFINE CELL NAME "DT2_DESCRI" OF oTotFil ALIAS "DT2" TITLE STR0026
		DEFINE CELL NAME "QTDTOTAL"	OF oTotFil ALIAS "   " TITLE STR0018 	SIZE 3 BLOCK { || (cAliasTot)->MES+(cAliasTot)->ANT }
		DEFINE CELL NAME "QTDMES" 		OF oTotFil ALIAS "   " TITLE STR0019	SIZE 3 BLOCK { || (cAliasTot)->MES }
		DEFINE CELL NAME "QTDANTER" 	OF oTotFil ALIAS "   " TITLE STR0020	SIZE 3 BLOCK { || (cAliasTot)->ANT }
		DEFINE CELL NAME "PERC" 		OF oTotFil ALIAS "   " TITLE STR0021	SIZE 3 BLOCK { || Round((((cAliasTot)->MES+(cAliasTot)->ANT) / U_TMSR150Cnt()) * 100,2) }
		
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
Static Function ReportPrint(oReport,cAliasQry,cAliasTot)

Local cSerTms   := StrZero(3,Len(DT2->DT2_SERTMS)) // Entrega
Local cFilOco   := ''
Local cIniRef   := StrZero(MV_PAR02,4) + StrZero(MV_PAR01,2)+ "01"
Local cFimRef   := StrZero(MV_PAR02,4) + StrZero(MV_PAR01,2)+ "31"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao Ocorrencias                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oReport:Section(1)

	BeginSql Alias cAliasQry

	SELECT DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI, SUM(MES) MES, SUM(ANT) ANT
	FROM (
	SELECT DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI, COUNT(*) MES, 0 ANT
	
	FROM  %table:DUA% DUA
	
	JOIN  %table:DT2% DT2
	ON DT2_FILIAL = %xFilial:DT2%
	AND DT2_CODOCO = DUA_CODOCO
	AND DT2.%NotDel%
	
	JOIN  %table:DT6% DT6
	ON DT6_FILIAL = %xFilial:DT6%
	AND DT6_DATEMI BETWEEN %Exp:cIniRef% AND %Exp:cFimRef%
	AND DT6_FILDOC = DUA_FILDOC
	AND DT6_DOC = DUA_DOC
	AND DT6_SERIE = DUA_SERIE
	AND DT6.%NotDel%
	
	WHERE DUA_FILIAL = %xFilial:DUA%
		AND DUA_FILOCO BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
		AND DUA_SERTMS = %Exp:cSerTms%
		AND DUA.%NotDel%

	GROUP BY DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI
	
	UNION ALL
	SELECT DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI, 0 MES, COUNT(*) ANT
	
	FROM  %table:DUA% DUA
	
	JOIN  %table:DT2% DT2
	ON DT2_FILIAL = %xFilial:DT2%
	AND DT2_CODOCO = DUA_CODOCO
	AND DT2.%NotDel%
	
	JOIN  %table:DT6% DT6
	ON DT6_FILIAL = %xFilial:DT6%
	AND DT6_DATEMI < %Exp:cIniRef%
	AND DT6_FILDOC = DUA_FILDOC
	AND DT6_DOC = DUA_DOC
	AND DT6_SERIE = DUA_SERIE
	AND DT6.%NotDel%
	
	WHERE DUA_FILIAL = %xFilial:DUA%
		AND DUA_FILOCO BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
		AND DUA_SERTMS = %Exp:cSerTms%
		AND DUA.%NotDel%
	
	GROUP BY DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI ) QUERY
	GROUP BY DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI
	ORDER BY DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI
	
	EndSql

END REPORT QUERY oReport:Section(1)

BEGIN REPORT QUERY oReport:Section(1):Section(2)

	BeginSql Alias cAliasTot

	%noparser%
	
	SELECT DUA_FILIAL, DUA_CODOCO, DT2_DESCRI, SUM(MES) MES, SUM(ANT) ANT
	FROM (
	SELECT DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI, COUNT(*) MES, 0 ANT
	
	FROM  %table:DUA% DUA
	
	JOIN  %table:DT2% DT2
	ON DT2_FILIAL = %xFilial:DT2%
	AND DT2_CODOCO = DUA_CODOCO
	AND DT2.%NotDel%
	
	JOIN  %table:DT6% DT6
	ON DT6_FILIAL = %xFilial:DT6%
	AND DT6_DATEMI BETWEEN %Exp:cIniRef% AND %Exp:cFimRef%
	AND DT6_FILDOC = DUA_FILDOC
	AND DT6_DOC = DUA_DOC
	AND DT6_SERIE = DUA_SERIE
	AND DT6.%NotDel%
	
	WHERE DUA_FILIAL = %xFilial:DUA%
		AND DUA_FILOCO BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
		AND DUA_SERTMS = %Exp:cSerTms%
		AND DUA.%NotDel%

	GROUP BY DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI
	
	UNION ALL
	SELECT DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI, 0 MES, COUNT(*) ANT
	
	FROM  %table:DUA% DUA
	
	JOIN  %table:DT2% DT2
	ON DT2_FILIAL = %xFilial:DT2%
	AND DT2_CODOCO = DUA_CODOCO
	AND DT2.%NotDel%
	
	JOIN  %table:DT6% DT6
	ON DT6_FILIAL = %xFilial:DT6%
	AND DT6_DATEMI < %Exp:cIniRef%
	AND DT6_FILDOC = DUA_FILDOC
	AND DT6_DOC = DUA_DOC
	AND DT6_SERIE = DUA_SERIE
	AND DT6.%NotDel%
	
	WHERE DUA_FILIAL = %xFilial:DUA%
		AND DUA_FILOCO BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
		AND DUA_SERTMS = %Exp:cSerTms%
		AND DUA.%NotDel%
	
	GROUP BY DUA_FILIAL, DUA_FILOCO, DUA_CODOCO, DT2_DESCRI ) QUERY
	GROUP BY DUA_FILIAL, DUA_CODOCO, DT2_DESCRI
	ORDER BY DUA_FILIAL, DUA_CODOCO, DT2_DESCRI	
	
	EndSql

END REPORT QUERY oReport:Section(1):Section(2)

oReport:Section(1):Section(1):SetParentQuery()

oReport:SetMeter(DUA->(LastRec()))

dbSelectArea(cAliasQry)
If !(cAliasQry)->(Eof())
	While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
		cFilOco := (cAliasQry)->DUA_FILOCO
	
		oReport:Section(1):Init()
		oReport:Section(1):PrintLine()
		oReport:Section(1):Finish()
	
		oReport:Section(1):Section(1):Init()
		While !oReport:Cancel() .And. !(cAliasQry)->(Eof()) .And. (cAliasQry)->DUA_FILOCO == cFilOco
			oReport:Section(1):Section(1):PrintLine()
			dbSelectArea(cAliasQry)
			dbSkip()
		EndDo
		oReport:Section(1):Section(1):Finish()
	
	EndDo
	
	oReport:Skipline(1)
	oReport:PrintText(STR0027,oReport:Row(),10) //"Resumo Geral por Ocorrencia"
	oReport:PrintText("_____________________________",oReport:Row(),10)
	oReport:Skipline(1)
	
	oReport:Section(1):Section(2):Init()
	While !oReport:Cancel() .And. !(cAliasTot)->(Eof())
		oReport:Section(1):Section(2):PrintLine()
		dbSelectArea(cAliasTot)
		dbSkip()
	EndDo
	oReport:Section(1):Section(2):Finish()
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMSR150Cnt³ Autor ³Rodolfo K. Rosseto     ³ Data ³09/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Calculo das Quantidades por Filial e Total					     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Numerico                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 - Filial da Ocorrencia                                ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMSR150Cnt(cFilOco)

Local cSerTms      := StrZero(3,Len(DT2->DT2_SERTMS)) // Entrega
Local nQtdFil      := 0
Local cAliasTotFil := GetNextAlias()
Local cWhere       := ''
Local cGroup       := ''
Local cOrder       := ''
Local cFimRef      := StrZero(MV_PAR02,4) + StrZero(MV_PAR01,2)+ "31"

Default cFilOco    := ''

cWhere := "%"
If !Empty(cFilOco)
	cWhere += "AND DUA_FILOCO = '" + cFilOco + "' "
Else
	cWhere += "AND DUA_FILOCO BETWEEN '" +mv_par03+ "'  AND '" + mv_par04 + "' "
EndIf
cWhere += "%"

cGroup := "%"
If !Empty(cFilOco)
	cGroup += " DUA_FILIAL, DUA_FILOCO "
Else
	cGroup += " DUA_FILIAL "
EndIf
cGroup += "%"

cOrder := "%"
If !Empty(cFilOco)
	cOrder += " DUA_FILIAL, DUA_FILOCO "
Else
	cOrder += " DUA_FILIAL "
EndIf
cOrder += "%"

BeginSql Alias cAliasTotFil

	SELECT MIN(DUA_FILOCO), COUNT(*) TOTFIL

	FROM %table:DUA% DUA

	JOIN %table:DT2% DT2
	ON DT2_FILIAL  = %xFilial:DT2%
	AND DT2_CODOCO = DUA_CODOCO
	AND DT2.%NotDel%

	JOIN %table:DT6% DT6
	ON DT6_FILIAL  = %xFilial:DT6%
	AND DT6_DATEMI <= %Exp:cFimRef%
	AND DT6_FILDOC = DUA_FILDOC
	AND DT6_DOC    = DUA_DOC
	AND DT6_SERIE  = DUA_SERIE
	AND DT6.%NotDel%

	WHERE DUA_FILIAL  = %xFilial:DUA%
		AND DUA_SERTMS = %Exp:cSerTms%
		AND DUA.%NotDel%
		%Exp:cWhere%

	GROUP BY %Exp:cGroup%
	ORDER BY %Exp:cOrder%

EndSql

nQtdFil := (cAliasTotFil)->TOTFIL

Return nQtdFil