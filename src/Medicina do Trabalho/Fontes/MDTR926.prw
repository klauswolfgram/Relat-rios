/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR926.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR926
Impressao da folha de comprovante de votacao CIPA

@return Nulo, Sempre nulo

@param cCodMandato, Caracter, Código do Mandato
@param cCliente, Caracter, Código do cliente
@param cLoja, Caracter, Código da loja

@author Denis Hyroshi de Souza
@since 09/10/2006
/*/
//---------------------------------------------------------------------
User Function MDTR926(cCodMandato,cCliente,cLoja)

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()
	Local aArea := GetArea()

	Private lCipatr    := SuperGetMv( "MV_NG2NR31", .F., "2" ) == "1"
	Private lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
	Private lMdtMin    := SuperGetMv( "MV_MDTMIN", .F., "N" ) == "S"

	Private nomeprog := "MDTR926"
	Private titulo   := STR0001 //"Comprovante de Votacao"
	Private cPerg    := If(!lSigaMdtPS,"MDT926    ","MDT926PS  ")

	If ExistBlock("MDTA111R")
		// Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"7-3"})//Tipo do Evento

		If ValType(cCodMandato) == "C"
			aAdd(aParam, {cCodMandato})
		Else
			aAdd(aParam, {""})
		Endif

		If lSigaMdtPS

			If ValType(cCliente) == "C" .AND. ValType(cLoja) == "C"
				aAdd(aParam, {cCliente})
				aAdd(aParam, {cLoja})
			Else
				aAdd(aParam, {""})
				aAdd(aParam, {""})
			Endif

		Endif

		lRet := ExecBlock("MDTA111R",.F.,.F.,aParam)

		If Type("lRet") <> "L"
			lRet := .F.
		Endif

		If lRet
			Return .T.
		Endif

	Endif

	/*-------------------------------
	|-----------PADRÃO--------------|
	| Mandato CIPA ?				|
	| Listar formulario ?			|
	| Qtas linhas para assinatura ?	|
	| Tipo de Impressao ?			|
	|-------------------------------|
	|----------PRESTADOR------------|
	| Cliente ?						|
	| Loja							|
	| Mandato CIPA ?				|
	| Listar formulario ?			|
	| Qtas linhas para assinatura ?	|
	| Tipo de Impressao ?			|
	---------------------------------*/

	If Pergunte(cPerg,.t.)
		Processa({|lEND| MDTA926IMP()},STR0002) //"Imprimindo..."
	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTA926IMP
Funcao de impressao

@return Nulo, Sempre nulo

