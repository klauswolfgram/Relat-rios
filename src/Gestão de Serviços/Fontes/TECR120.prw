/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR120.CH"
#INCLUDE "PROTHEUS.CH"
#include "report.ch"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR120"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ TECR120  ณ Autor ณ Cleber Martinez       ณ Data ณ06.07.2006ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescriฦo ณ Relatขrio de Pendencias do equipamento                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ Nenhum                                                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum                                                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   DATA   ณ Programador   ณManutencao efetuada                         ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ               ณ                                            ณฑฑ
ฑฑณ          ณ               ณ                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TECR120()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ PARAMETROS                                                             ณ
//ณ nOrdem : Tipo de Quebra ?                                              ณ
//ณ MV_PAR01 : Cliente de     ?                                            ณ
//ณ MV_PAR02 : Cliente ate    ?                                            ณ
//ณ MV_PAR03 : Produto de     ?                                            ณ
//ณ MV_PAR04 : Produto ate    ?                                            ณ
//ณ MV_PAR05 : Data de        ?                                            ณ
//ณ MV_PAR06 : Data ate       ?                                            ณ
//ณ MV_PAR07 : Ocorrencia de  ?                                            ณ
//ณ MV_PAR08 : Ocorrencia ate ?                                            ณ
//ณ MV_PAR09 : Grupo de       ?                                            ณ
//ณ MV_PAR10 : Grupo Ate      ?                                            ณ
//ณ MV_PAR11 : Exibe          ? 1 - Pendentes / 2 - Baixados / 3 - Ambos   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte("ATR120",.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInterface de impressaoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := Tcr120RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณTcr120RptDef บAutor  ณCleber Martinez     บ Data ณ  07/07/06   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para informar as celulas que serao utilizadas no rela-  บฑฑ
ฑฑบ          ณlatorio                                                        บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ TECR120 R4                                                    บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Tcr120RptDef()
Local oReport							// Objeto do relatorio
Local oSection1						// Objeto da secao 1
Local oSection2						// Objeto da secao 2
Local cAlias1	:= GetNextAlias()		// Pega o proximo Alias Disponivel
Local aOrdem	:= {}					// Ordens disponiveis para escolha do usuario
Local aChaves	:= {}					// Define as chaves de indexacao do arq. temporario
Local lQuery	:= .T.					// Indica se esta em ambiente TopConnect

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine as ordens disponiveis para o usuario escolherณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Aadd( aOrdem, STR0018 ) // Cliente e Equipamento
Aadd( aOrdem, STR0019 ) // Cliente e Data
Aadd( aOrdem, STR0020 ) // Data e Cliente
Aadd( aOrdem, STR0021 ) // Data e Equipamento

