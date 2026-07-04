/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH" 
#INCLUDE "TMKR509.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR509  ³ Autor ³ Vendas CRM            ³ Data ³ 28/11/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Produtividade por analista e equipe                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMKR501(void)                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR509()
Local oReport	//Objeto relatorio TReport (Release 4)    
Private oTempTable 	:= Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMKR509",.F.)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros				³
//³ Mv_PAR01	// De									³
//³ Mv_PAR02	// Ate									³
//³ Mv_PAR03	// Da Equipe							³
//³ Mv_PAR04	// Do analista							³
//³ Mv_PAR05	// Tipo de Relatorio					³			
//³ MV_PAR06	// Indicador (Chamados Solucionados)	³				
//³ MV_PAR07	// Indicador (Interacoes Produtivas)	³				
//³ MV_PAR08	// Indicador (Interacoes Nao Produtivas)³				
//³ MV_PAR09	// Indicador (Reaberturas)		    	³					
//³ MV_PAR10	// Indicador (Rejeição de uma fnc)    	³						
//³ MV_PAR11	// Indicador (Abertura de Ch.)	    	³							
//³ MV_PAR12	// Exibe sub-equipes ?     			    |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog() 
	
If( valtype(oTempTable) == "O")
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf
Return(.T.)         

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³Vendas CRM          ³ Data ³30/08/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()
Local oReport 				// Objeto relatorio TReport (Release 4)
Local oSection1             // Objeto secao 1 do relatorio (Cabecalho, nome da equipe)
Local oSection2             // Objeto secao 2 do relatorio (Itens, nome do operador)
Local oSection3 			// Objeto secao 3 do relatorio (Chamados solucionados)
Local oSection4 			// Objeto secao 4 do relatorio (Chamados pendentes)
Local oSection5 			// Objeto secao 5 do relatorio (Interacoes)
Local oSection6 			// Objeto secao 6 do relatorio (Infos do analista)
Local oSection7 			// Objeto secao 6 do relatorio (Chamados solucionados em ate 24 hs.)
Local oSection8 			// Objeto secao 6 do relatorio (Chamados solucionados em ate 48 hs.)
Local oSection9 			// Objeto secao 6 do relatorio (Chamados solucionados acima de 48 hs.)
Local oSection10 			// Objeto secao 6 do relatorio (Total de chamados solucionados)
Local cAliasTrb := ""		// Alias da consulta Embedded SQL
Local oBreak				// Break para a seção 3
Local cArqTrb
Local aCampos	:= Tkr509CriaTrb()           
Local lEntPePos := .F.
Local oChamaReabr   
Local oCSTotal  
Local oCSAF   
Local oChamaReje

DbSelectArea("ADE")

lEntPePos := .T.
                                  
cAliasTrb := GetNextAlias()

//-------------------------------------------------------------------
// Instancia tabela temporária.  
//-------------------------------------------------------------------

oTempTable	:= FWTemporaryTable():New( cAliasTrb)

//-------------------------------------------------------------------
// Atribui o  os índices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )

oTempTable:AddIndex("1",{"CODSU0","CODSU7"})
//------------------
//Criação da tabela
//------------------
oTempTable:Create()






DEFINE REPORT oReport NAME "TMKR509" TITLE STR0001 PARAMETER "TMKR509" ACTION {|oReport| Tkr509PrtRpt( oReport, cAliasTrb, cArqTrb, lEntPePos )} DESCRIPTION STR0002 // "Produtividade por analista e equipe" # "Exibe as informações de produtividade do analista e equipe no período consultado"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport 	TITLE STR0003 PAGE BREAK			// "Chamados da área"
DEFINE SECTION oSection2 OF oSection1 	TITLE STR0004	//"Chamados do analista" 				
DEFINE SECTION oSection3 OF oSection2 	TITLE STR0005	//"Chamados solucionados" 	
DEFINE SECTION oSection4 OF oSection2 	TITLE STR0006	//"Chamados pendentes" 	
DEFINE SECTION oSection5 OF oSection2 	TITLE STR0007	//"Interações" 	
DEFINE SECTION oSection6 OF oSection2 	TITLE STR0008	//"Indicadores do analista" 	

DEFINE SECTION oSection7 OF oSection2 	TITLE STR0009	//"Chamados solucionados em até 24 horas" 
DEFINE SECTION oSection8 OF oSection2 	TITLE STR0010	//"Chamados solucionados em até 48 horas"
DEFINE SECTION oSection9 OF oSection2 	TITLE STR0011	//"Chamados solucionados acima de 48 horas"
DEFINE SECTION oSection10 OF oReport 	TITLE STR0030	//"Total de chamados solucionados da Equipe"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "CODSU0"	OF oSection1 ALIAS "" TITLE STR0012	BLOCK {||TRIM((cAliasTrb)->CODSU0 + " - " + POSICIONE('SU0',1,xFilial('SU0')+(cAliasTrb)->CODSU0,'U0_NOME'))} SIZE 30 //"Equipe"
oSection1:Cell("CODSU0"):oFontBody :=  TFont():New("Verdana",0,-9,,.T.,,,,.F.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "CODSU7"	OF oSection2 ALIAS "" TITLE STR0013	BLOCK {||TRIM((cAliasTrb)->CODSU7 + " - " + FATPDObfuscate(POSICIONE('SU7',1,XFILIAL('SU7') + (cAliasTrb)->CODSU7, 'U7_NOME'),"U7_NOME",,.T.))} SIZE 50	// "Analista"
oSection2:Cell("CODSU7"):oFontBody :=  TFont():New("Verdana",0,-9,,.T.,,,,.F.,.F.)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao3³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
DEFINE CELL NAME "TITLE"			OF oSection3 ALIAS "" TITLE STR0005 SIZE 25 //"Chamados solucionados"
oSection3:Cell("TITLE"):oFontBody :=  TFont():New("Verdana",0,-8,,.T.,,,,.F.,.F.)
DEFINE CELL NAME "CS5"				OF oSection3 ALIAS ""		TITLE STR0014 + "|"					BLOCK {|| AllTrim(Str((cAliasTrb)->CS5)) + "|"} ALIGN RIGHT //Critico
DEFINE CELL NAME "CS4"				OF oSection3 ALIAS ""		TITLE STR0015 + "|"   	   				BLOCK {|| AllTrim(Str((cAliasTrb)->CS4)) + "|"} ALIGN RIGHT //Alta
DEFINE CELL NAME "CS3"				OF oSection3 ALIAS ""		TITLE STR0016 + "|"  					BLOCK {|| AllTrim(Str((cAliasTrb)->CS3)) + "|"} ALIGN RIGHT //Media
DEFINE CELL NAME "CS2"				OF oSection3 ALIAS ""		TITLE STR0017 + "|"  					BLOCK {|| AllTrim(Str((cAliasTrb)->CS2)) + "|"} ALIGN RIGHT //Baixa
DEFINE CELL NAME "CS1"				OF oSection3 ALIAS ""		TITLE STR0018 + "|"					BLOCK {|| AllTrim(Str((cAliasTrb)->CS1)) + "|"} ALIGN RIGHT //Melhoria
DEFINE CELL NAME "CSAF"				OF oSection3 ALIAS ""		TITLE STR0019 + "|" 				BLOCK {|| AllTrim(Str((cAliasTrb)->CSAF)) + "|"} ALIGN RIGHT //Abertura FNC
DEFINE CELL NAME "CSTOTAL"			OF oSection3 ALIAS ""		TITLE STR0020 + "|"						BLOCK {|| AllTrim(Str((cAliasTrb)->CSAF+(cAliasTrb)->CS1+(cAliasTrb)->CS2+(cAliasTrb)->CS3+(cAliasTrb)->CS4+(cAliasTrb)->CS5)) + "|"} ALIGN RIGHT // Total
DEFINE CELL NAME "CSSLA"			OF oSection3 ALIAS ""		TITLE STR0021 + "|" 	BLOCK {|| AllTrim(Str(Round(((cAliasTrb)->CSSLA*100)/((cAliasTrb)->CSAF+(cAliasTrb)->CS1+(cAliasTrb)->CS2+(cAliasTrb)->CS3+(cAliasTrb)->CS4+(cAliasTrb)->CS5),2))) + "|"} ALIGN RIGHT   //Solucionados no SLA(%)

                  
DEFINE CELL NAME "TITLE"			OF oSection4 ALIAS "" TITLE STR0006 SIZE 25	  //"Chamados pendentes"
oSection4:Cell("TITLE"):oFontBody :=  TFont():New("Verdana",0,-8,,.T.,,,,.F.,.F.)	  
DEFINE CELL NAME "CPANALISTA"		OF oSection4 ALIAS ""		TITLE STR0013 + "|"	BLOCK {|| AllTrim(Str((cAliasTrb)->CPANALISTA)) + "|"} ALIGN RIGHT //Analista
DEFINE CELL NAME "CPCLIENTE"		OF oSection4 ALIAS ""		TITLE STR0022 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CPCLIENTE)) + "|"} ALIGN RIGHT //Cliente
DEFINE CELL NAME "CPTOTAL"			OF oSection4 ALIAS ""		TITLE STR0020 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CPANALISTA+(cAliasTrb)->CPCLIENTE)) + "|"} ALIGN RIGHT //Total

