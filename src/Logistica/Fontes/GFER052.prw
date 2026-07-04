/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"


/*---------------------------------------------------------
{Protheus.doc} GFER052
	
@author siegklenes.beulke
@since 02/07/2013
@version 1.0

@description
Relatório Carga e Frete por Romaneio
Mostra indices do Valor Do Frete Calculado sob informações de Valor da carga,
Peso da carga, Volume da carga, Distancia percorrida e por quantidade de volumes  

-------------------------------------------------------------*/

User Function GFER052()
	Local oReport
	Local aArea := GetArea()

	Private cTabAlGWN       := "" // Consulta SQL
	Private cTabTot         := "" // Totalizadores

	If TRepInUse()
		//+------------------------------------------------------------------------+
		//|Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	RestArea(aArea)

	GFEDelTab(cTabAlGWN)
	GFEDelTab(cTabTot)
Return


//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReporteDef
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario. 

@author siegklenes.beulke
@version 1.0
@since 02/07/2013
@return oReport Objeto do Relatorio.

/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportDef()
	Local oReport
	
//+------------------------------------------------------------------------+
//|Criacao do componente de impressao                                      |
//|                                                                        |
//|TReport():New                                                           |
//|ExpC1 : Nome do relatorio                                               |
//|ExpC2 : Titulo                                                          |
//|ExpC3 : Pergunte                                                        |
//|ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  |
//|ExpC5 : Descricao                                                       |
//|                                                                        |
//+------------------------------------------------------------------------+
	oReport := TReport():New("GFER052","Relatório de Carga e Frete dos Romaneios","GFER052", {|oReport| ReportPrint(oReport)},"Emite relatório de Cargo e Frete por Romaneio conforme os parâmetros informados."/*Descricao do relatório*/)
	//configura a tela de paramêtros para vir selecionado a opção planilha
	
	oReport:SetLandscape(.T.)   //Define a orientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.T.) //Define se os totalizadores serão impressos em linha ou coluna 
	oReport:HideParamPage()
	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)  
	EndIf

