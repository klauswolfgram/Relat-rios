/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR445.CH"
#INCLUDE "PROTHEUS.CH"
/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё MATR445  Ё Autor Ё Marcos V. Ferreira    Ё Data Ё 30/05/06 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Analise da movimentacao de Estoques                        Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
*/
User Function MATR445()
Local oReport

oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  ЁReportDef Ё Autor ЁMarcos V. Ferreira     Ё Data Ё30/05/05  Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁA funcao estatica ReportDef devera ser criada para todos os Ё╠╠
╠╠Ё          Ёrelatorios que poderao ser agendados pelo usuario.          Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁNenhum                                                      Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё MATR445			                                          Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function ReportDef()

Local aOrdem 	 := {STR0006,STR0007,STR0008,STR0009}	//" Por Codigo "###" Por Tipo "###" Por Descricao "###" Por Grupo "
Local cPictQuant := PesqPict('SD3','D3_QUANT')	
Local cPictValor := PesqPict('SD3','D3_CUSTO1')
Local nQtdTam    := TamSX3('D3_QUANT')[1]
Local nVltTam    := TamSX3('D3_CUSTO1')[1]
Local oSession 
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
oReport:= TReport():New("MATR445",STR0002,"MTR445", {|oReport| ReportPrint(oReport)},STR0002+" "+STR0003+" "+STR0004+" "+STR0005)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01     // Perido de                                    Ё
//Ё mv_par02     // Periodo ate                                  Ё
//Ё mv_par03     // codigo de                                    Ё
//Ё mv_par04     // codigo ate                                   Ё
//Ё mv_par05     // local de                                     Ё
//Ё mv_par06     // local ate                                    Ё
//Ё mv_par07     // Moeda                                        Ё
//Ё mv_par08     // De  Tipo                                     Ё
//Ё mv_par09     // Ate Tipo                                     Ё
//Ё mv_par10     // Lista Prod. Sem Mov. Sim/N└o                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(oReport:uParam,.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁCriacao da secao utilizada pelo relatorio                               Ё
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

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Sessao 1                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSession := TRSection():New(oReport,STR0034,{"SB1","SD1","SD2","SD3"},aOrdem) // "Analise da Movimentacao" ##"MovimentaГЦo dos Produtos"
oSession:SetTotalInLine(.F.)

oSession:SetNoFilter("SD1")
oSession:SetNoFilter("SD2")
oSession:SetNoFilter("SD3")

