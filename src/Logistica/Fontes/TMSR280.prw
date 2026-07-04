/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR280.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR280  ³ Autor ³ Eduardo de Souza      ³ Data ³ 29/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de viagens              		                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR280()

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
±±³Programa  ³ReportDef ³ Autor ³ Eduardo de Souza      ³ Data ³ 26/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local cAliasQry := GetNextAlias()
Local aOrdem    := {}
Local lTercRbq  := DTR->(ColumnPos("DTR_CODRB3")) > 0

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
oReport:= TReport():New("TMSR280",STR0017,"TMR280", {|oReport| ReportPrint(oReport,cAliasQry)},STR0018) // "Relacao de viagens" ### "Emite Relacao de viagens conforme os parametros informados"
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³mv_par01  Filial de Origem De  ?    ³
//³mv_par02  Filial de Origem Ate ?    ³
//³mv_par01  Servic. Transporte De  ?  ³
//³mv_par02  Servic. Transporte Ate ?  ³
//³mv_par01  Data Geracao De  ?        ³
//³mv_par02  Data Geracao Ate ?        ³
//³mv_par07 Filtra Status (COMBOBOX)   ³
//³                 1 - Sim            ³
//³                 2 - Nao            ³
//³mv_par08 Status (COMBOBOX)          ³
//³                 1 - Em Aberto      ³
//³                 2 - Em Transito    ³
//³                 3 - Encerrada      ³
//³                 4 - Chagada parcial³
//³                 5 - Cancelada      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
Aadd( aOrdem, STR0019 ) // "Status + Fil.Origem + Viagem"

