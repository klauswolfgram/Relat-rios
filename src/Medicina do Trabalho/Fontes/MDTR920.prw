/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR920.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR920

Edital de convocacao para inscrição do mandato CIPA

@author  Denis Hyroshi de Souza
@since   16/10/2006

@sample  U_MDTR920(cCodMandato, cCliente, cLoja)

@param   cCodMandato, Caractere, Parametro usado em modo de prestador
@param   cCliente, Caractere, Parametro usado em modo de prestador
@param   cLoja, Caractere, Parametro usado em modo de prestador
/*/
//-------------------------------------------------------------------
User Function MDTR920(cCodMandato, cCliente, cLoja)

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local aArea := GetArea()

	Private lCipatr    := SuperGetMv( "MV_NG2NR31", .F., "2" ) == "1"
	Private lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
	Private lMdtMin    := SuperGetMv( "MV_MDTMIN", .F., "N" ) == "S"

	Private nomeprog := "MDTR920"
	Private titulo   := IIf( lMdtMin, STR0028, IIf( lCipatr, STR0023, STR0001 ))//"Edital de Convocação para Inscrição nas Eleições CIPATR" //"Edital de Convocação para Inscrição nas Eleições CIPA"
	Private cPerg    := If(!lSigaMdtPS,"MDT920    ","MDT920PS  ")

	If ExistBlock("MDTA111R")
		// Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"2"})//Tipo do Evento

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

		lRet := ExecBlock("MDTA111R", .F., .F., aParam)

		If Type("lRet") <> "L"
			lRet := .F.
		Endif

		If lRet
			Return .T.
		Endif

	Endif

	If lSigaMdtps
		cCliMdtps := ""
	Endif

	/*----------------------------------
	/PADRÃO								|
	|  Mandato CIPA ?					|
	|  Local Inscricao ?				|
	|  Data Inicio das Inscricoes ?		|
	|  Data Termino das Inscrições ?	|
	|  Quantas copias ?					|
	|  Tipo de Impressao ? 				|
	|  									|
	//PRESTADOR							|
	|  Cliente ?						|
	|  Loja								|
	|  Mandato CIPA ?					|
	|  Local Inscricao ?				|
	|  Data Inicio das Inscricoes ?		|
	|  Data Termino das Inscrições ?	|
	|  Quantas copias ?					|
	|  Tipo de Impressao ? 				|
	-----------------------------------*/

	If Pergunte(cPerg,.t.)
		Processa({|lEND| MDTA920IMP()},STR0002) //"Imprimindo..."
	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA920IMP

Funcao de impressao

