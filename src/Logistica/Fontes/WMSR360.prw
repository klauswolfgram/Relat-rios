/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'
#include 'WmsR360.ch'

//---------------------------------------------------------------------------
/*/{Protheus.doc} WmsR350
Relatorio de rastreamento de produto
@author Flavio Luiz Vicco
@since 20/06/2006
@version 1.0
/*/
//---------------------------------------------------------------------------
User Function WmsR360()
Local oReport
	If SuperGetMv("MV_WMSNEW",.F.,.F.)
		Return WMSR361()
	EndIf	

	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//----------------------------------------------------------
// Definições do relatório
//----------------------------------------------------------
Static Function ReportDef()
Local cTitle    := OemToAnsi(STR0001) // RASTREAMENTO DE PRODUTO
Local oReport 
Local oSection1 
Local oCell
	//-----------------------------------------------------------------------
	// Criacao do componente de impressao
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao
	//-----------------------------------------------------------------------
	oReport := TReport():New("WMSR360",cTitle,"WMR360",{|oReport| ReportPrint(oReport,'SDB','SBF','SX51','SX52','SX53','DCD')},STR0008) // Relatório de rastreamento da movimentação de produtos
oReport:SetLandscape()
	//-----------------------------------------------------------------------
	// Variaveis utilizadas para parametros
	// mv_par01  //  Armazem        De  ?
	// mv_par02  //                 Ate ?
	// mv_par03  //  Endereco       De  ?
	// mv_par04  //                 Ate ?
	// mv_par05  //  Documento      De  ?
	// mv_par06  //                 Ate ?
	// mv_par07  //  Carga          De  ?
	// mv_par08  //                 Ate ?
	// mv_par09  //  Produto        De  ?
	// mv_par10  //                 Ate ?
	// mv_par11  //  Data Movimento De  ?
	// mv_par12  //                 Ate ?
	// mv_par13  //  Servico        De  ?
	// mv_par14  //                 Ate ?
	// mv_par15  //  Tarefa         De  ?
	// mv_par16  //                 Ate ?
	// mv_par17  //  Lote           De  ?
	// mv_par18  //                 Ate ?
	// mv_par19  //  Sublote        De  ?
	// mv_par20  //                 Ate ?
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
	oSection1:= TRSection():New(oReport,STR0021,{"SDB"},/*aOrdem*/) // Movimentos por endereco
