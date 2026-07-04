/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR780.CH"
#Include "FIVEWIN.Ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Finr780	³ Autor ³ Alessandro B. Freire  ³ Data ³ 07/07/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao relatorio mov. historica do caixa. (J. Santos)   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_FinR780()																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR780																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FinR780

LOCAL cString	:="SE5"
LOCAL cDesc1	:= OemToAnsi(STR0001)  //"Este programa tem como objetivo imprimir a movim. "
LOCAL cDesc2	:= OemToAnsi(STR0002)  //"historica do caixa.                               "
LOCAL cDesc3	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cTitulo	:= OemToAnsi(STR0003)  //"Movimentacoes Historicas"
PRIVATE Cabecalho := OemToAnsi(STR0004)  //"Data          Entrada          Saida              Documento"
PRIVATE aReturn	:= { OemToAnsi(STR0005), 1,OemToAnsi(STR0006), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE cPerg		:= "FIR780"
PRIVATE nLastKey	:= 0
PRIVATE nomeprog	:= "FINR780"
PRIVATE cIndiceSE5:= ""
PRIVATE Tamanho	:= "P"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impress„o do Cabe‡alho e Rodap‚	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt 	:= SPACE(10)
cbcont	:= 0
li 		:= 80
m_pag 	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros								  ³
//³ mv_par01				// Banco 		 ? 							  ³
//³ mv_par02				// Agencia		 ? 							  ³
//³ mv_par03				// Conta 		 ? 							  ³
//³ mv_par04				// Data Movto.  ? 							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR780"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
	 Return( .F. )
End

SetDefault(aReturn,cString)

If nLastKey == 27
	Return( .F. )
Endif

RptStatus({|lEnd| U_Fa780Imp(@lEnd,wnRel,cString)},cTitulo)
dbSelectArea("SA6")
dbSetOrder(1)
Return( .T. )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ Fa780Imp ³ Autor ³ Alessandro B. Freire  ³ Data ³ 04/04/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao relatorio mov. historica do caixa. (J. Santos)   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FA780Imp(lEnd,wnRel,cString)										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametro 1 - lEnd	 - A‡Æo do CodeBlock 					  ³±±
±±³			 ³ Parametro 2 - wnRel	 - T¡tulo do relat¢rio					  ³±±
±±³			 ³ Parametro 3 - cString - Mensagem 								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR780																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA780Imp(lEnd,wnRel,cString)

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
LOCAL nSldAnt	:= 0	//³ Valor do Saldo anterior									³
LOCAL nSaldo	:= 0	//³ Valor do Saldo final										³
LOCAL nEspecie := 0	//³ Total em especies pagar									³
LOCAL nCheques := 0	//³ Total em cheques pagar 									³
LOCAL nAdianta := 0	//³ Total em adiantamentos pagar 							³
LOCAL nProviso := 0	//³ Total em provisorios pagar								³
LOCAL nEspecieR:= 0	//³ Total em especies receber 								³
LOCAL nChequesR:= 0	//³ Total em cheques receber									³
LOCAL nAdiantaR:= 0	//³ Total em adiantamentos receber							³
LOCAL nProvisoR:= 0	//³ Total em provisorios receber 							³
LOCAL nEntrada := 0	//³ Entradas no per¡odo - E5_RECPAG == "R"            ³
LOCAL nSaida	:= 0	//³ Sa¡das no per¡odo	- E5_RECPAG == "P"            ³
LOCAL nIndex	:= 0	//³ Ordem original do SE5										³
LOCAL cChave	:= "" //³ Chave para constru‡Æo do ¡ndice tempor rio        ³
LOCAL cIndex	:= "" //³ Nome do ¡ndice temporario                         ³
LOCAL cFiltro	:= "" //³ Filtro para o ¡ndice tempor rio                   ³
LOCAL nOutros	:= 0	//³ Valor de Outros												³
LOCAL nFatur	:= 0	//³ Faturamento													³
LOCAL nOutrosR := 0	//³ Valor de Outros												³
LOCAL nFaturR	:= 0	//³ Faturamento													³
PRIVATE cCaixa := "" //³ Nome do Caixa em questao.                         ³
PRIVATE cCodCx := "" //³ Codigo do Caixa em questao.                       ³
PRIVATE nChar	:= 0	//³ Caractere de impressao.									³						³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[4] == 1
	nChar := 15
Else
	nChar := 18
EndIf

dbSelectArea("SA6")
dbSetOrder(1)
dbSeek( xFilial() + mv_par01 + mv_par02 + mv_par03 )
cCaixa := Trim( SA6->A6_NREDUZ )
cCodCx := SA6->A6_COD

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Constroi o indice temporario ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
dbSelectArea("SE5")
cIndex	:= CriaTrab(NIL,.F.)
cChave	:= "E5_BANCO + E5_AGENCIA+ E5_CONTA + DTOS(E5_DATA) + E5_SEQMOV"

cFiltro	:= 'E5_FILIAL     == "' + xFilial("SE5")  + '" .And. '
cFiltro	+= 'DTOS(E5_DATA) == "' + DTOS(mv_par04)  + '" .And. '
cFiltro	+= 'E5_BANCO+E5_AGENCIA+E5_CONTA == "'
cFiltro	+= mv_par01+mv_par02+mv_par03 + '"'

nIndex	:= RetIndex("SE5")
IndRegua("SE5",cIndex,cChave,,cFiltro,OemToAnsi(STR0007))  //"Selecionando Registros"
#IFNDEF TOP
	dbSetIndex( cIndex +OrdBagExt())
#ENDIF
dbSetOrder( nIndex + 1 )
dbGoTop()

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Nƒo h  nenhum registro				³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
If Eof() .And. Bof()
	RetIndex("SE5")
	dbSetOrder(1)
	fErase( cIndex + OrdBagExt() )
	Return( .T. )
EndIf

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Verifica saldo Anterior		³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
dbSelectArea("SE8")
dbSetOrder(1)
dbSeek(xFilial("SE8")+mv_par01+mv_par02+mv_par03+DtoS(mv_par04),.T.)
dbSkip(-1)
If SE8->E8_BANCO + SE8->E8_AGENCIA + SE8->E8_CONTA != ;
	mv_par01 + mv_par02 + mv_par03 .OR. Bof()
	nSldAnt := 0
Else
	nSldAnt := SE8->E8_SALATUA
EndIf

li := 61

dbSelectArea("SE5")
While !Eof()

	 IF lEnd
		  Exit
	 End

	If SE5->E5_TIPODOC $ "BA/JR/CM/MT/TL/D2/J2/M2/V2"
		dbSkip()
		Loop
	Endif

	/* Aqui devem ser filtrados os tipos de documentos que nao devem
	ser impressos */

	U_fr780Cabec()

	@li, 0 PSAY DtoC( SE5->E5_DATA )
	If SE5->E5_RECPAG == "R"
		@li,11 PSAY SE5->E5_VALOR Picture "@E 99999,999.99"
	Else
		@li,28 PSAY SE5->E5_VALOR Picture "@E 99999,999.99"
	EndIf
	@li,52 PSAY Iif(!Empty(SE5->E5_NUMCHEQ),SE5->E5_NUMCHEQ,SE5->E5_DOCUMEN)
	li := li + 1
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Atualiza entradas e saidas			 ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
	If SE5->E5_RECPAG == "R"
		nEntrada := nEntrada + SE5->E5_VALOR
	Else
		nSaida	:= nSaida + SE5->E5_VALOR
	EndIf

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Atualiza composicao do saldo		 ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
	If SE5->E5_RECPAG == "P"
		If SE5->E5_MOEDA $ "M1³M2³M3³M4³M5"
			nEspecie := nEspecie + SE5->E5_VALOR
		ElseIf SE5->E5_MOEDA $ "CH³C1³C2³C3³C4³C5" .OR. ;
			SE5->E5_TIPO $ MVCHEQUES
			nCheques := nCheques + SE5->E5_VALOR
		ElseIf SE5->E5_TIPODOC == "PA"
			nAdianta := nAdianta + SE5->E5_VALOR
		Elseif SE5->E5_MOEDA == "PR"
			nProviso := nProviso + SE5->E5_VALOR
		Elseif SE5->E5_TIPODOC == "VL"
			nFatur	:= nFatur + SE5->E5_VALOR
		Else
			nOutros	:= nOutros + SE5->E5_VALOR
		Endif
	EndIf

	If SE5->E5_RECPAG == "R"
		If SE5->E5_MOEDA $ "M1³M2³M3³M4³M5"
			nEspecieR := nEspecieR + SE5->E5_VALOR
		Elseif SE5->E5_MOEDA $ "CH³C1³C2³C3³C4³C5" .OR. SE5->E5_TIPO $ MVCHEQUES
			nChequesR := nChequesR + SE5->E5_VALOR
		ElseIf SE5->E5_TIPODOC == "RA"
			nAdiantaR := nAdiantaR + SE5->E5_VALOR
		Elseif SE5->E5_MOEDA == "PR"
			nProvisoR := nProvisoR + SE5->E5_VALOR
		Elseif SE5->E5_TIPODOC == "VL"
			nFaturR	 := nFatuR + SE5->E5_VALOR
		Else
			nOutrosR  := nOutrosR + SE5->E5_VALOR
		EndIf
	EndIf
	dbSkip()
EndDo
li := li + 1

U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0008)  //"MOVIMENTO DE CAIXA"
li := li + 1
@li,00 PSAY OemToAnsi(STR0009)  //"SALDO ANTERIOR...............:"
@li,31 PSAY nSldAnt PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0010)  //"ENTRADAS.....................:"
@li,31 PSAY nEntrada PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0011)  //"SUB-TOTAL....................:"
@li,31 PSAY nEntrada + nSldAnt  PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0012)  //"SAIDAS.......................:"
@li,31 PSAY nSaida  PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0013)  //"SALDO........................:"
@li,31 PSAY nSldAnt + nEntrada - nSaida  PICTURE "@E 99,999,999,999,999.99"

