/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'
#Include 'FINR775.CH'


//-------------------------------------------------------------------
/*/{Protheus.doc} FINR775
Histórico de Movimentos

@author Totvs
@since 24/06/2015	
@version 11.80
/*/
//-------------------------------------------------------------------
User Function FINR775()
Local oReport		:= Nil
Local lTReport		:= TRepInUse()
Local lDefTop		:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Local lRet			:= .T.
Local cPerg			:= "FINR775"

If !lDefTop
	Help("  ",1,"FINR775TOP",,STR0001,1,0) //"Função disponível apenas para ambientes TopConnect"
	Return
EndIf

If !lTReport
	Help("  ",1,"FINR775R4",,STR0002,1,0) //"Função disponível apenas para TReport, por favor atualizar ambiente e verificar parametro MV_TREPORT"
	Return
EndIf

lRet := Pergunte( cPerg , .T. )

If lRet
	oReport := ReportDef(cPerg)
	oReport:PrintDialog()
EndIf

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definição de layout do relatório   

@author Totvs
@since 19/01/2015	
@version 11.80
/*/
//-------------------------------------------------------------------
Static Function ReportDef(cPerg)

Local oSection		:= Nil
Local oReport		:= Nil
Local oTotal		:= Nil
Local oBreak		:= Nil
Local cAliasFWA		:= GetNextAlias()
Local cReport		:= "FINR775"
Local cTitulo		:= STR0003//"Histórico de Movimentos"
Local cDescri		:= STR0004//"Relatório para apresentar os registros de movimentação do SERASA."

						//cReport	,cTitle		,uParam	,bAction											,cDescription	,lLandscape	,uTotalText	,lTotalInLine	,cPageTText	,lPageTInLine	,lTPageBreak	,nColSpace
oReport := TReport():New(cReport	,cTitulo	,cPerg	,{|oReport| PrintReport(oReport,cPerg,cAliasFWA)}	,cDescri		,.T.		,			,.F.			,			,				,				,			)

							//oParent	,cTitle		,uTable	,aOrder	,lLoadCells	,lLoadOrder	,uTotalText	,lTotalInLine	,lHeaderPage	,lHeaderBreak	,lPageBreak	,lLineBreak	,nLeftMargin	,lLineStyle	,nColSpace	,lAutoSize	,cCharSeparator	,nLinesBefore	,nCols	,nClrBack	,nClrFore	,nPercentage
oSection := TRSection():New( oReport	,			,"FWA"	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Participante
			//oParent	,cName			,cAlias	,cTitle	,cPicture	,nSize	,lPixel	,bBlock	,cAlign	,lLineBreak	,cHeaderAlign	,lCellBreak	,nColSpace	,lAutoSize	,nClrBack	,nClrFore	,lBold
TRCell():New( oSection	,"FWB_FILIAL"	,"FWB"	,		,			,		,		,		,		,		    ,				,			,			,	.T.	,			,			,		) //FILIAL
TRCell():New( oSection	,"FWA_NUM"		,"FWA"	,		,			,		,		,		,		,	    	,				,			,			,	.T.	,			,			,		) //NUMERO
TRCell():New( oSection	,"FWA_PARCEL"	,"FWA"	,		,			,		,		,		,		,	    	,				,			,			,	.T.	,			,			,		) //PARCELA
TRCell():New( oSection	,"FWA_TIPO"		,"FWA"	,		,			,		,		,		,		,	    	,				,			,			,	.T.	,			,			,		) //TIPO
TRCell():New( oSection	,"FWA_CLIENT"	,"FWA"	,		,			,		,		,		,		,	    	,				,			,			,	.T.	,			,			,		) //TIPO
TRCell():New( oSection	,"FWA_LOJA"		,"FWA"	,		,			,		,		,		,		,	    	,				,			,			,	.T.	,			,			,		) //TIPO
TRCell():New( oSection	,"FWB_DTOCOR"	,"FWB"	,		,			,		,		,		,		,	    	,				,			, 			,	.T.	,			,			,		) //DATA
TRCell():New( oSection	,"FWB_VALOR"	,"FWB"	,		,			,		,		,		,		,	    	,				,			,			,	.T.	,			,			,		) //VALOR
TRCell():New( oSection	,"FWB_OCORR"	,"FWB"	,		,			,		,		,		,		,	    	,				,			,			,	.T.	,			,			,		) //OCORRENCIA
TRCell():New( oSection	,"ERROR"		,		,STR0006,			,62		,		,	{|| U_F775GetDes(ERROR)}	,		,	    	,				,			,			,	.T.	,			,			,		) //ERRO


Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Rotina de Impressão de dados      

@author Totvs
@since 24/06/2015	
@version 11.80
/*/
//-------------------------------------------------------------------
Static Function PrintReport(oReport,cPerg,cAliasFWA)
Local oSection		:= oReport:Section(1)
Local cWhere:=cFil	:= ""
Local nX
Private aFilial := {}
//Seleciona filiais
If MV_PAR01 == 1 //Sim
	aFilial := AdmGetFil()
EndIf

//Filiais selecionadas.
If !Empty(aFilial)
	For nX := 1 To Len(aFilial)
		cFil += "'" + aFilial[nX] + "',"
	Next 
	cWhere += " AND FWA.FWA_FILIAL IN(" + Substr(cFil,1, Len(cFil) - 1 ) + ") "
Else
	cWhere += " AND FWA.FWA_FILIAL = '" + cFilAnt + "' "
EndIf

cWhere := "%" + cWhere + "%"
		
MakeSqlExp(cPerg)

BEGIN REPORT QUERY oSection

BeginSql alias cAliasFWA
	SELECT
		FWB.FWB_FILIAL,
		FWA.FWA_PREFIX,
		FWA.FWA_NUM,
		FWA.FWA_PARCEL,
		FWA.FWA_TIPO,
		FWA.FWA_CLIENT,
		FWA.FWA_LOJA,
		FWB.FWB_DTOCOR,
		FWB.FWB_VALOR,
		FWB.FWB_OCORR,
		FWB.FWB_CODERR AS ERROR
	FROM
		%table:FWA% FWA,
		%table:FWB% FWB
	WHERE
		(FWB.FWB_FILIAL = FWA.FWA_FILIAL AND FWB.FWB_IDDOC = FWA.FWA_IDDOC) AND
		FWB.FWB_DTOCOR	BETWEEN %exp:MV_PAR02% AND %exp:MV_PAR03% AND
		FWA.FWA_CLIENT	BETWEEN %exp:MV_PAR04% AND %exp:MV_PAR05% AND
		FWA.%notDel% AND FWB.%notDel%
		%exp:cWhere%
	ORDER BY
		FWA.FWA_NUM,FWA.FWA_PARCEL
	EndSql


END REPORT QUERY oSection

oSection:Print()

Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} F775GetDes
Recupera o texto do SX5 do erro de retorno do SERASA   

@author Totvs
@since 24/06/2015	
@version 12.1.6
/*/
//-------------------------------------------------------------------
User Function F775GetDes(cErro)

Local cDesc := ""

Default cErro := ""

dbSelectArea("SX5")

If SX5->(DbSeek(xFilial("SX5") + "QN" + cErro ))
	cDesc := cErro +' - '+ Alltrim(SX5->(X5Descri()))
EndIf

Return cDesc