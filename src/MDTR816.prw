/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr816.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR816
Relatorio da projecao para manutencao de EPI's dos funcionarios.

@author  Marcio Costa
@since   12/01/2000
/*/
//-------------------------------------------------------------------
User Function MDTR816()
	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local oReport
	Local nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))

	Private cPerg    :="MDT816    "
	Private nSizeSA2, nSizeSI3, nSizeSRJ
	Private cDescrCC := "CTT->CTT_DESC01"
	Private cAliasCC := "CTT"

	nSizeSA2 := If((TAMSX3("A2_COD")[1]) < 1,6,(TAMSX3("A2_COD")[1]))
	nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))
	nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))

	If Alltrim(GETMV("MV_MCONTAB")) != "CTB"
		cDescrCC := "SI3->I3_DESC"
		cAliasCC := "SI3"
	Endif

	// Verifica as perguntas selecionadas
	If TRepInUse()
		// Interface de impressao
		MV_PAR09 := 1
		oReport := ReportDef()
		oReport:SetPortrait()
		oReport:PrintDialog()
	Else
		U_MDTR816_R3()
	Endif

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR816_R3
Chamada da tela de perguntas e do relatorio

@author  Inacio Luiz Kolling
@since   01/06/1997
/*/
//-------------------------------------------------------------------
User Function MDTR816_R3()
	Local wnrel   := "mdtr816"
	Local limite  := 132
	Local cDesc1  := STR0001 //"Relatório de projeção para higienização / manutenção dos EPI's. Através dos     "
	Local cDesc2  := STR0002 //"parâmetros, o usuário deve informar o período desejado para visualizar uma rela-"
	Local cDesc3  := STR0003 //"ção com os epi's de funcionários que devem sofrer uma manutenção.  "
	Local cString := "TNF"

	Private nomeprog := "MDTR816"
	Private tamanho  := "M"
	Private aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
	Private titulo   := STR0006 //"Higienização / Manutenção dos Equipamentos (EPI)"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cabec1, cabec2

	/* PERGUNTAS PADRÃO
	mv_par01             // De  EPI
	mv_par02             // Ate EPI
	mv_par03             // De  Data Manutencao
	mv_par04             // Ate Data Manutencao
	mv_par05             // De  Matricula
	mv_par06             // Ate Matricula
	mv_par07             // De  Centro de Custo
	mv_par08             // Ate Centro de Custo
	mv_par09             // Ordernar por ?(Funcionario)
										(Matricula)
										(Epi)
										(Centro de Custo)   */

	pergunte(cPerg,.F.) // Verifica as perguntas selecionadas

	// Envia controle para a funcao SETPRINT
	wnrel := "MDTR816"
	wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to
		Return
	Endif

	If MV_PAR09 == 4
		tamanho:="G"
	Else
		tamanho:="M"
	END

	RptStatus({|lEnd| r816Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} r816Imp
Impressao do relatorio padrao

@author  Inacio Luiz Kolling
@since   01/06/1997

@sample  r816Imp(@lEnd,wnRel,titulo,tamanho)

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caractere, Programa utilizado
@param   titulo, Caractere, Título do relatório
@param   tamanho, Caractere, Tamanho do relatório

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function r816Imp(lEnd,wnRel,titulo,tamanho)

	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local nInd, nDad
	Local nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))

	// Variaveis para controle do cursor de progressao do relatorio
	Local nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

	// Variaveis locais exclusivas deste programa
	Local cChave           := SPACE(16)
	Local lContinua        := .T.
	Local lImprime         := .T.
	Local nPerMan := 0

	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1
	Private dDTFIM := cTOD("  /  /  ")

	// Variaveis locais exclusivas deste programa
	Private  cFicAnt := SPACE(9)

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	/*/
	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                 <Proje‡ao para substitui‡ao dos EPI's>                           DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*

	1 - Funcionario
	************************************************************************************************************************************
			1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Nome Funcionário                     Matrícula   Centro de Custo                  Função                         Dt.Nasc.   Admissão
		EPI               Descrição                                  Dt.Entrega   Quantidade   Última Manutenção  Próxima Manutenção

	12345678901234567890123456789012345  123456      123456789012345678901234567890   123456789012345678901234567890 99/99/9999   99/99/9999
		123456789012345   1234567890123456789012345678901234567890   99/99/9999        xxxx,xx   99/99/9999           99/99/9999

	2 - Matricula
	============================================================================================************************************************************************************************************************************
			1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Matrícula   Nome Funcionário                     Centro de Custo                  Função                         Dt.Nasc.   Admissão
		EPI               Descrição                                  Dt.Entrega   Quantidade   Última Manutenção  Próxima Manutenção

	123456      12345678901234567890123456789012345  123456789012345678901234567890   123456789012345678901234567890 99/99/9999   99/99/9999
		123456789012345   1234567890123456789012345678901234567890   99/99/9999        xxxx,xx   99/99/9999           99/99/9999

	3 - EPI
	============================================================================================************************************************************************************************************************************
			1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	EPI               Descrição
		Funcionário                     Mat.    Centro de Custo       Função                Dt.Entrega   Qtdade.  Últ.Man.  Próx.Man.

	123456789012345   1234567890123456789012345678901234567890   99/99/9999        xxxx,xx
		123456789012345678901234567890  123456  12345678901234567890  12345678901234567890  99/99/9999     999,99   99/99/9999  99/99/9999

	4 - Centro de Custo
	============================================================================================************************************************************************************************************************************
			1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Centro de Custo        Descrição
		Funcionário                     Mat.    EPI              Descrição                  Dt.Entrega   Qtdade.  Últ.Man.  Próx.Man.

	123456789012345        1234567890123456789012345678901234567890   99/99/9999        xxxx,xx
		123456789012345678901234567890  123456  123456789012345  1234567890123456789012345  99/99/9999     999,99   99/99/9999  99/99/9999

	/*/

	Private aDados816 := {}
	Private nIndTNF := 2
	Private cCondicTNF := "TNF->TNF_MAT < MV_PAR05 .Or. TNF->TNF_MAT > MV_PAR06"
	Private cSeekTNF := xFilial("TNF")+MV_PAR01
	Private cWhileTNF := "TNF->TNF_CODEPI <= MV_PAR02"

	If Empty(Mv_par01) .And. !Empty(MV_PAR05) .And. !Empty(MV_PAR06)
		nIndTNF := 3
		cCondicTNF := "TNF->TNF_CODEPI < MV_PAR01 .Or. TNF->TNF_CODEPI > MV_PAR02"
		cSeekTNF := xFilial("TNF")+MV_PAR05
		cWhileTNF := "TNF->TNF_MAT <= MV_PAR06"
	Endif

	dbSelectArea("TNF")
	dbSetOrder(nIndTNF)
	dbSeek(cSeekTNF,.t.)
	SetRegua(LastRec())
	While !Eof() .And. xFilial("TNF") == TNF->TNF_FILIAL .And. &(cWhileTNF)

		IncRegua()

		If &(cCondicTNF)
			dbSelectArea("TNF")
			dbSkip()
			Loop
		Endif

		If TNF->TNF_INDDEV == "1"
			dbSelectArea("TNF")
			dbSkip()
			Loop
		Endif

		dbSelectArea("TN3")
		dbSetOrder(1)

		If DbSeek( xFilial("TN3")+TNF->(TNF_FORNEC+TNF_LOJA+TNF_CODEPI+TNF_NUMCAP))
			nPerMan := TN3->TN3_PERMAN
		Else //Se não estiver no cadastro de fornecedor de EPI, verifica se é um EPI filho
			dbSelectArea("TL0")
			dbSetOrder(2)

			If DbSeek( xFilial("TL0")+TNF->(TNF_CODEPI+TNF_FORNEC+TNF_LOJA+TNF_NUMCAP))
				dbSelectArea("TN3")
				dbSetOrder(2)
				If dbSeek( xFilial("TN3")+TL0->TL0_EPIGEN )
					nPerMan := TN3->TN3_PERMAN
				EndIf

			EndIf

		EndIf

		If nPerMan == 0
			dbSelectArea("TNF")
			dbSkip()
			Loop
		EndIf

		dDTFIM := TNF->TNF_DTMANU + nPerMan
		lNaoManut := .T.

		If Empty(TNF->TNF_DTMANU) .And. !Empty(TNF->TNF_DTENTR)

			For nInd := 1 To 3650
				dDTFIM := TNF->TNF_DTENTR + (nPerMan * nInd)

				If dDTFIM >= MV_PAR03 .And. dDTFIM <= MV_PAR04
					Exit
				ElseIf dDTFIM > MV_PAR04
					lNaoManut := .F.
					Exit
				Endif

			Next nInd

		Endif

		If dDTFIM > MV_PAR04 .Or. dDTFIM < MV_PAR03 .Or. !lNaoManut
			dbSelectArea("TNF")
			dbSkip()
			Loop
		Endif

		dbSelectArea("SRA")
		dbSetOrder(1)

		If !dbSeek(xFilial("SRA")+TNF->TNF_MAT) .Or. SRA->RA_SITFOLH == "D"
			dbSelectArea("TNF")
			dbSkip()
			Loop
		Endif

		If SRA->RA_CC < MV_PAR07 .Or. SRA->RA_CC > MV_PAR08
			dbSelectArea("TNF")
			dbSkip()
			Loop
		Endif

		dbSelectArea(cAliasCC)
		dbSetOrder(1)
		dbSeek(xFilial(cAliasCC)+SRA->RA_CC)

		dbSelectArea("SRJ")
		dbSetOrder(1)
		dbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)

		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek(xFilial("SB1")+TNF->TNF_CODEPI)

		nPosX := aScan( aDados816 ,{|x| x[1] + x[2] == TNF->TNF_MAT + TNF->TNF_CODEPI })

		If nPosX == 0
			aAdd( aDados816 , { TNF->TNF_MAT, TNF->TNF_CODEPI, TNF->TNF_DTENTR, dDTFIM, ;
								SRA->RA_NOME, SB1->B1_DESC, TNF->TNF_DTMANU, SRA->RA_CC,;
								&(cDescrCC), SRJ->RJ_DESC, SRA->RA_NASC , SRA->RA_ADMISSA,;
								TNF->TNF_QTDENT } )
								lImprime := .F. //Variavel de controle de impressão.
		ElseIf dDTFIM >	aDados816[nPosX,4]
			aDados816[nPosX,4] := dDTFIM
		Endif

		dbSelectArea("TNF")
		dbSkip()

	End

	If MV_PAR09 == 1 //Funcionario

		/*
				1         2         3         4         5         6         7         8         9         0         1         2         3
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		Nome Funcionário                     Matrícula   Centro de Custo                  Função                          Dt.Nasc.  Admissão
			EPI               Descrição                                  Dt.Entrega   Quantidade   Última Manutenção  Próxima Manutenção

		12345678901234567890123456789012345  123456      123456789012345678901234567890   123456789012345678901234567890  99/99/9999  99/99/9999
			123456789012345   1234567890123456789012345678901234567890   99/99/9999        xxxx,xx   99/99/9999           99/99/9999
		*/

		//Definindo Cabeçalho e Ordenando dados
		aSort(aDados816,,,{|x,y| x[5]+x[1]+x[6] < y[5]+y[1]+y[6] })
		cabec1 := STR0007 //"Nome Funcionário                     Matrícula   Centro de Custo                  Função                          Dt.Nasc.  Admissão"
		cabec2 := STR0008 //"     EPI               Descrição                                  Dt.Entrega   Quantidade   Última Manutenção  Próxima Manutenção"

		// Impressão dos dados
		cNomMat := " "

		For nDad := 1 to Len(aDados816)

			If cNomMat <> aDados816[nDad,5]+aDados816[nDad,1]
				Somalinha()

				If nDad != 1
					Somalinha()
				Endif

				@Li,000 Psay Substr(aDados816[nDad,5],1,35) //Nome
				@Li,036 Psay aDados816[nDad,1] //Matricula
				@Li,048 Psay Substr(aDados816[nDad,9],1,30) //Centro de Custo
				@Li,079 Psay Substr(aDados816[nDad,10],1,30) //Funcao
				@Li,110 Psay aDados816[nDad,11] Picture "99/99/9999" //Nascimento
				@Li,121 Psay aDados816[nDad,12] Picture "99/99/9999" //Admissao
				Somalinha()
			Endif

			cNomMat := aDados816[nDad,5]+aDados816[nDad,1]
			Somalinha()
			@Li,005 Psay aDados816[nDad,2] //EPI
			@Li,038 Psay Substr(aDados816[nDad,6],1,40) //Descricao
			@Li,081 Psay aDados816[nDad,3] //Data Entrega
			@Li,097 Psay aDados816[nDad,13] Picture "@E 9999.99" //Quantidade
			@Li,107 Psay aDados816[nDad,7]  Picture "99/99/9999" //Ultima Manutencao
			@Li,119 Psay aDados816[nDad,4]  Picture "99/99/9999" //Proxima Manutencao
		Next nDad

	ElseIf MV_PAR09 == 2 //Nome

		/*
				1         2         3         4         5         6         7         8         9         0         1         2         3
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		Matrícula   Nome Funcionário                     Centro de Custo                  Função                          Dt.Nasc.  Admissão
			EPI               Descrição                                  Dt.Entrega   Quantidade   Última Manutenção  Próxima Manutenção

		123456      12345678901234567890123456789012345  123456789012345678901234567890   123456789012345678901234567890  99/99/9999  99/99/9999
			123456789012345   1234567890123456789012345678901234567890   99/99/9999        xxxx,xx   99/99/9999           99/99/9999
		*/

		//Definindo Cabeçalho e Ordenando dados
		aSort(aDados816,,,{|x,y| x[1]+x[6] < y[1]+y[6] })
		cabec1 := STR0009 //"Matrícula   Nome Funcionário                     Centro de Custo                  Função                          Dt.Nasc.  Admissão"
		cabec2 := STR0008 //"     EPI               Descrição                                  Dt.Entrega   Quantidade   Última Manutenção  Próxima Manutenção"

		//Impressão dos dados
		cNomMat := " "

		For nDad := 1 to Len(aDados816)

			If cNomMat <> aDados816[nDad,1]
				Somalinha()

				If nDad != 1
					Somalinha()
				EndIf

				@Li,000 Psay aDados816[nDad,1] //Matricula
				@Li,012 Psay Substr(aDados816[nDad,5],1,35) //Nome
				@Li,048 Psay Substr(aDados816[nDad,9],1,30) //Centro de Custo
				@Li,079 Psay Substr(aDados816[nDad,10],1,30) //Funcao
				@Li,110 Psay aDados816[nDad,11] Picture "99/99/9999" //Nascimento
				@Li,121 Psay aDados816[nDad,12] Picture "99/99/9999" //Admissao
				Somalinha()
			EndIf

			cNomMat := aDados816[nDad,1]
			Somalinha()
			@Li,005 Psay aDados816[nDad,2] //EPI
			@Li,038 Psay Substr(aDados816[nDad,6],1,40) //Descricao
			@Li,081 Psay aDados816[nDad,3] //Data Entrega
			@Li,097 Psay aDados816[nDad,13] Picture "@E 9999.99" //Quantidade
			@Li,107 Psay aDados816[nDad,7] Picture "99/99/9999" //Ultima Manutencao
			@Li,119 Psay aDados816[nDad,4] Picture "99/99/9999" //Proxima Manutencao
		Next nDad

	ElseIf MV_PAR09 == 3 //EPI

		/*
				1         2         3         4         5         6         7         8         9         0         1         2         3
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		EPI               Descrição
			Funcionário                     Mat.    Centro de Custo       Função                Dt.Entrega   Qtdade.  Últ.Man.  Próx.Man.

		123456789012345   1234567890123456789012345678901234567890   99/99/9999        xxxx,xx
			123456789012345678901234567890  123456  12345678901234567890  12345678901234567890  99/99/9999     999,99   99/99/9999  99/99/9999
		*/

		//Definindo Cabeçalho e Ordenando dados
		aSort(aDados816,,,{|x,y| x[6]+x[5] < y[6]+y[5] })
		cabec1 := STR0010 //"EPI               Descrição"
		cabec2 := STR0011 //"     Funcionário                     Mat.    Centro de Custo       Função                Dt.Entrega   Qtdade.  Últ.Man.  Próx.Man."

		//Impressão dos dados
		cNomMat := " "
		For nDad := 1 to Len(aDados816)

			If cNomMat <> aDados816[nDad,6]+aDados816[nDad,2]
				Somalinha()

				If nDad != 1
					Somalinha()
				EndIf

				@Li,000 Psay aDados816[nDad,2] //EPI
				@Li,033 Psay aDados816[nDad,6] //Descricao
				Somalinha()
			EndIf
			cNomMat := aDados816[nDad,6]+aDados816[nDad,2]
			Somalinha()
			@Li,005 Psay Substr(aDados816[nDad,5],1,35) //Nome
			@Li,037 Psay aDados816[nDad,1] //Matricula
			@Li,045 Psay Substr(aDados816[nDad,9],1,20) //Centro de Custo
			@Li,067 Psay Substr(aDados816[nDad,10],1,20) //Funcao
			@Li,089 Psay aDados816[nDad,3] Picture "99/99/9999" //Data Entrega
			@Li,101 Psay aDados816[nDad,13] Picture "@E 9999.99" //Quantidade
			@Li,111 Psay aDados816[nDad,7] Picture "99/99/9999" //Ultima Manutencao
			@Li,121 Psay aDados816[nDad,4] Picture "99/99/9999" //Proxima Manutencao
		Next nDad

	ElseIf MV_PAR09 == 4 //Centro de Custo

		/*
				1         2         3         4         5         6         7         8         9         0         1         2         3
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		Centro de Custo        Descrição
			Funcionário                     Mat.    EPI              Descrição                  Dt.Entrega   Qtdade.  Últ.Man.  Próx.Man.

		12345678901234567890   1234567890123456789012345678901234567890   99/99/9999        xxxx,xx
			123456789012345678901234567890  123456  123456789012345  1234567890123456789012345  99/99/9999     999,99   99/99/9999  99/99/9999
		*/

		//Definindo Cabeçalho e Ordenando dados
		aSort(aDados816,,,{|x,y| x[9]+x[8]+x[5] < y[9]+y[8]+y[5] })
		cabec1 := STR0012 //"Centro de Custo        Descrição"
		cabec2 := STR0013 //"     Funcionário                     Mat.    EPI              Descrição                  Dt.Entrega   Qtdade.  Últ.Man.  Próx.Man."

		// Impressão dos dados
		cNomMat := " "

		For nDad := 1 to Len(aDados816)

			If cNomMat <> aDados816[nDad,9]+aDados816[nDad,8]
				Somalinha()

				If nDad != 1
					Somalinha()
				EndIf

				@Li,000 Psay aDados816[nDad,8] //Centro de Custo
				@Li,023 Psay aDados816[nDad,9] //Descricao
				Somalinha()
			EndIf

			cNomMat := aDados816[nDad,9]+aDados816[nDad,8]
			Somalinha()
			@Li,005 Psay Substr(aDados816[nDad,5],1,35) //Nome
			@Li,043 Psay aDados816[nDad,1] //Matricula
			@Li,051 Psay aDados816[nDad,2] //Epi
			@Li,084 Psay Substr(aDados816[nDad,6],1,30) //Descricao
			@Li,117 Psay aDados816[nDad,3] Picture "99/99/9999" //Data Entrega
			@Li,131 Psay aDados816[nDad,13] Picture "@E 9999.99" //Quantidade
			@Li,143 Psay aDados816[nDad,7] Picture "99/99/9999" //Ultima Manutencao
			@Li,155 Psay aDados816[nDad,4] Picture "99/99/9999" //Proxima Manutencao
		Next nDad

	EndIf

	If Len(aDados816) > 0
		Roda(nCntImpr,cRodaTxt,Tamanho)
	Endif

	// Devolve a condicao original do arquivo principal
	RetIndex("TNF")

	Set Filter To
	Set Device To Screen

	If lImprime
		MsgInfo(STR0039)  //"Não há nada para imprimir no relatório."
		Return .F.
	EndIf

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf

	MS_FLUSH()

	dbSelectArea("TNF")
	dbSetOrder(1)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Incrementa Linha e Controla Salto de Pagina

