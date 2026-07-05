/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FATR030.ch" 
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FATR030  ³ Autor ³ Marco Bianchi         ³ Data ³ 08/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de contratos de Parceria                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FATR030()

Local oReport
Local aPDFields	:= {} 

If TRepInUse()
	//-- Interface de impressao 
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	aPDFields := {"A1_NOME"}
	FATPDLoad(Nil,Nil,aPDFields)	
	U_FATR030R3()
	FATPDUnload() 
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 08/08/06 ³±±
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

Local oReport
Local oContrato
Local oItens
Local oTotal
Local cAliasQry := GetNextAlias()
Local nTamProd  := TamSX3("ADB_CODPRO")[1]
Local nVlrTot	:= 0        
Local nPrcVen	:= 0
Local nValDes	:= 0

Local cAliasADA := GetNextAlias()
Local cAliasADB := cAliasADA 
Local cAliasSA1 := cAliasADA
Local cAliasSB1 := cAliasADA



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
oReport := TReport():New("FATR030",STR0015,"FTR030P9R1", {|oReport| ReportPrint(oReport,cAliasADA,cAliasADB,cAliasSA1,cALiasSB1,oContrato,oTotal,oItens)},STR0016 + " " + STR0017)	// "Relacao de contratos"###"Esta programa tem como objetivo demonstrar a relacao de contratos de "###"parceria, conforme os parametros definidos pelo usuario."
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³                                                                        ³
//³ MV_PAR01 : Numero                 ?                                    ³
//³ MV_PAR02 : Emissao de             ?                                    ³
//³ MV_PAR03 : Emissao ate            ?                                    ³
//³ MV_PAR04 : Cliente                ?                                    ³
//³ MV_PAR05 : Loja                   ?                                    ³
//³ MV_PAR06 : Produto                ?                                    ³
//³ MV_PAR07 : Moeda                  ?                                    ³
//³ MV_PAR08 : Qto ao Saldo           ? Nao Entregue/Entregue/Encerrado    ³
//³ MV_PAR09 : Analitico / Sintetico  ?  Analitico / Sintetico             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao Cabecalho - Section(1)                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oContrato := TRSection():New(oReport,STR0025,{"ADA"},{STR0018,STR0019,STR0020},/*Campos do SX3*/,/*Campos do SIX*/)	// "Relacao de contratos"###"Numero"###"Cliente/Loja"###"Emissao"
oContrato:SetTotalInLine(.F.)
TRCell():New(oContrato,"ADA_NUMCTR","ADA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oContrato,"ADA_EMISSA","ADA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oContrato,"ADA_CODCLI","ADA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oContrato,"ADA_LOJCLI","ADA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oContrato,"ADA_STATUS","ADA",/*Titulo*/,/*Picture*/,22,/*lPixel*/,{|| FTR030Stat((cAliasADA)->ADA_STATUS) })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao Itens - Section(1):Section(1)                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oItens := TRSection():New(oContrato,STR0026,{"ADB","SA1","SB1"},{STR0018,STR0019,STR0020},/*Campos do SX3*/,/*Campos do SIX*/)	// "Relacao de contratos"###"Numero"###"Cliente/Loja"###"Emissao"
oItens:SetTotalInLine(.F.)

TRCell():New(oItens,"ADB_NUMCTR"	,"ADB",/*Titulo*/			,/*Picture*/					,/*Tamanho*/			,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"ADA_EMISSA"	,"ADA",/*Titulo*/			,/*Picture*/					,/*Tamanho*/			,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"ADB_CODCLI"	,"ADB",/*Titulo*/			,/*Picture*/					,/*Tamanho*/			,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"ADB_LOJCLI"	,"ADB",/*Titulo*/			,/*Picture*/					,/*Tamanho*/			,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"A1_NOME"		,"SA1",/*Titulo*/			,/*Picture*/					,/*Tamanho*/			,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"ADB_CODPRO"	,"ADB",/*Titulo*/			,/*Picture*/					,TamSx3("ADB_CODPRO")[1]	,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"B1_DESC"		,"SB1",/*Titulo*/			,/*Picture*/					,IIf(nTamProd==30,21, TamSX3("B1_DESC")[1])	  		,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"ADB_ITEM"	,"ADB",/*Titulo*/			,/*Picture*/					,/*Tamanho*/	   		,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"ADB_QUANT"	,"ADB",/*Titulo*/			,/*Picture*/					,/*Tamanho*/	    		,/*lPixel*/		,/*{|| code-block de impressao }*/)
TRCell():New(oItens,"NSALDO"		,"ADB",STR0021          	,PesqPict("ADB","ADB_TOTAL")			,/*Tamanho*/			,/*lPixel*/		,{|| (cAliasADB)->ADB_QUANT-(cAliasADB)->ADB_QTDEMP})	// "Sld.Contrato"
TRCell():New(oItens,"NPRCVEN"		,"ADB",RetTitle("ADB_PRCVEN")	,PesqPict("ADB","ADB_PRCVEN",14,mv_par07)	,TamSx3("ADB_PRCVEN")[1]	,/*lPixel*/		,{|| nPrcVen})
TRCell():New(oItens,"NVLRTOT"		,"ADB",RetTitle("ADB_TOTAL")	,PesqPict("ADB","ADB_TOTAL",14,mv_par07)	,TamSx3("ADB_TOTAL")[1]		,/*lPixel*/		,{|| nVlrTot})
TRCell():New(oItens,"NVALDES"		,"ADB",RetTitle("ADB_VALDES")	,PesqPict("ADB","ADB_VALDES",14,mv_par07)	,TamSx3("ADB_VALDES")[1]	,/*lPixel*/		,{|| nValDes})
                                                                                                           	

