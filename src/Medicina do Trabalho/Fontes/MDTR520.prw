/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "mdtr520.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR520
Mostrar todos os riscos a que o funcionario esta exposto
atualmente, bem como os riscos que existem no novo ambiente
em que o funcionário ira trabalha

@type    function

@author  Denis Hyroshi de Souza
@since   13/11/2002

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTR520

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local cString := "SRA"
	Local wnrel   := "MDTR520"
	Local cDesc1  := STR0001 //"Mostrar todos os riscos a que o funcionario esta exposto atualmente,"
	Local cDesc2  := STR0002 //"bem como os riscos que existem no novo ambiente em que o funcionario"
	Local cDesc3  := STR0003 //"ira trabalhar"

	Local cF3CC := "MDTPS4"  //SI3 apenas do cliente
	Local aTamSX3   := TAMSX3("TN0_QTAGEN")

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cF3CC := "MDTPS6"  //CTT apenas do cliente
	EndIf

	Private aReturn  := { STR0004, 1, STR0005, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
	Private nomeprog := "MDTR520"
	Private tamanho  := "G"
	Private titulo   := STR0006 //"Riscos Atual do Funcionario e Existentes no Novo Ambiente"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg   	:=""
	Private cabec1   := " "
	Private cabec2   := " "
	Private cAliasCC := "SI3"
	Private cDescr := "SI3->I3_DESC"

	Private oTempTable, oTempTRB, oTempEpi
	Private cTrb520  := GetNextAlias()
	Private cTrbRis	 := GetNextAlias()
	Private cTrbEPI  := GetNextAlias()

	Private nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Private nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))
	Private nSizeSQB := If((TAMSX3("QB_DEPTO")[1]) < 1 , 9, (TAMSX3("QB_DEPTO")[1]) )
	Private nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,2,(TAMSX3("B1_COD")[1]))

	lSigaMdtPS := SuperGetMv("MV_MDTPS",.F.,"N") == "S"
	cPerg    := PADR( If(!lSigaMdtps,"MDT520","MDT520PS") , 10 )
	nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	nSizeTD := nTa1+nTa1L

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAliasCC := "CTT"
		cDescr := "CTT->CTT_DESC01"
	EndIf

	/*------------------------------------------------
	//PERGUNTAS PADRÃO								 |
	| 01 mv_par01           // Matricula             |
	| 02 mv_par02           // Novo Centro de Custo	 |
	| 03 mv_par03         // Nova Funcao             |
	| 04 mv_par04       // Nova Tarefa               |
	| 05 mv_par05        // Novo Departamento        |
	--------------------------------------------------*/

	// Verifica as perguntas selecionadas
	pergunte(cPerg,.F.)

	// Envia controle para a funcao SETPRINT
	Private cMARCA := GetMark()
	Private aTarefaX := {}

	aCpsRis := {}
	AADD(aCpsRis,{ "TIPO"  ,   "C" ,01, 0 })
	AADD(aCpsRis,{ "NUMFIC"  , "C" ,09, 0 })
	AADD(aCpsRis,{ "AGENTE"  , "C" ,06, 0 })
	AADD(aCpsRis,{ "NOMAGE"  , "C" ,22, 0 })
	AADD(aCpsRis,{ "FONTE"   , "C" ,08, 0 })
	AADD(aCpsRis,{ "NOMFON"  , "C" ,23, 0 })
	AADD(aCpsRis,{ "DTAVAL"  , "D" ,08, 0 })
	AADD(aCpsRis,{ "INTENS"  , "N" ,aTamSX3[1], aTamSX3[2] })
	AADD(aCpsRis,{ "UNIDAD"  , "C" ,06, 0 })
	AADD(aCpsRis,{ "CCUSTO"  , "C" ,nSizeSI3, 0 })
	AADD(aCpsRis,{ "DEPTO"   , "C" ,nSizeSQB, 0 })
	AADD(aCpsRis,{ "FUNCAO"  , "C" ,nSizeSRJ, 0 })
	AADD(aCpsRis,{ "TAREFA"  , "C" ,06, 0 })
	AADD(aCpsRis,{ "NOVO"    , "C" ,03, 0 })

	oTempTRB := FWTemporaryTable():New( cTrbRis , aCpsRis )
	oTempTRB:AddIndex( "1", {"TIPO","NUMFIC"} )
	oTempTRB:Create()

	aDBF1 := {}
	AADD(aDBF1,{ "EPI"    , "C" ,nSizeCod, 0 })
	AADD(aDBF1,{ "DESCRI" , "C" ,30, 0 })

	oTempEpi := FWTemporaryTable():New( cTrbEPI , aDBF1 )
	oTempEpi:AddIndex( "1", {"EPI"} )
	oTempEpi:Create()

	aCpsTar := {}
	AADD(aCpsTar,{ "TN5_OK"     , "C" ,02, 0 })
	AADD(aCpsTar,{ "TN5_MARK"   , "C" ,02, 0 })
	AADD(aCpsTar,{ "TN5_CODTAR" , "C" ,06, 0 })
	AADD(aCpsTar,{ "TN5_NOMTAR" , "C" ,40, 0 })

	oTempTable := FWTemporaryTable():New( cTrb520, aCpsTar )
	oTempTable:AddIndex( "1", {"TN5_CODTAR"} )
	oTempTable:AddIndex( "2", {"TN5_NOMTAR"} )
	oTempTable:AddIndex( "3", {"TN5_MARK","TN5_CODTAR"} )
	oTempTable:Create()

	If !U_MDT520MLT() //Tela de parametros
		oTempTable:Delete()
		oTempTRB:Delete()
		oTempEpi:Delete()
		NGRETURNPRM(aNGBEGINPRM)
		Return
	EndIf

	wnrel:=SetPrint(cString,wnrel,,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		oTempTable:Delete()
		NGRETURNPRM(aNGBEGINPRM)
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to
		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		oTempTable:Delete()
		NGRETURNPRM(aNGBEGINPRM)
		Return
	EndIf

	RptStatus({|lEnd| R520Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	oTempTable:Delete()
	oTempTRB:Delete()
	oTempEpi:Delete()
	NGRETURNPRM(aNGBEGINPRM)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} R520Imp
Chamado do Relatório

@type    function

@author  Denis Hyroshi de Souza
@since   13/11/2002

@param   lEnd, Lógico, Indica se foi cancelado o relatório
@param   wnRel, Objeto, Objeto do relatório
@param   titulo, Caracter, Indica o título do relatório
@param   tamanho, Caracter, Indica o tamanho do relatório

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function R520Imp(lEnd,wnRel,titulo,tamanho)

	// Define Variaveis
	Local cRodaTxt := ""
	Local nCntImpr := 0

	// Variaveis para controle do cursor de progressao do relatorio
	Local nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

	// Variaveis locais exclusivas deste programa
	Local cChave           := SPACE(16)
	Local lContinua        := .T.
	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1 ,nQtTotFunc  := 0 ,lPRINT := .T.
	Private aTarefas := {}, aRisco := {}
	Private dOLD_CCUSTO
	Private dOLD_DEPTO
	Private dOLD_FUNCAO
	Private dNEW_CCUSTO
	Private dNEW_DEPTO
	Private dNEW_FUNCAO
	Private dNEW_TAREFA

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	DbSelectArea("SRA")
	DbSetOrder(01)
	If DbSeek(xFilial("SRA")+mv_par01)

		U_OLDMDT520()
		U_NEWMDT520()
		U_PRIMDT520()
		U_EPIMDT520()

	EndIf

	Roda(nCntImpr,cRodaTxt,Tamanho)

	// Devolve a condicao original do arquivo principal
	RetIndex("SRA")
	Set Filter To
	Set device to Screen
	If aReturn[5] = 1
			Set Printer To
			dbCommitAll()
			OurSpool(wnrel)
	EndIf

	MS_FLUSH()

	If ExistBlock("MDTR5201")
		ExecBlock("MDTR5201",.F.,.F.)
	EndIf

	dbSelectArea("SRA")
	dbSetOrder(01)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} OLDMDT520
Busca antigos riscos

@type    function
@author  Denis Hyroshi de Souza
@since   13/11/2002

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function OLDMDT520()

	Local dtIni := dDataBase
	Local dtFim := dDataBase+1
	Local nIdx	:= 1
	Local cSeek := "xFilial('TN5')+TN6->TN6_CODTAR"
	Local aAreaFunc := SRA->(GetArea()) //Salva area da SRA
	Local aAreaRisc := TN0->(GetArea()) //Salva area da TN0

	If lSigaMdtps
		nIdx := 3
		cSeek := "xFilial('TN5')+TN6->(TN6_CLIENT+TN6_LOJA)+TN6->TN6_CODTAR"
	EndIf

	dOLD_CCUSTO := SRA->RA_ADMISSA
	dOLD_DEPTO  := SRA->RA_ADMISSA
	dOLD_FUNCAO := SRA->RA_ADMISSA

	Dbselectarea("SR7")
	Dbsetorder(1)
	Dbseek(SRA->RA_FILIAL+SRA->RA_MAT)
	While !eof() .And. SR7->R7_FILIAL == SRA->RA_FILIAL .And.;
			SR7->R7_MAT == SRA->RA_MAT

		If SR7->R7_FUNCAO == SRA->RA_CODFUNC
			If SR7->R7_DATA > dOLD_FUNCAO .And. SR7->R7_DATA <= dDataBase
				dOLD_FUNCAO := SR7->R7_DATA
			EndIf
		EndIf

		Dbselectarea("SR7")
		Dbskip()
	End

	Dbselectarea("SRE")
	Dbsetorder(1)
	Dbseek(cEmpAnt+SRA->RA_FILIAL+SRA->RA_MAT)
	While !eof()  .And. SRE->RE_EMPD == cEmpAnt .And. ;
				SRE->RE_FILIALD == SRA->RA_FILIAL .And.;
				SRE->RE_MATD == SRA->RA_MAT

		If SRE->RE_CCP ==  SRA->RA_CC
			If SRE->RE_DATA > dOLD_CCUSTO .And. SRE->RE_DATA <= dDataBase
				dOLD_CCUSTO  := SRE->RE_DATA
			EndIf
		EndIf

		If SRE->RE_DEPTOP ==  SRA->RA_DEPTO
			If SRE->RE_DATA > dOLD_DEPTO .And. SRE->RE_DATA <= dDataBase
				dOLD_DEPTO  := SRE->RE_DATA
			EndIf
		EndIf

		Dbselectarea("SRE")
		Dbskip()
	End

	Dbselectarea("TN6")
	Dbsetorder(2)
	Dbseek(xFilial("TN6")+SRA->RA_MAT)
	While !eof() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. SRA->RA_MAT == TN6->TN6_MAT

		If TN6->TN6_DTINIC >= dtFim .Or. (TN6->TN6_DTTERM < dtIni .And. !Empty(TN6->TN6_DTTERM))
			Dbselectarea("TN6")
			Dbskip()
			Loop
		EndIf

		dbselectarea( "TN5" )
		dbsetorder( nIdx )
		If dbseek( &( cSeek ) )
			aAdd( aTarefas , { TN6->TN6_CODTAR , SubStr(TN5->TN5_NOMTAR,1,40) , TN6->TN6_DTINIC } )
		EndIf

		Dbselectarea("TN6")
		Dbskip()
	End

	dbSelectArea("TM0")
	dbSetOrder(3)
	DbSeek(xFilial("TM0")+SRA->RA_MAT)

	MDTRETRIS( ,TM0->TM0_NUMFIC , , { | | U_NG520RISAV( "1" ) } , , , , .F. )

	RestArea(aAreaRisc)//Retorna área de TN0
	RestArea(aAreaFunc)//Retorna área de SRA

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} NEWMDT520
Busca novos riscos