DEFINE CELL NAME "TITLE"			OF oSection5 ALIAS "" TITLE STR0007 SIZE 25	  //"Interações"
oSection5:Cell("TITLE"):oFontBody :=  TFont():New("Verdana",0,-8,,.T.,,,,.F.,.F.)	                                                
DEFINE CELL NAME "ITPROD"			OF oSection5 ALIAS ""		TITLE STR0023 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->ITPROD)) + "|"} ALIGN RIGHT //Produtivas
DEFINE CELL NAME "ITNPROD"			OF oSection5 ALIAS ""		TITLE STR0024 + "|"	BLOCK {|| AllTrim(Str((cAliasTrb)->ITNPROD)) + "|"} ALIGN RIGHT //Não Produtivas
                                                
DEFINE CELL NAME "TITLE"			OF oSection6 ALIAS "" TITLE STR0008 SIZE 25	  //"Indicadores do analista"
oSection6:Cell("TITLE"):oFontBody :=  TFont():New("Verdana",0,-8,,.T.,,,,.F.,.F.)	  
DEFINE CELL NAME "CHAMAABERT"		OF oSection6 ALIAS ""		TITLE STR0025 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CHAMAABERT)) + "|"} ALIGN RIGHT //Chamados registrados
DEFINE CELL NAME "CHAMAREABR"		OF oSection6 ALIAS ""		TITLE STR0026 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CHAMAREABR)) + "|"} ALIGN RIGHT //Reaberturas de cliente
DEFINE CELL NAME "CHAMAREJEI"		OF oSection6 ALIAS ""		TITLE STR0027 + "|"				BLOCK {|| AllTrim(Str((cAliasTrb)->CHAMAREJEI)) + "|"} ALIGN RIGHT //FNC rejeitadas
DEFINE CELL NAME "DIASTRAB"			OF oSection6 ALIAS ""		TITLE STR0028 + "|"			BLOCK {|| AllTrim(Str((cAliasTrb)->DIASTRAB)) + "|"} ALIGN RIGHT //Dias trabalhados
DEFINE CELL NAME "CHAMAMEDIA"		OF oSection6 ALIAS ""		TITLE STR0029 + "|" BLOCK {|| AllTrim(Str(Round(((cAliasTrb)->CSAF+(cAliasTrb)->CS1+(cAliasTrb)->CS2+(cAliasTrb)->CS3+(cAliasTrb)->CS4+(cAliasTrb)->CS5)/(cAliasTrb)->DIASTRAB,2))) + "|"} ALIGN RIGHT //Média de chamados solucionados

DEFINE CELL NAME "TAM"				OF oSection6 ALIAS ""		TITLE "Tempo Total" + "|"		BLOCK {|| AllTrim((cAliasTrb)->TAM) + "|"} ALIGN RIGHT 
DEFINE CELL NAME "TMA"				OF oSection6 ALIAS ""		TITLE "TMA" + "|"		BLOCK {|| AllTrim((cAliasTrb)->TMA) + "|"} ALIGN RIGHT 
                                                
DEFINE CELL NAME "TITLE"			OF oSection7 ALIAS "" TITLE STR0009 SIZE 50	  //"Chamados solucionados em até 24 horas"
oSection7:Cell("TITLE"):oFontBody :=  TFont():New("Verdana",0,-8,,.T.,,,,.F.,.F.)	  
DEFINE CELL NAME "CS245"			OF oSection7 ALIAS ""		TITLE STR0014 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CS245)) + "|"} ALIGN RIGHT //Critico
DEFINE CELL NAME "CS244"			OF oSection7 ALIAS ""		TITLE STR0015 + "|"   		BLOCK {|| AllTrim(Str((cAliasTrb)->CS244)) + "|"} ALIGN RIGHT //Alta
DEFINE CELL NAME "CS243"			OF oSection7 ALIAS ""		TITLE STR0016 + "|"  		BLOCK {|| AllTrim(Str((cAliasTrb)->CS243)) + "|"} ALIGN RIGHT //Media
DEFINE CELL NAME "CS242"			OF oSection7 ALIAS ""		TITLE STR0017 + "|"  		BLOCK {|| AllTrim(Str((cAliasTrb)->CS242)) + "|"} ALIGN RIGHT //Baixa
DEFINE CELL NAME "CS241"			OF oSection7 ALIAS ""		TITLE STR0018 + "|"	BLOCK {|| AllTrim(Str((cAliasTrb)->CS241)) + "|"} ALIGN RIGHT //Melhoria
DEFINE CELL NAME "CS24AF"			OF oSection7 ALIAS ""		TITLE STR0019 + "|"	BLOCK {|| AllTrim(Str((cAliasTrb)->CS24AF)) + "|"} ALIGN RIGHT //Abertura FNC
DEFINE CELL NAME "CS24TOTAL"		OF oSection7 ALIAS ""		TITLE STR0020 + "|"		BLOCK {||	AllTrim(Str((cAliasTrb)->CS24AF+(cAliasTrb)->CS241+(cAliasTrb)->CS242+(cAliasTrb)->CS243+(cAliasTrb)->CS244+(cAliasTrb)->CS245)) + "|"} ALIGN RIGHT //Total
                                           
DEFINE CELL NAME "TITLE"			OF oSection8 ALIAS "" TITLE STR0010 SIZE 50	  //"Chamados solucionados em até 48 horas"
oSection8:Cell("TITLE"):oFontBody :=  TFont():New("Verdana",0,-8,,.T.,,,,.F.,.F.)	  
DEFINE CELL NAME "CS485"			OF oSection8 ALIAS ""		TITLE STR0014 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CS485)) + "|"} ALIGN RIGHT //Critico
DEFINE CELL NAME "CS484"			OF oSection8 ALIAS ""		TITLE STR0015 + "|"   		BLOCK {|| AllTrim(Str((cAliasTrb)->CS484)) + "|"} ALIGN RIGHT //Alta
DEFINE CELL NAME "CS483"			OF oSection8 ALIAS ""		TITLE STR0016 + "|"  		BLOCK {|| AllTrim(Str((cAliasTrb)->CS483)) + "|"} ALIGN RIGHT //Media
DEFINE CELL NAME "CS482"			OF oSection8 ALIAS ""		TITLE STR0017 + "|"  		BLOCK {|| AllTrim(Str((cAliasTrb)->CS482)) + "|"} ALIGN RIGHT //Baixa
DEFINE CELL NAME "CS481"			OF oSection8 ALIAS ""		TITLE STR0018 + "|"	BLOCK {|| AllTrim(Str((cAliasTrb)->CS481)) + "|"} ALIGN RIGHT //Melhoria
DEFINE CELL NAME "CS48AF"			OF oSection8 ALIAS ""		TITLE STR0019 + "|"	BLOCK {|| AllTrim(Str((cAliasTrb)->CS48AF)) + "|"} ALIGN RIGHT //Abertura FNC
DEFINE CELL NAME "CS48TOTAL"		OF oSection8 ALIAS ""		TITLE STR0020 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CS48AF+(cAliasTrb)->CS481+(cAliasTrb)->CS482+(cAliasTrb)->CS483+(cAliasTrb)->CS484+(cAliasTrb)->CS485)) + "|"} ALIGN RIGHT //Total
                                                     
DEFINE CELL NAME "TITLE"			OF oSection9 ALIAS "" TITLE STR0011 SIZE 50	  //"Chamados solucionados acima de 48 horas"
oSection9:Cell("TITLE"):oFontBody :=  TFont():New("Verdana",0,-8,,.T.,,,,.F.,.F.)	  
DEFINE CELL NAME "CS48_5"			OF oSection9 ALIAS ""		TITLE STR0014 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CS48_5)) + "|"} ALIGN RIGHT //Critico
DEFINE CELL NAME "CS48_4"			OF oSection9 ALIAS ""		TITLE STR0015 + "|"   		BLOCK {|| AllTrim(Str((cAliasTrb)->CS48_4)) + "|"} ALIGN RIGHT //Alta
DEFINE CELL NAME "CS48_3"			OF oSection9 ALIAS ""		TITLE STR0016 + "|"  		BLOCK {|| AllTrim(Str((cAliasTrb)->CS48_3)) + "|"} ALIGN RIGHT //Media
DEFINE CELL NAME "CS48_2"			OF oSection9 ALIAS ""		TITLE STR0017 + "|"  		BLOCK {|| AllTrim(Str((cAliasTrb)->CS48_2)) + "|"} ALIGN RIGHT //Baixa
DEFINE CELL NAME "CS48_1"			OF oSection9 ALIAS ""		TITLE STR0018 + "|"	BLOCK {|| AllTrim(Str((cAliasTrb)->CS48_1)) + "|"} ALIGN RIGHT //Melhoria
DEFINE CELL NAME "CS48_AF"			OF oSection9 ALIAS ""		TITLE STR0019 + "|"	BLOCK {|| AllTrim(Str((cAliasTrb)->CS48_AF)) + "|"} ALIGN RIGHT //Abertura FNC
DEFINE CELL NAME "CS48_TOTAL"		OF oSection9 ALIAS ""		TITLE STR0020 + "|"		BLOCK {|| AllTrim(Str((cAliasTrb)->CS48_AF+(cAliasTrb)->CS48_1+(cAliasTrb)->CS48_2+(cAliasTrb)->CS48_3+(cAliasTrb)->CS48_4+(cAliasTrb)->CS48_5)) + "|"} ALIGN RIGHT //Total

