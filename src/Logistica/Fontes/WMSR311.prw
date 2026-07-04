/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'
#Include 'WMSR311.ch'

//---------------------------------------------------------------------------
/*/{Protheus.doc} WmsR311
Relatorio de monitoramento de servicos
@author Flavio Luiz Vicco
@since 13/10/2006
@version 1.0
@param lPerg, Logico, (Executa o pergunte sem apresentar em tela)
@param aMVPar, Record, (Array com os parametros do pergunte)
/*/
//---------------------------------------------------------------------------
User Function WMSR311()
Local oReport

	If !SuperGetMV("MV_WMSNEW", .F., .F.)
		Return WmsR310()
	EndIf
	//  Interface de impressao
	oReport:= ReportDef()
	oReport:PrintDialog()
Return( Nil )
//----------------------------------------------------------
// Definições do relatório
//----------------------------------------------------------
Static Function ReportDef()
Local cAliasNew := GetNextAlias()
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local aTam1UM  := TamSx3("B1_UM")
Local aTam2UM  := TamSx3("B1_SEGUM")
Local cPic1UM  := X3Picture( "D12_QTDMOV" )
Local cPic2UM  := X3Picture( "D12_QTDMO2" )

	//  Criacao do componente de impressao
							// New(cReport  ,cTitle,uParam  ,bAction                                   ,cDescription,lLandscape,uTotalText,lTotalInLine,cPageTText,lPageTInLine,lTPageBreak,nColSpace)
	oReport := TReport():New("WMSR311",STR0004,"WMSR311",{|oReport| ReportPrint(oReport,cAliasNew)},STR0004)//     ,          ,          ,            ,          ,            ,           ,5        ) //  "Mapa Movimentos Armazém"
	oReport:lParamPage := .F.
	//---------------------------------------
	//  Variaveis utilizadas para parametros
	//---------------------------------------
	//  mv_par01  -  Mapa ? Gera e Imprime / Imprime
	//  mv_par02  -  Servico   De  ?
	//  mv_par03  -            Ate ?
	//  mv_par04  -  Tarefa    De S ?
	//  mv_par05  -            Ate ?
	//  mv_par06  -  Atividade De  ?
	//  mv_par07  -            Ate ?
	//  mv_par08  -  Tipo Agrupamento ? Carga / Conferência / Doc/Pedido
	//  mv_par09  -  Carga     De  ?
	//  mv_par10  -            Ate ?
	//  mv_par11  -  Conf. Recebimento De ?
	//  mv_par12  -                    Ate?
	//  mv_par13  -  Documento De  ?
	//  mv_par14  -            Ate ?
	//  mv_par15  -  Mapa Separaçao De  ?
	//  mv_par16  -                 Ate ?
	//  mv_par17  -  Situaçao Movimentos ? Finalizado / Interrompido / Em Execucao / Nao Executado / Todos
	//  mv_par18  -  Quantidade    ? 1a.UM / 2a.UM / U.M.I. / Nao Imprime
	//---------------------------------------
	Pergunte(oReport:uParam,.F.)
	//  Criacao da secao utilizada pelo relatorio
	oSection1:= TRSection():New(oReport,STR0028,{"D12"},/*aOrdem*/) //  Movimentos por endereco - Documento
	oSection1:SetHeaderPage(.F.)
	oSection1:SetLineStyle()
	oSection1:SetColSpace(10)
	TRCell():New(oSection1,"D12_MAPSEP", "D12")
	TRCell():New(oSection1,"D12_CARGA",  "D12")
	TRCell():New(oSection1,"D12_CODREC", "D12")
	TRCell():New(oSection1,"D12_DOC",    "D12")
	//  Criacao da secao utilizada pelo relatorio
	oSection2:= TRSection():New(oSection1,STR0029,{"D12"},/*aOrdem*/) //  Movimentos por endereco - Atividades
	//oSection2:SetHeaderPage()
	TRCell():New(oSection2,"DATIVID",    "",STR0031,,30,,{|| Posicione("SX5",1,xFilial("SX5")+"L3"+(cAliasNew)->D12_ATIVID,"X5Descri()") }) //  Movimento
	TRCell():New(oSection2,"D12_ENDORI", "D12")
	TRCell():New(oSection2,"D12_IDUNIT", "D12")
	TRCell():New(oSection2,"D12_PRODUT", "D12")
	TRCell():New(oSection2,"D12_LOTECT", "D12")
	TRCell():New(oSection2,"D12_ENDDES", "D12")
	If WmsX312118("D12","D12_UNIDES",.T.)
		TRCell():New(oSection2,"D12_UNIDES", "D12")
	EndIf
	TRCell():New(oSection2,"D12_STATUS", "D12")
	TRCell():New(oSection2,"TRACO",      "",STR0032,,23,,{||"_______________________"}) //  Traco
	If WmsX112118("WMSR311","18")
		//  Criacao da secao utilizada pelo relatorio
		oSection3:= TRSection():New(oSection2,STR0030,{"D12"},/*aOrdem*/) //  Movimentos por endereco - Quantidades
		oSection3:SetLineStyle()
		oSection3:SetColSpace(3)
		TRCell():New(oSection3,"D12_QTDMOV", "D12",STR0012,,,,,"LEFT") //  Qtde 1a.U.M.
		TRCell():New(oSection3,"LACUNA1",    "",STR0012,,13+aTam1UM[1],,{||"[__________] "+(cAliasNew)->B1_UM }) //  Qtde 1a.U.M.
		TRCell():New(oSection3,"D12_QTDMO2", "D12",STR0013,,,,,"LEFT") //  Qtde 2a.U.M.
		TRCell():New(oSection3,"LACUNA2",    "",STR0013,,13+aTam2UM[1],,{||"[__________] "+(cAliasNew)->B1_SEGUM }) //  Qtde 2a.U.M.
		TRCell():New(oSection3,"NUMI",       "",STR0034,"@E 999,999",5,,,"LEFT") //  Qtd Unitiz
		TRCell():New(oSection3,"LACUNA3",    "",STR0034,,12,,{||"[__________]"}) //  Qtd Unitiz
		TRCell():New(oSection3,"CUNIT",      "",STR0035,,15) //  Unitizador
		TRCell():New(oSection3,"B1_DESC",    "SB1")
	EndIf

