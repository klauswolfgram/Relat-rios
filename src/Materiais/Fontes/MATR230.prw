/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR230.CH" 
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR230  ³ Autor ³ Nereu Humberto Junior ³ Data ³ 21/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Requisicoes para consumo                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR230()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³21.06.2006³±±
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
Local aOrdem	:= {}
Local cAliasSD3	:= GetNextAlias()
Local nTamVlr	:= TamSX3('D3_CUSTO1' )[1]
Local cPictVl	:= X3Picture('D3_CUSTO1')
Local lVeiculo	:= Upper(GetMv("MV_VEICULO"))=="S"
Private cPerg		:= "MTR230"

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
oReport:= TReport():New("MATR230",STR0001,cPerg, {|oReport| ReportPrint(oReport,cAliasSD3)},STR0002+" "+STR0003+" "+STR0004) //"Requisicoes para Consumo"##"Emite a relacao das requisicoes feitas para consumo , dividindo por"##"Centro de Custo requisitante ou Conta Contabil.Este relatorio e' um"##"pouco demorado porque ele cria o arquivo de indice na hora."
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // De  Centro de Custo                          ³
//³ mv_par02     // Ate Centro de Custo                          ³
//³ mv_par03     // Moeda Selecionada ( 1 a 5 )                  ³
//³ mv_par04     // De  Local                                    ³
//³ mv_par05     // Ate Local                                    ³
//³ mv_par06     // Da  Data                                     ³
//³ mv_par07     // Ate Data                                     ³
//³ mv_par08     // Do  Produto                                  ³
//³ mv_par09     // Ate Produto                                  ³
//³ mv_par10     // Do  Tipo                                     ³
//³ mv_par11     // Ate Tipo                                     ³
//³ mv_par12     // Do  Grupo                                    ³
//³ mv_par13     // Ate Grupo                                    ³
//³ mv_par14     // Da  Conta Contabil                           ³
//³ mv_par15     // Ate Conta Contabil                           ³
//³ mv_par16     // Considera Transferência ?                    ³
//³ mv_par17     // Da  Codigo Item                              ³
//³ mv_par18     // Ate Codigo Item                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

Aadd( aOrdem, STR0005 ) // " Centro Custo "
Aadd( aOrdem, STR0006 ) // " Cta.Contabil "

