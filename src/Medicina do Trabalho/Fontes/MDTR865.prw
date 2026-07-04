/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr865.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR865
Emitir o resumo de acidentes com vitima conforme o Quadro III da NR4.

@sample U_MDTR865( )
@author Denis Hyroshi de Souza
@since 03/06/2002

@return Sempre nulo

@Obs Andre E.P.Alvarez - 19/10/05
Logo abaixo do resumo de acidentes, eh impresso o cabecalho com as
informacoes referentes a empresa. As informacoes sao: Nome comercial
da empresa, cidade, endereco comercial e telefone.
Motivo da alteracao: solicitacao do cliente.
/*/
//---------------------------------------------------------------------
User Function MDTR865

	//Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	//Define Variaveis
	Local cString       := "SI3"
	Local wnrel         := "MDTR865"
	Local cDesc1        := STR0001 //"Emitir o resumo de acidentes com vitima "
	Local cDesc2        := STR0002 //"conforme o Quadro III da NR4."
	Local cDesc3        := " "

	Private aReturn     := { STR0003, 1, STR0004, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
	Private nomeprog    := "MDTR865"
	Private tamanho     := "M"
	Private titulo      := STR0005 //"Quadro de Acidentes com Vitima"
	Private ntipo       := 0
	Private nLastKey    := 0
	Private cPerg       := "MDT865    "
	Private cabec1      := " "
	Private cabec2      := " "
	Private cAliasCC    := "SI3"
	Private cDescrCC    := "SI3->I3_DESC"
	Private cFiliaCC    := "SI3->I3_FILIAL"
	Private cCodigCC    := "SI3->I3_CUSTO"
	Private nSizeSI3    := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Private nSizeFil    := FwSizeFilial()
	Private lCompTNC    := (NGSX2MODO("TNC") == "C")
	Private cVerbas     := ""
	Private lIntMDTGPE  := .F.
	Private lMdtps      := .F.
	Private lCalcTaxa   := .F.
	Private aVetinr     := {}

	nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))

	If SuperGetMv("MV_NG2GRAV",.F.,"1") == "2"
		lCalcTaxa := .T.
	Endif

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAliasCC := "CTT"
		cDescrCC := "CTT->CTT_DESC01"
		cFiliaCC := "CTT->CTT_FILIAL"
		cCodigCC := "CTT->CTT_CUSTO"
		cString  := "CTT"
	Endif
	If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
		lMdtps := .T.
	EndIf

	If Alltrim(GETMV("MV_MDTGPE")) == "S"
		lIntMDTGPE := .T.
		cVerbas := Alltrim(GETMV("MV_MDTVERBA"))
	Endif

	/*  Perguntas Padrão
	MDT865    ¦01      ¦De Data ?
	MDT865    ¦02      ¦Ate Data ?
	MDT865    ¦03      ¦Jornada de trabalho ?
	MDT865    ¦04      ¦Dias uteis no ano ?
	MDT865    ¦05      ¦Responsável
	MDT865    ¦06      ¦Data do Mapa
	MDT865    ¦07      ¦De Filial ?
	MDT865    ¦08      ¦Até Filial ?
	MDT865    ¦09      ¦Considera Acid. Traj.?
	MDT865    ¦10      ¦Por Setor?
	MDT865    ¦11      ¦Setor S/ Acid?
	MDT865    ¦12      ¦Tipo de Horas?
	*/

	//Verifica as perguntas selecionadas
	pergunte(cPerg,.F.)

	//Envia controle para a funcao SETPRINT
	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		//Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
	Set Filter to
		//Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
	Return
	Endif

	RptStatus({|lEnd| R865Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)
	dbSelectArea("SM0")
	dbSeek(cEmpAnt+cFilAnt)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} R865Imp
Chamada do Relatório

@param lEnd, Lógico, indica o fim da impressão
@param wnRel, Caracter, nome do relatório
@param titulo, Caracter, título do relatório
@param tamanho, Caracter, tamanho do relatório

@sample R865Imp( )

@author Denis Hyroshi de Souza
@since 03/06/2002