@author  Denis Hyroshi de Souza
@since   28/06/07
/*/
//-------------------------------------------------------------------
Static Function Somalinha()
	Li++

	If Li > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatorio

@author  Andre E. Perez Alvarez
@since   31/07/06

@return  Objeto, Objeto para gerar o tReport
/*/
//-------------------------------------------------------------------
Static Function ReportDef()
	Static oReport
	Static oSection1
	Static oSection2
	Static oBreak1
	Static oCell
	// Criacao do componente de impressao
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao
	oReport := TReport():New("MDTR816",OemToAnsi(STR0006),"MDT816",{|oReport| ReportPrint()},; //"Higienização / Manutenção dos Equipamentos (EPI)"
			   STR0001+; //"Relatório de projeção para higienização / manutenção dos EPI's. Através dos     "
			   STR0002+; //"parâmetros, o usuário deve informar o período desejado para visualizar uma rela-"
			   STR0003) //"ção com os epi's de funcionários que devem sofrer uma manutenção.  "

	Pergunte(oReport:uParam,.F.)

	// Define secoes e celulas
	MDTR816REP()

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Impressao do relatorio em tReport

@author  Andre E. Perez Alvarez
@since   08/08/2006

@return  Logico, Sempre .T.
/*/
//-------------------------------------------------------------------
Static Function ReportPrint()

	Local nInd, nDad
	Local lImprime:= .T. //Variavel de controle de impressão.
	Local nPerMan := 0

	Private aDados816 := {}
	Private nIndTNF := 2, nArr
	Private cCondicTNF := "TNF->TNF_MAT < MV_PAR05 .Or. TNF->TNF_MAT > MV_PAR06"
	Private cSeekTNF := xFilial("TNF")+MV_PAR01
	Private cWhileTNF := "TNF->TNF_CODEPI <= MV_PAR02"
	//Redefine secoes e celulas
	MDTR816REP()

	If Empty(Mv_par01) .And. !Empty(MV_PAR05) .And. !Empty(MV_PAR06)
		nIndTNF := 3
		cCondicTNF := "TNF->TNF_CODEPI < MV_PAR01 .Or. TNF->TNF_CODEPI > MV_PAR02"
		cSeekTNF := xFilial("TNF")+MV_PAR05
		cWhileTNF := "TNF->TNF_MAT <= MV_PAR06"
	EndIf

	dbSelectArea("TNF")
	dbSetOrder(nIndTNF)
	dbSeek(cSeekTNF,.t.)
	oReport:SetMeter( LastRec() )

	While !oReport:Cancel() 			   .And.;
		!Eof()                     		   .And.;
		xFilial("TNF") == TNF->TNF_FILIAL  .And. &(cWhileTNF)

		oReport:IncMeter()

		If &(cCondicTNF)
			dbSelectArea("TNF")
			dbSkip()
			Loop
		EndIf

		If TNF->TNF_INDDEV == "1"
			dbSelectArea("TNF")
			dbSkip()
			Loop
		EndIf

		dbSelectArea("TN3")
		dbSetOrder(1)

		If DbSeek( xFilial("TN3")+TNF->(TNF_FORNEC+TNF_LOJA+TNF_CODEPI+TNF_NUMCAP))
			nPerMan := TN3->TN3_PERMAN
		Else //Se não estiver no cadastro de fornecedor de EPI, verifica se é um EPI filho
			dbSelectArea("TL0")
			dbSetOrder(2)

			If DbSeek( xFilial("TL0")+TNF->(TNF_CODEPI+TNF_FORNEC+TNF_LOJA+TNF_NUMCAP))
				dbSelectArea("TN3")
				dbSetOrder(2)
				If dbSeek( xFilial("TN3")+TL0->TL0_EPIGEN )
					nPerMan := TN3->TN3_PERMAN
				EndIf

			EndIf

		EndIf

		If nPerMan == 0
			dbSelectArea("TNF")
			dbSkip()
			Loop
		EndIf

		dDTFIM := TNF->TNF_DTMANU + nPerMan
		lNaoManut := .t.

		If Empty(TNF->TNF_DTMANU) .And. !Empty(TNF->TNF_DTENTR)

			For nInd := 1 To 3650
				dDTFIM := TNF->TNF_DTENTR + (nPerMan * nInd)

				If dDTFIM >= MV_PAR03 .And. dDTFIM <= MV_PAR04
					Exit
				ElseIf dDTFIM > MV_PAR04
					lNaoManut := .f.
					Exit
				EndIf

			Next nInd

		EndIf

		If dDTFIM > MV_PAR04 .Or. dDTFIM < MV_PAR03 .Or. !lNaoManut
			dbSelectArea("TNF")
			dbSkip()
			Loop
		EndIf

		dbSelectArea("SRA")
		dbSetOrder(1)
		If !dbSeek(xFilial("SRA")+TNF->TNF_MAT) .Or. SRA->RA_SITFOLH == "D"
			dbSelectArea("TNF")
			dbSkip()
			Loop
		EndIf

		If SRA->RA_CC < MV_PAR07 .Or. SRA->RA_CC > MV_PAR08
			dbSelectArea("TNF")
			dbSkip()
			Loop
		EndIf

		dbSelectArea(cAliasCC)
		dbSetOrder(1)
		dbSeek(xFilial(cAliasCC)+SRA->RA_CC)

		dbSelectArea("SRJ")
		dbSetOrder(1)
		dbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)

		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek(xFilial("SB1")+TNF->TNF_CODEPI)

		nPosX := aScan( aDados816 ,{|x| x[1] + x[2] == TNF->TNF_MAT + TNF->TNF_CODEPI })

		If nPosX == 0
			aAdd( aDados816 , { TNF->TNF_MAT, TNF->TNF_CODEPI, TNF->TNF_DTENTR, dDTFIM, ;
								SRA->RA_NOME, SB1->B1_DESC, TNF->TNF_DTMANU, SRA->RA_CC,;
								&(cDescrCC), SRJ->RJ_DESC, SRA->RA_NASC , SRA->RA_ADMISSA,;
								TNF->TNF_QTDENT } )
								lImprime := .F. //Variavel de controle de impressão.
		ElseIf dDTFIM >	aDados816[nPosX,4]
			aDados816[nPosX,4] := dDTFIM
		EndIf

		dbSelectArea("TNF")
		dbSkip()

	End

	oReport:SetMeter(Len(aDados816))
	cNomMat := " "

	If Mv_par09 == 1 // Funcionario
		aSort(aDados816,,,{|x,y| x[5]+x[1]+x[6] < y[5]+y[1]+y[6] })

		If Len(aDados816) > 0
			oSection1:Init()
		EndIf

		For nDad := 1 to Len(aDados816)
			nArr := nDad

			If cNomMat <> aDados816[nDad,5]+aDados816[nDad,1]

				If nDad != 1
					oSection2:Finish()
					oReport:SkipLine()
				EndIf

				oSection1:PrintLine()
				oSection2:Init()
			EndIf

			cNomMat := aDados816[nDad,5]+aDados816[nDad,1]
			oReport:IncMeter()
			oSection2:PrintLine()
		Next nDad

		If Len(aDados816) > 0
			oSection2:Finish()
			oSection1:Finish()
		EndIf

	ElseIf Mv_par09 == 2 // Matricula Funcionario
		aSort(aDados816,,,{|x,y| x[1]+x[6] < y[1]+y[6] })

		If Len(aDados816) > 0
			oSection1:Init()
		EndIf

		For nDad := 1 to Len(aDados816)
			nArr := nDad

			If cNomMat <> aDados816[nDad,1]

				If nDad != 1
					oSection2:Finish()
					oReport:SkipLine()
				EndIf

				oSection1:PrintLine()
				oSection2:Init()
			EndIf

			cNomMat := aDados816[nDad,1]
			oReport:IncMeter()
			oSection2:PrintLine()
		Next nDad

		If Len(aDados816) > 0
			oSection2:Finish()
			oSection1:Finish()
		EndIf

	ElseIf Mv_par09 == 3 // EPI
		aSort(aDados816,,,{|x,y| x[6]+x[5] < y[6]+y[5] })

		If Len(aDados816) > 0
			oSection1:Init()
		EndIf

		For nDad := 1 to Len(aDados816)
			nArr := nDad

			If cNomMat <> aDados816[nDad,6]+aDados816[nDad,2]

				If nDad != 1
					oSection2:Finish()
					oReport:SkipLine()
				EndIf

				oSection1:PrintLine()
				oSection2:Init()
			EndIf

			cNomMat := aDados816[nDad,6]+aDados816[nDad,2]
			oReport:IncMeter()
			oSection2:PrintLine()
		Next nDad

		If Len(aDados816) > 0
			oSection2:Finish()
			oSection1:Finish()
		EndIf

	ElseIf Mv_par09 == 4 // Centro Custo
		aSort(aDados816,,,{|x,y| x[9]+x[8]+x[5] < y[9]+y[8]+y[5] })

		If Len(aDados816) > 0
			oSection1:Init()
		EndIf

		For nDad := 1 to Len(aDados816)
			nArr := nDad

			If cNomMat <> aDados816[nDad,9]+aDados816[nDad,8]

				If nDad != 1
					oSection2:Finish()
					oReport:SkipLine()
				EndIf

				oSection1:PrintLine()
				oSection2:Init()
			EndIf

			cNomMat := aDados816[nDad,9]+aDados816[nDad,8]
			oReport:IncMeter()
			oSection2:PrintLine()
		Next nDad

		If Len(aDados816) > 0
			oSection2:Finish()
			oSection1:Finish()
		EndIf

	EndIf

	If lImprime
		MsgInfo(STR0039)  //"Não há nada para imprimir no relatório."
		Return .F.
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR816REP
Define secoes e colunas do tReport
@author  Roger Rodrigues
@since   12/03/2010

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
Static Function MDTR816REP()
	Local nDad
	Local nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))

	oReport:Asection := {}  //Apaga as secoes dos parametros anteriores
	If MV_PAR09 == 1 //Funcionario

		//Secao 1 - Funcionario
		oSection1 := TRSection():New (oReport,STR0014, {"SRA"} )  //"Funcionário"
		oCell := TRCell():New(oSection1, "aDados816[nDad,05]", , STR0015,	"@!"			,	35,	,	{|| aDados816[nArr,05] }  ) //"Nome"
		oCell := TRCell():New(oSection1, "aDados816[nDad,01]", , STR0016,	"@!"			,	06,	,	{|| aDados816[nArr,01] }  ) //"Matrícula"
		oCell := TRCell():New(oSection1, "aDados816[nDad,09]", , STR0017,	"@!"			,	30,	,	{|| aDados816[nArr,09] }  ) //"Centro de Custo"
		oCell := TRCell():New(oSection1, "aDados816[nDad,10]", , STR0018,	"@!"			,	30,	,	{|| aDados816[nArr,10] }  ) //"Função"
		oCell := TRCell():New(oSection1, "aDados816[nDad,11]", , STR0019,	"99/99/9999"	,	10,	,	{|| aDados816[nArr,11] }  ) //"Dt.Nasc."
		oCell := TRCell():New(oSection1, "aDados816[nDad,12]", , STR0020,	"99/99/9999"	,	10,	,	{|| aDados816[nArr,12] }  ) //"Admissão"
		//Secao 2 - EPI
		oSection2 := TRSection():New (oReport,STR0021, {"SB1"} ) //"Equipamento (EPI)"
		oCell := TRCell():New(oSection2, "aDados816[nDad,02]", , STR0022				, "@!"      , nSizeCod  , , {|| aDados816[nArr,02] }  ) //"EPI"
		oCell := TRCell():New(oSection2, "aDados816[nDad,06]", , STR0023		, "@!"		, 40  , , {|| aDados816[nArr,06] }  ) //"Descrição"
		oCell := TRCell():New(oSection2, "aDados816[nDad,03]", , STR0024		, "99/99/9999", 10  , , {|| aDados816[nArr,03] }  ) //"Dt.Entrega"
		oCell := TRCell():New(oSection2, "aDados816[nDad,13]", , STR0025		, "@E 9999.99",07 , , {|| aDados816[nArr,13] }  ) //"Quantidade"
		oCell := TRCell():New(oSection2, "aDados816[nDad,07]", , STR0026		, "99/99/9999", 10  , , {|| aDados816[nArr,07] }  ) //"Ult.Manut."
		oCell := TRCell():New(oSection2, "aDados816[nDad,04]", , STR0027		, "99/99/9999", 10  , , {|| aDados816[nArr,04] }  ) //"Prox.Manut."

	ElseIf MV_PAR09 == 2 //Nome
		//Secao 1 - Funcionario
		oSection1 := TRSection():New (oReport,STR0014, {"SRA"} )  //"Funcionário"
		oCell := TRCell():New(oSection1, "aDados816[nDad,01]", , STR0016		, "@!"		, 06  , , {|| aDados816[nArr,01] }  ) //"Matrícula"
		oCell := TRCell():New(oSection1, "aDados816[nDad,05]", , STR0015				, "@!"      , 35  , , {|| aDados816[nArr,05] }  ) //"Nome"
		oCell := TRCell():New(oSection1, "aDados816[nDad,09]", , STR0017	, "@!"      , 30  , , {|| aDados816[nArr,09] }  ) //"Centro de Custo"
		oCell := TRCell():New(oSection1, "aDados816[nDad,10]", , STR0018			, "@!"      , 30  , , {|| aDados816[nArr,10] }  ) //"Função"
		oCell := TRCell():New(oSection1, "aDados816[nDad,11]", , STR0019			, "99/99/9999", 10  , , {|| aDados816[nArr,11] }  ) //"Dt.Nasc."
		oCell := TRCell():New(oSection1, "aDados816[nDad,12]", , STR0020			, "99/99/9999", 10  , , {|| aDados816[nArr,12] }  ) //"Admissão"
		//Secao 2 - EPI
		oSection2 := TRSection():New (oReport,STR0021, {"SB1"} ) //"Equipamento (EPI)"
		oCell := TRCell():New(oSection2, "aDados816[nDad,02]", , STR0022				, "@!"      , nSizeCod  , , {|| aDados816[nArr,02] }  ) //"EPI"
		oCell := TRCell():New(oSection2, "aDados816[nDad,06]", , STR0023		, "@!"		, 40  , , {|| aDados816[nArr,06] }  ) //"Descrição"
		oCell := TRCell():New(oSection2, "aDados816[nDad,03]", , STR0024		, "99/99/9999", 10  , , {|| aDados816[nArr,03] }  ) //"Dt.Entrega"
		oCell := TRCell():New(oSection2, "aDados816[nDad,13]", , STR0025		, "@E 9999.99",07 , , {|| aDados816[nArr,13] }  ) //"Quantidade"
		oCell := TRCell():New(oSection2, "aDados816[nDad,07]", , STR0026		, "99/99/9999", 10  , , {|| aDados816[nArr,07] }  ) //"Ult.Manut."
		oCell := TRCell():New(oSection2, "aDados816[nDad,04]", , STR0027		, "99/99/9999", 10  , , {|| aDados816[nArr,04] }  ) //"Prox.Manut."

	ElseIf MV_PAR09 == 3 //EPI
		//Secao 1 - Equipamento
		oSection1 := TRSection():New (oReport,STR0021, {"SB1"} )  //"Equipamento (EPI)"
		oCell := TRCell():New(oSection1, "aDados816[nDad,02]", , STR0022				, "@!"      , nSizeCod  , , {|| aDados816[nArr,02] }  ) //"EPI"
		oCell := TRCell():New(oSection1, "aDados816[nDad,06]", , STR0023		, "@!"		, 40  , , {|| aDados816[nArr,06] }  ) //"Descrição"
		//Secao 2 - Funcionario
		oSection2 := TRSection():New (oReport,STR0014, {"SRA"} ) //"Funcionário"
		oCell := TRCell():New(oSection2, "aDados816[nDad,01]", , STR0016		, "@!"		, 06  , , {|| aDados816[nArr,01] }  ) //"Matrícula"
		oCell := TRCell():New(oSection2, "aDados816[nDad,05]", , STR0015				, "@!"      , 30  , , {|| aDados816[nArr,05] }  ) //"Nome"
		oCell := TRCell():New(oSection2, "aDados816[nDad,09]", , STR0017	, "@!"      , 20  , , {|| aDados816[nArr,09] }  ) //"Centro de Custo"
		oCell := TRCell():New(oSection2, "aDados816[nDad,10]", , STR0018			, "@!"      , 20  , , {|| aDados816[nArr,10] }  ) //"Função"
		oCell := TRCell():New(oSection2, "aDados816[nDad,03]", , STR0024		, "99/99/9999", 10  , , {|| aDados816[nArr,03] }  ) //"Dt.Entrega"
		oCell := TRCell():New(oSection2, "aDados816[nDad,13]", , STR0025		, "@E 9999.99",07 , , {|| aDados816[nArr,13] }  ) //"Quantidade"
		oCell := TRCell():New(oSection2, "aDados816[nDad,07]", , STR0026		, "99/99/9999", 10  , , {|| aDados816[nArr,07] }  ) //"Ult.Manut."
		oCell := TRCell():New(oSection2, "aDados816[nDad,04]", , STR0027		, "99/99/9999", 10  , , {|| aDados816[nArr,04] }  ) //"Prox.Manut."

	ElseIf MV_PAR09 == 4 //Centro de Custo
		//Secao 1 - Equipamento
		oSection1 := TRSection():New (oReport,STR0017, {cAliasCC} )  //"Centro de Custo"
		oCell := TRCell():New(oSection1, "aDados816[nDad,08]", , STR0017	, "@!"      , Len(SRA->RA_CC)  , , {|| aDados816[nArr,08] }  ) //"Centro de Custo"
		oCell := TRCell():New(oSection1, "aDados816[nDad,09]", , STR0023		, "@!"      , 40  , , {|| aDados816[nArr,09] }  ) //"Descrição"
		//Secao 2 - Funcionario
		oSection2 := TRSection():New (oReport,STR0014, {"SRA"} ) //"Funcionário"
		oCell := TRCell():New(oSection2, "aDados816[nDad,01]", , STR0016		, "@!"		, 06  , , {|| aDados816[nArr,01] }  ) //"Matrícula"
		oCell := TRCell():New(oSection2, "aDados816[nDad,05]", , STR0015				, "@!"      , 30  , , {|| aDados816[nArr,05] }  ) //"Nome"
		oCell := TRCell():New(oSection2, "aDados816[nDad,02]", , STR0022				, "@!"      , nSizeCod  , , {|| aDados816[nArr,02] }  ) //"EPI"
		oCell := TRCell():New(oSection2, "aDados816[nDad,06]", , STR0023		, "@!"		, 40  , , {|| aDados816[nArr,06] }  ) //"Descrição"
		oCell := TRCell():New(oSection2, "aDados816[nDad,10]", , STR0018			, "@!"      , 20  , , {|| aDados816[nArr,10] }  ) //"Função"
		oCell := TRCell():New(oSection2, "aDados816[nDad,03]", , STR0024		, "99/99/9999", 10  , , {|| aDados816[nArr,03] }  ) //"Dt.Entrega"
		oCell := TRCell():New(oSection2, "aDados816[nDad,13]", , STR0025		, "@E 9999.99",07 , , {|| aDados816[nArr,13] }  ) //"Quantidade"
		oCell := TRCell():New(oSection2, "aDados816[nDad,07]", , STR0026		, "99/99/9999", 10  , , {|| aDados816[nArr,07] }  ) //"Ult.Manut."
		oCell := TRCell():New(oSection2, "aDados816[nDad,04]", , STR0027		, "99/99/9999", 10  , , {|| aDados816[nArr,04] }  ) //"Prox.Manut."

	EndIf

Return .T.