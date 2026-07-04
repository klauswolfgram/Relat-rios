/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR017.CH"
#INCLUDE "TMKDEF.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR017  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 20/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Ligacoes recebidas no atendimento de Televendas            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TeleMarketing (SUA)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K ³10/07/03³710   ³Correcao do seek na Tabela SU9 indice 2     ³±±
±±³Andrea F. ³07/07/04³710   ³Inclusao de novos campos no cabecalho do    ³±±
±±³          ³        ³      ³relatorio e de totalizadores com informacoes³±±
±±³          ³        ³      ³estatisticas no final do relatorio.         ³±±
±±³Michel W. ³03/08/06³99187 ³Atualizacao de relatorio para release 4.    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function TMKR017()

Local oReport //Objeto relatorio TReport (Release 4)
Static cEntidade

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK017",.F.)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                          ³
//³ Mv_Par01           // Do Operador                             ³
//³ Mv_Par02           // Ate o Operador                          ³
//³ Mv_Par03           // A Partir de                             ³
//³ Mv_Par04           // Ate o dia                               ³
//³ Mv_Par05           // Da Midia                                ³
//³ Mv_Par06           // Ate a Midia                             ³
//³ Mv_Par07           // Campanha         - Vazio entra tudo     ³
//³ Mv_Par08           // Tipo da Entidade - SA1, SUS ou TODAS    ³
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
±±³Fun‡…o    ³ReportDef ³    Autor ³Michel W. Mosca     ³ Data ³07/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Ligacoes Recebidas  - televendas.                    ³±±
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
±±³			 |		|		 |Personalizar do relatorio TMKR017           ³±±                               
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()
Local oReport 				//Objeto relatorio TReport (Release 4)
Local oSection1             //Objeto secao 1 do relatorio (Dados do atendimentos)
Local oSection2             //Objeto secao 2 do relatorio (Itens vendidos)
Local oSection3             //Totalizador no fim do relatório
Local oSection4				//Totalizador no fim do relatório
Local oSection5				//Totalizador no fim do relatório
Local oSection6             //Totalizador no fim do relatório
Local cSUA := "SUA"     	//Alias da consulta Embedded SQL     
Local cSUB := "SUB"     	//Alias da consulta Embedded SQL	

#IFDEF TOP
	cSUA	:= GetNextAlias()						// Pega o proximo Alias Disponivel
#ENDIF

// "Ligacoes Realizadas - Televendas" # // "Este programa ira emitir uma relacao das ligacoes realizadas pelo operador no atendimento Televendas." #
// "Os dados serao emitidos conforme os parametros informados." # // "OBS: Serao considerados apenas os ORCAMENTOS e PEDIDOS."
DEFINE REPORT oReport NAME "TMKR017" TITLE STR0001 PARAMETER "TMK017" ACTION {|oReport| Tkr017PrtRpt( oReport, cSUA, cSUB )} DESCRIPTION STR0002 + STR0003 + STR0004

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0062 TABLES "SUA"    //Atendimento                      
DEFINE SECTION oSection2 OF oSection1 TITLE STR0063 TABLES "SUB" LINE BREAK //Itens do Atendimento
DEFINE SECTION oSection3 OF oReport TITLE STR0064                //Formas de Pagamento
DEFINE SECTION oSection4 OF oReport TITLE STR0036                //periodo do Atendimento
DEFINE SECTION oSection5 OF oReport TITLE STR0037  				//Total de faturamento
DEFINE SECTION oSection6 OF oReport TITLE STR0044  				//Quantidade de Produtos vendidos
   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "UA_NUM"		OF oSection1 ALIAS "SUA"	//ATENDIMENTO	
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||IIf((cSUA)->UA_PROSPEC,STR0032,STR0033)} TITLE STR0010 SIZE 40 	//"Entidade"
DEFINE CELL NAME "UA_TABELA"		OF oSection1 ALIAS "SUA" BLOCK {||(cSUA)->UA_TABELA + " - " + Posicione("DA0",1,xFilial("DA0")+(cSUA)->UA_TABELA,"DA0_DESCRI")} TITLE STR0017 SIZE 25	//"Tabela de Preco"							 
DEFINE CELL NAME "UA_EMISSAO"		OF oSection1 ALIAS "SUA" 	//"Data"				
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||(cSUA)->UA_CLIENTE + " / " + (cSUA)->UA_LOJA + " - " +TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,1,,.T.)} TITLE STR0011 SIZE 50	//"Razao Social"							
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK {||(cSUA)->UA_CONDPG  + " - " + Posicione("SE4",1,xFilial("SE4")+(cSUA)->UA_CONDPG,"E4_DESCRI")} TITLE STR0038 SIZE 25 	//"Cond. Pagamento"		
DEFINE CELL NAME "UA_OPER"		OF oSection1 ALIAS "SUA" 	//"Operacao"
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,2,,.T.)} TITLE STR0013
DEFINE CELL NAME "UA_TPFRETE"		OF oSection1 ALIAS "SUA"				
DEFINE CELL NAME "UA_TMK"		OF oSection1 ALIAS "SUA"				
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,10,,.T.)} TITLE STR0019 	//"Bairro"			     
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||(cSUA)->UA_TRANSP + " - " + ;
		Posicione("SA4",1,xFilial("SA4")+(cSUA)->UA_TRANSP,"A4_NREDUZ")} TITLE STR0045 SIZE 25								
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||(cSUA)->UA_OPERADO + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUA)->UA_OPERADO,"U7_NREDUZ"),"U7_NREDUZ",/*cSource*/,.T.)} TITLE STR0018 SIZE 25		//"Operador"			
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,3,,.T.) + " - " +; 	// "Cidade"
		TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,4,,.T.)} TITLE STR0021 	 //Estado								 
