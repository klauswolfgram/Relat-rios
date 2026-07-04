/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr845.ch"
#INCLUDE "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR845

Relatorio da Agenda de Reunioes
Gera o relatoria da Reuniao da Cipa

@author  Thiago Olis Machado
@since   23/06/01

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTR845()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local wnrel   := "MDTR845"
	Local limite  := 132
	Local cDesc1  := STR0001 //"Relatorio da Agenda de Reunioes "
	Local cDesc2  := " "
	Local cDesc3  := " "
	Local cString := "TNR"
	Local nTamSRA := TAMSX3("RA_MAT")[1]
	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	// Variaiveis do TRB
	Local aCampos := {}
	Private aVetInr  := {}
	Private oTempTRB
	Private cAliasTRB:= GetNextAlias()

	Private nomeprog := "MDTR845"
	Private tamanho  := "M"
	Private aReturn   := { STR0002, 1,STR0003, 1, 2, 1, "",1 } // "Zebrado"###"Administracao"
	Private titulo    := STR0004 // "Agenda de Reunioes"
	Private ntipo     := 0
	Private nLastKey  := 0
	Private cPerg     := ""
	Private cabec1, cabec2
	Private lFirstPage := .T.
	Private cMandato   := ""
	Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )

	cPerg    :=  If(!lSigaMdtPS,"MDT845    ","MDT845PS  ")

	/*---------------------------------------------
	//PERGUNTAS PADRÃO								|
	| MDT845    ¦01      ¦De  Mandato ?			    |
	| MDT845    ¦02      ¦Ate Mandato ?			    |
	| MDT845    ¦03      ¦De  Data ?				|
	| MDT845    ¦04      ¦Ate Data ?				|
	| MDT845    ¦05      ¦Ata da Reuniao ?			|
	| MDT845    ¦06      ¦Modelo de relatorio ?	    |
	| MDT845    ¦07      ¦Listar Ausentes ?		    |
	| MDT845    ¦08      ¦Ausência Justificada ?	|
	| 												|
	//PERGUNTAS DO PRESTADOR DE SERVIÇO			    |
	| 01       De Cliente ?							|
	| 02       Loja									|
	| 03       Até Cliente ?						|
	| 04       Loja									|
	| MDT845    ¦05      ¦De  Mandato ?			    |
	| MDT845    ¦06      ¦Ate Mandato ?			    |
	| MDT845    ¦07      ¦De  Data ?				|
	| MDT845    ¦08      ¦Ate Data ?				|
	| MDT845    ¦09      ¦Ata da Reuniao ?			|
	| MDT845    ¦10      ¦Modelo de relatorio ?	    |
	| MDT845    ¦11      ¦Listar Ausentes ?		    |
	| MDT845    ¦12      ¦Ausência Justificada ?	|
	----------------------------------------------*/

	Pergunte(cPerg,.F.) // Inicializa as variaveis de pergunta (mv_par01,...)

	wnrel:="MDTR845" // Envia controle para a funcao SETPRINT

	wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to
		NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)
		Return
	Endif

	// Cria arquivo temporario
	aAdd(aCampos,{"MAT"    , "C" ,nTamSRA, 0 })
	aAdd(aCampos,{"NOME"   , "C" , 35 , 0 })
	aAdd(aCampos,{"PRESEN" , "C" , 01 , 0 })

	oTempTRB := FWTemporaryTable():New( cAliasTRB, aCampos )
	oTempTRB:AddIndex( "1", {"PRESEN","MAT","NOME"} )
	oTempTRB:Create()

	If lSigaMdtps

		If mv_par10 == 1
			RptStatus({|lEnd| R845Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
		Else
			RptStatus({|lEnd| Graf845imp()},titulo)
		Endif

	Else

		If mv_par06 == 1
			RptStatus({|lEnd| R845Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
		Else
			RptStatus({|lEnd| Graf845imp()},titulo)
		Endif

	Endif

	oTempTRB:Delete()

	NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} R845Imp

Chamada do Relat¢rio Padrao

@author  Inacio Luiz Kolling
@since    01/06/97

@sample  R845Imp(@lEnd,wnRel,titulo,tamanho)

@param   lEnd, Lógico, Indica o fim da impressao
@param   wnRel, Caracter, Arquivo de saida do relatorio
@param   titulo, Caracter, Titulo do relatorio
@param   tamanho, Caracter, Tamanho do relatorio

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function R845Imp(lEnd,wnRel,titulo,tamanho)

	// Variaveis locais exclusivas deste programa
	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local LinhaCorrente
	Local nNum := ""

	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	// Monta os Cabecalhos
	cabec1 := STR0005 // "Mandato   Nome Mandato"
	cabec2 := STR0006 // "  Data Prev.  Data Real   Hora    Tipo"

	/*
	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                 <Relatorio de Questionario Medico>                               DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************

			1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	Mandato   Nome Mandato
	Data Prev.  Data Real   Hora    Tipo
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	999999    xxxxxxxxxxxxxxxxxxx
	99/99/99    99/99/99    99:99   xxxxxxxxxxxxxx    Assunto.: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	Participantes
	999999   xxxxxxxxxxxxxxxxxxx
	999999   xxxxxxxxxxxxxxxxxxx
	999999   xxxxxxxxxxxxxxxxxxx

						Ata.....: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	*/

	If lSigaMdtps

		dbSelectArea("TNR")
		dbSetOrder(02)  //TNR_FILIAL+TNR_CLIENT+TNR_LOJA+TNR_MANDAT+DTOS(TNR_DTREUN)+TNR_HRREUN
		dbSeek(xFilial("TNR")+MV_PAR01+MV_PAR02,.T.)

		SetRegua(LastRec())

		cCliente := ""
		lFirst2 := .T.

		// Correr TMI para ler as  Questoes
		While !Eof() .And. TNR->TNR_FILIAL == xFilial("TNR") .And.;
			TNR->(TNR_CLIENT+TNR_LOJA) >= mv_par01+mv_par02 .And. TNR->(TNR_CLIENT+TNR_LOJA) <= mv_par03+mv_par04

			IncRegua()

			If !( TNR->TNR_MANDATO >= MV_PAR05 .And. TNR->TNR_MANDATO <= MV_PAR06)
				dbSelectArea("TNR")
				dbSkip()
				loop
			Endif

			If TNR->TNR_DTREUN < MV_PAR07 .Or. TNR->TNR_DTREUN > MV_PAR08
				dbSelectArea("TNR")
				dbSkip()
				loop
			Endif

			cTipo := " "

			If TNR->(TNR_CLIENT+TNR_LOJA) != cCliente
				cCliente := TNR->(TNR_CLIENT+TNR_LOJA)
				cMandato := ""
				If !lFirst2
					Li := 80
				Endif
				Somalinha(1)
				lFirst2 := .F.
				dbSelectArea("SA1")
				dbSetOrder(1)
				dbSeek(xFilial("SA1")+cCliente)
				@ Li,000 Psay STR0031 + TNR->TNR_CLIENT + "-" + TNR->TNR_LOJA + " - " + SA1->A1_NOME //"Cliente/Loja: "
				Somalinha(1)
			Else
				Somalinha(1)
			Endif

			If TNR->TNR_MANDATO != cMandato
				Somalinha(1)
				@ Li,000 PSAY TNR->TNR_MANDATO PICTURE "@!"
				cMandato := TNR->TNR_MANDATO
				dbSelectArea("TNN")
				dbSetOrder(1)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
				dbSeek(xFilial("TNN")+TNR->TNR_CLIENT+TNR->TNR_LOJA+TNR->TNR_MANDATO)
				@ Li,010 Psay TNN->TNN_DESCRI
				Somalinha(1)
			Endif
			Somalinha(1)
			@ Li,002 Psay TNR->TNR_DTREUN Picture "99/99/99"
			@ Li,014 Psay TNR->TNR_DTREAL Picture "99/99/99"
			@ Li,026 Psay TNR->TNR_HRREUN Picture "99:99"

			If TNR->TNR_TIPREU = "1"
				cTipo := STR0008 //"Ordinaria"
			Else
				cTipo := STR0009 //"Extraordinaria"
			Endif

			@ Li,034 Psay cTipo Picture "@!"
			@ Li,052 Psay STR0010 //"Assunto.:"
			@ Li,062 Psay TNR->TNR_ASSUNT Picture "@!"
			Somalinha(1)

			If mv_par09 == 1
				lproc := .F.
				nLinhasMemo := MLCOUNT(Trim(TNR->TNR_ATA),80)
				lPRIN := .T.	//Variavel auxiliar p/ imprimir "Ata da Reuniao" soh uma vez para cada reuniao

				If !Empty(TNR->TNR_ATA)
					For LinhaCorrente := 1 to nLinhasMemo
						If lPRIN
							Somalinha(1)
							@Li,021 Psay replicate("_",89)
							Somalinha(1)
							@Li,020 Psay "|"
							@Li,056 Psay STR0012 //"Ata da Reuniao"
							@Li,110 Psay "|"
							Somalinha(1)
							@Li,020 Psay "|"
							@Li,021 Psay replicate("_",89)
							@Li,110 Psay "|"
							lPRIN := .F.
						Endif
						lProc := .T.
						Somalinha(1)
						@Li,020 PSay "|"
						@Li,025 PSAY (MemoLine(TNR->TNR_ATA,80,LinhaCorrente))
						@Li,110 PSay "|"
					Next LinhaCorrente
				EndIf
				If lProc
					Somalinha(1)
					@Li,020 Psay "|"
					@Li,021 Psay replicate("_",89)
					@Li,110 Psay "|"
				Endif

				Somalinha(1)
				Somalinha(1)

			Else

				Somalinha(1)

			Endif

			//@ Li,002 Psay STR0011 //"Participantes...:"
			lFirst := .T.
			dbSelectArea("TNS")
			dbSetOrder(3)  //TNS_FILIAL+TNS_CLIENT+TNS_LOJA+TNS_MANDAT+DTOS(TNS_DTREUN)+TNS_HRREUN+TNS_MAT
			dbSeek(xfilial("TNS")+TNR->TNR_CLIENT+TNR->TNR_LOJA+TNR->TNR_MANDATO+DTOS(TNR->TNR_DTREUN)+TNR->TNR_HRREUN)

			While !Eof() 								.And.;
				TNR->TNR_MANDATO == TNS->TNS_MANDATO 	.And.;
				TNR->TNR_DTREUN  == TNS->TNS_DTREUN  	.And.;
				TNR->TNR_HRREUN  == TNS->TNS_HRREUN	.And.;
				TNR->TNR_CLIENT  == TNS->TNS_CLIENT	.And.;
				TNR->TNR_LOJA    == TNS->TNS_LOJA

				If Empty(nNum)
					@ Li,002 Psay STR0011 //"Participantes...:"
				EndIf
				nNum := 1
				If TNS->TNS_PRESEN == "1" .Or. Empty(TNS->TNS_PRESEN)
					cFilTmp := cFilAnt
					If !Empty(TNS->TNS_FILMAT)
						cFilTmp := TNS->TNS_FILMAT
					Endif
					dbSelectArea("SRA")
					dbSetOrder(01)
					dbSeek(xFilial("SRA",cFilTmp)+TNS->TNS_MAT)
					If SRA->RA_SITFOLH == "D" .Or. !EMPTY(SRA->RA_DEMISSA)
						If SRA->RA_DEMISSA < TNR->TNR_DTREAL
							dbSelectArea("TNS")
							dbSkip()
							loop
						Endif
					Endif

					If !lFirst
						Somalinha(1); Somalinha(1)
					Endif
					lFirst := .F.
					If !Empty(TNS->TNS_MAT)
						@ Li,020 Psay TNS->TNS_MAT Picture "@!"
						@ Li,030 Psay SubStr(SRA->RA_NOME,1,28)
						@ Li,061 Psay STR0018  //"Ass.:________________________"
					ElseIf !Empty(TNS->TNS_NOMPAR)
						@ Li,020 Psay STR0050 Picture "@!"
						@ Li,030 Psay SubStr(TNS->TNS_NOMPAR,1,28)
						@ Li,061 Psay STR0018  //"Ass.:________________________"
					Endif
				Else
					DbSelectArea(cAliasTRB)
					DbSetOrder(1)
					//-------
					If Empty(TNS->TNS_MAT)
						If !DbSeek(TNS->TNS_PRESEN+TNS->TNS_NOMPAR)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MAT    := TNS->TNS_MAT
							(cAliasTRB)->PRESEN := TNS->TNS_PRESEN
							If Empty(TNS->TNS_MAT)
								( cAliasTRB )->NOME := TNS->TNS_NOMPAR
							Else
								dbSelectArea( 'SRA' )
								dbSetOrder( 01 )
								dbSeek( xFilial( 'SRA', TNS->TNS_FILMAT ) + TNS->TNS_MAT )
								( cAliasTRB )->NOME := SRA->RA_NOME
							EndIf
						EndIf
					ElseIf !Empty(TNS->TNS_MAT)
						If !DbSeek(TNS->TNS_PRESEN+TNS->TNS_MAT)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MAT    := TNS->TNS_MAT
							(cAliasTRB)->PRESEN := TNS->TNS_PRESEN
							If Empty(TNS->TNS_MAT)
								( cAliasTRB )->NOME := TNS->TNS_NOMPAR
							Else

								dbSelectArea( 'SRA' )
								dbSetOrder( 01 )

								If dbSeek( xFilial( 'SRA', TNS->TNS_FILMAT ) + TNS->TNS_MAT )

									( cAliasTRB )->NOME := SRA->RA_NOME

								EndIf

							EndIf
						EndIf
					EndIf
					MsUnlock(cAliasTRB)
					//--------
				Endif
				dbSelectArea("TNS")
				dbSkip()
			End

			If mv_par11 == 2
				DbSelectArea(cAliasTRB)
				DbGoTop()
				If RecCount() > 0
					SetRegua(LastRec())
					While !EOF()

						IncRegua()
						If !lFirst
							Somalinha(1); Somalinha(1)
						Endif
						lFirst := .F.

						If !Empty((cAliasTRB)->MAT) .And. !Empty((cAliasTRB)->NOME)
							@ Li,020 Psay (cAliasTRB)->MAT Picture "@!"
						Else
							@ Li,020 Psay STR0050 Picture "@!"
						Endif
						@ Li,030 Psay SubStr((cAliasTRB)->NOME,1,30)

						If mv_par12 == 2
							If (cAliasTRB)->PRESEN == "2".And. !Empty((cAliasTRB)->NOME)
								@Li,061 Psay STR0047 Picture "@!" //"Falta Justificada"
							ElseIf (cAliasTRB)->PRESEN == "3"
								@Li,061 Psay STR0048 Picture "@!" //"Falta Nao Justificada"
							EndIf
						Else
							@Li,061 Psay STR0049 Picture "@!" //"Não Compareceu"
						EndIf

						DbSelectArea(cAliasTRB)
						DbSkip()
					End
				EndIf
			EndIf

			Somalinha(1)

			DbSelectArea(cAliasTRB)
			dbGoTop()
			If RecCount() > 0
				While !EOF()
					RecLock(cAliasTRB,.F.)
					DbDelete()
					MsUnlock(cAliasTRB)
					DbSkip()
				End
			EndIf

			dbSelectArea("TNR")
			dbSkip()

		End

	Else

		dbSelectArea("TNR")
		dbSetOrder(01)
		dbSeek(xFilial("TNR")+MV_PAR01,.T.)

		SetRegua(LastRec())

		cMandato := ""
		lFirst2 := .T.
		While !Eof() .And. TNR->TNR_FILIAL == xFilial("TNR") .And.;
			TNR->TNR_MANDATO >= MV_PAR01 .And. TNR->TNR_MANDATO <= MV_PAR02

			If lEnd
				@ PROW()+1,001 PSay STR0007 //"CANCELADO PELO OPERADOR"
				Exit
			Endif

			IncRegua()

			If TNR->TNR_DTREUN < MV_PAR03 .Or. TNR->TNR_DTREUN > MV_PAR04
				dbSelectArea("TNR")
				dbSkip()
				loop
			Endif
			Somalinha(1)
			cTipo := " "

			If TNR->TNR_MANDATO != cMandato
				If !lFirst2
					Somalinha(1)
				Endif
				lFirst2 := .F.
				@ Li,000 PSAY TNR->TNR_MANDATO PICTURE "@!"
				cMandato := TNR->TNR_MANDATO
				dbSelectArea("TNN")
				dbSetOrder(1)
				dbSeek(xFilial("TNN")+TNR->TNR_MANDATO)
				@ Li,010 Psay TNN->TNN_DESCRI
				Somalinha(1)
			Endif

			Somalinha(1)
			@ Li,002 Psay TNR->TNR_DTREUN Picture "99/99/99"
			@ Li,014 Psay TNR->TNR_DTREAL Picture "99/99/99"
			@ Li,026 Psay TNR->TNR_HRREUN Picture "99:99"

			If TNR->TNR_TIPREU = "1"
				cTipo := STR0008 //"Ordinaria"
			Else
				cTipo := STR0009 //"Extraordinaria"
			Endif

			@ Li,034 Psay cTipo Picture "@!"
			@ Li,052 Psay STR0010 //"Assunto.:"
			@ Li,062 Psay TNR->TNR_ASSUNT Picture "@!"
			Somalinha(1)

			If mv_par05 == 1 .And. !Empty(TNR->TNR_ATA)
				lproc := .F.
				nLinhasMemo := MLCOUNT(Trim(TNR->TNR_ATA),80)
				lPRIN := .T.	//Variavel auxiliar p/ imprimir "Ata da Reuniao" soh uma vez para cada reuniao

				For LinhaCorrente := 1 to nLinhasMemo
					If lPRIN
						Somalinha(1)
						@Li,021 Psay replicate("_",89)
						Somalinha(1)
						@Li,020 Psay "|"
						@Li,056 Psay STR0012 //"Ata da Reuniao"
						@Li,110 Psay "|"
						Somalinha(1)
						@Li,020 Psay "|"
						@Li,021 Psay replicate("_",89)
						@Li,110 Psay "|"
						lPRIN := .F.
					Endif
					lProc := .T.
					Somalinha(1)
					@Li,020 PSay "|"
					@Li,025 PSAY (MemoLine(TNR->TNR_ATA,80,LinhaCorrente))
					@Li,110 PSay "|"
				Next LinhaCorrente
				//EndIf

				If lProc
					Somalinha(1)
					@Li,020 Psay "|"
					@Li,021 Psay replicate("_",89)
					@Li,110 Psay "|"
				Endif

				Somalinha(1)
				Somalinha(1)

			Else

				Somalinha(1)

			Endif

			//@ Li,002 Psay STR0011 //"Participantes...:"
			lFirst := .T.
			dbSelectArea("TNS")
			dbSetOrder(1)
			dbSeek(xfilial("TNS")+TNR->TNR_MANDATO+DTOS(TNR->TNR_DTREUN)+TNR->TNR_HRREUN)

			While !Eof() 								.And.;
				TNR->TNR_MANDATO == TNS->TNS_MANDATO 	.And.;
				TNR->TNR_DTREUN  == TNS->TNS_DTREUN  	.And.;
				TNR->TNR_HRREUN  == TNS->TNS_HRREUN
				If Empty(nNum)
					@ Li,002 Psay STR0011 //"Participantes...:"
				EndIf
				nNum := 1
				If TNS->TNS_PRESEN == "1" .Or. Empty(TNS->TNS_PRESEN)
					cFilTmp := cFilAnt
					If !Empty(TNS->TNS_FILMAT)
						cFilTmp := TNS->TNS_FILMAT
					Endif
					dbSelectArea("SRA")
					dbSetOrder(01)
					dbSeek(xFilial("SRA",cFilTmp)+TNS->TNS_MAT)
					If SRA->RA_SITFOLH == "D" .Or. !EMPTY(SRA->RA_DEMISSA)
						If SRA->RA_DEMISSA < TNR->TNR_DTREAL
							dbSelectArea("TNS")
							dbSkip()
							loop
						Endif
					Endif

					If !lFirst
						Somalinha(1); Somalinha(1)
					Endif
					lFirst := .F.
					If !Empty(TNS->TNS_MAT)
						@ Li,020 Psay TNS->TNS_MAT Picture "@!"
						@ Li,030 Psay SubStr(SRA->RA_NOME,1,28)
						@ Li,061 Psay STR0018  //"Ass.:________________________"
					ElseIf !Empty(TNS->TNS_NOMPAR)
						@ Li,020 Psay STR0050 Picture "@!"
						@ Li,030 Psay SubStr(TNS->TNS_NOMPAR,1,28)
						@ Li,061 Psay STR0018  //"Ass.:________________________"
					Endif
				Else
					DbSelectArea(cAliasTRB)
					DbSetOrder(1)
					If Empty(TNS->TNS_MAT)
						If !DbSeek(TNS->TNS_PRESEN+TNS->TNS_NOMPAR)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MAT    := TNS->TNS_MAT
							(cAliasTRB)->PRESEN := TNS->TNS_PRESEN
							If Empty(TNS->TNS_MAT)
								( cAliasTRB )->NOME := TNS->TNS_NOMPAR
							Else
								dbSelectArea( 'SRA' )
								dbSetOrder( 01 )
								dbSeek( xFilial( 'SRA', TNS->TNS_FILMAT ) + TNS->TNS_MAT )
								( cAliasTRB )->NOME := SRA->RA_NOME
							EndIf
						EndIf
					ElseIf !Empty(TNS->TNS_MAT)
						If !DbSeek(TNS->TNS_PRESEN+TNS->TNS_MAT)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MAT    := TNS->TNS_MAT
							(cAliasTRB)->PRESEN := TNS->TNS_PRESEN
							If Empty(TNS->TNS_MAT)
								( cAliasTRB )->NOME := TNS->TNS_NOMPAR
							Else
								dbSelectArea( 'SRA' )
								dbSetOrder( 01 )
								dbSeek( xFilial( 'SRA', TNS->TNS_FILMAT ) + TNS->TNS_MAT )
								( cAliasTRB )->NOME := SRA->RA_NOME
							EndIf
						EndIf
					EndIf
					MsUnlock(cAliasTRB)
				EndIf

				dbSelectArea("TNS")
				dbSkip()
			End

			If mv_par07 == 2
				DbSelectArea(cAliasTRB)
				DbGoTop()
				If RecCount() > 0
					SetRegua(LastRec())
					While !EOF()

						IncRegua()
						If !lFirst
							Somalinha(1); Somalinha(1)
						EndIf
						lFirst := .F.
						If !Empty((cAliasTRB)->MAT)
							@ Li,020 Psay (cAliasTRB)->MAT Picture "@!"
							@ Li,030 Psay SubStr((cAliasTRB)->NOME,1,30)
						Else
							@ Li,020 Psay STR0050 Picture "@!"
							@ Li,030 Psay SubStr((cAliasTRB)->NOME,1,30)
						EndIf

						If mv_par08 == 2
							If (cAliasTRB)->PRESEN == "2"
								@Li,061 Psay STR0047 Picture "@!" //"Falta Justificada"
							ElseIf (cAliasTRB)->PRESEN == "3"
								@Li,061 Psay STR0048 Picture "@!" //"Falta Nao Justificada"
							EndIf
						Else
							@Li,061 Psay STR0049 Picture "@!" //"Não Compareceu"
						EndIf

						DbSelectArea(cAliasTRB)
						DbSkip()
					End
				EndIf
			EndIf

			Somalinha(1)

			DbSelectArea(cAliasTRB)
			dbGoTop()
			If RecCount() > 0
				While !EOF()
					RecLock(cAliasTRB,.F.)
					DbDelete()
					MsUnlock(cAliasTRB)
					DbSkip()
				End
			EndIf

			dbSelectArea("TNR")
			dbSkip()

		End

	Endif

	Roda(nCntImpr,cRodaTxt,Tamanho)

	// Devolve a condicao original do arquivo principal
	RetIndex("TNR")
	Set Filter To
	Set device to Screen

	If lFirst2
		MsgInfo(STR0035)  // "Não há nada para imprimir no relatório."
		Return Nil
	Endif

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif

	MS_FLUSH() // SET CENTURY ON
	dbSelectArea("TNR")
	dbSetOrder(01)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha

Incrementa Linha e Controla Salto de Pagina

@author  Inacio Luiz Kolling
@since   01/06/1997

@sample  Somalinha(2,100, .T.)

@param   nTpo, Numerico, Modelo de relatorio. 1 = Padrao / 2 = Grafico
@param   nLinha, Numerico, Espacamento da quebra de linha
@param   lLaterais, Logico, Define se serao impressas linhas laterais
@param   lFim, Logico, Define se deve ser impresso a linha final
@param   lIni, Lógico, Define se deve ser impressa a linha inicial
/*/
//-------------------------------------------------------------------
Static Function Somalinha( nTpo, nLinha, lLaterais, lFim, lIni )

	Local cSMCOD      := FWGrpCompany()
	Local cSMFIL      := FWCodFil()
	Local lCipatr     := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"
	Default lLaterais := .F.
	Default lFim      := .F.
	Default lIni      := .T.

	If nTpo == 1
		Li++

		If Li > 58
			Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif

	Else

		If lLaterais
			oPrint:Line(lin,195,lin+nLinha,195)
			oPrint:Line(lin,2105,lin+nLinha,2105)
		Endif

		lin += nLinha

		If lFim
			oPrint:Line(lin,195,lin,2105) //Linha final
		ElseIf lin > 2900  // Se o numero de linhas ultrapassa 2800 pixels, cria uma nova pag.

			If !lFirstPage
				oPrint:Line(lin,195,lin,2105) //Linha final
				oPrint:EndPage()
			Endif

			lFirstPage := .F.
			oPrint:StartPage()	//Inicio de uma nova Pag.
			lin:=200
			cLogo := cStartPath+"LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial

			If File(cLogo)
				oPrint:SayBitMap(150,200,cLogo,250,50)
			Else
				cLogo := cStartPath+"LGRL"+cSMCOD+".BMP" // Empresa

				If File(cLogo)
					oPrint:SayBitMap(150,200,cLogo,250,50)
				Else
					cLogo := "LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial

					If File(cLogo)
						oPrint:SayBitMap(150,200,cLogo,250,50)
					Else
						cLogo := "LGRL"+cSMCOD+".BMP" // Empresa

						If File(cLogo)
							oPrint:SayBitMap(150,200,cLogo,250,50)
						Endif

					Endif

				Endif

			Endif

			oPrint:Say(lin,1000,If(lCipatr,STR0051,STR0020),oFont16) //"Reunião da CIPATR" //"Reunião da CIPA"
			lin += 180
			If lIni
				oPrint:Line(lin,195,lin,2105)     // linha inicial
				oPrint:Line(lin,195,lin+50,195)   // linha lado direito
				oPrint:Line(lin,2105,lin+50,2105) // linha lado esquerdo
			EndIf
			lin += 50

		Endif

	Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} GRAF845Imp

Chamada do Relatorio modelo grafico

@author  Andre E. P. Alvarez
@since   04/10/05

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function GRAF845Imp()

	// Variaveis pertencentes apenas ao escopo da funcao.
	Local LinhaCorrente
	Local aPart := {}
	Local nX, nZ
	Local lImpr := .F.
	Local nLinhasMemo
	Local nLinIniPart := 50

	// Variaveis pertencentes apenas ao escopo da funcao e suas subfuncoes
	Private oFont16, oFont14, oFont12, oFont11, oFont10, oFont09
	Private oPrint := FWMSPrinter():New( OemToAnsi(STR0021),,.T. ) // "Agenda de Reuniões"
	Private lin := 3200
	Private lFim := .F.
	Private lPriReu := .T. //Serve para verificar se eh a primeira reuniao a ser impressa de um determinado mandato
	Private cStartPath := AllTrim(GetSrvProfString("Startpath",""))

	If Substr(cStartPath,Len(cStartPath),1) <> "\"
		cStartPath := cStartPath+"\"
	Endif

	oPrint:SetPortrait()

	oFont09	 := TFont():New("Verdana",,10,,.F.,,,,.F.,.F.)
	oFont10  := TFont():New("Verdana",,12,,.F.,,,,.F.,.F.)
	oFont11  := TFont():New("Verdana",,12,,.F.,,,,.F.,.F.)
	oFont12  := TFont():New("Verdana",,14,,.F.,,,,.F.,.F.)
	oFont12n := TFont():New("Verdana",,14,,.T.,,,,.T.,.F.)
	oFont14	 := TFont():New("Verdana",,16,,.F.,,,,.F.,.F.)
	oFont16  := TFont():New("Verdana",,18,,.T.,,,,.T.,.F.)

	If lSigaMdtps

		dbSelectArea("TNR")
		dbSetOrder(02)  //TNR_FILIAL+TNR_CLIENT+TNR_LOJA+TNR_MANDAT+DTOS(TNR_DTREUN)+TNR_HRREUN
		dbSeek(xFilial("TNR")+MV_PAR01+MV_PAR02,.T.)

		//Seleciona os registros e os imprime
		While !Eof() .And. TNR->TNR_FILIAL == xFilial("TNR") .And.;
			TNR->(TNR_CLIENT+TNR_LOJA) >= mv_par01+mv_par02 .And. TNR->(TNR_CLIENT+TNR_LOJA) <= mv_par03+mv_par04


			If !( TNR->TNR_MANDATO >= MV_PAR05 .And. TNR->TNR_MANDATO <= MV_PAR06 )
				dbSelectArea("TNR")
				dbSkip()
				Loop
			Endif

			If TNR->TNR_DTREUN < MV_PAR07 .Or. TNR->TNR_DTREUN > MV_PAR08
				dbSelectArea("TNR")
				dbSkip()
				Loop
			Endif

			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+TNR->(TNR_CLIENT+TNR_LOJA))

			lin := 3200
			Somalinha(2,10) //Pula 1mm

			Somalinha(2,100)
			oPrint:Say(lin,200,STR0031,oFont12n) //"Cliente/Loja: "
			oPrint:Say(lin,600,SA1->A1_COD + "-" + SA1->A1_LOJA + " - " + SA1->A1_NOME ,oFont12)

			dbSelectArea("TNN")
			dbSetOrder(1)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
			dbSeek(xFilial("TNN")+TNR->TNR_CLIENT+TNR->TNR_LOJA+TNR->TNR_MANDATO)

			Somalinha(2,100)
			oPrint:Say(lin,200,STR0022,oFont12n) //"Mandato: "
			If Empty(TNN->TNN_DESCRI)
				oPrint:Say(lin,600, TNR->TNR_MANDATO ,oFont12)
			Else
				oPrint:Say(lin,600, TNR->TNR_MANDATO + " - " + TNN->TNN_DESCRI ,oFont12)
			Endif

			Somalinha(2,70)
			oPrint:Say(lin,200,STR0023,oFont12n) //"Data da Reunião:"
			If Empty(TNR->TNR_DTREAL)
				oPrint:Say(lin,600, DTOC(TNR->TNR_DTREUN) ,oFont12)
			Else
				oPrint:Say(lin,600, DTOC(TNR->TNR_DTREAL) ,oFont12)
			Endif
			oPrint:Say(lin,900,STR0024,oFont12n) //"Horário:"
			If Empty(TNR->TNR_HRREAL)
				oPrint:Say(lin,1100, TNR->TNR_HRREUN ,oFont12)
			Else
				oPrint:Say(lin,1100, TNR->TNR_HRREAL ,oFont12)
			Endif
			Somalinha(2,70)
			oPrint:Say(lin,200,STR0025,oFont12n) //"Reunião:"
			oPrint:Say(lin,600,STR0026,oFont12) //"Ordinária"
			oPrint:Box(lin,800,lin+40,840)
			oPrint:Say(lin,900,STR0027,oFont12) //"Extraordinária"
			oPrint:Box(lin,1200,lin+40,1240)
			If TNR->TNR_TIPREU == "1"
				oPrint:Line(lin,800,lin+40,840)
				oPrint:Line(lin+1,800,lin+39,840)
				oPrint:Line(lin,840,lin+40,800)
				oPrint:Line(lin+1,840,lin+39,800)
			Else
				oPrint:Line(lin,1200,lin+40,1240)
				oPrint:Line(lin,1240,lin+40,1200)
				oPrint:Line(lin+1,1200,lin+39,1240)
				oPrint:Line(lin+1,1240,lin+39,1200)
			Endif

			lImpr := .T.

			Somalinha(2,70)
			oPrint:Say(lin,200,STR0028,oFont12n) //"Assunto:"
			oPrint:Say(lin,600, TNR->TNR_ASSUNT ,oFont12)

			//-------------------------------------//
			//Imprime ATA                          //
			//-------------------------------------//
			If mv_par09 == 1  .And. !Empty(TNR->TNR_ATA)
				Somalinha(2,90)
				nLinhasMemo := MLCOUNT(Trim(TNR->TNR_ATA), 100)
				If lin+300 > 3200
					lin := 3200
					SomaLinha(2,100)
				Endif
				For LinhaCorrente := 1 to nLinhasMemo
					If LinhaCorrente == 1
						oPrint:Line(lin,205,lin,2295)
						oPrint:Line(lin+5,200,lin+100,200)
						oPrint:Line(lin+5,2300,lin+100,2300)
						oPrint:Line(lin+5,200,lin,205)
						oPrint:Line(lin+5,2300,lin,2295)
						oPrint:Line(lin+100,200,lin+100,2300)
						oPrint:Say(lin+30,1070,STR0029,oFont14) //"Ata da Reunião"
						Somalinha(2,100)
					Endif
					SomaLinha(2,50,.T.)
					oPrint:Say(lin+20,280,MemoLine(TNR->TNR_ATA,100,LinhaCorrente),oFont11)
					If LinhaCorrente == nLinhasMemo
						SomaLinha(2,70,.T.)
						oPrint:Line(lin,200,lin,2300)
					Endif
				Next LinhaCorrente
				SomaLinha(2,50)
			Endif

			Somalinha(2,50)

			aPart := {}
			dbSelectArea("TNS")
			dbSetOrder(3)  //TNS_FILIAL+TNS_CLIENT+TNS_LOJA+TNS_MANDAT+DTOS(TNS_DTREUN)+TNS_HRREUN+TNS_M.........
			dbSeek(xfilial("TNS")+TNR->TNR_CLIENT+TNR->TNR_LOJA+TNR->TNR_MANDATO+DTOS(TNR->TNR_DTREUN)+TNR->TNR_HRREUN)

			//Imprime somente as matriculas e os nomes dos participantes da reuniao
			While !Eof() 							    .And.;
				TNR->TNR_MANDATO == TNS->TNS_MANDATO .And.;
				TNR->TNR_DTREUN  == TNS->TNS_DTREUN  .And.;
				TNR->TNR_HRREUN  == TNS->TNS_HRREUN  .And.;
				TNR->(TNR_CLIENT+TNR_LOJA) == TNS->(TNS_CLIENT+TNS_LOJA)

				If TNS->TNS_PRESEN == "1" .Or. Empty(TNS->TNS_PRESEN)
					cFilTmp := cFilAnt
					If !Empty(TNS->TNS_FILMAT)
						cFilTmp := TNS->TNS_FILMAT
					Endif
					dbSelectArea("SRA")
					dbSetOrder(01)
					dbSeek(xFilial("SRA",cFilTmp)+TNS->TNS_MAT)
					If SRA->RA_SITFOLH == "D" .Or. !EMPTY(SRA->RA_DEMISSA)
						If SRA->RA_DEMISSA < TNR->TNR_DTREAL
							dbSelectArea("TNS")
							dbSkip()
							loop
						Endif
					Endif
					If !Empty(TNS->TNS_MAT)
						AADD(aPart, {TNS->TNS_MAT, Substr(SRA->RA_NOME,1,35) } )
					ElseIf !Empty(TNS->TNS_NOMPAR)
						AADD(aPart, {TNS->TNS_MAT, Substr(TNS->TNS_NOMPAR,1,35)} )
					EndIf
				Else
					DbSelectArea(cAliasTRB)
					DbSetOrder(1)
					If Empty(TNS->TNS_MAT)
						If !DbSeek(TNS->TNS_PRESEN+TNS->TNS_NOMPAR)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MAT    := TNS->TNS_MAT
							(cAliasTRB)->PRESEN := TNS->TNS_PRESEN
							If Empty(TNS->TNS_MAT)
								( cAliasTRB )->NOME := TNS->TNS_NOMPAR
							Else
								dbSelectArea( 'SRA' )
								dbSetOrder( 01 )
								dbSeek( xFilial( 'SRA', TNS->TNS_FILMAT ) + TNS->TNS_MAT )
								( cAliasTRB )->NOME := SRA->RA_NOME
							EndIf
						EndIf
					ElseIf !Empty(TNS->TNS_MAT)
						If !DbSeek(TNS->TNS_PRESEN+TNS->TNS_MAT)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MAT    := TNS->TNS_MAT
							(cAliasTRB)->PRESEN := TNS->TNS_PRESEN
							If Empty(TNS->TNS_MAT)
								( cAliasTRB )->NOME := TNS->TNS_NOMPAR
							Else
								dbSelectArea( 'SRA' )
								dbSetOrder( 01 )
								dbSeek( xFilial( 'SRA', TNS->TNS_FILMAT ) + TNS->TNS_MAT )
								( cAliasTRB )->NOME := SRA->RA_NOME
							EndIf
						EndIf
					EndIf
					MsUnlock(cAliasTRB)
				EndIf

				dbSelectArea("TNS")
				dbSkip()
			End

			Somalinha(2,60)

			If (lin+250)  > 3200
				lin := 3200
				SomaLinha(2,100)
			Endif

			// Imprime Participantes
			If Len(aPart) > 0 .Or. (cAliasTRB)->(RecCount()) > 0
				oPrint:Line(lin,205,lin,2295)
				oPrint:Line(lin+5,200,lin+100,200)
				oPrint:Line(lin+5,2300,lin+100,2300)
				oPrint:Line(lin+5,200,lin,205)
				oPrint:Line(lin+5,2300,lin,2295)

				oPrint:Line(lin+100,200,lin+100,2300)
				oPrint:Say(lin+30,1100,STR0019,oFont14)  //"Participantes"
				Somalinha(2,40)
			EndIf

			For nX := 1 To Len(aPart)
				Somalinha(2,80,.T.)
				If Empty(aPart[nX][1])
					oPrint:Say(lin,230,STR0050,oFont11)
					oPrint:Say(lin,390,"- ",oFont11)
					oPrint:Say(lin,430,aPart[nX][2],oFont11)
					oPrint:Say(lin,1350,STR0030,oFont11) //"Ass.:_____________________________________"
				else
					oPrint:Say(lin,230,aPart[nX][1],oFont11)
					oPrint:Say(lin,390,"- ",oFont11)
					oPrint:Say(lin,430,aPart[nX][2],oFont11)
					oPrint:Say(lin,1350,STR0030,oFont11) //"Ass.:_____________________________________"
				EndIf
			Next nX

			If mv_par11 == 2
				DbSelectArea(cAliasTRB)
				DbGoTop()
				If RecCount() > 0
					SetRegua(LastRec())
					While !EOF()

						IncRegua()
						Somalinha(2,80,.T.)
						If !Empty((cAliasTRB)->MAT) .And. !Empty((cAliasTRB)->NOME)
							oPrint:Say(lin,230,(cAliasTRB)->MAT,oFont11)
						Else
							oPrint:Say(lin,230,STR0050,oFont11)
						EndIf
						oPrint:Say(lin,390,"- ",oFont11)
						oPrint:Say(lin,430,(cAliasTRB)->NOME,oFont11)

						If mv_par12 == 2
							If (cAliasTRB)->PRESEN == "2" .And. !Empty((cAliasTRB)->NOME)
								oPrint:Say(lin,1350,STR0047,oFont11) //"Falta Justificada"
							ElseIf (cAliasTRB)->PRESEN == "3"
								oPrint:Say(lin,1350,STR0048,oFont11) //"Falta Nao Justificada"
							EndIf
						Else
							oPrint:Say(lin,1350,STR0049,oFont11) //"Não Compareceu"
						EndIf

						DbSelectArea(cAliasTRB)
						DbSkip()
					End
				EndIf
			EndIf

			If Len(aPart) > 0 .Or. (cAliasTRB)->(RecCount()) > 0
				SomaLinha(2,80,.T.)
				oPrint:Line(lin,200,lin,2300)
			Endif

			DbSelectArea(cAliasTRB)
			Zap

			dbSelectArea("TNR")
			dbSkip()
		EndDo

	Else
		dbSelectArea("TNR")
		dbSetOrder(01)
		dbSeek(xFilial("TNR")+MV_PAR01,.T.)

		//Seleciona os registros e os imprime
		While !Eof() .And. TNR->TNR_FILIAL == xFilial("TNR") .And. TNR->TNR_MANDATO >= MV_PAR01 .And. TNR->TNR_MANDATO <= MV_PAR02

			If TNR->TNR_DTREUN < MV_PAR03 .Or. TNR->TNR_DTREUN > MV_PAR04
				dbSelectArea("TNR")
				dbSkip()
				Loop
			Endif

			lin := 3200
			Somalinha(2,05,,,.F.) //Pula 1mm

			dbSelectArea("TNN")
			dbSetOrder(1)
			dbSeek(xFilial("TNN")+TNR->TNR_MANDATO)

			//Somalinha(2,05)
			oPrint:Say(lin,200,STR0022,oFont12n) //"Mandato: "
			If Empty(TNN->TNN_DESCRI)
				oPrint:Say(lin,410, TNR->TNR_MANDATO ,oFont12)
			Else
				oPrint:Say(lin,410, Alltrim(TNR->TNR_MANDATO) + " - " + TNN->TNN_DESCRI ,oFont12)
			Endif

			Somalinha(2,70)
			oPrint:Say(lin,200,STR0023,oFont12n) //"Data da Reunião:"
			If Empty(TNR->TNR_DTREAL)
				oPrint:Say(lin,620, DTOC(TNR->TNR_DTREUN) ,oFont12)
			Else
				oPrint:Say(lin,620, DTOC(TNR->TNR_DTREAL) ,oFont12)
			Endif
			oPrint:Say(lin,900,STR0024,oFont12n) //"Horário:"
			If Empty(TNR->TNR_HRREAL)
				oPrint:Say(lin,1110, TNR->TNR_HRREUN ,oFont12)
			Else
				oPrint:Say(lin,1110, TNR->TNR_HRREAL ,oFont12)
			Endif
			Somalinha(2,70)
			oPrint:Say(lin,200,STR0025,oFont12n) //"Reunião:"
			oPrint:Say(lin,412,STR0026,oFont12) //"Ordinária"
			oPrint:Box(lin-25,658,lin+15,698)
			oPrint:Say(lin,740,STR0027,oFont12) //"Extraordinária"
			oPrint:Box(lin-25,1120,lin+15,1160)
			If TNR->TNR_TIPREU == "1"
				oPrint:Line(lin-25,658,lin+15,698)
				oPrint:Line(lin+15,658,lin-25,698)
			Else
				oPrint:Line(lin-25,1120,lin+15,1160)
				oPrint:Line(lin+15,1120,lin-25,1160)
			Endif

			lImpr := .T.
			Somalinha(2,70)
			oPrint:Say(lin,200,STR0028,oFont12n) //"Assunto:"
			oPrint:Say(lin,415, TNR->TNR_ASSUNT ,oFont12)

			// Imprime ATA
			If mv_par05 == 1  .And. !Empty(TNR->TNR_ATA)
				Somalinha(2,90)
				nLinhasMemo := MLCOUNT(Trim(TNR->TNR_ATA), 95) //Valor total de linhas do texto

				If lin+300 > 3200
					lin := 3200
					SomaLinha(2,100)
				Endif

				oPrint:Box(lin-20,195,lin+120,2105)
				oPrint:SayAlign(lin,205,STR0029,oFont14, 1900 , 100 , , 2/*Centralizado Horizontal*/ , 0/*Centralizado Vertical*/ ) //"Ata da Reunião"

				//oPrint:Box(lin+150,195,lin+2100,2105)
				SomaLinha(2,150,.T.)
				For nX := 1 to nLinhasMemo

					cAt := Memoline( TNR->TNR_ATA , 95 , nX )
					SomaLinha( 2, 50, .T. )

					// Verifica se o texto a ser impresso tem tamanho maior do que 75% do tamanho máximo da linha
					If Len( AllTrim( cAt ) ) > 50
						oPrint:Say(lin+20,225, AV_Justifica( cAt ), oFont11)
					Else // Não justifica para não fazer espaçamentos grandes demais entre as palavras
						oPrint:Say(lin+20,225, cAt , oFont11)
					EndIf

					//oPrint:Say(lin+20,225, AV_Justifica( Alltrim( cAt ) ), oFont11)

				Next nX

			Endif

			Somalinha(2,90,.T.,.T.)
			aPart := {}
			dbSelectArea("TNS")
			dbSetOrder(1)
			dbSeek(xfilial("TNS")+TNR->TNR_MANDATO+DTOS(TNR->TNR_DTREUN)+TNR->TNR_HRREUN)

			//Imprime somente as matriculas e os nomes dos participantes da reuniao
			While !Eof() 							 .And.;
				TNR->TNR_MANDATO == TNS->TNS_MANDATO .And.;
				TNR->TNR_DTREUN  == TNS->TNS_DTREUN  .And.;
				TNR->TNR_HRREUN  == TNS->TNS_HRREUN

				If TNS->TNS_PRESEN == "1" .Or. Empty(TNS->TNS_PRESEN)
					cFilTmp := cFilAnt
					If !Empty(TNS->TNS_FILMAT)
						cFilTmp := TNS->TNS_FILMAT
					Endif
					dbSelectArea("SRA")
					dbSetOrder(01)
					dbSeek(xFilial("SRA",cFilTmp)+TNS->TNS_MAT)
					If SRA->RA_SITFOLH == "D" .Or. !EMPTY(SRA->RA_DEMISSA)
						If SRA->RA_DEMISSA < TNR->TNR_DTREAL
							dbSelectArea("TNS")
							dbSkip()
							loop
						Endif
					Endif
					If !Empty(TNS->TNS_MAT)
						AADD(aPart, {TNS->TNS_MAT, Substr(SRA->RA_NOME,1,35) } )
					ElseIf !Empty(TNS->TNS_NOMPAR)
						AADD(aPart, {TNS->TNS_MAT, Substr(TNS->TNS_NOMPAR,1,35)} )
					EndIf
				Else
					DbSelectArea(cAliasTRB)
					DbSetOrder(1)
					If Empty(TNS->TNS_MAT)
						If !DbSeek(TNS->TNS_PRESEN+TNS->TNS_NOMPAR)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MAT    := TNS->TNS_MAT
							(cAliasTRB)->PRESEN := TNS->TNS_PRESEN
							If Empty(TNS->TNS_MAT)
								( cAliasTRB )->NOME := TNS->TNS_NOMPAR
							Else
								dbSelectArea( 'SRA' )
								dbSetOrder( 01 )
								dbSeek( xFilial( 'SRA', TNS->TNS_FILMAT ) + TNS->TNS_MAT )
								( cAliasTRB )->NOME := SRA->RA_NOME
							EndIf
						EndIf
					ElseIf !Empty(TNS->TNS_MAT)
						If !DbSeek(TNS->TNS_PRESEN+TNS->TNS_MAT)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MAT    := TNS->TNS_MAT
							(cAliasTRB)->PRESEN := TNS->TNS_PRESEN
							If Empty(TNS->TNS_MAT)
								( cAliasTRB )->NOME := TNS->TNS_NOMPAR
							Else

								dbSelectArea( 'SRA' )
								dbSetOrder( 01 )

								If dbSeek( xFilial( 'SRA', TNS->TNS_FILMAT ) + TNS->TNS_MAT )

								( cAliasTRB )->NOME := SRA->RA_NOME

								EndIf

							EndIf
						EndIf
					EndIf


					MsUnlock(cAliasTRB)
				EndIf
				dbSelectArea("TNS")
				dbSkip()
			End

			Somalinha(2,150)

			If (lin+250)  > 3200
				lin := 3200
				SomaLinha(2,100)
			Endif

			//Imprime Participantes
			If Len(aPart) > 0 .Or. (cAliasTRB)->(RecCount()) > 0
				oPrint:Box(lin-50,195,lin+90,2105)
				oPrint:Say(lin+35,950,STR0019,oFont14)  //"Participantes"
				Somalinha(2,130,.T.)
			EndIf

			For nX := 1 To Len(aPart)
				Somalinha(2,65,.T.)
				If Empty(aPart[nX][1])
					oPrint:Say(lin,230,STR0050,oFont11)
					oPrint:Say(lin,390,"- ",oFont11)
					oPrint:Say(lin,430,aPart[nX][2],oFont11)
					oPrint:Say(lin,1120,STR0030,oFont11) //"Ass.:_____________________________________"
				else
					oPrint:Say(lin,230,aPart[nX][1],oFont11)
					oPrint:Say(lin,390,"- ",oFont11)
					oPrint:Say(lin,430,aPart[nX][2],oFont11)
					oPrint:Say(lin,1120,STR0030,oFont11) //"Ass.:_____________________________________"
				EndIf
				If nX == Len(aPart)
					Somalinha(2,30,.T.,.T.)
				EndIf
			Next nX

			If mv_par07 == 2
				Somalinha(2,80,.T.,.T.)
				DbSelectArea(cAliasTRB)
				DbGoTop()
				If RecCount() > 0
					SetRegua(LastRec())
					While !EOF()

						IncRegua()
						Somalinha(2,80)
						If !Empty((cAliasTRB)->MAT) .And. !Empty((cAliasTRB)->NOME)
							oPrint:Say(lin,230,(cAliasTRB)->MAT,oFont11)
						Else
							oPrint:Say(lin,230,STR0050,oFont11)
						EndIf
						oPrint:Say(lin,390,"- ",oFont11)
						oPrint:Say(lin,430,(cAliasTRB)->NOME,oFont11)

						If mv_par08 == 2
							If (cAliasTRB)->PRESEN == "2" .And. !Empty((cAliasTRB)->NOME)
								oPrint:Say(lin,1350,STR0047,oFont11) //"Falta Justificada"
							ElseIf (cAliasTRB)->PRESEN == "3"
								oPrint:Say(lin,1350,STR0048,oFont11) //"Falta Nao Justificada"
							EndIf
						Else
							oPrint:Say(lin,1350,STR0049,oFont11) //"Não Compareceu"
						EndIf

						DbSelectArea(cAliasTRB)
						DbSkip()
					End
				EndIf
			EndIf

			/*If Len(aPart) > 0 .Or. (cAliasTRB)->(RecCount()) > 0
				SomaLinha(2,80)
			Endif*/

			DbSelectArea(cAliasTRB)
			Zap

			dbSelectArea("TNR")
			dbSkip()
		EndDo

	Endif

	RetIndex("TNR")
	Set Filter To
	Set device to Screen

	If !lImpr
		MsgInfo(STR0035)  //"Não há nada para imprimir no relatório."
		Return Nil
	Endif

	If aReturn[5] == 1
		oPrint:Preview()
	Else
		oPrint:Print()
	Endif

Return NIL
