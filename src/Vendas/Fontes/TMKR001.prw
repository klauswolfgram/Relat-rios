/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR001.CH"
#INCLUDE "TMKDEF.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR001  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 04/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Ligacoes realizadas no atendimento de Telemarketing        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Telemarketing (SUC)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K ³10/07/03³710   ³Correcao do seek na Tabela SU9 indice 1     ³±±
±±³Andrea F. ³15/04/04³811   ³Revisao do fonte e inclusao de totalizadores³±±
±±³Marcelo K.³12/07/06³8.11  ³bops 102537 - Incluido uma posicao na       ³±±
±±³          ³        ³      ³inicializacao do array aTotOper             ³±±
±±³Michel W. ³13/07/06³101790³Atualizacao de relatorio para release 4.    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR001()
Local oReport //Objeto relatorio TReport (Release 4)
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK001",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                          ³
//³ Mv_Par01           // Do Operador                             ³
//³ Mv_Par02           // Ate o Operador                          ³
//³ Mv_Par03           // A Partir de                             ³
//³ Mv_Par04           // Ate o dia                               ³
//³ Mv_Par05           // Da Midia                                ³
//³ Mv_Par06           // Ate a Midia                             ³
//³ Mv_Par07           // Status da Ligacao                       ³
//³ Mv_Par08           // Entidade         - Vazio seleciona tudo ³
//³ Mv_Par09           // Contato          - Vazio seleciona tudo ³
//³ Mv_Par10	       // Segmento 1       - MV_TMKCTSG,MV_TMKSEGN³
//³ Mv_Par11 	       // Segmento 2                              ³                       
//³ Mv_Par12 		   // Segmento 3                              ³                       
//³ Mv_Par13		   // Segmento 4                              ³
//³ Mv_Par14           // Segmento 5                              ³
//³ Mv_Par15           // Segmento 6                              ³
//³ Mv_Par16           // Segmento 7                              ³ 
//³ Mv_Par17           // Segmento 8       - MV_TMKCTSG,MV_TMKSEGN³
//³ Mv_Par18           // Tipo do Relatorio                       ³
//³ Mv_Par19           // Assunto          - Vazio seleciona tudo ³
//³ Mv_Par20           // Campanha         - Vazio seleciona tudo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog() 

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³TKR001RptDef ³ Autor ³Michel W. Mosca     ³ Data ³13/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Ligacoes realizadas - Telemarketing no release 4.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Hanna C.  ³04/10/07³8.11  ³133983 - Correcao do titulo da celulas      ³±±
±±³          ³        ³      ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()
Local oReport             	//Objeto relatorio TReport (Release 4)
Local oSection1  			//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SUG e SB1)
Local oSection2				//Objeto secao 2 do relatorio (Detalhe, campos das tabelas SU1 e SB1)
Local oSection3				//Objeto secao 3 do relatorio (Detalhe, campos das tabelas SU1 e SB1)
Local oSection4 		    //Objeto secao 4 do relatorio (Detalhe, totalizador das informacoes de operador)
Local oSection5 		    //Objeto secao 5 do relatorio (Detalhe, totalizador das informacoes de operador)
Local oSection6             //Secao Total geral de atendimentos realizados pelo telemarketing
Local oSection7				//Secao Ranking dos operadores
Local oSection8				//Secao midia de maior reconhecimentos
Local oSection9				//Secao midia de maior reconhecimentos X Campanhas
Local oSection10			//Secao campanhas de maior execucao
Local oSection11			//Secao media de atendimento (TMA) dos operadores por campanha
Local cAlias1 := "SUC" 		//Alias da consulta Embedded SQL
Local cSud	  := "SUD" 		//Alias da consulta Embedded SQL 
Local aUC_Status	:= TkSx3Box("UC_STATUS")	// Busca as opcoes do campo no dicionario


cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
cSud		:= cAlias1

