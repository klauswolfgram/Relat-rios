/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AGRR105   º Autor ³ Saulo Carvalho Gomesº Data ³  01/11/05  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relação de contratos financeiros                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Clientes Microsiga                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AgrR105

	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Contrato Financeiro"
	Local titulo         := "Contrato Financeiro"
	Local nLin           := 80
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private aOrd        := {}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 132
	Private tamanho     := "M"
	Private nomeprog    := 'AGRR105'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR105"
	Private wnrel       := "AGRR105"

	Private cString := "NO7"

	dbSelectArea("NO7")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,Tamanho,,.F.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)


	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  01/10/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                             

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	//Local aArea   := GetArea()
	Local cCodAnt := ""
	Local cGrupo  := ""
	Local cDesc   := ""
	Local cCabDet := ""
	Local cTipo   := ""
	Local cAditivo:= ""

	//Variáveis para criação de filtro
	Local cIndex  := ""
	Local cChave  := ""
	Local cFiltro := ""
	Local cFilSE2 := ""
	Local cTipSE2 := ""

	//Variáveis para cálculo
	Local nPRAb	  := 0
	Local nPRBx   := 0
	Local nJRAb	  := 0
	Local nJRBx   := 0
	Local nTotFor := 0

	dbSelectArea(cString)
	dbGoTop()

	cFiltro := "NO7_CODFOR >= '"+MV_PAR01+"' .And. "
	cFiltro += "NO7_CODFOR <= '"+MV_PAR02+"' .And. "
	If (MV_PAR03 <> 3)
		If (MV_PAR03 = 1)
			cTipo 	:= "PR"
			cFiltro += "NO7_TIPO  == '"+ cTipo+"' .And. "
		Else
			cTipo 	:= "JR"
			cFiltro += "NO7_TIPO  == '"+ cTipo+"' .And. "
		EndIf
	EndIf
	cFiltro += "DTOS(NO7_DATEMI) >= '"+DTOS(MV_PAR04)+"' .And. "
	cFiltro += "DTOS(NO7_DATEMI) <= '"+DTOS(MV_PAR05)+"' .And. "
	cFiltro += "NO7_NUMERO >= '"+MV_PAR06+"' .And. "
	cFiltro += "NO7_NUMERO <= '"+MV_PAR07+"'"

	dbSelectArea("NO7")
	dbSetOrder(1)
	cIndex	:= CriaTrab(nil,.f.)
	cChave	:= IndexKey()
	IndRegua("NO7",cIndex,cChave,,cFiltro,"Selecionando Registros...")
	nIndex := RetIndex("NO7")
	DbSelectArea("NO7")
	#IFNDEF TOP
	DbSetIndex(cIndex+OrdBagExt())
	#ENDIF
	DbSetOrder(nIndex+1)
	dbGotop()

	//          0         0         0         0         0         0         0         0         0         1         1         1         1
	//          1         2         3         4         5         6         7         8         9         0         1         2         3
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	Cabec1 := "  Fornecedor"
	Cabec2 := "  No. Contrato  No. Completo          Adit  Tipo  Data Emi    Valor"
	cCabDet:= "  Pref  Num     Parc  Tipo  Vencto    Valor           Status "

	cCodAnt := NO7_NUMERO
	cTipo   := NO7_TIPO
	cAditivo:= NO7_ADTIVO
	cGrupo  := NO7_CODFOR

	While .Not. Eof()
		If MV_PAR03 == 1 .AND. NO7_TIPO == 'JR'
			dbSkip()
			Loop
		ElseIf MV_PAR03 == 2 .AND. NO7_TIPO == 'PR'
			dbSkip()
			Loop
		EndIf
		If cAditivo < fUltAdt(NO7->NO7_NUMERO, NO7->NO7_TIPO, NO7->NO7_ADTIVO)
			dbSkip()
			Loop
		EndIf

		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif  

		If (NO7_NUMERO	<> cCodAnt)
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9        
			cCodAnt	:= NO7_NUMERO
			cTipo  	:= NO7_TIPO
			cAditivo	:= NO7_ADTIVO
			If  cGrupo <> NO7_CODFOR
				nTotFor := 0  
			EndIf         
		EndIf

		dbSelectArea("SA2")
		dbSetOrder(1)
		If DbSeek(XFilial("SA1")+NO7->NO7_CODFOR + NO7->NO7_LOJFOR)
			cDesc := AllTrim(A2_NOME)
		EndIf

		dbSelectArea("NO7")
		cTipo    := NO7_TIPO
		//cAditivo := NO7_ADTIVO

		@ nLin , 002 PSay PadR(AllTrim(NO7_CODFOR) + "-" + AllTrim(NO7_LOJFOR),9) 
		@ nLin , 013 PSay PadR(cDesc,30)
		nLin ++
		@ nLin , 002 PSay PadR(NO7_NUMERO,06)
		@ nLin , 016 PSay PadR(NO7_NUMCMP,20)
		@ nLin , 038 PSay PadR(NO7_ADTIVO,01) 
		@ nLin , 044 PSay PadR(NO7_TIPO,02)
		@ nLin , 050 PSay NO7_DATEMI
		@ nLin , 062 PSay Transform(NO7_VALOR ,"@E 999,999,999.99")
		nLin ++
		@ nLin , 002 PSay "Historico: " + PadR(NO7_HISTOR,75)		
		nLin := nLin + 2
		@ nLin, 002 PSay Replicate("-",130)
		nLin ++

		cTipSE2 := IIf(NO7->NO7_TIPO = 'JR','JP','DP')

		cFilSE2 := "E2_NUM = '"+NO7->NO7_NUMERO+"' .And. AllTrim(E2_TIPO) = '"+CTipSE2+"' .And."
		cFilSE2 += "E2_PREFIXO = '"+('CT'+AllTrim(NO7->NO7_ADTIVO))+"'"
		dbSelectArea("SE2")
		dbSetOrder(1)//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
		dbSetFilter( {|| &cFilSE2 }, cFilSE2 )
		dbGotop()

		@ nLin, 000 PSay cCabDet
		nLin += 2

		While .Not. Eof()

			@ nLin, 002 PSay PadR(SE2->E2_PREFIXO,3)
			@ nLin, 008 PSay PadR(SE2->E2_NUM,6)
			@ nLin, 016 PSay PadR(SE2->E2_PARCELA,1)
			@ nLin, 022 PSay PadR(SE2->E2_TIPO,2)
			@ nLin, 028 PSay DToC(SE2->E2_VENCTO)
			@ nLin, 038 PSay Transform(SE2->E2_VALOR,"@E 999,999,999.99")
			If (SE2->E2_VALOR == SE2->E2_SALDO)
				@ nLin, 054 PSay "Aberto"
				If (NO7->NO7_TIPO = "PR")
					nPRAb	:= nPRAb + SE2->E2_VALOR
				Else
					nJRAb	:= nJRAb + SE2->E2_VALOR
				EndIf
			ElseIf (SE2->E2_VALOR > SE2->E2_SALDO)
				@ nLin, 054 PSay "Baixado"
				If (NO7->NO7_TIPO = "PR")
					nPRBx	:= nPRBx + (SE2->E2_VALOR-SE2->E2_SALDO)
				Else
					nJRBx	:= nJRBx + (SE2->E2_VALOR-SE2->E2_SALDO)
				EndIf
			EndIf
			nTotFor := nTotFor + SE2->E2_VALOR
			nLin++
			dbSelectArea('SE2')
			dbSkip()
		EndDo

		SE2->(dbClearFilter())

		@ nLin, 002 PSay Replicate("-",130)
		nLin ++
		If (cTipo == "PR")
			@ nLin, 002 PSay "Total Aberto Principal: " 
			@ nLin, 027 PSay  Transform(nPRAb,"@E 999,999,999.99")
			@ nLin, 044 PSay "Total Baixado Principal: " 
			@ nLin, 070 PSay Transform(nPRBx,"@E 999,999,999.99") 
			nLin ++
		ElseIf (cTipo == "JR")
			@ nLin, 002 PSay "Total Aberto Juros: " 
			@ nLin, 027 PSay  Transform(nJRAb,"@E 999,999,999.99")
			@ nLin, 044 PSay "Total Baixado Juros: " 
			@ nLin, 070 PSay Transform(nJRBx,"@E 999,999,999.99") 
			nLin ++
		EndIf
		@ nLin, 002 PSay Replicate("-",130)
		nLin ++; nLin ++; nLin++

		//Zera variaveis
		nPRAb := 0
		nPRBx := 0
		nJRAb := 0
		nJRBx := 0

		dbSelectArea("NO7")
		dbSkip()

		If  cGrupo <> NO7_CODFOR
			@ nLin, 002 PSay Replicate("-",130)
			nLin ++
			@ nLin, 002 PSay "Total do Fornecedor : "
			@ nLin, 026 PSay Transform(nTotFor, "@E 999,999,999.99")
			nLin ++
			@ nLin, 002 PSay Replicate("-",130)
			nLin ++
			nTotFor := 0
		EndIf
	EndDo

	Roda()

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return


/*
+--------+--------------------------------------------------------------+
| Funcao | fUltAdt()                                                    |
| Autor  | Ricardo Tomasi                                               |
| Data   | 10 de Maio 2004                                              |
| Descri | Procura ultimo aditivo do contrato.                          |
+--------+--------------------------------------------------------------+
*/
Static Function fUltAdt(cNumero, cTipo, cAdtivo)
	Local aAreaNO7 := NO7->(GetArea())
	Local cUltAdt  := ''

	dbSelectArea('NO7') //NO7_FILIAL+NO7_NUMERO+NO7_ADTIVO+NO7_TIPO
	dbGoTop()
	While .Not. Eof() .And. NO7->NO7_NUMERO = cNumero
		If NO7->NO7_TIPO = cTipo
			If cAdtivo < NO7->NO7_ADTIVO
				cUltAdt := NO7->NO7_ADTIVO
			EndIf
		EndIf
		dbSkip()
	EndDo

	RestArea(aAreaNO7)
Return(cUltAdt)


