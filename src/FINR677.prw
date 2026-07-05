/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"
#Include "Report.ch"
#Include "FinR677.ch"

/*/{Protheus.doc} FINR677
Relatório de Prestação de Contas.

@author     Lucas de Oliveira
@type       function
@since      01/11/13
/*/
User Function FINR677()

	Local oReport As Object

	If !(IsInCallStack("FINA677"))
		Help("  ",1,"FINR677",,STR0027,1,1) // # A execução desse relatório deve ser somente através da rotina FINA677 (Prestação de Contas).
		Return
	Endif

	oReport:= ReportDef()
	oReport:PrintDialog()

Return Nil

/*/{Protheus.doc} ReportDef
Definição de layout do relatório.

@author     Lucas de Oliveira
@type       function
@since      01/11/13
/*/
Static Function ReportDef() As Object

	Local cReport	As Character
	Local cTitulo	As Character
	Local cDescri	As Character
	Local cAliasPC	As Character
	Local cMoeda1	As Character
	Local cMoeda2	As Character
	Local cMoeda3	As Character
	Local oReport	As Object
	Local oFLF		As Object
	Local oFLE		As Object
	Local oResM1	As Object
	Local oResM2	As Object
	Local oResM3	As Object
	Local nTtlAdia1	As Numeric
	Local nTtlDesp1	As Numeric
	Local nTtlReem1	As Numeric
	Local nTtlAdia2	As Numeric
	Local nTtlDesp2	As Numeric
	Local nTtlReem2	As Numeric
	Local nTtlAdia3	As Numeric
	Local nTtlDesp3	As Numeric
	Local nTtlReem3	As Numeric

	cReport		:= "FINR677"
	cTitulo		:=  STR0001 //"Relatório de Prestação de Contas"
	cDescri		:= ""
	cAliasPC	:= GetNextAlias()
	cMoeda1		:= SuperGetMV("MV_MOEDA1",, STR0002)
	cMoeda2		:= SuperGetMV("MV_MOEDA2",, STR0003)
	cMoeda3		:= SuperGetMV("MV_MOEDA3",, STR0004)
	oReport		:= Nil
	oFLF		:= Nil
	oFLE		:= Nil
	oResM1		:= Nil
	oResM2		:= Nil
	oResM3		:= Nil
	nTtlAdia1	:= 0
	nTtlDesp1	:= 0
	nTtlReem1	:= 0
	nTtlAdia2	:= 0
	nTtlDesp2	:= 0
	nTtlReem2	:= 0
	nTtlAdia3	:= 0
	nTtlDesp3	:= 0
	nTtlReem3	:= 0

	DEFINE REPORT oReport NAME cReport TITLE cTitulo ACTION {|oReport| PrintReport(oReport, cAliasPC)} DESCRIPTION cDescri

	DEFINE SECTION oFLF OF oReport TABLES "FLF","SE2","SA1","SA2" TITLE STR0026//"Cabeçalho - Prestação de Contas" STR0026 Prestação de Contas

		oFLF:SetLineStyle()
		oFLF:SetCols(3) //"Quantidade de colunas"

		DEFINE CELL NAME "FLF_PRESTA"	OF oFLF ALIAS "FLF" SIZE TamSX3("FLF_PRESTA")[1]
		DEFINE CELL NAME "E2_VENCREA"	OF oFLF ALIAS "SE2" SIZE (TamSX3("E2_VENCREA")[1] + 2)
		DEFINE CELL NAME "FLF_CLIENT"	OF oFLF ALIAS "FLF" SIZE TamSX3("FLF_CLIENT")[1]
		DEFINE CELL NAME "FLF_LOJA"		OF oFLF ALIAS "FLF" SIZE TamSX3("FLF_LOJA")[1]
		DEFINE CELL NAME "A1_NOME"		OF oFLF ALIAS "SA1" SIZE TamSX3("A1_NOME")[1]
		DEFINE CELL NAME "FLF_CC"		OF oFLF ALIAS "FLF" SIZE TamSX3("FLF_CC")[1]
		DEFINE CELL NAME "FLF_PARTIC"	OF oFLF ALIAS "FLF" SIZE TamSX3("FLF_PARTIC")[1]
		DEFINE CELL NAME "A2_NOME"	 	OF oFLF ALIAS "SA2" SIZE TamSX3("A2_NOME")[1]
		DEFINE CELL NAME "A2_BANCO"		OF oFLF ALIAS "SA2" SIZE TamSX3("A2_BANCO")[1]
		DEFINE CELL NAME "A2_AGENCIA"	OF oFLF ALIAS "SA2" SIZE TamSX3("A2_AGENCIA")[1]
		DEFINE CELL NAME "A2_NUMCON"	OF oFLF ALIAS "SA2" SIZE TamSX3("A2_NUMCON")[1]
		DEFINE CELL NAME "FLF_FATCLI"	OF oFLF ALIAS "FLF" SIZE TamSX3("FLF_FATCLI")[1]
		DEFINE CELL NAME "FLF_FATEMP"	OF oFLF ALIAS "FLF" SIZE TamSX3("FLF_FATEMP")[1]
		DEFINE CELL NAME "FLF_DTINI"	OF oFLF ALIAS "FLF" SIZE (TamSX3("FLF_DTINI")[1] + 2)
		DEFINE CELL NAME "FLF_DTFIM"	OF oFLF ALIAS "FLF" SIZE (TamSX3("FLF_DTFIM")[1] + 2)
		DEFINE CELL NAME "FLF_OBCONF"	OF oFLF ALIAS "FLF" SIZE TamSX3("FLF_OBCONF")[1]

		oFLF:Cell('E2_VENCREA')	:SetCellBreak() // Quebra de linha
		oFLF:Cell('FLF_CC')		:SetCellBreak()
		oFLF:Cell('A2_NOME')	:SetCellBreak()
		oFLF:Cell('FLF_FATEMP')	:SetCellBreak()
		oFLF:Cell('FLF_DTFIM')	:SetCellBreak()
		oFLF:Cell('FLF_OBCONF')	:SetCellBreak()

		oFLF:OnPrintLine({|| nTtlAdia1 := (cAliasPC)->FLF_TADIA1,; // Guarda os valores antes da impressão para poder utilizar nos resumos
							nTtlDesp1 := (cAliasPC)->FLF_TDESP1,;
							nTtlReem1 := (cAliasPC)->FLF_TVLRE1,;
							nTtlAdia2 := (cAliasPC)->FLF_TADIA2,;
							nTtlDesp2 := (cAliasPC)->FLF_TDESP2,;
							nTtlReem2 := (cAliasPC)->FLF_TVLRE2,;
							nTtlAdia3 := (cAliasPC)->FLF_TADIA3,;
							nTtlDesp3 := (cAliasPC)->FLF_TDESP3,;
							nTtlReem3 := (cAliasPC)->FLF_TVLRE3})

		DEFINE SECTION oFLE OF oFLF TABLES "FLE","FLG" TITLE STR0026//"Itens da Prestação de Contas" STR0026 Prestação de Contas

			DEFINE CELL NAME "FLE_ITEM"		OF oFLE ALIAS "FLE" SIZE TamSX3("FLE_ITEM")[1]
			DEFINE CELL NAME "FLE_DATA"  	OF oFLE ALIAS "FLE" SIZE (TamSX3("FLE_DATA")[1] + 3)
			DEFINE CELL NAME "FLE_DESPES"  	OF oFLE ALIAS "FLE" SIZE TamSX3("FLE_DESPES")[1]
			DEFINE CELL NAME "FLG_DESCRI"  	OF oFLE ALIAS "FLG" SIZE (TamSX3("FLG_DESCRI")[1] * 0.6) //60%
			DEFINE CELL NAME "FLE_QUANT"  	OF oFLE ALIAS "FLE" SIZE TamSX3("FLE_QUANT")[1]
			DEFINE CELL NAME "FLE_DESCON"  	OF oFLE ALIAS "FLE" SIZE TamSX3("FLE_DESCON")[1] + 5
			DEFINE CELL NAME "FLE_DETDES"  	OF oFLE ALIAS "FLE" SIZE (TamSX3("FLE_DETDES")[1] * 0.4) //40%
			DEFINE CELL NAME "FLE_TOTAL"  	OF oFLE ALIAS "FLE" SIZE TamSX3("FLE_TOTAL")[1] + 5

			If cPaisLoc == "MEX"
				oReport:DisableOrientation()
				oReport:SetLandScape()

				DEFINE CELL NAME "FLE_UUID"  	OF oFLE ALIAS "FLE" SIZE 60
				DEFINE CELL NAME "FLE_RFC"  	OF oFLE ALIAS "FLE" SIZE 20
			EndIf

			oFLE:Cell("FLG_DESCRI"):lLineBreak := .T.
			oFLE:Cell("FLE_DETDES"):lLineBreak := .T.

		DEFINE SECTION oResM1 OF oReport TABLE "FLF" TITLE STR0022//"Resumo baseado na moeda local (1)"

			oResM1:SetCols(5) //"Quantidade de colunas"

			DEFINE CELL NAME "RESMOED1" 	OF oResM1 SIZE 20 TITLE "Resumo em " + cMoeda1
			DEFINE CELL NAME "FLF_TADIA1"	OF oResM1 SIZE 20 BLOCK {|| nTtlAdia1}					//"Total dos Adiantamentos"
			DEFINE CELL NAME "FLF_TDESP1"	OF oResM1 SIZE 20 BLOCK {|| nTtlDesp1}					//"Total dos Gastos"
			DEFINE CELL NAME "FLF_TVLRE1"	OF oResM1 SIZE 20 BLOCK {|| nTtlReem1}					//"Total do Reembolso"
			DEFINE CELL NAME "NAOREEMB" 	OF oResM1 SIZE 20 BLOCK {|| nTtlReem1 - nTtlAdia1 };	//"Total do Não Reembolso"
				TITLE  STR0005; //"Não Reembolsável"
				PICTURE PesqPict("FLF", "FLF_TADIA1", 20);
				HEADER ALIGN RIGHT

		DEFINE SECTION oResM2 OF oReport TABLE "FLF" TITLE STR0023//"Resumo baseado na moeda (2)"

			oResM2:SetCols(5) //"Quantidade de colunas"

			DEFINE CELL NAME "RESMOED2"		OF oResM2 SIZE 20 TITLE "Resumo em " + cMoeda2
			DEFINE CELL NAME "FLF_TADIA2"	OF oResM2 SIZE 20 BLOCK {|| nTtlAdia2}					//"Total dos Adiantamentos"
			DEFINE CELL NAME "FLF_TDESP2"	OF oResM2 SIZE 20 BLOCK {|| nTtlDesp2}					//"Total dos Gastos"
			DEFINE CELL NAME "FLF_TVLRE2"	OF oResM2 SIZE 20 BLOCK {|| nTtlReem2}					//"Total do Reembolso"
			DEFINE CELL NAME "DIFERENCA2"   OF oResM2 SIZE 20 BLOCK {|| nTtlAdia2 - nTtlReem2 };	//"Diferença"
				TITLE STR0006; //"Diferença"
				PICTURE PesqPict("FLF", "FLF_TADIA2", 20);
				HEADER ALIGN RIGHT

		DEFINE SECTION oResM3 OF oReport TABLES "FLF" TITLE STR0024//"Resumo baseado na moeda (3)"

			oResM3:SetCols(5) //"Quantidade de colunas"

			DEFINE CELL NAME "RESMOED3"		OF oResM3 SIZE 20 TITLE "Resumo em " + cMoeda3
			DEFINE CELL NAME "FLF_TADIA3"	OF oResM3 SIZE 20 BLOCK {|| nTtlAdia3}					//"Total dos Adiantamentos"
			DEFINE CELL NAME "FLF_TDESP3"	OF oResM3 SIZE 20 BLOCK {|| nTtlDesp3}					//"Total dos Gastos"
			DEFINE CELL NAME "FLF_TVLRE3"	OF oResM3 SIZE 20 BLOCK {|| nTtlReem3}					//"Total do Reembolso"
			DEFINE CELL NAME "DIFERENCA3"   OF oResM3 SIZE 20 BLOCK {|| nTtlAdia3 - nTtlReem3 };	//"Diferença"
				TITLE STR0007; //"Diferença"
				PICTURE PesqPict("FLF", "FLF_TADIA3", 20);
				HEADER ALIGN RIGHT

	oFLF:SetAutoSize()
	oResM1:SetAutoSize()
	oResM2:SetAutoSize()
	oResM3:SetAutoSize()

