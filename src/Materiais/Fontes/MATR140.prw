/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH" 
#INCLUDE "MATR140.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR140  ³ Autor ³ Alexandre Inacio Lemes³ Data ³11/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao das Solicitacoes de Compras                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR140(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr140( cAlias, nReg )

Local oReport

PRIVATE lAuto     := (nReg!=Nil) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef(nReg)
oReport:PrintDialog()
                                               
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³11/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao das Solicitacoes de Compras                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nExp01: nReg = Registro posicionado do SC1 apartir Browse  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(nReg)

Local oReport 
Local oSection1 
Local cTitle := STR0002 //"Solicitacao de Compra"
Local cAliasSC1 := ""

If Type("lAuto") == "U"
	lAuto := (nReg!=Nil)
Endif

If lAuto
	cAliasSC1 := "SC1"
Else
	cAliasSC1 := GetNextAlias()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01    Do Numero                                        ³
//³ mv_par02    Ate o Numero                                     ³
//³ mv_par03    Todas ou em Aberto                               ³
//³ mv_par04    A Partir da data de emissao                      ³
//³ mv_par05    Ate a data de emissao                            ³
//³ mv_par06    Do Item                                          ³
//³ mv_par07    Ate o Item                                       ³
//³ mv_par08    Campo Descricao do Produto.                      ³
//³ mv_par09    Imprime Empenhos ?                               ³
//³ mv_par10    Utiliza Amarracao ?  Produto   Grupo             ³
//³ mv_par11    Imprime Qtos Pedido Compra?                      ³
//³ mv_par12    Imprime Qtos Fornecedores?                       ³
//³ mv_par13    Impr. SC's Firmes, Previstas ou Ambas            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR140",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("MTR140",cTitle,If(lAuto,Nil,"MTR140"), {|oReport| ReportPrint(oReport,cAliasSC1,nReg)},STR0001) //"Emissao das solicitacoes de compras cadastradas"
oReport:SetLandscape() 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:= TRSection():New(oReport,STR0064,{"SC1","SB1","SB2"},/*aOrdem*/)
oSection1:SetHeaderPage()

TRCell():New(oSection1,"C1_ITEM"   ,"SC1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"C1_PRODUTO","SC1",/*Titulo*/,/*Picture*/,TamSX3("C1_PRODUTO")[1]+10,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"C1_QUANT"   ,"SC1",/*Titulo*/,PesqPict("SC1","C1_QUANT" ,12),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"DESCPROD"  ,"   ",STR0049,/*Picture*/,30,/*lPixel*/, {|| cDescPro })
TRCell():New(oSection1,"B2_QATU"   ,"SB2",/*Titulo*/    ,PesqPict("SB2","B2_QATU" ,12),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1EMIN"    ,"   ",STR0050       ,PesqPict("SB1","B1_EMIN" ,12),/*Tamanho*/,/*lPixel*/,{|| RetFldProd(SB1->B1_COD,"B1_EMIN") })
TRCell():New(oSection1,"SALDOSC1"  ,"   ",STR0051       ,PesqPict("SC1","C1_QUANT",12),/*Tamanho*/,/*lPixel*/,{|| (cAliasSC1)->C1_QUANT-(cAliasSC1)->C1_QUJE })
TRCell():New(oSection1,"C1_UM"     ,"SC1",/*Titulo*/    ,PesqPict("SC1","C1_UM"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"C1_LOCAL"  ,"SC1",/*Titulo*/    ,PesqPict("SC1","C1_LOCAL"),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_QE"     ,"SB1",/*Titulo*/    ,PesqPict("SB1","B1_QE",09),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_UPRC"   ,"SB1",/*Titulo*/    ,PesqPict("SB1","B1_UPRC",12),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"LEADTIME"  ,"   ",STR0052,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| CalcPrazo((cAliasSC1)->C1_PRODUTO,(cAliasSC1)->C1_QUANT)})
TRCell():New(oSection1,"DTNECESS"  ,"   ",STR0053,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If(Empty((cAliasSC1)->C1_DATPRF),(cAliasSC1)->C1_EMISSAO,(cAliasSC1)->C1_DATPRF) })
TRCell():New(oSection1,"DTFORCOMP" ,"   ",STR0054,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||SomaPrazo(If(Empty((cAliasSC1)->C1_DATPRF),(cAliasSC1)->C1_EMISSAO,(cAliasSC1)->C1_DATPRF), -CalcPrazo((cAliasSC1)->C1_PRODUTO,(cAliasSC1)->C1_QUANT)) })
oSection1:Cell("DESCPROD"):SetLineBreak(.T.) 