DEFINE CELL NAME "UA_ENDENT"		OF oSection1 ALIAS "SUA"	//"End. Entrega"				
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||(cSUA)->UA_VEND + " - " + FATPDObfuscate(Posicione("SA3",1,xFilial("SA3")+(cSUA)->UA_VEND,"A3_NREDUZ"),"A3_NREDUZ",/*cSource*/,.T.)} TITLE STR0020 SIZE 25  //"Vendedor"				
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||ALLTRIM(TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,9,,.T.)) + " - " + ;//DDD
		TkEntidade(cEntidade,(cSUA)->UA_CLIENTE+(cSUA)->UA_LOJA,6,,.T.)} TITLE STR0047  SIZE 25								
DEFINE CELL NAME "UA_BAIRROE"		OF oSection1 ALIAS "SUA"	//"Bairro Entrega"				
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||(cSUA)->UA_MIDIA + " - " +;
		Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")} TITLE STR0022  SIZE 25 // "Midia"		 							 
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||(cSUA)->UA_CODCONT + " - " + TkDadosContato((cSUA)->UA_CODCONT,0,.T.)} TITLE STR0012	 SIZE 25 //"Contato"			
DEFINE CELL NAME "UA_MUNE"		OF oSection1 ALIAS "SUA" 	//"Cidade Entrega"				
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||(cSUA)->UA_CODCAMP + " - " + ; // "Descricao da Campanha"
		Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")} TITLE STR0024  SIZE 25								
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||Alltrim(TkDadosContato((cSUA)->UA_CODCONT,8,.T.))+ " - " + ; //DDD
		TkDadosContato((cSUA)->UA_CODCONT,4)} TITLE STR0023 SIZE 25								
DEFINE CELL NAME "UA_ESTE"		OF oSection1 ALIAS "SUA" SIZE 25  	//"Estado Entrega"				
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||(cSUA)->UA_CODLIG + " - " +; //"Ocorrencia"
		Posicione("SU9",2,xFilial("SU9")+(cSUA)->UA_CODLIG,"U9_DESC")} TITLE STR0026   SIZE 25								
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||TkDadosContato((cSUA)->UA_CODCONT,10,.T.)} TITLE STR0025 SIZE 25	//"Descricao do Email"			
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||DTOC((cSUA)->UA_PROXLIG) + " - " +  (cSUA)->UA_HRPEND + " - " + ;
		(cDia:= Tk_DiaSemana((cSUA)->UA_PROXLIG,Nil,Nil))} TITLE STR0028 SIZE 25									
