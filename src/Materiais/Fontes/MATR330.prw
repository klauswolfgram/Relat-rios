/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR330.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR330  ³ Autor ³ Marcos V. Ferreira    ³ Data ³ 22/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Mapa das Movimentacoes                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR330()
Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Marcos V. Ferreira     ³ Data ³22/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR330			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local aOrdem    := {STR0005,STR0006}	//" Tipo     "###" Grupo    "
Local nTamQAtu  := TamSX3("B2_QATU"  )[1]
Local nTamVIni  := TamSX3("B9_VINI1" )[1]
Local nTamCusD1 := TamSX3("D1_CUSTO" )[1]
Local nTamCusD2 := TamSX3("D2_CUSTO1")[1]
Local nTamCusD3 := TamSX3("D3_CUSTO1")[1]
Local oProduto
Local oLinha
Local cAliasTop := GetNextAlias()    

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
oReport:= TReport():New("MATR330",STR0001,"MTR330", {|oReport| ReportPrint(oReport,aOrdem,cAliasTop)},STR0002+" "+STR0003+" "+STR0004) //"Mapa das Movimentacoes"
oReport:DisableOrientation()
oReport:SetLandscape() 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Almox. de                                    ³
//³ mv_par02     // Almox. ate                                   ³
//³ mv_par03     // Produto de                                   ³
//³ mv_par04     // Produto ate                                  ³
//³ mv_par05     // tipo de                                      ³
//³ mv_par06     // tipo ate                                     ³
//³ mv_par07     // grupo de                                     ³
//³ mv_par08     // grupo ate                                    ³
//³ mv_par09     // data inicial                                 ³
//³ mv_par10     // data final                                   ³
//³ mv_par11     // moeda selecionada ( 1 a 5 )                  ³
//³ mv_par12     // Saldo a considerar : Atual/Fechamento/Movim. ³
//³ mv_par13     // Rem/Dev Poder 3 Compras - Sim/Nao            ³
//³ mv_par14     // Rem/Dev Poder 3 Vendas  - Sim/Nao            ³
//³ mv_par15     // Impr. Vlr. Medio  - Sim/Nao                  ³
//³ mv_par16     // Imprime OPs geradas pelo SIGAMNT? Sim / Nao  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Sessao 1 - (Detalhes do Produto)                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oProduto:= TRSection():New(oReport,STR0050,{"SB1"},aOrdem) //"Produto"
oProduto:SetTotalInLine(.F.)

TRCell():New(oProduto,'B1_TIPO'		,'SB1',,/*Picture*/,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'B1_GRUPO'	,'SB1',,/*Picture*/,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'B1_UM'		,'SB1',,/*Picture*/,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'B1_CODITE'	,'SB1',,/*Picture*/,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'B1_COD'		,'SB1',,/*Picture*/,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'B1_DESC'		,'SB1',,/*Picture*/,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'txtQuant'	,'   ',,/*Picture*/,13			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'nQuant'		,'   ',,/*Picture*/,nTamQAtu		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'txtValor1'	,'   ',,/*Picture*/,12			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'nValor01'	,'   ',,/*Picture*/,nTamQAtu		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'txtValor2'	,'   ',,/*Picture*/,18			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oProduto,'nValor02'	,'   ',,/*Picture*/,nTamQAtu		,/*lPixel*/,/*{|| code-block de impressao }*/)

oProduto:Cell("B1_TIPO"):HideHeader()
oProduto:Cell("B1_GRUPO"):HideHeader()
oProduto:Cell("B1_UM"):HideHeader()
oProduto:Cell("B1_CODITE"):HideHeader()
oProduto:Cell("B1_COD"):HideHeader()
oProduto:Cell("B1_DESC"):HideHeader()
oProduto:Cell("txtQuant"):HideHeader()
oProduto:Cell("nQuant"):HideHeader()
oProduto:Cell("txtValor1"):HideHeader()
oProduto:Cell("nValor01"):HideHeader()
oProduto:Cell("txtValor2"):HideHeader()
oProduto:Cell("nValor02"):HideHeader()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Sessao 2 - (Linha de Quantidade/Valor)            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oLinha:= TRSection():New(oProduto,STR0051,{"SB1"},aOrdem,/*lLoadCells*/,/*lLoadOrder*/,,,,,,,,,,.F. /*AutoSize*/) //"Movimentacao dos produtos"
oLinha:SetTotalInLine(.F.)

TRCell():New(oLinha,'cTexto'	,'',STR0022+CRLF+STR0023	,"@!"/*Picture*/,6      ,/*lPixel*/,{|| Space(6) },/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/)
TRCell():New(oLinha,'Compra'	,'',STR0024					,/*Picture*/,nTamCusD1	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'DevVen'	,'',STR0025+CRLF+STR0026	,/*Picture*/,nTamCusD1	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'ReqSOP'	,'',STR0027+CRLF+STR0028	,/*Picture*/,nTamCusD3	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'ReqCOP'	,'',STR0029+CRLF+STR0030	,/*Picture*/,nTamCusD3	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'RE3DE3'	,'',STR0029+CRLF+STR0031	,/*Picture*/,nTamCusD3	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'IniPrc'	,'',STR0032+CRLF+STR0033	,/*Picture*/,nTamVIni	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'RE2DE2'	,'',STR0034+CRLF+STR0035	,/*Picture*/,nTamCusD3	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'FimPrc'	,'',STR0036+CRLF+STR0033	,/*Picture*/,nTamVIni 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'RE4DE4'	,'',STR0037+CRLF+STR0028	,/*Picture*/,nTamCusD3	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'Produc'	,'',STR0038					,/*Picture*/,nTamCusD3	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'Transf'	,'',STR0037+CRLF+STR0039	,/*Picture*/,nTamCusD2	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'Vendas'	,'',STR0040					,/*Picture*/,nTamCusD2	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'Entrad'	,'',STR0041+CRLF+STR0042	,/*Picture*/,nTamCusD2	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oLinha,'Saidas'	,'',STR0041+CRLF+STR0043	,/*Picture*/,nTamCusD2	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

oLinha:SetHeaderPage()
oLinha:SetReadOnly()

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Marcos V. Ferreira   ³ Data ³22/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR330			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem,cAliasTop)

