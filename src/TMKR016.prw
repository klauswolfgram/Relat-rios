/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR016.CH"     
#INCLUDE "TMKDEF.CH" 
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR016  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 20/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Ligacoes realizadas no atendimento de Televendas           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Televendas (SUA)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K ³10/07/03³710   ³Correcao do seek na Tabela SU9 para indice 2³±±
±±³Andrea F. ³07/07/04³710   ³Inclusao de novos campos no cabecalho do    ³±±
±±³          ³        ³      ³relatorio e de totalizadores com informacoes³±±
±±³          ³        ³      ³estatisticas no final do relatorio.         ³±±
±±³Michel W. ³03/08/06³99187 ³Atualizacao de relatorio para release 4.    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                

User Function TMKR016()

Local oReport	:= Nil	//Objeto relatorio TReport (Release 4)

Static cEntidade

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK016",.F.)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                          ³
//³ MV_PAR01           // Do Operador                             ³
//³ MV_PAR02           // Ate o Operador                          ³
//³ MV_PAR03           // A Partir de                             ³
//³ MV_PAR04           // Ate o dia                               ³
//³ MV_PAR05           // Da Midia                                ³
//³ MV_PAR06           // Ate a Midia                             ³
//³ MV_PAR07           // Campanha         - Vazio entra tudo     ³
//³ MV_PAR08           // Tipo da Entidade - SA1, SUS ou TODAS    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport	:= ReportDef()
oReport:PrintDialog() 

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef    ³ Autor ³Michel W. Mosca     ³ Data ³03/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Ligacoes realizadas - televendas.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CALL CENTER                                                ³±±
±±³ Fernando ³811   |11/10/06|Foi modificada a funcao ReportDef para      ³±±
±±³			 |		|		 |criacao de string a ser visualizada na opcao³±±
±±³			 |		|		 |Personalizar do relatorio TMKR016           ³±±                               
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()

Local oReport	:= Nil				//Objeto relatorio TReport (Release 4)
Local oSection1	:= Nil				//Objeto secao 1 do relatorio (Dados do atendimentos)
Local oSection2	:= Nil				//Objeto secao 2 do relatorio (Itens vendidos)
Local oSection3	:= Nil				//Totalizador no fim do relatório
Local oSection4	:= Nil				//Totalizador no fim do relatório
Local oSection5	:= Nil				//Totalizador no fim do relatório
Local oSection6	:= Nil				//Totalizador no fim do relatório
Local cSUA		:= GetNextAlias()	//Pega o proximo Alias Disponivel (Alias da consulta Embedded SQL)     
Local cSUB		:= "SUB"			//Alias da consulta Embedded SQL	

// "Ligacoes Realizadas - Televendas" # // "Este programa ira emitir uma relacao das ligacoes realizadas pelo operador no atendimento Televendas." #
// "Os dados serao emitidos conforme os parametros informados." # // "OBS: Serao considerados apenas os ORCAMENTOS e PEDIDOS."
DEFINE REPORT oReport NAME "TMKR016" TITLE STR0001 PARAMETER "TMK016" LANDSCAPE ACTION {|oReport| Tkr016PrtRpt(oReport, cSUA, cSUB)} DESCRIPTION STR0002 + STR0003 + STR0004

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport   TITLE STR0062 TABLES cSUA LINE BREAK AUTO SIZE COLUMN SPACE 8     //Atendimento                   
DEFINE SECTION oSection2 OF oSection1 TITLE STR0064 TABLES cSUB LINE BREAK AUTO SIZE COLUMN SPACE 5  	// Itens do Atendimento
DEFINE SECTION oSection3 OF oReport   TITLE STR0063                   //Forma de Pagamento
DEFINE SECTION oSection4 OF oReport   TITLE STR0036                  //periodo do Atendimento
DEFINE SECTION oSection5 OF oReport   TITLE STR0037                 //Total de faturamento
DEFINE SECTION oSection6 OF oReport   TITLE STR0044                 //Quantidade de Produtos vendidos

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "UA_NUM"			OF oSection1 ALIAS cSUA	//ATENDIMENTO	
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||IIf((cSUA)->UA_PROSPEC,STR0032,STR0033)} TITLE STR0010 SIZE 40 	//"Entidade"				
DEFINE CELL NAME "UA_TABELA"		OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_TABELA + " - " + Posicione("DA0",1,xFilial("DA0")+(cSUA)->UA_TABELA,"DA0_DESCRI")} TITLE STR0017 SIZE 25	//"Tabela de Preco"							 
DEFINE CELL NAME "UA_EMISSAO"		OF oSection1 ALIAS cSUA 	//"Data"				
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_CLIENTE + " / " + (cSUA)->UA_LOJA + " - " +TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,1,,.T.)} TITLE STR0011 SIZE 50	//"Razao Social"							
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_CONDPG  + " - " + Posicione("SE4",1,xFilial("SE4")+(cSUA)->UA_CONDPG,"E4_DESCRI")} TITLE STR0038 SIZE 25 	//"Cond. Pagamento"		
DEFINE CELL NAME "UA_OPER"			OF oSection1 ALIAS cSUA 	//"Operacao"
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,2,,.T.)} TITLE STR0013
DEFINE CELL NAME "UA_TPFRETE"		OF oSection1 ALIAS cSUA				
DEFINE CELL NAME "UA_TMK"			OF oSection1 ALIAS cSUA				
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,10,,.T.)} TITLE STR0019 	//"Bairro"			     
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_TRANSP + " - " + FATPDObfuscate(Posicione("SA4",1,xFilial("SA4")+(cSUA)->UA_TRANSP,"A4_NREDUZ"),"A4_NREDUZ",,.T.)} TITLE STR0045 SIZE 25								
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_OPERADO + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUA)->UA_OPERADO,"U7_NREDUZ"),"U7_NREDUZ",,.T.)} TITLE STR0018 SIZE 25		//"Operador"			
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,3,,.T.) + " - " + TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,4,,.T.)} TITLE STR0021 	// "Cidade"##"Estado"
                   					                                  	 								 
