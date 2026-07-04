/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'MATR425.CH'
#INCLUDE 'PROTHEUS.CH'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR425  ³ Autor ³Alexandre Inacio Lemes ³ Data ³26/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Estoque por Lote                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR425(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr425()

Local oReport

oReport:= ReportDef()
oReport:PrintDialog()
               
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³26/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Estoque por Lote                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local aOrdem      := {STR0004,STR0005,STR0018}	//" Por Produto"###" Por Lote/Sub-Lote"###" Por Armazem"
Local cTitle      := STR0003 //"Posicao de Estoque por Lote/Sub-Lote"
Local cPicSaldo   := PesqPict("SB8","B8_SALDO"  ,18)
Local cPicEmpenho := PesqPict("SB8","B8_EMPENHO",18)
Local oReport 
Local oSection1
Local oSection2
Local cAliasSB8 := GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01        	// Do  Produto                          ³
//³ mv_par02        	// Ate Produto                          ³
//³ mv_par03        	// De  Lote                             ³
//³ mv_par04        	// Ate Lote			         		    ³
//³ mv_par05        	// De  Sub-Lote                         ³
//³ mv_par06        	// Ate Sub-Lote			         	  	³
//³ mv_par07        	// De  Local			        	    ³
//³ mv_par08        	// Ate Local				            ³
//³ mv_par09        	// Lista Saldo Zerado ? Lista/Nao Lista ³
//³ mv_par10        	// Do Tipo  				            ³
//³ mv_par11        	// Ate o Tipo  			                ³
//³ mv_par12        	// Do Grupo 				            ³
//³ mv_par13        	// Ate o Grupo		                    ³
//³ mv_par14        	// QTDE na 2a.U.M. ?	                ³
//| mv_par15			// Imprime descricao do Armazem ?       |
//| mv_par16			// Da Data de Validade ?	 		    |
//| mv_par17			// Ate a Data de Validade ? 			|
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MR425A",.F.)
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
oReport:= TReport():New("MTR425",cTitle,"MR425A", {|oReport| ReportPrint(oReport,aOrdem,cAliasSB8)},STR0001+" "+STR0002) //"Este programa emitira' uma relacao com a posi‡„o de estoque por Lote/Sub-Lote."
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
oSection1:= TRSection():New(oReport,STR0028,{"SB8","SB1","SB2","NNR"},aOrdem) //"Saldos por Lote"
oSection1:SetTotalInLine(.F.)
oSection1:SetHeaderPage()
 
TRCell():New(oSection1,"B8_NUMLOTE","SB8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B8_LOTECTL","SB8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B8_PRODUTO","SB8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"SUBLOTE"   ,"   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"LOTE"      ,"   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B8_LOCAL"  ,"SB8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"SALDO1"    ,"   ",STR0024+CRLF+STR0026,cPicSaldo  ,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,"EMPENHO1"  ,"   ",STR0025+CRLF+STR0026,cPicEmpenho,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,"SALDO2"    ,"   ",STR0024+CRLF+STR0027,cPicSaldo  ,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,"EMPENHO2"  ,"   ",STR0025+CRLF+STR0027,cPicEmpenho,18,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,"B8_DATA"   ,"SB8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B8_DTVALID","SB8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"NNR_DESCRI","NNR",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
                                                                                                                         
oSection1:Cell("SUBLOTE"):GetFieldInfo("B8_NUMLOTE")
oSection1:Cell("LOTE"):GetFieldInfo("B8_LOTECTL")

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³26/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Estoque por Lote                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem,cAliasSB8)

Local oSection1  := oReport:Section(1) 
Local oSection2  := oReport:Section(1):Section(1)  
Local nOrdem     := oReport:Section(1):GetOrder()
Local cOrdem     := ""
Local cIndexKey  := ""
Local cCondicao  := ""
Local cLoteAnt   := ""
Local cProdAnt   := ""
Local cDescAnt   := ""
Local cSLotAnt   := ""
Local cAlmoAnt   := ""
Local cSeekSB8   := ""
Local cCondSB8   := ""
Local cDescArm   := ""
Local dDataAnt   := CtoD("  /  /  ")
Local dValiAnt   := CtoD("  /  /  ")
Local nSaldo     := 0
Local nEmpenho   := 0
Local nSaldo2    := 0
Local nEmpenho2  := 0
Local lPrinted   := .F.
Local lSubLote   := .F.
Local lEmpPrev   := If(SuperGetMV("MV_QTDPREV")== "S",.T.,.F.)     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " ("+AllTrim(aOrdem[nOrdem])+") ")