@type    function

@author  Denis Hyroshi de Souza
@since   13/11/2002

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function NEWMDT520()

	Local xx
	Local aTarRisco := {}
	Local aAreaFunc := SRA->(GetArea()) //Salva area da SRA
	Local aAreaRisc := TN0->(GetArea()) //Salva area da TN0
	Local aFixos := {Mv_par02,Mv_par03,Mv_par05}

	If mv_par02 == SRA->RA_CC
		dNEW_CCUSTO := dOLD_CCUSTO
	Else
		dNEW_CCUSTO := dDatabase
	EndIf

		If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
			If mv_par05 == SRA->RA_DEPTO
				dNEW_DEPTO := dOLD_DEPTO
			Else
				dNEW_DEPTO := dDatabase
			EndIf
		EndIf

	If mv_par03 == SRA->RA_CODFUNC
		dNEW_FUNCAO := dOLD_FUNCAO
	Else
		dNEW_FUNCAO := dDatabase
	EndIf

	For xx := 1 to len(aTarefas)
		nPosX := aSCAN(aTarefaX, {|x| x[1] == aTarefas[xx][1] })
		If nPosX > 0
			aTarefaX[nPosX][3] := aTarefas[xx][3]
		EndIf
	Next xx

	For xx := 1 To Len( aTarefaX )
		aAdd( aTarRisco , aTarefaX[ xx , 1 ] )
	Next xx

	dbSelectArea("TM0")
	dbSetOrder(3)
	DbSeek(xFilial("TM0")+SRA->RA_MAT)

	MDTRETRIS( ,TM0->TM0_NUMFIC , , { | | U_NG520RISAV( "2" ) } , , aTarRisco , , .F.,,.T.,aFixos )

	RestArea(aAreaRisc)//Retorna área de TN0
	RestArea(aAreaFunc)//Retorna área de SRA

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Soma a linha

