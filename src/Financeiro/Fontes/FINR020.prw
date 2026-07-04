/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"
#INCLUDE "fwcommand.ch"
#INCLUDE "finr020.ch"
#DEFINE CRLF CHR(13)+CHR(10)

Static _oFINR0201
Static cArqTmp 		:= ""

/*/{Protheus.doc} FINR020
Movimento diário do caixa

@author Daniel Batori
@since 26/06/2006
@version 12.1.17
/*/
User Function FINR020()

	Local oReport

	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*/{Protheus.doc} ReportDef
Definição do layout do relatório

@author Daniel Batori
@since 26/06/2006
@version 12.1.17
/*/
Static Function ReportDef()

	Local oReport
	Local oSection1
	Local cAliasQry1	:= GetNextAlias()
	Local cPerg			:= "FIN020"  // Nome do grupo de perguntas
	Local cPictTit		:= ""
	Local aTam1			:= {}
	Local aTam2			:= {}
	Local aTam3			:= {}
	Local nTamOrdem		:= 0
	Local nTamDomic		:= 0

	Pergunte(cPerg, .F.)

	oReport := TReport():New("FINR020", STR0030, cPerg, {|oReport| ReportPrint(oReport, @cAliasQry1)}, STR0003)

	//GESTAO - inicio
	oReport:SetUseGC(.F.)
	//GESTAO - fim

	oReport:SetLandScape()

	cPictTit 	:= PesqPict("SE1","E1_VALOR")
	aTam1		:= TamSX3("E1_PREFIXO")
	aTam2		:= TamSX3("E1_NUM")
	aTam3		:= TamSX3("E1_PARCELA")
	nTamOrdem	:= aTam1[1] + aTam2[1] + aTam3[1] + 2
	aTam1		:= TamSX3("A1_MUN")
	aTam2		:= TamSX3("A1_EST")
	nTamDomic	:= aTam1[1] + aTam2[1] + 1

	oSection1 := TRSection():New(oReport, STR0030, {"SE1", "SA1"},)
	TRCell():New(oSection1, "N_ORDEM",		"SE1", STR0014,, nTamOrdem, .F.,			{||})  //definido por SetBlock
	TRCell():New(oSection1, "E1_EMISSAO",	"SE1", STR0015 + CRLF + STR0016,, 11, .F.,	{|| (cAliasQry1)->E1_EMISSAO})
	TRCell():New(oSection1, "E1_EMIS1",		"SE1", STR0015 + CRLF + STR0017,, 10, .F.,	{|| (cAliasQry1)->E1_EMIS1})
	TRCell():New(oSection1, "E1_VALOR",		"SE1", STR0018, cPictTit, 20, .F.,			{||},,, "CENTER")  //definido por SetBlock
	TRCell():New(oSection1, "A1_NOME",		"SA1", STR0019,,35, .F.,					{|| Pad(SA1->A1_NOME, 35)})
	TRCell():New(oSection1, "DOMICILIO",	"SE1", STR0020,, nTamDomic, .F.,			{|| Trim(SA1->A1_MUN) + "/" + SA1->A1_EST})
	TRCell():New(oSection1, "E1_VENCREA",	"SE1", STR0021 + CRLF + STR0022,, 11, .F.,	{|| (cAliasQry1)->E1_VENCREA})
	TRCell():New(oSection1, "E1_BAIXA",		"SE1", STR0021 + CRLF + STR0023,, 11, .F.,	{|| (cAliasQry1)->E1_BAIXA})
	TRCell():New(oSection1, "ANOTACOES",		 , STR0024 + CRLF + STR0025,, 43, .F.,	{|| Replicate("_", 43)})

Return oReport

/*/{Protheus.doc} ReportPrint
Função responsável pela impressão do relatório

@param oReport
@param cAliasQry1

