/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR023.CH"
#INCLUDE "TMKDEF.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR023  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 10/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Prazos Medios e Maximos de Encerramento       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_TMKR023(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico TeleMarketing (SUC)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K ³10/07/03³710   ³Correcao do seek na Tabela SU9 indice 1     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Thiago G  ³27/07/04³811   ³Inclusao do cabecalho padrao e alteracao das³±±
±±³          ³        ³      ³totalizacoes.                               ³±±
±±³Michel W. ³10/08/06³99193 ³Atualizacao para relatorio release 4.       ³±±
±±³Michel W. ³21/08/06³99193 ³Revisao de fonte.                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/              
User Function TMKR023()

Local oReport	//Objeto relatorio TReport (Release 4)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK023",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ Mv_Par01           // De Data                                ³
//³ Mv_Par02           // Ate a Data                             ³
//³ Mv_Par03           // Tipo de Encerramento                   ³
//³ Mv_Par04           // Operador                               ³
//³ Mv_Par05           // Do CEP                                 ³
//³ Mv_Par06           // Ate o CEP                              ³
//³ Mv_Par07           // Tipo de Ligacao Ativo/Receptivo/Ambas  ³
//³ Mv_Par08	       // Segmento 1             ?               ³
//³ Mv_Par09 	       // Segmento 2             ?               ³
//³ Mv_Par10 		   // Segmento 3             ?               ³
//³ Mv_Par11		   // Segmento 4             ?               ³
//³ Mv_Par12	       // Segmento 5             ?               ³
//³ Mv_Par13           // Segmento 6             ?               ³
//³ Mv_Par14           // Segmento 7             ?               ³
//³ Mv_Par15           // Segmento 8             ?               ³
//³ Mv_Par16           // Entidade               ?               ³
//³ Mv_Par17           // Contato                ?               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
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
±±³Fun‡…o    ³ReportDef    ³ Autor ³Michel W. Mosca     ³ Data ³10/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Prazo de encerramento no release 4.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CALL CENTER                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()  

Local oReport 				//Objeto relatorio TReport (Release 4)
Local oSection1             //Objeto secao 1 do relatorio (Cabecalho, dados do atendimento)
Local oSection2             //Secao com itens relacionados ao atendimento
Local oSection3             //Secao com totalizadores do relatorio
Local oSection4             //Secao com totalizadores do relatorio
Local oSection5             //Secao com totalizadores do relatorio
Local oSection6             //Secao com totalizadores do relatorio
Local cSUC := "SUC"         //Alias da consulta Embedded SQL
Local cSUD := "SUD"
Local aCampos		:= {}						// Campos do alias principal para select
Local aDescCab      :={}
Local aDesc      :={}
Local aUC_Status	:= TkSx3Box("UC_STATUS")		// Busca no dd SX3 as opcoes para o campo
Local aUD_Status	:= TkSx3Box("UD_STATUS")		// Busca no dd SX3 as opcoes para o campo

cSUC	:= GetNextAlias()						// Pega o proximo Alias Disponivel	
cSUD	:= cSUC	                 

aCampos		:= {"UC_DATA"		,"UC_CODCONT"	,"UC_CODIGO"	,;
   				"U5_FCOM1"		,"UC_OPERADO"	,"U5_EMAIL"		,;
   				"UC_OPERACA"	,"UC_ENTIDAD"	,"UC_TIPO"		,;
   				"UC_DESCCHA"	,"UC_MIDIA"		,"A1_TEL"		,;
   				"UC_CODCAMP"	,"A1_END"		,"UC_STATUS"	,;
   				"A1_BAIRRO"		,"UC_PENDENT"	,"A1_MUN"		,;
   				"UC_HRPEND"		,"A1_EST"		,"UC_OBS"		,;
   				"UC_DTENCER"	,"UC_DIASDAT"	,"UC_OBSMOT"	,;	
   				"UC_DESCCAM"}
aDescCab	:= TkTitX3(aCampos)	 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Comeca a imprimir os items do atendimento            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCampos		:= {"UD_ITEM"		,"UD_ASSUNTO"	,"UD_PRODUTO"	,;
				"UD_OCORRENCIA"	,"UD_SOLUCAO"	,"UD_OPERADO"	,;
				"UD_DATA"		,"UD_STATUS"	,"UD_DTEXEC"	,;
				"UD_OBS"		,"UD_OBSEXEC"}
aDesc		:= TkTitX3(aCampos)        
        

// "Prazo de Encerramento - Telemarketing" # // "Este programa irá emitir uma relação das Ligações"
// "realizadas pelo operador no atendimento Telemarketing" # // "conforme os parametros previamente definidos"
DEFINE REPORT oReport NAME "TMKR023" TITLE STR0001 PARAMETER "TMK023" ACTION {|oReport| Tkr023PrtRpt( oReport, cSUC, cSUD )} DESCRIPTION STR0002 + 	STR0003 + STR0004

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0039 TABLES "SUC"			//"Cabecalho do Telemarketing"
DEFINE SECTION oSection2 OF oSection1 TITLE STR0040 TABLES "SUD"		//"Itens do Telemarketing"
DEFINE SECTION oSection3 OF oReport TITLE STR0041 						//"Motivo"
DEFINE SECTION oSection4 OF oReport TITLE STR0042                      	//"Data x Motivo"
DEFINE SECTION oSection5 OF oReport TITLE STR0043 						//"Operador x Maximo x Minimo"
DEFINE SECTION oSection6 OF oReport TITLE STR0044 						//"Motivo x Ativo"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ            
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime os dados do cabecalho do script dinamico.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DEFINE CELL NAME "UC_DATA" OF oSection1 Alias "SUC"
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_CODCONT + " - " + TkDadosContato((cSUC)->UC_CODCONT,0,.T.)} TITLE aDescCab[2][1] SIZE 50
DEFINE CELL NAME "UC_CODIGO" OF oSection1 Alias "SUC"		
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(Transform( TkDadosContato((cSUC)->UC_CODCONT,8) + TkDadosContato((cSUC)->UC_CODCONT,4) , "@R (99)9999-9999"),"A1_NOME",,.T.)} TITLE aDescCab[4][1] SIZE 15	
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_OPERADO + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.)} TITLE aDescCab[5][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkDadosContato((cSUC)->UC_CODCONT,10,.T.)} TITLE aDescCab[6][1] SIZE 50	
DEFINE CELL NAME "UC_OPERACA" OF oSection1 Alias "SUC"  
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||Posicione("SX5",1,xFilial("SX5")+"T5"+(cSUC)->UC_ENTIDAD,"X5DESCRI()")} TITLE aDescCab[8][1] SIZE 50			
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_TIPO  + " - " + Posicione("SUL",1,xFilial("SUL")+(cSUC)->UC_TIPO,"UL_DESC")} TITLE aDescCab[9][1] SIZE 50 
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,1,,.T.)} TITLE aDescCab[10][1]	SIZE 120
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_MIDIA + " - " + Posicione("SUH",1,xFilial("SUH")+(cSUC)->UC_MIDIA,"UH_DESC")} TITLE aDescCab[11][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(Transform(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,9)+TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,6) , "@R (99)9999-9999"),"A1_TEL",,.T.)} TITLE aDescCab[12][1] SIZE 15
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_CODCAMP + " - " + Posicione("SUO",1,xFilial("SUO")+(cSUC)->UC_MIDIA,"UO_DESC")} TITLE aDescCab[13][1] SIZE 50
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,2,,.T.)} TITLE aDescCab[14][1] SIZE 40 	
DEFINE CELL NAME "UC_STATUS" OF oSection1 Alias "SUC" BLOCK{||IIF(!Empty((cSUC)->UC_STATUS),aUC_Status[Val((cSUC)->UC_STATUS)],"")} TITLE aDescCab[15][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,10,,.T.)} TITLE aDescCab[16][1] SIZE 40			
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||DTOC((cSUC)->UC_PENDENT) + " - " + (cDia:= Tk_DiaSemana((cSUC)->UC_PENDENT,Nil,Nil))} TITLE aDescCab[17][1] SIZE 30
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,3,,.T.)} TITLE aDescCab[18][1] SIZE 120			
DEFINE CELL NAME "UC_HRPEND" OF oSection1 Alias "SUC"  
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,4,,.T.)} TITLE aDescCab[20][1] SIZE 10						
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||MSMM((cSUC)->UC_CODOBS, 200)} TITLE aDescCab[21][1] SIZE 200	
DEFINE CELL NAME "UC_DTENCER" OF oSection1 Alias "SUC"		   
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||Transform(IIF(!Empty((cSUC)->UC_DTENCER), STRZERO(((cSUC)->UC_DTENCER-(cSUC)->UC_DATA),4) ,0),'@E 9999')} TITLE aDescCab[23][1] SIZE 5		
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC")} TITLE aDescCab[24][1] SIZE 50			
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||MSMM((cSUC)->UC_CODMOT, 200)} TITLE aDescCab[25][1] SIZE 200				
	    
DEFINE CELL NAME "UD_ITEM" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_ASSUNTO),Posicione("SX5",1,xFilial("SX5")+"T1"+(cSUD)->UD_ASSUNTO,"X5DESCRI()"),STR0009)} TITLE aDesc[2][1] SIZE 30						
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_PRODUTO),Posicione("SB1",1,xFilial("SB1")+(cSUD)->UD_PRODUTO,"B1_DESC"),STR0009)} TITLE aDesc[3][1] SIZE 30			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_OCORREN),Posicione("SU9",1,xFilial("SU9")+(cSUD)->UD_ASSUNTO+(cSUD)->UD_OCORREN,"U9_DESC"),STR0009)} TITLE aDesc[4][1] SIZE 50			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_SOLUCAO),Posicione("SUQ", 1, xFilial("SUQ")+(cSUD)->UD_SOLUCAO, "UQ_DESC"),STR0009)} TITLE aDesc[5][1] SIZE 30 			
DEFINE CELL NAME "S2_USR" OF oSection2 ALIAS "SUD" TITLE aDesc[6][1] SIZE 40			
DEFINE CELL NAME "UD_DATA" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_STATUS),aUD_Status[Val((cSUD)->UD_STATUS)],"")} TITLE aDesc[8][1] SIZE 20			
DEFINE CELL NAME "UD_DTEXEC" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "UD_OBS" OF oSection2 ALIAS "SUD" 			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||MSMM((cSUD)->UD_CODEXEC,200)} TITLE aDesc[11][1] SIZE 200			
	

DEFINE CELL NAME "S3_MOTIV" OF oSection3 TITLE STR0029 SIZE 50			
DEFINE CELL NAME "S3_ATIVO" OF oSection3 TITLE STR0030 SIZE 10
DEFINE CELL NAME "S3_PERC_AT" OF oSection3 TITLE "%" SIZE 10
DEFINE CELL NAME "S3_RECEP" OF oSection3 TITLE STR0031 SIZE 10
DEFINE CELL NAME "S3_PERC_RP" OF oSection3 TITLE "%" SIZE 10
DEFINE CELL NAME "S3_TOT" OF oSection3 TITLE STR0028 SIZE 10
DEFINE CELL NAME "S3_PERC_TOT" OF oSection3 TITLE "%" SIZE 10		


DEFINE CELL NAME "S4_DATA"  OF oSection4 TITLE STR0032 SIZE 9
DEFINE CELL NAME "S4_MOTIV" OF oSection4 TITLE STR0029 SIZE 50			
DEFINE CELL NAME "S4_ATIVO" OF oSection4 TITLE STR0030 SIZE 10
DEFINE CELL NAME "S4_RECEP" OF oSection4 TITLE STR0031 SIZE 10
DEFINE CELL NAME "S4_TOT" 	OF oSection4 TITLE STR0028 SIZE 10


DEFINE CELL NAME "S5_OPER" OF oSection5 TITLE STR0033 SIZE 40           
DEFINE CELL NAME "S5_MEDIA" OF oSection5 TITLE STR0034 SIZE 10
DEFINE CELL NAME "S5_DESVIO" OF oSection5 TITLE STR0035 SIZE 10
DEFINE CELL NAME "S5_MAX" OF oSection5 TITLE STR0036 SIZE 10
DEFINE CELL NAME "S5_MIN" OF oSection5 TITLE STR0037 SIZE 10   

DEFINE CELL NAME "S6_OPERADOR" OF oSection6 TITLE STR0033 SIZE 40
DEFINE CELL NAME "S6_MOTIV" OF oSection6 TITLE STR0029 SIZE 50			
DEFINE CELL NAME "S6_ATIVO" OF oSection6 TITLE STR0030 SIZE 10
DEFINE CELL NAME "S6_PERC_AT" OF oSection6 TITLE "%" SIZE 10
DEFINE CELL NAME "S6_RECEP" OF oSection6 TITLE STR0031 SIZE 10
DEFINE CELL NAME "S6_PERC_RP" OF oSection6 TITLE "%" SIZE 10
DEFINE CELL NAME "S6_TOT" OF oSection6 TITLE STR0028 SIZE 10
DEFINE CELL NAME "S6_PERC_TOT" OF oSection6 TITLE "%" SIZE 10	  

Return(oReport)                    

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr023PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³08/08/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de           ³±±
±±³          ³Prazao de encerramento release 4.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr023PrtRept(ExpO1,ExpC2,ExpC3)                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC2 = alias da query atual                               ³±±
±±³          ³ ExpC3 = alias da query atual                               ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Fernando  ³26/10/06³110195³Correcao da cQuery em que foi feito um      ³±±
±±³          ³        ³      ³LEFT JOIN na cQuery para trazer todos os    ³±±
±±³          ³        ³      ³atendimentos da tabela SUC mesmo sem ter    ³±±
±±³          ³        ³      ³itens na tabela SUD                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr023PrtRpt(oReport, cSUC, cSUD)
Local oSection1 := oReport:Section(1)             //Objeto secao 1 do relatorio (Cabecalho, dados do atendimento)
Local oSection2 := oSection1:Section(1)             //Secao com itens relacionados ao atendimento
Local oSection3 := oReport:Section(2)             //Secao com totalizadores do relatorio    
Local oSection4 := oReport:Section(3)             //Secao com totalizadores do relatorio    
Local oSection5 := oReport:Section(4)             //Secao com totalizadores do relatorio
Local oSection6 := oReport:Section(5)             //Secao com totalizadores do relatorio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de variaveis especificas para este relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCep
Local nLine
Local cCodSUD		:= ""							// Gerencia a quebra dos itens do atendimento
Local cCodSUC		:= ""							// Gerencia a quebra do cabecalho do atendimento
Local nMaxGer		:= 0							// Totalizacao tempo maximo para o encerramento
Local nMinGer		:= 0							// Totalizacao tempo minimo para o encerramento
Local cDesc			:= ""							// Guarda o resultado da pesquisa do Seek
Local aTotMot		:= {}							// Guarda as totalizacoes
Local aTotDtMt		:= {}							// Guarda as totalizacoes
Local aTotOpMt		:= {}							// Guarda as totalizacoes
Local aTotOper		:= {}							// Guarda as totalizacoes
Local lPula			:= .F.							// Variavel de auxilio
Local cData			:= ""							// Apoio
Local cCodOp		:= ""							// Apoio     
Local aUser
Local nI
Local aSetField		:= {}						// Parametros para SetField do alias principal
Local cCampos		:= ""						// Campos do alias principal para select
Local cQuery		:= ""						// Armazena a expressao da query para top
Local cWhere		:= ""						// Validacao do segmento de negocio para top
Local cTable	 	:= ""

//Ajusta os campos a serem visualizados dos totalizadores conforme os parametros informados
If Mv_Par07 <> 3				
	oSection3:Cell("S3_TOT"):Disable()
	oSection3:Cell("S3_PERC_TOT"):Disable()
	oSection4:Cell("S4_TOT"):Disable()	
	oSection6:Cell("S6_TOT"):Disable()
	oSection6:Cell("S6_PERC_TOT"):Disable()
   	If Mv_Par07 <> 1 // Ativo
		oSection3:Cell("S3_ATIVO"):Disable()
		oSection3:Cell("S3_PERC_AT"):Disable()
		oSection4:Cell("S4_ATIVO"):Disable()		
		oSection6:Cell("S6_ATIVO"):Disable()
		oSection6:Cell("S6_PERC_AT"):Disable()		
	Else
		oSection3:Cell("S3_RECEP"):Disable()
		oSection3:Cell("S3_PERC_RP"):Disable()
		oSection4:Cell("S4_RECEP"):Disable()		
		oSection6:Cell("S6_RECEP"):Disable()
		oSection6:Cell("S6_PERC_RP"):Disable()		
	EndIf
Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMKR023")      

//	cSUD := "SUC"
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamo a funcao que monta a parte da query para validar os segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Mv_Par16 == "SA1" .OR. Mv_Par16 == "SUS"
	TKSegmento(	Mv_Par08,	Mv_Par09,	Mv_Par10,	Mv_Par11,;
				Mv_Par12,	Mv_Par13,	Mv_Par14,	Mv_Par15,;
				Mv_Par16,	"",			@cWhere)
Endif
	
//	TkSelect(cString, @cCampos, @aSetField)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query a validacao dos segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTable = "%"
If !Empty(cWhere)
	cTable += ", " + RetSqlName(Mv_Par16) + " " + Mv_Par16
Endif  
cTable += "%"
	
cQuery =	"% 		SUC.UC_FILIAL = '" + xFilial("SUC") + "' AND " +;
			" 		SUC.UC_CODCANC = '' AND" +;
			" 		SUC.UC_DATA BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND" +;
			" 		SUC.UC_STATUS = '3' AND"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciona os encerramentos definidos no parametro³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(Mv_Par03)
	cQuery +=	" 		SUC.UC_CODENCE = '" + Mv_Par03 + "' AND"
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Valida o operador do parametro caso informado³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(Mv_Par04)
	cQuery +=	" 		SUC.UC_OPERADO = '" + Mv_Par04 + "' AND"
Endif

If Mv_Par07 <> 3 //Ambos
	cQuery += "		(SUC.UC_OPERACA = '" + IIF(Mv_Par07==1,"2","1") + "' OR"
	cQuery += "		SUC.UC_OPERACA = '') AND"
Endif
	
If !Empty(Mv_Par16)
	cQuery += "		SUC.UC_ENTIDAD = '" + Mv_Par16 + "' AND"
Endif
	
If !Empty(Mv_Par17)
	cQuery += "		SUC.UC_CODCONT = '" + Mv_Par17 + "' AND"
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciono somente chamados que nao sao compartilhamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery += " 	SUC.UC_CHAORIG = '' AND"

cQuery +=	"		SUC.D_E_L_E_T_ = ' ' "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query a validacao dos segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cWhere)
	cQuery += " AND " + cWhere
Endif
	
cQuery +=	" %"

BEGIN REPORT QUERY oSection1
BeginSQL alias cSUC
	SELECT	UC_DATA, 		UC_CODCONT, 		UC_CODIGO, 		UC_OPERADO, 
			UC_OPERACA, 	UC_ENTIDAD, 		UC_TIPO, 		UC_CHAVE, 
			UC_MIDIA, 		UC_CODCAMP, 		UC_PENDENT, 	UC_HRPEND, 
			UC_CODOBS, 		UC_DTENCER, 		UC_CODENCE, 	UC_CODMOT,
			UC_FILIAL, 		UC_CODCANC, 		UC_STATUS, 
			UD_ASSUNTO, 	UD_PRODUTO, 		UD_OCORREN, 	UD_SOLUCAO, 
			UD_OPERADO, 	UD_DATA, 			UD_STATUS,		UD_DTEXEC, 
			UD_OBS, 		UD_CODEXEC, 		UD_CODIGO, 		UD_ITEM 
	FROM 	%table:SUC% SUC Left Join %table:SUD% SUD On(SUC.UC_CODIGO = SUD.UD_CODIGO AND SUD.D_E_L_E_T_ = ' ' AND SUD.UD_FILIAL = %xFilial:SUD% ) %exp:cTable%
	WHERE	%exp:cQuery%
	ORDER BY %order:SUC%    
   EndSql    
END REPORT QUERY oSection1
oSection2:SetParentQuery()	 

oSection1:Init()     
oSection1:SetLineStyle()
	