li := li + 3

U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0014)  //"COMPOSICAO DO SALDO                            PAGAR                 RECEBER"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0015)  //"ESPECIE.......................:"
@li,31 PSAY nEspecie  PICTURE "@E 99,999,999,999,999.99"
@li,55 PSAY nEspecieR PICTURE "@E 99,999,999,999,999.99"

li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0016)  //"CHEQUE DEPOSITO...............:"
@li,31 PSAY nCheques  PICTURE "@E 99,999,999,999,999.99"
@li,55 PSAY nChequesR PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0017)  //"ADIANTAMENTOS.................:"
@li,31 PSAY nAdianta  PICTURE "@E 99,999,999,999,999.99"
@li,55 PSAY nAdiantaR PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0018)  //"RECIBOS PROVISORIOS...........:"
@li,31 PSAY nProviso  PICTURE "@E 99,999,999,999,999.99"
@li,55 PSAY nProvisoR PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0019)  //"CHEQUES P/ PAGAMENTO..........:"
// @li,31 PSAY ? PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0020)  //"FATURAMENTO...................:"
@li,31 PSAY nFatur	 PICTURE "@E 99,999,999,999,999.99"
@li,55 PSAY nFaturR	 PICTURE "@E 99,999,999,999,999.99"
li := li + 1
U_fr780Cabec()
@li,00 PSAY OemToAnsi(STR0021)  //"OUTROS........................:"
@li,31 PSAY nOutros	 PICTURE "@E 99,999,999,999,999.99"
@li,55 PSAY nOutrosR  PICTURE "@E 99,999,999,999,999.99"
li := li + 1
@li,00 PSAY STR0013  //"SALDO.........................:"
@li,55 PSAY nSldAnt + nEntrada - nSaida PICTURE "@E 99,999,999,999,999.99"

