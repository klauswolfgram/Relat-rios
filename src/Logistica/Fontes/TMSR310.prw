/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR310.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR310  ³ Autor ³ Eduardo de Souza      ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relacao de veiculos a receber por filial.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR310()

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
±±³Uso       ³ TMSR310                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local aOrdem     := {}
Local cAliasQry  := GetNextAlias()
Local aAreaSM0   := SM0->(GetArea())
Local lTercRbq   := DTR->(ColumnPos("DTR_CODRB3")) > 0

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
oReport:= TReport():New("TMSR310",STR0012,"TMR310", {|oReport| ReportPrint(oReport,cAliasQry)},STR0013) // "Relação de veículos a receber por filial" ### "Emite relacao de veiculos a receber por filial, conforme os parametros informados"
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01	 // Filial Escala De	                             ³
//³ mv_par02	 // Filial Escala Ate                             ³
//³ mv_par03	 // Prev. Chegada De                              ³
//³ mv_par04	 // Prev. Chegada Ate                             ³
//³ mv_par05	 // Tipo Transporte De                            ³
//³ mv_par06	 // Tipo Transporte Ate                           ³
//³ mv_par07	 // Servico de Transp. ?                          ³
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
Aadd( aOrdem, STR0014 ) // "Fil. Atividade + Fil. Origem + Viagem"

