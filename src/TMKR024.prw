/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR024.CH"
#INCLUDE "REPORT.CH"

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    Ё TMKR024  Ё Autor Ё Armando M. Tessaroli  Ё Data Ё 20/03/03 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Ligacoes realizadas no atendimento de Televendas           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Televendas (SUA)                                           Ё╠╠
╠╠цддддддддддедддддддддддддддбдддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁAnalista  Ё Data/Bops/Ver ЁManutencao Efetuada                         Ё╠╠
╠╠цддддддддддеддддддддбддддддбдддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁMarcelo K Ё10/07/03Ё710   ЁCorrecao do seek na Tabela SU9 para indice 2Ё╠╠
╠╠цддддддддддеддддддддеддддддедддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁThiago G  Ё12/08/04Ё811   ЁInclusao do cabecalho padrao e alteracao dasЁ╠╠
╠╠Ё          Ё        Ё      Ёtotalizacoes.                               Ё╠╠
╠╠ЁMichel W. Ё14/08/06Ё99194 ЁAtualizacao para relatorio release 4.       Ё╠╠
╠╠ЁMichel W. Ё21/08/06Ё99194 ЁRevisao de fonte.                           Ё╠╠
╠╠юддддддддддаддддддддаддддддадддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/             

User Function TMKR024()

Local oReport	//Objeto relatorio TReport (Release 4)
Local aPDFields := {"U7_NOME", "A3_NOME", "A1_NOME", "A1_TEL", "A1_BAIRRO", "A1_MUN", "A1_EST","A1_END"}

FATPDLoad(/*cUserPDA*/, /*aAlias*/, aPDFields, "TMKR024")

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte("TMK024",.F.)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                          Ё
//Ё Mv_Par01           // Do Operador                             Ё
//Ё Mv_Par02           // Ate o Operador                          Ё
//Ё Mv_Par03           // A Partir de                             Ё
//Ё Mv_Par04           // Ate o dia                               Ё
//Ё Mv_Par05           // Da Midia                                Ё
//Ё Mv_Par06           // Ate a Midia                             Ё
//Ё Mv_Par07           // Campanha         - Vazio entra tudo     Ё
//Ё Mv_Par08           // Tipo da Entidade - SA1, SUS ou TODAS    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//здддддддддддддддддддддд©
//ЁInterface de impressaoЁ
//юдддддддддддддддддддддды
oReport := ReportDef()
oReport:PrintDialog()

FATPDUnload()

Return(.T.)

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддддддбдддддддбддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁReportDef    Ё Autor ЁMichel W. Mosca     Ё Data Ё14/08/2006Ё╠╠
╠╠цддддддддддедддддддддддддадддддддаддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁRotina que define os itens que serao apresentados no relato-Ё╠╠
╠╠Ё          Ёrio de Atendimentos realizados no release 4.                Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё ReportDef()                                                Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ                                                            Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё CALL CENTER                                                Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/              
Static Function ReportDef()
Local oReport 				//Objeto relatorio TReport (Release 4)
Local oSection1             //Objeto secao 1 do relatorio (Cabecalho, dados do atendimento)
Local oSection2             //Secao com itens relacionados ao atendimento
Local oSection2X			//Secao com itens relacionados ao atendimento
Local oSection3             //Secao com totalizadores do relatorio
Local oSection4             //Secao com totalizadores do relatorio
Local oSection5             //Secao com totalizadores do relatorio
Local oSection6             //Secao com totalizadores do relatorio
Local oSection7             //Secao com totalizadores do relatorio
Local oSection8             //Secao com totalizadores do relatorio
Local oSection9             //Secao com totalizadores do relatorio
Local oSection10             //Secao com totalizadores do relatorio
Local oSection11             //Secao com totalizadores do relatorio
Local oSection12             //Secao com totalizadores do relatorio
Local cSUA := "SUA"     //Alias da consulta Embedded SQL
Local cSUB := "SUB"
                                                                    
Local aCampos		:= {}						// Campos do alias principal para select
Local aDescCab      := {}                                                               
Local aUA_TMK		:= TkSx3Box("UA_TMK")		// Pesquisa as opcoes do campo no DD SX3
Local aUA_TpFrete	:= TkSx3Box("UA_TPFRETE")	// Pesquisa as opcoes do campo no DD SX3
Local aUA_Oper		:= TkSx3Box("UA_OPER")		// Pesquisa as opcoes do campo no DD SX3

cSUA	:= GetNextAlias()						// Pega o proximo Alias Disponivel	
cSUB	:= cSUA	                   

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁImprime o Cabecalho padrao e retorna a posicao da linha.   Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aCampos	:= {"UA_EMISSAO"	,"UA_CODCONT"	,"UA_NUM"		,;
   			"U5_FCOM1"		,"UA_OPERADO"   ,"U5_EMAIL"		,;
   			"UA_VEND"		,"UA_DESCCLI"	,"UA_MIDIA"		,;
   			"A1_TEL"		,"UA_CODCAMP"	,"A1_END"		,;
   			"UA_CODLIG" 	,"A1_BAIRRO"	,"UA_TABELA"	,;
			"A1_MUN"		,"UA_OPER"		,"A1_EST"		,;
			"UA_TMK"		,"UA_TPFRETE"	,"UC_PENDENT"	,;
			"UA_OBS"										}	

aDescCab:= TkTitX3(aCampos)


// "Atendimentos Realizados - Televendas" # // "Este programa ira emitir uma relacao das ligacoes realizadas pelo operador no atendimento Televendas."
// "Os dados serao emitidos conforme os parametros informados." # // "OBS: Serao considerados apenas os ORCAMENTOS e PEDIDOS."
DEFINE REPORT oReport NAME "TMKR024" TITLE STR0001 PARAMETER "TMK024" ACTION {|oReport| Tkr024PrtRpt( oReport, cSUA, cSUB )} DESCRIPTION STR0002 + 	STR0003 + STR0004

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁDefine a secao1 do relatorio, informando que o arquivo principal Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DEFINE SECTION oSection1  OF oReport    TITLE STR0037 TABLES "SUA"		//"OrГamento Televendas"
DEFINE SECTION oSection2  OF oSection1  TITLE STR0038 TABLES "SUB"		//"Itens do OrГamento Televendas"
DEFINE SECTION oSection2X  OF oSection2 TITLE STR0038 TABLES "SUB"		//Itens do OrГamento Televendas 2
DEFINE SECTION oSection3  OF oReport    TITLE STR0039 					//"Total atendimento"
DEFINE SECTION oSection4  OF oReport    TITLE STR0040 					//"Operador orГamento"
DEFINE SECTION oSection5  OF oReport    TITLE STR0041					//"Produtos orГamento"
DEFINE SECTION oSection6  OF oReport    TITLE STR0042 					//"Midia"
DEFINE SECTION oSection7  OF oReport    TITLE STR0043 					//"Valores mМdia x produto"
DEFINE SECTION oSection8  OF oReport    TITLE STR0044 					//"Atendimento"
DEFINE SECTION oSection9  OF oReport    TITLE STR0045 					//"Campanha"
DEFINE SECTION oSection10 OF oReport    TITLE STR0046 					//"Data x Operador"
DEFINE SECTION oSection11 OF oReport    TITLE STR0047 					//"Data x Midia"
DEFINE SECTION oSection12 OF oReport    TITLE STR0048 					//"Data x Campanha"