//+------------------------------------------------------------------------+
//|Criacao da secao utilizada pelo relatorio                               |
//|                                                                        |
//|TRSection():New                                                         |
//|ExpO1 : Objeto TReport que a secao pertence                             |
//|ExpC2 : Descricao da seçao                                              |
//|ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   |
//|        sera considerada como principal para a seção.                   |
//|ExpA4 : Array com as Ordens do relatório                                |
//|ExpL5 : Carrega campos do SX3 como celulas                              |
//|        Default : False                                                 |
//|ExpL6 : Carrega ordens do Sindex                                        |
//|        Default : False                                                 |
//|                                                                        |
//+------------------------------------------------------------------------+


	oSection1 := TRSection():New(oReport,"Cálculos de Romaneio",{"(cTabAlGWN)"},{"Carga e Frete por Romaneio"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
//Exemplo utilizando a tabela de clientes.
//oSection1 := TRSection():New(oReport,"Clientes",{"SA1"})
	oSection1:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
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
	//TRCell():New(oSection1,/*X3_CAMPO*/,/*Tabela*/,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection2 := TRSection():New(oSection1,"Carga e Frete por Romaneio",{"(cTabAlGWN)"}) //  //"Totalizadores"
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_FILIAL", "(cTabAlGWN)", "Filial"			  , 				   , , , )
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_NRROM"	, "(cTabAlGWN)", "Nr. Romaneio"	   	  , 				   , , , )                                                                    //Stod ou cTod apresentou problemas com Excel 2010
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_DTIMPL", "(cTabAlGWN)", "Data Criação"	   	  ,					   , , ,{||If(Vazio((cTabAlGWN)->GWN_DTIMPL),(cTabAlGWN)->GWN_DTIMPL,SubStr((cTabAlGWN)->GWN_DTIMPL,7,2) + '/' + SubStr((cTabAlGWN)->GWN_DTIMPL,5,2) + '/' + SubStr((cTabAlGWN)->GWN_DTIMPL,1,4))} )
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_DTSAI"	, "(cTabAlGWN)", "Data Liberação"	  , 				   , , ,{||If(Vazio((cTabAlGWN)->GWN_DTSAI),(cTabAlGWN)->GWN_DTSAI, SubStr((cTabAlGWN)->GWN_DTSAI,7,2) + '/' + SubStr((cTabAlGWN)->GWN_DTSAI,5,2) + '/' + SubStr((cTabAlGWN)->GWN_DTSAI,1,4))} )
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_CDTRP"	, "(cTabAlGWN)", "Cód. Tranportadora" , 				   , , , )
	TRCell():New(oSection2,"(cTabAlGWN)->GU3_NMEMIT", "(cTabAlGWN)", "Tranportadora"	  , 				   , , , )
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_PLACAD", "(cTabAlGWN)", "Placa"			  , 				   , , , )
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_CDMTR"	, "(cTabAlGWN)", "Cód. Motorista"	  , 				   , , , )
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_CDTPVC", "(cTabAlGWN)", "Cód. Tipo Veículo"  ,					   , , , )

	TRCell():New(oSection2,"nTotEntr"				, ""		   , "Qtde Entregas"	  ,"@E 99999"		   , 5, , {||nTotEntr} )
	TRCell():New(oSection2,"nTotDC"					, ""		   , "Qtde Documentos"    ,"@E 99999"		   , 5, , {||nTotDC} )

	TRCell():New(oSection2,"nPesor"					, ""		   , "Peso Carga"		  , 				   , , , {||nPesor} )
	TRCell():New(oSection2,"nVolume"				, ""		   , "Volume Carga m3"	  , 				   , , , {||nVolume} )
	TRCell():New(oSection2,"nValor"					, ""		   , "Valor Carga"		  ,					   , , , {||nValor} )
	TRCell():New(oSection2,"nQtVol"					, ""		   , "Qtde Volumes"	   	  , "@E 99999"		   , , , {||nQtVol} )

	TRCell():New(oSection2,"(cTabAlGWN)->GWN_DISTAN", "(cTabAlGWN)", "Percurso Estimado"  , "@E 99999"		   , , , )
	TRCell():New(oSection2,"(cTabAlGWN)->GWN_CALC"	, "(cTabAlGWN)", "Situação Cálculo"   , 				   , 30, , )

 	TRCell():New(oSection2,"nVlFret"				, ""		   , "Val Frete Calculado", 				   , , , {||nVlFret} )

	TRCell():New(oSection2,"nFretePes"				, ""		   , "Frete por Ton"	  ,"@E 999,999,999.99" , , ,{||nFretePes} )
	TRCell():New(oSection2,"nFretPecVal"			, ""		   , "% Frete Valor Carga","@E 999999999.99"   , , ,{||nFretPecVal} )
	TRCell():New(oSection2,"nFreteVol"				, ""		   , "Frete por m³"	   	  ,"@E 999,999,999.99" , , ,{||nFreteVol} )
	TRCell():New(oSection2,"nFreteQtdVol"			, ""		   , "Frete por Volume"   ,"@E 999,999,999.99" , , ,{||nFreteQtdVol})
	TRCell():New(oSection2,"nFreteDist"				, ""		   , "Frete por km"	   	  ,"@E 999,999,999.99" , , ,{||nFreteDist} )
	
	oSection3 := TRSection():New(oSection1,"Totalizadores",{"(cTabTot)"}) //  //"Totalizadores"
	oSection3:SetTotalInLine(.T.)
	oSection3:SetHeaderSection(.T.)
	TRCell():New(oSection3,"cTotal","","Totalizadores",,1,,{||cTotal})
	TRCell():New(oSection3,"cTotal","","",,1)
	TRCell():New(oSection3,"cTotal","","",,1)
	TRCell():New(oSection3,"cTotal","","",,1)
	TRCell():New(oSection3,"cTotal","","",,1)
	TRCell():New(oSection3,"cTotal","","",,1)
	TRCell():New(oSection3,"cTotal","","",,1)
	TRCell():New(oSection3,"cTotal","","",,1)
	TRCell():New(oSection3,"cTotal","","",,1)
	TRCell():New(oSection3,"(cTabTot)->GWN_TOTENT"	, "(cTabTot)"	, "Qtde Entregas", , , , )
	TRCell():New(oSection3,"(cTabTot)->GWN_TOTDC"	, "(cTabTot)"	, "Qtde Documentos", , , , )
	TRCell():New(oSection3,"(cTabTot)->GW8_PESOR"	, "(cTabTot)"	, "Peso Carga", , , , )
	TRCell():New(oSection3,"(cTabTot)->GW8_VOLUME"	, "(cTabTot)"	, "Vol Carga m3", , , , )
	TRCell():New(oSection3,"(cTabTot)->GW8_VALOR"	, "(cTabTot)"	, "Val Carga", , , , )
	TRCell():New(oSection3,"(cTabTot)->GW1_QTVOL"	, "(cTabTot)"	, "Qtde Volumes", , , , )
	TRCell():New(oSection3,"(cTabTot)->GWN_DISTAN"	, "(cTabTot)"	, "Percurso Estimado", , , , )
	TRCell():New(oSection3,"cTotal"				    ,""				, "", , 2)
	TRCell():New(oSection3,"(cTabTot)->FRETPES"	    , "(cTabTot)"	, "Frete por Ton", , , , )
	TRCell():New(oSection3,"(cTabTot)->FRETPECVAL"	, "(cTabTot)"	, "% Frete Valor Carga", , , , )
	TRCell():New(oSection3,"(cTabTot)->FRETEVOL"	, "(cTabTot)"	, "Frete por m³", , , , )
	TRCell():New(oSection3,"(cTabTot)->FRETEQTDVO"	, "(cTabTot)"	, "Frete por volume", , , , )
	TRCell():New(oSection3,"(cTabTot)->FRETEDIS"	, "(cTabTot)"	, "Frete por km", , , , )
	
Return(oReport)


//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.  

@param oReport Objeto do relatório  
@author Siegklenes.beulke
@version 1.0
@since 02/07/2013
@return Nil
/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
	Local oSection1         := oReport:Section(1)
	Local oSection2         := oReport:Section(1):Section(1)
	Local oSection3         := oReport:Section(1):Section(2)
	Local cTabAux           := ""
	Local cQuery            := ""
	Local cFiltro           := ""
	//--------- Indices de cálculo
	Private nTotEntr        := 0 //Total de entregas do romaneio
	Private nTotDC          := 0 //Total de doctos de carga do romaneio
	Private nQtVol          := 0 //Qtde de volumes do romaneio
	Private nPesor          := 0 //Peso Real do romaneio
	Private nVolume         := 0 //Volumes do romaneio
	Private nValor          := 0 //Valor das notas do romaneio
	Private nVlFret         := 0 //Valor de frete do romaneio
	
	Private nFretePes       := 0// Valor do Frete por tonelada
	Private nFretPecVal     := 0 // Valor do frete por valor da carga
	Private nFreteVol       := 0//Valor do Frete por m3
	Private nFreteDist      := 0 // Valor do frete por km
	Private nFreteQtdVol    := 0 // Valor do frete por Quantidade de volumes
	
	Private nSomaFret       := 0
	Private nSomaTon        := 0
	Private nSomaVCar       := 0
	Private nSomaVol        := 0
	Private nSomaDist       := 0
	Private nSomaQVol       := 0
	Private aSomaIndice     := {0,0,0,0,0}
	
	Private cTotal          := "Total"
	Private cFiltroItens    := '' //Filtro SQL
	Private cFiltroCalculos := '' //Filtro SQL
	Private lProgress       := .F.

	lProgress := TCGETDB() == 'OPENEDGE'

	CriaTabela() // cria tabela totalizadores
	CarregaDados(oReport)
	
	oReport:SetMeter((cTabAlGWN)->(LastRec()))
	oSection1:Init()
	oSection2:Init()
	
	cTabAux := GetNextAlias()
	
	RecLock((cTabTot), .T.)
	Do While !oReport:Cancel() .And. (cTabAlGWN)->(!Eof())
		oReport:IncMeter()
		
		//Quando for progress efetua as querys de agregação de forma individual
		If lProgress
			cQuery := SQLTotDC(.T., (cTabAlGWN)->GWN_FILIAL, (cTabAlGWN)->GWN_NRROM)
			cQuery := ChangeQuery(cQuery)	
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabAux, .F., .T.)
			(cTabAux)->( dbGoTop() )
			nTotDC := (cTabAux)->GWN_TOTDC
			(cTabAux)->(dbCloseArea())
			
			//Devido à forma como a Query é montada quando banco não é progress, que só seleciona romaneios com
			// documento de carga, caso o romaneio não tenha, deve ser desconsiderado.
			If nTotDC == 0
				(cTabAlGWN)->(dbskip())
				Loop
			EndIf 	
	
			cQuery := SQLTotEntr(.T., (cTabAlGWN)->GWN_FILIAL, (cTabAlGWN)->GWN_NRROM)
			cQuery := ChangeQuery(cQuery)	
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabAux, .F., .T.)
			(cTabAux)->( dbGoTop() )
			nTotEntr := (cTabAux)->GWN_TOTENT
			(cTabAux)->(dbCloseArea()) 	
		
			cQuery := SQLQtVol(.T., (cTabAlGWN)->GWN_FILIAL, (cTabAlGWN)->GWN_NRROM)
			cQuery := ChangeQuery(cQuery)	
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabAux, .F., .T.)
			(cTabAux)->( dbGoTop() )
			nQtVol := (cTabAux)->GW1_QTVOL
			(cTabAux)->(dbCloseArea()) 	

			cFiltro := " AND GW1_FILIAL = '" + (cTabAlGWN)->GWN_FILIAL + "'"
			cFiltro += " AND GW1_NRROM  = '" + (cTabAlGWN)->GWN_NRROM + "'"
			cQuery := SQLTotItens(.T., cFiltro)
			cQuery := ChangeQuery(cQuery)	
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabAux, .F., .T.)
			(cTabAux)->( dbGoTop() )
			nPesor := (cTabAux)->GW8_PESOR
			nVolume := (cTabAux)->GW8_VOLUME
			nValor :=  (cTabAux)->GW8_VALOR
			(cTabAux)->(dbCloseArea())
			
			cFiltro := " AND GWF_FILIAL = '" + (cTabAlGWN)->GWN_FILIAL + "'"
			cFiltro += " AND GWF_NRROM  = '" + (cTabAlGWN)->GWN_NRROM + "'" 
			cQuery := SQLTotCalc(.T., cFiltro)
			cQuery := ChangeQuery(cQuery)	
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabAux, .F., .T.)
			(cTabAux)->( dbGoTop() )
			nVlFret := (cTabAux)->GWI_VLFRET
			(cTabAux)->(dbCloseArea())		
		Else
			nTotEntr := (cTabAlGWN)->GWN_TOTENT
			nTotDC   := (cTabAlGWN)->GWN_TOTDC
			nQtVol   := (cTabAlGWN)->GW1_QTVOL
			nPesor   := (cTabAlGWN)->GW8_PESOR
			nVolume  := (cTabAlGWN)->GW8_VOLUME
			nValor   := (cTabAlGWN)->GW8_VALOR
			nVlFret  := (cTabAlGWN)->GWI_VLFRET
		EndIf	

		If GFXCP1212210('GWF_FILROM')
			GWF->( dbSetOrder(7) )
		Else
			GWF->( dbSetOrder(4) )
		EndIf
		If GWF->( dbSeek((cTabAlGWN)->GWN_FILIAL + (cTabAlGWN)->GWN_NRROM) )
			nVlFret := nVlFret + GWF->GWF_VLAJUS	
		EndIf

		//--------- Indices de cálculo
		nFretePes 		:= nVlFret/(nPesor/1000)
		nFretPecVal 	:= (nVlFret/nValor)*100
		nFreteVol		:= nVlFret/nVolume
		nFreteQtdVol	:= nVlFret/nQtVol
		nFreteDist		:= nVlFret/(cTabAlGWN)->GWN_DISTAN
		
		(cTabTot)->GWN_TOTENT	+= nTotEntr
		(cTabTot)->GWN_TOTDC	+= nTotDC
		(cTabTot)->GW8_PESOR	+= nPesor
		(cTabTot)->GW8_VOLUME	+= nVolume
		(cTabTot)->GW8_VALOR	+= nValor
		(cTabTot)->GW1_QTVOL	+= nQtVol
		(cTabTot)->GWN_DISTAN	+= (cTabAlGWN)->GWN_DISTAN
		(cTabTot)->GWI_VLFRET	+= nVlFret
		
		oSection1:PrintLine()
		oSection2:PrintLine()
		(cTabAlGWN)->(dbskip())
	Enddo

	(cTabTot)->FRETPES     := (cTabTot)->GWI_VLFRET/((cTabTot)->GW8_PESOR/1000)
	(cTabTot)->FRETPECVAL  := ((cTabTot)->GWI_VLFRET/(cTabTot)->GW8_VALOR)*100
	(cTabTot)->FRETEVOL    := (cTabTot)->GWI_VLFRET/(cTabTot)->GW8_VOLUME
	(cTabTot)->FRETEQTDVOL := (cTabTot)->GWI_VLFRET/(cTabTot)->GW1_QTVOL
	(cTabTot)->FRETEDIS    := (cTabTot)->GWI_VLFRET/(cTabTot)->GWN_DISTAN
	(cTabTot)->(MsUnlock())
	
	oSection3:Init()
	oSection3:PrintLine()
		
	oSection1:Finish()
	oSection2:Finish()
	oSection3:Finish()