DEFINE CELL NAME ""		OF oSection1 ALIAS "SUA" BLOCK{||MSMM((cSUA)->UA_CODOBS)} TITLE STR0030 SIZE 500				

DEFINE CELL NAME "UB_ITEM"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_PRODUTO"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME ""					OF oSection2 ALIAS "SUB" BLOCK{||Posicione("SB1",1,xFilial("SB1")+SUB->UB_PRODUTO,"B1_DESC")} SIZE 25 TITLE STR0066 
DEFINE CELL NAME "UB_SITPROD"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_QUANT"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_VRUNIT"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_VLRITEM"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_DESC"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_VALDESC"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_ACRE"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_VALACRE"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_TES"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_CF"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_PRCTAB"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_BASEICM"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_LOCAL"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_UM"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_DTENTRE"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_LOTE"			OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_SUBLOTE"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_DTVALID"		OF oSection2 ALIAS "SUB"



DEFINE CELL NAME "S3_DATA"			OF oSection3 TITLE STR0008 SIZE 15
DEFINE CELL NAME "S3_ORC"			OF oSection3 TITLE STR0057 SIZE 8
DEFINE CELL NAME "S3_VLORC"			OF oSection3 TITLE STR0058 SIZE 8
DEFINE CELL NAME "S3_FAT"			OF oSection3 TITLE STR0059 SIZE 8
DEFINE CELL NAME "S3_VRFAT"			OF oSection3 TITLE STR0060 SIZE 8      

DEFINE CELL NAME "S4_OPER"			OF oSection4 TITLE STR0018 SIZE 25
DEFINE CELL NAME "S4_VLR"			OF oSection4 TITLE STR0061 SIZE 15
DEFINE CELL NAME "S4_ATEND"			OF oSection4 TITLE STR0062 SIZE 15

DEFINE CELL NAME "S5_MIDIA"			OF oSection5 TITLE STR0022 SIZE 40
DEFINE CELL NAME "S5_PROD"			OF oSection5 TITLE STR0039 SIZE 40
DEFINE CELL NAME "S5_QTDE"			OF oSection5 TITLE STR0055 SIZE 15 //QUANTIDADE

DEFINE CELL NAME "S6_CAMP"			OF oSection6 TITLE STR0024 SIZE 40
DEFINE CELL NAME "S6_PROD"			OF oSection6 TITLE STR0039 SIZE 40
DEFINE CELL NAME "S6_QTDE"			OF oSection6 TITLE STR0055 SIZE 15 //QUANTIDADE

Return(oReport) 


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr017PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³07/08/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de           ³±±
±±³          ³Ligacoes Recebidas  - Televendas.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr017PrtRept(ExpO1,ExpC2,ExpC3)                           ³±±
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
Static Function Tkr017PrtRpt(oReport, cSUA, cSUB)
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
Local cCodSUA		:= ""			// Controla a quebra do cabecalho do atendimento
Local nI			:= 0			// Controle
Local nPos			:= 0			// Ponteiro da pesquisa no array
Local aLinhas		:= {}			// Linha do campo memo
Local aTotDia		:= {}			// Total de atendimentos diarios
Local aValOper		:= {}			// Valor de faturamento por operador
Local aProdMid		:= {}			// Produtos vendidos por midia
Local aProdCamp		:= {}			// Produtos vendidos por campanha
Local cMidia  		:= ""			// Controle de quebra de midia 
Local cCodCamp		:= ""			// Controle de quebra de Campanha
Local nTotFat		:= 0			// Numero de Faturamentos por dia
Local nTotOrc		:= 0			// Numero de Orcamentos por dia
Local nValFat		:= 0			// Valor de Faturamento por dia
Local nValOrc		:= 0			// Valor de Orcamentos por dia
Local cFormPag      := ""
Local aFatura		:= {} 
Local nCol			:= 0   
Local cPgLine		:= ""			//Var. auxiliar para impressao das formas de pagamento