@type    function

@author  Denis Hyroshi de Souza
@since   13/11/2002

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function Somalinha()

    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo,,.F.)
    EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} NG520RISAV
Grava arquivo de trabalho contendo os riscos do funcionario

@type    function

@author  Denis Hyroshi de Souza
@since   11/11/2002

@param   cTipo, Caracter, Indica o tipo (1-Atual, 2-Próximo)

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function NG520RISAV( cTipo )

	Local cSim := STR0007 //"SIM"
	Local cNao := STR0008 //"NAO"

	Dbselectarea("TMA")
	Dbsetorder(1)
	Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)

	If lSigaMdtps
		Dbselectarea("TN7")
		Dbsetorder(3)  //TN7_FILIAL+TN7_CLIENT+TN7_LOJA+TN7_FONTE
		Dbseek(xFilial("TN7")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_FONTE)
	Else
		Dbselectarea("TN7")
		Dbsetorder(1)
		Dbseek(xFilial("TN7")+TN0->TN0_FONTE)
	EndIf

	Dbselectarea(cTrbRis)
	Dbgotop()
	If !Dbseek(cTipo+TN0->TN0_NUMRIS)
		( cTrbRis )->(DBAPPEND())
		( cTrbRis )->TIPO   := cTipo
		( cTrbRis )->NUMFIC := TN0->TN0_NUMRIS
		( cTrbRis )->AGENTE := TN0->TN0_AGENTE
		( cTrbRis )->NOMAGE := Substr(TMA->TMA_NOMAGE,1,22)
		( cTrbRis )->FONTE  := TN0->TN0_FONTE
		( cTrbRis )->NOMFON := Substr(TN7->TN7_NOMFON,1,23)
		( cTrbRis )->DTAVAL := TN0->TN0_DTAVAL
		( cTrbRis )->INTENS := TN0->TN0_QTAGEN
		( cTrbRis )->UNIDAD := TN0->TN0_UNIMED
		( cTrbRis )->CCUSTO := TN0->TN0_CC
		If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
			( cTrbRis )->DEPTO  := TN0->TN0_DEPTO
		EndIf
		( cTrbRis )->FUNCAO := TN0->TN0_CODFUN
		( cTrbRis )->TAREFA := TN0->TN0_CODTAR
		nNovo		 := aSCAN(aRisco, {|x| Alltrim(X[1]) == Alltrim(TN0->TN0_NUMRIS)})
		( cTrbRis )->NOVO   := If((nNovo > 0),Substr(cNao,1,3),Substr(cSim,1,3))
		AADD(aRisco,{TN0->TN0_NUMRIS})
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} PRIMDT520
Impressão do relatório

@type    function