Return


Static Function CarregaDados(oReport)
	Local cQuery := ''
	Local cFilialDe, cFilialAte, cNrRomDe, cNrRomAte, dCriacaoDe, dCriacaoAte, dDataLibDe
	Local dDataLibAte, cTranspDeRoman, cTranspAteRoman, cTipoVeiDe, cTipoVeiAte, cClasFretDe, cClasFretAte
	/*
		01 Filial de
		02 Filial ate
		03 Nr Romaneio de
		04 Nr Romaneio ate
		05 Situacao Romaneio
		06 Data Criacao de
		07 Data Criacao ate
		08 Data Liberacao de
		09 Data Liberacao ate
		10 Tranportadora Romaneio de
		11 Tranportadora Romaneio ate
		12 Tipo Transportadora Romaneio
		13 Tipo Veiculo de
		14 Tipo Veiculo ate
		15 Classificacao Frete de
		16 Classificacao Frete ate
	*/ 
		
	cFilialDe := MV_PAR01
	cFilialAte := MV_PAR02
	cNrRomDe := MV_PAR03
	cNrRomAte := MV_PAR04
	nSitRom := MV_PAR05 // 1 Todos, 2 A liberar(Digitado/Emitido), 3 Em Transito(Liberado), 4 Encerrado 5 Exceto encerrado
	dCriacaoDe := MV_PAR06
	dCriacaoAte := MV_PAR07
	dDataLibDe := MV_PAR08
	dDataLibAte := MV_PAR09
	cTranspDeRoman := MV_PAR10
	cTranspAteRoman := MV_PAR11
	nTipoTransp := MV_PAR12 // 1 Todos, 2 Execeto Autonomos, 3 Autonomos
	cTipoVeiDe := MV_PAR13
	cTipoVeiAte := MV_PAR14
	cClasFretDe := MV_PAR15
	cClasFretAte := MV_PAR16
	
	cFiltroItens += " AND GW1_FILIAL >='" + cFilialDe + "'"
	cFiltroItens += " AND GW1_FILIAL <='" + cFilialAte + "'"
	cFiltroItens += " AND GW1_NRROM >='"  + cNrRomDe + "'"
	cFiltroItens += " AND GW1_NRROM <='"  + cNrRomAte + "'"

	cFiltroCalculos += " AND GWF_FILIAL >='" + cFilialDe + "'"
	cFiltroCalculos += " AND GWF_FILIAL <='" + cFilialAte + "'"
	cFiltroCalculos += " AND GWF_NRROM >='"  + cNrRomDe + "'"
	cFiltroCalculos += " AND GWF_NRROM <='"  + cNrRomAte + "'"


	cTabAlGWN := 	GetNextAlias()
	
	cQuery += "SELECT "
	cQuery += "	GWN_FILIAL, GWN_NRROM, GWN_DTIMPL, GWN_DTSAI, GWN_CDTRP, GU3_NMEMIT, GWN_PLACAD, GWN_CDMTR, GWN_CDTPVC," 
	cQuery += "	GWN_DISTAN, (CASE GWN_CALC"
	cQuery += "					WHEN '1' THEN	'Calculado com Sucesso'"
	cQuery += "					WHEN '2' THEN	'Não Calculado'"
	cQuery += "					WHEN '3' THEN	'Tentativa sem Sucesso'"
	cQuery += "					WHEN '4' THEN	'Necessita Recálculo'"
	cQuery += "					ELSE 'Não Informado'"
	cQuery += "				END) GWN_CALC"

	//Para Progress as funções de agregração serão executadas individualmente, dentro do while, 
	//devido à lentidão.
	//As funções foram criadas individualmente, com pequenas adaptações de acordo com o tipo de banco de dados,
	//de forma que a lógica da query seja mantida para qualquer banco sem ocasionar divergências no resultado.
	
	cQuery += SQLTotEntr(.F., '', '')
	
	cQuery += SQLTotDC(.F., '', '')
	
	cQuery += SQLQtVol(.F., '', '')
	 
	If lProgress
		cQuery += " FROM " + RetSQLName("GWN")
	Else
		cQuery += "	,GW8_PESOR,GW8_VOLUME,GW8_VALOR, GWI_VLFRET"

		cQuery += "	FROM "
		
		cQuery += SQLTotItens(.F., cFiltroItens)

		cQuery += "LEFT OUTER JOIN"
		
		cQuery += SQLTotCalc(.F., cFiltroCalculos)

		cQuery += "    ON CALCULOS.GWF_FILIAL = ITENS.GW1_FILIAL AND CALCULOS.GWF_NRROM = ITENS.GW1_NRROM"
		cQuery += " INNER JOIN " + RetSQLName("GWN") 
		If GFXCP1212210('GW1_FILROM')
			cQuery += " ON GWN_FILIAL = ITENS.GW1_FILROM"
		Else
			cQuery += " ON GWN_FILIAL = ITENS.GW1_FILIAL"
		EndIf
		cQuery += "    AND GWN_NRROM = ITENS.GW1_NRROM"
	
	EndIf

	cQuery += " INNER JOIN " + RetSQLName("GU3") + " ON GWN_CDTRP = GU3_CDEMIT"
	cQuery += " WHERE GWN_FILIAL >='" + cFilialDe + "' AND GWN_FILIAL <='" +   cFilialAte + "'"
	cQuery += " AND GWN_NRROM >='"  + cNrRomDe + "' AND GWN_NRROM <='" +   cNrRomAte + "'"
	cQuery += " AND GWN_CDTRP >='" + cTranspDeRoman + "' AND GWN_CDTRP <='" + cTranspAteRoman + "'"
	cQuery += " AND GWN_CDTPVC >='" + cTipoVeiDe + "' AND GWN_CDTPVC <='" + cTipoVeiAte + "'"
	cQuery += " AND GWN_CDCLFR >='" + cClasFretDe + "' AND GWN_CDCLFR <='" + cClasFretAte + "'"	

	cQuery += " AND GWN_DTIMPL >='" + DTOS(dCriacaoDe) + "' AND GWN_DTIMPL <='" + DTOS(dCriacaoAte) + "'"
	cQuery += " AND (GWN_DTSAI >='" + DTOS(dDataLibDe) + "' AND GWN_DTSAI <='" + DTOS(dDataLibAte) + "'"

	If CVALTOCHAR(nSitRom) $ '125'
		cQuery += " OR GWN_DTSAI = '" + Replicate(" ",8) + "')"
	Else
		cQuery += ")"
	EndIf

	Do Case
		Case nSitRom == 1
			cQuery += " AND GWN_SIT IN('1','2','3','4')"
		Case nSitRom == 2
			cQuery += " AND GWN_SIT IN('1','2')"
		Case nSitRom == 3 
			cQuery += " AND GWN_SIT = '3'"
		Case nSitRom == 4
			cQuery += " AND GWN_SIT = '4'"
		Case nSitRom == 5
			cQuery += " AND GWN_SIT != '4'"
	EndCase
		
	Do Case
		Case nTipoTransp == 1
			cQuery += " AND GU3_AUTON IN('1','2')"
		Case nTipoTransp == 2
			cQuery += " AND GU3_AUTON !='1'"
		Case nTipoTransp == 3
			cQuery += " AND GU3_AUTON ='1'"
	EndCase

	cQuery += " AND " + TabNDel("GWN") + " AND " + TabNDel("GU3")
	 
			
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabAlGWN, .F., .T.)
	dbSelectArea((cTabAlGWN))
	(cTabAlGWN)->( dbGoTop() )	
	
