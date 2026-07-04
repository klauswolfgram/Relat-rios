/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR160.ch"
#INCLUDE "topconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMSR160   ³ Autor ³Rodolfo K. Rosseto     ³ Data ³08/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de valores embarcados                    			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMSR160()

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
Local oFil
Local oViagem
Local oProd
Local cAliasQry   := GetNextAlias()
Local aArea       := GetArea()

oReport := TReport():New("TMSR160",STR0016,"TMR160", {|oReport| ReportPrint(oReport,cAliasQry)},STR0017)
oReport:SetTotalInLine(.F.)
Pergunte("TMR160",.F.)

oFil := TRSection():New(oReport,STR0018,{"DTQ"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oFil:SetTotalInLine(.F.)
oFil:SetPageBreak()
TRCell():New(oFil,"DTQ_FILORI"	,"DTQ",STR0019,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFil,"DESCFIL"		,"   ",STR0020,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DTQ_FILORI,"M0_CIDENT") })
TRCell():New(oFil,"ESTFIL"			,"   ",STR0021,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DTQ_FILORI,"M0_ESTENT") })

oViagem := TRSection():New(oFil,STR0022,{"DTQ","DUD"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oViagem:SetTotalInLine(.T.)
TRCell():New(oViagem,"DTQ_VIAGEM"	,"DTQ",STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_DATFEC"	,"DTQ",STR0023,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_HORFEC"	,"DTQ",STR0024,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DUD_FILDCA"	,"DTQ",STR0025,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRFunction():New(oViagem:Cell("DTQ_VIAGEM"),,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFil)

oProd := TRSection():New(oViagem,STR0027,{"SB1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oProd:SetTotalInLine(.F.)
TRCell():New(oProd,"B1_DESC"		,"SB1",STR0027,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProd,"DT6_VALTOT"	,"DT6",STR0028,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRFunction():New(oProd:Cell("DT6_VALTOT"),,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFil)

RestArea(aArea)

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

Local cStatus   := StrZero(3,Len(DTQ->DTQ_STATUS)) //Viagem Encerrada
Local cFilOri   := ''
Local cViagem   := ''
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao Viagens                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par05 == 2 //--Sintetico
	oReport:Section(1):Section(1):Section(1):Hide()
EndIf

oReport:Section(1):BeginQuery()

	BeginSql Alias cAliasQry
	
	SELECT *
	FROM 
	(

		SELECT DTQ_FILIAL, DTQ_FILORI, DUD_FILDCA, DTQ_VIAGEM, DTQ_DATFEC, DTQ_HORFEC, DTC_CODPRO,
				 B1_DESC, DT6_VALTOT
	
		FROM %table:DTQ% DTQ
	
   	JOIN %table:SB1% SB1
		ON B1_FILIAL = %xFilial:SB1%
		AND SB1.%NotDel%

   	JOIN %table:DTC% DTC
   	ON DTC_FILIAL = %xFilial:DTC%
   	AND DTC_CODPRO = B1_COD
   	AND DTC.%NotDel%

		JOIN %table:DT6% DT6
		ON DT6_FILIAL = %xFilial:DT6%
		AND DT6.%NotDel%

   	JOIN %table:DUD% DUD
   	ON DUD_FILIAL = %xFilial:DUD%
		AND DUD_FILDOC = DTC_FILDOC
		AND DUD_DOC    = DTC_DOC
		AND DUD_SERIE  = DTC_SERIE
		AND DUD_FILDOC = DT6_FILDOC
		AND DUD_DOC    = DT6_DOC
		AND DUD_SERIE  = DT6_SERIE
   	AND DUD.%NotDel%

		WHERE DTQ_FILIAL = %xFilial:DTQ%
			AND DTQ_FILORI = DUD_FILORI
			AND DTQ_VIAGEM = DUD_VIAGEM
			AND DTQ_FILORI BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
			AND DTQ_DATFEC BETWEEN %Exp:Dtos(mv_par03)% AND %Exp:Dtos(mv_par04)%
			AND DTQ_STATUS <> %Exp:cStatus%
			AND DTQ.%NotDel%
		
		UNION
		SELECT DTQ_FILIAL, DTQ_FILORI, DUD_FILDCA, DTQ_VIAGEM, DTQ_DATFEC, DTQ_HORFEC, DY4_CODPRO,
				 B1_DESC, DT6_VALTOT
	
		FROM %table:DTQ% DTQ
	
   		JOIN %table:SB1% SB1
		ON B1_FILIAL = %xFilial:SB1%
		AND SB1.%NotDel%

	   	JOIN %table:DY4% DY4
   		ON DY4_FILIAL = %xFilial:DY4%
	   	AND DY4_CODPRO = B1_COD
   		AND DY4.%NotDel%

		JOIN %table:DT6% DT6
		ON DT6_FILIAL = %xFilial:DT6%
		AND DT6.%NotDel%

   		JOIN %table:DUD% DUD
	   	ON DUD_FILIAL = %xFilial:DUD%
		AND DUD_FILDOC = DY4_FILDOC
		AND DUD_DOC    = DY4_DOC
		AND DUD_SERIE  = DY4_SERIE
		AND DUD_FILDOC = DT6_FILDOC
		AND DUD_DOC    = DT6_DOC
		AND DUD_SERIE  = DT6_SERIE
   		AND DUD.%NotDel%

		WHERE DTQ_FILIAL = %xFilial:DTQ%
			AND DTQ_FILORI = DUD_FILORI
			AND DTQ_VIAGEM = DUD_VIAGEM
			AND DTQ_FILORI BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
			AND DTQ_DATFEC BETWEEN %Exp:Dtos(mv_par03)% AND %Exp:Dtos(mv_par04)%
			AND DTQ_STATUS <> %Exp:cStatus%
			AND DTQ.%NotDel%		
	)AliasTmp ORDER BY DTQ_FILIAL, DTQ_FILORI, DTQ_VIAGEM, DTC_CODPRO

	EndSql

oReport:Section(1):EndQuery()

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter({ |cParam| (cAliasQry)->DTQ_FILORI == cParam },{ || (cAliasQry)->DTQ_FILORI })

oReport:Section(1):Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):Section(1):SetParentFilter({ |cParam| (cAliasQry)->DTQ_FILORI+(cAliasQry)->DTQ_VIAGEM == cParam },{ || (cAliasQry)->DTQ_FILORI+(cAliasQry)->DTQ_VIAGEM })

If mv_par05 == 1 //--Analitico
	oReport:Section(1):Print()
Else //-- Sintetico
	While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
		cFilOri := (cAliasQry)->DTQ_FILORI
		oReport:Section(1):Init()
		oReport:Section(1):PrintLine()

		oReport:Section(1):Section(1):Init()
		While !oReport:Cancel() .And. !(cAliasQry)->(Eof()) .And. (cAliasQry)->DTQ_FILORI == cFilOri
			cViagem := (cAliasQry)->DTQ_VIAGEM
			oReport:Section(1):Section(1):PrintLine()
		
			oReport:Section(1):Section(1):Section(1):Init()
			While !oReport:Cancel() .And. !(cAliasQry)->(Eof()) .And. (cAliasQry)->DTQ_FILORI == cFilOri ;
					.And. (cAliasQry)->DTQ_VIAGEM == cViagem
				oReport:Section(1):Section(1):Section(1):PrintLine()
				
				dbSelectArea(cAliasQry)
				dbSkip()
			EndDo
			oReport:Section(1):Section(1):Section(1):Finish()
		EndDo
   	oReport:Section(1):Section(1):Finish()
   	oReport:Section(1):Finish()
	EndDo
EndIf

oReport:SetMeter(DTQ->(LastRec()))

Return