DEFINE CELL NAME "TITLE"			OF oSection10 ALIAS "" TITLE STR0030 SIZE 25 //"Chamados solucionados"
//oSection10:Cell("TITLE"):oFontBody :=  TFont():New("Verdana",0,-8,,.T.,,,,.F.,.F.)
DEFINE CELL NAME "CS5"				OF oSection10 ALIAS ""		TITLE STR0014 + "|" ALIGN RIGHT					//BLOCK {|| AllTrim(Str((cAliasTrb)->CS5)) + "|"} ALIGN RIGHT //Critico
DEFINE CELL NAME "CSPER5"			OF oSection10 ALIAS ""		TITLE "(%)|" ALIGN RIGHT
DEFINE CELL NAME "CS4"				OF oSection10 ALIAS ""		TITLE STR0015 + "|" ALIGN RIGHT   	   				//BLOCK {|| AllTrim(Str((cAliasTrb)->CS4)) + "|"} ALIGN RIGHT //Alta
DEFINE CELL NAME "CSPER4"			OF oSection10 ALIAS ""		TITLE "(%)|" ALIGN RIGHT
DEFINE CELL NAME "CS3"				OF oSection10 ALIAS ""		TITLE STR0016 + "|" ALIGN RIGHT 					//BLOCK {|| AllTrim(Str((cAliasTrb)->CS3)) + "|"} ALIGN RIGHT //Media
DEFINE CELL NAME "CSPER3"			OF oSection10 ALIAS ""		TITLE "(%)|" ALIGN RIGHT
DEFINE CELL NAME "CS2"				OF oSection10 ALIAS ""		TITLE STR0017 + "|" ALIGN RIGHT 					//BLOCK {|| AllTrim(Str((cAliasTrb)->CS2)) + "|"} ALIGN RIGHT //Baixa
DEFINE CELL NAME "CSPER2"			OF oSection10 ALIAS ""		TITLE "(%)|" ALIGN RIGHT
DEFINE CELL NAME "CS1"				OF oSection10 ALIAS ""		TITLE STR0018 + "|" ALIGN RIGHT					//BLOCK {|| AllTrim(Str((cAliasTrb)->CS1)) + "|"} ALIGN RIGHT //Melhoria
DEFINE CELL NAME "CSPER1"			OF oSection10 ALIAS ""		TITLE "(%)|" ALIGN RIGHT
DEFINE CELL NAME "CSAF"				OF oSection10 ALIAS ""		TITLE STR0019 + "|" ALIGN RIGHT				//BLOCK {|| AllTrim(Str((cAliasTrb)->CSAF)) + "|"} ALIGN RIGHT //Abertura FNC
DEFINE CELL NAME "CSPERAF"			OF oSection10 ALIAS ""		TITLE "(%)|" ALIGN RIGHT
DEFINE CELL NAME "CSTOTAL"			OF oSection10 ALIAS ""		TITLE STR0020 + "|"	ALIGN RIGHT					//BLOCK {|| AllTrim(Str((cAliasTrb)->CSAF+(cAliasTrb)->CS1+(cAliasTrb)->CS2+(cAliasTrb)->CS3+(cAliasTrb)->CS4+(cAliasTrb)->CS5)) + "|"} ALIGN RIGHT // Total
DEFINE CELL NAME "CSPERTOT"			OF oSection10 ALIAS ""		TITLE "(%)|" ALIGN RIGHT

DEFINE BREAK oBreak3 	OF oSection1 WHEN oSection1:Cell("CODSU0") TITLE STR0032 TOTAL IN LINE //"Total de interações da Equipe"
DEFINE BREAK oBreak4 	OF oSection1 WHEN oSection1:Cell("CODSU0") TITLE STR0033 TOTAL IN LINE //"Total de indicadores do analista"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sub totalizadores.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lEntPePos
	DEFINE FUNCTION FROM oSection5:Cell("ITPROD") 	FUNCTION SUM BREAK oBreak3 TITLE STR0023 NO END REPORT NO END SECTION //"Produtivas"
	DEFINE FUNCTION FROM oSection5:Cell("ITNPROD") 	FUNCTION SUM BREAK oBreak3 TITLE STR0024 NO END REPORT NO END SECTION //"Não Produtivas"
Else
	DEFINE FUNCTION FROM oSection5:Cell("ITPROD") 	FUNCTION ONPRINT FORMULA {||U_Tkr509Iter(1, cAliasTrb)} BREAK oBreak3 TITLE STR0023 NO END REPORT NO END SECTION //"Produtivas"
	DEFINE FUNCTION FROM oSection5:Cell("ITNPROD") 	FUNCTION ONPRINT FORMULA {||U_Tkr509Iter(2, cAliasTrb)} BREAK oBreak3 TITLE STR0024 NO END REPORT NO END SECTION //"Não Produtivas"
EndIf

DEFINE FUNCTION oCSTotal FROM oSection10:Cell("CSTOTAL")		FUNCTION SUM 
oCSTotal:Hide()  
                 
DEFINE FUNCTION oCSAF FROM oSection10:Cell("CSAF")				FUNCTION SUM 
oCSAF:Hide()  

DEFINE FUNCTION FROM oSection6:Cell("CHAMAABERT")	FUNCTION SUM BREAK oBreak4 TITLE STR0025 NO END REPORT NO END SECTION //"Chamados registrados"
DEFINE FUNCTION oChamaReabr FROM oSection6:Cell("CHAMAREABR")	FUNCTION SUM BREAK oBreak4 TITLE STR0026 NO END REPORT NO END SECTION //"Reaberturas de cliente"
//DEFINE FUNCTION FROM oSection6:Cell("CHAMAREABR") FUNCTION ONPRINT FORMULA {||Round((oChamaReabr:GetLastValue()*100)/oCSTotal:GetLastValue(),0)} BREAK oBreak4 TITLE STR0026 + " (%)" NO END REPORT NO END SECTION
DEFINE FUNCTION oChamaReje	FROM oSection6:Cell("CHAMAREJEI")	FUNCTION SUM BREAK oBreak4 TITLE STR0027 NO END REPORT NO END SECTION //"FNC rejeitadas"
//DEFINE FUNCTION FROM oSection6:Cell("CHAMAREJEI") FUNCTION ONPRINT FORMULA {||Round((oChamaReje:GetLastValue()*100)/oCSAF:GetLastValue(),0)} BREAK oBreak4 TITLE STR0027 + " (%)" NO END REPORT NO END SECTION
DEFINE FUNCTION FROM oSection6:Cell("DIASTRAB")		FUNCTION MAX BREAK oBreak4 TITLE STR0028 NO END REPORT NO END SECTION //"Dias trabalhados"

oSection10:SetTotalText("")
oReport:SetTotalText("")
Return(oReport)   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr509PrtRpt ³ Autor ³Vendas CRM          ³ Data ³20/07/2008³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio              ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr509PrtRept(ExpO1,ExpC2)                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC1 = alias da query atual                               ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr509PrtRpt(oReport, cAliasTrb, cArqTrb, lEntPePos)
Local oSection1 := oReport:Section(1)		//Objeto secao 1 do relatorio 
Local oSection2 := oSection1:Section(1)		//Objeto secao 2 do relatorio 
Local oSection3 := oSection2:Section(1)		//Objeto secao 3 do relatorio 
Local oSection4 := oSection2:Section(2)		//Objeto secao 4 do relatorio 
Local oSection5 := oSection2:Section(3)		//Objeto secao 5 do relatorio 
Local oSection6 := oSection2:Section(4)		//Objeto secao 6 do relatorio 
Local oSection7 := oSection2:Section(5)		//Objeto secao 7 do relatorio 
Local oSection8 := oSection2:Section(6)		//Objeto secao 8 do relatorio 
Local oSection9 := oSection2:Section(7)		//Objeto secao 9 do relatorio 
Local oSection10:= oReport:Section(2)		//Objeto secao 10 do relatorio 
Local cListSU0E := ""       
Local cListSU7	:= ""
Local cListSU0E1:= ""       
Local cListSU71	:= ""

