/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR270.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR270  ³ Autor ³ Eduardo de Souza      ³ Data ³ 26/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relacao de motoristas (telerisco).				     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR270()

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
±±³Uso       ³ TMSR270                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local cAliasQry := GetNextAlias()
Local aOrdem    := {}
Local aAreaSM0  := SM0->(GetArea())
Local lDTX_SERMAN := DTX->(FieldPos("DTX_SERMAN")) > 0
Local lTercRbq    := DTR->(ColumnPos("DTR_CODRB3")) > 0

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
oReport:= TReport():New("TMSR270",STR0012,"TMR270", {|oReport| ReportPrint(oReport,cAliasQry)},STR0013) // STR0012 "Relacao Contabil de CTRCs nao Entregues" ### "Este programa ira emitir a relacao de CTRCs nao entregues de acordo com os parametros escolhidos pelo usuario"
oReport:SetLandscape()
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
Aadd( aOrdem, STR0014 ) // "Fil.Origem + Fil.Docto + Documento + Serie"

oFilDoc:= TRSection():New(oReport,STR0015,{"DT6"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oFilDoc:SetTotalInLine(.F.)
oFilDoc:SetTotalText(STR0026) //-- "Total Origem"
TRCell():New(oFilDoc,"DT6_FILDOC","DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFilDoc,"DES.FILIAL",""   ,STR0016   ,/*Picture*/,15/*Tamanho*/,/*lPixel*/, {|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DT6_FILDOC,"M0_FILIAL") } )

oDocto:= TRSection():New(oFilDoc,STR0017,{"DT6","DTW","DUD","DTY","DTR","SA1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oDocto:SetTotalInLine(.F.)
TRCell():New(oDocto,"DT6_DOC"   ,"DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_FILDES","DT6",STR0023   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_DATEMI","DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_PRZENT","DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DTW_DATREA","DTW",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DUD_FILMAN","DUD",STR0021   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DUD_MANIFE","DUD",STR0022   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If lDTX_SERMAN
	TRCell():New(oDocto,"DUD_SERMAN","DUD",/*cTitle*/ ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf
TRCell():New(oDocto,"DT6_VALTOT","DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DTY_NUMCTC","DTY",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DTR_CODVEI","DTR",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"PLACAVEI"  ,""   ,STR0018   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DTR_CODRB1","DTR",STR0024   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"PLACARB1"  ,""   ,STR0018   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DTR_CODRB2","DTR",STR0025   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"PLACARB2"  ,""   ,STR0018   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
If lTercRbq
	TRCell():New(oDocto,"DTR_CODRB3","DTR",STR0027   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
	TRCell():New(oDocto,"PLACARB3"  ,""   ,STR0018   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf
TRCell():New(oDocto,"DT6_PESO"  ,"DT6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocto,"DT6_VALFRE","DT6",STR0019   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/, {|| (cAliasQry)->DTY_VALFRE*((cAliasQry)->DT6_PESO/(cAliasQry)->DTY_PESO) })
TRCell():New(oDocto,"A1_NREDUZ" ,"SA1",STR0020   ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRFunction():New(oDocto:Cell("DT6_VALTOT"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFilDoc)
TRFunction():New(oDocto:Cell("DT6_PESO"  ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFilDoc)
TRFunction():New(oDocto:Cell("DT6_VALFRE"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oFilDoc)

RestArea( aAreaSM0 )

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

Local cAtivChg  := PadR(GetMv('MV_ATIVCHG'),Len(DTW->DTW_ATIVID))
Local cStat5    := StrZero(5,Len(DT6->DT6_STATUS))//Chega Final
Local cStat6    := StrZero(6,Len(DT6->DT6_STATUS))//Indicado para coleta
Local lDTX_SERMAN := DTX->(FieldPos("DTX_SERMAN")) > 0
Local lTercRbq    := DTR->(ColumnPos("DTR_CODRB3")) > 0

Local cCodRb3 := ''
Local cPlacaRb3 := ''

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

If lTercRbq
	cCodRb3 := "%DTR_CODRB3%"
	cPlacaRb3 := "%DA3D.DA3_PLACA PLACARB3%"
EndIf
//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	
If lDTX_SERMAN
	BeginSql Alias cAliasQry
	SELECT DT6_FILDOC,DT6_DOC,DT6_SERIE,DT6_FILDES,DT6_DATEMI,DT6_PRZENT,DUD_FILMAN,DUD_MANIFE,
	       A1_NREDUZ,DT6_VALTOT,DTY_NUMCTC,DTY_VALFRE,DTY_PESO,DTR_CODVEI,DTR_CODRB1,DTR_CODRB2,
	       DT6_PESO,DTW_DATREA, DT6_FILIAL, DA3A.DA3_PLACA PLACAVEI, DA3B.DA3_PLACA PLACARB1,
			 DA3C.DA3_PLACA PLACARB2	,DUD_SERMAN, %Exp:cCodRb3%, %Exp:cPlacaRb3% 
			
	   FROM %table:DT6% DT6 
	   JOIN %table:DUD% DUD 
	      ON DUD_FILIAL = %xFilial:DUD%
	      AND DUD_FILDOC = DT6_FILDOC 
	      AND DUD_DOC = DT6_DOC 
	      AND DUD_SERIE = DT6_SERIE 
	      AND DUD_FILORI = DT6_FILVGA 
	      AND DUD_VIAGEM = DT6_NUMVGA 
	      AND DUD.%NotDel%
	   LEFT JOIN %table:DTY% DTY 
	      ON DTY_FILIAL = %xFilial:DTY%
	      AND DTY_FILORI = DT6_FILVGA 
	      AND DTY_VIAGEM = DT6_NUMVGA 
	      AND DTY.%NotDel%
	   JOIN %table:DTR% DTR 
	      ON DTR_FILIAL = %xFilial:DTR%
	      AND DTR_FILORI = DT6_FILVGA 
	      AND DTR_VIAGEM = DT6_NUMVGA 
	      AND DTR.%NotDel%
	   LEFT JOIN %table:DA3% DA3A 
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
			ON DA3D.DA3_FILIAL = %xFilial:DA3%
			AND DA3D.DA3_COD = %Exp:cCodRb3%
		    AND DA3D.%NotDel%       
	   JOIN %table:SA1% SA1 
	      ON A1_FILIAL = %xFilial:SA1%
	      AND A1_COD = DT6_CLIDES 
	      AND A1_LOJA = DT6_LOJDES 
	      AND SA1.%NotDel%
	   LEFT JOIN %table:DTW% DTW 
	      ON DTW_FILIAL = %xFilial:DTW%
	      AND DTW_FILORI = DT6_FILVGA 
	      AND DTW_VIAGEM = DT6_NUMVGA 
			AND DTW_ATIVID = %Exp:cAtivChg%
			AND DTW_FILATI = %Exp:cFilAnt%
	      AND DTW.%NotDel%
	   WHERE DT6_FILIAL = %xFilial:DT6%
	      AND DT6_FILDOC BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
	      AND DT6_FILDES BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
	      AND DT6_DATEMI BETWEEN %Exp:Dtos(mv_par05)% AND %Exp:Dtos(mv_par06)%
	      AND DT6_ULTEMB <= %Exp:Dtos(mv_par07)%
	      AND DT6_DOCTMS = %Exp:StrZero(2,Len(DT6->DT6_SERTMS))%
	      AND (DT6_STATUS = %Exp:cStat5% OR DT6_STATUS = %Exp:cStat6% )
	      AND (DT6_DATENT = %Exp:Space(Len(Dtos(DT6->DT6_DATENT)))% OR DT6_DATENT > %Exp:Dtos(mv_par08)% ) 
	      AND DT6.%NotDel%
	ORDER BY DT6_FILIAL, DT6_FILDOC,DT6_DOC,DT6_SERIE
EndSql
Else
	BeginSql Alias cAliasQry
	 SELECT DT6_FILDOC,DT6_DOC,DT6_SERIE,DT6_FILDES,DT6_DATEMI,DT6_PRZENT,DUD_FILMAN,DUD_MANIFE,
		       A1_NREDUZ,DT6_VALTOT,DTY_NUMCTC,DTY_VALFRE,DTY_PESO,DTR_CODVEI,DTR_CODRB1,DTR_CODRB2,
		       DT6_PESO,DTW_DATREA, DT6_FILIAL, DA3A.DA3_PLACA PLACAVEI, DA3B.DA3_PLACA PLACARB1,
				 DA3C.DA3_PLACA PLACARB2	
				
		   FROM %table:DT6% DT6 
		   JOIN %table:DUD% DUD 
		      ON DUD_FILIAL = %xFilial:DUD%
		      AND DUD_FILDOC = DT6_FILDOC 
		      AND DUD_DOC = DT6_DOC 
		      AND DUD_SERIE = DT6_SERIE 
		      AND DUD_FILORI = DT6_FILVGA 
		      AND DUD_VIAGEM = DT6_NUMVGA 
		      AND DUD.%NotDel%
		   LEFT JOIN %table:DTY% DTY 
		      ON DTY_FILIAL = %xFilial:DTY%
		      AND DTY_FILORI = DT6_FILVGA 
		      AND DTY_VIAGEM = DT6_NUMVGA 
		      AND DTY.%NotDel%
		   JOIN %table:DTR% DTR 
		      ON DTR_FILIAL = %xFilial:DTR%
		      AND DTR_FILORI = DT6_FILVGA 
		      AND DTR_VIAGEM = DT6_NUMVGA 
		      AND DTR.%NotDel%
		   LEFT JOIN %table:DA3% DA3A 
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
		   JOIN %table:SA1% SA1 
		      ON A1_FILIAL = %xFilial:SA1%
		      AND A1_COD = DT6_CLIDES 
		      AND A1_LOJA = DT6_LOJDES 
		      AND SA1.%NotDel%
		   LEFT JOIN %table:DTW% DTW 
		      ON DTW_FILIAL = %xFilial:DTW%
		      AND DTW_FILORI = DT6_FILVGA 
		      AND DTW_VIAGEM = DT6_NUMVGA 
				AND DTW_ATIVID = %Exp:cAtivChg%
				AND DTW_FILATI = %Exp:cFilAnt%
		      AND DTW.%NotDel%
		   WHERE DT6_FILIAL = %xFilial:DT6%
		      AND DT6_FILDOC BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
		      AND DT6_FILDES BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
		      AND DT6_DATEMI BETWEEN %Exp:Dtos(mv_par05)% AND %Exp:Dtos(mv_par06)%
		      AND DT6_ULTEMB <= %Exp:Dtos(mv_par07)%
		      AND DT6_DOCTMS = %Exp:StrZero(2,Len(DT6->DT6_SERTMS))%
		      AND (DT6_STATUS = %Exp:cStat5% OR DT6_STATUS = %Exp:cStat6% )
		      AND (DT6_DATENT = %Exp:Space(Len(Dtos(DT6->DT6_DATENT)))% OR DT6_DATENT > %Exp:Dtos(mv_par08)% ) 
		      AND DT6.%NotDel%
		ORDER BY DT6_FILIAL, DT6_FILDOC,DT6_DOC,DT6_SERIE
	EndSql
EndIf
 

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
oReport:SetMeter(DT6->(LastRec()))

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter( {|cParam| (cAliasQry)->DT6_FILDOC == cParam  }, {|| (cAliasQry)->DT6_FILDOC } )

oReport:Section(1):Print()

Return