//зддддддддддддддддддддддддддддддддддддддддддддд©
//ЁDefine as celulas que irao aparecer na secao1Ё
//юддддддддддддддддддддддддддддддддддддддддддддды            
//зддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁImprime os dados do cabecalho do script dinamico.Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддды
DEFINE CELL NAME "UA_EMISSAO" OF oSection1 Alias "SUA" // "Data"
DEFINE CELL NAME "" OF oSection1 BLOCK{||(cSUA)->UA_CODCONT + " - " + TkDadosContato((cSUA)->UA_CODCONT,0,.T.)} TITLE aDescCab[2][1] SIZE 36		// "Contato"
DEFINE CELL NAME "UA_NUM" OF oSection1 Alias "SUA"	 // "Atendimento"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||Transform( TkDadosContato((cSUA)->UA_CODCONT,8,.T.) + TkDadosContato((cSUA)->UA_CODCONT,4,.T.) , "@R (99)9999-9999")} TITLE aDescCab[4][1] SIZE 13	// "Fone Com.1"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||(cSUA)->UA_OPERADO + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7") + (cSUA)->UA_OPERADO,"U7_NOME"),"U7_NOME","TMKR024")} TITLE aDescCab[5][1] SIZE 46	  // "Operador"	
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||TkDadosContato((cSUA)->UA_CODCONT,10,.T.)} TITLE aDescCab[6][1] SIZE 40		// "E-Mail"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||(cSUA)->UA_VEND + " - " + FATPDObfuscate(Posicione("SA3",1,xFilial("SA3")+(cSUA)->UA_VEND,"A3_NOME"),"A3_NOME","TMKR024")} TITLE aDescCab[7][1] SIZE 46			// Vendedor"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||(cSUA)->UA_CLIENTE + " - " + FATPDObfuscate(IIF((cSUA)->UA_PROSPEC,Posicione("SUS",1,xFilial("SUS") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"US_NOME"),Posicione("SA1",1,xFilial("SA1") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"A1_NOME")),"A1_NOME","TMKR024")} TITLE aDescCab[8][1] SIZE 46 	// "Empresa"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||(cSUA)->UA_MIDIA + " - " + Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")} TITLE aDescCab[9][1] SIZE 61 // "Midia"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||FATPDObfuscate(IIF((cSUA)->UA_PROSPEC,Transform(Posicione("SUS",1,xFilial("SUS") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"US_TEL"),"@R 9999-9999"),Transform(Posicione("SA1",1,xFilial("SA1") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"A1_TEL"),"@R 9999-9999")),"A1_TEL","TMKR024")} TITLE aDescCab[10][1] SIZE 15 	// "Telefone"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||(cSUA)->UA_CODCAMP + " - " + Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")} TITLE aDescCab[11][1] SIZE 46  // "Campanha"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||FATPDObfuscate(IIF((cSUA)->UA_PROSPEC,Posicione("SUS",1,xFilial("SUS") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"US_END"),Posicione("SA1",1,xFilial("SA1") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"A1_END")),"A1_END","TMKR024")} TITLE aDescCab[12][1] SIZE 40 	// "Endereco"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||(cSUA)->UA_CODLIG + " - " + Posicione("SU9",2,xFilial("SU9")+(cSUA)->UA_CODLIG,"U9_DESC")} TITLE aDescCab[13][1] SIZE 36  //"Codigo da Ocorrencia"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||FATPDObfuscate(IIF((cSUA)->UA_PROSPEC,Posicione("SUS",1,xFilial("SUS") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"US_BAIRRO"),Posicione("SA1",1,xFilial("SA1") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"A1_BAIRRO")),"A1_BAIRRO","TMKR024")} TITLE aDescCab[14][1] SIZE 30 	// "Bairro"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||(cSUA)->UA_TABELA + " - " + Posicione("DA0",1,xFilial("DA0") + (cSUA)->UA_TABELA,"DA0_DESCRI")} TITLE aDescCab[15][1] SIZE 36  // "Tabela"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||FATPDObfuscate(IIF((cSUA)->UA_PROSPEC,Posicione("SUS",1,xFilial("SUS") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"US_MUN"),Posicione("SA1",1,xFilial("SA1") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"A1_MUN")),"A1_MUN","TMKR024")} TITLE aDescCab[16][1] SIZE 15 	// "Municipio"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||IIF(Val((cSUA)->UA_OPER)>0,aUA_Oper[Val((cSUA)->UA_OPER)],"")} TITLE aDescCab[17][1] SIZE 80
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||FATPDObfuscate(IIF((cSUA)->UA_PROSPEC,Posicione("SUS",1,xFilial("SUS") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"US_EST"),Posicione("SA1",1,xFilial("SA1") + (cSUA)->UA_CLIENTE + (cSUA)->UA_LOJA,"A1_EST")),"A1_EST","TMKR024")} TITLE aDescCab[18][1] SIZE 15	// "Estado"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||IIF(Val((cSUA)->UA_TMK)>0,aUA_TMK[Val((cSUA)->UA_TMK)],"")} TITLE aDescCab[19][1] SIZE 80 // "Marketing"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||IIF(!EMPTY((cSUA)->UA_TPFRETE),aUA_TpFrete[ IIF((cSUA)->UA_TPFRETE=="C",1,2) ],"")} TITLE aDescCab[20][1] SIZE 80 // "Tipo de Frete"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||DtoC((cSUA)->UA_PROXLIG) + " - " +(cSUA)->UA_HRPEND} TITLE aDescCab[21][1] SIZE 18 //"Retorno"
DEFINE CELL NAME "" OF oSection1 Alias "SUA" BLOCK{||MSMM((cSUA)->UA_CODOBS,200)} TITLE aDescCab[15][1] SIZE 200  //"Observacao do Atendimento"

