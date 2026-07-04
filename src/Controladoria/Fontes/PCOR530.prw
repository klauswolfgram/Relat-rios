/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "pcor530.ch"
#INCLUDE "PROTHEUS.CH"

#DEFINE CELLTAMDATA 300


/*/
_F_U_N_C_ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ PCOR530  ³ AUTOR ³ Edson Maricate        ³ DATA ³ 20/03/2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Programa de impressao do dem.Resumido saldo mov/Periodo      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ USO      ³ SIGAPCO                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³_DOCUMEN_ ³ U_PCOR530    (BASEADO NO RELATORIO PCOR520)                    ³±±
±±³_DESCRI_  ³ Programa de impressao do demonstrativo saldo mov/periodo     ³±±
±±³_FUNC_    ³ Esta funcao devera ser utilizada com a sua chamada normal a  ³±±
±±³          ³ partir do Menu do sistema.                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PCOR530(aPerg)
Local aArea		:= GetArea()
Local lOk		:= .F.
Local lEnd	:= .F.
Local aProcessa, aProcComp

Private aSavPar
Private cCadastro := STR0001 //"Cubos Comparativos - Dem. Resumido de Saldos/Movimentos por Periodo"
Private nLin	:= 10000
Private aPeriodos
Private cCfg01:=STR0004, cCfg02:=STR0005  ////"Previsto"###"Realizado"
Private aTotais := {.T.}
Private aSubTot := {}

Default aPerg := {}


If Len(aPerg) == 0
	oPrint := PcoPrtIni(cCadastro,.T.,2,,@lOk,"PCR520")
Else
	aEval(aPerg, {|x, y| &("MV_PAR"+StrZero(y,2)) := x})
	oPrint := PcoPrtIni(cCadastro,.T.,2,,@lOk,"")
EndIf

If lOk
	aSavPar := {MV_PAR01,MV_PAR02,MV_PAR03,MV_PAR04,MV_PAR05,MV_PAR06, MV_PAR07, MV_PAR08, MV_PAR09, MV_PAR10, MV_PAR11, MV_PAR12, MV_PAR13}
	aTotais[1] := (aSavPar[12]==1)

	If !Empty(aSavPar[07])
		dbSelectArea("AL3")
		dbSetOrder(1)
		If MsSeek(xFilial()+aSavPar[07])
			cCfg01 := AllTrim(AL3->AL3_DESCRI)
		EndIf
	EndIf
	If !Empty(aSavPar[09])
		dbSelectArea("AL3")
		dbSetOrder(1)
		If MsSeek(xFilial()+aSavPar[09])
			cCfg02 := AllTrim(AL3->AL3_DESCRI)
		EndIf
	EndIf

	aPeriodos := PcoRetPer(aSavPar[2]/*dIniPer*/, aSavPar[3]/*dFimPer*/, aSavPar[5]/*cTipoPer*/, aSavPar[6]==1/*lAcumul*/)

	aProcessa := PcoRunCube(aSavPar[1], Len(aPeriodos)*2, "Pcor530Sld", aSavPar[7], aSavPar[8], .T./*(aSavPar[11]==1)*/, /*aNiveis*/,/*aFilIni*/,/*aFilFim*/,/*lReserv*/, /*aCfgCube*/,/*lProcessa*/,.T./*lVerAcesso*/)

	aProcComp := PcoRunCube(aSavPar[1], Len(aPeriodos)*2, "Pcor530Sld", aSavPar[9], aSavPar[10], .T./*(aSavPar[11]==1)*/, /*aNiveis*/,/*aFilIni*/,/*aFilFim*/,/*lReserv*/, /*aCfgCube*/,/*lProcessa*/,.T./*lVerAcesso*/)

	If aSavPar[11] == 2 //Não considera saldos zerados
		PCORETSAL(aProcessa, aProcComp)
	EndIf

	If Len(aPeriodos) == 1 // um unico periodo layout diferenciado
		RptStatus( {|lEnd| Pcor530UniImp(lEnd, oPrint, aProcessa, aProcComp)})
	Else
		RptStatus( {|lEnd| PCOR530Imp(@lEnd,oPrint,aProcessa, aProcComp)})
	EndIf

	PcoPrtEnd(oPrint)

EndIf

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Pcor530Sld³ Autor ³ Edson Maricate        ³ Data ³18/02/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de processamento do demonstrativo saldo / periodo.   ³±±
±±³          ³Funcao IGUAL AO DO RELATORIO PCOR520                        ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Pcor530Sld                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd - Variavel para cancelamento da impressao pelo usuario³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Pcor530Sld(cConfig,cChave)
Local aRetorno := {}
Local aRetIni,aRetFim
Local nCrdIni
Local nDebIni
Local nCrdFim
Local nDebFim
Local ny