oFilAti := TRSection():New(oReport,STR0015,{"DTW"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) // "Fil. Atividade"
oFilAti:SetPageBreak(.T.)
oFilAti:SetTotalInLine(.F.)
TRCell():New(oFilAti,"DTW_FILATI","DTW",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFilAti,"M0_FILIAL" ,"SM0",STR0016   ,/*Picture*/,15         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFilAti,"M0_ESTENT" ,"SM0",STR0017   ,/*Picture*/,2          ,/*lPixel*/,/*{|| code-block de impressao }*/)

oViagem := TRSection():New(oFilAti,STR0018,{"DTW","DTQ","DA8","DTR","DA3","DUP","DA4"},/*Array com as Ordens*/,/*Campos do SX3*/,/*Campos do SIX*/) // "Viagem"
oViagem:SetTotalInLine(.F.)
TRCell():New(oViagem,"DTW_FILORI","DTW",/*cTitle*/,/*Picture*/,8,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTW_VIAGEM","DTW",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DA8_DESROT","DA8",STR0025   ,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| Tabela("M3",(cAliasQry)->DA8_TIPROT,.F.) } ) // "Tipo Rota"
TRCell():New(oViagem,"DTQ_FILDES","DTQ",/*cTitle*/,/*Picture*/,8,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTW_DATPRE","DTW",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"DTW_HORPRE","DTW",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oViagem,"OCUPACAO"  ,""   ,STR0019   ,"@E 999.99",6          ,/*lPixel*/, {|| (100 * ((cAliasQry)->DT6_PESO / TmsTotVge((cAliasQry)->DTW_FILORI,(cAliasQry)->DTW_VIAGEM,,.T.)[11])) } ) // "Perc.Ocup."
TRCell():New(oViagem,"DTR_CODVEI","DTR",STR0020   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Veículo"
TRCell():New(oViagem,"PLACAVEI"  ,"DA3",STR0021   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/) // "Placa"
TRCell():New(oViagem,"DTR_CODRB1","DTR",STR0022   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "1o Reboque"
TRCell():New(oViagem,"PLACARB1"  ,"DA3",STR0021   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/) // "Placa"
TRCell():New(oViagem,"DTR_CODRB2","DTR",STR0023   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "2o Reboque"
TRCell():New(oViagem,"PLACARB2"  ,"DA3",STR0021   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/) // "Placa"
If lTercRbq
	TRCell():New(oViagem,"DTR_CODRB3","DTR",STR0026   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "3o Reboque"
	TRCell():New(oViagem,"PLACARB3"  ,"DA3",STR0021   ,/*Picture*/,TamSx3("DA3_PLACA")[1],/*lPixel*/,/*{|| code-block de impressao }*/) // "Placa"
EndIf
TRCell():New(oViagem,"DA4_NREDUZ","DA4",STR0024   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Motorista"

RestArea( aAreaSM0 )

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
±±³Uso       ³ TMSR330                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,cAliasQry,cAliasQry2)

Local cAtivCHG := GetMV('MV_ATIVCHG',,'')
Local cStatus  := StrZero(1,Len(DTW->DTW_STATUS))
Local cFilAtu  := ''
Local cViagem  := ''
Local cCodVei  := ''
Local cCodMot  := ''
Local cWhere   := ''
Local cSerTms  := Alltrim(Str(mv_par07))
Local cCodRb3  := ''
Local cPlacaRb3		:= ''
Local cColNamRb3 	:= ''
Local lTercRbq   	:= DTR->(ColumnPos("DTR_CODRB3")) > 0

If lTercRbq
	cCodRb3   := "%DTR_CODRB3%"
	cPlacaRb3 := "%DA3D.DA3_PLACA%"
	cColNamRb3:= "%PLACARB3%"
EndIf 
                        
cWhere := "%"
If cSerTms <> '4' 
	cWhere += " AND DTQ.DTQ_SERTMS = '"+cSerTms+"' "
EndIf	
cWhere += "%"

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	

BeginSql Alias cAliasQry
	SELECT DTW_FILIAL, DTW_FILORI, DTW_VIAGEM, DTW_FILATI, DTR_CODVEI, DUP_CODMOT, MIN(DTW_DATPRE) DTW_DATPRE, 
	       MIN(DTW_HORPRE) DTW_HORPRE, SUM(DT6_PESO) DT6_PESO, MIN(DTQ_FILDES) DTQ_FILDES, 
	       MIN(DA8_TIPROT) DA8_TIPROT, MIN(DA3A.DA3_PLACA) PLACAVEI, MIN(DTR_CODRB1) DTR_CODRB1, 
	       MIN(DA3B.DA3_PLACA) PLACARB1, MIN(DTR_CODRB2) DTR_CODRB2, MIN(DA3C.DA3_PLACA) PLACARB2,
	       MIN(%Exp:cCodRb3%) %Exp:cCodRb3%, MIN(%Exp:cPlacaRb3%)%Exp:cColNamRb3%,
	       MIN(DA4_NREDUZ) DA4_NREDUZ
		FROM %table:DTW% DTW
		LEFT JOIN %table:DTQ% DTQ
			ON DTQ_FILIAL = %xFilial:DTQ%
			AND DTQ_FILORI = DTW_FILORI
			AND DTQ_VIAGEM = DTW_VIAGEM
			AND DTQ.%NotDel%
		LEFT JOIN %table:DA8% DA8
			ON DA8_FILIAL = %xFilial:DA8%
			AND DA8_COD   = DTQ_ROTA
			AND DA8.%NotDel%
		LEFT JOIN %table:DUD% DUD
			ON DUD_FILIAL = %xFilial:DUD%
			AND DUD_FILORI = DTW_FILORI
			AND DUD_VIAGEM = DTW_VIAGEM
			AND DUD_FILDCA = DTW_FILATI
			AND DUD.%NotDel%
		LEFT JOIN %table:DT6% DT6
			ON DT6_FILIAL = %xFilial:DT6%
			AND DT6_FILDOC = DUD_FILDOC
			AND DT6_DOC    = DUD_DOC
			AND DT6_SERIE  = DUD_SERIE
			AND DT6.%NotDel%
		LEFT JOIN %table:DTR% DTR
			ON DTR_FILIAL = %xFilial:DTR%
			AND DTR_FILORI = DTW_FILORI
			AND DTR_VIAGEM = DTW_VIAGEM
			AND DTR.%NotDel%
		LEFT JOIN %table:DA3% DA3A
			ON DA3A.DA3_FILIAL = %xFilial:DA3%
			AND DA3A.DA3_COD = DTR_CODVEI
			AND DA3A.%NotDel%
		LEFT JOIN %table:DA3% DA3B
			ON DA3B.DA3_FILIAL = %xFilial:DA3%
			AND DA3B.DA3_COD = DTR_CODRB1
			AND DA3B.%NotDel%
		LEFT JOIN %table:DA3% DA3C
			ON DA3C.DA3_FILIAL = %xFilial:DA3%
			AND DA3C.DA3_COD = DTR_CODRB2
			AND DA3C.%NotDel%
		LEFT JOIN %table:DA3% DA3D
			ON DA3D.DA3_FILIAL = %xFilial:DA3%
			AND DA3D.DA3_COD = %Exp:cCodRb3%
			AND DA3D.%NotDel%
		LEFT JOIN %table:DUP% DUP
			ON DUP_FILIAL = %xFilial:DUP%
			AND DUP_FILORI = DTW_FILORI
			AND DUP_VIAGEM = DTW_VIAGEM
			AND DUP_CODVEI = DTR_CODVEI
			AND DUP.%NotDel%
		LEFT JOIN %table:DA4% DA4
			ON DA4_FILIAL = %xFilial:DA4%
			AND DA4_COD = DUP_CODMOT
			AND DA4.%NotDel%
		WHERE DTW_FILIAL  = %xFilial:DTW%
			AND DTW_FILATI BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
			AND DTW_DATPRE BETWEEN %Exp:DTOS(mv_par03)% AND %Exp:DTOS(mv_par04)%
			AND DTQ_TIPTRA BETWEEN %Exp:mv_par05% AND %Exp:mv_par06%
			AND DTW_ATIVID = %Exp:cATIVCHG%
			AND DTW_STATUS = %Exp:cStatus%
			AND DTW.%NotDel%
			%Exp:cWhere%
	GROUP BY DTW_FILIAL, DTW_FILATI, DTW_FILORI, DTW_VIAGEM, DTR_CODVEI, DUP_CODMOT
	ORDER BY DTW_FILIAL, DTW_FILATI, DTW_FILORI, DTW_VIAGEM, DTR_CODVEI, DUP_CODMOT
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
oReport:SetMeter(DTW->(LastRec()))

//-- Utiliza a query do Pai
oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter( { |cParam| (cAliasQry)->DTW_FILATI == cParam },{ || (cAliasQry)->DTW_FILATI })

TRPosition():New(oReport:Section(1),"SM0",1,{|| cEmpAnt+(cAliasQry)->DTW_FILATI })

DbSelectArea(cAliasQry)
If !(cAliasQry)->(Eof())
	While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
		cFilAti := (cAliasQry)->DTW_FILATI
		oReport:Section(1):Init()
		oReport:Section(1):PrintLine()
		//-- Viagem
		While !(cAliasQry)->(Eof()) .And. (cAliasQry)->DTW_FILATI == cFilAti
			cViagem := (cAliasQry)->DTW_VIAGEM
			cCodVei := (cAliasQry)->DTR_CODVEI
			cCodMot := (cAliasQry)->DUP_CODMOT
			oReport:Section(1):Section(1):Init()
			oReport:Section(1):Section(1):PrintLine()
			(cAliasQry)->(DbSkip())
			//-- Veiculos da Viagem
			While !(cAliasQry)->(Eof()) .And.	(cAliasQry)->DTW_FILATI == cFilAti .And. ;
											   			(cAliasQry)->DTW_VIAGEM == cViagem
				oReport:Section(1):Section(1):Cell("DTW_FILORI"):Hide()
				oReport:Section(1):Section(1):Cell("DTW_VIAGEM"):Hide()
				oReport:Section(1):Section(1):Cell("DA8_DESROT"):Hide()
				oReport:Section(1):Section(1):Cell("DTQ_FILDES"):Hide()
				oReport:Section(1):Section(1):Cell("DTW_DATPRE"):Hide()
				oReport:Section(1):Section(1):Cell("DTW_HORPRE"):Hide()
				oReport:Section(1):Section(1):Cell("OCUPACAO"  ):Hide()
				If (cAliasQry)->DTR_CODVEI == cCodVei
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
				oReport:Section(1):Section(1):PrintLine()
				cCodVei := (cAliasQry)->DTR_CODVEI
				cCodMot := (cAliasQry)->DUP_CODMOT
				(cAliasQry)->(DbSkip())
			EndDo
			oReport:Section(1):Section(1):Cell("DTW_FILORI"):Show()
			oReport:Section(1):Section(1):Cell("DTW_VIAGEM"):Show()
			oReport:Section(1):Section(1):Cell("DA8_DESROT"):Show()
			oReport:Section(1):Section(1):Cell("DTQ_FILDES"):Show()
			oReport:Section(1):Section(1):Cell("DTW_DATPRE"):Show()
			oReport:Section(1):Section(1):Cell("DTW_HORPRE"):Show()
			oReport:Section(1):Section(1):Cell("OCUPACAO"  ):Show()
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
EndIf

Return