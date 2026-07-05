/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR005.CH"
#INCLUDE "TMKDEF.CH"  
#INCLUDE  "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR005  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 20/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Analise das vendas por periodo e vendedor.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TeleVendas (SUA)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K.³14/07/03³      ³Revisao da impressao das descricoes e dos   ³±±
±±³          ³        ³      ³totais                                      ³±±
±±³Thiago G  ³16/08/04³8.11  ³Inclusao do cabecalho padrao e alteracao das³±±
±±³          ³        ³      ³totalizacoes.                               ³±±
±±³Michel W. ³31/07/06³99180 ³Atualizacao de relatorios relase 4.         ³±±
±±³Michel W. ³11/10/06³110579³Adicionado titulos na secoes do relatorio.  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function TMKR005()
Local oReport //Objeto relatorio TReport (Release 4)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK005",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                          ³
//³ Mv_Par01           // Do Vendedor                             ³
//³ Mv_Par02           // Ate o Vendedor                          ³
//³ Mv_Par03           // A Partir de                             ³
//³ Mv_Par04           // Ate a Data                              ³
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
±±³Fun‡…o    ³ReportDef ³ Autor ³Michel W. Mosca     ³ Data ³27/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Analise de Vendas no release 4.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                             ³±±
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
Local oSection1             //Objeto secao 1 do relatorio (Apresenta total de atendimentos no periodo)
Local oSection2             //Objeto secao 2 do relatorio (Apresenta divs. tempos de atendimentos)
Local oSection3				//Objeto secao 3 do relatorio (Apresenta divs. tempos de atendimentos)
Local oSection4             //Objeto secao 4 do relatorio (Totaliza os tempos de atendimento)
Local oSection5             //Objeto secao 5 do relatorio (Valor de faturamento X Media de Atendimento)
Local oSection6             //Objeto secao 6 do relatorio (Valor de faturamento por vendedor)
Local oSection7             //Objeto secao 7 do relatorio (Valor negociado e numeros de atendimento por operacao)
Local oSection8             //Objeto secao 8 do relatorio (Numeros de atendimentos, orcamentos e faturamento por vendedor)
Local oSection9             //Objeto secao 9 do relatorio (Quantidade e valor por produto faturado)
Local oSection10            //Objeto secao 10 do relatorio (Numero de atendimentos por midia)
Local oSection11            //Objeto secao 11 do relatorio (Quantidade e valor de produtos faturados por midia)
Local oSection12            //Objeto secao 12 do relatorio (Numero de atendimentos por campanha)
Local oSection13            //Objeto secao 13 do relatorio (Quantidade e valor de produtos faturados por campanha)
Local oSection14            //Objeto secao 14 do relatorio (Numeros de atendimentos, orcamentos e faturamento por vendedor)
Local oSection15            //Objeto secao 15 do relatorio (Numeros de atendimentos, orcamentos e faturamento por midia)
Local oSection16            //Objeto secao 16 do relatorio (Numeros de atendimentos, orcamentos e faturamento por campanha)
Local cAlias1 := "SUA"     //Alias da consulta Embedded SQL

#IFDEF TOP
	cAlias1	:= GetNextAlias()						// Pega o proximo Alias Disponivel
#ENDIF



// "Analise das vendas por periodo e vendedor" # // "Este programa ira emitir um relacao de analise da vendas"
// "realizadas pelos vendedores no atendimento Televendas" # // "conforme os parametros previamente definidos"
DEFINE REPORT oReport NAME "TMKR005" TITLE STR0001 PARAMETER "TMK005" ACTION {|oReport| Tkr005PrtRpt( oReport, cAlias1 )} DESCRIPTION STR0002 + STR0003 + STR0004

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as secoes do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0051 	//Total de Atendimentos do Periodo
DEFINE SECTION oSection2 OF oReport TITLE STR0052   //Totalização dos Tempos de Atendimento (T.M.A)
DEFINE SECTION oSection3 OF oReport TITLE STR0052   //Totalização dos Tempos de Atendimento (T.M.A) 2 - "Quebrar linha da seção 2"
DEFINE SECTION oSection4 OF oReport TITLE STR0053 	//Valor de Orcamento X Media de Atendimento
DEFINE SECTION oSection5 OF oReport TITLE STR0054 	//Valor de Faturamento X Media de Atendimento
DEFINE SECTION oSection6 OF oReport TITLE STR0055   //Valor de Faturamento por Vendedor
DEFINE SECTION oSection7 OF oReport TITLE STR0056   //Valor Negociado e Numeros de Atendimento por Operacao
DEFINE SECTION oSection8 OF oReport TITLE STR0057   //Numeros de Atendimentos, Orcamentos e Faturamentos por Vendedor
DEFINE SECTION oSection9 OF oReport TITLE STR0058   //Quantidade e Valor por Produto Faturado
DEFINE SECTION oSection10 OF oReport TITLE STR0059   //Total de atendimentos por Midia
DEFINE SECTION oSection11 OF oReport TITLE STR0060  //Quantidade e Valor de Produtos Faturados por Midia
DEFINE SECTION oSection12 OF oReport TITLE STR0061  //Total de Atendimentos por Campanha
DEFINE SECTION oSection13 OF oReport TITLE STR0066  //Quantidade Valor de Produtos Faturados por Campanha
DEFINE SECTION oSection14 OF oReport TITLE STR0067  //Vendedor - Atendimentos, Orcamentos e Faturamento
DEFINE SECTION oSection15 OF oReport TITLE STR0068  //Midia - Atendimentos, Orcamentos e Faturamento
DEFINE SECTION oSection16 OF oReport TITLE STR0069  //Campanha - Atendimentos, Orcamentos e Faturamento

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ               

// "Total de atendimentos computados para o periodo de ",  " a "
DEFINE CELL NAME "S1_TOT" 			OF oSection1 TITLE STR0011 + DtoC(Mv_Par03) + STR0012 + DtoC(Mv_Par04) SIZE 10
			    
DEFINE CELL NAME "S2_TMAOPAT" 		OF oSection2 TITLE STR0023 					
DEFINE CELL NAME "S2_TMAOPATVD" 	OF oSection2 TITLE STR0024					
DEFINE CELL NAME "S2_TMAOPOC"  		OF oSection2 TITLE STR0025					
DEFINE CELL NAME "S2_TMAOPOCVD" 	OF oSection2 TITLE STR0026	
// Quebrar aqui				
DEFINE CELL NAME "S2_TMAOPFAT" 		OF oSection3 TITLE STR0027					
DEFINE CELL NAME "S2_TMAOPFATVD" 	OF oSection3 TITLE STR0028 					
DEFINE CELL NAME "S2_TMAGER" 		OF oSection3 TITLE STR0029 					
DEFINE CELL NAME "S2_TMAGERVD" 		OF oSection3 TITLE STR0030					

DEFINE CELL NAME "S3_VLORCAT" 		OF oSection4 TITLE STR0031 
	
DEFINE CELL NAME "S4_VLFATATMD" 	OF oSection5 TITLE STR0032 			