oSection1 := TRSection():New(oReport,STR0026,{"SD3","SB1"},aOrdem) //"Itens de Movimentação Interna"
oSection1 :SetTotalInLine(.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nao e permitida a personalizacao de celulas do relatorio, pois o       ³
//³ mesmo totaliza as movimentecoes da SD3 para cada produto.              ³
//³ Dessa forma, nao faz sentido incluir celulas especificas de cada       ³
//³ movimento.                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 :SetEditCell(.F.)

TRCell():New(oSection1,"D3_EMISSAO"	,"SD3",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D3_CC"		,"SD3",/*Titulo*/			,/*Picture*/,TamSX3('D3_CC' )[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cDescCC"	,"   ",STR0021				,"@!"		,Iif(TamSX3('I3_DESC' )[1]<40, TamSX3('I3_DESC' )[1],40)	,/*lPixel*/,/*{|| code-block de impressao }*/) //Descricao
TRCell():New(oSection1,"D3_CONTA"	,"SD3",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cDesCont"	,"   ",STR0021				,"@!"		,25			,/*lPixel*/,/*{|| code-block de impressao }*/) //Descricao
TRCell():New(oSection1,"nAc2"		,"   ",STR0022				,cPictVl	,nTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor"
TRCell():New(oSection1,"B1_COD"		,"SB1",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_CODITE"	,"SB1",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| SB1->B1_CODITE+' '+SB1->B1_COD })
TRCell():New(oSection1,"B1_DESC"	,"SB1",/*Titulo*/			,/*Picture*/,25			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_UM"		,"SB1",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"nAp1"		,"   ",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
oSection1:Cell("nAp1"):GetFieldInfo("D3_QUANT")
TRCell():New(oSection1,"nUnit"		,"   ",STR0023+CRLF+STR0024,cPictVl		,nTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Custo"##"Unitario"
TRCell():New(oSection1,"nAp2"		,"   ",STR0023+CRLF+STR0025,cPictVl		,nTamVlr	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") //"Custo"##"Total"
TRCell():New(oSection1,"D3_GRUPO"	,"SD3",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³21.06.2006³±±
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
Static Function ReportPrint(oReport,cAliasSD3)

Local oSection1	:= oReport:Section(1)
Local nOrdem	:= oReport:Section(1):GetOrder()
Local cTitulo	:= ""
Local cOrder	:= ""
Local cCampoCus	:= ""
Local lImprime	:= .T.
Local lLista	:= .F.
Local nAp1		:= 0
Local nAp2		:= 0
Local nUnit		:= 0
Local aEntCt	:= { "CT1", "CTT" }
Local oBreak
Local oBreak2
Local dEmissao
Local cProd		:= ""
Local cWhere	:= ""
Local cFilialSB1:= XFILIAL("SB1")
Local lVeiculo	:= Upper(GetMv("MV_VEICULO"))=="S"

If nOrdem == 1
	oBreak  := TRBreak():New(oSection1,{|| oSection1:Cell('D3_CC'):GetValue()+ oSection1:Cell('D3_GRUPO'):GetValue() },STR0014,.F.) //"Total do Grupo "
	oBreak2 := TRBreak():New(oSection1,oSection1:Cell("D3_CC"),STR0015,.F.) //"Total Centro de Custo "

	TRFunction():New(oSection1:Cell("nAp1"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection1:Cell("nAp2"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.F.)

	TRFunction():New(oSection1:Cell("nAp1"),NIL,"SUM",oBreak2,"",/*cPicture*/,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("nAp2"),NIL,"SUM",oBreak2,"",/*cPicture*/,/*uFormula*/,.F.,.T.)

	cTitulo  := " (Por "+AllTrim(STR0005)+" ,em "+AllTrim(GetMv("MV_SIMB"+LTrim(Str(mv_par03))))+")"
	oReport:SetTitle( oReport:Title()+cTitulo)

	oSection1:Cell("D3_EMISSAO"):Disable()
	oSection1:Cell("D3_CONTA"):Disable()
	oSection1:Cell("cDesCont"):Disable()
	oSection1:Cell("nAc2"):Disable()

ElseIf nOrdem == 2

	oBreak  := TRBreak():New(oSection1,oSection1:Cell("D3_CONTA"),STR0018,.F.) //"Total da Conta --> "

	TRFunction():New(oSection1:Cell("nAc2"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.)

	cTitulo  := " (Por "+AllTrim(STR0006)+" ,em "+AllTrim(GetMv("MV_SIMB"+LTrim(Str(mv_par03))))+")"
	oReport:SetTitle( oReport:Title()+cTitulo)

	oSection1:Cell("B1_COD"):Disable()
	oSection1:Cell("B1_DESC"):Disable()
	oSection1:Cell("B1_UM"):Disable()
	oSection1:Cell("nAp1"):Disable()
	oSection1:Cell("nUnit"):Disable()
	oSection1:Cell("nAp2"):Disable()
	oSection1:Cell("D3_GRUPO"):Disable()

EndIf

dbSelectArea("SD3")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()

cWhere :="%"
If ! lVeiculo
	cWhere += "AND D3_COD >= '"+mv_par08+"' AND D3_COD <= '"+mv_par09+"'"
EndIf
If mv_par16 == 2
	cWhere += " AND D3_CF <> 'RE4' AND D3_CF <> 'DE4'"
EndIf
cWhere +="%"

cOrder := "%"
If nOrdem == 1
	cOrder += " D3_FILIAL, D3_CC, D3_GRUPO, D3_COD  "
Else
	cOrder += " D3_FILIAL, D3_CONTA, D3_CC, D3_COD  "
EndIf
cOrder += "%"

BeginSql Alias cAliasSD3

	SELECT SD3.*

	FROM %table:SD3% SD3

	WHERE D3_FILIAL = %xFilial:SD3%
		AND D3_CC BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
		AND D3_LOCAL BETWEEN %Exp:mv_par04% AND %Exp:mv_par05%
		AND D3_TIPO BETWEEN %Exp:mv_par10% AND %Exp:mv_par11%
		AND D3_CONTA BETWEEN %Exp:mv_par14%	AND %Exp:mv_par15%
		AND D3_EMISSAO BETWEEN %Exp:mv_par06% AND %Exp:mv_par07%
		AND D3_GRUPO BETWEEN %Exp:mv_par12%	AND %Exp:mv_par13%
		AND D3_ESTORNO = ' '
		AND SD3.%NotDel%
		%Exp:cWhere%

	ORDER BY %Exp:cOrder%

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
TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1") + cProd})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o campo a ser impresso no valor de acordo com a moeda selecionada ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCampoCus := "D3_CUSTO"+Str(mv_par03,1)
If ! lVeiculo
	oSection1:Cell("B1_CODITE"):Disable()
Else
	oSection1:Cell("B1_COD"):Disable()
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(SD3->(LastRec()))

Do Case

	Case nOrdem == 1
		oSection1:Init()
		dbSelectArea(cAliasSD3)
		While !oReport:Cancel() .And. (cAliasSD3)->(!Eof())

			If oReport:Cancel()
				Exit
			EndIf

			cCcant := (cAliasSD3)->D3_CC
			oSection1:Cell("D3_CC"):SetValue(cCcant)
			lImprime := .T.

			While !oReport:Cancel() .And. (cAliasSD3)->(!Eof()) .And. (cAliasSD3)->D3_FILIAL+(cAliasSD3)->D3_CC == xFilial("SD3")+cCCAnt
				cGrupant := (cAliasSD3)->D3_GRUPO
				oSection1:Cell("D3_GRUPO"):SetValue(cGrupant)
				While !oReport:Cancel() .And. (cAliasSD3)->(!Eof()) .And. (cAliasSD3)->D3_FILIAL+(cAliasSD3)->D3_CC+(cAliasSD3)->D3_GRUPO == xFilial("SD3")+cCCAnt+cGrupAnt

					If lVeiculo
						lT := .T.
						dbSelectArea("SB1")
						MsSeek( cFilialSB1 + (cAliasSD3)->D3_COD )
						If !Eof()
							If (SB1->B1_CODITE >= mv_par17 .And. SB1->B1_CODITE <= mv_par18)
								lT := .F.
							EndIf
						EndIf
						dbSelectArea(cAliasSD3)
						If lT
							dbSkip()
							Loop
						EndIf
					EndIf

					cProd	 := (cAliasSD3)->D3_COD
					cD3Local := (cAliasSD3)->D3_LOCAL
					Store 0 To nAp1,nAp2
					While !oReport:Cancel() .And. (cAliasSD3)->(!Eof()) .And. (cAliasSD3)->D3_FILIAL+(cAliasSD3)->D3_CC+(cAliasSD3)->D3_GRUPO+(cAliasSD3)->D3_COD+(cAliasSD3)->D3_LOCAL == xFilial("SD3")+cCCAnt+cGrupAnt+cProd+cD3Local

						oReport:IncMeter()

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ So' entra requisicao e devolucao                      ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If SubStr((cAliasSD3)->D3_CF,2,1) != "E"
							dbSkip()
							Loop
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Se tiver numero de OP nao e' para consumo , portanto  ³
						//³ nao deve entrar                                       ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If SubStr((cAliasSD3)->D3_OP,7,2) # "OS" .And. !Empty((cAliasSD3)->D3_OP)
							dbSkip()
							Loop
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Eu estou somando as requisicoes e subtraindo as  devolucoes ³
						//³porque este mapa tem o objetivo de totalizar os movimentos  ³
						//³internos,nao tem sentido mostrar um monte de valores negati-³
						//³vos ,sendo que as requisicoes normalmente serao maiores  que³
						//³as devolucoes.                                              ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If (cAliasSD3)->D3_TM <= "500"
							nAp1 -= (cAliasSD3)->D3_QUANT
							nAp2 -= (cAliasSD3)->&(cCampoCus)
						Else
							nAp1 += (cAliasSD3)->D3_QUANT
							nAp2 += (cAliasSD3)->&(cCampoCus)
						EndIf
						dbSkip()
					EndDo
					If nAp1 != 0 .Or. nAp2 != 0

						SB1->(MsSeek(xFilial("SB1")+cProd))
						If nAp1 = 0
							nUnit := nAp2
						Else
							nUnit := nAp2/nAp1
						EndIf
						oSection1:Cell("cDescCC"):SetValue(DescCC(cCcant, mv_par03))
						oSection1:Cell("nAp1"):SetValue(nAp1)
						oSection1:Cell("nUnit"):SetValue(nUnit)
						oSection1:Cell("nAp2"):SetValue(nAp2)

						If lImprime
							oSection1:Cell("D3_CC"):Show()
							oSection1:Cell("cDescCC"):Show()
							lImprime := .F.
						Else
							oSection1:Cell("D3_CC"):Hide()
							oSection1:Cell("cDescCC"):Hide()
						EndIf
						oSection1:PrintLine()
					EndIf
				EndDo
			EndDo
		EndDo
		oSection1:Finish()

	Case nOrdem == 2

		oSection1:Init()
		dbSelectArea(cAliasSD3)
		While !oReport:Cancel() .And. (cAliasSD3)->(!Eof())
			cContant := (cAliasSD3)->D3_CONTA
			oSection1:Cell("D3_CONTA"):SetValue(cContant)
			While !oReport:Cancel() .And. (cAliasSD3)->(!Eof()) .And. (cAliasSD3)->D3_FILIAL+(cAliasSD3)->D3_CONTA == xFilial("SD3")+cContant
				dbSelectArea(cAliasSD3)
				cCcant := (cAliasSD3)->D3_CC
				oSection1:Cell("D3_CC"):SetValue(cCcant)
				Store 0 To nAc2
				lLista:=.F.
				While !oReport:Cancel() .And. (cAliasSD3)->(!Eof()) .And. (cAliasSD3)->D3_FILIAL+(cAliasSD3)->D3_CONTA+(cAliasSD3)->D3_CC == xFilial("SD3")+cContant+cCCAnt

					If oReport:Cancel()
						Exit
					EndIf

					oReport:IncMeter()

					dbSelectArea(cAliasSD3)
					If lVeiculo
						lT := .T.
						dbSelectArea("SB1")
						MsSeek( cFilialSB1 + (cAliasSD3)->D3_COD )
						If !Eof()
							If (SB1->B1_CODITE >= mv_par17 .And. SB1->B1_CODITE <= mv_par18)
								lT := .F.
							EndIf
						EndIf
						dbSelectArea(cAliasSD3)
						If lT
							dbSkip()
							Loop
						EndIf
					EndIf

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ So' entra requisicao e devolucao                      ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If SubStr((cAliasSD3)->D3_CF,2,1) != "E"
						dbSkip()
						Loop
					EndIf
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Se tiver numero de OP nao e' para consumo , portanto  ³
					//³ nao deve entrar                                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If SubStr((cAliasSD3)->D3_OP,7,2) # "OS" .And. !Empty((cAliasSD3)->D3_OP)
						dbSkip()
						Loop
					EndIf
					lLista:=.T.
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Eu estou somando as requisicoes e subtraindo as  devolucoes ³
					//³porque este mapa tem o objetivo de totalizar os movimentos  ³
					//³internos,nao tem sentido mostrar um monte de valores negati-³
					//³vos ,sendo que as requisicoes normalmente serao maiores  que³
					//³as devolucoes.                                              ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If D3_TM <= "500"
						nAc2 -= (cAliasSD3)->&(cCampoCus)
					Else
						nAc2 += (cAliasSD3)->&(cCampoCus)
					EndIf
					dEmissao := (cAliasSD3)->D3_EMISSAO
					oSection1:Cell("cDescCC"):SetValue(DescCC(cCcant, mv_par03))
					oSection1:Cell("D3_EMISSAO"):SetValue(dEmissao)

					dbSkip()
				EndDo
				If lLista

					dbSelectArea(aEntCt[1])
					MsSeek(xFilial()+cContant)

					dbSelectArea(cAliasSD3)
					oSection1:Cell("cDesCont"):SetValue(SubStr(If(aEntCt[1] = "CT1", &("CT1->CT1_DESC" + StrZero(mv_par03, 2)),AllTrim(SI1->I1_DESC)),1,25))
					oSection1:Cell("nAc2"):SetValue(nAc2)

					oSection1:PrintLine()

				EndIf
			EndDo
	EndDo
	oSection1:Finish()
EndCase

Return NIL





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³DescCC    ºAutor  ³Fernando Joly       º Data ³  08/13/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna a Descricao do Centro de Custo                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function DescCC(cCC, nMoeda)

Local aAreaAnt	:= GetArea()
Local aAreaCC	:= {}
Local cRet		:= ""
Local cSeekCC	:= ''
Local cAliasCC	:= 'CTT'
Local nTamDESC	:= Iif(Len(SI3->I3_DESC)<40, Len(SI3->I3_DESC),40)

Default cCC        := ''
Default nMoeda     := 1

cRet := Replicate('*', nTamDESC)

dbSelectArea(cAliasCC)
aAreaCC := GetArea()
dbSetOrder(1)
If MsSeek(cSeekCC:=xFilial(cAliasCC)+cCC, .F.)
	cRet := Left(&('CTT_DESC'+StrZero(nMoeda, 2)), nTamDESC) //-- Do mesmo tamanho do I3_DESC, para manter a compatibilidade
EndIf
RestArea(aAreaCC)
RestArea(aAreaAnt)

Return cRet
