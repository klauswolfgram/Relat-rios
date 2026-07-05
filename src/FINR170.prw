/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR170.CH"
#INCLUDE "PROTHEUS.CH"

Static lFWCodFil := .T.
Static cConta	as Char
Static _lVerFil as Logical

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR170  ³ Autor ³Marcel Borges Ferreira ³ Data ³ 15/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o de Borderos para cobranca / pagamentos             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FINR170                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr170()

Local oReport

oReport:=ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Marcel Borges Ferreira º Data ³  15/08/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das          º±±
±±º          ³ secoes que serao utilizadas.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 													                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 												                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local cReport 	:= "FINR170" 				// Nome do relatorio
Local cDescri 	:= STR0001 +;       		//"Este programa tem a funçäo de emitir os borderos de cobrança"
						" " + STR0002   		//"ou pagamentos gerados pelo usuario."
Local cTitulo 	:= STR0006 					//"Emiss„o de Borderos de Pagamentos"
Local cPerg		:= "FIN170"					// Nome do grupo de perguntas
Local cPictTit := PesqPict("SE2","E2_VALOR")

Pergunte("FIN170",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01        	// Carteira (R/P)                          ³
//³ mv_par02        	// Numero do Bordero Inicial               ³
//³ mv_par03        	// Numero do Bordero Final                 ³
//³ mv_par04        	// considera filial                        ³
//³ mv_par05        	// da filial                               ³
//³ mv_par06        	// ate a filial                            ³
//³ mv_par07        	// moeda                                   ³
//³ mv_par08        	// imprime outras moedas                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport)}, cDescri)
oReport:SETUSEGC(.F.)
oReport:HideHeader()		//Oculta o cabecalho do relatorio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 01 -				    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport, "Cabecalho",("TRB","SA6"))
TRCell():New(oSection1, "A6_NOME","SA6",STR0024,,32,,)
oSection1:Cell("A6_NOME"):SetCellBreak()
TRCell():New(oSection1,"A6_AGENCIA","SA6",STR0016,,20,,)
TRCell():New(oSection1,"EA_NUMCON","SEA",STR0017,,15,,)
oSection1:Cell("EA_NUMCON"):SetCellBreak()
TRCell():New(oSection1,"A6_BAIRRO","SA6",,,15,,)
TRCell():New(oSection1,"A6_MUN","SA6",,,20,,)
TRCell():New(oSection1,"A6_EST","SA6",,,5,,)
oSection1:Cell("A6_EST"):SetCellBreak()
//TRCell():New(oSection1,STR0018,,"Texto 'Bordero nro'",,12,,{|| STR0018}) // BORDERO NRO
TRCell():New(oSection1,"EA_NUMBOR","SEA",STR0018,,15,,)
//TRCell():New(oSection1,STR0039,,"Texto 'Emitido em:'",,12,,{|| STR0039}) //
TRCell():New(oSection1,"EA_DATABOR","SEA",STR0039,PesqPict("SEA","EA_DATABOR"),10,,)
oSection1:Cell("EA_DATABOR"):SetCellBreak()
//RECEBER
TRCell():New(oSection1,STR0019,,"",,Len(STR0019),,{|| STR0019}) //"Solicitamos proceder o recebimento das duplicatas abaixo relacionadas"
oSection1:Cell(STR0019):SetCellBreak()
TRCell():New(oSection1,STR0020,,"",,Len(STR0020),,{|| STR0020}) //"CREDITANDO-NOS os valores correspondentes."
oSection1:Cell(STR0020):SetCellBreak()
//PAGAR
TRCell():New(oSection1,STR0021,,"",,Len(STR0021),,{|| STR0021}) //"Solicitamos proceder o pagamento das duplicatas abaixo relacionadas"
oSection1:Cell(STR0021):SetCellBreak()
TRCell():New(oSection1,STR0022,,"",,Len(STR0022),,{|| STR0022}) //"DEBITANDO-NOS os valores correspondentes."
oSection1:Cell(STR0022):SetCellBreak()
//Linhas complementares
TRCell():New(oSection1,"Linha complementar"+" 1",,"",,70,,)
oSection1:Cell("Linha complementar"+" 1"):SetCellBreak()
TRCell():New(oSection1,"Linha complementar"+" 2",,"",,70,,)
oSection1:Cell("Linha complementar"+" 2"):SetCellBreak()
TRCell():New(oSection1,"Linha complementar"+" 3",,"",,70,,)
oSection1:Cell("Linha complementar"+" 3"):SetCellBreak()

oSection1:SetCharSeparator("")
oSection1:SetLineStyle()
oSection1:SetHeaderSection(.F.)	//Nao imprime o cabecalho da secao
oSection1:SetPageBreak(.T.)		//Salta a pagina na quebra da secao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 02 -              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,"Titulos",{"TRB","SA1","SA2","SE1","SE2"})
TRCell():New(oSection2,"EA_PREFIXO","SEA",STR0040,,15,,)//"NUM"
TRCell():New(oSection2,"EA_NUM","SEA",STR0041,,15,,)//DUPLIC
TRCell():New(oSection2,"EA_PARCELA","SEA",STR0042,,15,,)//P
//RECEBER
TRCell():New(oSection2,"E1_CLIENTE"	,"SE1",STR0043,,TamSx3("E1_CLIENTE"	)[1],,)//CODIGO
TRCell():New(oSection2,"A1_NOME"	,"SA1",STR0044,,TamSx3("A1_NOME"	)[1],,)//RAZAO SOCIAL
TRCell():New(oSection2,"E1_VENCTO"	,"SE1",STR0045,PesqPict("SE1","E1_VENCTO"),10,,)//VENCTO

// PAGAR
TRCell():New(oSection2,"E2_FORNECE"	,"SE2",STR0043,,TamSx3("E2_FORNECE"	)[1],,)//CODIGO
TRCell():New(oSection2,"A2_NOME"	,"SA2",STR0044,,TamSx3("A2_NOME"	)[1],,)//RAZAO SOCIAL
TRCell():New(oSection2,"E2_VENCTO"	,"SE2",STR0045,PesqPict("SE2","E2_VENCTO"),10,,)//VENCTO

TRCell():New(oSection2,"VALOR","",STR0046,cPictTit,TamSx3("E2_VALOR")[1],/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT") //VALOR

oSection2:SetNoFilter({"TRB","SA1","SA2","SE1","SE2"})
oSection2:SetTotalText("")


Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³+ ºAutor ³Marcel Borges Ferreira ºData ³    /  /     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime o objeto oReport definido na funcao ReportDef.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto TReport do relatorio                           º±±
±±º          ³                                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)

Local nOpca := 0
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cAliasQry := "TRB"
Local cFilialSEA
Local cTableDel
Local cSE
Local cSA
Local cPrefixo
Local cNum
Local cParcela
Local cTipo
Local cCampos
Local cComple1 := Space(79)
Local cComple2 := Space(79)
Local cComple3 := Space(79)
Local cLayoutSM0 := FWSM0Layout()
Local lGestao	 := Substr(cLayoutSM0,1,1) $ "E|U"
Local aSelFil	:= {}
Local cTmpSEAFil:= ""
Local cFilSub	:= ""
Local lAutomato := FunName() == "RPC"
Local cVldFilSA6 := ""
Local cVldFilSA := ""
Local cModoSEA	:= FWModeAccess("SEA",1)+FWModeAccess("SEA",2)+FWModeAccess("SEA",3)
Local cModoSA6	:= FWModeAccess("SA6",1)+FWModeAccess("SA6",2)+FWModeAccess("SA6",3)
Local cModoSA12	:= ""
Local cCondBco	:= ""
Local cTipoCheq := Iif(Type("MVCHEQUES") == 'C', MVCHEQUES, MVCHEQUE)
Local nCasDec   := 2 
Local lTemplate := .F.
Local oObjAb    := Nil
Local lFinTotAb := FindFunction("FinTotAb")
Local lPccBaix  := SuperGetMv("MV_BX10925", .F., "2") == "1"
Local lIssBaix  := SuperGetMv("MV_MRETISS",.F.,"1") == "2"	
Local lBtrISS   := SE2->(ColumnPos("E2_BTRISS")) > 0 .And. SE2->(ColumnPos("E2_VRETBIS")) > 0 .And.;
				  SE2->(ColumnPos("E2_CODSERV")) > 0 .And. FindFunction("ISSCPOM") .And. FindFunction("BtrISSMun")
Local oObjMovBx := Nil
Local cFilOrig := ""

_lVerFil := .F.
//Caso nao seja informada nenhuma moeda, considerar moeda 1
If mv_par07 == 0
	mv_par07 := 1
Endif	
If MV_PAR01==1
	oSection1:Cell(STR0021):Disable()
	oSection1:Cell(STR0022):Disable()
	oSection2:Cell("E2_FORNECE"):Disable()
	oSection2:Cell("A2_NOME"):Disable()
	oSection2:Cell("E2_VENCTO"):Disable()
	nCasDec := TamSx3("E2_TXMOEDA")[2]
Else
	oSection1:Cell(STR0019):Disable()
	oSection1:Cell(STR0020):Disable()
	oSection2:Cell("E1_CLIENTE"):Disable()
	oSection2:Cell("A1_NOME"):Disable()
	oSection2:Cell("E1_VENCTO"):Disable()
	nCasDec := TamSx3("E1_TXMOEDA")[2]
	lTemplate := cPaisLoc == "BRA" .And. HasTemplate("LOT")
EndIf
If !lAutomato
	If lGestao
		nRegSM0 := SM0->(Recno())
		aSelFil := FwSelectGC()
		SM0->(DbGoTo(nRegSM0))
		Asort(aSelFil)
	Else
		aSelFil := AdmGetFil(.F.,.T.,"SEA")
	EndIf
	If(Empty(aSelFil))
		aSelFil := {cFilAnt}
	EndIf
	
	DEFINE MSDIALOG oDlg FROM  92,70 TO 221,463 TITLE OemToAnsi(STR0009) PIXEL  //  "Mensagem Complementar"
	@ 09, 02 SAY STR0036 SIZE 24, 7 OF oDlg PIXEL  //"Linha 1"
	@ 24, 02 SAY STR0037 SIZE 25, 7 OF oDlg PIXEL  //"Linha 2"
	@ 38, 03 SAY STR0038 SIZE 25, 7 OF oDlg PIXEL  //"Linha 3"
	@ 07, 31 MSGET cComple1 Picture "@S48" SIZE 163, 10 OF oDlg PIXEL
	@ 21, 31 MSGET cComple2 Picture "@S48" SIZE 163, 10 OF oDlg PIXEL
	@ 36, 31 MSGET cComple3 Picture "@S48" SIZE 163, 10 OF oDlg PIXEL
	DEFINE SBUTTON FROM 50, 139 TYPE 1 ENABLE OF oDlg ACTION (nOpca:=1,oDlg:End())
	DEFINE SBUTTON FROM 50, 167 TYPE 2 ENABLE OF oDlg ACTION oDlg:End()
	ACTIVATE MSDIALOG oDlg CENTERED
Else
	nOpca := 1
	aSelFil := {cFilAnt}
EndIf
If nOpca#1
	cComple1 := ""
	cComple2 := ""
	cComple3 := ""
EndIf
cAliasQry := GetNextAlias()
MakeSqlExpr(oReport:uParam)
_lVerFil := Len(aSelFil) > 1
oSection1:BeginQuery()

If _lVerFil
	cFilialSEA := "EA_FILIAL " + GetRngFil( aSelFil, "SEA", .T., @cTmpSEAFil ) + " "
Else
	cFilialSEA := "EA_FILIAL = '" + xFilial("SEA", aSelFil[1]) + "' "
EndIf
cFilialSEA := "%"+cFilialSEA+"%"
cFilSub	   := "SA6B"
cVldFilSA6 := R170SETFIL("SA6", aSelFil, @cFilSub)
//Tratamento para banco compartilhado ou bordero compartilhado e banco exclusivo.
//Para não duplicar na query e imprimir titulos duplicados. 
If cModoSA6 = "CCC" .OR. (cModoSEA == "CCC" .And. cModoSA6 <> cModoSEA)
	cCondBco := "%" + " SA6.R_E_C_N_O_ = 
	cCondBco += "(SELECT MIN(R_E_C_N_O_) FROM "+ RetSqlName("SA6") + " SA6B "
	cCondBco +=		" WHERE SA6B.A6_COD = SEA.EA_PORTADO AND SA6B.A6_AGENCIA = SEA.EA_AGEDEP" 
	cCondBco +=		" AND SA6B.A6_NUMCON = SEA.EA_NUMCON AND "
	cCondBco += cFilSub + " AND SA6B.D_E_L_E_T_ = ' ' ) " + "%"
Else
	cCondBco := "%" + " SA6.A6_COD = SEA.EA_PORTADO " + "%"
Endif
If MV_PAR01 ==1 //Carteira (R/P)
	cTableSE  := "%" + RetSqlName("SE1") + " SE1" + "%"
	cTableSA  := "%" + RetSqlName("SA1") + " SA1" + "%"
	cTableDel := "%" + "SE1.D_E_L_E_T_='' AND SA1.D_E_L_E_T_=''"  + "%" 
	cOrdem    := "%" + "E1_CLIENTE" + "%"
	cCond	  := "%" + "A1_COD = E1_CLIENTE AND " 
	cCond     += "A1_LOJA = E1_LOJA " 
	cSE       := "E1_"
	cSA       := "%" + "A1_NOME, SA1.R_E_C_N_O_ CLIFORRECN" + "%"
	cCampos   := "%" + "E1_CLIENTE, E1_LOJA, E1_VENCTO, E1_MOEDA, SE1.R_E_C_N_O_ TITNRECNO" + "%"
	cCart     := "R"	 
	cModoSA12 := FWModeAccess("SA1",1)+FWModeAccess("SA1",2)+FWModeAccess("SA1",3)
	cFilSub	  := "SA1B"
	cVldFilSA := R170SETFIL("SA1", aSelFil, @cFilSub)
	If cModoSA12 = "CCC" .OR. (cModoSEA == "CCC" .And. cModoSA12 <> cModoSEA)
		cCond += "AND SA1.R_E_C_N_O_ = 
		cCond += "(SELECT MIN(R_E_C_N_O_) FROM "+ RetSqlName("SA1") + " SA1B "
		cCond +=		"WHERE SA1B.A1_COD = SE1.E1_CLIENTE AND SA1B.A1_LOJA = SE1.E1_LOJA AND " 
		cCond += cFilSub + " AND SA1B.D_E_L_E_T_ = ' ' ) " + "%"
	Else
		cCond += "%"
	Endif
Else
	cTableSE  := "%" + RetSqlName("SE2") + " SE2" + "%"
	cTableSA  := "%" + RetSqlName("SA2") + " SA2" + "%"
	cTableDel := "%" + "SE2.D_E_L_E_T_ = ' ' AND SA2.D_E_L_E_T_ = ' '" + "%"
	cOrdem    := "%" + "E2_FORNECE" + "%"
	cCond     := "%" + "A2_COD = E2_FORNECE  AND E2_FORNECE = EA_FORNECE AND " 
	cCond     +=  "A2_LOJA = E2_LOJA AND E2_LOJA = EA_LOJA " 
	cSE       := "E2_"
	cSA       := "%" + "A2_NOME, SA2.R_E_C_N_O_ CLIFORRECN" + "%"
	cCampos   := "%" + "E2_FORNECE, E2_LOJA, E2_VENCTO, E2_MOEDA, SE2.R_E_C_N_O_ TITNRECNO" + "%"
	cCart     := "P"
	cModoSA12 := FWModeAccess("SA2",1)+FWModeAccess("SA2",2)+FWModeAccess("SA2",3)
	cFilSub	  := "SA2B"
	cVldFilSA := R170SETFIL("SA2", aSelFil, @cFilSub)
	If cModoSA12 = "CCC" .OR. (cModoSEA == "CCC" .And. cModoSA12 <> cModoSEA)
		cCond += "AND SA2.R_E_C_N_O_ = "
		cCond += "(SELECT MIN(R_E_C_N_O_) FROM "+ RetSqlName("SA2") + " SA2B "
		cCond +=		" WHERE SA2B.A2_COD = SE2.E2_FORNECE AND SA2B.A2_LOJA = SE2.E2_LOJA AND " 
		cCond += cFilSub + " AND SA2B.D_E_L_E_T_ = ' ' ) " + "%"
	Else
		cCond += "%"
	Endif
EndIf

cNumBor    := "%"+cSE+"NUMBOR"+"%"
cPrefixo   := "%"+cSE+"PREFIXO"+"%"
cNum 	   := "%"+cSE+"NUM"+"%"
cParcela   := "%"+cSE+"PARCELA"+"%"
cTipo	   := "%"+cSE+"TIPO"+"%"
cFilOrig   := "%"+cSE+"FILORIG"+"%"

BeginSql Alias cAliasQry
	SELECT DISTINCT EA_NUMBOR, EA_PREFIXO, EA_NUM, EA_PARCELA, EA_FILIAL, EA_PORTADO, EA_AGEDEP, EA_NUMCON, EA_DATABOR,   
		A6_COD, A6_NOME,A6_AGENCIA, A6_BAIRRO, A6_MUN, A6_EST, %Exp:cSA%,
		%Exp:cCampos%
	FROM %table:SEA% SEA
		INNER JOIN %table:SA6% SA6
		ON %exp:cVldFilSA6% AND SA6.A6_COD = SEA.EA_PORTADO
			AND SA6.A6_AGENCIA = SEA.EA_AGEDEP AND SA6.A6_NUMCON = SEA.EA_NUMCON AND %Exp:cCondBco% 			
		INNER JOIN %Exp:cTableSE%
		ON  EA_FILORIG = %Exp:cFilOrig% AND EA_NUMBOR = %Exp:cNumbor% AND EA_PREFIXO = %Exp:cPrefixo%  AND EA_NUM = %Exp:cNum% AND EA_PARCELA = %Exp:cParcela%
			AND EA_TIPO = %Exp:cTipo%
		INNER JOIN %Exp:cTableSA% 
		ON %exp:cVldFilSA% AND %exp:cCond% 
	WHERE %Exp:cFilialSEA% AND
		EA_NUMBOR BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03% AND
		EA_CART = %Exp:cCart% AND
		SEA.%NotDel% AND SA6.%NotDel% AND %Exp:cTableDel%
	ORDER BY EA_NUMBOR, EA_PREFIXO, EA_NUM, EA_PARCELA, %Exp:cOrdem%
EndSql
oSection1:EndQuery()
If mv_par01 == 1
	TRPosition():New(oSection2, "SA1", 1, {|| SA1->(DbGoTo((cAliasQry)->CLIFORRECN))}, .F.)
	TRPosition():New(oSection2, "SE1", 1, {|| SE1->(DbGoTo((cAliasQry)->TITNRECNO))}, .F.)
Else
	TRPosition():New(oSection2, "SA2", 1, {|| SA2->(DbGoTo((cAliasQry)->CLIFORRECN))}, .F.)
	TRPosition():New(oSection2, "SE2", 1, {|| SE2->(DbGoTo((cAliasQry)->TITNRECNO))}, .F.)
EndIf
oSection2:SetParentQuery( .T. )
oSection2:SetParentFilter({|cParam| (cAliasQry)->EA_NUMBOR = cParam},{|| (cAliasQry)->EA_NUMBOR})
oSection1:Cell("Linha complementar"+" 1"):SetBlock({||cComple1})
oSection1:Cell("Linha complementar"+" 2"):SetBlock({||cComple2})
oSection1:Cell("Linha complementar"+" 3"):SetBlock({||cComple3})
oSection2:Cell("VALOR"):SetBlock({|| R170ValorTit( (cAliasQry)->TITNRECNO, cTipoCheq, nCasDec, lTemplate, @oObjAb, lFinTotAb,;
lPccBaix, lIssBaix, lBtrISS, @oObjMovBx) })
//Totalizadores
If mv_par01==1
	oSection2:SetLineCondition({||(mv_par08 == 1 .OR. (mv_par08 == 2 .AND. (cAliasQRY)->E1_MOEDA = mv_par07))})
	TRFunction():New(oSection2:Cell("VALOR"),/*"oTotal"*/ ,"SUM", /*oBreak */,STR0047,/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)
	TRFunction():New(oSection2:Cell("VALOR"),/*"oTotal"*/ ,"COUNT", /*oBreak */,STR0049,/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)
Else
	oSection2:SetLineCondition({||(mv_par08 == 1 .OR. (mv_par08 == 2 .AND. (cAliasQRY)->E2_MOEDA = mv_par07))})
	TRFunction():New(oSection2:Cell("VALOR"),/*"oTotal"*/ ,"SUM", /*oBreak */,STR0048,/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)
	TRFunction():New(oSection2:Cell("VALOR"),/*"oTotal"*/ ,"COUNT", /*oBreak */,STR0049,/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)
EndIf
oReport:OnPageBreak({|| R170Header(oReport)})
If cConta != xFilial("SA6",(cAliasQRY)->EA_FILIAL)+(cAliasQRY)->(EA_PORTADO+EA_AGEDEP+EA_NUMCON)
	SA6->(DbSetOrder(1))
	If SA6->(MsSeek(xFilial("SA6",(cAliasQRY)->EA_FILIAL)+(cAliasQRY)->(EA_PORTADO+EA_AGEDEP+EA_NUMCON)))
		cConta := SA6->(A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON)
	Endif
Endif
oSection1:Print()
If Select("TRB") > 0
	TRB->(dbCloseArea())
	Ferase(cArq+GetDBExtension())      // Elimina arquivos de Trabalho
	Ferase(cArq+OrdBagExt())			  // Elimina arquivos de Trabalho
Endif
If oObjAb != Nil
	oObjAb:Destroy()
	oObjAb := Nil
EndIf
If oObjMovBx != Nil
	oObjMovBx:Destroy()
	oObjMovBx := Nil	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma ³R170Header   ºAutor ³Marcel Borges Ferreira ºData ³   /  /      º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.    ³Monta o cabecalho do relatorio.						                 º±±
±±º         ³ 						                                    	        º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso      ³ 	                                                	           º±±
±±ÈÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R170Header(oReport)
Local cStartPath	:= GetSrvProfString("Startpath","")
Local cLogo			:= cStartPath + "LGRL" + SM0->M0_CODIGO + IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ) + ".BMP" 	// Empresa+Filial