DEFINE CELL NAME "S5_VENDOR" 		OF oSection6 TITLE STR0035 SIZE 40
DEFINE CELL NAME "S5_ORCAM"    		OF oSection6 TITLE STR0036 SIZE 20
DEFINE CELL NAME "S5_DESVIO"  		OF oSection6 TITLE STR0037 SIZE 20
DEFINE CELL NAME "S5_FAT" 	 		OF oSection6 TITLE STR0038 SIZE 20
DEFINE CELL NAME "S5_DESVIO2" 		OF oSection6 TITLE STR0037 SIZE 20

DEFINE CELL NAME "S6_OPER" 			OF oSection7 TITLE STR0039 SIZE 40                                                           
DEFINE CELL NAME "S6_ATEND" 		OF oSection7 TITLE STR0040 SIZE 20                                                        
DEFINE CELL NAME "S6_VALNEG" 		OF oSection7 TITLE STR0041 SIZE 20
                                       
DEFINE CELL NAME "S7_VENDOR" 		OF oSection8 TITLE STR0035 SIZE 40                                                           
DEFINE CELL NAME "S7_ATEN" 			OF oSection8 TITLE STR0040 SIZE 10                                                           
DEFINE CELL NAME "S7_ORCAM" 		OF oSection8 TITLE STR0036 SIZE 10                                                           
DEFINE CELL NAME "S7_VALOR" 		OF oSection8 TITLE STR0042 SIZE 15                                                           
DEFINE CELL NAME "S7_FAT" 			OF oSection8 TITLE STR0043 SIZE 10                                                           
DEFINE CELL NAME "S7_VAL" 			OF oSection8 TITLE STR0044 SIZE 15                                                           
                        
DEFINE CELL NAME "S8_PRODFAT" 		OF oSection9 TITLE STR0045 SIZE 40                                                           
DEFINE CELL NAME "S8_QTDE" 			OF oSection9 TITLE STR0046 SIZE 15                                                           
DEFINE CELL NAME "S8_PERCENT" 		OF oSection9 TITLE "%" SIZE 15   
DEFINE CELL NAME "S8_VALOR" 		OF oSection9 TITLE STR0042 SIZE 15                                                           

DEFINE CELL NAME "S9_MIDIA" 		OF oSection10 TITLE STR0047 SIZE 15
DEFINE CELL NAME "S9_ATEND" 		OF oSection10 TITLE STR0040 SIZE 15
DEFINE CELL NAME "S9_PERCENT" 		OF oSection10 TITLE "%" SIZE 15

DEFINE CELL NAME "S10_PRODUTO" 		OF oSection11 TITLE STR0045 SIZE 40
DEFINE CELL NAME "S10_MIDIA" 		OF oSection11 TITLE STR0047 SIZE 15
DEFINE CELL NAME "S10_QTDE" 		OF oSection11 TITLE STR0046 SIZE 15
DEFINE CELL NAME "S10_FAT" 			OF oSection11 TITLE STR0042 SIZE 15
                                                                               
DEFINE CELL NAME "S11_CAMP" 		OF oSection12 TITLE STR0048 SIZE 40
DEFINE CELL NAME "S11_TOTAT" 		OF oSection12 TITLE STR0040 SIZE 15
DEFINE CELL NAME "S11_PERCENT" 		OF oSection12 TITLE "%" 	SIZE 15

DEFINE CELL NAME "S12_PROD" 		OF oSection13 TITLE STR0045 SIZE 40
DEFINE CELL NAME "S12_CAMP" 		OF oSection13 TITLE STR0048 SIZE 15
DEFINE CELL NAME "S12_QTDE" 		OF oSection13 TITLE STR0046 SIZE 15
DEFINE CELL NAME "S12_VLR" 			OF oSection13 TITLE STR0042 SIZE 15 

DEFINE CELL NAME "S13_DATA" 		OF oSection14 TITLE STR0049 SIZE 10 
DEFINE CELL NAME "S13_VENDOR" 		OF oSection14 TITLE STR0035 SIZE 40 
DEFINE CELL NAME "S13_TOTAT" 		OF oSection14 TITLE STR0040 SIZE 15 
DEFINE CELL NAME "S13_TOTORC" 		OF oSection14 TITLE STR0036 SIZE 15 
DEFINE CELL NAME "S13_VLORC" 		OF oSection14 TITLE STR0042 SIZE 15 
DEFINE CELL NAME "S13_TOTFAT" 		OF oSection14 TITLE STR0043 SIZE 15 
DEFINE CELL NAME "S13_VLFAT" 		OF oSection14 TITLE STR0042 SIZE 15 

DEFINE CELL NAME "S14_DATA" 		OF oSection15 TITLE STR0049 SIZE 10 
DEFINE CELL NAME "S14_MIDIA" 		OF oSection15 TITLE STR0047 SIZE 40 
DEFINE CELL NAME "S14_TOTAT" 		OF oSection15 TITLE STR0040 SIZE 15 
DEFINE CELL NAME "S14_TOTORC" 		OF oSection15 TITLE STR0036 SIZE 15 
DEFINE CELL NAME "S14_VLORC" 		OF oSection15 TITLE STR0042 SIZE 15 
DEFINE CELL NAME "S14_TOTFAT" 		OF oSection15 TITLE STR0043 SIZE 15 
DEFINE CELL NAME "S14_VLFAT" 		OF oSection15 TITLE STR0042 SIZE 15 

DEFINE CELL NAME "S15_DATA" 		OF oSection16 TITLE STR0049 SIZE 10 
DEFINE CELL NAME "S15_CAMPANHA" 	OF oSection16 TITLE STR0048 SIZE 40 
DEFINE CELL NAME "S15_TOTAT" 		OF oSection16 TITLE STR0040 SIZE 15 
DEFINE CELL NAME "S15_TOTORC" 		OF oSection16 TITLE STR0036 SIZE 15 
DEFINE CELL NAME "S15_VLORC" 		OF oSection16 TITLE STR0042 SIZE 15 
DEFINE CELL NAME "S15_TOTFAT" 		OF oSection16 TITLE STR0043 SIZE 15 
DEFINE CELL NAME "S15_VLFAT" 		OF oSection16 TITLE STR0042 SIZE 15 

