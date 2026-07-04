/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FIVEWIN.CH"
#INCLUDE "MATR605.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR605  ³ Autor ³ Marco Bianchi         ³ Data ³ 01/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡Æo de Or‡amentos de Venda                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR605()

Local oReport
Local aAreaSCK  := SCK->(GetArea())

Private lFirst 	:= .T.


//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

RestArea(aAreaSCK)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³01/06/2006³±±
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

Local oReport		:= Nil
Local oOrcVendas	:= Nil
Local cAliasSCK	:= ""
Local cAliasSCJ	:= ""
Local aOrd		:= {STR0027,STR0028,STR0029}	//"Numero"###"Cliente"###"Produto"

lFirst := Iif(Type("lFirst") == "U" .OR. Type("lFirst") <> "L", .T., lFirst)

cAliasSCJ := GetNextAlias()
cAliasSCK := cAliasSCJ

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
oReport := TReport():New("MATR605",STR0024,"MTR605", {|oReport| ReportPrint(oReport,cAliasSCK,cAliasSCJ,oOrcVendas)},STR0025 + " " + STR0026)	// "Relacao dos Orcamentos de Venda"###"Este relatorio irá imprimir a relaçäo dos Orçamentos de Venda"###"conforme os parametros solicitados.                          "
oReport:SetLandscape(.T.) 
oReport:SetTotalInLine(.F.)

Pergunte(oReport:uParam,.F.)
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
// Secao Principal
oOrcVendas := TRSection():New(oReport,STR0038,{"SCK","SCJ","SCL","SA1","SB1"},aOrd,/*Campos do SX3*/,/*Campos do SIX*/)
oOrcVendas:SetTotalInLine(.F.)
TRCell():New(oOrcVendas,"CK_NUM"			,"SCK",STR0030						,/*Picture*/						,/*Tamanho*/				,/*lPixel*/,{|| (cAliasSCK)->CK_NUM + "-" + (cAliasSCK)->CK_ITEM })
TRCell():New(oOrcVendas,"CK_CLIENTE"	,"SCK",RetTitle("CK_CLIENTE")	,/*Picture*/						,09							,/*lPixel*/,{|| (cAliasSCK)->CK_CLIENTE + "-" + (cAliasSCK)->CK_LOJA })
TRCell():New(oOrcVendas,"A1_NOME"		,"SA1",RetTitle("A1_NOME")		,PesqPict("SA1","A1_NOME")		,TamSX3("A1_NOME")[1]		,/*lPixel*/,{|| SA1->A1_NOME })
TRCell():New(oOrcVendas,"CK_PRODUTO"	,"SCK",RetTitle("CK_PRODUTO")	,PesqPict("SCK","CK_PRODUTO")	,TamSX3("CK_PRODUTO")[1]	,/*lPixel*/,{|| (cAliasSCK)->CK_PRODUTO })
TRCell():New(oOrcVendas,"B1_DESC"		,"SB1",RetTitle("B1_DESC")		,PesqPict("SB1","B1_DESC")		,TamSX3("B1_DESC")[1]		,/*lPixel*/,{|| SB1->B1_DESC })
TRCell():New(oOrcVendas,"CK_QTDVEN"		,"SCK",RetTitle("CK_QTDVEN")	,PesqPict("SCK","CK_QTDVEN")	,TamSX3("CK_QTDVEN")[1]		,/*lPixel*/,{|| (cAliasSCK)->CK_QTDVEN })
TRCell():New(oOrcVendas,"CK_PRCVEN"		,"SCK",RetTitle("CK_PRCVEN")	,PesqPict("SCK","CK_PRCVEN")	,TamSX3("CK_PRCVEN")[1]		,/*lPixel*/,{|| xMoeda((cAliasSCK)->CK_PRCVEN,(cAliasSCK)->CJ_MOEDA,MV_PAR13,(cAliasSCK)->CJ_EMISSAO) })
TRCell():New(oOrcVendas,"CK_VALOR"		,"SCK",RetTitle("CK_VALOR")	    ,PesqPict("SCK","CK_VALOR")  	,TamSX3("CK_VALOR")[1]		,/*lPixel*/,{|| xMoeda((cAliasSCK)->CK_VALOR,(cAliasSCK)->CJ_MOEDA,MV_PAR13,(cAliasSCK)->CJ_EMISSAO) })
TRCell():New(oOrcVendas,"CL_PRODUTO"	,"SCL",STR0031					,PesqPict("SCL","CL_PRODUTO")	,TamSX3("CL_PRODUTO")[1]	,/*lPixel*/,{|| SCL->CL_PRODUTO })
TRCell():New(oOrcVendas,"CL_DESCRI"		,"SCL",STR0032					,PesqPict("SCL","CL_DESCRI")	,TamSX3("CL_DESCRI")[1]		,/*lPixel*/,{|| SCL->CL_DESCRI })
TRCell():New(oOrcVendas,"CL_QUANT"		,"SCL",STR0039   				,PesqPict("SCL","CL_QUANT") 	,TamSX3("CL_QUANT")[1]		,/*lPixel*/,{|| SCL->CL_QUANT })
TRCell():New(oOrcVendas,"CL_TOTAL"		,"SCL",STR0033              	,PesqPict("SCK","CK_VALOR")	    ,TamSX3("CK_VALOR")[1]		,/*lPixel*/,{|| SCL->CL_QUANT * (cAliasSCK)->CK_QTDVEN })
TRCell():New(oOrcVendas,"CJ_STATUS"		,"SCJ",RetTitle("CJ_STATUS")	,PesqPict("SCJ","CJ_STATUS")	,TamSX3("CJ_STATUS")[1]		,/*lPixel*/,{|| (cAliasSCJ)->CJ_STATUS })