For ny := 1 to Len(aPeriodos)

	dIni := CtoD(Subs(aPeriodos[ny],1,10))
	dFim := CtoD(Subs(aPeriodos[ny],14))

	aRetIni := PcoRetSld(cConfig,cChave,dIni-1)
	nCrdIni := aRetIni[1, aSavPar[4]]
	nDebIni := aRetIni[2, aSavPar[4]]

	aRetFim := PcoRetSld(cConfig,cChave,dFim)
	nCrdFim := aRetFim[1, aSavPar[4]]
	nDebFim := aRetFim[2, aSavPar[4]]

	nSldIni := nCrdIni-nDebIni
	nMovCrd := nCrdFim-nCrdIni
	nMovDeb := nDebFim-nDebIni
	nMovPer := nMovCrd-nMovDeb

	aAdd(aRetorno,nMovCrd)
	aAdd(aRetorno,nMovDeb)

Next

Return aRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Pcor530Imp³ Autor ³ Paulo Carnelossi      ³ Data ³23/03/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao Demonst.Resumido de saldos Mov/periodo. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PCOR530Imp(lEnd)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd - Variavel para cancelamento da impressao pelo usuario³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Pcor530Imp(lEnd, oPrint, aProcessa, aProcComp)

Local nX, nY, nZ
Local cQuebra := ""
Local nTamLin := 40
Local nPosComp
Local nQtElem, nPeriod, nUltEle
Local nValorCf01, nValorCf02, nValorDifV, nValorDifP
Local nColor := RGB(230,230,230)
Local nLimite := nTamLin+(nTamLin*(Len(aPeriodos)/3+1))
Local aColunas := R530CabPer(aPeriodos)
Local aColDet := {10,310,610,910,1010,1310,1610,1910,2010,2310,2610,2910}
Local nNivProc := 0
Local aAuxTot  	:= {}
Local nNivTot	:= 0// Nivel a ser totalizado no Total Geral

//primeiro array se refere ao total geral
//os demais sao para cada nivel do cubo
For nX := 1 TO Len(aPeriodos)
	aAdd(aAuxTot, 0) //cred-deb cfg 01
	aAdd(aAuxTot, 0) //cred-deb cfg 02
Next

For nX := 1 To Len(aTotais)
	aAdd(aSubTot, aClone(aAuxTot))
Next