Return(oReport)                

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr005PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³27/07/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de           ³±±
±±³          ³Analise de vendas no release 4.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr005PrtRept(ExpO1,ExpC2)                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC1 = alias da query atual                               ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Fernando  ³16/10/06³8.11  ³- BOPS 109582 - Alteracao na formatacao da  ³±±
±±³          ³        ³      ³picture de porcetagem                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr005PrtRpt(oReport, cSUA)
Local oSection1 	:= oReport:Section(1)	           //Objeto secao 1 do relatorio (Apresenta total de atendimentos no periodo)
Local oSection2  	:= oReport:Section(2)	           //Objeto secao 2 do relatorio (Apresenta divs. tempos de atendimentos)
Local oSection3     := oReport:Section(3)			   //Objeto secao 3 do relatorio (Apresenta divs. tempos de atendimentos) - Parte 2
Local oSection4  	:= oReport:Section(4)	           //Objeto secao 4 do relatorio (Totaliza os tempos de atendimento)
Local oSection5 	:= oReport:Section(5)	           //Objeto secao 5 do relatorio (Valor de faturamento X Media de Atendimento)
Local oSection6 	:= oReport:Section(6)	           //Objeto secao 6 do relatorio (Valor de faturamento por vendedor)
Local oSection7  	:= oReport:Section(7)	           //Objeto secao 7 do relatorio (Valor negociado e numeros de atendimento por operacao)
Local oSection8  	:= oReport:Section(8)	           //Objeto secao 8 do relatorio (Numeros de atendimentos, orcamentos e faturamento por vendedor)
Local oSection9  	:= oReport:Section(9)	           //Objeto secao 9 do relatorio (Quantidade e valor por produto faturado)
Local oSection10  	:= oReport:Section(10)	           //Objeto secao 10 do relatorio (Numero de atendimentos por midia)
Local oSection11 	:= oReport:Section(11)	           //Objeto secao 11 do relatorio (Quantidade e valor de produtos faturados por midia)
Local oSection12 	:= oReport:Section(12)	           //Objeto secao 12 do relatorio (Numero de atendimentos por campanha)
Local oSection13 	:= oReport:Section(13)	           //Objeto secao 13 do relatorio (Quantidade e valor de produtos faturados por campanha)
Local oSection14 	:= oReport:Section(14)	           //Objeto secao 14 do relatorio (Numeros de atendimentos, orcamentos e faturamento por vendedor)
Local oSection15  	:= oReport:Section(15)	           //Objeto secao 15 do relatorio (Numeros de atendimentos, orcamentos e faturamento por midia)
Local oSection16 	:= oReport:Section(16)	           //Objeto secao 16 do relatorio (Numeros de atendimentos, orcamentos e faturamento por campanha)
Local cFiltro	:= ""                      //String contendo o filtro de busca a ser utilizado com DBF

Local cCodSUA		:= ""						// Controla a quebra do cabecalho do atendimento
Local nI			:= 0						// Controle
Local nPos			:= 0						// Ponteiro da pesquisa no array
Local cSUB			:= "SUB"					// Gerencia a troca do alias para top e dbf
Local cSB1			:= "SB1"					// Gerencia a troca do alias para top e dbf
Local aUA_Oper		:= TkSx3Box("UA_OPER")		// Pesquisa as opcoes do campo no DD SX3
Local aUA_TMK		:= TkSx3Box("UA_TMK")		// Pesquisa as opcoes do campo no DD SX3
Local aUA_TpFrete	:= TkSx3Box("UA_TPFRETE")	// Pesquisa as opcoes do campo no DD SX3
Local nTotGer		:= 0						// Total dos atendimentos
Local nTotAten		:= 0 						// Valor total negociado na operacao de atendimento 
Local nTotOrc		:= 0 						// Valor total dos itens Orcados
Local nTotFat		:= 0 						// Valor total dos itens Faturados
Local nTotVend		:= 0 						// Numero de vendedores no periodo
Local aTotOper		:= {}					    // Total por tipo de Operacao
Local aTotCamp		:= {}						// Total geral das campanhas
Local aTotMid		:= {}						// Total geral das midias
Local aTotProd		:= {}						// Total geral dos produtos 
Local aValVend		:= {}						// Total Orcados/Faturados por vendedor
Local aProdMid		:= {}						// Total Produtos vendidos por midia
Local aProdCamp     := {}						// Total Produtos vendidos por campanha
Local aDatVend		:= {}						// Total por data e por vendedor
Local aDatMid		:= {}						// Total por data e por midia
Local aDatCamp		:= {}						// Total por data e por campanha
Local nTempAt       := 0						// Tempo total no periodo
Local nTempAten     := 0						// Tempo total dos atendimentos no periodo
Local nTempOrc		:= 0						// Tempo total dos atendimentos (Orcados) no periodo
Local nTempFat      := 0 						// Tempo total dos atendimentos (Faturados) no periodo
Local cAtend		:= 0 						// Variavel de auxilio que monta a String no formato HH:MM:SS para a media por atendimentos
Local cVend         := 0						// Variavel de auxilio que monta a String no formato HH:MM:SS para a media por vendedores
Local cData			:= ""						// Para quebra de relatorio
Local lPula			:= .F.						// Variavel de auxilio
Local nLen			:= 0						// Variavel de auxilio
Local aTime			:= {}						// Variavel de Auxilio - Intervalo de tempo
Local cOrderBy 		:= ""
Local cNSellerObf	:= ""
Local lSellerIsObf	:= FATPDIsObfuscate("A3_NOME",Nil, .T.)	
Local cNSeller		:= ""	

#IFDEF TOP  
	Local cCanc := " "               //Codigo para cancelados
	//Local cMV03 := DtoS(mv_par03)	//Parametro 03 convertido no formato de data do sistema
	//Local cMV04 := DtoS(mv_par04)	//Parametro 04 convertido no formato de data do sistema


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("TMKR007") 
	DbSelectArea("SUA")
	DbSetOrder(4)
	cOrderBy := "% " + SqlOrder(IndexKey()) + " %"
	
	BEGIN REPORT QUERY oSection1
 	BeginSQL alias cSUA
		SELECT 	UA_FILIAL,		UA_EMISSAO,		UA_CANC,
				UA_VEND,		UA_NUM,			UA_CODCAMP,		UA_MIDIA,
				UA_INICIO,		UA_FIM,			UA_OPER				
		FROM 	%table:SUA% SUA
		WHERE	 SUA.UA_FILIAL = %xFilial:SUA% AND
				 SUA.UA_EMISSAO BETWEEN %exp:DtoS(Mv_Par03)% AND %exp:DtoS(Mv_Par04)% AND				 				 				
				 SUA.UA_VEND BETWEEN %exp:mv_par01% AND %exp:mv_par02% AND
				 SUA.UA_CANC = %exp:cCanc% AND
				 SUA.%notDel% 
		ORDER BY %ORDER:SUA% //ORDER BY %exp:cOrderBy%    
    EndSql    
	END REPORT QUERY oSection1 
                       

#ELSE 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("TMK004")       
			
	DbSelectArea(cSUA)
	DbSetOrder(4)
	oReport:SetMeter(RecCount())
	MsSeek(xFilial("SUA") + DtoS(Mv_Par03), .T.)
	
#ENDIF

