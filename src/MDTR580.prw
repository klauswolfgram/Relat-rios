/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr580.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR580

Mostrar todos os riscos a que o funcionario esta exposto atualmente.

@author  Denis Hyroshi de Souza
@since   06/05/03

@return  Nil, Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR580

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local cString := "SRA"
	Local wnrel   := "MDTR580"
	Local cDesc1  := STR0001 // "Mostrar todos os riscos a que o funcionario esta exposto atualmente."
	Local cDesc2  := " "
	Local cDesc3  := " "

	Private aReturn  := {STR0002,1,STR0003,1,1,1,"",1} // "Zebrado"###"Administracao"
	Private nomeprog := "MDTR580"
	Private tamanho  := "G"
	Private titulo   := STR0004 // "Riscos por Funcionario"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := "MDT580    "
	Private cabec1   := If(NGCADICBASE( "TN0_DEPTO" , "A" , "TN0", .F. ),STR0033 ,STR0013) //"    Num. Risco Agente                 Fonte Geradora           Avaliacao  Intensid.  U.M.   C.Custo                         Funcao                Tarefa                Departamento          Ambiente"//"    Num. Risco Agente                 Fonte Geradora           Avaliacao  Intensid.  U.M.   C.Custo                         Funcao                Tarefa                Ambiente"
	Private cabec2   := " "
	Private nSizeSI3
	nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	PRIVATE nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))
	Private cCliMdtPs := Space(Len(SA1->A1_COD+SA1->A1_LOJA))

	Private cAlias := "SI3"
	Private cDescr := "SI3->I3_DESC"
	Private cF3CC  := "SI3001"
	Private aVetinr := {}

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
		cF3CC  := "CTT001"
	EndIf

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	cCliMdtPs := If(!lSigaMdtPS,Space(Len(SA1->A1_COD+SA1->A1_LOJA)),"Z")
	cPerg    :=  If(!lSigaMdtPS,"MDT580    ","MDT580PS  ")

	/*---------------------------------------------------
	//PERGUNTAS PADRÃO										|
	| MDT580    ¦01      ¦De Funcionario ?					|
	| MDT580    ¦02      ¦Ate Funcionario ?				    |
	| MDT580    ¦03      ¦Considerar Risco ?				|
	| MDT580    ¦04      ¦De  Centro Custo ?				|
	| MDT580    ¦05      ¦Ate Centro Custo ?				|
	| MDT580    ¦06      ¦De  Funcao?						|
	| MDT580    ¦07      ¦Ate Funcao?						|
	| MDT580    ¦08      ¦Situacao Funcionario ?			|
	| MDT580    ¦09      ¦Imprimir Descrição Tarefa ?	    |
	| MDT580    ¦10      ¦Considera Eliminados?             |
	|														|
	//PERGUNTAS PRESTADOR DE SERVIÇO						|
	| MDT580    ¦01      ¦De Cliente ?						|
	| MDT580    ¦02      ¦Loja								|
	| MDT580    ¦03      ¦AtÚ Cliente ?					    |
	| MDT580    ¦04      ¦Loja								|
	| MDT580    ¦05      ¦De Funcionario ?					|
	| MDT580    ¦06      ¦Ate Funcionario ?				    |
	| MDT580    ¦07      ¦Considerar Risco ?				|
	| MDT580    ¦08      ¦De  Centro Custo ?				|
	| MDT580    ¦09      ¦Ate Centro Custo ?				|
	| MDT580    ¦10      ¦De  Funcao?						|
	| MDT580    ¦11      ¦Ate Funcao?						|
	| MDT580    ¦12      ¦Situacao Funcionario ?			|
	| MDT580    ¦12      ¦Imprimir Descrição Tarefa ?	    |
	----------------------------------------------------*/

	pergunte(cPerg,.F.) // Verifica as perguntas selecionadas

	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.)

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

	RptStatus({|lEnd| fR580Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} fR580Imp
Chamada do Relatorio

@author  Denis Hyroshi de Souza
@since   06/05/03

@sample  sample

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caractere, Arquivo de saida do relatorio
@param   titulo, Caractere, Titulo do relatorio
@param   tamanho, Caractere, Tamanho do relatorio

@return  Nil, Nulo
/*/
//-------------------------------------------------------------------
Static Function fR580Imp(lEnd,wnRel,titulo,tamanho)
	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local oTempTable
	Local aTamSX3   := TAMSX3("TN0_QTAGEN")

	Private li := 80 ,m_pag := 1 ,nQtTotFunc  := 0 ,lPRINT := .T.
	Private aTarImpr := {}
	Private aTarDesc := {}
	Private lFirstMat := .F.
	Private nParDesc := If(lSigamdtps,MV_PAR13,MV_PAR09)
	nTipo  := IIF(aReturn[4]==1,15,18)

	aDBF := {}
	aAdd( aDBF, { "MAT"   , "C", 06, 0 } )
	aAdd( aDBF, { "NUMRIS", "C", 09, 0 } )
	aAdd( aDBF, { "AGENTE", "C", 06, 0 } )
	aAdd( aDBF, { "NOMAGE", "C", 22, 0 } )
	aAdd( aDBF, { "FONTE" , "C", 08, 0 } )
	aAdd( aDBF, { "NOMFON", "C", 23, 0 } )
	aAdd( aDBF, { "DTAVAL", "D", 08, 0 } )
	aAdd( aDBF, { "INTENS", "N", aTamSX3[1], aTamSX3[2] } )
	aAdd( aDBF, { "UNIDAD", "C", 06, 0 } )
	aAdd( aDBF, { "CCUSTO", "C", 30, 0 } )
	aAdd( aDBF, { "FUNCAO", "C", 20, 0 } )
	aAdd( aDBF, { "TAREFA", "C", 20, 0 } )

	If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
		aAdd( aDBF, { "DEPTO", "C", 30, 0 } )
	EndIf

	aAdd( aDBF, {"AMBIENT", "C", 20, 0 } )

	// Cria TRB
	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
	oTempTable:AddIndex( "1", {"MAT","NUMRIS"} )
	oTempTable:Create()

	If lSigaMdtps

		dbSelectArea("SRA")
		dbSetOrder(01)
		dbSeek(xFilial("SRA")+mv_par05,.t.)
		While !eof() .and. xFilial("SRA") == SRA->RA_FILIAL .and. SRA->RA_MAT <= Mv_par06

			If SubSTR(SRA->RA_CC,1,nSizeTD) < mv_par01+mv_par02 .OR. SubSTR(SRA->RA_CC,1,nSizeTD) > mv_par03+mv_par04
				dbSkip()
				Loop
			Endif
			If SRA->RA_CC < Mv_par08 .or. SRA->RA_CC > Mv_par09
				dbSkip()
				Loop
			Endif
			If SRA->RA_CODFUNC < Mv_par10 .or. SRA->RA_CODFUNC > Mv_par11
				dbSkip()
				Loop
			Endif

			dDtDemissao := If(Empty(SRA->RA_DEMISSA),PPPDTDEMIS(),SRA->RA_DEMISSA) //Busca data demissao do SRG

			If Mv_par12 == 1
				If !Empty(SRA->RA_SITFOLH) .or. !Empty(dDtDemissao)
				DbSelectArea("SRA")
				DbSkip()
				Loop
				Endif
		ElseIf Mv_par12 == 2
				If !Empty(dDtDemissao) .or. SRA->RA_SITFOLH == "D"
				DbSelectArea("SRA")
				DbSkip()
				Loop
				Endif
		ElseIf Mv_par12 == 3
				If Empty(dDtDemissao) .or. SRA->RA_SITFOLH != "D"
				DbSelectArea("SRA")
				DbSkip()
				Loop
				Endif
		Endif

			aTarImpr := {}
			U_OLDMDT580()
			U_PRIMDT580()

			dbSelectArea("SRA")
			dbskip()
		End

	Else

		dbSelectArea("SRA")
		dbSetOrder(01)
		dbSeek(xFilial("SRA")+mv_par01,.T.)

		While !eof() .And. xFilial("SRA") == SRA->RA_FILIAL .And. SRA->RA_MAT <= Mv_par02

			If SRA->RA_CC < Mv_par04 .Or. SRA->RA_CC > Mv_par05
				dbSkip()
				Loop
			EndIf

			If SRA->RA_CODFUNC < Mv_par06 .Or. SRA->RA_CODFUNC > Mv_par07
				dbSkip()
				Loop
			EndIf

			dDtDemissao := If(Empty(SRA->RA_DEMISSA),PPPDTDEMIS(),SRA->RA_DEMISSA) // Busca data demissao do SRG

			If Mv_par08 == 1

				If !Empty(SRA->RA_SITFOLH) .Or. !Empty(dDtDemissao)
					dbSelectArea("SRA")
					dbSkip()
					Loop
				EndIf

			ElseIf Mv_par08 == 2

				If !Empty(dDtDemissao) .Or. SRA->RA_SITFOLH == "D"
					dbSelectArea("SRA")
					dbSkip()
					Loop
				EndIf

			ElseIf Mv_par08 == 3

				If Empty(dDtDemissao) .Or. SRA->RA_SITFOLH != "D"
					dbSelectArea("SRA")
					dbSkip()
					Loop
				Endif

			Endif

			aTarImpr := {}
			U_OLDMDT580()
			U_PRIMDT580()

			dbSelectArea("SRA")
			dbskip()
		End

	Endif

	dbSelectArea("TRB")
	dbGotop()

	If RecCount()==0
		MsgInfo(STR0012)  // "Não há nada para imprimir no relatório."

		oTempTable:Delete()
		dbSelectArea("SRA")
		RetIndex("SRA")
		Set Filter To
		Return .F.
	EndIf

	Roda(nCntImpr,cRodaTxt,Tamanho)

	RetIndex("SRA")
	Set Filter To
	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf

	MS_FLUSH()
	oTempTable:Delete()
	dbSelectArea("SRA")
	dbSetOrder(01)
Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} OLDMDT580

Seleciona os riscos a qual os funcionarios estao expostos

@author  Denis Hyroshi de Souza
@since   06/05/03
/*/
//-------------------------------------------------------------------
User Function OLDMDT580()
	Local cSeekTN5  := If( lSigaMdtPS,"xFilial('TN5')+TN6->(TN6_CLIENT+TN6_LOJA)+TN6->TN6_CODTAR" , "xFilial('TN5')+TN6->TN6_CODTAR" )
	Local IndexTN5	:= If( lSigaMdtPS, 3, 1 )
	Local cVldRis	:= ""

	aTarDesc:= {}

	dbSelectArea("TN6")
	dbSetOrder(2)
	dbSeek(xFilial("TN6")+SRA->RA_MAT)

	While !eof() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. SRA->RA_MAT == TN6->TN6_MAT

		If TN6->TN6_DTINIC > dDataBase .Or. (TN6->TN6_DTTERM < dDataBase .And. !Empty(TN6->TN6_DTTERM))
			dbSelectArea("TN6")
			dbSkip()
			Loop
		Endif

		dbSelectArea("TN5")
		dbSetOrder(IndexTN5)  // TN5_FILIAL(+TN5_CLIENT+TN5_LOJA)+TN5_CODTAR
		dbSeek(&cSeekTN5)
		aAdd(aTarImpr,{TN6->TN6_CODTAR,SubStr(TN5->TN5_NOMTAR,1,40)})

		If nParDesc == 2

			If !Empty(TN5->TN5_DESTAR) .Or. !Empty(TN5->TN5_DESCR1) .Or. !Empty(TN5->TN5_DESCR2) .Or. ;
			   !Empty(TN5->TN5_DESCR3) .Or. !Empty(TN5->TN5_DESCR4)
				aAdd(aTarDesc,{TN5->TN5_DESTAR,TN5->TN5_DESCR1,TN5->TN5_DESCR2,TN5->TN5_DESCR3,TN5->TN5_DESCR4})
			Else
				aAdd(aTarDesc,{})
			EndIf

		EndIf

		dbSelectArea("TN6")
		dbSkip()
	End

	cVldRis := " { | dData | "

	If lSigaMDTPs
		cVldRis += " ( MV_PAR07 == 3 .Or. ( MV_PAR07 == 1 .And. !Empty(TN0->TN0_DTAVAL) ) .Or. ( MV_PAR07 == 2 .And. Empty( TN0->TN0_DTAVAL ) ) ) "
	Else
		// Valida se considera riscos Eliminados
		cVldRis += " ( MV_PAR10 == 1 .Or. Empty(TN0->TN0_DTELIM) .Or. TN0->TN0_DTELIM > dData )"
		cVldRis += " .And. "
		cVldRis += " ( MV_PAR03 == 3 .Or. ( MV_PAR03 == 1 .And. !Empty(TN0->TN0_DTAVAL) ) .Or. ( MV_PAR03 == 2 .And. Empty( TN0->TN0_DTAVAL ) ) ) "
	EndIf

	cVldRis += " .And. TN0->TN0_DTRECO <= dData } "
	MDTRETRIS( , , , { | | U_NG580RISAV() } , , , , .F. , , , , cVldRis )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} NG580RISAV