DEFINE CELL NAME "UB_ITEM" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_PRODUTO" OF oSection2 Alias "SUB"
DEFINE CELL NAME "" OF oSection2 Alias "SUB" BLOCK{||Posicione("SB1",1,xFilial("SB1")+(cSUB)->UB_PRODUTO,"B1_DESC")} TITLE STR0023 SIZE 40
DEFINE CELL NAME "UB_SITPROD" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_QUANT" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_VRUNIT" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_VLRITEM" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_DESC" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_VALDESC" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_ACRE" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_VALACRE" OF oSection2 Alias "SUB"
DEFINE CELL NAME "UB_TES" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_CF" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_PRCTAB" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_BASEICM" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_LOCAL" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_UM" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_DTENTRE" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_LOTE" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_SUBLOTE" OF oSection2X Alias "SUB"
DEFINE CELL NAME "UB_DTVALID" OF oSection2X Alias "SUB"

DEFINE FUNCTION FROM oSection2:Cell("UB_QUANT") OF oSection2 FUNCTION SUM NO END REPORT
DEFINE FUNCTION FROM oSection2:Cell("UB_VLRITEM") OF oSection2 FUNCTION SUM NO END REPORT
DEFINE FUNCTION FROM oSection2:Cell("UB_VALDESC") OF oSection2 FUNCTION SUM NO END REPORT
DEFINE FUNCTION FROM oSection2:Cell("UB_VALACRE") OF oSection2 FUNCTION SUM NO END REPORT

oSection2:SetTotalInLine(.F.)

DEFINE FUNCTION FROM oSection1:Cell("UA_NUM") OF oSection1 FUNCTION COUNT TITLE STR0011 + DtoC(Mv_Par03) + STR0012 + DtoC(Mv_Par04) NO END SECTION 

DEFINE CELL NAME "S3_OPER" OF oSection3 TITLE STR0024 SIZE 30
DEFINE CELL NAME "S3_TOTAT" OF oSection3 TITLE STR0025 SIZE 10		
DEFINE CELL NAME "S3_TOTOP" OF oSection3 TITLE STR0026 SIZE 20		

DEFINE CELL NAME "S4_OPER" OF oSection4 TITLE STR0027 SIZE 40		
DEFINE CELL NAME "S4_ATEND" OF oSection4 TITLE STR0028 SIZE 10
DEFINE CELL NAME "S4_ORC" OF oSection4 TITLE STR0029 SIZE 10		
DEFINE CELL NAME "S4_VLRORC" OF oSection4 TITLE STR0030 SIZE 20		
DEFINE CELL NAME "S4_FAT" OF oSection4 TITLE STR0031 SIZE 10		
DEFINE CELL NAME "S4_VLR" OF oSection4 TITLE STR0030 SIZE 20		


DEFINE CELL NAME "S5_PROD" OF oSection5 TITLE STR0032 SIZE 40
DEFINE CELL NAME "S5_ATEND" OF oSection5 TITLE STR0028 SIZE 10		
DEFINE CELL NAME "S5_PERC" OF oSection5	TITLE "%" SIZE 10	
DEFINE CELL NAME "S5_VLR" OF oSection5 TITLE STR0030 SIZE 20		


DEFINE CELL NAME "S6_MIDIA" OF oSection6 TITLE STR0033 SIZE 40		
DEFINE CELL NAME "S6_ATD" OF oSection6 TITLE STR0028 SIZE 10		
DEFINE CELL NAME "S6_PERC" OF oSection6 TITLE "%" SIZE 10		

DEFINE CELL NAME "S7_PROD" OF oSection7 TITLE STR0032 SIZE 40
DEFINE CELL NAME "S7_MIDIA" OF oSection7 TITLE STR0033 SIZE 40
DEFINE CELL NAME "S7_QTDE" OF oSection7 TITLE STR0034 SIZE 10
DEFINE CELL NAME "S7_VLR" OF oSection7 TITLE STR0030 SIZE 20

DEFINE CELL NAME "S8_CPN" OF oSection8 TITLE STR0035 SIZE 40		
DEFINE CELL NAME "S8_ATD" OF oSection8 TITLE STR0028 SIZE 10		
DEFINE CELL NAME "S8_PERC" OF oSection8 TITLE "%" SIZE 10				

DEFINE CELL NAME "S9_PROD" OF oSection9 TITLE STR0032 SIZE 40 		
DEFINE CELL NAME "S9_CAMP" OF oSection9 TITLE STR0035 SIZE 40 
DEFINE CELL NAME "S9_QTDE" OF oSection9 TITLE STR0034 SIZE 10 		
DEFINE CELL NAME "S9_VLR" OF oSection9 TITLE STR0030 SIZE 20		

DEFINE CELL NAME "S10_DATA" OF oSection10 TITLE STR0036 SIZE 10	
DEFINE CELL NAME "S10_OPER" OF oSection10 TITLE STR0027 SIZE 40		
DEFINE CELL NAME "S10_ATD" OF oSection10 TITLE STR0028 SIZE 10		
DEFINE CELL NAME "S10_ORC" OF oSection10 TITLE STR0029 SIZE 10		
DEFINE CELL NAME "S10_VLRORC" OF oSection10 TITLE STR0030 SIZE 20		
DEFINE CELL NAME "S10_FAT" OF oSection10 TITLE STR0031 SIZE 10		
DEFINE CELL NAME "S10_VLRFAT" OF oSection10	TITLE STR0030 SIZE 20	
                                                         
DEFINE CELL NAME "S11_DATA" OF oSection11 TITLE STR0036 SIZE 10	
DEFINE CELL NAME "S11_MIDIA" OF oSection11 TITLE STR0033 SIZE 40		
DEFINE CELL NAME "S11_ATD" OF oSection11 TITLE STR0028 SIZE 10		
DEFINE CELL NAME "S11_ORC" OF oSection11 TITLE STR0029 SIZE 10		
DEFINE CELL NAME "S11_VLRORC" OF oSection11 TITLE STR0030 SIZE 20		
DEFINE CELL NAME "S11_FAT" OF oSection11 TITLE STR0031 SIZE 10		
DEFINE CELL NAME "S11_VLRFAT" OF oSection11	TITLE STR0030 SIZE 20	

DEFINE CELL NAME "S12_DATA" OF oSection12 TITLE STR0036 SIZE 10	
DEFINE CELL NAME "S12_CAMP" OF oSection12 TITLE STR0035 SIZE 40		
DEFINE CELL NAME "S12_ATD" OF oSection12 TITLE STR0028 SIZE 10		
DEFINE CELL NAME "S12_ORC" OF oSection12 TITLE STR0029 SIZE 10		
DEFINE CELL NAME "S12_VLRORC" OF oSection12 TITLE STR0030 SIZE 20		
DEFINE CELL NAME "S12_FAT" OF oSection12 TITLE STR0031 SIZE 10		
DEFINE CELL NAME "S12_VLRFAT" OF oSection12	TITLE STR0030 SIZE 20	