#IFDEF TOP 


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("TMK016")      
	
	cQuery :=	"%      	SUA.UA_FILIAL = '" + xFilial("SUA") + "' AND " +;
				" 		SUA.UA_EMISSAO BETWEEN '" + DtoS(Mv_Par03) + "' AND '" + DtoS(Mv_Par04) + "' AND" +;
				" 		SUA.UA_OPERADO BETWEEN '" + Mv_Par01 + "' AND '" + Mv_Par02 + "' AND" +;
				" 		SUA.UA_MIDIA BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND" +;
				" 		SUA.UA_CANC = '' AND" +;
				" 		SUA.UA_TMK = '1' AND " +;	// Receptivo
				" 		(SUA.UA_OPER = '1' OR SUA.UA_OPER = '2') AND "	// Orcamento - Faturamento
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Seleciono somente a campanha informada nos parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(Mv_Par07)
		cQuery +=	" 	SUA.UA_CODCAMP = '" + Mv_Par07 + "' AND"
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Seleciono somente o tipo de entidade dos parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Mv_Par08 <> 3		// Ambos
		If Mv_Par08 == 1	// Clientes
			cQuery +=	" 	SUA.UA_PROSPEC = 'F' AND"
		Else				// Prospects
			cQuery +=	" 	SUA.UA_PROSPEC = 'T' AND"
		Endif
	Endif
	
	cQuery +=	"	SUA.D_E_L_E_T_ = ' ' AND"
	
	cQuery +=	"	SUB.UB_FILIAL = '" + xFilial("SUB") + "' AND" +;
				"	SUB.UB_NUM = SUA.UA_NUM AND" +;
				"	SUB.D_E_L_E_T_ = ' ' AND" +;
				"	SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND" +;
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

                                  

#ELSE 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("TMK016")       

	DbSelectArea("SUA")
	DbSetOrder(4)
	DbSeek(xFilial("SUA") + DtoS(Mv_Par03), .T.)
	oReport:SetMeter(RecCount())
	                                    
	cFiltro := "UA_FILIAL = '" + xFilial(cSUA) + "' "

	
	oSection1:SetFilter( cFiltro ) 





#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quebra a linha, caso existam muitas colunas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:SetLineBreak()

