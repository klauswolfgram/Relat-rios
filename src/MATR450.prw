/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR450.CH"
#INCLUDE "PROTHEUS.CH"
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MATR450 ³ Autor ³ Flavio Luiz Vicco      ³ Data ³03/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao Consumo Real x Standard.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAPCP                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcos V.   ³19/09/06³      ³Revisao Geral- Release 3 e Release 4      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR450()
Local oReport := ReportDef()

oReport:PrintDialog()

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Flavio Luiz Vicco      ³Data  ³03/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao Consumo Real x Standard.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³(Nenhum)                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4
Local cTitle := OemToAnsi(STR0001) //"Consumo Real x Standard"

Private cPicD3C114 := PesqPict("SD3","D3_CUSTO1",14)
Private cPicD3C116 := PesqPict("SD3","D3_CUSTO1",16)
Private cPicD3C118 := PesqPict("SD3","D3_CUSTO1",18)
Private cPicD3Qtde := PesqPict("SD3","D3_QUANT" ,15)
Private cPicC2Qtde := PesqPict("SC2","C2_QUANT",15)
Private cPicD3Perc := PesqPict("SD3","D3_PMACNUT",7) //usa qq campo da D3 do tipo percentual
Private cTamCod    := TamSX3("D3_COD")[1]

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
oReport := TReport():New("MATR450",cTitle,"MTR451",{|oReport| ReportPrint(oReport)},STR0001) //"Consumo Real x Standard"
oReport:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01    // Listagem por Ordem de Producao ou Produto.    ³
//³ mv_par02    // Listagem Sintetica ou Analitica.              ³
//³ mv_par03    // De                                            ³
//³ mv_par04    // Ate                                           ³
//³ mv_par05    // Custo do Consumo Real 1...6 ( Moeda )         ³
//³ mv_par06    // Custo do Consumo Std  1...6                   ³
//³ mv_par07    // Movimentacao De                               ³
//³ mv_par08    // Movimentacao Ate                              ³
//³ mv_par09    // Calcular Pela Estrutura / Empenho             ³
//³ mv_par10    // Aglutina por Produto.                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da secao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a secao.                   ³
//³ExpA4 : Array com as Ordens do relatorio                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao das celulas da secao do relatorio                               ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatorio. O SX3 sera consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de codigo para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Section 1 - Total em Quantidade da OP / Produto              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:= TRSection():New(oReport,STR0045,{},/*aOrdem*/) //"Saldo Inicial OP / Produto"
oSection1:SetHeaderSection(.F.) // Inibe Header

TRCell():New(oSection1,"CPROD",		"",STR0037	,/*Picture*/,17 					,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"CDESC",		"",STR0038	,/*Picture*/,If(cTamCod>15, 37, 25),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"CUMED",		"",STR0039	,/*Picture*/, 2	,/*lPixel*/			,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"NQTDE",		"",STR0022	,cPicC2Qtde	,15	,/*lPixel*/			,/*{|| code-block de impressao }*/,,,"RIGHT")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Section 2 - Linha de Detalhe                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:= TRSection():New(oSection1,STR0044,{},/*aOrdem*/) //"Itens de Movimentação Interna"
oSection2:SetHeaderPage(.T.)
oSection2:SetHeaderSection(.T.)

