/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AGRR280  บ Autor ณ Ricardo Tomasi     บ Data ณ  09/12/2005 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao do Romaneio de Entreda.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Clientes Microsiga                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function AGRR280()
	Local cDesc1         := 'Este programa tem como objetivo imprimir relatorio '
	Local cDesc2         := 'de acordo com os parametros informados pelo usuario.'
	Local cDesc3         := 'Romaneio de Entrada'
	Local titulo         := 'Romaneio de Entrada'
	Local nLin           := 80
	Local Cabec1         := ''
	Local Cabec2         := ''
	Local aOrd           := {}

	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private CbTxt        := ''
	Private limite       := 80
	Private tamanho      := 'P'
	Private nomeprog     := 'AGRR280'
	Private nTipo        := 18
	Private aReturn      := { 'Zebrado', 1, 'Administracao', 2, 2, 1, '', 1}
	Private nLastKey     := 0
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private cPerg        := 'AGR280'
	Private wnrel        := 'AGRR280'
	Private lUnico       := .f.
	Private cCodAtu      := ''

	dbSelectArea('NPO')
	dbSetOrder(1)
	
	Pergunte(cPerg,.f.)

	If 'AGRA280' $ FunName()
		lUnico  := .t.
		cPerg   := ''
		cCodAtu := NPO->NPO_CODIGO
	EndIf

	wnrel := SetPrint('NPO',NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

	If nLastKey == 27
		Return()
	Endif

	SetDefault(aReturn,'NPO')

	If nLastKey == 27
		Return()
	Endif

	nTipo := 18 //If(aReturn[4]==1,15,18)

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  09/12/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	Local aLayOut    := Array(0)
	Local lEjetar    := .f.

	If lUnico
		cFiltro := "NPO_FILIAL=='"+xFilial('NPO')+"' .And. NPO_CODIGO >= '"+NPO->NPO_CODIGO+"' .And. NPO_CODIGO <= '"+NPO->NPO_CODIGO+"'"
	Else
		cFiltro := "NPO_FILIAL=='"+xFilial('NPO')+"' .And. NPO_CODIGO >= '"+MV_PAR01+"' .And. NPO_CODIGO <= '"+MV_PAR02+"'"
	EndIf

	IndRegua('NPO',CriaTrab(NIL,.F.),'NPO_FILIAL+NPO_CODIGO',,cFiltro,"Selecionando Registros ...")
	SetRegua(LastRec())
	dbGotop()
	While .Not. Eof()

		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf

		Cabec1 := PadR("Armazem: " +Posicione('NNR',1,xFilial('NNR')+NPO->NPO_ARM,'NNR_DESCRI'),40)
		Cabec1 += PadR("Produto.: "+Posicione('SB1',1,xFilial('SB1')+NPO->NPO_CODPRO,'B1_DESC'),40)

		dbSelectArea('SA1')
		dbSetOrder(1)
		dbSeek(xFilial('SA1')+NPO->NPO_CODCLI+NPO->NPO_LOJCLI)

		Cabec2 := PadR("Cliente: "+SA1->A1_NOME,40)
		Cabec2 += PadR("Endere็o: "+SA1->A1_END,40)

		If nLin > 28
			m_pag  := 1
			Cabec(AllTrim(Titulo)+': '+NPO->NPO_CODIGO,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin   := 8
		EndIf

		aAdd(aLayOut, {"Safra..: ", 'L015C050', Posicione('NN1',1,xFilial('NN1')+NPO->NPO_SAFRA,'NN1_DESCRI'), '@!', 'R', 30, .t., .t.})
		aAdd(aLayOut, {"Ticket.: ", 'L010C050', NPO->NPO_TICKET, '@!', 'R', 29, .t., .t.})
		aAdd(aLayOut, {"Laudo..: ", 'L011C050', NPO->NPO_LAUDO , '@!', 'R', 29, .t., .t.})
		aAdd(aLayOut, {"Peso Bruto...........: ", 'L015C000', NPO->NPO_PSBRUT, '@E 999,999,999.99', 'R', 40, .t., .t.})
		aAdd(aLayOut, {"Peso Tara............: ", 'L016C000', NPO->NPO_PSTARA, '@E 999,999,999.99', 'R', 40, .t., .t.})
		aAdd(aLayOut, {"Peso SubTotal........: ", 'L017C000', NPO->NPO_PSSUBT, '@E 999,999,999.99', 'R', 40, .t., .t.})
		aAdd(aLayOut, {"Peso Liquido.........: ", 'L026C000', NPO->NPO_PSREAL, '@E 999,999,999.99', 'R', 40, .t., .t.})
		aAdd(aLayOut, {"Obs.: "                 , 'L028C000', NPO->NPO_OBS   , '@!'               , 'R', 80, .t., .t.})
		aAdd(aLayOut, {"Usuario: "              , 'L026C050', Substr(cUserName,1,15), '@X'        , 'C', 29, .t., .t.})

		dbSelectArea('NPA')
		dbSetOrder(1)
		If dbSeek(xFilial('NPA')+NPO->NPO_CODAPO)

			aAdd(aLayOut, {"Fazenda: ", 'L016C050', Posicione('NN2',2,xFilial('NN2')+NPA->NPA_FAZ  ,'NN2_NOME'  ), '@!', 'C', 30, .t., .t.})
			aAdd(aLayOut, {"Ser. NF: ", 'L012C050', NPA->NPA_NFSSER, '@!', 'R', 29, .t., .t.})
			aAdd(aLayOut, {"Num. NF: ", 'L013C050', NPA->NPA_NFSNUM, '@!', 'R', 29, .t., .t.})
			aAdd(aLayOut, {"Apont..: ", 'L014C050', NPA->NPA_CODIGO, '@!', 'R', 29, .t., .t.})

			dbSelectArea('NN3')
			dbSetOrder(1)
			dbSeek(xFilial('NN3')+NPO->NPO_SAFRA+NPO->NPO_FAZ+NPO->NPO_TALHAO)
			aAdd(aLayOut, {"Talhao.: ", 'L017C050', NN3->NN3_TALHAO+'-'+NN3->NN3_DESCRI, '@!', 'L', 30, .t., .t.})

			dbSelectArea('NPB')
			dbSetOrder(1)
			dbSeek(xFilial('NPB')+NPA->NPA_CODIGO)
			nL := 18
			While .Not. Eof() .And. NPA->NPA_CODIGO == NPB->NPB_CODIGO

				aAdd(aLayOut, { PadR('Var..: '+NPB->NPB_DESVAR,21), 'L'+StrZero(nL,3)+'C052', Transform(NPB->NPB_PERVAR,'@E 999.99')+'%', '@!', 'L', 28, .t., .t.})

				nL++
				If nL = 25; Exit; EndIf
				dbSkip()
			EndDo

		EndIf

		dbSelectArea('SA4')
		dbSetOrder(1)
		If dbSeek(xFilial('SA4')+NPO->NPO_CODTRA)
			aAdd(aLayOut, {"Transp.: " , 'L010C000', SA4->A4_NOME  , '@!', 'R', 39, .t., .t.})
		EndIf

		dbSelectArea('NNA')
		dbSetOrder(1)
		If dbSeek(xFilial('NNA')+NPO->NPO_CODMOT)
			aAdd(aLayOut, {"Motor..: "  , 'L011C000', NNA->NNA_NOME , '@!', 'R', 39, .t., .t.})
		EndIf

		dbSelectArea('NNB')
		dbSetOrder(1)
		If dbSeek(xFilial('NNB')+NPO->NPO_CODEQU)
			aAdd(aLayOut, {"Placa..: " , 'L012C000', NNB->NNB_PLACA, '@!', 'R', 39, .t., .t.})
		EndIf

		dbSelectArea('NPP')
		dbSetOrder(1)
		dbSeek(xFilial('NPP')+NPO->NPO_CODIGO)
		nL := 18
		While .Not. Eof() .And. NPO->NPO_FILIAL==xFilial('NPO') .And. NPP->NPP_FILIAL==xFilial('NPP') .And. NPO->NPO_CODIGO == NPP->NPP_CODIGO

			aAdd(aLayOut, { PadR(AllTrim(NPP->NPP_DESDES),19,'.')+': ' , 'L'+StrZero(nL,3)+'C002', NPP->NPP_PESDES, '@E 999,999,999.99', 'R', 36, .t., .t.})
			aAdd(aLayOut, { ''                                         , 'L'+StrZero(nL,3)+'C038', NPP->NPP_PERDES, '@E 999.99'        , 'R', 06, .t., .t.})
			aAdd(aLayOut, { ''                                         , 'L'+StrZero(nL,3)+'C044', '%'            , '@!'               , 'C', 01, .t., .t.})

			nL++
			If nL = 25; Exit; EndIf
			dbSkip()
		EndDo

		If fImprime(aLayOut)
			aLayOut := Array(0)
			If lEjetar
				nLin := 80
				lEjetar := .f.
			Else
				nLin    := 33
				@ nLin,0 PSay ''
				SetPRC(0,0)
				lEjetar := .t.
			EndIf
		EndIf

		dbSelectArea('NPO')
		dbSkip()
		IncRegua()
	EndDo

	If lUnico
		dbSelectArea('NPO')
		dbSetOrder(1)
		dbSeek(xFilial('NPO')+cCodAtu)
	EndIf

	SET FILTER TO
	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR001R  บAutor  ณMicrosiga           บ Data ณ  12/08/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImprime(aLayOut)
	Local nX     := 0
	Local nLin   := 0
	Local nCol   := 0
	Local cCabec := ''
	Local cCampo := ''
	Local aNota  := aSort(aLayOut,,,{|x, y| x[2] < y[2] })

	For nX := 1 To Len(aNota)

		If aNota[nX,7] //Imprime Cabecalho
			cCabec := aNota[nX,1]
		EndIf

		cCampo := Transform(aNota[nX,3],aNota[nX,4])

		Do Case
			Case aNota[nX,5] == 'R'
			cCampo := PadR(cCabec+cCampo, aNota[nX,6])
			Case aNota[nX,5] == 'C'
			cCampo := PadC(cCabec+cCampo, aNota[nX,6])
			Case aNota[nX,5] == 'L'
			cCampo := PadL(cCabec+cCampo, aNota[nX,6])
			OtherWise
			cCampo := PadR(cCabec+cCampo, aNota[nX,6])
		EndCase

		nLin := Val(Substr(aNota[nX,2],2,3))
		nCol := Val(Substr(aNota[nX,2],6,3))

		@ nLin, nCol PSay cCampo

		cCabec := ''
		cCampo := ''

	Next nX

Return(.T.)

