/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR460.CH"
#Include 'Protheus.ch' 

//-------------------------------------------------------------------
/*/{Protheus.doc} TMSR460
Resumo de Frete.

@author		Eduardo de Souza
@since		30/05/2006
@version	12
@return		NIL
/*/
//-------------------------------------------------------------------

User Function TMSR460()

Local oReport
Local aArea := GetArea()

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
A funcao estatica ReportDef devera ser criada para todos os relatorios 
que poderao ser agendados pelo usuario.

@author		Eduardo de Souza
@since		30/05/06
@version	12
@return		NIL
/*/
//-------------------------------------------------------------------

Static Function ReportDef()

Local oReport
Local cAliasQry := GetNextAlias()
Local aOrdem    := {}

oReport:= TReport():New( "TMSR460", STR0018, "TMR460", { |oReport| ReportPrint(oReport, cAliasQry) }, STR0019 ) // "Resumo de Frete" ### "Emite o resumo de Frete conforme os parametros informados"
oReport:SetTotalInLine(.F.)
oReport:SetLandscape()

// Verifica as perguntas selecionadas
// mv_par01	- Periodo De
// mv_par02	- Periodo Ate
// mv_par03	- Filial Origem De
// mv_par04	- Filial Origem Ate
// mv_par05	- Filial Destino De
// mv_par06	- Filial Destino Ate
// mv_par07	- Tipo de Transporte De
// mv_par08	- Tipo de Transporte Ate
// mv_par09	- Tipo de Relatorio (Analitico/Sintetico)
// mv_par10	- Imprime (Expedido/Recebido)
Pergunte( oReport:uParam, .F. )

Aadd( aOrdem, STR0020 ) // "Filial"

oFilial := TRSection():New(oReport,STR0021,{"DT6"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oFilial:SetTotalInLine(.F.)
oFilial:SetTotalText(STR0036) //-- "Total Origem"
oFilial:lReadOnly := .T.
TRCell():New(oFilial,"DT6_FILDOC","DT6",STR0021   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFilial,"DES_FILORI",""   ,STR0022   ,/*Picture*/,15/*Tamanho*/,/*lPixel*/, {|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DT6_FILDOC,"M0_FILIAL") } )
TRCell():New(oFilial,"EST_FILORI",""   ,STR0023   ,/*Picture*/,2 /*Tamanho*/,/*lPixel*/, {|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DT6_FILDOC,"M0_ESTENT") } )

