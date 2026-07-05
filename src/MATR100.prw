/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MATR100.ch"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR100  ³ Autor ³ Nereu Humberto Junior ³ Data ³ 06.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao das Solicitacoes de Compras                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR100
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³06.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport 
Local oSection1
Local oCell         
Local aOrdem := {}

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
oReport:= TReport():New("MATR100",STR0005,"MTR100", {|oReport| ReportPrint(oReport)},STR0001+" "+STR0002) //"Relacao de Solicitacoes de Compras"##"Emite um relacao para controle das solicitacoes cadastradas ,"##"seus respectivos pedidos e prazos de entrega."
oReport:SetLandscape()    
oReport:SetTotalInLine(.F.)
oReport:SetUseGC(.F.)

Pergunte("MTR100",.F.)
Aadd( aOrdem, STR0003 ) //" Por Solicitacao    "
Aadd( aOrdem, STR0004 ) //" Por Produto        "

oSection1 := TRSection():New(oReport,STR0022,{"SC1","SB1","SC7","SA2"},aOrdem) //"Relacao de Solicitacoes de Compras"
oSection1:SetTotalInLine(.F.)
oSection1:SetHeaderPage()
oSection1:SetNoFilter("SB1")
oSection1:SetNoFilter("SC7")
oSection1:SetNoFilter("SA2")

TRCell():New(oSection1,"C1_NUM"		,"SC1",STR0024+CRLF+STR0025/*Titulo*/	,/*Picture*/,TamSX3("C1_NUM")[1]+2,/*lPixel*/,/*{|| code-block de impressao }*/) // "Numero"##"SC"
TRCell():New(oSection1,"C1_ITEM"	,"SC1",STR0026+CRLF+STR0025/*Titulo*/	,/*Picture*/,TamSX3("C1_ITEM")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/) // "Item"##"SC"
TRCell():New(oSection1,"C1_PRODUTO"	,"SC1",/*Titulo*/						,/*Picture*/,TamSX3("C1_PRODUTO")[1]+17,/*lPixel*/,/*{|| code-block de impressao }*/,/**/, /**/, /**/, /**/, /**/,.F.)
TRCell():New(oSection1,"C1_DESCRI"	,"SC1",/*Titulo*/						,/*Picture*/,40			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_TIPO"	,"SB1",STR0027/*Titulo*/				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Tp"
TRCell():New(oSection1,"B1_GRUPO"	,"SB1",/*Titulo*/						,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"C1_QUANT"	,"SC1",/*Titulo*/						,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"C1_UM"		,"SC1",STR0028/*Titulo*/				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"UM"
TRCell():New(oSection1,"C1_CC"		,"SC1",/*Titulo*/						,/*Picture*/,20			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"C1_EMISSAO"	,"SC1",STR0029+CRLF+STR0030/*Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Emissao"
TRCell():New(oSection1,"C1_DATPRF"	,"SC1",STR0031+CRLF+STR0025/*Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Entrega"##"SC"
TRCell():New(oSection1,"C1_SOLICIT"	,"SC1",/*Titulo*/						,/*Picture*/,9			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"dDtPrazo"	,"   ",STR0019+CRLF+STR0023,/*Picture*/	,TamSX3("C1_DATPRF")[1]+3,/*lPixel*/	,{||SomaPrazo(SC1->C1_DATPRF, - CalcPrazo(SC1->C1_PRODUTO,SC1->C1_QUANT))}) //"Dt.Limite"##"de Compra"
TRCell():New(oSection1,"nSaldo"		,"   ",STR0020,/*Picture*/,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/) //"Saldo SC"

TRCell():New(oSection1,"C7_NUM"		,"SC7",STR0032+CRLF+STR0033/*Titulo*/	,/*Picture*/,TamSX3("C7_NUM")[1]+2,/*lPixel*/,/*{|| code-block de impressao }*/) //"Numero"##"PC"
TRCell():New(oSection1,"C7_FORNECE"	,"SC7",STR0034+CRLF+STR0033				,/*Picture*/,TamSX3("C7_FORNECE")[1]+2,/*lPixel*/,/*{|| code-block de impressao }*/) //"Fornec."##"PC"
TRCell():New(oSection1,"C7_LOJA"	,"SC7",STR0035+CRLF+STR0033,/*Picture*/	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Lj"##"PC"

TRCell():New(oSection1,"C1_FORNECE"	,"SC1",STR0034+CRLF+STR0025,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Fornec."##"SC"
TRCell():New(oSection1,"C1_LOJA"	,"SC1",STR0035+CRLF+STR0025,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	

TRCell():New(oSection1,"A2_NOME"	,"SA2",AllTrim(RetTitle("A2_NOME")),/*Picture*/,TamSX3("A2_NOME")[1],/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New(oSection1,"C7_EMISSAO"	,"SC7",STR0030+CRLF+STR0033,/*Picture*/,TamSX3("C7_EMISSAO")[1]+20,/*lPixel*/,/*{|| code-block de impressao }*/) //"Emissao"##"PC"

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³06.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local oSection1 := oReport:Section(1) 
Local nOrdem    := oReport:Section(1):GetOrder() 
Local lFirst    := .T.
Local lCotacao  := .F.
Local lPedido   := .F.
Local cNum      := "" 
Local cCotacao  := ""
Local oBreak
Local aIndex	:= {}
Local aArea 	:= {}

If nOrdem == 1
	oBreak := TRBreak():New(oSection1,oSection1:Cell("C1_NUM"),STR0015,.F.) //"Total  -  "
ElseIf nOrdem == 2
	oBreak := TRBreak():New(oSection1,oSection1:Cell("C1_PRODUTO"),STR0015,.F.) //"Total  -  "
Endif
TRFunction():New(oSection1:Cell("C1_QUANT"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.F.) 
TRFunction():New(oSection1:Cell("nSaldo"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.F.) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR06 == 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Abre o SC7 em outra area para criar uma nova IndRegua        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SC7")  // ChkFile() precisa da tabela (SC7) criada
	ChkFile('SC7',.F.,'TMP')
	aADD(aIndex,CriaTrab(NIL,.F.))
	IndRegua("TMP",aIndex[Len(aIndex)],"C7_FILIAL+C7_NUMCOT+C7_PRODUTO")
	dbSelectArea("SC7")
	aADD(aIndex,CriaTrab(NIL,.F.))
	IndRegua("SC7",aIndex[Len(aIndex)],"C7_FILIAL+C7_NUMSC+C7_ITEMSC+C7_PRODUTO")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Condição criada para não exibir os campos em Excel, formato tabela  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR06 == 1
		oSection1:Cell("C1_FORNECE"):Disable()
		oSection1:Cell("C1_LOJA"):Disable()
Else
		oSection1:Cell("C7_FORNECE"):Disable()
		oSection1:Cell("C7_LOJA"):Disable()
		oSection1:Cell("C7_EMISSAO"):Disable()
		oSection1:Cell("C7_NUM"):Disable()
		oSection1:Cell("A2_NOME"):Disable()
Endif	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se o usuario escolher a opcao que lista as SC's canceladas   ³
//³ pelo sistema ,e' necessario ativar as deletadas.             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR03 == 3
	SET DELE OFF
Endif

oReport:SetMeter(SC1->(LastRec()))

oSection1:Init()

dbSelectArea("SC1")
dbSetOrder(nOrdem)
If nOrdem == 1
	dbSeek(xFilial("SC1")+MV_PAR01,.T.)
Else
	dbSeek(xFilial("SC1"))
EndIf
While !oReport:Cancel() .And. SC1->(!Eof()) .And. SC1->C1_FILIAL == xFilial() .And.;
	IIf(nOrdem==1,C1_NUM <= MV_PAR02,.T.)

	If oReport:Cancel()
		Exit
	EndIf
	
	oReport:IncMeter()

	cNum := SC1->C1_NUM
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra as solicitacoes maior que o numero definido           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If C1_NUM < mv_par01 .Or. C1_NUM > mv_par02
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra as solicitacoes cancelados pelo sistema               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par03 == 3 .And. !Deleted() .Or. (STR0021$C1_OBS) //"CANCELADA PELO SISTEMA."
		dbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra as solicitacoes de importacao                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par08 == 2 .And. ;
			(!Empty(C1_COTACAO) .And. (C1_COTACAO == "IMPORT" .Or. C1_COTACAO == "IMPORX"))
		dbSkip()
		Loop
	Endif
				
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra as solicitacoes em aberto gerada cotacao ou pedido    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par03 == 2
		If (C1_QUANT <= C1_QUJE  .Or. (!Empty(C1_COTACAO) .And. (C1_COTACAO <> "IMPORT" .And. C1_COTACAO <> "IMPORX" .AND. C1_COTACAO <> "XXXXXX"));
		 .Or. !Empty(C1_RESIDUO) .Or. !Empty(C1_PEDIDO)) .Or. C1_APROV == "R"
			dbSkip()
			Loop
		EndIf
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra as solicitacoes completamente atendidas               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par03 == 5 .And. C1_QUANT == C1_QUJE
		dbSkip()
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra as pendentes          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par03 == 5 .And. !Empty(C1_RESIDUO)
		dbSkip()
		Loop
	Endif	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica intervalo de data de emissao                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (C1_EMISSAO < mv_par04 .Or. C1_EMISSAO > mv_par05)
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra as solicitacoes nao entregue                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par03 == 4
		aArea  := SC7->(GetArea())
		If !Empty(C1_COTACAO) .And. C1_COTACAO <> "XXXXXX"
			nRegSC1 := SC1->(RecNo())
			nOrdSC1 := SC1->( IndexOrd()) 
            cCotSC1 := SC1->C1_COTACAO
            cProSC1 := SC1->C1_PRODUTO
            cItPSC1 := SC1->C1_ITEMPED 
			nQtdSC1 := 0
            nQtdSC7 := 0
            lPedido := .F. 
			dbSelectArea("SC7")
			dbSetOrder(2)
			dbSeek(xFilial("SC7")+SC1->C1_PRODUTO)
			While !Eof() .And. xFilial("SC7")+cProSC1 == C7_FILIAL+C7_PRODUTO
				If SC7->C7_NUMCOT == cCotSC1 .And. SC7->C7_ITEM == cItPSC1             
					lPedido := .T.	 
					nQtdSC7 += If(SC7->C7_RESIDUO == "S",SC7->C7_QUANT,SC7->C7_QUJE)

					dbSelectArea("SC8")
					dbSetOrder(3)
					MsSeek(xFilial("SC8")+SC7->C7_NUMCOT+SC7->C7_PRODUTO+SC7->C7_FORNECE+SC7->C7_LOJA+SC7->C7_NUM+SC7->C7_ITEM)

					dbSelectArea("SC1")
					dbSetOrder(5)
					MsSeek(xFilial("SC1")+SC8->C8_NUM+SC8->C8_PRODUTO+SC8->C8_IDENT)						
					While ( !Eof() .And. xFilial("SC1") == SC1->C1_FILIAL .And. SC8->C8_NUM == SC1->C1_COTACAO .And.;
							          SC8->C8_PRODUTO == SC1->C1_PRODUTO .And. SC8->C8_IDENT == SC1->C1_IDENT .And. ;
							          SC8->C8_NUMPED == SC1->C1_PEDIDO .And. SC8->C8_ITEMPED == SC1->C1_ITEMPED )
						nQtdSC1 += SC1->C1_QUANT
						dbSelectArea("SC1")
						dbSkip()
                    EndDo 
				Endif
				dbSelectArea("SC7")
				dbSkip()
			EndDo

			dbSelectArea("SC1")
			dbSetOrder(nOrdSC1)
			MsGoto(nRegSC1)

            If lPedido	 	
				nSldEntre := nQtdSC1 - nQtdSC7				
            Else 
				nSldEntre := SC1->C1_QUANT				
            EndIf 

		Else
			nSldEntre := SC1->C1_QUANT
			dbSelectArea("SC7")
			dbSetOrder(2)
			dbSeek(xFilial("SC7")+SC1->C1_PRODUTO)
			While !Eof() .And. xFilial( "SC7" ) +SC1->C1_PRODUTO == C7_FILIAL+C7_PRODUTO
				If C7_NUMSC == SC1->C1_NUM .And. C7_ITEMSC == SC1->C1_ITEM
					nSldEntre -= If(SC7->C7_RESIDUO == "S",SC7->C7_QUANT,SC7->C7_QUJE)
				Endif
				dbSelectArea("SC7")
				dbSkip()
			EndDo
		Endif
		
		If nSldEntre <= 0
			dbSelectArea("SC1")
			dbSkip()
			Loop
		Endif
		RestArea(aArea)

	Endif

	dbSelectArea("SC1")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !MtrAValOP(mv_par07, 'SC1')
		dbSkip()
		Loop
	EndIf

	dbSelectArea("SB1")
	dbSetOrder(1)
	dbSeek(xFilial("SB1")+SC1->C1_PRODUTO)		

	If MV_PAR06 == 1
                                       		
		If Empty(SC1->C1_COTACAO) .Or. SC1->C1_COTACAO == "XXXXXX" .Or. SC1->C1_COTACAO == "IMPORX" .Or. SC1->C1_COTACAO == "IMPORT" 
			lFirst := .T.
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona no arquivo de produtos                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek(xFilial("SB1")+SC1->C1_PRODUTO)		
			
			cAliasSC7 := "SC7"
			dbSelectArea("SC7")
			If dbSeek(xFilial()+SC1->C1_NUM+SC1->C1_ITEM+SC1->C1_PRODUTO)
				aProdAux:= {}
				While !Eof() .and. C7_FILIAL+C7_NUMSC+C7_ITEMSC == xFilial("SC7")+SC1->C1_NUM+SC1->C1_ITEM
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !MtrAValOP(mv_par07, "SC7" )
						dbSkip()
						Loop
					EndIf
					nPos:= aScan(aProdAux,{|x| x==C7_PRODUTO+C7_NUM})
					if nPos>0 //se já printou este produto para este pedido, não imprime mais
						dbSkip()
						Loop
					else
						aAdd(aProdAux,C7_PRODUTO+C7_NUM)
					endif
					
					dbSelectArea("SA2")
					dbSeek(xFilial("SA2")+(cAliasSC7)->C7_FORNECE+(cAliasSC7)->C7_LOJA)
				
					oSection1:Cell("C7_NUM"):SetValue((cAliasSC7)->C7_NUM)
					oSection1:Cell("C7_FORNECE"):SetValue((cAliasSC7)->C7_FORNECE)
					oSection1:Cell("C7_LOJA"):SetValue((cAliasSC7)->C7_LOJA)
					oSection1:Cell("C7_EMISSAO"):SetValue((cAliasSC7)->C7_EMISSAO)
					
					U_ImprimeSC(lFirst,0,@oSection1)
					
					If lFirst 
					   lFirst := .F.
					EndIf

					dbSelectArea(cAliasSC7)
					dbSkip()
				EndDo
				dbSelectArea("SC7")
			Else
	    		U_ImprimeSC(.T.,1,@oSection1)
			EndIf
		Else
			lFirst := .T.
			dbSelectArea("TMP")
			If dbSeek(xFilial('SC7')+SC1->C1_COTACAO+SC1->C1_PRODUTO)
				lCotacao  := .T.
				aProdAux:= {}
				While !Eof() .And. TMP->C7_FILIAL+TMP->C7_NUMCOT+TMP->C7_PRODUTO  == xFilial('SC7')+SC1->C1_COTACAO+SC1->C1_PRODUTO
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !MtrAValOP(mv_par07, 'SC7')
						dbSkip()
						Loop
					EndIf
					nPos:= aScan(aProdAux,{|x| x==C7_PRODUTO+C7_NUM})
					if nPos > 0 //se já printou este produto deste pedido, não imprime mais
						dbSkip()
						Loop
					else
						aAdd(aProdAux,C7_PRODUTO+C7_NUM)
					endif
					
					dbSelectArea("SA2")
					dbSeek(xFilial()+TMP->C7_FORNECE+TMP->C7_LOJA)
					
					oSection1:Cell("C7_NUM"):SetValue(TMP->C7_NUM)
					oSection1:Cell("C7_FORNECE"):SetValue(TMP->C7_FORNECE)
					oSection1:Cell("C7_LOJA"):SetValue(TMP->C7_LOJA)
					oSection1:Cell("C7_EMISSAO"):SetValue(TMP->C7_EMISSAO)
					
					If lFirst 
						U_ImprimeSC(lFirst,0,@oSection1)
						lFirst := .F.
					Else
						U_ImprimeSC(lFirst,0,@oSection1)
                    Endif

					dbSelectArea("TMP")
					dbSkip()
				EndDo
			Else
				lCotacao  := .F.
				U_ImprimeSc(.T.,1,@oSection1)
			EndIf
		EndIf
	Else    
			
	    dbSelectArea("SA2")
	    dbSeek(xFilial()+SC1->C1_FORNECE+SC1->C1_LOJA)
	    dbSelectArea("SC1")
		oSection1:Cell("C1_QUANT"):SetValue(SC1->C1_QUANT)
		oSection1:Cell("nSaldo"):SetValue(SC1->C1_QUANT-SC1->C1_QUJE)
			
		cAliasSC7 := "SC7"
		dbSelectArea("SC7")
		dbSeek(xFilial()+SC1->C1_NUM+SC1->C1_ITEM+SC1->C1_PRODUTO)
		
		U_ImprimeSc(.T.,1,@oSection1)
	EndIf
	cCotacao := IIF(!Empty(SC1->C1_COTACAO) .And. SC1->C1_COTACAO <> "XXXXXX" .And. lCotacao,SC1->C1_COTACAO,"")
	dbSelectArea("SC1")
	dbSkip()
	If SC1->C1_NUM <> cNum .And. !Empty(cCotacao)
		oReport:PrintText(STR0016+cCotacao,,oSection1:Cell('C7_NUM'):ColPos())
	Endif	
EndDo

If MV_PAR03 == 3
	SET DELE ON
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Deleta Arquivo Temporario e Restaura os Indices Nativos.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC7")
RetIndex("SC7")
dbSelectArea("SC1")
Set Filter To
RetIndex("SC1")
dbSetOrder(1)
If ( Select("TMP")<>0 )
	dbSelectArea("TMP")
	dbCloseArea()
	dbSelectArea("SC7")
EndIf
oSection1:Finish()

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImprimeSC³ Autor ³ Julio C.Guerato³ Data ³27/05/2009 |     |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Dados da SC na versão R4                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±   
±±³Parametros³ lImp:  Parâmetro para indicar como será setada a impressa  ³±±
±±³          ³ nTipo: 0 = Detalhe  / 1 = Totalizacao                      ³±± 
±±³          ³ oSection1: Objeto Impressao                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR100			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function ImprimeSC(lAtiva,nTipo,oSection1)

If lAtiva 
	oSection1:Cell("C1_NUM"):Show()
	oSection1:Cell("C1_ITEM"):Show()
	oSection1:Cell("C1_PRODUTO"):Show()
	oSection1:Cell("C1_DESCRI"):Show()
	oSection1:Cell("B1_TIPO"):Show()
	oSection1:Cell("B1_GRUPO"):Show()
	oSection1:Cell("C1_QUANT"):Show()
	oSection1:Cell("C1_UM"):Show()
	oSection1:Cell("C1_CC"):Show()
	oSection1:Cell("C1_EMISSAO"):Show()
	oSection1:Cell("C1_DATPRF"):Show()
	oSection1:Cell("C1_SOLICIT"):Show()
	oSection1:Cell("dDtPrazo"):Show()
	oSection1:Cell("nSaldo"):Show()
else
	oSection1:Cell("C1_NUM"):Hide()
	oSection1:Cell("C1_ITEM"):Hide()
	oSection1:Cell("C1_PRODUTO"):Hide()
	oSection1:Cell("C1_DESCRI"):Hide()
	oSection1:Cell("B1_TIPO"):Hide()
	oSection1:Cell("B1_GRUPO"):Hide()
	oSection1:Cell("C1_QUANT"):Hide()
	oSection1:Cell("C1_UM"):Hide()
	oSection1:Cell("C1_CC"):Hide()
	oSection1:Cell("C1_EMISSAO"):Hide()
	oSection1:Cell("C1_DATPRF"):Hide()
	oSection1:Cell("C1_SOLICIT"):Hide()
	oSection1:Cell("dDtPrazo"):Hide()
	oSection1:Cell("nSaldo"):Hide()
EndIf


Do Case
    Case nTipo == 0 
		If lAtiva
			oSection1:Cell("C1_QUANT"):SetValue(SC1->C1_QUANT)
			oSection1:Cell("nSaldo"):SetValue(SC1->C1_QUANT-SC1->C1_QUJE)
			oSection1:PrintLine()
		Else	
			oSection1:Cell("C1_QUANT"):SetValue(0)
			oSection1:Cell("nSaldo"):SetValue(0)
			oSection1:PrintLine()
		Endif	
    
    Case nTipo == 1
	    If lAtiva
   			oSection1:Cell("C7_NUM"):Hide()
			oSection1:Cell("C7_FORNECE"):Hide()				
			oSection1:Cell("C7_LOJA"):Hide()
			oSection1:Cell("A2_NOME"):Hide()
			oSection1:Cell("C7_EMISSAO"):Hide()
			
			oSection1:Cell("C1_QUANT"):SetValue(SC1->C1_QUANT)
			oSection1:Cell("nSaldo"):SetValue(SC1->C1_QUANT-SC1->C1_QUJE)

			oSection1:PrintLine()
				
			oSection1:Cell("C7_NUM"):Show()
			oSection1:Cell("C7_FORNECE"):Show()
			oSection1:Cell("C7_LOJA"):Show()
			oSection1:Cell("A2_NOME"):Show()
			oSection1:Cell("C7_EMISSAO"):Show()
		EndIf
EndCase

Return 

