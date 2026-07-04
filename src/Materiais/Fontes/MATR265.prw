/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR265.CH"
#INCLUDE "PROTHEUS.CH"

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё MATR265  Ё Autor Ё Felipe Nunes Toledo   Ё Data Ё 17/07/06 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Pick-List Enderecamento                                    Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
*/
User Function MATR265()
Local oReport


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁInterface de impressao                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oReport:= ReportDef()
oReport:PrintDialog()

Return NIL

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  ЁReportDef Ё Autor ЁFelipe Nunes Toledo    Ё Data Ё17/07/06  Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁA funcao estatica ReportDef devera ser criada para todos os Ё╠╠
╠╠Ё          Ёrelatorios que poderao ser agendados pelo usuario.          Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁNenhum                                                      Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       ЁMATR265                                                     Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function ReportDef()
Local oReport
Local oSection1, oSection2, oSection3, oSection4, oSection5, oSection6
Local cTitle    := OemToAnsi(STR0006) //"Pick-List Enderecamento"
Local cQryRel   := GetNextAlias()
Private cPerg   :="MTR265"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁCriacao do componente de impressao                                      Ё
//Ё                                                                        Ё
//ЁTReport():New                                                           Ё
//ЁExpC1 : Nome do relatorio                                               Ё
//ЁExpC2 : Titulo                                                          Ё
//ЁExpC3 : Pergunte                                                        Ё
//ЁExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  Ё
//ЁExpC5 : Descricao                                                       Ё
//Ё                                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oReport:= TReport():New("MATR265",cTitle,cPerg, {|oReport| ReportPrint(oReport,cQryRel)},OemToAnsi(STR0001)+" "+OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)) //##"Este relatorio tem o objetivo de facilitar a retirada de materiais"##"apos o Faturamento de uma NF ou a Criacao de uma OP caso consumam"##"materiais que utilizam o controle de Localizacao Fisica"
oReport:SetLandscape() //Define a orientacao de pagina do relatorio como paisagem.

// tratamento provisorio, pois as perguntas serao disponibilizadas somente na release 12.1.17 Agosto/2017.
MV_PAR14 := Space(SerieNfId("SD2",6,"D2_SERIE"))
MV_PAR15 := Replicate("Z",SerieNfId("SD2",6,"D2_SERIE"))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas (MTR265)                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01      Pick List   1 - NF  2 - OP                     Ё
//Ё mv_par02      De  Nota Fiscal Venda                          Ё
//Ё mv_par03      Ate Nota Fiscal Venda                          Ё
//Ё mv_par04      De  Data de Entrega                            Ё
//Ё mv_par05      Ate Data de Entrega                            Ё
//Ё mv_par06      De  Cliente                                    Ё
//Ё mv_par07      Ate Cliente                                    Ё
//Ё mv_par08      De  Ordem de Producao                          Ё
//Ё mv_par09      Ate Ordem de Producao                          Ё
//Ё mv_par10      Qtd p/ impressao 1 - Original 2 - Saldo        Ё
//Ё mv_par11      Considera OPs 1- Firmes 2- Previstas 3- Ambas  Ё
//Ё mv_par12      Moeda                                          Ё
//Ё mv_par13      Outras moedas                                  Ё
//Ё mv_par14      Serie De                                       Ё
//Ё mv_par15      Serie Ate                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(oReport:GetParam(),.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁCriacao das secoes utilizadas pelo relatorio                            Ё
//Ё                                                                        Ё
//ЁTRSection():New                                                         Ё
//ЁExpO1 : Objeto TReport que a secao pertence                             Ё
//ЁExpC2 : Descricao da seГao                                              Ё
//ЁExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   Ё
//Ё        sera considerada como principal para a seГЦo.                   Ё
//ЁExpA4 : Array com as Ordens do relatСrio                                Ё
//ЁExpL5 : Carrega campos do SX3 como celulas                              Ё
//Ё        Default : False                                                 Ё
//ЁExpL6 : Carrega ordens do Sindex                                        Ё
//Ё        Default : False                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё oSection1 (Nota Fiscal de Venda)                            Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSection1 := TRSection():New(oReport,STR0033,{"SD2","SF2","SA4"},/*Ordem*/) // "Cabecalhos dos documentos de Saida"
oSection1:SetLineStyle()

