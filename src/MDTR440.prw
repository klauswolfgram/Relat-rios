/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR440.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR440  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio dos Atestados Ocupacionais emitidos no periodo.   ³±±
±±³          ³O usuario pode informar o periodo desejado obtendo como     ³±±
±±³          ³resultado a relacao de Funcionarios que ja realizaram o     ³±±
±±³          ³exame de avalizacao clinica o qual gera o ASO. O relatorio  ³±±
±±³          ³totaliza por o numero de atestados com parecer Aptos e Ina- ³±±
±±³          ³ptos.                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MDTR440void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR440()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aNGBEGINPRM := NGBEGINPRM( )

	Local oReport
	Local aArea := GetArea()

	lSigaMdtPS := SuperGetMv("MV_MDTPS",.F.,"N") == "S"

	Private cPerg    := If(!lSigaMdtPS,"MDT440    ","MDT440PS  ")
	Private lMDTPS   := GetMv("MV_NGMDTPS") == "S"
	Private oTempTRB

	If !MDTRESTRI(cPrograma)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		NGRETURNPRM(aNGBEGINPRM)
		Return .F.
	Endif

	/*-------------------------------------------
	// PERGUNTAS DO PADRÃO						|
	|  01 - De  ASO ?            				|
	|  02 - Ate ASO ?            				|
	|  03 - De  Data Emissao ?   				|
	|  04 - Ate Data Emissao ?   				|
	|  05 - De Cliente ?         				|
	|  06 - Ate Cliente ?        				|
	//PERGUNTAS DO PRESTADOR DE SERVIÇO		    |
	|  01 - De Cliente ?          				|
	|  02 - Loja                  				|
	|  03 - Até Cliente ?        				|
	|  04 - Loja	                 			|
	|  05 - De  ASO ?            				|
	|  06 - Ate ASO ?            				|
	|  07 - De  Data Emissao ?  				|
	|  08 - Ate Data Emissao ?   				|
	-------------------------------------------*/

	If TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:SetPortrait()
	oReport:PrintDialog()
	Else
	U_MDTR440R3()
	EndIf
	RestArea(aArea)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³ Rafael Diogo Richter  ³ Data ³07/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Define as sessoes impressas no relatorio.                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMDT                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

	Local oReport
	Local oSection1
	Local oSection2
	Local oSection3
	Local oSection4
	Local oCell1
	Local oCell2
	Local oCell3
	Local oCell4

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao do componente de impressao                                      ³
	//³                                                                        ³
	//³TReport():New                                                           ³
	//³ExpC1 : Nome do relatorio                                               ³
	//³ExpC2 : Titulo                                                          ³
	//³ExpC3 : Pergunte                                                        ³
	//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
	//³ExpC5 : Descricao                                                       ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := TReport():New("MDTR440",OemToAnsi(STR0031),cPerg,{|oReport| ReportPrint(oReport)},STR0001+" "+STR0002)  //"Atestados de Saúde Ocupacional"

	Pergunte(oReport:uParam,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao da secao utilizada pelo relatorio                               ³
	//³                                                                        ³
	//³TRSection():New                                                         ³
	//³ExpO1 : Objeto TReport que a secao pertence                             ³
	//³ExpC2 : Descricao da seçao                                              ³
	//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
	//³        sera considerada como principal para a seção.                   ³
	//³ExpA4 : Array com as Ordens do relatório                                ³
	//³ExpL5 : Carrega campos do SX3 como celulas                              ³
	//³        Default : False                                                 ³
	//³ExpL6 : Carrega ordens do Sindex                                        ³
	//³        Default : False                                                 ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao da celulas da secao do relatorio                                ³
	//³                                                                        ³
	//³TRCell():New                                                            ³
	//³ExpO1 : Objeto TSection que a secao pertence                            ³
	//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
	//³ExpC3 : Nome da tabela de referencia da celula                          ³
	//³ExpC4 : Titulo da celula                                                ³
	//³        Default : X3Titulo()                                            ³
	//³ExpC5 : Picture                                                         ³
	//³        Default : X3_PICTURE                                            ³
	//³ExpC6 : Tamanho                                                         ³
	//³        Default : X3_TAMANHO                                            ³
	//³ExpL7 : Informe se o tamanho esta em pixel                              ³
	//³        Default : False                                                 ³
	//³ExpB8 : Bloco de código para impressao.                                 ³
	//³        Default : ExpC2                                                 ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lSigaMdtps
		oSection1 := TRSection():New(oReport,STR0032,{"TRB","SA1"})  //"Cliente"
		oCell1 := TRCell():New(oSection1,"TRB->CLIENTE"	,"TRB",STR0032,"@!" ,nTa1 ,/*lPixel*/,/*{|| code-block de impressao }*/)  //Cliente
		oCell1 := TRCell():New(oSection1,"TRB->LOJA"		,"TRB",STR0025,"@!" ,nTa1L,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Loja"
		oCell1 := TRCell():New(oSection1,"A1_NOME"			,"SA1",STR0033,"@!" ,40,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome"
		TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1")+TRB->CLIENTE+TRB->LOJA})
	Else
		oSection1 := TRSection():New(oReport,STR0032,{"TRB","SA1"}) //"Cliente"
		oCell1 := TRCell():New(oSection1,"TRB->CLIENTE"	,"TAB",STR0032,"@!" ,06,/*lPixel*/,/*{|| code-block de impressao }*/) //"Cliente"
		oCell1 := TRCell():New(oSection1,"A1_NOME"			,"SA1",STR0033,"@!" ,40,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome"
		TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1")+TRB->CLIENTE})
	Endif

	oSection2 := TRSection():New(oReport,STR0043,{"TRB"})  //"Atestado (ASO)"
	oCell2 := TRCell():New(oSection2,"TRB->ASO"		,"TRB", STR0034, "@!"         ,08,/*lPixel*/,/*{|| code-block de impressao }*/)  //"ASO"
	oCell2 := TRCell():New(oSection2,"TRB->NUMFIC"	,"TRB", STR0035, "@!" 		  ,12,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Ficha"
	oCell2 := TRCell():New(oSection2,"TRB->MAT"		,"TRB", STR0036, "@!" 		  ,12,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Matrícula"
	oCell2 := TRCell():New(oSection2,"TRB->NOME"    ,"TRB", STR0033, "@!" 		  ,40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Nome do Funcionário"
	oCell2 := TRCell():New(oSection2,"TRB->NOMESO"	,"TRB", STR0067, "@!" 		  ,40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Nome Social"
	oCell2 := TRCell():New(oSection2,"TRB->DTPROG"	,"TRB", STR0038, "99/99/9999" ,16,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Program."
	oCell2 := TRCell():New(oSection2,"TRB->DTEMIS"	,"TRB", STR0039, "99/99/9999" ,16,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Emissao"
	oCell2 := TRCell():New(oSection2,"TRB->DTCANC"	,"TRB", STR0040, "99/99/9999" ,16,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Cancel."
	oCell2 := TRCell():New(oSection2,"    "			,"   ", STR0041, "@!"		  ,20,/*lPixel*/,{|| cINDPAR })  //"Parecer"
	oCell2 := TRCell():New(oSection2,"TRB->NATURE"	,"TRB", STR0042, "@!"		  ,30,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Natureza"

	oSection3 := TRSection():New(oReport,STR0044,{"TRB"})  //"Resumo por Cliente"
	oCell3 := TRCell():New(oSection3,"    "	 ,"   " ,STR0045 ,"@!" 		 ,22,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Resumo do Relatório:"
	oCell3 := TRCell():New(oSection3,"APTOS"   ,"   " ,STR0046 ,"@E 999,999" ,08,/*lPixel*/,{|| nap })  //"Aptos"
	oCell3 := TRCell():New(oSection3,"INAPTOS" ,"   " ,STR0047 ,"@E 999,999" ,09,/*lPixel*/,{|| nin })  //"Inaptos"
	oCell3 := TRCell():New(oSection3,"APTOC"   ,"   " ,STR0048 ,"@E 999,999" ,23,/*lPixel*/,{|| nre })  //"Aptos com Restrições"
	oCell3 := TRCell():New(oSection3,"CANC"	 ,"   " ,STR0049 ,"@E 999,999" ,14,/*lPixel*/,{|| nca })  //"Cancelados"
	oSection3:Cell("APTOS"):SetHeaderAlign("RIGHT")
	oSection3:Cell("INAPTOS"):SetHeaderAlign("RIGHT")
	oSection3:Cell("APTOC"):SetHeaderAlign("RIGHT")
	oSection3:Cell("CANC"):SetHeaderAlign("RIGHT")

	oSection4 := TRSection():New(oReport,STR0050,{"TRB"})  //"Resumo"
	oCell4 := TRCell():New(oSection4,"    "	 ,"   " ,STR0045 ,"@!" 		 ,22,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Resumo do Relatório:"
	oCell4 := TRCell():New(oSection4,"APTOS"   ,"   " ,STR0046 ,"@E 999,999" ,08,/*lPixel*/,{|| napto })  //"Aptos"
	oCell4 := TRCell():New(oSection4,"INAPTOS" ,"   " ,STR0047 ,"@E 999,999" ,09,/*lPixel*/,{|| ninapto })  //"Inaptos"
	oCell4 := TRCell():New(oSection4,"APTOC"   ,"   " ,STR0048 ,"@E 999,999" ,23,/*lPixel*/,{|| nrestri })  //"Aptos com Restrições"
	oCell4 := TRCell():New(oSection4,"CANC"	 ,"   " ,STR0049 ,"@E 999,999" ,14,/*lPixel*/,{|| ncancel })  //"Cancelados"
	oSection4:Cell("APTOS"):SetHeaderAlign("RIGHT")
	oSection4:Cell("INAPTOS"):SetHeaderAlign("RIGHT")
	oSection4:Cell("APTOC"):SetHeaderAlign("RIGHT")
	oSection4:Cell("CANC"):SetHeaderAlign("RIGHT")

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTR440R3 ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio dos Atestados Ocupacionais emitidos no periodo.   ³±±
±±³          ³O usuario pode informar o periodo desejado obtendo como     ³±±
±±³          ³resultado a relacao de Funcionarios que ja realizaram o     ³±±
±±³          ³exame de avalizacao clinica o qual gera o ASO. O relatorio  ³±±
±±³          ³totaliza por o numero de atestados com parecer Aptos e Ina- ³±±
±±³          ³ptos.                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MDTR440void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
	User Function MDTR440R3()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOCAL wnrel   := "MDTR440"
	LOCAL limite  := 132
	LOCAL cDesc1  := STR0001  //"Relatorio de apresentacao dos Atestados de Saude Ocupacinal emitidos"
	LOCAL cDesc2  := STR0002 //"Atraves dos parametros o usuario podera selecionar: Periodo Desejado"
	LOCAL cDesc3  := " "
	LOCAL cString := "TMY"

	PRIVATE nomeprog := "MDTR440"
	PRIVATE tamanho  := If(TMY->(FieldPos("TMY_NOVFUN")) > 0,"G","M")
	PRIVATE aReturn  := { STR0003, 1,STR0004, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
	PRIVATE titulo   := STR0005 //"Atestados de Saude Ocupacional"
	PRIVATE ntipo    := 0
	PRIVATE nLastKey := 0
	PRIVATE cabec1, cabec2

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	pergunte(cPerg,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel:="MDTR440"

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

	RptStatus({|lEnd| R440Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R440Imp  ³ Autor ³ Inacio Luiz Kolling   ³ Data ³14/04/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR440                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R440Imp(lEnd,wnRel,titulo,tamanho)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cRodaTxt := ""
	Local nCntImpr := 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis para controle do cursor de progressao do relatorio ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Contadores de linha e pagina                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private li := 80 ,m_pag := 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se deve comprimir ou nao                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTipo  := IIF(aReturn[4]==1,15,18)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta os Cabecalhos                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cabec1 := STR0006 //"ASO    Ficha     Matric.   Nome do Funcionario                  Program. Emissao  Cancel.  Parecer              Natureza"
	cabec2 := "  "

	/*
	*******************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                 <Relatorio de Questionario Medico>                               DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	*******************************************************************************************************************************************
	0         1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
	*******************************************************************************************************************************************
	ASO    Ficha     Matric. Nome do Funcionario                    Program. Emissao  Cancel.  Parecer              Natureza
	Função               Centro de Custo                          Tarefa
	*******************************************************************************************************************************************
	xxxxxx xxxxxxxxx xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xxxx xx/xx/xxxx xx/xx/xxxx xxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxx
	xxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	xxxxxx xxxxxxxxx xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xxxx xx/xx/xxxx xx/xx/xxxx xxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxx
	xxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	xxxxxx xxxxxxxxx xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xxxx xx/xx/xxxx xx/xx/xxxx xxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxx
	xxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	xxxxxx xxxxxxxxx xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xxxx xx/xx/xxxx xx/xx/xxxx xxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxx
	xxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	-------------------------------------------------------------------------------------------------------------------------------------------
					Resumo:   Aptos..: 999.999   Inaptos..: 999.999   Apto Com Restrincao..: 999.999   Cancelados..: 999.999
	*/

	Processa({|lEND| MDTR440TMY(@lEnd)},STR0051)  //"Processando Arquivo..."

	If lSigaMdtps

		napto   := 0
		ninapto := 0
		nrestri := 0
		ncancel := 0
		lFirst := .T.

		dbSelectArea("TRB")
		dbgotop()
		SetRegua(LastRec())
		While !Eof()
			cCliente := TRB->CLIENTE
			cLoja := TRB->LOJA
			lFirst := .T.
			nap := 0
			nin := 0
			nre := 0
			nca := 0
			While !EOF() .And. TRB->CLIENTE == cCliente .And. TRB->LOJA == cLoja
				IncRegua()
				If !Empty(TRB->DTCANC)
					ncancel := ncancel + 1
					nca := nca + 1
					cINDPAR := STR0013 //'Cancelado'
				ElseIf TRB->INDPAR == '1'
					cINDPAR := STR0014 //'Apto'
					napto   := napto + 1
					nap   := nap + 1
				ElseIf TRB->INDPAR == '2'
					cINDPAR := STR0015 //'Inapto'
					ninapto := ninapto + 1
					nin := nin + 1
				Elseif TRB->INDPAR == '3'
					cINDPAR := STR0016 //'Apto Com Restricoes'
					nrestri := nrestri + 1
					nre := nre + 1
				Endif

				If lFirst
					Somalinha()
					Dbselectarea("SA1")
					Dbsetorder(1)
					Dbseek(xFilial("SA1")+TRB->CLIENTE+TRB->LOJA)
					@ Li,000 PSay STR0052 //"Cliente/Loja:"
					@ Li,014 PSay Alltrim(TRB->CLIENTE)+"-"+AllTrim(TRB->LOJA)+" - "+Alltrim(SA1->A1_NOME)
					Somalinha()
					lFirst := .F.
				Endif
				SomaLinha()
				@ Li,000 PSay TRB->ASO Picture "@!"
				@ Li,007 PSay TRB->NUMFIC Picture "@!"
				@ Li,017 PSay TRB->MAT Picture "@!"
				@ Li,025 PSay substr(TRB->NOME,1,35) Picture "@!"
				@ LI,065 PSay TRB->DTPROG Picture "99/99/9999"
				@ LI,076 PSay TRB->DTEMIS Picture "99/99/9999"
				@ LI,087 PSay TRB->DTCANC Picture "99/99/9999"
				@ Li,098 PSay cINDPAR Picture "@!"
				@ Li,119 PSay TRB->NATURE Picture "@!"


					SomaLinha()
					@ Li,002 PSay TRB->NOVFUN	Picture "@!"
					@ Li,023 PSay TRB->NOVCC		Picture "@!"
					@ Li,064 PSay TRB->NOVTAR	Picture "@!"


				dbSelectArea("TRB")
				dbskip()
			End
			If nca > 0 .Or. nap > 0 .Or. nin > 0 .Or. nre > 0
				SomaLinha()
				SomaLinha()
				@ Li,000 PSay Replicate("-",132)
				SomaLinha()
				@ Li,000 PSay STR0023		 //"Resumo do Cliente"
				If nap > 0
					SomaLinha()
					@ Li,000 PSay STR0018 //"Aptos.................:"
					@ Li,025 PSay nap picture "@E 999,999"
				Endif
				If nin > 0
					SomaLinha()
					@ Li,000 PSay STR0019 //"Inaptos...............:"
					@ Li,025 PSay nin picture "@E 999,999"
				Endif
				If nre > 0
					SomaLinha()
					@ Li,000 PSay STR0020 //"Apto Com Restricoes..:"
					@ Li,025 PSay nre picture "@E 999,999"
				Endif
				If nca > 0
					SomaLinha()
					@ Li,000 PSay STR0021 //"Cancelado.............:"
					@ Li,025 PSay nca picture "@E 999,999"
				Endif
			Endif
			dbSelectArea("TRB")
			If !eof()
				li := 80
			Endif
		End

		If ncancel > 0 .Or. napto > 0 .Or. ninapto > 0 .Or. nrestri > 0
			SomaLinha()
			SomaLinha()
			@ Li,000 PSay Replicate("-",132)
			SomaLinha()
			@ Li,000 PSay STR0017 //"Resumo do Relatorio"

			If napto > 0
				SomaLinha()
				@ Li,000 PSay STR0018 //"Aptos.................:"
				@ Li,025 PSay napto picture "@E 999,999"
			Endif

			If ninapto > 0
				SomaLinha()
				@ Li,000 PSay STR0019 //"Inaptos...............:"
				@ Li,025 PSay ninapto picture "@E 999,999"
			Endif

			If nrestri > 0
				SomaLinha()
				@ Li,000 PSay STR0020 //"Apto Com Restricoes..:"
				@ Li,025 PSay nrestri picture "@E 999,999"
			Endif

			If ncancel > 0
				SomaLinha()
				@ Li,000 PSay STR0021 //"Cancelado.............:"
				@ Li,025 PSay ncancel picture "@E 999,999"
			Endif

		Endif

	Else

		napto   := 0
		ninapto := 0
		nrestri := 0
		ncancel := 0
		Condicao := "!EOF()"
		lSX6 := .F.
		lFirst := .T.
		If lMDTPS
			Condicao := "!EOF() .And. TRB->CLIENTE == cCliente"
			lSX6 := .T.
		Endif

		dbSelectArea("TRB")
		dbgotop()
		SetRegua(LastRec())
		While !Eof()
			cCliente := TRB->CLIENTE
			lFirst := .T.
			nap := 0
			nin := 0
			nre := 0
			nca := 0
			While &Condicao
			IncRegua()
			If !Empty(TRB->DTCANC)
				ncancel := ncancel + 1
				nca := nca + 1
				cINDPAR := STR0013 //'Cancelado'
			ElseIf TRB->INDPAR == '1'
				cINDPAR := STR0014 //'Apto'
				napto   := napto + 1
				nap   := nap + 1
			ElseIf TRB->INDPAR == '2'
				cINDPAR := STR0015 //'Inapto'
				ninapto := ninapto + 1
				nin := nin + 1
			Elseif TRB->INDPAR == '3'
				cINDPAR := STR0016 //'Apto Com Restricoes'
				nrestri := nrestri + 1
				nre := nre + 1
			Endif

			If lSX6
				If lFirst
					Somalinha()
					Dbselectarea("SA1")
					Dbsetorder(1)
					Dbseek(xFilial("SA1")+TRB->CLIENTE)
					@ Li,000 PSay STR0022 //"Cliente..:"
					@ Li,011 PSay Alltrim(TRB->CLIENTE)+" - "+Alltrim(SA1->A1_NOME)
					Somalinha()
					lFirst := .F.
				Endif
			Endif
			SomaLinha()
			@ Li,000 PSay TRB->ASO Picture "@!"
			@ Li,007 PSay TRB->NUMFIC Picture "@!"
			@ Li,017 PSay TRB->MAT Picture "@!"
				@ Li,025 PSay substr(TRB->NOME,1,35) Picture "@!"
				@ LI,065 PSay TRB->DTPROG Picture "99/99/9999"
				@ LI,076 PSay TRB->DTEMIS Picture "99/99/9999"
				@ LI,087 PSay TRB->DTCANC Picture "99/99/9999"
			@ Li,098 PSay cINDPAR Picture "@!"
				@ Li,119 PSay TRB->NATURE Picture "@!"


					SomaLinha()
					@ Li,002 PSay TRB->NOVFUN	Picture "@!"
					@ Li,023 PSay TRB->NOVCC		Picture "@!"
					@ Li,064 PSay TRB->NOVTAR	Picture "@!"


			dbSelectArea("TRB")
			dbskip()
			End
			If lSX6
				If nca > 0 .Or. nap > 0 .Or. nin > 0 .Or. nre > 0
					SomaLinha()
					SomaLinha()
					@ Li,000 PSay Replicate("-",132)
					SomaLinha()
					@ Li,000 PSay STR0023		 //"Resumo do Cliente"
					If nap > 0
					SomaLinha()
					@ Li,000 PSay STR0018 //"Aptos.................:"
					@ Li,025 PSay nap picture "@E 999,999"
					Endif
					If nin > 0
					SomaLinha()
					@ Li,000 PSay STR0019 //"Inaptos...............:"
					@ Li,025 PSay nin picture "@E 999,999"
					Endif
					If nre > 0
					SomaLinha()
					@ Li,000 PSay STR0020 //"Apto Com Restricoes..:"
					@ Li,025 PSay nre picture "@E 999,999"
					Endif
					If nca > 0
					SomaLinha()
					@ Li,000 PSay STR0021 //"Cancelado.............:"
					@ Li,025 PSay nca picture "@E 999,999"
					Endif
				Endif
				dbSelectArea("TRB")
				If !eof()
					li := 80
				Endif
			Endif
		End

		If ncancel > 0 .Or. napto > 0 .Or. ninapto > 0 .Or. nrestri > 0
			SomaLinha()
			SomaLinha()
			@ Li,000 PSay Replicate("-",132)
			SomaLinha()
			@ Li,000 PSay STR0017 //"Resumo do Relatorio"

			If napto > 0
			SomaLinha()
			@ Li,000 PSay STR0018 //"Aptos.................:"
			@ Li,025 PSay napto picture "@E 999,999"
			Endif

			If ninapto > 0
			SomaLinha()
			@ Li,000 PSay STR0019 //"Inaptos...............:"
			@ Li,025 PSay ninapto picture "@E 999,999"
			Endif

			If nrestri > 0
			SomaLinha()
			@ Li,000 PSay STR0020 //"Apto Com Restricoes..:"
			@ Li,025 PSay nrestri picture "@E 999,999"
			Endif

			If ncancel > 0
			SomaLinha()
			@ Li,000 PSay STR0021 //"Cancelado.............:"
			@ Li,025 PSay ncancel picture "@E 999,999"
			Endif

		Endif

	Endif

	//Roda(nCntImpr,cRodaTxt,Tamanho)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve a condicao original do arquivo principal             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("TRB")
	dbGotop()
	If RecCount()==0
		MsgInfo(STR0053)  //"Não há nada para imprimir no relatório."
		oTempTRB:Delete()
		RetIndex("TMY")
		Set Filter To
		Return .F.
	Endif

	RetIndex("TMY")
	oTempTRB:Delete()

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif
	MS_FLUSH()

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportPrint³ Autor ³ Rafael Diogo Richter  ³ Data ³03/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Chamada do Relatorio.                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMDT                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(2)
	Local oSection3 := oReport:Section(3)
	Local oSection4 := oReport:Section(4)
	Local Condicao := "!EOF()"
	Local lFirst := .T.

	Private lSX6 := .F.
	Private cINDPAR
	Private napto   := 0
	Private ninapto := 0
	Private nrestri := 0
	Private ncancel := 0
	Private nap	:= 0
	Private nin := 0
	Private nre := 0
	Private nca := 0

	Processa({|lEND| MDTR440TMY(@lEnd)},STR0051)  //"Processando Arquivo..."

	If lSigaMdtps

		dbSelectArea("TRB")
		dbgotop()
		oReport:SetMeter(RecCount())
		While !Eof()
			cCliente := TRB->CLIENTE
			cLoja := TRB->LOJA
			lFirst := .T.
			nap := 0
			nin := 0
			nre := 0
			nca := 0
			While !EOF() .And. TRB->CLIENTE == cCliente .And. TRB->LOJA == cLoja
			oReport:IncMeter()
			If !Empty(TRB->DTCANC)
				ncancel := ncancel + 1
				nca := nca + 1
				cINDPAR := STR0013 //'Cancelado'
			ElseIf TRB->INDPAR == '1'
				cINDPAR := STR0014 //'Apto'
				napto   := napto + 1
				nap   := nap + 1
			ElseIf TRB->INDPAR == '2'
				cINDPAR := STR0015 //'Inapto'
				ninapto := ninapto + 1
				nin := nin + 1
			Elseif TRB->INDPAR == '3'
				cINDPAR := STR0016 //'Apto Com Restricoes'
				nrestri := nrestri + 1
				nre := nre + 1
			Endif

			If lFirst
				oSection1:Init()
				oSection1:PrintLine()
				oSection1:Finish()
				lFirst := .F.
			Endif

			oSection2:Init()
			oSection2:PrintLine()

			dbSelectArea("TRB")
			dbskip()
			End
			oSection3:Init()
			oSection3:PrintLine()
			oSection3:Finish()
			oSection2:Finish()
		End

		If ncancel > 0 .Or. napto > 0 .Or. ninapto > 0 .Or. nrestri > 0
			oSection4:Init()
			oSection4:PrintLine()
			oSection4:Finish()
		Endif

	Else

		If GetMv("MV_NGMDTPS") = "S"
			Condicao := "!EOF() .And. TRB->CLIENTE == cCliente"
			lSX6 := .T.
		Endif

		dbSelectArea("TRB")
		dbgotop()
		oReport:SetMeter(RecCount())
		While !Eof()
			cCliente := TRB->CLIENTE
			lFirst := .T.
			nap := 0
			nin := 0
			nre := 0
			nca := 0
			While &Condicao
			oReport:IncMeter()
			If !Empty(TRB->DTCANC)
				ncancel := ncancel + 1
				nca := nca + 1
				cINDPAR := STR0013 //'Cancelado'
			ElseIf TRB->INDPAR == '1'
				cINDPAR := STR0014 //'Apto'
				napto   := napto + 1
				nap   := nap + 1
			ElseIf TRB->INDPAR == '2'
				cINDPAR := STR0015 //'Inapto'
				ninapto := ninapto + 1
				nin := nin + 1
			Elseif TRB->INDPAR == '3'
				cINDPAR := STR0016 //'Apto Com Restricoes'
				nrestri := nrestri + 1
				nre := nre + 1
			Endif
			If lSX6
				If lFirst
						oSection1:Init()
						oSection1:PrintLine()
						oSection1:Finish()
					lFirst := .F.
				Endif
			Endif
				oSection2:Init()
				oSection2:PrintLine()
				If TRB->NATEXA == "3"
					oReport:PrintText(STR0059 + ": " + TRB->NOVFUN + STR0065 + ": " + TRB->NOVCC + STR0066 + ": " + TRB->NOVTAR , , 320 )
				EndIf

			dbSelectArea("TRB")
			dbskip()
			End
			If lSX6
				oSection3:Init()
				oSection3:PrintLine()
				oSection3:Finish()
			Endif
			oSection2:Finish()
		End

		If ncancel > 0 .Or. napto > 0 .Or. ninapto > 0 .Or. nrestri > 0
			oSection4:Init()
			oSection4:PrintLine()
			oSection4:Finish()
		Endif

	Endif

	dbSelectArea("TRB")
	dbGotop()
	If RecCount()==0
		MsgInfo(STR0053)  //"Não há nada para imprimir no relatório."
	oTempTRB:Delete()
		Return .F.
	Endif

	oTempTRB:Delete()

Return .T.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³14/04/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha()

    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
//        Li := Li - 1
    EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTR440TMY³ Autor ³ Rafael Diogo Richter  ³ Data ³07/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Processa o arquivo temporario.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMDT                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MDTR440TMY(lEnd)

	Local nTamMat     := TAMSX3("RA_MAT")[1]
	Local lContinua   := .T.

	Private aVetinr   := {}
	Private aTMYCombo := MDTCbox("TMY_NATEXA"," ",1)

	If lSigaMdtps

		aDBF := {}
		AADD(aDBF,{ "CLIENTE" , "C" ,nTa1, 0 })
		AADD(aDBF,{ "LOJA"    , "C" ,nTa1L,0 })
		AADD(aDBF,{ "ASO"     , "C" ,06, 0 })
		AADD(aDBF,{ "NUMFIC"  , "C" ,09, 0 })
		AADD(aDBF,{ "MAT"     , "C" ,nTamMat, 0 })
		AADD(aDBF,{ "NOME"    , "C" ,40, 0 })
		AADD(aDBF,{ "DTPROG"  , "D" ,08, 0 })
		AADD(aDBF,{ "DTEMIS"  , "D" ,08, 0 })
		AADD(aDBF,{ "DTCANC"  , "D" ,08, 0 })
		AADD(aDBF,{ "INDPAR"  , "C" ,01, 0 })
		AADD(aDBF,{ "NATEXA"  , "C" ,01, 0 })
		AADD(aDBF,{ "NATURE"  , "C" ,30, 0 })

			AADD(aDBF,{ "NOVFUN", "C", 20, 0 })
			AADD(aDBF,{ "NOVCC",  "C", 40, 0 })
			AADD(aDBF,{ "NOVTAR", "C", 40, 0 })

		//Cria TRB
		oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
		oTempTRB:AddIndex( "1", {"CLIENTE","LOJA","ASO"} )
		oTempTRB:Create()

		dbSelectArea("TMY")
		dbSetOrder(06)  //TMY_FILIAL+TMY_CLIENT+TMY_LOJA+TMY_NUMASO+TMY_NUMFIC
		dbSeek(xFilial("TMY")+MV_PAR01+MV_PAR02,.T.)
		ProcRegua(LastRec())
		While !Eof()                                 .And. ;
			TMY->TMY_FILIAL == xFIlial('TMY')        .And. ;
			TMY->(TMY_CLIENT+TMY_LOJA) <= MV_PAR03+MV_PAR04

			IncProc()

			If TMY->TMY_NUMASO < MV_PAR05 .Or. TMY->TMY_NUMASO > MV_PAR06
				dbSelectArea("TMY")
				dbSkip()
				loop
			EndIf

			If Empty(TMY->TMY_DTEMIS)
				dbSelectArea("TMY")
				dbSkip()
				loop
			EndIf

			If TMY->TMY_DTEMIS < MV_PAR07 .Or. TMY->TMY_DTEMIS > MV_PAR08
				dbSelectArea("TMY")
				dbSkip()
				loop
			EndIf

			dbSelectArea("TM0")
			dbSetOrder(01)
			dbSeek(xFilial("TM0")+TMY->TMY_NUMFIC)

			dbSelectArea("SRA")
			dbSetOrder(01)
			dbSeek(xFilial("SRA")+TM0->TM0_MAT)

			TRB->(DBAPPEND())
			TRB->ASO     := TMY->TMY_NUMASO
			TRB->CLIENTE := TMY->TMY_CLIENT
			TRB->LOJA    := TMY->TMY_LOJA
			TRB->NUMFIC  := TMY->TMY_NUMFIC
			TRB->MAT     := TM0->TM0_MAT
			TRB->DTPROG  := TMY->TMY_DTPROG
			TRB->DTEMIS  := TMY->TMY_DTEMIS
			TRB->DTCANC  := TMY->TMY_DTCANC
			TRB->INDPAR  := TMY->TMY_INDPAR
			TRB->NATEXA  := TMY->TMY_NATEXA

			If (nIND := aScan(aTMYcombo,{|x| Upper(Substr(x,1,1)) == Substr(TMY->TMY_NATEXA,1,1)})) > 0
					TRB->NATURE  := Substr(aTMYcombo[nIND],3,17)
			EndIf

			TRB->NOVFUN  := SubStr(NGSEEK("TOS",TMY->TMY_NOVFUN+TMY->TMY_CLIENT+TMY->TMY_LOJA,1,"TOS->TOS_DESFUN"),1,30)

			dbSelectArea("TMY")
			TMY->(dbskip())

		EndDo

	Else

		aDBF := {}
		AADD(aDBF,{ "CLIENTE" , "C" ,06, 0 })
		AADD(aDBF,{ "ASO"     , "C" ,06, 0 })
		AADD(aDBF,{ "NUMFIC"  , "C" ,09, 0 })
		AADD(aDBF,{ "MAT"     , "C" ,nTamMat, 0 })
		AADD(aDBF,{ "NOME"    , "C" ,40, 0 })
		AADD(aDBF,{ "NOMESO"  , "C" ,40, 0 })
		AADD(aDBF,{ "DTPROG"  , "D" ,08, 0 })
		AADD(aDBF,{ "DTEMIS"  , "D" ,08, 0 })
		AADD(aDBF,{ "DTCANC"  , "D" ,08, 0 })
		AADD(aDBF,{ "INDPAR"  , "C" ,01, 0 })
		AADD(aDBF,{ "NATEXA"  , "C" ,01, 0 })
		AADD(aDBF,{ "NATURE"  , "C" ,30, 0 })

			AADD(aDBF,{ "NOVFUN"  , "C" ,20, 0 })
			AADD(aDBF,{ "NOVCC"  , "C" ,40, 0 })
			AADD(aDBF,{ "NOVTAR"  , "C" ,40, 0 })

		//Cria TRB
		oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
		oTempTRB:AddIndex( "1", {"CLIENTE","ASO"} )
		oTempTRB:Create()

		dbSelectArea("TMY")
		dbSetOrder(01)
		dbSeek(xFilial("TMY")+MV_PAR01,.T.)
		ProcRegua(LastRec())
		While lContinua                       .And. ;
			!Eof()                            .And. ;
			TMY->TMY_FILIAL == xFIlial('TMY') .And. ;
			TMY->TMY_NUMASO <= MV_PAR02

			IncProc()

			If Empty(TMY->TMY_DTEMIS)
				dbSelectArea("TMY")
				dbSkip()
				loop
			EndIf

			If TMY->TMY_DTEMIS < MV_PAR03 .Or. TMY->TMY_DTEMIS > MV_PAR04
				dbSelectArea("TMY")
				dbSkip()
				loop
			EndIf

			dbSelectArea("TM0")
			dbSetOrder(01)
			dbSeek(xFilial("TM0")+TMY->TMY_NUMFIC)

			dbSelectArea("SRA")
			dbSetOrder(01)
			dbSeek(xFilial("SRA")+TM0->TM0_MAT)

			cCli := SUBSTR(SRA->RA_CC,1,6)

			If lMDTPS
				If SUBSTR(SRA->RA_CC,1,6) < MV_PAR05 .Or. SUBSTR(SRA->RA_CC,1,6) > MV_PAR06
					dbSelectArea("TMY")
					dbSkip()
					loop
				EndIf
			Else
				cCli := ""
			EndIf

			TRB->(DBAPPEND())
			TRB->ASO     := TMY->TMY_NUMASO
			TRB->CLIENTE := cCli
			TRB->NUMFIC  := TMY->TMY_NUMFIC
			TRB->MAT     := TM0->TM0_MAT
			TRB->DTPROG  := TMY->TMY_DTPROG
			TRB->DTEMIS  := TMY->TMY_DTEMIS
			TRB->DTCANC  := TMY->TMY_DTCANC
			TRB->INDPAR  := TMY->TMY_INDPAR
			TRB->NATEXA  := TMY->TMY_NATEXA

			If !Empty( SRA->RA_NSOCIAL )
				TRB->NOMESO := SRA->RA_NSOCIAL
			EndIf

			If !Empty( SRA->RA_NOME )
				TRB->NOME := SRA->RA_NOME

			ElseIf !Empty( TM0->TM0_NOMFIC )
				TRB->NOME := TM0->TM0_NOMFIC

			EndIf

			If (nIND := aScan(aTMYcombo,{|x| Upper(Substr(x,1,1)) == Substr(TMY->TMY_NATEXA,1,1)})) > 0
					TRB->NATURE  := Substr(aTMYcombo[nIND],3,20)
			EndIf

				TRB->NOVFUN  := SubStr(NGSEEK("SRJ",TMY->TMY_NOVFUN,1,"SRJ->RJ_DESC"),1,20)
				TRB->NOVCC  := SubStr(NGSEEK("CTT",TMY->TMY_NOVCC,1,"CTT->CTT_DESC01"),1,40)
				TRB->NOVTAR  := SubStr(NGSEEK("TN5",TMY->TMY_NOVTAR,1,"TN5->TN5_NOMTAR"),1,40)


			dbSelectArea("TMY")
			TMY->(dbskip())

		EndDo

	EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    | MDT440CLR| Autor ³ 	 Jackson Machado    ³ Data ³06/05/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Limpa campo do atestado aso.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMDT                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT440CLR(lLoja)

	If ValCli(1,mv_par01,'mv_par02',mv_par03,'mv_par04',nTa1,nTa1L)
		If AllTrim(mv_par01) != Posicione("SX1", 1, cPerg+"01", "X1_CNT01")
			mv_par05 := Space(6)
			mv_par06 := "ZZZZZZ"
		Endif
	Else
		Return .F.
	Endif

	If ValCli(3,mv_par01,'mv_par02',mv_par03,'mv_par04',nTa1,nTa1L)
		If AllTrim(mv_par03) != Posicione("SX1", 1, cPerg+"03", "X1_CNT01")
			mv_par05 := Space(6)
			mv_par06 := "ZZZZZZ"
		Endif
	Else
		Return .F.
	Endif

	If lLoja

		If ValCli(2,mv_par01,'mv_par02',mv_par03,'mv_par04',nTa1,nTa1L)
			If AllTrim(mv_par02) != Posicione("SX1", 1, cPerg+"02", "X1_CNT01")
				mv_par05 := Space(6)
				mv_par06 := "ZZZZZZ"
			Endif
		Else
			Return .F.
		Endif

		If ValCli(2,mv_par01,'mv_par02',mv_par03,'mv_par04',nTa1,nTa1L)
			If AllTrim(mv_par04) != Posicione("SX1", 1, cPerg+"04", "X1_CNT01")
				mv_par05 := Space(6)
				mv_par06 := "ZZZZZZ"
			Endif
		Else
			Return .F.
		Endif

	Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT440ASO
Validação para a pergunta De ASO.

@author Guilherme Freudenburg
@since 21/11/2013
@return
/*/
//---------------------------------------------------------------------

User Function MDT440ASO()

	Local lRet:= .T.

	If !Empty(mv_par01) .And. !ExistCpo("TMY",mv_par01)
		lRet:=.F.
	Endif
	If lRet .And. !Empty(mv_par02) .And. (mv_par01 > mv_par02)
		ShowHelpDlg(STR0060,{STR0061},1,{STR0062},1)
		lRet:=.F.
	Endif

Return lRet