Return oReport

/*/{Protheus.doc} PrintReport
Rotina de Impressão de dados

@author     Lucas de Oliveira
@type       function
@since      01/11/13
/*/
Static Function PrintReport(oReport As Object, cAliasPC As Character)

	Local oFLF			As Object
	Local oFLE			As Object
	Local oResM1		As Object
	Local oResM2		As Object
	Local oResM3		As Object
	Local cFilialFLF	As Character
	Local cPresta		As Character
	Local cPartic		As Character
	Local cTipo			As Character

	oFLF		:= oReport:Section(1)
	oFLE		:= oReport:Section(1):Section(1)
	oResM1		:= oReport:Section(2)
	oResM2		:= oReport:Section(3)
	oResM3		:= oReport:Section(4)
	cFilialFLF	:= FLF->FLF_FILIAL
	cPresta		:= FLF->FLF_PRESTA
	cPartic		:= FLF->FLF_PARTIC
	cTipo		:= FLF->FLF_TIPO

	BEGIN REPORT QUERY oFLF
	If cPaisLoc == "MEX"
		BeginSql alias cAliasPC
			SELECT DISTINCT
				FLF_FILIAL,
				FLF_PRESTA,
				FLF_TIPO,
				FLF_CLIENT,
				FLF_LOJA,
				FLF_CC,
				FLF_PARTIC,
				FLF_FATCLI,
				FLF_FATEMP,
				FLF_DTINI,
				FLF_DTFIM,
				FLF_OBCONF,
				FLF_TDESP1,
				FLF_TDESP2,
				FLF_TDESP3,
				FLF_TVLRE1,
				FLF_TVLRE2,
				FLF_TVLRE3,
				FLF_TADIA1,
				FLF_TADIA2,
				FLF_TADIA3,
				FLE_FILIAL,
				FLE_PRESTA,
				FLE_TIPO,
				FLE_PARTIC,
				FLE_ITEM,
				FLE_DATA,
				FLE_DESPES,
				FLG_DESCRI,
				FLE_QUANT,
				FLE_DESCON,
				FLE_DETDES,
				FLE_TOTAL,
				FLE_VALREE,
				FLE_VALNRE,
				FLE_UUID,
				FLE_RFC,
				SE2.E2_VENCREA

			FROM %table:FLF% FLF

				INNER JOIN %table:FLE% FLE ON
				FLF_FILIAL	= FLE_FILIAL AND
				FLF_PRESTA	= FLE_PRESTA AND
				FLF_PARTIC	= FLE_PARTIC AND
				FLE.%notDel%

				LEFT JOIN %table:FLD% FLD ON
				FLF_PARTIC	= FLD_PARTIC

				LEFT JOIN %table:FLG% FLG ON
				FLG_FILIAL	= %Exp:xFilial("FLG")% 	AND
				FLG_CODIGO	= FLE_DESPES 			AND
				FLG.%notDel%

				LEFT JOIN %table:FO7% FO7  ON
				FO7_FILIAL	= FLF_FILIAL AND 
				FO7_TPVIAG  = FLF_TIPO	 AND 
				FO7_PRESTA  = FLF_PRESTA AND 
				FO7_PARTIC  = FLF_PARTIC AND 
				FO7.%notDel%

				LEFT JOIN %table:SE2% SE2  ON
				E2_FILIAL 	= %xFilial:SE2% AND 
				E2_PREFIXO	= FO7_PREFIX AND 
				E2_NUM		= FO7_TITULO AND 
				E2_PARCELA	= FO7_PARCEL AND 
				E2_TIPO		= FO7_TIPO 	 AND 
				E2_FORNECE	= FO7_CLIFOR AND 
				E2_LOJA		= FO7_LOJA	 AND 
				SE2.%notDel%

			WHERE
				FLF_FILIAL	= %Exp:cFilialFLF%	AND
				FLF_PRESTA	= %Exp:cPresta%		AND
				FLF_PARTIC	= %Exp:cPartic%		AND
				FLF_TIPO 	= %Exp:cTipo%		AND
				FLF.%notDel%
		EndSql
	Else
		BeginSql alias cAliasPC
			SELECT DISTINCT
				FLF_FILIAL,
				FLF_PRESTA,
				FLF_TIPO,
				FLF_CLIENT,
				FLF_LOJA,
				FLF_CC,
				FLF_PARTIC,
				FLF_FATCLI,
				FLF_FATEMP,
				FLF_DTINI,
				FLF_DTFIM,
				FLF_OBCONF,
				FLF_TDESP1,
				FLF_TDESP2,
				FLF_TDESP3,
				FLF_TVLRE1,
				FLF_TVLRE2,
				FLF_TVLRE3,
				FLF_TADIA1,
				FLF_TADIA2,
				FLF_TADIA3,
				FLE_FILIAL,
				FLE_PRESTA,
				FLE_TIPO,
				FLE_PARTIC,
				FLE_ITEM,
				FLE_DATA,
				FLE_DESPES,
				FLG_DESCRI,
				FLE_QUANT,
				FLE_DESCON,
				FLE_DETDES,
				FLE_TOTAL,
				FLE_VALREE,
				FLE_VALNRE,
				SE2.E2_VENCREA

			FROM %table:FLF% FLF

				INNER JOIN %table:FLE% FLE ON
				FLF_FILIAL	= FLE_FILIAL AND
				FLF_PRESTA	= FLE_PRESTA AND
				FLF_PARTIC	= FLE_PARTIC AND
				FLE.%notDel%

				LEFT JOIN %table:FLG% FLG ON
				FLG_FILIAL	= %Exp:xFilial("FLG")%	AND
				FLG_CODIGO	= FLE_DESPES 			AND
				FLG.%notDel%

				LEFT JOIN %table:FLD% FLD ON
				FLF_PARTIC	= FLD_PARTIC

				LEFT JOIN %table:FO7% FO7  ON
				FO7_FILIAL	= FLF_FILIAL AND 
				FO7_TPVIAG  = FLF_TIPO	 AND 
				FO7_PRESTA  = FLF_PRESTA AND 
				FO7_PARTIC  = FLF_PARTIC AND 
				FO7.%notDel%

				LEFT JOIN %table:SE2% SE2  ON
				E2_FILIAL 	= %xFilial:SE2% AND 
				E2_PREFIXO	= FO7_PREFIX AND 
				E2_NUM		= FO7_TITULO AND 
				E2_PARCELA	= FO7_PARCEL AND 
				E2_TIPO		= FO7_TIPO 	 AND 
				E2_FORNECE	= FO7_CLIFOR AND 
				E2_LOJA		= FO7_LOJA	 AND 
				SE2.%notDel%

			WHERE
				FLF_FILIAL	= %Exp:cFilialFLF%	AND
				FLF_PRESTA	= %Exp:cPresta%		AND
				FLF_PARTIC	= %Exp:cPartic%		AND
				FLF_TIPO 	= %Exp:cTipo%		AND
				FLF.%notDel%
		EndSql
	EndIf

	END REPORT QUERY oFLF

	oFLE:SetParentQuery()
	oFLE:SetParentFilter({|cParam| (cAliasPC)->(FLE_FILIAL + FLE_TIPO + FLE_PRESTA + FLE_PARTIC) == cParam},{|| (cAliasPC)->(FLF_FILIAL + FLF_TIPO + FLF_PRESTA + FLF_PARTIC)})

	TRPosition():New(oFLF, "SA1", 1, {|| xFilial("SA1") + (cAliasPC)->(FLF_CLIENT+FLF_LOJA)	}) //A1_FILIAL+A1_COD+A1_LOJA 
	TRPosition():New(oFLF, "RD0", 1, {|| xFilial("RD0") + (cAliasPC)->(FLF_PARTIC)			}) //A2_FILIAL+A2_COD+A2_LOJA 
	TRPosition():New(oFLF, "SA2", 1, {|| xFilial("SA2") + RD0->(RD0_FORNEC+RD0_LOJA)		}) //A2_FILIAL+A2_COD+A2_LOJA 

	oFLF:Print()

	oResM1:init()
	oResM1:PrintLine()
	oResM1:finish()

	oResM2:init()
	oResM2:PrintLine()
	oResM2:finish()

	oResM3:init()
	oResM3:PrintLine()
	oResM3:finish()

Return Nil