Roda(cbcont,cbtxt,"P")

If aReturn[5] == 1
	 Set Printer to
	 dbCommitAll()
	 OurSpool(wnrel)
Endif
MS_FLUSH()
RetIndex("SE5")
fErase( cIndex + OrdBagExt() )
dbSetOrder(1)
Return( .T. )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³Fr780Cabec³ Autor ³ Alessandro B. Freire  ³ Data ³ 04/04/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime o cabecalho especifico do relatorio					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_Fr780Cabec()															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR780																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fr780Cabec
LOCAL aDriver		:= ReadDriver()
LOCAL cEmissao		:= OemToAnsi(STR0023)+ DtoC( dDataBase )  //"Emissao: " 
LOCAL cHora 		:= OemToAnsi(STR0024) + Time()  //"   Hora: "
LOCAL cPagina		:= OemToAnsi(STR0025) + StrZero( m_pag + 1, 8 )  //"  Folha: "
LOCAL cTamanho 		:= Tamanho
LOCAL cCabec1		:= OemToAnsi(STR0026)  //"Movimentacoes Historicas"
LOCAL cCabec2		:=  + CcAIXA  //"do "
LOCAL cSequencial	:= OemToAnsi(STR0027) + cCodCx  //"Sequencial do Caixa No. "
LOCAL nLargura		:= 80
Local aFil			:= FWArrFilAtu( cEmpAnt, cFilAnt )

If li < 61
	Return( .T. )
EndIf

if nChar == NIL
	 @ 0,0 PSAY &(if(cTamanho=="P",aDriver[1],if(cTamanho=="G",aDriver[5],aDriver[3])))
else
	 if nChar == 15
		  @ 0,0 PSAY &(if(cTamanho=="P",aDriver[1],if(cTamanho=="G",aDriver[5],aDriver[3])))
		  nLargura := 132
	 else
		  @ 0,0 PSAY &(if(cTamanho=="P",aDriver[2],if(cTamanho=="G",aDriver[6],aDriver[4])))
	 endif
endif
li := 01
dbSelectArea( "SM0" )
@ li, 00 PSAY Replicate("*",nlargura)

li := li + 1
@ li,00 PSAY NomeProg
@ li,00+(nLargura/2)-(Len(cCabec1)/2) PSAY cCabec1
@ li,00+nLargura - Len(cEmissao) PSAY cEmissao

li := li + 1
@ li,00+(nLargura/2)-(Len(cCabec2)/2) PSAY cCabec2
@ li,00+nLargura-Len(cHora) PSAY cHora

li := li + 1
@ li,00 PSAY OemToAnsi(STR0028) + aFil[1] + " " + aFil[2] + " " + SM0->M0_NOMECOM  // "Empresa: " 
@ li,00+nLargura-Len(cPagina) PSAY cPagina
li := li + 1
@ li,00 PSAY OemToAnsi(STR0029) + DtoC( mv_par04 )  // "Movimento do Dia " 
@ li,00+nLargura-Len(cSequencial) PSAY cSequencial

li := li + 1
@ li,00 PSAY Repl("*",nLargura)
li := li + 1
@li,00 PSAY Cabecalho
li := li + 1
@ li,00 PSAY Repl("*",nLargura)
li := li + 1
dbSelectArea("SE5")
