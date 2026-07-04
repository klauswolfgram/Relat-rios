/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR220.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR220  ³ Autor ³ Eduardo de Souza      ³ Data ³ 25/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Utilizacao mensal da Frota                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR220()

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
±±³Programa  ³ReportDef ³ Autor ³ Eduardo de Souza      ³ Data ³ 25/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local cAliasQry  := GetNextAlias()
Local aOrdem    := {}

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
oReport:= TReport():New("TMSR220",STR0018,"TMR220", {|oReport| ReportPrint(oReport,cAliasQry)},STR0019) // "Relacao de Utilizacao mensal da Frota" ### "Emite Relacao de Utilizacao mensal da Frota conforme os parametros informados"
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01  Data De  ?                           			     ³
//³ mv_par02  Data Ate ?                                         |
//| mv_par03  Frota ? 1- Propria                                 |
//|					  2- Terceiro                                |
//|					  3- Agregado                                |
//|					  4- Todas                                   |
//| mv_par04  Tipo de transporte de ?                            |
//| mv_par05  Tipo de transporte Ate?                            |
//| mv_par06  Serv.de transporte de ?                            |
//| mv_par07  Serv.de transporte Ate?                            |
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
Aadd( aOrdem, STR0020 ) // "Frota + Tipo Veículo + Veículo"

