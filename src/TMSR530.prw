/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR530.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR530  ³ Autor ³ Eduardo de Souza      ³ Data ³ 29/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Movimento de Custo de Transporte                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR530()

Local oReport
Local aArea := GetArea()

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Eduardo de Souza      ³ Data ³ 29/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR530                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local cAliasQry := GetNextAlias()
Local aOrdem    := {}
Local oCusto
Local oTotal1
Local oTotal2

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
oReport:= TReport():New("TMSR530",STR0014,"TMR530", {|oReport| ReportPrint(oReport,cAliasQry,oCusto,oTotal1,oTotal2)},STR0015) // "Movimento de Custo de Transporte" ### "Emite Relacao de Movimento de Custo de Transporte conforme os parametros informados."
oReport:SetTotalInLine(.F.)
oReport:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega as perguntas selecionadas                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01 - Emissao de         ? 									  ³
//³ mv_par02 - Emissao Ate        ? 									  ³
//³ mv_par03 - Cod. Despesa De    ?                              ³
//³ mv_par04 - Cod. Despesa Ate   ?                              ³
//³ mv_par05 - Veiculo de         ?                              ³
//³ mv_par06 - Veiculo Ate        ?                              ³
//³ mv_par07 - Filial Origem De   ?                              ³
//³ mv_par08 - Viagem De          ?                              ³
//³ mv_par09 - Filial Origem At   ?                              ³
//³ mv_par10 - Viagem Ate         ?                              ³
//³ mv_par11 - Conta Contabil De  ?                              ³
//³ mv_par12 - Conta Contabil Ate ?                              ³
//³ mv_par13 - Centro de Custo De ?                              ³
//³ mv_par14 - Centro de Custo Ate?                              ³
//³ mv_par15 - Proprietario De    ?                              ³
//³ mv_par16 - Loja De            ?                              ³
//³ mv_par17 - Proprietario Ate   ?                              ³
//³ mv_par18 - Loja Ate           ?                              ³
//³ mv_par19 - Total por          ?  1=Despesa - 2=Veiculo       ³
//³ 											 3=Viagem  - 4=Conta Contabil³
//³ 											 5=Proprietario              ³
//³ mv_par20 - Data Baixa de      ? 									  ³
//³ mv_par21 - Data Baixa Ate     ? 									  ³
//³ mv_par22 - Status Movto.      ?  1=Em aberto                 ³
//³ 											 2=Baixado                   ³
//³ 											 3=Ambos                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
Aadd( aOrdem, STR0016 ) // "Fil.Origem + Despesa + Emissão + Documento
Aadd( aOrdem, STR0017 ) // "Fil.Origem + Veículo + Emissão + Documento
Aadd( aOrdem, STR0018 ) // "Fil.Origem + Viagem + Emissão + Documento
Aadd( aOrdem, STR0019 ) // "Fil.Origem + Conta Contábil + Emissão + Documento
Aadd( aOrdem, STR0020 ) // "Fil.Origem + Proprietário + Emissão + Documento

