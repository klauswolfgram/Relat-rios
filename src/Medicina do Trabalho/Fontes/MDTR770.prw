/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr770.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR770
Relatorio de funcionarios com estabilidade.
Lista os funcionarios membros ou ex-membros da CIPA que tem
alguma estabilidade, de acordo com a NR-5.

@author Liber de Esteban
@since 12/11/2004
@return Nil
/*/
//---------------------------------------------------------------------
User Function MDTR770()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"
	Local wnrel   := "MDTR770"
	Local limite  := 132
	Local cDesc1  := STR0001 //"Relatorio dos funcionarios com estabilidade num determinado periodo."
	Local cDesc2  := If(lCipatr, STR0017, STR0002) //"De acordo com a NR-31, um funcionário membro da CIPATR tem estabilidade" //"De acordo com a NR-5, um funcionário membro da CIPA/CIPATR tem estabilidade"
	Local cDesc3  := STR0003 //"da data de sua candidatura ate 1 ano após o fim do mandato."
	Local cString := "TM1"
	Local nTamCTT := TAMSX3("CTT_CUSTO")[1]

	SetKey( VK_F9, { | | NGVersao( "MDTR770" , 1 ) } )

	Private nomeprog := "MDTR770"
	Private tamanho  := "M"
	Private aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",2 } //"Zebrado"###"Administracao"
	Private titulo   := STR0006 //"Estabilidade no Periodo"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := "MDT770"
	Private cabec1, cabec2

	Private cAlias := "CTT"
	Private cDescr := "CTT->CTT_DESC01"

	Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	Private nSizeSA1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	Private nSizeLoj := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))

	/*-----------------------
	//PERGUNTAS PADRÃO		|
	| De Funcionario ?		|
	| Ate Funcionario ?		|
	| De Função ?			|
	| AtÉ Função ?			|
	| De Centro Custo ?		|
	| Ate Centro Custo ?	|
	| De Data ?				|
	| Ate Data ?			|
	-------------------------*/

	// Verifica as perguntas selecionadas
	pergunte(cPerg,.F.)

	// Envia controle para a funcao SETPRINT
	wnrel:="MDTR770"

	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to
		Return
	Endif

	RptStatus({|lEnd| U_R770Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} R770Imp
Impressão do relatório

@author Liber de Esteban
@since 12/11/1994

@param lEnd - Cancela a impressão
@param wnRel - Nome do relatório
@param titulo - Informa o titulo do relatório
@param tamanho - Indica tamanho do relatório
/*/
//---------------------------------------------------------------------
User Function R770Imp(lEnd,wnRel,titulo,tamanho)

	// Define Variaveis
	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local nXYZ
	Local lNG2Sup := SuperGetMv( "MV_NG2CSUP" , .F. , "1" ) == "2"

	// Variaveis para controle do cursor de progressao do relatorio ³
	Local nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

	// Variaveis locais exclusivas deste programa

	Local cChave           := SPACE(16)
	Local lContinua        := .T.
	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	// Monta os Cabecalhos
	cabec1 := STR0015 //"Mat.    Nome                            Centro de Custo          Função                       Mandat. Dt.Fim    Periodo Estabilidade"
	cabec2 := " "
	/*
			1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Mat.    Nome                            Centro de Custo          Função                       Mandat. Dt.Fim    Periodo Estabilidade
	-------------------------------------------------------------------------------------------------------------------------------------
	123456  123456789012345678901234567890  12345678901234567890123  123456789012345678901234567  123456  12/45/78  xx/xx/xx - xx/xx/xx
	xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxx  xx/xx/xx  xx/xx/xx - xx/xx/xx

	*/

	nTotRec := TNQ->(LastRec())
	nTotRec += TNO->(LastRec())
	aDados := {}
	aDadosLoop := {}

	dbSelectArea("TNQ")
	dbSetOrder(02)
	dbSeek(xFilial("TNQ")+MV_PAR01,.T.)

	SetRegua(nTotRec)

	// Correr TM1 para ler os  Medicamentos
	While lContinua .And. !Eof() .And. ;
		  TNQ->TNQ_FILIAL == xFIlial('TNQ') .And. TNQ->TNQ_MAT <= MV_PAR02

			cFil1Tmp := cFilAnt

			If !Empty(TNQ->TNQ_FILMAT)
				cFil1Tmp := TNQ->TNQ_FILMAT
			Endif

			dbSelectArea("SRA")
			dbSetOrder(01)

			If !dbSeek(xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT)
				aAdd( aDadosLoop , { TNQ->TNQ_MAT , cFil1Tmp } )
				dbSelectArea("TNQ")
				dbSkip()
				Loop
			Endif

			If SRA->RA_CODFUNC < mv_par03 .or. SRA->RA_CODFUNC > mv_par04
				aAdd( aDadosLoop , { TNQ->TNQ_MAT , cFil1Tmp } )
				dbSelectArea("TNQ")
				dbSkip()
				Loop
			EndIf

			If SRA->RA_CC < mv_par05 .or. SRA->RA_CC > mv_par06
				aAdd( aDadosLoop , { TNQ->TNQ_MAT , cFil1Tmp } )
				dbSelectArea("TNQ")
				dbSkip()
				Loop
			EndIf

			If lNG2Sup .And. TNQ->TNQ_TIPCOM == "2"
				aAdd( aDadosLoop , { TNQ->TNQ_MAT , cFil1Tmp } )
				dbSelectArea("TNQ")
				dbSkip()
				Loop
			EndIf

			If TNQ->TNQ_INDICA == "1"
				aAdd( aDadosLoop , { TNQ->TNQ_MAT , cFil1Tmp } )
				dbSelectArea("TNQ")
				dbSkip()
				Loop
			EndIf

			dbSelectArea("TNO")
			dbSetOrder(01)
			dbSeek(xFilial("TNO")+TNQ->TNQ_MANDAT+TNQ->TNQ_MAT)

			If lSigaMdtPS
				Dbselectarea("TNN")
				DbSetOrder(3)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
				Dbseek(xFilial("TNN")+SubStr(SRA->RA_CC,1,nSizeSA1+nSizeLoj)+TNQ->TNQ_MANDAT)
			Else
				Dbselectarea("TNN")
				DbSetOrder(1)
				Dbseek(xFilial("TNN")+TNQ->TNQ_MANDAT)
			Endif

			dEstabde  := TNO->TNO_DTCAND
			dEstabate := DTOS(TNN->TNN_DTTERM)

			nAno := SubStr(dEstabate, 1, 4)
			nMes := SubStr(dEstabate, 5, 2)
			nDia := SubStr(dEstabate, 7, 2)
			nAno := Alltrim(STR(VAL(nAno) + 1))
			dEstabate := CTOD(ndia+"/"+nMes+"/"+nAno)

			// Se ano fim mandato for bissexto e terminar em 29/02, dia fim da estabilidade sera 28/02 do ano seguinte
			If Substr( DtoS(TNN->TNN_DTTERM) ,5,4) == "0229"
				dEstabate := CTOD("28"+"/"+"02"+"/"+nAno)
			Endif

			If dEstabde > mv_par08 .Or. dEstabate < mv_par07 .Or. Empty(dEstabde) .Or. Empty(dEstabate)
				dbSelectArea("TNQ")
				dbSkip()
				Loop
			EndIf

			IncRegua()

			dbSelectArea(cAlias)
			dbSetOrder(1)
			dbSeek(xFilial(cAlias,cFil1Tmp)+SRA->RA_CC)
			dbSelectArea("SRJ")
			dbSetOrder(1)
			dbSeek(xFilial("SRJ",cFil1Tmp)+SRA->RA_CODFUNC)

			nPosDad := aSCAN(aDados, {|x| x[1]+x[9] == SRA->RA_MAT+cFil1Tmp })

			If nPosDad == 0
				aAdd( aDados , { SRA->RA_MAT , SubStr(SRA->RA_NOME,1,30) , Substr(&cDescr,1,23) , Substr(SRJ->RJ_DESC,1,27) ,;
								TNQ->TNQ_MANDAT , TNN->TNN_DTTERM , dEstabde , dEstabate , cFil1Tmp } )
			ElseIf dEstabate > aDados[nPosDad,8]
				aDados[nPosDad,5] := TNQ->TNQ_MANDAT
				aDados[nPosDad,6] := TNN->TNN_DTTERM
				aDados[nPosDad,7] := dEstabde
				aDados[nPosDad,8] := dEstabate
			Endif

			dbSelectArea("TNQ")
			dbskip()
	Enddo

	dbSelectArea("TNO")
	dbSetOrder(02)
	dbSeek(xFilial("TNO")+MV_PAR01,.T.)

	While lContinua                                .And.;
		!Eof()                                   .AND.;
		TNO->TNO_FILIAL == xFIlial('TNO')        .AND.;
		TNO->TNO_MAT <= MV_PAR02

			cFil1Tmp := cFilAnt
			If !Empty(TNO->TNO_FILMAT)
				cFil1Tmp := TNO->TNO_FILMAT
			Endif

			If aSCAN(aDadosLoop, {|x| x[1]+x[2] == TNO->TNO_MAT+cFil1Tmp }) > 0
				dbSelectArea("TNO")
				dbSkip()
				Loop
			Endif

			dbSelectArea("SRA")
			dbSetOrder(01)
			If !dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT)
				dbSelectArea("TNO")
				dbSkip()
				Loop
			Endif

			If SRA->RA_CODFUNC < mv_par03 .or. SRA->RA_CODFUNC > mv_par04
				dbSelectArea("TNO")
				dbSkip()
				Loop
			EndIf

			If SRA->RA_CC < mv_par05 .or. SRA->RA_CC > mv_par06
				dbSelectArea("TNO")
				dbSkip()
				Loop
			EndIf

			If lSigaMdtPS
				Dbselectarea("TNN")
				DbSetOrder(1)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
				Dbseek(xFilial("TNN")+SubStr(SRA->RA_CC,1,nSizeSA1+nSizeLoj)+TNO->TNO_MANDAT)
			Else
				Dbselectarea("TNN")
				DbSetOrder(1)
				Dbseek(xFilial("TNN")+TNO->TNO_MANDAT)
			Endif

			dEstabde  := TNO->TNO_DTCAND
			dEstabate := TNN->TNN_ELEICA

			If dEstabde > mv_par08 .or. dEstabate < mv_par07 .or. Empty(dEstabde) .or. Empty(dEstabate)
				dbSelectArea("TNO")
				dbSkip()
				Loop
			EndIf

			IncRegua()

			dbSelectArea(cAlias)
			dbSetOrder(1)
			dbSeek(xFilial(cAlias,cFil1Tmp)+SRA->RA_CC)
			dbSelectArea("SRJ")
			dbSetOrder(1)
			dbSeek(xFilial("SRJ",cFil1Tmp)+SRA->RA_CODFUNC)

			nPosDad := aSCAN(aDados, {|x| x[1]+x[9] == SRA->RA_MAT+cFil1Tmp })

			If nPosDad == 0
				aAdd( aDados , { SRA->RA_MAT , SubStr(SRA->RA_NOME,1,30) , Substr(&cDescr,1,23) , Substr(SRJ->RJ_DESC,1,27) ,;
								TNO->TNO_MANDAT , TNN->TNN_ELEICA , dEstabde, dEstabate , cFil1Tmp } )
			Else
				If dEstabate > aDados[nPosDad,8]
					aDados[nPosDad,5] := TNO->TNO_MANDAT
					aDados[nPosDad,6] := TNN->TNN_ELEICA
					aDados[nPosDad,7] := dEstabde
					aDados[nPosDad,8] := dEstabate
				Endif
			Endif

			dbSelectArea("TNO")
			dbskip()
	Enddo

	ASORT(aDados,,,{|x,y| x[1] < y[1] })

	For nXYZ := 1 To Len(aDados)
		SomaLinha()
		@ Li,000 PSay aDados[nXYZ,1]
		@ Li,008 PSay aDados[nXYZ,2]
		@ Li,040 PSay aDados[nXYZ,3]
		@ Li,065 PSay aDados[nXYZ,4]
		@ Li,094 PSay aDados[nXYZ,5]
		@ Li,102 PSay DataTxt(aDados[nXYZ,6])
		@ Li,112 PSay DataTxt(aDados[nXYZ,7]) +  " - " + DataTxt(aDados[nXYZ,8])
	Next nXYZ

	//----------------------------------------------------------------
	// Devolve a condicao original do arquivo principal
	//----------------------------------------------------------------
	RetIndex("TNQ")
	RetIndex("TNO")

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif

	//SET CENTURY ON
	MS_FLUSH()

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@author Inacio Luiz Kolling
@since 12/11/2011

/*/
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return

//---------------------------------------------------------------------
/*/{Protheus.doc} DataTxt
Converte data em texto

@author  Denis
@since 12/11/2011

@param dDataTmp - Variavel data

/*/
//---------------------------------------------------------------------
Static Function DataTxt(dDataTmp)
Local cDat := "  /  /  "
Local nDia, nMes, nAno

If !Empty(dDataTmp)
	nDia := Day(dDataTmp)
	nMes := Month(dDataTmp)
	nAno := Year(dDataTmp)
	cDat := StrZero(nDia,2) + "/" + StrZero(nMes,2) + "/" + SubStr(StrZero(nAno,4),3,2)
Endif

Return cDat