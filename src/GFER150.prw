/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"


/*--------------------------------------------------------- 
{Protheus.doc} GFER150
	
@author siegklenes.beulke
@since 15/07/2013
@version 1.0

@description
Relatório de Ocupação de Veículos por Romaneio,
Mostra o aproveitamento da capacidade dos veículos por Romaneio

-------------------------------------------------------------*/
User Function GFER150()
	Local oReport
	Local aArea := GetArea()

	Private cTabOc // Registros referente a ocupação
	Private cTabTotOc // registros referentes a totalizadores
	Private cAliasOc // Consulta SQL

	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)
	GFEDelTab(cTabOc)	
	GFEDelTab(cTabTotOc)
	If cAliasOc != Nil .And. !Empty(cAliasOc)
		If Select(cAliasOc) > 0
			(cAliasOc)->(dbCloseArea())
		endif
	endif 	
	
Return Nil

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportDef
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario. 

@author siegklenes.beulke
@version 1.0
@since 15/07/2013
@return oReport Objeto do Relatorio.

/*/
//--------------------------------------------------------------------------------------------------------

Static Function ReportDef()
	Local oReport, oSection, oSection2, cTotal := "Total"
	
	//+------------------------------------------------------------------------+
	//| "Criacao do componente de impressao                                      | "
	//| "                                                                        | "
	//| "TReport():New                                                           | "
	//| "ExpC1 : Nome do relatorio                                               | "
	//| "ExpC2 : Titulo                                                          | "
	//| "ExpC3 : Pergunte                                                        | "
	//| "ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  | "
	//| "ExpC5 : Descricao                                                       | "
	//| "                                                                        | "
	//+------------------------------------------------------------------------+
	oReport := TReport():New("GFER150","Relatório de Ocupação de Veículo por Romaneio de Carga","GFER150", {|oReport| ReportPrint(oReport)},"Emite relatório de Ocupação de Veículos por Romaneio conforme os parâmetros informados."/*Descricao do relatório*/)
	
	//configura a tela de paramêtros para vir selecionado a opção planilha
	
	oReport:SetLandscape(.T.)   //Define a orientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.T.) //Define se os totalizadores serão impressos em linha ou coluna 
	oReport:HideParamPage() //Oculta página de parametros
	If !Empty(oReport:uParam)
	    Pergunte(oReport:uParam,.F.)  
	EndIf
	oSection := TRSection():New(oReport,"Ocupação de Veículos",{"(cAliasOc)","(cTabOc)"},{"Ocupação de Veículos por Romaneio"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	//Exemplo utilizando a tabela de clientes.
	//oSection := TRSection():New(oReport,"Clientes",{"SA1"})
	oSection:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
	//+------------------------------------------------------------------------+
	//|Criacao da celulas da secao do relatorio                                |
	//|                                                                        |
	//|TRCell():New                                                            |
	//|ExpO1 : Objeto TSection que a secao pertence                            |
	//|ExpC2 : Nome da celula do relatório. O SX3 será consultado              |
	//|ExpC3 : Nome da tabela de referencia da celula                          |
	//|ExpC4 : Titulo da celula                                                |
	//|        Default : X3Titulo()                                            |
	//|ExpC5 : Picture                                                         |
	//|        Default : X3_PICTURE                                            |
	//|ExpC6 : Tamanho                                                         |
	//|        Default : X3_TAMANHO                                            |
	//|ExpL7 : Informe se o tamanho esta em pixel                              |
	//|        Default : False                                                 |
	//|ExpB8 : Bloco de código para impressao.                                 |
	//|        Default : ExpC2                                                 |
	//|                                                                        |
	//+------------------------------------------------------------------------+
	//	GetSx3Inf @return aRetorno Array {cTitulo,cCbox,cPicture}
	//TRCell():New(oSection,/*X3_CAMPO*/,/*Tabela*/,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	TRCell():New(oSection,"(cTabOc)->GWN_NRROM" , "(cTabOc)", GetSx3Inf("GWN_NRROM")[1]	, GetSx3Inf("GWN_NRROM")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_SIT"   , "(cTabOc)", GetSx3Inf("GWN_SIT")[1]	, "@!",/*Tamanho*/,/*lPixel*/,{||GetStrCbox(GetSx3Inf("GWN_SIT")[2],(cTabOc)->GWN_SIT)}/*{|| code-block de impressao }*/)
	
	TRCell():New(oSection,"(cTabOc)->GWN_DTIMPL", "(cTabOc)", GetSx3Inf("GWN_DTIMPL")[1], GetSx3Inf("GWN_DTIMPL")[3], , ,)
	TRCell():New(oSection,"(cTabOc)->GWN_DTSAI"	, "(cTabOc)", GetSx3Inf("GWN_DTSAI")[1]	, GetSx3Inf("GWN_DTSAI")[3], , , )
	TRCell():New(oSection,"(cTabOc)->GWN_CDTRP" , "(cTabOc)", GetSx3Inf("GWN_CDTRP")[1]	, "@!",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_DSTRP" , "(cTabOc)", GetSx3Inf("GWN_DSTRP")[1]	, "@!",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_PLACAD", "(cTabOc)", GetSx3Inf("GWN_PLACAD")[1], "@!",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_NMMTR" , "(cTabOc)", GetSx3Inf("GWN_NMMTR")[1]	, "@!",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_CDTPVC", "(cTabOc)", GetSx3Inf("GWN_CDTPVC")[1], "@!",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_CDTPOP", "(cTabOc)", GetSx3Inf("GWN_CDTPOP")[1], "@!",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_TOTENT", "(cTabOc)", "Qtde Entregas"			, "@E 99999",5/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_TOTDC" , "(cTabOc)", "Qtde Doc Carga"			, "@E 99999",5/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GW8_PESOR" , "(cTabOc)", "Peso Real"				, GetSx3Inf("GW8_PESOR")[3],18,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GW8_VOLUME", "(cTabOc)", GetSx3Inf("GW8_VOLUME")[1], GetSx3Inf("GW8_VOLUME")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GW1_QTVOL" , "(cTabOc)", GetSx3Inf("GW1_QTVOL")[1] , GetSx3Inf("GW1_QTVOL")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_VIAGEM", "(cTabOc)", GetSx3Inf("GWN_VIAGEM")[1], GetSx3Inf("GWN_VIAGEM")[3],18,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_CPESO" , "(cTabOc)", GetSx3Inf("GWN_CPESO")[1] , GetSx3Inf("GWN_CPESO")[3],18,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->GWN_CVOL"  , "(cTabOc)", GetSx3Inf("GWN_CVOL")[1]  , GetSx3Inf("GWN_CVOL")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	TRCell():New(oSection,"(cTabOc)->PESOCAPAC", "(cTabOc)", "Capacidade Peso"  ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->LOTACPESO", "(cTabOc)", "% Lotação Peso"   ,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->VOLUCAPAC", "(cTabOc)", "Capacidade Volume","@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTabOc)->LOTACVOLU", "(cTabOc)", "% Ocupação Volume","@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	oSection2 := TRSection():New(oSection,"Totalizadores",{"(cTabTotOc)"}) //  //"Totalizadores"
	oSection2:SetTotalInLine(.T.)
	oSection2:SetHeaderSection(.T.)
	TRCell():New(oSection2,"cTotal","","Totalizadores",,2,,{||cTotal})
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"(cTabTotOc)->GWN_TOTENT"	, "(cTabTotOc)"	, "", , , , )
	TRCell():New(oSection2,"(cTabTotOc)->GWN_TOTDC"	, "(cTabTotOc)"	, "", , , , )
	TRCell():New(oSection2,"(cTabTotOc)->GW8_PESOR"	, "(cTabTotOc)"	, "", , , , )
	TRCell():New(oSection2,"(cTabTotOc)->GW8_VOLUME"	, "(cTabTotOc)"	, "", , , , )
	TRCell():New(oSection2,"(cTabTotOc)->GW1_QTVOL"	, "(cTabTotOc)"	, "", , , , )
	TRCell():New(oSection2,"(cTabTotOc)->GWN_VIAGEM", "(cTabTotOc)"	, "","@E 99999999999" , , , )
	TRCell():New(oSection2,"(cTabTotOc)->GWN_CPESO"	, "(cTabTotOc)"	, "","@E 999,999,999.99" , , , )
	TRCell():New(oSection2,"(cTabTotOc)->GWN_CVOL"	, "(cTabTotOc)"	, "","@E 999,999,999.99" , , , )
	TRCell():New(oSection2,"(cTabTotOc)->PESOCAPAC"	, "(cTabTotOc)"	, "", , , , )
	TRCell():New(oSection2,"(cTabTotOc)->LOTACPESO"	, "(cTabTotOc)"	, "", , , , )
	TRCell():New(oSection2,"(cTabTotOc)->VOLUCAPAC"	, "(cTabTotOc)"	, "", , , , )
	TRCell():New(oSection2,"(cTabTotOc)->LOTACVOLU"	, "(cTabTotOc)"	, "", , , , )

Return oReport

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
A funcao estatica CriaTabTemp Cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER150() 

@author siegklenes.beulke
@version 1.0
@since 15/07/2013
@return {aStruOp,aStruOpTot} Array com Struct dos campos

/*/
//--------------------------------------------------------------------------------------------------------
Static Function CriaTabTemp()
	Local aStruOp,aStruOpTot
	aStruOp := {{"GWN_NRROM" ,"C",TamSX3("GWN_NRROM" )[1],TamSX3("GWN_NRROM" )[2]},;
				{"GWN_SIT"   ,"C",TamSX3("GWN_SIT" )[1],TamSX3("GWN_SIT" )[2]},;
				{"GWN_DTIMPL","D",TamSX3("GWN_DTIMPL" )[1],TamSX3("GWN_DTIMPL" )[2]},;
				{"GWN_DTSAI" ,"D",TamSX3("GWN_DTSAI" )[1],TamSX3("GWN_DTSAI" )[2]},;
				{"GWN_CDTRP" ,"C",TamSX3("GWN_CDTRP" )[1],TamSX3("GWN_CDTRP" )[2]},;
				{"GWN_DSTRP" ,"C",TamSX3("GWN_DSTRP" )[1],TamSX3("GWN_DSTRP" )[2]},;
				{"GWN_PLACAD","C",TamSX3("GWN_PLACAD" )[1],TamSX3("GWN_PLACAD" )[2]},;
				{"GWN_NMMTR" ,"C",TamSX3("GWN_NMMTR" )[1],TamSX3("GWN_NMMTR" )[2]},;
				{"GWN_CDTPVC","C",TamSX3("GWN_CDTPVC" )[1],TamSX3("GWN_CDTPVC" )[2]},;
				{"GWN_CDTPOP","C",TamSX3("GWN_CDTPOP" )[1],TamSX3("GWN_CDTPOP" )[2]},;
				{"GWN_TOTENT","N",9,0},;
				{"GWN_TOTDC" ,"N",9,0},;
				{"GW8_PESOR" ,"N",TamSX3("GW8_PESOR" )[1]+4,TamSX3("GW8_PESOR" )[2]},;
				{"GW8_VOLUME","N",TamSX3("GW8_VOLUME" )[1]+4,TamSX3("GW8_VOLUME" )[2]},;
				{"GW1_QTVOL" ,"N",TamSX3("GW1_QTVOL" )[1]+4,TamSX3("GW1_QTVOL" )[2]},;
				{"PESOCAPAC" ,"N",TamSX3("GWI_VLFRET" )[1]+4,TamSX3("GWI_VLFRET" )[2]},; // CAPACIDADE PESO VEÍCULOS OU VEÍCULO
				{"LOTACPESO" ,"N",TamSX3("GWI_VLFRET" )[1]+4,TamSX3("GWI_VLFRET" )[2]},; // LOTAÇÃO DO PESO
				{"VOLUCAPAC" ,"N",TamSX3("GWI_VLFRET" )[1]+4,TamSX3("GWI_VLFRET" )[2]},; // CAPACIDADE VOLUME VEÍCULOS 
				{"LOTACVOLU" ,"N",TamSX3("GWI_VLFRET" )[1]+4,TamSX3("GWI_VLFRET" )[2]};  // LOTAÇÃO DE VOLUME
			   }
				
	
	
	aStruOpTot := {	{"GWN_TOTENT","N",9,0},;
					{"GWN_TOTDC" ,"N",9,0},;
					{"GW8_PESOR" ,"N",TamSX3("GW8_PESOR" )[1]+4,TamSX3("GW8_PESOR" )[2]},;
					{"GW8_VOLUME","N",TamSX3("GW8_VOLUME" )[1]+4,TamSX3("GW8_VOLUME" )[2]},;
					{"GW1_QTVOL" ,"N",TamSX3("GW1_QTVOL"  )[1]+4,TamSX3("GW1_QTVOL" )[2]},;
					{"PESOCAPAC" ,"N",TamSX3("GWI_VLFRET" )[1]+4,TamSX3("GWI_VLFRET" )[2]},; // CAPACIDADE PESO VEÍCULOS OU VEÍCULO
					{"LOTACPESO" ,"N",9,2},; // LOTAÇÃO DO PESO
					{"VOLUCAPAC" ,"N",TamSX3("GWI_VLFRET" )[1]+4,TamSX3("GWI_VLFRET" )[2]},; // CAPACIDADE VOLUME VEÍCULOS 
					{"LOTACVOLU" ,"N",9,2};  // LOTAÇÃO DE VOLUME
				  }

	aAdd(aStruOp,{"GWN_VIAGEM","C",TamSX3("GWN_VIAGEM" )[1]+4,TamSX3("GWN_VIAGEM" )[2]})
	aAdd(aStruOp,{"GWN_CPESO","N",TamSX3("GWN_CPESO" )[1]+4,TamSX3("GWN_CPESO" )[2]})
	aAdd(aStruOp,{"GWN_CVOL","N",TamSX3("GWN_CVOL" )[1]+4,TamSX3("GWN_CVOL" )[2]})
	aAdd(aStruOpTot,{"GWN_VIAGEM","N",TamSX3("GWN_VIAGEM" )[1]+4,TamSX3("GWN_VIAGEM" )[2]})
	aAdd(aStruOpTot,{"GWN_CPESO","N",TamSX3("GWN_CPESO" )[1]+4,TamSX3("GWN_CPESO" )[2]})
	aAdd(aStruOpTot,{"GWN_CVOL","N",TamSX3("GWN_CVOL" )[1]+4,TamSX3("GWN_CVOL" )[2]})
	
	cTabOc := GFECriaTab({aStruOp, {"GWN_NRROM"}})
	cTabTotOc :=  GFECriaTab({aStruOpTot,{"GWN_TOTENT"}})
Return {aStruOp,aStruOpTot}

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CarregaDados
A funcao estatica CarregaDados Realiza consulta sql em alias de variavel privada em U_GFER150()
Faz a leitura do Pergunte GFER150
@author siegklenes.beulke
@version 1.0
@since 15/07/2013
@return Nil

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CarregaDados()
	Local cQuery := ''
	Local cFltrOpen := ''
	Local cFltr :=''
	Local cFltrItens := ''
	Local cFltrSomaP := ''
	
	/*
		01 Filial de
		02 Filial ate
		03 Data Criacao de
		04 Data Criacao ate
		05 Data Liberacao de
		06 Data Liberacao ate
		07 Tranportadora Romaneio de
		08 Tranportadora Romaneio ate
		09 Tipo Transportadora Romaneio
		10 Tipo Veiculo de
		11 Tipo Veiculo ate
		12 Tipo Operacao de
		13 Tipo Operacao ate
		14 Classificacao Frete de
		15 Classificacao Frete ate
	*/ 
	
	cFltr += " AND GWN.GWN_FILIAL >= '" + MV_PAR01 + "' AND GWN.GWN_FILIAL <='" + MV_PAR02 + "'"
	cFltrOpen += " AND GWN.GWN_FILIAL >= '" + MV_PAR01 + "' AND GWN.GWN_FILIAL <='" + MV_PAR02 + "'"
	cFltrItens += " AND GW1_FILIAL >= '" + MV_PAR01 + "' AND GW1_FILIAL <='" + MV_PAR02 + "'"
	cFltrSomaP += " AND GWN_FILIAL >= '" + MV_PAR01 + "' AND GWN_FILIAL <='" + MV_PAR02 + "'"
	
	cFltr += " AND GWN_DTIMPL >= '" + DTOS(MV_PAR03) + "' AND GWN_DTIMPL <='" + DTOS(MV_PAR04) + "'"	
	cFltrOpen +=  " AND GWN_DTIMPL >= '" + DTOS(MV_PAR03) + "' AND GWN_DTIMPL <='" + DTOS(MV_PAR04) + "'"	
	cFltrSomaP+= " AND GWN_DTIMPL >= '" + DTOS(MV_PAR03) + "' AND GWN_DTIMPL <='" + DTOS(MV_PAR04) + "'"
	
	cFltr += " AND GWN_DTSAI >= '" + DTOS(MV_PAR05) + "' AND GWN_DTSAI <='" + DTOS(MV_PAR06) + "'"	 
	cFltrOpen +=  " AND GWN_DTSAI >= '" + DTOS(MV_PAR05) + "' AND GWN_DTSAI <='" + DTOS(MV_PAR06) + "'"	 
	cFltrSomaP+= " AND GWN_DTSAI >= '" + DTOS(MV_PAR05) + "' AND GWN_DTSAI <='" + DTOS(MV_PAR06) + "'"
	
	cFltr += " AND GWN_CDTRP >='" + MV_PAR07 + "' AND GWN_CDTRP <='" + MV_PAR08 + "'"
	cFltrOpen +=  " AND GWN_CDTRP >='" + MV_PAR07 + "' AND GWN_CDTRP <='" + MV_PAR08 + "'"
	cFltrSomaP += " AND GWN_CDTRP >='" + MV_PAR07 + "' AND GWN_CDTRP <='" + MV_PAR08 + "'"
	
	Do Case
		Case MV_PAR09 == 1
			cFltr += " AND GU3_AUTON IN('1','2')"
			cFltrOpen += " AND GU3_AUTON IN('1','2')"
		Case MV_PAR09 == 2
			cFltr += " AND GU3_AUTON <>'1'"
			cFltrOpen += " AND GU3_AUTON <>'1'"
		Case MV_PAR09 == 3
			cFltr += " AND GU3_AUTON ='1'"
			cFltrOpen += " AND GU3_AUTON ='1'"
	EndCase
	cFltr += " AND GWN_CDTPVC >='" + MV_PAR10 + "' AND GWN_CDTPVC <='" + MV_PAR11 + "'"
	cFltrSomaP += " AND GWN_CDTPVC >='" + MV_PAR10 + "' AND GWN_CDTPVC <='" + MV_PAR11 + "'"
	
	cFltr += " AND GWN_CDTPOP >='" + MV_PAR12 + "' AND GWN_CDTPOP <='" + MV_PAR13 + "'"
	cFltrSomaP += " AND GWN_CDTPOP >='" + MV_PAR12 + "' AND GWN_CDTPOP <='" + MV_PAR13 + "'"
	
	cFltr += " AND GWN_CDCLFR >='" + MV_PAR14 + "' AND GWN_CDCLFR <='" + MV_PAR15 + "'"
	cFltrSomaP += " AND GWN_CDCLFR >='" + MV_PAR14 + "' AND GWN_CDCLFR <='" + MV_PAR15 + "'"
	
	cAliasOc := GetNextAlias()
	cQuery += "SELECT	" 
	cQuery += " GWN.GWN_NRROM," 
	cQuery += " GWN_SIT,"
	cQuery += " GWN_DTIMPL,"
	cQuery += " GWN_DTSAI," 
	cQuery += " GWN_CDTRP," 
	cQuery += " GU3_NMEMIT GWN_DSTRP,"
	cQuery += " GWN_PLACAD," 
	cQuery += " GUU_NMMTR GWN_NMMTR,"
	cQuery += " GWN_CDTPVC," 
	cQuery += " GWN_CDTPOP,"
	
	cQuery += " GWN_CPESO," 
	cQuery += " GWN_CVOL,"
	cQuery += " GWN_VIAGEM,"
		
	cQuery += "		(SELECT	COUNT(GW1_NRDC)"
	cQuery += "			FROM	" + RetSQLName("GW1") + " GW1 "
	cQuery += "			INNER JOIN " + RetSQLName("GWU") + " GWU " 
	cQuery += "			ON GW1.GW1_FILIAL = GWU.GWU_FILIAL"
	cQuery += "			AND GW1.GW1_CDTPDC = GWU.GWU_CDTPDC"
	cQuery += "			AND GW1.GW1_EMISDC = GWU.GWU_EMISDC"
	cQuery += "			AND GW1.GW1_SERDC = GWU.GWU_SERDC"
	cQuery += "			AND GW1.GW1_NRDC = GWU.GWU_NRDC"
	cQuery += "			INNER JOIN " + RetSQLName("GU3") + " GU3 "
	cQuery += "			ON GW1.GW1_CDDEST = GU3.GU3_CDEMIT AND GWU.GWU_NRCIDD <> GU3.GU3_NRCID"
	cQuery += "			WHERE GWU.D_E_L_E_T_ = ' ' AND GW1.D_E_L_E_T_ = ' ' AND GU3.D_E_L_E_T_ = ' '"
	If GFXCP1212210('GW1_FILROM')
		cQuery += "		AND GW1.GW1_FILROM = GWN.GWN_FILIAL"
	Else
		cQuery += "		AND GW1.GW1_FILIAL = GWN.GWN_FILIAL"
	EndIf
	cQuery += "			AND GW1.GW1_NRROM = GWN.GWN_NRROM"
	cQuery += "		) GWN_TOTENT,"
	cQuery += "		(SELECT	COUNT(GW1_NRDC)"
	cQuery += "		   FROM " + RetSQLName("GW1") 
	cQuery += "		  WHERE D_E_L_E_T_ = ' '"
	If GFXCP1212210('GW1_FILROM')
		cQuery += "	    AND GW1_FILROM = GWN.GWN_FILIAL"
	Else
		cQuery += "	    AND GW1_FILIAL = GWN.GWN_FILIAL"
	EndIf
	cQuery += "		    AND GW1_NRROM = GWN.GWN_NRROM"
	cQuery += "		) GWN_TOTDC," 
	cQuery += "		ITENS.GW8_PESOR,"  
	cQuery += "		ITENS.GW8_VOLUME," 
	cQuery += "		(SELECT	SUM(GW1_QTVOL) " 
	cQuery += "		   FROM " + RetSQLName("GW1") 
	cQuery += "		  WHERE D_E_L_E_T_ = ' '"
	If GFXCP1212210('GW1_FILROM')
		cQuery += "	    AND GW1_FILROM = GWN.GWN_FILIAL"
	Else
		cQuery += "	    AND GW1_FILIAL = GWN.GWN_FILIAL"
	EndIf
	cQuery += "		    AND GW1_NRROM = GWN.GWN_NRROM" 
	cQuery += "		) GW1_QTVOL," 
	cQuery += " SOMAPESO.GU8_CARGUT," 
	cQuery += " SOMAPESO.GU8_VOLUT" 
	cQuery += "	FROM	( SELECT" 
	cQuery += "				GW1.GW1_NRROM,"
	cQuery += "				GW1.GW1_FILIAL,"
	cQuery += "				GW1.GW1_FILROM,"
	cQuery += "				SUM(GW8.GW8_PESOR) GW8_PESOR,"
	cQuery += "				SUM(GW8.GW8_VOLUME) GW8_VOLUME"
	cQuery += "				FROM " + RetSQLName("GW1") + " GW1"
	cQuery += "				INNER JOIN " + RetSQLName("GW8") + " GW8" 
	cQuery += "				ON GW1.GW1_FILIAL = GW8.GW8_FILIAL"
	cQuery += "			 	AND GW1.GW1_CDTPDC = GW8.GW8_CDTPDC" 
	cQuery += "				AND GW1.GW1_EMISDC = GW8.GW8_EMISDC" 
	cQuery += "				AND GW1.GW1_SERDC = GW8.GW8_SERDC"
	cQuery += "				AND GW1.GW1_NRDC = GW8.GW8_NRDC"
	cQuery += "				WHERE	GW1.D_E_L_E_T_ = ' ' AND GW8.D_E_L_E_T_ = ' '" + cFltrItens
	cQuery += "				GROUP BY GW1.GW1_NRROM, GW1.GW1_FILIAL, GW1.GW1_FILROM"
	cQuery += "			) ITENS" 
	cQuery += "	INNER JOIN"
	cQuery += "			( SELECT"
	cQuery += "				GWN_FILIAL,"
	cQuery += "				GWN_NRROM,"
	cQuery += "				SUM((CASE WHEN (	(CASE WHEN GU8_CARGUT = 0" 
	cQuery += "									THEN GV3.GV3_CARGUT" 
	cQuery += "									ELSE GU8_CARGUT" 
	cQuery += "			 						END)) IS NULL" 
	cQuery += "						  THEN GV3ROMAN.GV3_CARGUT"
	cQuery += "						  ELSE (	(CASE WHEN GU8_CARGUT = 0" 
	cQuery += "									THEN GV3.GV3_CARGUT "
	cQuery += "									ELSE GU8_CARGUT "
	cQuery += "									END))" 
	cQuery += "						  END)) GU8_CARGUT,"
	cQuery += "				SUM((CASE WHEN (	(CASE WHEN GU8_VOLUT = 0"
	cQuery += "									THEN GV3.GV3_VOLUT "
	cQuery += "									ELSE GU8_VOLUT "
	cQuery += "									END)) IS NULL"
	cQuery += "						  THEN GV3ROMAN.GV3_VOLUT"
	cQuery += "						  ELSE (	(CASE WHEN GU8_VOLUT = 0"
	cQuery += "						  			THEN GV3.GV3_VOLUT" 
	cQuery += "									ELSE GU8_VOLUT "
	cQuery += "						  			END))" 
	cQuery += "						  END)) GU8_VOLUT"

	If TCGETDB() = 'OPENEDGE'
		cQuery += "				FROM " + RetSQLName("GU8") + " GU8," + RetSQLName("GWN") + " GWN,"  + RetSQLName("GV3") + " GV3ROMAN"		
		cQuery += "				INNER JOIN " + RetSQLName("GV3") + " GV3 ON (GU8_CDTPVC = GV3.GV3_CDTPVC OR GU8_CDTPVC IS NULL ) "
	    cQuery += " 			WHERE  ( GU8.GU8_PLACA(+) = GWN.GWN_PLACAD "
	    cQuery += "          OR GU8.GU8_PLACA (+) = GWN.GWN_PLACAM "
	    cQuery += "          OR GU8.GU8_PLACA (+) = GWN.GWN_PLACAT ) "
	    cQuery += "          AND ( GV3ROMAN.GV3_CDTPVC (+) = GWN.GWN_CDTPVC ) "
		cQuery += "          AND ( GU8.D_E_L_E_T_ = ' '  OR  GU8.D_E_L_E_T_ IS NULL)"
	 Else 
		cQuery += "				FROM " + RetSQLName("GU8") + " GU8"
		cQuery += "				INNER JOIN " + RetSQLName("GV3") + " GV3 ON GU8_CDTPVC = GV3_CDTPVC"
		cQuery += "				RIGHT JOIN " + RetSQLName("GWN") + " GWN ON ( (GWN_PLACAD = GU8_PLACA OR GWN_PLACAM = GU8_PLACA OR GWN_PLACAT = GU8_PLACA))"
		cQuery += "				LEFT JOIN " + RetSQLName("GV3") + " GV3ROMAN ON GV3ROMAN.GV3_CDTPVC = GWN_CDTPVC"
		cQuery += "				WHERE ( GU8.D_E_L_E_T_ = ' ' OR  GU8.D_E_L_E_T_ IS NULL)" 
	EndIf
	
	cQuery += "				AND (GV3.D_E_L_E_T_ = ' ' OR GV3.D_E_L_E_T_ IS NULL)"
	cQuery += "				AND (GWN.D_E_L_E_T_ = ' ' OR GWN.D_E_L_E_T_ IS NULL)" 
	cQuery += "				AND (GV3ROMAN.D_E_L_E_T_ = ' ' OR GV3ROMAN.D_E_L_E_T_ IS NULL)" + cFltrSomaP
	cQuery += "				GROUP BY GWN_FILIAL, GWN_NRROM"
	cQuery += "			) SOMAPESO "
	cQuery += "			ON 	(SOMAPESO.GWN_FILIAL = ITENS.GW1_FILIAL" 
	cQuery += "			AND	SOMAPESO.GWN_NRROM = ITENS.GW1_NRROM)"
	cQuery += "			INNER JOIN " + RetSQLName("GWN") + " GWN "
	cQuery += "			ON 	(GWN.GWN_NRROM = ITENS.GW1_NRROM"
	If GFXCP1212210('GW1_FILROM')
		cQuery += "		AND	GWN.GWN_FILIAL = ITENS.GW1_FILROM)"
	Else
		cQuery += "		AND	GWN.GWN_FILIAL = ITENS.GW1_FILIAL)"
	EndIf
	cQuery += "			INNER JOIN " + RetSQLName("GU3") + " GU3 "
	cQuery += "			ON GWN.GWN_CDTRP = GU3.GU3_CDEMIT"
	cQuery += "			LEFT JOIN  " + RetSQLName("GUU") + " GUU "
	cQuery += "			ON GUU.GUU_CDMTR = GWN.GWN_CDMTR"
	IF TCGETDB() = 'OPENEDGE'
		cQuery += "	 WHERE     (GWN.D_E_L_E_T_ = ' ') AND (GU3.D_E_L_E_T_ = ' ') AND (GUU.D_E_L_E_T_ = ' ' OR GUU.D_E_L_E_T_ IS NULL) " +  cFltrOpen
	Else 
		cQuery += "	 WHERE     (GWN.D_E_L_E_T_ = ' ') AND (GU3.D_E_L_E_T_ = ' ') AND (GUU.D_E_L_E_T_ = ' ' OR GUU.D_E_L_E_T_ IS NULL) " +  cFltr	
	EndIf
	cQuery += " 	ORDER BY GWN.GWN_NRROM "

	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasOc, .F., .T.)
	dbSelectArea((cAliasOc))
	(cAliasOc)->( dbGoTop() )	
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.  

