/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr550.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 3 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR550  ³ Autor ³ Denis Hyroshi de Souza³ Data ³ 14/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio para imprimir os Epi's relacionados aos riscos,   ³±±
±±³          ³que foram filtrados dentro dos parametros informados pelo   ³±±
±±³          ³Usuario.                          						        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR550(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR550()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

Local oReport 
Local aArea := GetArea()  
Private cPerg := ""

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

cPerg    := If(!lSigaMdtPS,"MDT550    ","MDT550PS  ")   

/*----------------------------------
//PERGUNTAS PADRÃO					|
| MDT550    ¦01      ¦De Risco ?	|
| MDT550    ¦02      ¦Ate Risco ?	|
| MDT550    ¦03      ¦De Epi ?		|
| MDT550    ¦04      ¦Ate Epi ?		|
|										|
//PERGUNTAS PRESTADOR DE SERVIÇO	|
| 01      De Cliente ?				|
| 02      Loja						|
| 03      Até Cliente ?				|
| 04      Loja						|
| 05      De Risco ?					|
| 06      Ate Risco ?				|
| 07      De Epi ?					|
| 08      Ate Epi ?					|
----------------------------------*/

If TRepInUse()
   	//-- Interface de impressao
  	oReport := ReportDef()
  	oReport:SetPortrait()
	oReport:PrintDialog()
Else
   U_MDTR550R3()
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

Static oReport

Static oSection0
Static oSection1
Static oSection2

Static oCell

Static cAliasCC := "SI3"   
Static cCodCC   := "I3_CUSTO"
Static cDescCC  := "SI3->I3_DESC"

//Verifica se o modulo contabil esta disponivel
If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cCodCC   := "CTT_CUSTO"
	cDescCC  := "CTT->CTT_DESC01"
Endif

//LAYOUT
/*        1         2         3         4         5         6         7         8         9       100       110       120       130 
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________
                                                       
                                                       Epi's por Risco                  
____________________________________________________________________________________________________________________________________

No. Risco     Agente                        Centro de Custo                    Funcao                         Tarefa
________________________________________________________________________________________________________________________________
xxxxxxxxx     xxxxx  xxxxxxxxxxxxxxxxxxxxx  xxxxxxx  xxxxxxxxxxxxxxxxxxxxxxx   xxxx  xxxxxxxxxxxxx            xxxx  xxxxxxxxxxxx

Epi      Descricao
______________________________________________________________________

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
oReport := TReport():New("MDTR550",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint()},;  //"Epi's por Risco"
           STR0001+" "+STR0002+" "+STR0003)

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
	oSection0 := TRSection():New (oReport,"Cliente/Loja", {"TN0","SA1"} ) 
	oCell := TRCell():New(oSection0, "A1_COD"        , "SA1" , STR0019, "@!", nTa1  )   //"Cliente"
	oCell := TRCell():New(oSection0, "A1_LOJA"       , "SA1" , STR0020, "@!", nTa1L  )   //"Loja"
	oCell := TRCell():New(oSection0, "A1_NOME"       , "SA1" , STR0021, "@!", 40 )   //"Nome"
	TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TN0->TN0_CODCLI+TN0->TN0_LOJACL} )  
	
	//********************* Secao 1 - Risco
	oSection1 := TRSection():New (oReport,"Risco", {"TN0"} ) 
	oCell := TRCell():New(oSection1, "TN0_NUMRIS"    , "TN0" , STR0009, "@!", 11  )  //"No. Risco"     
	oCell := TRCell():New(oSection1, "cAgente"       ,       , STR0010, "@!", 35, /*lPixel*/, {|| Posic0() }  ) //"Agente"     
	oCell := TRCell():New(oSection1, "cCCusto"       ,       , STR0011, "@!", 55, /*lPixel*/, {|| Posic1() }  ) //"Centro de Custo"     
	oCell := TRCell():New(oSection1, "cFuncao"       ,       , STR0012, "@!", 30, /*lPixel*/, {|| Posic2() }  ) //"Função"     
	oCell := TRCell():New(oSection1, "cTarefa"       ,       , STR0013, "@!", 35, /*lPixel*/, {|| Posic3() }  ) //"Tarefa" 	    

