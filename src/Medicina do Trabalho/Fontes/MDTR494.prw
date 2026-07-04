/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr494.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR494  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio demonstrativo dos custos dos exames por fornecedor³±±
±±³          ³Sera considerado para o relatorio todos os exames do tipo   ³±±
±±³          ³ocupacional realizados no periodo solicitado. O Programa    ³±±
±±³          ³le a tabela de Exames do Funcionario (TM5), e para cada exa-³±±
±±³          ³realizado, o programa busca o valor na tabela precos (TMD), ³±±
±±³          ³com base no fornecedor e na data de realizacao do exame.    ³±±
±±³          ³O relatorio saira classificado por fornecedor  e por        ³±±
±±³          ³exame, acumulando os valores por exame.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR494(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR494()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM( )

Local oReport
Local aArea := GetArea()

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

Private cPerg    :="MDT494    "
Private lRelPer  := .T.
Private oTempTable
Private aExames := {}

cAliasCC := "SI3"
cF3CC    := "SI3001"  //SI3 apenas do cliente
cCodCC2  := "I3_CUSTO"
cDescCC2 := "SI3->I3_DESC"
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cF3CC    := "CTT001"  //CTT apenas do cliente
	cCodCC2  := "CTT_CUSTO"
	cDescCC2 := "CTT->CTT_DESC01"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
Endif

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/* Perguntas
+----------------------------+
| 01  De  Fornecedor ?       |
| 02  Ate Fornecedor ?       |
| 03  De  Exame ?            |
| 04  Ate Exame ?            |
| 05  De  Data Resultado ?   |
| 06  Ate Data Resultado ?   |
| 07  De Centro Custo ?      |
| 08  Ate Centro Custo ?     |
| 09  Imprimir relat¾rio: ?  |
+----------------------------+
*/

If TRepInUse()
   //-- Interface de impressao
   oReport := ReportDef()
   oReport:SetPortrait()
   oReport:PrintDialog()
Else
   lRelPer := .F.
   U_MDTR494R3()
EndIf
RestArea(aArea)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Heverson Vitoreti     ³ Data ³ 18/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Define as secoes impressas no relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SGAR050                                                    ³±±
±±|__________|____________________________________________________________|±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
Static Function ReportDef()

Static oReport
Static oSection0
Static oSection1
Static oSection2
Static oSection3
Static oBreak1, oBreak2
Static oCell

oReport := TReport():New("MDTR494",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint(oReport)},AllTrim(STR0001)+". "+AllTrim(STR0002)+" "+STR0003)

Pergunte(oReport:uParam,.F.)

