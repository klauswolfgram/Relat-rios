/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr560.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR560  ³ Autor ³ Denis Hyroshi de Souza³ Data ³ 14/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio para imprimir os Exames relacionados aos riscos,  ³±±
±±³          ³que foram filtrados dentro dos parametros informados pelo   ³±±
±±³          ³Usuario.                          						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR560(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR560()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM( )

Local oReport
Local aArea := GetArea()
Local nTamGrupExa := 0

lSigaMdtPS := SuperGetMv("MV_MDTPS",.F.,"N") == "S"

cPerg    := PADR( If(lSigaMdtPS,"MDT560PS","MDT560") , 10 )

cAliasCC := "SI3"
cCodCC   := "SI3->I3_CUSTO"
cDescCC2 := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cCodCC   := "CTT->CTT_CUSTO"
	cDescCC2 := "CTT->CTT_DESC01"
Endif

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*----------------------------------
//PERGUNTAS PADRÃO					|
| 01  De Risco ?      				|
| 02  Ate Risco ?     				|
| 03  De Exame ?      				|
| 04  Ate Exame ?    				|
|										|
//PERGUNTAS PRESTADOR DE SERVIÇO	|
| 01  De Cliente ?            		|
| 02  Loja                    		|
| 03  Até Cliente ?           		|
| 04  Loja	                  		|
| 05  De Risco ?              		|
| 06  Ate Risco ?             		|
| 07  De Exame ?              		|
| 08  Ate Exame ?             		|
------------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adicionando as perguntas relacionadas a Exames ao grupo de   ³
//³ campos 048 - "Exame".                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If TRepInUse()
   	//-- Interface de impressao
   	oReport := ReportDef()
	oReport:SetLandscape()
	oReport:PrintDialog()

Else
   U_MDTR560R3()
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
±±³Fun‡…o    ³ ReportDef³ Autor ³Andre E. Perez Alvarez ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Define as secoes impressas no relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR550                                                    ³±±
±±|__________|____________________________________________________________|±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function ReportDef()

Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])

Static oReport

Static oSection0
Static oSection1
Static oSection2

Static oCell

//LAYOUT
/*        1         2         3         4         5         6         7         8         9       100       110       120       130
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________

                                                       Exames por Risco
____________________________________________________________________________________________________________________________________

No. Risco     Agente                        Centro de Custo                    Funcao                         Tarefa
________________________________________________________________________________________________________________________________
xxxxxxxxx     xxxxx  xxxxxxxxxxxxxxxxxxxxx  xxxxxxx  xxxxxxxxxxxxxxxxxxxxxxx   xxxx  xxxxxxxxxxxxx            xxxx  xxxxxxxxxxxx

Exame    Descricao
_________________________________________________

123456   1234567890123456789012345678901234567890
123456   1234567890123456789012345678901234567890
123456   1234567890123456789012345678901234567890
123456   1234567890123456789012345678901234567890

*/

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
oReport := TReport():New("MDTR560",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint()},;  //"Exames por Risco"
           STR0001+" "+STR0002+" "+STR0003)
oReport:lDisableOrientation := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De Risco                             ³
//³ mv_par02             // Ate Risco                            ³
//³ mv_par03             // De Epi                               ³
//³ mv_par04             // Ate Epi                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
	//********************* Secao 0 - Cliente
	oSection0 := TRSection():New (oReport,STR0024, {"SA1"} )  //"Cliente"
	oCell := TRCell():New(oSection0, "A1_COD" , "SA1", STR0024, "@!", nTa1 )   //"Cliente"
	oCell := TRCell():New(oSection0, "A1_LOJA", "SA1", STR0017, "@!", nTa1L, /*lPixel*/, /*{|| xx }*/ ) //"Loja"
	oCell := TRCell():New(oSection0, "A1_NOME", "SA1", STR0025, "@!", 40, /*lPixel*/, /*{|| xx }*/  ) //"Nome"
	TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TN0->TN0_CODCLI+TN0->TN0_LOJACL} )
