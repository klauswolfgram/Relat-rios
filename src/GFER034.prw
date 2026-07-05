/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

  
/*---------------------------------------------------------
{Protheus.doc} GFER034
	   
@author siegklenes.beulke
@since 25/07/2013
@version 1.0

@description
Relatório de Ocorrências por Transportador,
Apresenta a ocorrencias por transportador, detalhando por tipo ou por motivo do tipo

-------------------------------------------------------------*/

User Function GFER034()
	Local oReport
	Local aArea := GetArea()
	Private cTranspTab // Registros referente aos transportadores
	Private cTipoOcor // registros referentes aos transportadores e tipos de ocorrencia
	Private cMotivTipo // registros referentes aos transportadores e motivo do tipo
	Private cTotTab	// registros totalizadores

	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)
	GFEDelTab(cTotTab)
	
	If !Vazio(cTranspTab)
		(cTranspTab)->(dbCloseArea())
	EndIf		

	If !Vazio(cTipoOcor)
		(cTipoOcor)->(dbCloseArea())
	EndIf
	
	If !Vazio(cMotivTipo)
		(cMotivTipo)->(dbCloseArea())
	EndIf	
	
Return Nil

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportDef
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario. 

@author siegklenes.beulke
@version 1.0
@since 25/07/2013
@return oReport Objeto do Relatorio.

/*/
//--------------------------------------------------------------------------------------------------------

Static Function ReportDef()
	Local oReport, oSection, oSection2, oSection3, oSection4, cTotal := "Total"
	
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
																	
	oReport := TReport():New("GFER034","Ocorrencias por Transportador","GFER034", {|oReport| ReportPrint(oReport)},"Emite relatório de Ocupação de Veículos por Transportador conforme os parâmetros informados."/*Descricao do relatório*/)
	oReport:SetLandscape(.T.)   //Define a oriadmientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.T.) //Define se os totalizadores serão impressos em linha ou coluna 
	 oReport:HideParamPage() //Oculta página de parametros
	If !Empty(oReport:uParam)
	    Pergunte(oReport:uParam,.F.)  
	EndIf
	oSection := TRSection():New(oReport,"Ocorrencias de Transporte",{"(cTranspTab)"},{"Ocorrencias de Transporte"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
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
	
	TRCell():New(oSection,"(cTranspTab)->GU3_CDEMIT","(cTranspTab)","Transportador",GetSx3Inf("GU3_CDEMIT")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTranspTab)->GU3_NMEMIT","(cTranspTab)",GetSx3Inf("GU3_NMEMIT")[1],"@!",80,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	TRCell():New(oSection,"(cTranspTab)->GWD_NROCO", "(cTranspTab)", "Qtde Ocorrencias",GetSx3Inf("GWD_NROCO")[3] , , )
	TRCell():New(oSection,"(cTranspTab)->GWI_VLFRET","(cTranspTab)","Valor Ocorrencias",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cTranspTab)->NRDC", "(cTranspTab)", "Qtde Doc Cargas",GetSx3Inf("GW1_NRDC")[3],,,)
	
	oSection2 := TRSection():New(oSection,"Tipo de Ocorrencias",{"(cTipoOcor)"},{"Tipos de Ocorrencias"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection2:SetTotalInLine(.T.)
	oSection2:SetHeaderSection(.T.)
	TRCell():New(oSection2,"(cTipoOcor)->GU5_CDTIPO","(cTipoOcor)","Tipo Ocorrencias",GetSx3Inf("GU5_CDTIPO")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cTipoOcor)->GU5_DESC","(cTipoOcor)","Descriçao","@!",50,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	//TRCell():New(oSection2,"(cTipoOcor)->GW1_NRDC", "(cTipoOcor)", "Qtde Doc Cargas",GetSx3Inf("GW1_NRDC")[3],,,)
	TRCell():New(oSection2,"(cTipoOcor)->GWD_NROCO", "(cTipoOcor)", "Qtde Ocorrencias",GetSx3Inf("GWD_NROCO")[3] , , )
	TRCell():New(oSection2,"(cTipoOcor)->GWI_VLFRET","(cTipoOcor)","Valor Ocorrencias",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	oSection3 := TRSection():New(oSection,"Motivo do Tipo",{"(cMotivTipo)"},{"Motivos do Tipo"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection3:SetTotalInLine(.T.)
	oSection3:SetHeaderSection(.T.)
	TRCell():New(oSection3,"(cMotivTipo)->GU6_CDMOT","(cMotivTipo)","Motivo Ocorrencias",GetSx3Inf("GU6_CDMOT")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"(cMotivTipo)->GU6_DESC","(cMotivTipo)","Descriçao","@!",50,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	//TRCell():New(oSection3,"(cMotivTipo)->GW1_NRDC", "(cMotivTipo)", "Qtde Doc Cargas",GetSx3Inf("GW1_NRDC")[3],,,)
	TRCell():New(oSection3,"(cMotivTipo)->GWD_NROCO", "(cMotivTipo)", "Qtde Ocorrencias",GetSx3Inf("GWD_NROCO")[3] , , )
	TRCell():New(oSection3,"(cMotivTipo)->GWI_VLFRET","(cMotivTipo)","Valor Ocorrencias",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	oSection4 := TRSection():New(oSection,"Totalizadores",{"(cTotTab)"}) //  //"Totalizadores"
	oSection4:SetTotalInLine(.T.)
	oSection4:SetHeaderSection(.T.)
	TRCell():New(oSection4,"cTotal","","Totalizadores",,2,,{||cTotal})
	TRCell():New(oSection4,"cTotal","","",,2)
	TRCell():New(oSection4,"(cTotTab)->GWD_TOTOCO", "(cTotTab)"	, "Qtde Ocorrencias", GetSx3Inf("GWD_NROCO")[3] ,9 , , )
	TRCell():New(oSection4,"(cTotTab)->GWI_VLFRET", "(cTotTab)"	, "Valor Ocorrencias", GetSx3Inf("GWI_VLFRET")[3], TamSX3("GWI_VLFRET" )[1] , , )
	TRCell():New(oSection4,"(cTotTab)->GW1_TOTDOC", "(cTotTab)"	, "Qtde Doc Cargas", GetSx3Inf("GWD_NROCO")[3] , 9, , )
	
Return oReport

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.  

@param oReport Objeto do relatório  
@author Siegklenes.beulke
@version 1.0
@since 22/07/2013
@return Nil
/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
	Local oSection  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	Local oSection3  := oReport:Section(1):Section(2)
	Local oSection4  := oReport:Section(1):Section(3)

	CarregaDados()
	
	oReport:SetMeter((cTranspTab)->(LastRec()))
	
	If MV_PAR11 == 1
		RecLock((cTotTab), .T.)
		oSection:Init()
	EndIf
	
	While !oReport:Cancel() .And. !(cTranspTab)->( Eof() )
		
		If MV_PAR11 == 1
			oSection:PrintLine()
			(cTotTab)->GW1_TOTDOC +=  (cTranspTab)->NRDC
			(cTotTab)->GWD_TOTOCO +=  (cTranspTab)->GWD_NROCO
			(cTotTab)->GWI_VLFRET +=  (cTranspTab)->GWI_VLFRET
		Else
			oSection:Init()
			oSection:PrintLine()
			oSection2:Init()	// Detalhe da transportadora, imprime abaixo da transportadora
			While !oReport:Cancel() .And. !(cTipoOcor)->( Eof() ) .And. (cTipoOcor)->GWD_CDTRP == (cTranspTab)->GU3_CDEMIT
				oSection2:PrintLine()
				(cTipoOcor)->(dbSkip())
			EndDo
			oSection2:Finish()
			If MV_PAR11 == 3
			oSection3:Init()	// Detalhe da transportadora, imprime abaixo da transportadora
				While !oReport:Cancel() .And. !(cMotivTipo)->( Eof() ) .And. (cMotivTipo)->GWD_CDTRP == (cTranspTab)->GU3_CDEMIT
					oSection3:PrintLine()
					(cMotivTipo)->(dbSkip())
				EndDo
			oSection3:Finish()
			EndIf
			oSection:Finish()
		EndIf
		
		(cTranspTab)->(dbSkip())
		
	EndDo
	If MV_PAR11 == 1
		MsUnlock((cTotTab))
		
		oSection4:Init()
		oSection4:PrintLine()
		oSection4:Finish()
		oSection:Finish()
	EndIf	
Return Nil

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CarregaDados
A funcao estatica CarregaDados Alimentam as tabelas temporárias cTabOc e cTabTotOc 
Faz a leitura do Pergunte GFER034
@author siegklenes.beulke
@version 1.0
@since 22/07/2013
@return Nil

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CarregaDados()
	Local aArea := GetArea(), cQuery := ""
	Local cFltrGWD := ""
	Local cFltrGU3 := ""
	Local cFltrGU5 := ""
	Local cFltrGU6 := "" 
	CriaTabTemp()
	
	/* Parametros do pergunte
		01 Filial de 
		02 Filial ate
		03 Data Ocor de // Data ocorrencia
		04 Data Ocor ate
		05 Transp de // transportadora
		06 Transp ate
		07 Grupo Transp // grupo de transportadoras do tipo gerencial		
		08 Situação Ocor // situação da Ocorrencia(gwd_sit) (1=Pendentes, 2=Aprovadas, 3=Reprovadas)
		09 Provocado por // Provocador (gu6_provoc) (1=Transportador, 2=Remetente, 3=Destinatario, 4=Outros)
		10 Eventos // tipo de evento (gu5_evento) (1=Cálculo Adicional, 2=Cancelamento Frete, 3=Simples Registros)
		11 Tipo Relatório (1=Resumido, 2=Detalhado por Tipo, 3=Detalhado por Tipo e Motivo) 
	*/
	cFltrGWD += " AND GWD_FILIAL >= '" + MV_PAR01 + "' AND GWD_FILIAL <= '" + MV_PAR02 + "'"
	cFltrGWD += " AND GWD_DTOCOR >= '" + DTOS(MV_PAR03) + "' AND GWD_DTOCOR <= '" + DTOS(MV_PAR04) + "'"
	
	If Empty(MV_PAR07)
		cFltrGU3 += " AND " + RetSQLName("GU3") + ".GU3_CDEMIT >= '" + MV_PAR05 + "' AND " + RetSQLName("GU3") + ".GU3_CDEMIT <= '" + MV_PAR06 + "'"
	Else
		cFltrGU3 += " AND " + RetSQLName("GU3") + ".GU3_CDGRGL = '" + MV_PAR07 + "'"
	EndIf
	
	Do Case
		Case MV_PAR08 == 1
			cFltrGWD += " AND GWD_SIT IN ('1','2','3')"
		Case MV_PAR08 > 1 .And. MV_PAR08 <= 4
			cFltrGWD += " AND GWD_SIT = '" + cValtoChar(MV_PAR08-1) + "'"
		Case MV_PAR08 == 5
			cFltrGWD += " AND GWD_SIT <>'3'"
	EndCase
	
	Do Case
		Case MV_PAR09 == 1
			cFltrGU6 += " AND GU6_PROVOC IN ('1','2','3','4')"
		Case MV_PAR09 == 2
			cFltrGU6 += " AND GU6_PROVOC = '1'"
		Case MV_PAR09 == 3
			cFltrGU6 += " AND GU6_PROVOC <> '1'"
	EndCase
	
	Do Case
		Case MV_PAR10 == 1
			cFltrGU5 += " AND GU5_EVENTO IN ('1','2','3')"
		Case MV_PAR10 == 2
			cFltrGU5 += " AND GU5_EVENTO = '2'"
		Case MV_PAR10 == 3
			cFltrGU5 += " AND GU5_EVENTO = '1'"
		Case MV_PAR10 == 4
			cFltrGU5 += " AND GU5_EVENTO = '3'"
		Case MV_PAR10 == 5
			cFltrGU5 += " AND GU5_EVENTO <> '3'"
	EndCase
	
	cQuery += "SELECT DISTINCT"  
	cQuery += "	" + RetSQLName("GU3") + ".GU3_CDEMIT,"
	cQuery += "	" + RetSQLName("GU3") + ".GU3_NMEMIT,"
	cQuery += "	COUNT(CDEMIT) NRDC,"
	cQuery += "	(	SELECT" 
	cQuery += "			COUNT (GWD_NROCO)" 
	cQuery += "		FROM " + RetSQLName("GWD")
	cQuery += "		INNER JOIN " + RetSQLName("GU5") + " ON " + RetSQLName("GU5") + ".D_E_L_E_T_<> '*' AND GU5_CDTIPO = GWD_CDTIPO"
	cQuery += "		INNER JOIN " + RetSQLName("GU6") + " ON " + RetSQLName("GU6") + ".D_E_L_E_T_<> '*' AND GU6_CDMOT = GWD_CDMOT"
	cQuery += "		WHERE GWD_CDTRP = " + RetSQLName("GU3") + ".GU3_CDEMIT"
	cQuery += "		AND " + RetSQLName("GWD") + ".D_E_L_E_T_ = ' '" + cFltrGU5 + cFltrGU6 + cFltrGWD
	cQuery += "	) GWD_NROCO," 
	cQuery += "	(	SELECT" 
	cQuery += "			SUM(GWI_VLFRET) GWI_VLFRET"
	cQuery += "		FROM " + RetSQLName("GWD") 
	cQuery += "		INNER JOIN " + RetSQLName("GU5") + " ON " + RetSQLName("GU5") + ".D_E_L_E_T_<> '*' AND GU5_CDTIPO = GWD_CDTIPO"
	cQuery += "		INNER JOIN " + RetSQLName("GU6") + " ON " + RetSQLName("GU6") + ".D_E_L_E_T_<> '*' AND GU6_CDMOT = GWD_CDMOT"
	cQuery += "		LEFT JOIN " + RetSQLName("GWF") 
	cQuery += "		ON GWF_FILIAL = GWD_FILIAL" 
	cQuery += "		AND GWF_NROCO = GWD_NROCO" 
	cQuery += "		AND " + RetSQLName("GWF") + ".D_E_L_E_T_ = ' '" 
	cQuery += "		AND " + RetSQLName("GWD") + ".D_E_L_E_T_ = ' '"
	cQuery += "		LEFT JOIN ("
	cQuery += "			SELECT DISTINCT" 
	cQuery += "				GWI_NRCALC,"  
	cQuery += "				GWI_FILIAL," 
	cQuery += "	   			SUM(GWI_VLFRET) GWI_VLFRET"
	cQuery += "			FROM " + RetSQLName("GWI")
	cQuery += "			WHERE D_E_L_E_T_ = ' ' AND GWI_TOTFRE = '1'"
	cQuery += "			GROUP BY GWI_NRCALC, GWI_FILIAL"
	cQuery += "		) CALCFRETE" 
	cQuery += "		ON CALCFRETE.GWI_FILIAL = GWF_FILIAL"
	cQuery += "		AND CALCFRETE.GWI_NRCALC = GWF_NRCALC"
	cQuery += "		WHERE GWD_CDTRP = " + RetSQLName("GU3") + ".GU3_CDEMIT" + cFltrGU5 + cFltrGU6 + cFltrGWD
	cQuery += "	) GWI_VLFRET"
	cQuery += "	FROM " + RetSQLName("GU3")
	cQuery += "	INNER JOIN ("
	cQuery += "		SELECT" 
	cQuery += "			" + RetSQLName("GU3") + ".GU3_CDEMIT CDEMIT"			
	cQuery += "			FROM " + RetSQLName("GU3")
	cQuery += "			INNER JOIN("
	cQuery += "			SELECT DISTINCT"
	cQuery += "				GWD_CDTRP, GWL_NRDC"
	cQuery += "			FROM " + RetSQLName("GWD")
	cQuery += "			INNER JOIN " + RetSQLName("GU5") + " ON " + RetSQLName("GU5") + ".D_E_L_E_T_<> '*' AND GU5_CDTIPO = GWD_CDTIPO"
	cQuery += "			INNER JOIN " + RetSQLName("GU6") + " ON " + RetSQLName("GU6") + ".D_E_L_E_T_<> '*' AND GU6_CDMOT = GWD_CDMOT"
	cQuery += "			INNER JOIN " + RetSQLName("GWL")
	cQuery += "			ON GWD_FILIAL = GWL_FILIAL"
	cQuery += "			AND GWD_NROCO = GWL_NROCO AND " + RetSQLName("GWL") + ".D_E_L_E_T_ = ' ' AND " + RetSQLName("GWD") + ".D_E_L_E_T_ = ' '" + cFltrGU5 + cFltrGU6 + cFltrGWD
	cQuery += "		) OCO ON OCO.GWD_CDTRP = " + RetSQLName("GU3") + ".GU3_CDEMIT AND " + RetSQLName("GU3") + ".D_E_L_E_T_ = ' '" + cFltrGU3
	cQuery += "	) DOCCARGA"
	cQuery += "	ON DOCCARGA.CDEMIT = " + RetSQLName("GU3") + ".GU3_CDEMIT"
	cQuery += "	WHERE " + RetSQLName("GU3") + ".D_E_L_E_T_ = ' ' AND (" + RetSQLName("GU3") + ".GU3_AUTON = '1' OR " + RetSQLName("GU3") + ".GU3_TRANSP = '1')" + cFltrGU3
	cQuery += "	GROUP BY " + RetSQLName("GU3") + ".GU3_CDEMIT, " + RetSQLName("GU3") + ".GU3_NMEMIT"
	cQuery += "	ORDER BY	" + RetSQLName("GU3") + ".GU3_CDEMIT"	
		
	
	cTranspTab := GetNextAlias()		
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,ChangeQuery(cQuery)),cTranspTab, .F., .T.)
	dbSelectArea((cTranspTab))
	(cTranspTab)->( dbGoTop() )
	
	If MV_PAR11 >= 2 
	
		cQuery := "	SELECT"
		cQuery += "	GWD.GWD_CDTRP,"  
		cQuery += "	GU5_CDTIPO,"
		cQuery += "	GU5_DESC,"
		cquery += "	COUNT(GWD.GWD_NROCO) GWD_NROCO,"
		cQuery += "	(	SELECT"
		cQuery += "			SUM(GWI_VLFRET) GWI_VLFRET"
		cQuery += "		FROM " + RetSQLName("GWD") + " GWDVALOR"
		cQuery += "		INNER JOIN " + RetSQLName("GU6") + " ON " + RetSQLName("GU6") + ".D_E_L_E_T_<> '*' AND GU6_CDMOT = GWDVALOR.GWD_CDMOT"
		cQuery += "		LEFT JOIN " + RetSQLName("GWF") 
		cQuery += "		ON GWF_FILIAL = GWDVALOR.GWD_FILIAL" 
		cQuery += "		AND GWF_NROCO = GWDVALOR.GWD_NROCO"
		cQuery += "		AND " + RetSQLName("GWF") + ".D_E_L_E_T_ = ' ' AND GWDVALOR.D_E_L_E_T_ = ' '" 
		cQuery += "		LEFT JOIN ("
		cQuery += "			SELECT DISTINCT" 
		cQuery += "				GWI_NRCALC," 
		cQuery += "				GWI_FILIAL," 
		cQuery += "	   			SUM(GWI_VLFRET) GWI_VLFRET"
		cQuery += "			FROM " + RetSQLName("GWI")
		cQuery += "			WHERE D_E_L_E_T_ = ' ' AND GWI_TOTFRE = '1'"
		cQuery += "			GROUP BY GWI_NRCALC, GWI_FILIAL"
		cQuery += "		) CALCFRETE" 
		cQuery += "		ON CALCFRETE.GWI_FILIAL = GWF_FILIAL"
		cQuery += "		AND CALCFRETE.GWI_NRCALC = GWF_NRCALC"
		cQuery += "		WHERE GWDVALOR.GWD_CDTIPO = GU5_CDTIPO	AND	GWDVALOR.GWD_CDTRP = GWD.GWD_CDTRP"  + cFltrGU6 + cFltrGWD
		cQuery += "	) GWI_VLFRET"
		cQuery += "	FROM " + RetSQLName("GU5")
		cQuery += "	INNER JOIN " + RetSQLName("GWD") + " GWD ON GWD.GWD_CDTIPO = GU5_CDTIPO"
		cQuery += "	INNER JOIN " + RetSQLName("GU3") + " ON " + RetSQLName("GU3") + ".D_E_L_E_T_<> '*' AND GWD.GWD_CDTRP = GU3_CDEMIT"
		cQuery += "	INNER JOIN " + RetSQLName("GU6") + " ON " + RetSQLName("GU6") + ".D_E_L_E_T_<> '*' AND GU6_CDMOT = GWD.GWD_CDMOT"
		cQuery += "	WHERE " + RetSQLName("GU5") + ".D_E_L_E_T_ = ' ' AND GWD.D_E_L_E_T_ = ' '" + cFltrGU5 + cFltrGU6 + cFltrGWD
		cQuery += " 	GROUP BY GWD.GWD_CDTRP, GU5_CDTIPO,GU5_DESC"
		cQuery += "	ORDER BY GWD.GWD_CDTRP, GU5_CDTIPO" 
		
				
		cTipoOcor := GetNextAlias()
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,ChangeQuery(cQuery)),cTipoOcor, .F., .T.)
		dbSelectArea((cTipoOcor))
		(cTipoOcor)->( dbGoTop() )
	EndIf
	
	If MV_PAR11  == 3
	
		cQuery := "	SELECT"
		cQuery += "	GWD.GWD_CDTRP," 
		cQuery += "	GU6_CDMOT,"
		cQuery += "	GU6_DESC,"
		cQuery += "	COUNT (GWD.GWD_NROCO)GWD_NROCO,"
		cQuery += "	(	SELECT" 
		cQuery += "			SUM(GWI_VLFRET) GWI_VLFRET"
		cQuery += "		FROM " + RetSQLName("GWD") + " GWDVALOR"
		cQuery += "		INNER JOIN " + RetSQLName("GU5") + " ON " + RetSQLName("GU5") + ".D_E_L_E_T_<> '*' AND GU5_CDTIPO = GWDVALOR.GWD_CDTIPO"
		cQuery += "		LEFT JOIN " + RetSQLName("GWF") 
		cQuery += "		ON GWF_FILIAL =  GWDVALOR.GWD_FILIAL" 
		cQuery += "		AND GWF_NROCO =  GWDVALOR.GWD_NROCO"
		cQuery += "		AND " + RetSQLName("GWF") + ".D_E_L_E_T_ = ' ' AND GWDVALOR.D_E_L_E_T_ = ' '" 
		cQuery += "		LEFT JOIN ("
		cQuery += "			SELECT DISTINCT" 
		cQuery += "				GWI_NRCALC," 
		cQuery += "				GWI_FILIAL," 
		cQuery += "	   			SUM(GWI_VLFRET) GWI_VLFRET"
		cQuery += "			FROM " + RetSQLName("GWI")
		cQuery += "			WHERE D_E_L_E_T_ = ' ' AND GWI_TOTFRE = '1'"
		cQuery += "			GROUP BY GWI_NRCALC, GWI_FILIAL"
		cQuery += "		) CALCFRETE" 
		cQuery += "		ON CALCFRETE.GWI_FILIAL = GWF_FILIAL"
		cQuery += "		AND CALCFRETE.GWI_NRCALC = GWF_NRCALC"
		cQuery += "		WHERE  GWDVALOR.GWD_CDMOT = GU6_CDMOT AND GWDVALOR.GWD_CDTRP = GWD.GWD_CDTRP" + cFltrGU5 + cFltrGWD
		cQuery += "	) GWI_VLFRET"
		cQuery += "	FROM " + RetSQLName("GU6")
		cQuery += "	INNER JOIN " + RetSQLName("GWD") + " GWD ON GWD.GWD_CDMOT = GU6_CDMOT"
		cQuery += "	INNER JOIN " + RetSQLName("GU3") + " ON " + RetSQLName("GU3") + ".D_E_L_E_T_<> '*' AND GWD.GWD_CDTRP = GU3_CDEMIT"
		cQuery += "	INNER JOIN " + RetSQLName("GU5") + " ON " + RetSQLName("GU5") + ".D_E_L_E_T_<> '*' AND GU5_CDTIPO = GWD.GWD_CDTIPO"
		cQuery += "	WHERE " + RetSQLName("GU6") + ".D_E_L_E_T_ = ' ' AND GWD.D_E_L_E_T_ = ' '" + cFltrGU5 + cFltrGU6 + cFltrGWD
		cQuery += "	GROUP BY GWD.GWD_CDTRP,GU6_CDMOT,GU6_DESC"
		cQuery += "	ORDER BY GWD.GWD_CDTRP,GU6_CDMOT"
		
		cMotivTipo := GetNextAlias()
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,ChangeQuery(cQuery)),cMotivTipo, .F., .T.)
		dbSelectArea((cMotivTipo))
		(cMotivTipo)->( dbGoTop() )
	
	EndIf
	RestArea(aArea)
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
A funcao estatica CriaTabTemp Cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER034() 

@author siegklenes.beulke
@version 1.0
@since 25/07/2013
@return {aStruOp,aStruOpTot} Array com Struct dos campos

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local  aStruTot
	
	aStruTot 	:= { 	{"GW1_TOTDOC","N",9,0},; // Qtde Doc Cargas
						{"GWD_TOTOCO","N",9,0},; // Qtde Ocorrencias
						{"GWI_VLFRET","N",TamSX3("GWI_VLFRET" )[1],TamSX3("GWI_VLFRET" )[2]}; // soma dos componentes de frete GWI_TOTFRE == '1'
					}
	
	
	cTotTab :=  GFECriaTab({aStruTot,{"GW1_TOTDOC"}})
Return {aStruTot}


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