aChaves := {	{"CODCLI+CODPRO+CODFAB+LOJAFA+NUMSER", STR0018 },; 			// "Cliente e Equipamento"
				{"CODCLI+DToS(DTEMIS)", STR0019 },;                      	// "Cliente e Data"
				{"DToS(DTEMIS)+CODCLI", STR0020 },;                       	// "Data e Cliente"
				{"DToS(DTEMIS)+CODPRO+CODFAB+LOJAFA+NUMSER", STR0021 } } 	// "Data e Equipamento
	 
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a criacao do objeto oReport  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//"Pendencias da Base Instalada"
//"Este relatorio ira imprimir a relacao de pendencias"
//"da Base Instalada"
DEFINE REPORT oReport NAME "TECR120" TITLE STR0001 PARAMETER "ATR120" ACTION {|oReport| Tcr120PrtRpt(oReport, aChaves, cAlias1)} DESCRIPTION STR0002 + STR0003 + STR0004
    
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Define a secao1 do relatorio  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DEFINE SECTION oSection1 OF oReport TITLE STR0025 TABLES cAlias1,"AA3","ABD","SA1" ORDERS aOrdem //"Cliente"
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Define as celulas que irao aparecer na secao1  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	            
		DEFINE CELL NAME "CODCLI" 	OF oSection1 ALIAS cAlias1 SIZE 8 TITLE STR0024 //"Cliente/Lj" 
		DEFINE CELL NAME "NOMECLI" 	OF oSection1 ALIAS cAlias1 
		DEFINE CELL NAME "DTEMIS" 	OF oSection1 ALIAS cAlias1 
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Define a secao2 do relatorio  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0026 TABLE cAlias1,"AA3","ABD","SB1"	//"Equipamento"
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Define as celulas que irao aparecer na secao2  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			DEFINE CELL NAME "CODPRO" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "NOMEPRO" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "FABRPRO" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "LOJAFA" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "NUMSER" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "DTEMIS" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "CODCLI" 	OF oSection2 ALIAS cAlias1 SIZE 8 TITLE STR0024 //"Cliente/Lj" 
			DEFINE CELL NAME "NOMECLI" 	OF oSection2 ALIAS cAlias1 

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Define a secao3 do relatorio  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		DEFINE SECTION oSection3 OF oSection2 TITLE STR0027 TABLE cAlias1,"ABD","AA3","AAG"	//"Dados Pend๊ncia"
			DEFINE CELL NAME "DESCRI" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "CODPRB" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "DESPRB"  	OF oSection3 ALIAS cAlias1 BLOCK {|| IIf(lQuery,AAG->AAG_DESCRI,(cAlias1)->DESPRB) }
			DEFINE CELL NAME "CODCLI" 	OF oSection3 ALIAS cAlias1 SIZE 8 TITLE STR0024 //"Cliente/Lj" 
			DEFINE CELL NAME "NOMECLI" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "DTEMIS" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "STATUS" 	OF oSection3 ALIAS cAlias1 	
			DEFINE CELL NAME "DATABX" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "CODPRO" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "NOMEPRO" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "FABRPRO" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "LOJAFA" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "CODMEM" 	OF oSection3 ALIAS cAlias1 SIZE 150 TITLE STR0016 BLOCK {|| MSMM(CODMEM) } //"Detalhes"
			
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณTcr120PrtRptบAutor  ณCleber Martinez     บ Data ณ  07/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para impressao do relatorio personalizavel             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNenhum                                                      	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณoReport: Objeto TReport do relatorio personalizavel        	บฑฑ
ฑฑบ          ณaChaves: Array com as chaves de ordenacao                  	บฑฑ
ฑฑบ          ณcAlias1: Alias da tabela usada no relatorio                	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ TECR120 R4                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ   DATA   ณ Programador   ณManutencao efetuada                           บฑฑ
ฑฑฬออออออออออุอออออออออออออออุออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ 28/05/07 ณ Conrado Q.    ณBops 125635 - Adicionado TRPosition para a    บฑฑ
ฑฑบ          ณ               ณtabela AA3, pois ao personalizar ocorria erro.บฑฑ
ฑฑศออออออออออฯอออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Tcr120PrtRpt( oReport, aChaves, cAlias1 )
Local oSection1	:= oReport:Section(1)							// Define a secao 1 do relatorio
Local oSection2	:= oSection1:Section(1)							// Define que a secao 2 sera filha da secao 1
Local oSection3	:= oReport:Section(1):Section(1):Section(1)	// Define que a secao 2 sera filha da secao 1
Local cOrderBy	:= ""												// Ordem da query
Local nOrdem		:= 1												// Ordem definida pelo usuario
Local oBreak															// Obj. para definir quebra do relatorio
Local aPendenc	:= { { "( '1', ' ' )"     , "1| "   },;
					     { "( '2' )"          , "2"     },;	
					     { "( '1', '2', ' ' )", "1|2| " } }
Local cWherePend	:= ""		//Condicao a ser adicionada na clausula WHERE
Local cDbMs		:= ""		//Nome do BD
Local cSelect		:= ""		//Campos a adicionar na query