//"Ligacoes Realizadas - Telemarketing" # // "Este programa ira emitir uma relacao das Ligacoes"
// "realizadas pelo operador no atendimento Telemarketing" # // "confomre os parametros previamente definidos"
DEFINE REPORT oReport NAME "TMKR001" TITLE STR0001 PARAMETER "TMK001" ACTION {|oReport| Tkr001PrtRpt( oReport, cAlias1, cSud )} DESCRIPTION STR0002 + STR0003 + STR0004

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as secoes do relatorios.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport   	TITLE STR0074 TABLES "SUC"  //Operadores
DEFINE SECTION oSection2 OF oSection1 	TITLE STR0075 TABLES "SUC"  //Cabecalho do Atendimento - Telemarketing
DEFINE SECTION oSection3 OF oSection2 	TITLE STR0076 TABLES "SUD"  //Itens do Atendimento - Telemarketing
DEFINE SECTION oSection4 OF oSection3 	TITLE STR0077 TABLES "SUD"  //Total de Atendimentos do Operador
DEFINE SECTION oSection5 OF oSection4 	TITLE STR0078 				//Total por Data do Operador
DEFINE SECTION oSection6 OF oReport 	TITLE STR0079				//Total Geral de Atendimentos
DEFINE SECTION oSection7 OF oReport 	TITLE STR0080				//Ranking por operador
DEFINE SECTION oSection8 OF oReport 	TITLE STR0059		// TOTALIZADOR: "MIDIA DE MAIOR RECONHECIMENTO"
DEFINE SECTION oSection9 OF oReport 	TITLE STR0082		// TOTALIZADOR: "MIDIA DE MAIOR RECONHECIMENTO POR CAMPANHA"
DEFINE SECTION oSection10 OF oReport 	TITLE STR0062		// TOTALIZADOR: "CAMPANHAS DE MAIOR EXECUÇÃO"
DEFINE SECTION oSection11 OF oReport 	TITLE STR0064		// TOTALIZADOR: "MEDIA DE ATENDIMENTO (T.M.A) DOS OPERADORES POR CAMPANHA"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³SECAO 1 DO RELATORIO  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME ""					OF oSection1 ALIAS "" SIZE 50 BLOCK{||(cAlias1)->UC_OPERADO + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cAlias1)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.)} TITLE STR0012 //Nome do Operador          

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³SECAO 2 DO RELATORIO  ³  
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "UC_CODIGO"		OF oSection2 ALIAS "SUC" TITLE STR0013	// "Atendimento" 		
DEFINE CELL NAME ""					OF oSection2 ALIAS "" TITLE STR0015 SIZE 50 BLOCK{||(cAlias1)->UC_CODCONT+" - "+TkDadosContato((cAlias1)->UC_CODCONT,0,.T.)}	// "Contato"			
DEFINE CELL NAME "UC_DATA"			OF oSection2 ALIAS "SUC" TITLE STR0014	// "Data"						
DEFINE CELL NAME ""					OF oSection2 ALIAS "" SIZE 12 TITLE STR0050 BLOCK{||TkDadosContato((cAlias1)->UC_CODCONT,4,.T.)} // "Fone Com.1"
DEFINE CELL NAME ""		   			OF oSection2 ALIAS "" TITLE STR0019 SIZE 30 BLOCK{||(cAlias1)->UC_OPERADO + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cAlias1)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.)} // "Operador"									
DEFINE CELL NAME ""	   				OF oSection2 ALIAS "" TITLE STR0051 BLOCK{||TkDadosContato((cAlias1)->UC_CODCONT,10,.T.)} // "E-Mail"						
DEFINE CELL NAME "UC_OPERACA"		OF oSection2 ALIAS "SUC" TITLE STR0021 // "Ligacao"						
DEFINE CELL NAME ""					OF oSection2 ALIAS "" TITLE STR0040 BLOCK {||TkrGetDesc(cAlias1)} 	// "Descricao da Entidade"				
DEFINE CELL NAME "UC_STATUS"		OF oSection2 ALIAS "SUC" TITLE STR0024 SIZE 15	BLOCK{||IIF(!Empty((cAlias1)->UC_STATUS),aUC_Status[Val((cAlias1)->UC_STATUS)],"")}// "Status do Atendimento"						
DEFINE CELL NAME ""	   				OF oSection2 ALIAS "" TITLE STR0018 SIZE 40 BLOCK{||TkEntidade((cAlias1)->UC_ENTIDAD,(cAlias1)->UC_CHAVE,1,,.T.)} // "Empresa"						
DEFINE CELL NAME ""					OF oSection2 ALIAS "" TITLE STR0020 SIZE 40 BLOCK{||(cAlias1)->UC_MIDIA + " - " +;	// "Descricao da Midia"
							Posicione("SUH",1,xFilial("SUH")+(cAlias1)->UC_MIDIA,"UH_DESC")}										
DEFINE CELL NAME ""	   				OF oSection2 ALIAS "" TITLE STR0052 SIZE 40 BLOCK{||TkEntidade((cAlias1)->UC_ENTIDAD,(cAlias1)->UC_CHAVE,2,,.T.)+ " - " +; // "Endereco"
							TkEntidade((cAlias1)->UC_ENTIDAD,(cAlias1)->UC_CHAVE,10,,.T.)}										
DEFINE CELL NAME ""					OF oSection2 ALIAS "" TITLE STR0028 SIZE 55 BLOCK{||(cAlias1)->UC_TIPO  + " - " + ;  // "Comunicacao"
							Posicione("SUL",1,xFilial("SUL")+(cAlias1)->UC_TIPO,"UL_DESC")}										
DEFINE CELL NAME ""	   				OF oSection2 ALIAS "" TITLE STR0053 SIZE 40 BLOCK{||TkEntidade((cAlias1)->UC_ENTIDAD,(cAlias1)->UC_CHAVE,3,,.T.)+ " - " +; // "Cidade"
							TkEntidade((cAlias1)->UC_ENTIDAD,(cAlias1)->UC_CHAVE,4,,.T.)}										
DEFINE CELL NAME ""		  			OF oSection2 ALIAS "" TITLE STR0029 SIZE 50 BLOCK{||(cAlias1)->UC_CODCAMP+ " - " + ;  // "Campanha"
							Posicione("SUO",1,xFilial("SUO")+(cAlias1)->UC_MIDIA,"UO_DESC")}										
DEFINE CELL NAME ""	   				OF oSection2 ALIAS "" TITLE STR0030 BLOCK{||DTOC((cAlias1)->UC_PENDENT) + " - " +  ;   // "Retorno"
							(cAlias1)->UC_HRPEND + " - " + (cDia:= Tk_DiaSemana((cAlias1)->UC_PENDENT,Nil,Nil))}										
DEFINE CELL NAME "UC_CODOBS"		OF oSection2 ALIAS "SUC" TITLE STR0032	// "Observacao"	  				

                              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³SECAO 3 DO RELATORIO  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "UD_ITEM"			OF oSection3 ALIAS "SUD" 
