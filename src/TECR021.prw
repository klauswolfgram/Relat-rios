/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Rwmake.ch"
#Include "Protheus.ch"      
#Include "TOPCONN.ch"
#Include "TECR021.ch"
Static cAutoPerg := "TECR021"

//-------------------------------------------------------------------
/*/{Protheus.doc} TECR020
Monta as definiçoes do Relatorio de Check-In / Check-Out Gestão de Serviços

@author Cesar Bianchi
@since 14/08/2017
@version P12.1.20
/*/
//-------------------------------------------------------------------
User Function TECR021()
	Local oReport := Nil
	Private cPerg	:= "TECR021" 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ PARAMETROS                                                             ³
	//³ MV_PAR01 : Data de ?                                                   ³
	//³ MV_PAR02 : Data ate?                                                   ³
	//³ MV_PAR03 : Atendente de ?                                              ³
	//³ MV_PAR04 : Atendente ate ?                                             ³
	//³ MV_PAR05 : Centro de custo de ?                                        ³
	//³ MV_PAR06 : Centro de custo ate ?                                       ³	
	//³ MV_PAR07 : Local de Atendimento de ?                                   ³
	//³ MV_PAR08 : Local de Atendimento  ate ?                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

	//Exibe dialog de perguntes ao usuario
	If !Pergunte(cPerg,.T.)
		Return nil
	EndIf

	//Pinta o relatorio a partir das perguntas escolhidas
	oReport := ReportDef()   
	oReport:PrintDialog()  
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} reportDef
Monta as definiçoes do relatorio de Relatorio de Check-In / Check-Out Gestão de Serviços

