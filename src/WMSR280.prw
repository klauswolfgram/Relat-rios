/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'FIVEWIN.CH'  
#Include 'WMSR280.CH'

//----------------------------------------------------------
/*/{Protheus.doc} WMSR280
Indicadores de Produtividade - Desempenho por Atividade

@author  Flavio Luiz Vicco
@version	P11
@since   20/06/2006
/*/
//----------------------------------------------------------
User Function WMSR280()
Local oReport
	If !SuperGetMV("MV_WMSNEW", .F., .F.)
		Return DLGR280()
	EndIf
	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//-----------------------------------------------------------------------
// Definições do relatório
//-----------------------------------------------------------------------
Static Function ReportDef()
Local cAliasNew := "D12"
Local cTitle    := OemToAnsi(STR0005) // Indicadores de Produtividade
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4

	dbSelectArea(cAliasNew)
	dbSetOrder(1)
	
	cAliasNew := GetNextAlias()
	
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
	oReport := TReport():New("WMSR280",cTitle,"DLR280",{|oReport| ReportPrint(oReport,cAliasNew)},STR0001) // Relatorio de todos os Movimentos de Distribuicao cadastrados no armazem com as informacoes
	//--------------------------------------------------------------------
	// Variaveis utilizadas como parametros p/filtrar as ordens de servico
	//--------------------------------------------------------------------
	// mv_par01	// Armazem       De  ?
	// mv_par02	//               Ate ?
	// mv_par03	// Servico       De  ?
	// mv_par04	//               Ate ?
	// mv_par05	// Tarefa        De  ?
	// mv_par06	//               Ate ?
	// mv_par07	// Atividade     De  ?
	// mv_par08	//               Ate ?
	// mv_par09	// Analitico/Sintetic? 1-Analitico
	//                                    2-Sintetico
	// mv_par10	// Indicador         ? 1-Recurso Humano
	//                                    2-Recurso Fisico
	//                                    3-Unitizador
	// mv_par11	// Indicador     De  ?
	// mv_par12	//               Ate ?
	// mv_par13	// Refer.Cobranca    ?
	//--------------------------------------------------------------------
	Pergunte(oReport:uParam,.F.)
	//--------------------------------------------------------------------
	// Criacao da secao utilizada pelo relatorio
	//
	// TRSection():New
	// ExpO1 : Objeto TReport que a secao pertence
	// ExpC2 : Descricao da seçao
	// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira
	//        tabela sera considerada como principal para a seção.
	// ExpA4 : Array com as Ordens do relatório
	// ExpL5 : Carrega campos do SX3 como celulas
	//        Default : False
	// ExpL6 : Carrega ordens do Sindex
	//        Default : False
	//-----------------------------------------------------------------------
	// Criacao da celulas da secao do relatorio
	//
	// TRCell():New
	// ExpO1 : Objeto TSection que a secao pertence
	// ExpC2 : Nome da celula do relatório. O SX3 será consultado
	// ExpC3 : Nome da tabela de referencia da celula
	// ExpC4 : Titulo da celula
	//        Default : X3Titulo()
	// ExpC5 : Picture
	//        Default : X3_PICTURE
	// ExpC6 : Tamanho
	//        Default : X3_TAMANHO
	// ExpL7 : Informe se o tamanho esta em pixel
	//        Default : False
	// ExpB8 : Bloco de código para impressao.
	//        Default : ExpC2
	//-----------------------------------------------------------------------
	// Sessao 1 - Armazem
	//-------------------
	oSection1:=TRSection():New(oReport,STR0020,{"D12"},/*aOrdem*/) // Movimentos por endereco
	oSection1:SetLineStyle()
	TRCell():New(oSection1,"D12_LOCORI","D12") //,,,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
	// Sessao 2 - Servico / Tarefa / Atividade
	oSection2:=TRSection():New(oSection1,STR0020+"-"+STR0021,{"D12"},/*aOrdem*/) // Movimentos por endereco // Servico/Tarefa/Atividade
	oSection2:SetLineStyle()
	TRCell():New(oSection2,"DSERVIC","",STR0024,,30,,{||(cAliasNew)->D12_SERVIC+" - "+TABELA("L4",(cAliasNew)->D12_SERVIC,.F.)}) // Servico
	TRCell():New(oSection2,"DTAREFA","",STR0025,,30,,{||(cAliasNew)->D12_TAREFA+" - "+TABELA("L2",(cAliasNew)->D12_TAREFA,.F.)}) // Tarefa
	TRCell():New(oSection2,"DATIVID","",STR0026,,30,,{||(cAliasNew)->D12_ATIVID+" - "+TABELA("L3",(cAliasNew)->D12_ATIVID,.F.)}) // Atividade
	// Sessao 3 - Recurso Humano / Fisico / Unitizador
	oSection3:=TRSection():New(oSection2,STR0020+"-"+STR0022,{"D12"},/*aOrdem*/) // Movimentos por endereco // Recurso Humano/Fisico/Unitizador
	oSection3:SetLineStyle()
	TRCell():New(oSection3,"INDICADOR","",STR0027,,30)
	// Sessao 4 - Analitico + Totais
	oSection4:=TRSection():New(oSection3,STR0020+"-"+STR0023,{"D12"},/*aOrdem*/) // Movimentos por endereco // Analitico/Totais
	oSection4:SetHeaderPage()
	TRCell():New(oSection4,"D12_PRODUT",	"D12",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection4,"D12_QTDMOV",	"D12",STR0018,   /*Picture*/,/*Tamanho*/,/*lPixel*/,{||WMSR280Calc(cAliasNew)}) // Quantidade
	TRCell():New(oSection4,"D12_DATINI",	"D12")
	TRCell():New(oSection4,"D12_HORINI",	"D12")
	TRCell():New(oSection4,"D12_DATFIM",	"D12")
	TRCell():New(oSection4,"D12_HORFIM",	"D12")
	TRCell():New(oSection4,"NTOTHR",		"",STR0019,,,,{||IntToHora(SubtHoras((cAliasNew)->D12_DATINI,(cAliasNew)->D12_HORINI,(cAliasNew)->D12_DATFIM,(cAliasNew)->D12_HORFIM),3)}) // Total de Horas"	