DEFINE CELL NAME "TKUD_ASSUNTO"		OF oSection3 ALIAS "" SIZE 30 TITLE STR0066
DEFINE CELL NAME "UD_PRODUTO"		OF oSection3 ALIAS "" SIZE 30 BLOCK {||Posicione("SB1",1,xFilial("SB1")+(cSUD)->UD_PRODUTO,"B1_DESC")}						
DEFINE CELL NAME "TKUD_OCORREN"		OF oSection3 ALIAS "" TITLE STR0067 SIZE 30
DEFINE CELL NAME "TKUD_SOLUCAO"		OF oSection3 ALIAS "" TITLE STR0068 SIZE 30
DEFINE CELL NAME "TKUD_OPERADO"	   	OF oSection3 ALIAS "" TITLE STR0069	
DEFINE CELL NAME "UD_DATA"			OF oSection3 ALIAS "SUD"	
DEFINE CELL NAME "UD_STATUS"		OF oSection3 ALIAS "SUD"	
DEFINE CELL NAME "UD_DTEXEC"		OF oSection3 ALIAS "SUD"	
DEFINE CELL NAME "UD_OBS"			OF oSection3 ALIAS "SUD"	
DEFINE CELL NAME "UD_CODEXEC"		OF oSection3 ALIAS "SUD"				

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³SECAO 4 DO RELATORIO  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "TKTOTANSOP"		OF oSection4 ALIAS "" SIZE 70 TITLE STR0077

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³SECAO 5 DO RELATORIO  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "TKS5DATE"	   		OF oSection5 ALIAS "" SIZE 25 TITLE STR0070
DEFINE CELL NAME "TKS5TOT"			OF oSection5 ALIAS "" SIZE 10 TITLE STR0071
DEFINE CELL NAME "TKS5PERC"			OF oSection5 ALIAS "" SIZE 6  TITLE "% " + STR0072

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³SECAO 6 DO RELATORIO  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impressao do Total Geral          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "TKS6TOT"			OF oSection6 ALIAS "" SIZE 6  TITLE STR0055 //"TOTAL GERAL "
DEFINE CELL NAME "TKS6MED"			OF oSection6 ALIAS "" SIZE 20 TITLE STR0056	//"MEDIA DIÁRIA " 
DEFINE CELL NAME "TKS6MEDTOT"		OF oSection6 ALIAS "" SIZE 6  TITLE STR0081 //"MEDIA TOTAL "	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime Totalizador de Todos os Operadores   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "TKS7OP"		OF oSection7 ALIAS "" SIZE 30 TITLE  STR0057	//"RANKING DE OPERADORES E MEDIA DE ATENDIMENTO"
DEFINE CELL NAME "TKS7TOT"		OF oSection7 ALIAS "" SIZE 15 TITLE STR0071
DEFINE CELL NAME "TKS7TMA"		OF oSection7 ALIAS "" SIZE 15 TITLE STR0073
                                                                 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime Totalizador de Todas as Midias  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "TKS8MIDIA"	OF oSection8 ALIAS "" SIZE 40 TITLE STR0059	//"MIDIA DE MAIOR RECONHECIMENTO"
DEFINE CELL NAME "TKS8TOTAL"	OF oSection8 ALIAS "" SIZE 15 TITLE STR0071

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime totalizador de Midias X Campanha ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "TKS9MIDIA"	OF oSection9 ALIAS "" SIZE 40 TITLE STR0061   //"MIDIA DE MAIOR RECONHECIMENTO POR CAMPANHA"
DEFINE CELL NAME "TKS9CAMP"		OF oSection9 ALIAS "" SIZE 40 TITLE STR0011
DEFINE CELL NAME "TKS9TOT"		OF oSection9 ALIAS "" SIZE 15 TITLE STR0071


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  
//³Imprime Totalizador de Todas as Campanhas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "TKS10CAMP"	OF oSection10 ALIAS "" SIZE 40 TITLE STR0062	//"CAMPANHAS DE MAIOR EXECUÇÃO"                                                                           
DEFINE CELL NAME "TKS10TOT"		OF oSection10 ALIAS "" SIZE 15 TITLE STR0071

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime totalizador de Campanhas X Operador ³                            
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                            
DEFINE CELL NAME "TKS11CAMP"		OF oSection11 ALIAS "" SIZE 40 TITLE STR0064 + " (" + STR0011 + ")"	//"MÉDIA DE ATENDIMENTO (T.M.A) DOS OPERADORES POR CAMPANHA"
DEFINE CELL NAME "TKS11OP"			OF oSection11 ALIAS "" SIZE 40 TITLE STR0012
DEFINE CELL NAME "TKS11TOT"			OF oSection11 ALIAS "" SIZE 15 TITLE STR0071
DEFINE CELL NAME "TKS11TMA"			OF oSection11 ALIAS "" SIZE 15 TITLE STR0073


//DEFINE FUNCTION FROM oSection2:Cell("UC_CODIGO") OF oSection1 FUNCTION COUNT TITLE "Total de atendimentos AAA"  NO END REPORT 

