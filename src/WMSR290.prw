/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "WMSR290.CH"

//----------------------------------------------------------
/*/{Protheus.doc} WMSR290
Impressao Servico X Tarefa X Atividade pendentes/executados.

@author  Felipe Nunes Toledo
@version P11
@since   12/06/06
/*/
//----------------------------------------------------------
User Function WMSR290()
Local oReport
	If !SuperGetMV("MV_WMSNEW", .F., .F.)
		Return DLGR290()
	EndIf

	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//-----------------------------------------------------------------------
// Definições do relatório
//-----------------------------------------------------------------------
Static Function ReportDef()
Local oReport, oSection
Local cAliasD12 := GetNextAlias()
	//-----------------------------------------------------------------------
	// Criacao do componente de impressao
	//
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao
	//
	//-----------------------------------------------------------------------
	oReport:= TReport():New("WMSR290",STR0001,"WMSR290", {|oReport| ReportPrint(oReport,cAliasD12)},STR0002) //##"Servicos Pendentes / Executados - Relacao com Servicos X Tarefas X Atividades pendentes e /ou executados. Os itens serao filtrados de acordo com os parametros utilizados pelo usuario."
	oReport:lParamPage := .F.
	oReport:SetLandscape() //Define a orientacao de pagina do relatorio como paisagem.

	//-----------------------------------------------------------------------
	//  Verifica as perguntas selecionadas - DLR290
	//-----------------------------------------------------------------------
	//  Variaveis utilizadas para parametros
	//  mv_par01     // De Servico
	//  mv_par02     // Ate Servico
	//  mv_par03     // De Tarefa
	//  mv_par04     // Ate Tarefa
	//  mv_par05     // Ate Recurso
	//  mv_par06     // De Atividade
	//  mv_par07     // Ate Atividade
	//  mv_par08     // De Documento
	//  mv_par09     // Ate Documento
	//  mv_par10     // De Serie
	//  mv_par11     // Imprime Itens
	//-----------------------------------------------------------------------
	Pergunte(oReport:uParam,.F.)
	//-----------------------------------------------------------------------
	// Criacao da secao utilizada pelo relatorio
	//
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
	//  Sessao 1 (oSection)
	//-----------------------------------------------------------------------
	oSection := TRSection():New(oReport,STR0011,{"D12","SB1"}) // Movimentos por endereco
	oSection:SetHeaderPage()

	TRCell():New(oSection,'D12_DOC'    ,'D12',STR0012,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Docto
	TRCell():New(oSection,'D12_SERIE'  ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,'D12_PRODUT' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,'D12_LOCORI' ,'D12',STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Arm
	TRCell():New(oSection,'D12_QTDMOV' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,'D12_UMMOV'  ,''   ,STR0014,PesqPict("SB1","B1_UM"),/*Tamanho*/,/*lPixel*/,{|| If(SB5->B5_UMIND=='2',SB1->B1_SEGUM,SB1->B1_UM)}) // UM"
	TRCell():New(oSection,'D12_LOTECT' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,'D12_NUMLOT' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,'D12_SERVIC' ,'D12',STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Serv
	TRCell():New(oSection,'X5_DESSERV' ,'SX5',STR0005,PesqPict("D12","D12_DESSER",23),15,/*lPixel*/,{|| Posicione("SX5",1,xFilial("SX5")+"L4"+(cAliasD12)->D12_SERVIC,"X5Descri()") })// Descricao do Servico
	TRCell():New(oSection,'D12_TAREFA' ,'D12',STR0016,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Tarefa
	TRCell():New(oSection,'X5_DESTAR'  ,'D12',STR0005,PesqPict("D12","D12_DESTAR",23),15,/*lPixel*/,{|| Posicione("SX5",1,xFilial("SX5")+"L2"+(cAliasD12)->D12_TAREFA,"X5Descri()") }) // Descricao da Tarefa
	TRCell():New(oSection,'D12_ATIVID' ,'D12',STR0017,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Ativ
	TRCell():New(oSection,'X5_DESATIV' ,'D12',STR0005,PesqPict("D12","D12_DESATI",23),15,/*lPixel*/,{|| Posicione("SX5",1,xFilial("SX5")+"L3"+(cAliasD12)->D12_ATIVID,"X5Descri()") }) // Descricao da Atividade
	TRCell():New(oSection,'D12_RECHUM' ,'D12',STR0018,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Rec.Hum
	TRCell():New(oSection,'D12_RECFIS' ,'D12',STR0019,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Rec.Fis
	TRCell():New(oSection,'BE_ESTORI'  ,''   ,STR0020,PesqPict("SBE","BE_ESTFIS",6),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Est.Fis"
	TRCell():New(oSection,'D12_ENDORI' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,'D12_IDUNIT' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,'BE_ESTDES'  ,''   ,STR0021,PesqPict("SBE","BE_ESTFIS",6),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Est.Des"
	TRCell():New(oSection,'D12_ENDDES' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	If WmsX312118("D12","D12_UNIDES",.T.)
		TRCell():New(oSection,'D12_UNIDES' ,'D12',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	EndIf

	// Posicionamento das tabelas
	TRPosition():New(oSection,"SB1",1,{|| xFilial("SB1")+(cAliasD12)->D12_PRODUT })
	TRPosition():New(oSection,"SB5",1,{|| xFilial("SB5")+(cAliasD12)->D12_PRODUT })
Return(oReport)
//----------------------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------------------
Static Function ReportPrint(oReport,cAliasD12)
Local oSection := oReport:Section(1)
Local cWhere   := ""
Local cField   := ""
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:uParam)
	// Query do relatorio da secao 1
	oSection:BeginQuery()

	If WmsX312118("D12","D12_UNIDES",.T.)
		cField := "%, D12_UNIDES%"
	EndIf

	cWhere := "%"
	If mv_par11 == 1
		cWhere += " D12_HORFIM = '"+Criavar("D12_HORFIM",.F.)+"' "
	ElseIf mv_par11 == 2
		cWhere += " D12_HORFIM <> '"+Criavar("D12_HORFIM",.F.)+"' "
	Else
		cWhere += " 1 = 1 "
	EndIf
	cWhere += "%"

	BeginSql Alias cAliasD12
		SELECT D12.D12_DOC   ,
				 D12.D12_SERIE ,
				 D12.D12_PRODUT,
				 D12.D12_LOCORI,
				 D12.D12_QTDMOV,
				 D12.D12_QTDMO2,
				 D12.D12_LOTECT,
				 D12.D12_NUMLOT,
				 D12.D12_SERVIC,
				 D12.D12_ORDTAR,
				 D12.D12_TAREFA,
				 D12.D12_ORDATI,
				 D12.D12_ATIVID,
				 D12.D12_RECHUM,
				 D12.D12_RECFIS,
				 SBE1.BE_ESTFIS BE_ESTORI,
				 D12.D12_ENDORI,
				 D12.D12_IDUNIT,
				 SBE2.BE_ESTFIS BE_ESTDES,
				 D12.D12_ENDDES
				 %Exp:cField%
		  FROM %table:D12% D12,
				 %table:SBE% SBE1,
				 %table:SBE% SBE2
		 WHERE D12.D12_FILIAL = %xFilial:D12%
			AND D12.D12_SERVIC >= %Exp:mv_par01%
			AND D12.D12_SERVIC <= %Exp:mv_par02%
			AND D12.D12_TAREFA >= %Exp:mv_par03%
			AND D12.D12_TAREFA <= %Exp:mv_par04%
			AND D12.D12_ATIVID >= %Exp:mv_par05%
			AND D12.D12_ATIVID <= %Exp:mv_par06%
			AND D12.D12_DOC    >= %Exp:mv_par07%
			AND D12.D12_DOC    <= %Exp:mv_par08%
			AND D12.D12_DTGERA >= %Exp:DtoS(mv_par09)%
			AND D12.D12_DTGERA <= %Exp:DtoS(mv_par10)%
			AND %Exp:cWhere%
			AND D12.%NotDel%
			AND SBE1.BE_FILIAL  = %xFilial:SBE%
			AND SBE1.BE_LOCAL   = D12.D12_LOCORI
			AND SBE1.BE_LOCALIZ = D12.D12_ENDORI
			AND SBE1.%NotDel%
			AND SBE2.BE_FILIAL  = %xFilial:SBE%
			AND SBE2.BE_LOCAL   = D12.D12_LOCDES
			AND SBE2.BE_LOCALIZ = D12.D12_ENDDES
			AND SBE2.%NotDel%
		ORDER BY D12_DOC,D12_SERIE,D12_PRODUT,D12_LOCORI,D12_LOTECT,D12_NUMLOT,D12_SERVIC,D12_ORDTAR,D12_ORDATI
	EndSql
	oSection:EndQuery()
	// Inicio da impressao do relatorio
	oSection:Print()
Return NIL