TRFunction():New(oOrcVendas:Cell("CK_QTDVEN") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| IIf(	lFirst,(cAliasSCK)->CK_QTDVEN,0) },.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oOrcVendas:Cell("CK_PRCVEN") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| IIf(	lFirst,xMoeda((cAliasSCK)->CK_PRCVEN,(cAliasSCK)->CJ_MOEDA,MV_PAR13,(cAliasSCK)->CJ_EMISSAO),0) },.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oOrcVendas:Cell("CK_VALOR")  ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| IIf(	lFirst,xMoeda((cAliasSCK)->CK_VALOR,(cAliasSCK)->CJ_MOEDA,MV_PAR13,(cAliasSCK)->CJ_EMISSAO),0) },.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³02/06/2006³±±
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
Static Function ReportPrint(oReport,cAliasSCK,cAliasSCJ,oOrcVendas)

Local lQuery 	:= .F.
Local cOrder	:= ""
Local cQuebra 	:= ""
Local cTotalText:= ""
Local cCondicao := ""
Local cFilSCL	:= xFilial("SCL")

lFirst := Iif(Type("lFirst") == "U" .OR. Type("lFirst") <> "L", .T., lFirst)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

If mv_par11 == 1
   TRFunction():New(oOrcVendas:Cell("CL_TOTAL") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oReport:Section(1):GetOrder() == 1
	// por Numero
	cOrder := "%CK_NUM,CK_ITEM%"
	cTotalText:= STR0036
ElseIf oReport:Section(1):GetOrder() == 2
	// por Cliente
	cOrder := "%CK_CLIENTE,CK_LOJA,CK_NUM,CK_ITEM%"
	cTotalText:= STR0034	
Else
	// por Produto
	cOrder := "%CK_PRODUTO,CK_NUM,CK_ITEM%"
	cTotalText:= STR0037	
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lQuery := .T.

oReport:Section(1):BeginQuery()	
BeginSql Alias cAliasSCK
	SELECT CJ_FILIAL, CJ_CLIENTE, CJ_LOJA, CJ_EMISSAO, CJ_NUM, CJ_STATUS, CJ_MOEDA, CK_FILIAL, CK_NUM, CK_PRODUTO,
	       CK_ITEM, CK_CLIENTE, CK_LOJA, CK_QTDVEN, CK_PRCVEN, CK_VALOR
	  FROM %table:SCJ% SCJ, %table:SCK% SCK
	 WHERE SCJ.CJ_FILIAL = %xFilial:SCJ%
	   AND SCJ.CJ_CLIENTE >= %Exp:mv_par01% AND SCJ.CJ_CLIENTE <= %Exp:mv_par02%
	   AND SCJ.CJ_EMISSAO >= %Exp:DtoS(mv_par03)% AND SCJ.CJ_EMISSAO <= %Exp:DtoS(mv_par04)%
	   AND SCJ.CJ_NUM >= %Exp:mv_par05% AND SCJ.CJ_NUM <= %Exp:mv_par06%
	   AND SCJ.%notdel% 
	   AND SCK.CK_FILIAL = %xFilial:SCK%
	   AND SCK.CK_PRODUTO >= %Exp:mv_par07% AND SCK.CK_PRODUTO <= %Exp:mv_par08%
	   AND SCK.CK_NUM = SCJ.CJ_NUM
	   AND SCK.%notdel% 		
	ORDER BY %Exp:cOrder%
EndSql 
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
TRPosition():New(oReport:Section(1),"SA1",1,{|| xFilial("SA1") + (cAliasSCK)->CK_CLIENTE + (cAliasSCK)->CK_LOJA})
TRPosition():New(oReport:Section(1),"SB1",1,{|| xFilial("SB1") + (cAliasSCK)->CK_PRODUTO})
                            
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Init()
oReport:SetMeter((cAliasSCK)->(LastRec()))
dbSelectArea(cAliasSCK)
While !oReport:Cancel() .And. !(cAliasSCK)->(Eof())

	If (mv_par12 == 2 .And. (cAliasSCJ)->CJ_STATUS <> "A") .Or. (mv_par12 == 3 .And. (cAliasSCJ)->CJ_STATUS <> "B") .Or. (mv_par12 == 4 .And. (cAliasSCJ)->CJ_STATUS <> "C")
		dbSelectArea(cAliasSCK)
		(cAliasSCK)->(DbSkip())
		If oReport:Section(1):GetOrder() <> 1
			C605Quebra(oReport,cQuebra,cAliasSCK,cTotalText)
		EndIf
		Loop
	EndIf
	If mv_par11 == 1					// Lista Componentes = Sim
		dbSelectArea("SCL")
		dbSetOrder(1)
	   	lFirst := .T.
		If SCL->(DbSeek(cFilSCL + (cAliasSCK)->CK_NUM + (cAliasSCK)->CK_ITEM))
			While SCL->(! Eof()) .And. SCL->CL_FILIAL == cFilSCL .And. SCL->CL_NUM == (cAliasSCK)->CK_NUM .And. SCL->CL_ITEMORC == (cAliasSCK)->CK_ITEM

				If SCL->CL_PRODUTO < mv_par09 .Or. SCL->CL_PRODUTO > mv_par10
					SCL->(DbSkip())
					Loop
				EndIf

				If lFirst
					oReport:Section(1):Cell("CK_NUM"		):Show()
					oReport:Section(1):Cell("CK_CLIENTE"	):Show()
					oReport:Section(1):Cell("A1_NOME"		):Show()
					oReport:Section(1):Cell("CK_PRODUTO"	):Show()
					oReport:Section(1):Cell("B1_DESC"		):Show()
					oReport:Section(1):Cell("CK_QTDVEN"		):Show()
					oReport:Section(1):Cell("CK_PRCVEN"		):Show()
					oReport:Section(1):Cell("CK_VALOR"		):Show()
					oReport:Section(1):Cell("CL_PRODUTO"	):Show()
					oReport:Section(1):Cell("CL_DESCRI"		):Show()
					oReport:Section(1):Cell("CL_QUANT"		):Show()
					oReport:Section(1):Cell("CL_TOTAL"		):Show()
				Else
 					oReport:Section(1):Cell("CK_NUM"		):Hide()
					oReport:Section(1):Cell("CK_CLIENTE"	):Hide()
					oReport:Section(1):Cell("A1_NOME"		):Hide()
					oReport:Section(1):Cell("CK_PRODUTO"	):Hide()
					oReport:Section(1):Cell("B1_DESC"		):Hide()
					oReport:Section(1):Cell("CK_QTDVEN"		):Hide()
					oReport:Section(1):Cell("CK_PRCVEN"		):Hide()
					oReport:Section(1):Cell("CK_VALOR"		):Hide()
					oReport:Section(1):Cell("CL_PRODUTO"	):Show()
					oReport:Section(1):Cell("CL_DESCRI"		):Show()
					oReport:Section(1):Cell("CL_QUANT"		):Show()
					oReport:Section(1):Cell("CL_TOTAL"		):Show()
				EndIf
				oReport:Section(1):PrintLine()

				If lFirst
				   lFirst := .F.
				EndIf

			   dbSelectArea("SCL")
			   SCL->(DbSkip())
			EndDo
		Else

			oReport:Section(1):Cell("CK_NUM"		):Show()
			oReport:Section(1):Cell("CK_CLIENTE"	):Show()
			oReport:Section(1):Cell("A1_NOME"		):Show()
			oReport:Section(1):Cell("CK_PRODUTO"	):Show()
			oReport:Section(1):Cell("B1_DESC"		):Show()
			oReport:Section(1):Cell("CK_QTDVEN"		):Show()
			oReport:Section(1):Cell("CK_PRCVEN"		):Show()
			oReport:Section(1):Cell("CK_VALOR"		):Show()
			oReport:Section(1):Cell("CL_PRODUTO"	):Show()
			oReport:Section(1):Cell("CL_DESCRI"		):Show()
			oReport:Section(1):Cell("CL_QUANT"		):Show()
			oReport:Section(1):Cell("CL_TOTAL"		):Show()

			oReport:Section(1):PrintLine()
		EndIf
	Else
		oReport:Section(1):Cell("CK_NUM"):Show()
		oReport:Section(1):Cell("CK_CLIENTE"):Show()
		oReport:Section(1):Cell("A1_NOME"):Show()
		oReport:Section(1):Cell("CK_PRODUTO"):Show()
		oReport:Section(1):Cell("B1_DESC"):Show()
		oReport:Section(1):Cell("CK_QTDVEN"):Show()
		oReport:Section(1):Cell("CK_PRCVEN"):Show()
		oReport:Section(1):Cell("CK_VALOR"):Show()
		oReport:Section(1):Cell("CL_PRODUTO"):Hide()
		oReport:Section(1):Cell("CL_DESCRI"):Hide()
		oReport:Section(1):Cell("CL_QUANT"):Hide()
		oReport:Section(1):Cell("CL_TOTAL"):Hide()
		oReport:Section(1):PrintLine()
	EndIf

	// Identifica quebra
	If oReport:Section(1):GetOrder() == 1 
		cQuebra := (cAliasSCK)->CK_NUM
	ElseIf oReport:Section(1):GetOrder() == 2
		cQuebra := (cAliasSCK)->CK_CLIENTE+(cAliasSCK)->CK_LOJA
	Else
		cQuebra := (cAliasSCK)->CK_PRODUTO
	EndIf

	dbSelectArea(cAliasSCK)
	(cAliasSCK)->(DbSkip())

	// Impressao da Secao 2: Totalizadores da Secao
	If (oReport:Section(1):GetOrder() == 1 .And. cQuebra <> (cAliasSCK)->CK_NUM) .Or.;
		(oReport:Section(1):GetOrder() == 2 .And. cQuebra <> (cAliasSCK)->CK_CLIENTE+(cAliasSCK)->CK_LOJA) .Or.;
		(oReport:Section(1):GetOrder() == 3 .And. cQuebra <> (cAliasSCK)->CK_PRODUTO)

		oReport:Section(1):SetTotalText(cTotalText)
		oReport:Section(1):Finish()
		oReport:Section(1):Init()

	EndIf
	oReport:IncMeter()

EndDo

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³C605Quebra³ Autor ³ Marco Bianchi         ³ Data ³07/12/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica quebra do relatorio.                               ³±±
±±³          ³                                                            ³±±
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
Static Function C605Quebra(oReport,cQuebra,cAliasSCK,cTotalText)
        
// Impressao da Secao 2: Totalizadores da Secao
If (oReport:Section(1):GetOrder() == 1 .And. cQuebra <> (cAliasSCK)->CK_NUM) .Or.;
	(oReport:Section(1):GetOrder() == 2 .And. cQuebra <> (cAliasSCK)->CK_CLIENTE+(cAliasSCK)->CK_LOJA) .Or.;
	(oReport:Section(1):GetOrder() == 3 .And. cQuebra <> (cAliasSCK)->CK_PRODUTO)
	
	oReport:Section(1):SetTotalText(cTotalText)
	oReport:Section(1):Finish()
	oReport:Section(1):Init()
EndIf
// Identifica quebra
If oReport:Section(1):GetOrder() == 1
	cQuebra := (cAliasSCK)->CK_NUM
ElseIf oReport:Section(1):GetOrder() == 2
	cQuebra := (cAliasSCK)->CK_CLIENTE+(cAliasSCK)->CK_LOJA
Else
	cQuebra := (cAliasSCK)->CK_PRODUTO
EndIf

Return