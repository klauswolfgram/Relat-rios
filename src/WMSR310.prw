/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'  
#Include 'WmsR310.ch'


//----------------------------------------------------------
/*/{Protheus.doc} WmsR310
Romaneio de Separação

@author  Flavio Luiz Vicco
@version	P11
@since   13/10/2006
/*/
//----------------------------------------------------------
User Function WmsR310(lPerg,aMVPar)
Local oReport
Private nIndSDB1 := 0
Default lPerg := .T.
Default aMVPar := {}

	If SuperGetMv("MV_WMSNEW",.F.,.F.)
		Return WMSR311(lPerg,aMVPar)
	EndIf	
	
	If !DlgV001Six(@nIndSDB1)
		Return( Nil )
	EndIf
	// Interface de impressao
	oReport:= ReportDef(lPerg,aMVPar)
	oReport:PrintDialog()
Return( Nil )
//----------------------------------------------------------
// Definições do relatório
//----------------------------------------------------------
Static Function ReportDef(lPerg,aMVPar)
Local cAliasNew := "SDB"
Local cTitle    := OemToAnsi(STR0004) // Monitor de Servicos
Local aQtdUni	  := {}
Local oReport 
Local oSection1
Local oSection2
Local oSection3
	dbSelectArea(cAliasNew)
	dbSetOrder(1)
	cAliasNew := GetNextAlias()
	// Criacao do componente de impressao
	oReport := TReport():New("WMSR310",cTitle,"WMR310",{|oReport| ReportPrint(oReport,cAliasNew)},STR0004) // Monitor de Servicos
	//--------------------------------------------------------------------
	//Variaveis utilizadas para parametros
	//--------------------------------------------------------------------
	// mv_par01  //  Servico   De  ?
	// mv_par02  //            Ate ?
	// mv_par03  //  Tarefa    De  ?
	// mv_par02  //            Ate ?
	// mv_par03  //  Documento De  ?
	// mv_par02  //            Ate ?
	// mv_par03  //  Carga     De  ?
	// mv_par02  //            Ate ?
	// mv_par09  //  Status        ?  Finalizado / Interrompido /
	//                                Em Execucao / Nao Executado / Todos
	// mv_par10  //  Quantidade    ?  1a.UM / 2a.UM / U.M.I. / Nao Imprime
	//--------------------------------------------------------------------
	If lPerg
		Pergunte(oReport:uParam,.F.)
	Else
		mv_par01 := aMVPar[1]
		mv_par02 := aMVPar[2]
		mv_par03 := aMVPar[3]
		mv_par04 := aMVPar[4]
		mv_par05 := aMVPar[5]
		mv_par06 := aMVPar[6]
		mv_par07 := aMVPar[7]
		mv_par08 := aMVPar[8]
		mv_par09 := aMVPar[9]
		mv_par10 := aMVPar[10]
	EndIf	
	// Criacao da secao utilizada pelo relatorio
	oSection1:= TRSection():New(oReport,STR0028,{"SDB"},/*aOrdem*/) // Movimentos por endereco - Documento
	oSection1:SetHeaderPage(.F.)
	oSection1:SetLineStyle()
	TRCell():New(oSection1,"DB_CARGA",	"SDB")
	TRCell():New(oSection1,"DB_DOC",	"SDB")
	// Criacao da secao utilizada pelo relatorio
	oSection2:= TRSection():New(oSection1,STR0029,{"SDB"},/*aOrdem*/) // Movimentos por endereco - Atividades
	oSection2:SetHeaderPage()
	TRCell():New(oSection2,"DATIVID",		"",STR0031,,30,,{||TABELA("L3",(cAliasNew)->DB_ATIVID,.F.)}) // Movimento
	TRCell():New(oSection2,"DB_LOCALIZ",	"SDB")
	TRCell():New(oSection2,"DB_PRODUTO",	"SDB")
	TRCell():New(oSection2,"DB_LOTECTL",	"SDB")
	TRCell():New(oSection2,"DB_ENDDES",		"SDB")
	TRCell():New(oSection2,"DB_STATUS",		"SDB",,,12,,{||Substr(x3FieldToCbox("DB_STATUS",(cAliasNew)->DB_STATUS),4)})
	TRCell():New(oSection2,"TRACO",	        "",STR0032,,23,,{||"_______________________"}) // Traco
	// Criacao da secao utilizada pelo relatorio
	oSection3:= TRSection():New(oSection2,STR0030,{"SDB"},/*aOrdem*/) // Movimentos por endereco - Quantidades
	oSection3:SetLineStyle()
	TRCell():New(oSection3,"DB_QUANT",		"SDB",STR0012) // Qtde 1a.U.M.
	TRCell():New(oSection3,"LACUNA1",		"",   STR0033+" 1",,12,,{||"[__________]"}) // Lacuna
	TRCell():New(oSection3,"B1_UM",			"SB1")
	TRCell():New(oSection3,"DB_QTSEGUM",	"SDB")
	TRCell():New(oSection3,"LACUNA2",		"",   STR0033+" 2",,12,,{||"[__________]"}) // Lacuna
	TRCell():New(oSection3,"B1_SEGUM",		"SB1")
	TRCell():New(oSection3,"NUMI", 			"",   STR0034) // Qtd Unitiz
	TRCell():New(oSection3,"LACUNA3",		"",   STR0033+" 3",,12,,{||"[__________]"}) // Lacuna
	TRCell():New(oSection3,"CUNIT",			"",   STR0035,,15) // Unitizador
