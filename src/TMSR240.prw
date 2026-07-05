/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR240.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} TMSR240
Imprime relacao de cargas reprocessadas por filial.

@author		Eduardo de Souza
@since		26/05/2006
@version	12
@return		NIL
/*/
//-------------------------------------------------------------------

User Function TMSR240()

Local oReport
Local aArea := GetArea()

// Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
A funcao estatica ReportDef devera ser criada para todos os relatorios 
que poderao ser agendados pelo usuario.

@author		Eduardo de Souza
@since		26/05/2006
@version	12
@return		NIL
/*/
//-------------------------------------------------------------------

Static Function ReportDef()

Local oReport
Local cAliasQry := GetNextAlias()
Local aOrdem    := {}

// Criacao do componente de impressao
// TReport():New
// ExpC1 : Nome do relatorio
// ExpC2 : Titulo
// ExpC3 : Pergunte
// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
// ExpC5 : Descricao
oReport:= TReport():New("TMSR240",STR0011,"TMR240", {|oReport| ReportPrint(oReport,cAliasQry)},STR0012) // "Cargas Reprocessadas por Filial" ### "Emite relacao de cargas reprocessadas por filial, conforme os parametros informados"
oReport:SetTotalInLine(.F.)

// Verifica as perguntas selecionadas
// mv_par01	 // Data Fechamento De
// mv_par02	 // Data Fechamento Ate
// mv_par03	 // Filial Origem De
// mv_par04	 // Filial Origem Ate
Pergunte(oReport:uParam,.F.)

// Criacao da secao utilizada pelo relatorio
// TRSection():New
// ExpO1 : Objeto TReport que a secao pertence
// ExpC2 : Descricao da seçao
// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
//         sera considerada como principal para a seção.
// ExpA4 : Array com as Ordens do relatório
// ExpL5 : Carrega campos do SX3 como celulas
//         Default : False
// ExpL6 : Carrega ordens do Sindex
//         Default : False

// Criacao da celulas da secao do relatorio
// TRCell():New
// ExpO1 : Objeto TSection que a secao pertence
// ExpC2 : Nome da celula do relatório. O SX3 será consultado
// ExpC3 : Nome da tabela de referencia da celula
// ExpC4 : Titulo da celula
//         Default : X3Titulo()
// ExpC5 : Picture
//         Default : X3_PICTURE
// ExpC6 : Tamanho
//         Default : X3_TAMANHO
// ExpL7 : Informe se o tamanho esta em pixel
//         Default : False
// ExpB8 : Bloco de código para impressao.
//         Default : ExpC2
Aadd( aOrdem, STR0013 ) // "Fil.Documento"

oDocto:= TRSection():New(oReport,STR0015,{"DUD","DT6"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oDocto:SetTotalInLine(.F.)
TRCell():New(oDocto,"DUD_FILDOC","DUD",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"QTDCTR"    ,""   ,STR0015   ,/*Picture*/, 4          ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_PESO"  ,"DT6",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_PESOM3","DT6",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_QTDVOL","DT6",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_VALMER","DT6",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_VALTOT","DT6",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRFunction():New(oDocto:Cell("QTDCTR"    ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_PESO"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_PESOM3"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_QTDVOL"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_VALMER"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oDocto:Cell("DT6_VALTOT"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/)

Return(oReport)

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios 
que poderao ser agendados pelo usuario.

@author		Eduardo de Souza
@since		25/05/2006
@version	12
@return		NIL
/*/
//-------------------------------------------------------------------

Static Function ReportPrint(oReport,cAliasQry)

Local cSerTms := StrZero(2,Len(DTQ->DTQ_SERTMS))

// Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

// Filtragem do relatório
// Query do relatório da secao 1
oReport:Section(1):BeginQuery()	

BeginSql Alias cAliasQry
	SELECT DUD_FILIAL, DUD_FILDOC, COUNT(DUD_DOC) QTDCTR, SUM(DT6_PESO) DT6_PESO, SUM(DT6_PESOM3) DT6_PESOM3,
	       SUM(DT6_QTDVOL) DT6_QTDVOL, SUM(DT6_VALMER) DT6_VALMER, SUM(DT6_VALTOT) DT6_VALTOT
	   FROM %table:DTQ% DTQ
	   JOIN %table:DUD% DUD
	      ON DUD_FILIAL = %xFilial:DUD%
	      AND DUD_FILORI = DTQ.DTQ_FILORI 
	      AND DUD_VIAGEM = DTQ.DTQ_VIAGEM 
	      AND DUD_FILDOC <> DUD.DUD_FILORI
	      AND DUD.%NotDel%
	   JOIN %table:DT6% DT6
	      ON DT6_FILIAL = %xFilial:DT6%
	      AND DT6_FILDOC = DUD_FILDOC 
	      AND DT6_DOC    = DUD_DOC 
	      AND DT6_SERIE  = DUD_SERIE 
	      AND DT6.%NotDel%
	   WHERE DTQ_FILIAL = %xFilial:DTQ%
			AND DTQ_DATFEC BETWEEN %Exp:DTOS(mv_par01)% AND %Exp:DTOS(mv_par02)%
			AND DTQ_FILORI BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
			AND DTQ_SERTMS = %Exp:cSerTms%
	      AND DTQ.%NotDel%
	GROUP BY DUD_FILIAL, DUD_FILDOC
EndSql 

// Metodo EndQuery ( Classe TRSection )
// Prepara o relatório para executar o Embedded SQL.
// ExpA1 : Array com os parametros do tipo Range
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

// Inicio da impressao do fluxo do relatório
oReport:SetMeter(DT6->(LastRec()))

oReport:Section(1):Print()

Return