@param oReport Objeto do relatório  
@author Siegklenes.beulke
@version 1.0
@since 15/07/2013
@return Nil
/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
	Local oSection  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	Local nCont := 1
	Local aViagens := {}

	Private cTabOc 		// Registros referente a ocupação
	Private cTabTotOc 	// registros referentes a totalizadores
	Private cAliasOc 	// Consulta SQL
	Private aStructs := CriaTabTemp()

	CarregaDados()
	
	If !IsBlind()
		oReport:SetMeter((cAliasOc)->(LastRec()))
	EndIf
	oSection:Init()
	RecLock((cTabTotOc), .T.)
	While !oReport:Cancel() .AND. !(cAliasOc)->( Eof() )
		oReport:IncMeter()
		RecLock((cTabOc), .T.)
			For nCont := 1 to Len(aStructs[1])
				If (cAliasOc)->(FieldPos(aStructs[1][nCont][1])) > 0
					If aStructs[1][nCont][2] == "D"
						(cTabOc)->&(aStructs[1][nCont][1]) := STOD((cAliasOc)->&(aStructs[1][nCont][1]))
					Else
						(cTabOc)->&(aStructs[1][nCont][1]) := (cAliasOc)->&(aStructs[1][nCont][1])
					EndIf
				EndIf
			Next nCont
			
			(cTabOc)->PESOCAPAC := (cAliasOc)->GU8_CARGUT
			(cTabOc)->LOTACPESO := (((cAliasOc)->GW8_PESOR + (cTabOc)->GWN_CPESO)/(cAliasOc)->GU8_CARGUT)*100
			(cTabOc)->VOLUCAPAC := (cAliasOc)->GU8_VOLUT
			(cTabOc)->LOTACVOLU := (((cAliasOc)->GW8_VOLUME + (cTabOc)->GWN_CVOL)/(cAliasOc)->GU8_VOLUT)*100
						
			(cTabTotOc)->GWN_TOTENT += (cTabOc)->GWN_TOTENT
			(cTabTotOc)->GWN_TOTDC  += (cTabOc)->GWN_TOTDC 
			(cTabTotOc)->GW8_PESOR  += (cTabOc)->GW8_PESOR 
			(cTabTotOc)->GW8_VOLUME += (cTabOc)->GW8_VOLUME
			(cTabTotOc)->GW1_QTVOL  += (cTabOc)->GW1_QTVOL
			
			If !Empty((cTabOc)->GWN_VIAGEM ) .And. aScan(aViagens,{|x|x == (cTabOc)->GWN_VIAGEM}) == 0
				aAdd(aViagens,(cTabOc)->GWN_VIAGEM)
				(cTabTotOc)->GWN_VIAGEM += 1
			EndIf
			(cTabTotOc)->GWN_CPESO += (cTabOc)->GWN_CPESO 
			(cTabTotOc)->GWN_CVOL  += (cTabOc)->GWN_CVOL
			
			
			(cTabTotOc)->PESOCAPAC += (cAliasOc)->GU8_CARGUT
			(cTabTotOc)->VOLUCAPAC += (cAliasOc)->GU8_VOLUT
		MsUnlock((cTabOc))	
		oSection:PrintLine()
		(cAliasOc)->(DbSkip())
	EndDo
	(cTabTotOc)->LOTACPESO := ((cTabTotOc)->GW8_PESOR/(cTabTotOc)->PESOCAPAC)*100
	(cTabTotOc)->LOTACVOLU := ((cTabTotOc)->GW8_VOLUME/(cTabTotOc)->VOLUCAPAC)*100
	MsUnlock((cTabTotOc))
	
	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()
		
	oSection:Finish()
	
