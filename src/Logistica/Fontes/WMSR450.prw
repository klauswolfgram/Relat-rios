/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "RWMAKE.CH"
#INCLUDE "WMSR450.CH"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} novo
Montagem da tela de processamento

@author    Tiago Filipe
@version   P12
@since     22/08/2013
/*/
//------------------------------------------------------------------------------------------
User Function WMSR450()
Local oReport := Nil
Local lWmsNew := SuperGetMv("MV_WMSNEW",.F.,.F.)

Private aColsSX3  := {}
Private cAliasIni := ""
Private lAutom    := .F.

	If lWmsNew
		Return WMSR451()
	EndIf

	CriaTemp()
	
	oReport:= ReportDef()
	oReport:PrintDialog()

	(cAliasIni)->(dbCloseArea())

Return

//------------------------------------------------------------
// CriaTemp
// Cria tabela temporaria
//------------------------------------------------------------
Static Function CriaTemp()
Local aCamposIni := {}
	// {Titulo, Picture, Tamanho, Decimal}
	buscarSX3('DB_LOCAL'  ,,aColsSX3); AAdd(aCamposIni,{"ARMAZE",'C',aColsSX3[3],aColsSX3[4]})
	buscarSX3('DB_PRODUTO',,aColsSX3); AAdd(aCamposIni,{"PRODUT",'C',aColsSX3[3],aColsSX3[4]})
	                                   AAdd(aCamposIni,{"DESCRI",'C',30         ,0          })
	buscarSX3('DB_LOCALIZ',,aColsSX3); AAdd(aCamposIni,{"LOCALI",'C',aColsSX3[3],aColsSX3[4]})
	buscarSX3('DB_QUANT'  ,,aColsSX3); AAdd(aCamposIni,{"QTDENT",'N',aColsSX3[3],aColsSX3[4]})
	                                   AAdd(aCamposIni,{"MOVENT",'N',aColsSX3[3],aColsSX3[4]})
	                                   AAdd(aCamposIni,{"QTDSAI",'N',aColsSX3[3],aColsSX3[4]})
	                                   AAdd(aCamposIni,{"MOVSAI",'N',aColsSX3[3],aColsSX3[4]})
	cAliasIni := criaTabTmp(aCamposIni,{'ARMAZE+PRODUT+LOCALI','ARMAZE+PRODUT+DESCEND(QTDENT)','ARMAZE+PRODUT+DESCEND(MOVENT)','ARMAZE+PRODUT+DESCEND(QTDSAI)','ARMAZE+PRODUT+DESCEND(MOVSAI)','LOCALI+DESCEND(QTDENT)','LOCALI+DESCEND(MOVENT)','LOCALI+DESCEND(QTDSAI)','LOCALI+DESCEND(MOVSAI)'})
Return

//------------------------------------------------------------
// CarregaTemp
// Carrega tabela temporaria
//------------------------------------------------------------
Static Function CarregaTemp()
Local cAliasQry := GetNextAlias()
Local cProd     := ''
Local cArm      := ''
Local nTotEnt   := 0
Local nTotEntM  := 0
Local nTotSai   := 0
Local nTotSaiM  := 0

	cQuery := "SELECT DB_LOCAL    ARMAZE,"
	cQuery +=       " DB_PRODUTO  PRODUT,"
	cQuery +=       " DB_LOCALIZ  LOCALI,"
	cQuery +=       " SUM(QTDENT) QTDENT,"
	cQuery +=       " SUM(MOVENT) MOVENT,"
	cQuery +=       " SUM(QTDSAI) QTDSAI,"
	cQuery +=       " SUM(MOVSAI) MOVSAI"
	cQuery += " FROM (SELECT DB_LOCAL,"
	cQuery +=              " DB_PRODUTO,"
	cQuery +=              " DB_LOCALIZ,"
	cQuery +=              " SUM(DB_QUANT)     QTDENT,"
	cQuery +=              " COUNT(R_E_C_N_O_) MOVENT,"
	cQuery +=              " 0                 QTDSAI,"
	cQuery +=              " 0                 MOVSAI"
	cQuery +=         " FROM "+RetSqlName("SDB")
	cQuery +=        " WHERE DB_FILIAL  = '"+xFilial("SDB")+"'"
	cQuery +=          " AND DB_TM      <= '500'"
	cQuery +=          " AND DB_PRODUTO >= '"+MV_PAR01+"'"
	cQuery +=          " AND DB_PRODUTO <= '"+MV_PAR02+"'"
	cQuery +=          " AND DB_LOCALIZ >= '"+MV_PAR03+"'"
	cQuery +=          " AND DB_LOCALIZ <= '"+MV_PAR04+"'"
	cQuery +=          " AND DB_LOCAL   >= '"+MV_PAR05+"'"
	cQuery +=          " AND DB_LOCAL   <= '"+MV_PAR06+"'"
	cQuery +=          " AND DB_ESTFIS  >= '"+MV_PAR07+"'"
	cQuery +=          " AND DB_ESTFIS  <= '"+MV_PAR08+"'"
	cQuery +=          " AND DB_DATA    >= '"+DtoS(MV_PAR09)+"'"
	cQuery +=          " AND DB_DATA    <= '"+DtoS(MV_PAR10)+"'"
	cQuery +=          " AND DB_ATUEST  = 'S'"
	cQuery +=          " AND DB_ESTORNO = ' '"
	cQuery +=          " AND D_E_L_E_T_ = ' '"
	cQuery +=        " GROUP BY DB_LOCAL,DB_PRODUTO,DB_LOCALIZ"
	cQuery +=        " UNION ALL "
	cQuery +=        "SELECT DB_LOCAL,"
	cQuery +=              " DB_PRODUTO,"
	cQuery +=              " DB_LOCALIZ,"
	cQuery +=              " 0                 QTDENT,"
	cQuery +=              " 0                 MOVENT,"
	cQuery +=              " SUM(DB_QUANT)     QTDSAI ,"
	cQuery +=              " COUNT(R_E_C_N_O_) MOVSAI"
	cQuery +=         " FROM "+RetSqlName("SDB")
	cQuery +=        " WHERE DB_FILIAL  = '"+xFilial("SDB")+"'"
	cQuery +=          " AND DB_TM      > '500'"
	cQuery +=          " AND DB_PRODUTO >= '"+MV_PAR01+"'"
	cQuery +=          " AND DB_PRODUTO <= '"+MV_PAR02+"'"
	cQuery +=          " AND DB_LOCALIZ >= '"+MV_PAR03+"'"
	cQuery +=          " AND DB_LOCALIZ <= '"+MV_PAR04+"'"
	cQuery +=          " AND DB_LOCAL   >= '"+MV_PAR05+"'"
	cQuery +=          " AND DB_LOCAL   <= '"+MV_PAR06+"'"
	cQuery +=          " AND DB_ESTFIS  >= '"+MV_PAR07+"'"
	cQuery +=          " AND DB_ESTFIS  <= '"+MV_PAR08+"'"
	cQuery +=          " AND DB_DATA    >= '"+DtoS(MV_PAR09)+"'"
	cQuery +=          " AND DB_DATA    <= '"+DtoS(MV_PAR10)+"'"
	cQuery +=          " AND DB_ATUEST  = 'S'"
	cQuery +=          " AND DB_ESTORNO = ' '"
	cQuery +=          " AND D_E_L_E_T_ = ' '"
	cQuery +=        " GROUP BY DB_LOCAL,DB_PRODUTO,DB_LOCALIZ"
	cQuery +=       ") GIRO"
	cQuery += " GROUP BY DB_LOCAL,DB_PRODUTO,DB_LOCALIZ"
	cQuery += " ORDER BY DB_LOCAL,DB_PRODUTO,DB_LOCALIZ"
	cQuery := ChangeQuery(cQuery)
	DBUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)

	While !(cAliasQry)->(Eof())
		cArm     := (cAliasQry)->ARMAZE
		cProd    := (cAliasQry)->PRODUT
		nTotEnt  := 0
		nTotEntM := 0
		nTotSai  := 0
		nTotSaiM := 0

		// loop para gravar registro de cada PRODUT
		While !(cAliasQry)->(Eof()) .And. cArm+cProd == (cAliasQry)->ARMAZE+(cAliasQry)->PRODUT

			RecLock(cAliasIni,.T.)
			(cAliasIni)->ARMAZE := (cAliasQry)->ARMAZE
			(cAliasIni)->PRODUT := (cAliasQry)->PRODUT
			(cAliasIni)->DESCRI := Posicione("SB1",1,xFilial("SB1")+cProd,"B1_DESC")
			(cAliasIni)->LOCALI := (cAliasQry)->LOCALI
			(cAliasIni)->QTDENT := (cAliasQry)->QTDENT
			(cAliasIni)->MOVENT := (cAliasQry)->MOVENT
			(cAliasIni)->QTDSAI := (cAliasQry)->QTDSAI
			(cAliasIni)->MOVSAI := (cAliasQry)->MOVSAI
			(cAliasIni)->(MsUnlock())

			nTotEnt  += (cAliasQry)->QTDENT
			nTotEntM += (cAliasQry)->MOVENT
			nTotSai  += (cAliasQry)->QTDSAI
			nTotSaiM += (cAliasQry)->MOVSAI

			(cAliasQry)->(DBSkip())

		Enddo

		// grava total do PRODUT
		RecLock(cAliasIni,.T.)
		(cAliasIni)->ARMAZE := cARM
		(cAliasIni)->PRODUT := cPROD
		(cAliasIni)->LOCALI := "TOTAL"
		(cAliasIni)->QTDENT := nTotEnt
		(cAliasIni)->MOVENT := nTotEntM
		(cAliasIni)->QTDSAI := nTotSai
		(cAliasIni)->MOVSAI := nTotSaiM
		(cAliasIni)->(MsUnlock())

	Enddo
	(cAliasQry)->(DBCloseArea())

Return

//------------------------------------------------------------
//  Definições do relatório
//------------------------------------------------------------
Static Function ReportDef()
Local cTitle    := OemToAnsi(STR0001) // Giro do PRODUT
Local oReport   := Nil
Local oSection1 := Nil

	If lAutom
		CriaTemp()
	EndIf
	// Criacao do componente de impressao
	oReport := TReport():New('WMSR450',cTitle,'WMSR450',{|oReport| ReportPrint(oReport)},STR0001) // Giro do PRODUT

	Pergunte(oReport:uParam,.F.)

	// Criacao da secao utilizada pelo relatorio
	oSection1:= TRSection():New(oReport,STR0010,{cAliasIni},/*aOrdem*/) // Relatorio Giro do PRODUT

	TRCell():New(oSection1,"ARMAZE",cAliasIni,STR0003) // Armazem
	TRCell():New(oSection1,"PRODUT",cAliasIni,STR0004) // Produto
	TRCell():New(oSection1,"DESCRI",cAliasIni,STR0005) // Descrição
	TRCell():New(oSection1,"LOCALI",cAliasIni,STR0006) // Endereço
	TRCell():New(oSection1,"QTDENT",cAliasIni,STR0007) // Entrada
	TRCell():New(oSection1,"MOVENT",cAliasIni,STR0008) // Movimentos
	TRCell():New(oSection1,"QTDSAI",cAliasIni,STR0009) // Saida
	TRCell():New(oSection1,"MOVSAI",cAliasIni,STR0008) // Movimentos

