/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR171.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR171  ³ Autor ³ Nereu Humberto Junior ³ Data ³ 29.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Boletim de Entrada com base em los Remitos...   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACOM                                                    ³±±
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
User Function Matr171()
    Local oReport

    //Interfaz de impresión
    oReport := ReportDef()
    oReport:PrintDialog()

Return

/*/
    ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
    ±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
    ±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³29.06.2006³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
    ±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
    ±±³          ³                                                            ³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³Parametros³Nenhum                                                      ³±±
    ±±³          ³                                                            ³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³          ³               ³                                            ³±±
    ±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
    ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

    Local oReport
    Local oSection1
    Local oSection2
    Local oSection3
    Local oSection4
    Local oSection5

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
    oReport:= TReport():New("MATR171",STR0002,"MTR171", {|oReport| ReporPrint(oReport)},STR0001) //"Boletín de entrada"##"Este programa emitirá el Boletín de entrada."
    oReport:SetTotalInLine(.F.)
    oReport:HideHeader()
    oReport:HideFooter()
    oReport:HideParamPage()

    Pergunte("MTR171",.F.)

    oSection1 := TRSection():New(oReport,STR0035,{"SF1","SA2"}) //"Encabez. de Remito de entrada"
    oSection1 :SetTotalInLine(.F.)

    TRCell():New(oSection1,"A2_NOME","SA2",/*Titulo*/,/*Picture*/,27,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection1,"A2_COD","SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection1,"A2_LOJA","SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection1,"cNum","   ",STR0033,"@!",1,/*lPixel*/,{|| "X" }) //"Nº"
    TRCell():New(oSection1,"F1_DOC","SF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection1,"F1_EMISSAO","SF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection1,"dDtVencto","   ",STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| Space(8) }) //"Vencto"

    oSection2 := TRSection():New(oSection1,STR0036,{"SA2"}) //""Proveedor"
    oSection2 :SetTotalInLine(.F.)

    TRCell():New(oSection2,"A2_END","SA2",/*Titulo*/,/*Picture*/,29,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection2,"A2_MUN","SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection2,"A2_EST","SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection2,"A2_CGC","SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

    oSection3 := TRSection():New(oReport,STR0037,{"SD1","SB1"}) //"Ítems del Remito de Entr."
    oSection3 :SetTotalInLine(.F.)

    TRCell():New(oSection3,"D1_COD","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection3,"D1_UM","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection3,"cDescri","SD1",STR0031,"@!",23,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descripción de la mercadería"
    TRCell():New(oSection3,"D1_QUANT","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection3,"D1_QTSEGUM","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

    oSection4 := TRSection():New(oSection3,STR0038,{"SD1"}) //"TES vs. C. de costo"
    oSection4 :SetTotalInLine(.F.)

    TRCell():New(oSection4,"D1_TES","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection4,"D1_CONTA","SD1",/*Titulo*/,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection4,"D1_CC","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection4,"D1_CUSTO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| SD1->D1_CUSTO/SD1->D1_QUANT })
    TRCell():New(oSection4,"cNomeGrupo"," ",STR0032,"@!",23,/*lPixel*/,/*{|| code-block de impressao }*/) //"Grupo"

    oSection5 := TRSection():New(oReport,STR0039,{"SD7"}) //"Movim. de C. Cal."
    oSection5 :SetTotalInLine(.F.)

    TRCell():New(oSection5,"D7_PRODUTO","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection5,"D7_LOCAL","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection5,"D7_LOCDEST","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
    TRCell():New(oSection5,"D7_DATA","SD7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
    ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
    ±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
    ±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³16.05.2006³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
    ±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
    ±±³          ³                                                            ³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³Retorno   ³Nenhum                                                      ³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
    ±±³          ³                                                            ³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
    ±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
    ±±³          ³               ³                                            ³±±
    ±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
    ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReporPrint(oReport)

    Local oSection1 := oReport:Section(1)
    Local oSection2 := oReport:Section(1):Section(1)
    Local oSection3 := oReport:Section(2)
    Local oSection4 := oReport:Section(2):Section(1)
    Local oSection5 := oReport:Section(3)
    Local cAliasSF1 := "SF1"
    Local lPedCom   := .F.
    Local aDivergencia := {},aPedidos := {},cPedidos,dDataSav,aCQ:={}
    Local cLocDest 	:= GetMV("MV_CQ")
    Local cNomeGrupo :=""
    Local nX		:= 0
    Local cDescProd := ""
    Local cRetTitle := RTrim(RetTitle("F1_REMITO"))
    Local nTamVazio := 80 - ( Len(OemToAnsi(STR0030) ) +Len(cRetTitle)  )//"-------------------------------- DATOS "
    Local cWhere 	:= ""
    Local aSbmCtlg	:= GetArrSbm()
    Local nIndex	:= 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Filtragem do relatório                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    dbSelectArea("SF1")
    dbSetOrder(1)
    cAliasSF1 := GetNextAlias()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    MakeSqlExpr(oReport:uParam)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oReport:Section(1):BeginQuery()

    cWhere :="%"
    cWhere += "AND ("+IsRemito(3,'F1_TIPODOC')+ ")"
    cWhere +="%"

    BeginSql Alias cAliasSF1

	SELECT F1_FILIAL, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_DTDIGIT, F1_EMISSAO, F1_REMITO

	FROM %table:SF1% SF1

	WHERE F1_FILIAL = %xFilial:SF1% AND
	  	  F1_DTDIGIT >= %Exp:Dtos(mv_par01)% AND
		  F1_DTDIGIT <= %Exp:Dtos(mv_par02)% AND
		  F1_DOC >= %Exp:mv_par03% AND
		  F1_DOC <= %Exp:mv_par04% AND
		  SF1.%NotDel%
		  %Exp:cWhere%

	ORDER BY %Order:SF1%

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

    oSection2:SetParentQuery()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo TrPosition()                                                     ³
	//³                                                                        ³
	//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
	//³realizado antes da impressao de cada linha do relatório.                ³
	//³                                                                        ³
	//³                                                                        ³
	//³ExpO1 : Objeto Report da Secao                                          ³
	//³ExpC2 : Alias da Tabela                                                 ³
	//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
	//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
	//³        cutada.                                                         ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+(cAliasSF1)->F1_FORNECE+(cAliasSF1)->F1_LOJA})
    TRPosition():New(oSection2,"SA2",1,{|| xFilial("SA2")+(cAliasSF1)->F1_FORNECE+(cAliasSF1)->F1_LOJA})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicio da impressao do fluxo do relatório                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oReport:SetMeter(SF1->(LastRec()))

    If mv_par06 == 2
        oSection4:Cell("D1_CUSTO"):Disable()
    EndIf

    dbSelectArea(cAliasSF1)
    While !oReport:Cancel() .And. (cAliasSF1)->(!Eof())

        oReport:IncMeter()
        aCQ	:= {}

        If oReport:Cancel()
            Exit
        EndIf

        nImpInc	:=0
        nImpNoInc:=0
        dbSelectArea("SD1")
        dbSetOrder(1)
        MSSEEK(xFilial("SD1")+(cAliasSF1)->F1_DOC+(cAliasSF1)->F1_SERIE+(cAliasSF1)->F1_FORNECE+(cAliasSF1)->F1_LOJA)

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Impressao do Cabecalho.                                      ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        oReport:PrintText(STR0019+DtoC((cAliasSF1)->F1_DTDIGIT)) 	//"BOLETÍN DE ENTRADA      Material recibido el: "
        oReport:PrintText(SM0->M0_NOME + "-" + SM0->M0_FILIAL)
        oReport:FatLine()
        oReport:SkipLine()

        oSection1:Init()
        oSection1:PrintLine()

        oSection2:Init(.F.)
        oSection2:PrintLine()

        oSection2:Finish()
        oSection1:Finish()
        oReport:SkipLine()
        oReport:PrintText(STR0030+Upper(cRetTitle)+" "+Replicate("-",nTamVazio)) //"-------------------------------- DATOS "

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Impressao dos itens da Nota de Entrada.                      ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        dbSelectArea("SD1")
        cRemito := D1_DOC+D1_SERIE
        cFornece:= D1_FORNECE+D1_LOJA
        aDivergencia := {}
        aPedidos     := {}
        aDescPed     := {}

        While ( !Eof() .And. SD1->D1_DOC+SD1->D1_SERIE == cRemito .And.;
                cFornece == SD1->D1_FORNECE+SD1->D1_LOJA .And.;
                SD1->D1_FILIAL == xFilial("SD1") )

            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
            //³ Posiciona Todos os Arquivos Ref. ao Itens                    ³
            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            dbSelectArea("SB1")
            dbSetOrder(1)
            MSSEEK(xFilial("SB1")+SD1->D1_COD)
            
            nIndex := ascan(aSbmCtlg,{|x| alltrim(x[1]) == alltrim(SB1->B1_GRUPO)})
            //Si es grupo está informado en el producto, pero no se encuentra en el catálogo lo informara vacío en el reporte
            cNomeGrupo :=  	if(!empty(SB1->B1_GRUPO) .AND. nIndex <> 0, aSbmCtlg[nIndex][2],"")

            oSection4:Cell("cNomeGrupo"):SetValue(cNomeGrupo)

            dbSelectArea("SC7")
            dbSetOrder(1)
            If MSSEEK(xFilial()+SD1->D1_PEDIDO+SD1->D1_ITEMPC)
                If ( SD1->D1_COD == SC7->C7_PRODUTO )
                    lPedCom:=.T.
                    dbSelectArea("SF4")
                    dbSetOrder(1)
                    MSSEEK(xFilial("SD1")+SD1->D1_TES)
                    dDataSav  := dDataBase
                    dDataBase := SD1->D1_EMISSAO
                    cProblema := ""
                    If SC7->C7_QUANT <> SD1->D1_QUANT
                        cProblema += "Q"
                    Else
                        cProblema += " "
                    EndIf
                    If SC7->C7_DATPRF <> SD1->D1_DTDIGIT
                        cProblema += "E"
                    Else
                        cProblema += " "
                    EndIf
                    cDescProd := IIf(mv_par07==1 .or. Empty(SC7->C7_DESCRI),Substr(SB1->B1_DESC,1,30),Substr(SC7->C7_DESCRI,1,30))
                    If !Empty(cProblema)
                        AADD(aDivergencia,cProblema+"  "+SC7->C7_NUM+"-"+SC7->C7_ITEM+" "+cDescProd+" "+Str(SC7->C7_QUANT,11,2)+" "+Transform(IIf(Empty(SC7->C7_REAJUST),SC7->C7_PRECO,Formula(SC7->C7_REAJUST)),"@E 99,999,999.99")+"  "+DTOC(SC7->C7_DATPRF))
                    Else
                        AADD(aPedidos,SC7->C7_NUM+"-"+SC7->C7_ITEM)
                    Endif
                    dDataBase := dDataSav
                Endif
            Endif

            dbSelectArea("SF4")
            dbSetOrder(1)
            MSSEEK(xFilial("SF4")+SD1->D1_TES)

            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
            //³ Inicializa array dos itens que foram enviados ao CQ (SD7)    ³
            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            If !Empty(SD1->D1_NUMCQ) .AND. SF4->F4_ESTOQUE == "S"
                AADD(aCQ,SD1->D1_NUMCQ+SD1->D1_COD+cLocDest+"001"+DTOS(SD1->D1_DTDIGIT))
            Endif

            cDescProd := IIf(mv_par07==1 .or. Empty(SC7->C7_DESCRI),Substr(SB1->B1_DESC,1,30),Substr(SC7->C7_DESCRI,1,30))
            oSection3:Cell("cDescri"):SetValue(cDescProd)

            oSection3:Init()
            oSection3:PrintLine()

            oSection4:Init()
            oSection4:PrintLine()
            oSection4:Finish()

            oSection3:Finish()

            dbSelectArea("SD1")
            dbSkip()
        EndDo

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Imprime produtos enviados ao Controle de Qualidade SD7       ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        If Len(aCQ) > 0

            oReport:PrintText(STR0006) //"------------------ PRODUCTO(s) ENVIADO(s) AL CONTROL DE CALIDAD ----------------"
            oReport:SkipLine()

            oSection5:Init()
            dbSelectArea("SD7")
            dbSetOrder(1)
            For nX:=1 to Len(aCQ)
                If MSSEEK(xFilial("SD7")+aCQ[nX])
                    oSection5:PrintLine()
                Endif
            Next nX
            oSection5:Finish()
        EndIf

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Imprime Divergencia com Pedido de Compra.                    ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        oReport:SkipLine()
        oReport:PrintText(STR0008) //"------------------------ DIVERGENCIAS CON EL PEDIDO DE COMPRA ---------------------------"
        oReport:SkipLine()
        If lPedCom
            cPedidos := ""
            For nX := 1 To Len(aPedidos)
                cPedidos += aPedidos[nX]+"\"
            Next nX
            cPedidos := Subs(cPedidos,1,Len(cPedidos)-1)

            If Empty(cProblema)
                oReport:PrintText(STR0009+cPedidos) //"No hay divergencias en el/los pedido(s) "
            EndIf

            If Len(aDivergencia) > 0
                oReport:PrintText(STR0010) //"Div Número    Descripción del producto          Cantidad  Precio Unit.   Entrega"
            EndIf

            For nX := 1 to Len(aDivergencia)
                oReport:PrintText(aDivergencia[nX])
            Next nX

        Else
            If !Empty(aPedidos)
                cPedidos := ""
                For nX := 1 To Len(aPedidos)
                    cPedidos += aPedidos[nX]+"\"
                Next nX
                cPedidos := SubStr(cPedidos,1,Len(cPedidos)-1)
                oReport:PrintText(STR0011+cPedidos) //"No hay divergencias en el/los pedido(s)"
            Else
                oReport:PrintText(STR0012) //"Na hay pedidos"
            Endif
        EndIf
        oReport:SkipLine()
        oReport:SkipLine()

        oReport:PrintText(STR0015) //"------------------------------------ VISTOS ------------------------------------"
        oReport:PrintText('                     |                   |                   |')
        oReport:PrintText('--------------------------------------------------------------------------------')

        dbSelectArea(cAliasSF1)
        dbSkip()
        If (cAliasSF1)->(!Eof())
            oReport:EndPage()
        Endif
    EndDo

Return NIL

/*
+=======================================================================================+
| Funcion : GetArrSbm			Autor : Nahum Ramirez				Data : 16/01/2020	|
+=======================================================================================+

 Descripcion : 	Obtiene de la tabla SBM las columnas BM_GRUPO y BM_DESC para uso como 
 				catalogo.
 Parametros	 : 	
 Retorno	 :	aCatalog

+=======================================================================================+
*/
Static function GetArrSbm()

    Local aCatalog  := {}

    DbSelectArea("SBM")
    DbSetOrder(1)
    dbGotop()

    While !Eof()
    	If MSSEEK(xFilial("SBM")+SBM->BM_GRUPO)
    		AADD(aCatalog,{SBM->BM_GRUPO, SBM->BM_DESC})
    	EndIf    	
    	dbSkip()
	End

    DbCloseArea()

return aCatalog
