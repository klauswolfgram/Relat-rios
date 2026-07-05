/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "WMSR457.CH"  
#INCLUDE "PROTHEUS.CH"
//------------------------------------------------------------
/*/{Protheus.doc} WMSR457
Produtos a distribuir
@author alexsander.correa
@since 02/02/2016
@version 1.0
/*/
//------------------------------------------------------------
User Function WMSR457()
Local oReport

	// Permite efetuar validações, apresentar mensagem e abortar o programa quando desejado
	If !WMSChkPrg(FunName(),"3")
		Return Nil
	EndIf
	
	//------------------------
	// Interface de impressao
	//------------------------
	oReport := ReportDef()
	oReport:PrintDialog()
Return
//-------------------------------------------------------------------------
// Função ReportDef
//-------------------------------------------------------------------------
Static Function ReportDef()
Local oReport 
Local oSection
Local nTamCod   := TamSx3("D0G_PRODUTO")[1]+4
Local nTamDoc   := TamSx3("D0G_DOC")[1]+2
Local nTamArm   := TamSx3("D0G_LOCAL")[1]+1
Local nTamSer   := TamSx3("D0G_SERIE")[1]
Private cAliasQRY := "D0G" 
	//------------------------------------------------------------------------
	// Criacao do componente de impressao
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao
	//------------------------------------------------------------------------
	oReport := TReport():New("WMSR457",STR0001,"WMSR457", {|oReport| ReportPrint(oReport)},STR0002) // Relatório de Produtos a Distribuir // Emite a relação dos produtos que aguardam distribuição para suas localizações fisicas especificas.
	oReport:SetLandscape()
	
	//------------------------------------------------
	// Variaveis utilizadas para parametros
	// mv_par01     // De  Local
	// mv_par02     // Ate Local
	// mv_par03     // De  Produto
	// mv_par04     // Ate Produto
	// mv_par05     // Lista Saldos Zerados ? Sim Nao
	//------------------------------------------------
	Pergunte("WMSR457",.F.)	
	//------------------------------------------------------------------------
	// Criacao da secao utilizada pelo relatorio
	// TRSection():New
	// ExpO1 : Objeto TReport que a secao pertence
	// ExpC2 : Descricao da seçao
	// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
	//         sera considerada como principal para a seção.
	// ExpA4 : Array com as Ordens do relatorio
	// ExpL5 : Carrega campos do SX3 como celulas
	//         Default : False
	// ExpL6 : Carrega ordens do Sindex
	//         Default : False
	//-------------------------------------------------------------
	// Criacao das celulas da secao do relatorio
	// TRCell():New
	// ExpO1 : Objeto TSection que a secao pertence
	// ExpC2 : Nome da celula do relatorio. O SX3 sera consultado
	// ExpC3 : Nome da tabela de referencia da celula
	// ExpC4 : Titulo da celula
	//         Default : X3Titulo()
	// ExpC5 : Picture
	//         Default : X3_PICTURE
	// ExpC6 : Tamanho
	//         Default : X3_TAMANHO
	// ExpL7 : Informe se o tamanho esta em pixel
	//         Default : False
	// ExpB8 : Bloco de codigo para impressao.
	//         Default : ExpC2
	//-------------------------------------------------------------
	
	oSection := TRSection():New(oReport,STR0003,{"D0G","SB1","SB8"}) // Saldos a Endereçar
	oSection:SetHeaderPage()
	
	TRCell():New(oSection,"D0G_PRODUT"	,"D0G",										,/*Picture*/,nTamCod	,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection,"B1_DESC"		,"SB1",										,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"D0G_LOCAL"	,"D0G",PadR(RetTitle("D0G_LOCAL"),nTamArm)	,/*Picture*/,nTamArm	,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection,"D0G_QTDORI"	,"D0G",STR0004+CRLF+STR0005 				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"D0G_SALDO"	,"D0G",STR0006+CRLF+STR0007					,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"D0G_ORIGEM"	,"D0G",STR0008								,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection,"D0G_LOTECT"	,"D0G",										,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection,"D0G_NUMLOT"	,"D0G",										,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection,"B8_DTVALID"	,"SB8",										,/*Picture*/,12			,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection,"D0G_DOC"		,"D0G",										,/*Picture*/,nTamDoc	,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection,"D0G_SERIE"	,"D0G",PadR(RetTitle("D0G_SERIE"),nTamSer)	,/*Picture*/,nTamSer	,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection,"D0G_NUMSEQ"	,"D0G",STR0009+CRLF+STR0010					,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)

Return(oReport)
//-------------------------------------------------------------------------
// Função ReportPrint
//-------------------------------------------------------------------------
Static Function ReportPrint(oReport)
Local oSection  := oReport:Section(1)
Local cCondicao := ""
Local cQuery	:= ""

	SB1->( dbSetOrder( 1 ) )
	SB8->( dbSetOrder( 3 ) )
	dbSelectArea("D0G")	
	//----------------------------------------------
	//Filtragem do relatorio
	//----------------------------------------------
	// Transforma parametros Range em expressao SQL 
	//----------------------------------------------
	MakeSqlExpr(oReport:uParam)
	//----------------------------------------------
	// Query do relatório da secao 1
	//----------------------------------------------
	oReport:Section(1):BeginQuery()	
	
	cAliasQRY := GetNextAlias()
	
	BeginSql Alias cAliasQRY
	SELECT	D0G_FILIAL,D0G_PRODUT,D0G_LOCAL,D0G_QTDORI,D0G_SALDO,D0G_ORIGEM,
			D0G_LOTECT,D0G_NUMLOT,D0G_DOC,D0G_SERIE,D0G_NUMSEQ
	FROM %table:D0G% D0G
		WHERE D0G_FILIAL = %xFilial:D0G%  AND
			D0G_LOCAL   >= %Exp:mv_par01% AND
			D0G_LOCAL   <= %Exp:mv_par02% AND
			D0G_PRODUT >= %Exp:mv_par03% AND
			D0G_PRODUT <= %Exp:mv_par04% AND
			D0G.%NotDel%
	ORDER BY %Order:D0G%	
	EndSql 
	//--------------------------------------------------
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	//--------------------------------------------------
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)	
	//--------------------------------------------------------------------------------
	// Metodo TrPosition()
	// Posiciona em um registro de uma outra tabela. O posicionamento será
	// realizado antes da impressao de cada linha do relatório.
	// ExpO1 : Objeto Report da Secao
	// ExpC2 : Alias da Tabela
	// ExpX3 : Ordem ou NickName de pesquisa
	// ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe cutada.
	//--------------------------------------------------------------------------------	
	TRPosition():New(oSection,"SB1",1,{|| xFilial("SB1") + (cAliasQRY)->D0G_PRODUT})
	TRPosition():New(oSection,"SB8",3,;
	{|| If(Rastro( (cAliasQRY)->D0G_PRODUT ), xFilial("SB8")+(cAliasQRY)->D0G_PRODUT+(cAliasQRY)->D0G_LOCAL+(cAliasQRY)->D0G_LOTECT+ If(Rastro((cAliasQRY)->D0G_PRODUT,"S"),(cAliasQRY)->D0G_NUMLOT,""),'xxx') })
	//--------------------------------------------------
	// Inicio da impressao do fluxo do relatorio
	//--------------------------------------------------
	oSection:Print()
Return NIL