@author Cesar Bianchi
@since 14/08/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()
	
	Local cPerg		:= "TECR021"
	Local cTitulo 	:= STR0001 //"Relatorio de Check-In / Check-Out - Gestão de Serviços"
	Local oReport 	:= TReport():New(cPerg, cTitulo, cPerg , {|oReport| PrintReport(oReport)},STR0001)
	Local oSection1 := TRSection():New(oReport,STR0013,{"ABB","ABQ","ABS","AA1","SRA","TFF","TFL","TFJ","ADY","AD1","SB1","CN9","SRJ","SQ3","AC0","SR6"})	//"Check-Ins Registrados"

	//Define Propriedades do Relatorio (Cabeçalho, Orientação, Totais e SubTotais)
	oReport:ShowHeader()
	oReport:SetLandScape()
	oReport:SetTotalInLine(.F.)
	oSection1:SetTotalInLine(.F.)

	//Define colunas do relatorio
	TRCell():New(oSection1, "RA_MAT" 	, "SRA", OemToAnsi(STR0002) ,PesqPict('SRA',"RA_MAT")		,TamSX3("RA_MAT")[1]		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Matricula RH"
	TRCell():New(oSection1, "AA1_CODTEC", "AA1", OemToAnsi(STR0003) ,PesqPict('AA1',"AA1_CODTEC")	,TamSX3("AA1_CODTEC")[1]	,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Código Atendente"
	TRCell():New(oSection1, "AA1_NOMTEC", "AA1", OemToAnsi(STR0004) ,PesqPict('AA1',"AA1_NOMTEC")	,TamSX3("AA1_NOMTEC")[1]	,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Nome Atendente"
	TRCell():New(oSection1, "ABS_DESCRI", "ABS", OemToAnsi(STR0006) ,PesqPict('ABS',"ABS_DESCRI")	,TamSX3("ABS_DESCRI")[1]	,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Descrição Local Atendimento"	
	TRCell():New(oSection1, "ABB_DTINI"	, "ABB", OemToAnsi(STR0007) ,PesqPict('ABB',"ABB_DTINI")	,TamSX3("ABB_DTINI")[1]		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Data Inicial Posto"
	TRCell():New(oSection1, "ABB_HRINI"	, "ABB", OemToAnsi(STR0008) ,PesqPict('ABB',"ABB_HRINI")	,TamSX3("ABB_HRINI")[1]		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Hora Inicial Posto"
	TRCell():New(oSection1, "ABB_HRCHIN", "ABB", OemToAnsi(STR0018) ,PesqPict('ABB',"ABB_HRCHIN")	,TamSX3("ABB_HRCHIN")[1]	,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Hora Check-In"	
	TRCell():New(oSection1, "ABB_DTFIM"	, "ABB", OemToAnsi(STR0009) ,PesqPict('ABB',"ABB_DTFIM")	,TamSX3("ABB_DTFIM")[1]		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Data Final Posto"
	TRCell():New(oSection1, "ABB_HRFIM"	, "ABB", OemToAnsi(STR0010) ,PesqPict('ABB',"ABB_HRFIM")	,TamSX3("ABB_HRFIM")[1]		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Hora Final Posto"
	TRCell():New(oSection1, "ABB_HRCOUT", "ABB", OemToAnsi(STR0019) ,PesqPict('ABB',"ABB_HRCOUT")	,TamSX3("ABB_HRCOUT")[1]	,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Hora Check-Out"
	
	//Define campos alinhados a esquerda
	oSection1:Cell("RA_MAT"):SetAlign("LEFT")
	oSection1:Cell("AA1_CODTEC"):SetAlign("LEFT")
	oSection1:Cell("AA1_NOMTEC"):SetAlign("LEFT")	
	oSection1:Cell("ABS_DESCRI"):SetAlign("LEFT")
	
	//Define campos alinhados ao centro
	oSection1:Cell("ABB_DTINI"):SetAlign("LEFT")
	oSection1:Cell("ABB_HRINI"):SetAlign("LEFT")	
	oSection1:Cell("ABB_HRCHIN"):SetAlign("LEFT")
	oSection1:Cell("ABB_DTFIM"):SetAlign("LEFT")
	oSection1:Cell("ABB_HRFIM"):SetAlign("LEFT")
	oSection1:Cell("ABB_HRCOUT"):SetAlign("LEFT")	
	
Return (oReport) 

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Gera o relatorio de Check-In / Check-Out Gestão de Serviços

@author Cesar Bianchi
@since 14/08/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport(oReport)

	Local aArea		:= GetArea() 
	Local oSection1	:= oReport:Section(1)
	Local cAlias	:= GetNextAlias()

	BEGIN REPORT QUERY oReport:Section(1)

		BeginSql alias cAlias
		SELECT AA1.AA1_CDFUNC RA_MAT, AA1.AA1_CODTEC, AA1.AA1_NOMTEC, ABS.ABS_LOCAL, ABS.ABS_DESCRI, ABB.ABB_DTINI, ABB.ABB_HRINI, ABB.ABB_HRCHIN, 
				ABB.ABB_DTFIM, ABB.ABB_HRFIM, ABB.ABB_HRCOUT, ABS.ABS_LATITU, ABS.ABS_LONGIT,
				ABB.ABB_LATIN, ABB.ABB_LONIN, ABB.ABB_LATOUT, ABB.ABB_LONOUT
			FROM %table:ABB% ABB
			INNER JOIN %table:AA1% AA1
				ON ABB.ABB_CODTEC = AA1.AA1_CODTEC
				AND AA1.AA1_FILIAL = %xfilial:AA1%
				AND AA1.%notDel%
			INNER JOIN %table:ABS% ABS
				ON ABS.ABS_LOCAL = ABB.ABB_LOCAL
				AND ABS.ABS_FILIAL = %xfilial:ABS%
				AND ABS.%notDel%
			INNER JOIN %table:TDV% TDV
				ON TDV.TDV_CODABB = ABB.ABB_CODIGO
				AND TDV.TDV_FILIAL = ABB.ABB_FILIAL
				AND TDV.%notDel%
			WHERE ABB.ABB_FILIAL = %xfilial:ABB%
				AND TDV.TDV_DTREF BETWEEN  %exp:MV_PAR01% AND %exp:MV_PAR02% 
				AND AA1.AA1_CODTEC BETWEEN %exp:MV_PAR03% AND  %exp:MV_PAR04%
				AND AA1.AA1_CC BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
				AND ABS.ABS_LOCAL BETWEEN %exp:MV_PAR07%  AND %exp:MV_PAR08%
				AND ABB.%notDel%
				ORDER BY AA1.AA1_CDFUNC, TDV.TDV_DTREF, ABB.ABB_DTINI, ABB.ABB_DTFIM, ABB.ABB_HRINI, ABB.ABB_HRFIM
		EndSql
	END REPORT QUERY oReport:Section(1)

	//Define tamanho da regua de processamento
	oReport:SetMeter((cAlias)->(RecCount()))

	//Monta a primeira secao do relatorio
	oSection1:Init()

	//Pinta cada registro da query de busca no relatorio
	dbSelectArea(cAlias)
	While (cAlias)->(!Eof())
		oSection1:PrintLine()

		//botao cancelar
		If oReport:Cancel()
			Exit
		EndIf

		//Incremento da regua
		oReport:IncMeter()

		//Proximo registro
		(cAlias)->(dbSkip())                                                          
	EndDo

	(cAlias)->(dbCloseArea())
	oSection1:Finish()
RestArea(aArea)
Return


//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg

