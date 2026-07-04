/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AGRR107   º Autor ³ Saulo Carvalho Gomesº Data ³  01/11/05  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relação de contratos financeiros                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Clientes Microsiga                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR107

	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Contrato Financeiro por Vencimento"
	Local titulo         := "Contratos Financeiros por Vencimento"
	Local nLin           := 80
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private aOrd        := {}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 132
	Private tamanho     := "M"
	Private nomeprog    := 'AGRR107'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR107"
	Private wnrel       := "AGRR107"

	Private cString := "SE2"

	dbSelectArea("SE2")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,Tamanho,,.T.)

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
	Local cFiltUser := aReturn[7]
	Local cFilSE2   := ''
	Local cNumero   := ''
	Local cNumComp  := ''
	Local cFornece  := ''
	Local nPR       := 0
	Local nJR       := 0
	Local nPRTot    := 0
	Local nJRTot    := 0
	Local nPRGer    := 0
	Local nJRGer    := 0
	Local cTexto    := ' em ' + GetMV('MV_MOEDAP'+AllTrim(Str(mv_par11)))

	@Titulo := AllTrim(@Titulo)+cTexto

	//                                                                                                    1         1         1         1
	//          1         2         3         4         5         6         7         8         9         0         1         2         3
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//Contrato                Fornecedor                                                           Principal          Juros          Total
	//######(###############) ######/##-##############################                        ###,###,###.## ###,###,###.## ###,###,###.##


	//-----------------------------------------------------------------------------
	Cabec1 := "Contrato                Fornecedor                                                           Principal          Juros          Total"

	//-----------------------------------------------------------------------------
	cFilSE2 += "E2_FORNECE >= '"+mv_par01+"' .And. E2_FORNECE <= '"+mv_par02+"' .And. "
	cFilSE2 += "E2_NUM >= '"    +mv_par06+"' .And. E2_NUM <= '"    +mv_par07+"' .And. "
	cFilSE2 += "DTOS(E2_EMISSAO) >= '"+DToS(mv_par04)+"' .And. DTOS(E2_EMISSAO) <= '"+DToS(mv_par05)+"' .And. "
	cFilSE2 += "DTOS(E2_VENCTO)  >= '"+DToS(mv_par08)+"' .And. DTOS(E2_VENCTO)  <= '"+DToS(mv_par09)+"' .And. "
	cFilSE2 += "Left(E2_PREFIXO,2) = 'CT' .And. E2_SALDO > 0 .And. "
	If mv_par03 = 1
		cFilSE2 += "E2_TIPO = 'DP'"
	ElseIf mv_par03 = 2
		cFilSE2 += "E2_TIPO = 'JP'"
	Else
		cFilSE2 += "(E2_TIPO = 'DP' .Or. E2_TIPO = 'JP')"
	EndIf
	//-----------------------------------------------------------------------------
	dbSelectArea("SE2")
	dbSetOrder(1)
	cIndex	:= CriaTrab(nil,.f.)
	cChave	:= 'DTOS(E2_VENCTO)+E2_NUM'
	IndRegua("SE2",cIndex,cChave,,cFilSE2,"Selecionando Registros...")
	nIndex := RetIndex("SE2")
	dbSelectArea("SE2")
	#IFNDEF TOP
	dbSetIndex(cIndex+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)
	dbGotop()
	While .Not. Eof()

		If !Empty(cFiltUser).And.!(&cFiltUser)
			SE2->(dbSkip())
			Loop
		EndIf

		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		EndIf

		dVencto  := SE2->E2_VENCTO
		While .Not. Eof() .And. SE2->E2_VENCTO = dVencto

			dbSelectArea('SA2')
			dbSetOrder(1)
			dbSeek(xFilial('SA2')+SE2->E2_FORNECE+SE2->E2_LOJA)

			cFornece := AllTrim(SA2->A2_COD)+'/'+AllTrim(SA2->A2_LOJA)+'-'+AlLTrim(SA2->A2_NOME)

			dbSelectArea('NO7')
			dbSetOrder(2)
			dbSeek(SE2->E2_FILIAL+SA2->A2_COD+SA2->A2_LOJA+SE2->E2_NUM)

			cNumComp := AllTrim(NO7->NO7_NUMCMP)

			dbSelectArea('SE2')
			cNumero  := SE2->E2_NUM
			While .Not. Eof() .And. SE2->E2_VENCTO = dVencto .And. SE2->E2_NUM = cNumero
				If SE2->E2_TIPO = 'DP'
					nVl := xMoeda(SE2->E2_SALDO, SE2->E2_MOEDA, mv_par11, dDataBase)
					nPR += nVl
				Else
					nVl := xMoeda(SE2->E2_SALDO, SE2->E2_MOEDA, mv_par11, dDataBase)
					nJR += nVl
				EndIf
				dbSelectArea('SE2')
				dbSkip()
			EndDo

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			EndIf

			If mv_par10 > 1
				@nLin, 000 PSay PadR(cNumero,06)+'('+PadR(cNumComp,15)+')'
				@nLin, 024 PSay PadR(cFornece,40)
				@nLin, 088 PSay Transform(nPR    , '@E 999,999,999.99')
				@nLin, 103 PSay Transform(nJR    , '@E 999,999,999.99')
				@nLin, 118 PSay Transform(nPR+nJR, '@E 999,999,999.99')
				nLin++
			EndIf

			nPRTot += nPR
			nJRTot += nJR
			nPR := 0
			nJR := 0

		EndDo

		@nLin, 000 PSay PadL('Total da Data: '+DTOC(dVencto)+' -->',34)
		@nLin, 088 PSay Transform(nPRTot       , '@E 999,999,999.99')
		@nLin, 103 PSay Transform(nJRTot       , '@E 999,999,999.99')
		@nLin, 118 PSay Transform(nPRTot+nJRTot, '@E 999,999,999.99')
		nLin += 2

		nPRGer += nPRTot
		nJRGer += nJRTot
		nPRTot := 0
		nJRTot := 0

	EndDo

	nLin++
	@nLin, 010 PSay PadL('Total Geral --->',24)
	@nLin, 088 PSay Transform(nPRGer       , '@E 999,999,999.99')
	@nLin, 103 PSay Transform(nJRGer       , '@E 999,999,999.99')
	@nLin, 118 PSay Transform(nPRGer+nJRGer, '@E 999,999,999.99')

	Roda()

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return