If !File( cLogo )
	cLogo := cStartPath + "LGRL" + SM0->M0_CODIGO + ".BMP"
endif

oReport:SkipLine()
oReport:SkipLine()
oReport:SkipLine()
oReport:FatLine()
oReport:SkipLine()
oReport:SayBitmap (oReport:Row(),005,cLogo,291,057)
oReport:SkipLine()
oReport:SkipLine()
oReport:SkipLine()
oReport:FatLine()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma ³R170ValorTit ºAutor ³Marcel Borges Ferreira ºData ³   /  /      º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.    ³Calcula valor.       						                          º±±
±±º         ³ 						                                    	        º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso      ³ 	                                                	           º±±
±±ÈÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R170ValorTit(nRecno, cTipoCheq, nCasDec, lTemplate, oObjAb, lFinTotAb, lPccBaix, lIssBaix, lBtrISS, oObjMovBx)
	Local nValor    := 0
	Local nAbat     := 0
	Local aAux      := {}	
	Local cTitPai   := ""
	Local cIdDocFK  := ""
	Local nTotalMov := 0
	Local nImpoCalc := 0 
	Local cSE1SE2   := AllTrim("SE"+cValToChar(MV_PAR01))
	
	Default nRecno    := 0
	Default cTipoCheq := ""
	Default nCasDec   := 2
	Default lTemplate := .F.
	Default lFinTotAb := .F.
	Default lPccBaix  := .F.
	Default lIssBaix  := .F. 
	Default lBtrISS   := .F.
	
	(cSE1SE2)->(DbGoto(nRecno))	
	
	If MV_PAR01 == 1
		cTitPai := SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)
		
		If cPaisLoc != "BRA" .And. SE1->E1_TIPO $ cTipoCheq
			nValor := xMoeda(SE1->(E1_VALOR+E1_SDACRES-E1_SDDECRE), SE1->E1_MOEDA, mv_par07, dDataBase, nCasDec)
			
			If mv_par07 == 1 .And. dDatabase != SE1->E1_EMIS1
				nValor := (SE1->E1_VALOR * SE1->E1_TXMOEDA + SE1->E1_SDACRES-SE1->E1_SDDECRE)
			EndIf
		Else			
			cIdDocFK  := FINBuscaFK7(SE1->(E1_FILIAL+"|"+E1_PREFIXO+"|"+E1_NUM+"|"+E1_PARCELA+"|"+E1_TIPO+"|"+E1_CLIENTE+"|"+E1_LOJA), cSE1SE2)			
			nTotalMov := FinVlrMov(SE1->E1_FILORIG, DTOS(SE1->E1_DATABOR), cIdDocFK, @oObjMovBx, nCasDec)
			
			If nTotalMov == 0 .And. SE1->E1_SALDO > 0 .And. SE1->E1_SALDO != SE1->E1_VALOR .And. !Empty(SE1->E1_BAIXA)
				nValor := SE1->(E1_SALDO+E1_SDACRES) - SE1->E1_SDDECRE
			Else
				nValor := (SE1->(E1_VALOR+E1_ACRESC) - SE1->E1_DECRESC)
			EndIf			
			
			If SE1->E1_MOEDA != mv_par07 .And. mv_par07 > 0 
				nValor := xMoeda(nValor, SE1->E1_MOEDA, mv_par07, SE1->E1_EMISSAO, nCasDec, SE1->E1_TXMOEDA)
			EndIf
		EndIf
		
		If lFinTotAb
			nAbat := FinTotAb("SE1", cTitPai, SE1->E1_FILORIG, MV_PAR07, dDataBase, nCasDec, @oObjAb, MVABATIM, "|")
		EndIf
		
		//Template GEM
		If lTemplate .And. !Empty(SE1->E1_NCONTR)
			aAux := ExecTemplate("CMDtPrc",.F.,.F.,{SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_VENCTO, SE1->E1_VENCTO})
			nValor += aAux[2] + aAux[3]
		EndIf
	Else
		cTitPai := SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)
		
		If cPaisLoc != "BRA" .And. SE2->E2_TIPO $ cTipoCheq
			nValor := xMoeda((SE2->(E2_VALOR+E2_SDACRES) - SE2->E2_SDDECRE), SE2->E2_MOEDA, mv_par07, dDataBase, nCasDec)
			
			If dDatabase <> SE1->E1_EMIS1.and. mv_par07=1
				nValor:= (SE1->E1_VALOR * SE1->E1_TXMOEDA+SE1->E1_SDACRES-SE1->E1_SDDECRE)
			EndIf
		Else
			cIdDocFK := FINBuscaFK7(SE2->(E2_FILIAL+"|"+E2_PREFIXO+"|"+E2_NUM+"|"+E2_PARCELA+"|"+E2_TIPO+"|"+E2_FORNECE+"|"+E2_LOJA), "SE2")			
			nTotalMov := FinVlrMov(SE2->E2_FILORIG, DTOS(SE2->E2_DTBORDE), cIdDocFK, @oObjMovBx, nCasDec)						
						
			If nTotalMov == 0 .And. SE2->E2_SALDO > 0 .And. SE2->E2_SALDO != SE2->E2_VALOR .And. !Empty(SE2->E2_BAIXA)
				nValor := SE2->(E2_SALDO+E2_SDACRES) - SE2->E2_SDDECRE
			Else
				nValor := (SE2->(E2_VALOR+E2_ACRESC) - SE2->E2_DECRESC)
			EndIf
			
			If SE2->E2_MOEDA != mv_par07 .And. mv_par07 > 0 
				nValor := xMoeda(nValor, SE2->E2_MOEDA, mv_par07, SE2->E2_EMISSAO, nCasDec, SE2->E2_TXMOEDA)
			EndIf			
			
			//Total de impostos calculado, previsão de retenção.
			If !SE2->E2_TIPO $ MVPAGANT
				If lPccBaix .And. SE2->(E2_PIS+E2_COFINS+E2_CSLL) > 0 
					nImpoCalc += (SE2->(E2_PIS+E2_COFINS+E2_CSLL) - SE2->(E2_VRETPIS+E2_VRETCOF+E2_VRETCSL))
				EndIf
				
				If (lIrfBaix := (SE2->E2_IRRF > 0 .And. SA2->(Dbseek(xFilial("SA2")+SE2->(E2_FORNECE+E2_LOJA))) .And. SA2->A2_CALCIRF == "2"))					
					If (Posicione("SED", 1, xFilial("SED", SE2->E2_FILORIG) + SE2->(E2_NATUREZ), "ED_CALCIRF") == "S")
						nImpoCalc += SE2->(E2_IRRF - E2_VRETIRF)
					EndIf
				EndIf
				
				If lIssBaix .And. SE2->E2_ISS > 0
					nImpoCalc += SE2->(E2_ISS - E2_VRETISS)
					
					If lBtrISS .And. SE2->(E2_ISS != E2_VRETISS)						
					 	nImpoCalc += SE2->E2_VRETBIS
					 EndIf
				EndIf
			EndIf
		EndIf
		
		If lFinTotAb
			nAbat := FinTotAb("SE2", cTitPai, SE2->E2_FILORIG, MV_PAR07, dDataBase, nCasDec, @oObjAb, MVABATIM, "|")
		EndIf
	Endif
	
	nValor -= (nTotalMov+nImpoCalc+nAbat)
