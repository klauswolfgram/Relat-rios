/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MDTR840.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR840  ³ Autor ³ Thiago Machado        ³ Data ³ 05.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio dos Planos de Acoes por Risco.                    ³±±
±±³          ³O usuario pode selecionar o risco e o periodo, obtendo assim³±±
±±³          ³a relacao das acoes previstas para controle dos riscos      ³±±
±±³          ³existentes na empresa.                                      ³±±
±±³          ³O programa inicia lendo a tabela de Risco x Plano de Acao.  ³±±
±±³          ³portanto s¢ ser  considerado os planos de acoes relacionados³±±
±±³          ³aos riscos.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MDTR840 void                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR840()
	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local wnrel   := "MDTR840"
	Local limite  := 220
	Local cDesc1  := STR0001 //"Relatorio do Plano de Acao por Risco.                              "
	Local cDesc2  := STR0002 //"O Relatorio mostra as acoes definidas para eliminar ou minimizar os   "
	Local cDesc3  := STR0003 //"riscos existentes na empresa.                                         "
	Local cString := "TNJ"

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )
	nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	nSizeTD := nTa1+nTa1L

	Private nomeprog := "MDTR840"
	Private tamanho  := "G"
	Private aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
	Private titulo   := STR0006 //"Plano de Acao por Risco "
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := ""
	Private cabec1, cabec2
	Private cFILELOGO := "NGLOGO.GIF"
	Private cCliMdtPs := ""
	Private aVetinr := {}

	cCliMdtPs := If(!lSigaMdtps,Space(nSizeTD),"Z")
	cPerg    :=  If(!lSigaMdtps,"MDT840    ","MDT840PS  ")

	SG90PLACAO()//Adequação do Plano de Ação.

	/*--------------------------------------------
	//PERGUNTASPADRÃO						    	|
	| MDT840    ¦01      ¦De  Risco ?				|
	| MDT840    ¦02      ¦Ate Risco ?				|
	| MDT840    ¦03      ¦De  Dt.Implan.Plano ?	    |
	| MDT840    ¦04      ¦Ate Dt.Implan.Plano ?	    |
	| MDT840    ¦05      ¦Acoes ?					|
	| MDT840    ¦06      ¦De Resp. Sesmt ?			|
	| MDT840    ¦07      ¦Ate Resp. Sesmt ?		    |
	| MDT840    ¦08      ¦De  Func. Resp ?			|
	| MDT840    ¦09      ¦Ate Func. Resp. ?		    |
	| MDT840    ¦10      ¦Agrupar ?					|
	| 												|
	//PERGUNTAS PRESTADOR DE SERVIÇO				|
	| 01       De Cliente ?							|
	| 02       Loja									|
	| 03       Até Cliente ?						|
	| 04       Loja									|
	| MDT840    ¦05      ¦De  Risco ?				|
	| MDT840    ¦06      ¦Ate Risco ?				|
	| MDT840    ¦07      ¦De  Dt.Implan.Plano ?	    |
	| MDT840    ¦08      ¦Ate Dt.Implan.Plano ?	    |
	| MDT840    ¦09      ¦Acoes ?					|
	| MDT840    ¦10      ¦De Resp. Sesmt ?			|
	| MDT840    ¦11      ¦Ate Resp. Sesmt ?		    |
	| MDT840    ¦12      ¦De  Func. Resp. ?		    |
	| MDT840    ¦13      ¦Ate Func. Resp. ?		    |
	| MDT840    ¦14      ¦Agrupar ?					|
	----------------------------------------------*/

	// Verifica as perguntas selecionadas
	pergunte(cPerg,.F.)

	// Envia controle para a funcao SETPRINT
	wnrel:="MDTR840"

	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to
		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
		Return
	EndIf


	RptStatus({|lEnd| R840Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R840Imp  ³ Autor ³ Thiago Machado        ³ Data ³05/09/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR840                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R840Imp(lEnd,wnRel,titulo,tamanho)

	// Define Variaveis
	//Local cRodaTxt := ""
	//Local nCntImpr := 0

	Local cCliente := ""
	Local lPri := .T.
	Local oTempTRB
	Local aTamSX3   := TAMSX3("TN0_QTAGEN")

	// Variaveis para controle do cursor de progressao do relatorio
	//Local nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0
	// Variaveis locais exclusivas deste programa
	//Local lContinua        := .T.

	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1
	Private lTop := .T.

	Private nSizeSI3 := TAMSX3("I3_CUSTO")[1]
	Private nSizeSRJ := TAMSX3("RJ_FUNCAO")[1]
	Private nSizeSQB := TAMSX3("QB_DEPTO")[1]
	Private nSizeTN0 := TAMSX3("TN0_CODAMB")[1]

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	// Monta os Cabecalhos

	/*
	*****************************************************************************************************************************************************************************************************************************
	*<empresa>                                                                                                                                                                                                 Folha..: xxxxx   *
	*SIGA /<nome .04                                                                          <Plano de Acao por Risco>                                                                                        DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                                                                                                         Emissao: dd/mm/aa*
	*****************************************************************************************************************************************************************************************************************************
			1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200       210       220
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
	Risco      Agente  Nome Agente                     Qtde       U.Med.  Dt.Recon    Dt.Aval     Dt.Elim     Fonte Geradora                  C.Custo               Funcao          Tarefa  Ambiente
		Plano     Nome do Plano de Acao                     Dt.Implant.  Inic.Prev.  Fim Prev.   Inic.Real   Fim Real    Responsavel
	_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
	xxxxxxxxx  xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxx,xxx  xxxxxx  xx/xx/xxxx  xx/xx/xxxx  xx/xx/xxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxx  xxxxxx  xxxxxx
		xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99/99/9999   99/99/9999  99/99/9999  99/99/9999  99/99/9999  xxxxxxxxxxxxxxxxxxxxxxx
				O que.: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				Onde..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				Porque: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				Como..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				Quando: Inic.Previsto..: 99/99/9999      Real.:   99/99/9999
						Fim  Previsto..: 99/99/9999      Real.:   99/99/9999
				Quanto: Valor Previsto.: x.xxx.xxx,xx    Real.: x.xxx.xxx,xx
						Qtde Atual.....:    xx.xxx,xx    Real.: x.xxx.xxx,xx   Meta.: xx.xxx,xx      Unid.Medida.: xxxxxx

		xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99/99/9999   99/99/9999  99/99/9999  99/99/9999  99/99/9999  xxxxxxxxxxxxxxxxxxxxxxx
				O que.: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				Onde..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				Porque: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				Como..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				Quando: Inic.Previsto.: 99/99/9999      Real.:   99/99/9999
						Fim  Previsto.: 99/99/9999      Real.:   99/99/9999
				Quanto: Valor Previsto: x.xxx.xxx,xx    Real.: x.xxx.xxx,xx
						Qtde  Atual...:    xx.xxx,xx    Real.: x.xxx.xxx,xx   Meta.: xx.xxx,xx      Unid.Medida.: xxxxxx


	===============================================================================================================================================

			1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200       210       220
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
	Plano     Nome do Plano de Acao                    Dt.Implant Inic.Prev  Fim Prev   Inic.Real   Fim Real   Responsavel
	Risco      Agente  Nome Agente                     Qtde       U.Med.  Dt.Recon    Dt.Aval     Dt.Elim     Fonte Geradora                  C.Custo               Funcao          Tarefa  Ambiente
	_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
	xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999 99/99/9999 99/99/9999 99/99/9999  99/99/9999 xxxxxxxxxxxx
			O que.: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Onde..: .xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Porque: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Como..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Quando: Inic.Previsto.: 99/99/9999      Real.:   99/99/9999
					Fim  Previsto.: 99/99/9999      Real.:   99/99/9999
			Quanto: Valor Previsto: x.xxx.xxx,xx    Real.: x.xxx.xxx,xx
					Qtde  Atual...:    xx.xxx,xx    Real.: x.xxx.xxx,xx   Meta.: xx.xxx,xx      Unid.Medida.: xxxxxx
	Riscos Relacionados:
	xxxxxxxxx  xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxx,xxx  xxxxxx  xx/xx/xxxx  xx/xx/xxxx  xx/xx/xxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxx  xxxxxx  xxxxxx
	xxxxxxxxx  xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxx,xxx  xxxxxx  xx/xx/xxxx  xx/xx/xxxx  xx/xx/xxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxx  xxxxxx  xxxxxx

	xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999 99/99/9999 99/99/9999 99/99/9999  99/99/9999 xxxxxxxxxxxx
			O que.: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Onde..: .xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Porque: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Como..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Quando: Inic.Previsto.: 99/99/9999      Real.:   99/99/9999
					Fim  Previsto.: 99/99/9999      Real.:   99/99/9999
			Quanto: Valor Previsto: x.xxx.xxx,xx    Real.: x.xxx.xxx,xx
					Qtde  Atual...:    xx.xxx,xx    Real.: x.xxx.xxx,xx   Meta.: xx.xxx,xx      Unid.Medida.: xxxxxx
	Riscos Relacionados:
	xxxxxxxxx  xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxx,xxx  xxxxxx  xx/xx/xxxx  xx/xx/xxxx  xx/xx/xxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxx  xxxxxx  xxxxxx
	xxxxxxxxx  xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxx,xxx  xxxxxx  xx/xx/xxxx  xx/xx/xxxx  xx/xx/xxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxx  xxxxxx  xxxxxx
	*/

	If lSigaMdtps

		If mv_par14 == 1
			cabec1 := STR0047 //"Risco      Agente  Nome Agente                     Qtde        U.Med.  Dt.Recon    Dt.Aval     Dt.Elim     Fonte Geradora                  C.Custo               Funcao          Tarefa  Ambiente"
			cabec2 := STR0037 //"    Plano     Nome do Plano de Acao                     Dt.Implant.  Inic.Prev.  Fim Prev.   Inic.Real   Fim Real    Responsavel"
		Else
			cabec1 := STR0038 //"Plano     Nome do Plano de Acao                    Dt.Implant Inic.Prev  Fim Prev   Inic.Real   Fim Real   Responsavel"
			cabec2 := STR0048 //"   Risco      Agente  Nome Agente                     Qtde        U.Med.  Dt.Recon    Dt.Aval     Dt.Elim     Fonte Geradora                  C.Custo               Funcao          Tarefa  Ambiente"
		EndIf

		aDBF := {}
		AADD(aDBF,{"RISCO"   ,"C",09,0})
		AADD(aDBF,{"AGENTE"  ,"C",06,0})
		AADD(aDBF,{"DTRECON" ,"D",08,0})
		AADD(aDBF,{"DTAVAL"  ,"D",08,0})
		AADD(aDBF,{"DTELIM"  ,"D",08,0})
		AADD(aDBF,{"FONTE"   ,"C",08,0})
		AADD(aDBF,{"QTDE"    ,"N",aTamSX3[1],aTamSX3[2]})
		AADD(aDBF,{"UMED"    ,"C",06,0})
		AADD(aDBF,{"CCUSTO"  ,"C",nSizeSI3,0})
		AADD(aDBF,{"FUNCAO"  ,"C",nSizeSRJ,0})
		AADD(aDBF,{"TAREFA"  ,"C",06,0})
		AADD(aDBF,{"AMBIENTE","C",nSizeTN0,0})
		AADD(aDBF,{"PLANO"   ,"C",08,0})
		AADD(aDBF,{"NOMPLA"  ,"C",40,0})
		AADD(aDBF,{"DTIMPLA" ,"D",08,0})
		AADD(aDBF,{"INICPREV","D",08,0})
		AADD(aDBF,{"FIM"     ,"D",08,0})
		AADD(aDBF,{"INIREAL" ,"D",08,0})
		AADD(aDBF,{"FIMREAL" ,"D",08,0})
		AADD(aDBF,{"RESP"    ,"C",12,0})
		AADD(aDBF,{"CLIENT"  ,"C",nTa1 ,0})
		AADD(aDBF,{"LOJA"    ,"C",nTa1L,0})

		//Cria TRB
		oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
		If mv_par14 == 1
			oTempTRB:AddIndex( "1", {"CLIENT","LOJA","RISCO","PLANO"} )
		Else
			oTempTRB:AddIndex( "1", {"CLIENT","LOJA","PLANO","RISCO"} )
		EndIf
		oTempTRB:Create()

		dbSelectArea("TN0")
		dbSetOrder(08)  //TN0_FILIAL+TN0_CODCLI+TN0_LOJACL+TN0_NUMRIS
		dbSeek(xFilial("TN0")+MV_PAR01+MV_PAR02,.T.)

		SetRegua(LastRec())

		// Correr TMJ para ler o Plano de Acao por Risco

		While !EoF()                            .And.;
			TN0->TN0_FILIAL == xFilial('TN0') .And.;
			TN0->(TN0_CODCLI+TN0_LOJACL) >= MV_PAR01+MV_PAR02 .And. TN0->(TN0_CODCLI+TN0_LOJACL) <= MV_PAR03+MV_PAR04

			IncRegua()

			If TN0->TN0_NUMRIS < MV_PAR05 .Or. TN0->TN0_NUMRIS > MV_PAR06
					dbSelectArea("TN0")
					dbSkip()
					Loop
			EndIf

			dbSelectArea("TNJ")
			dbSetOrder(3)  //TNJ_FILIAL+TNJ_CLIENT+TNJ_LOJA+TNJ_NUMRIS+TNJ_CODPLA
			IF dbSeek(xfilial("TNJ")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_NUMRIS)

				DO WHILE !EoF().And. xfilial("TNJ") == TNJ->TNJ_FILIAL .And. TNJ->TNJ_NUMRIS == TN0->TN0_NUMRIS .And. TN0->(TN0_CODCLI+TN0_LOJACL) == TNJ->(TNJ_CLIENT+TNJ_LOJA)

				dbSelectArea( cAliasPA )
				dbSetOrder(nIndexPA)  //TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_CODPLA
				IF dbSeek(xfilial(cAliasPA)+TNJ->(TNJ_CLIENT+TNJ_LOJA)+TNJ->TNJ_CODPLA)

					DO WHILE !EoF().And. xfilial(cAliasPA) == (cAliasPA)->&(aFieldPA[1]) .And. (cAliasPA)->&(aFieldPA[2]) == TNJ->TNJ_CODPLA .And. TNJ->(TNJ_CLIENT+TNJ_LOJA) == (cAliasPA)->(&(cClientePA)+&(cLojaPA))

						If (cAliasPA)->&(aFieldPA[4]) < MV_PAR07 .Or. (cAliasPA)->&(aFieldPA[4]) > MV_PAR08
						dbSelectArea( cAliasPA )
						dbSKIP()
						loop
						EndIf

						If !Empty((cAliasPA)->&(aFieldPA[8])) .And. MV_PAR09 = 2
						dbSelectArea( cAliasPA )
						dbSKIP()
						loop
						EndIf

						If Empty((cAliasPA)->&(aFieldPA[8])) .And. MV_PAR09 = 3
						dbSelectArea( cAliasPA )
						dbSKIP()
						loop
						EndIf

						dbSelectArea("TRB")
						TRB->(DbAppend())
						TRB->RISCO    := TN0->TN0_NUMRIS
						TRB->AGENTE   := TN0->TN0_AGENTE
						TRB->DTRECON  := TN0->TN0_DTRECO
						TRB->DTAVAL   := TN0->TN0_DTAVAL
						TRB->DTELIM   := TN0->TN0_DTELIM
						TRB->FONTE    := TN0->TN0_FONTE
						TRB->QTDE     := TN0->TN0_QTAGEN
						TRB->UMED     := TN0->TN0_UNIMED
						TRB->CCUSTO   := TN0->TN0_CC
						TRB->FUNCAO   := TN0->TN0_CODFUN
						TRB->TAREFA   := TN0->TN0_CODTAR
						TRB->AMBIENTE := TN0->TN0_CODAMB
						TRB->PLANO    := (cAliasPA)->&(aFieldPA[2])
						TRB->NOMPLA   := (cAliasPA)->&(aFieldPA[3])
						TRB->DTIMPLA  := (cAliasPA)->&(aFieldPA[4])
						TRB->INICPREV := (cAliasPA)->&(aFieldPA[6])
						TRB->FIM      := (cAliasPA)->&(aFieldPA[7])
						TRB->INIREAL  := (cAliasPA)->&(aFieldPA[8])
						TRB->FIMREAL  := (cAliasPA)->&(aFieldPA[9])
						TRB->RESP     := (cAliasPA)->&(aFieldPA[11])
						TRB->CLIENT   := TN0->TN0_CODCLI
						TRB->LOJA     := TN0->TN0_LOJACL
						dbSelectArea( cAliasPA )
						dbSKIP()
					enddo
				EndIf
				dbSelectArea("TNJ")
				dbSKIP()
			enddo
			EndIf
			dbSelectArea("TN0")
			dbSKIP()
		End
		dbSelectArea("TRB")
		dbGOTOP()

		If !EoF()
			SomaLinha()
		EndIf

		If mv_par14 == 1 // Agrupar planos x riscos
			While !EoF()

			If cCliente <> TRB->CLIENT+TRB->LOJA
					cCliente := TRB->CLIENT+TRB->LOJA
					If !lPri
						@Li,000 PSAY Replicate("-",220)
						Somalinha()
					EndIf
					dbSelectArea("SA1")
					dbSetOrder(1)
					dbSeek(xFilial("SA1")+TRB->CLIENT+TRB->LOJA)
					@Li,000 PSAY STR0025 + Alltrim(TRB->CLIENT) + "-" + Alltrim(TRB->LOJA) + " - " + AllTrim(SA1->A1_NOME)  //"Cliente: "
					Somalinha()
			EndIf

				cRISCO := TRB->RISCO
				Somalinha()
				lTop := .F.
				@Li,000 PSAY TRB->RISCO PICTURE "@!"
				@Li,011 PSAY TRB->AGENTE PICTURE "@!"
				dbSelectArea("TMA")
				dbSetOrder(01)
				dbSeek(xFilial("TMA")+TRB->AGENTE)
				@Li,019 PSAY Substr(TMA->TMA_NOMAGE,1,20)
				@Li,051 PSAY TRB->QTDE PICTURE PesqPict('TN0','TN0_QTAGEN')
				@Li,063 PSAY TRB->UMED PICTURE "@!"
				@Li,071 PSAY TRB->DTRECON PICTURE "99/99/99"
				@Li,083 PSAY TRB->DTAVAL PICTURE "99/99/99"
				@Li,095 PSAY TRB->DTELIM PICTURE "99/99/99"
				dbSelectArea("TN7")
				dbSetOrder(03)  //TN7_FILIAL+TN7_CLIENT+TN7_LOJA+TN7_FONTE
				dbSeek(xFilial("TN7")+TRB->CLIENT+TRB->LOJA+TRB->FONTE)
				@Li,107 PSAY Substr(TN7->TN7_NOMFON,1,20)
				@Li,139 PSAY TRB->CCUSTO PICTURE "@!"
				IF TRB->FUNCAO = "*"
					@LI,161 PSAY STR0010 //"TODOS"
				ELSE
					@Li,161 PSAY TRB->FUNCAO PICTURE "@!"
				EndIf
				IF TRB->TAREFA = "*"
					@LI,177 PSAY STR0011 //"TODAS"
				ELSE
					@Li,177 PSAY TRB->TAREFA PICTURE "@!"
				EndIf
				@Li,185 PSAY TRB->AMBIENTE PICTURE "@!"

				Do while !EoF() .And. TRB->RISCO == cRISCO .And. TRB->CLIENT+TRB->LOJA == cCliente
					Somalinha()
					@Li,004 PSAY TRB->PLANO PICTURE "@!"
					@Li,014 PSAY TRB->NOMPLA PICTURE "@!"
					@Li,056 PSAY TRB->DTIMPLA PICTURE "99/99/99"
					@Li,069 PSAY TRB->INICPREV PICTURE "99/99/99"
					@Li,081 PSAY TRB->FIM PICTURE "99/99/99"
					@Li,093 PSAY TRB->INIREAL PICTURE "99/99/99"
					@Li,105 PSAY TRB->FIMREAL PICTURE "99/99/99"
					@Li,117 PSAY TRB->RESP PICTURE "@!"
					dbSelectArea( cAliasPA )
					dbSetOrder(nIndexPA)  //TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_CODPLA
					IF dbSEEK(xfilial( cAliasPA )+TRB->CLIENT+TRB->LOJA+TRB->PLANO)
					somalinha()
					@Li,014 PSAY STR0012 + (cAliasPA)->&(aFieldPA[10]) PICTURE "@!" //"O que.: "
					somalinha()
					@Li,014 PSAY STR0013 + (cAliasPA)->&(aFieldPA[12]) PICTURE "@!" //"Onde..: "
					somalinha()
					@Li,014 PSAY STR0014 + (cAliasPA)->&(aFieldPA[13]) PICTURE "@!" //"Porque: "
					somalinha()
					@Li,014 PSAY STR0015 + (cAliasPA)->&(aFieldPA[14]) PICTURE "@!" //"Como..: "
					somalinha()
					@Li,014 PSAY STR0016 + dtoc((cAliasPA)->&(aFieldPA[6]))  //"Quando: Inic.Previsto.: "
					@Li,054 PSAY STR0017 + dtoc((cAliasPA)->&(aFieldPA[8]))  //"Real.: "
					somalinha()
					@Li,022 PSAY STR0018 + dtoc((cAliasPA)->&(aFieldPA[7]))  //"Fim Previsto.: "
					@Li,054 PSAY STR0017 + dtoc((cAliasPA)->&(aFieldPA[9]))  //"Real.: "
					somalinha()
					@Li,014 PSAY STR0019 //"Quanto: Valor Previsto.: "
					@LI,039 PSAY (cAliasPA)->&(aFieldPA[15]) PICTURE "@E 9999,999.99"
					@Li,054 PSAY STR0017  //"Real.: "
					@LI,060 PSAY (cAliasPA)->&(aFieldPA[16]) PICTURE "@E 9999,999.99"
					somalinha()
					@Li,022 PSAY STR0020 //"Qtde Atual...: "
					@Li,041 PSAY (cAliasPA)->&(aFieldPA[17]) PICTURE "@E 99,999.99"
					@Li,054 PSAY STR0017 //"Real.: "
					@Li,063 PSAY (cAliasPA)->&(aFieldPA[19]) PICTURE "@E 99,999.99"
					@Li,076 PSAY STR0021 //"Meta.: "
					@Li,086 PSAY (cAliasPA)->&(aFieldPA[18]) PICTURE "@E 99,999.99"
					@Li,100 PSAY STR0040 //"Un. Medida:"
					If FieldPos( aFieldPA[24] ) > 0
						@Li,114 PSAY (cAliasPA)->&(aFieldPA[24]) PICTURE "@!"
					EndIf

					EndIf
					somalinha()
					dbSelectArea("TRB")
					dbSKIP()
				Enddo
				lPri := .F.
			Enddo
		Else // Agrupar riscos x plano
			While !EoF()

			If cCliente <> TRB->CLIENT+TRB->LOJA
					cCliente := TRB->CLIENT+TRB->LOJA
					If !lPri
						@Li,000 PSAY Replicate("-",220)
						Somalinha()
					EndIf
					dbSelectArea("SA1")
					dbSetOrder(1)
					dbSeek(xFilial("SA1")+TRB->CLIENT+TRB->LOJA)
					@Li,000 PSAY STR0025 + Alltrim(TRB->CLIENT) + "-" + Alltrim(TRB->LOJA) + " - " + AllTrim(SA1->A1_NOME)  //"Cliente: "
					Somalinha()
			EndIf

				cPLANO := TRB->PLANO
				Somalinha()

				lTop := .F.
				@Li,000 PSAY TRB->PLANO PICTURE "@!"
				@Li,010 PSAY TRB->NOMPLA PICTURE "@!"
				@Li,051 PSAY TRB->DTIMPLA PICTURE "99/99/99"
				@Li,062 PSAY TRB->INICPREV PICTURE "99/99/99"
				@Li,073 PSAY TRB->FIM PICTURE "99/99/99"
				@Li,084 PSAY TRB->INIREAL PICTURE "99/99/99"
				@Li,096 PSAY TRB->FIMREAL PICTURE "99/99/99"
				@Li,107 PSAY TRB->RESP PICTURE "@!"
				dbSelectArea( cAliasPA )
				dbSetOrder(nIndexPA)  //TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_CODPLA
				IF dbSEEK(xfilial( cAliasPA )+TRB->CLIENT+TRB->LOJA+TRB->PLANO)

				somalinha()
				@Li,010 PSAY STR0012 + (cAliasPA)->&(aFieldPA[10]) PICTURE "@!" //"O que.: "
				somalinha()
				@Li,010 PSAY STR0013 + (cAliasPA)->&(aFieldPA[12]) PICTURE "@!" //"Onde..: "
				somalinha()
				@Li,010 PSAY STR0014 + (cAliasPA)->&(aFieldPA[13]) PICTURE "@!" //"Porque: "
				somalinha()
				@Li,010 PSAY STR0015 + (cAliasPA)->&(aFieldPA[14]) PICTURE "@!" //"Como..: "
				somalinha()
				somalinha()
				@Li,010 PSAY STR0016 + dtoc((cAliasPA)->&(aFieldPA[6]))  //"Quando: Inic.Previsto.: "
				@Li,050 PSAY STR0017 + dtoc((cAliasPA)->&(aFieldPA[8]))  //"Real.: "
				somalinha()
				@Li,018 PSAY STR0018 + dtoc((cAliasPA)->&(aFieldPA[7]))  //"Fim Previsto.: "
				@Li,050 PSAY STR0017 + dtoc((cAliasPA)->&(aFieldPA[9]))  //"Real.: "
				somalinha()
				@Li,010 PSAY STR0019 //"Quanto: Valor Previsto.: "
				@LI,035 PSAY (cAliasPA)->&(aFieldPA[15]) PICTURE "@E 9999,999.99"
				@Li,050 PSAY STR0017  //"Real.: "
				@LI,057 PSAY (cAliasPA)->&(aFieldPA[16]) PICTURE "@E 9999,999.99"
				somalinha()
				@Li,018 PSAY STR0020 //"Qtde Atual...: "
				@Li,033 PSAY (cAliasPA)->&(aFieldPA[17]) PICTURE "@E 99,999.99"
				@Li,050 PSAY STR0017 //"Real.: "
				@Li,057 PSAY (cAliasPA)->&(aFieldPA[19]) PICTURE "@E 99,999.99"
				@Li,072 PSAY STR0021 //"Meta.: "
				@Li,080 PSAY (cAliasPA)->&(aFieldPA[18]) PICTURE "@E 99,999.99"
				@Li,096 PSAY STR0040 //"Un. Medida:"
				If FieldPos( aFieldPA[24] ) > 0
					@Li,108 PSAY (cAliasPA)->&(aFieldPA[24]) PICTURE "@!"
				EndIf

				EndIf

				lFirst := .T.
				Do while !EoF() .And. TRB->PLANO == cPLANO .And. TRB->CLIENT+TRB->LOJA == cCliente

					If lFirst
						Somalinha()
						Somalinha()
						@Li,003 PSAY STR0041 //"Riscos Relacionados.:"
						Somalinha()
						lFirst := .F.
					EndIf


					@Li,003 PSAY TRB->RISCO PICTURE "@!"
					@Li,014 PSAY TRB->AGENTE PICTURE "@!"
					dbSelectArea("TMA")
					dbSetOrder(01)
					dbSeek(xFilial("TMA")+TRB->AGENTE)
					@Li,022 PSAY Substr(TMA->TMA_NOMAGE,1,20)
					@Li,054 PSAY TRB->QTDE PICTURE PesqPict('TN0','TN0_QTAGEN')
					@Li,066 PSAY TRB->UMED PICTURE "@!"
					@Li,074 PSAY TRB->DTRECON PICTURE "99/99/99"
					@Li,086 PSAY TRB->DTAVAL PICTURE "99/99/99"
					@Li,098 PSAY TRB->DTELIM PICTURE "99/99/99"
					dbSelectArea("TN7")
					dbSetOrder(03)  //TN7_FILIAL+TN7_CLIENT+TN7_LOJA+TN7_FONTE
					dbSeek(xFilial("TN7")+TRB->CLIENT+TRB->LOJA+TRB->FONTE)
					@Li,110 PSAY Substr(TN7->TN7_NOMFON,1,20)
					@Li,142 PSAY TRB->CCUSTO PICTURE "@!"
					IF TRB->FUNCAO = "*"
						@LI,164 PSAY STR0010 //"TODOS"
					ELSE
						@Li,164 PSAY TRB->FUNCAO PICTURE "@!"
					EndIf
					IF TRB->TAREFA = "*"
						@LI,180 PSAY STR0011 //"TODAS"
					ELSE
						@Li,180 PSAY TRB->TAREFA PICTURE "@!"
					EndIf
					@Li,188 PSAY TRB->AMBIENTE PICTURE "@!"

					dbSelectArea("TRB")
					dbSKIP()
					Somalinha()
				Enddo
				lPri := .F.
			Enddo
		EndIf

	Else

		If mv_par10 == 1
			cabec1 := STR0036 // "Risco      Agente     Nome Agente           Qtde        U.Med.  Dt.Recon    Dt.Aval    Dt.Elim     Fonte Geradora        C.Custo    Funcao  Tarefa  Ambiente                         Departamento"
			cabec2 := STR0037 //"    Plano     Nome do Plano de Acao                     Dt.Implant.  Inic.Prev.  Fim Prev.   Inic.Real   Fim Real    Responsavel"
		Else
			cabec1 := STR0038 //"Plano     Nome do Plano de Acao                    Dt.Implant Inic.Prev  Fim Prev   Inic.Real   Fim Real   Responsavel"
			cabec2 := STR0039 // "   Risco      Agente     Nome Agente           Qtde        U.Med.  Dt.Recon    Dt.Aval    Dt.Elim     Fonte Geradora        C.Custo    Funcao  Tarefa  Ambiente                         Departamento"
		EndIf

		aDBF := {}
		AADD(aDBF,{"RISCO"   ,"C",09,0})
		AADD(aDBF,{"AGENTE"  ,"C",06,0})
		AADD(aDBF,{"DTRECON" ,"D",08,0})
		AADD(aDBF,{"DTAVAL"  ,"D",08,0})
		AADD(aDBF,{"DTELIM"  ,"D",08,0})
		AADD(aDBF,{"FONTE"   ,"C",08,0})
		AADD(aDBF,{"QTDE"    ,"N",09,3})
		AADD(aDBF,{"UMED"    ,"C",06,0})
		AADD(aDBF,{"CCUSTO"  ,"C",nSizeSI3,0})
		AADD(aDBF,{"FUNCAO"  ,"C",nSizeSRJ,0})
		AADD(aDBF,{"TAREFA"  ,"C",06,0})
		AADD(aDBF,{"DEPTO"   ,"C",nSizeSQB,0})
		AADD(aDBF,{"AMBIENTE","C",nSizeTN0,0})
		AADD(aDBF,{"PLANO"   ,"C",06,0})
		AADD(aDBF,{"NOMPLA"  ,"C",40,0})
		AADD(aDBF,{"DTIMPLA" ,"D",08,0})
		AADD(aDBF,{"INICPREV","D",08,0})
		AADD(aDBF,{"FIM"     ,"D",08,0})
		AADD(aDBF,{"INIREAL" ,"D",08,0})
		AADD(aDBF,{"FIMREAL" ,"D",08,0})
		AADD(aDBF,{"RESP"    ,"C",12,0})

		//Cria TRB
		oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
		If mv_par10 == 1
			oTempTRB:AddIndex( "1", {"RISCO","PLANO"} )
		Else
			oTempTRB:AddIndex( "1", {"PLANO","RISCO"} )
		EndIf
		oTempTRB:Create()

		dbSelectArea("TN0")
		dbSetOrder(01)
		dbSeek(xFilial("TN0")+MV_PAR01,.T.)

		SetRegua(LastRec())

		// Correr TMJ para ler o Plano de Acao por Risco

		While !EoF() .And. TN0->TN0_FILIAL == xFilial('TN0') .And. TN0->TN0_NUMRIS <= MV_PAR02
			IncRegua()
			dbSelectArea("TNJ")
			dbSetOrder(1)
			If dbSeek(xfilial("TNJ")+TN0->TN0_NUMRIS)

				Do While !EoF().And. xfilial("TNJ") == TNJ->TNJ_FILIAL .And. TNJ->TNJ_NUMRIS == TN0->TN0_NUMRIS
					dbSelectArea(cAliasPA)
					dbSetOrder(nIndexPA)
					If dbSeek(xfilial( cAliasPA )+TNJ->TNJ_CODPLA)
						Do While !EoF().And. xfilial( cAliasPA ) == (cAliasPA)->&(aFieldPA[1]).And. (cAliasPA)->&(aFieldPA[2]) == TNJ->TNJ_CODPLA

							If (cAliasPA)->&(aFieldPA[4]) < MV_PAR03 .Or. (cAliasPA)->&(aFieldPA[4]) > MV_PAR04
								dbSelectArea( cAliasPA )
								dbSKIP()
								loop
							EndIf

							If !Empty((cAliasPA)->&(aFieldPA[8])) .And. MV_PAR05 = 2
								dbSelectArea( cAliasPA )
								dbSKIP()
								loop
							EndIf

							If Empty((cAliasPA)->&(aFieldPA[8])) .And. MV_PAR05 = 3
								dbSelectArea( cAliasPA )
								dbSKIP()
								loop
							EndIf

							dbSelectArea("TRB")
							TRB->(DbAppend())
							TRB->RISCO    := TN0->TN0_NUMRIS
							TRB->AGENTE   := TN0->TN0_AGENTE
							TRB->DTRECON  := TN0->TN0_DTRECO
							TRB->DTAVAL   := TN0->TN0_DTAVAL
							TRB->DTELIM   := TN0->TN0_DTELIM
							TRB->FONTE    := TN0->TN0_FONTE
							TRB->QTDE     := TN0->TN0_QTAGEN
							TRB->UMED     := TN0->TN0_UNIMED
							TRB->CCUSTO   := TN0->TN0_CC
							TRB->DEPTO    := TN0->TN0_DEPTO
							TRB->FUNCAO   := TN0->TN0_CODFUN
							TRB->TAREFA   := TN0->TN0_CODTAR
							TRB->AMBIENTE := TN0->TN0_CODAMB
							TRB->PLANO    := (cAliasPA)->&(aFieldPA[2])
							TRB->NOMPLA   := (cAliasPA)->&(aFieldPA[3])
							TRB->DTIMPLA  := (cAliasPA)->&(aFieldPA[4])
							TRB->INICPREV := (cAliasPA)->&(aFieldPA[6])
							TRB->FIM      := (cAliasPA)->&(aFieldPA[7])
							TRB->INIREAL  := (cAliasPA)->&(aFieldPA[8])
							TRB->FIMREAL  := (cAliasPA)->&(aFieldPA[9])
							TRB->RESP     := (cAliasPA)->&(aFieldPA[11])

							dbSelectArea( cAliasPA )
							dbSkip()
						EndDo
					EndIf
					dbSelectArea("TNJ")
					dbSkip()
				EndDo
			EndIf
			dbSelectArea("TN0")
			dbSkip()
		End
		dbSelectArea("TRB")
		dbGOTOP()

		If mv_par10 == 1 // Agrupar planos x riscos
			While !EoF()

				cRISCO := TRB->RISCO
				Somalinha()
				If !lTop
					Somalinha()
				EndIf
				lTop := .F.
				@Li,000 PSAY TRB->RISCO PICTURE "@!" // Risco
				@Li,011 PSAY TRB->AGENTE PICTURE "@!" // Agente
				dbSelectArea("TMA")
				dbSetOrder(01)
				dbSeek(xFilial("TMA")+TRB->AGENTE)
				@Li,022 PSAY Substr(TMA->TMA_NOMAGE,1,20) // Nome Agente
				@Li,044 PSAY TRB->QTDE PICTURE PesqPict('TN0','TN0_QTAGEN') // Qtde
				@Li,056 PSAY TRB->UMED PICTURE "@!" // U. Med
				@Li,064 PSAY TRB->DTRECON PICTURE "99/99/99" // Dt.Recon
 				@Li,076 PSAY TRB->DTAVAL PICTURE "99/99/99" // Dt.Aval
				@Li,087 PSAY TRB->DTELIM PICTURE "99/99/99" // Dt.Elim
				dbSelectArea("TN7")
				dbSetOrder(01)
				dbSeek(xFilial("TN7")+TRB->FONTE)
				@Li,99 PSAY Substr(TN7->TN7_NOMFON,1,20) // Fonte Geradora
				@Li,121 PSAY TRB->CCUSTO PICTURE "@!" // C.Custo
				IF TRB->FUNCAO = "*"
					@Li,132 PSAY STR0010 //"TODOS" // Funcao
				Else
					@Li,132 PSAY TRB->FUNCAO PICTURE "@!" // Funcao
				EndIf
				IF TRB->TAREFA = "*"
					@Li,140 PSAY STR0011 //"TODAS" // Tarefa
				Else
					@Li,140 PSAY TRB->TAREFA PICTURE "@!" //Tarefa
				EndIf
				@Li,148 PSAY TRB->AMBIENTE PICTURE "@!" // Ambiente
				If TRB->DEPTO = "*"
					@Li,181 PSAY STR0010 //"TODOS" // Departamento
				Else
					@Li,181 PSAY TRB->DEPTO PICTURE "@!" // Departamento
				EndIf

				Do while !EoF() .And. TRB->RISCO == cRISCO
					Somalinha()
					@Li,004 PSAY TRB->PLANO PICTURE "@!"
					@Li,014 PSAY TRB->NOMPLA PICTURE "@!"
					@Li,056 PSAY TRB->DTIMPLA PICTURE "99/99/99"
					@Li,069 PSAY TRB->INICPREV PICTURE "99/99/99"
					@Li,081 PSAY TRB->FIM PICTURE "99/99/99"
					@Li,093 PSAY TRB->INIREAL PICTURE "99/99/99"
					@Li,105 PSAY TRB->FIMREAL PICTURE "99/99/99"
					@Li,117 PSAY TRB->RESP PICTURE "@!"
					dbSelectArea( cAliasPA )
					dbSetOrder(1)
					IF dbSEEK(xfilial( cAliasPA )+TRB->PLANO)
						somalinha()
						@Li,014 PSAY STR0012 + (cAliasPA)->&(aFieldPA[10]) PICTURE "@!" //"O que.: "
						somalinha()
						@Li,014 PSAY STR0013 + (cAliasPA)->&(aFieldPA[12]) PICTURE "@!" //"Onde..: "
						somalinha()
						@Li,014 PSAY STR0014 + (cAliasPA)->&(aFieldPA[13]) PICTURE "@!" //"Porque: "
						somalinha()
						@Li,014 PSAY STR0015 + (cAliasPA)->&(aFieldPA[14]) PICTURE "@!" //"Como..: "
						somalinha()
						@Li,014 PSAY STR0016 + dtoc((cAliasPA)->&(aFieldPA[6]))  //"Quando: Inic.Previsto.: "
						@Li,054 PSAY STR0017 + dtoc((cAliasPA)->&(aFieldPA[8]))  //"Real.: "
						somalinha()
						@Li,022 PSAY STR0018 + dtoc((cAliasPA)->&(aFieldPA[7]))  //"Fim Previsto.: "
						@Li,054 PSAY STR0017 + dtoc((cAliasPA)->&(aFieldPA[9]))  //"Real.: "
						somalinha()
						@Li,014 PSAY STR0019 //"Quanto: Valor Previsto.: "
						@LI,039 PSAY (cAliasPA)->&(aFieldPA[15])PICTURE "@E 9999,999.99"
						@Li,054 PSAY STR0017  //"Real.: "
						@LI,060 PSAY (cAliasPA)->&(aFieldPA[16])PICTURE "@E 9999,999.99"
						somalinha()
						@Li,022 PSAY STR0020 //"Qtde Atual...: "
						@Li,041 PSAY (cAliasPA)->&(aFieldPA[17])PICTURE "@E 99,999.99"
						@Li,054 PSAY STR0017 //"Real.: "
						@Li,063 PSAY (cAliasPA)->&(aFieldPA[19])PICTURE "@E 99,999.99"
						@Li,076 PSAY STR0021 //"Meta.: "
						@Li,086 PSAY (cAliasPA)->&(aFieldPA[18])PICTURE "@E 99,999.99"
						@Li,100 PSAY STR0040 //"Un. Medida:"
						If FieldPos(aFieldPA[24]) > 0
							@Li,114 PSAY (cAliasPA)->&(aFieldPA[24])PICTURE "@!"
						EndIf

					EndIf
					somalinha()
					somalinha()
					dbSelectArea("TRB")
					dbSKIP()
				Enddo
				somalinha()
			Enddo
		Else // Agrupar riscos x plano
			While !EoF()

				cPLANO := TRB->PLANO
				Somalinha()
				If !lTop
					Somalinha()
				EndIf
				lTop := .F.
				@Li,000 PSAY TRB->PLANO PICTURE "@!"
				@Li,010 PSAY TRB->NOMPLA PICTURE "@!"
				@Li,051 PSAY TRB->DTIMPLA PICTURE "99/99/99"
				@Li,063 PSAY TRB->INICPREV PICTURE "99/99/99"
				@Li,074 PSAY TRB->FIM PICTURE "99/99/99"
				@Li,085 PSAY TRB->INIREAL PICTURE "99/99/99"
				@Li,097 PSAY TRB->FIMREAL PICTURE "99/99/99"
				@Li,108 PSAY TRB->RESP PICTURE "@!"
				dbSelectArea(cAliasPA)
				dbSetOrder(nIndexPA)
				IF dbSEEK(xfilial( cAliasPA )+TRB->PLANO)

					somalinha()
					@Li,010 PSAY STR0012 + (cAliasPA)->&(aFieldPA[10])PICTURE "@!" //"O que.: "
					somalinha()
					@Li,010 PSAY STR0013 + (cAliasPA)->&(aFieldPA[12])PICTURE "@!" //"Onde..: "
					somalinha()
					@Li,010 PSAY STR0014 + (cAliasPA)->&(aFieldPA[13])PICTURE "@!" //"Porque: "
					somalinha()
					@Li,010 PSAY STR0015 + (cAliasPA)->&(aFieldPA[14])PICTURE "@!" //"Como..: "
					somalinha()
					somalinha()
					@Li,010 PSAY STR0016 + dtoc((cAliasPA)->&(aFieldPA[6]))  //"Quando: Inic.Previsto.: "
					@Li,050 PSAY STR0017 + dtoc((cAliasPA)->&(aFieldPA[8]))  //"Real.: "
					somalinha()
					@Li,018 PSAY STR0018 + dtoc((cAliasPA)->&(aFieldPA[7]))  //"Fim Previsto.: "
					@Li,050 PSAY STR0017 + dtoc((cAliasPA)->&(aFieldPA[9]))  //"Real.: "
					somalinha()
					@Li,010 PSAY STR0019 //"Quanto: Valor Previsto.: "
					@LI,035 PSAY (cAliasPA)->&(aFieldPA[15])PICTURE "@E 9999,999.99"
					@Li,050 PSAY STR0017  //"Real.: "
					@LI,057 PSAY (cAliasPA)->&(aFieldPA[16])PICTURE "@E 9999,999.99"
					somalinha()
					@Li,018 PSAY STR0020 //"Qtde Atual...: "
					@Li,033 PSAY (cAliasPA)->&(aFieldPA[17])PICTURE "@E 99,999.99"
					@Li,050 PSAY STR0017 //"Real.: "
					@Li,057 PSAY (cAliasPA)->&(aFieldPA[19])PICTURE "@E 99,999.99"
					@Li,072 PSAY STR0021 //"Meta.: "
					@Li,080 PSAY (cAliasPA)->&(aFieldPA[18])PICTURE "@E 99,999.99"
					@Li,096 PSAY STR0040 //"Un. Medida:"
					If FieldPos(aFieldPA[24]) > 0
						@Li,108 PSAY (cAliasPA)->&(aFieldPA[24])PICTURE "@!"
					EndIf

				EndIf

				lFirst := .T.
				Do while !EoF() .And. TRB->PLANO == cPLANO

					If lFirst
						Somalinha()
						Somalinha()
						@Li,003 PSAY STR0041 //"Riscos Relacionados.:"
						Somalinha()
						lFirst := .F.
					EndIf

					@Li,003 PSAY TRB->RISCO PICTURE "@!" // Risco
					@Li,014 PSAY TRB->AGENTE PICTURE "@!" // Agente
					dbSelectArea("TMA")
					dbSetOrder(01)
					dbSeek(xFilial("TMA")+TRB->AGENTE)
					@Li,025 PSAY Substr(TMA->TMA_NOMAGE,1,20) // Nome Agente
					@Li,047 PSAY TRB->QTDE PICTURE PesqPict('TN0','TN0_QTAGEN') // Qtde
					@Li,059 PSAY TRB->UMED PICTURE "@!" // U. Med
					@Li,067 PSAY TRB->DTRECON PICTURE "99/99/99" // Dt.Recon
					@Li,079 PSAY TRB->DTAVAL PICTURE "99/99/99" // Dt.Aval
					@Li,090 PSAY TRB->DTELIM PICTURE "99/99/99" // Dt.Elim
					dbSelectArea("TN7")
					dbSetOrder(01)
					dbSeek(xFilial("TN7")+TRB->FONTE)
					@Li,102 PSAY Substr(TN7->TN7_NOMFON,1,20) // Fonte Geradora
					@Li,124 PSAY TRB->CCUSTO PICTURE "@!" // C.Custo
					IF TRB->FUNCAO = "*"
						@Li,135 PSAY STR0010 //"TODOS" // Funcao
					Else
						@Li,135 PSAY TRB->FUNCAO PICTURE "@!" // Funcao
					EndIf
					IF TRB->TAREFA = "*"
						@Li,143 PSAY STR0011 //"TODAS" // Tarefa
					Else
						@Li,143 PSAY TRB->TAREFA PICTURE "@!" //Tarefa
					EndIf
					@Li,151 PSAY TRB->AMBIENTE PICTURE "@!" // Ambiente
					If TRB->DEPTO = "*"
						@Li,184 PSAY STR0010 //"TODOS" // Departamento
					Else
						@Li,184 PSAY TRB->DEPTO PICTURE "@!" // Departamento
					EndIf

					dbSelectArea("TRB")
					dbSKIP()
					Somalinha()
				Enddo

			Enddo
		EndIf

	EndIf

	// Devolve a condicao original do arquivo principal
	RetIndex("TN0")

	Set Filter To
	Set device to Screen

	If aReturn[5] = 1
			Set Printer To
			dbCommitAll()
			OurSpool(wnrel)
	EndIf

	MS_FLUSH()

	oTempTRB:Delete()
	dbSelectArea("TN0")
	dbSetOrder(01)

Return NIL

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Thiago Machado        ³ Data ³05/09/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR840                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha()

    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
        lTop := .T.
    EndIf

Return

//---------------------------------------------------------------------------
/*/{Protheus.doc} MDT840PERG
Valida os campos do SX1, trazendo uma mensagem help específica para cada campo.

@author Guilherme Freudenburg
@since 08/11/2013
@return lRet
/*/
//----------------------------------------------------------------------------
User Function MDT840PERG(nperg)

	Local lRet:= .T.

	If (nperg == 1)
		If mv_par02 <> Replicate("Z",Len(mv_par02))
			If ((mv_par01 > mv_par02) .Or. Empty(mv_par02) )
				ShowHelpDlg(STR0042,{STR0044},2,{STR0043},2)
				lRet:=.F.
			ElseIf lRet := ExistCpo("TN0")
			EndIf
		EndIf
	ElseIf (nperg == 2)
		If  mv_par07 <> Replicate("Z",Len(mv_par07))
			If (mv_par06 > mv_par07) .Or. Empty(mv_par07)
				ShowHelpDlg(STR0042,{STR0045},2,{STR0043},2)
				lRet:=.F.
			ElseIf lRet := ExistCpo("TMK")
			EndIf
		EndIf
	ElseIf (nperg == 3)
		If  mv_par09 <> Replicate("Z",Len(mv_par09))
			If (mv_par08 > mv_par09) .Or. Empty(mv_par09)
				ShowHelpDlg(STR0042,{STR0046},2,{STR0043},2)
				lRet:=.F.
			ElseIf lRet := ExistCpo("SRA")
			EndIf
		EndIf
	EndIf

Return lRet
