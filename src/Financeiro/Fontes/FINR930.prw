/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "finr930.ch"
#INCLUDE "Protheus.ch"

STATIC _oFR930TR1 := NIL
STATIC _oFR930TR2 := NIL
STATIC _oFR930TR3 := NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³finr930   º Autor ³ Nilton Pereira     º Data ³  22/02/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relacao de titulos aglutinados (pis, cofins e csll).       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function finr930()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cDesc1      := STR0001 //"Imprime relacao de titulos a pagar de impostos "
	Local cDesc2      := STR0002 //"(Pis, Cofins e Csll), exibindo os titulos que "
	Local cDesc3      := STR0003 //"originaram aglutinacao e o titulo aglutinador."
	Local titulo      := STR0004 //"Aglutinacao de Impostos a Pagar"
	Local titulo0     := ""
	Local nLin        := 80
	Local Cabec0      := ""
	Local Cabec1      := ""
	Local Cabec2      := ""

	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private CbTxt        := ""
	Private limite       := 210
	Private tamanho      := "G"
	Private nomeprog     := "finr930"
	Private nTipo        := 18
	Private aReturn      := { STR0005, 1, STR0006, 2, 2, 1, "", 1}  //"Zebrado"###"Administracao"
	Private nLastKey     := 0
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private wnrel        := "finr930"
	Private cString      := "SE5"
	Private cPerg			:= "FIN930"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetKey (VK_F12,{|a,b| AcessaPerg(cPerg,.T.)})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                  ³
	//³ mv_par01		 // Do Processo?                        ³
	//³ mv_par02		 // Ate Processo?                       ³
	//³ mv_par03		 // De Emissao?                         ³
	//³ mv_par04		 // Ate Emissao?                        ³
	//³ mv_par05		 // Selecionar Filiais ?                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte(cPerg,.F.)

	dbSelectArea("SE5")
	dbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta a interface padrao com o usuario...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,,.F.,Tamanho,,.T.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RptStatus({|| Fr930Imp(Cabec0,Cabec1,Cabec2,Titulo,Titulo0,nLin) },Titulo)

	F930DelTRB(.T.)

Return