Return nValor


//-------------------------------------
/*/{Protheus.doc}R170SETFIL
Monta trecho de validacao referente as 
filiais das tabelas SA6 e SA2/SA1 com a 
tabela SEA, para tratar compartilhamentos.

@author Vinicius do Prado
@since  12/09/2019
@version 12
/*/
//-------------------------------------
Static function R170SETFIL(cAlias as Char, aSelFil as Array, cFilSub as Char) as Character

	Local cValFil 	 as Char
	Local cSE     	 as Char
	Local cBDname    as Char
	Local cSubs      as Char
	Local cTmpFil    as Char
	Local cIsNull	 as Char
	Local nTamSEA 	 as Numeric 
	Local nTamALIAS	 as Numeric
	Local nTamFilSEA as Numeric
	Local nTamFilAli as Numeric
	Local nTamanho	 as Numeric

	Default cAlias	:= "SA6"
	Default aSelFil	:= {cFilAnt}
	Default cFilSub	:= ""

	cSE     	:= "1"
	cValFil 	:= ""
	cTmpFil		:= ""
	nTamSEA 	:= TAMSX3("EA_FILIAL")[1]
	nTamALIAS	:= Len(xFilial(cAlias))
	cBDname  	:= Upper( TCGetDB() )
	cSubs   	:= "SUBSTR"
	nTamFilSEA	:= Len(Alltrim(xFilial("SEA")))
	nTamFilAli	:= Len(Alltrim(xFilial(cAlias)))
	
	If cAlias == "SA2"
		cSE := "2"
	ElseIf cAlias == "SA6"
		cSE := "6"
	EndIf

	If cBDname $ "ORACLE"
		cIsNull := "NVL"
	ElseIf cBDname $ "POSTGRES"
		cIsNull := "COALESCE"
	Else
		cIsNull := "ISNULL"
		cSubs   := "SUBSTRING"
	EndIf

	cValFil := "% "

	If nTamFilSEA <> nTamFilAli

		If nTamFilAli <> 0
			If nTamFilAli > nTamFilSEA
				nTamanho	:= nTamFilSEA
			ElseIf nTamFilAli < nTamFilSEA
				nTamanho	:= nTamFilAli
			EndIf
			
			If cAlias == "SA6"
				cValFil  += cIsNull + "("+cSubs + "("+cAlias+".A"+cSE+"_FILIAL, 1,"+cValToChar(nTamanho)+"),'"+ Space(nTamSEA) +"') = "
				cValFil  += cIsNull + "("+ cSubs +" (SEA.EA_FILIAL ,1 ," + cValToChar(nTamanho)+"),'" + Space(nTamSEA) + "') "
			Else
				If FWModeAccess(cAlias) == "E"
					cValFil  += cAlias+".A"+cSE+"_FILIAL = SEA.EA_FILORIG "
				Else
					cValFil  += cIsNull + "("+cSubs + "("+cAlias+".A"+cSE+"_FILIAL, 1,"+cValToChar(nTamanho)+"),'"+ Space(nTamSEA) +"') = "
					cValFil  += cIsNull + "("+ cSubs +" (SEA.EA_FILORIG ,1 ," + cValToChar(nTamanho)+"),'" + Space(nTamSEA) + "') "
				EndIf
			EndIf
		Else
			cValFil += cAlias+".A"+cSE+"_FILIAL = '"+ Space(nTamSEA) +"' "
		EndIf
	Else
		// Para o mesmo nivel de compartilhamento
		cValFil  += cAlias+".A"+cSE+"_FILIAL =  SEA.EA_FILIAL "
	EndIf

	If !Empty(cFilSub)
		cFilSub  := StrTran(cValFil,cAlias,cFilSub)
		cFilSub  := StrTran(cFilSub,"%","")
	EndIf

	cValFil += "%"

