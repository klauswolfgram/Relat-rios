/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr540.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR540  ³ Autor ³ Heverson Vitoreti     ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio demonstrativo dos custos dos exames realizados    ³±±
±±³          ³Sera considerado para o relatorio todos os exames do tipo   ³±± 
±±³          ³ocupacional realizados no periodo solicitado. O Programa    ³±± 
±±³          ³le a tabela de Exames do Funcionario (TM5), e para cada exa-³±± 
±±³          ³realizado, o programa busca o valor na tabela precos (TMD), ³±±
±±³          ³com base no fornecedor e na data de realizacao do exame.    ³±±
±±³          ³O relatorio saira classificado por Empresa, Centro de Custo,³±± 
±±³          ³Fornecedor,exame e acumulando os valores do exame.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MDTR494void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR540()
//-----------------------------------------------------
//| Armazena variaveis p/ devolucao (NGRIGHTCLICK) 	  |
//-----------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

Local oReport
Local aArea := GetArea()
Local nTamGrupExa := 0

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

cAliasCC := "SI3"   
cF3CC    := "SI3" 
cCodCC2  := "I3_CUSTO"
cDescCC2 := "SI3->I3_DESC"
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cF3CC    := "CTT"
	cCodCC2  := "CTT_CUSTO"
	cDescCC2 := "CTT->CTT_DESC01"		
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))				
Endif

cPerg := If(!lSigaMdtPS,"MDT540    ","MDT540PS  ")

/*----------------------------------
//PERGUNTAS PADRÃO					|
| 01  De Centro de Custo ?  		|
| 02  Ate Centro de Custo ? 		|
| 03  De Fornecedor ?       		|
| 04  Ate Fornecedor ?      		|
| 05  De Exame ?            		|
| 06  Ate Exame ?           		|
| 07  De Data de Resul. ?   		|
| 08  Ate Data de Resul. ? 			|
|										|
//PERGUNTAS DO PRESTADOR DE SERVIÇO|
| 01  De Cliente ?          		|
| 02  Loja                  		|
| 03  Até Cliente ?         		|
| 04  Loja                  		|
| 05  De Centro de Custo ?  		|
| 06  Ate Centro de Custo ? 		|
| 07  De Fornecedor ?       		|
| 08  Ate Fornecedor ?     			|
| 09  De Exame ?            		|
| 10  Ate Exame ?           		|
| 11  De Data de Resul. ?   		|
| 12  Ate Data de Resul. ?  		|
----------------------------------*/

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adicionando as perguntas relacionadas a Exames ao grupo de   ³
//³ campos 048 - "Exame".                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If TRepInUse()
   //-- Interface de impressao
   oReport := ReportDef()
	oReport:SetPortrait()
   oReport:PrintDialog()
