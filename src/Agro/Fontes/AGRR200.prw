/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AGRR200  º Autor ³ Ricardo Tomasi     º Data ³  24/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio para impressão da uma ou varias aplicações.      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Cliente Microsiga                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR200(cAlias, nReg)
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Custo por Aplicação"
	Local titulo         := "Custo por Aplicação"
	Local nLin           := 80
	Local Cabec1         := ""
	Local Cabec2         := ""
	Local aOrd           := {}

	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private limite       := 80
	Private tamanho      := "P"
	Private nomeprog     := "AGRR200" // Coloque aqui o nome do programa para impressao no cabecalho
	Private nTipo        := 18
	Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
	Private nLastKey     := 0
	Private cbtxt        := Space(10)
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private cPerg        := "AGR200"
	Private wnrel        := "AGRR200" // Coloque aqui o nome do arquivo usado para impressao em disco
	Private cString      := "NP1"
	Private nRegistro    := nReg

	dbSelectArea("NP1")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	If nRegistro != Nil
		cPerg := ""
	EndIf

	wnRel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin, nRegistro) },Titulo)
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
	Local cFazenda  := ""
	Local cDataApl  := ""
	Local cSafra    := ""
	Local cProduto  := ""
	Local cTalhao   := ""
	Local cArea     := ""
	Local cServico  := ""
	Local nCusto    := 0
	Local nTotalCC  := 0
	Local cTotalCC  := ""
	Local cIndex
	Local cChave
	Local nIndex

	Private cCodDe  := ""
	Private cCodAte := ""
	Private dDatDe  := ""
	Private dDatAte := ""
	Private cFiltro := ""

	If nReg != Nil
		dbGoto(nReg)
		cCodDe    := NP1->NP1_CODIGO
		cCodAte   := NP1->NP1_CODIGO
		dDatDe    := NP1->NP1_DATA
		dDatAte   := NP1->NP1_DATA
	Else
		cCodDe    := IIf(Empty(MV_PAR01),'      ',MV_PAR01)
		cCodAte   := IIf(Empty(MV_PAR02),'ZZZZZZ',MV_PAR02)
		dDatDe    := IIf(Empty(MV_PAR03),CToD('01/01/80'),MV_PAR03)
		dDatAte   := IIf(Empty(MV_PAR04),CToD('31/12/20'),MV_PAR04)
	EndIf

	cFiltro += "NP1_FILIAL == '" + xFilial('NP1') + "' .And. "
	cFiltro += "NP1_CODIGO >= '" + cCodDe  + "' .And. "
	cFiltro += "NP1_CODIGO <= '" + cCodAte + "' .And. "
	cFiltro += "DToS(NP1_DATA) >= '" + DToS(dDatDe)  + "' .And. "
	cFiltro += "DToS(NP1_DATA) <= '" + DToS(dDatAte) + "'"
	cFiltro += IIf(Empty(aReturn[7]),""," .And. "+aReturn[7])

	dbSelectArea("NP1")
	dbSetOrder(1)

	cIndex	:= CriaTrab(nil,.f.)
	cChave	:= IndexKey()
	IndRegua("NP1",cIndex,cChave,,cFiltro,"Selecionando Registros...")
	nIndex := RetIndex("NP1")
	DbSelectArea("NP1")
	#IFNDEF TOP
	DbSetIndex(cIndex+OrdBagExt())
	#ENDIF
	DbSetOrder(nIndex+1)
	dbGoTop()

	While .Not. Eof()
		titulo := AllTrim(titulo)+IIf(MV_PAR06==1, '(Previsto)', '(Realizado)')
		Cabec1 := "Numero da Aplicação: " + AllTrim(NP1->NP1_CODIGO)
		nTotalCC := 0

		If lAbortPrint
			@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		If nLin > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif

		nQtdPrev := 0
		nUMPrev	 := ''

		cFazenda := PadC("Fazenda: " + AllTrim(Posicione("NN2",2,xFilial("NN2")+NP1->NP1_FAZ,"NN2_NOME")),49) //49
		cDataApl := PadR("Data: " + DToC(NP1->NP1_DATA),24) //24
		dbSelectArea("NN1")
		dbSetOrder(1)
		dbSeek(xFilial("NN1")+NP1->NP1_SAFRA,.T.)
		cSafra   := PadR("Safra: " + NN1->NN1_ANO + "/" + NN1->NN1_SEQ + " - " + NN1->NN1_DESCRI,33)
		cProduto := PadR("Produto: " + AllTrim(NN1->NN1_CODPRO) + " " + NN1->NN1_DESPRO,40)
		cTalhao  := PadR("Talhão: " + NP1->NP1_TALHAO + " " + Posicione("NN3",1,xFilial("NN3")+NP1->NP1_SAFRA+NP1->NP1_FAZ+NP1->NP1_TALHAO,"NN3_DESCRI"),24) //24
		cArea    := PadR("Area do Talhão: " + Transform(NP1->NP1_AREA, X3Picture("NP1_AREA")) + " Hectares",49) //49
		cServico := PadR("Serviço a ser executado: " + AllTrim(NP1->NP1_CODSRV) + " " + NP1->NP1_DESSRV ,76) //76

		@ nLin, 00 PSay "+---------------------------------------------------+--------------------------+"; nLin++
		@ nLin, 00 PSay "| "  +               cFazenda                   + " | " +    cDataApl      + " |"; nLin++
		@ nLin, 00 PSay "+-----------------------------------+---------------+--------------------------+";	nLin++
		@ nLin, 00 PSay "| "             + cSafra +        " | " +              cProduto            + " |";	nLin++
		@ nLin, 00 PSay "+--------------------------+--------+------------------------------------------+";	nLin++
		@ nLin, 00 PSay "| " +      cTalhao     + " | " +                cArea                      + " |";	nLin++
		@ nLin, 00 PSay "+--------------------------+---------------------------------------------------+";	nLin++
		@ nLin, 00 PSay "| " +                            cServico                                  + " |";	nLin++
		@ nLin, 00 PSay "+------------------------------------------------------------------------------+"; nLin++

		dbSelectArea('NP2')
		dbSetOrder(2)
		If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'MO')
			nLin += 1
			@ nLin, 00 PSay "---------------------------------- MAO-DE-OBRA ---------------------------------";nLin += 1
			@ nLin, 00 PSay "Codigo - Descricao               Qtd Prevista      Qtd Aplicada            Custo";nLin += 1
			@ nLin, 00 PSay "--------------------------------------------------------------------------------";nLin += 1
			While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "MO"
				@ nLin, 00 PSay Subst(AllTrim(NP2->NP2_MOCOD) + " - " + AllTrim(NP2->NP2_MONOM),1,27)
				@ nLin, 30 PSay NP2->NP2_QTDTOT Picture "@E 9,999,999.99"
				@ nLin, 43 PSay Subst(NP2->NP2_UM,1,2)
				@ nLin, 46 PSay NP2->NP2_QTDRET Picture "@E 9,999,999.99"
				@ nLin, 61 PSay Subst(NP2->NP2_UM,1,2)
				@ nLin, 64 PSay Subst(MV_SIMB1,1,2)
				nCusto := fRetCust(NP2->NP2_CODIGO,NP2->NP2_TIPO,NP2->NP2_MOCOD,IIf(MV_PAR06==1,NP2->NP2_QTDTOT,NP2->NP2_QTDRET))
				@ nLin, 66 PSay nCusto Picture "@E 999,999,999.99"
				nTotalCC += nCusto
				nLin := nLin + 1 // Avanca a linha de impressao
				dbSkip()
			EndDo
		EndIf


		dbSelectArea('NP2')
		dbSetOrder(3)
		If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'EQ')
			nLin += 1
			@ nLin, 00 PSay "--------------------------------- EQUIPAMENTOS ---------------------------------";nLin += 1
			@ nLin, 00 PSay "Codigo - Descricao               Qtd Prevista      Qtd Aplicada            Custo";nLin += 1
			@ nLin, 00 PSay "--------------------------------------------------------------------------------";nLin += 1
			While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "EQ"
				@ nLin, 00 PSay Subst(AllTrim(NP2->NP2_EQCOD) + " - " + AllTrim(NP2->NP2_EQNOM),1,27)
				@ nLin, 30 PSay NP2->NP2_QTDTOT Picture "@E 9,999,999.99"
				@ nLin, 43 PSay Subst(NP2->NP2_UM,1,2)
				@ nLin, 46 PSay NP2->NP2_QTDRET Picture "@E 9,999,999.99"
				@ nLin, 61 PSay Subst(NP2->NP2_UM,1,2)
				@ nLin, 64 PSay Subst(MV_SIMB1,1,2)
				nCusto := fRetCust(NP2->NP2_CODIGO,NP2->NP2_TIPO,NP2->NP2_EQCOD,IIf(MV_PAR06==1,NP2->NP2_QTDTOT,NP2->NP2_QTDRET))
				@ nLin, 66 PSay nCusto Picture "@E 999,999,999.99"
				nTotalCC += nCusto
				nLin := nLin + 1 // Avanca a linha de impressao
				dbSkip()
			EndDo
		EndIf

		dbSelectArea('NP2')
		dbSetOrder(4)
		If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'PD')

			If MV_PAR06 == 1
				nLin += 1
				@ nLin, 00 PSay "---------------------------------- PRODUTOS ------------------------------------";nLin += 1
				@ nLin, 00 PSay "Codigo - Descricao               Qtd Prevista      Qtd Aplicada            Custo";nLin += 1
				@ nLin, 00 PSay "--------------------------------------------------------------------------------";nLin += 1
				While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "PD"
					@ nLin, 00 PSay Subst(AllTrim(NP2->NP2_PDCOD) + " - " + AllTrim(NP2->NP2_PDNOM),1,27)
					@ nLin, 30 PSay NP2->NP2_QTDTOT Picture "@E 9,999,999.99"
					@ nLin, 43 PSay Subst(NP2->NP2_UM,1,2)
					@ nLin, 46 PSay NP2->NP2_QTDRET Picture "@E 9,999,999.99"
					@ nLin, 61 PSay Subst(NP2->NP2_UM,1,2)
					@ nLin, 64 PSay Subst(MV_SIMB1,1,2)
					//nCusto := fRetCust(NP2->NP2_CODIGO,NP2->NP2_TIPO,NP2->NP2_PDCOD,IIf(MV_PAR06==1,NP2->NP2_QTDTOT,NP2->NP2_QTDRET), NP2->NP2_LOCAL)
					nCusto := fRetCust(NP2->NP2_CODIGO,NP2->NP2_TIPO,NP2->NP2_PDCOD,NP2->NP2_QTDTOT, NP2->NP2_LOCAL)
					@ nLin, 66 PSay nCusto Picture "@E 999,999,999.99"
					nTotalCC += nCusto
					nLin := nLin + 1 // Avanca a linha de impressao
					dbSkip()
				EndDo
			ElseIf MV_PAR06 == 2
				dbSelectArea('NP5')
				dbSetOrder(3)
				If dbSeek(xFilial('NP5')+NP1->NP1_CODIGO)
					nLin += 1
					@ nLin, 00 PSay "---------------------------------- PRODUTOS ------------------------------------";nLin += 1
					@ nLin, 00 PSay "Codigo - Descricao               Qtd Prevista      Qtd Aplicada            Custo";nLin += 1
					@ nLin, 00 PSay "--------------------------------------------------------------------------------";nLin += 1

					dbSelectArea('NP6')
					dbSetOrder(4)
					If dbSeek(xFilial('NP6')+NP5->NP5_CODIGO+'PD')
						While NP6->NP6_CODIGO == NP5->NP5_CODIGO .And. NP6->NP6_TIPO == "PD" 
							@ nLin, 00 PSay Subst(AllTrim(NP6->NP6_PDCOD) + " - " + AllTrim(NP6->NP6_PDNOM),1,25)	//codigo+descricao
							@ nLin, 27 PSay NP6->NP6_LOCAL 															//local
							@ nLin, 46 PSay NP6->NP6_QTDTOT Picture "@E 9,999,999.99"								//qtd aplicada
							@ nLin, 61 PSay Subst(NP6->NP6_UM,1,2)													//unidade medida
							@ nLin, 64 PSay Subst(MV_SIMB1,1,2)														//simbolo moeda
							nCusto := fRetCust(NP6->NP6_CODIGO,NP6->NP6_TIPO,NP6->NP6_PDCOD,NP6->NP6_QTDTOT, NP6->NP6_LOCAL)
							@ nLin, 66 PSay nCusto Picture "@E 999,999,999.99"										//custo
							nTotalCC += nCusto

							dbSelectArea('NP2')
							dbSetOrder(4)
							If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'PD'+NP6->NP6_PDCOD)
								nQtdPrev := NP2->NP2_QTDTOT
								nUMPrev	 := Subst(NP2->NP2_UM,1,2)
							EndIf
							@ nLin, 30 PSay nQtdPrev Picture "@E 9,999,999.99"										//qtd prevista
							@ nLin, 43 PSay nUMPrev																	//unidade medida

							nLin := nLin + 1 // Avanca a linha de impressao

							NP6->(dbSkip())
						EndDo
					EndIf
				EndIf
			EndIf
		EndIf
		cTotalCC := PadL("Custo Total: " + Subst(MV_SIMB1,1,2) + " " + Transform(nTotalCC,"@E 999,999,999.99"),36)

		nLin += 2
		@ nLin, 00 PSay "+--------------------------------- FECHAMENTO ---------------------------------+"; nLin++
		@ nLin, 00 PSay "|                                       | " +                     cTotalCC + " |"; nLin++
		@ nLin, 00 PSay "+---------------------------------------+--------------------------------------+"

		nLin += 1
		Roda()

		If nReg = Nil; nLin := 80; EndIf

		dbSelectArea("NP1")
		dbSkip()
	EndDo
	dbClearFilter()
	Set Device To Screen

	If aReturn[5]==1
		dbCommitAll()
		Set Printer To
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return