Default cAlias1	:= GetNextAlias()
Default aChaves := {	{"CODCLI+CODPRO+CODFAB+LOJAFA+NUMSER", STR0018 },; 			// "Cliente e Equipamento"
				{"CODCLI+DToS(DTEMIS)", STR0019 },;                      	// "Cliente e Data"
				{"DToS(DTEMIS)+CODCLI", STR0020 },;                       	// "Data e Cliente"
				{"DToS(DTEMIS)+CODPRO+CODFAB+LOJAFA+NUMSER", STR0021 } } 	// "Data e Equipamento

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Pega a ordem escolhida pelo usuario ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nOrdem := oSection1:GetOrder()
If nOrdem <= 0
	nOrdem := 1
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Configura as celulas de acordo com os campos do SX3 ณ
//ณ e habilita/desabilita celulas conforme a ordem      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Tcr120SetCells(oSection1, oSection2, oSection3, nOrdem)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria quebra na secao1 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nOrdem == 1 .OR. nOrdem == 2
	oBreak := TRBreak():New(oSection1,oSection1:Cell("CODCLI"),STR0018,.F.) //"Cliente"
ElseIf nOrdem == 3 .OR. nOrdem == 4
	oBreak := TRBreak():New(oSection1,oSection1:Cell("DTEMIS"),STR0020,.F.) //"Data"
EndIf

DbSelectArea("AA3")
DbSetOrder(1)
        
cDbMs	:= UPPER(TcGetDb())
	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTransforma parametros do tipo Range em expressao SQL para ser utilizada na query ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MakeSqlExpr("ATR120")

cWherePend := "% ABD_STATUS IN " + aPendenc[mv_par11,1] + " %"
    
If cDbMs $ "MSSQL"
	cSelect := "% AA3_CODCLI+AA3_LOJA CODCLI, %"
Else
	cSelect := "% AA3_CODCLI||AA3_LOJA CODCLI, %"
EndIf
	 
If nOrdem == 1
	cOrderBy := "% CODCLI, CODPRO, CODFAB, LOJAFA, NUMSER %"
ElseIf nOrdem == 2
	cOrderBy := "% CODCLI, DTEMIS %"
ElseIf nOrdem == 3
	cOrderBy := "% DTEMIS, CODCLI %"
ElseIf nOrdem == 4
	cOrderBy := "% DTEMIS, CODPRO, CODFAB, LOJAFA, NUMSER %"