Return(oReport) 


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr001PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³13/07/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de           ³±±
±±³          ³Ligacoes realizadas - Telemarketing no release 4.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr001PrtRept(ExpO1,ExpC2,ExpC3)                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC2 = alias da query em SUD                              ³±±
±±³          ³ ExpC3 = alias da query em SUC                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Hanna C.  ³04/10/07³8.11  ³133983 - Alterada a ordem do array para ser ³±±
±±³          ³        ³      ³apresentado no total                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr001PrtRpt(oReport, cAlias1, cSud)
Local oSection1 := oReport:Section(1) 		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SUG e SB1)
Local oSection2 := oSection1:Section(1)		//Objeto secao 2 do relatorio (Detalhe, campos das tabelas SU1 e SB1)
Local oSection3 := oSection2:Section(1)		//Objeto secao 2 do relatorio (Detalhe, campos das tabelas SU1 e SB1)
Local oSection4 := oSection3:Section(1) 	//Objeto secao 4 do relatorio (Detalhe, totalizador das informacoes de operador)
Local oSection5 := oSection4:Section(1)		//Objeto secao 5 do relatorio (Detalhe, totalizador das informacoes de operador)
Local oSection6 := oReport:Section(2)     	//Secao Total geral de atendimentos realizados pelo telemarketing
Local oSection7 := oReport:Section(3)		//Secao Ranking dos operadores
Local oSection8 := oReport:Section(4)		//Secao midia de maior reconhecimentos
Local oSection9 := oReport:Section(5)		//Secao midia de maior reconhecimentos X Campanhas
Local oSection10 := oReport:Section(6)   	//Secao campanhas de maior execucao
Local oSection11 := oReport:Section(7)    	//Secao media de atendimento (TMA) dos operadores por campanha
Local nDias		:= 1						//controle da impressão de totalizadores no fim de relatorio
Local cDia									//controle da impressão de totalizadores no fim de relatorio
Local cCodCamp								//controle de impressao na secao de media de atendimento dos operadores por campanha

Local cOperado		:= ""			// Codigo do Operador (para quebra de relatorio)
Local cCodSUC		:= ""			// Controla a quebra dos atendimentos
Local aTotOper		:= {}			// Acumula valores  - array[Midia/Campanha][Valor]
Local nPosData		:= 0			// Ponteiro de pesquisa do array
Local aTotGer		:= {}			// Acumula valores  - array[Midia/Campanha][Valor]
Local nTotSeg						// Totalizador de Segundos	
Local nPosCodCamp	:= 0			// Ponteiro de pesquisa do array
Local nPosMidia		:= 0			// Ponteiro de pesquisa do array
Local nPosCodOper
Local nPosTotOper
Local nPosTotMid
Local nPosTotCam
Local aUser		:= {} 
Local cDescAss 	:= ""
Local nI    
Local nMediaAt
Local nHoras
Local nMinutos
Local nSegundos
Local cTime   


Local cQuery		:= ""		// Monta a query para top
Local cWhere		:= ""		// Recebe a clausula where para validar os segmentos de negocios
Local cOptTab		:= ""		// Recebe o nome de uma tabela opcional     
Local cCodCan		:= ""		// codigo de cancelamento

oSection1:SetLineBreak()
oSection2:SetLineBreak()
oSection3:SetLineBreak()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMKR001")      

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamo a funcao que monta a parte da query para validar os segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Mv_Par08 == "SA1" .OR. Mv_Par08 == "SUS"
	TKSegmento(	Mv_Par10,	Mv_Par11,	Mv_Par12,	Mv_Par13,;
				Mv_Par14,	Mv_Par15,	Mv_Par16,	Mv_Par17,;
				Mv_Par08,	"",			@cWhere)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query a validacao dos segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cWhere)
	cOptTab := ", " + RetSqlName(Mv_Par08) + " " + Mv_Par08
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o status da ligacao inFormado no parametro     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (Mv_par07 <> 1)  // TODAS
	cQuery += " 		SUC.UC_STATUS = '" + Str(Mv_Par07-1,1) + "' AND"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico se eh para uma entidade especifica         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(Mv_Par08)
	cQuery += " 		SUC.UC_ENTIDAD = '" + Mv_Par08 + "' AND"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifico o contato                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(mv_par09)
	cQuery += " 		SUC.UC_CODCONT = '" + AllTrim(Mv_Par09) + "' AND"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciono somente as ligacoes da campanha informada  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(mv_par20)
	cQuery += " 		SUC.UC_CODCAMP = '" + Mv_par20 + "' AND"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Desconsidera compartilhamentos                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery += "			SUC.UC_CHAORIG = '' AND"
			
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciono somente o assunto informado                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(Mv_Par19)
	cQuery +=	" 		SUD.UD_ASSUNTO = '" + AllTrim(Mv_Par19) + "' AND"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Comeca a fazer a amarracao com a tabela SUD dos itens do atendimento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery +=	"		" +;
			"		SUD.UD_CODIGO = SUC.UC_CODIGO"	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query a validacao dos segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cWhere)
	cQuery += " AND " + cWhere
Endif 

cQuery = "%" + cQuery + "%"	                
cOptTab = "%" + cOptTab + "%"

