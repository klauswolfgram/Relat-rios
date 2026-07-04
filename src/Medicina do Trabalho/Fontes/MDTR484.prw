/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR484.ch"
#Include "Protheus.ch" 

#DEFINE _nVERSAO 02 //Versao do fonte     
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR484  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do Resultado dos Exames Quantitativos por         ³±±
±±³          ³C.Custo.                                                    ³±±
±±³          ³Atraves dos parametros o usuario podera selecionar um exame ³±± 
±±³          ³especifico o todos, um C.Custo ou todos e ainda um periodo  ³±± 
±±³          ³determinado. Com base nos parametro o programa ira obter    ³±± 
±±³          ³as informacoes da tabela de exames do funcionario (TM5), e  ³±± 
±±³          ³para cada exame que atender os filtros especificados, obter ³±± 
±±³          ³as informacoes da tabela de resultado dos fexames quanttati-³±± 
±±³          ³vos TM6, e o padrao de normalidade na tabela de Normalidade ³±± 
±±³          ³TM8. A quantidade permitira  o usuario selecionar exames    ³±± 
±±³          ³cujo o resultado do sub-item fica entre o intervalo informa-³±± 
±±³          ³do.                                                         ³±± 
±±³          ³O Relatorio saira classificado por c.custo e por matricula, ³±± 
±±³          ³para cada exame fora da faixa de normalidade aparecera uma  ³±±
±±³          ³mensagem indicando se o resultado encontra-se acima ou abai-³±± 
±±³          ³xo do padrao de normalidade. O programa so lista exames com ³±± 
±±³          ³tipo de resultado igual a quantitativo.                     ³±± 
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MDTR484void)                                               ³±±                  
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR484()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

Local oReport
Local aArea := GetArea()
Local nTamGrupExa := 0
Private cPerg 
Private oTempTRB 

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

cPerg:= If(!lSigaMdtPS,"MDT484    ","MDT484PS  ")

cAliasCC := "CTT"
cDescCC  := "CTT->CTT_DESC01"
nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
cDescCC := "CTT_DESC01"
cDescCC2 := "CTT->CTT_DESC01"
	
If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*----------------------------------
//PERGUNTAS PADRÃO					|
| 01  De  Centro de Custo ?   		|
| 02  Ate Centro de Custo ?   		|
| 03  De  Exame ?             		|
| 04  Ate Exame ?             		|
| 05  De  Sub-Item ?          		|
| 06  Ate Sub-Item ?          		|
| 07  De  Quantidade ?        		|
| 08  Ate Quantidade ?        		|
| 09  De  Data Resultado ?    		|
| 10  Ate Data Resultado ?    		|
|										|
//PERGUNTAS DO PRESTADOR DE SERVIÇO|
| 01  De Cliente ?            		| 
| 02  Loja                    		| 
| 03  Até Cliente ?           		| 
| 04  Loja	                  		|	 
| 05  De  Centro de Custo ?   		|
| 06  Ate Centro de Custo ?   		|
| 07  De  Exame ?             		|
| 08  Ate Exame ?             		|
| 09  De  Sub-Item ?          		|
| 10  Ate Sub-Item ?          		|
| 11  De  Quantidade ?        		|
| 12  Ate Quantidade ?        		|
| 13  De  Data Resultado ?    		|
| 14  Ate Data Resultado ?    		|
------------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adicionando as perguntas relacionadas a Exames ao grupo de   ³
//³ campos 048 - "Exame".                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If TRepInUse()
   //-- Interface de impressao
   oReport := ReportDef()
   oReport:lDisableOrientation := .T.//trava o modo de impressão como paisagem
	oReport:SetLandscape()
   oReport:PrintDialog()
