/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR175.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR175  ³ Autor ³Alexandre Inacio Lemes ³ Data ³28/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao das Baixas do Controle de Qualidade                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR175(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR175()

Local oReport

oReport:= ReportDef()
oReport:PrintDialog()
                                               
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³28/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao das Baixas do Controle de Qualidade                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local aOrdem   := {STR0003,STR0004}		//" Por Numero    "###" Por Produto        "
Local cTitle   := STR0005	            //"Relacao de Baixas do CQ" 
Local oReport 
Local oSection1
Local oSection2
Local cAliasSD7 := GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//³mv_par01             // a partir do numero                    ³
//³mv_par02             // ate o numero                          ³
//³mv_par03             // Liberados/Rejeitados/Todos            ³
//³mv_par04             // Imprime estornados Sim/Nao            ³
//³mv_par05             // Data emissao inicial                  ³
//³mv_par06             // Data emissao final                    ³
//³mv_par07             // Fornecedor De                         ³
//³mv_par08             // Fornecedor Ate                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR175",.F.)
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

oReport:= TReport():New("MTR175",cTitle,"MTR175", {|oReport| ReportPrint(oReport,aOrdem,cAliasSD7)},STR0001+" "+STR0002) //"Emite um relacao dos produto Liberados/Rejeitados pelo Controle de qualidade juntamente com a respectiva avaliacao."
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
oSection1:= TRSection():New(oReport,STR0037,{"SD7","SB1"},aOrdem)
oSection1:SetHeaderPage()

TRCell():New(oSection1,"D7_NUMERO" ,"SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D7_PRODUTO","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_UM"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D7_LOCAL"  ,"SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D7_DOC"    ,"SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D7_ORIGLAN","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D7_FORNECE","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection2:= TRSection():New(oSection1,STR0038,{"SD7","SB1"}) 
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage()

TRCell():New(oSection2,"D7_NUMERO" ,"SD7",/*Titulo*/	,/*Picture*/				,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D7_DATA"   ,"SD7",/*Titulo*/	,/*Picture*/				,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"TIPO"      ,"   ",STR0032		,/*Picture*/				,13						,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"QUANTIDADE","   ",STR0033		,PesqPictQt("D7_QTDE",17)	,TamSX3("D7_QTDE")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D7_USUARIO","SD7",/*Titulo*/	,/*Picture*/				,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"AVALIACAO" ,"   ",STR0034		,/*Picture*/				,26						,/*lPixel*/,{|| cTexto })
TRCell():New(oSection2,"D7_DOC"    ,"SD7",/*Titulo*/	,/*Picture*/				,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D7_LOCDEST","SD7",/*Titulo*/	,/*Picture*/				,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"D7_MOTREJE","SD7",STR0035		,/*PicSture*/				,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"X5_DESCRI" ,"SX5",STR0036		,/*Picture*/				,/*Tamanho*/			,/*lPixel*/,{|| If( !Empty((cAliasSD7)->D7_MOTREJE) , " - " + Left(X5Descri(),20) , "" ) })

oSection2:Cell("AVALIACAO"):SetLineBreak() 

If !__lPyme
	TRCell():New(oSection2,"D7_LOTECTL","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"D7_NUMLOTE","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Endif

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³28/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao das Baixas do Controle de Qualidade                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³ExpA1: Array com as Ordens do relatorio                     ³±±
±±³          ³ExpC1: Alias do arquivo					                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem,cAliasSD7)

Local oSection1  := oReport:Section(1) 
Local oSection2  := oReport:Section(1):Section(1)  
Local nOrdem     := oReport:Section(1):GetOrder()
Local cProduto   := ""
Local lSd7Valido := .T.
Local cWhere    := ""
Local cOrder    := ""
Local oFile

PRIVATE cDirCQ  :=ALLTRIM(GETMV("MV_DIRCQ"))
PRIVATE cAuxTxt := ""
PRIVATE cTexto  := ""
PRIVATE cArqCQ  := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Analisa a existencia do diretorio de Avaliacoes do CQ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDirCQ:=IIF(Subs(cDirCQ,1,1)#'\','\'+cDirCQ,cDirCQ)
cDirCQ:=IIF(Subs(cDirCQ,Len(cDirCq),1)#'\',cDirCQ+'\',cDirCQ)
cArqCQ:=cDirCQ+"X"

oFile := FWFileWriter():New(cArqCQ, .T.)
 If !oFile:Create()//oFile:nHandLen
	HELP(" ",1,"NODIRCQ")
	Return
Else
	If oFile:Exists(cArqCQ)
		FERASE(cArqCQ)
	Endif	
EndIf 

oFile:Close()

PRIVATE nSaldo := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " -" + If( nOrdem == 1 , STR0003 , STR0004 ) ) //" Por Numero    " ### " Por Produto        "

dbSelectArea("SD7")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
oReport:Section(1):BeginQuery()	

cWhere := "%" 
If mv_par03 == 1 .And. mv_par04 == 1
	cWhere += " AND ( D7_TIPO = 0 OR D7_TIPO = 1 OR D7_TIPO = 3 OR D7_TIPO = 6 )" 
ElseIf mv_par03 == 1 .And. mv_par04 == 2
	cWhere += " AND ( D7_TIPO = 0 OR D7_TIPO = 1 OR D7_TIPO = 3 )" 
ElseIf mv_par03 == 2 .And. mv_par04 == 1
	cWhere += " AND ( D7_TIPO = 0 OR D7_TIPO = 2 OR D7_TIPO = 4 OR D7_TIPO = 7 )" 
ElseIf mv_par03 == 2 .And. mv_par04 == 2
	cWhere += " AND ( D7_TIPO = 0 OR D7_TIPO = 2 OR D7_TIPO = 4 )" 
ElseIf mv_par03 == 3 .And. mv_par04 == 1
	cWhere += " AND ( D7_TIPO = 0 OR D7_TIPO = 1 OR D7_TIPO = 2 OR D7_TIPO = 3 OR D7_TIPO = 4 OR D7_TIPO = 6 OR D7_TIPO = 7 OR D7_TIPO = 8 OR D7_TIPO = 9 )" 
ElseIf mv_par03 == 3 .And. mv_par04 == 2
	cWhere += " AND ( D7_TIPO = 0 OR D7_TIPO = 1 OR D7_TIPO = 2 OR D7_TIPO = 3 OR D7_TIPO = 4 OR D7_TIPO = 8 )" 
EndIf
cWhere += "%" 

If nOrdem == 1
	SD7->(dbSetOrder(1))
	cOrder := "% " + SqlOrder(SD7->(IndexKey())) + " %"
Else
	cOrder := "% D7_FILIAL,D7_PRODUTO,D7_NUMERO,D7_LOCAL %"
EndIf

BeginSql Alias cAliasSD7
 
	SELECT SD7.*,SD7.R_E_C_N_O_ SD7RECNO
	 
	FROM %table:SD7% SD7
	 
	WHERE D7_FILIAL  = %xFilial:SD7% AND 
		D7_NUMERO   >= %Exp:mv_par01% AND 
	    D7_NUMERO   <= %Exp:mv_par02% AND      
	    D7_FORNECE  >= %Exp:mv_par07% AND 
	    D7_FORNECE  <= %Exp:mv_par08% AND          
	    D7_DATA     >= %Exp:Dtos(mv_par05)% AND 
	    D7_DATA     <= %Exp:Dtos(mv_par06)% AND 
	    SD7.%NotDel% 
	    %Exp:cWhere%	    

	ORDER BY %Exp:cOrder%
	   
EndSql

oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
    
oSection2:SetParentQuery()

If nOrdem == 1
	cKeyForTot := "D7_FILIAL+D7_NUMERO+D7_PRODUTO+D7_LOCAL"
	oSection2:Cell("D7_NUMERO"):Disable()
	oSection2:Cell("D7_DOC"):Disable()
Else
	cKeyForTot := "D7_FILIAL+D7_PRODUTO+D7_NUMERO+D7_LOCAL"
	oSection1:Cell("D7_NUMERO"):Disable()
	oSection1:Cell("D7_DOC"):Disable()
	oSection1:Cell("D7_ORIGLAN"):Disable()
	oSection2:Cell("X5_DESCRI"):Disable()
EndIf

TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1")+(cAliasSD7)->D7_PRODUTO })
TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+(cAliasSD7)->D7_FORNECE+(cAliasSD7)->D7_LOJA})	
TRPosition():New(oSection2,"SX5",1,{|| xFilial("SX5")+"43"+(cAliasSD7)->D7_MOTREJE })

oSection2:SetTotalText(STR0020) //"Saldo "
TRFunction():New(oSection2:Cell("QUANTIDADE"),NIL,"SUM",/*oBreak2*/,,/*cPicture*/,{|| nSaldo },.T.,.F.,,oSection2)

oReport:SetMeter(SD7->(LastRec()))
dbSelectArea(cAliasSD7)               

While !oReport:Cancel() .And. !(cAliasSD7)->(Eof())
	
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	
	If nOrdem == 1
		cProduto := (cAliasSD7)->(D7_FILIAL+D7_NUMERO+D7_PRODUTO+D7_LOCAL)
	Else
		cProduto := (cAliasSD7)->(D7_FILIAL+D7_PRODUTO+D7_NUMERO+D7_LOCAL)
		oSection2:Cell("D7_NUMERO"):Show()
	EndIf

	If lSd7Valido := If( (cAliasSD7)->D7_TIPO = 0 , U_ValidaSD7(cAliasSD7,cProduto,cKeyForTot) , .T. )
		
		// Tratamento para imprimir nome do cliente em caso de notas de Devolucao/Beneficiamento
		If (cAliasSD7)->D7_ORIGLAN == 'CP'
			oSection1:Cell("A2_NOME"):SetValue(SA2->A2_NOME)
			SD1->(dbSetOrder(2)) // FILIAL + COD + DOC + SERIE + FORNECE + LOJA
			IF SD1->(MsSeek(xFilial('SD1')+(cAliasSD7)->D7_PRODUTO+(cAliasSD7)->D7_DOC+(cAliasSD7)->D7_SERIE+(cAliasSD7)->D7_FORNECE+(cAliasSD7)->D7_LOJA))
				If SD1->D1_TIPO $ 'D|B' .and. SD1->D1_NUMSEQ == (cAliasSD7)->D7_NUMSEQ
					SA1->(dbSetOrder(1)) // FILIAL + COD + LOJA
					SA1->(MsSeek(xFilial('SA1')+SD1->D1_FORNECE+SD1->D1_LOJA))
					oSection1:Cell("A2_NOME"):SetValue(SA1->A1_NOME)
				Else
					SA2->(dbSetOrder(1)) // FILIAL + COD + LOJA
					SA2->(MsSeek(xFilial('SA2')+(cAliasSD7)->D7_FORNECE+(cAliasSD7)->D7_LOJA))
					oSection1:Cell("A2_NOME"):SetValue(SA2->A2_NOME)
				EndIf
			EndIf
		EndIf
		
		oSection1:Init()
		oSection1:PrintLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Abre arquivo CQ99999.TXT                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cArqCQ  :=cDirCq+"CQ"+(cAliasSD7)->D7_NUMERO+".TXT"
		oFile := FWFileReader():New(cArqCQ)
		cAuxTxt := oFile:GetLine()

		nSaldo := 0
		
		oSection2:Init()
		While !oReport:Cancel() .And. !(cAliasSD7)->(Eof()) .And. cProduto == (cAliasSD7)->&(cKeyForTot)
			
			oReport:IncMeter()
			If oReport:Cancel()
				Exit
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Le o Texto com base no arquivo CQ99999.TXT   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cTexto := fLeTxt(cAuxTxt)
			
			If (cAliasSD7)->D7_TIPO == 0
				oSection2:Cell("TIPO"):SetValue(STR0015) //"Qtd. Original"
			ElseIf (cAliasSD7)->D7_TIPO == 1
				oSection2:Cell("TIPO"):SetValue(STR0016)	//"Liberado"
			ElseIf (cAliasSD7)->D7_TIPO == 2
				oSection2:Cell("TIPO"):SetValue(STR0017)	//"Rejeitado"
			ElseIf (cAliasSD7)->D7_TIPO == 3
				oSection2:Cell("TIPO"):SetValue(STR0028)	//'Devolucao Liberacao '
			ElseIf (cAliasSD7)->D7_TIPO == 4
				oSection2:Cell("TIPO"):SetValue(STR0029)	//'Devolucao Rejeicao  '
			ElseIf (cAliasSD7)->D7_TIPO == 6
				oSection2:Cell("TIPO"):SetValue(STR0018)	//"Est. Liber."
			ElseIf (cAliasSD7)->D7_TIPO == 7
				oSection2:Cell("TIPO"):SetValue(STR0019)	//"Est. Rej."
			ElseIf (cAliasSD7)->D7_TIPO == 8
				oSection2:Cell("TIPO"):SetValue(STR0030)	//'Despesas Agregadas  '
			ElseIf (cAliasSD7)->D7_TIPO == 9
				oSection2:Cell("TIPO"):SetValue(STR0031)	//'Estorno Despesas    '
			Endif
			
			If (cAliasSD7)->D7_QTDE <= 0
				oSection2:Cell("QUANTIDADE"):SetValue((cAliasSD7)->D7_SALDO)
			Else
				oSection2:Cell("QUANTIDADE"):SetValue((cAliasSD7)->D7_QTDE)
			Endif
			
			nSaldo := ( If( (cAliasSD7)->D7_TIPO == 0 , (cAliasSD7)->D7_SALDO , ;
						 If( (cAliasSD7)->D7_TIPO == 1 .Or. (cAliasSD7)->D7_TIPO == 2 ,;
			    		- (cAliasSD7)->D7_QTDE , (cAliasSD7)->D7_QTDE )))

			oSection2:PrintLine()
			
			If nOrdem == 2
				oSection2:Cell("D7_NUMERO"):Hide()
			EndIf
			
			dbSelectArea(cAliasSD7)
			dbSkip()
			
		EndDo
		
		oSection1:Finish()
		oSection2:Finish()
		
	Else

		dbSelectArea(cAliasSD7)
		dbSkip()

	EndIf
	
EndDo

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ValidaSD7 ³ Autor ³Alexandre Inacio Lemes ³Data  ³28/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao das Baixas do Controle de Qualidade                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Alias da Tabela                                      ³±±
±±³          ³ExpC2: Conteudo dos campos do registro posicionado.         ³±±
±±³          ³ExpC3: String para macroexecucao no while de pesiquisa.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 : .T. se o Registro SD7 for valido para impressao     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ValidaSD7(cAliasSD7,cProduto,cKeyForTot)

Local aArea	  := GetArea()
Local lValido :=.F.

dbSelectArea("SD7")

SD7->(dbGoto((cAliasSD7)->SD7RECNO))
SD7->(dbSkip())

While !Eof() .And. cProduto ==  &(cKeyForTot)
	If mv_par03 # 3
		If (mv_par03==1 .and. SD7->D7_TIPO == 2) ;
			.or. (mv_par03==2 .and. SD7->D7_TIPO == 1)
			dbSkip()
			Loop
		Endif
	Endif
	If mv_par04 == 2 .And. (SD7->D7_TIPO == 6 .Or. SD7->D7_TIPO == 7)
		dbSkip()
		Loop
	Endif
	If mv_par04 == 1
		If mv_par03 == 1 .And. SD7->D7_TIPO == 7
			dbSkip()
			Loop
		ElseIf mv_par03 == 2 .And. SD7->D7_TIPO == 6
			dbSkip()
			Loop
		Endif
	Endif
	lValido:=.T.
	Exit
End

RestArea(aArea)

Return lValido

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  fLeTXT  ³ Autor ³   Marcos Simidu       ³ Data ³ 20.11.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Le Arquivo de Controle de Transacoes do CQ.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fLeTXT(cTexto)

cAcha:= STR0021+Str(D7_TIPO,1)+STR0022+D7_SEQ+"/A]"		//"[TIPO:"###"/SEQ:"
nAt  := At(cAcha,cTexto)
cAcha:= STR0021+Str(D7_TIPO,1)+STR0022+D7_SEQ+"/Z]"		//"[TIPO:"###"/SEQ:"
nAt1 := At(cAcha,cTexto)
If nAt#0 .And. nAt1#0
	cTexto := Substr(cTexto,nAt+20,nAt1-nAt-21)
Else
	cTexto := ""
EndIf

Return(cTexto)
