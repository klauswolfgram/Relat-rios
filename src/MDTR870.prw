/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MDTR870.ch"
#Include "Protheus.ch"
#Include "MSOLE.CH"
#Include "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR870

Relatorio do PCMSO - Programa de Controle Medico e Saude Ocupacional
que ira emitir os dados da empresa, as funcoes por risco, os exames
necessarios para aqueles riscos e o total da jornada de trabalho dos
funcionarios envolvidos.

@return Nil, Nulo

@sample U_MDTR870()

@author	Thiago Olis Machado
@since	28/08/2001
/*/
//---------------------------------------------------------------------
User Function MDTR870()

	//Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local oRadOp,oDLGpcmso

	lSigaMdtPS := SuperGetMv("MV_MDTPS",.F.,"N") == "S"
	Private lMV_NGMDTPS := .F.
	Private aFilRelat   := {}
	Private nSizeFil    := FwSizeFilial()
	Private lTMW_Filial := If( Empty(xFilial("TMW")) .And. !Empty(xFilial("SRA")) , .T. , .F. ) //Indica se o PCMSO é para varias filiais
	Private cFiltroF := Alltrim(SuperGetMv("MV_NGCATFU",.F.," "))

	If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
		lMV_NGMDTPS := .T.
	EndIf
	cCliMdtps := ""

	Private nModeloImp := 1
	Private Mv_parEx
	Private cCidade   := Alltrim(SM0->M0_CIDCOB)+If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")
	Private cEmp_Nome := SM0->M0_NOMECOM
	Private cEmp_Fili := SM0->M0_FILIAL
	Private cEmp_Endr := SM0->M0_ENDCOB
	Private cEmp_Insc := SM0->M0_INSC
	Private cEmp_Cnae := SM0->M0_CNAE
	Private lMdtUmCC  := lMDT190UMCC()
	Private cCCPCMSO  := Space(9)
	Private cDpPCMSO  := Space(9)
	Private li := 80 ,m_pag := 1
	Private dDeLaudo := CTOD("  /  /  "),	dAteLaudo := CTOD("  /  /  ")
	Private cCodEmpresa := FWGrpCompany()
	Private aTipoInsc := fTipoINSC()//"C.G.C."
	Private cEmp_Cnpj := aTipoInsc[2]
	Private lMdtUnix := If( GetRemoteType() == 2 .Or. isSRVunix() , .T. , .F. ) //Verifica se servidor ou estacao é Linux
	Private lTN0Depto := NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )

	Private cPathWord := GETMV("MV_NGSERVE"),cRootPath
	If Substr(cPathWord,len(cPathWord),1) != "\"
		cPathWord += "\"
	EndIf

	SG90PLACAO() //Adequação do Plano de Ação.

	If !MDT210UPD() //Verifica Aplicacao de Update
		NGRETURNPRM(aNGBEGINPRM)
		Return .F.
	EndIf

	If !MDTRESTRI(cPrograma)
		//Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
		Return .F.
	EndIf

	lRet  := .F.

	DEFINE MSDIALOG oDLGpcmso FROM  0,0 TO 150,320 TITLE STR0015 PIXEL //"Selecione o Modelo do Relatorio"

	@ 10,10 TO 55,150 LABEL STR0016 of oDLGpcmso Pixel //"Modelo do Relatório"
	@ 20,14 RADIO oRadOp VAR nModeloImp ITEMS "Word",STR0066,STR0067 SIZE 70,15 PIXEL OF oDLGpcmso //"Padrão" //"Gráfico"

	DEFINE SBUTTON FROM 59,90  TYPE 1 ENABLE OF oDLGpcmso ACTION EVAL({|| lRET := .T.,oDLGpcmso:END()})
	DEFINE SBUTTON FROM 59,120 TYPE 2 ENABLE OF oDLGpcmso ACTION oDLGpcmso:END()

	ACTIVATE MSDIALOG oDLGpcmso CENTERED

	If lRet
		If nModeloImp == 1
			U_MDTR870WOR()
		Else
			U_MDT870PDR()
		EndIf
	EndIf

	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT870PDR
Chamada do Relatório

@return Nil, Nulo

@sample U_MDT870PDR()

@author	Denis
@since	29/08/2001
/*/
//---------------------------------------------------------------------
User Function MDT870PDR()

	Local wnrel   := "MDTR870"
	Local limite  := 132
	Local cDesc1  := STR0001 //"Relatorio do PCMSO - Programa de Controle Medico e Saude Ocupacional           "
	Local cDesc2  := ""
	Local cDesc3  := ""
	Local cString := "TM5"

	Private nomeprog := "MDTR870"
	Private tamanho  := "M"
	Private aReturn  := {STR0002, 1,STR0003, 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
	Private titulo   := STR0166 //"PCMSO"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := If(!lSigaMdtps,"MDT870    ","MDT870PS  ")
	Private cabec1, cabec2

	nSizeSA1  := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	nSizeLo1  := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))

	/*-----------------------
	//PADRÃO					|
	| Laudo ?					|
	| De  PCMSO ?				|
	| Ate PCMSO ?				|
	| Medico Coordenador ?   	|
	| Listar Exames ?			|
	| Data Utilizada?			|
	| 							|
	//PRESTADOR				    |
	| Cliente ?				    |
	| Loja						|
	| Laudo ?					|
	| De  PCMSO ?				|
	| Ate PCMSO ?				|
	| Medico Coordenador ?	    |
	| Listar Exames ?			|
	| Data Utilizada?			|
	--------------------------*/

	pergunte(cPerg,.F.)

	//Envia controle para a funcao SETPRINT
	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey == 27
	Set Filter to
	Return
	EndIf

	aFilRelat := {}
	If lTMW_Filial .And. !Empty(xFilial("TM5")) .And. !lSigaMdtps
		aAreaSM0 := SM0->(GetArea())
		dbSelectArea("SM0")
		dbGoTop()
		If Empty(Mv_par06)
			dbSeek(cEmpAnt)
		Else
			dbSeek(cEmpAnt+Mv_par06)
		EndIf
		While !Eof() .And. AllTrim(SM0->M0_CODIGO) == cEmpAnt .And. AllTrim(SM0->M0_CODFIL) <= Mv_par07
			cCodFil := FWCodFil()
			aAdd( aFilRelat , { cCodFil , SM0->M0_NOME , Mv_par06 , Mv_par07 } )
			dbSkip()
		End
		RestArea(aAreaSM0)
	Else
		aAdd( aFilRelat , { cFilAnt , SM0->M0_NOME , Mv_par06 , Mv_par07 } )
	EndIf

	If nModeloImp == 2
		RptStatus({|lEnd| R870Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
	Else
		RptStatus({|lEnd| R870Grf(@lEnd,wnRel,titulo,tamanho)},titulo)
	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} R870Imp
Chamada do Relatório Padrão

@return Nil, Nulo

@sample R870Imp()

@author	Thiago Olis Machado
@since	29/08/2001
/*/
//---------------------------------------------------------------------
Static Function R870Imp(lEnd,wnRel,titulo,tamanho)

	Local cMemo := " ",cTitulo := " ",cTexto := " ",nX,nXP
	Local lEof := .T.
	Local nLenMemo := 0
	Local nPerMemo := 0

	If lSigaMdtps
		Mv_parEx := Mv_par07
	Else
		Mv_parEx := Mv_par05
	EndIf

	If lSigaMdtps
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par03)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	Else
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par01)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	EndIf

	Private li := 80
	Private cAlias := "SI3"
	Private cDescr := "SI3->I3_DESC"
	Private lPrint := .T.
	Private lPrin2 := .T.
	Private lFirst := .T.
	Private lJumpCab := .T.
	Private lIdentar := .F.
	Private dIniPrg := Stod(Space(8))
	Private dFimPrg := Stod(Space(8))

	//Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	cabec1 := " "
	cabec1 := " "

	/*
			1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		FUNCOES          N.    HO    MU    ME         RISCOS                  EPI                  EXAMES
	XXXXXXXXXXXXXXXXXXXXX  XXXX  XXXX  XXXX  XXXX  XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXX   XXXXXXXXXXXXXXXXXXXX
	*/
	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
	EndIf

	aPCMSO := {}
	If lSigaMdtps
		Dbselectarea("TMW")
		Dbsetorder(6)
		Dbseek(xFilial("TMW")+Mv_par01+Mv_par02,.T.)
		While !eof() .And. xFilial("TMW") == TMW->TMW_FILIAL .And. Substr(TMW->TMW_CCDE,1,nSizeSA1+nSizeLo1) == Mv_par01+Mv_par02
			If TMW->TMW_PCMSO >= Mv_par04 .And. TMW->TMW_PCMSO <= Mv_par05
				aADD(aPCMSO,TMW->TMW_PCMSO)
			EndIf
			Dbselectarea("TMW")
			Dbskip()
		End

		Dbselectarea("TMW")
		Dbsetorder(1)
		Dbseek ( xFilial("TMW") + Mv_par04, .T.)
		dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		If Empty(TMW->TMW_CCATE)
			cCCPCMSO:= TMW->TMW_CCDE    //CC DO PCMSO
		EndIf

		If mv_par05==Replicate('Z',6)
			Dbgobottom()
		Else
			Dbseek ( xFilial("TMW") + mv_par05)
		EndIf

		If TMW->TMW_DTINIC < dIniPrg
			dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		EndIf
		If TMW->TMW_DTFIM > dFimPrg
			dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		EndIf

		dbSelectArea("TO0")
		dbSetOrder(06)  //TO0_FILIAL+TO0_CLIENT+TO0_LOJA+TO0_LAUDO
		dbSeek(xFilial("TO0")+MV_PAR01+MV_PAR02+MV_PAR03)

	Else

		Dbselectarea("TMW")
		Dbsetorder(1)
		Dbseek ( xFilial("TMW") + Mv_par02, .T.)
		dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		If !Empty(TMW->TMW_CCATE)
			cCCPCMSO:= TMW->TMW_CCDE    //CC DO PCMSO
		EndIf

		If mv_par03==Replicate('Z',6)
			Dbgobottom()
		Else
			Dbseek ( xFilial("TMW") + mv_par03)
		EndIf

		If TMW->TMW_DTINIC < dIniPrg
			dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		EndIf
		If TMW->TMW_DTFIM > dFimPrg
			dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		EndIf

		dbSelectArea("TO0")
		dbSetOrder(01)
		dbSeek(xFilial("TO0")+MV_PAR01)

	EndIf

	If lSigaMdtps
		Dbselectarea("SA1")
		Dbsetorder(1)
		If Dbseek(xFilial("SA1")+mv_par01+mv_par02)
			cCidade   := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
			cEmp_Nome := SA1->A1_NOME
			cEmp_Cnpj := SA1->A1_CGC
			cEmp_Endr := SA1->A1_END
			cEmp_Insc := SA1->A1_INSCR
			cEmp_Cnae := SA1->A1_ATIVIDA
		EndIf
	ElseIf lMV_NGMDTPS
		Dbselectarea("SA1")
		Dbsetorder(1)
		If Dbseek(xFilial("SA1")+TO0->TO0_CLIENT)
			cCidade   := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
			cEmp_Nome := SA1->A1_NOME
			cEmp_Cnpj := SA1->A1_CGC
			cEmp_Endr := SA1->A1_END
			cEmp_Insc := SA1->A1_INSCR
			cEmp_Cnae := SA1->A1_ATIVIDA
		EndIf
	Else
		cCidade   := Alltrim(SM0->M0_CIDCOB)+If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")
		cEmp_Nome := SM0->M0_NOMECOM
		cEmp_Cnpj := aTipoInsc[2]
		cEmp_Endr := SM0->M0_ENDCOB
		cEmp_Insc := SM0->M0_INSC
		cEmp_Cnae := SM0->M0_CNAE
	EndIf


	SomaLinha()
	SomaLinha()
	SomaLinha()
	SomaLinha()
	dIniMY := StrZero(Month(dIniPrg),2)+"/"+Str(Year(dIniPrg),4)
	dTerMY := StrZero(Month(dFimPrg),2)+"/"+Str(Year(dFimPrg),4)
	@ LI,000 PSay "                                     "+STR0017 //"PROGRAMA DE CONTROLE MÉDICO DE SAUDE OCUPACIONAL - PCMSO"
	Somalinha()
	@ LI,000 PSay "                                                 "+STR0018+dIniMY+STR0019+dTerMY //"PERÍODO DE "###" ATÉ "
	Somalinha()
	Somalinha()
	Somalinha()
	/*
							1         2         3         4         5         6         7         8         9         0         1         2         3
					0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	*/

	@ Li,000 Psay STR0004 //"NOME DA EMPRESA :"
	@ Li,022 Psay cEmp_Nome
	SomaLinha()
	@ Li,000 Psay STR0005 //"ENDERECO :"
	@ Li,022 Psay cEmp_Endr
	SomaLinha()
	@ Li,000 Psay STR0007
	@ Li,022 Psay cCidade
	SomaLinha()
	@ Li,000 Psay aTipoInsc[1]//"CNPJ/CGC :"
	@ Li,022 Psay cEmp_Cnpj
	SomaLinha()
	@ Li,000 Psay STR0020 //"INSCRIÇÃO ESTADUAL : "
	@ Li,022 Psay cEmp_Insc
	SomaLinha()
	@ Li,000 Psay STR0013 //"GRAU DE RISCO :"
	@ Li,022 Psay TO0->TO0_GRISCO
	SomaLinha()
	@ Li,000 Psay STR0021 //"CNAE : "
	@ Li,022 Psay cEmp_Cnae
	Dbselectarea(cAlias)
	Dbsetorder(1)
	If Dbseek(xFilial(cAlias)+cCCPCMSO) .And. !Empty(cCCPCMSO) .And. lMdtUmCC
		SomaLinha()
		@ Li,000 Psay STR0032 //"Centro de Custo:"
		@ Li,022 Psay &(cDescr)
	EndIf

	Somalinha()
	SomaLinha()
	SomaLinha()

	cMemo := Alltrim(TO0->TO0_DESCRI)
	If !Empty(TO0->TO0_MMSYP2)
		cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
		If !Empty(cMMSYP2)
			If !Empty(cMemo)
				cMemo += CRLF
			EndIf
			cMemo += cMMSYP2
		EndIf
		EndIf

	SetRegua(100)
	nLenMemo := Len(cMemo)
	nPerMemo := 0

	While lEof
		If Empty(cMemo)  //Memo vazio
			lEof := .F.
			Exit
		Else
			nPos1 := At("#",cMemo) //Inicio de um Titulo

			If nPos1 > 1
				cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
				cMemo  := Alltrim(Substr(cMemo,nPos1))
				U_IMPTXT870(Alltrim(cTexto))
				fReguaPCMSO( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
				Loop
			ElseIf nPos1 == 1 //Existe #
				cMemo   := Alltrim(Substr(cMemo,nPos1+1))
				nPos1   := At("#",cMemo)
				cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
				cMemo   := Alltrim(Substr(cMemo,nPos1+1))

				nPos1   := At("#",cMemo)
				If nPos1 > 0
					cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
					cMemo  := Alltrim(Substr(cMemo,nPos1))
				Else
					cTexto := Alltrim(cMemo)
					cMemo  := " "
					lEof   := .F.
				EndIf
			Else //Nao existe #
				//IMPRIME TEXTO
				U_IMPTXT870(Alltrim(cMemo))
				lEof := .F.
				Exit
			EndIf


			//IMPRIME TITULO
			If !Empty(cTitulo)
				U_IMPCAB870(cTitulo)
			EndIf

			//IMPRIME TEXTO
			If !Empty(cTexto)
				lPrint := .T.
				lPrin2 := .T.
				U_IMPTXT870(Alltrim(cTexto))
			EndIf

		EndIf

		fReguaPCMSO( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua

	End

	cTxtMemo := " "
	DbSelectArea("TMZ")
	DbSetOrder(1)
	IF DbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
		cTxtMemo := TMZ->TMZ_DESCRI
	EndIf

	Dbselectarea("TMK")
	Dbsetorder(1)
	If lSigaMdtps
		Dbseek(xFilial("TMK")+Mv_par06)
	Else
		Dbseek(xFilial("TMK")+Mv_par04)
	EndIf

	li := 80
	Somalinha()

	@li,048 Psay STR0022 //"RESPONSÁVEIS TÉCNICOS"
	For nX := 1 to 3
		Somalinha()
	Next nX

	U_IMPTXT870(Alltrim(cTxtMemo))
	Somalinha()
	Somalinha()

	Somalinha()
	@li,000 Psay STR0023 //"MÉDICO COORDENADOR:"
	@li,030 Psay Alltrim(SubStr(TMK->TMK_NOMUSU,1,40))

	Somalinha()
	@li,000 Psay STR0024 //"REG.SSST:"
	@li,030 Psay Alltrim(TMK->TMK_REGMTB)

	Somalinha()
	@li,000 Psay If(Empty(TMK->TMK_ENTCLA),STR0167,Alltrim(TMK->TMK_ENTCLA))+":" // "CRM"
	@li,030 Psay Alltrim(TMK->TMK_NUMENT)

	Somalinha()
	@li,000 Psay STR0025 //"FONE:"
	@li,030 Psay Alltrim(TMK->TMK_TELUSU)

	Somalinha()
	@li,000 Psay STR0026 //"ENDEREÇO:"
	@li,030 Psay Alltrim(TMK->TMK_ENDUSU)

	For nX := 1 to 3
		Somalinha()
	Next nX

	Somalinha()
	@li,000 Psay STR0027+" "+Alltrim(Transform(Date(),"99/99/9999")) //"DATA:"
	For nX := 1 to 5
		Somalinha()
	Next nX

	Somalinha()
	@li,000 Psay STR0077+" ___________________________________________" //"Ass:"

	RetIndex("TO0")
	Set Filter To
	Set device to Screen
	If aReturn[5] = 1
			Set Printer To
			dbCommitAll()
			OurSpool(wnrel)
	EndIf
	MS_FLUSH()

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} R870Grf
Chamada do Relatório Gráfico

@return Nil, Nulo

@sample R870Grf()

@author	Thiago Olis Machado
@since	04/08/2001
/*/
//---------------------------------------------------------------------
Static Function R870Grf(lEnd,wnRel,titulo,tamanho)

	Local cMemo := " ", cTitulo := " ", cTexto := " "
	Local lEof := .T.
	Local nLenMemo := 0
	Local nPerMemo := 0
	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()

	If lSigaMdtps
		Mv_parEx := Mv_par07
	Else
		Mv_parEx := Mv_par05
	EndIf
	Private li := 80
	Private cAlias := "SI3"
	Private cDescr := "SI3->I3_DESC"
	Private lPrint := .T.
	Private lPrin2 := .T.
	Private lFirst := .T.
	Private lJumpCab := .T.
	Private lIdentar := .F.
	Private dIniPrg := Stod(Space(8))
	Private dFimPrg := Stod(Space(8))
	Private nPaginaG   := 0

	Private oFont08	 := TFont():New("Verdana",07,07,,.F.,,,,.F.,.F.)
	Private oFont08b := TFont():New("Verdana",07,07,,.T.,,,,.F.,.F.)
	Private oFont10b := TFont():New("Verdana",09,09,,.T.,,,,.F.,.F.)
	Private oFont10	 := TFont():New("Verdana",09,09,,.F.,,,,.F.,.F.)
	Private oFont12b := TFont():New("Verdana",11,11,,.T.,,,,.F.,.F.)
	Private oFont12  := TFont():New("Verdana",11,11,,.F.,,,,.F.,.F.)
	Private oFont12bs:= TFont():New("Verdana",11,11,,.T.,,,,.T.,.T.)
	Private oFont12s := TFont():New("Verdana",11,11,,.F.,,,,.T.,.T.)
	Private oFont13	 := TFont():New("Verdana",11,11,,.F.,,,,.F.,.F.)
	Private oFont13b := TFont():New("Verdana",11,11,,.T.,,,,.F.,.F.)
	Private oFont28b := TFont():New("Verdana",28,28,,.T.,,,,.F.,.F.)
	Private oFont50b := TFont():New("Verdana",50,50,,.T.,,,,.F.,.F.)

	oPrintPPRA	:= FWMSPrinter():New(OemToAnsi(STR0017), IMP_PDF,,,.T.) //"PROGRAMA DE CONTROLE MÉDICO DE SAUDE OCUPACIONAL - PCMSO"
	oPrintPPRA:SetParm( "-RFS")
	oPrintPPRA:SetResolution(72)
	oPrintPPRA:SetPortrait()
	oPrintPPRA:SetPaperSize(DMPAPER_A4)
	oPrintPPRA:SetMargin(10,10,10,10) // nEsquerda, nSuperior, nDireita, nInferior

	If lSigaMdtps
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par03)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	Else
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par01)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	EndIf

	//Contadores de linha e pagina
	Private lin := 9999

	//Caminho do logoppp.bmp
	Private cStartDir := AllTrim(GetSrvProfString("StartPath","\"))
	Private cStartLogo := " "
	If lSigaMdtPS
		If File(cStartDir+"LGRL"+cCliMdtPs+".BMP")
			cStartLogo := cStartDir+"LGRL"+cCliMdtPs+".BMP"
		ElseIf File(cStartDir+"LGRL"+Substr(cCliMdtPs,1,nSizeSA1)+".BMP")
			cStartLogo := cStartDir+"LGRL"+Substr(cCliMdtPs,1,nSizeSA1)+".BMP"
		EndIf
	Else
		If File(cStartDir+"LGRL"+cSMCOD+cSMFIL+".BMP")
			cStartLogo := cStartDir+"LGRL"+cSMCOD+cSMFIL+".BMP"
		ElseIf File(cStartDir+"LGRL"+cSMCOD+".BMP")
			cStartLogo := cStartDir+"LGRL"+cSMCOD+".BMP"
		EndIf
	EndIf

	//Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	cabec1 := " "
	cabec2 := " "

	/*
			1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		FUNCOES          N.    HO    MU    ME         RISCOS                  EPI                  EXAMES
	XXXXXXXXXXXXXXXXXXXXX  XXXX  XXXX  XXXX  XXXX  XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXX   XXXXXXXXXXXXXXXXXXXX
	*/
	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
	EndIf

	aPCMSO := {}
	If lSigaMdtps
		Dbselectarea("TMW")
		Dbsetorder(6)
		Dbseek(xFilial("TMW")+Mv_par01+Mv_par02,.T.)
		While !eof() .And. xFilial("TMW") == TMW->TMW_FILIAL .And. Substr(TMW->TMW_CCDE,1,nSizeSA1+nSizeLo1) == Mv_par01+Mv_par02
			If TMW->TMW_PCMSO >= Mv_par04 .And. TMW->TMW_PCMSO <= Mv_par05
				aADD(aPCMSO,TMW->TMW_PCMSO)
			EndIf
			Dbselectarea("TMW")
			Dbskip()
		End

		Dbselectarea("TMW")
		Dbsetorder(1)
		Dbseek ( xFilial("TMW") + Mv_par04, .T.)
		dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		If Empty(TMW->TMW_CCATE)
			cCCPCMSO:= TMW->TMW_CCDE    //CC DO PCMSO
		EndIf

		If mv_par05==Replicate('Z',6)
			Dbgobottom()
		Else
			Dbseek ( xFilial("TMW") + mv_par05)
		EndIf

		If TMW->TMW_DTINIC < dIniPrg
			dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		EndIf
		If TMW->TMW_DTFIM > dFimPrg
			dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		EndIf

		dbSelectArea("TO0")
		dbSetOrder(06)  //TO0_FILIAL+TO0_CLIENT+TO0_LOJA+TO0_LAUDO
		dbSeek(xFilial("TO0")+MV_PAR01+MV_PAR02+MV_PAR03)

	Else

		Dbselectarea("TMW")
		Dbsetorder(1)
		Dbseek ( xFilial("TMW") + Mv_par02, .T.)
		dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		If !Empty(TMW->TMW_CCATE)
			cCCPCMSO:= TMW->TMW_CCDE    //CC DO PCMSO
		EndIf

		If mv_par03==Replicate('Z',6)
			Dbgobottom()
		Else
			Dbseek ( xFilial("TMW") + mv_par03)
		EndIf

		If TMW->TMW_DTINIC < dIniPrg
			dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		EndIf
		If TMW->TMW_DTFIM > dFimPrg
			dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		EndIf

		dbSelectArea("TO0")
		dbSetOrder(01)
		dbSeek(xFilial("TO0")+MV_PAR01)

	EndIf

	cCidade   := Alltrim(SM0->M0_CIDCOB)+If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")
	cEmp_Nome := SM0->M0_NOMECOM
	cEmp_Cnpj := aTipoInsc[2]
	cEmp_Endr := SM0->M0_ENDCOB
	cEmp_Insc := SM0->M0_INSC
	cEmp_Cnae := SM0->M0_CNAE
	If lSigaMdtps
		Dbselectarea("SA1")
		Dbsetorder(1)
		If Dbseek(xFilial("SA1")+mv_par01+mv_par02)
			cCidade   := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
			cEmp_Nome := SA1->A1_NOME
			cEmp_Cnpj := SA1->A1_CGC
			cEmp_Endr := SA1->A1_END
			cEmp_Insc := SA1->A1_INSCR
			cEmp_Cnae := SA1->A1_ATIVIDA
		EndIf
	ElseIf lMV_NGMDTPS
		Dbselectarea("SA1")
		Dbsetorder(1)
		If Dbseek(xFilial("SA1")+TO0->TO0_CLIENT)
			cCidade   := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
			cEmp_Nome := SA1->A1_NOME
			cEmp_Cnpj := SA1->A1_CGC
			cEmp_Endr := SA1->A1_END
			cEmp_Insc := SA1->A1_INSCR
			cEmp_Cnae := SA1->A1_ATIVIDA
		EndIf
	EndIf

	cTitPCMSO := STR0068 //"Programa de Controle Médico de Saúde Ocupacional"
	SomaLinha(150)
	oPrintPPRA:Say(700,850,STR0166,oFont50b,,,,2) // "PCMSO"
	oPrintPPRA:Say(1200,300,AllTrim(MemoLine(cTitPCMSO,33,1)),oFont28b,,,,2)
	oPrintPPRA:Say(1400,650,AllTrim(MemoLine(cTitPCMSO,33,2)),oFont28b,,,,2)

	dIniMY := StrZero(Month(dIniPrg),2)+"/"+Str(Year(dIniPrg),4)
	dTerMY := StrZero(Month(dFimPrg),2)+"/"+Str(Year(dFimPrg),4)
	cTitPCMSO := STR0069+" " + dIniMY + " "+STR0070+" " + dTerMY //"Período de" //"até"
	oPrintPPRA:Say(1600,980,MemoLine(cTitPCMSO,35,3),oFont12b)

	oPrintPPRA:Say(2220, 150, STR0071+" :",oFont12b) //"EMPRESA"
	oPrintPPRA:Say(2220, 350, cEmp_Nome,oFont12)
	oPrintPPRA:Say(2300, 150, aTipoInsc[1],oFont12b) //"CNPJ/CGC :"
	oPrintPPRA:Say(2300, 300, cEmp_Cnpj,oFont12)
	oPrintPPRA:Say(2380, 150, STR0072+" :",oFont12b) //"IE"
	oPrintPPRA:Say(2380, 250, cEmp_Insc,oFont12)
	oPrintPPRA:Say(2460, 150, STR0021,oFont12b)     //"CNAE .........: "
	oPrintPPRA:Say(2460, 300, cEmp_Cnae,oFont12)
	oPrintPPRA:Say(2540, 150, STR0013,oFont12b)     //"GRAU DE RISCO :"
	oPrintPPRA:Say(2540, 480, TO0->TO0_GRISCO,oFont12)
	oPrintPPRA:Say(2620, 150, Upper(STR0007),oFont12b) //"CIDADE"
	oPrintPPRA:Say(2620, 350, cCidade,oFont12)
	oPrintPPRA:Say(2700, 150, STR0073+" :",oFont12b) //"ENDEREÇO"
	oPrintPPRA:Say(2700, 370, cEmp_Endr,oFont12)

	Dbselectarea(cAlias)
	Dbsetorder(1)
	If Dbseek(xFilial(cAlias)+cCCPCMSO) .And. !Empty(cCCPCMSO) .And. lMdtUmCC
		oPrintPPRA:Say(2780, 150, Upper(STR0032), oFont12b) //"Centro de Custo:"
		oPrintPPRA:Say(2780, 550, &(cDescr), oFont12)
	EndIf

	lin := 9999 //Forçar quebra de pagina

	cMemo := Alltrim(TO0->TO0_DESCRI)
	If !Empty(TO0->TO0_MMSYP2)
		cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
		If !Empty(cMMSYP2)
			If !Empty(cMemo)
				cMemo += CRLF
			EndIf
			cMemo += cMMSYP2
		EndIf
	EndIf

	SetRegua(100)
	nLenMemo := Len(cMemo)
	nPerMemo := 0

	While lEof
		If Empty(cMemo)  //Memo vazio
			lEof := .F.
			Exit
		Else
			nPos1 := At("#",cMemo) //Inicio de um Titulo

			If nPos1 > 1
				cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
				cMemo  := Alltrim(Substr(cMemo,nPos1))
				U_IMPTXT870(Alltrim(cTexto))
				fReguaPCMSO( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
				Loop
			ElseIf nPos1 == 1 //Existe #
				cMemo   := Alltrim(Substr(cMemo,nPos1+1))
				nPos1   := At("#",cMemo)
				cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
				cMemo   := Alltrim(Substr(cMemo,nPos1+1))

				nPos1   := At("#",cMemo)
				If nPos1 > 0
					cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
					cMemo  := Alltrim(Substr(cMemo,nPos1))
				Else
					cTexto := Alltrim(cMemo)
					cMemo  := " "
					lEof   := .F.
				EndIf
			Else //Nao existe #
				//IMPRIME TEXTO
				U_IMPTXT870(Alltrim(cMemo))
				lEof := .F.
				Exit
			EndIf

			//IMPRIME TITULO
			If !Empty(cTitulo)
				U_IMPCAB870(cTitulo)
			EndIf

			//IMPRIME TEXTO
			If !Empty(cTexto)
				lPrint := .T.
				lPrin2 := .T.
				U_IMPTXT870(Alltrim(cTexto))
			EndIf

		EndIf

		fReguaPCMSO( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua

	End

	cTxtMemo := " "
	DbSelectArea("TMZ")
	DbSetOrder(1)
	IF DbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
		cTxtMemo := TMZ->TMZ_DESCRI
	EndIf

	Dbselectarea("TMK")
	Dbsetorder(1)
	If lSigaMdtps
		Dbseek(xFilial("TMK")+Mv_par06)
	Else
		Dbseek(xFilial("TMK")+Mv_par04)
	EndIf

	If Lin != 100 //Se o cursor estiver na primeira linha nao eh necessario criar uma nova pagina
		Lin := 9999
		Somalinha()
	EndIf

	oPrintPPRA:Say(lin,1000,STR0022,oFont12b) //"RESPONSÁVEIS TÉCNICOS"

	Somalinha(180)
	U_IMPTXT870(Alltrim(cTxtMemo))

	Somalinha(180)
	oPrintPPRA:Say(lin,150,STR0023,oFont12b) //"MÉDICO COORDENADOR:"
	oPrintPPRA:Say(lin,550,Alltrim(SubStr(TMK->TMK_NOMUSU,1,40)),oFont12)

	Somalinha()
	oPrintPPRA:Say(lin,150,STR0024,oFont12b) //"REG.SSST:"
	oPrintPPRA:Say(lin,350,Alltrim(TMK->TMK_REGMTB),oFont12)

	Somalinha()
	oPrintPPRA:Say(lin,150,If(Empty(TMK->TMK_ENTCLA),STR0167,Alltrim(TMK->TMK_ENTCLA))+": ",oFont12b) // "CRM"
	oPrintPPRA:Say(lin,250,Alltrim(TMK->TMK_NUMENT),oFont12)


	Somalinha()
	oPrintPPRA:Say(lin,150,STR0025,oFont12b) //"FONE:"
	oPrintPPRA:Say(lin,270,Alltrim(TMK->TMK_TELUSU),oFont12)

	Somalinha()
	oPrintPPRA:Say(lin,150,STR0026,oFont12b) //"ENDEREÇO:"
	oPrintPPRA:Say(lin,350,Alltrim(TMK->TMK_ENDUSU),oFont12)


	Somalinha(180)
	oPrintPPRA:Say(lin,150,STR0027,oFont12b) //"DATA:"
	oPrintPPRA:Say(lin,270,Alltrim(Transform(Date(),"99/99/9999")),oFont12)

	Somalinha(300)
	oPrintPPRA:Say(lin,150,STR0077+" ___________________________________________",oFont12) //"Ass:"

	If aReturn[5] == 1
		oPrintPPRA:Preview()
	Else
		oPrintPPRA:Print()
	EndIf

	//Devolve a condicao original do arquivo principal
	RetIndex("TO0")
	Set Filter To

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Incrementa Linha e Controla Salto de Pagina

@return .T., Lógico, sempre verdadeiro

@sample SomaLinha()

@author	Inacio Luiz Kolling
@since	01/06/1997
/*/
//---------------------------------------------------------------------
Static Function Somalinha(lLinha,lLinha2,lLinhaAux,nLin__,lAnexoB)

	Local lLinha3 := .T.
	Default lAnexoB := .F.//Variavel do ANEXO B

	If nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
	ElseIf nModeloImp == 2
		If lLinhaAux
			lLinha3 := .F.
		EndIf
		Li++
		If Li > 58
			If lLinha
				If !lAnexoB
					@li,000 Psay "|"
					@li,001 Psay Replicate("_",31)
					@li,032 Psay "|"
					@li,033 Psay Replicate("_",31)
					@li,064 Psay "|"
					@li,065 Psay Replicate("_",31)
					@li,096 Psay "|"
					@li,097 Psay Replicate("_",31)
					@li,128 Psay "|"
				Else
					@li,000 Psay "|"
					@li,001 Psay Replicate("_",31)
					@li,032 Psay "|"
					@li,033 Psay Replicate("_",31)
					@li,064 Psay "|"
					@li,065 Psay Replicate("_",31)
					@li,096 Psay "|"
					@li,097 Psay Replicate("_",7)
					@li,104 Psay "|"
					@li,105 Psay Replicate("_",7)
					@li,112 Psay "|"
					@li,113 Psay Replicate("_",7)
					@li,120 Psay "|"
					@li,121 Psay Replicate("_",7)
					@li,128 Psay "|"
				EndIf
			EndIf
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			If lLinha2
				@li,001 Psay Replicate("_",127)
				If lLinha3
					Somalinha()
				EndIf
				Return .F.
			EndIf
		EndIf
	ElseIf nModeloImp == 3
		If ValType(lLinha) == "N"
			Lin += lLinha
		Else
			Lin += 60
		EndIf
		If Lin > 2800
			Lin := 300
			If nPaginaG > 0
				oPrintPPRA:EndPage()
			EndIf
			oPrintPPRA:StartPage()
			nPaginaG++
			If nPaginaG != 1
				oPrintPPRA:Say(100,2320,Alltrim(Str(nPaginaG,10)),oFont08)
			EndIf
			If !Empty(cStartLogo) .And. File(cStartLogo)
				oPrintPPRA:SayBitMap(100,150,cStartLogo,300,150)
			EndIf
		EndIf
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR870WOR
Relatorio do PCMSO

@return .T., Lógico, sempre verdadeiro

@sample U_MDTR870WOR()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function MDTR870WOR()

	nSizeSA1  := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	nSizeLo1  := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	cPerg := "MDT87R    "

	/*  Perguntas
	MDT87R    ¦01      ¦Laudo ?
	MDT87R    ¦02      ¦De PCMSO ?
	MDT87R    ¦03      ¦Ate PCMSO ?
	MDT87R    ¦04      ¦Medico Coordenador ?
	MDT87R    ¦05      ¦Impressao ?
	MDT87R    ¦06      ¦Arquivo Saida ?
	MDT87R    ¦07      ¦Listar Exames ?
	*/

	If Pergunte(cPerg,.T.)
		Mv_parEx := mv_par07
		RptStatus({|lEnd| U_IMP870WD()},STR0166) //"PCMSO"
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} IMP870WD
Impressao do relatorio

@return .T., Lógico, sempre verdadeiro

@sample U_IMP870WD()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function IMP870WD()

	Local cMemo := " ",cTitulo := " ",cTexto := " "
	Local lEof := .T.,nX,nXP
	Local cArqDot  := "pcmso.dot"							// Nome do arquivo modelo do Word (Tem que ser .dot)
	Local cPathDot := Alltrim(GetMv("MV_DIRACA"))			// Path do arquivo modelo do Word
	Local cRootPath
	Local cBarraRem := "\"
	Local cBarraSrv := "\"
	Local nLenMemo := 0
	Local nPerMemo := 0

	Private cPathEst := Alltrim(GetMv("MV_DIREST")) 			// PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHOZ

	aFilRelat := {}
	If lTMW_Filial .And. !Empty(xFilial("TM5")) .And. !lSigaMdtps
		aAreaSM0 := SM0->(GetArea())
		dbSelectArea("SM0")
		dbGoTop()
		If Empty(Mv_par08)
			dbSeek(cEmpAnt)
		Else
			dbSeek(cEmpAnt+Mv_par08)
		EndIf
		While !Eof() .And. AllTrim(SM0->M0_CODIGO) == cEmpAnt .And. AllTrim(SM0->M0_CODFIL) <= Mv_par09
			cCodFil := FWCodFil()
			aAdd( aFilRelat , { cCodFil , SM0->M0_NOME , Mv_par08 , Mv_par09 } )
			dbSkip()
		End
		RestArea(aAreaSM0)
	Else
		aAdd( aFilRelat , { cFilAnt , SM0->M0_NOME , Mv_par08 , Mv_par09 } )
	EndIf

	Private lCriaIndice := .F.

	If GetRemoteType() == 2  //estacao com sistema operacional unix
		cBarraRem := "/"
	EndIf
	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	EndIf

	cPathDot += If(Substr(cPathDot,len(cPathDot),1) != cBarraSrv,cBarraSrv,"") + cArqDot
	cPathEst += If(Substr(cPathEst,len(cPathEst),1) != cBarraRem,cBarraRem,"")

	//Cria diretorio se nao existir
	MontaDir(cPathEst)

	//Se existir .dot na estacao, apaga!
	If File( cPathEst + cArqDot )
		Ferase( cPathEst + cArqDot )
	EndIf
	If !File(cPathDot)
		MsgStop( STR0074 + chr(10)+ STR0075 +" 'MV_DIRACA'.",STR0076) //"O arquivo pcmso.dot não foi encontrado no servidor." //"Verificar parâmetro" //"ATENÇÃO"
		Return
	EndIf
	CpyS2T(cPathDot,cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario
	// para que o wordview e o proprio word possam preparar o arquivo para impressao e
	// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
	// estacao , por exemplo C:\WORDTMP

	Private cVar := "cVAR",nVar := 1
	Private cVar1 := "cTIT",nVar1 := 1
	Private cAlias := "SI3"
	Private cDescr := "SI3->I3_DESC"
	Private lPrint := .T.
	Private lPrin2 := .T.
	Private lFirst := .T.
	Private lJumpCab := .T.
	Private lIdentar := .F.
	Private dIniPrg := Stod(Space(8))
	Private dFimPrg := Stod(Space(8))

	If lSigaMdtps
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par03)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	Else
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par01)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	EndIf

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
	EndIf

	Dbselectarea("SRJ")
	Dbsetorder(1)
	Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)

	Dbselectarea(cAlias) 	//SI3 ou CTT
	Dbsetorder(1)
	Dbseek(xFilial(cAlias)+SRA->RA_CC)

	aPCMSO := {}
	If lSigaMdtps
		Dbselectarea("TMW")
		Dbsetorder(6)
		Dbseek(xFilial("TMW")+Mv_par01+Mv_par02,.T.)
		While !eof() .And. xFilial("TMW") == TMW->TMW_FILIAL .And. Substr(TMW->TMW_CCDE,1,nSizeSA1+nSizeLo1) == Mv_par01+Mv_par02
			If TMW->TMW_PCMSO >= Mv_par04 .And. TMW->TMW_PCMSO <= Mv_par05
				aADD(aPCMSO,TMW->TMW_PCMSO)
			EndIf
			Dbselectarea("TMW")
			Dbskip()
		End

		Dbselectarea("TMW")
		Dbsetorder(1)
		Dbseek ( xFilial("TMW") + Mv_par04, .T.)
		dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		If Empty(TMW->TMW_CCATE)
			cCCPCMSO:= TMW->TMW_CCDE    //CC DO PCMSO
		EndIf

		If mv_par05==Replicate('Z',6)
			Dbgobottom()
		Else
			Dbseek ( xFilial("TMW") + mv_par05)
		EndIf

		If TMW->TMW_DTINIC < dIniPrg
			dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		EndIf
		If TMW->TMW_DTFIM > dFimPrg
			dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		EndIf

		Dbselectarea("TO0")
		Dbsetorder(6)  //TO0_FILIAL+TO0_CLIENT+TO0_LOJA+TO0_LAUDO
		If Dbseek(xFilial("TO0")+cCliMdtps+mv_par03)

			lImpress	:= If(mv_par07 == 1,.T.,.F.)	//Verifica se a saida sera em Tela ou Impressora
			cArqSaida	:= If(Empty(mv_par08),"Documento1",AllTrim(mv_par08))	// Nome do arquivo de saida

			oWord := OLE_CreateLink('TMsOleWord97')//Cria link como Word

			If lImpress //Impressao via Impressora
				OLE_SetProperty(oWord,oleWdVisible,  .F.)
				OLE_SetProperty(oWord,oleWdPrintBack,.T.)
			Else //Impressao na Tela(Arquivo)
				OLE_SetProperty(oWord,oleWdVisible,  .F.)
				OLE_SetProperty(oWord,oleWdPrintBack,.F.)
			EndIf
			cType := "pcmso| *.dot"

			OLE_NewFile(oWord,cPathEst + cArqDot) //Abrindo o arquivo modelo automaticamente

			OLE_SetDocumentVar(oWord,"DataInicio",StrZero(Month(dIniPrg),2)+"/"+Str(Year(dIniPrg),4))
			OLE_SetDocumentVar(oWord,"DataFim",StrZero(Month(dFimPrg),2)+"/"+Str(Year(dFimPrg),4))
			Dbselectarea("SA1")
			Dbsetorder(1)
			Dbseek(xFilial("SA1")+cCliMdtps)
			cCidade   := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
			cEmp_Nome := SA1->A1_NOME
			cEmp_Cnpj := SA1->A1_CGC
			cEmp_Endr := SA1->A1_END
			cEmp_Insc := SA1->A1_INSCR
			cEmp_Cnae := SA1->A1_ATIVIDA
			cEmp_GRisco := TO0->TO0_GRISCO

			//Dados Empresa
			OLE_SetDocumentVar(oWord,"Empresa",cEmp_Nome)
			OLE_SetDocumentVar(oWord,"tipoInscr",aTipoInsc[1])
			OLE_ExecuteMacro(oWord,"Com_Negrito")
			OLE_SetDocumentVar(oWord,"CGC",cEmp_Cnpj)
			OLE_SetDocumentVar(oWord,"Ie",cEmp_Insc)
			OLE_SetDocumentVar(oWord,"Cnae",cEmp_Cnae)
			OLE_SetDocumentVar(oWord,"GRisco",cEmp_GRisco)
			OLE_SetDocumentVar(oWord,"Cidade",cCidade)
			OLE_SetDocumentVar(oWord,"Endereco",cEmp_Endr)
			Dbselectarea(cAlias)
			Dbsetorder(1)
			If Dbseek(xFilial(cAlias)+cCCPCMSO) .And. !Empty(cCCPCMSO) .And. lMdtUmCC
				OLE_SetDocumentVar(oWord,"CapaCC",&(cDescr))
			EndIf

			OLE_ExecuteMacro(oWord,"NewPage")

			cMemo := Alltrim(TO0->TO0_DESCRI)

			If !Empty(TO0->TO0_MMSYP2)
				cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
				If !Empty(cMMSYP2)
					If !Empty(cMemo)
						cMemo += CRLF
					EndIf
					cMemo += cMMSYP2
				EndIf
				EndIf


			SetRegua(100)
			nLenMemo := Len(cMemo)
			nPerMemo := 0

			While lEof
				OLE_ExecuteMacro(oWord,"Atualiza")

				If Empty(cMemo)  //Memo vazio
					lEof := .F.
					Exit
				Else
					nPos1 := At("#",cMemo) //Inicio de um Titulo

					If nPos1 > 1
						cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo  := Alltrim(Substr(cMemo,nPos1))
						U_IMPTXT870(Alltrim(cTexto))
						fReguaPCMSO( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
						Loop
					ElseIf nPos1 == 1 //Existe #
						cMemo   := Alltrim(Substr(cMemo,nPos1+1))
						nPos1   := At("#",cMemo)
						cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo   := Alltrim(Substr(cMemo,nPos1+1))

						nPos1   := At("#",cMemo)
						If nPos1 > 0
							cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
							cMemo  := Alltrim(Substr(cMemo,nPos1))
						Else
							cTexto := Alltrim(cMemo)
							cMemo  := " "
							lEof   := .F.
						EndIf
					Else //Nao existe #
						//IMPRIME TEXTO
						U_IMPTXT870(Alltrim(cMemo))
						lEof := .F.
						Exit
					EndIf


					//IMPRIME TITULO
					If !Empty(cTitulo)
						U_IMPCAB870(cTitulo,,.T.)
					EndIf

					//IMPRIME TEXTO
					If !Empty(cTexto)
						lPrint := .T.
						lPrin2 := .T.
						U_IMPTXT870(Alltrim(cTexto))
					EndIf

				EndIf

				fReguaPCMSO( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua

			End

			cTxtMemo := " "
			DbSelectArea("TMZ")
			DbSetOrder(1)
			IF DbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
				cTxtMemo := TMZ->TMZ_DESCRI
			EndIf

			Dbselectarea("TMK")
			Dbsetorder(1)
			Dbseek(xFilial("TMK")+Mv_par06)

			OLE_ExecuteMacro(oWord,"NewPage")

			U_IMPCAB870("{CNS}"+STR0022,.T.) //"RESPONSÁVEIS TÉCNICOS"
			For nX := 1 to 3
				OLE_ExecuteMacro(oWord,"Somalinha")
			Next nX

			U_IMPTXT870(Alltrim(cTxtMemo))

			U_IMPCAB870("{N}"+STR0023) //"MÉDICO COORDENADOR:"
			lPrint := .F.
			lPrin2 := .F.
			U_IMPTXT870(Alltrim(SubStr(TMK->TMK_NOMUSU,1,40)))

			U_IMPCAB870("{N}"+STR0024,.T.) //"REG.SSST:"
			lPrint := .F.
			lPrin2 := .F.
			U_IMPTXT870(Alltrim(TMK->TMK_REGMTB))

			U_IMPCAB870("{N}"+If(Empty(TMK->TMK_ENTCLA),STR0167,Alltrim(TMK->TMK_ENTCLA))+": ",.T.) // "CRM"
			lPrint := .F.
			lPrin2 := .F.
			U_IMPTXT870(Alltrim(TMK->TMK_NUMENT))

			U_IMPCAB870("{N}"+STR0025,.T.) //"FONE:"
			lPrint := .F.
			lPrin2 := .F.
			U_IMPTXT870(Alltrim(TMK->TMK_TELUSU))

			U_IMPCAB870("{N}"+STR0026,.T.) //"ENDEREÇO:"
			lPrint := .F.
			lPrin2 := .F.
			U_IMPTXT870(Alltrim(TMK->TMK_ENDUSU))

			For nX := 1 to 3
				OLE_ExecuteMacro(oWord,"Somalinha")
			Next nX

			U_IMPCAB870("{N}"+STR0027,.T.) //"DATA:"
			lPrint := .F.
			lPrin2 := .F.
			U_IMPTXT870(Alltrim(Transform(Date(),"99/99/9999")))
			For nX := 1 to 5
				OLE_ExecuteMacro(oWord,"Somalinha")
			Next nX

			U_IMPCAB870("{N}"+STR0077+" ___________________________________________") //"Ass:"

			OLE_SetDocumentVar(oWord,"Cria_Var"	,Space(1)) //Limpa campo oculto do documento
			OLE_SetDocumentVar(oWord,"Tabela"	,Space(1)) //Limpa campo oculto do documento
			OLE_SetDocumentVar(oWord,"Tabela2"	,Space(1)) //Limpa campo oculto do documento
			OLE_SetDocumentVar(oWord,"Linhas"	,Space(1)) //Limpa campo oculto do documento
			If lCriaIndice
				OLE_ExecuteMacro(oWord,"Cria_Indice")//"Cria o indice"
			EndIf
			OLE_ExecuteMacro(oWord,"Atualiza") //Executa a macro que atualiza os campos do documento
			If lCriaIndice
				OLE_ExecuteMacro(oWord, "AtualizaIndice")//"Atualiza Indice"
			EndIf
			OLE_ExecuteMacro(oWord,"Begin_Text") //Posiciona o cursor no inicio do documento

			cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "ERROR", GetADV97() )
			cRootPath := IF( RIGHT(cRootPath,1) == cBarraSrv,SubStr(cRootPath,1,Len(cRootPath)-1), cRootPath)

			IF lImpress //Impressao via Impressora
				OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord, "ALL",,, 1 )
			Else //Impressao na Tela(Arquivo)
				OLE_SetProperty(oWord,oleWdVisible,.T.)
				OLE_ExecuteMacro(oWord,"Maximiza_Tela")
				If !lMdtUnix //Se for windows
					If U_DIRR870(cRootPath+cBarraSrv+"RELATO"+cBarraSrv)
						OLE_SaveAsFile(oWord,cRootPath+cBarraSrv+"RELATO"+cBarraSrv+cArqSaida,,,.F.,oleWdFormatDocument)
					Else
						OLE_SaveAsFile(oWord,cPathEst+cArqSaida,,,.F.,oleWdFormatDocument)
					EndIf
				EndIf
				MsgInfo(STR0062) //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
			EndIf
			OLE_CloseLink(oWord) //Fecha o documento

		EndIf

	Else

		Dbselectarea("TMW")
		Dbsetorder(1)
		Dbseek ( xFilial("TMW") + Mv_par02, .T.)
		dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		If !Empty(TMW->TMW_CCATE)
			cCCPCMSO:= TMW->TMW_CCDE    //CC DO PCMSO
		EndIf

		If mv_par03==Replicate('Z',6)
			Dbgobottom()
		Else
			Dbseek ( xFilial("TMW") + mv_par03)
		EndIf

		If TMW->TMW_DTINIC < dIniPrg
			dIniPrg := TMW->TMW_DTINIC   //INICIO DO PCMSO
		EndIf
		If TMW->TMW_DTFIM > dFimPrg
			dFimPrg := TMW->TMW_DTFIM   //TERMINO DO PCMSO
		EndIf

		Dbselectarea("TO0")
		Dbsetorder(1)
		If Dbseek(xFilial("TO0")+Mv_par01)

			lImpress	:= If(mv_par05 == 1,.T.,.F.)	//Verifica se a saida sera em Tela ou Impressora
			cArqSaida	:= If(Empty(mv_par06),"Documento1",AllTrim(mv_par06))	// Nome do arquivo de saida

			oWord := OLE_CreateLink('TMsOleWord97')//Cria link como Word

			If lImpress //Impressao via Impressora
				OLE_SetProperty(oWord,oleWdVisible,  .F.)
				OLE_SetProperty(oWord,oleWdPrintBack,.T.)
			Else //Impressao na Tela(Arquivo)
				OLE_SetProperty(oWord,oleWdVisible,  .F.)
				OLE_SetProperty(oWord,oleWdPrintBack,.F.)
			EndIf

			cType := "pcmso| *.dot"

			OLE_NewFile(oWord,cPathEst + cArqDot) //Abrindo o arquivo modelo automaticamente

			OLE_SetDocumentVar(oWord,"DataInicio",StrZero(Month(dIniPrg),2)+"/"+Str(Year(dIniPrg),4))
			OLE_SetDocumentVar(oWord,"DataFim",StrZero(Month(dFimPrg),2)+"/"+Str(Year(dFimPrg),4))
			Dbselectarea("SA1")
			Dbsetorder(1)
			If Dbseek(xFilial("SA1")+TO0->TO0_CLIENT)
				cCidade   := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
				cEmp_Nome := SA1->A1_NOME
				cEmp_Cnpj := SA1->A1_CGC
				cEmp_Endr := SA1->A1_END
				cEmp_Insc := SA1->A1_INSCR
				cEmp_Cnae := SA1->A1_ATIVIDA
			Else
				cCidade   := Alltrim(SM0->M0_CIDCOB)+If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")
				cEmp_Nome := SM0->M0_NOMECOM
				cEmp_Cnpj := aTipoInsc[2]
				cEmp_Endr := SM0->M0_ENDCOB
				cEmp_Insc := SM0->M0_INSC
				cEmp_Cnae := SM0->M0_CNAE
			EndIf
			cEmp_GRisco := TO0->TO0_GRISCO

			//Dados Empresa
			OLE_SetDocumentVar(oWord,"Empresa",cEmp_Nome)
			OLE_SetDocumentVar(oWord,"tipoInscr",aTipoInsc[1])
			OLE_ExecuteMacro(oWord,"Com_Negrito")
			OLE_SetDocumentVar(oWord,"CGC",cEmp_Cnpj)
			OLE_SetDocumentVar(oWord,"Ie",cEmp_Insc)
			OLE_SetDocumentVar(oWord,"Cnae",cEmp_Cnae)
			OLE_SetDocumentVar(oWord,"GRisco",cEmp_GRisco)
			OLE_SetDocumentVar(oWord,"Cidade",cCidade)
			OLE_SetDocumentVar(oWord,"Endereco",cEmp_Endr)
			Dbselectarea(cAlias)
			Dbsetorder(1)
			If Dbseek(xFilial(cAlias)+cCCPCMSO) .And. !Empty(cCCPCMSO) .And. lMdtUmCC
				OLE_SetDocumentVar(oWord,"CapaCC",&(cDescr))
			EndIf

			OLE_ExecuteMacro(oWord,"NewPage")

			cMemo := Alltrim(TO0->TO0_DESCRI)

			If !Empty(TO0->TO0_MMSYP2)
				cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
				If !Empty(cMMSYP2)
					If !Empty(cMemo)
						cMemo += CRLF
					EndIf
					cMemo += cMMSYP2
				EndIf
				EndIf

			SetRegua(100)
			nLenMemo := Len(cMemo)
			nPerMemo := 0

			While lEof
				OLE_ExecuteMacro(oWord,"Atualiza")

				If Empty(cMemo)  //Memo vazio
					lEof := .F.
					Exit
				Else
					nPos1 := At("#",cMemo) //Inicio de um Titulo

					If nPos1 > 1
						cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo  := Alltrim(Substr(cMemo,nPos1))
						U_IMPTXT870(Alltrim(cTexto))
						fReguaPCMSO( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
						Loop
					ElseIf nPos1 == 1 //Existe #
						cMemo   := Alltrim(Substr(cMemo,nPos1+1))
						nPos1   := At("#",cMemo)
						cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo   := Alltrim(Substr(cMemo,nPos1+1))

						nPos1   := At("#",cMemo)
						If nPos1 > 0
							cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
							cMemo  := Alltrim(Substr(cMemo,nPos1))
						Else
							cTexto := Alltrim(cMemo)
							cMemo  := " "
							lEof   := .F.
						EndIf
					Else //Nao existe #
						//IMPRIME TEXTO
						U_IMPTXT870(Alltrim(cMemo))
						lEof := .F.
						Exit
					EndIf


					//IMPRIME TITULO
					If !Empty(cTitulo)
						U_IMPCAB870(cTitulo,,.T.)
					EndIf

					//IMPRIME TEXTO
					If !Empty(cTexto)
						lPrint := .T.
						lPrin2 := .T.
						U_IMPTXT870(Alltrim(cTexto))
					EndIf

				EndIf

				fReguaPCMSO( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua

			End

			cTxtMemo := " "
			DbSelectArea("TMZ")
			DbSetOrder(1)
			IF DbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
				cTxtMemo := TMZ->TMZ_DESCRI
			EndIf

			Dbselectarea("TMK")
			Dbsetorder(1)
			Dbseek(xFilial("TMK")+Mv_par04)
			If lCriaIndice
				OLE_ExecuteMacro(oWord,"NewPage")
			EndIf
			U_IMPCAB870("{CNS}"+STR0022,.T.) //"RESPONSÁVEIS TÉCNICOS"
			For nX := 1 to 3
				OLE_ExecuteMacro(oWord,"Somalinha")
			Next nX

			U_IMPTXT870(Alltrim(cTxtMemo))

			cMemo := Alltrim(STR0023)+"#*" //"MÉDICO COORDENADOR:"
			cMemo += Alltrim(TMK->TMK_NOMUSU)+"#*"
			cMemo += Alltrim(STR0024)+"#*" //"REG.SSST:"
			cMemo += Alltrim(TMK->TMK_REGMTB)+"#*"
			cMemo += If(Empty(TMK->TMK_ENTCLA),STR0167,Alltrim(TMK->TMK_ENTCLA))+": "+"#*" //"CRM"
			cMemo += Alltrim(TMK->TMK_NUMENT)+"#*"
			cMemo += AllTrim(STR0025)+"#*" //"FONE:"
			cMemo += Alltrim(TMK->TMK_TELUSU)+"#*"
			cMemo += AllTrim(STR0026)+"#*" //"ENDEREÇO:"
			cMemo += Alltrim(TMK->TMK_ENDUSU)+"#*"
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",5)
			OLE_ExecuteMacro(oWord,"Table_Responsaveis")

			For nX := 1 to 3
				OLE_ExecuteMacro(oWord,"Somalinha")
			Next nX

			U_IMPCAB870("{N}"+STR0027,.T.) //"DATA:"
			lPrint := .F.
			lPrin2 := .F.
			U_IMPTXT870(Alltrim(Transform(Date(),"99/99/9999")))
			For nX := 1 to 5
				OLE_ExecuteMacro(oWord,"Somalinha")
			Next nX

			U_IMPCAB870("{N}"+STR0077+" ___________________________________________") //"Ass:"

			OLE_SetDocumentVar(oWord,"Cria_Var"	,Space(1)) //Limpa campo oculto do documento
			OLE_SetDocumentVar(oWord,"Tabela"	,Space(1)) //Limpa campo oculto do documento
			OLE_SetDocumentVar(oWord,"Tabela2"	,Space(1)) //Limpa campo oculto do documento
			OLE_SetDocumentVar(oWord,"Linhas"	,Space(1)) //Limpa campo oculto do documento
			If lCriaIndice
				OLE_ExecuteMacro(oWord,"Cria_Indice")//"Cria o indice"
			EndIf
			OLE_ExecuteMacro(oWord,"Atualiza") //Executa a macro que atualiza os campos do documento
			If lCriaIndice
				OLE_ExecuteMacro(oWord, "AtualizaIndice")//"Atualiza Indice"
			EndIf
			OLE_ExecuteMacro(oWord,"Begin_Text") //Posiciona o cursor no inicio do documento

			cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "ERROR", GetADV97() )
			cRootPath := IF( RIGHT(cRootPath,1) == cBarraSrv,SubStr(cRootPath,1,Len(cRootPath)-1), cRootPath)

			IF lImpress //Impressao via Impressora
				OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord, "ALL",,, 1 )
			Else //Impressao na Tela(Arquivo)
				OLE_SetProperty(oWord,oleWdVisible,.T.)
				OLE_ExecuteMacro(oWord,"Maximiza_Tela")
				If !lMdtUnix //Se for windows
					If U_DIRR870(cRootPath+cBarraSrv+"RELATO"+cBarraSrv)
						OLE_SaveAsFile(oWord,cRootPath+cBarraSrv+"RELATO"+cBarraSrv+cArqSaida,,,.F.,oleWdFormatDocument)
					Else
						OLE_SaveAsFile(oWord,cPathEst+cArqSaida,,,.F.,oleWdFormatDocument)
					EndIf
				EndIf
				MsgInfo(STR0062) //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
			EndIf
			OLE_CloseLink(oWord) //Fecha o documento
		EndIf

	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} DIRR870
Verifica se o diretorio existe

@return lDir, Lógico, verdadeiro se o diretório existir

@sample U_DIRR870()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function DIRR870(cCaminho)

	Local lDir := .F.
	Local cBARRAS   := If(isSRVunix(),"/","\")
	Local cBARRAD := If(isSRVunix(),"//","\\")

	If !empty(cCaminho) .And. !(cBARRAD$cCaminho)
		cCaminho := alltrim(cCaminho)
		if Right(cCaminho,1) == cBARRAS
			cCaminho := SubStr(cCaminho,1,len(cCaminho)-1)
		EndIf
		lDir :=(Ascan( Directory(cCaminho,"D"),{|_Vet | "D" $ _Vet[5] } ) > 0)
	EndIf

Return lDir

//---------------------------------------------------------------------
/*/{Protheus.doc} IMPTXT870
Imprime o conteúdo do texto

@return .T., Lógico, sempre verdadeiro

@sample U_IMPTXT870()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function IMPTXT870(_cTexto)

	Local lTexto := .T.
	Local nPosTxt := 0
	Local cTitExe,LinhaCor
	Local cTextoNew := _cTexto
	Local cTxtMemo := _cTexto
	Local nArroba
	//Imprime texto

	lJumpCab := .F. //Somalinha do Titulo de Relatorio
	While lTexto
		nArroba := At("@",cTxtMemo)

		If nArroba > 1
			cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
			cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))
			U_IMPTXT870(Alltrim(cTextoNew))
			Loop
		ElseIf nArroba == 1 //Existe @
			cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))
			nArroba  := At("@",cTxtMemo)
			cTitExe  := Alltrim(Substr(cTxtMemo,1,nArroba-1))
			U_EXEC870TIT(cTitExe)
			cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))

			nArroba   := At("@",cTxtMemo)
			If nArroba > 0
				cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
				cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))
				U_IMPTXT870(Alltrim(cTextoNew))
				Loop
			EndIf
		EndIf

		If (nPosTxt := At(CRLF,cTxtMemo)) == 0
			lTexto := .F.
			cTextoNew :=  Alltrim(cTxtMemo)
		Else
			cTextoNew :=  Alltrim(Substr(cTxtMemo,1,nPosTxt-1))
			cTxtMemo  :=  Alltrim(Substr(cTxtMemo,nPosTxt+2))
			If Len(cTxtMemo) == 0
				lTexto := .F.
			EndIf
		EndIf

		lImp850 := .T.
		If Empty(cTextoNew)
			cTextoNew := " "
		EndIf

		If lImp850
			If nModeloImp == 2
				nAddLi := 0
				If lIdentar
					nAddLi := 5
				EndIf
				lPrimeiro := .T.
				nLinhasMemo := MLCOUNT(cTextoNew,120)
				For LinhaCor := 1 to nLinhasMemo
				    If lPrimeiro
						@ Li,005+nAddLi PSAY (MemoLine(cTextoNew,120,LinhaCor))
						lPrimeiro := .F.
					Else
						@ Li,000+nAddLi PSAY (MemoLine(cTextoNew,120,LinhaCor))
					EndIf
					Somalinha()
				Next LinhaCor
			ElseIf nModeloImp == 1
				cVar1 := "cTXT"+Strzero(nVar1,5)
				OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
				nVar1++

				If lPrint .And. !lFirst
					OLE_ExecuteMacro(oWord,"Somalinha")
					lPrint := .F.
				EndIf
				If lPrin2 .And. !lFirst
					OLE_ExecuteMacro(oWord,"Somalinha")
				EndIf
				lPrin2 := .T.
				lFirst := .F.

				OLE_ExecuteMacro(oWord,"Cria_Texto")
				If lIdentar
					OLE_ExecuteMacro(oWord,"Identar")
				EndIf
				OLE_ExecuteMacro(oWord,"Sem_Negrito")
				OLE_SetDocumentVar(oWord,cVar1,cTextoNew)
			ElseIf nModeloImp == 3
				nAddLi := 0
				If lIdentar
					nAddLi := 150
				EndIf
				lPrimeiro := .T.
				nLinhasMemo := MLCOUNT(cTextoNew,120)
				For LinhaCor := 1 to nLinhasMemo
					Somalinha()
				    If lPrimeiro
				    	oPrintPPRA:Say(lin,300+nAddLi,MemoLine(cTextoNew,120,LinhaCor),oFont10)
						lPrimeiro := .F.
					Else
						oPrintPPRA:Say(lin,150+nAddLi,MemoLine(cTextoNew,120,LinhaCor),oFont10)
					EndIf
				Next LinhaCor
			EndIf
		EndIf
	End

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} IMPCAB870
Imprime o título do texto

@return .T., Lógico, sempre verdadeiro

@sample U_IMPCAB870()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function IMPCAB870(_cTit,lJump,lIndice)

	Local nPosTemp
	Local _cTitulo := _cTit
	Local cCNS := " "
	Local lJumper
	Local nLinhasMemo
	Local LinhaCor

	Default lJump := .F.
	Default lIndice := .F.
	lJumper := If(!lJump,lJumpCab,lJump)

	If nModeloImp == 2
		If ("{" $ _cTitulo) .And.  ("}" $ _cTitulo)
			nPosTemp := At("}",_cTitulo)
			cCNS     := Substr(_cTitulo,1,nPosTemp)
			_cTitulo := Substr(_cTitulo,nPosTemp+1)
		EndIf
		Somalinha()
		@ Li,000 Psay _cTitulo
		Somalinha()
		Return .T.
	ElseIf nModeloImp == 3
		If ("{" $ _cTitulo) .And.  ("}" $ _cTitulo)
			nPosTemp := At("}",_cTitulo)
			cCNS     := Substr(_cTitulo,1,nPosTemp)
			_cTitulo := Substr(_cTitulo,nPosTemp+1)
		EndIf

		nLinhasMemo := MLCOUNT(_cTitulo,90)
		For LinhaCor := 1 to nLinhasMemo
			Somalinha()
			nColImp := 150
			cTxtImp := Alltrim(MemoLine(_cTitulo,90,LinhaCor))
			If ("C" $ Upper(cCNS)) //C=Centralizar
				nDiff := Round( (90 - Len(cTxtImp)) / 2 , 0 )
				If nDiff > 0
					nColImp := 100 + (nDiff*23.3)
				EndIf
			EndIf
			If ("N" $ Upper(cCNS)) //N=Negrito
				If ("S" $ Upper(cCNS)) //S=Sublinhar
					oPrintPPRA:Say(lin,nColImp,cTxtImp,oFont12bs)
				Else
					oPrintPPRA:Say(lin,nColImp,cTxtImp,oFont12b)
				EndIf
			Else
				If ("S" $ Upper(cCNS)) //S=Sublinhar
					oPrintPPRA:Say(lin,nColImp,cTxtImp,oFont12s)
				Else
					oPrintPPRA:Say(lin,nColImp,cTxtImp,oFont12)
				EndIf
			EndIf
		Next LinhaCor
		Return .T.
	Else

		lFirst := .F.////Somalinha do texto

		cVar := "cTIT"+Strzero(nVar,5)
		nVar++
		OLE_SetDocumentVar(oWord,"Cria_Var",cVar)
		If !lJumper
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
		lJumpCab := .F.//Somalinha do Titulo de Relatorio
		OLE_ExecuteMacro(oWord,"Somalinha")


		If ("{" $ _cTitulo) .And.  ("}" $ _cTitulo)
			nPosTemp := At("}",_cTitulo)
			cCNS     := Substr(_cTitulo,1,nPosTemp)
			_cTitulo := Substr(_cTitulo,nPosTemp+1)
		EndIf

		If lIndice
			If ("1" $Upper(cCNS))//Titulo 1
				lCriaIndice := .T.
				OLE_ExecuteMacro(oWord, "Cria_TituloUsuario")
			ElseIf("2" $Upper(cCNS))//2=Titulo 2
				lCriaIndice := .T.
				OLE_ExecuteMacro(oWord, "Cria_TituloUsuario2")
			ElseIf("3" $Upper(cCNS))//2=Titulo 3
				lCriaIndice := .T.
				OLE_ExecuteMacro(oWord, "Cria_TituloUsuario3")
			ElseIf("4" $Upper(cCNS))//2=Titulo 4
				lCriaIndice := .T.
				OLE_ExecuteMacro(oWord, "Cria_TituloUsuario4")
			Else
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
			EndIf
		Else
			OLE_ExecuteMacro(oWord,"Cria_Titulo")
		EndIf

		If ("N" $ Upper(cCNS)) //N=Negrito
			OLE_ExecuteMacro(oWord,"Com_Negrito")
		Else
			OLE_ExecuteMacro(oWord,"Sem_Negrito")
		EndIf

		If ("C" $ Upper(cCNS)) //C=Centralizar
			OLE_ExecuteMacro(oWord,"Centralizar")
		Else
			OLE_ExecuteMacro(oWord,"Justificar")
		EndIf

		If ("S" $ Upper(cCNS)) //S=Sublinhar
			OLE_ExecuteMacro(oWord,"Com_Sublinhar")
		Else
			OLE_ExecuteMacro(oWord,"Sem_Sublinhar")
		EndIf

		OLE_SetDocumentVar(oWord,cVar,_cTitulo)
		If lIndice
			Somalinha()
		EndIf
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} EXEC870TIT
Imprime a tabela relacionada ao título

@return .T., Lógico, sempre verdadeiro

@sample U_EXEC870TIT()

@author	Denis Hyroshi de Souza
@since	25/05/2003
/*/
//---------------------------------------------------------------------
User Function EXEC870TIT(_cTitExe)

	Local cTitExe := _cTitExe, nTipo := 1, cTitTemp, nPos1

	cTitTemp := _cTitExe
	nPos1    := At("!",cTitTemp)
	If nPos1 > 0
		cTitTemp := Alltrim(Substr(cTitTemp,nPos1+1))
		nPos1    := At("!",cTitTemp)
		If nPos1 > 0
			cTitTemp := Substr(cTitTemp,1,nPos1-1)
			nTipo := 2
		EndIf
	EndIf

	If nTipo == 1
		cTitTemp := _cTitExe
		nPos1    := At("%",cTitTemp)
		If nPos1 > 0
			cTitTemp := Alltrim(Substr(cTitTemp,nPos1+1))
			nPos1    := At("%",cTitTemp)
			If nPos1 > 0
				cTitTemp := Substr(cTitTemp,1,nPos1-1)
				nTipo := 3
			EndIf
		EndIf
	EndIf

	Begin Sequence
		If ExistBlock("MDTR8501") //Ponto de Entrada para executar atalhos customizados
			aRetPE := ExecBlock('MDTR8501',.F.,.F., {'2', nModeloImp, cTitExe})
			If ValType(aRetPE) == "A"
				nPosPE := aScan(aRetPE, {|x| Alltrim(x[1]) == Alltrim(cTitExe) .And. Alltrim(cTitExe) == Alltrim(x[1]) })
				If nPosPE > 0
					&(aRetPE[nPosPE,2])
					Break
				EndIf
			EndIf
		EndIf

		If nTipo == 2
			A870IMAGEM(cTitTemp)
		ElseIf nTipo == 3
			A870ARQUIVO(cTitTemp)
		ElseIf "LOCAIS" $ Upper(cTitExe) .Or. "LOCAL" $ Upper(cTitExe)
			U_A870Local()
		ElseIf "RISCO" $ Upper(cTitExe)
			fBusRis()
		ElseIf "FUNCIONARIOS X FUNCAO" $ Upper(cTitExe)
			U_A870FUNFUN()
		ElseIf "LISTA FUNCIONARIOS" $ Upper(cTitExe)
			U_A870LISFUN()
		ElseIf "EQUIPAMENTO" $ Upper(cTitExe)
			U_A870EQUIP()
		ElseIf "CONTROLE" $ Upper(cTitExe)
			U_A870CONTR()
		ElseIf "EXAMES" $ Upper(cTitExe)
			fBusExa()
		ElseIf "SESMT" $ Upper(cTitExe)
			U_A870SESMT()
		ElseIf Upper(cTitExe) $ "PROGRAMA"
			U_A870PROGS()
		ElseIf Upper(cTitExe) $ "PROGRAMACAO VACINAS"
			fA870PRVAC()
		ElseIf "QUADRO FUNCIONARIOS" $ Upper(cTitExe)
			U_A870QUADFUN()
		ElseIf "ACIDENTE" $ Upper( cTitExe )
			f870InfoCat()
			fPrevCentCu()
			fIncCentCu()
		ElseIf "TURNOS" $ Upper(cTitExe)
			U_A870TURNOS()
		ElseIf "ANEXO" $ Upper(cTitExe)
			If "ANEXO-B" $ Upper(cTitExe)
				If !lSigaMdtPS .And. lTN0Depto .And. ;
					( ( nModeloImp == 1 .And. mv_par11 == 2 ) .Or. ( nModeloImp <> 1 .And. mv_par09 == 2 ) )
					U_A870QDRDPT(.F.,.T.) //AnexoA, AnexoB
				Else
				U_A870QUADRO(.F.,.T.) //AnexoA, AnexoB
				EndIf
			Else
				If !lSigaMdtPS .And. lTN0Depto .And. ;
					( ( nModeloImp == 1 .And. mv_par11 == 2 ) .Or. ( nModeloImp <> 1 .And. mv_par09 == 2 ) )
					U_A870QDRDPT(.T.,.F.) //AnexoA, AnexoB
				Else
				U_A870QUADRO(.T.,.F.) //AnexoA, AnexoB
				EndIf
			EndIf
		ElseIf "PAGINA"	$ Upper(cTitExe)
			If nModeloImp == 2
				li := 80
				somalinha()
			ElseIf nModeloImp == 3
				lin := 9999
				somalinha()
			Else
				OLE_ExecuteMacro(oWord,"NewPage")
				lJumpCab := .T.
			EndIf
		ElseIf "PLANO" $ Upper(cTitExe)
			A870PLAN()
		ElseIf "CRONOGRAMA" $ Upper(cTitExe)
			A870CRON()
		ElseIf Upper(cTitExe) $ "REQUISITOS"
			A870REQUIS()
		EndIf
	End Sequence

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} A870Local
Imprime os locais do laudo

@return .T., Lógico, sempre verdadeiro

@sample U_A870Local()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function A870Local()

	Local aArea    	:= GetArea()
	Local cDescAmb	:= ''
	Local i			:= 0
	Local nMarEsq	:= 150 // Margem esquerda mínima
	Local nMarDir	:= 2250 // Margem direita máxima
	Local nMeiLin  	:= 40 // Meio da linha
	Local lPriReg	:= .T. // Primeiro registro

	If lSigaMdtps

		Dbselectarea("TO5")
		Dbsetorder(04)  //TO5_FILIAL+TO5_CLIENT+TO5_LOJA+TO5_LAUDO+TO5_CODAMB
		Dbseek(xFilial("TO5")+cCliMdtps+TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TO5")+cCliMdtps+TO0->TO0_LAUDO == TO5->(TO5_FILIAL+TO5_CLIENT+TO5_LOJA+TO5_LAUDO)
			Dbselectarea("TNE")
			Dbsetorder(3)  //TNE_FILIAL+TNE_CODCLI+TNE_LOJACL+TNE_CODAMB
			If Dbseek( xFilial("TNE")+TO5->(TO5_CLIENT+TO5_LOJA+TO5_CODAMB) )
				lPrint := .T.

				cDescAmb := Alltrim(TNE->TNE_MEMODS)

				If nModeloImp == 2
					lPrimeiro   := .T.
					nTamanho    := 135-Len(STR0174+": ") //"Descricao do Ambiente"
					nLinhasMemo := MLCOUNT(Alltrim(TNE->TNE_NOME),nTamanho)

					For i := 1 To nLinhasMemo
						If lPrimeiro
							@ Li,000 pSay STR0173+": " //"Nome do Ambiente"
							lPrimeiro := .F.
						EndIf
						@ Li,000+Len(STR0174+": ") pSay MemoLine(Alltrim(TNE->TNE_NOME),nTamanho,i)
						Somalinha()
					Next i

					lPrimeiro   := .T.
					nLinhasMemo := MLCOUNT(cDescAmb,nTamanho)

					For i := 1 To nLinhasMemo
						If lPrimeiro
							@ Li,000 pSay STR0174+": " //"Descricao do Ambiente"
							lPrimeiro := .F.
						EndIf
						@ Li,000+Len(STR0174+": ") pSay MemoLine(cDescAmb,nTamanho,i)
						Somalinha()
					Next i

					Somalinha()

				ElseIf nModeloImp == 3
				lPrimeiro   := .T.
				nTamanho    := 120
					nLinhasMemo := MLCOUNT(Alltrim(TNE->TNE_NOME),nTamanho)

					For i := 1 To nLinhasMemo
						If lPrimeiro
							Somalinha()
							oPrintPPRA:Say(lin,150,STR0173+": ",oFont10) //"Nome do Ambiente"
							lPrimeiro := .F.
						EndIf
						oPrintPPRA:Say(lin,600,MemoLine(Alltrim(TNE->TNE_NOME),nTamanho,i),oFont10)
						Somalinha()
					Next i

					lPrimeiro   := .T.
					nLinhasMemo := MLCOUNT(cDescAmb,nTamanho)

					For i := 1 To nLinhasMemo
						If lPrimeiro
							oPrintPPRA:Say(lin,150,STR0174+": ",oFont10) //"Descricao do Ambiente"
							lPrimeiro := .F.
						EndIf
						oPrintPPRA:Say(lin,600,MemoLine(cDescAmb,nTamanho,i),oFont10)
						Somalinha()
					Next i

					Somalinha()

				Else
					////////////// Nome do Ambiente
					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Somalinha")
					OLE_ExecuteMacro(oWord,"Somalinha")
					OLE_ExecuteMacro(oWord,"Cria_Titulo")
					OLE_ExecuteMacro(oWord,"Com_Negrito")
					OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
					OLE_SetDocumentVar(oWord,cVar1,STR0173+":") //"Nome do Ambiente"

					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Cria_Texto")
					OLE_ExecuteMacro(oWord,"Sem_Negrito")
					OLE_ExecuteMacro(oWord,"Alinhar_Descricao")
					OLE_SetDocumentVar(oWord,cVar1, Capital(Alltrim(TNE->TNE_NOME)) )
					OLE_ExecuteMacro(oWord,"Somalinha")

					////////////// Descrição do ambiente
					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Cria_Titulo")
					OLE_ExecuteMacro(oWord,"Com_Negrito")
					OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
					OLE_SetDocumentVar(oWord,cVar1,STR0174+":") //"Descrição do Ambiente"

					cDescAmb := Alltrim(TNE->TNE_MEMODS)

					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Cria_Texto")
					OLE_ExecuteMacro(oWord,"Sem_Negrito")
					OLE_ExecuteMacro(oWord,"Alinhar_Descricao")
					OLE_SetDocumentVar(oWord,cVar1, cDescAmb )
					OLE_ExecuteMacro(oWord,"Somalinha")
					OLE_ExecuteMacro(oWord,"Somalinha")

					OLE_ExecuteMacro(oWord,"Retornar_Alinhamento")
				EndIf
			EndIf

			Dbselectarea("TO5")
			Dbskip()
		End

	Else

		Dbselectarea("TO5")
		Dbsetorder(01)
		Dbseek(xFilial("TO5")+TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TO5")+TO0->TO0_LAUDO == TO5->TO5_FILIAL+TO5->TO5_LAUDO
			Dbselectarea("TNE")
			Dbsetorder(1)
			If Dbseek(xFilial("TNE")+TO5->TO5_CODAMB)
				lPrint := .T.

				cDescAmb := Alltrim(TNE->TNE_MEMODS)

				If nModeloImp == 2
					lPrimeiro   := .T.
					nTamanho    := 135-Len(STR0174+": ") //"Descricao do Ambiente"
					nLinhasMemo := MLCOUNT(Alltrim(TNE->TNE_NOME),nTamanho)

					For i := 1 To nLinhasMemo
						If lPrimeiro
							@ Li,000 pSay STR0173+": " //"Nome do Ambiente"
							lPrimeiro := .F.
						EndIf
						@ Li,000+Len(STR0174+": ") pSay MemoLine(Alltrim(TNE->TNE_NOME),nTamanho,i)
						Somalinha()
					Next i

					lPrimeiro   := .T.
					nLinhasMemo := MLCOUNT(cDescAmb,nTamanho)

					For i := 1 To nLinhasMemo
						If lPrimeiro
							@ Li,000 pSay STR0174+": " //"Descricao do Ambiente"
							lPrimeiro := .F.
						EndIf
						@ Li,000+Len(STR0174+": ") pSay MemoLine(cDescAmb,nTamanho,i)
						Somalinha()
					Next i

					Somalinha()

				ElseIf nModeloImp == 3

					nLinhasMemo := MlCount( cDescAmb, 80 )
					nLinhasMemo := IIf( nLinhasMemo == 0, 1, nLinhasMemo )

					If lin + ( 60 * nLinhasMemo ) > 3000 //Força quebra de pagina se o quadro nao sair na mesma pagina
						lin := 9999
					EndIf

					Somalinha()
					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Line( lin, 1000, lin + 60, 1000 )
					oPrintPPRA:Say( lin + nMeiLin, 400, STR0173, oFont10b ) // "Nome do Ambiente"
					oPrintPPRA:Say( lin + nMeiLin, 1500, STR0174, oFont10b ) // "Descricao do Ambiente"
					Somalinha()
					
					oPrintPPRA:Box( lin, nMarEsq, lin + ( 60 * nLinhasMemo ), nMarDir )
					oPrintPPRA:Line( lin, 1000, lin + ( 60 * nLinhasMemo ), 1000 )
					oPrintPPRA:Say( lin + nMeiLin, 170, Alltrim( TNE->TNE_NOME ), oFont10 )

					For i := 1 To nLinhasMemo

						oPrintPPRA:Say( lin + nMeiLin, 1020, MemoLine( cDescAmb, 80, i ), oFont10 )
						Somalinha()

					Next i

				Else
					////////////// Nome do Ambiente
					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Somalinha")
					OLE_ExecuteMacro(oWord,"Somalinha")
					OLE_ExecuteMacro(oWord,"Cria_Titulo")
					OLE_ExecuteMacro(oWord,"Com_Negrito")
					OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
					OLE_SetDocumentVar(oWord,cVar1,STR0173+":") //"Nome do Ambiente"

					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Cria_Texto")
					OLE_ExecuteMacro(oWord,"Sem_Negrito")
					OLE_ExecuteMacro(oWord,"Alinhar_Descricao")
					OLE_SetDocumentVar(oWord,cVar1, Capital(Alltrim(TNE->TNE_NOME)) )
					OLE_ExecuteMacro(oWord,"Somalinha")

					////////////// Descrição do ambiente
					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Cria_Titulo")
					OLE_ExecuteMacro(oWord,"Com_Negrito")
					OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
					OLE_SetDocumentVar(oWord,cVar1,STR0174+":") //"Descrição do Ambiente"

					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Cria_Texto")
					OLE_ExecuteMacro(oWord,"Sem_Negrito")
					OLE_ExecuteMacro(oWord,"Alinhar_Descricao")
					OLE_SetDocumentVar(oWord,cVar1, cDescAmb )
					OLE_ExecuteMacro(oWord,"Somalinha")

					OLE_ExecuteMacro(oWord,"Retornar_Alinhamento")
				EndIf
			EndIf

			Dbselectarea("TO5")
			Dbskip()
		End

	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} fVerJunRis
Verifica se a pergunta "Imprimir junto ao risco?" foi criada no
dicionário

@author Gabriel Sokacheski
@since 01/11/2023

@param, cPergunta, variável a ser atualizada para compatibilidade
/*/
//-------------------------------------------------------------------
Static Function fVerJunRis( cPergunta )

	If ValType( cPergunta ) == 'N'
		cPergunta := ''
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusRis
Busca os riscos relacionados ao laudo

@author Gabriel Sokacheski
@since 31/10/2023

/*/
//-------------------------------------------------------------------
Static Function fBusRis()

	// Variáveis
	Local aRiscos 		:= {}
	Local aFunExp 		:= {}

	Local bValida 		:= { ||;
		( Empty( TN0->TN0_DTELIM ) .Or. TN0->TN0_DTELIM >= TO0->TO0_DTINIC );
		.And.;
		( Empty( TO0->TO0_DTFIM ) .Or. TN0->TN0_DTAVAL <= TO0->TO0_DTFIM );
	}

	Local cDep 			:= ''
	Local cFonte 		:= ''
	Local cAmbFis 		:= ''
	Local cCenCus 		:= ''
	Local cFuncao 		:= ''
	Local cTarefa 		:= ''
	Local cAgente 		:= ''
	Local cTipoAge 		:= ''
	Local cUnidade 		:= ''
	Local cTipoExp 		:= ''
	Local cImprime 		:= IIf( nModeloImp == 1, mv_par12, mv_par10 )
	Local cLTolNR15 	:= ''
	Local cLTolACGIH 	:= ''
	Local cLTolNHO01 	:= ''

	fVerJunRis( @cImprime )

	DbSelectArea( 'TO1' )
	( 'TO1' )->( DbSetOrder( 1 ) )

	If ( 'TO1' )->( DbSeek( xFilial( 'TO1' ) + TO0->TO0_LAUDO ) )

		While ( 'TO1' )->( !Eof() ) .And. TO1->TO1_FILIAL + TO1->TO1_LAUDO == xFilial( 'TO1' ) + TO0->TO0_LAUDO

			( 'TN0' )->( DbSelectArea( 'TN0' ) )
			( 'TN0' )->( DbSetOrder( 1 ) )

			If ( 'TN0' )->( DbSeek( xFilial( 'TN0' ) + TO1->TO1_NUMRIS ) )

				If TN0->TN0_MAPRIS != '1' .And. Eval( bValida )

					( 'TMA' )->( DbSelectArea( 'TMA' ) )
					( 'TMA' )->( DbSetOrder( 1 ) )

					( 'TMA' )->( MsSeek( xFilial( 'TMA' ) + TN0->TN0_AGENTE ) )

					cAgente 	:= TMA->TMA_NOMAGE
					cTipoAge	:= TMA->TMA_GRISCO

					Do Case

						Case cTipoAge == '1'
							cTipoAge := STR0132  // "Físico"
						Case cTipoAge == '2'
							cTipoAge := STR0133  // "Químico"
						Case cTipoAge == '3'
							cTipoAge := STR0134  // "Biológico"
						Case cTipoAge == '4'
							cTipoAge := STR0135  // "Ergonômico"
						Case cTipoAge == '5'
							cTipoAge := STR0136  // "Acidente"
						Case cTipoAge == '6'
							cTipoAge := STR0240  // "Mecânico"
						Case cTipoAge == '7'
							cTipoAge := STR0241  // "Perigoso"
						Case cTipoAge == '8'
							cTipoAge := STR0295  // "Psicossociais"

					End Case

					cFonte := Posicione( 'TN7', 1, xFilial( 'TN7' ) + TN0->TN0_FONTE, 'TN7_NOMFON' )

					If AllTrim( TN0->TN0_CC ) != '*'
						cCenCus := Posicione( 'CTT', 1, xFilial( 'CTT' ) + TN0->TN0_CC, 'CTT_DESC01' )
					Else
						cCenCus := STR0256 // "Todos"
					EndIf

					If AllTrim( TN0->TN0_CODFUN ) != '*'
						cFuncao := Posicione( 'SRJ', 1, xFilial( 'SRJ' ) + TN0->TN0_CODFUN, 'RJ_DESC' )
					Else
						cFuncao := STR0257 // "Todas"
					EndIf

					If AllTrim( TN0->TN0_CODTAR ) != '*'
						cTarefa := Posicione( 'TN5', 1, xFilial( 'TN5' ) + TN0->TN0_CODTAR, 'TN5_NOMTAR' )
					Else
						cTarefa := STR0257 // "Todas"
					EndIf

					If AllTrim( TN0->TN0_DEPTO ) != '*'
						cDep := Posicione( 'SQB', 1, xFilial( 'SQB' ) + TN0->TN0_DEPTO, 'QB_DESCRIC' )
					Else
						cDep := STR0256 // "Todos"
					EndIf

					cAmbFis := Posicione( 'TNE', 1, xFilial( 'TNE' ) + TN0->TN0_CODAMB, 'TNE_NOME' )

					cUnidade := Posicione( 'V3F', 2, xFilial( 'V3F' ) + TN0->TN0_UNIMED, 'V3F_DESCRI' )

					If Empty( TN0->TN0_INDEXP )
						cTipoExp := AllTrim( Capital( ngRetSx3Box( 'TN0_INDEXP', '3' ) ) )
					Else
						cTipoExp := AllTrim( Capital( ngRetSx3Box( 'TN0_INDEXP', TN0->TN0_INDEXP ) ) )
					EndIf

					cLTolNR15 	:= MDTGetTLim( xFilial( 'TLK' ), TN0->TN0_AGENTE, TN0->TN0_QTAGEN, '1', .T. )
					cLTolACGIH	:= MDTGetTLim( xFilial( 'TLK' ), TN0->TN0_AGENTE, TN0->TN0_QTAGEN, '2', .T. )
					cLTolNHO01	:= MDTGetTLim( xFilial( 'TLK' ), TN0->TN0_AGENTE, TN0->TN0_QTAGEN, '3', .T. )

					aFunExp 	:= fBusExp( '1' $ cImprime )
					aFunNaoExp	:= fBusNaoExp( '2' $ cImprime )

					aAdd( aRiscos, {;
						AllTrim( TN0->TN0_NUMRIS )									,; // Código do risco [1]
						Capital( AllTrim( cAgente ) )								,; // Nome do agente [2]
						AllTrim( cTipoAge )											,; // Tipo do agente [3]
						DtoC( TN0->TN0_DTAVAL )										,; // Data de avaliação [4]
						Capital( AllTrim( cFonte ) )								,; // Nome da fonte [5]
						Capital( AllTrim( cCenCus ) )								,; // Nome do centro de custo [6]
						Capital( AllTrim( cFuncao ) )								,; // Nome da função [7]
						Capital( AllTrim( cTarefa ) )								,; // Nome da tarefa [8]
						Capital( AllTrim( cDep ) )									,; // Nome do departamento [9]
						Capital( AllTrim( cAmbFis ) )								,; // Nome do ambiente fisíco [10]
						Alltrim( Str( TN0->TN0_QTAGEN ) + Space( 1 ) + cUnidade )	,; // Quantidade do agente [11]
						AllTrim( cTipoExp )											,; // Tipo de exposição [12]
						cLTolNR15													,; // Limite de tolerancia NR-15 [13]
						cLTolACGIH													,; // Limite de tolerancia ACGIH [14]
						AllTrim( Str( aFunExp[ 1 ] ) )								,; // Número de funcionários expostos [15]
						AllTrim( Str( aFunNaoExp[ 1 ] ) )							,; // Número de funcionários não expostos [16]
						Mdt180Cla( .T., TN0->TN0_SEVERI, TN0->TN0_PROBAB )			,; // Classificação do risco [17]
						Capital( AllTrim( TO1->TO1_RECOME ) )						,; // Recomendação [18]
						TN0->TN0_SEVERI												,; // Severidade [19]
						TN0->TN0_PROBAB												,; // Probabilidade [20]
						Nil															,; // Lista de atividades [21]
						aFunExp[ 2 ]												,; // Lista de funcionários expostos [22]
						aFunNaoExp[ 2 ]												,; // Lista de funcionários não expostos [23]
						Nil															,; // Lista de planos de ação [24]
						cLTolNHO01                                                  ;  // Limite de tolerancia NHO-01 [25]
					} )

				EndIf

			EndIf

			( 'TO1' )->( dbSkip() )

		End

	EndIf

	If Len( aRiscos ) > 0
		fImpRis( aRiscos )
	Else

		If nModeloImp == 1

			OLE_SetDocumentVar( oWord, 'titulo', STR0255 ) // "Risco"
			OLE_SetDocumentVar( oWord, 'texto', STR0276 + '.' ) // "Não existem riscos válidos vinculados ao laudo"

			OLE_ExecuteMacro( oWord, 'aviso' )

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpRis
Imprime os riscos relacionados ao laudo

@author Gabriel Sokacheski
@since 01/11/2023

@param, aRiscos, riscos a serem impressos

/*/
//-------------------------------------------------------------------
Static Function fImpRis( aRiscos )

	Local cLista 	:= ''
	Local cImprime 	:= IIf( nModeloImp == 1, mv_par12, mv_par10 )
	Local cTitulos 	:= ''

	Local nMemo 	:= 0
	Local nRisco 	:= 0
	Local nLinha 	:= 0
	Local nMarEsq 	:= 150
	Local nMarDir 	:= 2250
	Local nMeiLin	:= 40

	fVerJunRis( @cImprime )

	If nModeloImp == 1

		cTitulos += STR0030 + '#' 		// "Agente:"
		cTitulos += STR0255 + ':' + '#' // "Risco"
		cTitulos += STR0037 + '#' 		// "Data de Avaliação:"
		cTitulos += STR0224 + ':' + '#'	// "Fonte Geradora"
		cTitulos += STR0032 + '#' 		// "Centro de Custo:"
		cTitulos += STR0034 + '#' 		// "Função:"
		cTitulos += STR0035 + '#' 		// "Tarefa:"
		cTitulos += STR0238 + '#' 		// "Departamento:"
		cTitulos += STR0223 + ':' + '#' // "Ambiente"
		cTitulos += STR0038 + '#' 		// "Quantidade do Agente de Risco:"
		cTitulos += STR0252 + '#' 		// "Tipo de Exposição:"
		cTitulos += STR0277 + ':' + '#' // "Limite de tolerância NR-15"
		cTitulos += STR0278 + ':' + '#' // "Limite de tolerância ACGIH"
		cTitulos += STR0290 + ':' + '#' // "Limite de tolerância NHO-01"
		cTitulos += STR0279 + ':' + '#' // "Funcionários Expostos"
		cTitulos += STR0253 + ':' + '#' // "Funcionários não expostos"
		cTitulos += STR0280 + ':' + '#' // "Classificação"
		cTitulos += STR0039 + '#' 		// "Recomendação:"

		OLE_SetDocumentVar( oWord, 'titulos_risco', cTitulos )
		OLE_SetDocumentVar( oWord, 'opcao_matriz', 1 )

		For nRisco := 1 To Len( aRiscos )

			cLista += STR0255 + ' - ' + aRiscos[ nRisco, 1 ] + '@'	// "Risco"
			cLista += aRiscos[ nRisco, 2 ] + '#' 					// "Agente:"
			cLista += aRiscos[ nRisco, 3 ] + '#' 					// "Risco:"
			cLista += aRiscos[ nRisco, 4 ] + '#' 					// "Data de Avaliação:"
			cLista += aRiscos[ nRisco, 5 ] + '#' 					// "Fonte Geradora"
			cLista += aRiscos[ nRisco, 6 ] + '#' 					// "Centro de Custo:"
			cLista += aRiscos[ nRisco, 7 ] + '#' 					// "Função:"
			cLista += aRiscos[ nRisco, 8 ] + '#' 					// "Tarefa:"
			cLista += aRiscos[ nRisco, 9 ] + '#' 					// "Departamento:"
			cLista += aRiscos[ nRisco, 10 ] + '#' 					// "Ambiente"
			cLista += aRiscos[ nRisco, 11 ] + '#' 					// "Quantidade do Agente de Risco:"
			cLista += aRiscos[ nRisco, 12 ] + '#' 					// "Tipo de Exposição:"
			cLista += aRiscos[ nRisco, 13 ] + '#' 					// "Limite de tolerância NR-15:"
			cLista += aRiscos[ nRisco, 14 ] + '#' 					// "Limite de tolerância ACGIH:"
			cLista += aRiscos[ nRisco, 25 ] + '#' 					// "Limite de tolerância NHO-01:"
			cLista += aRiscos[ nRisco, 15 ] + '#' 					// "Funcionários Expostos:"
			cLista += aRiscos[ nRisco, 16 ] + '#' 					// "Funcionários não expostos"
			cLista += aRiscos[ nRisco, 17 ] + '#' 					// "Classificação:"
			cLista += aRiscos[ nRisco, 18 ] + '#' 					// "Recomendação:"

			OLE_SetDocumentVar( oWord, 'risco', cLista )
			OLE_ExecuteMacro( oWord, 'risco' )

			cLista := ''

			If '1' $ cImprime
				fImpExp( aRiscos[ nRisco, 22 ] )
			EndIf

			If '2' $ cImprime
				fImpNaoExp( aRiscos[ nRisco, 23 ] )
			EndIf

		Next nRisco

	ElseIf nModeloImp == 2

		For nRisco := 1 To Len( aRiscos )

			SomaLinha()
			@ Li, 60 PSay STR0255 + ' - ' + aRiscos[ nRisco, 1 ] // "Risco"

			SomaLinha()
			@ Li, 0 PSay STR0030 + Space( 1 ) + aRiscos[ nRisco, 2 ] // "Agente:"

			SomaLinha()
			@ Li, 0 PSay STR0255 + ':' + Space( 1 ) + aRiscos[ nRisco, 3 ] // "Risco"

			SomaLinha()
			@ Li, 0 PSay STR0037 + Space( 1 ) + aRiscos[ nRisco, 4 ] // "Data de avaliação:"

			SomaLinha()
			@ Li, 0 PSay STR0224 + ':' + Space( 1 ) + aRiscos[ nRisco, 5 ] // "Fonte geradora"

			SomaLinha()
			@ Li, 0 PSay STR0032 + Space( 1 ) + aRiscos[ nRisco, 6 ] // "Centro de custo:"

			SomaLinha()
			@ Li, 0 PSay STR0034 + Space( 1 ) + aRiscos[ nRisco, 7 ] // "Função:"

			SomaLinha()
			@ Li, 0 PSay STR0035 + Space( 1 ) + aRiscos[ nRisco, 8 ] // "Tarefa:"

			SomaLinha()
			@ Li, 0 PSay STR0238 + Space( 1 ) + aRiscos[ nRisco, 9 ] // "Departamento:"

			SomaLinha()
			@ Li, 0 PSay STR0223 + ':' + Space( 1 ) + aRiscos[ nRisco, 10 ] // "Ambiente:"

			SomaLinha()
			@ Li, 0 PSay STR0038 + Space( 1 ) + aRiscos[ nRisco, 11 ] // "Quantidade de agente do risco:"

			SomaLinha()
			@ Li, 0 PSay STR0252 + Space( 1 ) + aRiscos[ nRisco, 12 ] // "Tipo de exposição:"

			SomaLinha()
			@ Li, 0 PSay STR0277 + ':' + Space( 1 ) + aRiscos[ nRisco, 13 ] // "Limite de tolerância NR-15:"

			SomaLinha()
			@ Li, 0 PSay STR0278 + ':' + Space( 1 ) + aRiscos[ nRisco, 14 ] // "Limite de tolerância ACGIH:"

			SomaLinha()
			@ Li, 0 PSay STR0290 + ':' + Space( 1 ) + aRiscos[ nRisco, 25 ] // "Limite de tolerância NHO-01:"

			SomaLinha()
			@ Li, 0 PSay STR0279 + ':' + Space( 1 ) + aRiscos[ nRisco, 15 ] // "Funcionários expostos:"

			SomaLinha()
			@ Li, 0 PSay STR0253 + ':' + Space( 1 ) + aRiscos[ nRisco, 16 ] // "Funcionários não expostos:"

			SomaLinha()
			@ Li, 0 PSay STR0280 + Space( 1 ) + aRiscos[ nRisco, 17 ] // "Classificação:"

			SomaLinha()
			nMemo := MlCount( aRiscos[ nRisco, 18 ], 120 )
			@ Li, 0 PSay STR0039 // "Recomendação:"

			SomaLinha()

			For nLinha := 1 To nMemo

				If nLinha != 1
					SomaLinha()
				EndIf

				@ Li, 0 PSay MemoLine( aRiscos[ nRisco, 18 ], 120, nLinha )

			Next nMemo

			SomaLinha()

			If '1' $ cImprime
				fImpExp( aRiscos[ nRisco, 22 ] )
			EndIf

			If '2' $ cImprime
				fImpNaoExp( aRiscos[ nRisco, 23 ] )
			EndIf

		Next nRisco

	Else

		For nRisco := 1 To Len( aRiscos )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 1200, STR0255 + ' - ' + aRiscos[ nRisco, 1 ], oFont10b ) // "Risco"

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0030, oFont10b ) // "Agente:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 2 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0255 + ':', oFont10b ) // "Risco:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 3 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0037, oFont10b ) // "Data de avaliação:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 4 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0224 + ':', oFont10b ) // "Fonte geradora:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 5 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0032, oFont10b ) // "Centro de custo:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 6 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0034, oFont10b ) // "Função:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 7 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0035, oFont10b ) // "Tarefa:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 8 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0238, oFont10b ) // "Departamento:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 9 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0223 + ':', oFont10b ) // "Ambiente"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 10 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0038, oFont10b ) // "Quantidade de agente do risco:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 11 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0252, oFont10b ) // "Tipo de exposição:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 12 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0277 + ':', oFont10b ) // "Limite de tolerância NR-nMeiLin:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 13 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0278 + ':', oFont10b ) // "Limite de tolerância ACGIH:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 14 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0290 + ':', oFont10b ) // "Limite de tolerância NHO-01:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 25 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0279 + ':', oFont10b ) // "Funcionários expostos:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 15 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0253 + ':', oFont10b ) // "Funcionários não expostos:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 16 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Box( lin, 870, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0280 + ':', oFont10b ) // "Classificação:"
			oPrintPPRA:Say( lin + nMeiLin, 900, aRiscos[ nRisco, 17 ], oFont10 )

			SomaLinha()
			nMemo := MlCount( aRiscos[ nRisco, 18 ], 110 )
			oPrintPPRA:Box( lin, nMarEsq, lin + ( 60 * nMemo ) + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 170, STR0039, oFont10b ) // "Recomendação:"

			SomaLinha()

			For nLinha := 1 To nMemo

				If nLinha != 1
					SomaLinha()
				EndIf

				oPrintPPRA:Say(lin + nMeiLin, 170, MemoLine( aRiscos[ nRisco, 18 ], 110, nLinha ), oFont10 )

			Next nMemo

			SomaLinha()

			If '1' $ cImprime
				fImpExp( aRiscos[ nRisco, 22 ] )
			EndIf

			If '2' $ cImprime
				fImpNaoExp( aRiscos[ nRisco, 23 ] )
			EndIf

		Next nRisco

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusExp
Busca os funcionários expostos ao Risco

@author	Gabriel Sokacheski
@since 01/11/2023

@param lImprime, indica se deve montar a lista com os nomes dos
funcionários

@return aExp, quantidade e a lista dos funcionários expostos
/*/
//-------------------------------------------------------------------
Static Function fBusExp( lImprime )

	Local aExp 		:= {}

	Local cCenCus 	:= TN0->TN0_CC
	Local cFuncao 	:= TN0->TN0_CODFUN
	Local cTarefa 	:= TN0->TN0_CODTAR
	Local cDepart 	:= TN0->TN0_DEPTO
	Local cAliasFun	:= GetNextAlias()

	Local dAva 		:= TN0->TN0_DTAVAL
	Local dEli 		:= TN0->TN0_DTELIM

	Local nFun 		:= 0

	BeginSQL Alias cAliasFun

		SELECT 
			COUNT( SRA.RA_MAT ) AS QTDFUN
		FROM 
			%table:SRA% SRA
				LEFT JOIN %table:TN6% TN6 ON
					SRA.RA_MAT = TN6.TN6_MAT
					AND TN6.TN6_FILIAL = %xFilial:TN6%
					AND (
						( TN6.TN6_DTTERM = '' AND %exp:dEli% = '' )
						OR (
							TN6.TN6_DTTERM != '' AND %exp:dEli% != ''
							AND NOT(
								( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
								OR ( TN6.TN6_DTINIC > %exp:dEli% AND TN6.TN6_DTTERM > %exp:dEli% )
							)
						)
						OR (
							TN6.TN6_DTTERM != ''
							AND %exp:dEli% = ''
							AND NOT( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
						)
						OR (
							TN6.TN6_DTTERM = ''
							AND %exp:dEli% != ''
							AND NOT( %exp:dAva% < TN6.TN6_DTINIC AND %exp:dEli% < TN6.TN6_DTINIC )
						)
					)
					AND TN6.TN6_DTINIC <= %exp:dAteLaudo%
					AND TN6.%NotDel%
		WHERE
			SRA.RA_FILIAL = %xFilial:SRA%
			AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
			AND SRA.RA_ADMISSA <= %exp:dAteLaudo%
			AND ( SRA.RA_ADMISSA <= %exp:dEli% OR %exp:dEli% = '' )
			AND ( %exp:cCenCus% = '*' OR SRA.RA_CC = %exp:cCenCus% )
			AND ( %exp:cFuncao% = '*' OR SRA.RA_CODFUNC = %exp:cFuncao% )
			AND ( %exp:cDepart% = '*' OR SRA.RA_DEPTO = %exp:cDepart% )
			AND ( %exp:cTarefa% = '*' OR TN6.TN6_CODTAR = %exp:cTarefa% )
			AND SRA.%NotDel%

	EndSQL

	DbSelectArea( cAliasFun )
		( cAliasFun )->( DbGoTop() )

	If ( cAliasFun )->( !Eof() )
		nFun := ( cAliasFun )->( QTDFUN )
	EndIf

	( cAliasFun )->( dbCloseArea() )

	If lImprime

		cAliasFun := GetNextAlias()

		BeginSQL Alias cAliasFun

			SELECT 
				SRA.RA_MAT, SRA.RA_NOME
			FROM 
				%table:SRA% SRA
					LEFT JOIN %table:TN6% TN6 ON
						SRA.RA_MAT = TN6.TN6_MAT
						AND TN6.TN6_FILIAL = %xFilial:TN6%
						AND (
							( TN6.TN6_DTTERM = '' AND %exp:dEli% = '' )
							OR (
								TN6.TN6_DTTERM != '' AND %exp:dEli% != ''
								AND NOT(
									( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
									OR ( TN6.TN6_DTINIC > %exp:dEli% AND TN6.TN6_DTTERM > %exp:dEli% )
								)
							)
							OR (
								TN6.TN6_DTTERM != ''
								AND %exp:dEli% = ''
								AND NOT( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
							)
							OR (
								TN6.TN6_DTTERM = ''
								AND %exp:dEli% != ''
								AND NOT( %exp:dAva% < TN6.TN6_DTINIC AND %exp:dEli% < TN6.TN6_DTINIC )
							)
						)
						AND TN6.TN6_DTINIC <= %exp:dAteLaudo%
						AND TN6.%NotDel%
			WHERE
				SRA.RA_FILIAL = %xFilial:SRA%
				AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
				AND SRA.RA_ADMISSA <= %exp:dAteLaudo%
				AND ( SRA.RA_ADMISSA <= %exp:dEli% OR %exp:dEli% = '' )
				AND ( %exp:cCenCus% = '*' OR SRA.RA_CC = %exp:cCenCus% )
				AND ( %exp:cFuncao% = '*' OR SRA.RA_CODFUNC = %exp:cFuncao% )
				AND ( %exp:cDepart% = '*' OR SRA.RA_DEPTO = %exp:cDepart% )
				AND ( %exp:cTarefa% = '*' OR TN6.TN6_CODTAR = %exp:cTarefa% )
				AND SRA.%NotDel%
			GROUP BY SRA.RA_MAT, SRA.RA_NOME
			ORDER BY SRA.RA_MAT

		EndSQL

		DbSelectArea( cAliasFun )
		( cAliasFun )->( DbGoTop() )

		While ( cAliasFun )->( !Eof() )

			aAdd( aExp, {;
				AllTrim( RA_MAT ),;
				Capital( AllTrim( RA_NOME ) );
			} )

			( cAliasFun )->( dbSkip() )

		End

		( cAliasFun )->( dbCloseArea() )

	EndIf

Return { nFun, aExp }

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpExp
Imprime os funcionários expostos ao Risco

@author Gabriel Sokacheski
@since 08/11/2023

@param, aExp, array, contendo os expostos ao risco
/*/
//-------------------------------------------------------------------
Static Function fImpExp( aExp )

	Local cLista	:= ''

	Local nFun 		:= 0
	Local nExp 		:= Len( aExp )
	Local nMarEsq 	:= 150
	Local nMarDir 	:= 2250
	Local nMeiLin	:= 40

	If nExp > 0

		If nModeloImp == 1

			cLista += STR0279 + '@' // "Funcionários Expostos"
			cLista += STR0090 + '#' // "Matrícula"
			cLista += STR0079 + '#' // "Nome"

			For nFun := 1 To nExp
				cLista += aExp[ nFun, 1 ] + '$'
				cLista += aExp[ nFun, 2 ] + '$'
			Next

			OLE_SetDocumentVar( oWord, 'funcionarios_expostos', cLista )
			OLE_SetDocumentVar( oWord, 'numero_funcionarios_expostos', nExp )
			OLE_ExecuteMacro( oWord, 'expostos' )

		ElseIf nModeloImp == 2

			SomaLinha()
			@ Li, 55 PSay STR0279 // "Funcionários Expostos"

			SomaLinha()

			For nFun := 1 To nExp

				@ Li, 0 PSay aExp[ nFun, 1 ] + ' - ' + aExp[ nFun, 2 ]

				SomaLinha()

			Next

			SomaLinha()

		Else

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 1100, STR0279, oFont10b ) // "Funcionários Expostos"

			SomaLinha()

			For nFun := 1 To nExp

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Box( lin, 500, lin + 60, nMarDir )
				oPrintPPRA:Say( lin + nMeiLin, 170, aExp[ nFun, 1 ], oFont10 )
				oPrintPPRA:Say( lin + nMeiLin, 520, aExp[ nFun, 2 ], oFont10 )

				SomaLinha()

			Next

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusNaoExp
Busca os funcionários não expostos ao Risco

@author	Gabriel Sokacheski
@since 01/11/2023

@param lImprime, indica se deve montar a lista com os nomes dos
funcionários

@return aExp, quantidade e a lista dos funcionários não expostos
/*/
//-------------------------------------------------------------------
Static Function fBusNaoExp( lImprime )

	Local aNaoExp 	:= {}

	Local cCenCus 	:= TN0->TN0_CC
	Local cFuncao 	:= TN0->TN0_CODFUN
	Local cTarefa 	:= TN0->TN0_CODTAR
	Local cDepart 	:= TN0->TN0_DEPTO
	Local cAliasFun	:= GetNextAlias()

	Local dAva 		:= TN0->TN0_DTAVAL
	Local dEli 		:= TN0->TN0_DTELIM

	Local nFun 		:= 0

	BeginSQL Alias cAliasFun

			SELECT
				COUNT( SRA.RA_MAT ) AS QTDFUN
			FROM
				%table:SRA% SRA
			WHERE
				SRA.RA_FILIAL = %xFilial:SRA%
				AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
				AND SRA.RA_ADMISSA < %exp:dAteLaudo%
				AND SRA.%NotDel%
				AND SRA.RA_MAT NOT IN (
					SELECT 
						SRA.RA_MAT
					FROM 
						%table:SRA% SRA
							LEFT JOIN %table:TN6% TN6 ON
								SRA.RA_MAT = TN6.TN6_MAT
								AND TN6.TN6_FILIAL = %xFilial:TN6%
								AND (
									( TN6.TN6_DTTERM = '' AND %exp:dEli% = '' )
									OR (
										TN6.TN6_DTTERM != '' AND %exp:dEli% != ''
										AND NOT(
											( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
											OR ( TN6.TN6_DTINIC > %exp:dEli% AND TN6.TN6_DTTERM > %exp:dEli% )
										)
									)
									OR (
										TN6.TN6_DTTERM != ''
										AND %exp:dEli% = ''
										AND NOT( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
									)
									OR (
										TN6.TN6_DTTERM = ''
										AND %exp:dEli% != ''
										AND NOT( %exp:dAva% < TN6.TN6_DTINIC AND %exp:dEli% < TN6.TN6_DTINIC )
									)
								)
								AND TN6.TN6_DTINIC <= %exp:dAteLaudo%
								AND TN6.%NotDel%
					WHERE
						SRA.RA_FILIAL = %xFilial:SRA%
						AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
						AND SRA.RA_ADMISSA <= %exp:dAteLaudo%
						AND ( SRA.RA_ADMISSA <= %exp:dEli% OR %exp:dEli% = '' )
						AND ( %exp:cCenCus% = '*' OR SRA.RA_CC = %exp:cCenCus% )
						AND ( %exp:cFuncao% = '*' OR SRA.RA_CODFUNC = %exp:cFuncao% )
						AND ( %exp:cDepart% = '*' OR SRA.RA_DEPTO = %exp:cDepart% )
						AND ( %exp:cTarefa% = '*' OR TN6.TN6_CODTAR = %exp:cTarefa% )
						AND SRA.%NotDel%
					GROUP BY SRA.RA_MAT
				)

		EndSQL

		DbSelectArea( cAliasFun )
		( cAliasFun )->( DbGoTop() )

		If ( cAliasFun )->( !Eof() )
			nFun := ( cAliasFun )->( QTDFUN )
		EndIf

	( cAliasFun )->( dbCloseArea() )

	If lImprime

		cAliasFun := GetNextAlias()

		BeginSQL Alias cAliasFun

			SELECT
				SRA.RA_MAT, SRA.RA_NOME
			FROM
				%table:SRA% SRA
			WHERE
				SRA.RA_FILIAL = %xFilial:SRA%
				AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
				AND SRA.RA_ADMISSA < %exp:dAteLaudo%
				AND SRA.%NotDel%
				AND SRA.RA_MAT NOT IN (
					SELECT 
						SRA.RA_MAT
					FROM 
						%table:SRA% SRA
							LEFT JOIN %table:TN6% TN6 ON
								SRA.RA_MAT = TN6.TN6_MAT
								AND TN6.TN6_FILIAL = %xFilial:TN6%
								AND (
									( TN6.TN6_DTTERM = '' AND %exp:dEli% = '' )
									OR (
										TN6.TN6_DTTERM != '' AND %exp:dEli% != ''
										AND NOT(
											( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
											OR ( TN6.TN6_DTINIC > %exp:dEli% AND TN6.TN6_DTTERM > %exp:dEli% )
										)
									)
									OR (
										TN6.TN6_DTTERM != ''
										AND %exp:dEli% = ''
										AND NOT( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
									)
									OR (
										TN6.TN6_DTTERM = ''
										AND %exp:dEli% != ''
										AND NOT( %exp:dAva% < TN6.TN6_DTINIC AND %exp:dEli% < TN6.TN6_DTINIC )
									)
								)
								AND TN6.TN6_DTINIC <= %exp:dAteLaudo%
								AND TN6.%NotDel%
					WHERE
						SRA.RA_FILIAL = %xFilial:SRA%
						AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
						AND SRA.RA_ADMISSA <= %exp:dAteLaudo%
						AND ( SRA.RA_ADMISSA <= %exp:dEli% OR %exp:dEli% = '' )
						AND ( %exp:cCenCus% = '*' OR SRA.RA_CC = %exp:cCenCus% )
						AND ( %exp:cFuncao% = '*' OR SRA.RA_CODFUNC = %exp:cFuncao% )
						AND ( %exp:cDepart% = '*' OR SRA.RA_DEPTO = %exp:cDepart% )
						AND ( %exp:cTarefa% = '*' OR TN6.TN6_CODTAR = %exp:cTarefa% )
						AND SRA.%NotDel%
					GROUP BY SRA.RA_MAT
				)
			GROUP BY SRA.RA_MAT, SRA.RA_NOME
			ORDER BY SRA.RA_MAT

		EndSQL

		DbSelectArea( cAliasFun )
		( cAliasFun )->( DbGoTop() )

		While ( cAliasFun )->( !Eof() )

			aAdd( aNaoExp, {;
				AllTrim( ( cAliasFun )->RA_MAT ),;
				Capital( AllTrim( ( cAliasFun )->RA_NOME ) );
			} )

			( cAliasFun )->( dbSkip() )

		End

		( cAliasFun )->( dbCloseArea() )

	EndIf

Return { nFun, aNaoExp }

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpNaoExp
Imprime os funcionários não expostos ao Risco

@author Gabriel Sokacheski
@since 08/11/2023

@param, aNaoExp, array, contendo os não expostos ao risco
/*/
//-------------------------------------------------------------------
Static Function fImpNaoExp( aNaoExp )

	Local cLista 	:= ''

	Local nFun 		:= 0 // Controlador do for
	Local nVezes	:= 1 // Quantidade de vezes que a macro foi executada novamente
	Local nNaoExp 	:= Len( aNaoExp ) // Quantidade total de funcionários a ser impressa
	Local nLimite 	:= 500 // Limite de registros impressos por vez
	Local nRegImp 	:= IIf( nNaoExp > nLimite, nLimite, nNaoExp ) // Número de registros que será impresso na vez
	Local nTotalFun := nNaoExp // Total de funcionários
	Local nVezesImp	:= 1 // Controlador do while
	Local nMarEsq 	:= 150
	Local nMarDir 	:= 2250
	Local nMeiLin	:= 40

	If nNaoExp > 0

		If nModeloImp == 1

			cLista += STR0253 + '@' // "Funcionários não expostos"
			cLista += STR0090 + '#' // "Matrícula"
			cLista += STR0079 + '#' // "Nome"

			For nFun := 1 To nRegImp
				cLista += aNaoExp[ nFun, 1 ] + '$'
				cLista += aNaoExp[ nFun, 2 ] + '$'
			Next

			OLE_SetDocumentVar( oWord, 'funcionarios_nao_expostos', cLista )
			OLE_SetDocumentVar( oWord, 'numero_funcionarios_nao_expostos', nNaoExp )
			OLE_SetDocumentVar( oWord, 'limite_funcionarios_nao_expostos', nLimite )
			OLE_ExecuteMacro( oWord, 'nao_expostos' )

			nNaoExp -= nLimite

			While nNaoExp > 0

				cLista := ''

				nFun := ( nLimite * nVezes + 1 )
				nRegImp := nTotalFun - ( nLimite * nVezes )
				nVezesImp := 1

				While nVezesImp <= nRegImp .And. nVezesImp <= nNaoExp

					cLista += aNaoExp[ nFun, 1 ] + '$'
					cLista += aNaoExp[ nFun, 2 ] + '$'

					nFun++
					nVezesImp++

				End

				nVezes += 1

				OLE_SetDocumentVar( oWord, 'funcionarios_nao_expostos', cLista )
				OLE_SetDocumentVar( oWord, 'numero_funcionarios_nao_expostos', nNaoExp )
				OLE_SetDocumentVar( oWord, 'limite_funcionarios_nao_expostos', nLimite )
				OLE_ExecuteMacro( oWord, 'nao_expostos_continuacao' )

				nNaoExp -= nLimite

			End

		ElseIf nModeloImp == 2

			SomaLinha()
			@ Li, 55 PSay STR0253  // "Funcionários não expostos"

			SomaLinha()

			For nFun := 1 To nNaoExp

				@ Li, 0 PSay aNaoExp[ nFun, 1 ] + ' - ' + aNaoExp[ nFun, 2 ]

				SomaLinha()

			Next

			SomaLinha()

		Else

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 1100, STR0253, oFont10b ) // "Funcionários não expostos"

			SomaLinha()

			For nFun := 1 To nNaoExp

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Box( lin, 500, lin + 60, nMarDir )
				oPrintPPRA:Say( lin + nMeiLin, 170, aNaoExp[ nFun, 1 ], oFont10 )
				oPrintPPRA:Say( lin + nMeiLin, 520, aNaoExp[ nFun, 2 ], oFont10 )

				SomaLinha()

			Next

		EndIf

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} A870EQUIP
Imprime os equipamentos do laudo

@return .T., Lógico, sempre verdadeiro

@sample U_A870EQUIP()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function A870EQUIP()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local _1st := .T.

	If lSigaMdtps

		Dbselectarea("TO2")
		Dbsetorder(03)  //TO2_FILIAL+TO2_CLIENT+TO2_LOJA+TO2_LAUDO+TO2_EQPTO
		Dbseek(xFilial("TO2")+cCliMdtps+TO0->TO0_LAUDO)

		While !eof() .And. xFilial("TO2")+cCliMdtps+TO0->TO0_LAUDO == TO2->(TO2_FILIAL+TO2_CLIENT+TO2_LOJA+TO2_LAUDO)
			Dbselectarea("TM7")
			Dbsetorder(1)
			If Dbseek(xFilial("TM7")+TO2->TO2_EQPTO)
				nRegs++
				If nModeloImp == 2
					If _1st
						Somalinha()
						@ Li,000 Psay STR0040 //"Equipamentos:  Nome                           Fabricante            Data Calibração  Data Aferição"
						_1st := .F.
					EndIf
					Somalinha()
					@ Li,015 Psay Substr(TM7->TM7_NOEQTO,1,28)
					@ Li,046 Psay Substr(TM7->TM7_NOMFAB,1,19)
					@ Li,068 Psay TM7->TM7_DTCALI
					@ Li,085 Psay TM7->TM7_DTAFER
				ElseIf nModeloImp == 3
					If _1st
						Somalinha()
						oPrintPPRA:Say(lin,200,STR0078+":",oFont12b) //"Equipamentos"
						oPrintPPRA:Say(lin,550,STR0079,oFont10b) //"Nome"
						oPrintPPRA:Say(lin,1200,STR0080,oFont10b) //"Fabricante"
						oPrintPPRA:Say(lin,1670,STR0081,oFont10b) //"Data Calibração"
						oPrintPPRA:Say(lin,2000,STR0082,oFont10b) //"Data Aferição"
						_1st := .F.
					EndIf
					Somalinha()
					oPrintPPRA:Say(lin,550,Substr(TM7->TM7_NOEQTO,1,28),oFont08)
					oPrintPPRA:Say(lin,1200,Substr(TM7->TM7_NOMFAB,1,19),oFont08)
					oPrintPPRA:Say(lin,1670,DtoC(TM7->TM7_DTCALI),oFont08)
					oPrintPPRA:Say(lin,2000,DtoC(TM7->TM7_DTAFER),oFont08)
				Else
					cMemo += Alltrim(TM7->TM7_NOEQTO)+"#*"
					cMemo += Alltrim(TM7->TM7_NOMFAB)+"#*"
					cMemo += If(!Empty(TM7->TM7_DTCALI),DTOC(TM7->TM7_DTCALI),"__/__/__")+"#*"
					cMemo += If(!Empty(TM7->TM7_DTAFER),DTOC(TM7->TM7_DTAFER),"__/__/__")+"#*"
				EndIf
			EndIf
			Dbselectarea("TO2")
			Dbskip()
		End

	Else

		Dbselectarea("TO2")
		Dbsetorder(01)
		Dbseek(xFilial("TO2")+TO0->TO0_LAUDO)

		While !eof() .And. xFilial("TO2")+TO0->TO0_LAUDO == TO2->TO2_FILIAL+TO2->TO2_LAUDO
			Dbselectarea("TM7")
			Dbsetorder(1)
			If Dbseek(xFilial("TM7")+TO2->TO2_EQPTO)
				nRegs++
				If nModeloImp == 2
					If _1st
						Somalinha()
						@ Li,000 Psay STR0040 //"Equipamentos:  Nome                           Fabricante            Data Calibração  Data Aferição"
						_1st := .F.
					EndIf
					Somalinha()
					@ Li,015 Psay Substr(TM7->TM7_NOEQTO,1,28)
					@ Li,046 Psay Substr(TM7->TM7_NOMFAB,1,19)
					@ Li,068 Psay TM7->TM7_DTCALI
					@ Li,085 Psay TM7->TM7_DTAFER
				ElseIf nModeloImp == 3
					If _1st
						Somalinha()
						oPrintPPRA:Say(lin,200,STR0078+":",oFont12b) //"Equipamentos"
						oPrintPPRA:Say(lin,550,STR0079,oFont10b) //"Nome"
						oPrintPPRA:Say(lin,1200,STR0080,oFont10b) //"Fabricante"
						oPrintPPRA:Say(lin,1670,STR0081,oFont10b) //"Data Calibração"
						oPrintPPRA:Say(lin,2000,STR0082,oFont10b) //"Data Aferição"
						_1st := .F.
					EndIf
					Somalinha()
					oPrintPPRA:Say(lin,550,Substr(TM7->TM7_NOEQTO,1,28),oFont08)
					oPrintPPRA:Say(lin,1200,Substr(TM7->TM7_NOMFAB,1,19),oFont08)
					oPrintPPRA:Say(lin,1670,DtoC(TM7->TM7_DTCALI),oFont08)
					oPrintPPRA:Say(lin,2000,DtoC(TM7->TM7_DTAFER),oFont08)
				Else
					cMemo += Alltrim(TM7->TM7_NOEQTO)+"#*"
					cMemo += Alltrim(TM7->TM7_NOMFAB)+"#*"
					cMemo += If(!Empty(TM7->TM7_DTCALI),DTOC(TM7->TM7_DTCALI),"__/__/__")+"#*"
					cMemo += If(!Empty(TM7->TM7_DTAFER),DTOC(TM7->TM7_DTAFER),"__/__/__")+"#*"
				EndIf
			EndIf
			Dbselectarea("TO2")
			Dbskip()
		End

	EndIf

	If nRegs > 0 .And. nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_Equipamentos")
	EndIf

	If nRegs > 0 .And. nModeloImp == 2
		Somalinha()
	EndIf

	RestArea(aArea)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} A870CONTR
Imprime as medidas de controle do laudo

@return .T., Lógico, sempre verdadeiro

@sample U_A870CONTR()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function A870CONTR()

	Local aArea := GetArea()

	If lSigaMdtps

		Dbselectarea("TO3")
		Dbsetorder(03)  //TO3_FILIAL+TO3_CLIENT+TO3_LOJA+TO3_LAUDO+TO3_CONTRO
		Dbseek(xFilial("TO3")+cCliMdtps+TO0->TO0_LAUDO)

		While !eof() .And. xFilial("TO3")+cCliMdtps+TO0->TO0_LAUDO == TO3->(TO3_FILIAL+TO3_CLIENT+TO3_LOJA+TO3_LAUDO)
			Dbselectarea("TO4")
			Dbsetorder(1)
			If Dbseek(xFilial("TO4")+TO3->TO3_CONTRO)
				lPrint := .T.
				U_IMPCAB870(Alltrim(TO4->TO4_NOMCTR))
				If !Empty(TO3->TO3_DESCRI)
					U_IMPTXT870(Alltrim(TO3->TO3_DESCRI))
				EndIf
				Somalinha()
			EndIf
			Dbselectarea("TO3")
			Dbskip()
		End
		RestArea(aArea)

	Else

		Dbselectarea("TO3")
		Dbsetorder(01)
		Dbseek(xFilial("TO3")+TO0->TO0_LAUDO)

		While !eof() .And. xFilial("TO3")+TO0->TO0_LAUDO == TO3->TO3_FILIAL+TO3->TO3_LAUDO
			Dbselectarea("TO4")
			Dbsetorder(1)
			If Dbseek(xFilial("TO4")+TO3->TO3_CONTRO)
				lPrint := .T.
				U_IMPCAB870(Alltrim(TO4->TO4_NOMCTR))
				If !Empty(TO3->TO3_DESCRI)
					U_IMPTXT870(Alltrim(TO3->TO3_DESCRI))
				EndIf
				Somalinha()
			EndIf
			Dbselectarea("TO3")
			Dbskip()
		End
		RestArea(aArea)

	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fBusExa
Atalho de exames

@author	Gabriel Sokacheski
@since 14/11/2023

/*/
//---------------------------------------------------------------------
Static Function fBusExa()

	Local aTotal		:= {}
	Local aExaAnt		:= {}
	Local aExaAtu		:= {}
	Local aTotNat		:= {}
	Local aHisFun 		:= {}
	Local aRetBusExa	:= {} // Retorno da busca de exames

	Local cAntIni		:= Mv_par11 // Código inicial do PCMSO anterior
	Local cAntFim 		:= Mv_par12 // Código final do PCMSO anterior
	Local cAtuIni		:= Mv_par02 // Código inicial do PCMSO atual
	Local cAtuFim 		:= Mv_par03 // Código final do PCMSO atual

	Local dIniPrg		:= CtoD( '' )
	Local dFimPrg 		:= CtoD( '' )
	Local dIniAnt		:= CtoD( '' )
	Local dFimAnt 		:= CtoD( '' )

	If nModeloImp == 1
		cAntIni := Mv_par13 // Código inicial do PCMSO anterior
		cAntFim := Mv_par14 // Código final do PCMSO anterior
	EndIf

	fDefDatAnt( cAntIni, cAntFim, @dIniAnt, @dFimAnt ) // Define as datas do PCMSO anterior
	fDefDatAnt( cAtuIni, cAtuFim, @dIniPrg, @dFimPrg ) // Define as datas do PCMSO atual

	aExaAnt := fRetExa( cAntIni, cAntFim, dIniAnt, dFimAnt )[ 1 ] // Exames do PCMSO anterior

	aRetBusExa := fRetExa( cAtuIni, cAtuFim, dIniPrg, dFimPrg )

	aExaAtu	:= aRetBusExa[ 1 ] // Exames do PCMSO atual
	aTotNat	:= aRetBusExa[ 2 ] // Totais por natureza
	aTotal 	:= aRetBusExa[ 3 ] // Totais da empresa
	aHisFun	:= aRetBusExa[ 4 ] // Histórico de funcionário

	fImpExa( { DtoC( dIniAnt ), DtoC( dFimAnt ), DtoC( dIniPrg ), DtoC( dFimPrg ) }, aExaAnt, aExaAtu )

	fImpNatExa( aTotNat )

	fImpTotExa( aTotal )

	fImpHisFun( aHisFun )

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fDefDatAnt
Busca as informações do PCMSO anterior

@author Gabriel Sokacheski
@since 24/10/2023

@param cIni, variável a ser gravado o código do PCMSO anterior
@param cFim, variável a ser gravado o código do PCMSO anterior
@param dIni, variável a ser gravada a data de início
@param dFim, variável a ser gravada a data de fim

/*/
//---------------------------------------------------------------------
Static Function fDefDatAnt( cIni, cFim, dIni, dFim )

	Local aArea := ( 'TMW' )->( GetArea() )

	DbSelectArea( 'TMW' )
	( 'TMW' )->( DbSetOrder( 1 ) )
	( 'TMW' )->( DbGoTop() )

	If ( 'TMW' )->( DbSeek( xFilial( 'TMW' ) + cIni ) )

		dIni := TMW->TMW_DTINIC
		dFim := TMW->TMW_DTFIM

		While ( 'TMW' )->( !Eof() ) .And. TMW->TMW_FILIAL == xFilial( 'TMW' ) .And. TMW->TMW_PCMSO >= cIni .And. TMW->TMW_PCMSO <= cFim

			If TMW->TMW_DTINIC < dIni
				dIni := TMW->TMW_DTINIC
			EndIf

			If TMW->TMW_DTFIM > dFim
				dFim := TMW->TMW_DTFIM
			EndIf

			( 'TMW' )->( DbSkip() )

		End

	EndIf

	RestArea( aArea )

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fRetExa
Retorna os exames que serão impressos no atalho de exames

@author Gabriel Sokacheski
@since 14/11/2023

@param cIni, código inicial do PCMSO a ser buscado
@param cFim, código final do PCMSO a ser buscado
@param dIni, data de início do PCMSO
@param dFim, data de fim do PCMSO

@return aArray, array contendo listas com as informações necessárias
/*/
//---------------------------------------------------------------------
Static Function fRetExa( cIni, cFim, dIni, dFim )

	Local aExame 		:= {} // Lista com todos os exames do PCMSO
	Local aNatureza		:= {} // Lista os exames por natureza
	Local aTotal		:= { 0, 0, 0 } // Totais da empresa dos exames do PCMSO
	Local aHisFun		:= {} // Histórico de exames do PCMSO do funcionário

	Local cNome			:= ''
	Local cSetor 		:= ''
	Local cExame 		:= ''
	Local cNatureza		:= ''
	Local cResultado	:= ''

	Local nExame		:= 0 // Quantidade realizada do exame
	Local nSetor 		:= 0 // Considerar por? 1=Centro de custo;2=Departamento;
	Local nResAno		:= 0 // Número de resultados anormais do exame

	If nModeloImp == 1
		nSetor 	:= mv_par11
	Else
		nSetor 	:= mv_par09
	EndIf

	DbSelectArea( 'TMW' )
	( 'TMW' )->( DbSetOrder( 01 ) )

	If ( 'TMW' )->( DbSeek( xFilial( 'TMW' ) + cIni ) )

		While ( 'TMW' )->( !Eof() ) .And. TMW->TMW_FILIAL == xFilial( 'TMW' ) .And. TMW->TMW_PCMSO <= cFim

			DbSelectArea( 'TM5' )
			( 'TM5' )->( DbSetOrder( 03 ) )

			If ( 'TM5' )->( DbSeek( xFilial( 'TM5' ) + TMW->TMW_PCMSO ) )

				While ( 'TM5' )->( !Eof() ) .And. TM5->TM5_FILIAL == xFilial( 'TM5' ) .And. TM5->TM5_PCMSO == TMW->TMW_PCMSO
				
					If TM5->TM5_DTPROG >= dIni .And. TM5->TM5_DTPROG <= dFim .And. !Empty( TM5->TM5_CC ) .And. !Empty( TM5->TM5_DTRESU )

						//----------------------
						// Informações do exame
						//----------------------

						If nSetor == 2
							cSetor := Posicione( 'TM0', 1, xFilial( 'TM0' ) + TM5->TM5_NUMFIC, 'TM0_DEPTO' )
							cSetor := AllTrim( Capital( Posicione( 'SQB', 1, xFilial( 'SQB' ) + cSetor, 'QB_DESCRIC' ) ) )
						Else
							cSetor := AllTrim( Capital( Posicione( 'CTT', 1, xFilial( 'CTT' ) + TM5->TM5_CC, 'CTT_DESC01' ) ) )
						EndIf

						If TM5->TM5_INDRES == '2' // Resultado alterado (não normal/anormal)
							nResAno := 1
						EndIf

						cExame := AllTrim( Capital( Posicione( 'TM4', 1, xFilial( 'TM4' ) + TM5->TM5_EXAME, 'TM4_NOMEXA' ) ) )

						Do Case
							Case TM5->TM5_NATEXA == '1'
								cNatureza := 'Admissional'
							Case TM5->TM5_NATEXA == '2'
								cNatureza := 'Periódico'
							Case TM5->TM5_NATEXA == '3'
								cNatureza := 'Mudança de riscos ocupacionais'
							Case TM5->TM5_NATEXA == '4'
								cNatureza := 'Retorno ao trabalho'
							Case TM5->TM5_NATEXA == '5'
								cNatureza := 'Demissional'
							Case TM5->TM5_NATEXA == '6'
								cNatureza := 'Monitoramento pontual'
						EndCase

						// Caso não exista este exame no array, adiciona
						If ( nExame := aScan( aExame, { | exame | exame[ 1 ] == cSetor .And. exame[ 2 ] == cExame } ) ) == 0

							aAdd( aExame, {;
								cSetor,;				// [1] Setor
								cExame,;				// [2] Exame
								1,;						// [3] Exames realizados
								nResAno,;				// [4] Resultados anormais
								( nResAno / 1 ) * 100;	// [5] Percentual anormal
							} )

						// Caso exista, altera os totalizadores do exame no array
						Else

							aExame[ nExame, 3 ] += 1 													// [3] Exames realizados
							aExame[ nExame, 4 ] += nResAno 												// [4] Resultados anormais
							aExame[ nExame, 5 ] := ( aExame[ nExame, 4 ] / aExame[ nExame, 3 ] ) * 100	// [5] Percentual anormal

						EndIf

						// Caso não exista este exame no array, adiciona
						If ( nExame := aScan( aNatureza, { | exame | exame[ 1 ] == cNatureza } ) ) == 0

							aAdd( aNatureza, {;
								cNatureza,;				// [1] Natureza
								1,;						// [2] Exames realizados
								nResAno,;				// [3] Resultados anormais
								( nResAno * 100 ) / 1;	// [4] Percentual anormal
							} )

						// Caso exista, altera os totalizadores do exame no array
						Else

							aNatureza[ nExame, 2 ] += 1 														// [2] Exames realizados
							aNatureza[ nExame, 3 ] += nResAno 													// [3] Resultados anormais
							aNatureza[ nExame, 4 ] := ( aNatureza[ nExame, 3 ] / aNatureza[ nExame, 2 ] ) * 100 // [4] Percentual anormal

						EndIf

						//-------------------
						// Totais da empresa
						//-------------------
						aTotal[ 1 ] += 1
						aTotal[ 2 ] += nResAno
						aTotal[ 3 ] := ( aTotal[ 2 ] / aTotal[ 1 ] ) * 100 

						//--------------------------
						// Histórico do funcionário
						//--------------------------

						DbSelectArea( 'TM0' )
						( 'TM0' )->( DbSetOrder( 1 ) )
						If ( 'TM0' )->( DbSeek( xFilial( 'TM0' ) + TM5->TM5_NUMFIC ) )

							If !Empty( TM0->TM0_NOMSOC )
								cNome := MDTHideCpo( AllTrim( Capital( TM0->TM0_NOMSOC ) ), 'TM0_NOMSOC' )
							Else
								cNome := MDTHideCpo( AllTrim( Capital( TM0->TM0_NOMFIC ) ), 'TM0_NOMFIC' )
							EndIf

						EndIf

						If nResAno == 1
							cResultado := STR0047 // "Alterado"
						Else
							cResultado := STR0048 // "Normal"
						EndIf

						aAdd( aHisFun, { cSetor, TM0->TM0_NUMFIC, cNome, cExame, DtoC( TM5->TM5_DTRESU ), cResultado } )

						nResAno := 0

					EndIf

					( 'TM5' )->( Dbskip() )

				End

			EndIf

			( 'TMW' )->( Dbskip() )

		End

	EndIf

	If !Empty( aExame ) // Ordena o array de forma cresente pelo setor dos exames
		aSort( aExame, Nil, Nil, { | x, y | x[ 1 ] < y[ 1 ] } )
	EndIf

	If !Empty( aNatureza ) // Ordena o array de forma cresente pela natureza dos exames
		aSort( aNatureza, Nil, Nil, { | x, y | x[ 1 ] < y[ 1 ] } )
	EndIf

	If !Empty( aTotal ) // Converte os totais para caractere
		aTotal[ 1 ] := AllTrim( Str( aTotal[ 1 ] ) )
		aTotal[ 2 ] := AllTrim( Str( aTotal[ 2 ] ) )
		aTotal[ 3 ] := AllTrim( Str( aTotal[ 3 ] ) ) + '%'
	EndIf

	If !Empty( aHisFun ) // Ordena o array de forma cresente pelo setor + nome + exame + data
		aSort( aHisFun, Nil, Nil, { | x, y | x[ 1 ] + x[ 4 ] + x[ 4 ] + x[ 5 ] < y[ 1 ] + y[ 3 ] + y[ 4 ] + y[ 5 ] } )
	EndIf

Return { aExame, aNatureza, aTotal, aHisFun }

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpExa
Imprime o atalho de exames

@author Gabriel Sokacheski
@since 16/11/2023

@param aDatas, datas de início e fim do PCMSO anterior e atual
@param aExaAnt, exames do PCMSO anterior
@param aExaAtu, exames do PCMSO atual

/*/
//---------------------------------------------------------------------
Static Function fImpExa( aDatas, aExaAnt, aExaAtu )

	Local cRegistros	:= '' // Variável contendo todos os exames do setor para impressão em Word

	Local nExaAtu 		:= 0 // Posição no array do exame no período atual
	Local nExaAnt 		:= 0 // Posicão no array do exame equivalente no período anterior
	Local nExaSet 		:= 0 // Número de exames do setor
	Local nMarEsq		:= 150 // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nImpVal 		:= 40 // Meio da linha

	If nModeloImp == 1

		OLE_SetDocumentVar( oWord, "titulo_exames", STR0283 ) // "Exames"
		OLE_ExecuteMacro( oWord, "titulo_atalho_exames" )

		For nExaAtu := 1 To Len( aExaAtu )

			If nExaAtu != 1 .And. aExaAtu[ nExaAtu, 1 ] != aExaAtu[ nExaAtu - 1, 1 ] // Imprime os exames do setor em que percorreu os exames

				OLE_SetDocumentVar( oWord, "cabecalho_exames", aExaAtu[ nExaAtu - 1, 1 ] + '#' + aDatas[ 1 ] + ' - ' + aDatas[ 2 ] + '#' +  aDatas[ 3 ] + ' - ' + aDatas[ 4 ] )
				OLE_SetDocumentVar( oWord, "tabela_exames", cRegistros )
				OLE_SetDocumentVar( oWord, "numero_exames", nExaSet )
				OLE_ExecuteMacro( oWord, "exames" )

				nExaSet 	:= 0
				cRegistros	:= ''

			EndIf

			cRegistros += aExaAtu[ nExaAtu, 2 ] + '#' // Exame

			// Procura no array de exames do PCMSO anterior o exame equivalente ao atual
			If ( nExaAnt := aScan( aExaAnt, { | exame | exame[ 1 ] == aExaAtu[ nExaAtu, 1 ] .And. exame[ 2 ] == aExaAtu[ nExaAtu, 2 ] } ) ) > 0

				cRegistros += AllTrim( Str( aExaAnt[ nExaAnt, 3 ] ) ) + '#' // Número de exames realizados
				cRegistros += AllTrim( Str( aExaAnt[ nExaAnt, 4 ] ) ) + '#' // Número de resultados anormais
				cRegistros += AllTrim( Str( aExaAnt[ nExaAnt, 5 ] ) + '%' ) + '#' // Percentual de resultados anormais

			Else // Define os totalizadores como zero caso não exista um exame equivalente

				cRegistros += '0' + '#'
				cRegistros += '0' + '#'
				cRegistros += '0%' + '#'

			EndIf

			cRegistros += AllTrim( Str( aExaAtu[ nExaAtu, 3 ] ) ) + '#' // Número de exames realizados
			cRegistros += AllTrim( Str( aExaAtu[ nExaAtu, 4 ] ) ) + '#' // Número de resultados anormais
			cRegistros += AllTrim( Str( aExaAtu[ nExaAtu, 5 ] ) + '%' ) + '#' // Percentual de resultados anormais

			nExaSet	+= 1

			If nExaAtu == Len( aExaAtu )

				OLE_SetDocumentVar( oWord, "cabecalho_exames", aExaAtu[ nExaAtu, 1 ] + '#' + aDatas[ 1 ] + ' - ' + aDatas[ 2 ] + '#' +  aDatas[ 3 ] + ' - ' + aDatas[ 4 ] )
				OLE_SetDocumentVar( oWord, "tabela_exames", cRegistros )
				OLE_SetDocumentVar( oWord, "numero_exames", nExaSet )
				OLE_ExecuteMacro( oWord, "exames" )

			EndIf

		Next nExaAtu

	ElseIf nModeloImp == 3


		SomaLinha()
		oPrintPPRA:Say( lin + nImpVal, 1200, STR0283, oFont10b ) // "Exames"

		For nExaAtu := 1 To Len( aExaAtu )

			SomaLinha()

			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 820, lin + 60, 820 )

			oPrintPPRA:Say( lin + nImpVal, 170, STR0284, oFont10b ) // "Setor"
			oPrintPPRA:Say( lin + nImpVal, 840, aExaAtu[ nExaAtu, 1 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 820, lin + 60, 820 )
			oPrintPPRA:Say( lin + nImpVal, 170, STR0083, oFont10b ) // "Exame"
			oPrintPPRA:Say( lin + nImpVal, 840, aExaAtu[ nExaAtu, 2 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 1200, lin + 60, 1200 )
			oPrintPPRA:Say( lin + nImpVal, 450, aDatas[ 1 ] + ' - ' + aDatas[ 2 ], oFont10b )
			oPrintPPRA:Say( lin + nImpVal, 1600, aDatas[ 3 ] + ' - ' + aDatas[ 4 ], oFont10b )

			SomaLinha()

			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 440, lin + 60, 440 )
			oPrintPPRA:Line( lin, 770, lin + 60, 770 )
			oPrintPPRA:Line( lin, 1200, lin + 60, 1200 )
			oPrintPPRA:Line( lin, 1530, lin + 60, 1530 )
			oPrintPPRA:Line( lin, 1920, lin + 60, 1920 )
			oPrintPPRA:Say( lin + nImpVal, 170, STR0285, oFont10b ) // "Exames realizados"
			oPrintPPRA:Say( lin + nImpVal, 460, STR0286, oFont10b ) // "Resultados anormais"
			oPrintPPRA:Say( lin + nImpVal, 830, STR0287, oFont10b ) // "Percentual anormais"
			oPrintPPRA:Say( lin + nImpVal, 1240, STR0285, oFont10b ) // "Exames realizados"
			oPrintPPRA:Say( lin + nImpVal, 1580, STR0286, oFont10b ) // "Resultados anormais"
			oPrintPPRA:Say( lin + nImpVal, 1940, STR0287, oFont10b ) // "Percentual anormais"

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 440, lin + 60, 440 )
			oPrintPPRA:Line( lin, 770, lin + 60, 770 )
			oPrintPPRA:Line( lin, 1200, lin + 60, 1200 )
			oPrintPPRA:Line( lin, 1530, lin + 60, 1530 )
			oPrintPPRA:Line( lin, 1920, lin + 60, 1920 )

			// Procura no array de exames do PCMSO anterior o exame equivalente ao atual
			If ( nExaAnt := aScan( aExaAnt, { | exame | exame[ 1 ] == aExaAtu[ nExaAtu, 1 ] .And. exame[ 2 ] == aExaAtu[ nExaAtu, 2 ] } ) ) > 0

				oPrintPPRA:Say( lin + nImpVal, 170, AllTrim( Str( aExaAnt[ nExaAnt, 3 ] ) ), oFont10 )
				oPrintPPRA:Say( lin + nImpVal, 460, AllTrim( Str( aExaAnt[ nExaAnt, 4 ] ) ), oFont10 )
				oPrintPPRA:Say( lin + nImpVal, 830, AllTrim( Str( aExaAnt[ nExaAnt, 5 ] ) + '%' ), oFont10 )

			Else // Define os totalizadores como zero caso não exista um exame equivalente

				oPrintPPRA:Say( lin + nImpVal, 170, '0', oFont10 )
				oPrintPPRA:Say( lin + nImpVal, 460, '0', oFont10 )
				oPrintPPRA:Say( lin + nImpVal, 830, '0%', oFont10 )

			EndIf

			oPrintPPRA:Say( lin + nImpVal, 1240, AllTrim( Str( aExaAtu[ nExaAtu, 3 ] ) ), oFont10 )
			oPrintPPRA:Say( lin + nImpVal, 1580, AllTrim( Str( aExaAtu[ nExaAtu, 4 ] ) ), oFont10 )
			oPrintPPRA:Say( lin + nImpVal, 1940, AllTrim( Str( aExaAtu[ nExaAtu, 5 ] ) + '%' ), oFont10 )
			SomaLinha()

		Next nExaAtu

	Else

		SomaLinha()
		@ Li, 60 PSay STR0283 // "Exames"
		SomaLinha()

		For nExaAtu := 1 To Len( aExaAtu )

			SomaLinha()
			@ Li, 0 PSay STR0284 + ':' + Space( 1 ) + aExaAtu[ nExaAtu, 1 ] // "Setor"

			SomaLinha()
			@ Li, 0 PSay STR0083 + ':' + Space( 1 ) + aExaAtu[ nExaAtu, 2 ] // "Exame"

			SomaLinha()
			@ Li, 18 PSay aDatas[ 1 ] + ' - ' + aDatas[ 2 ]
			@ Li, 86 PSay aDatas[ 3 ] + ' - ' + aDatas[ 4 ]

			SomaLinha()
			@ Li, 0 PSay STR0285 // "Exames realizados
			@ Li, 19 PSay STR0286 // "Resultados anormais"
			@ Li, 40 PSay STR0287 // "Percentual anormais"
			@ Li, 65 PSay STR0285 // "Exames realizados
			@ Li, 88 PSay STR0286 // "Resultados anormais"
			@ Li, 110 PSay STR0287 // "Percentual anormais"

			// Procura no array de exames do PCMSO anterior o exame equivalente ao atual
			If ( nExaAnt := aScan( aExaAnt, { | exame | exame[ 1 ] == aExaAtu[ nExaAtu, 1 ] .And. exame[ 2 ] == aExaAtu[ nExaAtu, 2 ] } ) ) > 0

				SomaLinha()
				@ Li, 10 PSay AllTrim( Str( aExaAnt[ nExaAnt, 3 ] ) )
				@ Li, 29 PSay AllTrim( Str( aExaAnt[ nExaAnt, 4 ] ) )
				@ Li, 50 PSay AllTrim( Str( aExaAnt[ nExaAnt, 5 ] ) + '%' )

			Else // Define os totalizadores como zero caso não exista um exame equivalente

				SomaLinha()
				@ Li, 10 PSay '0'
				@ Li, 29 PSay '0'
				@ Li, 50 PSay '0%'

			EndIf

			@ Li, 75 PSay AllTrim( Str( aExaAtu[ nExaAtu, 3 ] ) )
			@ Li, 98 PSay AllTrim( Str( aExaAtu[ nExaAtu, 4 ] ) )
			@ Li, 120 PSay AllTrim( Str( aExaAtu[ nExaAtu, 5 ] ) + '%' )

			SomaLinha()
			SomaLinha()

		Next nExaAtu

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpNatExa
Imprime os exames por natureza

@author Gabriel Sokacheski
@since 26/03/2025

@param aTotal, array, totais por natureza

/*/
//---------------------------------------------------------------------
Static Function fImpNatExa( aTotal )

	Local cExames 		:= ''
	Local cTitulos		:= ''

	Local nExame		:= 0
	Local nMarEsq		:= 150 // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nImpVal 		:= 40 // Meio da linha

	cTitulos += STR0296 + '#' // "Natureza"
	cTitulos += STR0285 + '#' // "Exames realizados"
	cTitulos += STR0286 + '#' // "Resultados anormais"
	cTitulos += STR0287 + '#' // "Percentual anormais"

	For nExame := 1 To Len( aTotal )

		If nModeloImp == 1

			cExames := cTitulos
			cExames += aTotal[ nExame, 1 ] + '#'
			cExames += AllTrim( Str( aTotal[ nExame, 2 ] ) ) + '#'
			cExames += AllTrim( Str( aTotal[ nExame, 3 ] ) ) + '#'
			cExames += AllTrim( Str( aTotal[ nExame, 4 ] ) ) + '%'

			OLE_SetDocumentVar( oWord, "total_natureza", cExames )
			OLE_ExecuteMacro( oWord, "total_natureza_exames" )

			cExames := ''

		ElseIf nModeloImp == 3

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 820, lin + 60, 820 )
			oPrintPPRA:Say( lin + nImpVal, 170, STR0296, oFont10b ) // "Natureza"
			oPrintPPRA:Say( lin + nImpVal, 840, aTotal[ nExame, 1 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 1020, lin + 60, 1020 )
			oPrintPPRA:Line( lin, 1570, lin + 60, 1570 )
			oPrintPPRA:Say( lin + nImpVal, 170, STR0285, oFont10b ) // "Exames realizados"
			oPrintPPRA:Say( lin + nImpVal, 1040, STR0286, oFont10b ) // "Resultados anormais"
			oPrintPPRA:Say( lin + nImpVal, 1610, STR0287, oFont10b ) // "Percentual anormais"

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 1020, lin + 60, 1020 )
			oPrintPPRA:Line( lin, 1570, lin + 60, 1570 )
			oPrintPPRA:Say( lin + nImpVal, 170, AllTrim( Str( aTotal[ nExame, 2 ] ) ), oFont10 )
			oPrintPPRA:Say( lin + nImpVal, 1040, AllTrim( Str( aTotal[ nExame, 3 ] ) ), oFont10 )
			oPrintPPRA:Say( lin + nImpVal, 1610, AllTrim( Str( aTotal[ nExame, 4 ] ) ) + '%', oFont10 )

			SomaLinha()

		Else

			SomaLinha()
			@ Li, 0 PSay STR0296 + ':' + Space( 1 ) + aTotal[ nExame, 1 ] // "Natureza"

			SomaLinha()
			@ Li, 20 PSay STR0285 // "Exames realizados
			@ Li, 55 PSay STR0286 // "Resultados anormais"
			@ Li, 88 PSay STR0287 // "Percentual anormais"

			SomaLinha()
			@ Li, 30 PSay AllTrim( Str( aTotal[ nExame, 2 ] ) )
			@ Li, 65 PSay AllTrim( Str( aTotal[ nExame, 3 ] ) )
			@ Li, 98 PSay AllTrim( Str( aTotal[ nExame, 4 ] ) ) + '%'

			SomaLinha()
			SomaLinha()

		EndIf

	Next nExame

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpTotExa
Imprime os totais dos exames da empresa do PCMSO

@author Gabriel Sokacheski
@since 29/11/2023

@param aTotal, estátisticas dos exames do PCMSO da empresa

/*/
//---------------------------------------------------------------------
Static Function fImpTotExa( aTotal )

	Local nMarEsq		:= 150 // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nImpVal 		:= 40 // Meio da linha

	If nModeloImp == 1

		OLE_SetDocumentVar( oWord, "total_exames", aTotal[ 1 ] + '#' + aTotal[ 2 ] + '#' + aTotal[ 3 ] )
		OLE_ExecuteMacro( oWord, "total_exames_empresa" )

	ElseIf nModeloImp == 3

		SomaLinha()
		oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
		oPrintPPRA:Say( lin + nImpVal, 1150, STR0046, oFont10b ) // "Totais da empresa"

		SomaLinha()
		oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
		oPrintPPRA:Line( lin, 1020, lin + 60, 1020 )
		oPrintPPRA:Line( lin, 1570, lin + 60, 1570 )
		oPrintPPRA:Say( lin + nImpVal, 170, STR0285, oFont10b ) // "Exames realizados
		oPrintPPRA:Say( lin + nImpVal, 1040, STR0286, oFont10b ) // "Resultados anormais"
		oPrintPPRA:Say( lin + nImpVal, 1610, STR0287, oFont10b ) // "Percentual anormais"

		SomaLinha()
		oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
		oPrintPPRA:Line( lin, 1020, lin + 60, 1020 )
		oPrintPPRA:Line( lin, 1570, lin + 60, 1570 )
		oPrintPPRA:Say( lin + nImpVal, 170, aTotal[ 1 ], oFont10 )
		oPrintPPRA:Say( lin + nImpVal, 1040, aTotal[ 2 ], oFont10 )
		oPrintPPRA:Say( lin + nImpVal, 1610, aTotal[ 3 ], oFont10 )

		SomaLinha()

	Else

		SomaLinha()
		@ Li, 60 PSay STR0046 // "Totais da empresa"

		SomaLinha()
		@ Li, 20 PSay STR0285 // "Exames realizados
		@ Li, 55 PSay STR0286 // "Resultados anormais"
		@ Li, 88 PSay STR0287 // "Percentual anormais"

		SomaLinha()
		@ Li, 30 PSay aTotal[ 1 ]
		@ Li, 65 PSay aTotal[ 2 ]
		@ Li, 98 PSay aTotal[ 3 ]

		SomaLinha()
		SomaLinha()

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpHisFun
Imprime o histórico do funcionário

@author Gabriel Sokacheski
@since 29/11/2023

@param aExame, exame dos funcionários

/*/
//---------------------------------------------------------------------
Static Function fImpHisFun( aExame )

	Local cRegistros	:= '' // Exames do funcionário atual

	Local nExame	 	:= 0 // Exame atual
	Local nTotExaFun	:= 0 // Total de exames do funcionário atual

	Local nMarEsq		:= 150 // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nImpVal 		:= 40 // Meio da linha

	If nModeloImp == 1

		For nExame := 1 To Len( aExame )

			If nExame != 1 .And. aExame[ nExame, 2 ] != aExame[ nExame - 1, 2 ] // Imprime os exames do funcionário em que percorreu os exames

				OLE_SetDocumentVar( oWord, "cabecalho_historico_exames", aExame[ nExame - 1, 1 ] + '#' + aExame[ nExame - 1, 3 ] )
				OLE_SetDocumentVar( oWord, "tabela_historico_exames", cRegistros )
				OLE_SetDocumentVar( oWord, "numero_historico_exames", nTotExaFun )
				OLE_ExecuteMacro( oWord, "historico_exames" )

				nTotExaFun 	:= 0
				cRegistros	:= ''

			EndIf

			cRegistros += aExame[ nExame, 4 ] + '#'
			cRegistros += aExame[ nExame, 5 ] + '#'
			cRegistros += aExame[ nExame, 6 ] + '#'

			nTotExaFun 	+= 1

			If nExame == Len( aExame )

				OLE_SetDocumentVar( oWord, "cabecalho_historico_exames", aExame[ nExame, 1 ] + '#' + aExame[ nExame, 3 ] )
				OLE_SetDocumentVar( oWord, "tabela_historico_exames", cRegistros )
				OLE_SetDocumentVar( oWord, "numero_historico_exames", nTotExaFun )
				OLE_ExecuteMacro( oWord, "historico_exames" )

			EndIf

		Next nExame

	ElseIf nModeloImp == 3

		For nExame := 1 To Len( aExame )

			If nExame == 1 .Or. aExame[ nExame, 2 ] != aExame[ nExame - 1, 2 ]

				If nExame != 1
					SomaLinha()
				Else
					SomaLinha()
					oPrintPPRA:Say( lin + 15, 1050, STR0288, oFont10b ) // "Histórico do funcionário"
				EndIf

				SomaLinha()
				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, 820, lin + 60, 820 )
				oPrintPPRA:Say( lin + nImpVal, 170, STR0284, oFont10b ) // "Setor"
				oPrintPPRA:Say( lin + nImpVal, 840, aExame[ nExame, 1 ], oFont10 )

				SomaLinha()
				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, 820, lin + 60, 820 )
				oPrintPPRA:Say( lin + nImpVal, 170, STR0289, oFont10b ) // "Funcionário"
				oPrintPPRA:Say( lin + nImpVal, 840, aExame[ nExame, 3 ], oFont10 )

				SomaLinha()
				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, 1520, lin + 60, 1520 )
				oPrintPPRA:Line( lin, 2070, lin + 60, 2070 )
				oPrintPPRA:Say( lin + nImpVal, 170, STR0083, oFont10b ) // "Exame"
				oPrintPPRA:Say( lin + nImpVal, 1540, STR0092, oFont10b ) // "Data"
				oPrintPPRA:Say( lin + nImpVal, 2090, STR0093, oFont10b ) // "Resultado"

			EndIf

			SomaLinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Line( lin, 1520, lin + 60, 1520 )
			oPrintPPRA:Line( lin, 2070, lin + 60, 2070 )
			oPrintPPRA:Say( lin + nImpVal, 170, aExame[ nExame, 4 ], oFont10 )
			oPrintPPRA:Say( lin + nImpVal, 1540, aExame[ nExame, 5 ], oFont10 )
			oPrintPPRA:Say( lin + nImpVal, 2090, aExame[ nExame, 6 ], oFont10 )

		Next nExaAtu

		SomaLinha()

	Else

		SomaLinha()
		@ Li, 60 PSay STR0288 // "Histórico do funcionário"
		SomaLinha()

		For nExame := 1 To Len( aExame )

			If nExame == 1 .Or. aExame[ nExame, 2 ] != aExame[ nExame - 1, 2 ]

				If nExame != 1
					SomaLinha()
					SomaLinha()
				EndIf

				SomaLinha()
				@ Li, 0 PSay STR0284 + ':' + Space( 1 ) + aExame[ nExame, 1 ] // "Setor"

				SomaLinha()
				@ Li, 0 PSay STR0289 + ':' + Space( 1 ) + aExame[ nExame, 3 ] // "Funcionário"

				SomaLinha()
				@ Li, 20 PSay STR0083 // "Exame"
				@ Li, 75 PSay STR0092 // "Data"
				@ Li, 98 PSay STR0093 // "Resultado"

			EndIf

			SomaLinha()
			@ Li, 0 PSay aExame[ nExame, 4 ]
			@ Li, 75 PSay aExame[ nExame, 5 ]
			@ Li, 98 PSay aExame[ nExame, 6 ]

		Next nExaAtu

		SomaLinha()
		SomaLinha()

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} A870SESMT
Imprime os componentes do SESMT

@return .T., Lógico, sempre verdadeiro

@sample U_A870SESMT()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function A870SESMT()

	Local aArea := GetArea()
	Local aSesmt := {}, nFor
	Store 0 to nMedTrab,nEnfTrab,nAuxTrab,nEngSeg,nTecSeg,nMedico,nEnferm,nAuxEnf
	Dbselectarea("TMK")
	Dbsetorder(1)
	Dbseek(xFilial("TMK"))
	While !eof() .And. xFilial("TMK") == TMK->TMK_FILIAL
		If TMK->TMK_SESMT == "2"
			Dbselectarea("TMK")
			Dbskip()
			Loop
		EndIf
		If TMK->TMK_INDFUN == "1"
			nMedTrab ++
		ElseIf TMK->TMK_INDFUN == "2"
			nEnfTrab ++
		ElseIf TMK->TMK_INDFUN == "3"
			nAuxTrab ++
		ElseIf TMK->TMK_INDFUN == "4"
			nEngSeg ++
		ElseIf TMK->TMK_INDFUN == "5"
			nTecSeg ++
		EndIf

		Dbselectarea("TMK")
		Dbskip()
	End
	nCSesmt := 0
	cMemo := ""
	If nMedTrab > 0
		nCSesmt++
		cMemo += STR0052+"#*" //"Médicos do Trabalho"
		cMemo += Alltrim(Str(nMedTrab,3))+"#*"
		If nModeloImp == 2
			U_IMPTXT870(STR0053+Alltrim(Str(nMedTrab,3))) //"Médicos do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0052 , nMedTrab } )
	EndIf
	If nEnfTrab > 0
		nCSesmt++
		cMemo += STR0054+"#*" //"Enfermeiros do Trabalho"
		cMemo += Alltrim(Str(nEnfTrab,3))+"#*"
		If nModeloImp == 2
			U_IMPTXT870(STR0055+Alltrim(Str(nEnfTrab,3))) //"Enfermeiros do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0054 , nEnfTrab } )
	EndIf
	If nAuxTrab > 0
		nCSesmt++
		cMemo += STR0056+"#*" //"Auxiliares de Enfermagem do Trabalho"
		cMemo += Alltrim(Str(nAuxTrab,3))+"#*"
		If nModeloImp == 2
			U_IMPTXT870(STR0057+Alltrim(Str(nAuxTrab,3))) //"Auxiliares de Enfermagem do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0056 , nAuxTrab } )
	EndIf
	If nEngSeg > 0
		nCSesmt++
		cMemo += STR0058+"#*" //"Engenheiros de Segurança do Trabalho"
		cMemo += Alltrim(Str(nEngSeg,3))+"#*"
		If nModeloImp == 2
			U_IMPTXT870(STR0059+Alltrim(Str(nEngSeg,3))) //"Engenheiros de Segurança do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0058 , nEngSeg } )
	EndIf
	If nTecSeg > 0
		nCSesmt++
		cMemo += STR0060+"#*" //"Técnicos de Segurança do Trabalho"
		cMemo += Alltrim(Str(nTecSeg,3))+"#*"
		If nModeloImp == 2
			U_IMPTXT870(STR0061+Alltrim(Str(nTecSeg,3))) //"Técnicos de Segurança do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0060 , nTecSeg } )
	EndIf

	If nCSesmt > 0
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nCSesmt)
			OLE_ExecuteMacro(oWord,"Table_Sesmt")
		ElseIf nModeloImp == 3 .And. Len(aSesmt) > 0
			aSort(aSesmt,,,{|x,y| x[1] < y[1] })
			If lin+180 > 3000
				lin := 9999
			EndIf
			For nFor := 1 To Len(aSesmt)
				If nFor == 1
					Somalinha()
					oPrintPPRA:Box(lin,150,lin+120,2300)
					oPrintPPRA:Line(lin+60,150,lin+60,2300)
					oPrintPPRA:Line(lin+60,1580,lin+120,1580)
					oPrintPPRA:Say(lin+35,800,STR0094,oFont12b) //"QUADRO DE COMPONENTES DO SESMT"
					Somalinha()
					oPrintPPRA:Say(lin+40,810,STR0095,oFont12b) //"Função"
					oPrintPPRA:Say(lin+40,1820,STR0096,oFont12b) //"Quantidade"
				EndIf
				Somalinha()
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,2300)
				EndIf
				oPrintPPRA:Line(lin+60,150,lin+60,2300)
				oPrintPPRA:Line(lin, 150,lin+60, 150)
				oPrintPPRA:Line(lin,1580,lin+60,1580)
				oPrintPPRA:Line(lin,2300,lin+60,2300)
				oPrintPPRA:Say(lin+40,170,aSesmt[nFor,1],oFont10)
				oPrintPPRA:Say(lin+40,1930,Alltrim(Str(aSesmt[nFor,2],6)),oFont10)
			Next nFor
		EndIf
	EndIf
	RestArea(aArea)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} A870PROGS
Imprimi os programas de saude existe na empresa

@return .T., Lógico, sempre verdadeiro

@sample U_A870PROGS()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function A870PROGS()

	Dbselectarea("TMO")
	Dbsetorder(1)
	Dbseek(xFilial("TMO"))
	While !eof() .And. xFilial("TMO") == TMO->TMO_FILIAL
		//Verifica se existe funcionario relacionado ao programa de saude
		Dbselectarea("TMN")
		Dbsetorder(1)
		If !Dbseek(xFilial("TMN")+TMO->TMO_CODPRO)
			Dbselectarea("TMO")
			Dbskip()
			Loop
		EndIf
		If !U_fCLIENT870(TMN->TMN_NUMFIC) // Verifica se o Prog. Saude eh destinado aos funcionarios do Cliente
			Dbselectarea("TMO")
			Dbskip()
			Loop
		EndIf

		lPrint := .T.
		U_IMPCAB870("{N}"+TMO->TMO_NOMPRO)
		If !Empty(TMO->TMO_DESPRO)
			U_IMPTXT870(Alltrim(TMO->TMO_DESPRO))
			If nModeloImp == 3
				Somalinha()
			EndIf
		Else
			Somalinha()
		EndIf
		Dbselectarea("TMO")
		Dbskip()
	End

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fCLIENT870
Verifica se o Prog. Saude eh destinado aos funcionarios do Cliente

@return .T., Lógico, sempre verdadeiro

@sample U_fCLIENT870()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function fCLIENT870( cFicha )

	Local aArea := GetArea()
	Local lRet := .F.

	Private lSigaMdtPS := SuperGetMv( "MV_MDTPS" , .F. , "N" ) == "S"
	Private lMV_NGMDTPS := SuperGetMv( "MV_NGMDTPS", .F., "N" ) == "S"

	If lMV_NGMDTPS .Or. lSigaMdtps
		dbselectarea( "TM0" )
		dbsetorder( 1 )
		If dbseek( xFilial( "TM0" ) + cFicha )
			If TM0->TM0_CLIENT + TM0->TM0_LOJA == TO0->TO0_CLIENT + TO0->TO0_LOJA
				lRet := .T.
			EndIf
		EndIf
	Else
		lRet := .T.
	EndIf

	RestArea( aArea )

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} fMDTPREX
Verifica se o exame eh do cliente selecionado caso seja Prestador de Servico

@return .T., Lógico, sempre verdadeiro

@sample U_fMDTPREX()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function fMDTPREX(cCusto)

	If lSigaMdtps
		If Substr(cCusto,1,nSizeSA1+nSizeLo1) != TO0->TO0_CLIENT+TO0->TO0_LOJA
			Return .F.
		EndIf
	ElseIF lMV_NGMDTPS
		If Substr(cCusto,1,nSizeSA1) != TO0->TO0_CLIENT
			Return .F.
		EndIf
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} A870QUADFUN
Imprime listagem do número de funcionários masculinos, femininos e menores

@return .T., Lógico, sempre verdadeiro

@sample U_A870QUADFUN()

@author	Liber Ee Esteban
@since	17/05/2005
/*/
//---------------------------------------------------------------------
User Function A870QUADFUN()

	Local aArea  	:= GetArea()
	Local nMasc  	:= 0
	Local nFemi  	:= 0
	Local nMenor 	:= 0
	Local nTotal 	:= 0
	Local nMarEsq	:= 150
	Local nMarDir 	:= 2250
	Local nMeiLin 	:= 40

	cMemo := ""

	If lSigaMdtps
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par03)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	Else
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par01)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	EndIf

	Dbselectarea("SRA")
	Dbsetorder(01)
	Dbseek(xFilial("SRA"))
	While !eof() .And. xFilial("SRA") == SRA->RA_FILIAL
		// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
		If !R870FUNC()
			DbSelectArea("SRA")
			DbSkip()
			Loop
		EndIf
		If !Empty(cCCPCMSO) .And. lMdtUmCC
			If SRA->RA_CC != cCCPCMSO
				DbSelectArea("SRA")
				DbSkip()
				Loop
			EndIf
		EndIf
		nIdade := Year(Date()) - Year(SRA->RA_NASC)
		If Month(Date()) < Month(SRA->RA_NASC)
			nIdade := nIdade - 1
		Elseif Month(Date()) == Month(SRA->RA_NASC)
			If Day(Date()) < Day(SRA->RA_NASC)
				nIdade := nIdade - 1
			EndIf
		EndIf

		If nIdade < 18
			nMenor++
		Else
			If SRA->RA_SEXO == "M"
				nMasc++
			Else
				nFemi++
			EndIf
		EndIf
		nTotal++
		Dbselectarea("SRA")
		Dbskip()
	End

	If nModeloImp == 2
		Somalinha()
		@ Li,000 Psay STR0097 //"Quadro de Funcionarios: Masculino  Feminino  Menor Aprendiz"
		Somalinha()
		Somalinha()
		@ Li,024 Psay nMasc
		@ Li,035 Psay nFemi
		@ Li,045 Psay nMenor
		Somalinha()
		Somalinha()
		@ Li,000 Psay STR0229//"Total de Funcionários:"
		@ Li,024 Psay nTotal
		Somalinha()
		Somalinha()
	ElseIf nModeloImp == 3
		If lin+180 > 3000 //Força quebra de pagina se o quadro nao sair na mesma pagina
			lin := 9999
		EndIf

		Somalinha()
		oPrintPPRA:Box( lin, nMarEsq, lin + 180, nMarDir )
		oPrintPPRA:Line( lin + 60, nMarEsq, lin + 60, nMarDir )
		oPrintPPRA:Line( lin + 120, nMarEsq, lin + 120, nMarDir )
		oPrintPPRA:Line( lin + 60, 865, lin + 180, 865 )
		oPrintPPRA:Line( lin + 60, 1580, lin + 180, 1580 )
		oPrintPPRA:Say( lin + nMeiLin, 950, STR0098, oFont12b ) // "QUADRO DE FUNCIONÁRIOS"

		Somalinha()
		oPrintPPRA:Say( lin + nMeiLin, 430, STR0099, oFont12b ) // "Masculino"
		oPrintPPRA:Say( lin + nMeiLin, 1120, STR0100, oFont12b ) // "Feminino"
		oPrintPPRA:Say( lin + nMeiLin, 1765, STR0101, oFont12b ) // "Menor Aprendiz"

		Somalinha()
		oPrintPPRA:Say(lin + nMeiLin, 500, Alltrim( Str( nMasc, 6 ) ), oFont10 )
		oPrintPPRA:Say(lin + nMeiLin, 1200, Alltrim( Str( nFemi, 6 ) ), oFont10 )
		oPrintPPRA:Say(lin + nMeiLin, 1900, Alltrim( Str( nMenor, 6 ) ), oFont10 )

		Somalinha()
		oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
		oPrintPPRA:Say( lin + nMeiLin, 940, STR0229, oFont12b ) // "Total de Funcionários:"
		oPrintPPRA:Say( lin +  nMeiLin, 1400, Alltrim( Str( nTotal, 6 ) ), oFont10 )

	Else
		cMemo:=STR0225 + Replicate("#*",3)//"QUADRO DE FUNCIONÁRIOS"
		cMemo+=STR0226 + "#*" //"Masculino"
		cMemo+=STR0227 + "#*" //"Feminino"
		cMemo+=STR0228 + "#*" //"Menor Aprendiz"
		cMemo+=STR(nMasc,5) + "#*"
		cMemo+=STR(nFemi,5) + "#*"
		cMemo+=STR(nMenor,5) + "#*"
		cMemo+=STR0229 + Space(1) + STR(nTotal,5) + Replicate("#*",3) //"Total de Funcionários:"
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_ExecuteMacro(oWord,"Quadro_Funcionario")
		OLE_ExecuteMacro(oWord,"Somalinha")
	EndIf
	RestArea(aArea)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} A870TURNOS
Imprime listagem do número de funcionários masculinos, femininos e menores

@return .T., Lógico, sempre verdadeiro

@sample U_A870TURNOS()

@author	Liber Ee Esteban
@since	20/05/2005
/*/
//---------------------------------------------------------------------
User Function A870TURNOS()

	Local aArea  := GetArea()
	Local lfirst := .T.
	Local nMarEsq := 150
	Local nMarDir := 2250
	Local nMeiLin := 40
	cMemo := " "
	nRegs := 0

	Dbselectarea("SR6")
	Dbsetorder(01)
	Dbseek(xFilial("SR6"))
	While !eof() .And. xFilial("SR6") == SR6->R6_FILIAL

		If nModeloImp == 2
			If lfirst
				lfirst := .F.
				Somalinha()
				@ Li,000 Psay STR0102 //"Turnos de Trabalho              Quant.Horas  Quant.Descanso"
				Somalinha()//  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxx    xxxxx
			EndIf
			@ Li,000 Psay Substr(Alltrim(SR6->R6_DESC),1,30)
			@ Li,032 Psay SR6->R6_HRNORMA
			@ Li,045 Psay SR6->R6_HRDESC
			Somalinha()
		Else
			cMemo += Substr(Alltrim(SR6->R6_DESC),1,30)+"#*"
			cMemo += Alltrim(Str(SR6->R6_HRNORMA,6))+"#*"
			cMemo += Alltrim(Str(SR6->R6_HRDESC,6))+"#*"
			nRegs++
		EndIf
		Dbselectarea("SR6")
		Dbskip()
	End

	If nModeloImp == 2
		Somalinha()
	ElseIf nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Turnos")
		OLE_ExecuteMacro(oWord,"Somalinha")
	ElseIf nModeloImp == 3
		l_Eof := .T.
		nCol := 0
		_1st := .T.
		If lin+120 > 3000
			lin := 9999
		EndIf
		While (l_Eof)
			nPos  := At("#*",cMemo)
			cText := Substr(cMemo,1,nPos-1)
			cMemo := Substr(cMemo,nPos+2)

			If _1st
				Somalinha()
				oPrintPPRA:Line(lin, nMarEsq,lin, nMarDir )
				oPrintPPRA:Line(lin+60, nMarEsq,lin+60, nMarDir )
				oPrintPPRA:Line(lin, nMarEsq,lin+60, nMarEsq )
				oPrintPPRA:Line(lin, nMarDir,lin+60, nMarDir )

				oPrintPPRA:Say( lin + nMeiLin,580,STR0103,oFont10b) //"Turnos de Trabalho"
				oPrintPPRA:Line(lin,1300,lin+60,1300)
				oPrintPPRA:Say( lin + nMeiLin,1480,STR0104,oFont10b) //"Quant.Horas"
				oPrintPPRA:Line(lin,1800,lin+60,1800)
				oPrintPPRA:Say( lin + nMeiLin,1950,STR0105,oFont10b) //"Quant.Descanso"
				Somalinha()
			EndIf

			nCol++
			If nCol > 3
				nCol := 1
			EndIf
			If nCol == 1
				If !_1st
					Somalinha()
				EndIf
				If lin == 300
					oPrintPPRA:Line(lin, nMarEsq,lin, nMarDir )
				EndIf
				oPrintPPRA:Line(lin+60, nMarEsq,lin+60, nMarDir )
				oPrintPPRA:Line(lin, nMarEsq,lin+60, nMarEsq )
				oPrintPPRA:Line(lin, nMarDir,lin+60, nMarDir )
				oPrintPPRA:Line(lin,1300,lin+60,1300)
				oPrintPPRA:Line(lin,1800,lin+60,1800)

				oPrintPPRA:Say( lin + nMeiLin,160,Alltrim(cText),oFont10)
			ElseIf nCol == 2
				oPrintPPRA:Say( lin + nMeiLin,1310,cText,oFont10)
			ElseIf nCol == 3
				oPrintPPRA:Say( lin + nMeiLin,1810,cText,oFont10)
			EndIf

			_1st := .F.
			If Empty(cMemo)
				l_Eof := .F.
			EndIf
		End
		SomaLinha()
	EndIf

	RestArea(aArea)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} A870FUNFUN
Imprime listagem dos funcionários por função

@return .T., Lógico, sempre verdadeiro

@sample U_A870FUNFUN()

@author	Denis Hyroshi de Souza
@since	11/08/2004
/*/
//---------------------------------------------------------------------
User Function A870FUNFUN()

	Local aArea 	:= GetArea()
	Local cMemo 	:= ""
	Local nRegs 	:= 0
	Local _1st 		:= .T.
	Local nContFun 	:= 0
	Local nContTOT 	:= 0
	Local aFunMod3	:= {},nFor
	Local nMarEsq	:= 150 // Margem esquerda mínima
	Local nMarDir	:= 2250 // Margem direita máxima
	Local nImpVal 	:= 40 // Meio da linha

	If lSigaMdtPs

		Dbselectarea("TOS")
		DbSetOrder(2)
		DbSeek(xFilial("TOS")+cCliMdtPs)
		While !EOF() .And. xFilial("TOS")+cCliMdtPs == TOS->(TOS_FILIAL+TOS_CLIENT+TOS_LOJA)
			nContFun := 0
			Dbselectarea("SRA")
			Dbsetorder(2)
			Dbseek(xFilial("SRA")+cCliMdtPs,.T.)
			While !eof() .And. xFilial("SRA")+cCliMdtPs == SRA->RA_FILIAL+Substr(SRA->RA_CC,1,nSizeSA1+nSizeLo1)
				// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
				If !R870FUNC()
					DbSelectArea("SRA")
					DbSkip()
					Loop
				EndIf

				If !Empty(cCCPCMSO) .And. lMdtUmCC
					If TOS->TOS_CODFUN == SRA->RA_CODFUNC .And. SRA->RA_CC == cCCPCMSO
						nContFun++
					EndIf
				Else
					If TOS->TOS_CODFUN == SRA->RA_CODFUNC
						nContFun++
					EndIf
				EndIf
				Dbskip()
			End
			If nContFun > 0
				nContTOT += nContFun
				nRegs++
				If nModeloImp == 2
					If _1st
						Somalinha()
						@ Li,000 Psay STR0065				 //"Funcionários x Função: Função                                   Quant. Funcionários"
						_1st := .F.
					EndIf
					Somalinha()
					If Empty(TOS->TOS_DESFUN)
						@ Li,023 Psay Substr(NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC"),1,35)
					Else
						@ Li,023 Psay Substr(TOS->TOS_DESFUN,1,35)
					EndIf
					@ Li,075 Psay nContFun Picture "99999999"
				ElseIf nModeloImp == 3
					cDescFuncao := TOS->TOS_DESFUN
					If Empty(TOS->TOS_DESFUN)
						cDescFuncao := NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC")+"#*"
					EndIf
					aAdd( aFunMod3 , { cDescFuncao , Str(nContFun,7) } )
				Else
					If Empty(TOS->TOS_DESFUN)
						cMemo += NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC")+"#*"
					Else
						cMemo += TOS->TOS_DESFUN+"#*"
					EndIf

					cMemo += Str(nContFun,7)+"#*"
				EndIf
			EndIf

			Dbselectarea("TOS")
			Dbskip()
		End

	Else
		Dbselectarea("SRJ")
		DbSetOrder(3)
		DbSeek(xFilial("SRJ"))
		While !EOF() .And. xFilial("SRJ") == SRJ->RJ_FILIAL
			nContFun := 0
			Dbselectarea("SRA")
			Dbsetorder(7)
			Dbseek(xFilial("SRA")+SRJ->RJ_FUNCAO)
			While !eof() .And. xFilial("SRA")+SRJ->RJ_FUNCAO == SRA->RA_FILIAL+SRA->RA_CODFUNC
				// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
				If !R870FUNC()
					DbSelectArea("SRA")
					DbSkip()
					Loop
				EndIf
				If !Empty(cCCPCMSO) .And. lMdtUmCC
					If SRA->RA_CC == cCCPCMSO
						nContFun++
					EndIf
				Else
					nContFun++
				EndIf
				DbSelectArea("SRA")
				Dbskip()
			End
			Dbselectarea("SRA")
			Dbsetorder(1)
			If nContFun > 0
				nContTOT += nContFun
				nRegs++
				If nModeloImp == 2
					If _1st
						Somalinha()
						@ Li,000 Psay STR0065				 //"Funcionários x Função: Função                                   Quant. Funcionários"
						_1st := .F.
					EndIf
					Somalinha()
					@ Li,023 Psay Substr(SRJ->RJ_DESC,1,35)
					@ Li,075 Psay nContFun Picture "99999999"
				ElseIf nModeloImp == 3
					aAdd( aFunMod3 , { SRJ->RJ_DESC , Str(nContFun,7) } )
				Else
					cMemo += SRJ->RJ_DESC+"#*"
					cMemo += Str(nContFun,7)+"#*"
				EndIf
			EndIf

			Dbselectarea("SRJ")
			Dbskip()
		End
	EndIf

	If nRegs > 0
		If nModeloImp == 2

			Somalinha()
			@ Li,023 Psay "Total"
			@ Li,075 Psay nContTOT Picture "99999999"
			Somalinha()

		ElseIf nModeloImp == 3

			Somalinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir)
			oPrintPPRA:Line( lin , 1800, lin + 60, 1800 )
			oPrintPPRA:Say( lin + nImpVal, 500, STR0095, oFont10b ) // "Função"
			oPrintPPRA:Say( lin + nImpVal, 1870, STR0106, oFont10b ) // "Número de Trabalhadores"

			For nFor := 1 To Len( aFunMod3 )

				Somalinha()
				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir)
				oPrintPPRA:Line( lin , 1800, lin + 60, 1800 )
				oPrintPPRA:Say( lin + nImpVal, 170, aFunMod3[ nFor, 1 ], oFont10 )
				oPrintPPRA:Say( lin + nImpVal, 1820, AllTrim( aFunMod3[ nFor, 2 ] ), oFont10, Nil, Nil, Nil, 1 )

				If nFor == Len( aFunMod3 )

					Somalinha()
					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir)
					oPrintPPRA:Line( lin , 1800, lin + 60, 1800 )
					oPrintPPRA:Say( lin + nImpVal, 170, Upper( STR0107 ), oFont10b ) // "Total"
					oPrintPPRA:Say( lin + nImpVal, 1820, AllTrim( Str( nContTOT, 7 ) ), oFont10, Nil, Nil, Nil, 1 )

				EndIf

			Next nFor

			Somalinha()

		Else
			cMemo += STR0107+"#*" //"Total"
			cMemo += Str(nContTOT,7)+"#*"
			nRegs++

			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Funcionario")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			Somalinha()
		EndIf
	EndIf

	Dbselectarea("SRJ")
	DbSetOrder(1)

	RestArea(aArea)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} A870QUADRO
Monta quadro com acoes de prevencao, controle e diagnostico de doencas
ocupacionais ou nao

@return .T., Lógico, sempre verdadeiro

@sample U_A870QUADRO()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function A870QUADRO(lAnexoA,lAnexoB)

	Local lPostoTrb := .F.,nx,nInd,nInd2,nInd1,i
	Local _centrCusto := " "
	Local _cFuncc     := " "
	Local _cTarefa    := " "
	Local nIndTN0     := 5//FILIAL+CC+FUNCAO+DEPTO
	Local nQntFor
	Local cCentroC    := " "
	Local cCodFunc    := " "
	Local lFirstFor   := .T.
	Local lFirstCC    := .T.
	Local lPula60     := .F.
	Local cTitulo     := STR0108 //"FUNÇÃO"
	Local cTitulo2    := STR0108 //"FUNÇÃO"
	Local cDeptoAux
	Local LinhaCor,nLinhasMemo
	Local oTempTRBA, oTempTRBC, oTempTRBD, oTempTRBE, oTempTRBB, oTempTRBF
	Local bValidPeri  := { || TRBD->VLRPERIO > aPeriodic[1,1] .Or. ;
							( TRBD->VLRPERIO == aPeriodic[1,1] .And. ( TRBD->VLRPOSAD == 0 .Or. ;
							( TRBD->VLRPOSAD > aPeriodic[1,2] .And. aPeriodic[1,2] <> 0 ) ) ) .Or. ;
							( (TRBD->VLRPERIO >= aPeriodic[1,1] .And. TRBD->VLRPOSAD >= aPeriodic[1,2] ) .And. ;
							TRBD->VLRPOSA2 == 0 .Or. ( TRBD->VLRPOSAD > aPeriodic[1,2] .And. aPeriodic[1,2] <> 0 ) ) }
	Local nMarEsq := 150
	Local nMarDir := 2250
	Local nMeiLin := 40

	Private cCodFun   := "RA_CODFUNC"
	Private cTabFun   := "SRJ"
	Private cCodFun2  := "TN0_CODFUN"
	Private cDesFun   := "SRJ->RJ_DESC"
	Private nSizeCTT  := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	Private nSizeSRJ  := If((TAMSX3("RJ_FUNCAO")[1]) < 1,5,(TAMSX3("RJ_FUNCAO")[1]))
	Private nSizeSQB  := If( lTN0Depto , TAMSX3("QB_DEPTO")[1], 9 )
	Private aLetras   := {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v",;
		"w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V",;
		"W","X","Y","Z"}
	If TN0->(FieldPos("TN0_CODPOS")) > 0 .And. SRA->(FieldPos("RA_POSTO")) > 0 .And. (TAMSX3("ZZI_COD")[1]) > 0
		nIndTN0   := 8
		lPostoTrb := .T.
		cTitulo   := STR0109 //"POSTO DE TRABALHO"
		cTitulo2  := STR0109 //"POSTO DE TRABALHO"
		cCodFun   := "RA_POSTO"
		cTabFun   := "ZZI"
		cCodFun2  := "TN0_CODPOS"
		cDesFun   := "ZZI->ZZI_DESC"
		nSizeSRJ  := (TAMSX3("ZZI_COD")[1])
	EndIf

	//Tabela Ccusto x Funcao
	aTRB := {{"RA_CC"		,"C",nSizeCTT,0},;
			{"RA_CODFUN"	,"C",nSizeSRJ,0},;
			{"RA_CODFUN2"	,"C",nSizeSRJ,0}}

	If lTN0Depto
		aAdd( aTRB,{ "RA_DEPTO"	, "C" , nSizeSQB , 0 } )
	EndIf

	oTempTRBA := FWTemporaryTable():New( "TRBA", aTRB )
	#IFDEF CDX
		oTempTRBA:AddIndex( "1", {"RA_CC","RA_CODFUN"} )
		oTempTRBA:AddIndex( "2", {"RA_CC","RA_CODFUN2"} )
	#ELSE
		oTempTRBA:AddIndex( "1", {"RA_CC","RA_CODFUN"} )
		oTempTRBA:AddIndex( "2", {"RA_CC","RA_CODFUN2"} )
	#EndIf
	oTempTRBA:Create()

	//Tabela Ccusto x Funcao x Riscos
	aTRB1 := {{"CC"		,"C",nSizeCTT,0},;
			{"CODFUN"	,"C",nSizeSRJ,0},;
			{"TIPO"	,"C",1,0},;
			{"NUMRIS"	,"C",40,0}}

	If lTN0Depto
		aAdd( aTRB1 , {"DEPTO"	,"C",nSizeSQB,0} )
	EndIf

	oTempTRBC := FWTemporaryTable():New( "TRBC", aTRB1 )
	oTempTRBC:AddIndex( "1", {"CC","CODFUN","TIPO","NUMRIS"} )
	oTempTRBC:Create()

	//Tabela Ccusto x Funcao x Exames
	aTRB3 := { { "CC"	   , "C", nSizeCTT, 0 } ,;
			   { "CODFUN"  , "C", nSizeSRJ, 0 } ,;
			   { "TIPO"	   , "C", 01,       0 } ,;
			   { "EXAME"   , "C", 40,       0 } ,;
			   { "PERIODIC", "C", 40,       0 } ,;
			   { "POSADM"  , "C", 100,      0 } ,;
			   { "VLRPERIO", "N", 02,       0 } ,;
			   { "VLRPOSAD", "N", 02,       0 } ,;
			   { "VLRPOSA2", "N", 02,       0 } }


	oTempTRBD := FWTemporaryTable():New( "TRBD", aTRB3 )
	#IFDEF CDX
		oTempTRBD:AddIndex( "1", {"CC","CODFUN","TIPO","EXAME"} )
		oTempTRBD:AddIndex( "2", {"CC","CODFUN","PERIODIC","POSADM","TIPO","EXAME"} )
	#ELSE
		oTempTRBD:AddIndex( "1", {"CC","CODFUN","TIPO","EXAME"} )
		oTempTRBD:AddIndex( "2", {"CC","CODFUN","PERIODIC","POSADM","TIPO","EXAME"} )
	#EndIf
	oTempTRBD:Create()

	//Tabela Ccusto x Funcao x Recomendacao
	aTRB5 := {{"CC"		,"C",nSizeCTT,0},;
			{"CODFUN"	,"C",nSizeSRJ,0},;
			{"RECOME"	,"C",100,0}}

	oTempTRBE := FWTemporaryTable():New( "TRBE", aTRB5 )
	oTempTRBE:AddIndex( "1", {"CC","CODFUN","RECOME"} )
	oTempTRBE:Create()

	//Tabela de Quantidade de funcionarios por funcao
	aTRB2 := {{"CODFUN"	,"C",nSizeSRJ,0},;
			{"DESCRI"	,"C",50,0},;
			{ "QUANTI","N",9,0}}

	oTempTRBB := FWTemporaryTable():New( "TRBB", aTRB2 )
	#IFDEF CDX
		oTempTRBB:AddIndex( "1", {"CODFUN"} )
		oTempTRBB:AddIndex( "2", {"DESCRI"} )
	#ELSE
		oTempTRBB:AddIndex( "1", {"CODFUN"} )
		oTempTRBB:AddIndex( "2", {"DESCRI"} )
	#EndIf
	oTempTRBB:Create()

	//Tabela Ccusto x Funcao x Exames dem., adm., ret. e mud.
	aTRB6 := {{"CC"		,"C",nSizeCTT,0},;
			{"CODFUN"	,"C",nSizeSRJ,0},;
			{"NATUREZA","C",1,0},;
			{"EXAME"	,"C",40,0}}

	oTempTRBF := FWTemporaryTable():New( "TRBF", aTRB6 )
	#IFDEF CDX
		oTempTRBF:AddIndex( "1", {"CC","CODFUN","EXAME","NATUREZA"} )
	#ELSE
		oTempTRBF:AddIndex( "1", {"CC","CODFUN","EXAME","NATUREZA"} )
	#EndIf
	oTempTRBF:Create()

	Dbselectarea("SRA")
	Dbsetorder(1)
	Dbseek(xFilial("SRA"))
	While !eof() .And. xFilial("SRA") == SRA->RA_FILIAL
		// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
		If !R870FUNC()
			DbSelectArea("SRA")
			DbSkip()
			Loop
		EndIf

		If !Empty(cCCPCMSO) .And. lMdtUmCC
			If Empty(SRA->RA_CC) .Or. Empty(SRA->(&(cCodFun))) .Or. !Empty(SRA->RA_DEMISSA) .Or. SRA->RA_SITFOLH == "D" .Or. SRA->RA_CC != cCCPCMSO
				Dbselectarea("SRA")
				Dbskip()
				Loop
			EndIf
		Else
			If Empty(SRA->RA_CC) .Or. Empty(SRA->(&(cCodFun))) .Or. !Empty(SRA->RA_DEMISSA) .Or. SRA->RA_SITFOLH == "D"
				Dbselectarea("SRA")
				Dbskip()
				Loop
			EndIf
		EndIf

		Dbselectarea("TRBA")
		Dbsetorder(1)
		If !Dbseek(SRA->RA_CC+SRA->(&(cCodFun)))
			RecLock("TRBA",.T.)
			TRBA->RA_CC 	:= SRA->RA_CC
			TRBA->RA_CODFUN := SRA->(&(cCodFun))
			If lTN0Depto
				TRBA->RA_DEPTO  := SRA->RA_DEPTO
			EndIf
			MsUnLock("TRBA")
		EndIf

		Dbselectarea(cTabFun)
		Dbsetorder(1)
		Dbseek(xFilial(cTabFun)+SRA->(&(cCodFun)))

		Dbselectarea("TRBB")
		Dbsetorder(1)
		If !Dbseek(SRA->(&(cCodFun)))
			RecLock("TRBB",.T.)
			TRBB->CODFUN := SRA->(&(cCodFun))
			TRBB->DESCRI := &(cDesFun)
			TRBB->QUANTI := 1
			MsUnLock("TRBB")
		Else
			RecLock("TRBB",.F.)
			TRBB->QUANTI := TRBB->QUANTI+1
			MsUnLock("TRBB")
		EndIf

		Dbselectarea("SRA")
		Dbskip()
	End

	Dbselectarea("TRBA")
	Dbsetorder(1)
	Dbgotop()
	While !eof()
		aRiscoFun := {}
		lAchExame := .F.
		lAchRisco := .F.
		nPerExame := 0
		//Verifica Exames
		cSeekProg := xFilial("TON")+TRBA->RA_CODFUN
		dbSelectArea("TON")
		dbSetOrder(1)
		dbSeek(cSeekProg)
		While !EOF() .And. TON->TON_FILIAL+TON->TON_CODFUN == cSeekProg

			dbSelectArea("TM4")
			dbSetOrder(1)
			If !dbSeek(xFilial("TM4")+TON->TON_CODEXA)
				dbSelectArea("TON")
				dbSkip()
				Loop
			EndIf

			lAchExame := .T.

			aPeriodic := {{0, 0, 0, 0}}
			aPeriodic := NGUTILPER(TON->TON_FAIXA,25,"1")
			IF aPeriodic[1,3] <> 1 .Or. aPeriodic[1,1] == 0
				dbSelectArea("TON")
				dbSkip()
				Loop
			EndIf

			cTipo := If(Alltrim(TON->TON_CODEXA)=="NR7","1","2")
			dbSelectArea("TRBD")
			dbSetOrder(1)
			If !dbSeek(TRBA->RA_CC+TRBA->RA_CODFUN+cTipo+Substr(TM4->TM4_NOMEXA,1,40))
				RecLock("TRBD",.T.)
				TRBD->CC     := TRBA->RA_CC
				TRBD->CODFUN := TRBA->RA_CODFUN
				TRBD->EXAME  := Substr(TM4->TM4_NOMEXA,1,40)
				TRBD->TIPO   := cTipo
				TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
				TRBD->POSADM := Padr(U_cMdt870Per( aPeriodic[1,2], 1 ) + U_cMdt870Per( aPeriodic[1,4], 2 ), 100 )
				TRBD->VLRPERIO := aPeriodic[1,1]
				TRBD->VLRPOSAD := aPeriodic[1,2]
				TRBD->VLRPOSA2 := aPeriodic[1,4]
				MsUnLock("TRBD")
			ElseIf Eval(bValidPeri)// Se for uma periodicicade menor
				RecLock("TRBD",.F.)
				TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
				TRBD->POSADM := Padr(U_cMdt870Per( aPeriodic[1,2], 1 ) + U_cMdt870Per( aPeriodic[1,4], 2 ), 100 )
				TRBD->VLRPERIO := aPeriodic[1,1]
				TRBD->VLRPOSAD := aPeriodic[1,2]
				TRBD->VLRPOSA2 := aPeriodic[1,4]
				MsUnLock("TRBD")
			EndIf

			dbSelectArea("TON")
			dbSkip()
		End
		If lTN0Depto
			cDeptoAux := TRBA->RA_DEPTO
			nQntFor   := 9
		Else
			cDeptoAux := Space( nSizeSQB )
			nQntFor   := 4
		EndIf
		//Verifica exames e Riscos
		For nx := 1 to nQntFor
			If nx == 1
				_centrCusto := TRBA->RA_CC
				_cFuncc     := TRBA->RA_CODFUN
				_cDepto    := cDeptoAux
			ElseIf nx == 2
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc     := TRBA->RA_CODFUN
				_cDepto    := cDeptoAux
			ElseIf nX == 3
				_centrCusto := TRBA->RA_CC
				_cFuncc    := PADR( "*" , nSizeSRJ )
				_cDepto    := cDeptoAux
			ElseIf nX == 4
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := PADR( "*" , nSizeSRJ )
				_cDepto    := cDeptoAux
			ElseIf nX == 5
				_centrCusto:= TRBA->RA_CC
				_cFuncc    := TRBA->RA_CODFUN
				_cDepto    := PADR( "*" , nSizeSQB )
			ElseIf nX == 6
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := TRBA->RA_CODFUN
				_cDepto    := PADR( "*" , nSizeSQB )
			ElseIf nX == 7
				_centrCusto:= TRBA->RA_CC
				_cFuncc    := PADR( "*" , nSizeCTT )
				_cDepto    := PADR( "*" , nSizeSQB )
			ElseIf nX == 8
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := TRBA->RA_CODFUN
				_cDepto    := cDeptoAux
			ElseIf nX == 9
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := PADR( "*" , nSizeCTT )
				_cDepto    := PADR( "*" , nSizeSQB )
			EndIf

			DbSelectArea("TN0")
			DbSetOrder(nIndTN0)
			DbSeek(xFilial("TN0")+_centrCusto+_cFuncc)
			While !EOF() .And. TN0->TN0_FILIAL == xFilial("TN0") .And. TN0->TN0_CC == _centrCusto .And. ;
										(&(cCodFun2)) == _cFuncc
				If AllTrim(TN0->TN0_CC) <> "*" .And. !Empty(cCCPCMSO) .And. lMdtUmCC .And. TN0->TN0_CC != cCCPCMSO
					Dbselectarea("TN0")
					dbSkip()
					Loop
				EndIf

				If lTN0Depto .And. AllTrim( TN0->TN0_DEPTO ) <> "*" .And. TN0->TN0_DEPTO <> _cDepto
					Dbselectarea("TN0")
					dbSkip()
					Loop
				EndIf
				If TN0->TN0_MAPRIS == "1" //Valida se o Mapa Risco é igual a CIPA ### Autor: Jackson Machado ### Data: 10/02/2011
					dbSelectArea("TN0")
					dbSkip()
					Loop
				EndIf

				Dbselectarea("TMA")
				Dbsetorder(1)
				If !Dbseek(xFilial("TMA")+TN0->TN0_AGENTE) .Or. ;
					(!Empty(TN0->TN0_DTELIM) .And. TN0->TN0_DTELIM < dDataBase)

					DbSelectArea("TN0")
					Dbskip()
					Loop
				EndIf

				lAchRisco := .T.

				Dbselectarea("TRBC")
				If !Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN+Substr(TMA->TMA_GRISCO,1,01)+Substr(TMA->TMA_NOMAGE,1,40))
					RecLock("TRBC",.T.)
					TRBC->CC     := TRBA->RA_CC
					TRBC->CODFUN := TRBA->RA_CODFUN
					If lTN0Depto
						TRBC->DEPTO  := TRBA->RA_DEPTO
					EndIf
					TRBC->NUMRIS := Substr(TMA->TMA_NOMAGE,1,40)
					TRBC->TIPO   := Substr(TMA->TMA_GRISCO,1,01)
					MsUnLock("TRBC")
				EndIf
				//Adiciona riscos em um array
				If lAnexoB
					If (aScan(aRiscoFun,{|x| Trim(Upper(x[1])) == TN0->TN0_NUMRIS } ) == 0)
						aAdd(aRiscoFun, {TN0->TN0_NUMRIS } )
					EndIf
				EndIf

				DbSelectArea("TN2")
				DbSetOrder(1)
				DbSeek(xFilial("TN2")+TN0->TN0_NUMRIS)
				While !EOF() .And. TN2->TN2_NUMRIS == TN0->TN0_NUMRIS .And. TN2->TN2_FILIAL == xFilial("TN2")

					Dbselectarea("TM4")
					Dbsetorder(1)
					If !Dbseek(xFilial("TM4")+TN2->TN2_EXAME)
						DbSelectArea("TN2")
						Dbskip()
						Loop
					EndIf

					lAchExame := .T.

					aPeriodic := {{0, 0, 0, 0}}
					aPeriodic := NGUTILPER(TN2->TN2_FAIXA,25,"1")
					IF aPeriodic[1,3] <> 1 .Or. aPeriodic[1,1] == 0
						DbSelectArea("TN2")
						Dbskip()
						Loop
					EndIf

					cTipo := If(Alltrim(TN2->TN2_EXAME)=="NR7","1","2")
					Dbselectarea("TRBD")
					dbSetOrder(1)
					If !Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN+cTipo+Substr(TM4->TM4_NOMEXA,1,40))
						RecLock("TRBD",.T.)
						TRBD->CC     := TRBA->RA_CC
						TRBD->CODFUN := TRBA->RA_CODFUN
						TRBD->EXAME  := Substr(TM4->TM4_NOMEXA,1,40)
						TRBD->TIPO   := cTipo
						TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
						TRBD->POSADM := Padr( U_cMdt870Per( aPeriodic[1,2], 1 ) + U_cMdt870Per( aPeriodic[1,4], 2 ), 100 ) //TMQ->TMQ_POSADM
						TRBD->VLRPERIO := aPeriodic[1,1]
						TRBD->VLRPOSAD := aPeriodic[1,2]
						TRBD->VLRPOSA2 := aPeriodic[1,4]
						MsUnLock("TRBD")
					ElseIf Eval(bValidPeri)// Se for uma periodicicade menor
						RecLock("TRBD",.F.)
						TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
						TRBD->POSADM := Padr( U_cMdt870Per( aPeriodic[1,2], 1 ) + U_cMdt870Per( aPeriodic[1,4], 2 ), 100 ) //TMQ->TMQ_POSADM
						TRBD->VLRPERIO := aPeriodic[1,1]
						TRBD->VLRPOSAD := aPeriodic[1,2]
						TRBD->VLRPOSA2 := aPeriodic[1,4]
						MsUnLock("TRBD")
					EndIf

					DbSelectArea("TN2")
					DbSkip()
				End

				//Acoes
				DbSelectArea("TO1")
				DbSetOrder(1)
				DbSeek(xFilial("TO1")+MV_PAR01+TN0->TN0_NUMRIS)
				While !EOF() .And. TO1->TO1_LAUDO+TO1->TO1_NUMRIS == MV_PAR01+TN0->TN0_NUMRIS .And. ;
					TO1->TO1_FILIAL == xFilial("TO1")

					cRecome := PadR( Alltrim( Str( TO1->(Recno()) ) ) , 100 )

					Dbselectarea("TRBE")
					If !Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN+cRecome) .And. !Empty(cRecome)
						RecLock("TRBE",.T.)
						TRBE->CC     := TRBA->RA_CC
						TRBE->CODFUN := TRBA->RA_CODFUN
						TRBE->RECOME := cRecome
						MsUnLock("TRBE")
					EndIf

					DbSelectArea("TO1")
					DbSkip()
				End

				DbSelectArea("TN0")
				DbSkip()
			End
		Next nx
		//Verifica exames complementares
		DbSelectArea("TN9")
		DbSetOrder(1)
		DbSeek(xFilial("TN9"))
		While !EOF() .And. TN9->TN9_FILIAL == xFilial("TN9")

			Dbselectarea("TM4")
			Dbsetorder(1)
			If !Dbseek(xFilial("TM4")+TN9->TN9_EXAME)
				DbSelectArea("TN9")
				Dbskip()
				Loop
			EndIf

			lAchExame := .T.

			aPeriodic := {{0, 0, 0, 0}}
			aPeriodic := NGUTILPER(TN9->TN9_FAIXA,25,"1")
			IF aPeriodic[1,3] <> 1 .Or. aPeriodic[1,1] == 0
				DbSelectArea("TN9")
				Dbskip()
				Loop
			EndIf

			cTipo := If(Alltrim(TN9->TN9_EXAME)=="NR7","1","2")
			Dbselectarea("TRBD")
			dbSetOrder(1)
			If !Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN+cTipo+Substr(TM4->TM4_NOMEXA,1,40))
				RecLock("TRBD",.T.)
				TRBD->CC     := TRBA->RA_CC
				TRBD->CODFUN := TRBA->RA_CODFUN
				TRBD->EXAME  := Substr(TM4->TM4_NOMEXA,1,40)
				TRBD->TIPO   := cTipo
				TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
				TRBD->POSADM := Padr(U_cMdt870Per( aPeriodic[1,2], 1 ) + U_cMdt870Per( aPeriodic[1,4], 2 ), 100 ) //TMQ->TMQ_POSADM
				TRBD->VLRPERIO := aPeriodic[1,1]
				TRBD->VLRPOSAD := aPeriodic[1,2]
				TRBD->VLRPOSA2 := aPeriodic[1,4]
				MsUnLock("TRBD")
			ElseIf Eval(bValidPeri)// Se for uma periodicicade menor
				RecLock("TRBD",.F.)
				TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
				TRBD->POSADM := Padr(U_cMdt870Per( aPeriodic[1,2], 1 ) + U_cMdt870Per( aPeriodic[1,4], 2 ), 100 ) //TMQ->TMQ_POSADM
				TRBD->VLRPERIO := aPeriodic[1,1]
				TRBD->VLRPOSAD := aPeriodic[1,2]
				TRBD->VLRPOSA2 := aPeriodic[1,4]
				MsUnLock("TRBD")
			EndIf

			DbSelectArea("TN9")
			DbSkip()
		End

		If !lAchRisco
			Dbselectarea("TRBC")
			If !Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN+" "+STR0110) //"Ausência de riscos"
				RecLock("TRBC",.T.)
				TRBC->CC     := TRBA->RA_CC
				TRBC->CODFUN := TRBA->RA_CODFUN
				If lTN0Depto
					TRBC->DEPTO  := TRBA->RA_DEPTO
				EndIf
				TRBC->NUMRIS := STR0110 //"Ausência de riscos"
				TRBC->TIPO   := " "
				MsUnLock("TRBC")
			EndIf
		EndIf
		//Verifica exames Demissionais, Admissionais, Mud. Func e Retorno
		If lAnexoB
			aTemp := {}
			cTipo := "A"
			For nInd:= 1 to 4
				If nInd == 1
					cTipo := "A"//Busca todos os exames necessarios para admissao
				ElseIf nInd == 2
					cTipo := "D"//Busca todos os exames necessarios para demissao
				ElseIf nInd == 3
					cTipo := "M"//Busca todos os exames necessarios para Mudanca de Funcao
				Else
					cTipo := "R"//Busca todos os exames necessarios para Retorno ao trabalho
				EndIf
				aTemp := MDTRETEXA(TRBA->RA_CODFUN,cTipo,aRiscoFun)
				For i := 1 to Len(aTemp)//Grava no TRB
					dbSelectArea("TRBF")
					If !dbSeek(TRBA->RA_CC+TRBA->RA_CODFUN+Substr(aTemp[i,2],1,40)+cTipo)
						RecLock("TRBF",.T.)
						TRBF->CC := TRBA->RA_CC
						TRBF->CODFUN := TRBA->RA_CODFUN
						TRBF->EXAME := Substr(aTemp[i,2],1,40)
						TRBF->NATUREZA := cTipo
						MsUnlock("TRBF")
					EndIf
				Next i
			Next nInd
		EndIf
		DbSelectArea("TRBA")
		DbSkip()
	End

	Dbselectarea("TRBA")
	Dbsetorder(1)
	Dbgotop()
	While !eof()
		If !Empty(TRBA->RA_CODFUN2)
			Dbselectarea("TRBA")
			DbSkip()
			Loop
		EndIf
		Reclock("TRBA",.F.)
		TRBA->RA_CODFUN2 := TRBA->RA_CODFUN
		MsUnLock("TRBA")

		cExames := " "
		cPeriod := " "
		cPosAdm := " "
		cRiscos := " "
		cAcoes  := " "
		cExames2:= " "

		Dbselectarea("TRBC")
		Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_CC+TRBA->RA_CODFUN == TRBC->CC+TRBC->CODFUN
			cRiscos += TRBC->NUMRIS
			DbSkip()
		End
		Dbselectarea("TRBD")
		dbSetOrder(1)
		Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_CC+TRBA->RA_CODFUN == TRBD->CC+TRBD->CODFUN
			cExames += TRBD->EXAME
			cPeriod += TRBD->PERIODIC
			cPosAdm += TRBD->POSADM
			DbSkip()
		End
		Dbselectarea("TRBE")
		Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_CC+TRBA->RA_CODFUN == TRBE->CC+TRBE->CODFUN
			nGoTo_ := Val(TRBE->RECOME)
			If nGoTo_ > 0
				dbSelectArea("TO1")
				dbGoTo(nGoTo_)
				If !Eof()
					cAcoes += Alltrim(TO1->TO1_RECOME)
				EndIf
			EndIf
			Dbselectarea("TRBE")
			DbSkip()
		End

		If lAnexoB
			Dbselectarea("TRBF")
			dbSetOrder(1)
			Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN)
			While !eof() .And. TRBA->RA_CC+TRBA->RA_CODFUN == TRBF->CC+TRBF->CODFUN
				cExames2 += TRBF->EXAME+TRBF->NATUREZA
				DbSkip()
			End
		EndIf

		Dbselectarea("TRBA")
		nRecnoTrb := TRBA->(Recno())

		U_MDT870CC2(TRBA->RA_CC,TRBA->RA_CODFUN,cRiscos,cExames,cAcoes,lAnexoB,cPeriod,cPosAdm)

		Dbselectarea("TRBA")
		Dbgoto(nRecnoTrb)
		DbSkip()
	End

	lFirstFor := .T.
	Dbselectarea("TRBB")
	Dbsetorder(2)
	Dbgotop()
	While !eof()
		If lFirstFor
			lFirstFor := .F.
			If nModeloImp == 2
				If li != 6 //Se não estiver na primeira linha, não cria nova pagina
					li := 80
				EndIf
				Somalinha()
				U_IMPCAB870(STR0111) //"Anexo ao PCMSO:"
				Somalinha()
				Somalinha()
				Somalinha()
				U_IMPCAB870(STR0112) //"ANEXO I - RELAÇÃO DAS FUNÇÕES EXISTENTES NO ESTABELECIMENTO E SEU RESPECTIVO QUANTITATIVO."
				Somalinha()
				U_IMPCAB870(STR0113) //"ANEXO II - LEVANTAMENTO PARA RECONHECIMENTO E AVALIAÇÃO QUALITATIVA DOS RISCOS AMBIENTAIS E EXAMES PROGRAMADOS DE ACORDO COM A FUNÇÃO."
				Somalinha()
				U_IMPCAB870("{NS}"+STR0114) //"ANEXO I"
				Somalinha()
			ElseIf nModeloImp == 3
				If Lin != 300
					lin := 9999
				EndIf
				Somalinha()
				U_IMPCAB870(STR0111) //"Anexo ao PCMSO:"
				Somalinha(120)
				U_IMPCAB870(STR0112) //"ANEXO I - RELAÇÃO DAS FUNÇÕES EXISTENTES NO ESTABELECIMENTO E SEU RESPECTIVO QUANTITATIVO."
				Somalinha()
				U_IMPCAB870(STR0113) // "ANEXO II - LEVANTAMENTO PARA RECONHECIMENTO E AVALIAÇÃO QUALITATIVA DOS RISCOS AMBIENTAIS E EXAMES PROGRAMADOS DE ACORDO COM A FUNÇÃO."
				Somalinha()
				U_IMPCAB870("{NS}"+STR0114) //"ANEXO I"
				Somalinha()
			Else
				//OLE_ExecuteMacro(oWord,"NewPage")
				U_IMPCAB870(STR0111) //"Anexo ao PCMSO:"
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				U_IMPCAB870(STR0112) //"ANEXO I - RELAÇÃO DAS FUNÇÕES EXISTENTES NO ESTABELECIMENTO E SEU RESPECTIVO QUANTITATIVO."
				OLE_ExecuteMacro(oWord,"Somalinha")
				U_IMPCAB870(STR0113) //"ANEXO II - LEVANTAMENTO PARA RECONHECIMENTO E AVALIAÇÃO QUALITATIVA DOS RISCOS AMBIENTAIS E EXAMES PROGRAMADOS DE ACORDO COM A FUNÇÃO."
				OLE_ExecuteMacro(oWord,"Somalinha")
				U_IMPCAB870("{NS}"+STR0114) //"ANEXO I"
				OLE_ExecuteMacro(oWord,"Somalinha")
			EndIf
		EndIf

		If !Empty(TRBB->DESCRI)
			U_IMPTXT870(Alltrim(Str(TRBB->QUANTI,9))+" - "+Alltrim(TRBB->DESCRI))
		EndIf

		Dbselectarea("TRBB")
		Dbskip()
	End

	lFirstCC := .T.

	Dbselectarea("TRBA")
	Dbsetorder(2)
	Dbgotop()
	While !eof()
		cCentroC := TRBA->RA_CC

		If lFirstCC
			Dbselectarea("TMK")
			Dbsetorder(1)
			If lSigaMdtps
				Dbseek(xFilial("TMK")+Mv_par06)
			Else
				Dbseek(xFilial("TMK")+Mv_par04)
			EndIf

			If nModeloImp == 2
				//li := 80
				Somalinha()
				@li,001 Psay Replicate("_",127)
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Substr(Alltrim(cEmp_Nome),1,50)
				@li,053 Psay "|"
				@li,054 Psay STR0119 //"ACOES DE PREVENCAO, CONTROLE E DIAGNOSTICO DE DOENCAS OCUPACIONAIS E "
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Substr(Alltrim(cEmp_Fili),1,50)
				@li,053 Psay "|"
				@li,054 Psay STR0120 //"NAO OCUPACIONAIS"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,053 Psay "|"
				If(mv_par08 == 1)
					@li,054 Psay Upper(STR0092)+" :"+DTOC(DDATABASE)+"   "+STR0116+" - "+Upper(STR0092)+": "+DTOC(DDATABASE+365)+"   "+STR0118 //"DATA" // "REVISÃO" //"ANEXO II"
				Else
					@li,054 Psay Upper(STR0092)+" :"+DTOC(TO0->TO0_DTINIC)+"   "+STR0116+" - "+Upper(STR0092)+": "+DTOC(If(Empty(TO0->TO0_DTVALI),(TO0->TO0_DTINIC+365),TO0->TO0_DTVALI))+"   "+STR0118 //"DATA" // "REVISÃO" //"ANEXO II"
				EndIf
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,053 Psay "|"
				@li,054 Psay STR0117+": "+Substr(Alltrim(TMK->TMK_NOMUSU),1,40) //"RESPONSÁVEL P/ LEVANTAMENTO"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Replicate("_",52)
				@li,053 Psay "|"
				@li,054 Psay Replicate("_",74)
				@li,128 Psay "|"
			ElseIf nModeloImp == 3

				Somalinha()
				oPrintPPRA:Box( lin, nMarEsq, lin + 180, nMarDir )
				oPrintPPRA:Line( lin, 1025, lin + 180, 1025 )
				oPrintPPRA:Say( lin + nMeiLin, 160, Alltrim( cEmp_Nome ), oFont10b )
				oPrintPPRA:Say( lin + nMeiLin * 2, 160, Alltrim( cEmp_Fili ), oFont10b )
				cColuna2 := STR0115 //"AÇÕES DE PREVENÇÃO, CONTROLE E DIAGNÓSTICO DE DOENÇAS OCUPACIONAIS E NÃO OCUPACIONAIS"
				If(mv_par08 == 1)
					cColuna1 := Upper(STR0092)+": "+DTOC(DDATABASE)+"  /  "+STR0116+" - "+Upper(STR0092)+": "+DTOC(DDATABASE+365)+"    - "+STR0118 //"DATA" //"REVISÃO" //"ANEXO II"
				Else
					cColuna1 := Upper(STR0092)+": "+DTOC(TO0->TO0_DTINIC)+"  /  "+STR0116+" - "+Upper(STR0092)+": "+DTOC(If(Empty(TO0->TO0_DTVALI),(TO0->TO0_DTINIC+365),TO0->TO0_DTVALI))+"    - "+STR0118 //"DATA" //"REVISÃO" //"ANEXO II"
				EndIf
				oPrintPPRA:Say( lin + nMeiLin, 1035, MemoLine( cColuna2, 55, 1 ), oFont10b )
				oPrintPPRA:Say( lin + nMeiLin * 2, 1035, MemoLine( cColuna2, 55, 2 ), oFont10b )
				oPrintPPRA:Say( lin + nMeiLin * 3, 1035, cColuna1 ,oFont10b )
				oPrintPPRA:Say( lin + nMeiLin * 4, 1035, STR0117 + ": " + Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ), oFont10b ) // "RESPONSÁVEL P/ LEVANTAMENTO"
				Somalinha()
				Somalinha()
				Somalinha()

			Else
				If(mv_par10 == 1)
					cColuna1 := Alltrim(cEmp_Nome)+CRLF+Alltrim(cEmp_Fili)+CRLF
					cColuna2 := STR0115+CRLF+; //"AÇÕES DE PREVENÇÃO, CONTROLE E DIAGNÓSTICO DE DOENÇAS OCUPACIONAIS E NÃO OCUPACIONAIS
					Upper(STR0092)+": "+DTOC(DDATABASE)+"   "+STR0116+" - "+Upper(STR0092)+": "+DTOC(DDATABASE+365)+"   "+STR0118+CRLF+; //"DATA" //"REVISÃO" //"ANEXO II"
					STR0117+": "+Alltrim(SubStr(TMK->TMK_NOMUSU,1,40)) //"RESPONSÁVEL P/ LEVANTAMENTO"
				Else
					cColuna1 := Alltrim(cEmp_Nome)+CRLF+Alltrim(cEmp_Fili)+CRLF
					cColuna2 := STR0115+CRLF+; //"AÇÕES DE PREVENÇÃO, CONTROLE E DIAGNÓSTICO DE DOENÇAS OCUPACIONAIS E NÃO OCUPACIONAIS
					Upper(STR0092)+": "+DTOC(TO0->TO0_DTINIC)+"   "+STR0116+" - "+Upper(STR0092)+": "+DTOC(If(Empty(TO0->TO0_DTVALI),(TO0->TO0_DTINIC+365),TO0->TO0_DTVALI))+"   "+STR0118+CRLF+; //"DATA" //"REVISÃO" //"ANEXO II"
					STR0117+": "+Alltrim(SubStr(TMK->TMK_NOMUSU,1,40)) //"RESPONSÁVEL P/ LEVANTAMENTO"
				EndIf
				//OLE_ExecuteMacro(oWord,"NewPage")
				OLE_SetDocumentVar(oWord,"Tabela",cColuna1+"#*"+cColuna2)
				OLE_ExecuteMacro(oWord,"Tb_Anexo_Tit")
			EndIf
		EndIf
		lFirstCC := .F.

		Dbselectarea(cAlias)
		Dbsetorder(1)
		Dbseek(xFilial(cAlias)+TRBA->RA_CC)

		If nModeloImp == 2
			If li == 57
				li := 58
			EndIf
			Somalinha(,.T.)
			@li,000 Psay "|"
			@li,001 Psay Alltrim(&cDescr)
			@li,128 Psay "|"
			Somalinha()
			@li,000 Psay "|"
			@li,001 Psay Replicate("_",127)
			@li,128 Psay "|"
			If li >= 56
				li := 58
			EndIf
			Somalinha(,.T.)
			@li,000 Psay "|"
			If lAnexoA
				@li,001 Psay cTitulo2
				@li,032 Psay "|"
				@li,033 Psay STR0121+" / "+STR0122 //"AGENTES" //"RISCOS"
				@li,064 Psay "|"
				@li,065 Psay STR0123+"/"+STR0124+"/" //"EXAMES CLÍNICOS" //"COMPLEMENTARES"
				@li,096 Psay "|"
				@li,097 Psay STR0126+" /" //"AÇÕES DE PROMOÇÃO A SAÚDE"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,032 Psay "|"
				@li,064 Psay "|"
				@li,065 Psay STR0125 //"PERIODICIDADE"
				@li,096 Psay "|"
				@li,097 Psay STR0127 //"PROTEÇÃO ESPECÍFICA"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Replicate("_",31)
				@li,032 Psay "|"
				@li,033 Psay Replicate("_",31)
				@li,064 Psay "|"
				@li,065 Psay Replicate("_",31)
				@li,096 Psay "|"
				@li,097 Psay Replicate("_",31)
				@li,128 Psay "|"
			Else
				@li,001 Psay STR0121+" / "+STR0122 //"AGENTES" //"RISCOS"
				@li,032 Psay "|"
				@li,033 Psay STR0123+"/"+STR0124+"/" //"EXAMES CLÍNICOS" //"COMPLEMENTARES"
				@li,064 Psay "|"
				@li,065 Psay STR0168//"EXAMES"
				@li,096 Psay "|"
				@li,097 Psay STR0169//"ADM"
				@li,104 Psay "|"
				@li,105 Psay STR0170//"DEM"
				@li,112 Psay "|"
				@li,113 Psay STR0171//"MUD"
				@li,120 Psay "|"
				@li,121 Psay STR0172//"RET"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,032 Psay "|"
				@li,033 Psay STR0125 //"PERIODICIDADE"
				@li,064 Psay "|"
				@li,096 Psay "|"
				@li,104 Psay "|"
				@li,112 Psay "|"
				@li,120 Psay "|"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Replicate("_",31)
				@li,032 Psay "|"
				@li,033 Psay Replicate("_",31)
				@li,064 Psay "|"
				@li,065 Psay Replicate("_",31)
				@li,096 Psay "|"
				@li,097 Psay Replicate("_",7)
				@li,104 Psay "|"
				@li,105 Psay Replicate("_",7)
				@li,112 Psay "|"
				@li,113 Psay Replicate("_",7)
				@li,120 Psay "|"
				@li,121 Psay Replicate("_",7)
				@li,128 Psay "|"
			EndIf
		ElseIf nModeloImp == 3

			Somalinha()
			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 160, Alltrim( &cDescr ), oFont10b )

			If lin+130 > 3000
				lin := 9999
			EndIf

			Somalinha()
			oPrintPPRA:Line( lin + 130, nMarEsq, lin + 130, nMarDir )
			oPrintPPRA:Line( lin, nMarEsq, lin + 130, nMarEsq )

			If lAnexoA

				oPrintPPRA:Line( lin, 680, lin + 130, 680 )
				oPrintPPRA:Line( lin, 1210, lin + 130, 1210 )
				oPrintPPRA:Line( lin, 1740, lin + 130, 1740 )
				oPrintPPRA:Line( lin, nMarDir, lin + 130, nMarDir )
				oPrintPPRA:Say( lin + nMeiLin, 160, cTitulo, oFont10b ) // "FUNÇÃO"
				oPrintPPRA:Say( lin + nMeiLin, 690, STR0121 + " / " + STR0122, oFont10b ) // "AGENTES" // "RISCOS"
				oPrintPPRA:Say( lin + nMeiLin, 1220, STR0123 + " /", oFont10b ) // "EXAMES CLÍNICOS"
				oPrintPPRA:Say( lin + nMeiLin * 2, 1220, STR0124, oFont10b ) // "COMPLEMENTARES"
				oPrintPPRA:Say( lin + nMeiLin * 3, 1220, "/ " + STR0125, oFont10b ) // "PERIODICIDADE"
				oPrintPPRA:Say( lin + nMeiLin, 1750, STR0128, oFont10b ) // "AÇÕES DE PROMOÇÃO A"
				oPrintPPRA:Say( lin + nMeiLin * 2, 1750, STR0129 + " / " + STR0130, oFont10b ) // "SAÚDE" // "PROTEÇÃO"
				oPrintPPRA:Say( lin + nMeiLin * 3, 1750, STR0131, oFont10b ) // "ESPECÍFICA"
				Somalinha()
				lPula60 := .T.
			Else
				oPrintPPRA:Line( lin, 680, lin + 130, 680 )
				oPrintPPRA:Line( lin, 1210, lin + 130, 1210 )
				oPrintPPRA:Line( lin, 1700, lin + 130, 1700 )
				oPrintPPRA:Line( lin, 1830, lin + 130, 1830 )
				oPrintPPRA:Line( lin, 1970, lin + 130, 1970 )
				oPrintPPRA:Line( lin, 2110, lin + 130, 2110 )
				oPrintPPRA:Line( lin, nMarDir, lin + 130, nMarDir )
				oPrintPPRA:Say( lin + nMeiLin, 160, STR0121 + " / " + STR0122, oFont10b ) // "AGENTES" //"RISCOS"
				oPrintPPRA:Say( lin + nMeiLin, 690, STR0123 + " /", oFont10b ) // "EXAMES CLÍNICOS"
				oPrintPPRA:Say( lin + nMeiLin * 2, 690, STR0124, oFont10b ) // "COMPLEMENTARES"
				oPrintPPRA:Say( lin + nMeiLin * 3, 690, "/ " + STR0125, oFont10b ) // "PERIODICIDADE"
				oPrintPPRA:Say( lin + nMeiLin, 1220, STR0168, oFont10b ) //" EXAMES"
				oPrintPPRA:Say( lin + nMeiLin, 1760, STR0169, oFont10b ) //" ADM"
				oPrintPPRA:Say( lin + nMeiLin, 1897, STR0170, oFont10b ) //" DEM"
				oPrintPPRA:Say( lin + nMeiLin, 2035, STR0171, oFont10b ) //" MUD"
				oPrintPPRA:Say( lin + nMeiLin, 2172, STR0172, oFont10b ) //" RET"
				Somalinha()
			EndIf
		Else
			OLE_SetDocumentVar(oWord,"Tabela",Alltrim(&cDescr)+" ")
			OLE_ExecuteMacro(oWord,"Final_texto")
			OLE_ExecuteMacro(oWord,"Tb_Anexo_CC")
			OLE_SetDocumentVar(oWord,"Tabela",cTitulo)
			OLE_ExecuteMacro(oWord,"Final_texto")
			If lAnexoA
				OLE_ExecuteMacro(oWord,"Tb_Anexo_Cabec")
			Else
				OLE_ExecuteMacro(oWord,"Tb_AnexoB_Cabec")
			EndIf
		EndIf

		Dbselectarea("TRBA")
		While !eof() .And. cCentroC == TRBA->RA_CC
			cCodFunc := TRBA->RA_CODFUN2

			aFuncoes := {}
			Dbselectarea("TRBA")
			While !eof() .And. cCentroC == TRBA->RA_CC .And. cCodFunc == TRBA->RA_CODFUN2
				Dbselectarea(cTabFun)
				Dbsetorder(1)
				Dbseek(xFilial(cTabFun)+TRBA->RA_CODFUN)
				aADD(aFuncoes,&(cDesFun))
				Dbselectarea("TRBA")
				DbSkip()
			End

			aRiscos := {}
			Dbselectarea("TRBC")
			Dbseek(cCentroC+cCodFunc)
			While !eof() .And. cCentroC+cCodFunc == TRBC->CC+TRBC->CODFUN
				cTipoRis := TRBC->TIPO
				cTipoTxt := " "
				If TRBC->TIPO == "1"
					cTipoTxt := STR0132 //"Físico"
				ElseIf TRBC->TIPO == "2"
					cTipoTxt := STR0133 //"Químico"
				ElseIf TRBC->TIPO == "3"
					cTipoTxt := STR0134 //"Biológicos"
				ElseIf TRBC->TIPO == "4"
					cTipoTxt := STR0135 //"Ergonômicos"
				ElseIf TRBC->TIPO == "5"
					cTipoTxt := STR0136 //"Acidentes"
				ElseIf TRBC->TIPO == "6"
					cTipoTxt := STR0240 //"Mecânicos"
				ElseIf TRBC->TIPO == "7"
					cTipoTxt := STR0241 //"Perigosos"
				ElseIf TRBC->TIPO == "8"
					cTipoTxt := STR0295 //"Psicossociais"
				ElseIf !empty(TRBC->TIPO)
					cTipoTxt := STR0137 //"Outros"
				EndIf
				aADD(aRiscos,{cTipoTxt,{}})
				While !eof() .And. cCentroC+cCodFunc == TRBC->CC+TRBC->CODFUN .And. cTipoRis == TRBC->TIPO
					aADD(aRiscos[len(aRiscos),2],TRBC->NUMRIS)
					DbSkip()
				End
			End

			aExames := {}
			Dbselectarea("TRBD")
			Dbsetorder(2)
			Dbseek(cCentroC+cCodFunc)
			While !eof() .And. cCentroC+cCodFunc == TRBD->CC+TRBD->CODFUN
				cPeriodic := TRBD->PERIODIC
				cPosAdm		:= TRBD->POSADM
				aADD(aExames,{TRBD->PERIODIC,TRBD->POSADM,{}})
				While !eof() .And. cCentroC+cCodFunc == TRBD->CC+TRBD->CODFUN .And. cPeriodic == TRBD->PERIODIC .And. cPosAdm == TRBD->POSADM
					If TRBD->TIPO == "1"
						cTipoTxt := STR0138 //"Exame Clínico"
					ElseIf TRBD->TIPO == "2"
						cTipoTxt := STR0139 //"Exames Complementares"
					Else
						cTipoTxt := STR0137 //"Outros"
					EndIf
					aADD(aExames[len(aExames),3],{cTipoTxt,{}})
					cTipoExa := TRBD->TIPO
					While !eof() .And. cCentroC+cCodFunc == TRBD->CC+TRBD->CODFUN .And. ;
						cTipoExa == TRBD->TIPO .And. cPeriodic == TRBD->PERIODIC .And. cPosAdm == TRBD->POSADM

						aADD(aExames[len(aExames),3,len(aExames[len(aExames),3]),2],TRBD->EXAME)
						DbSkip()
					End
				End
			End

			aAcoes := {}
			Dbselectarea("TRBE")
			Dbseek(cCentroC+cCodFunc)
			While !eof() .And. cCentroC+cCodFunc == TRBE->CC+TRBE->CODFUN
				nGoTo_ := Val(TRBE->RECOME)
				If nGoTo_ > 0
					dbSelectArea("TO1")
					dbGoTo(nGoTo_)
					If !Eof()
						aADD(aAcoes,Alltrim(TO1->TO1_RECOME))
					EndIf
				EndIf
				Dbselectarea("TRBE")
				DbSkip()
			End
			aFunExames := {}
			If lAnexoB
				Dbselectarea("TRBF")
				dbSetOrder(1)
				Dbseek(cCentroC+cCodFunc)
				While !eof() .And. cCentroC+cCodFunc == TRBF->CC+TRBF->CODFUN
					If ((nPosExa := aScan(aFunExames,{|x| SubStr(x[1],1,40) == SubStr(TRBF->EXAME,1,40)})) == 0)
						aAdd(aFunExames, {SubStr(TRBF->EXAME,1,40), Trim(TRBF->NATUREZA)})
					Else
						aFunExames[nPosExa,2] += Trim(TRBF->NATUREZA)
					EndIf
					DbSkip()
				End
			EndIf

			If nModeloImp == 2
				cTextoFun := ""
				For nInd := 1 to Len(aFuncoes)
					If lAnexoA
						If nInd > Len(aLetras)
							cTextoFun += Alltrim(Str(nInd,6))+") "+aFuncoes[nInd]+CRLF
						Else
							cTextoFun += aLetras[nInd]+") "+aFuncoes[nInd]+CRLF
						EndIf
					Else
						If nInd == 1
							cTextoFun := cTitulo+":"
						EndIf
						cTextoFun += " "+AllTrim(aFuncoes[nInd])
						If nInd <> Len(aFuncoes)
							cTextoFun += ","
						EndIf
					EndIf
				Next nInd

				cTextoRis := ""
				For nInd := 1 to Len(aRiscos)
					If Empty(aRiscos[nInd,1]) .And. Len(aRiscos) == 1
						cLinha := Alltrim(Str(nInd,6))+"- "+STR0110 //"Ausência de riscos"
					Else
						cLinha := Alltrim(Str(nInd,6))+"- "+Alltrim(aRiscos[nInd,1])+": "
					EndIf
					For nInd2 := 1 To Len(aRiscos[nInd,2])
						If Alltrim(aRiscos[nInd,2,nInd2]) <> STR0110 //"Ausência de riscos"
							cLinha += Alltrim(aRiscos[nInd,2,nInd2])+If(nInd2<>Len(aRiscos[nInd,2]),", ",".")
						EndIf
					Next nInd2
					cLinha += CRLF
					cTextoRis += cLinha
				Next nInd

				cTextoExa := ""
				For nInd1 := 1 to Len(aExames)
					cTextoExa += Capital(STR0125)+": "+Alltrim(aExames[nInd1,1]) //"Periodicidade"
					cTextoExa += CRLF
					cTextoExa += STR0234+": " + Alltrim(aExames[nInd1,2])//"Pós-Admissional"
					cTextoExa += CRLF
					For nInd := 1 to Len(aExames[nInd1,3])
						cLinha := Alltrim(aExames[nInd1,3,nInd,1])+": "
						For nInd2 := 1 To Len(aExames[nInd1,3,nInd,2])
							cLinha += Alltrim(aExames[nInd1,3,nInd,2,nInd2])+If(nInd2<>Len(aExames[nInd1,3,nInd,2]),", ",".")
						Next nInd2
						cLinha += CRLF
						cTextoExa += cLinha
					Next nInd
					If Len(aExames) <> nInd1
						cTextoExa += CRLF
					EndIf
				Next nInd1

				cTextoAco := ""
				For nInd := 1 to Len(aAcoes)
					cTextoAco += Alltrim(aAcoes[nInd])+CRLF
				Next nInd

				cExa2Texto := ""
				For nInd := 1 to Len(aFunExames)
					cExa2Texto += "#*"+Padr(aFunExames[nInd,2],4)+Alltrim(aFunExames[nInd,1])+CRLF
				Next nInd

				If lAnexoA
					nTxtFun := MLCOUNT(cTextoFun,31)
					nMaior  := nTxtFun
					nTxtAco := MLCOUNT(cTextoAco,31)
					nMaior  := If(nTxtAco > nMaior,nTxtAco,nMaior)
				Else
					nTxtFun := MLCOUNT(cTextoFun,124)
					nMaior  := 0
					nTxtEx2 := MLCOUNT(cExa2Texto,31)
					nMaior  := If(nTxtEx2 > nMaior,nTxtEx2,nMaior)
					For i:=1 to nTxtFun
						Somalinha(i<>1,.T.,,,lAnexoB)
						@li,000 Psay "|"
						If !Empty(MemoLine(cTextoFun,124,i))
							@li,001 Psay MemoLine(cTextoFun,124,i)
						EndIf
						@li,128 Psay "|"
						If i == nTxtFun
							@li,000 Psay "|"
							@li,001 Psay Replicate("_",127)
							@li,128 Psay "|"
						EndIf
					Next
				EndIf

				nTxtRis := MLCOUNT(cTextoRis,31)
				nTxtExa := MLCOUNT(cTextoExa,31)

				nMaior  := If(nTxtRis > nMaior,nTxtRis,nMaior)
				nMaior  := If(nTxtExa > nMaior,nTxtExa,nMaior)

				For nInd := 1 to nMaior
					Somalinha(nInd <> 1,.T.,,lAnexoB)
					@li,000 Psay "|"
					If lAnexoA
						If !Empty(MemoLine(cTextoFun,31,nInd))
							@li,001 Psay MemoLine(cTextoFun,31,nInd)
						EndIf
						@li,032 Psay "|"
						If !Empty(MemoLine(cTextoRis,31,nInd))
							@li,033 Psay MemoLine(cTextoRis,31,nInd)
						EndIf
						@li,064 Psay "|"
						If !Empty(MemoLine(cTextoExa,31,nInd))
							@li,065 Psay MemoLine(cTextoExa,31,nInd)
						EndIf
						@li,096 Psay "|"
						If !Empty(MemoLine(cTextoAco,31,nInd))
							@li,097 Psay MemoLine(cTextoAco,31,nInd)
						EndIf
						@li,128 Psay "|"
						If nInd == nMaior
							If Somalinha(nInd <> 1,.T.,.T.)
								@li,000 Psay "|"
								@li,001 Psay Replicate("_",31)
								@li,032 Psay "|"
								@li,033 Psay Replicate("_",31)
								@li,064 Psay "|"
								@li,065 Psay Replicate("_",31)
								@li,096 Psay "|"
								@li,097 Psay Replicate("_",31)
								@li,128 Psay "|"
							EndIf
						EndIf
					Else
						If !Empty(MemoLine(cTextoRis,31,nInd))
							@li,001 Psay MemoLine(cTextoRis,31,nInd)
						EndIf
						@li,032 Psay "|"
						If !Empty(MemoLine(cTextoExa,31,nInd))
							@li,033 Psay MemoLine(cTextoExa,31,nInd)
						EndIf
						@li,064 Psay "|"
						cExaFun := MemoLine(cExa2Texto,31,nInd)
						If !Empty(cExaFun)
							//Indica se marca ou nao
							If At("#*",cExaFun) > 0
								@li,065 Psay SubStr(cExaFun,7)
								@li,096 Psay "|"
								If "A" $ Substr(cExaFun,1,6)
									@li,100 Psay "X"
								EndIf
								@li,104 Psay "|"
								If "D" $ Substr(cExaFun,1,6)
									@li,108 Psay "X"
								EndIf
								@li,112 Psay "|"
								If "M" $ Substr(cExaFun,1,6)
									@li,116 Psay "X"
								EndIf
								@li,120 Psay "|"
								If "R" $ Substr(cExaFun,1,6)
									@li,124 Psay "X"
								EndIf
								@li,128 Psay "|"
							Else
								@li,065 Psay cExaFun
								@li,096 Psay "|"
								@li,104 Psay "|"
								@li,112 Psay "|"
								@li,120 Psay "|"
								@li,128 Psay "|"
							EndIf
							//Verifica se a proxima linha e nova
							If (At("#*",MemoLine(cExa2Texto,31,nInd+1)) > 0) .Or. (Empty(MemoLine(cExa2Texto,31,nInd+1)))
								@li,066 Psay Replicate("_",31)
								@li,098 Psay Replicate("_",7)
								@li,106 Psay Replicate("_",7)
								@li,114 Psay Replicate("_",7)
								@li,122 Psay Replicate("_",7)
							EndIf
						Else
							@li,096 Psay "|"
							@li,104 Psay "|"
							@li,112 Psay "|"
							@li,120 Psay "|"
							@li,128 Psay "|"
						EndIf
						If nInd == nMaior
							If Somalinha(nInd <> 1,.T.,.T.,,lAnexoB)
								@li,000 Psay "|"
								@li,001 Psay Replicate("_",31)
								@li,032 Psay "|"
								@li,033 Psay Replicate("_",31)
								@li,064 Psay "|"
								@li,065 Psay Replicate("_",31)
								@li,096 Psay "|"
								@li,097 Psay Replicate("_",7)
								@li,104 Psay "|"
								@li,105 Psay Replicate("_",7)
								@li,112 Psay "|"
								@li,113 Psay Replicate("_",7)
								@li,120 Psay "|"
								@li,121 Psay Replicate("_",7)
								@li,128 Psay "|"
							EndIf
						EndIf
					EndIf
				Next nInd

			ElseIf nModeloImp == 3

				aDadosTmp := {"","","","",""}

				cTexto := ""
				For nInd := 1 to Len(aFuncoes)
					If lAnexoA
						If nInd > Len(aLetras)
							cTexto += Alltrim(Str(nInd,6))+") "+aFuncoes[nInd]+CRLF
						Else
							cTexto += aLetras[nInd]+") "+aFuncoes[nInd]+CRLF
						EndIf
					Else
						If nInd == 1
							cTexto := cTitulo+":"
						EndIf
						cTexto += " "+AllTrim(aFuncoes[nInd])
						If nInd <> Len(aFuncoes)
							cTexto += ","
						EndIf
					EndIf
				Next nInd
				aDadosTmp[1] := cTexto

				cTexto := ""
				For nInd := 1 to Len(aRiscos)
					If Empty(aRiscos[nInd,1]) .And. Len(aRiscos) == 1
						cLinha := Alltrim(Str(nInd,6))+"- "+STR0110// "Ausência de riscos"
					Else
						cLinha := Alltrim(Str(nInd,6))+"- "+Alltrim(aRiscos[nInd,1])+": "
					EndIf
					For nInd2 := 1 To Len(aRiscos[nInd,2])
						If Alltrim(aRiscos[nInd,2,nInd2]) <> STR0110 //"Ausência de riscos"
							cLinha += Alltrim(aRiscos[nInd,2,nInd2])+If(nInd2<>Len(aRiscos[nInd,2]),", ",".")
						EndIf
					Next nInd2
					cLinha += CRLF
					cTexto += cLinha
				Next nInd
				aDadosTmp[2] := cTexto

				cTexto := ""
				For nInd1 := 1 to Len(aExames)
					cTexto += Capital(STR0125)+": "+Alltrim(aExames[nInd1,1]) //"Periodicidade"
					cTexto += CRLF
					cTexto += STR0234+": " + Alltrim(aExames[nInd1,2])//"Pós-Admissional"
					cTexto += CRLF
					For nInd := 1 to Len(aExames[nInd1,3])
						cLinha := Alltrim(aExames[nInd1,3,nInd,1])+": "
						For nInd2 := 1 To Len(aExames[nInd1,3,nInd,2])
							cLinha += Alltrim(aExames[nInd1,3,nInd,2,nInd2])+If(nInd2<>Len(aExames[nInd1,3,nInd,2]),", ",".")
						Next nInd2
						cLinha += CRLF
						cTexto += cLinha
					Next nInd
					If Len(aExames) <> nInd1
						cTexto += CRLF
					EndIf
				Next nInd1
				aDadosTmp[3] := cTexto

				cTexto := ""
				For nInd := 1 to Len(aAcoes)
					cTexto += Alltrim(aAcoes[nInd])+CRLF
				Next nInd
				aDadosTmp[4] := cTexto

				cTexto := ""
				For nInd := 1 to Len(aFunExames)
					cTexto += "#*"+Padr(aFunExames[nInd,2],4)+Alltrim(aFunExames[nInd,1])+CRLF
				Next nInd
				aDadosTmp[5] := cTexto

				If lAnexoA
					nTxtFun := MLCOUNT(aDadosTmp[1],31)
					nMaior  := nTxtFun
					nTxtAco := MLCOUNT(aDadosTmp[4],31)
					nMaior  := If(nTxtAco > nMaior,nTxtAco,nMaior)
				Else
					nTxtFun := MLCOUNT(aDadosTmp[1],110)
					nMaior  := 0
					nTxtEx2 := MLCOUNT(aDadosTmp[5],31)
					nMaior  := If(nTxtEx2 > nMaior,nTxtEx2,nMaior)

					For i:=1 to nTxtFun

						Somalinha()

						oPrintPPRA:Line( lin, nMarEsq, lin + 60, nMarEsq )

						If !Empty(MemoLine(aDadosTmp[1],110,i))
							oPrintPPRA:Say( lin + nMeiLin, 160, MemoLine( aDadosTmp[ 1 ], 110, i ), oFont10 )
						EndIf

						oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )

					Next

				EndIf

				nTxtRis := MLCOUNT(aDadosTmp[2],31)
				nTxtExa := MLCOUNT(aDadosTmp[3],31)
				nMaior  := If(nTxtRis > nMaior,nTxtRis,nMaior)
				nMaior  := If(nTxtExa > nMaior,nTxtExa,nMaior)
				If nMaior < 60
					If lin + (nMaior*40) > 3000
						lin := 9999
					EndIf
				EndIf

				Somalinha()

				If !lAnexoA
					oPrintPPRA:Line( lin, nMarEsq, lin, nMarDir )
				EndIf

				For nInd := 1 to nMaior

					oPrintPPRA:Line( lin, nMarEsq, lin + 60, nMarEsq )
					oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )
					oPrintPPRA:Line( lin, 680, lin + 60, 680 )
					oPrintPPRA:Line( lin, 1210, lin + 60, 1210 )

					If lAnexoA
						oPrintPPRA:Line( lin, 1740, lin + 60, 1740 )
					Else
						oPrintPPRA:Line( lin, 1700, lin + 60, 1700 )
						oPrintPPRA:Line( lin, 1830, lin + 60, 1830 )
						oPrintPPRA:Line( lin, 1970, lin + 60, 1970 )
						oPrintPPRA:Line( lin, 2110, lin + 60, 2110 )
					EndIf

					If lAnexoA

						If !Empty( MemoLine( aDadosTmp[ 1 ], 31, nInd ) )
							oPrintPPRA:Say( lin + nMeiLin, 160, MemoLine( aDadosTmp[ 1 ], 31, nInd ), oFont08 )
						EndIf
						If !Empty( MemoLine( aDadosTmp[ 2 ], 31, nInd ) )
							oPrintPPRA:Say( lin + nMeiLin, 690, MemoLine( aDadosTmp[ 2 ], 31, nInd ), oFont08 )
						EndIf
						If !Empty( MemoLine( aDadosTmp[ 3 ], 31, nInd ) )
							oPrintPPRA:Say( lin + nMeiLin, 1220, MemoLine( aDadosTmp[ 3 ], 31, nInd ), oFont08 )
						EndIf
						If !Empty( MemoLine( aDadosTmp[ 4 ], 31, nInd ) )
							oPrintPPRA:Say( lin + nMeiLin, 1750, MemoLine( aDadosTmp[ 4 ], 31, nInd ), oFont08 )
						EndIf

						If nInd == nMaior
							oPrintPPRA:Line( lin + 60, nMarEsq, lin + 60, nMarDir )
						EndIf

					Else

						If !Empty( MemoLine( aDadosTmp[ 2 ], 31, nInd ) )
							oPrintPPRA:Say( lin + nMeiLin, 160, MemoLine( aDadosTmp[ 2 ], 31, nInd ), oFont08 )
						EndIf

						If !Empty(MemoLine( aDadosTmp[ 3 ], 31, nInd ) )
							oPrintPPRA:Say( lin + nMeiLin, 690, MemoLine( aDadosTmp[ 3 ], 31, nInd ), oFont08 )
						EndIf

						cExaFun := MemoLine( aDadosTmp[ 5 ], 37, nInd )

						If !Empty( cExaFun )
							//Indica se marca ou nao
							If At("#*",cExaFun) > 0

								oPrintPPRA:Say( lin + nMeiLin, 1220, SubStr( cExaFun, 7 ), oFont08 )

								If "A" $ Substr(cExaFun,1,6)
									oPrintPPRA:Say( lin + nMeiLin, 1750, "X", oFont08 )
								EndIf

								If "D" $ Substr(cExaFun,1,6)
									oPrintPPRA:Say( lin + nMeiLin, 1880, "X", oFont08 )
								EndIf

								If "M" $ Substr(cExaFun,1,6)
									oPrintPPRA:Say( lin + nMeiLin, 2020, "X", oFont08 )
								EndIf

								If "R" $ Substr(cExaFun,1,6)
									oPrintPPRA:Say( lin + nMeiLin, 2160, "X", oFont08 )
								EndIf

							Else
								oPrintPPRA:Say(lin+5,1220, cExaFun ,oFont08)
							EndIf
							//Verifica se a proxima linha e nova
							If (At("#*",MemoLine(aDadosTmp[5],37,nInd+1)) > 0) .Or. (Empty(MemoLine(aDadosTmp[5],37,nInd+1)))
								oPrintPPRA:Line( lin + 60, 1210, lin + 60, nMarDir )
							EndIf
						EndIf
					EndIf

					If !lAnexoA
						If nInd == nMaior
							oPrintPPRA:Line( lin + 60, nMarEsq, lin + 60, nMarDir )
						Else
							Somalinha()
						EndIf
					Else
						Somalinha()
					EndIf

				Next nInd

			Else
				cTexto := ""
				For nInd := 1 to Len(aFuncoes)
					If lAnexoA
						If nInd > Len(aLetras)
							cTexto += Alltrim(Str(nInd,6))+") "+aFuncoes[nInd]+CRLF
						Else
							cTexto += aLetras[nInd]+") "+aFuncoes[nInd]+CRLF
						EndIf
					Else
						If nInd == 1
							cTexto := cTitulo+":"
						EndIf
						cTexto += " "+AllTrim(aFuncoes[nInd])
						If nInd <> Len(aFuncoes)
							cTexto += ","
						EndIf
					EndIf
				Next nInd
				cTexto += "#*"
				For nInd := 1 to Len(aRiscos)
					If Empty(aRiscos[nInd,1]) .And. Len(aRiscos) == 1
						cLinha := Alltrim(Str(nInd,6))+"- "+STR0110 //"Ausência de riscos"
					Else
						cLinha := Alltrim(Str(nInd,6))+"- "+Alltrim(aRiscos[nInd,1])+": "
					EndIf
					For nInd2 := 1 To Len(aRiscos[nInd,2])
						If Alltrim(aRiscos[nInd,2,nInd2]) <> STR0110 //"Ausência de riscos"
							cLinha += Alltrim(aRiscos[nInd,2,nInd2])+If(nInd2<>Len(aRiscos[nInd,2]),", ",".")
						EndIf
					Next nInd2
					cLinha += CRLF
					cTexto += cLinha
				Next nInd

				cTexto += "#*"
				For nInd1 := 1 to Len(aExames)
					cTexto += Capital(STR0125)+": "+Alltrim(aExames[nInd1,1]) //"Periodicidade"
					cTexto += CRLF
					cTexto += STR0234+": " + Alltrim(aExames[nInd1,2])//"Pós-Admissional"
					cTexto += CRLF
					For nInd := 1 to Len(aExames[nInd1,3])
						cLinha := Alltrim(aExames[nInd1,3,nInd,1])+": "
						For nInd2 := 1 To Len(aExames[nInd1,3,nInd,2])
							cLinha += Alltrim(aExames[nInd1,3,nInd,2,nInd2])+If(nInd2<>Len(aExames[nInd1,3,nInd,2]),", ",".")
						Next nInd2
						cLinha += CRLF
						cTexto += cLinha
					Next nInd
					If Len(aExames) <> nInd1
						cTexto += CRLF
					EndIf
				Next nInd1
				cTexto += "#*"
				If lAnexoA
					For nInd := 1 to Len(aAcoes)
						cTexto += Alltrim(aAcoes[nInd])+CRLF
					Next nInd
				Else
					For nInd := 1 to Len(aFunExames)
						cTexto += Padr(aFunExames[nInd,2],4)+Alltrim(aFunExames[nInd,1])+"%*"
					Next nInd
				EndIf

				OLE_SetDocumentVar(oWord,"Tabela",cTexto)
				OLE_ExecuteMacro(oWord,"Final_texto")
				If lAnexoA
					OLE_ExecuteMacro(oWord,"Tb_Anexo_Fun")
				Else
					OLE_SetDocumentVar(oWord,"Linhas",Len(aFunExames)+1)
					OLE_ExecuteMacro(oWord,"Tb_AnexoB_Fun")
					If TRBA->RA_CC <> cCentroC
						OLE_ExecuteMacro(oWord,"Final_texto")
						OLE_ExecuteMacro(oWord,"Somalinha")
					EndIf
				EndIf
			EndIf

			Dbselectarea("TRBA")
		End
		Dbselectarea("TRBA")
	End


	Dbselectarea("TRBA")
	DbCloseArea()
	Dbselectarea("TRBB")
	DbCloseArea()
	Dbselectarea("TRBC")
	DbCloseArea()
	Dbselectarea("TRBD")
	DbCloseArea()
	Dbselectarea("TRBE")
	DbCloseArea()
	Dbselectarea("TRBF")
	DbCloseArea()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} cMdt870Per
Retorna por extenso a quantidade de meses da periodicidade

@type    function
@author  Denis Hyroshi de Souza
@since   08/04/2003
@sample  U_cMdt870Per( 12, 1 )

@param   nPerExame, Numérico, Periodicidade do exame em meses
@param   [nPosAdm], Numérico, Se é periodicidade do (1) - Pós admissional
ou (2) - Pós admissional 2

@return  cPeriod, Caractere, String de descrição da priodicidade
/*/
//-------------------------------------------------------------------
User Function cMdt870Per( nPerExame, nPosAdm )

	Local cPeriod := Space(40)
	Local cAno
	Local cMes

	Default nPosAdm := 0

	cAno := Alltrim(Str(Int((nPerExame/12)),2))
	cMes := Alltrim(Str(nPerExame%12,2))
	cPerExame := Alltrim(Str(nPerExame,2))

	If nPerExame > 0

		If nPerExame > 12

			If cMes == '0'
				cPeriod := IIf( nPosAdm == 0, STR0140 + ' ', '' ) + cAno + ' ' + STR0141 //"a cada" //"anos"
			Else
				If cAno == '1'
					If cMes == '1'
						cPeriod := IIf(nPosAdm == 0, STR0140 + ' ', '' ) + '1 ' + STR0142 + ' ' + STR0143 + ;
										 ' 1 ' + STR0144 //"a cada" //"ano" //"e" //"mês"
					Else
						cPeriod := IIf(nPosAdm == 0, STR0140 + ' ', '' ) + '1 ' + STR0142 + ' ' + STR0143 + ' ' + ;
										cMes + ' ' + STR0145 //"a cada" //"ano" //"e" //"meses"
					EndIf
				Else
					If cMes == '1'
						cPeriod := IIf( nPosAdm == 0, STR0140 + ' ', '' ) + cAno + ' ' + STR0141 + ;
											' ' + STR0143 + ' 1 ' + STR0144 //"a cada" //"anos" //"e" //"mês"
					Else
						cPeriod := IIf(nPosAdm == 0, STR0140 + ' ', '' )   + cAno + ' ' + STR0141 + ' ' + ;
										STR0143 + ' ' + cMes + ' ' + STR0145 //"a cada" //"anos" //"e" //"meses"
					EndIf
				EndIf
			EndIf

		ElseIf nPerExame == 12

			cPeriod := IIf( nPosAdm == 0, STR0147, cAno + ' ' + STR0142 ) //"de 1 em 1 ano" //"ano"

		Else

			If nPerExame == 1
				cPeriod := IIf( nPosAdm == 0, STR0146, '1 ' + STR0144 )//"mensalmente" //"mês"
			Else
				cPeriod := IIf( nPosAdm == 0, STR0148 + ' ' + cPerExame + ' ' + STR0149 + ' ', '' ) + ;
								cPerExame + ' ' + STR0145 //"de" //"em" //"meses"
			EndIf

		EndIf

		If nPosAdm == 2
			cPeriod := ' / ' + cPeriod
		EndIf

		If nPosAdm == 0
			cPeriod := PADR( cPeriod, 40 )
		EndIf

	EndIf

Return cPeriod

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT870CC2
Agrupa as funcoes com o mesmo riscos e exames

@return .T., Lógico, sempre verdadeiro

@sample U_MDT870CC2()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function MDT870CC2(cRA_CC,cRA_CODFUN,cRiscos,cExames,cAcoes,lAnexoB,cPeriod,cPosAdm)

	Local aArea := GetArea()
	Local _cExames := " "
	Local _cPeriod := " "
	Local _cPosAdm := " "
	Local _cRiscos := " "
	Local _cAcoes  := " "
	Default lAnexoB := .F.

	Dbselectarea("TRBA")
	Dbskip()
	While !eof() .And. cRA_CC == TRBA->RA_CC
		If !Empty(TRBA->RA_CODFUN2)
			Dbselectarea("TRBA")
			DbSkip()
			Loop
		EndIf

		_cExames := " "
		_cPeriod := " "
		_cPosAdm := " "
		_cRiscos := " "
		_cAcoes  := " "
		_cExames2:= " "

		Dbselectarea("TRBC")
		Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_CC+TRBA->RA_CODFUN == TRBC->CC+TRBC->CODFUN
			_cRiscos += TRBC->NUMRIS
			DbSkip()
		End
		Dbselectarea("TRBD")
		dbSetOrder(1)
		Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_CC+TRBA->RA_CODFUN == TRBD->CC+TRBD->CODFUN
			_cExames += TRBD->EXAME
			_cPeriod += TRBD->PERIODIC
			_cPosAdm += TRBD->POSADM
			DbSkip()
		End
		Dbselectarea("TRBE")
		Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_CC+TRBA->RA_CODFUN == TRBE->CC+TRBE->CODFUN
			nGoTo_ := Val(TRBE->RECOME)
			If nGoTo_ > 0
				dbSelectArea("TO1")
				dbGoTo(nGoTo_)
				If !Eof()
					_cAcoes += Alltrim(TO1->TO1_RECOME)
				EndIf
			EndIf
			Dbselectarea("TRBE")
			DbSkip()
		End
		If lAnexoB
			Dbselectarea("TRBF")
			dbSetOrder(1)
			Dbseek(TRBA->RA_CC+TRBA->RA_CODFUN)
			While !eof() .And. TRBA->RA_CC+TRBA->RA_CODFUN == TRBF->CC+TRBF->CODFUN
				cExames2 += TRBF->EXAME+TRBF->NATUREZA
				DbSkip()
			End
		EndIf

		If _cExames == cExames .And. _cPeriod == cPeriod .And. _cPosAdm == cPosAdm .And. _cRiscos == cRiscos .And. _cAcoes == cAcoes .And. _cExames2 == cExames2
			Reclock("TRBA",.F.)
			TRBA->RA_CODFUN2 := cRA_CODFUN
			MsUnLock("TRBA")
		EndIf

		DbSelectArea("TRBA")
		DbSkip()
	End

	RestArea(aArea)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTCLI870
Atualiza a variavel cCliMdtps para filtrar corretamente os PCMSO's
e valida o cliente

@return .T., Lógico, sempre verdadeiro

@sample U_MDTCLI870()

@author	Andre Perez Alvarez
@since	20/12/2007
/*/
//---------------------------------------------------------------------
User Function MDTCLI870(nTipo)

	Local lRet := .T.

	If nTipo == 1
		If Empty(Mv_par02)
			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+Mv_par01)
			Mv_par02 := SA1->A1_LOJA
		EndIf
		lRet := ExistCpo('SA1',Mv_par01 + Mv_par02)
		cCliMdtps := Mv_par01 + Mv_par02
		Return lRet
	Else
		If !ExistCpo('SA1',Mv_par01 + Mv_par02)
			Return .F.
		EndIf
		cCliMdtps := Mv_par01 + Mv_par02
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT870TMW
Valida a pergunta PCMSO?

@return .T., Lógico, sempre verdadeiro

@sample U_MDT870TMW()

@author	Andre Perez Alvarez
@since	21/12/2007
/*/
//---------------------------------------------------------------------
User Function MDT870TMW(cPCMSO)

	dbSelectArea("TMW")
	dbSetOrder(1)
	dbSeek(xFilial("TMW")+cPCMSO)
	If cCliMdtps <> SubStr(TMW->TMW_CCDE,1,nSizeSA1+nSizeLo1)
		msgStop(STR0150) //"O PCMSO escolhido não pertence ao cliente."
		Return .F.
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDR870P4
Valida a pergunta De PCMSO (prestador de serviço)

@return .T., Lógico, sempre verdadeiro

@sample U_MDR870P4()

@author	Andre Perez Alvarez
@since	21/12/2007
/*/
//---------------------------------------------------------------------
User Function MDR870P4()

Return IF(vazio(),.T.,ExistCpo('TMW',Mv_par04) .And. U_MDT870TMW(Mv_par04))

//---------------------------------------------------------------------
/*/{Protheus.doc} MDR870P5
Valida a pergunta Ate PCMSO (prestador de serviço)

@return .T., Lógico, sempre verdadeiro

@sample U_MDR870P5()

@author	Andre Perez Alvarez
@since	21/12/2007
/*/
//---------------------------------------------------------------------
User Function MDR870P5()

Return ValAte(mv_par04,mv_par05,'TMW','TMW_PCMSO') .And. If(mv_par05=Replicate("Z",6),.T.,U_MDT870TMW(mv_par05))

//---------------------------------------------------------------------
/*/{Protheus.doc} fReguaPCMSO
Processa regua

@return .T., Lógico, sempre verdadeiro

@sample fReguaPCMSO()

@author	Andre Perez Alvarez
@since	03/05/2007
/*/
//---------------------------------------------------------------------
Static Function fReguaPCMSO( nLenMemo, nPerMemo, nLenAtual )

	Local nLenOld := (100 - nPerMemo) * ( nLenMemo / 100 ) //Calcula Len anterior
	Local nDiff := nLenOld - nLenAtual
	Local nFor,nPercent

	If nDiff > 0
		//Porcentagem que processou neste Loop
		nPercent := Round( (100 / nLenMemo) * nDiff , 0 )
		//Porcentagem processada
		nPerMemo += nPercent
		If nPercent >= 1 .And. nPercent <= 100
			For nFor := 1 To nPercent
				IncRegua()
			Next nFor
		EndIf
	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT870FLVL
Valida os campos De/Ate Filial

@return .T., Lógico, sempre verdadeiro

@sample U_MDT870FLVL()

@author	Denis Hyroshi
@since	04/08/2008
/*/
//---------------------------------------------------------------------
User Function MDT870FLVL(nTipo)

	Local lRet := .T.
	Local cArea := Alias()
	Local aArea := SM0->(GetArea())

	If nTipo == 1
		If !Empty(Mv_par06)
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+Mv_par06)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			EndIf
			If Mv_par06 > Mv_par07
				Mv_par07 := Mv_par06
			EndIf
		EndIf
	ElseIf nTipo == 2
		If Mv_par07 <> Replicate("Z",Len(Mv_par07)) .And. Mv_par07 <> Replicate("9",Len(Mv_par07))
			If Mv_par06 > Mv_par07
				Help(" ",1,"DEATEINVAL")
				lRet := .F.
			Else
				dbSelectArea("SM0")
				If !dbSeek(cEmpAnt+Mv_par07)
					Help(" ",1,"REGNOIS")
					lRet := .F.
				EndIf
			EndIf
		EndIf
	ElseIf nTipo == 3
		If !Empty(Mv_par08)
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+Mv_par08)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			EndIf
			If Mv_par08 > Mv_par09
				Mv_par09 := Mv_par08
			EndIf
		EndIf
	ElseIf nTipo == 4
		If Mv_par09 <> Replicate("Z",Len(Mv_par09)) .And. Mv_par09 <> Replicate("9",Len(Mv_par09))
			If Mv_par08 > Mv_par09
				Help(" ",1,"DEATEINVAL")
				lRet := .F.
			Else
				dbSelectArea("SM0")
				If !dbSeek(cEmpAnt+Mv_par09)
					Help(" ",1,"REGNOIS")
					lRet := .F.
				EndIf
			EndIf
		EndIf
	EndIf

	RestArea(aArea)
	dbSelectArea(cArea)

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} A870LISFUN
Lista funcionários do PCMSO

@return .T., Lógico, sempre verdadeiro

@sample U_A870LISFUN()

@author	Roger Rodrigues
@since	18/06/2010
/*/
//---------------------------------------------------------------------
User Function A870LISFUN()

	Local aArea := GetArea()
	Local i
	Local aListFun := {}
	Local cFuncao := ""

	If lSigaMdtps
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par03)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	Else
		dbSelectArea("TO0")
		dbSetOrder(1)
		Dbseek(xFilial("TO0")+mv_par01)
		dDeLaudo := TO0->TO0_DTINIC
		If	!Empty(TO0->TO0_DTFIM)
			dAteLaudo := TO0->TO0_DTFIM
		Else
			dAteLaudo := dDatabase
		EndIf
	EndIf

	//Carrega funcionarios em um array
	If lSigaMdtPs
		dbSelectArea("TOS")
		dbSetOrder(2)
		dbSeek(xFilial("TOS")+cCliMdtPs)
		While !EOF() .And. xFilial("TOS")+cCliMdtPs == TOS->(TOS_FILIAL+TOS_CLIENT+TOS_LOJA)
			dbSelectArea("SRA")
			dbSetOrder(2)
			dbSeek(xFilial("SRA")+cCliMdtPs,.T.)
			While !eof() .And. xFilial("SRA")+cCliMdtPs == SRA->RA_FILIAL+Substr(SRA->RA_CC,1,nSizeSA1+nSizeLo1)
				// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
				If !R870FUNC()
					DbSelectArea("SRA")
					DbSkip()
					Loop
				EndIf
				If	!Empty(cCCPCMSO) .And. lMdtUmCC .And. SRA->RA_ADMISSA <= dAteLaudo
					If TOS->TOS_CODFUN == SRA->RA_CODFUNC .And. SRA->RA_CC == cCCPCMSO
						aAdd(aListFun,{TOS->TOS_CODFUN, AllTrim(NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC")), SRA->RA_MAT, SRA->RA_NOME})
					EndIf
				Else
					If TOS->TOS_CODFUN == SRA->RA_CODFUNC .And. SRA->RA_ADMISSA <= dAteLaudo
						aAdd(aListFun,{TOS->TOS_CODFUN, AllTrim(NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC")), SRA->RA_MAT, SRA->RA_NOME})
					EndIf
				EndIf
				dbSelectArea("SRA")
				dbSkip()
			End
			dbSelectArea("TOS")
			dbSkip()
		End
	Else
		dbSelectArea("SRJ")
		dbSetOrder(3)
		dbSeek(xFilial("SRJ"))
		While !EOF() .And. xFilial("SRJ") == SRJ->RJ_FILIAL
			dbSelectArea("SRA")
			dbSetOrder(7)
			dbSeek(xFilial("SRA")+SRJ->RJ_FUNCAO)
			While !eof() .And. xFilial("SRA")+SRJ->RJ_FUNCAO == SRA->RA_FILIAL+SRA->RA_CODFUNC
				If SRA->RA_ADMISSA <= dAteLaudo
				// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
					If !R870FUNC()
						DbSelectArea("SRA")
						DbSkip()
						Loop
					EndIf
					//
					If	!Empty(cCCPCMSO) .And. lMdtUmCC
						If SRA->RA_CC == cCCPCMSO
							aAdd(aListFun,{SRJ->RJ_FUNCAO, AllTrim(SRJ->RJ_DESC), SRA->RA_MAT, SRA->RA_NOME})
						EndIf
					Else
						aAdd(aListFun,{SRJ->RJ_FUNCAO, AllTrim(SRJ->RJ_DESC), SRA->RA_MAT, SRA->RA_NOME})
					EndIf
				EndIf

				dbSelectArea("SRA")
				dbSkip()

			End
			dbSelectArea("SRJ")
			dbSkip()
		End
	EndIf
	//Ordena por Nome da Funcao+Nome do Funcionario
	aSort(aListFun,,,{|x,y| x[2]+x[4] < y[2]+y[4] })

	If Len(aListFun) > 0
		For i:=1 to Len(aListFun)
			lPrint := .T.
			//Se mudar de funcao imprime nome
			If cFuncao <> aListFun[i,1]
				If nModeloImp == 3
					Somalinha()
				EndIf
				U_IMPCAB870("{N}"+aListFun[i,2])
				cFuncao := aListFun[i,1]
			EndIf
			U_IMPTXT870(aListFun[i,4])//Nome do Funcionario
		Next i
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			Somalinha()
		EndIf
	EndIf

	dbSelectArea("SRJ")
	dbSetOrder(1)

	RestArea(aArea)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} Sente_Upper
Transforma a primeira palavra de uma sentença em maiúscula

@return .T., Lógico, sempre verdadeiro

@sample Sente_Upper()

@author	Andre Perez Alvarez
@since	03/05/2007
/*/
//---------------------------------------------------------------------
Static Function Sente_Upper(cTexto)

	Local cTextoNew := SubSTR(cTexto,1,1) + Lower(SubStr(cTexto,2))
	Local cTextoAux := ""

	While .T.

		nPos := at(". ",cTextoNew)
		If nPos > 0
			cTextoAux += SubSTR(cTextoNew,1,nPos+1)
			cTextoNew := Upper(SubSTR(cTextoNew,nPos+2,1)) + SubSTR(cTextoNew,nPos+3)
		Else
			cTextoAux += cTextoNew
			Exit
		EndIf

	End

Return cTextoAux

//---------------------------------------------------------------------
/*/{Protheus.doc} R870FUNC
Busca Funcionarios afastados e transferidos

@return .T., Lógico, sempre verdadeiro

@sample R870FUNC()

@author	Pedro C. Furst
@since	07/12/2011
/*/
//---------------------------------------------------------------------
Static Function R870FUNC()

	Local lAfast := .F.
	Local lRet   := .T.

	//Afastados anteriores ao período vigente do laudo e que continuam afastados
	lAfast := MDTChkSR8( "SR8", 1 ,	xFilial("SR8")+SRA->RA_MAT,;
													"xFilial('SR8')+SRA->RA_MAT == SR8->R8_FILIAL+SR8->R8_MAT" ,;
													TO0->TO0_DTINIC ,;
													dAteLaudo )
	If lAfast
		lRet   := .F.
	EndIf
	//Transferidos/Demitidos antes da vigência
	If SRA->RA_SITFOLH $ "T/D" .And. !Empty(SRA->RA_DEMISSA)
		If SRA->RA_DEMISSA <= TO0->TO0_DTINIC
			lRet   := .F.
		EndIf
	EndIf
	If SRA->RA_ADMISSA > dAteLaudo
		lRet   := .F.
	EndIf
	If SRA->RA_CATFUNC $ cFiltroF //Indica as Categorias Funcionais que nao aparecerao no PPRA
		lRet   := .F.
	EndIf

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} A870IMAGEM
Funcao para inserir imagem no doc

@return .T., Lógico, sempre verdadeiro

@sample A870IMAGEM()

@author	Denis
@since	04/08/2001
/*/
//---------------------------------------------------------------------
Static Function A870IMAGEM(cTitTemp)

	Local cFileArq := "", nPos
	Local cBarraSrv := "\"

	If nModeloImp != 1 //Se nao for em formato WORD, nao imprime
		Return
	EndIf

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	EndIf

	nPos := Rat(cBarraSrv,cTitTemp)
	If nPos > 0
		cFileArq := AllTrim(Substr(cTitTemp,nPos+1))
	EndIf

	CpyS2T(Alltrim(cTitTemp),cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario

	If File( cPathEst+cFileArq )
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Cria_Var",cPathEst+cFileArq)
		OLE_ExecuteMacro(oWord,"Insere_img")
	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} A870ARQUIVO
Funcao para inserir documentos no doc

@return .T., Lógico, sempre verdadeiro

@sample A870ARQUIVO()

@author	Denis
@since	04/08/2001
/*/
//---------------------------------------------------------------------
Static Function A870ARQUIVO(cTitTemp)

	Local cFileArq := "", nPos
	Local cBarraSrv := "\"

	If nModeloImp != 1 //Se nao for em formato WORD, nao imprime
		Return
	EndIf

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	EndIf

	nPos := Rat(cBarraSrv,cTitTemp)
	If nPos > 0
		cFileArq := AllTrim(Substr(cTitTemp,nPos+1))
	EndIf

	CpyS2T(Alltrim(cTitTemp),cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario

	If File( cPathEst+cFileArq )
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Cria_Var",cPathEst+cFileArq)
		OLE_ExecuteMacro(oWord,"Insere_doc")
	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} A870PLAN()
Imprime os planos do laudo (PCMSO)

@author André Felipe Joriatti
@since 03/07/2012
@version MP11
@return Nil
/*/
//---------------------------------------------------------------------
Static Function A870PLAN()

	Local   aArea     := GetArea()
	Local   svlPrint  := lPrint
	Local   svlPrin2  := lPrin2
	Private lAchou    := .F.
	Private aPlanos   := {}

	f870PlaAca()

	lPrint := svlPrint
	lPrin2 := svlPrin2

	If lAchou
		Somalinha()
		Somalinha()
	EndIf

	RestArea(aArea)

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} A870CRON()
Imprime os cronogramas do laudo (PCMSO)

@author André Felipe Joriatti
@since 03/07/2012
@version MP11
@return Nil
/*/
//---------------------------------------------------------------------
Static Function A870CRON()

	Local aArea := GetArea()
	Local aPlanos := {}
	Local _1st := .T.
	Local nRegs := 0
	Local cMemo := ""
	Local cPadrao := ""
	Local cPadrao2 := ""
	Local cPadrao3 := ""
	Local nFor
	Local dDtIniCro := cTod("//")
	Local nAnoIni := 0
	Local nMesIni := 0
	Local nAnoFim := 0
	Local nMesFim := 0
	//"Jan/","Fev/","Mar/","Abr/","Mai/","Jun/","Jul/","Ago/","Set/","Out/","Nov/","Dez/","Jan/","Fev/","Mar/","Abr/","Mai/","Jun/","Jul/","Ago/","Set/","Out/","Nov/","Dez/"}
	Local aMes    := {STR0176,STR0177,STR0178,STR0179,STR0180,STR0181,STR0182,STR0183,STR0184,STR0185,STR0186,STR0187,STR0176,STR0177,STR0178,STR0179,STR0180,STR0181,STR0182,STR0183,STR0184,STR0185,STR0186,STR0187}
	Local dtFimReal
	Local dtFimPrev
	Local cMemo2 := ""
	Local lAcao
	Local lPrim1 := .T.
	Local cAcoes := "", cAno := ""
	Local nLinha := 0, LinhaCorrente := 0
	Local nMarEsq	:= 150
	Local nMarDir 	:= 2250
	Local nMeiLin	:= 40

	f870PlaAca(@aPlanos)

	ASORT(aPlanos,,,{|x,y| x[2] < y[2] })
	If Len(aPlanos) > 0
		dDtIniCro := TO0->TO0_DTINIC
		nAnoIni := Year(dDtIniCro)
		nMesIni := Month(dDtIniCro)
		nAnoFim := Year(dDtIniCro)+1
		nMesFim := Month(dDtIniCro)
	EndIf

	For nFor := 1 to Len(aPlanos)
		If nFor == 1
			cMemo += STR0188+" #*"  //"AÇÕES / MÊS"
			cMemo += aMes[nMesIni]+SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+1]+SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+2]+SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+3]+SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+4]+SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+5]+SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+6]+SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+7]+SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+8]+SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+9]+SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+10]+SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+11]+SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+12]+SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2)+" #*"

			cPadrao += STR0188+Space(22)
			cPadrao += aMes[nMesIni]+Space(2)
			cAno += SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+1]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+2]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+3]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+4]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+5]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+6]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+7]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+8]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+9]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+10]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+11]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+12]
			cAno += SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		EndIf     //OK

		If nModeloImp == 2 .And. lPrim1// 2 - Padrão
	    	Somalinha()
	    	Somalinha()
			@ Li,001 Psay cPadrao
			Somalinha()
			@ Li,034 Psay cAno
			Somalinha()
			@ Li,001 Psay ("_______________________________________________________________________________________________________________")
		  	lPrim1 := .F.
			Somalinha()
		EndIf

	 	If nModeloImp == 1 .Or. nModeloImp == 2
			lAcao := .F.
			If !(Year(aPlanos[nFor,2]) > nAnoFim .And. Month(aPlanos[nFor,2]) > nMesFim) //Se a data inicial prevista está dentro do cronograma

				cMemo += Sente_Upper(Alltrim(aPlanos[nFor,1])) +" #*"
				cAcoes := Sente_Upper(Alltrim(aPlanos[nFor,1]))
				lAcao := .T.
				//Mes 1
				cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 2
				cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 3
				cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 4
				cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 5
				cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 6
				cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 7
				cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 8
				cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 9
				cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 10
				cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 11
				cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 12
				cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
				//Mes 13
				cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
				cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X"," ")
		Else
			//Mes 1
			cMemo2 += " "+"#*"
			//Mes 2
			cMemo2 += " "+"#*"
			//Mes 3
			cMemo2 += " "+"#*"
			//Mes 4
			cMemo2 += " "+"#*"
			//Mes 5
			cMemo2 += " "+"#*"
			//Mes 6
			cMemo2 += " "+"#*"
			//Mes 7
			cMemo2 += " "+"#*"
			//Mes 8
			cMemo2 += " "+"#*"
			//Mes 9
			cMemo2 += " "+"#*"
			//Mes 10
			cMemo2 += " "+"#*"
			//Mes 11
			cMemo2 += " "+"#*"
			//Mes 12
			cMemo2 += " "+"#*"
			//Mes 13
			cMemo2 += " "+"#*"
		EndIf

		If !(Year(aPlanos[nFor,4]) > nAnoFim .And. Month(aPlanos[nFor,4]) > nMesFim); //Se a data inicial real está dentro do cronograma
				.And. !Empty(aPlanos[nFor,4]) //Dt Real Ini *e* Final preenchidas

			If !lAcao
				cMemo += Sente_Upper(Alltrim(aPlanos[nFor,1])) +" #*"
			EndIf
			//Mes 1
				cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 2
				cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 3
				cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 4
				cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 5
				cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 6
				cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 7
				cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 8
				cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 9
				cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 10
				cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 11
				cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 12
				cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
				//Mes 13
				cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
				cMemo2 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
				cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X"," ")
			Else
				//Mes 1
				cMemo2 += " "+"#*"
				//Mes 2
				cMemo2 += " "+"#*"
				//Mes 3
				cMemo2 += " "+"#*"
				//Mes 4
				cMemo2 += " "+"#*"
				//Mes 5
				cMemo2 += " "+"#*"
				//Mes 6
				cMemo2 += " "+"#*"
				//Mes 7
				cMemo2 += " "+"#*"
				//Mes 8
				cMemo2 += " "+"#*"
				//Mes 9
				cMemo2 += " "+"#*"
				//Mes 10
				cMemo2 += " "+"#*"
				//Mes 11
				cMemo2 += " "+"#*"
				//Mes 12
				cMemo2 += " "+"#*"
				//Mes 13
				cMemo2 += " "+"#*"
			EndIf
			If nModeloImp == 2 // 2 - Padrão
				Somalinha()
	  		  	@ Li,000 Psay AllTrim(Str(nFor)+"-"+SubStr(cAcoes,1,30))
	   		@ Li,033 Psay "P"//"Planejado"
		    	@ Li,035 Psay cPadrao2
	   	 	Somalinha()
	   	 	@ Li,033 Psay "E"//"Executado"
				@ Li,035 Psay cPadrao3
				Somalinha()
				cPadrao2 := ""
				cPadrao3 := ""
			EndIf
		EndIf
		If nModeloImp == 3  //3 - Gráfico
				Somalinha()
			If lPrim1
				oPrintPPRA:Say( lin + nMeiLin, 180, STR0188, oFont08b ) //"AÇÕES / MÊS"
				oPrintPPRA:Line( lin, nMarEsq, lin + 60, nMarEsq )
				oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, nMarEsq, lin, nMarDir )
				oPrintPPRA:Line(lin,650,lin+60,650)
				oPrintPPRA:Line(lin,775,lin+60,775)
				oPrintPPRA:Line(lin,900,lin+60,900)
				oPrintPPRA:Line(lin,1025,lin+60,1025)
				oPrintPPRA:Line(lin,1150,lin+60,1150)
				oPrintPPRA:Line(lin,1275,lin+60,1275)
				oPrintPPRA:Line(lin,1400,lin+60,1400)
				oPrintPPRA:Line(lin,1525,lin+60,1525)
		  		oPrintPPRA:Line(lin,1650,lin+60,1650)
		  		oPrintPPRA:Line(lin,1775,lin+60,1775)
		  		oPrintPPRA:Line(lin,1900,lin+60,1900)
		  		oPrintPPRA:Line(lin,2025,lin+60,2025)
		  		oPrintPPRA:Line(lin,2150,lin+60,2150)

	  			oPrintPPRA:Say( lin + nMeiLin, 680,aMes[nMesIni]+SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 800,aMes[nMesIni+1]+SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 930,aMes[nMesIni+2]+SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 1050,aMes[nMesIni+3]+SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 1180,aMes[nMesIni+4]+SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 1320,aMes[nMesIni+5]+SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 1440,aMes[nMesIni+6]+SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 1560,aMes[nMesIni+7]+SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 1690,aMes[nMesIni+8]+SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 1810,aMes[nMesIni+9]+SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 1930,aMes[nMesIni+10]+SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 2060,aMes[nMesIni+11]+SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			oPrintPPRA:Say( lin + nMeiLin, 2170,aMes[nMesIni+12]+SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
	  			Somalinha()
				lPrim1 := .F.
			EndIf


			lAcao := .F.
			If !(Year(aPlanos[nFor,2]) > nAnoFim .And. Month(aPlanos[nFor,2]) > nMesFim) //Se a data inicial prevista está dentro do cronograma

				cAcoes := Sente_Upper(Alltrim(aPlanos[nFor,1]))
				lAcao := .T.

				//Mes 1
				cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,713,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 2
				cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,838,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 3
				cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,963,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 4
				cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,1088,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 5
				cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,1213,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 6
				cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,1338,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 7
				cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,1463,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 8
				cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,1588,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 9
				cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,1713,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 10
				cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,1838,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 11
				cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,1963,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 12
				cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,2088,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
				//Mes 13
				cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
				oPrintPPRA:Say( lin+ nMeiLin,2213,If(cDtTemp >= aPlanos[nFor,2].And. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			EndIf

			If !(Year(aPlanos[nFor,4]) > nAnoFim .And. Month(aPlanos[nFor,4]) > nMesFim); //Se a data inicial real está dentro do cronograma
					.And. !Empty(aPlanos[nFor,4]) //Dt Real Ini *e* Final preenchidas

				//Mes 1
				cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 713,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 2
				cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 838,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 3
				cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 963,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 4
				cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 1088,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 5
				cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 1213,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 6
				cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 1338,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 7
				cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 1463,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 8
				cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 1588,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 9
				cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 1713,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 10
				cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 1838,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 11
				cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 1963,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 12
				cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 2088,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
				//Mes 13
				cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
				oPrintPPRA:Say( lin + nMeiLin * 2.5, 2213,If(cDtTemp >= aPlanos[nFor,4].And. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			EndIf

			If nModeloImp == 3  //3 - Gráfico
			  	//oPrintPPRA:Line(lin,800,lin,2300)
			  	oPrintPPRA:Line( lin, nMarEsq, lin + 60, nMarEsq )
			  	oPrintPPRA:Line(lin,570,lin+60,570)
			  	oPrintPPRA:Line(lin,650,lin+60,650)
			  	oPrintPPRA:Line(lin,775,lin+60,775)
				oPrintPPRA:Line(lin,900,lin+60,900)
				oPrintPPRA:Line(lin,1025,lin+60,1025)
				oPrintPPRA:Line(lin,1150,lin+60,1150)
				oPrintPPRA:Line(lin,1275,lin+60,1275)
				oPrintPPRA:Line(lin,1400,lin+60,1400)
				oPrintPPRA:Line(lin,1525,lin+60,1525)
				oPrintPPRA:Line(lin,1650,lin+60,1650)
				oPrintPPRA:Line(lin,1775,lin+60,1775)
		  		oPrintPPRA:Line(lin,1900,lin+60,1900)
		  		oPrintPPRA:Line(lin,2025,lin+60,2025)
		  		oPrintPPRA:Line(lin,2150,lin+60,2150)
		  		oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )
		  		//oPrintPPRA:Line(lin,2400,lin+60,2400)
		  		//oPrintPPRA:Line(lin,2300,lin+60,2300)
		  		oPrintPPRA:Line( lin, nMarEsq, lin, nMarDir )
		  		nLinhasMemo := MLCOUNT(AllTrim(cAcoes),17)
		  		oPrintPPRA:Say( lin + nMeiLin, 170, AllTrim( Str( nFor ) + " - "), oFont08b )
		  		nLinha := lin
				For LinhaCorrente := 1 to nLinhasMemo
					If	LinhaCorrente > 2
						Exit
					EndIf
					If !empty( (MemoLine(cAcoes,17,LinhaCorrente)))
			   		oPrintPPRA:Say( nLinha + nMeiLin, 220, MemoLine( cAcoes, 17, LinhaCorrente ), oFont08b )
			   		nLinha := lin + 60
					EndIf
			    Next
		  		//oPrintPPRA:Say(lin,170,AllTrim(Str(nFor)+" - "+SubStr(cAcoes,1,30)),oFont08b)
		    	oPrintPPRA:Say(lin + nMeiLin, 600, "P", oFont08b ) // "Planejado"
		      SomaLinha()
		      oPrintPPRA:Line( lin, 575, lin, nMarDir ) //linhas
		      oPrintPPRA:Line( lin, nMarEsq, lin + 60, nMarEsq )
			  	oPrintPPRA:Line(lin,570,lin+60,570)
		  		oPrintPPRA:Line(lin,650,lin+60,650)
			  	oPrintPPRA:Line(lin,775,lin+60,775)
				oPrintPPRA:Line(lin,900,lin+60,900)
				oPrintPPRA:Line(lin,1025,lin+60,1025)
				oPrintPPRA:Line(lin,1150,lin+60,1150)
				oPrintPPRA:Line(lin,1275,lin+60,1275)
				oPrintPPRA:Line(lin,1400,lin+60,1400)
				oPrintPPRA:Line(lin,1525,lin+60,1525)
				oPrintPPRA:Line(lin,1650,lin+60,1650)
				oPrintPPRA:Line(lin,1775,lin+60,1775)
		  		oPrintPPRA:Line(lin,1900,lin+60,1900)
		  		oPrintPPRA:Line(lin,2025,lin+60,2025)
		  		oPrintPPRA:Line(lin,2150,lin+60,2150)
		  		oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )
				oPrintPPRA:Say( lin + nMeiLin, 600, "E", oFont08b )//"Executado"
			EndIf
		EndIf
	Next nFor

	nRegs := Len(aPlanos)
	If nRegs > 0
		If nModeloImp == 1//Word


	    	OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Tabela2",cMemo2)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Cronograma")
			_lJumpCab := lJumpCab
			lJumpCab := .T.
			lJumpCab := .T.
			IMPHEA850("{CN}P: "+STR0189,.F.)  //"Planejado"
			lJumpCab := .T.
			IMPHEA850("{CN}E: "+STR0190,.F.)  //"Executado"
			lJumpCab := _lJumpCab
			OLE_ExecuteMacro(oWord,"Somalinha")
	    	OLE_ExecuteMacro(oWord,"Somalinha")
		ELseIf nModeloImp == 2  //2 - Padrão
	   	SomaLinha()
	  		@ Li,055 Psay "P: "+STR0189
	  		Somalinha()
			@ Li,055 Psay "E: "+STR0190
			Somalinha()
	   ELseIf nModeloImp == 3  //3 - Gráfico
	   	SomaLinha()
		  	oPrintPPRA:Line( lin, nMarEsq, lin, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 1220, "P: " + STR0189, oFont08b )
		  	SomaLinha()
		  	oPrintPPRA:Say( lin + nMeiLin, 1220, "E: " + STR0190, oFont08b )
	    EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} f870PlaAca
Faz a pesquisa padrao no Plano de Ação
Uso MDTR870

@return

@sample
f870PlaAca()

@since 23/11/2012
@version 1.0
/*/
//---------------------------------------------------------------------
Static Function f870PlaAca(aParPlanos)

	Local nIndTOZ, nIndPA, nIndTNJ, nIndTO1, nIndTN0
	Local cSeekTOZ, cSeekPA, cSeekTNJ, cSeekTO1, cSeekTN0
	Local cWhileTOZ, cWhileTNJ
	Local lExitPla := Type("aPlanos") == "A"

	If lSigaMdtps

		If Empty( trim(cCliMdtPs) ) //Caso cCliMdtPs venha vazio, pois quando o usuário nao abre a tela de parametros do relatório essa variável vem vazia
			If Empty(Mv_par02)
				dbSelectArea("SA1")
				dbSetOrder(1)
				dbSeek(xFilial("SA1")+Mv_par01)
				Mv_par02 := SA1->A1_LOJA
			EndIf

			cCliMdtPs := Mv_par01 + Mv_par02
		EndIf
		nIndTOZ   := 3
		nIndPA    := 5
		nIndTNJ   := 4
		nIndTO1   := 3
		nIndTN0   := 8
		cSeekTOZ  := xFilial("TOZ") + cCliMdtPs + TO0->TO0_LAUDO
		cWhileTOZ := "xFilial('TOZ')+TO0->TO0_LAUDO == TOZ->TOZ_FILIAL+TOZ->TOZ_LAUDO .And. cCliMdtPs == TOZ->TOZ_CLIENT+TOZ->TOZ_LOJA"
		cWhileTNJ := "xFilial('TNJ')+"+(cAliasPA)+"->"+(aFieldPA[2])+" == TNJ->TNJ_FILIAL+TNJ->TNJ_CODPLA .And. cCliMdtPs == TNJ->TNJ_CLIENT + TNJ->TNJ_LOJA"
	Else
		nIndTOZ   := 1
		nIndPA    := 1
		nIndTNJ   := 2
		nIndTO1   := 1
		nIndTN0   := 1
		cSeekTOZ  := xFilial("TOZ") + TO0->TO0_LAUDO
		cWhileTOZ := "TOZ->TOZ_FILIAL == xFilial('TOZ') .And. TOZ->TOZ_LAUDO == TO0->TO0_LAUDO"
		cWhileTNJ := "xFilial('TNJ')+"+(cAliasPA)+"->"+(aFieldPA[2])+" == TNJ->TNJ_FILIAL+TNJ->TNJ_CODPLA"
	EndIf

	Dbselectarea("TOZ")
	Dbsetorder(nIndTOZ)
	Dbseek(cSeekTOZ)
	While !eof() .And. &(cWhileTOZ)
		If lSigaMdtPs
			cSeekPA := xFilial( cAliasPA ) + cCliMdtPs + TOZ->TOZ_PLANO
		Else
			cSeekPA := xFilial( cAliasPA )+TOZ->TOZ_PLANO
		EndIf
		DbSelectArea( cAliasPA )
		DbSetOrder(nIndPA)
		If Dbseek(cSeekPA)

			If lSigaMdtPs
				cSeekTNJ := xFilial("TNJ")+cCliMdtPs+(cAliasPA)->&(aFieldPA[2])
			Else
				cSeekTNJ := xFilial("TNJ")+(cAliasPA)->&(aFieldPA[2])
			EndIf
			Dbselectarea("TNJ")
			Dbsetorder(nIndTNJ)
			If Dbseek(cSeekTNJ)
				While !eof() .And. &(cWhileTNJ)

					If lSigaMdtPs
						cSeekTO1 := xFilial("TO1")+cCliMdtPs+TO0->TO0_LAUDO+TNJ->TNJ_NUMRIS
					Else
						cSeekTO1 := xFilial("TO1")+TO0->TO0_LAUDO+TNJ->TNJ_NUMRIS
					EndIf
					Dbselectarea("TO1")
					Dbsetorder(nIndTO1)
					If !Dbseek(cSeekTO1)
						DbSelectArea("TNJ")
						DbSkip()
						Loop
					EndIf

					If lSigaMdtPs
						cSeekTN0 := xFilial("TN0")+cCliMdtPs+TO1->TO1_NUMRIS
					Else
						cSeekTN0 := xFilial("TN0")+TO1->TO1_NUMRIS
					EndIf

					Dbselectarea("TN0")
					Dbsetorder(nIndTN0)  //TN0_FILIAL+TN0_CODCLI+TN0_LOJACL+TN0_NUMRIS
					If !Dbseek(cSeekTN0)
						Dbselectarea("TNJ")
						Dbskip()
						Loop
					Else
						If TN0->TN0_MAPRIS == "1"
							Dbselectarea("TNJ")
							Dbskip()
							Loop
						EndIf
					EndIf

					If lExitPla
						If aScan(aPlanos,{|x| x == TNJ->TNJ_CODPLA}) > 0
							DbSelectArea("TNJ")
							Dbskip()
							Loop
						EndIf
					Else
						If aScan(aParPlanos,{|x| x[6] == TNJ->TNJ_CODPLA}) > 0
							DbSelectArea("TNJ")
							Dbskip()
							Loop
						EndIf
					EndIf

					If ValType(aParPlanos) <> "U"
						If !Empty((cAliasPA)->&(aFieldPA[8])) .Or. !Empty((cAliasPA)->&(aFieldPA[6]))

							If !Empty((cAliasPA)->&(aFieldPA[7]))
								dtFimPrev := (cAliasPA)->&(aFieldPA[7])
							Else
								dtFimPrev := CtoD("01/01/2040")
							EndIf

							If !Empty((cAliasPA)->&(aFieldPA[9]))
								dtFimReal := (cAliasPA)->&(aFieldPA[9])
							Else
								dtFimReal := CtoD("01/01/2040")
							EndIf

							aADD(aParPlanos,{(cAliasPA)->&(aFieldPA[3]),(cAliasPA)->&(aFieldPA[6]),dtFimPrev,(cAliasPA)->&(aFieldPA[8]),dtFimReal,(cAliasPA)->&(aFieldPA[2])})
						EndIf
					Else
						Dbselectarea("TMK")
						Dbsetorder(1)
						Dbseek(xFilial("TMK")+(cAliasPA)->&(aFieldPA[11]))
						Plano850()
					EndIf

					Dbselectarea("TNJ")
					DbSkip()
				EndDo
			Else
				If ValType(aParPlanos) <> "U"
					If !Empty((cAliasPA)->&(aFieldPA[8])) .Or. !Empty((cAliasPA)->&(aFieldPA[6]))

						If !Empty((cAliasPA)->&(aFieldPA[7]))
							dtFimPrev := (cAliasPA)->&(aFieldPA[7])
						Else
							dtFimPrev := CtoD("01/01/2040")
						EndIf

						If !Empty((cAliasPA)->&(aFieldPA[9]))
							dtFimReal := (cAliasPA)->&(aFieldPA[9])
						Else
							dtFimReal := CtoD("01/01/2040")
						EndIf

						aADD(aParPlanos,{(cAliasPA)->&(aFieldPA[3]),(cAliasPA)->&(aFieldPA[6]),dtFimPrev,(cAliasPA)->&(aFieldPA[8]),dtFimReal,(cAliasPA)->&(aFieldPA[2])})
					EndIf
				Else
					Dbselectarea("TMK")
					Dbsetorder(1)
					Dbseek(xFilial("TMK")+(cAliasPA)->&(aFieldPA[11]))
					Plano850()
				EndIf
			EndIf
		EndIf
		dbselectarea("TOZ")
		TOZ->(dbSkip())
	EndDo

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} f870PRVAC
Imprime Programação de Vacinas
Uso MDTR870

@return

@sample
fA870PRVAC()

@since 25/01/2012
@version 1.0
/*/
//---------------------------------------------------------------------
Static Function fA870PRVAC()

	Local aVacina 	:= {} // Registros das vacinas

	Local cLista 	:= '' // Lista de impressão
	Local cTitulos	:= ''
	Local cAliasTL9 := ''

	Local nVezes	:= 1 // Quantidade de vezes que a macro foi executada
	Local nVacina 	:= 0 // Controlador do For
	Local nLimite 	:= 500 // Limite de registros impressos por vez
	Local nVacinas	:= Len( aVacina ) // Quantidade total de vacinas a ser impressa
	Local nRegImp 	:= IIf( nVacinas > nLimite, nLimite, nVacinas ) // Número de registros que será impresso na vez
	Local nTotalVac := nVacinas // Total de vacinas
	Local nVezesImp := 1 // Controlador do While
	Local nMarEsq 	:= 150 // Margem esquerda máxima
	Local nMarDir	:= 2250 // Margem direita máxima
	Local nLinMei	:= 40 // Meio da linha
	Local nTamCen	:= 1 // Número de linhas necessárias para o centro de custo
	Local nLinha 	:= 1

	If nModeloImp == 1

		cTitulos += STR0291 + '@'
		cTitulos += STR0193 + '#'
		cTitulos += STR0194 + '#'
		cTitulos += STR0195 + '#'
		cTitulos += STR0196 + '#'
		cTitulos += STR0197 + '#'
		cTitulos += STR0198 + '#'
		cTitulos += STR0199 + '#'
		cTitulos += STR0200 + '#'

	EndIf

	cAliasTL9 := GetNextAlias()

	BeginSQL Alias cAliasTL9
		SELECT DISTINCT
			TL9.TL9_VACINA, TL6.TL6_NOMVAC, TL9.TL9_DTPREV, TL9.TL9_NUMFIC,
			TM0.TM0_NOMFIC, CTT.CTT_DESC01, TL9.TL9_DOSE, TL9.TL9_INDVAC
		FROM
			%table:TL9% TL9
				INNER JOIN %table:TL6% TL6 ON
					TL6.TL6_FILIAL = %xFilial:TL6% AND
					TL6.TL6_VACINA = TL9.TL9_VACINA AND
					TL6.%notDel%
				INNER JOIN %table:TM0% TM0 ON
					TM0.TM0_FILIAL = %xFilial:TM0% AND
					TM0.TM0_NUMFIC = TL9.TL9_NUMFIC AND
					TM0.%notDel%
				INNER JOIN %table:CTT% CTT ON
					CTT.CTT_FILIAL = %xFilial:CTT% AND
					CTT.CTT_CUSTO = TM0.TM0_CC AND
					CTT.%notDel%
		WHERE
			TL9.TL9_FILIAL = %xFilial:TL9%
			AND %exp:dDeLaudo% <= TL9.TL9_DTPREV
			AND %exp:dAteLaudo% >= TL9.TL9_DTPREV
			AND TL9.%notDel%
		ORDER BY
			TL9.TL9_NUMFIC, TL9.TL9_DTPREV
	EndSQL

	While ( cAliasTL9 )->( !EoF() )

		aAdd( aVacina, {;
			AllTrim( ( cAliasTL9 )->TL9_VACINA ),;
			AllTrim( ( cAliasTL9 )->TL6_NOMVAC ),;
			DtoC( StoD( ( cAliasTL9 )->TL9_DTPREV ) ),;
			AllTrim( ( cAliasTL9 )->TL9_NUMFIC ),;
			AllTrim( ( cAliasTL9 )->TM0_NOMFIC ),;
			AllTrim( ( cAliasTL9 )->CTT_DESC01 ),;
			AllTrim( ( cAliasTL9 )->TL9_DOSE ),;
			AllTrim( IIf( ( cAliasTL9 )->TL9_INDVAC == '3', STR0192, NgRetSx3Box( 'TL9_INDVAC' , ( cAliasTL9 )->TL9_INDVAC ) ) );
		} )

		( cAliasTL9 )->( DbSkip() )

	EndDo

	( cAliasTL9 )->( DbCloseArea() )

	If nModeloImp == 1

		nVacinas	:= Len( aVacina )
		nRegImp 	:= IIf( nVacinas > nLimite, nLimite, nVacinas )
		nTotalVac := nVacinas

		For nVacina := 1 To nRegImp
			cLista += aVacina[ nVacina, 1 ] + '$'
			cLista += aVacina[ nVacina, 2 ] + '$'
			cLista += aVacina[ nVacina, 3 ] + '$'
			cLista += aVacina[ nVacina, 4 ] + '$'
			cLista += aVacina[ nVacina, 5 ] + '$'
			cLista += aVacina[ nVacina, 6 ] + '$'
			cLista += aVacina[ nVacina, 7 ] + '$'
			cLista += aVacina[ nVacina, 8 ] + '$'
		Next

		OLE_SetDocumentVar( oWord, 'titulo_programacao_vacinas', cTitulos )
		OLE_SetDocumentVar( oWord, 'programacao_vacinas', cLista )
		OLE_SetDocumentVar( oWord, 'numero_programacao_vacinas', nVacinas )
		OLE_SetDocumentVar( oWord, 'limite_programacao_vacinas', nLimite )
		OLE_ExecuteMacro( oWord, 'programacao_vacinas' )

		nVacinas -= nLimite

		While nVacinas > 0

			cLista := ''

			nVacina := ( nLimite * nVezes + 1 )
			nRegImp := nTotalVac - ( nLimite * nVezes )
			nVezesImp := 1

			While nVezesImp <= nLimite .And. nVezesImp <= nVacinas

				cLista += aVacina[ nVacina, 1 ] + '$'
				cLista += aVacina[ nVacina, 2 ] + '$'
				cLista += aVacina[ nVacina, 3 ] + '$'
				cLista += aVacina[ nVacina, 4 ] + '$'
				cLista += aVacina[ nVacina, 5 ] + '$'
				cLista += aVacina[ nVacina, 6 ] + '$'
				cLista += aVacina[ nVacina, 7 ] + '$'
				cLista += aVacina[ nVacina, 8 ] + '$'

				nVacina++
				nVezesImp++

			End

			nVezes += 1

			OLE_SetDocumentVar( oWord, 'programacao_vacinas_continuacao', cLista )
			OLE_SetDocumentVar( oWord, 'numero_programacao_vacinas_continuacao', nVacinas )
			OLE_SetDocumentVar( oWord, 'limite_programacao_vacinas_continuacao', nLimite )
			OLE_ExecuteMacro( oWord, 'programacao_vacinas_continuacao' )

			nVacinas -= nLimite

		End

	ElseIf nModeloImp == 3

		For nVacina := 1 To Len( aVacina )

			If nVacina > 1

				nTamCen := MlCount( aVacina[ nVacina, 6 ], 24 )
				nTamCen := IIf( nTamCen > 1, nTamCen, 1 )

				oPrintPPRA:Box( lin, nMarEsq, lin + ( 60 * nTamCen ), nMarDir )
				oPrintPPRA:Say( lin + nLinMei, 170, aVacina[ nVacina, 2 ], oFont10 )
				oPrintPPRA:Line( lin, 700, lin + ( 60 * nTamCen ), 700 )
				oPrintPPRA:Say( lin + nLinMei, 720, aVacina[ nVacina, 3 ], oFont10 )
				oPrintPPRA:Line( lin, 900, lin + ( 60 * nTamCen ), 900 )
				oPrintPPRA:Say( lin + nLinMei, 920, aVacina[ nVacina, 5 ], oFont10 )
				oPrintPPRA:Line( lin, 1550, lin + ( 60 * nTamCen ), 1550 )
				oPrintPPRA:Line( lin, 1950, lin + ( 60 * nTamCen ), 1950 )
				oPrintPPRA:Say( lin + nLinMei, 1970, aVacina[ nVacina, 7 ], oFont10 )
				oPrintPPRA:Line( lin, 2100, lin + ( 60 * nTamCen ), 2100 )
				oPrintPPRA:Say( lin + nLinMei, 2120, aVacina[ nVacina, 8 ], oFont10 )

				For nLinha := 1 To nTamCen
					oPrintPPRA:Say( lin + nLinMei, 1570, MemoLine( aVacina[ nVacina, 6 ], 24, nLinha ), oFont10 )
					Somalinha()
				Next nLinha

			Else

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Say( lin + nLinMei, 350, STR0194, oFont10b ) // "Nome da Vacina"
				oPrintPPRA:Line( lin, 700, lin + 60, 700 )
				oPrintPPRA:Say( lin + nLinMei, 720, STR0195, oFont10b ) // "Data Programada"
				oPrintPPRA:Line( lin, 900, lin + 60, 900 )
				oPrintPPRA:Say( lin + nLinMei, 1100, STR0197, oFont10b ) // "Nome do Funcionario"
				oPrintPPRA:Line( lin, 1550, lin + 60, 1550 )
				oPrintPPRA:Say( lin + nLinMei, 1650, STR0198, oFont10b ) // "Centro de Custo"
				oPrintPPRA:Line( lin, 1950, lin + 60, 1950 )
				oPrintPPRA:Say( lin + nLinMei, 2000, STR0199, oFont10b ) // "Dose"
				oPrintPPRA:Line( lin, 2100, lin + 60, 2100 )
				oPrintPPRA:Say( lin + nLinMei, 2120, STR0200, oFont10b ) // "Aplicada"

				Somalinha()

			EndIf

		Next nVacina

	ElseIf nModeloImp == 2

		For nVacina := 1 To Len( aVacina )

			If nVacina == 1
				@Li, 000 Psay STR0194 + Space( 16 ) +;
				STR0195 + Space( 1 ) +;
				STR0197 + Space( 15 ) +;
				STR0198 + Space( 15 ) +;
				STR0199 + Space( 7 ) +;
				STR0200
				Somalinha()
			Else
				@Li, 000 Psay aVacina[ nVacina, 2 ]
				@Li, 030 Psay aVacina[ nVacina, 3 ]
				@Li, 042 Psay aVacina[ nVacina, 5 ]
				@Li, 080 Psay aVacina[ nVacina, 6 ]
				@Li, 095 Psay aVacina[ nVacina, 7 ]
				@Li, 100 Psay aVacina[ nVacina, 8 ]
				Somalinha()
			EndIf

		Next nVacina

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} A870REQUIS
Impressão de Requisitos do Laudo
Uso MDTR870

@return

@sample
A870REQUIS()

@since 01/02/2013
@version 1.0
/*/
//---------------------------------------------------------------------
Static Function A870REQUIS()

	Local aArea := GetArea()
	//Variaveis de Busca
	Local mx_LAUDO := mv_par01
	Local cKeyPsq    := ""
	Local cCondTJA := "TJA->TJA_FILIAL + TJA->TJA_LAUDO"
	Local nIndTJA := 1
	//Variaveis de relatorio
	Local nRegs := 18 // Variavel pra impressao de word, numero de linhas
	Local nX	:= 0
	Local nCol	:= 0
	Local nCont := 42
	Local aMemo := {}
	Local cMemo := ""
	Local nLinhasMemo, nLinhaCorrente
	Local lTitulo := .T.
	Local nMarEsq := 150
	Local nMarDir := 2250
	Local nMeiLin := 40

	If lSigaMdtPs
		mx_LAUDO:= mv_par03
		cKeyPsq:= mv_par01 + mv_par02
		cCondTJA:= "TJA->TJA_FILIAL + TJA->TJA_CLIENT + TJA->TJA_LOJA + TJA->TJA_LAUDO"
		nIndTJA := 3
	EndIf

	dbSelectArea("TJA")
	dbSetOrder(nIndTJA)
	dbSeek(xFilial("TJA") + cKeyPsq + mx_LAUDO , .T. )
	While !EOF() .And. xFilial("TJA") + cKeyPsq + mx_LAUDO == &cCondTJA.

		dbSelectArea("TA0")
		dbSetOrder(1)
		dbSeek(xFilial("TA0") + TJA->TJA_CODLEG)

		If Empty(cMemo) .And. lTitulo
			lTitulo := .F.
			If nModeloImp == 1
				cVar1 := "cTXT"+Strzero(nVar1,6)
				OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
				nVar1++
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
				OLE_ExecuteMacro(oWord,"Sem_Negrito")
				OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
				OLE_SetDocumentVar(oWord,cVar1,STR0219)//"Requisitos Legais"
				OLE_ExecuteMacro(oWord,"Somalinha")
			ElseIf nModeloImp == 2
				nCol := 000
				@Li, nCol Psay STR0219 + ":" //"Requisitos Legais"
				Somalinha()
			ElseIf nModeloImp == 3
				nCol := 160
				Somalinha()
				oPrintPPRA:Say( lin, nMarEsq, STR0219, oFont12b ) // "Requisitos Legais"
			EndIf
		EndIf

		cMemo += STR0201 + "#*"	+ Alltrim(TA0->TA0_CODLEG)  		+ "#*"//Requisito#*
		cMemo += STR0202 + "#*"	+ Alltrim(TA0->TA0_EMENTA)			+ "#*"//Tema da Lei#*
		cMemo += STR0203 + "#*"	+ Alltrim(TA0->TA0_TIPO)			+ "#*"//Tipo#*
		cMemo += STR0204 + "#*"	+ "'MEMO1'"							+ "#*"//Descrição#*
		cMemo += STR0205 + "#*"	+ NGRETSX3BOX("TA0_ORIGEM",TA0->TA0_ORIGEM)+ "#*"//Origem#*
		cMemo += STR0206 + "#*"	+ Alltrim(TA0->TA0_CODRES)			+ "#*"//Resolução#*
		cMemo += STR0207 + "#*"	+ Alltrim(TA0->TA0_NUMRES)  		+ "#*"//Numero resolução#*
		cMemo += STR0208 + "#*"	+ Alltrim(TA0->TA0_OREMIS)			+ "#*"//Órgão Emissor#*
		cMemo += STR0209 + "#*"	+ Alltrim(DTOC(TA0->TA0_DTEMIS))	+ "#*"//Data Emissão#*
		cMemo += STR0210 + "#*"	+ SubStr(Alltrim(TA0->TA0_SITE),1,80)+ "#*"//Site#*
		cMemo += STR0211 + "#*"	+ Alltrim(DTOC(TA0->TA0_DTVIGE))	+ "#*"//Início da Vigência#*
		cMemo += STR0212 + "#*"	+ Alltrim(DTOC(TA0->TA0_DTVENCI))	+ "#*"//Término da Vigência
		cMemo += STR0213 + "#*"	+ Alltrim(TA0->TA0_EST)				+ "#*"//Estado#*
		cMemo += STR0214 + "#*"	+ Alltrim(STR(TA0->TA0_DTVCTO))  	+ "#*"//Dias Vencimento#*
		cMemo += STR0215 + "#*"	+ "'MEMO2'"							+ "#*"//Atendimento#*
		cMemo += STR0216 + "#*"	+ "'MEMO3'"							+ "#*"//Controles#*
		cMemo += STR0217 + "#*" + "'MEMO4'"							+ "#*"//Plano de Ações do Requisito#*
		cMemo += STR0218 + "#*" + "'MEMO5'"							+ "#*"//Responsáveis#*
		If nModeloImp == 2 //Modo de impressao padrao
			cMemo := StrTran(cMemo,"#*#*","#* #*")//Caso houver arquivo vazio incrementa espaco
			aMemo := StrTokArr(cMemo,"#*")//Carrega vetor, Impar - cabecalho, Par - Registros
			For nX := 1 To Len(aMemo)
				If nX % 2 <> 0 // Se cabecalho imprimir a esquerda
					nCol := 000
				Else
					nCol := 030// Se registro imprimir na coluna
				EndIf
				If "MEMO" $ aMemo[nX]//Se for campo Memo imprimi o memo especifico
					IF aMemo[nX] == "'MEMO1'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_DESCRI),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_DESCRI)
					ElseIF aMemo[nX] == "'MEMO2'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_OBRIGA),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_OBRIGA)
					ElseIF aMemo[nX] == "'MEMO3'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_ACOES),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_ACOES)
					ElseIf aMemo[nX] == "'MEMO4'"
						cLinhasMemo := ImpReqMemo("1")
						nLinhasMemo := MLCOUNT(cLinhasMemo,nCont)
					ElseIf aMemo[nX] == "'MEMO5'"
						cLinhasMemo := ImpReqMemo("2")
						nLinhasMemo := MLCOUNT(cLinhasMemo,nCont)
					EndIf
					For nLinhaCorrente := 1 to nLinhasMemo
						If !Empty(MemoLine(cLinhasMemo,nCont,nLinhaCorrente))
							@Li, nCol Psay MemoLine(cLinhasMemo,nCont,nLinhaCorrente)
							If nLinhaCorrente <> nLinhasMemo
								Somalinha()
							EndIf
						EndIf
					Next
				Else
					@Li, nCol Psay aMemo[nX]
				EndIf
			Next nX
			Somalinha()
		ElseIf nModeloImp == 1 //Impressao Word
			cMemo := StrTran( cMemo , "'MEMO1'" , Alltrim(TA0->TA0_DESCRI))
			cMemo := StrTran( cMemo , "'MEMO2'" , Alltrim(TA0->TA0_OBRIGA))//MEMO1 - TAO_OBRIGA
			cMemo := StrTran( cMemo , "'MEMO3'" , Alltrim(TA0->TA0_ACOES))//MEMO2 - TAO_ACOES
			cMemo := StrTran( cMemo , "'MEMO4'" , ImpReqMemo("1") )//MEMO3 - TAA_NOME
			cMemo := StrTran( cMemo , "'MEMO5'" , ImpReqMemo("2") )//MEMO2 - QAA_NOME
			OLE_ExecuteMacro( oWord, "Somalinha")
			OLE_SetDocumentVar(oWord, "Tabela",cMemo)
			OLE_SetDocumentVar(oWord, "Linhas",nRegs)
			OLE_ExecuteMacro( oWord, "Table_Requisitos")
			OLE_ExecuteMacro( oWord, "Somalinha")
		ElseIf nModeloImp == 3 // Impressao Grafico
			cMemo := StrTran(cMemo,"#*#*","#* #*")//Caso houver arquivo vazio incrementa espaco
			aMemo := StrTokArr(cMemo,"#*")//Carrega vetor, Impar - cabecalho, Par - Registros
			For nX := 1 To Len(aMemo)
				If nX % 2 <> 0// Se cabecalho imprimir a esquerda
					SomaLinha()
					oPrintPPRA:Line( lin, nMarEsq, lin + 60, 150 ) //Linha vertical esquerda
					oPrintPPRA:Line( lin, 740, lin + 60, 740) //Linha vertical meio
					oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )//Linha horizontal em baixo
					oPrintPPRA:Line( lin, nMarEsq, lin, nMarDir ) // Linha horizontal em cima
					nCol := 160
				Else// Se registro imprimir na coluna
					nCol := 750
				EndIf
				If "MEMO" $ aMemo[nX]//Se for campo Memo imprimi o memo especifico
					IF aMemo[nX] == "'MEMO1'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_DESCRI),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_DESCRI)
					ElseIF aMemo[nX] == "'MEMO2'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_OBRIGA),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_OBRIGA)
					ElseIf aMemo[nX] == "'MEMO3'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_ACOES),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_ACOES)
					ElseIf aMemo[nX] == "'MEMO4'"
						cLinhasMemo := ImpReqMemo("1")
						nLinhasMemo := MLCOUNT(cLinhasMemo,nCont)
					ElseIf aMemo[nX] == "'MEMO5'"
						cLinhasMemo := ImpReqMemo("2")
						nLinhasMemo := MLCOUNT(cLinhasMemo,nCont)
					EndIf
					For nLinhaCorrente := 1 to nLinhasMemo
						If !Empty(MemoLine(cLinhasMemo,nCont,nLinhaCorrente))
							oPrintPPRA:Line( lin, nMarEsq,lin + 60, nMarEsq )//Linha vertical esquerda
							oPrintPPRA:Line( lin, 740, lin + 60, 740 )//Linha vertical meio
							oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )//Linha horizontal em baixo

							oPrintPPRA:Say( lin + nMeiLin, nCol, MemoLine(cLinhasMemo,nCont,nLinhaCorrente), oFont10 )

							If nLinhaCorrente <> nLinhasMemo
								Somalinha()
								oPrintPPRA:Line( lin, nMarEsq, lin + 60, nMarEsq )//Linha vertical esquerda
								oPrintPPRA:Line( lin, 740, lin + 60, 740 )//Linha vertical meio
								oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )//Linha horizontal em baixo
							EndIf
						EndIf
					Next
				Else
					oPrintPPRA:Say( lin + nMeiLin, nCol, aMemo[nX], IIf( nX % 2 <> 0, oFont10b, oFont10 ) )
				EndIf
				If nX % 2 == 0
					oPrintPPRA:Line( lin + 60, nMarEsq, lin + 60, nMarDir )//Linha horizontal em cima
				EndIf
			Next nX
		EndIf

		dbSelectArea("TJA")
		dbSkip()

		cMemo := ""
		aMemo := {}
	End

	RestArea(aArea)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} ImpReqMemo
Busca Memo dos campos:
1 - Plano de Ações do Requisito;
2 - Responsáveis;
para imprecao de Requisitos A850REQUIS
Uso MDTR850

@return

@sample
ImpReqMemo()

@since 01/02/2013
@version 1.0
/*/
//---------------------------------------------------------------------
Static Function ImpReqMemo(cCampo)

	Local aArea := GetArea()
	Local cMemo := ""
	Do Case
		Case cCampo == "1"//Plano de Ações do Requisito
			dbSelectArea("TCL")
			dbSetOrder(1)
			dbSeek(xFilial("TCL") + TA0->TA0_CODLEG, .T.)
			While !Eof() .And. xFilial("TCL") + TA0->TA0_CODLEG == TCL->TCL_FILIAL + TCL->TCL_CODLEG
				dbSelectArea("TAA")
				dbSetOrder(1)
				dbSeek(xFilial("TAA") + TCL->TCL_CODPLA)
				cMemo += Alltrim(TAA->TAA_NOME) + CRLF
				dbSelectArea("TCL")
				dbSkip()
			End
		Case cCampo == "2" //Responsáveis
			dbSelectArea("TCM")
			dbSetOrder(1)
			dbSeek(xFilial("TCM") + TA0->TA0_CODLEG, .T.)
			While !Eof() .And. xFilial("TCM") + TA0->TA0_CODLEG == TCM->TCM_FILIAL + TCM->TCM_CODLEG
				dbSelectArea("QAA")
				dbSetOrder(1)
				dbSeek(xFilial("QAA") + TCM->TCM_RESPON)
				cMemo += Alltrim(QAA->QAA_NOME) + CRLF
				dbSelectArea("TCM")
				dbSkip()
			End
	End Case

	RestArea(aArea)

Return cMemo

//-----------------------------------------------------------------------------
/*/{Protheus.doc} fImpMedCon
	- Funcao que imprime Medidas de controle para os riscos.

@author Guilherme Benkendorf
@since 08/03/2013
@version P10/P11
/*/
//-------------------------------------------------------------------------------
Static Function fImpMedCon(cRisco, nReg)

	Local lImp
	Local lTitulo := .T.
	Local cMemo	  := ""

	Local cSeek		:= IF(lSigaMdtPs,cCliMdtPs, "")
	Local cWhileTJF := "TJF->TJF_FILIAL + TJF->TJF_NUMRIS"
	Local cWhileTO4 := "TO4->TO4_FILIAL + TO4->TO4_CONTRO"
	Local nIndTJF 	:= 1
	Local nIndTO4 	:= 1

	Default nReg := 0

	If lSigaMdtPs
		cWhileTJF := "TJF->TJF_FILIAL + TJF->TJF_CLIENT + TJF->TJF_LOJA + TJF->TJF_NUMRIS"
		nIndTJF   := 2
	End

	//Imprime Titulo
	If nModeloImp == 2
		Somalinha()
		@ Li, 005 Psay STR0220 + ":" //"Medidas de Controle"
	ElseIf nModeloImp == 3
		Somalinha()
		oPrintPPRA:Say(lin,200,STR0220 + ":",oFont12b)  //"Medidas de Controle"
	EndIf

	//Procura Medidas de controle relacionado aos Riscos
	DbSelectArea("TJF")
	DbSetOrder(nIndTJF)
	DbSeek(xFilial("TJF") + cSeek + cRisco)
	While xFilial("TJF") + cSeek + cRisco == &cWhileTJF.
		DbSelectArea("TO4")
		DbSetOrder(nIndTO4)
		DbSeek(xFilial("TO4") + TJF->TJF_MEDCON)
		While xFilial("TO4") + TJF->TJF_MEDCON == &cWhileTO4.

			//Imprime codigo e descricao
			If nModeloImp == 1
				If lTitulo
					lTitulo := .F.
					cMemo += STR0221 + "#*" //"Codigo"
					cMemo += STR0222 + "#*" //"Descrição"
					nReg++
				EndIf
				cMemo += Alltrim(TO4->TO4_CONTRO) + "#*"
				cMemo += Alltrim(TO4->TO4_NOMCTR) + "#*"
				nReg++
			ElseIf nModeloImp == 2
				If lTitulo
					lTitulo := .F.
				Somalinha()
					@ Li, 005 Psay STR0221 //Codigo
					@ Li, 015 Psay STR0222 //Descrição
				EndIf
				Somalinha()
				@ Li, 005 Psay Alltrim(TO4->TO4_CONTRO)
				@ Li, 015 Psay Alltrim(TO4->TO4_NOMCTR)
			ElseIf nModeloImp == 3
				If lTitulo
					lTitulo := .F.
					Somalinha()
					oPrintPPRA:Say(lin,200,STR0221,oFont12b) //"Codigo"
					oPrintPPRA:Say(lin,475,STR0222,oFont12b) //"Descrição"
				EndIf
				Somalinha()
				oPrintPPRA:Say(lin,200,Alltrim(TO4->TO4_CONTRO),oFont10)
				oPrintPPRA:Say(lin,475,Alltrim(TO4->TO4_NOMCTR),oFont10)
			EndIf
			DbSelectArea("TO4")
			DbSkip()
		End
		DbSelectArea("TJF")
		DbSkip()
	End

	If nModeloImp == 1
		StrTran(cMemo,"#*#*","#* #*")
		Return cMemo
	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} A870QDRDPT
Monta quadro com acoes de prevencao, controle e diagnostico de doencas
ocupacionais ou nao por departamento

@return .T., Lógico, sempre verdadeiro

@sample U_A870QDRDPT()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function A870QDRDPT(lAnexoA,lAnexoB)

	Local lPostoTrb := .F.,nx,nInd,nInd2,nInd1,i
	Local _centrCusto := " "
	Local _cFuncc     := " "
	Local _cTarefa    := " "
	Local nIndTN0     := 5//FILIAL+CC+FUNCAO+DEPTO
	Local nQntFor
	Local cDepto	  := " "
	Local cCodFunc    := " "
	Local lFirstFor   := .T.
	Local lFirstDpt   := .T.
	Local lPula60     := .F.
	Local cTitulo     := STR0108 //"FUNÇÃO"
	Local cTitulo2    := STR0108 //"FUNÇÃO"
	Local cDeptoAux
	Local LinhaCor,nLinhasMemo
	Local nMarEsq := 150
	Local nMarDir := 2250
	Local nMeiLin := 40
	Local oTempTRBA, oTempTRBC, oTempTRBD, oTempTRBE, oTempTRBB, oTempTRBF

	Private cCodFun   := "RA_CODFUNC"
	Private cTabFun   := "SRJ"
	Private cCodFun2  := "TN0_CODFUN"
	Private cDesFun   := "SRJ->RJ_DESC"
	Private nSizeCTT  := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	Private nSizeSQB  := If((TAMSX3("QB_DEPTO")[1]) < 1,9,(TAMSX3("QB_DEPTO")[1]))
	Private nSizeSRJ  := If((TAMSX3("RJ_FUNCAO")[1]) < 1,5,(TAMSX3("RJ_FUNCAO")[1]))
	Private aLetras   := {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v",;
		"w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V",;
		"W","X","Y","Z"}
	If TN0->(FieldPos("TN0_CODPOS")) > 0 .And. SRA->(FieldPos("RA_POSTO")) > 0 .And. (TAMSX3("ZZI_COD")[1]) > 0
		nIndTN0   := 8
		lPostoTrb := .T.
		cTitulo   := STR0109 //"POSTO DE TRABALHO"
		cTitulo2  := STR0109 //"POSTO DE TRABALHO"
		cCodFun   := "RA_POSTO"
		cTabFun   := "ZZI"
		cCodFun2  := "TN0_CODPOS"
		cDesFun   := "ZZI->ZZI_DESC"
		nSizeSRJ  := (TAMSX3("ZZI_COD")[1])
	EndIf

	//Tabela Ccusto x Funcao
	aTRB := {{"RA_DEPTO"	,"C",nSizeSQB,0},;
			{"RA_CODFUN"	,"C",nSizeSRJ,0},;
			{"RA_CODFUN2"	,"C",nSizeSRJ,0},;
			{"RA_CC"		,"C",nSizeCTT,0}}

	oTempTRBA := FWTemporaryTable():New( "TRBA", aTRB )
	#IFDEF CDX
		oTempTRBA:AddIndex( "1", {"RA_DEPTO","RA_CODFUN"} )
		oTempTRBA:AddIndex( "2", {"RA_DEPTO","RA_CODFUN2"} )
	#ELSE
		oTempTRBA:AddIndex( "1", {"RA_DEPTO","RA_CODFUN"} )
		oTempTRBA:AddIndex( "2", {"RA_DEPTO","RA_CODFUN2"} )
	#EndIf
	oTempTRBA:Create()

	//Tabela Ccusto x Funcao x Riscos
	aTRB1 := {{"DEPTO"	,"C",nSizeSQB,0},;
			{"CODFUN"	,"C",nSizeSRJ,0},;
			{"TIPO"	,"C",1,0},;
			{"NUMRIS"	,"C",40,0}}

	oTempTRBC := FWTemporaryTable():New( "TRBC", aTRB1 )
	oTempTRBC:AddIndex( "1", {"DEPTO","CODFUN","TIPO","NUMRIS"} )
	oTempTRBC:Create()

	//Tabela Ccusto x Funcao x Exames
	aTRB3 := {{"DEPTO"	,"C", nSizeSQB, 0 } ,;
			{"CODFUN"	,"C", nSizeSRJ, 0 } ,;
			{"TIPO"	,"C", 1       , 0 } ,;
			{"EXAME"	,"C", 40      , 0 } ,;
			{"PERIODIC","C", 40      , 0 } ,;
			{"POSADM"  ,"C", 100     , 0 } }

	oTempTRBD := FWTemporaryTable():New( "TRBD", aTRB3 )
	#IFDEF CDX
		oTempTRBD:AddIndex( "1", {"DEPTO","CODFUN","TIPO","EXAME"} )
		oTempTRBD:AddIndex( "2", {"DEPTO","CODFUN","PERIODIC","TIPO","EXAME"} )
	#ELSE
		oTempTRBD:AddIndex( "1", {"DEPTO","CODFUN","TIPO","EXAME"} )
		oTempTRBD:AddIndex( "2", {"DEPTO","CODFUN","PERIODIC","TIPO","EXAME"} )
	#EndIf
	oTempTRBD:Create()

	//Tabela Ccusto x Funcao x Recomendacao
	aTRB5 := {{"DEPTO"	,"C",nSizeSQB,0},;
			{"CODFUN"	,"C",nSizeSRJ,0},;
			{"RECOME"	,"C",100,0}}

	oTempTRBE := FWTemporaryTable():New( "TRBE", aTRB5 )
	oTempTRBE:AddIndex( "1", {"DEPTO","CODFUN","RECOME"} )
	oTempTRBE:Create()

	//Tabela de Quantidade de funcionarios por funcao
	aTRB2 := {{"CODFUN"	,"C",nSizeSRJ,0},;
			{"DESCRI"	,"C",50,0},;
			{ "QUANTI","N",9,0}}

	oTempTRBB := FWTemporaryTable():New( "TRBB", aTRB2 )
	#IFDEF CDX
		oTempTRBB:AddIndex( "1", {"CODFUN"} )
		oTempTRBB:AddIndex( "2", {"DESCRI"} )
	#ELSE
		oTempTRBB:AddIndex( "1", {"CODFUN"} )
		oTempTRBB:AddIndex( "2", {"DESCRI"} )
	#EndIf
	oTempTRBB:Create()

	//Tabela Ccusto x Funcao x Exames dem., adm., ret. e mud.
	aTRB6 := {{"DEPTO"	,"C",nSizeSQB,0},;
			{"CODFUN"	,"C",nSizeSRJ,0},;
			{"NATUREZA","C",1,0},;
			{"EXAME"	,"C",40,0}}

	oTempTRBF := FWTemporaryTable():New( "TRBF", aTRB6 )
	#IFDEF CDX
		oTempTRBF:AddIndex( "1", {"DEPTO","CODFUN","EXAME","NATUREZA"} )
	#ELSE
		oTempTRBF:AddIndex( "1", {"DEPTO","CODFUN","EXAME","NATUREZA"} )
	#EndIf
	oTempTRBF:Create()

	Dbselectarea("SRA")
	Dbsetorder(1)
	Dbseek(xFilial("SRA"))
	While !eof() .And. xFilial("SRA") == SRA->RA_FILIAL
		// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
		If !R870FUNC()
			DbSelectArea("SRA")
			DbSkip()
			Loop
		EndIf

		If !Empty(cCCPCMSO) .And. lMdtUmCC
			If Empty(SRA->RA_CC) .Or. Empty(SRA->(&(cCodFun))) .Or. !Empty(SRA->RA_DEMISSA) .Or. SRA->RA_SITFOLH == "D" .Or. SRA->RA_CC != cCCPCMSO
				Dbselectarea("SRA")
				Dbskip()
				Loop
			EndIf
		Else
			If Empty(SRA->RA_CC) .Or. Empty(SRA->(&(cCodFun))) .Or. !Empty(SRA->RA_DEMISSA) .Or. SRA->RA_SITFOLH == "D"
				Dbselectarea("SRA")
				Dbskip()
				Loop
			EndIf
		EndIf

		Dbselectarea("TRBA")
		Dbsetorder(1)
		If !Dbseek(SRA->RA_DEPTO+SRA->(&(cCodFun)))
			RecLock("TRBA",.T.)
			TRBA->RA_DEPTO 	:= SRA->RA_DEPTO
			TRBA->RA_CODFUN := SRA->(&(cCodFun))
			TRBA->RA_CC 	:= SRA->RA_CC
			MsUnLock("TRBA")
		EndIf

		Dbselectarea(cTabFun)
		Dbsetorder(1)
		Dbseek(xFilial(cTabFun)+SRA->(&(cCodFun)))

		Dbselectarea("TRBB")
		Dbsetorder(1)
		If !Dbseek(SRA->(&(cCodFun)))
			RecLock("TRBB",.T.)
			TRBB->CODFUN := SRA->(&(cCodFun))
			TRBB->DESCRI := &(cDesFun)
			TRBB->QUANTI := 1
			MsUnLock("TRBB")
		Else
			RecLock("TRBB",.F.)
			TRBB->QUANTI := TRBB->QUANTI+1
			MsUnLock("TRBB")
		EndIf

		Dbselectarea("SRA")
		Dbskip()
	End

	Dbselectarea("TRBA")
	Dbsetorder(1)
	Dbgotop()
	While !eof()
		aRiscoFun := {}
		lAchExame := .F.
		lAchRisco := .F.
		nPerExame := 0
		//Verifica Exames
		cSeekProg := xFilial("TON")+TRBA->RA_CODFUN
		dbSelectArea("TON")
		dbSetOrder(1)
		dbSeek(cSeekProg)
		While !EOF() .And. TON->TON_FILIAL+TON->TON_CODFUN == cSeekProg

			dbSelectArea("TM4")
			dbSetOrder(1)
			If !dbSeek(xFilial("TM4")+TON->TON_CODEXA)
				dbSelectArea("TON")
				dbSkip()
				Loop
			EndIf

			lAchExame := .T.

			aPeriodic := {{0, 0, 0, 0}}
			aPeriodic := NGUTILPER(TON->TON_FAIXA,25,"1")
			IF aPeriodic[1,3] <> 1 .Or. aPeriodic[1,1] == 0
				dbSelectArea("TON")
				dbSkip()
				Loop
			EndIf

			cTipo := If(Alltrim(TON->TON_CODEXA)=="NR7","1","2")
			dbSelectArea("TRBD")
			dbSetOrder(1)
			If !dbSeek(TRBA->RA_DEPTO+TRBA->RA_CODFUN+cTipo+Substr(TM4->TM4_NOMEXA,1,40))
				RecLock("TRBD",.T.)
				TRBD->DEPTO  := TRBA->RA_DEPTO
				TRBD->CODFUN := TRBA->RA_CODFUN
				TRBD->EXAME  := Substr(TM4->TM4_NOMEXA,1,40)
				TRBD->TIPO   := cTipo
				TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
				TRBD->POSADM := Padr( U_cMdt870Per( aPeriodic[1,2], 1) + U_cMdt870Per( aPeriodic[1,4], 2 ), 100 )
				MsUnLock("TRBD")
			EndIf

			dbSelectArea("TON")
			dbSkip()
		End
		If lTN0Depto
			cDeptoAux := TRBA->RA_DEPTO
			nQntFor   := 9
		Else
			cDeptoAux := Space( nSizeSQB )
			nQntFor   := 4
		EndIf
	//Verifica exames e Riscos
		For nx := 1 to nQntFor
			If nx == 1
				_centrCusto:= TRBA->RA_CC
				_cFuncc    := TRBA->RA_CODFUN
				_cDepto    := cDeptoAux
			ElseIf nx == 2
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := TRBA->RA_CODFUN
				_cDepto    := cDeptoAux
			ElseIf nX == 3
				_centrCusto:= TRBA->RA_CC
				_cFuncc    := PADR( "*" , nSizeSRJ )
				_cDepto    := cDeptoAux
			ElseIf nX == 4
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := PADR( "*" , nSizeSRJ )
				_cDepto    := cDeptoAux
			ElseIf nX == 5
				_centrCusto:= TRBA->RA_CC
				_cFuncc    := TRBA->RA_CODFUN
				_cDepto    := PADR( "*" , nSizeSQB )
			ElseIf nX == 6
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := TRBA->RA_CODFUN
				_cDepto    := PADR( "*" , nSizeSQB )
			ElseIf nX == 7
				_centrCusto:= TRBA->RA_CC
				_cFuncc    := PADR( "*" , nSizeCTT )
				_cDepto    := PADR( "*" , nSizeSQB )
			ElseIf nX == 8
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := TRBA->RA_CODFUN
				_cDepto    := cDeptoAux
			ElseIf nX == 9
				_centrCusto:= PADR( "*" , nSizeCTT )
				_cFuncc    := PADR( "*" , nSizeCTT )
				_cDepto    := PADR( "*" , nSizeSQB )
			EndIf

			DbSelectArea("TN0")
			DbSetOrder(nIndTN0)
			DbSeek(xFilial("TN0")+_centrCusto+_cFuncc )
			While !EOF() .And. TN0->TN0_FILIAL == xFilial("TN0") .And. TN0->TN0_CC == _centrCusto .And. ;
										(&(cCodFun2)) == _cFuncc
				If AllTrim(TN0->TN0_CC) <> "*" .And. !Empty(cCCPCMSO) .And. lMdtUmCC .And. TN0->TN0_CC != cCCPCMSO
					Dbselectarea("TN0")
					dbSkip()
					Loop
				EndIf

				If lTN0Depto .And. AllTrim( TN0->TN0_DEPTO ) <> "*" .And. TN0->TN0_DEPTO <> _cDepto
					Dbselectarea("TN0")
					dbSkip()
					Loop
				EndIf
				If TN0->TN0_MAPRIS == "1" //Valida se o Mapa Risco é igual a CIPA ### Autor: Jackson Machado ### Data: 10/02/2011
					dbSelectArea("TN0")
					dbSkip()
					Loop
				EndIf

				Dbselectarea("TMA")
				Dbsetorder(1)
				If !Dbseek(xFilial("TMA")+TN0->TN0_AGENTE) .Or. ;
					(!Empty(TN0->TN0_DTELIM) .And. TN0->TN0_DTELIM < dDataBase)

					DbSelectArea("TN0")
					Dbskip()
					Loop
				EndIf

				lAchRisco := .T.

				Dbselectarea("TRBC")
				If !Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN+Substr(TMA->TMA_GRISCO,1,01)+Substr(TMA->TMA_NOMAGE,1,40))
					RecLock("TRBC",.T.)
					TRBC->DEPTO  := TRBA->RA_DEPTO
					TRBC->CODFUN := TRBA->RA_CODFUN
					TRBC->NUMRIS := Substr(TMA->TMA_NOMAGE,1,40)
					TRBC->TIPO   := Substr(TMA->TMA_GRISCO,1,01)
					MsUnLock("TRBC")
				EndIf
				//Adiciona riscos em um array
				If lAnexoB
					If (aScan(aRiscoFun,{|x| Trim(Upper(x[1])) == TN0->TN0_NUMRIS } ) == 0)
						aAdd(aRiscoFun, {TN0->TN0_NUMRIS } )
					EndIf
				EndIf

				DbSelectArea("TN2")
				DbSetOrder(1)
				DbSeek(xFilial("TN2")+TN0->TN0_NUMRIS)
				While !EOF() .And. TN2->TN2_NUMRIS == TN0->TN0_NUMRIS .And. TN2->TN2_FILIAL == xFilial("TN2")

					Dbselectarea("TM4")
					Dbsetorder(1)
					If !Dbseek(xFilial("TM4")+TN2->TN2_EXAME)
						DbSelectArea("TN2")
						Dbskip()
						Loop
					EndIf

					lAchExame := .T.

					aPeriodic := {{0, 0, 0, 0}}
					aPeriodic := NGUTILPER(TN2->TN2_FAIXA,25,"1")
					IF aPeriodic[1,3] <> 1 .Or. aPeriodic[1,1] == 0
						DbSelectArea("TN2")
						Dbskip()
						Loop
					EndIf

					cTipo := If(Alltrim(TN2->TN2_EXAME)=="NR7","1","2")
					Dbselectarea("TRBD")
					dbSetOrder(1)
					If !Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN+cTipo+Substr(TM4->TM4_NOMEXA,1,40))
						RecLock("TRBD",.T.)
						TRBD->DEPTO  := TRBA->RA_DEPTO
						TRBD->CODFUN := TRBA->RA_CODFUN
						TRBD->EXAME  := Substr(TM4->TM4_NOMEXA,1,40)
						TRBD->TIPO   := cTipo
						TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
						TRBD->POSADM := Padr(U_cMdt870Per( aPeriodic[1,2], 1 ) + U_cMdt870Per( aPeriodic[1,4], 2 ), 100 ) //TMQ->TMQ_POSADM
						MsUnLock("TRBD")
					EndIf

					DbSelectArea("TN2")
					DbSkip()
				End

				//Acoes
				DbSelectArea("TO1")
				DbSetOrder(1)
				DbSeek(xFilial("TO1")+MV_PAR01+TN0->TN0_NUMRIS)
				While !EOF() .And. TO1->TO1_LAUDO+TO1->TO1_NUMRIS == MV_PAR01+TN0->TN0_NUMRIS .And. ;
					TO1->TO1_FILIAL == xFilial("TO1")

					cRecome := PadR( Alltrim( Str( TO1->(Recno()) ) ) , 100 )

					Dbselectarea("TRBE")
					If !Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN+cRecome) .And. !Empty(cRecome)
						RecLock("TRBE",.T.)
						TRBE->DEPTO  := TRBA->RA_DEPTO
						TRBE->CODFUN := TRBA->RA_CODFUN
						TRBE->RECOME := cRecome
						MsUnLock("TRBE")
					EndIf

					DbSelectArea("TO1")
					DbSkip()
				End

				DbSelectArea("TN0")
				DbSkip()
			End
		Next nx
		//Verifica exames complementares
		DbSelectArea("TN9")
		DbSetOrder(1)
		DbSeek(xFilial("TN9"))
		While !EOF() .And. TN9->TN9_FILIAL == xFilial("TN9")

			Dbselectarea("TM4")
			Dbsetorder(1)
			If !Dbseek(xFilial("TM4")+TN9->TN9_EXAME)
				DbSelectArea("TN9")
				Dbskip()
				Loop
			EndIf

			lAchExame := .T.

			aPeriodic := {{0, 0, 0, 0}}
			aPeriodic := NGUTILPER(TN9->TN9_FAIXA,25,"1")
			IF aPeriodic[1,3] <> 1 .Or. aPeriodic[1,1] == 0
				DbSelectArea("TN9")
				Dbskip()
				Loop
			EndIf

			cTipo := If(Alltrim(TN9->TN9_EXAME)=="NR7","1","2")
			Dbselectarea("TRBD")
			dbSetOrder(1)
			If !Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN+cTipo+Substr(TM4->TM4_NOMEXA,1,40))
				RecLock("TRBD",.T.)
				TRBD->DEPTO  := TRBA->RA_DEPTO
				TRBD->CODFUN := TRBA->RA_CODFUN
				TRBD->EXAME  := Substr(TM4->TM4_NOMEXA,1,40)
				TRBD->TIPO   := cTipo
				TRBD->PERIODIC := U_cMdt870Per( aPeriodic[1,1] )
				TRBD->POSADM :=  Padr( U_cMdt870Per( aPeriodic[1,2], 1 ) + U_cMdt870Per( aPeriodic[1,4], 2), 100 )//TMQ->TMQ_POSADM
				MsUnLock("TRBD")
			EndIf

			DbSelectArea("TN9")
			DbSkip()
		End

		If !lAchRisco
			Dbselectarea("TRBC")
			If !Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN+" "+STR0110) //"Ausência de riscos"
				RecLock("TRBC",.T.)
				TRBC->DEPTO  := TRBA->RA_DEPTO
				TRBC->CODFUN := TRBA->RA_CODFUN
				If lTN0Depto
					TRBC->DEPTO  := TRBA->RA_DEPTO
				EndIf
				TRBC->NUMRIS := STR0110 //"Ausência de riscos"
				TRBC->TIPO   := " "
				MsUnLock("TRBC")
			EndIf
		EndIf
		//Verifica exames Demissionais, Admissionais, Mud. Func e Retorno
		If lAnexoB
			aTemp := {}
			cTipo := "A"
			For nInd:= 1 to 4
				If nInd == 1
					cTipo := "A"//Busca todos os exames necessarios para admissao
				ElseIf nInd == 2
					cTipo := "D"//Busca todos os exames necessarios para demissao
				ElseIf nInd == 3
					cTipo := "M"//Busca todos os exames necessarios para Mudanca de Funcao
				Else
					cTipo := "R"//Busca todos os exames necessarios para Retorno ao trabalho
				EndIf
				aTemp := MDTRETEXA(TRBA->RA_CODFUN,cTipo,aRiscoFun)
				For i := 1 to Len(aTemp)//Grava no TRB
					dbSelectArea("TRBF")
					If !dbSeek(TRBA->RA_DEPTO+TRBA->RA_CODFUN+Substr(aTemp[i,2],1,40)+cTipo)
						RecLock("TRBF",.T.)
						TRBF->DEPTO := TRBA->RA_DEPTO
						TRBF->CODFUN := TRBA->RA_CODFUN
						TRBF->EXAME := Substr(aTemp[i,2],1,40)
						TRBF->NATUREZA := cTipo
						MsUnlock("TRBF")
					EndIf
				Next i
			Next nInd
		EndIf
		DbSelectArea("TRBA")
		DbSkip()
	End

	Dbselectarea("TRBA")
	Dbsetorder(1)
	Dbgotop()
	While !eof()
		If !Empty(TRBA->RA_CODFUN2)
			Dbselectarea("TRBA")
			DbSkip()
			Loop
		EndIf
		Reclock("TRBA",.F.)
		TRBA->RA_CODFUN2 := TRBA->RA_CODFUN
		MsUnLock("TRBA")

		cExames := " "
		cRiscos := " "
		cAcoes  := " "
		cExames2:= " "

		Dbselectarea("TRBC")
		Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_DEPTO+TRBA->RA_CODFUN == TRBC->DEPTO+TRBC->CODFUN
			cRiscos += TRBC->NUMRIS
			DbSkip()
		End
		Dbselectarea("TRBD")
		dbSetOrder(1)
		Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_DEPTO+TRBA->RA_CODFUN == TRBD->DEPTO+TRBD->CODFUN
			cExames += TRBD->EXAME
			DbSkip()
		End
		Dbselectarea("TRBE")
		Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_DEPTO+TRBA->RA_CODFUN == TRBE->DEPTO+TRBE->CODFUN
			nGoTo_ := Val(TRBE->RECOME)
			If nGoTo_ > 0
				dbSelectArea("TO1")
				dbGoTo(nGoTo_)
				If !Eof()
					cAcoes += Alltrim(TO1->TO1_RECOME)
				EndIf
			EndIf
			Dbselectarea("TRBE")
			DbSkip()
		End

		If lAnexoB
			Dbselectarea("TRBF")
			dbSetOrder(1)
			Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN)
			While !eof() .And. TRBA->RA_DEPTO+TRBA->RA_CODFUN == TRBF->DEPTO+TRBF->CODFUN
				cExames2 += TRBF->EXAME+TRBF->NATUREZA
				DbSkip()
			End
		EndIf

		Dbselectarea("TRBA")
		nRecnoTrb := TRBA->(Recno())

		U_MDT870DPT2(TRBA->RA_DEPTO,TRBA->RA_CODFUN,cRiscos,cExames,cAcoes,lAnexoB)

		Dbselectarea("TRBA")
		Dbgoto(nRecnoTrb)
		DbSkip()
	End

	lFirstFor := .T.
	Dbselectarea("TRBB")
	Dbsetorder(2)
	Dbgotop()
	While !eof()
		If lFirstFor
			lFirstFor := .F.
			If nModeloImp == 2
				If li != 6 //Se não estiver na primeira linha, não cria nova pagina
					li := 80
				EndIf
				Somalinha()
				U_IMPCAB870(STR0111) //"Anexo ao PCMSO:"
				Somalinha()
				Somalinha()
				Somalinha()
				U_IMPCAB870(STR0112) //"ANEXO I - RELAÇÃO DAS FUNÇÕES EXISTENTES NO ESTABELECIMENTO E SEU RESPECTIVO QUANTITATIVO."
				Somalinha()
				U_IMPCAB870(STR0113) //"ANEXO II - LEVANTAMENTO PARA RECONHECIMENTO E AVALIAÇÃO QUALITATIVA DOS RISCOS AMBIENTAIS E EXAMES PROGRAMADOS DE ACORDO COM A FUNÇÃO."
				Somalinha()
				U_IMPCAB870("{NS}"+STR0114) //"ANEXO I"
				Somalinha()
			ElseIf nModeloImp == 3
				If Lin != 300
					lin := 9999
				EndIf
				Somalinha()
				U_IMPCAB870(STR0111) //"Anexo ao PCMSO:"
				Somalinha(120)
				U_IMPCAB870(STR0112) //"ANEXO I - RELAÇÃO DAS FUNÇÕES EXISTENTES NO ESTABELECIMENTO E SEU RESPECTIVO QUANTITATIVO."
				Somalinha()
				U_IMPCAB870(STR0113) // "ANEXO II - LEVANTAMENTO PARA RECONHECIMENTO E AVALIAÇÃO QUALITATIVA DOS RISCOS AMBIENTAIS E EXAMES PROGRAMADOS DE ACORDO COM A FUNÇÃO."
				Somalinha()
				U_IMPCAB870("{NS}"+STR0114) //"ANEXO I"
				Somalinha()
			Else
				//OLE_ExecuteMacro(oWord,"NewPage")
				U_IMPCAB870(STR0111) //"Anexo ao PCMSO:"
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				U_IMPCAB870(STR0112) //"ANEXO I - RELAÇÃO DAS FUNÇÕES EXISTENTES NO ESTABELECIMENTO E SEU RESPECTIVO QUANTITATIVO."
				OLE_ExecuteMacro(oWord,"Somalinha")
				U_IMPCAB870(STR0113) //"ANEXO II - LEVANTAMENTO PARA RECONHECIMENTO E AVALIAÇÃO QUALITATIVA DOS RISCOS AMBIENTAIS E EXAMES PROGRAMADOS DE ACORDO COM A FUNÇÃO."
				OLE_ExecuteMacro(oWord,"Somalinha")
				U_IMPCAB870("{NS}"+STR0114) //"ANEXO I"
				OLE_ExecuteMacro(oWord,"Somalinha")
			EndIf
		EndIf

		If !Empty(TRBB->DESCRI)
			U_IMPTXT870(Alltrim(Str(TRBB->QUANTI,9))+" - "+Alltrim(TRBB->DESCRI))
		EndIf

		Dbselectarea("TRBB")
		Dbskip()
	End

	lFirstDpt := .T.

	Dbselectarea("TRBA")
	Dbsetorder(2)
	Dbgotop()
	While !eof()
		cDepto := TRBA->RA_DEPTO

		If lFirstDpt
			Dbselectarea("TMK")
			Dbsetorder(1)
			If lSigaMdtps
				Dbseek(xFilial("TMK")+Mv_par06)
			Else
				Dbseek(xFilial("TMK")+Mv_par04)
			EndIf

			If nModeloImp == 2
				// li := 80
				Somalinha()
				@li,001 Psay Replicate("_",127)
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Substr(Alltrim(cEmp_Nome),1,50)
				@li,053 Psay "|"
				@li,054 Psay STR0119 //"ACOES DE PREVENCAO, CONTROLE E DIAGNOSTICO DE DOENCAS OCUPACIONAIS E "
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Substr(Alltrim(cEmp_Fili),1,50)
				@li,053 Psay "|"
				@li,054 Psay STR0120 //"NAO OCUPACIONAIS"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,053 Psay "|"
				If(mv_par08 == 1)
					@li,054 Psay Upper(STR0092)+" :"+DTOC(DDATABASE)+"   "+STR0116+" - "+Upper(STR0092)+": "+DTOC(DDATABASE+365)+"   "+STR0118 //"DATA" // "REVISÃO" //"ANEXO II"
				Else
					@li,054 Psay Upper(STR0092)+" :"+DTOC(TO0->TO0_DTINIC)+"   "+STR0116+" - "+Upper(STR0092)+": "+DTOC(If(Empty(TO0->TO0_DTVALI),(TO0->TO0_DTINIC+365),TO0->TO0_DTVALI))+"   "+STR0118 //"DATA" // "REVISÃO" //"ANEXO II"
				EndIf
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,053 Psay "|"
				@li,054 Psay STR0117+": "+Substr(Alltrim(TMK->TMK_NOMUSU),1,40) //"RESPONSÁVEL P/ LEVANTAMENTO"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Replicate("_",52)
				@li,053 Psay "|"
				@li,054 Psay Replicate("_",74)
				@li,128 Psay "|"
			ElseIf nModeloImp == 3

				Somalinha()

				oPrintPPRA:Box( lin, nMarEsq, lin + 180, nMarDir )
				oPrintPPRA:Line( lin, 1025, lin + 180, 1025 )
				oPrintPPRA:Say( lin + nMeiLin, 160, Alltrim( cEmp_Nome ), oFont10b )
				oPrintPPRA:Say( lin + nMeiLin * 2, 160, Alltrim( cEmp_Fili ), oFont10b )

				cColuna2 := STR0115 //"AÇÕES DE PREVENÇÃO, CONTROLE E DIAGNÓSTICO DE DOENÇAS OCUPACIONAIS E NÃO OCUPACIONAIS"
				If(mv_par08 == 1)
					cColuna1 := Upper(STR0092)+": "+DTOC(DDATABASE)+"  /  "+STR0116+" - "+Upper(STR0092)+": "+DTOC(DDATABASE+365)+"    - "+STR0118 //"DATA" //"REVISÃO" //"ANEXO II"
				Else
					cColuna1 := Upper(STR0092)+": "+DTOC(TO0->TO0_DTINIC)+"  /  "+STR0116+" - "+Upper(STR0092)+": "+DTOC(If(Empty(TO0->TO0_DTVALI),(TO0->TO0_DTINIC+365),TO0->TO0_DTVALI))+"    - "+STR0118 //"DATA" //"REVISÃO" //"ANEXO II"
				EndIf

				oPrintPPRA:Say( lin + nMeiLin, 1035, MemoLine( cColuna2, 55, 1 ) ,oFont10b )
				oPrintPPRA:Say( lin + nMeiLin * 2, 1035, MemoLine( cColuna2, 55, 2 ) ,oFont10b )
				oPrintPPRA:Say( lin + nMeiLin * 3, 1035, cColuna1, oFont10b )
				oPrintPPRA:Say( lin + nMeiLin * 4, 1035, STR0117 + ": " + Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ), oFont10b ) // "RESPONSÁVEL P/ LEVANTAMENTO"

				Somalinha( 130 )

			Else
			If(mv_par10 == 1)
				cColuna1 := Alltrim(cEmp_Nome)+CRLF+Alltrim(cEmp_Fili)+CRLF
				cColuna2 := STR0115+CRLF+; //"AÇÕES DE PREVENÇÃO, CONTROLE E DIAGNÓSTICO DE DOENÇAS OCUPACIONAIS E NÃO OCUPACIONAIS
				Upper(STR0092)+": "+DTOC(DDATABASE)+"   "+STR0116+" - "+Upper(STR0092)+": "+DTOC(DDATABASE+365)+"   "+STR0118+CRLF+; //"DATA" //"REVISÃO" //"ANEXO II"
				STR0117+": "+Alltrim(SubStr(TMK->TMK_NOMUSU,1,40)) //"RESPONSÁVEL P/ LEVANTAMENTO"
			Else
				cColuna1 := Alltrim(cEmp_Nome)+CRLF+Alltrim(cEmp_Fili)+CRLF
				cColuna2 := STR0115+CRLF+; //"AÇÕES DE PREVENÇÃO, CONTROLE E DIAGNÓSTICO DE DOENÇAS OCUPACIONAIS E NÃO OCUPACIONAIS
				Upper(STR0092)+": "+DTOC(TO0->TO0_DTINIC)+"   "+STR0116+" - "+Upper(STR0092)+": "+DTOC(If(Empty(TO0->TO0_DTVALI),(TO0->TO0_DTINIC+365),TO0->TO0_DTVALI))+"   "+STR0118+CRLF+; //"DATA" //"REVISÃO" //"ANEXO II"
				STR0117+": "+Alltrim(SubStr(TMK->TMK_NOMUSU,1,40)) //"RESPONSÁVEL P/ LEVANTAMENTO"
			EndIf
				//OLE_ExecuteMacro(oWord,"NewPage")
				OLE_SetDocumentVar(oWord,"Tabela",cColuna1+"#*"+cColuna2)
				OLE_ExecuteMacro(oWord,"Tb_Anexo_Tit")
			EndIf
		EndIf
		lFirstDpt := .F.

		Dbselectarea("SQB")
		Dbsetorder(1)
		Dbseek(xFilial("SQB")+TRBA->RA_DEPTO)

		If nModeloImp == 2
			If li == 57
				li := 58
			EndIf
			Somalinha(,.T.)
			@li,000 Psay "|"
			@li,001 Psay Alltrim(SQB->QB_DESCRIC)
			@li,128 Psay "|"
			Somalinha()
			@li,000 Psay "|"
			@li,001 Psay Replicate("_",127)
			@li,128 Psay "|"
			If li >= 56
				li := 58
			EndIf
			Somalinha(,.T.)
			@li,000 Psay "|"
			If lAnexoA
				@li,001 Psay cTitulo2
				@li,032 Psay "|"
				@li,033 Psay STR0121+" / "+STR0122 //"AGENTES" //"RISCOS"
				@li,064 Psay "|"
				@li,065 Psay STR0123+"/"+STR0124+"/" //"EXAMES CLÍNICOS" //"COMPLEMENTARES"
				@li,096 Psay "|"
				@li,097 Psay STR0126+" /" //"AÇÕES DE PROMOÇÃO A SAÚDE"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,032 Psay "|"
				@li,064 Psay "|"
				@li,065 Psay STR0125 //"PERIODICIDADE"
				@li,096 Psay "|"
				@li,097 Psay STR0127 //"PROTEÇÃO ESPECÍFICA"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Replicate("_",31)
				@li,032 Psay "|"
				@li,033 Psay Replicate("_",31)
				@li,064 Psay "|"
				@li,065 Psay Replicate("_",31)
				@li,096 Psay "|"
				@li,097 Psay Replicate("_",31)
				@li,128 Psay "|"
			Else
				@li,001 Psay STR0121+" / "+STR0122 //"AGENTES" //"RISCOS"
				@li,032 Psay "|"
				@li,033 Psay STR0123+"/"+STR0124+"/" //"EXAMES CLÍNICOS" //"COMPLEMENTARES"
				@li,064 Psay "|"
				@li,065 Psay STR0168//"EXAMES"
				@li,096 Psay "|"
				@li,097 Psay STR0169//"ADM"
				@li,104 Psay "|"
				@li,105 Psay STR0170//"DEM"
				@li,112 Psay "|"
				@li,113 Psay STR0171//"MUD"
				@li,120 Psay "|"
				@li,121 Psay STR0172//"RET"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,032 Psay "|"
				@li,033 Psay STR0125 //"PERIODICIDADE"
				@li,064 Psay "|"
				@li,096 Psay "|"
				@li,104 Psay "|"
				@li,112 Psay "|"
				@li,120 Psay "|"
				@li,128 Psay "|"
				Somalinha()
				@li,000 Psay "|"
				@li,001 Psay Replicate("_",31)
				@li,032 Psay "|"
				@li,033 Psay Replicate("_",31)
				@li,064 Psay "|"
				@li,065 Psay Replicate("_",31)
				@li,096 Psay "|"
				@li,097 Psay Replicate("_",7)
				@li,104 Psay "|"
				@li,105 Psay Replicate("_",7)
				@li,112 Psay "|"
				@li,113 Psay Replicate("_",7)
				@li,120 Psay "|"
				@li,121 Psay Replicate("_",7)
				@li,128 Psay "|"
			EndIf
		ElseIf nModeloImp == 3

			Somalinha()
			Somalinha()

			oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
			oPrintPPRA:Say( lin + nMeiLin, 160, Alltrim( SQB->QB_DESCRIC ), oFont10b )

			If lin+130 > 3000
				lin := 9999
			EndIf

			Somalinha()

			oPrintPPRA:Line( lin + 130, nMarEsq, lin + 130, nMarDir )
			oPrintPPRA:Line( lin + 1, nMarEsq, lin + 130, nMarEsq )
			oPrintPPRA:Line( lin + 1, nMarDir, lin + 130, nMarDir )

			If lAnexoA
				oPrintPPRA:Line( lin + 1, 680, lin + 130, 680 )
				oPrintPPRA:Line( lin + 1, 1210, lin + 130, 1210 )
				oPrintPPRA:Line( lin + 1, 1740, lin + 130, 1740 )
				oPrintPPRA:Say( lin + nMeiLin, 160, cTitulo, oFont10b ) // "FUNÇÃO"
				oPrintPPRA:Say( lin + nMeiLin, 690, STR0121 + " / " + STR0122, oFont10b ) // "AGENTES" // "RISCOS"
				oPrintPPRA:Say( lin + nMeiLin, 1220, STR0123 + " /", oFont10b ) // "EXAMES CLÍNICOS"
				oPrintPPRA:Say( lin + nMeiLin * 2, 1220, STR0124, oFont10b ) // "COMPLEMENTARES"
				oPrintPPRA:Say( lin + nMeiLin * 3, 1220, "/ " + STR0125, oFont10b ) // "PERIODICIDADE"
				oPrintPPRA:Say( lin + nMeiLin, 1750, STR0128, oFont10b ) // "AÇÕES DE PROMOÇÃO A"
				oPrintPPRA:Say( lin + nMeiLin * 2, 1750, STR0129 + " / " + STR0130, oFont10b ) // "SAÚDE" // "PROTEÇÃO"
				oPrintPPRA:Say( lin + nMeiLin * 3, 1750, STR0131, oFont10b ) // "ESPECÍFICA"
				Somalinha()
				lPula60 := .T.
			Else
				oPrintPPRA:Line( lin + 3, 680, lin + 130, 680 )
				oPrintPPRA:Line( lin + 3, 1210, lin + 130, 1210 )
				oPrintPPRA:Line( lin + 3, 1700, lin + 130, 1700 )
				oPrintPPRA:Line( lin + 3, 1837, lin + 130, 1837 )
				oPrintPPRA:Line( lin + 3, 1975, lin + 130, 1975 )
				oPrintPPRA:Line( lin + 3, 2112, lin + 130, 2112 )
				oPrintPPRA:Say( lin + nMeiLin, 160, STR0121 + " / " + STR0122, oFont10b ) // "AGENTES" // "RISCOS"
				oPrintPPRA:Say( lin + nMeiLin, 690, STR0123 + " /", oFont10b ) // "EXAMES CLÍNICOS"
				oPrintPPRA:Say( lin + nMeiLin * 2, 690, STR0124, oFont10b ) // "COMPLEMENTARES"
				oPrintPPRA:Say( lin + nMeiLin * 3, 690, "/ " + STR0125, oFont10b ) // "PERIODICIDADE"
				oPrintPPRA:Say( lin + nMeiLin, 1220, STR0168, oFont10b ) // "EXAMES"
				oPrintPPRA:Say( lin + nMeiLin, 1710, STR0169, oFont10b ) // "ADM"
				oPrintPPRA:Say( lin + nMeiLin, 1847, STR0170, oFont10b ) // "DEM"
				oPrintPPRA:Say( lin + nMeiLin, 1985, STR0171, oFont10b ) // "MUD"
				oPrintPPRA:Say( lin + nMeiLin, 2122, STR0172, oFont10b ) // "RET"
				Somalinha()
				lPula60 := .T.
			EndIf
		Else
			OLE_SetDocumentVar(oWord,"Tabela",Alltrim(SQB->QB_DESCRIC)+" ")
			OLE_ExecuteMacro(oWord,"Final_texto")
			OLE_ExecuteMacro(oWord,"Tb_Anexo_CC")
			OLE_SetDocumentVar(oWord,"Tabela",cTitulo)
			OLE_ExecuteMacro(oWord,"Final_texto")
			If lAnexoA
				OLE_ExecuteMacro(oWord,"Tb_Anexo_Cabec")
			Else
				OLE_ExecuteMacro(oWord,"Tb_AnexoB_Cabec")
			EndIf
		EndIf

		Dbselectarea("TRBA")
		While !eof() .And. cDepto == TRBA->RA_DEPTO
			cCodFunc := TRBA->RA_CODFUN2

			aFuncoes := {}
			Dbselectarea("TRBA")
			While !eof() .And. cDepto == TRBA->RA_DEPTO .And. cCodFunc == TRBA->RA_CODFUN2
				Dbselectarea(cTabFun)
				Dbsetorder(1)
				Dbseek(xFilial(cTabFun)+TRBA->RA_CODFUN)
				aADD(aFuncoes,&(cDesFun))
				Dbselectarea("TRBA")
				DbSkip()
			End

			aRiscos := {}
			Dbselectarea("TRBC")
			Dbseek(cDepto+cCodFunc)
			While !eof() .And. cDepto+cCodFunc == TRBC->DEPTO+TRBC->CODFUN
				cTipoRis := TRBC->TIPO
				cTipoTxt := " "
				If TRBC->TIPO == "1"
					cTipoTxt := STR0132 //"Físico"
				ElseIf TRBC->TIPO == "2"
					cTipoTxt := STR0133 //"Químico"
				ElseIf TRBC->TIPO == "3"
					cTipoTxt := STR0134 //"Biológicos"
				ElseIf TRBC->TIPO == "4"
					cTipoTxt := STR0135 //"Ergonômicos"
				ElseIf TRBC->TIPO == "5"
					cTipoTxt := STR0136 //"Acidentes"
				ElseIf TRBC->TIPO == "6"
					cTipoTxt := STR0240 //"Mecânicos"
				ElseIf TRBC->TIPO == "7"
					cTipoTxt := STR0241 //"Perigosos"
				ElseIf TRBC->TIPO == "8"
					cTipoTxt := STR0295 //"Psicossociais"
				EndIf
				aADD(aRiscos,{cTipoTxt,{}})
				While !eof() .And. cDepto+cCodFunc == TRBC->DEPTO+TRBC->CODFUN .And. cTipoRis == TRBC->TIPO
					aADD(aRiscos[len(aRiscos),2],TRBC->NUMRIS)
					DbSkip()
				End
			End

			aExames := {}
			Dbselectarea("TRBD")
			Dbsetorder(2)
			Dbseek(cDepto+cCodFunc)
			While !eof() .And. cDepto+cCodFunc == TRBD->DEPTO+TRBD->CODFUN
				cPeriodic := TRBD->PERIODIC
				aADD(aExames,{TRBD->PERIODIC,TRBD->POSADM,{}})
				While !eof() .And. cDepto+cCodFunc == TRBD->DEPTO+TRBD->CODFUN .And. cPeriodic == TRBD->PERIODIC
					If TRBD->TIPO == "1"
						cTipoTxt := STR0138 //"Exame Clínico"
					ElseIf TRBD->TIPO == "2"
						cTipoTxt := STR0139 //"Exames Complementares"
					Else
						cTipoTxt := STR0137 //"Outros"
					EndIf
					aADD(aExames[len(aExames),3],{cTipoTxt,{}})
					cTipoExa := TRBD->TIPO
					While !eof() .And. cDepto+cCodFunc == TRBD->DEPTO+TRBD->CODFUN .And. ;
						cTipoExa == TRBD->TIPO .And. cPeriodic == TRBD->PERIODIC

						aADD(aExames[len(aExames),3,len(aExames[len(aExames),3]),2],TRBD->EXAME)
						DbSkip()
					End
				End
			End

			aAcoes := {}
			Dbselectarea("TRBE")
			Dbseek(cDepto+cCodFunc)
			While !eof() .And. cDepto+cCodFunc == TRBE->DEPTO+TRBE->CODFUN
				nGoTo_ := Val(TRBE->RECOME)
				If nGoTo_ > 0
					dbSelectArea("TO1")
					dbGoTo(nGoTo_)
					If !Eof()
						aADD(aAcoes,Alltrim(TO1->TO1_RECOME))
					EndIf
				EndIf
				Dbselectarea("TRBE")
				DbSkip()
			End
			aFunExames := {}
			If lAnexoB
				Dbselectarea("TRBF")
				dbSetOrder(1)
				Dbseek(cDepto+cCodFunc)
				While !eof() .And. cDepto+cCodFunc == TRBF->DEPTO+TRBF->CODFUN
					If ((nPosExa := aScan(aFunExames,{|x| SubStr(x[1],1,40) == SubStr(TRBF->EXAME,1,40)})) == 0)
						aAdd(aFunExames, {SubStr(TRBF->EXAME,1,40), Trim(TRBF->NATUREZA)})
					Else
						aFunExames[nPosExa,2] += Trim(TRBF->NATUREZA)
					EndIf
					DbSkip()
				End
			EndIf

			If nModeloImp == 2
				cTextoFun := ""
				For nInd := 1 to Len(aFuncoes)
					If lAnexoA
						If nInd > Len(aLetras)
							cTextoFun += Alltrim(Str(nInd,6))+") "+aFuncoes[nInd]+CRLF
						Else
							cTextoFun += aLetras[nInd]+") "+aFuncoes[nInd]+CRLF
						EndIf
					Else
						If nInd == 1
							cTextoFun := cTitulo+":"
						EndIf
						cTextoFun += " "+AllTrim(aFuncoes[nInd])
						If nInd <> Len(aFuncoes)
							cTextoFun += ","
						EndIf
					EndIf
				Next nInd

				cTextoRis := ""
				For nInd := 1 to Len(aRiscos)
					If Empty(aRiscos[nInd,1]) .And. Len(aRiscos) == 1
						cLinha := Alltrim(Str(nInd,6))+"- "+STR0110 //"Ausência de riscos"
					Else
						cLinha := Alltrim(Str(nInd,6))+"- "+Alltrim(aRiscos[nInd,1])+": "
					EndIf
					For nInd2 := 1 To Len(aRiscos[nInd,2])
						If Alltrim(aRiscos[nInd,2,nInd2]) <> STR0110 //"Ausência de riscos"
							cLinha += Alltrim(aRiscos[nInd,2,nInd2])+If(nInd2<>Len(aRiscos[nInd,2]),", ",".")
						EndIf
					Next nInd2
					cLinha += CRLF
					cTextoRis += cLinha
				Next nInd

				cTextoExa := ""
				For nInd1 := 1 to Len(aExames)
					cTextoExa += Capital(STR0125)+": "+Alltrim(aExames[nInd1,1]) //"Periodicidade"
					cTextoExa += CRLF
					cTextoExa += STR0234+": " + Alltrim(aExames[nInd1,2])//"Pós-Admissional"
					cTextoExa += CRLF
					For nInd := 1 to Len(aExames[nInd1,3])
						cLinha := Alltrim(aExames[nInd1,3,nInd,1])+": "
						For nInd2 := 1 To Len(aExames[nInd1,3,nInd,2])
							cLinha += Alltrim(aExames[nInd1,3,nInd,2,nInd2])+If(nInd2<>Len(aExames[nInd1,3,nInd,2]),", ",".")
						Next nInd2
						cLinha += CRLF
						cTextoExa += cLinha
					Next nInd
					If Len(aExames) <> nInd1
						cTextoExa += CRLF
					EndIf
				Next nInd1

				cTextoAco := ""
				For nInd := 1 to Len(aAcoes)
					cTextoAco += Alltrim(aAcoes[nInd])+CRLF
				Next nInd

				cExa2Texto := ""
				For nInd := 1 to Len(aFunExames)
					cExa2Texto += "#*"+Padr(aFunExames[nInd,2],4)+Alltrim(aFunExames[nInd,1])+CRLF
				Next nInd

				If lAnexoA
					nTxtFun := MLCOUNT(cTextoFun,31)
					nMaior  := nTxtFun
					nTxtAco := MLCOUNT(cTextoAco,31)
					nMaior  := If(nTxtAco > nMaior,nTxtAco,nMaior)
				Else
					nTxtFun := MLCOUNT(cTextoFun,124)
					nMaior  := 0
					nTxtEx2 := MLCOUNT(cExa2Texto,31)
					nMaior  := If(nTxtEx2 > nMaior,nTxtEx2,nMaior)
					For i:=1 to nTxtFun
						Somalinha(i<>1,.T.,,,lAnexoB)
						@li,000 Psay "|"
						If !Empty(MemoLine(cTextoFun,124,i))
							@li,001 Psay MemoLine(cTextoFun,124,i)
						EndIf
						@li,128 Psay "|"
						If i == nTxtFun
							@li,000 Psay "|"
							@li,001 Psay Replicate("_",127)
							@li,128 Psay "|"
						EndIf
					Next
				EndIf

				nTxtRis := MLCOUNT(cTextoRis,31)
				nTxtExa := MLCOUNT(cTextoExa,31)

				nMaior  := If(nTxtRis > nMaior,nTxtRis,nMaior)
				nMaior  := If(nTxtExa > nMaior,nTxtExa,nMaior)

				For nInd := 1 to nMaior
					Somalinha(nInd <> 1,.T.,,lAnexoB)
					@li,000 Psay "|"
					If lAnexoA
						If !Empty(MemoLine(cTextoFun,31,nInd))
							@li,001 Psay MemoLine(cTextoFun,31,nInd)
						EndIf
						@li,032 Psay "|"
						If !Empty(MemoLine(cTextoRis,31,nInd))
							@li,033 Psay MemoLine(cTextoRis,31,nInd)
						EndIf
						@li,064 Psay "|"
						If !Empty(MemoLine(cTextoExa,31,nInd))
							@li,065 Psay MemoLine(cTextoExa,31,nInd)
						EndIf
						@li,096 Psay "|"
						If !Empty(MemoLine(cTextoAco,31,nInd))
							@li,097 Psay MemoLine(cTextoAco,31,nInd)
						EndIf
						@li,128 Psay "|"
						If nInd == nMaior
							If Somalinha(nInd <> 1,.T.,.T.)
								@li,000 Psay "|"
								@li,001 Psay Replicate("_",31)
								@li,032 Psay "|"
								@li,033 Psay Replicate("_",31)
								@li,064 Psay "|"
								@li,065 Psay Replicate("_",31)
								@li,096 Psay "|"
								@li,097 Psay Replicate("_",31)
								@li,128 Psay "|"
							EndIf
						EndIf
					Else
						If !Empty(MemoLine(cTextoRis,31,nInd))
							@li,001 Psay MemoLine(cTextoRis,31,nInd)
						EndIf
						@li,032 Psay "|"
						If !Empty(MemoLine(cTextoExa,31,nInd))
							@li,033 Psay MemoLine(cTextoExa,31,nInd)
						EndIf
						@li,064 Psay "|"
						cExaFun := MemoLine(cExa2Texto,31,nInd)
						If !Empty(cExaFun)
							//Indica se marca ou nao
							If At("#*",cExaFun) > 0
								@li,065 Psay SubStr(cExaFun,7)
								@li,096 Psay "|"
								If "A" $ Substr(cExaFun,1,6)
									@li,100 Psay "X"
								EndIf
								@li,104 Psay "|"
								If "D" $ Substr(cExaFun,1,6)
									@li,108 Psay "X"
								EndIf
								@li,112 Psay "|"
								If "M" $ Substr(cExaFun,1,6)
									@li,116 Psay "X"
								EndIf
								@li,120 Psay "|"
								If "R" $ Substr(cExaFun,1,6)
									@li,124 Psay "X"
								EndIf
								@li,128 Psay "|"
							Else
								@li,065 Psay cExaFun
								@li,096 Psay "|"
								@li,104 Psay "|"
								@li,112 Psay "|"
								@li,120 Psay "|"
								@li,128 Psay "|"
							EndIf
							//Verifica se a proxima linha e nova
							If (At("#*",MemoLine(cExa2Texto,31,nInd+1)) > 0) .Or. (Empty(MemoLine(cExa2Texto,31,nInd+1)))
								@li,066 Psay Replicate("_",31)
								@li,098 Psay Replicate("_",7)
								@li,106 Psay Replicate("_",7)
								@li,114 Psay Replicate("_",7)
								@li,122 Psay Replicate("_",7)
							EndIf
						Else
							@li,096 Psay "|"
							@li,104 Psay "|"
							@li,112 Psay "|"
							@li,120 Psay "|"
							@li,128 Psay "|"
						EndIf
						If nInd == nMaior
							If Somalinha(nInd <> 1,.T.,.T.,,lAnexoB)
								@li,000 Psay "|"
								@li,001 Psay Replicate("_",31)
								@li,032 Psay "|"
								@li,033 Psay Replicate("_",31)
								@li,064 Psay "|"
								@li,065 Psay Replicate("_",31)
								@li,096 Psay "|"
								@li,097 Psay Replicate("_",7)
								@li,104 Psay "|"
								@li,105 Psay Replicate("_",7)
								@li,112 Psay "|"
								@li,113 Psay Replicate("_",7)
								@li,120 Psay "|"
								@li,121 Psay Replicate("_",7)
								@li,128 Psay "|"
							EndIf
						EndIf
					EndIf
				Next nInd

			ElseIf nModeloImp == 3

				aDadosTmp := {"","","","",""}

				cTexto := ""
				For nInd := 1 to Len(aFuncoes)
					If lAnexoA
						If nInd > Len(aLetras)
							cTexto += Alltrim(Str(nInd,6))+") "+aFuncoes[nInd]+CRLF
						Else
							cTexto += aLetras[nInd]+") "+aFuncoes[nInd]+CRLF
						EndIf
					Else
						If nInd == 1
							cTexto := cTitulo+":"
						EndIf
						cTexto += " "+AllTrim(aFuncoes[nInd])
						If nInd <> Len(aFuncoes)
							cTexto += ","
						EndIf
					EndIf
				Next nInd
				aDadosTmp[1] := cTexto

				cTexto := ""
				For nInd := 1 to Len(aRiscos)
					If Empty(aRiscos[nInd,1]) .And. Len(aRiscos) == 1
						cLinha := Alltrim(Str(nInd,6))+"- "+STR0110// "Ausência de riscos"
					Else
						cLinha := Alltrim(Str(nInd,6))+"- "+Alltrim(aRiscos[nInd,1])+": "
					EndIf
					For nInd2 := 1 To Len(aRiscos[nInd,2])
						If Alltrim(aRiscos[nInd,2,nInd2]) <> STR0110 //"Ausência de riscos"
							cLinha += Alltrim(aRiscos[nInd,2,nInd2])+If(nInd2<>Len(aRiscos[nInd,2]),", ",".")
						EndIf
					Next nInd2
					cLinha += CRLF
					cTexto += cLinha
				Next nInd
				aDadosTmp[2] := cTexto

				cTexto := ""
				For nInd1 := 1 to Len(aExames)
					cTexto += Capital(STR0125)+": "+Alltrim(aExames[nInd1,1]) //"Periodicidade"
					cTexto += CRLF
					cTexto += STR0234+": " + Alltrim(aExames[nInd1,2])//"Pós-Admissional"
					cTexto += CRLF
					For nInd := 1 to Len(aExames[nInd1,3])
						cLinha := Alltrim(aExames[nInd1,3,nInd,1])+": "
						For nInd2 := 1 To Len(aExames[nInd1,3,nInd,2])
							cLinha += Alltrim(aExames[nInd1,3,nInd,2,nInd2])+If(nInd2<>Len(aExames[nInd1,3,nInd,2]),", ",".")
						Next nInd2
						cLinha += CRLF
						cTexto += cLinha
					Next nInd
					If Len(aExames) <> nInd1
						cTexto += CRLF
					EndIf
				Next nInd1
				aDadosTmp[3] := cTexto

				cTexto := ""
				For nInd := 1 to Len(aAcoes)
					cTexto += Alltrim(aAcoes[nInd])+CRLF
				Next nInd
				aDadosTmp[4] := cTexto

				cTexto := ""
				For nInd := 1 to Len(aFunExames)
					cTexto += "#*"+Padr(aFunExames[nInd,2],4)+Alltrim(aFunExames[nInd,1])+CRLF
				Next nInd
				aDadosTmp[5] := cTexto

				If lAnexoA
					nTxtFun := MLCOUNT(aDadosTmp[1],31)
					nMaior  := nTxtFun
					nTxtAco := MLCOUNT(aDadosTmp[4],31)
					nMaior  := If(nTxtAco > nMaior,nTxtAco,nMaior)
				Else
					nTxtFun := MLCOUNT(aDadosTmp[1],110)
					nMaior  := 0
					nTxtEx2 := MLCOUNT(aDadosTmp[5],31)
					nMaior  := If(nTxtEx2 > nMaior,nTxtEx2,nMaior)
					For i:=1 to nTxtFun
						Somalinha()
						oPrintPPRA:Line( lin, nMarEsq, lin + 60, nMarEsq )
						oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )
						oPrintPPRA:Line( lin + 60, nMarEsq, lin + 60, nMarDir )
						If !Empty(MemoLine(aDadosTmp[1],110,i))
							oPrintPPRA:Say( lin + nMeiLin, 160, MemoLine( aDadosTmp[ 1 ], 110, i ), oFont10 )
						EndIf
					Next
				EndIf

				nTxtRis := MLCOUNT(aDadosTmp[2],31)
				nTxtExa := MLCOUNT(aDadosTmp[3],31)
				nMaior  := If(nTxtRis > nMaior,nTxtRis,nMaior)
				nMaior  := If(nTxtExa > nMaior,nTxtExa,nMaior)
				If nMaior < 60
					If lin + (nMaior*40) > 3000
						lin := 9999
					EndIf
				EndIf

				For nInd := 1 to nMaior
					Somalinha()
					oPrintPPRA:Line( lin, 680, lin + 60, 680 )
					oPrintPPRA:Line( lin, 1210, lin + 60, 1210 )
					If lAnexoA
						oPrintPPRA:Line( lin, 1740, lin + 60, 1740 )
					Else
						oPrintPPRA:Line( lin, 1700, lin + 60, 1700 )
						oPrintPPRA:Line( lin, 1837, lin + 60, 1837 )
						oPrintPPRA:Line( lin, 1975, lin + 60, 1975 )
						oPrintPPRA:Line( lin, 2112, lin + 60, 2112 )
					EndIf
					oPrintPPRA:Line( lin, nMarEsq, lin + 60, nMarEsq )
					oPrintPPRA:Line( lin, nMarDir, lin + 60, nMarDir )
					If lAnexoA
						If !Empty(MemoLine(aDadosTmp[1],31,nInd))
							oPrintPPRA:Say( lin + nMeiLin, 160, MemoLine( aDadosTmp[ 1 ], 31, nInd ), oFont08 )
						EndIf
						If !Empty(MemoLine(aDadosTmp[2],31,nInd))
							oPrintPPRA:Say( lin + nMeiLin, 690, MemoLine( aDadosTmp[ 2 ], 31, nInd ), oFont08 )
						EndIf
						If !Empty(MemoLine(aDadosTmp[3],31,nInd))
							oPrintPPRA:Say( lin + nMeiLin, 1220, MemoLine( aDadosTmp[ 3 ], 31, nInd ), oFont08 )
						EndIf
						If !Empty(MemoLine(aDadosTmp[4],31,nInd))
							oPrintPPRA:Say( lin + nMeiLin, 1750, MemoLine( aDadosTmp[ 4 ], 31, nInd ), oFont08 )
						EndIf
					Else
						If !Empty(MemoLine(aDadosTmp[2],31,nInd))
							oPrintPPRA:Say( lin + nMeiLin, 160, MemoLine( aDadosTmp[ 2 ], 31, nInd ), oFont08 )
						EndIf
						If !Empty(MemoLine(aDadosTmp[3],31,nInd))
							oPrintPPRA:Say( lin + nMeiLin, 690, MemoLine( aDadosTmp[ 3 ], 31, nInd ), oFont08 )
						EndIf
						cExaFun := MemoLine(aDadosTmp[5],37,nInd)
						If !Empty(cExaFun)
							//Indica se marca ou nao
							If At("#*",cExaFun) > 0
								oPrintPPRA:Say(lin + nMeiLin,1220, SubStr(cExaFun,7) ,oFont08)
								If "A" $ Substr(cExaFun,1,6)
									oPrintPPRA:Say(lin + nMeiLin,1813.75, "X" ,oFont08)
								EndIf
								If "D" $ Substr(cExaFun,1,6)
									oPrintPPRA:Say(lin + nMeiLin,1951.25, "X" ,oFont08)
								EndIf
								If "M" $ Substr(cExaFun,1,6)
									oPrintPPRA:Say(lin + nMeiLin,2088.75, "X" ,oFont08)
								EndIf
								If "R" $ Substr(cExaFun,1,6)
									oPrintPPRA:Say(lin + nMeiLin,2226.25, "X" ,oFont08)
								EndIf
							Else
								oPrintPPRA:Say(lin+5,1220, cExaFun ,oFont08)
							EndIf
							//Verifica se a proxima linha e nova
							If (At("#*",MemoLine(aDadosTmp[5],37,nInd+1)) > 0) .Or. (Empty(MemoLine(aDadosTmp[5],37,nInd+1)))
								oPrintPPRA:Line( lin + 60, 1210, lin + 60, nMarDir )
							EndIf
						EndIf
					EndIf

					If nInd == nMaior
						oPrintPPRA:Line( lin + 60, nMarEsq, lin + 60, nMarDir )
					EndIf

				Next nInd

			Else
				cTexto := ""
				For nInd := 1 to Len(aFuncoes)
					If lAnexoA
						If nInd > Len(aLetras)
							cTexto += Alltrim(Str(nInd,6))+") "+aFuncoes[nInd]+CRLF
						Else
							cTexto += aLetras[nInd]+") "+aFuncoes[nInd]+CRLF
						EndIf
					Else
						If nInd == 1
							cTexto := cTitulo+":"
						EndIf
						cTexto += " "+AllTrim(aFuncoes[nInd])
						If nInd <> Len(aFuncoes)
							cTexto += ","
						EndIf
					EndIf
				Next nInd
				cTexto += "#*"
				For nInd := 1 to Len(aRiscos)
					If Empty(aRiscos[nInd,1]) .And. Len(aRiscos) == 1
						cLinha := Alltrim(Str(nInd,6))+"- "+STR0110 //"Ausência de riscos"
					Else
						cLinha := Alltrim(Str(nInd,6))+"- "+Alltrim(aRiscos[nInd,1])+": "
					EndIf
					For nInd2 := 1 To Len(aRiscos[nInd,2])
						If Alltrim(aRiscos[nInd,2,nInd2]) <> STR0110 //"Ausência de riscos"
							cLinha += Alltrim(aRiscos[nInd,2,nInd2])+If(nInd2<>Len(aRiscos[nInd,2]),", ",".")
						EndIf
					Next nInd2
					cLinha += CRLF
					cTexto += cLinha
				Next nInd

				cTexto += "#*"
				For nInd1 := 1 to Len(aExames)
					cTexto += Capital(STR0125)+": "+Alltrim(aExames[nInd1,1]) //"Periodicidade"
					cTexto += CRLF
					cTexto += STR0234+": " + Alltrim(aExames[nInd1,2])//"Pós-Admissional"
					cTexto += CRLF
					For nInd := 1 to Len(aExames[nInd1,3])
						cLinha := Alltrim(aExames[nInd1,3,nInd,1])+": "
						For nInd2 := 1 To Len(aExames[nInd1,3,nInd,2])
							cLinha += Alltrim(aExames[nInd1,3,nInd,2,nInd2])+If(nInd2<>Len(aExames[nInd1,3,nInd,2]),", ",".")
						Next nInd2
						cLinha += CRLF
						cTexto += cLinha
					Next nInd
					If Len(aExames) <> nInd1
						cTexto += CRLF
					EndIf
				Next nInd1
				cTexto += "#*"
				If lAnexoA
					For nInd := 1 to Len(aAcoes)
						cTexto += Alltrim(aAcoes[nInd])+CRLF
					Next nInd
				Else
					For nInd := 1 to Len(aFunExames)
						cTexto += Padr(aFunExames[nInd,2],4)+Alltrim(aFunExames[nInd,1])+"%*"
					Next nInd
				EndIf

				OLE_SetDocumentVar(oWord,"Tabela",cTexto)
				OLE_ExecuteMacro(oWord,"Final_texto")
				If lAnexoA
					OLE_ExecuteMacro(oWord,"Tb_Anexo_Fun")
				Else
					OLE_SetDocumentVar(oWord,"Linhas",Len(aFunExames)+1)
					OLE_ExecuteMacro(oWord,"Tb_AnexoB_Fun")
					If TRBA->RA_DEPTO <> cDepto
						OLE_ExecuteMacro(oWord,"Final_texto")
						OLE_ExecuteMacro(oWord,"Somalinha")
					EndIf
				EndIf
			EndIf

			Dbselectarea("TRBA")
		End
		Dbselectarea("TRBA")
	End


	Dbselectarea("TRBA")
	DbCloseArea()
	Dbselectarea("TRBB")
	DbCloseArea()
	Dbselectarea("TRBC")
	DbCloseArea()
	Dbselectarea("TRBD")
	DbCloseArea()
	Dbselectarea("TRBE")
	DbCloseArea()
	Dbselectarea("TRBF")
	DbCloseArea()

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT870DPT2
Agrupa as funcoes com o mesmo riscos e exames departamento

@return .T., Lógico, sempre verdadeiro

@sample U_MDT870DPT2()

@author	Denis Hyroshi de Souza
@since	08/04/2003
/*/
//---------------------------------------------------------------------
User Function MDT870DPT2(cRA_DEPTO,cRA_CODFUN,cRiscos,cExames,cAcoes,lAnexoB)

	Local aArea := GetArea()
	Local _cExames := " "
	Local _cRiscos := " "
	Local _cAcoes  := " "
	Default lAnexoB := .F.

	Dbselectarea("TRBA")
	Dbskip()
	While !eof() .And. cRA_DEPTO == TRBA->RA_DEPTO
		If !Empty(TRBA->RA_CODFUN2)
			Dbselectarea("TRBA")
			DbSkip()
			Loop
		EndIf

		_cExames := " "
		_cRiscos := " "
		_cAcoes  := " "
		_cExames2:= " "

		Dbselectarea("TRBC")
		Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_DEPTO+TRBA->RA_CODFUN == TRBC->DEPTO+TRBC->CODFUN
			_cRiscos += TRBC->NUMRIS
			DbSkip()
		End
		Dbselectarea("TRBD")
		dbSetOrder(1)
		Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_DEPTO+TRBA->RA_CODFUN == TRBD->DEPTO+TRBD->CODFUN
			_cExames += TRBD->EXAME
			DbSkip()
		End
		Dbselectarea("TRBE")
		Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN)
		While !eof() .And. TRBA->RA_DEPTO+TRBA->RA_CODFUN == TRBE->DEPTO+TRBE->CODFUN
			nGoTo_ := Val(TRBE->RECOME)
			If nGoTo_ > 0
				dbSelectArea("TO1")
				dbGoTo(nGoTo_)
				If !Eof()
					_cAcoes += Alltrim(TO1->TO1_RECOME)
				EndIf
			EndIf
			Dbselectarea("TRBE")
			DbSkip()
		End
		If lAnexoB
			Dbselectarea("TRBF")
			dbSetOrder(1)
			Dbseek(TRBA->RA_DEPTO+TRBA->RA_CODFUN)
			While !eof() .And. TRBA->RA_DEPTO+TRBA->RA_CODFUN == TRBF->DEPTO+TRBF->CODFUN
				cExames2 += TRBF->EXAME+TRBF->NATUREZA
				DbSkip()
			End
		EndIf

		If _cExames == cExames .And. _cRiscos == cRiscos .And. _cAcoes == cAcoes .And. _cExames2 == cExames2
			Reclock("TRBA",.F.)
			TRBA->RA_CODFUN2 := cRA_CODFUN
			MsUnLock("TRBA")
		EndIf

		DbSelectArea("TRBA")
		DbSkip()
	End

	RestArea(aArea)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fSubCateg
Carrega no array os tipos de categoria do funcionario

@author  Rodrigo Soledade
@since   15/09/2011
@param   cCateg, Caractere, Categorias separadas por barra

@return  aCateg, Array, Contém as categorias do funcionário
/*/
//-------------------------------------------------------------------
Static Function fSubCateg(cCateg)

	Local aCateg := {}
	Local nPos

	If !Empty(cCateg)
		If Substr(cCateg,1,1) == "/"
			cCateg := Substr(cCateg,2)
		EndIf
		If Substr(cCateg,Len(cCateg),1) != "/"
			cCateg += "/"
		EndIf
		cCateg := AllTrim(cCateg)

		While .T.
			nPos := At("/",cCateg)
			If nPos > 0
				If !Empty(Substr(cCateg,1,nPos-1)) .And. Substr(cCateg,1,nPos-1) != "/"
					aADD(aCateg,Substr(cCateg,1,nPos-1))
				EndIf
				cCateg := Substr(cCateg,nPos+1)
			Else
				Exit
			EndIf
		EndDo
	EndIf

Return aCateg

//-------------------------------------------------------------------
/*/{Protheus.doc} A870INFOCAT
Busca e imprime as informações sobre CATs, emitidas pela organização, 
referentes a seus empregados, relacionados ao laudo.

@author Eloisa Anibaletto
@since 10/07/2023

/*/
//-------------------------------------------------------------------
Static Function f870InfoCat()

	Local aAcidentes	:= {}
	Local cAliasTNC  	:= GetNextAlias()
	Local cLista     	:= ''
	Local cTitulos   	:= ''
	Local cTitVit    	:= ''
	Local cCTT       	:= xFilial( 'CTT' )
	Local cTLG       	:= xFilial( 'TLG' )
	Local cTM0       	:= xFilial( 'TM0' )
	Local cTMR       	:= xFilial( 'TMR' )
	Local cTNC       	:= xFilial( 'TNC' )
	Local cTNG       	:= xFilial( 'TNG' )
	Local cTOJ       	:= xFilial( 'TOJ' )
	Local cSRJ       	:= xFilial( 'SRJ' )
	Local lPrim         := .T.
	Local nI         	:= 0
	Local nMarEsq		:= 150 // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nLinMei		:= 40 // Meio da linha

	BeginSQL Alias cAliasTNC
		SELECT TNC.TNC_VITIMA, TNC.TNC_ACIDEN, TNC.TNC_DESACI, TNC.TNC_INDACI, TNC.TNC_DTACID, 
			TLG.TLG_GRUPO, TLG.TLG_DESCRI, TMR.TMR_CID, TMR.TMR_DOENCA, 
			TNG.TNG_TIPACI, TNG.TNG_DESTIP, TNG.TNG_ESOC, SRJ.RJ_FUNCAO, SRJ.RJ_DESC, 
			TM0.TM0_MAT, TM0.TM0_NUMFIC, TM0.TM0_NOMFIC, TM0.TM0_NOMSOC, TM0.TM0_DTNASC,
			TOJ.TOJ_CODLES, TOJ.TOJ_NOMLES, TOJ.TOJ_ESOC, CTT.CTT_CUSTO, CTT.CTT_DESC01
		FROM %table:TNC% TNC
		LEFT JOIN %table:TM0% TM0 ON
				TM0.TM0_NUMFIC = TNC.TNC_NUMFIC
				AND %exp:cTM0% = TM0.TM0_FILIAL 
				AND TM0.%notDel%
		LEFT JOIN %table:TLG% TLG ON
				TLG.TLG_GRUPO = TNC.TNC_GRPCID
				AND %exp:cTLG% = TLG.TLG_FILIAL
				AND TLG.%notDel%
		LEFT JOIN %table:TMR% TMR ON
				TMR.TMR_CID = TNC.TNC_CID
				AND %exp:cTMR% = TMR.TMR_FILIAL
				AND TMR.%notDel%
		LEFT JOIN %table:TNG% TNG ON
				TNG.TNG_TIPACI = TNC.TNC_TIPACI
				AND %exp:cTNG% = TNG.TNG_FILIAL
				AND TNG.%notDel%
		LEFT JOIN %table:SRJ% SRJ ON
				SRJ.RJ_FUNCAO = TNC.TNC_CODFUN
				AND %exp:cSRJ% = SRJ.RJ_FILIAL
				AND SRJ.%notDel% 
		LEFT JOIN %table:TOJ% TOJ ON
				TOJ.TOJ_CODLES = TNC.TNC_CODLES
				AND %exp:cTOJ% = TOJ.TOJ_FILIAL
				AND TOJ.%notDel%
		LEFT JOIN %table:CTT% CTT ON
				CTT.CTT_CUSTO = TNC.TNC_CC
				AND %exp:cCTT% = CTT.CTT_FILIAL
				AND CTT.%notDel%
		WHERE 
			TNC.TNC_FILIAL = %exp:cTNC%
			AND TNC.TNC_DTACID >= %exp:TO0->TO0_DTINIC% AND TNC.TNC_DTACID <= %exp:TO0->TO0_DTFIM% 
			AND TNC.%notDel%
		GROUP BY TNC.TNC_VITIMA, TNC.TNC_CC, TNC.TNC_ACIDEN, TNC.TNC_DESACI, TNC.TNC_INDACI, TNC.TNC_DTACID, 
			TLG.TLG_GRUPO, TLG.TLG_DESCRI, TMR.TMR_CID, TMR.TMR_DOENCA, 
			TNG.TNG_TIPACI, TNG.TNG_DESTIP, TNG.TNG_ESOC, SRJ.RJ_FUNCAO, SRJ.RJ_DESC, 
			TM0.TM0_MAT, TM0.TM0_NUMFIC, TM0.TM0_NOMFIC, TM0.TM0_NOMSOC, TM0.TM0_DTNASC,
			TOJ.TOJ_CODLES, TOJ.TOJ_NOMLES, TOJ.TOJ_ESOC, CTT.CTT_CUSTO, CTT.CTT_DESC01
	EndSQL

	dbSelectArea( cAliasTNC )
	dbGoTop()

	While !( cAliasTNC )->( Eof() )

		aAdd( aAcidentes, {;
			( cAliasTNC )->( CTT_CUSTO  ),;
			( cAliasTNC )->( TM0_NUMFIC ),;
			( cAliasTNC )->( TM0_MAT    ),;
			( cAliasTNC )->( TM0_NOMFIC ),;
			( cAliasTNC )->( RJ_FUNCAO  ),;
			( cAliasTNC )->( RJ_DESC    ),;
			( cAliasTNC )->( TM0_NOMSOC ),;
			( cAliasTNC )->( TM0_DTNASC ),;
			( cAliasTNC )->( TNC_ACIDEN ),;
			( cAliasTNC )->( TNC_DESACI ),;
			( cAliasTNC )->( TNC_DTACID ),;
			( cAliasTNC )->( TNC_INDACI ),;
			( cAliasTNC )->( TNG_ESOC   ),;
			( cAliasTNC )->( TNG_TIPACI ),;
			( cAliasTNC )->( TNG_DESTIP ),;
			( cAliasTNC )->( TLG_GRUPO  ),;
			( cAliasTNC )->( TLG_DESCRI ),;
			( cAliasTNC )->( TMR_CID    ),;
			( cAliasTNC )->( TMR_DOENCA ),;
			( cAliasTNC )->( TOJ_CODLES ),;
			( cAliasTNC )->( TOJ_NOMLES ),;
			( cAliasTNC )->( TOJ_ESOC   ),;
			( cAliasTNC )->( TNC_VITIMA ),;
			( cAliasTNC )->( CTT_DESC01 );
		} )

		( cAliasTNC )->( dbSkip() )

	End

	( cAliasTNC )->( dbCloseArea() )

	If Len( aAcidentes ) > 0

		For nI := 1 To Len( aAcidentes )

			If nModeloImp == 1
				
				If aAcidentes[ nI, 23 ] == '1' .Or. aAcidentes[ nI, 23 ] == '3' // Se for com vítima

					cTitVit += STR0266 + '#'        // Informações do Func.
					cTitVit += STR0254 + ': ' + '#' // Num. Ficha
					cTitVit += STR0090 + ': ' + '#' // Matrícula
					cTitVit += STR0079 + ': ' + '#' // Nome
					cTitVit += STR0095 + ': ' + '#' // Cód. Função
					cTitVit += STR0198 + ': ' + '#' // Centro de Custo
					cTitVit += STR0267 + ': ' + '#' // Nome Social
					cTitVit += STR0268 + ': ' + '#' // Data Nasc.
					cTitVit += STR0269 + '#'        // Informações do Acidente
					cTitVit += STR0270 + ': ' + '#' // Cód. Acidente
					cTitVit += STR0092 + ': ' + '#' // Data Acidente
					cTitVit += STR0258 + ': ' + '#' // Tipo de Acidente
					cTitVit += STR0271 + ': ' + '#' // Cód. eSocial do Tipo Acidente 
					cTitVit += STR0203 + ': ' + '#' // Tipo
					cTitVit += STR0259 + ': ' + '#' // Grupo Cid
					cTitVit += STR0260 + ': ' + '#' // Cid 
					cTitVit += STR0272 + ': ' + '#' // Natureza Lesão
					cTitVit += STR0273 + ': ' + '#' // Cód. eSocial da Natureza da Lesão

					OLE_SetDocumentVar( oWord, 'titulos_acidente', cTitVit )

					cLista += STR0270 + ' ' + STR0275 + ' - ' + aAcidentes[ nI, 9 ] + '@' + '#'// Cód. Acid. 
					cLista += aAcidentes[ nI, 2 ]  + '#'                       // Num. Ficha
					cLista += aAcidentes[ nI, 3 ]  + '#'                       // Matrícula
					cLista += aAcidentes[ nI, 4 ]  + '#'                       // Nome
					cLista += aAcidentes[ nI, 5 ]  + '  '                      // Cód. Função
					cLista += aAcidentes[ nI, 6 ]  + '#'                       // Desc. Função
					cLista += aAcidentes[ nI, 1 ]  + '  '                      // Cód. Centro de Custo
					cLista += aAcidentes[ nI, 24 ] + '#'                       // Descr. Centro de Custo
					cLista += aAcidentes[ nI, 7 ]  + '#'                       // Nome Social
					cLista += Dtoc( Stod( aAcidentes[ nI, 8 ] ) )  + '#'       // Data Nasc.
					cLista += '#'							                   // Corte para pular linha
					cLista += aAcidentes[ nI, 9 ]  + '  '                      // Cód. Acidente
					cLista += aAcidentes[ nI, 10 ] + '#'                       // Desc. Acidente
					cLista += Dtoc( Stod( aAcidentes[ nI, 11 ] ) ) + '#'       // Data Acidente

					If aAcidentes[ nI, 12 ] == '1'                             // Indicativo de Tipo de Acid.
						cLista += aAcidentes[ nI, 12 ] + ' - ' + STR0262 + '#' // Acidente Típico
					ElseIf aAcidentes[ nI, 12 ] == '2'
						cLista += aAcidentes[ nI, 12 ] + ' - ' + STR0263 + '#' // Acidente de Trajeto
					ElseIf aAcidentes[ nI, 12 ] == '3'
						cLista += aAcidentes[ nI, 12 ] + ' - ' + STR0264 + '#' // Doença de Trabalho
					ElseIf aAcidentes[ nI, 12 ] == '4'
						cLista += aAcidentes[ nI, 12 ] + ' - ' + STR0265 + '#' // Incidente
					EndIf

					cLista += aAcidentes[ nI, 13 ] + '#'                       // Cód. Esocial Tipo Acidente
					cLista += aAcidentes[ nI, 14 ] + '  '                      // Tipo
					cLista += aAcidentes[ nI, 15 ] + '#'                       // Descrição do Tipo
					cLista += aAcidentes[ nI, 16 ] + '  '                      // Cód. Grupo Cid
					cLista += aAcidentes[ nI, 17 ] + '#'                       // Descri. Grupo Cid
					cLista += aAcidentes[ nI, 18 ]                             // Cód. Cid
					cLista += aAcidentes[ nI, 19 ] + '#'                       // Desc. Cid
					cLista += aAcidentes[ nI, 20 ] + '  '                      // Cód. Natureza Lesão
					cLista += aAcidentes[ nI, 21 ] + '#'                       // Descri. Natureza Lesão
					cLista += aAcidentes[ nI, 22 ] + '#'                       // Cód. eSocial da Natureza da Lesão

					OLE_SetDocumentVar( oWord, 'array_acidente', cLista )
					OLE_ExecuteMacro( oWord, 'acidente' )

				ElseIf aAcidentes[ nI, 23 ] == '2' .Or. aAcidentes[ nI, 23 ] == ' ' // Se for sem vítima

					cTitulos += STR0269 + '#'        // Informações do Acidente
					cTitulos += STR0270 + ': ' + '#' // Cód. Acidente
					cTitulos += STR0092 + ': ' + '#' // Data Acidente
					cTitulos += STR0258 + ': ' + '#' // Tipo de Acidente
					cTitulos += STR0271 + ': ' + '#' // Cód. eSocial do Tipo Acidente 
					cTitulos += STR0203 + ': ' + '#' // Tipo
					cTitulos += STR0259 + ': ' + '#' // Grupo Cid
					cTitulos += STR0260 + ': ' + '#' // Cid 
					cTitulos += STR0272 + ': ' + '#' // Natureza Lesão
					cTitulos += STR0273 + ': ' + '#' // Cód. eSocial da Natureza da Lesão

					OLE_SetDocumentVar( oWord, 'titulos_acidente', cTitulos )

					cLista += STR0270 + ' ' + STR0274 + ' - ' + aAcidentes[ nI, 9 ] + '@' + '#'// Cód. Acid.
					cLista += aAcidentes[ nI, 9 ]  + '  '                      // Cód. Acidente
					cLista += aAcidentes[ nI, 10 ] + '#'                       // Desc. Acidente
					cLista += Dtoc( Stod( aAcidentes[ nI, 11 ] ) ) + '#'       // Data Acidente

					If aAcidentes[ nI, 12 ] == '1'                             // Indicativo de Tipo de Acid.
						cLista += aAcidentes[ nI, 12 ] + ' - ' + STR0262 + '#' // Acidente Típico
					ElseIf aAcidentes[ nI, 12 ] == '2'
						cLista += aAcidentes[ nI, 12 ] + ' - ' + STR0263 + '#' // Acidente de Trajeto
					ElseIf aAcidentes[ nI, 12 ] == '3'
						cLista += aAcidentes[ nI, 12 ] + ' - ' + STR0264 + '#' // Doença de Trabalho
					ElseIf aAcidentes[ nI, 12 ] == '4'
						cLista += aAcidentes[ nI, 12 ] + ' - ' + STR0265 + '#' // Incidente
					EndIf

					cLista += aAcidentes[ nI, 13 ] + '#'                       // Cód. Esocial Tipo Acidente
					cLista += aAcidentes[ nI, 14 ] + '  '                      // Tipo
					cLista += aAcidentes[ nI, 15 ] + '#'                       // Descrição do Tipo
					cLista += aAcidentes[ nI, 16 ] + '  '                      // Cód. Grupo Cid
					cLista += aAcidentes[ nI, 17 ] + '#'                       // Descri. Grupo Cid
					cLista += aAcidentes[ nI, 18 ] + '  '                      // Cód. Cid
					cLista += aAcidentes[ nI, 19 ] + '#'                       // Desc. Cid
					cLista += aAcidentes[ nI, 20 ] + '  '                      // Cód. Natureza Lesão
					cLista += aAcidentes[ nI, 21 ] + '#'                       // Descri. Natureza Lesão
					cLista += aAcidentes[ nI, 22 ] + '#'                       // Cód. eSocial da Natureza da Lesão

					OLE_SetDocumentVar( oWord, 'array_acidente', cLista )
					OLE_ExecuteMacro( oWord, 'acidente_sem_vitima' )
				EndIf

				cLista := ''

			ElseIf nModeloImp == 2

				If aAcidentes[ nI, 23 ] == '1' .Or. aAcidentes[ nI, 23 ] == '3' // Se for com vítima
					@ Li, 30 PSay STR0270 + ' ' + STR0275 + ' - ' + SubStr( STR0069, 1, 11 ) + ' ' + DtoC( TO0->TO0_DTINIC ) + ' a ' + DtoC( TO0->TO0_DTFIM )
					SomaLinha()
				ElseIf aAcidentes[ nI, 23 ] == '2' .Or. aAcidentes[ nI, 23 ] == ' ' // Se for sem vítima
					@ Li, 30 PSay STR0270 + ' ' + STR0274 + ' - ' + SubStr( STR0069, 1, 11 ) + ' ' + DtoC( TO0->TO0_DTINIC ) + ' a ' + DtoC( TO0->TO0_DTFIM )
					SomaLinha()
				EndIf

				If aAcidentes[ nI, 23 ] == '1' .Or. aAcidentes[ nI, 23 ] == '3' // Se for com vítima

					@ Li, 0 PSay STR0266 + ': ' // Informações do Func.
					SomaLinha()

					@ Li, 0 PSay STR0254 + ': ' + AllTrim( aAcidentes[ nI, 2 ] ) // Num. da Ficha Méd.
					SomaLinha()

					@ Li, 0 PSay STR0090 + ': ' + AllTrim( aAcidentes[ nI, 3 ] ) // Matrícula
					SomaLinha()

					@ Li, 0 PSay STR0198 + ': ' + AllTrim( aAcidentes[ nI, 1 ] ) // Centro de Custo
					SomaLinha()

					@ Li, 0 PSay STR0079 + ': ' + AllTrim( aAcidentes[ nI, 4 ] ) // Nome
					SomaLinha()

					@ Li, 0 PSay STR0095 + ': ' + AllTrim( aAcidentes[ nI, 5 ] ) +  ' - ' + AllTrim( aAcidentes[ nI, 6 ] ) // Cód. Fun. + Desc.
					SomaLinha()

					@ Li, 0 PSay STR0267 + ': ' + AllTrim( aAcidentes[ nI, 7 ] ) // Nome Social
					SomaLinha()

					@ Li, 0 PSay STR0268 + ': ' + Dtoc( Stod(  aAcidentes[ nI, 8 ] ) ) // Data Nasc.
					SomaLinha()
				EndIf

				@ Li, 0 PSay STR0269 + ': ' // Informações do Acidente
				SomaLinha()

				@ Li, 0 PSay STR0270 + ': ' + AllTrim( aAcidentes[ nI, 9 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 10 ] ) // Cód. Acid. + Desc.
				SomaLinha()

				@ Li, 0 PSay STR0092 + ': ' + Dtoc( Stod( aAcidentes[ nI, 11 ] ) ) // Data Acid.
				SomaLinha()

				If aAcidentes[ nI, 12 ] == '1' // Indicativo de Tipo de Acid.
					@ Li, 0 PSay STR0258 + ': ' + AllTrim( aAcidentes[ nI, 12 ] ) + ' - ' + STR0262 // Acidente Típico
					SomaLinha()
				ElseIf aAcidentes[ nI, 12 ] == '2'
					@ Li, 0 PSay STR0258 + ': ' + AllTrim( aAcidentes[ nI, 12 ] ) + ' - ' + STR0263 // Acidente de Trajeto
					SomaLinha()
				ElseIf aAcidentes[ nI, 12 ] == '3'
					@ Li, 0 PSay STR0258 + ': ' + AllTrim( aAcidentes[ nI, 12 ] ) + ' - ' + STR0264 // Doença de Trabalho
					SomaLinha()
				ElseIf aAcidentes[ nI, 12 ] == '4' 
					@ Li, 0 PSay STR0258 + ': ' + AllTrim( aAcidentes[ nI, 12 ] ) + ' - ' + STR0265 // Incidente
					SomaLinha()
				EndIf

				@ Li, 0 PSay STR0203 + ': ' + AllTrim( aAcidentes[ nI, 14 ] )+ ' - ' + AllTrim( aAcidentes[ nI, 15 ] )// Tipo Acidente
				SomaLinha()

				@ Li, 0 PSay STR0271 + ': ' + AllTrim( aAcidentes[ nI, 13 ] ) // Tipo eSocial
				SomaLinha()

				@ Li, 0 PSay STR0259 + ': ' + AllTrim( aAcidentes[ nI, 16 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 17 ] ) // Gp. Cid + Desc.
				SomaLinha()

				@ Li, 0 PSay STR0260 + ': ' + AllTrim( aAcidentes[ nI, 18 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 19 ] ) // Cid + Desc.
				SomaLinha()

				@ Li, 0 PSay STR0272 + ': ' + AllTrim( aAcidentes[ nI, 20 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 21 ] ) // Nat. da Lesão + Desc.
				SomaLinha()

				@ Li, 0 PSay STR0273 + ': ' + AllTrim( aAcidentes[ nI, 13 ] ) // Cód. eSocial Nat. da Lesão
				SomaLinha()

			ElseIf nModeloImp == 3

				If lPrim

					SomaLinha()

					oPrintPPRA:Say( lin, 700, STR0270 + ' - ' + SubStr( STR0069, 1, 11 ) + '  ' + DtoC( TO0->TO0_DTINIC ) + '  ' + SubStr( STR0070, 1, 11 ) + '  ' + DtoC( TO0->TO0_DTFIM ), oFont13b )
					lPrim := .F.

				EndIf

				SomaLinha()

				If aAcidentes[ nI, 23 ] == '1' .Or. aAcidentes[ nI, 23 ] == '3' // Se for com vítima
					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 950, STR0270 + ' ' + STR0275 + ' - ' , oFont13b ) // Acidente
					oPrintPPRA:Say( lin + nLinMei, 1360, aAcidentes[ nI, 9 ], oFont13 ) 
					SomaLinha()
				ElseIf aAcidentes[ nI, 23 ] == '2' .Or. aAcidentes[ nI, 23 ] == ' ' // Se for sem vítima
					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 950, STR0270 + ' ' + STR0274 + ' - ' , oFont13b ) // Acidente
					oPrintPPRA:Say( lin + nLinMei, 1360, aAcidentes[ nI, 9 ], oFont13 ) 
					SomaLinha()
				EndIf

				If aAcidentes[ nI, 23 ] == '1' .Or. aAcidentes[ nI, 23 ] == '3' // Se for com vítima
					
					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 170, STR0266 , oFont13b ) // Informações do Funcionário
					SomaLinha()

					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Line( lin, 670, lin + 60, 670 )
					oPrintPPRA:Line( lin, 1600, lin + 60, 1600 )
					oPrintPPRA:Line( lin, 1900, lin + 60, 1900 )
					oPrintPPRA:Say( lin + nLinMei, 170, STR0254 + ': ', oFont10b ) // Num. Ficha
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 2 ] ), oFont10 )
					oPrintPPRA:Say( lin + nLinMei, 1620, STR0090 + ': ', oFont10b ) // Matrícula
					oPrintPPRA:Say( lin + nLinMei, 1920, AllTrim( aAcidentes[ nI, 3 ] ), oFont10 )
					SomaLinha()

					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Box( lin, 670, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 170, STR0079 + ': ', oFont10b ) // Nome Ficha
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 4 ] ), oFont10 )
					SomaLinha()

					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Box( lin, 670, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 170, STR0198 + ': ', oFont10b ) // Centro de Custo
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 1 ] ), oFont10 )
					SomaLinha()

					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Box( lin, 670, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 170, STR0095 + ': ', oFont10b ) // Função + Descrição
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 5 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 6 ] ), oFont10 )
					SomaLinha()

					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Line( lin, 670, lin + 60, 670 )
					oPrintPPRA:Line( lin, 1600, lin + 60, 1600 )
					oPrintPPRA:Line( lin, 1900, lin + 60, 1900 )
					oPrintPPRA:Say( lin + nLinMei, 170, STR0267 + ': ', oFont10b ) // Nome Social
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 7 ] ), oFont10 )
					oPrintPPRA:Say( lin + nLinMei, 1620, STR0268 + ': ', oFont10b ) // Data Nasc.
					oPrintPPRA:Say( lin + nLinMei, 1920, Dtoc( Stod( aAcidentes[ nI, 8 ] ) ), oFont10 )
					SomaLinha()

				EndIf

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Say( lin + nLinMei, 170, STR0269 , oFont13b ) // Informações do Acidente
				SomaLinha()


				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, 670, lin + 60, 670 )
				oPrintPPRA:Line( lin, 1600, lin + 60, 1600 )
				oPrintPPRA:Line( lin, 1900, lin + 60, 1900 )
				oPrintPPRA:Say( lin + nLinMei, 170, STR0270 + ': ', oFont10b ) // Cód. Acidente + Descrição
				oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 9 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 10 ] ), oFont10 )
				oPrintPPRA:Say( lin + nLinMei, 1620, STR0092 + ': ', oFont10b ) // Data
				oPrintPPRA:Say( lin + nLinMei, 1920, Dtoc( Stod( aAcidentes[ nI, 11 ] ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, 670, lin + 60, 670 )
				oPrintPPRA:Line( lin, 1600, lin + 60, 1600 )
				oPrintPPRA:Line( lin, 1900, lin + 60, 1900 )

				If aAcidentes[ nI, 12 ] == '1' // Indicativo de Tipo de Acid.
					oPrintPPRA:Say( lin + nLinMei, 170, STR0258 + ': ', oFont10b ) // Acidente Típico
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 12 ] ) + ' - ' + STR0262, oFont10 )
				ElseIf aAcidentes[ nI, 12 ] == '2'
					oPrintPPRA:Say( lin + nLinMei, 170, STR0258 + ': ', oFont10b ) // Acidente de Trajeto
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 12 ] ) + ' - ' + STR0263, oFont10 )
				ElseIf aAcidentes[ nI, 12 ] == '3'
					oPrintPPRA:Say( lin + nLinMei, 170, STR0258 + ': ', oFont10b ) // Doença de Trabalho
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 12 ] ) + ' - ' + STR0264, oFont10 )
				ElseIf aAcidentes[ nI, 12 ] == '4'
					oPrintPPRA:Say( lin + nLinMei, 170, STR0258 + ': ', oFont10b ) // Incidente
					oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 12 ] ) + ' - ' + STR0265, oFont10 )
				EndIf

				oPrintPPRA:Say( lin + nLinMei, 1620, STR0271 + ': ', oFont10b ) // Tipo eSocial
				oPrintPPRA:Say( lin + nLinMei, 1920, AllTrim( aAcidentes[ nI, 13 ] ) , oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Box( lin, 670, lin + 60, nMarDir )
				oPrintPPRA:Say( lin + nLinMei, 170, STR0203 + ': ', oFont10b ) // Tipo de Acid. + Descri
				oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 14 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 15 ] ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Box( lin, 670, lin + 60, nMarDir )
				oPrintPPRA:Say( lin + nLinMei, 170, STR0259 + ': ', oFont10b ) // Grupo Cid
				oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 16 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 17 ] ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Box( lin, 670, lin + 60, nMarDir )
				oPrintPPRA:Say( lin + nLinMei, 170, STR0260 + ': ', oFont10b ) // Cid
				oPrintPPRA:Say( lin + nLinMei, 700, AllTrim( aAcidentes[ nI, 18 ] ) + ' - ' + AllTrim( aAcidentes[ nI, 19 ] ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, 670, lin + 60, 670 )
				oPrintPPRA:Line( lin, 1600, lin + 60, 1600 )
				oPrintPPRA:Line( lin, 1900, lin + 60, 1900 )
				oPrintPPRA:Say( lin + nLinMei, 170, STR0272 + ': ', oFont10b ) // Nat. da Lesão + Descrição
				oPrintPPRA:Say( lin + nLinMei, 700, Substr( AllTrim( aAcidentes[ nI, 20 ] ), 1, 40 ) + ' - ' + Substr( AllTrim( aAcidentes[ nI, 21 ] ), 1, 40 ), oFont10 )
				oPrintPPRA:Say( lin + nLinMei, 1620, STR0273 + ': ', oFont10b ) // Nat. eSocial Cód.
				oPrintPPRA:Say( lin + nLinMei, 1920, AllTrim( aAcidentes[ nI, 22 ] ) , oFont10 )
				SomaLinha()	

				If lin >= 2040

					SomaLinha()

				EndIf

			EndIf

		Next

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} Mdtr870X1V
Validação das perguntas utilizadas na rotina

@author Gabriel Sokacheski
@since 18/10/2023

@param nOrdem, identificador da pergunta

@return lRet, retorno da validação
/*/
//-------------------------------------------------------------------
User Function Mdtr870X1V( nOrdem )

	Local aArea	:= ( 'TMW' )->( GetArea() )

	Local lRet 	:= .T.

	If !IsInCallStack( 'MDTR475' )

		Do Case
			Case nOrdem == 1 // De PCMSO (anterior) ?
				lRet := ExistCpo( 'TMW', Mv_par11 )
			Case nOrdem == 2 // Até PCMSO (anterior) ?
				lRet := fValDeAte( Mv_par11, Mv_par12 )
			Case nOrdem == 3 // De PCMSO (anterior) ? // Word
				lRet := ExistCpo( 'TMW', Mv_par13 )
			Case nOrdem == 4 // Até PCMSO (anterior) ? // Word
				lRet := fValDeAte( Mv_par13, Mv_par14 )
		End Case

	Else

		Do Case
			Case nOrdem == 1 // De PCMSO (anterior) ?
				lRet := ExistCpo( 'TMW', Mv_par01 )
			Case nOrdem == 2 // Até PCMSO (anterior) ?
				lRet := fValDeAte( Mv_par01, Mv_par02 )
			Case nOrdem == 3 // De PCMSO (anterior) ? // Word
				lRet := ExistCpo( 'TMW', Mv_par16 )
			Case nOrdem == 4 // Até PCMSO (anterior) ? // Word
				lRet := fValDeAte( Mv_par16, Mv_par17 )
		End Case

	EndIf

	RestArea( aArea )

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fValDeAte
Valida de até do PCMSO

@author Gabriel Sokacheski
@since 18/10/2023

@param cDe, parâmetro um
@param cAte, parâmetro dois

@return lRet, retorno da validação
/*/
//-------------------------------------------------------------------
Static Function fValDeAte( cDe, cAte )

	Local aArea	:= ( 'TMW' )->( GetArea() )

	Local lRet 	:= .T.

	lRet := ExistCpo( 'TMW', cAte )

	If lRet

		If cAte < cDe

			lRet := .F.

			//-----------------------------------------------------------
            // Mensagens:
            // "Atenção"
            // "O último PCMSO selecionado é menor que o primeiro PCMSO"
			// "Informe um PCMSO maior"
            //-----------------------------------------------------------
            Help( Nil, Nil, STR0076, Nil, STR0281 + '.', 1, 0, Nil, Nil, Nil, Nil, Nil, { STR0282 + '.' } )

		EndIf

	EndIf

	RestArea( aArea )

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fPrevCentCu
Busca e imprime as informações sobre CATs, emitidas pela organização
e calcula a prevalência das CIDs (doenças) por centro de custo.

@author Eloisa Anibaletto
@since 31/01/2025

/*/
//-------------------------------------------------------------------
Static Function fPrevCentCu()

	Local aImprCont     := {}
	Local aImprPrev     := {}
	Local aPrevalencia 	:= {}
	
	Local cCentroCus    := ''
	Local cRegistros    := ''
	Local cMemCC        := ''
	Local cAliasPrev    := GetNextAlias()
	Local cCTT       	:= FWxFilial( 'CTT' )
	Local cTNC       	:= FWxFilial( 'TNC' )
	Local cTLG       	:= FWxFilial( 'TLG' )
	Local cSRA       	:= FWxFilial( 'SRA' )

	Local lPrim         := .T.

	Local nI            := 0
	Local nY            := 0
	Local nLinMei		:= 40   // Meio da linha
	Local nMarEsq		:= 150  // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nPrevalecia   := 0

	BeginSQL Alias cAliasPrev
		SELECT COUNT( DISTINCT( TNC.TNC_NUMFIC ) ) QTFIC, TLG.TLG_GRUPO, TLG.TLG_DESCRI, 
				CTT.CTT_CUSTO, CTT.CTT_DESC01, COUNT( DISTINCT( SRA.RA_MAT ) ) QTFUN
		FROM %table:TNC% TNC
		INNER JOIN %table:CTT% CTT ON
				CTT.CTT_FILIAL = %exp:cCTT%
				AND CTT.CTT_CUSTO = TNC.TNC_CC
				AND CTT.%notDel%
		LEFT JOIN %table:TLG% TLG ON
				TLG.TLG_FILIAL = %exp:cTLG%
				AND TLG.TLG_GRUPO = TNC.TNC_GRPCID
				AND TLG.%notDel%
		LEFT JOIN %table:SRA% SRA ON
				SRA.RA_FILIAL = %exp:cSRA%
				AND SRA.RA_CC = TNC.TNC_CC
				AND SRA.%notDel%
		WHERE
		    TNC.TNC_FILIAL = %exp:cTNC%
			AND TNC.TNC_DTACID >= %exp:TO0->TO0_DTINIC% AND TNC.TNC_DTACID <= %exp:TO0->TO0_DTFIM%
			AND TNC.%notDel%
		GROUP BY TLG.TLG_GRUPO, TLG.TLG_DESCRI, CTT.CTT_CUSTO, CTT.CTT_DESC01
		ORDER BY CTT.CTT_CUSTO, CTT.CTT_DESC01
	EndSQL

	dbSelectArea( cAliasPrev )
	dbGoTop()

	cMemCC := ''

	While !( cAliasPrev )->( Eof() )

		nPrevalecia := ( ( cAliasPrev )->QTFIC / ( cAliasPrev )->QTFUN ) * 100

		If cMemCC != AllTrim( ( cAliasPrev )->CTT_CUSTO )

			aAdd( aImprPrev, {;
				AllTrim( ( cAliasPrev )->CTT_CUSTO  ),;
				AllTrim( ( cAliasPrev )->CTT_DESC01 ),; 
				AllTrim( ( cAliasPrev )->TLG_GRUPO  ),;
				AllTrim( ( cAliasPrev )->TLG_DESCRI ),;
				cValToChar( nPrevalecia ) } )

		Else

			aImprPrev[ Len( aImprPrev ), 3 ] += ';' + AllTrim( ( cAliasPrev )->TLG_GRUPO  )
			aImprPrev[ Len( aImprPrev ), 4 ] += ';' + AllTrim( ( cAliasPrev )->TLG_DESCRI )
			aImprPrev[ Len( aImprPrev ), 5 ] += ';' + cValToChar( nPrevalecia )

		EndIf

		cMemCC := AllTrim( ( cAliasPrev )->CTT_CUSTO  )

		( cAliasPrev )->( dbSkip() )

	End

	( cAliasPrev )->( dbCloseArea() )

	For nI := 1 To Len( aImprPrev )

		cCentroCus := aImprPrev[ nI, 1 ] + ' - ' + aImprPrev[ nI, 2 ]

		aImprCont := {} //Zera para receber novos valores
		aAdd( aImprCont, { StrTokArr( aImprPrev[ nI, 3 ], ';' ), StrTokArr( aImprPrev[ nI, 4 ], ';' ), StrTokArr( aImprPrev[ nI, 5 ], ';' ) } )

		For nY := 1 To Len( aImprCont[ 1, 1 ] )

			If nModeloImp == 1

				If lPrim

					OLE_SetDocumentVar( oWord, 'Titulo', STR0292 )
					OLE_SetDocumentVar( oWord, 'Centro_Custo', STR0198 + ' ' + cCentroCus )
					OLE_SetDocumentVar( oWord, 'CID', STR0260 )
					OLE_SetDocumentVar( oWord, 'Porcentagem', STR0089 )

					lPrim := .F.

				EndIf

				cRegistros += aImprCont[ 1, 1, nY ] + ' - ' + aImprCont[ 1, 2, nY ] + '#'
				cRegistros += Substr( aImprCont[ 1, 3, nY ], 1, 5 ) + '%' + '#'

				//Na ultima CID do centro de custo imprime
				If Len( aImprCont[ 1, 1 ] ) == nY
					OLE_SetDocumentVar( oWord, 'Array_Prevalencia', cRegistros )
					OLE_SetDocumentVar( oWord, 'Linhas', Len( aImprCont ) + 3 )
					OLE_ExecuteMacro( oWord, 'prevalencia_doencas' )
				EndIf

			ElseIf nModeloImp == 2

				If lPrim

					SomaLinha()
					@ Li, 30 PSay STR0292 //Prevalência de Doenças Relacionadas ao Centro de Custo

					SomaLinha()
					SomaLinha()
					@ Li, 30 PSay STR0198 + ' : ' + cCentroCus //Centro de Custo + Descrição

					SomaLinha()
					@ Li, 0 Psay STR0293 //CID + Descrição + Porcentagem
					SomaLinha()

					lPrim := .F.

				EndIf

				@ Li,0 Psay aImprCont[ 1, 1, nY ] + ' - ' + aImprCont[ 1, 2, nY ]
				@ Li,55 Psay Substr( aImprCont[ 1, 3, nY ], 1, 5 ) + '%'
				SomaLinha()

			ElseIf nModeloImp == 3

				If lPrim

					SomaLinha()
					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 750, STR0292, oFont13b ) //Prevalência de Doenças Relacionadas ao Centro de Custo
					SomaLinha()

					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Box( lin, 670, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 170, STR0198 + ': ', oFont10b ) //Centro de Custo + Descrição
					oPrintPPRA:Say( lin + nLinMei, 700,  cCentroCus, oFont10 )
					SomaLinha()

					lPrim := .F.

				EndIf

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, 670, lin + 60, 670 )
				oPrintPPRA:Line( lin, 1600, lin + 60, 1600 )
				oPrintPPRA:Line( lin, 1900, lin + 60, 1900 )
				oPrintPPRA:Say( lin + nLinMei, 170, STR0260 + ': ', oFont10b ) //CID + Descrição
				oPrintPPRA:Say( lin + nLinMei, 700, aImprCont[ 1, 1, nY ] + aImprCont[ 1, 2, nY ], oFont10 )
				oPrintPPRA:Say( lin + nLinMei, 1620, STR0089 + ': ', oFont10b ) //Porcentagem
				oPrintPPRA:Say( lin + nLinMei, 1920, Substr( aImprCont[ 1, 3, nY ], 1, 5 ) + '%', oFont10 )
				SomaLinha()

			EndIf

		Next nY

		lPrim := .T.
		cCentroCus := ''
		cRegistros := ''

	Next nI

	FWFreeArray( aImprCont )
    FWFreeArray( aImprPrev )
    FWFreeArray( aPrevalencia )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fIncCentCu
Busca e imprime as informações sobre CATs, emitidas pela organização
e calcula a incidência das CIDs (doenças) por centro de custo.

@author Eloisa Anibaletto
@since 31/01/2025

/*/
//-------------------------------------------------------------------
Static Function fIncCentCu()

	Local aImprCont     := {}
	Local aImprInc      := {}
	Local aIncidencia 	:= {}
	
	Local cCentroCus    := ''
	Local cDataInic     := ''
	Local cDataFim      := ''
	Local cRegistros    := ''
	Local cMemCC        := ''
	Local cAliasInc     := GetNextAlias()
	Local cCTT       	:= FWxFilial( 'CTT' )
	Local cTNC       	:= FWxFilial( 'TNC' )
	Local cTLG       	:= FWxFilial( 'TLG' )
	Local cSRA       	:= FWxFilial( 'SRA' )

	Local lPrim         := .T.

	Local nI            := 0
	Local nY            := 0
	Local nIncidencia   := 0
	Local nLinMei		:= 40   // Meio da linha
	Local nMarEsq		:= 150  // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima

	//Pega ultimo mês corrente ou último mês do laudo para filtrar por casos novos
	If Date() >= TO0->TO0_DTINIC .And. Date() <= TO0->TO0_DTFIM
		cDataInic := cValToChar( Year( Date() ) ) + cValToChar( StrZero( Month( Date() ), 2 ) ) + '01'
		cDataFim  := cValToChar( Year( Date() ) ) + cValToChar( StrZero( Month( Date() ), 2 ) ) + '31'
	Else
		cDataInic := cValToChar( Year( Date() ) ) + cValToChar( StrZero( Month( TO0->TO0_DTFIM ), 2 ) ) + '01'
		cDataFim  := cValToChar( Year( Date() ) ) + cValToChar( StrZero( Month( TO0->TO0_DTFIM ), 2 ) ) + '31'
	EndIf

	BeginSQL Alias cAliasInc
		SELECT COUNT( DISTINCT( TNC.TNC_NUMFIC ) ) QTFIC, TLG.TLG_GRUPO, TLG.TLG_DESCRI, 
				CTT.CTT_CUSTO, CTT.CTT_DESC01, COUNT( DISTINCT( SRA.RA_MAT ) ) QTFUN
		FROM %table:TNC% TNC
		INNER JOIN %table:CTT% CTT ON
				CTT.CTT_FILIAL = %exp:cCTT%
				AND CTT.CTT_CUSTO = TNC.TNC_CC
				AND CTT.%notDel%
		LEFT JOIN %table:TLG% TLG ON
				TLG.TLG_FILIAL = %exp:cTLG%
				AND TLG.TLG_GRUPO = TNC.TNC_GRPCID
				AND TLG.%notDel%
		LEFT JOIN %table:SRA% SRA ON
				SRA.RA_FILIAL = %exp:cSRA%
				AND SRA.RA_CC = TNC.TNC_CC
				AND SRA.%notDel%
		WHERE
		    TNC.TNC_FILIAL = %exp:cTNC%
			AND TNC.TNC_DTACID >= %exp:cDataInic% AND TNC.TNC_DTACID <= %exp:cDataFim%
			AND TNC.%notDel%
		GROUP BY TLG.TLG_GRUPO, TLG.TLG_DESCRI, CTT.CTT_CUSTO, CTT.CTT_DESC01
		ORDER BY CTT.CTT_CUSTO, CTT.CTT_DESC01
	EndSQL

	dbSelectArea( cAliasInc )
	dbGoTop()

	cMemCC := ''

	While !( cAliasInc )->( Eof() )

		nIncidencia := ( ( cAliasInc )->QTFIC / ( cAliasInc )->QTFUN ) * 1000

		If cMemCC != AllTrim( ( cAliasInc )->CTT_CUSTO )

			aAdd( aImprInc, {;
				AllTrim( ( cAliasInc )->CTT_CUSTO  ),;
				AllTrim( ( cAliasInc )->CTT_DESC01 ),; 
				AllTrim( ( cAliasInc )->TLG_GRUPO  ),;
				AllTrim( ( cAliasInc )->TLG_DESCRI ),;
				cValToChar( nIncidencia ) } )

		Else

			aImprInc[ Len( aImprInc ), 3 ] += ';' + AllTrim( ( cAliasInc )->TLG_GRUPO  )
			aImprInc[ Len( aImprInc ), 4 ] += ';' + AllTrim( ( cAliasInc )->TLG_DESCRI )
			aImprInc[ Len( aImprInc ), 5 ] += ';' + cValToChar( nIncidencia )

		EndIf

		cMemCC := AllTrim( ( cAliasInc )->CTT_CUSTO  )

		( cAliasInc )->( dbSkip() )

	End

	( cAliasInc )->( dbCloseArea() )

	For nI := 1 To Len( aImprInc )

		cCentroCus := aImprInc[ nI, 1 ] + ' - ' + aImprInc[ nI, 2 ]

		aImprCont := {} //Zera para receber novos valores
		aAdd( aImprCont, { StrTokArr( aImprInc[ nI, 3 ], ';' ), StrTokArr( aImprInc[ nI, 4 ], ';' ), StrTokArr( aImprInc[ nI, 5 ], ';' ) } )

		For nY := 1 To Len( aImprCont[ 1, 1 ] )

			If nModeloImp == 1

				If lPrim

					OLE_SetDocumentVar( oWord, 'Titulo', STR0294 )
					OLE_SetDocumentVar( oWord, 'Centro_Custo', STR0198 + ' ' + cCentroCus )
					OLE_SetDocumentVar( oWord, 'CID', STR0260 )
					OLE_SetDocumentVar( oWord, 'Porcentagem', STR0089 )

					lPrim := .F.

				EndIf

				cRegistros += aImprCont[ 1, 1, nY ] + ' - ' + aImprCont[ 1, 2, nY ] + '#'
				cRegistros += Substr( aImprCont[ 1, 3, nY ], 1, 3 ) + '%' + '#'

				//Na ultima CID do centro de custo imprime
				If Len( aImprCont[ 1, 1 ] ) == nY
					OLE_SetDocumentVar( oWord, 'Array_Incidencia', cRegistros )
					OLE_SetDocumentVar( oWord, 'Linhas', Len( aImprCont ) + 3 )
					OLE_ExecuteMacro( oWord, 'incidencia_doencas' )
				EndIf

			ElseIf nModeloImp == 2

				If lPrim

					SomaLinha()
					@ Li, 30 PSay STR0294 //Incidência de Doenças Relacionadas ao Centro de Custo

					SomaLinha()
					SomaLinha()
					@ Li, 30 PSay STR0198 + ' : ' + cCentroCus //Centro de Custo + Descrição

					SomaLinha()
					@ Li, 0 Psay STR0293 //CID + Descrição + Porcentagem
					SomaLinha()

					lPrim := .F.

				EndIf

				@ Li,0 Psay aImprCont[ 1, 1, nY ] + ' - ' + aImprCont[ 1, 2, nY ]
				@ Li,55 Psay Substr( aImprCont[ 1, 3, nY ], 1, 3 ) + '%'
				SomaLinha()

			ElseIf nModeloImp == 3

				If lPrim

					SomaLinha()
					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 750, STR0294, oFont13b ) //Incidência de Doenças Relacionadas ao Centro de Custo
					SomaLinha()

					oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
					oPrintPPRA:Box( lin, 670, lin + 60, nMarDir )
					oPrintPPRA:Say( lin + nLinMei, 170, STR0198 + ': ', oFont10b ) //Centro de Custo + Descrição
					oPrintPPRA:Say( lin + nLinMei, 700,  cCentroCus, oFont10 )
					SomaLinha()

					lPrim := .F.

				EndIf

				oPrintPPRA:Box( lin, nMarEsq, lin + 60, nMarDir )
				oPrintPPRA:Line( lin, 670, lin + 60, 670 )
				oPrintPPRA:Line( lin, 1600, lin + 60, 1600 )
				oPrintPPRA:Line( lin, 1900, lin + 60, 1900 )
				oPrintPPRA:Say( lin + nLinMei, 170, STR0260 + ': ', oFont10b ) //CID + Descrição
				oPrintPPRA:Say( lin + nLinMei, 700, aImprCont[ 1, 1, nY ] + aImprCont[ 1, 2, nY ], oFont10 )
				oPrintPPRA:Say( lin + nLinMei, 1620, STR0089 + ': ', oFont10b ) //Porcentagem
				oPrintPPRA:Say( lin + nLinMei, 1920, Substr( aImprCont[ 1, 3, nY ], 1, 3 ) + '%', oFont10 )
				SomaLinha()

			EndIf

		Next nY

		lPrim := .T.
		cCentroCus := ''
		cRegistros := ''

	Next nI

	FWFreeArray( aImprCont )
    FWFreeArray( aImprInc )
    FWFreeArray( aIncidencia )

Return