@author Daniel Batori
@since 26/06/2006
@version 12.1.17
/*/
Static Function ReportPrint(oReport, cAliasQry1)

	Local oSection1		:= oReport:Section(1)
	Local cNumOrdem		:= ""
	Local lImpLivro		:= .F.
	Local lImpTermos	:= .F.
	Local nX			:= 0
	Local cString1		:= ""
	Local cString2		:= ""
	Local cArqAbert		:= ""
	Local cArqEncer		:= ""
	Local nPosSE1		:= 0
	Local nPosSA1		:= 0 
	//GESTAO - inicio
	Local cCNPJAtu		:= ""
	Local cInscAtu		:= ""
	Local aSelFil		:= {}
	Local aArea			:= {}
	Local aVariaveis	:= {}
	Local aVarParam		:= {}
	Local nRegSM0		:= 0
	Local nFil			:= 0

	nRegSM0 := SM0->(Recno())

	//Cria arquivo temporario
	aArea := GetArea()
	If MV_PAR06 == 1 .Or. MV_PAR06 == 2 //imprime livro
		MsgRun(STR0030, "", {|| aSelFil := U_F020GerTrb(@cAliasQry1)})
	Else
		U_F020AgrFil(@aSelFil)
	EndIf
	//GESTAO - fim

	oSection1:Cell("DOMICILIO"):SetBlock({|| Trim((cAliasQry1)->A1_MUN) + "/" + (cAliasQry1)->A1_EST})
	oSection1:Cell("A1_NOME"):SetBlock({|| Pad((cAliasQry1)->A1_NOME, 40)})

	Do Case
		Case MV_PAR06 == 1  // Imprime so livro
			lImpLivro	:= .T.
			lImpTermos	:= .F.
		Case MV_PAR06 == 2 // Imprime livro e termos
			lImpLivro	:= .T.
			lImpTermos	:= .T.
		Case MV_PAR06 == 3 // Imprime so termos
			lImpLivro	:= .F.
			lImpTermos	:= .T.
	EndCase

	oSection1:Cell("N_ORDEM"):SetBlock({|| cNumOrdem := (cAliasQry1)->E1_PREFIXO,;
		If(!Empty((cAliasQry1)->E1_PREFIXO), cNumOrdem += "-" + (cAliasQry1)->E1_NUM, cNumOrdem := (cAliasQry1)->E1_NUM),;
		If(!Empty((cAliasQry1)->E1_PARCELA), cNumOrdem += "-" + (cAliasQry1)->E1_PARCELA, cNumOrdem)})

	oSection1:Cell("E1_VALOR"):SetBlock({|| xMoeda((cAliasQry1)->E1_VALOR, (cAliasQry1)->E1_MOEDA, 1,,, If(cPaisLoc == "BRA", (cAliasQry1)->E1_TXMOEDA, 0))})

	cPicCgc	:= PesqPict("SA1", "A1_CGC")

	//GESTAO - inicio
	If !(Empty(aSelFil))
		oReport:OnPageBreak({||	If (oReport:Page() > MV_PAR04, oReport:SetPageNumber(MV_PAR05), ""),;
								oReport:PrintText(STR0026 + " " + PadR(SM0->M0_NOMECOM, 100) + STR0029 + "  " + Str(oReport:Page())),;
								oReport:PrintText(STR0027 + " " + PadR(SM0->M0_INSC, 30) + STR0028 + " " + Transform(SM0->M0_CGC, cPicCgc)),;
								oReport:SkipLine()})
	Else
		cString1 :=	STR0026 + " " + PadR(SM0->M0_NOMECOM, 100)
		cString2 :=	STR0027 + " " + PadR(SM0->M0_INSC, 30) + STR0028 + " " + Transform(SM0->M0_CGC, cPicCgc)

		oReport:OnPageBreak({||	If (oReport:Page() > MV_PAR04, oReport:SetPageNumber(MV_PAR05), ""),;
								oReport:PrintText(cString1 + STR0029 + "  " + Str(oReport:Page())),;
								oReport:PrintText(cString2),;
								oReport:SkipLine()})
	EndIf
	//GESTAO - fim

	//acerta pagina inicial
	oReport:SetPageNumber(MV_PAR03)

	//GESTAO - inicio
	If Select(cAliasQry1) > 0
		oReport:SetMeter((cAliasQry1)->(LastRec()))
	EndIf

	If lImpTermos // Impressao dos Termos
		cArqAbert := GetMV("MV_LDUPABE",, "")
		cArqEncer := GetMV("MV_LDUPENC",, "")
	EndIf

	If lImpTermos .And. !(Empty(cArqAbert))

		If !(File(cArqAbert))
			aSavSet := __SetSets()
			cArqAbert := CFGX024(, STR0007) // Editor de Termos de Livros //"Livro de Duplicatas"
			__SetSets(aSavSet)
			Set(24, Set(24), .T.)
		EndIf

		If !(File(cArqEncer))
			aSavSet := __SetSets()
			cArqEncer := CFGX024(, STR0007) // Editor de Termos de Livros //"Livro de Duplicatas"
			__SetSets(aSavSet)
			Set(24, Set(24), .T.)
		EndIf

		DbSelectArea("SX1")
		DbSeek(Padr("FIN020", Len(X1_GRUPO), " ") + "01")
		aVarParam := {}

		While SX1->X1_GRUPO == Padr("FIN020", Len(X1_GRUPO), " ")
			AAdd(aVarParam, {Rtrim(Upper(X1_VAR01)), &(X1_VAR01)})
			DbSkip()
		EndDo

	EndIf

	oSection1:Init()

	If lImpLivro
		nPosSA1 := SA1->(Recno())
		(cAliasQry1)->(DbGoTop())
		While (cAliasQry1)->(!EoF())
			cCNPJAtu := (cAliasQry1)->M0_CGC
			cInscAtu := (cAliasQry1)->M0_INSC

			SM0->(DbGoTo(aSelFil[(cAliasQry1)->ASM0RECNO][3]))
			DbSelectArea("SM0")
			aVariaveis := AClone(aVarParam)

			For nX := 1 To FCount()
				If AllTrim(FieldName(nX)) == "M0_CGC"
					AAdd(aVariaveis, {FieldName(nX), Transform(FieldGet(nX), "@R 99.999.999/9999-99")})
				Else
					If !(AllTrim(FieldName(nX)) == "M0_NOME")
						AAdd(aVariaveis, {FieldName(nX), FieldGet(nX)})
					EndIf
				EndIf
			Next nX

			nPosSE1 := SE1->(Recno())

			While (cAliasQry1)->(!EoF()) .And. ((cAliasQry1)->M0_CGC == cCNPJAtu) .And. ((cAliasQry1)->M0_INSC == cInscAtu)
				SE1->(DbSeek((cAliasQry1)->(E1_FILIAL + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)))
				SA1->(DbSeek(FwxFilial("SA1",SE1->E1_FILORIG)+(CALIASQRY1)->(E1_CLIENTE+E1_LOJA)))
				oSection1:PrintLine()
				(cAliasQry1)->(DbSkip())
				oReport:IncMeter()
			EndDo

			SE1->(DbGoTo(nPosSE1))

			bBreak := oReport:bOnPageBreak
			oReport:OnPageBreak({||	})
			If lImpTermos
				If !(Empty(cArqAbert))
					ImpTerm2(cArqAbert, aVariaveis,,,, oReport)
				ElseIf !(Empty(cArqEncer))
					ImpTerm2(cArqEncer, aVariaveis,,,, oReport)
				EndIf
			EndIf
			oReport:EndPage()
			oReport:SetPageNumber(MV_PAR03)
			oReport:OnPageBreak(bBreak)
		EndDo

		lImpTermos := .F.
		SA1->(dbGoto(nPosSA1))
	EndIf

	//GESTAO - fim
	oSection1:Finish()

	oReport:OnPageBreak({||	})

	//GESTAO - inicio
	If lImpTermos .And. !Empty(cArqAbert) // Impressao dos Termos
		For nFil := 1 To Len(aSelFil)
			DbSelectArea("SM0")
			SM0->(DbGoTo(aSelFil[nFil,3]))
			aVariaveis := AClone(aVarParam)

			For nX := 1 to FCount()
				If AllTrim(FieldName(nX)) == "M0_CGC"
					AAdd(aVariaveis, {FieldName(nX), Transform(FieldGet(nX), "@R 99.999.999/9999-99")})
				Else
					If !(AllTrim(FieldName(nX)) == "M0_NOME")
						AAdd(aVariaveis, {FieldName(nX), FieldGet(nX)})
					EndIf
				EndIf
			Next nX

			If cArqAbert # ""
				oReport:EndPage()
				ImpTerm2(cArqAbert, aVariaveis,,,, oReport)
			EndIf

			If cArqEncer # ""
				oReport:EndPage()
				ImpTerm2(cArqEncer, aVariaveis,,,, oReport)
			EndIf
		Next nFil
	EndIf

	//GESTAO - inicio
	SM0->(DbGoTo(nRegSM0))

	If Select(cAliasQry1) > 0
		DbSelectArea(cAliasQry1)
		DbCloseArea()

		//Deleta tabela temporária criada na função F020GERTRB
		If _oFINR0201 <> Nil
			_oFINR0201:Delete()
			_oFINR0201 := Nil
		EndIf

	EndIf

	If Select(cArqTmp) > 0 .And. !Empty(cArqTmp)
		DbSelectArea(cArqTmp)
		DbCloseArea()
	EndIf

	RestArea(aArea)

Return

/*/{Protheus.doc} F020GerTrb
Gera a tabela temporária para impressão do relatório

