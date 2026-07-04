/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr868.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR868  ³ Autor ³ Denis Hyroshi de Souza³ Data ³ 24/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Emitir o resumo de acidentes sem vitima                     ³±±
±±³          ³conforme o Quadro VI  da NR4.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MDTR865(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR868

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM( )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString := "SI3"
Local wnrel   := "MDTR868"
Local cDesc1  := STR0001 //"Emitir o resumo de acidentes sem vitima "
Local cDesc2  := STR0002 //"conforme o Quadro VI da NR4."
Local cDesc3  := " "

Private aReturn  := { STR0003, 1, STR0004, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private nomeprog := "MDTR868"
Private tamanho  := "M"
Private titulo   := STR0005 //"Quadro de Acidentes sem Vitima"
Private ntipo    := 0
Private nLastKey := 0
Private cPerg    := "MDT868    "
Private cabec1   := " "
Private cabec2   := " "
Private cAliasCC := "SI3"
Private cDescrCC := "SI3->I3_DESC"
Private cFiliaCC := "SI3->I3_FILIAL"
Private cCodigCC := "SI3->I3_CUSTO"
Private nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
Private nSizeFil := FwSizeFilial()
Private lCompTNC := (NGSX2MODO("TNC") == "C")
Private lMdtps   := .f.
nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
nSizeTD := nTa1

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cDescrCC := "CTT->CTT_DESC01"
	cFiliaCC := "CTT->CTT_FILIAL"
	cCodigCC := "CTT->CTT_CUSTO"
	cString  := "CTT"
Endif
If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
	lMdtps := .t.
Endif
lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
cPerg    := If(!lSigaMdtps,"MDT868    ","MDT868PS  ")

/*--------------------
//PADRÃO				|
| De Data ?			|
| Ate Data ?			|
| Data do mapa ?		|
| Responsavel ?		|
| De Filial ?			|
| Ate Filial ?		|
| 						|
//PRESTADOR			|
| De Cliente ?		|
| Loja					|
| Até Cliente ?		|
| Loja					|
| De Data ?			|
| Ate Data ?			|
| Data do mapa ?		|
| Responsavel ?		|
| De Filial ?			|
| Ate Filial ?		|
---------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

If lSigaMdtps
	dDataMap := mv_par07
	cCodResp := mv_par08
Else
	dDataMap := mv_par03
	cCodResp := mv_par04
Endif

RptStatus({|lEnd| R868Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)
dbSelectArea("SM0")
dbSeek(cEmpAnt+cFilAnt)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R868Imp  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 24/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR868                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R868Imp(lEnd,wnRel,titulo,tamanho)

	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local nYY,nXX,i
	Local oTempTable
	Local lAvgFunPE := If( SuperGetMv("MV_MDTAVGF",.F.,"N") == "S", .t. , .f. )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Contadores de linha e pagina                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private li := 80 ,m_pag := 1 ,nQtTotFunc  := 0 ,lPRINT := .t.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis exclusivas deste programa                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private nQtsemvit, nQtcomvit, nValormat, cCentroCusto
	Private aFiliais := {}, cFilAtual := cFilAnt, cNomFil := Upper(Substr(SM0->M0_NOME, 1, 40))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se deve comprimir ou nao                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTipo  := IIF(aReturn[4]==1,15,18)

	cCodcli := ""
	nQtFun := 0

	//============================================================================
	aDBF := {}
	AADD(aDBF,{ "CCUSTO"  , "C" ,nSizeSI3, 0 })
	AADD(aDBF,{ "QTDACI"  , "N" ,06, 0 })
	AADD(aDBF,{ "SEMVIT"  , "N" ,06, 0 })
	AADD(aDBF,{ "COMVIT"  , "N" ,06, 0 })
	AADD(aDBF,{ "VALMAT"  , "N" ,12, 2 })

	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
	oTempTable:AddIndex( "1", {"CCUSTO"} )
	oTempTable:Create()

	If !lSigaMdtps .and. !lMdtps
		aFiliais := MDTRETFIL("SRA", MV_PAR05, MV_PAR06)
	Else
		aFiliais := { {cFilAnt, Upper(Substr(SM0->M0_NOME, 1, 40)) } }
	Endif

	For i:=1 To Len(aFiliais)
		cFilAtual	:= aFiliais[i,1]
		cNomFil		:= aFiliais[i,2]

		dbSelectArea("SM0")
		dbSeek(cEmpAnt+cFilAtual)

		dbSelectArea("TRB")
		ZAP

		nQtAciden := 0
		nQtsemvit := 0
		nQtcomvit := 0
		nValormat := 0

		nRegTotal := ( TNC->(LastRec()) * 2 )

		lFirst  := .t.
		lPRINT := .t.

		If lSigaMdtps

			SetRegua(nRegTotal)

			aDadosTNC := {}
			DbSelectArea("TNC")
			DbSetOrder(11)  //TNC_FILIAL+TNC_CLIENT+TNC_LOJA+TNC_CC
			DbSeek(xFilial("TNC",cFilAtual)+mv_par01+mv_par02,.t.)
			While !EOF() .AND. TNC->TNC_Filial == xFilial("TNC",cFilAtual) .and. ;
				TNC->(TNC_CLIENT+TNC_LOJA) >= mv_par01+mv_par02 .and. TNC->(TNC_CLIENT+TNC_LOJA) <= mv_par03+mv_par04

				IncRegua()
				If !Empty(TNC->TNC_CC)
					If TNC->TNC_DTACID >= MV_PAR05 .and. TNC->TNC_DTACID <= MV_PAR06
						aAdd( aDadosTNC , { TNC->TNC_ACIDEN, TNC->TNC_CATINS, TNC->TNC_NUMFIC, TNC->TNC_AFASTA,;
											TNC->TNC_QTAFAS, TNC->TNC_TIPCAT, TNC->TNC_CC, TNC->(TNC_CLIENT+TNC_LOJA) } )
					Endif
				Endif

				DbSelectArea("TNC")
				DbSkip()
			End

			aSort(aDadosTNC,,,{|x,y| x[7]+x[2]+x[6] < y[7]+y[2]+y[6] })

			For nXX := 1 To Len(aDadosTNC)
				IncRegua()
				cCodInss := aDadosTNC[nXX,7]+aDadosTNC[nXX,2]
				cCentroCusto := aDadosTNC[nXX,7]
				If !Empty(aDadosTNC[nXX,2])
					nRegValido := nXX
					For nYY := nXX To Len(aDadosTNC)
						If cCodInss == aDadosTNC[nYY,7]+aDadosTNC[nYY,2]
							nRegValido := nYY
						Else
							Exit
						Endif
					Next nYY
					nXX := nRegValido
				Endif

				nQtAciden++
				Dbselectarea("TNM")
				Dbsetorder(03)  //TNM_FILIAL+TNM_CLIENT+TNM_LOJA+TNM_ACIDEN+TNM_CODDES
				Dbseek(xFilial("TNM",cFilAtual)+aDadosTNC[nXX,8]+aDadosTNC[nXX,1])
				While !eof() .and. xFilial("TNM",cFilAtual)+aDadosTNC[nXX,8]+aDadosTNC[nXX,1] == TNM->TNM_Filial+TNM->TNM_CLIENT+TNM->TNM_LOJA+TNM->TNM_ACIDEN
					Dbselectarea("TNL")
					Dbsetorder(1)  //TNL_FILIAL+TNL_CLIENT+TNL_LOJA+TNL_CODDES
					If DBseek(xFilial("TNL",cFilAtual)+TNM->TNM_CLIENT+TNM->TNM_LOJA+TNM->TNM_CODDES)
						nValormat += TNM->TNM_VALDES
					Endif
					Dbselectarea("TNM")
					Dbskip()
				End
				If !Empty(aDadosTNC[nXX,3])
					If aDadosTNC[nXX,4] == "1" .or. aDadosTNC[nXX,5] > 0
						nQtcomvit++
					Else
						nQtsemvit++
					Endif
				Endif

				If Len(aDadosTNC) == nXX
					If nQtAciden > 0
						GRAVATRB()
						lFirst  := .f.
					Endif
				Else
					If cCentroCusto != aDadosTNC[nXX+1,7]
						If nQtAciden > 0
							GRAVATRB()
							lFirst  := .f.
						Endif
					Endif
				EndIf

			Next nXX

		Else

			//Acumula o total de funcionarios do estabelecimento (NAO PRESTADOR)
			If lAvgFunPE //Se existir parametro MV_MDTAVGF e este for igual a S, faz a media mensal de funcionarios
				nRegTotal += ( SRA->(LastRec()) * Round((Mv_par02 - Mv_par01) / 30,0) )
				SetRegua(nRegTotal)
				nQtTotFunc := 0
				nQtdeTemp := 0
				nContador := 0
				dDataTemp := Mv_par01
				While dDataTemp <= Mv_par02
					_Mvpar01 := StoD(	StrZero(Year(dDataTemp),4) + ;
					StrZero(Month(dDataTemp),2) + ;
					"01" )
					_Mvpar02 := ""
					If Month(dDataTemp) == 12
						_Mvpar02 := StoD(  StrZero(Year(dDataTemp)+1,4) + ;
						"01" + ;
						"01" ) - 1
					Else
						_Mvpar02 := StoD(  StrZero(Year(dDataTemp),4) + ;
						StrZero(Month(dDataTemp)+1,2) + ;
						"01" ) - 1
					Endif

					nQtdeTemp += MDTCAGED(_Mvpar01,_Mvpar02,,,cFilAtual,,,.T.)
					nContador++

					If Month(dDataTemp) == 12
						dDataTemp := StoD(  StrZero(Year(dDataTemp)+1,4) + ;
						"01" + ;
						"01" )
					Else
						dDataTemp := StoD(  StrZero(Year(dDataTemp),4) + ;
						StrZero(Month(dDataTemp)+1,2) + ;
						"01" )
					Endif
				End
				nQtTotFunc := nQtdeTemp / nContador
			Else
				nRegTotal += SRA->(LastRec())
				SetRegua(nRegTotal)
				nQtTotFunc := MDTCAGED(Mv_par01,Mv_par02,,,cFilAtual,,,.T.)
			Endif

			aDadosTNC := {}
			DbSelectArea("TNC")
			DbSetOrder(5)
			DbSeek(xFilial("TNC",cFilAtual))
			While !EOF() .AND. TNC->TNC_Filial == xFilial("TNC",cFilAtual)

				IncRegua()
				If lCompTNC
					If AllTrim(TNC->TNC_FILFUN) != AllTrim(cFilAtual)
						DbSelectArea("TNC")
						DbSkip()
						Loop
					Endif
				Endif
				If !Empty(TNC->TNC_CC)
					If TNC->TNC_DTACID >= Mv_par01 .and. TNC->TNC_DTACID <= Mv_par02
						aAdd( aDadosTNC , { TNC->TNC_ACIDEN, TNC->TNC_CATINS, TNC->TNC_NUMFIC, TNC->TNC_AFASTA,;
						TNC->TNC_QTAFAS, TNC->TNC_TIPCAT, TNC->TNC_CC } )
					Endif
				Endif

				DbSelectArea("TNC")
				DbSkip()
			End

			aSort(aDadosTNC,,,{|x,y| x[7]+x[2]+x[6] < y[7]+y[2]+y[6] })

			For nXX := 1 To Len(aDadosTNC)
				IncRegua()
				cCodInss := aDadosTNC[nXX,7]+aDadosTNC[nXX,2]
				cCentroCusto := aDadosTNC[nXX,7]
				If !Empty(aDadosTNC[nXX,2])
					nRegValido := nXX
					For nYY := nXX To Len(aDadosTNC)
						If cCodInss == aDadosTNC[nYY,7]+aDadosTNC[nYY,2]
							nRegValido := nYY
						Else
							Exit
						Endif
					Next nYY
					nXX := nRegValido
				Endif

				nQtAciden++
				Dbselectarea("TNM")
				Dbsetorder(1)
				Dbseek(xFilial("TNM",cFilAtual)+aDadosTNC[nXX,1])
				While !eof() .and. aDadosTNC[nXX,1] == TNM->TNM_ACIDEN .and. TNM->TNM_Filial == xFilial("TNM",cFilAtual)
					Dbselectarea("TNL")
					Dbsetorder(1)
					If DBseek(xFilial("TNL",cFilAtual)+TNM->TNM_CODDES)
						nValormat += TNM->TNM_VALDES
					Endif
					Dbselectarea("TNM")
					Dbskip()
				End
				If !Empty(aDadosTNC[nXX,3])
					If aDadosTNC[nXX,4] == "1" .or. aDadosTNC[nXX,5] > 0
						nQtcomvit++
					Else
						nQtsemvit++
					Endif
				Endif

				If Len(aDadosTNC) == nXX
					If nQtAciden > 0
						GRAVATRB()
						lFirst  := .f.
					Endif
				Else
					If cCentroCusto != aDadosTNC[nXX+1,7]
						If nQtAciden > 0
							GRAVATRB()
							lFirst  := .f.
						Endif
					Endif
				EndIf

			Next nXX

		Endif

		If lFirst  //Se não houver dados p/ imprimir, tem que imprimir o quadro vazio conforme a lei exige
			If lMdtps
				dbSelectArea(cAliasCC)
				dbSetOrder(1)
				dbSeek(xFilial(cAliasCC,cFilAtual))
				While !eof() .and. xFilial(cAliasCC,cFilAtual) == &(cFiliaCC)

					If cCodCli <> SubSTR(&(cCodigCC),1,nTa1)
						cCodCli := SubSTR(&(cCodigCC),1,nTa1)
						_RESEMVIT()
					Endif

					dbSelectArea(cAliasCC)
					dbSkip()
				End
			Elseif lSigaMdtps
				dbSelectArea(cAliasCC)
				dbSetOrder(1)
				dbSeek(xFilial(cAliasCC,cFilAtual)+mv_par01+mv_par02,.t.)
				While !eof() .and. xFilial(cAliasCC,cFilAtual) == &(cFiliaCC) .and. SubSTR(&(cCodigCC),1,nSizeTD) <= mv_par03+mv_par04

					If cCodCli <> SubSTR(&(cCodigCC),1,nSizeTD)
						cCodCli := SubSTR(&(cCodigCC),1,nSizeTD)
						_RESEMVIT()
					Endif

					dbSelectArea(cAliasCC)
					dbSkip()
				End
			Else
				_RESEMVIT()
			Endif
		Else
			If lMdtps
				RESEMVIT()
				dbSelectArea(cAliasCC)
				dbSetOrder(1)
				dbSeek(xFilial(cAliasCC,cFilAtual))
				While !eof() .and. xFilial(cAliasCC,cFilAtual) == &(cFiliaCC)

					If cCodCli <> SubSTR(&(cCodigCC),1,nTa1)
						cCodCli := SubSTR(&(cCodigCC),1,nTa1)

						dbSelectArea("TRB")
						If !dbSeek(cCodCli)
							_RESEMVIT()
						Endif
					Endif

					dbSelectArea(cAliasCC)
					dbSkip()
				End
			Elseif lSigaMdtps
				RESEMVIT()
				dbSelectArea(cAliasCC)
				dbSetOrder(1)
				dbSeek(xFilial(cAliasCC,cFilAtual)+mv_par01+mv_par02,.t.)
				While !eof() .and. xFilial(cAliasCC,cFilAtual) == &(cFiliaCC) .and. SubSTR(&(cCodigCC),1,nSizeTD) <= mv_par03+mv_par04

					If cCodCli <> SubSTR(&(cCodigCC),1,nSizeTD)
						cCodCli := SubSTR(&(cCodigCC),1,nSizeTD)

						dbSelectArea("TRB")
						If !dbSeek(cCodCli)
							_RESEMVIT()
						Endif
					Endif

					dbSelectArea(cAliasCC)
					dbSkip()
				End
			Else
				RESEMVIT()
			Endif
		Endif
	Next i

	Roda(nCntImpr,cRodaTxt,Tamanho)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve a condicao original do arquivo principal             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	RetIndex(cAliasCC)

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

	dbSelectArea("TRB")
	use
	dbSelectArea(cAliasCC)
	dbSetOrder(01)

Return NIL

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   | GRAVATRB  ³ Autor³Liber De Esteban       ³ Data  ³ 28/06/05³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Grava os dados dos acidentes na tabela TRB.                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function GRAVATRB()

DbSelectArea("TRB")
If !DbSeek(cCentroCusto)
	TRB->(DbAppend())
	TRB->CCUSTO := cCentroCusto
	TRB->QTDACI := nQtAciden
	TRB->SEMVIT := nQtsemvit
	TRB->COMVIT := nQtcomvit
	TRB->VALMAT := nValormat
EndIF

nQtAciden := 0
nQtsemvit := 0
nQtcomvit := 0
nValormat := 0

Return  .t.

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   |  RESEMVIT ³ Autor³Denis Hyroshi de Souza ³ Data  ³ 24/07/02³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o Resumo dos Acidentes Com Vitimas                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ RESEMVIT                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Codigo Centro de Custo                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR868                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function RESEMVIT()

Private nAcid_estab  := 0
Private nValo_estab  := 0
Private nSemv_estab  := 0
Private nComv_estab  := 0
Private lFlag        := .f.

Dbselectarea("TRB")
DbGotop()
If lSigaMdtps
	cCodcli := Substr(TRB->CCUSTO,1,nSizeTD)
Endif

While !Eof()

	If (lMdtps .or. lSigaMdtps) .and. !lPRINT
		If cCodcli != Substr(TRB->CCUSTO,1,nSizeTD)
			cCodcli := Substr(TRB->CCUSTO,1,nSizeTD)
			MDT868SETOR()
			MDT868QUAD()
			lPRINT := .t.
		EndIf
	EndIf

	If lPRINT
		SomaLinha()
		@ Li,000 PSay " "

		SomaLinha()
		@ Li,001 PSay Replicate("_",118)
		Somalinha()
		@ Li,000 PSay "|"
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay STR0007 //"|ACIDENTES SEM VITIMA__________________________________ PERIODO DE"
		@ Li,068 PSay If(lSigaMdtPs,Alltrim(DtoC(Mv_par05)),Alltrim(DtoC(Mv_par01)))
		@ Li,079 PSay STR0037 //"ATE"
		@ Li,083 PSay If(lSigaMdtPs,Alltrim(DtoC(Mv_par06)),Alltrim(DtoC(Mv_par02)))
		If Empty(dDataMap)
			@ Li,094 PSay STR0038 //"DATA DO MAPA: ___/__/___ |"
		Else
			@ Li,094 PSay STR0039 //"DATA DO MAPA:"
			@ Li,108 PSay Alltrim(DtoC(dDataMap))
			@ Li,119 PSay "|"
		Endif

		Somalinha()
		@ Li,000 PSay "|"
		@ Li,119 PSay "|"

		Somalinha()
		If Empty(cCodResp)
			@ Li,000 PSay STR0008 //"|RESPONSAVEL:________________________________________________  ASS:___________________________________ |"
		Else
			@ Li,000 PSay STR0023  //"| RESPONSAVEL:"
			@ Li,015 PSay SubStr( NGSEEK("TMK",cCodResp,1,"TMK->TMK_NOMUSU"),1,50 )
			@ Li,079 PSay STR0024  //ASS:___________________________________ |"
		Endif

		SomaLinha()
		@ Li,000 PSay "|"
		@ Li,001 PSay Replicate("_",118)
		@ Li,119 PSay "|"

		Somalinha()
		@ Li,000 PSay STR0009  //"|          Setor          |   Numero  |  Perda Material   |  Acid. S/Vitima  |      Observacoes        |"

		Somalinha()
		@ Li,000 PSay STR0010 //"|                         | Acidentes | Avaliada em Reais | ________________ |                         |"

		Somalinha()
		@ Li,000 PSay STR0011 //"|                         |           |                   |  Acid. C/Vitima  |                         |"

		Somalinha()
		@ Li,000 PSay "|_________________________________________|___________|___________________|__________________|_________________________|"

		lPRINT := .f.
	Endif
	lFlag     := .t.

	/*Acumula Para o Total do Estabelecimento*/
	nAcid_estab  += TRB->QTDACI
	nSemv_estab  += TRB->SEMVIT
	nComv_estab  += TRB->COMVIT

	Somalinha()
	@ Li,000 PSay "|"
	DbSelectArea(cAliasCC)
	DbSetOrder(1)
	DbSeek(xFilial(cAliasCC,cFilAtual)+TRB->CCUSTO)
	@ Li,001 PSay SUBSTR(&(cDescrCC),1,25)
	@ Li,042 PSay "|"
	@ Li,045 PSay TRB->QTDACI Picture "9999999"
	@ Li,054 PSay "|"
	@ Li,060 PSay TRB->VALMAT Picture '@E 999,999,999.99'
	@ Li,074 PSay "|"
	@ Li,078 PSay PadL( Alltrim(Str(TRB->SEMVIT,6)) + "/" + Alltrim(Str(TRB->COMVIT,6)) , 13)
	@ Li,093 PSay "|"
	@ Li,119 PSay "|"
	SomaLinha()
	@ Li,000 PSay "|_________________________________________|___________|___________________|__________________|_________________________|"
	nValo_estab  += TRB->VALMAT

	DbSelectArea("TRB")
	DbSkip()
End

MDT868SETOR()
MDT868QUAD()

Return .t.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   | _RESEMVIT ³ Autor³Andre E. Perez Alvarez ³ Data  ³ 29/02/08³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o Resumo dos Acidentes Com Vitimas                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ _RESEMVIT                                                  ³±±
±±³ Uso      ³ MDTR868                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function _RESEMVIT()

SomaLinha()
@ Li,000 PSay " "

SomaLinha()
@ Li,001 PSay Replicate("_",118)
Somalinha()
@ Li,000 PSay "|"
@ Li,119 PSay "|"

SomaLinha()
@ Li,000 PSay STR0007 //"|ACIDENTES SEM VITIMA_________________________________________ PERIODO DE"
@ Li,068 PSay If(lSigaMdtPs,Alltrim(DtoC(Mv_par05)),Alltrim(DtoC(Mv_par01)))
@ Li,079 PSay STR0037 //"ATE"
@ Li,083 PSay If(lSigaMdtPs,Alltrim(DtoC(Mv_par06)),Alltrim(DtoC(Mv_par02)))
If Empty(dDataMap)
	@ Li,094 PSay STR0038 //"DATA DO MAPA: ___/__/___ |"
Else
	@ Li,094 PSay STR0039 //"DATA DO MAPA:"
	@ Li,108 PSay DtoC(dDataMap)
	@ Li,119 PSay "|"
Endif

Somalinha()
@ Li,000 PSay "|"
@ Li,119 PSay "|"

Somalinha()
If Empty(cCodResp)
	@ Li,000 PSay STR0008 //"|RESPONSAVEL:________________________________________________  ASS:___________________________________ |"
Else
	@ Li,000 PSay STR0023  //"| RESPONSAVEL:"
	@ Li,015 PSay SubStr( NGSEEK("TMK",cCodResp,1,"TMK->TMK_NOMUSU"),1,50 )
	@ Li,079 PSay STR0024  //ASS:___________________________________ |"
Endif

SomaLinha()
@ Li,000 PSay "|"
@ Li,001 PSay Replicate("_",118)
@ Li,119 PSay "|"

Somalinha()
@ Li,000 PSay STR0009  //"|          Setor          |   Numero  |  Perda Material   |  Acid. S/Vitima  |      Observacoes        |"

Somalinha()
@ Li,000 PSay STR0010 //"|                         | Acidentes | Avaliada em Reais | ________________ |                         |"

Somalinha()
@ Li,000 PSay STR0011 //"|                         |           |                   |  Acid. C/Vitima  |                         |"

Somalinha()
@ Li,000 PSay "|_________________________________________|___________|___________________|__________________|_________________________|"


Somalinha()
@ Li,000 PSay "|"
@ Li,042 PSay "|"
@ Li,054 PSay "|"
@ Li,074 PSay "|"
@ Li,093 PSay "|"
@ Li,119 PSay "|"
SomaLinha()
@ Li,000 PSay "|_________________________________________|___________|___________________|__________________|_________________________|"

_MDT868SETOR()
MDT868QUAD()

Return .t.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   |MDT868SETOR³ Autor³Denis Hyroshi de Souza ³ Data  ³ 12/07/02³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o Resumo dos Acidentes Com Vitimas                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR825                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function MDT868SETOR()

Local aArea := GetArea()

If lFlag

	If lSigaMdtps

		//Acumula o total de funcionarios do estabelecimento (NAO PRESTADOR)

		nQtTotFunc := 0
		dbSelectArea("SRA")
		dbSetOrder(1)
		dbGoTop()
		While !Eof()
			If SRA->RA_ADMISSA >= Mv_par06 .or. (SRA->RA_DEMISSA <= Mv_par06 .and. !Empty(SRA->RA_DEMISSA))
				dbSelectArea("SRA")
				dbSkip()
				Loop
			Endif

			If SubStr(SRA->RA_CC,1,nSizeTD) <> cCodCli
				dbSelectArea("SRA")
				dbSkip()
				Loop
			Endif

			//Funcionários que não são regidos pela CLT (não possuem vínculo empregatício) não devem ser considerados
			//Autônomo  //Estagiário Mensalista  //Estagiário Horista
			If SRA->RA_CATFUNC == "A" .OR. SRA->RA_CATFUNC == "E" .OR. SRA->RA_CATFUNC == "G" .OR. SRA->RA_CATFUNC == "P"
				dbSelectArea("SRA")
				dbSkip()
				Loop
			Endif

			lTemSR8 := MDTChkSR8( "SR8" , 1 , xFilial("SR8")+SRA->RA_MAT,;
																"xFilial('SR8') == SR8->R8_FILIAL .and. SRA->RA_MAT == SR8->R8_MAT"	,;
																Mv_par05	,;
																Mv_par06 )

			//Se o funcionario nao está afastado, acumula no total
			If !lTemSR8
				nQtTotFunc++
			Endif

			dbSelectArea("SRA")
			dbSkip()
		End

		RestArea(aArea)

	Endif

	Somalinha()
	@ Li,000 PSay "|"
	If ( nQtTotFunc - Int(nQtTotFunc) ) == 0
		@ Li,001 PSay STR0012 + " (" + Alltrim(Str(nQtTotFunc,10)) + ")"//"Total do Estabelecimento"
	Else
		@ Li,001 PSay STR0012 + " (" + Alltrim( TransForm(nQtTotFunc,"@E 999,999.9") ) + ")"//"Total do Estabelecimento"
	Endif
	@ Li,042 PSay "|"
	@ Li,044 PSay nAcid_estab Picture "99999999"
	@ Li,054 PSay "|"
	@ Li,060 PSay nValo_estab Picture '@E 999,999,999.99'
	@ Li,074 PSay "|"
	@ Li,076 PSay PadL( Alltrim(Str(nSemv_estab,7)) + "/" + Alltrim(Str(nComv_estab,7)) , 15)
	@ Li,093 PSay "|"
	@ Li,119 PSay "|"
	SomaLinha()
	@ Li,000 PSay "|_________________________________________|___________|___________________|__________________|_________________________|"
EndIf

nAcid_estab  := 0
nValo_estab  := 0
nSemv_estab  := 0
nComv_estab  := 0
lFlag        := .f.

Return .t.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o |_ MDT868SETOR³ Autor³Andre E. Perez Alvarez ³ Data  ³ 29/02/08³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o Resumo dos Acidentes Com Vitimas                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR825                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function _MDT868SETOR()

Local aArea := GetArea()

If lSigaMdtps

	nQtTotFunc := 0
	dbSelectArea("SRA")
	dbSetOrder(1)
	dbGoTop()
	While !Eof()
		If SRA->RA_ADMISSA >= Mv_par06 .or. (SRA->RA_DEMISSA <= Mv_par06 .and. !Empty(SRA->RA_DEMISSA))
			dbSelectArea("SRA")
			dbSkip()
			Loop
		Endif

		If SubStr(SRA->RA_CC,1,nSizeTD) <> cCodCli
			dbSelectArea("SRA")
			dbSkip()
			Loop
		Endif

		//Funcionários que não são regidos pela CLT (não possuem vínculo empregatício) não devem ser considerados
		//Autônomo  //Estagiário Mensalista  //Estagiário Horista
		If SRA->RA_CATFUNC == "A" .OR. SRA->RA_CATFUNC == "E" .OR. SRA->RA_CATFUNC == "G" .OR. SRA->RA_CATFUNC == "P"
			dbSelectArea("SRA")
			dbSkip()
			Loop
		Endif

		lTemSR8 := MDTChkSR8( "SR8", 1 ,	xFilial("SR8")+SRA->RA_MAT ,;
															"xFilial('SR8') == SR8->R8_FILIAL .and. SRA->RA_MAT == SR8->R8_MAT" ,;
															Mv_par05 ,;
															Mv_par06 )

		//Se o funcionario nao está afastado, acumula no total
		If !lTemSR8
			nQtTotFunc++
		Endif

		dbSelectArea("SRA")
		dbSkip()
	End

	RestArea(aArea)
Endif

Somalinha()
@ Li,000 PSay "|"
If ( nQtTotFunc - Int(nQtTotFunc) ) == 0
	@ Li,001 PSay STR0012 + " (" + Alltrim(Str(nQtTotFunc,10)) + ")"//"Total do Estabelecimento"
Else
	@ Li,001 PSay STR0012 + " (" + Alltrim( TransForm(nQtTotFunc,"@E 999,999.9") ) + ")"//"Total do Estabelecimento"
Endif
@ Li,042 PSay "|"
@ Li,054 PSay "|"
@ Li,074 PSay "|"
@ Li,093 PSay "|"
@ Li,119 PSay "|"
SomaLinha()
@ Li,000 PSay "|_________________________________________|___________|___________________|__________________|_________________________|"

Return .t.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³Denis Hyroshi de Souza ³ Data ³ 03/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR868                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha()
    Li++
    If Li > 58
        lPRINT := .t.
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   | MDT868QUAD ³ Autor³Liber de Esteban       ³ Data  ³ 12/07/02³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o quadro com dados da empresa                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR868                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function MDT868QUAD()

If lMdtps .or. lSigaMdtps // se a empresa for prestadora de serviços
	dbSelectArea("SA1")
	dbSetOrder(01)
	dbSeek(xFilial("SA1",cFilAtual) + cCodcli)
	cNome := SA1->A1_NOME
	cEndereco := SA1->A1_END
	cCidade := SA1->A1_MUN
	If empty(SA1->A1_DDD)
		cTelefone := SA1->A1_TEL
	Else
		cTelefone := "(" + Alltrim(SA1->A1_DDD) + ")" + Alltrim(SA1->A1_TEL)
	EndIf
Else
	dbSelectArea("SM0")
	dbSeek(cEmpAnt+cFilAtual)
	cNome		:= SM0->M0_NOMECOM
	cEndereco	:= SM0->M0_ENDCOB
	cCidade		:= SM0->M0_CIDCOB
	cTelefone	:= SM0->M0_TEL
EndIf

Somalinha()
@ Li,000 PSay "|"
@ Li,002 PSay STR0029 //"DADOS DA EMPRESA"
@ Li,119 PSay "|"

Somalinha()
@ Li,000 PSay "|"
@ Li,119 PSay "|"

Somalinha()
@ Li,000 PSay "|"
@ Li,002 PSay STR0030 + Substr(cNome,1,45) //"EMPRESA.: "
@ Li,058 PSay STR0031 + AllTrim(cCidade) //"CIDADE..: "
@ Li,119 PSay "|"

Somalinha()
@ Li,000 PSay "|"
@ Li,002 PSay STR0032 + AllTrim(cEndereco) //"ENDERECO: "
@ Li,058 PSay STR0033 + AllTrim(cTelefone) //"TELEFONE: "
@ Li,119 PSay "|"

SomaLinha()
@ Li,000 PSay "|"
@ Li,001 PSay Replicate("_",118)
@ Li,119 PSay "|"

li := 60

Return .t.
/*
          1         2         3         4         5         6         7         8         9         0         1        12        13
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
 ______________________________________________________________________________________________________________________
|				                                                                                                       |
|ACIDENTES SEM VITIMA___________________________________ PERIODO DE 00/00/0000 ATE 00/00/0000 DATA DO MAPA: 00/00/0000 |
|																						        	                   |
|RESPONSAVEL:________________________________________________________________  ASS:___________________________________ |
|______________________________________________________________________________________________________________________|
|          Setor                          |   Numero  |  Perda Material   |  Acid. S/Vitima  |      Observacoes        |
|                                         | Acidentes | Avaliada em Reais | ________________ |                         |
|                                         |           |                   |  Acid. C/Vitima  |                         |
|_________________________________________|___________|___________________|__________________|_________________________|
|SETOR DE RECRUTAMENTO                    |  9999999  |           500,00  |   123456/123456  | XXXXXXXXXXXXXXXXXXXXXXX |
|_________________________________________|___________|___________________|__________________|_________________________|
|REFINARIA DE COCA                        |       23  |       111.901,09  |              22  | ZZZZZZZZZZZZZZZZZZZZZZZ |
|_________________________________________|___________|___________________|__________________|_________________________|
|SETOR DE ALMOXERIFADO                    |       92  |            10,09  |            9021  | WWWWWWWWWWWWWWWWWWWWWWW |
|_________________________________________|___________|___________________|__________________|_________________________|
|Total do Estabelecimento (1234567890)    |  1000999  |       209.292,99  |           10000  | EEEEEEEEEEEEEEEEEEEEEEE |
|_________________________________________|___________|___________________|__________________|_________________________|
*/