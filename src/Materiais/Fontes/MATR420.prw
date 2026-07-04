/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR420.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR420  ³ Autor ³Alexandre Inacio Lemes ³ Data ³09/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo diario das movimentacos do Kardex                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR420(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr420()

Local oReport

oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³09/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo diario das movimentacos do Kardex                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local aOrdem   := {STR0005,STR0006} //" Codigo Produto "###" Tipo Produto   "
Local aArea	   := Getarea()
Local aSB1Cod  := TamSX3("B1_COD")
Local aSB1Ite  := TAMSX3("B1_CODITE")
Local lVeiculo := Upper(GetMV("MV_VEICULO")) == "S"

Local cTitle   := STR0001	         //"Resumo Diario do Kardex"
Local oReport
Local oSection1
Local oSection2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se utiliza custo unificado por Empresa/Filial       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lCusUnif := A330CusFil()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        // Do produto                                ³
//³ mv_par02        // Ate o produto                             ³
//³ mv_par03        // Do tipo                                   ³
//³ mv_par04        // Ate o tipo                                ³
//³ mv_par05        // Da data                                   ³
//³ mv_par06        // Ate a data                                ³
//³ mv_par07        // Lista produtos s/movimento                ³
//³ mv_par08        // Qual Local (almoxarifado)                 ³
//³ mv_par09        // Saldo a considerar : Atual / Fechamento   ³
//³ mv_par10        // Moeda selecionada (1 a 5)                 ³
//³ mv_par11        // Imprime descricao do armazem Por Empresa? ³
//³ mv_par12        // Seleciona Filial?                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR420",.F.)

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
//³ Descricao                                                              ³
//³"Este programa emite uma rela‡„o ,resumida por dia ,das movimenta‡”es"  ³
//³"dos produtos e materiais de estoque. Ele aglutina as entradas e"       ³
//³"saidas em uma £nica linha para cada dia."                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:=TReport():New("MTR420",cTitle,"MTR420", {|oReport| ReportPrint(oReport,aOrdem)},STR0002+" "+STR0003+" "+STR0004)
oReport:SetTotalInLine(.F.)
oReport:SetPortrait()
oReport:SetUseGC(.F.) // Remove botão da gestão de empresas pois conflita com a pergunta "Seleciona Filiais"
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
oSection1:= TRSection():New(oReport,STR0031,{"SB1"},aOrdem)
oSection1:SetTotalInLine(.F.)
oSection1:SetLineStyle()

If lVeiculo
	TRCell():New(oSection1,"B1_CODITE","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf
TRCell():New(oSection1,"B1_COD"    ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_UM"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_TIPO"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_GRUPO"  ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"SALDOQTD"  ,"   ",/*Titulo*/,PesqPictQt("B2_QATU",16)              ,/*Tamanho*/,/*lPixel*/,{|| aSalAtu[1] })
oSection1:Cell("SALDOQTD"):GetFieldInfo("B2_QATU")
oSection1:Cell("SALDOQTD"):SetTitle(STR0022) //"Saldo Quantidade"

TRCell():New(oSection1,"SALDOVLR"  ,"   ",/*Titulo*/,PesqPict("SD1","D1_CUSTO",18,mv_par10),/*Tamanho*/,/*lPixel*/,{|| aSalAtu[mv_par10+1] })
oSection1:Cell("SALDOVLR"):GetFieldInfo("D1_CUSTO")
oSection1:Cell("SALDOVLR"):SetTitle(STR0023) //"Saldo Valor Total"
oSection2:= TRSection():New(oSection1,STR0032,{"SB1","SB2","SD1","SD2","SD3"})
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage()

TRCell():New(oSection2,"DATAMOV","   ",STR0024,/*Picture*/                            ,/*Tamanho*/,/*lPixel*/,{|| dCntData })
TRCell():New(oSection2,"QTDENT" ,"   ",STR0025,PesqPictQt("B2_QATU",16)               ,/*Tamanho*/,/*lPixel*/,{|| nEntPriUM })
TRCell():New(oSection2,"CUSENT" ,"   ",STR0026,PesqPict("SD1","D1_CUSTO",18,mv_par10) ,/*Tamanho*/,/*lPixel*/,{|| nEntraVal })
TRCell():New(oSection2,"QTDSAI" ,"   ",STR0027,PesqPictQt("B2_QATU",16)            ,/*Tamanho*/,/*lPixel*/,{|| nSaiPriUM })
TRCell():New(oSection2,"CUSSAI" ,"   ",STR0028,PesqPict("SD1","D1_CUSTO",18,mv_par10) ,/*Tamanho*/,/*lPixel*/,{|| nSaidaVal })
TRCell():New(oSection2,"QTDSAL" ,"   ",STR0029,PesqPictQt("B2_QATU",16)               ,/*Tamanho*/,/*lPixel*/,{|| aSalAtu[1] })
TRCell():New(oSection2,"VLRSAL" ,"   ",STR0030,PesqPict("SD1","D1_CUSTO",18,mv_par10) ,/*Tamanho*/,/*lPixel*/,{|| aSalAtu[mv_par10+1] })

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³09/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo diario das movimentacos do Kardex                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem)

Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local nOrdem     := oReport:Section(1):GetOrder()

Local aFilsCalc  := {}
Local bBloco     := { |nV,nX| Trim(nV)+IIf(Valtype(nX)='C',"",Str(nX,1)) }

Local cIndexKey  := ""
Local cTrbSD1    := ""
Local cTrbSD2    := ""
Local cTrbSD3    := ""
Local cProdAnt   := ""
Local cFilBack   := cFilAnt
Local cProdMNT   := GetMv("MV_PRODMNT")
Local cProdTER   := GetMv("MV_PRODTER")
Local cLocaliz   := ""
Local aProdsMNT  := {}

Local dDataIni   := mv_par05
Local dDataFim   := mv_par06

Local nSavRec    := 0
Local nRec1      := 0
Local nRec2      := 0
Local nRec3      := 0
Local nEntSegUM  := 0
Local nSaiSegUM  := 0
Local nForFilial := 0

Local lLocProc   := mv_par08 == GetMvNNR('MV_LOCPROC','99')
Local lVeiculo   := Upper(GetMV("MV_VEICULO"))=="S"
Local lRemInt    := SuperGetMv("MV_REMINT",.F.,.F.)
Local lFirst1    := .T.
Local lInvertMov := .F.
Local lDev       // Flag que indica se nota ‚ devolu‡ao (.T.) ou nao (.F.)
Local lPriApropri:=.T.
Local aSalAlmox	:={},aArea:={}
Local cSeek		:=""
Local i			:=0
Local cRemito   := ""
Local cAliasRel := ""
Local cSimbMoed := ""
PRIVATE aSalAtu    := {}
PRIVATE nEntPriUM  := 0
PRIVATE nSaiPriUM  := 0
PRIVATE nEntraVal  := 0
PRIVATE nSaidaVal  := 0
PRIVATE dCntData

cProdMNT := cProdMNT + Space(15-Len(cProdMNT))
cProdTER := cProdTER + Space(15-Len(cProdTER))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ MatFilCalc() - Funcao para selecao de Filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFilsCalc := MatFilCalc((mv_par12 == 1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se utiliza custo unificado por Empresa/Filial       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private lCusUnif := A330CusFil()

lCusUnif:=lCusUnif .And. Trim(mv_par08) == "**"

If Empty(aFilsCalc)
	Return
EndIf

oSection1 :SetTotalText(STR0014) //"T O T A I S :"
TRFunction():New(oSection2:Cell("QTDENT"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1)
TRFunction():New(oSection2:Cell("CUSENT"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1)
TRFunction():New(oSection2:Cell("QTDSAI"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1)
TRFunction():New(oSection2:Cell("CUSSAI"),NIL,"SUM",/*oBreak1*/,,/*cPicture*/,/*uFormula*/,.T.,.F.,,oSection1)
TRFunction():New(oSection2:Cell("QTDSAL"),NIL,"ONPRINT",/*oBreak1*/,,/*cPicture*/,{|| aSalAtu[1]},.T.,.F.,,oSection1)
TRFunction():New(oSection2:Cell("VLRSAL"),NIL,"ONPRINT",/*oBreak1*/,,/*cPicture*/,{|| aSalAtu[mv_par10+1]},.T.,.F.,,oSection1)

For nForFilial := 1 To Len( aFilsCalc )

	If aFilsCalc[ nForFilial, 1 ]

		cFilAnt := aFilsCalc[ nForFilial, 2 ]

		oReport:EndPage() //Reinicia Pagina

		cSimbMoed := A420GetMV("MV_SIMB"+Ltrim(Str(mv_par10)))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nOrdem == 1
			oReport:SetTitle( STR0001+STR0011+AllTrim(STR0005)+STR0012+AllTrim(cSimbMoed+")")+' - ' + aFilsCalc[ nForFilial, 3 ] ) //" (Por "###" ,em "
		Else
			oReport:SetTitle( STR0001+STR0011+AllTrim(STR0006)+STR0012+AllTrim(cSimbMoed+")")+' - ' + aFilsCalc[ nForFilial, 3 ] ) //" (Por "###" ,em "
		EndIf	

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Transforma parametros Range em expressao SQL                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MakeAdvplExpr(oReport:uParam)

		cFiltro := "B1_FILIAL == '" + xFilial('SB1') + "' .And. "
		If lVeiculo
			cFiltro += "B1_CODITE   >= '" + mv_par01 + "' .And. B1_CODITE   <= '" + mv_par02 + "' .And. "
		Else
			cFiltro += "B1_COD      >= '" + mv_par01 + "' .And. B1_COD      <= '" + mv_par02 + "' .And. "
		EndIf
		cFiltro += "B1_TIPO  >= '" + mv_par03 + "' .And. B1_TIPO  <= '" + mv_par04 + "' "

		dbSelectArea("SB1")
		If nOrdem == 1
			If lVeiculo
				cIndexKey := "B1_FILIAL+B1_CODITE"
			Else
				SB1->(dbSetOrder(1))
				cIndexKey := IndexKey()
			EndIf
		ElseIf nOrdem == 2
			If lVeiculo
				cIndexKey := "B1_FILIAL+B1_TIPO+B1_CODITE"
			Else
				SB1->(dbSetOrder(2))
				cIndexKey := IndexKey()
			EndIf
		EndIf

		oReport:Section(1):SetFilter(cFiltro,cIndexKey)

		oReport:SetMeter(SB1->(LastRec()))

		dbSelectArea("SB1")

		While !oReport:Cancel() .And. !SB1->(Eof()) .And. B1_FILIAL == xFilial("SB1")

			oReport:IncMeter()
			If oReport:Cancel()
				Exit
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Não imprimir o produto MANUTENCAO (MV_PRDMNT) qdo integrado com MNT.       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If MTR420IsMNT()
				aProdsMNT := aClone(NGProdMNT())
				If aScan(aProdsMNT, {|x| AllTrim(x) == AllTrim(SB1->B1_COD) }) > 0
					dbSkip()
					Loop
				EndIf
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se nao encontrar no arquivo de saldos ,nao lista ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SB2")
			If !dbSeek(xFilial("SB2")+SB1->B1_COD+If(lCusUnif,"",mv_par08))
				dbSelectArea("SB1")
				dbSkip()
				Loop
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o Saldo Inicial do Produto             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lCusUnif
				aArea:=GetArea()
				aSalAtu  := { 0,0,0,0,0,0,0 }
				dbSelectArea("SB2")
				dbSetOrder(1)
				dbSeek(cSeek:=xFilial("SB2") + (SB1->B1_COD))
				While !Eof() .And. B2_FILIAL+B2_COD == cSeek
					aSalAlmox := CalcEst(SB1->B1_COD,SB2->B2_LOCAL,mv_par05)
					For i:=1 to Len(aSalAtu)
						aSalAtu[i] += aSalAlmox[i]
					Next i
					dbSkip()
				End
				RestArea(aArea)
			Else
				aSalAtu := CalcEst(SB1->B1_COD,mv_par08,mv_par05)
			EndIf

			cQuery:= "SELECT SUM(CASE SD1.D1_TIPO WHEN 'D' THEN 0 ELSE SD1.D1_QUANT END) AS ENTQTD,"
			cQuery+= "SUM(CASE SD1.D1_TIPO WHEN 'D' THEN -SD1.D1_QUANT ELSE 0 END) AS SDAQTD,"
			cQuery+= "SUM(CASE SD1.D1_TIPO WHEN 'D' THEN 0 ELSE SD1.D1_QTSEGUM END) AS ENTQTS,"
			cQuery+= "SUM(CASE SD1.D1_TIPO WHEN 'D' THEN -SD1.D1_QTSEGUM ELSE 0 END) AS SDAQTS,"
			cQuery+= "SUM(CASE SD1.D1_TIPO WHEN 'D' THEN 0 ELSE SD1.D1_CUSTO"+Iif(mv_par10==1," ",alltrim(Str(mv_par10)))+" END) AS ENTCUST,"
			cQuery+= "SUM(CASE SD1.D1_TIPO WHEN 'D' THEN -SD1.D1_CUSTO"+Iif(mv_par10==1," ",alltrim(Str(mv_par10)))+" ELSE 0 END) AS SDACUST,"
			cQuery+= "SD1.D1_DTDIGIT AS DATA "
			cQuery+= " FROM "+RetSqlName("SD1")+" SD1 JOIN "+RetSqlName("SF4")+" SF4 ON "
			cQuery+= "SF4.D_E_L_E_T_ = ' ' AND "
			cQuery+= "SF4.F4_FILIAL = '"+xFilial("SF4")+"' AND "
			cQuery+= "SF4.F4_CODIGO = SD1.D1_TES AND "
			cQuery+= "SF4.F4_ESTOQUE = 'S' "
			cQuery+= "WHERE SD1.D_E_L_E_T_ = ' ' AND "
			cQuery+= "SD1.D1_FILIAL = '"+xFilial("SD1")+"'"
			cQuery+= " AND SD1.D1_COD = '"+SB1->B1_COD+"' "
			cQuery+= " AND SD1.D1_DTDIGIT >= '"+Dtos(mv_par05)+"' AND SD1.D1_DTDIGIT <= '"+dtos(mv_par06)+"'"
			cQuery+= " AND SD1.D1_ORIGLAN != 'LF'"
			If !lCusUnif
				cQuery += " AND SD1.D1_LOCAL = '"+MV_PAR08+"'"
			EndIf
			If cPaisLoc != "BRA"
				cRemito:= CriaVar("D1_REMITO")
				cConhec:= CriaVar("D1_CONHEC")
				cQuery += " AND D1_REMITO = '"+cRemito+"'"
				cQuery += " AND SD1.D1_TIPO_NF NOT IN('6','7','8','9','A','B')"
				If lRemInt
					cQuery += " AND SD1.D1_CONHEC = '"+cConhec+"' AND SD1.D1_TIPO_NF NOT IN ('5') AND SD1.D1_TIPODOC NOT IN '10'"
				EndIf
			EndIf
			cQuery+= " GROUP BY D1_DTDIGIT"

			cQuery+= " UNION ALL "
			cQuery+= "SELECT SUM(CASE WHEN SD3.D3_TM > '500' THEN 0 ELSE SD3.D3_QUANT END) AS ENTQTD,
			cQuery+= "SUM(CASE WHEN SD3.D3_TM > '500' THEN SD3.D3_QUANT ELSE 0 END) AS SDAQTD,"
			cQuery+= "SUM(CASE WHEN SD3.D3_TM > '500' THEN 0 ELSE SD3.D3_QTSEGUM END) AS ENTQTS,"
			cQuery+= "SUM(CASE WHEN SD3.D3_TM > '500' THEN SD3.D3_QTSEGUM ELSE 0 END) AS SDAQTS,"
			cQuery+= "SUM(CASE WHEN SD3.D3_TM > '500' THEN 0 ELSE SD3.D3_CUSTO"+Alltrim(Str(mv_par10))+" END) AS ENTCUST,"
			cQuery+= "SUM(CASE WHEN SD3.D3_TM > '500' THEN SD3.D3_CUSTO"+AllTrim(Str(mv_par10))+" ELSE 0 END) AS SDACUST, "
			cQuery+= "SD3.D3_EMISSAO AS DATA "
			cQuery+= "FROM "+RetSqlName("SD3")+" SD3 "
			cQuery+= "WHERE SD3.D_E_L_E_T_ = ' ' AND "
			cQuery+= "SD3.D3_FILIAL = '"+xFilial("SD3")+"'"
			cQuery+= " AND SD3.D3_COD = '"+SB1->B1_COD+"' "
			cQuery+= " AND SD3.D3_EMISSAO >= '"+Dtos(mv_par05)+"' AND SD3.D3_EMISSAO <= '"+dtos(mv_par06)+"'"
			cQuery+= " AND SD3.D3_ESTORNO <> 'S'"
			If !lCusUnif
				cQuery += " AND SD3.D3_LOCAL = '"+MV_PAR08+"'"
			EndIf
			cQuery+= " GROUP BY D3_EMISSAO

			If lLocProc .Or. lCusUnif
				cQuery+= " UNION ALL "
				cQuery+= "SELECT SUM(CASE WHEN SD3.D3_TM < '501' THEN 0 ELSE SD3.D3_QUANT END) AS ENTQTD,
				cQuery+= "SUM(CASE WHEN SD3.D3_TM < '501' THEN SD3.D3_QUANT ELSE 0 END) AS SDAQTD,"
				cQuery+= "SUM(CASE WHEN SD3.D3_TM < '501' THEN 0 ELSE SD3.D3_QTSEGUM END) AS ENTQTS,"
				cQuery+= "SUM(CASE WHEN SD3.D3_TM < '501' THEN SD3.D3_QTSEGUM ELSE 0 END) AS SDAQTS,"
				cQuery+= "SUM(CASE WHEN SD3.D3_TM < '501' THEN 0 ELSE SD3.D3_CUSTO"+Alltrim(Str(mv_par10))+" END) AS ENTCUST,"
				cQuery+= "SUM(CASE WHEN SD3.D3_TM < '501' THEN SD3.D3_CUSTO"+AllTrim(Str(mv_par10))+" ELSE 0 END) AS SDACUST, "
				cQuery+= "SD3.D3_EMISSAO AS DATA "
				cQuery+= "FROM "+RetSqlName("SD3")+" SD3 "
				cQuery+= "WHERE SD3.D_E_L_E_T_ = ' ' AND "
				cQuery+= "SD3.D3_FILIAL = '"+xFilial("SD3")+"'"
				cQuery+= " AND SD3.D3_COD = '"+SB1->B1_COD+"' "
				cQuery+= " AND SD3.D3_EMISSAO >= '"+Dtos(mv_par05)+"' AND SD3.D3_EMISSAO <= '"+dtos(mv_par06)+"'"
				cQuery+= " AND SD3.D3_ESTORNO <> 'S'"
				cQuery+= " AND SUBSTRING(SD3.D3_CF,3,1) = '3'"
				cQuery+= " GROUP BY D3_EMISSAO
			EndIf

			cQuery+= " UNION ALL "
			cQuery+= "SELECT SUM(CASE SD2.D2_TIPO WHEN 'D' THEN -SD2.D2_QUANT ELSE 0 END) AS ENTQTD,"
			cQuery+= "SUM(CASE SD2.D2_TIPO WHEN 'D' THEN 0 ELSE SD2.D2_QUANT END) AS SDAQTD,"
			cQuery+= "SUM(CASE SD2.D2_TIPO WHEN 'D' THEN -SD2.D2_QTSEGUM ELSE 0 END) AS ENTQTS,"
			cQuery+= "SUM(CASE SD2.D2_TIPO WHEN 'D' THEN 0 ELSE SD2.D2_QTSEGUM END) AS SDAQTS,"
			cQuery+= "SUM(CASE SD2.D2_TIPO WHEN 'D' THEN -SD2.D2_CUSTO"+Alltrim(Str(mv_par10))+" ELSE 0 END) AS ENTCUST,"
			cQuery+= "SUM(CASE SD2.D2_TIPO WHEN 'D' THEN 0 ELSE SD2.D2_CUSTO"+Alltrim(Str(mv_par10))+" END) AS SDACUST,"
			cQuery+= "SD2.D2_EMISSAO AS DATA "
			cQuery+= " FROM "+RetSqlName("SD2")+" SD2 JOIN "+RetSqlName("SF4")+" SF4 ON "
			cQuery+= "SF4.D_E_L_E_T_ = ' ' AND "
			cQuery+= "SF4.F4_FILIAL = '"+xFilial("SF4")+"' AND "
			cQuery+= "SF4.F4_CODIGO = SD2.D2_TES AND "
			cQuery+= "SF4.F4_ESTOQUE = 'S' "
			cQuery+= "WHERE SD2.D_E_L_E_T_ = ' ' AND "
			cQuery+= "SD2.D2_FILIAL = '"+xFilial("SD2")+"'"
			cQuery+= " AND SD2.D2_COD = '"+SB1->B1_COD+"' "
			cQuery+= " AND SD2.D2_EMISSAO >= '"+Dtos(mv_par05)+"' AND SD2.D2_EMISSAO <= '"+dtos(mv_par06)+"'"
			cQuery+= " AND SD2.D2_ORIGLAN <> 'LF'"
			If !lCusUnif
				cQuery += " AND SD2.D2_LOCAL = '"+MV_PAR08+"'"
			EndIf
			If !(cPaisLoc $ "BRA|CHI")
				cRemito:= CriaVar("D2_REMITO")
				cQuery += " AND D2_REMITO = '"+cRemito+"'"
				If !(cPaisLoc $ "MEX|PER|COL|EQU")
					cQuery += " AND SD2.D2_TPDCENV IN('1','A')"
				EndIf
			EndIf
			cQuery+= " GROUP BY D2_EMISSAO"
			cQuery+= " ORDER BY DATA"
			cQuery:= ChangeQuery(cQuery)
			cAliasRel := GetNextAlias()
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasRel,.T.,.T.)

			TCSetField(cAliasRel, "DATA", "D")

			(cAliasRel)->(DbGoTop())
			If (cAliasRel)->(Eof())
				If mv_par07 $ "Ss"
					oSection1:Init()
					oSection1:PrintLine()
					oReport:SkipLine()
					oReport:PrintText(STR0016,,oSection2:Cell("DATAMOV"):ColPos()) //"NAO HOUVE MOVIMENTACAO PARA ESTE PRODUTO"
					oReport:ThinLine()
					oSection1:Finish()
				Else							//Se !mv_par07 $ "Ss", nao lista produtos sem movimento
					(cAliasRel)->(DbCloseArea())
					dbSelectArea("SB1")
					dbSkip()
					Loop
				Endif
			Else
				oSection1:Init()
				oSection1:PrintLine()
			EndIf

			While !(cAliasRel)->(Eof())

				dCntData  := (cAliasRel)->DATA
				nEntPriUM += (cAliasRel)->ENTQTD
				nEntraVal += (cAliasRel)->ENTCUST
				nSaiPriUM += (cAliasRel)->SDAQTD
				nSaidaVal += (cAliasRel)->SDACUST

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Subtrai as saidas porque vem sempre com valor positivo da query  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				aSalAtu[1]:= aSalAtu[1] + (cAliasRel)->ENTQTD - (cAliasRel)->SDAQTD
				aSalAtu[mv_par10+1] := aSalAtu[mv_par10+1] + (cAliasRel)->ENTCUST - (cAliasRel)->SDACUST
				aSalAtu[7]          := aSalAtu[7] + (cAliasRel)->ENTQTS - (cAliasRel)->SDAQTS

				(cAliasRel)->(DbSkip())

				If dCntData == (cAliasRel)->DATA
						Loop
				Else
					oSection2:Init()
					oSection2:PrintLine()

					nEntPriUM := 0
					nEntraVal := 0
					nSaiPriUM := 0
					nSaidaVal := 0
				EndIf
			End
			oSection1:Finish()
			oSection2:Finish()

			If mv_par11 == 1 .And. !Empty(NNR->NNR_DESCRI)
			    cLocaliz := Posicione("NNR",1,xFilial("NNR")+SB2->B2_LOCAL,"NNR_DESCRI")
				oReport:PrintText(STR0021+cLocaliz+Space(70)+STR0015+TransForm(aSalAtu[7],PesqPictQt("B2_QTSEGUM",16)),,oSection2:Cell("DATAMOV"):ColPos()) //"Armazem : "
			Else
				oReport:PrintText(Space(95)+STR0015+TransForm(aSalAtu[7],PesqPictQt("B2_QTSEGUM",16)),,oSection2:Cell("DATAMOV"):ColPos()) //"Armazem : "
			EndIf

			oReport:SkipLine()
			oReport:ThinLine()
			(cAliasRel)->(DbCloseArea())
			dbSelectArea("SB1")
			dbSkip()
		EndDo
	EndIf
Next nForFilial

cFilAnt := cFilBack

dbSelectArea("SB1")
dbSetOrder(1)
dbSelectArea("SB2")
dbSetOrder(1)

dbSelectArea("SD1")
If lCusUnif
	dbClearFilter()
	RetIndex("SD1")
	If File(cTrbSD1+OrdBagExt())
		Ferase(cTrbSD1+OrdBagExt())
	EndIf
EndIf
dbSetOrder(1)

dbSelectArea("SD2")
If lCusUnif
	dbClearFilter()
	RetIndex("SD2")
	If File(cTrbSD2+OrdBagExt())
		Ferase(cTrbSD2+OrdBagExt())
	EndIf
EndIf
dbSetOrder(1)

dbSelectArea("SD3")
If lLocProc .Or. lCusUnif
	dbClearFilter()
	RetIndex("SD3")
	If File(cTrbSD3+OrdBagExt())
		Ferase(cTrbSD3+OrdBagExt())
	EndIf
EndIf
dbSetOrder(1)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR420IsMN³ Autor ³ Lucas                 ³ Data ³ 03.10.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se há integração com o modulo SigaMNT/NG          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MTR420IsMNT()
Local aArea
Local aAreaSB1
Local aProdsMNT := {}
Local nX := 0
Local lIntegrMNT := .F.

//Esta funcao encontra-se no modulo Manutencao de Ativos (NGUTIL05.PRX), e retorna os produtos (pode ser MAIS de UM), dos parametros de
//Manutencao - "M" (MV_PRODMNT) / Terceiro - "T" (MV_PRODTER) / ou Ambos - "*" ou em branco
If FindFunction ("NGProdMNT")
	aProdsMNT := aClone(NGProdMNT("M"))
	Endif

If Len(aProdsMNT) > 0
	aArea	 := GetArea()
	aAreaSB1 := SB1->(GetArea())

	SB1->(dbSelectArea( "SB1" ))
	SB1->(dbSetOrder(1))
	For nX := 1 To Len(aProdsMNT)
		If SB1->(dbSeek( xFilial("SB1") + aProdsMNT[nX] ))
			lIntegrMNT := .T.
			Exit
		EndIf

	Next nX

	RestArea(aAreaSB1)
	RestArea(aArea)
EndIf

Return( lIntegrMNT )

/*/{Protheus.doc} A420GetMV
	Função para encapsular GetMV ao ser utilizado em bloco de loop
	@type  Static Function
	@author pedro.bruno
	@since 12/04/2023
/*/
Static Function A420GetMV(cParam, lHelp, xDefault)
	Local xRet := Nil
	xRet := GetMv(cParam, lHelp, xDefault)
Return xRet