oCusto:= TRSection():New(oReport,STR0021,{"SDG","DT7","DA3","SA2"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oCusto:SetTotalInLine(.F.)
TRCell():New(oCusto,"DG_DOC"    ,"SDG",,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_EMISSAO","SDG",,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_CODDES" ,"SDG",STR0029   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DT7_DESCRI","DT7",,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_CODVEI" ,"SDG",,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DA3_DESC"  ,"DA3",/*cTitle*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)
TRCell():New(oCusto,"DG_FILORI" ,"SDG",,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_VIAGEM" ,"SDG",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_CONTA"  ,"SDG",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_ITEMCTA","SDG",STR0032   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_CC"     ,"SDG",STR0033   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_STATUS" ,"SDG",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_VALCOB" ,"SDG",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"DG_SALDO"  ,"SDG",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oCusto,"A2_NOME"   ,"SA2",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.T.)

oTotal1:= TRFunction():New(oCusto:Cell("DG_VALCOB"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
oTotal2:= TRFunction():New(oCusto:Cell("DG_SALDO"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)

Return(oReport)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo de Souza       ³ Data ³ 29/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR520                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,cAliasQry,oCusto,oTotal1,oTotal2)

Local cWhere  := ""
Local cOrder  := ""
Local cSelect := ""
Local cJoin   := ""
Local lIdent  := SDG->(FieldPos("DG_IDENT")) > 0 .And. nModulo<>43

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	

cOrder := "%"
If oReport:Section(1):GetOrder() == 1
	oBreak := TRBreak():New(oCusto,oCusto:Cell("DG_CODDES" ),STR0022,.F.) // "Total da Despesa"
	oTotal1:SetBreak(oBreak)
	oTotal2:SetBreak(oBreak)
	If lIdent
		cOrder += "DTQ_FILORI, DG_CODDES,  DG_EMISSAO, DG_DOC "
	Else
		cOrder += "DG_FILORI, DG_CODDES,  DG_EMISSAO, DG_DOC "
	EndIf
ElseIf oReport:Section(1):GetOrder() == 2
	oBreak := TRBreak():New(oCusto,oCusto:Cell("DG_CODVEI" ),STR0023,.F.) // "Total do Veículo"
	oTotal1:SetBreak(oBreak)
	oTotal2:SetBreak(oBreak)
	If lIdent
		cOrder += "DTQ_FILORI, DG_CODVEI,  DG_EMISSAO, DG_DOC "	
	Else
		cOrder += "DG_FILORI, DG_CODVEI,  DG_EMISSAO, DG_DOC "	
	EndIf
ElseIf oReport:Section(1):GetOrder() == 3
	oBreak := TRBreak():New(oCusto,oCusto:Cell("DG_VIAGEM" ),STR0024,.F.) // "Total da Viagem"
	oTotal1:SetBreak(oBreak)
	oTotal2:SetBreak(oBreak)
	If lIdent
		cOrder += "DTQ_FILORI, DTQ_VIAGEM,  DG_EMISSAO, DG_DOC "	
	Else
		cOrder += "DG_FILORI, DG_VIAGEM,  DG_EMISSAO, DG_DOC "	
	EndIf
ElseIf oReport:Section(1):GetOrder() == 4
	oBreak:= TRBreak():New(oCusto,oCusto:Cell("DG_CONTA"  ),STR0025,.F.) // "Total da Conta Contábil"
	oTotal1:SetBreak(oBreak)
	oTotal2:SetBreak(oBreak)
	If lIdent
		cOrder += "DTQ_FILORI, DG_CONTA, DG_EMISSAO, DG_DOC "	
	Else
		cOrder += "DG_FILORI, DG_CONTA, DG_EMISSAO, DG_DOC "	
	EndIf
ElseIf oReport:Section(1):GetOrder() == 5
	oBreak := TRBreak():New(oCusto,oCusto:Cell("DA3_CODFOR"),STR0026,.F.) // "Total do Proprietário"
	oTotal1:SetBreak(oBreak)
	oTotal2:SetBreak(oBreak)
	If lIdent
		cOrder += "DTQ_FILORI, DA3_CODFOR, DG_EMISSAO, DG_DOC "	
	Else
		cOrder += "DG_FILORI, DA3_CODFOR, DG_EMISSAO, DG_DOC "
	EndIf
EndIf	
cOrder += "%"

cWhere := "%"
If mv_par22 == 1    
	cWhere += "  AND DG_STATUS =  '1' "
ElseIf mv_par22 == 2
	cWhere += "  AND DG_STATUS <> '1' "
	cWhere += "  AND DG_DATBAI BETWEEN  '" + Dtos(mv_par20) + "  'AND'" + Dtos(mv_par21) + "'"  
ElseIf MV_PAR22 == 4
	cWhere += "  AND DG_STATUS =  '2' "
EndIf	 

cSelect := "%"
cJoin   := "%"
If lIdent
	cSelect	+= " DG_DOC,DG_EMISSAO,DG_CODDES,DT7_DESCRI,DG_CODVEI,DA3_DESC,DTQ_FILORI,DTQ_VIAGEM,DG_CONTA,"
	cSelect	+= " DG_ITEMCTA,DG_CC,DG_STATUS,DG_TOTAL,DG_SALDO,A2_NOME, DG_VALCOB "
	
	cJoin	+= "JOIN " + RetSqlName("DTQ")  + "  " + "DTQ"
	cJoin 	+= " ON  DTQ_FILIAL = '"  + xFilial('DTQ') + "'"
	cJoin 	+= " AND DTQ_FILORI >= '" + mv_par07 + "'"
	cJoin 	+= " AND DTQ_VIAGEM >= '" + mv_par08 + "'"
	cJoin 	+= " AND DTQ_FILORI <= '" + mv_par09 + "'"
	cJoin 	+= " AND DTQ_VIAGEM <= '" + mv_par10 + "'"
	cJoin    += " AND DTQ_IDENT  = DG_IDENT"
	cJoin    += " AND DG_TIPUSO  = '1'"
	
	cWhere	+= " "                 
	
Else
	cSelect	+= " DG_DOC,DG_EMISSAO,DG_CODDES,DT7_DESCRI,DG_CODVEI,DA3_DESC,DG_FILORI,DG_VIAGEM,DG_CONTA,
	cSelect	+= " DG_ITEMCTA,DG_CC,DG_STATUS,DG_TOTAL,DG_SALDO,A2_NOME, DG_VALCOB "

	cJoin   += " "
	
	cWhere	+= " AND DG_FILORI >= '" + mv_par07 + "'"
	cWhere	+= " AND DG_VIAGEM >= '" + mv_par08 + "'"
	cWhere	+= " AND DG_FILORI <= '" + mv_par09 + "'" 
	cWhere	+= " AND DG_VIAGEM <= '" + mv_par10 + "'"
EndIf

cSelect += "%"
cJoin   += "%"
cWhere  += "%"

BeginSql Alias cAliasQry
	SELECT %Exp:cSelect%
	   FROM %table:SDG% SDG
	   JOIN %table:DA3% DA3
	      ON DA3_FILIAL = %xFilial:DA3%
	      AND DA3_COD   = DG_CODVEI
	      AND DA3_CODFOR BETWEEN %Exp:mv_par15% AND %Exp:mv_par17%
	      AND DA3_LOJFOR BETWEEN %Exp:mv_par16% AND %Exp:mv_par18%
	      AND DA3.%NotDel%
	   JOIN %table:SA2% SA2
	      ON A2_FILIAL  = %xFilial:SA2%
	      AND A2_COD    = DA3_CODFOR
	      AND A2_LOJA   = DA3_LOJFOR
	      AND SA2.%NotDel%
	   JOIN %table:DT7% DT7
	      ON DT7_FILIAL = %xFilial:DT7%
	      AND DT7_CODDES = DG_CODDES
	      AND DT7.%NotDel%
	   %Exp:cJoin%
	   WHERE DG_FILIAL  = %xFilial:SDG%
	      AND DG_EMISSAO BETWEEN %Exp:Dtos(mv_par01)% AND %Exp:Dtos(mv_par02)%
	      AND DG_CODDES  BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
	      AND DG_CODVEI  BETWEEN %Exp:mv_par05% AND %Exp:mv_par06%
	      AND DG_CONTA  BETWEEN  %Exp:mv_par11% AND %Exp:mv_par12%
	      AND DG_CC     BETWEEN  %Exp:mv_par13% AND %Exp:mv_par14%
	      AND SDG.%NotDel%
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

//-- Inicio da impressao do fluxo do relatório
oReport:SetMeter(SDG->(LastRec()))

oReport:Section(1):Print()

Return