Else
   U_MDTR484R3()
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
±±³Fun‡…o    ³ReportDef ³ Autor ³ Ricardo Dalponte      ³ Data ³09/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Define as secoes impressas no relatorio                     ³±±
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
Local oSection0
Local oSection1 
Local oSection2 
Local oCell

Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])
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
oReport := TReport():New("MDTR484",OemToAnsi(STR0006),"MDT484",{|oReport| ReportPrint(oReport)},STR0001+" "+STR0002+" "+STR0003)

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
	oSection0 := TRSection():New (oReport,STR0032, {"TRB", "SA1"} )  //"Cliente"
	TRCell():New (oSection0, "A1_COD" , "SA1", STR0032, "@!", nTa1 )  //"Cliente"
	TRCell():New (oSection0, "A1_LOJA", "SA1", STR0026, "@!", nTa1L ) //"Loja"
	TRCell():New (oSection0, "A1_NOME", "SA1", STR0033, "@!", 40 )    //"Nome"
	TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TRB->CLIENT+TRB->LOJA } )
Endif

oSection1 := TRSection():New(oReport,STR0034,{"TRB","SI3"})   //"Centro de Custo"
TRCell():New(oSection1,"TRB->CCUSTO"	,"TRB"		,STR0013 	,"@!" ,nSizeSI3	,/*lPixel*/,/*{|| code-block de impressao }*/) //"C.Custo"
TRCell():New(oSection1,cDescCC			,cAliasCC	,STR0014	,"@!" ,40			,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descrição"
TRPosition():New(oSection1,cAliasCC,1,{|| xFilial(cAliasCC) + TRB->CCUSTO})

oSection2 := TRSection():New(oReport,STR0035,{"TRB","SRA","TM4","TM8","TPA","SB1"})  //"Exames"
oCell := TRCell():New(oSection2,"TRB->MATRIC" 	,"TRB" ,STR0015	,"@!" 		 				,15   		,/*lPixel*/,/*{|| code-block de impressao }*/) //"Matricula"
oCell := TRCell():New(oSection2,"RA_NOME" 	  	,"SRA" ,STR0016	,"@!" 		 				,45  		,/*lPixel*/,/*{|| code-block de impressao }*/) //"Funcionário"
oCell := TRCell():New(oSection2,"TRB->DTREAL" 	,"TRB" ,STR0017	,"99/99/9999"				,14			,/*lPixel*/,/*{|| code-block de impressao }*/) //"Realização"
oCell := TRCell():New(oSection2,"TRB->EXAME"  	,"TRB" ,STR0018	,"@!"        				,nTamExa+1	,/*lPixel*/,/*{|| code-block de impressao }*/) //"Exame"
oCell := TRCell():New(oSection2,"TM4_NOMEXA"  	,"TM4" ,STR0019	,"@!"        				,62  		,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome Exame"
oCell := TRCell():New(oSection2,"TRB->SUBITEM"	,"TRB" ,STR0020	,"@!"        				,10  		,/*lPixel*/,/*{|| code-block de impressao }*/) //"Sub-item"
oCell := TRCell():New(oSection2,"TM8_NOMITE"  	,"TM8" ,STR0014	,"@!"        				,28 		,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descrição"
	oCell := TRCell():New(oSection2,"TM8->TM8_SEXO"  ,"TM8" ,STR0048	,"@!"        				,06 		,/*lPixel*/,{|| SubSTr(NGRETSX3BOX("TM8_SEXO",TM8->TM8_SEXO),1,1) }) //"Sexo"
oCell := TRCell():New(oSection2,"TRB->QUANTID"	,"TRB" ,STR0021	,"@E 999,999,999.999" 	,20  		,/*lPixel*/,/*{|| code-block de impressao }*/) //"Quantidade"
oCell := TRCell():New(oSection2,"DELIMIT1"    	," "   ," "	    ,"@!"        				,02 		,/*lPixel*/,/*{|| code-block de impressao }*/) //"Espaçamento criado pois campos truncavam pelo motivo de um ser C e outro N"
oCell := TRCell():New(oSection2,"TM8_UNIDAD"  	,"TM8" ,STR0022	,"@!"        				,06  		,/*lPixel*/,/*{|| code-block de impressao }*/) //"Unid."
oCell := TRCell():New(oSection2,"  "	 	  		,"   " ,STR0023	,"@!"        				,08  		,/*lPixel*/,{|| cOBS}) //"Obs."
TRPosition():New(oSection2,"SRA",1,{|| xFilial("SRA") + TRB->MATRIC})
TRPosition():New(oSection2,"TM4",1,{|| xFilial("TM4") + TRB->EXAME}) 
TRPosition():New(oSection2,"TM8",1,{|| xFilial("TM8") + TRB->EXAME + TRB->SUBITEM})  
oSection2:Cell("TRB->QUANTID"):SetHeaderAlign("RIGHT") 
  
Return oReport  
  
/*/  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR484R3³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do Resultado dos Exames Quantitativos por         ³±±
±±³          ³C.Custo.                                                    ³±±
±±³          ³Atraves dos parametros o usuario podera selecionar um exame ³±± 
±±³          ³especifico o todos, um C.Custo ou todos e ainda um periodo  ³±± 
±±³          ³determinado. Com base nos parametro o programa ira obter    ³±± 
±±³          ³as informacoes da tabela de exames do funcionario (TM5), e  ³±± 
±±³          ³para cada exame que atender os filtros especificados, obter ³±± 
±±³          ³as informacoes da tabela de resultado dos fexames quanttati-³±± 
±±³          ³vos TM6, e o padrao de normalidade na tabela de Normalidade ³±± 
±±³          ³TM8. A quantidade permitira  o usuario selecionar exames    ³±± 
±±³          ³cujo o resultado do sub-item fica entre o intervalo informa-³±± 
±±³          ³do.                                                         ³±± 
±±³          ³O Relatorio saira classificado por c.custo e por matricula, ³±± 
±±³          ³para cada exame fora da faixa de normalidade aparecera uma  ³±±
±±³          ³mensagem indicando se o resultado encontra-se acima ou abai-³±±  
±±³          ³xo do padrao de normalidade. O programa so lista exames com ³±± 
±±³          ³tipo de resultado igual a quantitativo.                     ³±± 
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MDTR484void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR484R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR484"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio de Resultado dos exames quantitativos por Centro de Custo  "
LOCAL cDesc2  := STR0002 //"Demonstra exames realizados em um determinado periodo, permitindo    "
LOCAL cDesc3  := STR0003 //"selecionar as quantidades apuradas nos resultados dos exames.        "
LOCAL cString := "TM6"

PRIVATE nomeprog := "MDTR484"
PRIVATE tamanho  := "G"
PRIVATE aReturn  := {STR0004, 1,STR0005, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Resultado dos Exames Quantitativos"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2
PRIVATE cPROGRAMA := 'MDTR484'
PRIVATE LEITEM    := .T.
PRIVATE LELIMMAX  := .T.
PRIVATE LELIMMIN  := .T.
PRIVATE LENOMITE  := .T.
PRIVATE nSizeSI3
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De Centro de Custo                   ³
//³ mv_par02             // Ate Centro de Custo                  ³
//³ mv_par03             // De Exame                             ³
//³ mv_par04             // Ate Exame                            ³
//³ mv_par05             // De Sub-item                          ³
//³ mv_par06             // Ate Sub-item                         ³
//³ mv_par07             // De Quantidade                        ³
//³ mv_par08             // Ate Quantidade                       ³
//³ mv_par09             // De Dt.Realizacao                     ³
//³ mv_par10             // Ate Dt.Realizacao                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR484"

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

RptStatus({|lEnd| R484Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R484Imp  ³ Autor ³ Inacio Luiz Kolling   ³ Data ³28/04/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR484                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R484Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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

cabec1 := STR0007                                              //"Codigo        Nome do Centro de Custo"
cabec2 := STR0008 //"Matricula Funcionario                       Realizado  Exame      Nome Exame                               Sub-item                   Sexo       Quantidade Unid. Obs."

/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                 <Relatorio de Exame Quantitativos>                               DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Codigo        Nome do Centro de Custo
Matricula Funcionario                       Realizado  Exame      Nome Exame                               Sub-item                              Quantidade Unid. Obs.
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      99/99/99   xxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxx 999.999.999,999 xxxx  xxxxxx
                                            99/99/99   xxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxx 999.999.999,999 xxxx  xxxxxx
                                            99/99/99   xxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxx 999.999.999,999 xxxx  xxxxxx
*/

Processa({|lEND| U_MDTR484TM5()},STR0024) //"Processando Arquivo..."

If lSigaMdtps

	dbSelectArea("TRB")
	dbGOTOP()
	ProcRegua(RecCount())
	While !Eof()         
			
		IncProc()
	
		SomaLinha()
		cCliente := TRB->CLIENT+TRB->LOJA
		@Li,000 PSay STR0036 + AllTrim(TRB->CLIENT) +"-"+ AllTrim(TRB->LOJA) + " - " + NGSEEK("SA1",cCliente,1,"SA1->A1_NOME")  //"Cliente/Loja: "
		SomaLinha()
		
		While !Eof() .and. cCliente == TRB->CLIENT+TRB->LOJA
		
			ccCUSTO := TRB->CCUSTO
		
			SomaLinha()
		
			@Li,000 PSay ccCUSTO
			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			dbSeek(xFilial(cAliasCC)+ccCUSTO)
			@Li,022 PSay &(cDescCC2)
		
			dbSelectArea("TRB")
			While !Eof() .AND. ccCUSTO == TRB->CCUSTO
		
				cMAT := TRB->MATRIC
		
				Somalinha()
				@Li,000 PSay cMAT PICTURE "@!"
				dbSelectArea("SRA")
				dbSetOrder(01)
				dbSeek(xFilial("SRA")+cMAT)
				@Li,010 PSay Substr(SRA->RA_NOME,1,30)
		
				lPRIN := .t.
		
				dbSelectArea("TRB")
				While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC
		
					If !lPRIN
						Somalinha()
					Endif
		
					@Li,044 PSay TRB->DTREAL PICTURE '99/99/9999'
					@Li,055 PSay TRB->EXAME  PICTURE '@!'
		
					dbSelectArea("TM4")
					dbSetOrder(01)
					dbSeek(xFilial("TM4")+TRB->EXAME)
					@Li,066 PSay Substr(TM4->TM4_NOMEXA,1,40)
		
					@Li,107 PSay TRB->SUBITEM PICTURE '@!'
		
					dbSelectArea("TM8")
					dbSetOrder(01)
					dbSeek(xFilial("TM8")+TRB->EXAME+TRB->SUBITEM)
					@Li,114 PSay Substr(TM8->TM8_NOMITE,1,20)
						@Li,136 PSay SubSTr(NGRETSX3BOX("TM8_SEXO",TM8->TM8_SEXO),1,1) PICTURE '@!' 
					@Li,140 PSay TRB->QUANTID PICTURE '@E 999,999,999.999'
					@Li,156 PSay TM8->TM8_UNIDAD PICTURE '@!'
		
					cOBS := STR0010 //'Normal'
		
					If TRB->QUANTID >= TM8->TM8_LIMMIN  .and. TRB->QUANTID <= TM8->TM8_LIMMAX
						cOBS := STR0010 //'Normal'
					ElseIf TRB->QUANTID < TM8->TM8_LIMMIN
						cOBS := STR0011 //'A Baixo'
					ElseIf TRB->QUANTID > TM8->TM8_LIMMAX
						cOBS := STR0012 //'Acima'
					Endif
		
					@Li,162 PSay cOBS PICTURE '@!'
		
					lPRIN := .f.
		
					dbSelectArea("TRB")
					dbSKIP()
		
				End
		
				If ccCUSTO == TRB->CCUSTO
					Somalinha()
				Endif
		
			End
		
			Somalinha()
		End 		
		
	End
		
Else

	dbSelectArea("TRB")
	dbGOTOP()
	ProcRegua(RecCount())
	While !Eof()         
			
		IncProc()
	
		ccCUSTO := TRB->CCUSTO
	
		SomaLinha()
	
		@Li,000 PSay ccCUSTO
		dbSelectArea(cAliasCC)
		dbSetOrder(01)
		dbSeek(xFilial(cAliasCC)+ccCUSTO)
		@Li,022 PSay &(cDescCC2)
	
		dbSelectArea("TRB")
		While !Eof() .AND. ccCUSTO == TRB->CCUSTO
	
			cMAT := TRB->MATRIC
	
			Somalinha()
			@Li,000 PSay cMAT PICTURE "@!"
			dbSelectArea("SRA")
			dbSetOrder(01)
			dbSeek(xFilial("SRA")+cMAT)
			@Li,010 PSay Substr(SRA->RA_NOME,1,30)
	
			lPRIN := .t.
	
			dbSelectArea("TRB")
			While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC
	
				If !lPRIN
					Somalinha()
				Endif
	
				@Li,044 PSay TRB->DTREAL PICTURE '99/99/9999'
				@Li,055 PSay TRB->EXAME  PICTURE '@!'
	
				dbSelectArea("TM4")
				dbSetOrder(01)
				dbSeek(xFilial("TM4")+TRB->EXAME)
				@Li,066 PSay Substr(TM4->TM4_NOMEXA,1,40)
	
				@Li,107 PSay TRB->SUBITEM PICTURE '@!'
	
				dbSelectArea("TM8")
				dbSetOrder(01)
				dbSeek(xFilial("TM8")+TRB->EXAME+TRB->SUBITEM)
				@Li,114 PSay Substr(TM8->TM8_NOMITE,1,20)
					@Li,136 PSay SubStr(NGRETSX3BOX("TM8_SEXO",TM8->TM8_SEXO),1,1) PICTURE '@!' 
				@Li,140 PSay TRB->QUANTID PICTURE '@E 999,999,999.999'
				@Li,156 PSay TM8->TM8_UNIDAD PICTURE '@!'
	
				cOBS := STR0010 //'Normal'
	
				If TRB->QUANTID >= TM8->TM8_LIMMIN  .and. TRB->QUANTID <= TM8->TM8_LIMMAX
					cOBS := STR0010 //'Normal'
				ElseIf TRB->QUANTID < TM8->TM8_LIMMIN
					cOBS := STR0011 //'A Baixo'
				ElseIf TRB->QUANTID > TM8->TM8_LIMMAX
					cOBS := STR0012 //'Acima'
				Endif
	
				@Li,162 PSay cOBS PICTURE '@!'
	
				lPRIN := .f.
	
				dbSelectArea("TRB")
				dbSKIP()
	
			End
	
			If ccCUSTO == TRB->CCUSTO
				Somalinha()
			Endif
	
		End
	
		Somalinha()
	End 

Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRB")
dbGotop()
If RecCount()==0
	MsgInfo(STR0037)  //"Não há nada para imprimir no relatório."
	oTempTRB:Delete()
	RetIndex("TM5")
	Set Filter To
	Return .F.
Endif

RetIndex("TM5")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
oTempTRB:Delete() 

dbSelectArea("TM5")
Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportPrint³ Autor ³ Rafael Diogo Richter  ³ Data ³28/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Chamada do Relat¢rio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMNT                                                     ³±±
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

Local oSection0 
Local oSection1 
Local oSection2

Private cOBS

Processa({|lEND| U_MDTR484TM5()},STR0024) //"Processando Arquivo..."

dbSelectArea("TRB")
dbGotop()
If RecCount()==0
	MsgInfo(STR0037)  //"Não há nada para imprimir no relatório."
	oTempTRB:Delete()
	Return .F.
Endif

If lSigaMdtps

	oSection0 := oReport:Section(1)
	oSection1 := oReport:Section(2)
	oSection2 := oReport:Section(3)

	oReport:SetMeter(RecCount())
	While !Eof() .And. !oReport:Cancel()
			
		oReport:IncMeter()
			
		cCliente := TRB->CLIENT+TRB->LOJA
		oSection0:Init()
		oSection0:PrintLine()
		
		While !Eof() .and. cCliente == TRB->CLIENT+TRB->LOJA .and. !oReport:Cancel()
		
			ccCUSTO := TRB->CCUSTO
		      
			oSection1:Init()
			oSection1:PrintLine()
		      
			dbSelectArea("TRB")
			While !Eof() .AND. ccCUSTO == TRB->CCUSTO .And. !oReport:Cancel()
				  
				oSection2:Init()
				    
				cMAT := TRB->MATRIC
		
				lPRIN := .t.
				oSection2:Cell("TRB->MATRIC"):Show()
				oSection2:Cell("RA_NOME"):Show()
	
				dbSelectArea("TRB")
				While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC .And. !oReport:Cancel()
		
					dbSelectArea("TM8")
					dbSetOrder(01)
					dbSeek(xFilial("TM8")+TRB->EXAME+TRB->SUBITEM)
		
					cOBS := STR0010 //'Normal'
		
					If TRB->QUANTID >= TM8->TM8_LIMMIN  .and. TRB->QUANTID <= TM8->TM8_LIMMAX
						cOBS := STR0010 //'Normal'
					ElseIf TRB->QUANTID < TM8->TM8_LIMMIN
						cOBS := STR0011 //'A Baixo'
					ElseIf TRB->QUANTID > TM8->TM8_LIMMAX
						cOBS := STR0012 //'Acima'
					Endif
		            
					oSection2:PrintLine()
		            
					oSection2:Cell("TRB->MATRIC"):Hide()
					oSection2:Cell("RA_NOME"):Hide()
		
					dbSelectArea("TRB")
					dbSKIP()
				End
				oSection2:Finish()
			End
			oSection1:Finish()
		End					
		oSection0:Finish()
		
	End
		
Else

	oSection1 := oReport:Section(1)
	oSection2 := oReport:Section(2)

	oReport:SetMeter(RecCount())
	While !Eof() .And. !oReport:Cancel()
			
		oReport:IncMeter()
			
		ccCUSTO := TRB->CCUSTO
	      
		oSection1:Init()
		oSection1:PrintLine()
	      
		dbSelectArea("TRB")
		While !Eof() .AND. ccCUSTO == TRB->CCUSTO .And. !oReport:Cancel()
			  
			oSection2:Init()
			    
			cMAT := TRB->MATRIC
	
			lPRIN := .t.
			oSection2:Cell("TRB->MATRIC"):Show()
			oSection2:Cell("RA_NOME"):Show()
	
			dbSelectArea("TRB")
			While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC .And. !oReport:Cancel()
	
				dbSelectArea("TM8")
				dbSetOrder(01)
				dbSeek(xFilial("TM8")+TRB->EXAME+TRB->SUBITEM)
	
				cOBS := STR0010 //'Normal'
	
				If TRB->QUANTID >= TM8->TM8_LIMMIN  .and. TRB->QUANTID <= TM8->TM8_LIMMAX
					cOBS := STR0010 //'Normal'
				ElseIf TRB->QUANTID < TM8->TM8_LIMMIN
					cOBS := STR0011 //'A Baixo'
				ElseIf TRB->QUANTID > TM8->TM8_LIMMAX
					cOBS := STR0012 //'Acima'
				Endif
	            
				oSection2:PrintLine()
	            
				oSection2:Cell("TRB->MATRIC"):Hide()
				oSection2:Cell("RA_NOME"):Hide()
	
				dbSelectArea("TRB")
				dbSKIP()
			End
			oSection2:Finish()
		End
		oSection1:Finish()
	End

Endif

oTempTRB:Delete()

Return .T.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
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
    //   Li--
    EndIf
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTR484TM5 ³ Autor ³ Ricardo Dalponte      ³ Data ³09/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Processa o arquivo de roteio..                               ³±±
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
User Function MDTR484TM5()
Local nTamMat := TAMSX3("RA_MAT")[1]
//LOCAL lContinua := .T.
Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])
Private aVetinr := {}

If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{"CLIENT" ,"C",nTa1,0}) 
	AADD(aDBF,{"LOJA"   ,"C",nTa1L,0})
	AADD(aDBF,{"CCUSTO" ,"C",nSizeSI3,0})
	AADD(aDBF,{"MATRIC" ,"C",nTamMat,0}) 
	AADD(aDBF,{"DTREAL" ,"D",10,0}) 
	AADD(aDBF,{"EXAME"  ,"C",nTamExa,0}) 
	AADD(aDBF,{"SUBITEM","C",06,0}) 
	AADD(aDBF,{"QUANTID","N",13,3}) 
	
	//Cria TRB

	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CLIENT","LOJA","CCUSTO","MATRIC"} )
	oTempTRB:Create()
	
	dbSelectArea("TM5")
	dbSetOrder(07)  //TM5_FILIAL+TM5_CC+TM5_EXAME
	dbSeek(xFilial("TM5")+MV_PAR01+MV_PAR02,.T.)
	
	ProcRegua(LastRec())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  Exames realizados                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	While !Eof()                              .AND.;
	      TM5->TM5_FILIAL == xFIlial('TM5')   .AND.;
	      SubStr(TM5->TM5_CC,1,nSizeTD) <= MV_PAR03+MV_PAR04
	
	      IncProc()
	      
	      If TM5->TM5_CC < mv_par05 .or. TM5->TM5_CC > mv_par06
	          dbSKIP()
	          loop
	      Endif
	
	      If Empty(TM5->TM5_DTRESU)
	          dbSKIP()
	          loop
	      Endif
	      If TM5->TM5_EXAME < MV_PAR07 .or. TM5->TM5_EXAME > MV_PAR08
	          dbSelectArea("TM5") 
	          dbSKIP()
	          loop
	      Endif
	
	      If TM5->TM5_DTRESU < MV_PAR13 .or. TM5->TM5_DTRESU > MV_PAR14
	          dbSelectArea("TM5")
	          dbSKIP()
	          loop
	      Endif
	 
	      dbSelectArea("TM6")
	      dbSetOrder(01)
	      dbSeek(xFilial("TM6")+TM5->TM5_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_EXAME)
	      While !Eof()                              .AND.;
	            TM6->TM6_FILIAL == xFIlial('TM6')   .AND.;
	            TM6->TM6_NUMFIC == TM5->TM5_NUMFIC  .AND.;
	            TM6->TM6_DTPROG == TM5->TM5_DTPROG  .AND.;
	            TM6->TM6_EXAME == TM5->TM5_EXAME
	
	         If TM6->TM6_ITEM < MV_PAR09 .or. TM6->TM6_ITEM > MV_PAR10
	             dbSelectArea("TM6")
	             dbSKIP()
	             loop
	         Endif
	
	         If TM6->TM6_QTDITE >= MV_PAR11 .and. TM6->TM6_QTDITE <= MV_PAR12
	             dbSelectArea("TRB")
	             TRB->(DbAppend())
	             TRB->CCUSTO  := TM5->TM5_CC
	             TRB->MATRIC  := TM5->TM5_MAT
	             TRB->DTREAL  := TM5->TM5_DTRESU
	             TRB->EXAME   := TM5->TM5_EXAME
	             TRB->SUBITEM := TM6->TM6_ITEM
	             TRB->QUANTID := TM6->TM6_QTDITE
	             TRB->CLIENT  := Substr(TM5->TM5_CC,1,nTa1)
	             TRB->LOJA    := Substr(TM5->TM5_CC,nTa1+1,nSizeTD)
	         Endif
	
	         dbSelectArea("TM6")
	         dbSkip()
	
	      End
	      dbSelectArea("TM5")
	      dbSkip()
	End