Grava arquivo de trabalho contendo os riscos do funcionario

@author  Denis Hyroshi de Souza
@since   11/11/02
/*/
//-------------------------------------------------------------------
User Function NG580RISAV()
	dbSelectarea("TMA")
	dbSetorder(1)
	dbSeek(xFilial("TMA")+TN0->TN0_AGENTE)

	If lSigaMdtps
		dbSelectArea("TN7")
		dbSetOrder(3)  //TN7_FILIAL+TN7_CLIENT+TN7_LOJA+TN7_FONTE
		dbSeek(xFilial("TN7")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_FONTE)
	Else
		dbSelectArea("TN7")
		dbSetOrder(1)
		dbSeek(xFilial("TN7")+TN0->TN0_FONTE)
	EndIf

	dbSelectArea("TRB")
	dbGoTop()

	If !Dbseek(SRA->RA_MAT+TN0->TN0_NUMRIS)
		TRB->(DBAPPEND())
		TRB->MAT    := SRA->RA_MAT
		TRB->NUMRIS := TN0->TN0_NUMRIS
		TRB->AGENTE := TN0->TN0_AGENTE
		TRB->NOMAGE := Substr(TMA->TMA_NOMAGE,1,22)
		TRB->FONTE  := TN0->TN0_FONTE
		TRB->NOMFON := Substr(TN7->TN7_NOMFON,1,23)
		TRB->DTAVAL := TN0->TN0_DTAVAL
		TRB->INTENS := TN0->TN0_QTAGEN
		TRB->UNIDAD := TN0->TN0_UNIMED
		TRB->CCUSTO := If(AllTrim(TN0->TN0_CC) 		<> "*",If(Alltrim(GETMV("MV_MCONTAB")) == "CTB", ;
							SubStr(NGSEEK('CTT',TN0->TN0_CC,1,'CTT->CTT_DESC01'),1,30), ;
							SubStr(NGSEEK('SI3',TN0->TN0_CC,1,'SI3->I3_DESC'),1,30)),Upper(STR0028))
		TRB->FUNCAO  := If(AllTrim(TN0->TN0_CODFUN) <> "*",SubStr(NGSEEK('SRJ',TN0->TN0_CODFUN,1,'SRJ->RJ_DESC'),1,20),Upper(STR0030))
		TRB->TAREFA  := If(AllTrim(TN0->TN0_CODTAR) <> "*",SubStr(NGSEEK('TN5',TN0->TN0_CODTAR,1,'TN5->TN5_NOMTAR'),1,20),Upper(STR0030))

		If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
			TRB->DEPTO   := If(AllTrim(TN0->TN0_DEPTO) <> "*",SubStr(NGSEEK('SQB',TN0->TN0_DEPTO,1,'SQB->QB_DESCRIC'),1,20),Upper(STR0028))
		EndIf

		TRB->AMBIENT := SubStr(NGSEEK('TNE',TN0->TN0_CODAMB,1,'TNE->TNE_NOME'),1,20)
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} PRIMDT580

Executa a impressao do conteudo do relatorio

@author  Denis Hyroshi de Souza
@since   13/11/02
/*/
//-------------------------------------------------------------------
User Function PRIMDT580()
	Local lFirst := .T., xx, nInd

	dbSelectarea(cAlias)
	dbSetorder(1)
	dbSeek(xFilial(cAlias)+SRA->RA_CC)
	dbSelectarea("SRJ")
	dbSetorder(1)
	dbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)
	dbSelectarea("TRB")
	dbGotop()
	dbSeek(SRA->RA_MAT)

	While !eof() .and. TRB->MAT == SRA->RA_MAT

		If lFirst
			lFirst := .f.

			If lFirstMat
				fSomalinha()
			EndIf

			lFirstMat := .T.
			fSomalinha()
			@ Li,000 PSay STR0006 //"Funcionario.......:"
			@ Li,020 PSay TRB->MAT+" - "+Alltrim(SRA->RA_NOME)
			fSomalinha()

			If lSigaMdtps
				@ Li,000 PSay STR0011 //"Cliente/Loja......:"
				dbSelectArea("SA1")
				dbSetOrder(1)

				If dbSeek(xFilial("SA1")+SubSTR(SRA->RA_CC,1,nSizeTD))
					@ Li,020 PSay SA1->A1_COD + "-" + SA1->A1_LOJA + " - "  + Alltrim(SA1->A1_NOME)
				EndIf

				fSomalinha()
			EndIf

			@ Li,000 PSay STR0007 //"Centro de Custo...:"
			@ Li,020 PSay Alltrim(SRA->RA_CC)+" - "+&cDescr
			fSomalinha()

			@ Li,000 PSay STR0035 //"Departamento......:"
			@ Li,020 PSay Alltrim(SRA->RA_DEPTO)+" - "+POSICIONE("SQB",1,XFILIAL("SQB")+SRA->RA_DEPTO,"QB_DESCRIC")
			fSomalinha()

			@ Li,000 PSay STR0008 //"Funcao............:"
			@ Li,020 PSay Alltrim(SRA->RA_CODFUNC)+" - "+SRJ->RJ_DESC
			fSomalinha()
			@ Li,000 PSay STR0009 //"Tarefas...........:"

			For xx := 1 To len(aTarImpr)
				@ Li,020 PSay Alltrim(aTarImpr[xx][1])+" - "+Alltrim(aTarImpr[xx][2])
				fSomalinha()

				If nParDesc == 2

					If !Empty(aTarDesc[xx])
						nLinhasMemo := MLCOUNT(aTarDesc[xx][1],80)

						For nInd := 1 to nLinhasMemo
							@Li,029 Psay MemoLine(aTarDesc[xx][1],80,nInd)
							fSomalinha()
						Next nInd

					EndIf

				EndIf

			Next xx

			If len(aTarImpr) == 0
				fSomalinha()
			EndIf

			fSomalinha()
			@ Li,000 PSay STR0010 //"Riscos:"
		EndIf

		fSomalinha()
		@ Li,004 PSay TRB->NUMRIS
		@ Li,015 PSay Substr(Alltrim(TRB->NOMAGE),1,22)
		@ Li,038 PSay Substr(Alltrim(TRB->NOMFON),1,23)
		@ Li,063 PSay TRB->DTAVAL
		@ Li,074 PSay TRB->INTENS
		@ Li,085 PSay TRB->UNIDAD
		@ Li,092 PSay TRB->CCUSTO
		@ Li,124 PSay TRB->FUNCAO
		@ Li,146 PSay TRB->TAREFA
		@ Li,168 Psay TRB->DEPTO
		@ Li,192 Psay TRB->AMBIENT

		dbSelectArea("TRB")
		dbSkip()
	End

Return

/*        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
    Num. Risco Agente                 Fonte Geradora           Avaliacao  Intensid.  U.M.   C.Custo                         Funcao                Tarefa                Departamento          Ambiente
    XXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXX  99/99/9999 99,999.999 XXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXX
*/

//-------------------------------------------------------------------
/*/{Protheus.doc} fSomalinha

Incrementa a linha e colntrola a quebra de pagina

@author  Denis Hyroshi de Souza
@since   13/11/02
/*/
//-------------------------------------------------------------------
Static Function fSomalinha()
	Li++

	If Li > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf

Return