@author  Denis Hyroshi de Souza
@since   09/10/2006

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function MDTA920IMP()

	Local nInd

	Private oPrint    := FwMSPrinter():New( OemToAnsi(titulo) ,, .T.)
	Private oFont12n  := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private oFont12   := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFont10   := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	Private oFontCNEW := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
	Private l1st_page := .t. // Controla impressao da primeira pagina ou nao

	Lin := 300
	oPrint:SetPortrait() //retrato

	nContFun := 0
	nPagina_ := 0

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(3)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		For nInd := 1 To Mv_par07

			oPrint:StartPage()
			// Localização do Logo da Empresa
			oPrint:SayBitMap(50,50,NGLocLogo(),250,50)
			oPrint:SayAlign(lin,200,NGSeek('SA1',TNN->(TNN_CLIENT+TNN_LOJAC),1,'SA1->A1_NOME'),oFont12n) //Nome do cliente
			oPrint:SayAlign(lin+200,300,STR0003,oFont12n,/*nWidth*/,/*nHeight*/,/*nClrText*/,/*nALignHorz*/2/*2-Centralizado*/,/*nALignVert*/) //"CONVOCAÇÃO PARA AS INSCRIÇÕES DOS CANDIDATOS A REPRESENTANTES"
			oPrint:SayAlign(lin+300,900,IIf( lMdtMin, STR0029, IIf( lCipatr, STR0024, STR0004 )),oFont12n,/*nWidth*/,/*nHeight*/,/*nClrText*/,/*nALignHorz*/2/*2-Centralizado*/,/*nALignVert*/)//"DOS EMPREGADOS NA CIPATR" //"DOS EMPREGADOS NA CIPA"

			cTxtData := StrZero(Year(TNN->TNN_DTINIC),4)

			If Year(TNN->TNN_DTINIC) <> Year(TNN->TNN_DTTERM)
				cTxtData += " / "+StrZero(Year(TNN->TNN_DTTERM),4)
			Endif

			cTxt01 := STR0005 //"Convocamos a todos os colaboradores interessados em candidatar-se aos cargos de"
			cTxt02 := IIf(lCipatr,STR0025,STR0006) //"representantes, titulares e suplentes, da Comissão Interna de Prevenção de Acidentes no Trabalho Rural - " //"representantes, titulares e suplentes, da Comissão Interna de Prevenção de Acidentes - "
			cTxt03 := IIf( lMdtMin, STR0030, IIf( lCipatr, STR0026, STR0007 ))+cTxtData+STR0008 //"CIPATR, gestão " //"CIPA, gestão "###", a efetivarem suas inscrições junto aos membros da Comissão "
			//"Eleitoral que se encontra instalada no local "###", no período" "de "###" à "
			cTxt04 := STR0009+Alltrim(Mv_par02)+STR0010+ " " +STR0020+DTOC(Mv_par03)+STR0021+DTOC(Mv_par04)+"."

			oPrint:SayAlign(0870,200,cTxt01 + cTxt02 + cTxt03 + cTxt04 ,oFont12,1875,260,/*nClrText*/,3,/*nALignVert*/)

			cCidade  := Alltrim(SM0->M0_CIDCOB)
			cCidade  += ", "+Strzero(Day(dDataBase),2)+STR0022 //" de "
			cCidade  += UPPER(MesExtenso(dDataBase))+STR0022 //" de "
			cCidade  += Strzero(Year(dDataBase),4)

			If Len(cCidade) > 40
				oPrint:Say(1800,1300,cCidade,oFont10)
			Else
				oPrint:Say(1800,1300,cCidade,oFont12)
			Endif

			oPrint:Say(2400,1000,STR0011,oFont12) //"Comissão Eleitoral"
			oPrint:EndPage()

		Next nInd

		If mv_par08 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)

		For nInd := 1 To Mv_par05

			oPrint:StartPage()
			// Localização do Logo da Empresa
			oPrint:SayBitMap(50,50,NGLocLogo(),250,50)
			oPrint:SayAlign(lin,650,STR0003 + " " + IIf( lMdtMin, STR0029, IIf( lCipatr, STR0024, STR0004 )),oFont12n,1000,90,/*nClrText*/,2,/*nALignVert*/) //"CONVOCAÇÃO PARA AS INSCRIÇÕES DOS CANDIDATOS A REPRESENTANTES" //"DOS EMPREGADOS NA CIPA"

			cTxtData := StrZero(Year(TNN->TNN_DTINIC),4)

			If Year(TNN->TNN_DTINIC) <> Year(TNN->TNN_DTTERM)
				cTxtData += " / "+StrZero(Year(TNN->TNN_DTTERM),4)
			EndIf

			cTxt01 := "		" + STR0005 + " " //"Convocamos a todos os colaboradores interessados em candidatar-se aos cargos de"
			cTxt02 := IIf(lCipatr,STR0025,STR0006) //"representantes, titulares e suplentes, da Comissão Interna de Prevenção de Acidentes - "
			cTxt03 := IIf( lMdtMin, STR0030, IIf( lCipatr, STR0026, STR0007 ))+cTxtData+STR0008 //"CIPA, gestão "###", a efetivarem suas inscrições junto aos membros da Comissão "
			//"Eleitoral que se encontra instalada no local "###", no período" "de "###" à "
			cTxt04 := STR0009+Alltrim(Mv_par02)+STR0010+ " " +STR0020+DTOC(Mv_par03)+STR0021+DTOC(Mv_par04)+"."

			oPrint:SayAlign(0870,200,cTxt01 + cTxt02 + cTxt03 + cTxt04 ,oFont12,1875,260,/*nClrText*/,3,/*nALignVert*/)

			cCidade  := Alltrim(SM0->M0_CIDCOB)
			cCidade  += ", "+Strzero(Day(dDataBase),2)+STR0022 //" de "
			cCidade  += UPPER(MesExtenso(dDataBase))+STR0022 //" de "
			cCidade  += Strzero(Year(dDataBase),4)

			If Len(cCidade) > 40
				oPrint:SayAlign(1700,1300,cCidade,oFont10,0775,260,/*nClrText*/,1,/*nALignVert*/)
			Else
				oPrint:SayAlign(1700,1300,cCidade,oFont12,0775,260,/*nClrText*/,1,/*nALignVert*/)
			Endif

			oPrint:Say(2400,1000,STR0011,oFont12) //"Comissão Eleitoral"
			oPrint:EndPage()

		Next nInd

		If mv_par06 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Endif

Return NIL