Return Nil

Static Function CriaTabela()
	Local aTotalTb
	
	aTotalTb := {{"GWN_TOTENT", "N", TamSX3("GW1_NRDC")[1]    , TamSX3("GW1_NRDC")[2]},;
				 {"GWN_TOTDC" , "N", TamSX3("GW1_NRDC")[1]    , TamSX3("GW1_NRDC")[2]},;
				 {"GW8_PESOR" , "N", TamSX3("GW8_PESOR")[1]+5 , TamSX3("GW8_PESOR")[2]},;
				 {"GW8_VOLUME", "N", TamSX3("GW8_VOLUME")[1]+5, TamSX3("GW8_VOLUME")[2]},;
				 {"GW8_VALOR" , "N", TamSX3("GW8_VALOR")[1]+5 , TamSX3("GW8_VALOR")[2]},;
				 {"GW1_QTVOL" , "N", TamSX3("GW1_QTVOL")[1]+5 , TamSX3("GW1_QTVOL")[2]},;
				 {"GWN_DISTAN", "N", TamSX3("GWN_DISTAN")[1]+5, TamSX3("GWN_DISTAN")[2]},;
				 {"GWI_VLFRET", "N", TamSX3("GWI_VLFRET")[1]+5, TamSX3("GWI_VLFRET")[2]},;
				 {"FRETPES"   , "N", TamSX3("GWI_VLFRET")[1]+5, TamSX3("GWI_VLFRET")[2]},;
				 {"FRETPECVAL", "N", TamSX3("GWI_VLFRET")[1]+5, TamSX3("GWI_VLFRET")[2]},;
				 {"FRETEVOL"  , "N", TamSX3("GWI_VLFRET")[1]+5, TamSX3("GWI_VLFRET")[2]},;
				 {"FRETEQTDVO", "N", TamSX3("GWI_VLFRET")[1]+5, TamSX3("GWI_VLFRET")[2]},;
				 {"FRETEDIS"  , "N", TamSX3("GWI_VLFRET")[1]+5, TamSX3("GWI_VLFRET")[2]}}

	cTabTot := GFECriaTab({aTotalTb, {"GWN_TOTENT"}})

