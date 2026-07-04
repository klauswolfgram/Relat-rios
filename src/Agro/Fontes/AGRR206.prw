/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

Static oArqTemp := Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AgrR206  º Autor ³ Ricardo Tomasi     º Data ³  28/10/2004 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de referencial de custos na aplicação.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Clientes Microsiga                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AGRR206()
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Referencial de Custos nas Aplicações."
	Local titulo         := "Custo das Aplicações"
	Local nLin           := 80
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private CbTxt        := ""
	Private limite       := 132
	Private tamanho      := "M"
	Private nomeprog     := "AGRR206"
	Private nTipo        := 18
	Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey     := 0
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private cPerg        := "AGR206"
	Private wnrel        := "AGRR206" // Coloque aqui o nome do arquivo usado para impressao em disco
	Private cAliasTMP      := ""
	Private cString := "NP1"

	Pergunte(cPerg,.F.)

	dbSelectArea(cString)
	dbSetOrder(1)

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,Tamanho,,.T.)

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

	//          0         0         0         0         0         0         0         0         0         1         1         1         1
	//          1         2         3         4         5         6         7         8         9         0         1         2         3
	//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012


	AGRDLTPTB(oArqTemp)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  28/10/04   º±±
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
	Local aArea   := GetArea()
	Local nCont   := 0
	Local nCusto  := 0
	Local cUMOrig := ''
	Local cUMDest := ''

	//Variaveis para filtro e arquivos temporarios
	Local cFilNN2 := ""
	Local cFilNN3 := ""
	Local cFilNP1 := ""
	Local cFilNP5 := ""
	Local aArqTMP := {}

	//Variaveis do Cabecalho
	Local cFazenda := ""
	Local cSafra   := ""
	Local cSisCult := ""
	Local nAreaTot := 0
	Local cAreaTot := ""
	Local nQuiloHA := 0
	Local cQuiloHA := ""
	Local cSegUMHA := ""
	Local nSegUMHA := 0
	Local cCustoHA := ""
	Local nCustoHA := 0
	Local cCustUM2 := ""
	Local nCustUM2 := 0  

	//Variaveis do Desdobramento
	Local cCol04   := ""
	Local cCol05   := ""
	Local cCol06   := ""
	Local cUniAnt  := ""			
	Local nQtdaTot := 0
	Local nCustTot := 0

	//Variaveis do Rodapé
	Local nProdTot := 0
	Local nVlrTotA := 0
	Local nVlrTotB := 0
	Local nTotalAB := 0
	Local nPerTotA := 0
	Local nPerTotB := 0
	Local nPerceAB := 0
	Local nCusTotA := 0
	Local nCusTotB := 0
	Local nCustoAB := 0
	Local cVlrTotA := ""
	Local cVlrTotB := ""
	Local cTotalAB := ""
	Local cPerTotA := ""
	Local cPerTotB := ""
	Local cPerceAB := ""
	Local cCusTotA := ""
	Local cCusTotB := ""
	Local cCustoAB := ""

	titulo := AllTrim(titulo)+' '+IIf(MV_PAR10==1,'(Previsto)','(Realizado)')
	//Inicio
	dbSelectArea("NN1") //Posiciona Cadastro de Safras
	dbSetOrder(1)
	dbSeek(xFilial("NN1")+MV_PAR01)
	cSafra  := AllTrim(NN1_ANO + NN1_SEQ + " - " + NN1_DESCRI)
	cUMOrig := Posicione('SB1',1,xFilial('SB1')+NN1_CODPRO,'B1_UM')
	cUMDest := MV_PAR11

	dbSelectArea("NN2") //Posiciona Cadastro de Fazendas
	dbSetOrder(1)
	cFilNN2 := "NN2->NN2_CODIGO >= MV_PAR02 .And. NN2->NN2_CODIGO <= MV_PAR03"
	dbSetFilter({|| &cFilNN2 }, cFilNN2 )
	dbGotop()
	If MV_PAR02 == MV_PAR03
		cFazenda := AllTrim(NN2->NN2_CODIGO + " - " + NN2->NN2_NOME)
	Else
		cFazenda := AllTrim("Consolidado de Fazendas")
	EndIf

	dbSelectArea("NN3") //Posiciona Cadastro de Talhoes
	dbSetOrder(1)
	cFilNN3 := "NN3->NN3_SAFRA  == MV_PAR01 .And. " +;
	"NN3->NN3_FAZ    >= MV_PAR02 .And. " +;
	"NN3->NN3_FAZ    <= MV_PAR03 .And. " +;
	"NN3->NN3_TALHAO >= MV_PAR04 .And. " +;
	"NN3->NN3_TALHAO <= MV_PAR05"
	If MV_PAR06 < 3 //1-Plantio Direto 2-Plantio Convensional 3-Ambos
		cFilNN3  += " .And. NN3->NN3_PLANT == Str(MV_PAR06)"
		cSisCult := IIf(MV_PAR06 = 1, "1-Plantio Direto", "2-Plantio Convensional")
	Else
		cSisCult := "3-Ambos"
	EndIf
	dbSetFilter({|| &cFilNN3 }, cFilNN3 )
	dbGoTop()             
	While !Eof()
		nAreaTot := nAreaTot + NN3->NN3_HECTAR
		dbSkip()
	EndDo                                     
	cAreaTot := Transform(nAreaTot, "@E 99,999,999.999999") + " Hectares"
	dbGoTop()

	If .Not. Empty(nAreaTot)

		//Cria estrutura para arquivo temporario
		aAdd(aArqTMP,{"TMP_APLIC" ,"C",006,00})
		aAdd(aArqTMP,{"TMP_ITEM"  ,"C",002,00})
		aAdd(aArqTMP,{"TMP_TIPO"  ,"C",002,00})
		aAdd(aArqTMP,{"TMP_GRUPO" ,"C",006,00})
		aAdd(aArqTMP,{"TMP_MOCOD" ,"C",006,00})
		aAdd(aArqTMP,{"TMP_MONOM" ,"C",040,00})
		aAdd(aArqTMP,{"TMP_EQCOD" ,"C",006,00})
		aAdd(aArqTMP,{"TMP_EQNOM" ,"C",040,00})
		aAdd(aArqTMP,{"TMP_PDCOD" ,"C",015,00})
		aAdd(aArqTMP,{"TMP_PDNOM" ,"C",040,00})
		aAdd(aArqTMP,{"TMP_UM"    ,"C",002,00})
		aAdd(aArqTMP,{"TMP_QTDAPL","N",014,06})
		aAdd(aArqTMP,{"TMP_CUSTO" ,"N",016,06})

		cAliasTMP  := GetNextAlias()
		oArqTemp := AGRCRTPTB(cAliasTMP, {aArqTMP, {{"", "TMP_TIPO+TMP_GRUPO"} }} )   


		If MV_PAR10 == 1
			dbSelectArea("NP1")
			dbSetOrder(1)
			cFilNP1 := "NP1->NP1_SAFRA  == MV_PAR01 .And. " +;
			"NP1->NP1_FAZ >= MV_PAR02 .And. " +;
			"NP1->NP1_FAZ <= MV_PAR03 .And. " +;
			"NP1->NP1_TALHAO >= MV_PAR04 .And. " +;
			"NP1->NP1_TALHAO <= MV_PAR05"
			dbSetFilter({|| &cFilNP1 }, cFilNP1 )
			dbGoTop()

			nCont := 0
			While .Not. Eof()
				dbSelectArea("NP2")
				dbSetOrder(1)
				If dbSeek(xFilial("NP2")+NP1->NP1_CODIGO)
					While !Eof() .And. NP2->NP2_CODIGO == NP1->NP1_CODIGO

						nCusto := round(fRetCust(NP2->NP2_TIPO,IIf(NP2->NP2_TIPO == "PD",NP2->NP2_PDCOD,IIf(NP2->NP2_TIPO == "MO",NP2->NP2_MOCOD,NP2->NP2_EQCOD)),NP2->NP2_QTDTOT),2)

						dbSelectArea(cAliasTMP)
						If fPrcProd(IIf(NP2->NP2_TIPO == "PD",NP2->NP2_PDCOD,IIf(NP2->NP2_TIPO == "MO",NP2->NP2_MOCOD,NP2->NP2_EQCOD)),IIf(NP6->NP6_TIPO == "PD","AA","BB"))
							If RecLock(cAliasTMP,.f.)
								(cAliasTMP)->TMP_QTDAPL := (cAliasTMP)->TMP_QTDAPL + NP2->NP2_QTDTOT
								(cAliasTMP)->TMP_CUSTO  := (cAliasTMP)->TMP_CUSTO  + nCusto
								MsUnLock()
							EndIf
						Else
							If RecLock(cAliasTMP,.t.)
								(cAliasTMP)->TMP_APLIC  := NP2->NP2_CODIGO
								(cAliasTMP)->TMP_ITEM   := NP2->NP2_ITEM
								(cAliasTMP)->TMP_TIPO   := IIf(NP2->NP2_TIPO == "PD","AA","BB")
								(cAliasTMP)->TMP_MOCOD  := NP2->NP2_MOCOD
								(cAliasTMP)->TMP_MONOM  := NP2->NP2_MONOM
								(cAliasTMP)->TMP_EQCOD  := NP2->NP2_EQCOD
								(cAliasTMP)->TMP_EQNOM  := NP2->NP2_EQNOM
								(cAliasTMP)->TMP_GRUPO  := IIf(NP2->NP2_TIPO == "PD",RetGRP(NP2->NP2_PDCOD),NP1->NP1_CODSRV)
								(cAliasTMP)->TMP_PDCOD  := NP2->NP2_PDCOD
								(cAliasTMP)->TMP_PDNOM  := NP2->NP2_PDNOM
								(cAliasTMP)->TMP_UM     := NP2->NP2_UM
								(cAliasTMP)->TMP_QTDAPL := NP2->NP2_QTDTOT
								(cAliasTMP)->TMP_CUSTO  := nCusto
								MsUnLock()
							EndIf
						EndIf

						If NP2->NP2_TIPO == "PD"
							nCusTotA := nCusTotA + nCusto
						Else
							nCusTotB := nCusTotB + nCusto
						EndIf 

						dbSelectArea("NP2")
						dbSkip()
					EndDo
				EndIf
				nCont++
				dbSelectArea("NP1")
				dbSkip()
			EndDo
		Else
			dbSelectArea("NP5")
			dbSetOrder(1)
			cFilNP5 := "NP5->NP5_SAFRA  == MV_PAR01 .And. " +;
			"NP5->NP5_FAZ >= MV_PAR02 .And. " +;
			"NP5->NP5_FAZ <= MV_PAR03 .And. " +;
			"NP5->NP5_TALHAO >= MV_PAR04 .And. " +;
			"NP5->NP5_TALHAO <= MV_PAR05"
			dbSetFilter({|| &cFilNP5 }, cFilNP5 )
			dbGoTop()

			nCont := 0
			While .Not. Eof()
				dbSelectArea("NP6")
				dbSetOrder(1)
				If dbSeek(xFilial("NP6")+NP5->NP5_CODIGO)
					While !Eof() .And. NP6->NP6_CODIGO == NP5->NP5_CODIGO

						nCusto := round(IIf(MV_PAR09 = 1, NP6->NP6_CUSTO, fRetCust(NP6->NP6_TIPO,;
						IIf(NP6->NP6_TIPO == "PD",NP6->NP6_PDCOD,;
						IIf(NP6->NP6_TIPO == "MO",NP6->NP6_MOCOD,NP6->NP6_EQCOD)),NP6->NP6_QTDTOT)),2)

						dbSelectArea(cAliasTMP)
						If fPrcProd(IIf(NP6->NP6_TIPO == "PD",NP6->NP6_PDCOD,IIf(NP6->NP6_TIPO == "MO",NP6->NP6_MOCOD,NP6->NP6_EQCOD)),IIf(NP6->NP6_TIPO == "PD","AA","BB"))
							If RecLock(cAliasTMP,.f.)
								(cAliasTMP)->TMP_QTDAPL := (cAliasTMP)->TMP_QTDAPL + NP6->NP6_QTDTOT
								(cAliasTMP)->TMP_CUSTO  := (cAliasTMP)->TMP_CUSTO  + nCusto
								MsUnLock()
							EndIf
						Else
							If RecLock(cAliasTMP,.t.)
								(cAliasTMP)->TMP_APLIC  := NP6->NP6_CODIGO
								(cAliasTMP)->TMP_ITEM   := NP6->NP6_ITEM
								(cAliasTMP)->TMP_TIPO   := IIf(NP6->NP6_TIPO == "PD","AA","BB")
								(cAliasTMP)->TMP_MOCOD  := NP6->NP6_MOCOD
								(cAliasTMP)->TMP_MONOM  := NP6->NP6_MONOM
								(cAliasTMP)->TMP_EQCOD  := NP6->NP6_EQCOD
								(cAliasTMP)->TMP_EQNOM  := NP6->NP6_EQNOM
								(cAliasTMP)->TMP_GRUPO  := IIf(NP6->NP6_TIPO == "PD",RetGRP(NP6->NP6_PDCOD),NP5->NP5_CODSRV)
								(cAliasTMP)->TMP_PDCOD  := NP6->NP6_PDCOD
								(cAliasTMP)->TMP_PDNOM  := NP6->NP6_PDNOM
								(cAliasTMP)->TMP_UM     := NP6->NP6_UM
								(cAliasTMP)->TMP_QTDAPL := NP6->NP6_QTDTOT
								(cAliasTMP)->TMP_CUSTO  := nCusto
								MsUnLock()
							EndIf
						EndIf

						If NP6->NP6_TIPO == "PD"
							nCusTotA := nCusTotA + nCusto
						Else
							nCusTotB := nCusTotB + nCusto
						EndIf 

						dbSelectArea("NP6")
						dbSkip()
					EndDo
				EndIf
				nCont++
				dbSelectArea("NP5")
				dbSkip()
			EndDo
		EndIf

		nCustoAB := nCusTotA + nCusTotB

		nVlrTotA := (nCusTotA / nAreaTot)
		nVlrTotB := (nCusTotB / nAreaTot)
		nTotalAB := nVlrTotA + nVlrTotB

		nPerTotA := ((nVlrTotA * 100) / nTotalAB)
		nPerTotB := ((nVlrTotB * 100) / nTotalAB)
		nPerceAB := nPerTotA + nPerTotB

		cCusTotA := Transform(nCusTotA, "@E 999,999,999.9999")
		cCusTotB := Transform(nCusTotB, "@E 999,999,999.9999")
		cCustoAB := Transform(nCustoAB, "@E 999,999,999.9999")

		cVlrTotA := Transform(nVlrTotA, "@E 9,999,999.9999")
		cVlrTotB := Transform(nVlrTotB, "@E 9,999,999.9999")
		cTotalAB := Transform(nTotalAB, "@E 9,999,999.9999")
		cPerTotA := Transform(nPerTotA, "@E 999.99")
		cPerTotB := Transform(nPerTotB, "@E 999.99")
		cPerceAB := Transform(nPerceAB, "@E 999.99")

		nProdTot := RetPDC() //produçao total da safra da(s) fazenda(s) e talhoes

		nQuiloHA := (nProdTot / nAreaTot) //total de producao na UM de Origem DIVIDIDO pelo total de area cultivada

		nSegUMHA := ((AgrX001(cUMOrig,cUMDest,nProdTot)) / nAreaTot) //total da producao na UM de Destino DIVIDIDO pelo valor da segunda unidade

		nCustoHA := (nCustoAB / nAreaTot) //total de custos DIVIDIDO pelo total de area cultivada

		nCustUM2 := nCustoHA / nSegUMHA

		cQuiloHA := Transform(nQuiloHA, "@E 99,999,999.999999")
		cSegUMHA := Transform(nSegUMHA, "@E 99,999,999.999999")
		cCustoHA := Transform(nCustoHA, "@E 99,999,999.999999")
		cCustUM2 := Transform(nCustUM2, "@E 99,999,999.999999")



		//          0         0         0         0         0         0         0         0         0         1         1         1         1
		//          1         2         3         4         5         6         7         8         9         0         1         2         3
		//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
		//+--------------------------------------------------+                            +--------------------------------------------------+
		//| Fazenda: 123456 - 123456789012345678901234567890 |                            | Safra: 123456 - 1234/1234 12345678901234567890   |
		//+--------------------------------------------------+                            +--------------------------------------------------+
		//| Sistema de Cultivo: 2-Plantio Convensional       |                            | Area Cultivada: 99,999,999.999999 Hectares       |
		//+--------------------------------------------------+                            +--------------------------------------------------+
		//| Produção em Quilos por Hectar: 99,999,999.999999 |                            | Produção em Sacas por Hectar:  99,999,999.999999 |
		//+--------------------------------------------------+                            +--------------------------------------------------+
		//| Custo por Hectar:              99,999,999.999999 |                            | Custo por Saca:                99,999,999.999999 |
		//+--------------------------------------------------+                            +--------------------------------------------------+
		//
		//          0         0         0         0         0         0         0         0         0         1         1         1         1
		//          1         2         3         4         5         6         7         8         9         0         1         2         3
		//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
		//+--------------------------------------------+----+----------------+------------+----------------+----------------+----------------+
		//| A - Grupo de Insumos                       | UM |  Quantidade/HA | Qtd. Total | Valor Unitario |  Vlr. Total/HA | Total do Custo |
		//+--------------------------------------------+----+----------------+------------+----------------+----------------+----------------+
		//
		//+--------------------------------------------+----+----------------+------------+----------------+----------------+----------------+
		//| B - Grupo de Serviços                      | UM |  Quantidade/HA | Qtd. Total | Valor Unitario |  Vlr. Total/HA | Total do Custo |
		//+--------------------------------------------+----+----------------+------------+----------------+----------------+----------------+
		//
		//+--------------------------------------------+----+----------------+------------+----------------+----------------+----------------+
		//| Total dos Grupos                           | UM |  Quantidade/HA | Qtd. Total | Valor Unitario |  Vlr. Total/HA | Total do Custo |
		//+--------------------------------------------+----+----------------+------------+----------------+----------------+----------------+
		//|  A - Insumos                               |    |                |            |                |                |                |
		//+--------------------------------------------+----+----------------+------------+----------------+----------------+----------------+
		//|  B - Serviços                              |    |                |            |                |                |                |
		//+============================================+====+================+============+================+================+================+
		//| Total do Grupos                            |    |                |            |                |                |                |
		//+============================================+====+================+============+================+================+================+

		If nLin > 55
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif

		@ nLin, 00 PSay "+--------------------------------------------------+                            +--------------------------------------------------+"; nLin++
		@ nLin, 00 PSay "| Fazenda: " + PadR(cFazenda,39)               + " |                            | Safra: " + PadR(cSafra,41)                   + " |"; nLin++
		@ nLin, 00 PSay "+--------------------------------------------------+                            +--------------------------------------------------+"; nLin++
		@ nLin, 00 PSay "| Sistema de Cultivo: " + PadR(cSisCult,28)    + " |                            | Area Cultivada: " + PadR(cAreaTot,32)        + " |"; nLin++
		@ nLin, 00 PSay "+--------------------------------------------------+                            +--------------------------------------------------+"; nLin++
		@ nLin, 00 PSay "| Produção em "+cUMOrig+" por HA: "+PadL(cQuiloHA,25)+" |                            | Produção em "+cUMDest+ " por HA: "+PadL(cSegUMHA,25)+" |"; nLin++
		@ nLin, 00 PSay "+--------------------------------------------------+                            +--------------------------------------------------+"; nLin++
		//	@ nLin, 00 PSay "| Custo em Reais por HA: " + PadL(cCustoHA,25) + " |                            | Custo em Reais por "+MV_PAR11+": "+PadL(cCustUM2,25)+" |"; nLin++
		@ nLin, 00 PSay "| Custo em "+PadR(mv_par12,6)+" por HA: " + PadL(cCustoHA,24) + " |                            | Custo em "+PadR(mv_par12,6)+" por "+MV_PAR11+": "+PadL(cCustUM2,24)+" |"; nLin++
		@ nLin, 00 PSay "+--------------------------------------------------+                            +--------------------------------------------------+"; nLin++
		nLin += 2

		dbSelectArea(cAliasTMP)
		dbSetOrder(1)
		dbGoTop()
		While !Eof()
			If nLin > 55
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif

			If MV_PAR07 = 1 .Or. MV_PAR07 = 3
				@ nLin, 00 PSay "+--------------------------------------------+----+---------------+-------------+----------------+----------------+----------------+"; nLin++
				@ nLin, 00 PSay "| A - Grupo de Insumos                       | UM | Quantidade/HA | Qtd. Total  | Valor Unitario |  Vlr. Total/HA | Total do Custo |"; nLin++
				@ nLin, 00 PSay "+--------------------------------------------+----+---------------+-------------+----------------+----------------+----------------+"; nLin++
				While (cAliasTMP)->TMP_TIPO == "AA" .And. !Eof()
					If nLin > 55
						If nLin < 80
							Roda()
						EndIf
						Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
						nLin := 9
					Endif

					cGrpAnt := (cAliasTMP)->TMP_GRUPO
					cUniAnt := (cAliasTMP)->TMP_UM
					While cGrpAnt == (cAliasTMP)->TMP_GRUPO .And. !Eof()
						If nLin > 55
							If nLin < 80
								Roda()
							EndIf
							Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
							nLin := 9
						Endif

						If MV_PAR08 = 2
							@ nLin, 004 PSay PadR((cAliasTMP)->TMP_PDCOD + " - " + (cAliasTMP)->TMP_PDNOM,40)
							@ nLin, 047 PSay (cAliasTMP)->TMP_UM
							@ nLin, 052 PSay Transform(((cAliasTMP)->TMP_QTDAPL / nAreaTot), "@E 999,999.999999")
							@ nLin, 067 PSay Transform((cAliasTMP)->TMP_QTDAPL, "@E 99,999,999.99")
							@ nLin, 082 PSay Transform(((cAliasTMP)->TMP_CUSTO / (cAliasTMP)->TMP_QTDAPL), "@E 999,999.999999")
							@ nLin, 099 PSay Transform(((cAliasTMP)->TMP_CUSTO / nAreaTot), "@E 999,999.999999")
							@ nLin, 116 PSay Transform((cAliasTMP)->TMP_CUSTO, "@E 999,999,999.999")
							nLin++
						EndIf
						nQtdaTot := nQtdaTot + (cAliasTMP)->TMP_QTDAPL
						nCustTot := nCustTot + (cAliasTMP)->TMP_CUSTO
						cUniAnt  := IIf((cAliasTMP)->TMP_UM == cUniAnt, (cAliasTMP)->TMP_UM, "**")
						dbSkip()
					EndDo
					//Tratar resultado do grupo
					//				cCol01 := cUniAnt
					//				cCol02 := Transform((nQtdaTot / nAreaTot), "@E 999,999.999999")
					//				cCol03 := Transform(((nCustTot * 100) / nCustoAB), "@E 999.99")
					cCol04 := Transform((nCustTot / nQtdaTot), "@E 999,999.999999")
					cCol05 := Transform((nCustTot / nAreaTot), "@E 999,999.999999")
					cCol06 := Transform(nCustTot, "@E  999,999,999.999")

					nQtdaTot := 0
					nCustTot := 0

					@ nLin, 001 PSay PadR(AllTrim(cGrpAnt) + " - " + DescGRP("AA",cGrpAnt),43)
					//				@ nLin, 047 PSay cCol01
					//				@ nLin, 052 PSay cCol02
					//				@ nLin, 069 PSay cCol03
					@ nLin, 082 PSay cCol04
					@ nLin, 099 PSay cCol05
					@ nLin, 116 PSay cCol06
					nLin++

				EndDo                            
				If MV_PAR07 = 1; dbGoBottom(); dbSkip(); EndIf
			EndIf  
			nLin += 2
			If MV_PAR07 = 2 .Or. MV_PAR07 = 3
				@ nLin, 00 PSay "+--------------------------------------------+----+---------------+-------------+----------------+----------------+----------------+"; nLin++
				@ nLin, 00 PSay "| B - Grupo de Serviços                      | UM | Quantidade/HA | Qtd. Total  | Valor Unitario |  Vlr. Total/HA | Total do Custo |"; nLin++
				@ nLin, 00 PSay "+--------------------------------------------+----+---------------+-------------+----------------+----------------+----------------+"; nLin++
				While (cAliasTMP)->TMP_TIPO == "BB" .And. !Eof()
					If nLin > 55
						If nLin < 80
							Roda()
						EndIf
						Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
						nLin := 9
					Endif

					cGrpAnt := (cAliasTMP)->TMP_GRUPO
					While cGrpAnt == (cAliasTMP)->TMP_GRUPO .And. !Eof() 
						If nLin > 55
							If nLin < 80
								Roda()
							EndIf
							Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
							nLin := 9
						Endif

						If MV_PAR08 = 2
							If AllTrim((cAliasTMP)->TMP_EQCOD) == ""
								@ nLin, 004 PSay PadR((cAliasTMP)->TMP_MOCOD + " - " + (cAliasTMP)->TMP_MONOM,40)
							Else
								@ nLin, 004 PSay PadR((cAliasTMP)->TMP_EQCOD + " - " + (cAliasTMP)->TMP_EQNOM,40)
							EndIf
							@ nLin, 047 PSay "HS"
							@ nLin, 052 PSay Transform(((cAliasTMP)->TMP_QTDAPL / nAreaTot), "@E 999,999.999999")
							@ nLin, 067 PSay Transform((cAliasTMP)->TMP_QTDAPL, "@E 99,999,999.99")
							@ nLin, 082 PSay Transform(((cAliasTMP)->TMP_CUSTO / (cAliasTMP)->TMP_QTDAPL), "@E 999,999.999999")
							@ nLin, 099 PSay Transform(((cAliasTMP)->TMP_CUSTO  / nAreaTot), "@E 999,999.999999")
							@ nLin, 116 PSay Transform((cAliasTMP)->TMP_CUSTO, "@E 999,999,999.999")
							nLin++
						EndIf
						nQtdaTot := nQtdaTot + (cAliasTMP)->TMP_QTDAPL
						nCustTot := nCustTot + (cAliasTMP)->TMP_CUSTO
						dbSkip()
					EndDo
					//Tratar resultado do grupo

					//				cCol01 := "HS"
					//				cCol02 := Transform((nQtdaTot / nAreaTot), "@E 999,999.999999")
					//				cCol03 := Transform(((nCustTot * 100) / nCustoAB), "@E 999.99")
					cCol04 := Transform((nCustTot / nQtdaTot), "@E 999,999.999999")
					cCol05 := Transform((nCustTot / nAreaTot), "@E 999,999.999999")
					cCol06 := Transform(nCustTot, "@E  999,999,999.999")

					nQtdaTot := 0
					nCustTot := 0

					@ nLin, 001 PSay PadR(AllTrim(cGrpAnt) + " - " + DescGRP("BB", cGrpAnt),43)
					//				@ nLin, 047 PSay cCol01
					//				@ nLin, 052 PSay cCol02
					//				@ nLin, 069 PSay cCol03
					@ nLin, 082 PSay cCol04
					@ nLin, 099 PSay cCol05
					@ nLin, 116 PSay cCol06
					nLin++

				EndDo
				If MV_PAR07 = 2; dbGoBottom(); dbSkip(); EndIf
			EndIf
		EndDo      

		If nLin > 43
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif

		nLin += 2
		@ nLin, 00 PSay "+--------------------------------------------+----+---------------+-------------+----------------+----------------+----------------+"; nLin++
		@ nLin, 00 PSay "| Total dos Grupos                           | UM | Quantidade/HA | Qtd. Total  | Valor Unitario |  Vlr. Total/HA | Total do Custo |"; nLin++
		@ nLin, 00 PSay "+--------------------------------------------+----+---------------+-------------+----------------+----------------+----------------+"; nLin++
		@ nLin, 00 PSay "|  A - Insumos                               |    |               |             |                | "+PadL(cVlrTotA,14)+" | "+PadL(cCusTotA,14)+" |"; nLin++
		@ nLin, 00 PSay "+--------------------------------------------+----+---------------+-------------+----------------+----------------+----------------+"; nLin++
		@ nLin, 00 PSay "|  B - Serviços                              |    |               |             |                | "+PadL(cVlrTotB,14)+" | "+PadL(cCusTotB,14)+" |"; nLin++
		@ nLin, 00 PSay "+============================================+====+===============+=============+================+================+================+"; nLin++
		@ nLin, 00 PSay "| Total do Grupo                             |    |               |             |                | "+PadL(cTotalAB,14)+" | "+PadL(cCustoAB,14)+" |"; nLin++
		@ nLin, 00 PSay "+============================================+====+===============+=============+================+================+================+"; nLin++

		//Finaliza relatorio
		(cAliasTMP)->(dbCloseArea())
		//FErase(cArqTMP+".DBF")
		//FErase(cIndTMP+OrdBagExt())
		RestArea(aArea)     

		Roda()

	EndIf

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return()