Return(oReport)
//---------------------------------------------------------------------
// Impressão do relatório
//---------------------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(1):Section(1)
Local oSection4  := oReport:Section(1):Section(1):Section(1):Section(1)
Local cQuebra	 := ""
Local cChave     := ""
Local cComp      := ""
Local oBreak1
Local cSelect    := ""
Local cWhere     := ""
Local cOrder     := ""
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	If	mv_par10 == 1	// Recurso Humano
		cWhere  := "%AND D12_RECHUM >= '"+mv_par11+"'"
		cWhere  += " AND D12_RECHUM <= '"+mv_par12+"'%"
		cChave  := "D12_FILIAL,D12_LOCORI,D12_SERVIC,D12_TAREFA,D12_ATIVID,D12_RECHUM"
	ElseIf mv_par10 == 2	// Recurso Fisico
		cWhere  := "%AND D12_RECFIS >= '"+mv_par11+"'"
		cWhere  += " AND D12_RECFIS <= '"+mv_par12+"'%"
		cChave  := "D12_FILIAL,D12_LOCORI,D12_SERVIC,D12_TAREFA,D12_ATIVID,D12_RECFIS"
	ElseIf mv_par10 == 3	// Unitizador
		cWhere  := "%AND D12_IDUNIT >= '"+mv_par11+"'"
		cWhere  += " AND D12_IDUNIT <= '"+mv_par12+"'%"
		cChave  := "D12_FILIAL,D12_LOCORI,D12_SERVIC,D12_TAREFA,D12_ATIVID,D12_IDUNIT"
	EndIf
	cOrder := "%"+cChave+"%"
	// Query do relatório da secao 1
	oSection1:BeginQuery()
	BeginSql Alias cAliasNew
		
		SELECT D12.D12_FILIAL, D12.D12_LOCORI, D12.D12_SERVIC, D12.D12_TAREFA, D12.D12_ATIVID,
		       D12.D12_PRODUT, D12.D12_QTDMOV, D12.D12_QTDMO2,
		       D12.D12_DATINI, D12.D12_HORINI, D12.D12_DATFIM, D12.D12_HORFIM,
		       D12.D12_RECHUM, D12.D12_RECFIS, D12.D12_IDUNIT,
		       SB1.B1_UM,      SB1.B1_PESO,    SB5.B5_ALTURLC, SB5.B5_LARGLC,  SB5.B5_COMPRLC
		  FROM %table:D12% D12
		  LEFT JOIN %table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = D12.D12_PRODUT AND SB1.%NotDel%
		  LEFT JOIN %table:SB5% SB5 ON SB5.B5_FILIAL = %xFilial:SB5% AND SB5.B5_COD = D12.D12_PRODUT AND SB5.%NotDel%
		 WHERE D12_FILIAL = %xFilial:D12%
		   AND D12_LOCORI >= %Exp:mv_par01%
		   AND D12_LOCORI <= %Exp:mv_par02%
		   AND D12_SERVIC >= %Exp:mv_par03%
		   AND D12_SERVIC <= %Exp:mv_par04%
		   AND D12_TAREFA >= %Exp:mv_par05%
		   AND D12_TAREFA <= %Exp:mv_par06%
		   AND D12_ATIVID >= %Exp:mv_par07%
		   AND D12_ATIVID <= %Exp:mv_par08%
		   AND D12_LOCORI <> %Exp:Space(TamSx3("D12_LOCORI")[1])%
		   AND D12_DATINI <> %Exp:Space(TamSx3("D12_DATINI")[1])%
		   AND D12_HORINI <> %Exp:Space(TamSx3("D12_HORINI")[1])%
		   AND D12_DATFIM <> %Exp:Space(TamSx3("D12_DATFIM")[1])%
		   AND D12_HORFIM <> %Exp:Space(TamSx3("D12_HORFIM")[1])%
		   AND D12.%NotDel%
		  %Exp:cWhere%
		 ORDER BY %Exp:cOrder%
	
	EndSql
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)
	oBreak1 := TRBreak():New(oSection4,{||(cAliasNew)->(&cChave) },STR0017,.F.,,.F.) // Total Geral:
	TRFunction():New(oSection4:Cell("D12_QTDMOV"),NIL,"SUM",    oBreak1,,/*cPicture*/,/*uFormula*/,.F.,.F. )
	TRFunction():New(oSection4:Cell("NTOTHR"),  NIL,"TIMESUM",oBreak1,,,,.F.,.F.)
	If	mv_par09 == 2 // Sintetico
		oSection4:Hide()
	EndIf
	If	mv_par10 == 1	// Recurso Humano
		oSection3:Cell("INDICADOR"):SetTitle(STR0028) // Recurso Humano
		oSection3:Cell("INDICADOR"):SetBlock({||(cAliasNew)->D12_RECHUM+' - '+Posicione('DCD',1,xFilial('DCD')+(cAliasNew)->D12_RECHUM,'DCD_NOMFUN')})
	ElseIf mv_par10 == 2	// Recurso Fisico
		oSection3:Cell("INDICADOR"):SetTitle(STR0029) // Recurso Fisico
		oSection3:Cell("INDICADOR"):SetBlock({||(cAliasNew)->D12_RECFIS+' - '+AllTrim(Posicione("D05",1,xFilial("D05")+(cAliasNew)->D12_RECFIS,"D05_DESREC"))})
	ElseIf mv_par10 == 3	// Unitizador
		oSection3:Cell("INDICADOR"):SetTitle(STR0030) // Unitizador
		If WmsX212118("D0T")
			oSection3:Cell("INDICADOR"):SetBlock({||(cAliasNew)->D12_IDUNIT+' - '+Posicione('D0T',1,xFilial('D0T')+(cAliasNew)->D12_IDUNIT,'D0T_DESUNI')})
		Else
			oSection3:Cell("INDICADOR"):SetBlock({||(cAliasNew)->D12_IDUNIT+' - '+Posicione('DC1',1,xFilial('DC1')+(cAliasNew)->D12_IDUNIT,'DC1_DESUNI')})
		EndIf
	EndIf
	oSection2:SetParentQuery()
	oSection3:SetParentQuery()
	oSection4:SetParentQuery()
	oReport:SetMeter(D12->(RecCount()))
	dbSelectArea(cAliasNew)
	oSection1:Init()
	oSection2:Init()
	oSection3:Init()
	While !oReport:Cancel() .And. !(cAliasNew)->(Eof())
		oReport:IncMeter()
		If	oReport:Cancel()
			Exit
		EndIf
		If	cComp != (cAliasNew)->(&cChave)
			cComp := (cAliasNew)->(&cChave)
			oSection4:Finish()
			oReport:SkipLine()
			oSection1:PrintLine()
			oSection2:PrintLine()
			oSection3:PrintLine()
		EndIf
		oSection4:Init()
		oSection4:PrintLine()
		(cAliasNew)->(dbSkip())
	EndDo
	oSection4:Finish()
	oSection3:Finish()
	oSection2:Finish()
	oSection1:Finish()