U_MDT494SEC()

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR494R3³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio demonstrativo dos custos dos exames por fornecedor³±±
±±³          ³Sera considerado para o relatorio todos os exames do tipo   ³±±
±±³          ³ocupacional realizados no periodo solicitado. O Programa    ³±±
±±³          ³le a tabela de Exames do Funcionario (TM5), e para cada exa-³±±
±±³          ³realizado, o programa busca o valor na tabela precos (TMD), ³±±
±±³          ³com base no fornecedor e na data de realizacao do exame.    ³±±
±±³          ³O relatorio saira classificado por fornecedor  e por        ³±±
±±³          ³exame, acumulando os valores por exame.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR494(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR494R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR494"
LOCAL cDesc1  := STR0001  //"Relatorio de Custos de Exames por Fornecedor              "
LOCAL cDesc2  := STR0002 //"Atraves dos parametros o usuario podera selecionar o fornecedor,"
LOCAL cDesc3  := STR0003 //"ou o exame, e obterar os custos dos exames realizados no periodo."
LOCAL cString := "TM5"

PRIVATE nomeprog := "MDTR494"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Custos dos Exames por Fornecedor"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2
PRIVATE nValforn := 0.00
PRIVATE lContinua := .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(AllTrim(cPerg),.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De  Fornecedor                       ³
//³ mv_par02             // Ate Fornecedor                       ³
//³ mv_par03             // De Exame                             ³
//³ mv_par04             // Ate Exame                            ³
//³ mv_par05             // De Dt. Realizacao                    ³
//³ mv_par06             // Ate Dt. Realizacao                   ³
//³ mv_par07             // De C.C                               ³
//³ mv_par08             // Ate C.C                              ³
//³ mv_par09             // Imprimir relatorio:                  ³
//³                           Sintetico                          ³
//³                           Analitico                          ³
//³ mv_par10             // De Filial                            ³
//³ mv_par11             // Ate Filial                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR494"
wnrel:=SetPrint(cString,wnrel,AllTrim(cPerg),titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey = 27
   Set Filter To
   Return
Endif

SetDefault(aReturn,cString)
If lSigaMdtps
	if mv_par13 == 1  //sintetico
		tamanho  := "M"
	endif
Else
	if mv_par09 == 1  //sintetico
		tamanho  := "M"
	endif
Endif

RptStatus({|lEnd| U_R494Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R494Imp  ³ Autor ³                       ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR494                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R494Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
LOCAL nX := 0
LOCAL nFORNEC := 0.00
LOCAL nTOTAL  := 0.00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lSigaMdtps
	If mv_par13 == 1	//Sintetico
		cabec1 := STR0007 //"Codigo  Loja  Nome do Fornecedor"
		cabec2 := STR0008 //"  Exame       Nome do Exame                          Quantidade            Custo"
	Else  //Analitico
		cabec1 := STR0014 //Codigo               Loja  Nome do Fornecedor"
		cabec2 := STR0015 //"         Matrícula   F. Medica    Nome                                      Centro de Custo       Realizacao"
	Endif
Else
	If mv_par09 == 1	//Sintetico
		cabec1 := STR0007 //"Codigo  Loja  Nome do Fornecedor"
		cabec2 := STR0008 //"  Exame       Nome do Exame                          Quantidade            Custo"
	Else  //Analitico
		cabec1 := STR0014 //Codigo               Loja  Nome do Fornecedor"
		cabec2 := STR0015 //"         Matrícula   F. Medica    Nome                                      Centro de Custo       Realizacao"
	Endif
Endif

//************ Relatorio SINTETICO
/*
		  1         2         3         4         5         6         7         8
012345678901234567890123456789012345678901234567890123456789012345678901234567890
----------------------------------------------------------------------------------
Codigo                Loja     Nome do Fornecedor
  Exame  Nome do Exame                               Quantidade            Custo
---------------------------------------------------------------------------------
123456          12    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  123456 1234567890123456789012345678901234567890  9,999,999.99     9,999,999.99
  123456 1234567890123456789012345678901234567890  9,999,999.99     9,999,999.99
  123456 1234567890123456789012345678901234567890  9,999,999.99     9,999,999.99
                                                                   -------------
                                             Total do Fornecedor   99.999.999,99
123456          12    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  123456 1234567890123456789012345678901234567890  9,999,999.99     9,999,999.99
  123456 1234567890123456789012345678901234567890  9,999,999.99     9,999,999.99
  123456 1234567890123456789012345678901234567890  9,999,999.99     9,999,999.99
                                                                   -------------
                                             Total do Fornecedor   99.999.999,99

                                                                   -------------
                                                    Total Geral:  999.999.999,99
*/

//************ Relatorio ANALITICO
/*
          1         2         3         4         5         6         7         8         9        10        11        12        13
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
------------------------------------------------------------------------------------------------------------------------------------
Codigo      Loja     Nome do Fornecedor
         Matrícula   Ficha Med.   Nome                                      Centro de Custo       Realizacao
------------------------------------------------------------------------------------------------------------------------------------

123456      12       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
     Exame: 123456        Nome do Exame: 1234567890123456789012345678901234567890
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
  				                                             Quantidade do Exame: 9,999,999    Custo do Exame: 9,999,999.99
     Exame: 123456        Nome do Exame: 1234567890123456789012345678901234567890
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
  				                                             Quantidade do Exame: 9,999,999    Custo do Exame: 9,999,999.99
																					      Total do Fornecedor: 9,999,999.99

123456      12       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
     Exame: 123456        Nome do Exame: 1234567890123456789012345678901234567890
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
	     123456      123456789    1234567890123456789012345678901234567890  12345678901234567890  xx/xx/xxxx
  				                                             Quantidade do Exame: 9,999,999    Custo do Exame: 9,999,999.99
											                                              Total do Fornecedor: 9,999,999.99

																							      Total Geral: 9,999,999.99
*/

Processa({|lEND| MDTR494TM5(@lEnd)},STR0023)  //"Processando Arquivo..."

nTotal := 0.00

dbSelectArea("TRB")
dbGotop()
If RecCount()==0
	MsgInfo(STR0059) //"Não há nada para imprimir no relatório."
	oTempTable:Delete()
	RetIndex("TM5")
	Set Filter To
	Set device to Screen
	Return .F.
Endif

If lSigaMdtps

	if mv_par13 == 1  //sintetico

		dbSelectArea("TRB")
		dbGotop()
		ProcRegua(LastRec())
		While !Eof()

			nTotal := 0
			cCliente := TRB->CLIENT+TRB->LOJACL
			Somalinha()
			@Li,000 PSAY STR0060 + AllTrim(TRB->CLIENT) + "-" + AllTrim(TRB->LOJACL) + " - " + NGSEEK("SA1",cCliente,1,"A1_NOME")   //"Cliente/Loja: "

			While !Eof() .and. cCliente = TRB->CLIENT+TRB->LOJACL

				cFornec  := TRB->FORNEC
				cLoja    := TRB->LOJA

				If Empty(cFornec+cLOJA)
					SomaLinha()
					Somalinha()
					@ Li,000 Psay "-"
					@ Li,016 Psay "-"
					@ Li,022 Psay "-"
				Else
					dbSelectArea("SA2")
					dbSetOrder(01)
					If !dbSeek(xFilial("SA2")+cFornec+cLOJA)
						dbSelectArea("SA2")
						dbSetOrder(01)
						dbSeek(xFilial("SA2")+cFornec)
					EndIf
					SomaLinha()
					Somalinha()
					@ Li,000 Psay cFornec Picture "@!"
					@ Li,022 Psay cLOJA   Picture "@!"
					@ Li,028 Psay SA2->A2_NOME Picture "@!"
				Endif

				nFORNEC := 0.00
				dbSelectArea("TRB")
				While !Eof()  .AND. TRB->FORNEC == cFornec .and. TRB->LOJA == cLOJA .and. cCliente = TRB->CLIENT+TRB->LOJACL

					IncProc()
					SomaLinha()
					@ Li,002 PSay TRB->EXAME
					dbSelectArea("TM4")
					dbSetOrder(01)
					dbSeek(xFilial("TM4")+TRB->EXAME)
					@ Li,014 PSay Substr(TM4->TM4_NOMEXA,1,35)
					@ Li,078 PSay TRB->QTDE   Picture "999,999"
					@ Li,090 PSay TRB->VALOR  Picture "@E 9,999,999.99"

					nFORNEC := nFORNEC + TRB->VALOR
					dbSelectArea("TRB")
					dbSkip()

				EndDo
				nTotal := nTotal + nFornec
				SomaLinha()
				@ Li,089 PSay "-------------"
				SomaLinha()
				@ Li,067 PSay STR0010 //"Total do Fornecedor"
				@ Li,090 PSay nFORNEC  Picture "@E 9,999,999.99"

			End
			SomaLinha()
			SomaLinha()
			@ Li,089 PSay "-------------"
			SomaLinha()
			@ Li,070 PSay STR0061 //"Total do Cliente:"
			@ Li,090 PSay nTotal  Picture "@E 9,999,999.99"
			If !Eof()
				Somalinha()
				@ Li,000 PSAY __PrtThinLine()
			Endif

		End

	else  //analitico

		aSort( aExames ,,, { |x,y| x[1]+x[2]+x[3]+x[4]+x[5] < y[1]+y[2]+y[3]+y[4]+y[5] }   )
		cCliente := ""
		lFirst := .t.

		for nX := 1 to Len(aExames)

	    	If cCliente <> aExames[nX][1]+aExames[nX][2]
				if !lFirst
					SomaLinha()
					@ Li,080 PSay STR0010+":" //"Total do Fornecedor:"
					@ Li,101 PSay nFORNEC Picture "@E 9,999,999.99"
					SomaLinha()
					SomaLinha()
					@ Li,83 PSay STR0061 //"Total do Cliente:"
					@ Li,101 PSay nTOTAL Picture "@E 9,999,999.99"
				endif
				lFirst := .T.
				nTotal := 0
				cFornec := ""
	    		cCliente := aExames[nX][1]+aExames[nX][2]
				Somalinha()
				If nX > 1
					@ Li,000 PSAY __PrtThinLine()
					Somalinha()
				Endif
				@Li,000 PSAY STR0060 + AllTrim(aExames[nX][1]) + "-" + AllTrim(aExames[nX][2]) + " - " + NGSEEK("SA1",cCliente,1,"A1_NOME") //"Cliente/Loja: "
				SomaLinha()
				SomaLinha()
	    	Endif

	    	if cFornec != aExames[nX][3]+aExames[nX][4]
				if !lFirst
					SomaLinha()
  					@ Li,000 PSAY __PrtThinLine()
	 				SomaLinha()
					@ Li,080 PSay STR0010+":" //"Total do Fornecedor:"
					@ Li,101 PSay nFORNEC Picture "@E 9,999,999.99"
					SomaLinha()
					Somalinha()
				endif
				lFirst := .F.

				If Empty(aExames[nX][3]+aExames[nX][4])
					@ Li,000 Psay "-"    //Fornecedor
					@ Li,012 Psay "-"    //Loja
					@ Li,021 Psay "-"
				Else
				 	dbSelectArea("SA2")
					dbSetOrder(01)
					If !dbSeek(xFilial("SA2")+aExames[nX][3]+aExames[nX][4])
						dbSeek(xFilial("SA2")+aExames[nX][3])
					EndIf
					@ Li,000 Psay aExames[nX][3] Picture "@!"    //Fornecedor
					@ Li,021 Psay aExames[nX][4] Picture "@!"    //Loja
					@ Li,028 Psay SA2->A2_NOME Picture "@!"
				Endif
				Somalinha()
				cFornec := aExames[nX][3] + aExames[nX][4]
				nFORNEC := 0
			endif

	    	@ Li,005 PSay STR0018 + aExames[nX][5] //"Exame: "
			dbSelectArea("TM4")
			dbSetOrder(01)
			dbSeek(xFilial("TM4")+aExames[nX][5])
			@ Li,026 PSay STR0019 + Substr(TM4->TM4_NOMEXA,1,40)  //"Nome do Exame: "

		    dbselectarea("TRB")
			dbseek(aExames[nX][1]+aExames[nx][2]+aExames[nX][3]+aExames[nX][4]+aExames[nX][5])    //Imprime as informacoes dos funcionarios
		    While !Eof() 			    		  .AND.;
		    	  aExames[nx][1]+aExames[nx][2] == TRB->CLIENT+TRB->LOJACL .AND.;
		    	  aExames[nX][3] == TRB->FORNEC   .AND.;
		    	  aExames[nX][4] == TRB->LOJA     .AND.;
		    	  aExames[nX][5] == TRB->EXAME

				IncProc()
				SomaLinha()

				@ Li,009 PSay TRB->MAT
				@ Li,021 PSay TRB->FICHA
				@ Li,034 PSay TRB->NOME
				@ Li,076 PSay TRB->CCNAME
				@ Li,098 PSay DtoC(TRB->DTEXAME)

				dbSelectArea("TRB")
				dbSkip()
			EndDo

			nFORNEC += aExames[nX][7]
			nTOTAL  += aExames[nX][7]
			SomaLinha()
			@ Li,061 PSay STR0020  //"Quantidade do Exame:"
			@ Li,082 PSay Alltrim(STR(aExames[nX][6]))
			@ Li,085 PSay STR0021  //"Custo do Exame:"
			@ Li,101 PSay aExames[nX][7] Picture "@E 9,999,999.99"
			SomaLinha()

		Next nX

		SomaLinha()
		@ Li,080 PSay STR0010+":" //"Total do Fornecedor:"
		@ Li,101 PSay nFORNEC Picture "@E 9,999,999.99"
		SomaLinha()
		SomaLinha()
		@ Li,83 PSay STR0061 //"Total do Cliente:"
		@ Li,101 PSay nTOTAL Picture "@E 9,999,999.99"

	endif

Else

	if mv_par09 == 1  //sintetico

		dbSelectArea("TRB")
		dbGotop()
		ProcRegua(LastRec())
		While !Eof()

			cFornec  := TRB->FORNEC
			cLoja    := TRB->LOJA

			If Empty(cFornec+cLOJA)
				SomaLinha()
				Somalinha()
				@ Li,000 Psay "-"
				@ Li,016 Psay "-"
				@ Li,022 Psay "-"
			Else
				dbSelectArea("SA2")
				dbSetOrder(01)
				If !dbSeek(xFilial("SA2")+cFornec+cLOJA)
					dbSelectArea("SA2")
					dbSetOrder(01)
					dbSeek(xFilial("SA2")+cFornec)
				EndIf
				SomaLinha()
				Somalinha()
				@ Li,000 Psay cFornec Picture "@!"
				@ Li,022 Psay cLOJA   Picture "@!"
				@ Li,028 Psay SA2->A2_NOME Picture "@!"
			Endif

			nFORNEC := 0.00
			dbSelectArea("TRB")
			While !Eof()  .AND. TRB->FORNEC == cFornec .and. TRB->LOJA == cLOJA

				IncProc()
				SomaLinha()
				@ Li,002 PSay TRB->EXAME
				dbSelectArea("TM4")
				dbSetOrder(01)
				dbSeek(xFilial("TM4")+TRB->EXAME)
				@ Li,014 PSay Substr(TM4->TM4_NOMEXA,1,35)
				@ Li,078 PSay TRB->QTDE   Picture "999,999"
				@ Li,090 PSay TRB->VALOR  Picture "@E 9,999,999.99"

				nFORNEC := nFORNEC + TRB->VALOR
				dbSelectArea("TRB")
				dbSkip()

			EndDo
			nTotal := nTotal + nFornec
			SomaLinha()
			@ Li,089 PSay "-------------"
			SomaLinha()
			@ Li,067 PSay STR0010 //"Total do Fornecedor"
			@ Li,090 PSay nFORNEC  Picture "@E 9,999,999.99"

		EndDo
		SomaLinha()
		SomaLinha()
		@ Li,089 PSay "-------------"
		SomaLinha()
		@ Li,067 PSay STR0022 //"Total Geral:"
		@ Li,090 PSay nTotal  Picture "@E 9,999,999.99"

	else  //analitico

		aSort( aExames ,,, { |x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3] }   )
		lFirst := .T.
		cFornec := ""
		SomaLinha()

		for nX := 1 to Len(aExames)

	    	if cFornec != aExames[nX][1]+aExames[nX][2]
				if !lFirst
					SomaLinha()
					@ Li,000 PSAY __PrtThinLine()
					SomaLinha()
					@ Li,080 PSay STR0010+":" //"Total do Fornecedor:"
					@ Li,103 PSay nFORNEC Picture "@E 9,999,999.99"
					SomaLinha()
					Somalinha()
				endif
				lFirst := .F.

			 	If Empty(aExames[nX][1]+aExames[nX][2])
					@ Li,000 Psay "-"
					@ Li,012 Psay "-"
					@ Li,021 Psay "-"
			 	Else
				 	dbSelectArea("SA2")
					dbSetOrder(01)
					If !dbSeek(xFilial("SA2")+aExames[nX][1]+aExames[nX][2])
						dbSeek(xFilial("SA2")+aExames[nX][1])
					EndIf
					@ Li,000 Psay aExames[nX][1] Picture "@!"    //Fornecedor
					@ Li,021 Psay aExames[nX][2] Picture "@!"    //Loja
					@ Li,027 Psay SA2->A2_NOME Picture "@!"
				Endif
				Somalinha()
				cFornec := aExames[nX][1] + aExames[nX][2]
				nFORNEC := 0
			endif

	    	@ Li,005 PSay STR0018 + aExames[nX][3] //"Exame: "
			dbSelectArea("TM4")
			dbSetOrder(01)
			dbSeek(xFilial("TM4")+aExames[nX][3])
			@ Li,026 PSay STR0019 + Substr(TM4->TM4_NOMEXA,1,40)  //"Nome do Exame: "

		    dbselectarea("TRB")
			dbseek(aExames[nX][1]+aExames[nX][2]+aExames[nX][3])    //Imprime as informacoes dos funcionarios
		    While !Eof() 			    		  .AND.;
		    	  aExames[nX][1] == TRB->FORNEC  .AND.;
		    	  aExames[nX][2] == TRB->LOJA    .AND.;
		    	  aExames[nX][3] == TRB->EXAME

				IncProc()
				SomaLinha()

				@ Li,009 PSay TRB->MAT
				@ Li,021 PSay TRB->FICHA
				@ Li,034 PSay TRB->NOME
				@ Li,076 PSay TRB->CCNAME
				@ Li,098 PSay DtoC(TRB->DTEXAME)

				dbSelectArea("TRB")
				dbSkip()
			EndDo

			nFORNEC += aExames[nX][5]
			nTOTAL  += aExames[nX][5]
			SomaLinha()
			@ Li,056 PSay STR0020  //"Quantidade do Exame:"
			@ Li,077 PSay Alltrim(STR(aExames[nX][4]))
			@ Li,085 PSay STR0021  //"Custo do Exame:"
			@ Li,103 PSay aExames[nX][5] Picture "@E 9,999,999.99"
			SomaLinha()

		Next nX

		SomaLinha()
		@ Li,000 PSAY __PrtThinLine()
		SomaLinha()
		@ Li,080 PSay STR0010+":" //"Total do Fornecedor:"
		@ Li,103 PSay nFORNEC Picture "@E 9,999,999.99"
		SomaLinha()
		SomaLinha()
		@ Li,88 PSay STR0022  //"Total Geral:"
		@ Li,103 PSay nTOTAL Picture "@E 9,999,999.99"

	endif

Endif

Roda(nCntImpr,cRodaTxt,Tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TM5")
Set Filter To
Set device to Screen
If aReturn[5] = 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
Endif
MS_FLUSH()

oTempTable:Delete()

Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ReportPrint³ Autor ³ Rafael Diogo Richter  ³ Data ³ 18/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)

Local oSection0
Local oSection1
Local oSection2
Local oSection3
Local nX
Local cFornec, cLoja, cExa


Processa({|lEND| MDTR494TM5(@lEnd)},STR0023)  //"Processando Arquivo..."

dbSelectArea("TRB")
dbGotop()
If RecCount()==0
	MsgInfo(STR0059) //"Não há nada para imprimir no relatório."
	oTempTable:Delete()
	RetIndex("TM5")
	Set Filter To
	Set device to Screen
	Return .F.
Endif

nTotal := 0.00

If lSigaMdtps

	if mv_par13 == 1  //sintetico

		oSection0 := oReport:Section(1)
		oSection1 := oReport:Section(2)
		oSection2 := oReport:Section(3)

		dbSelectArea("TRB")
		dbGotop()
		oReport:SetMeter(RecCount())
		While !Eof()
			oReport:IncMeter()

			cCliente := TRB->CLIENT+TRB->LOJACL
			oSection0:Init()
			oSection0:PrintLine()

			While !Eof() .and. cCliente = TRB->CLIENT+TRB->LOJACL

				cFornec  := TRB->FORNEC
				cLoja    := TRB->LOJA

				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()

				nFORNEC := 0.00
				dbSelectArea("TRB")
				While !Eof() .AND. TRB->FORNEC == cFornec .and. TRB->LOJA == cLOJA .and. cCliente = TRB->CLIENT+TRB->LOJACL

					oSection2:PrintLine()

					dbSelectArea("TRB")
					dbSkip()
				EndDo
				oSection2:Finish()
				oSection1:Finish()

			End
			oSection0:Finish()

		End
	else  //analitico
		lFirst := .T.
		cFornec := ""

		oSection0 := oReport:Section(1)
		oSection1 := oReport:Section(2)
		oSection2 := oReport:Section(3)
		oSection3 := oReport:Section(4)

		dbSelectArea("TRB")
		dbGotop()
		oReport:SetMeter(RecCount())
		While !Eof() .And. !oReport:Cancel()

			oReport:IncMeter()

			cCliente := TRB->CLIENT+TRB->LOJACL
			oSection0:Init()
			oSection0:PrintLine()
			lPrim := .T.
			While !Eof() .And. !oReport:Cancel() .and. cCliente = TRB->CLIENT+TRB->LOJACL

				If TRB->FORNEC == cFornec .and. TRB->LOJA == cLoja .And. !lPrim
					dbSelectArea("TRB")
					DbSkip()
					Loop
				EndIf

				cFornec  := TRB->FORNEC
				cLoja    := TRB->LOJA

				oSection1:Init()
				oSection1:PrintLine()

				cExame := ""

				aArea1 := GetArea()
				dbSelectArea("TRB")
				DbSeek(cCliente+cFornec+cLOJA)
				While !Eof()  .AND. TRB->FORNEC == cFornec .And. TRB->LOJA == cLOJA .And. !oReport:Cancel() .and. cCliente = TRB->CLIENT+TRB->LOJACL
					If TRB->FORNEC == cFornec .And. TRB->LOJA == cLoja .And. TRB->EXAME == cExame
						DbSkip()
						Loop
					EndIf
					oReport:IncMeter()

					cExame := TRB->EXAME

					oSection2:Init()
					oSection2:PrintLine()
					oSection3:Init()

					aArea2 := GetArea()
					dbSelectArea("TRB")
					DbSeek(cCliente+cFornec+cLOJA+cExame)
					While !Eof() .And. TRB->FORNEC == cFornec .And. TRB->LOJA == cLOJA .And. TRB->EXAME == cExame .And. !oReport:Cancel() .and. cCliente = TRB->CLIENT+TRB->LOJACL

						oSection3:PrintLine()

						dbSelectArea("TRB")
						dbSkip()
					End
					RestArea(aArea2)
					oSection2:Finish()
					oReport:SkipLine()
					oSection3:Finish()
					dbSelectArea("TRB")
					dbSkip()
				End
				RestArea(aArea1)
				oSection1:Finish()
				lPrim := .F.
			End
			oSection0:Finish()

			//dbSelectArea("TRB")
			//dbSkip()
		End
	EndIf

Else

	oSection1 := oReport:Section(1)
	oSection2 := oReport:Section(2)
	oSection3 := oReport:Section(3)

	if mv_par09 == 1  //sintetico

		dbSelectArea("TRB")
		dbGotop()
		oReport:SetMeter(RecCount())
		While !Eof()
			oReport:IncMeter()

			cFornec  := TRB->FORNEC
			cLoja    := TRB->LOJA

			oSection1:Init()
			oSection1:PrintLine()
			oSection2:Init()

			nFORNEC := 0.00
			dbSelectArea("TRB")
			While !Eof()  .AND. TRB->FORNEC == cFornec .and. TRB->LOJA == cLOJA

				oSection2:PrintLine()

				dbSelectArea("TRB")
				dbSkip()
			EndDo
			oSection1:Finish()
			oSection2:Finish()
		EndDo
	else  //analitico
		lFirst := .T.
		cFornec := ""

		dbSelectArea("TRB")
		dbGotop()
		oReport:SetMeter(RecCount())
		While !Eof() .And. !oReport:Cancel()

			oReport:IncMeter()

	      If TRB->FORNEC == cFornec .and. TRB->LOJA == cLoja
	      	dbSelectArea("TRB")
	      	DbSkip()
	      	Loop
	      EndIf

			cFornec  := TRB->FORNEC
			cLoja    := TRB->LOJA

			oSection1:Init()
			oSection1:PrintLine()

			cExame := ""

			aArea1 := GetArea()
			dbSelectArea("TRB")
			DbSeek(cFornec+cLOJA)
			While !Eof()  .AND. TRB->FORNEC == cFornec .And. TRB->LOJA == cLOJA .And. !oReport:Cancel()
				If TRB->FORNEC == cFornec .And. TRB->LOJA == cLoja .And. TRB->EXAME == cExame
					DbSkip()
					Loop
				EndIf
				oReport:IncMeter()

				cExame := TRB->EXAME

				oSection2:Init()
				oSection2:PrintLine()
				oSection3:Init()

				aArea2 := GetArea()
				dbSelectArea("TRB")
				DbSeek(cFornec+cLOJA+cExame)
				While !Eof() .And. TRB->FORNEC == cFornec .And. TRB->LOJA == cLOJA .And. TRB->EXAME == cExame .And. !oReport:Cancel()

					oSection3:PrintLine()

					dbSelectArea("TRB")
					dbSkip()
				End
				RestArea(aArea2)
				oSection2:Finish()
				oReport:SkipLine()
				oSection3:Finish()
				dbSelectArea("TRB")
				dbSkip()
			End
			RestArea(aArea1)
			oSection1:Finish()

			dbSelectArea("TRB")
			dbSkip()
		End
	EndIf

Endif

oTempTable:Delete()

Return .T.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTR494TM5³ Autor ³ Rafael Diogo Richter  ³ Data ³08/08/2006³±±
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
Static Function MDTR494TM5(lEnd)
LOCAL lContinua      := .T.
Local nXYZ,aFilRelat := {}
Local nSizeSA2 := If((TAMSX3("A2_COD")[1]) < 1,6,(TAMSX3("A2_COD")[1]))
Local nSizeLo2 := If((TAMSX3("A2_LOJA")[1]) < 1,6,(TAMSX3("A2_LOJA")[1]))
Local nLenFila := If((TAMSX3("TM0_FILIAL")[1]) < 1,2,(TAMSX3("TM0_FILIAL")[1]))
Local nTamExa	:= If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])

aDBF := {}

If lSigaMdtps

	if mv_par13 == 1	//Sintetico

		AADD(aDBF,{"CLIENT","C",nTa1,0})
		AADD(aDBF,{"LOJACL","C",nTa1L,0})
		AADD(aDBF,{"FORNEC","C",nSizeSA2,0})
		AADD(aDBF,{"LOJA"  ,"C",nSizeLo2,0})
		AADD(aDBF,{"EXAME" ,"C",nTamExa,0})
		AADD(aDBF,{"QTDE"  ,"N",06,0})
		AADD(aDBF,{"VALOR" ,"N",10,2})
		AADD(aDBF,{"NOMEF" ,"C",40,0})

	else	//Analitico

		AADD(aDBF,{"CLIENT" ,"C",nTa1,0})
		AADD(aDBF,{"LOJACL" ,"C",nTa1L,0})
		AADD(aDBF,{"FORNEC" ,"C",nSizeSA2,0})
		AADD(aDBF,{"LOJA"   ,"C",nSizeLo2,0})
		AADD(aDBF,{"EXAME"  ,"C",nTamExa ,0})
		AADD(aDBF,{"MAT"    ,"C",06 ,0})
		AADD(aDBF,{"FICHA"  ,"C",09 ,0})
		AADD(aDBF,{"NOME"   ,"C",40 ,0})
		AADD(aDBF,{"CC"     ,"C",nSizeSI3,0})
		AADD(aDBF,{"CCNAME" ,"C",20 ,0})
		AADD(aDBF,{"DTEXAME","D",08 ,0})
		AADD(aDBF,{"VALOR"	,"N",12 ,2})
		AADD(aDBF,{"FILFUN" ,"C",nLenFila,0})
		AADD(aDBF,{"NOMEF" ,"C",40,0})
	endif

	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
	if mv_par13 == 1	//sintetico
		oTempTable:AddIndex( "1", {"CLIENT","LOJACL","FORNEC","LOJA","EXAME"} )
	else //analitico
		oTempTable:AddIndex( "1", {"CLIENT","LOJACL","FORNEC","LOJA","EXAME","FICHA"} )
	endif
	oTempTable:Create()

	dbSelectArea("TM5")
	dbSetOrder(02)
	dbSeek(xFilial("TM5")+MV_PAR07,.T.)
	ProcRegua(LastRec())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  Exames                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While lContinua                         	.AND.;
	      !Eof()                             	.AND.;
	      TM5->TM5_FILIAL == xFIlial('TM5')  	.AND.;
	      TM5->TM5_EXAME <=  MV_PAR08

		IncProc()
		dbSelectArea("TM0")
		dbSetOrder(1)
		dbSeek(xFilial("TM0")+TM5->TM5_NUMFIC)
		cCliente := TM0->TM0_CLIENT+TM0_LOJA
		If cCliente < mv_par01+mv_par02 .or. cCliente > mv_par03+mv_par04
			dbSelectArea("TM5")
			dbSkip()
			Loop
		Endif
		IF TM5->TM5_FORNEC < MV_PAR05 .OR. TM5->TM5_FORNEC > MV_PAR06 .OR. Empty(TM5->TM5_FORNEC)
			DbSelectArea("TM5")
			DbSkip()
			Loop
		EndIf
		IF TM5->TM5_DTRESU < MV_PAR09 .OR. TM5->TM5_DTRESU > MV_PAR10
			DbSelectArea("TM5")
			DbSkip()
			Loop
		EndIf

		dbSelectArea(cAliasCC)
		dbSetOrder(01)
		DbSeek(xFilial(cAliasCC)+cCliente)

		IF TM5->TM5_CC < MV_PAR11 .OR. TM5->TM5_CC > MV_PAR12
			DbSelectArea("TM5")
			DbSkip()
			Loop
		EndIf

		IF EMPTY(TM5->TM5_DTRESU)
			dbskip()
			Loop
		Endif

		nValforn := 0.00

		dbSelectArea("TMD")
		dbSetOrder(01)
		dbSeek(xFilial("TMD")+TM5->TM5_FORNEC+TM5->TM5_LOJA+TM5->TM5_EXAME)

		While !Eof() 							  .AND.;
			  TMD->TMD_FILIAL == xFilial('TMD')   .AND.;
			  TMD->TMD_FORNEC == TM5->TM5_FORNEC  .AND.;
			  TMD->TMD_LOJA == TM5->TM5_LOJA 	  .AND.;
			  TMD->TMD_EXAME == TM5->TM5_EXAME

			If TMD->TMD_DTINIC <= TM5->TM5_DTRESU
				nValforn := TMD->TMD_VALEXA
			Else
				Exit
			Endif

			dbSelectArea("TMD")
			dbSkip()
		End

		dbSelectArea("TRB")

		if mv_par13 == 1 //Sintetico

			IF !dbseek(cCliente+TM5->TM5_FORNEC+TM5->TM5_LOJA+TM5->TM5_EXAME)
				TRB->(DbAppend())
				TRB->CLIENT := SubStr(cCliente,1,nTa1)
				TRB->LOJACL := SubStr(cCliente,nTa1+1,nSizeTD)
				dbSelectArea("SA2")
				dbSetOrder(01)
				If !dbSeek(xFilial("SA2")+TM5->TM5_FORNEC+TM5->TM5_LOJA)
					dbSelectArea("SA2")
					dbSetOrder(01)
					dbSeek(xFilial("SA2")+TM5->TM5_FORNEC)
				EndIf
			  	TRB->FORNEC := SA2->A2_COD//TM5->TM5_FORNEC
			  	TRB->NOMEF  := SA2->A2_NOME
			  	TRB->LOJA   := TM5->TM5_LOJA
				TRB->EXAME  := TM5->TM5_EXAME
			EndIf
			TRB->QTDE  := TRB->QTDE + 1
			TRB->VALOR := TRB->VALOR + nValforn

		else	//Analitico

			RecLock("TRB",.t.)
			TRB->CLIENT := SubStr(cCliente,1,nTa1)
			TRB->LOJACL := SubStr(cCliente,nTa1+1,nSizeTD)
			dbSelectArea("SA2")
			dbSetOrder(01)
			If !dbSeek(xFilial("SA2")+TM5->TM5_FORNEC+TM5->TM5_LOJA)
				dbSelectArea("SA2")
				dbSetOrder(01)
				dbSeek(xFilial("SA2")+TM5->TM5_FORNEC)
			EndIf
		  	TRB->FORNEC := SA2->A2_COD
		  	TRB->NOMEF  := SA2->A2_NOME
			TRB->LOJA   := TM5->TM5_LOJA
			TRB->EXAME  := TM5->TM5_EXAME
			TRB->MAT    := TM5->TM5_MAT
			TRB->FICHA  := TM5->TM5_NUMFIC
			TRB->NOME   := Ngseek("TM0", TM5->TM5_NUMFIC, 1, "TM0->TM0_NOMFIC" )
			TRB->CC     := TM5->TM5_CC
			TRB->CCNAME := Ngseek(cAliasCC, TM5->TM5_CC, 1, cDescCC2 )
			TRB->DTEXAME:= TM5->TM5_DTRESU
			TRB->VALOR	+= nValforn
			Msunlock("TRB")

			if (nX := aSCAN( aExames,{ |x| x[1]+x[2]+x[3]+x[4]+x[5] == TRB->CLIENT + TRB->LOJACL +  TM5->TM5_FORNEC+TM5->TM5_LOJA+TM5->TM5_EXAME})) == 0
				AADD (aExames, {TRB->CLIENT,TRB->LOJACL,TM5->TM5_FORNEC,TM5->TM5_LOJA,TM5->TM5_EXAME,1,nValforn} )
			else
				aExames[nX][6] ++
				aExames[nX][7] += nValforn
			endif

		endif

		dbSelectArea("TM5")
		dbSKIP()
	End

Else

	If !Empty(xFilial("TM5"))
		aAreaSM0 := SM0->(GetArea())
		dbSelectArea("SM0")
		dbGoTop()
		If Empty(Mv_par10)
			dbSeek(cEmpAnt)
		Else
			dbSeek(cEmpAnt+Mv_par10)
		Endif
		While !Eof() .and. SM0->M0_CODIGO == cEmpAnt .and. SM0->M0_CODFIL <= Mv_par11
			aAdd( aFilRelat , Padr(SM0->M0_CODFIL,Len(TM5->TM5_FILIAL)))
			dbSkip()
		End
		RestArea(aAreaSM0)
	Else
		aAdd( aFilRelat , cFilAnt )
	Endif

	if mv_par09 == 1	//Sintetico

		AADD(aDBF,{"FORNEC","C",nSizeSA2,0})
		AADD(aDBF,{"LOJA"  ,"C",nSizeLo2,0})
		AADD(aDBF,{"EXAME" ,"C",nTamExa,0})
		AADD(aDBF,{"QTDE"  ,"N",06,0})
		AADD(aDBF,{"VALOR" ,"N",10,2})

	else	//Analitico

		AADD(aDBF,{"FORNEC" 	,"C" 	,nSizeSA2,0})
		AADD(aDBF,{"LOJA"   	,"C" 	,nSizeLo2 ,0})
		AADD(aDBF,{"EXAME"  	,"C" 	,nTamExa ,0})
		AADD(aDBF,{"MAT"    	,"C" 	,06 ,0})
		AADD(aDBF,{"FICHA"  	,"C" 	,09 ,0})
		AADD(aDBF,{"NOME"   	,"C" 	,40 ,0})
		AADD(aDBF,{"CC"     	,"C" 	,nSizeSI3,0})
		AADD(aDBF,{"CCNAME" 	,"C" 	,20 ,0})
		AADD(aDBF,{"DTEXAME"	,"D" 	,08 ,0})
		AADD(aDBF,{"VALOR"	    ,"N"	,12 ,2})
		AADD(aDBF,{"FILFUN" 	,"C"	,nLenFila,0})
	endif

	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
	if mv_par09 == 1	//sintetico
		oTempTable:AddIndex( "1", {"FORNEC","LOJA","EXAME"} )
	else //analitico
		oTempTable:AddIndex( "1", {"FORNEC","LOJA","EXAME","FICHA"} )
	endif
	oTempTable:Create()

	For nXYZ := 1 To Len(aFilRelat)
		dbSelectArea("TM5")
		dbSetOrder(02)
		dbSeek(xFilial("TM5",aFilRelat[nXYZ])+MV_PAR03,.T.)
		ProcRegua(LastRec())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Correr TM5 para ler os  Exames                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		While lContinua                         	.AND.;
		      !Eof()                             	.AND.;
		      TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ]) .AND.;
		      TM5->TM5_EXAME <=  MV_PAR04

			IncProc()
			IF TM5->TM5_FORNEC < MV_PAR01 .OR. TM5->TM5_FORNEC > MV_PAR02 .OR. Empty(TM5->TM5_FORNEC)
				DbSelectArea("TM5")
				DbSkip()
				Loop
			EndIf
			IF TM5->TM5_DTRESU < MV_PAR05 .OR. TM5->TM5_DTRESU > MV_PAR06
				DbSelectArea("TM5")
				DbSkip()
				Loop
			EndIf

			cFilTM5 := aFilRelat[nXYZ]
			If !Empty(TM5->TM5_FILFUN)
				cFilTM5 := TM5->TM5_FILFUN
				If TM5->TM5_FILFUN < Mv_par10 .or. TM5->TM5_FILFUN > Mv_par11
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Else
				dbSelectArea("TM0")
				DbSetOrder(1)
				If dbSeek(xFilial("TM0")+TM5->TM5_NUMFIC) .And. !Empty(TM0->TM0_FILFUN)
					If TM0->TM0_FILFUN < Mv_par10 .or. TM0->TM0_FILFUN > Mv_par11
						dbSelectArea("TM5")
						dbskip()
						Loop
					Endif
				EndIf
			Endif

			IF TM5->TM5_CC < MV_PAR07 .OR. TM5->TM5_CC > MV_PAR08
				DbSelectArea("TM5")
				DbSkip()
				Loop
			EndIf

			IF EMPTY(TM5->TM5_DTRESU)
				dbskip()
				Loop
			Endif

			nValforn := 0.00

			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			dbSeek(xFilial(cAliasCC,cFilTM5)+TM5->TM5_CC)

			dbSelectArea("TM0")
			dbSetOrder(01)
			dbSeek(xFilial("TM0",cFilTM5)+TM5->TM5_NUMFIC)

			dbSelectArea("TMD")
			dbSetOrder(01)
			dbSeek(xFilial("TMD",cFilTM5)+TM5->TM5_FORNEC+TM5->TM5_LOJA+TM5->TM5_EXAME)

			While !Eof() 							  .AND.;
				  TMD->TMD_FILIAL == xFilial('TMD',cFilTM5)  .AND.;
				  TMD->TMD_FORNEC == TM5->TM5_FORNEC .AND.;
				  TMD->TMD_LOJA == TM5->TM5_LOJA 	  .AND.;
				  TMD->TMD_EXAME == TM5->TM5_EXAME

				If TMD->TMD_DTINIC <= TM5->TM5_DTRESU
					nValforn := TMD->TMD_VALEXA
				Else
					Exit
				Endif

				dbSelectArea("TMD")
				dbSkip()
			End

			dbSelectArea("TRB")

			if mv_par09 == 1 //Sintetico

				IF !dbseek(TM5->TM5_FORNEC+TM5->TM5_LOJA+TM5->TM5_EXAME)
					TRB->(DbAppend())
					TRB->FORNEC := TM5->TM5_FORNEC
					TRB->LOJA   := TM5->TM5_LOJA
					TRB->EXAME  := TM5->TM5_EXAME
				EndIf
				TRB->QTDE  := TRB->QTDE + 1
				TRB->VALOR := TRB->VALOR + nValforn

			else	//Analitico

				RecLock("TRB",.t.)
				TRB->FILFUN := cFilTM5
				TRB->FORNEC := TM5->TM5_FORNEC
				TRB->LOJA   := TM5->TM5_LOJA
				TRB->EXAME  := TM5->TM5_EXAME
				TRB->MAT    := TM5->TM5_MAT
				TRB->FICHA  := TM5->TM5_NUMFIC
				TRB->NOME   := TM0->TM0_NOMFIC
				TRB->CC     := TM5->TM5_CC
				TRB->CCNAME := &(cDescCC2)
				TRB->DTEXAME:= TM5->TM5_DTRESU
				TRB->VALOR	+= nValforn
				Msunlock("TRB")

				if (nX := aSCAN( aExames,{ |x| x[1]+x[2]+x[3] == TM5->TM5_FORNEC+TM5->TM5_LOJA+TM5->TM5_EXAME})) == 0
					AADD (aExames, {TM5->TM5_FORNEC,TM5->TM5_LOJA,TM5->TM5_EXAME,1,nValforn} )
				else
					aExames[nX][4] ++
					aExames[nX][5] += nValforn
				endif

			endif

			dbSelectArea("TM5")
			dbSKIP()
		End
	Next nXYZ