Return cValFil

//------------------------------------
/*/{Protheus.doc} FinVlrMov
Busca o total de movimento baixado, antes 
da geração do borderÔ

@author Sivaldo Oliveira
@since 15/04/2021
@version P12
/*/
//------------------------------------
Static Function FinVlrMov(cFilOrig As Char, cDataBord As Char, cIdDocFK As Char, oObjMovBx As Object, nCasDec As Numeric) As Numeric
	Local nTotalMov As Numeric
	Local nVlrMov   As Numeric
	Local nTaxaPart As Numeric
	Local nMoeda	As Numeric
	Local cQuery    As Char
	Local cTblTmp   As Char
	Local cTblFK    As Char
	
	Default cFilOrig  := cFilAnt
	Default cDataBord := ""
	Default cIdDocFK  := ""	
	Default oObjMovBx := Nil 
	Default nCasDec   := 2
	
	//Inicializa variáveis.
	nTotalMov := 0
	
	If !Empty(cIdDocFK) .And. !Empty(cDataBord)
		nTotalMov := 0
		nVlrMov   := 0
		nTaxaPart := 0
		cQuery    := ""
		cTblTmp   := ""		
		cTblFK    := ""
		
		If oObjMovBx == Nil
			cTblFK := RetSqlName("FK" + cValTochar(MV_PAR01))
			
			If MV_PAR01 == 2
				cQuery := "SELECT FK2.FK2_VALOR VALOR, FK2.FK2_MOEDA MOEDA, FK2.FK2_TXMOED TXMOEDA, "
				cQuery += "FK2.FK2_DATA DATABX FROM " + cTblFK + " FK2 WHERE "
				cQuery += "FK2.FK2_IDDOC = ? AND FK2.FK2_FILORI = ? AND FK2.FK2_DATA < ? "
				cQuery += "AND FK2.FK2_MOTBX NOT IN ('PCC', 'IRF', 'ISS', 'IMR') "
				cQuery += "AND FK2.FK2_TPDOC NOT IN ('DC','JR','MT','CM','D2','J2','M2','V2','C2','TL', 'I2','EI','VA') "
				cQuery += "AND FK2.D_E_L_E_T_ = ' ' AND FK2.FK2_SEQ NOT IN (SELECT FK2EST.FK2_SEQ FROM " 
				cQuery += cTblFK + " FK2EST WHERE "
				cQuery += "FK2EST.FK2_IDDOC = ? AND FK2EST.FK2_FILORI = ? AND FK2EST.FK2_DATA < ? "
				cQuery += "AND FK2EST.FK2_MOTBX NOT IN ('PCC', 'IRF', 'ISS', 'IMR') "
				cQuery += "AND FK2EST.D_E_L_E_T_ = ' ' AND FK2EST.FK2_TPDOC = 'ES') "
			Else
				cQuery := "SELECT FK1.FK1_VALOR VALOR, FK1.FK1_MOEDA MOEDA, FK1.FK1_TXMOED TXMOEDA, "
				cQuery += "FK1.FK1_DATA DATABX FROM " + cTblFK + " FK1 WHERE "
				cQuery += "FK1.FK1_IDDOC = ? AND FK1.FK1_FILORI = ? AND FK1.FK1_DATA < ? "
				cQuery += "AND FK1.FK1_MOTBX NOT IN ('PCC', 'IRF', 'ISS', 'IMR') "
				cQuery += "AND FK1.FK1_TPDOC NOT IN ('DC','JR','MT','CM','D2','J2','M2','V2','C2','TL', 'I2','EI','VA') "
				cQuery += "AND FK1.D_E_L_E_T_ = ' ' AND FK1.FK1_SEQ NOT IN (SELECT FK1EST.FK1_SEQ FROM " 
				cQuery += cTblFK + " FK1EST WHERE "
				cQuery += "FK1EST.FK1_IDDOC = ? AND FK1EST.FK1_FILORI = ? AND FK1EST.FK1_DATA < ? "
				cQuery += "AND FK1EST.FK1_MOTBX NOT IN ('PCC', 'IRF', 'ISS', 'IMR') "
				cQuery += "AND FK1EST.D_E_L_E_T_ = ' ' AND FK1EST.FK1_TPDOC = 'ES') "
			EndIf
			
			cQuery    := ChangeQuery(cQuery)
			oObjMovBx := FWPreparedStatement():New(cQuery)		
		EndIf
		
		oObjMovBx:SetString(1, cIdDocFK)
		oObjMovBx:SetString(2, cFilOrig)
		oObjMovBx:SetString(3, cDataBord)
		oObjMovBx:SetString(4, cIdDocFK)
		oObjMovBx:SetString(5, cFilOrig)
		oObjMovBx:SetString(6, cDataBord)		
		cQuery  := oObjMovBx:GetFixQuery()

		cTblTmp := MpSysOpenQuery(cQuery)
		
		While !(cTblTmp)->(Eof())
			nVlrMov := (cTblTmp)->VALOR
			
			If mv_par07 > 0 .And. (nMoeda := Val((cTblTmp)->MOEDA)) != mv_par07
				nTaxaPart := Iif(nMoeda == 0, 1, (cTblTmp)->TXMOEDA)
				nVlrMov := Round(xMoeda(nVlrMov, nMoeda, mv_par07, STOD((cTblTmp)->DATABX), nCasDec, nTaxaPart), 2)
			EndIf
			
			nTotalMov += nVlrMov
			(cTblTmp)->(DbSkip())
		EndDo
		
		(cTblTmp)->(DbCloseArea())	
	EndIf
Return nTotalMov
