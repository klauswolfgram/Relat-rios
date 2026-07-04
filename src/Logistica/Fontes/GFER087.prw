/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER087
Relatorio de Despesa de Frete por Representante e Destinatário 

@sample

@author Gustavo H. Baptista
@since 18/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER087()
	Local oReport

	If TRepInUse() // teste padrão 
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CriaTabela
Cria tabelas auxiliares para a geração do relatório.

@sample

@author Gustavo Baptista
@since 18/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CriaTabela()

	// Criacao da tabela temporaria p/ imprimir o relat
	
	aTTREP:={{"REPRES ","C",TamSX3("GW1_REPRES" )[1],0}}
	
	cAliasRepr := GFECriaTab({aTTREP, {"REPRES"}})
	
	aTT :={ {"REPDEST"	,"C",TamSX3("GW1_CDDEST" )[1]+TamSX3("GW1_REPRES" )[1],0},;
			{"REPRES" 	,"C",TamSX3("GW1_REPRES" )[1],0},;
			{"CDDEST"	,"C",TamSX3("GW1_CDDEST" )[1],0},;
			{"DSDEST"	,"C",TamSX3("GU3_NMEMIT" )[1],0},;
			{"PESO"		,"N",TamSX3("GW8_PESOR" )[1]+5,TamSX3("GW8_PESOR" )[2]},;
			{"VALOR"	,"N",TamSX3("GW8_VALOR" )[1]+5,TamSX3("GW8_VALOR" )[2]},;
			{"VOLUME"	,"N",TamSX3("GW8_VOLUME"  )[1]+5,TamSX3("GW8_VOLUME"  )[2]},;
			{"QTDE"		,"N",TamSX3("GW8_QTDE" )[1]+5,TamSX3("GW8_QTDE" )[2]},;
			{"DESPFRETE","N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
			{"FRPESO"	,"N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
			{"FRVAL"	,"N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
			{"FRVOL"	,"N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
			{"FRQTD"	,"N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
			{"QTDDC"	,"N",7,0}}
			 
	cAliasRel := GFECriaTab({aTT, {"REPRES","REPDEST"}})

	aTotalTable := {{"REPRES","C",TamSX3("GW1_REPRES" )[1],0},;
					{"TPESO","N",TamSX3("GW8_PESOR" )[1]+5,TamSX3("GW8_PESOR" )[2]},;
					{"TVAL","N",TamSX3("GW8_VALOR" )[1]+5,TamSX3("GW8_VALOR" )[2]},;
					{"TVOL","N",TamSX3("GW8_VOLUME" )[1]+5,TamSX3("GW8_VOLUME" )[2]},;
					{"TQTD","N",TamSX3("GW8_QTDE" )[1]+5,TamSX3("GW8_QTDE" )[2]},;
					{"TFRETE","N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
					{"TFRPESO","N",TamSX3("GWM_VLFRET" )[1]+5,TamSX3("GWM_VLFRET" )[2]},;
					{"TFRVAL","N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
					{"TFRVOL","N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
					{"TFRQTD","N",TamSX3("GWM_VLFRET" )[1],TamSX3("GWM_VLFRET" )[2]},;
					{"TQTDDC","N",7,0}}

	cAliasTot := GFECriaTab({aTotalTable, {"REPRES"}})
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Monta a estrutura do relatório

@sample

@author Gustavo Baptista
@since 18/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport	 := TReport():New("GFER087","Relatório de Frete por Representante e Destinatário","GFER087", {|oReport| ReportPrint(oReport)},"Despesa de Frete por Representante e Destinatário ")
	Local aOrdem   := {}
	Local cTotparc :="Total Parcial: "
	Local cTotfin  :="Total Final: "
	
	oReport:SetLandscape()   // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	//oReport:nFontBody	:= 10 // Define o tamanho da fonte.
	//oReport:nLineHeight	:= 50 // Define a altura da linha.    
	oReport:NDEVICE := 4     

	Pergunte("GFER087",.F.)

	Aadd( aOrdem, "Despesa de Frete por Representante e Destinatário " )

	oSection1 := TRSection():New(oReport,"Despesa de Frete por Representante e Destinatário ",{"(cAliasRepr)"},aOrdem) 
	oSection1:SetTotalInLine(.F.)
	oSection1:SetHeaderSection(.T.)

	TRCell():New(oSection1,"(cAliasRepr)->REPRES"  ,"(cAliasRepr)","Representante"				,"@!", 40,/*lPixel*/, )

	oSection2 := TRSection():New(oSection1,"Despesa de Frete por Representante e Destinatário ",{"(cAliasRel)"},aOrdem) //  //"Total Parcial"
	oSection2 :SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.T.)
	TRCell():New(oSection2,"(cAliasRel)->DSDEST" 	,"(cAliasRel)","Destinatário" 			,"@!", 40,/*lPixel*/)
	TRCell():New(oSection2,"(cAliasRel)->QTDDC" 	,"(cAliasRel)","Qtde Documentos "			,"@E 9999999", 7,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->PESO" 		,"(cAliasRel)","Peso Total"				,"@E 99,999,999.99", 20,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->VALOR" 	,"(cAliasRel)","Valor Total"				,"@E 99,999,999.99", 20,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->VOLUME" 	,"(cAliasRel)","Volume Total"				,"@E 99,999,999.99", 20,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->QTDE" 		,"(cAliasRel)","Qtde Total"				,"@E 99,999,999.99", 20,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->DESPFRETE" ,"(cAliasRel)","Despesa Frete"			,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->FRPESO" 	,"(cAliasRel)","$ Frete x Peso"			,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->FRVAL" 	,"(cAliasRel)","% Frete x Valor"			,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->FRVOL" 	,"(cAliasRel)","$ Frete x Volume"			,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->FRQTD" 	,"(cAliasRel)","$ Frete x Quantidade"		,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	

	oSection3 := TRSection():New(oSection1,"Total Parcial",{"cAliasTot"},aOrdem) //  //"Total Parcial"
	oSection3 :SetTotalInLine(.F.)
	oSection3:SetHeaderSection(.F.)
	TRCell():New(oSection3,"cTotparc"    			,""			," "   			    ,"@!"			   ,40,/*lPixel*/, {||cTotparc})
	TRCell():New(oSection3,"(cAliasTot)->TQTDDC" 	,"(cAliasTot)","Qtde Documentos"	,"@E 9999999"	   , 7,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TPESO" 	,"(cAliasTot)","Peso"				,"@E 99,999,999.99", 20,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TVAL" 		,"(cAliasTot)","Valor"			,"@E 99,999,999.99", 20,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TVOL" 		,"(cAliasTot)","Volume"			,"@E 99,999,999.99", 20,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TQTD" 		,"(cAliasTot)","Quantidade"		,"@E 99,999,999.99", 20,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRETE" 	,"(cAliasTot)","Frete"			,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRPESO"	,"(cAliasTot)","$ Frete x Peso"	,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRVAL" 	,"(cAliasTot)","% Frete x Valor"	,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRVOL" 	,"(cAliasTot)","$ Frete x Volume"	,"@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRQTD" 	,"(cAliasTot)","$ Frete x Quantidade","@E 99,999,999.99", 13,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/,"RIGHT")
	

	oSection4 := TRSection():New(oSection1,"Total Final",{"cAliasTot"},aOrdem) //  //"Total Final"
	oSection4:SetTotalInLine(.F.)
	oSection4:SetHeaderSection(.F.)
	TRCell():New(oSection4,"cTotfin"    ,"","Total Parcial "	  ,	"@!",40,/*lPixel*/,{||cTotfin},/*cAlign*/,/*lLineBreak*/)
	TRCell():New(oSection4,"aTotais[10]","","Qtde Documentos"	  ,	"@E 9999999",7,/*lPixel*/,{||aTotais[10]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[1]"	,"","Peso"				  ,	"@E 99,999,999.99",20,/*lPixel*/,{||aTotais[1]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[2]"	,"","Valor"				  ,	"@E 99,999,999.99",20,/*lPixel*/,{||aTotais[2]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[3]" ,"","Volume"			  ,	"@E 99,999,999.99",20,/*lPixel*/,{||aTotais[3]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[4]" ,"","Quantidade"		  ,	"@E 99,999,999.99",20,/*lPixel*/,{||aTotais[4]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[5]" ,"","Frete"				  ,	"@E 99,999,999.99",13,/*lPixel*/,{||aTotais[5]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[6]" ,"","$ Frete x Peso"	  ,	"@E 99,999,999.99",13,/*lPixel*/,{||aTotais[6]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[7]" ,"","% Frete x Valor"	  ,	"@E 99,999,999.99",13,/*lPixel*/,{||aTotais[7]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[8]" ,"","$ Frete x Volume"	  ,	"@E 99,999,999.99",13,/*lPixel*/,{||aTotais[8]},/*cAlign*/,/*lLineBreak*/,"RIGHT")
	TRCell():New(oSection4,"aTotais[9]" ,"","$ Frete x Quantidade",	"@E 99,999,999.99",13,/*lPixel*/,{||aTotais[9]},/*cAlign*/,/*lLineBreak*/,"RIGHT")

Return(oReport)

Static Function ReportPrint(oReport)
	Local oSection1     := oReport:Section(1)
	Local oSection2     := oReport:Section(1):Section(1)
	Local oSection3     := oReport:Section(1):Section(2)
	Local oSection4     := oReport:Section(1):Section(3)
	Local aArea         := GetArea()
	
	Private cDados      := ""
	Private cFilialIni  := ""
	Private cFilialFim  := ""
	Private dDataIni    := Nil
	Private dDataFim    := Nil
	Private cRepIni     := ""
	Private cRepFim     := ""
	Private cImpRecup   := ""
	Private cImpAuton   := ""
	Private cDctSemDesp := ""
	Private cTipDesp    := ""
	Private aTotais[10]
	Private cSeek       := ""
	Private cCritRat    := ""
	Private nVlFret     := 0
	Private nVlIss      := 0
	Private nVlIrrf     := 0
	Private nVlInau     := 0
	Private nVlInem     := 0
	Private nVlSest     := 0
	Private nVlIcms     := 0
	Private nVlCofi     := 0
	Private nVlPis      := 0
	Private cAliasRel   := ""
	Private cAliasTot   := ""
	Private cAliasRepr  := ""
	Private nVlIBS      := 0
	Private nVlIBM      := 0
	Private nVlCBS      := 0

	oReport:SetMeter(0)

	aTotais[1] := 0
	aTotais[2] := 0
	aTotais[3] := 0
	aTotais[4] := 0	
	aTotais[5] := 0
	aTotais[6] := 0
	aTotais[7] := 0
	aTotais[8] := 0
	aTotais[9] := 0
	aTotais[10] := 0

	CriaTabela()

	CarregaDados(oReport)

	(cAliasRepr)->(dbGoTop())
	oReport:SetMeter((cAliasRel)->(LastRec()))

	Do While ((cAliasRepr)->(!Eof())) // Para cada Representante
		oSection1:Init()
		oSection1:PrintLine()
		oSection1:Finish()
		oSection2:Init()

		(cAliasRel)->(dbSetOrder(1))
		If (cAliasRel)->(dbSeek((cAliasRepr)->REPRES))
			Do While (cAliasRel)->(!Eof()) .And. (cAliasRel)->REPRES== (cAliasRepr)->REPRES // Imprimir todas os Destinatários
				oSection2:PrintLine()
				
				(cAliasRel)->(dbSkip())
			EndDo
		EndIf
		oSection2:Finish()
		
		oSection3:Init()
		(cAliasTot)->(dbSetOrder(1))
		If (cAliasTot)->(dbSeek((cAliasRepr)->REPRES))
			Do While (cAliasTot)->(!Eof()) .And. (cAliasTot)->REPRES == (cAliasRepr)->REPRES // Por Fim imprime o total do estado (total parcial)
				oSection3:PrintLine()
	
				//Faz a soma para gerar os totais finais
				aTotais[1] 	+= (cAliasTot)->TPESO
				aTotais[2]	+= (cAliasTot)->TVAL
				aTotais[3] 	+= (cAliasTot)->TVOL
				aTotais[4]	+= (cAliasTot)->TQTD	
				aTotais[5] 	+= (cAliasTot)->TFRETE
				aTotais[6] 	+= (cAliasTot)->TFRPESO
				aTotais[7] 	+= (cAliasTot)->TFRVAL
				aTotais[8] 	+= (cAliasTot)->TFRVOL
				aTotais[9] 	+=	(cAliasTot)->TFRQTD
				aTotais[10] +=(cAliasTot)->TQTDDC
	
				(cAliasTot)->(dbSkip())
			EndDo
		EndIf
		oSection3:Finish()

		(cAliasRepr)->(dbSkip())
	EndDo

	oSection4:Init()
	oSection4:PrintLine()
	oSection4:Finish()

	GFEDelTab(cAliasTot)
	GFEDelTab(cAliasRel)
	GFEDelTab(cAliasRepr)
	RestArea(aArea)
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaDados
Realiza a busca dos dados da seleção e cria a tabela temporária de impressão
Generico.

@sample
CarregaDados()

@author Gustavo Baptista
@since 18/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaDados(oReport)
	Local cAliasGW1  := Nil
	Local cAliasGWM  := Nil
	Local cAliasGW8  := Nil
	Local cAliasGU3  := Nil
	Local lFrete     := 0
	Local cNRDCAnt   := ""
	Local cNRDFAnt   := ""
	Local cWhere     := ""
	Local cGU3NMEMIT := ""
	Local cGW1REPRES := ""
	
	cFilialIni  := MV_PAR01
	cFilialFim  := MV_PAR02
	dDataIni    := MV_PAR03
	dDataFim    := MV_PAR04
	cRepIni     := MV_PAR05
	cRepFim     := MV_PAR06
	cImpRecup   := MV_PAR07
	cImpAuton   := MV_PAR08
	cDctSemDesp := MV_PAR09
	cTipDesp    := MV_PAR10
	cCritRat    := MV_PAR11
	cDestIni    := MV_PAR12
	cDestFim    := MV_PAR13

	// Faz a busca dos dados dos movimentos, movimentos contábeis e cálculo de frete
	cWhere := ""
	If Len(AllTrim(cRepIni)) > 0 
		cWhere += " AND GW1.GW1_REPRES >= '"+cRepIni +"'"
		cWhere += " AND GW1.GW1_REPRES <= '"+cRepFim +"'"
	EndIf
	cWhere := "%" + cWhere + "%"
	cAliasGW1 := GetNextAlias()
	BeginSql Alias cAliasGW1
		SELECT GW1.GW1_FILIAL,
				GW1.GW1_CDTPDC,
				GW1.GW1_EMISDC,
				GW1.GW1_SERDC,
				GW1.GW1_NRDC,
				GW1.GW1_REPRES,
				GW1.GW1_CDDEST
		FROM %Table:GW1% GW1
		WHERE GW1.GW1_FILIAL >= %Exp:cFilialIni%
		AND GW1.GW1_FILIAL <= %Exp:cFilialFim%
		AND GW1.GW1_DTEMIS >= %Exp:DToS(dDataIni)%
		AND GW1.GW1_DTEMIS <= %Exp:DToS(dDataFim)%
		AND GW1.GW1_CDDEST >= %Exp:cDestIni%
		AND GW1.GW1_CDDEST <= %Exp:cDestFim%
		AND GW1.%NotDel%
		%Exp:cWhere%
	EndSql
	Do While !oReport:Cancel() .And. (cAliasGW1)->(!Eof())
		// Inicializa representante truncando o tamanho devido erros na base de teste automatizado
		cGW1REPRES := (cAliasGW1)->GW1_REPRES

		oReport:IncMeter()

		// Busca nome do emitente
		cAliasGU3 := GetNextAlias()
		BeginSql Alias cAliasGU3
			SELECT GU3.GU3_NMEMIT
			FROM %Table:GU3% GU3
			WHERE GU3.GU3_FILIAL = %xFilial:GU3%
			AND GU3.GU3_CDEMIT = %Exp:(cAliasGW1)->GW1_CDDEST%
			AND GU3.%NotDel%
		EndSql
		cGU3NMEMIT := (cAliasGU3)->GU3_NMEMIT
		(cAliasGU3)->(dbCloseArea())

		//cTipDesp     ->Tipo de Despesa 
		cWhere := ""
		If cTipDesp == 1
			//considerar os registros de Rateios de Frete de Cálculo de Frete (GWM_TPDOC = 1)
			cWhere += " AND GWM.GWM_TPDOC = '1'"
			
		ElseIf cTipDesp == 2
			//considerar os registros de Rateios de Frete de Documento de Frete ou Contrato com Autônomo (GWM_TPDOC = 2 ou 3)
			cWhere += " AND (GWM.GWM_TPDOC = '2' OR GWM.GWM_TPDOC = '3')"

		Else
			//verificar primeiramente se o Documento de Carga possui Rateios de Frete de Documento de Frete 
			//ou Contrato com Autônomo (GWM_TPDOC = 2 ou 3) usando-o em caso positivo
			// e em caso negativo usando usar os Rateios de Frete de Cálculo de Frete (GWM_TPDOC = 1). 
			cWhere += " AND (GWM.GWM_TPDOC = '2' OR GWM.GWM_TPDOC = '3')"
		EndIf
		cWhere := "%" + cWhere + "%"
		cAliasGWM := GetNextAlias()
		BeginSql Alias cAliasGWM
			SELECT *
			FROM %Table:GWM% GWM
			WHERE GWM.GWM_FILIAL = %Exp:(cAliasGW1)->GW1_FILIAL%
			AND GWM.GWM_CDTPDC = %Exp:(cAliasGW1)->GW1_CDTPDC%
			AND GWM.GWM_EMISDC = %Exp:(cAliasGW1)->GW1_EMISDC%
			AND GWM.GWM_SERDC = %Exp:(cAliasGW1)->GW1_SERDC%
			AND GWM.GWM_NRDC = %Exp:(cAliasGW1)->GW1_NRDC%
			AND GWM.%NotDel%
			%Exp:cWhere%
			ORDER BY GWM.GWM_FILIAL,
						GWM.GWM_TPDOC,
						GWM.GWM_CDESP,
						GWM.GWM_CDTRP,
						GWM.GWM_SERDOC,
						GWM.GWM_NRDOC,
						GWM.GWM_DTEMIS,
						GWM.GWM_CDTPDC,
						GWM.GWM_EMISDC,
						GWM.GWM_SERDC,
						GWM.GWM_NRDC,
						GWM.GWM_SEQGW8,
						GWM.GWM_DTEMDC,
						GWM.GWM_ITEM
		EndSql
		If (cAliasGWM)->(Eof()) .And. cTipDesp > 2
			//verificar primeiramente se o Documento de Carga possui Rateios de Frete de Documento de Frete 
			//ou Contrato com Autônomo (GWM_TPDOC = 2 ou 3) usando-o em caso positivo
			// e em caso negativo usando usar os Rateios de Frete de Cálculo de Frete (GWM_TPDOC = 1). 
			(cAliasGWM)->(dbCloseArea())

			cAliasGWM :=GetNextAlias()
			BeginSql Alias cAliasGWM
				SELECT *
				FROM %Table:GWM% GWM
				WHERE GWM.GWM_FILIAL = %Exp:(cAliasGW1)->GW1_FILIAL%
				AND GWM.GWM_CDTPDC = %Exp:(cAliasGW1)->GW1_CDTPDC%
				AND GWM.GWM_EMISDC = %Exp:(cAliasGW1)->GW1_EMISDC%
				AND GWM.GWM_SERDC = %Exp:(cAliasGW1)->GW1_SERDC%
				AND GWM.GWM_NRDC = %Exp:(cAliasGW1)->GW1_NRDC%
				AND GWM.GWM_TPDOC = '1'
				AND GWM.%NotDel%
			EndSql
		ElseIf (cAliasGWM)->( Eof() ) .And. cDctSemDesp == 2
			(cAliasGW1)->(dbSkip())
			(cAliasGWM)->(dbCloseArea())
			Loop
		ElseIf (cAliasGWM)->(Eof()) .And. cDctSemDesp == 1
			cAliasGW8 := GetNextAlias()
			BeginSql Alias cAliasGW8
				SELECT GW8.GW8_PESOR,
						GW8.GW8_VALOR,
						GW8.GW8_VOLUME,
						GW8.GW8_QTDE
				FROM %Table:GW8% GW8
				WHERE GW8.GW8_FILIAL = %Exp:(cAliasGW1)->GW1_FILIAL%
				AND GW8.GW8_CDTPDC = %Exp:(cAliasGW1)->GW1_CDTPDC%
				AND GW8.GW8_EMISDC = %Exp:(cAliasGW1)->GW1_EMISDC%
				AND GW8.GW8_SERDC = %Exp:(cAliasGW1)->GW1_SERDC%
				AND GW8.GW8_NRDC = %Exp:(cAliasGW1)->GW1_NRDC%
				AND GW8.%NotDel%
			EndSql
			Do While (cAliasGW8)->(!Eof())
				//Cria um novo registro de estado
				(cAliasRepr)->(dbSetOrder(1))
				If (cAliasRepr)->(!dbSeek(cGW1REPRES))
					// Cria um novo registro com o novo item
					RecLock((cAliasRepr), .T.)
						(cAliasRepr)->REPRES := cGW1REPRES
					(cAliasRepr)->(MsUnlock())
				EndIf	
				// Cria um novo registro com o novo item
				(cAliasRel)->(dbSetOrder(2))
				If (cAliasRel)->(dbSeek(cGW1REPRES+(cAliasGW1)->GW1_CDDEST,.T.))
					// Altera o registro corrente
					RecLock((cAliasRel), .F.)
				Else
					// Cria um novo registro com o novo item
					RecLock((cAliasRel), .T.)
						(cAliasRel)->REPRES  := cGW1REPRES
						(cAliasRel)->REPDEST := cGW1REPRES+(cAliasGW1)->GW1_CDDEST
						(cAliasRel)->CDDEST  := (cAliasGW1)->GW1_CDDEST
						(cAliasRel)->DSDEST  := cGU3NMEMIT
				EndIf
				
				If (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC <> cNRDCAnt
					(cAliasRel)->QTDDC++
					cNRDCAnt := (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC
				EndIf
				
				(cAliasRel)->PESO   += (cAliasGW8)->GW8_PESOR
				(cAliasRel)->VALOR  += (cAliasGW8)->GW8_VALOR
				(cAliasRel)->VOLUME += (cAliasGW8)->GW8_VOLUME
				(cAliasRel)->QTDE   += (cAliasGW8)->GW8_QTDE
				
				(cAliasRel)->(MSUnlock())
				
				(cAliasGW8)->(dbSkip())
			EndDo
		EndIf

		cNRDFAnt := ""
		Do While !(cAliasGWM)->( Eof() ) ;
			.And. (cAliasGWM)->GWM_FILIAL == (cAliasGW1)->GW1_FILIAL ;
			.And. (cAliasGWM)->GWM_CDTPDC == (cAliasGW1)->GW1_CDTPDC ;
			.And. (cAliasGWM)->GWM_EMISDC == (cAliasGW1)->GW1_EMISDC ;
			.And. (cAliasGWM)->GWM_SERDC  == (cAliasGW1)->GW1_SERDC ;
			.And. (cAliasGWM)->GWM_NRDC   == (cAliasGW1)->GW1_NRDC

			CarregaImpostos(cAliasGWM)

			//Cria um novo registro de estado
			(cAliasRepr)->(dbSetOrder(1))
			If (cAliasRepr)->(!dbSeek(cGW1REPRES))
				// Cria um novo registro com o novo item
				RecLock((cAliasRepr), .T.)
					(cAliasRepr)->REPRES := cGW1REPRES
				(cAliasRepr)->(MsUnlock())
			EndIf

			// Cria um novo registro com o novo item
			(cAliasRel)->(dbSetOrder(2))
			If (cAliasRel)->(dbSeek(cGW1REPRES+(cAliasGW1)->GW1_CDDEST,.T.))
				// Altera o registro corrente
				RecLock((cAliasRel), .F.)
			Else
				// Cria um novo registro com o novo item
				RecLock((cAliasRel), .T.)
					(cAliasRel)->REPRES  := cGW1REPRES
					(cAliasRel)->REPDEST := cGW1REPRES+(cAliasGW1)->GW1_CDDEST
					(cAliasRel)->CDDEST  := (cAliasGW1)->GW1_CDDEST
					(cAliasRel)->DSDEST  := cGU3NMEMIT
			EndIf
			
			If (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC <> cNRDCAnt
				(cAliasRel)->QTDDC := (cAliasRel)->QTDDC + 1
				cNRDCAnt := (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC
			EndIf

			If (cAliasGWM)->GWM_FILIAL + (cAliasGWM)->GWM_CDESP + (cAliasGWM)->GWM_CDTRP + ;
				(cAliasGWM)->GWM_SERDOC + (cAliasGWM)->GWM_NRDOC + (cAliasGWM)->GWM_DTEMIS == cNRDFAnt .OR. Empty(cNRDFAnt) 
				cAliasGW8 := GetNextAlias()
				BeginSql Alias cAliasGW8
					SELECT GW8.GW8_PESOR,
							GW8.GW8_VALOR,
							GW8.GW8_VOLUME,
							GW8.GW8_QTDE
					FROM %Table:GW8% GW8
					WHERE GW8.GW8_FILIAL = %Exp:(cAliasGWM)->GWM_FILIAL%
					AND GW8.GW8_CDTPDC = %Exp:(cAliasGWM)->GWM_CDTPDC%
					AND GW8.GW8_EMISDC = %Exp:(cAliasGWM)->GWM_EMISDC%
					AND GW8.GW8_SERDC = %Exp:(cAliasGWM)->GWM_SERDC%
					AND GW8.GW8_NRDC = %Exp:(cAliasGWM)->GWM_NRDC%
					AND GW8.GW8_SEQ = %Exp:(cAliasGWM)->GWM_SEQGW8%
					AND GW8.%NotDel%
				EndSql
				If (cAliasGW8)->(!Eof())
					(cAliasRel)->PESO   += (cAliasGW8)->GW8_PESOR
					(cAliasRel)->VALOR  += (cAliasGW8)->GW8_VALOR
					(cAliasRel)->VOLUME += (cAliasGW8)->GW8_VOLUME
					(cAliasRel)->QTDE   += (cAliasGW8)->GW8_QTDE
				EndIf
				(cAliasGW8)->(dbCloseArea())
				cNRDFAnt := (cAliasGWM)->GWM_FILIAL + (cAliasGWM)->GWM_CDESP + (cAliasGWM)->GWM_CDTRP + (cAliasGWM)->GWM_SERDOC + (cAliasGWM)->GWM_NRDOC + (cAliasGWM)->GWM_DTEMIS
			EndIf

			lFrete := nVlFret
			
			//cImpRecup    ->Impostos a recuperar
			If cImpRecup == 1 
				//1=Descontar, deve-se subtrair o valor de ICMS (GWM_VLICMS), PIS (GWM_VLPIS) do valor do frete (GWM_VLFRET)
				//e COFINS (GWM_VLCOFI) do valor do frete (GWM_VLFRET)
				If AllTrim((cAliasGWM)->GWM_TPDOC) == '1' 
					lFrete := FretePrevisto(lFrete,cAliasGWM)
				ElseIf AllTrim((cAliasGWM)->GWM_TPDOC) == '2'
					lFrete := FreteRealizado(lFrete,cAliasGWM)
				EndIf
			EndIf

			//cImpAuton    ->Impostos dos Autônomos
			if cImpAuton == 1 .AND. AllTrim((cAliasGWM)->GWM_TPDOC) == '3'
				lFrete += (nVlIss + nVlIrrf + nVlInau + nVlInem + nVlSest + nVlIBM)
			EndIf
			(cAliasRel)->DESPFRETE	+= lFrete

			(cAliasRel)->(MsUnlock())

			(cAliasGWM)->(dbSkip())
		EndDo		
		(cAliasGWM)->(dbCloseArea())
		(cAliasGW1)->(dbSkip())
	EndDo
	
	//Atualiza a tabela com os valores que precisam ser calculados. 
	(cAliasRel)->( dbGoTop() )
	Do While (cAliasRel)->(!Eof())
		RecLock((cAliasRel), .F.)
			(cAliasRel)->FRPESO := ((cAliasRel)->DESPFRETE / (cAliasRel)->PESO )
			(cAliasRel)->FRVAL  := ((cAliasRel)->DESPFRETE / (cAliasRel)->VALOR ) * 100
			(cAliasRel)->FRVOL  := ((cAliasRel)->DESPFRETE / (cAliasRel)->VOLUME )
			(cAliasRel)->FRQTD  := ((cAliasRel)->DESPFRETE / (cAliasRel)->QTDE )
		(cAliasRel)->(MsUnlock())

		(cAliasTot)->(dbSetOrder(1))
		If (cAliasTot)->(dbSeek((cAliasRel)->REPRES))
			RecLock((cAliasTot),.F.)
		Else
			RecLock((cAliasTot),.T.)
			(cAliasTot)->REPRES := (cAliasRel)->REPRES
		EndIf

		//Gera totalizadores finais
		(cAliasTot)->TPESO   += (cAliasRel)->PESO
		(cAliasTot)->TVAL    += (cAliasRel)->VALOR
		(cAliasTot)->TVOL    += (cAliasRel)->VOLUME
		(cAliasTot)->TQTD    += (cAliasRel)->QTDE

		(cAliasTot)->TFRETE  += (cAliasRel)->DESPFRETE
		(cAliasTot)->TFRPESO += (cAliasRel)->FRPESO
		(cAliasTot)->TFRVAL  += (cAliasRel)->FRVAL
		(cAliasTot)->TFRVOL  += (cAliasRel)->FRVOL
		(cAliasTot)->TFRQTD  += (cAliasRel)->FRQTD
		(cAliasTot)->TQTDDC  += (cAliasRel)->QTDDC

		(cAliasTot)->(MsUnlock())

		(cAliasRel)->( dbSkip() )
	EndDo
	(cAliasGW1)->(dbCloseArea())
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} FretePrevisto
Efetua os descontos do frete previsto ( se for possível)

@sample

@author Gustavo H. Baptista
@since 18/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/

Static Function FretePrevisto(lFrete,cAliasGWM)
	Local cAliasGWF := GetNextAlias()
	// Busca o cálculo de frete relacionado ao Movimento Contábil

	BeginSql Alias cAliasGWF
		SELECT GWF.GWF_CRDICM,
				GWF.GWF_CRDPC
		FROM %Table:GWF% GWF
		WHERE GWF.GWF_FILIAL = %Exp:(cAliasGWM)->GWM_FILIAL%
		AND GWF.GWF_NRCALC = %Exp:(cAliasGWM)->GWM_NRDOC%
		AND GWF.%NotDel%
	EndSql
	If (cAliasGWF)->(!Eof())
		// Descontar impostos recuperáveis
		//Retira o ICMS
		If (cAliasGWF)->GWF_CRDICM == "1"
			lFrete -= (nVlIcms + nVlIBS)
		EndIf

		//Retira o PIS e COFINS
		If (cAliasGWF)->GWF_CRDPC == "1"
			lFrete -= (nVlCofi + nVlPis + nVlCBS)
		EndIf
	EndIf
Return lFrete

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} FreteRealizado
Efetua os descontos do frete realizado ( se for possível)

@sample


@author Gustavo H. Baptista
@since 18/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function FreteRealizado(lFrete,cAliasGWM)
	// Busca o cálculo de frete relacionado ao Movimento Contábil
	dbSelectArea("GW3")
	dbSetOrder(1)
	If dbSeek((cAliasGWM)->GWM_FILIAL + (cAliasGWM)->GWM_CDESP + (cAliasGWM)->GWM_CDTRP + (cAliasGWM)->GWM_SERDOC + (cAliasGWM)->GWM_NRDOC + (cAliasGWM)->GWM_DTEMIS)             
		// Descontar impostos recuperáveis
		// Retira o ICMS
		If GW3->GW3_CRDICM == "1"
			lFrete -= (nVlIcms + nVlIBS)
		EndIf
		
		//Retira o PIS e COFINS
		If GW3->GW3_CRDPC == "1"
			lFrete -= (nVlCofi + nVlPis + nVlCBS)
		EndIf	    
	EndIf
Return lFrete

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaImpostos
Carrega os valores de impostos que devem ser considerados no cálculo do frete

@sample

@author Gustavo H. Baptista
@since 19/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaImpostos(cAliasGWM)

	if cCritRat == 1 //Peso Carga
		nVlFret	:= (cAliasGWM)->GWM_VLFRET
		nVlIss 	:= (cAliasGWM)->GWM_VLISS 
		nVlIrrf	:= (cAliasGWM)->GWM_VLIRRF
		nVlInau	:= (cAliasGWM)->GWM_VLINAU
		nVlInem	:= (cAliasGWM)->GWM_VLINEM 
		nVlSest	:= (cAliasGWM)->GWM_VLSEST
		nVlIcms	:= (cAliasGWM)->GWM_VLICMS 
		nVlCofi	:= (cAliasGWM)->GWM_VLCOFI
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS"), (cAliasGWM)->GWM_VLIBS, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM"), (cAliasGWM)->GWM_VLIBM, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS"), (cAliasGWM)->GWM_VLCBS, 0)
	ElseIf cCritRat == 2 //Valor Carga
		nVlFret := (cAliasGWM)->GWM_VLFRE1
		nVlIss 	:= (cAliasGWM)->GWM_VLISS1 
		nVlIrrf := (cAliasGWM)->GWM_VLIRR1 
		nVlInau := (cAliasGWM)->GWM_VLINA1 
		nVlInem := (cAliasGWM)->GWM_VLINE1 
		nVlSest := (cAliasGWM)->GWM_VLSES1
		nVlIcms := (cAliasGWM)->GWM_VLICM1 
		nVlCofi := (cAliasGWM)->GWM_VLCOF1
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS1
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS1"), (cAliasGWM)->GWM_VLIBS1, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM1"), (cAliasGWM)->GWM_VLIBM1, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS1"), (cAliasGWM)->GWM_VLCBS1, 0)
	ElseIf cCritRat == 3 //Quantidade Itens
		nVlFret	:= (cAliasGWM)->GWM_VLFRE2
		nVlIss 	:= (cAliasGWM)->GWM_VLISS2 
		nVlIrrf	:= (cAliasGWM)->GWM_VLIRR2 
		nVlInau	:= (cAliasGWM)->GWM_VLINA2 
		nVlInem	:= (cAliasGWM)->GWM_VLINE2 
		nVlSest	:= (cAliasGWM)->GWM_VLSES2
		nVlIcms	:= (cAliasGWM)->GWM_VLICM2 
		nVlCofi	:= (cAliasGWM)->GWM_VLCOF2
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS2
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS2"), (cAliasGWM)->GWM_VLIBS2, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM2"), (cAliasGWM)->GWM_VLIBM2, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS2"), (cAliasGWM)->GWM_VLCBS2, 0)
	ElseIf cCritRat == 4 //Volume Carga
		nVlFret	:= (cAliasGWM)->GWM_VLFRE3
		nVlIss 	:= (cAliasGWM)->GWM_VLISS3 
		nVlIrrf	:= (cAliasGWM)->GWM_VLIRR3 
		nVlInau	:= (cAliasGWM)->GWM_VLINA3 
		nVlInem	:= (cAliasGWM)->GWM_VLINE3 
		nVlSest	:= (cAliasGWM)->GWM_VLSES3
		nVlIcms	:= (cAliasGWM)->GWM_VLICM3 
		nVlCofi	:= (cAliasGWM)->GWM_VLCOF3
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS3
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS3"), (cAliasGWM)->GWM_VLIBS3, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM3"), (cAliasGWM)->GWM_VLIBM3, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS3"), (cAliasGWM)->GWM_VLCBS3, 0)
	EndIf
Return