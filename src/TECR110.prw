/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR110.CH"
#INCLUDE "PROTHEUS.CH"
#include "report.ch"
Static cAutoPerg := "ATR110"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ TECR110  ณ Autor ณ Cleber Martinez       ณ Data ณ29.06.2006ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescriฦo ณRelatขrio de Plano de Movimentaฦo.                         ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณNenhum                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณNenhum                                                      ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   DATA   ณ Programador   ณManutencao efetuada                         ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ               ณ                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function TECR110()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ PARAMETROS                                                             ณ
//ณ MV_PAR01 : Cliente de     ?                                            ณ
//ณ MV_PAR02 : Cliente ate    ?                                            ณ
//ณ MV_PAR03 : Produto de     ?                                            ณ
//ณ MV_PAR04 : Produto ate    ?                                            ณ
//ณ MV_PAR05 : Data de        ?                                            ณ
//ณ MV_PAR06 : Data ate       ?                                            ณ
//ณ MV_PAR07 : Plano de       ?                                            ณ
//ณ MV_PAR08 : Plano ate      ?                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte("ATR110",.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInterface de impressaoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := Tcr110RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณTcr110RptDef บAutor  ณCleber Martinez     บ Data ณ  29/06/06   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para informar as celulas que serao utilizadas no rela-  บฑฑ
ฑฑบ          ณlatorio                                                        บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ TECR110 R4                                                    บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Tcr110RptDef()
Local oReport							// Objeto do relatorio
Local oSection1							// Objeto da secao 1
Local oSection2							// Objeto da secao 2
Local cAlias1	:= GetNextAlias()		// Pega o proximo Alias Disponivel
Local aOrdem	:= {}					// Ordens disponiveis para escolha do usuario
Local aChaves	:= {}					// Define as chaves de indexacao do arq. temporario

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine as ordens disponiveis para o usuario escolherณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Aadd( aOrdem, STR0012 ) // Cliente e Equipamento
Aadd( aOrdem, STR0013 ) // Cliente e Data
Aadd( aOrdem, STR0014 ) // Data e Cliente
Aadd( aOrdem, STR0015 ) // Data e Equipamento

aChaves := {	{"CODCLI+CODPRO+CODFAB+LOJAFA+NUMSER",  STR0012 },;
				{"CODCLI+DToS(DTMOV)", STR0013 },;
				{"DToS(DTMOV)+CODCLI", STR0014 },; 
				{"DToS(DTMOV)+CODPRO+CODFAB+LOJAFA+NUMSER", STR0015 } 	}
						 
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define a criacao do objeto oReport  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//"Movimentacao de Planos de Manutenฦo"  
//"Este relatorio ira imprimir a relacao de movimentacao"  
//"do plano de manutenฦo conforme os parametros solicitados"  
DEFINE REPORT oReport NAME "TECR110" TITLE STR0001 PARAMETER "ATR110" ACTION {|oReport| Tcr110PrtRpt(oReport, aChaves, cAlias1)} DESCRIPTION STR0002 + STR0003 + STR0004
    
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Define a secao1 do relatorio  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DEFINE SECTION oSection1 OF oReport TITLE STR0017 TABLES "AA3","ABE","SA1" ORDERS aOrdem	//"Cliente"
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Define as celulas que irao aparecer na secao1  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	            
		DEFINE CELL NAME "CODCLI" 	OF oSection1 ALIAS cAlias1 
		DEFINE CELL NAME "LOJA" 		OF oSection1 ALIAS cAlias1 
		DEFINE CELL NAME "NOMECLI" 	OF oSection1 ALIAS cAlias1 
		DEFINE CELL NAME "DTMOV" 	OF oSection1 ALIAS cAlias1 
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Define a secao2 do relatorio  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0018 TABLE "AA3","ABE","SB1"		//"Equipamento"
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Define as celulas que irao aparecer na secao2  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			DEFINE CELL NAME "CODPRO" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "NOMEPRO" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "FABRPRO" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "LOJAFA" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "NUMSER" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "DTMOV" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "CODCLI" 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "LOJA"	 	OF oSection2 ALIAS cAlias1 
			DEFINE CELL NAME "NOMECLI" 	OF oSection2 ALIAS cAlias1 

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Define a secao3 do relatorio  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		DEFINE SECTION oSection3 OF oSection2 TITLE STR0019 TABLE "ABE","AA3"	//"Plano"
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Define as celulas que irao aparecer na secao3  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			//Ordem 2 ou 3			             
			DEFINE CELL NAME "CODPRO" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "NOMEPRO" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "CODFAB" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "LOJAFA" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "NUMSER" 	OF oSection3 ALIAS cAlias1 
			// Ordem 1 ou 4
			DEFINE CELL NAME "PLANO" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "ITEM"	 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "DTMOV" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "DTORIG" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "SEQUEN" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "CODCLI" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "LOJA"  	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "NOMECLI" 	OF oSection3 ALIAS cAlias1 
			DEFINE CELL NAME "NUMOS" 	OF oSection3 ALIAS cAlias1 

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณTcr110PrtRptบAutor  ณCleber Martinez     บ Data ณ  30/06/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para impressao do relatorio personalizavel             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNenhum                                                      	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณoReport: Objeto TReport do relatorio personalizavel        	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ TECR100 R4                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Tcr110PrtRpt( oReport, aChaves, cAlias1 )
Local oSection1	:= oReport:Section(1)							// Define a secao 1 do relatorio
Local oSection2	:= oSection1:Section(1)							// Define que a secao 2 sera filha da secao 1
Local oSection3	:= oReport:Section(1):Section(1):Section(1)	// Define que a secao 2 sera filha da secao 1
Local cOrderBy	:= ""												// Ordem da query
Local nOrdem		:= 1												// Ordem definida pelo usuario
Local oBreak															// Obj. para definir quebra do relatorio