Endif

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDT494CC  ³ Autor ³ Andre Perez Alvarez   ³ Data ³23/02/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Valida o centro de custo.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMDT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT494CC()

if !atecodigo('CTT',mv_par07,mv_par08,09)
	Return .F.
endif

return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDT494CC  ³ Autor ³ Andre Perez Alvarez   ³ Data ³23/02/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Atualiza as configuracoes de secao de acordo com o parametro³±±
±±³          ³mv_par09 (sintetico/analitico)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMDT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT494SEC()

Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])
Local nSizeLoj := If((TAMSX3("A2_LOJA")[1]) < 1,4,(TAMSX3("A2_LOJA")[1]))

If lSigaMdtps

	If lRelPer

		oReport:Asection := {}  //Apaga as secoes dos parametros anteriores
		oReport:aSection  := {}
		oReport:aFunction := {}

		If mv_par13 == 1  //sintetico
			oReport:SetTotalInLine(.F.)

			oSection0 := TRSection():New(oReport,STR0062,{"TRB","SA1"}) //"Cliente"
			TRCell():New(oSection0,"TRB->CLIENT","TRB",STR0062,"@!",nTa1) //"Cliente"
			TRCell():New(oSection0,"TRB->LOJACL","TRB",STR0043	,"@!",nTa1L) //"Loja"
			TRCell():New(oSection0,"A1_NOME"	,"SA1",STR0034   ,"@!",40) //"Nome"
			TRPosition():New(oSection0,"SA1",1,{|| xFilial("SA1")+TRB->CLIENT+TRB->LOJACL})

			oSection1 := TRSection():New(oReport,STR0024,{"TRB","SA2"})  //"Fornecedor"
			oCell := TRCell():New(oSection1,"TRB->FORNEC","TRB",STR0025,"@!", nTa1)  //"Código"
			oCell := TRCell():New(oSection1,"TRB->LOJA"  ,"TRB",STR0026,"@!", nTa1L)  //"Loja"
			oCell := TRCell():New(oSection1,"TRB->NOMEF"	 ,"TRB",STR0027,"@!",40)  //"Nome do Fornecedor"
			TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+TRB->FORNEC+TRB->LOJA})

			oSection2 := TRSection():New(oReport,STR0028,{"TRB"})  //"Exame"
			oCell2 := TRCell():New(oSection2,"TRB->EXAME","TRB",STR0028  ,"@!"              ,nTamExa,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Exame"
			oCell2 := TRCell():New(oSection2,"TM4_NOMEXA","TM4",STR0029  ,"@!"              ,40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Nome do Exame"
			oCell2 := TRCell():New(oSection2,"TRB->QTDE" ,"TRB",STR0030  ,"@E 999,999"      ,07,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Quantidade"
			oCell2 := TRCell():New(oSection2,"TRB->VALOR","TRB",STR0031  ,"@E 9,999,999.99" ,12,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Custo"
			oSection2:Cell("TRB->QTDE"):SetHeaderAlign("RIGHT")
			oSection2:Cell("TRB->VALOR"):SetHeaderAlign("RIGHT")
			TRPosition():New(oSection2,"TM4",1,{|| xFilial("TM4")+TRB->EXAME})

			oBreak1 := TRBreak():New(oSection1,".T.",STR0010,.F.)  //"Total do Fornecedor"
			TRFunction():New(oSection2:Cell("TRB->VALOR"),/*cId*/,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotaliz1 := TRFunction():New(oSection2:Cell("TRB->VALOR"),"TOTVAL","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
		Else
			oReport:SetTotalInLine(.T.)

			oSection0 := TRSection():New(oReport,STR0062,{"TRB","SA1"}) //"Cliente"
			TRCell():New(oSection0,"TRB->CLIENT","TRB",STR0062,"@!",nTa1) //"Cliente"
			TRCell():New(oSection0,"TRB->LOJACL"  ,"TRB",STR0043	,"@!",nTa1L) //"Loja"
			TRCell():New(oSection0,"A1_NOME"	,"SA1",STR0034   ,"@!",40) //"Nome"
			TRPosition():New(oSection0,"SA1",1,{|| xFilial("SA1")+TRB->CLIENT+TRB->LOJACL})

			oSection1 := TRSection():New(oReport,STR0024 ,{"TRB","SA2"})  //"Fornecedor"
			oCell := TRCell():New(oSection1,"TRB->FORNEC","TRB",STR0025 ,"@!", nTa1)  //"Código"
			oCell := TRCell():New(oSection1,"TRB->LOJA"  ,"TRB",STR0026 ,"@!", nTa1L)  //"Loja"
			oCell := TRCell():New(oSection1,"TRB->NOMEF"	 ,"TRB",STR0027 ,"@!",40)  //"Nome do Fornecedor"
			TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+TRB->FORNEC+TRB->LOJA})

			oSection2 := TRSection():New(oReport,STR0028,{"TRB","TM4"})  //"Exame"
			oCell2 := TRCell():New(oSection2,"TRB->EXAME"  ,"TRB",STR0028  ,"@!"              ,nTamExa,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Exame"
			oCell2 := TRCell():New(oSection2,"TM4_NOMEXA"  ,"TM4",STR0029  ,"@!"              ,40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Nome do Exame"
			TRPosition():New(oSection2,"TM4",1,{|| xFilial("TM4")+TRB->EXAME})

			oSection3 := TRSection():New(oReport,STR0063,{"TRB"}) //"Funcionário"
			oCell3 := TRCell():New(oSection3,"TRB->MAT"    ,"TRB",STR0032 ,"@!"               ,06,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Matrícula"
			oCell3 := TRCell():New(oSection3,"TRB->FICHA"  ,"TRB",STR0033 ,"@!"               ,09,/*lPixel*/,/*{|| code-block de impressao }*/)  //"F. Médica"
			oCell3 := TRCell():New(oSection3,"TRB->NOME"   ,"TRB",STR0034 ,"@!"               ,40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Nome"
			oCell3 := TRCell():New(oSection3,"TRB->CC"     ,"TRB",STR0035 ,"@!"               ,nSizeSI3,/*lPixel*/,/*{|| code-block de impressao }*/)  //"C.Custo"
			oCell3 := TRCell():New(oSection3,"TRB->CCNAME" ,"TRB",STR0036 ,"@!"               ,20,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Descrição"
			oCell3 := TRCell():New(oSection3,"TRB->DTEXAME","TRB",STR0037 ,"99/99/9999"       ,10,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Realização"
			oCell3 := TRCell():New(oSection3,"TRB->VALOR"  ,"TRB",STR0038 ,"@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Custo do Exame"
			/*oSection3:Cell("TRB->VALOR"):Hide() */
			oSection3:Cell("TRB->VALOR"):SetHeaderAlign("RIGHT")

			oBreak1 := TRBreak():New(oSection2,".T.",STR0039,.T.)  //"Total do Exame"
			TRFunction():New(oSection3:Cell("TRB->VALOR")	,/*cId*/,"SUM"	,oBreak1 ,STR0031,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Custo"
			TRFunction():New(oSection3:Cell("TRB->FICHA")  	,/*cId*/,"COUNT",oBreak1,STR0040,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Qtde"

			oBreak3 := TRBreak():New(oSection1,".T.",STR0010,.T.)  //"Total do Fornecedor"
			TRFunction():New(oSection3:Cell("TRB->VALOR"),/*cId*/,"SUM",oBreak3,STR0031,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Custo"
			oTotaliz := TRFunction():New(oSection3:Cell("TRB->VALOR"),"TOTVAL"   ,"SUM",/*oBreak*/,STR0031,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)  //"Custo"
		EndIf

	Endif

Else

	If lRelPer

		oReport:Asection := {}  //Apaga as secoes dos parametros anteriores
		oReport:aSection  := {}
		oReport:aFunction := {}

		If mv_par09 == 1  //sintetico
			oReport:SetTotalInLine(.F.)
			oSection1 := TRSection():New(oReport,STR0024,{"TRB","SA2"})  //"Fornecedor"
			oCell := TRCell():New(oSection1,"TRB->FORNEC","TRB",STR0025,"@!", Len(SA2->A2_COD) )  //"Código"
			oCell := TRCell():New(oSection1,"TRB->LOJA"  ,"TRB",STR0026,"@!", nSizeLoj )  //"Loja"
			oCell := TRCell():New(oSection1,"A2_NOME"	 ,"SA2",STR0027,"@!",40)  //"Nome do Fornecedor"
			TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+TRB->FORNEC+TRB->LOJA})

			oSection2 := TRSection():New(oReport,STR0028,{"TRB"})  //"Exame"
			oCell2 := TRCell():New(oSection2,"TRB->EXAME","TRB",STR0028  ,"@!"              ,nTamExa,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Exame"
			oCell2 := TRCell():New(oSection2,"TM4_NOMEXA","TM4",STR0029  ,"@!"              ,40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Nome do Exame"
			oCell2 := TRCell():New(oSection2,"TRB->QTDE" ,"TRB",STR0030  ,"@E 999,999"      ,17,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Quantidade"
			oCell2 := TRCell():New(oSection2,"TRB->VALOR","TRB",STR0031  ,"@E 9,999,999.99" ,12,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Custo"
			oSection2:Cell("TRB->QTDE"):SetHeaderAlign("RIGHT")
			oSection2:Cell("TRB->VALOR"):SetHeaderAlign("RIGHT")
			TRPosition():New(oSection2,"TM4",1,{|| xFilial("TM4")+TRB->EXAME})

			oBreak1 := TRBreak():New(oSection1,".T.",STR0010,.F.)  //"Total do Fornecedor"
			TRFunction():New(oSection2:Cell("TRB->VALOR"),/*cId*/,"SUM",oBreak1,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotaliz1 := TRFunction():New(oSection2:Cell("TRB->VALOR"),"TOTVAL","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
		Else
			oReport:SetTotalInLine(.T.)
			oSection1 := TRSection():New(oReport,STR0024 ,{"TRB","SA2"})  //"Fornecedor"
			oCell := TRCell():New(oSection1,"TRB->FORNEC","TRB",STR0025 ,"@!", Len(SA2->A2_COD) )  //"Código"
			oCell := TRCell():New(oSection1,"TRB->LOJA"  ,"TRB",STR0026 ,"@!", nSizeLoj)  //"Loja"
			oCell := TRCell():New(oSection1,"A2_NOME"	 ,"SA2",STR0027 ,"@!",40)  //"Nome do Fornecedor"
			TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+TRB->FORNEC+TRB->LOJA})

			oSection2 := TRSection():New(oReport,STR0028,{"TRB","TM4"})  //"Exame"
			oCell2 := TRCell():New(oSection2,"TRB->EXAME"  ,"TRB",STR0028  ,"@!"              ,nTamExa,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Exame"
			oCell2 := TRCell():New(oSection2,"TM4_NOMEXA"  ,"TM4",STR0029  ,"@!"              ,40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Nome do Exame"
			TRPosition():New(oSection2,"TM4",1,{|| xFilial("TM4")+TRB->EXAME})

			oSection3 := TRSection():New(oReport,STR0063,{"TRB"}) //"Funcionário"
			oCell3 := TRCell():New(oSection3,"TRB->MAT"    ,"TRB",STR0032 ,"@!"               ,06,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Matrícula"
			oCell3 := TRCell():New(oSection3,"TRB->FICHA"  ,"TRB",STR0033 ,"@!"               ,09,/*lPixel*/,/*{|| code-block de impressao }*/)  //"F. Médica"
			oCell3 := TRCell():New(oSection3,"TRB->NOME"   ,"TRB",STR0034 ,"@!"               ,40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Nome"
			oCell3 := TRCell():New(oSection3,"TRB->CC"     ,"TRB",STR0035 ,"@!"               ,nSizeSI3,/*lPixel*/,/*{|| code-block de impressao }*/)  //"C.Custo"
			oCell3 := TRCell():New(oSection3,"TRB->CCNAME" ,"TRB",STR0036 ,"@!"               ,20,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Descrição"
			oCell3 := TRCell():New(oSection3,"TRB->DTEXAME","TRB",STR0037 ,"99/99/9999"       ,10,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Realização"
			oCell3 := TRCell():New(oSection3,"TRB->VALOR"  ,"TRB",STR0038 ,"@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Custo do Exame"
			//oSection3:Cell("TRB->VALOR"):Hide()
			oSection3:Cell("TRB->VALOR"):SetHeaderAlign("RIGHT")

			oBreak1 := TRBreak():New(oSection2,".T.",STR0039,.T.)  //"Total do Exame"
			TRFunction():New(oSection3:Cell("TRB->VALOR")	,/*cId*/,"SUM"	,oBreak1 ,STR0031,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Custo"
			TRFunction():New(oSection3:Cell("TRB->FICHA")  	,/*cId*/,"COUNT",oBreak1,STR0040,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Qtde"

			oBreak3 := TRBreak():New(oSection1,".T.",STR0010,.T.)  //"Total do Fornecedor"
			TRFunction():New(oSection3:Cell("TRB->VALOR"),/*cId*/,"SUM",oBreak3,STR0031,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)  //"Custo"
			oTotaliz := TRFunction():New(oSection3:Cell("TRB->VALOR"),"TOTVAL"   ,"SUM",/*oBreak*/,STR0031,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)  //"Custo"

		EndIf

	Endif

Endif

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDT494FLVL³ Autor ³ Denis Hyroshi        ³ Data ³ 04/08/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida os campos De/Ate Filial                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT494FLVL(nTipo)
Local lRet := .T.
Local cArea := Alias()
Local aArea := SM0->(GetArea())

If nTipo == 1
	If !Empty(Mv_par10)
		dbSelectArea("SM0")
		If !dbSeek(cEmpAnt+Mv_par10)
			Help(" ",1,"REGNOIS")
			lRet := .F.
		Endif
		If Mv_par10 > Mv_par11
			Mv_par11 := Mv_par10
		Endif
	Endif
Else
	If Mv_par11 <> Replicate("Z",Len(Mv_par11)) .and. Mv_par11 <> Replicate("9",Len(Mv_par11))
		If Mv_par10 > Mv_par11
			Help(" ",1,"DEATEINVAL")
			lRet := .F.
		Else
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+Mv_par11)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			Endif
		Endif
	Endif
Endif

RestArea(aArea)
dbSelectArea(cArea)

Return lRet