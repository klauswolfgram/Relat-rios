/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "WMSR455.CH"
#INCLUDE "PROTHEUS.CH"

//--------------------------------------------------------
/*/{Protheus.doc} WMSR455
Saldo em Estoque.
@author felipe.m
@since 25/03/2015
@version 1.0
/*/
//--------------------------------------------------------
User Function WMSR455()
Local oReport

	// Permite efetuar validações, apresentar mensagem e abortar o programa quando desejado
	If !WMSChkPrg(FunName(),"3")
		Return Nil
	EndIf
	
	oReport:= ReportDef()
	oReport:PrintDialog()
Return Nil
//------------------------------------------------------------
//  Definições do relatório
//------------------------------------------------------------
Static Function ReportDef()
Local oReport, oSection1, oSection2, oBreak
Local aOrdem    := {STR0005,STR0006}  //  Armazem + Grupo + Produto   //  Produto + Armazem
Local cAliasD14 := GetNextAlias()

	// Criacao do componente de impressao
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao
	oReport:= TReport():New("WMSR455",STR0001,"MTR255", {|oReport| ReportPrint(oReport,cAliasD14)},STR0002+" "+STR0003+" "+STR0004) // Posicao Detalhada do Estoque por Endereco ##"Neste relat¢rio ‚ possivel obter uma posi‡„o de quantidade por  // produto/lote/endereco/status, o que permite o mapeamento perfeito  // de cada Endereco."
	oReport:SetColSpace(2)
	oReport:lParamPage := .F.
	// Variaveis utilizadas para parametros
	// MV_PAR01 Produto de
	// MV_PAR02 Produto ate
	// MV_PAR03 Situacao de
	// MV_PAR04 Situacao ate
	// MV_PAR05 Imprimir Normal/Ambos
	// MV_PAR06 Do Armazem
	// MV_PAR07 Ate o Armazem
	// MV_PAR08 Da Localizacao
	// MV_PAR09 Ate a Localizacao
	Pergunte(oReport:GetParam(),.F.)

	// Criacao das secoes utilizadas pelo relatorio
	// TRSection():New
	// ExpO1 : Objeto TReport que a secao pertence
	// ExpC2 : Descricao da seçao
	// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
	//           sera considerada como principal para a seção.
	// ExpA4 : Array com as Ordens do relatório
	// ExpL5 : Carrega campos do SX3 como celulas
	//           Default : False
	// ExpL6 : Carrega ordens do Sindex
	//           Default : False
	// Section1
	// TRSection:New(oParent,cTitle,uTable,aOrder,lLoadCells,lLoadOrder,uTotalText,lTotalInLine,lHeaderPage,lHeaderBreak,lPageBreak,lLineBreak,nLeftMargin,lLineStyle,nColSpace,lAutoSize,cCharSeparator,nLinesBefore,nCols,nClrBack,nClrFore,nPercentage)
	oSection1 := TRSection():New(oReport,STR0007,{"D14","SB1"},aOrdem,,,,,,,,,,,0) // Produtos
	oSection1:SetHeaderPage()

	// TRCell:New(oParent,cName,cAlias,cTitle,cPicture,nSize,lPixel,bBlock,cAlign,lLineBreak,cHeaderAlign,lCellBreak,nColSpace,lAutoSize,nClrBack,nClrFore,lBold)
	TRCell():New(oSection1,'D14_LOCAL' ,'D14')
	TRCell():New(oSection1,'B1_GRUPO'  ,'SB1')
	TRCell():New(oSection1,'BM_DESC'   ,'SBM')
	TRCell():New(oSection1,'D14_PRDORI','D14')
	TRCell():New(oSection1,'D14_PRODUT','D14')
	TRCell():New(oSection1,'B1_DESC'   ,'SB1')

	// Definindo a Quebra
	// TRBreak:New(oParent,uBreak,uTitle,lTotalInLine,cName,lPageBreak)
	oBreak := TRBreak():New(oSection1,{|| (cAliasD14)->(D14_PRDORI+D14_PRODUT) },STR0008,.F.) // "Total do Produto"
	// Posicionamento das tabelas
	// TRPosition:New(oParent,cAlias,uOrder,uFormula,lSeek)
	TRPosition():New(oSection1,"SBM",1,{|| xFilial("SBM") + (cAliasD14)->B1_GRUPO})

	// oSection2
	oSection2 := TRSection():New(oSection1,STR0009,{"D14","SB1","SB8"},/*Ordem*/,,,,,,,,,,,0) // Enderecos
	oSection2:SetHeaderPage()

	TRCell():New(oSection2,'D14_LOCAL'  ,'D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_LOTECT' ,'D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_NUMLOT' ,'D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_DTVALD' ,'D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_ENDER'  ,'D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_IDUNIT' ,'D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	// TRCell():New(oSection2,'D14_NUMSER' ,'D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'B1_UM'      ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_QTDEST' ,'D14',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_QTDEPR' ,'D14',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_QTDSPR' ,'D14',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_QTDEMP' ,'D14',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_QTDBLQ' ,'D14',/*Titulo*/,/*Picture*/,18,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'D14_QTDSLD' ,'D14', STR0010  ,PesqPict("D14","D14_QTDEST"),18,/*lPixel*/,{|| (cAliasD14)->(D14_QTDEST - (D14_QTDSPR + D14_QTDEMP + D14_QTDBLQ))},"RIGHT",,"RIGHT",,,.F.) // "Disponivel"

	// Defindo os totalizadores do relatorio
	// TRFunction()New(oCell,cName,cFunction,oBreak,cTitle,cPicture,uFormula,lEndSection,lEndReport,lEndPage,oParent,bCondition,lDisable,bCanPrint)
	TRFunction():New(oSection2:Cell('D14_QTDEST'),Nil,"SUM",oBreak,Nil,/*Picture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('D14_QTDEPR'),Nil,"SUM",oBreak,Nil,/*Picture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('D14_QTDSPR'),Nil,"SUM",oBreak,Nil,/*Picture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('D14_QTDEMP'),Nil,"SUM",oBreak,Nil,/*Picture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('D14_QTDSLD'),Nil,"SUM",oBreak,Nil,/*Picture*/,/*uFormula*/,.F.,.F.,.F.)
	TRFunction():New(oSection2:Cell('D14_QTDBLQ'),Nil,"SUM",oBreak,Nil,/*Picture*/,/*uFormula*/,.F.,.F.,.F.)

Return(oReport)
//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport, cAliasD14)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local nOrdem     := oSection1:GetOrder()
Local l300SalNeg := SuperGetMV('MV_MT300NG', .F., .F.) // Indica se permite saldo negativo (DEFAULT = .F.)
Local cWhere
Local cOrderBy
Local cKeyAnt

	// Determinando o titulo do Relatorio
	If nOrdem == 1
		oReport:SetTitle(oReport:Title()+" ("+STR0005+")") // Posicao Detalhada do Estoque por Endereco  // Armazem + Grupo + Produto
	ElseIf nOrdem == 2
		oReport:SetTitle(oReport:Title()+" ("+STR0006+")") // Posicao Detalhada do Estoque por Endereco  // Produto + Armazem
	EndIf

	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())

	// Query do relatorio
	cWhere := "%"
	// Considera somente registros no D14 que possuirem quantidade maior que zero
 	If l300SalNeg
 		cWhere += "(D14.D14_QTDEST >= 0 OR D14.D14_QTDEST < 0)"
	Else // Considera somente registros no D14 que possuirem quantidade maior que zero
		cWhere += "D14.D14_QTDEST >= 0"
	EndIf
 	cWhere += "%"

	cOrderBy := "%"
 	If nOrdem == 1
		cOrderBy += "D14.D14_FILIAL, D14.D14_LOCAL, SB1.B1_GRUPO, D14.D14_PRDORI, D14.D14_PRODUT, D14.D14_ENDER,D14.D14_LOTECT, D14.D14_NUMLOT"
	ElseIf nOrdem == 2
		cOrderBy += "D14.D14_FILIAL, D14.D14_PRDORI, D14.D14_PRODUT, D14.D14_LOCAL, D14.D14_ENDER, D14.D14_LOTECT, D14.D14_NUMLOT"
	Endif
	cOrderBy += "%"

 	BEGIN REPORT QUERY oSection1
 	BeginSql Alias cAliasD14
		SELECT D14.D14_FILIAL,
		       D14.D14_LOCAL,
		       D14.D14_PRODUT,
		       D14.D14_PRDORI,
		       SB1.B1_DESC,
		       SB1.B1_GRUPO,
		       D14.D14_ENDER,
		       D14.D14_NUMSER,
		       D14.D14_LOTECT,
		       D14.D14_NUMLOT,
		       D14.D14_DTVALD,
		       D14.D14_IDUNIT,
		       SB1.B1_UM,
		       D14.D14_QTDEST,
		       D14.D14_QTDEPR,
		       D14.D14_QTDSPR,
		       D14.D14_QTDEMP,
		       D14.D14_QTDBLQ
		  FROM %table:D14% D14
		  JOIN %table:SB1% SB1
		    ON SB1.B1_FILIAL  = %xFilial:SB1%
		   AND SB1.B1_COD     = D14.D14_PRODUT
		   AND SB1.%NotDel%
		 WHERE D14.D14_FILIAL = %xFilial:D14%
		   AND D14.D14_PRODUT BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
		   AND D14.D14_LOCAL  BETWEEN %Exp:MV_PAR06% AND %Exp:MV_PAR07%
		   AND D14.D14_ENDER  BETWEEN %Exp:MV_PAR08% AND %Exp:MV_PAR09%
		   AND %Exp:cWhere%
		   AND D14.%NotDel%
		 ORDER BY %Exp:cOrderBy%
	EndSql
	END REPORT QUERY oSection1

	// Definindo as secoes filhas para utilizarem a query da secao pai
	oSection2:SetParentQuery()

	If nOrdem == 1
		oSection2:Cell('D14_LOCAL'):Disable()
	ElseIf nOrdem ==2
		oSection1:Cell('D14_LOCAL'):Disable()
	EndIf

	// Inicio da impressao do fluxo do relatorio
	oReport:SetMeter( D14->(LastRec()) )
	oSection1:Init()
	While !oReport:Cancel() .And. !(cAliasD14)->(Eof())
		oReport:SkipLine()
		oSection1:PrintLine() // Impressao da secao 1
		oReport:SkipLine()
		cKeyAnt := (cAliasD14)->(D14_FILIAL+D14_LOCAL+D14_PRODUT)
		oSection2:Init()
		While !oReport:Cancel() .And. (cAliasD14)->(!Eof() .And. D14_FILIAL+D14_LOCAL +D14_PRODUT == cKeyAnt)

			oReport:IncMeter()
			oSection2:PrintLine() // Impressao da secao 2

			(cAliasD14)->(dbSkip())
		EndDo
		oSection2:Finish()
	EndDo
	oSection1:Finish()
	(cAliasD14)->(DbCloseArea())
Return Nil