Return(oReport)

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддддддбдддддддбддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁTkr024PrtRpt Ё Autor ЁMichel W. Mosca     Ё Data Ё14/08/2006Ё╠╠
╠╠Ё          Ё             Ё       Ё                    Ё      Ё          Ё╠╠
╠╠цддддддддддедддддддддддддадддддддаддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁRotina responsavel pela impressao do relatorio de           Ё╠╠
╠╠Ё          ЁAtendimentos realizados release 4.                          Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё Tkr024PrtRept(ExpO1,ExpC2,ExpC3)                           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ ExpO1 = objeto relatorio                                   Ё╠╠
╠╠Ё          Ё ExpC2 = alias da query atual                               Ё╠╠
╠╠Ё          Ё ExpC3 = alias da query atual                               Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function Tkr024PrtRpt(oReport, cSUA, cSUB)
Local oSection1 := oReport:Section(1)             //Objeto secao 1 do relatorio (Cabecalho, dados do atendimento)
Local oSection2 := oSection1:Section(1)           //Secao com itens relacionados ao atendimento
Local oSection2X := oSection2:Section(1)		  //secao com itens relacionados ao atendimento 2
Local oSection3 := oReport:Section(2)             //Secao com totalizadores do relatorio    
Local oSection4 := oReport:Section(3)             //Secao com totalizadores do relatorio    
Local oSection5 := oReport:Section(4)             //Secao com totalizadores do relatorio    
Local oSection6 := oReport:Section(5)             //Secao com totalizadores do relatorio    
Local oSection7 := oReport:Section(6)             //Secao com totalizadores do relatorio    
Local oSection8 := oReport:Section(7)             //Secao com totalizadores do relatorio    
Local oSection9 := oReport:Section(8)             //Secao com totalizadores do relatorio    
Local oSection10 := oReport:Section(9)            //Secao com totalizadores do relatorio    
Local oSection11 := oReport:Section(10)           //Secao com totalizadores do relatorio    
Local oSection12 := oReport:Section(11)           //Secao com totalizadores do relatorio    

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁDeclaracao de variaveis especificas para este relatorioЁ
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Local cCodSUA		:= ""						// Controla a quebra do cabecalho do atendimento
Local nI			:= 0						// Controle
Local nTotGer		:= 0						// Total dos atendimentos
Local aTotItem		:= {0,0,0,0}				// Total dos itens por atendimento
Local aTotOper		:= {}					    // Total por tipo de Operacao
Local aTotCamp		:= {}						// Total geral das campanhas
Local aTotMid		:= {}						// Total geral das midias
Local aTotProd		:= {}						// Total geral dos produtos 
Local aValOper		:= {}						// Total Orcados/Faturados por operador
Local aProdMid		:= {}						// Total Produtos vendidos por midia
Local aProdCamp     := {}						// Total Produtos vendidos por campanha
Local aDatOper		:= {}						// Total por data e por operador
Local aDatMid		:= {}						// Total por data e por midia
Local aDatCamp		:= {}						// Total por data e por campanha
Local cData			:= ""						// Para quebra de relatorio
Local lAtend		:= .T.						// Variavel de auxilio
Local lPula			:= .F.						// Variavel de auxilio	
Local nLen			:= 0						// Variavel de auxilio	
Local aUA_Oper		:= TkSx3Box("UA_OPER")		// Pesquisa as opcoes do campo no DD SX3
Local cQuery

cQuery :=	"% 	AND	SUA.UA_EMISSAO BETWEEN '" + DtoS(Mv_Par03) + "' AND '" + DtoS(Mv_Par04) + "' AND" +;
			" 		SUA.UA_OPERADO BETWEEN '" + Mv_Par01 + "' AND '" + Mv_Par02 + "' AND" +;
			" 		SUA.UA_MIDIA BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND" +;
			" 		SUA.UA_CANC = '' AND" +;
			" 		SUA.UA_TMK = '3' AND " +;	// Fax
			" 		(SUA.UA_OPER = '1' OR SUA.UA_OPER = '2')  "	// Orcamento - Faturamento
	
//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁSeleciono somente a campanha informada nos parametrosЁ
//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
If !Empty(Mv_Par07)
	cQuery +=	" AND	SUA.UA_CODCAMP = '" + Mv_Par07 + "' "
Endif
	
//зддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁSeleciono somente o tipo de entidade dos parametrosЁ
//юддддддддддддддддддддддддддддддддддддддддддддддддддды
If Mv_Par08 <> 3		// Ambos
	If Mv_Par08 == 1	// Clientes
		cQuery +=	" AND	SUA.UA_PROSPEC = 'F' "
	Else				// Prospects
		cQuery +=	" AND 	SUA.UA_PROSPEC = 'T' "
	Endif
Endif
	
cQuery +=	"%"

BEGIN REPORT QUERY oSection1
BeginSQL alias cSUA
	SELECT	UA_EMISSAO, 	UA_CODCONT, 		UA_NUM, 		UA_OPERADO, 
			UA_VEND, 		UA_CLIENTE, 		UA_MIDIA, 		UA_PROSPEC, 
			UA_LOJA, 		UA_CODCAMP, 		UA_CODLIG, 		UA_TABELA, 
			UA_OPER, 		UA_TMK, 			UA_TPFRETE, 	UA_PROXLIG, 
			UA_HRPEND, 		UA_CODOBS,			UB_ITEM, 		UB_PRODUTO, 
			UB_SITPROD, 	UB_QUANT, 			UB_VRUNIT, 		UB_VLRITEM, 
			UB_DESC, 		UB_VALDESC, 		UB_ACRE, 		UB_VALACRE, 
			UB_TES, 		UB_CF, 				UB_PRCTAB, 		UB_BASEICM, 
			UB_LOCAL, 		UB_UM, 				UB_DTENTRE, 	UB_LOTE, 	
			UB_SUBLOTE, 	UB_DTVALID,			UA_FILIAL
	FROM 	%table:SUA% SUA, %table:SUB% SUB
	WHERE	SUA.UA_FILIAL = %xFilial:SUA% 	AND
			SUB.UB_FILIAL = %xFilial:SUB% 	AND
			SUB.%notDel% 					AND
			SUA.%notDel%                   	AND
			SUA.UA_NUM = SUB.UB_NUM
			%exp:cQuery%
	ORDER BY %order:SUA%    
EndSql    
END REPORT QUERY oSection1  
oSection2:SetParentQuery()
oSection2X:SetParentQuery()