@return Sempre nulo
/*/
//---------------------------------------------------------------------
Static Function R865Imp(lEnd,wnRel,titulo,tamanho)

	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local strCusto
	Local i
	Local nRecno
	Local oTempTRB
	Local lAvgFunPE := SuperGetMv("MV_MDTAVGF",.F.,"N") == "S"
	Local aIndex    := {}
	Local nIndex    := 0
	Local cChaveTNC := ""

	//Contadores de linha e pagina
	Private li := 80 ,m_pag := 1 ,nQtTotVit := 0 ,nQtTotFunc  := 0 ,lPRINT := .T., nQtTotEmp  := 0
	Private nJornada
	Private nDiUteis
	Private aFiliais := {}, cFilAtual := cFilAnt, cNomFil := Upper(Substr(SM0->M0_NOME, 1, 40))

	If lSigaMdtps
		nJornada   := U_mdt865conv(mv_par07)
		nDiUteis   := mv_par08
	Else
		nJornada   := U_mdt865conv(mv_par03)
		nDiUteis   := mv_par04
	endif

	Private nQtHrsTrab := 0
	Private nIndTNC    := 1

	If !lSigaMdtps .And. !lMdtps
		aFiliais := MDTRETFIL("SRA", MV_PAR07, MV_PAR08)
	Else
		aFiliais := { {cFilAnt, Upper(Substr(SM0->M0_NOME, 1, 40)) } }
	Endif

	//Cria arquivo temporario
	aDBF := {}
	AADD(aDBF,{ "CCUSTO"     , "C" ,nSizeSI3, 0 })
	AADD(aDBF,{ "QTFUNC"     , "N" ,06, 0 })
	AADD(aDBF,{ "QTVIT"      , "N" ,06, 0 })
	AADD(aDBF,{ "QTINF15D"   , "N" ,06, 0 })
	AADD(aDBF,{ "QTSUP15D"   , "N" ,06, 0 })
	AADD(aDBF,{ "QTSEMAFAS"  , "N" ,06, 0 })
	AADD(aDBF,{ "QTOBITO"    , "N" ,06, 0 })
	AADD(aDBF,{ "QTDIHOPERD" , "N" ,12, 2 })
	AADD(aDBF,{ "QTDIADEBIT" , "N" ,12, 2 })
	AADD(aDBF,{ "QTHRHOMENS" , "N" ,12, 2 })

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CCUSTO"} )
	oTempTRB:Create()

	For i:=1 to Len(aFiliais)//Percorre todas as filiais
		cFilAtual	:= aFiliais[i,1]
		cNomFil		:= aFiliais[i,2]
		nQtTotVit	:= 0
		nQtTotFunc  := 0
		lPRINT		:= .T.
		nRegTotal	:= (cAliasCC)->(LastRec())

		dbSelectArea("SM0")
		dbSeek(cEmpAnt+cFilAtual)

		//Acumula o total de funcionarios do estabelecimento (NAO PRESTADOR)
		If !lSigaMdtps
			If lAvgFunPE //Se existir parametro MV_MDTAVGF e este for igual a S, faz a media mensal de funcionarios
				nRegTotal += ( SRA->(LastRec()) * Round((Mv_par02 - Mv_par01) / 30,0) )
				SetRegua(nRegTotal)
				nQtTotFunc:= 0
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

					nQtdeTemp += U_MDTCAGED(_Mvpar01,_Mvpar02,,,cFilAtual,,,.T.)//Busca os funcionário por empresa
					nContador += 1

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
				nQtTotEmp := nQtdeTemp / nContador
			Else
				nRegTotal += SRA->(LastRec())
				SetRegua(nRegTotal)
				nQtTotEmp := U_MDTCAGED(Mv_par01,Mv_par02,,,cFilAtual,,,.T.)//Busca os funcionário por empresa.
			Endif
		Else
			SetRegua(nRegTotal)
		Endif

		If FWSIXUtil():ExistIndex( "TNC", "5" )
			nIndTNC := 5
		EndIf

		//Verifica se deve comprimir ou nao
		nTipo  := IIF(aReturn[4]==1,15,18)

		dbSelectArea("TRB")
		ZAP

		dbSelectArea(cAliasCC)
		dbSetOrder(01)
		dbSeek(xFilial(cAliasCC,cFilAtual))

		strCusto := ' '
		cCodCli := ''
		If nQtTotEmp > 0 //Verifica se tem alguma funcionário para a filial
		If lSigaMdtps

			While !Eof() .And. &(cFiliaCC) == xFilial(cAliasCC,cFilAtual)

				Incregua()
				strCusto := &(cCodigCC)
				cCodCli := SubStr(strCusto,1,nSizeTd)

				If cCodCli < mv_par01+mv_par02 .Or. cCodCli > mv_par03+mv_par04
					DbSelectArea(cAliasCC)
					DbSkip()
					Loop
				Endif

				ACIDENTES(strCusto)
				U_MDTCAGED(Mv_par01,Mv_par02,,,cFilAtual,.T.,strCusto)

				DbSelectArea(cAliasCC)
				nRecno := Recno()
				DbSkip()

				If cCodCli != SubStr(&(cCodigCC),1,nSizeTd)
					IMPRIRESUMO()
					DbSelectArea(cAliasCC)
					dbGoTo(nRecno)
					DbSkip()
				Endif

			Enddo
			_IMPRIRESUMO()

			Li := 80

		Else

			While !Eof() .And. &(cFiliaCC) == xFIlial(cAliasCC,cFilAtual)

				Incregua()
				strCusto := &(cCodigCC)

				ACIDENTES(strCusto)
				U_MDTCAGED(Mv_par01,Mv_par02,,,cFilAtual,.T.,strCusto)

				DbSelectArea(cAliasCC)
				DbSkip()

			Enddo

			IMPRIRESUMO()

			Li := 80

		Endif
		EndIf
	Next i

	Roda(nCntImpr,cRodaTxt,Tamanho)
	//Devolve a condicao original do arquivo principal

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
	//use
	oTempTRB:Delete()
	dbSelectArea(cAliasCC)
	dbSetOrder(01)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} ACIDENTES
Acumula Dados da tabela de Acidentes

@param cCentroCusto, Caracter, Codigo Centro de Custo

@sample ACIDENTES( "001" )

@author Denis Hyroshi de Souza
@since 03/06/2002

@return Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function ACIDENTES(cCentroCusto)

	Local nYY,nXX
	Local nDiasTotAf := SuperGetMv( "MV_NG2TOAF" , .F. , 15 )//"Indica a quantidade de dias que a empresa deverá ""pagar, referente ao afastamentos do trabalho. "
	Local lCompTM0 := (NGSX2MODO("TM0") == "C")
	Local lFilFun  := NGCADICBASE("TNC_FILFUN","A","TNC",.F.)

	nQtSup15d   := 0
	nQtInf15d   := 0
	nQtDiHoPerd := 0
	nQtSemAfast := 0
	nQtObito    := 0
	nQtDiasPerd := 0
	nHrDia      := 0
	lExiste     := .F.

	cSeekTNC := xFilial("TNC",cFilAtual)
	If nIndTNC == 5
		cSeekTNC := xFilial("TNC",cFilAtual) + cCentroCusto
	Endif

	dMv_par01 := MV_PAR01
	dMv_par02 := MV_PAR02
	If lSigaMdtps
		dMv_par01 := MV_PAR05
		dMv_par02 := MV_PAR06
	Endif

	DbSelectArea("TNC")
	DbSetOrder(nIndTNC)
	If DbSeek(cSeekTNC)//Verifica se existe um acidente para o Setor.
		nQtvit  := 0
		aDadosTNC := {}
		While !EOF() .And. TNC->TNC_Filial == xFilial("TNC",cFilAtual)

			If !Empty(TNC->TNC_NUMFIC) .And. If( lSigaMdtPs .Or. mv_par09 == 2 , TNC->TNC_INDACI <> "2" , .T. )
				If lFilFun .And. lCompTNC
					If !Empty( TNC->TNC_FILFUN )
						If TNC->TNC_FILFUN != cFilAtual
							DbSelectArea("TNC")
							DbSkip()
							Loop
						EndIf
					Else
						dbSelectArea( "TM0" )
						dbSetOrder( 1 )
						If dbSeek( xFilial( "TM0" ) + TNC->TNC_NUMFIC )
							If lCompTM0
								If Empty( TM0->TM0_MAT ) .Or. TM0->TM0_FILFUN <> cFilAtual
									DbSelectArea("TNC")
									DbSkip()
									Loop
								EndIf
							Else
								If TM0->TM0_FILIAL <> cFilAtual
									DbSelectArea("TNC")
									DbSkip()
									Loop
								EndIf
							EndIf
						Else
							DbSelectArea("TNC")
							DbSkip()
							Loop
						EndIf
					Endif
				Endif
				If TNC->TNC_CC != cCentroCusto
					If nIndTNC == 5
						Exit
					Endif
					DbSelectArea("TNC")
					DbSkip()
					Loop
				Endif
		//Verifica a Data do Acidente.
				If TNC->TNC_DTACID >= mv_par02
					DbSelectArea("TNC")
					DbSkip()
					Loop
				Endif

				If TNC->TNC_DTACID >= dMv_par01 .And. TNC->TNC_DTACID <= dMv_par02
					aAdd( aDadosTNC , { TNC->TNC_ACIDEN, TNC->TNC_CATINS, TNC->TNC_DTOBIT, TNC->TNC_VITIMA,;
						TNC->TNC_QTAFAS, TNC->TNC_HRTRAB, TNC->TNC_TIPCAT, TNC->TNC_DIASDB , TNC->TNC_DTACID } )
				Endif
			Endif

			DbSelectArea("TNC")
			DbSkip()
		End

		aSort(aDadosTNC,,,{|x,y| x[2]+x[7] < y[2]+y[7] })

		For nXX := 1 To Len(aDadosTNC)
			cCodInss := aDadosTNC[nXX,2]
			If !Empty(cCodInss)
				nRegValido := nXX
				For nYY := nXX To Len(aDadosTNC)
					If cCodInss == aDadosTNC[nYY,2]
						nRegValido := nYY
					Else
						Exit
					Endif
				Next nYY
				nXX := nRegValido
			Endif

			nQtvit += 1
			nQtTotVit += 1
	//Se vitima fatal
			If !Empty(aDadosTNC[nXX,3]) .And. aDadosTNC[nXX,4] == '3'
				nQtObito := nQtObito + 1
			Else
		//Afastamento quando nao for vitima fatal
				If aDadosTNC[nXX,5] > nDiasTotAf
					nQtSup15d   := nQtSup15d + 1
				Else
					If aDadosTNC[nXX,5] >= 1
						nQtInf15d += 1
					Else
						nQtSemAfast += 1
					Endif
				Endif
			Endif
	//Verifica o período do afastamento para contabilizar com o final do relatório
			nMaxDias := Max( aDadosTNC[nXX,5] , aDadosTNC[nXX,8] )
			If aDadosTNC[nXX,9] + nMaxDias > dMv_par02
				nMaxDias := DateDiffDay( aDadosTNC[nXX,9] , dMv_par02 )
			EndIf
			nQtDiasPerd += nMaxDias
			lExiste := .T.
			If nMaxDias == 0
				nHrTrab := U_mdt865conv(aDadosTNC[nXX,6])
				If !Empty(aDadosTNC[nXX,6]) .And. nHrTrab > 0 .And. nHrTrab < nJornada
					nHrDia += nJornada - nHrTrab
				Endif
			Endif
		Next nXX

		nQtDiHoPerd :=((nQtDiasPerd * nJornada) + nHrDia)/nJornada
		If lExiste
			DbSelectArea("TRB")
			If !DbSeek(cCentroCusto)
				RecLock("TRB",.T.)
				TRB->CCUSTO      := cCentroCusto
				TRB->QTINF15D    := nQtInf15d
				TRB->QTSUP15D    := nQtSup15d
				TRB->QTSEMAFAS   := nQtSemAfast
				TRB->QTOBITO     := nQtObito
				TRB->QTDIHOPERD  := nQtDiHoPerd
				TRB->QTVIT       := nQtvit
				MsUnlock()
			EndIf
		ElseIf Mv_par11 == 1 //Caso seja impresso Setor sem Acidente.
			DbSelectArea("TRB")
			If !DbSeek(cCentroCusto)
				RecLock("TRB",.T.)
				TRB->CCUSTO      := cCentroCusto
				MsUnlock()
			EndIf
		Endif
	ElseIf Mv_par11 == 1 //Caso seja impresso Setor sem Acidente.
		DbSelectArea("TRB")
		If !DbSeek(cCentroCusto)
			RecLock("TRB",.T.)
			TRB->CCUSTO      := cCentroCusto
			MsUnlock()
		EndIf
	Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} IMPRIRESUMO
Imprime o Resumo dos Acidentes Com Vitimas

@sample IMPRIRESUMO( )

@author Denis Hyroshi de Souza
@since 03/06/2002

@return Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function IMPRIRESUMO()

	nQTIndRel  := 0
	nQTFreq    := 0
	nQTIndGra  := 0
	nQTTxGrav  := 0

	nTSup15d   := 0
	nTInf15d   := 0
	nTDiHoPerd := 0
	nTSemAfast := 0
	nTObito    := 0
	nTFunc     := 0
	nTIndRel   := 0
	nTFreq     := 0
	nTIndGra   := 0
	nTTxGrav   := 0

	lFlag      := .F.

	If lSigaMdtps
		Li := 300
		lPrint := .T.

		Dbselectarea("TRB")
		dbSeek(cCodCli)

		While !Eof() .And. cCodCli == SubStr(TRB->CCUSTO,1,nSizeTD)

			If lPRINT
				SomaLinha()
				@ Li,000 PSay " "

				SomaLinha()
				@ Li,001 PSay Replicate("_",130)
				Somalinha()
				@ Li,000 PSay "|"
				@ Li,131 PSay "|"

				SomaLinha()
				@ Li,000 PSay STR0007 //"|ACIDENTES C/VITIMA______________________________________________  PERIODO DE"         "ATE"    "DATA DO MAPA:            |"
				@ Li,078 PSay Alltrim(DtoC(Mv_par05))
				@ Li,089 PSay STR0040//"ATE"
				@ Li,093 PSay Alltrim(DtoC(Mv_par06))
				If Empty(Mv_par10)
					@ Li,105 PSay STR0041//"DATA DO MAPA: __/__/___  |"
				Else
					@ Li,105 PSay STR0042//"DATA DO MAPA:"
					@ Li,118 PSay Alltrim(DtoC(Mv_par10))
					@ Li,131 PSay "|"
				EndIf

				Somalinha()
				@ Li,000 PSay "|"
				@ Li,131 PSay "|"

				Somalinha()
				If Empty(mv_par09)
					@ Li,000 PSay STR0008 //"|RESPONSAVEL:________________________________________________              ASS:____________________________________|"
				Else
					@ Li,000 PSay STR0021 //"|RESPONSAVEL:"
					@ Li,015 PSay SubStr( NGSEEK("TMK",mv_par09,1,"TMK->TMK_NOMUSU"),1,47 )
					@ Li,091 PSay STR0022 //"ASS:____________________________________|"
				Endif

				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,001 PSay Replicate("_",130)
				@ Li,131 PSay "|"

				fCabR865()

				lPRINT := .F.
			Endif
			lFlag:= .T.
			//Valores por Setor
			nQTIndRel  := (TRB->QTVIT / TRB->QTFUNC ) * 100
			nQTFreq    := (TRB->QTVIT * 1000000) / TRB->QTHRHOMENS
			nQTIndGra  := TRB->QTDIHOPERD / If(MV_PAR10 == 1, TRB->QTVIT, nQtTotVit)
			nQTTxGrav  := (TRB->QTDIHOPERD * 1000000) / TRB->QTHRHOMENS

			//Acumula Para o Total do Estabelecimento
			nTSup15d   := nTSup15d + TRB->QTSUP15D
			nTInf15d   := nTInf15d + TRB->QTINF15D
			nTDiHoPerd := nTDiHoPerd + TRB->QTDIHOPERD
			nTSemAfast := nTSemAfast + TRB->QTSEMAFAS
			nTObito    := nTObito + TRB->QTOBITO
			nTIndRel   := (nQtTotVit / nQtTotEmp) * 100
			nTFreq     := (nQtTotVit * 1000000) / nQtHrsTrab
			nTIndGra   := nTDiHoPerd / nQtTotVit
			nTTxGrav   := (nTDiHoPerd * 1000000) / nQtHrsTrab

			Somalinha()
			@ Li,000 PSay "|"
			DbSelectArea(cAliasCC)
			DbSetOrder(1)
			DbSeek(xFilial(cAliasCC,cFilAtual)+TRB->CCUSTO)
			If Mv_par10 == 1 //Caso seja por Setor
				@ Li,001 PSay SUBSTR(&(cDescrCC),1,If(Len(Alltrim(&(cDescrCC))) < 35, Len(Alltrim(&(cDescrCC))),35));
				+ " (" + cValToChar(TRB->QTFUNC) + ")"
			ELse
			@ Li,001 PSay SUBSTR(&(cDescrCC),1,40)
			EndIf
			@ Li,042 PSay "|"
			@ Li,044 PSay TRB->QTVIT Picture "9999999"
			@ Li,051 PSay "|"
			@ Li,054 PSay TRB->QTINF15D Picture "999999"
			@ Li,060 PSay "|"
			@ Li,063 PSay TRB->QTSUP15D Picture "999999"
			@ Li,069 PSay "|"
			@ Li,072 PSay TRB->QTSEMAFAS Picture "999999"
			@ Li,078 PSay "|"

			If nQTIndRel < 1000
				@ Li,080 PSay nQTIndRel Picture "@E 9999.9999"
			Else
				@ Li,079 PSay nQTIndRel Picture "@E 99999.9999"
			Endif

			@ Li,089 PSay "|"
			@ Li,091 PSay TRB->QTDIHOPERD Picture "@E 9999.9999"
			@ Li,100 PSay "|"

			If nQTFreq < 10000
				@ Li,102 PSay nQTFreq Picture "@E 9999.9999"
			Else
				@ Li,101 PSay nQTFreq Picture "@E 99999.9999"
			Endif

			@ Li,111 PSay "|"
			@ Li,113 PSay TRB->QTOBITO Picture "99999"
			@ Li,120 PSay "|"

			If lCalcTaxa
				@ Li,122 PSay nQTTxGrav Picture "@E 99999999"
			Else
				If nQTIndGra < 1000
					@ Li,122 PSay nQTIndGra Picture "@E 999.9999"
				Else
					@ Li,121 PSay nQTIndGra Picture "@E 99999.9999"
				Endif
			Endif

			@ Li,131 PSay "|"

			SomaLinha()
			If !lPRINT
			@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
			EndIf
			DbSelectArea("TRB")
			DbSkip()
		End

		If lFlag

			Somalinha()
			@ Li,000 PSay "|"
			If ( nQtTotFunc - Int(nQtTotFunc) ) == 0
				@ Li,001 PSay STR0013 + " (" + Alltrim(Str(nQtTotFunc,10)) + ")" //"Total do Estabelecimento"
			Else
				@ Li,001 PSay STR0013 + " (" + Alltrim( TransForm(nQtTotFunc,"@E 999,999.9") ) + ")"//"Total do Estabelecimento"
			Endif
			@ Li,042 PSay "|"
			@ Li,045 PSay nQtTotVit Picture "999999"
			@ Li,051 PSay "|"
			@ Li,054 PSay nTInf15d Picture "999999"
			@ Li,060 PSay "|"
			@ Li,063 PSay nTSup15d Picture "999999"
			@ Li,069 PSay "|"
			@ Li,072 PSay nTSemAfast Picture "999999"
			@ Li,078 PSay "|"

			If nTIndRel < 1000
				@ Li,080 PSay nTIndRel Picture "@E 9999.9999"
			Else
				@ Li,079 PSay nTIndRel Picture "@E 99999.9999"
			Endif

			@ Li,089 PSay "|"
			@ Li,091 PSay nTDiHoPerd Picture "@E 9999.9999"
			@ Li,100 PSay "|"

			If nTFreq < 10000
				@ Li,102 PSay nTFreq Picture "@E 9999.9999"
			Else
				@ Li,101 PSay nTFreq Picture "@E 99999.9999"
			Endif

			@ Li,111 PSay "|"
			@ Li,113 PSay nTObito Picture "99999"
			@ Li,120 PSay "|"

			If lCalcTaxa
				@ Li,122 PSay nTTxGrav Picture "@E 99999999"
			Else
				If nTIndGra < 10000
					@ Li,122 PSay nTIndGra Picture "@E 999.9999"
				Else
					@ Li,121 PSay nTIndGra Picture "@E 99999.9999"
				Endif
			Endif

			@ Li,131 PSay "|"        /////////////////

			SomaLinha()
			If !lPRINT
			@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
			Endif
			MDT865QUAD()
		Endif	//lFlag

	Else
		Dbselectarea("TRB")
		DbGotop()
		While !Eof()

			If lPRINT
				SomaLinha()
				@ Li,000 PSay " "

				SomaLinha()
				@ Li,001 PSay Replicate("_",130)
				Somalinha()
				@ Li,000 PSay "|"
				@ Li,131 PSay "|"

				SomaLinha()
				@ Li,000 PSay STR0007 //"|ACIDENTES C/VITIMA_______________________________________________  PERIODO DE"         "ATE"    "DATA DO MAPA:            |"
				@ Li,078 PSay Alltrim(DtoC(Mv_par01))
				@ Li,089 PSay STR0040//"ATE"
				@ Li,093 PSay Alltrim(DtoC(Mv_par02))
				If Empty(Mv_par06)
					@ Li,105 PSay STR0041//"DATA DO MAPA: __/__/___  |"
				Else
					@ Li,105 PSay STR0042//"DATA DO MAPA:"
					@ Li,118 PSay Alltrim(DtoC(Mv_par06))
					@ Li,131 PSay "|"
				EndIf

				Somalinha()
				@ Li,000 PSay "|"
				@ Li,131 PSay "|"

				Somalinha()
				If Empty(mv_par05)
					@ Li,000 PSay STR0008 //"|RESPONSAVEL:________________________________________________              ASS:____________________________________|"
				Else
					@ Li,000 PSay STR0021 //"|RESPONSAVEL:"
					@ Li,015 PSay SubStr( NGSEEK("TMK",mv_par05,1,"TMK->TMK_NOMUSU"),1,47 )
					@ Li,091 PSay STR0022 //"ASS:____________________________________|"
				Endif

				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,001 PSay Replicate("_",130)
				@ Li,131 PSay "|"

				fCabR865()

				lPRINT := .F.
			Endif
			lFlag:= .T.
			//Acumula por Setor
			nQTIndRel  := (TRB->QTVIT * 100) / TRB->QTFUNC
			nQTFreq    := (TRB->QTVIT * 1000000) / TRB->QTHRHOMENS
			nQTIndGra  := TRB->QTDIHOPERD / If(MV_PAR10 == 1, TRB->QTVIT, nQtTotVit)
			nQTTxGrav  := (TRB->QTDIHOPERD * 1000000) / TRB->QTHRHOMENS

			//Acumula Para o Total do Estabelecimento
			nTSup15d   := nTSup15d + TRB->QTSUP15D
			nTInf15d   := nTInf15d + TRB->QTINF15D
			nTDiHoPerd := nTDiHoPerd + TRB->QTDIHOPERD
			nTSemAfast := nTSemAfast + TRB->QTSEMAFAS
			nTObito    := nTObito + TRB->QTOBITO
			nTIndRel   := (nQtTotVit * 100) / nQtTotEmp
			nTFreq     := (nQtTotVit * 1000000) / nQtHrsTrab
			nTIndGra   := nTDiHoPerd / nQtTotVit
			nTTxGrav   := (nTDiHoPerd * 1000000) / nQtHrsTrab

			Somalinha()
			@ Li,000 PSay "|"
			DbSelectArea(cAliasCC)
			DbSetOrder(1)
			DbSeek(xFilial(cAliasCC,cFilAtual)+TRB->CCUSTO)
			If Mv_par10 == 1 //Caso seja por Setor
				@ Li,001 PSay SUBSTR(&(cDescrCC),1,If(Len(Alltrim(&(cDescrCC))) < 35, Len(Alltrim(&(cDescrCC))),35));
				+ " (" + cValToChar(TRB->QTFUNC) + ")"
			ELse
			@ Li,001 PSay SUBSTR(&(cDescrCC),1,40)
			EndIf
			@ Li,042 PSay "|"
			@ Li,044 PSay TRB->QTVIT Picture "9999999"
			@ Li,051 PSay "|"
			@ Li,054 PSay TRB->QTINF15D Picture "999999"
			@ Li,060 PSay "|"
			@ Li,063 PSay TRB->QTSUP15D Picture "999999"
			@ Li,069 PSay "|"
			@ Li,072 PSay TRB->QTSEMAFAS Picture "999999"
			@ Li,078 PSay "|"

			If nQTIndRel < 1000
				@ Li,080 PSay nQTIndRel Picture "@E 9999.9999"
			Else
				@ Li,079 PSay nQTIndRel Picture "@E 99999.9999"
			Endif

			@ Li,089 PSay "|"
			@ Li,091 PSay TRB->QTDIHOPERD Picture "@E 9999.9999"
			@ Li,100 PSay "|"

			If nQTFreq < 10000
				@ Li,102 PSay nQTFreq Picture "@E 9999.9999"
			Else
				@ Li,101 PSay nQTFreq Picture "@E 99999.9999"
			Endif

			@ Li,111 PSay "|"
			@ Li,113 PSay TRB->QTOBITO Picture "99999"
			@ Li,120 PSay "|"

			If lCalcTaxa
				@ Li,122 PSay nQTTxGrav Picture "@E 99999999"
			Else
				If nQTIndGra < 1000
					@ Li,122 PSay nQTIndGra Picture "@E 999.9999"
				Else
					@ Li,121 PSay nQTIndGra Picture "@E 99999.9999"
				Endif
			Endif

			@ Li,131 PSay "|"

			SomaLinha()
			If !lPRINT
			@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
			Endif
			DbSelectArea("TRB")
			DbSkip()
		End

		If lFlag

			Somalinha()
			@ Li,000 PSay "|"
			If ( nQtTotEmp - Int(nQtTotEmp) ) == 0
				@ Li,001 PSay STR0013 + " (" + Alltrim(Str(nQtTotEmp,10)) + ")" //"Total do Estabelecimento"
			Else
				@ Li,001 PSay STR0013 + " (" + Alltrim( TransForm(nQtTotEmp,"@E 999,999.9") ) + ")"//"Total do Estabelecimento"
			Endif
			@ Li,042 PSay "|"
			@ Li,045 PSay nQtTotVit Picture "999999"
			@ Li,051 PSay "|"
			@ Li,054 PSay nTInf15d Picture "999999"
			@ Li,060 PSay "|"
			@ Li,063 PSay nTSup15d Picture "999999"
			@ Li,069 PSay "|"
			@ Li,072 PSay nTSemAfast Picture "999999"
			@ Li,078 PSay "|"

			If nTIndRel < 1000
				@ Li,080 PSay nTIndRel Picture "@E 9999.9999"
			Else
				@ Li,079 PSay nTIndRel Picture "@E 99999.9999"
			Endif

			@ Li,089 PSay "|"
			@ Li,091 PSay nTDiHoPerd Picture "@E 9999.9999"
			@ Li,100 PSay "|"

			If nTFreq < 10000
				@ Li,102 PSay nTFreq Picture "@E 9999.9999"
			Else
				@ Li,101 PSay nTFreq Picture "@E 99999.9999"
			Endif

			@ Li,111 PSay "|"
			@ Li,113 PSay nTObito Picture "99999"
			@ Li,120 PSay "|"

			If lCalcTaxa
				@ Li,122 PSay nTTxGrav Picture "@E 99999999"
			Else
				If nTIndGra < 10000
					@ Li,122 PSay nTIndGra Picture "@E 999.9999"
				Else
					@ Li,121 PSay nTIndGra Picture "@E 99999.9999"
				Endif
			Endif

			@ Li,131 PSay "|"        /////////////////

			SomaLinha()
			If !lPRINT
			@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
			Endif
			MDT865QUAD()
		Endif	//lFlag

		If TRB->(RecCount()) == 0

			If lMdtps

				dbSelectArea(cAliasCC)
				dbSetOrder(1)
				dbSeek(xFilial(cAliasCC,cFilAtual))
				While !eof() .And. xFilial(cAliasCC,cFilAtual) == &(cFiliaCC )

					If cCodCli <> SubSTR(&(cCodigCC),1,nTa1)

						cCodCli := SubSTR(&(cCodigCC),1,nTa1)

						SomaLinha()
						@ Li,000 PSay " "

						SomaLinha()
						@ Li,001 PSay Replicate("_",130)
						Somalinha()
						@ Li,000 PSay "|"
						@ Li,131 PSay "|"

						SomaLinha()
						@ Li,000 PSay STR0007 //"|ACIDENTES C/VITIMA_______________________________________________  PERIODO DE"         "ATE"    "DATA DO MAPA:            |"
						@ Li,078 PSay Alltrim(DtoC(Mv_par01))
						@ Li,089 PSay STR0040//"ATE"
						@ Li,093 PSay Alltrim(DtoC(Mv_par02))
						If Empty(Mv_par06)
							@ Li,105 PSay STR0041//"DATA DO MAPA: __/__/___  |"
						Else
							@ Li,105 PSay STR0042//"DATA DO MAPA:            |"
							@ Li,118 PSay Alltrim(DtoC(Mv_par06))
							@ Li,131 PSay "|"
						EndIf
						@ Li,106 PSay STR0041//"DATA DO MAPA: ___/__/___ |"

						Somalinha()
						@ Li,000 PSay "|"
						@ Li,131 PSay "|"

						Somalinha()
						If Empty(mv_par05)
							@ Li,000 PSay STR0008 //"|RESPONSAVEL:________________________________________________              ASS:____________________________________|"
						Else
							@ Li,000 PSay STR0021 //"|RESPONSAVEL:"
							@ Li,015 PSay SubStr( NGSEEK("TMK",mv_par05,1,"TMK->TMK_NOMUSU"),1,47 )
							@ Li,091 PSay STR0022 //"ASS:____________________________________|"
						Endif

						SomaLinha()
						@ Li,000 PSay "|"
						@ Li,001 PSay Replicate("_",130)
						@ Li,131 PSay "|"

						fCabR865()

						Somalinha()
						@ Li,000 PSay "|"
						@ Li,042 PSay "|"
						@ Li,051 PSay "|"
						@ Li,060 PSay "|"
						@ Li,069 PSay "|"
						@ Li,078 PSay "|"
						@ Li,089 PSay "|"
						@ Li,100 PSay "|"
						@ Li,111 PSay "|"
						@ Li,120 PSay "|"
						@ Li,131 PSay "|"

						SomaLinha()
						If !lPRINT
						@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
						EndIf
						Somalinha()
						@ Li,000 PSay "|"
						If ( nQtTotEmp - Int(nQtTotEmp) ) == 0
							@ Li,001 PSay STR0013 + " (" + Alltrim(Str(nQtTotEmp,10)) + ")" //"Total do Estabelecimento"
						Else
							@ Li,001 PSay STR0013 + " (" + Alltrim( TransForm(nQtTotEmp,"@E 999,999.9") ) + ")"//"Total do Estabelecimento"
						Endif
						@ Li,042 PSay "|"
						@ Li,051 PSay "|"
						@ Li,060 PSay "|"
						@ Li,069 PSay "|"
						@ Li,078 PSay "|"
						@ Li,089 PSay "|"
						@ Li,100 PSay "|"
						@ Li,111 PSay "|"
						@ Li,120 PSay "|"
						@ Li,131 PSay "|"

						SomaLinha()
						If !lPRINT
						@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
						Endif
						MDT865QUAD()
					Endif

					dbSelectArea(cAliasCC)
					dbSkip()
				End

			Else

				SomaLinha()
				@ Li,000 PSay " "

				SomaLinha()
				@ Li,001 PSay Replicate("_",130)
				Somalinha()
				@ Li,000 PSay "|"
				@ Li,131 PSay "|"

				SomaLinha()
				@ Li,000 PSay STR0007 //"|ACIDENTES C/VITIMA_______________________________________________  PERIODO DE"         "ATE"    "DATA DO MAPA:            |"
				@ Li,078 PSay Alltrim(DtoC(Mv_par01))
				@ Li,089 PSay STR0040//"ATE"
				@ Li,093 PSay Alltrim(DtoC(Mv_par02))
				If Empty(Mv_par06)
					@ Li,105 PSay STR0041//"DATA DO MAPA: __/__/___  |"
				Else
					@ Li,105 PSay STR0042//"DATA DO MAPA:            |"
					@ Li,118 PSay Alltrim(DtoC(Mv_par06))
					@ Li,131 PSay "|"
				EndIf

				Somalinha()
				@ Li,000 PSay "|"
				@ Li,131 PSay "|"

				Somalinha()
				If Empty(mv_par05)
					@ Li,000 PSay STR0008 //"|RESPONSAVEL:________________________________________________              ASS:____________________________________|"
				Else
					@ Li,000 PSay STR0021 //"|RESPONSAVEL:"
					@ Li,015 PSay SubStr( NGSEEK("TMK",mv_par05,1,"TMK->TMK_NOMUSU"),1,47 )
					@ Li,091 PSay STR0022 //"ASS:____________________________________|"
				Endif

				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,001 PSay Replicate("_",130)
				@ Li,131 PSay "|"

				fCabR865()

				Somalinha()
				@ Li,000 PSay "|"
				@ Li,042 PSay "|"
				@ Li,051 PSay "|"
				@ Li,060 PSay "|"
				@ Li,069 PSay "|"
				@ Li,078 PSay "|"
				@ Li,089 PSay "|"
				@ Li,100 PSay "|"
				@ Li,111 PSay "|"
				@ Li,120 PSay "|"
				@ Li,131 PSay "|"

				SomaLinha()
				If !lPRINT
				@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
				EndIf
				Somalinha()
				@ Li,000 PSay "|"
				If ( nQtTotEmp - Int(nQtTotEmp) ) == 0
					@ Li,001 PSay STR0013 + " (" + Alltrim(Str(nQtTotEmp,10)) + ")" //"Total do Estabelecimento"
				Else
					@ Li,001 PSay STR0013 + " (" + Alltrim( TransForm(nQtTotEmp,"@E 999,999.9") ) + ")"//"Total do Estabelecimento"
				Endif
				@ Li,042 PSay "|"
				@ Li,051 PSay "|"
				@ Li,060 PSay "|"
				@ Li,069 PSay "|"
				@ Li,078 PSay "|"
				@ Li,089 PSay "|"
				@ Li,100 PSay "|"
				@ Li,111 PSay "|"
				@ Li,120 PSay "|"
				@ Li,131 PSay "|"

				SomaLinha()
				If !lPRINT
				@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
				Endif
				MDT865QUAD()

			Endif

		Else

			If lMdtps

				dbSelectArea(cAliasCC)
				dbSetOrder(1)
				dbSeek(xFilial(cAliasCC,cFilAtual))
				While !eof() .And. xFilial(cAliasCC,cFilAtual) == &(cFiliaCC )

					If cCodCli <> SubSTR(&(cCodigCC),1,nTa1)

						cCodCli := SubSTR(&(cCodigCC),1,nTa1)

						dbSelectArea("TRB")
						If !dbSeek(cCodCli)

							SomaLinha()
							@ Li,000 PSay " "

							SomaLinha()
							@ Li,001 PSay Replicate("_",130)
							Somalinha()
							@ Li,000 PSay "|"
							@ Li,132 PSay "|"

							SomaLinha()
							@ Li,000 PSay STR0007 //"|ACIDENTES C/VITIMA_______________________________________________  PERIODO DE"         "ATE"    "DATA DO MAPA:            |"
							@ Li,078 PSay Alltrim(DtoC(Mv_par01))
							@ Li,089 PSay STR0040//"ATE"
							@ Li,093 PSay Alltrim(DtoC(Mv_par02))
							If Empty(Mv_par06)
								@ Li,105 PSay STR0041//"DATA DO MAPA: __/__/___  |"
							Else
								@ Li,105 PSay STR0042//"DATA DO MAPA:"
								@ Li,118 PSay Alltrim(DtoC(Mv_par06))
								@ Li,131 PSay "|"
							EndIf

							Somalinha()
							@ Li,000 PSay "|"
							@ Li,132 PSay "|"

							Somalinha()
							If Empty(mv_par05)
								@ Li,000 PSay STR0008 //"|RESPONSAVEL:________________________________________________              ASS:____________________________________|"
							Else
								@ Li,000 PSay STR0021 //"|RESPONSAVEL:"
								@ Li,015 PSay SubStr( NGSEEK("TMK",mv_par05,1,"TMK->TMK_NOMUSU"),1,47 )
								@ Li,091 PSay STR0022 //"ASS:____________________________________|"
							Endif

							SomaLinha()
							@ Li,000 PSay "|"
							@ Li,001 PSay Replicate("_",130)
							@ Li,131 PSay "|"

							fCabR865()

							nQTIndRel  := 0
							nQTFreq    := 0
							nQTIndGra  := 0
							nQTTxGrav  := 0

							//Acumula Para o Total do Estabelecimento
							nTSup15d   := 0
							nTInf15d   := 0
							nTDiHoPerd := 0
							nTSemAfast := 0
							nTObito    := 0
							nTIndRel   := 0
							nTFreq     := 0
							nTIndGra   := 0
							nTTxGrav   := 0

							Somalinha()
							@ Li,000 PSay "|"
							@ Li,042 PSay "|"
							@ Li,051 PSay "|"
							@ Li,060 PSay "|"
							@ Li,069 PSay "|"
							@ Li,078 PSay "|"
							@ Li,089 PSay "|"
							@ Li,100 PSay "|"
							@ Li,111 PSay "|"
							@ Li,120 PSay "|"
							@ Li,131 PSay "|"

							SomaLinha()
							If !lPRINT
							@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
							EndIf
							Somalinha()
							@ Li,000 PSay "|"
							If ( nQtTotEmp - Int(nQtTotEmp) ) == 0
								@ Li,001 PSay STR0013 + " (" + Alltrim(Str(nQtTotEmp,10)) + ")" //"Total do Estabelecimento"
							Else
								@ Li,001 PSay STR0013 + " (" + Alltrim( TransForm(nQtTotEmp,"@E 999,999.9") ) + ")"//"Total do Estabelecimento"
							Endif
							@ Li,042 PSay "|"
							@ Li,051 PSay "|"
							@ Li,060 PSay "|"
							@ Li,069 PSay "|"
							@ Li,078 PSay "|"
							@ Li,089 PSay "|"
							@ Li,100 PSay "|"
							@ Li,111 PSay "|"
							@ Li,120 PSay "|"
							@ Li,131 PSay "|"

							SomaLinha()
							If !lPRINT
							@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
							Endif
							MDT865QUAD()
						Endif
					Endif

					dbSelectArea(cAliasCC)
					dbSkip()
				End

			Endif

		Endif
	Endif

Return .T.

//Monta os Cabecalhos
/*
          1         2         3         4         5         6         7         8         9         0         1        12        13
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
 __________________________________________________________________________________________________________________________________
|				                                                                                                                   |
|ACIDENTES C/VITIMA______________________________________________  PERIODO DE 00/00/0000 ATE 00/00/0000  DATA DO MAPA: ___/__/___  |
|																						        		  	  	                   |
|RESPONSAVEL:________________________________________________                              ASS:____________________________________|
|__________________________________________________________________________________________________________________________________|
|                  Setor                  | Numero |Afastam.|Afastam.|  Sem   |  Indice  |  Dias/   |   Taxa   | Obitos |  Indice  |
|                                         |Absoluto|Menor ou| Maior  |Afastam.| Relativo |  Homem   |    de    |        | de Aval. |
|                                         |        |Igual a | Que 15 |        | Total de | Perdidos | Frequen. |        |    da    |
|                                         |        |   15   |        |        | Emprega. |          |          |        | Gravida. |
|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|
|			                		      |99999999|99999999|99999999|99999999|99999.9999|99999.9999|22222.9099|33333333|33333.0099|
|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|
|			                			  | 9999999| 9999999| 9999999| 9999999| 999999999| 9999999  | 3333.0099| 2222111| 2222.0099|
|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|
|						                  | 999999 | 999999 | 999999 | 999999 | 999999 99| 999999   | 333.00   | 222211 | 222.0099 |
|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|
|Total do Estabelecimento                 |        |        |        |        |          |          |          |        |          |
|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|
*/

//---------------------------------------------------------------------
/*/{Protheus.doc} mdt865conv
Converte de horas para decimal(para utilizar em calculos)

@param cHora, Caracter, Hora a ser convertida

@sample U_mdt865conv( "20:30" )

@author Denis Hyroshi de Souza
@since 03/06/2002

@return Valor convertido ou zero
/*/
//---------------------------------------------------------------------
User Function mdt865conv(cHora)

	Local nHora, nMin, nPonto
	If (nPonto := AT(":",cHora)) > 0
		nHora := val(substr(cHora,1,nPonto-1))
		nMin  := val(substr(cHora,nPonto+1))
		Return nHora + ((nMin * (10/6))/100)
	Endif

Return 0

//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Incrementa Linha e Controla Salto de Pagina

@sample SomaLinha( )

@author Denis Hyroshi de Souza
@since 03/06/2002

@return
/*/
//---------------------------------------------------------------------
Static Function Somalinha()

    Li++
    If Li > 58

  		 //Caso seja uma nova página, finaliza a página.
  		 If m_pag > 1
  		 	@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
  		 EndIf

        lPRINT := .T.
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} mdt865conv
Buscar quqantidade de horas trabalhada pelo funcionario no ano.

@param cFil_Mat, Caracter, Filial + Matrícula
@param cVerbas, Caracter, Verbas
@param dPerIni, Data, Data Inicial
@param dPerFim, Data, Data Final
@param nHrsMes, Caracter, Horas trabaladas ao mês

@author Denis Hyroshi de Souza
@since 12/05/2005

@return nQtd, Numérico, Indica a quantidade de horas trabalhadas.
/*/
//---------------------------------------------------------------------
User Function MDT865HrsF(cFil_Mat,cVerbas,dPerIni,dPerFim,nHrsMes)

	Local cAnoMesIni := MesAno(dPerIni)
	Local cAnoMesFim := MesAno(dPerFim)
	Local nQtd	 := 0
	Local nHoras := 0

	dbSelectArea("SRD")
	dbSetOrder(1)
	dbSeek(cFil_Mat+cAnoMesIni,.T.)
	While !Eof() .And. cFil_Mat == SRD->RD_FILIAL+SRD->RD_MAT .And.;
		SRD->RD_DATARQ >= cAnoMesIni .And. SRD->RD_DATARQ <= cAnoMesFim

		If SRD->RD_PD $ cVerbas
			nMultiplic := 1
			If SRD->RD_TIPO1 == "D"
				nMultiplic := nHrsMes/30
			Endif
			nHoras := SRD->RD_HORAS * nMultiplic
			If NGSEEK("SRV",SRD->RD_PD,1, "RV_TIPOCOD") $ "13"
				nQtd += nHoras
			Elseif NGSEEK("SRV",SRD->RD_PD,1, "RV_TIPOCOD") == "2"// PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_TIPOCOD") == "2"
				nQtd -= nHoras
			Endif
		Endif

		dbSelectArea("SRD")
		dbSkip()
	End

