/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "FINR895.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR895      ³Autor ³ Mauricio Pequim Jr   ³Data³ 18.08.05   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio para verificacao da retencao de impostos PCC       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Manutencao Efetuada                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR895(lProcessou)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := STR0001 //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := STR0002 //"/Demonstra Retencoes PCC de acordo com os parametros informaDos pelo usuario."
Local cDesc3         := STR0003 //"Relatorio Demonstrativo das Retencoes PCC"
Local cPict          := " "
Local nLin           := 80

Local Cabec1         := STR0004 //" Pref. Numero    Pc. Tipo Bordero  Dt Bord.   Dt Baixa       Valor PIS       Valor COF      Valor CSL      Ret. PIS       Ret. COF       Ret. CSL       Base PCC  Processo Verif. PCC"
Local Cabec2         := " "
Local imprime        := .T.
Local aPergunta      := {}
Private Titulo       := STR0005 //"Rel. Demonstrativo Pis, Cofins, Csll"

Private Titulo0      := STR0015 //"Rel. Demonstrativo Pis, Cofins, Csll (Filiais selecionadas para o relatorio)"

Private aOrd			:= {}
private aCampos      := {}
private cNomArq      := ""
Private lAbortPrint  := .F.
Private limite       := 80
Private tamanho      := "G"
Private nomeprog     := "FINR895"
Private nTipo        := 18
Private aReturn      := { STR0006, 1, STR0007, 2, 2, 1, "", 1} //"ZebraDo"###"Administracao"
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private wnrel        := "FINR895"
Private cString      := "SE2"
Private cPerg        := "FIR895"
Private m_pag        := 01
private cArqTRB      := " "

DEFAULT lProcessou := .F.