oSection1:Init()
While	(!Eof())							.AND.;
		(cSUA)->UA_FILIAL == xFilial("SUA")	.AND.;
		(cSUA)->UA_EMISSAO >=	Mv_Par03	.AND.;
		(cSUA)->UA_EMISSAO <=	Mv_Par04

	oReport:IncMeter()
	
	If oReport:Cancel()
		Exit
	EndIf	
	
	
	//зддддддддддддддддддддддддддддд©
	//ЁAvalia os parametros para DBFЁ
	//юддддддддддддддддддддддддддддды
	#IFNDEF TOP
		//здддддддддддддддддддддддддддддддддддддддддддд©
		//ЁSeleciona somente os atendimentos FAX       Ё
		//юдддддддддддддддддддддддддддддддддддддддддддды
		If (cSUA)->UA_TMK <> "3"
			DbSkip()
			Loop
		Endif
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁValida o intervalo de operadores informado nos parametrosЁ
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If (cSUA)->UA_OPERADO < Mv_Par01 .OR. (cSUA)->UA_OPERADO > Mv_Par02
			DbSkip()
			Loop
		Endif
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁValida o intervalo de midias informado nos parametrosЁ
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If (cSUA)->UA_MIDIA < Mv_Par05 .OR. (cSUA)->UA_MIDIA > Mv_Par06
			DbSkip()
			Loop
		Endif
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁSeleciono somente a campanha informada nos parametrosЁ
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !Empty(Mv_Par07) .AND. (cSUA)->UA_CODCAMP <> Mv_Par07
			DbSkip()
			Loop
		Endif

	
		//зддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁSeleciono somente o tipo de entidade dos parametrosЁ
		//юддддддддддддддддддддддддддддддддддддддддддддддддддды
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
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁSe mudou o registro de atendimento , totaliza os contadores e imprime o novo cabecalhoЁ
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If (cSUA)->UA_NUM <> cCodSUA
		If cCodSUA <> ""
			oSection2:Finish()
			oReport:EndPage()
		EndIf
		cCodSUA := (cSUA)->UA_NUM
		oSection1:SetLineStyle()		
		oSection1:PrintLine()
		oSection2:Init()  
		oSection2:SetLineBreak()
		oSection2X:Init()
		oSection2X:SetLineBreak()
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁImpressao dos itens do atendimento do Televendas.				   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		lAtend := .T. // Informa quando e um novo atendimento		

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁTotal geral dos atendimentos.                                       Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nTotGer++

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁTotal dos atendimentos por Campanha.  							   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPos := aScan(aTotCamp, {|x| x[1]==(cSUA)->UA_CODCAMP} )
		If nPos == 0
			aAdd(aTotCamp,{ (cSUA)->UA_CODCAMP												,;	// Codigo da campanha
							Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")	,;	// Descricao da campanha
			 				1																})	// Totalizador
		Else
			aTotCamp[nPos][3]++
		Endif

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁTotal dos atendimentos por Midia.  							       Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPos := aScan(aTotMid, {|x| x[1]==(cSUA)->UA_MIDIA} )
		If nPos == 0
			aAdd(aTotMid, {(cSUA)->UA_MIDIA													,;	// Tipo da midia	
							Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")	,;	// Descricao da midia			
			 				1																})	// Totalizador				
		Else
			aTotMid[nPos][3]++
		Endif		
	EndIf    
	
	#IFNDEF TOP
		DbSelectArea((cSUB))
		DbSetOrder(1)
		MSSeek(xFilial(cSUB) + (cSUA)->UA_NUM)
		While	(!Eof())								.AND.;
				(cSUB)->UB_FILIAL	==	xFilial(("SUB"))	.AND.;
				(cSUB)->UB_NUM		==	(cSUA)->UA_NUM
	#ENDIF
			
			oSection2:PrintLine()  
			oSection2X:PrintLine()
		
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotalizacao dos itens por atendimento.                              Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			aAdd(aTotItem, {aTotItem[1]	+=(cSUB)->UB_QUANT			,;	// Quantidade
							aTotItem[2]	+=(cSUB)->UB_VLRITEM		,;	// Valor por Item					
							aTotItem[3]	+=(cSUB)->UB_VALDESC		,;	// Valor do Desconto					
							aTotItem[4]	+=(cSUB)->UB_VALACRE		})	// Valor do Acrescimo
	
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotal em dinheiro por Tipo de Operacao (Faturamento ou Orcamento).  Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			nPos := aScan(aTotOper, {|x| x[1]==(cSUA)->UA_OPER} )
			If nPos == 0                                     
				aAdd(aTotOper,	 {(cSUA)->UA_OPER		,;	// Tipo de Operacao     
								 1						,;	// Total de Atendimentos
								 (cSUB)->UB_VLRITEM		}) 	// Total por Operacao
			Else
				If lAtend
					aTotOper[nPos][2]++
				Endif	
				aTotOper[nPos][3]+= (cSUB)->UB_VLRITEM
			Endif

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotal em dinheiro por Operador e por Tipo de Operacao.              Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			nPos := aScan(aValOper, {|x| x[1]==(cSUA)->UA_OPERADO} )
			If nPos == 0
				If	(cSUA)->UA_OPER == "2"	// Orcado
					aAdd(aValOper, 	{(cSUA)->UA_OPERADO												,;	// Codigo do Operador
									FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUA)->UA_OPERADO	,"U7_NOME"),"U7_NOME","TMKR024")	,;	// Descricao do operador
									1																,;	// Total de Atendimentos
									(cSUB)->UB_VLRITEM				                                ,;	// Valor Orcado
									1																,;  // Total de Atendimentos Orcados
									0																,;  // Valor Faturado 
									0																})  // Total de Atendimentos Faturados
				Else // Faturado
					aAdd(aValOper, 	{(cSUA)->UA_OPERADO												,;	// Codigo do Operador
									FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUA)->UA_OPERADO	,"U7_NOME"),"U7_NOME","TMKR024")	,;	// Descricao do operador
									1																,;	// Total de Atendimentos
									0								                                ,;	// Valor Orcado
									0																,;  // Total de Atendimentos Orcados
									(cSUB)->UB_VLRITEM												,;  // Valor Faturado 
									1																})  // Total de Atendimentos Faturados				
				Endif
			Else
				If lAtend
					aValOper[nPos][3]++
				Endif	
				If	(cSUA)->UA_OPER == "2"	// Orcado
					aValOper[nPos][4]+=(cSUB)->UB_VLRITEM
					If lAtend
						aValOper[nPos][5]++
					Endif	
				Else // Faturado
					aValOper[nPos][6]+=(cSUB)->UB_VLRITEM					
					If lAtend
						aValOper[nPos][7]++
					Endif	
				Endif
			Endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotal de cada produto vendido.                                      Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If (cSUA)->UA_OPER == "1"		// Faturamento
				nPos := aScan(aTotProd, {|x,y| x[1]==(cSUB)->UB_PRODUTO} )
				If nPos == 0
					aAdd(aTotProd, 	{(cSUB)->UB_PRODUTO												,;	// Codigo do produto
                        			Posicione("SB1",1,xFilial("SB1")+(cSUB)->UB_PRODUTO,"B1_DESC")	,;	// Descricao do produto
								 	(cSUB)->UB_QUANT												,;  // Quantidade do Produto
									(cSUB)->UB_VLRITEM												})	// Valor Total Vendido
				Else
					aTotProd[nPos][3]+=(cSUB)->UB_QUANT
					aTotProd[nPos][4]+=(cSUB)->UB_VLRITEM										
				Endif
			Endif

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotal de cada produto vendido por midia.                            Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If (cSUA)->UA_OPER == "1"		// Faturamento
				nPos := aScan(aProdMid, {|x,y| x[1]==(cSUB)->UB_PRODUTO .AND. x[3]==(cSUA)->UA_MIDIA} )
				If nPos == 0
					aAdd(aProdMid, 	{(cSUB)->UB_PRODUTO												,;	// Codigo do produto
                        			Posicione("SB1",1,xFilial("SB1")+(cSUB)->UB_PRODUTO,"B1_DESC")	,;	// Descricao do produto
								 	(cSUA)->UA_MIDIA												,;	// Codigo da midia
									Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")	,;	// Descricao da Midia								 	
								 	(cSUB)->UB_QUANT												,;  // Quantidade do Produto
									(cSUB)->UB_VLRITEM												})	// Valor Total Vendido
				Else
					aProdMid[nPos][5]+=(cSUB)->UB_QUANT
					aProdMid[nPos][6]+=(cSUB)->UB_VLRITEM										
				Endif
			Endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotal de cada produto vendido por campanha.                         Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If (cSUA)->UA_OPER == "1"		// Faturamento
				nPos := aScan(aProdCamp, {|x,y| x[1]==(cSUB)->UB_PRODUTO .AND. x[3]==(cSUA)->UA_CODCAMP} )
				If nPos == 0
					aAdd(aProdCamp,	{(cSUB)->UB_PRODUTO												,;	// Codigo do produto
                        			Posicione("SB1",1,xFilial("SB1")+(cSUB)->UB_PRODUTO,"B1_DESC")	,;	// Descricao do produto
								 	(cSUA)->UA_CODCAMP												,;	// Codigo da midia
									Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")	,;	// Descricao da campanha
								 	(cSUB)->UB_QUANT												,;  // Quantidade do Produto
									(cSUB)->UB_VLRITEM												})	// Valor Total Vendido
				Else
					aProdCamp[nPos][5]+=(cSUB)->UB_QUANT
					aProdCamp[nPos][6]+=(cSUB)->UB_VLRITEM										
				Endif
			Endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotal de orcamento e faturamento por data e por operador.           Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			nPos := aScan(aDatOper, {|x,y| x[1]==DtoS((cSUA)->UA_EMISSAO) .AND. x[2]==(cSUA)->UA_OPERADO} )
			If nPos == 0
				If	(cSUA)->UA_OPER == "2"	// Orcado
					aAdd(aDatOper,	{DtoS((cSUA)->UA_EMISSAO)										,;	// Data do Atendimento
                   	    			(cSUA)->UA_OPERADO												,;	// Codigo do operador
									FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUA)->UA_OPERADO	,"U7_NOME"),"U7_NOME","TMKR024")	,;	// Descricao do operador
									1																,;	// Total de Atendimentos
									(cSUB)->UB_VLRITEM				                                ,;	// Valor Orcado
									1																,;  // Total de Atendimentos Orcados
									0																,;  // Valor Faturado 
									0																})  // Total de Atendimentos Faturados
				Else // Faturado
					aAdd(aDatOper,	{DtoS((cSUA)->UA_EMISSAO)										,;	// Data do Atendimento
                   	    			(cSUA)->UA_OPERADO												,;	// Codigo do operador
									FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUA)->UA_OPERADO	,"U7_NOME"),"U7_NOME","TMKR024")	,;	// Descricao do operador
									1																,;	// Total de Atendimentos
									0								                                ,;	// Valor Orcado
									0																,;  // Total de Atendimentos Orcados
									(cSUB)->UB_VLRITEM												,;  // Valor Faturado 
									1																})  // Total de Atendimentos Faturados				
				Endif					
			Else
				If lAtend
					aDatOper[nPos][4]++
				Endif	
				If	(cSUA)->UA_OPER == "2"	// Orcado
					aDatOper[nPos][5]+=(cSUB)->UB_VLRITEM
					If lAtend
						aDatOper[nPos][6]++
					Endif	
				Else // Faturado
					aDatOper[nPos][7]+=(cSUB)->UB_VLRITEM					
					If lAtend
						aDatOper[nPos][8]++
					Endif	
				Endif
			Endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotal de orcamento e faturamento por data e por midia.              Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			nPos := aScan(aDatMid, {|x,y| x[1]==DtoS((cSUA)->UA_EMISSAO) .AND. x[2]==(cSUA)->UA_MIDIA} )
			If nPos == 0
				If	(cSUA)->UA_OPER == "2"	// Orcado
					aAdd(aDatMid,	{DtoS((cSUA)->UA_EMISSAO)										,;	// Data do Atendimento
                   	    			(cSUA)->UA_MIDIA												,;	// Codigo da midia
									Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")	,;	// Descricao da midia			
									1																,;	// Total de Atendimentos
									(cSUB)->UB_VLRITEM				                                ,;	// Valor Orcado
									1																,;  // Total de Atendimentos Orcados
									0																,;  // Valor Faturado 
									0																})  // Total de Atendimentos Faturados
				Else // Faturado
					aAdd(aDatMid,	{DtoS((cSUA)->UA_EMISSAO)										,;	// Data do Atendimento
                   	    			(cSUA)->UA_MIDIA												,;	// Codigo da midia
									Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC")	,;	// Descricao da midia			
									1																,;	// Total de Atendimentos
									0								                                ,;	// Valor Orcado
									0																,;  // Total de Atendimentos Orcados
									(cSUB)->UB_VLRITEM												,;  // Valor Faturado 
									1																})  // Total de Atendimentos Faturados				
				Endif					
			Else
				If lAtend
					aDatMid[nPos][4]++
				Endif	
				If	(cSUA)->UA_OPER == "2"	// Orcado
					aDatMid[nPos][5]+=(cSUB)->UB_VLRITEM
					If lAtend
						aDatMid[nPos][6]++
					Endif	
				Else // Faturado
					aDatMid[nPos][7]+=(cSUB)->UB_VLRITEM					
					If lAtend
						aDatMid[nPos][8]++
					Endif	
				Endif
			Endif

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTotal de orcamento e faturamento por data e por campanha.           Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			nPos := aScan(aDatCamp, {|x,y| x[1]==DtoS((cSUA)->UA_EMISSAO) .AND. x[2]==(cSUA)->UA_CODCAMP} )
			If nPos == 0
				If	(cSUA)->UA_OPER == "2"	// Orcado
					aAdd(aDatCamp,	{DtoS((cSUA)->UA_EMISSAO)										,;	// Data do Atendimento
									(cSUA)->UA_CODCAMP												,;	// Codigo da campanha
									Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")	,;	// Descricao da campanha
									1																,;	// Total de Atendimentos
									(cSUB)->UB_VLRITEM				                                ,;	// Valor Orcado
									1																,;  // Total de Atendimentos Orcados
									0																,;  // Valor Faturado 
									0																})  // Total de Atendimentos Faturados
				Else // Faturado
					aAdd(aDatCamp,	{DtoS((cSUA)->UA_EMISSAO)										,;	// Data do Atendimento
									(cSUA)->UA_CODCAMP												,;	// Codigo da campanha
									Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC")	,;	// Descricao da campanha
									1																,;	// Total de Atendimentos
									0								                                ,;	// Valor Orcado
									0																,;  // Total de Atendimentos Orcados
									(cSUB)->UB_VLRITEM												,;  // Valor Faturado 
									1																})  // Total de Atendimentos Faturados				
				Endif					
			Else
				If lAtend
					aDatCamp[nPos][4]++
				Endif					
				If	(cSUA)->UA_OPER == "2"	// Orcado
					aDatCamp[nPos][5]+=(cSUB)->UB_VLRITEM
					If lAtend
						aDatCamp[nPos][6]++
					Endif						
				Else // Faturado
					aDatCamp[nPos][7]+=(cSUB)->UB_VLRITEM					
					If lAtend
						aDatCamp[nPos][8]++
					Endif	
				Endif
			Endif

			lAtend := .F.		      

	#IFNDEF TOP
			DbSelectArea(cSUB)
			DbSkip()
		End         
	#ENDIF
		

	
   
	DbSelectArea(cSUA)
	DbSkip()
