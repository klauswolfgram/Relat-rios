/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR071.CH"
#Include "Protheus.ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

// TRADUCAO DE CH'S PARA PORTUGAL - 21/07/08
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR071    ³ Autor ³ Wagner Xavier          ³ Data ³ 09.03.06³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Posi‡„o Valorizada dos Bens Reatroativa                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR071                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR071()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cString := "SN4"
LOCAL cDesc1    := OemToAnsi(STR0001) // "Este programa ir  emitir a posi‡„o valorizada dos"
LOCAL cDesc2    := OemToAnsi(STR0002) //"bens em ate 5 (cinco) moedas."
LOCAL cDesc3    := ""
LOCAL wnrel

PRIVATE aReturn  := { OemToAnsi(STR0014), 1,OemToAnsi(STR0015), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE aLinha   := { }
PRIVATE cPerg    := "AFR071"
PRIVATE nomeprog := "ATFR071"
PRIVATE nLastKey := 0
PRIVATE tamanho   := "G"

PRIVATE titulo    := OemToAnsi(STR0003) //"Posicao Valorizada dos Bens"
PRIVATE cabec1
PRIVATE cabec2

PRIVATE cQuebra1 := " .t. ", cQuebra2 := " .t. "
PRIVATE cCond1   := " .t. "
PRIVATE nOrdem   :=0
PRIVATE nOrder

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte( "AFR071" , .F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01            // Data Conta                           ³
//³ mv_par02            // Ate a Conta                          ³
//³ mv_par03            // Do Centro Custo                      ³
//³ mv_par04            // Ate o Centro Custo                   ³
//³ mv_par05            // Analitico / Sintetico                ³
//³ mv_par06            // Moeda 2 (S/N)                        ³
//³ mv_par07            // Moeda 3 (S/N)                        ³
//³ mv_par08            // Moeda 4 (S/N)                        ³
//³ mv_par09            // Moeda 5 (S/N)                        ³
//³ mv_par10            // Data Base                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "ATFR071"
aOrd  := { OemToAnsi(STR0016), OemToAnsi(STR0017) }   //"Conta"###"C Custo"
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey == 27
	Return
End

SetDefault(aReturn,cString)

nOrdem := aReturn[8]
Titulo := Alltrim(Titulo)
titulo += OemtoAnsi(STR0018)+aOrd[nOrdem] + " - Data de Referência: " + Dtoc(mv_par10)

IF nOrdem == 1
	cabec1 :=OemToAnsi(STR0004) //"C. Custo        Cod. Base  Item Tp Descricao sintetica                 Aquisic.   Dt.Baixa    Quantidade  Chapa                      "
	nOrder := 4
Else
	cabec1 :=OemToAnsi(STR0005) //"Conta           Cod. Base  Item Tp Descricao sintetica                 Aquisic.   Dt.Baixa    Quantidade  Chapa                      "
	nOrder := 5
End
cabec2 := "" // OemToAnsi(STR0006) //"       VLR AMPLIACAO     VALOR ORIGINAL    VALOR ATUALIZADO  DEPREC. NO MES DEPREC. NO EXERC.   DEPREC. ACUMULADA   CORR.MON. MES  CORR. MON.EXERC.  CORR. MONET. ACUM.  CORR.DEPR. MES  CORR.DEPR.EXERC.  CORR. DEPR.  ACUM."
*                                                   999,999,999,999,99  99.999.999.9999,99 9999.999.999,99 99.999.999.999,99 .999.999.999.999,99 .999.999.999,99 99,999,999,999,99 .999.999.999.999,99 .999.999.999,99 99.999.999.999,99 .999.999.999.999,99
*                              01234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901
*                                        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2 
*                                                                                                                                  1                                                                                                   2                     

If mv_par05 == 2  // 1=Analitico, 2=Sintetico
	Cabec1 := Cabec2
	Cabec2 := ""
Endif

If nLastKey == 27
	Return
End

RptStatus({|lEnd| FR071Imp(@lEnd,wnRel,cString)},Titulo)
Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FR071Imp   ³ Autor ³ Claudinei           ³ Data ³ 11.11.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Posi‡„o Valorizada dos Bens                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FR071Imp(End,wnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function FR071Imp (lEnd,wnRel,cString)

LOCAL cCabCond1  := ""
LOCAL cCabCond2  := ""
LOCAL aTotGeral  := {}
LOCAL aTQuebra1  := {}
LOCAL nSuf       := 0
LOCAL nMoedas    := 1
LOCAL lDescricao := .F.
LOCAL limite     := 220
LOCAL cMoedas    := "S"
LOCAL CbTxt
LOCAL cbCont
LOCAL aQuantidade := { 0, 0, 0, 0, 0 }
LOCAL aTotal 	 := { 0, 0, 0, 0, 0 }
Local dUltDepr   := GetMv("MV_ULTDEPR")
Local cGrupoPass := GetMv("MV_GRPASS")
Local lCtb 		 := CtbInUse(), aTipos, nTipo, nMoeda, nValores, nTotal := 0
Local nCount     := 0

dbSelectArea("SN3")
dbSetOrder ( nOrder )
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza registro inicial                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1
	dbSeek(cFilial+mv_par01, .T. )
	cCabCond1 := OemToAnsi(STR0007) //"Conta   : "
	cCabCond2 := OemToAnsi(STR0008) //"C.Custo : "
Else
	dbSeek(cFilial+mv_par03, .T. )
	cCabCond1 := OemToAnsi(STR0008) //"C.Custo : "
	cCabCond2 := OemToAnsi(STR0007) //"Conta   : "
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Zera os arquivos de acumulado                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCount := 1 To 5
	aTipos := {}
	For nTipo := 1 To 5
		Aadd(aTipos, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
	Next
	AAdd(aTotGeral, AClone(aTipos) )
	AAdd(aTQuebra1, AClone(aTipos) )
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt  := SPACE(10)
cbcont := 0
li      := 80
m_pag	:= 1

cMoedas += IIF(MV_PAR06 == 1, "S", "N");    nMoedas += IIF(MV_PAR06 == 1, 1, 0)
cMoedas += IIF(MV_PAR07 == 1, "S", "N");    nMoedas += IIF(MV_PAR07 == 1, 1, 0)
cMoedas += IIF(MV_PAR08 == 1, "S", "N");    nMoedas += IIF(MV_PAR08 == 1, 1, 0)
cMoedas += IIF(MV_PAR09 == 1, "S", "N");    nMoedas += IIF(MV_PAR09 == 1, 1, 0)

SetRegua(SN3->(Reccount()))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Deve processar todos os registros do SN3 que sejam da mesma filial        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While !SN3->(Eof()) .AND. SN3->N3_FILIAL == xFilial()
    
	IF lEnd
		@ PROW()+1,001 PSAY OemToAnsi(STR0009) // "CANCELADO PELO OPERADOR"
		Exit
	EndIf
    
	// Incrementa regua
	IncRegua()
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica a parametriza‡„o antes mesmo de entrar no detalhe ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aQuantidade := { 0, 0, 0, 0, 0 }
	dbSelectArea("SN3")
	IF SN3->N3_CCONTAB < MV_PAR01 .Or. SN3->N3_CCONTAB > MV_PAR02
		dbSkip()
		Loop
	EndIf
    
	IF SN3->N3_CCUSTO < MV_PAR03 .Or. SN3->N3_CCUSTO > MV_PAR04
		dbSkip()
		Loop
	EndIf

	IF SN3->N3_DINDEPR > mv_par10
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Controla a quebra no 1o. nivel                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF nOrdem == 1
		cQuebra1 := SN3->N3_CCONTAB
		cQuebra2 := SN3->N3_TIPO
		cCond1   := "N3_CCONTAB == cQuebra1 .And. N3_TIPO = cQuebra2"
	Else
		cQuebra1 := SN3->N3_CCUSTO
		cQuebra2 := SN3->N3_TIPO
		cCond1   := "N3_CCUSTO == cQuebra1 .And. N3_TIPO = cQuebra2"
	EndIf
    
	IF Empty(cQuebra1) .Or. Empty(cQuebra2)
		dbSkip()
		Loop
	EndIf
    
	lDescricao := .f.
    
	While !SN3->(Eof()) .AND. SN3->N3_FILIAL == cFilial .And. &cCond1
        
		IF lEnd
			@PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
        
		IncRegua()              
        
		dbSelectArea("SN3")

		IF SN3->N3_CCONTAB < MV_PAR01 .Or. SN3->N3_CCONTAB > MV_PAR02
			dbSkip()
			Loop
		EndIf

		IF SN3->N3_CCUSTO < MV_PAR03 .Or. SN3->N3_CCUSTO > MV_PAR04
			dbSkip()
			Loop
		EndIf

		IF SN3->N3_DINDEPR > mv_par10
			dbSkip()
			Loop
		Endif
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se precisa imprimir o cabecalho ou a descricao da   ³
		//³ conta.                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF li > 58 .Or. (li + nMoedas + 1) > 58
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,15)
			AFR071Cab(nOrdem,cQuebra1)
			lDescricao := .T.
		EndIf
		If !lDescricao
			AFR071Cab(nOrdem,cQuebra1)
			lDescricao := .T.
		EndIf
        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza item no SN1                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SN1->(dbSeek(xFilial("SN1")+SN3->N3_CBASE+SN3->N3_ITEM))
		dbSelectArea("SN3")
		aQuantidade[Val(SN3->N3_TIPO)] ++
        
		If mv_par05 == 1  // 1=Analitico, 2=Sintetico
			IF nOrdem == 1
				@ li,000 PSAY SN3->N3_CCUSTO 
			Else
				@ li,000 PSAY SN3->N3_CCONTAB 
			EndIf
			@ li,021 PSAY SN3->N3_CBASE + "-" + SN3->N3_ITEM + "-" + SN3->N3_TIPO 
			@ li,040 PSAY SubStr(SN1->N1_DESCRIC,1,32)
			@ li,073 PSAY SN1->N1_AQUISIC 
			@ li,082 PSAY SN3->N3_DTBAIXA 
			@ li,091 PSAY SN1->N1_QUANTD	PICTURE "@E 999.999"
			@ li,099 PSAY SN1->N1_CHAPA 
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Efetua a impressao dos valores conforme moedas selecionadas      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nSuf := 1 To 5
			If SubStr(cMoedas,nSuf,1) == "S"
				cSuf      	:= Str(nSuf,1)
				nAmplia		:= U_RetSaldoAtf('SN3->N3_AMPLIA'+cSuf,mv_par10)
				nDepMes 		:= U_RetSaldoAtf('SN3->N3_VRDBAL'+cSuf, mv_par10, FirstDay(mv_par10)) // Depreciacao do comeco do mes ate a data base
				nDepExer		:= U_RetSaldoAtf('SN3->N3_VRDBAL'+cSuf, mv_par10, Ctod("01/01/" + Str(Year(mv_par10), 4))) // Depreciacao do comeco do ano ate a data base
				nDepAcum		:= U_RetSaldoAtf('SN3->N3_VRDACM'+cSuf, mv_par10) // Depreciacao acumulada desde a implantacao ate a data base
				// Valor atual = Valor Original + Ampliacao da epoca - Deprecicao ate a epoca
				nVlrAtual 	:= SN3->N3_VORIG1 + nAmplia - nDepAcum
				If mv_par05 == 1  // 1=Analitico, 2=Sintetico
					@ li,106    PSAY GetMV("MV_SIMB"+cSuf)
					@ li,112    PSAY nAmplia PICTURE "@E 999,999,999.99"
					@ li,128    PSAY &('SN3->N3_VORIG'+cSuf)  PICTURE "@E 9999,999,999.99"
					IF cSuf == "1"
						@ li, 144    PSAY    nVlrAtual       PICTURE "@E 9999,999,999.99"
					Endif
					If Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(GetMv("MV_ULTDEPR"))
						@li, 161    PSAY    nDepMes PICTURE "@E 999,999,999.99"
					Else
						@li, 161    PSAY    0 PICTURE "@E 999,999,999.99"
					EndIf
					@li, 176    PSAY    nDepExer PICTURE "@E 9,999,999,999.99"
					@li, 194    PSAY    nDepAcum PICTURE "@E 99,999,999,999.99"
					@li, 212    PSAY    &('SN3->N3_TXDEPR'+cSuf) PICTURE "@E 999.999"
					li++
				Endif

				If SN1->N1_PATRIM $ "NP "
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totaliza para quebra no 1o. Nivel                             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][01] += &('SN3->N3_VORIG'+cSuf)
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][02] += nVlrAtual
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][03] += IIf (Dtos(SN1->N1_DTBLOQ) < Dtos(GetMv("MV_ULTDEPR")),nDepMes,0)
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][04] += nDepExer 
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][05] += nDepAcum
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][13] += nAmplia
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][12] += 1
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totaliza para quebra no 1o. Nivel                             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][01] -= &('SN3->N3_VORIG'+cSuf)
					aTquebAa1[Val(SN3->N3_TIPO)][nSuf][02] -= nVlrAtual
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][03] -= IIf(Dtos(SN1->N1_DTBLOQ) < Dtos(GetMv("MV_ULTDEPR")),nDepMes,0)
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][04] -= nDepExer 
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][05] -= nDepAcum
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][13] -= nAmplia
					aTquebra1[Val(SN3->N3_TIPO)][nSuf][12] += 1
				EndIf
			EndIf
		Next
		SN3->( dbSkip())
	EndDo
   
    For nTipo := 1 To 5
	 	If aTQuebra1[nTipo][1][12] != 0
			If mv_par05 == 1  // 1=Analitico, 2=Sintetico
				li += 2
			Endif
			cDescr := Afr071desc( nOrdem, cQuebra1 )
			@ li, 6 PSAY OemToAnsi(STR0010) + cCabCond1 + cDescr 		// "TOTAL "
			@ li,72 PSAY OemToAnsi(STR0011) + Str(aQuantidade[nTipo],5,0) 	// "QUANTIDADE"
			aTotal[nTipo] += aQuantidade[nTipo]
			aQuantidade[nTipo] := 0
			For nSuf := 1 To 5
				IF SubStr(cMoedas,nSuf,1) == "S"
					cSuf := Str(nSuf,1)
					li++
					@ li, 106 PSAY GetMV("MV_SIMB"+cSuf)
					If nOrdem == 1
						If lCtb
							dbSelectArea("CT1")
							If (dbSeek(xFilial()+cQuebra1))
								If SubStr(CT1->CT1_CONTA,1,1) $ cGrupoPass
									If CT1->CT1_NORMAL == "1"
										aTQuebra1[nTipo][nSuf][ 1] := aTQuebra1[nTipo][nSuf][ 1] * -1
										aTQuebra1[nTipo][nSuf][ 2] := aTQuebra1[nTipo][nSuf][ 2] * -1
									Endif
								EndIf
							Endif					
						Else
							dbSelectArea("SI1")
							If (dbSeek(xFilial()+cQuebra1))
								If SubStr(SI1->I1_CODIGO,1,1) $ cGrupoPass
									If SI1->I1_NORMAL == "D"
										aTQuebra1[nTipo][nSuf][ 1] := aTQuebra1[nTipo][nSuf][ 1] * -1
										aTQuebra1[nTipo][nSuf][ 2] := aTQuebra1[nTipo][nSuf][ 2] * -1
									Endif
								EndIf
							Endif
						EndIf
					Endif
					@ li,112    PSAY    aTQuebra1[nTipo][nSuf][13]     PICTURE "@E 999,999,999.99"
					@ li,128    PSAY    aTQuebra1[nTipo][nSuf][01]     PICTURE "@E 9999,999,999.99"
					IF cSuf == "1"
						@ li, 144   PSAY   aTQuebra1[nTipo][nSuf][02]  PICTURE "@E 9999,999,999.99"
					Endif
					If cSuf == "1"
						@ li, 161   PSAY    aTQuebra1[nTipo][nSuf][03] PICTURE "@E 999,999,999.99"
						@ li, 176   PSAY    aTQuebra1[nTipo][nSuf][04] PICTURE "@E 99,999,999,999.99"
						@ li, 194   PSAY    aTQuebra1[nTipo][nSuf][05] PICTURE "@E 99,999,999,999.99"
					Else
						@ li, 161   PSAY    aTQuebra1[nTipo][nSuf][03] PICTURE "@E 999,999,999.99"
						@ li, 176   PSAY    aTQuebra1[nTipo][nSuf][04] PICTURE "@E 99,999,999,999.99"
						@ li, 194   PSAY    aTQuebra1[nTipo][nSuf][05] PICTURE "@E 99,999,999,999.99"
					Endif
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Totaliza para quebra no 1o. Nivel                             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aTotGeral[nTipo][nSuf][01] += aTQuebra1[nTipo][nSuf][01]
					aTotGeral[nTipo][nSuf][02] += aTQuebra1[nTipo][nSuf][02]
					aTotGeral[nTipo][nSuf][03] += aTQuebra1[nTipo][nSuf][03]
					aTotGeral[nTipo][nSuf][04] += aTQuebra1[nTipo][nSuf][04]
					aTotGeral[nTipo][nSuf][05] += aTQuebra1[nTipo][nSuf][05]
					aTotGeral[nTipo][nSuf][13] += aTQuebra1[nTipo][nSuf][13]
					aTotGeral[nTipo][nSuf][12] -= aTQuebra1[nTipo][nSuf][12]
				Endif
			Next
			li++
			For nSuf := 1 To 13
				aTQuebra1[nTipo][1][nSuf] := 0
				aTQuebra1[nTipo][2][nSuf] := 0
				aTQuebra1[nTipo][3][nSuf] := 0
				aTQuebra1[nTipo][4][nSuf] := 0
				aTQuebra1[nTipo][5][nSuf] := 0
			Next
			lDescricao := .F.
		Endif
	Next
	li+=2
	@ li ++, 0 PSAY Replicate("-",limite)
	dbSelectArea("SN3")