DEFINE CELL NAME "UA_ENDENT"		OF oSection1 ALIAS cSUA	//"End. Entrega"		  		
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_VEND + " - " + FATPDObfuscate(Posicione("SA3",1,xFilial("SA3")+(cSUA)->UA_VEND,"A3_NREDUZ"),"A3_NREDUZ",,.T.)} TITLE STR0020 SIZE 25  //"Vendedor"				
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||ALLTRIM(TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,9,,.T.)) + " - " + TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,6,,.T.)} TITLE STR0047  SIZE 25//DDD

DEFINE CELL NAME "UA_BAIRROE"		OF oSection1 ALIAS cSUA	//"Bairro Entrega"				
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_MIDIA + " - " + Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")} TITLE STR0022  SIZE 25 // "Midia"		 							 
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_CODCONT + " - " + TkDadosContato((cSUA)->UA_CODCONT,0,.T.)} TITLE STR0012	 SIZE 25 //"Contato"			
DEFINE CELL NAME "UA_MUNE"			OF oSection1 ALIAS cSUA	//"Cidade Entrega"				
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_CODCAMP + " - " + Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")} TITLE STR0024  SIZE 25 // "Descricao da Campanha"
										
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||Alltrim(TkDadosContato((cSUA)->UA_CODCONT,8,.T.))+ " - " + TkDadosContato((cSUA)->UA_CODCONT,4,.T.)} TITLE STR0023 SIZE 25 //DDD
                   					                                         								
DEFINE CELL NAME "UA_ESTE"			OF oSection1 ALIAS cSUA 	//"Estado Entrega"				  
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||(cSUA)->UA_CODLIG + " - " + Posicione("SU9",2,xFilial("SU9")+(cSUA)->UA_CODLIG,"U9_DESC")} TITLE STR0026   SIZE 25 //"Ocorrencia"

DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||TkDadosContato((cSUA)->UA_CODCONT,10,.T.)} TITLE STR0025 SIZE 25	//"Descricao do Email"			
DEFINE CELL NAME ""					OF oSection1 ALIAS cSUA BLOCK {||DTOC((cSUA)->UA_PROXLIG) + " - " +  (cSUA)->UA_HRPEND + " - " + (cDia:= Tk_DiaSemana((cSUA)->UA_PROXLIG,Nil,Nil))} TITLE STR0028 SIZE 25									
DEFINE CELL NAME "UA_CODOBS"		OF oSection1 ALIAS cSUA  

