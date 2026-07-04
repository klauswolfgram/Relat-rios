/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'MATR311.CH'
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR311  ³ Autor ³ Ricardo Berti			³ Data ³14/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rela‡„o dos Produtos Vendidos FIFO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR311()

Local oReport

oReport:= ReportDef()
oReport:PrintDialog()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Ricardo Berti 		³ Data ³14.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport 
Local oSection1
Local oCell         
Local oBreak
Local cTamVlr	:= TamSX3('D2_CUSTO1')[1]
Local cPictVl	:= X3Picture('D2_CUSTO1')
Local nTotLuc	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                    	³
//³ mv_par01     // Almoxarifado inicial                        ³
//³ mv_par02     // Almoxarifado final                          ³
//³ mv_par03     // Data de emissao inicial                     ³
//³ mv_par04     // Data de emissao final                       ³
//³ mv_par05     // Tipo Inicial                                ³
//³ mv_par06     // Tipo Final                                  ³
//³ mv_par07     // Produto Inicial                             ³
//³ mv_par08     // Produto Final                               ³
//³ mv_par09     // Moeda Selecionada (1 a 5)                   ³
//³ mv_par10     // Considera Valor IPI Sim Näo                 ³
//³ mv_par11     // Considera Devolucao NF Orig/NF Devl/Nao Cons³
//³ mv_par12     // Quanto a Estoque Movimenta/Nao Movta/Ambos  ³
//³ mv_par13     // Quanto a Duplicata Gera/Nao Gera/Ambos      ³
//³ mv_par14     // Inclui Devolucao de Compra?                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR311",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("MATR311",STR0027,"MTR311", {|oReport| ReportPrint(oReport,@nTotLuc)},STR0002+" "+STR0003+" "+STR0004) //'RELACAO DOS PRODUTOS VENDIDOS'##'Este relatorio apresenta o valor total das vendas de cada produto,'###//'Este relatorio apresenta o valor total das vendas de cada produto,'###'bem o custo de cada venda e o custo de reposicao do produto.'
oReport:SetLandscape()    
oReport:SetTotalInLine(.F.)
oReport:SetEdit(.F.)

oSection1 := TRSection():New(oReport,STR0026,{"SD2"}) // "Itens de documentos de saida"
oSection1 :SetTotalInLine(.F.)
oSection1 :SetHeaderPage(.F.)