EndDO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Efetua a impressao da totalizacao na quebra do segundo nivel        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Aadd(aTotGeral, Aclone(aTotGeral[1]))
For nMoeda := 1 To 5
	For nTipo := 1 To 5
		For nValores := 1 To Len(aTotGeral[6][nTipo])
			aTotGeral[6][nTipo][nValores] := 0
		Next
	Next
Next

For nMoeda := 1 To 5
	For nTipo := 1 To Len(aTotGeral[nMoeda])
		For nValores := 1 To Len(aTotGeral[nMoeda][nTipo])
			aTotGeral[6][nTipo][nValores] += aTotGeral[nMoeda][nTipo][nValores]
		Next
	Next
	nTotal += aTotal[nMoeda]
Next

For nTipo := 1 To 6
	If aTotGeral[nTipo][1][12] != 0
		If nTipo = 6
			@ li,06 PSAY OemToAnsi(STR0012) 							// "* * *   T O T A L   G E R A L   * * *"
			@ li ++,72 PSAY OemToAnsi(STR0013) + Str(nTotal,5,0) 	// "QUANTIDADE" 
		Else
			@ li,06 PSAY "TOTAL TIPO " + StrZero(nTipo, 2)
			@ li ++,72 PSAY OemToAnsi(STR0013) + Str(aTotal[nTipo],5,0) 	// "QUANTIDADE" 
		Endif
		For nSuf := 1 To 5
			IF SubStr(cMoedas,nSuf,1) == "S"
				cSuf      := Str(nSuf,1)
				IF li > 58 .Or. (li + nMoedas + 1) > 58
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,15)
				Endif
				@ li,106    PSAY    GetMV("MV_SIMB"+cSuf)
				@ li,112    PSAY    aTotGeral[nTipo][nSuf][13]     PICTURE "@E 999,999,999.99"
				@ li,128    PSAY    aTotGeral[nTipo][nSuf][01]     PICTURE "@E 9999,999,999.99"
				IF cSuf == "1"
					@ li,144    PSAY    aTotGeral[nTipo][nSuf][02]  PICTURE "@E 9999,999,999.99"
				End
				If cSuf == "1"
					@li,161    PSAY    aTotGeral[nTipo][nSuf][03] PICTURE "@E 999,999,999.99"
					@li,176    PSAY    aTotGeral[nTipo][nSuf][04] PICTURE "@E 99,999,999,999.99"
					@li,194    PSAY    aTotGeral[nTipo][nSuf][05] PICTURE "@E 99,999,999,999.99"
				Else
					@li,161    PSAY    aTotGeral[nTipo][nSuf][03] PICTURE "@E 999,999,999.99"
					@li,176    PSAY    aTotGeral[nTipo][nSuf][04] PICTURE "@E 99,999,999,999.99"
					@li,194    PSAY    aTotGeral[nTipo][nSuf][05] PICTURE "@E 99,999,999,999.99"
				Endif
				li ++
			EndIf
		Next
	Endif