DEFINE CELL NAME "UB_ITEM"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_PRODUTO"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME ""					OF oSection2 ALIAS cSUB BLOCK {||Posicione("SB1",1,xFilial("SB1")+SUB->UB_PRODUTO,"B1_DESC")} SIZE 25 TITLE "DESCRICAO" 
DEFINE CELL NAME "UB_SITPROD"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_QUANT"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_VRUNIT"		OF oSection2 ALIAS cSUB    
DEFINE CELL NAME "UB_VLRITEM"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_DESC"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_VALDESC"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_ACRE"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_VALACRE"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_TES"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_CF"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_PRCTAB"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_BASEICM"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_LOCAL"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_UM"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_DTENTRE"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_LOTE"			OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_SUBLOTE"		OF oSection2 ALIAS cSUB
DEFINE CELL NAME "UB_DTVALID"		OF oSection2 ALIAS cSUB

DEFINE CELL NAME "S3_DATA"			OF oSection3 TITLE STR0008 SIZE 15
DEFINE CELL NAME "S3_ORC"			OF oSection3 TITLE STR0057 SIZE 8
DEFINE CELL NAME "S3_VLORC"			OF oSection3 TITLE STR0058 SIZE 8
DEFINE CELL NAME "S3_FAT"			OF oSection3 TITLE STR0059 SIZE 8
DEFINE CELL NAME "S3_VRFAT"			OF oSection3 TITLE STR0060 SIZE 8      

DEFINE CELL NAME "S4_OPER"			OF oSection4 TITLE STR0018 SIZE 25
DEFINE CELL NAME "S4_VLR"			OF oSection4 TITLE STR0061 SIZE 15
DEFINE CELL NAME "S4_ATEND"			OF oSection4 TITLE STR0062 SIZE 15

DEFINE CELL NAME "S5_MIDIA"			OF oSection5 TITLE STR0022 SIZE 15
DEFINE CELL NAME "S5_PROD"			OF oSection5 TITLE STR0039 SIZE 15
DEFINE CELL NAME "S5_QTDE"			OF oSection5 TITLE STR0055 SIZE 15 //QUANTIDADE

DEFINE CELL NAME "S6_CAMP"			OF oSection6 TITLE STR0024 SIZE 15
DEFINE CELL NAME "S6_PROD"			OF oSection6 TITLE STR0039 SIZE 15
DEFINE CELL NAME "S6_QTDE"			OF oSection6 TITLE STR0055 SIZE 15 //QUANTIDADE
Return(oReport) 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr016PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³04/08/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de           ³±±
±±³          ³Ligacoes realizadas - Televendas.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr016PrtRept(ExpO1,ExpC2,ExpC3)                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC2 = alias da query atual                               ³±±
±±³          ³ ExpC3 = alias da query atual                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr016PrtRpt(oReport, cSUA, cSUB)

Local oSection1 := oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection2 := oSection1:Section(1)		//Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local oSection3 := oReport:Section(2)		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection4 := oReport:Section(3)      //Totalizador no fim do relatório
Local oSection5 := oReport:Section(4)      //Totalizador no fim do relatório
Local oSection6 := oReport:Section(5)      //Totalizador no fim do relatório
Local cFiltro	:= ""                      //String contendo o filtro de busca a ser utilizado com DBF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de variaveis especificas para este relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local dData			:= CTOD("//")	// Para quebra de relatorio
Local aLinhas		:= {}			// Linha do campo memo
Local aTotDia		:= {}			// Total de atendimentos diarios
Local aValOper		:= {}			// Valor de faturamento por operador
Local aProdMid		:= {}			// Produtos vendidos por midia
Local aProdCamp		:= {}			// Produtos vendidos por campanha
Local aFatura		:= {} 
Local nI			:= 0			// Controle
Local nPos			:= 0			// Ponteiro da pesquisa no array
Local nTotFat		:= 0			// Numero de Faturamentos por dia
Local nTotOrc		:= 0			// Numero de Orcamentos por dia
Local nValFat		:= 0			// Valor de Faturamento por dia
Local nValOrc		:= 0			// Valor de Orcamentos por dia
Local nCol			:= 0
Local nLoopParc		:= 0   
Local cMidia  		:= ""			// Controle de quebra de midia 
Local cCodCamp		:= ""			// Controle de quebra de Campanha
Local cFormPag      := ""
Local cPgLine		:= ""			//Var. auxiliar para impressao das formas de pagamento
Local cCodSUA		:= ""			// Controla a quebra do cabecalho do atendimento
Local cFilSL4		:= xFilial("SL4")
Local cFilSUB		:= xFilial("SUB")
Local cFilSB1		:= xFilial("SB1")
Local cFilSU7		:= xFilial("SU7")
Local cFilSUH		:= xFilial("SUH")
Local cFilSUO		:= xFilial("SUO")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMK016")      
	