oStatus:= TRSection():New(oReport,STR0020,{"DTQ"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oStatus:SetTotalInLine(.F.)
oStatus:SetTotalText(STR0021) //-- "Total do Status"
TRCell():New(oStatus,"DTQ_STATUS","DTQ",/*cTitle*/,/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oViagem:= TRSection():New(oStatus,STR0022,{"DTQ"},/*Ordem do Relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oViagem:SetTotalInLine(.F.)
TRCell():New(oViagem,"DTQ_DATGER","DTQ",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_HORGER","DTQ",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_FILORI","DTQ",/*cTitle*/,/*Picture*/,8 /*Tamanho*/,/*lPixel*/, {|| (cAliasQry)->DTQ_FILORI } )
TRCell():New(oViagem,"DTQ_VIAGEM","DTQ",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTQ_FILDES","DTQ",/*cTitle*/,/*Picture*/,8 /*Tamanho*/,/*lPixel*/, {|| (cAliasQry)->DTQ_FILDES } )
TRCell():New(oViagem,"DTQ_TIPVIA","DTQ",/*cTitle*/,/*Picture*/,10/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTR_CODVEI","DTR",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"PLACAVEI"  ,""   ,STR0023   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTR_CODRB1","DTR",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"PLACARB1"  ,""   ,STR0023   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTR_CODRB2","DTR",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"PLACARB2"  ,""   ,STR0023   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
If lTercRbq
	TRCell():New(oViagem,"DTR_CODRB3","DTR",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oViagem,"PLACARB3"  ,""   ,STR0023   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf
TRCell():New(oViagem,"DA4_NREDUZ","DA4",STR0024   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oTotaliz:=TRFunction():New(oViagem:Cell("DTQ_VIAGEM"),/*cId*/,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oStatus)
oTotaliz:SetCondition({ || TMR280Vge((cAliasQry)->DTQ_FILORI,(cAliasQry)->DTQ_VIAGEM) })

Return(oReport)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo de Souza       ³ Data ³ 25/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR430                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,cAliasQry)

Local cWhere := ''
Local cCodRb3 := ''
Local cPlacaRb3 := ''
Local lTercRbq  := DTR->(ColumnPos("DTR_CODRB3")) > 0

If lTercRbq
	cCodRb3 := "%DTR_CODRB3%"
	cPlacaRb3 := "%DA3D.DA3_PLACA PLACARB3%"
EndIf 

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	

// Verifica se filtra ou nao pelo Status
cWhere := "%"
If mv_par07 == 1
	cWhere += " AND DTQ_STATUS = '" + Alltrim(Str(mv_par08)) + "' "
EndIf
cWhere += "%"

BeginSql Alias cAliasQry
	SELECT DTQ_FILIAL, DTQ_FILORI, DTQ_VIAGEM, DTQ_DATGER, DTQ_HORGER, DTQ_FILDES, DTQ_STATUS, DTQ_TIPVIA,
	       DTR_CODVEI, DA3A.DA3_PLACA PLACAVEI, DTR_CODRB1, DA3B.DA3_PLACA PLACARB1, DTR_CODRB2,
	       DA3C.DA3_PLACA PLACARB2, DA4_NREDUZ, %Exp:cCodRb3%, %Exp:cPlacaRb3%
	   FROM %table:DTQ% DTQ
	   JOIN %table:DTR% DTR
	      ON DTR_FILIAL = %xFilial:DTR%
	      AND DTR_FILORI = DTQ_FILORI
	      AND DTR_VIAGEM = DTQ_VIAGEM
	      AND DTR.%NotDel%
	   JOIN %table:DA3% DA3A
	      ON  DA3A.DA3_FILIAL = %xFilial:DA3%
	      AND DA3A.DA3_COD = DTR_CODVEI
	      AND DA3A.%NotDel%
	   LEFT JOIN %table:DA3% DA3B
	      ON  DA3B.DA3_FILIAL = %xFilial:DA3%
	      AND DA3B.DA3_COD = DTR_CODRB1
	      AND DA3B.%NotDel%
	   LEFT JOIN %table:DA3% DA3C
	      ON  DA3C.DA3_FILIAL = %xFilial:DA3%
	      AND DA3C.DA3_COD = DTR_CODRB2
	      AND DA3C.%NotDel%
	   LEFT JOIN %table:DA3% DA3D
	      ON  DA3D.DA3_FILIAL = %xFilial:DA3%
	      AND DA3D.DA3_COD = %Exp:cCodRb3%
	      AND DA3D.%NotDel%
	   JOIN %table:DUP% DUP
	      ON DUP_FILIAL = %xFilial:DUP%
	      AND DUP_FILORI = DTQ_FILORI
	      AND DUP_VIAGEM = DTQ_VIAGEM
	      AND DUP_CODVEI = DTR_CODVEI
	      AND DUP.%NotDel%
	   JOIN %table:DA4% DA4
	      ON  DA4_FILIAL = %xFilial:DA4%
	      AND DA4_COD = DUP_CODMOT
	      AND DA4.%NotDel%
		WHERE DTQ_FILIAL  = %xFilial:DTQ%
	      AND DTQ_FILORI BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
	      AND DTQ_SERTMS BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
	      AND DTQ_DATGER BETWEEN %Exp:Dtos(mv_par05)% AND %Exp:Dtos(mv_par06)%
	      AND DTQ.%NotDel%
			%Exp:cWhere%
	ORDER BY DTQ_FILIAL, DTQ_STATUS, DTQ_FILORI, DTQ_VIAGEM, DTR_CODVEI
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
oReport:SetMeter(DTQ->(LastRec()))

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter( {|cParam| (cAliasQry)->DTQ_STATUS == cParam  }, {|| (cAliasQry)->DTQ_STATUS } )

DbSelectArea(cAliasQry)
While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
	cStatus := (cAliasQry)->DTQ_STATUS
	oReport:Section(1):Init()
	oReport:Section(1):PrintLine()
	While !(cAliasQry)->(Eof()) .And. (cAliasQry)->DTQ_STATUS == cStatus
		cFilOri := (cAliasQry)->DTQ_FILORI
		cViagem := (cAliasQry)->DTQ_VIAGEM
		cCodVei := (cAliasQry)->DTR_CODVEI
		oReport:Section(1):Section(1):Init()
		oReport:Section(1):Section(1):PrintLine()
		(cAliasQry)->(DbSkip())
		While !(cAliasQry)->(Eof()) .And. 	(cAliasQry)->DTQ_STATUS == cStatus .And. ;
														(cAliasQry)->DTQ_FILORI == cFilOri .And. ;
														(cAliasQry)->DTQ_VIAGEM == cViagem
			oReport:Section(1):Section(1):Cell("DTQ_DATGER"):Hide()
			oReport:Section(1):Section(1):Cell("DTQ_HORGER"):Hide()
			oReport:Section(1):Section(1):Cell("DTQ_FILORI"):Hide()
			oReport:Section(1):Section(1):Cell("DTQ_VIAGEM"):Hide()
			oReport:Section(1):Section(1):Cell("DTQ_FILDES"):Hide()
			oReport:Section(1):Section(1):Cell("DTQ_TIPVIA"):Hide()
			If cCodVei == (cAliasQry)->DTR_CODVEI
				oReport:Section(1):Section(1):Cell("DTR_CODVEI"):Hide()
				oReport:Section(1):Section(1):Cell("PLACAVEI"  ):Hide()
				oReport:Section(1):Section(1):Cell("DTR_CODRB1"):Hide()
				oReport:Section(1):Section(1):Cell("PLACARB1"  ):Hide()
				oReport:Section(1):Section(1):Cell("DTR_CODRB2"):Hide()
				oReport:Section(1):Section(1):Cell("PLACARB2"  ):Hide()
				If lTercRbq
					oReport:Section(1):Section(1):Cell("DTR_CODRB3"):Hide()
					oReport:Section(1):Section(1):Cell("PLACARB3"  ):Hide()
				EndIf
         Else
				oReport:Section(1):Section(1):Cell("DTR_CODVEI"):Show()
				oReport:Section(1):Section(1):Cell("PLACAVEI"  ):Show()
				oReport:Section(1):Section(1):Cell("DTR_CODRB1"):Show()
				oReport:Section(1):Section(1):Cell("PLACARB1"  ):Show()
				oReport:Section(1):Section(1):Cell("DTR_CODRB2"):Show()
				oReport:Section(1):Section(1):Cell("PLACARB2"  ):Show()
				If lTercRbq
					oReport:Section(1):Section(1):Cell("DTR_CODRB3"):Show()
					oReport:Section(1):Section(1):Cell("PLACARB3"  ):Show()
				EndIf 
         EndIf
			cCodVei := (cAliasQry)->DTR_CODVEI
			oReport:Section(1):Section(1):PrintLine()
			(cAliasQry)->(DbSkip())
		EndDo
		oReport:Section(1):Section(1):Cell("DTQ_DATGER"):Show()
		oReport:Section(1):Section(1):Cell("DTQ_HORGER"):Show()
		oReport:Section(1):Section(1):Cell("DTQ_FILORI"):Show()
		oReport:Section(1):Section(1):Cell("DTQ_VIAGEM"):Show()
		oReport:Section(1):Section(1):Cell("DTQ_FILDES"):Show()
		oReport:Section(1):Section(1):Cell("DTQ_TIPVIA"):Show()
		oReport:Section(1):Section(1):Cell("DTR_CODVEI"):Show()
		oReport:Section(1):Section(1):Cell("PLACAVEI"  ):Show()
		oReport:Section(1):Section(1):Cell("DTR_CODRB1"):Show()
		oReport:Section(1):Section(1):Cell("PLACARB1"  ):Show()
		oReport:Section(1):Section(1):Cell("DTR_CODRB2"):Show()
		oReport:Section(1):Section(1):Cell("PLACARB2"  ):Show()
		If lTercRbq
			oReport:Section(1):Section(1):Cell("DTR_CODRB3"):Show()
			oReport:Section(1):Section(1):Cell("PLACARB3"  ):Show()
		EndIf
	EndDo
	oReport:Section(1):Section(1):Finish()
	oReport:Section(1):Finish()
EndDo

TMR280Vge(,,.T.) //-- Zera variavel controladora do totalizador

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMR28Vge ³ Autor ³Eduardo de Souza       ³ Data ³ 29/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Controla o totalizador do relatorio                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Filial Origem                                        ³±±
±±³          ³ExpC2: Viagem                                               ³±±
±±³          ³ExpL1: Zera variavel                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR430                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMR280Vge(cFilOri,cViagem,lZera)

Static cVge := ''
Local lRet  := .T.
Default lZera := .F.

If lZera
	cVge := ''
Else
	If cVge == cFilOri+cViagem
		lRet := .F.
	EndIf
	cVge := cFilOri+cViagem
EndIf

Return lRet