Else
   U_MDTR540R3()
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
±±³ Uso      ³ MDTR540                                                    ³±±
±±|__________|____________________________________________________________|±± 
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/   
Static Function ReportDef() 

	Local oReport 
	Local oSection1 
	Local oSection2 
	Local oSection3 
	Local oCell
	Local oBreak1, oBreak2
	Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])

	oReport := TReport():New( "MDTR540", OemToAnsi( STR0006 ), cPerg, { |oReport| ReportPrint( oReport ) }, STR0001 + " " + STR0002 + " " + STR0003 )

	Pergunte(oReport:uParam,.F.)

	oReport:SetTotalInLine(.T.)

	oSection1 := TRSection():New( oReport, STR0036, { "TRB" ,"SI3","CTT" } ) //"Centro de Custo"
	TRCell():New(oSection1,"TRB->CCUSTO"	 , "TRB" ,STR0037 ,"@!",nSizeSI3) //"C.Custo"
	If cAliasCC == "CTT"
		TRCell():New(oSection1,"CTT_DESC01" ,"CTT",STR0038	,"@!",40) //"Descrição"
		TRPosition():New(oSection1,"CTT",1,{|| xFilial( "CTT" )+ TRB ->CCUSTO}) 
	Else
		TRCell():New(oSection1,"I3_DESC" 	,"SI3",STR0038	,"@!",40) //"Descrição"
		TRPosition():New(oSection1,"SI3",1,{|| xFilial( "SI3" ) + TRB->CCUSTO})
	EndIf

	oSection2 := TRSection():New(oReport,STR0039,{"TRB","SA2"})  //"Fornecedor"
	TRCell():New(oSection2,"TRB->FORNEC"	,"TRB",STR0039	,"@!",06) //"Fornecedor"
	TRCell():New(oSection2,"A2_NOME"		,"SA2",STR0035   	,"@!",40) //"Nome"
	TRPosition():New(oSection2,"SA2",1,{|| xFilial("SA2")+TRB->FORNEC})
	
	oSection3 := TRSection():New(oReport,STR0040,{"TRB"})            //"Exames"
	oCell := TRCell():New(oSection3,"TRB->EXAME"	,"TRB",STR0041        ,"@!"             ,nTamExa,,) //"Exame"
	oCell := TRCell():New(oSection3,"TM4_NOMEXA"	,"TM4",STR0042,"@!"             ,40,,) //"Nome do Exame"
	oCell := TRCell():New(oSection3,"TRB->QTDE"	,"TRB",STR0043   ,"@E 999,999"     ,06,,) //"Quantidade"
	oCell := TRCell():New(oSection3,"TRB->VALOR"	,"TRB",STR0044        ,"@E 9,999,999.99",12,,) //"Custo"
	TRPosition():New(oSection3,"TM4",1,{|| xFilial("TM4")+TRB->EXAME})
	oSection3:Cell("TRB->QTDE"):SetHeaderAlign("RIGHT")
	oSection3:Cell("TRB->VALOR"):SetHeaderAlign("RIGHT")
	
	oBreak1 := TRBreak():New(oSection2,".T.",STR0010,.F.) //"Total do Fornecedor"
	TRFunction():New(oSection3:Cell("TRB->VALOR")	,/*cId*/,"SUM"	,oBreak1,STR0044,"@E 9,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/) //"Custo"
	
	oBreak2 := TRBreak():New(oSection1,".T.",STR0013,.F.) //"Total do Centro de Custo"
	TRFunction():New(oSection3:Cell("TRB->VALOR")	,/*cId*/,"SUM"	,oBreak2,STR0044,"@E 9,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/) //"Custo"
	
	oTotaliz := TRFunction():New(oSection3:Cell("TRB->VALOR"),"TOTVAL"   ,"SUM",/*oBreak*/,STR0044,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/) //"Custo"


Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR540  ³ Autor ³ Elisangela Costa      ³ Data ³ 13.01.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio demonstrativo dos custos dos exames realizados    ³±±
±±³          ³Sera considerado para o relatorio todos os exames do tipo   ³±± 
±±³          ³ocupacional realizados no periodo solicitado. O Programa    ³±± 
±±³          ³le a tabela de Exames do Funcionario (TM5), e para cada exa-³±± 
±±³          ³realizado, o programa busca o valor na tabela precos (TMD), ³±±
±±³          ³com base no fornecedor e na data de realizacao do exame.    ³±±
±±³          ³O relatorio saira classificado por Empresa, Centro de Custo,³±± 
±±³          ³Fornecedor,exame e acumulando os valores do exame.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MDTR494void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR540R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR540"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001  //"Relatorio de Custos dos Exames realizados. Atraves dos parametros"
LOCAL cDesc2  := STR0002 //"o usuario podera selecionar o centro de custo,fornecedor, exame,"
LOCAL cDesc3  := STR0003 //"e obterar os custos dos exames realizados no periodo."

LOCAL cString := "TM5"                       
PRIVATE nomeprog := "MDTR540"
PRIVATE tamanho  := "P"
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Custos dos Exames realizados"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2
PRIVATE nValforn := 0.00
PRIVATE lContinua := .T.  
Private aVetinr := {}, oTempTRB

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De  Centro de Custo                  ³
//³ mv_par02             // Ate Centro de Custo                  ³
//³ mv_par03             // De  Fornecedor                       ³
//³ mv_par04             // Ate Fornecedor                       ³
//³ mv_par05             // De Exame                             ³
//³ mv_par06             // Ate Exame                            ³
//³ mv_par07             // Ate Dt. Realizacao                   ³
//³ mv_par08             // Ate Dt. Realizacao                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "MDTR540"
wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
    Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| R540Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R540Imp  ³ Autor ³Elisangela Costa       ³ Data ³14 /01/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR540                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R540Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
Local nTamCli  := TAMSX3("A1_COD")[1]
Local nTamLoj  := TAMSX3("A1_LOJA")[1]
Local nSpcCli  := If( nTamCli < 7 , 0 , nTamCli - 7 )

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

cabec1 := STR0007 //"Codigo  Loja  Nome do Fornecedor"
cabec2 := STR0008 //"  Exame  Nome do Exame                               Quantidade            Custo"

//           1         2         3         4         5         6         7         8
// 012345678901234567890123456789012345678901234567890123456789012345678901234567890
//____________________________________________________________________________________
//Codigo  Nome do Fornecedor
//  Exame  Nome do Exame                               Quantidade            Custo
//____________________________________________________________________________________
//
//Empresa...: xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//C.Custo...: xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//xxxxxx   xx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//  xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       999.999    99.999.999,99
//                                                                   -------------
//                                              Total do Fornecedor  99.999.999,99

//xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//  xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       999.999    99.999.999,99
//                                                                   -------------
//                                         Total do Fornecedor       99.999.999,99
//                                         Total do Centro de Custo 999.999.999,99
//C.Custo...: xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//  xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       999.999    99.999.999,99
//                                                                   -------------
//                                         Total do Fornecedor       99.999.999,99
//                                         Total do Centro de Custo 999.999.999,99
//                                         Total da Empresa       9.999.999.999,99
//                                         Total do Geral        99.999.999.999,99
// =========================================================

//           1         2         3         4         5         6         7         8
// 012345678901234567890123456789012345678901234567890123456789012345678901234567890
//____________________________________________________________________________________
//Codigo  Nome do Fornecedor
//  Exame  Nome do Exame                               Quantidade            Custo
//____________________________________________________________________________________
//
//C.Custo...: xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//  xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       999.999    99.999.999,99
//                                                                   -------------
//                                              Total do Fornecedor  99.999.999,99

//xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//  xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       999.999    99.999.999,99
//                                                                   -------------
//                                         Total do Fornecedor       99.999.999,99
//                                         Total do Centro de Custo 999.999.999,99
//C.Custo...: xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//  xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       999.999    99.999.999,99
//                                                                   -------------
//                                         Total do Fornecedor       99.999.999,99
//                                         Total do Centro de Custo 999.999.999,99
//                                         Total do Geral         9.999.999.999,99

	Processa({|lEND| MDTR540TM5(@lEnd)},STR0047) //"Processando Arquivo..."

	dbSelectArea( "TRB" )
	dbGotop()
	If RecCount()==0
		MsgInfo(STR0049) //"Não há nada para imprimir no relatório."
		//Use
		oTempTRB:Delete()
		RetIndex("TM5")		
		Set Filter To		
		Set device to Screen		        
		Return .F.
	Endif	
	
	cUsaPS := Alltrim(GETMV("MV_NGMDTPS")) //Usa Prestadora de Servico
	nTotalG := 0.00  //Total Geral
	lPri := .T.
	
	dbSelectArea( "TRB" )
	dbGotop()
	While !EOF()

			If lEnd
			@ PROW()+1,001 PSay STR0009 //"CANCELADO PELO OPERADOR"
			Exit
			EndIf

			cCustoF := TRB->CCUSTO //Centro de Custo
			nTotCC  := 0.00 // Total do Centro de Custo

			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			dbSeek(xFilial(cAliasCC)+cCustoF)
			SomaLinha()   
			Somalinha()
			@ Li,000 PSay STR0012 + Alltrim(cCustoF)+" - "+&cDescCC2 PICTURE "@!"
			
			DbSelectArea( "TRB" )   
			While !EOF()  .AND. TRB->CCUSTO = cCustoF
			
				cFornec  := TRB->FORNEC
				nTotFornc := 0.00 //Total do Fornecedor
				
				dbSelectArea("SA2")
				dbSetOrder(01)
				dbSeek(xFilial("SA2")+cFornec)
				SomaLinha()   
				Somalinha()
				@ Li,000 PSay Alltrim(cFornec)+" - "+SA2->A2_NOME PICTURE "@!"

				DbSelectArea( "TRB" )   
				While !EOF() .And. TRB->CCUSTO = cCustoF .And. TRB->FORNEC == cFornec
						
						IncProc()
						SomaLinha()
						@ Li,002 PSay TRB->EXAME
						dbSelectArea("TM4")
						dbSetOrder(01)
						dbSeek(xFilial("TM4")+TRB->EXAME)
						@ Li,014 PSay SUBSTR(TM4->TM4_NOMEXA,1,35)
						@ Li,056 PSay TRB->QTDE    PICTURE "999,999"
						@ Li,068 PSay TRB->VALOR   PICTURE "@E 9,999,999.99"

						nTotFornc := nTotFornc + TRB->VALOR
						dbSelectArea("TRB")
						dbSkip()

				EndDo 
				nTotCC  := nTotCC  + nTotFornc 
				SomaLinha()
				@ Li,067 PSay "-------------"
				SomaLinha()
				@ Li,040 PSay STR0010 //"Total do Fornecedor"
				@ Li,068 PSay nTotFornc  PICTURE "@E 9,999,999.99"

			EndDo
			nTotalG := nTotalG + nTotCC 
			SomaLinha()
			SomaLinha()
			@ Li,040 PSay STR0013 //"Total do Centro de Custo"
			@ Li,068 PSay nTotCC PICTURE "@E 9,999,999.99"
	Enddo
	SomaLinha()
	SomaLinha()
	@ Li,067 PSay "-------------"
	SomaLinha()
	@ Li,040 PSay STR0015 //"Total Geral"
	@ Li,068 PSay nTotalG  PICTURE "@E 9,999,999.99" 

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

	dbSelectArea("TRB")
	//USE
	oTempTRB:Delete()

Return NIL          

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ReportPrint³ Autor ³ Rafael Diogo Richter  ³ Data ³ 08/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )

	Local oSection1 
	Local oSection2 
	Local oSection3 
	Local oSection4
	Local cFornec
	Private aVetinr := {}, oTempTRB

	oSection1 := oReport:Section(1)
	oSection2 := oReport:Section(2)
	oSection3 := oReport:Section(3)
	oSection4 := oReport:Section(4)

	Processa( { |lEND| MDTR540TM5( @lEnd, oSection1, oSection2 ) }, STR0047 ) //"Processando Arquivo..."

	lPri := .T.

	dbSelectArea("TRB")
	dbGotop()
	oReport:SetMeter(RecCount())
	While !EOF() .And. !oReport:Cancel()

		cCustoF := TRB->CCUSTO //Centro de Custo
		nTotCC  := 0.00 // Total do Centro de Custo

		oSection1:Init()
		oSection1:PrintLine()
		
		DbSelectArea("TRB")   
		While !EOF()  .AND. TRB->CCUSTO = cCustoF .And. !oReport:Cancel()
		
			cFornec  := TRB->FORNEC
			nTotFornc := 0.00 //Total do Fornecedor
				
			oSection2:Init()
			oSection2:PrintLine()
			oSection3:Init()

			DbSelectArea("TRB")   
			While !EOF() .And. TRB->CCUSTO = cCustoF .And. TRB->FORNEC == cFornec .And. !oReport:Cancel()

				oReport:IncMeter()
				
				oSection3:PrintLine()
				
				DbSelectArea("TRB")
				DbSkip()
			End 
		oSection2:Finish()
		oSection3:Finish()
		End
		oSection1:Finish()
	End

	dbSelectArea("TRB")
	DbGoTop()
	If TRB->QTDE == 0
		MsgInfo(STR0049) //"Não há nada para imprimir no relatório."
		//Use
		oTempTRB:Delete()
		RetIndex("TM5")		
		Set Filter To		
		Set device to Screen		        
		Return .F.
	Endif

	dbSelectArea("TRB")
	//USE
	oTempTRB:Delete()

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
±±³Fun‡…o    ³MDTR540TM5³ Autor ³ Rafael Diogo Richter  ³ Data ³08/08/2006³±±
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
Static Function MDTR540TM5(lEnd, oSection1, oSection2)

	Local nSizeSA2  := If( ( TAMSX3( "A2_COD" )[1] ) < 1, 6, (TAMSX3( "A2_COD" )[1] ) )
	Local nSizeLo2  := If( ( TAMSX3( "A2_LOJA" )[1] ) < 1, 6, (TAMSX3( "A2_LOJA" )[1] ) )
	Local nTamExa	:= If( ( TAMSX3( "TM4_EXAME" )[1] )	< 1, 6, (TAMSX3( "TM4_EXAME" )[1] ) )
	Private aVetinr := {}

	aDBF := {}
	aAdd( aDBF, { "FORNEC", "C", nSizeSA2, 0 } )
	aAdd( aDBF, { "LOJA"  , "C", nSizeLo2, 0 } )
	aAdd( aDBF, { "EXAME" , "C", nTamExa , 0 } )
	aAdd( aDBF, { "QTDE"  , "N", 06		 , 0 } )
	aAdd( aDBF, { "VALOR" , "N", 12      , 2 } )
	aAdd( aDBF, { "CCUSTO", "C", nSizeSI3, 0 } )

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", { "CCUSTO", "FORNEC", "LOJA", "EXAME", "VALOR", "QTDE" } )
	oTempTRB:Create()
	
	If lFiltroCc := !Empty( oSection1:aUserFilter )

		If !Empty( oSection1:aUserFilter[1][3] )

			cFiltroCc := oSection1:aUserFilter[1][3]
			cTblCC	  := oSection1:aUserFilter[1][1]
		
		EndIf

		If Len( oSection1:aUserFilter ) == 2

			If !Empty( oSection1:aUserFilter[2][3] ) .And. !Empty( oSection1:aUserFilter[1][3] )

				cFiltroCc := cFiltroCc + Space(1) + "AND" + Space(1) + oSection1:aUserFilter[2][3]
				cTblCC	  := oSection1:aUserFilter[2][1]

			EndIf

		EndIf

		cFiltroCc := "%" + cFiltroCc + "%"

	EndIf

	If ( lFiltroForn := !Empty( oSection2:aUserFilter ) )

		If !Empty( oSection2:aUserFilter[1][3] )

			cFiltroForn := "%" + oSection2:aUserFilter[1][3] + "%"
			cTblForn	:= oSection2:aUserFilter[1][1]

		EndIf

	EndIf

	If lFiltroCc

		( "TRB" )->( DbCloseArea() )

		If Len( oSection1:aUserFilter ) == 2

			BeginSql Alias "TRB"
				SELECT
					TM5_CC AS CCUSTO,
					TM5_FORNEC AS FORNEC,
					TM5_LOJA AS LOJA,
					TM5_EXAME AS EXAME,
					( TMD_VALEXA * COUNT(*) ) AS VALOR,
					COUNT(*) AS QTDE
				FROM
					%table:TM5% TM5
					INNER JOIN %table:SI3% SI3 ON
						SI3.I3_FILIAL = %xFilial:SI3%
						AND SI3.I3_CUSTO = TM5.TM5_CC
						AND SI3.%NotDel%
					INNER JOIN %table:CTT% CTT ON
						CTT.CTT_FILIAL = %xFilial:CTT%
						AND CTT.CTT_CUSTO = TM5.TM5_CC
						AND CTT.%NotDel%
					INNER JOIN %table:TMD% TMD ON
						TMD.TMD_FILIAL = %xFilial:TMD%
						AND TMD.TMD_FORNEC = TM5.TM5_FORNEC
						AND TMD.TMD_LOJA = TM5.TM5_LOJA
						AND TMD.TMD_EXAME = TM5.TM5_EXAME
						AND TMD.TMD_DTINIC <= TM5.TM5_DTRESU
						AND TMD.%NotDel%
				WHERE
					TM5.TM5_FILIAL = %xFilial:TM5%
					AND %exp:cFiltroCc%
					AND TM5.TM5_CC BETWEEN %exp:mv_par01%
					AND %exp:mv_par02%
					AND TM5.TM5_FORNEC BETWEEN %exp:mv_par03%
					AND %exp:mv_par04%
					AND TM5.TM5_EXAME BETWEEN %exp:mv_par05%
					AND %exp:mv_par06%
					AND TM5.TM5_DTRESU BETWEEN %exp:mv_par07%
					AND %exp:mv_par08%
					AND TM5.%NotDel%
				GROUP BY
					TM5_CC,
					TM5_FORNEC,
					TM5_LOJA,
					TM5_EXAME,
					TMD_VALEXA 
			ENDSQL

		ElseIf cTblCC == "CTT"

			BeginSql Alias "TRB"
				SELECT
					TM5_CC AS CCUSTO,
					TM5_FORNEC AS FORNEC,
					TM5_LOJA AS LOJA,
					TM5_EXAME AS EXAME,
					( TMD_VALEXA * COUNT(*) ) AS VALOR,
					COUNT(*) AS QTDE
				FROM
					%table:TM5% TM5
					INNER JOIN %table:CTT% CTT ON
						CTT.CTT_FILIAL = %xFilial:CTT%
						AND CTT.CTT_CUSTO = TM5.TM5_CC
						AND CTT.%NotDel%
					INNER JOIN %table:TMD% TMD ON
						TMD.TMD_FILIAL = %xFilial:TMD%
						AND TMD.TMD_FORNEC = TM5.TM5_FORNEC
						AND TMD.TMD_LOJA = TM5.TM5_LOJA
						AND TMD.TMD_EXAME = TM5.TM5_EXAME
						AND TMD.TMD_DTINIC <= TM5.TM5_DTRESU
						AND TMD.%NotDel%
				WHERE
					TM5.TM5_FILIAL = %xFilial:TM5%
					AND %exp:cFiltroCc%
					AND TM5.TM5_CC BETWEEN %exp:mv_par01%
					AND %exp:mv_par02%
					AND TM5.TM5_FORNEC BETWEEN %exp:mv_par03%
					AND %exp:mv_par04%
					AND TM5.TM5_EXAME BETWEEN %exp:mv_par05%
					AND %exp:mv_par06%
					AND TM5.TM5_DTRESU BETWEEN %exp:mv_par07%
					AND %exp:mv_par08%
					AND TM5.%NotDel%
				GROUP BY
					TM5_CC,
					TM5_FORNEC,
					TM5_LOJA,
					TM5_EXAME,
					TMD_VALEXA 
			ENDSQL
			
		Else

			BeginSql Alias "TRB"
				SELECT
					TM5_CC AS CCUSTO,
					TM5_FORNEC AS FORNEC,
					TM5_LOJA AS LOJA,
					TM5_EXAME AS EXAME,
					( TMD_VALEXA * COUNT(*) ) AS VALOR,
					COUNT(*) AS QTDE
				FROM
					%table:TM5% TM5
					INNER JOIN %table:SI3% SI3 ON
						SI3.I3_FILIAL = %xFilial:SI3%
						AND SI3.I3_CUSTO = TM5.TM5_CC
						AND SI3.%NotDel%
					INNER JOIN %table:TMD% TMD ON
						TMD.TMD_FILIAL = %xFilial:TMD%
						AND TMD.TMD_FORNEC = TM5.TM5_FORNEC
						AND TMD.TMD_LOJA = TM5.TM5_LOJA
						AND TMD.TMD_EXAME = TM5.TM5_EXAME
						AND TMD.TMD_DTINIC <= TM5.TM5_DTRESU
						AND TMD.%NotDel%
				WHERE
					TM5.TM5_FILIAL = %xFilial:TM5%
					AND %exp:cFiltroCc%
					AND TM5.TM5_CC BETWEEN %exp:mv_par01%
					AND %exp:mv_par02%
					AND TM5.TM5_FORNEC BETWEEN %exp:mv_par03%
					AND %exp:mv_par04%
					AND TM5.TM5_EXAME BETWEEN %exp:mv_par05%
					AND %exp:mv_par06%
					AND TM5.TM5_DTRESU BETWEEN %exp:mv_par07%
					AND %exp:mv_par08%
					AND TM5.%NotDel%
				GROUP BY
					TM5_CC,
					TM5_FORNEC,
					TM5_LOJA,
					TM5_EXAME,
					TMD_VALEXA 
			ENDSQL

		EndIf

	ElseIf lFiltroForn

		( "TRB" )->( DbCloseArea() )

        BeginSql Alias "TRB"
			SELECT
				TM5_CC AS CCUSTO,
				TM5_FORNEC AS FORNEC,
				TM5_LOJA AS LOJA,
				TM5_EXAME AS EXAME,
				( TMD_VALEXA * COUNT(*) ) AS VALOR,
				COUNT(*) AS QTDE
			FROM
				%table:TM5% TM5
				INNER JOIN %table:SA2% SA2 ON
					SA2.A2_FILIAL = %xFilial:SA2%
					AND SA2.A2_COD = TM5.TM5_FORNEC
					AND SA2.A2_LOJA = TM5.TM5_LOJA
					AND SA2.%NotDel%
				INNER JOIN %table:TMD% TMD ON
					TMD.TMD_FILIAL = %xFilial:TMD%
					AND TMD.TMD_FORNEC = TM5.TM5_FORNEC
					AND TMD.TMD_LOJA = TM5.TM5_LOJA
					AND TMD.TMD_EXAME = TM5.TM5_EXAME
					AND TMD.TMD_DTINIC <= TM5.TM5_DTRESU
					AND TMD.%NotDel%
			WHERE
				TM5.TM5_FILIAL = %xFilial:TM5%
				AND %exp:cFiltroForn%
				AND TM5.TM5_CC BETWEEN %exp:mv_par01%
				AND %exp:mv_par02%
				AND TM5.TM5_FORNEC BETWEEN %exp:mv_par03%
				AND %exp:mv_par04%
				AND TM5.TM5_EXAME BETWEEN %exp:mv_par05%
				AND %exp:mv_par06%
				AND TM5.TM5_DTRESU BETWEEN %exp:mv_par07%
				AND %exp:mv_par08%
				AND TM5.%NotDel%
			GROUP BY
				TM5_CC,
				TM5_FORNEC,
				TM5_LOJA,
				TM5_EXAME,
				TMD_VALEXA 
		ENDSQL

	Else

		( "TRB" )->( DbCloseArea() )

        BeginSql Alias "TRB"
			SELECT
				TM5_CC AS CCUSTO,
				TM5_FORNEC AS FORNEC,
				TM5_LOJA AS LOJA,
				TM5_EXAME AS EXAME,
				( TMD_VALEXA * COUNT(*) ) AS VALOR,
				COUNT(*) AS QTDE
			FROM
				%table:TM5% TM5
				INNER JOIN %table:TMD% TMD ON
					TMD.TMD_FILIAL = %xFilial:TMD%
					AND TMD.TMD_FORNEC = TM5.TM5_FORNEC
					AND TMD.TMD_LOJA = TM5.TM5_LOJA
					AND TMD.TMD_EXAME = TM5.TM5_EXAME
					AND TMD.TMD_DTINIC <= TM5.TM5_DTRESU
					AND TMD.%NotDel%
			WHERE
				TM5.TM5_FILIAL = %xFilial:TM5%
				AND TM5.TM5_CC BETWEEN %exp:mv_par01%
				AND %exp:mv_par02%
				AND TM5.TM5_FORNEC BETWEEN %exp:mv_par03%
				AND %exp:mv_par04%
				AND TM5.TM5_EXAME BETWEEN %exp:mv_par05%
				AND %exp:mv_par06%
				AND TM5.TM5_DTRESU BETWEEN %exp:mv_par07%
				AND %exp:mv_par08%
				AND TM5.%NotDel%
			GROUP BY
				TM5_CC,
				TM5_FORNEC,
				TM5_LOJA,
				TM5_EXAME,
				TMD_VALEXA 
		ENDSQL

	EndIf

Return .T.