Local oLinha 	:= oReport:Section(1):Section(1)
Local oProduto	:= oReport:Section(1)
Local nOrdem   	:= oProduto:GetOrder()
Local nTvIniAlm := nTvCompra := nTvDevVen := nTvReqSOP := nTvReqCOP := nTvRE3DE3 := nTvIniPrc := nTvRE2DE2 := nTvFimPrc := nTvRE4DE4 := nTvProduc := nTvTransf := nTvVendas := nTvFimAlm := 0
Local nTqQtdIni := nTqCompra := nTqDevVen := nTqReqSOP := nTqReqCOP := nTqRE3DE3 := nTqIniPrc := nTqRE2DE2 := nTqFimPrc := nTqRE4DE4 := nTqProduc := nTqTransf := nTqVendas := nTqQtdFim := 0
Local nGvIniAlm := nGvCompra := nGvDevVen := nGvReqSOP := nGvReqCOP := nGvRE3DE3 := nGvIniPrc := nGvRE2DE2 := nGvFimPrc := nGvRE4DE4 := nGvProduc := nGvTransf := nGvVendas := nGvFimAlm := 0
Local nGqQtdIni := nGqCompra := nGqDevVen := nGqReqSOP := nGqReqCOP := nGqRE3DE3 := nGqIniPrc := nGqRE2DE2 := nGqFimPrc := nGqRE4DE4 := nGqProduc := nGqTransf := nGqVendas := nGqQtdFim := 0
Local nAqIniAlm := nAqCompra := nAqDevVen := nAqReqSOP := nAqReqCOP := nAqRE3DE3 := nAqIniPrc := nAqRE2DE2 := nAqFimPrc := nAqRE4DE4 := nAqProduc := nAqTransf := nAqVendas := nAqFimAlm := 0
Local nAvIniAlm := nAvCompra := nAvDevVen := nAvReqSOP := nAvReqCOP := nAvRE3DE3 := nAvIniPrc := nAvRE2DE2 := nAvFimPrc := nAvRE4DE4 := nAvProduc := nAvTransf := nAvVendas := nAvFimAlm := 0
Local nAqEntrad := nAvEntrad := nTqEntrad := nTvEntrad := nGqEntrad := nGvEntrad := 0
Local nAqSaidas := nAvSaidas := nTqSaidas := nTvSaidas := nGqSaidas := nGvSaidas := 0
Local xSD3		:= xSD1 := xSD2 := xSF4 := xSB1 := xSB2 := ''
Local lPassou   := .F. 
Local lTeveItem := .F. 
Local lTotal	:= .F.
Local lRetPE	:= .F.
Local lR330Trans:= ExistBlock('R330TRANS')
Local cCodAux   := ''
Local cLocalAux := '  '
Local bBloco    := { |nV,nX| Trim(nV)+Str(nX,1) }
Local nVUnit    := 0
Local cCondWhile:= ''
Local cAnt      := ''
Local cVar      := ''
Local cTrbSB1 	:= CriaTrab('',.F.)
Local cTrbSB2 	:= Subs(cTRBSB1,1,7)+'A'
Local cTrbSD1 	:= Subs(cTRBSB1,1,7)+'B'
Local cTrbSD2 	:= Subs(cTRBSB1,1,7)+'C'
Local cTrbSD3 	:= Subs(cTRBSB1,1,7)+'D'
Local nIndex	:= 0
Local nIndB2    := 0
Local nCusto    := 0
Local lVeic		:= Upper(GetMV('MV_VEICULO'))=='S'
Local cLocProc  := GetMvNNR('MV_LOCPROC','99')
Local lLocProc :=  cLocProc >= mv_par01 .And. cLocProc <= mv_par02
Local cAliasSB1 := 'SB1'
Local cAliasSB2 := 'SB2'
Local cAliasSD1 := 'SD1'
Local cAliasSD2 := 'SD2'
Local cAliasSD3 := 'SD3'
Local aSldFimPrc:= {0,0}
Local cOrderBy  := ''
Local cB1_COD   := ''
Local cFilUser  := oReport:Section(1):GetAdvplExp()
Local cIndexkey	:= ''
Local cTipant   := ''
Local cFiliant  := ''
Local cPictQIni := PesqPict(IIf(mv_par12==1,'SB2','SB9'),IIf(mv_par12==1,'B2_QATU','B9_QINI'))
Local cPictQaB2 := PesqPict('SB2',IIf(mv_par12==1,'B2_QATU','B2_QFIM'))
Local cPictQtD1 := PesqPict('SD1','D1_QUANT')
Local cPictQtD2 := PesqPict('SD2','D2_QUANT')
Local cPictQtD3 := PesqPict('SD3','D3_QUANT')
Local cPictQfB2 := PesqPict('SB2','B2_QFIM' )
Local cPictVIni := PesqPict('SB9','B9_VINI1' )
Local cPictFim  := PesqPict('SB2','B2_VFIM1' )
Local cPictIni  := PesqPict('SB9','B9_QINI'  )
Local cPictCusD1:= PesqPict('SD1','D1_CUSTO' )
Local cPictCusD2:= PesqPict('SD2','D2_CUSTO1')
Local cPictCusD3:= PesqPict('SD3','D3_CUSTO1')
Local cSelectD1 := cWhereD1  := ''
Local cSelectD2 := cWhereD2  := ''
Local cSelectD3 := cWhereD3  := ''
Local cSelectB2 := cWhereB2  := ''
Local lWmsNew		:= SuperGetMv("MV_WMSNEW",.F.,.F.)
Local lD3Servi	:= IIF(lWmsNew,.F.,GetMV('MV_D3SERVI',.F.,'N')=='N')

dbSelectArea("SD2")
dbSetOrder(1)
nRegs := SD2->(LastRec())
xSD2  := xFilial("SD2")

dbSelectArea("SD3")
dbSetOrder(1)
nRegs += SD3->(LastRec())
xSD3  := xFilial("SD3")

dbSelectArea("SD1")
dbSetOrder(1)
nRegs += SD1->(LastRec())
xSD1  := xFilial("SD1")

dbSelectArea("SF4")
dbSetOrder(1)
xSF4  := xFilial("SF4")

dbSelectArea("SB2")
dbSetOrder(1)
xSB2  := xFilial("SB2")