dbSelectArea('SB1')
dbSetOrder(1)

dbSelectArea("SB8")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)  
oReport:Section(1):BeginQuery()	

If nOrdem == 1
	cOrdem := "% B8_FILIAL,B8_PRODUTO,B8_LOCAL,B8_LOTECTL,B8_NUMLOTE %"
ElseIf nOrdem == 2
	cOrdem := "% B8_FILIAL,B8_LOTECTL,B8_NUMLOTE,B8_PRODUTO,B8_LOCAL %"
ElseIf nOrdem == 3
	cOrdem := "% B8_FILIAL,B8_LOCAL,B8_LOTECTL,B8_NUMLOTE,B8_PRODUTO %"
EndIf

BeginSql Alias cAliasSB8
		
SELECT SB8.*,SB8.R_E_C_N_O_ AS SB8Recno

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
      B8_DTVALID  >= %Exp:Dtos(mv_par16)% AND 
      B8_DTVALID  <= %Exp:Dtos(mv_par17)% AND 
      SB8.%NotDel% 

ORDER BY %Exp:cOrdem%
				
EndSql 

    oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desabilita Celulas conforme Parametros e Ordens Selecionadas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1 .Or. nOrdem == 3
	 oSection1:Cell("B8_NUMLOTE"):Disable()
	 oSection1:Cell("B8_LOTECTL"):Disable()
ElseIf nOrdem == 2
	 oSection1:Cell("SUBLOTE"):Disable()
	 oSection1:Cell("LOTE"):Disable()
EndIf

If mv_par15 == 2
	 oSection1:Cell("NNR_DESCRI"):Disable()
EndIf

If mv_par14 == 2
	 oSection1:Cell("SALDO2"):Disable()
	 oSection1:Cell("EMPENHO2"):Disable()