Return Nil

/*/ {Protheus.doc}  SQLTotEntr
Retorna query de total de entregas do romaneio.
Quando progress, retorna o select count para ser diretamente executado, sendo feito somente no while da query principal.
Quando outro banco, retorna a query de forma a ser unida à query principal, com JOIN na GWN, que está sendo montada.
Entrada: 
lWhile - indica se a função foi chamada dentro do while ou na montagem da query principal.
cFil - Filial do romaneio
cNrRom - Número do romaneio
/*/
Static Function SQLTotEntr(lWhile, cFil, cNrRom)
	Local cQuery
	
	//Se progress e query principal, não faz leitura de agregação. Faz no while dos romaneios
	If lProgress .And. !lWhile
		cQuery := ''
	Else	
		IIf (lWhile, cQuery := "", cQuery := ", (")
	
		cQuery += "SELECT COUNT(GW1_NRDC)"
	
		If lWhile
			cQuery += " GWN_TOTENT "
		EndIf  
	
		cQuery += "  FROM " + RetSQLName("GW1")  
		cQuery += " INNER JOIN " + RetSQLName("GWU")  
		cQuery += "    ON GWU_FILIAL = GW1_FILIAL AND GWU_CDTPDC = GW1_CDTPDC"
		cQuery += "   AND GWU_EMISDC = GW1_EMISDC AND GWU_SERDC = GW1_SERDC AND GWU_NRDC = GW1_NRDC"
		cQuery += "   AND " + TabNDel("GWU")
		cQuery += " INNER JOIN " + RetSQLName("GU3")  
		cQuery += "    ON GU3_CDEMIT = GW1_CDDEST"
		cQuery += "   AND " + TabNDel("GU3")
		cQuery += " WHERE " + TabNDel("GW1")
		cQuery += "   AND GWU_NRCIDD != GU3_NRCID AND "
	
		If lWhile
			cQuery += " GW1_FILIAL = '" + cFil + "' AND GW1_NRROM = '" + cNrRom + "'"
		Else
			If GFXCP1212210('GW1_FILROM')
				cQuery += " GW1_FILROM = GWN_FILIAL AND GW1_NRROM = GWN_NRROM) GWN_TOTENT "
			Else
				cQuery += " GW1_FILIAL = GWN_FILIAL AND GW1_NRROM = GWN_NRROM) GWN_TOTENT "
			EndIf
		EndIf
	EndIf

