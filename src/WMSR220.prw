/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "WMSR220.ch"
#Include "Protheus.ch"

//-----------------------------------------------------------
/*/{Protheus.doc} WMSR220
Relação de operações executadas por um funcionário

@author  Flavio Luiz Vicco
@version	P11
@since   17/10/06 - revisão 18/09/14
/*/
//-----------------------------------------------------------
User Function WMSR220()
Local oReport
	If !SuperGetMV("MV_WMSNEW", .F., .F.)
		Return DLGR220()
	EndIf

	// Interface de Impressão
	oReport:= ReportDef()
	oReport:PrintDialog()
Return( Nil )
//-----------------------------------------------------------
// Definições do relatório
//-----------------------------------------------------------
Static Function ReportDef()
Local oReport, oSection1, oSection2, oSection3
Local cPictQtd   := PesqPict("D12","D12_QTDMOV")
Local cAliasRel  := GetNextAlias()
	// Criacao do componente de impressao
	oReport := TReport():New("WMSR220",STR0001,"WMSR220",{|oReport| ReportPrint(oReport,cAliasRel)},STR0001) // Mapa de Separacao
	oReport:SetColSpace(2)
	oReport:lParamPage := .F.
	// Verifica os parâmetros selecionados via Pergunte
	Pergunte(oReport:GetParam(),.F.)

	// Seção 1 - Movimentos por endereco - Estrutura
	// TRSection:New(oParent,cTitle,uTable,aOrder,lLoadCells,lLoadOrder,uTotalText,lTotalInLine,lHeaderPage,lHeaderBreak,lPageBreak,lLineBreak,nLeftMargin,lLineStyle,nColSpace,lAutoSize,cCharSeparator,nLinesBefore,nCols,nClrBack,nClrFore,nPercentage)
	oSection1:= TRSection():New(oReport,STR0002,{"D12"},,,,,,,,,,,.T.,3) // Movimentos Serviços WMS - Estrutura
	TRCell():New(oSection1,"D12_MAPSEP" ,"D12")
	TRCell():New(oSection1,"D12_CARGA"  ,"D12")
	TRCell():New(oSection1,"D12_DOC"    ,"D12",STR0004,,TamSX3("C5_NUM")[1]) // Pedido
	TRCell():New(oSection1,"D12_ENDDES","D12")
	TRCell():New(oSection1,"BE_ESTFIS"  ,"SBE") // Estrutura
	TRCell():New(oSection1,"DC8_DESEST" ,"DC8")

	// Seção 2 - Movimentos por endereco - Endereco
	oSection2:= TRSection():New(oSection1,STR0007,{"D12","SB1"},,,,,,,,,,,.F.,0) // Movimentos por endereco - Endereco
	TRCell():New(oSection2,"D12_LOCORI","D12")
	TRCell():New(oSection2,"D12_ENDORI","D12")
	TRCell():New(oSection2,"D12_IDUNIT","D12")
	TRCell():New(oSection2,"D12_PRODUT","D12")
	TRCell():New(oSection2,"B1_DESC"   ,"SB1")
	TRCell():New(oSection2,"D12_LOTECT","D12")
	TRCell():New(oSection2,"D12_NUMLOT","D12")
	TRCell():New(oSection2,"NUNI"      ,/*Alias*/, STR0012  ,"@E 999,999,999",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")  // Qtd Unit
	TRCell():New(oSection2,"LACUNA1"   ,/*Alias*/, STR0012  ,/*Picture*/, 13        ,/*lPixel*/,{|| "[__________]"            }  )  // Qtd Unit
	TRCell():New(oSection2,"NCAIXAFC"  ,/*Alias*/, STR0009  ,"@E 999,999,999",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")  // Segunda UM
	TRCell():New(oSection2,"N2UM"      ,/*Alias*/, STR0013  ,"@E 999,999,999",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")  // 2a. U.M.
	TRCell():New(oSection2,"LACUNA2"   ,/*Alias*/, STR0013  ,/*Picture*/, 13        ,/*lPixel*/,{|| "[__________]"            }  )  // 2a. U.M.
	TRCell():New(oSection2,"B1_SEGUM"  ,"SB1"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,/*nColSpace*/ 1)
	TRCell():New(oSection2,"NUNIDADE"  ,/*Alias*/, STR0010  , cPictQtd  ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")  // Unidades
	TRCell():New(oSection2,"N1UM"      ,/*Alias*/, STR0014  , cPictQtd  ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")  // 1a. U.M.
	TRCell():New(oSection2,"LACUNA3"   ,/*Alias*/, STR0014  ,/*Picture*/, 13        ,/*lPixel*/,{|| "[__________]"            }  )  // 1a. U.M.
	TRCell():New(oSection2,"B1_UM"     ,"SB1"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,/*nColSpace*/ 1)
	TRCell():New(oSection2,"LACUNA8"   ,/*Alias*/, STR0011  ,/*Picture*/, 18        ,/*lPixel*/,{|| "__________________"      }  ) // Anormalidades

	// Seção 3 - Movimentos por endereco - Recurso Humano
	oSection3:= TRSection():New(oSection1,STR0008,{"D12"},{'1'}) // Movimentos por endereco - Recurso Humano
	TRCell():New(oSection3,"SEPARADOR", "",STR0005,,55,,{||" _______________________   ___:___   ___:___"}) // Separador :
	TRCell():New(oSection3,"CONFERENTE","",STR0006,,55,,{||" _______________________   ___:___   ___:___"}) // Conferente :
	oSection3:SetLineStyle(.F.)
	oSection3:SetCharSeparator("")

	// Esconde o título da 1a e 2a UM
	oSection2:Cell('B1_UM'   ):HideHeader()
	oSection2:Cell('B1_SEGUM'):HideHeader()

	// Posicionamento das tabelas secundárias na impressão do relatório
	TRPosition():New(oSection1,"DC8",1,{|| xFilial("DC8")+(cAliasRel)->BE_ESTFIS  })

Return( oReport )
//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasRel)
Local oSection1 := oReport:Section(1)
Local oSection2 := oSection1:Section(1)
Local oSection3 := oSection1:Section(2)
Local lWmsACar  := (SuperGetMV('MV_WMSACAR', .F., 'S')=='S')
Local cSemMpSep := Space(TamSX3("D12_MAPSEP")[1])
Local cWhere    := ""
Local cOrderBy  := ""
Local cMapa     := ""
Local cCodCFG   := ""
Local cPicCFG   := ""
Local cSeekQry  := ""
Local bSeekQry  := {||.T.}
Local nCaixaFc  := 0
Local nUnidade  := 0
Local aQtdUni   := {}
Local nLinBar   := 0

	If WmsX112118("WMSR220","18") .And. mv_par18 == 2 // Quebra por Estrutura ? 2=Não
		oSection1:Cell("BE_ESTFIS"):Disable()
		oSection1:Cell("DC8_DESEST"):Disable()
	EndIf

	If mv_par15 == 2 // Imprime Lote ? 2=Não
		oSection2:Cell("D12_LOTECT"):Disable()
		oSection2:Cell("D12_NUMLOT"):Disable()
	EndIf
	If mv_par16 == 2 // Imprime Unitizador ? 2=Não
		oSection2:Cell("D12_IDUNIT"):Disable()
	EndIf

	If WmsX112118("WMSR220","19") .And. mv_par19 == 1 // Oculta Quantidades ? 1=Sim
		oSection2:Cell("NUNI"):Disable()
		oSection2:Cell("N2UM"):Disable()
		oSection2:Cell("N1UM"):Disable()
		oSection2:Cell("NCAIXAFC"):Disable()
		oSection2:Cell("NUNIDADE"):Disable()
		If mv_par17 == 2 // Imprimir U.M.I. ? 2=Não
			oSection2:Cell("LACUNA1"):Disable()
		EndIf
	Else
		oSection2:Cell("LACUNA1"):Disable()
		oSection2:Cell("LACUNA2"):Disable()
		oSection2:Cell("LACUNA3"):Disable()
		If mv_par17 == 2 // Imprimir U.M.I. ? 2=Não
			oSection2:Cell("NUNI"):Disable()
			oSection2:Cell("N2UM"):Disable()
			oSection2:Cell("N1UM"):Disable()
		Else
			oSection2:Cell("NCAIXAFC"):Disable()
			oSection2:Cell("NUNIDADE"):Disable()
		EndIf
	EndIf

	cWhere += " D12.D12_SERVIC BETWEEN '"+mv_par02+"' AND '"+mv_par03+"'"
	cWhere += " AND D12.D12_TAREFA BETWEEN '"+mv_par04+"' AND '"+mv_par05+"'"
	cWhere += " AND D12.D12_ATIVID BETWEEN '"+mv_par06+"' AND '"+mv_par07+"'"
	cWhere += " AND D12.D12_CARGA  BETWEEN '"+mv_par09+"' AND '"+mv_par10+"'"
	cWhere += " AND D12.D12_DOC    BETWEEN '"+mv_par11+"' AND '"+mv_par12+"'"

	If mv_par01 == 1
		cWhere += " AND D12.D12_STATUS = '4'"
		cWhere += " AND D12.D12_MAPSEP = '"+cSemMpSep+"'"
	Else
		cWhere += " AND D12.D12_MAPSEP BETWEEN '"+mv_par13+"' AND '"+mv_par14+"'"
		cWhere += " AND D12.D12_MAPSEP <> '"+cSemMpSep+"'"
		cWhere += " AND D12.D12_STATUS <> '0'"
		cWhere += " AND D12.D12_ATUEST = '1'"
	EndIf
	cWhere := "%"+cWhere+"%"

	// Query do relatório da secao 1
	If WmsX112118("WMSR220","18") .And. mv_par18 == 1
		If mv_par08 == 1 //Pedido
			cOrderBy := "BE_ESTFIS,D12_DOC,D12_PRIORI,D12_SERIE,D12_ENDORI,D12_IDUNIT,D12_PRODUT,D12_LOCORI"
		Else //Carga
			cOrderBy := "BE_ESTFIS,D12_CARGA,D12_PRIORI,D12_DOC,D12_ENDORI,D12_IDUNIT,D12_PRODUT,D12_LOCORI"
		EndIf
	Else
		//Ordena impressão do relatório conforme pergunte
		If mv_par08 == 1 //Pedido
			cOrderBy := "D12_DOC,D12_PRIORI,D12_SERIE,BE_ESTFIS,D12_ENDORI,D12_IDUNIT,D12_PRODUT,D12_LOCORI"
		Else //Carga
			cOrderBy := "D12_CARGA,D12_PRIORI,D12_DOC,D12_SERIE,BE_ESTFIS,D12_ENDORI,D12_IDUNIT,D12_PRODUT,D12_LOCORI"
		EndIf
	EndIf
	cOrderBy := "%"+cOrderBy+"%"

	oSection1:BeginQuery()
	BeginSql Alias cAliasRel
	  SELECT D12.D12_LOCORI,D12.D12_ENDORI,SBE.BE_ESTFIS,SBE.BE_CODCFG,
				D12.D12_LOCDES,D12.D12_ENDDES,
				D12.D12_CARGA,D12.D12_DOC,D12.D12_QTDMOV,
				D12.D12_SERVIC,D12.D12_TAREFA,D12.D12_ATIVID,
				D12.D12_PRODUT,D12.D12_LOTECT,D12.D12_NUMLOT,
				D12.D12_IDUNIT,D12.D12_ATUEST,
				D12.D12_MAPSEP,D12.D12_CODREC,D12.R_E_C_N_O_ RECNOD12,
				SB1.B1_DESC, SB1.B1_UM, SB1.B1_SEGUM, SB1.B1_CONV, SB5.B5_UMIND 
		 FROM %table:D12% D12
		 INNER JOIN %table:SB1% SB1
			 ON SB1.B1_FILIAL = %xFilial:SB1%
			AND SB1.B1_COD = D12.D12_PRODUT
			AND SB1.%NotDel%
		 INNER JOIN %table:SB5% SB5
			 ON SB5.B5_FILIAL = %xFilial:SB5%
			AND SB5.B5_COD = D12.D12_PRODUT
			// AND SB5.B5_WMSEMB = '2'
			AND SB5.%NotDel%
		INNER JOIN %table:SBE% SBE
			ON SBE.BE_FILIAL  = %xFilial:SBE%
		  AND SBE.BE_LOCAL   = D12.D12_LOCORI
		  AND SBE.BE_LOCALIZ = D12.D12_ENDORI
		  AND SBE.%NotDel%
		 WHERE D12.D12_FILIAL = %xFilial:D12%
			AND D12.D12_ORIGEM = 'SC9'
		   AND %Exp:cWhere%
		   AND D12.%NotDel%
		ORDER BY %Exp:cOrderBy%
	EndSql

	// EndQuery (Classe TRSection) - Prepara o relatório para executar o Embedded SQL
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)

	// Define que a seção filha utiliza a query da seção pai na impressão da seção
	oSection2:SetParentQuery()

	// Fluxo de impressão do relatório
	oReport:SetMeter((cAliasRel)->(LastRec()))

	While !oReport:Cancel() .And. !(cAliasRel)->(Eof())

		If mv_par01 == 1
			cMapa := WMSProxSeq("MV_WMSMPSP","D12_MAPSEP")
		Else
			cMapa := (cAliasRel)->D12_MAPSEP
		EndIf
		
		oSection1:Init()

		// Início da impressão das informações do mapa de separação e documento
		oSection1:Cell('D12_MAPSEP'):SetValue(cMapa)

		// Impressão do código de barras
		oReport:PrintText('')
		oReport:SkipLine(5)

        If oReport:nEnvironment == 1 .And. oReport:nDevice <> 6
		  	nLinBar := 1
		Else	
			nLinBar := 2
		EndIf

		MSBAR3("CODE128",nLinBar,0.5,Trim(cMapa),@oReport:oPrint,Nil,Nil,Nil,Nil ,1 ,Nil,Nil,Nil,.F.,,,.F.)

		oSection1:Cell("D12_CARGA"):Enable()
		oSection1:Cell("D12_DOC"):Enable()

		// Independente da quebra escolhida, deverá agrupar primeiro pelo número do mapa
		// Pois pode ser que a geração tenha sido feita por um agrupamento a impressão seja por outra
		// Desta forma deverá quebrar por mapa cada página a ser impressa
		// Quando não tem mapa gerado este campo está em branco não influenciando na quebra
		If mv_par08 == 1 .Or. Empty((cAliasRel)->D12_CARGA)  //Pedido
			oSection1:Cell("D12_CARGA"):Disable()
			cSeekQry := (cAliasRel)->D12_MAPSEP+Iif(WmsX112118("WMSR220","18") .And. mv_par18==1,(cAliasRel)->BE_ESTFIS,"")+(cAliasRel)->D12_DOC
			bSeekQry := &("{|| cSeekQry == (cAliasRel)->D12_MAPSEP+"+Iif(WmsX112118("WMSR220","18") .And. mv_par18==1,"(cAliasRel)->BE_ESTFIS+","")+"(cAliasRel)->D12_DOC}")
		ElseIf mv_par08 == 2 //Carga
			cSeekQry := (cAliasRel)->D12_MAPSEP+Iif(WmsX112118("WMSR220","18") .And. mv_par18==1,(cAliasRel)->BE_ESTFIS,"")+(cAliasRel)->D12_CARGA+Iif(lWmsACar,"",(cAliasRel)->D12_DOC)
			bSeekQry := &("{|| cSeekQry == (cAliasRel)->D12_MAPSEP+"+Iif(WmsX112118("WMSR220","18") .And. mv_par18==1,"(cAliasRel)->BE_ESTFIS+","")+"(cAliasRel)->D12_CARGA"+Iif(lWmsACar,"}","+(cAliasRel)->D12_DOC}"))
			If lWmsACar
				oSection1:Cell("D12_DOC"):Disable()
			EndIf
		EndIf

		oSection1:PrintLine()
		
		oSection2:Init()
		While !oReport:Cancel() .And. (cAliasRel)->(!Eof()) .And. Eval(bSeekQry)

			If cCodCFG <> (cAliasRel)->BE_CODCFG // Verifica se o codigo mudou
				cCodCFG := (cAliasRel)->BE_CODCFG // Atualiza flag
				cPicCFG := DLXPicEnd((cAliasRel)->BE_CODCFG) // Atualiza Picture
				oSection2:Cell('D12_ENDORI'):SetPicture(cPicCFG)
			EndIf

			If WmsX112118("WMSR220","19") .And. mv_par19 == 2
				If mv_par17 == 1  // Imprimir U.M.I.    ? Sim
					aQtdUni := WmsQtdUni((cAliasRel)->D12_PRODUT,(cAliasRel)->D12_LOCORI,(cAliasRel)->BE_ESTFIS,(cAliasRel)->D12_QTDMOV)
					oSection2:Cell("NUNI"):SetValue(aQtdUni[1,1])
					oSection2:Cell("N2UM"):SetValue(aQtdUni[2,1])
					oSection2:Cell("N1UM"):SetValue(aQtdUni[3,1])
				Else
					If (cAliasRel)->B5_UMIND == "1"
						nCaixaFc := 0
						nUnidade := (cAliasRel)->D12_QTDMOV
					Else
						If !Empty((cAliasRel)->B1_CONV)
							nCaixaFc := Int(ConvUM((cAliasRel)->D12_PRODUT,(cAliasRel)->D12_QTDMOV,0,2))
							nUnidade := (cAliasRel)->D12_QTDMOV - ConvUM((cAliasRel)->D12_PRODUT,0,nCaixaFc,1)
						Else
							nCaixaFc := (cAliasRel)->D12_QTDMOV
							nUnidade := 0
						EndIf
					EndIf
					oSection2:Cell("NCAIXAFC"):SetValue(nCaixaFc)
					oSection2:Cell("NUNIDADE"):SetValue(nUnidade)
				EndIf
			EndIf

			// Somente imprime a atividade que movimenta estoque
			If (cAliasRel)->D12_ATUEST == "1"
				oSection2:PrintLine()
			EndIf

			If mv_par01 == 1
				D12->(DbGoTo((cAliasRel)->RECNOD12))
				RecLock('D12', .F.)
				D12->D12_MAPSEP := cMapa
				D12->(MsUnlock())
			EndIf
			oReport:IncMeter()
			(cAliasRel)->(DbSkip())
		EndDo
		oSection2:Finish()
		oSection3:Init()
		oSection3:PrintLine()
		oSection3:Finish()
		oSection1:Finish()
		oReport:EndPage()
	EndDo
Return( Nil )