@param cAliasQry1

@author Unknown
@since 27/08/2013
@version 12.1.17
/*/
User Function F020GerTrb(cAliasQry1)

	Local cQuery	:= ""
	Local nPosFil	:= 0
	Local nRegSM0	:= 0
	Local cTmpFil	:= ""
	Local aSM0		:= {}
	Local aArea		:= {}
	Local aSelFil	:= {}
	Local aFilCNPJ	:= {}
	Local lRastro	:= FVerRstFin()
	Local cFilImp	:= ""

	aArea := GetArea()
	nRegSM0 := SM0->(Recno())
	U_F020AgrFil(, @aSelFil)

	aCampos := {}
	AAdd(aCampos, {"M0_CGC"		, "C", TamSX3("A1_CGC")[1]		,	0							})
	AAdd(aCampos, {"M0_INSC"	, "C", TamSX3("A1_INSCR")[1]	,	0							})
	AAdd(aCampos, {"ASM0RECNO"	, "N", 10						,	0							})
	AAdd(aCampos, {"E1_FILIAL"	, "C", TamSX3("E1_FILIAL")[1]	,	0							})
	AAdd(aCampos, {"E1_PREFIXO"	, "C", TamSX3("E1_PREFIXO")[1]	,	0							})
	AAdd(aCampos, {"E1_NUM"		, "C", TamSX3("E1_NUM")[1]		,	0							})
	AAdd(aCampos, {"E1_PARCELA"	, "C", TamSX3("E1_PARCELA")[1]	,	0							})
	AAdd(aCampos, {"E1_TIPO"	, "C", TamSX3("E1_TIPO")[1]		,	0							})
	AAdd(aCampos, {"E1_EMISSAO"	, "D", 8						,	0							})
	AAdd(aCampos, {"E1_EMIS1"	, "D", 8						,	0							})
	AAdd(aCampos, {"E1_VENCREA"	, "D", 8						,	0							})
	AAdd(aCampos, {"E1_BAIXA"	, "D", 8						,	0							})
	AAdd(aCampos, {"E1_VALOR"	, "N", TamSX3("E1_VALOR")[1]	,	TamSX3("E1_VALOR")[2]		})
	AAdd(aCampos, {"E1_MOEDA"	, "N", TamSX3("E1_MOEDA")[1]	,	0							})
	AAdd(aCampos, {"E1_TXMOEDA"	, "N", TamSX3("E1_TXMOEDA")[1]	,	TamSX3("E1_TXMOEDA")[2]		})
	AAdd(aCampos, {"E1_CLIENTE"	, "C", TamSX3("E1_CLIENTE")[1]	,	0							})
	AAdd(aCampos, {"E1_LOJA"	, "C", TamSX3("E1_LOJA")[1]		,	0							})
	AAdd(aCampos, {"A1_NOME"	, "C", TamSX3("A1_NOME")[1]		,	0							})
	AAdd(aCampos, {"A1_MUN"		, "C", TamSX3("A1_MUN")[1]		,	0							})
	AAdd(aCampos, {"A1_EST"		, "C", TamSX3("A1_EST")[1]		,	0							})

	If _oFINR0201 <> Nil
		_oFINR0201:Delete()
		_oFINR0201 := Nil
	EndIf

	DbSelectArea("AE8")
	DbCloseArea()

	cAliasQry1 := GetNextAlias()

	_oFINR0201 := FwTemporaryTable():New(cAliasQry1)
	_oFINR0201:SetFields(aCampos)
	_oFINR0201:AddIndex("1", {/*"M0_CGC", "M0_INSC", */"E1_FILIAL", "E1_EMISSAO", "E1_PREFIXO", "E1_NUM", "E1_PARCELA", "E1_TIPO"})

	//------------------
	//Criação da tabela temporaria
	//------------------
	_oFINR0201:Create()

	//Crio o arquivo temporario para aglutinar por CNPJ
	cQuery := "SELECT E1_FILIAL,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_EMISSAO,E1_EMIS1,E1_VALOR,E1_VENCREA,E1_BAIXA,E1_MOEDA,E1_TXMOEDA,E1_CLIENTE,E1_LOJA, E1_FILORIG"
	cQuery += " FROM " + RetSQLName("SE1") + " SE1 "
	cQuery += " WHERE E1_FILIAL " + GetRngFil(aSelFil, "SE1", .T., @cTmpFil)
	cQuery += " AND E1_EMISSAO >= '" + Dtos(MV_PAR01) + "' "
	cQuery += " AND E1_EMISSAO <= '" + Dtos(MV_PAR02) + "' "
	cQuery += " AND E1_TIPO IN ('" + MVDUPLIC + "','" + MVNOTAFIS + "') "
	cQuery += " AND D_E_L_E_T_ = ' ' "

	If lRastro
		// Seleciona apenas as parcelas de um dedobramento, removendo o titulo que foi desdobrado.
		cQuery += " AND ( SE1.E1_DESDOBR = '2' "
		cQuery += " OR 'FINA040' NOT IN (SE1.E1_ORIGEM) "
		cQuery += " OR ( SE1.E1_DESDOBR = '1' "
		cQuery += " AND EXISTS(SELECT * FROM " + RetSQLName("FI7") + " FI7 " + ;
					" WHERE SE1.E1_FILIAL = FI7.FI7_FILIAL " + ;
					" AND SE1.E1_FILIAL = FI7.FI7_FILDES " + ;
					" AND SE1.E1_PREFIXO = FI7.FI7_PRFDES " + ;
					" AND SE1.E1_NUM = FI7.FI7_NUMDES " + ;
					" AND SE1.E1_PARCELA = FI7.FI7_PARDES " + ;
					" AND SE1.E1_TIPO = FI7.FI7_TIPDES " + ;
					" AND SE1.E1_CLIENTE = FI7.FI7_CLIDES " + ;
					" AND SE1.E1_LOJA = FI7.FI7_LOJDES " + ;
					" AND FI7.D_E_L_E_T_ = ' ' ))) "
	EndIf

	cQuery += " ORDER BY E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO"

	cQuery 	:= ChangeQuery(cQuery)
	cArqTmp := GetNextAlias()
	MPSysOpenQuery(cQuery, cArqTmp)
	TCSetField(cArqTmp, "E1_EMISSAO",	"D",	8,	0)
	TCSetField(cArqTmp, "E1_EMIS1",		"D",	8,	0)
	TCSetField(cArqTmp, "E1_VENCREA",	"D",	8,	0)
	TCSetField(cArqTmp, "E1_BAIXA",		"D",	8,	0)

	aSM0 := FwLoadSM0(.T.)

	While !((cArqTmp)->(EoF()))
		cFilImp := (cArqTmp)->E1_FILORIG
		nPosFil := AScan(aSM0, {|SM0| SM0[SM0_GRPEMP] == FwGrpCompany() .And. SM0[SM0_CODFIL] == cFilImp})

		If nPosFil > 0
			DbSelectArea("SA1") //ADD ALT

			SA1->(DbSeek(xFilial("SA1", cFilImp) + (cArqTmp)->E1_CLIENTE + (cArqTmp)->E1_LOJA))
			SM0->(DbGoTo(aSM0[nPosFil][SM0_RECNO]))

			//Agrupa as filiais por CNPJ
			nPosFil := AScan(aFilCNPJ, {|SM0| SM0[1] == SM0->M0_CGC .And. SM0[2] == SM0->M0_INSC})

			If nPosFil == 0
				AAdd(aFilCNPJ, {SM0->M0_CGC, SM0->M0_INSC, SM0->(Recno()), {(cArqTmp)->E1_FILIAL}})
				nPosFil := Len(aFilCNPJ)
			Else
				If AScan(aFilCNPJ[nPosFil][4], (cArqTmp)->E1_FILIAL) == 0
					AAdd(aFilCNPJ[nPosFil][4], (cArqTmp)->E1_FILIAL)
				EndIf
			EndIf

			RecLock(cAliasQry1, .T.)
			Replace (cAliasQry1)->M0_CGC		With SM0->M0_CGC
			Replace (cAliasQry1)->M0_INSC		With SM0->M0_INSC
			Replace (cAliasQry1)->E1_FILIAL		With (cArqTmp)->E1_FILIAL
			Replace (cAliasQry1)->E1_PREFIXO	With (cArqTmp)->E1_PREFIXO
			Replace (cAliasQry1)->E1_NUM		With (cArqTmp)->E1_NUM
			Replace (cAliasQry1)->E1_PARCELA	With (cArqTmp)->E1_PARCELA
			Replace (cAliasQry1)->E1_TIPO		With (cArqTmp)->E1_TIPO
			Replace (cAliasQry1)->E1_EMISSAO	With (cArqTmp)->E1_EMISSAO
			Replace (cAliasQry1)->E1_EMIS1		With (cArqTmp)->E1_EMIS1
			Replace (cAliasQry1)->E1_VENCREA	With (cArqTmp)->E1_VENCREA
			Replace (cAliasQry1)->E1_BAIXA		With (cArqTmp)->E1_BAIXA
			Replace (cAliasQry1)->E1_VALOR		With (cArqTmp)->E1_VALOR
			Replace (cAliasQry1)->E1_MOEDA		With (cArqTmp)->E1_MOEDA
			Replace (cAliasQry1)->E1_TXMOEDA	With (cArqTmp)->E1_TXMOEDA
			Replace (cAliasQry1)->E1_CLIENTE	With (cArqTmp)->E1_CLIENTE
			Replace (cAliasQry1)->E1_LOJA		With (cArqTmp)->E1_LOJA
			Replace (cAliasQry1)->A1_NOME		With SA1->A1_NOME
			Replace (cAliasQry1)->A1_MUN		With SA1->A1_MUN
			Replace (cAliasQry1)->A1_EST		With SA1->A1_EST
			Replace (cAliasQry1)->ASM0RECNO		With nPosFil
			MsUnLock()
		EndIf
		(cArqTmp)->(DbSkip())
	EndDo

	DbSelectArea(cArqTmp)
	CtbTmpErase(cTmpFil)
	SM0->(DbGoTo(nRegSM0))
	RestArea(aArea)