While	(!Eof())							.AND.;
		(cSUA)->UA_FILIAL == xFilial("SUA") .AND.;
		(cSUA)->UA_EMISSAO >=	Mv_Par03	 .AND.;
		(cSUA)->UA_EMISSAO <=	Mv_Par04
	
	oReport:IncMeter()
	
	If oReport:Cancel()
		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Avalia os parametros para DBF³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	#IFNDEF TOP
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Seleciona somente os atendimentos Receptivos³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (cSUA)->UA_TMK <> "1"
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valida o intervalo de operadores informado nos parametros³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (cSUA)->UA_OPERADO < Mv_Par01 .OR. (cSUA)->UA_OPERADO > Mv_Par02
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valida o intervalo de midias informado nos parametros³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (cSUA)->UA_MIDIA < Mv_Par05 .OR. (cSUA)->UA_MIDIA > Mv_Par06
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Seleciono somente a campanha informada nos parametros³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par07) .AND. (cSUA)->UA_CODCAMP <> Mv_Par07
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Seleciono somente o tipo de entidade dos parametros³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do Case
			// Se o parametro = cliente e atendimento = prospect  <<pula>>
			Case Mv_Par08 == 1 .AND. (cSUA)->UA_PROSPEC
				DbSkip()
				Loop
			// Se o parametro = prospect e atendimento <> prospect  <<pula>>
			Case Mv_Par08 == 2 .AND. !(cSUA)->UA_PROSPEC
				DbSkip()
				Loop
		EndCase

		If (cSUA)->UA_CANC == "S"
			DbSkip()
			Loop
		Endif
		
		If (cSUA)->UA_OPER == "3"	// Atendimento
			DbSkip()
			Loop
		Endif
		
	#ENDIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta uma string com as formas de pagamento utilizada na venda³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("SL4")
	DbSetOrder(1)
	cFormPag := ""
	If DbSeek(xFilial("SL4") + (cSUA)->UA_NUM + "SIGATMK")
		While	(!Eof())							.AND.;
				SL4->L4_FILIAL 	== xFilial("SL4")	.AND.;
				SL4->L4_NUM 	== (cSUA)->UA_NUM	.AND.;
				Trim(SL4->L4_ORIGEM) == "SIGATMK"
				
			If !(Trim(SL4->L4_FORMA) $ cFormPag)
				cFormPag := cFormPag + Trim(SL4->L4_FORMA) + "/"
			Endif
			AaDd(aFatura, {SL4->L4_DATA, SL4->L4_VALOR, SL4->L4_FORMA} )
			DbSkip()
			
		End
		cFormPag := SubStr(cFormPag,1,Len(cFormPag)-1)
	Endif


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Quebra de atendimento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cSUA)->UA_NUM <> cCodSUA
		cCodSUA := (cSUA)->UA_NUM
		
		If (cSUA)->UA_PROSPEC
			cEntidade:="SUS"
		Else
			cEntidade:="SA1"
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
			nTotFat:=1
			nValFat:=(cSUA)->UA_VLRLIQ
			nValOrc:=0
		ElseIf 	 VAL((cSUA)->UA_OPER) == ORCAMENTO
			nTotOrc:=1
			nValOrc:=(cSUA)->UA_VLRLIQ
			nValFat:=0
		Endif
        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza os atendimentos por data com os dados de orcamento e faturamento.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aTotDia) > 0
			nPos := aScan(aTotDia, {|x| x[1]==(cSUA)->UA_EMISSAO} )
			If nPos == 0
				aAdd(aTotDia,{(cSUA)->UA_EMISSAO, nTotOrc,nValOrc,nTotFat,nValFat,1,nValOrc+nValFat})
			Else
				aTotDia[nPos][2]+=nTotOrc
				aTotDia[nPos][3]+=nValOrc
				aTotDia[nPos][4]+=nTotFat
				aTotDia[nPos][5]+=nValFat
				aTotDia[nPos][6]++
				aTotDia[nPos][7]+=nValOrc+nValFat
			Endif
		Else
			aAdd(aTotDia,{(cSUA)->UA_EMISSAO, nTotOrc,nValOrc,nTotFat,nValFat,1,nValOrc+nValFat})		
		Endif
		nTotOrc	:=0
		nValOrc	:=0
		nTotFat	:=0
		nValFat	:=0
	  
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valor total em dinheiro dos faturamentos realizados por operador.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If VAL((cSUA)->UA_OPER) == FATURAMENTO
			nPos := aScan(aValOper, {|x| x[1]==(cSUA)->UA_OPERADO} )
			If nPos == 0
				aAdd(aValOper, {(cSUA)->UA_OPERADO, (cSUA)->UA_VLRLIQ , 1 })
			Else
				aValOper[nPos][2]+=(cSUA)->UA_VLRLIQ
				aValOper[nPos][3]+=1
			Endif
		Endif
		
		oSection2:Init()
		oSection2:SetLineBreak()
								
		DbSelectArea(cSUB)
		DbSetOrder(1)
		DbSeek(xFilial(cSUB) + (cSUA)->UA_NUM)
	
		While	(!Eof())							.AND.;
				(cSUB)->UB_FILIAL	==	xFilial("SUB")	.AND.;
				(cSUB)->UB_NUM		==	(cSUA)->UA_NUM
			
			oSection2:PrintLine()			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Quantidade total de cada produto vendido dentro de cada midia.      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If VAL((cSUA)->UA_OPER) == FATURAMENTO
				If !Empty((cSUA)->UA_MIDIA)
					nPos := aScan(aProdMid, {|x,y| x[1]==(cSUA)->UA_MIDIA .AND. x[2]==(cSUB)->UB_PRODUTO } )
					If nPos == 0
						aAdd(aProdMid, {(cSUA)->UA_MIDIA,(cSUB)->UB_PRODUTO,(cSUB)->UB_QUANT} )
					Else
						aProdMid[nPos][3]+=(cSUB)->UB_QUANT
					Endif
				Endif	
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Quantidade total de cada produto vendido dentro de cada campanha.   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If VAL((cSUA)->UA_OPER) == FATURAMENTO
				If !Empty((cSUA)->UA_CODCAMP)
					nPos := aScan(aProdCamp, {|x,y| x[1]==(cSUA)->UA_CODCAMP .AND. x[2]==(cSUB)->UB_PRODUTO })
					If nPos == 0
						aAdd(aProdCamp, {(cSUA)->UA_CODCAMP, (cSUB)->UB_PRODUTO, (cSUB)->UB_QUANT})
					Else
						aProdCamp[nPos][3]+=(cSUB)->UB_QUANT
					Endif    
				Endif	
			Endif
			
			//DbSelectArea("SUB")
			DbSelectArea(cSUB)
			
			DbSkip()
		End
		oSection2:Finish()
		

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime as formas de pagamento.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If len(aFatura) > 0
			nCol := 0
			
			oReport:SkipLine()
	
			
			//TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			//@ nLi,000 PSay PadR(STR0051,Limite) //"| Vencto   Forma          Valor || Vencto   Forma          Valor || Vencto   Forma          Valor || Vencto   Forma          Valor |"
			//oReport:ThinLine()
			oReport:PrintText(STR0051)
			oReport:ThinLine()
					
					          
			oReport:SkipLine()
			cPgLine := ""
			For nI := 1 to len(aFatura)			
				If nCol == 0
					//@ nLi,nCol PSay "| " + DtoC(aFatura[nI][1]) + " " + SubStr(aFatura[nI][3],1,9) + " " + Transform(aFatura[nI][2], "@E 999,999.99")
					cPgLine := "| " + DtoC(aFatura[nI][1]) + " " + SubStr(aFatura[nI][3],1,9) + " " + Transform(aFatura[nI][2], "@E 999,999.99")
					nCol+=32
				Else
					//@ nLi,nCol PSay "|| " + DtoC(aFatura[nI][1]) + " " + SubStr(aFatura[nI][3],1,9) + " " + Transform(aFatura[nI][2], "@E 999,999.99")
					cPgLine += " || " + DtoC(aFatura[nI][1]) + " " + SubStr(aFatura[nI][3],1,9) + " " + Transform(aFatura[nI][2], "@E 999,999.99")
					nCol+=33
				Endif
				If nCol == 131
					//@ nLi,nCol PSay "|"
					cPgLine += "|"
					//TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					oReport:PrintText(cPgLine)
					cPgLine := ""
					oReport:SkipLine()				
					nCol := 0
				Endif
			Next nI
			
			If nCol == 32
				//@ nLi,nCol		PSay "||"
				cPgLine += " ||"
				//@ nLi,nCol+33	PSay "||"
				cPgLine += Space(30) + " ||"
				//@ nLi,nCol+66	PSay "||"
				cPgLine += Space(30) + " ||"
				//@ nLi,131		PSay "|"
				cPgLine += Space(30) + " |"
				//TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			ElseIf nCol == 65
				//@ nLi,nCol		PSay "||"
				cPgLine += " ||"
				//@ nLi,nCol+33	PSay "||"
				cPgLine += Space(30) + " ||"
				//@ nLi,131		PSay "|"
				cPgLine += Space(30) + " |"
				//TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			ElseIf nCol == 98
				//@ nLi,nCol		PSay "||"
				cPgLine += " ||"
				//@ nLi,131		PSay "|"   
				cPgLine += Space(30) + " |"
				//TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			Endif
		
			//@ nLi,000 PSay __PrtThinLine()
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
	DbSelectArea(cSUA)
	DbSkip()  
	
