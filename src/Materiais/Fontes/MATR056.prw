/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR056.CH"
#INCLUDE "FIVEWIN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR056  ³ Autor ³ Alexandre Alves Silva ³ Data ³28/10/2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Programa para imprimir Solicitacoes de NCP                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Void U_MATR056(void)                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³Data    ³ BOPS     ³ Motivo da Alteracao                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jonathan Glz³06/07/15³PCREQ-4256³Se elimina la funcion AjustaSX1() que ³±±
±±³            ³        ³          ³hace modificacion a SX1 por motivo de ³±±
±±³            ³        ³          ³adecuacion a fuentes a nuevas estruc- ³±±
±±³            ³        ³          ³turas SX para Version 12.             ³±±
±±³M.Camargo   ³09.11.15³PCREQ-4262³Merge sistemico v12.1.8               ³±±
±±³Marco A. Glz³05/02/20³DMINA-8367³Se corrige error de clase invalida en ³±±
±±³            ³        ³          ³TPen() y se aplican buenas practicas. ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ*/
User Function MATR056()

	Local cTitulo	:= FunDesc()
	Local lRet		:= .T.

	Private nLastKey	:= 0
	Private cPerg	 	:= "MTR056"
	Private nomeProg	:= "MATR056"
	Private wnrel		:= "MATR056" //Nome Default do relatorio em Disco

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros   ³
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ mv_par01	// Numero de               ³
	//³ mv_par02	// Numero Ate              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Pergunte(cPerg,.T.)
		MsgRun(STR0001,"",{|| CursorWait(), U_Mtr056Cfg(cTitulo, .F.), CursorArrow()}) //"Generando informe, espere..."
	Else
		lRet := .F.
	Endif

Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºProgram   ³MATR056   ºAuthor ³Alexandre Silva     º Date ³  11-01-02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Configura o relatorio para impressao.                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUse       ³ SIGACOM                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ*/
User Function Mtr056Cfg(cTitulo)

	Private oArial10	:= TFont():New("Arial", 10, 10, , .F., , , , .T., .F.)
	Private oArial12N	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.)
	Private oArial14N	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.)

	Private oPrint	:= TMSPrinter():New(cTitulo)
	Private oPen	:= TPen():New(0, 7, CLR_BLACK)

	oPrint:SetPortrait()

	U_Mtr056Det(cTitulo)

	oPrint:Preview() // Visualiza antes de imprimir

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºProgram   ³MTR056Det ºAuthor ³Alexandre Silva     º Date ³  11-01-02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera o detalhe  para o relatorio                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUse       ³ AP7                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ*/
User Function Mtr056Det(cTitulo)

	Local cValPict		:= PesqPict("SCU", "CU_VALMIN", 20)
	Local cSimb			:= GETMV("MV_SIMB1")
	Local cFornece		:= ""
	Local cMotivo		:= ""
	Local cTexto		:= ""
	Local nLin			:= 0
	Local nLinhaAtual	:= 0
	Local cFilSCU		:= xFilial("SCU")
	Local cFilSA2		:= xFilial("SA2")
	Local cFilSX5		:= xFilial("SX5")

	DBSelectArea("SCU")
	SCU->(DBSetOrder(1)) //CU_FILIAL+CU_NUMERO

	If SCU->(DBSeek(cFilSCU + MV_PAR01, .T.))
		While SCU->(CU_NUMERO) <= MV_PAR02 .And. !Eof()
			nLin := Mt056ICab()
			cFornece	:= RTrim(SubStr(Posicione("SA2", 1, cFilSA2 + SCU->CU_FORNECE + SCU->CU_LOJA, "A2_NOME"), 1, 30))
			cMotivo		:= RTrim(SubStr(Posicione("SX5", 1, cFilSX5 + 'O1' + SCU->CU_MOTIVO, "X5_DESCRI"), 1, 30))
			cTexto	 	:= StrTran(STR0003, "<EMPRESA>", " " + cFornece + " ") //"        Solicitamos a los señores <EMPRESA> emitir Nota de Credito con valor de <VALOR> debido a <MOTIVO>."
			cTexto	 	:= StrTran(cTexto, "<VALOR>", + cSimb + " " + LTrim(TransForm(SCU->CU_VALMIN, cValPict)))
			cTexto	 	:= StrTran(cTexto, "<MOTIVO>", " " + cMotivo + " ")
			nLin		+= 250
			For nLinhaAtual := 1 To MlCount(cTexto,120)
				oPrint:Say(nLin += 50, 100, MemoLine(cTexto, 120, nLinhaAtual), oArial10)            
			Next
			oPrint:Say(nLin += 250, 100		, STR0004 + RTrim(SCU->CU_NFISCAL) + IIf(!Empty(SerieNfId("SCU", 2, "CU_SERNF")), STR0005 + " " + SerieNfId("SCU", 2, "CU_SERNF"), "") + " " + STR0002 + DtoC(SCU->CU_DTNF), oArial10) //"Factura de Referencia " - "Fecha: " 
			oPrint:Say(nLin += 300, 1600	, Replicate("_", 26), oArial10)
			oPrint:Say(nLin += 050, 1600	, STR0006, oArial10) //"Atentamente"
			oPrint:Say(nLin += 050, 1600	, STR0007, oArial10) //"Dpto. de Compras"
			oPrint:EndPage() 	 	 				
			SCU->(DBSkip())
		EndDo
	EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Mt056ICab ºAutor  ³Alexandre Silva     ºFecha ³  01/11/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime o cabecalho do relatorio                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACOM                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Mt056ICab()

	Local cCGCNome 	:= RTrim(FWX3Titulo("A1_CGC")) + " "  //Retorna o titulo do campo
	Local cEndNome	:= RTrim(FWX3Titulo("A1_END")) + " " 
	Local cCepNome	:= RTrim(FWX3Titulo("A1_CEP")) + " " 
	Local cCidNome	:= RTrim(FWX3Titulo("A1_MUN")) + " " 
	Local cEstNome	:= RTrim(FWX3Titulo("A1_EST")) + " " 
	Local cTelNome	:= RTrim(FWX3Titulo("A1_TEL")) + " " 
	Local cFaxNome	:= RTrim(FWX3Titulo("A1_FAX")) + " " 
	Local nLin	   	:= 20
	Local aFieldSM0	:= {"M0_NOMECOM", "M0_CGC", "M0_ENDENT", "M0_CEPENT", "M0_CIDENT", "M0_ESTENT", "M0_TEL", "M0_FAX"}
	Local aDatosEmp	:= FWSM0Util():GetSM0Data(cEmpAnt, cFilAnt, aFieldSM0)
	
	
	/* Retorna array "aDatosEmp" con la siguiente estructura:
	 * aDatosEmp[1]		:= M0_NOMECOM
	 * aDatosEmp[1][2]	:= Contenido
	 * aDatosEmp[2]		:= M0_CGC
	 * aDatosEmp[2][2]	:= Contenido
	 * aDatosEmp[3]		:= M0_ENDENT
	 * aDatosEmp[3][2]	:= Contenido
	 * aDatosEmp[4]		:= M0_CEPENT
	 * aDatosEmp[4][2]	:= Contenido
	 * aDatosEmp[5]		:= M0_CIDENT
	 * aDatosEmp[5][2]	:= Contenido
	 * aDatosEmp[6]		:= M0_ESTENT
	 * aDatosEmp[6][2]	:= Contenido
	 * aDatosEmp[7]		:= M0_TEL
	 * aDatosEmp[7][2]	:= Contenido
	 * aDatosEmp[8]		:= M0_FAX
	 * aDatosEmp[8][2]	:= Contenido
	*/

	oPrint:StartPage()

	oPrint:Box(nLin, 0080, 1600	, 2380, oPen)
	oPrint:Say(nLin += 20, 0100	, aDatosEmp[1][2],oArial14N)
	oPrint:Say(nLin += 70, 0100	, cCGCNome + Transform(aDatosEmp[2][2], PesqPict("SM0","M0_CGC")), oArial12N)  //"CGC,RUT,RUC,CUIT..."
	oPrint:Say(nLin += 00, 1780	, STR0008 + SCU->CU_NUMERO, oArial12N) //"Solicitud numero: "
	oPrint:Say(nLin += 50, 0100	, cEndNome + aDatosEmp[3][2], oArial12N)
	oPrint:Say(nLin += 00, 1780	, STR0002 + DTOC(SCU->CU_EMISSAO), oArial12N) //"Fecha: "
	oPrint:Say(nLin += 50, 0100	, cCepNome + Transform(aDatosEmp[4][2], PesqPict("SM0", "M0_CEPENT")) + " - " + cCidNome + RTrim(aDatosEmp[5][2]) + " - " + cEstNome + aDatosEmp[6][2], oArial12N)
	oPrint:Say(nLin += 50, 0100	, cTelNome + Transform(aDatosEmp[7][2], PesqPict("SM0", "M0_TEL")) + cFaxNome + Transform(aDatosEmp[8][2], PesqPict("SM0", "M0_FAX" )), oArial12N ) //"| Telefono : ","     FAX : "
	
	oPrint:Line(nLin += 90, 0080, nLin, 2380) // horizontal
	oPrint:Line(nLin += 10, 0080, nLin, 2380) // horizontal

Return nLin