@author  Denis Hyroshi de Souza
@since   13/11/2002

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function PRIMDT520()

	Local xx

	Dbselectarea(cAliasCC)
	Dbsetorder(1)
	Dbseek(xFilial(cAliasCC)+SRA->RA_CC)
	Dbselectarea("SRJ")
	Dbsetorder(1)
	Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)
	Dbselectarea("SQB")
	Dbsetorder(1)
	Dbseek(xFilial("SQB")+SRA->RA_DEPTO)

	// DADOS DOS RISCOS ATUAIS
	Somalinha()
	@ Li,000 PSay STR0009  //"Funcionario.......:"
	@ Li,020 PSay SRA->RA_MAT+" - "+SRA->RA_NOME
	Somalinha()
	@ Li,000 PSay STR0010 //"Data de Nascimento:"
	@ Li,020 PSay SRA->RA_NASC
	Somalinha()
	@ Li,000 PSay STR0011 //"Data de Admissao..:"
	@ Li,020 PSay SRA->RA_ADMISSA
	Somalinha();Somalinha()
	@ Li,000 PSay STR0012 //"Ambiente Atual"
	Somalinha()
	If lSigaMdtps
		dbSelectArea("SA1")
		dbSetOrder(1)
		If dbSeek(xFilial("SA1")+SubStr(SRA->RA_CC,1,nSizeTD))
			@ Li,006 PSay STR0024  //"Cliente/Loja....:"
			@ Li,024 PSay AllTrim(SA1->A1_COD) + "-" + AllTrim(SA1->A1_LOJA) + " - " + AllTrim(SA1->A1_NOME)
			Somalinha()
		EndIf
	EndIf
	@ Li,006 PSay STR0013    //"Centro de Custo.:"
	@ Li,024 PSay Substr(Alltrim(SRA->RA_CC)+" - "+&cDescr,1,52)
	@ Li,077 PSay STR0014+dtoc(dOLD_CCUSTO) //"a partir de: "
	Somalinha()
	@ Li,006 PSay STR0015                         //"Funcao..........:"
	@ Li,024 PSay Alltrim(SRA->RA_CODFUNC)+" - "+SRJ->RJ_DESC
	@ Li,077 PSay STR0014+dtoc(dOLD_FUNCAO) //"a partir de: "
	Somalinha()
	@ Li,006 PSay STR0042                         //"Departamento....:"
	@ Li,024 PSay Alltrim(SRA->RA_DEPTO)+" - "+SQB->QB_DEPTO
	@ Li,077 PSay STR0014+dtoc(dOLD_DEPTO) //"a partir de: "

	Somalinha()
	@ Li,006 PSay STR0016      //"Tarefas.........:"
	for xx := 1 to len(aTarefas)
		@ Li,024 PSay Alltrim(aTarefas[xx][1])+" - "+aTarefas[xx][2]
		@ Li,077 PSay STR0014+dtoc(aTarefas[xx][3]) //"a partir de: "
		Somalinha()
	Next xx
	If len(aTarefas) == 0
		Somalinha()
	EndIf
	Somalinha()

	Dbselectarea(cTrbRis)
	Dbgotop()
	If DBseek("1")
	@ Li,006 PSay STR0017 //"Riscos"
	Somalinha()

	@ Li,006 PSay STR0025 // "Num.Risco  Agente               Fonte Geradora       Avaliacao Intensid.    U.M.    C.Custo               Funcao          Tarefa    Departamento"

	Somalinha()
	While !eof() .And. ( cTrbRis )->TIPO == "1"
		Somalinha()
		@ Li,006 PSay ( cTrbRis )->NUMFIC
		@ Li,017 PSay Substr(Alltrim(( cTrbRis )->NOMAGE),1,19)
		@ Li,038 PSay Substr(Alltrim(( cTrbRis )->NOMFON),1,19)
		@ Li,059 PSay ( cTrbRis )->DTAVAL
		@ Li,070 PSay ( cTrbRis )->INTENS
		@ Li,082 PSay ( cTrbRis )->UNIDAD
		@ Li,090 PSay Alltrim(( cTrbRis )->CCUSTO)
		@ Li,112 PSay ( cTrbRis )->FUNCAO
		@ Li,128 PSay ( cTrbRis )->TAREFA
		@ Li,138 PSay ( cTrbRis )->DEPTO
		Dbskip()
	End
	EndIf
	//DADOS DA PREVISAO DOS RISCOS
	Dbselectarea(cAliasCC)
	Dbsetorder(1)
	Dbseek(xFilial(cAliasCC)+mv_par02)
	Dbselectarea("SRJ")
	Dbsetorder(1)
	Dbseek(xFilial("SRJ")+mv_par03)
	Dbselectarea("SQB")
	Dbsetorder(1)
	Dbseek(xFilial("SQB")+mv_par05)

	cCustoNew := If(Alltrim(mv_par03) == "*" , STR0019 , SRJ->RJ_DESC) //"Todas"

	Somalinha()
	Somalinha()
	@ Li,000 PSay STR0020 //"Ambiente Novo"
	Somalinha()
	@ Li,006 PSay STR0013    //"Centro de Custo.:"
	@ Li,024 PSay Substr(Alltrim(mv_par02)+" - "+&cDescr,1,52)
	@ Li,077 PSay STR0014+dtoc(dNEW_CCUSTO) //"a partir de: "
	Somalinha()
	@ Li,006 PSay STR0015                         //"Funcao..........:"
	@ Li,024 PSay Alltrim(mv_par03)+" - "+cCustoNew
	@ Li,077 PSay STR0014+dtoc(dNEW_FUNCAO) //"a partir de: "
	Somalinha()
	@ Li,006 PSay STR0042//"Departamento....:"
	@ Li,024 PSay Alltrim(mv_par05)+" - "+If(Alltrim(mv_par05) == "*" , STR0048 , SQB->QB_DESCRIC) //"Todos"
	@ Li,077 PSay STR0014+dtoc(dNEW_DEPTO) //"a partir de: "
	Somalinha()
	@ Li,006 PSay STR0016      //"Tarefas.........:"
	For xx := 1 to len(aTarefaX)
		If Empty(aTarefaX[xx][3])
			aTarefaX[xx][3] := dDataBase
		EndIf
		@ Li,024 PSay Alltrim(aTarefaX[xx][1])+" - "+aTarefaX[xx][2]
		@ Li,077 PSay STR0014+dtoc(aTarefaX[xx][3]) //"a partir de: "
		Somalinha()
	Next xx
	If len(aTarefaX) == 0
		Somalinha()
	EndIf

	/*        1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		Num.Risco  Agente            Fonte Geradora    Avaliacao Intensid.  U.M.    C.Custo               Funcao          Tarefa  Novo
		xxxxxxxxx  1234567890123456  1234567890123456  xx/xx/xx  xxxxx,xxx  xxxxxx  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxx  xxxxxx  xxx
	*/

	Dbselectarea(cTrbRis)
	Dbgotop()
	If DBseek("2")
		Somalinha()
		@ Li,006 PSay STR0017 //"Riscos"
		Somalinha()
		@ Li,006 PSay STR0026 // "Num.Risco  Agente            Fonte Geradora    Avaliacao Intensid.    U.M.    C.Custo               Funcao          Tarefa  Departamento   Novo"
		Somalinha()
		While !eof() .And. ( cTrbRis )->TIPO == "2"
			Somalinha()
			@ Li,06 PSay ( cTrbRis )->NUMFIC
			@ Li,17 PSay Substr(Alltrim(( cTrbRis )->NOMAGE),1,16)
			@ Li,35 PSay Substr(Alltrim(( cTrbRis )->NOMFON),1,16)
			@ Li,53 PSay ( cTrbRis )->DTAVAL
			@ Li,64 PSay ( cTrbRis )->INTENS
			@ Li,076 PSay ( cTrbRis )->UNIDAD
			@ Li,084 PSay ( cTrbRis )->CCUSTO
			@ Li,106 PSay ( cTrbRis )->FUNCAO
			@ Li,122 PSay ( cTrbRis )->TAREFA
			@ Li,130 PSay ( cTrbRis )->DEPTO
			@ Li,145 PSay ( cTrbRis )->NOVO
			Dbskip()
		End
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} EPIMDT520
Imprime os Epis que o funcionario necessitara.