While	(!Eof())							.AND.;
		(cSUA)->UA_FILIAL == xFilial("SUA")	.AND.;
		(cSUA)->UA_EMISSAO >=	Mv_Par03	.AND.;
		(cSUA)->UA_EMISSAO <=	Mv_Par04
	
	If oReport:Cancel()
		Exit
	EndIf	

	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Avalia os parametros para DBF³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	#IFNDEF TOP
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valida se o atendimento nao esta encerrado               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cSUA)->UA_CANC)
			(cSUA)->(DbSkip())
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valida o intervalo de vendedores informado nos parametros³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ((cSUA)->UA_VEND <= Mv_Par01) .AND. ((cSUA)->UA_VEND >= Mv_Par02)
			(cSUA)->(DbSkip())
			Loop
		Endif

	#ENDIF
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se mudou o registro de atendimento , totaliza os contadores e imprime o novo cabecalho³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cSUA)->UA_NUM <> cCodSUA
		cCodSUA := (cSUA)->UA_NUM

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total geral dos atendimentos.                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotGer++

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total dos atendimentos por Campanha.  							   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTotCamp, {|x| x[1]==(cSUA)->UA_CODCAMP} )
		If nPos > 0
			aTotCamp[nPos][3]++
		Else
			If !Empty( (cSUA)->UA_CODCAMP )
				AAdd(aTotCamp,{ (cSUA)->UA_CODCAMP												,;	// 1 - Codigo da campanha
								Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")	,;	// 2 - Descricao da campanha
				 				1																})	// 3 - Totalizador
			Endif	 				
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total dos atendimentos por Midia.  							       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTotMid, {|x| x[1]==(cSUA)->UA_MIDIA} )
		If nPos > 0
			aTotMid[nPos][3]++
		Else
			If !Empty( (cSUA)->UA_MIDIA )
				AAdd(aTotMid, {(cSUA)->UA_MIDIA													,;	// 1 - Tipo da midia	
								Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")	,;	// 2 - Descricao da midia			
				 				1																})	// 3 - Totalizador				
			Endif	 				
		Endif                       
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total dos tempos gastos para um atendimento (Orcado e Faturado).    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		AAdd(aTime,	{	HrstoSecs( Abs( Val(Substr((cSUA)->UA_FIM,1,2)) - Val(Substr((cSUA)->UA_INICIO,1,2))))		,;	// 1 - Hora -> Segundos
					 	MintoSecs( Abs( Val(Substr((cSUA)->UA_FIM,4,2)) - Val(Substr((cSUA)->UA_INICIO,4,2))))		,;	// 2 - Minuto -> Segundos 
					 	Abs( Val(Substr((cSUA)->UA_FIM,7,2)) - Val(Substr((cSUA)->UA_INICIO,7,2)))				    }) 	// 3 - Segundos 
		
		nTempAt	+= aTime[1][1]+aTime[1][2]+aTime[1][3]	   				// Tempo total dos atendimentos no periodo
		
		If (cSUA)->UA_OPER == "3"	// Atendimento
			nTempAten     += aTime[1][1]+aTime[1][2]+aTime[1][3]		// Tempo total dos atendimentos no periodo		
		
		ElseIf	(cSUA)->UA_OPER == "2"	// Orcado
			nTempOrc	  += aTime[1][1]+aTime[1][2]+aTime[1][3]		// Tempo total dos atendimentos (Orcados) no periodo
		
		ElseIf	(cSUA)->UA_OPER == "1"	// Faturado
			nTempFat      += aTime[1][1]+aTime[1][2]+aTime[1][3]		// Tempo total dos atendimentos (Faturados) no periodo
		Endif	
        
		aTime := {}
		
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao dos itens do atendimento do Televendas.				   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    
	DbSelectArea((cSUB))
	DbSetOrder(1)
	MsSeek(xFilial(cSUB) + (cSUA)->UA_NUM)

	While	(!Eof())								.AND.;
			(cSUB)->UB_FILIAL	==	xFilial((cSUB))	.AND.;
			(cSUB)->UB_NUM		==	(cSUA)->UA_NUM

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total em dinheiro por Tipo de Operacao (Faturamento ou Orcamento).  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTotOper, {|x| x[1]==(cSUA)->UA_OPER} )
		If nPos > 0                                     
			aTotOper[nPos][2]++                 	// Acumula o total de atendimentos
			aTotOper[nPos][3]+= (cSUB)->UB_VLRITEM	// Acumula o valor do item
		Else
			
			If !Empty( (cSUA)->UA_OPER )
				AAdd(aTotOper, {	(cSUA)->UA_OPER		,;	// 1 - Tipo de Operacao     
									 1					,;	// 2 - Total de Atendimentos
								 	(cSUB)->UB_VLRITEM	}) 	// 3 - Total por Operacao
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total em dinheiro por vendedor e por Tipo de Operacao.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aValVend, {|x| x[1]==(cSUA)->UA_VEND} )
		If nPos > 0
			aValVend[nPos][3]++										// Acumula o total de atendimentos
				
			If	VAL((cSUA)->UA_OPER) == ORCAMENTO		// Orcamento
				aValVend[nPos][4] += (cSUB)->UB_VLRITEM             // Acumula os valores de item para os orcamentos
				aValVend[nPos][5]++									// Acumula o total de atendimentos de ORCAMENTO	
					
			ElseIf VAL((cSUA)->UA_OPER) == FATURAMENTO  // Faturamento
				aValVend[nPos][6] += (cSUB)->UB_VLRITEM				// Acumula os valores de item para os faturados
				aValVend[nPos][7]++									// Acumula o total de atendimentos de FATURAMENTO		
			Endif
		
		Else

			
			If lSellerIsObf
				If Empty(cNSellerObf)
					cNSellerObf 	:= FATPDObfuscate("Seller")
				EndIf
				cNSeller := cNSellerObf  
			Else
				cNSeller	:= Posicione("SA3",1,xFilial("SA3")+(cSUA)->UA_VEND,"A3_NOME")
			EndIf	

	
			If VAL((cSUA)->UA_OPER) == ORCAMENTO
			    If !Empty( (cSUA)->UA_VEND )
					AAdd(aValVend,{	(cSUA)->UA_VEND													,;	// 1 - Codigo do vendedor
									cNSeller														,;	// 2 - Descricao do vendedor
									1																,;	// 3 - Total de Atendimentos
									(cSUB)->UB_VLRITEM				                                ,;	// 4 - Valor Orcado
									1																,;  // 5 - Total de Atendimentos Orcados
									0																,;  // 6 - Valor Faturado 
									0																})  // 7 - Total de Atendimentos Faturados
			    Endif
			    
			ElseIf VAL((cSUA)->UA_OPER) == FATURAMENTO
				
				If !Empty( (cSUA)->UA_VEND )
					AAdd(aValVend,{	(cSUA)->UA_VEND													,;	// 1 - Codigo do vendedor
									cNSeller														,;	// 2 - Descricao do vendedor
									1																,;	// 3 - Total de Atendimentos
									0								                                ,;	// 4 - Valor Orcado
									0																,;  // 5 - Total de Atendimentos Orcados
									(cSUB)->UB_VLRITEM												,;  // 6 - Valor Faturado 
									1																})  // 7 - Total de Atendimentos Faturados				
				Endif
				
			Endif  
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total de cada produto vendido.                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If VAL( (cSUA)->UA_OPER ) == FATURAMENTO
			nPos := Ascan(aTotProd, {|x,y| x[1] == (cSUB)->UB_PRODUTO} )
			If nPos > 0
				aTotProd[nPos][3] += (cSUB)->UB_QUANT
				aTotProd[nPos][4] += (cSUB)->UB_VLRITEM										
			Else
				If !Empty( (cSUB)->UB_PRODUTO )
					AAdd(aTotProd, {	(cSUB)->UB_PRODUTO												,;	// 1 - Codigo do produto
    	                    			Posicione("SB1",1,xFilial("SB1")+(cSUB)->UB_PRODUTO,"B1_DESC")	,;	// 2 - Descricao do produto
								 		(cSUB)->UB_QUANT												,;  // 3 - Quantidade do Produto
										(cSUB)->UB_VLRITEM												})	// 4 - Valor Total Vendido
			    Endif
			    
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total de cada produto vendido por midia.                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If VAL( (cSUA)->UA_OPER ) == FATURAMENTO
			nPos := Ascan(aProdMid, {|x,y| x[1] ==(cSUB)->UB_PRODUTO .AND. x[3]==(cSUA)->UA_MIDIA} )
			If nPos > 0
				aProdMid[nPos][5] += (cSUB)->UB_QUANT
				aProdMid[nPos][6] += (cSUB)->UB_VLRITEM										
			Else
				If !Empty( (cSUB)->UB_PRODUTO )
					AAdd(aProdMid,{	(cSUB)->UB_PRODUTO												,;	// 1 - Codigo do produto
    	                    		Posicione("SB1",1,xFilial("SB1")+(cSUB)->UB_PRODUTO,"B1_DESC")	,;	// 2 - Descricao do produto
								 	(cSUA)->UA_MIDIA												,;	// 3 - Codigo da midia
									Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")	,;	// 4 - Descricao da Midia								 	
								 	(cSUB)->UB_QUANT												,;  // 5 - Quantidade do Produto
									(cSUB)->UB_VLRITEM												})	// 6 - Valor Total Vendido
			    Endif
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total de cada produto vendido por campanha.                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If VAL( (cSUA)->UA_OPER ) == FATURAMENTO
			nPos := Ascan(aProdCamp, {|x,y| x[1]==(cSUB)->UB_PRODUTO .AND. x[3]==(cSUA)->UA_CODCAMP} )
			If nPos > 0
				aProdCamp[nPos][5] += (cSUB)->UB_QUANT
				aProdCamp[nPos][6] += (cSUB)->UB_VLRITEM										
			Else
				
				If !Empty( (cSUB)->UB_PRODUTO )
					AAdd(aProdCamp,	{	(cSUB)->UB_PRODUTO												,;	// 1 - Codigo do produto
                        				Posicione("SB1",1,xFilial("SB1")+(cSUB)->UB_PRODUTO,"B1_DESC")	,;	// 2 - Descricao do produto
							 			(cSUA)->UA_CODCAMP												,;	// 3 - Codigo da midia
										Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")	,;	// 4 - Descricao da campanha
							 			(cSUB)->UB_QUANT												,;  // 5 - Quantidade do Produto
										(cSUB)->UB_VLRITEM												})	// 6 - Valor Total Vendido
				Endif
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total de orcamento e faturamento por data e por vendedor.           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aDatVend, {|x,y| x[1]==DtoS((cSUA)->UA_EMISSAO) .AND. x[2]==(cSUA)->UA_VEND} )
		If nPos > 0
			aDatVend[nPos][4]++
			If VAL( (cSUA)->UA_OPER ) == ORCAMENTO
				aDatVend[nPos][5] += (cSUB)->UB_VLRITEM
				aDatVend[nPos][6]++

			ElseIf VAL( (cSUA)->UA_OPER ) == FATURAMENTO 
				aDatVend[nPos][7]+=(cSUB)->UB_VLRITEM					
				aDatVend[nPos][8]++
			Endif

		Else
			If VAL( (cSUA)->UA_OPER ) == ORCAMENTO
				If !Empty( (cSUA)->UA_VEND )
					AAdd(aDatVend,	{DtoS((cSUA)->UA_EMISSAO)										,;	// 1 - Data do Atendimento
    	               	    		(cSUA)->UA_VEND													,;	// 2 - Codigo do vendedor
									Posicione("SA3",1,xFilial("SA3")+(cSUA)->UA_VEND,"A3_NOME")		,;	// 3 - Descricao do vendedor
									1																,;	// 4 - Total de Atendimentos
									(cSUB)->UB_VLRITEM				                                ,;	// 5 - Valor Orcado
									1																,;  // 6 - Total de Atendimentos Orcados
									0																,;  // 7 - Valor Faturado 
									0																})  // 8 - Total de Atendimentos Faturados
				Endif
													
			ElseIf VAL((cSUA)->UA_OPER ) == FATURAMENTO
				
				If !Empty( (cSUA)->UA_VEND )
					AAdd(aDatVend,	{DtoS((cSUA)->UA_EMISSAO)										,;	// 1 - Data do Atendimento
    	               	    		(cSUA)->UA_VEND													,;	// 2 - Codigo do vendedor
									Posicione("SA3",1,xFilial("SA3")+(cSUA)->UA_VEND,"A3_NOME")		,;	// 3 - Descricao do vendedor
									1																,;	// 4 - Total de Atendimentos
									0								                                ,;	// 5 - Valor Orcado
									0																,;  // 6 - Total de Atendimentos Orcados
									(cSUB)->UB_VLRITEM												,;  // 7 - Valor Faturado 
									1																})  // 8 - Total de Atendimentos Faturados				
				Endif
				
			Endif					
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total de orcamento e faturamento por data e por midia.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aDatMid, {|x,y| x[1]==DtoS((cSUA)->UA_EMISSAO) .AND. x[2]==(cSUA)->UA_MIDIA} )
		If nPos > 0
			aDatMid[nPos][4]++
			If VAL( (cSUA)->UA_OPER ) == ORCAMENTO
				aDatMid[nPos][5] += (cSUB)->UB_VLRITEM
				aDatMid[nPos][6]++                      
				
			ElseIf VAL( (cSUA)->UA_OPER ) == FATURAMENTO
				aDatMid[nPos][7] += (cSUB)->UB_VLRITEM					
				aDatMid[nPos][8]++
			Endif
		Else
			If VAL( (cSUA)->UA_OPER ) == ORCAMENTO
				
				If !Empty( (cSUA)->UA_MIDIA )
					AAdd(aDatMid,	{DtoS((cSUA)->UA_EMISSAO)										,;	// Data do Atendimento
    	               	    		(cSUA)->UA_MIDIA												,;	// Codigo da midia
									Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")	,;	// Descricao da midia			
									1																,;	// Total de Atendimentos
									(cSUB)->UB_VLRITEM				                                ,;	// Valor Orcado
									1																,;  // Total de Atendimentos Orcados
									0																,;  // Valor Faturado 
									0																})  // Total de Atendimentos Faturados
				Endif
									
			ElseIf VAL( (cSUA)->UA_OPER ) == FATURAMENTO
				
				If !Empty( (cSUA)->UA_MIDIA )
					AAdd(aDatMid,	{DtoS((cSUA)->UA_EMISSAO)										,;	// Data do Atendimento
                   	    			(cSUA)->UA_MIDIA												,;	// Codigo da midia
									Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")	,;	// Descricao da midia			
									1																,;	// Total de Atendimentos
									0								                                ,;	// Valor Orcado
									0																,;  // Total de Atendimentos Orcados
									(cSUB)->UB_VLRITEM												,;  // Valor Faturado 
									1																})  // Total de Atendimentos Faturados				
				Endif
			Endif							
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Total de orcamento e faturamento por data e por campanha.           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aDatCamp, {|x,y| x[1]==DtoS((cSUA)->UA_EMISSAO) .AND. x[2]==(cSUA)->UA_CODCAMP} )
		If nPos > 0
			aDatCamp[nPos][4]++
			If VAL(	(cSUA)->UA_OPER ) == ORCAMENTO
				aDatCamp[nPos][5] += (cSUB)->UB_VLRITEM
				aDatCamp[nPos][6]++

			ElseIf VAL(	(cSUA)->UA_OPER ) == FATURAMENTO
				aDatCamp[nPos][7] += (cSUB)->UB_VLRITEM					
				aDatCamp[nPos][8]++
			Endif
		Else
			If VAL(	(cSUA)->UA_OPER ) == ORCAMENTO
				
				If !Empty( (cSUA)->UA_CODCAMP )
					AAdd(aDatCamp,	{DtoS((cSUA)->UA_EMISSAO)										,;	// 1 - Data do Atendimento
									(cSUA)->UA_CODCAMP												,;	// 2 - Codigo da campanha
									Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")	,;	// 3 - Descricao da campanha
									1																,;	// 4 - Total de Atendimentos
									(cSUB)->UB_VLRITEM				                                ,;	// 5 - Valor Orcado
									1																,;  // 6 - Total de Atendimentos Orcados
									0																,;  // 7 - Valor Faturado 
									0																})  // 8 - Total de Atendimentos Faturados
				Endif
				
			ElseIf VAL(	(cSUA)->UA_OPER ) == FATURAMENTO
				
				If !Empty( (cSUA)->UA_CODCAMP )
					AAdd(aDatCamp,	{DtoS((cSUA)->UA_EMISSAO)										,;	// 1 - Data do Atendimento
									(cSUA)->UA_CODCAMP												,;	// 2 - Codigo da campanha
									Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")	,;	// 3 - Descricao da campanha
									1																,;	// 4 - Total de Atendimentos
									0								                                ,;	// 5 - Valor Orcado
									0																,;  // 6 - Total de Atendimentos Orcados
									(cSUB)->UB_VLRITEM												,;  // 7 - Valor Faturado 
									1																})  // 8 - Total de Atendimentos Faturados				
				Endif
			Endif					
		Endif        
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valor Total dos produtos orcados e faturados. 				       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        If VAL( (cSUA)->UA_OPER ) == ATENDIMENTO
		    nTotAten += (cSUB)->UB_VLRITEM      
		    
		ElseIf	VAL( (cSUA)->UA_OPER ) == ORCAMENTO
			nTotOrc	 += (cSUB)->UB_VLRITEM         
			
		ElseIf 	VAL( (cSUA)->UA_OPER ) == FATURAMENTO
			nTotFat	 += (cSUB)->UB_VLRITEM
		
		Endif	
		
		DbSelectArea(cSUB)
		DbSkip()
		
	End
	
	DbSelectArea(cSUA)
	DbSkip()
	oReport:IncMeter()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Numero total de vendedores no periodo.                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotVend := Len(aValVend)

