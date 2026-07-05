/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AgrR202   º Autor ³ Ricardo Tomasi     º Data ³  24/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio para impressão da uma ou varias aplicações.      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Cliente Microsiga                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR202(cAlias, nReg)

	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Planilha para Aplicação"
	Local titulo         := "Planilha para Aplicação"
	Local nLin           := 80
	Local Cabec1         := ""
	Local Cabec2         := ""
	Local aOrd           := {}

	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private limite       := 80
	Private tamanho      := "P"
	Private nomeprog     := "AGRR202" // Coloque aqui o nome do programa para impressao no cabecalho
	Private nTipo        := 18
	Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
	Private nLastKey     := 0
	Private cbtxt        := Space(10)
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private cPerg        := "AGR202"
	Private wnrel        := "AGRR202" // Coloque aqui o nome do arquivo usado para impressao em disco
	Private cString      := "NP1"
	Private nRegistro    := nReg

	dbSelectArea("NP1")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	If nRegistro != Nil
		cPerg := ""
	EndIf

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

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
	Local cFase     := ""
	Local cSafra    := ""
	Local cProduto  := ""
	Local cTalhao   := ""
	Local cArea     := ""
	Local cServico  := ""
	Local aProd     := {}
	Local aEqui     := {}
	Local aMaoD     := {}
	Local nCont     := 0
	Local cPictPd   := "@R 9,999,999.99"
	Local cIndex
	Local cChave
	Local nIndex
	Local nProd     := 0
	Local nX        := 0   
	Local cCProdA   := ""
	Local cCProdB   := ""
	Local cCProdC   := ""
	Local cCProdD   := "" 

	Local cProdA    := ""
	Local cProdB    := ""
	Local cProdC    := ""
	Local cProdD    := ""

	Local nVProdA   := 0
	Local nVProdB   := 0
	Local nVProdC   := 0
	Local nVProdD   := 0

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

	cFiltro += "NP1_CODIGO >= '" + cCodDe  + "' .And. "
	cFiltro += "NP1_CODIGO <= '" + cCodAte + "' .And. "
	cFiltro += "DToS(NP1_DATA) >= '" + DToS(dDatDe)  + "' .And. "
	cFiltro += "DToS(NP1_DATA) <= '" + DToS(dDatAte) + "'"
	cFiltro += IIf(Empty(aReturn[7]),""," .And. "+aReturn[7])

	dbSelectArea("NP1")
	dbSetOrder(1)
	//dbSetFilter( {|| &cFiltro }, cFiltro )
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

	While !Eof()

		Cabec1 := "Numero da Aplicação: " + AllTrim(NP1->NP1_CODIGO)

		If lAbortPrint
			@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		If nLin > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif

		cFazenda := PadC("Fazenda: " + AllTrim(Posicione("NN2",2,xFilial("NN2")+NP1->NP1_FAZ,"NN2_NOME")),49) //49
		cDataApl := PadR("Data Aplicação: " + DToC(NP1->NP1_DATA),24) //24
		dbSelectArea("NN1")
		dbSetOrder(1)
		dbSeek(xFilial("NN1")+NP1->NP1_SAFRA,.T.)
		cSafra   := PadR("Safra: " + NN1->NN1_ANO + "/" + NN1->NN1_SEQ,14) //14
		cProduto := PadR("Produto: " + AllTrim(NN1->NN1_CODPRO) + " " + NN1->NN1_DESPRO,32) //32
		cTalhao  := PadR("Talhão: " + NP1->NP1_TALHAO + " " + Posicione("NN3",1,xFilial("NN3")+NP1->NP1_SAFRA+NP1->NP1_FAZ+NP1->NP1_TALHAO,"NN3_DESCRI"),24) //24
		cArea    := PadR("Area da Aplicação: " + Transform(NP1->NP1_AREA, X3Picture("NP1_AREA")) + " Hectares",49) //49
		cServico := PadR("Serviço a ser executado: " + AllTrim(NP1->NP1_CODSRV) + " " + NP1->NP1_DESSRV ,76) //76

		@ nLin, 00 PSay "+---------------------------------------------------+--------------------------+";	nLin++
		@ nLin, 00 PSay "| "  +               cFazenda                   + " | " +    cDataApl      + " |";	nLin++
		@ nLin, 00 PSay "+--------------------------+----------------+-------+--------------------------+";	nLin++
		@ nLin, 00 PSay "| " +      cFase       + " | " + cSafra + " | " +        cProduto          + " |";	nLin++
		@ nLin, 00 PSay "+--------------------------+----------------+----------------------------------+";	nLin++
		@ nLin, 00 PSay "| " +      cTalhao     + " | " +                cArea                      + " |";	nLin++
		@ nLin, 00 PSay "+--------------------------+---------------------------------------------------+";	nLin++
		@ nLin, 00 PSay "| " +                            cServico                                  + " |";	nLin++
		@ nLin, 00 PSay "+-----------------------+------------------------+-----------------------------+";	nLin++   


		dbSelectArea('NP2')
		dbSetOrder(2)
		If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'MO')
			@ nLin, 01 PSay "Mao de Obra " + space(11) + "|"
			@ nLin, 26 PSay "Descrição   " + space(11) + "|"
			@ nLin, 51 PSay "Horas "       
			nLin++

			nCont := 0
			While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "MO"
				nCont++  
				aadd(aMaoD,{AllTrim(NP2->NP2_MOCOD), AllTrim(NP2->NP2_MONOM),0})        

				//--------------------------------------------------
				nRegist := Recno()
				cCodigo := NP2->NP2_MOCOD
				nQuant  := 0
				If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'MO'+'R'+cCodigo)
					While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "MO" .And. NP2->NP2_MOCOD = cCodigo
						nQuant := nQuant + NP2->NP2_QTDRET
						dbSkip()
					EndDo
				EndIf
				dbGoto(nRegist)
				//--------------------------------------------------
				aMaoD[nCont,3] := NP2->NP2_QTDTOT - nQuant
				aMaoD[nCont,2] := IIf(ValType(aMaoD[nCont,2])=='U','',aMaoD[nCont,2])

				@ nLin, 01 PSay PadR(aMaoD[nCont,1],6)   + space(17) + "|"
				@ nLin, 27 PSay PadR(aMaoD[nCont,2],15)  + space(07) + "|"
				@ nLin, 52 PSay Alltrim(Transform(aMaoD[nCont,3],cPictPd))
				nLin++     

				If nLin > 55
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 8
				Endif
				dbSkip()
			EndDo

			@ nLin,00 PSay "+-----------------------+------------------------+-----------------------------+"
			nLin++
		EndIf



		dbSelectArea('NP2')
		dbSetOrder(3)
		If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'EQ')
			@ nLin, 01 PSay "Equipamento " + space(11) + "|"
			@ nLin, 26 PSay "Descrição   " + space(11) + "|"
			@ nLin, 51 PSay "Horas       " 
			nLin++

			nCont := 0
			While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "EQ"
				nCont++      
				aadd(aEqui,{AllTrim(NP2->NP2_EQCOD), AllTrim(NP2->NP2_EQNOM),0})    

				//--------------------------------------------------
				nRegist := Recno()
				cCodigo := NP2->NP2_EQCOD
				nQuant  := 0
				If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'EQ'+'R'+cCodigo)
					While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "EQ" .And. NP2->NP2_EQCOD = cCodigo
						nQuant := nQuant + NP2->NP2_QTDRET
						dbSkip()
					EndDo
				EndIf
				dbGoto(nRegist)
				//--------------------------------------------------
				aEqui[nCont,3] := NP2->NP2_QTDTOT - nQuant

				@ nLin, 01 PSay PadR(aEqui[nCont,1],18)  + space(05) + "|"
				@ nLin, 27 PSay PadR(aEqui[nCont,2],18)  + space(04) + "|"
				@ nLin, 52 PSay Alltrim(Transform(aEqui[nCont,3],cPictPd))
				nLin++   

				If nLin > 55
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 8
				Endif

				dbSkip()
			EndDo
			@ nLin,00 PSay "+-----------------------+------------------------+-----------------------------+"
		EndIf


		dbSelectArea('NP2')
		dbSetOrder(4)
		If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'PD')
			nCont := 0
			While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "PD"
				nCont++

				aadd(aProd,{AllTrim(NP2->NP2_PDCOD), AllTrim(NP2->NP2_PDNOM),0,.F.})    

				//--------------------------------------------------
				nRegist := Recno()
				cCodigo := NP2->NP2_PDCOD
				nQuant  := 0
				If dbSeek(xFilial('NP2')+NP1->NP1_CODIGO+'PD'+'R'+cCodigo)
					While NP2->NP2_CODIGO == NP1->NP1_CODIGO .And. NP2->NP2_TIPO == "PD" .And. NP2->NP2_PDCOD = cCodigo
						nQuant := nQuant + NP2->NP2_QTDRET
						dbSkip()
					EndDo
				EndIf
				dbGoto(nRegist)
				//--------------------------------------------------
				aProd[nCont,3] := NP2->NP2_QTDTOT - nQuant

				dbSkip()
			EndDo
		EndIf

		If nCont > 0 .And. Len(aProd) > 0

			nProd := 0

			For nX := 1 To Len(aProd)

				If nProd == 0 
					cCProdA := IIf(ValType(aProd[nX  ,1])=='U','',aProd[nX  ,1])     
					cCProdB := iif(nX+1>len(aProd),'',IIf(ValType(aProd[nX+1,1])=='U','',aProd[nX+1,1]))
					cCProdC := iif(nX+2>len(aProd),'',IIf(ValType(aProd[nX+2,1])=='U','',aProd[nX+2,1]))
					cCProdD := iif(nX+3>len(aProd),'',IIf(ValType(aProd[nX+3,1])=='U','',aProd[nX+3,1]))

					cProdA := IIf(ValType(aProd[nX  ,2])=='U','',aProd[nX  ,2])     
					cProdB := iif(nX+1>len(aProd),'',IIf(ValType(aProd[nX+1,2])=='U','',aProd[nX+1,2]))
					cProdC := iif(nX+2>len(aProd),'',IIf(ValType(aProd[nX+2,2])=='U','',aProd[nX+2,2]))
					cProdD := iif(nX+3>len(aProd),'',IIf(ValType(aProd[nX+3,2])=='U','',aProd[nX+3,2]))

					nVProdA := IIf(ValType(aProd[nX  ,3])=='U',0,aProd[nX  ,3])     
					nVProdB := iif(nX+1>len(aProd),0,IIf(ValType(aProd[nX+1,3])=='U',0,aProd[nX+1,3]))
					nVProdC := iif(nX+2>len(aProd),0,IIf(ValType(aProd[nX+2,2])=='U',0,aProd[nX+2,3]))
					nVProdD := iif(nX+3>len(aProd),0,IIf(ValType(aProd[nX+3,2])=='U',0,aProd[nX+3,3]))

					nLin++ 		
					@ nLin, 01 PSay "Prod. A-" + PadR(cCProdA,10) + " |"
					@ nLin, 21 PSay "Prod. B-" + PadR(cCProdB,10) + " |"
					@ nLin, 41 PSay "Prod. C-" + PadR(cCProdC,10) + " |"
					@ nLin, 61 PSay "Prod. D-" + PadR(cCProdD,10)
					nLin++
					@ nLin, 01 PSay PadR(cProdA,18) + " |"
					@ nLin, 21 PSay PadR(cProdB,18) + " |"
					@ nLin, 41 PSay PadR(cProdC,18) + " |"
					@ nLin, 61 PSay PadR(cProdD,18)
					nLin++
					@ nLin, 01 PSay PadR(Subst(cProdA,19,Len(aProd[nX,2])),18) + " |"
					@ nLin, 21 PSay PadR(Subst(cProdB,19,Len(aProd[nX,2])),18) + " |"
					@ nLin, 41 PSay PadR(Subst(cProdC,19,Len(aProd[nX,2])),18) + " |"
					@ nLin, 61 PSay PadR(Subst(cProdD,19,Len(aProd[nX,2])),18)
					nLin++
					@ nLin, 01 PSay "-------------------+-------------------+-------------------+------------------"
					nLin++                   
					@ nLin, 01 PSay "Qtde. " + Transform(nVProdA,cPictPd) + " |"
					@ nLin, 21 PSay "Qtde. " + Transform(nVProdB,cPictPd) + " |"
					@ nLin, 41 PSay "Qtde. " + Transform(nVProdC,cPictPd) + " |"
					@ nLin, 61 PSay "Qtde. " + Transform(nVProdD,cPictPd)
					nLin++
					@ nLin, 01 PSay "  P/HA   | No Tanq |  P/HA   | No Tanq |  P/HA   | No Tanq |  P/HA   | No Tanq"
					nLin++
					@ nLin, 01 PSay "---------+---------+---------+---------+---------+---------+---------+--------"
					For nCont := 1 to 10
						nLin++
						@ nLin, 01 PSay "         |         |         |         |         |         |         |        "
						nLin++
						@ nLin, 01 PSay "---------+---------+---------+---------+---------+---------+---------+--------"
					Next nCont                                                                                         
					nLin++
					@ nLin, 01 PSay " Total-> |         | Total-> |         | Total-> |         | Total-> |        "
					nLin++
					@ nLin, 01 PSay "---------+---------+---------+---------+---------+---------+---------+--------"			
				EndIf

				nProd++

				If nProd == 4 
					nProd := 0   
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 8 
				EndIf
			Next		
		EndIf

		If nLin > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8 
		EndIf 		

		nLin++
		@ nLin, 00 PSay "+----------DATA DA APLICAÇÃO------------+-------ASSINATURA DO RESPONSAVEL------+";	nLin++
		@ nLin, 00 PSay "|                                       |                                      |";	nLin++
		@ nLin, 00 PSay "|                                       |                                      |";	nLin++
		@ nLin, 00 PSay "+---------------------------------------+--------------------------------------+"

		nLin += 1

		Roda()
		If nReg = Nil; nLin := 80; EndIf

		dbSelectArea("NP1")	
		dbSkip()
	EndDo

	Set Filter To
	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return