BEGIN REPORT QUERY oSection1
	BeginSQL alias cAlias1
		SELECT 	UC_OPERADO, 	UC_FILIAL,	UC_CODIGO, 		UC_CODCONT,			
				UC_DATA, 		UC_OPERACA, 	UC_ENTIDAD, 
				UC_STATUS, 		UC_CHAVE, 	UC_MIDIA, 		UC_TIPO, 
				UC_CODCAMP, 	UC_PENDENT, UC_HRPEND, 		UC_CODOBS,         
				UC_INICIO,		UC_FIM, 
				UD_ASSUNTO, 	UD_CODEXEC, UD_DATA, 		UD_DTEXEC, 
				UD_ITEM, 		UD_OBS, 	UD_OCORREN, 	UD_OPERADO, 	
				UD_PRODUTO, 	UD_SOLUCAO, UD_STATUS, 		UD_CODIGO				
		FROM	%table:SUC% SUC, %table:SUD% SUD %exp:cOptTab% 
		WHERE	SUC.UC_FILIAL = %xFilial:SUC% AND 
				SUC.%notDel% AND
				SUD.UD_FILIAL = %xFilial:SUD% AND
				SUD.%notDel% AND
				SUC.UC_OPERADO BETWEEN %exp:Mv_Par01% AND %exp:Mv_Par02% AND
				SUC.UC_DATA BETWEEN %exp:DtoS(Mv_Par03)% AND %exp:DtoS(Mv_Par04)% AND					
				SUC.UC_MIDIA BETWEEN %exp:Mv_Par05% AND %exp:Mv_Par06% AND										
				SUC.UC_CODCANC = %exp:cCodCan% AND
				SUC.UC_OPERACA = '2' AND
				%exp:cQuery%
		ORDER BY UC_FILIAL,UC_OPERADO,UC_CODIGO,UC_DATA,UC_STATUS				
	EndSql
END REPORT QUERY oSection1 


oSection2:SetParentQuery()	
oSection2:SetParentFilter({|cParam| (cAlias1)->UD_CODIGO == cParam},{|| (cAlias1)->UC_CODIGO })	
oSection3:SetParentQuery()
oSection3:SetParentFilter({|cParam| (cAlias1)->UD_CODIGO == cParam},{|| (cAlias1)->UC_CODIGO })		