@type    function

@author  Denis Hyroshi de Souza
@since   13/02/2002

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function EPIMDT520()

	Dbselectarea(cTrbRis)
	Dbgotop()
	DBseek("2")
	While !eof() .And. ( cTrbRis )->TIPO == "2"
		Dbselectarea("TNX")
		Dbsetorder(1)
		Dbseek(xFilial("TNX")+( cTrbRis )->NUMFIC)
		While !eof() .And. xFilial("TNX") == TNX->TNX_FILIAL .And. ;
			( cTrbRis )->NUMFIC == TNX->TNX_NUMRIS

			Dbselectarea("SB1")
			Dbsetorder(1)
			Dbseek(xFilial("SB1")+TNX->TNX_EPI)

			Dbselectarea( cTrbEPI )
			Dbgotop()
			If !Dbseek(TNX->TNX_EPI)
				( cTrbEPI )->(Dbappend())
				( cTrbEPI )->EPI    := TNX->TNX_EPI
				( cTrbEPI )->DESCRI := SB1->B1_DESC
			EndIf

			Dbselectarea("TNX")
			Dbskip()
		End
		Dbselectarea(cTrbRis)
		Dbskip()
	End
	lPrim := .T.
	Dbselectarea(cTrbEPI)
	Dbgotop()
	While !eof()
		Somalinha()
		If lPrim
			Somalinha()
			Somalinha()
			@Li,006 Psay STR0022		 //"Epi's Necessarios.:"
			lPrim := .F.
		EndIf
		@Li,029 Psay Alltrim(( cTrbEPI )->EPI)+" - "+( cTrbEPI )->DESCRI
		Dbskip()
	End

Return Nil
/*        1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
      Num. Risco Agente                      Fonte Geradora                Avaliacao Intensidade U.M.   C.Custo   Funcao Tarefa Novo
      XXXXXXXXX  XXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXXXX XXXXXXXXXXXXXXXXXXXX 99/99/99  99,999.999  XXXXXX XXXXXXXXX XXXXX  XXXXXX XXX
*/

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT520CC
Valida o centro de custo

@type    function

@author  Andre Perez Alvarez
@since   03/05/2007

@param   cCodCC, Caracter, Código do Centro de Custo

@return  Lógico, Retorna se o centro de custo é válido
/*/
//-------------------------------------------------------------------
User Function MDT520CC(cCodCC)

	Local aAreaSRA := SRA->(GetArea())

	dbSelectArea("SRA")
	dbSetOrder(1)
	dbSeek(xFilial("SRA")+mv_par01)
	If SubStr(cCodCC,1,nSizeTD) <> SubStr(SRA->RA_CC,1,nSizeTD)
		msgStop(STR0023)  //"O centro de custo deve pertencer ao mesmo cliente onde o funcionário está localizado."
		RestArea(aAreaSRA)
		Return .F.
	EndIf

	RestArea(aAreaSRA)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT520POS
Valida o centro de custo

@type    function

@author  Andre Perez Alvarez
@since   03/05/2007

@param   cMat, Caracter, Matrícula do Funcionário

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function MDT520POS(cMat)

	Local aAreaSRA := SRA->(GetArea())

	dbSelectArea("SRA")
	dbSetOrder(1)
	dbSeek(xFilial("SRA")+cMat)

	cCliMdtps := SubStr(SRA->RA_CC,1,nSizeTD)

	RestArea(aAreaSRA)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT520TOS
Valida a funcao

@type    function

@author  Andre Perez Alvarez
@since   03/05/2007

@param   cCodFun, Caracter, Código da Função

@return  Lógico, Retorna se função é válida
/*/
//-------------------------------------------------------------------
User Function MDT520TOS(cCodFun)

	Local aAreaTOS := TOS->(GetArea())

	dbSelectArea("SRA")
	dbSetOrder(1)
	dbSeek(xFilial("SRA")+mv_par01)

	cCliMdtps := SubStr(SRA->RA_CC,1,nSizeTD)

	dbSelectArea("TOS")
	dbSetOrder(1)  //TOS_FILIAL+TOS_CODFUN+TOS_CLIENT+TOS_LOJA
	If !dbSeek(xFilial("TOS")+cCodFun+cCliMdtps)
		msgStop(STR0027) //"A função selecionada não pertence ao cliente onde o funcionário está localizado."
		RestArea(aAreaTOS)
		Return .F.
	EndIf

	RestArea(aAreaTOS)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT520TN5
Valida a tarefa

@type    function

@author  Andre Perez Alvarez
@since   03/05/2007

@param   cCodTar, Caracter, Código da Tarefa