@author Denis Hyroshi de Souza
@since 09/10/2006
/*/
//---------------------------------------------------------------------
Static Function MDTA926IMP()

	Local nInd
	Local nSizeCli := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	Local nSizeLoj := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	Local cTmpQry  := GetNextAlias()
	Local cFilCC   := "%%"

	Private oPrint  := FwMsPrinter():New( OemToAnsi(titulo))
	Private oFont12n := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private oFont12	:= TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFontCNEW := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
	Private l1st_page := .t. // Controla impressao da primeira pagina ou nao

	Lin := 4000
	oPrint:SetPortrait() //retrato

	nContFun := 0
	nPagina_ := 0

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(3)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		If Mv_par04 == 1 //Se imprimir formulario com o nome dos funcionarios

			dbSelectArea("SRA")
			dbSetOrder(3)
			Set Filter To xFilial("SRA") == SRA->RA_FILIAL .AND. SubStr(SRA->RA_CC,1,nSizeCli+nSizeLoj) == MV_PAR01+MV_PAR02 .AND.;
						!(SRA->RA_SITFOLH == "D" .or. !Empty(SRA->RA_DEMISSA)) .And.;
						!(SRA->RA_CATFUNC == 'A' .Or. SRA->RA_CATFUNC == 'E' .Or. SRA->RA_CATFUNC == 'G')  // Verifica se o funcionario nao eh autonomo ou estagiario.
			dbGoTop()

			While !eof()

				nContFun++
				Somalinha()

				// Linhas Verticais
				oPrint:Line(lin,100,lin+70,100)
				oPrint:Line(lin,250,lin+70,250)
				oPrint:Line(lin,1450,lin+70,1450)
				oPrint:Line(lin,2200,lin+70,2200)

				// Linhas Horizontais
				oPrint:Line(lin+70,100,lin+70,2200)

				oPrint:SayAlign(lin, 110, Str(nContFun,6), oFontCNEW, 150, 70, , 2, 0)
				oPrint:SayAlign(lin, 280, SRA->RA_NOME, oFont12, 1200, 70, , , 0)

				dbSelectArea("SRA")
				dbSkip()

			End

			dbSelectArea("SRA")
			Set Filter To

		Else // Se imprimir formulario em branco
			For nInd := 1 To Mv_par05
				Somalinha()

				// Linhas Verticais
				oPrint:Line(lin,100,lin+70,100)
				oPrint:Line(lin,250,lin+70,250)
				oPrint:Line(lin,1450,lin+70,1450)
				oPrint:Line(lin,2200,lin+70,2200)

				// Linhas Horizontais
				oPrint:Line(lin+70,100,lin+70,2200)

				oPrint:SayAlign(lin, 110, Str(nContFun,6), oFontCNEW, 150, 70, , 2, 0)
			Next nInd
		Endif

		If !l1st_page
			oPrint:EndPage()
		Endif

		If mv_par06 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)

		If Mv_par02 == 1 // Se imprimir formulario com o nome dos funcionarios

			If !Empty( TNN->TNN_CC )
				cFilCC := "% SRA.RA_CC = " + ValToSQL( TNN->TNN_CC ) + " AND %"
			EndIf

			BeginSQL Alias cTmpQry
				SELECT SRA.RA_NOME
					FROM %table:SRA% SRA
					WHERE 	SRA.RA_FILIAL = %xFilial:SRA% AND
							SRA.RA_SITFOLH <> 'D' AND
							SRA.RA_DEMISSA = %exp:SToD(Space(8))% AND
							SRA.RA_CATFUNC NOT IN ( 'A' , 'E' , 'G' ) AND
							%exp:cFilCC%
							SRA.%notDel%
					ORDER BY SRA.RA_NOME
			EndSQL

			While ( cTmpQry )->( !EoF() )
				nContFun++
				Somalinha()

				// Linhas Verticais
				oPrint:Line(lin,100,lin+70,100)
				oPrint:Line(lin,250,lin+70,250)
				oPrint:Line(lin,1450,lin+70,1450)
				oPrint:Line(lin,2200,lin+70,2200)

				// Linhas Horizontais
				oPrint:Line(lin+70,100,lin+70,2200)

				oPrint:SayAlign(lin, 110, Str(nContFun,6), oFontCNEW, 150, 70, , 2, 0)
				oPrint:SayAlign(lin, 280, ( cTmpQry )->RA_NOME, oFont12, 1200, 70, , , 0)

				( cTmpQry )->( dbSkip() )
			End

		Else // Se imprimir formulario em branco

			For nInd := 1 To Mv_par03
				nContFun++
				Somalinha()

				// Linhas Verticais
				oPrint:Line(lin,100,lin+70,100)
				oPrint:Line(lin,250,lin+70,250)
				oPrint:Line(lin,1450,lin+70,1450)
				oPrint:Line(lin,2200,lin+70,2200)

				// Linhas Horizontais
				oPrint:Line(lin+70,100,lin+70,2200)

				oPrint:SayAlign(lin, 110, Str(nContFun,6), oFontCNEW, 150, 70, , 2, 0)
			Next nInd

		Endif

		If !l1st_page
			oPrint:EndPage()
		Endif

		If mv_par04 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Endif

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Funcao de somar linha

@return Nulo, Sempre nulo

@author Denis Hyroshi de Souza
@since 09/10/2006
/*/
//---------------------------------------------------------------------
Static Function Somalinha()

	lin += 70

	If lin > 2900

		If !l1st_page
			oPrint:EndPage()
		Endif

		l1st_page := .f.

		oPrint:StartPage()

	// Localização do Logo da Empresa
	oPrint:SayBitMap(50,50,NGLocLogo(),250,50)

		lin := 150
		nPagina_ ++

		cTitTxt := IIf( lMdtMin, STR0014, IIf( lCipatr, STR0012, STR0003 ))+StrZero(Year(TNN->TNN_DTINIC),4) //"FOLHA DE VOTAÇÃO - CIPATR GESTÃO " //"FOLHA DE VOTAÇÃO - CIPA GESTÃO "

		If Year(TNN->TNN_DTINIC) <> Year(TNN->TNN_DTTERM)
			cTitTxt += "/"+Substr(StrZero(Year(TNN->TNN_DTTERM),4),3,2)
		Else
			cTitTxt += Space(5)
		Endif
		cTitTxt := PadR(cTitTxt,42)
		oPrint:Say(lin,750,cTitTxt,oFont12n)

		lin += 120

		oPrint:Box(lin,100,lin+70,2200)
		oPrint:Line(lin,250,lin+70,250)
		oPrint:Line(lin,1450,lin+70,1450)

		oPrint:Say(lin+50,700,STR0004,oFont12n) //"Funcionário"
		oPrint:Say(lin+50,1700,STR0005,oFont12n) //"Assinatura"

		lin += 70
	Endif

Return