While	(!Eof())							.AND.;
		(cAlias1)->UC_FILIAL == xFilial("SUC")	.AND.;
		(cAlias1)->UC_OPERADO >=	Mv_Par01	.AND.;
		(cAlias1)->UC_OPERADO <=	Mv_Par02

	If oReport:Cancel()
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se mudou o operador faz uma sub-totalizacao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cAlias1)->UC_OPERADO <> cOperado		
		If Len(aTotOper)>0 
			aSort(aTotOper,,, {|x,y| x[1] < y[1]} )		// Crescente
			oSection4:Init()            
			//"TOTAL DE ATENDIMENTOS DO OPERADOR "
			oSection4:Cell("TKTOTANSOP"):SetValue(FATPDObfuscate(UPPER(Posicione("SU7",1,xFilial("SU7")+cOperado,"U7_NREDUZ")),"U7_NREDUZ",,.T.) + ;
										Transform(aTotOper[1][3],'999,999'))        
			oSection4:PrintLine()
			
			oSection5:Init()	 			                       
			For nI := 1 To Len(aTotOper)
				oSection5:Cell("TKS5DATE"):SetValue(DTOC(aTotOper[nI][1]) + " - " + (cDia:= Tk_DiaSemana(aTotOper[nI][1],Nil,Nil)))
				oSection5:Cell("TKS5TOT"):SetValue(aTotOper[nI][2])
				oSection5:Cell("TKS5PERC"):SetValue(Transform(aTotOper[nI][2]/aTotOper[1][3]*100, '@E 999.99') + ' %')
				oSection5:PrintLine()
			Next nI            					
			oSection5:Finish()  //"DATA      TOTAL           % PERCENTUAL"
		EndIf  
		If cOperado <> ""
			oSection4:Finish()
			oSection3:Finish()
			oSection2:Finish()
			oSection1:Finish()
			oReport:EndPage()
		EndIf
		cOperado := (cAlias1)->UC_OPERADO		
		aTotOper := {}	

		cCodSuc := "" 
		
		oSection1:Init()				
		oSection1:PrintLine() 
		oReport:FatLine()
		oSection2:Init()
	Endif
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Quebra de atendimento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cAlias1)->UC_CODIGO <> cCodSUC
		If cCodSuc <> ""     
			oSection3:Finish()
			If Mv_Par18 == 1 //Relatorio Analitico	
				oReport:EndPage()
			EndIf
		EndIf
		cCodSUC := (cAlias1)->UC_CODIGO
		If Mv_Par18 == 1 //Relatorio Analitico			
			oSection2:PrintLine()
			oReport:FatLine()
			oSection3:Init()
		Endif
			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza as quantidades de atendimentos por operador ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 		If Len(aTotOper) > 0
			aTotOper[1][3]++  
			nPosData := Ascan(aTotOper, {|x| x[1]==(cAlias1)->UC_DATA} )
			If nPosData > 0
				aTotOper[nPosData][2]++
			Else
				AAdd( aTotOper,{ (cAlias1)->UC_DATA , 1 ,1 } )
			Endif	
		Else
			AAdd( aTotOper, { (cAlias1)->UC_DATA , 1 ,1 } )
		Endif
 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza as quantidades de atendimentos no Geral     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aTotGer) > 0
			aTotGer[1][3]++
		Else
			AAdd( aTotGer, {"ATENDIM","",1} )
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza as quantidades de atendimentos por Operador ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosTotOper := Ascan(aTotGer, {|x| x[1]=="TO" .AND. x[2]==(cAlias1)->UC_OPERADO} )		

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula a diferenca entre duas horas e converte a hora³
		//³(HH:MM:SS) em segundos para calculo                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotSeg 	:= Elaptime((cAlias1)->UC_INICIO ,(cAlias1)->UC_FIM)
		nTotSeg		:= VAL(Substr(nTotSeg,1,2))*3600 + VAL(Substr(nTotSeg,4,2))*60 + VAL(Substr(nTotSeg,7,2))
   		If nPosTotOper > 0
     		aTotGer[nPosTotOper][3]++ 
     		aTotGer[nPosTotOper][4]+=nTotSeg
     	Else
	     	AAdd( aTotGer, {"TO",(cAlias1)->UC_OPERADO,1,nTotSeg} )
	    Endif
	     	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza as quantidades de Midia ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cAlias1)->UC_MIDIA)
			nPosTotMid := Ascan(aTotGer, {|x| x[1]=="TM" .AND. x[2]==(cAlias1)->UC_MIDIA} )		
			If nPosTotMid > 0
	     		aTotGer[nPosTotMid][3]++
	     	Else
		     	AAdd( aTotGer, {"TM",(cAlias1)->UC_MIDIA,1} )	
		    Endif
	  	Endif
	  	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza as quantidades de Campanha  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cAlias1)->UC_CODCAMP)
			nPosTotCam := Ascan(aTotGer, {|x| x[1]=="TC" .AND. x[2]==(cAlias1)->UC_CODCAMP} )		
			If nPosTotCam > 0
	     		aTotGer[nPosTotCam][3]++
	     	Else
		     	AAdd( aTotGer, {"TC",(cAlias1)->UC_CODCAMP,1} )	
		    Endif
	    Endif
	    
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza as quantidades das Campanhas por operador   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cAlias1)->UC_CODCAMP)
			nPosCodCamp := Ascan(aTotGer, {|x| x[1]=="C"+(cAlias1)->UC_CODCAMP} )

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Calcula a diferenca entre duas horas e converte a hora³
			//³(HH:MM:SS) em segundos para calculo                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nTotSeg 	:= Elaptime((cAlias1)->UC_INICIO ,(cAlias1)->UC_FIM)
			nTotSeg		:= VAL(Substr(nTotSeg,1,2))*3600 + VAL(Substr(nTotSeg,4,2))*60 + VAL(Substr(nTotSeg,7,2))
			If nPosCodCamp > 0
				nPosCodOper	:= Ascan(aTotGer, {|x| x[1] =="C"+(cAlias1)->UC_CODCAMP .AND. x[2]==(cAlias1)->UC_OPERADO} )
				If nPosCodOper > 0
					aTotGer[nPosCodOper][3]++
		     		aTotGer[nPosCodOper][4]+=nTotSeg
				Else
					AAdd( aTotGer, {"C"+(cAlias1)->UC_CODCAMP, (cAlias1)->UC_OPERADO,1,nTotSeg} )					
				Endif	
			Else
				AAdd( aTotGer, {"C"+(cAlias1)->UC_CODCAMP,(cAlias1)->UC_OPERADO,1,nTotSeg} )
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza as quantidades de Midias por Campanha       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cAlias1)->UC_MIDIA)
			nPosMidia := Ascan(aTotGer, {|x| x[1]=="M"+(cAlias1)->UC_MIDIA} )
			If nPosMidia > 0
				nPosCodCamp	:= Ascan(aTotGer, {|x| x[1] == "M"+(cAlias1)->UC_MIDIA .AND. x[2]==(cAlias1)->UC_CODCAMP} )
				If nPosCodCamp > 0
					aTotGer[nPosCodCamp][3]++
				Else
					If !Empty((cAlias1)->UC_CODCAMP)
						AAdd( aTotGer, {"M"+(cAlias1)->UC_MIDIA,(cAlias1)->UC_CODCAMP, 1} )
					Endif
				Endif	
			Else
			    If !Empty((cAlias1)->UC_CODCAMP)
					AAdd( aTotGer, {"M"+(cAlias1)->UC_MIDIA,(cAlias1)->UC_CODCAMP, 1} )
				Endif	
			Endif
			
		Endif

			
	Endif 

	If Mv_Par18 == 1 //Analitico		
		//Preencher a celula "COD_ASSUNTO"
		DbSelectArea("SX5")
		DbSetOrder(1)      		// Codigo do Assunto 
		If !Empty((cSUD)->UD_ASSUNTO)
			If MsSeek(xFilial("SX5")+"T1"+(cSUD)->UD_ASSUNTO)
				cDescAss := ""
				cDescAss := X5DESCRI()		
				oSection3:Cell("TKUD_ASSUNTO"):SetValue(cDescAss)
			Endif	
		EndIf 
		
		//Preencher a celula "COD_USR"  
		DbSelectArea("SUQ")
		DbSetOrder(1)					
		PswOrder(1)
		aUser := IIF(PswSeek((cSUD)->UD_OPERADO),PswRet(1),{})							
		oSection3:Cell("TKUD_OPERADO"):SetValue(IIF(Len(aUser)>0,aUser[1][2],""))		
	
		//TKUD_OCORREN
		DbSelectArea("SU9")
		DbSetOrder(1)          
		If !Empty((cSUD)->UD_OCORREN)
			If 	MsSeek(xFilial("SU9")+ (cSUD)->UD_ASSUNTO + (cSUD)->UD_OCORREN)// Codigo do Assunto + Codigo da Ocorrencia
				//cDescOco := SU9->U9_DESC
				oSection3:Cell("TKUD_OCORREN"):SetValue(SU9->U9_DESC)
			EndIf
		EndIf
		
		//TKUD_SOLUCAO
		DbSelectArea("SUQ")
		DbSetOrder(1)
		If !Empty((cSUD)->UD_SOLUCAO)
			If 	MsSeek(xFilial("SUQ")+(cSUD)->UD_SOLUCAO)
				//cDescSol := SUQ->UQ_DESC 
				oSection3:Cell("TKUD_SOLUCAO"):SetValue(SUQ->UQ_DESC)
			EndIf
		EndIf
		
		//oSection3:Init()		
		oSection3:PrintLine()
		oReport:ThinLine()
	Endif			
			
	
	DbSelectArea(cAlias1)
	DbSkip()

	
	oReport:IncMeter()

