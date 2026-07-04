/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR034.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TMKDEF.CH"
#INCLUDE "REPORT.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ Tmkr034  ณ Autor ณ Rafael M. Quadrotti   ณ Data ณ 22.06.01 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณRelatorio de atendimento telemarketing                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ U_TMKR034(void)                                              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ ANALISTA     ณ DATA   ณ BOPS ณ  MOTIVO DA ALTERACAO                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณHanna Carolineณ03/08/06ณR4    ณRelatorio Personalizavel                ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function TMKR034()

Local oReport						//Objeto do relatorio
Local aArea := GetArea()			//Area atual para restauracao posterior 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                                         ณ
//ณ Mv_Par01           // Entidade                                               ณ
//ณ Mv_Par02           // Tipo Atendimento ( 1-ATIVO 2-RECEPTIVO 3-AMBOS )       ณ
//ณ Mv_Par03           // Status ( 1-PLANEJADA 2-PENDENTE 3-ENCERRADAS 4-TODAS ) ณ
//ณ Mv_Par04           // Da Data                                                ณ
//ณ Mv_Par05           // Ate a Data                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte("TMK034",.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInterface de impressaoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณHanna               บ Data ณ  03/08/06   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para informar as celulas que serao utilizadas no rela-  บฑฑ
ฑฑบ          ณlatorio                                                        บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ TMKR034                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออหอออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAnalista  ณ Data/Bops/Ver บManutencao Efetuada                            บฑฑ
ฑฑฬออออออออออุออออออออหออออออหอออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Hanna    ณ15/09/06บ107543บAlterada a referencia do campo U5_CONTAT       บฑฑ
ฑฑบ Hanna    ณ20/09/06บ107440บInclusao de Strings diferentes para as secoes  บฑฑ
ฑฑบ          ณ        บ      บInclusao do arquivo SUN (motivo encerramento)  บฑฑ
ฑฑณ Fernando ณ11/10/06|811   |Foi modificada a funcao ReportDef para      ณฑฑ
ฑฑณ			 |	      |		 |criacao de string a ser visualizada na opcao   ณฑฑ
ฑฑณ			 |		  |		 |Personalizar do relatorio TMKR034              ณฑฑ                               
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤ  |ฤฤฤฤฤฤ|ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ---ูฑฑ
ฑฑศออออออออออฯออออออออฯออออออสอออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport				// Objeto do relatorio
Local oSection1				// Objeto da secao 1
Local oSection2				// Objeto da secao 2
Local cAlias1	:= "SUC"	// Define o Alias
Local cAlias2	:= "SU7"	// Define o Alias
Local cAlias3	:= "SUD"	// Define o Alias

cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
cAlias2		:= cAlias1
cAlias3		:= cAlias1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณGera a tela com os dados para a confirma็ใo da geracao do relatorioณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//"Atendimento Telemarketing"
// "Relatorio de Atendimentos Telemarketing"
DEFINE REPORT oReport NAME "TMKR034" TITLE STR0015 PARAMETER "TMK034" ACTION {|oReport| Tkr034PrtRpt( oReport, cAlias1 ) } DESCRIPTION STR0016

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine a secao1 do relatorio, informando que o arquivo principal utlizado eh o SL3 e o complementar o SB1ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE SECTION oSection1 OF oReport TITLE STR0051 TABLES "SUC","SU5","SUH","SUL","SUN" COLUMNS 2		//"  Telemarketing"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine as celulas que irao aparecer na secao1ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE CELL NAME "UC_CODIGO"	OF oSection1 ALIAS "SUC"
DEFINE CELL NAME "CONTATO"		OF oSection1 ALIAS "SUC" SIZE 36 TITLE STR0025 BLOCK {|| UC_CODCONT + " - " + FATPDObfuscate(SU5->U5_CONTAT,"U5_CONTAT",,.T.) }
DEFINE CELL NAME "UCDATA"		OF oSection1 ALIAS "SUC" SIZE 20 TITLE STR0020 BLOCK {|| DTOC(UC_DATA) + " - " + TKR034RetVal( UC_DATA ) }
DEFINE CELL NAME "U5_FCOM1"		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "UC_OPERACA"	OF oSection1 ALIAS "SUC"
DEFINE CELL NAME "X2NOME"		OF oSection1 SIZE 32 TITLE STR0006 BLOCK {|| Posicione("SX2",1,UC_ENTIDAD,"X2NOME()") }
DEFINE CELL NAME "UC_STATUS"	OF oSection1 ALIAS "SUC" BLOCK {|| TKR034RetSta( cAlias1 ) }
DEFINE CELL NAME "UH_DESC"	 	OF oSection1 ALIAS "SUH" BLOCK {|| TkEntidade(UC_ENTIDAD,UC_CHAVE,1,,.T.) }
DEFINE CELL NAME "UC_OPERADO"	OF oSection1 ALIAS "SUC" SIZE 20 BLOCK {|| UC_OPERADO + " - " + FATPDObfuscate((cAlias2)->U7_NOME,"U7_NOME",,.T.)   }
DEFINE CELL NAME "UC_PENDENT"	OF oSection1 SIZE 20 TITLE STR0023 BLOCK {|| DTOC(UC_PENDENT) + " - " + TKR034RetVal( UC_PENDENT ) }
DEFINE CELL NAME "UC_HRPEND"	OF oSection1
DEFINE CELL NAME "UC_MIDIA" 	OF oSection1 ALIAS "SUC" SIZE 50 BLOCK {|| UC_MIDIA + Posicione("SUH",1,xFilial("SUH") + UC_MIDIA,"UH_DESC") }
DEFINE CELL NAME "ENDERECO"		OF oSection1 SIZE 40 TITLE STR0009 BLOCK {|| TkEntidade(UC_ENTIDAD,UC_CHAVE,2,,.T.) }
DEFINE CELL NAME "COMUNICA"		OF oSection1 SIZE 40 TITLE STR0028 BLOCK {|| UC_TIPO + " - " + Posicione("SUL",1,xFilial("SUL") + UC_TIPO,"UL_DESC") }
DEFINE CELL NAME "BAIRRO"		OF oSection1 SIZE 40 TITLE STR0042 BLOCK {|| TkEntidade(UC_ENTIDAD,UC_CHAVE,10,,.T.) }
DEFINE CELL NAME "CAMPANHA" 	OF oSection1 SIZE 40 TITLE STR0029 BLOCK {|| Posicione("SUO",1,xFilial("SUO") + UC_CODCAMP,"UO_DESC") }
DEFINE CELL NAME "MUNICI" 		OF oSection1 SIZE 40 TITLE STR0011 BLOCK {|| TkEntidade( UC_ENTIDAD,UC_CHAVE,3,,.T.) }	// "Cidade"
DEFINE CELL NAME "ESTADO" 		OF oSection1 SIZE 2	 TITLE STR0012 BLOCK {|| TkEntidade( UC_ENTIDAD,UC_CHAVE,4,,.T.) }	// "Estado"
DEFINE CELL NAME "UC_CODOBS" 	OF oSection1 ALIAS "SUC" TITLE STR0030 SIZE 180 BLOCK {|| MSMM( UC_CODOBS ) }  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine a secao2 (que sera filha da secao1) ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE SECTION oSection2 OF oSection1 TITLE STR0050 TABLES "SUD","SB1","SU9","SUQ"	//"Itens - Atendimento Telemarketing"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine as celulas que irao aparecer na secao2ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE CELL NAME "X5DESCRI"		OF oSection2 TITLE STR0031 SIZE 12 BLOCK {|| Posicione("SX5",1,xFilial("SX5") + "T1" + UD_ASSUNTO,"X5DESCRI()") }
DEFINE CELL NAME "UD_PRODUTO"	OF oSection2 ALIAS "SUD"
DEFINE CELL NAME "PRODUTO"		OF oSection2 TITLE STR0041 SIZE 60 BLOCK {|| Posicione("SB1",1,xFilial("SB1") + UD_PRODUTO, "B1_DESC") }
DEFINE CELL NAME "U9_DESC"		OF oSection2 ALIAS "SU9" BLOCK {|| UD_OCORREN }
DEFINE CELL NAME "UQ_DESC"		OF oSection2 ALIAS "SUQ" BLOCK {|| Posicione("SU9",2,xFilial("SU9")+UD_OCORREN,"U9_DESC") }
DEFINE CELL NAME "OPERADOR"		OF oSection2 TITLE STR0026 SIZE 20 BLOCK {|| TKR034RetPSW(cAlias3) }
DEFINE CELL NAME "UD_DATA"		OF oSection2 ALIAS "SUD"
DEFINE CELL NAME "UD_STATUS"	OF oSection2 ALIAS "SUD"
DEFINE CELL NAME "UD_DTEXEC"	OF oSection2 ALIAS "SUD"
DEFINE CELL NAME "UD_OBS"		OF oSection2 ALIAS "SUD" SIZE 180 BLOCK {|| UD_OBS }
    
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine a secao3 (que sera filha da secao2) ณ  
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection1:SetLineStyle()
oSection1:PageBreak()
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTMKR034PrtบAutor  ณHanna Caroline      บ Data ณ  04/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para impressao do relatorio personalizavel           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Call Center                                                บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ ANALISTA     ณ DATA   ณ BOPS ณ  MOTIVO DA ALTERACAO                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณHanna Carolineณ20/09/06ณ107440ณPosicionado o SUN para imprimir o motivoณฑฑ
ฑฑณTatiana Camposณ29/03/07ณ121872ณAlterada a variavel cQuery por conter %%ณฑฑ
ฑฑณ              ณ        ณ      ณe duplicar o caracter quando o parametroณฑฑ
ฑฑณ              ณ        ณ      ณentidade era preenchido.                ณฑฑ
ฑฑณNorbert Waage ณ09/04/07ณ123341ณAlterada a variavel cQuery para que so- ณฑฑ
ฑฑณ              ณ        ณ      ณmente ao final da definicao dos parame- ณฑฑ
ฑฑณ              ณ        ณ      ณtros adicionais sejam utilizados os to- ณฑฑ
ฑฑณ              ณ        ณ      ณkens '%'.                               ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TKR034PrtRpt(oReport, cAlias1)
Local cQuery		:= ""								// Primeira Query
Local oSection1		:= oReport:Section(1)		   		// Define a secao 1 do relatorio
Local oSection2		:= oSection1:Section(1)				// Define que a secao 2 serah filha da secao 1
Local lCompart		:= SUC->(ColumnPos("UC_CHAORIG")) > 0
Local nTamAux		:= 0
	
DbSelectArea("SUC")
DbSetOrder(1)

If !Empty(Mv_Par01)
	cQuery += " UC_ENTIDAD = '" + MV_PAR01 + "' AND "
Endif

If Mv_Par02 <> 3	// Ambos
	nTamAux	:= TamSX3("UC_OPERACA")[1]
	cQuery	+= " ( UC_OPERACA = '" + Str(MV_PAR02,1) + "' OR"		// Ativo ou Receptivo
	cQuery	+= " UC_OPERACA = '"+Space(nTamAux)+"' ) AND "
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณSeleciono somente chamados que nao sao compartilhamentoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If lCompart
	nTamAux	:= TamSX3("UC_CHAORIG")[1]
	cQuery += "	SUC.UC_CHAORIG = '"+Space(nTamAux)+"' AND "
EndIf

If Mv_Par03 <> 4	// Todas
	cQuery += "	UC_STATUS = '" + Str(MV_PAR03,1) + "' AND "		// Plan. Pend. Encerr.
Endif

cQuery := "%"+cQuery+"%"

MakeSqlExpr("TMKR034")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicializa a secao 1ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
BEGIN REPORT QUERY oSection1
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณQuery da secao 1ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
BeginSql alias cAlias1
	SELECT	UC_CODIGO,	UC_CODCONT,	UC_DATA,	UC_CODOBS,
			UC_OPERADO,	UC_OPERACA,	UC_STATUS,
			UC_PENDENT,	UC_HRPEND,	UC_MIDIA,	UC_TIPO,
			UC_CODCAMP,	UC_ENTIDAD,	UC_CHAVE,	UC_CODENCE,
			U7_NOME,	UD_OPERADO,	UD_DATA,	UD_STATUS,	UD_DTEXEC,	
			UD_OBS,		UD_SOLUCAO,	UD_PRODUTO,	UD_ASSUNTO,	
			UD_OCORREN
	FROM	%table:SUC% SUC, %table:SU7% SU7, %table:SUD% SUD
	WHERE	UC_FILIAL	= 	%xfilial:SUC%			AND 
			UD_FILIAL	= 	%xfilial:SUD%			AND 
			U7_FILIAL	= 	%xfilial:SU7%			AND 
			UC_DATA 	>=	%exp:DtoS(mv_par04)%	AND
			UC_DATA 	<=	%exp:DtoS(mv_par05)%  	AND
			UC_OPERADO	=	U7_COD					AND
			UC_CODIGO	=	UD_CODIGO				AND
			UC_CODCANC	=	' '						AND
			%exp:cQuery%
			SUC.%notDel%							AND
			SU7.%notDel%							AND
			SUD.%notDel%							
	ORDER BY %Order:SUC%
EndSql
END REPORT QUERY oSection1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณBaseada na query da secao1, utiliza filtro para saber quando deve sair do laco de impressaoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection2:SetParentQuery()
oSection2:SetParentFilter( { | cParam | (cAlias1)->UC_CODIGO == cParam},{|| (cAlias1)->UC_CODIGO } )

TRPosition():New(oSection1,"SUL",1,{|| xFilial("SUL") + (cAlias1)->UC_TIPO } )
TRPosition():New(oSection1,"SUH",1,{|| xFilial("SUH") + (cAlias1)->UC_MIDIA } )
TRPosition():New(oSection1,"SUO",1,{|| xFilial("SUO") + (cAlias1)->UC_CODCAMP } )
TRPosition():New(oSection1,"SU5",1,{|| xFilial("SU5") + (cAlias1)->UC_CODCONT })  
TRPosition():New(oSection1,"SUN",1,{|| xFilial("SUN") + (cAlias1)->UC_CODENCE })  

TRPosition():New(oSection2,"SU9",1,{|| xFilial("SU9") + (cAlias1)->UD_OCORREN } )
TRPosition():New(oSection2,"SUQ",1,{|| xFilial("SUQ") + (cAlias1)->UD_SOLUCAO } )
	
	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณExecuta a impressao dos dados, de acordo com o filtro ou queryณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection1:Print()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTKR034RetValบAutor  ณHanna Caroline    บ Data ณ  04/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para retorno do dia em extenso                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Call Center                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TKR034RetVal( cCampo )
Local cRet := ""			// Retorno da funcao

If !Empty( cCampo )
	cRet := DiaExtenso( cCampo )
Endif

Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTKR034RetPSWบAutor  ณHanna Caroline    บ Data ณ  04/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para retornar o nome do operador de acordo com o PSS บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Call Center                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TKR034RetPSW(cAlias3)
Local cRet := ""			// Retorno da funcao
PswOrder(1)
If PswSeek( (cAlias3)->UD_OPERADO )
	cRet	:= PswRet()[1][4]
Endif
Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTKR034RetStaบAutor  ณHanna Caroline    บ Data ณ  11/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para retornar o status do atendimento                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Call Center                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TKR034RetSta(cAlias1)
Local cRet := ""			// Retorno da funcao
Do Case
	Case VAL((cAlias1)->UC_STATUS) == PLANEJADA
		cRet := STR0001

	Case VAL((cAlias1)->UC_STATUS) == PENDENTE
		cRet := STR0002

	Case VAL((cAlias1)->UC_STATUS) == ENCERRADA
		cRet := STR0003
EndCase
Return cRet

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa fun็ใo quando nใo houver releases menor que 12.1.27

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
    Fun็ใo que verifica se a melhoria de Dados Protegidos existe.

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