Return( oReport )
//----------------------------------------------------------
// Impressão do relatório
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1) 
Local lWmsACar  := (SuperGetMV('MV_WMSACAR', .F., 'S')=='S')
Local cQuebra   := ""
Local cLocaliz  := ""
Local cSelect	  := ""
Local cWhere	  := ""
Local cOrder	  := ""
	oSection2:Cell("TRACO"):HideHeader()
	oSection3:Cell("LACUNA1"):HideHeader()
	oSection3:Cell("B1_UM"):HideHeader()
	oSection3:Cell("DB_QTSEGUM"):HideHeader()
	oSection3:Cell("LACUNA2"):HideHeader()
	oSection3:Cell("B1_SEGUM"):HideHeader()
	oSection3:Cell("NUMI"):HideHeader()
	oSection3:Cell("LACUNA3"):HideHeader()
	oSection3:Cell("CUNIT"):HideHeader()
	
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	// Query do relatório da secao 1
	oSection1:BeginQuery()	

	cSelect := "%, "+SqlOrder(SDB->(IndexKey(nIndSDB1)))+" %"

	cWhere := "%"
	If	mv_par09 <> 5
		cWhere += " DB_STATUS      = '"+AllTrim(Str(mv_par09))+"' AND "
	EndIf
	cWhere += "%"

	cOrder := "% "+SqlOrder(SDB->(IndexKey(nIndSDB1)))+" %"

	BeginSql Alias cAliasNew
		SELECT DB_TAREFA, SX51.X5_DESCRI D_TAREFA , DB_ATIVID,
	           SX52.X5_DESCRI D_ATIVIDADE, DB_LOCAL, DB_LOCALIZ, DB_ENDDES, DB_PRODUTO, DB_QUANT,
	           DB_LOTECTL, DB_ESTORNO, DB_ESTFIS, B1_UM, B1_SEGUM
	           %Exp:cSelect%
		FROM %table:SDB% SDB
		JOIN %table:SX5% SX51 ON SX51.X5_FILIAL = %xFilial:SX5% AND SX51.X5_TABELA = 'L2' AND SX51.X5_CHAVE = SDB.DB_TAREFA AND SX51.%NotDel%
		JOIN %table:SX5% SX52 ON SX52.X5_FILIAL = %xFilial:SX5% AND SX52.X5_TABELA = 'L3' AND SX52.X5_CHAVE = SDB.DB_ATIVID AND SX52.%NotDel%
		JOIN %table:SB1% SB1  ON SB1.B1_FILIAL  = %xFilial:SB1% AND SB1.B1_COD = SDB.DB_PRODUTO AND SB1.%NotDel%
		WHERE
		DB_FILIAL         = %xFilial:SDB% AND
		DB_ESTORNO       <> 'S' AND
		DB_ATUEST         = 'N' AND
		DB_SERVIC BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
		DB_TAREFA BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% AND
		DB_DOC    BETWEEN %Exp:mv_par05% AND %Exp:mv_par06% AND
		DB_CARGA  BETWEEN %Exp:mv_par07% AND %Exp:mv_par08% AND
		%Exp:cWhere%
		SDB.%NotDel%
		ORDER BY %Exp:cOrder%
	EndSql 
	// Metodo EndQuery ( Classe TRSection )
	// Prepara o relatório para executar o Embedded SQL.
	// ExpA1 : Array com os parametros do tipo Range
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)
	SB1->(dbSetOrder(1))
	SB1->(MsSeek(xFilial("SB1")+(cAliasNew)->DB_PRODUTO))
	If	mv_par10 == 1
		oSection3:Cell("DB_QTSEGUM"):Disable()
		oSection3:Cell("LACUNA1"):Disable()
		oSection3:Cell("B1_SEGUM"):Disable()
		oSection3:Cell("LACUNA2"):Disable()
		oSection3:Cell("NUMI"):Disable()
		oSection3:Cell("LACUNA3"):Disable()
		oSection3:Cell("CUNIT"):Disable()
	ElseIf mv_par10 == 2
		oSection3:Cell("DB_QTSEGUM"):SetTitle(STR0013) // Qtde 2a.U.M.
		oSection3:Cell("DB_QUANT"):Disable()
		oSection3:Cell("LACUNA1"):Disable()
		oSection3:Cell("B1_UM"):Disable()
		oSection3:Cell("B1_UM"):Disable()  
		oSection3:Cell("LACUNA2"):Disable()
		oSection3:Cell("NUMI"):Disable()
		oSection3:Cell("LACUNA3"):Disable()
		oSection3:Cell("CUNIT"):Disable()
	ElseIf mv_par10 == 3
		oSection3:Cell("DB_QUANT"):SetTitle(STR0014) // Qtde U.M.I.
		oSection3:Cell("LACUNA1"):Disable()
		oSection3:Cell("LACUNA2"):Disable()
		oSection3:Cell("LACUNA3"):Disable()
	ElseIf mv_par10 == 4
		oSection3:Cell("DB_QUANT"):SetTitle(STR0015) // Qtde
		oSection3:Cell("DB_QUANT"):Disable()
		oSection3:Cell("DB_QTSEGUM"):Disable()
		oSection3:Cell("NUMI"):Disable()
	EndIf
	oSection1:SetParentQuery()
	oSection2:SetParentQuery()
	oSection3:SetParentQuery()
	oReport:SetTitle(STR0009+Upper(Tabela('L2',(cAliasNew)->DB_TAREFA,.F.))) // SERVICO DE
	oReport:SetMeter(SDB->(LastRec()))
	dbSelectArea(cAliasNew)
	oSection1:Init()
	oSection2:Init()
	oSection3:Init()
	While !oReport:Cancel() .And. !(cAliasNew)->(Eof())
		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
		oSection1:Cell("DB_CARGA"):Enable()
		oSection1:Cell("DB_DOC"):Enable()
		lCarga := !Empty((cAliasNew)->DB_CARGA)
		If	lCarga
			If	lWmsACar
				oSection1:Cell("DB_DOC"):Disable()
			EndIf
		Else
			oSection1:Cell("DB_CARGA"):Disable()
		EndIf
		If	cQuebra <> Iif(lCarga,(cAliasNew)->DB_CARGA,(cAliasNew)->DB_DOC)+If(lWmsACar,'',(cAliasNew)->DB_DOC)+(cAliasNew)->DB_TAREFA
			cQuebra := Iif(lCarga,(cAliasNew)->DB_CARGA,(cAliasNew)->DB_DOC)+If(lWmsACar,'',(cAliasNew)->DB_DOC)+(cAliasNew)->DB_TAREFA
			oReport:SetTitle(STR0009+Upper(Tabela('L2',(cAliasNew)->DB_TAREFA,.F.))) // SERVICO DE
			oReport:EndPage()
			oSection1:PrintLine()
		EndIf
		If	cLocaliz <> (cAliasNew)->DB_LOCALIZ
			cLocaliz := (cAliasNew)->DB_LOCALIZ
			oReport:SkipLine()
		EndIf
		If	mv_par10 == 3
			aQtdUni:=WmsQtdUni((cAliasNew)->DB_PRODUTO,(cAliasNew)->DB_LOCAL,(cAliasNew)->DB_ESTFIS,(cAliasNew)->DB_QUANT)
			oSection3:Cell("DB_QTSEGUM"):SetValue(aQtdUni[3,1])
			oSection3:Cell("DB_QUANT"):SetValue(aQtdUni[2,1])
			oSection3:Cell("NUMI"):SetValue(aQtdUni[1,1])
			oSection3:Cell("CUNIT"):SetValue(aQtdUni[1,2])
		ElseIf mv_par10 == 4
			aQtdUni:=WmsQtdUni((cAliasNew)->DB_PRODUTO,(cAliasNew)->DB_LOCAL,(cAliasNew)->DB_ESTFIS,(cAliasNew)->DB_QUANT)
			oSection3:Cell("CUNIT"):SetValue(aQtdUni[1,2])
		EndIf
		oSection2:PrintLine()
		oSection3:PrintLine()
		(cAliasNew)->(dbSkip())
	EndDo
	oSection1:Finish()
Return( Nil )