EndIf
    
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicializa a secao 1ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
BEGIN REPORT QUERY oSection1

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณQuery da secao 1ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BeginSql alias cAlias1
	
		SELECT DISTINCT AA3_CODFAB CODFAB, AA3_LOJAFA LOJAFA, AA3_NUMSER NUMSER, AA3_CODPRO CODPRO,
				%exp:cSelect% ABD_CODPRB CODPRB, ABD_DATA DTEMIS,
				ABD_DESCRI DESCRI, ABD_CODMEM CODMEM, ABD_STATUS STATUS, ABD_DATABX DATABX,
				A1_NREDUZ NOMECLI, B1_DESC NOMEPRO, B1_FABRIC FABRPRO

			FROM %table:SB1% SB1, %table:AA3% AA3, 
				%table:ABD% ABD,  %table:SA1% SA1

			WHERE AA3_FILIAL = %xfilial:AA3%       AND
			      AA3_CODCLI >= %exp:mv_par01%     AND
			      AA3_CODCLI <= %exp:mv_par02%     AND
			      AA3_CODPRO >= %exp:mv_par03%     AND
			      AA3_CODPRO <= %exp:mv_par04%     AND
			      ABD_FILIAL = %xfilial:ABD%       AND
			      ABD_CODPRB >= %exp:mv_par07%     AND
			      ABD_CODPRB <= %exp:mv_par08%     AND
			      ABD_DATA >= %exp:DToS(mv_par05)% AND
			      ABD_DATA <= %exp:DToS(mv_par06)% AND
			      %exp:cWherePend%                 AND
			      B1_FILIAL = %xfilial:SB1%        AND
			      B1_GRUPO >= %exp:mv_par09%       AND
			      B1_GRUPO <= %exp:mv_par10%       AND
		 	      AA3_CODFAB = ABD_CODFAB          AND
			      AA3_LOJAFA = ABD_LOJAFA          AND
			      AA3_CODPRO = ABD_CODPRO          AND
			      AA3_NUMSER = ABD_NUMSER          AND
			      AA3_CODPRO = B1_COD              AND
			      AA3_CODCLI = A1_COD              AND
			      AA3_LOJA = A1_LOJA               AND
			      AA3.%notDel%                     AND
			      ABD.%notDel%                     AND
			      SB1.%notDel%

			ORDER BY %exp:cOrderBy%
	EndSql
	
	END REPORT QUERY oSection1 
	
	If !(cAlias1)->(Eof())

		TCSetField( cAlias1, "DTEMIS", "D", 8, 0 )
		TCSetField( cAlias1, "DATABX", "D", 8, 0 )   
			
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Define que a secao 2 usara a mesma query da secao 1 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oSection2:SetParentQuery()
		If nOrdem == 1 .OR. nOrdem == 2
			oSection2:SetParentFilter({|cParam| (cAlias1)->CODCLI == cParam},{|| (cAlias1)->CODCLI })
		ElseIf nOrdem == 3 .OR. nOrdem == 4
			oSection2:SetParentFilter({|cParam| (cAlias1)->DTEMIS  == cParam},{|| (cAlias1)->DTEMIS })
		EndIf
	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Define que a secao 3 usara a mesma query da secao 2 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oSection3:SetParentQuery()
		If nOrdem == 1 
			oSection3:SetParentFilter({|cParam| (cAlias1)->CODPRO+(cAlias1)->CODFAB+(cAlias1)->LOJAFA+(cAlias1)->NUMSER == cParam},{|| (cAlias1)->CODPRO+(cAlias1)->CODFAB+(cAlias1)->LOJAFA+(cAlias1)->NUMSER })
		ElseIf nOrdem == 2	
			oSection3:SetParentFilter({|cParam| (cAlias1)->DTEMIS == cParam},{|| (cAlias1)->DTEMIS })	
		ElseIf nOrdem == 3
			oSection3:SetParentFilter({|cParam| (cAlias1)->CODCLI == cParam},{|| (cAlias1)->CODCLI })
		ElseIf nOrdem == 4
			oSection3:SetParentFilter({|cParam| (cAlias1)->CODPRO + (cAlias1)->CODFAB + (cAlias1)->LOJAFA + (cAlias1)->NUMSER == cParam},{|| (cAlias1)->CODPRO + (cAlias1)->CODFAB + (cAlias1)->LOJAFA + (cAlias1)->NUMSER })
		EndIf
	    
		TRPosition():New(oSection3,"AAG",1,{|| xFilial("AAG")+(cAlias1)->CODPRB })
	    
		oReport:PrintText(STR0001+STR0017+aChaves[nOrdem,2],,oSection1:Cell("CODCLI"):ColPos()) 
		oReport:PrintText("",,oSection1:Cell("CODCLI"):ColPos())
		oSection3:SetLineBreak()
		If !isBlind()
			oSection1:Print()
		EndIf
	EndIf	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณTcr120SetCelบAutor  ณCleber Martinez     บ Data ณ  10/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณConfigura as celulas de acordo com o SX3 e                    บฑฑ
ฑฑบ          ณhabilita/desabilita as celulas a imprimir conf. a Ordem       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNenhum                                                      	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณoSection1: Obj. Secao 1 do relatorio                       	บฑฑ
ฑฑบ          ณoSection2: Obj. Secao 2 do relatorio                         	บฑฑ
ฑฑบ          ณoSection3: Obj. Secao 3 do relatorio                         	บฑฑ
ฑฑบ          ณnOrdem: Ordem selecionada pelo usuario                     	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ TECR120 R4                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Tcr120SetCells(oSection1, oSection2, oSection3, nOrdem)

oSection1:Cell("NOMECLI"):GetFieldInfo("A1_NREDUZ")
oSection1:Cell("DTEMIS"):GetFieldInfo("ABD_DATA")

oSection2:Cell("CODPRO"):GetFieldInfo("AA3_CODPRO")
oSection2:Cell("NOMEPRO"):GetFieldInfo("B1_DESC")
oSection2:Cell("FABRPRO"):GetFieldInfo("B1_FABRIC")
oSection2:Cell("LOJAFA"):GetFieldInfo("AA3_LOJAFA")
oSection2:Cell("NUMSER"):GetFieldInfo("AA3_NUMSER")
oSection2:Cell("DTEMIS"):GetFieldInfo("ABD_DATA")
oSection2:Cell("NOMECLI"):GetFieldInfo("A1_NREDUZ")