@return  Lógico, Retorna se tarefa é válida
/*/
//-------------------------------------------------------------------
User Function MDT520TN5(cCodTar)

	Local aAreaTN5 := TN5->(GetArea())

	dbSelectArea("SRA")
	dbSetOrder(1)
	dbSeek(xFilial("SRA")+mv_par01)

	cCliMdtps := SubStr(SRA->RA_CC,1,nSizeTD)

	dbSelectArea("TN5")
	dbSetOrder(3)  //TN5_FILIAL+TN5_CLIENT+TN5_LOJA+TN5_CODTAR
	If !dbSeek(xFilial("TN5")+cCliMdtps+cCodTar)
		msgStop(STR0028) //"A tarefa selecionada não pertence ao cliente onde o funcionário está localizado."
		RestArea(aAreaTN5)
		Return .F.
	EndIf

	RestArea(aAreaTN5)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT520M4
Valida a tarefa

@type    function

@author  Andre Perez Alvarez
@since   03/05/2007

@return  Lógico, Retorna se tarefa é válida
/*/
//-------------------------------------------------------------------
User Function MDT520M4()

Return ExistCpo('TN5',mv_par04) .And. U_MDT520TN5(mv_par04)

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT520MLT
Retorna os riscos

@type    function

@author  Denis Hyroshi de Souza
@since   01/02/2008

@return  Lógico, Retorna confirmação da tela
/*/
//-------------------------------------------------------------------
User Function MDT520MLT()

	Local x, y, xx
	Local aArea := GetArea()
	Local oDlgF,oFont
	Local cBuscaEx := Space(40)
	Local oMARK1
	Local cSRAF3 := "SRA"
	Local cF3CC := "MDTPS4"  //SI3 apenas do cliente
	Local oPnlAmb
	Local nPosX := 0

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cF3CC := "MDTPS6"  //CTT apenas do cliente
	EndIf

	Private cMatriNom := Space(25)
	Private cCustoNom := Space(25)
	Private cFuncaNom := Space(25)
	Private cDeptoNom := Space(25)

	cF3_CTT := cAliasCC
	cF3_SRJ := "SRJ"

	lInverte := .F.
	lQuery   := .T.

	dbSelectArea("TO1")
	aTRB1 := {}
	AADD(aTRB1,{ "TN5_OK"    ,NIL," ",})
	AADD(aTRB1,{ "TN5_CODTAR",NIL,STR0029,}) //"Código"
	AADD(aTRB1,{ "TN5_NOMTAR",NIL,STR0030,}) //"Nome"

	cSeekRis  := xFilial("TN5")
	Private cWhileRis := '.T.'
	nIndRis := 1
	If lSigaMdtPs
		cSeekRis  := xFilial("TN5")+cCliMdtPs
		cWhileRis := 'TN5->TN5_CLIENT+TN5->TN5_LOJA == cCliMdtPs'
		nIndRis   := 3
	EndIf

	dbSelectArea("TN5")
	dbSetOrder(nIndRis)
	dbSeek(cSeekRis)
	While !eof() .And. TN5->TN5_FILIAL == xFilial("TN5") .And. &(cWhileRis)
		( cTrb520 )->(DbAppend())
		( cTrb520 )->TN5_CODTAR := TN5->TN5_CODTAR
		( cTrb520 )->TN5_NOMTAR := TN5->TN5_NOMTAR
		( cTrb520 )->TN5_MARK   := "ZZ"
		dbSelectArea("TN5")
		dbSkip()
	End

	Mv_par01 := Space(Len(Mv_par01))
	Mv_par02 := Space(Len(Mv_par02))
	Mv_par03 := Space(Len(Mv_par03))

	Private cSvPar01 := Mv_par01

	If lSigaMdtps
		cSRAF3  := "MDTPSA"
		cF3_CTT := cF3CC
		cF3_SRJ := "TOS001"
	EndIf

	If ExistBlock("MDTR5202")
		cSRAF3 := ExecBlock('MDTR5202',.F.,.F.)
	EndIf

	dbSelectArea(cTrb520)
	dbSetOrder(1)
	dbGoTop()

	aExaInd  := {"1="+STR0031,"2="+STR0030,"3="+STR0032} //"Codigo"###"Nome"###"Marcados"
	cIndExam := "1"

	nOpca1 := 2
	DEFINE FONT oFont NAME "Arial" SIZE 0,-12
	DEFINE MSDIALOG oDlgF TITLE OemToAnsi(STR0033) From 0,0 To 500,670 COLOR CLR_BLACK,CLR_WHITE OF oMainWnd Pixel//"Selecione o novo ambiente para o funcionário"

	oPnlAmb							:=	tPanel():New(00,00,,oDlgF,,.F.)
	oPnlAmb:Align					:= CONTROL_ALIGN_ALLCLIENT

	@ 05,10  SAY OemToAnsi(STR0034) Pixel OF oPnlAmb  //"Matrícula"
	@ 05,90  MSGET Mv_par01 Picture "@!" Size 70,8  Valid (ExistCpo("SRA",Mv_par01) .And. fRetNome(Mv_par01,1,@oMARK1)) F3 cSRAF3 When .T. HasButton Pixel OF oPnlAmb
	@ 05,190 MSGET cMatriNom Picture "@!" Size 100,8 When .F. Pixel OF oPnlAmb

	@ 17,10  SAY OemToAnsi(STR0035) Pixel OF oPnlAmb //"Novo Centro de Custo"
	@ 17,90  MSGET Mv_par02 Picture "@!" Size 70,8  Valid (ExistCpo(cAliasCC,Mv_par02) .And. fRetNome(Mv_par02,2)) F3 cF3_CTT When .T. HasButton Pixel OF oPnlAmb
	@ 17,190 MSGET cCustoNom Picture "@!" Size 100,8 When .F. Pixel OF oPnlAmb

	@ 29,10  SAY OemToAnsi(STR0036) Pixel OF oPnlAmb //"Nova Função"
	@ 29,90  MSGET Mv_par03 Picture "@!" Size 40,8  Valid (ExistCpo("SRJ",Mv_par03) .And. fRetNome(Mv_par03,3)) F3 cF3_SRJ When .T. HasButton Pixel OF oPnlAmb
	@ 29,190 MSGET cFuncaNom Picture "@!" Size 100,8 When .F. Pixel OF oPnlAmb

		If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
			@ 41,10  SAY OemToAnsi(STR0043) Pixel OF oPnlAmb //"Novo Departamento"
			@ 41,90  MSGET Mv_par05 Picture "@!" Size 40,8  Valid ((AllTrim(Mv_par05) == '*' .Or. ExistCpo("SQB",Mv_par05)) .And. fRetNome(Mv_par05,4)) F3 "MDTSQB" When .T. HasButton Pixel OF oPnlAmb
			@ 41,190 MSGET cDeptoNom Picture "@!" Size 100,8 When .F. Pixel OF oPnlAmb
			aCordMark := {70,15,200,325}
		Else
			nPosX := 10
			aCordMark := {60,15,180,325}
		EndIf

		@ 50-nPosX,8 TO 203,330 LABEL STR0037 Pixel OF oPnlAmb //"Novas Tarefas"
		@ 58-nPosX,15  SAY OemToAnsi(STR0038) Pixel OF oPnlAmb //"Ordenar Por"
		@ 58-nPosX,66  COMBOBOX oCbx1 VAR cIndExam ITEMS aExaInd Valid fExaAlInd(@oMARK1,cTrb520) SIZE 45,8 Pixel OF oPnlAmb WHEN .T.

		@ 58-nPosX,130 Say OemToAnsi(STR0039) Pixel OF oPnlAmb //"Localizar Tarefa"
		@ 58-nPosX,190 MsGet oGetTarr Var cBuscaEx Valid fLocTarefa(cBuscaEx,@oMARK1) Picture '@!' Size 100,8 Pixel OF oPnlAmb

	oMARK1							:= MsSelect():NEW(cTrb520,"TN5_OK",,aTRB1,@lINVERTE,@cMARCA,aCordMark,,,oPnlAmb)
	oMARK1:bMARK					:= {|| U_MDT520MKFU(@oMARK1)}
	oMARK1:oBROWSE:lHASMARK		:= .T.
	oMARK1:oBROWSE:lCANALLMARK	:= .T.
	oMARK1:oBROWSE:bALLMARK		:= {|| U_MDTA520INV(cMarca,.F.) }
	ACTIVATE MSDIALOG oDlgF ON INIT EnchoiceBar(oDlgF,{|| nOpca1 := 1, If(!fVldTarefa(),nOpca1 := 0,oDlgf:End()) },{|| nOpca1 := 2,oDlgf:End() }) CENTERED

	lRet := .F.
	If nOpca1 == 1
		lRet := .T.
		aTarefaX := {}
		dbSelectArea(cTrb520)
		dbGoTop()
		While !eof()
			If !Empty(( cTrb520 )->TN5_OK)
				aAdd( aTarefaX , { ( cTrb520 )->TN5_CODTAR , ( cTrb520 )->TN5_NOMTAR , StoD("") } )
			EndIf
			dbSkip()
		End
	EndIf

	RestArea(aArea)
	lRefresh := .T.

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fVldTarefa
Valida tela de selecao de parametro

@type    function

@author  Denis Hyroshi de Souza
@since   27/07/2003

@return  Lógico, Retorna se tarefa é válida
/*/
//-------------------------------------------------------------------
Static Function fVldTarefa()


	If Empty(Mv_par01) .Or. Empty(Mv_par02) .Or. Empty(Mv_par03) .Or. Empty(Mv_par05)
		HELP(" ",1,"OBRIGAT")
		Return .F.
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA520INV
Inverte a marcacao do browse de todos