Local cWhere	:= ""						//Condicoes utilizadas na listagem do indicador  
Local cQuery	:= ""  
Local cAlias1	:= ""
Local cWhereI1  := "" 						// Condicoes utilizadas pelo Indicador 1 (Chamados solucionados)
Local bSQLBlock := {||} 
Local cSeekS2 := ""
Local cSeekS3 := ""
Local cSQLCom := ""         
Local nTotalSol := 0	//Armazena o total de chamados solucionados
Local aChamaSol := Array(6)
Local lTKR509TRB := FindFunction("P_TKR509TRB")		//Project Function para informar o alias da tabela temporária.


      
MakeSqlExpr(oReport:uParam)
cAlias1	:= GetNextAlias()

If Empty(MV_PAR03)
	cListSU0E := "%(1=1)%"
Else
	cListSU0E := "%" + Mv_Par03 + "	%"
EndIf
              
If Empty(MV_PAR04)
	cListSU7 := "%(1=1)%"
Else
	cListSU7 := "%" + MV_PAR04 + "%"
EndIf

cListSU0E1	:= StrTran(cListSU0E,"ADF_","ADF1.ADF_")       
cListSU71	:= StrTran(cListSU7,"ADF_","ADF1.ADF_")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamados Solucionados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0063+"...")	//Chamados Solucionados
cWhereI1 := GetIndicSQL(MV_PAR06, "ADF")
cWhereI2 := GetIndicSQL(MV_PAR06, "ADF2")	
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_SEVCOD, COUNT(*) TOTAL
	FROM %table:ADE% ADE, (
	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF% AND
		ADF.%notDel%   					AND
		%exp:cWhereI1%					AND							
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND			
		%exp:cListSU0E% AND
		%exp:cListSU7% AND
		ADF_FNC = %exp:''% AND
		ADF_CODIGO NOT IN ( SELECT ADF_CODIGO FROM %table:ADF% ADF2 WHERE
		ADF.ADF_FILIAL = ADF2.ADF_FILIAL AND
		ADF.ADF_CODIGO = ADF2.ADF_CODIGO AND
		ADF.ADF_ITEM > ADF2.ADF_ITEM     AND
		%exp:cWhereI2%					 AND
		ADF.ADF_CODSU7 = ADF2.ADF_CODSU7 AND
		ADF.ADF_CODSU0 = ADF2.ADF_CODSU0 AND
		ADF2.ADF_FNC =  %exp:''% )			

		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			
	
	) AUX 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					AND			
		ADE.ADE_CODIGO = AUX.ADF_CODIGO AND
		ADE.ADE_FNC = %exp:''% 				
	GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_SEVCOD 			
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_SEVCOD 			
EndSql	

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
   	oReport:IncMeter()
	Tkr509RecLock(cAliasTRB, cAlias1)
    bSQLBlock := &("{||" + cAliasTRB + "->CS"+ (cAlias1)->ADE_SEVCOD +" += " + AllTrim(Str((cAlias1)->TOTAL)) + "}")                                                     
   	Eval(bSQLBlock)        
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo
(cAlias1)->(DbCloseArea())
If oReport:Cancel()
	Return
EndIf    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamados Solucionados no prazo do SLA³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0064+"...")		//Chamados Solucionados no prazo do SLA
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, COUNT(*) TOTAL
	FROM %table:ADE% ADE, (
	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO, MAX(ADF_DATA) DT_EXP FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF% AND
		ADF.%notDel%   					AND
		%exp:cWhereI1%  AND
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND			
		%exp:cListSU0E% and
		%exp:cListSU7% AND
		ADF_FNC = %exp:' '% AND
		ADF_CODIGO NOT IN ( SELECT ADF_CODIGO FROM %table:ADF% ADF2 WHERE
		ADF.ADF_FILIAL = ADF2.ADF_FILIAL AND
		ADF.ADF_CODIGO = ADF2.ADF_CODIGO AND
		ADF.ADF_ITEM > ADF2.ADF_ITEM     AND
		%exp:cWhereI2%					 AND
		ADF.ADF_CODSU7 = ADF2.ADF_CODSU7 AND
		ADF.ADF_CODSU0 = ADF2.ADF_CODSU0 AND
		ADF2.ADF_FNC = %exp:' '% )			
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			

	) AUX 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					AND			
		ADE.ADE_CODIGO = AUX.ADF_CODIGO	AND
		ADE.ADE_GRUPO  = AUX.ADF_CODSU0 AND
	   	ADE.ADE_DTEXPI >= AUX.DT_EXP	AND
	   	ADE_FNC = %exp:' '%	 				
	GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7 			
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7
EndSql	

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
    (cAliasTRB)->CSSLA += (cAlias1)->TOTAL       
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo
(cAlias1)->(DbCloseArea())    
If oReport:Cancel()
	Return
EndIf    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamados com FNC		³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
oReport:SetMsgPrint(STR0065+"...")		//Chamados com FNC
If lEntPePos 
	cSQLCom := "% ADE_CHORIG = '' %" 
Else
	cSQLCom := "% (1=1) %" 
EndIf
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, COUNT(*) TOTAL
	FROM %table:ADE% ADE, (
	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF%  AND
		ADF.%notDel%   					AND							
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND
		%exp:cListSU0E% and
		%exp:cListSU7% AND
		ADF_FNC <> %exp:' '% AND
		ADF_CODIGO NOT IN ( SELECT ADF_CODIGO FROM %table:ADF% ADF2	WHERE 
		ADF.ADF_FILIAL = ADF2.ADF_FILIAL AND
		ADF.ADF_CODIGO = ADF2.ADF_CODIGO AND
		ADF.ADF_ITEM > ADF2.ADF_ITEM 	 AND
		ADF.ADF_CODSU7 = ADF2.ADF_CODSU7 AND
		ADF.ADF_CODSU0 = ADF2.ADF_CODSU0 AND
		ADF2.ADF_FNC <> %exp:' '% )
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			

	) AUX 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   	AND			
		ADE.ADE_CODIGO = AUX.ADF_CODIGO AND				
		%exp:cSQLCom%
	GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7 			
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7 			
EndSql

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
	(cAliasTRB)->CSAF += (cAlias1)->TOTAL
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo  
(cAlias1)->(DbCloseArea())   
If oReport:Cancel()
	Return
EndIf    
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamados Solucionados no prazo do SLA com FNC³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0066+"...")		//Chamados Solucionados no prazo do SLA com FNC
cWhereI1 := GetIndicSQL(MV_PAR06)  	  		
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, COUNT(*) TOTAL
	FROM %table:ADE% ADE, (
	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO, MAX(ADF_DATA) DT_EXP FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF% AND
		ADF.%notDel%   					AND
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND			
		%exp:cListSU0E% and
		%exp:cListSU7% AND
		ADF_FNC <> %exp:' '%  AND
		ADF_CODIGO NOT IN ( SELECT ADF_CODIGO FROM %table:ADF% ADF2	WHERE 
		ADF.ADF_FILIAL = ADF2.ADF_FILIAL AND
		ADF.ADF_CODIGO = ADF2.ADF_CODIGO AND
		ADF.ADF_ITEM > ADF2.ADF_ITEM 	 AND
		ADF.ADF_CODSU7 = ADF2.ADF_CODSU7 AND
		ADF.ADF_CODSU0 = ADF2.ADF_CODSU0 AND
		ADF2.ADF_FNC <> %exp:' '% )
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			
	
	) AUX 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					AND			
		ADE.ADE_CODIGO = AUX.ADF_CODIGO	AND
	   	ADE.ADE_DTEXPI >= AUX.DT_EXP AND
	   	%exp:cSQLCom%	
	GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7 			
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7
EndSql	

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
    (cAliasTRB)->CSSLA += (cAlias1)->TOTAL       
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo  
(cAlias1)->(DbCloseArea()) 
If oReport:Cancel()
	Return
EndIf    
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamados Pendentes	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
oReport:SetMsgPrint(STR0067+"...")		//Chamados Pendentes
If lEntPePos
 	BeginSQL alias cAlias1                         
		SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_ENTREP, COUNT(*) TOTAL
		FROM %table:ADE% ADE, (
		
			SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO FROM %table:ADF% ADF WHERE
			ADF.ADF_FILIAL = %xFilial:ADF% AND
			ADF.%notDel%   					AND							
			ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND
			%exp:cListSU0E% and
			%exp:cListSU7%
			GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			
		
		) AUX 
		WHERE ADE.ADE_FILIAL = %xFilial:ADE% 	AND 			
			ADE.%notDel%   						AND			
			ADE.ADE_CODIGO = AUX.ADF_CODIGO 	AND 				
			ADE.ADE_STATUS <> '3' 								
		GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_ENTREP 			
		ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_ENTREP 			
    EndSql  
Else
 	BeginSQL alias cAlias1                         
		SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_STATUS, COUNT(*) TOTAL
		FROM %table:ADE% ADE, (
		
			SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO FROM %table:ADF% ADF WHERE
			ADF.ADF_FILIAL = %xFilial:ADF% AND
			ADF.%notDel%   					AND							
			ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND
			%exp:cListSU0E% and
			%exp:cListSU7%
			GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			
		
		) AUX 
		WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
			ADE.%notDel%   					AND			
			ADE.ADE_CODIGO = AUX.ADF_CODIGO	AND
			ADE.ADE_STATUS <> '3' 				
		GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_STATUS 			
		ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE_STATUS 			
    EndSql 	