Return( oReport )
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1 := oReport:Section(1)
Local oSection2 := oSection1:Section(1)
Local oSection3 := oSection2:Section(1)
Local cSeekQry  := ""
Local bSeekQry  := {||.T.}
Local cLocaliz  := ""
Local cWhere    := ""
Local cMapa     := ""
Local cCodUni   := ""
Local cDesUni   := ""
Local cCFGOri   := ""
Local cCFGDes   := ""
Local cPicCFG   := ""
Local cOrderBy  := ""
Local cPic1UM   := AllTrim(X3Picture( "D12_QTDMOV" ))
Local cPic2UM   := AllTrim(X3Picture( "D12_QTDMO2" ))
Local nLinBar   := 0

	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	// Query do relatório da secao 1
	oSection1:BeginQuery()

	cWhere := "%"
	cWhere += " D12.D12_SERVIC BETWEEN '"+mv_par02+"' AND '"+mv_par03+"'"
	cWhere += " AND D12.D12_SERVIC BETWEEN '"+mv_par02+"' AND '"+mv_par03+"'"
	cWhere += " AND D12.D12_TAREFA BETWEEN '"+mv_par04+"' AND '"+mv_par05+"'"
	cWhere += " AND D12.D12_ATIVID BETWEEN '"+mv_par06+"' AND '"+mv_par07+"'"
	cWhere += " AND D12.D12_CARGA  BETWEEN '"+mv_par09+"' AND '"+mv_par10+"'"
	cWhere += " AND D12.D12_CODREC BETWEEN '"+mv_par11+"' AND '"+mv_par12+"'"
	cWhere += " AND D12.D12_DOC    BETWEEN '"+mv_par13+"' AND '"+mv_par14+"'"

	If WmsX112118("WMSR311","17") .And. mv_par17 <> 5
		cWhere += " AND D12.D12_STATUS = '"+AllTrim(Str(mv_par17))+"'"
	EndIf

	If mv_par01 == 1 //Gera e Imprime
		//Quando seleciono a opção 'Gera e Imprime' não deve-se mostrar as movimentações estornadas ou executadas
		cWhere += " AND D12.D12_MAPSEP = '"+Space(TamSX3("D12_MAPSEP")[1])+"'"
		If WmsX112118("WMSR311","17") .And. mv_par17 == 5
			cWhere += " AND D12.D12_STATUS <> '0' AND D12.D12_STATUS <> '1'"
		EndIf
	ElseIf mv_par01 == 2 //Imprime
		//Quando seleciono a opção 'Imprime' não deve-se mostrar as movimentações estornadas
		If WmsX112118("WMSR311","16")
			cWhere += " AND D12.D12_MAPSEP BETWEEN '"+mv_par15+"' AND '"+mv_par16+"'"
			cWhere += " AND D12.D12_MAPSEP <> '"+Space(TamSX3("D12_MAPSEP")[1])+"'"
			If mv_par17 == 5
				cWhere += " AND D12.D12_STATUS <> '0'"
			EndIf
		Else
			If !Empty(mv_par15)
				cWhere += " AND D12_MAPSEP = '"+%Exp:mv_par15%+"'"
			Else
				cWhere += " AND D12_MAPSEP <> '"+Space(TamSX3("D12_MAPSEP")[1])+"'"
			EndIf
		EndIf
	EndIf
	cWhere += " %"

	//Ordena impressão do relatório conforme pergunte
	If mv_par08 == 1  //Carga
		cOrderBy:= " D12.D12_MAPSEP, D12.D12_CARGA, D12.D12_PRIORI, D12.D12_DOC, D12_SERIE, D12.D12_CLIFOR, D12.D12_LOJA, D12.D12_SERVIC, D12.D12_TAREFA, D12.D12_ORDATI "
	ElseIf mv_par08 == 2 //Conferência
		cOrderBy:= " D12.D12_MAPSEP, D12.D12_CODREC, D12.D12_PRIORI, D12.D12_DOC, D12_SERIE, D12.D12_CLIFOR, D12.D12_LOJA, D12.D12_SERVIC, D12.D12_TAREFA, D12.D12_ORDATI "
	Else  //Docto
		cOrderBy:= " D12.D12_MAPSEP, D12.D12_DOC, D12.D12_PRIORI, D12_SERIE, D12.D12_CLIFOR, D12.D12_LOJA, D12.D12_SERVIC, D12.D12_TAREFA, D12.D12_ORDATI "
	EndIf
	cOrderBy := "%"+cOrderBy+"%"

	BeginSql Alias cAliasNew
		SELECT D12.D12_TAREFA,
				 D12.D12_ATIVID,
				 D12.D12_LOCORI,
				 D12.D12_ENDORI,
				 SBE1.BE_ESTFIS BE_ESTORI,
				 SBE1.BE_CODCFG BE_CFGORI,
				 D12.D12_ENDDES,
				 SBE2.BE_CODCFG BE_CFGDES,
				 D12.D12_PRODUT,
				 D12.D12_QTDMOV,
				 D12.D12_QTDMO2,
				 D12.D12_LOTECT,
				 SB1.B1_UM,
				 SB1.B1_SEGUM,
				 SB1.B1_DESC,
				 D12.D12_MAPSEP,
				 D12.D12_SERVIC,
				 CASE WHEN (D12_ORIGEM = 'SD1') THEN D12.D12_SERIE ELSE "" END D12_SERIE,
				 D12.D12_CLIFOR,
				 D12.D12_LOJA,
				 D12.D12_IDUNIT,
				 D12.D12_DOC,
				 D12.D12_CARGA,
				 D12.D12_CODREC,
				 D12.D12_ORIGEM,
				 D12.D12_PRIORI,
				 D12.D12_ORDATI,
				 D12.D12_STATUS,
				 D12.D12_UNIDES,
				 D12.R_E_C_N_O_ RECNOD12
		  FROM %table:D12% D12
		 INNER JOIN %table:SBE% SBE1
			 ON SBE1.BE_FILIAL  = %xFilial:SBE%
			AND D12.D12_FILIAL  = %xFilial:D12%
			AND SBE1.BE_LOCAL   = D12.D12_LOCORI
			AND SBE1.BE_LOCALIZ = D12.D12_ENDORI
			AND SBE1.%NotDel%
		 INNER JOIN %table:SBE% SBE2
			 ON SBE2.BE_FILIAL  = %xFilial:SBE%
			AND D12.D12_FILIAL  = %xFilial:D12%
			AND SBE2.BE_LOCAL   = D12.D12_LOCDES
			AND SBE2.BE_LOCALIZ = D12.D12_ENDDES
			AND SBE2.%NotDel%
		  LEFT JOIN %table:SB1% SB1
			 ON SB1.B1_FILIAL = %xFilial:SB1%
			AND SB1.B1_COD = D12.D12_PRODUT
			AND SB1.%NotDel%
		 WHERE D12.D12_FILIAL = %xFilial:D12%
			AND %Exp:cWhere%
			AND D12.%NotDel%
		 ORDER BY %Exp:cOrderBy%
	EndSql
	//  Metodo EndQuery ( Classe TRSection )
	//  Prepara o relatório para executar o Embedded SQL.
	//  ExpA1 : Array com os parametros do tipo Range
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)
	oSection2:SetParentQuery()

	If WmsX112118("WMSR311","18")
		oSection3:SetParentQuery()
		If mv_par18 == 1
			oSection3:Cell("D12_QTDMO2"):Disable()
			oSection3:Cell("LACUNA1"):Disable()
			oSection3:Cell("LACUNA2"):Disable()
			oSection3:Cell("NUMI"):Disable()
			oSection3:Cell("LACUNA3"):Disable()
			oSection3:Cell("CUNIT"):Disable()
		ElseIf mv_par18 == 2
			oSection3:Cell("D12_QTDMOV"):Disable()
			oSection3:Cell("LACUNA1"):Disable()
			oSection3:Cell("LACUNA2"):Disable()
			oSection3:Cell("NUMI"):Disable()
			oSection3:Cell("LACUNA3"):Disable()
			oSection3:Cell("CUNIT"):Disable()
		ElseIf mv_par18 == 3
			oSection3:Cell("LACUNA1"):Disable()
			oSection3:Cell("LACUNA2"):Disable()
			oSection3:Cell("LACUNA3"):Disable()
		ElseIf mv_par18 == 4
			oSection3:Cell("D12_QTDMOV"):Disable()
			oSection3:Cell("D12_QTDMO2"):Disable()
			oSection3:Cell("NUMI"):Disable()
		ElseIf mv_par18 == 5
			oSection3:Cell("LACUNA1"):Disable()
			oSection3:Cell("LACUNA2"):Disable()
			oSection3:Cell("LACUNA3"):Disable()
			oSection3:Cell("NUMI"):Disable()
			oSection3:Cell("CUNIT"):Disable()
		EndIf
		
		If mv_par19 == 2 // Imprimir Lote ? 2=Não
			oSection2:Cell("D12_LOTECT"):Disable()
		EndIf

		If mv_par20 == 2 // Imprimir Unitizador ? 2=Não
			oSection2:Cell("D12_IDUNIT"):Disable()
			oSection2:Cell("D12_UNIDES"):Disable()
		EndIf

	EndIf

	oReport:SetMeter(D12->(LastRec()))

	While !oReport:Cancel() .And. !(cAliasNew)->(Eof())

		If mv_par01 == 1
			cMapa := WMSProxSeq("MV_WMSMPSP","D12_MAPSEP")
		Else
			cMapa := (cAliasNew)->D12_MAPSEP
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
		oSection1:Cell("D12_CODREC"):Enable()

		// Independente da quebra escolhida, deverá agrupar primeiro pelo número do mapa
		// Pois pode ser que a geração tenha sido feita por um agrupamento a impressão seja por outra
		// Desta forma deverá quebrar por mapa cada página a ser impressa
		// Quando não tem mapa gerado este campo está em branco não influenciando na quebra
		If mv_par08 == 1 // Carga
			If Empty((cAliasNew)->D12_CARGA) // Se for vazio a carga exibe o documento (Pedido)
				cSeekQry := (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_DOC
				bSeekQry := &("{|| cSeekQry == (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_DOC}")
				oSection1:Cell("D12_CARGA"):Disable()
			Else
				cSeekQry := (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_CARGA
				bSeekQry := &("{|| cSeekQry == (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_CARGA}")
				oSection1:Cell("D12_DOC"):Disable()
			EndIf
			oSection1:Cell("D12_CODREC"):Disable()
		ElseIf mv_par08 == 2 // Recebimento
			If Empty((cAliasNew)->D12_CODREC)
				cSeekQry := (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_DOC
				bSeekQry := &("{|| cSeekQry == (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_DOC}")
				oSection1:Cell("D12_CODREC"):Disable()
			Else
				cSeekQry := (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_CODREC
				bSeekQry := &("{|| cSeekQry == (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_CODREC}")
				oSection1:Cell("D12_DOC"):Disable()
			EndIf
			oSection1:Cell("D12_CARGA"):Disable()
		Else
			cSeekQry := (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_DOC
			bSeekQry := &("{|| cSeekQry == (cAliasNew)->D12_MAPSEP+(cAliasNew)->D12_DOC}")
			oSection1:Cell("D12_CODREC"):Disable()
			oSection1:Cell("D12_CARGA"):Disable()
		EndIf

		oSection1:PrintLine()
		
		oSection2:Cell("TRACO"):HideHeader()
		cLocaliz := ""
		oSection2:Init()
		While !oReport:Cancel() .And. (cAliasNew)->(!Eof()) .And. Eval(bSeekQry)

			If !Empty(cLocaliz) .And. cLocaliz <> (cAliasNew)->D12_ENDORI
				oReport:SkipLine()
			EndIf
			cLocaliz := (cAliasNew)->D12_ENDORI

			If cCFGOri <> (cAliasNew)->BE_CFGORI // Verifica se o codigo mudou
				cCFGOri := (cAliasNew)->BE_CFGORI // Atualiza flag
				cPicCFG := DLXPicEnd(cCFGOri) // Atualiza Picture
				oSection2:Cell("D12_ENDORI"):SetPicture(cPicCFG)
			EndIf
			If cCFGDes <> (cAliasNew)->BE_CFGDES // Verifica se o codigo mudou
				cCFGDes := (cAliasNew)->BE_CFGDES // Atualiza flag
				cPicCFG := DLXPicEnd(cCFGDes) // Atualiza Picture
				oSection2:Cell("D12_ENDDES"):SetPicture(cPicCFG)
			EndIf

			oSection2:PrintLine()

			If WmsX112118("WMSR311","18")

				oSection3:Cell("D12_QTDMOV"):SetPicture(cPic1UM+' '+(cAliasNew)->B1_UM)
				oSection3:Cell("D12_QTDMO2"):SetPicture(cPic2UM+' '+(cAliasNew)->B1_SEGUM)
				oSection3:Cell("CUNIT"):HideHeader()

				oSection3:Init()

				If mv_par18 == 3
					aQtdUni := WmsQtdUni((cAliasNew)->D12_PRODUT,(cAliasNew)->D12_LOCORI,(cAliasNew)->BE_ESTORI,(cAliasNew)->D12_QTDMOV)
					oSection3:Cell("D12_QTDMOV"):SetValue(aQtdUni[3,1])
					oSection3:Cell("D12_QTDMO2"):SetValue(aQtdUni[2,1])
					oSection3:Cell("NUMI"):SetValue(aQtdUni[1,1])
					oSection3:Cell("CUNIT"):SetValue(aQtdUni[1,2])
				ElseIf mv_par18 == 4 .And. WmsX312118("D12","D12_UNIDES",.T.)
					W381DesUni((cAliasNew)->D12_LOCORI,(cAliasNew)->D12_ENDORI,(cAliasNew)->D12_PRODUT,@cCodUni,@cDesUni,.F.)
					oSection3:Cell("CUNIT"):SetValue(cDesUni)
				EndIf

				oSection3:PrintLine()
				oSection3:Finish()

			EndIf
			
			If mv_par01 == 1
				D12->(DbGoTo((cAliasNew)->RECNOD12))
				RecLock('D12', .F.)
				D12->D12_MAPSEP := cMapa
				D12->(MsUnlock())
			EndIf
			oReport:IncMeter()
			(cAliasNew)->(dbSkip())
		EndDo
		oSection2:Finish()
		oSection1:Finish()
		oReport:EndPage()
	EndDo
Return( Nil )