oResumo := TRSection():New(oFilial,STR0041,{"DT6"},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oResumo:SetTotalInLine(.F.)
oResumo:lReadOnly := .T.
TRCell():New(oResumo,"DT6_FILDES","DT6",STR0038		,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oResumo,"DT6_TIPTRA",""   ,STR0025   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/, {|| Iif((cAliasQry)->DT6_TIPTRA=="1","R",Iif((cAliasQry)->DT6_TIPTRA=="2","A","F")) },,,,,,.F.)
TRCell():New(oResumo,"PESOPG"    ,""   ,STR0026   ,PesqPict("DT6","DT6_PESO"  ),TamSx3("DT6_PESO"  )[1]+TamSx3("DT6_PESO"  )[2],/*lPixel*/, {|| (cAliasQry)->PESOPG / If(mv_par11==1,1,1000) },"RIGHT",,"RIGHT",,,.F.)
TRCell():New(oResumo,"PESOAP"    ,""   ,STR0027   ,PesqPict("DT6","DT6_PESO"  ),TamSx3("DT6_PESO"  )[1]+TamSx3("DT6_PESO"  )[2],/*lPixel*/, {|| (cAliasQry)->PESOAP / If(mv_par11==1,1,1000) },"RIGHT",,"RIGHT",,,.F.)
TRCell():New(oResumo,"PESOTOT"   ,""   ,STR0028   ,PesqPict("DT6","DT6_PESO"  ),TamSx3("DT6_PESO"  )[1]+TamSx3("DT6_PESO"  )[2],/*lPixel*/, {|| ( (cAliasQry)->PESOPG + (cAliasQry)->PESOAP) / If(mv_par11==1,1,1000) },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"FREPG"     ,""   ,STR0029   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"PDGPG"     ,""   ,STR0030   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"IMPPG"     ,""   ,STR0031   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"DIFERPG"   ,""   ,STR0034   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"SUBTRBPG"  ,""   ,STR0035   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"TOTPG"     ,""   ,STR0028   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"FREAP"     ,""   ,STR0032   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"PDGAP"     ,""   ,STR0030   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"IMPAP"     ,""   ,STR0031   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"DIFERAP"   ,""   ,STR0034   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"SUBTRBAP"  ,""   ,STR0035   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumo,"TOTAP"     ,""   ,STR0028   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)

//-- O totalizador da pagina lEndPag deverá ser setado com .F. para controle de impressao do totalizador
TRFunction():New(oResumo:Cell("PESOPG"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("PESOAP"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("PESOTOT" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("FREPG"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("PDGPG"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("IMPPG"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("DIFERPG" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("SUBTRBPG"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("TOTPG"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("FREAP"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("PDGAP"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("IMPAP"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("DIFERAP" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("SUBTRBAP"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumo:Cell("TOTAP"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

oFilialA := TRSection():New(oReport,STR0033,{"DT6"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oFilialA:SetTotalInLine(.F.)
oFiliala:SetTotalText(STR0037) //-- "Total Destino"
oFilialA:lReadOnly := .T.
TRCell():New(oFilialA,"DT6_FILDES","DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFilialA,"DES_FILDES",""   ,STR0022   ,/*Picture*/,15/*Tamanho*/,/*lPixel*/, {|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DT6_FILDES,"M0_FILIAL") } )
TRCell():New(oFilialA,"EST_FILDES",""   ,STR0023   ,/*Picture*/,2 /*Tamanho*/,/*lPixel*/, {|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DT6_FILDES,"M0_ESTENT") } )

oResumoA := TRSection():New(oFilialA,STR0041,{"DT6"},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oResumoA:SetTotalInLine(.F.)
oResumoA:lReadOnly := .T.
TRCell():New(oResumoA,"DT6_FILDOC","DT6",STR0021   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oResumoA,"DT6_TIPTRA",""   ,STR0025   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/, {|| Iif((cAliasQry)->DT6_TIPTRA=="1","R",Iif((cAliasQry)->DT6_TIPTRA=="2","A","F")) },,,,,,.F.)
TRCell():New(oResumoA,"PESOPG"    ,""   ,STR0026   ,PesqPict("DT6","DT6_PESO"  ),TamSx3("DT6_PESO"  )[1]+TamSx3("DT6_PESO"  )[2],/*lPixel*/,{|| (cAliasQry)->PESOPG / If(mv_par11==1,1,1000) },"RIGHT",,"RIGHT",,,.F.)
TRCell():New(oResumoA,"PESOAP"    ,""   ,STR0027   ,PesqPict("DT6","DT6_PESO"  ),TamSx3("DT6_PESO"  )[1]+TamSx3("DT6_PESO"  )[2],/*lPixel*/,{|| (cAliasQry)->PESOAP / If(mv_par11==1,1,1000) },"RIGHT",,"RIGHT",,,.F.)
TRCell():New(oResumoA,"PESOTOT"   ,""   ,STR0028   ,PesqPict("DT6","DT6_PESO"  ),TamSx3("DT6_PESO"  )[1]+TamSx3("DT6_PESO"  )[2],/*lPixel*/, {|| ( (cAliasQry)->PESOPG + (cAliasQry)->PESOAP ) / If(mv_par11==1,1,1000) },"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"FREPG"     ,""   ,STR0029   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"PDGPG"     ,""   ,STR0030   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"IMPPG"     ,""   ,STR0031   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"DIFERPG"   ,""   ,STR0034   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"SUBTRBPG"  ,""   ,STR0035   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"TOTPG"     ,""   ,STR0028   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"FREAP"     ,""   ,STR0032   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"PDGAP"     ,""   ,STR0030   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"IMPAP"     ,""   ,STR0031   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"DIFERAP"   ,""   ,STR0034   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"SUBTRBAP"  ,""   ,STR0035   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)
TRCell():New(oResumoA,"TOTAP"     ,""   ,STR0028   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT",,,.T.)

//-- O totalizador da pagina lEndPag deverá ser setado com .T. para controle de impressao do totalizador
TRFunction():New(oResumoA:Cell("PESOPG"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("PESOAP"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("PESOTOT" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("FREPG"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("PDGPG"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("IMPPG"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("DIFERPG" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("SUBTRBPG"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("TOTPG"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("FREAP"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("PDGAP"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("IMPAP"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("DIFERAP" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("SUBTRBAP"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oResumoA:Cell("TOTAP"   ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

Return(oReport)

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios 
que poderao ser agendados pelo usuario.

@author		Eduardo de Souza
@since		30/05/06
@version	12
@param		
@return		NIL
/*/
//-------------------------------------------------------------------

Static Function ReportPrint(oReport,cAliasQry)

Local cFilAli := TMSR460Ali()
Local cSelect := ""
Local cWhere  := ""
Local cOrder  := ""
Local cTitulo := ""

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

If mv_par10 = 1 //--Expedido
	cTitulo := " " + STR0039 + " ( " + DtoC(mv_par01) + " a " + DtoC(mv_par02) + " ) "
ElseIf mv_par10 = 2 //--Recebido
	cTitulo := " " + STR0040 + " ( " + DtoC(mv_par01) + " a " + DtoC(mv_par02) + " ) "
EndIf
oReport:SetTitle(oReport:Title() + cTitulo)

If !Empty(cFilAli)
	cSelect := "%MAX(CASE WHEN DT6_FILDES IN (" + cFilAli + ") THEN DT6_FILDOC ELSE DT6_FILDES END ) DT6_FILDES,%"
Else
	cSelect := "%MAX(DT6_FILDES) DT6_FILDES,%"
EndIf

cWhere := "%"
If mv_par12 == 1
	cWhere += " AND F2_VALICM > 0 "
ElseIf mv_par12 == 2
	cWhere += " AND F2_VALISS > 0 "
EndIf
cWhere += "%"

//-- Ordem dos dados
cOrder := "%"
If mv_par10 == 1
	cOrder += " DT6_FILIAL, DT6_FILDOC, DT6_FILDES, DT6_TIPTRA "
ElseIf mv_par10 == 2 //-- Recebido
	cOrder += " DT6_FILIAL, DT6_FILDES, DT6_FILDOC, DT6_TIPTRA "
EndIf
cOrder += "%"

If mv_par10 == 1
	//-- Filtragem do relatório
	//-- Query do relatório da secao 1
	oReport:Section(1):BeginQuery()	
	BeginSql Alias cAliasQry
		SELECT DT6_FILIAL, DT6_FILDOC, DT6_FILDES, DT6_TIPTRA, 
		       SUM(CASE WHEN TIPFRE = '1' THEN PESO   ELSE 0 END ) PESOPG, 
		       SUM(CASE WHEN TIPFRE = '1' THEN VALFRE ELSE 0 END ) FREPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN VALPDG ELSE 0 END ) PDGPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN VALIMP ELSE 0 END ) IMPPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN DIFER  ELSE 0 END ) DIFERPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN SUBTRB ELSE 0 END ) SUBTRBPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN VALTOT ELSE 0 END ) TOTPG,
		       SUM(CASE WHEN TIPFRE = '2' THEN PESO   ELSE 0 END ) PESOAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN VALFRE ELSE 0 END ) FREAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN VALPDG ELSE 0 END ) PDGAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN VALIMP ELSE 0 END ) IMPAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN DIFER  ELSE 0 END ) DIFERAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN SUBTRB ELSE 0 END ) SUBTRBAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN VALTOT ELSE 0 END ) TOTAP 
		   FROM (
		        SELECT DT6_FILIAL, DT6_FILDOC, 
		               %Exp:cSelect%
		               DT6_TIPTRA, MAX(DT6_TIPFRE) TIPFRE, MAX(DT6_PESO) PESO, MAX(DT6_VALFRE) VALFRE,
		               MAX(DT6_VALIMP) VALIMP, MAX(DT6_VALTOT) VALTOT, MAX(F2_ICMSDIF) DIFER ,
		               MAX(F2_ICMSRET) SUBTRB,
		               MAX(CASE WHEN COALESCE (DT8_CODPAS, ' ') = ' '  THEN DT8_VALPAS ELSE 0 END ) VALPDG 
		           FROM %table:DT6% DT6 
		           JOIN %table:DT8% DT8 
		               ON DT8_FILIAL = %xFilial:DT8%
		               AND DT8_FILDOC = DT6_FILDOC 
		               AND DT8_DOC   = DT6_DOC 
		               AND DT8_SERIE = DT6_SERIE 
		               AND DT8.%NotDel%
		            JOIN %table:SF2% SF2 
		               ON F2_FILIAL   = DT6_FILDOC 
		               AND F2_DOC     = DT6_DOC 
		               AND F2_SERIE   = DT6_SERIE 
		               AND F2_CLIENTE = DT6_CLIDEV 
		               AND F2_LOJA    = DT6_LOJDEV 
		               AND SF2.%NotDel%
						   %Exp:cWhere%
		            WHERE DT6_FILIAL = %xFilial:DT6%
							AND DT6_FILDOC BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
							AND DT6_FILDES BETWEEN %Exp:mv_par05% AND %Exp:mv_par06%
							AND DT6_DATEMI BETWEEN %Exp:DtoS(mv_par01)% AND %Exp:DtoS(mv_par02)%
							AND DT6_TIPTRA BETWEEN %Exp:mv_par07% AND %Exp:mv_par08%
		               AND DT6.%NotDel%
		            GROUP BY DT6_FILIAL, DT6_FILDOC, DT6_DOC, DT6_SERIE, DT6_TIPTRA ) TOTAL 
		    GROUP BY DT6_FILIAL, DT6_FILDOC, DT6_FILDES, DT6_TIPTRA
		    ORDER BY %Exp:cOrder%
	EndSql 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
Else
	//-- Filtragem do relatório
	//-- Query do relatório da secao 1
	oReport:Section(2):BeginQuery()	
	BeginSql Alias cAliasQry
		SELECT DT6_FILIAL, DT6_FILDOC, DT6_FILDES, DT6_TIPTRA, 
		       SUM(CASE WHEN TIPFRE = '1' THEN PESO   ELSE 0 END ) PESOPG, 
		       SUM(CASE WHEN TIPFRE = '1' THEN VALFRE ELSE 0 END ) FREPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN VALPDG ELSE 0 END ) PDGPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN VALIMP ELSE 0 END ) IMPPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN DIFER  ELSE 0 END ) DIFERPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN SUBTRB ELSE 0 END ) SUBTRBPG,
		       SUM(CASE WHEN TIPFRE = '1' THEN VALTOT ELSE 0 END ) TOTPG,
		       SUM(CASE WHEN TIPFRE = '2' THEN PESO   ELSE 0 END ) PESOAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN VALFRE ELSE 0 END ) FREAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN VALPDG ELSE 0 END ) PDGAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN VALIMP ELSE 0 END ) IMPAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN DIFER  ELSE 0 END ) DIFERAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN SUBTRB ELSE 0 END ) SUBTRBAP,
		       SUM(CASE WHEN TIPFRE = '2' THEN VALTOT ELSE 0 END ) TOTAP 
		   FROM (
		        SELECT DT6_FILIAL, DT6_FILDOC, 
		               %Exp:cSelect%
		               DT6_TIPTRA, MAX(DT6_TIPFRE) TIPFRE, MAX(DT6_PESO) PESO, MAX(DT6_VALFRE) VALFRE,
		               MAX(DT6_VALIMP) VALIMP, MAX(DT6_VALTOT) VALTOT, MAX(F2_ICMSDIF) DIFER ,
		               MAX(F2_ICMSRET) SUBTRB,
					   MAX(CASE WHEN COALESCE (DT8_CODPAS, ' ') = ' '  THEN DT8_VALPAS ELSE 0 END ) VALPDG  
		           FROM %table:DT6% DT6 
		           JOIN %table:DT8% DT8 
		               ON DT8_FILIAL = %xFilial:DT8%
		               AND DT8_FILDOC = DT6_FILDOC 
		               AND DT8_DOC   = DT6_DOC 
		               AND DT8_SERIE = DT6_SERIE 
		               AND DT8.%NotDel%
		            JOIN %table:SF2% SF2 
		               ON F2_FILIAL   = DT6_FILDOC 
		               AND F2_DOC     = DT6_DOC 
		               AND F2_SERIE   = DT6_SERIE 
		               AND F2_CLIENTE = DT6_CLIDEV 
		               AND F2_LOJA    = DT6_LOJDEV 
		               AND SF2.%NotDel%
						   %Exp:cWhere%
		            WHERE DT6_FILIAL = %xFilial:DT6%
							AND DT6_FILDOC BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
							AND DT6_FILDES BETWEEN %Exp:mv_par05% AND %Exp:mv_par06%
							AND DT6_DATEMI BETWEEN %Exp:DtoS(mv_par01)% AND %Exp:DtoS(mv_par02)%
							AND DT6_TIPTRA BETWEEN %Exp:mv_par07% AND %Exp:mv_par08%
		               AND DT6.%NotDel%
		            GROUP BY DT6_FILIAL, DT6_FILDOC, DT6_DOC, DT6_SERIE, DT6_TIPTRA ) TOTAL 
		    GROUP BY DT6_FILIAL, DT6_FILDOC, DT6_FILDES, DT6_TIPTRA
		    ORDER BY %Exp:cOrder%
	EndSql 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)
EndIf

//-- Inicio da impressao do fluxo do relatório
oReport:SetMeter(DT6->(LastRec()))

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter( { |cParam| (cAliasQry)->DT6_FILDOC == cParam }, { || (cAliasQry)->DT6_FILDOC } )

oReport:Section(2):Section(1):SetParentQuery()
oReport:Section(2):Section(1):SetParentFilter( { |cParam| (cAliasQry)->DT6_FILDES == cParam }, { || (cAliasQry)->DT6_FILDES } )

If mv_par10 == 1 //-- Expedido
	If mv_par09 == 2 //--Sintetico
		//--Estes titulos precisam estar em branco pois na immpressao do relatorio
		//do tipo Sintetico nao pode aparecer a descricao destes tres campos
		oReport:Section(1):Section(1):Cell("DT6_FILDES"):SetTitle("")
		oReport:Section(1):Section(1):Cell("DT6_TIPTRA"):SetTitle("")
		oReport:Section(1):Section(1):Hide()
	EndIf
	oReport:Section(1):Print()
ElseIf mv_par10 == 2 //-- Recebido
	If mv_par09 == 2 //-- Sintetico
		//--Estes titulos precisam estar em branco pois na immpressao do relatorio
		//do tipo Sintetico nao pode aparecer a descricao destes tres campos
		oReport:Section(2):Section(1):Cell("DT6_FILDOC"):SetTitle("")
		oReport:Section(2):Section(1):Cell("DT6_TIPTRA"):SetTitle("")
		oReport:Section(2):Section(1):Hide()
	EndIf
	oReport:Section(2):Print()
EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} TMSR460Ali
Retorna as filiais validas

@author		Eduardo de Souza
@since		 01/06/2005
@version	12
@return		NIL
/*/
//-------------------------------------------------------------------

Static Function TMSR460Ali()

Local cFilAli  := ''
Local aAreaSM0 := SM0->(GetArea())
Local aFilAli  := {}

If SM0->(MsSeek(cEmpAnt))
	aFilAli:= FWAllFilial(,,SM0->M0_CODIGO)
		
	If Ascan( aFilAli, { |x| x == SM0->M0_CODIGO } ) == 0
		cFilAli += ",'" + SM0->M0_CODFIL + "'"
	EndIf	
EndIf

RestArea( aAreaSM0 )

Return SubStr(cFilAli,2)