Endif

//********************* Secao 1 - Risco
oSection1 := TRSection():New (oReport,"Risco", {"TN0"} )
oCell := TRCell():New(oSection1, "TN0_NUMRIS"    , "TN0" , STR0009, "@!", 12  )  //"No. Risco"
oCell := TRCell():New(oSection1, "cAgente"       ,       , STR0010, "@!", 47, /*lPixel*/, {|| Posic0() }  ) //"Agente"
oCell := TRCell():New(oSection1, "cCCusto"       ,       , STR0011, "@!", 50, /*lPixel*/, {|| Posic1() }  ) //"Centro de Custo"
oCell := TRCell():New(oSection1, "cFuncao"       ,       , STR0012, "@!", 40, /*lPixel*/, {|| Posic2() }  ) //"Função"
oCell := TRCell():New(oSection1, "cTarefa"       ,       , STR0013, "@!", 46, /*lPixel*/, {|| Posic3() }  ) //"Tarefa"
If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
	oCell := TRCell():New(oSection1, "cDepto"        ,       , STR0033, "@!", 46, /*lPixel*/, {|| Posic4() }  ) //"Departamento"
EndIf

//********************* Secao 2 - Exame
oSection2 := TRSection():New (oReport,"Exame", {"TN2","TM4"} )
oCell := TRCell():New (oSection2, "TN2_EXAME" , "TN2", STR0014, "@!", nTamExa, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Exame"
oCell := TRCell():New (oSection2, "TM4_NOMEXA", "TM4", STR0015, "@!", 40, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Nome do Exame"
TRPosition():New (oSection2, "TM4", 1, {|| xFilial("TM4") + TN2->TN2_EXAME} )

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Posic0     ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o codigo do agente e descricao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Posic0()

Local cDesc := ""

DbselectArea("TMA")
DbSetOrder(01)
If Dbseek( xFilial("TMA") + TN0->TN0_AGENTE )
	cDesc := TMA->TMA_AGENTE + Space(1) + TMA->TMA_NOMAGE
Endif

Return cDesc
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Posic1     ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o codigo do centro de custo e descricao.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Posic1()

Local cDesc := ""

If AllTrim(TN0->TN0_CC) $ "*"
	cDesc := "*" + Space(4) + STR0026  //"Todos"
Else
	DbselectArea(cAliasCC)
	DbSetOrder(01)
	If Dbseek( xFilial(cAliasCC) + TN0->TN0_CC )
		cDesc := &(cCodCC) + Space(1) + &(cDescCC2)
	Endif
Endif

Return cDesc
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Posic2     ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o codigo da funcao e descricao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Posic2()

Local cDesc := ""

If AllTrim(TN0->TN0_CODFUN) $ "*"
	cDesc := "*" + Space(4) + STR0027  //"Todas"
Else
	DbselectArea("SRJ")
	DbSetOrder(01)
	If Dbseek( xFilial("SRJ") + TN0->TN0_CODFUN )
		cDesc := SRJ->RJ_FUNCAO + Space(1) + SRJ->RJ_DESC
	Endif
Endif

Return cDesc
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Posic3     ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o codigo da tarefa e descricao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Posic3()

Local cDesc := ""

If AllTrim(TN0->TN0_CODTAR) $ "*"
	cDesc := "*" + Space(4) + STR0027  //"Todas"
Else
	If lSigaMdtps
		DbselectArea("TN5")
		DbSetOrder(03)
		If Dbseek( xFilial("TN5") + TN0->(TN0_CODCLI+TN0_LOJACL) + TN0->TN0_CODTAR )
			cDesc := TN5->TN5_CODTAR + Space(1) + SubStr(TN5->TN5_NOMTAR,1,40)
		Endif
	Else
		DbselectArea("TN5")
		DbSetOrder(01)
		If Dbseek( xFilial("TN5") + TN0->TN0_CODTAR )
			cDesc := TN5->TN5_CODTAR + Space(1) + SubStr(TN5->TN5_NOMTAR,1,40)
		Endif
	Endif
Endif

Return cDesc
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Posic4     ³ Autor ³ Jackson Machado       ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o codigo do centro de custo e descricao.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Posic4()

Local cDesc := ""

If AllTrim(TN0->TN0_DEPTO) == "*"
	cDesc := "*" + Space(4) + STR0026  //"Todos"
Else
	DbselectArea("SQB")
	DbSetOrder(01)
	If Dbseek( xFilial("SQB") + TN0->TN0_DEPTO )
		cDesc := AllTrim(SQB->QB_DEPTO) + Space(1) + AllTrim( SubStr( SQB->QB_DESCRIC,1,25 ) )
	Endif
Endif

Return cDesc
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ReportPrint³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime o relatorio.                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function ReportPrint()

Local lPrint := .T.
Local lEntrou := .f.

If lSigaMdtps

	DbSelectArea("TN0")
	DbSetOrder(08)   //TN0_FILIAL+TN0_CODCLI+TN0_LOJACL+TN0_NUMRIS
	DbSeek(xFilial("TN0")+mv_par01+mv_par02,.t.)
	oReport:SetMeter(LastRec())

	While !oReport:Cancel()	  				  .AND.;
		  !Eof() 	                          .AND.;
		  xFilial("TN0") == TN0->TN0_FILIAL   .AND.;
		  TN0->(TN0_CODCLI+TN0_LOJACL) <= mv_par03+mv_par04

		oReport:IncMeter()

		cCliente := TN0->(TN0_CODCLI+TN0_LOJACL)
		lPrint0  := .t.
		While !oReport:Cancel()	  				  .AND.;
			  !Eof() 	                          .AND.;
			  xFilial("TN0") == TN0->TN0_FILIAL   .AND.;
			  cCliente == TN0->(TN0_CODCLI+TN0_LOJACL)

			If TN0->TN0_NUMRIS < mv_par05 .or. TN0->TN0_NUMRIS > mv_par06
				dbSkip()
				Loop
			Endif

			Dbselectarea("TN2")
			Dbsetorder(5)
			If !Dbseek(xFilial("TN2")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_NUMRIS)   //Se o risco nao esta relacionado a nenhum exame
				DbSelectArea("TN0")
				DbSkip()
				Loop
			Endif

			lPrint := .T.
			While !oReport:Cancel()	  				  .AND.;
			  	  !Eof() 	                          .AND.;
			  	  xFilial("TN2") == TN2->TN2_FILIAL	  .AND.;
			  	  TN2->TN2_NUMRIS == TN0->TN0_NUMRIS  .AND.;
			  	  TN0->(TN0_CODCLI+TN0_LOJACL) == TN2->(TN2_CLIENT+TN2_LOJA)

				If TN2->TN2_EXAME < mv_par07 .or. TN2->TN2_EXAME > mv_par08
					Dbselectarea("TN2")
					Dbskip()
					Loop
				Endif

				If lPrint0
					oSection0:Init()
					oSection0:PrintLine()
					lPrint0 := .F.
					lEntrou := .t.
				Endif
				If lPrint
					oSection1:Init()
					oSection1:PrintLine()
					oSection2:Init()
					lPrint := .F.
				Endif

				oSection2:PrintLine()

				DbSelectArea("TN2")
				Dbskip()
			End
			If !lPrint
				oSection2:Finish()
				oSection1:Finish()
			Endif

			DbSelectArea("TN0")
			Dbskip()
		End
		If !lPrint0
			oSection0:Finish()
		Endif

	End

Else

	DbSelectArea("TN0")
	DbSetOrder(01)
	DbSeek(xFilial("TN0")+mv_par01,.t.)
	oReport:SetMeter(LastRec())

	While !oReport:Cancel()	  				  .AND.;
		  !Eof() 	                          .AND.;
		  xFilial("TN0") == TN0->TN0_FILIAL  .AND.;
		  TN0->TN0_NUMRIS <= mv_par02

		oReport:IncMeter()

		Dbselectarea("TN2")
		Dbsetorder(1)
		If !Dbseek(xFilial("TN2")+TN0->TN0_NUMRIS) //Se o risco nao esta relacionado a nenhum exame
			DbSelectArea("TN0")
			DbSkip()
			Loop
		Endif

		lPrint := .T.
		While !oReport:Cancel()	  				  .AND.;
		  	  !Eof() 	                          .AND.;
		  	  xFilial("TN2") == TN2->TN2_FILIAL	  .AND.;
		  	  TN2->TN2_NUMRIS == TN0->TN0_NUMRIS

			If TN2->TN2_EXAME < mv_par03 .or. TN2->TN2_EXAME > mv_par04
				Dbselectarea("TN2")
				Dbskip()
				Loop
			Endif

			If lPrint
				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()
				lPrint := .F.
				lEntrou := .t.
			Endif

			oSection2:PrintLine()

			DbSelectArea("TN2")
			Dbskip()
		End
		If !lPrint
			oSection2:Finish()
			oSection1:Finish()
		Endif

		DbSelectArea("TN0")
		Dbskip()
	End

Endif

If !lEntrou
	MsgInfo(STR0023)  //"Não há nada para imprimir no relatório."
	Return .F.
Endif

Return .T.

//***************************************************************************
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR560R3³ Autor ³ Denis Hyroshi de Souza³ Data ³ 14/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Chamada do relatorio (realese 3)                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR560                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR560R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cString := "TN0"
LOCAL wnrel   := "MDTR560"
LOCAL cDesc1  := STR0001 //"Relatorio para imprimir os Exames relacionados aos riscos."
LOCAL cDesc2  := STR0002 //"Esses riscos serao filtrados atraves dos parametros informados pelo"
LOCAL cDesc3  := STR0003 //"Usuario."
Local lDepto  := NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )

PRIVATE aReturn  := { STR0004, 1, STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE nomeprog := "MDTR560"
PRIVATE tamanho  := "G"
PRIVATE titulo   := STR0006 //"Exames por Risco"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
//"No. Risco  Agente                       Centro de Custo                           Funcao                    Tarefa                     Departamento"
PRIVATE cabec1   := PADR( STR0009 , 9 ) + Space(2) +;
					PADR( STR0010 , 6 ) + Space(23) +;
					PADR( STR0011 , 15 ) + Space(19) +;
					PADR( STR0012 , 6 ) + Space(21) +;
					PADR( STR0013 , 6 ) +;
					If(lDepto,Space(21) + PADR( STR0033 , 12 ),"")
PRIVATE cabec2   := " "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De Risco                             ³
//³ mv_par02             // Ate Risco                            ³
//³ mv_par03             // De Epi                               ³
//³ mv_par04             // Ate Epi                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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

RptStatus({|lEnd| R560Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R560Imp  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 14/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR560                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R560Imp(lEnd,wnRel,titulo,tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cRodaTxt  := ""
Local nCntImpr  := 0
lEntrou := .f.

Private li := 80 ,m_pag := 1 ,nQtTotFunc  := 0 ,lPRINT := .f., lJump := .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

If lSigaMdtps

	DbSelectArea("TN0")
	DbSetOrder(08)   //TN0_FILIAL+TN0_CODCLI+TN0_LOJACL+TN0_NUMRIS
	DbSeek(xFilial("TN0")+mv_par01+mv_par02,.t.)
	SetRegua(LastRec())
	While !Eof() .and. xFilial("TN0") == TN0->TN0_FILIAL .and. TN0->(TN0_CODCLI+TN0_LOJACL) <= mv_par03+mv_par04

		IncRegua()

		cCliente := TN0->(TN0_CODCLI+TN0_LOJACL)
		lPrint0 := .t.
		While !Eof() .and. cCliente == TN0->(TN0_CODCLI+TN0_LOJACL)

			If TN0->TN0_NUMRIS < mv_par05 .or. TN0->TN0_NUMRIS > mv_par06
				Dbskip()
				Loop
			Endif

			lPrint := .t.

			Dbselectarea("TN2")
			Dbsetorder(5)  //"TN2_FILIAL+TN2_CLIENT+TN2_LOJA+TN2_NUMRIS+TN2_EXAME+TN2_FAIXA"
			Dbseek(xFilial("TN2")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_NUMRIS)
			While !Eof() .and. xFilial("TN2") == TN2->TN2_FILIAL .and. TN2->TN2_NUMRIS = TN0->TN0_NUMRIS .AND. TN0->(TN0_CODCLI+TN0_LOJACL) = TN2->(TN2_CLIENT+TN2_LOJA)

				If TN2->TN2_EXAME < mv_par07 .or. TN2->TN2_EXAME > mv_par08
					Dbselectarea("TN2")
					Dbskip()
					Loop
				Endif
				Somalinha()
				If lPrint0
					U_MDTR560CLI()
					lPrint0 := .f.
					lEntrou := .t.
				Endif
				If lPrint
					U_MDTR560CABEC()
					lPrint := .f.
				Endif
				Dbselectarea("TM4") // Tabela de Exame
				Dbsetorder(1)
				Dbseek(xFilial("TM4")+TN2->TN2_EXAME)
				@Li,013 Psay Alltrim(TN2->TN2_EXAME)+" - "+SubStr(TM4->TM4_NOMEXA,1,40)

				DbSelectArea("TN2")
				Dbskip()
			End

			DbSelectArea("TN0")
			Dbskip()
		End

	End

Else

	DbSelectArea("TN0")
	DbSetOrder(01)
	DbSeek(xFilial("TN0")+mv_par01,.t.)
	SetRegua(LastRec())
	While !Eof() .and. xFilial("TN0") == TN0->TN0_FILIAL .and. TN0->TN0_NUMRIS <= mv_par02

		IncRegua()
		lPrint := .t.

		Dbselectarea("TN2")
		Dbsetorder(1)
		Dbseek(xFilial("TN2")+TN0->TN0_NUMRIS)
		While !Eof() .and. xFilial("TN2") == TN2->TN2_FILIAL .and. TN2->TN2_NUMRIS = TN0->TN0_NUMRIS

			If TN2->TN2_EXAME < mv_par03 .or. TN2->TN2_EXAME > mv_par04
				Dbselectarea("TN2")
				Dbskip()
				Loop
			Endif
			Somalinha()
			If lPrint
				U_MDTR560CABEC()
				lPrint := .f.
				lEntrou := .t.
			Endif
			Dbselectarea("TM4") // Tabela de Exame
			Dbsetorder(1)
			Dbseek(xFilial("TM4")+TN2->TN2_EXAME)
			@Li,013 Psay Alltrim(TN2->TN2_EXAME)+" - "+SubStr(TM4->TM4_NOMEXA,1,40)

			DbSelectArea("TN2")
			Dbskip()
		End
		DbSelectArea("TN0")
		Dbskip()
	End

Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !lEntrou
	RetIndex("TN0")
	Set Filter To
	MsgInfo(STR0023)  //"Não há nada para imprimir no relatório."
	Return .F.
Endif

RetIndex("TN0")
Set Filter To
Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()
dbSelectArea("TN0")
dbSetOrder(01)

Return NIL
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   |Somalinha()³ Autor³Denis Hyroshi de Souza ³ Data  ³ 14/02/03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR560                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o |MDTR560CABEC³ Autor³Denis Hyroshi de Souza³ Data  ³14/02/03³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…³ Imprime registro do Risco                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
User Function MDTR560CABEC()
Local lDepto := NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
Dbselectarea("TMA") // Tabela do Agente
Dbsetorder(1)
Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)
Dbselectarea(cAliasCC) // Tabela do Centro de Custo
Dbsetorder(1)
Dbseek(xFilial(cAliasCC)+TN0->TN0_CC)
Dbselectarea("SRJ") // Tabela da Funcao
Dbsetorder(1)
Dbseek(xFilial("SRJ")+TN0->TN0_CODFUN)
If lDepto
	dbSelectArea("SQB")
	dbSetOrder(1)
	dbSeek( xFilial( "SQB" ) + TN0->TN0_DEPTO )
EndIf
If lSigaMdtps
	Dbselectarea("TN5") // Tabela da Tarefa
	Dbsetorder(3)   //TN5_FILIAL+TN5_CLIENT+TN5_LOJA+TN5_CODTAR
	Dbseek(xFilial("TN5")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_CODTAR)
Else
	Dbselectarea("TN5") // Tabela da Tarefa
	Dbsetorder(1)
	Dbseek(xFilial("TN5")+TN0->TN0_CODTAR)
Endif
If lJump
	Somalinha()
Endif
lJump := .t.
@Li,000 Psay TN0->TN0_NUMRIS
@Li,011 Psay TN0->TN0_AGENTE
@Li,018 Psay Substr(TMA->TMA_NOMAGE,1,20)
@Li,040 Psay Alltrim(TN0->TN0_CC) + " " + If(Alltrim(TN0->TN0_CC)=="*",STR0026,Substr(&cDescCC2,1,20)) //"Todos"

@Li,074 Psay TN0->TN0_CODFUN
@Li,080 Psay If(Alltrim(TN0->TN0_CODFUN)=="*",STR0027,Substr(SRJ->RJ_DESC,1,17)) //"Todas"
@Li,101 Psay TN0->TN0_CODTAR
@Li,108 Psay If(Alltrim(TN0->TN0_CODTAR)=="*",STR0027,Substr(TN5->TN5_NOMTAR,1,17)) //"Todas"
If lDepto
	@Li,128 Psay TN0->TN0_DEPTO
	@Li,138 Psay If(Alltrim(TN0->TN0_DEPTO)=="*",STR0026,Substr(SQB->QB_DESCRIC,1,17))  //"Todos"
EndIf

Somalinha()
@Li,004 Psay STR0008 //"Exames.:"
Return
/*        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
No. Risco  Agente                       Centro de Custo                   Funcao                     Tarefa                     Departamento
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

000000001  123456 12345678901234567890  123456789 12345678901234567890    12345 12345678901234567    123456 12345678901234567   123456789 12345678901234567
	Exames.: NR7 - AVALIACAO CLINICA
		     001 - AUDIOMETRIA
		     002 - RAIO-X

000000002  123456 12345678901234567890  12345678901234567890 12345678901234567890 12345 12345678901234567  123456 12345678901234567
	Exames.: NR7 - AVALIACAO CLINICA
		     004 - TOMOGRAFIA COMPUTADORIZADA

*/
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o |MDTR560CLI³  Autor³ Andre E. Perez Alvarez³ Data  ³06/05/08³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…³ Imprime cabeçalho do cliente.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
User Function MDTR560CLI()

If lEntrou
	@Li,000 Psay Replicate("-",132)
	SomaLinha()
Endif

@Li,000 Psay STR0028 + AllTrim(TN0->TN0_CODCLI) +"-"+ AllTrim(TN0->TN0_LOJACL) + " - " + NGSEEK("SA1",TN0->TN0_CODCLI+TN0->TN0_LOJACL,1,"SA1->A1_NOME")  //"Cliente/Loja: "
SomaLinha()

If !lEntrou
	SomaLinha()
Endif

Return .T.
