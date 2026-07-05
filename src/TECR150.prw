/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#Include "REPORT.CH"
#Include "TECR150.CH"
Static cAutoPerg := "TECR150"
//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR150
@description Entregas CIF/FOB
@sample	 	U_TECR150() 
@param		Nenhum
@return		Nil
@author		Kaique Schiller
@since		18/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
User Function TECR150()

Local oReport	//Objeto relatorio TReport
Local cPerg := "TECR150"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³ MV_PAR01 : Região de?                                                  ³
//³ MV_PAR02 : Região até?                                                 ³
//³ MV_PAR03 : Cliente de?  											   ³
//³ MV_PAR04 : Loja de?                                                    ³
//³ MV_PAR05 : Cliente até?                                                ³
//³ MV_PAR06 : Loja até?                                                   ³
//³ MV_PAR07 : Local de?                                                   ³
//³ MV_PAR08 : Local até?                                                  ³
//³ MV_PAR09 : Produto de?                                                 ³
//³ MV_PAR10 : Produto até?                                                ³
//³ MV_PAR11 : Tipo do frete?                                              ³
//³ MV_PAR12 : Entrega imediata?                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg, .F.)

oReport := Rt150RDef(cPerg)
oReport:PrintDialog()

Return (.T.)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rt150RDef()

Entregas CIF/FOB - monta as Section's para impressão do relatorio

@sample 	Rt150RDef(cPerg)
@param cPerg 
@return oReport

@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------
Static Function Rt150RDef(cPerg)

Local aArea := GetArea()	//Guarda a area atual
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR150" TITLE STR0001 PARAMETER "TECR150" ACTION {|oReport| Tcr150PrtRpt(oReport, cPerg)} DESCRIPTION  STR0001 //"Entregas CIF" ## "Entregas CIF/FOB"
    oReport:SetLandscape() //Escolher o padrão de Impressao como Paisagem 
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0003 TABLES "ABS" //"Cidade"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE CELL NAME "ABS_MUNIC"	OF oSection1 TITLE STR0003 ALIAS "ABS"
		DEFINE CELL NAME "REGIAO"	OF oSection1 TITLE STR0007 ALIAS "SX5"
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao2 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	DEFINE SECTION oSection2 OF oSection1 TITLE STR0002 TABLE "SX5", "TFI", "TFJ", "TFL", "TEW", "SB1", "SA1", "ABS" LEFT MARGIN 5	//"Entregas"
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE CELL NAME "TFJ_TPFRET"	OF oSection2 TITLE STR0008 ALIAS "TFJ"
		DEFINE CELL NAME "ABS_DESCRI"	OF oSection2 TITLE STR0004 ALIAS "ABS"
		DEFINE CELL NAME "ABS_END"		OF oSection2 ALIAS "ABS"
		DEFINE CELL NAME "B1_DESC"		OF oSection2 TITLE STR0005 ALIAS "SB1"		
		DEFINE CELL NAME "TFI_PERINI"	OF oSection2 ALIAS "TFI"
		DEFINE CELL NAME "TFI_PERFIM"	OF oSection2 ALIAS "TFI"
		DEFINE CELL NAME "TFI_ENTEQP"	OF oSection2 ALIAS "TFI"
		DEFINE CELL NAME "TFI_COLEQP"	OF oSection2 ALIAS "TFI"
		DEFINE CELL NAME "A1_NOME"		OF oSection2 TITLE STR0006 ALIAS "SA1"
		DEFINE CELL NAME "TFI_QTDVEN"	OF oSection2 ALIAS "TFI"				
				
RestArea( aArea )
		
Return oReport