Return AClone(aFilCNPJ)

/*/{Protheus.doc} F020AgrFil
Prepara as filiais selecionadas para uso na query

@param aCNPJ
@param aFil

@author Unknown
@since 27/08/2013
@version 12.1.17
/*/
User Function F020AgrFil(aCNPJ, aFil)

	Local nPosFil	:= 0
	Local nX		:= 0
	Local nRegSM0	:= 0
	Local aSM0		:= {}
	Local aArea		:= {}

	Default aCNPJ	:= {}
	Default aFil	:= {}

	aArea 	:= GetArea()
	nRegSM0 := SM0->(Recno())

	aFil := AdmGetFil(.F., .F., "SE1")

	If Empty(aFil)
		aFil := {cFilAnt}
	EndIf

	aSM0 := FwLoadSM0(.T.)
	For nX := 1 To Len(aFil)
		nPosFil := AScan(aSM0, {|SM0| SM0[SM0_GRPEMP] == FwGrpCompany() .And. SM0[SM0_CODFIL] == aFil[nX]})
		If nPosFil > 0
			SM0->(DbGoTo(aSM0[nPosFil][SM0_RECNO]))
			nPosFil := AScan(aCNPJ, {|sm0| sm0[1] == SM0->M0_CGC .And. sm0[2] == SM0->M0_INSC})
			If nPosFil == 0
				AAdd(aCNPJ, {SM0->M0_CGC, SM0->M0_INSC, SM0->(Recno()), {aFil[nX]}})
				nPosFil := Len(aCNPJ)
			Else
				If AScan(aCNPJ[nPosFil][4], aFil[nX]) == 0
					AAdd(aCNPJ[nPosFil][4], aFil[nX])
				EndIf
			Endif
		Endif
	Next nX

	SM0->(DbGoTo(nRegSM0))
	RestArea(aArea)

Return