@type    function

@author  Denis Hyroshi de Souza
@since   27/07/2003

@param   cMarca, caracter, Objeto do MarkBrowse
@param   lTNB, Null, Compatibilidade

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function MDTA520INV(cMarca,lTNB)

	Local aArea := GetArea()

	dbSelectArea(cTrb520)
	Dbgotop()
	While !eof()
		( cTrb520 )->TN5_OK   := IF(( cTrb520 )->TN5_OK == "  ",cMARCA,"  ")
		( cTrb520 )->TN5_MARK := IF(Empty(( cTrb520 )->TN5_OK),"ZZ","  ")
		dbSkip()
	End

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT520MKFU
Inverte a marcacao do browse

@type    function

@author  Denis Hyroshi de Souza
@since   27/07/2003

@param   oMark1, Objeto, Objeto do MarkBrowse

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDT520MKFU(oMARK1)

	( cTrb520 )->TN5_MARK := IF(Empty(( cTrb520 )->TN5_OK),"ZZ","  ")
	If cIndExam == "3"
		( cTrb520 )->(dbGoTop())
		oMARK1:oBROWSE:REFRESH(.T.)
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fRetNome
Retorna nome do funcionario, centro de custo e funcao

@type    function

@author  Denis Hyroshi de Souza
@since   27/07/2003