Return nQtd

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT865QUAD
Imprime o quadro com dados da empresa

@sample MDT865QUAD( )

@author Andre E.Perez Alvarez
@since 19/10/2005

@return Valor convertido ou zero
/*/
//---------------------------------------------------------------------
Static Function MDT865QUAD()

	If lSigaMdtps .Or. lMdtps // se a empresa for prestadora de serviços
		dbSelectArea("SA1")
		dbSetOrder(01)
		dbSeek(xFilial("SA1",cFilAtual) + cCodCli)
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
		cNome := SM0->M0_NOMECOM
		cEndereco := SM0->M0_ENDCOB
		cCidade := SM0->M0_CIDCOB
		cTelefone := SM0->M0_TEL
	EndIf

	Somalinha()
	@ Li,000 PSay "|"
	@ Li,001 PSay STR0025 //"DADOS DA EMPRESA"
	@ Li,131 PSay "|"

	Somalinha()
	@ Li,000 PSay "|"
	@ Li,131 PSay "|"

	Somalinha()
	@ Li,000 PSay "|"
	@ Li,001 PSay STR0026 + AllTrim(cNome) //"EMPRESA.: "
	@ Li,131 PSay "|"
	Somalinha()
	@ Li,000 PSay "|"
	@ Li,001 PSay STR0027 + AllTrim(cCidade) //"CIDADE..: "
	@ Li,080 PSay STR0029 + AllTrim(cTelefone) //"TELEFONE: "
	@ Li,131 PSay "|"

	Somalinha()
	@ Li,000 PSay "|"
	@ Li,001 PSay STR0028 + AllTrim(cEndereco) //"ENDERECO: "
	@ Li,131 PSay "|"

	SomaLinha()
	@ Li,000 PSay "|"
	@ Li,001 PSay Replicate("_",130)
	@ Li,131 PSay "|"

	li := 60

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTCAGED
Imprime o quadro com dados da empresa

@sample MDTR780, MDTR825, MDTR865, MDTR868

@param Mv_DataIni - Data inicial.
@param Mv_DataFim - Data final.
@param lPesqFil - Controle de pesquisa.
@param lIncReg_ - Incrementa regua de progressão.
@param cFilAtu - Filial atual.
@param lCentroCusto - Pesquisa pelo centro de custo utilizado.
@param cCentroCusto - Centro de custo utilizado para a pesquisa.
@param lTotEmp - Calcula o total de funcionários da empresa.

@author Andre E.Perez Alvarez
@since 19/10/05

@return TpriDia - Quantidade de Funcionários.
/*/
//---------------------------------------------------------------------
User Function MDTCAGED(Mv_DataIni,Mv_DataFim,lPesqFil,lIncReg_,cFilAtu,lCentroCusto,cCentroCusto,lTotEmp)

	Local nQtHrsFun	:= 0
	Local nQtFunc		:= 0
	Local nX			:= 0
	Local aTransf		:= {}
	Local lPercCC		:= .F.
	Local lIntMDTGPE	:= Alltrim(GETMV("MV_MDTGPE")) == "S"
	Local lAmbPrest		:= Type( "lSigaMdtps" ) == "L" .And. lSigaMdtps
	Local lNg2iPon      := SuperGetMv( "MV_NG2IPON", .F., "2" ) == "1"

	Default lPesqFil 	:= .T.
	Default lIncReg_ 	:= .T.
	Default cFilAtu  	:= cFilAnt
	Default cCentroCusto := ""
	Default lCentroCusto := .F.
	Default lTotEmp		:= .F.

	Private TAdmi		:= 0
	Private TDemi		:= 0
	Private TpriDia	:= 0
	Private dDtIni	:= Mv_DataIni
	Private dDtRef	:= Mv_DataFim
	Private lAdmissao	:= .F.
	Private lDemissao	:= .F.

	If IsInCallStack( "MDTR865" )
		If Mv_par10 == 1 //Caso seja por setor
			nQtTotFunc :=0
		Else //Caso seja pelo total da empresa
			nQtTotFunc := nQtTotEmp
		Endif
	EndIf

	dbSelectArea("SRA")
	If lCentroCusto //Caso seja efetuado filtro por Setor
		dbSetOrder(2)//RA_FILIAL+RA_CC+RA_MAT
	Else
		dbSetOrder(1)//RA_FILIAL+RA_MAT
	Endif
	If lPesqFil
		If lCentroCusto //Caso tenha o filtro por Setor
			dbSeek(xFilial("SRA",cFilAtu)+cCentroCusto)
		Else
			dbSeek(xFilial("SRA",cFilAtu))
		EndIf
	Else
		If lCentroCusto//Caso utilize o filtro de Setor
			dbSeek(xFilial("SRA")+cCentroCusto)
		Else
			dbGoTop()
		Endif
	Endif

	While !SRA->(Eof()) .And. If(lPesqFil,SRA->RA_FILIAL == xFilial("SRA",cFilAtu),.T.)
		If lIncReg_
			Incregua()
		Else
			IncProc()
		Endif

		//-------------------------------------------------------------
		//| Filtra por Setor - Centro de Custo                        |
		//-------------------------------------------------------------
		If lCentroCusto //Caso tenha o filtro por centro de custo
			If cCentroCusto <> SRA->RA_CC //Caso seja de centro de custo diferente
				SRA->(dbSkip())
				Loop
			Endif
		Endif

		//-------------------------------------------------------------
		//| Desconsidera Funcion rios Diretores                       |
		//-------------------------------------------------------------
		IF SRA->RA_VIEMRAI == "80" .And. SRA->RA_TIPOADM $ "1A*1B*1C"
			SRA->(dbSkip())
			Loop
		Endif

		//-------------------------------------------------------------
		//| Desconsidera Autonomo,Pro-labore,Estagiario               |
		//-------------------------------------------------------------
		IF SRA->RA_CATFUNC $ "A,E,P,G"
			SRA->(dbSkip())
			Loop
		EndIF

		//Desconsidera funcionários demitidos antes do período do relatório
		If !(( SRA->RA_ADMISSA <= dDtRef .And. Empty(SRA->RA_DEMISSA) ) .Or.;
			( !Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA >= dDtIni ))
			SRA->(dbSkip())
			Loop
		EndIf

		If lIntMDTGPE//Quando a integração com o GPE estiver habilitada

			//-----------------------------------------------------------------------------------
			//| Caso o funcionário seja transferido verifica se a data de transferencia			|
			//| está dentro do periodo de impressão. Se estiver o funcionário entra na contagem,|
			//| pois mesmo que por pouco tempo ele estava presente na Empresa ou Setor. 			|
			//-----------------------------------------------------------------------------------
			lPercCC := .F.
			aTransf := MDT180HFUN( , , , , , , , , .T. )//Verifica a transferencia
			If Len( aTransf ) > 0 //Caso tenha ocorrido uma transferencia
				For nX := 1 To Len( aTransf )
					If (If(lCentroCusto,aTransf[ nX , 7 ] == cCentroCusto,.T.)) .And. ; //Varifica se a transferencia está dentro do periodo
						( aTransf[ nX , 4 ] <= dDtRef .And. aTransf[ nX , 5 ] >= dDtRef ) .Or.;
						( aTransf[ nX , 4 ] <= dDtRef .And. aTransf[ nX , 5 ] >= dDtIni .And. aTransf[ nX , 5 ] <= dDtRef ) .Or.;
						( aTransf[ nX , 4 ] <= dDtIni .And. aTransf[ nX , 4 ] <= dDtRef .And. aTransf[ nX , 5 ] <= dDtIni .And. aTransf[ nX , 5 ] <= dDtRef ) //Caso a transferência esteja fora do período.
						lPercCC := .T.
					EndIf
				Next nX
				If !lPercCC	//Caso funcionário seja transferido
					DbSelectArea("SRA")
					DbSkip()
					Loop
				EndIf
			EndIf

			//------------------------------------------------------------------------
			//| Verifica se esto funcionário estava afastado duraten todo o periodo. |
			//------------------------------------------------------------------------
			lTemSR8 := MDTChkSR8( "SR8" , 1 ,	xFilial("SR8",cFilAtu)+SRA->RA_MAT,;
					"xFilial('SR8','"+cFilAtu+"') == SR8->R8_FILIAL .And. SRA->RA_MAT == SR8->R8_MAT" ,;
																dDtIni ,;
																dDtRef )

			dbSelectArea("SRA")
			If lTemSR8 //Se estiver afastado
				DbSelectArea("SRA")
				DbSkip()
				Loop
			Endif

			If IsInCallStack( "MDTR865" ) .And. Mv_par10 == 1 .And. !lTotEmp
				nQtFunc += 1    //Total de Funcionarios no C.Custo
				nQtTotFunc += 1 //Total de Funcionarios na Empresa
			ElseIf lTotEmp
				TpriDia +=1
			EndIf
			If !lTotEmp
				If mv_par12 == 3 .And. lNg2iPon //Se integração com o SIGAPON
					nQtHrsFun += fPegaHrs( dDtIni, dDtRef )
				Else
					//Total de horas trabalhadas pelo funcionario
					If lAmbPrest .Or. mv_par12 == 1
						nQtHrsFun += ((dDtRef - DdtIni) + 1) * (SRA->RA_HRSMES / 30)
					EndIf
					//Acrescenta as horas extras e subtrai as faltas
					nQtHrsFun += U_MDT865HrsF(SRA->RA_FILIAL+SRA->RA_MAT,cVerbas,dDtIni,dDtRef,SRA->RA_HRSMES)
				EndIf
			Endif

		Else

			If IsInCallStack( "MDTR865" ) .And. Mv_par10 == 1 .And. !lTotEmp
				nQtFunc += 1    //Total de Funcionarios no C.Custo
				nQtTotFunc += 1 //Total de Funcionarios na Empresa
			ElseIf lTotEmp
				TpriDia +=1
			EndIf

		Endif

		//Pula para o próximo registro
		dbSelectArea("SRA")
		dbSkip()

	End

	If !lTotEmp
		If !lIntMDTGPE
			nQtHrsTrab := nQtTotEmp * nDiUteis  * nJornada
			If lSigaMdtps
				nQtHrsFun  := nQtFunc * nDiUteis  * nJornada
			Else
				nQtHrsFun  := nQtTotFunc * nDiUteis  * nJornada
				nQtFunc    := nQtTotFunc
			Endif
		Else
			nQtHrsTrab += nQtHrsFun
			nQtFunc    := nQtTotFunc
		Endif
		If nQtFunc > 0
			DbSelectArea("TRB")
			If DbSeek(cCentroCusto)
				RecLock('TRB',.F.)
				If lSigaMdtps
					TRB->QTFUNC := nQtFunc
				Else
					TRB->QTFUNC := nQtTotFunc
				Endif
				TRB->QTHRHOMENS := nQtHrsFun
				MsUnlock('TRB')
			Endif
		EndIF
	EndIf

