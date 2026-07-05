/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE  'TMSR480.CH'

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TMSR480  ³ Autor ³ Eduardo de Souza      ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de clientes com ajustes                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR480()

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
±±³Uso       ³ TMSR480                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oFilNeg
Local oTabFre
Local oCliente
Local oTotaliz
Local oComp
Local aOrdem     := {}
Local cAliasQry  := GetNextAlias()
Local cAliasQry2 := GetNextAlias()

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
oReport:= TReport():New("TMSR480",STR0021,"TMR480A", {|oReport| ReportPrint(oReport,cAliasQry,cAliasQry2)},STR0020) // "Clientes com ajuste" ### "Este programa tem o objetivo de imprimir os clientes com ajuste"
oReport:SetLandscape()
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
Aadd( aOrdem, "Filial Negociação + Tabela Frete + Tipo Tabela" )

oFilNeg := TRSection():New(oReport,"Filial Negociação",{"AAM","DDA","DUY","SA1","SA3"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)

oFilNeg:SetPageBreak(.T.)
TRCell():New(oFilNeg,"DUY_FILDES","DUH","Filial Negociação",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oFilNeg,"DES.FILIAL",""   ,"Descrição"        ,""        ,15         ,          , {|| Posicione("SM0",1,cEmpAnt+(cAliasQry)->DUY_FILDES,"M0_FILIAL") }) // 'Descrição''

oTabFre := TRSection():New(oFilNeg,"Tabela de Frete",{"AAM","DDA","DUY","SA1","SA3"},/*Ordem do relatório*/,/*Campos do SX3*/,/*Campos do SIX*/)

TRCell():New(oTabFre,"CODTABFRE","DDA",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTabFre,"CODTIPTAB","DDA",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTabFre,"DT0_DESTIP","DT0",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| Tabela("M5",(cAliasQry)->CODTIPTAB,.F.) } )

oCliente := TRSection():New(oTabFre,"Cliente",{"AAM","DDA","DUY","SA1","SA3"},/*Ordem do relatório*/,/*Campos do SX3*/,/*Campos do SIX*/)

oCliente:SetTotalInLine(.F.)
TRCell():New(oCliente,"A1_NREDUZ" ,"SA1",STR0022   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A1_CGC"    ,"SA1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"AAM_TIPFRE","AAM",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"DUY_DESCRI","DUY",STR0023   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"DUY_EST"   ,"DUY",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"A3_NREDUZ" ,"SA3",STR0024   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"AAM_CONTRT","AAM",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"AAM_INIVIG","AAM",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"CODSERVIC","DDA",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"CODNEG","DDA",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"AAM_REAAUT","AAM",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCliente,"DDA_FATCUB","DDA",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oTotaliz := TRFunction():New(oCliente:Cell("AAM_CONTRT" ),/*cId*/,"COUNT",/*oBreak*/,STR0025,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilNeg)
oTotaliz:SetCondition({ || (cAliasQry)->AAM_TIPFRE <> StrZero(2,Len(AAM->AAM_TIPFRE)) })

oTotaliz := TRFunction():New(oCliente:Cell("AAM_CONTRT" ),/*cId*/,"COUNT",/*oBreak*/,STR0026,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,oFilNeg)
oTotaliz:SetCondition({ || (cAliasQry)->AAM_TIPFRE <> StrZero(1,Len(AAM->AAM_TIPFRE)) })

oTotaliz := TRFunction():New(oCliente:Cell("AAM_CONTRT" ),/*cId*/,"COUNT",/*oBreak*/,STR0025,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oTabFre)
oTotaliz:SetCondition({ || (cAliasQry)->AAM_TIPFRE <> StrZero(2,Len(AAM->AAM_TIPFRE)) })

oTotaliz := TRFunction():New(oCliente:Cell("AAM_CONTRT" ),/*cId*/,"COUNT",/*oBreak*/,STR0026,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,oTabFre)
oTotaliz:SetCondition({ || (cAliasQry)->AAM_TIPFRE <> StrZero(1,Len(AAM->AAM_TIPFRE)) })

oComp := TRSection():New(oCliente,"Componentes",{"DVE","DT3"},/*Ordem do relatório*/,/*Campos do SX3*/,/*Campos do SIX*/)
oComp:SetTotalInLine(.F.)
TRCell():New(oComp,"DVE_CODPAS","DVE",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oComp,"DT3_DESCRI","DT3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oComp,"COBRADO"   ,""   ,STR0027   ,/*Picture*/ ,1          ,/*lPixel*/, {|| If((cAliasQry2)->COBRADO == "1",STR0028,STR0029) })
TRCell():New(oComp,"DT3_CALPES","DT3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

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

Local cWhere  := ''
Local cQuery1 := ''
Local cQuery2 := ''
Local cComp   := ''

Local cJoinSel := ""
Local cJoinCrt := ""
Local cJoinSrv := ""
Local cJoinSub := ""
Local cJoinOrd := ""

//-- Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//-- Filtragem do relatório
//-- Query do relatório da secao 1
oReport:Section(1):BeginQuery()	

cWhere := '%'
If MV_PAR03 <> 3
	cWhere += " AND AAM_REAAUT ='" + AllTrim( Str(MV_PAR03) )+ "' "
EndIf
If MV_PAR04 <> 3
	cWhere += " AND AAM_TIPFRE ='" + AllTrim( Str(MV_PAR04) )+ "' "
EndIf
If MV_PAR05 == MV_PAR06
	cWhere += " AND DC5_TIPTRA = '" + MV_PAR05 + "' "
Else
	cWhere += " AND DC5_TIPTRA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
EndIf
If MV_PAR07 == MV_PAR08
	cWhere += " AND DDA_SERVIC = '" + MV_PAR07 + "' "	
	cWhere += " AND DC5_SERVIC = '" + MV_PAR07 + "' "
Else
	cWhere += " AND DDA_SERVIC BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "
	cWhere += " AND DC5_SERVIC BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "
EndIf
If MV_PAR09 == MV_PAR11
	cWhere += " AND AAM_CODCLI ='" + MV_PAR09 + "' "
Else
	cWhere += " AND AAM_CODCLI BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR11 + "' "
EndIf
If MV_PAR10 == MV_PAR12
	cWhere += " AND AAM_LOJA ='" + MV_PAR10 + "' "
Else
	cWhere += " AND AAM_LOJA BETWEEN '" + MV_PAR10 + "' AND '" + MV_PAR12 + "' "
EndIf
If MV_PAR13 == MV_PAR15
	cWhere += " AND DDA_TABFRE = '" + MV_PAR13 + "' "	
Else
	cWhere += " AND DDA_TABFRE BETWEEN '" + MV_PAR13 + "' AND '" + MV_PAR15 + "' "	
EndIf
If MV_PAR14 == MV_PAR16
	cWhere += " AND DDA_TIPTAB ='" + MV_PAR14 + "' "	
Else
	cWhere += " AND DDA_TIPTAB BETWEEN '" + MV_PAR14 + "' AND '" + MV_PAR16 + "' "	
EndIf
cWhere += '%'

cQuery1 := '%'
If MV_PAR01 == MV_PAR02
	cQuery1 += " AND DUY_FILDES = '" + MV_PAR01 + "' "
Else
	cQuery1 += " AND DUY_FILDES BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
EndIf
cQuery1 += '%'

cQuery2 := '%'
If MV_PAR01 == MV_PAR02
	cQuery2 += " AND DW3_FILNEG = '" + MV_PAR01 + "' "
Else
	cQuery2 += " AND DW3_FILNEG BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
EndIf
cQuery2 += '%'

cJoinSel := "%DDA_TABFRE CODTABFRE,DDA_TIPTAB CODTIPTAB,DDA_SERVIC CODSERVIC,DDA_CODNEG CODNEG,DDA_FATCUB%"
cJoinCrt := "% INNER JOIN " + RetSqlName("DDC") + " DDC " + ;
			"    ON DDC_FILIAL = '" + xFilial("DDC") + "' " + ;
			"   AND DDC_NCONTR = AAM_CONTRT " + ;
			"   AND DDC.D_E_L_E_T_ = ' ' " + ;
			"  INNER JOIN " + RetSqlName("DDA") + " DDA " + ;
			"    ON DDA_FILIAL = '" + xFilial("DDA") + "' " +;
			"   AND DDA_NCONTR = DDC_NCONTR " + ;
			"   AND DDA_CODNEG = DDC_CODNEG " + ;
			"   AND DDA.D_E_L_E_T_ = ' ' %"
cJoinSrv := "%  AND DC5_SERVIC = DDA_SERVIC %"
cJoinSub := "%  AND DVC_TABFRE = DDA_TABFRE " + ;
			"   AND DVC_TIPTAB = DDA.DDA_TIPTAB " + ;
			"   AND ( DVC_SERVIC = DDA_SERVIC OR DVC_SERVIC = ' ' ) %"
cJoinOrd := "%DDA_TABFRE,DDA_TIPTAB%"
	
BeginSql Alias cAliasQry

	SELECT * FROM (
	SELECT DISTINCT 
	    AAM_CODCLI,AAM_LOJA,AAM_CONTRT,AAM_INIVIG,AAM_TIPFRE,AAM_REAAUT,A1_CGC,A1_NREDUZ,A1_COND,DUY_FILIAL,
	    A1_VEND,%Exp:cJoinSel%,DUY_DESCRI,DUY_EST,A3_NREDUZ, DUY_FILDES
	  FROM %Table:AAM% AAM
	  %Exp:cJoinCrt%
	 INNER JOIN %Table:SA1% SA1
	    ON  A1_FILIAL = %xFilial:SA1%
	    AND A1_COD    = AAM_CODCLI
	    AND A1_LOJA   = AAM_LOJA
	    AND SA1.D_E_L_E_T_ = ' ' 
	  LEFT JOIN %Table:SA3% SA3
	    ON A3_FILIAL  = %xFilial:SA3%
	    AND A3_COD    = A1_VEND
	    AND SA3.D_E_L_E_T_ = ' ' 
	  INNER JOIN %Table:DC5% DC5
	    ON  DC5_FILIAL = %xFilial:DC5%
	    %Exp:cJoinSrv%
	    AND DC5.D_E_L_E_T_ = ' ' 
	  INNER JOIN %Table:DUY% DUY
	    ON DUY_FILIAL = %xFilial:DUY%
	    AND DUY_GRPVEN = A1_CDRDES 
	    AND DUY.D_E_L_E_T_ = ' ' 
		%Exp:cQuery1%
	  WHERE AAM_FILIAL = %xFilial:AAM%
	    AND AAM_FIMVIG = ' ' 
	    AND EXISTS(
	            SELECT 'X' 
	               FROM %Table:DVC% DVC 
	               WHERE DVC_FILIAL = %xFilial:DVC%
	                 AND DVC_CODCLI = AAM_CODCLI 
	                 AND DVC_LOJCLI = AAM_LOJA 
	                 %Exp:cJoinSub%
	                 AND DVC.D_E_L_E_T_ = ' ')
	    AND AAM.D_E_L_E_T_ = ' ' 
	    AND NOT EXISTS ( 
	            SELECT '1' 
	                FROM %Table:DW3% DW3
	                WHERE DW3_FILIAL = %xFilial:DW3%
	                  AND DW3_CODCLI = A1_COD
	                  AND DW3_LOJCLI = A1_LOJA
	                  AND ( DW3_TIPTRA = DC5_TIPTRA
	                     OR DW3_TIPTRA = '4' )
	                  AND D_E_L_E_T_ = ' ' )
		%Exp:cWhere%
	UNION ALL
	SELECT DISTINCT 
	    AAM_CODCLI,AAM_LOJA,AAM_CONTRT,AAM_INIVIG,AAM_TIPFRE,AAM_REAAUT,A1_CGC,A1_NREDUZ,A1_COND,DUY_FILIAL,
	    A1_VEND,%Exp:cJoinSel%,DUY_DESCRI,DUY_EST,A3_NREDUZ, DW3_FILNEG DUY_FILDES
	  FROM %Table:AAM% AAM
	  %Exp:cJoinCrt%
	  INNER JOIN %Table:SA1% SA1
	    ON  A1_FILIAL = %xFilial:SA1%
	    AND A1_COD    = AAM_CODCLI
	    AND A1_LOJA   = AAM_LOJA
	    AND SA1.D_E_L_E_T_ = ' ' 
	  LEFT JOIN %Table:SA3% SA3
	    ON A3_FILIAL  = %xFilial:SA3%
	    AND A3_COD    = A1_VEND
	    AND SA3.D_E_L_E_T_ = ' ' 
	  INNER JOIN %Table:DC5% DC5
	    ON  DC5_FILIAL = %xFilial:DC5%
	    %Exp:cJoinSrv%
	    AND DC5.D_E_L_E_T_ = ' ' 
	  INNER JOIN %Table:DUY% DUY
	    ON DUY_FILIAL = %xFilial:DUY%
	    AND DUY_GRPVEN = A1_CDRDES 
	    AND DUY.D_E_L_E_T_ = ' ' 
  	  INNER JOIN %Table:DW3% DW3
	    ON  DW3_FILIAL = %xFilial:DW3%
	    AND DW3_CODCLI = A1_COD
	    AND DW3_LOJCLI = A1_LOJA
	    AND DW3_VEND   = A3_COD
	    AND ( DW3_TIPTRA = DC5_TIPTRA
	       OR DW3_TIPTRA = '4' )
	    AND DW3.D_E_L_E_T_ = ' '
		%Exp:cQuery2%
	  WHERE AAM_FILIAL = %xFilial:AAM%
	    AND AAM_FIMVIG = ' ' 
	    AND EXISTS(
	            SELECT 'X' 
	               FROM %Table:DVC% DVC 
	               WHERE DVC_FILIAL = %xFilial:DVC%
	                 AND DVC_CODCLI = AAM_CODCLI 
	                 AND DVC_LOJCLI = AAM_LOJA 
	                 %Exp:cJoinSub%
	                 AND DVC.D_E_L_E_T_ = ' ')
	    AND AAM.D_E_L_E_T_ = ' ' 
		%Exp:cWhere%
		) TRB1
		ORDER BY DUY_FILIAL,DUY_FILDES,CODTABFRE,CODTIPTAB ,A1_NREDUZ
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

//-- Filtragem do relatório
//-- Query do relatório da secao 1
If !Empty(MV_PAR17)
	Begin Report Query oReport:Section(1):Section(1):Section(1):Section(1)

	//-- Componentes a serem impressos
	cComp := Alltrim(MV_PAR17)
	cWhere := "% AND DVE_CODPAS IN ("
	While !Empty(SubStr(cComp,1,At(",",cComp)-1))
		cWhere += "'" + SubStr(cComp,1,At(",",cComp)-1) + "',"
		cComp := SubStr(cComp,At(",",cComp)+1)
	EndDo
	cWhere += "'" + cComp + "') %"

	BeginSql Alias cAliasQry2
		SELECT DVE_CODPAS, MAX(DT3_DESCRI) DT3_DESCRI, MAX(DT3_CALPES) DT3_CALPES, MIN(COBRADO) COBRADO
		    FROM (
		    SELECT DVE_CODPAS, DT3_DESCRI, DT3_CALPES, '2' COBRADO
		      FROM %table:DVE% DVE
		      JOIN %table:DT3% DT3
		        ON DT3_FILIAL  = %xFilial:DT3%
		        AND DT3_CODPAS = DVE_CODPAS
		        AND DT3.%NotDel%
		      WHERE DVE_FILIAL = %xFilial:DVE%
		        AND DVE_TABFRE = %Exp:(cAliasQry)->CODTABFRE%
		        AND DVE_TIPTAB = %Exp:(cAliasQry)->CODTIPTAB%
		        AND DVE.%NotDel%
 				  %Exp:cWhere%
		    UNION ALL
		    SELECT DVE_CODPAS, DT3_DESCRI, DT9_CALPES, '1' COBRADO
		      FROM %table:DVE% DVE
		      JOIN %table:DT3% DT3
		        ON DT3_FILIAL  = %xFilial:DT3%
		        AND DT3_CODPAS = DVE_CODPAS
		        AND DT3.%NotDel%
		      LEFT JOIN %table:DT9% DT9
		        ON DT9_FILIAL  = %xFilial:DT9%
		        AND DT9_NCONTR = %Exp:(cAliasQry)->AAM_CONTRT%
		        AND DT9_SERVIC = %Exp:(cAliasQry)->CODSERVIC%
		        AND DT9_CODPAS = DVE_CODPAS
		        AND DT9.%NotDel%
		      WHERE DVE_FILIAL = %xFilial:DVE%
		        AND DVE_TABFRE = %Exp:(cAliasQry)->CODTABFRE%
		        AND DVE_TIPTAB = %Exp:(cAliasQry)->CODTIPTAB%
		        AND DVE.%NotDel%
				  %Exp:cWhere%
		        AND EXISTS( 
		            SELECT '1' 
	 			        FROM %table:DVC% DVC
					     JOIN %table:DVD% DVD
		                ON DVD_FILIAL = %xFilial:DVD%
		                AND DVD_TABFRE = DVC_TABFRE
		                AND DVD_TIPTAB = DVC_TIPTAB
		                AND DVD_CODCLI = DVC_CODCLI
		                AND DVD_LOJCLI = DVC_LOJCLI
		                AND DVD_CDRORI = DVC_CDRORI
		                AND DVD_CDRDES = DVC_CDRDES
		                AND DVD_SEQTAB = DVC_SEQTAB
		                AND DVD_SERVIC = DVC_SERVIC
		                AND DVD_CODPRO = DVC_CODPRO
		                AND DVD_SEQTAB = DVC_SEQTAB
		                AND DVD_CODPAS = DVE.DVE_CODPAS
		                AND DVD.%NotDel%
		              WHERE DVC_FILIAL = %xFilial:DVC%
		                AND DVC_CODCLI = %Exp:(cAliasQry)->AAM_CODCLI%
		                AND DVC_LOJCLI = %Exp:(cAliasQry)->AAM_LOJA%
					       AND DVC_TABFRE = %Exp:(cAliasQry)->CODTABFRE%
					       AND DVC_TIPTAB = %Exp:(cAliasQry)->CODTIPTAB%
		                AND ( DVC_SERVIC = %Exp:(cAliasQry)->CODSERVIC% OR DVC_SERVIC = ' ' )
		                AND DVC.%NotDel%
		                AND DVC_SEQTAB = (
		                        SELECT Max(DVC_SEQTAB)
		                          FROM %Table:DVC% DVC2
		                          WHERE DVC_FILIAL = %xFilial:DVC%
		                            AND DVC_TABFRE = %Exp:(cAliasQry)->CODTABFRE%
		                            AND DVC_TIPTAB = %Exp:(cAliasQry)->CODTIPTAB%
		                            AND DVC_CODCLI = %Exp:(cAliasQry)->AAM_CODCLI%
		                            AND DVC_LOJCLI = %Exp:(cAliasQry)->AAM_LOJA%
		                            AND ( DVC_SERVIC = %Exp:(cAliasQry)->CODSERVIC% OR DVC_SERVIC = ' ' )
		                            AND %NotDel%) ) ) QUERY
		GROUP BY DVE_CODPAS
	EndSql
	
	End Report Query oReport:Section(1):Section(1):Section(1):Section(1)
EndIf

//-- Inicio da impressao do fluxo do relatório
oReport:SetMeter(AAM->(LastRec()))

//-- Utiliza a query do Pai
oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):Section(1):SetParentQuery()

DbSelectArea(cAliasQry)
If !(cAliasQry)->(Eof())
	While !oReport:Cancel() .And. !(cAliasQry)->(Eof())
		cFilNeg := (cAliasQry)->DUY_FILDES
		oReport:Section(1):Init()
		oReport:Section(1):PrintLine()
		While !(cAliasQry)->(Eof()) .And. (cAliasQry)->DUY_FILDES == cFilNeg
			cTabFre := (cAliasQry)->CODTABFRE
			cTipTab := (cAliasQry)->CODTIPTAB
			oReport:Section(1):Section(1):Init()
			oReport:Section(1):Section(1):PrintLine()
			While !(cAliasQry)->(Eof()) .And. 	(cAliasQry)->DUY_FILDES == cFilNeg .And. ;
															(cAliasQry)->CODTABFRE + (cAliasQry)->CODTIPTAB == cTabFre + cTipTab
				oReport:Section(1):Section(1):Section(1):Init()
				oReport:Section(1):Section(1):Section(1):PrintLine()
				lFinish := .F.
				oReport:Section(1):Section(1):Section(1):Section(1):ExecSQL()
				
				If !Empty(MV_PAR17) .AND. !(cAliasQry2)->(Eof())
					While !(cAliasQry2)->(Eof())
						lFinish := .T.
						oReport:Section(1):Section(1):Section(1):Section(1):Init()
						oReport:Section(1):Section(1):Section(1):Section(1):PrintLine()
						(cAliasQry2)->(dbSkip())
					EndDo
				EndIf	
				
				If lFinish
					oReport:Section(1):Section(1):Section(1):Finish()
				EndIf
				oReport:Section(1):Section(1):Section(1):Section(1):Finish()
				(cAliasQry)->(dbSkip())
			EndDo
			If !lFinish
				oReport:Section(1):Section(1):Section(1):Finish()
			EndIf
			oReport:Section(1):Section(1):Finish()	
			(cAliasQry)->(dbSkip())
		EndDo
		oReport:IncMeter()
		oReport:Section(1):Finish()
		(cAliasQry)->(dbSkip())
	EndDo
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³Tmr480Leg ³ Autor ³Wellington A Santos    ³ Data ³31/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Clientes com ajuste                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ U_Tmr480Leg(aCompTab)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ TMSR480                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ aCompTab - Array com os componentes de frete               ³±±
±±³           ³ nMax     - Tamanho das colunas do relatorio                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Tmr480Leg(aCompTab,nMax)

Local nConComp := 0
Local cLegend  := ''
//Formato do array aCompTab { codigo do componente , flag se e cobrado,  Descricao do componente , Campo que informa se usa peso ou nao , flag se imprimi o componente no relatorio }
For nConComp := 1 To Len(aCompTab)
	If aCompTab[nConComp,5] .And. nMax >= nConComp
		cLegend +=  AllTrim( aCompTab[nConComp,1] ) + "=" + AllTrim( aCompTab[nConComp,3] ) + Space(4)
	EndIf
Next nConComp

Return cLegend

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³Tmr480Sel ³ Autor ³Wellington A Santos    ³ Data ³31/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Selecionar os componetes a serem impressos                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ Tmsr480Sel()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ TMSR480                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Tmr480Sel()

Local aLayOut  := {}
Local nCountLay:= 0
Local cSelecao := ''

DT3->( DbGoTop() )
DT3->(DbSetOrder(1))

Do While DT3->( !Eof() )
	Aadd( aLayOut, { .F., DT3->DT3_CODPAS , DT3->DT3_DESCRI  } )	
	DT3->( DbSkip() )
EndDo

If TMSABrowse( aLayOut,STR0016 ,,,,.F., { STR0017, STR0018 } )
	For nCountLay := 1 To Len(aLayOut)
		If aLayOut[nCountLay,1]
			cSelecao += aLayOut[nCountLay,2] + ","
		EndIf
	Next nCountLay
	If !Empty(cSelecao)
		cSelecao := Substr(cSelecao,1,Len(cSelecao) - 1 )
	EndIf
EndIf		

VAR_IXB := cSelecao

Return .T.