Else

	//********************* Secao 1 - Risco
	oSection1 := TRSection():New (oReport,"Risco", {"TN0"} ) 
	oCell := TRCell():New(oSection1, "TN0_NUMRIS"    , "TN0" , STR0009, "@!", 11  )  //"No. Risco"     
	oCell := TRCell():New(oSection1, "cAgente"       ,       , STR0010, "@!", 35, /*lPixel*/, {|| Posic0() }  ) //"Agente"     
	oCell := TRCell():New(oSection1, "cCCusto"       ,       , STR0011, "@!", 44, /*lPixel*/, {|| Posic1() }  ) //"Centro de Custo"     
	oCell := TRCell():New(oSection1, "cFuncao"       ,       , STR0012, "@!", 30, /*lPixel*/, {|| Posic2() }  ) //"Função"     
	oCell := TRCell():New(oSection1, "cTarefa"       ,       , STR0013, "@!", 35, /*lPixel*/, {|| Posic3() }  ) //"Tarefa"     
	If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
		oCell := TRCell():New(oSection1, "cDepto"       ,       , STR0030, "@!", 35, /*lPixel*/, {|| Posic4() }  ) //"Departamento"     
	EndIf
	      
Endif
           
//********************* Secao 2 - Epi
oSection2 := TRSection():New (oReport,"EPI", {"TNX","SB1"} )
oCell := TRCell():New (oSection2, "TNX_EPI"   , "TNX", STR0014, "@!", TAMSX3( "B1_COD" )[ 1 ] + 2, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"EPI"
oCell := TRCell():New (oSection2, "B1_DESC"   , "SB1", STR0015, "@!", 40, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Descricao"
TRPosition():New (oSection2, "SB1", 1, {|| xFilial("SB1") + TNX->TNX_EPI} )      

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
	cDesc := AllTrim(TMA->TMA_AGENTE) + Space(1) + AllTrim(SubStr(TMA->TMA_NOMAGE,1,25))
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
	cDesc := "*" + Space(4) + STR0022  //"Todos"
Else
	DbselectArea(cAliasCC)
	DbSetOrder(01)
	If Dbseek( xFilial(cAliasCC) + TN0->TN0_CC )
		cDesc := AllTrim(&(cCodCC)) + Space(1) + AllTrim( SubStr( &(cDescCC),1,25 ) )
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
	cDesc := "*" + Space(4) + STR0023  //"Todas"
Else
	DbselectArea("SRJ")
	DbSetOrder(01)
	If Dbseek( xFilial("SRJ") + TN0->TN0_CODFUN )
		cDesc := AllTrim(SRJ->RJ_FUNCAO) + Space(1) + AllTrim(SubSTR(SRJ->RJ_DESC,1,20))
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
	cDesc := "*" + Space(4) + STR0023  //"Todas"
Else
	DbselectArea("TN5")
	DbSetOrder(01)
	If Dbseek( xFilial("TN5") + TN0->TN0_CODTAR )
		cDesc := AllTrim(TN5->TN5_CODTAR) + Space(1) + AllTrim(SubStr(TN5->TN5_NOMTAR,1,25))
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

If AllTrim(TN0->TN0_DEPTO) $ "*"
	cDesc := "*" + Space(4) + STR0022  //"Todos"
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
Local lPrint0 := .T.
Local cCliente := ""

If lSigaMdtps

	DbSelectArea("TN0")
	DbSetOrder(08)  //TN0_FILIAL+TN0_CODCLI+TN0_LOJACL+TN0_NUMRIS
	DbSeek(xFilial("TN0")+mv_par01+mv_par02,.t.)
	oReport:SetMeter(LastRec()) 
	
	While !oReport:Cancel()	  				  .AND.;
		  !Eof() 	                          .AND.;
		  xFilial("TN0") == TN0->TN0_FILIAL	  .AND.; 
		  TN0->(TN0_CODCLI+TN0_LOJACL) >= mv_par01+mv_par02 .AND.;
		  TN0->(TN0_CODCLI+TN0_LOJACL) <= mv_par03+mv_par04
	
		oReport:IncMeter()                                 
				
		cCliente := TN0->(TN0_CODCLI+TN0_LOJACL)
		lPrint0 := .T.
		
		While !oReport:Cancel()	  				  .AND.;
			  !Eof() 	                          .AND.;
			  xFilial("TN0") == TN0->TN0_FILIAL	  .AND.; 
			  TN0->(TN0_CODCLI+TN0_LOJACL) == cCliente 
			  
			If TN0->TN0_NUMRIS < mv_par05 .OR. TN0->TN0_NUMRIS > mv_par06
				dbSkip()
				Loop
			Endif			  
			  
			Dbselectarea("TNX")
			Dbsetorder(1)
			If !Dbseek(xFilial("TNX")+TN0->TN0_NUMRIS)  //Se o risco esta relacionado a nennhum EPI
				DbSelectArea("TN0")
				DbSkip()
				Loop
			Endif
			
			lPrint := .T.
			While !oReport:Cancel()	  				  .AND.;
			  	  !Eof() 	                          .AND.;
			   	  xFilial("TNX") == TNX->TNX_FILIAL	  .AND.; 
			   	  TNX->TNX_NUMRIS = TN0->TN0_NUMRIS 
				
				If TNX->TNX_EPI < mv_par07 .or. TNX->TNX_EPI > mv_par08 
					Dbselectarea("TNX")
					Dbskip()
					Loop
				Endif    
				  
				If lPrint0
					oSection0:Init()
					oSection0:PrintLine()									
					lPrint0 := .F.
				Endif
				If lPrint                        
					oSection1:Init()
					oSection1:PrintLine()
					oSection2:Init()
					lPrint := .F.
				Endif       
				
				oSection2:PrintLine()
				
				DbSelectArea("TNX")
				Dbskip()
			End
			If !lPrint 
				oSection2:Finish()
				oSection1:Finish()
			Endif			
							
			dbSelectArea("TN0")
			dbSkip()
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
		  xFilial("TN0") == TN0->TN0_FILIAL	  .AND.; 
		  TN0->TN0_NUMRIS <= mv_par02   
	
		oReport:IncMeter()
		
		Dbselectarea("TNX")
		Dbsetorder(1)
		If !Dbseek(xFilial("TNX")+TN0->TN0_NUMRIS)  //Se o risco esta relacionado a nennhum EPI
			DbSelectArea("TN0")
			DbSkip()
			Loop	
		Endif
		
		lPrint := .T.
		While !oReport:Cancel()	  				  .AND.;
		  	  !Eof() 	                          .AND.;
		   	  xFilial("TNX") == TNX->TNX_FILIAL	  .AND.; 
		   	  TNX->TNX_NUMRIS = TN0->TN0_NUMRIS 
			
			If TNX->TNX_EPI < mv_par03 .or. TNX->TNX_EPI > mv_par04
				Dbselectarea("TNX")
				Dbskip()
				Loop
			Endif    
			  
			If lPrint                        
				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()
				lPrint := .F.
			Endif       
			
			oSection2:PrintLine()
			
			DbSelectArea("TNX")
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
	
Return .T.   




//***************************************************************************
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR550R3³ Autor ³ Denis Hyroshi de Souza³ Data ³ 14/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Chamada do relatorio (realese 3)                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR550                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR550R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cString := "TN0"
LOCAL wnrel   := "MDTR550"
LOCAL cDesc1  := STR0001 //"Relatorio para imprimir os Epi's relacionados aos riscos."
LOCAL cDesc2  := STR0002 //"Esses riscos serao filtrados atraves dos parametros informados pelo"
LOCAL cDesc3  := STR0003 //"Usuario."

PRIVATE aReturn  := { STR0004, 1, STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE nomeprog := "MDTR550"
PRIVATE tamanho  := "M"
PRIVATE titulo   := STR0006 //"Epi's por Risco"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1   := STR0031 //"No. Risco  Agente                       Centro de Custo                           Função                     Tarefa"
PRIVATE cabec2   := " "

If NGCADICBASE("TN0_DEPTO","A","TN0",.F.)
	cabec1   := STR0007//"No. Risco  Agente                       Centro de Custo                           Função                     Tarefa                     Departamento"
	tamanho  := "G"
EndIf

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

RptStatus({|lEnd| R550Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R550Imp  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 14/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR550                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R550Imp(lEnd,wnRel,titulo,tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cRodaTxt  := ""
Local nCntImpr  := 0 
Local lPrint0 := .T.
Local cCliente := ""          
Local lPri := .T.

Private li := 80 ,m_pag := 1 ,nQtTotFunc  := 0 ,lPRINT := .f., lJump := .f.
Private cAlias := "SI3"   
Private cDescr := "SI3->I3_DESC"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAlias := "CTT"
	cDescr := "CTT->CTT_DESC01"
Endif

If lSigaMdtps

	DbSelectArea("TN0")
	DbSetOrder(08)  //TN0_FILIAL+TN0_CODCLI+TN0_LOJACL+TN0_NUMRIS
	DbSeek(xFilial("TN0")+mv_par01+mv_par02,.t.)
	SetRegua(LastRec()) 

	While !Eof() 	                          .AND.;
		  xFilial("TN0") == TN0->TN0_FILIAL	  .AND.; 
		  TN0->(TN0_CODCLI+TN0_LOJACL) >= mv_par01+mv_par02 .AND.;
		  TN0->(TN0_CODCLI+TN0_LOJACL) <= mv_par03+mv_par04
	
		IncRegua()	
		
		cCliente := TN0->(TN0_CODCLI+TN0_LOJACL)
		lPrint0 := .T.
		
		While !Eof() 	                          .AND.;
			  xFilial("TN0") == TN0->TN0_FILIAL	  .AND.; 
			  TN0->(TN0_CODCLI+TN0_LOJACL) == cCliente 	
			  
			If TN0->TN0_NUMRIS < mv_par05 .OR. TN0->TN0_NUMRIS > mv_par06
				dbSkip()
				Loop
			Endif				  	
		
			lPrint := .t.
			
			Dbselectarea("TNX")
			Dbsetorder(1)
			Dbseek(xFilial("TNX")+TN0->TN0_NUMRIS)
			While !Eof() .and. xFilial("TNX") == TNX->TNX_FILIAL .and. TNX->TNX_NUMRIS = TN0->TN0_NUMRIS 
				
				If TNX->TNX_EPI < mv_par07 .or. TNX->TNX_EPI > mv_par08
					Dbselectarea("TNX")
					Dbskip()
					Loop
				Endif
				     
				Somalinha() 
				If lPrint0
					dbSelectArea("SA1")
					dbSetOrder(1)
					dbSeek(xFilial("SA1")+cCliente)
					//"Cliente/Loja: "  //
					If !lPri
						SomaLinha()
					Endif
					@Li,000 Psay STR0024 + SA1->A1_COD +"-"+ SA1->A1_LOJA +STR0025+ SA1->A1_NOME
					SomaLinha()
					SomaLinha()
					lPrint0 := .f.
					lPri := .f.
				Endif
				If lPrint                        
					U_MDTR550CABEC()
					lPrint := .f.
				Endif       
				
				Dbselectarea("SB1") // Tabela de Produto
				Dbsetorder(1)
				Dbseek(xFilial("SB1")+TNX->TNX_EPI)		
				@Li,013 Psay Alltrim(TNX->TNX_EPI)+" - "+SB1->B1_DESC
				
				DbSelectArea("TNX")
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
		
		Dbselectarea("TNX")
		Dbsetorder(1)
		Dbseek(xFilial("TNX")+TN0->TN0_NUMRIS)
		While !Eof() .and. xFilial("TNX") == TNX->TNX_FILIAL .and. TNX->TNX_NUMRIS = TN0->TN0_NUMRIS 
			
			If TNX->TNX_EPI < mv_par03 .or. TNX->TNX_EPI > mv_par04
				Dbselectarea("TNX")
				Dbskip()
				Loop
			Endif     
			Somalinha() 
			If lPrint                        
				U_MDTR550CABEC()
				lPrint := .f.
			Endif       
			Dbselectarea("SB1") // Tabela de Produto
			Dbsetorder(1)
			Dbseek(xFilial("SB1")+TNX->TNX_EPI)		
			@Li,013 Psay Alltrim(TNX->TNX_EPI)+" - "+SB1->B1_DESC
			
			DbSelectArea("TNX")
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
±±³ Uso      ³ MDTR550                                                    ³±±
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
±±³ Fun‡…o |MDTR550CABEC³ Autor³Denis Hyroshi de Souza³ Data  ³14/02/03³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…³ Imprime registro do Risco                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/      
User Function MDTR550CABEC()            

Dbselectarea("TMA") // Tabela do Agente
Dbsetorder(1)
Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)
Dbselectarea(cAlias) // Tabela do Centro de Custo
Dbsetorder(1)
Dbseek(xFilial(cAlias)+TN0->TN0_CC)
Dbselectarea("SRJ") // Tabela da Funcao
Dbsetorder(1)
Dbseek(xFilial("SRJ")+TN0->TN0_CODFUN)
Dbselectarea("TN5") // Tabela da Tarefa
Dbsetorder(1)
Dbseek(xFilial("TN5")+TN0->TN0_CODTAR)
If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
	dbSelectArea("SQB")
	dbSetOrder(1)
	dbSeek( xFilial( "SQB" ) + TN0->TN0_DEPTO )
EndIf

If !lSigaMdtps
	If lJump
		Somalinha()
	Endif          
	lJump := .t.
Endif
@Li,000 Psay TN0->TN0_NUMRIS
@Li,011 Psay TN0->TN0_AGENTE
@Li,018 Psay Substr(TMA->TMA_NOMAGE,1,20)
@Li,040 Psay Alltrim(TN0->TN0_CC) + " " + If(Alltrim(TN0->TN0_CC)=="*",STR0022,Substr(&cDescr,1,20))  //"Todos"

@Li,082 Psay TN0->TN0_CODFUN
@Li,089 Psay If(Alltrim(TN0->TN0_CODFUN)=="*",STR0023,Substr(SRJ->RJ_DESC,1,17))  //"Todas"
@Li,109 Psay TN0->TN0_CODTAR 
@Li,116 Psay If(Alltrim(TN0->TN0_CODTAR)=="*",STR0023,Substr(TN5->TN5_NOMTAR,1,17))  //"Todas"
If NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
	@Li,136 Psay TN0->TN0_DEPTO
	@Li,146 Psay If(Alltrim(TN0->TN0_DEPTO)=="*",STR0022,Substr(SQB->QB_DESCRIC,1,17))  //"Todos"
EndIf
Somalinha()
@Li,004 Psay STR0008 //"Exames.:"

Return

/*        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
----------------------------------------------------------------------------------------------------------------------------------------------
No. Risco  Agente                       Centro de Custo                           Função                     Tarefa                     Departamento
----------------------------------------------------------------------------------------------------------------------------------------------

 000000001  123456 12345678901234567890  123456789 12345678901234567890            12345 12345678901234567   123456 12345678901234567   123456789 12345678901234567
	Epi's..: NR7 - AVALIACAO CLINICA
		     001 - AUDIOMETRIA
		     002 - RAIO-X

000000002  123456 12345678901234567890  12345678901234567890 12345678901234567890 12345 12345678901234567  123456 12345678901234567
	Epi's..: NR7 - AVALIACAO CLINICA
		     004 - TOMOGRAFIA COMPUTADORIZADA

*/