//-----------------------------------------Procura por Produto ja Existente
Static Function fPrcProd(cCodigo, cType)
	Local lRetorno := .f.
	Local cChCOD   := AllTrim(cCodigo)
	dbSelectArea(cAliasTMP)
	dbGoTop()
	While !Eof()
		If (AllTrim((cAliasTMP)->TMP_MOCOD) == cChCOD .and. cType == "BB") .Or. (AllTrim((cAliasTMP)->TMP_EQCOD) == cChCOD .and. cType == "BB" ) .Or. (AllTrim((cAliasTMP)->TMP_PDCOD) == cChCOD .and. cType == "AA" )
			lRetorno := .t.
			Exit
		EndIf
		dbSkip()
	EndDo

Return(lRetorno)

//-----------------------------------------Retorna Grupo do Produto
Static Function RetGRP(cCodPro)
	Local aArea    := GetArea()
	Local cCodGrup := ""
	Local cRetorno := ""
	dbSelectArea("SB1")
	dbSetOrder(1)
	dbSeek(xFilial("SB1")+cCodPro,.T.)
	cCodGrup := SB1->B1_GRUPO
	dbSelectArea("SBM")
	dbSetOrder(1)
	dbSeek(xFilial("SBM")+cCodGrup,.T.)
	cRetorno := Subst(SBM->BM_GRUPO,1,6)
	RestArea(aArea)
