/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR435.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o     ³ MATR435  ³ Autor ³Alexandre Inacio Lemes³ Data ³28/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o  ³ Kardex p/ Lote Sobre o SD5                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³ U_MATR435(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ Generico                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR435()

Local oReport

oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³28/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Kardex p/ Lote Sobre o SD5                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local cTitle      := STR0004 //"Kardex por Lote/Sub-Lote (por produto)"
Local cPicSaldo   := PesqPict("SB8","B8_SALDO"  ,18)
Local cPicEmpenho := PesqPict("SB8","B8_EMPENHO",18)
Local oReport 
Local oSection1
Local oSection2
Local oSection3
Local nTamDoc     := Max(TamSX3("D5_DOC")[1], TamSX3("D5_OP")[1])
Local cAliasSB8 := GetNextAlias()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     	 ³
//³ mv_par01       	// Do  Produto                         	 	 ³
//³ mv_par02        // Ate Produto                         	 	 ³
//³ mv_par03        // De  Lote                            	 	 ³
//³ mv_par04        // Ate Lote			        			 	 ³
//³ mv_par05        // De  Sub-Lote                          	 ³
//³ mv_par06        // Ate Sub-Lote			        		 	 ³
//³ mv_par07        // De  Local		        			 	 ³
//³ mv_par08        // Ate Local							 	 ³
//³ mv_par09        // De  Data			        			 	 ³
//³ mv_par10        // Ate Data								 	 ³
//³ mv_par11       	// Lotes/Sub S/ Movimentos (Lista/Nao Lista) ³
//³ mv_par12       	// Lote/Sub Saldo Zerado   (Lista/Nao Lista) ³ 
//³ mv_par13       	// QTDE. na 2a. U.M. ?     (Sim/Nao)         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MR435A",.F.)
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
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Descricao do Relatorio                                                 ³
//³                                                                        ³
//³ STR0001	//"Este programa emitir  um Kardex com todas as movimenta‡”es" ³
//³ STR0002	//"do estoque por Lote/Sub-Lote, diariamente. Observa‡„o: o 1o"³                                                                        
//³ STR0003	//"movimento de cada Lote/Sub-Lote se refere a cria‡„o do mesmo³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("MATR435",cTitle,"MR435A", {|oReport| ReportPrint(oReport,cAliasSB8)},STR0001+" "+STR0002+" "+STR0003)
oReport:SetTotalInLine(.F.)
oReport:SetPortrait() 
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
oSection1:= TRSection():New(oReport,STR0028,{"SB8","SB1","SB2","NNR"}) //"Produtos"
oSection1:SetTotalInLine(.F.)
oSection1:SetTotalText(" ")
oSection1:SetLineStyle()
oSection1:SetNoFilter("SB1")
oSection1:SetNoFilter("SB2")

TRCell():New(oSection1,"B8_PRODUTO","SB8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection1,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection1,"B1_TIPO"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection1,"B1_UM"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If(mv_par13 <> 1 ,SB1->B1_UM,SB1->B1_SEGUM)},,,,,,.T.)
TRCell():New(oSection1,"NNR_DESCRI","NNR",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| Posicione("NNR",1,xFilial("NNR")+SB2->B2_LOCAL,"NNR_DESCRI")},,,,,,.T.)

oSection2:= TRSection():New(oSection1,STR0029,{"SB8"}) //"Saldos por Lote"
oSection2:SetTotalInLine(.F.)
oSection2:SetTotalText(" ")
oSection2:SetLineStyle()

TRCell():New(oSection2,"B8_NUMLOTE","SB8",STR0013	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection2,"B8_LOTECTL","SB8",STR0014	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection2,"SP1"       ,"   "," "		,/*Picture*/,47			,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection2,"SALDO"     ,"   ",STR0015	,cPicSaldo	,18			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.T. )
TRCell():New(oSection2,"TOTAL"     ,"   "," "		,cPicSaldo	,18			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.T. )
oSection2:Cell("SP1"):HideHeader()
oSection2:Cell("TOTAL"):Hide()
oSection2:SetCharSeparator("")

oSection3:= TRSection():New(oSection2,STR0030,{"SD5","SB8"}) //"Movimentos por Lote"
oSection3:SetTotalInLine(.F.)
oSection3:SetHeaderPage()
oSection3:SetNoFilter("SD5")
 
TRCell():New(oSection3,"D5_LOCAL"  ,"SD5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"D5LOCAL"   ,"SD5",RetTitle( "NNR_DESCRI" ),GetSx3Cache( 'NNR_DESCRI', 'X3_PICTURE'), GetSx3Cache( 'NNR_DESCRI', 'X3_TAMANHO'),/*lPixel*/,{|| Posicione("NNR",1, FWxFilial("NNR") + SD5->D5_LOCAL ,"NNR_DESCRI")},,,,,,.T.)
TRCell():New(oSection3,"D5_DATA"   ,"SD5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"D5_DTVALID","SD5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"D5_OP"     ,"SD5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"NUMDOC"    ,"SD5",STR0023	,/*Picture*/, nTamDoc	,/*lPixel*/,{|| SD5->D5_DOC },,,,,,.T.)

If cPaisLoc != "BRA"
	If cPaisLoc == "ARG"
		TRCell():New(oSection3,"DESCDOC","   ",STR0024,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| RetMovArg(SD5->D5_NUMSEQ) },,,,,,.T.)
	Else 
		TRCell():New(oSection3,"DESCDOC","   ",STR0024,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If( AllTrim(SD5->D5_SERIE) == "X" , If(cPaisLoc == "CHI" ,"GUI","REM") , "FAC" ) },,,,,,.T.)
	EndIf
EndIf

TRCell():New(oSection3,"D5_ORIGLAN","SD5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"D5_ESTORNO","SD5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oSection3,"ENTRADA"   ,"   ",STR0025	 ,cPicSaldo  ,18		 ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.T. )
TRCell():New(oSection3,"SAIDA"     ,"   ",STR0026	 ,cPicEmpenho,18		 ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.T. )
TRCell():New(oSection3,"SALDO"     ,"   ",STR0027	 ,cPicSaldo  ,18		 ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT",,,.T. )

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³28/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Kardex p/ Lote Sobre o SD5                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasSB8)

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(1):Section(1)  
Local oSection3 := oReport:Section(1):Section(1):Section(1)  
Local cCampo    := ""
Local cCompara  := ""
Local cLote     := ""
Local cLocal    := ""
Local cSubLote  := ""
Local cProduto  := ""
Local cProdAnt  := ""
Local cCondicao := ""
Local cWorkSD5  := ""
Local cFilter   := ""
Local cWhere    := ""
Local lProd     := .T.					
Local lLote     := .T.					
Local lLoteZera := .T.                  
Local lMovSD5   := .T.
Local lOkSublote:= .F.
Local lSeek     := .F.
Local nEntrada  := 0
Local nSaida    := 0
Local nSaldo    := 0 	
Local nSldLote  := 0
Local nIndSD5   := 0
Local nSD5Quant := 0  
Local nRec      := 0
Local nTotal    := 0
Local oTotal_EN1,oTotal_SA1, oTotal_SL1
Local oTotal_EN2,oTotal_SA2, oTotal_SL2

dbSelectArea('SB1')
dbSetOrder(1)

dbSelectArea("SB8")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cWhere := "%"

MakeSqlExpr(oReport:uParam)

oReport:Section(1):BeginQuery()	

BeginSql Alias cAliasSB8
		
SELECT SB8.* 

FROM %table:SB8% SB8

WHERE B8_FILIAL    = %xFilial:SB8% AND 
	  B8_PRODUTO  >= %Exp:mv_par01% AND 
      B8_PRODUTO  <= %Exp:mv_par02% AND      
      B8_LOTECTL  >= %Exp:mv_par03% AND 
      B8_LOTECTL  <= %Exp:mv_par04% AND          
      B8_NUMLOTE  >= %Exp:mv_par05% AND 
      B8_NUMLOTE  <= %Exp:mv_par06% AND      
      B8_LOCAL    >= %Exp:mv_par07% AND 
      B8_LOCAL    <= %Exp:mv_par08% AND      
	  %Exp:cWhere%
      SB8.%NotDel% 

ORDER BY B8_PRODUTO,B8_LOTECTL,B8_LOCAL,B8_NUMLOTE
				
EndSql 

oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
oSection2:SetParentQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho para a tabela SD5.       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD5")

cWorkSD5:= CriaTrab("",.F.)
cFilter := 'D5_FILIAL=="'+xFilial("SD5")+'".And.D5_PRODUTO>="'+mv_par01+'".And.D5_PRODUTO<="'+mv_par02+'".And.'
cFilter += 'D5_LOTECTL>="'+mv_par03+'".And.D5_LOTECTL<="'+mv_par04+'".And.'
cFilter += 'D5_NUMLOTE>="'+mv_par05+'".And.D5_NUMLOTE<="'+mv_par06+'".And.'
cFilter += 'D5_LOCAL>="'  +mv_par07+'".And.D5_LOCAL<="'  +mv_par08+'".And.'
cFilter += 'Dtos(D5_DATA)>="'+Dtos(mv_par09)+'".And.Dtos(D5_DATA)<="'+Dtos(mv_par10)+'"'

IndRegua("SD5",cWorkSD5,"D5_PRODUTO+D5_LOCAL+D5_LOTECTL+Dtos(D5_DATA)+D5_NUMLOTE+D5_NUMSEQ",,cFilter,STR0019) //"Selecionando Registros..."

nIndSD5 := RetIndex("SD5")
dbSetOrder(nIndSD5+1)
dbGotop()

oTotal_EN1 :=TRFunction():New(oSection3:Cell("ENTRADA"  ),"CALCENT1"	,"SUM"		,/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T./*lEndReport*/,.F./*lEndPage*/,,oSection1)
oTotal_SA1 :=TRFunction():New(oSection3:Cell("SAIDA"    ),"CALCSAI1"	,"SUM"		,/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1) 
oTotal_SL1 :=TRFunction():New(oSection3:Cell("SALDO"    ),NIL			,"ONPRINT"	,/*oBreak1*/,,/*cPicture*/,{|| F435Saldo( oSection1, "CALCENT1", "CALCSAI1", "TOTAL" ) },.T.,.F. ,,oSection1)

oTotal_EN2 :=TRFunction():New(oSection3:Cell("ENTRADA"  ),"CALCENT2"	,"SUM"		,/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection2)
oTotal_SA2 :=TRFunction():New(oSection3:Cell("SAIDA"    ),"CALCSAI2"	,"SUM"		,/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection2) 
oTotal_SL2 :=TRFunction():New(oSection3:Cell("SALDO"    ),NIL			,"ONPRINT"	,/*oBreak1*/,,/*cPicture*/,{|| F435Saldo( oSection2, "CALCENT2", "CALCSAI2", "SALDO" ) },.T.,.F. ,,oSection2)
 
oSection3:Cell("ENTRADA"  ):SetSize(30+len(STR0025))

If mv_par14 == 2
	oSection1:Cell("NNR_DESCRI"):Disable() 
	oSection3:Cell("D5LOCAL"):Disable()
EndIf

oReport:SetMeter(SB8->(LastRec()))
dbSelectArea(cAliasSB8)

While !oReport:Cancel() .And. !(cAliasSB8)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf

	oSection1:Init()

	cProduto := (cAliasSB8)->B8_PRODUTO
	cLote    := (cAliasSB8)->B8_LOTECTL
	cSubLote := (cAliasSB8)->B8_NUMLOTE
	cLocal   := (cAliasSB8)->B8_LOCAL
	
	nSldLote :=CalcEstL(cProduto,cLocal,mv_par10+1,(cAliasSB8)->B8_LOTECTL,If(Rastro(cProduto,"S"),(cAliasSB8)->B8_NUMLOTE,NIL))[If(mv_par13<>1,1,7)]
	
	If mv_par12 == 2 .AND. nSldLote <= 0
		(cAliasSB8)->(dbSkip())
		Loop
	EndIf
	
	lLoteZera:= If( mv_par12 == 1 , .T. , If( nSldLote == 0 , .F. , .T. ) )
    lProd    := AllTrim( cProdAnt) <> AllTrim( (cAliasSB8)->B8_PRODUTO )
	lLote 	 := .T.	
	lMovSD5  := .T.
	nRec     := 0
	
	dbSelectArea("SD5")
	If !dbSeek(cProduto + cLocal + cLote ,.T.)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se Lista Lote/Sub Sem Movimentos   ³
		//³ 1 = Lista          2 = Nao Lista		    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lLote   := If( mv_par11 == 1 , .T. , .F. )
		lMovSD5 := If( mv_par12 == 1 .And. lLote , .T. , .F. )

	ElseIf Rastro(cProduto,"S")

		lOkSublote:=.F.

		While !Eof() .And. SD5->D5_PRODUTO+SD5->D5_LOCAL+SD5->D5_LOTECTL == cProduto+cLocal+cLote
			If  SD5->D5_NUMLOTE == cSubLote
				lOkSublote:=.T.	
				Exit
			EndIf	
			dbSelectArea("SD5")
			dbSkip()
		EndDo
		If !lOkSubLote
			lLote   := If(mv_par11 == 1, .T. , .F. )
			lMovSD5 := If(mv_par12 == 1 .And. lLote , .T. , .F. )
		EndIf
	EndIf	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera no filtro o Lote/Sub com o Saldo Zerado ³
	//³ 1 = Lista          2 = Nao Lista		          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par12 == 2 .And. nSldLote == 0 .And. !lMovSD5
		dbSelectArea(cAliasSB8)
		dbSkip()
	EndIf
	
	dbSelectArea("SD5")
	If (lSeek:=MsSeek(cProduto+cLocal+cLote, .F.)) .Or. lLote

		If lProd .And. lLote .And. lLoteZera
			
			SB1->(dbSetOrder(1))
			SB1->(dbSeek(xFilial("SB1")+cProduto))

			If mv_par14 == 1
				SB2->(MsSeek(xFilial("SB2")+cProduto+cLocal)) 
			Endif

			oSection1:PrintLine()		

			lProd    := .F.
			cProdAnt := cProduto
		EndIf
		
		If lLote .And. lLoteZera

			oSection2:Init()

			If SB1->B1_RASTRO == "S"
				oSection2:Cell("B8_NUMLOTE"):Enable()
				oSection2:Cell("SP1"):SetSize(60-Len(STR0013)-Len(STR0014)-TamSX3("B8_NUMLOTE")[1]-TamSX3("B8_LOTECTL")[1],.F./*lPixel*/) //"Sub-Lote: "###"Lote: "
			ElseIf SB1->B1_RASTRO == "L"
	 			oSection2:Cell("B8_NUMLOTE"):Disable()
				oSection2:Cell("SP1"):SetSize(61-Len(STR0014)-TamSX3("B8_LOTECTL")[1],.F./*lPixel*/) //"Lote: "
			EndIf

			nSaldo:=CalcEstL(cProduto,cLocal,mv_par09,(cAliasSB8)->B8_LOTECTL,IF(Rastro(cProduto,"S"),(cAliasSB8)->B8_NUMLOTE,NIL))[If(mv_par13<>1,1,7)]
            nTotal+=nSaldo // armazena o total do produto
            
			oSection2:Cell("SALDO"):SetValue(nSaldo)
			oSection2:Cell("TOTAL"):SetValue(nTotal)
			nRec := 0
			
			oSection2:PrintLine()		

		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Zera os totais de cada Lote/SubLote   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nEntrada := nSaida := 0
		
		cCampo	:= "D5_PRODUTO+D5_LOTECTL"
		cCompara:=	D5_PRODUTO+D5_LOTECTL
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao dos Movimentos do Lote/Sub  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do While !Eof() .And. &(cCampo) == cCompara .And. lLoteZera

			oSection3:Init()

			If  SD5->D5_LOCAL <> cLocal .Or. (Rastro(cProduto,"S") .And.  SD5->D5_NUMLOTE <> cSubLote)
				dbSkip()
				Loop
			EndIf

			nSD5Quant := If(mv_par13 <> 1, SD5->D5_QUANT,SD5->D5_QTSEGUM)

			If SD5->D5_ORIGLAN <= "500" .Or. Substr( SD5->D5_ORIGLAN,1,2) $ "DE/PR" .Or. SD5->D5_ORIGLAN == "MAN"
				oSection3:Cell("ENTRADA"):SetValue(nSD5Quant)
				oSection3:Cell("SAIDA"  ):SetValue(0)
				nEntrada+=nSD5Quant
				nSaldo  +=nSD5Quant
			Elseif SD5->D5_ORIGLAN > "500" .Or. Substr(SD5->D5_ORIGLAN,1,2) == "RE"
				oSection3:Cell("SAIDA"  ):SetValue(nSD5Quant)
				oSection3:Cell("ENTRADA"):SetValue(0)
				nSaida  +=nSD5Quant
				nSaldo  -=nSD5Quant
			EndIf

			oSection3:Cell("SALDO"):SetValue(nSaldo)

			oSection3:PrintLine()
			
			nRec +=1
			dbSkip()
		EndDo
		
  		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| Lote Sem Movimentos ou movimentos fora do critério de data informado, coloca o saldo Inicial p/célula Entrada |
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nRec = 0         
			oSection3:Init()
			oSection3:Cell("ENTRADA"):SetValue(0)
			oSection3:Cell("SAIDA"):SetValue(0)
			oSection3:Hide()
			oSection3:PrintLine()  
			oSection3:Show()
		EndIf

		oSection3:Finish()

		If lLote .And. lLoteZera
			oTotal_EN1:HideHeader()
			oTotal_SA1:HideHeader()
			oTotal_SL1:HideHeader()

			oTotal_EN2:ShowHeader()
			oTotal_SA2:HideHeader()
			oTotal_SL2:HideHeader()

			oTotal_EN2:SetTitle(If(SB1->B1_RASTRO == "S" , STR0016 , STR0017 )) //"Total do Sub-Lote -> " # "Total do Lote -> "
			oSection2:Finish()
		Else
			lLote := .T.
		Endif
		
	EndIf

	dbSelectArea(cAliasSB8)
	If Rastro(cProduto,"L") 
		Do While !Eof() .And. cProduto + cLocal == (cAliasSB8)->B8_PRODUTO + (cAliasSB8)->B8_LOCAL
			If cLote <> (cAliasSB8)->B8_LOTECTL
				Exit
			EndIf
			dbSkip()
			If !( mv_par12 == 1 )
				While (cAliasSB8)->B8_SALDO == 0 .And. cProduto == (cAliasSB8)->B8_PRODUTO
					dbSkip()
					Loop
				EndDo
			EndIf
		EndDo
	Else
		dbSkip()
	EndIf

	If ( cProduto <> (cAliasSB8)->B8_PRODUTO .And. If( !( mv_par12 == 1 ) ,nSaldo > 0 , .T. ) ) .And. lSeek
 		oTotal_EN2:HideHeader()
 		oTotal_SA2:HideHeader()
 		oTotal_SL2:HideHeader()
		
		oTotal_EN1:ShowHeader()
		oTotal_SA1:HideHeader()
		oTotal_SL1:HideHeader()

		oTotal_EN1:SetTitle(STR0018)

		oSection1:Finish()		

		lProd  := .T.
		nTotal := 0
	Else                                           
   		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Quebrou o Produto e não possui movimentos de Entrada / Saídas no critério de data informado   ³
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cProduto <> (cAliasSB8)->B8_PRODUTO .And. nRec = 0 
	 		oTotal_EN2:HideHeader()
	 		oTotal_SA2:HideHeader()
	 		oTotal_SL2:HideHeader()
			
			oTotal_EN1:ShowHeader()
			oTotal_SA1:HideHeader()
			oTotal_SL1:HideHeader()
	
			oTotal_EN1:SetTitle(STR0018)

		    oSection1:Hide()
			oSection1:Finish()
	    	oSection1:Show()
	    	
			nTotal := 0
	  	EndIf
	EndIf
	
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve ordens originais da tabela e apaga indice de trabalho³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("SD5")
dbSelectArea("SD5")
dbSetOrder(1)
dbClearFilter()

If File(cWorkSD5+OrdBagExt())
	Ferase(cWorkSD5+OrdBagExt())
EndIf

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³F435Saldo ³ Autor ³ Norberto M de Melo    ³ Data ³03.09.2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Função de Cálculo e validação de conteúdo                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static	nVlrTotPrd	:= 0

Static Function F435Saldo( oSection, cObjEnt, cObjSai, cObjSal )
Local nRet	:= 0
Local lRet	:= (	ValType(oSection) == "O" .and.;
					ValType(cObjEnt) == "C"  .and.;
					ValType(cObjSai) == "C"  .and.;
					ValType(cObjSal) == "C" )
Local nEnt	:= 0
Local nSai	:= 0
Local nSal	:= 0


If lRet
	nEnt	:= oSection:GetFunction( cObjEnt ):GetLastValue()
	nSai	:= oSection:GetFunction( cObjSai ):GetLastValue()
	
	If ValType(oSection:Cell( cObjSal )) == "O"
		nSal		:= oSection:Cell( cObjSal ):GetValue()
		nVlrTotPrd += nSal
	Else
		nSal		:= nVlrTotPrd
		nVlrTotPrd	:= 0 
	EndIf
	
	nEnt	:= If( ValType( nEnt ) <> "N", 0 , nEnt )
	nSai	:= If( ValType( nSai ) <> "N", 0 , nSai )
	nSal	:= If( ValType( nSal ) <> "N", 0 , nSal )
	
	nRet := ( nEnt - nSai ) + nSal
EndIf

Return nRet

/*/{Protheus.doc} RetMovArg
//TODO Retorna o tipo de movimento de acordo com o numseq passado e buscando na SD3, SD2 e SD1, aplicado somente na Argentina
@author Leonardo Bratti
@since 28/03/2017
@version 1.0
@return cTpMov, Código do Tipo de Movimento
@param cNUMSEQ, characters, Numero de Sequencial da tabela SD5
@type function
/*/
Static Function RetMovArg(cNUMSEQ)
Local aAreaAnt	:= GetArea()
Local cTpMov 	:= "FAC"

dbSelectArea("SD3")
dbSetOrder(4) // D3_FILIAL+D3_NUMSEQ+D3_CHAVE+D3_COD
If dbSeek(xFilial("SD3")+cNUMSEQ)

	cTpMov :=  IIF(Empty(SD3->D3_CF), "FAC", SD3->D3_CF)			

Else

	dbSelectArea("SD1")
	dbSetOrder(4) // D1_FILIAL+D1_NUMSEQ
	If dbSeek(xFilial("SD1")+cNUMSEQ)
	
		cTpMov :=  IIF(Empty(SD1->D1_CF), "FAC" , SD1->D1_CF)			
	
	Else
		dbSelectArea("SD2")
		dbSetOrder(4) // D2_FILIAL+D2_NUMSEQ
		If dbSeek(xFilial("SD2")+cNUMSEQ)
		
			cTpMov :=  IIF(Empty(SD2->D2_CF), "FAC" , SD2->D2_CF)			
		
		EndIf
	EndIf	
EndIf

RestArea(aAreaAnt)

Return cTpMov