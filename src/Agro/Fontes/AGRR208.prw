/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AGRR208   º Autor ³ Ricardo Tomasi     º Data ³  24/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio para impressão das quantidades realizadas das    º±±
±±º          ³ aplicações.                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Cliente Microsiga                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AGRR208()

	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Cronograma realizado das aplicações."
	Local titulo         := "Cronograma Realizado"
	Local nLin           := 80
	//                                                                                                   1         1         1         1
	//         1         2         3         4         5         6         7         8         9         0         1         2         3
	//123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	//Data Prevista    Fazenda               Talhao   Serviço
	//  ##/##/##       ####################    ##     ########################################
	//----------------------------------------------------------------------------------------
	//Tipo           Grupo                Produto                              UM      Qtd. Apl.     Total HAs    Qtd. Total      Media/HA
	//Mão-de-Obra -> #################### ###################################  ##     ###.###,##    ###.###,##    ###.###,##    ###.###,##
	//Equipamento -> #################### ###################################  ##     ###.###,##    ###.###,##    ###.###,##    ###.###,##
	//Produto     -> #################### ###################################  ##     ###.###,##    ###.###,##    ###.###,##    ###.###,##


	Local Cabec1         := "Safra: "
	Local Cabec2         := "Tipo           Grupo                Produto                              UM                    Total HAs    Qtd. Total      Media/HA"
	Local aOrd           := {"Data Realizada+Desc. Produto"}

	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private limite       := 132
	Private tamanho      := "M"
	Private nomeprog     := "AGRR208"
	Private nTipo        := 18
	Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey     := 0
	Private cbtxt        := Space(10)
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private cPerg        := "AGR208"
	Private wnrel        := "AGRR208"
	Private cString      := "NP5"

	dbSelectArea("NP5")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

	If nLastKey == 27
		Return()
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return()
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return()

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
	Local dData    := dDataBase

	Local cCodFaz  := ''
	Local cCodTal  := ''
	Local cCodSrv  := ''

	Local cFilNP5  := ''
	Local cIndNP5  := ''
	Local cChaNP5  := ''
	Local nIndNP5  := 0
	local lprtCab  := .f.

	Cabec1 += AllTrim(Cabec1)+' '+MV_PAR01

	dbSelectArea('NP5')
	dbSetOrder(1)
	cFilNP5 += "NP5_SAFRA == '"      + MV_PAR01 +       "' .And. "
	cFilNP5 += "NP5_FAZ >= '"        + MV_PAR02 +       "' .And. NP5_FAZ <= '"        + MV_PAR03 +       "' .And. "
	cFilNP5 += "NP5_TALHAO >= '"     + MV_PAR04 +       "' .And. NP5_TALHAO <= '"     + MV_PAR05 +       "' .And. "
	cFilNP5 += "NP5_CODSRV >= '"     + MV_PAR06 +       "' .And. NP5_CODSRV <= '"     + MV_PAR07 +       "' .And. "
	cFilNP5 += "DToS(NP5_DATA) >= '" + DToS(MV_PAR08) + "' .And. DToS(NP5_DATA) <= '" + DToS(MV_PAR09) + "'"
	cFilNP5 += IIf(Empty(aReturn[7]),""," .And. "+aReturn[7])
	cIndNP5 := CriaTrab(Nil,.f.)
	cChaNP5 := 'NP5_FILIAL+DToS(NP5_DATA)+NP5_FAZ+NP5_TALHAO+NP5_CODSRV'
	IndRegua("NP5",cIndNP5,cChaNP5,,cFilNP5,"Selecionando Registros...")
	nIndNP5 := RetIndex("NP5")
	dbSelectArea("NP5")
	#IFNDEF TOP
	DbSetIndex(cIndNP5+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndNP5+1)
	dbGotop()

	While .Not. Eof()

		dData   := NP5_DATA
		While .Not. Eof() .And. NP5_DATA == dData

			If nLin > 55
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			EndIf

			lprtCab := .f.
			cCodFaz := NP5_FAZ
			cCodTal := NP5_TALHAO
			cCodSrv := NP5_CODSRV   	

			While .Not. Eof() .And. NP5_DATA == dData .And. NP5_FAZ == cCodFaz .And. NP5_TALHAO == cCodTal .And. NP5_CODSRV == cCodSrv

				if (.not. lprtCab) .and. (empty(MV_PAR10) .and. empty(MV_PAR12))
					dbSelectArea('NP5') 
					@ nLin, 000 PSay 'Data: '   + DToC(NP5_DATA)
					@ nLin, 018 PSay 'Fazenda: '+ Left(NP5_FAZ+'-'+NP5_FAZNOM,21)
					@ nLin, 050 PSay 'Talhão: ' + NP5_TALHAO
					@ nLin, 062 PSay 'Serviço: '+ Left(NP5_CODSRV+'-'+NP5_DESSRV,30)
					nLin++   
					lprtCab := .t.
					dbSelectArea('NP6') 
				endif

				if empty(MV_PAR10) .and. empty(MV_PAR12)  /*Lista somente se o produto inicial não for informado.*/
					dbSelectArea('NP6')
					dbSetOrder(2)
					dbSeek(xFilial('NP6')+NP5->NP5_CODIGO+'MO')
					While .Not. Eof() .And. NP5->NP5_CODIGO == NP6_CODIGO .And. NP6->NP6_TIPO == 'MO'

						If nLin > 55
							If nLin < 80
								Roda()
							EndIf
							Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
							nLin := 9
						EndIf

						@ nLin, 000 PSay 'MO->'
						@ nLin, 036 PSay NP6->NP6_MONOM
						@ nLin, 074 PSay NP6->NP6_UM
						//@ nLin, 081 PSay Transform(NP6->NP6_QTDAPL,'@E 999,999.99')
						@ nLin, 095 PSay Transform(NP5->NP5_AREA  ,'@E 999,999.99')
						@ nLin, 109 PSay Transform(NP6->NP6_QTDTOT,'@E 999,999.99')
						@ nLin, 123 PSay Transform(NP6->NP6_QTDUNI,'@E 999,999.99')
						nLin++
						dbSelectArea('NP6')
						dbSkip()
					EndDo

					dbSelectArea('NP6')
					dbSetOrder(3)
					dbSeek(xFilial('NP6')+NP5->NP5_CODIGO+'EQ')
					While .Not. Eof() .And. NP5->NP5_CODIGO == NP6_CODIGO .And. NP6->NP6_TIPO == 'EQ'
						@ nLin, 000 PSay 'EQ->'
						@ nLin, 036 PSay NP6->NP6_EQNOM
						@ nLin, 074 PSay NP6->NP6_UM
						//@ nLin, 081 PSay Transform(NP6->NP6_QTDAPL,'@E 999,999.99')
						@ nLin, 095 PSay Transform(NP5->NP5_AREA  ,'@E 999,999.99')
						@ nLin, 109 PSay Transform(NP6->NP6_QTDTOT,'@E 999,999.99')
						@ nLin, 123 PSay Transform(NP6->NP6_QTDUNI,'@E 999,999.99')
						nLin++
						dbSelectArea('NP6')
						dbSkip()
					EndDo
				endif     		 


				dbSelectArea('NP6')
				dbSetOrder(4)
				dbSeek(xFilial('NP6')+NP5->NP5_CODIGO+'PD')
				While .Not. Eof() .And. NP5->NP5_CODIGO == NP6_CODIGO .And. NP6->NP6_TIPO == 'PD'
					dbSelectArea('SB1')
					dbSetOrder(1)
					dbSeek(xFilial('SB1')+NP6->NP6_PDCOD)
					If B1_COD < MV_PAR12 .Or. B1_COD > MV_PAR13
						dbSelectArea('NP6')
						dbSkip()
						Loop
					EndIf
					dbSelectArea('SBM')
					dbSetOrder(1)
					dbSeek(xFilial('SBM')+SB1->B1_GRUPO)
					If BM_GRUPO < MV_PAR10 .Or. BM_GRUPO > MV_PAR11
						dbSelectArea('NP6')
						dbSkip()
						Loop
					EndIf

					if (.not. lprtCab)
						dbSelectArea('NP5')                 
						@ nLin, 000 PSay 'Data: '   + DToC(NP5_DATA)
						@ nLin, 018 PSay 'Fazenda: '+ Left(NP5_FAZ+'-'+NP5_FAZNOM,21)
						@ nLin, 050 PSay 'Talhão: ' + NP5_TALHAO
						@ nLin, 062 PSay 'Serviço: '+ Left(NP5_CODSRV+'-'+NP5_DESSRV,30)
						dbSelectArea('NP6')  
						nLin++   
						lprtCab := .t.
					endif


					@ nLin, 000 PSay 'PD->'
					@ nLin, 015 PSay Left(SBM->BM_DESC,15)
					@ nLin, 036 PSay NP6->NP6_PDNOM
					@ nLin, 074 PSay NP6->NP6_UM
					//@ nLin, 081 PSay Transform(NP6->NP6_QTDAPL,'@E 999,999.99')
					@ nLin, 095 PSay Transform(NP5->NP5_AREA  ,'@E 999,999.99')
					@ nLin, 109 PSay Transform(NP6->NP6_QTDTOT,'@E 999,999.99')
					@ nLin, 123 PSay Transform(NP6->NP6_QTDUNI,'@E 999,999.99')
					nLin++
					dbSelectArea('NP6')
					dbSkip()
				EndDo

				dbSelectArea('NP5')
				dbSkip()
			EndDo

			if lprtCab 
				nLin += 1
				@ nLin, 001 PSay '------------------------------------------------------------------------------'
				nLin += 2
			endif

		EndDo

	EndDo

	Roda()

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return()