oSection2:= TRSection():New(oReport,STR0065,{"SD4","SC2"},/*aOrdem*/)

TRCell():New(oSection2,"D4_OP"     ,"SD4",STR0055,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C2_PRODUTO","SC2",STR0056,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D4_DATA"   ,"SD4",STR0057,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D4_QUANT"  ,"SD4",STR0058,PesqPict("SD4","D4_QUANT",12),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection3:= TRSection():New(oReport,STR0066,{"SB3"},/*aOrdem*/)

TRCell():New(oSection3,"MES01"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q01",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES02"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q02",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES03"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q03",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES04"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q04",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES05"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q05",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES06"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q06",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES07"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q07",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES08"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q08",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES09"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q09",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES10"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q10",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES11"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q11",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"MES12"		,"   ",/*Titulo*/,PesqPict("SB3","B3_Q12",11)	,11			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"B3_MEDIA"	,"SB3", ,PesqPict("SB3","B3_MEDIA",8),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"B3_CLASSE"	,"SB3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection4:= TRSection():New(oReport,STR0067,{"SC7","SA2"},/*aOrdem*/)
TRCell():New(oSection4,"C7_NUM"    ,"SC7",STR0043,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| cNumPc})
TRCell():New(oSection4,"C7_ITEM"   ,"SC7",STR0074,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| cItemPc})
TRCell():New(oSection4,"C7_FORNECE","SC7",STR0075,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| cFornec})
TRCell():New(oSection4,"C7_LOJA"   ,"SC7",STR0076,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| cLojaFor})
TRCell():New(oSection4,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| cNomeFor})
TRCell():New(oSection4,"C7_QUANT"  ,"SC7",/*Titulo*/,PesqPict("SC7","C7_QUANT"),/*Tamanho*/,/*lPixel*/,{|| nQuant})
TRCell():New(oSection4,"C7_UM"     ,"SC7",STR0077,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| cUM})
TRCell():New(oSection4,"C7_PRECO"  ,"SC7",/*Titulo*/,PesqPict("SC7","C7_PRECO"),/*Tamanho*/,/*lPixel*/,{|| nPreco})
TRCell():New(oSection4,"C7_TOTAL"  ,"SC7",/*Titulo*/,PesqPict("SC7","C7_TOTAL"),/*Tamanho*/,/*lPixel*/,{|| nTotal})
TRCell():New(oSection4,"C7_EMISSAO","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| dEmissao})
TRCell():New(oSection4,"C7_DATPRF" ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| dDATPRF})
TRCell():New(oSection4,"PRAZO"     ,"   ",STR0059,"999",/*Tamanho*/,/*lPixel*/,{|| dPrazo })
TRCell():New(oSection4,"C7_COND"   ,"SC7",STR0078/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| cCond})
TRCell():New(oSection4,"C7_QUJE"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| nQuje})
TRCell():New(oSection4,"SALDORES"  ,"   ",STR0060,PesqPict("SC7","C7_QUJE"),/*Tamanho*/,/*lPixel*/,{||nSaldores })
TRCell():New(oSection4,"RESIDUO"   ,"   ",STR0061,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||cResiduo})
                                        
If mv_par10 == 1	
	
	oSection5:= TRSection():New(oReport,STR0068,{"SA5","SA2","SC1"},/*aOrdem*/)
	TRCell():New(oSection5,"A5_FORNECE","SA5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A5_LOJA"   ,"SA5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_TEL"    ,"SA2",/*Titulo*/,/*Picture*/,41,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_CONTATO","SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_FAX"    ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_ULTCOM" ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_MUN"    ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_EST"    ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_RISCO"  ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A5_CODPRF" ,"SA5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
Else	
	oSection5:= TRSection():New(oReport,STR0069,{"SAD","SA2","SC1"},/*aOrdem*/)
	TRCell():New(oSection5,"AD_FORNECE","SAD",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"AD_LOJA"   ,"SAD",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_TEL"    ,"SA2",/*Titulo*/,/*Picture*/,41,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_CONTATO","SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_FAX"    ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_ULTCOM" ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_MUN"    ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_EST"    ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"A2_RISCO"  ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
EndIf

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³11/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao das Solicitacoes de Compras                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasSC1,nReg)

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3) 
Local oSection4 := oReport:Section(4) 
Local oSection5 := oReport:Section(5) 
Local aMeses	:= {STR0005,STR0006,STR0007,STR0008,STR0009,STR0010,STR0011,STR0012,STR0013,STR0014,STR0015,STR0016}		//"Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"###"Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"
Local aOrdem    := {}
Local aSavRec   := {}
Local cMes      := ""
Local cCampos   := ""
Local cEmissao  := ""
Local cGrupo    := ""
Local nX        := 0
Local nY        := 0
Local nRecnoSD4 := 0
Local nAno      := Year(dDataBase)
Local nMes      := Month(dDataBase)
Local nPrinted  := 0
Local nVlrMax   := 0
Local cLmtSol   := ""
Local cQuery := ""
Local cWhere := ""
Local lQuery := .T.
Local aAreaC1:= SC1->(GetArea())
Local cChaveSC1 as string

nVlrMax := val(Replicate('9',TamSX3("C1_QTDREEM")[1]))//Valor maximo para reemissao

Private cDescPro := ""     
Private cNumPc   := ""  
Private cItemPc  := ""
Private cFornec  := ""
Private cLojaFor := ""
Private cNomeFor := ""
Private cUM      := ""   
Private cCond    := ""
Private cResiduo := ""
Private nQuant   := 0
Private nPreco   := 0
Private nTotal   := 0
Private nQuje    := 0 
Private nSaldoRes:= 0  
Private dEmissao := ctod("")
Private dDATPRF  := ctod("")     
Private dPrazo   := ctod("")

If Type("lAuto") == "U"
	lAuto := (nReg!=Nil)
Endif

dbSelectArea("SC1")
dbSetOrder(1)

If lAuto
	dbGoto(nReg)
	cChaveSC1 := SC1->(C1_FILIAL+C1_NUM)
	mv_par01  := SC1->C1_NUM
	mv_par02  := SC1->C1_NUM
	mv_par03  := 1
	mv_par04  := SC1->C1_EMISSAO
	mv_par05  := SC1->C1_EMISSAO
	mv_par06  := "  "
	mv_par07  := "ZZ"
	mv_par13  := 3
	dbSeek(cChaveSC1)
Else
	
 	MakeSqlExpr(oReport:uParam)
    
 	oReport:Section(1):BeginQuery()	

	cWhere := "%" 
	If mv_par03 == 2
		cWhere += " C1_QUANT <> C1_QUJE AND C1_RESIDUO <> 'S' AND "
    EndIf
	cWhere += "%" 

	BeginSql Alias cAliasSC1
	 
		SELECT SC1.*, SC1.R_E_C_N_O_ SC1RECNO
   		  FROM %table:SC1% SC1
		 WHERE C1_FILIAL  = %xFilial:SC1% AND 
   			   C1_NUM      >= %Exp:mv_par01% AND 
 		       C1_NUM      <= %Exp:mv_par02% AND      
	           C1_EMISSAO  >= %Exp:Dtos(mv_par04)% AND 
	           C1_EMISSAO  <= %Exp:Dtos(mv_par05)% AND 
	           C1_ITEM     >= %Exp:mv_par06% AND 
	           C1_ITEM     <= %Exp:mv_par07% AND          
	           %Exp:cWhere%	    
	           SC1.%NotDel% 
		ORDER BY %Order:SC1% 
	EndSql
	
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

EndIf
	
TRPosition():New(oSection1,"SB1",1,{ || xFilial("SB1") + (cAliasSC1)->C1_PRODUTO })
TRPosition():New(oSection1,"SB2",1,{ || xFilial("SB2") + (cAliasSC1)->C1_PRODUTO + (cAliasSC1)->C1_LOCAL })
TRPosition():New(oSection1,"SB3",1,{ || xFilial("SB3") + (cAliasSC1)->C1_PRODUTO })
TRPosition():New(oSection3,"SB3",1,{ || xFilial("SB3") + (cAliasSC1)->C1_PRODUTO })
TRPosition():New(oSection1,"SD4",1,{ || xFilial("SD4") + (cAliasSC1)->C1_PRODUTO })
TRPosition():New(oSection1,"SC7",1,{ || xFilial("SC7") + (cAliasSC1)->C1_NUM + (cAliasSC1)->C1_ITEM })
TRPosition():New(oSection2,"SC2",1,{ || xFilial("SC2") + SD4->D4_OP })
TRPosition():New(oSection4,"SA2",1,{ || xFilial("SA2") + SC7->C7_FORNECE + SC7->C7_LOJA })
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o CodeBlock com o PrintLine da Sessao 1 toda vez que rodar o oSection1:Init()   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:onPageBreak( { || oReport:SkipLine(), oSection1:PrintLine(), oReport:SkipLine(), oReport:ThinLine() })
		
oReport:SetMeter(SC1->(LastRec()))
dbSelectArea(cAliasSC1)               

While !oReport:Cancel() .And. !(cAliasSC1)->(Eof()) .And. (cAliasSC1)->C1_FILIAL == xFilial("SC1") .And. ;
								(cAliasSC1)->C1_NUM >= mv_par01 .And. (cAliasSC1)->C1_NUM <= mv_par02

	oReport:IncMeter()

	If oReport:Cancel()
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra Tipo de OPs Firmes ou Previstas                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !MtrAValOP(mv_par13,"SC1",cAliasSC1 )
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Obtem a string do titulo conforme a SC impressa.           ³
	//³ "Solicitacao de Compra  C.Custo :   a.Emissao"	           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    cEmissao := IIf((cAliasSC1)->C1_QTDREEM > 0 , Str(If((cAliasSC1)->C1_QTDREEM < nVlrMax,(cAliasSC1)->C1_QTDREEM + 1,(cAliasSC1)->C1_QTDREEM) ,2) + STR0045 , " " )//"a.Emissao 
	oReport:SetTitle(STR0002+"     "+STR0043+" "+Substr((cAliasSC1)->C1_NUM,1,6)+" "+STR0018+" "+(cAliasSC1)->C1_CC+Space(20)+cEmissao )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa o descricao do Produto conf. parametro digitado.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SB1->(dbSetOrder(1))
	SB1->(dbSeek( xFilial("SB1") + (cAliasSC1)->C1_PRODUTO ))
	cDescPro := SB1->B1_DESC
	cGrupo   := SB1->B1_GRUPO  
	
	If AllTrim(mv_par08) == "C1_DESCRI"    // Impressao da Descricao do produto do arquivo de Solicitacao SC1.
		cDescPro := (cAliasSC1)->C1_DESCRI           
	ElseIf AllTrim(mv_par08) == "B5_CEME"  // Descricao cientifica do Produto.
		SB5->(dbSetOrder(1))
		If SB5->(dbSeek( xFilial("SB5") + (cAliasSC1)->C1_PRODUTO ))
			cDescPro := SB5->B5_CEME
		EndIf
	EndIf        
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Dispara o codeBlock do OnPageBreak com o PrintLine           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:Init()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao das observacoes da solicitacao (caso exista)       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty((cAliasSC1)->C1_OBS)
		oReport:PrintText(STR0019,,oSection1:Cell("C1_ITEM"):ColPos()) // "OBSERVACOES:"

		For nX := 1 To 258 Step 129
			oReport:PrintText(Substr((cAliasSC1)->C1_OBS,nX,129),,oSection1:Cell("C1_ITEM"):ColPos()) // "OBSERVACOES:"
			If Empty(Substr((cAliasSC1)->C1_OBS,nX+129,129))
				Exit
			Endif
		Next nX

		oReport:ThinLine()

	Endif
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao da requisicoes empenhadas                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par09 == 1
	    oReport:SkipLine() 
		oReport:PrintText(STR0020,,oSection1:Cell("C1_ITEM"):ColPos()) //"REQUISICOES EMPENHADAS:"

		dbSelectArea("SD4")
		If !Eof()

			oSection2:Init()

			While !Eof() .And. SD4->D4_FILIAL + SD4->D4_COD == (cAliasSC1)->C1_FILIAL + (cAliasSC1)->C1_PRODUTO

				nRecnoSD4 := SD4->(Recno())
				If SD4->D4_QUANT <> 0
					oSection2:PrintLine()		    
                EndIf   
				SD4->(dbGoTo(nRecnoSD4))
				SD4->(dbSkip())

			EndDo

			oSection2:Finish()				

        Else
        	oReport:PrintText(STR0021,,oSection1:Cell("C1_ITEM"):ColPos())//"Nao existem requisicoes empenhadas deste item."
		EndIf

		oReport:SkipLine() 
		oReport:ThinLine()

	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao dos Consumos nos ultimos 12 meses                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine() 
	oReport:PrintText(STR0024,,oSection1:Cell("C1_ITEM"):ColPos())	//"CONSUMO DOS ULTIMOS 12 MESES:"

	dbSelectArea("SB3")
	If !Eof()

		oSection3:Init()

		nAno   := Year(dDataBase)
		nMes   := Month(dDataBase)
		aOrdem := {}
	    nY     := 1

		For nX := nMes To 1 Step -1    
			oSection3:Cell("MES"+StrZero(nY,2)):SetTitle("|  "+aMeses[nX]+"/"+StrZero(nAno,4))
			AADD(aOrdem,nX)
            nY++
		Next nX

		nAno--                                 

		For nX := 12 To nMes+1 Step -1
			oSection3:Cell("MES"+StrZero(nY,2)):SetTitle("|  "+aMeses[nX]+"/"+StrZero(nAno,4))
			AADD(aOrdem,nX)
            nY++
		Next nX

		For nX := 1 To Len(aOrdem)
			cMes    := StrZero(aOrdem[nX],2)
			cCampos := "SB3->B3_Q"+cMes
			oSection3:Cell("MES"+StrZero(nX,2)):SetValue(&cCampos)
		Next nX

		oSection3:PrintLine()		    
		oSection3:Finish()				

    Else 
		oReport:PrintText(STR0025,,oSection1:Cell("C1_ITEM"):ColPos())	//"Nao existe registro de consumo anterior deste item."
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao dos ultimos pedidos                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine() 
	oReport:ThinLine()
	oReport:SkipLine() 
	oReport:PrintText(STR0027,,oSection1:Cell("C1_ITEM"):ColPos()) //"ULTIMOS PEDIDOS:"

	dbSelectArea("SC7")
	dbSetOrder(4)
	Set SoftSeek On
	dbSeek(xFilial("SC7")+(cAliasSC1)->C1_PRODUTO+"z")
	Set SoftSeek Off
	dbSkip(-1)
	If (cAliasSC1)->C1_FILIAL + (cAliasSC1)->C1_PRODUTO == SC7->C7_FILIAL + SC7->C7_PRODUTO
		nPrinted := 0

		oSection4:Init()

		While !Bof() .And. (cAliasSC1)->C1_FILIAL + (cAliasSC1)->C1_PRODUTO == SC7->C7_FILIAL + SC7->C7_PRODUTO			
			cNumPc   := SC7->C7_NUM
			cItemPc  := SC7->C7_ITEM
			cFornec  := SC7->C7_FORNECE
			cLojaFor := SC7->C7_LOJA
			cCond    := SC7->C7_COND
			cUM      := SC7->C7_UM 	  
			cResiduo := IIf(Empty(SC7->C7_RESIDUO),STR0062,STR0063) 	
			nQuant   := SC7->C7_QUANT
			nPreco   := SC7->C7_PRECO
			nTotal   := SC7->C7_TOTAL
			dEmissao := SC7->C7_EMISSAO 
			dDATPRF  := SC7->C7_DATPRF   
			dPrazo   := SC7->C7_DATPRF - SC7->C7_EMISSAO  	
			nQuje    := SC7->C7_QUJE          
			nSaldoRes:= Iif(Empty(SC7->C7_RESIDUO),SC7->C7_QUANT - SC7->C7_QUJE,0)                                                               
		
			SA2->(dbSetOrder(1))
			SA2->(dbSeek(xFilial("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA))
			cNomeFor := SA2->A2_NOME     
		
			nPrinted++
			If nPrinted > mv_par11
				Exit
			EndIf

			oSection4:PrintLine()
			
			dbSkip(-1)
		EndDo
		
		oSection4:Finish()

	Else
		oReport:PrintText(STR0028,,oSection1:Cell("C1_ITEM"):ColPos())	//"Nao existem pedidos cadastrados para este item."
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os fornecedores indicados para este produto          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine() 
	oReport:ThinLine()
	oReport:SkipLine() 
	oReport:PrintText(STR0030,,oSection1:Cell("C1_ITEM"):ColPos()) //"FORNECEDORES:"
	
	If mv_par10 == 1                                                  
		
		dbSelectArea("SA5")
		dbSetOrder(2)
		dbSeek(xFilial("SA5")+(cAliasSC1)->C1_PRODUTO)

		If !Eof()
			nPrinted := 0
			oSection5:Init()

			While !Eof() .And. xFilial("SA5") + (cAliasSC1)->C1_PRODUTO == SA5->A5_FILIAL + SA5->A5_PRODUTO
				If SA2->(dbSeek(xFilial("SA2")+SA5->A5_FORNECE+SA5->A5_LOJA))
					nPrinted++
					If nPrinted > mv_par12
						Exit
					EndIf
					oSection5:PrintLine()
                EndIf    
                
				dbSkip()
			EndDo
			oSection5:Finish()
		Else
			oReport:PrintText(STR0031,,oSection1:Cell("C1_ITEM"):ColPos())	//"Nao existem fornecedores cadastrados para este item."
		EndIf
	Else                                                                            
		dbSelectArea("SAD")
		dbSetOrder(2)
		dbSeek(xFilial()+cGrupo)

		If !Eof()
			nPrinted := 0
			oSection5:Init()
			While !Eof() .And. SAD->AD_FILIAL + SAD->AD_GRUPO == xFilial("SAD") + cGrupo
				If SA2->(dbSeek(xFilial("SA2")+SAD->AD_FORNECE+SAD->AD_LOJA))
					nPrinted++
					If nPrinted > mv_par12
						Exit
					EndIf
					oSection5:PrintLine()
                EndIf    
				dbSkip()
			EndDo
        Else 
			oReport:PrintText(STR0031,,oSection1:Cell("C1_ITEM"):ColPos())	//"Nao existem fornecedores cadastrados para este item."
		EndIf
		oSection5:Finish()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do codigo alternativo                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine() 
	oReport:ThinLine()
	oReport:SkipLine() 

	If !Empty(SB1->B1_ALTER)
		SB2->(dbSeek(xFilial("SB2") + SB1->B1_ALTER + (cAliasSC1)->C1_LOCAL ))
		oReport:PrintText(STR0034+" "+SB1->B1_ALTER+" "+STR0035+" "+Transform(SB2->B2_QATU,PesqPict("SB2","B2_QATU",12)+" "+SC1->C1_UM ),,oSection1:Cell("C1_ITEM"):ColPos()) //"Codigo Alternativo : " "Saldo do Alternativo :"
	Else
		oReport:PrintText(STR0034 + " " + STR0036,,oSection1:Cell("C1_ITEM"):ColPos()) //"Codigo Alternativo : " ### "Nao ha'"
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do quadro de concorrencias                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSC1)

	oReport:SkipLine() 
	oReport:ThinLine()
	oReport:SkipLine() 
	
	oReport:SkipLine() 
	oReport:ThinLine()
	oReport:SkipLine() 

	oReport:PrintText(STR0037,,oSection1:Cell("C1_ITEM"):ColPos()) //"|  C O N C O R R E N C I A S                  | ENTREGA         | OBSERVACOES                        | COND.PGTO        |  CONTATO         |QUANTIDADE      |  PRECO UNITARIO             | IPI     |     VALOR            |"
	oReport:PrintText("|---------------------------------------------|-----------------|------------------------------------|------------------|------------------|----------------|-----------------------------|---------|----------------------|",,oSection1:Cell("C1_ITEM"):ColPos())
	For nX :=1 To 4
	oReport:PrintText("|                                             |                 |                                    |                  |                  |                |                             |         |                      |",,oSection1:Cell("C1_ITEM"):ColPos())
	oReport:PrintText("|---------------------------------------------|-----------------|------------------------------------|------------------|------------------|----------------|-----------------------------|---------|----------------------|",,oSection1:Cell("C1_ITEM"):ColPos())
	Next nX
	oReport:SkipLine() 
	oReport:PrintText("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",,oSection1:Cell("C1_ITEM"):ColPos())
	oReport:PrintText(STR0038,,oSection1:Cell("C1_ITEM"):ColPos())
	oReport:PrintText("|                                                                                                            |                                                                                                             |",,oSection1:Cell("C1_ITEM"):ColPos())
	oReport:PrintText("|   ------------------------------------------------------------------------------------------------------   |   -------------------------------------------------------------------------------------------------------   |",,oSection1:Cell("C1_ITEM"):ColPos())
	oReport:PrintText("|                "+PADC(AllTrim((cAliasSC1)->C1_SOLICIT),15)+"                                                                             |                    "+ Padc(AllTrim((cAliasSC1)->C1_NOMAPRO),15)+ "                                                                          |",,oSection1:Cell("C1_ITEM"):ColPos())
	oReport:PrintText("|                                                                                                            |                                                                                                             |",,oSection1:Cell("C1_ITEM"):ColPos())
	oReport:PrintText("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",,oSection1:Cell("C1_ITEM"):ColPos())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Guarda o Recno para a gravacao do numero de reemissao da SC³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If Ascan(aSavRec,IIf(lQuery .And. !lAuto ,(cAliasSC1)->SC1RECNO,Recno())) == 0	
		AADD(aSavRec,IIf(lQuery .And. !lAuto ,(cAliasSC1)->SC1RECNO,Recno()))
	Endif

	dbSelectArea(cAliasSC1)
	dbSkip()
	oSection1:Finish()
    oReport:EndPage() 
EndDo
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Grava o numero de reemissao da SC.                             |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC1")
If Len(aSavRec) > 0 
	For nX:=1 to Len(aSavRec)
		dbGoto(aSavRec[nX])
		If C1_QTDREEM < nVlrMax
			RecLock("SC1",.F.)  //Atualizacao do flag de Impressao
			Replace C1_QTDREEM With (C1_QTDREEM+1)
			MsUnLock()
		Else
			cLmtSol += SC1->C1_NUM + ","
		EndIf
	Next nX
EndIf

If !Empty(cLmtSol)
	Aviso(STR0073,STR0070 + "'" + Alltrim(str(nVlrMax)) + "'" + STR0071 + SubStr(cLmtSol,1,len(cLmtSol)-1) + STR0072,{"OK"})
EndIf

RestArea(aAreaC1)
Return Nil
