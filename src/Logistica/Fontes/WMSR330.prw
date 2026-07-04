/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'  
#include 'WmsR330.ch'

//---------------------------------------------------------------------------
/*/{Protheus.doc} WmsR330
Relatorio de saldo na doca proveniente de enderecos de picking fixo
@author Flavio Luiz Vicco
@since 20/06/2006
@version 1.0
/*/
//---------------------------------------------------------------------------
User Function WmsR330()
Local oReport
	If SuperGetMv("MV_WMSNEW",.F.,.F.)
		Return WMSR331()
	EndIf

	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//----------------------------------------------------------
// Definições do relatório
//----------------------------------------------------------
Static Function ReportDef()
Local cAliasNew := "SBF"
Local cTitle    := OemToAnsi(STR0001) //  Relatorio de Saldo na Doca
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
	oReport:= TReport():New("WMSR330",cTitle,NIL,{|oReport| ReportPrint(oReport,cAliasNew)},STR0008) //  Saldo na doca proveniente de enderecos de picking fixo
	oReport:HideParamPage() //desabilitar a impressao da pagina de parametros
	//------------------------------------------------------------------------
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
	//------------------------------------------------------------------------
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
	//------------------------------------------------------------------------
	oSection1:= TRSection():New(oReport,STR0009,{"SBF","SBE"},/*aOrdem*/) //  Saldos por endereco
	oSection1:SetHeaderPage()
	TRCell():New(oSection1,"BF_LOCALIZ",	"SBF",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"BF_PRODUTO",	"SBF")
	TRCell():New(oSection1,"BF_QUANT",		"SBF",,PesqPictQt('BF_QUANT'))
	TRCell():New(oSection1,"BE_LOCAL",		"SBE")
	TRCell():New(oSection1,"BE_LOCALIZ",	"SBE")
Return(oReport)
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1 := oReport:Section(1)
Local cQuebra	  := ""
Local cIndSBE	  := ""
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	// Query do relatório da secao 1
	oReport:Section(1):BeginQuery()	
	BeginSQL Alias cAliasNew

		SELECT BF_LOCALIZ, BF_PRODUTO, BF_QUANT, BF_EMPENHO, BE_LOCAL, BE_LOCALIZ

		FROM %table:SBF% SBF, %table:SBE% SBE

			LEFT JOIN %table:DC8% DOCA ON DOCA.DC8_FILIAL = %xFilial:DC8% AND DOCA.DC8_TPESTR ='5' AND DOCA.%NotDel%
			LEFT JOIN %table:DC8% PICK ON PICK.DC8_FILIAL = %xFilial:DC8% AND PICK.DC8_TPESTR ='2' AND PICK.%NotDel%

		WHERE BF_FILIAL = %xFilial:SBF% AND
				BF_ESTFIS = DOCA.DC8_CODEST AND
				BF_QUANT  > 0 AND
			
				SBF.%NotDel% AND
				BE_FILIAL = %xFilial:SBE% AND
				BE_ESTFIS = PICK.DC8_CODEST AND
				BE_CODPRO = BF_PRODUTO AND
				SBE.%NotDel%

		ORDER BY BF_LOCALIZ, BF_PRODUTO
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
		If	cQuebra != (cAliasNew)->BF_LOCALIZ + (cAliasNew)->BF_PRODUTO
			cQuebra := (cAliasNew)->BF_LOCALIZ + (cAliasNew)->BF_PRODUTO
			oReport:Section(1):Cell("BF_LOCALIZ"):Show()
			oReport:Section(1):Cell("BF_PRODUTO"):Show()
			oReport:Section(1):Cell("BF_QUANT"):Show()
		Else
			oReport:Section(1):Cell("BF_LOCALIZ"):Hide()
			oReport:Section(1):Cell("BF_PRODUTO"):Hide()
			oReport:Section(1):Cell("BF_QUANT"):Hide()
		EndIf
		oSection1:PrintLine()
		(cAliasNew)->(dbSkip())
	EndDo
	oSection1:Finish()

	If	File(cIndSBE+OrdBagExt())
		Ferase(cIndSBE+OrdBagExt())
	EndIf
Return NIL