End 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Totais gerais impressos na ultima pagina do relatorio. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Total Diario de Atendimentos com valores de Orcamentos e Faturamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aTotDia) > 0

	oReport:SkipLine()
	oReport:PrintText(PadR(STR0036 + DtoC(Mv_Par03) + STR0043 + DtoC(Mv_Par04),80))//"Total de atendimentos realizados no periodo de " //" a "
	oReport:SkipLine()	


		
	aSort(aTotDia,,, {|x,y| x[1] < y[1]} )		// Coloca em ordem Crescente

	oSection3:Init()
	For nI := 1 To Len(aTotDia)
		oSection3:Cell("S3_DATA"):SetValue(Dtoc(aTotDia[nI][1]))	// Data
		oSection3:Cell("S3_ORC"):SetValue(Transform(aTotDia[nI][2],'@E 999999'))	// Numero de Orcamentos
		oSection3:Cell("S3_VLORC"):SetValue(Transform(aTotDia[nI][3],'@E 999,999,999.99'))// Valor em Reais dos Orcamentos 
		oSection3:Cell("S3_FAT"):SetValue(Transform(aTotDia[nI][4],'@E 999999'))	// Numero de Faturamento
		oSection3:Cell("S3_VRFAT"):SetValue(Transform(aTotDia[nI][5], '@E 999,999,999.99'))	// Valor em Reais dos Faturamento 		
		oSection3:PrintLine()
		nTotOrc+=aTotDia[nI][2]
		nValOrc+=aTotDia[nI][3]
		nTotFat+=aTotDia[nI][4]
		nValFat+=aTotDia[nI][5]
	Next nI

	oSection3:Cell("S3_DATA"):SetValue(STR0053)		//"Total Geral"
	oSection3:Cell("S3_ORC"):SetValue(Transform(nTotOrc,'@E 999999'))	// Numero de Orcamentos
	oSection3:Cell("S3_VLORC"):SetValue(Transform(nValOrc,'@E 999,999,999.99'))// Valor em Reais dos Orcamentos 
	oSection3:Cell("S3_FAT"):SetValue(Transform(nTotFat,'@E 999999'))	// Numero de Faturamento
	oSection3:Cell("S3_VRFAT"):SetValue(Transform(nValFat,'@E 999,999,999.99'))	// Valor em Reais dos Faturamento 		
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
		//oReport:SkipLine()		
		
		aSort(aValOper,,, {|x,y| x[1] > y[1]} )		// Coloca em ordem Decrescente
		For nI := 1 To Len(aValOper)


			oSection4:Cell("S4_OPER"):SetValue(aValOper[nI][1] + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+aValOper[nI][1],"U7_NREDUZ"),"U7_NREDUZ",,.T.))
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
				oSection5:Cell("S5_MIDIA"):SetValue(aProdMid[nI][1] + " - " + Alltrim(Posicione("SUH",1,xFilial("SUH")+aProdMid[nI][1],"UH_DESC")))
				oSection5:PrintLine()
				oSection5:Cell("S5_MIDIA"):SetValue("")									
			Endif	
			oSection5:Cell("S5_PROD"):SetValue(Alltrim(aProdMid[nI][2]) + " - " + Alltrim(Posicione("SB1",1,xFilial("SB1")+aProdMid[nI][2],"B1_DESC")))
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
				oSection6:Cell("S6_CAMP"):SetValue(aProdCamp[nI][1] + " - " + Alltrim(Posicione("SUO",1,xFilial("SUO")+aProdCamp[nI][1],"UO_DESC")))
				oSection6:PrintLine()				
				oSection6:Cell("S6_CAMP"):SetValue("")
			Endif
			oSection6:Cell("S6_PROD"):SetValue(Alltrim(aProdCamp[nI][2]) + " - " + Alltrim(Posicione("SB1",1,xFilial("SB1")+aProdCamp[nI][2],"B1_DESC")))
			oSection6:Cell("S6_QTDE"):SetValue(Transform(aProdCamp[nI][3],'@E 999999'))
			oSection6:PrintLine()
		Next nI                  
		oSection6:Finish()
	Endif	
Endif       

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKR017VerifPosºAutor  ³CRM - VENDAS        º Data ³  04/03/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para controlar a coluna do campo para ver se pula linha.  º±±
±±º          |OBS: Passar o parâmetro 1 (nLi) como referência.				   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TKR017VerifPos(nLi, cCampo)
	Local nLocalPCol	:= 000							// Controla a coluna da impressão do relatório para saber se precisa pular linha
	nLocalPCol := PCol()+1
	If(nLocalPCol+(TamSX3(cCampo)[1]) > Limite)
		nLi += 1
		nLocalPCol := 000
	End IF
return nLocalPCol

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