/*/{Protheus.doc} Fr930Imp
    @description Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS monta a janela com a regua de processamento. 
    @author guilherme.sordi
    @since 22/02/2005
    @return NIL
	@param 
		Cabec0
		Cabec1
		Cabec2
		Titulo
		Titulo0
		nLin
    @type static function
/*/
Static Function Fr930Imp(Cabec0 as Character, Cabec1 as Character, Cabec2 as Character, Titulo as Character, Titulo0 as Character, nLin as Numeric) as Variant

	Local cArqTRB		as Character
	Local nValSub		as Numeric
	Local nValTot		as Numeric
	Local aCamposSE5	as Array
	Local cProcesso		as Character
	Local lQuebraPro	as Logical
	Local cChaveAGP		as Character
	Local nTamProc		as Numeric
	Local nTamNat 		as Numeric
	Local nTamTipo		as Numeric
	Local nTamCF		as Numeric
	Local nTamLoja  	as Numeric
	Local cCodRet       as Character
	Local nCol			as Numeric
	Local nI			as Numeric
	Local cQuery2		as Character
	Local cCamposTR1	as Character
	Local cCamposTR2	as Character

	Local cCabA 		as Character
	Local cCabB 		as Character
	Local cCabC 		as Character
	Local cCabD 		as Character
	Local nCabA 		as Numeric
	Local nCabB 		as Numeric
	Local nCabC 		as Numeric
	Local nCabD 		as Numeric

	Local aSelFil 		as Array
	Local nC 			as Numeric
	Local lPrtFil 		as Logical
	Local cFilialAtu 	as Character
	Local aAreaSM0 		as Array
	Local lGestao 		as Logical
	Local lSE5Excl 		as Logical
	Local aSM0 			as Array
	Local aFilAux 		as Array
	Local nTamEmp		as Numeric
	Local nTamUnNeg		as Numeric
	Local nLinha		as Numeric
	Local nMvComp		as Numeric

	cArqTRB				:= ""
	nValSub				:= 0
	nValTot				:= 0
	aCamposSE5			:= {}
	cProcesso			:= ""
	lQuebraPro			:= .T.
	cChaveAGP			:= ""
	nTamProc			:= TamSX3( "E5_AGLIMP"  )[1]
	nTamNat 			:= TamSX3( "E5_NATUREZ" )[1]
	nTamTipo			:= TamSX3( "E5_TIPO"    )[1]
	nTamCF				:= TamSX3( "E5_CLIFOR"  )[1]
	nTamLoja  			:= TamSX3( "E5_LOJA"    )[1]
	cCodRet       		:= ""
	nCol				:= TamSX3( "E5_FILIAL"  )[1] + 1
	nI					:= 0
	cQuery2				:= ''
	cCamposTR1			:= ''
	cCamposTR2			:= ''

	cCabA 				:= ""
	cCabB 				:= ""
	cCabC 				:= ""
	cCabD 				:= ""
	nCabA 				:= 0
	nCabB 				:= 0
	nCabC 				:= 0
	nCabD 				:= 0

	aSelFil 			:= {}
	nC 					:= 0
	lPrtFil				:= .F.
	cFilialAtu 			:= cFilAnt
	lGestao   			:= ( FWSizeFilial() > 2 )
	lSE5Excl  			:= Iif( lGestao, FWModeAccess("SE5",1) == "E", FWModeAccess("SE5",3) == "E")
	aSM0 				:= {}
	aFilAux 			:= {}
	nTamEmp				:= 0
	nTamUnNeg			:= 0
	nLinha				:= 0
	nMvComp				:= SuperGetMV("MV_COMP", .F., 15)

	Private cUniao   := PADR(SuperGetMV("MV_UNIAO"),Len(SA2->A2_COD))
	Private cNatPis  := SuperGetMV("MV_PISNAT",.F.,"PIS")
	Private cNatCof  := SuperGetMV("MV_COFINS",.F.,"COF")
	Private cNatCsl  := SuperGetMV("MV_CSLL",.F.,"CSL")
	Private cNatIrf  := &(SuperGetMV("MV_IRF"))

	titulo0 := STR0008 + " (" + STR0022	+ ")"	//"Relação de Titulos Movimentados por Aglutinação ### (Filiais selecionadas para o relatorio)"
	//Cabec0 := "Código         Empresa                                      Unidade de Negócio           Filial"

	If mv_par05 == 1
		If lSE5Excl
			aAreaSM0 := SM0->(GetArea())
			If lGestao .And. FindFunction("FwSelectGC")
				aSelFil := FwSelectGC()
			Else
				aSelFil := AdmGetFil(.F.,.F.,"SE5")
			Endif
			RestArea(aAreaSM0)

			If Empty( aSelFil )
				aAdd( aSelFil , cFilAnt )
			EndIf
		Else
			mv_par05 := 2
		EndIf
	Endif

	If mv_par05 == 1
		aSort(aSelFil)
		aSM0 := FWLoadSM0()
		nTamEmp := Len(FWSM0LayOut(,1))
		nTamUnNeg := Len(FWSM0LayOut(,2))
		cCabA := PadR(STR0018,Max(Len(STR0018),20) + 1) //"Código"
		cCabB := PadR(STR0019,Max(Len(STR0019),60) + 1) //"Empresa"
		cCabC := PadR(STR0020,Max(Len(STR0020),60) + 1) //"Unidade de Negócio"
		cCabD := PadR(STR0021,Max(Len(STR0021),60) + 1) //"Filial"
		nCabA := Len(cCabA)
		nCabB := nCabA + Len(cCabB)
		nCabC := nCabB + Len(cCabC)
		nCabD := nCabC + Len(cCabD)
		Cabec0 := cCabA+cCabB+cCabC+cCabD
		For nC := 1 To Len(aSelFil)
			If nLin > 58
				nLin := cabec(titulo0, cabec0, "", nomeprog, tamanho, nMvComp)
				nLin++
			EndIf
			nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nC] .And. sm0[SM0_GRPEMP] == cEmpAnt})
			If nLinha > 0
				cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
				@ nLin,0 PSAY cFilSel
				@ nLin,nCabA PSAY aSM0[nLinha,SM0_DESCEMP]
				@ nLin,nCabB PSAY aSM0[nLinha,SM0_DESCUN]
				@ nLin++,nCabC PSAY aSM0[nLinha,SM0_NOMRED]
			Endif
		Next
		nLin := 80
	Else
		aSelFil := {cFilAnt}
	EndIf

	For nC := 1 To Len(aSelFil) Step 1
		cFilAnt := aSelFil[nC]

		//Evita a duplicidade de dados na gestão corporativa com a filial parcialmente compartilhada
		If aScan( aFilAux , xFilial( "SE5" ) ) > 0
			Loop
		EndIf

		lPrtFil := .T.
		cArqTRB		:= ""
		nValSub		:= 0
		nValTot		:= 0
		aCamposSE5	:= {}
		cProcesso		:= ""
		lQuebraPro	:= .T.
		cChaveAGP		:= ""
		cCodRet       := ""

		// Monta estrutura do arquivo temporario (CodeBase)
		aCamposSE5	:= {	    {"FILIAL"	,"C",TamSx3("E5_FILIAL")[1] ,0 },;
								{"PREFIXO"	,"C",TamSx3("E5_PREFIXO")[1] ,0 },;
								{"NUM"		,"C",TamSx3("E5_NUMERO")[1] ,0 },;
								{"PARCELA"	,"C",TamSx3("E5_PARCELA")[1] ,0 },;
								{"TIPO"		,"C",TamSx3("E5_TIPO")[1] ,0 },;
								{"CODIGO"	,"C",TamSx3("E5_CLIFOR")[1] ,0 },;
								{"LOJA"		,"C",TamSx3("E5_LOJA")[1] ,0 },;
								{"NOMEFOR"	,"C",TamSx3("E2_NOMFOR")[1] ,0 },;
								{"EMISSAO"	,"D",TamSx3("E5_DTDIGIT")[1] ,0 },;
								{"VENCTO"	,"D",TamSx3("E5_VENCTO")[1] ,0 },;
								{"PROCESSO"	,"C",TamSx3("E5_AGLIMP")[1] ,0 },;
								{"NATUREZA"	,"C",TamSx3("E5_NATUREZ")[1] ,0 },;
								{"CODRET"	,"C",TamSx3("E2_CODRET")[1] ,0 },;
								{"VALOR"	,"N",TamSx3("E5_VALOR")[1] ,2 },;
								{"GERADOR"	,"C",1,0 }}

		// Monta o arquivo temporario com a soma dos titulos das filiais
		F930DelTRB(.F.,3)
		_oFR930TR3 := FWTemporaryTable():New( 'TRB', aCamposSE5 )
		_oFR930TR3:AddIndex('1',{"PROCESSO","CODRET","NATUREZA","GERADOR","PREFIXO","NUM","PARCELA","TIPO"})
		_oFR930TR3:Create()

		// A função SomaAbat reabre o SE2 com outro nome pela ChkFile, pois o filtro do SE2, desconsidera os abatimentos
		SomaAbat("","","","P")

		// Cria Arquivo temporario 1 -------------------------------------------
		// Monta condicao de query para execucao no SE5.
		cQuery := "SELECT "
		cQuery += "A2_COD,A2_LOJA,A2_NOME,"
		cQuery += "E5_PREFIXO,E5_NUMERO,E5_PARCELA,E5_TIPO,E5_DTDIGIT,E5_VENCTO,E5_VALOR,E5_AGLIMP,E5_NATUREZ,"
		cQuery += "E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA,E2_EMISSAO,E2_CODRET,E2_FILIAL "
		cQuery += "FROM " + RetSqlName("SE5")+" SE5 "
		cQuery += "INNER JOIN " + RetSqlName("SE2")+ " SE2 ON "
		cQuery += " SE5.E5_FILORIG = SE2.E2_FILORIG"
		cQuery += " AND SE5.E5_PREFIXO = SE2.E2_PREFIXO"
		cQuery += " AND SE5.E5_NUMERO  = SE2.E2_NUM"
		cQuery += " AND SE5.E5_PARCELA = SE2.E2_PARCELA"
		cQuery += " AND SE5.E5_TIPO    = SE2.E2_TIPO,"
		cQuery += RetSqlName("SA2")+" SA2 "
		cQuery += " WHERE SA2.A2_FILIAL   = '" + xFilial("SA2") + "'"
		cQuery += " AND SE5.D_E_L_E_T_  = ' ' "
		cQuery += " AND SA2.D_E_L_E_T_  = ' ' "
		cQuery += " AND SE2.D_E_L_E_T_  = ' ' "
		cQuery += " AND SE5.E5_SITUACA  <> 'C' "
		cQuery += " AND SE5.E5_CLIFOR  =  SA2.A2_COD"
		cQuery += " AND SE5.E5_LOJA	  =  SA2.A2_LOJA"
		cQuery += " AND SE5.E5_DATA  between '" + DTOS(mv_par03)  + "' AND '" + DTOS(mv_par04) + "'"
		cQuery += " AND SE5.E5_TIPODOC IN ('VL','BA','CP','V2') "
		cQuery += " AND SE5.E5_AGLIMP <> '"+Space(Len(SE5->E5_AGLIMP))+"' "
		cQuery += " AND SE5.E5_AGLIMP>='"+mv_par01+"' "
		cQuery += " AND SE5.E5_AGLIMP<='"+mv_par02+"' "
		cQuery += " AND SE5.E5_TIPO IN " + FormatIn(MVPAGANT+"|"+MV_CPNEG+"|"+MVISS+"|"+MVTAXA+"|"+MVTXA+"|"+MVINSS +"|"+ "SES", "|" )
		cQuery := ChangeQuery(cQuery)

		aCamposTR1 := {	{"CODIGO",		TAMSX3("A2_COD")[3],		TAMSX3("A2_COD")[1],		TAMSX3("A2_COD")[2]},;
						{"LOJA",		TAMSX3("A2_LOJA")[3],		TAMSX3("A2_LOJA")[1],		TAMSX3("A2_LOJA")[2]},;
						{"A2_NOME",		TAMSX3("A2_NOME")[3],		TAMSX3("A2_NOME")[1],		TAMSX3("A2_NOME")[2]},;
						{"PREFIXO",		TAMSX3("E5_PREFIXO")[3],	TAMSX3("E5_PREFIXO")[1],	TAMSX3("E5_PREFIXO")[2]},;
						{"NUM",			TAMSX3("E5_NUMERO")[3],		TAMSX3("E5_NUMERO")[1],		TAMSX3("E5_NUMERO")[2]},;
						{"PARCELA",		TAMSX3("E5_PARCELA")[3],	TAMSX3("E5_PARCELA")[1],	TAMSX3("E5_PARCELA")[2]},;
						{"TIPO",		TAMSX3("E5_TIPO")[3],		TAMSX3("E5_TIPO")[1],		TAMSX3("E5_TIPO")[2]},;
						{"EMISSAO",		TAMSX3("E5_DTDIGIT")[3],	TAMSX3("E5_DTDIGIT")[1],	TAMSX3("E5_DTDIGIT")[2]},;
						{"VENCTO",		TAMSX3("E5_VENCTO")[3],		TAMSX3("E5_VENCTO")[1],		TAMSX3("E5_VENCTO")[2]},;
						{"VALOR",		TAMSX3("E5_VALOR")[3],		TAMSX3("E5_VALOR")[1],		TAMSX3("E5_VALOR")[2]},;
						{"PROCESSO",	TAMSX3("E5_AGLIMP")[3],		TAMSX3("E5_AGLIMP")[1],		TAMSX3("E5_AGLIMP")[2]},;
						{"NATUREZA",	TAMSX3("E5_NATUREZ")[3],	TAMSX3("E5_NATUREZ")[1],	TAMSX3("E5_NATUREZ")[2]},;
						{"E2_PREFIXO",	TAMSX3("E2_PREFIXO")[3],	TAMSX3("E2_PREFIXO")[1],	TAMSX3("E2_PREFIXO")[2]},;
						{"E2_NUM",		TAMSX3("E2_NUM")[3],		TAMSX3("E2_NUM")[1],		TAMSX3("E2_NUM")[2]},;
						{"E2_PARCELA",	TAMSX3("E2_PARCELA")[3],	TAMSX3("E2_PARCELA")[1],	TAMSX3("E2_PARCELA")[2]},;
						{"E2_TIPO",		TAMSX3("E2_TIPO")[3],		TAMSX3("E2_TIPO")[1],		TAMSX3("E2_TIPO")[2]},;
						{"E2_FORNECE",	TAMSX3("E2_FORNECE")[3],	TAMSX3("E2_FORNECE")[1],	TAMSX3("E2_FORNECE")[2]},;
						{"E2_LOJA",		TAMSX3("E2_LOJA")[3],		TAMSX3("E2_LOJA")[1],		TAMSX3("E2_LOJA")[2]},;
						{"E2_EMISSAO",	TAMSX3("E2_EMISSAO")[3],	TAMSX3("E2_EMISSAO")[1],	TAMSX3("E2_EMISSAO")[2]},;
						{"CODRET",		TAMSX3("E2_CODRET")[3],		TAMSX3("E2_CODRET")[1],		TAMSX3("E2_CODRET")[2]},;
						{"FILIAL",		TAMSX3("E2_FILIAL")[3],		TAMSX3("E2_FILIAL")[1],		TAMSX3("E2_FILIAL")[2]} }

		For nI := 1 To LEN(aCamposTR1)
			cCamposTR1 += aCamposTR1[nI][1]
			cCamposTR1 += If(nI < LEN(aCamposTR1),',',' ')
		Next nI

		F930DelTRB(.F.,1)
		_oFR855TR1 := FWTemporaryTable():New( 'TR1', aCamposTR1 )
		_oFR855TR1:Create()
		cQuery2 := " INSERT "
		If ALLTRIM(TCGetdb()) == "ORACLE"
			cQuery2 += " /*+ APPEND */ "
		Endif
		cQuery2 += " INTO " + _oFR855TR1:GetRealName() + " (" + cCamposTR1 + ") " + cQuery
		Processa({|| nTcSql := TcSQLExec(cQuery2)})
		cCamposTR1	:= ""
		// Cria Arquivo temporario 2 -------------------------------------------
		// Monta condicao de query para execucao no SE2.
		cQuery := "SELECT "
		cQuery += "A2_COD,A2_LOJA,A2_NOME,E2_PREFIXO,E2_NUM,E2_NUM,E2_PARCELA,E2_TIPO,E2_EMISSAO,E2_VENCTO,E2_VALOR,E2_NATUREZ,E2_CODRET,E2_FILIAL "
		cQuery += "FROM "+RetSqlName("SE2")+" SE2,"
		cQuery +=         RetSqlName("SA2")+" SA2 "
		cQuery += "WHERE SE2.D_E_L_E_T_ = ' ' AND SA2.D_E_L_E_T_ = ' ' "
		cQuery += "AND SE2.E2_FILIAL = '" + xFilial("SE2") + "' "
		cQuery += "AND SA2.A2_FILIAL = '" + xFilial("SA2") + "' "
		cQuery += "AND SE2.E2_FORNECE = SA2.A2_COD "
		cQuery += "AND SE2.E2_LOJA = SA2.A2_LOJA "
		cQuery += "AND SE2.E2_FORNECE LIKE '"+Alltrim(cUniao)+"%' "
		cQuery += "AND SE2.E2_TIPO IN "+ FORMATIN(MVTAXA,,3)+" "
		cQuery += "AND SE2.E2_SALDO > 0 "
		cQuery += "AND (SE2.E2_NATUREZ LIKE '"+ cNatPIS +"%' "
		cQuery += "OR SE2.E2_NATUREZ LIKE '"+ cNatCOF +"%' "
		cQuery += "OR SE2.E2_NATUREZ LIKE '"+ cNatIRF +"%' "
		cQuery += "OR SE2.E2_NATUREZ LIKE '"+ cNatCSL +"%' ) "
		cQuery += "AND SE2.E2_EMISSAO between '" + DTOS(mv_par03)  + "' AND '" + DTOS(mv_par04) + "'"
		cQuery += "AND SE2.E2_NUM>='"+mv_par01+"' "
		cQuery += "AND SE2.E2_NUM<='"+mv_par02+"' "
		cQuery += "AND (SE2.E2_NUMTIT LIKE 'FINA378%' "
		cQuery += "OR SE2.E2_NUMTIT LIKE 'FINA376%' "
		cQuery += "OR SE2.E2_NUMTIT LIKE 'FINA381%') "
		cQuery := ChangeQuery(cQuery)

		aCamposTR2 := {	{"CODIGO",		TAMSX3("A2_COD")[3],		TAMSX3("A2_COD")[1],		TAMSX3("A2_COD")[2]},;
						{"LOJA",		TAMSX3("A2_LOJA")[3],		TAMSX3("A2_LOJA")[1],		TAMSX3("A2_LOJA")[2]},;
						{"A2_NOME",		TAMSX3("A2_NOME")[3],		TAMSX3("A2_NOME")[1],		TAMSX3("A2_NOME")[2]},;
						{"PREFIXO",		TAMSX3("E2_PREFIXO")[3],	TAMSX3("E2_PREFIXO")[1],	TAMSX3("E2_PREFIXO")[2]},;
						{"NUM",			TAMSX3("E2_NUM")[3],		TAMSX3("E2_NUM")[1],		TAMSX3("E2_NUM")[2]},;
						{"PROCESSO",	TAMSX3("E2_NUM")[3],		TAMSX3("E2_NUM")[1],		TAMSX3("E2_NUM")[2]},;
						{"PARCELA",		TAMSX3("E2_PARCELA")[3],	TAMSX3("E2_PARCELA")[1],	TAMSX3("E2_PARCELA")[2]},;
						{"TIPO",		TAMSX3("E2_TIPO")[3],		TAMSX3("E2_TIPO")[1],		TAMSX3("E2_TIPO")[2]},;
						{"EMISSAO",		TAMSX3("E2_EMISSAO")[3],	TAMSX3("E2_EMISSAO")[1],	TAMSX3("E2_EMISSAO")[2]},;
						{"VENCTO",		TAMSX3("E2_VENCTO")[3],		TAMSX3("E2_VENCTO")[1],		TAMSX3("E2_VENCTO")[2]},;
						{"VALOR",		TAMSX3("E2_VALOR")[3],		TAMSX3("E2_VALOR")[1],		TAMSX3("E2_VALOR")[2]},;
						{"NATUREZA",	TAMSX3("E2_NATUREZ")[3],	TAMSX3("E2_NATUREZ")[1],	TAMSX3("E2_NATUREZ")[2]},;
						{"CODRET",		TAMSX3("E2_CODRET")[3],		TAMSX3("E2_CODRET")[1],		TAMSX3("E2_CODRET")[2]},;
						{"FILIAL",		TAMSX3("E2_FILIAL")[3],		TAMSX3("E2_FILIAL")[1],		TAMSX3("E2_FILIAL")[2]} }

		For nI := 1 To LEN(aCamposTR2)
			cCamposTR2 += aCamposTR2[nI][1]
			cCamposTR2 += If(nI < LEN(aCamposTR2),',',' ')
		Next nI

		F930DelTRB(.F.,2)
		_oFR855TR2 := FWTemporaryTable():New( 'TR2', aCamposTR2 )
		_oFR855TR2:Create()
		cQuery2 := " INSERT "
		If ALLTRIM(TCGetdb()) == "ORACLE"
			cQuery2 += " /*+ APPEND */ "
		Endif
		cQuery2 += " INTO " + _oFR855TR2:GetRealName() + " (" + cCamposTR2 + ") " + cQuery
		Processa({|| nTcSql := TcSQLExec(cQuery2)})
		cCamposTR2	:= ""
		// Grava TRB com os arquivos resultates do filtro do SE5 e SE2
		TR2->( dbGotop() )
		Do While TR2->( !EoF() )

			RecLock("TRB",.T.)
				TRB->FILIAL		:= TR2->FILIAL
				TRB->CODIGO		:= TR2->CODIGO
				TRB->LOJA		:= TR2->LOJA
				TRB->NOMEFOR	:= GetLGPDValue("TR2","A2_NOME")
				TRB->PREFIXO	:= TR2->PREFIXO
				TRB->NUM		:= TR2->NUM
				TRB->PARCELA	:= TR2->PARCELA
				TRB->TIPO		:= TR2->TIPO
				TRB->EMISSAO	:= TR2->EMISSAO
				TRB->PROCESSO	:= TR2->PROCESSO
				TRB->NATUREZA	:= TR2->NATUREZA
				TRB->VALOR		:= TR2->VALOR
				TRB->VENCTO		:= TR2->VENCTO
				TRB->GERADOR	:= "2"
				TRB->CODRET		:= TR2->CODRET
			TRB->( MsUnlock() )

			cChaveAGP := PadR( TR2->PROCESSO, nTamProc ) + TR2->NATUREZA + TR2->TIPO + TR2->CODIGO + TR2->LOJA + TR2->CODRET

			TR1->( dbGoTop() )
			Do While TR1->( !EoF() )

				// Somente grava o TX aglutinado se corresponder ao titulo aglutinador
				If PadR( TR1->PROCESSO, nTamProc ) + TR1->NATUREZA + TR1->TIPO + TR1->CODIGO + TR1->LOJA + TR1->CODRET  == cChaveAGP

						If	RecLock("TRB",.T.)
								TRB->FILIAL		:= TR1->FILIAL
								TRB->CODIGO		:= TR1->CODIGO
								TRB->LOJA		:= TR1->LOJA
								TRB->NOMEFOR	:= GetLGPDValue("TR1","A2_NOME")
								TRB->PREFIXO	:= TR1->PREFIXO
								TRB->NUM		:= TR1->NUM
								TRB->PARCELA	:= TR1->PARCELA
								TRB->TIPO		:= TR1->TIPO
								TRB->EMISSAO	:= TR1->E2_EMISSAO
								TRB->PROCESSO	:= TR1->PROCESSO
								TRB->NATUREZA	:= TR1->NATUREZA
								TRB->VALOR		:= TR1->VALOR
								TRB->VENCTO		:= TR1->VENCTO
								TRB->GERADOR	:= "5"
								TRB->CODRET		:= TR1->CODRET //U_RetCodRet(TR1->(PREFIXO+NUM+PARCELA+TIPO+CODIGO+LOJA))
							TRB->( MsUnlock() )
						EndIf
				EndIf
				TR1->(dbSkip())

			EndDo
			TR2->( dbSkip() )

		EndDo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seta a regua com a quantidade de arquivos resultantes               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SetRegua(TRB->(RecCount()))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga arquivos temporarios gerados no filtro                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		TR1->(dbCloseArea())
		TR2->(dbCloseArea())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta cabec e titulo conforme ordem selecionada                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		titulo      := STR0008 //"Relação de Titulos Movimentados por Aglutinação"

		If TamSX3( "E5_FILIAL"  )[1] > 2 //Gestao Corporativa
			Cabec1		:= Padr(STR0016,nCol+1)
			Cabec1      += STR0009 //"Prf. Num.   Pc.Tipo  Cd.For.Lj Nome Fornecedor      Nat.       Dt.Emissao Dt.Vencto.  Cod.Ret.           Valor"
		Else
			Cabec1		:= Padr(STR0017,nCol+1)
			Cabec1      += STR0009 //"Prf. Num.   Pc.Tipo  Cd.For.Lj Nome Fornecedor      Nat.       Dt.Emissao Dt.Vencto.  Cod.Ret.           Valor"
		Endif


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa o arquivo temporario gerado efetuando a impressao          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("TRB")
		dbGoTop()
		cProcesso := TRB->PROCESSO
		While !EOF()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica o cancelamento pelo usuario...                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAbortPrint
				@nLin,00 PSAY STR0010 //"*** CANCELADO PELO OPERADOR ***"
				Exit
			Endif

			If lPrtFil .And. mv_par05 == 1
				If nLin > 58
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 8
				Endif
				nLin += 2
				@nLin,0 PSAY STR0021 + " " + cFilAnt
				nLin++
				lPrtFil := .F.
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao do cabecalho do relatorio. . .                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nLin > 58
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 8
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Incrementa regua de processamento                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncRegua(TRB->(PREFIXO+NUM+PARCELA+TIPO))

			//cProcesso := TRB->PROCESSO

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a quebra por processo                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lQuebraPro == .T.
				lQuebraPro := .F.
				nLin    := nLin + 1
				@nLin,000 PSAY __PrtThinLine()
				nLin    := nLin + 1
				@nLin, 001 PSAY STR0011 + TRB->PROCESSO  //"Processo : "
				nLin    := nLin + 1
				@nLin,000 PSAY __PrtThinLine()
				nLin    := nLin + 2
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime primeiro titulo aglutinado                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			@nLin, 001 PSAY STR0012 //"Titulo Aglutinado : "
			nLin    := nLin + 1
			@nLin, 001      PSAY TRB->FILIAL
			@nLin, nCol+001 PSAY TRB->PREFIXO
			@nLin, nCol+005 PSAY TRB->NUM
			@nLin, nCol+015 PSAY TRB->PARCELA
			@nLin, nCol+020 PSAY TRB->TIPO
			@nLin, nCol+025 PSAY TRB->CODIGO
			@nLin, nCol+036 PSAY TRB->LOJA
			@nLin, nCol+041 PSAY Substr(TRB->NOMEFOR,1,20)
			@nLin, nCol+062 PSAY TRB->NATUREZA
			@nLin, nCol+073 PSAY TRB->EMISSAO
			@nLin, nCol+084 PSAY TRB->VENCTO
			@nLin, nCol+096 PSAY TRB->CODRET
			@nLin, nCol+105 PSAY TRB->VALOR PICTURE Tm(TRB->VALOR ,15)
			nLin    := nLin + 2
			@nLin, 001 PSAY STR0013 //"Titulos Baixados  : "
			nLin    := nLin + 1
			TRB->(DbSkip())

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Processa todas as baixas que geraram a aglutinacao                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("TRB")
			While !Eof() .And. cProcesso == TRB->PROCESSO  .And. TRB->GERADOR <> "2"

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao do cabecalho do relatorio. . .                            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nLin > 58
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 8
				Endif
				@nLin, 001      PSAY TRB->FILIAL
				@nLin, nCol+001 PSAY TRB->PREFIXO
				@nLin, nCol+005 PSAY TRB->NUM
				@nLin, nCol+015 PSAY TRB->PARCELA
				@nLin, nCol+020 PSAY TRB->TIPO
				@nLin, nCol+025 PSAY TRB->CODIGO
				@nLin, nCol+036 PSAY TRB->LOJA
				@nLin, nCol+041 PSAY Substr(TRB->NOMEFOR,1,20)
				@nLin, nCol+062 PSAY TRB->NATUREZA
				@nLin, nCol+073 PSAY TRB->EMISSAO
				@nLin, nCol+084 PSAY TRB->VENCTO
				@nLin, nCol+096 PSAY TRB->CODRET
				@nLin, nCol+105 PSAY TRB->VALOR PICTURE Tm(TRB->VALOR ,15)

				nLin    := nLin + 1
				nValSub += TRB->VALOR
				DbSkip()
			Enddo
			nLin    := nLin + 1

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Caso seja outro processo, efetua a quebra e imprime o sub-total     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cProcesso <> TRB->PROCESSO
				lQuebraPro := .T.
				@nLin, 067 PSAY STR0014 + cProcesso + " :"  //"Sub-Total (Processo) "
				@nLin, nCol+105 PSAY nValSub PICTURE Tm(TRB->VALOR ,15)
				nLin       := nLin + 1
				nValTot    += nValSub
				nValSub    := 0
				cProcesso := TRB->PROCESSO
			Endif
		Enddo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime totalizar do relatorio. . .                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nValTot > 0
			nLin    := nLin + 1
			@nLin,000 PSAY __PrtThinLine()
			nLin    := nLin + 1
			@nLin, 083 PSAY STR0015 //"Total Geral :"
			@nLin, nCol+105 PSAY nValTot PICTURE Tm(TRB->VALOR ,15)
			nLin    := nLin + 1
			@nLin,000 PSAY __PrtThinLine()
			nLin    := nLin + 1
		Endif


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Efetua limpeza dos filtros e dos arquivos temporarios...            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbCloseArea()
		ChKFile("SE2")
		dbSelectArea("SE2")
		dbSetOrder(1)
		dbSelectArea("SE5")
		dbCloseArea()
		ChKFile("SE5")
		dbSelectArea("SE5")
		dbSetOrder(1)
		TRB->(dbCloseArea())

		aAdd( aFilAux , xFilial( "SE5" ) )
	Next

	cFilAnt := cFilialAtu

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza a execucao do relatorio...                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SET DEVICE TO SCREEN

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se impressao em disco, chama o gerenciador de impressao...          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()
	aSize( aFilAux , 0 )
	aFilAux := Nil

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RetCodRet ºAutor  ³Mauricio Pequim Jr. º Data ³  20/09/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Localizo no SE2 o codigo de retencao do titulo que foi     º±±
±±º          ³ baixado pela aglutinacao                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Finr930                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RetCodRet(cChave)

	Local aArea		:= GetArea()
	Local cCodRet	:= ""

	dbSelectArea("__SE2")
	__SE2->(dbSetOrder(1))
	If __SE2->(MsSeek(xFilial("SE2")+cChave))
		cCodRet := __SE2->E2_CODRET
	Endif

	RestArea(aArea)

Return cCodRet

/*/{Protheus.doc} F930DelTRB
//Função estática que libera a tabela no banco e a variável de instância.
@author norbertom
@since 11/10/2018
@version P12

@return NIL, Nenhum retorno
@example
F930DelTRB(.T.,NIL)	// Libera todas as tabelas e variáveis de instância
F930DelTRB(.F.,2)	// Libera a tabela indicada no segundo o parâmetro

/*/
Static Function F930DelTRB(lAll,nTRB)
	Default lAll := .F.
	Default nTRB := 0

	IF (lAll .or. nTRB == 1) .AND. !EMPTY(_oFR930TR1)
		_oFR930TR1:Delete()
		_oFR930TR1 := NIL
	ENDIF
	IF (lAll .or. nTRB == 2) .AND. !EMPTY(_oFR930TR2)
		_oFR930TR2:Delete()
		_oFR930TR2 := NIL
	ENDIF
	IF (lAll .or. nTRB == 3) .AND. !EMPTY(_oFR930TR3)
		_oFR930TR3:Delete()
		_oFR930TR3 := NIL
	ENDIF

Return NIL