For nx := 1 To Len(aProcessa)

	nPosComp := ASCAN(aProcComp, { |x| x[1] == aProcessa[nx][1] })

	//cabecalho normal + cabecalho fixo
	If PcoPrtLim(nLin+(nLimite*2))     //sempre considerar o bloco para salto
		nLin := 200
		PcoPrtCab(oPrint)
		R530CabFix(aColDet)
	EndIf

	//cabecalho da quebra -- Nivel de Quebra + Descricao --> ex: CO-1000 Presidencia
	If cQuebra<>aProcessa[nx,1]
		R530DetFix(aProcessa, aProcComp, nX)
		cQuebra := aProcessa[nx,1]
		nLin += nTamLin
	EndIf

	//imprime o detalhe do relatorio (os periodos e os valores)
	//acolunas contem todos os periodos quebrados em linhas
	For nY := 1 TO Len(aColunas)

		//Qtde de Periodos (normalmente 3 )
		nQtElem := Len(aColunas[nY, 1])

		//imprime o cabecalho com os Periodos da linha (nY) de aColunas
		PcoPrtCol(aColunas[nY, 1])
		For nZ := 1 TO nQtElem
			If nY = Len(aColunas) .And. nZ == nQtElem .And. nZ != 3 //ULTIMA LINHA E ULTIMA COLUNA
				PcoPrtCell(PcoPrtPos(nZ), nLin, 		  1000, 30, aColunas[nY,2,nZ],oPrint,2,2,nColor-10,,.F.,,,.T.)
			Else
				PcoPrtCell(PcoPrtPos(nZ), nLin, PcoPrtTam(nZ), 30, aColunas[nY,2,nZ],oPrint,2,2,nColor-10,,.F.,,,.T.)
			EndIf
		Next
		nLin += nTamLin

		//imprime o detalhe dos Periodos
		nPeriod := (nY*3)-2 //relatorio contem 3 colunas fixas contendo periodos
		//e subtrai 2 para setar o primeiro periodo

		PcoPrtCol(aColDet)
		For nZ := 1 TO nQtElem
			nUltEle := nPeriod*2
			nValorCf01  := aProcessa[nX,2,nUltEle-1] - aProcessa[nX,2,nUltEle]
			nValorCf02  := 0
			If nPosComp > 0
				nValorCf02  := aProcComp[nPosComp,2,nUltEle-1] - aProcComp[nPosComp,2,nUltEle]
			EndIf

			//*****************************************
			// Verrifica se o registro do nivel atual *
			// não tem nivel superior.                *
			//*****************************************
			lTot := (Empty(aProcessa[nX,16]) .and. (nNivTot==0 .or. nNivTot==aProcessa[nX,8] ))
			//*****************************************
			// Verrifica se o registro do nivel atual *
			// tem conta superior no aProcesso.       *
			//*****************************************
			If !lTot .and. (nNivTot==0 .or. nNivTot==aProcessa[nX,8])
				lTot := (aScan(aProcessa , {|x| x[14]==aProcessa[nX,16] .and. (nNivTot==0 .or. nNivTot==x[8] )} )==0)
			EndIf
			If lTot
				nNivTot := aProcessa[nX, 8] // Grava o Primeiro nivel que pode ser totalizado
				aSubTot[1, nUltEle-1] += nValorCf01
				aSubTot[1, nUltEle] += nValorCf02
			EndIf
			nValorDifV  := nValorCf01 - nValorCf02
			If aSavPar[13]==1
				nValorDifP  := If(nValorCf01>0, nValorCf02 / nValorCf01 * 100, 0)
			Else
				nValorDifP  := If(nValorCf02>0, nValorCf01 / nValorCf02 * 100, 0)
			Endif
			//nZ*4-3+0    -- multiplica por 4 pq sao 4 colunas em cada periodo
			//            -- subtrai 3 para ir para o primeiro
			//            -- incrementa 0 para 1a.coluna  (Cred-Deb) Cfg 01
			//							1 para 2a.coluna  (Cred-Deb) Cfg 02
			//                          2 para 3a.coluna
			//                          3 para 4a.coluna
			PcoPrtCell(PcoPrtPos(nZ*4-3+0),nLin,PcoPrtTam(nZ*4-3+0),50,Transform(nValorCf01, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
			PcoPrtCell(PcoPrtPos(nZ*4-3+1),nLin,PcoPrtTam(nZ*4-3+1),50,Transform(nValorCf02, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
			PcoPrtCell(PcoPrtPos(nZ*4-3+2),nLin,PcoPrtTam(nZ*4-3+2),50,Transform(nValorDifV, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
			PcoPrtCell(PcoPrtPos(nZ*4-3+3),nLin,PcoPrtTam(nZ*4-3+3),50,Transform(nValorDifP, "@E 9,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
			nPeriod++
		Next
		nLin += nTamLin

	Next

	nLin += 10
	PcoPrtLine(PcoPrtPos(1),nLin) //somente para fechar a quebra
	nLin -= 08  //para voltar

	If lEnd
		PcoPrtCell(PcoPrtPos(1),nLin,PcoPrtTam(1),30,STR0006,oPrint,2,1,RGB(230,230,230)) //"Impressao cancelada pelo operador..."
	Endif

Next

//impressao do total geral
If aTotais[1]
	nLin += nTamLin
	R530ImpSubTot(0, aColDet, aColunas, STR0011)  // "*** Total Geral *** "
EndIf

Return

/*

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R530DetFix  ºAutor  ³Paulo Carnelossi   º Data ³ 23/03/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do titulo do detalhe da quebra        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R530DetFix(aProcessa, aProcComp, nX)
Local aColFix := { 10, 1150}
Local aTitFix := {STR0002, STR0003} //"Codigo"###"Descricao"

//nX  ---> Linha do aProcessa que esta sendo impressa
nLin += 20
PcoPrtCol(aColFix)
PcoPrtCell(PcoPrtPos(1), nLin, PcoPrtTam(1), 40, aTitFix[1],oPrint,2,1,RGB(230,230,230))
PcoPrtCell(PcoPrtPos(2), nLin, PcoPrtTam(2), 40, aTitFix[2],oPrint,2,1,RGB(230,230,230))
nLin += 30

//aProcessa[nX, 3] = quebra  Ex: CO
//aProcessa[nX, 2] = chave da quebra por Ex: 1000
//aProcessa[nX, 6] = Descricao da chave da quebra por Ex: Presidencia
PcoPrtCell(PcoPrtPos(1), nLin, PcoPrtTam(1), 60, Alltrim(aProcessa[nx,3])+"-"+aProcessa[nx,1],oPrint,1,2,/*RgbColor*/)
nLin+=30
PcoPrtCell(PcoPrtPos(2), nLin, PcoPrtTam(2), 60, aProcessa[nx,6],oPrint,1,2,/*RgbColor*/)
nLin+=40

PcoPrtLine(PcoPrtPos(1),nLin)
nLin-=35  //para voltar para nao ficar espaco vazio entre os periodos e a descricao

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R530CabFix  ºAutor  ³Paulo Carnelossi   º Data ³ 23/03/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do cabecalho fixo apos impressao  do  º±±
±±º          ³cabecalho normal                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R530CabFix(aColDet)
Local nColor := RGB(230,220,230)
Local aColPri := {10,310,610,1010,1310,1610,2010,2310,2610}

PcoPrtCol(aColPri)

//impressao do sub-titulo
PcoPrtCell(PcoPrtPos(4), nLin, PcoPrtTam(4),40,STR0007+cCfg01+"-(1) "+STR0008+cCfg02+"-(2)",oPrint,1,2,/*RgbColor*/)
nLin+=60

//impressao da 1a. linha do cabecalho fixo
PcoPrtCell(PcoPrtPos(1), nLin, PcoPrtTam(1), 40, cCfg01+"-(1)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(2), nLin, PcoPrtTam(2), 40, cCfg02+"-(2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
If aSavPar[13]==1
	PcoPrtCell(PcoPrtPos(3), nLin, PcoPrtTam(3), 40, STR0009+" (1-2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
Else
	PcoPrtCell(PcoPrtPos(3), nLin, PcoPrtTam(3), 40, STR0009+" (2-1)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
EndIf

PcoPrtCell(PcoPrtPos(4), nLin, PcoPrtTam(4), 40, cCfg01+"-(1)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(5), nLin, PcoPrtTam(5), 40, cCfg02+"-(2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
If aSavPar[13]==1
	PcoPrtCell(PcoPrtPos(6), nLin, PcoPrtTam(6), 40, STR0009+" (1-2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
Else
	PcoPrtCell(PcoPrtPos(6), nLin, PcoPrtTam(6), 40, STR0009+" (2-1)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
EndIf


PcoPrtCell(PcoPrtPos(7), nLin, PcoPrtTam(7), 40, cCfg01+"-(1)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(8), nLin, PcoPrtTam(8), 40, cCfg02+"-(2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(9), nLin, PcoPrtTam(9), 40, STR0009+" (1-2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
If aSavPar[13]==1
	PcoPrtCell(PcoPrtPos(9), nLin, PcoPrtTam(9), 40, STR0009+" (1-2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
Else
	PcoPrtCell(PcoPrtPos(9), nLin, PcoPrtTam(9), 40, STR0009+" (2-1)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
EndIf
nLin += 40

//impressao da 2a. linha do cabecalho fixo
PcoPrtCol(aColDet)  //seta colunas igual a impressao do detalhe

PcoPrtCell(PcoPrtPos(1), nLin, PcoPrtTam(1), 40, STR0010,oPrint,2,1,nColor,,,,, .T./*lCentral*/)//"(Cred-Deb) "
PcoPrtCell(PcoPrtPos(2), nLin, PcoPrtTam(2), 40, STR0010,oPrint,2,1,nColor,,,,, .T./*lCentral*/)//"(Cred-Deb) "
PcoPrtCell(PcoPrtPos(3), nLin, PcoPrtTam(3), 40, " $ ",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(4), nLin, PcoPrtTam(4), 40, " % ",oPrint,2,1,nColor,,,,, .T./*lCentral*/)

PcoPrtCell(PcoPrtPos(5), nLin, PcoPrtTam(5), 40, STR0010,oPrint,2,1,nColor,,,,, .T./*lCentral*/)//"(Cred-Deb) "
PcoPrtCell(PcoPrtPos(6), nLin, PcoPrtTam(6), 40, STR0010,oPrint,2,1,nColor,,,,, .T./*lCentral*/)//"(Cred-Deb) "
PcoPrtCell(PcoPrtPos(7), nLin, PcoPrtTam(7), 40, " $ ",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(8), nLin, PcoPrtTam(8), 40, " % ",oPrint,2,1,nColor,,,,, .T./*lCentral*/)

PcoPrtCell(PcoPrtPos(09), nLin, PcoPrtTam(09), 40, STR0010,oPrint,2,1,nColor,,,,, .T./*lCentral*/)//"(Cred-Deb) "
PcoPrtCell(PcoPrtPos(10), nLin, PcoPrtTam(10), 40, STR0010,oPrint,2,1,nColor,,,,, .T./*lCentral*/)//"(Cred-Deb) "
PcoPrtCell(PcoPrtPos(11), nLin, PcoPrtTam(11), 40, " $ ",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(12), nLin, PcoPrtTam(12), 40, " % ",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
nLin += 20

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R530CabPer  ºAutor  ³Paulo Carnelossi   º Data ³ 23/03/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para retornar array aColunas com a seguinte estruturaº±±
±±º          ³                                                            º±±
±±º          ³Len(aColunas) = numero de linhas para impressao do periodo  º±±
±±º          ³                sendo que cada linha comporta ate 3 periodosº±±
±±º          ³                                                            º±±
±±º          ³ 2 (duas) - dimensoes                                       º±±
±±º          ³   1-array com as posicoes a ser impresso o periodo         º±±
±±º          ³   2-array String contendo os periodos a ser impresso       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R530CabPer(aPeriodos)
Local aColAux := {}, aAuxTit := {}
Local aColunas := {}
Local nCol := 10
Local nY

For nY := 1 TO Len(aPeriodos)

	If Empty(aColAux) .Or. aColAux[Len(aColAux)] < (2800-(3*CELLTAMDATA)+100)
		aAdd(aColAux, nCol)
		aAdd(aAuxTit, aPeriodos[nY])
		nCol += (3*CELLTAMDATA)+100
	Else
		aAdd(aColunas, {aClone(aColAux), aClone(aAuxTit)})
		aColAux := {}
		aAuxTit := {}
		nCol := 10
		aAdd(aColAux, nCol)
		aAdd(aAuxTit, aPeriodos[nY])
		nCol += (3*CELLTAMDATA)+100
	EndIf

Next

//adiciona os ultimos elementos no array acolunas
If ! Empty(aColAux)
	aAdd(aColunas, {aClone(aColAux), aClone(aAuxTit)})
EndIf

Return(aColunas)


//------TRATAMENTO ESPECIFICO PARA QUANDO LEN(APERIODO) == 1 UNICO PERIODO--------//
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Pcor530UniImp³Autor ³ Paulo Carnelossi    ³ Data ³07/04/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao Demonst.Resumido de saldos Mov/periodo. ³±±
±±³          ³quando impressao de um unico periodo                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PCOR530Imp(lEnd)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd - Variavel para cancelamento da impressao pelo usuario³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Pcor530UniImp(lEnd, oPrint, aProcessa, aProcComp)

Local nX, nY, nZ
Local cQuebra := ""
Local nTamLin := 30
Local nPosComp
Local nQtElem, nPeriod, nUltEle
Local nValorCf01, nValorCf02, nValorDifV, nValorDifP
Local nColor := RGB(230,230,230)
Local nLimite := nTamLin+(nTamLin*(Len(aPeriodos)+1))
Local aColunas := { { {2010}, {aPeriodos[1]} } }
Local aColDet := {10,310,610,910,1010,1310,1610,1910,2010,2310,2610,2910}
Local aAuxTot  := {}
Local nNivTot	:= 0// Nivel a ser totalizado no Total Geral

//primeiro array se refere ao total geral
//os demais sao para cada nivel do cubo
For nX := 1 TO Len(aPeriodos)
	aAdd(aAuxTot, 0) //cred-deb cfg 01
	aAdd(aAuxTot, 0) //cred-deb cfg 02
Next

For nX := 1 To Len(aTotais)
	aAdd(aSubTot, aClone(aAuxTot))
Next

For nx := 1 To Len(aProcessa)

	nPosComp := ASCAN(aProcComp, { |x| x[1] == aProcessa[nx][1] })

	//cabecalho normal + cabecalho fixo
	If PcoPrtLim(nLin+nLimite)     //sempre considerar o bloco para salto
		nLin := 200
		PcoPrtCab(oPrint)
		R530CabUniFix(aColDet)
		R530UniCabFix(aProcessa, aProcComp, nX)
	EndIf

	//cabecalho da quebra -- Nivel de Quebra + Descricao --> ex: CO-1000 Presidencia
	If cQuebra<>aProcessa[nx,1]
		R530UniDetFix(aProcessa, aProcComp, nX)
		cQuebra := aProcessa[nx,1]
	EndIf

	//imprime o detalhe do relatorio (os periodos e os valores)
	//acolunas contem todos os periodos quebrados em linhas
	For nY := 1 TO Len(aColunas)

		//Qtde de Periodos (normalmente 3 )
		nQtElem := 3    //vou considerar como sendo o 3o. periodo para impressao

		//imprime o detalhe dos Periodos
		nPeriod := 1   //periodo sempre sera 1 (periodo unico)

		PcoPrtCol(aColDet)
		For nZ := 3 TO nQtElem
			nUltEle := nPeriod*2
			nValorCf01  := aProcessa[nX,2,nUltEle-1] - aProcessa[nX,2,nUltEle]
			nValorCf02  := 0
			If nPosComp > 0
				nValorCf02  := aProcComp[nPosComp,2,nUltEle-1] - aProcComp[nPosComp,2,nUltEle]
			EndIf
			nValorDifV  := nValorCf01 - nValorCf02
			If aSavPar[13]==1
				nValorDifP  := If(nValorCf01>0, nValorCf02 / nValorCf01 * 100, 0)
			Else
				nValorDifP  := If(nValorCf02>0, nValorCf01 / nValorCf02 * 100, 0)
			EndIf

			//*****************************************
			// Verrifica se o registro do nivel atual *
			// não tem nivel superior.                *
			//*****************************************
			lTot := (Empty(aProcessa[nX,16]) .and. (nNivTot==0 .or. nNivTot==aProcessa[nX,8] ))
			//*****************************************
			// Verrifica se o registro do nivel atual *
			// tem conta superior no aProcesso.       *
			//*****************************************
			If !lTot .and. (nNivTot==0 .or. nNivTot==aProcessa[nX,8])
				lTot := (aScan(aProcessa , {|x| x[14]==aProcessa[nX,16] .and. (nNivTot==0 .or. nNivTot==x[8] )} )==0)
			EndIf
			If lTot
				nNivTot := aProcessa[nX, 8] // Grava o Primeiro nivel que pode ser totalizado
				aSubTot[1, nUltEle-1] += nValorCf01
				aSubTot[1, nUltEle] += nValorCf02
			EndIf
			//
			//nZ*4-3+0    -- multiplica por 4 pq sao 4 colunas em cada periodo
			//            -- subtrai 3 para ir para o primeiro
			//            -- incrementa 0 para 1a.coluna  (Cred-Deb) Cfg 01
			//							1 para 2a.coluna  (Cred-Deb) Cfg 02
			//                          2 para 3a.coluna
			//                          3 para 4a.coluna
			PcoPrtCell(PcoPrtPos(nZ*4-3+0),nLin,PcoPrtTam(nZ*4-3+0),50,Transform(nValorCf01, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
			PcoPrtCell(PcoPrtPos(nZ*4-3+1),nLin,PcoPrtTam(nZ*4-3+1),50,Transform(nValorCf02, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
			PcoPrtCell(PcoPrtPos(nZ*4-3+2),nLin,PcoPrtTam(nZ*4-3+2),50,Transform(nValorDifV, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
			PcoPrtCell(PcoPrtPos(nZ*4-3+3),nLin,PcoPrtTam(nZ*4-3+3),50,Transform(nValorDifP, "@E 9,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
			nPeriod++
		Next
		nLin += nTamLin

	Next

	If lEnd
		PcoPrtCell(PcoPrtPos(1),nLin,PcoPrtTam(1),30,STR0006,oPrint,2,1,RGB(230,230,230)) //"Impressao cancelada pelo operador..."
	Endif

Next

//impressao do total geral
If aTotais[1]
	nLin += nTamLin
	R530UniImpSub(0, aColDet, aColunas, STR0011)//"*** Total Geral *** "
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R530UniDetFix ºAutor  ³Paulo Carnelossi º Data ³ 07/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do detalhe da quebra                  º±±
±±º          ³quando for um unico periodo                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R530UniDetFix(aProcessa, aProcComp, nX)
Local aColFix := { 10, 750}

PcoPrtCol(aColFix)
nLin+=30

//aProcessa[nX, 3] = quebra  Ex: CO
//aProcessa[nX, 2] = chave da quebra por Ex: 1000
//aProcessa[nX, 6] = Descricao da chave da quebra por Ex: Presidencia
PcoPrtCell(PcoPrtPos(1), nLin, PcoPrtTam(1), 60, Alltrim(aProcessa[nx,3])+"-"+aProcessa[nx,1],oPrint,1,2,/*RgbColor*/)
nLin+=30
PcoPrtCell(PcoPrtPos(2), nLin, PcoPrtTam(2), 60, aProcessa[nx,6],oPrint,1,2,/*RgbColor*/)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R530UniCabFix ºAutor  ³Paulo Carnelossi º Data ³ 07/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do titulo do detalhe da quebra        º±±
±±º          ³quando for um unico periodo                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R530UniCabFix(aProcessa, aProcComp, nX)

Local aColFix := { 10, 750}
Local aTitFix := {STR0002, STR0003} //"Codigo"###"Descricao"

//nX  ---> Linha do aProcessa que esta sendo impressa
nLin += 20
PcoPrtCol(aColFix)
PcoPrtCell(PcoPrtPos(1), nLin, PcoPrtTam(1), 40, aTitFix[1],oPrint,2,1,RGB(230,230,230))
PcoPrtCell(PcoPrtPos(2), nLin, PcoPrtTam(2), 40, aTitFix[2],oPrint,2,1,RGB(230,230,230))

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R530CabUniFix  ºAutor  ³Paulo Carnelossi º Data ³ 07/04/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do cabecalho fixo apos impressao  do  º±±
±±º          ³cabecalho normal quando for um unico periodo                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R530CabUniFix(aColDet)
Local nColor := RGB(230,220,230)
Local aColPri := {10,310,610,1010,1310,1610,2010,2310,2610}

PcoPrtCol(aColPri)

//impressao do sub-titulo
PcoPrtCell(PcoPrtPos(2), nLin+25, PcoPrtTam(2),40,STR0007+cCfg01+"-(1) "+STR0008+cCfg02+"-(2)   - Periodo : " + aPeriodos[1],oPrint,1,2,/*RgbColor*/)
//impressao da 1a. linha do cabecalho fixo
PcoPrtCell(PcoPrtPos(7), nLin, PcoPrtTam(7), 40, cCfg01+"-(1)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(8), nLin, PcoPrtTam(8), 40, cCfg02+"-(2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
if aSavPar[13]==1
	PcoPrtCell(PcoPrtPos(9), nLin, PcoPrtTam(9), 40, STR0009+" (1-2)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
Else
	PcoPrtCell(PcoPrtPos(9), nLin, PcoPrtTam(9), 40, STR0009+" (2-1)",oPrint,2,1,nColor,,,,, .T./*lCentral*/)  //Variacao
EndIf
nLin += 40

//impressao da 2a. linha do cabecalho fixo
PcoPrtCol(aColDet)  //seta colunas igual a impressao do detalhe

PcoPrtCell(PcoPrtPos(09), nLin, PcoPrtTam(09), 40, STR0010,oPrint,2,1,nColor,,,,, .T./*lCentral*/)//"(Cred-Deb) "
PcoPrtCell(PcoPrtPos(10), nLin, PcoPrtTam(10), 40, STR0010,oPrint,2,1,nColor,,,,, .T./*lCentral*/)//"(Cred-Deb) "
PcoPrtCell(PcoPrtPos(11), nLin, PcoPrtTam(11), 40, " $ ",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
PcoPrtCell(PcoPrtPos(12), nLin, PcoPrtTam(12), 40, " % ",oPrint,2,1,nColor,,,,, .T./*lCentral*/)
nLin += 20

Return

Static Function R530ImpSubTot(nNivProc, aColDet, aColunas, cTitulo)
Local nColor := RGB(230,230,230)
Local nY, nZ
Local nQtElem
Local nPeriod
Local nUltEle
Local nTamLin := 40

//imprime o detalhe do relatorio (os periodos e os valores)
//acolunas contem todos os periodos quebrados em linhas
For nY := 1 TO Len(aColunas)

	//Qtde de Periodos (normalmente 3 )
	nQtElem := Len(aColunas[nY, 1])

	//imprime o cabecalho com os Periodos da linha (nY) de aColunas
	PcoPrtCol(aColunas[nY, 1])
	For nZ := 1 TO nQtElem
		If nY = Len(aColunas) .And. nZ == nQtElem .And. nZ != 3 //ULTIMA LINHA E ULTIMA COLUNA
			PcoPrtCell(PcoPrtPos(nZ), nLin, 		  1000, 30, cTitulo+aColunas[nY,2,nZ],oPrint,2,2,nColor-10,,.F.,,,.F.)
		Else
			PcoPrtCell(PcoPrtPos(nZ), nLin, PcoPrtTam(nZ), 30, cTitulo+aColunas[nY,2,nZ],oPrint,2,2,nColor-10,,.F.,,,.F.)
		EndIf
	Next
	nLin += nTamLin

	//imprime o detalhe dos Periodos
	nPeriod := (nY*3)-2 //relatorio contem 3 colunas fixas contendo periodos
	//e subtrai 2 para setar o primeiro periodo

	PcoPrtCol(aColDet)
	For nZ := 1 TO nQtElem
		nUltEle := nPeriod*2
		nValorCf01  := aSubTot[nNivProc+1, nUltEle-1]
		nValorCf02  := aSubTot[nNivProc+1, nUltEle]

		nValorDifV  := nValorCf01 - nValorCf02
		If aSavPar[13]==1
			nValorDifP  := If(nValorCf01>0, nValorCf02 / nValorCf01 * 100, 0)
		Else
			nValorDifP  := If(nValorCf02>0, nValorCf01 / nValorCf02 * 100, 0)
		EndIf
		//nZ*4-3+0    -- multiplica por 4 pq sao 4 colunas em cada periodo
		//            -- subtrai 3 para ir para o primeiro
		//            -- incrementa 0 para 1a.coluna  (Cred-Deb) Cfg 01
		//							1 para 2a.coluna  (Cred-Deb) Cfg 02
		//                          2 para 3a.coluna
		//                          3 para 4a.coluna
		PcoPrtCell(PcoPrtPos(nZ*4-3+0),nLin,PcoPrtTam(nZ*4-3+0),50,Transform(nValorCf01, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
		PcoPrtCell(PcoPrtPos(nZ*4-3+1),nLin,PcoPrtTam(nZ*4-3+1),50,Transform(nValorCf02, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
		PcoPrtCell(PcoPrtPos(nZ*4-3+2),nLin,PcoPrtTam(nZ*4-3+2),50,Transform(nValorDifV, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
		PcoPrtCell(PcoPrtPos(nZ*4-3+3),nLin,PcoPrtTam(nZ*4-3+3),50,Transform(nValorDifP, "@E 9,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
		nPeriod++
	Next
	nLin += nTamLin

Next

nLin += 10
PcoPrtLine(PcoPrtPos(1),nLin) //somente para fechar a quebra
nLin -= 08  //para voltar

Return

Static Function R530UniImpSub(nNivProc, aColDet, aColunas, cTitulo)
Local nY, nZ
Local nQtElem
Local nPeriod
Local nUltEle
Local nTamLin := 40

//imprime o detalhe do relatorio (os periodos e os valores)
//acolunas contem todos os periodos quebrados em linhas
For nY := 1 TO Len(aColunas)

	//Qtde de Periodos (normalmente 3 )
	nQtElem := 3

	//imprime o detalhe dos Periodos
	nPeriod := 1   //periodo sempre sera 1 (periodo unico)

	PcoPrtCol(aColDet)
	PcoPrtCell(PcoPrtPos(1), nLin, PcoPrtTam(1), 50,cTitulo,oPrint,1,2,/*RgbColor*/,"",.T.)

	For nZ := 3 TO nQtElem
		nUltEle := nPeriod*2
		nValorCf01  := aSubTot[nNivProc+1, nUltEle-1]
		nValorCf02  := aSubTot[nNivProc+1, nUltEle]

		nValorDifV  := nValorCf01 - nValorCf02

		If aSavPar[13]==1
			nValorDifP  := If(nValorCf01>0, nValorCf02 / nValorCf01 * 100, 0)
		Else
			nValorDifP  := If(nValorCf02>0, nValorCf01 / nValorCf02 * 100, 0)
		EndIf
		//nZ*4-3+0    -- multiplica por 4 pq sao 4 colunas em cada periodo
		//            -- subtrai 3 para ir para o primeiro
		//            -- incrementa 0 para 1a.coluna  (Cred-Deb) Cfg 01
		//							1 para 2a.coluna  (Cred-Deb) Cfg 02
		//                          2 para 3a.coluna
		//                          3 para 4a.coluna
		PcoPrtCell(PcoPrtPos(nZ*4-3+0),nLin,PcoPrtTam(nZ*4-3+0),50,Transform(nValorCf01, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
		PcoPrtCell(PcoPrtPos(nZ*4-3+1),nLin,PcoPrtTam(nZ*4-3+1),50,Transform(nValorCf02, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
		PcoPrtCell(PcoPrtPos(nZ*4-3+2),nLin,PcoPrtTam(nZ*4-3+2),50,Transform(nValorDifV, "@E 999,999,999,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
		PcoPrtCell(PcoPrtPos(nZ*4-3+3),nLin,PcoPrtTam(nZ*4-3+3),50,Transform(nValorDifP, "@E 9,999.99"),oPrint,1,2,/*RgbColor*/,"",.T.)
		nPeriod++
	Next
	nLin += nTamLin

Next

nLin += 10
PcoPrtLine(PcoPrtPos(1),nLin) //somente para fechar a quebra
nLin -= 08  //para voltar

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PCORETSAL ºAutor  ³ Pedro Pereira Lima º Data ³  03/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PcoRetSal(aProcessa,aProcComp)
Local nX 		:= 0
Local nY 	  	:= 0
Local lTemValor:= .F.
Local aDelPos  := {}
Local aAux		:= {}

For nX := 1 To Len(aProcComp)
   lTemValor := .F.
	For nY := 1 To Len(aProcComp[nX][2])
		If aProcComp[nX][2][nY] > 0
			lTemValor := .T.
			Exit
		EndIf
	Next nY
	If !lTemValor
		aAdd(aDelPos,nX)
	EndIf
Next nX

For nX := Len(aDelPos) To 1 Step -1
	aDel(aProcComp,aDelPos[nX])
Next nX

aSize(aProcComp,Len(aProcComp) - Len(aDelPos))

aDelPos := {}

For nX := 1 To Len(aProcComp)
	If aScan(aProcessa, { |x| x[1] == aProcComp[nX][1]}) > 0
		aAdd(aDelPos,aScan(aProcessa, { |x| x[1] == aProcComp[nX][1]}))
	EndIf
Next nX

ASort(aDelPos, , , {|x,y|x > y})

For nY := 1 To Len(aDelPos)
	aAdd(aAux,aProcessa[aDelPos[nY]])
Next nX

aProcessa := aClone(aAux)

Return Nil