Return(cRetorno)

//-----------------------------------------Retorna Produção Total da Safra da Fazenda e Talhao
Static Function RetPDC()
	Local aArea    := GetArea()
	Local nRetorno := 0                                                        
	Local cFiltro  := ""                          
	Local cIndFile := CriaTrab(Nil,.F.)

	cFiltro += "NPA_SAFRA  >= MV_PAR01 .And. NPA_SAFRA  <= MV_PAR01 .And. "
	cFiltro += "NPA_FAZ    >= MV_PAR02 .And. NPA_FAZ    <= MV_PAR03 .And. "
	cFiltro += "NPA_TALHAO >= MV_PAR04 .And. NPA_TALHAO <= MV_PAR05 .And. "
	cFiltro += "NPA_FECHAD  = 'S'"
	IndRegua("NPA",cIndFile,"NPA_SAFRA+NPA_FAZ+NPA_TALHAO+NPA_FECHAD",,cFiltro,"Selecionando Registros...")

	dbSelectArea("NPA")
	While !Eof()
		nRetorno := nRetorno + NPA->NPA_QTDREA
		dbSkip()
	EndDo

	RestArea(aArea)
Return(nRetorno)

Static Function DescGRP(cTipo,cCodigo)
	Local aArea := GetArea()
	Local cRetorno := ""

	If cTipo == "AA"
		dbSelectArea("SBM")
		dbSetOrder(1)
		dbGoTop()
		If dbSeek(xFilial("SBM")+cCodigo,.t.)
			cRetorno := SBM->BM_DESC
		EndIf
	EndIf

	If cTipo == "BB"
		dbSelectArea("NN9")
		dbSetOrder(1)
		dbGoTop()
		If dbSeek(xFilial("NN9")+cCodigo)
			cRetorno := NN9->NN9_DESCRI
		EndIf
	EndIf

	RestArea(aArea)
Return(cRetorno)

Static Function fRetCust(cTipo,cCodigo,cQtda)
	Local aArea    := GetArea()
	Local nRetorno := 0

	Do Case
		Case cTipo == "EQ"
		dbSelectArea("NNB")
		dbSetOrder(1)
		If dbSeek(xFilial("NNB")+cCodigo)
			nRetorno := (cQtda * NNB->NNB_CUSEST)
		EndIf
		Case cTipo == "MO"
		dbSelectArea("NNA")
		dbSetOrder(1)
		If dbSeek(xFilial("NNA")+cCodigo)
			nRetorno := (cQtda * NNA->NNA_CUSEST)
		EndIf
		Case cTipo == "PD"
		If MV_PAR09 == 1
			dbSelectArea("SB2")
			dbSetOrder(1)
			If dbSeek(xFilial("SB2")+cCodigo)
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