dbSelectArea("SB1")
dbSetOrder(1)
xSB1  := xFilial("SB1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " ("+AllTrim(aOrdem[nOrdem])+") ")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desabilita colunas nao utilizadas no relatorio               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lVeic
	oProduto:Cell("B1_CODITE"):Disable()
EndIf
//-- Valor Inicial/Final Medio
If !(mv_par15 == 1)
	oProduto:Cell('txtValor2' ):Disable()
	oProduto:Cell('nValor02'  ):Disable()
EndIf


oReport:NoUserFilter()  // Desabilita a aplicacao do filtro do usuario no filtro/query das secoes

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do SELECT da tabela SB2                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSelectB2 := "%"
If lVeic
	cSelectB2 +=	", SB1.B1_CODITE CODITE "
EndIf
cSelectB2 += ",%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do WHERE da tabela SB2                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhereB2 := "%"
If !lVeic
	cWhereB2 += " SB1.B1_COD >= '" + mv_par03 + "'"
	cWhereB2 += " AND SB1.B1_COD <= '" + mv_par04 + "'"
Else
	cWhereB2 += " SB1.B1_CODITE >= '" + mv_par03 + "'"
	cWhereB2 += " AND SB1.B1_CODITE <= '" + mv_par04 + "'"
EndIf
cWhereB2 += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do SELECT da tabela SD1                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSelectD1 := "% D1_CUSTO"
If mv_par11 > 1
	cSelectD1 += Str(mv_par11,1,0) // Coloca a Moeda do Custo
EndIf
cSelectD1 += " CUSTO"
If lVeic
	cSelectD1	+=	", SB1.B1_CODITE CODITE"
EndIf
cSelectD1 += ",%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do WHERE da tabela SD1                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhereD1 := "%"
If cPaisLoc <> "BRA"
	cWhereD1 += " AND D1_REMITO = '" + Space(TamSx3("D1_REMITO")[1]) + "' "
EndIf
cWhereD1 += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do SELECT da tabela SD2                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    cSelectD2 := "% D2_CUSTO"
cSelectD2 += Str(mv_par11,1,0) // Coloca a Moeda do Custo
cSelectD2 += " CUSTO"
If lVeic
	cSelectD2	+=	", SB1.B1_CODITE CODITE"
EndIf
    cSelectD2 += ",%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do WHERE da tabela SD2                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhereD2 := "%"
If cPaisLoc <> "BRA"
	cWhereD2 += " AND D2_REMITO = '" + Space(TamSx3("D2_REMITO")[1]) + "' "
EndIf
cWhereD2 += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do SELECT da tabelas SD3                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSelectD3 := "% D3_CUSTO"
cSelectD3 += Str(mv_par11,1,0) // Coloca a Moeda do Custo
cSelectD3 +=	" CUSTO" 
If lVeic
	cSelectD3 +=	", SB1.B1_CODITE CODITE" 
EndIf
cSelectD3 += ",%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Complemento do WHERE da tabela SD3                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    cWhereD3 := "%"
If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cWhereD3 += " AND D3_ESTORNO <> 'S'"
EndIf
If lD3Servi .And. IntDL()
	cWhereD3 += " AND ( (D3_SERVIC = '   ') OR (D3_SERVIC <> '   ' AND D3_TM <= '500')  "
	cWhereD3 += " OR  (D3_SERVIC <> '   ' AND D3_TM > '500' AND D3_LOCAL ='" + GetMvNNR('MV_CQ','98') + "') )"
EndIf
cWhereD3 += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Montagem do ORDER BY                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cOrderBy := "%"
If !lVeic
	If nOrdem == 1
		cOrderBy += "TIPO,PRODUTO,ARQ" //3-TIPO/2-PRODUTO/1-ARQ
	Else
		cOrderBy += "GRUPO,PRODUTO,ARQ" //5-GRUPO/2-PRODUTO/1-ARQ
	EndIf
Else
	If nOrdem == 1
		cOrderBy += "TIPO,CODITE,PRODUTO,ARQ" //3-TIPO/21-CODITE/2-PRODUTO/1-ARQ
	Else
		cOrderBy += "GRUPO,CODITE,PRODUTO,ARQ" //5-GRUPO/21-CODITE/2-PRODUTO/1-ARQ
	EndIf
EndIf	
cOrderBy += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da Secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oLinha:BeginQuery()	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio do Embedded SQL                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BeginSql Alias cAliasTop

	SELECT 	'SD1' ARQ, 				//-- 01 ARQ
			 SB1.B1_COD PRODUTO, 	//-- 02 PRODUTO
			 SB1.B1_TIPO TIPO, 		//-- 03 TIPO
			 SB1.B1_UM UM,			//-- 04 UM
			 SB1.B1_GRUPO GRUPO,	//-- 05 GRUPO
			 SB1.B1_DESC DESCR,		//-- 06 DESCR
			 D1_DTDIGIT DTDIGIT,	//-- 07 DATA
			 D1_TES TES,			//-- 08 TES
			 D1_CF CF,				//-- 09 CF
			 D1_NUMSEQ SEQUENCIA,	//-- 10 SEQUENCIA
			 D1_DOC DOCUMENTO,		//-- 11 DOCUMENTO
			 D1_SERIE SERIE,		//-- 12 SERIE
			 D1_QUANT QUANTIDADE,	//-- 13 QUANTIDADE
			 D1_QTSEGUM QUANT2UM,	//-- 14 QUANT2UM
			 D1_LOCAL ARMAZEM,		//-- 15 ARMAZEM
			 ' ' OP,				//-- 16 OP
			 D1_FORNECE FORNECEDOR,	//-- 17 FORNECEDOR
			 D1_LOJA LOJA,			//-- 18 LOJA
			 D1_TIPO TIPONF,		//-- 19 TIPO NF
			 %Exp:cSelectD1%		//-- 20 CUSTO / 21 B1_CODITE	
			 SD1.R_E_C_N_O_ NRECNO  //-- 22 RECNO

	FROM %table:SB1% SB1,%table:SD1% SD1,%table:SF4% SF4

	WHERE SB1.B1_COD     =  SD1.D1_COD		AND  	SD1.D1_FILIAL  =  %xFilial:SD1%		AND
		  SF4.F4_FILIAL  =  %xFilial:SF4%  	AND 	SD1.D1_TES     =  SF4.F4_CODIGO		AND
		  SF4.F4_ESTOQUE =  'S'				AND 	SD1.D1_DTDIGIT >= %Exp:mv_par09%   AND
		  SD1.D1_DTDIGIT <= %Exp:mv_par10%	AND		SD1.D1_ORIGLAN <> 'LF'				AND
		  SD1.D1_LOCAL   >= %Exp:mv_par01%	AND		SD1.D1_LOCAL   <= %Exp:mv_par02%	AND
		  SB1.B1_FILIAL  =  %xFilial:SB1%	AND		SB1.B1_TIPO    >= %Exp:mv_par05%	AND
		  SB1.B1_TIPO    <= %Exp:mv_par06%	AND		SB1.B1_GRUPO   >= %Exp:mv_par07%	AND
		  SB1.B1_GRUPO   <= %Exp:mv_par08%	AND		SB1.%NotDel%						AND
		  SD1.%NotDel%						AND 	SF4.%NotDel%
		  %Exp:cWhereD1%					AND		%Exp:cWhereB2%

	UNION
	
	SELECT 'SD2' ARQ,				//-- 01 ARQ
			SB1.B1_COD PRODUTO,		//-- 02 PRODUTO
			SB1.B1_TIPO TIPO,		//-- 03 TIPO
			SB1.B1_UM,				//-- 04 UM
			SB1.B1_GRUPO GRUPO,		//-- 05 GRUPO
			SB1.B1_DESC DESCR,		//-- 06 DESCR
			D2_EMISSAO,				//-- 07 DATA
			D2_TES,					//-- 08 TES
			D2_CF,					//-- 09 CF
			D2_NUMSEQ,				//-- 10 SEQUENCIA
			D2_DOC,					//-- 11 DOCUMENTO
			D2_SERIE,				//-- 12 SERIE
			D2_QUANT,				//-- 13 QUANTIDADE
			D2_QTSEGUM,				//-- 14 QUANT2UM
			D2_LOCAL,				//-- 15 ARMAZEM
			' ',					//-- 16 OP
			D2_CLIENTE,				//-- 17 FORNECEDOR
			D2_LOJA,				//-- 18 LOJA
			D2_TIPO,				//-- 19 TIPO NF
			%Exp:cSelectD2%			//-- 20 CUSTO / 21 B1_CODITE	
			SD2.R_E_C_N_O_ SD2RECNO //-- 22 RECNO

	FROM %table:SB1% SB1,%table:SD2% SD2,%table:SF4% SF4
	
	WHERE	SB1.B1_COD     =  SD2.D2_COD		AND	SD2.D2_FILIAL  = %xFilial:SD2%		AND
			SF4.F4_FILIAL  = %xFilial:SF4% 		AND	SD2.D2_TES     =  SF4.F4_CODIGO		AND
			SF4.F4_ESTOQUE =  'S'				AND	SD2.D2_EMISSAO >= %Exp:mv_par09%	AND
			SD2.D2_EMISSAO <= %Exp:mv_par10%	AND	SD2.D2_ORIGLAN <> 'LF'				AND
			SD2.D2_LOCAL   >= %Exp:mv_par01%	AND	SD2.D2_LOCAL   <= %Exp:mv_par02%	AND
			SD2.%NotDel%						AND SF4.%NotDel%						AND
			SB1.B1_FILIAL  = %xFilial:SB1%		AND SB1.B1_TIPO    >= %Exp:mv_par05%	AND
			SB1.B1_TIPO    <= %Exp:mv_par06%	AND SB1.B1_GRUPO   >= %Exp:mv_par07%	AND
			SB1.B1_GRUPO   <= %Exp:mv_par08%	AND SB1.%NotDel%
		    %Exp:cWhereD2%						AND %Exp:cWhereB2%

	UNION
	
	SELECT 	'SD3' ARQ,				//-- 01 ARQ
			SB1.B1_COD PRODUTO,		//-- 02 PRODUTO
			SB1.B1_TIPO TIPO,		//-- 03 TIPO
			SB1.B1_UM,				//-- 04 UM
			SB1.B1_GRUPO GRUPO,		//-- 05 GRUPO
			SB1.B1_DESC DESCR,		//-- 06 DESCR
			D3_EMISSAO,				//-- 07 DATA
			D3_TM,					//-- 08 TES
			D3_CF,					//-- 09 CF
			D3_NUMSEQ,				//-- 10 SEQUENCIA
			D3_DOC,					//-- 11 DOCUMENTO
			' ',					//-- 12 SERIE
			D3_QUANT,				//-- 13 QUANTIDADE
			D3_QTSEGUM,				//-- 14 QUANT2UM
			D3_LOCAL,				//-- 15 ARMAZEM
			D3_OP,					//-- 16 OP
			' ',					//-- 17 FORNECEDOR
			' ',					//-- 18 LOJA
			' ',					//-- 19 TIPO NF
			%Exp:cSelectD3%			//-- 20 CUSTO / 21 B1_CODITE	
			SD3.R_E_C_N_O_ SD3RECNO //-- 22 RECNO

	FROM %table:SB1% SB1,%table:SD3% SD3

	WHERE	SB1.B1_COD     =  SD3.D3_COD 		AND SD3.D3_FILIAL  =  %xFilial:SD3%		AND
			SD3.D3_EMISSAO >= %Exp:mv_par09%	AND	SD3.D3_EMISSAO <= %Exp:mv_par10%	AND
			SD3.D3_LOCAL   >= %Exp:mv_par01%	AND	SD3.D3_LOCAL   <= %Exp:mv_par02%	AND
			SD3.%NotDel%						AND SB1.B1_FILIAL  =  %xFilial:SB1%		AND
			SB1.B1_TIPO    >= %Exp:mv_par05%	AND SB1.B1_TIPO    <= %Exp:mv_par06%	AND
			SB1.B1_GRUPO   >= %Exp:mv_par07%	AND SB1.B1_GRUPO   <= %Exp:mv_par08%	AND
			SB1.%NotDel%
			%Exp:cWhereD3%						AND %Exp:cWhereB2%

				UNION
		
		SELECT 	'SD3S' ARQ,				//-- 01 ARQ
				SB1.B1_COD PRODUTO,		//-- 02 PRODUTO
				SB1.B1_TIPO TIPO,		//-- 03 TIPO
				SB1.B1_UM,				//-- 04 UM
				SB1.B1_GRUPO GRUPO,		//-- 05 GRUPO
				SB1.B1_DESC DESCR,		//-- 06 DESCR
				D3_EMISSAO,				//-- 07 DATA
				D3_TM,					//-- 08 TES
				D3_CF,					//-- 09 CF
				D3_NUMSEQ,				//-- 10 SEQUENCIA
				D3_DOC,					//-- 11 DOCUMENTO
				' ',					//-- 12 SERIE
				D3_QUANT,				//-- 13 QUANTIDADE
				D3_QTSEGUM,				//-- 14 QUANT2UM
				D3_LOCAL,				//-- 15 ARMAZEM
				D3_OP,					//-- 16 OP
				' ',					//-- 17 FORNECEDOR
				' ',					//-- 18 LOJA
				' ',					//-- 19 TIPO NF
				%Exp:cSelectD3%			//-- 20 CUSTO / 21 B1_CODITE	
				SD3.R_E_C_N_O_ SD3RECNO //-- 22 RECNO

		FROM %table:SB1% SB1,%table:SD3% SD3
	
		WHERE	SB1.B1_COD     =  SD3.D3_COD 		AND SD3.D3_FILIAL  =  %xFilial:SD3%		AND
				SD3.D3_EMISSAO >= %Exp:mv_par09%	AND	SD3.D3_EMISSAO <= %Exp:mv_par10%	AND
				(SD3.D3_CF = 'RE3'	OR	SD3.D3_CF = 'DE3')									AND
				SD3.%NotDel%						AND SB1.B1_FILIAL  =  %xFilial:SB1%		AND
				SB1.B1_TIPO    >= %Exp:mv_par05%	AND SB1.B1_TIPO    <= %Exp:mv_par06%	AND
				SB1.B1_GRUPO   >= %Exp:mv_par07%	AND SB1.B1_GRUPO   <= %Exp:mv_par08%	AND
				SB1.%NotDel%
				%Exp:cWhereD3%						AND %Exp:cWhereB2%
	UNION
	
	SELECT 	'SB2' ARQ,				//-- 01 ARQ
			SB1.B1_COD PRODUTO,		//-- 02 PRODUTO
			SB1.B1_TIPO TIPO,		//-- 03 TIPO
			SB1.B1_UM,				//-- 04 UM
			SB1.B1_GRUPO GRUPO,		//-- 05 GRUPO
			SB1.B1_DESC DESCR,		//-- 06 DESCR
			' ',					//-- 07 DATA
			' ',					//-- 08 TES
			' ',					//-- 09 CF
			' ',					//-- 10 SEQUENCIA	
			' ',					//-- 11 DOCUMENTO
			' ',					//-- 12 SERIE
			0,						//-- 13 QUANTIDADE
			0,						//-- 14 QUANT2UM
			B2_LOCAL,				//-- 15 ARMAZEM
			' ',					//-- 16 OP
			' ',					//-- 17 FORNECEDOR
			' ',					//-- 18 LOJA
			' ',					//-- 19 TIPO NF
			0						//-- 20 CUSTO 
			%Exp:cSelectB2%			//-- 21 B1_CODITE	
			0						//-- 22 RECNO

	FROM %table:SB1% SB1,%table:SB2% SB2

	WHERE SB1.B1_COD    = SB2.B2_COD		AND	SB2.B2_FILIAL  =  %xFilial:SB2%		AND
		  SB2.B2_LOCAL  >= %Exp:mv_par01%  AND 	SB2.B2_LOCAL   <= %Exp:mv_par02%	AND
		  SB2.%NotDel%						AND	SB1.B1_FILIAL  =  %xFilial:SB1% 	AND
		  SB1.B1_TIPO   >= %Exp:mv_par05%	AND SB1.B1_TIPO    <= %Exp:mv_par06%	AND
		  SB1.B1_GRUPO  >= %Exp:mv_par07%	AND	SB1.B1_GRUPO   <= %Exp:mv_par08%	AND
		  SB1.%NotDel%						AND %Exp:cWhereB2%	

	ORDER BY %Exp:cOrderBy%

EndSql 

oLinha:EndQuery()

dbSelectArea(cAliasTop)
oReport:SetMeter(nRegs)
dbGoTop()

oProduto:Init(.F.)
oLinha:Init()
Do While !oReport:Cancel() .And. !(cAliasTop)->(Eof())

	oReport:IncMeter()

	cAnt := (cAliasTop)->(If(nOrdem==1,"TIPO","GRUPO"))
	cAnt := (cAliasTop)->(If(nOrdem==1,"TIPO","GRUPO"))
	cVar := (cAliasTop)->(If(nOrdem==1, TIPO , GRUPO ))
	nTvIniAlm := nTvCompra := nTvDevVen := nTvReqSOP := nTvReqCOP := 0
	nTvRE3DE3 := nTvIniPrc := nTvRE2DE2 := nTvFimPrc := nTvRE4DE4 := 0
	nTvProduc := nTvTransf := nTvVendas := nTvFimAlm := 0

	nTqQtdIni := nTqCompra := nTqDevVen := nTqReqSOP := nTqReqCOP := 0
	nTqRE3DE3 := nTqIniPrc := nTqRE2DE2 := nTqFimPrc := nTqRE4DE4 := 0
	nTqProduc := nTqTransf := nTqVendas := nTqQtdFim := 0
	nTqEntrad := nTvEntrad := nTqSaidas := nTvSaidas := 0

	Do While !oReport:Cancel() .And. !(cAliasTop)->(Eof()) .And. (cAliasTop)->(&(cAnt)) == cVar

		oReport:IncMeter()

		nAqIniAlm := nAqCompra := nAqDevVen := nAqReqSOP := nAqReqCOP := 0
		nAqRE3DE3 := nAqIniPrc := nAqRE2DE2 := nAqFimPrc := nAqRE4DE4 := 0
		nAqProduc := nAqTransf := nAqVendas := nAqFimAlm := 0

		nAvIniAlm := nAvCompra := nAvDevVen := nAvReqSOP := nAvReqCOP := 0
		nAvRE3DE3 := nAvIniPrc := nAvRE2DE2 := nAvFimPrc := nAvRE4DE4 := 0
		nAvProduc := nAvTransf := nAvVendas := nAvFimAlm := 0

		nAqEntrad := nAvEntrad := nAqSaidas := nAvSaidas := 0

		cB1_COD  := (cAliasTop)->PRODUTO

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro escolhido                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilUser)
		    SB1->(MsSeek( xFilial("SB1") + cB1_COD ))
		    If !SB1->(&(cFilUser))
		       dbSkip()
	    	   Loop
	    	EndIf   
		EndIf

		oProduto:Cell('B1_TIPO'	 	):SetValue((cAliasTop)->TIPO)
		oProduto:Cell('B1_GRUPO' 	):SetValue((cAliasTop)->GRUPO)
		oProduto:Cell('B1_UM'    	):SetValue((cAliasTop)->UM)
		If lVeic
			oProduto:Cell('B1_CODITE'	):SetValue((cAliasTop)->CODITE)
		EndIf
		oProduto:Cell('B1_COD'   	):SetValue(cB1_COD)
		oProduto:Cell('B1_DESC'		):SetValue((cAliasTop)->DESCR)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pega o saldo final e inicial dos almoxarifados               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSB2)
		dbSetOrder(1)
		dbSeek(xSB2 + cB1_COD)
		While !oReport:Cancel() .And. !(cAliasSB2)->(Eof()) .And. ((cAliasSB2)->B2_COD == cB1_COD) .And. ((cAliasSB2)->B2_FILIAL == xSB2)

			oReport:IncMeter()

			dbSelectArea(cAliasSB2)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Nao permite listar os produtos com Armazem em Processo       |
			//| caso a variavel lLocProc nao esteja ativa                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !lLocProc
				If B2_LOCAL == cLocProc
					dbSkip()
					Loop
				EndIf
			EndIF

			If B2_LOCAL < mv_par01 .Or. B2_LOCAL > mv_par02
				dbSkip()
				Loop
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Totaliza o saldo final ou atual de cada almoxarifado         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If	mv_par12 == 1
				nAqFimAlm += B2_QATU
				nAvFimAlm +=&(Eval(bBloco,"B2_VATU",mv_par11))
			Elseif mv_par12 == 2
				nAqFimAlm += B2_QFIM
				nAvFimAlm +=&(Eval(bBloco,"B2_VFIM",mv_par11))
			Else
				aSaldoFim := CalcEst((cAliasSB2)->B2_COD,(cAliasSB2)->B2_LOCAL,mv_par10+1)
				nAqFimAlm += aSaldoFim[1]
				nAvFimAlm += aSaldoFim[1+mv_par11]
			EndIf

			aSaldoIni := CalcEst((cAliasSB2)->B2_COD,(cAliasSB2)->B2_LOCAL,mv_par09)
			nAqIniAlm += aSaldoIni[1]

			nVUnit    := aSaldoIni[mv_par11+1]/If(QtdComp(nAqIniAlm)>QtdComp(0),nAqIniAlm,1)
			nAvIniAlm += If(QtdComp(nAqIniAlm)>QtdComp(0),nAqIniAlm,1) * nVUnit
			dbSelectArea(cAliasSB2)
			dbSkip()

		EndDo

		If nAqIniAlm != 0 .Or. nAvIniAlm != 0 .Or. nAqFimAlm != 0 .Or. nAvFimAlm != 0
			lPassou := .T.
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pega o saldo em processo (B2_LOCAL = cLocProc)               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aSaldoIni := CalcEst(cB1_COD,cLocProc,mv_par09)
		nAqIniPrc += aSaldoIni[1]
		nAvIniPrc += aSaldoIni[mv_par11+1]

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pega o saldo final em processo (B2_LOCAL = cLocProc)         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aSldFimPrc := SldFimPrc(cB1_COD,cLocProc)
		nAqFimPrc  := aSldFimPrc[1]
		nAvFimPrc  += aSldFimPrc[2]

		If nAqIniPrc != 0 .Or. nAvIniPrc != 0 .Or. nAqFimPrc != 0 .Or. nAvFimPrc != 0
			lPassou := .T.
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ SB2 - Verifica Produtos Sem Movimento						 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasTop)
		Do While !oReport:Cancel() .And. !(cAliasTop)->(Eof()) .And. ( (cAliasTop)->PRODUTO == cB1_COD) .And. (UPPER(Alltrim((cAliasTop)->ARQ)) == "SB2")
			oReport:IncMeter()
			dbSkip()
		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ SD1 - Verifica as Entradas                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasTop)

		Do While !oReport:Cancel() .And. !(cAliasTop)->(Eof())	.And. ((cAliasTop)->PRODUTO == cB1_COD ) .And. (UPPER(Alltrim((cAliasTop)->ARQ)) == "SD1")

			oReport:IncMeter()

			SF4->(MsSeek(xSF4 + (cAliasTop)->TES))

			If SF4->F4_ESTOQUE == "S"

				nCusto := (cAliasTop)->CUSTO

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifica o ponto de entrada para considerar Transferencia ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				lRetPE := If(lR330Trans .And. ValType(lRetPE := ExecBlock("R330TRANS",.F.,.F.,{ (cAliasTop)->CF }) ) =='L', lRetPE, .F.)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Separa as transferencias das compras                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lRetPE .Or. ( (;
						( Len( allTrim( (cAliasTop)->CF) ) == 3 );
						.And.;
						(SubStr( allTrim( (cAliasTop)->CF),1,3)$"121/122/126/192/221/222/226/292");
					);
					.Or.;
					(;
						( Len( allTrim( (cAliasTop)->CF) ) > 3 ) ;
						.And.;
						(SubStr( allTrim( (cAliasTop)->CF ),1,4)$"1151/1152/1552/2151/2152/2552");
					) )
					nAqTransf += (cAliasTop)->QUANTIDADE
					nAvTransf += nCusto
				ElseIf (cAliasTop)->TIPONF == "D"
					nAqDevVen += (cAliasTop)->QUANTIDADE
					nAvDevVen += nCusto
				ElseIf SF4->F4_PODER3 $ "RD" .And. mv_par13 == 1
					nAqEntrad += (cAliasTop)->QUANTIDADE
					nAvEntrad += nCusto
				Else
					nAqCompra += (cAliasTop)->QUANTIDADE
					nAvCompra += nCusto
				EndIf
				lPassou := .T.
			EndIf
				
			dbSelectArea(cAliasTop)
			dbSkip()
			
		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ SD2 - Verifica as Saidas                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasTop)

		Do While !oReport:Cancel() .And. !(cAliasTop)->(Eof()) .And. ( (cAliasTop)->PRODUTO == cB1_COD ) 	.And. ( UPPER(Alltrim((cAliasTop)->ARQ)) == "SD2" )

			oReport:IncMeter()

			SF4->(MsSeek(xSF4 + (cAliasTop)->TES))

			If SF4->F4_ESTOQUE == "S"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifica o ponto de entrada para considerar Transferencia ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				lRetPE := If(lR330Trans .And. ValType(lRetPE := ExecBlock("R330TRANS",.F.,.F.,{ (cAliasTop)->CF }) ) =='L', lRetPE, .F.)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Separa as transferencias das vendas                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lRetPE .Or. ( (;
						( Len(allTrim((cAliasTop)->CF)) == 3);
						.And.;
						(SubStr(allTrim((cAliasTop)->CF),1,3)$"521/522/526/592/621/622/626/692");
					);
					.Or.;
					(;
						(Len(allTrim((cAliasTop)->CF)) >3);
						.And.;
						(SubStr(allTrim((cAliasTop)->CF),1,4)$"5151/5152/5156/5552/6151/6152/6156/6552");
					) )

					nAqTransf -= (cAliasTop)->QUANTIDADE
					nAvTransf -= (cAliasTop)->CUSTO
				ElseIf (cAliasTop)->TIPONF == "D"
					nAqCompra -= (cAliasTop)->QUANTIDADE
					nAvCompra -= (cAliasTop)->CUSTO
				ElseIf SF4->F4_PODER3 $ "RD" .And. mv_par14 == 1
					nAqSaidas += (cAliasTop)->QUANTIDADE
					nAvSaidas += (cAliasTop)->CUSTO
				Else
					nAqVendas += (cAliasTop)->QUANTIDADE
					nAvVendas += (cAliasTop)->CUSTO
				EndIf
				lPassou := .T.
			EndIf

			dbSelectArea(cAliasTop)
			dbSkip()

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ SD3 -  Verifica as Movimentacoes Internas                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasTop)

		Do While !oReport:Cancel() .And. !(cAliasTop)->(Eof())	.And. ((cAliasTop)->PRODUTO == cB1_COD) .And. ((upper(Alltrim((cAliasTop)->ARQ)) == "SD3") .OR. (upper(Alltrim((cAliasTop)->ARQ)) == "SD3S"))

			oReport:IncMeter()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina materiais requisitados para consumo proprio         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( (allTrim( (cAliasTop)->CF )  $ "RE0/DE0" ) .And. Empty( (cAliasTop)->OP ));
				.Or. ((allTrim( (cAliasTop)->CF ) $"RE6/DE6/DEA/REA" ) .And. Empty( (cAliasTop)->OP )) 

				If (cAliasTop)->TES <= "500"
					nAqReqSOP += (cAliasTop)->QUANTIDADE
					nAvReqSOP += (cAliasTop)->CUSTO
				Else
					nAqReqSOP -= (cAliasTop)->QUANTIDADE
					nAvReqSOP -= (cAliasTop)->CUSTO
				EndIf
				lPassou := .T.
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina materiais diretos utilizados em ordens de producao  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If	(;
					( allTrim( (cAliasTop)->CF ) $"RE0/DE0" );
					.And.;
					( !Empty( (cAliasTop)->OP ) );
				);
				.Or.;
				( allTrim( (cAliasTop)->CF ) $"RE1/DE1/RE5/DE5" );
				.Or.;
				(;
					( allTrim( (cAliasTop)->CF ) $ "RE6/DE6/DEA/REA" ); 
					.And.;
					( !Empty( (cAliasTop)->OP ) );
				)

				If (cAliasTop)->TES <= "500"
					nAqReqCOP += (cAliasTop)->QUANTIDADE
					nAvReqCOP += (cAliasTop)->CUSTO
				Else
					nAqReqCOP -= (cAliasTop)->QUANTIDADE
					nAvReqCOP -= (cAliasTop)->CUSTO
				EndIf
				lPassou := .T.
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina materiais indiretos enviados para o processo        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If allTrim((cAliasTop)->CF)$"RE3/DE3"
					If !(cAliasTop)->ARQ == "SD3S"
						If (cAliasTop)->TES <= "500"
							nAqRE3DE3 += (cAliasTop)->QUANTIDADE
							nAvRE3DE3 += (cAliasTop)->CUSTO
						Else
							nAqRE3DE3 -= (cAliasTop)->QUANTIDADE
							nAvRE3DE3 -= (cAliasTop)->CUSTO
						EndIf
					Else
						If lLocProc
							If (cAliasTop)->TES <= "500"
								nAqRE3DE3 -= (cAliasTop)->QUANTIDADE
								nAvRE3DE3 -= (cAliasTop)->CUSTO	
							Else
								nAqRE3DE3 += (cAliasTop)->QUANTIDADE
								nAvRE3DE3 += (cAliasTop)->CUSTO		
							EndIf
						EndIf		
					EndIf	
					lPassou := .T.
				EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina materiais indiretos apropriados `a producao         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If allTrim((cAliasTop)->CF)$"RE2/DE2"
				If (cAliasTop)->TES <= "500"
					nAqRE2DE2 += (cAliasTop)->QUANTIDADE
					nAvRE2DE2 += (cAliasTop)->CUSTO
				Else
					nAqRE2DE2 -= (cAliasTop)->QUANTIDADE
					nAvRE2DE2 -= (cAliasTop)->CUSTO
				EndIf
				lPassou := .T.
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina as transferencias internas                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If allTrim((cAliasTop)->CF)$"RE4/DE4/RE7/DE7"
				If (cAliasTop)->TES <= "500"
					nAqRE4DE4 += (cAliasTop)->QUANTIDADE
					nAvRE4DE4 += (cAliasTop)->CUSTO
				Else
					nAqRE4DE4 -= (cAliasTop)->QUANTIDADE
					nAvRE4DE4 -= (cAliasTop)->CUSTO
				EndIf
				lPassou := .T.
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina as entradas de produtos importados                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If allTrim((cAliasTop)->CF)$"RE8/DE8"
				If (cAliasTop)->TES <= "500"
					nAqCompra += (cAliasTop)->QUANTIDADE
					nAvCompra += (cAliasTop)->CUSTO
				Else
					nAqCompra -= (cAliasTop)->QUANTIDADE
					nAvCompra -= (cAliasTop)->CUSTO
				EndIf
				lPassou := .T.
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina as producoes e subtrai os estornos                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If allTrim((cAliasTop)->CF)$"PR0/ER0/PR1/ER1"
				If (cAliasTop)->TES <= "500"
					nAqProduc += (cAliasTop)->QUANTIDADE
					nAvProduc += (cAliasTop)->CUSTO
				Else
					nAqProduc -= (cAliasTop)->QUANTIDADE
					nAvProduc -= (cAliasTop)->CUSTO
				EndIf
				lPassou := .T.
			EndIf

			dbSelectArea(cAliasTop)
			dbSkip()

		EndDo

		dbSelectArea(cAliasTop)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Rotina de Impressao                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lPassou

			oProduto:Cell('B1_TIPO'	 	):Show()
			oProduto:Cell('B1_GRUPO' 	):Show()
			oProduto:Cell('B1_UM'    	):Show()
			oProduto:Cell('B1_COD'   	):Show()
			oProduto:Cell('B1_CODITE'	):Show()
			oProduto:Cell('B1_DESC'		):Show()

			//-- Quantidade Inicial
			oProduto:Cell('txtQuant'):SetValue(STR0044)
			oProduto:Cell('nQuant'  ):SetPicture(cPictQIni)
			oProduto:Cell('nQuant'  ):SetValue(nAqIniAlm)

			//-- Valor Inicial
			oProduto:Cell('txtValor1'):SetValue(STR0045)
			oProduto:Cell('nValor01' ):SetPicture(cPictVIni)
			oProduto:Cell('nValor01' ):SetValue(nAvIniAlm)

			//-- Valor Inicial Medio
			oProduto:Cell('txtValor2'):SetValue(STR0046)
			oProduto:Cell('nValor02' ):SetPicture(cPictVIni)
			oProduto:Cell('nValor02' ):SetValue(nAvIniAlm/IIf(nAqIniAlm==0,1,nAqIniAlm))

                oProduto:PrintLine()
                                                         
			//-- Ajusta Picture da linha de quantidades
			oLinha:Cell('Compra'):SetPicture(cPictQtD1)
			oLinha:Cell('DevVen'):SetPicture(cPictQtD1)
			oLinha:Cell('ReqSOP'):SetPicture(cPictQtD3)
			oLinha:Cell('ReqCOP'):SetPicture(cPictQtD3)
			oLinha:Cell('RE3DE3'):SetPicture(cPictQtD3)
			oLinha:Cell('IniPrc'):SetPicture(cPictQfB2)
			oLinha:Cell('RE2DE2'):SetPicture(cPictQtD3)
			oLinha:Cell('FimPrc'):SetPicture(cPictQaB2)
			oLinha:Cell('RE4DE4'):SetPicture(cPictQtD3)
			oLinha:Cell('Produc'):SetPicture(cPictQtD3)
			oLinha:Cell('Transf'):SetPicture(cPictQtD2)
			oLinha:Cell('Vendas'):SetPicture(cPictQtD2)
			oLinha:Cell('Entrad'):SetPicture(cPictQtD2)
			oLinha:Cell('Saidas'):SetPicture(cPictQtD2)

			//-- Impressao da linha de quantidade				
			oLinha:Cell('Compra'):SetValue(nAqCompra)
			oLinha:Cell('DevVen'):SetValue(nAqDevVen)
			oLinha:Cell('ReqSOP'):SetValue(nAqReqSOP)
			oLinha:Cell('ReqCOP'):SetValue(nAqReqCOP)
			oLinha:Cell('RE3DE3'):SetValue(nAqRE3DE3)
			oLinha:Cell('IniPrc'):SetValue(nAqIniPrc)
			oLinha:Cell('RE2DE2'):SetValue(nAqRE2DE2)
			oLinha:Cell('FimPrc'):SetValue(nAqFimPrc)
			oLinha:Cell('RE4DE4'):SetValue(nAqRE4DE4)
			oLinha:Cell('Produc'):SetValue(nAqProduc)
			oLinha:Cell('Transf'):SetValue(nAqTransf)
			oLinha:Cell('Vendas'):SetValue(nAqVendas)
			oLinha:Cell('Entrad'):SetValue(nAqEntrad)
			oLinha:Cell('Saidas'):SetValue(nAqSaidas)
                
                oLinha:PrintLine()

			//-- Ajusta Picture da linha de valores
			oLinha:Cell('Compra'):SetPicture(cPictCusD1)
			oLinha:Cell('DevVen'):SetPicture(cPictCusD1)
			oLinha:Cell('ReqSOP'):SetPicture(cPictCusD3)
			oLinha:Cell('ReqCOP'):SetPicture(cPictCusD3)
			oLinha:Cell('RE3DE3'):SetPicture(cPictCusD3)
			oLinha:Cell('IniPrc'):SetPicture(cPictVIni)
			oLinha:Cell('RE2DE2'):SetPicture(cPictCusD3)
			oLinha:Cell('FimPrc'):SetPicture(cPictFim)
			oLinha:Cell('RE4DE4'):SetPicture(cPictCusD3)
			oLinha:Cell('Produc'):SetPicture(cPictCusD3)
			oLinha:Cell('Transf'):SetPicture(cPictCusD2)
			oLinha:Cell('Vendas'):SetPicture(cPictCusD2)
			oLinha:Cell('Entrad'):SetPicture(cPictCusD2)
			oLinha:Cell('Saidas'):SetPicture(cPictCusD2)

                //-- Impressao da Linha de Valores
			oLinha:Cell('Compra'):SetValue(nAvCompra)
			oLinha:Cell('DevVen'):SetValue(nAvDevVen)
			oLinha:Cell('ReqSOP'):SetValue(nAvReqSOP)
			oLinha:Cell('ReqCOP'):SetValue(nAvReqCOP)
			oLinha:Cell('RE3DE3'):SetValue(nAvRE3DE3)
			oLinha:Cell('IniPrc'):SetValue(nAvIniPrc)
			oLinha:Cell('RE2DE2'):SetValue(nAvRE2DE2)
			oLinha:Cell('FimPrc'):SetValue(nAvFimPrc)
			oLinha:Cell('RE4DE4'):SetValue(nAvRE4DE4)
			oLinha:Cell('Produc'):SetValue(nAvProduc)
			oLinha:Cell('Transf'):SetValue(nAvTransf)
			oLinha:Cell('Vendas'):SetValue(nAvVendas)
			oLinha:Cell('Entrad'):SetValue(nAvEntrad)
			oLinha:Cell('Saidas'):SetValue(nAvSaidas)

                oLinha:PrintLine()

			oProduto:Cell('B1_TIPO'	 	):Hide()
			oProduto:Cell('B1_GRUPO' 	):Hide()
			oProduto:Cell('B1_UM'    	):Hide()
			oProduto:Cell('B1_COD'   	):Hide()
			oProduto:Cell('B1_CODITE'	):Hide()
			oProduto:Cell('B1_DESC'		):Hide()

                //-- Quantidade Final
			oProduto:Cell('txtQuant'):SetValue(STR0047)
			oProduto:Cell('nQuant'  ):SetPicture(cPictQaB2)
			oProduto:Cell('nQuant'  ):SetValue(nAqFimAlm)

			//-- Valor Final
			oProduto:Cell('txtValor1'):SetValue(STR0048)
			oProduto:Cell('nValor01' ):SetPicture(cPictFim)
			oProduto:Cell('nValor01' ):SetValue(nAvFimAlm)

			//-- Valor Final Medio
			oProduto:Cell('txtValor2'):SetValue(STR0049)
			oProduto:Cell('nValor02' ):SetPicture(cPictFim)
			oProduto:Cell('nValor02' ):SetValue(nAvFimAlm/IIf(nAqFimAlm==0,1,nAqFimAlm))

                oProduto:PrintLine()

                oReport:SkipLine() //-- Salta Linha

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Totalizacao de Quantidades                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nTqQtdIni += nAqIniAlm
			nTqCompra += nAqCompra
			nTqDevVen += nAqDevVen
			nTqReqSOP += nAqReqSOP
			nTqReqCOP += nAqReqCOP
			nTqRE3DE3 += nAqRE3DE3
			nTqIniPrc += nAqIniPrc
			nTqRE2DE2 += nAqRE2DE2
			nTqFimPrc += nAqFimPrc
			nTqRE4DE4 += nAqRE4DE4
			nTqProduc += nAqProduc
			nTqTransf += nAqTransf
			nTqVendas += nAqVendas
			nTqQtdFim += nAqFimAlm
			nTqEntrad += nAqEntrad
			nTqSaidas += nAqSaidas

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Totalizacao de Valores                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nTvIniAlm += nAvIniAlm
			nTvCompra += nAvCompra
			nTvDevVen += nAvDevVen
			nTvReqSOP += nAvReqSOP
			nTvReqCOP += nAvReqCOP
			nTvRE3DE3 += nAvRE3DE3
			nTvIniPrc += nAvIniPrc
			nTvRE2DE2 += nAvRE2DE2
			nTvFimPrc += nAvFimPrc
			nTvRE4DE4 += nAvRE4DE4
			nTvProduc += nAvProduc
			nTvTransf += nAvTransf
			nTvVendas += nAvVendas
			nTvFimAlm += nAvFimAlm
			nTvEntrad += nAvEntrad
			nTvSaidas += nAvSaidas
			lTeveItem := .T.
			lPassou   := .F.
			lTotal	  := .T.
		EndIf
	EndDo

	If lTeveItem

		If nOrdem == 1
			oReport:PrintText(STR0016 + cVar)		//"Total Tipo : "
		Else
			oReport:PrintText(STR0017 + cVar)		//"Total Grupo: "
		EndIf

		//-- Ajusta a picture da linha de quantidades
		oLinha:Cell('Compra'):SetPicture(cPictQtD1)
		oLinha:Cell('DevVen'):SetPicture(cPictQtD1)
		oLinha:Cell('ReqSOP'):SetPicture(cPictQtD3)
		oLinha:Cell('ReqCOP'):SetPicture(cPictQtD3)
		oLinha:Cell('RE3DE3'):SetPicture(cPictQtD3)
		oLinha:Cell('IniPrc'):SetPicture(cPictQfB2)
		oLinha:Cell('RE2DE2'):SetPicture(cPictQtD3)
		oLinha:Cell('FimPrc'):SetPicture(cPictQaB2)
		oLinha:Cell('RE4DE4'):SetPicture(cPictQtD3)
		oLinha:Cell('Produc'):SetPicture(cPictQtD3)
		oLinha:Cell('Transf'):SetPicture(cPictQtD2)
		oLinha:Cell('Vendas'):SetPicture(cPictQtD2)
		oLinha:Cell('Entrad'):SetPicture(cPictQtD2)
		oLinha:Cell('Saidas'):SetPicture(cPictQtD2)

		//-- Impressao da linha de quantidade (SubTotal)
		oLinha:Cell('Compra'):SetValue(nTqCompra)
		oLinha:Cell('DevVen'):SetValue(nTqDevVen)
		oLinha:Cell('ReqSOP'):SetValue(nTqReqSOP)
		oLinha:Cell('ReqCOP'):SetValue(nTqReqCOP)
		oLinha:Cell('RE3DE3'):SetValue(nTqRE3DE3)
		oLinha:Cell('IniPrc'):SetValue(nTqIniPrc)
		oLinha:Cell('RE2DE2'):SetValue(nTqRE2DE2)
		oLinha:Cell('FimPrc'):SetValue(nTqFimPrc)
		oLinha:Cell('RE4DE4'):SetValue(nTqRE4DE4)
		oLinha:Cell('Produc'):SetValue(nTqProduc)
		oLinha:Cell('Transf'):SetValue(nTqTransf)
		oLinha:Cell('Vendas'):SetValue(nTqVendas)
		oLinha:Cell('Entrad'):SetValue(nTqEntrad)
		oLinha:Cell('Saidas'):SetValue(nTqSaidas)
               
		oLinha:PrintLine()

		//-- Ajusta Picture da linha de valores
		oLinha:Cell('Compra'):SetPicture(cPictCusD1)
		oLinha:Cell('DevVen'):SetPicture(cPictCusD1)
		oLinha:Cell('ReqSOP'):SetPicture(cPictCusD3)
		oLinha:Cell('ReqCOP'):SetPicture(cPictCusD3)
		oLinha:Cell('RE3DE3'):SetPicture(cPictCusD3)
		oLinha:Cell('IniPrc'):SetPicture(cPictVIni)
		oLinha:Cell('RE2DE2'):SetPicture(cPictCusD3)
		oLinha:Cell('FimPrc'):SetPicture(cPictFim)
		oLinha:Cell('RE4DE4'):SetPicture(cPictCusD3)
		oLinha:Cell('Produc'):SetPicture(cPictCusD3)
		oLinha:Cell('Transf'):SetPicture(cPictCusD2)
		oLinha:Cell('Vendas'):SetPicture(cPictCusD2)
		oLinha:Cell('Entrad'):SetPicture(cPictCusD2)
		oLinha:Cell('Saidas'):SetPicture(cPictCusD2)

		//-- Impressao da Linha de Valores
		oLinha:Cell('Compra'):SetValue(nTvCompra)
		oLinha:Cell('DevVen'):SetValue(nTvDevVen)
		oLinha:Cell('ReqSOP'):SetValue(nTvReqSOP)
		oLinha:Cell('ReqCOP'):SetValue(nTvReqCOP)
		oLinha:Cell('RE3DE3'):SetValue(nTvRE3DE3)
		oLinha:Cell('IniPrc'):SetValue(nTvIniPrc)
		oLinha:Cell('RE2DE2'):SetValue(nTvRE2DE2)
		oLinha:Cell('FimPrc'):SetValue(nTvFimPrc)
		oLinha:Cell('RE4DE4'):SetValue(nTvRE4DE4)
		oLinha:Cell('Produc'):SetValue(nTvProduc)
		oLinha:Cell('Transf'):SetValue(nTvTransf)
		oLinha:Cell('Vendas'):SetValue(nTvVendas)
		oLinha:Cell('Entrad'):SetValue(nTvEntrad)
		oLinha:Cell('Saidas'):SetValue(nTvSaidas)

		oLinha:PrintLine()

		//-- Quantidade Inicial
		oReport:PrintText(Space(13),oReport:Row() )
		oReport:PrintText(STR0044,oReport:Row() )
		oReport:PrintText(Transform(nTqQtdIni,cPictQIni),oReport:Row() )
		
		//-- Valor Inicial
		oReport:PrintText(Space(1),oReport:Row() )
		oReport:PrintText(STR0045,oReport:Row() )
		oReport:PrintText(Transform(nTvIniAlm,cPictIni),oReport:Row() )
		
		//-- Valor Medio Inicial
		If mv_par15 == 1
			oReport:PrintText(Space(1),oReport:Row() )
			oReport:PrintText(STR0046,oReport:Row())
			oReport:PrintText(Transform(nTvIniAlm/IIf(nTqQtdIni==0,1,nTqQtdIni), cPictIni ),oReport:Row())
		EndIf
		
		//-- Quantidade Final
		oReport:PrintText(Space(1),oReport:Row() )
		oReport:PrintText(STR0047,oReport:Row())
		oReport:PrintText(Transform(nTqQtdFim,cPictQaB2),oReport:Row())
		
		//-- Valor Final
		oReport:PrintText(Space(1),oReport:Row() )
		oReport:PrintText(STR0048,oReport:Row())
		oReport:PrintText(Transform(nTvFimAlm,cPictFim)	, oReport:Row())
    		
    		//-- Valor Medio Final
		If mv_par15 == 1
			oReport:PrintText(Space(1),oReport:Row() )
			oReport:PrintText(STR0049,oReport:Row())
			oReport:PrintText(Transform(nTvFimAlm/IIf(nTqQtdFim==0,1,nTqQtdFim),cPictFim),oReport:Row())
		EndIf
            
       oReport:SkipLine() //-- Salta Linha  
       
		oReport:ThinLine() //-- Impressao de Linha Simples

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Total Geral das Quantidades                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nGqQtdIni += nTqQtdIni
		nGqCompra += nTqCompra
		nGqDevVen += nTqDevVen
		nGqReqSOP += nTqReqSOP
		nGqReqCOP += nTqReqCOP
		nGqRE3DE3 += nTqRE3DE3
		nGqIniPrc += nTqIniPrc
		nGqRE2DE2 += nTqRE2DE2
		nGqFimPrc += nTqFimPrc
		nGqRE4DE4 += nTqRE4DE4
		nGqProduc += nTqProduc
		nGqTransf += nTqTransf
		nGqVendas += nTqVendas
		nGqQtdFim += nTqQtdFim
		nGqEntrad += nTqEntrad
		nGqSaidas += nTqSaidas
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Total Geral dos Valores                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nGvIniAlm += nTvIniAlm
		nGvCompra += nTvCompra
		nGvDevVen += nTvDevVen
		nGvReqSOP += nTvReqSOP
		nGvReqCOP += nTvReqCOP
		nGvRE3DE3 += nTvRE3DE3
		nGvIniPrc += nTvIniPrc
		nGvRE2DE2 += nTvRE2DE2
		nGvFimPrc += nTvFimPrc
		nGvRE4DE4 += nTvRE4DE4
		nGvProduc += nTvProduc
		nGvTransf += nTvTransf
		nGvVendas += nTvVendas
		nGvFimAlm += nTvFimAlm
		nGvEntrad += nTvEntrad
		nGvSaidas += nTvSaidas
		lTeveItem  := .F.
	EndIf
	dbSelectArea(cAliasTop)
EndDo

If lTotal
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Total Geral                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:PrintText(STR0018)	//"TOTAL GERAL : "
	
	//-- Ajusta a picture da linha de quantidades
	oLinha:Cell('Compra'):SetPicture(cPictQtD1)
	oLinha:Cell('DevVen'):SetPicture(cPictQtD1)
	oLinha:Cell('ReqSOP'):SetPicture(cPictQtD3)
	oLinha:Cell('ReqCOP'):SetPicture(cPictQtD3)
	oLinha:Cell('RE3DE3'):SetPicture(cPictQtD3)
	oLinha:Cell('IniPrc'):SetPicture(cPictQfB2)
	oLinha:Cell('RE2DE2'):SetPicture(cPictQtD3)
	oLinha:Cell('FimPrc'):SetPicture(cPictQaB2)
	oLinha:Cell('RE4DE4'):SetPicture(cPictQtD3)
	oLinha:Cell('Produc'):SetPicture(cPictQtD3)
	oLinha:Cell('Transf'):SetPicture(cPictQtD2)
	oLinha:Cell('Vendas'):SetPicture(cPictQtD2)
	oLinha:Cell('Entrad'):SetPicture(cPictQtD2)
	oLinha:Cell('Saidas'):SetPicture(cPictQtD2)
	
	//-- Impressao da linha de quantidade (SubTotal)
	oLinha:Cell('Compra'):SetValue(nGqCompra)
	oLinha:Cell('DevVen'):SetValue(nGqDevVen)
	oLinha:Cell('ReqSOP'):SetValue(nGqReqSOP)
	oLinha:Cell('ReqCOP'):SetValue(nGqReqCOP)
	oLinha:Cell('RE3DE3'):SetValue(nGqRE3DE3)
	oLinha:Cell('IniPrc'):SetValue(nGqIniPrc)
	oLinha:Cell('RE2DE2'):SetValue(nGqRE2DE2)
	oLinha:Cell('FimPrc'):SetValue(nGqFimPrc)
	oLinha:Cell('RE4DE4'):SetValue(nGqRE4DE4)
	oLinha:Cell('Produc'):SetValue(nGqProduc)
	oLinha:Cell('Transf'):SetValue(nGqTransf)
	oLinha:Cell('Vendas'):SetValue(nGqVendas)
	oLinha:Cell('Entrad'):SetValue(nGqEntrad)
	oLinha:Cell('Saidas'):SetValue(nGqSaidas)
	
	oLinha:PrintLine()
	
	//-- Ajusta Picture da linha de valores
	oLinha:Cell('Compra'):SetPicture(cPictCusD1)
	oLinha:Cell('DevVen'):SetPicture(cPictCusD1)
	oLinha:Cell('ReqSOP'):SetPicture(cPictCusD3)
	oLinha:Cell('ReqCOP'):SetPicture(cPictCusD3)
	oLinha:Cell('RE3DE3'):SetPicture(cPictCusD3)
	oLinha:Cell('IniPrc'):SetPicture(cPictVIni)
	oLinha:Cell('RE2DE2'):SetPicture(cPictCusD3)
	oLinha:Cell('FimPrc'):SetPicture(cPictFim)
	oLinha:Cell('RE4DE4'):SetPicture(cPictCusD3)
	oLinha:Cell('Produc'):SetPicture(cPictCusD3)
	oLinha:Cell('Transf'):SetPicture(cPictCusD2)
	oLinha:Cell('Vendas'):SetPicture(cPictCusD2)
	oLinha:Cell('Entrad'):SetPicture(cPictCusD2)
	oLinha:Cell('Saidas'):SetPicture(cPictCusD2)
	
	//-- Impressao da Linha de Valores
	oLinha:Cell('Compra'):SetValue(nGvCompra)
	oLinha:Cell('DevVen'):SetValue(nGvDevVen)
	oLinha:Cell('ReqSOP'):SetValue(nGvReqSOP)
	oLinha:Cell('ReqCOP'):SetValue(nGvReqCOP)
	oLinha:Cell('RE3DE3'):SetValue(nGvRE3DE3)
	oLinha:Cell('IniPrc'):SetValue(nGvIniPrc)
	oLinha:Cell('RE2DE2'):SetValue(nGvRE2DE2)
	oLinha:Cell('FimPrc'):SetValue(nGvFimPrc)
	oLinha:Cell('RE4DE4'):SetValue(nGvRE4DE4)
	oLinha:Cell('Produc'):SetValue(nGvProduc)
	oLinha:Cell('Transf'):SetValue(nGvTransf)
	oLinha:Cell('Vendas'):SetValue(nGvVendas)
	oLinha:Cell('Entrad'):SetValue(nGvEntrad)
	oLinha:Cell('Saidas'):SetValue(nGvSaidas)
	
	oLinha:PrintLine()
	
	//-- Quantidade Inicial
	oReport:PrintText(Space(13),oReport:Row() )
	oReport:PrintText(STR0044,oReport:Row() )
	oReport:PrintText(Transform(nGqQtdIni,cPictQIni),oReport:Row() )
				
	//-- Valor Inicial
	oReport:PrintText(Space(1),oReport:Row() )
	oReport:PrintText(STR0045,oReport:Row() )
	oReport:PrintText(Transform(nGvIniAlm,cPictIni),oReport:Row() )
				
	//-- Valor Medio Inicial
	If mv_par15 == 1
		oReport:PrintText(Space(1),oReport:Row() )
		oReport:PrintText(STR0046,oReport:Row())
		oReport:PrintText(Transform(nGvIniAlm/IIf(nGqQtdIni==0,1,nGqQtdIni), cPictIni ),oReport:Row())
	EndIf
				
	//-- Quantidade Final
	oReport:PrintText(Space(1),oReport:Row() )
	oReport:PrintText(STR0047,oReport:Row())
	oReport:PrintText(Transform(nGqQtdFim,cPictQaB2),oReport:Row())
				
	//-- Valor Final
	oReport:PrintText(Space(1),oReport:Row() )
	oReport:PrintText(STR0048,oReport:Row())
	oReport:PrintText(Transform(nGvFimAlm,cPictFim)	,oReport:Row())
	    		
	//-- Valor Medio Final
	If mv_par15 == 1
		oReport:PrintText(Space(1),oReport:Row() )
		oReport:PrintText(STR0049,oReport:Row())
		oReport:PrintText(Transform(nGvFimAlm/IIF(nGqQtdFim==0,1,nGqQtdFim),cPictFim),oReport:Row())
	EndIf
	            
	oReport:SkipLine() //-- Salta Linha  
	
	oReport:ThinLine() //-- Impressao de Linha Simples
	
EndIf

oLinha:Finish()
oProduto:Finish()
		
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SldFimPrc ³ Autor ³ Larson Zordan         ³ Data ³ 25.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pega o saldo final em processo                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR330			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SldFimPrc(cProduto,cLocProc)
Local aAreaAnt := GetArea()
Local bBloco   := { |nV,nX| Trim(nV)+Str(nX,1) }
Local aSldFim  := {}
Local nSldQtd  := 0
Local nSldVlr  := 0

dbSelectArea("SB2")
dbSetOrder(1)
If MsSeek( xFilial("SB2") + cProduto + cLocProc )
	If	mv_par12 == 1
		nSldQtd += B2_QATU
	Elseif mv_par12 == 2
		nSldQtd += B2_QFIM
	Else
		aSldFim := CalcEst(cProduto,cLocProc,mv_par10+1)
		nSldQtd += aSldFim[1]
	EndIf
	nSldVlr += If(mv_par12<3,&(Eval(bBloco,Iif(mv_par12 == 1,"B2_VATU","B2_VFIM"),mv_par11)),aSldFim[mv_par11+1])
EndIf

RestArea(aAreaAnt)
Return({nSldQtd,nSldVlr})
