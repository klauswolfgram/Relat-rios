/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'  
#include 'WMSR361.ch'

//---------------------------------------------------------------------------
/*/{Protheus.doc} WmsR350
Relatorio de rastreamento de produto
@author Flavio Luiz Vicco
@since 20/06/2006
@version 1.0
/*/
//---------------------------------------------------------------------------
User Function WmsR361()
Local oReport
	If !SuperGetMV("MV_WMSNEW", .F., .F.)
		Return WmsR360()
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
	oReport := TReport():New("WMSR361",cTitle,"WMR360",{|oReport| ReportPrint(oReport,'D12','D14','SX51','SX52','SX53','DCD')},STR0008) // Relatório de rastreamento da movimentação de produtos
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
	oSection1:= TRSection():New(oReport,STR0021,{"D12"},/*aOrdem*/) // Movimentos por endereco
	oSection1:SetHeaderPage()
	TRCell():New(oSection1,"D12_DOC"	,"D12",STR0009,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Docto.
	TRCell():New(oSection1,"D12_CARGA"	,"D12",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection1,"D12_PRODUT","D12",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
	TRCell():New(oSection1,"D12_DTGERA","D12")
	TRCell():New(oSection1,"D12_HRGERA","D12",STR0010) // Hr In
	TRCell():New(oSection1,"D12_HORFIM","D12",STR0011) // Hr Fi
	TRCell():New(oSection1,"DSERVIC"	,	"",	STR0012,,13) // Servico
	TRCell():New(oSection1,"DTAREFA"	,	"",	STR0013,,13) // Tarefa
	TRCell():New(oSection1,"DATIVID"	,	"",	STR0014,,13) // Atividade
	TRCell():New(oSection1,"DCD_NOMFUN","DCD",STR0015,,08) // RecHum
	TRCell():New(oSection1,"D12_ENDORI","D12",STR0016) // End. Origem
	TRCell():New(oSection1,"D12_ENDDES","D12")
	TRCell():New(oSection1,"D12_LOTECT","D12")
	TRCell():New(oSection1,"D12_NUMLOT","D12")
	TRCell():New(oSection1,"D12_TM"    ,"D12",STR0017) // TP Movto
	TRCell():New(oSection1,"D12_QTDMOV","D12",STR0018) // Qtde.Movtos
	TRCell():New(oSection1,"D14_QTDEST","D14",STR0019,PesqPictQt('D14_QTDEST')) // Saldo Endereco
	TRCell():New(oSection1,"D14_QTDEMP","D14",STR0020,PesqPictQt('D14_QTDEMP')) // Empenho
	oSection1:Cell("DSERVIC"):SetLineBreak()
	oSection1:Cell("DTAREFA"):SetLineBreak()
	oSection1:Cell("DATIVID"):SetLineBreak()
	oSection1:Cell("DCD_NOMFUN"):SetLineBreak()
Return(oReport)
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasD12)
Local oSection1 := oReport:Section(1)
Local cAliasNew := "D12"
	dbSelectArea(cAliasNew)
	dbSetOrder(1)
	cAliasNew := GetNextAlias()
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	// Query do relatório da secao 1
	oReport:Section(1):BeginQuery()
	BeginSql Alias cAliasNew
	SELECT D12.D12_DOC,    D12.D12_CARGA,  D12.D12_PRODUT, D12.D12_DTGERA, D12.D12_HRGERA, D12.D12_HORFIM, SX51.X5_DESCRI DSERVIC,
			DCD.DCD_NOMFUN, D12.D12_ENDORI, D12.D12_ENDDES, D12.D12_LOTECT, SX52.X5_DESCRI DTAREFA, SX53.X5_DESCRI DATIVID, 
			D12.D12_NUMLOT, D12.D12_TM,     D12.D12_QTDMOV, D14.D14_QTDEST, D14.D14_QTDEMP
	  FROM %table:D12% D12
	  LEFT JOIN %table:D14% D14  ON D14.D14_FILIAL = %xFilial:D14% AND D14.D14_LOCAL  = D12.D12_LOCDES AND D14.D14_ENDER = D12.D12_ENDDES AND D14.D14_QTDEST > 0 AND D14.%NotDel%
	  LEFT JOIN %table:SX5% SX51 ON SX51.X5_FILIAL = %xFilial:SX5% AND SX51.X5_TABELA = 'L4'           AND SX51.X5_CHAVE = D12.D12_SERVIC AND SX51.%NotDel%
	  LEFT JOIN %table:SX5% SX52 ON SX52.X5_FILIAL = %xFilial:SX5% AND SX52.X5_TABELA = 'L2'           AND SX52.X5_CHAVE = D12.D12_TAREFA AND SX52.%NotDel%
	  LEFT JOIN %table:SX5% SX53 ON SX53.X5_FILIAL = %xFilial:SX5% AND SX53.X5_TABELA = 'L3'           AND SX53.X5_CHAVE = D12.D12_ATIVID AND SX53.%NotDel%
	  LEFT JOIN %table:DCD% DCD  ON DCD.DCD_FILIAL = %xFilial:DCD% AND DCD.DCD_CODFUN = D12.D12_RECHUM AND DCD.%NotDel%
	 WHERE D12_FILIAL = %xFilial:D12%
	   AND D12_LOCORI  BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
	   AND (D12_ENDORI BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
 	    OR  D12_ENDDES BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%)
	   AND D12_DOC     BETWEEN %Exp:mv_par05% AND %Exp:mv_par06%
	   AND D12_CARGA   BETWEEN %Exp:mv_par07% AND %Exp:mv_par08%
	   AND D12_PRODUT  BETWEEN %Exp:mv_par09% AND %Exp:mv_par10%
	   AND D12_DTGERA  BETWEEN %Exp:DtoS(mv_par11)% AND %Exp:DtoS(mv_par12)%
	   AND D12_SERVIC  BETWEEN %Exp:mv_par13% AND %Exp:mv_par14%
	   AND D12_TAREFA  BETWEEN %Exp:mv_par15% AND %Exp:mv_par16%
	   AND D12_LOTECT  BETWEEN %Exp:mv_par17% AND %Exp:mv_par18%
	   AND D12_NUMLOT  BETWEEN %Exp:mv_par19% AND %Exp:mv_par20%
	   AND D12.%NotDel%
	 ORDER BY D12_DOC,D12_CARGA,D12_ENDORI,D12_ENDDES,D12_PRODUT
	EndSql
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
	oSection1:Print()
Return NIL