oSection3:Cell("DESCRI"):GetFieldInfo("ABD_DESCRI")
oSection3:Cell("CODPRB"):GetFieldInfo("ABD_CODPRB")
oSection3:Cell("DESPRB"):GetFieldInfo("AAG_DESCRI")
oSection3:Cell("NOMECLI"):GetFieldInfo("A1_NREDUZ")
oSection3:Cell("DTEMIS"):GetFieldInfo("ABD_DATA")
oSection3:Cell("STATUS"):GetFieldInfo("ABD_STATUS")
oSection3:Cell("DATABX"):GetFieldInfo("ABD_DATABX")
oSection3:Cell("CODPRO"):GetFieldInfo("AA3_CODPRO")
oSection3:Cell("NOMEPRO"):GetFieldInfo("B1_DESC")
oSection3:Cell("FABRPRO"):GetFieldInfo("B1_FABRIC")
oSection3:Cell("LOJAFA"):GetFieldInfo("AA3_LOJAFA")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Habilita/desabilita as celulas a imprimir conforme a Ordem  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nOrdem == 1

	oSection1:Cell("DTEMIS"):Disable()
	
	oSection2:Cell("DTEMIS"):Disable()
	oSection2:Cell("CODCLI"):Disable()
	oSection2:Cell("NOMECLI"):Disable()
	
	oSection3:Cell("CODCLI"):Disable()
	oSection3:Cell("NOMECLI"):Disable()
	oSection3:Cell("CODPRO"):Disable()
	oSection3:Cell("NOMEPRO"):Disable()
	oSection3:Cell("FABRPRO"):Disable()
	oSection3:Cell("LOJAFA"):Disable()

ElseIf nOrdem == 2

	oSection1:Cell("DTEMIS"):Disable()
	
	oSection2:Cell("CODPRO"):Disable()
	oSection2:Cell("NOMEPRO"):Disable()
	oSection2:Cell("FABRPRO"):Disable()
	oSection2:Cell("LOJAFA"):Disable()
	oSection2:Cell("NUMSER"):Disable()
	oSection2:Cell("CODCLI"):Disable()
	oSection2:Cell("NOMECLI"):Disable()
	
	oSection3:Cell("CODCLI"):Disable()
	oSection3:Cell("NOMECLI"):Disable()
	oSection3:Cell("DTEMIS"):Disable()

ElseIf nOrdem == 3

	oSection1:Cell("CODCLI"):Disable()
	oSection1:Cell("NOMECLI"):Disable()
	
	oSection2:Cell("DTEMIS"):Disable()
	oSection2:Cell("CODPRO"):Disable()
	oSection2:Cell("NOMEPRO"):Disable()
	oSection2:Cell("FABRPRO"):Disable()
	oSection2:Cell("LOJAFA"):Disable()
	oSection2:Cell("NUMSER"):Disable()
	
	oSection3:Cell("CODCLI"):Disable()
	oSection3:Cell("NOMECLI"):Disable()
	oSection3:Cell("DTEMIS"):Disable()
	
ElseIf nOrdem == 4

	oSection1:Cell("CODCLI"):Disable()
	oSection1:Cell("NOMECLI"):Disable()

	oSection2:Cell("DTEMIS"):Disable()
	oSection2:Cell("CODCLI"):Disable()
	oSection2:Cell("NOMECLI"):Disable()

	oSection3:Cell("CODPRO"):Disable()
	oSection3:Cell("NOMEPRO"):Disable()
	oSection3:Cell("FABRPRO"):Disable()
	oSection3:Cell("LOJAFA"):Disable()
	oSection3:Cell("DTEMIS"):Disable()

EndIf
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Monta as defini็oes do relatorio.
Chamada utilizada na automa็ใo de c๓digo.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()

Return Tcr120RptDef()

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Chama a fun็ใo ReportPrint
Chamada utilizada na automa็ใo de c๓digo.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport ( oReport )

Return Tcr120PrtRpt( oReport )

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relat๓rio
Fun็ใo utilizada na automa็ใo
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg