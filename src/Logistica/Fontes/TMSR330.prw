/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSR330.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR330  ³ Autor ³ Eduardo de Souza      ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Posicao de Veiculos                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR330()

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
±±³Uso       ³ TMSR330                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local aOrdem     := {}
Local cAliasQry  := GetNextAlias()

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
oReport:= TReport():New("TMSR330",STR0016,"TMR330", {|oReport| ReportPrint(oReport,cAliasQry)},STR0017) // "Relacao da Posicao de Veiculo" ### "Emite Relacao da Posicao de Veiculo conforme os parametros informados"
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
Aadd( aOrdem, STR0018 ) // "Veiculos"

oTipVei := TRSection():New(oReport,STR0019,{"DA3","DUT"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) // "Tipo de Veículos"
oTipVei:SetTotalInLine(.F.)
oTipVei:SetTotalText(STR0035) // "Total Tipo de Veículos"
TRCell():New(oTipVei,"DA3_TIPVEI","DA3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTipVei,"DUT_DESCRI","DUT",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oFroVei := TRSection():New(oTipVei,STR0020,{"DA3"},/*Array com as Ordens*/,/*Campos do SX3*/,/*Campos do SIX*/) // "Tipo de Frota"
oFroVei:SetTotalInLine(.F.)
TRCell():New(oFroVei,"DA3_FROVEI","DA3",/*cTitle*/,/*Picture*/,10,/*lPixel*/,/*{|| code-block de impressao }*/)

oVeiculo := TRSection():New(oFroVei,STR0018,{"DA3","DTQ"},/*Array com as Ordens*/,/*Campos do SX3*/,/*Campos do SIX*/) // "Veículos"
oVeiculo:SetTotalInLine(.F.)
oVeiculo:SetTotalText(STR0034) //"Total Frota"
TRCell():New(oVeiculo,"DA3_COD"   ,"DA3",STR0021,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Veiculo"   
TRCell():New(oVeiculo,"DA3_PLACA" ,"DA3",STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DA3_DESC"  ,"DA3",STR0023,/*Picture*/,25         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DA3_CAPACM","DA3",STR0024,/*Picture*/,10         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DTQ_FILORI","DTQ",STR0025,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DTQ_VIAGEM","DTQ",STR0026,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DA3_STATUS","DA3",STR0027,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DA3_FILATU","DA3",STR0028,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| TMR330Prv((cAliasQry)->DA3_FILVGA,(cAliasQry)->DA3_NUMVGA, (cAliasQry)->DA3_FILATU,(cAliasQry)->DA3_STATUS)[1] })
TRCell():New(oVeiculo,"DTQ_DATFEC","DTQ",STR0029,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DTQ_HORFEC","DTQ",STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oVeiculo,"DTW_DATPRE","DTW",STR0031,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| TMR330Prv((cAliasQry)->DA3_FILVGA,(cAliasQry)->DA3_NUMVGA, (cAliasQry)->DA3_FILATU,(cAliasQry)->DA3_STATUS)[2] })
TRCell():New(oVeiculo,"DTW_HORPRE","DTW",STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| TMR330Prv((cAliasQry)->DA3_FILVGA,(cAliasQry)->DA3_NUMVGA, (cAliasQry)->DA3_FILATU,(cAliasQry)->DA3_STATUS)[3] })
TRCell():New(oVeiculo,"DA4_NOME"  ,"DA4",STR0033,/*Picture*/,35         ,/*lPixel*/,/*{|| code-block de impressao }*/)

oTotaliz:=TRFunction():New(oVeiculo:Cell("DA3_COD"),/*cId*/,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || TMR330Sum((cAliasQry)->DA3_COD+'1') })

oTotaliz:=TRFunction():New(oVeiculo:Cell("DA3_COD"),/*cId*/,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,.F./*lEndPage*/,oTipVei)
oTotaliz:SetCondition({ || TMR330Sum((cAliasQry)->DA3_COD+'2') })

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

Local cTipVei := ''
Local cFroVei := ''
Local cCodVei := ''
Local cQuery  := ''

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	

cQuery :="%"
If mv_par03 <> 4
	cQuery += " AND DA3_FROVEI = '"  + StrZero(mv_par03,Len(DA3->DA3_FROVEI))+ "' "
EndIf
// Verifica se filtra pelo Status do Veiculo
If mv_par06 == 3
	cQuery += " AND (DA3_STATUS = '2' OR DA3_STATUS = '3') "
ElseIf  mv_par06 == 1
	cQuery += " AND DA3_STATUS = '2'  "
ElseIf  mv_par06 == 2
	cQuery += " AND DA3_STATUS = '3'  "
EndIf
cQuery +="%"

BeginSql Alias cAliasQry
	SELECT DA3_FILVGA, DA3_NUMVGA, DA3_TIPVEI, DA3_FROVEI, DA3_COD, DA3_PLACA,
	        DA3_DESC, DA3_CAPACM, DA3_STATUS, DA3_FILATU, DA4_NOME, DA3_FILIAL
		FROM %table:DA3% DA3
	   LEFT JOIN %table:DUP% DUP
	      ON DUP_FILIAL = %xFilial:DUP%
	      AND DUP_FILORI = DA3_FILVGA
	      AND DUP_VIAGEM = DA3_NUMVGA
	      AND DUP_CODVEI = DA3_COD
			AND DUP.%NotDel%	
		LEFT JOIN %table:DA4% DA4
	      ON DA4_FILIAL = %xFilial:DA4%
	      AND DA4_COD = DUP_CODMOT
			AND DA4.%NotDel%	
		WHERE DA3_FILIAL = %xFilial:DA3%
	  	  AND DA3_COD >= %Exp:mv_par01%
		  AND DA3_COD <= %Exp:mv_par02%
		  AND DA3_TIPVEI >= %Exp:mv_par04%
		  AND DA3_TIPVEI <= %Exp:mv_par05%
		  AND DA3.%NotDel%	
		  %Exp:cQuery%
		ORDER BY DA3_FILIAL, DA3_TIPVEI, DA3_FROVEI
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
oReport:SetMeter(DA3->(LastRec()))

TRPosition():New(oReport:Section(1),"DUT",1,{|| xFilial("DUT")+(cAliasQry)->DA3_TIPVEI })
TRPosition():New(oReport:Section(1):Section(1):Section(1),"DTQ",2,{|| xFilial("DTQ")+(cAliasQry)->DA3_FILVGA+(cAliasQry)->DA3_NUMVGA })

//-- Utiliza a query do Pai
oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):Section(1):SetParentQuery()

DbSelectArea(cAliasQry)
If !(cAliasQry)->(Eof())
	While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
		cTipVei := (cAliasQry)->DA3_TIPVEI
		oReport:Section(1):Init()
		oReport:Section(1):PrintLine()
		While !(cAliasQry)->(Eof()) .And. (cAliasQry)->DA3_TIPVEI == cTipVei
			cFroVei := (cAliasQry)->DA3_FROVEI
			cCodVei := ''
			oReport:Section(1):Section(1):Init()
			oReport:Section(1):Section(1):PrintLine()
			While !(cAliasQry)->(Eof()) .And. (cAliasQry)->DA3_TIPVEI == cTipVei .And. (cAliasQry)->DA3_FROVEI == cFroVei
				If cCodVei == (cAliasQry)->DA3_COD
					oReport:Section(1):Section(1):Section(1):Cell("DA3_COD"   ):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_PLACA" ):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_DESC"  ):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_CAPACM"):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DTQ_FILORI"):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DTQ_VIAGEM"):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_STATUS"):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_FILATU"):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DTQ_DATFEC"):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DTQ_HORFEC"):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DTW_DATPRE"):Hide()
					oReport:Section(1):Section(1):Section(1):Cell("DTW_HORPRE"):Hide()
				Else
					oReport:Section(1):Section(1):Section(1):Cell("DA3_COD"   ):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_PLACA" ):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_DESC"  ):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_CAPACM"):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DTQ_FILORI"):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DTQ_VIAGEM"):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_STATUS"):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DA3_FILATU"):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DTQ_DATFEC"):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DTQ_HORFEC"):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DTW_DATPRE"):Show()
					oReport:Section(1):Section(1):Section(1):Cell("DTW_HORPRE"):Show()
				EndIf
				cCodVei := (cAliasQry)->DA3_COD
				oReport:Section(1):Section(1):Section(1):Init()
				oReport:Section(1):Section(1):Section(1):PrintLine()
				dbSelectArea(cAliasQry)
				dbSkip()
			EndDo
			oReport:Section(1):Section(1):Finish()
			oReport:Section(1):Section(1):Section(1):Finish()
		EndDo
		oReport:IncMeter()
		oReport:Section(1):Finish()
	EndDo
EndIf

//-- Zera a variavel
TMR330Sum(,.T.)

oReport:Section(1):SetPageBreak(.T.) 

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMR330Vge ³ Autor ³Eduardo de Souza       ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna dados da previsao de chegada                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Filial Viagem                                        ³±±
±±³          ³ExpC2: Viagem                                               ³±±
±±³          ³ExpC3: Filial Atual Veiculo                                 ³±±
±±³          ³ExpC4: Status Veiculo                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR330                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMR330Prv(cFilOri,cViagem,cFilAtu,cStatus)

Static cVge      := ''
Static aDados    := {}
Local cAtivChg   := SuperGetMV("MV_ATIVCHG")
Local cAliasQry2 := ''

//-- Qdo mudar a viagem devera zerar as variaveis
If cVge <> cFilOri+cViagem
	cVge   := cFilOri+cViagem
	aDados := {}
EndIf

If Empty(aDados)
	If cStatus == StrZero(2,Len(DA3->DA3_STATUS))
		Aadd( aDados, cFilAtu )
		Aadd( aDados, STOD('') )
		Aadd( aDados, '' )
	ElseIf cStatus == StrZero(3,Len(DA3->DA3_STATUS))
		cAliasQry2 := GetNextAlias()
		BeginSql Alias cAliasQry2
			SELECT DTW_FILATI, DTW_STATUS, DTW_DATPRE, DTW_HORPRE, DTW_FILIAL
			  FROM %table:DTW%
			  WHERE DTW_FILIAL = %xFilial:DTW%
			    AND DTW_FILORI = %Exp:cFilOri%
			    AND DTW_VIAGEM = %Exp:cViagem%
			    AND DTW_ATIVID = %Exp:cAtivChg%
			    AND %NotDel%
			ORDER BY DTW_FILIAL, DTW_SEQUEN DESC
		EndSql
		If (cAliasQry2)->(!Eof())
			Aadd( aDados, (cAliasQry2)->DTW_FILATI )
			Aadd( aDados, STOD((cAliasQry2)->DTW_DATPRE))
			Aadd( aDados, (cAliasQry2)->DTW_HORPRE )
			(cAliasQry2)->(DbSkip())
			While (cAliasQry2)->(!Eof())
				If (cAliasQry2)->DTW_STATUS == StrZero(1,Len(DTW_STATUS)) //-- Em Aberto
					aDados[1] := (cAliasQry2)->DTW_FILATI
					aDados[2] := (cAliasQry2)->DTW_DATPRE
					aDados[3] := (cAliasQry2)->DTW_HORPRE
				EndIf
				(cAliasQry2)->(DbSkip())
			EndDo
		Else
			Aadd( aDados, '' )
			Aadd( aDados, STOD('') )
			Aadd( aDados, '' )
		EndIf
		(cAliasQry2)->(DbCloseArea())
	EndIf
EndIf

Return aDados

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMR330Sum ³ Autor ³Eduardo de Souza       ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se devera ser somado a linha em questao            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Cod. Veiculo                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TMSR330                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMR330Sum(cCodVei,lZeraVar)
Static aCodVei := {}

Local lRet := .F.
Default lZeraVar := .F.

If lZeraVar
	aCodVei := {}
ElseIf Ascan( aCodVei, { |x| x == cCodVei } ) == 0
	Aadd( aCodVei, cCodVei )
	lRet := .T.
Endif

Return lRet