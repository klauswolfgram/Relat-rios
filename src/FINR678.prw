/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FINR678.CH"

/*/{Protheus.doc} FINR678
Relatorio de Status da Prestação de Contas.

@author Totvs
@since 05/11/2013
@version P11 R9

@return Nil
/*/
User Function FINR678()
Local oReport	:= Nil
Local lTReport	:= TRepInUse()
Local lDefTop	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Local lRet		:= .T.
Local cPerg		:= "FINR678"

If !lDefTop
	Help("  ",1,"FINR678TOP",,STR0001,1,0) //"Função disponível apenas para ambientes TopConnect"
	Return
EndIf

If !lTReport
	Help("  ",1,"FINR678R4",,STR0002,1,0) //"Função disponível apenas para TReport, por favor atualizar ambiente e verificar parametro MV_TREPORT"
	Return
ENdIf

lRet := Pergunte( cPerg , .T. )

If lRet
	oReport := ReportDef(cPerg)
	oReport:PrintDialog()
EndIf

Return

/*/{Protheus.doc} ReportDef
Definição da estrutura do relatório

@author Totvs
@since 05/11/2013
@version P11 R9

@param cPerg, caractere, Grupo de Perguntas

@return Objeto, objeto do TReport
/*/
Static Function ReportDef(cPerg)
Local oSection	:= Nil
Local oSection1	:= Nil
Local oBreak	:= Nil
Local oReport	:= Nil
Local oTotal	:= Nil
Local oBreak	:= Nil
Local cAliasFLF	:= GetNextAlias()
Local cReport	:= "FINR678"
Local cTitulo	:= STR0003 //"Status da Prestação de Contas"
Local cDescri	:= STR0004 //"Relatório para apresentar as prestações de contas com os dados mais relevantes."

						//cReport	,cTitle		,uParam	,bAction											,cDescription	,lLandscape	,uTotalText	,lTotalInLine	,cPageTText	,lPageTInLine	,lTPageBreak	,nColSpace
oReport := TReport():New(cReport	,cTitulo	,cPerg	,{|oReport| PrintReport(oReport,cPerg,cAliasFLF)}	,cDescri		,.T.		,			,.F.			,			,				,				,			)

							//oParent	,cTitle		,uTable	,aOrder	,lLoadCells	,lLoadOrder	,uTotalText	,lTotalInLine	,lHeaderPage	,lHeaderBreak	,lPageBreak	,lLineBreak	,nLeftMargin	,lLineStyle	,nColSpace	,lAutoSize	,cCharSeparator	,nLinesBefore	,nCols	,nClrBack	,nClrFore	,nPercentage