Static Function fRetCust(cAplPre,cTipo,cCodigo,cQtda,cLocal)
	Local aArea    := GetArea()
	Local nRetorno := 0

	Do Case
		Case cTipo == "MO"
		If MV_PAR05 == 1
			dbSelectArea("NNA")
			dbSetOrder(1)
			If dbSeek(xFilial("NNA")+cCodigo)
				nRetorno := (cQtda * NNA->NNA_CUSREA)
			EndIf
		Else
			dbSelectArea("NNA")
			dbSetOrder(1)
			If dbSeek(xFilial("NNA")+cCodigo)
				nRetorno := (cQtda * NNA->NNA_CUSEST)
			EndIf
		EndIf
		Case cTipo == "EQ"
		If MV_PAR05 == 1
			dbSelectArea("NNB")
			dbSetOrder(1)
			If dbSeek(xFilial("NNB")+cCodigo)
				nRetorno := (cQtda * NNB->NNB_CUSREA)
			EndIf
		Else
			dbSelectArea("NNB")
			dbSetOrder(1)
			If dbSeek(xFilial("NNB")+cCodigo)
				nRetorno := (cQtda * NNB->NNB_CUSEST)
			EndIf
		EndIf
		Case cTipo == "PD"
		If MV_PAR05 == 1
			dbSelectArea("SB2")
			dbSetOrder(1)
			If dbSeek(xFilial("SB2")+cCodigo+cLocal)
				nRetorno := (cQtda * SB2->B2_CM1)
			EndIf
		Else
			dbSelectArea("SB1")
			dbSetOrder(1)
			If dbSeek(xFilial("SB1")+cCodigo)
				nRetorno := (cQtda * SB1->B1_CUSTD)
			EndIf
		EndIf
	EndCase
	RestArea(aArea)
Return(nRetorno)
