/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "mdtr900.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR900
Relatorio de Vacinação por Periodo.

@type    function
@author  Andre E. Perez Alvarez
@since   21/11/2006
@sample  U_MDTR900()
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function MDTR900()

	Local oReport
	Local aArea := GetArea()

	Private nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Private cAlias   := "SI3"
	Private cDescr   := "SI3->I3_DESC"
	Private cCodCTT  := "I3_CUSTO"
	Private aPerg := {}
	Private oTempTRB, oTempTRB2
	Private cTRBTL9 := GetNextAlias()

	SetKey( VK_F9, { | | NGVersao( "MDTR900" , 02 ) } )
	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )

	Private cPerg := "MDTR900   "

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias   := "CTT"
		cDescr   := "CTT->CTT_DESC01"
		nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
		cF3CC := "CTT001"  //CTT apenas do cliente
		cCodCTT := "CTT_CUSTO"
	EndIf

	If !MDTRESTRI("MDTR900")
		Return .F.
	EndIf
	/*---------------------------
	//PADRÃO					|
	|  De Vacina ?				|
	|  Ate Vacina ?				|
	|  De Ficha Medica ?		|
	|  Ate Ficha Medica ?		|
	|  De Centro de Custo ?		|
	|  Ate Centro de Custo ?	|
	|  De Data Vacina ?			|
	|  Ate Data Vacina ?		|
	|  Listar Vacinas ?			|
	|  Situacao Func. ?			|
	|							|
	//PRESTADOR					|
	|  De Cliente ?				|
	|  Loja						|
	|  Até Cliente ?			|
	|  Loja						|
	|  De Vacina ?				|
	|  Ate Vacina ?				|
	|  De Ficha Medica ?		|
	|  Ate Ficha Medica ?		|
	|  De Centro de Custo ?		|
	|  Ate Centro de Custo ?	|
	|  De Data Vacina ?			|
	|  Ate Data Vacina ?		|
	|  Listar Vacinas ?			|
	|  Situacao Func. ?			|
	-----------------------------*/

	If TRepInUse()
		// Interface de impressao
		oReport := ReportDef()
		oReport:SetPortrait()
		oReport:PrintDialog()
	Else
		U_MDTR900R3()
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} ValidCC
Valida o centro de custo

@type    function
@author  Rafael Reinert
@since   01/06/2011
@sample  U_ValidCC()

@param   deCli, Caractere, Início do intervalo de clientes
@param   ateCli, Caractere, Fim do intervalo de cliente
@param   deLoja, Caractere, Início do intervalo de Lojas
@param   ateLoja, Caractere, Fim do intervalo de Lojas
@param   cCTT, Caractere, Centro de custo selecionado
@param   lCTT, Lógico, Verdadeiro se houver filtro por centro de custo

@return  lRet, Lógico, verdadeiro se o Centro do Custo for válido
/*/
//-------------------------------------------------------------------
User Function ValidCC( deCli, ateCli, deLoja, ateLoja, cCTT, lCTT )

	Local lRet    := .F.
	Local cRep    := Replicate("Z",nSizeSI3)
	Local nTamCli := TAMSX3("A1_COD")[1]
	Local nTamLoj := TAMSX3("A1_LOJA")[1]

	If (Empty(cCTT) .And. lCTT) .Or. (cRep $ cCTT .And. !lCTT)
		Return .T.
	EndIf
	If !lCTT
		If cCTT < MV_PAR09
			ShowHelpDlg("ATENÇÃO",{"Opção inválida."},2,{"Informe no Até Centro de Custo um valor maior que o De Centro de Custo."},2)
			Return .F.
		Elseif Empty(cCTT)
			ShowHelpDlg("ATENÇÃO",{"Opção inválida."},2,{"Informe um Centro de Custo válido."},2)
			Return .F.
		EndIf
	EndIf
	If Empty(deCli+deLoja) .And. ateCli+ateLoja == Replicate("Z",nTamCli+nTamLoj)
		lRet := .T.
	Else
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+deCli+deLoja)

		While !EOF() .And. SA1->A1_COD+SA1->A1_LOJA >= deCli+deLoja .And. SA1->A1_COD+SA1->A1_LOJA <= ateCli+ateLoja
			If SA1->A1_COD+SA1->A1_LOJA == SUBSTR(cCTT,1,nTamCli+nTamLoj)
				lRet := .T.
				Exit
			EndIf
			dbSelectArea("SA1")
			dbSkip()
			Loop
		End
	EndIf

	If !lRet
		ShowHelpDlg("ATENÇÃO",{"Cliente(s) e Centro de Custo incondizentes."},2,{"Informe um Centro de Custo válido."},2)
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} ValidCC
Valida Ficha Médica

@type    function
@author  Rafael Reinert
@since   01/06/2011
@sample  U_ValidCC()

@param   deCli, Caractere, Início do intervalo de clientes
@param   ateCli, Caractere, Fim do intervalo de cliente
@param   deLoja, Caractere, Início do intervalo de Lojas
@param   ateLoja, Caractere, Fim do intervalo de Lojas
@param   cCTT, Caractere, Centro de custo selecionado
@param   lCTT, Lógico, Verdadeiro se houver filtro por centro de custo

@return  lRet, Lógico, verdadeiro se a fica médica for válida
/*/
//-------------------------------------------------------------------
User Function ValidFM( deCli, ateCli, deLoja, ateLoja, cTM0, lTM0 )

	Local lRet := .F.
	Local cRep := Replicate("Z",9)
	Local nOrder := NGRETORDEM("TM0","TM0_FILIAL+TM0_CLIENT+TM0_LOJA+TM0_NUMFIC",.F.)

	If (Empty(cTM0) .And. lTM0) .Or. (cRep $ cTM0 .And. !lTM0)
		Return .T.
	EndIf
	If !lTM0
		If cTM0 < MV_PAR07
			ShowHelpDlg("ATENÇÃO",{"Opção inválida."},2,{"Informe no Até Ficha Médica um valor maior que o De Ficha Médica."},2)
			Return .F.
		Elseif Empty(cTM0)
			ShowHelpDlg("ATENÇÃO",{"Opção inválida."},2,{"Informe uma Ficha Médica válida."},2)
			Return .F.
		EndIf
	EndIf
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+deCli+deLoja)

	While !EOF() .And. SA1->A1_COD >= deCli .And. SA1->A1_LOJA >= deLoja .And. SA1->A1_COD <= ateCli .And. SA1->A1_LOJA <= ateLoja
		dbSelectArea("TM0")
		dbSetOrder(nOrder)
		If dbSeek(xFilial("TM0")+SA1->A1_COD+SA1->A1_LOJA+cTM0)
			lRet := .T.
			Exit
		EndIf
		dbSelectArea("SA1")
		dbSkip()
		Loop
	End
	If !lRet
		ShowHelpDlg("ATENÇÃO",{"Cliente(s) e Ficha Médica incondizentes."},2,{"Informe uma Ficha Médica válida."},2)
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatório

@type    function
@author  Andre E. Perez Alvarez
@since   21/11/2006
@sample  ReportDef()
@return  oReport, Objeto, Características do relatório
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Static oReport
	Static oSection0
	Static oSection1
	Static oSection2
	Static oBreak1
	Static oCell
	Static oCel2

	/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	_______________________________________________________________________________________________________________________________________________

														Vacinacao por Periodo
	_______________________________________________________________________________________________________________________________________________


	Vacina                           Prog. de Vacina
	---------------------------------------
	xxxxxxxxxxxxxxx                  xxxxxxxxxx

	Ficha Médica  Nome                 Centro de Custo        Funcao       Dose      Data Vacina     Foi Aplicada?
	------------------------------------------------------------------------------------------------------------------------------------------------
	xxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx      xxxxxxxxxx   xxxxxxxx  xxxxxxxxxxxxx   NAO
	xxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx      xxxxxxxxxx   xxxxxxxx  xxxxxxxxxxxxx   NAO
	xxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx      xxxxxxxxxx   xxxxxxxx  xxxxxxxxxxxxx   SIM
	xxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx      xxxxxxxxxx   xxxxxxxx  xxxxxxxxxxxxx   NAO

	Total: 4

	Vacina                           Prog. de Vacina
	---------------------------------------
	xxxxxxxxxxxxxxx                  xxxxxxxxxx

	Ficha Médica  Nome                 Centro de Custo        Funcao       Dose      Data Vacina     Foi Aplicada?
	------------------------------------------------------------------------------------------------------------------------------------------------
	xxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx      xxxxxxxxxx   xxxxxxxx  xxxxxxxxxxxxx   NAO
	xxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx      xxxxxxxxxx   xxxxxxxx  xxxxxxxxxxxxx   NAO
	xxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx      xxxxxxxxxx   xxxxxxxx  xxxxxxxxxxxxx   SIM
	xxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx      xxxxxxxxxx   xxxxxxxx  xxxxxxxxxxxxx   NAO

	Total: 4

	*/

	//Criacao do componente de impressao
	//
	//TReport():New
	//ExpC1 : Nome do relatorio
	//ExpC2 : Titulo
	//ExpC3 : Pergunte
	//ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	//ExpC5 : Descricao

	oReport := TReport():New("MDTR900",OemToAnsi(STR0013),AllTrim(cPerg),{|oReport| ReportPrint()},;  //"Vacinação por Período"
			STR0014)  //"Relatório que lista os funcionários que deverão ser vacinados no período informado."

	Pergunte(oReport:uParam,.F.)

	//Criacao da secao utilizada pelo relatorio
	//
	//TRSection():New
	//ExpO1 : Objeto TReport que a secao pertence
	//ExpC2 : Descricao da seçao
	//ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
	//        sera considerada como principal para a seção.
	//ExpA4 : Array com as Ordens do relatório
	//ExpL5 : Carrega campos do SX3 como celulas
	//        Default : False
	//ExpL6 : Carrega ordens do Sindex
	//        Default : False
	//
	//Criacao da celulas da secao do relatorio
	//
	//TRCell():New
	//ExpO1 : Objeto TSection que a secao pertence
	//ExpC2 : Nome da celula do relatório. O SX3 será consultado
	//ExpC3 : Nome da tabela de referencia da celula
	//ExpC4 : Titulo da celula
	//        Default : X3Titulo()
	//ExpC5 : Picture
	//        Default : X3_PICTURE
	//ExpC6 : Tamanho
	//        Default : X3_TAMANHO
	//ExpL7 : Informe se o tamanho esta em pixel
	//        Default : False
	//ExpB8 : Bloco de código para impressao.
	//        Default : ExpC2

	oReport:SetTotalInLine(.F.)

	If lSigaMdtps
		// Secao 0 - Cliente
		oSection0 := TRSection():New (oReport, STR0035, {"TRB","SA1"} ) //"Cliente"
		oCell := TRCell():New(oSection0, "TRB->CLIENT", "TRB" , STR0035, "@!", nTa1 )  //"Cliente"
		oCell := TRCell():New(oSection0, "TRB->LOJA"   , "TRB" , STR0038, "@!", nTa1L  )  //"Loja"
		oCell := TRCell():New(oSection0, "SA1->A1_NOME", "SA1" , STR0043, "@!", 40  )  //"Nome"
		TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TRB->CLIENT+TRB->LOJA } )
	EndIf

	// Secao 1 - Vacina
	oSection1 := TRSection():New (oReport, STR0017, {"TRB","TL6"} ) //"Vacina"
	oCell := TRCell():New(oSection1, "TRB->VACINA", "TRB" , STR0016, "@!", 10  )  //"Código Vacina"
	oCell := TRCell():New(oSection1, "TL6_NOMVAC" , "TL6" , STR0017, "@!", 30  )  //"Vacina"
	oCell := TRCell():New(oSection1, "TRB->NUMCON" , "TRB" , STR0054, "@!", 10  )  //"Prog. de Vacina"
	TRPosition():New (oSection1, "TL6", 1, {|| xFilial("TL6") + TRB->VACINA } )

	// Secao 2 - Funcionarios
	oSection2 := TRSection():New (oReport,STR0018, {"TRB","TM0",cAlias,"SRJ"} ) //"Funcionários"
	oCel2 := TRCell():New (oSection2, "TRB->NUMFIC", "TRB", STR0019, "@!", 09, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Ficha Médica"
	oCel2 := TRCell():New (oSection2, "TM0_NOMFIC" , "TM0", STR0020, "@!", 25, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Nome"
	oCel2 := TRCell():New (oSection2, cDescr       ,cAlias, STR0021, "@!", nSizeSI3, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Centro de Custo"
	oCel2 := TRCell():New (oSection2, "RJ_DESC"    , "SRJ", STR0022, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Função"
	oCel2 := TRCell():New (oSection2, "TRB->DOSE"   , "TRB", STR0023, "@E 99", 02, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Dose"
	oSection2:Cell("DOSE"):SetHeaderAlign("RIGHT")
	oCel2 := TRCell():New (oSection2, "dData"      ,      , STR0024, "99/99/9999", 08, /*lPixel*/, {|| If( Empty(TRB->DTREAL), TRB->DTPREV, TRB->DTREAL ) } ) //"Data Vacina"
	oCel2 := TRCell():New (oSection2, "TRB->APLICA", "TRB", STR0025, "@!", 35, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Foi Aplicada?"

	TRPosition():New (oSection2, "TM0" , 1, {|| xFilial("TM0")  + TRB->NUMFIC } )
	TRPosition():New (oSection2, cAlias, 1, {|| xFilial(cAlias) + TRB->CC } )
	TRPosition():New (oSection2, "SRJ" , 1, {|| xFilial("SRJ")  + TRB->FUNCAO } )

	oBreak1 := TRBreak():New(oSection1,oSection1:Cell("TRB->VACINA"),STR0026,.T.)  //"Total:"
	TRFunction():New(oSection2:Cell("TRB->NUMFIC"),/*cId*/,"COUNT",oBreak1,/*cTitle*/,"999999",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatório

@type    function
@author  Andre E. Perez Alvarez
@since   22/11/2006
@sample  ReportPrint()
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function ReportPrint()

	Private cArqTrab
	Private aVETINR := {} //Usado pela funcao que cria arq. temporario

	Processa( {|lEND| TRBgrava()}, STR0027, STR0028 ) //"Aguarde" ## "Processando os atendimentos..."

	If lSigaMdtps

		dbSelectArea( "TRB" )
		dbSetOrder( 1 )
		dbGoTop()

		oReport:SetMeter( RecCount() )

		oSection1:Cell("TRB->VACINA"):Disable()

		While !oReport:Cancel() .And.;
			!Eof()

			cCliente := TRB->CLIENT+TRB->LOJA
			oSection0:Init() //-- Clientes
			oSection0:PrintLine()

			While !oReport:Cancel() .And. !Eof() .And. cCliente == TRB->CLIENT+TRB->LOJA

				cVacina := TRB->VACINA

				oSection1:Init() //-- Vacina
				oSection1:PrintLine()
				oSection2:Init() //-- Funcionarios

				While !oReport:Cancel() .And. !Eof() .And. TRB->VACINA == cVacina .And. cCliente == TRB->CLIENT+TRB->LOJA

					oReport:IncMeter()
					oSection2:PrintLine()

					dbSkip()
				End

				oSection2:Finish()
				oSection1:Finish()
			End

			oSection0:Finish()

		End

	Else

		dbSelectArea( "TRB" )
		dbSetOrder( 1 )
		dbGoTop()

		oReport:SetMeter( RecCount() )

		oSection1:Cell("TRB->VACINA"):Disable()

		While !oReport:Cancel() .And.;
			!Eof()

			cVacina := TRB->VACINA

			oSection1:Init() //-- Vacina
			oSection1:PrintLine()
			oSection2:Init() //-- Funcionarios

			While !oReport:Cancel() 		  .And.;
				!Eof()					  .And.;
				TRB->VACINA == cVacina

				oReport:IncMeter()
				oSection2:PrintLine()

				dbSkip()
			End

			oSection2:Finish()
			oSection1:Finish()

		End

	EndIf

	dbSelectArea("TRB")
	dbGotop()
	If RecCount()==0
		MsgInfo(STR0034)  //"Não há nada para imprimir no relatório."
		oTempTRB:Delete()
		Return .F.
	EndIf

	oTempTRB:Delete()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT900Vac
Valida a pergunta Ate Vacina

@type    function
@author  Andre E. Perez Alvarez
@since   22/11/2006
@sample  U_MDT900Vac()
@return  lRet, Lógico, Verdadeiro se a pergunta for válida
/*/
//-------------------------------------------------------------------
User Function MDT900Vac()

	Local lRet := .T.

	If lSigaMdtps
		lRet := IIf( mv_par06==Replicate("Z",10), .T., ExistCPO('TL6',mv_par06) .And. AteCodigo('TL6',mv_par05,mv_par06,10) )
	Else
		lRet := IIf( mv_par02==Replicate("Z",10), .T., ExistCPO('TL6',mv_par02) .And. AteCodigo('TL6',mv_par01,mv_par02,10) )
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT900Vac
Valida a pergunta Ate Ficha Medica

@type    function
@author  Andre E. Perez Alvarez
@since   22/11/2006
@sample  U_MDT900Vac()
@return  lRet, Lógico, Verdadeiro se a pergunta for válida
/*/
//-------------------------------------------------------------------
User Function MDT900Fic()

	Local lRet := .T.

	If lSigaMdtps
		lRet := IIf( mv_par08==Replicate("Z",09), .T., ExistCPO('TM0',mv_par08) .And. AteCodigo('TM0',mv_par07,mv_par08,09) )
	Else
		lRet := IIf( mv_par04==Replicate("Z",09), .T., ExistCPO('TM0',mv_par04) .And. AteCodigo('TM0',mv_par03,mv_par04,09) )
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT900Vac
Valida a pergunta Ate Centro de Custo

@type    function
@author  Andre E. Perez Alvarez
@since   22/11/2006
@sample  U_MDT900Vac()
@return  lRet, Lógico, Verdadeiro se a pergunta for válida
/*/
//-------------------------------------------------------------------
User Function MDT900CC()

	Local lRet := .T.

	lRet := IIf( mv_par06==Replicate("Z",nSizeSI3), .T., ExistCPO(cAlias,mv_par06) .And. AteCodigo(cAlias,mv_par05,mv_par06,nSizeSI3) )

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} TRBgrava
Processa os registros de acordo com os parametros e grava no arquivo
temporario.

@type    function
@author  Andre E. Perez Alvarez
@since   31/07/2006
@sample  TRBgrava()
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function TRBgrava()

	Local cIndex := ""
	Local cChave := ""
	Local cFiltro
	Local lCC
	Local cSituac := ""

	Local aDBF := {}
	Local vIND := {}

	fCreateTRB(1)

	If lSigaMdtps
		xm_par1 := MV_PAR05
		xm_par2 := MV_PAR06
		xm_par3 := MV_PAR07
		xm_par4 := MV_PAR08
		xm_par5 := MV_PAR11
		xm_par6 := MV_PAR12
		xm_par7 := mv_par13
	Else
		xm_par1 := MV_PAR01
		xm_par2 := MV_PAR02
		xm_par3 := MV_PAR03
		xm_par4 := MV_PAR04
		xm_par5 := MV_PAR07
		xm_par6 := MV_PAR08
		xm_par7 := mv_par09
	EndIf

	cSQLCond := "%%"
	If xm_par7 == 1  //Aplicadas
		cSQLCond := "%TL9_DTREAL <> '' " + " AND%"
	ElseIf xm_par7 == 2  //Pendentes
		cSQLCond := "%TL9_DTREAL = ''" + " AND%"
	ElseIf xm_par7 == 3  //Nao quer ser vacinado
		cSQLCond := "%TL9_INDVAC = 3 " + " AND%"
	EndIf

	BeginSQL Alias cTRBTL9
		SELECT TL9.TL9_FILIAL, TL9.TL9_VACINA, TL9.TL9_NUMFIC, TL9.TL9_INDVAC,
		TL9.TL9_DTPREV, TL9.TL9_DOSE, TL9.TL9_NUMCON, TL9.TL9_DTREAL
		FROM %table:TL9% TL9
		WHERE
		TL9_FILIAL = %xFilial:TL9% AND
		TL9_VACINA BETWEEN %exp:xm_par1% AND %exp:xm_par2% AND
		TL9_NUMFIC BETWEEN %exp:xm_par3% AND %exp:xm_par4% AND
		TL9_DTPREV BETWEEN %exp:xm_par5% AND %exp:xm_par6% AND
		%exp:cSQLCond%
		TL9.%notDel%
	EndSQL

	If lSigaMdtps

		//Grava os dados no arquivo temporario

		DbSelectArea( cTRBTL9 )
		DbGoTop()
		ProcRegua( 10 )

		While !oReport:Cancel() .And. !Eof()

			IncProc()

			dbSelectArea( "TM0" )
			dbSetOrder( 1 )
			dbSeek( xFilial("TM0") + ( cTRBTL9 )->TL9_NUMFIC )

			If TM0->(TM0_CLIENT+TM0_LOJA) < mv_par01+mv_par02 .Or. TM0->(TM0_CLIENT+TM0_LOJA) > mv_par03+mv_par04
				dbSelectArea( cTRBTL9 )
				dbSkip()
				Loop
			EndIf

			lCC := .T.
			If !Empty(TM0->TM0_CC) .And. Empty(TM0->TM0_MAT)
				If (TM0->TM0_CC < mv_par09) .Or. (TM0->TM0_CC > mv_par10)
					dbSelectArea( cTRBTL9 )
					dbSkip()
					Loop
				EndIf
				lCC := .F.
			EndIf

			DbSelectArea( "SRA" )
			DbSetOrder( 1 )
			DbSeek( xFilial("SRA") + TM0->TM0_MAT )

			If lCC .And. ( (SRA->RA_CC < mv_par09) .Or. (SRA->RA_CC > mv_par10) )
				dbSelectArea( cTRBTL9 )
				dbSkip()
				Loop
			EndIf

			// Filtro pela situação do funcionário.
			cSituac := If( Empty( MV_PAR14 ),Space(1),AllTrim( MV_PAR14 ) )
			If cSituac != "ZZZZZZ" .And. SRA->RA_SITFOLH != cSituac
				DbSelectArea( cTRBTL9 )
				DbSkip()
				Loop
			EndIf

			TRB->(dbAppend())
			TRB->CLIENT := TM0->TM0_CLIENT
			TRB->LOJA   := TM0->TM0_LOJA
			TRB->VACINA := ( cTRBTL9 )->TL9_VACINA
			TRB->NUMFIC := ( cTRBTL9 )->TL9_NUMFIC
			If !lCC
				TRB->CC := TM0->TM0_CC
			Else
				TRB->CC := SRA->RA_CC
			EndIf
			TRB->FUNCAO := SRA->RA_CODFUNC
			TRB->DTPREV := ( cTRBTL9 )->TL9_DTPREV
			If ( cTRBTL9 )->TL9_INDVAC == "1"
				TRB->APLICA := STR0049 //"SIM"
			ElseiF ( cTRBTL9 )->TL9_INDVAC == "2" .Or. Empty(( cTRBTL9 )->TL9_INDVAC)
				TRB->APLICA := STR0050 //"NÃO"
			ElseIf ( cTRBTL9 )->TL9_INDVAC == "3"
				TRB->APLICA := STR0051 //"FUNCIONÁRIO NÃO QUER SER VACINADO"
			Else
				TRB->APLICA := ""
			EndIf
			TRB->NUMCON := NGSEEK("TLE",( cTRBTL9 )->TL9_NUMCON,1,"TLE->TLE_NUMCON")
			TRB->DOSE 	:= ( cTRBTL9 )->TL9_DOSE
			( cTRBTL9 )->( dbSkip() )
		End

	Else

		//Grava os dados no arquivo temporario
		dbSelectArea( cTRBTL9 )
		dbGoTop()

		ProcRegua( RecCount() )

		While !oReport:Cancel() .And.;
			( cTRBTL9 )->( !Eof() )

			IncProc()

			dbSelectArea( "TM0" )
			dbSetOrder( 1 )
			dbSeek( xFilial("TM0") + ( cTRBTL9 )->TL9_NUMFIC )

			lCC := .T.
			If !Empty(TM0->TM0_CC) .And. Empty(TM0->TM0_MAT)
				If (TM0->TM0_CC < mv_par05) .Or. (TM0->TM0_CC > mv_par06)
					dbSelectArea( cTRBTL9 )
					dbSkip()
					Loop
				EndIf
				lCC := .F.
			EndIf

			DbSelectArea( "SRA" )
			DbSetOrder( 1 )
			DbSeek( xFilial("SRA") + TM0->TM0_MAT )

			If lCC .And. ( (SRA->RA_CC < mv_par05) .Or. (SRA->RA_CC > mv_par06) )
				DbSelectArea( cTRBTL9 )
				DbSkip()
				Loop
			EndIf

			// Filtro pela situação do funcionário.
			cSituac := If( Empty( MV_PAR10 ),Space(1),AllTrim( MV_PAR10 ) )
			If cSituac != "ZZZZZZ" .And. SRA->RA_SITFOLH != cSituac
				DbSelectArea( cTRBTL9 )
				DbSkip()
				Loop
			EndIf

			TRB->(dbAppend())
			TRB->VACINA := ( cTRBTL9 )->TL9_VACINA
			TRB->NUMFIC := ( cTRBTL9 )->TL9_NUMFIC
			If !lCC
				TRB->CC := TM0->TM0_CC
			Else
				TRB->CC := SRA->RA_CC
			EndIf

			TRB->FUNCAO := SRA->RA_CODFUNC

			If ( cTRBTL9 )->TL9_DTPREV != Nil
				TRB->DTPREV := StoD(( cTRBTL9 )->TL9_DTPREV)
			Else
				TRB->DTPREV := StoD('')
			EndIf

			If ( cTRBTL9 )->TL9_INDVAC == "1"
				TRB->APLICA := STR0049 //"SIM"
			ElseiF ( cTRBTL9 )->TL9_INDVAC == "2" .Or. EMPTY(( cTRBTL9 )->TL9_INDVAC)
				TRB->APLICA := STR0050 //"NÃO"
			ElseIf ( cTRBTL9 )->TL9_INDVAC == "3"
				TRB->APLICA := STR0051 //"FUNCIONÁRIO NÃO QUER SER VACINADO"
			Else
				TRB->APLICA := ""
			EndIf
			TRB->NUMCON := NGSEEK("TLE",( cTRBTL9 )->TL9_NUMCON,1,"TLE->TLE_NUMCON")
			TRB->DOSE 	:= ( cTRBTL9 )->TL9_DOSE
			( cTRBTL9 )->( dbSkip() )
		End

	EndIf

	DbSelectArea( cTRBTL9 )
	dbCloseArea()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR900R3
Relatorio demonstrativo dos custos dos exames por fornecedor. Será
considerado para o relatorio todos os exames do tipo ocupacional
realizados no periodo solicitado. O Programa lê a tabela de Exames
do Funcionario (TM5), e para cada exae realizado, o programa busca
o valor na tabela precos (TMD),com base no fornecedor e na data de
realizacao do exame. O relatorio saira classificado por fornecedor
e por exame, acumulando os valores por exame.

@type    function
@author  Marcio Costa
@since   12/01/2000
@sample  U_MDTR900R3()
@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTR900R3()

	// Define Variaveis
	Local wnrel   := "MDTR900"
	Local cDesc1  := STR0013  //"Vacinação por Período."
	Local cDesc2  := STR0014  //"Relatório que lista os funcionários que deverão ser vacinados no período informado."
	Local cDesc3  := ""
	Local cString := "TL9"

	Private nomeprog := "MDTR900"
	Private tamanho  := "G"
	Private aReturn  := { STR0030, 1,STR0031, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
	Private titulo   := STR0013   //"Vacinação por Período."
	Private ntipo    := 0
	Private nLastKey := 0
	Private cabec1, cabec2
	Private nValforn := 0.00
	Private lContinua := .T.

	// Verifica as perguntas selecionadas
	pergunte(AllTrim(cPerg),.F.)
	// Variaveis utilizadas para parametros
	// mv_par01             // De  Fornecedor
	// mv_par02             // Ate Fornecedor
	// mv_par03             // De Exame
	// mv_par04             // Ate Exame
	// mv_par05             // De Dt. Realizacao
	// mv_par06             // Ate Dt. Realizacao
	// mv_par07             // De C.C
	// mv_par08             // Ate C.C
	// mv_par09             // Imprimir relatorio:
	//                           Sintetico
	//                           Analitico
	// Envia controle para a funcao SETPRINT
	wnrel:="MDTR900"
	wnrel:=SetPrint(cString,wnrel,AllTrim(cPerg),titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey = 27
	Set Filter To
	Return
	EndIf

	SetDefault(aReturn,cString)
	RptStatus({|lEnd| U_R900Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} R900Imp
description
@type    function
@author
@since   01/06/1997
@sample  U_R900Imp( @lEnd, "MDTR435", "Título", "M" )

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caracter, Programa utilizado
@param   titulo, Caracter, Título do relatório
@param   tamanho, Caracter, Tamanho do relatório

@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function R900Imp( lEnd, wnRel, titulo, tamanho)

	// Define Variaveis
	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local cArqTrab

	// Variaveis para controle do cursor de progressao do relatorio
	Local nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	// Monta os Cabecalhos

	cabec1 := STR0032  //"Vacina                           Prog. de Vacina"
	cabec2 := STR0033  //"   Ficha Médica  Nome                                      Centro de Custo                           Função                                    Dose   Data Vacina   Foi Aplicada?"

	/*
			1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        160       170       180
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Vacina                           Prog. de Vacina
	Ficha Médica  Nome                                      Centro de Custo                           Função                                    Dose   Data Vacina   Foi Aplicada?
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	123456789  1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  xx     xx/xx/xxxx   SIM

	Total:       xxxx
	*/

	Private aVETINR := {} //Usado pela funcao que cria arq. temporario

	Processa({|lEND| TRB2grava(@lEnd)},STR0027, STR0028)  //"Aguarde" ## "Processando os atendimentos..."

	If lSigaMdtps

		dbSelectArea("TRB")
		dbGotop()
		ProcRegua(LastRec())
		While !Eof()

			cCliente := TRB->CLIENT+TRB->LOJA
			SomaLinha()
			@ Li,000 Psay STR0044 + Alltrim(TRB->CLIENT) + " - " + TRB->LOJA + " - " + NGSEEK("SA1",TRB->CLIENT+TRB->LOJA,1,"SA1->A1_NOME")  //"Cliente/Loja: "
			SomaLinha()

			While !eof() .And. cCliente = TRB->CLIENT+TRB->LOJA

				cVacina := TRB->VACINA
				nTotal := 0
				SomaLinha()
				@ Li,000 PSay TRB->NOMVAC
				SomaLinha()
				SomaLinha()
				While !Eof() .And. TRB->VACINA == cVacina .And. cCliente = TRB->CLIENT+TRB->LOJA

					IncProc()
					@ Li,003 PSay TRB->NUMFIC
					@ Li,017 PSay TRB->NOMFIC
					@ Li,059 PSay TRB->NOMECC
					@ Li,101 PSay TRB->NOFUNC
					@ Li,143 PSay TRB->DOSE
					@ Li,150 PSay TRB->DTPREV  Picture "99/99/99"
					@ Li,164 PSay TRB->APLICA

					SomaLinha()

					nTotal ++
					dbSelectArea("TRB")
					dbSkip()

				EndDo
				SomaLinha()
				@ Li,000 PSay STR0026 //"Total:"
				@ Li,008 PSay nTotal Picture "@E 9,999,999"
				SomaLinha()

			End
			SomaLinha()
			@ Li,000 PSAY __PrtThinLine()

		EndDo

	Else

		dbSelectArea("TRB")
		dbGotop()
		ProcRegua(LastRec())
		While !Eof()

			cVacina := TRB->VACINA
			nTotal := 0
			SomaLinha()
			@ Li,000 PSay TRB->NOMVAC
			@ Li,034 PSay TRB->NUMCON
			SomaLinha()
			SomaLinha()
			While !Eof() .And. TRB->VACINA == cVacina

				IncProc()
				@ Li,003 PSay TRB->NUMFIC
				@ Li,017 PSay TRB->NOMFIC
				@ Li,059 PSay TRB->NOMECC
				@ Li,101 PSay TRB->NOFUNC
				@ Li,143 PSay TRB->DOSE
				@ Li,150 PSay TRB->DTPREV  Picture "99/99/99"
				@ Li,164 PSay TRB->APLICA

				SomaLinha()

				nTotal ++
				dbSelectArea("TRB")
				dbSkip()

			EndDo
			SomaLinha()
			@ Li,000 PSay STR0026 //"Total:"
			@ Li,008 PSay nTotal Picture "@E 9,999,999"
			SomaLinha()

		EndDo

	EndIf

	dbSelectArea("TRB")
	dbGotop()
	If RecCount()==0
		MsgInfo(STR0034)  //"Não há nada para imprimir no relatório."
		oTempTRB2:Delete()
		Set Filter To
		Return .F.
	EndIf

	Roda(nCntImpr,cRodaTxt,Tamanho)
	// Devolve a condicao original do arquivo principal
	RetIndex("TL9")
	Set Filter To
	Set device to Screen
	If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
	EndIf
	MS_FLUSH()

	oTempTRB2:Delete()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} TRB2grava
Processa os registros de acordo com os parâmetros e grava no arquivo
temporário.

@type    function
@author  Andre E. Perez Alvarez
@since   31/07/2006
@sample  TRB2grava()
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function TRB2grava()

	Local cIndex := ""
	Local cChave := ""
	Local cFiltro
	Local lCC
	Local cSituac := ""

	Local aDBF := {}
	Local vIND := {}

	fCreateTRB(2)

	If lSigaMdtps
		xm_par1 := MV_PAR05
		xm_par2 := MV_PAR06
		xm_par3 := MV_PAR07
		xm_par4 := MV_PAR08
		xm_par5 := MV_PAR11
		xm_par6 := MV_PAR12
		xm_par7 := mv_par13
	Else
		xm_par1 := MV_PAR01
		xm_par2 := MV_PAR02
		xm_par3 := MV_PAR03
		xm_par4 := MV_PAR04
		xm_par5 := MV_PAR07
		xm_par6 := MV_PAR08
		xm_par7 := mv_par09
	EndIf

	cSQLCond := "%%"
	If xm_par7 == 1  //Aplicadas
		cSQLCond := "%TL9_INDVAC = 1 " + " AND%"
	ElseIf xm_par7 == 2  //Pendentes
		cSQLCond := "%TL9_INDVAC = 2 " + " AND%"
	ElseIf xm_par7 == 3  //Nao quer ser vacinado
		cSQLCond := "%TL9_INDVAC = 3 " + " AND%"
	EndIf

	BeginSQL Alias cTRBTL9
		SELECT TL9.TL9_FILIAL, TL9.TL9_VACINA, TL9.TL9_NUMFIC, TL9.TL9_INDVAC,
		TL9.TL9_DTPREV, TL9.TL9_DOSE, TL9.TL9_NUMCON, TL9.TL9_DTREAL
		FROM %table:TL9% TL9
		WHERE
		TL9_FILIAL = %xFilial:TL9% AND
		TL9_VACINA BETWEEN %exp:xm_par1% AND %exp:xm_par2% AND
		TL9_NUMFIC BETWEEN %exp:xm_par3% AND %exp:xm_par4% AND
		TL9_DTPREV BETWEEN %exp:xm_par5% AND %exp:xm_par6% AND
		%exp:cSQLCond%
		TL9.%notDel%
	EndSQL

	If lSigaMdtps

		//Grava os dados no arquivo temporario

		DbSelectArea( cTRBTL9 )
		DbGoTop()
		ProcRegua( 10 )

		While !Eof()

			IncProc()

			dbSelectArea( "TM0" )
			dbSetOrder( 1 )
			dbSeek( xFilial("TM0") + ( cTRBTL9 )->TL9_NUMFIC )

			If TM0->(TM0_CLIENT+TM0_LOJA) < mv_par01+mv_par02 .Or. TM0->(TM0_CLIENT+TM0_LOJA) > mv_par03+mv_par04
				dbSelectArea( cTRBTL9 )
				dbSkip()
				Loop
			EndIf

			lCC := .T.
			If !Empty(TM0->TM0_CC) .And. Empty(TM0->TM0_MAT)
				If (TM0->TM0_CC < mv_par09) .Or. (TM0->TM0_CC > mv_par10)
					dbSelectArea( cTRBTL9 )
					dbSkip()
					Loop
				EndIf
				lCC := .F.
			EndIf

			DbSelectArea( "SRA" )
			DbSetOrder( 1 )
			DbSeek( xFilial("SRA") + TM0->TM0_MAT )

			If lCC .And. ( (SRA->RA_CC < mv_par09) .Or. (SRA->RA_CC > mv_par10) )
				dbSelectArea( cTRBTL9 )
				dbSkip()
				Loop
			EndIf

		// Filtro pela situação do funcionário.
			cSituac := If( Empty( MV_PAR14 ),Space(1),AllTrim( MV_PAR14 ) )
			If cSituac != "ZZZZZZ" .And. SRA->RA_SITFOLH != cSituac
				DbSelectArea( cTRBTL9 )
				DbSkip()
				Loop
			EndIf

			TRB->(dbAppend())
			TRB->CLIENT := TM0->TM0_CLIENT
			TRB->LOJA   := TM0->TM0_LOJA
			TRB->VACINA := ( cTRBTL9 )->TL9_VACINA
			TRB->NOMVAC := NGSEEK("TL6",( cTRBTL9 )->TL9_VACINA,1,"TL6->TL6_NOMVAC")
			TRB->NUMFIC := ( cTRBTL9 )->TL9_NUMFIC
			TRB->NOMFIC := NGSEEK("TM0",( cTRBTL9 )->TL9_NUMFIC,1,"TM0->TM0_NOMFIC")
			If !lCC
				TRB->CC := TM0->TM0_CC
			Else
				TRB->CC := SRA->RA_CC
			EndIf
			TRB->NOMECC := NGSEEK(cAlias,TRB->CC,1,cDescr)
			TRB->FUNCAO := SRA->RA_CODFUNC
			TRB->NOFUNC := NGSEEK("SRJ",SRA->RA_CODFUNC,1,"SRJ->RJ_DESC")
			TRB->DOSE   := ( cTRBTL9 )->TL9_DOSE

			If ( cTRBTL9 )->TL9_DTPREV != Nil
				TRB->DTPREV := StoD(( cTRBTL9 )->TL9_DTPREV)
			Else
				TRB->DTPREV := StoD('')
			EndIf

			If ( cTRBTL9 )->TL9_INDVAC == "1"
				TRB->APLICA := STR0049 //"SIM"
			ElseiF ( cTRBTL9 )->TL9_INDVAC == "2" .Or. EMPTY(( cTRBTL9 )->TL9_INDVAC)
				TRB->APLICA := STR0050 //"NÃO"
			ElseIf ( cTRBTL9 )->TL9_INDVAC == "3"
				TRB->APLICA := STR0051 //"FUNCIONÁRIO NÃO QUER SER VACINADO"
			Else
				TRB->APLICA := ""
			EndIf

			( cTRBTL9 )->( dbSkip() )

		End

	Else
	//Grava os dados no arquivo temporari

		DbSelectArea( cTRBTL9 )
		DbGoTop()
		ProcRegua( 10 )

		While ( cTRBTL9 )->( !Eof() )

			IncProc()

			dbSelectArea( "TM0" )
			dbSetOrder( 1 )
			dbSeek( xFilial("TM0") + ( cTRBTL9 )->TL9_NUMFIC )

			lCC := .T.
			If !Empty(TM0->TM0_CC) .And. Empty(TM0->TM0_MAT)
				If (TM0->TM0_CC < mv_par05) .Or. (TM0->TM0_CC > mv_par06)
					dbSelectArea( cTRBTL9 )
					dbSkip()
					Loop
				EndIf
				lCC := .F.
			EndIf

			DbSelectArea( "SRA" )
			DbSetOrder( 1 )
			DbSeek( xFilial("SRA") + TM0->TM0_MAT )

			If lCC .And. ( (SRA->RA_CC < mv_par05) .Or. (SRA->RA_CC > mv_par06) )
				DbSelectArea( cTRBTL9 )
				DbSkip()
				Loop
			EndIf

		// Filtro pela situação do funcionário.
			cSituac := If( Empty( mv_par10 ),Space(1),AllTrim( MV_PAR10 ) )
			If cSituac != "ZZZZZZ" .And. SRA->RA_SITFOLH != cSituac
				DbSelectArea( cTRBTL9 )
				DbSkip()
				Loop
			EndIf

			TRB->(dbAppend())
			TRB->VACINA := ( cTRBTL9 )->TL9_VACINA
			TRB->NOMVAC := NGSEEK("TL6",( cTRBTL9 )->TL9_VACINA,1,"TL6->TL6_NOMVAC")
			TRB->NUMFIC := ( cTRBTL9 )->TL9_NUMFIC
			TRB->NOMFIC := NGSEEK("TM0",( cTRBTL9 )->TL9_NUMFIC,1,"TM0->TM0_NOMFIC")
			If !lCC
				TRB->CC := TM0->TM0_CC
			Else
				TRB->CC := SRA->RA_CC
			EndIf
			TRB->NOMECC := NGSEEK(cAlias,TRB->CC,1,cDescr)
			TRB->FUNCAO := SRA->RA_CODFUNC
			TRB->NOFUNC := NGSEEK("SRJ",SRA->RA_CODFUNC,1,"SRJ->RJ_DESC")
			TRB->DOSE   := ( cTRBTL9 )->TL9_DOSE

			If ( cTRBTL9 )->TL9_DTPREV != Nil
				TRB->DTPREV := StoD(( cTRBTL9 )->TL9_DTPREV)
			Else
				TRB->DTPREV := StoD('')
			EndIf

			TRB->NUMCON := NGSEEK("TLE",( cTRBTL9 )->TL9_NUMCON,1,"TLE->TLE_NUMCON")

			If ( cTRBTL9 )->TL9_INDVAC == "1"
				TRB->APLICA := STR0049 //"SIM"
			ElseiF ( cTRBTL9 )->TL9_INDVAC == "2" .Or. EMPTY(( cTRBTL9 )->TL9_INDVAC)
				TRB->APLICA := STR0050 //"NÃO"
			ElseIf ( cTRBTL9 )->TL9_INDVAC == "3"
				TRB->APLICA := STR0051 //"FUNCIONÁRIO NÃO QUER SER VACINADO"
			Else
				TRB->APLICA := ""
			EndIf

			( cTRBTL9 )->( dbSkip() )

		End

	EndIf

	DbSelectArea( cTRBTL9 )
	dbCloseArea()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@type    function
@author  Inacio Luiz Kolling
@since   01/06/1997
@sample  Somalinha()
@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function Somalinha()

    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} SchedDef
Execução de Parâmetros na Definição do Schedule

@type    function
@author  Gabriel Gustavo de Mora
@since   27/04/2016
@sample  SchedDef()
@return  aParam, Array, Contém as definições de parâmetros
/*/
//---------------------------------------------------------------------
Static Function SchedDef()

	Local aOrd			:= {}
	Local aParam 		:= {}
	Local lSigaMdtPS	:= AllTrim( SuperGetMv( "MV_MDTPS" , .F. , "N" ) ) == "S"
	Local cPerg			:= If( !lSigaMdtps, PadR( "MDTR900" , 10 ), PadR( "MDTR900PS" , 10 ) )

	aParam := { 	"R" , ;
					cPerg , ;
					"TL6" , ;
					aOrd , ;
					STR0013 }
Return aParam

//---------------------------------------------------------------------
/*/{Protheus.doc} fCreateTRB
Função para realizar a criação das TRBs.


@type    function
@author  Jean Pytter da Costa
@since   24/01/2017
@param   nImp, Numérico, Indica o tipo de impressão.
@sample  fCreateTRB( 1 )

@return  Nil, Sempre nulo
/*/
//---------------------------------------------------------------------
Static Function fCreateTRB( nImp )

	Local nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Default nImp := 1

	If nImp == 1
		aDBF :=	{}
		If lSigaMdtps
			aAdd(aDBF,{"CLIENTE"  ,"C",nTa1,0})
			aAdd(aDBF,{"LOJA"     ,"C",nTa1L,0})
		EndIf
		aAdd(aDBF,{"VACINA" ,"C",10,0})
		aAdd(aDBF,{"NUMFIC" ,"C",09,0})
		aAdd(aDBF,{"CC"     ,"C",nSizeSI3,0})
		aAdd(aDBF,{"FUNCAO" ,"C",05,0})
		aAdd(aDBF,{"DTPREV" ,"D",08,0})
		aAdd(aDBF,{"APLICA" ,"C",35,0})
		aAdd(aDBF,{"NUMCON" ,"C",10,0})
		aAdd(aDBF,{"DTREAL" ,"D",08,0})
		aAdd(aDBF,{"DOSE"   ,"C",02,0})

		oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
		If lSigaMdtps
			oTempTRB:AddIndex( "1", {"CLIENT","LOJA","VACINA","NUMFIC","DTPREV"} )
		Else
			oTempTRB:AddIndex( "1", {"VACINA","NUMFIC","DTPREV"} )
		EndIf
		oTempTRB:Create()
	Else
		aDBF :=	{}
		If lSigaMdtps
			aAdd(aDBF,{"CLIENTE"  ,"C",nTa1,0})
			aAdd(aDBF,{"LOJA"     ,"C",nTa1L,0})
		Else
			aAdd(aDBF,{"NUMCON"   ,"C",10,0})
		EndIf
		aAdd(aDBF,{"VACINA"   ,"C",10,0})
		aAdd(aDBF,{"NOMVAC"   ,"C",40,0})
		aAdd(aDBF,{"NUMFIC"   ,"C",09,0})
		aAdd(aDBF,{"NOMFIC"   ,"C",40,0})
		aAdd(aDBF,{"CC"       ,"C",nSizeSI3,0})
		aAdd(aDBF,{"NOMECC"   ,"C",40,0})
		aAdd(aDBF,{"FUNCAO"   ,"C",05,0})
		aAdd(aDBF,{"NOFUNC"   ,"C",40,0})
		aAdd(aDBF,{"DOSE"     ,"C",02,0})
		aAdd(aDBF,{"DTPREV"   ,"D",08,0})
		aAdd(aDBF,{"APLICA"   ,"C",35,0})
		aAdd(aDBF,{"DTREAL"   ,"D",08,0})

		oTempTRB2 := FWTemporaryTable():New( "TRB", aDBF )
		If lSigaMdtps
			oTempTRB2:AddIndex( "1", {"CLIENT","LOJA","VACINA","NUMFIC","DTPREV"} )
		Else
			oTempTRB2:AddIndex( "1", {"VACINA","NUMFIC","DTPREV"} )
		EndIf
		oTempTRB2:Create()

	EndIf
Return Nil