Return cQuery

/*/ {Protheus.doc}  SQLTotDC
Retorna query de documentos de carga do romaneio.
Quando progress, retorna o select count para ser diretamente executado, sendo feito somente no while da query principal.
Quando outro banco, retorna a query de forma a ser unida à query principal, com JOIN na GWN, que está sendo montada.
Entrada: 
lWhile - indica se a função foi chamada dentro do while ou na montagem da query principal.
cFil - Filial do romaneio
cNrRom - Número do romaneio
/*/
Static Function SQLTotDC(lWhile, cFil, cNrRom)
	Local cQuery
	
	//Se progress e query principal, não faz leitura de agregação. Faz no while dos romaneios
	If lProgress .And. !lWhile
		cQuery := ''
	Else	
		IIf (lWhile, cQuery := "", cQuery := ", (")
	
		cQuery += "SELECT COUNT(GW1_NRDC)"
		
		If lWhile 
			cQuery += " GWN_TOTDC "
		EndIf
		
		cQuery += "  FROM " + RetSQLName("GW1") 
		cQuery += " WHERE " + TabNDel("GW1") + " AND "

		If lWhile
			cQuery += " GW1_FILIAL = '" + cFil + "' AND GW1_NRROM = '" + cNrRom + "'"
		Else
			If GFXCP1212210('GW1_FILROM')
				cQuery += " GW1_FILROM = GWN_FILIAL AND GW1_NRROM = GWN_NRROM) GWN_TOTDC "
			Else
				cQuery += " GW1_FILIAL = GWN_FILIAL AND GW1_NRROM = GWN_NRROM) GWN_TOTDC "
			EndIf
		EndIf
	EndIf
	
