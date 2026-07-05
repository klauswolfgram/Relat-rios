/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TMSR580.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMSR580   ³ Autor ³Rodolfo K. Rosseto     ³ Data ³23/05/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao da Ordem de Coleta                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSR580( lTMSA460 )

Local oReport
Local aArea      := GetArea()
Default lTMSA460 := .F.

oReport := ReportDef( lTMSA460 )
oReport:PrintDialog()

RestArea(aArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ TOTVS S/A             ³ Data ³ 23/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef( lTMSA460 )

Local oReport
Local oFilial
Local oColeta
Local oSolicitante
Local oProd
Local oObs
Local cPerg     := ''
Local aAreaSM0  := GetArea()
Local cAliasDT5 := GetNextAlias()
Local cAliasSol := GetNextAlias()
                                                                                 
If lTMSA460
	//--Se a chamada do relatorio for a partir
	//--do TMSA460, chama o grupo de perguntas
	//--do relatorio DESCONSIDERANDO o profile do usuario
	//--Tambem desabilita o botao "Parametros" no relatorio
	Pergunte( "TMR580", .F.,,,, .F. )                                         
	cPerg := ''
Else
	//--Se a chamada do relatorio for a partir
	//--do MENU, habilita o grupo de perguntas
	//--CONSIDERANDO o profile de usuario
	Pergunte( "TMR580", .F. )
	cPerg := 'TMR580'
EndIf	

oReport := TReport():New("TMSR580",STR0001, cPerg, {|oReport| ReportPrint(oReport,cAliasDT5,cAliasSol, lTMSA460)},STR0002) //"ORDEM DE COLETA DE CARGAS" ### "Este programa ira listar as Ordens de Coleta"
oReport:SetTotalInLine(.F.)
oReport:SetLandscape()

oFilial := TRSection():New(oReport,STR0003,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Filial"
oFilial :SetTotalInLine(.F.)
TRCell():New(oFilial ,"M0_CODFIL" ,"   " ,STR0004 ,/*Picture*/ ,2  ,/*lPixel*/	,{|| SM0->M0_CODFIL})	//"Cod.Fil."
TRCell():New(oFilial ,"M0_FILIAL" ,"   " ,STR0003 ,/*Picture*/ ,15 ,/*lPixel*/	,{|| SM0->M0_FILIAL})	//"Filial"
TRCell():New(oFilial ,"M0_NOME"   ,"   " ,STR0005 ,/*Picture*/ ,15 ,/*lPixel*/	,{|| SM0->M0_NOME})		//"Nome"
TRCell():New(oFilial ,"M0_ENDCOB" ,"   " ,STR0006 ,/*Picture*/ ,30 ,/*lPixel*/	,{|| SM0->M0_ENDCOB})	//"End.Cob."
TRCell():New(oFilial ,"M0_CEPCOB" ,"   " ,STR0007 ,/*Picture*/ ,8  ,/*lPixel*/	,{|| SM0->M0_CEPCOB})	//"Cep.Cob."
TRCell():New(oFilial ,"M0_ESTCOB" ,"   " ,STR0008 ,/*Picture*/ ,2  ,/*lPixel*/	,{|| SM0->M0_ESTCOB})	//"Est.Cob."
TRCell():New(oFilial ,"M0_TEL"    ,"   " ,STR0009 ,/*Picture*/ ,14 ,/*lPixel*/	,{|| SM0->M0_TEL})		//"Telefone"
TRCell():New(oFilial ,"M0_FAX"    ,"   " ,STR0010 ,/*Picture*/ ,14 ,/*lPixel*/	,{|| SM0->M0_FAX})		//"Fax"
TRCell():New(oFilial ,"M0_CGC"    ,"   " ,STR0011 ,/*Picture*/ ,14 ,/*lPixel*/	,{|| SM0->M0_CGC})		//"CNPJ"
TRCell():New(oFilial ,"M0_INSC"   ,"   " ,STR0012 ,/*Picture*/ ,14 ,/*lPixel*/	,{|| SM0->M0_INSC})		//"Insc.Estadual"

oColeta := TRSection():New(oReport,STR0013,{"DT5","DT6","DA8"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Dados da Solicitacao"
oColeta :SetTotalInLine(.F.)
TRCell():New(oColeta ,"DT5_FILORI" ,"DT5" ,STR0014 ,/*Picture*/ , ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Fil.Sol."
TRCell():New(oColeta ,"DT5_NUMSOL" ,"DT5" ,STR0015 ,/*Picture*/ , ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Solicitacao"
TRCell():New(oColeta ,"DT6_FILORI" ,"DT6" ,STR0016 ,/*Picture*/ , ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Fil.Ordem"
TRCell():New(oColeta ,"DT6_DOC"    ,"DT6" ,STR0017 ,/*Picture*/ , ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Ordem Col."
TRCell():New(oColeta ,SerieNfId("DT6",3,"DT6_SERIE")  ,"DT6" ,SerieNfId("DT6",7,"DT6_SERIE") ,/*Picture*/ , ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Serie"
TRCell():New(oColeta ,"DT6_DATEMI" ,"DT6" ,STR0019 ,/*Picture*/ , ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Emissao"
TRCell():New(oColeta ,"DT5_TIPCOL" ,"DT5" ,STR0020 ,/*Picture*/ , ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Tipo Coleta"
TRCell():New(oColeta ,"DA8_DESC"   ,"DA8" ,STR0021 ,/*Picture*/ , ,/*lPixel*/ ,{|| (cAliasDT5)->ROTA } ) //"Rota"

oSolicitante := TRSection():New(oColeta,STR0022,{"DUE"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Solicitante"
oSolicitante :SetTotalInLine(.F.)
TRCell():New(oSolicitante ,"DUE_NOME"   ,"DUE" ,STR0023 ,PesqPict("DUE","DUE_NOME") ,TamSx3("DUE_NOME")[1]    ,/*lPixel*/ ,{|| (cAliasDT5)->DUE_NOME }) //"Nome"
TRCell():New(oSolicitante ,"DUE_END"    ,"DUE" ,STR0024 ,PesqPict("DUE","DUE_END") ,TamSx3("DUE_END")[1]     ,/*lPixel*/ ,{|| IIf(!Empty((cAliasDT5)->DT5_SEQEND),(cAliasDT5)->DUL_END,(cAliasDT5)->DUE_END) })       //"Endereco"
TRCell():New(oSolicitante ,"DUE_BAIRRO" ,"DUE" ,STR0025 ,PesqPict("DUE","DUE_BAIRRO") ,TamSx3("DUE_BAIRRO")[1]     ,/*lPixel*/ ,{|| IIf(!Empty((cAliasDT5)->DT5_SEQEND),(cAliasDT5)->DUL_BAIRRO,(cAliasDT5)->DUE_BAIRRO) }) //"Bairro"
TRCell():New(oSolicitante ,"DUE_MUN"    ,"DUE" ,STR0026 ,PesqPict("DUE","DUE_MUN") ,TamSx3("DUE_MUN")[1]     ,/*lPixel*/ ,{|| IIf(!Empty((cAliasDT5)->DT5_SEQEND),(cAliasDT5)->DUL_MUN,(cAliasDT5)->DUE_MUN) })       //"Cidade"
TRCell():New(oSolicitante ,"DUE_CEP"    ,"DUE" ,STR0027 ,PesqPict("DUE","DUE_CEP") ,TamSx3("DUE_CEP")[1] +5  ,/*lPixel*/ ,{|| IIf(!Empty((cAliasDT5)->DT5_SEQEND),(cAliasDT5)->DUL_CEP,(cAliasDT5)->DUE_CEP) })       //"Cep"
TRCell():New(oSolicitante ,"DUE_EST"    ,"DUE" ,STR0028 ,PesqPict("DUE","DUE_EST") ,TamSx3("DUE_EST")[1]    ,/*lPixel*/ ,{|| IIf(!Empty((cAliasDT5)->DT5_SEQEND),(cAliasDT5)->DUL_EST,(cAliasDT5)->DUE_EST) })       //"UF"
TRCell():New(oSolicitante ,"DUE_CGC"    ,"DUE" ,STR0029 ,PesqPict("DUE","DUE_CGC") ,TamSx3("DUE_CGC")[1] +10 ,/*lPixel*/ ,{|| (cAliasDT5)->DUE_CGC   } ) //"CNPJ"
TRCell():New(oSolicitante ,"DUE_INSCR"  ,"DUE" ,STR0012 ,PesqPict("DUE","DUE_INSCR") ,TamSx3("DUE_INSCR")[1] ,/*lPixel*/ ,{|| (cAliasDT5)->DUE_INSCR } ) //"Insc.Estadual"

oSolicitante2 := TRSection():New(oColeta,STR0022,{"DUE","DT5"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Solicitante"
oSolicitante2 :SetTotalInLine(.F.)
TRCell():New(oSolicitante2 ,"DUE_DDD"    ,"DUE" ,STR0030 ,PesqPict("DUE","DUE_DDD") ,TamSx3("DUE_DDD")[1]  	,/*lPixel*/ ,/*{|| code-block de impressao }*/)   	//"DDD"
TRCell():New(oSolicitante2 ,"DUE_TEL"    ,"DUE" ,STR0009 ,PesqPict("DUE","DUE_TEL") ,TamSx3("DUE_TEL")[1] 	,/*lPixel*/ ,/*{|| code-block de impressao }*/) 	//"Telefone"
TRCell():New(oSolicitante2 ,"DUE_CONTAT" ,"DUE" ,STR0031 ,PesqPict("DUE","DUE_CONTAT") ,TamSx3("DUE_CONTAT")[1]  	,/*lPixel*/ ,/*{|| code-block de impressao }*/) 	//"Contato"
TRCell():New(oSolicitante2 ,"DUE_HORCOI" ,"DUE" ,STR0032 ,PesqPict("DUE","DUE_HORCOI") ,TamSx3("DUE_HORCOI")[1]  	,/*lPixel*/ ,/*{|| code-block de impressao }*/)  	//"Col.De"
TRCell():New(oSolicitante2 ,"DUE_HORCOF" ,"DUE" ,STR0033 ,PesqPict("DUE","DUE_HORCOF") ,TamSx3("DUE_HORCOF")[1]  	,/*lPixel*/ ,/*{|| code-block de impressao }*/) 	//"Col.Ate"
TRCell():New(oSolicitante2 ,"DT5_DATPRV" ,"DT5" ,STR0034 ,PesqPict("DT5","DT5_DATPRV") ,/*TamSx3("DT5_DATPRV")[1]  */	,/*lPixel*/ ,/*{|| code-block de impressao }*/) 	//"Dt. Prev."
TRCell():New(oSolicitante2 ,"DT5_HORPRV" ,"DT5" ,STR0035 ,PesqPict("DT5","DT5_HORPRV") ,TamSx3("DT5_HORPRV")[1]     	,/*lPixel*/ ,/*{|| code-block de impressao }*/) 	//"Hr. Prev."
TRCell():New(oSolicitante2 ,"DT5_OBS"    ,"   ", STR0052 ,/*Picture*/ ,TamSx3("DT5_OBS")[1] ,/*lPixel*/ , {|| AllTrim(MSMM((cAliasDT5)->DT5_CODOBS)) } ) 


oProd := TRSection():New(oColeta,STR0036,{"DUM","SB1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Produto"
oProd :SetTotalInLine(.F.)
TRCell():New(oProd ,"B1_DESC"    ,"SB1" ,STR0036 ,/*Picture*/ ,   ,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"Produto"
TRCell():New(oProd ,"DUM_CODEMB" ,"DUM" ,STR0037 ,/*Picture*/ ,   ,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"Embalagem"
TRCell():New(oProd ,"DUM_QTDVOL" ,"DUM" ,STR0038 ,/*Picture*/ ,   ,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"Volume Previsto"
TRCell():New(oProd ,"DUM_PESO"   ,"DUM" ,STR0039 ,/*Picture*/ ,   ,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"Peso Previsto"
TRCell():New(oProd ,"QTDVOL"     ,"   " ,STR0040 ,/*Picture*/ ,   ,/*lPixel*/ ,{|| "___________" }) 				//"Volume Real"
TRCell():New(oProd ,"PESO"       ,"   " ,STR0041 ,/*Picture*/ ,   ,/*lPixel*/ ,{|| "___________" }) 				//"Peso Real"

TRFunction():New(oProd:Cell("DUM_QTDVOL"),,"SUM",/*oBreak*/," "/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oProd:Cell("DUM_PESO"),,"SUM",/*oBreak*/, " "/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

oObs := TRSection():New(oColeta,STR0042,{"DT5"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Observacao"
oObs :SetTotalInLine(.F.)
TRCell():New(oObs ,"DT5_DATPRV" ,"DT5" ,STR0043 ,/*Picture*/ ,   ,/*lPixel*/ ,/*{|| code-block de impressao }*/) 					//"Data Pedido"
TRCell():New(oObs ,"DT5_HORPRV" ,"DT5" ,STR0044 ,/*Picture*/ ,   ,/*lPixel*/ ,/*{|| code-block de impressao }*/) 					//"Hora Pedido"
TRCell():New(oObs ,"HORCHG"     ,"   " ,STR0045 ,/*Picture*/ ,11 ,/*lPixel*/ ,{|| "___________" }) 								//"Hora Cheg."
TRCell():New(oObs ,"HORSAI"     ,"   " ,STR0046 ,/*Picture*/ ,11 ,/*lPixel*/ ,{|| "___________" }) 								//"Hora Sai."
TRCell():New(oObs ,"VEICULO"    ,"   " ,STR0047 ,/*Picture*/ ,20 ,/*lPixel*/ ,{|| "____________________" }) 						//"Veiculo"
TRCell():New(oObs ,"KMVEI"      ,"   " ,STR0048 ,/*Picture*/ ,11 ,/*lPixel*/ ,{|| "___________" }) 								//"Km"
TRCell():New(oObs ,"DATA"       ,"   " ,STR0049 ,/*Picture*/ ,23 ,/*lPixel*/ ,{|| "_______________________" }) 					//"Data"
TRCell():New(oObs ,"ASSINATURA" ,"   " ,STR0050 ,/*Picture*/ ,40 ,/*lPixel*/ ,{|| "________________________________________" })	//"Assinatura"

RestArea(aAreaSM0)

Return( oReport )

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo Riera          ³ Data ³04.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,cAliasDT5,cAliasSol,lTMSA460)

Local cAliasDUM  := ''
Local cDocTMS    := StrZero(1, Len(DT6->DT6_DOCTMS)) // Documento coleta.
Local nRetImp    := mv_par02
Local cFetch     :=''
Local cMv_Par01  := "%" + TMR580Col(mv_par01) + "%"
Local cDocMvPar  := IIf(!Empty(mv_par01),StrTran(cMv_Par01,";",","),'')

Default lTMSA460 := .F.

If SerieNfId("DT6",3,"DT6_SERIE")=="DT6_SDOC"
	cFetch := '%DT6_SDOC,%'
Else
	cFetch :='%%'
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lTMSA460
	MakeSqlExpr('TMR580')
Else
	MakeSqlExpr(oReport:uParam)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Solicitacoes de Coleta                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:Section(2):BeginQuery()

	BeginSql Alias cAliasDT5

	SELECT DT5_FILORI, DT5_NUMSOL, (CASE WHEN DT5_STATUS = '1' THEN DT5_ROTPRE ELSE DTQ_ROTA END) ROTA ,
       	 DT5_TIPCOL, DT5_HORPRV, DT5_DATPRV, DT6_FILORI, DT6_DOC, DT6_SERIE,%Exp:cFetch% DT6_DATEMI, DT6_HOREMI,
       	 (CASE WHEN DT5_STATUS = '1' THEN DA81.DA8_DESC ELSE DA8.DA8_DESC END), DUE_NOME, DUE_END, DUE_BAIRRO, DUE_CEP, DUE_MUN, DUE_EST, DUE_CGC, DUE_INSCR, DUE_DDD,
       	 DUE_TEL,DUE_CODSOL, DUE_HORCOI, DUE_HORCOF, DUE_CONTAT, DUL_END, DUL_BAIRRO,
       	 DUL_CEP, DUL_MUN, DUL_EST, DT5_SEQEND, DT5_CODOBS, DT6.R_E_C_N_O_ DT6_RECNO
	
	FROM %table:DT5% DT5

	JOIN %table:DT6% DT6 ON
  		DT6_FILIAL = %xFilial:DT6%
		AND DT6_FILORI = %Exp:cFilAnt%
		AND DT6_DOCTMS = %Exp:cDocTMS%
		AND DT6_FIMP = %Exp:IIf(nRetImp == 1,'0','1')%
		AND DT6.%NotDel%
		
	JOIN %table:DUE% DUE ON
 		DUE_FILIAL = %xFilial:DUE%
 		AND DUE_CODSOL = DT5_CODSOL
 		AND DUE.%NotDel%

 	LEFT JOIN %table:DUL% DUL ON
 		DUL_FILIAL = %xFilial:DUL%
 		AND DT5_SEQEND <> ' '
 		AND DUL_CODSOL = DT5_CODSOL
 		AND DUL_SEQEND = DT5_SEQEND
 		AND DUL.%NotDel%

	LEFT JOIN %table:DTQ% DTQ ON
  		DTQ_FILORI = DT6_FILVGA
  		AND DTQ_VIAGEM = DT6_NUMVGA
		AND DTQ.%NotDel%

	LEFT JOIN %table:DA8% DA8 ON
  		DA8_COD = DTQ_ROTA
		AND DA8.%NotDel%
	
	LEFT JOIN %table:DA8% DA81 ON
		DA81.DA8_COD = DT5_ROTPRE
		AND DA81.%NotDel%
		
	WHERE DT5_FILIAL   = %xFilial:DT5%
  		AND DT5_FILDOC  = DT6_FILDOC
  		AND DT5_DOC     = DT6_DOC
  		AND DT5_SERIE   = DT6_SERIE
  		AND DT5.%NotDel%
  		AND DT6_DOC IN (%Exp:cDocMvPar%)
  		  		
	EndSql 

oReport:Section(2):EndQuery()

oReport:Section(2):Section(2):BeginQuery()

	BeginSql Alias cAliasSol

	SELECT DT5_FILORI, DT5_NUMSOL, (CASE WHEN DT5_STATUS = '1' THEN DT5_ROTPRE ELSE DTQ_ROTA END) ROTA ,
       	 DT5_TIPCOL, DT5_HORPRV, DT5_DATPRV, DT6_FILORI, DT6_DOC, DT6_SERIE, DT6_DATEMI, DT6_HOREMI,
       	 (CASE WHEN DT5_STATUS = '1' THEN DA81.DA8_DESC ELSE DA8.DA8_DESC END), DUE_NOME, DUE_END, DUE_BAIRRO, DUE_CEP, DUE_MUN, DUE_EST, DUE_DDD,
       	 DUE_TEL, DUE_HORCOI, DUE_HORCOF, DUE_CGC, DUE_INSCR, DUE_CONTAT, DUL_END, DUL_BAIRRO,
       	 DUL_CEP, DUL_MUN, DUL_EST, DT5_SEQEND, DT5_CODOBS, DT6.R_E_C_N_O_ DT6_RECNO
	
	FROM %table:DT5% DT5

	JOIN %table:DT6% DT6 ON
  		DT6_FILIAL = %xFilial:DT6%
		AND DT6_FILORI = %Exp:cFilAnt%
		AND DT6_DOCTMS = %Exp:cDocTMS%
		AND DT6_FIMP = %Exp:IIf(nRetImp == 1,'0','1')%
		AND DT6.%NotDel%
		
	JOIN %table:DUE% DUE ON
 		DUE_FILIAL = %xFilial:DUE%
 		AND DUE_CODSOL = DT5_CODSOL
 		AND DUE.%NotDel%

 	LEFT JOIN %table:DUL% DUL ON
 		DUL_FILIAL = %xFilial:DUL%
 		AND DT5_SEQEND <> ' '
 		AND DUL_CODSOL = DT5_CODSOL
 		AND DUL_SEQEND = DT5_SEQEND
 		AND DUL.%NotDel%

	LEFT JOIN %table:DTQ% DTQ ON
  		DTQ_FILORI = DT6_FILVGA
  		AND DTQ_VIAGEM = DT6_NUMVGA
		AND DTQ.%NotDel%

	LEFT JOIN %table:DA8% DA8 ON
  		DA8_COD = DTQ_ROTA
		AND DA8.%NotDel%
	
	LEFT JOIN %table:DA8% DA81 ON
		DA81.DA8_COD = DT5_ROTPRE
		AND DA81.%NotDel%
		
	WHERE DT5_FILIAL   = %xFilial:DT5%
  		AND DT5_FILDOC  = DT6_FILDOC
  		AND DT5_DOC     = DT6_DOC
  		AND DT5_SERIE   = DT6_SERIE
  		AND DT5.%NotDel%
  		AND DT6_DOC IN (%Exp:cDocMvPar%)
  		
	EndSql 

oReport:Section(2):Section(2):EndQuery()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Produtos                      			   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oReport:Section(2):Section(3)

	cAliasDUM := GetNextAlias()
		
	BeginSql Alias cAliasDUM

	SELECT DUM_CODPRO, DUM_CODEMB, DUM_QTDVOL, DUM_PESO, DUM_FILORI, DUM_NUMSOL
	
	FROM %table:DUM% DUM
		WHERE DUM_FILIAL = %xFilial:DUM%
 			AND DUM_FILORI = %report_param:(cAliasDT5)->DT5_FILORI%
  			AND DUM_NUMSOL = %report_param:(cAliasDT5)->DT5_NUMSOL%
			AND DUM.%NotDel%
 			
	EndSql 

END REPORT QUERY oReport:Section(2):Section(3)

TRPosition():New(oReport:Section(2):Section(3),"SB1",1,{|| xFilial("SB1")+(cAliasDUM)->DUM_CODPRO })   
TRPosition():New(oReport:Section(2):Section(3),"DUM",1,{|| xFilial("DUM")+(cAliasDUM)->DUM_FILORI+(cAliasDUM)->DUM_NUMSOL })

oReport:SetMeter(DT5->(LastRec()))

dbSelectArea(cAliasDT5)
While !oReport:Cancel() .And. !(cAliasDT5)->(Eof())
			
	oReport:Section(1):Init()
	oReport:Section(1):PrintLine()
	oReport:Section(1):Finish()

	oReport:Section(2):Init()
	oReport:Section(2):PrintLine()
	oReport:Section(2):Finish()
			
	oReport:Section(2):Section(1):Init()
	oReport:Section(2):Section(1):PrintLine()
	oReport:Section(2):Section(1):Finish()
		
	oReport:Section(2):Section(2):Init()
	oReport:Section(2):Section(2):PrintLine()
	oReport:Section(2):Section(2):Finish()

	oReport:Section(2):Section(3):ExecSql()
	dbSelectArea(cAliasDUM)
	oReport:Section(2):Section(3):Init()
	oReport:SkipLine()
	While !oReport:Cancel() .And. !(cAliasDUM)->(Eof())
		oReport:Section(2):Section(3):PrintLine()
		dbSelectArea(cAliasDUM)
		(cAliasDUM)->(dbSkip())
				
	EndDo
	oReport:Section(2):Section(3):Finish()

	oReport:Section(1):SetPageBreak(.T.)

	DT6->(DbGoTo((cAliasDT5)->DT6_RECNO))
	RecLock("DT6",.F.)
	DT6->DT6_FIMP := StrZero(1, Len(DT6->DT6_FIMP)) //Grava Flag de Impressao
	DT6->( MsUnlock() )

	dbSelectArea(cAliasDT5)
	(cAliasDT5)->(dbSkip())
	oReport:IncMeter()
EndDo

Return

/*/{Protheus.doc} TMR580Col
Remove caracteres especiais, realiza tratativa do campo range ou de registros de coletas específicos. 
@author Marlon Augusto Heiber
@since 13/02/2019
@version 12.1.23
@param  cValor
@return cValor
/*/
Static Function TMR580Col(cValor)
Local cTemp	  	:= ""
Local cQuery	:= ""
Local cAliasQry := ""
Local cColIni	:= ""
Local nPos		:= 0
Local nTamCol	:= TamSx3("DT5_NUMSOL")[1]
Local nX	  	:= 1

	cValor := StrTran(cValor,".")
	cValor := StrTran(cValor,":")
	cValor := StrTran(cValor,"]")
	cValor := StrTran(cValor,"[")
	cValor := StrTran(cValor,"}")
	cValor := StrTran(cValor,"{")
	cValor := StrTran(cValor,";")
	cValor := StrTran(cValor,"|")
	cValor := StrTran(cValor,"/")
	cValor := StrTran(cValor,"\")
	cValor := StrTran(cValor,"'")
	cValor := StrTran(cValor,'"')
	cValor := StrTran(cValor,"_")
	cValor := StrTran(cValor,"*")
	cValor := StrTran(cValor,"+")
	cValor := StrTran(cValor,"ª")
	cValor := StrTran(cValor,"º")
	cValor := StrTran(cValor,"¹")
	cValor := StrTran(cValor,"²")
	cValor := StrTran(cValor,"³")
	cValor := StrTran(cValor,"£")
	cValor := StrTran(cValor,"¢")
	cValor := StrTran(cValor,"¬")
	cValor := StrTran(cValor,"?")
	cValor := StrTran(cValor,"!")
	cValor := StrTran(cValor,"@")
	cValor := StrTran(cValor,"#")
	cValor := StrTran(cValor,"$")
	cValor := StrTran(cValor,"%")
	cValor := StrTran(cValor,"¨")
	cValor := StrTran(cValor,"&")
	cValor := StrTran(cValor,")")
	cValor := StrTran(cValor,"(")
	cValor := StrTran(cValor,"§")
	cValor := StrTran(cValor,"=")
	cValor := StrTran(cValor,"<")
	cValor := StrTran(cValor,">")
	cValor := StrTran(cValor," ","")
	cValor := StrTran(cValor,"á","a")
	cValor := StrTran(cValor,"à","a")
	cValor := StrTran(cValor,"â","a")
	cValor := StrTran(cValor,"ã","a")
	cValor := StrTran(cValor,"é","e")
	cValor := StrTran(cValor,"è","e")
	cValor := StrTran(cValor,"ê","e")
	cValor := StrTran(cValor,"í","i")
	cValor := StrTran(cValor,"ì","i")
	cValor := StrTran(cValor,"ó","o")
	cValor := StrTran(cValor,"ò","o")
	cValor := StrTran(cValor,"ô","o")
	cValor := StrTran(cValor,"õ","o")
	cValor := StrTran(cValor,"ú","u")
	cValor := StrTran(cValor,"ù","u")
	cValor := StrTran(cValor,"ç","c")
	
	cValor := Alltrim(StrTran(cValor,"DT6_DOC IN",""))
	
	If AT("-",cValor) > 0 
		cAliasQry := GetNextAlias()
		
		nPos    := AT("-",cValor)
		cColIni := SubStr(cValor,(nPos-nTamCol),nTamCol)
		cColPos := SubStr(cValor,nPos+1,nTamCol)
		
		cQuery := " SELECT DT6_DOC "
		cQuery += " FROM " + RetSqlName('DT6') + " DT6 "
		cQuery += " WHERE DT6_FILIAL = '" + xFilial('DT6') + "'"
		cQuery += " AND DT6_FILDOC = '" + cFilAnt + "'"
		cQuery += " AND DT6_DOC BETWEEN '" + cColIni + "' AND '" + cColPos + "' "
		cQuery += " AND DT6_SERIE = 'COL' "
		cQuery += " AND DT6_DOCTMS = '1' "   
		cQuery += " AND D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY DT6_DOC  "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ) , cAliasQry, .F., .T. )


		While (cAliasQry)->(!EoF())
			If Empty(cTemp)
				cTemp := (cAliasQry)->DT6_DOC
			Else
				cTemp += "," + (cAliasQry)->DT6_DOC
			EndIf
			(cAliasQry)->( DbSkip() )
		EndDo
		
		(cAliasQry)->(dbCloseArea())
	Else
		cValor := StrTran(cValor,"-")
		cTemp  := "'"+ SubStr(cValor,1,nTamCol)+"'" 
		For nX := 1 to (Len(cValor)/nTamCol)-1
			cTemp += ",'" + SubStr(cValor,(nTamCol*nX)+1,nTamCol)+"'" 
		Next nX
	EndIf
	
	cValor := cTemp
		
Return  cValor