oSection := TRSection():New( oReport	,STR0005	,"FLF"	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Participante

			//oParent	,cName			,cAlias	,cTitle	,cPicture	,nSize	,lPixel	,bBlock	,cAlign	,lLineBreak	,cHeaderAlign	,lCellBreak	,nColSpace	,lAutoSize	,nClrBack	,nClrFore	,lBold
TRCell():New( oSection	,"FLF_PARTIC"	,"FLF"	,		,			,		,		,		,		,			,				,			,			,			,			,			,		) //Codigo do Participante
TRCell():New( oSection	,"RD0_NOME"		,"RD0"	,		,			,		,		,		,		,.T.		,				,			,			,.T.		,			,			,		) //Nome do participante

							//oParent	,cTitle		,uTable	,aOrder	,lLoadCells	,lLoadOrder	,uTotalText	,lTotalInLine	,lHeaderPage	,lHeaderBreak	,lPageBreak	,lLineBreak	,nLeftMargin	,lLineStyle	,nColSpace	,lAutoSize	,cCharSeparator	,nLinesBefore	,nCols	,nClrBack	,nClrFore	,nPercentage
oSection1 := TRSection():New( oSection	,STR0006	,"FLF"	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			)	//Prestacao de Contas

			//oParent	,cName			,cAlias	,cTitle	,cPicture	,nSize	,lPixel	,bBlock										,cAlign	,lLineBreak	,cHeaderAlign	,lCellBreak	,nColSpace	,lAutoSize	,nClrBack	,nClrFore	,lBold
TRCell():New( oSection1	,"FLF_STATUS"	,"FLF"	,		,			,20		,		,{|| U_FINR678STA((cAliasFLF)->FLF_STATUS)}	,		,			,				,			,			,			,			,			,		) //Status da prestacao
TRCell():New( oSection1	,"FLF_PRESTA"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Cod. Prestacao de Contas
TRCell():New( oSection1	,"FLF_EMISSA"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Data de Emissao
TRCell():New( oSection1	,"FLF_DTINI"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Data de Saida
TRCell():New( oSection1	,"FLF_DTFIM"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Data de chegada
TRCell():New( oSection1	,"FLF_CLIENT"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Codigo do Cliente
TRCell():New( oSection1	,"FLF_LOJA"		,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Loja do Cliente
TRCell():New( oSection1	,"A1_NOME"		,"SA1"	,		,			,		,		,											,		,.T.		,				,			,			,.T.		,			,			,		) //Nome do Cliente
TRCell():New( oSection1	,"FLF_TADIA1"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Valor adiantamento moeda 1
TRCell():New( oSection1	,"FLF_TDESP1"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Total de despesas
TRCell():New( oSection1	,"FLF_TVLRE1"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Total Valor reembonsável
TRCell():New( oSection1	,"FLF_CC"		,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //Centro de Custo
TRCell():New( oSection1	,"FLF_FATEMP"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //% Faturamento Empresa
TRCell():New( oSection1	,"FLF_FATCLI"	,"FLF"	,		,			,		,		,											,		,			,				,			,			,			,			,			,		) //% Faturamento do cliente

oBreak := TRBreak():New ( oSection ,oSection:Cell("FLF_PARTIC"), "Totais do Colaborador no Periodo")

TRFunction():New(oSection1:Cell("FLF_TADIA1"),/*cName*/, "SUM"/*cFunction*/,oBreak/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/,/*oParent*/,/*bCondition*/,/*lDisable*/,/*bCanPrint*/)
TRFunction():New(oSection1:Cell("FLF_TDESP1"),/*cName*/, "SUM"/*cFunction*/,oBreak/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/,/*oParent*/,/*bCondition*/,/*lDisable*/,/*bCanPrint*/)
TRFunction():New(oSection1:Cell("FLF_TVLRE1"),/*cName*/, "SUM"/*cFunction*/,oBreak/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/,/*oParent*/,/*bCondition*/,/*lDisable*/,/*bCanPrint*/)

Return oReport

/*/{Protheus.doc} PrintReport
Montagem da query

@author Totvs
@since 05/11/2013
@version P11 R9

@param oReport, objeto, objeto do TReport
@param cPerg, caractere, Grupo de Perguntas

@return Nil
/*/
Static Function PrintReport(oReport,cPerg,cAliasFLF)
Local oSection		:= oReport:Section(1)
Local oSection1	:= oReport:Section(1):Section(1)
Local cWhere		:= ""

If MV_PAR17 == 2 //Nacional
	cWhere += "AND FLF.FLF_NACION = '1' "
ElseIf MV_PAR17 == 3 //Internacional
	cWhere += "AND FLF.FLF_NACION = '2' "
EndIf
cWhere := "%" + cWhere + "%"

MakeSqlExp(cPerg)

BEGIN REPORT QUERY oSection

BeginSql alias cAliasFLF
	SELECT
		FLF_PRESTA,
		FLF_STATUS,
		FLF_PARTIC,
		FLF_FATEMP,
		FLF_CLIENT,
		FLF_LOJA,
		FLF_FATCLI,
		FLF_CC,
		FLF_DTINI,
		FLF_DTFIM,
		FLF_DTFECH,
		FLF_EMISSA,
		FLF_TDESP1,
		FLF_TVLRE1,
		FLF_TADIA1

	FROM
		%table:FLF% FLF

	WHERE
		FLF.FLF_FILIAL = %xfilial:FLF%
		AND FLF.FLF_PARTIC	BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
		AND FLF.FLF_PRESTA	BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
		AND FLF.FLF_EMISSA	BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
		AND FLF.FLF_CLIENT	BETWEEN %exp:MV_PAR07% AND %exp:MV_PAR09%
		AND FLF.FLF_LOJA	BETWEEN %exp:MV_PAR08% AND %exp:MV_PAR10%
		AND FLF.FLF_DTINI	BETWEEN %exp:MV_PAR11% AND %exp:MV_PAR12%
		AND FLF.FLF_DTFIM	BETWEEN %exp:MV_PAR13% AND %exp:MV_PAR14%
		AND FLF.FLF_CC		BETWEEN %exp:MV_PAR15% AND %exp:MV_PAR16%
		AND FLF.%notDel%
		%exp:cWhere%
	ORDER BY
		FLF_PARTIC,FLF_PRESTA
EndSql

END REPORT QUERY oSection

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter({|cParam| (cAliasFLF)->FLF_PARTIC == cParam},{|| (cAliasFLF)->FLF_PARTIC})

TRPosition():New(oSection,"RD0",1,{|| XFilial("RD0")+(cAliasFLF)->FLF_PARTIC })
TRPosition():New(oSection1,"SA1",1,{|| XFilial("SA1")+(cAliasFLF)->FLF_CLIENT+(cAliasFLF)->FLF_LOJA })

oSection:Print()

Return

/*/{Protheus.doc} FINR678STA
Função para identificar a descrição do status da prestação de contas

@author Totvs
@since 05/11/2013
@version P11 R9

@param cStatus, caractere, Status da prestação de contas

@return caratere, Descrição do status da prestação de contas
/*/
User Function FINR678STA(cStatus)
Local cDescStat := ""

Default cStatus := ""

Do Case

	Case cStatus == "1"
		cDescStat := STR0007 //"Em aberto"

	Case cStatus == "2"
		cDescStat := STR0008 //"Em conferência"

	Case cStatus == "3"
		cDescStat := STR0009 //"Com bloqueio"

	Case cStatus == "4"
		cDescStat := STR0010 //"Em avaliação"

	Case cStatus == "5"
		cDescStat := STR0011 //"Reprovada"

	Case cStatus == "6"
		cDescStat := STR0012 //"Aprovada"

	Case cStatus == "7"
		cDescStat := STR0013 //"Liberado pagto"

	Case cStatus == "8"
		cDescStat := STR0014 //"Finalizada"

EndCase

Return cDescStat