EndIf

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
	If lEntPePos                           
        If (cAlias1)->ADE_ENTREP == "10"
        	(cAliasTRB)->CPANALISTA += (cAlias1)->TOTAL
        ElseIf (cAlias1)->ADE_ENTREP == "20"
        	(cAliasTRB)->CPCLIENTE += (cAlias1)->TOTAL
        EndIf 
 	Else
        If (cAlias1)->ADE_STATUS $ "12"
        	(cAliasTRB)->CPANALISTA += (cAlias1)->TOTAL
        Else
        	(cAliasTRB)->CPCLIENTE += (cAlias1)->TOTAL
        EndIf      
 	EndIf        
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo
(cAlias1)->(DbCloseArea())  
If oReport:Cancel()
	Return
EndIf        

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interacoes Produtivas	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0068+"...")		//Interações Produtivas
cWhereI1 := GetIndicSQL(MV_PAR07)  	  		
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, SUM(IT) TOTAL
	FROM %table:ADE% ADE, (
	
		SELECT ADF.ADF_CODSU0, ADF.ADF_CODSU7, ADF.ADF_CODIGO, COUNT(*) IT FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF% AND
		ADF.%notDel%   					AND
		%exp:cWhereI1% 					AND							
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND
		%exp:cListSU0E% and
		%exp:cListSU7%
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			
	
	) AUX 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					 AND			
		ADE.ADE_CODIGO = AUX.ADF_CODIGO  AND
		ADE.ADE_GRUPO  = AUX.ADF_CODSU0
	GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7 			
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7
EndSql	

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
    (cAliasTRB)->ITPROD += (cAlias1)->TOTAL       
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo
(cAlias1)->(DbCloseArea())  
If oReport:Cancel()
	Return
EndIf    
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interacoes Nao Produtivas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0069+"...")		//Interações não Produtivas
cWhereI1 := GetIndicSQL(MV_PAR08)  	  		
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, SUM(IT) TOTAL
	FROM %table:ADE% ADE, (
	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO, COUNT(*) IT
		FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF% AND
		ADF.%notDel%   					AND
		%exp:cWhereI1% 					AND							
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND
		%exp:cListSU0E%  and
		%exp:cListSU7%
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			
	
	) AUX 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					 AND			
		ADE.ADE_CODIGO = AUX.ADF_CODIGO	 AND
		ADE.ADE_GRUPO  = AUX.ADF_CODSU0
	GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7 			
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7
EndSql	

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
    (cAliasTRB)->ITNPROD += (cAlias1)->TOTAL       
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo    
(cAlias1)->(DbCloseArea()) 
If oReport:Cancel()
	Return
EndIf    
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamados abertos	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
oReport:SetMsgPrint(STR0070+"...")		//Chamados Abertos
cWhereI1 := GetIndicSQL(MV_PAR11, "ADF")	//Abertura de chamados
cAlias1  := GetNextAlias()
If Upper(TcGetDb()) $ "ORACLE"
 	BeginSQL alias cAlias1                               
 		SELECT ADF_CODSU0, ADF_CODSU7, COUNT(*) TOTAL FROM (
			SELECT ADF.ADF_CODSU0, ADF.ADF_CODSU7, ADF_CODIGO 
			FROM %table:ADE% ADE, %table:ADF% ADF  
			WHERE ADF.ADF_FILIAL = %xFilial:ADF% AND
			ADE.ADE_FILIAL = %xFilial:ADE% AND
			ADF.%notDel%   					AND
			ADE.%notDel%   					AND			
			ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND
			%exp:cListSU0E% and
			%exp:cListSU7% AND
			%exp:cWhereI1% 	AND	
			ADE.ADE_CODIGO = ADF.ADF_CODIGO AND
			%exp:cSQLCom%
			GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO
		) 
		GROUP BY ADF_CODSU0, ADF_CODSU7			 	
    EndSql	
Else
 	BeginSQL alias cAlias1                               
 		SELECT A.ADF_CODSU0, A.ADF_CODSU7, COUNT(*) TOTAL FROM (
			SELECT ADF.ADF_CODSU0, ADF.ADF_CODSU7, ADF_CODIGO 
			FROM %table:ADE% ADE, %table:ADF% ADF  
			WHERE ADF.ADF_FILIAL = %xFilial:ADF% AND
			ADE.ADE_FILIAL = %xFilial:ADE% AND
			ADF.%notDel%   					AND
			ADE.%notDel%   					AND			
			ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND
			%exp:cListSU0E% and
			%exp:cListSU7% AND
			%exp:cWhereI1% 	AND	
			ADE.ADE_CODIGO = ADF.ADF_CODIGO AND
			%exp:cSQLCom%
			GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO
		) AS A 
		GROUP BY A.ADF_CODSU0, A.ADF_CODSU7			 	
    EndSql	    
EndIf

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
    (cAliasTRB)->CHAMAABERT += (cAlias1)->TOTAL       
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo    
(cAlias1)->(DbCloseArea()) 
If oReport:Cancel()
	Return
EndIf    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Reaberturas de cliente	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0071+"...")		//Reaberturas de Cliente
cWhereI1 := GetIndicSQL(MV_PAR09, "ADF")	//Reabertura 
cWhereI2 := GetIndicSQL(MV_PAR06, "ADF1")  	//Solucão
	cAlias1  := GetNextAlias()

 	BeginSQL alias cAlias1                         
 		SELECT AUX1.ADF_CODSU0, AUX1.ADF_CODSU7, COUNT(*) TOTAL FROM (
			SELECT ADF1.ADF_CODSU0, ADF1.ADF_CODSU7, ADF1.ADF_CODIGO, ADF1.ADF_ITEM
			FROM %table:ADF% ADF1, (
			
				SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO, ADF_ITEM,ADF_FILIAL FROM %table:ADF% ADF WHERE
				ADF.ADF_FILIAL = %xFilial:ADF% AND
				ADF.%notDel%   					AND
				%exp:cWhereI1% 					AND
				ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02%

			) AUX 

			WHERE ADF1.ADF_FILIAL = %xFilial:ADF% AND 			
				ADF1.%notDel%   					AND			
				%exp:cListSU0E1% AND
				%exp:cListSU71% AND
				ADF1.ADF_CODIGO = AUX.ADF_CODIGO 	AND
				ADF1.ADF_ITEM = ( SELECT MAX(ADF1.ADF_ITEM) FROM %table:ADF% ADF1 WHERE
						 				ADF1.%notDel% AND
						 				ADF1.ADF_FILIAL = AUX.ADF_FILIAL AND			
										ADF1.ADF_CODIGO = AUX.ADF_CODIGO AND
										ADF1.ADF_ITEM < AUX.ADF_ITEM AND
										%exp:cWhereI2% ) AND
				%exp:cWhereI2%
			GROUP BY ADF1.ADF_CODSU0, ADF1.ADF_CODSU7, ADF1.ADF_CODIGO, ADF1.ADF_ITEM 
		) AUX1 GROUP BY AUX1.ADF_CODSU0, AUX1.ADF_CODSU7 ORDER BY AUX1.ADF_CODSU0, AUX1.ADF_CODSU7
    EndSql		    

	Tkr509Meter(oReport,cAlias1)
	
    While (cAlias1)->(!Eof())
	    oReport:IncMeter()       	
		Tkr509RecLock(cAliasTRB, cAlias1)
        (cAliasTRB)->CHAMAREABR += (cAlias1)->TOTAL       
       	MsUnlock()       
    	(cAlias1)->(DbSkip())
    EndDo    
    (cAlias1)->(DbCloseArea())  
	If oReport:Cancel()
		Return
	EndIf    
 
   	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Rejeicao de FNC			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0072+"...")		//Rejeições de FNC
cWhereI1 := GetIndicSQL(MV_PAR10, "ADF1")  	  		
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, COUNT(*) TOTAL
	FROM %table:ADF% ADF1, (
	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO, ADF_ITEM 
		FROM %table:ADE% ADE, %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF%  AND
		ADE.ADE_FILIAL = %xFilial:ADE%  AND
		ADF.%notDel%   					AND
		ADE.%notDel%   					AND			
		ADF.ADF_FNC <> %exp:' '%			AND
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND			
		%exp:cListSU0E% and
		%exp:cListSU7% AND
	   	ADE.ADE_CODIGO = ADF.ADF_CODIGO AND
		%exp:cSQLCom%						
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO, ADF_ITEM			
	
	) AUX 
	WHERE ADF1.ADF_FILIAL = %xFilial:ADF%   AND 			
		ADF1.%notDel%   					AND			
		%exp:cWhereI1% 						AND
		ADF1.ADF_CODIGO = AUX.ADF_CODIGO 	AND
		ADF1.ADF_ITEM > AUX.ADF_ITEM		
	GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7, AUX.ADF_CODIGO			
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7, AUX.ADF_CODIGO 			
EndSql

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
    (cAliasTRB)->CHAMAREJEI += (cAlias1)->TOTAL       
   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo    