Return

/*/{Protheus.doc} GetSx3Inf
	
@author siegklenes.beulke
@since 16/07/2013
@version 1.0

@param cCampo, character, Campo  do Banco de dados 
@param aRetorno, array, Opcional, Informações de Retorno caso não encontre o Campo

@description

Função que busca no sx3 as informações de titulo,cbox,picture e descrição do campo
e retorna um array nessa ordem, ou caso não encontre o campo, retorna o segundo parametro

@example

GetSx3Inf("GW1_FILIAL") Retorno {"Filial","","@!","Filial"}
GetSx3Inf("GW1_FILI",{"Fila","1=Sim;2=Nao","","Fila de espera"})Retorno {"Fila","1=Sim;2=Nao","","Fila de espera"} 

@return aArray:={X3Titulo, X3Cbox,X3Picture,X3DESCRIC}
/*/

Static Function GetSx3Inf(cCampo,aRetorno)
Local nCont := 1
Local aArea := GetArea("SX3")
Default aRetorno := {"","","",""}
	For nCont := 1 to 4-Len(aRetorno)
		aAdd(aRetorno,"")
	Next
	dbSelectArea("SX3")
	dbSetOrder(2)
	If dbSeek( cCampo )   
		aRetorno[1] := X3Titulo()
		aRetorno[2] := X3Cbox()
		aRetorno[3] := X3Picture()
		aRetorno[4] := X3DESCRIC()
	EndIf
	RestArea(aArea)
Return aRetorno

/*/{Protheus.doc} GetStrCbox
	
@author siegklenes.beulke
@since 16/07/2013
@version 1.0

@param cBox, character, Caracter Representando X3Cbox
@param cVal, character, Valor de pesquisa

@description

Retorna o valor do combo dado o valor da sequencia

@example

GetStrCbox("1=Sim;2=Nao","1") // retorna "Sim" 

@return cRet Valor Buscado
/*/

Static Function GetStrCbox(cBox,cVal)
	Local aArr := STRTOKARR(cBox,";")
	Local aArr2 := {}
	Local nCont,nPos,cRet:=""
	For nCont :=1 to Len(aArr)
		aAdd(aArr2,STRTOKARR(aArr[ncont],"="))
	Next nCont
	If Len(aArr2) > 0 
		nPos := aScan(aArr2,{|x|x[1]==cVal})
		If nPos > 0
			cRet := aArr2[nPos][2]
		EndIf
	EndIf
Return cRet