oTotal := TRFunction():New(oItens:Cell("ADB_QUANT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
oTotal := TRFunction():New(oItens:Cell("NSALDO"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
oTotal := TRFunction():New(oItens:Cell("NVLRTOT"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
oTotal := TRFunction():New(oItens:Cell("NVALDES"	),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao Detalhes - Section(2)                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oDetalhes := TRSection():New(oReport,STR0028,{"SC5","SD2"},{STR0018,STR0019,STR0020},/*Campos do SX3*/,/*Campos do SIX*/)	// "Relacao de contratos"###"Numero"###"Cliente/Loja"###"Emissao"
oDetalhes:SetTotalInLine(.F.)

TRCell():New(oDetalhes,"C6_CLI"		,"SC6",/*Titulo*/,/*Picture*/							,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDetalhes,"C6_LOJA"		,"SC6",/*Titulo*/,/*Picture*/							,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDetalhes,"C6_NUM"		,"SC6",/*Titulo*/,/*Picture*/							,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDetalhes,"C5_EMISSAO"	,"SC5",/*Titulo*/,/*Picture*/							,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDetalhes,"C6_QTDVEN"	,"SC6",/*Titulo*/,PesqPict("SC6","C6_QTDVEN")	,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDetalhes,"D2_DOC" 		,"SD2",/*Titulo*/,/*Picture*/							,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDetalhes,"D2_SERIE"	,"SD2",/*Titulo*/,/*Picture*/							,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDetalhes,"D2_EMISSAO"	,"SD2",/*Titulo*/,/*Picture*/							,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDetalhes,"D2_QUANT"	,"SD2",/*Titulo*/,PesqPict("SD2","D2_QUANT")		,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime cabecalho no top da pagina                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetHeaderPage(.T.)
oReport:Section(1):Section(1):SetHeaderPage(.T.)


Return(oReport)               


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 08/08/06 ³±±
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
Static Function ReportPrint(oReport,cAliasADA,cAliasADB,cAliasSA1,cALiasSB1,oContrato,oTotal,oItens)

Local oBreak
Local cIndexC6 
Local nOrderSC6


Local cWhere 	:= ""	
Local cOrder 	:= "%"		
Local cCampos  := ""
Local aCpoADA   := {}
Local aCpoADB	:= {}
Local nCpo := 0

oReport:Section(1):Section(1):Cell("NVLRTOT" 	):SetBlock({|| nVlrTot		})
oReport:Section(1):Section(1):Cell("NPRCVEN" 	):SetBlock({|| nPrcVen		})
oReport:Section(1):Section(1):Cell("NVALDES" 	):SetBlock({|| nValDes		})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("ADA")
Do Case
	Case oReport:Section(1):GetOrder() == 1 //Numero
		cOrder += "ADA_FILIAL+ADA_NUMCTR"
	Case oReport:Section(1):GetOrder() == 2 //Cliente/Loja   
		cOrder += "ADA_FILIAL+ADA_CODCLI+ADA_LOJCLI+ADA_NUMCTR"
	Case oReport:Section(1):GetOrder() == 3 //Emissao
		cOrder += "ADA_FILIAL+DTOS(ADA_EMISSA)+ADA_NUMCTR"
EndCase

cOrder += "%"	   

cWhere := "%"
If MV_PAR08 == 1  //Aberto
	cWhere += "ADB.ADB_QTDEMP <> ADB.ADB_QUANT AND "
	cWhere += "ADA.ADA_STATUS <> 'E' AND "				
EndIf
If MV_PAR08 == 2 //Encerrado
	cWhere += "ADB.ADB_QTDEMP = ADB.ADB_QUANT AND "
EndIf
If MV_PAR08 == 3 //Contrato Encerrado Manualmente
	cWhere += "ADB.ADB_QTDEMP <> ADB.ADB_QUANT AND "
	cWhere += "ADA.ADA_STATUS = 'E' AND "
EndIf
cWhere += "%"

aCpoADA := ADA->(dbStruct())
aCpoADB	:= ADB->(dbStruct())
cCampos += "%"

For nCpo := 1 To Len(aCpoADA)
	If aCpoADA[nCpo][2] <> "M"
		cCampos += aCpoADA[nCpo][1] 
		cCampos += ","
	EndIf	
Next

For nCpo := 1 To Len(aCpoADB)
	cCampos += aCpoADB[nCpo][1] 
	If nCpo < Len(aCpoADB)
		cCampos += ","
	EndIf	
Next

cCampos += "%"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o Cabecalho de acordo com parametros                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " " + "em" + " " +GetMV("MV_MOEDA"+Str(mv_par07,1))) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)


oReport:Section(1):BeginQuery()

BeginSql Alias cAliasADA
SELECT %Exp:SqlOrder(cCampos)% 
FROM %Table:ADA% ADA, %Table:ADB% ADB
WHERE ADA.ADA_FILIAL = %xFilial:ADA% AND 
ADA.ADA_EMISSA >= %Exp:Dtos(MV_PAR02)% AND 
ADA.ADA_EMISSA <= %Exp:Dtos(MV_PAR03)% AND 
ADA.%notdel% AND
ADB.ADB_FILIAL = %xFilial:ADB% AND 
ADB.ADB_NUMCTR = ADA.ADA_NUMCTR AND
%Exp:cWhere%
ADB.%notdel%
ORDER BY %Exp:SqlOrder(cOrder)%
EndSql  

oReport:Section(1):EndQuery({MV_PAR01,MV_PAR04,MV_PAR05,MV_PAR06}) // Passar os parametros para query

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Usa Query da Secao Principal nas Secoes Filhas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):SetParentQuery()
TRPosition():New(oReport:Section(1):Section(1),"SB1",1,{|| xFilial("SB1")+(cAliasADB)->ADB_CODPRO })
TRPosition():New(oReport:Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+(cAliasADA)->ADA_CODCLI+(cAliasADA)->ADA_LOJCLI })	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oReport:Section(1):Section(1),"SB1",1,{|| xFilial("SB1")+(cAliasADB)->ADB_CODPRO })
TRPosition():New(oReport:Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+(cAliasADA)->ADA_CODCLI + (cAliasADA)->ADA_LOJCLI })
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria indice temporario p/ SC6 quando relatorio analitico                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par09 == 1
	cIndexC6  := CriaTrab(NIL,.F.)
	dbSelectArea("SC6")
	IndRegua("SC6",cIndexC6,"C6_FILIAL+C6_CONTRAT+C6_ITEMCON",,)
	nOrderSC6 := RetIndex("SC6")

	dbSelectArea("SC6")
	dbSetOrder(nOrderSC6+1)

	TRPosition():New(oReport:Section(2),"SC5",1,{|| xFilial("SC5")+SC6->C6_NUM })	
Else
	oReport:Section(2):Disable()
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define regra de saida do loop quando mutilizado metodo Print            ³
//³Altera texto dos totalizadores de acordo com ordem selecionada          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case oReport:Section(1):GetOrder() == 1 //Numero
		
		oReport:Section(1):Section(1):SetParentFilter({|x| (cAliasADB)->ADB_FILIAL+(cAliasADB)->ADB_NUMCTR == x}, {||xFilial("ADB")+(cAliasADA)->ADA_NUMCTR} )
		oReport:Section(1):Section(1):SetTotalText(STR0022)		// "Total do Contrato"
		oReport:Section(1):Cell("ADA_EMISSA"):Disable()
		oReport:Section(1):Cell("ADA_CODCLI"):Disable()
		oReport:Section(1):Cell("ADA_LOJCLI"):Disable()
	Case oReport:Section(1):GetOrder() == 2 //Cliente/Loja
		oReport:Section(1):Section(1):SetParentFilter({|x| (cAliasADB)->ADB_FILIAL+(cAliasADB)->ADB_CODCLI+(cALiasADB)->ADB_LOJCLI == x}, {||xFilial("ADA")+(cAliasADA)->ADA_CODCLI+(cAliasADA)->ADA_LOJCLI} )
		oReport:Section(1):Section(1):SetTotalText(STR0023)		// "Total do Cliente"
		oReport:Section(1):Cell("ADA_NUMCTR"):Disable()
		oReport:Section(1):Cell("ADA_EMISSA"):Disable()
	Case oReport:Section(1):GetOrder() == 3 //Emissao
		oReport:Section(1):Section(1):SetParentFilter({|x| (cAliasADA)->ADA_FILIAL+DTOC((cAliasADA)->ADA_EMISSA) == x}, {||xFilial("ADA")+DTOC((cAliasADA)->ADA_EMISSA)} )
		oReport:Section(1):Section(1):SetTotalText(STR0024)		// "Total do dia"
		oReport:Section(1):Cell("ADA_NUMCTR"):Disable()
		oReport:Section(1):Cell("ADA_CODCLI"):Disable()
		oReport:Section(1):Cell("ADA_LOJCLI"):Disable()
EndCase	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAliasADA)->(LastRec()))
dbSelectArea(cAliasADA)
oReport:SetMeter((cAliasADA)->(LastRec()))

