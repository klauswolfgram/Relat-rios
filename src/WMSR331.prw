/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'  
#include 'WMSR331.ch'

//---------------------------------------------------------------------------
/*/{Protheus.doc} WMSR331
Relatorio de saldo na doca proveniente de enderecos de picking fixo
@author Flavio Luiz Vicco
@since 20/06/2006
@version 1.0
/*/
//---------------------------------------------------------------------------
User Function WMSR331()
Local oReport
	If !SuperGetMv("MV_WMSNEW",.F.,.F.)
		Return WMSR330()
	EndIf
	
	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//----------------------------------------------------------
// Definições do relatório
//----------------------------------------------------------
Static Function ReportDef()
Local cAliasNew := "D14"
Local cTitle    := OemToAnsi(STR0001) // Relatorio de Saldo na Doca
Local oReport 
Local oSection1 
Local oCell
	dbSelectArea(cAliasNew)
	dbSetOrder(1)
	cAliasNew := GetNextAlias()

	//------------------------------------------------------------------------
	// Criacao do componente de impressao
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao
	//------------------------------------------------------------------------
	oReport:= TReport():New("WMSR331",cTitle,NIL,{|oReport| ReportPrint(oReport,cAliasNew)},STR0002) // Saldo na doca proveniente de enderecos de picking fixo
	oReport:HideParamPage() //desabilitar a impressao da pagina de parametros
	//------------------------------------------------------------------------
	// Criacao da secao utilizada pelo relatorio
	// TRSection():New
	// ExpO1 : Objeto TReport que a secao pertence
	// ExpC2 : Descricao da seçao
	// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
	//        sera considerada como principal para a seção.
	// ExpA4 : Array com as Ordens do relatório
	// ExpL5 : Carrega campos do SX3 como celulas
	//        Default : False
	// ExpL6 : Carrega ordens do Sindex
	//        Default : False
	// ----------------------------------------------------------------------
	// Criacao da celulas da secao do relatorio
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
	//------------------------------------------------------------------------
	oSection1:= TRSection():New(oReport,STR0003,{"D14","SBE"},/*aOrdem*/) // Saldos por endereco
	oSection1:SetHeaderPage()
	TRCell():New(oSection1,"D14_ENDER",  "D14",/*Titulo*/,/*Picture*/             ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"D14_PRODUT", "D14",/*Titulo*/,/*Picture*/             ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"D14_PRDORI", "D14",/*Titulo*/,/*Picture*/             ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"D14_SLDDIS", "D14","Saldo Disponível",PesqPictQt('D14_QTDEST'),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"BE_LOCAL",   "SBE",/*Titulo*/,/*Picture*/             ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"BE_LOCALIZ", "SBE",/*Titulo*/,/*Picture*/             ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Return(oReport)
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1 := oReport:Section(1)
Local cQuebra	:= ""
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	// Query do relatório da secao 1
	oReport:Section(1):BeginQuery()		
	BeginSQL Alias cAliasNew
		SELECT D14.D14_ENDER, 
	           D14.D14_PRODUT, 
               D14.D14_PRDORI,
		       (D14.D14_QTDEST - (D14.D14_QTDSPR + D14.D14_QTDEMP + D14.D14_QTDBLQ)) D14_SLDDIS, 
		       SBE.BE_LOCAL, 
		       SBE.BE_LOCALIZ
		  FROM %table:D14% D14
		 INNER JOIN %table:DC8% DC8 
		    ON DC8.DC8_FILIAL = %xFilial:DC8%
		   AND DC8.DC8_CODEST = D14.D14_ESTFIS 
		   AND DC8.DC8_TPESTR = '5' 
		   AND DC8.%NotDel%
		  LEFT JOIN %table:SBE% SBE 
		    ON SBE.BE_FILIAL  = %xFilial:SBE%
		   AND SBE.BE_CODPRO  = D14.D14_PRODUT 		   
		   AND SBE.%NotDel%
		 WHERE D14.D14_FILIAL = %xFilial:D14% 
		   AND (D14.D14_QTDEST - (D14.D14_QTDSPR + D14.D14_QTDEMP + D14.D14_QTDBLQ)) > 0 
		   AND D14.%NotDel%
		 ORDER BY D14.D14_ENDER, D14.D14_PRODUT
	EndSQL 
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
		If	cQuebra != (cAliasNew)->D14_ENDER + (cAliasNew)->D14_ENDER
			cQuebra := (cAliasNew)->D14_ENDER + (cAliasNew)->D14_ENDER
			oReport:Section(1):Cell("D14_ENDER"):Show()
			oReport:Section(1):Cell("D14_PRODUT"):Show()
			oReport:Section(1):Cell("D14_PRDORI"):Show()
			oReport:Section(1):Cell("D14_SLDDIS"):Show()
		Else
			oReport:Section(1):Cell("D14_ENDER"):Hide()
			oReport:Section(1):Cell("D14_PRODUT"):Hide()
			oReport:Section(1):Cell("D14_PRDORI"):Hide()
			oReport:Section(1):Cell("D14_SLDDIS"):Hide()
		EndIf
		oSection1:PrintLine()
	
		(cAliasNew)->(dbSkip())
	EndDo
	oSection1:Finish()
Return NIL