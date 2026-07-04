/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR565.CH"
#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR565
Recibo de adiantamentos do Caixinha.

@author Pequim
@since 25/04/2003
/*/
//-------------------------------------------------------------------
User Function FINR565()
	Local oReport As Object
	Private lMenu := .T.

	oReport	:= ReportDef()
	oReport:PrintDialog()
Return


//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definicão do objeto do relatório.

@author richard.lopes
@since 13/12/2019
@version 12.1.25
/*/
//-------------------------------------------------------------------
Static Function ReportDef() As Object
	Local oReport As Object
	Local cReport As Character
	Local cTitulo As Character
	Local cDescri As Character

	cReport := "FINR565"
	cTitulo := OemToAnsi(STR0003)
	cDescri := OemToAnsi(STR0001) + " " + OemToAnsi(STR0002)

	If FunName() == "FINA560"
		lMenu := .F.
	Else
		Pergunte("AFI565",.F.)
	EndIf
	
	// --------------------------------------------------------------
	//  Variaveis utilizadas para parametros                        |
	//  MV_PAR01            // Caixa De		                        |
	//  MV_PAR02            // Caixa Ate                            |
	//  MV_PAR03            // Data De                              |
	//  MV_PAR04            // Data Ate                             |
	//  MV_PAR05            // Numero do Documento De               |
	//  MV_PAR06            // Numero do Documento Ate              |
	//  MV_PAR07            // Recibos Por Pagina (1 ou 2)          |
	//  MV_PAR08            // Emissao/Reemissão/Todos			    |
	// --------------------------------------------------------------

	oReport := TReport():New(cReport, cTitulo, Iif(lMenu, "AFI565", ""), {|oReport| ReportPrint(oReport)}, cDescri)

	oReport:SetPortrait() // Retrato
	oReport:SetLineHeight(40) 

	oReport:nFontBody := 12
Return oReport


//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o objeto oReport definido na funcao ReportDef.