End //Fim do Loop 

oSection4:Finish()
oSection3:Finish()
oSection2:Finish()
oSection1:Finish()

If Len(aTotOper)>0 
	aSort(aTotOper,,, {|x,y| x[1] < y[1]} )		// Crescente
	oSection4:Init()            
	//"TOTAL DE ATENDIMENTOS DO OPERADOR "
	oSection4:Cell("TKTOTANSOP"):SetValue(FATPDObfuscate(UPPER(Posicione("SU7",1,xFilial("SU7")+cOperado,"U7_NREDUZ")),"U7_NREDUZ",,.T.) + ;
								Transform(aTotOper[1][3],'999,999'))        
	oSection4:PrintLine()
	
	oSection5:Init()	 			                       
	For nI := 1 To Len(aTotOper)
		oSection5:Cell("TKS5DATE"):SetValue(DTOC(aTotOper[nI][1]) + " - " + (cDia:= Tk_DiaSemana(aTotOper[nI][1],Nil,Nil)))
		oSection5:Cell("TKS5TOT"):SetValue(aTotOper[nI][2])
		oSection5:Cell("TKS5PERC"):SetValue(Transform(aTotOper[nI][2]/aTotOper[1][3]*100, '@E 999.99') + ' %')
		oSection5:PrintLine()
	Next nI            					
	oSection5:Finish()  //"DATA      TOTAL           % PERCENTUAL"