Return (TpriDia)

//---------------------------------------------------------------------
/*/{Protheus.doc} _IMPRIRESUMO
Imprime o Resumo dos Acidentes Com Vitimas

@sample _IMPRIRESUMO( )

@author Andre E. Perez Alvarez
@since 29/02/2008

@return Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function _IMPRIRESUMO()

	cCodCli := ""

	dbSelectArea(cAliasCC)
	dbSetOrder(1)
	dbSeek(xFilial(cAliasCC,cFilAtual)+mv_par01+mv_par02,.T.)
	While !eof() .And. xFilial(cAliasCC,cFilAtual) == &(cFiliaCC ) .And. SubStr(&(cCodigCC),1,nSizeTD) <= mv_par03+mv_par04

		If cCodCli <> SubSTR(&(cCodigCC),1,nSizeTD)

			cCodCli := SubSTR(&(cCodigCC),1,nSizeTD)

			dbSelectArea("TRB")
			If !dbSeek(cCodCli)
				SomaLinha()
				@ Li,000 PSay " "

				SomaLinha()
				@ Li,001 PSay Replicate("_",130)
				Somalinha()
				@ Li,000 PSay "|"
				@ Li,131 PSay "|"

				SomaLinha()
				@ Li,000 PSay STR0007 //"|ACIDENTES C/VITIMA_______________________________________________  PERIODO DE"         "ATE"    "DATA DO MAPA:            |"
				@ Li,078 PSay Alltrim(DtoC(Mv_par05))
				@ Li,089 PSay STR0040//"ATE"
				@ Li,093 PSay Alltrim(DtoC(Mv_par06))
				If Empty(Mv_par10)
					@ Li,105 PSay STR0041//"DATA DO MAPA: __/__/___  |"
				Else
					@ Li,105 PSay STR0042//"DATA DO MAPA:"
					@ Li,118 PSay Alltrim(DtoC(Mv_par10))
					@ Li,131 PSay "|"
				EndIf

				Somalinha()
				@ Li,000 PSay "|"
				@ Li,131 PSay "|"

				Somalinha()
				If Empty(mv_par09)
					@ Li,000 PSay STR0008 //"|RESPONSAVEL:________________________________________________              ASS:____________________________________|"
				Else
					@ Li,000 PSay STR0021 //"|RESPONSAVEL:"
					@ Li,015 PSay SubStr( NGSEEK("TMK",mv_par09,1,"TMK->TMK_NOMUSU"),1,47 )
					@ Li,091 PSay STR0022 //"ASS:____________________________________|"
				Endif

				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,001 PSay Replicate("_",130)
				@ Li,131 PSay "|"

				fCabR865()

				Somalinha()
				@ Li,000 PSay "|"
				@ Li,042 PSay "|"
				@ Li,051 PSay "|"
				@ Li,060 PSay "|"
				@ Li,069 PSay "|"
				@ Li,078 PSay "|"
				@ Li,089 PSay "|"
				@ Li,100 PSay "|"
				@ Li,111 PSay "|"
				@ Li,120 PSay "|"
				@ Li,131 PSay "|"

				SomaLinha()
				If !lPRINT
				@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
				Endif
				Somalinha()
				@ Li,000 PSay "|"
				If ( nQtTotEmp - Int(nQtTotEmp) ) == 0
					@ Li,001 PSay STR0013 + " (" + Alltrim(Str(nQtTotEmp,10)) + ")" //"Total do Estabelecimento"
				Else
					@ Li,001 PSay STR0013 + " (" + Alltrim( TransForm(nQtTotEmp,"@E 999,999.9") ) + ")"//"Total do Estabelecimento"
				Endif
				@ Li,042 PSay "|"
				@ Li,051 PSay "|"
				@ Li,060 PSay "|"
				@ Li,069 PSay "|"
				@ Li,078 PSay "|"
				@ Li,089 PSay "|"
				@ Li,100 PSay "|"
				@ Li,111 PSay "|"
				@ Li,120 PSay "|"
				@ Li,131 PSay "|"

				SomaLinha()
				If !lPRINT
				@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"
				Endif
				MDT865QUAD()
			Endif
		Endif

		dbSelectArea(cAliasCC)
		dbSkip()
	End

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fCabR865
Imprime cabeçalho

@sample fCabR865( )

@author Andre E. Perez Alvarez
@since 29/02/2008

@return Nil
/*/
//---------------------------------------------------------------------
Static Function fCabR865()

	Local nX
	Local cDiasTotAf := cValToChar( SuperGetMv( "MV_NG2TOAF" , .F. , 15 ) )
	Local aCabec := If( lCalcTaxa ,	{ STR0036 , STR0037 , STR0038 + cDiasTotAf + STR0043 , STR0039 + cDiasTotAf + STR0044 },;
													{ STR0009 , STR0010 , STR0011 +cDiasTotAf+STR0045, STR0012 + cDiasTotAf + STR0046 } )
		//STR0036				//"|                  Setor                  | Numero |Afastam.|Afastam.|  Sem   |  Indice  |  Dias/   |   Taxa   | Obitos |   Taxa   |"
		//STR0037				//"|                                         |Absoluto|Menor ou| Maior  |Afastam.| Relativo |  Homem   |    de    |        |    de    |"
		//STR0038+STR0043		//"|                                         |        |Igual a | Que "" |        | Total de | Perdidos | Frequen. |        |Gravidade |"
		//STR0039+STR0044		//"|                                         |        |   ""   |        |        | Emprega. |          |          |        |          |"
		//STR0009				//"|                  Setor                  | Numero |Afastam.|Afastam.|  Sem   |  Indice  |  Dias/   |   Taxa   | Obitos |  Indice  |"
		//STR0010				//"|                                         |Absoluto|Menor ou| Maior  |Afastam.| Relativo |  Homem   |    de    |        | de Aval. |"
		//STR0011+STR0045		//"|                                         |        |Igual a | Que "" |        | Total de | Perdidos | Frequen. |        |    da    |"
		//STR0012+STR0046		//"|                                         |        |   ""   |        |        | Emprega. |          |          |        | Gravida. |"
	For nX := 1 To Len( aCabec )
		Somalinha()
		@ Li , 000 PSay aCabec[ nX ]
	Next nX

	Somalinha()
	@ Li,000 PSay "|_________________________________________|________|________|________|________|__________|__________|__________|________|__________|"

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fPegaHrs
Retorna as horas trabalhadas pelo funcionário de acordo com o SIGAPON
@type    function
@author  Julia Kondlatsch
@since   27/02/2019
@sample  fPegaHrs( 01/01/2019, 20/02/2019 )

@param   dPerIni, Data, Início do período
@param   dPerFim, Data, Fim do período

@return  nHrs, Numérico, Horas de trabalho apontadas pelo funcionário
no período informado por parâmetro
/*/
//-------------------------------------------------------------------
Static Function fPegaHrs( dPerIni, dPerFim )

	Local aPonto := GetLastApo( dPerIni, dPerFim , "SPC" )
	Local nHrs   := 0

	aEval( aPonto, { | aPonto | nHrs += aPonto[ 3 ] } )

Return nHrs

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR865P12
Valida a pergunta 12 do relatório

@type    function
@author  Julia Kondlatsch
@since   27/02/2019
@sample  U_MDTR865P12()
@return  lRet, Lógico, Verdadeiro se houver integração com o GPE ou a
opção selecionada seja diferente de 3
/*/
//-------------------------------------------------------------------
User Function MDTR865P12()

	Local lRet := .T.

	If mv_par12 == 3 .And. SuperGetMv( 'MV_NG2IPON', .F., '2' ) <> '1'
		lRet := .F.
		Help( Nil, Nil, STR0059, Nil, STR0060, 1, 0, NIL, NIL, NIL, NIL, NIL, {STR0061})
		//"Atenção" # "Esta Opção só está disponível para ambientes com integração com o módulo SIGAPON" #
		//"Escolha outra opção para este parâmetro"
	EndIf

Return lRet
