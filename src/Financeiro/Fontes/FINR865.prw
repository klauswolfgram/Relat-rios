/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR865.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "fwcommand.ch"

#DEFINE N_VALSEST		1
#DEFINE N_VALIRRF		2
#DEFINE N_VALISS 		3
#DEFINE N_VALINSS		4
#DEFINE N_VALPIS 		5
#DEFINE N_VALCOF 		6
#DEFINE N_VALCSLL		7
#DEFINE CODEMP_M0		3
#DEFINE CODUNG_M0		4
#DEFINE LAYEMP_M0		13
#DEFINE LAYUNG_M0		14
#DEFINE LAYFIL_M0		15

Static lIsIssBx := FindFunction("IsIssBx")
Static nTamCodFor	:= TamSX3("A2_COD")[1]
Static nTamLojFor	:= TamSX3("A2_LOJA")[1]
Static nTamE2Fil	:= TamSX3("E2_FILIAL")[1]
Static aTamNum		:= TamSX3("E2_NUM")
Static nVMinIr		:= SuperGetMv("MV_VLRETIR", .F., 0)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno	 ณ FINR865	ณ Autor ณ Nilton Pereira        ณ Data ณ 24.03.04 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Relacao de titulos a pagar com rentencao PIS/Cofins/CSLL	  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe e ณ U_FINR865(void)			 								  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso		 ณ Generico 												  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FINR865()

Local oReport                              
Local aArea	:= GetArea()
                                                         
oReport := ReportDef()
oReport:PrintDialog()

RestArea(aArea)  

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ ReportDef บ Autor ณ Marcio Menon		  บ Data ณ  01/09/06  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Definicao do objeto do relatorio personalizavel e das      บฑฑ
ฑฑบ          ณ secoes que serao utilizadas.                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ EXPC1 - Grupo de perguntas do relatorio                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 										                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport
Local oSection1        
Local oSection2
Local oSection3
Local cReport 	:= "FINR865" 				// Nome do relatorio
Local cDescri 	:= STR0001					//"Imprime a relacao dos titulos a pagar que sofreram retencao de Impostos"
Local cTitulo 	:= STR0007 					//"Relacao de Titulos a Pagar com retencao de Impostos"
Local cPerg		:= "FIN865"					// Nome do grupo de perguntas
Local aOrdem	:= {STR0004,STR0005}	 	//"Por Codigo Fornecedor"###"Por Nome Fornecedor"
Local aCodRet	:= {}						// Codigos de retencao selecionados para filtro

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Pergunte("FIN865",.F.)

//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
//ณ Variaveis utilizadas para parametros ณ
//ณ mv_par01		 // Do Fornecedor?     ณ
//ณ mv_par02		 // Ate Fornecedor?    ณ
//ณ mv_par03		 // Da Loja?      	  ณ
//ณ mv_par04		 // Ate Loja?          ณ
//ณ mv_par05		 // Da Emissao?	     ณ
//ณ mv_par06		 // Ate Emissao?       ณ
//ณ mv_par07		 // Do Vencimento?     ณ
//ณ mv_par08		 // Ate Vencimento?    ณ
//ณ mv_par09		 //	Filtra Cod. de Retencao ?     
//ณ mv_par10		 //	Tipo Fornecedor ?             
//ณ mv_par11		 //	Cons.Filiais abaixo ?         
//ณ mv_par12		 //	De Filial ?                   
//ณ mv_par13		 //	Ate Filial ?                  
//ณ mv_par14		 //	Seleciona Filiais
//ณ mv_par15		 //	Quebra por Fil. Orig?
//ณ mv_par16		 //	PCC sem Inf cod.Ret?
//ณ mv_par17		 //	Considera Impostos?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao do componente de impressao                                      ณ
//ณ                                                                        ณ
//ณTReport():New                                                           ณ
//ณExpC1 : Nome do relatorio                                               ณ
//ณExpC2 : Titulo                                                          ณ
//ณExpC3 : Pergunte                                                        ณ
//ณExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ณ
//ณExpC5 : Descricao                                                       ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport|	Iif( mv_par09 == 2 .Or. (mv_par09 == 1 .And. FR865CodRet( @aCodRet )),;
																ReportPrint( oReport, aCodRet ), .F. ) }, cDescri )

oReport:SetLandscape()	//Imprime o relatorio no formato paisagem
oReport:SetTotalInLine(.F.)		//Imprime o total em linha
//Gestao
oReport:SetUseGC(.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ                                                                        ณ
//ณ                      Definicao das Secoes                              ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Secao 01 (Dados Fornecedor)                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection1 := TRSection():New(oReport,STR0022, {"TRB","SA2"}, aOrdem)

TRCell():New(oSection1,"CODIGO" ,"TRB",STR0020,/*Picture*/, nTamCodFor ,/*lPixel*/,{ || TRB->CODIGO  } )		//"Codigo"
TRCell():New(oSection1,"LOJA"   ,"TRB",STR0021,/*Picture*/, nTamLojFor ,/*lPixel*/,{ || TRB->LOJA 	  } )		//"Loja"
TRCell():New(oSection1,"A2_NOME","TRB",STR0022,/*Picture*/, 40 ,/*lPixel*/,{ || TRB->A2_NOME})		//"Fornecedor"
TRCell():New(oSection1,"A2_CGC" ,"TRB",STR0023,/*Picture*/, 25 ,/*lPixel*/,{ || If(!Empty(TRB->A2_CGC), TRB->A2_CGC, '') } )	//"CGC"

oSection1:SetNoFilter("TRB")	// Desabilita Filtro
oSection1:SetNoFilter("SA2")	// Desabilita Filtro
oSection1:SetHeaderSection(.F.)	//Nao imprime o cabe็alho da secao

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Secao 02 (Titulos)                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection2 := TRSection():New(oSection1, STR0014, {"TRB","SE2"}, aOrdem)		//"TITULOS"

TRCell():New(oSection2,"PRF"    ,"TRB",STR0024,/*Picture*/, TamSX3("E2_PREFIXO")[1],/*lPixel*/,{ || TRB->PREFIXO } )	//"Prf"
TRCell():New(oSection2,"NUM"    ,"TRB",STR0025,/*Picture*/, aTamNum[1]             ,/*lPixel*/,{ || TRB->NUM     } )	//"Numero"
TRCell():New(oSection2,"PARCELA","TRB",STR0026,/*Picture*/, TamSX3("E2_PARCELA")[1],/*lPixel*/,{ || TRB->PARCELA } )	//"Pc"
TRCell():New(oSection2,"TIPO"   ,"TRB",STR0027,/*Picture*/, TamSX3("E2_TIPO")[1]   ,/*lPixel*/,{ || TRB->TIPO    } )	//"Tipo"
TRCell():New(oSection2,"EMISSAO","TRB",STR0028,/*Picture*/, TamSX3("E2_EMISSAO")[1]+2,/*lPixel*/,/*{ || TRB->EMISSAO }*/ )	//"Emissao"
TRCell():New(oSection2,"VENCTO" ,"TRB",STR0029,/*Picture*/, TamSX3("E2_VENCREA")[1]+2,/*lPixel*/,/*{ || TRB->VENCTO  }*/ )	//"Vencto"
TRCell():New(oSection2,"VALBASE","TRB",STR0030+STR0031,TM(0,15), 15,/*lPixel*/,/*{ || TRB->VALBASE }*/ )		//"Valor "##"Original"
TRCell():New(oSection2,"VACRESC","TRB",STR0030+STR0045,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"Acrescimo"
TRCell():New(oSection2,"VDECRES","TRB",STR0030+STR0046,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"Decrescimo"
TRCell():New(oSection2,"VALSEST","TRB",STR0030+STR0032,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"SEST"
TRCell():New(oSection2,"VALIRRF","TRB",STR0030+STR0033,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"IRRF"
TRCell():New(oSection2,"VALISS" ,"TRB",STR0030+STR0034,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"ISS"
TRCell():New(oSection2,"VALINSS","TRB",STR0030+STR0035,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"INSS"
TRCell():New(oSection2,"VALPIS" ,"TRB",STR0030+STR0036,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"PIS"
TRCell():New(oSection2,"VALCOF" ,"TRB",STR0030+STR0037,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"COFINS"
TRCell():New(oSection2,"VALCSLL","TRB",STR0030+STR0038,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"CSLL"
TRCell():New(oSection2,"VALLIQ" ,"TRB",STR0030+STR0039,TM(0,15), 15,/*lPixel*/,/*{ || If (!lPccBaixa .or. !lContrRet, TRB->VALLIQ, TRB->(VALLIQ-VALPIS-VALCOF-VALCSLL) ) }*/ )	//"Valor "##"Liquido"
TRCell():New(oSection2,"TIPORET",""   ,Substr(STR0017,1,1)+Substr(STR0018,1,1)+Substr(STR0019,1,1),/*Picture*/, 01 ,/*lPixel*/,/*CodeBlock*/)

oSection2:Cell("VALBASE"):SetHeaderAlign("RIGHT")
oSection2:Cell("VALSEST"):SetHeaderAlign("RIGHT")
oSection2:Cell("VACRESC"):SetHeaderAlign("RIGHT")
oSection2:Cell("VDECRES"):SetHeaderAlign("RIGHT")
oSection2:Cell("VALIRRF"):SetHeaderAlign("RIGHT")
oSection2:Cell("VALISS" ):SetHeaderAlign("RIGHT")
oSection2:Cell("VALINSS"):SetHeaderAlign("RIGHT")
oSection2:Cell("VALPIS" ):SetHeaderAlign("RIGHT")
oSection2:Cell("VALCOF" ):SetHeaderAlign("RIGHT")
oSection2:Cell("VALCSLL"):SetHeaderAlign("RIGHT")
oSection2:Cell("VALLIQ" ):SetHeaderAlign("RIGHT")
oSection2:Cell("TIPORET"):HideHeader()	//Oculta o texto do cabe็alho

oSection2:SetNoFilter("TRB")  	// Desabilita Filtro
oSection2:SetHeaderPage()	//Define o cabecalho da secao como padrao
oSection2:SetLineBreak(.T.)		//Quebra a linha quando nใo couber na pแgina
oSection2:SetTotalInLine(.F.)   //Imprime o total em linha


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Secao 03 (Totaliza็ใo) 
//ณ Estrutura semelhante เ da Secao 02 para manter o alinhamento entre os 
//ณ tํtulos e o total por filial
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection3 := TRSection():New(oSection2, STR0014, {"TRB","SE2" }, aOrdem)		//"Totaliza็ใo por Filial"

TRCell():New(oSection3,"TOTFIL" ,"TRB","Total por FILIAL",/*Picture*/, TamSX3("E2_PREFIXO")[1]+aTamNum[1]+TamSX3("E2_PARCELA")[1]+TamSX3("E2_TIPO")[1]+TamSX3("E2_EMISSAO")[1]+2+TamSX3("E2_VENCREA")[1]+2 ,/*lPixel*/, /*{ || TRB->PREFIXO } */)
TRCell():New(oSection3,"VALBASE","TRB",STR0030+STR0031,TM(0,15), 15,/*lPixel*/,/*{ || TRB->VALBASE }*/ )		//"Valor "##"Original"
TRCell():New(oSection3,"VACRESC","TRB",STR0030+STR0045,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"Acrescimo"
TRCell():New(oSection3,"VDECRES","TRB",STR0030+STR0046,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"Decrescimo"
TRCell():New(oSection3,"VALSEST","TRB",STR0030+STR0032,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"SEST"
TRCell():New(oSection3,"VALIRRF","TRB",STR0030+STR0033,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"IRRF"
TRCell():New(oSection3,"VALISS" ,"TRB",STR0030+STR0034,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"ISS"
TRCell():New(oSection3,"VALINSS","TRB",STR0030+STR0035,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"INSS"
TRCell():New(oSection3,"VALPIS" ,"TRB",STR0030+STR0036,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"PIS"
TRCell():New(oSection3,"VALCOF" ,"TRB",STR0030+STR0037,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"COFINS"
TRCell():New(oSection3,"VALCSLL","TRB",STR0030+STR0038,TM(0,15), 15,/*lPixel*/,/*{ || }*/ )	//"Valor "##"CSLL"
TRCell():New(oSection3,"VALLIQ" ,"TRB",STR0030+STR0039,TM(0,15), 15,/*lPixel*/,/*{ || If (!lPccBaixa .or. !lContrRet, TRB->VALLIQ, TRB->(VALLIQ-VALPIS-VALCOF-VALCSLL) ) }*/ )	//"Valor "##"Liquido"
TRCell():New(oSection3,"TIPORET",""   ,Substr(STR0017,1,1)+Substr(STR0018,1,1)+Substr(STR0019,1,1),/*Picture*/, 01 ,/*lPixel*/,/*CodeBlock*/)

oSection3:Cell("VALBASE"):SetHeaderAlign("RIGHT")
oSection3:Cell("VALSEST"):SetHeaderAlign("RIGHT")
oSection3:Cell("VACRESC"):SetHeaderAlign("RIGHT")
oSection3:Cell("VDECRES"):SetHeaderAlign("RIGHT")
oSection3:Cell("VALIRRF"):SetHeaderAlign("RIGHT")
oSection3:Cell("VALISS" ):SetHeaderAlign("RIGHT")
oSection3:Cell("VALINSS"):SetHeaderAlign("RIGHT")
oSection3:Cell("VALPIS" ):SetHeaderAlign("RIGHT")
oSection3:Cell("VALCOF" ):SetHeaderAlign("RIGHT")
oSection3:Cell("VALCSLL"):SetHeaderAlign("RIGHT")
oSection3:Cell("VALLIQ" ):SetHeaderAlign("RIGHT")
oSection3:Cell("TIPORET"):HideHeader()	//Oculta o texto do cabe็alho

oSection3:SetNoFilter("TRB")  	// Desabilita Filtro
oSection3:SetLineBreak(.T.)		//Quebra a linha quando nใo couber na pแgina
oSection3:SetTotalInLine(.F.)   //Imprime o total em linha
oSection3:SetHeaderSection(.F.)	//Nao imprime o cabe็alho da secao

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออัออออออออออออัอออออัออออออออออออออออออออัออออออัอออออออออออออปฑฑ
ฑฑบPrograma   ณReportPrint ณAutorณ Marcio Menon       ณ Data ณ  01/09/06   บฑฑ
ฑฑฬอออออออออออฯออออออออออออฯอออออฯออออออออออออออออออออฯออออออฯอออออออออออออนฑฑ
ฑฑบDescricao  ณ Imprime o objeto oReport definido na funcao ReportDef.     บฑฑ 
ฑฑฬอออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametros ณ oReport - Objeto TReport do relatorio                      บฑฑ
ฑฑบ           ณ 				   										   บฑฑ
ฑฑฬอออออออออออุออออออออออออัออออออัออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ   Data    ณ    Autor   ณ BOPS ณ        Manutencao Efetuada             บฑฑ
ฑฑฬอออออออออออุออออออออออออุออออออุออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ06/11/2007 ณPedro P Limaณ134275ณ O relatorio nao considerava o valor    บฑฑ
ฑฑบ           ณ   TI6434   ณ P10  ณ original do titulo, que era impresso   บฑฑ
ฑฑบ           ณ            ณ      ณ com o valor 0,00 e tabem nao           บฑฑ
ฑฑบ           ณ            ณ      ณ considerava o valor do campo valor liq.บฑฑ
ฑฑบ           ณ            ณ      ณ que era impresso incorretamente.       บฑฑ  
ฑฑบ           ณ            ณ      ณ Foi corrigido o trecho onde a variavel บฑฑ
ฑฑบ           ณ            ณ      ณ nValBase recebe o valor original do    บฑฑ
ฑฑบ           ณ            ณ      ณ titulo e o tratamento do valor liquido.บฑฑ 
ฑฑศอออออออออออฯออออออออออออฯออออออฯออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint( oReport, aCodRet )

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(1):Section(1)

Local oTotPis
Local oTotCof
Local oTotCsll

Local cFilterUser := oSection1:GetSqlExp("SE2")

Local oBreak
Local nOrdem		:= oReport:Section(1):GetOrder()
Local cCGCAnt
Local cChaveSe2
Local nTitCli		:= 0
Local nTitRel		:= 0
Local cCodFor		:= ""
Local cLojFor		:= ""
Local cNomFor		:= ""                       
Local cNomFil		:= ""
Local cNomFilAnt	:= ""
Local nValBase	 	:= 0
Local nValAcre	 	:= 0
Local nValDecre	 	:= 0
Local nValLiq	 	:= 0
Local lFatura 	 	:= .F.
Local lCalcIssBx 	:=	IIF(lIsIssBx, IsIssBx("P"), SuperGetMv("MV_MRETISS",.F.,"1") == "2" )

Local cFilterSE2 	:= ""
Local cTipoForn		:= Iif( mv_par10 == 1, "F", Iif( mv_par10 == 2, "J", "" ) )	// Tipo de Fornecedor
Local lSelFil		:= ( MV_PAR14 == 1 )	// Seleciona Filiais? 1=Sim / 2=Nao
Local lMultFil   	:= .F.	// Indica que existe mais de uma filial para a empresa
Local nTitFil		:= 0	// Total de titulos processados para filial
Local cCodRet		:= ""
Local nTotValImp	:= 0
Local aValImp		:= {}
Local lFilCRet		:= .F.		// Indica se foram selecionados codigos de retencao para filtro
Local lTitPai		:= .T.
Local lTotPCC		:= .T.		// Indica se deve totalizar colunas de PCC. Deve ser .F. se a coluna TIPORET for igual a "B"
Local lImpFornec	:= .T.
Local cOrder		:= ""
Local nSomaImp		:= 0
Local lDedInss		:= .T.
Local nVl10925		:= SuperGetMv( "MV_VL10925", ,5000 ) 
Local cMvPar15		:= TYPE("MV_PAR15")
Local lPaBruto  	:= Alltrim(SuperGetMv("MV_PABRUTO", .F., "2")) == "1"        

Local nTotREG		:= 0

Local lIRPFBaixa	:= .T.
Local lIRPFBxAux	:= .F.
Local nTotRetIr		:= 0
Local nVRetIr		:= 0
Local lAplMinIR		:= .F.

Local nVRetIss		:= 0
Local nFiltPcc		:= 1
Local nCont 		:= 1
Local nTamPerg		:= 0
Local lMulFilAut    := .F.
Local nFiltRet		:= 1
Local nVRetPis		:= 0
Local nVRetCof		:= 0
Local nVRetCsll		:= 0
Local lRetIR		:= .T.
Local lRetISS		:= .T.

//Gestao
Local lGestao   := ( FWSizeFilial() > 2 ) .And. AdmGetGest() 	// Indica se usa Gestao Corporativa
Local aSelFil 	:= {}
Local aSm0		:= {}
Local nRegSM0	:= SM0->(Recno())
Local cFilSm0	:= "" 
Local nInc		:= 0

Local cModeAcSA2 := ""
Local cModeAcSE2 := ""

Private lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1"

//Verifica a existencia do pergunte e sua ordem
oSX1 := FWSX1Util():New()
oSX1:AddGroup("FIN865")
oSX1:SearchGroup()

nTamPerg := Len(oSX1:aGrupo[1, 2])
FOR nCont := 1 TO nTamPerg
    If UPPER(ALLTRIM(oSX1:aGrupo[1, 2, nCont]:CX1_VAR01)) == UPPER("mv_par16")
		nFiltPcc := IIf(nCont == 15, mv_par15, mv_par16)
	ElseIf UPPER(ALLTRIM(oSX1:aGrupo[1, 2, nCont]:CX1_VAR01)) == UPPER("mv_par17") 	
		nFiltRet := IIf(nCont == 17, mv_par17, 1)
	EndIf
NEXT nCont

oSX1 := Nil


//Gestao
If lSelFil // Seleciona Filiais ?
	If !IsBlind()
		If lGestao
			aSelFil := FwSelectGC()
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SE2")	
		Endif
	Else
		If FindFunction("GetParAuto")
			aRetAuto := GetParAuto("FINR865TestCase")
			If !Empty(aRetAuto)
				aSelFil  := aRetAuto
				lMulFilAut := .T.
			EndIf
		EndIf
	EndIf
EndIf

If Empty(aSelFil)
	aSelFil := {cFilAnt}
EndIF

SM0->(DbGoTo(nRegSM0))
aSM0 := FR865AbreSM0(aSelFil,If(cMvPar15 $ "UC",.T.,MV_PAR15 == 1))

oReport:SetTotalText({|| STR0016+"("+ALLTRIM(STR(nTitRel))+" "+IIF(nTitRel > 1,STR0014,STR0015)+")"})
oReport:SetPageFooter(4,{|| If(!oSection2:Printing(),F865Legenda(oReport),"")})

TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+TRB->CODIGO+TRB->LOJA}) 
TRPosition():New(oSection2,"SE2",1,{|| xFilial("SE2")+TRB->PREFIXO+TRB->NUM+TRB->PARCELA+TRB->TIPO+TRB->CODIGO+TRB->LOJA})

oBreak := TRBreak():New(oSection1,{|| TRB->CODIGO+TRB->LOJA},{|| STR0013 + AllTrim(cNomFor) +" ("+AllTrim(STR(nTitCli))+" "+IiF(nTitCli>1,STR0014,STR0015)+")"})
oBreak:OnBreak({|x| cNomFor := GetLGPDValue("SA2","A2_NOME") })

TRFunction():New(oSection2:Cell("EMISSAO"),"","TIMESUB",oBreak,,,,.F.,.T.)
TRFunction():New(oSection2:Cell("VENCTO" ),"","TIMESUB",oBreak,,,,.F.,.T.)
TRFunction():New(oSection2:Cell("VALBASE"),"","SUM",oBreak,,,,.F.,.T.)
TRFunction():New(oSection2:Cell("VACRESC"),"","SUM",oBreak,,,,.F.,.T.)
TRFunction():New(oSection2:Cell("VDECRES"),"","SUM",oBreak,,,,.F.,.T.)
TRFunction():New(oSection2:Cell("VALSEST"),"","SUM",oBreak,,,,.F.,.T.)

TRFunction():New(oSection2:Cell("VALIRRF"),"","SUM",oBreak,,,{|| Iif(	!lRetIR .OR. aValImp[N_VALIRRF]  == 0, 0, aValImp[N_VALIRRF]  			) },.F.,.T.,.F.,oSection2)
TRFunction():New(oSection2:Cell("VALISS" ),"","SUM",oBreak,,,{|| Iif(	!lRetISS .OR. aValImp[N_VALISS]  == 0, 0, aValImp[N_VALISS]  										) },.F.,.T.,.F.,oSection2)
TRFunction():New(oSection2:Cell("VALINSS"),"","SUM",oBreak,,,{|| Iif(	TRB->PRETINS == "1" .Or. aValImp[N_VALINSS]  == 0, 0, aValImp[N_VALINSS]  			) },.F.,.T.,.F.,oSection2)
oTotPis  := TRFunction():New(oSection2:Cell("VALPIS" ),"","SUM",oBreak,,,{|| Iif(	TRB->PRETPIS == "1" .Or. aValImp[N_VALPIS]  == 0, 0, aValImp[N_VALPIS]  ) },.F.,.T.,.F.,oSection2)
oTotCof  := TRFunction():New(oSection2:Cell("VALCOF" ),"","SUM",oBreak,,,{|| Iif(	TRB->PRETCOF == "1" .Or. aValImp[N_VALCOF]  == 0, 0, aValImp[N_VALCOF]  ) },.F.,.T.,.F.,oSection2)
oTotCsll := TRFunction():New(oSection2:Cell("VALCSLL"),"","SUM",oBreak,,,{|| Iif(	TRB->PRETCSL == "1" .Or. aValImp[N_VALCSLL] == 0, 0, aValImp[N_VALCSLL] ) },.F.,.T.,.F.,oSection2)

TRFunction():New(oSection2:Cell("VALLIQ" ),"","SUM",oBreak,,,,.F.,.T.)

//Gestao
// Verifica se existe mais de uma filial para a empresa posicionada
If Len(aSM0) > 1 .Or. lMulFilAut
	lMultFil := .T.
Else
	lMultFil := .F.
Endif

// Monta string com codigos de retencao selecionadas no filtro
lFilCRet := ( Len( aCodRet ) > 0 )

If lFilCRet
	AEval( aCodRet, { |x| cCodRet += ( x + "/" ) } )
	cCodRet := Left( cCodRet, Len( cCodRet ) - 1 )
	oReport:OnPageBreak( { || FR865ImpCRet( oReport, cCodRet ) } )
EndIf

//Gestao
For nInc := 1 To Len( aSM0 )

	cFilSm0 :=	""		

	cFilAnt := aSM0[nInc][2]
	cFilSm0 := aSM0[nInc][2] + ' - ' + aSM0[nInc][7]

	// Inicializa totalizadores por filial se considera filiais e utiliza mais de uma filial
	If lMultFil
		nTitFil	  := 0
		nVlFilOri := 0
		nVlFilLiq := 0
		nVlFilIns := 0
		nVlFilPis := 0
		nVlFilCof := 0
		nVlFilCsl := 0
		nVlFilIrf := 0
		nVlFilIss := 0
		nVlFilSes := 0
		nVlFilAcr := 0
		nVlFilDec := 0
	EndIf 

	dbSelectArea("SE2")
	
	cChaveSe2 := IndexKey()
	cFilterSE2 := cFilterUser  
	
	cQuery := "SELECT E2_FORNECE CODIGO, E2_LOJA LOJA, E2_FILIAL FILIAL, E2_PREFIXO PREFIXO, SA2.A2_NOME, SA2.A2_CGC, "
	
	If nOrdem == 1 
		cOrder := " ORDER BY FILIAL, CODIGO, LOJA"
	Else
		cOrder := " ORDER BY FILIAL, A2_NOME"
	Endif
	
	cQuery += "E2_NUM NUM,E2_PARCELA PARCELA,E2_TIPO TIPO,E2_EMISSAO EMISSAO,E2_VENCREA VENCTO, E2_IRRF VALIRRF, E2_ISS VALISS, E2_VRETISS VRETISS, "
	cQuery += "E2_INSS VALINSS, E2_VRETINS VRETINS ,E2_FATURA FATURA,E2_NATUREZ NATUREZ, E2_PIS VALPIS,E2_COFINS VALCOF,E2_CSLL VALCSLL, "
		
	//Se controla Retencao
	cQuery += "E2_VRETPIS VRETPIS,E2_VRETCOF VRETCOF,E2_VRETCSL VRETCSL,"	
	cQuery += "E2_PRETPIS PRETPIS,E2_PRETCOF PRETCOF,E2_PRETCSL PRETCSL,"	
	cQuery += "(E2_VALOR) VALBASE,"
	cQuery += "E2_SEST VALSEST,"	

	
	cQuery += "E2_VRETIRF VRETIRF, E2_PRETIRF PRETIRF, "

	IF lCalcIssBx
		cQuery += "E2_TRETISS TRETISS, "
	Endif

	cQuery += "E2_VALOR VALLIQ, E2_PARCISS PARCISS, E2_PARCINS PARCINS, E2_PARCIR PARCIR, "
	cQuery += "E2_PARCPIS PARCPIS, E2_PARCCOF PARCCOF, E2_PARCSLL PARCSLL, E2_PARCSES PARCSES, E2_PRETINS PRETINS, "
	cQuery += "E2_ACRESC ACRESC, E2_JUROS JUROS, E2_MULTA MULTA, E2_DECRESC DECRESC, E2_DESCONT DESCONT, E2_TITPAI TITPAI, "
	cQuery += "E2_NUMBOR NUMBOR, E2_BAIXA BAIXA, E2_FILORIG FILORIG "
	cQuery += "FROM " + RetSqlName("SE2")+" SE2 "
	
	cQuery 	+= " INNER JOIN " + RetSqlName("SA2")+" SA2 ON SA2.A2_FILIAL = '" + xFilial("SA2") + "'" 
	cQuery 	+= " AND SE2.E2_FORNECE = SA2.A2_COD AND SE2.E2_LOJA	= SA2.A2_LOJA AND SA2.D_E_L_E_T_ = ' ' "
	If !Empty( cTipoForn )
		cQuery += " AND SA2.A2_TIPO = '" + cTipoForn + "'"
	EndIf
	
	cQuery += " WHERE "
	
	//Determina como serแ o filtro das filiais
	IF !cMvPar15 $ "UC"
		IF MV_PAR15 == 1
			cQuery += " SE2.E2_FILORIG = '" + cFilAnt + "'"
		ELSE
			cQuery += " SE2.E2_FILIAL = '" + xFilial("SE2") + "'"
		ENDIF
	ELSE
		cQuery += " SE2.E2_FILORIG = '" + cFilAnt + "'"
	ENDIF

	cQuery += " AND SE2.E2_FORNECE  BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"
	cQuery += " AND SE2.E2_LOJA BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"
	cQuery += " AND SE2.E2_EMISSAO  <= '" + DTOS(dDataBase) + "'"
	cQuery += " AND (SE2.E2_INSS > 0 "
	cQuery += " OR SE2.E2_ISS > 0 "
	cQuery += " OR SE2.E2_PIS > 0 "
	cQuery += " OR SE2.E2_COFINS > 0 "
	cQuery += " OR SE2.E2_CSLL > 0 "
	cQuery += " OR SE2.E2_SEST > 0 "  

	cQuery += " OR (SE2.E2_IRRF > 0 OR (SE2.E2_VRETIRF > 0 AND SE2.E2_PRETIRF <> '1' ))) "

	cQuery += " AND SE2.E2_VENCREA  between '" + DTOS(mv_par07)  + "' AND '" + DTOS(mv_par08) + "'"
	cQuery += " AND SE2.E2_EMISSAO  between '" + DTOS(mv_par05)  + "' AND '" + DTOS(mv_par06) + "'"
	cQuery += " AND SE2.E2_EMISSAO  <= '"      + DTOS(dDataBase) + "'"		

	
	If nFiltPcc == 2 .And. mv_Par09 == 1
      	cQuery += " AND  E2_CODRET <> ' '"
	EndIf

	If !Empty(cFilterSE2)
      	cQuery += " AND " + cFilterSE2
	EndIf
	
	cQuery += " AND SE2.D_E_L_E_T_ = ' ' "
	cQuery += cOrder
	cQuery := ChangeQuery(cQuery)

	dbSelectArea("SE2")
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TRB', .F., .T.)
	TCSetField('TRB',"VENCTO","D",8,0)
	TCSetField('TRB',"EMISSAO","D",8,0)

	dbSelectArea("TRB")
	TRB->(dbGoTop())
	TRB->(dbEval({|| nTotREG++}))
	TRB->(dbGoTop())	
	
	oReport:SetMeter(nTotREG)

	Do While !TRB->(Eof())
	
		nTitCli		:= 0
				
		nValBase	:= 0
		nValAcre	:= 0
		nValDecre	:= 0
                    
		// Inicializa totais de PIS, COFINS e CSLL que devem ser abatidos do total do fornecedor se coluna TIPORET igual a "B"
		nNTotPis	:= 0
		nNTotCof	:= 0
		nNTotCsl	:= 0

		// Inicializa variaveis de reten็ใo de IR
		nTotRetIr	:= 0
		nVRetIr		:= 0
		lAplMinIR	:= .F.

		nVRetIss	:= 0
				
		dbSelectArea("SA2")			
		SA2->(dbSetOrder(1))
		
		cCodFor		:= TRB->CODIGO
		cLojFor		:= TRB->LOJA
		cNomFor		:= TRB->A2_NOME
		cCGCAnt		:= TRB->A2_CGC
	
		lImpFornec	:= .T.

		Do While TRB->(!EOF()) .AND. cCodFor + cLojFor == TRB->(CODIGO+LOJA)

			nSomaImp	:= 0
			nVRetIr		:= 0
			nVRetISS	:= 0
			nVRetPis	:= 0
			nVRetCof	:= 0
			nVRetCsll	:= 0
			lRetIR 		:= .T.
			lRetISS 	:= .T.

			If SA2->(! dbSeek(xFilial("SA2")+TRB->CODIGO+TRB->LOJA) )
				TRB->( dbSkip() )
				Loop
			EndIf

			lIRPFBAux  := lIRPFBaixa
			If cPaisLoc == "BRA"
				lIRPFBxAux := lIRPFBAux .And. ( SA2->A2_CALCIRF == "2" )
			Else
				lIRPFBxAux := .F.
			EndIf


			// IRRF Emissใo
			If !lIRPFBxAux
				// Verifica se o fornecedor trata o valor minimo de retencao.
				// 1 - Nใo considera  2 - Considera o parโmetro MV_VLRETIR
				If cPaisLoc == "BRA" .And. SA2->A2_MINIRF == "2"
					lAplMinIR := .T.
				Endif

				// Verifica cumulatividade de IRRF
				If lAplMinIr
					If TRB->VALIRRF == 0 .And. (nTotRetIr + TRB->VRETIRF) < nVMinIr
						nTotRetIr += TRB->VRETIRF
					Else
						nVRetIr   := TRB->VALIRRF
						nTotRetIr := 0
					EndIf
				Else
					nVRetIr := TRB->VRETIRF	
				EndIf
			Else
				//IR na baixa 
				If nFiltRet == 1 // Exibe somente se for retido 
					nVRetIr := TRB->VRETIRF
				ElseIf nFiltRet == 2 // Exibe retido e calculado na baixa em aberto
					If TRB->VRETIRF == 0 .and. Empty(TRB->BAIXA) .and. VLDBOR(TRB->NUMBOR,"P",TRB->FILORIG)
						//ainda nใo foi gerado o TX, logo, mostrar o calculado
						nVRetIr := TRB->VALIRRF 
						lRetIR := .F.
					Else
						nVRetIr := TRB->VRETIRF
						lRetIR := .T.
					EndIf	
				EndIf	
			EndIf
			
			If lCalcIssBx
				If nFiltRet == 1 // Exibe somente se for retido 
					nVRetIss := TRB->VRETISS
				ElseIf nFiltRet == 2 // Exibe retido e calculado na baixa em aberto
					If TRB->VRETISS == 0 .and. Empty(TRB->BAIXA) .and. VLDBOR(TRB->NUMBOR,"P",TRB->FILORIG)
						//ainda nใo foi gerado o TX, logo, mostrar o calculado
						nVRetIss := TRB->VALISS 
						lRetISS := .F.
					else
						nVRetIss := TRB->VRETISS
						lRetISS := .T.
					EndIf
					
					
				EndIf	
			Else
				nVRetIss := TRB->VALISS
			EndIf
			

			// Inicializa vetor com o valor dos impostos do titulo
			// Se valor de PCC jแ retido, considerar os campos de reten็ใo da E2, pois podem haver Juros\Desconto nas parcelas dos impostos (MV_IMPBAIX)
			aValImp := {;
							TRB->VALSEST,;		// Valor SEST
							TRB->VALIRRF,;		// Valor IRRF 	
							TRB->VALISS ,;		// Valor ISS
							TRB->VALINSS,;		// Valor INSS
							TRB->VALPIS	,;		// Valor PIS
							TRB->VALCOF	,;		// Valor COFINS
							TRB->VALCSLL }		// Valor CSLL	
			
			
			aValImp[N_VALIRRF] := nVRetIr			// Valor retido IRRF
			aValImp[N_VALISS]  := nVRetIss			// Valor retido ISS
			
			If TRB->PRETINS <> '1'
				aValImp[N_VALINSS] := TRB->VRETINS		// Valor retido INSS
			EndIf

			nVRetPis := TRB->VALPIS
			nVRetCof := TRB->VALCOF
			nVRetCsll := TRB->VALCSLL

			If lPccBaixa

				If nFiltRet == 1 // Exibe somente se for retido 
					nVRetPis	:= TRB->VRETPIS
					nVRetCof	:= TRB->VRETCOF
					nVRetCsll	:= TRB->VRETCSL
				ElseIf nFiltRet == 2 // Exibe retido e calculado na baixa em aberto
					nVRetPis := Iif(TRB->VRETPIS == 0 .and. TRB->PRETPIS == "1",TRB->VALPIS ,TRB->VRETPIS)
					nVRetCof := Iif(TRB->VRETCOF == 0 .and. TRB->PRETCOF == "1",TRB->VALCOF ,TRB->VRETCOF)
					nVRetCsll := Iif(TRB->VRETCSL == 0 .and. TRB->PRETCSL == "1",TRB->VALCSLL ,TRB->VRETCSL)
				EndIf	

			Else
				If TRB->PRETPIS <> '1'
					nVRetPis := TRB->VRETPIS		// Valor retido PIS
				EndIf
				If TRB->PRETCOF <> '1'
					nVRetCof := TRB->VRETCOF		// Valor retido COFINS
				EndIf
				If TRB->PRETCSL <> '1'
					nVRetCsll := TRB->VRETCSL		// Valor retido CSLL
				EndIf
			EndIf           
			aValImp[N_VALPIS] := nVRetPis
			aValImp[N_VALCOF] := nVRetCof
			aValImp[N_VALCSLL] := nVRetCsll

			// Se utiliza filtro por codigo de retencao, altera os valores do vetor 
			// de acordo com os codigos de retencao selecionados para filtro
			If lFilCRet

				nTotValImp := 0
				FR865FilCRet( @aValImp, aCodRet, lTitPai )
				AEval( aValImp, { |x| nTotValImp += x } )

				// Se todos os impostos estao com valor zero, vai para o proximo titulo
				If nTotValImp == 0
					TRB->(dbSkip())
					Loop     
				EndIf

			EndIf
             
			If lImpFornec
				oSection1:Init()
				oSection1:Cell("A2_CGC"):SetPicture(IIF(Len(Alltrim(cCGCAnt)) == 11 , "@R 999.999.999-99","@R 99.999.999/9999-99"))					
				oSection1:PrintLine()
				oSection2:Init()
				lImpFornec := .F.
			EndIf		
			
			nValAcre := TRB->ACRESC + TRB->MULTA
			nValDecre:= TRB->DECRESC
			If TRB->JUROS > 0
				nValAcre := TRB->JUROS + TRB->MULTA
			EndIf
			If TRB->DESCONT > 0
				nValDecre:= TRB->DESCONT
			EndIf
			
			oSection2:Cell("VACRESC"):SetBlock( { || nValAcre } )
			oSection2:Cell("VDECRES"):SetBlock( { || nValDecre } )
			oSection2:Cell("VALSEST"):SetBlock( { || aValImp[N_VALSEST] } )
			oSection2:Cell("VALIRRF"):SetBlock( { || aValImp[N_VALIRRF] } )
			oSection2:Cell("VALISS" ):SetBlock( { || aValImp[N_VALISS]  } )
			oSection2:Cell("VALINSS"):SetBlock( { || aValImp[N_VALINSS] } )
			oSection2:Cell("VALPIS" ):SetBlock( { || aValImp[N_VALPIS]  } )
			oSection2:Cell("VALCOF" ):SetBlock( { || aValImp[N_VALCOF]  } )
			oSection2:Cell("VALCSLL"):SetBlock( { || aValImp[N_VALCSLL] } )
	
			lFatura := .F.
			lTotPCC	:= .T.
			
		 	If !Empty(TRB->FATURA) .And. TRB->FATURA == 'NOTFAT'
				lFatura := .T.
			EndIf 

			oSection2:Cell("EMISSAO"):SetBlock( { || TRB->EMISSAO } )
			oSection2:Cell("VENCTO" ):SetBlock( { || TRB->VENCTO } )
                
			dbSelectArea("SED")   
			dbsetorder(1)
			dbSeek( xFilial("SED") + TRB->NATUREZ )
			lDedInss	:= (SED->ED_DEDINSS == "1")
			nValBase	:= TRB->(VALBASE + Iif(lDedInss, VALINSS, 0) + VALISS)
			nValLiq 	:= TRB->VALLIQ 

			If !Empty(nVRetIr) .And. (((TRB->TIPO $ MVPAGANT) .And. !lPaBruto) .Or. !(TRB->TIPO $ MVPAGANT) .And. !lIRPFBxAux)
				nValBase += nVRetIr
			EndIf

			If !lPccBaixa
				If (Empty( TRB->PRETPIS) .OR. Empty( TRB->PRETCOF) .OR. Empty( TRB->PRETCSL)) .AND.  TRB->(VALPIS+VALCOF+VALCSLL)  > 0
				//PCC retido na emissao nele mesmo, somar para compor o valor original.
					nValBase += TRB->(VRETPIS+VRETCOF+VRETCSL)   
				Endif
			EndIf
				
			If (( TRB->PRETPIS == '2') .OR. ( TRB->PRETCOF == '2') .OR. ( TRB->PRETCSL == '2')) .AND. (TRB->( VALPIS + VALCOF + VALCSLL ) > 0)
				//PCC retido na baixa ou na emissao nao nele mesmo, ou seja, o E2_VALOR nao sofreu abatimento, entao abater o PCC para obter o liquido
				nValLiq -= TRB->(VALPIS+VALCOF+VALCSLL) 
			Endif
			
			//Caso o calculo do ISS seja efetuado na baixa do titulo, nao somo o imposto para compor o valor base
			If lCalcIssBx .and. TRB->TRETISS == "2"
				nValBase -= TRB->VALISS
				nValLiq	 -= nVRetIss
			Endif
			
			If ((lIRPFBxAux .And. !(TRB->TIPO $ MVPAGANT)) .Or. ((TRB->TIPO $ MVPAGANT) .And. lPaBruto)) .and. TRB->PRETIRF $ "1/7/ /4"
				nValLiq	 -= nVRetIr 
			EndIf
		
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณNo que esta consolidado nao se pode determinar qual o    ณ
			//ณtipo de retencao de PCC estava em uso e nao se pode usar ณ
			//ณo parametro MV_BX10925 como referencia, entao utilizar   ณ
			//ณapenas os campos PRET para determinar se o PCC deve      ณ
			//ณou nao ser agregado ao valor original do titulo.         ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

			If	!(lPccBaixa .and. ( (TRB->PRETPIS == '1' .And. TRB->PRETPIS == '1' ) .OR. ( TRB->PRETCOF == '1' .And. TRB->PRETCOF == '1' ) .OR. ( TRB->PRETCSL == '1' .And. TRB->PRETCSL == '1' ) ) .AND. TRB->( VALPIS + VALCOF + VALCSLL ) > 0)
				If	( ( TRB->PRETPIS <> '2' .And. TRB->PRETPIS <> '3' .And. TRB->PRETPIS <> '4' ) .OR. ( TRB->PRETCOF <> '2' .And. TRB->PRETCOF <> '3' .And. TRB->PRETCOF <> '4' ) .OR. ( TRB->PRETCSL <> '2' .And. TRB->PRETCSL <> '3' .And. TRB->PRETCSL <> '4' ) ) .AND. TRB->( VALPIS + VALCOF + VALCSLL ) > 0
					//PCC retido na emissao nele mesmo, somar para compor o valor original.
					If	( ( TRB->PRETPIS <> '2' .And. TRB->PRETPIS <> '3' ) .OR. ( TRB->PRETCOF <> '2' .And. TRB->PRETCOF <> '3' ) .OR. ( TRB->PRETCSL <> '2' .And. TRB->PRETCSL <> '3' ) ) .AND. TRB->( VALPIS + VALCOF + VALCSLL ) > 0					    		
						If nValBase > nVl10925
							nDescont:= TRB->(VRETPIS+VRETCOF+VRETCSL) - TRB->(VALPIS+VALCOF+VALCSLL) 
							nValLiq += nDescont
							If !lIRPFBxAux	.and. (!Empty( TRB->PRETPIS) .Or. !Empty( TRB->PRETCOF) .or. !Empty( TRB->PRETCSL))						
								nValBase+= nDescont
							EndIf
						Else
							nDescont:= TRB->(VRETPIS+VRETCOF+VRETCSL) - TRB->(VALPIS+VALCOF+VALCSLL) 
							nValLiq += nDescont
						EndIf
					EndIf

				Elseif lPccBaixa .and. (( TRB->PRETPIS <> '2') .OR. ( TRB->PRETCOF <> '2') .OR. ( TRB->PRETCSL <> '2' ))
					//PCC retido na baixa ou na emissao nao nele mesmo, ou seja, o E2_VALOR nao sofreu abatimento, entao abater o PCC para obter o liquido
					nValLiq -= (nVRetPis + nVRetCof + nVRetCsll)

				Endif
			ElseIf lPccBaixa // .and. ( nValBase > SuperGetMv( "MV_VL10925", ,5000 ) )  							
				nValLiq-= (nVRetPis + nVRetCof + nVRetCsll) 
			EndIf
			
			nValBase += aValImp[N_VALSEST]
			nValLiq := nValLiq + nValAcre - nValDecre
			
			oSection2:Cell("VALBASE"):SetBlock( { || nValBase } )
			oSection2:Cell("VALLIQ" ):SetBlock( { || nValLiq } )

			oSection2:Cell("TIPORET"):Hide()
			If lPccBaixa	// Geracao dos impostos lei 10925 pela baixa
				If TRB->(VALPIS+VALCOF+VALCSLL) > 0  
					If TRB->TIPO $ MVPAGANT 
						If TRB->PRETPIS == "1" .OR. TRB->PRETCOF == "1" .OR. TRB->PRETCSL == "1"
							If TRB->(VRETPIS+VRETCOF+VRETCSL) == 0	   
								oSection2:Cell("TIPORET"):Show()
								oSection2:Cell("TIPORET"):SetBlock( { || "A" } )
							Endif
						Endif			                                               					
					Else
						If TRB->PRETPIS == "3" .OR. TRB->PRETCOF == "3" .OR. TRB->PRETCSL == "3"
							If TRB->(VRETPIS+VRETCOF+VRETCSL) == 0
								oSection2:Cell("TIPORET"):Show()								
								oSection2:Cell("TIPORET"):SetBlock( { || "A" } )
							Endif
						ElseIf TRB->PRETPIS == "1" .OR. TRB->PRETCOF == "1" .OR. TRB->PRETCSL == "1"
							oSection2:Cell("TIPORET"):Show()							
							oSection2:Cell("TIPORET"):SetBlock( { || "B" } )   
							lTotPCC := .F.
						Endif
					Endif
				Endif			
			Else
				If TRB->PRETPIS == "2" .OR. TRB->PRETCOF == "2" .OR. TRB->PRETCSL == "2"
					oSection2:Cell("TIPORET"):Show()					
					oSection2:Cell("TIPORET"):SetBlock( { || "A" } )					
				ElseIf TRB->PRETPIS == "1" .OR. TRB->PRETCOF == "1" .OR. TRB->PRETCSL == "1"
					oSection2:Cell("TIPORET"):Show()					
					oSection2:Cell("TIPORET"):SetBlock( { || "B" } )	
					lTotPCC := .F.
				Endif
			Endif
		
			
			If !lRetIR .or. !lRetISS
				oSection2:Cell("TIPORET"):Show()					
				oSection2:Cell("TIPORET"):SetBlock( { || "B" } )
			EndIf	
			
		 	If lFatura   
				oSection2:Cell("TIPORET"):Show()		 	
				oSection2:Cell("TIPORET"):SetBlock( { || "C" } )
			EndIf
	
			// Imprime registro caso houver valores de impostos
			AEval(aValImp,{|x| nSomaImp += x  } )
			If nSomaImp > 0
				oSection2:PrintLine()
						
				nTitCli++
				If !lTotPCC
					nNTotPis  += aValImp[N_VALPIS]
					nNTotCof  += aValImp[N_VALCOF]
					nNTotCsl  += aValImp[N_VALCSLL]
				EndIf
					
				If lMultFil
					nVlFilLiq += nValLiq
					nVlFilIns += aValImp[N_VALINSS]
					If lRetIR
						nVlFilIrf += aValImp[N_VALIRRF]
					EndIf
					If lRetISS	
						nVlFilIss += aValImp[N_VALISS]
					EndIf	
					nVlFilSes += aValImp[N_VALSEST]
					nVlFilAcr += nValAcre
					nVlFilDec += nValDecre
					
					If !lFatura
						nVlFilOri += nValBase
					EndIf 
					If lTotPCC
						nVlFilPis += aValImp[N_VALPIS]
						nVlFilCof += aValImp[N_VALCOF]
						nVlFilCsl += aValImp[N_VALCSLL]
					EndIf	
					
				EndIf
			EndIf
	
			TRB->(dbSkip())
			oReport:IncMeter()

		Enddo	

		oSection2:Finish()
		oSection1:Finish()

		If lMultFil
			nTitFil += nTitCli
		EndIf
			
		nTitRel += nTitCli

		oReport:IncMeter()

		
	Enddo

	If lMultFil
		lTemCont := If(nTitFil > 0,.T.,.F.)
		
		If lTemCont		
			cNomFil 	:= cFilSM0 + " (" + AllTrim( Str(nTitFil) ) + " " + Iif( nTitFil > 1, STR0014, STR0015 ) + ")"
			cNomFilAnt  := cNomFil
		Else
			cNomFil     := cNomFilAnt  
		Endif        
		//Se for formato de planilha em tabela, nใo devera imprimir a quebra
		If nTitFil > 0 .And. !oReport:lXlsTable	
			FR865QuebraFil( nTitFil, nVlFilOri, nVlFilLiq, nVlFilIns, nVlFilPis, nVlFilCof,;
							nVlFilCsl, nVlFilIrf, nVlFilIss, nVlFilSes, oReport, cFilSm0, nVlFilAcr, nVlFilDec )
		EndIf	
	EndIf

	dbSelectArea("SE2")
	dbCloseArea()
	ChKFile("SE2")
	dbSelectArea("SE2")
	dbSetOrder(1)
	TRB->(dbCloseArea())

	IF !cMvPar15 $ "UC"
		
		cModeAcSA2 := FWModeAccess("SA2",1)
		cModeAcSA2 += FWModeAccess("SA2",2)
		cModeAcSA2 += FWModeAccess("SA2",3)

		cModeAcSE2 := FWModeAccess("SE2",1)
		cModeAcSE2 += FWModeAccess("SE2",2)
		cModeAcSE2 += FWModeAccess("SE2",3)
		
		IF MV_PAR15 == 2 .AND. !EMPTY(MV_PAR15) .AND. cModeAcSA2 == "CCC" .AND. cModeAcSE2 == "CCC"
			Exit
		ENDIF
	ENDIF
Next
	
SM0->( dbGoTo( nRegSM0 ) )
cFilAnt := SM0->M0_CODFIL

//Limpeza do objeto FwPreparedStatement
TxSeek(,,.T.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณF865Legendaบ Autor ณ Marcio Menon	      บ Data ณ  09/05/08  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao da legenda de retencao de impostos.		      บฑฑ
ฑฑบ          ณ 								                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 											                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Finr865								                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function F865Legenda(oReport)

oReport:PrintText(STR0017)		// A = Os valores de Pis,Cofins e Csll deste titulo foram retidos em outro titulo.
oReport:PrintText(STR0018+STR0041)	// B = Existem impostos com reten็ใo na baixa que ainda nao foram retidos.
oReport:PrintText(STR0019)		// C = Os registros referentes a fatura nใo sใo incluidos nos totalizadores.

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno	 ณ FR865QuebraFil ณAutor ณ Gustavo Henrique ณ Data ณ 02/07/09 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Imprimir total do relatorio								  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ EXPN1  - Total de titulos da filial                        ณฑฑ
ฑฑณ          ณ EXPN2  - Total de valor original da filial                 ณฑฑ
ฑฑณ          ณ EXPN3  - Total de valor liquido da filial                  ณฑฑ
ฑฑณ          ณ EXPN4  - Total do imposto INSS da filial                   ณฑฑ
ฑฑณ          ณ EXPN5  - Total do imposto PIS  da filial                   ณฑฑ
ฑฑณ          ณ EXPN6  - Total do imposto COFINS da filial                 ณฑฑ
ฑฑณ          ณ EXPN7  - Total do imposto CSLL da filial                   ณฑฑ
ฑฑณ          ณ EXPN8  - Total do imposto IRRF da filial                   ณฑฑ
ฑฑณ          ณ EXPN9  - Total do imposto ISS da filial                    ณฑฑ
ฑฑณ          ณ EXPN10 - Total do imposto SEST da filial                   ณฑฑ
ฑฑณ          ณ EXPN11 - Objeto do relatorio de Retencao de Impostos       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ FINR865 				   									  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
STATIC Function FR865QuebraFil( nTitFil, nVlFilOri, nVlFilLiq, nVlFilIns, nVlFilPis, nVlFilCof,;
								nVlFilCsl, nVlFilIrf, nVlFilIss, nVlFilSes, oReport,cFilSm0, nVlFilAcr, nVlFilDec )

Local nTamChave :=	0
Local oSection3 := oReport:Section(1):Section(1):Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cCampoS3  := oSection3:aCell[2]:cName
Local nX

oReport:SkipLine()
oSection3:Init()

//Deixa em branco os campos que nใo sใo num้ricos
For nX := 1 to len(oSection3:aCell)
	If !(oSection3:aCell[nX]:cType == "N")
		cNameCampo := oSection3:aCell[nX]:cName
		oSection3:Cell(cNameCampo):SetBlock({|| " " })
	EndIF
Next

//Imprime o nome da Filial Totalizada
oSection3:Cell("TOTFIL"  ):SetSize(60,.F.)
oSection3:Cell("TOTFIL"  ):SetBlock({|| STR0042 + " - " + AllTrim(cFilSm0) + " (" + AllTrim( Str(nTitFil) ) + " " + Iif( nTitFil > 1, STR0014, STR0015 ) + ")" })	// Total Filial###TITULOS ### TITULO
oSection3:Cell("VALBASE" ):SetBlock({|| })
oSection3:Cell("VALLIQ"  ):SetBlock({|| })
oSection3:Cell("VACRESC" ):SetBlock({|| })
oSection3:Cell("VDECRES" ):SetBlock({|| })
oSection3:Cell("VALSEST" ):SetBlock({|| })
oSection3:Cell("VALIRRF" ):SetBlock({|| })
oSection3:Cell("VALISS"  ):SetBlock({|| })
oSection3:Cell("VALINSS" ):SetBlock({|| })
oSection3:Cell("VALPIS"  ):SetBlock({|| })
oSection3:Cell("VALCOF"  ):SetBlock({|| })
oSection3:Cell("VALCSLL" ):SetBlock({|| })

oSection3:PrintLine()

oReport:ThinLine()

//Define quantos campos foram informados na Se็ใo 2 antes do primeiro num้rico do totalizador
//para dar o espa็amento correto no nTamChave
//O cแlculo ้ feito pelo tamanho do tํtulo ou conte๚do do campo
For nX := 1 to len(oSection2:aCellPos)
	If oSection2:aCellPos[nX]:cName == cCampoS3
		Exit
	EndIF
	If (oSection2:aCellPos[nX]:lHeaderSize) .AND. (oSection2:aCellPos[nX]:nHeaderSize > oSection2:aCellPos[nX]:nSize)
		nTamChave += oSection2:aCellPos[nX]:nHeaderSize+1
	Else
		nTamChave += oSection2:aCellPos[nX]:nSize+1
	EndIf
Next

oSection3:Cell("TOTFIL"  ):SetSize(nTamChave-1,.F.)
oSection3:Cell("TOTFIL"  ):SetBlock({|| })
oSection3:Cell("VALBASE" ):SetBlock({|| nVlFilOri })
oSection3:Cell("VALLIQ"  ):SetBlock({|| nVlFilLiq })
oSection3:Cell("VACRESC" ):SetBlock({|| nVlFilAcr })
oSection3:Cell("VDECRES" ):SetBlock({|| nVlFilDec })
oSection3:Cell("VALSEST" ):SetBlock({|| nVlFilSes })
oSection3:Cell("VALIRRF" ):SetBlock({|| nVlFilIrf })
oSection3:Cell("VALISS"  ):SetBlock({|| nVlFilIss })
oSection3:Cell("VALINSS" ):SetBlock({|| nVlFilIns })
oSection3:Cell("VALPIS"  ):SetBlock({|| nVlFilPis })
oSection3:Cell("VALCOF"  ):SetBlock({|| nVlFilCof })
oSection3:Cell("VALCSLL" ):SetBlock({|| nVlFilCsl })

oSection3:PrintLine()
oSection3:Finish()	
oReport:SkipLine()

Return     
      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหออออออัออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ FR865ImpCRet บAutor ณ Gustavo Henrique บ Data ณ 03/07/09   บฑฑ
ฑฑฬออออออออออุออออออออออออออสออออออฯออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Imprimir os codigos de retencao selecionados no filtro.    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Relatorio de Retencao de Impostos                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FR865ImpCRet(oReport, cCodRet)
if oReport:PageWidth() < 2500
	if len(cCodRet) > 130
		oReport:PrintText("C๓digos de Reten็ใo Selecionados: " + substr(cCodRet,1,130))
		oReport:PrintText("                                  " + substr(cCodRet,130,300))		
	Else
		oReport:PrintText("C๓digos de Reten็ใo Selecionados: " + cCodRet)				
	endiF		
Else	
	if len(cCodRet) > 190
		oReport:PrintText("C๓digos de Reten็ใo Selecionados: " + substr(cCodRet,1,190))
		oReport:PrintText("                                  " + substr(cCodRet,190,300))		
	Else
		oReport:PrintText("C๓digos de Reten็ใo Selecionados: " + cCodRet)				
	endiF		
endif 
oReport:ThinLine()
oReport:SkipLine()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ FR865CodRet บ Autor ณ Gustavo Henrique บ Data ณ 01/07/09   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Exibe dialogo para selecao dos codigos de retencao caso    บฑฑ
ฑฑบ          ณ seja informado "Sim" na pergunta "Filtra Cod. Retencao?"   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ EXPA1 - Vetor com os codigos de retencao selecionados para บฑฑ
ฑฑบ          ณ         filtro dos valores de impostos impressos.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Relatorio de Retencao de Impostos - FINR865                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FR865CodRet( aCodRet )
     
Local cTitulo	:= ""                     
Local lRet		:= .T.
Local cTabela	:= "37"		// Tabela 37 - Codigos de retencao
Local aBox		:= {}                        
Local nTam		:= TamSX3("E2_CODRET")[1]
Local nX		:= 0 
Local MvParDef	:= ""
Local aRetSX5	:= {}

If !IsBlind() 
	aRetSX5 := FWGetSX5( cTabela, ,"pt-br")

	// Posiciona na Tabela 37 para buscar a descricao da tabela do SX5
	cTitulo := AllTrim(FWGetSX5( "00","37","pt-br")[1][4])

	// Monta opcoes para selecao de acordo com os itens da tabela do SX5
	For nX := 1 to len(aRetSX5)
		AAdd( aBox, AllTrim( aRetSX5[nX][3] ) + " - " + Alltrim( aRetSX5[nX][4] ) ) 
		MvParDef += AllTrim( aRetSX5[nX][3] )
	Next nX	

	Do While lRet

		lRet := f_Opcoes(	@aCodRet,;		// uVarRet
							cTitulo,;		// cTitulo
							@aBox,;			// aOpcoes
							MvParDef,;		// cOpcoes
							,;				// nLin1
							,;				// nCol1
							,;				// l1Elem
							nTam,; 			// nTam
							Len( aBox ),;	// nElemRet
							,;				// lMultSelect
							,;				// lComboBox
							,;				// cCampo
							,;				// lNotOrdena
							,;				// NotPesq
							.T.,;			// ForceRetArr
							)				// F3
				
		If lRet .And. Len( aCodRet ) == 0
			// Quando for informado "Sim" na pergunta "Filtra C๓digos de Reten็ใo?", deve ser selecionado ao menos um c๓digo de reten็ใo.
			MsgInfo( STR0043 ) 
		Else
			Exit
		EndIf
		
	EndDo
Else
	If FunName() == "RPC"
		aCodRet := STATICCALL(FINR865TestCase,GetCodRet)
	Endif
Endif

FwFreeArray(aBox)
FwFreeArray(aRetSX5)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณ FR865FilCRet บ Autor ณ Gustavo Henrique บ Data ณ 01/07/09  บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Realiza filtro por codigo de retencao se informados.       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ EXPA1 - Valores dos impostos do titulo a serem impressos.  บฑฑ
ฑฑบ          ณ EXPA2 - Codigos de retencao selecionados no filtro.        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Relacao de Impostos                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FR865FilCRet( aValImp, aCodRet, lTitPai )
			                               
Local cNatImp := ""			   
Local lAglPCC := SuperGetMv("MV_AG10925",.F.,"2") == '1' // Aglutina Impostos ?
LOCAL cSearchKey := TRB->(PREFIXO + NUM + PARCELA + TIPO + CODIGO + LOJA)
LOCAL cTRB_CodRet := ""


//Caso seja Aglutina็ใo de PCC, o mesmo deve utilizar o PARCPIS.
//Pois quando se aglutina os impostos o unico preenchido ้ o PARCPIS.
If lAglPCC

	// Verifica parcelas dos impostos do titulo principal para saber se tem o imposto	
	cNatImp := SuperGetMV("MV_PISNAT")
	IF !EMPTY(aValImp[ N_VALPIS ]) .AND.;
		!FR865PesqImp(cSearchKey,aCodRet,cNatImp,lTitPai,@cTRB_CodRet)
		aValImp[ N_VALPIS ] := 0
		// Quando o C๓digo de Reten็ใo ้ ฺnico
		IF cTRB_CodRet == "5952"
			aValImp[ N_VALCOF ] := 0
			aValImp[ N_VALCSLL ] := 0
		ENDIF
	ENDIF
	IF cTRB_CodRet != "5952"
		cNatImp := SuperGetMV("MV_COFINS")
		IF !EMPTY(aValImp[ N_VALCOF ]) .AND.;
			!FR865PesqImp(cSearchKey,aCodRet,cNatImp,lTitPai)
			aValImp[ N_VALCOF ] := 0
		ENDIF
		cNatImp := SuperGetMV("MV_CSLL")
		IF !EMPTY(aValImp[ N_VALCSLL ]) .AND.;
			!FR865PesqImp(cSearchKey,aCodRet,cNatImp,lTitPai)
			aValImp[ N_VALCSLL ] := 0           
		ENDIF
	ENDIF

Else //Caso nใo seja Aglutina็ใo de PCC, o mesmo deve utilizar o PARCPIS,PARCCOF e PARCSLL.
	 //Pois quando nใo se aglutinado os impostos todos os anteriores sao preenchidos (PARCPIS,PARCCOF e PARCSLL)

	// Verifica parcelas dos impostos do titulo principal para saber se tem o imposto			   
	If !Empty( TRB->PARCPIS ) // Pis
		cNatImp := SuperGetMV( "MV_PISNAT" )
		// Se o codigo de retencao nao foi selecionado para filtro, grava zero no valor do imposto
		If ! FR865PesqImp( TRB->( PREFIXO + NUM + PARCELA + TIPO + CODIGO + LOJA ), aCodRet, cNatImp, lTitPai )
			aValImp[ N_VALPIS ] := 0
		EndIf	
	Else
		aValImp[ N_VALPIS ] := 0             
	EndIf

	If !Empty( TRB->PARCCOF ) // Cofins
		cNatImp := SuperGetMV( "MV_COFINS" )
		If ! FR865PesqImp( TRB->( PREFIXO + NUM + PARCELA + TIPO + CODIGO + LOJA ), aCodRet, cNatImp, lTitPai )
			aValImp[ N_VALCOF ] := 0   
		EndIf	
	Else
		aValImp[ N_VALCOF ] := 0             
	EndIf

	If !Empty( TRB->PARCSLL ) // Csll
		cNatImp := SuperGetMV( "MV_CSLL" )
		If ! FR865PesqImp( TRB->( PREFIXO + NUM + PARCELA + TIPO + CODIGO + LOJA ), aCodRet, cNatImp, lTitPai )
			aValImp[ N_VALCSLL ] := 0   
		EndIf	
	Else
		aValImp[ N_VALCSLL ] := 0             
	EndIf

EndIf

If !Empty( TRB->PARCIR ) .Or. !Empty( TRB->VALIRRF )	// Irrf
	cNatImp := &( SuperGetMV( "MV_IRF" ) )
	If ! FR865PesqImp(TRB->( PREFIXO + NUM + PARCELA + TIPO + CODIGO + LOJA ) , aCodRet, cNatImp, lTitPai )
		aValImp[ N_VALIRRF ] := 0   
	EndIf	
ELSE 
	aValImp[ N_VALIRRF ] := 0	
EndIf

// ISS nao tem codigo de retencao, tem codigo de recolhimento pois eh uma contribuicao da previdencia 
// social. Por este motivo, nao imprime o imposto se selecionado filtro por codigos de retencao.
If !Empty( TRB->PARCISS ) .Or. !Empty( TRB->VALISS ) // Iss
	aValImp[ N_VALISS ] := 0  
EndIf

// INSS nao tem codigo de retencao, tem codigo de recolhimento pois eh uma contribuicao da previdencia 
// social. Por este motivo, nao imprime o imposto se selecionado filtro por codigos de retencao.
If !Empty( TRB->PARCINS ) .Or. !Empty( TRB->VALINSS )	// Inss
	aValImp[ N_VALINSS ] := 0
EndIf

If !Empty( TRB->PARCSES )	// Sest
	cNatImp := SuperGetMV( "MV_SEST" )
	If ! FR865PesqImp( TRB->( PREFIXO + NUM + PARCELA + TIPO + CODIGO + LOJA ) , aCodRet, cNatImp, lTitPai )
		// Para o caso de Sest, verifica tambem se existe codigo de rentecao no titulo pai
		SE2->( dbSetOrder( 1 ) )     
		SE2->( MsSeek( xFilial("SE2") + TRB->( PREFIXO + NUM + PARCELA + TIPO + CODIGO + LOJA ) ) )
		If aScan( aCodRet, SE2->E2_CODRET ) == 0
			aValImp[ N_VALSEST ] := 0
		EndIf	
	EndIf	
EndIf
	
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณ FR865PesqImp บ Autor ณ Gustavo Henrique บ Data ณ 01/07/09  บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Retornar se o valor do imposto deve ser impresso no        บฑฑ
ฑฑบ          ณ relatorio a partir dos filtros de codigo de retencao       บฑฑ
ฑฑบ          ณ selecionados.                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ EXPC1 - Chave do titulo pai (E2_TITPAI)      			  บฑฑ
ฑฑบ          ณ EXPA2 - Vetor com os codigos de retencao para filtro       บฑฑ
ฑฑบ          ณ EXPC3 - Natureza do titulo de imposto.                     บฑฑ
ฑฑบ          ณ EXPL4 - Indica se existe o campo E2_TITPAI.                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ EXPL1 - Retorna .T. se deve considerar o valor do imposto  บฑฑ
ฑฑบ          ณ         no relatorio ou .F. caso contrario.                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Relacao de Impostos                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FR865PesqImp( cChaveImp, aCodRet, cNatImp, lTitPai, cCodRet )
Local lRet := .T.

If TxSeek(cNatImp,cChaveImp)
	cCodRet := SE2->E2_CODRET
	If aScan(aCodRet,cCodRet) == 0		   	
		lRet := .F.			                                 			
	EndIf                                                                   	
Else
	lRet := .F.
Endif	

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณFR865AbreSM0ณ Autor ณ Mauricio Pequim Jr  ณ Data ณ 16/10/13 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณRetorna um array com as informacoes das filias das empresas ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Generico                                                   ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function FR865AbreSM0(aSelFil,lFilOrig)               

Local aArea			:= SM0->( GetArea() )
Local aRetSM0		:= {}
Local nLaco			:= 0
Local cUngAux		:= ""
Local cEmpAux		:= ""
Local cFilAux		:= ""
Local lContinua		:= .T.
Local lSharE2_1		:= .F.
Local lSharE2_2		:= .F.
Local lSharE2_3		:= .F.
Local lTemEmp		:= .F.
Local lTemUNG		:= .F.

Default lFilOrig	:= .F.

lSharE2_1	:= FWModeAccess("SE2",1) == "C"
lSharE2_2	:= FWModeAccess("SE2",2) == "C"
lSharE2_3	:= FWModeAccess("SE2",3) == "C"
			
aRetSM0	:= FWLoadSM0()

If Len(aRetSM0) != Len(aSelFil)
	If lFilOrig .or. !lSharE2_3
		For nLaco := Len(aRetSM0) To 1 Step -1
			cFilx := aRetSm0[nLaco,SM0_CODFIL]
			nPosFil := Ascan(aSelFil,aRetSm0[nLaco,SM0_CODFIL])
			If nPosFil == 0 .Or. cEmpAnt != aRetSM0[nLaco,SM0_GRPEMP]
				ADel(aRetSM0,nLaco)
				aSize(aRetSM0, Len(aRetSM0)-1)
			EndIf
		Next
	Else
		For nLaco := Len(aRetSM0) To 1 Step -1
			lContinua := .T.
			// Verifica filiais selecionadas
			cFilx := aRetSm0[nLaco,SM0_CODFIL]
			nPosFil := Ascan(aSelFil,aRetSm0[nLaco,SM0_CODFIL])
			If nPosFil == 0 .Or. cEmpAnt != aRetSM0[nLaco,SM0_GRPEMP]
				ADel(aRetSM0,nLaco)
				aSize(aRetSM0, Len(aRetSM0)-1)
				lContinua := .F.
			EndIf
			If lContinua
				// Leiaute com empresa
				If !Empty(aRetSM0[nLaco,LAYEMP_M0])
					lTemEmp := .T.
					If lSharE2_1				 	// Se tudo esta compartilhada, 
						If nLaco <> Len(aRetSM0) 	// uma empresa ja basta para processar
							ADel(aRetSM0,nLaco)
							aSize(aRetSM0, Len(aRetSM0)-1)
						EndIf
						lContinua := .F.
					EndIf
				EndIf
				// Leiaute com unidade de negocio
				If lContinua .and. !Empty(aRetSM0[nLaco,LAYUNG_M0]) 
					lTemUNG := .T.
					If lSharE2_2				// Se esta compartilhada, verifica se eh da mesma empresa
						If lTemEmp
							If cEmpAux <> aRetSM0[nLaco,CODEMP_M0]	
								cEmpAux := aRetSM0[nLaco,CODEMP_M0]
							Else
								ADel(aRetSM0,nLaco)
								aSize(aRetSM0, Len(aRetSM0)-1)
							EndIf
						Else	// Tudo compartilhado
							If nLaco <> Len(aRetSM0) 	
								ADel(aRetSM0,nLaco)
								aSize(aRetSM0, Len(aRetSM0)-1)
							EndIf
						EndIf
						lContinua := .F.
					EndIf
				EndIf
				// Leiaute com filial 
				If lContinua .and. !Empty(aRetSM0[nLaco,LAYFIL_M0])
					If lSharE2_3				// Se esta compartilhada, verifica se eh da mesma UN
						If lTemUNG
							If cUngAux <> aRetSM0[nLaco,CODUNG_M0]		
								cUngAux := aRetSM0[nLaco,CODUNG_M0]
							Else	
								ADel(aRetSM0,nLaco)
								aSize(aRetSM0, Len(aRetSM0)-1)
								lContinua := .F.
							EndIf
						ElseIf lTemEmp
							If cFilAux <> aRetSM0[nLaco,CODEMP_M0]	
								cFilAux := aRetSM0[nLaco,CODEMP_M0]
							Else
								ADel(aRetSM0,nLaco)
								aSize(aRetSM0, Len(aRetSM0)-1)
								lContinua := .F.
							EndIf
						Else	// Tudo compartilhado
							If nLaco <> Len(aRetSM0) 	
								ADel(aRetSM0,nLaco)
								aSize(aRetSM0, Len(aRetSM0)-1)
								lContinua := .F.
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		Next
	EndIf
Endif

aSort(aRetSm0,,,{ |x,y| x[SM0_CODFIL] < y[SM0_CODFIL] } )
RestArea( aArea )

Return aClone(aRetSM0)