EndIf  



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impressao do Total Geral          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aTotGer) > 0

	oSection6:Init()
	oReport:EndPage()
	// Decrescente ordenado apenas a primeira e a terceira coluna
	aSort(aTotGer,,, {|x,y| x[1]+Str(x[3]) < y[1]+Str(y[3])} )		
                                              
	//"TOTAL GERAL DE ATENDIMENTOS REALIZADOS PELO TELEMARKETING"
	oSection6:Cell("TKS6TOT"):SetValue(Transform(aTotGer[1][3],'@E 999,999'))

	//"MEDIA DIÁRIA DE ATENDIMENTOS ATIVOS NO PERIODO DE " 
	oSection6:Cell("TKS6MED"):SetValue(	DTOC(MV_PAR03)+ " - " + ;
										(cDia:= Tk_DiaSemana(MV_PAR03,Nil,Nil))+ " ATE " +;
										DTOC(MV_PAR04)+ " - " + (cDia:= Tk_DiaSemana(MV_PAR04,Nil,Nil)))	
		
	//TKS6MEDTOT  
	nDias += (MV_PAR04 - MV_PAR03)
	oSection6:Cell("TKS6MEDTOT"):SetValue(Transform(((aTotGer[1][3])/nDias),'@E 999.99'))
	oSection6:PrintLine()
    oSection6:Finish()
    
    oSection7:Init()  
    oSection7:SetTotalText(STR0057)		//"RANKING DE OPERADORES E MEDIA DE ATENDIMENTO"

    For nI:= 1  to Len(aTotGer)
		If SubStr(aTotGer[nI][1],1,2) == "TO"
			//TKS7OP  
			oSection7:Cell("TKS7OP"):SetValue(aTotGer[nI][2] + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+aTotGer[nI][2],"U7_NREDUZ"),"U7_NREDUZ",,.T.))
			
			//TKS7TOT
			oSection7:Cell("TKS7TOT"):SetValue(Transform(aTotGer[nI][3],'@E 999,999'))

			//TKS7TMA
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³(Total de Segundos / Numero de Atendimentos   ³
			//³  == Media de Atendimento em Segundos         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
			nMediaAt	:= aTotGer[nI][4]/ aTotGer[nI][3]
			
			//Calcula Segundos em: Hora, Minutos e Segundos			
			TkSecsToHMS( nMediaAt , @nHoras , @nMinutos, @nSegundos) 
			
			//Retorna Horas, Minutos e Segundos no formato HH:MM:SS
			cTime:= TkHMSToTime( nHoras , nMinutos , nSegundos )      
			oSection7:Cell("TKS7TMA"):SetValue(cTime)
		    oSection7:PrintLine()
        Endif
    Next nI    
    oSection7:Finish()
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime Totalizador de Todas as Midias  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nI:= Ascan(aTotGer, {|x| x[1] == "TM" })
	If nI > 0 //Se houver Totalizador de Midia
   		oSection8:Init()		
		For nI:= Ascan(aTotGer, {|x| x[1] == "TM" }) To Len(aTotGer)
			If SubStr(aTotGer[nI][1],1,2) == "TM"
				If !Empty(aTotGer[nI][2]) 
					oSection8:Cell("TKS8MIDIA"):SetValue(aTotGer[nI][2] + " - " + Posicione("SUH",1,xFilial("SUH")+aTotGer[nI][2],"UH_DESC"))
					oSection8:Cell("TKS8TOTAL"):SetValue(Transform(aTotGer[nI][3],'@E 999,999'))					
					oSection8:PrintLine()
				Endif	
				DbSelectArea(cAlias1)
			Endif 
		Next nI
		oSection8:Finish()
    Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime totalizador de Midias X Campanha ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nI:= Ascan(aTotGer, {|x| x[1] == "M" }) 
	If nI > 0 //Se houver Totalizador de Midia por campanha
		oSection9:Init()
		For nI := 2 To Len(aTotGer)
			If SubStr(aTotGer[nI][1],1,1) == "M"
				If !Empty(SubStr(aTotGer[nI][1],2,6))
					oSection9:Cell("TKS9MIDIA"):SetValue("")
					oSection9:Cell("TKS9TOT"):SetValue("")
					oSection9:Cell("TKS9CAMP"):SetValue("")
					If cCodMid <> SubStr(aTotGer[nI][1],2,6) 
					    cCodMid:= SubStr(aTotGer[nI][1],2,6) 
						oSection9:Cell("TKS9MIDIA"):SetValue(SubStr(aTotGer[nI][1],2,6) + ;
															 " - " + Posicione("SUH",1,xFilial("SUH")+SubStr(aTotGer[nI][1],2,6),"UH_DESC"))
						oSection9:PrintLine()									 
						oReport:SkipLine() 
						oSection9:Cell("TKS9MIDIA"):SetValue("")
					Endif	
					oSection9:Cell("TKS9CAMP"):SetValue(SubStr(aTotGer[nI][2],1,6) + " - " + Posicione("SUO",1,xFilial("SUO")+SubStr(aTotGer[nI][2],1,6),"UO_DESC"))					
					oSection9:Cell("TKS9TOT"):SetValue(Transform(aTotGer[nI][3],'@E 999,999'))					
					oSection9:PrintLine()
				Endif	
			Endif 
		Next nI
		oSection9:Finish()
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime Totalizador de Todas as Campanhas ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nI:= Ascan(aTotGer, {|x| x[1] == "TC" })
	If nI > 0 //Se houver Totalizador de Campanha
		oSection10:Init()	
		For nI:= Ascan(aTotGer, {|x| x[1] == "TC" }) To Len(aTotGer)
			If SubStr(aTotGer[nI][1],1,2) == "TC"
				If !Empty(aTotGer[nI][2]) 
					oSection10:Cell("TKS10CAMP"):SetValue(aTotGer[nI][2] + " - " + Posicione("SUO",1,xFilial("SUO")+aTotGer[nI][2],"UO_DESC"))
					oSection10:Cell("TKS10TOT"):SetValue(Transform(aTotGer[nI][3],'@E 999,999'))					
					oSection10:PrintLine()
				Endif
	        Endif
		Next nI          
		oSection10:Finish()
	Endif	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime totalizador de Campanhas X Operador ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nI:= Ascan(aTotGer, {|x| Substr(x[1],1,1) == "C" })
	If nI > 0 //Se houver Campanha
		oSection11:Init()
		For nI:= 2 To Len(aTotGer)
			oSection11:Cell("TKS11CAMP"):SetValue("")
			oSection11:Cell("TKS11OP"):SetValue("")
			oSection11:Cell("TKS11TOT"):SetValue("")
			oSection11:Cell("TKS11TMA"):SetValue("")									
			If SubStr(aTotGer[nI][1],1,1) == "C"
				If !Empty(SubStr(aTotGer[nI][1],2,6))
				    If cCodCamp <> SubStr(aTotGer[nI][1],2,6) 
					    cCodCamp:= SubStr(aTotGer[nI][1],2,6)                                               
					    oReport:SkipLine()
						oSection11:Cell("TKS11CAMP"):SetValue(SubStr(aTotGer[nI][1],2,6) + " - " + Posicione("SUO",1,xFilial("SUO")+SubStr(aTotGer[nI][1],2,6),"UO_DESC"))
						oSection11:PrintLine()
						oSection11:Cell("TKS11CAMP"):SetValue("")
					Endif	
					oSection11:Cell("TKS11OP"):SetValue(SubStr(aTotGer[nI][2],1,6) + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+SubStr(aTotGer[nI][2],1,6),"U7_NREDUZ"),"U7_NREDUZ",,.T.))                                                                                            
					oSection11:Cell("TKS11TOT"):SetValue(Transform(aTotGer[nI][3],'@E 999,999'))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³(Total de Segundos / Numero de Atendimentos   ³  
					//³  == Media de Atendimento em Segundos         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
					nMediaAt	:= aTotGer[nI][4]/ aTotGer[nI][3]
					
					//Calcula Segundos em: Hora, Minutos e Segundos			
					TkSecsToHMS( nMediaAt , @nHoras , @nMinutos, @nSegundos) 
					
					//Retorna Horas, Minutos e Segundos no formato HH:MM:SS
					cTime:= TkHMSToTime( nHoras , nMinutos , nSegundos )      
		
					oSection11:Cell("TKS11TMA"):SetValue(cTime)
					oSection11:PrintLine()
				Endif	
			Endif 
		Next nI		
		oSection11:Finish()
	Endif
                 
	oReport:FatLine()
	aTotGer := {}	

Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Caso nada tenha sido impresso, entao imprime uma menssagem de aviso³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:PrintText(STR0045)    
EndIf

Return(.T.)   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³TkrGetDesc   ³ Autor ³Michel W. Mosca     ³ Data ³13/07/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtem a descricao do acessorio.                             ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TkrGetDesc(ExpC)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = alias da consulta ao SGDB                          ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TkrGetDesc(cAlias)
Local cDesc		//descricao em SX2

DbSelectArea("SX2")
DbSetOrder(1)
If MsSeek((cAlias)->UC_ENTIDAD)
	cDesc := X2NOME()	// "Descricao da Entidade"	
EndIf	
Return(cDesc)

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