oFrota:= TRSection():New(oReport,STR0021,{"DA3"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oFrota:SetTotalInLine(.F.)
oFrota:lReadOnly := .T.
TRCell():New(oFrota,"DA3_FROVEI","DA3",/*cTitle*/,/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oTipVei:= TRSection():New(oFrota,STR0022,{"DA3"},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oTipVei:SetTotalInLine(.F.)
oTipVei:SetTotalText(STR0029) //-- "Total Frota"
oTipVei:lReadOnly := .T.
TRCell():New(oTipVei,"DA3_TIPVEI","DA3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTipVei,"DUT_DESCRI","DUT",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oVeiculo:= TRSection():New(oTipVei,STR0023,{"DA3","DT6"},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
oVeiculo:SetTotalInLine(.F.)
oVeiculo:SetTotalText(STR0030) //-- "Total Tipo Veículo"
oVeiculo:lReadOnly := .T.
TRCell():New(oVeiculo,"DA3_COD"   ,"DA3",/*cTitle*/,/*Picture*/,9/*Tamanho*/,/*lPixel*/, {|| Iif(!Empty((cAliasQry)->DTR_CODRB2),(cAliasQry)->DA3_COD+"*",(cAliasQry)->DA3_COD) } )
TRCell():New(oVeiculo,"DA3_PLACA" ,"DA3",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DA3_CAPACM","DA3",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"QTDVGE"    ,""   ,STR0024   ,/*Picture*/,4/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"QTDDOC"    ,""   ,STR0025   ,/*Picture*/,4/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DT6_QTDVOL","DT6",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DT6_PESO"  ,"DT6",/*cTitle*/,"@E 99,999,999.9999", 15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DT6_PESOM3","DT6",/*cTitle*/,"@E 99,999,999.9999", 15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DT6_PESCOB","DT6",/*cTitle*/,/*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"MARGEM"    ,""   ,STR0026   ,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1],/*lPixel*/,{|| ((cAliasQry)->DTR_VALFRE / (cAliasQry)->DT6_VALTOT ) * 100 })
TRCell():New(oVeiculo,"MARGEMPES" ,""   ,STR0027   ,PesqPict("DT6","DT6_PESO"  ),TamSx3("DT6_PESO"  )[1],/*lPixel*/,{|| ((cAliasQry)->DT6_PESO / (cAliasQry)->DA3_CAPACM ) * 100 })
TRCell():New(oVeiculo,"KMROD"     ,""   ,STR0028   ,PesqPict("DUV","DUV_ODOENT"),TamSx3("DUV_ODOENT")[1],/*lPixel*/,/*{|| code-block de impressao }*/)

TRFunction():New(oVeiculo:Cell("QTDVGE"    ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oTipVei)
TRFunction():New(oVeiculo:Cell("QTDDOC"    ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oTipVei)
TRFunction():New(oVeiculo:Cell("DT6_QTDVOL"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oTipVei)
TRFunction():New(oVeiculo:Cell("DT6_PESO"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oTipVei)
TRFunction():New(oVeiculo:Cell("DT6_PESOM3"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oTipVei)
TRFunction():New(oVeiculo:Cell("DT6_PESCOB"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oTipVei)
TRFunction():New(oVeiculo:Cell("KMROD"     ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oTipVei)

TRFunction():New(oVeiculo:Cell("QTDVGE"    ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFrota)
TRFunction():New(oVeiculo:Cell("QTDDOC"    ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFrota)
TRFunction():New(oVeiculo:Cell("DT6_QTDVOL"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFrota)
TRFunction():New(oVeiculo:Cell("DT6_PESO"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFrota)
TRFunction():New(oVeiculo:Cell("DT6_PESOM3"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFrota)
TRFunction():New(oVeiculo:Cell("DT6_PESCOB"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFrota)
TRFunction():New(oVeiculo:Cell("KMROD"     ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFrota)

oLegenda:= TRSection():New(oReport,STR0031,{},/*Ordem do relatorio*/,/*Campos do SX3*/,/*Campos do SIX*/)
TRCell():New(oLegenda,"LEGENDA","" ,STR0031,/*Picture*/,40/*Tamanho*/,/*lPixel*/, {|| STR0032 } )

Return(oReport)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo de Souza       ³ Data ³ 24/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,cAliasQry)

Local cWhere1 := ''
Local cWhere2 := ''
Local cWhere3 := ''
Local cCodRb3 := ''
Local cPlacaRb3 := ''
Local cOdoEntRb3 := ''
Local cOdoSaiRb3 := ''
Local cDuvCodRb3 := ''
Local lTercRbq   := DUV->(ColumnPos("DUV_CODRB3")) > 0

If lTercRbq
	cCodRb3   := "%DTR_CODRB3%"
	cPlacaRb3 := "%DA3D.DA3_PLACA PLACARB3%"
	cOdoEntRb3 := "%DUV_ODOER3%"
	cOdoSaiRb3 := "%DUV_ODOSR3%"
	cDuvCodRb3 := "%DUV_CODRB3%"
EndIf

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	

cWhere1 := "%"
If mv_par03 <> 4
	cWhere1 += " AND DA3_FROVEI = '" + AllTrim(Str(mv_par03)) + "' "
EndIf
cWhere1 += "%"

cWhere2 := "%"
If mv_par03 <> 4
	cWhere2 += " AND DA3A.DA3_FROVEI = '" + AllTrim(Str(mv_par03)) + "' "
EndIf
cWhere2 += "%"

cWhere3 := "%"
If mv_par03 <> 4
	cWhere3 += " AND DA3B.DA3_FROVEI = '" + AllTrim(Str(mv_par03)) + "' "
EndIf
cWhere3 += "%"

BeginSql Alias cAliasQry
	SELECT DA3_FROVEI, DA3_TIPVEI, DA3_COD, MAX(DA3_PLACA) DA3_PLACA, MAX(DA3_CAPACM) DA3_CAPACM, COUNT(DTQ_VIAGEM) QTDVGE, SUM(QTDDOC) QTDDOC, SUM(DT6_QTDVOL) DT6_QTDVOL, 
	       SUM(DT6_PESO) DT6_PESO, SUM(DT6_PESOM3) DT6_PESOM3, SUM(DT6_PESCOB) DT6_PESCOB, SUM(KMROD) KMROD, MAX(DUT_DESCRI) DUT_DESCRI, SUM(DT6_VALTOT) DT6_VALTOT, 
	       SUM(DTR_VALFRE) DTR_VALFRE, MAX(DTR_CODRB2) DTR_CODRB2, MAX(%Exp:cCodRb3%) %Exp:cCodRb3%
	   FROM (
	    SELECT DTQ_FILORI, DTQ_VIAGEM, MAX(DA3_FROVEI) DA3_FROVEI, MAX(DA3_TIPVEI) DA3_TIPVEI, 
	           MAX(DA3_COD) DA3_COD  , MAX(DA3_CAPACM) DA3_CAPACM, MAX(DA3_PLACA) DA3_PLACA, SUM(DTR_VALFRE) DTR_VALFRE,
	           COUNT(DUD_DOC) QTDDOC     , SUM(DT6_QTDVOL) DT6_QTDVOL, SUM(DT6_PESO) DT6_PESO, SUM(DT6_PESOM3) DT6_PESOM3,
	           SUM(DT6_PESCOB) DT6_PESCOB, SUM(DT6_VALTOT) DT6_VALTOT, MAX(DTR_CODRB2) DTR_CODRB2, MAX(%Exp:cCodRb3%) %Exp:cCodRb3%, MAX(DUV_ODOENT - DUV_ODOSAI) KMROD
	       FROM %table:DTQ% DTQ
	       JOIN %table:DTR% DTR
	         ON DTR_FILIAL = %xFilial:DTR%
	         AND DTR_FILORI = DTQ_FILORI
	         AND DTR_VIAGEM = DTQ_VIAGEM
	         AND DTR.%NotDel%
	       JOIN %table:DA3% DA3
	         ON DA3_FILIAL = %xFilial:DA3%
	         AND DA3_COD = DTR_CODVEI
	         AND DA3.%NotDel%
				%Exp:cWhere1%
	       JOIN %table:DUD% DUD
	         ON DUD_FILIAL = %xFilial:DUD%
	         AND DUD_FILORI = DTQ_FILORI
	         AND DUD_VIAGEM = DTQ_VIAGEM
	         AND DUD.%NotDel%
	       JOIN %table:DT6% DT6
	         ON DT6_FILIAL = %xFilial:DT6%
	         AND DT6_FILDOC = DUD_FILDOC
	         AND DT6_DOC    = DUD_DOC
			 AND DT6_SERIE  = DUD_SERIE
	         AND DT6.%NotDel%
	      LEFT JOIN %table:DUV% DUV
	         ON DUV_FILIAL = %xFilial:DUV%
	         AND DUV_FILORI = DTQ_FILORI
	         AND DUV_VIAGEM = DTQ_VIAGEM
	         AND DUV_CODVEI = DTR_CODVEI
	         AND DUV.%NotDel%
	       WHERE DTQ_FILIAL = %xFilial:DTQ%
	         AND DTQ_DATENC BETWEEN %Exp:Dtos(mv_par01)% AND %Exp:Dtos(mv_par02)%
			 AND DTQ_TIPTRA BETWEEN %Exp:mv_par04% AND %Exp:mv_par05%
			 AND DTQ_SERTMS BETWEEN %Exp:mv_par06% AND %Exp:mv_par07%
	         AND DTQ.%NotDel%
	    GROUP BY DTQ_FILORI, DTQ_VIAGEM
	    UNION ALL
	    SELECT DTQ_FILORI, DTQ_VIAGEM, MAX(DA3A.DA3_FROVEI) DA3_FROVEI, MAX(DA3A.DA3_TIPVEI) DA3_TIPVEI, 
	           MAX(DA3A.DA3_COD) DA3_COD  , MAX(DA3A.DA3_CAPACM + DA3B.DA3_CAPACM) DA3_CAPACM, MAX(DA3A.DA3_PLACA) DA3_PLACA, SUM(DTR_VALFRE) DTR_VALFRE,
	           COUNT(DUD_DOC) QTDDOC     , SUM(DT6_QTDVOL) DT6_QTDVOL, SUM(DT6_PESO) DT6_PESO, SUM(DT6_PESOM3) DT6_PESOM3,
	           SUM(DT6_PESCOB) DT6_PESCOB, SUM(DT6_VALTOT) DT6_VALTOT, MAX(DTR_CODRB2) DTR_CODRB2, MAX(%Exp:cCodRb3%) %Exp:cCodRb3%, MAX(DUV_ODOER1+DUV_ODOER2+%Exp:cOdoEntRb3%-DUV_ODOSR1+DUV_ODOSR2+%Exp:cOdoSaiRb3%) KMROD
	       FROM %table:DTQ% DTQ
	       JOIN %table:DTR% DTR
	         ON DTR_FILIAL = %xFilial:DTR%
	         AND DTR_FILORI = DTQ_FILORI
	         AND DTR_VIAGEM = DTQ_VIAGEM
	         AND DTR_CODRB1 <> ' '
	         AND DTR.%NotDel%
	       JOIN %table:DA3% DA3A
	         ON DA3A.DA3_FILIAL = %xFilial:DA3%
	         AND DA3A.DA3_COD = DTR_CODRB1
				%Exp:cWhere2%
	         AND DA3A.%NotDel%
	       LEFT JOIN %table:DA3% DA3B
	         ON DA3B.DA3_FILIAL = %xFilial:DA3%
	         AND DA3B.DA3_COD = DTR_CODRB2
				%Exp:cWhere3%
	         AND DA3B.%NotDel%
	       LEFT JOIN %table:DA3% DA3C
	         ON DA3C.DA3_FILIAL = %xFilial:DA3%
	         AND DA3C.DA3_COD = (%Exp:cCodRb3%)
				%Exp:cWhere3%
	         AND DA3C.%NotDel%  
	       JOIN %table:DUD% DUD
	         ON DUD_FILIAL = %xFilial:DUD%
	         AND DUD_FILORI = DTQ_FILORI
	         AND DUD_VIAGEM = DTQ_VIAGEM
	         AND DUD.%NotDel%
	       JOIN %table:DT6% DT6
	         ON DT6_FILIAL = %xFilial:DT6%
	         AND DT6_FILDOC = DUD_FILDOC
	         AND DT6_DOC    = DUD_DOC
	         AND DT6_SERIE  = DUD_SERIE
	         AND DT6.%NotDel%
	      LEFT JOIN %table:DUV% DUV
	         ON DUV_FILIAL = %xFilial:DUV%
	         AND DUV_FILORI = DTQ_FILORI
	         AND DUV_VIAGEM = DTQ_VIAGEM
	         AND ( DUV_CODRB1 = DTR_CODRB1
	            OR DUV_CODRB2 = DTR_CODRB2
	            OR %Exp:cDuvCodRb3% = %Exp:cCodRb3% )
	         AND DUV.%NotDel%
	       WHERE DTQ_FILIAL = %xFilial:DTQ%
	         AND DTQ_DATENC BETWEEN %Exp:Dtos(mv_par01)% AND %Exp:Dtos(mv_par02)%
			 AND DTQ_TIPTRA BETWEEN %Exp:mv_par04% AND %Exp:mv_par05%
			 AND DTQ_SERTMS BETWEEN %Exp:mv_par06% AND %Exp:mv_par07%
	         AND DTQ.%NotDel%
	    GROUP BY DTQ_FILORI, DTQ_VIAGEM ) QUERY
   JOIN %table:DUT% DUT
    ON DUT_FILIAL = %xFilial:DUT%
    AND DUT_TIPVEI = DA3_TIPVEI
    AND DUT.%NotDel%
	GROUP BY DA3_FROVEI, DA3_TIPVEI, DA3_COD
	ORDER BY DA3_FROVEI, DA3_TIPVEI, DA3_COD
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
oReport:Section(1):Section(1):SetParentFilter( {|cParam| (cAliasQry)->DA3_FROVEI == cParam }, {|| (cAliasQry)->DA3_FROVEI } )

oReport:Section(1):Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):Section(1):SetParentFilter( {|cParam| (cAliasQry)->DA3_FROVEI+(cAliasQry)->DA3_TIPVEI == cParam }, {|| (cAliasQry)->DA3_FROVEI+(cAliasQry)->DA3_TIPVEI } )

oReport:Section(1):Print()

oReport:Section(2):Init()
oReport:SkipLine(3)
oReport:Section(2):PrintLine()
oReport:Section(2):Finish()

Return