End             
If cCodSUA <> ""
	oSection2:Finish()
	oReport:EndPage()
EndIf
oSection1:Finish()


If nTotGer > 0
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁTotal por operacao.											   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды			
	aSort(aTotOper,,, {|x,y| x[3] > y[3]} )		// Coloca em ordem decrescente
	oSection3:Init()
	nLen := Len(aTotOper)
	For nI := 1 To nLen    	
		oSection3:Cell("S3_OPER"):SetValue(aUA_Oper[Val(aTotOper[nI][1])]) 			// Tipo de Operacao
		oSection3:Cell("S3_TOTAT"):SetValue(Transform(aTotOper[nI][2],'@E 999,999'))			// Total de Atendimentos
		oSection3:Cell("S3_TOTOP"):SetValue(Transform(aTotOper[nI][3],'@E 999,999,999.99'))	// Total por Operacao
		oSection3:PrintLine()
    Next nI
    oSection3:Finish()
    

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁTotal por Operador e por Tipo de Operacao.                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды			
	aSort(aValOper,,, {|x,y| x[3] > y[3]} )		// Coloca em ordem decrescente  
	oSection4:Init()	
	nLen :=	Len(aValOper)
	For nI := 1 To nLen
		oSection4:Cell("S4_OPER"):SetValue(aValOper[nI][1]+ " - " +  aValOper[nI][2])
		oSection4:Cell("S4_ATEND"):SetValue(Transform(aValOper[nI][3],'@E 999,999'))
		oSection4:Cell("S4_ORC"):SetValue(Transform(aValOper[nI][5],'@E 999,999'))
		oSection4:Cell("S4_VLRORC"):SetValue(Transform(aValOper[nI][4],'@E 999,999,999.99'))
		oSection4:Cell("S4_FAT"):SetValue(Transform(aValOper[nI][7],'@E 999,999'))
		oSection4:Cell("S4_VLR"):SetValue(Transform(aValOper[nI][6],'@E 999,999,999.99'))
		oSection4:PrintLine()
	Next nI
	oSection4:Finish()                                     

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁTotal por produto.  											   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды			
	aSort(aTotProd,,, {|x,y| x[4] > y[4]} )		// Coloca em ordem decrescente  
    oSection5:Init()	
	nLen := Len(aTotProd)
	For nI := 1 To nLen	
		oSection5:Cell("S5_PROD"):SetValue(aTotProd[nI][1] + " - " + aTotProd[nI][2])
		oSection5:Cell("S5_ATEND"):SetValue(Transform(aTotProd[nI][3],'@E 999,999'))
		oSection5:Cell("S5_PERC"):SetValue(Transform((aTotProd[nI][3]/nTotGer)*100, '@E 999.99'))
		oSection5:Cell("S5_VLR"):SetValue(Transform(aTotProd[nI][4],'@E 999,999,999.99'))
		oSection5:PrintLine()
	Next nI    
    oSection5:Finish()
           
    

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁTotal por midia.  											   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды			
	aSort(aTotMid,,, {|x,y| x[3] > y[3]} )		// Coloca em ordem decrescente  
	oSection6:Init()	
	nLen := Len(aTotMid)
	For nI := 1 To nLen
		oSection6:Cell("S6_MIDIA"):SetValue(aTotMid[nI][1] + " - " + aTotMid[nI][2])
		oSection6:Cell("S6_ATD"):SetValue(Transform(aTotMid[nI][3],'@E 999,999'))	// Total de Atendimentos		
		oSection6:Cell("S6_PERC"):SetValue(Transform((aTotMid[nI][3]/nTotGer)*100, '@E 999.99')) 		// Porcentagem		
		oSection6:PrintLine()
	Next nI    
	oSection6:Finish()    


	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁTotal de produtos vendidos por midia.    					   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды			
	aSort(aProdMid,,, {|x,y| x[6] > y[6] } )		// Coloca em ordem decrescente por valor
	oSection7:Init()	
	nLen := Len(aProdMid)
	For nI := 1 To nLen	
		oSection7:Cell("S7_PROD"):SetValue(aProdMid[nI][1] + " - " + aProdMid[nI][2]) 	// Descricao do produto
		oSection7:Cell("S7_MIDIA"):SetValue(aProdMid[nI][3] + " - " + aProdMid[nI][4])	// Descricao da midia
		oSection7:Cell("S7_QTDE"):SetValue(Transform(aProdMid[nI][5],'@E 999,999'))		// Quantidade de produtos
		oSection7:Cell("S7_VLR"):SetValue(Transform(aProdMid[nI][6],'@E 999,999,999.99'))	// Valor total Faturados
		oSection7:PrintLine()
	Next nI	
	oSection7:Finish()
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁTotal por campanha.											   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды			
	aSort(aTotCamp,,, {|x,y| x[3] > y[3]} )		// Coloca em ordem decrescente  
	oSection8:Init()
	nLen := Len(aTotCamp)
	For nI := 1 To nLen
		oSection8:Cell("S8_CPN"):SetValue(aTotCamp[nI][1] + " - " + aTotCamp[nI][2])	// Descricao da campanha
		oSection8:Cell("S8_ATD"):SetValue(Transform(aTotCamp[nI][3],'@E 999,999'))		// Total de Atendimentos		
		oSection8:Cell("S8_PERC"):SetValue(Transform((aTotCamp[nI][3]/nTotGer)*100, '@E 999.99'))// Porcentagem
		oSection8:PrintLine()
	Next nI                  
	oSection8:Finish()

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁTotal de produtos vendidos por campanha.    					   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды			
	aSort(aProdCamp,,, {|x,y| x[6] > y[6] } )		// Coloca em ordem decrescente por valor
	oSection9:Init()	
    nLen := Len(aProdCamp)
	For nI := 1 To nLen	
		oSection9:Cell("S9_PROD"):SetValue(aProdCamp[nI][1] + " - " + aProdCamp[nI][2]) 	// Descricao do produto
		oSection9:Cell("S9_CAMP"):SetValue(aProdCamp[nI][3] + " - " + aProdCamp[nI][4]) 	// Descricao da midia
		oSection9:Cell("S9_QTDE"):SetValue(Transform(aProdCamp[nI][5],'@E 999,999'))	// Quantidade de produtos
		oSection9:Cell("S9_VLR"):SetValue(Transform(aProdCamp[nI][6],'@E 999,999,999.99'))	// Valor total Faturados	
		oSection9:PrintLine()
	Next nI
	oSection9:Finish()	
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁImprime o total dos atendimentos por Data e Operador.     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aSort(aDatOper,,, {|x,y| x[1] < y[1] } )		// Coloca em ordem crescente por dia
	oSection10:Init()
	nLen := Len(aDatOper)
	For nI := 1 To nLen	
		oSection10:Cell("S10_DATA"):SetValue(StoD(aDatOper[nI][1]))
		oSection10:Cell("S10_OPER"):SetValue(aDatOper[nI][2] + " - " + aDatOper[nI][3])// Descricao do operador
		oSection10:Cell("S10_ATD"):SetValue(Transform(aDatOper[nI][4],'@E 999,999'))	// Total de Atendimentos
		oSection10:Cell("S10_ORC"):SetValue(Transform(aDatOper[nI][6],'@E 999,999'))		// Total de Atendimentos Orcados		
		oSection10:Cell("S10_VLRORC"):SetValue(Transform(aDatOper[nI][5],'@E 999,999,999.99'))	// Valor Orcado
		oSection10:Cell("S10_FAT"):SetValue(Transform(aDatOper[nI][8],'@E 999,999')) 	// Total de Atendimentos Faturados
		oSection10:Cell("S10_VLRFAT"):SetValue(Transform(aDatOper[nI][7],'@E 999,999,999.99'))	// Valor Faturado
		oSection10:PrintLine()
	Next nI
	oSection10:Finish()	
	lPula := .F.
	cData := ""	  
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁImprime o total dos atendimentos por Data e Midia.        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aSort(aDatMid,,, {|x,y| x[1] < y[1] } )		// Coloca em ordem crescente por dia
	oSection11:Init()
	nLen := Len(aDatMid)
	For nI := 1 To nLen
		oSection11:Cell("S11_DATA"):SetValue(StoD(aDatMid[nI][1]))
		oSection11:Cell("S11_MIDIA"):SetValue(aDatMid[nI][2] + " - " + aDatMid[nI][3]) 	// Descricao do operador
		oSection11:Cell("S11_ATD"):SetValue(Transform(aDatMid[nI][4],'@E 999,999'))		// Total de Atendimentos
		oSection11:Cell("S11_ORC"):SetValue(Transform(aDatMid[nI][6],'@E 999,999')) 	// Total de Atendimentos Orcados
		oSection11:Cell("S11_VLRORC"):SetValue(Transform(aDatMid[nI][5],'@E 999,999,999.99'))	// Valor Orcado
		oSection11:Cell("S11_FAT"):SetValue(Transform(aDatMid[nI][8],'@E 999,999')) 			// Total de Atendimentos Faturados
		oSection11:Cell("S11_VLRFAT"):SetValue(Transform(aDatMid[nI][7],'@E 999,999,999.99'))	// Valor Faturado 
		oSection11:PrintLine()		
	Next nI
	oSection11:Finish()
		
	lPula := .F.
	cData := ""
	       
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁImprime o total dos atendimentos por Data e Campanha.     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aSort(aDatCamp,,, {|x,y| x[1] < y[1] } )		// Coloca em ordem crescente por dia
	oSection12:Init()
	nLen := Len(aDatCamp)		
	For nI := 1 To nLen
		oSection12:Cell("S12_DATA"):SetValue(StoD(aDatCamp[nI][1]))
		oSection12:Cell("S12_CAMP"):SetValue(aDatCamp[nI][2] + " - " + aDatCamp[nI][3]) // Descricao do operador
		oSection12:Cell("S12_ATD"):SetValue(Transform(aDatCamp[nI][4],'@E 999,999'))	// Total de Atendimentos
		oSection12:Cell("S12_ORC"):SetValue(Transform(aDatCamp[nI][6],'@E 999,999')) 	// Total de Atendimentos Orcados
		oSection12:Cell("S12_VLRORC"):SetValue(Transform(aDatCamp[nI][5],'@E 999,999,999.99'))	// Valor Orcado
		oSection12:Cell("S12_FAT"):SetValue(Transform(aDatCamp[nI][8],'@E 999,999'))	// Total de Atendimentos Faturados
		oSection12:Cell("S12_VLRFAT"):SetValue(Transform(aDatCamp[nI][7],'@E 999,999,999.99'))			// Valor Faturado 
		oSection12:PrintLine()		
	Next nI
	oSection12:Finish()
		
	lPula := .F.
	cData := ""	
    
EndIf

Return(.T.)

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa funГЦo quando nЦo houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuАrio utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serЦo verificados.
    @param aFields, Array, Array com todos os Campos que serЦo verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteГЦo de dados.
	Remover essa funГЦo quando nЦo houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa funГЦo quando nЦo houver releases menor que 12.1.27

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
    FunГЦo que verifica se a melhoria de Dados Protegidos existe.

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