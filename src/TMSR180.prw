/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR180.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR180  ³ Autor ³ Eduardo de Souza      ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Analise diaria dos fretes                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR180()

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
±±³Programa  ³ReportDef ³ Autor ³ Eduardo de Souza      ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oFilMan
Local oManifest
Local aOrdem     := {}
Local cAliasQry  := GetNextAlias()
Local cAliasQry2 := GetNextAlias()
Local aAreaSM0   := SM0->(GetArea())
Local lDTX_SERMAN := DTX->(FieldPos("DTX_SERMAN")) > 0

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
oReport:= TReport():New("TMSR180",STR0011,"TMR180", {|oReport| ReportPrint(oReport,cAliasQry,cAliasQry2)},STR0012) // "Analise Diaria dos Fretes" ### "Este programa ira emitir a analise diaria dos fretes de acordo com os parametros escolhidos pelo usuario"
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
Aadd( aOrdem, STR0013 ) // "Fil. Manif. + Manifesto"

oFilMan:= TRSection():New(oReport,STR0024,{"DTX"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) // "Filial Manifesto"
oFilMan:SetTotalInLine(.F.)
TRCell():New(oFilMan,"DTX_FILDCA","DTX",STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // 'Fil.Destino'
TRCell():New(oFilMan,"DES.FILIAL",""   ,STR0026,""        ,15         ,          , {|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DTX_FILDCA,"M0_FILIAL") }) // 'Descrição'

oManifest:= TRSection():New(oFilMan,STR0025,{"DTX"},/*Array com as Ordens do relatório*/,/*Campos do SX3*/,/*Campos do SIX*/) // "Manifesto"
oManifest:SetTotalInLine(.F.)
TRCell():New(oManifest,"DTX_MANIFE","DTX",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If lDTX_SERMAN
	TRCell():New(oManifest,"DTX_SERMAN","DTX",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf
TRCell():New(oManifest,"PESPG" ,"",STR0015,PesqPict("DT6","DT6_PESCOB"),TamSx3("DT6_PESCOB")[1]+TamSx3("DT6_PESCOB")[2],/*lPixel*/,/*{|| code-block de impressao }*/) // Peso Pago
TRCell():New(oManifest,"PESAPG","",STR0016,PesqPict("DT6","DT6_PESCOB"),TamSx3("DT6_PESCOB")[1]+TamSx3("DT6_PESCOB")[2],/*lPixel*/,/*{|| code-block de impressao }*/) // Peso Pagar
TRCell():New(oManifest,"PESTOT","",STR0017,PesqPict("DT6","DT6_PESCOB"),TamSx3("DT6_PESCOB")[1]+TamSx3("DT6_PESCOB")[2],/*lPixel*/, {|| (cAliasQry2)->PESPG + (cAliasQry2)->PESAPG }) // Peso Total
TRCell():New(oManifest,"FREPG" ,"",STR0018,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/) // Frete Pago
TRCell():New(oManifest,"IMPPG" ,"",STR0019,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/) // Imposto Pago
TRCell():New(oManifest,"TOTPG" ,"",STR0020,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/, {|| (cAliasQry2)->FREPG + (cAliasQry2)->IMPPG }) // Total Pago
TRCell():New(oManifest,"FREAPG","",STR0021,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/) // Frete Pagar
TRCell():New(oManifest,"IMPAPG","",STR0022,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/,/*{|| code-block de impressao }*/) // Imposto Pagar
TRCell():New(oManifest,"TOTAPG","",STR0023,PesqPict("DT6","DT6_VALTOT"),TamSx3("DT6_VALTOT")[1]+TamSx3("DT6_VALTOT")[2],/*lPixel*/, {|| (cAliasQry2)->FREAPG + (cAliasQry2)->IMPAPG }) // Total Pagar

TRFunction():New(oManifest:Cell("PESPG" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oManifest:Cell("PESAPG"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oManifest:Cell("PESTOT"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oManifest:Cell("FREPG" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oManifest:Cell("IMPPG" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oManifest:Cell("TOTPG" ),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oManifest:Cell("FREAPG"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oManifest:Cell("IMPAPG"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)
TRFunction():New(oManifest:Cell("TOTAPG"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/)

RestArea(aAreaSM0)

Return(oReport)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo de Souza       ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,cAliasQry,cAliasQry2)

Local lDTX_SERMAN := DTX->(FieldPos("DTX_SERMAN")) > 0

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	 

BeginSql Alias cAliasQry
	SELECT DTX_FILIAL, DTX_FILDCA
		FROM %table:DTX%
		WHERE DTX_FILIAL = %xFilial:DTX% 
  		  AND DTX_FILORI = %Exp:mv_par01%
		  AND DTX_DATMAN = %Exp:DTOS(mv_par02)%
  		  AND %NotDel%
	GROUP BY DTX_FILIAL, DTX_FILDCA
	ORDER BY DTX_FILIAL, DTX_FILDCA
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

Begin REPORT QUERY oReport:Section(1):Section(1)

	If lDTX_SERMAN
		BeginSql Alias cAliasQry2
			SELECT DTX_FILIAL, DTX_FILMAN, DTX_MANIFE, DTX_SERMAN, SUM(PESPG)  PESPG , SUM(FREPG)  FREPG , SUM(IMPPG) IMPPG ,
			       SUM(PESAPG) PESAPG, SUM(FREAPG) FREAPG, SUM(IMPAPG)IMPAPG
			  FROM (
			  SELECT DTX_FILIAL, DTX_FILMAN, DTX_MANIFE, DTX_SERMAN, 
			  	 (CASE WHEN DT6_TIPFRE = '2' THEN 0 ELSE DT6_PESCOB END) PESPG ,
			    (CASE WHEN DT6_TIPFRE = '2' THEN 0 ELSE DT6_VALFRE END) FREPG ,
			    (CASE WHEN DT6_TIPFRE = '2' THEN 0 ELSE DT6_VALIMP END) IMPPG ,
			    (CASE WHEN DT6_TIPFRE = '1' THEN 0 ELSE DT6_PESCOB END) PESAPG,
			    (CASE WHEN DT6_TIPFRE = '1' THEN 0 ELSE DT6_VALFRE END) FREAPG,
			    (CASE WHEN DT6_TIPFRE = '1' THEN 0 ELSE DT6_VALIMP END) IMPAPG
				FROM %table:DTX% DTX, %table:DUD% DUD, %table:DT6% DT6
				WHERE DTX_FILIAL = %xFilial:DTX%
					AND DTX_FILORI = %Exp:mv_par01%
					AND DTX_DATMAN = %Exp:DTOS(mv_par02)%
					AND DTX.%NotDel%
					AND DUD_FILIAL = %xFilial:DUD%
					AND DUD_VIAGEM = DTX_VIAGEM
			      	AND DUD_FILMAN = DTX_FILMAN
			     	AND DUD_MANIFE = DTX_MANIFE
			      	AND DUD_SERMAN = DTX_SERMAN
					AND DUD_FILDCA = %report_param:(cAliasQry)->DTX_FILDCA%
					AND DUD.%NotDel%
			      AND DT6_FILIAL = %xFilial:DT6%
			      AND DT6_FILDOC = DUD_FILDOC
			      AND DT6_DOC    = DUD_DOC
			      AND DT6_SERIE  = DUD_SERIE
			      AND DT6.%NotDel% ) QUERY
			GROUP BY DTX_FILIAL, DTX_FILMAN, DTX_MANIFE, DTX_SERMAN
			ORDER BY DTX_FILIAL, DTX_FILMAN, DTX_MANIFE, DTX_SERMAN
		EndSql
	Else           
		BeginSql Alias cAliasQry2                                            
			SELECT DTX_FILIAL, DTX_FILMAN, DTX_MANIFE, SUM(PESPG)  PESPG , SUM(FREPG)  FREPG , SUM(IMPPG) IMPPG ,
		       SUM(PESAPG) PESAPG, SUM(FREAPG) FREAPG, SUM(IMPAPG)IMPAPG
			  FROM (
			  SELECT DTX_FILIAL, DTX_FILMAN, DTX_MANIFE, 
			  	 (CASE WHEN DT6_TIPFRE = '2' THEN 0 ELSE DT6_PESCOB END) PESPG ,
			    (CASE WHEN DT6_TIPFRE = '2' THEN 0 ELSE DT6_VALFRE END) FREPG ,
			    (CASE WHEN DT6_TIPFRE = '2' THEN 0 ELSE DT6_VALIMP END) IMPPG ,
			    (CASE WHEN DT6_TIPFRE = '1' THEN 0 ELSE DT6_PESCOB END) PESAPG,
			    (CASE WHEN DT6_TIPFRE = '1' THEN 0 ELSE DT6_VALFRE END) FREAPG,
			    (CASE WHEN DT6_TIPFRE = '1' THEN 0 ELSE DT6_VALIMP END) IMPAPG
				FROM %table:DTX% DTX, %table:DUD% DUD, %table:DT6% DT6
				WHERE DTX_FILIAL = %xFilial:DTX%
					AND DTX_FILORI = %Exp:mv_par01%
					AND DTX_DATMAN = %Exp:DTOS(mv_par02)%
					AND DTX.%NotDel%
					AND DUD_FILIAL = %xFilial:DUD%
					AND DUD_VIAGEM = DTX_VIAGEM
			      AND DUD_FILMAN = DTX_FILMAN
			      AND DUD_MANIFE = DTX_MANIFE
					AND DUD_FILDCA = %report_param:(cAliasQry)->DTX_FILDCA%
					AND DUD.%NotDel%
			      AND DT6_FILIAL = %xFilial:DT6%
			      AND DT6_FILDOC = DUD_FILDOC
			      AND DT6_DOC    = DUD_DOC
			      AND DT6_SERIE  = DUD_SERIE
			      AND DT6.%NotDel% ) QUERY
				GROUP BY DTX_FILIAL, DTX_FILMAN, DTX_MANIFE
				ORDER BY DTX_FILIAL, DTX_FILMAN, DTX_MANIFE
		EndSql
	EndIf
 
End REPORT QUERY oReport:Section(1):Section(1)

//-- Inicio da impressao do fluxo do relatório
oReport:SetMeter(DTX->(LastRec()))

oReport:Section(1):Print()

Return