Next
If li != 80
	Roda(cbcont,cbtxt,"G")
End

dbClearFilter()
dbSelectArea("SN3")
dbSetOrder(1)
SN3 -> ( dbSetOrder ( 1 ) )

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
EndIf
MS_FLUSH()

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ AFR071Cab  ³ Autor ³ Wagner Xavier         ³ Data ³ 11.11.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao do cabecalho do relatorio (Nivel 1 de quebra)      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ AFR071Cab(cPar01,nPar01,@nPar02)                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ cPar01 - Cabecalho a ser impresso                            ³±±
±±³          ³ nPar01 - Ordem da impressao do relatorio (1-Conta/2-C.Custo) ³±±
±±³          ³ nPar02 - Linha corrente                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR071                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AFR071Cab(nOrdem,cChave)
Local cCabNiv1 := ""
Local lCtb     := CtbInUse()
                                        
IF nOrdem == 1
	If lCtb
		dbSelectArea("CT1")
		dbSetOrder(1)
		CT1->(dbSeek(xFilial("CT1") + cChave))
		cCabNiv1 := AllTrim(Mascara(cQuebra1))+" - "+CT1->CT1_DESC01
	Else
		dbSelectArea("SI1")
		dbSetOrder(1)
		SI1->(dbSeek( xFilial("SI1") + cChave ))
		cCabNiv1 := AllTrim(Mascara(cQuebra1))+" - "+SI1->I1_DESC
	Endif