Default aChaves := {	{"CODCLI+CODPRO+CODFAB+LOJAFA+NUMSER",  STR0012 },;
				{"CODCLI+DToS(DTMOV)", STR0013 },;
				{"DToS(DTMOV)+CODCLI", STR0014 },; 
				{"DToS(DTMOV)+CODPRO+CODFAB+LOJAFA+NUMSER", STR0015 } 	}
				
Default cAlias1	:= GetNextAlias()
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
Tcr110SetCells(oSection1, oSection2, oSection3, nOrdem)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria quebra na secao1 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nOrdem == 1 .OR. nOrdem == 2
	oBreak := TRBreak():New(oSection1,oSection1:Cell("CODCLI"),STR0012,.F.) //"Cliente"
ElseIf nOrdem == 3 .OR. nOrdem == 4
	oBreak := TRBreak():New(oSection1,oSection1:Cell("DTMOV"),STR0014,.F.) //"Data"
EndIf

DbSelectArea("AA3")
DbSetOrder(1)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณTransforma parametros do tipo Range em expressao SQL para ser utilizada na query ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MakeSqlExpr("ATR110")

If nOrdem == 1
	cOrderBy := "% CODCLI, CODPRO, CODFAB, LOJAFA, NUMSER %"
ElseIf nOrdem == 2
	cOrderBy := "% CODCLI, DTMOV %"
ElseIf nOrdem == 3
	cOrderBy := "% DTMOV, CODCLI %"
ElseIf nOrdem == 4
	cOrderBy := "% DTMOV, CODPRO, CODFAB, LOJAFA, NUMSER %"
EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicializa a secao 1ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
BEGIN REPORT QUERY oSection1

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณQuery da secao 1ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BeginSql alias cAlias1

		COLUMN DTMOV AS DATE
		COLUMN DTORIG AS DATE

		SELECT	AA3.AA3_CODFAB CODFAB, AA3.AA3_LOJAFA LOJAFA, AA3.AA3_NUMSER NUMSER, AA3.AA3_CODPRO CODPRO,
		       AA3.AA3_CODCLI CODCLI, AA3.AA3_LOJA LOJA,     ABE_PLANO PLANO,       ABE.ABE_ITEM ITEM,
		       ABE.ABE_DATA DTMOV,    ABE.ABE_DTORIG DTORIG, ABE.ABE_SEQUEN SEQUEN, ABE.ABE_NUMOS NUMOS,
		       SA1.A1_NREDUZ NOMECLI, SB1.B1_DESC NOMEPRO,   SB1.B1_FABRIC FABRPRO
		  FROM %table:AA3% AA3, %table:ABE% ABE, %table:SB1% SB1, %table:SA1% SA1
		 WHERE AA3.AA3_FILIAL = %xfilial:AA3%
		   AND AA3.AA3_CODCLI >= %exp:MV_PAR01%
		   AND AA3.AA3_CODCLI <= %exp:MV_PAR02%
		   AND AA3.AA3_CODPRO >= %exp:MV_PAR03%
		   AND AA3.AA3_CODPRO <= %exp:MV_PAR04%
		   AND ABE.ABE_FILIAL =  %xfilial:ABE%
		   AND ABE.ABE_PLANO >= %exp:MV_PAR07%
		   AND ABE.ABE_PLANO <= %exp:MV_PAR08%
		   AND ABE.ABE_DATA >= %exp:DToS(MV_PAR05)%
		   AND ABE.ABE_DATA <= %exp:DToS(MV_PAR06)%
		   AND AA3.AA3_CODFAB = ABE.ABE_CODFAB
		   AND AA3.AA3_LOJAFA = ABE.ABE_LOJAFA
		   AND AA3.AA3_CODPRO = ABE.ABE_CODPRO
		   AND AA3.AA3_NUMSER = ABE.ABE_NUMSER
		   AND SB1.B1_FILIAL = %xfilial:SB1%
		   AND AA3.AA3_CODPRO = SB1.B1_COD
		   AND AA3.AA3_CODCLI = SA1.A1_COD
		   AND AA3.AA3_LOJA = SA1.A1_LOJA
		   AND AA3.%notDel%
		   AND ABE.%notDel%
		   AND SB1.%notDel%
		   AND SA1.%notDel%
		 ORDER BY %exp:cOrderBy%
	EndSql
	
END REPORT QUERY oSection1
      
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define que a secao 2 usara a mesma query da secao 1 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection2:SetParentQuery()
If nOrdem == 1 .OR. nOrdem == 2
	oSection2:SetParentFilter({|cParam| (cAlias1)->CODCLI + (cAlias1)->LOJA == cParam},{|| (cAlias1)->CODCLI + (cAlias1)->LOJA })
ElseIf nOrdem == 3 .OR. nOrdem == 4
	oSection2:SetParentFilter({|cParam| (cAlias1)->DTMOV  == cParam},{|| (cAlias1)->DTMOV })
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define que a secao 3 usara a mesma query da secao 2 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection3:SetParentQuery()
If nOrdem == 1
	oSection3:SetParentFilter({|cParam| (cAlias1)->CODPRO+(cAlias1)->CODFAB+(cAlias1)->LOJAFA+(cAlias1)->NUMSER == cParam},{|| (cAlias1)->CODPRO+(cAlias1)->CODFAB+(cAlias1)->LOJAFA+(cAlias1)->NUMSER })
ElseIf nOrdem == 2
	oSection3:SetParentFilter({|cParam| (cAlias1)->CODCLI + (cAlias1)->LOJA + DTOS((cAlias1)->DTMOV) == cParam},{|| (cAlias1)->CODCLI + (cAlias1)->LOJA + DTOS((cAlias1)->DTMOV) })
ElseIf nOrdem == 3
	oSection3:SetParentFilter({|cParam| DTOS((cAlias1)->DTMOV) + (cAlias1)->CODCLI + (cAlias1)->LOJA  == cParam},{|| DTOS((cAlias1)->DTMOV) + (cAlias1)->CODCLI + (cAlias1)->LOJA })
ElseIf nOrdem == 4
	oSection3:SetParentFilter({|cParam| DTOS((cAlias1)->DTMOV) + (cAlias1)->CODPRO + (cAlias1)->CODFAB + (cAlias1)->LOJAFA + (cAlias1)->NUMSER == cParam},{|| DTOS((cAlias1)->DTMOV) + (cAlias1)->CODPRO + (cAlias1)->CODFAB + (cAlias1)->LOJAFA + (cAlias1)->NUMSER })
EndIf

oReport:PrintText(STR0016+aChaves[nOrdem,2],,oSection1:Cell("CODCLI"):ColPos()) //"Movimentacao de Planos - Quebra por "
oReport:PrintText("",,oSection1:Cell("CODCLI"):ColPos())
If !isBlind()
	oSection1:Print()
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณTcr110SetCelบAutor  ณCleber Martinez     บ Data ณ  30/06/06   บฑฑ
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
ฑฑบUso       ณ TECR100 R4                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Tcr110SetCells(oSection1, oSection2, oSection3, nOrdem)

oSection1:Cell("CODCLI"):GetFieldInfo("A1_COD")
oSection1:Cell("LOJA"):GetFieldInfo("A1_LOJA")
oSection1:Cell("NOMECLI"):GetFieldInfo("A1_NREDUZ") 
oSection1:Cell("DTMOV"):GetFieldInfo("ABE_DATA") 

oSection2:Cell("CODPRO"):GetFieldInfo("AA3_CODPRO")
oSection2:Cell("NOMEPRO"):GetFieldInfo("B1_DESC")
oSection2:Cell("FABRPRO"):GetFieldInfo("B1_FABRIC")
oSection2:Cell("LOJAFA"):GetFieldInfo("AA3_LOJAFA") 
oSection2:Cell("NUMSER"):GetFieldInfo("AA3_NUMSER")
oSection2:Cell("DTMOV"):GetFieldInfo("ABE_DATA")
oSection2:Cell("CODCLI"):GetFieldInfo("AA3_CODCLI")
oSection2:Cell("LOJA"):GetFieldInfo("AA3_LOJA")
oSection2:Cell("NOMECLI"):GetFieldInfo("A1_NREDUZ") 

oSection3:Cell("CODPRO"):GetFieldInfo("AA3_CODPRO")
oSection3:Cell("NOMEPRO"):GetFieldInfo("B1_DESC")
oSection3:Cell("CODFAB"):GetFieldInfo("AA3_CODFAB")
oSection3:Cell("LOJAFA"):GetFieldInfo("AA3_LOJAFA")                  
oSection3:Cell("NUMSER"):GetFieldInfo("AA3_NUMSER")
oSection3:Cell("PLANO"):GetFieldInfo("ABE_PLANO") 
oSection3:Cell("ITEM"):GetFieldInfo("ABE_ITEM") 
oSection3:Cell("DTMOV"):GetFieldInfo("ABE_DATA") 
oSection3:Cell("DTORIG"):GetFieldInfo("ABE_DTORIG") 
oSection3:Cell("SEQUEN"):GetFieldInfo("ABE_SEQUEN") 
oSection3:Cell("CODCLI"):GetFieldInfo("AA3_CODCLI") 
oSection3:Cell("LOJA"):GetFieldInfo("AA3_LOJA") 
oSection3:Cell("NOMECLI"):GetFieldInfo("A1_NREDUZ") 
oSection3:Cell("NUMOS"):GetFieldInfo("ABE_NUMOS") 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Habilita/desabilita as celulas a imprimir conforme a Ordem  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nOrdem == 1

	oSection1:Cell("DTMOV"):Disable()                  
	
	oSection2:Cell("DTMOV"):Disable()
	oSection2:Cell("CODCLI"):Disable()            
	oSection2:Cell("LOJA"):Disable()                  
	oSection2:Cell("NOMECLI"):Disable()                  
	
	oSection3:Cell("CODCLI"):Disable()            
	oSection3:Cell("LOJA"):Disable()                  
	oSection3:Cell("NOMECLI"):Disable()           		
	oSection3:Cell("CODPRO"):Disable()           		
	oSection3:Cell("NOMEPRO"):Disable()           				
	oSection3:Cell("CODFAB" ):Disable()           				
	oSection3:Cell("LOJAFA"):Disable()           				
	oSection3:Cell("NUMSER"):Disable()

ElseIf nOrdem == 2 

	oSection1:Cell("DTMOV"):Disable()                        
	
	oSection2:Cell("CODPRO"):Disable()                        		
	oSection2:Cell("NOMEPRO"):Disable()                        		
	oSection2:Cell("FABRPRO"):Disable()  
	oSection2:Cell("LOJAFA"):Disable()                        		
	oSection2:Cell("NUMSER"):Disable()                        		
	oSection2:Cell("CODCLI"):Disable()                        		
	oSection2:Cell("LOJA"):Disable()                        		
	oSection2:Cell("NOMECLI"):Disable()               
	
	oSection3:Cell("CODCLI"):Disable()           		
	oSection3:Cell("LOJA"):Disable()           				
	oSection3:Cell("NOMECLI"):Disable()           				
	oSection3:Cell("DTMOV"):Disable()           				         		

ElseIf nOrdem == 3

	oSection1:Cell("CODCLI"):Disable()		
	oSection1:Cell("LOJA"):Disable()
	oSection1:Cell("NOMECLI"):Disable()
	
	oSection2:Cell("DTMOV"):Disable()                        
	oSection2:Cell("CODPRO"):Disable()                        		
	oSection2:Cell("NOMEPRO"):Disable()                        		
	oSection2:Cell("FABRPRO"):Disable()                        		
	oSection2:Cell("LOJAFA"):Disable()                        		
	oSection2:Cell("NUMSER"):Disable()                        				
	
	oSection3:Cell("CODCLI"):Disable()           		
	oSection3:Cell("LOJA"):Disable()           				
	oSection3:Cell("NOMECLI"):Disable()           				
	oSection3:Cell("DTMOV"):Disable()           				
	
ElseIf nOrdem == 4

	oSection1:Cell("CODCLI"):Disable()		
	oSection1:Cell("LOJA"):Disable()
	oSection1:Cell("NOMECLI"):Disable()          
	
	oSection2:Cell("DTMOV"):Disable()
	oSection2:Cell("CODCLI"):Disable()            
	oSection2:Cell("LOJA"):Disable()                  
	oSection2:Cell("NOMECLI"):Disable()               
	
	oSection3:Cell("CODPRO"):Disable()
	oSection3:Cell("NOMEPRO"):Disable()
	oSection3:Cell("CODFAB" ):Disable()           				
	oSection3:Cell("LOJAFA"):Disable()   
	oSection3:Cell("NUMSER"):Disable()		   		
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

Return Tcr110RptDef()

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

Return Tcr110PrtRpt( oReport )

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