cQuery :=	"%      	SUA.UA_FILIAL = '" + xFilial("SUA") + "' AND " +;
			" 		SUA.UA_EMISSAO BETWEEN '" + DtoS(MV_PAR03) + "' AND '" + DtoS(MV_PAR04) + "' AND" +;
			" 		SUA.UA_OPERADO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' AND" +;
			" 		SUA.UA_MIDIA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' AND" +;
			" 		SUA.UA_CANC = '' AND" +;
			" 		SUA.UA_TMK = '2' AND " +;	// Ativo
			" 		(SUA.UA_OPER = '1' OR SUA.UA_OPER = '2') AND "	// Orcamento - Faturamento
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciono somente a campanha informada nos parametros³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(MV_PAR07)
	cQuery +=	" 	SUA.UA_CODCAMP = '" + MV_PAR07 + "' AND"
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciono somente o tipo de entidade dos parametros³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR08 <> 3		// Ambos
	If MV_PAR08 == 1	// Clientes
		cQuery +=	" 	SUA.UA_PROSPEC = 'F' AND"
	Else				// Prospects
		cQuery +=	" 	SUA.UA_PROSPEC = 'T' AND"
	Endif
Endif
cQuery +=	"	SUA.D_E_L_E_T_ = ' ' AND"
	
cQuery +=	"	SUB.UB_FILIAL = '" + cFilSUB + "' AND" +;
			"	SUB.UB_NUM = SUA.UA_NUM AND" +;
			"	SUB.D_E_L_E_T_ = ' ' AND" +;
			"	SB1.B1_FILIAL = '" + cFilSB1 + "' AND" +;
			"	SB1.B1_COD = SUB.UB_PRODUTO AND" +;
			"	SB1.D_E_L_E_T_ = ' ' %"

BEGIN REPORT QUERY oSection1
 	BeginSQL alias cSUA
		SELECT 	UA_FILIAL,		UA_EMISSAO,		UA_TMK,			UA_OPERADO,
				UA_MIDIA,		UA_CODCAMP,		UA_PROSPEC,		UA_CANC,
				UA_OPER,		UA_NUM,			UA_VLRLIQ, 		UA_CODLIG,
				UA_LOJA,		UA_CLIENTE,		UA_TRANSP,		UA_CONDPG,
				UA_TPFRETE,		UA_TABELA,		UA_ENDENT,		UA_BAIRROE,
				UA_MUNE,		UA_ESTE,		UA_CODOBS,		UA_PROXLIG,
				UA_HRPEND,		UA_CODCONT,		UA_VEND,
				UB_ACRE, 		UB_BASEICM, 	UB_CF, 			UB_DESC,
				UB_DTENTRE, 	UB_DTVALID, 	UB_FILIAL, 		UB_ITEM,
				UB_LOCAL,		UB_LOTE, 		UB_NUM, 		UB_PRCTAB,
				UB_PRODUTO, 	UB_QUANT, 		UB_SITPROD, 	UB_SUBLOTE,
				UB_TES, 		UB_UM,			UB_VALDESC, 	UB_VLRITEM,
				UB_VRUNIT, 		UB_VALACRE, 	B1_DESC
		FROM %table:SUA% SUA, %table:SUB% SUB, %table:SB1% SB1
		WHERE %exp:cQuery%
		ORDER BY %order:SUA%
    EndSql
END REPORT QUERY oSection1