(cAlias1)->(DbCloseArea()) 
If oReport:Cancel()
	Return
EndIf    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Dias trabalhados			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0073+"...")		//Dias Trabalhados
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1      
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, COUNT(*) TOTAL FROM ( 		                        	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_DATA FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF% AND
		ADF.%notDel%   					AND			
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND			
		%exp:cListSU0E% and
		%exp:cListSU7%
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_DATA 		
	) AUX		
	GROUP BY AUX.ADF_CODSU0, AUX.ADF_CODSU7		
EndSql

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
   	If (lEntPePos .AND. AllTrim(Upper((cAlias1)->ADF_CODSU7)) <> "AUTO") .OR.  !lEntPePos
		Tkr509RecLock(cAliasTRB, cAlias1)
        (cAliasTRB)->DIASTRAB += (cAlias1)->TOTAL    
        (cAliasTRB)->TAM := TK510TAME(	Nil, 	   					Mv_Par01, 						Mv_Par02, 					(cAlias1)->ADF_CODSU0,; 
										(cAlias1)->ADF_CODSU0, 		(cAlias1)->ADF_CODSU7, 			(cAlias1)->ADF_CODSU7 )
        (cAliasTRB)->TMA := TK510TMA(	Nil, 						Mv_Par01, 						Mv_Par02, 					(cAlias1)->ADF_CODSU0,; 
										(cAlias1)->ADF_CODSU0, 		(cAlias1)->ADF_CODSU7, 			(cAlias1)->ADF_CODSU7 )
           
       	MsUnlock()       
  	EndIf
	(cAlias1)->(DbSkip())
EndDo    
(cAlias1)->(DbCloseArea()) 
If oReport:Cancel()
	Return
EndIf    
        
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamados Solucionados (Prazo de atendimento)³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0074+"...")			//Chamados Solucionados (Prazo de Atendimento)
cWhereI1 := GetIndicSQL(MV_PAR06, "ADF")
cWhereI2 := GetIndicSQL(MV_PAR06, "ADF2")		
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE.ADE_SEVCOD, ADE.ADE_DATA,	AUX.DT_EXP DT_EXP 
	FROM %table:ADE% ADE, (
	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO, MAX(ADF_DATA) DT_EXP FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF% AND
		ADF.%notDel%   					AND
		%exp:cWhereI1%  AND
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND			
		%exp:cListSU0E% and
		%exp:cListSU7% AND
		ADF_FNC = %exp:' '% AND
		ADF_CODIGO NOT IN ( SELECT ADF_CODIGO FROM %table:ADF% ADF2 WHERE
		ADF.ADF_FILIAL = ADF2.ADF_FILIAL AND
		ADF.ADF_CODIGO = ADF2.ADF_CODIGO AND
		ADF.ADF_ITEM > ADF2.ADF_ITEM     AND
		%exp:cWhereI2%					 AND
		ADF.ADF_CODSU7 = ADF2.ADF_CODSU7 AND
		ADF.ADF_CODSU0 = ADF2.ADF_CODSU0 AND
		ADF2.ADF_FNC =  %exp:' '% )	
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			
	
	) AUX 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					AND			
		ADE.ADE_CODIGO = AUX.ADF_CODIGO	AND
		ADE.ADE_GRUPO  = AUX.ADF_CODSU0 AND
	   	ADE_FNC = %exp:' '%	 							
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7
EndSql	        
TCSetField(cAlias1, 'ADE_DATA',	'D')
TCSetField(cAlias1, 'DT_EXP',	'D')    

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
	dDataAbertura 	:= (cAlias1)->ADE_DATA
	dDataUltIter	:= (cAlias1)->DT_EXP
	nDiff			:= dDataUltIter - dDataAbertura 		 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Validacao para contablizar apenas dias uteis³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	nDiaUtil := -1
	While dDataUltIter >= dDataAbertura
		If DataValida(dDataAbertura) == dDataAbertura
			nDiaUtil++
		EndIf
		   
		If nDiaUtil >= 3
			bSQLBlock := &("{||" + cAliasTRB + "->CS48_"+ (cAlias1)->ADE_SEVCOD +" += 1}")
			Exit
		ElseIf nDiaUtil == 2
			bSQLBlock := &("{||" + cAliasTRB + "->CS48"+ (cAlias1)->ADE_SEVCOD +" += 1}")
		ElseIf nDiaUtil <= 1 
			bSQLBlock := &("{||" + cAliasTRB + "->CS24"+ (cAlias1)->ADE_SEVCOD +" += 1}")
		EndIf
		dDataAbertura++								
	End
   	Eval(bSQLBlock)        								

   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo    
(cAlias1)->(DbCloseArea()) 
If oReport:Cancel()
	Return
EndIf    
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamados Solucionados com FNC (Prazo de atendimento)³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMsgPrint(STR0075+"...")				//Chamados Solucionados com FNC (Prazo de Atendimento)
cWhereI1 := GetIndicSQL(MV_PAR06)  	  		
cAlias1  := GetNextAlias()
BeginSQL alias cAlias1                         
	SELECT AUX.ADF_CODSU0, AUX.ADF_CODSU7, ADE.ADE_DATA,	AUX.DT_EXP DT_EXP 
	FROM %table:ADE% ADE, (
	
		SELECT ADF_CODSU0, ADF_CODSU7, ADF_CODIGO, MAX(ADF_DATA) DT_EXP FROM %table:ADF% ADF WHERE
		ADF.ADF_FILIAL = %xFilial:ADF% AND
		ADF.%notDel%   					AND
		ADF_DATA	BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND			
		%exp:cListSU0E% and
		%exp:cListSU7% AND
		ADF_FNC <> %exp:' '% AND
		ADF_CODIGO NOT IN ( SELECT ADF_CODIGO FROM %table:ADF% ADF2	WHERE 
		ADF.ADF_FILIAL = ADF2.ADF_FILIAL AND
		ADF.ADF_CODIGO = ADF2.ADF_CODIGO AND
		ADF.ADF_ITEM > ADF2.ADF_ITEM 	 AND
		ADF.ADF_CODSU7 = ADF2.ADF_CODSU7 AND
		ADF.ADF_CODSU0 = ADF2.ADF_CODSU0 AND
		ADF2.ADF_FNC <> %exp:' '% )
		GROUP BY ADF_CODSU0, ADF_CODSU7, ADF_CODIGO			
	
	) AUX 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					AND			
		ADE.ADE_CODIGO = AUX.ADF_CODIGO	AND
		%exp:cSQLCom%
	ORDER BY AUX.ADF_CODSU0, AUX.ADF_CODSU7
EndSql	        

TCSetField(cAlias1, 'ADE_DATA',	'D')
TCSetField(cAlias1, 'DT_EXP',	'D')    

Tkr509Meter(oReport,cAlias1)

While (cAlias1)->(!Eof())
    oReport:IncMeter()       	
	Tkr509RecLock(cAliasTRB, cAlias1)
	dDataAbertura 	:= (cAlias1)->ADE_DATA
	dDataUltIter	:= (cAlias1)->DT_EXP
	nDiff			:= dDataUltIter - dDataAbertura 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Validacao para contablizar apenas dias uteis³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	nDiaUtil := -1
	While dDataUltIter >= dDataAbertura
		If DataValida(dDataAbertura) == dDataAbertura
			nDiaUtil++
		EndIf
		   
		If nDiaUtil >= 3
			bSQLBlock := &("{||" + cAliasTRB + "->CS48_AF += 1}")
			Exit
		ElseIf nDiaUtil == 2
			bSQLBlock := &("{||" + cAliasTRB + "->CS48AF += 1}")
		ElseIf nDiaUtil <= 1 
			bSQLBlock := &("{||" + cAliasTRB + "->CS24AF += 1}")
		EndIf
		dDataAbertura++								
	End		
   	Eval(bSQLBlock)        								

   	MsUnlock()       
	(cAlias1)->(DbSkip())
EndDo
(cAlias1)->(DbCloseArea())   
If oReport:Cancel()
	Return
EndIf    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressão do relatório³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea(cAliasTRB)                                                            

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ponto de entrada para permitir a manipulação dos dados da ³
//³ da tabela temporária. (Project Function)				  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lTKR509TRB
     P_TKR509TRB(cAliasTRB)
EndIf
(cAliasTRB)->(DbGoTop())
BEGIN REPORT QUERY oSection1
	BeginSQL alias cAliasTRB   		
	(cAliasTRB)->(DbGoTop()) 
 	EndSql    
END REPORT QUERY oSection1 		

oSection2:SetParentQuery() 
oSection2:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0},{|| (cAliasTRB)->CODSU0}) 	

oSection3:SetParentQuery() 
oSection3:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7},{|| (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7}) 		