//------------------------------------------------------------------------------
/*/{Protheus.doc} Tcr150PrtRpt
@description	Realiza a pesquisa dos dados para o relatorio.
@sample	 	Tcr150PrtRpt(oReport) 
@param		oReport
@return		Nil
@author		Kaique Schiller
@since		14/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
Static Function Tcr150PrtRpt(oReport, cPerg)
Local oSection1 := oReport:Section(1)		// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)		// Define a secao 1 do relatorio
Local cAlias	:= GetNextAlias()			// Pega o proximo Alias Disponivel
Local cChave	:= ""
Local cWhere	:= ""

If MV_PAR11 == 1
	cWhere += "AND TFJ_TPFRET = '1'"
ElseIf MV_PAR11 == 2
	cWhere += "AND TFJ_TPFRET = '2'"
ElseIf MV_PAR11 == 3
	cWhere += "AND (TFJ_TPFRET = '1' OR TFJ_TPFRET = '2')"
EndIf

If MV_PAR12 == 1
	cWhere += "AND TEW_DTRINI <> ' '"
ElseIf MV_PAR12 == 2
	cWhere += "AND TEW_DTRINI = ' '"
EndIf

cWhere	:= '%' + cWhere + '%'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection1
	BEGIN REPORT QUERY oSection2

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query da secao 1³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BeginSql alias cAlias

			SELECT ABS.ABS_MUNIC,  SX5.X5_DESCRI REGIAO,  TFJ.TFJ_TPFRET, ABS.ABS_DESCRI, ABS.ABS_END, SB1.B1_DESC,
			       TFI.TFI_PERINI, TFI.TFI_PERFIM, TFI.TFI_ENTEQP, TFI.TFI_COLEQP, SA1.A1_NOME, TFI.TFI_QTDVEN
			  FROM %Table:TFJ% TFJ
			       INNER JOIN %Table:TFL% TFL ON TFL.TFL_FILIAL = %xFilial:TFL%
			                                 AND TFL.%notDel%
			                                 AND TFL.TFL_CODPAI = TFJ.TFJ_CODIGO 
			       INNER JOIN %Table:TFI% TFI ON TFI.TFI_FILIAL = %xFilial:TFI%
			                                 AND TFI.%notDel%
			                                 AND TFI.TFI_CODPAI = TFL.TFL_CODIGO
			       INNER JOIN %Table:ABS% ABS ON ABS.ABS_FILIAL = %xFilial:ABS%
			                                 AND ABS.%notDel%
			                                 AND ABS.ABS_LOCAL = TFL.TFL_LOCAL
			       INNER JOIN %Table:TEW% TEW ON TEW.TEW_FILIAL = %xFilial:TEW%
			                                 AND TEW.%notDel%
			                                 AND TEW.TEW_CODEQU = TFI.TFI_COD
			       INNER JOIN %Table:SA1% SA1 ON SA1.A1_FILIAL  = %xFilial:SA1%
			                                 AND SA1.%notDel%
			                                 AND SA1.A1_COD = ABS.ABS_CODIGO
			                                 AND SA1.A1_LOJA = ABS.ABS_LOJA
			       LEFT JOIN  %Table:SX5% SX5 ON SX5.X5_FILIAL  = %xFilial:SX5%
			                                 AND SX5.%notDel%
			                                 AND SX5.X5_TABELA = 'A2'
			                                 AND SX5.X5_CHAVE = SA1.A1_REGIAO
			       INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL  = %xFilial:SB1%
			                                 AND SB1.%notDel%
			                                 AND SB1.B1_COD = TFI.TFI_PRODUT
			 WHERE SA1.A1_REGIAO >= %Exp:MV_PAR01%
			   AND SA1.A1_REGIAO <= %Exp:MV_PAR02%
			   AND TFJ.TFJ_CODENT >= %Exp:MV_PAR03%
			   AND TFJ.TFJ_CODENT <= %Exp:MV_PAR05%
			   AND TFJ.TFJ_LOJA   >= %Exp:MV_PAR04%
			   AND TFJ.TFJ_LOJA   <= %Exp:MV_PAR06%
			   AND TFI.TFI_LOCAL  >= %Exp:MV_PAR07%
			   AND TFI.TFI_LOCAL  <= %Exp:MV_PAR08%
			   AND TFI.TFI_PRODUT >= %Exp:MV_PAR09%
			   AND TFI.TFI_PRODUT <= %Exp:MV_PAR10%
			   AND TFI.TFI_PERINI >= %Exp:MV_PAR13%
			   AND TFI.TFI_PERINI <= %Exp:MV_PAR14%
			   AND TFI.TFI_PERFIM >= %Exp:MV_PAR15%
			   AND TFI.TFI_PERFIM <= %Exp:MV_PAR16%
			   AND TFI.TFI_ENTEQP >= %Exp:MV_PAR17%
			   AND TFI.TFI_ENTEQP <= %Exp:MV_PAR18%
			   AND TFI.TFI_COLEQP >= %Exp:MV_PAR19%
			   AND TFI.TFI_COLEQP <= %Exp:MV_PAR20%
			   AND TFJ.%NotDel%
			   %Exp:cWhere%
			 ORDER BY ABS.ABS_MUNIC, SX5.X5_CHAVE, TFJ.TFJ_TPFRET, TFI.TFI_LOCAL, ABS.ABS_CODIGO

		EndSql

	END REPORT QUERY oSection1
END REPORT QUERY oSection2

dbSelectArea(cAlias)
If !oReport:Cancel() .And. !(cAlias)->(EOF())

	While !oReport:Cancel() .And. !(cAlias)->(Eof())
		oSection1:Init()
		oSection1:PrintLine()
		cChave	:= (cAlias)->ABS_MUNIC + (cAlias)->REGIAO
		While !oReport:Cancel() .And. !(cAlias)->(Eof()) .AND. cChave	== (cAlias)->ABS_MUNIC + (cAlias)->REGIAO
			oSection2:Init()
			oSection2:PrintLine()
			(cAlias)->(dbSkip())
		EndDo
		oSection2:Finish()
		oSection1:Finish()
	EndDo
	
EndIf

(cAlias)->(dbCloseArea())
Return (.T.)

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatóio
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Monta as definiçoes do relatorio.
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()

Return Rt150RDef(GetPergTRp())

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Chama a função ReportPrint
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport ( oReport )

Return Tcr150PrtRpt( oReport , GetPergTRp())