SL4->(DbSetOrder(1))	// L4_FILIAL+L4_NUM+L4_ORIGEM
(cSUB)->(DbSetOrder(1))	// UB_FILIAL+UB_NUM+UB_ITEM+UB_PRODUTO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quebra a linha, caso existam muitas colunas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:SetLineBreak()
While	(cSUA)->(!Eof())
	oReport:IncMeter()
	
	If oReport:Cancel()
		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta uma string com as formas de pagamento utilizada na venda³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cFormPag := ""
	If SL4->(DbSeek(cFilSL4 + (cSUA)->UA_NUM + "SIGATMK"))
		While SL4->(! Eof())                .AND.;
		      SL4->L4_FILIAL == cFilSL4     .AND.;
		      SL4->L4_NUM == (cSUA)->UA_NUM .AND.;
		      Trim(SL4->L4_ORIGEM) == "SIGATMK"
			If !(Trim(SL4->L4_FORMA) $ cFormPag)
				cFormPag := cFormPag + Trim(SL4->L4_FORMA) + "/"
			Endif
			AaDd(aFatura, {SL4->L4_DATA, SL4->L4_VALOR, SL4->L4_FORMA} )
			SL4->(DbSkip())
		EndDo
		cFormPag := SubStr(cFormPag,1,Len(cFormPag)-1)
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Quebra de atendimento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cSUA)->UA_NUM <> cCodSUA
		cCodSUA := (cSUA)->UA_NUM

		If (cSUA)->UA_PROSPEC
			cEntidade	:= "SUS"
		Else
			cEntidade	:= "SA1"
		Endif
		oSection1:Init()
		oSection1:SetLineStyle()
		oSection1:PrintLine()
		oSection1:Finish()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Sumariza os atendimentos de acordo com o tipo de operacao³
		//³Esta sendo sumarizado o valor liquido do atendimento que ³
		//³contem despesas, acrescimos, descontos etc.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF VAL((cSUA)->UA_OPER) == FATURAMENTO
			nTotFat	:= 1
			nValFat	:= (cSUA)->UA_VLRLIQ
			nValOrc	:= 0
		ElseIf 	 VAL((cSUA)->UA_OPER) == ORCAMENTO
			nTotOrc	:= 1
			nValOrc	:= (cSUA)->UA_VLRLIQ
			nValFat	:= 0
		Endif
        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza os atendimentos por data com os dados de orcamento e faturamento.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aTotDia) > 0
			If ( nPos := aScan(aTotDia, {|x| x[1] == (cSUA)->UA_EMISSAO} ) ) == 0
				aAdd(aTotDia,{(cSUA)->UA_EMISSAO, 0, 0, 0, 0, 0, 0})
				nPos := Len(aTotDia)
			Endif
		Else
			aAdd(aTotDia,{(cSUA)->UA_EMISSAO, 0, 0, 0, 0, 0, 0})
			nPos := Len(aTotDia)
		Endif
		aTotDia[nPos][2]	+= nTotOrc
		aTotDia[nPos][3]	+= nValOrc
		aTotDia[nPos][4]	+= nTotFat
		aTotDia[nPos][5]	+= nValFat
		aTotDia[nPos][6]++
		aTotDia[nPos][7]	+= ( nValOrc + nValFat )

		nTotOrc	:= 0
		nValOrc	:= 0
		nTotFat	:= 0
		nValFat	:= 0
	  
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valor total em dinheiro dos faturamentos realizados por operador.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If VAL((cSUA)->UA_OPER) == FATURAMENTO
			If ( nPos := aScan(aValOper, {|x| x[1]==(cSUA)->UA_OPERADO} ) ) == 0
				aAdd(aValOper, {(cSUA)->UA_OPERADO, 0 , 0 })
				nPos := Len(aValOper)
			EndIf
			aValOper[nPos][2]	+= (cSUA)->UA_VLRLIQ
			aValOper[nPos][3]	+= 1
		Endif
		
		oSection2:Init()
		oSection2:SetLineBreak()

		(cSUB)->(DbSeek(cFilSUB + (cSUA)->UA_NUM))
		While	(cSUB)->(! Eof())				.AND.;
				(cSUB)->UB_FILIAL	==	cFilSUB	.AND.;
				(cSUB)->UB_NUM		==	(cSUA)->UA_NUM

			oSection2:PrintLine()	
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Quantidade total de cada produto vendido dentro de cada midia.      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If VAL((cSUA)->UA_OPER) == FATURAMENTO
				If !Empty((cSUA)->UA_MIDIA)
					If ( nPos := aScan(aProdMid, {|x,y| x[1]==(cSUA)->UA_MIDIA .AND. x[2]==(cSUB)->UB_PRODUTO } ) ) == 0
						aAdd(aProdMid, {(cSUA)->UA_MIDIA,(cSUB)->UB_PRODUTO,0} )
						nPos := Len(aProdMid)
					Endif
					aProdMid[nPos][3]	+= (cSUB)->UB_QUANT
				Endif	
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Quantidade total de cada produto vendido dentro de cada campanha.   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If VAL((cSUA)->UA_OPER) == FATURAMENTO
				If !Empty((cSUA)->UA_CODCAMP)
					If ( nPos := aScan(aProdCamp, {|x,y| x[1]==(cSUA)->UA_CODCAMP .AND. x[2]==(cSUB)->UB_PRODUTO }) ) == 0
						aAdd(aProdCamp, {(cSUA)->UA_CODCAMP, (cSUB)->UB_PRODUTO, 0})
						nPos := Len(aProdCamp)
					Endif
					aProdCamp[nPos][3]	+= (cSUB)->UB_QUANT
				Endif
			Endif

			(cSUB)->(DbSkip())
		EndDo
		oSection2:Finish()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime as formas de pagamento.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If len(aFatura) > 0
			nCol := 0
			
			oReport:SkipLine()

			oReport:PrintText(STR0051)	//"| Vencto     Forma          Valor || Vencto     Forma          Valor || Vencto     Forma          Valor || Vencto     Forma          Valor |"
			oReport:ThinLine()

			cPgLine		:= ""
			nLoopParc	:= 0
			For nI := 1 to len(aFatura)
				++nLoopParc
				cPgLine += "| " + DtoC(aFatura[nI][1]) + " " + SubStr(aFatura[nI][3],1,9) + " " + Transform(aFatura[nI][2], "@E 999,999.99") + " |"
				nCol	+= 34
				If nLoopParc == 4
					oReport:PrintText(cPgLine)
					oReport:SkipLine()
					cPgLine		:= ""
					nCol		:= 0
					nLoopParc	:= 0
				EndIf
			Next nI
			If nLoopParc > 0 .AND. nLoopParc < 4
				cPgLine += Replicate("|                                 |",4-nLoopParc)
			EndIf
			If cPgLine <> "" 
				oReport:PrintText(cPgLine)
			EndIf
			oReport:ThinLine()
		Endif
		
		aFatura   := {}
		nTotQtd   := 0
		nTotGeral := 0
		
		oReport:EndPage()
	EndIf		          

	(cSUA)->(DbSkip())
EndDo 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Totais gerais impressos na ultima pagina do relatorio. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Total Diario de Atendimentos com valores de Orcamentos e Faturamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aTotDia) > 0

	oReport:SkipLine()
	oReport:PrintText(PadR(STR0036 + DtoC(MV_PAR03) + STR0043 + DtoC(MV_PAR04),80))//"Total de atendimentos realizados no periodo de " //" a "
	oReport:SkipLine()	

	aSort(aTotDia,,, {|x,y| x[1] < y[1]} )		// Coloca em ordem Crescente

	oSection3:Init()
	For nI := 1 To Len(aTotDia)
		oSection3:Cell("S3_DATA"):SetValue(Dtoc(aTotDia[nI][1]))								// Data
		oSection3:Cell("S3_ORC"):SetValue(Transform(aTotDia[nI][2],   '@E 999999'))				// Numero de Orcamentos
		oSection3:Cell("S3_VLORC"):SetValue(Transform(aTotDia[nI][3], '@E 999,999,999.99'))		// Valor em Reais dos Orcamentos 
		oSection3:Cell("S3_FAT"):SetValue(Transform(aTotDia[nI][4],   '@E 999999'))				// Numero de Faturamento
		oSection3:Cell("S3_VRFAT"):SetValue(Transform(aTotDia[nI][5], '@E 999,999,999.99'))		// Valor em Reais dos Faturamento 		
		oSection3:PrintLine()
		nTotOrc	+= aTotDia[nI][2]
		nValOrc	+= aTotDia[nI][3]
		nTotFat	+= aTotDia[nI][4]
		nValFat	+= aTotDia[nI][5]
	Next nI

	oSection3:Cell("S3_DATA"):SetValue(STR0053)													//"Total Geral"
	oSection3:Cell("S3_ORC"):SetValue(Transform(nTotOrc,   '@E 999999'))						// Numero de Orcamentos
	oSection3:Cell("S3_VLORC"):SetValue(Transform(nValOrc, '@E 999,999,999.99'))				// Valor em Reais dos Orcamentos 
	oSection3:Cell("S3_FAT"):SetValue(Transform(nTotFat,   '@E 999999'))						// Numero de Faturamento
	oSection3:Cell("S3_VRFAT"):SetValue(Transform(nValFat, '@E 999,999,999.99'))				// Valor em Reais dos Faturamento 		
	oSection3:PrintLine()
	
	oSection3:Finish()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total geral de faturamento por operador³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aValOper) > 0
		oSection4:Init()
		oReport:ThinLine()		
		oReport:SkipLine()
		oReport:PrintText(STR0037)//"VALOR TOTAL EM REAIS DE FATURAMENTO REALIZADO POR OPERADOR"
		
		aSort(aValOper,,, {|x,y| x[1] > y[1]} )		// Coloca em ordem Decrescente
		For nI := 1 To Len(aValOper)
			oSection4:Cell("S4_OPER"):SetValue(aValOper[nI][1] + " - " + Posicione("SU7",1,cFilSU7+aValOper[nI][1],"U7_NREDUZ"))
			oSection4:Cell("S4_VLR"):SetValue(Transform(aValOper[nI][2],  '@E 999,999,999.99'))
			oSection4:Cell("S4_ATEND"):SetValue(Transform(aValOper[nI][3],'@E 999999'))
			oSection4:PrintLine()
		Next nI                  
		oSection4:Finish()
	Endif                 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Quantidade de produtos vendidos por midia   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aProdMid) > 0 
		oSection5:Init()   
		oReport:ThinLine()
		oReport:SkipLine()
		oReport:PrintText(STR0044)//"QUANTIDADE DE PRODUTOS VENDIDOS POR MIDIA"

		aSort(aProdMid,,, {|x,y| x[1]+x[2] < y[1]+y[2]} )		// Coloca em ordem Crescente
		For nI := 1 To Len(aProdMid)
			oSection5:Cell("S5_QTDE"):SetValue("")
			oSection5:Cell("S5_PROD"):SetValue("")
			oSection5:Cell("S5_MIDIA"):SetValue("")
			If cMidia <> aProdMid[nI][1]
				cMidia := aProdMid[nI][1]
				oSection5:Cell("S5_MIDIA"):SetValue(aProdMid[nI][1] + " - " + Alltrim(Posicione("SUH",1,cFilSUH+aProdMid[nI][1],"UH_DESC")))
				oSection5:PrintLine()
				oSection5:Cell("S5_MIDIA"):SetValue("")									
			Endif	
			oSection5:Cell("S5_PROD"):SetValue(Alltrim(aProdMid[nI][2]) + " - " + Alltrim(Posicione("SB1",1,cFilSB1+aProdMid[nI][2],"B1_DESC")))
			oSection5:Cell("S5_QTDE"):SetValue(Transform(aProdMid[nI][3], '@E 999999'))
			oSection5:PrintLine()
		Next nI
		oSection5:Finish()
	Endif   

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Quantidade de produtos vendidos por Campanha³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aProdCamp) > 0
		oSection6:Init()		
		oReport:ThinLine()
		oReport:SkipLine()
		oReport:PrintText(STR0056)//"QUANTIDADE DE PRODUTOS VENDIDOS POR CAMPANHA"

		aSort(aProdCamp,,, {|x,y| x[1]+x[2] < y[1]+y[2]} )		// Coloca em ordem Crescente
		For nI := 1 To Len(aProdCamp)
			oSection6:Cell("S6_CAMP"):SetValue("")
			oSection6:Cell("S6_PROD"):SetValue("")
			oSection6:Cell("S6_QTDE"):SetValue("")
			If cCodCamp <> aProdCamp[nI][1]
				cCodCamp := aProdCamp[nI][1]
				oSection6:Cell("S6_CAMP"):SetValue(aProdCamp[nI][1] + " - " + Alltrim(Posicione("SUO",1,cFilSUO+aProdCamp[nI][1],"UO_DESC")))
				oSection6:PrintLine()
				oSection6:Cell("S6_CAMP"):SetValue("")
			Endif
			oSection6:Cell("S6_PROD"):SetValue(Alltrim(aProdCamp[nI][2]) + " - " + Alltrim(Posicione("SB1",1,cFilSB1+aProdCamp[nI][2],"B1_DESC")))
			oSection6:Cell("S6_QTDE"):SetValue(Transform(aProdCamp[nI][3],'@E 999999'))
			oSection6:PrintLine()
		Next nI
		oSection6:Finish()
	Endif
Endif
aLinhas		:= {}
aTotDia		:= {}
aValOper	:= {}
aProdMid	:= {}
aProdCamp	:= {}
aFatura		:= {}

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