@author richard.lopes
@since 13/12/2019
@version 12.1.25
/*/
//-------------------------------------------------------------------
Static Function ReportPrint(oReport As Object)
	Local cExt1     As Character
	Local cExt2     As Character
	Local cValor    As Character
	Local cChave	As Character
	Local cMoeda    As Character
	Local cQuery    As Character
	Local cExtenso  As Character
	Local cQuantia  As Character
	Local cAliasTmp As Character
	Local lRecFirst As Logical
	Local aStru 	As Array
	Local aRecno    As Array
	Local aAreaSEU  As Array
	Local nI 		As Numeric

	cExt1     := ""
	cExt2     := ""
	cValor    := ""
	cChave    := ""
	cMoeda    := GetMv("MV_SIMB1")
	cQuery    := ""
	cExtenso  := ""
	cQuantia  := ""
	cAliasTmp := GetNextAlias()
	lRecFirst := .F.  //Controla se estou imprimindo o primeiro ou o segundo recibo
	aStru 	  := {}
	aRecno    := {}
	aAreaSEU  := {}
	nI 		  := 0

	If lMenu
		dbSelectArea("SEU")
		dbSetOrder(4)		//Caixa/Dt. Digitacao/Numero

		aStru	:= SEU->(dbStruct())
		cChave	:= SqlOrder("EU_FILIAL+EU_CAIXA+EU_EMISSAO+EU_NUM")

		dbCloseArea()

		aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
		cQuery := "SELECT "+SubStr(cQuery,2)
		cQuery +=         ",R_E_C_N_O_ RECSEU "
		cQuery += " FROM " + RetSqlName("SEU") + " WHERE"
		cQuery += " EU_FILIAL = '" + xFilial("SEU") + "'"
		cQuery += " AND EU_CAIXA	BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02+ "'"	
		cQuery += " AND EU_EMISSAO	BETWEEN '" + Dtos(MV_PAR03) + "' AND '" + Dtos(MV_PAR04) + "'"   
		cQuery += " AND EU_NUM	BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'"
		cQuery += " AND EU_TIPO IN ('00','01')"
		If MV_PAR08 == 1
			cQuery += " AND EU_IMPRESS <> 'S'"
		ElseIf MV_PAR08 == 2
			cQuery += " AND EU_IMPRESS = 'S'"
		EndIf					
		cQuery += " AND D_E_L_E_T_ = ' '"
		cQuery += " ORDER BY " + cChave
				
		cQuery := ChangeQuery(cQuery)
				
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasTmp, .F., .T.)

		For nI := 1 To Len(aStru)
			If aStru[nI,2] != 'C'
				TCSetField(cAliasTmp, aStru[nI,1], aStru[nI,2],aStru[nI,3],aStru[nI,4])
			EndIf
		Next
	Else
		cAliasTmp := "SEU"
	EndIf

	While (cAliasTmp)->(!Eof())
		SET->(DbSetOrder(1))
		SET->(DBSeek (xFilial("SET") + (cAliasTmp)->EU_CAIXA))
		SA6->(DbSeek (xFilial("SA6") +SET->ET_BANCO+SET->ET_AGEBCO+SET->ET_CTABCO ))

		cValor := cMoeda + " " + AllTrim(Transform((cAliasTmp)->EU_VALOR, PesqPict("SEU","EU_VALOR",19,1)))

		oReport:PrtRight("")
		oReport:PrtLeft(SM0->M0_NOME)
		oReport:PrtRight(STR0013 + DtoC(dDataBase))
		oReport:SkipLine()
		oReport:PrtCenter(Iif((cAliasTmp)->EU_TIPO == "00", STR0011, STR0012)) // RECIBO DE DESPESA // RECIBO DE ADIANTAMENTO
		oReport:SkipLine()
		oReport:PrtCenter(STR0014 + (cAliasTmp)->EU_NUM) // Nro. :
		oReport:SkipLine(4)
		oReport:PrtRight(cValor)
		oReport:SkipLine(4)

		aAreaSEU := (cAliasTmp)->(GetArea())
		cExtenso:= Extenso( (cAliasTmp)->EU_VALOR,.F.,SA6->A6_MOEDA)
		RestArea(aAreaSEU)
		
		U_Fr565Exten(cExtenso,@cExt1,@cExt2)

		cQuantia := Space(20) + STR0008 + DtoC((cAliasTmp)->EU_EMISSAO) + STR0009 + AllTrim(cExt1) // Recebi em // a quantia de 

		If !Empty(cExt2) .or. Len(cExt1) >= 34
			oReport:PrtCenter(cQuantia)
			oReport:SkipLine()
			oReport:PrtCenter(Alltrim(cExt2) + ".")
			oReport:SkipLine(2)
		Else
			oReport:PrtCenter(cQuantia + ".")
			oReport:SkipLine(2)
		EndIf

		oReport:PrtCenter(STR0010 + AllTrim((cAliasTmp)->EU_HISTOR) + ".") // Este valor refere-se a
		
		oReport:SkipLine(10)
		
		oReport:PrtCenter(Replicate("-", Len((cAliasTmp)->EU_BENEF)))
		oReport:SkipLine()
		oReport:PrtCenter(PadC(AllTrim((cAliasTmp)->EU_BENEF), Len((cAliasTmp)->EU_BENEF)))
		
		oReport:SkipLine(10)
		
		oReport:FatLine()
		oReport:SkipLine(3)

		If lMenu
			AAdd(aRecno,(cAliasTmp)->RECSEU)
			(cAliasTmp)->(dbSkip())
		Else
			AAdd(aRecno,(cAliasTmp)->(RECNO()))
			Exit
		EndIf

		If MV_PAR07 == 1 .Or. lRecFirst // Um recibo por página
			oReport:EndPage()
			lRecFirst := .F.
		ElseIf !lRecFirst
			lRecFirst := .T.
		EndIf
	EndDo

	// Atualiza flag de recibo impresso.
	dbSelectArea("SEU")
	For nI := 1 To Len(aRecno)
		SEU->(DbGoto(aRecno[nI]))
		RecLock("SEU")
		SEU->EU_IMPRESS := "S"
		SEU->(MsUnlock())
	Next
	SEU->(dbCloseArea())
Return


//-------------------------------------------------------------------
/*/{Protheus.doc} Fr565Exten
Valor extenso para o recibo de caixinha.

@author Pequim
@since 24/04/2003
/*/
//-------------------------------------------------------------------
User Function Fr565Exten(cExtenso As Character, cExt1 As Character, cExt2 As Character)
	Local nLoop As Numeric
	
	cExt1 := SubStr(cExtenso,1,35) // 1.a linha do extenso
	nLoop := Len(cExt1)

	While .T.
		If Len(cExtenso) == Len(cExt1)
			Exit
		EndIf

		If SubStr(cExtenso, Len(cExt1), 1) == " " 
			Exit
		EndIf

		cExt1 := SubStr(cExtenso, 1, nLoop)
		nLoop --
	Enddo

	cExt2 := SubStr(cExtenso,Len(cExt1)+1,80) // 2.a linha do extenso

	IF !Empty(cExt2)
		cExt1 := StrTran(cExt1," ","  ",,35-Len(cExt1))
	EndIf
Return