@param   cCod, Caracter, Matrícula do funcionário
@param   nTableTmp, Numérico, Tabela a ser pesquisada (1-SRA, 2-CTT, 3-SRJ, 4-SQB)
@param   oMark1, Objeto, Objeto do MarkBrowse
@param   cCodSRA, Caracter, Matrícula do funcionário

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function fRetNome(cCod,nTableTmp,oMARK1,llSkip)

	If nTableTmp == 1
		If lSigaMdtps
			U_MDT520POS(cCod)
		EndIf
		dbSelectArea("SRA")
		dbSetOrder(1)
		dbSeek(xFilial("SRA")+cCod)
		cMatriNom := Substr(SRA->RA_NOME,1,25)
		If cSvPar01 <> Mv_par01
			Mv_par02 := SRA->RA_CC
			Mv_par03 := SRA->RA_CODFUNC
			Mv_par05 := SRA->RA_DEPTO
			fRetNome(Mv_par02,2,,.T.)
			fRetNome(Mv_par03,3,,.T.)
			fRetNome(Mv_par05,4,,.T.)
			fCarrTar(Mv_par01)
			( cTrb520 )->(dbGoTop())
			oMARK1:oBROWSE:REFRESH(.T.)
		EndIf
		cSvPar01 := Mv_par01
	ElseIf nTableTmp == 2
		If ValType(llSkip) == "U"
			If lSigaMdtps
				If !U_MDT520CC(cCod)
					Return .F.
				EndIf
			EndIf
		EndIf
		dbSelectArea(cAliasCC)
		dbSetOrder(1)
		dbSeek(xFilial(cAliasCC)+cCod)
		cCustoNom := Substr(&cDescr,1,25)
	ElseIf nTableTmp == 3
		If ValType(llSkip) == "U"
			If lSigaMdtps
				U_MDT520TOS(cCod)
			EndIf
		EndIf
		dbSelectArea("SRJ")
		dbSetOrder(1)
		dbSeek(xFilial("SRJ")+cCod)
		cFuncaNom := Substr(SRJ->RJ_DESC,1,25)
	ElseIf nTableTmp == 4
		dbSelectArea("SQB")
		dbSetOrder(1)
		dbSeek(xFilial("SQB")+cCod)
		cDeptoNom := If(AllTrim(cCod) =='*',STR0048,Substr(SQB->QB_DESCRIC,1,25))//"Todos"
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} fCarrTar
Carrega tarefas do funcionario

@type    function

@author  Denis Hyroshi de Souza
@since   27/11/2007

@param   oMark1, Objeto, Objeto do MarkBrowse
@param   cCodSRA, Caracter, Matrícula do funcionário

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function fCarrTar(cCodSRA)

	Local dtIni := dDataBase
	Local dtFim := dDataBase+1
	Local aTar  := {}
	Local aArea := GetArea()
	Local aAre2 := ( cTrb520 )->(GetArea())

	If lSigaMdtPs
		dbSelectArea(cTrb520)
		Zap
		dbSelectArea("TN5")
		dbSetOrder(3)
		dbSeek(xFilial("TN5")+cCliMdtPs)
		While !eof() .And. TN5->TN5_FILIAL == xFilial("TN5") .And. TN5->TN5_CLIENT+TN5->TN5_LOJA == cCliMdtPs
			( cTrb520 )->(DbAppend())
			( cTrb520 )->TN5_CODTAR := TN5->TN5_CODTAR
			( cTrb520 )->TN5_NOMTAR := TN5->TN5_NOMTAR
			( cTrb520 )->TN5_MARK   := "ZZ"
			dbSelectArea("TN5")
			dbSkip()
		End
	EndIf

	dbSelectArea("TN6")
	dbSetOrder(2)
	dbSeek(xFilial("TN6")+cCodSRA)
	While !eof() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. cCodSRA == TN6->TN6_MAT
		If TN6->TN6_DTINIC >= dtFim .Or. (TN6->TN6_DTTERM < dtIni .And. !Empty(TN6->TN6_DTTERM))
			dbSelectArea("TN6")
			dbSkip()
			Loop
		EndIf
		dbSelectArea( cTrb520 )
		dbSetOrder(1)
		If dbSeek(TN6->TN6_CODTAR)
			( cTrb520 )->TN5_OK   := cMARCA
			( cTrb520 )->TN5_MARK := "  "
			aAdd( aTar , TN6->TN6_CODTAR )
		EndIf
		dbSelectArea("TN6")
		dbSkip()
	End

	dbSelectArea(cTrb520)
	dbSetOrder(1)
	dbGoTop()
	While !eof()
		If aSCAN(aTar, {|x| x == ( cTrb520 )->TN5_CODTAR }) == 0
			( cTrb520 )->TN5_OK   := "  "
			( cTrb520 )->TN5_MARK := "ZZ"
		EndIf
		dbSelectArea("TN6")
		dbSkip()
	End

	RestArea(aAre2)
	RestArea(aArea)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fExaAlInd
Troca indice

@type    function

@author  Denis Hyroshi de Souza
@since   27/11/2007

@param   oMark1, Objeto, Objeto do MarkBrowse
@param   cAliasTMP, Caracter, Alias do arquivo temporário

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function fExaAlInd(oMARK1,cAliasTMP)

	dbSelectArea(cAliasTMP)
	If cIndExam == "1"
		dbSetOrder(1)
		oGetTarr:Enable()
	ElseIf cIndExam == "2"
		dbSetOrder(2)
		oGetTarr:Enable()
	ElseIf cIndExam == "3"
		dbSetOrder(3)
		oGetTarr:Disable()
	EndIf

	oMARK1:oBROWSE:REFRESH(.T.)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} fExaAlInd
Troca indice

@type    function

@author  Denis Hyroshi de Souza
@since   27/11/2007

@param   cBuscaEx, Caracter, Tarefa a ser localizada
@param   oMark1, Objeto, Objeto do MarkBrowse

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function fLocTarefa(cBuscaEx,oMARK1)

	Local cOldTa := Alias()
	Local aArea1 := ( cTrb520 )->(GetArea())
	Local lAchou := .F.

	If Empty(cBuscaEx)
		Return .T.
	EndIf

	dbSelectArea(cTrb520)
	dbGoTop()
	If dbSeek(Alltrim(cBuscaEx),.T.)
		oMARK1:oBROWSE:REFRESH(.T.)
		oMARK1:oBROWSE:SetFocus()
		lAchou := .T.
	Else
		RestArea(aArea1)
	EndIf

	If !lAchou
		MsgInfo(STR0040,STR0041) //"Não foi possível localizar esta tarefa."###"Atenção"
		Return .T.
	EndIf

	dbSelectArea(cOldTa)

Return .T.