oSection1:SetHeaderPage()
	TRCell():New(oSection1,"DB_DOC",		"SDB",STR0009,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Docto."
TRCell():New(oSection1,"DB_CARGA",		"SDB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection1,"DB_PRODUTO",	"SDB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection1,"DB_DATA",		"SDB")
	TRCell():New(oSection1,"DB_HRINI",		"SDB",STR0010) // Hr In
	TRCell():New(oSection1,"DB_HRFIM",		"SDB",STR0011) // Hr Fi
	TRCell():New(oSection1,"DSERVIC",		"",   STR0012,,13) // Servico
	TRCell():New(oSection1,"DTAREFA",		"",   STR0013,,13) // Tarefa
	TRCell():New(oSection1,"DATIVID",		"",   STR0014,,13) // Atividade
	TRCell():New(oSection1,"DCD_NOMFUN",	"DCD",STR0015,,08) // RecHum
	TRCell():New(oSection1,"DB_LOCALIZ",	"SDB",STR0016) // End. Origem
TRCell():New(oSection1,"DB_ENDDES",		"SDB")
TRCell():New(oSection1,"DB_LOTECTL",	"SDB")
TRCell():New(oSection1,"DB_NUMLOTE",	"SDB")
	TRCell():New(oSection1,"DB_TM",			"SDB",STR0017) // TP Movto
	TRCell():New(oSection1,"DB_QUANT",		"SDB",STR0018) // Qtde.Movtos
	TRCell():New(oSection1,"BF_QUANT",		"SBF",STR0019,PesqPictQt('BF_QUANT')) // Saldo Endereco
	TRCell():New(oSection1,"BF_EMPENHO",	"SBF",STR0020,PesqPictQt('BF_EMPENHO')) // Empenho
oSection1:Cell("DSERVIC"):SetLineBreak() 
oSection1:Cell("DTAREFA"):SetLineBreak()
oSection1:Cell("DATIVID"):SetLineBreak()
oSection1:Cell("DCD_NOMFUN"):SetLineBreak()
Return(oReport)
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasSDB)
Local oSection1 := oReport:Section(1)
Local cAliasNew := "SDB"
dbSelectArea(cAliasNew)
dbSetOrder(1)
	cAliasNew := GetNextAlias()
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	// Query do relatório da secao 1
	oReport:Section(1):BeginQuery()	
	BeginSql Alias cAliasNew
	SELECT 	DB_DOC,DB_CARGA,DB_PRODUTO,DB_DATA,DB_HRINI,DB_HRFIM,SX51.X5_DESCRI DSERVIC,
			SX52.X5_DESCRI DTAREFA,SX53.X5_DESCRI DATIVID,DCD_NOMFUN,DB_LOCALIZ,DB_ENDDES,DB_LOTECTL,
			DB_NUMLOTE,DB_ATUEST,DB_TM,DB_QUANT,BF_QUANT,BF_EMPENHO
	FROM %table:SDB% SDB
	LEFT JOIN %table:SBF% SBF  ON SBF.BF_FILIAL  = %xFilial:SBF% AND SBF.BF_LOCAL = SDB.DB_LOCAL AND SBF.BF_LOCALIZ = SDB.DB_ENDDES AND SBF.BF_QUANT > 0 AND SBF.%NotDel%
	LEFT JOIN %table:SX5% SX51 ON SX51.X5_FILIAL = %xFilial:SX5% AND SX51.X5_TABELA = 'L4' AND SX51.X5_CHAVE = SDB.DB_SERVIC AND SX51.%NotDel%
	LEFT JOIN %table:SX5% SX52 ON SX52.X5_FILIAL = %xFilial:SX5% AND SX52.X5_TABELA = 'L2' AND SX52.X5_CHAVE = SDB.DB_TAREFA AND SX52.%NotDel%
	LEFT JOIN %table:SX5% SX53 ON SX53.X5_FILIAL = %xFilial:SX5% AND SX53.X5_TABELA = 'L3' AND SX53.X5_CHAVE = SDB.DB_ATIVID AND SX53.%NotDel%
	LEFT JOIN %table:DCD% DCD  ON DCD.DCD_FILIAL = %xFilial:DCD% AND DCD.DCD_CODFUN = SDB.DB_RECHUM AND DCD.%NotDel%
	WHERE DB_FILIAL = %xFilial:SDB%
	AND DB_LOCAL    BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
	AND (DB_LOCALIZ BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
	OR   DB_ENDDES  BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%)
	AND DB_DOC      BETWEEN %Exp:mv_par05% AND %Exp:mv_par06%
	AND DB_CARGA    BETWEEN %Exp:mv_par07% AND %Exp:mv_par08%
	AND DB_PRODUTO  BETWEEN %Exp:mv_par09% AND %Exp:mv_par10%
	AND DB_DATA     BETWEEN %Exp:DtoS(mv_par11)% AND %Exp:DtoS(mv_par12)%
	AND DB_SERVIC   BETWEEN %Exp:mv_par13% AND %Exp:mv_par14%
	AND DB_TAREFA   BETWEEN %Exp:mv_par15% AND %Exp:mv_par16%
	AND DB_LOTECTL  BETWEEN %Exp:mv_par17% AND %Exp:mv_par18%
	AND DB_NUMLOTE  BETWEEN %Exp:mv_par19% AND %Exp:mv_par20%
	AND DB_ESTORNO  <> 'S'
	AND DB_ATUEST   =  'N'
	AND SDB.%NotDel%
	ORDER BY DB_DOC,DB_CARGA,DB_LOCALIZ,DB_ENDDES,DB_PRODUTO
	EndSql 
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
	oSection1:Print()
Return NIL