TRCell():New(oSection1,"B1_TIPO"	,"SB1",/*Titulo*/			,/*Picture*/				,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D2_COD"		,"SD2",/*Titulo*/			,/*Picture*/				,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_DESC"	,"SB1",/*Titulo*/			,/*Picture*/				,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"nAp1"		,"   ",RetTitle("D2_QUANT")	,PesqPictQt("D2_QUANT",12)	,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,"B1_UM"		,"SB1",/*Titulo*/			,/*Picture*/				,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,"nAp2"		,"   ",STR0016				,/*Picture*/				,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Custo Total"
TRCell():New(oSection1,"nCusto"		,"   ",STR0017+CRLF+STR0018	,/*Picture*/				,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Custo por"###" Unidade"
TRCell():New(oSection1,"nAp3"		,"   ",STR0019				,/*Picture*/				,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Valor Faturado"
TRCell():New(oSection1,"cSinalMarg"	,"   ","+"+CRLF+"-"			,"X"						,1			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"nMargem"	,"   ",STR0020				,"9999.9"					,6			,/*lPixel*/,/*{|| code-block de impressao }*/) //"Margem"
TRCell():New(oSection1,"nMix"		,"   ",STR0021				,"9999.9"					,6			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Mix"
TRCell():New(oSection1,"cSinalMixM"	,"   ","+"+CRLF+"-"			,"X"	 					,1			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"nMixMar"	,"   ",STR0021+CRLF+STR0022	,"9999.9"					,6			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Mix"###"*Mar"
TRCell():New(oSection1,"nAp4"		,"   ",STR0023+CRLF+STR0024	,/*Picture*/				,cTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Custo de "###"Reposicao"
TRCell():New(oSection1,"nVariacao"	,"   ",STR0025				,"9999.9"					,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Variacao"

oBreak := TRBreak():New(oSection1,oSection1:Cell("B1_TIPO"),STR0012,.F.) //"Sub Total : "
TRFunction():New(oSection1:Cell("nAp1")		,"AP1"	,"SUM"		,oBreak,"",PesqPictQt("D2_QUANT",12),/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection1:Cell("nAp2")		,"AP2"	,"SUM"		,oBreak,"",cPictVl,/*uFormula*/,.F.,.T.) 
// ONPRINT: calculo no momento da impressao
// Metodo GetLastValue(): Ultimo valor do totalizador
TRFunction():New(oSection1:Cell("nCusto")	,NIL	,"ONPRINT"	,oBreak,"",cPictVl		,{|| oSection1:GetFunction("AP2"):GetLastValue() /  oSection1:GetFunction("AP1"):GetLastValue() }/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection1:Cell("nAp3")		,"AP3"	,"SUM"		,oBreak,"",cPictVl		,/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection1:Cell("nMargem")	,NIL	,"ONPRINT"	,oBreak,"","@Z 9999.9"	,{|| 100* (oSection1:GetFunction("AP3"):GetLastValue() - oSection1:GetFunction("AP2"):GetLastValue()) / oSection1:GetFunction("AP3"):GetLastValue() }/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection1:Cell("nMix")		,NIL	,"SUM"		,oBreak,"","@Z 9999.9"	,/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection1:Cell("nMixMar")	,NIL	,"ONPRINT"	,oBreak,"","@Z 9999.9"	,{|| 100* (oSection1:GetFunction("AP3"):GetLastValue() - oSection1:GetFunction("AP2"):GetLastValue()) / nTotLuc }/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection1:Cell("nAp4")		,"AP4"	,"SUM"		,oBreak,"",cPictVl		,/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection1:Cell("nVariacao"),NIL	,"ONPRINT"	,oBreak,"","@Z 9999.9"	,{|| If( oSection1:GetFunction("AP2"):GetLastValue()<> 0,(100* oSection1:GetFunction("AP4"):GetLastValue() / oSection1:GetFunction("AP2"):GetLastValue())-100 ,0) }/*uFormula*/,.F.,.T.) 

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Ricardo Berti 		³ Data ³14.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto do relatorio                                  ³±±
±±³          ³ExpN1: Totalizador utilizado em calculos (Fat - custo Fifo) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,nTotLuc)

Local oSection1   := oReport:Section(1) 
Local cAliasTop	  := "SD2"
Local cCodAnt     := ''
Local cTipAnt     := ''
Local cMoeda      := Str(mv_par09,1)
Local cEstoq      := If(mv_par12==1,'S',If(mv_par12==2,'N','SN'))
Local cDupli      := If(mv_par13==1,'S',If(mv_par13==2,'N','SN'))
Local cArqSD1     := ''
Local cArqSD2     := ''
Local cCondSD1    := ''
Local cChaveSD1   := ''
Local cFilSD1     := xFilial('SD1')
Local cFilSD2     := xFilial('SD2')
Local nTotFat     := 0
Local nIndSD1     := 0
Local nAp1        := 0
Local nAp2        := 0
Local nAp3        := 0
Local nAp4        := 0
Local nFldSD1     := 0
Local nFldSD2     := 0
Local lDevolucao  := .F.
Local cWhere
Local cSelect


oReport:SetTitle( oReport:Title()+" - "+GetMv("MV_SIMB"+cMoeda))

If !(mv_par11==3)
	dbSelectArea('SD1')
	cArqSD1   := CriaTrab(NIL,.F.)
	cChaveSD1 := 'D1_FILIAL+D1_COD+D1_SERIORI+D1_NFORI+D1_ITEMORI'
	cCondSD1  := "D1_FILIAL=='"+cFilSD1+"'.And.D1_TIPO=='D'.And."
	cCondSD1  += "D1_COD>='"+mv_par07+"'.And.D1_COD<='"+mv_par08+"'.And."
	cCondSD1  += "D1_LOCAL>='"+mv_par01+"'.And.D1_LOCAL<='"+mv_par02
	If (mv_par11 == 1)
		cCondSD1 += "'"
	Else
		cCondSD1 += "'.And.DtoS(D1_DTDIGIT)>='"+DtoS(mv_par03)+"'.And.DtoS(D1_DTDIGIT)<='"+DtoS(mv_par04)+"'"
	Endif
	IndRegua('SD1', cArqSD1, cChaveSD1,, cCondSD1, OemToAnsi(STR0010) ) //'Selecionando Registros...'
	nIndSD1 := RetIndex('SD1')

	dbSetOrder(nIndSD1+1)
	nFldSD1 := FieldPos('D1_CUSFF'+cMoeda)
Endif

dbSelectArea("SB1")
dbSetOrder(1)
dbSelectArea("SD2")
dbSetOrder(2)
nFldSD2 := FieldPos('D2_CUSFF'+cMoeda)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)
	
	cAliasTop := GetNextAlias()    

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):BeginQuery()	
	
	cSelect := "%"
	If nFldSD2 > 0
		//Adicao a query do campo conf. a moeda
		cSelect += ","+'D2_CUSFF'+cMoeda
	EndIf
	cSelect += "%"

	cWhere := "%"
	If mv_par14 == 2
		cWhere += " And D2_TIPO <> 'D'"
	Endif	
	cWhere += "%"

	BeginSql Alias cAliasTop

		SELECT D2_FILIAL,D2_TP,D2_COD,D2_DOC,D2_SERIE,D2_ITEM,D2_TES,D2_EMISSAO,D2_QUANT, 
 		       D2_TOTAL,D2_VALIPI,D2_ORIGLAN,D2_CLIENTE,D2_LOJA
 		       %Exp:cSelect%	 	
				
		FROM %table:SD2% SD2
			
		WHERE	D2_FILIAL   = %xFilial:SD2% AND
				D2_TP      >= %Exp:mv_par05% AND D2_TP    <= %Exp:mv_par06% AND 
				D2_COD     >= %Exp:mv_par07% AND D2_COD   <= %Exp:mv_par08% AND 
				D2_LOCAL   >= %Exp:mv_par01% AND D2_LOCAL <= %Exp:mv_par02% AND 
				D2_EMISSAO >= %Exp:DtoS(mv_par03)% AND D2_EMISSAO  <= %Exp:DtoS(mv_par04)% AND 
				SD2.%NotDel% 
				%Exp:cWhere%
				
		ORDER BY %Order:SD2% 
	
	EndSql 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasTop)
oReport:SetMeter(SD2->(LastRec())*2)
dbGoTop()

While !oReport:Cancel() .And. !(cAliasTop)->(Eof())
	If oReport:Cancel()
		Exit
	EndIf	
	oReport:IncMeter()
	
	If !(cCodAnt==D2_COD)
		cCodAnt    := D2_COD
		lDevolucao := .T.
	EndIf

	// Posiciona no cabecalho do documento de saida
	SF2->(dbSetOrder())
	SF2->(dbSeek(xFilial("SF2")+(cAliasTop)->(D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
	//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(D2_ORIGLAN=='LF') .And. AvalTes(D2_TES,cEstoq,cDupli)
		If nFldSD2 > 0		
			nTotLuc += D2_CUSFF&(cMoeda)
		EndIf
		If mv_par09 > 1 .Or. (mv_par09 # SF2->F2_MOEDA)
			nTotFat += xMoeda(D2_TOTAL+If(mv_par10==1,0,D2_VALIPI),SF2->F2_MOEDA,Val(cMoeda),D2_EMISSAO)
		Else
			nTotFat += D2_TOTAL+If(mv_par10 == 1,0,D2_VALIPI)
		EndIf
		If mv_par11 == 1
			dbSelectArea('SD1')
			If dbSeek(cFilSD1+(cAliasTop)->D2_COD+(cAliasTop)->D2_SERIE+(cAliasTop)->D2_DOC+(cAliasTop)->D2_ITEM, .F.)
				// Posicionar no Cabecalho do Documento de Entrada
				SF1->(dbSetOrder(1))
				SF1->(dbSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_TIPO))
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
				//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !(D1_ORIGLAN=='LF') .And. AvalTes(D1_TES,cEstoq,cDupli)
					If mv_par09 > 1 .And. (mv_par09 # SF1->F1_MOEDA)
						nTotLuc -= xMoeda(FieldGet( nFldSD1 ),SF1->F1_MOEDA,Val(cMoeda),D1_DTDIGIT)
						nTotFat -= xMoeda(D1_TOTAL+If(mv_par10==1,0,D1_VALIPI),SF1->F1_MOEDA,Val(cMoeda),D1_DTDIGIT)
					Else
						nTotLuc -= FieldGet(nFldSD1)
						nTotFat -= D1_TOTAL+If(mv_par10==1,0,D1_VALIPI)
					EndIf
				EndIf
			EndIf
		ElseIf mv_par11 == 2 .And. lDevolucao
			dbSelectArea('SD1')
			If dbSeek(cFilSD1+(cAliasTop)->D2_COD, .F.)
				Do While !Eof() .And. (D1_COD==(cAliasTop)->D2_COD)
					// Posicionar no Cabecalho do Documento de Entrada
					SF1->(dbSetOrder(1))
					SF1->(dbSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_TIPO))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
					//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !(D1_ORIGLAN=='LF') .And. AvalTes(D1_TES,cEstoq,cDupli)
						If mv_par09 > 1 .And. (mv_par09 # SF1->F1_MOEDA)
							nTotLuc -= xMoeda(FieldGet( nFldSD1 ),SF1->F1_MOEDA,Val(cMoeda),D1_DTDIGIT)
							nTotFat -= xMoeda(D1_TOTAL+If(mv_par10==1,0,D1_VALIPI),SF1->F1_MOEDA,Val(cMoeda),D1_DTDIGIT)
						Else
							nTotLuc -= FieldGet(nFldSD1)
							nTotFat -= D1_TOTAL+If(mv_par10==1,0,D1_VALIPI)
						EndIf
					EndIf
					dbSkip()
				EndDo
			EndIf
			lDevolucao := .F.
		EndIf
	EndIf
	dbSelectArea((cAliasTop))
	dbSkip()
EndDo

nTotLuc := nTotFat-nTotLuc

dbGoTop()

cCodAnt := ''

oSection1:Init() 

While !oReport:Cancel() .And. !(cAliasTop)->(Eof())
	If oReport:Cancel()
		Exit
	EndIf

	nAt1    := 0
	nAt2    := 0
	nAt3    := 0
	nAt4    := 0
	cTipant := D2_TP

	Do While  !oReport:Cancel() .And. !(cAliasTop)->(Eof()) .And. (cAliasTop)->D2_TP==cTipant
		If oReport:Cancel()
			Exit
		EndIf
		nAp1 := 0
		nAp2 := 0
		nAp3 := 0
		nAp4 := 0

		If !(cCodAnt==D2_COD)
			cCodAnt    := D2_COD
			lDevolucao := .T.
		Endif

		While !oReport:Cancel() .And. !(cAliasTop)->(Eof()) .And. (cAliasTop)->D2_TP+(cAliasTop)->D2_COD==cTipant+cCodAnt
			If oReport:Cancel()
				Exit
			EndIf
			oReport:IncMeter()
			// Posiciona no cabecalho do documento de saida
			SF2->(dbSetOrder())
			SF2->(dbSeek(xFilial("SF2")+(cAliasTop)->(D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
			//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !(D2_ORIGLAN=='LF') .And. AvalTes(D2_TES,cEstoq,cDupli)
				SB1->(dbSeek(xFilial('SB1')+(cAliasTop)->D2_COD, .F.))
				nAp1 += D2_QUANT
				If nFldSD2 > 0		
					nAp2 += D2_CUSFF&(cMoeda)
				EndIf
				If mv_par09 > 1 .Or. (mv_par09 # SF2->F2_MOEDA)
					nAp3 += xMoeda(D2_TOTAL+If(mv_par10==1,D2_VALIPI,0),SF2->F2_MOEDA,Val(cMoeda),D2_EMISSAO)
					nAp4 += D2_QUANT*xMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),Val(cMoeda),RetFldProd(SB1->B1_COD,"B1_DATREF"))
				Else
					nAp4 += (D2_QUANT*RetFldProd(SB1->B1_COD,"B1_CUSTD"))
					nAp3 += (D2_TOTAL+If(mv_par10==1,D2_VALIPI,0))
				EndIf
				If mv_par11 == 1
					dbSelectArea('SD1')
					If dbSeek(cFilSD1+(cAliasTop)->D2_COD+(cAliasTop)->D2_SERIE+(cAliasTop)->D2_DOC+(cAliasTop)->D2_ITEM, .F.)
						// Posicionar no Cabecalho do Documento de Entrada
						SF1->(dbSetOrder(1))
						SF1->(dbSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_TIPO))
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
						//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If !(D1_ORIGLAN=='LF') .And. AvalTes(D1_TES,cEstoq,cDupli)
							nAp1 -= D1_QUANT
							If mv_par09 > 1 .And. (mv_par09 # SF1->F1_MOEDA)
								nAp2 -= xMoeda(FieldGet( nFldSD1 ),SF1->F1_MOEDA,Val(cMoeda),D1_DTDIGIT)
								nAp3 -= xMoeda(D1_TOTAL+If(mv_par10==1,0,D1_VALIPI),SF1->F1_MOEDA,Val(cMoeda),D1_DTDIGIT)
								nAp4 -= D1_QUANT*xMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),Val(cMoeda),RetFldProd(SB1->B1_COD,"B1_DATREF"))
							Else
								nAp3 -= (D1_TOTAL+If(mv_par10 == 1,D1_VALIPI,0 ))
								nAp2 -= FieldGet(nFldSD1)
								nAp4 -= (D1_QUANT*RetFldProd(SB1->B1_COD,"B1_CUSTD"))
							EndIf
						EndIf
					EndIf
				Elseif mv_par11 == 2 .And. lDevolucao
					dbSelectArea('SD1')
					If dbSeek(cFilSD1+(cAliasTop)->D2_COD, .F.)
						Do While !Eof() .And. (D1_COD==cCodAnt)
							// Posicionar no Cabecalho do Documento de Entrada
							SF1->(dbSetOrder(1))
							SF1->(dbSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_TIPO))
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal    ³
							//³ Despreza Itens em que a TES NAO Se Ajusta a Selecao do Usuario ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If !(D1_ORIGLAN=='LF') .And. AvalTes(D1_TES,cEstoq,cDupli)
								nAp1 -= D1_QUANT
								If mv_par09 > 1 .And. (mv_par09 # SF1->F1_MOEDA)
									nAp2 -= xMoeda(FieldGet( nFldSD1 ),SF1->F1_MOEDA,Val(cMoeda),D1_DTDIGIT)
									nAp3 -= xMoeda(D1_TOTAL+If(mv_par10==1,0,D1_VALIPI),SF1->F1_MOEDA,Val(cMoeda),D1_DTDIGIT)
									nAp4 -= D1_QUANT*xMoeda(RetFldProd(SB1->B1_COD,"B1_CUSTD"),Val(RetFldProd(SB1->B1_COD,"B1_MCUSTD")),Val(cMoeda),RetFldProd(SB1->B1_COD,"B1_DATREF"))
								Else
									nAp2 -= FieldGet(nFldSD1)
									nAp4 -= (D1_QUANT*RetFldProd(SB1->B1_COD,"B1_CUSTD"))
									nAp3 -= (D1_TOTAL+If(mv_par10 == 1,D1_VALIPI,0))
								EndIf
							EndIf
							dbSkip()
						EndDo
					EndIf
					lDevolucao := .F.
				EndIf
			EndIf
			dbSelectArea((cAliasTop))
			dbSkip()
		EndDo
		If !(QtdComp(nAp1)==QtdComp(0)) .Or. !(QtdComp(nAp2)==QtdComp(0)) .Or. !(QtdComp(nAp3)==QtdComp(0)) .Or. !(QtdComp(nAp4)==QtdComp(0))		
			oSection1:Cell("nAp2"	):SetPicture(TM(nAp2,14))
			oSection1:Cell("nCusto"	):SetPicture(TM(nAp2,14))
			oSection1:Cell("nAp3"	):SetPicture(TM(nAp3,14))
			oSection1:Cell("nAp4"	):SetPicture(TM(nAp4,14))

			oSection1:Cell("B1_TIPO"):SetValue(cTipant)
			oSection1:Cell("D2_COD"	):SetValue(cCodAnt)
			oSection1:Cell("B1_DESC"):SetValue(SB1->B1_DESC)
			oSection1:Cell("nAp1"	):SetValue(nAp1)
			oSection1:Cell("B1_UM"	):SetValue(SB1->B1_UM)
			oSection1:Cell("nAp1"	):SetValue(nAp1)
			oSection1:Cell("nAp2"	):SetValue(nAp2)
			oSection1:Cell("nCusto"	):SetValue(nAp2/nAp1)
			oSection1:Cell("nAp3"	):SetValue(nAp3)
			If !(QtdComp(nAp3)==QtdComp(0))
				oSection1:Cell("cSinalMarg"	):SetValue(If(QtdComp((nAp3-nAp2)/nAp3)>QtdComp(0),'+','-'))
				oSection1:Cell("cSinalMarg"	):Show()
				oSection1:Cell("nMargem"	):SetValue(ABS(100*(nAp3-nAp2)/nAp3))
				oSection1:Cell("nMargem"	):Show()
			Else
				oSection1:Cell("cSinalMarg"	):Hide()
				oSection1:Cell("nMargem"	):SetValue(0)
				oSection1:Cell("nMargem"	):Hide()
			Endif
			If !(QtdComp(nTotFat)==QtdComp(0))
				oSection1:Cell("nMix"):SetValue(100*(nAp3/nTotFat))
				oSection1:Cell("nMix"):Show()
			Else
				oSection1:Cell("nMix"):SetValue(0)
				oSection1:Cell("nMix"):Hide()
			Endif
			If nTotLuc != 0
				oSection1:Cell("cSinalMixM"	):SetValue(If(((nAp3-nAp2)/nTotLuc)>0,'+','-'))
				oSection1:Cell("cSinalMixM"	):Show()
				oSection1:Cell("nMixMar"	):SetValue(ABS(100*(nAp3-nAp2)/nTotLuc))
				oSection1:Cell("nMixMar"	):Show()
			Else
				oSection1:Cell("cSinalMixM"	):Hide()
				oSection1:Cell("nMixMar"	):SetValue(0)
				oSection1:Cell("nMixMar"	):Hide()
			EndIf
			oSection1:Cell("nAp4"):SetValue(nAp4)
			If !(QtdComp(nAp2)==QtdComp(0))
				oSection1:Cell("nVariacao"):SetValue((100*nAp4/nAp2)-100)
				oSection1:Cell("nVariacao"):Show()
			Else
				oSection1:Cell("nVariacao"):SetValue(0)
				oSection1:Cell("nVariacao"):Hide()
			EndIf		
  			oSection1:PrintLine()			
		EndIf
	EndDo
EndDo
oSection1:Finish()			

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasTop)
dbCloseArea()

dbSelectArea('SD2')
dbClearFilter()
dbSetOrder(1)
RetIndex('SD2')

dbSelectArea('SD1')
RetIndex('SD1')

IF "" <> AllTrim(cArqSD1)
	IF File(cArqSD1+OrdBagExt())
		fErase(cArqSD1+OrdBagExt())
	EndIf
Endif
IF "" <> AllTrim(cArqSD2)
	If File(cArqSD2+OrdBagExt())
		fErase( cArqSD2+OrdBagExt() )
	EndIf
EndIf

Return Nil