While !oReport:Cancel() .And. !(cAliasADA)->(Eof())
	
	Do Case
		Case oReport:Section(1):GetOrder() == 1 //Numero
			cChave := ADA_FILIAL+ADA_NUMCTR
			bChave := {|| !oReport:Cancel() .And. !(cAliasADA)->(Eof()) .And. ADA_FILIAL+ADA_NUMCTR == cChave}
		Case oReport:Section(1):GetOrder() == 2 //Cliente/Loja
			cChave := ADA_FILIAL+ADA_CODCLI+ADA_LOJCLI
			bChave := {|| !oReport:Cancel() .And. !(cAliasADA)->(Eof()) .And. ADA_FILIAL+ADA_CODCLI+ADA_LOJCLI == cChave}
		Case oReport:Section(1):GetOrder() == 3 //Emissao
			cChave := ADA_FILIAL+DTOS(ADA_EMISSA)
			bChave := {|| !oReport:Cancel() .And. !(cAliasADA)->(Eof()) .And. ADA_FILIAL+DTOS(ADA_EMISSA) == cChave}
	EndCase
	
	lCab := .T.
	dbSelectArea(cAliasADA)
	While  Eval(bChave)
		
		dbSelectArea(cAliasADB)
		cContrato := (cAliasADA)->ADA_NUMCTR
		While !oReport:Cancel() .And. !(cAliasADB)->(Eof()) .And. (cAliasADB)->ADB_NUMCTR == cContrato

				If ((cAliasADB)->ADB_CODPRO $ MV_PAR06) .Or.; // Produto
	 				(mv_par08 == 1 .And. (cAliasADB)->ADB_QTDEMP == (cAliasADB)->ADB_QUANT ) .Or.;		// em Aberto
					(mv_par08 == 2 .And. (cAliasADB)->ADB_QTDEMP <> (cAliasADB)->ADB_QUANT ) .Or.;		// em encerradas
					(mv_par08 == 3 .And. ((cAliasADB)->ADB_QTDEMP == (cAliasADB)->ADB_QUANT ) .And. ((cAliasADA)->ADA_STATUS == 'E')) .Or.;		// Contratos encerradas Manualmente					
					dbSelectAre(cAliasADB)
					dbSkip()
					Loop
     			EndIf
     			
     			nVlrTot:=xmoeda((cAliasADB)->ADB_TOTAL,ADA->ADA_MOEDA,mv_par07,(cAliasADA)->ADA_EMISSA)
				nPrcVen:=xmoeda((cAliasADB)->ADB_PRCVEN,ADA->ADA_MOEDA,mv_par07,(cAliasADA)->ADA_EMISSA)
				nValDes:=xmoeda((cAliasADB)->ADB_VALDES,ADA->ADA_MOEDA,mv_par07,(cAliasADA)->ADA_EMISSA)

			
			If lCab
				oReport:Section(1):Init()
				oReport:Section(1):Section(1):Init()
				oReport:Section(1):PrintLine()
				lCab := .F.
			EndIf
			
			oReport:Section(1):Section(1):PrintLine()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Relatorio Analitico                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			If mv_par09 == 1 .And. SC6->(dbSeek(xFilial("SC6")+(cAliasADB)->ADB_NUMCTR+(cAliasADB)->ADB_ITEM))
				oReport:Section(2):Init()
				dbSelectArea("SC6")
				While SC6->(!Eof()) .And. SC6->C6_CONTRAT+SC6->C6_ITEMCON == (cAliasADB)->ADB_NUMCTR+(cAliasADB)->ADB_ITEM
					SD2->(dbSetOrder(8))
					If SD2->(dbSeek(xFilial("SD2")+SC6->C6_NUM+SC6->C6_ITEM))
						While SD2->(!Eof()) .And. SD2->D2_PEDIDO+SD2->D2_ITEMPV == SC6->C6_NUM+SC6->C6_ITEM
							oReport:Section(2):PrintLine()
							dbSelectArea("SD2")
							SD2->(dbSkip())
						EndDo
					Else
						oReport:Section(2):PrintLine()
					EndIf
					dbSelectArea("SC6")
					SC6->(dbSkip())
				EndDo
				oReport:Section(2):Finish()
				oReport:SkipLine()
			EndIf
			
			dbSelectArea(cAliasADB)
			dbSkip()
		EndDo
		
		dbSelectArea(cAliasADA)
		
	EndDo
	
	oReport:Section(1):Finish()
	oReport:Section(1):Section(1):Finish()
	dbSelectArea(cAliasADA)
	
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Deleta indice temporario do SC6 quando relatorio analitico              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par09 == 1
	dbSelectArea("SC6")
	dbClearFilter()
	RetIndex("SC6")
	FErase(cIndexC6+OrdBagExt())