Return cQuery

/*/ {Protheus.doc}  SQLQtVol
Retorna query de total de volumes do romaneio.
Quando progress, retorna o select count para ser diretamente executado, sendo feito somente no while da query principal.
Quando outro banco, retorna a query de forma a ser unida à query principal, com JOIN na GWN, que está sendo montada.
Entrada: 
lWhile - indica se a função foi chamada dentro do while ou na montagem da query principal.
cFil - Filial do romaneio
cNrRom - Número do romaneio
/*/
Static Function SQLQtVol(lWhile, cFil, cNrRom)
	Local cQuery
	
	//Se progress e query principal, não faz leitura de agregação. Faz no while dos romaneios
	If lProgress .And. !lWhile
		cQuery := ''
	Else	
		IIf (lWhile, cQuery := "", cQuery := ", (")
		
		cQuery += "SELECT SUM(GW1_QTVOL)"
			
		If lWhile 
			cQuery += " GW1_QTVOL "
		EndIf
			
		cQuery += "  FROM " + RetSQLName("GW1") 
		cQuery += " WHERE " + TabNDel("GW1") + " AND "

		If lWhile
			cQuery += " GW1_FILIAL = '" + cFil + "' AND GW1_NRROM = '" + cNrRom + "'"
		Else
			If GFXCP1212210('GW1_FILROM')
				cQuery += " GW1_FILROM = GWN_FILIAL AND GW1_NRROM = GWN_NRROM) GW1_QTVOL "
			Else
				cQuery += " GW1_FILIAL = GWN_FILIAL AND GW1_NRROM = GWN_NRROM) GW1_QTVOL "
			EndIf
		EndIf
	EndIf