Pergunte("FIR895",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
EndIf

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CONOUT("FINR895 | "+ALLTRIM(STR(ThreadId())) +" Start Time "+Time()+" "+ALLTRIM(STR(Seconds())))
RptStatus({|| FINR895Rpt(Cabec1,Cabec2,Titulo,Titulo0,nLin,@lProcessou) },Titulo)
CONOUT("FINR895 | "+ALLTRIM(STR(ThreadId())) +" End Time "+Time()+" "+ALLTRIM(STR(Seconds())))
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR875Rpt   ³Autor ³ Cristiano Denardi    ³Data³ 02.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento do relatorio								           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FINR895Rpt(Cabec1,Cabec2,Titulo,Titulo0,nLin,lProcessou)

Local nPIS 			:= 0
Local nCOF 			:= 0
Local nCSL 			:= 0
Local nPISRet		:= 0
Local nCOFRet		:= 0
Local nCSLRet		:= 0
Local nBase		:= 0
Local nTotPIS		:= 0
Local nTotCOF		:= 0
Local nTotCSL		:= 0
Local nTotPISRet	:= 0
Local nTotCOFRet	:= 0
Local nTotCSLRet	:= 0
Local lFina374		:= IsInCallStack("FINA374")
Local aArqs		:= {}
Local cFilterUser := aReturn[7]

Local aAreaSM0
Local lGestao   := ( FWSizeFilial() > 2 )
Local lSE2Excl  := Iif( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
Local aSM0 := {}
Local aFilAux 	:= {} 
Local aSelFil := {}
Local nC := 0
Local lPrtFil := .T.
Local cFilialAtu := cFilAnt

Local cCabA := ""
Local cCabB := ""
Local cCabC := ""
Local cCabD := ""
Local nCabA := 0
Local nCabB := 0
Local nCabC := 0
Local nCabD := 0

Local Cabec0 := ""

Local aPergunte		As Array
Local oFwSX1Util    As Object
Local lConsPA       As Logical

//Proteção para dicionário (novo pergunte)
oFwSX1Util:= FwSX1Util():New()
oFwSX1Util:AddGroup(cPerg)
oFwSX1Util:SearchGroup()
aPergunte := oFwSX1Util:GetGroup(cPerg)
lConsPA   := .T.

If Len(aPergunte) > 1 .And. Len(aPergunte[2]) >= 6 .And. Upper(AllTrim(aPergunte[2][6]:CX1_VAR01)) == "MV_PAR06"
	If MV_PAR06 == 2
		lConsPA := .F.
	EndIf
EndIf

Titulo := Alltrim(Titulo)+" - Mes: "+ STRZERO(mv_par01,2) +" Ano: "+ STRZERO(mv_par02,4)

If mv_par05 == 1
	If lSE2Excl
		aAreaSM0 := SM0->(GetArea())
		If lGestao .And. FindFunction("AdmSelecFil") 
			AdmSelecFil("FIR895",05,.F.,@aSelFil,"SE2",.F.)
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SE2")
		Endif
		RestArea(aAreaSM0)

		If Empty( aSelFil )
			aAdd( aSelFil , cFilAnt )
	Endif
	Else
		mv_par05 := 2
	EndIf
Endif

	If mv_par05 == 1
		aSort(aSelFil)
		aSM0 := FWLoadSM0()
		nTamEmp := Len(FWSM0LayOut(,1))
		nTamUnNeg := Len(FWSM0LayOut(,2))
	cCabA := PadR(STR0014,Max(Len(STR0014),20) + 1) //"Código"
	cCabB := PadR(STR0017,Max(Len(STR0017),60) + 1) //"Empresa"
	cCabC := PadR(STR0018,Max(Len(STR0018),60) + 1) //"Unidade de Negócio"
	cCabD := PadR(STR0019,Max(Len(STR0019),60) + 1) //"Filial"
		nCabA := Len(cCabA)
	nCabB := nCabA + Len(cCabB)
	nCabC := nCabB + Len(cCabC)
	nCabD := nCabC + Len(cCabD)
		Cabec0 := cCabA+cCabB+cCabC+cCabD
		For nC := 1 To Len(aSelFil)
			If nLin > 58
				nLin := cabec(titulo0,Cabec0,"",nomeprog,tamanho,GetMv("MV_COMP"))
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
	If aScan( aFilAux , xFilial( "SE2" ) ) > 0
		Loop
	EndIf

nPIS 			:= 0
nCOF 			:= 0
nCSL 			:= 0
nPISRet		:= 0
nCOFRet		:= 0
nCSLRet		:= 0
nBase		:= 0
nTotPIS		:= 0
nTotCOF		:= 0
nTotCSL		:= 0
nTotPISRet	:= 0
nTotCOFRet	:= 0
nTotCSLRet	:= 0
aArqs		:= {}
lProcessou := .F.
lPrtFil := .T.

If Select("TMP") > 0
	TMP->(dbCloseArea())
EndIf

If !lProcessou
	aArqs := F374TRB(@lProcessou,,lConsPA)
Endif

dbSelectArea("TRB")

While ! TRB->(Eof())
	If lPrtFil .And. mv_par05 == 1
		If nLin > 58
			CtCGCCabec(,,,Cabec1,Cabec2,ddatabase,Titulo,,"2",Tamanho)
			nLin = 10
		EndIF
		nLin++
		@ nLin, 000 Psay STR0016 + cFilAnt
		nLin++
		lPrtFil := .F.
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ VerIfica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 Psay STR0009 //"*** CANCELADO PELO OPERADOR ***"
		Exit
	EndIf



	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao Do cabecalho Do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLin > 58
		CtCGCCabec(,,,Cabec1,Cabec2,ddatabase,Titulo,,"2",Tamanho)
		nLin = 10
	Else
		nLin := nLin + 3
		@ nLin, 000 Psay __PrtFatLine()
		nLin++
	EndIf

	cFornAtu	:= TRB->(FORNECE+LOJA)
	cDadosForn := TRB->FORNECE+"-"+TRB->LOJA+" - "+TRB->NOME

	@nLin,001 Psay STR0012 + cDadosForn   //"Fornecedor : "
	nLin := nLin + 2
	@ nLin, 000 Psay __PrtThinLine()
	nLin++

	While ! TRB->(Eof()) .and. TRB->(FORNECE+LOJA) == cFornAtu

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilterUser)
			dbSelectArea("SE2")
			dbGoto(TRB->RECSE2)
			If !(&cFilterUser)
				TRB->(dbSkip())
				Loop
			EndIf
		EndIf

		//" Pref. Numero    Pc. Tipo Bordero  Dt Bord.   Dt Baixa       Valor PIS       Valor COF      Valor CSL       Ret. PIS       Ret. COF       Ret. CSL       Base PCC  Processo Verif. PCC"
		//           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
		// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

		@nLin,001 Psay TRB->PREFIXO
		@nLin,007 Psay TRB->NUM
		@nLin,017 Psay TRB->PARCELA
		@nLin,021 Psay TRB->TIPO
		@nLin,027 Psay TRB->BORDERO
		@nLin,038 Psay TRB->DTBORD
		@nLin,052 Psay TRB->BAIXA
		@nLin,063 Psay TRB->PIS Picture TM(TRB->PIS,14,2)
		@nLin,079 Psay TRB->COF Picture TM(TRB->COF,14,2)
		@nLin,093 Psay TRB->CSL Picture TM(TRB->CSL,14,2)
		@nLin,109 Psay TRB->PISRET Picture TM(TRB->PISRET,14,2)
		@nLin,123 Psay TRB->COFRET Picture TM(TRB->COFRET,14,2)
		@nLin,139 Psay TRB->CSLRET Picture TM(TRB->CSLRET,14,2)
		@nLin,156 Psay TRB->BASEPCC Picture TM(TRB->BASEPCC,14,2)
		//Para titulos gerados pela rotina de verificacao de PCC (FINA374)
		//Informo o processo, a data do processo e se o titulo ainda esta pendente de compensacao ou pagamento
	 	If TRB->TIPO $ MVTAXA+"#"+MVTXA
			@nLin,173 Psay TRB->PROCPCC+" - "+DTOC(TRB->DTPRPCC)+" "+IF(TRB->TIPO $ MVTXA .and. TRB->SALDO > 0,"**"," ")
		Endif

		nPIS 	+= TRB->PIS
		nCOF 	+= TRB->COF
		nCSL 	+= TRB->CSL
		nPISRet	+= TRB->PISRET
		nCOFRet	+= TRB->COFRET
		nCSLRet	+= TRB->CSLRET
		nBase	+= TRB->BASEPCC

		nLin++ // Avanca a linha de impressao
		If nLin > 58
			CtCGCCabec(,,,Cabec1,Cabec2,ddatabase,Titulo,,"2",Tamanho)
			nLin = 10
			@nLin,001 Psay STR0012 +cDadosForn+ STR0013 //"Fornecedor : "###" (continuação...)
			nLin := nLin + 2
		EndIf
		dbselectarea("TRB")
		dbSkip() // Avanca o ponteiro Do registro no arquivo
	Enddo
	If nLin != 80

		nLin++

		If nLin > 58
			CtCGCCabec(,,,Cabec1,Cabec2,ddatabase,Titulo,,"2",Tamanho)
			nLin = 10
			nLin := nLin + 2
		EndIf

		@ nLin, 000 Psay __PrtThinLine()

		nLin++

		@nLin, 001 Psay STR0010 + cDadosForn //"Total --> "
		@nLin,063 Psay nPIS Picture TM(nPIS,14,2)
		@nLin,079 Psay nCOF Picture TM(nCOF,14,2)
		@nLin,093 Psay nCSL Picture TM(nCSL,14,2)
		@nLin,109 Psay nPISRET Picture TM(nPISRET,14,2)
		@nLin,123 Psay nCOFRET Picture TM(nCOFRET,14,2)
		@nLin,139 Psay nCSLRET Picture TM(nCSLRET,14,2)
		@nLin,156 Psay nBASE Picture TM(nBASE,14,2)

		nTotPIS	 	+= nPis
		nTotCOF	 	+= nCof
		nTotCSL	 	+= nCsl
		nTotPISRet	+= nPisRet
		nTotCOFRet	+= nCofRet
		nTotCSLRet	+= nCslRet
		nPIS 			:= 0
		nCOF 			:= 0
		nCSL 			:= 0
		nPISRet		:= 0
		nCOFRet		:= 0
		nCSLRet		:= 0
		nBase			:= 0
	EndIf
Enddo

If nLin != 80

	nLin := nLin + 2

	If nLin > 58
		CtCGCCabec(,,,Cabec1,Cabec2,ddatabase,Titulo,,"2",Tamanho)
		nLin = 10
		nLin := nLin + 2
	EndIf

	@ nLin, 000 Psay __PrtFATLine()
	nLin++
	@ nLin, 010 Psay STR0011  //"Total Geral: "
	@nLin,063 Psay nTotPis Picture TM(nTOTPIS,14,2)
	@nLin,078 Psay nTotCof Picture TM(nTOTCOF,14,2)
	@nLin,093 Psay nTotCsl Picture TM(nTOTCSL,14,2)
	@nLin,109 Psay nTotPisRet Picture TM(nTOTPISRET,14,2)
	@nLin,123 Psay nTotCofRet Picture TM(nTOTCOFRET,14,2)
	@nLin,139 Psay nTotCslRet Picture TM(nTOTCSLRET,14,2)

	nLin++
	@nLin,000 Psay __PrtFATLine()
	nLin+= 2
	@nLin,000 Psay "** Titulos ainda pendentes de regularizacao (compensacao)"

	Roda(cbcont,cbtxt,tamanho)

EndIf

If !lFina374
	dbSelectArea("TRB")
	dbCloseArea()
	fErase(aArqs[1]+GetDBExtension())
	fErase(aArqs[1]+OrdbagExt())

	dbSelectArea("TRB2")
	dbCloseArea()
	fErase(aArqs[2]+GetDBExtension())
	fErase(aArqs[2]+OrdbagExt())
Endif

nLin := 80

Next

cFilAnt := cFilialAtu

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao Do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Set Device To Screen

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciaDor de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	Ourspool(wnrel)
Endif
MS_FLUSH()

Return