If nTotGer > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total dos atendimentos. 								           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:Init()
	oSection1:Cell("S1_TOT"):SetValue(Transform(nTotGer,'@E 999,999'))
	oSection1:PrintLine()
	oSection1:Finish()


	oSection2:Init()	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Medias dos tempos. 							                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAtend	:= 	StrZero( SecsToHrs(nTempAten/nTotGer),2)+":"+; 
				StrZero( SecsToMin( Abs(nTempAten/nTotGer-SecsToHrs(nTempAten/nTotGer)*3600) ),2)+":"+;
				StrZero( Abs( (nTempAten/nTotGer-SecsToHrs(nTempAten/nTotGer)*3600) - (SecsToMin( Abs(nTempAten/nTotGer-SecsToHrs(nTempAten/nTotGer)*3600) )*60) ),2)	
	oSection2:Cell("S2_TMAOPAT"):SetValue(cAtend)	// 'T.M.A. por operação de "Atendimento"'


	cVend   := 	StrZero( SecsToHrs(nTempAten/nTotVend),2)+":"+; 
				StrZero( SecsToMin( Abs(nTempAten/nTotVend-SecsToHrs(nTempAten/nTotVend)*3600) ),2)+":"+;
				StrZero( Abs( (nTempAten/nTotVend-SecsToHrs(nTempAten/nTotVend)*3600) - (SecsToMin( Abs(nTempAten/nTotVend-SecsToHrs(nTempAten/nTotVend)*3600) )*60) ),2)
	oSection2:Cell("S2_TMAOPATVD"):SetValue(cVend)	// 'T.M.A. por operação de "Atendimento" X Vendedor'

	cAtend	:= 	StrZero( SecsToHrs(nTempOrc/nTotGer),2)+":"+; 
				StrZero( SecsToMin( Abs(nTempOrc/nTotGer-SecsToHrs(nTempOrc/nTotGer)*3600) ),2)+":"+;
				StrZero( Abs( (nTempOrc/nTotGer-SecsToHrs(nTempOrc/nTotGer)*3600) - (SecsToMin( Abs(nTempOrc/nTotGer-SecsToHrs(nTempOrc/nTotGer)*3600) )*60) ),2)
	oSection2:Cell("S2_TMAOPOC"):SetValue(cAtend)// 'T.M.A. por operação de "Orçamento"'

	cVend   := 	StrZero( SecsToHrs(nTempOrc/nTotVend),2)+":"+; 
				StrZero( SecsToMin( Abs(nTempOrc/nTotVend-SecsToHrs(nTempOrc/nTotVend)*3600) ),2)+":"+;
				StrZero( Abs( (nTempOrc/nTotVend-SecsToHrs(nTempOrc/nTotVend)*3600) - (SecsToMin( Abs(nTempOrc/nTotVend-SecsToHrs(nTempOrc/nTotVend)*3600) )*60) ),2)	
	oSection2:Cell("S2_TMAOPOCVD"):SetValue(cAtend)// 'T.M.A. por operação de "Orçamento" X Vendedor'

	oSection2:SetLineBreak()
	oSection2:PrintLine()
	oSection2:Finish()

	oSection3:Init()
	cAtend	:= 	StrZero( SecsToHrs(nTempFat/nTotGer),2)+":"+; 
				StrZero( SecsToMin( Abs(nTempFat/nTotGer-SecsToHrs(nTempFat/nTotGer)*3600) ),2)+":"+;
				StrZero( Abs( (nTempFat/nTotGer-SecsToHrs(nTempFat/nTotGer)*3600) - (SecsToMin( Abs(nTempFat/nTotGer-SecsToHrs(nTempFat/nTotGer)*3600) )*60) ),2)
	oSection3:Cell("S2_TMAOPFAT"):SetValue(cAtend)	// 'T.M.A. por operação de "Faturamento"'

	cVend   := 	StrZero( SecsToHrs(nTempFat/nTotVend),2)+":"+; 
				StrZero( SecsToMin( Abs(nTempFat/nTotVend-SecsToHrs(nTempFat/nTotVend)*3600) ),2)+":"+;
				StrZero( Abs( (nTempFat/nTotVend-SecsToHrs(nTempFat/nTotVend)*3600) - (SecsToMin( Abs(nTempFat/nTotVend-SecsToHrs(nTempFat/nTotVend)*3600) )*60) ),2)
	oSection3:Cell("S2_TMAOPFATVD"):SetValue(cVend)// 'T.M.A. por operação de "Faturamento" X Vendedor'


	cAtend	:= 	StrZero( SecsToHrs(nTempAt/nTotGer),2)+":"+; 
				StrZero( SecsToMin( Abs(nTempAt/nTotGer-SecsToHrs(nTempAt/nTotGer)*3600) ),2)+":"+;
				StrZero( Abs( (nTempAt/nTotGer-SecsToHrs(nTempAt/nTotGer)*3600) - (SecsToMin( Abs(nTempAt/nTotGer-SecsToHrs(nTempAt/nTotGer)*3600) )*60) ),2)
	oSection3:Cell("S2_TMAGER"):SetValue(cAtend)// "T.M.A. Geral"

	cVend   := 	StrZero( SecsToHrs(nTempAt/nTotVend),2)+":"+; 
				StrZero( SecsToMin( Abs(nTempAt/nTotVend-SecsToHrs(nTempAt/nTotVend)*3600) ),2)+":"+;
				StrZero( Abs( (nTempAt/nTotVend-SecsToHrs(nTempAt/nTotVend)*3600) - (SecsToMin( Abs(nTempAt/nTotVend-SecsToHrs(nTempAt/nTotVend)*3600) )*60) ),2)
	oSection3:Cell("S2_TMAGERVD"):SetValue(cVend)	// "T.M.A. Geral X Vendedor"

	oSection3:SetLineBreak()
	oSection3:PrintLine()
	oSection3:Finish()   
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Medias dos valores. 							                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nPos := Ascan(aTotOper, {|x,y| TRIM(x[1]) == "2" } ) // Orcamento
	If nPos > 0 
		If aTotOper[nPos][3] > 0
			oSection4:Init()		
			oSection4:Cell("S3_VLORCAT"):SetVaLue(Transform(aTotOper[nPos][3]/nTotGer,'@E 999,999,999.99'))
			oSection4:PrintLine()
		    oSection4:Finish()			
    	Endif
    Endif                        
        
	nPos := Ascan(aTotOper, {|x,y| TRIM(x[1]) == "1" } ) // Faturamento
	If nPos > 0 
		If aTotOper[nPos][3] > 0
			oSection5:Init()
			oSection5:Cell("S4_VLFATATMD"):SetVaLue(Transform(aTotOper[nPos][3]/nTotGer,'@E 999,999,999.99'))
			oSection5:PrintLine()
			oSection5:Finish()
    	Endif
    Endif    

	nLen :=	Len(aValVend)
	oSection6:Init()
	For nI := 1 To nLen
		oSection6:Cell("S5_VENDOR"):SetVaLue(aValVend[nI][1] + " - " + FATPDObfuscate(aValVend[nI][2],"A3_NOME",,.T.))		
		
		nPos := Ascan(aTotOper, {|x,y| x[1]=="2" } )		
		If nPos > 0
			oSection6:Cell("S5_ORCAM"):SetVaLue(Transform(aValVend[nI][4]/aValVend[nI][5],'@E 999,999,999.99'))			
			oSection6:Cell("S5_DESVIO"):SetVaLue(Transform( (aValVend[nI][4]/aValVend[nI][5]) -  aTotOper[nPos][3]/nTotGer,'@E 999,999,999.99'))
		Endif  
		nPos := Ascan(aTotOper, {|x,y| x[1]=="1" } )		
		If nPos > 0 
			oSection6:Cell("S5_FAT"):SetVaLue(Transform(aValVend[nI][6]/aValVend[nI][7] ,'@E 999,999,999.99'))
			oSection6:Cell("S5_DESVIO2"):SetVaLue(Transform( (aValVend[nI][6]/aValVend[nI][7]) -  aTotOper[nPos][3]/nTotGer,'@E 999,999,999.99'))   
        Endif		
        oSection6:PrintLine()		
	Next                     
	oSection6:Finish()
	
	oReport:EndPage()	
	
	oSection7:Init()	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total por operacao.											   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ASort(aTotOper,,, {|x,y| x[3] > y[3]} )		// Coloca em ordem decrescente
	nLen := Len(aTotOper)
	For nI := 1 To nLen	
		oSection7:Cell("S6_OPER"):SetValue(aUA_Oper[Val(aTotOper[nI][1])])
		oSection7:Cell("S6_ATEND"):SetValue(Transform(aTotOper[nI][2],'@E 999,999'))		
		oSection7:Cell("S6_VALNEG"):SetValue(Transform(aTotOper[nI][3],'@E 999,999,999.99'))			
	    oSection7:PrintLine()
	Next	
	oSection7:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total por vendedor e por Tipo de Operacao.                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	oSection8:Init()
	ASort(aValVend,,, {|x,y| x[3] > y[3]} )		// Coloca em ordem decrescente  
	nLen :=	Len(aValVend)
	For nI := 1 To nLen	
		oSection8:Cell("S7_VENDOR"):SetValue(aValVend[nI][1] + " - " + FATPDObfuscate(aValVend[nI][2],"A3_NOME",,.T.))
		oSection8:Cell("S7_ATEN"):SetValue(Transform(aValVend[nI][3],'@E 999,999'))		
		oSection8:Cell("S7_ORCAM"):SetValue(Transform(aValVend[nI][5],'@E 999,999'))
		oSection8:Cell("S7_VALOR"):SetValue(Transform(aValVend[nI][4],'@E 999,999,999.99'))
		oSection8:Cell("S7_FAT"):SetValue(Transform(aValVend[nI][7],'@E 999,999'))
		oSection8:Cell("S7_VAL"):SetValue(Transform(aValVend[nI][6],'@E 999,999,999.99'))
		oSection8:PrintLine()		
	Next nI	        
	oSection8:Finish()
        
	oSection9:Init()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total por produto.  											   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	ASort(aTotProd,,, {|x,y| x[4] > y[4]} )		// Coloca em ordem decrescente  
	nLen := Len(aTotProd)
	For nI := 1 To nLen
		oSection9:Cell("S8_PRODFAT"):SetValue(aTotProd[nI][1] + " - " + aTotProd[nI][2])		
		oSection9:Cell("S8_QTDE"):SetValue(Transform(aTotProd[nI][3],'@E 999,999'))
		oSection9:Cell("S8_PERCENT"):SetValue(Transform((aTotProd[nI][3]/nTotGer)*100, '@E 999,999.99'))
		oSection9:Cell("S8_VALOR"):SetValue(Transform(aTotProd[nI][4],'@E 999,999,999.99'))
		oSection9:PrintLine()
	Next nI	
	oSection9:Finish()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total por midia.  											   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	oSection10:Init()  
	ASort(aTotMid,,, {|x,y| x[3] > y[3]} )		// Coloca em ordem decrescente  
	nLen := Len(aTotMid)
	For nI := 1 To nLen
		oSection10:Cell("S9_MIDIA"):SetValue(aTotMid[nI][1] + " - " + aTotMid[nI][2])	// Descricao da campanha
		oSection10:Cell("S9_ATEND"):SetValue(Transform(aTotMid[nI][3],'@E 999,999'))						// Total de Atendimentos		
		oSection10:Cell("S9_PERCENT"):SetValue(Transform((aTotMid[nI][3]/nTotGer)*100, '@E 999,999.99')) 		// Porcentagem)		
		oSection10:PrintLine()
	Next nI		
	oSection10:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total de produtos vendidos por midia.    					   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	oSection11:Init()
	ASort(aProdMid,,, {|x,y| x[6] > y[6] } )		// Coloca em ordem decrescente por valor
	
	nLen := Len(aProdMid)
	For nI := 1 To nLen
		oSection11:Cell("S10_PRODUTO"):SetValue(aProdMid[nI][1]+ " - " + aProdMid[nI][2]) 	// Descricao do produto
		oSection11:Cell("S10_MIDIA"):SetValue(aProdMid[nI][3]+ " - " + aProdMid[nI][4])		// Descricao da midia
		oSection11:Cell("S10_QTDE"):SetValue(Transform(aProdMid[nI][5],'@E 999,999'))			// Quantidade de produtos
		oSection11:Cell("S10_FAT"):SetValue(Transform(aProdMid[nI][6],'@E 999,999,999.99'))	// Valor total Faturados
        oSection11:PrintLine()
	Next nI	
	oSection11:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total por campanha.											   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	oSection12:Init()
	ASort(aTotCamp,,, {|x,y| x[3] > y[3]} )		// Coloca em ordem decrescente  
	nLen := Len(aTotCamp)
	For nI := 1 To nLen
		oSection12:Cell("S11_CAMP"):SetValue(aTotCamp[nI][1] + " - " + aTotCamp[nI][2]) // Descricao da campanha
		oSection12:Cell("S11_TOTAT"):SetValue(Transform(aTotCamp[nI][3],'@E 999,999'))				// Total de Atendimentos
		oSection12:Cell("S11_PERCENT"):SetValue(Transform((aTotCamp[nI][3]/nTotGer)*100, '@E 999,999.99')) // Porcentagem
		oSection12:PrintLine()
	Next nI                  	
	oSection12:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total de produtos vendidos por campanha.    					   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	oSection13:Init()  
	ASort(aProdCamp,,, {|x,y| x[6] > y[6] } )		// Coloca em ordem decrescente por valor
    nLen := Len(aProdCamp)
	For nI := 1 To nLen
		oSection13:Cell("S12_PROD"):SetValue(aProdCamp[nI][1]+ " - " + aProdCamp[nI][2])	// Descricao do produto
		oSection13:Cell("S12_CAMP"):SetValue(aProdCamp[nI][3]+ " - " + aProdCamp[nI][4]) // Descricao da midia
		oSection13:Cell("S12_QTDE"):SetValue(Transform(aProdCamp[nI][5],'@E 999,999'))	// Quantidade de produtos
		oSection13:Cell("S12_VLR"):SetValue(Transform(aProdCamp[nI][6],'@E 999,999,999.99')) // Valor total Faturados
		oSection13:PrintLine()
	Next nI		
	oSection13:Finish()

	oReport:EndPage()                                                                  

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Data e vendedor.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection14:Init()
	ASort(aDatVend,,, {|x,y| x[1] < y[1] } )		// Coloca em ordem crescente por dia
	nLen := Len(aDatVend)
	For nI := 1 To nLen
		oSection14:Cell("S13_DATA"):SetValue()
		If cData <> aDatVend[nI][1]
			oSection14:Cell("S13_DATA"):SetValue(StoD(aDatVend[nI][1]))
		Endif
		oSection14:Cell("S13_VENDOR"):SetValue(aDatVend[nI][2]+ " - " + FATPDObfuscate(aDatVend[nI][3],"A3_NOME",,.T.)) // Descricao do vendedor
		oSection14:Cell("S13_TOTAT"):SetValue(Transform(aDatVend[nI][4],'@E 999,999')) 					// Total de Atendimentos
		oSection14:Cell("S13_TOTORC"):SetValue(Transform(aDatVend[nI][6],'@E 999,999')) // Total de Atendimentos Orcados
		oSection14:Cell("S13_VLORC"):SetValue(Transform(aDatVend[nI][5],'@E 999,999,999.99'))	// Valor Orcado
		oSection14:Cell("S13_TOTFAT"):SetValue(Transform(aDatVend[nI][8],'@E 999,999'))	// Total de Atendimentos Faturados
		oSection14:Cell("S13_VLFAT"):SetValue(Transform(aDatVend[nI][7],'@E 999,999,999.99'))	// Valor Faturado
		oSection14:PrintLine()
		cData := aDatVend[nI][1]		
	Next nI
	
	lPula := .F.
	cData := ""	
	oSection14:Finish()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Data e Midia.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection15:Init()
	ASort(aDatMid,,, {|x,y| x[1] < y[1] } )		// Coloca em ordem crescente por dia

	nLen := Len(aDatMid)
	For nI := 1 To nLen

		oSection15:Cell("S14_DATA"):SetValue("")
		If cData <> aDatMid[nI][1]
			oSection15:Cell("S14_DATA"):SetValue(StoD(aDatMid[nI][1]))
		Endif

		oSection15:Cell("S14_MIDIA"):SetValue(aDatMid[nI][2]+ " - " + aDatMid[nI][3])	// Descricao da Midia
		oSection15:Cell("S14_TOTAT"):SetValue(Transform(aDatMid[nI][4],'@E 999,999'))	// Total de Atendimentos
		oSection15:Cell("S14_TOTORC"):SetValue(Transform(aDatMid[nI][6],'@E 999,999'))	// Total de Atendimentos Orcados
		oSection15:Cell("S14_VLORC"):SetValue(Transform(aDatMid[nI][5],'@E 999,999,999.99'))		// Valor Orcado
		oSection15:Cell("S14_TOTFAT"):SetValue(Transform(aDatMid[nI][8],'@E 999,999'))	// Total de Atendimentos Faturados
		oSection15:Cell("S14_VLFAT"):SetValue(Transform(aDatMid[nI][7],'@E 999,999,999.99'))	// Valor Faturado
		oSection15:PrintLine()
		
		cData := aDatMid[nI][1]
		
	Next nI
		
	lPula := .F.
	cData := ""	
	oSection15:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Data e Campanha.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection16:Init()
	ASort(aDatCamp,,, {|x,y| x[1] < y[1] } )		// Coloca em ordem crescente por dia
	nLen := Len(aDatCamp)		
	For nI := 1 To nLen
		If cData <> aDatCamp[nI][1]
			oSection16:Cell("S15_DATA"):SetValue(StoD(aDatCamp[nI][1]))
		Endif

		oSection16:Cell("S15_CAMPANHA"):SetValue(aDatCamp[nI][2]+ " - " + aDatCamp[nI][3]) // Descricao da campanha
		oSection16:Cell("S15_TOTAT"):SetValue(Transform(aDatCamp[nI][4],'@E 999,999'))	// Total de Atendimentos
		oSection16:Cell("S15_TOTORC"):SetValue(Transform(aDatCamp[nI][6],'@E 999,999'))	// Total de Atendimentos Orcados
		oSection16:Cell("S15_VLORC"):SetValue(Transform(aDatCamp[nI][5],'@E 999,999,999.99'))	// Valor Orcado
		oSection16:Cell("S15_TOTFAT"):SetValue(Transform(aDatCamp[nI][8],'@E 999,999'))	// Total de Atendimentos Faturados
		oSection16:Cell("S15_VLFAT"):SetValue(Transform(aDatCamp[nI][7],'@E 999,999,999.99'))	// Valor Faturado
		oSection16:PrintLine()
		
		cData := aDatCamp[nI][1]
		
	Next nI
		
	lPula := .F.
	cData := ""
	
	oSection16:Finish()  
	
EndIf 

Return()

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate

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