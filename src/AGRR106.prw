/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AGRR106   º Autor ³ Saulo Carvalho Gomesº Data ³  01/11/05  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relação de contratos financeiros                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Clientes Microsiga                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AgrR106

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
	Private limite      := 220
	Private tamanho     := "G"
	Private nomeprog    := 'AGRR106'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR106"
	Private wnrel       := "AGRR106"

	Private cString := "NO7"

	dbSelectArea("NO7")
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
	Local cCodFor   := ''
	Local cNumCTF   := ''
	Local cFornec   := ''
	Local cCodFil   := ''
	Local cNumCnt   := ''

	//Variáveis para criação de filtro
	Local cIndex  := ""
	Local cChave  := ""
	Local cFilNO7 := ""
	Local cFilSE2 := ""

	//Variáveis para cálculo
	Local nTotPR := 0
	Local nTotJR := 0
	Local nBxaPR := 0
	Local nBxaJR := 0
	Local nSldPR := 0
	Local nSldJR := 0
	Local nFTtPR := 0
	Local nFTtJR := 0
	Local nFBxPR := 0
	Local nFBxJR := 0
	Local nFSlPR := 0
	Local nFSlJR := 0
	Local nGTtPR := 0
	Local nGTtJR := 0
	Local nGBxPR := 0
	Local nGBxJR := 0
	Local nGSlPR := 0
	Local nGSlJR := 0

	cFilNO7 := "NO7_CODFOR >= '"+MV_PAR01+"' .And. "
	cFilNO7 += "NO7_CODFOR <= '"+MV_PAR02+"' .And. "
	If (MV_PAR03 <> 3)
		If (MV_PAR03 = 1)
			cTipo 	:= "PR"
			cFilNO7 += "NO7_TIPO  == '"+ cTipo+"' .And. "
		Else
			cTipo 	:= "JR"
			cFilNO7 += "NO7_TIPO  == '"+ cTipo+"' .And. "
		EndIf
	EndIf
	cFilNO7 += "DTOS(NO7_DATEMI) >= '"+DTOS(MV_PAR04)+"' .And. "
	cFilNO7 += "DTOS(NO7_DATEMI) <= '"+DTOS(MV_PAR05)+"' .And. "
	cFilNO7 += "NO7_NUMERO >= '"+MV_PAR06+"' .And. "
	cFilNO7 += "NO7_NUMERO <= '"+MV_PAR07+"'"

	dbSelectArea("NO7")
	dbSetOrder(1)
	cIndex	:= CriaTrab(nil,.f.)
	cChave	:= 'NO7_CODFOR+NO7_NUMERO+NO7_ADTIVO+NO7_TIPO'//IndexKey()
	IndRegua("NO7",cIndex,cChave,,cFilNO7,"Selecionando Registros...")
	nIndex := RetIndex("NO7")
	dbSelectArea("NO7")
	#IFNDEF TOP
	dbSetIndex(cIndex+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)

	//          0         0         0         0         0         0         0         0         0         1         1         1         1         1         1         1         1         1         1         2         2         2
	//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
	//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//|Fornecedor                             | Fl | Contrato                 | -------------- Total do Contrato ------------- | -------------- Baixado do Contrato ----------- | -------------- Saldo do Contrato ------------- |
	//|                                       |    |                          |     Principal |         Juros |          Total |     Principal |         Juros |          Total |     Principal |         Juros |          Total |
	// ######-###############################   ##   ###### (###############)   XX.XXX.XXX,XX   XX.XXX.XXX,XX   XXX.XXX.XXX,XX   XX.XXX.XXX,XX   XX.XXX.XXX,XX   XXX.XXX.XXX,XX   XX.XXX.XXX,XX   XX.XXX.XXX,XX   XXX.XXX.XXX,XX  
	Titulo += ": Vencto de "+DToC(mv_par08)+" ate "+DToC(mv_par09)
	Cabec1 := "|Fornecedor                             | Fl | Contrato                 | -------------- Total do Contrato ------------- | -------------- Baixado do Contrato ----------- | -------------- Saldo do Contrato ------------- |"
	Cabec2 := "|                                       |    |                          |     Principal |         Juros |          Total |     Principal |         Juros |          Total |     Principal |         Juros |          Total |"

	While .Not. Eof()

		cCodFor := NO7->NO7_CODFOR
		While .Not. Eof() .And. NO7->NO7_CODFOR == cCodFor

			cNumCTF := NO7->NO7_NUMERO
			While .Not. Eof() .And. NO7->NO7_CODFOR == cCodFor .And. NO7->NO7_NUMERO == cNumCTF

				If !Empty(cFiltUser).And.!(&cFiltUser)
					NO7->(dbSkip())
					Loop
				EndIf

				dbSelectArea("SA2")
				dbSetOrder(1)
				dbSeek(XFilial("SA2")+NO7->NO7_CODFOR + NO7->NO7_LOJFOR)

				cFilSE2 := "E2_FILIAL = '"+NO7->NO7_FILIAL+"' .And. "
				cFilSE2 += "E2_NUM = '"+NO7->NO7_NUMERO+"' .And. AllTrim(E2_TIPO) = '"+IIf(NO7->NO7_TIPO = 'JR','JP','DP')+"' .And. "
				cFilSE2 += "E2_PREFIXO = 'CT"+NO7->NO7_ADTIVO+"' .And. E2_FORNECE = '"+NO7->NO7_CODFOR+"' .And. "
				cFilSE2 += "DTOS(E2_VENCTO) >= '"+DTOS(mv_par08)+"' .And. DTOS(E2_VENCTO) <= '"+DTOS(mv_par09)+"'"
				dbSelectArea("SE2")
				dbSetOrder(1)//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
				dbSetFilter( {|| &cFilSE2 }, cFilSE2 )
				dbGotop()
				While .Not. Eof()

					If NO7->NO7_TIPO = 'PR'
						nTotPR += SE2->E2_VALOR
						nBxaPR += SE2->E2_VALOR - SE2->E2_SALDO
						nSldPR += SE2->E2_SALDO
					ElseIf NO7->NO7_TIPO = 'JR'
						nTotJR += SE2->E2_VALOR
						nBxaJR += SE2->E2_VALOR - SE2->E2_SALDO
						nSldJR += SE2->E2_SALDO
					EndIf

					dbSelectArea('SE2')
					dbSkip()
				EndDo

				cFornec := PadR(SA2->A2_COD,6)+'-'+PadR(SA2->A2_NOME,30)
				cCodFil := NO7->NO7_FILIAL
				cNumCnt := PadR(NO7->NO7_NUMERO,6)+' ('+PadR(NO7->NO7_NUMCMP,15)+')'

				dbSelectArea("NO7")
				dbSkip()
			EndDo

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

			If mv_par10 == 2
				@nLin, 001 PSay PadR(cFornec,38)
				@nLin, 042 PSay PadR(cCodFil,02)
				@nLin, 047 PSay PadR(cNumCnt,24)
				@nLin, 074 PSay Transform(nTotPR,  '@E 99,999,999.99')
				@nLin, 090 PSay Transform(nTotJR,  '@E 99,999,999.99')
				@nLin, 106 PSay Transform(nTotPR+nTotJR, '@E 999,999,999.99')
				@nLin, 123 PSay Transform(nBxaPR,  '@E 99,999,999.99')
				@nLin, 139 PSay Transform(nBxaJR,  '@E 99,999,999.99')
				@nLin, 155 PSay Transform(nBxaPR+nBxaJR, '@E 999,999,999.99')
				@nLin, 172 PSay Transform(nSldPR,  '@E 99,999,999.99')
				@nLin, 188 PSay Transform(nSldJR,  '@E 99,999,999.99')
				@nLin, 204 PSay Transform(nSldPR+nSldJR, '@E 999,999,999.99')
				nLin++
			EndIf

			nFTtPR += nTotPR
			nFTtJR += nTotJR
			nFBxPR += nBxaPR
			nFBxJR += nBxaJR
			nFSlPR += nSldPR
			nFSlJR += nSldJR

			nGTtPR += nTotPR
			nGTtJR += nTotJR
			nGBxPR += nBxaPR
			nGBxJR += nBxaJR
			nGSlPR += nSldPR
			nGSlJR += nSldJR

			nTotPR := 0
			nSldPR := 0
			nBxaPR := 0
			nTotJR := 0
			nSldJR := 0
			nBxaJR := 0

		EndDo

		nLin += 1
		@nLin, 001 PSay PadL('Total para: '+cFornec+' --->',64)
		@nLin, 074 PSay Transform(nFTtPR,  '@E 99,999,999.99')
		@nLin, 090 PSay Transform(nFTtJR,  '@E 99,999,999.99')
		@nLin, 106 PSay Transform(nFTtPR+nFTtJR, '@E 999,999,999.99')
		@nLin, 123 PSay Transform(nFBxPR,  '@E 99,999,999.99')
		@nLin, 139 PSay Transform(nFBxJR,  '@E 99,999,999.99')
		@nLin, 155 PSay Transform(nFBxPR+nFBxJR, '@E 999,999,999.99')
		@nLin, 172 PSay Transform(nFSlPR,  '@E 99,999,999.99')
		@nLin, 188 PSay Transform(nFSlJR,  '@E 99,999,999.99')
		@nLin, 204 PSay Transform(nFSlPR+nFSlJR, '@E 999,999,999.99')
		nLin += 2

		nFTtPR := 0
		nFTtJR := 0
		nFBxPR := 0
		nFBxJR := 0
		nFSlPR := 0
		nFSlJR := 0

	EndDo

	nLin += 1
	@nLin, 001 PSay PadL('Total Geral dos Contratos Listados ------>',64)
	@nLin, 074 PSay Transform(nGTtPR,  '@E 99,999,999.99')
	@nLin, 090 PSay Transform(nGTtJR,  '@E 99,999,999.99')
	@nLin, 106 PSay Transform(nGTtPR+nGTtJR, '@E 999,999,999.99')
	@nLin, 123 PSay Transform(nGBxPR,  '@E 99,999,999.99')
	@nLin, 139 PSay Transform(nGBxJR,  '@E 99,999,999.99')
	@nLin, 155 PSay Transform(nGBxPR+nGBxJR, '@E 999,999,999.99')
	@nLin, 172 PSay Transform(nGSlPR,  '@E 99,999,999.99')
	@nLin, 188 PSay Transform(nGSlJR,  '@E 99,999,999.99')
	@nLin, 204 PSay Transform(nGSlPR+nGSlJR, '@E 999,999,999.99')

	Roda()

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return