TRCell():New(oSection2,"CPROD"		,"",STR0020	+CRLF+STR0037,/*Picture*/	,cTamCod+2	   				,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"CDESC"		,"",""		+CRLF+STR0038,/*Picture*/	,If(cTamCod>15, 22, 25)		,/*lPixel*/,/*{|| code-block de impressao }*/) //"M a t e r i a l"
TRCell():New(oSection2,"CUMED"		,"",""		+CRLF+STR0039,/*Picture*/	, 2							,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"NQTDE"		,"",STR0021	+CRLF+STR0022,cPicD3Qtde	,15							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Consumo"###"Quantidade"
TRCell():New(oSection2,"NCUSUNIT"	,"",STR0023	+CRLF+STR0024,cPicD3C114	,14							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Real"###"Custo Un."
TRCell():New(oSection2,"NVLTOT"		,"","" 		+CRLF+STR0025,cPicD3C116	,16							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Valor total"
TRCell():New(oSection2,"NQTDE2"		,"",STR0021	+CRLF+STR0022,cPicD3Qtde	,15							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Consumo"###"Quantidade"
TRCell():New(oSection2,"NCUSUSTD"	,"",STR0026	+CRLF+STR0024,cPicD3C114	,14							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Standard"###"Custo Un."
TRCell():New(oSection2,"NVLTOT2"	,"",""   	+CRLF+STR0025,cPicD3C116	,16							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Valor Total"
TRCell():New(oSection2,"NQTDE3"		,"",STR0027	+CRLF+STR0040,cPicD3Qtde	,15							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Variacao"###"Quantidade"
TRCell():New(oSection2,"NTOTALVAR"	,"",""    	+CRLF+STR0025,cPicD3C114	,14							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Valor Total"
TRCell():New(oSection2,"NSVALOR"	,"",""      +CRLF+STR0028,cPicD3C114	,14							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"$Qdt."
TRCell():New(oSection2,"NSQUANT"	,"",""      +CRLF+STR0029,cPicD3Qtde	,13							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"$Valor"
TRCell():New(oSection2,"NPERC"		,"",""      +CRLF+"    %",cPicD3Perc	, 7 						,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Section 3 - Linha de Totais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3:= TRSection():New(oSection2,STR0046,{},/*aOrdem*/) //"Totais por OP / Produto"
oSection3:SetHeaderSection(.F.)
oSection3:SetNoFilter("SD3")

TRCell():New(oSection3,"CTOTAL"		,""	,STR0020+CRLF+STR0037	,/*Picture*/,cTamCod+2					,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"CDESC"		,""	,""		+CRLF+STR0038	,/*Picture*/,If(cTamCod>15, 22, 25) 	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"CUMED"		,""	,""	  	+CRLF+STR0039	,/*Picture*/, 2							,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"NQTDE"		,""	,STR0021+CRLF+STR0022	,cPicD3Qtde	,15							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")//"Quantidade"
TRCell():New(oSection3,"NTOTREALOPU",""	,STR0023+CRLF+STR0024	,cPicD3C114	,14							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")//"Custo un."
TRCell():New(oSection3,"NTOTREALOP"	,""	,"" 	+CRLF+STR0025	,cPicD3C116	,16							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")//"Valor total"
TRCell():New(oSection3,"NQTDE2"		,""	,STR0021+CRLF+STR0022	,cPicD3Qtde	,15							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")//"Quantidade"
TRCell():New(oSection3,"NTOTSTDOPU",""	,STR0026+CRLF+STR0024	,cPicD3C114	,14							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")//"Custo Un."
TRCell():New(oSection3,"NTOTSTDOP"	,""	,STR0025				,cPicD3C116	,16							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")//"Valor Total"
TRCell():New(oSection3,"NQTDE3"		,""	,STR0022				,cPicD3Qtde	,15							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")//"Quantidade"
TRCell():New(oSection3,"NTOTVAROP"	,""	,STR0025				,cPicD3C116	,16							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")//"Valor Total"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Section 4 - Resumo Geral                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection4:= TRSection():New(oReport,STR0047,{},/*aOrdem*/) //"Resumo Aglutinado por Produto"
oSection4:SetHeaderPage(.T.)
oSection4:SetHeaderSection(.F.)
oSection4:SetNoFilter("SD3")

TRCell():New(oSection4,"CPROD"		,"",""     +CRLF+STR0037	,/*Picture*/,cTamCod+2 	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"CDESC"		,"",""     +CRLF+STR0038	,/*Picture*/,25 		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"CUMED"		,"",""						,/*Picture*/, 2			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"NQTDE"		,"",STR0030+CRLF+STR0041	,cPicD3Qtde	,15			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Consumo Real"###"Quantidade"
TRCell():New(oSection4,"NVLTOT"		,"",""     +CRLF+STR0031	,cPicD3C118	,18			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Valor"
TRCell():New(oSection4,"NQTDE2"		,"",STR0032+CRLF+STR0042	,cPicD3Qtde	,15			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Consumo Std."###"Quantidade"
TRCell():New(oSection4,"NVLTOT2"	,"",""     +CRLF+STR0031	,cPicD3C118	,18			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Valor"
TRCell():New(oSection4,"NQTDE3"		,"",STR0027+CRLF+STR0043	,cPicD3Qtde	,15			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Variacao"###"Quantidade"
TRCell():New(oSection4,"NVLTOT3"	,"",""     +CRLF+STR0031	,cPicD3C118	,18			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Valor"
TRCell():New(oSection4,"NPERCTOT"	,"",""     +CRLF+"    %"	,cPicD3Perc	,7			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // Percentual( % )

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Flavio Luiz Vicco      ³Data  ³03/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao Consumo Real x Standard.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(1):Section(1)
Local oSection4  := oReport:Section(2)
Local cVazio1    := Space(Len(SD3->D3_OP))
Local aTam       := TamSX3("D3_CUSTO1")
Local cAnt       := ""
Local cOpAnt     := ""
Local nQuantG1   := 0
Local lOpConf    := .T.
Local aRecnoD4   := {}
Local nTotalVar  := 0
Local nQtdVar    := 0
Local nPercent   := 0
Local nCusStdOP  := nTotStdOP := nCusRealOP := nTotRealOP := nTotVarOP := 0
Local nCusUnit   := nCusUnitR := nCusUnitS  := nCusUStd   := 0
Local nSValor    := 0
Local nSQuant    := 0
Local nPosTrb1   := nPosTrb2 := nPosTrb3 := 0
Local nI		 := 0
Local cFilSB1    := xFilial("SB1")
Local cFilSBZ    := xFilial("SBZ")
Local cFilSC2    := xFilial("SC2")
Local cFilSG1    := xFilial("SG1")
Local cWhere	 := ""
Local nCount
Local cQuery
Local lContinua
Local cQrySG1
Local aAreaSG1
Local aBind		 := {}
Local cAliasSG1	 := "SG1MATR450"
Local cMVARQPROD := SuperGetMV("MV_ARQPROD",.F.,"SB1")
Local oLstTrb1J	 := JsonObject():New()
Local cKeyScan
Local nQtdBase
Local cChvExEst
Local cTipoDec

Private cAliasNew  := "SD3"
Private nTamDecQtd := TamSX3("D3_QUANT")[2]
Private nTamIntCus := aTam[1]
Private nTamDecCus := aTam[2]
Private aLstTrb1   := {}
Private aLstTrb2   := {}
Private aLstTrb3   := {}

Static oExplEstr  := Nil

If oExplEstr == Nil
	oExplEstr := JsonObject():New()
EndIf

dbSelectArea(cAliasNew)
dbSetOrder(6)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cAliasNew := GetNextAlias()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao 1                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro por OP / Produto                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par01 == 1
	// Filtrar por OP
	cWhere := "% SD3.D3_OP BETWEEN '"+ mv_par03 +"' AND '"+ mv_par04 + "' %"
Else
	// Filtrar por Produto Pai
	cWhere := "% SD3.D3_OP IN (SELECT C2_NUM||C2_ITEM||C2_SEQUEN||C2_ITEMGRD FROM "+RetSqlName("SC2")+" SC2 "
	cWhere += "WHERE SC2.C2_FILIAL = '"+xFilial("SC2")+"' "
	cWhere += "AND SC2.C2_PRODUTO BETWEEN '"+ mv_par03 +"' AND '"+ mv_par04 + "' "
	cWhere += "AND SC2.D_E_L_E_T_ = ' ' ) %"
EndIf

BeginSql Alias cAliasNew

	SELECT SD3.* ,SD3.R_E_C_N_O_ D3REC

	FROM %table:SD3% SD3

	WHERE SD3.D3_FILIAL = %xFilial:SD3%
		AND SD3.D3_OP <> %Exp:cVazio1 %
		AND %Exp:cWhere%
		AND SD3.D3_CF <> 'ER0' AND SD3.D3_CF <> 'ER1'
		AND SD3.D3_EMISSAO >= %Exp:DTOS(mv_par07)%
		AND SD3.D3_EMISSAO <= %Exp:DTOS(mv_par08)%
		AND SD3.D3_ESTORNO <> 'S'
		AND SD3.%NotDel%

	ORDER BY %Order:SD3%

EndSql
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatorio para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

oReport:SetMeter(SD3->(RecCount()))

While !oReport:Cancel() .And. (cAliasNew)->(!Eof())
	oReport:IncMeter()

	If oReport:Cancel()
		Exit
	EndIf

	If SB1->(B1_FILIAL+B1_COD)# (cFilSB1+(cAliasNew)->D3_COD)
		SB1->(MsSeek(cFilSB1+(cAliasNew)->D3_COD))
	EndIf

	If SC2->(C2_FILIAL+C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)# (cFilSC2+(cAliasNew)->D3_OP)
		SC2->(MsSeek(cFilSC2+(cAliasNew)->D3_OP))
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Le requisicoes e devolucoes SD3 e grava no aLstTrb1 para gravacao do REAL ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SubStr((cAliasNew)->D3_CF,2,1)$"E" .And. (cAliasNew)->(!Empty(D3_OP) )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Ordem de Producao / Produto                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par01 == 1
			cKeyScan := (cAliasNew)->D3_OP+(cAliasNew)->D3_COD
		Else
			If mv_par10 == 1
				cKeyScan := SC2->C2_PRODUTO+(cAliasNew)->D3_COD
			Else
				cKeyScan := SC2->C2_PRODUTO+(cAliasNew)->D3_COD+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)
			EndIf
		EndIf

		If oLstTrb1J[cKeyScan] != NIL
			nPosTrb1 	 := oLstTrb1J[cKeyScan]
		Else
			nPosTrb1 	 := 0
		EndIf

		If Empty(nPosTrb1)
			aAdd(aLstTrb1,{	(cAliasNew)->D3_COD,		;	  		//01 - PRODUTO
							(cAliasNew)->D3_OP,			; 			//02 - OP
							(cAliasNew)->D3_NUMSEQ,		; 			//03 - NUMSEQ
							R450TRT("RE"),				; 			//04 - TRT
							(cAliasNew)->D3_CHAVE,		; 			//05 - CHAVE
							(cAliasNew)->D3_EMISSAO,	; 			//06 - EMISSAO
							SC2->C2_PRODUTO,			; 			//07 - PAI
							"",							;	 		//08 - FIXVAR
							R450Qtd("R",0,cAliasNew),	; 			//09 - QTDREAL
							0,							; 			//10 - QTDSTD
							0,							; 			//11 - QTDVAR
							0,							; 			//12 - CUSTOSTD
							R450Cus('R', mv_par05,,cAliasNew),;		//13 - CUSTOREAL
							0	})						  			//14 - CUSTOVAR
			oLstTrb1J[cKeyScan] := Len(aLstTrb1)
		Else
			aLstTrb1[nPosTrb1,03] := (cAliasNew)->D3_NUMSEQ				//03 - NUMSEQ
			aLstTrb1[nPosTrb1,04] := R450TRT("RE")						//04 - TRT
			aLstTrb1[nPosTrb1,05] := (cAliasNew)->D3_CHAVE				//05 - CHAVE
			aLstTrb1[nPosTrb1,06] := (cAliasNew)->D3_EMISSAO			//06 - EMISSAO
			aLstTrb1[nPosTrb1,09] += R450Qtd("R",0,cAliasNew)		 	//09 - QTDREAL
			aLstTrb1[nPosTrb1,13] += R450Cus('R', mv_par05,,cAliasNew)	//13 - CUSTOREAL
		EndIf

	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Le producoes e gravar TRB. para gravacao do STANDARD         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cAliasNew)->D3_ESTORNO != "S" .And. SubStr((cAliasNew)->D3_CF,1,2)$"PR"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro de Usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !(SB1->(MsSeek(cFilSB1+(cAliasNew)->D3_COD)))
			(cAliasNew)->(DbSkip())
			Loop
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Lista por Ordem de Producao / Produto                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par01 == 1
			nPosTrb2 := aScan(aLstTrb2,{|x|x[2]==(cAliasNew)->D3_OP})
		Else
			nPosTrb2 := aScan(aLstTrb2,{|x|x[1]==(cAliasNew)->D3_COD})
		EndIf

		If Empty(nPosTrb2)
			aAdd(aLstTrb2,Array(4))
			nPosTrb2 := Len(aLstTrb2)
			aLstTrb2[nPosTrb2,4] := 0
		EndIf
		aLstTrb2[nPosTrb2,1] := (cAliasNew)->D3_COD
		aLstTrb2[nPosTrb2,2] := (cAliasNew)->D3_OP
		aLstTrb2[nPosTrb2,3] := (cAliasNew)->D3_UM
		aLstTrb2[nPosTrb2,4] += (cAliasNew)->D3_QUANT

		cProduto := (cAliasNew)->D3_COD

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcular pela Estrutura                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par09 == 1

			nCount := 0
			cQuery := ""
			lContinua := .F.
 
 			If cQrySG1 == nil 
				cQrySG1 := "SELECT "
				cQrySG1 += "	SG1.G1_FILIAL, SG1.G1_COD, SG1.G1_COMP, "
				cQrySG1 += "	SG1.G1_QUANT, SG1.G1_INI, SG1.G1_FIM, "
				cQrySG1 += "	SG1.G1_GROPC, SG1.G1_OPC, SG1.G1_TRT, "
				If cMVARQPROD == "SBZ"
					cQrySG1 += MatIsNull()+"(SBZ1.BZ_FANTASM,SB11.B1_FANTASM) FANTASM_COD, "
					cQrySG1 += MatIsNull()+"(SBZ2.BZ_FANTASM,SB12.B1_FANTASM) FANTASM_COMP, "
				Else
					cQrySG1 += "SB11.B1_FANTASM FANTASM_COD, " 
					cQrySG1 += "SB12.B1_FANTASM FANTASM_COMP, "
				EndIf
				cQrySG1 += "	SG1.G1_FIXVAR, SG1.R_E_C_N_O_ SG1RECNO " 
				cQrySG1 += "FROM "+RetSqlName("SG1")+" SG1 "
				cQrySG1 += "	LEFT JOIN "+RetSqlName("SB1")+" SB11 ON SB11.B1_FILIAL = '"+cFilSB1+"' "
				cQrySG1 += "		AND SB11.B1_COD = SG1.G1_COD "
			    cQrySG1 += "	    AND SB11.D_E_L_E_T_= ? "
				cQrySG1 += "	LEFT JOIN "+RetSqlName("SB1")+" SB12 ON SB12.B1_FILIAL = '"+cFilSB1+"' "
				cQrySG1 += "		AND SB12.B1_COD = SG1.G1_COMP "
			    cQrySG1 += "	    AND SB12.D_E_L_E_T_= ? "
				If cMVARQPROD == "SBZ"
					cQrySG1 += "LEFT JOIN "+RetSqlName("SBZ")+" SBZ1 ON SBZ1.BZ_FILIAL = '"+cFilSBZ+"' "
					cQrySG1 += "	AND SBZ1.BZ_COD = SB11.B1_COD "
					cQrySG1 += "	AND SBZ1.D_E_L_E_T_= ? "
					cQrySG1 += "LEFT JOIN "+RetSqlName("SBZ")+" SBZ2 ON SBZ2.BZ_FILIAL = '"+cFilSBZ+"' "
					cQrySG1 += "	AND SBZ2.BZ_COD = SB12.B1_COD "
					cQrySG1 += "    AND SBZ2.D_E_L_E_T_= ? "
				EndIf
				cQrySG1 += "WHERE SG1.G1_FILIAL = '"+cFilSG1+"' "   
				cQrySG1 += "	AND SG1.G1_COD = ? "
				cQrySG1 += "	AND SG1.D_E_L_E_T_= ? "
				cQrySG1 := ChangeQuery(cQrySG1) 
			EndIf
                                                                
			aBind := {}
			If cMVARQPROD == "SBZ"
			   AADD(aBind,Space(1)) 
			   AADD(aBind,Space(1)) 
			EndIf
			AADD(aBind,Space(1))  
			AADD(aBind,Space(1))                
			AADD(aBind,cProduto) 
			AADD(aBind,Space(1))

 			dbUseArea(.T.,"TOPCONN",TcGenQry2(,,cQrySG1,aBind),cAliasSG1)
			TcSetField( cAliasSG1, "G1_INI" , "D", 8, 0 )
			TcSetField( cAliasSG1, "G1_FIM" , "D", 8, 0 )
			TcSetField( cAliasSG1,"SG1RECNO", "N", 8, 0 )

			While (cAliasSG1)->(!Eof()) .And. cFilSG1+cProduto == (cAliasSG1)->(G1_FILIAL+G1_COD)
				If dDataBase < (cAliasSG1)->G1_INI .Or. dDataBase > (cAliasSG1)->G1_FIM
					(cAliasSG1)->(dbSkip())
					Loop
				EndIf

				// CORREÇÃO ISSUE - DMANMAT01-14544
				If !EMPTY( (cAliasSG1)->G1_GROPC ) .AND. !EMPTY( (cAliasSG1)->G1_OPC )

					If Empty((cAliasSG1)->G1_TRT)
						// se existir sequencia deste componente na estrutura
						// com opcionais ent?o devo verificar os movimentos internos
						cQuery := "SELECT COUNT(R_E_C_N_O_) NREC FROM " + RetSqlName("SG1")
						cQuery += " WHERE "
						cQuery += " G1_FILIAL = '"+ xFilial("SG1") +"' "
						cQuery += " AND G1_COMP = '"+ (cAliasSG1)->G1_COMP +"' "
						cQuery += " AND G1_TRT > '"+ space(len((cAliasSG1)->G1_TRT)) +"' "
						cQuery += " AND G1_GROPC = '" +(cAliasSG1)->G1_GROPC+ "' "
						cQuery += " AND G1_OPC = '" +(cAliasSG1)->G1_OPC+ "' "
						cQuery += " AND G1_INI >= '"+dtos((cAliasSG1)->G1_INI)+"' "
						cQuery += " AND G1_FIM <= '"+dtos((cAliasSG1)->G1_FIM)+"' "
						cQuery += " AND D_E_L_E_T_ = ' ' "
						nCount := MpSysExecScalar(cQuery,"NREC")
						lContinua := nCount > 0
					EndIf

					If lContinua
						cAliasOpc := GetNextAlias()

						BeginSql Alias cAliasOpc

							SELECT 	SD3.D3_OP, SD3.D3_COD, SD3.D3_TRT, SD3.R_E_C_N_O_ D3REC

							FROM 	%table:SD3% SD3

							WHERE 	SD3.D3_FILIAL = %xFilial:SD3%
									AND SD3.D3_OP =  %Exp:(cAliasNew)->D3_OP%
									AND SD3.D3_COD = %Exp:(cAliasSG1)->G1_COMP%
									AND SD3.D3_TRT <> ' '
									AND SD3.%NotDel%

							ORDER BY %Order:SD3%

						EndSql

						If ( cAliasOpc )->( !Eof() )
							If ( cAliasOpc )->D3_TRT <> (cAliasSG1)->G1_TRT
								( cAliasOpc )->( dbCloseArea() )
								(cAliasSG1)->(dbSkip())
								Loop
							EndIf
						EndIf
						( cAliasOpc )->( dbCloseArea() )
					EndIf

				EndIf
				// FIM

				nQuantG1 := 0
				nRecno	 := (cAliasSG1)->SG1RECNO
				If (cAliasSG1)->G1_FIXVAR == "F"
					nQuantG1 := (cAliasSG1)->G1_QUANT
					If (cAliasNew)->D3_PARCTOT == 'P'
						nQuantG1 := Round(nQuantG1*IIf(SC2->(C2_QUJE==C2_QUANT),1,SC2->(C2_QUJE/C2_QUANT)),nTamDecQtd)
					EndIf
				Else
					aAreaSG1 := GetArea()
					dbSelectArea('SG1')
					MsGoto(nRecno)
					
					cChvExEst := SG1->(G1_FILIAL+G1_COD+G1_COMP+G1_TRT+DTOS(G1_INI)+DTOS(G1_FIM)+G1_REVINI+G1_REVFIM)
					cChvExEst += SC2->(C2_FILIAL+C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)

					cTipoDec := Posicione('SB1',1,FWxFilial('SB1')+SG1->G1_COMP,'B1_TIPODEC')
					If oExplEstr[cChvExEst] == Nil
						nQtdBase := ExplEstr(1,SC2->C2_DATPRI,SC2->C2_OPC,SC2->C2_REVISAO,,,.F.)
						oExplEstr[cChvExEst] := {nQtdBase, cTipoDec}
					Else
						nQtdBase := oExplEstr[cChvExEst][1]
						cTipoDec := oExplEstr[cChvExEst][2]
					EndIf

					nQuantG1 := nQtdBase * (cAliasNew)->D3_QUANT
					Do Case
						Case cTipoDec == "A"
							nQuantG1 := Round( nQuantG1,0 )
						Case cTipoDec == "I"
							nQuantG1 := Int(nQuantG1)+If(((nQuantG1-Int(nQuantG1)) > 0),1,0)
						Case cTipoDec == "T"
							nQuantG1 := Int( nQuantG1 )
						OtherWise
							nQuantG1 := nQuantG1
					EndCase

					RestArea(aAreaSG1)
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Se Produto for FANTASMA gravar so os componentes.            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If (cAliasSG1)->FANTASM_COD == "S" // Projeto Implementacao de campos MRP e FANTASM no SBZ
					R450Fant(nQuantG1 )
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Gravar Valores da Producao no array aLstTrb1                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par01 == 1
						cKeyScan := (cAliasNew)->D3_OP+(cAliasSG1)->G1_COMP
					Else
						If mv_par10 == 1
							cKeyScan := SC2->C2_PRODUTO+(cAliasSG1)->G1_COMP
						Else
							cKeyScan := SC2->C2_PRODUTO+(cAliasSG1)->G1_COMP+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)
						EndIf
					EndIf

					If oLstTrb1J[cKeyScan] != NIL
						nPosTrb1 := oLstTrb1J[cKeyScan]
					Else
						nPosTrb1 := 0
					EndIf
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Valida Requesicoes de mesmo componente para a mesma estrutura ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !Empty(nPosTrb1) .And. !Empty(aLstTrb1[nPosTrb1,4])
						aRetSD3 := R450TRT("PR",nPosTrb1)
					Else
						aRetSD3 := {"",0,.F.}
					EndIf

					If Empty(nPosTrb1)
						aAdd(aLstTrb1,Array(14))
						nPosTrb1 := Len(aLstTrb1)
						aLstTrb1[nPosTrb1,01] := (cAliasSG1)->G1_COMP
						aLstTrb1[nPosTrb1,02] := (cAliasNew)->D3_OP
						aLstTrb1[nPosTrb1,09] := 0
						aLstTrb1[nPosTrb1,10] := 0
						aLstTrb1[nPosTrb1,11] := 0
						aLstTrb1[nPosTrb1,12] := 0
						aLstTrb1[nPosTrb1,13] := 0
						aLstTrb1[nPosTrb1,14] := 0
					
						oLstTrb1J[cKeyScan] := Len(aLstTrb1)
					EndIf
					aLstTrb1[nPosTrb1,04] := aRetSD3[1]
					aLstTrb1[nPosTrb1,07] := cProduto
					aLstTrb1[nPosTrb1,08] := (cAliasSG1)->G1_FIXVAR
					aLstTrb1[nPosTrb1,10] += Round(nQuantG1,nTamDecQtd)
					aLstTrb1[nPosTrb1,12] += R450Cus("S",mv_par06,Round(nQuantG1,nTamDecCus))
				EndIf
				(cAliasSG1)->(dbSkip())
			EndDo
			(cAliasSG1)->(dbCloseArea())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcular pelo Empenho                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Else
			dbSelectArea("SD4")
			dbSetOrder(2)
			dbSeek(xFilial("SD4")+(cAliasNew)->D3_OP)
			If (cAliasNew)->D3_OP # cOpAnt
				lOpConf:=.T.
			Else
				lOpConf:=.F.
			EndIf

			While SD4->(!Eof() .And. D4_FILIAL + D4_OP == xFilial("SD4")+(cAliasNew)->D3_OP ) .And. cOpAnt # (cAliasNew)->D3_OP .And. lOpConf

				If aScan(aRecnoD4, SD4->(RecNo())) > 0
					dbSkip()
					Loop
				EndIf

				aAdd(aRecnoD4, SD4->(RecNo()))

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Gravar Valores da Producao no array aLstTrb1                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("SB1")
				MsSeek(cFilSB1+SD4->D4_COD)
				If mv_par01 == 1
					nPosTrb1 := aScan(aLstTrb1,{|x|x[2]+x[1]==(cAliasNew)->D3_OP+SD4->D4_COD})
				Else
					If mv_par10 == 1
						nPosTrb1 := aScan(aLstTrb1,{|x|x[7]+x[1]==SC2->C2_PRODUTO+SD4->D4_COD})
					Else
						nPosTrb1 := aScan(aLstTrb1,{|x| x[7]+x[1]+x[2]==SC2->C2_PRODUTO+SD4->D4_COD+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)})
					EndIf
				EndIf

				If Empty(nPosTrb1)
					aAdd(aLstTrb1,Array(14))
					nPosTrb1 := Len(aLstTrb1)
					aLstTrb1[nPosTrb1,01] := SD4->D4_COD
					aLstTrb1[nPosTrb1,02] := (cAliasNew)->D3_OP
					aLstTrb1[nPosTrb1,09] := 0
					aLstTrb1[nPosTrb1,10] := 0
					aLstTrb1[nPosTrb1,11] := 0
					aLstTrb1[nPosTrb1,12] := 0
					aLstTrb1[nPosTrb1,13] := 0
					aLstTrb1[nPosTrb1,14] := 0
				EndIf
				aLstTrb1[nPosTrb1,07] := cProduto
				aLstTrb1[nPosTrb1,08] := ""
				aLstTrb1[nPosTrb1,10] += Round(SD4->D4_QTDEORI * SC2->(C2_QUJE/C2_QUANT), nTamDecQtd)
				aLstTrb1[nPosTrb1,12] += R450Cus("S",mv_par06,Round(SD4->D4_QTDEORI * SC2->(C2_QUJE/C2_QUANT),nTamDecCus))

				dbSelectArea("SD4")
				dbSkip()
			EndDo

			cOpAnt := (cAliasNew)->D3_OP
		EndIf
		dbSelectArea(cAliasNew)
	EndIf
	(cAliasNew)->(dbSkip())
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena por Ordem de Producao / Produto                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par01 == 1
	aLstTrb1 := ASort(aLstTrb1,,, { | x,y | x[2]+x[1] < y[2]+y[1] })
Else
	aLstTrb1 := ASort(aLstTrb1,,, { | x,y | x[7]+x[1] < y[7]+y[1] })
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da Impressao do array.                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title()+IIF(mv_par01 == 1, STR0009,STR0010)) //" ( Por Ordem de Producao )"###" ( Por Produto )"
oReport:SetMeter(RecCount())
oSection1:Init()
oSection2:Init()
oSection3:Init()
nQuantOp := 0.00

For nI:=1 To Len(aLstTrb1)

	oReport:IncMeter()

	If oReport:Cancel()
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao por OP e PRODUTO                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par01 = 1
		nPosTrb2 := aScan(aLstTrb2,{|x| x[2]==aLstTrb1[nI,2]})
	Else
		nPosTrb2 := aScan(aLstTrb2,{|x| x[1]==aLstTrb1[nI,7]})
	EndIf
	If Empty(nPosTrb2)
		Loop
	EndIf
	If mv_par02 == 1
		oSection1:Cell("CPROD"):SetValue(If(mv_par01=1,STR0036+aLstTrb2[nPosTrb2,2],STR0035)) //"OP: "###"PRODUTO:"
		oSection1:Cell("CDESC"):SetValue(aLstTrb2[nPosTrb2,1])
		oSection1:Cell("CUMED"):SetValue(aLstTrb2[nPosTrb2,3])
		oSection1:Cell("NQTDE"):SetValue(aLstTrb2[nPosTrb2,4])
		oSection1:PrintLine()
		oReport:SkipLine() //-- Salta linha
		nQuantOp := aLstTrb2[nPosTrb2,4]
	EndIf
	nCusStdOP := nTotStdOP := nCusRealOP := nTotRealOP := nTotVarOP := 0
	nCusUnitR := nCusUnitS := 0

	cAnt 	  := IIf( mv_par01 == 1,aLstTrb1[nI,02],aLstTrb1[nI,07])

	While nI <= Len(aLstTrb1) .And. IIF( mv_par01 == 1,aLstTrb1[nI,2],aLstTrb1[nI,7]) == cAnt
		nTotalVar  := aLstTrb1[nI,13]-aLstTrb1[nI,12]  //	CUSTOREAL-CUSTOSTD
		nQtdVar    := aLstTrb1[nI,09]-aLstTrb1[nI,10]	//	QTDREAL-QTDSTD
		nPercent   := (nQtdVar/aLstTrb1[nI,10])*100	//	((QTDREAL-QTDSTD)/QTDSTD)*100
		nCusUnit   := IIf(Empty(aLstTrb1[nI,09]),aLstTrb1[nI,13],Round(aLstTrb1[nI,13]/aLstTrb1[nI,09],nTamDecCus))	//Round(CUSTOREAL/IIF(QTDREAL=0,1,QTDREAL),nTamDecCus)
		nCusUStd   := IIf(Empty(aLstTrb1[nI,10]),aLstTrb1[nI,12],Round(aLstTrb1[nI,12]/aLstTrb1[nI,10],nTamDecCus))	//Round(CUSTOSTD/IIF(QTDSTD=0,1,QTDSTD),nTamDecCus)
		nSValor    := Round(nCusUnit*nQtdVar,nTamDecCus)
		nSQuant    := Round(nTotalVar-nSValor,nTamDecCus)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona na tabela de PRODUTOS                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB1->(DbSetOrder(1))
		SB1->(dbSeek(xFilial("SB1")+aLstTrb1[nI,01]))
		If mv_par02 == 1 .And. (mv_par09 == 1 .Or. (QtdComp(aLstTrb1[nI,09],.T.) # QtdComp(0,.T.)))
			oSection2:Cell("CPROD"	):SetValue(aLstTrb1[nI,01])
			oSection2:Cell("CDESC"	):SetValue(SB1->B1_DESC)
			oSection2:Cell("CUMED"	):SetValue(SB1->B1_UM)

			oSection2:Cell("NQTDE"		):SetValue(aLstTrb1[nI,09])
			oSection2:Cell("NCUSUNIT"	):SetValue(nCusUnit)
			oSection2:Cell("NVLTOT"		):SetValue(aLstTrb1[nI,13])

			oSection2:Cell("NQTDE2"		):SetValue(aLstTrb1[nI,10])
			oSection2:Cell("NCUSUSTD"	):SetValue(nCusUStd)
			oSection2:Cell("NVLTOT2"	):SetValue(aLstTrb1[nI,12])

			oSection2:Cell("NQTDE3"		):SetValue(nQtdVar)
			oSection2:Cell("NTOTALVAR"	):SetValue(nTotalVar)
			oSection2:Cell("NSVALOR"	):SetValue(nSValor)
			oSection2:Cell("NSQUANT"	):SetValue(nSQuant)
			oSection2:Cell("NPERC"		):SetValue(nPercent)

			oSection2:PrintLine()
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Aglutinar Produto para Posterior Resumo.                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosTrb3 := aScan(aLstTrb3,{|x|x[1]==aLstTrb1[nI,1]})
		If Empty(nPosTrb3)
			aAdd(aLstTrb3,{	aLstTrb1[nI,01],; //PRODUTO
							aLstTrb1[nI,09],; //QTDREAL
							aLstTrb1[nI,10],; //QTDSTD
							aLstTrb1[nI,13],; //CUSTOREAL
							aLstTrb1[nI,12],; //CUSTOSTD
							SB1->B1_DESC})    //DESCRICAO
		Else
			aLstTrb3[nPosTrb3,02] += aLstTrb1[nI,09] //QTDREAL
			aLstTrb3[nPosTrb3,03] += aLstTrb1[nI,10] //QTDSTD
			aLstTrb3[nPosTrb3,04] += aLstTrb1[nI,13] //CUSTOREAL
			aLstTrb3[nPosTrb3,05] += aLstTrb1[nI,12] //CUSTOSTD
		EndIf
		nCusUnitR  += nCusUnit
		nCusUnitS  += nCusUStd
		nTotRealOP += aLstTrb1[nI,13]
		nTotStdOP  += aLstTrb1[nI,12]
		nTotVarOP  += nTotalVar
		nI++
		If nI > Len(aLstTrb1) .Or. IIf( mv_par01 == 1,aLstTrb1[nI,2],aLstTrb1[nI,7]) # cAnt
			nI--
			Exit
		EndIf
	EndDo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao dos Totais por OP/Produto.                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par02 == 1
		oReport:ThinLine() //-- Impressao de Linha Simples
		oSection3:Cell("CTOTAL"			):SetValue(STR0012+IIf(mv_par01==1,STR0013,STR0014)) //"Total "###"da OP:"###"do Produto:"
		oSection3:Cell("NTOTREALOPU"	):SetValue((nTotRealOP/nQuantOp))
		oSection3:Cell("NTOTREALOP"		):SetValue(nTotRealOP)
		oSection3:Cell("NTOTSTDOPU"		):SetValue((nTotStdOP/nQuantOp))
		oSection3:Cell("NTOTSTDOP"		):SetValue(nTotStdOP)
		oSection3:Cell("NTOTVAROP"		):SetValue(nTotRealOP - nTotStdOP)
		oSection3:PrintLine()
		oReport:ThinLine() //-- Impressao de Linha Simples
		oReport:SkipLine() //-- Salta linha
	EndIf
Next
oSection2:SetHeaderSection(.F.)
oSection4:SetHeaderSection(.T.)
oSection1:Finish()
oSection2:Finish()
oSection3:Finish()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Resumo Aglutinado por Produto.              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(STR0015) //"V A R I A C A O   DE   U S O   E   C O N S U M O"
oReport:SetMeter(Len(aLstTrb1))
oReport:EndPage()
oSection4:Init()
aLstTrb3 := aSort(aLstTrb3,,, { | x,y | x[1] < y[1] })
For nI:=1 To Len(aLstTrb3)
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	oSection4:Cell("CPROD" 		):SetValue(aLstTrb3[nI,01])
	oSection4:Cell("CDESC" 		):SetValue(aLstTrb3[nI,06])
	oSection4:Cell("NQTDE" 		):SetValue(aLstTrb3[nI,02])
	oSection4:Cell("NVLTOT"		):SetValue(aLstTrb3[nI,04])
	oSection4:Cell("NQTDE2"		):SetValue(aLstTrb3[nI,03])
	oSection4:Cell("NVLTOT2"	):SetValue(aLstTrb3[nI,05])
	oSection4:Cell("NQTDE3"		):SetValue(Round(aLstTrb3[nI,02]-aLstTrb3[nI,03],nTamDecCus))
	oSection4:Cell("NVLTOT3"	):SetValue(Round(aLstTrb3[nI,04]-aLstTrb3[nI,05],nTamDecCus))
	oSection4:Cell("NPERCTOT"	):SetValue( (oSection4:Cell("NQTDE3"):GetValue() / aLstTrb3[nI,03]) * 100  )
	oSection4:PrintLine()
	oReport:ThinLine() //-- Impressao de Linha Simples
Next
oSection4:Finish()
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R450Cus   ³ Autor ³ Erike Yuri da Silva  ³ Data ³14/03/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o Custo.                                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ExpN1 := R450Cus(ExpC1,ExpN2,ExpN3)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 := Tipo "S" para Standard e "R" para Real            ³±±
±±³          ³ ExpC1 := Tipo "S" para Standard e "R" para Real            ³±±
±±³          ³ ExpN2 := Indica a Moeda para obtencao do Custo             ³±±
±±³          ³ ExpN3 := Quantidade utilizada.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR450                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/
Static Function R450Cus(cTipo,nMoeda,nQtd,cAliasSD3)
Local aAreaAnt  := GetArea()
Local nRet      := 0

Default cAliasSD3 := "SD3"
Default nQtd      := 0

If cTipo = "R" 	// Custo Real
	nRet := (cAliasSD3)->( &("D3_CUSTO"+ Str(nMoeda,1)) ) * IIf(SubStr((cAliasSD3)->D3_CF, 1, 1) == 'R', 1, -1)
Else  // Custo Standard
	dbSelectArea("SB1")
	nRet := (nQtd*xMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")), nMoeda, RetFldProd(SB1->B1_COD,"B1_DATREF") ))
EndIf

RestArea(aAreaAnt)
Return (nRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R450Fant  ³ Autor ³ Cesar Eduardo Valadao³ Data ³ 01.06.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna a Estrutura de Produto Fantasma                    ³±±
±±³          ³ Funcao Recursiva.                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R450Fant(ExpN1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 := Quantidade do Pai.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR450                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
Static Function R450Fant(nQuantPai)
Local aAreaAnt  := GetArea()
Local aAreaSB1  := SB1->(GetArea())
Local aAreaSG1  := SG1->(GetArea())
Local cComponen := SG1->G1_COMP
Local nPosTrb1  := 0

dbSelectArea("SG1")
If dbSeek(xFilial("SG1")+cComponen, .F.)
	While !Eof() .And. G1_FILIAL+G1_COD == xFilial("SG1")+cComponen
		If G1_INI > dDataBase .Or. G1_FIM < dDataBase
			dbSkip()
			Loop
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Gravar Valores da Producao em TRB do componente.             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SB1")
		If MsSeek(xFilial("SB1")+SG1->G1_COMP)
			If SG1->G1_FIXVAR == "F"
				nQuantG1 := SG1->G1_QUANT
			Else
				nQuantG1 := ExplEstr(nQuantPai,SC2->C2_DATPRI,SC2->C2_OPC,SC2->C2_REVISAO)
			EndIf
			If mv_par01 == 1
				nPosTrb1 := aScan(aLstTrb1,{|x| x[2]+x[1]==(cAliasNew)->D3_OP+SG1->G1_COMP})
			Else
				If mv_par10 == 1
					nPosTrb1 := aScan(aLstTrb1,{|x| x[7]+x[1]==SC2->C2_PRODUTO+SG1->G1_COMP})
				Else
					nPosTrb1 := aScan(aLstTrb1,{|x| x[7]+x[1]+x[2]==SC2->C2_PRODUTO+SG1->G1_COMP+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)})
				EndIf
			EndIf

			If RetFldProd(SB1->B1_COD,"B1_FANTASM") == "S" // Projeto Implementeacao de campos MRP e FANTASM no SBZ
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Se Produto for FANTASMA gravar so os componentes.            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				R450Fant(nQuantG1 )
			Else
				If !Empty(nPosTrb1) .And. !Empty(aLstTrb1[nPosTrb1,04])
					aRetSD3 := R450TRT("PR",nPosTrb1)
				Else
					aRetSD3 := {"",0,.F.}
				EndIF

				If Empty(nPosTrb1)
					aAdd(aLstTrb1,Array(14))
					nPosTrb1 := Len(aLstTrb1)
					aLstTrb1[nPosTrb1,01] := SG1->G1_COMP
					aLstTrb1[nPosTrb1,02] := (cAliasNew)->D3_OP
					aLstTrb1[nPosTrb1,09] := 0
					aLstTrb1[nPosTrb1,10] := 0
					aLstTrb1[nPosTrb1,12] := 0
					aLstTrb1[nPosTrb1,13] := 0
					aLstTrb1[nPosTrb1,14] := 0
				EndIf
				aLstTrb1[nPosTrb1,04] := aRetSD3[1]
				aLstTrb1[nPosTrb1,07] := cProduto
				aLstTrb1[nPosTrb1,08] := SG1->G1_FIXVAR
				aLstTrb1[nPosTrb1,10] += Round(nQuantG1,nTamDecQtd)
				aLstTrb1[nPosTrb1,12] += R450Cus("S",mv_par06,Round(nQuantG1,nTamDecCus))

			EndIf
		EndIf
		dbSelectArea("SG1")
		dbSkip()
	End
EndIf
RestArea(aAreaSB1)
RestArea(aAreaSG1)
RestArea(aAreaAnt)
Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R450TRT   ³ Autor ³ Marcelo Iuspa        ³ Data ³ 24.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Funcao para tratar duas ou mais requisicoes de um mesmo    ³±±
±±³          ³ componente utilizados dentro da mesma estrutura.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R450TRT(ExpC1,ExpN2)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 := Tipo de Movimento 'RE' ou 'PR'                    ³±±
±±³          ³ ExpN1 := Numero da Linha                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR450                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
Static Function R450TRT(cTipoMov,nLin)
Local cConteudo := If(Empty(nLin),"",RTrim(aLstTrb1[nLin,4]))
Local aAreaAnt  := GetArea()
Local cQuery    := ""
Local cAliasSD3 := ""
Local nRegSD3   := 0
Local nPosCorte := 0
Local lReposSD3 := .F.
Local xRetorno

If cTipoMov == "RE"
	// Chamado a partir da leitura das REQUISICOES para compor o REAL
	If !Empty((cAliasNew)->D3_TRT)
		If Empty(cConteudo)
			xRetorno := "   /" + (cAliasNew)->D3_TRT
		Else
			xRetorno := cConteudo+"/" + (cAliasNew)->D3_TRT
		EndIf
	EndIf
Else
	// Chamado a partir da leitura das PRODUCOES para compor o STANDARD
	lReposSD3	:= .F.
	nPosCorte	:= At("/",cConteudo)
	If nPosCorte <> 0
		cTRTCorte	:= SubStr(cConteudo,1,nPosCorte-1)
		cConteudo	:= Substr(cConteudo,nPosCorte+1,Len(cConteudo))
	Else
		cTRTCorte	:= AllTrim(cConteudo)
		cConteudo	:= ""
	EndIf
	nRegSD3	:= SD3->( Recno() )

	cAliasSD3 := GetNextAlias()
	cQuery    := "SELECT SD3.R_E_C_N_O_ SD3RECNO "
	cQuery    +=   "FROM " + RetSqlName("SD3") + " SD3 "
	cQuery    +=  "WHERE SD3.D3_FILIAL  = '"  + xFilial('SD3') 			+ "' "
	cQuery    +=    "AND SD3.D3_EMISSAO = '"  + DTOS(aLstTrb1[nLin,06])+ "' "
	cQuery    +=    "AND SD3.D3_NUMSEQ  = '"  + aLstTrb1[nLin,03] 		+ "' "
	cQuery    +=    "AND SD3.D3_CHAVE   = '"  + aLstTrb1[nLin,05] 		+ "' "
	cQuery    +=    "AND SD3.D3_COD     = '"  + aLstTrb1[nLin,01] 		+ "' "
	cQuery    +=    "AND SD3.D_E_L_E_T_ = ' ' "
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasSD3,.F.,.T.)
	Do While !Eof()
		xRetorno := {cConteudo,(cAliasSD3)->SD3RECNO,.T.}
		Exit
		dbSkip()
	EndDo
	(cAliasSD3)->(dbCloseArea())
	RestArea(aAreaAnt)

EndIf

Return (xRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R450Qtd   ³ Autor ³ Fernando Joly Siquini³ Data ³03/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna a Quantidade                                       ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ExpN1 := R450Qtd(ExpC1,ExpN2,ExpN3)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 := Tipo "R" Qtde Real, "S" Qtde Standard             ³±±
±±³          ³ ExpN2 := Quantidade Standard                               ³±±
±±³          ³ ExpC3 := Alias da tabela SD3                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR450                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/
Static Function R450Qtd(cTipo,nQuant,cAliasSD3)

Local aAreaAnt   := GetArea()
Local nRet       := 0

Default cAliasSD3:= "SD3"

If cTipo = "R" // Quantidade Real
	nRet := (cAliasSD3)->D3_QUANT*IIf(SubStr((cAliasSD3)->D3_CF, 1, 1)=='R', 1, -1)
Else // Quantidade Standard
	nRet := nQuant
EndIf

RestArea(aAreaAnt)
Return (nRet)
