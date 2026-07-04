/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr842.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR842
Relatorio dos Planos de Acoes por Mandato.

@author Thiago Machado
@since 15.08.01
@return Nil
/*/
//---------------------------------------------------------------------
User Function MDTR842()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local wnrel   := "MDTR842"
	Local limite  := 132
	Local cDesc1  := STR0001 // "Relatório do Plano de Acão por Mandato."
	Local cDesc2  := STR0002 // "O Relatório mostra as acões definidas em conjunto pelos integrantes"
	Local cDesc3  := STR0003 // "do mandato."
	Local cString := "TNN"
	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	Private nomeprog := "MDTR842"
	Private tamanho  := "M"
	Private aReturn  := {STR0004, 1,STR0005, 2, 2, 1, "",1 }  //"Zebrado"###"Administracão"
	Private titulo   := STR0006 //"Plano de Acão por Mandato"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := ""
	Private cabec1, cabec2
	Private cAliasTRB:= GetNextAlias()

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	cPerg      := If(!lSigaMdtPS,"MDT842    ","MDT842PS  ")

	SG90PLACAO() // Adequação do Plano de Ação.

	/*-------------------------------------
	//PERGUNTAS PADRÃO					|
	| MDT842    ¦01      ¦De  Mandato ?	|
	| MDT842    ¦02      ¦Ate Mandato ?	|
	| MDT842    ¦03      ¦Acoes ?		|
	| 									|
	//PERGUNTAS DO PRESTADOR DE SERVIÇO	|
	| 		   01       De Cliente ?	|
	| 		   02       Loja			|
	| 		   03       Até Cliente ?	|
	| 		   04       Loja			|
	| MDT842    ¦05      ¦De  Mandato ?	|
	| MDT842    ¦06      ¦Ate Mandato ?	|
	| MDT842    ¦07      ¦Acoes ?		|
	---------------------------------------*/

	// Verifica as perguntas selecionadas
	pergunte(cPerg,.F.)

	// Envia controle para a funcao SETPRINT
	wnrel := "MDTR842"

	wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
			// Devolve variaveis armazenadas (NGRIGHTCLICK)
			NGRETURNPRM(aNGBEGINPRM)
		Return
	EndIf

	SetDefault(aReturn,cString)
	RptStatus({|lEnd| R842Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} R842Imp
Chama Relatório.

@param lEnd - Cancela a impressão.
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho do relatório.

@author Thiago Machado
@since 05/09/2000
@return
/*/
//---------------------------------------------------------------------
Static Function R842Imp(lEnd,wnRel,titulo,tamanho)

	// Define Variaveis
	LOCAL cRodaTxt := ""
	LOCAL nCntImpr := 0
	Local nTamPlano := Len( (cAliasPA)->&(aFieldPA[2]) )
	LOCAL cCliente := ""
	LOCAL lPri := .T.
	Local oTempTRB

	// Variaveis para controle do cursor de progressao do relatorio
	LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

	// Variaveis locais exclusivas deste programa

	LOCAL lContinua        := .T.

	// Contadores de linha e pagina
	PRIVATE li := 80 ,m_pag := 1

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	// Monta os Cabecalhos

	cabec1 := STR0007 //"Mandato     Descricão                                 Início      Término      Data Eleicão"
	cabec2 := STR0008 //"    Plano     Nome do Plano de Acão                    Dt. Implant.   Inic. Prev.  Fim Prev.  Inic. Real.  Fim Real.   Responsável"

	/*
	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04         <Plano de Acao por Risco>                                                                DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************
			1         2         3         4         5         6         7         8         9        10        11        12        13
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Mandato     Descricão                                 Início      Término      Data Eleicão
		Plano     Nome do Plano de Acão                    Dt. Implant.   Inic. Prev.  Fim Prev.  Inic. Real.  Fim Real.   Responsável
	XXXXXX      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999  99/99/9999   99/99/9999
		XXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/99/9999     99/99/9999   99/99/9999 99/99/9999   99/99/9999  999
				O QUE.: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				ONDE..: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				PORQUE: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				COMO..: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				Quando: Inic. Previsto.:  99/99/9999    Real.:  99/99/9999
						Fim Previsto...:  99/99/9999    Real.:  99/99/9999
				Quanto: Valor Previsto.: 9999.999,99    Real.: 9999.999,99
						Qtde Atual.....:   99.999,99    Real.:   99.999,99    Meta.:  99.999,99

	===============================================================================================================================================

	*/

	aDBF := {}
	If lSigaMDTPs
		AADD(aDBF,{ "CLIENT"  , "C" ,nTa1 , 0 })
		AADD(aDBF,{ "LOJA"    , "C" ,nTa1L, 0 })
		AADD(aDBF,{ "NOMECLI" , "C" ,40, 0 })
	EndIf
	AADD(aDBF,{ "MANDATO" , "C" ,06, 0 })
	AADD(aDBF,{ "DESCRI"  , "C" ,40, 0 })
	AADD(aDBF,{ "INICIO"  , "D" ,08, 0 })
	AADD(aDBF,{ "TERMINO" , "D" ,08, 0 })
	AADD(aDBF,{ "DTELEIC" , "D" ,08, 0 })
	AADD(aDBF,{ "PLANO"   , "C" ,nTamPlano, 0 })
	AADD(aDBF,{ "NOMPLA"  , "C" ,40, 0 })
	AADD(aDBF,{ "DTIMPLA" , "D" ,08, 0 })
	AADD(aDBF,{ "INICPREV", "D" ,08, 0 })
	AADD(aDBF,{ "FIM"     , "D" ,08, 0 })
	AADD(aDBF,{ "INIREAL" , "D" ,08, 0 })
	AADD(aDBF,{ "FIMREAL" , "D" ,08, 0 })
	AADD(aDBF,{ "RESP"    , "C" ,12, 0 })

	If lSigaMdtps

		oTempTRB := FWTemporaryTable():New( cAliasTRB, aDBF )
		oTempTRB:AddIndex( "1", {"CLIENT","LOJA","MANDATO","PLANO"} )
		oTempTRB:Create()

		dbSelectArea("TNN")
		dbSetOrder(03)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJACC+TNN_MANDAT
		dbSeek(xFilial("TNN")+MV_PAR01+MV_PAR02,.T.)

		SetRegua(LastRec())

			// Correr TNT para ler o Plano de Acao por Acidente
			While !EoF()                            .AND.;
			TNN->TNN_FILIAL == xFilial('TNN') .AND.;
			TNN->(TNN_CLIENT+TNN_LOJAC) >= MV_PAR01+MV_PAR02 .AND. TNN->(TNN_CLIENT+TNN_LOJAC) <= MV_PAR03+MV_PAR04

			IF TNN->TNN_MANDAT < MV_PAR05 .OR. TNN->TNN_MANDAT > MV_PAR06
				dbSelectArea("TNN")
				dbSkip()
				Loop
			EndIf
			cCliente := TNN->(TNN_CLIENT+TNN_LOJAC)

			IncRegua()
			dbSelectArea("TNV")
			dbSetOrder(4)  //TNV_FILIAL+TNV_CLIENT+TNV_LOJA+TNV_MANDAT+TNV_CODPLA
			IF dbSeek(xfilial("TNV")+cCliente+TNN->TNN_MANDAT)

				DO WHILE !EoF().and. xfilial("TNV") == TNV->TNV_FILIAL .AND. TNV->TNV_MANDAT == TNN->TNN_MANDAT .AND. cCliente == TNV->(TNV_CLIENT+TNV_LOJA)

					dbSelectArea( cAliasPA )
					dbSetOrder( nIndexPA )  //TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_CODPLA
					IF dbSeek(xfilial( cAliasPA )+cCliente+TNV->TNV_CODPLA)

						DO WHILE !EoF().and. xfilial( cAliasPA ) == (cAliasPA)->&(aFieldPA[1]) .AND.;
								(cAliasPA)->&(aFieldPA[2]) == TNV->TNV_CODPLA .and. cCliente == (cAliasPA)->(&(cClientePA)+&(cLojaPA))

							If !Empty((cAliasPA)->&(aFieldPA[8])) .AND. MV_PAR07 = 2
								dbSelectArea(cAliasPA)
								dbSKIP()
								loop
							EndIf

							If Empty((cAliasPA)->&(aFieldPA[9])) .AND. MV_PAR07 = 3
								dbSelectArea( cAliasPA )
								dbSKIP()
								loop
							EndIf

							dbSelectArea(cAliasTRB)
							DbSetOrder(1)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->CLIENT   := TNN->TNN_CLIENT
							(cAliasTRB)->LOJA 	 := TNN->TNN_LOJAC
							(cAliasTRB)->NOMECLI  := NGSEEK("SA1",cCliente,1,"SA1->A1_NOME")
							(cAliasTRB)->MANDATO  := TNN->TNN_MANDAT
							(cAliasTRB)->DESCRI   := TNN->TNN_DESCRI
							(cAliasTRB)->INICIO   := TNN->TNN_DTINIC
							(cAliasTRB)->TERMINO  := TNN->TNN_DTTERM
							(cAliasTRB)->DTELEIC  := TNN->TNN_ELEICA
							(cAliasTRB)->PLANO    := (cAliasPA)->&(aFieldPA[2])
							(cAliasTRB)->NOMPLA   := (cAliasPA)->&(aFieldPA[3])
							(cAliasTRB)->DTIMPLA  := (cAliasPA)->&(aFieldPA[4])
							(cAliasTRB)->INICPREV := (cAliasPA)->&(aFieldPA[6])
							(cAliasTRB)->FIM      := (cAliasPA)->&(aFieldPA[7])
							(cAliasTRB)->INIREAL  := (cAliasPA)->&(aFieldPA[8])
							(cAliasTRB)->FIMREAL  := (cAliasPA)->&(aFieldPA[9])
							(cAliasTRB)->RESP     := (cAliasPA)->&(aFieldPA[11])
							MsUnlock(cAliasTRB)
							dbSelectArea( cAliasPA )
							dbSKIP()
						EndDo
					EndIf
					dbSelectArea("TNV")
					dbSKIP()
				EndDo
			EndIf

			dbSelectArea("TNN")
			dbSKIP()
		End

		dbSelectArea(cAliasTRB)
		dbGOTOP()

		SomaLinha()
		SomaLinha()

		cCliente := ""

		While !EoF()
		/*
			1         2         3         4         5         6         7         8         9        10        11        12        13
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Mandato     Descricão                                 Início      Término      Data Eleicão
		Plano     Nome do Plano de Acão                    Dt. Implant.   Inic. Prev.  Fim Prev.  Inic. Real.  Fim Real.   Responsável

		*/

			If cCliente <> (cAliasTRB)->CLIENT+(cAliasTRB)->LOJA
				If !lPri
					@Li,000 PSAY Replicate("-",132)
					SomaLinha()
				EndIf
				lPri := .F.
				cCliente := (cAliasTRB)->CLIENT+(cAliasTRB)->LOJA
				@Li,000 PSAY STR0023 + (cAliasTRB)->CLIENT + "-" + (cAliasTRB)->LOJA + " - " + (cAliasTRB)->NOMECLI PICTURE "@!" //"Cliente/Loja: "
			EndIf

			cMandato := (cAliasTRB)->MANDATO
			Somalinha()
			Somalinha()
			@Li,000 PSAY (cAliasTRB)->MANDATO
			@Li,012 PSAY (cAliasTRB)->DESCRI
			@Li,054 PSAY (cAliasTRB)->INICIO
			@Li,066 PSAY (cAliasTRB)->TERMINO
			@Li,079 PSAY (cAliasTRB)->DTELEIC

			Do while ! EoF() .and. (cAliasTRB)->MANDATO == cMandato .and. (cAliasTRB)->CLIENT+(cAliasTRB)->LOJA == cCliente
				Somalinha()
				@Li,004 PSAY (cAliasTRB)->PLANO PICTURE "@!"
				@Li,014 PSAY (cAliasTRB)->NOMPLA PICTURE "@!"
				@Li,055 PSAY (cAliasTRB)->DTIMPLA PICTURE "99/99/9999"
				@Li,070 PSAY (cAliasTRB)->INICPREV PICTURE "99/99/9999"
				@Li,083 PSAY (cAliasTRB)->FIM PICTURE "99/99/9999"
				@Li,094 PSAY (cAliasTRB)->INIREAL PICTURE "99/99/9999"
				@Li,107 PSAY (cAliasTRB)->FIMREAL PICTURE "99/99/9999"
				@Li,119 PSAY (cAliasTRB)->RESP PICTURE "@!"

				dbSelectArea( cAliasPA )
				dbSetOrder( nIndexPA )  //TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_CODPLA
				IF dbSEEK(xfilial( cAliasPA )+(cAliasTRB)->CLIENT+(cAliasTRB)->LOJA+(cAliasTRB)->PLANO)
					somalinha()
					@Li,014 PSAY STR0010 + ".: " +  (cAliasPA)->&(aFieldPA[10]) PICTURE "@!"  //"O que"
					somalinha()
					@Li,014 PSAY STR0011 + "..: " + (cAliasPA)->&(aFieldPA[12])PICTURE "@!"  //"Onde"
					somalinha()
					@Li,014 PSAY STR0012 + " " +    (cAliasPA)->&(aFieldPA[13]) PICTURE "@!"  //"Porque:"
					somalinha()
					@Li,014 PSAY STR0013 + "..: " + (cAliasPA)->&(aFieldPA[14]) PICTURE "@!"  //"Como"
					somalinha()
					@Li,014 PSAY STR0014 + ".:  " + dtoc((cAliasPA)->&(aFieldPA[6])) //"Quando: Inic.Previsto"
					@Li,054 PSAY STR0015 + ".:  " + dtoc((cAliasPA)->&(aFieldPA[8])) //"Real"
					somalinha()
					@Li,022 PSAY STR0016 + "...:  " + dtoc((cAliasPA)->&(aFieldPA[7])) //"Fim Previsto"
					@Li,054 PSAY STR0015 + ".:  " + dtoc((cAliasPA)->&(aFieldPA[9])) //"Real"
					somalinha()
					@Li,014 PSAY STR0017 + ".: " //"Quanto: Valor Previsto"
					@LI,039 PSAY (cAliasPA)->&(aFieldPA[15]) PICTURE "@E 9999,999.99"
					@Li,054 PSAY STR0015 + ".: " //"Real.: "
					@LI,061 PSAY (cAliasPA)->&(aFieldPA[16]) PICTURE "@E 9999,999.99"
					somalinha()
					@Li,022 PSAY STR0018 + "...: " //"Quant. Atual"
					@Li,041 PSAY (cAliasPA)->&(aFieldPA[17]) PICTURE "@E 99,999.99"
					@Li,054 PSAY STR0015 + ".: " //"Real"
					@Li,063 PSAY (cAliasPA)->&(aFieldPA[19]) PICTURE "@E 99,999.99"
					@Li,076 PSAY STR0019 + ".: " //"Meta"
					@Li,084 PSAY (cAliasPA)->&(aFieldPA[18]) PICTURE "@E 99,999.99"
				EndIf
				somalinha()
				somalinha()
				dbSelectArea(cAliasTRB)
				dbSKIP()
			EndDo
			nTotRegs++
		Enddo

	Else

		oTempTRB := FWTemporaryTable():New( cAliasTRB, aDBF )
		oTempTRB:AddIndex( "1", {"MANDATO","PLANO"} )
		oTempTRB:Create()

		dbSelectArea("TNN")
		dbSetOrder(01)
		dbSeek(xFilial("TNN")+MV_PAR01,.T.)

		SetRegua(LastRec())

			// Correr TNT para ler o Plano de Acao por Acidente

		While !EoF()                            .AND.;
			TNN->TNN_FILIAL == xFilial('TNN') .AND.;
			TNN->TNN_MANDAT <= MV_PAR02

			If lEnd
				@ PROW()+1,001 PSay STR0009 //"CANCELADO PELO OPERADOR"
				Exit
			EndIf

			IncRegua()
			dbSelectArea("TNV")
			dbSetOrder(1)
			IF dbSeek(xfilial("TNV")+TNN->TNN_MANDAT)

				DO WHILE !EoF().and. xfilial("TNV") == TNV->TNV_FILIAL .AND. TNV->TNV_MANDAT == TNN->TNN_MANDAT

					dbSelectArea( cAliasPA )
					dbSetOrder(1)
					IF dbSeek(xfilial( cAliasPA )+TNV->TNV_CODPLA)

						DO WHILE !EoF().and. xfilial( cAliasPA ) == (cAliasPA)->&(aFieldPA[1]) .AND. (cAliasPA)->&(aFieldPA[2]) == TNV->TNV_CODPLA

							If !Empty((cAliasPA)->&(aFieldPA[9])) .AND. MV_PAR03 = 2
								dbSelectArea( cAliasPA )
								dbSKIP()
								loop
							EndIf

							If Empty((cAliasPA)->&(aFieldPA[9])) .AND. MV_PAR03 = 3
								dbSelectArea( cAliasPA )
								dbSKIP()
								loop
							EndIf

							dbSelectArea(cAliasTRB)
							DbSetOrder(1)
							RecLock(cAliasTRB,.T.)
							(cAliasTRB)->MANDATO  := TNN->TNN_MANDAT
							(cAliasTRB)->DESCRI   := TNN->TNN_DESCRI
							(cAliasTRB)->INICIO   := TNN->TNN_DTINIC
							(cAliasTRB)->TERMINO  := TNN->TNN_DTTERM
							(cAliasTRB)->DTELEIC  := TNN->TNN_ELEICA
							(cAliasTRB)->PLANO    := (cAliasPA)->&(aFieldPA[2])
							(cAliasTRB)->NOMPLA   := (cAliasPA)->&(aFieldPA[3])
							(cAliasTRB)->DTIMPLA  := (cAliasPA)->&(aFieldPA[4])
							(cAliasTRB)->INICPREV := (cAliasPA)->&(aFieldPA[6])
							(cAliasTRB)->FIM      := (cAliasPA)->&(aFieldPA[7])
							(cAliasTRB)->INIREAL  := (cAliasPA)->&(aFieldPA[8])
							(cAliasTRB)->FIMREAL  := (cAliasPA)->&(aFieldPA[9])
							(cAliasTRB)->RESP     := (cAliasPA)->&(aFieldPA[11])
							MsUnlock(cAliasTRB)
							dbSelectArea( cAliasPA )
							dbSKIP()
						EndDo
					EndIf
					dbSelectArea("TNV")
					dbSKIP()
				EndDo
			EndIf
			dbSelectArea("TNN")
			dbSKIP()
		End
		dbSelectArea(cAliasTRB)
		dbGOTOP()

		While !EoF()
		/*
			1         2         3         4         5         6         7         8         9        10        11        12        13
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Mandato     Descricão                                 Início      Término      Data Eleicão
		Plano     Nome do Plano de Acão                    Dt. Implant.   Inic. Prev.  Fim Prev.  Inic. Real.  Fim Real.   Responsável

		*/
			cMandato := (cAliasTRB)->MANDATO
			Somalinha()
			Somalinha()
			@Li,000 PSAY (cAliasTRB)->MANDATO
			@Li,012 PSAY (cAliasTRB)->DESCRI
			@Li,054 PSAY (cAliasTRB)->INICIO
			@Li,066 PSAY (cAliasTRB)->TERMINO
			@Li,079 PSAY (cAliasTRB)->DTELEIC

			Do while ! EoF() .and. (cAliasTRB)->MANDATO == cMandato
				Somalinha()
				@Li,004 PSAY (cAliasTRB)->PLANO PICTURE "@!"
				@Li,014 PSAY (cAliasTRB)->NOMPLA PICTURE "@!"
				@Li,055 PSAY (cAliasTRB)->DTIMPLA PICTURE "99/99/9999"
				@Li,070 PSAY (cAliasTRB)->INICPREV PICTURE "99/99/9999"
				@Li,083 PSAY (cAliasTRB)->FIM PICTURE "99/99/9999"
				@Li,094 PSAY (cAliasTRB)->INIREAL PICTURE "99/99/9999"
				@Li,107 PSAY (cAliasTRB)->FIMREAL PICTURE "99/99/9999"
				@Li,119 PSAY (cAliasTRB)->RESP PICTURE "@!"
				dbSelectArea( cAliasPA )
				dbSetOrder(1)
				IF dbSEEK(xfilial( cAliasPA )+(cAliasTRB)->PLANO)
					somalinha()
					@Li,014 PSAY STR0010 + ".: " + (cAliasPA)->&(aFieldPA[10]) PICTURE "@!"  //"O que"
					somalinha()
					@Li,014 PSAY STR0011 + "..: " + (cAliasPA)->&(aFieldPA[12])PICTURE "@!"  //"Onde"
					somalinha()
					@Li,014 PSAY STR0012 + " " + (cAliasPA)->&(aFieldPA[13]) PICTURE "@!"  //"Porque:"
					somalinha()
					@Li,014 PSAY STR0013 + "..: " + (cAliasPA)->&(aFieldPA[14]) PICTURE "@!"  //"Como"
					somalinha()
					@Li,014 PSAY STR0014 + ".:  " + dtoc((cAliasPA)->&(aFieldPA[6])) //"Quando: Inic.Previsto"
					@Li,054 PSAY STR0015 + ".:  " + dtoc((cAliasPA)->&(aFieldPA[8])) //"Real"
					somalinha()
					@Li,022 PSAY STR0016 + "...:  " + dtoc((cAliasPA)->&(aFieldPA[7])) //"Fim Previsto"
					@Li,054 PSAY STR0015 + ".:  " + dtoc((cAliasPA)->&(aFieldPA[9])) //"Real"
					somalinha()
					@Li,014 PSAY STR0017 + ".: " //"Quanto: Valor Previsto"
					@LI,039 PSAY (cAliasPA)->&(aFieldPA[15]) PICTURE "@E 9999,999.99"
					@Li,054 PSAY STR0015 + ".: " //"Real.: "
					@LI,061 PSAY (cAliasPA)->&(aFieldPA[16]) PICTURE "@E 9999,999.99"
					somalinha()
					@Li,022 PSAY STR0018 + "...: " //"Quant. Atual"
					@Li,041 PSAY (cAliasPA)->&(aFieldPA[17]) PICTURE "@E 99,999.99"
					@Li,054 PSAY STR0015 + ".: " //"Real"
					@Li,063 PSAY (cAliasPA)->&(aFieldPA[19]) PICTURE "@E 99,999.99"
					@Li,076 PSAY STR0019 + ".: " //"Meta"
					@Li,084 PSAY (cAliasPA)->&(aFieldPA[18]) PICTURE "@E 99,999.99"
				EndIf
				somalinha()
				somalinha()
				dbSelectArea(cAliasTRB)
				dbSKIP()
			EndDo
			nTotRegs++
		EndDo
	EndIf

	Roda(nCntImpr,cRodaTxt,Tamanho)

	// Devolve a condicao original do arquivo principal
	RetIndex("TN0")

	Set Filter To

	Set device to Screen

	oTempTRB:Delete()

	// Verifica se existem dados a serem impressos
	If nTotRegs == 0
		MsgInfo(STR0027,STR0028) //"Não há dados para a montagem do relatório."###"ATENÇÃO"
		Return .F.
	EndIf

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf

	MS_FLUSH()

	dbSelectArea("TN0")
	dbSetOrder(01)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@author Thiago Machado
@since 05/09/2000
@return
/*/
//---------------------------------------------------------------------
Static Function Somalinha()
	Li++

	If Li > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)

		If Li > 9
			Li := Li - 1
		EndIf

	EndIf

Return