Else
	TRFunction():New(oSection1:Cell("SALDO2"  ),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1) 
	TRFunction():New(oSection1:Cell("EMPENHO2"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1) 
EndIf

TRFunction():New(oSection1:Cell("SALDO1"  ),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1)
TRFunction():New(oSection1:Cell("EMPENHO1"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1) 


oReport:SetMeter(SB8->(LastRec()))
dbSelectArea(cAliasSB8)

While !oReport:Cancel() .And. !(cAliasSB8)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf

	lSubLote := Rastro(B8_PRODUTO,"S")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a Quebra por Produto ou Lote                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOrdem == 1
		cSeekSB8 := B8_FILIAL+B8_PRODUTO+B8_LOCAL
		cCondSB8 := 'B8_FILIAL+B8_PRODUTO+B8_LOCAL'
	ElseIf nOrdem == 2
		cSeekSB8 := B8_FILIAL+B8_LOTECTL+If(lSubLote,B8_NUMLOTE,'')+B8_PRODUTO+B8_LOCAL
		cCondSB8 := 'B8_FILIAL+B8_LOTECTL+'+If(lSubLote,'B8_NUMLOTE+','')+'B8_PRODUTO+B8_LOCAL'
	ElseIf nOrdem == 3
		cSeekSB8 := B8_FILIAL+B8_LOCAL+B8_PRODUTO
		cCondSB8 := 'B8_FILIAL+B8_LOCAL+B8_PRODUTO'
	EndIf

	nSaldo    := 0
	nEmpenho  := 0
	nSaldo2   := 0
	nEmpenho2 := 0
	
	oSection1:Init()

	While !oReport:Cancel() .And. !(cAliasSB8)->(Eof()) .And. cSeekSB8 == &(cCondSB8)

		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Posiciona-se na Descricao Correta do SB1                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !(cProdAnt==B8_PRODUTO)
			SB1->(dbSeek(xFilial("SB1") + (cAliasSB8)->B8_PRODUTO, .F.))
		EndIf	
		
		If SB1->B1_TIPO < mv_par10 .Or. SB1->B1_TIPO > mv_par11 .Or. SB1->B1_GRUPO < mv_par12 .Or. SB1->B1_GRUPO > mv_par13
			dbSkip()
			Loop
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Saldo do Lote ou Lote/Sublote                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nSaldo   += SB8SALDO(,,,,cAliasSB8,lEmpPrev,,,.T.)
		nEmpenho += SB8SALDO(.T.,,,,cAliasSB8,lEmpPrev,,,.T.)
		nSaldo2  += SB8SALDO(,,,.T.,cAliasSB8,lEmpPrev,,,.T.) // Quando passado .T. no 4o. Parametro a funcao retorna a 2a. UM.
		nEmpenho2+= SB8SALDO(.T.,,,.T.,cAliasSB8,lEmpPrev,,,.T.)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Salva Dados do Registro Atual / Passa para o Pr¢ximo Registro ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cProdAnt := B8_PRODUTO
		cDescAnt := SB1->B1_DESC
		cSLotAnt := If(lSubLote,B8_NUMLOTE,Space(Len(B8_NUMLOTE)))
		cLoteAnt := B8_LOTECTL
		cAlmoAnt := B8_LOCAL
		dDataAnt := B8_DATA
		dValiAnt := B8_DTVALID
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³posiciona SB2 para impressao de campos adicionados pelo usuario ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB2->(MsSeek(xFilial("SB2")+cProdAnt+cAlmoAnt)) 

		If mv_par15 == 1
			cDescArm := ""
			NNR->(dbSetOrder(1))
			If NNR->(MsSeek(xFilial("NNR")+cAlmoAnt)) .And. !Empty(NNR->NNR_DESCRI)
				cDescArm := NNR->NNR_DESCRI
			EndIf
		EndIf	
		nRecno := (cAliasSB8)->SB8Recno
		dbSkip()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime Saldo do Lote ou Lote/Sublote                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !(cSeekSB8 == &(cCondSB8)) .Or. lSubLote .Or. !(cLoteAnt == B8_LOTECTL)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se Lista Saldo Zerado                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            If mv_par09 == 2 .And. QtdComp(nSaldo) == QtdComp(0)
				Loop
			EndIf
			
			lPrinted := .T.

			oSection1:Cell("B8_NUMLOTE"):SetValue(cSLotAnt)
			oSection1:Cell("B8_LOTECTL"):SetValue(cLoteAnt)
			oSection1:Cell("B8_PRODUTO"):SetValue(cProdAnt)
			oSection1:Cell("B1_DESC"):SetValue(cDescAnt)
			oSection1:Cell("SUBLOTE"):SetValue(cSLotAnt)
			oSection1:Cell("LOTE"):SetValue(cLoteAnt)
			oSection1:Cell("B8_LOCAL"):SetValue(cAlmoAnt)
			oSection1:Cell("SALDO1"):SetValue(nSaldo)
			oSection1:Cell("EMPENHO1"):SetValue(nEmpenho)
			oSection1:Cell("SALDO2"):SetValue(nSaldo2)
			oSection1:Cell("EMPENHO2"):SetValue(nEmpenho2)
			oSection1:Cell("B8_DATA"):SetValue(dDataAnt)
			oSection1:Cell("B8_DTVALID"):SetValue(dValiAnt)
			oSection1:Cell("NNR_DESCRI"):SetValue(cDescArm)
            
        	SB8->(dbGoTo(nRecno))
			oSection1:CALIAS:="SB8"
			oSection1:PrintLine()		
			oSection1:CALIAS:=cAliasSB8
					
			nSaldo   := 0
			nEmpenho := 0
			nSaldo2  := 0
			nEmpenho2:= 0
	
		EndIf

	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime Totalizador                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lPrinted
		oSection1 :SetTotalText(If(nOrdem == 1, STR0013 , If(lSubLote , STR0016 , STR0015 ))) //"Total do Produto ->"###"Total do Lote ->"###'Total do Lote/SubLote ->'
		oSection1:Finish()
		lPrinted := .F.
	EndIf

EndDo

Return Nil

/*/
{Protheus.doc} SchedDef
	Funcao Responsavel por definir informacoes para Execu??o do Relatorio via Schedule
	@type  Static Function
	@param param, param_type, param_descr
	@return return, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
/*/


Static Function SchedDef()
Local aParam := Nil
local aOrdem := {OemToAnsi(STR0004),OemToAnsi(STR0005),OemToAnsi(STR0018)} 

aParam := { "R", "MR425A" , "SB8" , aOrdem, OemToAnsi(Replace(STR0003,"/"," ")) }    

Return aParam
