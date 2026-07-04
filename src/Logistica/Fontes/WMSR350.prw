/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'  
#include 'WmsR350.ch'

//---------------------------------------------------------------------------
/*/{Protheus.doc} WmsR350
Relatorio de pedidos sem codigo de servico
@author Flavio Luiz Vicco
@since 20/06/2006
@version 1.0
/*/
//---------------------------------------------------------------------------
User Function WmsR350()
Local oReport
	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//----------------------------------------------------------
// Definições do relatório
//----------------------------------------------------------
Static Function ReportDef()
Local oReport 
Local oSection1 
Local oCell
Local cTitle := OemToAnsi(STR0001) //'PEDIDO SEM CODIGO DE SERVICO'
	//-----------------------------------------------------------------------
	// Criacao do componente de impressao
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao
	//-----------------------------------------------------------------------
	oReport := TReport():New("WMSR350",cTitle,"WMR350",{|oReport| ReportPrint(oReport,"SC6")},STR0008)
	//-----------------------------------------------------------------------
	// Variaveis utilizadas para parametros
	// mv_par01  //  Armazem De  ?
	// mv_par02  //          Ate ?
	//-----------------------------------------------------------------------
	Pergunte(oReport:uParam,.F.)
	//-----------------------------------------------------------------------
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
	//-----------------------------------------------------------------------
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
	//-----------------------------------------------------------------------
	oSection1:= TRSection():New(oReport,STR0009,{"SC6"},/*aOrdem*/) // Itens de pedidos de venda
	oSection1:SetHeaderPage()
	TRCell():New(oSection1,"C6_NUM",		"SC6",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"C6_PRODUTO",	"SC6")
	TRCell():New(oSection1,"C6_QTDVEN",	"SC6",,PesqPictQt('C6_QTDVEN'))
	TRCell():New(oSection1,"C6_QTDLIB",	"SC6",,PesqPictQt('C9_QTDLIB'))
	TRCell():New(oSection1,"C6_QTDENT",	"SC6",,PesqPictQt('C6_QTDENT'))
	TRCell():New(oSection1,"C6_LOTECTL",	"SC6")
	TRCell():New(oSection1,"C6_LOCALIZ",	"SC6")
	TRCell():New(oSection1,"C6_SERVIC",	"SC6")
	TRCell():New(oSection1,"C6_ENDPAD",	"SC6")
Return(oReport)
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasSB1)
Local oSection1 := oReport:Section(1)
Local cAliasNew := "SC6"
Local cVazio1	  := Space(Len(SC6->C6_SERVIC))

	dbSelectArea(cAliasNew)
	dbSetOrder(1)
	// Filtragem do relatório
	cAliasNew := GetNextAlias()
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:uParam)
	// Query do relatório da secao 1
	oReport:Section(1):BeginQuery()	

	BeginSql Alias cAliasNew
		SELECT C6_NUM, C6_PRODUTO, C6_QTDVEN, C6_QTDLIB, C6_QTDENT, C6_LOTECTL, C6_LOCALIZ, C6_SERVIC, C6_ENDPAD, C6_TES
	
		FROM %table:SC6% SC6
	
		JOIN %table:SF4% SF4 ON SF4.F4_FILIAL = %xFilial:SF4% AND SF4.F4_CODIGO = SC6.C6_TES AND SF4.%NotDel%
	
		WHERE	C6_FILIAL = %xFilial:SC6% AND
				C6_LOCAL BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
				C6_SERVIC = %Exp:cVazio1% AND
				C6_QTDVEN <> C6_QTDENT AND
				SC6.%NotDel%
	
		ORDER BY C6_FILIAL, C6_NUM, C6_PRODUTO
	EndSql 
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

	oReport:SetMeter(RecCount())
	oSection1:Init()
	dbSelectArea(cAliasNew)
	While !oReport:Cancel() .And. !(cAliasNew)->(Eof())
		If oReport:Cancel()
			Exit
		EndIf
		oReport:IncMeter()
		cPedido := (cAliasNew)->C6_NUM
		oSection1:PrintLine()
		(cAliasNew)->(dbSkip())
		If	cPedido != (cAliasNew)->C6_NUM
			oReport:ThinLine() // Impressao de Linha Simples
		EndIf
		(cAliasNew)->(dbSkip())
	EndDo
	oSection1:Finish()
Return NIL