oSection4:SetParentQuery() 
oSection4:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7},{|| (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7}) 		

oSection5:SetParentQuery() 
oSection5:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7},{|| (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7}) 			

oSection6:SetParentQuery() 
oSection6:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7},{|| (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7}) 				

oSection7:SetParentQuery() 
oSection7:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7},{|| (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7}) 					

oSection8:SetParentQuery() 
oSection8:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7},{|| (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7}) 					

oSection9:SetParentQuery() 
oSection9:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7},{|| (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7}) 							

oSection10:SetParentQuery() 
oSection10:SetParentFilter({|cParam|cParam == (cAliasTRB)->CODSU0},{|| (cAliasTRB)->CODSU0})



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//oSection1:Print()         
If (cAliasTRB)->(!EOF())
	cSeekS2 := ""//(cAliasTRB)->CODSU0 
	cSeekS3 := ""//(cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7
EndIf   

If MV_PAR05 == 2
	oSection2:Hide()
	oSection3:Hide()
	oSection4:Hide()
	oSection5:Hide()
	oSection6:Hide()
	oSection7:Hide()
	oSection8:Hide()
	oSection9:Hide()	
EndIf

While (cAliasTRB)->(!EOF())

	If oReport:Cancel()
		Return
	EndIf    
    
	nTotalSol	 := 0
    aChamaSol[1] := 0  
	aChamaSol[2] := 0
	aChamaSol[3] := 0
	aChamaSol[4] := 0
	aChamaSol[5] := 0
	aChamaSol[6] := 0 			

    oSection1:Init()         
    oSection1:PrintLine()		

	While (cAliasTRB)->(!EOF())
	    oSection2:Init()              
	    cSeekS2 := (cAliasTRB)->CODSU0		    
	    oSection2:PrintLine()
	     
		While (cAliasTRB)->(!EOF())
			If 	!((cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7 == cSeekS3)			    			    
			    cSeekS3 := (cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7			    
		    EndIf 
		    
		    nTotalSol += (cAliasTrb)->CSAF+(cAliasTrb)->CS1+(cAliasTrb)->CS2+(cAliasTrb)->CS3+(cAliasTrb)->CS4+(cAliasTrb)->CS5		//Chamado solucionado - TOTAL

		    aChamaSol[1] += (cAliasTrb)->CS1		//Chamado solucionado - Melhoria 
		    aChamaSol[2] += (cAliasTrb)->CS2		//Chamado solucionado - Baixo
		    aChamaSol[3] += (cAliasTrb)->CS3		//Chamado solucionado - Medio
		    aChamaSol[4] += (cAliasTrb)->CS4		//Chamado solucionado - Alta
		    aChamaSol[5] += (cAliasTrb)->CS5		//Chamado solucionado - Critico
		    aChamaSol[6] += (cAliasTrb)->CSAF		//Chamado solucionado - Abertura de FNC
		    
		    oSection3:Init() 
		    oSection3:PrintLine()				    
		    oSection3:Finish()		        
		    
		    oSection4:Init()         
		    oSection4:PrintLine()					    
		    oSection4:Finish()		    		    
		    
		    oSection5:Init()         
		    oSection5:PrintLine()					    
		    oSection5:Finish()	 
		    
		    oSection6:Init()         
		    oSection6:PrintLine()					    
		    oSection6:Finish()	
		    
		    oSection7:Init()         
		    oSection7:PrintLine()					    
		    oSection7:Finish()		    		    		    
		    
		    oSection8:Init()         
		    oSection8:PrintLine()					    
		    oSection8:Finish()			                          
		    
		    oSection9:Init()         
		    oSection9:PrintLine()					    
		    oSection9:Finish()			    
		    
		    oReport:SkipLine() 
			(cAliasTRB)->(DbSkip())
			If 	(cAliasTRB)->(EOF()) .OR. (cAliasTRB)->(!EOF()) .AND. !((cAliasTRB)->CODSU0+(cAliasTRB)->CODSU7 == cSeekS3)	
			    Exit		       	    	
			EndIf		
		EndDo
		oSection2:Finish()                        
		If 	(cAliasTRB)->(EOF()) .OR. (cAliasTRB)->(!EOF()) .AND. !((cAliasTRB)->CODSU0 == cSeekS2)			     
		    Exit		       	    	 	
		EndIf	
	EndDo
	
    oSection10:Init()   
    oSection10:Cell("CS1"):setValue("0|")
    oSection10:Cell("CS2"):setValue("0|")
    oSection10:Cell("CS3"):setValue("0|")
    oSection10:Cell("CS4"):setValue("0|")
    oSection10:Cell("CS5"):setValue("0|")
    oSection10:Cell("CSAF"):setValue("0|")
    oSection10:Cell("CSTOTAL"):setValue("0|")  
    
    oSection10:Cell("CSPER1"):setValue("0|")
    oSection10:Cell("CSPER2"):setValue("0|")
    oSection10:Cell("CSPER3"):setValue("0|")
    oSection10:Cell("CSPER4"):setValue("0|")
    oSection10:Cell("CSPER5"):setValue("0|")
    oSection10:Cell("CSPERAF"):setValue("0|")
    oSection10:Cell("CSPERTOT"):setValue("100|")     
        
    oSection10:Cell("CS1" ):setValue( AllTrim( Str(aChamaSol[1]) ) + "|" )	//Chamado solucionado - Melhoria 
    oSection10:Cell("CS2" ):setValue( AllTrim( Str(aChamaSol[2]) ) + "|" )	//Chamado solucionado - Baixo
    oSection10:Cell("CS3" ):setValue( AllTrim( Str(aChamaSol[3]) ) + "|" )	//Chamado solucionado - Medio
    oSection10:Cell("CS4" ):setValue( AllTrim( Str(aChamaSol[4]) ) + "|" )	//Chamado solucionado - Alta
    oSection10:Cell("CS5" ):setValue( AllTrim( Str(aChamaSol[5]) ) + "|" )	//Chamado solucionado - Critico
    oSection10:Cell("CSAF"):setValue( AllTrim( Str(aChamaSol[6]) ) + "|" )	//Chamado solucionado - Abertura de FNC 
    
    oSection10:Cell('CSTOTAL'):setValue( AllTrim( Str(nTotalSol) ) + "|" )	//Chamado solucionado - TOTAL
        
    oSection10:Cell("CSPER1"):setValue(AllTrim( Str(Round(aChamaSol[1]*100/nTotalSol,0) ) ) + "|") 
    oSection10:Cell("CSPER2"):setValue(AllTrim( Str(Round(aChamaSol[2]*100/nTotalSol,0) ) ) + "|")
    oSection10:Cell("CSPER3"):setValue(AllTrim( Str(Round(aChamaSol[3]*100/nTotalSol,0) ) ) + "|")
    oSection10:Cell("CSPER4"):setValue(AllTrim( Str(Round(aChamaSol[4]*100/nTotalSol,0) ) ) + "|")
    oSection10:Cell("CSPER5"):setValue(AllTrim( Str(Round(aChamaSol[5]*100/nTotalSol,0) ) ) + "|")
    oSection10:Cell("CSPERAF"):setValue(AllTrim( Str(Round(aChamaSol[6]*100/nTotalSol,0) ) ) + "|")
    oSection10:Cell("CSPERTOT"):setValue("100|")          
        
    oSection10:PrintLine()					    
    oSection10:Finish()		
	
	oSection1:Finish()                                     
EndDo
Return(.T.)                


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetIndicSQL ºAutor  ³Microsiga         º Data ³  11/28/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna as condicoes da query para atender o indicador.     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetIndicSQL(cCodIndic, cAliasName)
Local cWhere 	:= "" 
Local cQuery	:= ""
Local cAlias	:= GetNextAlias()  

Default cAliasName := "ADF"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a lista de Ocorrências x Acoes listadas no indicador 1	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cQuery := ""
cQuery := "SELECT 	UU_CODSU9,	UU_CODSUQ,	UU_CODSUT,	UU_FILIAL		" 
cQuery += "FROM "+RetSqlName("SUU")+" SUU  WHERE "
cQuery += "SUU.UU_FILIAL = '" + xFilial("SUU") + "' AND "
cQuery += "SUU.UU_CODSUT = '" + cCodIndic + "' AND "
cQuery += "SUU.D_E_L_E_T_<>'*' "
cQuery += "ORDER BY SUU.UU_CODSUT "	    

cQuery	:= ChangeQuery(cQuery)
// MemoWrite("TMKR001.SQL", cQuery)
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias, .F., .T.)	

While	(cAlias)->(!EOF()) .AND.;     
		(cAlias)->UU_FILIAL == xFilial("SUU") .AND.;
		(cAlias)->UU_CODSUT	== cCodIndic
	
	If !Empty(cWhere)
		cWhere += " OR ("		
	Else	                       
	   	cWhere += " ("
	EndIf        
   	                                                        
   	If !Empty((cAlias)->UU_CODSU9)
   		cWhere += " " + cAliasName + ".ADF_CODSU9 = '" + (cAlias)->UU_CODSU9 + "' "
   	EndIf
   	If !Empty((cAlias)->UU_CODSU9) .AND. !Empty((cAlias)->UU_CODSUQ)
   		cWhere += " AND " + cAliasName + ".ADF_CODSUQ = '" + (cAlias)->UU_CODSUQ + "') "
   	ElseIf !Empty((cAlias)->UU_CODSUQ)
   		cWhere += " " + cAliasName + ".ADF_CODSUQ = '" + (cAlias)->UU_CODSUQ + "') "
   	Else          
   		cWhere += ")"	   	
   	EndIf	   		   	
	(cAlias)->(DbSkip())
End         	                                       
(cAlias)->(DbCloseArea())

If !Empty(cWhere)
    	cWhere := "% (" + cWhere + ") %"	
 	Else
 		cWhere := "% (1=1) %"	
EndIf     	

Return cWhere


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Tkr509CriaºAutor  ³Microsiga           º Data ³  11/28/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria os campos do arquivo de trabalho                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr509CriaTrb()
Local aCampos := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria tabela temporaria³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD( aCampos,{"CODSU7"		, TamSX3( "ADE_OPERAD" )[3]	,TamSX3( "ADE_OPERAD" )[1]	,TamSX3( "ADE_OPERAD" )[2] } )
AADD( aCampos,{"CODSU0"		, TamSX3( "ADE_GRUPO" )[3]	,TamSX3( "ADE_GRUPO" )[1] 	,TamSX3( "ADE_GRUPO" )[2] } )
AADD( aCampos,{"CS5"		,"N"						,10							,0 } ) //Chamado solucionado - Critico
AADD( aCampos,{"CS4"		,"N"						,10							,0 } ) //Chamado solucionado - Alta
AADD( aCampos,{"CS3"		,"N"						,10							,0 } ) //Chamado solucionado - Medio
AADD( aCampos,{"CS2"		,"N"						,10							,0 } ) //Chamado solucionado - Baixo
AADD( aCampos,{"CS1"		,"N"						,10							,0 } ) //Chamado solucionado - Melhoria
AADD( aCampos,{"CSAF"		,"N"						,10							,0 } ) //Chamado solucionado - Abertura de FNC
AADD( aCampos,{"CSTOT"		,"N"						,10							,0 } ) //Chamado solucionado - TOTAL
AADD( aCampos,{"CSSLA"		,"N"						,10							,0 } ) //Chamado solucionado - % Solucionados no SLA

AADD( aCampos,{"CPANALISTA"	,"N"						,10							,0 } ) //Chamado pendente - Analista
AADD( aCampos,{"CPCLIENTE"	,"N"						,10							,0 } ) //Chamado pendente - Cliente

AADD( aCampos,{"ITPROD"		,"N"						,10							,0 } ) //Interacoes Produtivas
AADD( aCampos,{"ITNPROD"	,"N"						,10							,0 } ) //Interacoes Nao Produtivas

AADD( aCampos,{"CHAMAABERT"	,"N"						,10							,0 } ) //Chamados abertos
AADD( aCampos,{"CHAMSOLSLA"	,"N"						,10							,0 } ) //Chamados solucionados no prazo SLA
AADD( aCampos,{"CHAMATOT"	,"N"						,10							,0 } ) //Total de Chamados
AADD( aCampos,{"CHAMAREABR"	,"N"						,10							,0 } ) //Total de Chamados Reabertos
AADD( aCampos,{"CHAMAREJEI"	,"N"						,10							,0 } ) //Total de Chamados com FNC rejeitados 
AADD( aCampos,{"DIASTRAB"	,"N"						,10							,0 } ) //Total de dias trabalhados	
AADD( aCampos,{"CHAMAMEDIA"	,"N"						,10							,0 } ) //Media de chamados solucionados
AADD( aCampos,{"CS245"		,"N"						,10							,0 } ) //Chamado solucionado em ate 24 horas - Critico
AADD( aCampos,{"CS244"		,"N"						,10							,0 } ) //Chamado solucionado em ate 24 horas - Alta
AADD( aCampos,{"CS243"		,"N"						,10							,0 } ) //Chamado solucionado em ate 24 horas - Medio
AADD( aCampos,{"CS242"		,"N"						,10							,0 } ) //Chamado solucionado em ate 24 horas - Baixo
AADD( aCampos,{"CS241"		,"N"						,10							,0 } ) //Chamado solucionado em ate 24 horas - Melhoria	
AADD( aCampos,{"CS24AF"		,"N"						,10							,0 } ) //Chamado solucionado em ate 24 horas - Abertura de FNC

AADD( aCampos,{"CS485"		,"N"						,10							,0 } ) //Chamado solucionado em ate 48 horas - Critico
AADD( aCampos,{"CS484"		,"N"						,10							,0 } ) //Chamado solucionado em ate 48 horas - Alta
AADD( aCampos,{"CS483"		,"N"						,10							,0 } ) //Chamado solucionado em ate 48 horas - Medio
AADD( aCampos,{"CS482"		,"N"						,10							,0 } ) //Chamado solucionado em ate 48 horas - Baixo
AADD( aCampos,{"CS481"		,"N"						,10							,0 } ) //Chamado solucionado em ate 48 horas - Melhoria		
AADD( aCampos,{"CS48AF"		,"N"						,10							,0 } ) //Chamado solucionado em ate 48 horas - Abertura de FNC

AADD( aCampos,{"CS48_5"		,"N"						,10							,0 } ) //Chamado solucionado acima de 48 horas - Critico
AADD( aCampos,{"CS48_4"		,"N"						,10							,0 } ) //Chamado solucionado acima de 48 horas - Alta
AADD( aCampos,{"CS48_3"		,"N"						,10							,0 } ) //Chamado solucionado acima de 48 horas - Medio
AADD( aCampos,{"CS48_2"		,"N"						,10							,0 } ) //Chamado solucionado acima de 48 horas - Baixo
AADD( aCampos,{"CS48_1"		,"N"						,10							,0 } ) //Chamado solucionado acima de 48 horas - Melhoria		
AADD( aCampos,{"CS48_AF"	,"N"						,10							,0 } ) //Chamado solucionado acima de 48 horas - Abertura de FNC

AADD( aCampos,{"TAM"		,"C"						,10							,0 } ) //Tempo total de atendimento
AADD( aCampos,{"TMA"		,"C"						,10							,0 } ) //Tempo médio de atendimento

Return aCampos            


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Tkr509RecLockºAutor  ³Michel W. Mosca  º Data ³  12/02/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Realiza o reclock no TRB.                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr509RecLock(cAliasTRB, cAlias1)
Local lFind := .F.

(cAliasTRB)->(DbGoTop()) 
While (cAliasTRB)->(!EOF())
	If 	(cAliasTRB)->CODSU7 == (cAlias1)->ADF_CODSU7 .AND.;
       	(cAliasTRB)->CODSU0 == (cAlias1)->ADF_CODSU0
       	
      	lFind := .T.
       	Exit       	    	
    EndIf       	    	
    (cAliasTRB)->(DbSkip())
End
If !lFind
	RecLock( cAliasTRB, .T. )
    (cAliasTRB)->CODSU7 := (cAlias1)->ADF_CODSU7 
    (cAliasTRB)->CODSU0 := (cAlias1)->ADF_CODSU0
Else
   	RecLock( cAliasTRB, .F. )
EndIf 
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr509Iter   ³ Autor ³Vendas CRM          ³ Data ³21/01/2009³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Calcula o total de interacoes, desconsiderando o usuario    ³±±
±±³          ³portal.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Tkr509Iter()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³nTipo = (1-Produtivas / 2-Nao Produtivas)                   ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
User Function Tkr509Iter(nTipo, cAliasTrb)
Local nTotal := 0                   
Local aArea := (cAliasTrb)->(GetArea())

(cAliasTrb)->(dbGoTop())
While (cAliasTrb)->(!EOF())
	If AllTrim(Upper((cAliasTrb)->CODSU7)) <> "AUTO"
		If nTipo == 1
			nTotal += (cAliasTrb)->ITPROD
		Else
			nTotal += (cAliasTrb)->ITNPROD		
		EndIf
	EndIf
	(cAliasTrb)->(DbSkip())
End
                                       
RestArea(aArea)
Return nTotal

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr509Meter  ³ Autor ³Vendas CRM          ³ Data ³30/06/2009³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula a quantidade de registros da tabela temporária p/  ³±±
±±³          ³ recalcular a regua (meter) de processamento do relatório.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr509Meter(ExpO1,ExpC2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC1 = alias da query atual                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function Tkr509Meter(oReport,cAlias1)

Local nCont := 0

oReport:SetMeter(nCont)

If (cAlias1)->(!Eof())
	(cAlias1)->(dbEval({|| nCont++ }))
	(cAlias1)->(dbGoTop())
	oReport:SetMeter(nCont)
EndIf

Return

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive