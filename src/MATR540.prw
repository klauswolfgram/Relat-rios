/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR540.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR540  ³ Autor ³ Marco Bianchi            ³ Data ³ 23/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Comissoes.                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR540(void)                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function Matr540()

Local oReport	 := Nil
Local aPDFields	 := {"A3_NOME","A1_NOME"}

//-- Interface de impressao
//Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
FATPDLoad(Nil,Nil,aPDFields)     
oReport := ReportDef() 
oReport:PrintDialog()  
//Finaliza o gerenciamento dos campos com proteção de dados.
FATPDUnLoad()

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³23/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oComissaoA
Local oComissaoS
Local oDetalhe
Local oTotal,oGeral
Local cVend  		:= ""
Local dVencto   	:= CTOD( "" ) 
Local dBaixa    	:= CTOD( "" ) 
Local nVlrTitulo	:= 0
Local nBasePrt  	:= 0
Local nComPrt   	:= 0
Local cTipo     	:= ""
Local cLiquid 		:= ""
Local aValLiq   	:= {}
Local nI2       	:= 0
Local aLiqProp  	:= {}
Local nValIR    	:= 0
Local nTotSemIR 	:= 0
Local nAc1			:= 0
Local nAc2			:= 0
Local nAc3      	:= 0
Local nTamData  	:= Len(DTOC(MsDate()))
Local lRndIrrf		:= GetMV("MV_RNDIRF")
Local cAlias		:= GetNextAlias()

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

oReport := TReport():New("MATR540",STR0025,"MTR540", {|oReport| ReportPrint(oReport,cAlias,oComissaoA,oComissaoS,oDetalhe,oTotal,oGeral)},STR0026)
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

Pergunte("MTR540",.F.)
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
oComissaoA := TRSection():New(oReport,STR0050,{"SE3","SA3"},{STR0046,STR0047},/*Campos do SX3*/,/*Campos do SIX*/)
oComissaoA:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Analitico                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oComissaoA,"E3_VEND" ,"SE3",/*Titulo*/,/*Picture*/                ,/*Tamanho*/         ,/*lPixel*/  ,{|| cVend })
TRCell():New(oComissaoA,"A3_NOME" ,"SA3",/*Titulo*/,/*Picture*/                ,/*Tamanho*/         ,/*lPixel*/  ,{|| FATPDObfuscate(SA3->A3_NOME,"A3_NOME") })  

// Titulos da Comissao
oDetalhe := TRSection():New(oComissaoA,STR0048,{"SE3","SA3","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oDetalhe:SetTotalInLine(.F.)
oDetalhe:SetHeaderBreak(.T.)
TRCell():New(oDetalhe,"E3_PREFIXO" 	,cAlias,/*Titulo*/,/*Picture*/               ,/*Tamanho*/  ,/*lPixel*/,{|| SE3->E3_PREFIXO })
TRCell():New(oDetalhe,"E3_NUM"		,cAlias,/*Titulo*/,/*Picture*/               ,/*Tamanho*/  ,/*lPixel*/,{|| SE3->E3_NUM })
TRCell():New(oDetalhe,"E3_PARCELA" 	,cAlias,/*Titulo*/,/*Picture*/               ,/*Tamanho*/  ,/*lPixel*/,{|| SE3->E3_PARCELA })
TRCell():New(oDetalhe,"E3_CODCLI"	,cAlias,/*Titulo*/,/*Picture*/               ,/*Tamanho*/  ,/*lPixel*/,{|| SA1->A1_COD })
TRCell():New(oDetalhe,"NOMCLI"      ,"   " ,Iif(MV_PAR14 == 1,RetTitle("A1_NREDUZ"),RetTitle("A1_NOME")),/*Picture*/               ,30			,/*lPixel*/,{|| cNomCli := Iif(MV_PAR14 == 1,SA1->A1_NREDUZ,SA1->A1_NOME) ,Substr(FATPDObfuscate(cNomCli,"A1_NOME"),1,30) })
TRCell():New(oDetalhe,"E3_EMISSAO"	,cAlias,/*Titulo*/,/*Picture*/               ,nTamData  ,/*lPixel*/,{|| SE3->E3_EMISSAO })
TRCell():New(oDetalhe,"DVENCTO"		,"    ",STR0033   ,/*Picture*/               ,nTamData  ,/*lPixel*/,{|| dVencto })
TRCell():New(oDetalhe,"DBAIXA"		,"    ",STR0034   ,/*Picture*/               ,nTamData  ,/*lPixel*/,{|| dBaixa })
TRCell():New(oDetalhe,"E3_DATA"		,cAlias,/*Titulo*/,/*Picture*/               ,nTamData  ,/*lPixel*/,{|| SE3->E3_DATA })
TRCell():New(oDetalhe,"E3_PEDIDO"	,cAlias,STR0039   ,/*Picture*/               ,/*Tamanho*/  ,/*lPixel*/,{|| SE3->E3_PEDIDO })
TRCell():New(oDetalhe,"NVLRTITULO"	,"    ",STR0035,PesqPict('SE3','E3_BASE')	 ,TamSx3("E3_BASE"	)[1],/*lPixel*/,{|| 5,5 }) //nVlrTitulo })
TRCell():New(oDetalhe,"NBASEPRT"	,"    ",STR0036,PesqPict('SE3','E3_BASE')	 ,TamSx3("E3_BASE"	)[1],/*lPixel*/,{|| nBasePrt })
TRCell():New(oDetalhe,"E3_PORC"		,cAlias,STR0032,PesqPict('SE3','E3_PORC')	 ,TamSx3("E3_PORC"  )[1],/*lPixel*/,{|| SE3->E3_PORC })
TRCell():New(oDetalhe,"NCOMPRT"		,"    ",STR0038,PesqPict('SE3','E3_COMIS')   ,TamSx3("E3_COMIS" )[1],/*lPixel*/,{|| nComPrt })
TRCell():New(oDetalhe,"E3_BAIEMI"	,cAlias,STR0040,/*Picture*/                  ,/*Tamanho*/  ,/*lPixel*/,{|| Substr(cTipo,1,1) })
TRCell():New(oDetalhe,"AJUSTE"		,"    ",STR0037,/*Picture*/                  ,/*Tamanho*/  ,/*lPixel*/,{|| ""})

// Titulos de Liquidacao
oLiquida := TRSection():New(oDetalhe,STR0051,{"SE1","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oLiquida:SetTotalInLine(.F.)
TRCell():New(oLiquida,"E1_NUMLIQ" 	,"   ",/*Titulo*/ ,/*Picture*/                ,/*Tamanho*/  		,/*lPixel*/,{|| cLiquid })
TRCell():New(oLiquida,"E1_PREFIXO"	,"SE1",/*Titulo*/ ,/*Picture*/                ,/*Tamanho*/  		,/*lPixel*/,{|| SE1->E1_PREFIXO })
TRCell():New(oLiquida,"E1_NUM"	    ,"SE1",/*Titulo*/ ,/*Picture*/                ,/*Tamanho*/  		,/*lPixel*/,{|| SE1->E1_NUM })
TRCell():New(oLiquida,"E1_PARCELA" 	,"SE1",/*Titulo*/ ,/*Picture*/                ,/*Tamanho*/  		,/*lPixel*/,{|| SE1->E1_PARCELA })
TRCell():New(oLiquida,"E1_TIPO"   	,"SE1",/*Titulo*/ ,/*Picture*/                ,/*Tamanho*/  		,/*lPixel*/,{|| SE1->E1_TIPO })
TRCell():New(oLiquida,"E1_CLIENTE"	,"SE1",/*Titulo*/ ,/*Picture*/                ,/*Tamanho*/  		,/*lPixel*/,{|| SE1->E1_CLIENTE })
TRCell():New(oLiquida,"E1_LOJA"		,"SE1",/*Titulo*/ ,/*Picture*/                ,/*Tamanho*/  		,/*lPixel*/,{|| SE1->E1_LOJA })
TRCell():New(oLiquida,"NOMCLI"   	,"   ",Iif(MV_PAR14 == 1,RetTitle("A1_NREDUZ"),RetTitle("A1_NOME")),/*Picture*/               ,30			,/*lPixel*/,{||  cNomCli := Iif(MV_PAR14 == 1,SA1->A1_NREDUZ,SA1->A1_NOME) ,Substr(FATPDObfuscate(cNomCli,"A1_NOME"),1,30) })
TRCell():New(oLiquida,"E1_VALOR"		,"SE1",/*Titulo*/ ,Tm(SE1->E1_VALOR,15,2)    ,/*Tamanho*/  		,/*lPixel*/,{|| SE1->E1_VALOR })
TRCell():New(oLiquida,"NVALLIQ1"		,"   ",STR0043    ,/*Picture*/                ,nTamData	     		,/*lPixel*/,{|| aValLiq[nI2,1] })
TRCell():New(oLiquida,"NVALLIQ2"		,"   ",STR0044    ,Tm(SE1->E1_VALOR,15,2)    ,/*Tamanho*/  		,/*lPixel*/,{|| aValLiq[nI2,2] })
TRCell():New(oLiquida,"NLIQPROP"		,"   ",STR0045    ,Tm(SE1->E1_VALOR,15,2)    ,/*Tamanho*/  		,/*lPixel*/,{|| aLiqProp[nI2] })

//-- Secao Totalizadora do Valor do IR e Total (-) IR
oTotal := TRSection():New(oReport,"",{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
TRCell():New(oTotal,"TOTALIR"     ,"   ",STR0028,"@E 99,999,999.99",12         ,/*lPixel*/,{|| If(lRndIrrf,Round(nValIR,TamSX3("E2_IRRF")[2]),NoRound(nValIR,TamSX3("E2_IRRF")[2])) })
TRCell():New(oTotal,"TOTSEMIR"    ,"   ",STR0029,"@E 99,999,999.99",12         ,/*lPixel*/,{|| nTotSemIR })  

//-- TOTAL GERAL
oGeral := TRSection():New(oTotal,"",{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
TRCell():New(oGeral, "TXTTOTAL"          , "" , STR0052  , , 08 ,/*lPixel*/,{ || "" } )    
TRCell():New(oGeral, "GERAL"	         , "" , STR0053  , PesqPict('SE3','E3_COMIS')    	, TamSX3("E3_COMIS")[1]   ,/*lPixel*/,/*CodeBlock*/)
TRCell():New(oGeral, "PERCENT"	         , "" , STR0054  , PesqPict("SE3","E3_PORC" )   	, TamSX3("E3_PORC" )[1]   ,/*lPixel*/,/*CodeBlock*/)
TRCell():New(oGeral, "COMIS"		     , "" , STR0055  , PesqPict('SE3','E3_COMIS')    	, TamSX3("E3_COMIS")[1]   ,/*lPixel*/,/*CodeBlock*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sintetico                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oComissaoS := TRSection():New(oReport,STR0049,{"SE3","SA3"},{STR0046,STR0047},/*Campos do SX3*/,/*Campos do SIX*/)
oComissaoS:SetTotalInLine(.F.)

TRCell():New(oComissaoS,"E3_VEND" ,"SE3",/*Titulo*/,/*Picture*/                	,/*Tamanho*/          	,/*lPixel*/	,{|| cVend })
TRCell():New(oComissaoS,"A3_NOME" ,"SA3",/*Titulo*/,/*Picture*/					,/*Tamanho*/          	,/*lPixel*/	,{|| SA3->A3_NOME })
TRCell():New(oComissaoS,"TOTALTIT",""		,STR0027   ,PesqPict('SE3','E3_BASE') 	,TamSx3("E3_BASE")[1] 	,/*lPixel*/	,{|| nAc3 })
TRCell():New(oComissaoS,"E3_BASE" ,cAlias,STR0030   ,PesqPict('SE3','E3_BASE') 	,TamSx3("E3_BASE")[1] 	,/*lPixel*/	,{|| nAc1 })
TRCell():New(oComissaoS,"E3_PORC" ,cAlias,STR0032   ,PesqPict('SE3','E3_PORC') 	,TamSx3("E3_PORC")[1] 	,/*lPixel*/	,{||NoRound((nAc2*100) / nAc1),2})
TRCell():New(oComissaoS,"E3_COMIS",cAlias,STR0031   ,PesqPict('SE3','E3_COMIS')	,TamSx3("E3_COMIS")[1]	,/*lPixel*/	,{|| nAc2 })
TRCell():New(oComissaoS,"VALIR"   ,""   	,STR0028   ,PesqPict('SE3','E3_COMIS')	,TamSx3("E3_COMIS")[1]	,/*lPixel*/	,{|| If(lRndIrrf,Round(nValIR,TamSX3("E2_IRRF")[2]),NoRound(nValIR,TamSX3("E2_IRRF")[2])) })
TRCell():New(oComissaoS,"TOTSEMIR",""   	,STR0029   ,PesqPict('SE3','E3_COMIS')	,TamSx3("E3_COMIS")[1]	,/*lPixel*/	,{||nTotSemIR})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no topo da pagina                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetHeaderPage()
oReport:Section(3):SetHeaderPage() 
oReport:Section(1):Setedit(.T.)
oReport:Section(1):Section(1):Setedit(.T.)
oReport:Section(1):Section(1):Section(1):Setedit(.T.)
oReport:Section(2):Setedit(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alinhamento a direita dos campos de valores                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Analitico
oDetalhe:Cell("NVLRTITULO"):SetHeaderAlign("RIGHT")
oDetalhe:Cell("NBASEPRT"):SetHeaderAlign("RIGHT")
oDetalhe:Cell("NCOMPRT"):SetHeaderAlign("RIGHT")
//Sintetico
oComissaoS:Cell("TOTALTIT"):SetHeaderAlign("RIGHT")
oComissaoS:Cell("E3_BASE" ):SetHeaderAlign("RIGHT")
oComissaoS:Cell("E3_COMIS"):SetHeaderAlign("RIGHT")
oComissaoS:Cell("VALIR"   ):SetHeaderAlign("RIGHT")
oComissaoS:Cell("TOTSEMIR"):SetHeaderAlign("RIGHT")

//IR
oTotal:Cell("TOTALIR"):SetHeaderAlign("RIGHT")
oTotal:Cell("TOTSEMIR"):SetHeaderAlign("RIGHT")         

//TOTAL GERAL
oGeral:Cell("TXTTOTAL"):SetHeaderAlign("RIGHT")
oGeral:Cell("GERAL"   ):SetHeaderAlign("RIGHT") 
oGeral:Cell("PERCENT" ):SetHeaderAlign("RIGHT")
oGeral:Cell("COMIS"   ):SetHeaderAlign("RIGHT")

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo Riera          ³ Data ³04.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAlias,oComissaoA,oComissaoS,oDetalhe,oTotal,oGeral)
Local dEmissao 	 as Date
Local nTotLiq  	 as Numeric
Local aLiquid    as Array
Local ny 	   	 as Numeric
Local cWhere   	 as Character
Local cNomArq    as Character
Local cFilialSE1 as Character
Local cFilialSE3 as Character
Local nI       	 as Numeric
Local cOrder   	 as Character
Local nDecs	   	 as Numeric
Local nTotPorc	 as Numeric
Local nTotPerVen as Numeric
Local nTotPerGer as Numeric
Local nTaxa	     as Numeric
Local cDocLiq    as Character
Local cTitulo    as Character
Local cAjuste    as Character
Local nTotBase	 as Numeric
Local nTotComis	 as Numeric
Local nSection	 as Numeric
Local nOrdem	 as Numeric
Local nTGerBas   as Numeric
Local nTGerCom   as Numeric
Local cFilSE1	 as Character
Local cFilSE3    as Character
Local cFilSA1    as Character
Local lVend	     as Logical
Local lFirst     as Logical
Local lRndIrrf	 as Logical
Local lUseOffBal as Logical
Local cQuery     as Character
Local aStruSE3   as Array
Local aStruQry   as Array
Local aSelect    as Array
Local nPosQry    as Numeric
	
	dEmissao 	:= CTOD( "" ) 
	nTotLiq  	:= 0
	aLiquid  	:= {}
	ny 		 	:= 0
	cWhere   	:= ""
	cNomArq  	:= ""
	cFilialSE1  := ""
	cFilialSE3  := ""
	nI       	:= 0
	cOrder   	:= ""
	nDecs	 	:= 0
	nTotPorc	:= 0
	nTotPerVen	:= 0
	nTotPerGer	:= 0
	nTaxa		:= 0
	cDocLiq   	:= ""
	cTitulo   	:= ""                                     
	cAjuste   	:= ""
	nTotBase	:= 0
	nTotComis	:= 0
	nSection	:= 0
	nOrdem		:= 0
	nTGerBas  	:= 0
	nTGerCom  	:= 0
	cFilSE1		:= "" 
	cFilSE3   	:= "" 
	cFilSA1   	:= "" 
	lVend	    := .F.
	lFirst    	:= .F.
	lRndIrrf 	:= GetMV("MV_RNDIRF")
	lUseOffBal  := FindFunction("RskIsActive") .And. RskIsActive()	
	aSelect 	:= {}
	aStruSE3    := {}
	aStruQry    := {}	
	nPosQry     := 0		

If oReport:Section(1):GetOrder() == 1		// Ordem: por Titulo
	nOrdem := 1
Else										// Ordem: por Cliente
	nOrdem := 2
EndIf	

If mv_par12 == 1	// Analitico
	oReport:Section(3):Disable()
	nSection := 1   
	
	oReport:Section(1):section(1):Cell("NOMCLI"):SetTitle( Iif(mv_par14 == 1,RetTitle("A1_NREDUZ"),RetTitle("A1_NOME")) )
	oReport:Section(1):section(1):section(1):Cell("NOMCLI"):SetTitle( Iif(mv_par14 == 1,RetTitle("A1_NREDUZ"),RetTitle("A1_NOME")) )
	
	oReport:Section(1):Cell("E3_VEND"):SetBlock({|| cVend })
	oReport:Section(1):Section(1):Cell("DVENCTO" ):SetBlock({|| dVencto })	
	oReport:Section(1):Section(1):Cell("DBAIXA" ):SetBlock({|| dBaixa })	
	oReport:Section(1):Section(1):Cell("NVLRTITULO" ):SetBlock({|| nVlrTitulo })	
	oReport:Section(1):Section(1):Cell("NBASEPRT" ):SetBlock({|| nBasePrt })	
	oReport:Section(1):Section(1):Cell("NCOMPRT" ):SetBlock({|| nComPrt })	
	oReport:Section(1):Section(1):Cell("E3_BAIEMI" ):SetBlock({|| Substr(cTipo,1,1) })	
	oReport:Section(1):Section(1):Cell("AJUSTE" ):SetBlock({|| IIf( (cAjuste == "S" .And. MV_PAR07 == 1),"AJUSTE","" ) })	
	oReport:Section(1):Section(1):Section(1):Cell("E1_NUMLIQ" ):SetBlock({|| cLiquid  })	
	oReport:Section(1):Section(1):Section(1):Cell("NVALLIQ1" ):SetBlock({|| aValLiq[nI2,1] })	
	oReport:Section(1):Section(1):Section(1):Cell("NVALLIQ2" ):SetBlock({|| aValLiq[nI2,2] })	
	oReport:Section(1):Section(1):Section(1):Cell("NLIQPROP" ):SetBlock({|| aLiqProp[nI2] })	
	oReport:Section(2):Cell("TOTALIR" ):SetBlock({|| If(lRndIrrf,Round(nValIR,TamSX3("E2_IRRF")[2]),NoRound(nValIR,TamSX3("E2_IRRF")[2])) })	
	oReport:Section(2):Cell("TOTSEMIR" ):SetBlock({|| nTotSemIR })	

    bVOrig := { || cDocLiq := SE1->E1_NUMLIQ, nVlrTitulo := Iif(cTitulo <> (cAlias)->E3_PREFIXO+(cAlias)->E3_NUM+(cAlias)->E3_PARCELA+(cAlias)->E3_TIPO+(cAlias)->E3_VEND+(cAlias)->E3_CODCLI+(cAlias)->E3_LOJA, nVlrTitulo, 0 ) }
    
	TRFunction():New(oDetalhe:Cell("NVLRTITULO"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,bVOrig,.T./*lEndSection*/,IIf(mv_par11 == 2,.T.,.F.)/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oDetalhe:Cell("NBASEPRT")  ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,IIf(mv_par11 == 2,.T.,.F.)/*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oDetalhe:Cell("NCOMPRT")   ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict('SE3','E3_COMIS'),/*uFormula*/,.T./*lEndSection*/,IIf(mv_par11 == 2,.T.,.F.)/*lEndReport*/,/*lEndPage*/)	
	TRFunction():New(oDetalhe:Cell("E3_PORC")   ,/* cID */,"ONPRINT",/*oBreak*/,/*cTitle*/,PesqPict('SE3','E3_PORC'),{|| nTotPorc },.T./*lEndSection*/,IIf(mv_par11 == 2,.T.,.F.)/*lEndReport*/,/*lEndPage*/)

	cVend		:= ""
	dVencto 	:= ctod("  /  /  ")
	dBaixa 		:= ctod("  /  /  ") 
	nVlrTitulo 	:= 0
	nBasePrt 	:= 0
	nComPrt 	:= 0
	cTipo 		:= ""
	cLiquid  	:= ""
	nValIR		:= 0
	nTotSemIR 	:= 0
	
Else				// Sintetico

	TRFunction():New(oComissaoS:Cell("TOTALTIT"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oComissaoS:Cell("E3_BASE"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oComissaoS:Cell("E3_PORC"),/* cID */,"ONPRINT",/*oBreak*/,/*cTitle*/,PesqPict('SE3','E3_PORC'),{||nTotPorc},.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oComissaoS:Cell("E3_COMIS"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,PesqPict('SE3','E3_COMIS'),/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oComissaoS:Cell("VALIR"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
	TRFunction():New(oComissaoS:Cell("TOTSEMIR"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
              
	oReport:Section(1):Disable()
	oReport:Section(1):Section(1):Disable()
	oReport:Section(1):Section(1):Section(1):Disable()
	nSection := 3
	
	oReport:Section(3):Cell("E3_VEND" ):SetBlock({|| cVend })		
	oReport:Section(3):Cell("TOTALTIT" ):SetBlock({|| nAc3 })		
	oReport:Section(3):Cell("E3_BASE" ):SetBlock({|| nAc1 })		
	oReport:Section(3):Cell("E3_PORC" ):SetBlock({||NoRound((nAc2*100) / nAc1,TamSX3("E3_PORC")[2]) })		
	oReport:Section(3):Cell("E3_COMIS" ):SetBlock({||nAc2 })		
	oReport:Section(3):Cell("VALIR" ):SetBlock({|| If(lRndIrrf,Round(nValIR,TamSX3("E2_IRRF")[2]),NoRound(nValIR,TamSX3("E2_IRRF")[2])) })	
	oReport:Section(3):Cell("TOTSEMIR" ):SetBlock({|| nTotSemIR })	

	cVend		:= ""
	nAc1		:= 0
	nAc2		:= 0
	nAc3		:= 0
	nValIR		:= 0
	nTotSemIR	:= 0
	
EndIf
If len(oReport:Section(1):GetAdvplExp("SE1")) > 0
   cFilSE1 := oReport:Section(1):GetAdvplExp("SE1")
EndIf
If len(oReport:Section(3):GetAdvplExp("SE3")) > 0
   cFilSE3 := oReport:Section(3):GetAdvplExp("SE3")
EndIf
If len(oReport:Section(1):GetAdvplExp("SA1")) > 0
   cFilSA1 := oReport:Section(1):GetAdvplExp("SA1")
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


// Indexa de acordo com ordem escolhida oelo cliente
dbSelectArea("SE3")
If nOrdem == 1		// Ordem: por Titulo
	dbSetOrder(2)   
	cOrder := "E3_FILIAL,E3_VEND,E3_PREFIXO,E3_NUM,E3_PARCELA"
Else										// Ordem: por Cliente
	dbSetOrder(3)
	cOrder := "E3_FILIAL,E3_VEND,E3_CODCLI,E3_LOJA,E3_PREFIXO,E3_NUM,E3_PARCELA"
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)	

oReport:Section(nSection):BeginQuery()

If mv_par01 == 1
	cWhere += "AND E3_BAIEMI <> 'B'"  //Baseado pela emissao da NF
Elseif mv_par01 == 2
	cWhere += "AND E3_BAIEMI =  'B'"  //Baseado pela baixa do titulo
EndIf
If mv_par06 == 1 		//Comissoes a pagar
	cWhere += "AND E3_DATA = '" + Dtos(Ctod("")) + "'"
ElseIf mv_par06 == 2 //Comissoes pagas
	cWhere += "AND E3_DATA <> '" + Dtos(Ctod("")) + "'"
Endif
If ValType(mv_par15) == "N"
	If mv_par15 <> 1 // Todos
		If mv_par15 == 2 // Parceiros
			cWhere += "AND A3_TIPO = 'P'"
		ElseIf mv_par15 == 3 // Vendedores
			cWhere += "AND A3_TIPO <> 'P'"
		EndIf
	EndIf
EndIf
cWhere += " ORDER BY " + cOrder
cWhere := "%" + cWhere + "%"

If lUseOffBal

	aStruSE3 := SE3->(dbStruct())
	
	cQuery := "SELECT "
	cQuery += "	E3_FILIAL,E3_BASE, E3_COMIS, E3_VEND, E3_PORC, A3_NOME, "
	cQuery += "	E3_PREFIXO,E3_NUM, E3_PARCELA,E3_TIPO,E3_AJUSTE,E3_BAIEMI, "
	cQuery += "	E3_EMISSAO,E3_DATA,E3_PEDIDO,E3_SEQ, "
	cQuery += "	CASE "
	cQuery += "		WHEN COALESCE(AR1_CLIENT,'') = '' THEN E3_CODCLI "
	cQuery += "		ELSE AR1_CLIENT "
	cQuery += "	END AS E3_CODCLI, "
	cQuery += "	CASE "
	cQuery += "		WHEN COALESCE(AR1_CLIENT,'') = '' THEN E3_LOJA "
	cQuery += "		ELSE AR1_LOJA "
	cQuery += "	END AS E3_LOJA "
	cQuery += "FROM ? SE3 "
	cQuery += "LEFT JOIN ? SA3 "
	cQuery += "	ON A3_COD = E3_VEND "
	cQuery += "LEFT JOIN ? AR2 "
	cQuery += "	ON AR2_FILTIT = E3_FILIAL "
	cQuery += "	AND AR2_TIPO = E3_TIPO "
	cQuery += "	AND AR2_NUMTIT = E3_NUM "
	cQuery += "	AND AR2_PREFIX = E3_PREFIXO "
	cQuery += "	AND AR2_PARC = E3_PARCELA "
	cQuery += "	AND AR2.D_E_L_E_T_ = ' ' "
	cQuery += "LEFT JOIN ? AR1 "
	cQuery += "	ON AR2_FILIAL = AR1_FILIAL "
	cQuery += "	AND AR2_COD = AR1_COD "
	cQuery += "	AND AR1.D_E_L_E_T_ = ' ' "
	cQuery += "WHERE A3_FILIAL = ? "
	cQuery += "	AND E3_FILIAL = ? "
	cQuery += "	AND	E3_EMISSAO >= ? " //mv_par02
	cQuery += "	AND E3_EMISSAO <= ? " //mv_par03
	cQuery += "	AND SE3.E3_VEND BETWEEN ? AND ? " //MV_PAR04 e MV_PAR05
	cQuery += "	AND SA3.D_E_L_E_T_ = ' ' "
	cQuery += "	AND SE3.D_E_L_E_T_ = ' ' "		
	cQuery += "	? "		
	
	cQuery := ChangeQuery(cQuery)	
	oDetalhe := FWPreparedStatement():New(cQuery)

	oDetalhe:SetUnsafe(1,RetSqlName("SE3"))
	oDetalhe:SetUnsafe(2,RetSqlName("SA3"))
	oDetalhe:SetUnsafe(3,RetSqlName("AR2"))
	oDetalhe:SetUnsafe(4,RetSqlName("AR1"))
	oDetalhe:SetString(5,xFilial("SA3"))
	oDetalhe:SetString(6,xFilial("SE3"))
	oDetalhe:SetString(7,DtoS(mv_par02))
	oDetalhe:SetString(8,DtoS(mv_par03))
	oDetalhe:SetString(9,mv_par04)
	oDetalhe:SetString(10,mv_par05)
	oDetalhe:SetUnsafe(11,replace(cWhere,"%",""))

    cQuery := oDetalhe:GetFixQuery()		
	cAlias := MPSysOpenQuery( cQuery )	
	oDetalhe:doTcSetField(cAlias)

	aStruQry	:= &(cAlias)->(dbStruct())	
	For nY := 1 To Len(aStruSE3)
		If aStruSE3[nY][2] <> "C"
			//Verificar se o campo existe na query antes do TcSetField
			nPosQry	:= aScan(aStruQry,{|x|(x[1])==Trim(aStruSE3[nY][1])})
			If nPosQry > 0
				Aadd( aSelect, {aStruSE3[nY][1],aStruSE3[nY][2],aStruSE3[nY][3],aStruSE3[nY][4]})
			EndIf
		EndIf
	Next nY

	oDetalhe:setFields(aSelect)
	oDetalhe:doTcSetField(cAlias)

Else
	BEGIN REPORT QUERY oDetalhe
		BeginSql Alias cAlias
		SELECT E3_FILIAL,E3_BASE, E3_COMIS, E3_VEND, E3_PORC, A3_NOME, E3_PREFIXO,E3_NUM, E3_PARCELA,E3_TIPO,E3_CODCLI,E3_LOJA,E3_AJUSTE,E3_BAIEMI,E3_EMISSAO,E3_DATA,E3_PEDIDO,E3_SEQ
			FROM %table:SE3% SE3
			LEFT JOIN %table:SA3% SA3
				ON A3_COD = E3_VEND
			WHERE A3_FILIAL = %xFilial:SA3%
				AND E3_FILIAL = %xFilial:SE3%
				AND	E3_EMISSAO >= %Exp:Dtos(mv_par02)%
				AND E3_EMISSAO <= %Exp:Dtos(mv_par03)%
				AND SE3.E3_VEND BETWEEN %Exp:MV_PAR04% AND %Exp:MV_PAR05%
				AND SA3.%NotDel%
				AND SE3.%notdel%
				%Exp:cWhere%
		EndSql
	END REPORT QUERY oDetalhe 
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(nSection):EndQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³				
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oReport:Section(nSection),"SA3",1,{|| xFilial("SA3")+cVend })
//TRPosition():New(oReport:Section(nSection),"SE3",2,{|| xFilial("SE3")+cVend+(cAlias)->E3_PREFIXO+(cAlias)->E3_NUM+(cAlias)->E3_PARCELA+(cAlias)->E3_SEQ})
If mv_par12 == 1
   TRPosition():New(oReport:Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+(cAlias)->E3_CODCLI+(cAlias)->E3_LOJA })
   TRPosition():New(oReport:Section(1):Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA })
EndIf   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par12 == 2 .Or. mv_par12 == 1 
	nTotBase	:= 0
	nTotComis	:= 0
EndIf

dbSelectArea(cAlias)
dbGoTop()
nDecs     := GetMv("MV_CENT"+(IIF(mv_par08 > 1 , STR(mv_par08,1),"")))

oReport:SetMeter(SE3->(LastRec()))
dbSelectArea(cAlias)
While !oReport:Cancel() .And. !&(cAlias)->(Eof())
	
	cVend := &(cAlias)->(E3_VEND)
	nAc1 := 0
	nAc2 := 0
	nAc3 := 0
	nTotPerVen := 0
	
	oReport:Section(nSection):Init()
	If mv_par12 == 1 .And. Empty(cFilSE1) .And. Empty(cFilSE3) .And. Empty(cFilSA1)
		oReport:Section(nSection):PrintLine()
	EndIf	

	lVend:= .T. 
	lFirst := .T. 
	While !Eof() .And. xFilial("SE3") == (cAlias)->E3_FILIAL .And. (cAlias)->E3_VEND == cVend
		nBasePrt   := 0
		nComPrt    := 0
		nVlrTitulo := 0
		If mv_par12 == 1 
			nTotBase	:= 0
			nTotComis	:= 0
		EndIf
		
		dbSelectArea("SE3")
		If lUseOffBal
			dbSetOrder(2)
			dbSeek(xFilial("SE3")+cVend+&(cAlias)->(E3_PREFIXO)+&(cAlias)->(E3_NUM)+&(cAlias)->(E3_PARCELA)+&(cAlias)->(E3_SEQ))
		Else
			dbSetOrder(3)
			dbSeek(xFilial("SE3")+cVend+(cAlias)->(E3_CODCLI)+(cAlias)->(E3_LOJA)+(cAlias)->(E3_PREFIXO)+(cAlias)->(E3_NUM)+(cAlias)->(E3_PARCELA)+(cAlias)->E3_TIPO+(cAlias)->(E3_SEQ))
		EndIf

		dbSelectArea("SE1")
		dbSetOrder(1)
		dbSeek(xFilial()+&(cAlias)->(E3_PREFIXO)+&(cAlias)->(E3_NUM)+&(cAlias)->(E3_PARCELA)+&(cAlias)->(E3_TIPO))

	   // Verifica filtro do usuario
	   	If !Empty(cFilSE1) .And. !(&cFilSE1)
		   dbSelectArea(cAlias)	
	       dbSkip()
		   Loop
		ElseIf !Empty(cFilSE1) .And. (&cFilSE1) .And. lFirst
			oReport:Section(nSection):PrintLine()
			lFirst := .F.    
		EndIf 
		If!Empty(cFilSE3) .And. !SE3->(&cFilSE3)
		   dbSelectArea(cAlias)	
	       dbSkip()
		   Loop
		ElseIf !Empty(cFilSE3) .And. SE3->(&cFilSE3) .And. lVend 
			If mv_par12 == 1
				oReport:Section(nSection):PrintLine()       
				lVend:= .F.
			EndIf   
		EndIf
		If!Empty(cFilSA1) 
		   	SA1->(dbSetOrder(1))               
			If SA1->(dbSeek(xFilial()+&(cAlias)->(E3_CODCLI)+&(cAlias)->(E3_LOJA)))
				If !( SA1->&cFilSa1)	
		  			dbSelectArea(cAlias)	 
				   	dbSkip()  
					Loop
				ElseIf (SA1->&cFilSA1) .And. lVend
					oReport:Section(nSection):PrintLine()
					lVend := .F.	
				EndIf	
		   	EndIf 
		EndIf 		   	
		If nModulo == 12 
			nVlrTitulo:= Round(xMoeda((cAlias)->E3_BASE,SE1->E1_MOEDA,MV_PAR08,(cAlias)->E3_EMISSAO,nDecs+1),nDecs)
		Else
			nVlrTitulo:= Round(xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,MV_PAR08,SE1->E1_EMISSAO,nDecs+1),nDecs)
		EndIf
			
		dEmissao  := SE1->E1_EMISSAO
		cLiquid   := ""
		cDocLiq   := SE1->E1_NUMLIQ
		
		If mv_par12 == 1
			dVencto   := SE1->E1_VENCTO
			aLiquid	  := {}
			aValLiq	  := {}
			aLiqProp  := {}
			nTotLiq	  := 0
			If mv_par13 == 1 .And. !Empty(SE1->E1_NUMLIQ) .And. FindFunction("FA440LIQSE1")
				cLiquid := SE1->E1_NUMLIQ
				cDocLiq := SE1->E1_NUMLIQ
				// Obtem os registros que deram origem ao titulo gerado pela liquidacao
				Fa440LiqSe1(SE1->E1_NUMLIQ,@aLiquid,@aValLiq)
				For ny := 1 to Len(aValLiq)
					nTotLiq += aValLiq[ny,2]
				Next
				For ny := 1 to Len(aValLiq)
					aAdd(aLiqProp,(nVlrTitulo/nTotLiq)*aValLiq[ny,2])
				Next
			Endif
			
			If (cAlias)->E3_BAIEMI == "B"
				dBaixa     := (cAlias)->E3_EMISSAO
			Else
				dBaixa     := SE1->E1_BAIXA
			Endif
		EndIf
		
		If Eof()

			dbSelectArea("SF1")
			dbSetOrder(1)

			dbSelectArea("SF2")
			dbSetorder(1)
			
			If AllTrim((cAlias)->E3_TIPO) == "NCC"
				SF1->(dbSeek(xFilial("SF1")+(cAlias)->E3_NUM+(cAlias)->E3_PREFIXO+(cAlias)->E3_CODCLI+(cAlias)->E3_LOJA,.t.))
			    nVlrTitulo := Round(xMoeda(SF1->F1_VALBRUT,SF1->F1_MOEDA,mv_par08,SF1->F1_DTDIGIT,nDecs+1,SF1->F1_TXMOEDA),nDecs)
			    dEmissao   := SF1->F1_DTDIGIT
			Else
		   		dbSeek(xFilial()+(cAlias)->E3_NUM+(cAlias)->E3_PREFIXO)
				nVlrTitulo := Round(xMoeda(F2_VALFAT,SF2->F2_MOEDA,mv_par08,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA),nDecs)
		 		dEmissao   := SF2->F2_EMISSAO
			EndIf
			
			If mv_par12 == 1
				dVencto    := CTOD( "" )
				dBaixa     := CTOD( "" )  	
			EndIf
			
			If Eof()
				nVlrTitulo := 0
				dbSelectArea("SE1")
				dbSetOrder(1)
				cFilialSE1 := xFilial()
				dbSeek(cFilialSE1+&(cAlias)->(E3_PREFIXO)+&(cAlias)->(E3_NUM))
				While ( !Eof() .And. (cAlias)->E3_PREFIXO == SE1->E1_PREFIXO .And.;
					(cAlias)->E3_NUM == SE1->E1_NUM .And.;
					(cAlias)->E3_FILIAL == cFilialSE1 )
					If ( SE1->E1_TIPO == (cAlias)->E3_TIPO  .And. ;
						SE1->E1_CLIENTE == (cAlias)->E3_CODCLI .And. ;
						SE1->E1_LOJA == (cAlias)->E3_LOJA )
						nVlrTitulo += Round(xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,MV_PAR08,SE1->E1_EMISSAO,nDecs+1),nDecs)
						
						If mv_par12 == 1
							dVencto    := CTOD( "" )
							dBaixa     := CTOD( "" )
						EndIf

						If Empty(dEmissao)
							dEmissao := SE1->E1_EMISSAO
						EndIf
						
					EndIf
					dbSelectArea("SE1")
					dbSkip()
				EndDo
			EndIf
		Endif
		
		If Empty(dEmissao)
			dEmissao := NIL
		EndIf
				
		If MV_PAR08 == 1 .Or. SE1->E1_MOEDA == 1
			nBasePrt:=	Round(xMoeda((cAlias)->E3_BASE ,1,MV_PAR08,dEmissao,nDecs+1),nDecs)
			nComPrt :=	Round(xMoeda((cAlias)->E3_COMIS,1,MV_PAR08,dEmissao,TamSx3("E3_COMIS")[2]+1),TamSx3("E3_COMIS")[2])
		Else
			nTaxa 	:=  RecMoeda((cAlias)->E3_EMISSAO,MV_PAR08) 
			nBasePrt:=	Round(xMoeda((cAlias)->E3_BASE ,1,MV_PAR08,dEmissao,nDecs+1,SE1->E1_TXMOEDA,nTaxa),nDecs)
			nComPrt :=	Round(xMoeda((cAlias)->E3_COMIS,1,MV_PAR08,dEmissao,TamSx3("E3_COMIS")[2]+1,SE1->E1_TXMOEDA,nTaxa),TamSx3("E3_COMIS")[2])
		EndIf
		
		If mv_par09 == 2 .And. mv_par08 != 1  //Não apresenta comissões zeradas em outras moedas
			If nVlrTitulo == 0 .And. nBasePrt == 0 .And. nComPrt == 0 
				(cAlias)->(DbSkip())
				Loop
			EndIf
		EndIf 
		
		If nBasePrt < 0 .And. nComPrt < 0
			nVlrTitulo := nVlrTitulo * -1
		Endif
		
		If mv_par12 == 1
			cAjuste := (cAlias)->E3_AJUSTE
			cTipo   := (cAlias)->E3_BAIEMI
			dbSelectArea(cAlias)
			oReport:Section(1):Section(1):Init()
 			oReport:Section(1):Section(1):PrintLine()
  			oReport:IncMeter()
			
			If mv_par13 == 1
				For nI := 1 To Len(aLiquid)
					nI2 := nI
					SE1->(MsGoto(aLiquid[nI]))
				    oReport:Section(1):SetHeaderBreak(.T.)
					oReport:Section(1):Section(1):Section(1):Init()
					oReport:Section(1):Section(1):Section(1):PrintLine()
				Next
				If Len(aLiquid) > 0
					oReport:Section(1):Section(1):Section(1):Finish()
				EndIf
			Endif			
			
		EndIf
		
		nAc1 += nBasePrt
		nAc2 += nComPrt
		nTotPerVen += (nBasePrt*(cAlias)->E3_PORC)/100
		nTotPerGer += nTotPerVen
		If cTitulo <> (cAlias)->E3_PREFIXO+(cAlias)->E3_NUM+(cAlias)->E3_PARCELA+(cAlias)->E3_TIPO+(cAlias)->E3_VEND+(cAlias)->E3_CODCLI+(cAlias)->E3_LOJA 
			nAc3   += nVlrTitulo
			cTitulo:= (cAlias)->E3_PREFIXO+(cAlias)->E3_NUM+(cAlias)->E3_PARCELA+(cAlias)->E3_TIPO+(cAlias)->E3_VEND+(cAlias)->E3_CODCLI+(cAlias)->E3_LOJA
			cDocLiq:= ""
		EndIf
		
		dbSelectArea(cAlias)
		dbSkip()
	EndDo
	
	If mv_par12 == 1
		nTotBase 	+= nAc1
		nTotComis 	+= nAc2
		nTotPorc	:= Round((nTotComis / nTotBase)*100,TamSx3("E3_COMIS")[2])
		nTotPerVen  := Round((nTotPerVen/nAc1)*100,TamSx3("E3_PORC")[2])
		oReport:Section(1):Section(1):SetTotalText("Total do Vendedor " + cVend)
		oReport:Section(1):Section(1):Finish()
	EndIf
	
	nValIR    := 0
	nTotSemIR := 0
	If mv_par10 > 0 .And. (nAc2 * mv_par10 / 100) > GetMV("MV_VLRETIR") //IR
		nValIR    := nAc2 * (MV_PAR10/100)
		nTotSemIR := nAc2 - (nAc2 * (MV_PAR10/100))
	Else
		nTotSemIR := nAc2
	EndIf
	
	If mv_par12 == 2
		nTotBase 	+= nAc1
		nTotComis 	+= nAc2
		nTotPorc	:= Round((nTotComis / nTotBase)*100,TamSx3("E3_COMIS")[2])
		nTotPerVen  := Round((nTotPerVen/nAc1)*100,TamSx3("E3_PORC")[2])
		oReport:Section(nSection):Init()				
		oReport:Section(nSection):PrintLine()
	EndIf	
	oReport:Section(nSection):Finish()
	
	If mv_par12 == 1 .And. mv_par10 > 0
		oReport:Section(2):Init()
		oReport:Section(2):PrintLine()
		oReport:Section(2):Finish()
	EndIf
	
	If mv_par11 == 1
	   oReport:Section(nSection):SetPageBreak(.T.)
	EndIf
	
	If mv_par12 == 2
		oReport:IncMeter()
	EndIf
	
	nTGerBas    += nAc1
    nTGerCom    += nAc2
	
EndDo

nTotPorc := ((nTGerCom*100)/nTGerBas) 
 
If mv_par11 == 1
	oGeral:SetPageBreak(.T.)
	oGeral:Cell("TXTTOTAL"):SetSize(21)
	oGeral:Cell("GERAL"   ):SetBlock  ( { || nTGerBas } ) 
	oGeral:Cell("PERCENT" ):SetBlock  ( { || nTotPorc } )
	oGeral:Cell("COMIS"   ):SetBlock  ( { || nTGerCom } ) 
	oGeral:Init()
	oGeral:PrintLine()
	oGeral:Finish()
	oGeral:SetPageBreak(.T.)
EndIf 

FwFreeArray(aStruSE3)
FwFreeArray(aStruQry)
FwFreeArray(aSelect)

Return




//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
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
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

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