Return cQuery

/*/ {Protheus.doc}  SQLTotItens
Retorna query com peso, valor e volume dos documentos de carga do romaneio.
Quando progress, retorna o select count para ser diretamente executado, sendo feito somente no while da query principal.
Quando outro banco, retorna a query de forma a ser unida à query principal, com JOIN na GWN, que está sendo montada.
Entrada: 
lWhile - indica se a função foi chamada dentro do while ou na montagem da query principal.
cFiltro - contém o filtro no formato filial+nr romaneio ou com o JOIN da GWN, dependendo do caso
/*/
Static Function SQLTotItens(lWhile, cFiltro)
	Local cQuery
	
	//Se progress e query principal, não faz leitura de agregação. Faz no while dos romaneios
	If lProgress .And. !lWhile
		cQuery := ''
	Else	
		If lWhile
			cQuery := "SELECT "
		Else
			cQuery := "(SELECT GW1_NRROM, GW1_FILIAL,"
			If GFXCP1212210('GW1_FILROM')
				cQuery += "GW1_FILROM, "		
			EndIf
		EndIf
		
		cQuery += "SUM(GW8_PESOR) GW8_PESOR, SUM(GW8_VOLUME) GW8_VOLUME ,SUM(GW8_VALOR) GW8_VALOR"
		cQuery += "  FROM " + RetSQLName("GW1") 
		cQuery += " INNER JOIN " + RetSQLName("GW8") + " ON GW1_FILIAL = GW8_FILIAL AND GW1_CDTPDC = GW8_CDTPDC "
		cQuery += "	AND GW1_EMISDC = GW8_EMISDC AND GW1_SERDC = GW8_SERDC AND GW1_NRDC = GW8_NRDC AND " + TabNDel("GW8") 
		cQuery += " WHERE " + TabNDel("GW1") + cFiltro		
		
		If !lWhile
			cQuery += " GROUP BY GW1_NRROM, GW1_FILIAL "
			IF GFXCP1212210('GW1_FILROM')
				cQuery += ",GW1_FILROM "
			EndIf
			cQuery += ") ITENS "
		EndIf
	EndIf

Return cQuery

/*/ {Protheus.doc}  SQLTotCalc
Retorna query com valor total dos cálculos do romaneio.
Quando progress, retorna o select count para ser diretamente executado, sendo feito somente no while da query principal.
Quando outro banco, retorna a query de forma a ser unida à query principal, com JOIN na GWN, que está sendo montada.
Entrada: 
lWhile - indica se a função foi chamada dentro do while ou na montagem da query principal.
cFiltro - contém o filtro no formato filial+nr romaneio ou com o JOIN da GWN, dependendo do caso
/*/
Static Function SQLTotCalc(lWhile, cFiltro)
	Local cQuery
	
	//Se progress e query principal, não faz leitura de agregação. Faz no while dos romaneios
	If lProgress .And. !lWhile
		cQuery := ''
	Else	
		If lWhile 
			cQuery := "SELECT "
		Else
			cQuery := "(SELECT GWF_NRROM, GWF_FILIAL, "
		EndIf
	
		cQuery += "SUM(GWI_VLFRET) GWI_VLFRET"
		cQuery += "  FROM " + RetSQLName("GWF") 
		cQuery += " INNER JOIN " + RetSQLName("GWI") + " ON GWF_FILIAL = GWI_FILIAL AND GWF_NRCALC = GWI_NRCALC"
		cQuery += "   AND " + TabNDel("GWI") + " AND GWI_TOTFRE = '1'
		cQuery += " WHERE " + TabNDel("GWF") + " AND GWF_TPCALC != '8'" + cFiltro

		If !lWhile
			cQuery += " GROUP BY GWF_NRROM, GWF_FILIAL) CALCULOS "
		EndIf
	EndIf

Return cQuery

Static Function TabNDel(cTab)

	cTab := RetSQLName(cTab) + ".D_E_L_E_T_ = ' '
	 
Return cTab