Else
	If lCtb
		dbSelectAre("CTT")
		dbSetOrder(1)
		CTT->( dbSeek(xFilial("CTT")+cChave ) )
		cCabNiv1 := AllTrim(cQuebra1)+" - "+CTT->CTT_DESC01
	Else
		SI3 -> ( dbSeek( xFilial("SI3") + cChave ) )
		cCabNiv1 := AllTrim(cQuebra1)+" - "+SI3->I3_DESC
	Endif
End
@ Li, 0 PSAY  AllTrim(cCabNiv1) + STR0019 + SN3->N3_TIPO //" - TIPO "
Li += 2
Return NIL

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ AFR071Desc ³ Autor ³ Cesar C S Prado       ³ Data ³ 09.08.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Busca a descricao a ser impressa para subtotal / total       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ AFR071Desc(nPar01)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ nPar01 - Ordem da impressao do relatorio (1-Conta/2-C.Custo) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR071                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AFR071Desc(nOrdem, cChave )
Local cAlias  := Alias()
Local cDescr  := ""
Local lCtb    := CtbInUse()                                   
                            
If lCtb
	dbSelectArea( Iif( nOrdem == 1, "CT1", "CTT" ) )
	IF dbSeek(cFilial+cChave)
		cDescr := Iif( nOrdem==1,Mascara(cChave),cChave) + " " + Iif(nOrdem==1,CT1->CT1_DESC01,CTT->CTT_DESC01)
	Endif
