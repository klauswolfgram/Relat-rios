/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'Protheus.ch'  
#include 'WmsR320.ch'

//---------------------------------------------------------------------------
/*/{Protheus.doc} WmsR320
Relatorio de enderecos vazios 
@author Flavio Luiz Vicco
@since 13/10/2006
@version 1.0
/*/
//---------------------------------------------------------------------------
User Function WmsR320()
Local oReport
	// Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return NIL
//----------------------------------------------------------
// Definições do relatório
//----------------------------------------------------------
Static Function ReportDef()
Local cAliasNew := "SBE"
Local cTitle    := OemToAnsi(STR0001) //  Relatorio de Enderecos Vazios"
Local oReport
Local oSection1
Local oSection2
	dbSelectArea(cAliasNew)
	dbSetOrder(1)
	cAliasNew := GetNextAlias()
	// Criacao do componente de impressao
	oReport := TReport():New("WMSR320",cTitle,"WMR320",{|oReport| ReportPrint(oReport,cAliasNew)},STR0001) //  Relatorio de Enderecos Vazios
	//--------------------------------------------------------
	// Variaveis utilizadas para parametros
	//--------------------------------------------------------
	// mv_par01  //  Armazem   De  ?
	// mv_par02  //            Ate ?
	// mv_par03  //  Zona      De  ?
	// mv_par04  //            Ate ?
	// mv_par05  //  Estrutura De  ?
	// mv_par06  //            Ate ?
	// mv_par07  //  Endereco  De  ?
	// mv_par08  //            Ate ?
	//-------------------------------------------------------- 
	Pergunte(oReport:uParam,.F.)
	//  Criacao da secao utilizada pelo relatorio
	oSection1:= TRSection():New(oReport,STR0010,{"SBE"},/*aOrdem*/) //  Enderecos - Estruturas
	oSection1:SetLineStyle()
	TRCell():New(oSection1,"BE_LOCAL",	"SBE")
	TRCell():New(oSection1,"BE_CODZON",	"SBE")
	TRCell():New(oSection1,"CDESZON",	"",STR0012,,20,,{|| (cAliasNew)->DC4_DESZON}) //  Descricao
	TRCell():New(oSection1,"BE_ESTFIS",	"SBE")
	TRCell():New(oSection1,"CDESEST",	"",STR0012,,30,,{|| (cAliasNew)->DC8_DESEST}) //  Descricao
	// Criacao da secao utilizada pelo relatorio
	oSection2:= TRSection():New(oSection1,STR0011,{"SBE"},/*aOrdem*/) //  Enderecos
	oSection2:SetHeaderPage(.T.)
	TRCell():New(oSection2,"BE_LOCALIZ","SBE")
	TRCell():New(oSection2,"LACUNA1","",STR0013,,16,,{||"________________"}) //  Documento
	TRCell():New(oSection2,"LACUNA2","",STR0014,,19,,{||"___________________"}) //  Produto
	TRCell():New(oSection2,"LACUNA3","",STR0015,,17,,{||"_________________"}) //  Quantidade
Return(oReport)
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cQuebra   := ""
	oSection1:Cell("CDESZON"):HideHeader()
	oSection1:Cell("CDESEST"):HideHeader()
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	// Query do relatório da secao 1
	oSection1:BeginQuery()
	BeginSql Alias cAliasNew
		SELECT BE_FILIAL, BE_LOCAL, BE_CODZON, BE_ESTFIS, BE_LOCALIZ, DC4_DESZON, DC8_DESEST
		FROM %table:SBE% SBE
		LEFT JOIN %table:DC4%  DC4 ON DC4_FILIAL = %xFilial:DC4% AND DC4_CODZON = BE_CODZON AND DC4.%NotDel%
		LEFT JOIN %table:DC8%  DC8 ON DC8_FILIAL = %xFilial:DC8% AND DC8_CODEST = BE_ESTFIS AND DC8.%NotDel%
		WHERE BE_FILIAL = %xFilial:SBE%
		AND BE_STATUS  = '1'
		AND BE_LOCAL   BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
		AND BE_CODZON  BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
		AND BE_ESTFIS  BETWEEN %Exp:mv_par05% AND %Exp:mv_par06%
		AND BE_LOCALIZ BETWEEN %Exp:mv_par07% AND %Exp:mv_par08%
		AND SBE.%NotDel%
		ORDER BY BE_FILIAL, BE_LOCAL, BE_CODZON, BE_ESTFIS, BE_LOCALIZ
	EndSql 
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)
	oSection1:SetParentQuery()
	oSection2:SetParentQuery()
	oReport:SetMeter(SBE->(LastRec()))
	dbSelectArea(cAliasNew)
	oSection1:Init()
	oSection2:Init()
	While !oReport:Cancel() .And. !(cAliasNew)->(Eof())
		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
		If	cQuebra != (cAliasNew)->BE_FILIAL+(cAliasNew)->BE_LOCAL+(cAliasNew)->BE_CODZON+(cAliasNew)->BE_ESTFIS
			cQuebra := (cAliasNew)->BE_FILIAL+(cAliasNew)->BE_LOCAL+(cAliasNew)->BE_CODZON+(cAliasNew)->BE_ESTFIS
			oReport:EndPage()
			oSection1:PrintLine()
		EndIf
		oReport:SkipLine()
		oSection2:PrintLine()
		(cAliasNew)->(dbSkip())
	EndDo
	oSection1:Finish()
Return NIL