Else

	PRIVATE nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	
	aDBF := {}
	AADD(aDBF,{"CCUSTO" ,"C",nSizeSI3,0})
	AADD(aDBF,{"MATRIC" ,"C",nTamMat,0}) 
	AADD(aDBF,{"DTREAL" ,"D",10,0}) 
	AADD(aDBF,{"EXAME"  ,"C",nTamExa,0}) 
	AADD(aDBF,{"SUBITEM","C",06,0}) 
	AADD(aDBF,{"QUANTID","N",13,3}) 
			
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CCUSTO","MATRIC"} )
	oTempTRB:Create()
	
	dbSelectArea("TM5")
	dbSetOrder(07)
	dbSeek(xFilial("TM5")+MV_PAR01,.T.)
	
	ProcRegua(LastRec())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  Exames realizados                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	While !Eof()                              .AND.;
	      TM5->TM5_FILIAL == xFIlial('TM5')   .AND.;
	      TM5->TM5_CC <= MV_PAR02
	
	      IncProc()
	
	      If Empty(TM5->TM5_DTRESU)
	          dbSelectArea("TM5")
	          dbSKIP()
	          loop
	      Endif
	
	      If TM5->TM5_EXAME < MV_PAR03 .or. TM5->TM5_EXAME > MV_PAR04
	          dbSelectArea("TM5")
	          dbSKIP()
	          loop
	      Endif
	
	      If TM5->TM5_DTRESU < MV_PAR09 .or. TM5->TM5_DTRESU > MV_PAR10
	          dbSelectArea("TM5")
	          dbSKIP()
	          loop
	      Endif
	 
	      dbSelectArea("TM6")
	      dbSetOrder(01)
	      dbSeek(xFilial("TM6")+TM5->TM5_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_EXAME)
	      While !Eof()                              .AND.;
	            TM6->TM6_FILIAL == xFIlial('TM6')   .AND.;
	            TM6->TM6_NUMFIC == TM5->TM5_NUMFIC  .AND.;
	            TM6->TM6_DTPROG == TM5->TM5_DTPROG  .AND.;
	            TM6->TM6_EXAME == TM5->TM5_EXAME
	
	         If TM6->TM6_ITEM < MV_PAR05 .or. TM6->TM6_ITEM > MV_PAR06
	             dbSelectArea("TM6")
	             dbSKIP()
	             loop
	         Endif
	
	         If TM6->TM6_QTDITE >= MV_PAR07 .and. TM6->TM6_QTDITE <= MV_PAR08
	             dbSelectArea("TRB")
	             TRB->(DbAppend())
	             TRB->CCUSTO  := TM5->TM5_CC
	             TRB->MATRIC  := TM5->TM5_MAT
	             TRB->DTREAL  := TM5->TM5_DTRESU
	             TRB->EXAME   := TM5->TM5_EXAME
	             TRB->SUBITEM := TM6->TM6_ITEM
	             TRB->QUANTID := TM6->TM6_QTDITE
	         Endif
	
	         dbSelectArea("TM6")
	         dbSkip()
	
	      End
	      dbSelectArea("TM5")
	      dbSkip()
	End

Endif

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ TM8SXBFIL ³ Autor ³ Denis                 ³ Data ³09/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Filtra a consulta TM8                                       ³±±
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
User Function TM8SXBFIL() 
 
If Type("cPROGRAMA") == "C"
	If cPROGRAMA == "MDTR484"
		If lSigaMdtps 
			If TM8->TM8_EXAME < Mv_par07 .or. TM8->TM8_EXAME > Mv_par08
				Return .f.
			Endif
		Else
			If TM8->TM8_EXAME < Mv_par03 .or. TM8->TM8_EXAME > Mv_par04
				Return .f.
			Endif
		Endif 
	Endif
Endif

Return .t.