Else
	dbSelectArea( Iif( nOrdem == 1, "SI1", "SI3" ) )
	IF dbSeek(cFilial+cChave)
		cDescr := Iif( nOrdem==1,Mascara(cChave),cChave) + " " + Iif(nOrdem==1,SI1->I1_DESC,SI3->I3_DESC)
	Endif
EndIf

dbSelectArea( cAlias )
Return (cDescr)

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³RetSaldoAtf ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 11/11/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Le o SN4 baseado no identificador do SN3 ate a data base      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Utilizacao³ U_RetSaldoAtf(cIdentSn3,dDataFim,dDataIni)                     ³±±
±±³Parametros³ cIdentSn3 -> Identificador do SN3 para identificar movimento ³±±
±±³          ³ dDataFim  -> Data Limite para leitura dos movimentos         ³±±
±±³          ³ dDataIni  -> Data Inicio para leitura dos movimentos         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RetSaldoAtf(cIdentSn3,dDataFim,dDataIni)

Local nSaldo := 0  
Local aArea                      
Local aSx3     
Local cAliasQry 
Local cFiltro

aArea := GetArea()
SN4->(DbSetOrder(4))
If "N3_AMPLIA" $ cIdentSn3		// Ampliacao
	cFiltro := 	"N4_OCORR = '09' AND N4_DATA <= '" + Dtos(dDataFim) + "'"