While	(!Eof())							.AND.;
		(cSUC)->UC_FILIAL == xFilial("SUC")	.AND.;
		(cSUC)->UC_DATA >=	Mv_Par01		.AND.;
		(cSUC)->UC_DATA <=	Mv_Par02
	
	oReport:IncMeter()
	
	If oReport:Cancel()
		Exit
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona o intervalo do CEP Exeto Concorrente que nao tem CEP ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Mv_Par16 <> "AC3" .AND. (cSUC)->UC_ENTIDAD <> "AC3"
		cCep := TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,5)
		If AllTrim(cCep) < AllTrim(Mv_Par05) .OR. AllTrim(cCep) > AllTrim(Mv_Par06)
			DbSkip()
			Loop
		Endif
	Endif
	
	#IFNDEF TOP
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nao seleciono as ligacoes canceladas                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cSUC)->UC_CODCANC)
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Seleciono somente os atendimentos encerrados³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Val((cSUC)->UC_STATUS) <> 3
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Seleciono somente os tipos de encerramentos do parametro³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par03) .AND. (cSUC)->UC_CODENCE <> Mv_Par03
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valida o operador do parametro caso informado³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par04) .AND. (cSUC)->UC_OPERADO <> Mv_Par04
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona as ligacoes de acordo com o parametro RECEPTIVO/ATIVO/AMBOS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Mv_Par07 <> 3 //Ambos  (Nao sera validado o Tipo de Ligacao para a impressao)
			If Mv_Par07 == 1  //Ativo
				If Val((cSUC)->UC_OPERACA) <> ATIVO .OR. Empty((cSUC)->UC_OPERACA) //"2"
					DbSkip()
					Loop
				Endif
			Else           //Receptivo
				If Val((cSUC)->UC_OPERACA) <> RECEPTIVO .OR. Empty((cSUC)->UC_OPERACA) //"1"
					DbSkip()
					Loop
				Endif
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Permite a impressao somente da entidade informada        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par16) .AND. (cSUC)->UC_ENTIDAD <> Mv_Par16
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifico o contato                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par17) .AND. (cSUC)->UC_CODCONT <> AllTrim(Mv_Par17)
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Chamo a funcao que valida os segmentos de negocios³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Mv_Par16 == "SA1" .OR. Mv_Par16 == "SUS"
			If !TKSegmento(	Mv_Par08,	Mv_Par09,	Mv_Par10,	Mv_Par11,;
							Mv_Par12,	Mv_Par13,	Mv_Par14,	Mv_Par15,;
							Mv_Par16,	(cSUC)->UC_CHAVE)
				DbSkip()
				Loop
			Endif
		Endif
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nao seleciono chamados que sao compartilhamentos         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cSUC)->UC_CHAORIG)
			DbSkip()
			Loop
		EndIf
	
	#ENDIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Comeca a imprimir o relatorio neste ponto³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cCodSUC <> (cSUC)->UC_CODIGO
		If cCodSUC <> "" 
			oSection2:Finish()	      
			oReport:EndPage()				
		EndIf		
		cCodSUC := (cSUC)->UC_CODIGO 
		
		oSection1:PrintLine()
		oReport:ThinLine()
		oReport:SkipLine()
		oSection2:Init()  
		oSection2:SetLineStyle()		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes gerais do atendimento pelo Motivo do Encerramento.³ 
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosTot := Ascan(aTotMot, {|x| x[2]=="MOTIVO"} )
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO 		// Ligacao Receptiva 
				AAdd(aTotMot, { "CODIGO"	,;  // Auxilio
				 				"MOTIVO" 	,; 	// Auxilio
				 				1 		 	,;	// Total das Ligacoes
				 				1 			,; 	// Total Receptivo
				 				0 } ) 			// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO 	// Ligacao Ativa                     
				AAdd(aTotMot, { "CODIGO" 	,;  // Auxilio
								"MOTIVO" 	,;  // Auxilio
								1 			,;	// Total das Ligacoes
								0 			,; 	// Total Receptivo
								1 } ) 			// Total Ativo
			Endif
		Else
			aTotMot[nPosTot][3]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO 		// Ligacao Receptiva 
				aTotMot[nPosTot][4]++
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO 	// Ligacao Ativa
				aTotMot[nPosTot][5]++
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes especificas do atendimento pelo Motivo do Encerramento.³ 
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTotMot , {|x| x[1]==(cSUC)->UC_CODENCE})
		If nPos == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotMot , { (cSUC)->UC_CODENCE 											,; // Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),; // Descricao do Encerramento
								 1 																,; // Total das Ligacoes
								 1 																,; // Total Receptivo
								 0 } ) 															   // Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				AAdd(aTotMot , { (cSUC)->UC_CODENCE 											,; // Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),; // Descricao do Encerramento
								 1 																,; // Total das Ligacoes
								 0 																,; // Total Receptivo
								 1 } )															   // Total Ativo
			Endif
		Else
			aTotMot[nPos][3]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotMot[nPos][4]++
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotMot[nPos][5]++
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes gerais do atendimento por Data e por Motivo.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosTot := Ascan(aTotDtMt, {|x| x[1]=="DATA"} )
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO	// Ligacao Receptiva 
				AAdd(aTotDtMt,{	"DATA" 		,;			// Auxilio
				 				"CODENCE" 	,;   		// Auxilio
								"MOTIVO" 	,;   		// Auxilio
								1 			,;   		// Total das Ligacoes
								1 			,;   		// Total Receptivo
								0 } )		 			// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa                     
				AAdd(aTotDtMt, { "DATA" 	,;			// Auxilio
				 				 "CODENCE" 	,;			// Auxilio
				 				 "MOTIVO" 	,;			// Auxilio
				 				 1			,;   		// Total das Ligacoes
				 				 0 			,;   		// Total Receptivo
				 				 1 } )		 			// Total Ativo
			Endif
		Else
			aTotDtMt[nPosTot][4]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotDtMt[nPosTot][5]++                                     
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotDtMt[nPosTot][6]++
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes especificas do atendimento por Data e por Motivo.	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTotDtMt, {|x| x[1]==DtoS((cSUC)->UC_DATA)} )
		If nPos == 0
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotDtMt, { DtoS((cSUC)->UC_DATA) 											,; 	// Data do Atendimento
 								 (cSUC)->UC_CODENCE 											,; 	// Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),; 	// Descricao do Encerramento
								 1 																,;	// Total das Ligacoes
								 1 																,;  // Total Receptivo
								 0 } )																// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				AAdd(aTotDtMt, { DtoS((cSUC)->UC_DATA) 											,; 	// Data do Atendimento
								 (cSUC)->UC_CODENCE												,; 	// Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),; 	// Descricao do Encerramento
								 1 																,;	// Total das Ligacoes
								 0 																,;  // Total Receptivo
								 1 } )																// Total Ativo
			Endif
		Else
			nPos := Ascan(aTotDtMt, {|x| x[1]== DtoS((cSUC)->UC_DATA) .AND. x[2]==(cSUC)->UC_CODENCE })
			If nPos = 0
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					AAdd(aTotDtMt, { DtoS((cSUC)->UC_DATA) , (cSUC)->UC_CODENCE , Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC") , 1 , 1 , 0 } )
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					AAdd(aTotDtMt, { DtoS((cSUC)->UC_DATA) , (cSUC)->UC_CODENCE , Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC") , 1 , 0 , 1 } )
				Endif
			Else    
				aTotDtMt[nPos][4]++
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					aTotDtMt[nPos][5]++
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					aTotDtMt[nPos][6]++
				Endif
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes gerais do atendimento por Operador e por Motivo.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosTot := Ascan(aTotOpMt, {|x| x[1]=="CODOPER"} )
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO	// Ligacao Receptiva 
				AAdd(aTotOpMt,{	"CODOPER" 	,;			// Auxilio
								"OPERADOR" 	,;			// Auxilio
				 				"CODENCE" 	,;   		// Auxilio
								"MOTIVO" 	,;   		// Auxilio
								1 			,;   		// Total das Ligacoes
								1 			,;   		// Total Receptivo
								0 }	) 					// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa                     
				AAdd(aTotOpMt, { "CODOPER" 	,;			// Auxilio
								 "OPERADOR" ,;			// Auxilio
								 "CODENCE" 	,;   		// Auxilio
								 "MOTIVO" 	,;   		// Auxilio
								 1 			,;   		// Total das Ligacoes
								 0 			,;   		// Total Receptivo
								 1 } )          		// Total Ativo
			Endif
		Else
			aTotOpMt[nPosTot][5]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotOpMt[nPosTot][6]++                                     
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotOpMt[nPosTot][7]++
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes gerais do atendimento por Operador e por Motivo.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTotOpMt, {|x| x[1]==(cSUC)->UC_OPERADO} )
		If nPos == 0
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotOpMt, { (cSUC)->UC_OPERADO 											,; 	// Codigo do Operador
								 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) ,; 	// Nome do Operador
 								 (cSUC)->UC_CODENCE 											,; 	// Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),; 	// Descricao do Encerramento
								 1 																,;	// Total das Ligacoes
								 1 																,;  // Total Receptivo
								 0 } )																// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				AAdd(aTotOpMt, { (cSUC)->UC_OPERADO 											,; 	// Codigo do Operador
				 				 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.),; 	// Nome do Operador
				 				 (cSUC)->UC_CODENCE  											,; 	// Codigo do Encerramento
				 				 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),; 	// Descricao do Encerramento
				 				 1 																,;	// Total das Ligacoes
				 				 0 																,;  // Total Receptivo
				 				 1 } )																// Total Ativo
			Endif
		Else
			nPos := Ascan(aTotOpMt, {|x| x[1]== (cSUC)->UC_OPERADO .AND. x[3]==(cSUC)->UC_CODENCE })
			If nPos = 0
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					AAdd(aTotOpMt, { (cSUC)->UC_OPERADO , FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) , (cSUC)->UC_CODENCE , Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC") , 1 , 1 , 0 } )
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					AAdd(aTotOpMt, { (cSUC)->UC_OPERADO , FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) , (cSUC)->UC_CODENCE , Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC") , 1 , 0 , 1 } )
				Endif
			Else    
				aTotOpMt[nPos][5]++
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					aTotOpMt[nPos][6]++
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					aTotOpMt[nPos][7]++
				Endif
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes gerais do tempo de encerramento por Operador.     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		nPosTot := Ascan(aTotOper, {|x| x[1]=="CODOPER"} )
		If nPosTot == 0
		    AAdd(aTotOper,{	"CODOPER" 								,;	// Auxilio
							"OPERADOR" 								,;	// Auxilio
							1 										,;	// Total de Ligacoes
							((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)	,;	// Tempo Maximo
							((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)   ,;	// Tempo Minimo
							((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)   })	// Tempo Total
		Else
			aTotOper[nPosTot][3]++
			If aTotOper[nPosTot][4] < ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
				aTotOper[nPosTot][4]	:= ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
			Endif    
			If aTotOper[nPosTot][5] > ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
				aTotOper[nPosTot][5]	:= ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
			Endif			
			aTotOper[nPosTot][6]+= ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes especificas do atendimento por Operador.          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		nPosTot := Ascan(aTotOper, {|x| x[1]==(cSUC)->UC_OPERADO} )
		If nPosTot == 0
		    AAdd(aTotOper,{	(cSUC)->UC_OPERADO 												,; 	// Codigo do Operador
							FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.)	,; 	// Nome do Operador
							1				 												,;	// Total de Ligacoes
							((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)							,;	// Tempo Maximo
							((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)  						 	,;	// Tempo Minimo
							((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)   							})	// Tempo Total
		Else
			aTotOper[nPosTot][3]++
			If aTotOper[nPosTot][4] < ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
				aTotOper[nPosTot][4]	:= ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
			Endif    
			If aTotOper[nPosTot][5] > ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
				aTotOper[nPosTot][5]	:= ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
			Endif			
			aTotOper[nPosTot][6]+= ((cSUC)->UC_DTENCER-(cSUC)->UC_DATA)
		Endif
	Endif
	       
	#IFNDEF TOP
		DbSelectArea(cSUD)
		DbSetOrder(1)
		DbSeek(xFilial(cSUD) + (cSUC)->UC_CODIGO)
		While	(!Eof()) .AND. (cSUD)->UD_CODIGO == (cSUC)->UC_CODIGO
	#ENDIF                                                           
			PswOrder(1)
			aUser := IIF(PswSeek((cSUD)->UD_OPERADO),PswRet(1),{})
			oSection2:Cell("S2_USR"):SetValue(IIF(Len(aUser)>0,aUser[1][2],""))
			oSection2:PrintLine() 
			oReport:SkipLine()
	#IFNDEF TOP
			DbSelectArea(cSUD)
			DbSkip()
		End
	#ENDIF
	
	DbSelectArea(cSUC)
	DbSkip()
End        
If cCodSUC <> "" 
	oSection2:Finish()	      
	oReport:EndPage()				
EndIf		
oSection1:Finish()  

oReport:EndPage()

If Len(aTotMot) > 0
    
                  
	//oReport:ThinLine()
	oReport:PrintText("")
	nLine := oReport:Row()

	// "Total de atendimentos registrados para o periodo de " , " a "
	oReport:PrintText(STR0011 + DtoC(Mv_Par01) + STR0012 + DtoC(Mv_Par02),nLine,02)
	oReport:PrintText(Transform(aTotMot[1][3],'@E 999,999'),nLine, 950)
	oReport:PrintText("")	
	
	oReport:PrintText("")
	nLine := oReport:Row()
	//nLine++
//	oReport:PrintText(,nLine,00)	
	oReport:PrintText(STR0013,nLine,00)	 // "AVALIAÇÃO DE TEMPOS DO PERÍODO (DIAS)"
	oReport:PrintText("")	
	oReport:ThinLine()
	oReport:Line()
	
	oReport:SkipLine()    
	nLine := oReport:Row()	
	oReport:PrintText(STR0014,nLine,02)	// "Tempo máximo para o Encerramento de um atendimento"
	oReport:PrintText(Transform(aTotOper[1][4],'@E 999.999'),nLine,950)	

	oReport:SkipLine()
	nLine := oReport:Row()		                                                              
	oReport:PrintText(STR0015,nLine,02)	 // "Tempo mínimo para o Encerramento de um atendimento"	
	oReport:PrintText(Transform(aTotOper[1][5],'@E 999.999'),nLine,950)	
	                                                                                          
	oReport:SkipLine()
	nLine := oReport:Row()		                                                              	
	oReport:PrintText(STR0016,nLine,02) // "Tempo mínimo para o Encerramento de um atendimento"	
	oReport:PrintText(Transform(aTotOper[1][6]/aTotOper[1][3],'@E 999.999'),nLine,950)	


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Motivo.				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine()
	oReport:SkipLine()		
	ASort(aTotMot,2,,{|x,y| x[3] > y[3]})

	oSection3:Init()		
	For nI := 2 To Len(aTotMot)
		oReport:SkipLine()
		nLine := oReport:Row()		
		If Mv_Par07 == 3				
			oSection3:Cell("S3_MOTIV"):SetValue(aTotMot[nI][1] + " - " + aTotMot[nI][2])
			oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotMot[nI][5],'@E 999,999'))
			oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotMot[nI][5]/aTotMot[1][3]*100, '@E 999.99'))
			oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotMot[nI][4],'@E 999,999'))
			oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotMot[nI][4]/aTotMot[1][3]*100, '@E 999.99'))
			oSection3:Cell("S3_TOT"):SetValue(Transform(aTotMot[nI][5]+aTotMot[nI][4],'@E 999,999'))
			oSection3:Cell("S3_PERC_TOT"):SetValue(Transform((aTotMot[nI][5]/aTotMot[1][3]*100)+(aTotMot[nI][4]/aTotMot[1][3]*100), '@E 999.99'))
		Else                     
			oSection3:Cell("S3_MOTIV"):SetValue(aTotMot[nI][1] + " - " + aTotMot[nI][2])					
	     	If Mv_Par07 == 1 // Ativo
				oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotMot[nI][3],'@E 999,999'))
				oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotMot[nI][3]/aTotMot[1][3]*100, '@E 999.99'))
			Else
				oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotMot[nI][3],'@E 999,999'))
				oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotMot[nI][3]/aTotMot[1][3]*100, '@E 999.99'))
			EndIf
		Endif 
		oSection3:PrintLine()		
	Next nI

	If Mv_Par07 == 3 
		oSection3:Cell("S3_MOTIV"):SetValue(STR0028)
		oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotMot[1][5],'@E 999,999'))
		oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotMot[1][5]/aTotMot[1][3]*100, '@E 999.99'))
		oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotMot[1][4],'@E 999,999'))
		oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotMot[1][4]/aTotMot[1][3]*100, '@E 999.99'))
		oSection3:Cell("S3_TOT"):SetValue(Transform(aTotMot[1][5]+aTotMot[1][4],'@E 999,999'))
		oSection3:Cell("S3_PERC_TOT"):SetValue(Transform((aTotMot[1][5]/aTotMot[1][3]*100)+(aTotMot[1][4]/aTotMot[1][3]*100), '@E 999.99'))
	Else 

		oSection3:Cell("S3_MOTIV"):SetValue(STR0028)
		If Mv_Par07 == 1 // Ativo
			oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotMot[1][3],'@E 999,999'))
			oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotMot[1][3]/aTotMot[1][3]*100, '@E 999.99'))
		Else
			oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotMot[1][3],'@E 999,999'))
			oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotMot[1][3]/aTotMot[1][3]*100, '@E 999.99'))		
		EndIf
	Endif	
	oSection3:PrintLine()	
	oSection3:Finish()
	
	aTotMot := {}  
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Data e Operador.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection4:Init()
	For nI := 2 To Len(aTotDtMt)				
		oSection4:Cell("S4_DATA"):SetValue(StoD(aTotDtMt[nI][1]))
		If Mv_Par07 == 3
			oSection4:Cell("S4_MOTIV"):SetValue(aTotDtMt[nI][2] + " - " + aTotDtMt[nI][3])
			oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotDtMt[nI][6], '@E 999,999'))
			oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotDtMt[nI][5], '@E 999,999'))
			oSection4:Cell("S4_TOT"):SetValue(Transform(aTotDtMt[nI][6]+aTotDtMt[nI][5], '@E 999,999'))
		Else
			oSection4:Cell("S4_MOTIV"):SetValue(aTotDtMt[nI][2] + " - " + aTotDtMt[nI][3])
			If Mv_Par07 == 1 // Ativo
				oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotDtMt[nI][4], '@E 999,999'))
			Else
				oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotDtMt[nI][4], '@E 999,999'))
			EndIf
		Endif
		oSection4:PrintLine()		
	Next nI
	
	oSection4:Cell("S4_MOTIV"):SetValue(STR0028)
	If Mv_Par07 == 3
		oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotDtMt[1][6], '@E 999,999'))
		oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotDtMt[1][5], '@E 999,999'))
		oSection4:Cell("S4_TOT"):SetValue(Transform(aTotDtMt[1][6]+aTotDtMt[1][5], '@E 999,999'))
	Else
		If Mv_Par07 == 1 // Ativo
			oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotDtMt[1][4], '@E 999,999'))
		Else
			oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotDtMt[1][4], '@E 999,999'))
		EndIf
	Endif	
	oSection4:PrintLine()	
		
	oSection4:Finish()
	aTotDtMt := {}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime os tempos de encerramento por Operador.			   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ASort(aTotOper,2,,{|x,y| x[4] > y[4]})
	oSection5:Init()
	For nI := 2 To Len(aTotOper)                                  
		oSection5:Cell("S5_OPER"):SetValue(aTotOper[nI][1] + " - " + aTotOper[nI][2])
		oSection5:Cell("S5_MEDIA"):SetValue(Transform(aTotOper[nI][6]/aTotOper[nI][3], '@E 999.999'))
		oSection5:Cell("S5_DESVIO"):SetValue(Transform(((aTotOper[nI][6]/aTotOper[nI][3])-(aTotOper[1][6]/aTotOper[1][3])) , '@E 999.999'))
		oSection5:Cell("S5_MAX"):SetValue(Transform(aTotOper[nI][4], '@E 999.999'))
		oSection5:Cell("S5_MIN"):SetValue(Transform(aTotOper[nI][5], '@E 999.999'))		
		oSection5:PrintLine()
	Next nI	
	
	oSection5:Cell("S5_OPER"):SetValue(STR0038)
	oSection5:Cell("S5_MEDIA"):SetValue(Transform(aTotOper[1][6]/aTotOper[1][3], '@E 999.999'))	
	oSection5:Cell("S5_DESVIO"):SetValue(Transform(((aTotOper[1][6]/aTotOper[1][3])-(aTotOper[1][6]/aTotOper[1][3])) , '@E 999.999'))	
	oSection5:Cell("S5_MAX"):SetValue(Transform(aTotOper[1][4], '@E 999.999'))	
	oSection5:Cell("S5_MIN"):SetValue(Transform(aTotOper[1][5], '@E 999.999'))	
	oSection5:PrintLine()

	aTotOper := {} 
	oSection5:Finish()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Operador e por Motivo. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ASort(aTotOpMt,2,,{|x,y| x[1] > y[1]})
	oSection6:Init()

	For nI := 2 To Len(aTotOpMt)
		oSection6:Cell("S6_OPERADOR"):SetValue(aTotOpMt[nI][1] + " - " + aTotOpMt[nI][2])
		If Mv_Par07 == 3 // Ambos
			oSection6:Cell("S6_MOTIV"):SetValue(aTotOpMt[nI][3] + " - " + aTotOpMt[nI][4])
			oSection6:Cell("S6_ATIVO"):SetValue(Transform(aTotOpMt[nI][7], '@E 999,999'))
			oSection6:Cell("S6_PERC_AT"):SetValue(Transform(aTotOpMt[nI][7]/aTotOpMt[1][5]*100, '@E 999.99'))
			oSection6:Cell("S6_RECEP"):SetValue(Transform(aTotOpMt[nI][6], '@E 999,999'))
			oSection6:Cell("S6_PERC_RP"):SetValue(Transform(aTotOpMt[nI][6]/aTotOpMt[1][5]*100, '@E 999.99'))
			oSection6:Cell("S6_TOT"):SetValue(Transform(aTotOpMt[nI][7]+aTotOpMt[nI][6], '@E 999,999'))
			oSection6:Cell("S6_PERC_TOT"):SetValue(Transform((aTotOpMt[nI][6]/aTotOpMt[1][5]*100)+(aTotOpMt[nI][7]/aTotOpMt[1][5]*100), '@E 999.99'))
		Else         
			oSection6:Cell("S6_MOTIV"):SetValue(aTotOpMt[nI][3] + " - " + aTotOpMt[nI][4])
			If Mv_Par07 == 1 // Ativo			
				oSection6:Cell("S6_ATIVO"):SetValue(Transform(aTotOpMt[nI][5], '@E 999,999'))
				oSection6:Cell("S6_PERC_AT"):SetValue(Transform(aTotOpMt[nI][5]/aTotOpMt[1][5]*100, '@E 999.99'))
			Else
				oSection6:Cell("S6_RECEP"):SetValue(Transform(aTotOpMt[nI][5], '@E 999,999'))
				oSection6:Cell("S6_PERC_RP"):SetValue(Transform(aTotOpMt[nI][5]/aTotOpMt[1][5]*100, '@E 999.99'))
			EndIf
		Endif
		cCodOp := aTotOpMt[nI][1]
		oSection6:PrintLine()			
	Next nI	                                 
	
	oSection6:Cell("S6_OPERADOR"):SetValue(STR0028)
	oSection6:Cell("S6_MOTIV"):SetValue("")

	If Mv_Par07 == 3 // Ambos
		oSection6:Cell("S6_ATIVO"):SetValue(Transform(aTotOpMt[1][7], '@E 999,999'))
		oSection6:Cell("S6_PERC_AT"):SetValue(Transform(aTotOpMt[1][7]/aTotOpMt[1][5]*100, '@E 999.99'))
		oSection6:Cell("S6_RECEP"):SetValue(Transform(aTotOpMt[1][6], '@E 999,999'))
		oSection6:Cell("S6_PERC_RP"):SetValue(Transform(aTotOpMt[1][6]/aTotOpMt[1][5]*100, '@E 999.99'))
		oSection6:Cell("S6_TOT"):SetValue(Transform(aTotOpMt[1][7]+aTotOpMt[1][6], '@E 999,999'))
		oSection6:Cell("S6_PERC_TOT"):SetValue(Transform((aTotOpMt[1][6]/aTotOpMt[1][5]*100)+(aTotOpMt[1][7]/aTotOpMt[1][5]*100), '@E 999.99'))
	Else
		If Mv_Par07 == 1 // Ativo
			oSection6:Cell("S6_ATIVO"):SetValue(Transform(aTotOpMt[1][5], '@E 999,999'))
			oSection6:Cell("S6_PERC_AT"):SetValue(Transform(aTotOpMt[1][5]/aTotOpMt[1][5]*100, '@E 999.99'))
		Else
			oSection6:Cell("S6_RECEP"):SetValue(Transform(aTotOpMt[1][5], '@E 999,999'))
			oSection6:Cell("S6_PERC_RP"):SetValue(Transform(aTotOpMt[1][5]/aTotOpMt[1][5]*100, '@E 999.99'))		
		EndIf
	Endif
	oSection6:PrintLine()

	aTotOpMt := {}
	oSection6:Finish()

Else
	oReport:PrintText(STR0010) // "Nao Existem dados a serem impressos para este relatorio com os parametros informados")
EndIf

Return(.T.)

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