Return NIL
//-----------------------------------------------------------------------
// Calculo do campo Quantidade
//-----------------------------------------------------------------------
Static Function WMSR280Calc(cAliasNew)
Local aAreaAnt   := GetArea()
Local cUM        := ""
Local nPeso      := 0
Local nAlturLC   := 0
Local nLargLC    := 0
Local nCmprLC    := 0
Local nRet       := 0
	cUM        := (cAliasNew)->B1_UM
	nPeso      := (cAliasNew)->B1_PESO
	nAlturLC   := (cAliasNew)->B5_ALTURLC
	nLargLC    := (cAliasNew)->B5_LARGLC
	nCmprLC    := (cAliasNew)->B5_COMPRLC
	// Calculo quantidade e horas
	If AllTrim(mv_par13) == '0001'		// Peso
		If	Upper(AllTrim(cUM)) == 'KG'
			nRet := (cAliasNew)->D12_QTDMOV
		Else
			nRet := (cAliasNew)->D12_QTDMOV * nPeso
		EndIf
	ElseIf AllTrim(mv_par13) == '0002'	// Volume M3
		nRet := (cAliasNew)->D12_QTDMOV * nAlturLC * nLargLC * nCmprLC
	ElseIf AllTrim(mv_par13) == '0003'	// Itens
		nRet := (cAliasNew)->D12_QTDMO2 // embalagem com 4 garrafas e igual a 1 item
	ElseIf AllTrim(mv_par13) == '0004'	// Movimentacoes
		nRet := 1
	ElseIf AllTrim(mv_par13) == '0005'	// Paletes
		nRet := 1
	ElseIf AllTrim(mv_par13) == '0006'	// Quantidade
		nRet := (cAliasNew)->D12_QTDMOV
	EndIf
	RestArea(aAreaAnt)
Return nRet