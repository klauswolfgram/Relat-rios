/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr545.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR545  ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 12.11.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³   Relatorio Estatístico dos Diagnósticos Médicos.          ³±±
±±³          ³O objetivo deste relatorio e' apresentar as estatísticas    ³±±
±±³          ³dos diganósticos médicos.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR545(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR545()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   := "MDTR545"
Local cDesc1  := STR0001  //"Relatório de estatísticas dos diagnósticos médicos."
LOCAL cDesc2  := ""
LOCAL cDesc3  := ""
LOCAL cString := "TMT"

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

Private Tamanho := "M"
PRIVATE nomeprog := "MDTR545"
PRIVATE aReturn  := { STR0002, 1,STR0003, 2, 2, 1, "",1 }  //"Zebrado"//"Administracao"
PRIVATE titulo   := STR0004  //"Estatísticas dos Diagnósticos Médicos"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    := If(!lSigaMdtPS,"MDT545    ","MDT545PS  ")
PRIVATE cabec1, cabec2

Private nTa1      := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
Private nTa1L     := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
Private lVdeCli   := .F.
Private lVateCli  := .F.
Private lVdeLojC  := .F.
Private lVateLoC  := .F.
Private lCliVazio := .T.
Private lAteCliZ  := .T.
Private cDeCli    := " "
Private cDeCliL   := " "
Private cAteCli   := " "
Private cAteCliL  := " "

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*-----------------------------------------------
//PERGUNTAS PADRÃO									|
| 01 mv_par05             // De Dt. Consulta     |
| 02 mv_par06             // Até Dt. Consulta    |
														|
//PERGUNTAS DO PRESTADOR DE SERVIÇO				|
| 01 mv_par01             // De Cliente          |
| 02 mv_par02             // Loja                |
| 03 mv_par03             // Ate Cliente         |
| 04 mv_par04             // Loja                |
| 05 mv_par05             // De Dt. Consulta     |
| 06 mv_par06             // Até Dt. Consulta    |
--------------------------------------------------*/


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")
If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
   Return
Endif

SetDefault(aReturn,cString)
If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

RptStatus({|lEnd| R545Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R545Imp  ³ Autor ³Andre E. Perez Alvarez ³ Data ³ 14/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Prepara o relatório.                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR545                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R545Imp(lEnd,wnRel,titulo,tamanho)

Local oTempAfast, oTempAcid, oTempDiag

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Local nLastRec

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
cabec1 := STR0010  //"Variável estatística                                                       Diagnósticos     Média(%)     Mulheres     Homens"
cabec2 := ""

/***** Relatorio do tipo Sintetico
          1         2         3         4         5         6         7         8         9         0         1         2        3
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________

Variável estatística                                                       Diagnósticos     Média(%)     Mulheres     Homens
____________________________________________________________________________________________________________________________________

Cliente/Unidade: 000001-0000 - XXXXXXXXXXXXXXXXXXXXXXXXXX

Quantidade de diagnósticos no período de ____/____/____ a ____/____/____ : 50

Peso
===================================
Magreza severa                                                               123456789       xx%         123456789    123456789
Magreza moderada															 123456789       xx%         123456789    123456789
Magreza leve                                                                 123456789       xx%         123456789    123456789
Peso saudavel                                                                123456789       xx%         123456789    123456789
Pessoas com Pre obesidade													 123456789       xx%         123456789    123456789
Obesidade grau 1   															 123456789       xx%         123456789    123456789
Obesidade grau 2															 123456789       xx%         123456789    123456789
Obesidade grau 3															 123456789       xx%         123456789    123456789
-----------------------------------

Pressão arterial
===================================
Pressão normal                                            					      1        2,00%       0       1
Pressão normal limítrofe                                                          1        2,00%       0       1
Hipertensão leve (estágio 1)                           							  1        2,00%       0       1
Hipertensão moderada (estágio 2)                       							  1        2,00%       0       1
Hipertensão severa (estágio 3)                         							  1        2,00%       0       1
Hipertensão muito severa (4)                           							           2,00%       0       1
Hipertensão sistólica isolada                          							  1        2,00%       0       1
-----------------------------------

Temperarura
===================================
Temperaturas inferiores a 36ºC                                                    1        2,00%       0       1
Temperaturas superiores a 36ºC                                                    1        2,00%       0       1
-----------------------------------

Atendimentos realizados
===================================
Atendimento Clínico                                                                1        2,00%       0       1
Doenca do Trabalho                                                                 1        2,00%       0       1
Acidente Tipico                                                                    1        2,00%       0       1
Acidente Trajeto          												           1        2,00%       0       1
Outros Atedimentos                  									           1        2,00%       0       1
Avaliacao NR7                             								           1        2,00%       0       1
-----------------------------------

Acidentes
===================================
xxxxxxxxxxxxxxxxxxxxxxxx                                                           1        2,00%       0       1
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                             				   1        2,00%       0       1
xxxxxxxxxxxxxxxxxxxxxxxxxxx                                      			       1        2,00%       0       1
-----------------------------------

Afastamentos
===================================
Número de diagnósticos que relatam afastamentos									   1        2,00%       0       1
Maior período de afastamento: 40 dias                                              ------------------------------
-----------------------------------
___________________________________________________________________________________________________________________________________
*/

/***** Relatorio do tipo Sintetico
          1         2         3         4         5         6         7         8         9         0         1         2        3
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________

Variável estatística                                                       Diagnósticos     Média(%)     Mulheres     Homens
____________________________________________________________________________________________________________________________________

Quantidade de diagnósticos no período de ____/____/____ a ____/____/____ : 50

Peso
===================================
Magreza severa                                                               123456789       xx%         123456789    123456789
Magreza moderada															 123456789       xx%         123456789    123456789
Magreza leve                                                                 123456789       xx%         123456789    123456789
Peso saudavel                                                                123456789       xx%         123456789    123456789
Pessoas com Pre obesidade													 123456789       xx%         123456789    123456789
Obesidade grau 1   															 123456789       xx%         123456789    123456789
Obesidade grau 2															 123456789       xx%         123456789    123456789
Obesidade grau 3															 123456789       xx%         123456789    123456789
-----------------------------------

Pressão arterial
===================================
Pressão normal                                            					      1        2,00%       0       1
Pressão normal limítrofe                                                          1        2,00%       0       1
Hipertensão leve (estágio 1)                           							  1        2,00%       0       1
Hipertensão moderada (estágio 2)                       							  1        2,00%       0       1
Hipertensão severa (estágio 3)                         							  1        2,00%       0       1
Hipertensão muito severa (4)                           							           2,00%       0       1
Hipertensão sistólica isolada                          							  1        2,00%       0       1
-----------------------------------

Temperarura
===================================
Temperaturas inferiores a 36ºC                                                    1        2,00%       0       1
Temperaturas superiores a 36ºC                                                    1        2,00%       0       1
-----------------------------------

Atendimentos realizados
===================================
Atendimento Clínico                                                                1        2,00%       0       1
Doenca do Trabalho                                                                 1        2,00%       0       1
Acidente Tipico                                                                    1        2,00%       0       1
Acidente Trajeto          												           1        2,00%       0       1
Outros Atedimentos                  									           1        2,00%       0       1
Avaliacao NR7                             								           1        2,00%       0       1
-----------------------------------

Acidentes
===================================
xxxxxxxxxxxxxxxxxxxxxxxx                                                           1        2,00%       0       1
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                             				   1        2,00%       0       1
xxxxxxxxxxxxxxxxxxxxxxxxxxx                                      			       1        2,00%       0       1
-----------------------------------

Afastamentos
===================================
Número de diagnósticos que relatam afastamentos									   1        2,00%       0       1
Maior período de afastamento: 40 dias                                              ------------------------------
-----------------------------------
___________________________________________________________________________________________________________________________________
*/

aDBF := {}

If lSigaMdtps
	AADD(aDBF,{"CLIENT"   ,"C" ,nTa1  ,0})
	AADD(aDBF,{"LOJA"     ,"C" ,nTa1L ,0})
	AADD(aDBF,{"NOMECLI"  ,"C" ,40    ,0})
Endif

//Peso
AADD(aDBF,{"PESO1"   ,"N" ,09    ,0})  //Magreza severa
AADD(aDBF,{"PESO1M"  ,"N" ,09    ,0})  //mulheres
AADD(aDBF,{"PESO1H"  ,"N" ,09    ,0})  //homens

AADD(aDBF,{"PESO2"   ,"N" ,09    ,0})  //Magreza moderada
AADD(aDBF,{"PESO2M"  ,"N" ,09    ,0})
AADD(aDBF,{"PESO2H"  ,"N" ,09    ,0})

AADD(aDBF,{"PESO3"   ,"N" ,09    ,0})  //Magreza leve
AADD(aDBF,{"PESO3M"  ,"N" ,09    ,0})
AADD(aDBF,{"PESO3H"  ,"N" ,09    ,0})

AADD(aDBF,{"PESO4"   ,"N" ,09    ,0})  //Peso saudavel
AADD(aDBF,{"PESO4M"  ,"N" ,09    ,0})
AADD(aDBF,{"PESO4H"  ,"N" ,09    ,0})

AADD(aDBF,{"PESO5"   ,"N" ,12    ,0})  //Pre obesidade
AADD(aDBF,{"PESO5M"  ,"N" ,09    ,0})
AADD(aDBF,{"PESO5H"  ,"N" ,09    ,0})

AADD(aDBF,{"PESO6"   ,"N" ,09    ,0})  //Obesidade grau 1
AADD(aDBF,{"PESO6M"  ,"N" ,09    ,0})
AADD(aDBF,{"PESO6H"  ,"N" ,09    ,0})

AADD(aDBF,{"PESO7"   ,"N" ,09    ,0})  //Obesidade grau 2
AADD(aDBF,{"PESO7M"  ,"N" ,09    ,0})
AADD(aDBF,{"PESO7H"  ,"N" ,09    ,0})

AADD(aDBF,{"PESO8"   ,"N" ,09    ,0})  //Obesidade grau 3
AADD(aDBF,{"PESO8M"  ,"N" ,09    ,0})
AADD(aDBF,{"PESO8H"  ,"N" ,09    ,0})

AADD(aDBF,{"PESO9"   ,"N" ,09    ,0})  //Pessoas sem peso e altura especificados
AADD(aDBF,{"PESO9M"  ,"N" ,09    ,0})
AADD(aDBF,{"PESO9H"  ,"N" ,09    ,0})

//Pressao
AADD(aDBF,{"PRESS1"  ,"N" ,09    ,0})  //normal
AADD(aDBF,{"PRESS1M" ,"N" ,09    ,0})
AADD(aDBF,{"PRESS1H" ,"N" ,09    ,0})

AADD(aDBF,{"PRESS2"  ,"N" ,09    ,0})  //limítrofe
AADD(aDBF,{"PRESS2M" ,"N" ,09    ,0})
AADD(aDBF,{"PRESS2H" ,"N" ,09    ,0})

AADD(aDBF,{"PRESS3"  ,"N" ,09    ,0})  //hipertensão leve
AADD(aDBF,{"PRESS3M" ,"N" ,09    ,0})
AADD(aDBF,{"PRESS3H" ,"N" ,09    ,0})

AADD(aDBF,{"PRESS4"  ,"N" ,09    ,0})  //hipertensão moderada
AADD(aDBF,{"PRESS4M" ,"N" ,09    ,0})
AADD(aDBF,{"PRESS4H" ,"N" ,09    ,0})

AADD(aDBF,{"PRESS5"  ,"N" ,09    ,0})  //hipertensão severa
AADD(aDBF,{"PRESS5M" ,"N" ,09    ,0})
AADD(aDBF,{"PRESS5H" ,"N" ,09    ,0})

AADD(aDBF,{"PRESS6"  ,"N" ,09    ,0})  //hipertensão muito severa
AADD(aDBF,{"PRESS6M" ,"N" ,09    ,0})
AADD(aDBF,{"PRESS6H" ,"N" ,09    ,0})

AADD(aDBF,{"PRESS7"  ,"N" ,09    ,0})  //hipertensão sistólica isolada
AADD(aDBF,{"PRESS7M" ,"N" ,09    ,0})
AADD(aDBF,{"PRESS7H" ,"N" ,09    ,0})

//Problemas de temperatura
AADD(aDBF,{"TEMPERI"  ,"N" ,09   ,0})  //Inferior a 36ºC
AADD(aDBF,{"TEMPERIM" ,"N" ,09   ,0})
AADD(aDBF,{"TEMPERIH" ,"N" ,09   ,0})
AADD(aDBF,{"TEMPERS"  ,"N" ,09   ,0})  //Superior a 36ºC
AADD(aDBF,{"TEMPERSM" ,"N" ,09   ,0})
AADD(aDBF,{"TEMPERSH" ,"N" ,09   ,0})

//Atendimentos realizados
AADD(aDBF,{"CLINI"   ,"N" ,09   ,0})  //atendimentos clinicos
AADD(aDBF,{"CLINIM"  ,"N" ,09   ,0})
AADD(aDBF,{"CLINIH"  ,"N" ,09   ,0})

AADD(aDBF,{"TRAB" ,"N" ,09    ,0})  //doença do trabalho
AADD(aDBF,{"TRABM","N" ,09    ,0})
AADD(aDBF,{"TRABH","N" ,09    ,0})

AADD(aDBF,{"TIP"  ,"N" ,09    ,0})  //acidente tipico
AADD(aDBF,{"TIPM" ,"N" ,09    ,0})
AADD(aDBF,{"TIPH" ,"N" ,09    ,0})

AADD(aDBF,{"TRAJ"  ,"N" ,09    ,0})  //acidente trajeto
AADD(aDBF,{"TRAJM" ,"N" ,09    ,0})
AADD(aDBF,{"TRAJH" ,"N" ,09    ,0})

AADD(aDBF,{"OUTROS"  ,"N" ,09    ,0})  //outros atendimentos
AADD(aDBF,{"OUTROSM" ,"N" ,09    ,0})
AADD(aDBF,{"OUTROSH" ,"N" ,09    ,0})

AADD(aDBF,{"NR7"     ,"N" ,09    ,0})  //avaliacao NR7
AADD(aDBF,{"NR7M"    ,"N" ,09    ,0})
AADD(aDBF,{"NR7H"    ,"N" ,09    ,0})

//Afastamentos
AADD(aDBF,{"AFAST"  ,"N" ,09    ,0})  //Qtde. de pessoas que tiveram Afastamentos
AADD(aDBF,{"AFASTM" ,"N" ,09    ,0})
AADD(aDBF,{"AFASTH" ,"N" ,09    ,0})
AADD(aDBF,{"PERIMA" ,"N" ,04    ,0})

oTempAfast:= FWTemporaryTable():New( "TRB", aDBF )
If lSigaMdtps
	oTempAfast:AddIndex( "1", {"CLIENT","LOJA"} )
Else
	oTempAfast:AddIndex( "1", {"PESO1"} )
Endif
oTempAfast:Create()

//Acidentes
aDBF2 := {}

If lSigaMdtps
	AADD(aDBF2,{"CLIENT" ,"C" ,nTa1  ,0})
	AADD(aDBF2,{"LOJA"   ,"C" ,nTa1L ,0})
Endif

AADD(aDBF2,{"ACIDEN" ,"C" ,06    ,0})
AADD(aDBF2,{"DESACI" ,"C" ,40    ,0})
AADD(aDBF2,{"QUANT"  ,"N" ,09    ,0})  //Quantidade
AADD(aDBF2,{"QUANTM" ,"N" ,09    ,0})
AADD(aDBF2,{"QUANTH" ,"N" ,09    ,0})

oTempAcid:= FWTemporaryTable():New( "TRB2", aDBF2 )
If lSigaMdtps
	oTempAcid:AddIndex( "1", {"CLIENT","LOJA","ACIDEN"} )
Else
	oTempAcid:AddIndex( "1", {"ACIDEN"} )
Endif
oTempAcid:Create()

//Totais gerais dos diagnosticos
aDBF3 := {}
If lSigaMdtps
	AADD(aDBF3,{"CLIENT" ,"C" ,nTa1  ,0})
	AADD(aDBF3,{"LOJA"   ,"C" ,nTa1L ,0})
Endif
AADD(aDBF3,{"QUANT"  ,"N" ,09    ,0})  //Quantidade

oTempDiag := FWTemporaryTable():New( "TRB3", aDBF3 )
If lSigaMdtps
	oTempDiag:AddIndex( "1", {"CLIENTE","LOJA"} )
Else
	oTempDiag:AddIndex( "1", {"QUANT"} )
EndIf
oTempDiag:Create()

TRBGrava()  //Busca os dados a serem impressos

//Imprime o relatorio. Antes verifica se ha' informacoes para isso.
If !U_Imp545R()
	MsgInfo(STR0011)  //"Não há nada para imprimir no relatório."
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve a condicao original do arquivo principal             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oTempAfast:Delete()
	oTempAcid:Delete()
	oTempDiag:Delete()

	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTempAfast:Delete()
oTempAcid:Delete()
oTempDiag:Delete()

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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TRBGrava ³ Autor ³Andre E. Perez Alvarez ³ Data ³ 13/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio - busca os dados a serem impressos.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR545                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TRBGrava()

Local cClient := "", cLoja := ""
Local lPri01 := .T.
Local lPri02 := .T.

If lSigaMdtps

	dbSelectArea("TMT")
	dbSetOrder(9) //TMT_FILIAL+TMT_CLIENT+TMT_LOJA+DTOS(TMT_DTCONS)+TMT_NUMFIC
	Set Filter To TMT->TMT_FILIAL == xFilial("TMT") .AND.;
				  TMT->(TMT_CLIENT+TMT_LOJA) >= mv_par01+mv_par02 .AND. TMT->(TMT_CLIENT+TMT_LOJA) <= mv_par03+mv_par04  .AND.;
			 	  TMT->TMT_DTCONS >= mv_par05 .AND. TMT->TMT_DTCONS <= mv_par06
	dbGoTop()

	SetRegua( RecCount() )

	While !Eof()

		IncRegua()

	    cClient := TMT->TMT_CLIENT
		cLoja   := TMT->TMT_LOJA

	    dbSelectArea("TRB3")
		If !DbSeek( cClient + cLoja )
			Reclock('TRB3',.T.)
		Else
			Reclock('TRB3',.F.)
		EndIf
		TRB3->CLIENT := cClient
		TRB3->LOJA := cLoja
		TRB3->QUANT ++
	   	TRB3->(MsUnLock())

	   	dbSelectArea("SA1")
	  	dbSetOrder(1)
	  	dbSeek(xFilial("SA1")+cClient+cLoja)

	  	dbSelectArea("TM0")
	  	dbSetOrder(1)
	  	dbSeek(xFilial("TM0")+TMT->TMT_NUMFIC)

	    dbSelectArea("TRB")
		If !DbSeek( cClient + cLoja )
			Reclock('TRB',.T.)
		Else
			Reclock('TRB',.F.)
		EndIf

		TRB->CLIENT  := cClient
		TRB->LOJA    := cLoja
		TRB->NOMECLI := SA1->A1_NOME

		If TM0->TM0_SEXO == "1"  //Masculino

			U_MDTPREMASC()  //Pressão
			MDTIMCMASC()  //Peso

			If TMT->TMT_TEMPER < 36
				TRB->TEMPERI ++
				TRB->TEMPERIH ++
			Elseif TMT->TMT_TEMPER > 36
				TRB->TEMPERS ++
				TRB->TEMPERSH ++
			Endif

			//Atendimentos realizados
			If TMT->TMT_OCORRE == "1"  //1=Atend. Clinico;
				TRB->CLINI ++
				TRB->CLINIH ++
			Elseif TMT->TMT_OCORRE == "2"  //2=Doenca do Trabalho;
				TRB->TRAB ++
				TRB->TRABH ++
			Elseif TMT->TMT_OCORRE == "3" //3=Acidente Tipico;
				TRB->TIP ++
				TRB->TIPH ++
			Elseif TMT->TMT_OCORRE == "4"  //4=Acidente Trajeto;
				TRB->TRAJ ++
				TRB->TRAJH ++
			Elseif TMT->TMT_OCORRE == "5"  //5=Outros Atedimentos;
				TRB->OUTROS ++
				TRB->OUTROSH ++
			Elseif TMT->TMT_OCORRE == "6"  //6=Avaliacao NR7
				TRB->NR7 ++
				TRB->NR7H ++
			Endif

			//Afastamentos
			If TMT->TMT_QTAFAS > 0
				TRB->AFAST ++
				TRB->AFASTH ++
			Endif
			If TMT->TMT_QTAFAS > TRB->PERIMA   //Maior Periodo de Afastamento
				TRB->PERIMA := TMT->TMT_QTAFAS
			Endif

			//Acidentes
			If !Empty(TMT->TMT_ACIDEN)
			    dbSelectArea("TRB2")
				If !DbSeek( cClient + cLoja + TMT->TMT_ACIDEN)
					Reclock('TRB2',.T.)
				Else
					Reclock('TRB2',.F.)
				EndIf
				TRB2->CLIENT := cClient
				TRB2->LOJA := cLoja
				TRB2->ACIDEN := TMT->TMT_ACIDEN
				TRB2->DESACI := NGSEEK("TNC",cClient+cLoja+TMT->TMT_ACIDEN,1,"TNC->TNC_DESACI")
				TRB2->QUANT ++
				TRB2->QUANTH ++
			   	TRB2->(MsUnLock())
			Endif

		Elseif TM0->TM0_SEXO == "2"  //Feminino

			U_MDTPREFEM()  //Pressão
			MDTIMCFEM()  //Peso

			If TMT->TMT_TEMPER < 36
				TRB->TEMPERI ++
				TRB->TEMPERIM ++
			Elseif TMT->TMT_TEMPER > 36
				TRB->TEMPERS ++
				TRB->TEMPERSM ++
			Endif

			//Atendimentos realizados
			If TMT->TMT_OCORRE == "1"  //1=Atend. Clinico;
				TRB->CLINI ++
				TRB->CLINIM ++
			Elseif TMT->TMT_OCORRE == "2"  //2=Doenca do Trabalho;
				TRB->TRAB ++
				TRB->TRABM ++
			Elseif TMT->TMT_OCORRE == "3" //3=Acidente Tipico;
				TRB->TIP ++
				TRB->TIPM ++
			Elseif TMT->TMT_OCORRE == "4"  //4=Acidente Trajeto;
				TRB->TRAJ ++
				TRB->TRAJM ++
			Elseif TMT->TMT_OCORRE == "5"  //5=Outros Atedimentos;
				TRB->OUTROS ++
				TRB->OUTROSM ++
			Elseif TMT->TMT_OCORRE == "6"  //6=Avaliacao NR7
				TRB->NR7 ++
				TRB->NR7M ++
			Endif

			//Afastamentos
			If TMT->TMT_QTAFAS > 0
				TRB->AFAST ++
				TRB->AFASTM ++
			Endif
			If TMT->TMT_QTAFAS > TRB->PERIMA   //Maior Periodo de Afastamento
				TRB->PERIMA := TMT->TMT_QTAFAS
			Endif

			//Acidentes
			If !Empty(TMT->TMT_ACIDEN)
			    dbSelectArea("TRB2")
				If !DbSeek( cClient + cLoja + TMT->TMT_ACIDEN)
					Reclock('TRB2',.T.)
				Else
					Reclock('TRB2',.F.)
				EndIf
				TRB2->CLIENT := cClient
				TRB2->LOJA := cLoja
				TRB2->ACIDEN := TMT->TMT_ACIDEN
				TRB2->DESACI := NGSEEK("TNC",cClient+cLoja+TMT->TMT_ACIDEN,1,"TNC->TNC_DESACI")
				TRB2->QUANT ++
				TRB2->QUANTM ++
			   	TRB2->(MsUnLock())
			Endif

		Endif

	   	TRB->(MsUnLock())

		dbSelectArea("TMT")
		dbSkip()
	End
Else

	dbSelectArea("TMT")
	dbSetOrder(3) //TMT_FILIAL+TMT_NUMFIC+DTOS(TMT_DTCONS)+TMT_HRCONS
	Set Filter To xFilial("TMT") == TMT->TMT_FILIAL .AND. TMT->TMT_DTCONS >= mv_par01 .AND. TMT->TMT_DTCONS <= mv_par02
	dbGoTop()

	SetRegua( RecCount() )

	While !Eof()

		IncRegua()

	    dbSelectArea("TRB3")
		If lPri01
			Reclock('TRB3',.T.)
			lPri01 := .F.
		Else
			Reclock('TRB3',.F.)
		Endif
		TRB3->QUANT ++
	   	TRB3->(MsUnLock())

	  	dbSelectArea("TM0")
	  	dbSetOrder(1)
	  	dbSeek(xFilial("TM0")+TMT->TMT_NUMFIC)

	    dbSelectArea("TRB")
		If lPri02
			Reclock('TRB',.T.)
			lPri02 := .F.
		Else
			Reclock('TRB',.F.)
		Endif

		If TM0->TM0_SEXO == "1"  //Masculino

			U_MDTPREMASC()  //Pressão
			MDTIMCMASC()  //Peso

			If TMT->TMT_TEMPER < 36
				TRB->TEMPERI ++
				TRB->TEMPERIH ++
			Elseif TMT->TMT_TEMPER > 36
				TRB->TEMPERS ++
				TRB->TEMPERSH ++
			Endif

			//Atendimentos realizados
			If TMT->TMT_OCORRE == "1"  //1=Atend. Clinico;
				TRB->CLINI ++
				TRB->CLINIH ++
			Elseif TMT->TMT_OCORRE == "2"  //2=Doenca do Trabalho;
				TRB->TRAB ++
				TRB->TRABH ++
			Elseif TMT->TMT_OCORRE == "3" //3=Acidente Tipico;
				TRB->TIP ++
				TRB->TIPH ++
			Elseif TMT->TMT_OCORRE == "4"  //4=Acidente Trajeto;
				TRB->TRAJ ++
				TRB->TRAJH ++
			Elseif TMT->TMT_OCORRE == "5"  //5=Outros Atedimentos;
				TRB->OUTROS ++
				TRB->OUTROSH ++
			Elseif TMT->TMT_OCORRE == "6"  //6=Avaliacao NR7
				TRB->NR7 ++
				TRB->NR7H ++
			Endif

			//Afastamentos
			If TMT->TMT_QTAFAS > 0
				TRB->AFAST ++
				TRB->AFASTH ++
			Endif
			If TMT->TMT_QTAFAS > TRB->PERIMA   //Maior Periodo de Afastamento
				TRB->PERIMA := TMT->TMT_QTAFAS
			Endif

			//Acidentes
			If !Empty(TMT->TMT_ACIDEN)
			    dbSelectArea("TRB2")
				If !DbSeek( TMT->TMT_ACIDEN)
					Reclock('TRB2',.T.)
				Else
					Reclock('TRB2',.F.)
				EndIf
				TRB2->ACIDEN := TMT->TMT_ACIDEN
				TRB2->DESACI := NGSEEK("TNC",TMT->TMT_ACIDEN,1,"TNC->TNC_DESACI")
				TRB2->QUANT ++
				TRB2->QUANTH ++
			   	TRB2->(MsUnLock())
			Endif

		Elseif TM0->TM0_SEXO == "2"  //Feminino

			U_MDTPREFEM()  //Pressão
			MDTIMCFEM()  //Peso

			If TMT->TMT_TEMPER < 36
				TRB->TEMPERI ++
				TRB->TEMPERIM ++
			Elseif TMT->TMT_TEMPER > 36
				TRB->TEMPERS ++
				TRB->TEMPERSM ++
			Endif

			//Atendimentos realizados
			If TMT->TMT_OCORRE == "1"  //1=Atend. Clinico;
				TRB->CLINI ++
				TRB->CLINIM ++
			Elseif TMT->TMT_OCORRE == "2"  //2=Doenca do Trabalho;
				TRB->TRAB ++
				TRB->TRABM ++
			Elseif TMT->TMT_OCORRE == "3" //3=Acidente Tipico;
				TRB->TIP ++
				TRB->TIPM ++
			Elseif TMT->TMT_OCORRE == "4"  //4=Acidente Trajeto;
				TRB->TRAJ ++
				TRB->TRAJM ++
			Elseif TMT->TMT_OCORRE == "5"  //5=Outros Atedimentos;
				TRB->OUTROS ++
				TRB->OUTROSM ++
			Elseif TMT->TMT_OCORRE == "6"  //6=Avaliacao NR7
				TRB->NR7 ++
				TRB->NR7M ++
			Endif

			//Afastamentos
			If TMT->TMT_QTAFAS > 0
				TRB->AFAST ++
				TRB->AFASTM ++
			Endif
			If TMT->TMT_QTAFAS > TRB->PERIMA   //Maior Periodo de Afastamento
				TRB->PERIMA := TMT->TMT_QTAFAS
			Endif

			//Acidentes
			If !Empty(TMT->TMT_ACIDEN)
			    dbSelectArea("TRB2")
				If !DbSeek( TMT->TMT_ACIDEN)
					Reclock('TRB2',.T.)
				Else
					Reclock('TRB2',.F.)
				EndIf
				TRB2->ACIDEN := TMT->TMT_ACIDEN
				TRB2->DESACI := NGSEEK("TNC",TMT->TMT_ACIDEN,1,"TNC->TNC_DESACI")
				TRB2->QUANT ++
				TRB2->QUANTM ++
			   	TRB2->(MsUnLock())
			Endif

		Endif

	   	TRB->(MsUnLock())

		dbSelectArea("TMT")
		dbSkip()
	End

Endif

Set Filter To

Return .T.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³Imp545R   ³ Autor ³ Andre E.P. Alvarez    ³ Data ³ 13/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o relatorio.                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Retorna falso caso nao haja nada para imprimir. Retorna    ³±±
±±³          ³ verdadeiro caso haja informacoes impressas.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR545                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
User Function Imp545R()

Local cRodaTxt := ""
Local nCntImpr := 0

Local n1 := 74
Local n2 := 93
Local n3 := 101
Local n4 := 112

Private lNewPage := .F.

dbSelectArea("TRB")

If RecCount()==0
	Return .F.
EndIf

SomaLinha()

dbGotop()

If lSigaMdtps

	While !EOF()

	    @ Li,000 PSay STR0012 + TRB->CLIENT + "-" + TRB->LOJA + " - " +TRB->NOMECLI  //"Cliente/Unidade: "

	    dbSelectArea("TRB3")
	    dbSeek(TRB->CLIENT+TRB->LOJA)

	    SomaLinha()
	    SomaLinha()
		@ Li,000 PSay STR0013 + DtoC(mv_par05) + STR0045 + DtoC(mv_par06) + ": " + AllTrim(Str(TRB3->QUANT))    //"Quantidade de diagnósticos no período de " //" a "
	    SomaLinha()
	    SomaLinha()

		@ Li,000 PSay STR0014  //"Peso"
		SomaLinha()
		@ Li,000 PSay "-----------------------------------"
		SomaLinha()
		@ Li,000 PSay STR0015  //"Magreza severa"
		@ Li,n1  PSay TRB->PESO1 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO1/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO1M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO1H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0016  //"Magreza moderada"
		@ Li,n1  PSay TRB->PESO2 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO2/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO2M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO2H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0017  //"Magreza leve"
		@ Li,n1  PSay TRB->PESO3 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO3/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO3M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO3H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0018  //"Peso saudável"
		@ Li,n1  PSay TRB->PESO4 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO4/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO4M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO4H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0019  //"Pré-obesidade"
		@ Li,n1  PSay TRB->PESO5 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO5/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO5M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO5H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0020  //"Obesidade grau 1"
		@ Li,n1  PSay TRB->PESO6 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO6/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO6M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO6H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0021  //"Obesidade grau 2"
		@ Li,n1  PSay TRB->PESO7 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO7/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO7M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO7H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0022 //"Obesidade grau 3"
		@ Li,n1  PSay TRB->PESO8 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO8/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO8M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO8H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		Somalinha()
		@ Li,000 PSay STR0023  //"Pressão arterial"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		@ Li,000 PSay STR0024  //"Pressão normal"
		@ Li,n1  PSay TRB->PRESS1 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS1/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS1M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS1H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0025  //"Pressão normal limítrofe"
		@ Li,n1  PSay TRB->PRESS2 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS2/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS2M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS2H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0026  //"Hipertensão leve (estágio 1)"
		@ Li,n1  PSay TRB->PRESS3 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS3/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS3M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS3H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0027  //"Hipertensão moderada (estágio 2)"
		@ Li,n1  PSay TRB->PRESS4 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS4/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS4M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS4H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0028  //"Hipertensão severa (estágio 3)"
		@ Li,n1  PSay TRB->PRESS5 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS5/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS5M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS5H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0029  //"Hipertensão muito severa (4)"
		@ Li,n1  PSay TRB->PRESS6 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS6/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS6M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS6H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0030  //"Hipertensão sistólica isolada"
		@ Li,n1  PSay TRB->PRESS7 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS7/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS7M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS7H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		Somalinha()
		@ Li,000 PSay STR0031  //"Temperatura"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		@ Li,000 PSay STR0032  //"Temperaturas inferiores a 36ºC"
		@ Li,n1  PSay TRB->TEMPERI Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TEMPERI/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->TEMPERIM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TEMPERIH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0033  //"Temperaturas superiores a 36ºC"
		@ Li,n1  PSay TRB->TEMPERS Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TEMPERS/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->TEMPERSM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TEMPERSH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		Somalinha()

		@ Li,000 PSay STR0034  //"Atendimentos realizados"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		@ Li,000 PSay STR0035  //"Atendimento Clínico"
		@ Li,n1  PSay TRB->CLINI Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->CLINI/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->CLINIM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->CLINIH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0036  //"Doença do Trabalho"
		@ Li,n1  PSay TRB->TRAB	Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TRAB/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->TRABM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TRABH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0037  //"Acidente Típico"
		@ Li,n1  PSay TRB->TIP Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TIP/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->TIPM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TIPH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0038  //"Acidente de Trajeto"
		@ Li,n1  PSay TRB->TRAJ Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TRAJ/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->TRAJM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TRAJH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0039  //"Outros Atendimentos"
		@ Li,n1  PSay TRB->OUTROS Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->OUTROS/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->OUTROSM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->OUTROSH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0040  //"Avaliação NR7"
		@ Li,n1  PSay TRB->NR7 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->NR7/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->NR7M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->NR7H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		Somalinha()

	    dbSelectArea("TRB2")
		If DbSeek( TRB->(CLIENT+LOJA) )
			@ Li,000 PSay STR0041  //"Acidentes"
			SomaLinha()
			@ Li,000 PSay "-----------------------------------"
			SomaLinha()
			While !Eof() .AND. TRB->(CLIENT+LOJA) == TRB2->(CLIENT+LOJA)
				@ Li,000 PSay TRB2->DESACI
				@ Li,n1  PSay TRB2->QUANT Picture "@E 9,999,999"
				@ Li,n2  PSay (TRB2->QUANT/TRB3->QUANT)*100 Picture "@E 999"
				@ Li,n3  PSay TRB2->QUANTM Picture "@E 9,999,999"
				@ Li,n4  PSay TRB2->QUANTH Picture "@E 9,999,999"
				SomaLinha()
				dbSkip()
			End
			@ Li,000 PSay "-----------------------------------"
			SomaLinha()
			SomaLinha()
		EndIf

		@ Li,000 PSay STR0042  //"Afastamentos"
		SomaLinha()
		@ Li,000 PSay "-----------------------------------"
		SomaLinha()
		@ Li,000 PSay STR0043  //"Número de diagnósticos que relatam afastamentos:"
		@ Li,n1  PSay TRB->AFAST Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->AFAST/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->AFASTM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->AFASTH Picture "@E 9,999,999"
		SomaLinha()
		@ Li,000 PSay STR0044  //"Maior período de afastamento: "
		@ Li,030 PSay TRB->PERIMA Picture "@E 9999"

	    dbSelectArea("TRB")
	   	dbSkip()

	   	If !Eof()
			SomaLinha()
			SomaLinha()
			@ Li,000 PSay Replicate("_",132)
			SomaLinha()
			SomaLinha()
	   	Endif
	End

Else

	While !EOF()

	    dbSelectArea("TRB3")
	    dbGoTop()

		@ Li,000 PSay STR0013 + DtoC(mv_par01) + STR0045 + DtoC(mv_par02) + ": " + AllTrim(Str(TRB3->QUANT))    //"Quantidade de diagnósticos no período de "###" a "
	    SomaLinha()
	    SomaLinha()

		@ Li,000 PSay STR0014  //"Peso"
		SomaLinha()
		@ Li,000 PSay "-----------------------------------"
		SomaLinha()
		@ Li,000 PSay STR0015  //"Magreza severa"
		@ Li,n1  PSay TRB->PESO1 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO1/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO1M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO1H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0016  //"Magreza moderada"
		@ Li,n1  PSay TRB->PESO2 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO2/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO2M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO2H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0017  //"Magreza leve"
		@ Li,n1  PSay TRB->PESO3 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO3/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO3M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO3H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0018  //"Peso saudável"
		@ Li,n1  PSay TRB->PESO4 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO4/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO4M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO4H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0019  //"Pré-obesidade"
		@ Li,n1  PSay TRB->PESO5 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO5/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO5M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO5H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0020  //"Obesidade grau 1"
		@ Li,n1  PSay TRB->PESO6 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO6/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO6M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO6H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0021  //"Obesidade grau 2"
		@ Li,n1  PSay TRB->PESO7 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO7/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO7M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO7H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0022 //"Obesidade grau 3"
		@ Li,n1  PSay TRB->PESO8 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PESO8/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PESO8M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PESO8H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		Somalinha()
		@ Li,000 PSay STR0023  //"Pressão arterial"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		@ Li,000 PSay STR0024  //"Pressão normal"
		@ Li,n1  PSay TRB->PRESS1 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS1/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS1M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS1H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0025  //"Pressão normal limítrofe"
		@ Li,n1  PSay TRB->PRESS2 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS2/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS2M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS2H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0026  //"Hipertensão leve (estágio 1)"
		@ Li,n1  PSay TRB->PRESS3 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS3/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS3M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS3H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0027  //"Hipertensão moderada (estágio 2)"
		@ Li,n1  PSay TRB->PRESS4 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS4/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS4M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS4H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0028  //"Hipertensão severa (estágio 3)"
		@ Li,n1  PSay TRB->PRESS5 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS5/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS5M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS5H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0029  //"Hipertensão muito severa (4)"
		@ Li,n1  PSay TRB->PRESS6 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS6/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS6M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS6H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0030  //"Hipertensão sistólica isolada"
		@ Li,n1  PSay TRB->PRESS7 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->PRESS7/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->PRESS7M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->PRESS7H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		Somalinha()
		@ Li,000 PSay STR0031  //"Temperatura"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		@ Li,000 PSay STR0032  //"Temperaturas inferiores a 36ºC"
		@ Li,n1  PSay TRB->TEMPERI Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TEMPERI/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->TEMPERIM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TEMPERIH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0033  //"Temperaturas superiores a 36ºC"
		@ Li,n1  PSay TRB->TEMPERS Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TEMPERS/TRB3->QUANT)*100  Picture "@E 999"
		@ Li,n3  PSay TRB->TEMPERSM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TEMPERSH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		Somalinha()

		@ Li,000 PSay STR0034  //"Atendimentos realizados"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		@ Li,000 PSay STR0035  //"Atendimento Clínico"
		@ Li,n1  PSay TRB->CLINI Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->CLINI/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->CLINIM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->CLINIH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0036  //"Doença do Trabalho"
		@ Li,n1  PSay TRB->TRAB	Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TRAB/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->TRABM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TRABH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0037  //"Acidente Típico"
		@ Li,n1  PSay TRB->TIP Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TIP/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->TIPM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TIPH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0038  //"Acidente de Trajeto"
		@ Li,n1  PSay TRB->TRAJ Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->TRAJ/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->TRAJM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->TRAJH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0039  //"Outros Atendimentos"
		@ Li,n1  PSay TRB->OUTROS Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->OUTROS/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->OUTROSM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->OUTROSH Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay STR0040  //"Avaliação NR7"
		@ Li,n1  PSay TRB->NR7 Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->NR7/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->NR7M Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->NR7H Picture "@E 9,999,999"
		Somalinha()
		@ Li,000 PSay "-----------------------------------"
		Somalinha()
		Somalinha()

	    dbSelectArea("TRB2")
	    dbGoTop()
		If !Eof()
			@ Li,000 PSay STR0041  //"Acidentes"
			SomaLinha()
			@ Li,000 PSay "-----------------------------------"
			SomaLinha()
			While !Eof()
				@ Li,000 PSay TRB2->DESACI
				@ Li,n1  PSay TRB2->QUANT Picture "@E 9,999,999"
				@ Li,n2  PSay (TRB2->QUANT/TRB3->QUANT)*100 Picture "@E 999"
				@ Li,n3  PSay TRB2->QUANTM Picture "@E 9,999,999"
				@ Li,n4  PSay TRB2->QUANTH Picture "@E 9,999,999"
				SomaLinha()
				dbSkip()
			End
			@ Li,000 PSay "-----------------------------------"
			SomaLinha()
			SomaLinha()
		EndIf

		@ Li,000 PSay STR0042  //"Afastamentos"
		SomaLinha()
		@ Li,000 PSay "-----------------------------------"
		SomaLinha()
		@ Li,000 PSay STR0043  //"Número de diagnósticos que relatam afastamentos:"
		@ Li,n1  PSay TRB->AFAST Picture "@E 9,999,999"
		@ Li,n2  PSay (TRB->AFAST/TRB3->QUANT)*100 Picture "@E 999"
		@ Li,n3  PSay TRB->AFASTM Picture "@E 9,999,999"
		@ Li,n4  PSay TRB->AFASTH Picture "@E 9,999,999"
		SomaLinha()
		@ Li,000 PSay STR0044  //"Maior período de afastamento: "
		@ Li,030 PSay TRB->PERIMA Picture "@E 9999"

	    dbSelectArea("TRB")
	   	dbSkip()

	End

Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

Return .T.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Andre E. Perez Alvarez³ Data ³ 24/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR542                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
Static Function Somalinha()

Li++
If Li > 58
	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	lNewPage := .T.
Else
	lNewPage := .F.
EndIf

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTIMCFEM ³ Autor ³ Andre Perez Alvarez   ³ Data ³ 13/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz o calculo da massa atraves dos campos peso e altura,   ³±±
±±³          ³ e contabiliza para as mulheres.                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MDTIMCFEM()

Local aArea := TMT->(GetArea())
Local nIMC

If Empty(TMT->TMT_PESO) .OR. Empty(TMT->TMT_ALTURA)  //Pessoa sem o peso e altura especificados
	TRB->PESO9 ++
	TRB->PESO9M ++
	Return .T.
Endif

nIMC := TMT->TMT_PESO / (TMT->TMT_ALTURA*TMT->TMT_ALTURA)

If nIMC >= 00.0 .and. nIMC < 16.0  //"MAGREZA SEVERA"
	TRB->PESO1 ++
	TRB->PESO1M ++
ElseIf nIMC >= 16.0 .and. nIMC < 17.0  //"MAGREZA MODERADA"
	TRB->PESO2 ++
	TRB->PESO2M ++
ElseIf nIMC >= 17.0 .and. nIMC < 18.5  //"MAGREZA LEVE"
	TRB->PESO3 ++
	TRB->PESO3M ++
ElseIf nIMC >= 18.5 .and. nIMC < 25.0  //"PESO SAUDAVEL"
	TRB->PESO4 ++
	TRB->PESO4M ++
ElseIf nIMC >= 25.0 .and. nIMC < 30.0  //"PRE OBESIDADE"
	TRB->PESO5 ++
	TRB->PESO5M ++
ElseIf nIMC >= 30.0 .and. nIMC < 35.0  //"OBESIDADE GRAU 1"
	TRB->PESO6 ++
	TRB->PESO6M ++
ElseIf nIMC >= 35.0 .and. nIMC < 40.0  //"OBESIDADE GRAU 2"
	TRB->PESO7 ++
	TRB->PESO7M ++
ElseIf nIMC >= 40.0 .and. nIMC < 99.9  //"OBESIDADE GRAU 3"
	TRB->PESO8 ++
	TRB->PESO8M ++
Endif

RestArea(aArea)

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTIMCMASC³ Autor ³ Andre Perez Alvarez   ³ Data ³ 13/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz o calculo da massa atraves dos campos peso e altura,   ³±±
±±³          ³ e contabiliza para os homens.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MDTIMCMASC()

	Local aArea := TMT->(GetArea()	)
	Local nIMC

	If Empty(TMT->TMT_PESO) .OR. Empty(TMT->TMT_ALTURA)  //Pessoa sem o peso e altura especificados
		TRB->PESO9 ++
		TRB->PESO9H ++
		Return .T.
	Endif

	nIMC := TMT->TMT_PESO / (TMT->TMT_ALTURA*TMT->TMT_ALTURA)

	If nIMC >= 00.0 .and. nIMC < 16.0  //"MAGREZA SEVERA"
		TRB->PESO1 ++
		TRB->PESO1H ++
	ElseIf nIMC >= 16.0 .and. nIMC < 17.0  //"MAGREZA MODERADA"
		TRB->PESO2 ++
		TRB->PESO2H ++
	ElseIf nIMC >= 17.0 .and. nIMC < 18.5  //"MAGREZA LEVE"
		TRB->PESO3 ++
		TRB->PESO3H ++
	ElseIf nIMC >= 18.5 .and. nIMC < 25.0  //"PESO SAUDAVEL"
		TRB->PESO4 ++
		TRB->PESO4H ++
	ElseIf nIMC >= 25.0 .and. nIMC < 30.0  //"PRE OBESIDADE"
		TRB->PESO5 ++
		TRB->PESO5H ++
	ElseIf nIMC >= 30.0 .and. nIMC < 35.0  //"OBESIDADE GRAU 1"
		TRB->PESO6 ++
		TRB->PESO6H ++
	ElseIf nIMC >= 35.0 .and. nIMC < 40.0  //"OBESIDADE GRAU 2"
		TRB->PESO7 ++
		TRB->PESO7H ++
	ElseIf nIMC >= 40.0 .and. nIMC < 99.9  //"OBESIDADE GRAU 3"
		TRB->PESO8 ++
		TRB->PESO8H ++
	Endif

	RestArea(aArea)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTPREFEM
Faz o calculo do nivel de pressao.

@sample U_MDTPREFEM()

@author Andre Perez Alvarez
@since 13/11/07
/*/
//---------------------------------------------------------------------
User Function MDTPREFEM()

	//Classificação da Pressão Arterial, segundo o III Consenso Brasileiro de Hipertensão Arterial

	Local xSistolica   //Pressão Sistólica
	Local xDiastolica  //Pressão Diastólica
	Local nPos

	xSistolica := TMT->TMT_PRESIS
	xDiastolica:= TMT->TMT_PREDIS

	If xSistolica == 0 .Or. xDiastolica == 0
		Return
	EndIf

	If (xSistolica < 130) .AND. (xDiastolica < 85)
		//Pressão normal
		TRB->PRESS1  ++
		TRB->PRESS1M ++
	ElseIf (xSistolica >= 130 .AND. xSistolica <= 139) .AND. (xDiastolica >= 85 .AND. xDiastolica <= 89)
		//Pressão normal limítrofe
		TRB->PRESS2  ++
		TRB->PRESS2M ++
	ElseIf (xSistolica >= 140 .AND. xSistolica <= 159) .AND. (xDiastolica >= 90 .AND. xDiastolica <= 99)
		//Hipertensão leve (estágio 1)
		TRB->PRESS3  ++
		TRB->PRESS3M ++
	ElseIf (xSistolica >= 160 .AND. xSistolica <= 179) .AND. (xDiastolica >= 100 .AND. xDiastolica <= 109)
		//Hipertensão moderada (estágio 2)
		TRB->PRESS4  ++
		TRB->PRESS4M ++
	ElseIf (xSistolica >= 180 .AND. xSistolica <= 209) .AND. (xDiastolica >= 110 .AND. xDiastolica <= 119)
		//Hipertensão severa (estágio 3)
		TRB->PRESS5  ++
		TRB->PRESS5M ++
	ElseIf (xSistolica >= 210) .AND. (xDiastolica >= 120)
		//Hipertensão muito severa (4)
		TRB->PRESS6  ++
		TRB->PRESS6M ++
	ElseIf (xSistolica > 140) .AND. (xDiastolica < 90)
		//Hipertensão sistólica isolada
		TRB->PRESS7  ++
		TRB->PRESS7M ++
	Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTPREMASC
Faz o calculo do nivel de pressao.

@sample U_MDTPREMASC()

@author Andre Perez Alvarez
@since 13/11/07
/*/
//---------------------------------------------------------------------
User Function MDTPREMASC()

	//Classificação da Pressão Arterial, segundo o III Consenso Brasileiro de Hipertensão Arterial

	Local xSistolica   //Pressão Sistólica
	Local xDiastolica  //Pressão Diastólica

	xSistolica := TMT->TMT_PRESIS
	xDiastolica:= TMT->TMT_PREDIS

	If xSistolica == 0 .Or. xDiastolica == 0
		Return
	EndIf

	If (xSistolica < 130) .AND. (xDiastolica < 85)
		//Pressão normal
		TRB->PRESS1  ++
		TRB->PRESS1H ++
	ElseIf (xSistolica >= 130 .AND. xSistolica <= 139) .AND. (xDiastolica >= 85 .AND. xDiastolica <= 89)
		//Pressão normal limítrofe
		TRB->PRESS2  ++
		TRB->PRESS2H ++
	ElseIf (xSistolica >= 140 .AND. xSistolica <= 159) .AND. (xDiastolica >= 90 .AND. xDiastolica <= 99)
		//Hipertensão leve (estágio 1)
		TRB->PRESS3  ++
		TRB->PRESS3H ++
	ElseIf (xSistolica >= 160 .AND. xSistolica <= 179) .AND. (xDiastolica >= 100 .AND. xDiastolica <= 109)
		//Hipertensão moderada (estágio 2)
		TRB->PRESS4  ++
		TRB->PRESS4H ++
	ElseIf (xSistolica >= 180 .AND. xSistolica <= 209) .AND. (xDiastolica >= 110 .AND. xDiastolica <= 119)
		//Hipertensão severa (estágio 3)
		TRB->PRESS5  ++
		TRB->PRESS5H ++
	ElseIf (xSistolica >= 210) .AND. (xDiastolica >= 120)
		//Hipertensão muito severa (4)
		TRB->PRESS6  ++
		TRB->PRESS6H ++
	ElseIf (xSistolica > 140) .AND. (xDiastolica < 90)
		//Hipertensão sistólica isolada
		TRB->PRESS7  ++
		TRB->PRESS7H ++
	EndIf

Return .T.