Return oReport

//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local nOrd      := 1
Local nOrd2     := 1

	CarregaTemp()

	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())

	If MV_PAR11 == 1
		nOrd  := 2
		nOrd2 := 6
	ElseIf MV_PAR11 == 2
		nOrd  := 3
		nOrd2 := 7
	ElseIf MV_PAR11 == 3
		nOrd  := 4
		nOrd2 := 8
	ElseIf MV_PAR11 == 4
		nOrd  := 5
		nOrd2 := 9
	EndIf

	oReport:SetMeter((cAliasIni)->(RecCount()))

	(cAliasIni)->(dbSetOrder(nOrd2))
	(cAliasIni)->(dbSeek("TOTAL"))

	oSection1:Init()
	oSection1:Cell("ARMAZE"):SetSize(10)
	oSection1:Cell("PRODUT"):SetSize(15)
	oSection1:Cell("DESCRI"):SetSize(30)
	oSection1:Cell("LOCALI"):SetSize(10)
	oSection1:Cell("QTDENT"):SetSize(12)
	oSection1:Cell("MOVENT"):SetSize(10)
	oSection1:Cell("QTDSAI"):SetSize(12)
	oSection1:Cell("MOVSAI"):SetSize(10)

	While !oReport:Cancel() .And. !(cAliasIni)->(Eof()) .And. AllTrim((cAliasIni)->LOCALI) == "TOTAL"
		cArm   := (cAliasIni)->ARMAZE
		cProd  := (cAliasIni)->PRODUT
		nRecno := (cAliasIni)->(Recno())
		nAux   := 0

		oReport:IncMeter()

		If oReport:Cancel()
			Exit
		EndIf

		(cAliasIni)->(dbSetOrder(nOrd))
		(cAliasIni)->(dbSeek(cArm+cProd))

		While (cAliasIni)->ARMAZE+(cAliasIni)->PRODUT == cArm+cProd

			If AllTrim((cAliasIni)->LOCALI) <> "TOTAL"

				If nAux == 0
					oSection1:Cell("ARMAZE"):Show()
					oSection1:Cell("PRODUT"):Show()
					oSection1:Cell("DESCRI"):Show()
					oSection1:Cell("LOCALI"):Show()
					oSection1:Cell("QTDENT"):Show()
					oSection1:Cell("QTDENT"):SetAlign("LEFT")
					oSection1:Cell("MOVENT"):Show()
					oSection1:Cell("MOVENT"):SetAlign("LEFT")
					oSection1:Cell("QTDSAI"):Show()
					oSection1:Cell("QTDSAI"):SetAlign("LEFT")
					oSection1:Cell("MOVSAI"):Show()
					oSection1:Cell("MOVSAI"):SetAlign("LEFT")
					oSection1:PrintLine()
					nAux := 1
					(cAliasIni)->(dbSkip())
					Loop
				Endif

				oSection1:Cell("ARMAZE"):Hide()
				oSection1:Cell("PRODUT"):Hide()
				oSection1:Cell("DESCRI"):Hide()
				oSection1:Cell("LOCALI"):Show()
				oSection1:Cell("QTDENT"):Show()
				oSection1:Cell("MOVENT"):Show()
				oSection1:Cell("QTDSAI"):Show()
				oSection1:Cell("MOVSAI"):Show()
				oSection1:PrintLine()

			EndIf

			(cAliasIni)->(dbSkip())

		EndDo

		nAux := 0

		// imprime total
		(cAliasIni)->(dbSetOrder(nOrd2))
		(cAliasIni)->(dbGoTo(nRecno))

		oSection1:Cell("ARMAZE"):Hide()
		oSection1:Cell("PRODUT"):Hide()
		oSection1:Cell("DESCRI"):Hide()
		oSection1:Cell("LOCALI"):Hide()
		oSection1:Cell("QTDENT"):Show()
		oSection1:Cell("MOVENT"):Show()
		oSection1:Cell("QTDSAI"):Show()
		oSection1:Cell("MOVSAI"):Show()

		oReport:PrintText(STR0002) // Total do Poduto
		oReport:FatLine()
		oSection1:PrintLine()
		oReport:SkipLine()

		(cAliasIni)->(dbSkip())

	EndDo

	oSection1:Finish()

Return