EndIf	

Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} FTR030Stat
Retorna o texto com o status do contrato de parceria

@sample 	FTR030Stat()
@param		ExpC	Código do status do contrato			
@return		ExpC 	Retorna o texto do status do contrato

@author	Serviços
@since		23/05/2018
@version	P12
/*/
//------------------------------------------------------------------------------
Static Function FTR030Stat(cStatus)

Local cTxtStat := ""

If cStatus == "E"
	cTxtStat := STR0029		//##"Encerrado Manualmente"
ElseIf cStatus == "C"
	cTxtStat := STR0030		//##"Parcialmente Entregue"
ElseIf cStatus == "A"
	cTxtStat := STR0031		//##"Contrato em Aberto"
ElseIf cStatus == "D"
	cTxtStat := STR0032		//##"Contrato Entregue"
ElseIf cStatus == "B"
	cTxtStat := STR0033		//##"Contrato Aprovado"
EndIf

Return cTxtStat

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³FATR030   ³ Autor ³ Eduardo Riera         ³ Data ³12.07.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de contratos de Parceria                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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
User Function FATR030R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo  := "" //"Relacao de contratos"
Local cDesc1  := STR0002 //"Esta programa tem como objetivo demonstrar a relacao de contratos de "
Local cDesc2  := STR0003 //"parceria, conforme os parametros definidos pelo usuario."
Local cDesc3  := ""
Local cString := "ADA"
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .T. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "FATR030"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "FATR030"  // nome do programa

Private Tamanho := "G" // P/M/G
Private Limite  := 220 // 80/132/220
Private aOrdem  := {STR0004,STR0005,STR0006}  // Ordem do Relatorio //"Numero"###"Cliente/Loja"###"Emissao"
Private cPerg   := "FTR030"  // Pergunta do Relatorio
Private aReturn := { "A4", 1,STR0007, 1, 2, 1, "",1 } //"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)

Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault  


// Tratamento para verificar o tamanho do grupo de perguntas                   
cPerg := cPerg + Space(Len(SX1->X1_GRUPO)-Len(AllTrim(cPerg)))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³                                                                        ³
//³ MV_PAR01 : Numero de         ?                                         ³
//³ MV_PAR02 : Numero ate        ?                                         ³
//³ MV_PAR03 : Emissao de        ?                                         ³
//³ MV_PAR04 : Emissao ate       ?                                         ³
//³ MV_PAR05 : Cliente de        ?                                         ³
//³ MV_PAR06 : Cliente ate       ?                                         ³
//³ MV_PAR07 : Loja de           ?                                         ³
//³ MV_PAR08 : Loja ate          ?                                         ³
//³ MV_PAR09 : Produto de        ?                                         ³
//³ MV_PAR10 : Produto ate       ?                                         ³
//³ MV_PAR11 : Moeda             ?                                         ³
//³ MV_PAR12 : Qto ao Saldo      ? Nao Entregue/Entregue/Encerrado         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Cabecalho                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo  += STR0001


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif
RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)
Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³12.07.2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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

Static Function ImpDet(lEnd,wnrel,cString,nomeprog)  

Local Titulo	:= ""
Local aTotal    := {0,0,0,0,0,0,0,0}
Local aStruADA  := {}
Local aStruADB  := {}
Local li        := 100 // Contador de Linhas
Local lImp      := .F. // Indica se algo foi impresso
Local cbCont    := 0   // Numero de Registros Processados
Local cbText    := ""  // Mensagem do Rodape
Local cCabec1   := ""
Local cCabec2   := ""
Local cQuery    := ""
Local cQuebra   := ""
Local cContrato := ""
Local cAliasADA := "ADA"
Local cAliasADB := "ADB"
Local cAliasSB1 := "SB1"
Local cAliasSA1 := "SA1"
Local cKey      := ""
Local cArqInd   := ""
Local nX        := 0
Local cIndexC6  := CriaTrab("",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Cabecalho                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo  += AllTrim(STR0001)+" "+"em"+" "+ GetMv( "MV_MOEDA" + Str(MV_PAR11, 1)) 

//                      1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//            01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
cCabec1 := 	 STR0008 //"CONTRATO                                                            STATUS          PRODUTOS CONTRATOS"
cCabec2 :=	 STR0009 //"NUMERO EMISSAO    CLIENTE                                                           ITEM PRODUTO                                        UN QTD.CONTRATADA   SLD.CONTRADO      PRECO VENDA               VALOR       DESCONTO"
          	//XXXXXX XX/XX/XXXX XXXXXXXXXXXXXXXXXXXX-XXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99 999,999,999.99 999,999,999.99   999,999,999.99  999,999,999,999.99 999,999,999.99
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria indice temporario p/ SC6 quando relatorio analitico                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par13 == 1
	dbSelectArea("SC6")
	IndRegua("SC6",cIndexC6,"C6_FILIAL+C6_CONTRAT+C6_ITEMCON",,)
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Selecao dos registros                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("ADA")
Do Case
	Case aReturn[8] == 1 //Numero
		cKey := "ADA_FILIAL+ADA_NUMCTR"
	Case aReturn[8] == 2 //Cliente/Loja
		cKey := "ADA_FILIAL+ADA_CODCLI+ADA_LOJCLI"
	Case aReturn[8] == 3 //Emissao
		cKey := "ADA_FILIAL+DTOS(ADA_EMISSA)"
EndCase	
	

cAliasSA1 := "IMPDET"
cAliasSB1 := "IMPDET"	
cAliasADA := "IMPDET"
cAliasADB := "IMPDET"
aStruADA  := ADA->(dbStruct())
aStruADB  := ADB->(dbStruct())	

cQuery := "SELECT ADA.*,ADB.*,B1_DESC,A1_NOME "
cQuery += "FROM "+RetSqlName("ADA")+" ADA,"
cQuery += RetSqlName("ADB")+" ADB,"
cQuery += RetSqlName("SA1")+" SA1,"
cQuery += RetSqlName("SB1")+" SB1 "
cQuery += "WHERE ADA.ADA_FILIAL='"+xFilial("ADA")+"' AND "
cQuery += "ADA.ADA_NUMCTR>='"+MV_PAR01+"' AND "
cQuery += "ADA.ADA_NUMCTR<='"+MV_PAR02+"' AND "	
cQuery += "ADA.ADA_EMISSA>='"+Dtos(MV_PAR03)+"' AND "
cQuery += "ADA.ADA_EMISSA<='"+Dtos(MV_PAR04)+"' AND "
cQuery += "ADA.ADA_CODCLI>='"+MV_PAR05+"' AND "
cQuery += "ADA.ADA_CODCLI<='"+MV_PAR06+"' AND "
cQuery += "ADA.ADA_LOJCLI>='"+MV_PAR07+"' AND "
cQuery += "ADA.ADA_LOJCLI<='"+MV_PAR08+"' AND "
cQuery += "ADA.D_E_L_E_T_=' ' AND "
cQuery += "ADB.ADB_FILIAL='"+xFilial("ADB")+"' AND "
cQuery += "ADB.ADB_NUMCTR=ADA.ADA_NUMCTR AND "
cQuery += "ADB.ADB_CODPRO>='"+MV_PAR09+"' AND "
cQuery += "ADB.ADB_CODPRO<='"+MV_PAR10+"' AND "

If MV_PAR12 == 1 //Aberto
	cQuery += "ADB.ADB_QTDEMP <> ADB.ADB_QUANT AND "
	cQuery += "ADA.ADA_STATUS <> 'E' AND "				
EndIf
If MV_PAR12 == 2 //Encerrado
	cQuery += "ADB.ADB_QTDEMP = ADB.ADB_QUANT AND "
EndIf
If MV_PAR12 == 3 //Contrato Encerrado Manualmente
	cQuery += "ADB.ADB_QTDEMP <> ADB.ADB_QUANT AND "
	cQuery += "ADA.ADA_STATUS = 'E' AND "
EndIf
cQuery += "ADB.D_E_L_E_T_=' ' AND "
cQuery += "SA1.A1_FILIAL='"+xFilial("SA1")+"' AND "
cQuery += "SA1.A1_COD=ADA.ADA_CODCLI AND "
cQuery += "SA1.A1_LOJA=ADA.ADA_LOJCLI AND "
cQuery += "SA1.D_E_L_E_T_=' ' AND "
cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
cQuery += "SB1.B1_COD=ADB.ADB_CODPRO AND "
cQuery += "SB1.D_E_L_E_T_=' ' "
cQuery += "ORDER BY "+SqlOrder(cKey)

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasADA)	
For nX := 1 To Len(aStruADA)
	If aStruADA[nX][2] <> "C"
		TcSetField(cAliasADA,aStruADA[nX][1],aStruADA[nX][2],aStruADA[nX][3],aStruADA[nX][4])
	EndIf
Next nX
For nX := 1 To Len(aStruADB)
	If aStruADB[nX][2] <> "C"
		TcSetField(cAliasADB,aStruADB[nX][1],aStruADB[nX][2],aStruADB[nX][3],aStruADB[nX][4])
	EndIf
Next nX	
dbSelectArea(cAliasADA)
SetRegua(ADA->(LastRec()))
While ( !Eof() .And. xFilial("ADA")==(cAliasADA)->ADA_FILIAL )
	If lEnd
			@ Prow()+1,001 PSAY STR0010 //"CANCELADO PELO OPERADOR"
			Exit
	EndIf
	
	cContrato := (cAliasADA)->ADA_NUMCTR
	While ( !Eof() .And. xFilial("ADB")==(cAliasADB)->ADB_FILIAL .And.;
		cContrato == (cAliasADB)->ADB_NUMCTR )
		If lEnd
			@ Prow()+1,001 PSAY STR0010 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		
		If (cAliasADB)->ADB_CODPRO >= MV_PAR09 .And. (cAliasADB)->ADB_CODPRO <= MV_PAR10 .And.;
			IIF(MV_PAR12==4,.T.,IIF(MV_PAR12==1,((cAliasADB)->ADB_QTDEMP <> (cAliasADB)->ADB_QUANT ),;
			IIF (mv_par12 == 2,((cAliasADB)->ADB_QTDEMP == (cAliasADB)->ADB_QUANT ),;
			mv_par12 == 3 .And.  (cAliasADA)->ADA_STATUS == 'E')))

			If Empty(aReturn[7]) .Or. &(aReturn[7])
				lImp := .T.
				If ( li > 56 )
					li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
					li++
				EndIf
	            @ Li,000 PSAY (cAliasADB)->ADB_NUMCTR
	            @ Li,007 PSAY (cAliasADA)->ADA_EMISSA
	            @ Li,018 PSAY (cAliasADB)->ADB_CODCLI+"-"+(cAliasADB)->ADB_LOJCLI+" "+ FATPDObfuscate(SubStr((cAliasSA1)->A1_NOME,1,30),"A1_NOME") 
	            @ Li,068 PSAY (cAliasADA)->ADA_STATUS
	            @ Li,084 PSAY (cAliasADB)->ADB_ITEM
	            @ Li,089 PSAY (cAliasADB)->ADB_CODPRO+" "+SubStr((cAliasSB1)->B1_DESC,1,25)
				@ Li,144 PSAY (cAliasADB)->ADB_UM
				@ Li,147 PSAY (cAliasADB)->ADB_QUANT  PICTURE PesqPict("ADB","ADB_QUANT",14)
				@ Li,161 PSAY (cAliasADB)->ADB_QUANT-(cAliasADB)->ADB_QTDEMP PICTURE PesqPict("ADB","ADB_QTDEMP",14)
				@ Li,176 PSAY xMoeda((cAliasADB)->ADB_PRCVEN,(cAliasADA)->ADA_MOEDA,MV_PAR11,(cAliasADA)->ADA_EMISSA) PICTURE PesqPict("ADB","ADB_PRCVEN",14)
				@ Li,190 PSAY xMoeda((cAliasADB)->ADB_TOTAL,(cAliasADA)->ADA_MOEDA,MV_PAR11,(cAliasADA)->ADA_EMISSA) PICTURE PesqPict("ADB","ADB_TOTAL",18)
				@ Li,206 PSAY xMoeda((cAliasADB)->ADB_VALDES,(cAliasADA)->ADA_MOEDA,MV_PAR11,(cAliasADA)->ADA_EMISSA) PICTURE PesqPict("ADB","ADB_VALDES",14)
				Li++
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Relatorio Analitico                                                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par13 == 1 .And. SC6->(dbSeek(xFilial("SC6")+(cAliasADB)->ADB_NUMCTR+(cAliasADB)->ADB_ITEM))
					Li++
					@ Li,000 PSAY STR0027		// "     Cliente   Pedido   Emissao   Qtd.Pedido        Nota/Serie   Emissao          Qtd Nota Fiscal"
					Li++						
					dbSelectArea("SC6")
					While !Eof() .And. C6_CONTRAT+C6_ITEMCON == (cAliasADB)->ADB_NUMCTR+(cAliasADB)->ADB_ITEM
					   SC5->(dbSetOrder(1))
					   SC5->(dbSeek(xFilial("SC5")+SC6->C6_NUM))
					   SD2->(dbSetOrder(8))
					   If SD2->(dbSeek(xFilial("SD2")+SC6->C6_NUM+SC6->C6_ITEM))
						   dbSelectArea("SD2")
						   While !Eof() .And. D2_PEDIDO+D2_ITEMPV == SC6->C6_NUM+SC6->C6_ITEM
				      	   @ Li,005 PSAY SC6->C6_CLI + "/" + SC6->C6_LOJA
				         	@ Li,015 PSAY SC6->C6_NUM
				         	@ Li,024 PSAY SC5->C5_EMISSAO
					         @ Li,035 PSAY SC6->C6_QTDVEN		PICTURE PesqPict("SC6","C6_QTDVEN")
					         @ Li,052 PSAY SD2->D2_DOC + "/" + SD2->D2_SERIE
					         @ Li,065 PSAY SD2->D2_EMISSAO
					         @ Li,086 PSAY SD2->D2_QUANT		PICTURE PesqPict("SD2","D2_QUANT")
						   	Li++						   
						   	SD2->(dbSkip())
						   EndDo
					   Else
				         @ Li,005 PSAY SC6->C6_CLI + "/" + SC6->C6_LOJA
				         @ Li,015 PSAY SC6->C6_NUM
			         	@ Li,024 PSAY SC5->C5_EMISSAO				         
				  	      @ Li,035 PSAY SC6->C6_QTDVEN		PICTURE PesqPict("SC6","C6_QTDVEN")
				     	   Li++
					   EndIf    
					   dbSelectArea("SC6")
						SC6->(dbSkip())
					EndDo
					Li++
				EndIf
				aTotal[1] += xMoeda((cAliasADB)->ADB_TOTAL,(cAliasADA)->ADA_MOEDA,MV_PAR11,(cAliasADA)->ADA_EMISSA)
				aTotal[2] += xMoeda((cAliasADB)->ADB_TOTAL,(cAliasADA)->ADA_MOEDA,MV_PAR11,(cAliasADA)->ADA_EMISSA)
				aTotal[3] += (cAliasADB)->ADB_QUANT
				aTotal[4] += (cAliasADB)->ADB_QUANT
				aTotal[5] += (cAliasADB)->ADB_QUANT-(cAliasADB)->ADB_QTDEMP
				aTotal[6] += (cAliasADB)->ADB_QUANT-(cAliasADB)->ADB_QTDEMP				
				aTotal[7] += xMoeda((cAliasADB)->ADB_VALDES,(cAliasADA)->ADA_MOEDA,MV_PAR11,(cAliasADA)->ADA_EMISSA)
				aTotal[8] += xMoeda((cAliasADB)->ADB_VALDES,(cAliasADA)->ADA_MOEDA,MV_PAR11,(cAliasADA)->ADA_EMISSA)
			EndIf
		EndIf

		dbSelectArea(cAliasADA)
		cQuebra := &cKey

		dbSelectArea(cAliasADB)
		dbSkip()
		cbCont++
	EndDo
	
	IncRegua()	
	cbCont++
	dbSelectArea(cAliasADA)
	If (!(!Eof() .And. xFilial("ADA")==(cAliasADA)->ADA_FILIAL) .Or. cQuebra <> &cKey) .And. aTotal[1]<>0
		Do Case
			Case aReturn[8] == 1 //Numero
				@ Li,000 PSAY STR0011+SubStr(cQuebra,3) //"Total do contrato nr.: "
				@ Li,147 PSAY aTotal[3] PICTURE TM(aTotal[3],14,2)
				@ Li,161 PSAY aTotal[5] PICTURE TM(aTotal[5],14,2)
				@ Li,190 PSAY aTotal[1] PICTURE TM(aTotal[1],18,2)
				@ Li,206 PSAY aTotal[7] PICTURE TM(aTotal[7],14,2)
			Case aReturn[8] == 2 //Cliente/Loja
				@ Li,000 PSAY STR0012+SubStr(cQuebra,3) //"Total do cliente.: "
				@ Li,147 PSAY aTotal[3] PICTURE TM(aTotal[3],14,2)
				@ Li,161 PSAY aTotal[5] PICTURE TM(aTotal[5],14,2)
				@ Li,190 PSAY aTotal[1] PICTURE TM(aTotal[1],18,2)
				@ Li,206 PSAY aTotal[7] PICTURE TM(aTotal[7],14,2)
			Case aReturn[8] == 3 //Emissao
				@ Li,000 PSAY STR0013+Dtoc(Stod(SubStr(cQuebra,3))) //"Total da emissao.: "
				@ Li,147 PSAY aTotal[3] PICTURE TM(aTotal[3],14,2)
				@ Li,161 PSAY aTotal[5] PICTURE TM(aTotal[5],14,2)
				@ Li,190 PSAY aTotal[1] PICTURE TM(aTotal[1],18,2)
				@ Li,206 PSAY aTotal[7] PICTURE TM(aTotal[7],14,2)
		EndCase
		li+=2
		aTotal[1] := 0
		aTotal[3] := 0
		aTotal[5] := 0
		aTotal[7] := 0
	EndIf	
EndDo
If ( lImp )
	If ( li > 56 )
		li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
		li++
	EndIf
	@ Li,000 PSAY STR0014 //"Total geral.: "
	@ Li,147 PSAY aTotal[4] PICTURE TM(aTotal[4],14,2)
	@ Li,161 PSAY aTotal[6] PICTURE TM(aTotal[6],14,2)
	@ Li,190 PSAY aTotal[2] PICTURE TM(aTotal[2],18,2)
	@ Li,206 PSAY aTotal[8] PICTURE TM(aTotal[8],14,2)
	Roda(cbCont,cbText,Tamanho)
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a integridade da rotina                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea(cAliasADA)
dbCloseArea()
dbSelectArea("ADA")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Deleta indice temporario do SC6 quando relatorio analitico              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par13 == 1
	dbSelectArea("SC6")
	dbClearFilter()
	RetIndex("SC6")
	FErase(cIndexC6+OrdBagExt())
EndIf	
dbSelectArea("ADA")
dbClearFilter()
RetIndex("ADA")
FErase(cArqInd+OrdBagExt())
Set Device To Screen
Set Printer To
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
EndIf
MS_FLUSH()
Return(.T.)  




//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource


//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   


//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