TRCell():New(oSection1,'A2_COD'    ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'A2_LOJA'   ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'A2_NOME'   ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'A2_MUN'    ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'A2_EST'    ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'D2_DOC'    ,'SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,SerieNfId("SD2",3,"D2_SERIE"),'SD2',SerieNfId("SD2",7,"D2_SERIE"),/*Picture*/,SerieNfId("SD2",6,"D2_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'D2_PEDIDO' ,'SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'A4_NOME'   ,'SA4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'F2_VOLUME1','SF2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'F2_ESPECI1','SF2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'F2_PLIQUI' ,'SF2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'F2_PBRUTO' ,'SF2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection1:Cell('A2_COD'    ):SetCellBreak()
oSection1:Cell('A2_LOJA'   ):SetCellBreak()
oSection1:Cell('A2_NOME'   ):SetCellBreak()
oSection1:Cell('A2_MUN'    ):SetCellBreak()
oSection1:Cell('A2_EST'    ):SetCellBreak()
oSection1:Cell('D2_DOC'    ):SetCellBreak()
oSection1:Cell(SerieNfId("SD2",3,"D2_SERIE")):SetCellBreak()
oSection1:Cell('D2_PEDIDO' ):SetCellBreak()
oSection1:Cell('A4_NOME'   ):SetCellBreak()
oSection1:Cell('F2_VOLUME1'):SetCellBreak()
oSection1:Cell('F2_ESPECI1'):SetCellBreak()
oSection1:Cell('F2_PLIQUI' ):SetCellBreak()
oSection1:Cell('F2_PBRUTO' ):SetCellBreak()

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё oSection2 (Ordem de Producao)                               Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSection2 := TRSection():New(oReport,STR0034,{"SD4","SC2"},/*Ordem*/) //"Ordens de ProduГЦo"
oSection2:SetLineStyle()

TRCell():New(oSection2,'D4_OP'     ,'SD4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'C2_PRODUTO','SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'B1_DESC'   ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'C2_DATPRI' ,'SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'C2_DATPRF' ,'SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'C2_QUANT'  ,'SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'C2_OBS'    ,'SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection2:Cell('D4_OP'     ):SetCellBreak()
oSection2:Cell('C2_PRODUTO'):SetCellBreak()
oSection2:Cell('B1_DESC'   ):SetCellBreak()
oSection2:Cell('C2_DATPRI' ):SetCellBreak()
oSection2:Cell('C2_DATPRF' ):SetCellBreak()
oSection2:Cell('C2_QUANT'  ):SetCellBreak()
oSection2:Cell('C2_OBS'    ):SetCellBreak()

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё oSection3 (Remito)                                          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSection3 := TRSection():New(oReport,STR0035,{"SD2"},/*Ordem*/) //"Itens de documentos de saida"
oSection3:SetLineStyle()

TRCell():New(oSection3,'A2_COD'   ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'A2_LOJA'  ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'A2_NOME'  ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'A2_MUN'   ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'A2_EST'   ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'D2_DOC'   ,'SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,SerieNfId("SD2",3,"D2_SERIE"),'SD2',SerieNfId("SD2",7,"D2_SERIE"),/*Picture*/,SerieNfId("SD2",6,"D2_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'D2_PEDIDO','SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection3:Cell('A2_COD'   ):SetCellBreak()
oSection3:Cell('A2_LOJA'  ):SetCellBreak()
oSection3:Cell('A2_NOME'  ):SetCellBreak()
oSection3:Cell('A2_MUN'   ):SetCellBreak()
oSection3:Cell('A2_EST'   ):SetCellBreak()
oSection3:Cell('D2_DOC'   ):SetCellBreak()
oSection3:Cell(SerieNfId("SD2",3,"D2_SERIE")):SetCellBreak()
oSection3:Cell('D2_PEDIDO'):SetCellBreak()

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё oSection4 (Item Nota Fiscal de Saida)                       Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSection4 := TRSection():New(oSection1,STR0035,{"SD2","SB1","SDB"},/*Ordem*/) //"Itens de documentos de saida"
oSection4:SetHeaderPage()

TRCell():New(oSection4,'D2_COD'    ,'SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'B1_DESC'   ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'B1_UM'     ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'D2_LOTECTL','SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'D2_NUMLOTE','SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'DB_LOCALIZ','SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'DB_NUMSERI','SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'DB_QUANT'  ,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'D2_DTVALID','SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,'D2_POTENCI','SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё oSection5 (Item Ordem de Producao)                          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSection5 := TRSection():New(oSection2,STR0036,{"SD4","SB1","SDC"},/*Ordem*/) //"Empenhos"
oSection5:SetHeaderPage()

TRCell():New(oSection5,'D4_COD'    ,'SD4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'B1_DESC'   ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'B1_UM'     ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'D4_LOTECTL','SD4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'D4_NUMLOTE','SD4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'DC_LOCALIZ','SDC',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'DC_NUMSERI','SDC',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'D4_QUANT'  ,'SD4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'D4_DTVALID','SD4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,'D4_POTENCI','SD4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё oSection6 (Item Remito)                                     Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSection6 := TRSection():New(oSection3,STR0037,{"SD2","SB1","SDB"},/*Ordem*/) //"Movimentos por EndereГo"
oSection6:SetHeaderPage()

TRCell():New(oSection6,'D2_COD'    ,'SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,'B1_DESC'   ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,'B1_UM'     ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,'D2_LOTECTL','SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,'D2_NUMLOTE','SD2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,'DB_LOCALIZ','SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,'DB_NUMSERI','SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,'DB_QUANT'  ,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбдддддддбдддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  ЁReportPrint Ё Autor ЁFelipe Nunes Toledo  Ё Data Ё17/07/06  Ё╠╠
╠╠цддддддддддеддддддддддддадддддддадддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁA funcao estatica ReportPrint devera ser criada para todos  Ё╠╠
╠╠Ё          Ёos relatorios que poderao ser agendados pelo usuario.       Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁRetorno   ЁNenhum                                                      Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁExpO1: Objeto Report do Relatorio                           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       ЁMATR265                                                     Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function ReportPrint(oReport, cQryRel)
Local oSection1	:= oReport:Section(1)
Local oSection2	:= oReport:Section(2)
Local oSection3	:= oReport:Section(3)
Local oSection4	:= oReport:Section(1):Section(1)
Local oSection5	:= oReport:Section(2):Section(1)
Local oSection6	:= oReport:Section(3):Section(1)
Local lExistBlock := ExistBlock("MR265MAIL")
Local cIndex
Local cChaveDB	:= cChaveC9 := cChave := cChave2 := cDocAnt := cCompara := cTitulo:= ""
Local nValorNf	:= 0
Local aTam		:= TamSX3("D2_TOTAL")
Local aAreaSB1	:= SB1->(GetArea())
Local bBlock
Local cWhere01
Local nSldSD4	:= 0
Local cSelectD2	:= ""

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁTransforma parametros Range em expressao SQL                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MakeSqlExpr(oReport:GetParam())

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Condicao Where para filtrar OP's                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

cWhere01 := "%"
cWhere01  += "SC2.C2_NUM || SC2.C2_ITEM || SC2.C2_SEQUEN || SC2.C2_ITEMGRD = SD4.D4_OP
cWhere01 += "%"

cSelectD2:= "%"
cSelectD2+= Iif(SerieNfId("SD2",3,"D2_SERIE")<>"D2_SERIE","D2_SDOC,","")
cSelectD2+= "%"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁQuery do relatorio                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
    
If MV_PAR01 == 1           	

	BEGIN REPORT QUERY oSection1
		BeginSql Alias cQryRel

		SELECT D2_FILIAL, D2_DOC, D2_SERIE,%Exp:cSelectD2% D2_ITEM, D2_COD, D2_ITEMPV, D2_LOTECTL, D2_NUMLOTE, D2_PEDIDO, 
		       D2_TIPO, D2_DTVALID, D2_POTENCI, D2_TIPODOC, D2_CLIENTE, D2_LOJA, D2_TOTAL, D2_NUMSEQ, D2_LOCAL,
		       D2_QUANT, D2_REMITO, 
		       C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, C6_ENTREG,
		       F2_FILIAL,F2_DOC, F2_SERIE,F2_CLIENTE, F2_LOJA, F2_TIPO, F2_MOEDA, F2_VOLUME1, F2_ESPECI1, 
		       F2_PLIQUI, F2_PBRUTO, F2_TRANSP, F2_EMISSAO, F2_TXMOEDA,
		       B1_FILIAL, B1_COD, B1_DESC, B1_UM,
		       A4_FILIAL, A4_COD, A4_NOME
		FROM %table:SD2% SD2

		INNER JOIN %table:SC6% SC6 ON
		       SC6.C6_FILIAL = %xFilial:SC6% AND
		       SC6.C6_NUM = D2_PEDIDO AND
		       SC6.C6_ITEM = D2_ITEMPV AND
		       SC6.C6_ENTREG BETWEEN %Exp:mv_par04% AND %Exp:mv_par05% AND
		       SC6.%NotDel%
		LEFT JOIN %table:SF2% SF2 ON
		       SF2.F2_FILIAL = %xFilial:SF2% AND
		       SF2.F2_CLIENTE = D2_CLIENTE AND
		       SF2.F2_LOJA = D2_LOJA AND
		       SF2.F2_DOC = D2_DOC AND
		       SF2.F2_SERIE = D2_SERIE AND
		       SF2.%NotDel%
		LEFT JOIN %table:SB1% SB1 ON
		       SB1.B1_FILIAL = %xFilial:SB1% AND
		       SB1.B1_COD = D2_COD AND
		       SB1.%NotDel%
		LEFT JOIN %table:SA4% SA4 ON
		       SA4.A4_FILIAL = %xFilial:SA4% AND
		       SA4.A4_COD = F2_TRANSP AND
		       SA4.%NotDel%
		WHERE  D2_FILIAL = %xFilial:SD2%  AND
		       D2_DOC BETWEEN %Exp:mv_par02% AND %Exp:mv_par03% AND
		       D2_CLIENTE BETWEEN %Exp:mv_par06% AND %Exp:mv_par07% AND
		       D2_SERIE BETWEEN %Exp:mv_par14% AND %Exp:mv_par15% AND
		       SD2.%NotDel%
		ORDER BY D2_FILIAL, D2_DOC, D2_SERIE, D2_ITEM, D2_COD, D2_ITEMPV, D2_LOTECTL, D2_NUMLOTE		

		EndSql 
	END REPORT QUERY oSection1 
	
	oSection4:SetParentQuery() //Define a utilizacao da Query para a secao Filha   
    
ElseIf MV_PAR01 == 2
	
	BEGIN REPORT QUERY oSection2
		BeginSql Alias cQryRel

		SELECT SD4.D4_FILIAL, SD4.D4_COD, SD4.D4_OP, SD4.D4_LOTECTL, SD4.D4_NUMLOTE, SD4.D4_DTVALID, 
		       SD4.D4_POTENCI, SD4.D4_LOCAL, SD4.D4_TRT, SD4.D4_QUANT, SD4.D4_QTDEORI,
		       SC2.C2_FILIAL, SC2.C2_NUM, SC2.C2_ITEM, SC2.C2_SEQUEN, SC2.C2_ITEMGRD, SC2.C2_DATPRI,
		       SC2.C2_DATPRF, SC2.C2_PRODUTO, SC2.C2_QUANT, SC2.C2_OBS, SC2.C2_TPOP,
		       SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_DESC, SB1.B1_UM
		FROM   %table:SD4% SD4
		INNER JOIN %table:SC2% SC2 ON
		       SC2.C2_FILIAL = %xFilial:SC2% AND
		       SC2.C2_DATPRF BETWEEN %Exp:mv_par04% AND %Exp:mv_par05% AND
		       SC2.%NotDel%
		LEFT JOIN %table:SB1% SB1 ON
		       SB1.B1_FILIAL = %xFilial:SB1% AND
		       SB1.B1_COD = SD4.D4_COD AND
		       SB1.%NotDel%
		WHERE  SD4.D4_FILIAL = %xFilial:SD4% AND
		       SD4.D4_OP BETWEEN %Exp:mv_par08% AND %Exp:mv_par09% AND
		       %Exp:cWhere01% AND
		       SD4.%NotDel%
		ORDER BY
		     SC2.C2_FILIAL, SC2.C2_NUM, SC2.C2_ITEM, SC2.C2_SEQUEN, SC2.C2_ITEMGRD

		EndSql
	END REPORT QUERY oSection2
	
	oSection5:SetParentQuery() //Define a utilizacao da Query para a secao Filha
	  	    
ElseIf MV_PAR01 == 3

	BEGIN REPORT QUERY oSection3
		BeginSql Alias cQryRel

		SELECT D2_FILIAL, D2_DOC, D2_SERIE,%Exp:cSelectD2% D2_ITEM, D2_COD, D2_ITEMPV, D2_LOTECTL, D2_NUMLOTE, D2_PEDIDO,
		       D2_TIPO, D2_DTVALID, D2_POTENCI, D2_TIPODOC, D2_CLIENTE, D2_LOJA, D2_TOTAL, D2_NUMSEQ, D2_LOCAL,
		       D2_QUANT, D2_REMITO, 
		       B1_FILIAL, B1_COD, B1_DESC, B1_UM
		FROM   %table:SD2% SD2
		LEFT   
		JOIN   %table:SB1% SB1 ON
		       SB1.B1_FILIAL = %xFilial:SB1% AND
		       SB1.B1_COD = D2_COD AND
		       SB1.%NotDel%
		WHERE  D2_FILIAL = %xFilial:SD2% AND
		       D2_TIPODOC >= '50' AND
		       D2_DOC BETWEEN %Exp:mv_par02% AND %Exp:mv_par03% AND
		       D2_CLIENTE BETWEEN %Exp:mv_par06% AND %Exp:mv_par07% AND
		       D2_SERIE BETWEEN %Exp:mv_par14% AND %Exp:mv_par15% AND
			   SD2.%NotDel%
		ORDER BY D2_FILIAL, D2_DOC, D2_SERIE, D2_ITEM, D2_COD, D2_ITEMPV, D2_LOTECTL, D2_NUMLOTE					

		EndSql 
	END REPORT QUERY oSection3
	
	oSection6:SetParentQuery() //Define a utilizacao da Query para a secao Filha    
    
EndIf


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁInicio da impressao do fluxo do relatorio                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea(cQryRel)
If MV_PAR01 == 1 // Impressao Nota Fiscal de Venda

	//зддддддддддддддддддддддддддддддд©
	//ЁDefinindo o titulo do RelatorioЁ
	//юддддддддддддддддддддддддддддддды
	oReport:SetTitle(oReport:Title()+"    "+STR0008) //"Pick-List Enderecamento"##"(Nota Fiscal de Venda)"

	//зддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁDesabilitando secoes que nao seram utilizadasЁ
	//юддддддддддддддддддддддддддддддддддддддддддддды
	oSection2:Disable()
	oSection3:Disable()
	oSection5:Disable()
	oSection6:Disable()

	oReport:SetMeter( SD2->(LastRec()) )
	oSection1:Init()
	oSection4:Init()
	While !oReport:Cancel() .And. !(cQryRel)->(Eof())
		cQrySF2 := cQryRel
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica Moeda                                               Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If mv_par13==2  //nao imprimir notas com moeda diferente da escolhida
		   If iIf((cQryRel)->F2_MOEDA==0,1,(cQryRel)->F2_MOEDA)!=mv_par12
				dbselectarea(cQryRel)
				oReport:IncMeter()
				dbskip()
				loop
		   endif
		endif
		If (cQrySF2)->F2_TIPO $ "D╨B"
			dbSelectArea( "SA2" )
			dbSetOrder( 1 )
			dbSeek( xFilial("SA2") + (cQryRel)->D2_CLIENTE + (cQryRel)->D2_LOJA )
			oSection1:Cell('A2_COD' ):SetValue( SA2->A2_COD  )
			oSection1:Cell('A2_LOJA'):SetValue( SA2->A2_LOJA )
			oSection1:Cell('A2_NOME'):SetValue( SA2->A2_NOME ) 
			oSection1:Cell('A2_MUN' ):SetValue( SA2->A2_MUN  )
			oSection1:Cell('A2_EST' ):SetValue( SA2->A2_EST  )
		Else
			dbSelectArea( "SA1" )
			dbSetOrder( 1 )
			dbSeek( xFilial("SA1") + (cQryRel)->D2_CLIENTE + (cQryRel)->D2_LOJA)
			oSection1:Cell('A2_COD' ):SetValue( SA1->A1_COD  )
			oSection1:Cell('A2_LOJA'):SetValue( SA1->A1_LOJA )
			oSection1:Cell('A2_NOME'):SetValue( SA1->A1_NOME ) 
			oSection1:Cell('A2_MUN' ):SetValue( SA1->A1_MUN  )
			oSection1:Cell('A2_EST' ):SetValue( SA1->A1_EST  )
		EndIf
		oSection1:PrintLine() //-- Impressao da secao 1
		oReport:ThinLine()

		nValorNf := 0
		cDocAnt  := xFilial("SD2")+(cQryRel)->(D2_DOC+D2_SERIE)
		While !(cQryRel)->(Eof()) .And. (cQryRel)->(D2_FILIAL+D2_DOC+D2_SERIE) == cDocAnt 
			If Localiza( (cQryRel)->D2_COD )
				dbSelectArea( "SDB" )
				dbSetOrder( 1 )
				cChaveDB :=xFilial("SDB")+(cQryRel)->D2_COD+(cQryRel)->D2_LOCAL+(cQryRel)->D2_NUMSEQ+(cQryRel)->D2_DOC+(cQryRel)->D2_SERIE+(cQryRel)->D2_CLIENTE+(cQryRel)->D2_LOJA
				If dbSeek( cChaveDB )
					While !Eof() .And. cChaveDB == DB_FILIAL+DB_PRODUTO+DB_LOCAL+DB_NUMSEQ+DB_DOC+DB_SERIE+DB_CLIFOR+DB_LOJA
						If DB_ESTORNO == "S"
							dbSkip()
							Loop
						EndIf
						oSection4:Cell('DB_LOCALIZ'):SetValue( SDB->DB_LOCALIZ )
						oSection4:Cell('DB_NUMSERI'):SetValue( SDB->DB_NUMSERI )
						oSection4:Cell('DB_QUANT'  ):SetValue( SDB->DB_QUANT   )
						oReport:IncMeter()
						oSection4:PrintLine()
						dbSkip()
					EndDo
				Else
					dbSelectArea( "SC9" )
					dbSetOrder( 2 )
					cChaveC9 := xFilial( "SC9" ) + (cQryRel)->D2_CLIENTE + (cQryRel)->D2_LOJA + ;
					(cQryRel)->D2_PEDIDO + (cQryRel)->D2_ITEMPV
					dbSeek( cChaveC9 )
					While !Eof() .And. cChaveC9 == C9_FILIAL + C9_CLIENTE + C9_LOJA + C9_PEDIDO + C9_ITEM
						//здддддддддддддддддддддддддддддддддддддддддд©
						//Ё Verifica se a liberacao ja foi faturada  Ё
						//юдддддддддддддддддддддддддддддддддддддддддды
						If Rastro( (cQryRel)->D2_COD, "S" )
							bBlock  := { || C9_PRODUTO + C9_NUMLOTE + C9_NFISCAL + ;
							C9_SERIENF <> (cQryRel)->D2_COD + (cQryRel)->D2_NUMLOTE + (cQryRel)->D2_DOC +;
							(cQryRel)->D2_SERIE }
						ElseIf Rastro( SC9->C9_PRODUTO, "L" )
							bBlock  := { || C9_PRODUTO + C9_LOTECTL + C9_NFISCAL + C9_SERIENF <> (cQryRel)->D2_COD +;
							(cQryRel)->D2_LOTECTL + (cQryRel)->D2_DOC + (cQryRel)->D2_SERIE  }
						Else
							bBlock  := { || C9_PRODUTO + C9_NFISCAL + C9_SERIENF <> ;
							(cQryRel)->D2_COD + (cQryRel)->D2_DOC + (cQryRel)->D2_SERIE }
						EndIf
				
						If C9_BLEST <> "10" .Or. C9_BLCRED <> "10" .Or. Eval( bBlock )
							dbSkip()
							Loop
						EndIf
						dbSelectArea('SDC')
						dbSetOrder(1)
						If Rastro((cQryRel)->D2_COD, 'S')
							bBlock  := {|| SC9->C9_LOTECTL+SC9->C9_NUMLOTE == DC_LOTECTL+DC_NUMLOTE}
							cChave  := xFilial()+SC9->C9_PRODUTO+(cQryRel)->D2_LOCAL+'SC6'+SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_SEQUEN
							cChave2 := SC9->C9_LOTECTL+SC9->C9_NUMLOTE
						ElseIf Rastro(SC9->C9_PRODUTO, 'L')
							bBlock  := {|| SC9->C9_LOTECTL == DC_LOTECTL}
							cChave  := xFilial()+SC9->C9_PRODUTO+(cQryRel)->D2_LOCAL+'SC6'+SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_SEQUEN
							cChave2 := SC9->C9_LOTECTL
						Else
							bBlock  := {|| .T.}
							cChave  := xFilial()+SC9->C9_PRODUTO+(cQryRel)->D2_LOCAL+'SC6'+SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_SEQUEN
							cChave2 := ''
						EndIf
						//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Varre composicao do empenho                                  Ё
						//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						If dbSeek(cChave+cChave2, .F.)
							Do While !Eof() .And. cChave==DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_ORIGEM+DC_PEDIDO+DC_ITEM+DC_SEQ .And. Eval(bBlock)
								oSection4:Cell('DB_LOCALIZ'):SetValue( SDC->DC_LOCALIZ )
								oSection4:Cell('DB_NUMSERI'):SetValue( SDC->DC_NUMSERI )
								//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
								//ЁLista quantidade de acordo com o parametro selecionado        Ё
								//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
								SB8->(dbSeek(xFilial("SB8") + SDC->(DC_PRODUTO+DC_LOCAL+DTOS(SC9->C9_DTVALID)+DC_LOTECTL+DC_NUMLOTE)))
								If mv_par10 == 1
									oSection4:Cell('DB_QUANT'  ):SetValue( SDC->DC_QTDORIG )
								Else
									oSection4:Cell('DB_QUANT'  ):SetValue( SDC->DC_QUANT )
								EndIf
								oSection4:Cell('D2_DTVALID'):SetValue( SC9->C9_DTVALID )
								oSection4:Cell('D2_POTENCI'):SetValue( SB8->B8_POTENCI )
								dbSelectArea('SDC')
								dbSkip()
								oReport:IncMeter()
								oSection4:PrintLine() // Impressao da secao 4
							EndDo
						EndIf
						dbSelectArea('SC9')
						dbSkip()
					EndDo
				EndIf
			Else
				oSection4:Cell('DB_LOCALIZ'):SetValue( '' )
				oSection4:Cell('DB_NUMSERI'):SetValue( '' )
				oSection4:Cell('DB_QUANT'  ):SetValue( (cQryRel)->D2_QUANT )
				oReport:IncMeter()
				oSection4:PrintLine() // Impressao da secao 4
			EndIf
			//здддддддддддддддддддддддддддддддддддддд©
			//Ё Executa EXECBLOCK p/ envio de e-mail Ё
			//юдддддддддддддддддддддддддддддддддддддды
			If lExistBlock
				ExecBlock("MR265MAIL",.F.,.F.)
			EndIf
			nValorNf += xmoeda((cQryRel)->D2_TOTAL,(cQrySF2)->F2_MOEDA,mv_par12,(cQrySF2)->F2_EMISSAO,msdecimais(mv_par12)+1,(cQrySF2)->F2_TXMOEDA)
			
			(cQryRel)->(dbSkip())
		EndDo
		oReport:SkipLine()
		oReport:PrintText(STR0012+"  "+Str(nValorNf,aTam[1],aTam[2]))
		oReport:SkipLine()
		oReport:PrintText(STR0013)
		oReport:EndPage() //-- Salta Pagina
	EndDo

	oSection1:Finish()
	oSection4:Finish()
	(cQryRel)->(DbCloseArea()) 

ElseIf MV_PAR01 == 2 // Impressao Ordem de Producao

	//зддддддддддддддддддддддддддддддд©
	//ЁDefinindo o titulo do RelatorioЁ
	//юддддддддддддддддддддддддддддддды
	oReport:SetTitle(oReport:Title()+"    "+STR0009) //"Pick-List Enderecamento"##"(Ordem de Producao)"

	//зддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁDesabilitando secoes que nao seram utilizadasЁ
	//юддддддддддддддддддддддддддддддддддддддддддддды
	oSection1:Disable()
	oSection3:Disable()
	oSection4:Disable()
	oSection6:Disable()

	oReport:SetMeter( SD4->(LastRec()) )
	oSection2:Init()
	oSection5:Init()
	While !oReport:Cancel() .And. !(cQryRel)->(Eof())
		If !MtrAvalOp(mv_par11,"SC2",cQryRel)
			oReport:IncMeter()
			(cQryRel)->(dbSkip())
			Loop
		EndIf
		SB1->(DbSetOrder(1))
		SB1->(DbSeek(xFilial("SB1") + (cQryRel)->C2_PRODUTO))
		oSection2:Cell('B1_DESC'):SetValue( SB1->B1_DESC )
		oSection2:PrintLine() //-- Impressao da secao 2
		oReport:ThinLine()
		cOpAnt := (cQryRel)->D4_OP
		While !(cQryRel)->(Eof()) .And. (cQryRel)->(D4_FILIAL+D4_OP) == xFilial("SD4")+cOpAnt
			If Localiza((cQryRel)->D4_COD)
				dbSelectArea("SDC")
				dbSetOrder(2)
				cChave := ''
				If Rastro((cQryRel)->D4_COD)
					cChave:=xFilial("SDC")+(cQryRel)->(D4_COD+D4_LOCAL+D4_OP+D4_TRT+D4_LOTECTL+D4_NUMLOTE)
					cCompara:="DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_OP+DC_TRT+DC_LOTECTL+DC_NUMLOTE"
				Else
					cChave:=xFilial("SDC")+(cQryRel)->(D4_COD+D4_LOCAL+D4_OP+D4_TRT)
					cCompara:="DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_OP+DC_TRT"
				EndIf
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Varre composicao do empenho                                  Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If !Empty(cChave) .AND. dbSeek(cChave)
					nSldSD4 := If(mv_par10==1,(cQryRel)->D4_QTDEORI,(cQryRel)->D4_QUANT)
					Do While SDC->(!Eof()) .And. cChave == &(cCompara)
			
						oSection5:Cell('DC_LOCALIZ'):Setvalue( SDC->DC_LOCALIZ )
						oSection5:Cell('DC_NUMSERI'):Setvalue( SDC->DC_NUMSERI )

						//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//ЁLista quantidade de acordo com o parametro selecionado        Ё
						//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						If mv_par10 == 1
							oSection5:Cell('D4_QUANT'  ):Setvalue( SDC->DC_QTDORIG )
						Else
							oSection5:Cell('D4_QUANT'  ):Setvalue( SDC->DC_QUANT )
						EndIf

						oReport:IncMeter()
						oSection5:PrintLine() //-- Impressao da secao 4
						nSldSD4 -= If(mv_par10==1,SDC->DC_QTDORIG,SDC->DC_QUANT)
						SDC->(dbSkip())
					EndDo
				Else
					oSection5:Cell('DC_LOCALIZ'):Setvalue( '' )
					oSection5:Cell('DC_NUMSERI'):Setvalue( '' )
					If mv_par10 == 1
						oSection5:Cell('D4_QUANT'  ):Setvalue( (cQryRel)->D4_QTDEORI )
					Else
						oSection5:Cell('D4_QUANT'  ):Setvalue( (cQryRel)->D4_QUANT )
					EndIf
					oReport:IncMeter()
					oSection5:PrintLine() //-- Impressao da secao 4
				EndIf
			Else
				oSection5:Cell('DC_LOCALIZ'):Setvalue( '' )
				oSection5:Cell('DC_NUMSERI'):Setvalue( '' )
				If mv_par10 == 1
					oSection5:Cell('D4_QUANT'  ):Setvalue( (cQryRel)->D4_QTDEORI )
				Else
					oSection5:Cell('D4_QUANT'  ):Setvalue( (cQryRel)->D4_QUANT )
				EndIf
				oReport:IncMeter()
				oSection5:PrintLine() //-- Impressao da secao 4
			EndIf
			If nSldSD4 > 0 //Imprime linha para diferenca nao empenhada no SDC
				oSection5:Cell('DC_LOCALIZ'):Setvalue( '' )
				oSection5:Cell('DC_NUMSERI'):Setvalue( '' )
				oSection5:Cell('D4_QUANT'  ):Setvalue( nSldSD4 )
				oReport:IncMeter()
				oSection5:PrintLine() //-- Impressao da secao 4
				nSldSD4 := 0 //prepara para novo item
			EndIf
			(cQryRel)->(dbSkip())
		EndDo
		oReport:EndPage() //-- Salta Pagina
	EndDo
	oSection2:Finish()
	oSection5:Finish()
	(cQryRel)->(DbCloseArea()) 

ElseIf MV_PAR01 == 3 // Impressao Remito

	//зддддддддддддддддддддддддддддддд©
	//ЁDefinindo o titulo do RelatorioЁ
	//юддддддддддддддддддддддддддддддды
	If cPaisloc $ "CHI"
		cTitulo  += " (" + STR0030 + ") "	//" (GUIA DE DESPACHO)"
	Elseif cPaisloc $ "COL|MEX|PAR"
		cTitulo  += " (" + STR0031 + ") "	//" (REMISION)"
	Elseif cPaisloc $ "EUA|POR"
		cTitulo  += " (" + STR0032 + ") "	//" (CONDUCE)"
	Elseif cPaisloc $ "ARG|URU"
		cTitulo  += " (" + STR0029 + ") "	//" (REMITO)"
	Endif
	oReport:SetTitle(oReport:Title()+"    "+cTitulo) //"Pick-List Enderecamento"
	
	//зддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁDesabilitando secoes que nao seram utilizadasЁ
	//юддддддддддддддддддддддддддддддддддддддддддддды
	oSection1:Disable()
	oSection2:Disable()
	oSection4:Disable()
	oSection5:Disable()

	oReport:SetMeter( SD2->(LastRec()) )
	oSection3:Init()
	oSection6:Init()
	While !oReport:Cancel() .And. !(cQryRel)->(Eof())
		If SD2->D2_TIPO $ "D"
			dbSelectArea( "SA2" )
			dbSetOrder( 1 )
			dbSeek( xFilial("SA2") + (cQryRel)->D2_CLIENTE + (cQryRel)->D2_LOJA )
			oSection3:Cell('A2_COD' ):SetValue( SA2->A2_COD  )
			oSection3:Cell('A2_LOJA'):SetValue( SA2->A2_LOJA )
			oSection3:Cell('A2_NOME'):SetValue( SA2->A2_NOME ) 
			oSection3:Cell('A2_MUN' ):SetValue( SA2->A2_MUN  )
			oSection3:Cell('A2_EST' ):SetValue( SA2->A2_EST  )
		Else
			dbSelectArea( "SA1" )
			dbSetOrder( 1 )
			dbSeek( xFilial("SA1") + (cQryRel)->D2_CLIENTE + (cQryRel)->D2_LOJA)
			oSection3:Cell('A2_COD' ):SetValue( SA1->A1_COD  )
			oSection3:Cell('A2_LOJA'):SetValue( SA1->A1_LOJA )
			oSection3:Cell('A2_NOME'):SetValue( SA1->A1_NOME ) 
			oSection3:Cell('A2_MUN' ):SetValue( SA1->A1_MUN  )
			oSection3:Cell('A2_EST' ):SetValue( SA1->A1_EST  )
		EndIf
		oSection3:PrintLine() //-- Impressao da secao 3
		oReport:ThinLine()
		cDocAnt := xFilial("SD2")+(cQryRel)->(D2_DOC+D2_SERIE)
		While !(cQryRel)->(Eof()) .And. (cQryRel)->(D2_FILIAL+D2_DOC+D2_SERIE) == cDocAnt
			If Localiza( (cQryRel)->D2_COD )
				dbSelectArea( "SDB" )
				dbSetOrder(1)
				cChaveDB := xFilial("SDB")+(cQryRel)->(D2_COD+D2_LOCAL+D2_NUMSEQ+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)
				If dbSeek(cChaveDB)
					While !Eof() .And. cChaveDB == DB_FILIAL+DB_PRODUTO+DB_LOCAL+DB_NUMSEQ+DB_DOC+DB_SERIE+DB_CLIFOR+DB_LOJA
			   			If DB_ESTORNO == "S"
							dbSkip()
							Loop
						EndIf
						oSection6:Cell('DB_LOCALIZ'):SetValue( SDB->DB_LOCALIZ )
						oSection6:Cell('DB_NUMSERI'):SetValue( SDB->DB_NUMSERI )
						oSection6:Cell('DB_QUANT'  ):SetValue( SDB->DB_QUANT   )
						oReport:IncMeter()
						oSection6:PrintLine() //-- Impressao da secao 6
						SDB->(dbSkip())
					EndDo
				Else
					oSection6:Cell('DB_LOCALIZ'):SetValue( '' )
					oSection6:Cell('DB_NUMSERI'):SetValue( '' )
					oSection6:Cell('DB_QUANT'  ):SetValue( (cQryRel)->D2_QUANT )
					oReport:IncMeter()
					oSection6:PrintLine() //-- Impressao da secao 6
				EndIf
			Else
				oSection6:Cell('DB_LOCALIZ'):SetValue( '' )
				oSection6:Cell('DB_NUMSERI'):SetValue( '' )
				oSection6:Cell('DB_QUANT'  ):SetValue( (cQryRel)->D2_QUANT )
				oReport:IncMeter()
				oSection6:PrintLine() //-- Impressao da secao 6
			EndIf
			//здддддддддддддддддддддддддддддддддддддд©
			//Ё Executa EXECBLOCK p/ envio de e-mail Ё
			//юдддддддддддддддддддддддддддддддддддддды
			If lExistBlock
				ExecBlock("MR265MAIL",.F.,.F.)
			EndIf
			(cQryRel)->(dbSkip())
		EndDo
		oReport:EndPage() //-- Salta Pagina
	EndDo
	oSection3:Finish()
	oSection6:Finish()
	(cQryRel)->(DbCloseArea()) 

EndIf

RestArea(aAreaSB1)

Return Nil