ElseIf "N3_VRDBAL" $ cIdentSn3	// Depreciacao
	cFiltro := 	"N4_OCORR = '06' AND N4_DATA >= '" + Dtos(dDataIni) + "' AND " +;
					"N4_DATA <= '" + Dtos(dDataFim) + "' AND N4_TIPOCNT = '4'"
ElseIf "N3_VRDACM" $ cIdentSn3
	cFiltro := 	"N4_OCORR = '06' AND N4_DATA <= '" + Dtos(dDataFim) +;
					"' AND N4_TIPOCNT = '4'"
ElseIf "N3_VRCBAL" $ cIdentSn3	// Correcao
	cFiltro := 	"N4_OCORR = '07' AND N4_DATA >= '" + Dtos(dDataIni) + "' AND " +;
					"N4_DATA <= '" + Dtos(dDataFim) + "' AND N4_TIPOCNT = '4'"
ElseIf "N3_VRCACM" $ cIdentSn3
	cFiltro := 	"N4_OCORR = '07' AND N4_DATA <= '" + Dtos(dDataFim) +;
					"' AND N4_TIPOCNT = '4'"
ElseIf "N3_VRCDB" $ cIdentSn3	// Correcao depreciacao
	cFiltro := 	"N4_OCORR = '08' AND N4_DATA >= '" + Dtos(dDataIni) + "' AND " +;
					"N4_DATA <= '" + Dtos(dDataFim) + "' AND N4_TIPOCNT = '4'"
ElseIf "N3_VRCDA" $ cIdentSn3
	cFiltro := 	"N4_OCORR = '08' AND N4_DATA <= '" + Dtos(dDataFim) +;
					"' AND N4_TIPOCNT = '4'"
Endif
aSx3 := TamSx3("N4_VLROC" + Right(cIdentSn3, 1))
cAliasQry := 	SelDados("SN4", "N4_FILIAL = '" + xFilial("SN4") + "' AND " +;
										"N4_CBASE = '" + SN3->N3_CBASE + "' AND " +;
											"N4_ITEM = '" + SN3->N3_ITEM + "' AND " +;
											"N4_TIPO = '" + SN3->N3_TIPO + "' AND " + cFiltro,,,;
				{ { "VALOR", "N", aSx3[1], aSx3[2], "SUM(N4_VLROC" + Right(cIdentSn3, 1) + ")" } })
nSaldo := (cAliasQry)->VALOR	
RemoveSel("SN4")
RestArea(aArea)

Return nSaldo