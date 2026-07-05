/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AGRR205   º Autor ³ Ricardo Tomasi     º Data ³  24/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio para impressão de Previsto X Realizado, das      º±±
±±º          ³ aplicações.                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Cliente Microsiga                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AGRR205()
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Quantidades Aplicadas."
	Local titulo         := "Quantidades Aplicadas"
	Local nLin           := 80
	Local Cabec1         := ""
	Local Cabec2         := ""
	Local aOrd           := {"Fazenda+Fases+Serviços+Talhões"}

	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private limite       := 132
	Private tamanho      := "M"
	Private nomeprog     := "AGRR205"
	Private nTipo        := 18
	Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey     := 0
	Private cbtxt        := Space(10)
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private cPerg        := "AGR205"
	Private wnrel        := "AGRR205"
	Private cString      := "NP5"

	dbSelectArea("NP5")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

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
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  24/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin, nReg)
	Local nRegist    := 0
	Local cCodigo    := ''
	Local nQuant     := 0

	Local nCusto
	Local nCustUN    := 0
	Local nCustHA    := 0

	Local nTamTal    := 0

	Local nTotalFaz  := 0
	Local nTotalFase := 0
	Local nTotalServ := 0
	Local nTotalTalh := 0

	Local nFazCustUN := 0
	Local nFasCustUN := 0
	Local nSrvCustUN := 0
	Local nTalCustUN := 0

	Local nFazCustHA := 0
	Local nFasCustHA := 0
	Local nSrvCustHA := 0
	Local nTalCustHA := 0

	Local cSafAnt  := MV_PAR01
	Local cFazAnt  := ""
	Local cFaseAnt := ""
	Local cSrvAnt  := ""
	Local cTalAnt  := ""

	Local cArq := ""
	Local cInd := ""
	Local cFil := ""

	Cabec1 := "SAFRA: " + cSafAnt + " " + Posicione("NN1",1,xFilial("NN1")+cSafAnt,"NN1_DESCRI")
	//                   1         2         3         4         5         6         7         8         9         0         1         2         3
	//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	Cabec2 := "                                                                    Quantidade     Area/HA      Custo/UN    Custo/HA     Custo Total"
	//                                                                                           9,999.99    999,999.99  999,999.99  999,999,999.99
	dbSelectArea("NP5")

	cArq := CriaTrab(Nil,.F.)
	cInd := "NP5_FAZ+NP5_FASE+NP5_CODSRV+NP5_TALHAO"

	cFil += "NP5_SAFRA  == MV_PAR01 .And. "
	cFil += "NP5_FAZ    >= MV_PAR02 .And. "
	cFil += "NP5_FAZ    <= MV_PAR03 .And. "
	cFil += "NP5_TALHAO >= MV_PAR04 .And. "
	cFil += "NP5_TALHAO <= MV_PAR05 .And. "
	cFil += "NP5_CODSRV >= MV_PAR06 .And. "
	cFil += "NP5_CODSRV <= MV_PAR07 .And. "
	cFil += "NP5_DATA   >= MV_PAR08 .And. "
	cFil += "NP5_DATA   <= MV_PAR09"  

	IndRegua("NP5",cArq,cInd,,cFil,"Selecionando Registros...")

	While !Eof()

		cFazAnt := NP5->NP5_FAZ

		If lAbortPrint
			@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif

		While NP5->NP5_FAZ == cFazAnt

			cFaseAnt := NP5->NP5_FASE

			If lAbortPrint
				@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
				Exit
			Endif

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif

			While NP5->NP5_FAZ == cFazAnt .And. NP5->NP5_FASE == cFaseAnt

				If lAbortPrint
					@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
					Exit
				Endif

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif

				cSrvAnt := NP5->NP5_CODSRV

				While NP5->NP5_FAZ == cFazAnt .And. NP5->NP5_FASE == cFaseAnt .And. NP5->NP5_CODSRV == cSrvAnt

					If lAbortPrint
						@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
						Exit
					Endif

					If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
						Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
						nLin := 9
					Endif

					cTalAnt := NP5->NP5_TALHAO

					While NP5->NP5_FAZ == cFazAnt .And. NP5->NP5_FASE == cFaseAnt .And. NP5->NP5_CODSRV == cSrvAnt .And. NP5->NP5_TALHAO == cTalAnt

						nTamTal := NP5->NP5_AREA

						dbSelectArea("NP6")
						dbSetOrder(1)
						If dbSeek(xFilial("NP6")+NP5->NP5_CODIGO)
							While NP6->NP6_CODIGO == NP5->NP5_CODIGO
								If NP6->NP6_TIPO == "MO" .And. (MV_PAR11 = 1 .Or. MV_PAR11 = 3)
									cCodigo    := AllTrim(NP6->NP6_MOCOD)
									cDescr     := AllTrim(NP6->NP6_MONOM)
									//--------------------------------------------------
									nRegist := Recno()
									nQuant  := 0
									nCusto  := 0
									dbSetOrder(2)
									If dbSeek(xFilial('NP6')+NP5->NP5_CODIGO+'MO'+cCodigo)
										While NP6->NP6_CODIGO == NP5->NP5_CODIGO .And. NP6->NP6_TIPO == "MO" .And. NP6->NP6_MOCOD = cCodigo
											nQuant := nQuant + NP6->NP6_QTDTOT
											nCusto := nCusto + NP6->NP6_CUSTO
											dbSkip()
										EndDo
									EndIf
									dbSetOrder(1)
									dbGoto(nRegist)
									//--------------------------------------------------
									nCustUN    := nCusto / nQuant
									nCustHA    := nCusto / nTamTal
									nTotalTalh := nTotalTalh + nCusto
									nTalCustUN := nTalCustUN + nCustUN
									nTalCustHA := nTalCustHA + nCustHA
									If MV_PAR10 = 2 //1-Sintetico 2-Analitico
										@ nLin, 020 PSay PadR(cCodigo + " - " + cDescr,40)
										@ nLin, 061 PSay nQuant          Picture "@E 999,999,999.99"
										@ nLin, 076 PSay NP6->NP6_UM     Picture "@!"
										@ nLin, 082 PSay nTamTal         Picture "@E 9,999.99"
										@ nLin, 094 PSay nCustUN         Picture "@E 999,999.99"
										@ nLin, 106 PSay nCustHA         Picture "@E 999,999.99"
										@ nLin, 118 PSay nCusto          Picture "@E 999,999,999.99"
										nLin++

										If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
											Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
											nLin := 9
										Endif

									EndIf
								ElseIf NP6->NP6_TIPO == "EQ" .And. (MV_PAR11 = 1 .Or. MV_PAR11 = 2)
									cCodigo := AllTrim(NP6->NP6_EQCOD)
									cDescr  := AllTrim(NP6->NP6_EQNOM)
									//--------------------------------------------------
									nRegist := Recno()
									nQuant  := 0
									nCusto  := 0
									dbSetOrder(3)
									If dbSeek(xFilial('NP6')+NP5->NP5_CODIGO+'EQ'+cCodigo)
										While NP6->NP6_CODIGO == NP5->NP5_CODIGO .And. NP6->NP6_TIPO == "EQ" .And. NP6->NP6_EQCOD = cCodigo
											nQuant := nQuant + NP6->NP6_QTDTOT
											nCusto := nCusto + NP6->NP6_CUSTO
											dbSkip()
										EndDo
									EndIf
									dbSetOrder(2)
									dbGoto(nRegist)
									//--------------------------------------------------
									nCustUN    := nCusto / nQuant
									nCustHA    := nCusto / nTamTal
									nTotalTalh := nTotalTalh + nCusto
									nTalCustUN := nTalCustUN + nCustUN
									nTalCustHA := nTalCustHA + nCustHA
									If MV_PAR10 = 2 //1-Sintetico 2-Analitico
										@ nLin, 020 PSay PadR(cCodigo + " - " + cDescr,40)
										@ nLin, 061 PSay nQuant          Picture "@E 999,999,999.99"
										@ nLin, 076 PSay NP6->NP6_UM     Picture "@!"
										@ nLin, 082 PSay nTamTal         Picture "@E 9,999.99"
										@ nLin, 094 PSay nCustUN         Picture "@E 999,999.99"
										@ nLin, 106 PSay nCustHA         Picture "@E 999,999.99"
										@ nLin, 118 PSay nCusto          Picture "@E 999,999,999.99"
										nLin++
										If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
											Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
											nLin := 9
										Endif
									EndIf
								ElseIf NP6->NP6_TIPO == "PD" .And. (MV_PAR11 = 1 .Or. MV_PAR11 = 4)
									cCodigo := AllTrim(NP6->NP6_PDCOD)
									cDescr  := AllTrim(NP6->NP6_PDNOM)
									//--------------------------------------------------
									nRegist := Recno()
									nQuant  := 0
									nCusto  := 0
									dbSetOrder(4)
									If dbSeek(xFilial('NP6')+NP5->NP5_CODIGO+'PD'+cCodigo)
										While NP6->NP6_CODIGO == NP5->NP5_CODIGO .And. NP6->NP6_TIPO == "PD" .And. NP6->NP6_PDCOD = cCodigo
											nQuant := nQuant + NP6->NP6_QTDTOT
											nCusto := nCusto + NP6->NP6_CUSTO
											dbSkip()
										EndDo
									EndIf
									dbSetOrder(1)
									dbGoto(nRegist)
									//--------------------------------------------------
									nCustUN    := nCusto / nQuant
									nCustHA    := nCusto / nTamTal
									nTotalTalh := nTotalTalh + nCusto
									nTalCustUN := nTalCustUN + nCustUN
									nTalCustHA := nTalCustHA + nCustHA
									If MV_PAR10 = 2 //1-Sintetico 2-Analitico
										@ nLin, 020 PSay PadR(cCodigo + " - " + cDescr,40)
										@ nLin, 061 PSay nQuant          Picture "@E 999,999,999.99"
										@ nLin, 076 PSay NP6->NP6_UM     Picture "@!"
										@ nLin, 082 PSay nTamTal         Picture "@E 9,999.99"
										@ nLin, 094 PSay nCustUN         Picture "@E 999,999.99"
										@ nLin, 106 PSay nCustHA         Picture "@E 999,999.99"
										@ nLin, 118 PSay nCusto          Picture "@E 999,999,999.99"
										nLin++
										If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
											Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
											nLin := 9
										Endif
									EndIf
								EndIf

								dbSkip()
							EndDo
						EndIf

						dbSelectArea("NP5")
						dbSkip()
					EndDo

					//Imprimir totalização com a descrição do talhão
					@ nLin, 015 PSay PadR("Resumo do Talhão: " + cTalAnt + " " + fRetTalDes(cSafAnt+cFazAnt+cTalAnt), 45)
					@ nLin, 082 PSay nTotalTalh / nTalCustHA Picture "@E 9,999.99"
					@ nLin, 094 PSay nTalCustUN  Picture "@E 999,999.99"
					@ nLin, 106 PSay nTalCustHA  Picture "@E 999,999.99"
					@ nLin, 118 PSay nTotalTalh  Picture "@E 999,999,999.99"

					nLin++

					If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
						Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
						nLin := 9
					Endif

					nTotalServ := nTotalServ + nTotalTalh
					nSrvCustUN := nSrvCustUN + nTalCustUN
					nSrvCustHA := nSrvCustHA + nTalCustHA
					nTalCustUN := 0
					nTalCustHA := 0
					nTotalTalh := 0

				EndDo

				//Imprimir totalização com a descrição do serviço
				@ nLin, 010 PSay PadR("Resumo do Serviço: " + cSrvAnt + " " + fRetSrvDes(cSrvAnt),50)
				@ nLin, 082 PSay nTotalServ / nSrvCustHA Picture "@E 9,999.99"
				@ nLin, 094 PSay nSrvCustUN  Picture "@E 999,999.99"
				@ nLin, 106 PSay nSrvCustHA  Picture "@E 999,999.99"
				@ nLin, 118 PSay nTotalServ  Picture "@E 999,999,999.99"

				nLin++

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif

				nTotalFase := nTotalFase + nTotalServ
				nFasCustUN := nFasCustUN + nSrvCustUN
				nFasCustHA := nFasCustHA + nSrvCustHA
				nSrvCustUN := 0
				nSrvCustHA := 0
				nTotalServ := 0

			EndDo

			//Imprimir totalização com a descrição da fase
			@ nLin, 005 PSay PadR("Resumo da Fase: " + IIf(cFaseAnt == "1","Preparação do Solo",IIf(cFaseAnt == "2","Plantio",IIf(cFaseAnt == "3","Manutenção da Lavoura","CoNP6ita"))),55)
			@ nLin, 082 PSay nTotalFase / nFasCustHA Picture "@E 9,999.99"
			@ nLin, 094 PSay nFasCustUN  Picture "@E 999,999.99"
			@ nLin, 106 PSay nFasCustHA  Picture "@E 999,999.99"
			@ nLin, 118 PSay nTotalFase  Picture "@E 999,999,999.99"

			nLin++

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif

			nTotalFaz  := nTotalFaz + nTotalFase
			nFazCustUN := nFazCustUN + nFasCustUN
			nFazCustHA := nFazCustHA + nFasCustHA
			nFasCustUN := 0
			nFasCustHA := 0
			nTotalFase := 0

		EndDo

		//Imprimir totalização com a descrição da fase
		@ nLin, 000 PSay PadR("Resumo da Fazenda: " + cFazAnt + " " + Posicione("NN2",2,xFilial("NN2")+cFazAnt,"NN2_NOME"),60)
		@ nLin, 082 PSay nTotalFaz / nFazCustHA Picture "@E 9,999.99"
		@ nLin, 094 PSay nFazCustUN  Picture "@E 999,999.99"
		@ nLin, 106 PSay nFazCustHA  Picture "@E 999,999.99"
		@ nLin, 118 PSay nTotalFaz  Picture "@E 999,999,999.99"

		nLin++

		nTotalFaz  := 0
		nFazCustUN := 0
		nFazCustHA := 0

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

Static Function fRetTalDes(cCodigo)
	Local cAliasAT := Alias()
	Local cRetorno := ''

	dbSelectArea("NN3")
	dbSetOrder(1)
	dbGoTop()
	dbSeek(xFilial("NN3")+cCodigo,.T.)

	cRetorno := NN3->NN3_DESCRI

	dbSelectArea(cAliasAT)
Return(cRetorno)

Static Function fRetSrvDes(cCodigo)
	Local cAliasAT := Alias()
	Local cRetorno := ''

	dbSelectArea("NN9")
	dbSetOrder(1)
	dbGoTop()
	dbSeek(xFilial("NN9")+cCodigo,.T.)

	cRetorno := NN9->NN9_DESCRI

	dbSelectArea(cAliasAT)
Return(cRetorno)