TRCell():New(oSession,'B1_COD'		,'SB1',STR0022				,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSession,'B1_TIPO'		,'SB1',STR0023				,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSession,'B1_GRUPO'	,'SB1',STR0024				,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSession,'B1_DESC'		,'SB1',STR0025				,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSession,'B1_UM'		,'SB1',STR0026				,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSession,'QTDE_PER'	,'   ',STR0029+CRLF+STR0027	,cPictQuant		,nQtdTam	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSession,'VLR_PER'		,'   ',STR0029+CRLF+STR0028	,cPictValor		,nVltTam	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSession,'QTDE_MED'	,'   ',STR0030+CRLF+STR0027	,cPictQuant		,nQtdTam	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSession,'VLR_MED'		,'   ',STR0030+CRLF+STR0028	,cPictValor		,nVltTam	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSession,'VLR_COM'		,'   ',STR0032+CRLF+STR0031	,cPictValor		,nVltTam	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

oSession:SetHeaderPage()
oSession:SetTotalText(STR0033) // "T o t a l   G e r a l :"
Return(oReport)

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбдддддддбдддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  ЁReportPrint Ё Autor ЁMarcos V. Ferreira   Ё Data Ё30/05/06  Ё╠╠
╠╠цддддддддддеддддддддддддадддддддадддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁA funcao estatica ReportPrint devera ser criada para todos  Ё╠╠
╠╠Ё          Ёos relatorios que poderao ser agendados pelo usuario.       Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁRetorno   ЁNenhum                                                      Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁExpO1: Objeto Report do Relatorio                           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё MATR445			                                          Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function ReportPrint(oReport)

Local oSession := oReport:Section(1)
Local nOrdem   := oSession:GetOrder()
Local cMoeda   := StrZero(mv_par07,1,0)
Local aOrdem   := {STR0006,STR0007,STR0008,STR0009} 	//" Por Codigo "###" Por Tipo "###" Por Descricao "###" Por Grupo "
Local aVars    := {}
Local aProd    := {}
Local nSiVl    := 0
Local nSiQt    := 0
Local nQtCo    := 0
Local nVlCo    := 0
Local nQtMed   := 0
Local nVlMed   := 0 
Local lMov     := .F.
Local lWmsNew	:= SuperGetMv("MV_WMSNEW",.F.,.F.)
Local lD3Servi	:= IIF(lWmsNew,.F.,GetMV('MV_D3SERVI',.F.,'N')=='N')
Local cAliasTop	:= ''
Local cQueryD3	:= ''
Local cProduto	:= ''
Local nTotRegs	:= 0
Local nX		:= 0 
Local cFiltro	:= ''
Local cQryOrdem	:= ''
Local aSaldo	:= {}
Local oBreak

Local aStrucSB1 := SB1->(dbStruct())      
Local cFilUsrSB1:= ""
Local cSelectSB1:= ""
Local cSelect   := ""
Local cName		:= ""

Private lVeic  := Upper(GetMV("MV_VEICULO"))=="S"

oReport:SetTitle(oReport:Title()+" - ("+AllTrim(aOrdem[oSession:GetOrder()])+STR0014+Dtoc(mv_par01)+STR0015+Dtoc(mv_par02))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Definicao da linha de SubTotal                               |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nOrdem == 2
	oBreak := TRBreak():New(oSession,oSession:Cell("B1_TIPO"),STR0017+STR0018,.F.)
ElseIf nOrdem == 4
	oBreak := TRBreak():New(oSession,oSession:Cell("B1_GRUPO"),STR0017+STR0019,.F.)
EndIf	

If nOrdem == 2 .Or. nOrdem == 4
	TRFunction():New(oSession:Cell('QTDE_PER'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oSession:Cell('VLR_PER'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oSession:Cell('QTDE_MED'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oSession:Cell('VLR_MED'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
	TRFunction():New(oSession:Cell('VLR_COM'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
EndIf

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Definicao da linha de Total Geral                            |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TRFunction():New(oSession:Cell('QTDE_PER'	),NIL,"SUM",/*oBreak*/,STR0020,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oSession:Cell('VLR_PER'	),NIL,"SUM",/*oBreak*/,STR0020,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oSession:Cell('QTDE_MED'	),NIL,"SUM",/*oBreak*/,STR0020,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oSession:Cell('VLR_MED'	),NIL,"SUM",/*oBreak*/,STR0020,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)
TRFunction():New(oSession:Cell('VLR_COM'	),NIL,"SUM",/*oBreak*/,STR0020,/*cPicture*/,/*uFormula*/,IIf(nOrdem == 2 .Or. nOrdem == 4 ,.F.,.T.),.F.)

nTotRegs += SD1->(LastRec())
nTotRegs += SD2->(LastRec())
nTotRegs += SD3->(LastRec())

cFilUsrSB1:= oSession:GetAdvplExp()


/*/ **** ATENCAO - O ORDER BY UTILIZA AS POSICOES DO SELECT, SE ALGUM CAMPO
    **** FOR INCLUIDO NA QUERY OU ALTERADO DE LUGAR DEVE SER REVISTA A SINTAXE
    **** DO ORDER BY
    01.ARQ				02.PRODUTO		    03.TIPO				04.UM
    05.GRUPO			06.DESCR		    07.CODITE			08.DATA
    09.TES				10.CF		    	11.SEQUENCIA		12.DOCUMENTO
    13.SERIE			14.QUANTIDADE		15.QUANT2UM			16.ARMAZEM
    17.OP				18.FORNECEDOR		19.LOJA				20.TIPO NF
    21.CODITE			22.REMITO		    23.TPDCENV			24.CUSTO1
    25.CUSTO2			26.CUSTO3			27.CUSTO4			28.CUSTO5
/*/                     
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Filtro adicional no SD3 para integracao com o modulo do WMS            |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cQueryD3 := "%"
If lD3Servi .And. IntDL()
	cQueryD3 += " AND ( (SD3.D3_SERVIC = '   ') OR
	cQueryD3 += " (SD3.D3_SERVIC <> '   ' AND SD3.D3_TM <= '500') OR "
	cQueryD3 += " (SD3.D3_SERVIC <> '   ' AND SD3.D3_TM > '500' AND "
	cQueryD3 += " SD3.D3_LOCAL ='" + GetMvNNR('MV_CQ','98') + "') )"
EndIf
cQueryD3 += "%"
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Ordem selecionada para exibicao do relatorio                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cQryOrdem := "%"
If nOrdem == 1
	cQryOrdem += IIf(!lVeic,"2,3,1,8,11","7,3,1,8,11")	//(PRODUTO/CODITE)+TIPO+ARQ+DATA+SEQUENCIA
ElseIf nOrdem == 2
	cQryOrdem += IIf(!lVeic,"3,2,1,8,11","3,7,1,8,11")	//TIPO+(PRODUTO/CODITE)+ARQ+DATA+SEQUENCIA
ElseIf nOrdem == 3
	cQryOrdem += "6,2,1,8,11" 							//DESCR+PRODUTO+ARQ+DATA+SEQUENCIA
Else
	cQryOrdem += IIf(!lVeic,"5,2,1,8,11","5,7,1,8,11")	//GRUPO+(PRODUTO/CODITE)+ARQ+DATA+SEQUENCIA
EndIf

cQryOrdem += "%"

    If !Empty(cFilUsrSB1)
	For nX := 1 To SB1->(FCount())
		cName := SB1->(FieldName(nX))
	 	If AllTrim( cName ) $ cFilUsrSB1
      		If aStrucSB1[nX,2] <> "M"  
      			If !cName $ cSelect .And. !cName $ cSelectSB1
	        		cSelectSB1 += "SB1."+cName+"," 
	          	Endif 	
	       	EndIf
		EndIf 			       	
	Next
    Endif

  	If !Empty(cSelectSB1)  
    cSelectSB1 := ","+Substr(cSelectSB1, 1, Len(cSelectSB1)-1) 
    EndIf

   	cSelectSB1 := "%"+cSelectSB1+"%" 

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁTransforma parametros Range em expressao SQL                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MakeSqlExpr(oReport:uParam)

cAliasTop := GetNextAlias()    
	
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁQuery do relatorio da Sessao 1                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oReport:Section(1):BeginQuery()			
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁInicio do Embedded SQL                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BeginSql Alias cAliasTop

	Column DTAUX as Date

	SELECT 'SD1' ARQ,				//01 - ARQUIVO
	       SB1.B1_COD PRODUTO,		//02 - PRODUTO
	       SB1.B1_TIPO TIPO,		//03 - TIPO
	       SB1.B1_UM UM,			//04 - UM
	       SB1.B1_GRUPO GRUPO,		//05 - GRUPO
	       SB1.B1_DESC DESCR,		//06 - DESCRICAO
	       SB1.B1_CODITE CODITE,	//07 - CODITE
	       D1_DTDIGIT DTAUX,			//08 - DATA
	       D1_TES TES,				//09 - TES
	       D1_CF CF,				//10 - CF
	       D1_NUMSEQ SEQUENCIA,		//11 - SEQUENCIA
	       D1_DOC DOCUMENTO,		//12 - DOCUMENTO	
	       D1_SERIE SERIE,			//13 - SERIE
	       D1_QUANT QUANTIDADE,		//14 - QUANTIDADE
	       D1_QTSEGUM QUANT2UM,		//14 - QUANT2UM
	       D1_LOCAL ARMAZEM,		//15 - ARMAZEM
	       ' ' OP,					//16 - OP
	       D1_FORNECE FORNECEDOR,	//17 - FORNECEDOR	
	       D1_LOJA LOJA,			//18 - LOJA
	       D1_TIPO TIPONF,			//19 - TIPONF
	       D1_REMITO REMITO,		//20 - REMITO
	       ' ' TPDCENV,				//21 - TPDCENV
	       D1_CUSTO CUSTO1,			//22 - CUSTO1
	       D1_CUSTO2 CUSTO2,		//23 - CUSTO2
	       D1_CUSTO3 CUSTO3,		//24 - CUSTO3
	       D1_CUSTO4 CUSTO4,		//25 - CUSTO4
	       D1_CUSTO5 CUSTO5,		//26 - CUSTO5
	       SD1.R_E_C_N_O_ NRECNO 	//27 RECNO
	       %Exp:cSelectSB1%

	FROM %table:SB1% SB1,%table:SD1% SD1,%table:SF4% SF4

	WHERE	SD1.D1_FILIAL  =  %xFilial:SD1%		AND SD1.D1_TES     =  SF4.F4_CODIGO		AND
			SD1.D1_DTDIGIT >= %Exp:mv_par01%	AND	SD1.D1_DTDIGIT <= %Exp:mv_par02%	AND
			SD1.D1_LOCAL   >= %Exp:mv_par05%	AND	SD1.D1_LOCAL   <= %Exp:mv_par06%	AND
			SD1.D1_ORIGLAN <> 'LF'		       	AND SD1.%NotDel% 						AND
			SB1.B1_FILIAL  =  %xFilial:SB1%		AND	SB1.B1_COD     =  SD1.D1_COD	   	AND
			SB1.B1_COD	   >= %Exp:mv_par03%	AND	SB1.B1_COD	   <= %Exp:mv_par04%	AND
			SB1.B1_TIPO	   >= %Exp:mv_par08%	AND	SB1.B1_TIPO	   <= %Exp:mv_par09%	AND
 			    SB1.%NotDel%						AND
 			    SF4.F4_FILIAL  =  %xFilial:SF4%		AND	SF4.F4_ESTOQUE =  'S'				AND
 			    SF4.%NotDel%						

	UNION

	SELECT 	'SD2' ARQ,
	        SB1.B1_COD PRODUTO,
	        SB1.B1_TIPO TIPO,
	        SB1.B1_UM UM,
	        SB1.B1_GRUPO GRUPO,
	        SB1.B1_DESC DESCR,
	        ' ' CODITE,
	        D2_EMISSAO DTAUX,
	        D2_TES TES,
			D2_CF CF,
			D2_NUMSEQ SEQUENCIA,
			D2_DOC DOCUMENTO,
			D2_SERIE SERIE,
			D2_QUANT QUANTIDADE,
			D2_QTSEGUM QUANT2UM,
			D2_LOCAL ARMAZEM,
			' ' OP,
			D2_CLIENTE FORNECEDOR,
			D2_LOJA LOJA,
			D2_TIPO TIPONF,
			D2_REMITO REMITO,
			D2_TPDCENV TPDCENV,
			D2_CUSTO1 CUSTO1,
			D2_CUSTO2 CUSTO2,
			D2_CUSTO3 CUSTO3,
			D2_CUSTO4 CUSTO4,
			D2_CUSTO5 CUSTO5,
	        SD2.R_E_C_N_O_ SD2RECNO  //27 RECNO
	        %Exp:cSelectSB1%
			
	FROM %table:SB1% SB1,%table:SD2% SD2, %table:SF4% SF4
	
	WHERE   SD2.D2_FILIAL 	=  %xFilial:SD2%	AND SD2.D2_TES 		=  SF4.F4_CODIGO	AND
			SD2.D2_EMISSAO 	>= %Exp:mv_par01%	AND	SD2.D2_EMISSAO 	<= %Exp:mv_par02%	AND
			SD2.D2_ORIGLAN 	<> 'LF'				AND	SD2.D2_LOCAL 	>= %Exp:mv_par05%	AND
			SD2.D2_LOCAL 	<= %Exp:mv_par06%	AND	SD2.%NotDel% 						AND
			SB1.B1_FILIAL   =  %xFilial:SB1%	AND	SB1.B1_COD 		=  SD2.D2_COD		AND
			SB1.B1_COD	    >= %Exp:mv_par03%	AND	SB1.B1_COD	    <= %Exp:mv_par04%	AND
		    SB1.B1_TIPO     >= %Exp:mv_par08%	AND SB1.B1_TIPO     <= %Exp:mv_par09%	AND
		    SB1.%NotDel% 						AND
		    SF4.F4_FILIAL	=  %xFilial:SF4%	AND	SF4.F4_ESTOQUE 	=  'S'				AND
		    SF4.%NotDel%

	UNION
		
	SELECT 	'SD3' ARQ, 
	        SB1.B1_COD PRODUTO,
	        SB1.B1_TIPO TIPO,
	        SB1.B1_UM UM, 
	        SB1.B1_GRUPO GRUPO,
	        SB1.B1_DESC DESCR,
	        ' ' CODITE,
	        D3_EMISSAO DTAUX,
	        D3_TM TES,
			D3_CF CF,
			D3_NUMSEQ SEQUENCIA,
			D3_DOC DOCUMENTO,
			' ' SERIE,
			D3_QUANT QUANTIDADE,
			D3_QTSEGUM QUANT2UM,
			D3_LOCAL ARMAZEM,
			D3_OP OP,
			' ' FORNECEDOR,
			' ' LOJA,
			' ' TIPONF,
			' ' REMITO,
			' ' TPDCENV,
			D3_CUSTO1 CUSTO1,
			D3_CUSTO2 CUSTO2,
			D3_CUSTO3 CUSTO3,
			D3_CUSTO4 CUSTO4,
			D3_CUSTO5 CUSTO5,
	        SD3.R_E_C_N_O_ SD3RECNO  //27 RECNO
	       %Exp:cSelectSB1%
				
	FROM %table:SB1% SB1,%table:SD3% SD3
		
	WHERE	SD3.D3_FILIAL	=  %xFilial:SD3%	AND	SD3.D3_COD		=  SB1.B1_COD  		AND
			SD3.D3_EMISSAO	>= %Exp:mv_par01%	AND	SD3.D3_EMISSAO	<= %Exp:mv_par02%	AND	
			SD3.D3_LOCAL	>= %Exp:mv_par05%	AND	SD3.D3_LOCAL	<= %Exp:mv_par06%	AND
			SD3.D3_ESTORNO	<> 'S'				AND	SD3.%NotDel%						AND
			SB1.B1_FILIAL   =  %xFilial:SB1%	AND	SB1.B1_TIPO     >= %Exp:mv_par08%	AND	
			SB1.B1_TIPO     <= %Exp:mv_par09%	AND	SB1.B1_COD	    >= %Exp:mv_par03%	AND
			SB1.B1_COD	    <= %Exp:mv_par04%	AND	SB1.%NotDel%
			%Exp:cQueryD3%

	UNION
		
	SELECT 	'SB1' ARQ,
	        SB1.B1_COD PRODUTO,
	        SB1.B1_TIPO TIPO,
	        SB1.B1_UM UM, 
	        SB1.B1_GRUPO GRUPO,
	        SB1.B1_DESC DESCR,
	        ' ' CODITE,
	        ' ' DTAUX,
	        ' ' TES,
	        ' ' CF,
	        ' ' SEQUENCIA,
	        ' ' DOCUMENTO,
	        ' ' SERIE,
			0 QUANTIDADE,
			0 QUANT2UM,
			' ' ARMAZEM,
			' ' OP,
			' ' FORNECEDOR,
			' ' LOJA,
			' ' TIPONF,
			' ' REMITO,
			' ' TPDCENV,
			0 CUSTO1,
			0 CUSTO2,
			0 CUSTO3,
			0 CUSTO4,
			0 CUSTO5,
			0 SB1RECNO // 27
	       %Exp:cSelectSB1%
				
	FROM %table:SB1% SB1

	WHERE 	SB1.B1_FILIAL   = %xFilial:SB1%		AND SB1.B1_COD 		>= %Exp:mv_par03%	AND
		  	SB1.B1_COD 		<= %Exp:mv_par04%	AND SB1.B1_TIPO 	>= %Exp:mv_par08%	AND
			SB1.B1_TIPO 	    <= %Exp:mv_par09%	AND	SB1.B1_LOCPAD >= %Exp:mv_par05%	AND SB1.B1_LOCPAD <= %Exp:mv_par06% AND
			SB1.%NotDel%
			

	ORDER BY %Exp:cQryOrdem%

   	EndSql

oReport:Section(1):EndQuery()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Abertura do arquivo de trabalho                              |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea(cAliasTop)
oReport:SetMeter(nTotRegs)
		
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicio da impressao da Sessao 1                              |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSession:Init()

While !oReport:Cancel() .And. !Eof() .And. (mv_par01 <= mv_par02)
		
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Considera filtro escolhido                                   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	dbSelectArea(cAliasTop)
	If !Empty(cFilUsrSB1)
	    If !(&(cFilUsrSB1))
	       dbSkip()
    	   Loop
    	EndIf   
	EndIf

	cProduto := (cAliasTop)->PRODUTO
	lMov	 := .F. // Validacao para produtos sem Movimentacao
	aProd    := {}
		
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Limpa array de saldos e o inicializa com as datas            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aVars:= {}
	For nX:=mv_par01 to mv_par02    // Montando Variaveis de Calculo
		Aadd(Avars,{nX,0,0})
	Next
	nSiVl := 0
	nSiQt := 0
	nQtCo := 0
	nVlCo := 0
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё SB1 - Verifica Produtos Sem Movimento						 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	dbSelectArea(cAliasTop)
	While !Eof() .And. (cAliasTop)->PRODUTO == cProduto .And. Alltrim((cAliasTop)->ARQ) == "SB1"
		aProd := {(cAliasTop)->PRODUTO,(cAliasTop)->CODITE,(cAliasTop)->TIPO,(cAliasTop)->GRUPO,(cAliasTop)->DESCR,(cAliasTop)->UM}
		dbSkip()
	EndDo

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta movimentacao pelo SD1 dentro do array de Saldos        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	dbSelectArea(cAliasTop)
	Do While !oReport:Cancel() .And. !Eof() .And. (cProduto == (cAliasTop)->PRODUTO) .And. Alltrim((cAliasTop)->ARQ) == "SD1"
		oReport:IncMeter()
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Despreza os movimentos feitos por remito.                    Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If cPaisLoc # "BRA" .And. !Empty(AllTrim((cAliasTop)->REMITO))
			dbSkip()
			Loop
		EndIf
		dbSelectArea("SF4")
		If MsSeek(xFilial("SF4")+(cAliasTop)->TES)
			dbSelectArea(cAliasTop)
			If SF4->F4_ESTOQUE == "S"
				lMov:= .T.
				nX:=Ascan(aVars, {|x| x[1] == (cAliasTop)->DTAUX })
				aVars[nX,2] += (cAliasTop)->QUANTIDADE
				aVars[nX,3] += &(cAliasTop+'->CUSTO'+cMoeda)
				nQtco += (cAliasTop)->QUANTIDADE
				nVlco += &(cAliasTop+'->CUSTO'+cMoeda)
			EndIf
		EndIf	
		dbSelectArea(cAliasTop)
		aProd := {(cAliasTop)->PRODUTO,(cAliasTop)->CODITE,(cAliasTop)->TIPO,(cAliasTop)->GRUPO,(cAliasTop)->DESCR,(cAliasTop)->UM}
		dbSkip()
	EndDo
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta movimentacao pelo SD2 dentro do array de Saldos        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	dbSelectArea(cAliasTop)
	Do While !oReport:Cancel() .And. !Eof() .And. (cProduto == (cAliasTop)->PRODUTO) .And. Alltrim((cAliasTop)->ARQ) == "SD2"
		oReport:IncMeter()
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Despreza os movimentos feitos por remito.                    Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If cPaisLoc # "BRA"  .And. !Empty(AllTrim((cAliasTop)->REMITO)) .And. !((cAliasTop)->TPDCENV $ "1A")
			dbSkip()
			Loop
		EndIf
		dbSelectArea("SF4")
		If MsSeek(xFilial("SF4")+(cAliasTop)->TES)
			dbSelectArea(cAliasTop)
			If SF4->F4_ESTOQUE == "S"
				lMov:= .T.
				nX:=Ascan(aVars, {|x| x[1] == (cAliasTop)->DTAUX })
				aVars[nX,2] -= (cAliasTop)->QUANTIDADE
				aVars[nX,3] -= &(cAliasTop+'->CUSTO'+cMoeda)
			EndIf
		EndIf
		dbSelectArea(cAliasTop)
		aProd := {(cAliasTop)->PRODUTO,(cAliasTop)->CODITE,(cAliasTop)->TIPO,(cAliasTop)->GRUPO,(cAliasTop)->DESCR,(cAliasTop)->UM}
		dbSkip()
	EndDo
			
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta movimentacao pelo SD3 dentro do array de Saldos        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	dbSelectArea(cAliasTop)
	Do While !oReport:Cancel() .And. !Eof() .And. (cProduto == (cAliasTop)->PRODUTO) .And. Alltrim((cAliasTop)->ARQ) == "SD3"
		oReport:IncMeter()
		lMov:= .T.
		If (cAliasTop)->TES > "500"
			nX:=Ascan(aVars, {|x| x[1] == (cAliasTop)->DTAUX })
			aVars[nX,2] -= (cAliasTop)->QUANTIDADE
			aVars[nX,3] -= &(cAliasTop+'->CUSTO'+cMoeda)
		Else
			nX:=Ascan(aVars, {|x| x[1] == (cAliasTop)->DTAUX })
			aVars[nX,2] += (cAliasTop)->QUANTIDADE
			aVars[nX,3] += &(cAliasTop+'->CUSTO'+cMoeda)
		EndIf
		aProd := {(cAliasTop)->PRODUTO,(cAliasTop)->CODITE,(cAliasTop)->TIPO,(cAliasTop)->GRUPO,(cAliasTop)->DESCR,(cAliasTop)->UM}
		dbSkip()
	EndDo

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Calcula Saldo inicial pelo SB9 e monta variaveis             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	dbSelectArea("SB2")
	dbSetOrder(1)
	MsSeek(xFilial("SB2")+cProduto+Alltrim(mv_par05),.T.)
	While !Eof() .And. (B2_COD == cProduto .And. B2_LOCAL <= mv_par06)
		aSaldo := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,mv_par01)
		nSiVl  += aSaldo[mv_par07+1]
		nSiQt  += aSaldo[1]
		dbSkip()
	EndDo
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Soma linha do array c/ linha anterior para ter o saldo do prd.Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nQtMed:= 0
	nVlMed:= 0
	For nX:= 1 to Len(aVars)
		If nX == 1
			aVars[1,2] += nSiQt
			aVars[1,3] += nSiVl
		Else
			aVars[nX,2] += aVars[nX-1,2]
			aVars[nX,3] += aVars[nX-1,3]
		EndIf
		nQtMed += aVars[nX,2]
		nVlMed += aVars[nX,3]
	Next
	nQtMed:= nQtMed / Len (aVars)
	nVlMed:= nVlMed / Len (aVars)

	If mv_par10 == 1 .Or. (mv_par10 == 2 .And. lMov)

		If !lVeic
			oSession:Cell('B1_COD'):SetValue(aProd[1]) // PRODUTO
		Else
			oSession:Cell('B1_COD'):SetValue(aProd[2] + " " + aProd[1]) // CODITE + PRODUTO
		EndIf

		oSession:Cell('B1_TIPO'	):SetValue(aProd[3]) 	// TIPO
		oSession:Cell('B1_GRUPO'):SetValue(aProd[4]) 	// GRUPO
		oSession:Cell('B1_DESC'	):SetValue(aProd[5])	// DESCR
		oSession:Cell('B1_UM'	):SetValue(aProd[6])	// UM
		oSession:Cell('QTDE_PER'):SetValue(aVars[Len(aVars),2])
		oSession:Cell('VLR_PER' ):SetValue(aVars[Len(aVars),3])
		oSession:Cell('QTDE_MED'):SetValue(nQtMed)
		oSession:Cell('VLR_MED' ):SetValue(nVlMed)
		oSession:Cell('VLR_COM' ):SetValue(nVlco/nQtco)

		oSession:PrintLine()

	EndIf

	dbSelectArea(cAliasTop)

EndDo

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Termino da impressao da Sessao 1                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
oSession:Finish()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Encerra a Query de Trabalho                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
(cAliasTop)->(dbCloseArea())
	
	
Return Nil

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё MR445DT  Ё Autor Ё Wilson Junior         Ё Data Ё 05/08/93 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Testa se periodo 'de/ate' - periodo de maior que 4096      Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function MR445DT()
If mv_par02-mv_par01 > 4095
	Help(" ",1,"R4096DIAS")
	Return .F.
EndIf
Return .T.