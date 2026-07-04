/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#Include "TMSR590.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TMSR590   ³ Autor ³Rodolfo K. Rosseto     ³ Data ³29/05/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao do Manifesto de Carga                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMSR590()

Local oReport
Local aArea := GetArea()

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf

RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³A funcao estatica ReportDef devera ser criada para todos os ³±±
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
Local oManif
Local oFilial
Local oVeiculo
Local oMotorista
Local oDocumento
Local oTotalGeral
Local oTotManif
Local oTotaliz
Local oNotaFiscal
Local oObs
Local aAreaSM0  := SM0->(GetArea())
Local cAliasDTX := GetNextAlias()
Local cAliasDT6 := GetNextAlias()
Local lDTX_SERMAN := DTX->(FieldPos("DTX_SERMAN")) > 0

oReport := TReport():New("TMSR590",STR0002,"TMR590", {|oReport| ReportPrint(oReport,cAliasDTX,cAliasDT6)},STR0001) //"Manifesto de Cargas"
oReport:SetLandscape()			//-- paisagem
oReport:HideParamPage()			//-- inibe impressao da pagina de parametros
oReport:SetTotalInLine(.F.)	//-- define se os totalizadores serao impressos em linha ou coluna

Pergunte("TMR590",.F.)

oManif := TRSection():New(oReport,STR0003,{"DTX"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Manifesto"
oManif:SetPageBreak(.T.)
oManif:SetTotalInLine(.F.)
TRCell():New(oManif,"DTX_FILORI"		,"DTX",STR0004,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Fil.Ori."
TRCell():New(oManif,"DTX_VIAGEM"		,"DTX",STR0005,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Viagem"
TRCell():New(oManif,"DTX_FILMAN"		,"DTX",STR0006,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Fil.Manif."
TRCell():New(oManif,"DTX_MANIFE"		,"DTX",STR0003,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Manifesto"
If lDTX_SERMAN
	TRCell():New(oManif,"DTX_SERMAN"	,"DTX",/*cTitle*/ ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Serie Manifesto"
EndIf	

oFilial := TRSection():New(oManif,STR0007,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Filial"
oFilial:SetTotalInLine(.F.)
TRCell():New(oFilial,"M0_NOMECOM"		,     ,"",     /*Picture*/,60,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasDTX)->DTX_FILMAN,"M0_NOMECOM") })
TRCell():New(oFilial,"M0_ENDCOB"		,     ,STR0008,/*Picture*/,30,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasDTX)->DTX_FILMAN,"M0_ENDCOB")  }) //"End.Cob."
TRCell():New(oFilial,"M0_BAIRCOB"		,     ,STR0009,/*Picture*/,20,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasDTX)->DTX_FILMAN,"M0_BAIRCOB") }) //"Bairro"
TRCell():New(oFilial,"M0_CIDCOB"		,     ,"",     /*Picture*/,20,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasDTX)->DTX_FILMAN,"M0_CIDCOB")  })
TRCell():New(oFilial,"M0_ESTCOB"		,     ,"",     /*Picture*/,02,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasDTX)->DTX_FILMAN,"M0_ESTCOB")  })
TRCell():New(oFilial,"M0_CEPCOB"		,     ,STR0011,/*Picture*/,08,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasDTX)->DTX_FILMAN,"M0_CEPCOB")  }) //"CEP Cob."
TRCell():New(oFilial,"M0_CGC"			,     ,STR0012,/*Picture*/,14,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasDTX)->DTX_FILMAN,"M0_CGC")     }) //"CNPJ"
TRCell():New(oFilial,"M0_INSC"			,     ,STR0013,/*Picture*/,14,/*lPixel*/,{|| Posicione("SM0",1,cEmpAnt+(cAliasDTX)->DTX_FILMAN,"M0_INSC")    }) //"Insc."

oVeiculo := TRSection():New(oManif,STR0014,{"DA3","DUT","DVB"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Veiculo"
oVeiculo:SetTotalInLine(.F.)
TRCell():New(oVeiculo,"DA3_COD"			,"DA3",STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Veiculo"
TRCell():New(oVeiculo,"DA3_DESC"		,"DA3",STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descricao"
TRCell():New(oVeiculo,"DUT_DESCRI"		,"DUT",STR0016,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Tip.Veic."
TRCell():New(oVeiculo,"DA3_PLACA"		,"DA3",STR0017,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Placa"
TRCell():New(oVeiculo,"DA3_MUNPLA"		,"DA3",STR0018,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Cidade Placa"
TRCell():New(oVeiculo,"DA3_ESTPLA"		,"DA3",STR0019,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Estado Placa"
TRCell():New(oVeiculo,"DVB_LACRE"		,"DA3",STR0020,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Lacres"

oMotorista := TRSection():New(oVeiculo,STR0021,{"DA4"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Motorista"
oMotorista:SetTotalInLine(.F.)
TRCell():New(oMotorista,"DA4_COD"		,"DA4",STR0021,   /*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Motorista"
TRCell():New(oMotorista,"DA4_NREDUZ"	,"DA4",STR0022,   /*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome Reduz."
TRCell():New(oMotorista,"DA4_RG"		,"DA4",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oMotorista,"DA4_RGEST"		,"DA4","",        /*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oMotorista,"DA4_NUMCNH"	,"DA4",STR0023,   /*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"CNH"

oObs := TRSection():New(oManif,STR0024,{"DTQ"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Observacao"
oObs:SetTotalInLine(.F.)
TRCell():New(oObs,"DTQ_CODOBS"			,"DTQ",STR0024,/*Picture*/,80/*Tamanho*/,/*lPixel*/,{|| If(!Empty((cAliasDTX)->DTQ_CODOBS),MSMM((cAliasDTX)->DTQ_CODOBS),"") }) //"Observacao"

oDocumento := TRSection():New(oManif,STR0025,{"DT6","SA1","SF2"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Documentos"
oDocumento:SetTotalInLine(.F.)
oDocumento:SetLineBreak(.T.)
TRCell():New(oDocumento,"DT6_DOC"		,"DT6",STR0026,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"CTRC"
TRCell():New(oDocumento,"NOMEREM"		,"SA1",STR0027,/*Picture*/,/*Tamanho*/,/*lPixel*/,) //"Remetente"
TRCell():New(oDocumento,"INSCREM"		,"SA1",STR0028,/*Picture*/,/*Tamanho*/,/*lPixel*/,) //"IE Remetente"
TRCell():New(oDocumento,"A1_MUN"		,"SA1",STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDT6)->CIDREM }) //"Cidade"
TRCell():New(oDocumento,"A1_EST"		,"SA1",STR0031,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDT6)->UFREM  }) //"UF"

TRCell():New(oDocumento,"NOMEDES"		,"SA1",STR0029,/*Picture*/,/*Tamanho*/,/*lPixel*/,) //"Destinatario"
TRCell():New(oDocumento,"INSCDES"		,"SA1",STR0057,/*Picture*/,/*Tamanho*/,/*lPixel*/,) //"IE Destinat."
TRCell():New(oDocumento,"A1_MUN"		,"SA1",STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDT6)->CIDDES }) //"Cidade"
TRCell():New(oDocumento,"A1_EST"		,"SA1",STR0031,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDT6)->UFDES  }) //"UF"

TRCell():New(oDocumento,"DT6_QTDVOL"	,"DT6",STR0033,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Volumes"
TRCell():New(oDocumento,"DT6_PESO"		,"DT6",STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Peso Real"
TRCell():New(oDocumento,"DT6_PESCOB"	,"DT6",STR0035,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Peso Cob."
TRCell():New(oDocumento,"DT6_VALMER"	,"DT6",STR0036,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor Merc."
TRCell():New(oDocumento,"DT6_TIPFRE"	,"DT6",STR0037,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Tipo"
TRCell():New(oDocumento,"DT6_FILORI"	,"DT6",STR0038,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Orig"
TRCell():New(oDocumento,"DT6_FILDES"	,"DT6",STR0039,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Dest"
TRCell():New(oDocumento,"DT6_VALFRE"	,"DT6",       ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,"F2_VALFAT"		,"SF2",       ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,"F2_BASEICM"	,"SF2",       ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oDocumento,"F2_VALICM"		,"SF2",       ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oNotaFiscal := TRSection():New(oDocumento,STR0041,{"DTC","DUH","SB1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Nota Fiscal"
oNotaFiscal:SetTotalInLine(.F.)
TRCell():New(oNotaFiscal,"DTC_NUMNFC"	,"DTC",STR0041,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nota Fiscal"
TRCell():New(oNotaFiscal,"DTC_SERNFC"	,"DTC",STR0042,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Serie"
TRCell():New(oNotaFiscal,"B1_DESC"		,"SB1",STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Diz Conter"
TRCell():New(oNotaFiscal,"DUH_LOCAL"	,"DUH",STR0043,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Armazem"
TRCell():New(oNotaFiscal,"DUH_LOCALI"	,"DUH",STR0044,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Endereco"

//-- Variaveis totalizadoras por pagina
//-- Totalizador Resumo do Manifesto CIF
oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_VALMER"),"VALMER_CIF_PAG","SUM",/*oBreak*/,/*cTitle*//*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_VALFRE"),"VALFRE_CIF_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_VALFAT"),"VALNTRIB_CIF_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_BASEICM"),"VALTRIB_CIF_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_VALICM"),"VALICM_CIF_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_QTDVOL"),"QTDVOL_CIF_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESO"),"PESO_CIF_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESCOB"),"PESCOB_CIF_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_DOC"),"QTDCTRC_CIF_PAG","COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

//-- Totalizador Resumo do Manifesto FOB
oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_VALMER"),"VALMER_FOB_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_VALFRE"),"VALFRE_FOB_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_VALFAT"),"VALNTRIB_FOB_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_BASEICM"),"VALTRIB_FOB_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_VALICM"),"VALICM_FOB_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_QTDVOL"),"QTDVOL_FOB_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESO"),"PESO_FOB_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESCOB"),"PESCOB_FOB_PAG","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_DOC"),"QTDCTRC_FOB_PAG","COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

//-- Variaveis totalizadoras - Total Geral
//-- Totalizador Resumo do Manifesto CIF
oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_VALMER"),"VALMER_CIF","SUM",/*oBreak*/,/*cTitle*//*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_VALFRE"),"VALFRE_CIF","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_VALFAT"),"VALNTRIB_CIF","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_BASEICM"),"VALTRIB_CIF","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_VALICM"),"VALICM_CIF","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_QTDVOL"),"QTDVOL_CIF","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESO"),"PESO_CIF","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESCOB"),"PESCOB_CIF","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_DOC"),"QTDCTRC_CIF","COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(1,Len(DT6->DT6_TIPFRE)) })

//-- Totalizador Resumo do Manifesto FOB
oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_VALMER"),"VALMER_FOB","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_VALFRE"),"VALFRE_FOB","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_VALFAT"),"VALNTRIB_FOB","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_BASEICM"),"VALTRIB_FOB","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("F2_VALICM"),"VALICM_FOB","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_QTDVOL"),"QTDVOL_FOB","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESO"),"PESO_FOB","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_PESCOB"),"PESCOB_FOB","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

oTotaliz:=TRFunction():New(oDocumento:Cell("DT6_DOC"),"QTDCTRC_FOB","COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotaliz:SetCondition({ || (cAliasDT6)->DT6_TIPFRE == StrZero(2,Len(DT6->DT6_TIPFRE)) })

//-- Secao Totalizadora - Resumo do Manifesto
oTotManif := TRSection():New(oManif,STR0045,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Resumo do Manifesto"
oTotManif :SetHeaderSection()
TRCell():New(oTotManif,"TEXTO"		,"",STR0054 + "/" + STR0055 + "/" + STR0056,,7,/*lPixel*/,/*{|| code-block de impressao }*/) //"CIF"###"FOB"
TRCell():New(oTotManif,"VALMER"		,"",STR0046,"@E 99,999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor Mercadoria"
TRCell():New(oTotManif,"VALFRE"		,"",STR0047,"@E 99,999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor Frete"
TRCell():New(oTotManif,"VALNTRIB"	,"",STR0048,,16,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor N. Tributavel"
TRCell():New(oTotManif,"VALTRIB"	,"",STR0049,,16,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor Tributavel"
TRCell():New(oTotManif,"VALICMS"	,"",STR0050,,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor ICMS"
TRCell():New(oTotManif,"VOLUME"		,"",STR0051,,05,/*lPixel*/,/*{|| code-block de impressao }*/) //"Vols"
TRCell():New(oTotManif,"PESOREAL"	,"",STR0034,,11,/*lPixel*/,/*{|| code-block de impressao }*/) //"FOB"
TRCell():New(oTotManif,"PESOCOB"	,"",STR0035,,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Peso Cob."
TRCell():New(oTotManif,"QTDCTRC"	,"",STR0052,,03,/*lPixel*/,/*{|| code-block de impressao }*/) //"CTRCs"

//-- Secao Totalizadora - Resumo Geral do Manifesto
oTotalGeral := TRSection():New(oReport,STR0053,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Resumo Geral do Manifesto"
oTotalGeral :SetHeaderSection()
TRCell():New(oTotalGeral,"TEXTO"	,"",STR0054 + "/" + STR0055 + "/" + STR0056,,7,/*lPixel*/,/*{|| code-block de impressao }*/) //"CIF"###"FOB"###"TOTAL"
TRCell():New(oTotalGeral,"VALMER"	,"",STR0046,"@E 99,999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor Mercadoria"
TRCell():New(oTotalGeral,"VALFRE"	,"",STR0047,"@E 99,999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor Frete"
TRCell():New(oTotalGeral,"VALNTRIB"	,"",STR0048,,16,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor N. Tributavel"
TRCell():New(oTotalGeral,"VALTRIB"	,"",STR0049,,16,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor Tributavel"
TRCell():New(oTotalGeral,"VALICMS"	,"",STR0050,,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Valor ICMS"
TRCell():New(oTotalGeral,"VOLUME"	,"",STR0051,,05,/*lPixel*/,/*{|| code-block de impressao }*/) //"Vols"
TRCell():New(oTotalGeral,"PESOREAL"	,"",STR0034,,11,/*lPixel*/,/*{|| code-block de impressao }*/) //"Peso Real"
TRCell():New(oTotalGeral,"PESOCOB"	,"",STR0035,,14,/*lPixel*/,/*{|| code-block de impressao }*/) //"Peso Cob."
TRCell():New(oTotalGeral,"QTDCTRC"	,"",STR0052,,03,/*lPixel*/,/*{|| code-block de impressao }*/) //"CTRCs"

RestArea(aAreaSM0)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo Riera          ³ Data ³04.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³A funcao estatica ReportDef devera ser criada para todos os ³±±
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
Static Function ReportPrint(oReport,cAliasDTX,cAliasDT6)
Local oManif     := oReport:Section(1)
Local oFilial    := oReport:Section(1):Section(1)
Local oVeiculo   := oReport:Section(1):Section(2) 
Local oMotorista := oReport:Section(1):Section(2):Section(1)
Local oObs       := oReport:Section(1):Section(3)
Local oDocumento := oReport:Section(1):Section(4)
Local oNotaFiscal:= oReport:Section(1):Section(4):Section(1)
Local oTotManif  := oReport:Section(1):Section(5)
Local oTotGeral  := oReport:Section(2)
Local cAliasDA3  := ''
Local cAliasDA4  := ''
Local cAliasDTC  := ''
Local cCodVei    := ''
Local cFilNfc    := ''
Local cNumNfc    := ''
Local cSerNfc    := ''
Local cFilSF2    := ''
Local lDTX_SERMAN := DTX->(FieldPos("DTX_SERMAN")) > 0

If Empty(xFilial('SF2'))
	cFilSF2:= "%'" + xFilial('SF2') + "'%"
Else
	cFilSF2:= "%DT6_FILDOC%"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao Manifestos                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oManif:BeginQuery()
If !lDTX_SERMAN

	BeginSql Alias cAliasDTX
	
	SELECT DTX_FILORI, DTX_VIAGEM, DTX_FILMAN, DTX_MANIFE, DTQ_CODOBS
		FROM %table:DTX% DTX

		JOIN %table:DTQ% DTQ ON
		DTQ_FILIAL = %xFilial:DTQ%
		AND DTQ_FILORI = DTX_FILORI
		AND DTQ_VIAGEM = DTX_VIAGEM
		AND DTQ.%NotDel%

		WHERE DTX_FILIAL = %xFilial:DTX%
			AND DTX_FILORI = %Exp:mv_par01%
			AND DTX_VIAGEM = %Exp:mv_par02%
			AND DTX_FILMAN >= %Exp:mv_par03%
			AND DTX_MANIFE >= %Exp:mv_par05%
			AND DTX_FILMAN <= %Exp:mv_par04%
			AND DTX_MANIFE <= %Exp:mv_par06%
			AND DTX.%NotDel%

	EndSql
Else
	BeginSql Alias cAliasDTX
		SELECT DTX_FILORI, DTX_VIAGEM, DTX_FILMAN, DTX_SERMAN, DTX_MANIFE, DTQ_CODOBS
		FROM %table:DTX% DTX

		JOIN %table:DTQ% DTQ ON
		DTQ_FILIAL = %xFilial:DTQ%
		AND DTQ_FILORI = DTX_FILORI
		AND DTQ_VIAGEM = DTX_VIAGEM
		AND DTQ.%NotDel%

		WHERE DTX_FILIAL = %xFilial:DTX%
			AND DTX_FILORI = %Exp:mv_par01%
			AND DTX_VIAGEM = %Exp:mv_par02%
			AND DTX_FILMAN >= %Exp:mv_par03%
			AND DTX_MANIFE >= %Exp:mv_par05%
			AND DTX_FILMAN <= %Exp:mv_par04%
			AND DTX_MANIFE <= %Exp:mv_par06%
			AND DTX_SERMAN >= %Exp:mv_par07%
			AND DTX_SERMAN <= %Exp:mv_par08%
			AND DTX.%NotDel%
	EndSql
EndIf

oManif:EndQuery(/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao Veiculos                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oVeiculo

	cAliasDA3 := GetNextAlias()

	BeginSql Alias cAliasDA3

		SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI,
				 DTR_VIAGEM, DTR_ITEM, DTR_CODVEI, DA3_MUNPLA, DA3_ESTPLA, DVB_LACRE

		FROM %table:DTR% DTR

		JOIN %table:DA3% DA3 ON
		DA3_FILIAL  = %xFilial:DA3%
		AND DA3_COD = DTR_CODVEI
		AND DA3.%NotDel%

		LEFT JOIN %table:DVB% DVB ON
		DVB_FILIAL     = %xFilial:DVB%
		AND DVB_FILORI = DTR_FILORI
		AND DVB_VIAGEM = DTR_VIAGEM
		AND DVB_CODVEI = DTR_CODVEI
		AND DVB.%NotDel%

		WHERE DTR_FILIAL  = %xFilial:DTR%
			AND DTR_FILORI = %report_param:(cAliasDTX)->DTX_FILORI%
			AND DTR_VIAGEM = %report_param:(cAliasDTX)->DTX_VIAGEM%
			AND DTR.%NotDel%

		UNION ALL

		SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI,
				 DTR_VIAGEM, DTR_ITEM, DTR_CODRB1 DTR_CODVEI, DA3_MUNPLA, DA3_ESTPLA, ' ' DVB_LACRE

		FROM %table:DTR% DTR

		JOIN %table:DA3% DA3 ON
		DA3_FILIAL  = %xFilial:DA3%
		AND DA3_COD = DTR_CODRB1
		AND DA3.%NotDel%

		WHERE DTR_FILIAL  = %xFilial:DTR%
			AND DTR_FILORI = %report_param:(cAliasDTX)->DTX_FILORI%
			AND DTR_VIAGEM = %report_param:(cAliasDTX)->DTX_VIAGEM%
			AND DTR.%NotDel%

		UNION ALL

		SELECT DA3_COD, DA3_DESC, DA3_PLACA, DA3_CAPACM, DA3_TIPVEI, DTR_FILIAL, DTR_FILORI,
				 DTR_VIAGEM, DTR_ITEM, DTR_CODRB2 DTR_CODVEI, DA3_MUNPLA, DA3_ESTPLA, ' ' DVB_LACRE

		FROM %table:DTR% DTR

		JOIN %table:DA3% DA3 ON
		DA3_FILIAL  = %xFilial:DA3%
		AND DA3_COD = DTR_CODRB2
		AND DA3.%NotDel%

		WHERE DTR_FILIAL  = %xFilial:DTR%
			AND DTR_FILORI = %report_param:(cAliasDTX)->DTX_FILORI%
			AND DTR_VIAGEM = %report_param:(cAliasDTX)->DTX_VIAGEM%
			AND DTR.%NotDel%

		ORDER BY DTR_FILIAL, DTR_ITEM

	EndSql

END REPORT QUERY oVeiculo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao Motoristas                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oMotorista

	cAliasDA4 := GetNextAlias()

	BeginSql Alias cAliasDA4

		SELECT DA4_COD, DA4_NREDUZ, DA4_NUMCNH

		FROM %table:DA4% DA4, %table:DUP% DUP

		WHERE DA4_FILIAL  = %xFilial:DA4%
			AND DUP_CODMOT = DA4_COD
			AND DUP_FILORI = %report_param:(cAliasDTX)->DTX_FILORI%
			AND DUP_VIAGEM = %report_param:(cAliasDTX)->DTX_VIAGEM%
			AND DUP.%NotDel%
			AND DA4.%NotDel%

	EndSql

END REPORT QUERY oMotorista

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao Documentos                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oDocumento
If !lDTX_SERMAN
	BeginSql Alias cAliasDT6

		SELECT DT6_FILDOC, DT6_DOC, DT6_SERIE,
		SA11.A1_NREDUZ NOMEREM, SA11.A1_INSCR INSCREM, SA11.A1_MUN CIDREM, SA11.A1_EST UFREM,
		SA12.A1_NREDUZ NOMEDES, SA12.A1_INSCR INSCDES, SA12.A1_MUN CIDDES, SA12.A1_EST UFDES,
		DT6_QTDVOL, DT6_PESO, DT6_PESCOB, DT6_VALMER, DT6_TIPFRE, DT6_FILORI, DT6_FILDES, DT6_VALFRE,
		F2_VALFAT, F2_VALICM, (F2_VALFAT-F2_BASEICM) NTRIB, F2_BASEICM, F2_VALICM

		FROM %table:DT6% DT6

		JOIN %table:SA1% SA11 ON
		SA11.A1_FILIAL   = %xFilial:SA1%
		AND SA11.A1_COD  = DT6_CLIREM
		AND SA11.A1_LOJA = DT6_LOJREM
		AND SA11.%NotDel%

		JOIN %table:SA1% SA12 ON
		SA12.A1_FILIAL   = %xFilial:SA1%
		AND SA12.A1_COD  = DT6_CLIDES
		AND SA12.A1_LOJA = DT6_LOJDES
		AND SA12.%NotDel%

		JOIN %table:DUD% DUD ON
		DUD_FILIAL     = %xFilial:DUD%
		AND DUD_FILORI = %report_param:(cAliasDTX)->DTX_FILORI%
		AND DUD_VIAGEM = %report_param:(cAliasDTX)->DTX_VIAGEM%
		AND DUD_FILMAN = %report_param:(cAliasDTX)->DTX_FILMAN%
		AND DUD_MANIFE = %report_param:(cAliasDTX)->DTX_MANIFE%

		AND DUD_FILDOC = DT6_FILDOC
		AND DUD_DOC    = DT6_DOC
		AND DUD_SERIE  = DT6_SERIE
		AND DUD.%NotDel%

		JOIN %table:SF2% SF2 ON
		F2_FILIAL    = %exp:cFilSF2%
		AND F2_DOC   = DT6_DOC
		AND F2_SERIE = DT6_SERIE
		AND SF2.%NotDel%

		WHERE DT6_FILIAL = %xFilial:DT6%
			AND DT6.%NotDel%

	EndSql
Else
	BeginSql Alias cAliasDT6
	
			SELECT DT6_FILDOC, DT6_DOC, DT6_SERIE,
		SA11.A1_NREDUZ NOMEREM, SA11.A1_INSCR INSCREM, SA11.A1_MUN CIDREM, SA11.A1_EST UFREM,
		SA12.A1_NREDUZ NOMEDES, SA12.A1_INSCR INSCDES, SA12.A1_MUN CIDDES, SA12.A1_EST UFDES,
		DT6_QTDVOL, DT6_PESO, DT6_PESCOB, DT6_VALMER, DT6_TIPFRE, DT6_FILORI, DT6_FILDES, DT6_VALFRE,
		F2_VALFAT, F2_VALICM, (F2_VALFAT-F2_BASEICM) NTRIB, F2_BASEICM, F2_VALICM

		FROM %table:DT6% DT6

		JOIN %table:SA1% SA11 ON
		SA11.A1_FILIAL   = %xFilial:SA1%
		AND SA11.A1_COD  = DT6_CLIREM
		AND SA11.A1_LOJA = DT6_LOJREM
		AND SA11.%NotDel%

		JOIN %table:SA1% SA12 ON
		SA12.A1_FILIAL   = %xFilial:SA1%
		AND SA12.A1_COD  = DT6_CLIDES
		AND SA12.A1_LOJA = DT6_LOJDES
		AND SA12.%NotDel%

		JOIN %table:DUD% DUD ON
		DUD_FILIAL     = %xFilial:DUD%
		AND DUD_FILORI = %report_param:(cAliasDTX)->DTX_FILORI%
		AND DUD_VIAGEM = %report_param:(cAliasDTX)->DTX_VIAGEM%
		AND DUD_FILMAN = %report_param:(cAliasDTX)->DTX_FILMAN%
		AND DUD_MANIFE = %report_param:(cAliasDTX)->DTX_MANIFE%
		AND DUD_SERMAN = %report_param:(cAliasDTX)->DTX_SERMAN%

		AND DUD_FILDOC = DT6_FILDOC
		AND DUD_DOC    = DT6_DOC
		AND DUD_SERIE  = DT6_SERIE
		AND DUD.%NotDel%

		JOIN %table:SF2% SF2 ON
		F2_FILIAL    = %exp:cFilSF2%
		AND F2_DOC   = DT6_DOC
		AND F2_SERIE = DT6_SERIE
		AND SF2.%NotDel%

		WHERE DT6_FILIAL = %xFilial:DT6%
			AND DT6.%NotDel%

	EndSql
EndIf
END REPORT QUERY oDocumento

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao Notas Fiscais e Enderecamentos              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oNotaFiscal

	cAliasDTC := GetNextAlias()

	BeginSql Alias cAliasDTC

		SELECT DTC_FILORI, DTC_NUMNFC, DTC_SERNFC, DTC_CLIREM, DTC_LOJREM, DUH_LOCAL, DUH_LOCALI, B1_DESC

		FROM %table:DT6% DT6

		LEFT JOIN %table:DT6% ORI ON
				ORI.%NotDel%
			AND ORI.DT6_FILIAL = %xFilial:DT6%
			AND ORI.DT6_FILDOC = DT6.DT6_FILDCO
			AND ORI.DT6_DOCDCO = DT6.DT6_DOCDCO
			AND ORI.DT6_SERDCO = DT6.DT6_SERDCO 

		LEFT JOIN %table:DTC% DTC ON
				DTC.%NotDel%
			AND DTC.DTC_FILIAL = %xFilial:DTC%
			AND (DTC.DTC_FILDOC = DT6.DT6_FILDOC OR DTC.DTC_FILDOC = ORI.DT6_FILDCO)
			AND (DTC.DTC_DOC    = DT6.DT6_DOC    OR DTC.DTC_DOC    = ORI.DT6_DOCDCO)
			AND (DTC.DTC_SERIE   = DT6.DT6_SERIE OR DTC.DTC_SERIE  = ORI.DT6_SERDCO)

		LEFT JOIN %table:DUH% DUH ON
			DUH.DUH_FILIAL = %xFilial:DUH%
		AND DUH.DUH_FILORI = DTC.DTC_FILORI
		AND DUH.DUH_NUMNFC = DTC.DTC_NUMNFC
		AND DUH.DUH_SERNFC = DTC.DTC_SERNFC
		AND DUH.DUH_CLIREM = DTC.DTC_CLIREM
		AND DUH.DUH_LOJREM = DTC.DTC_LOJREM
		AND DUH.%NotDel%

		LEFT JOIN %table:SB1% SB1 ON
			SB1.B1_FILIAL = %xFilial:SB1%
		AND SB1.B1_COD = DTC_CODPRO
		AND SB1.%NotDel%

		LEFT JOIN %table:DY4% DY4 ON
			DY4.%NotDel%
		AND DY4.DY4_FILIAL	= %xFilial:DY4%
		AND DY4.DY4_FILDOC	= DT6.DT6_FILDOC
		AND DY4.DY4_DOC		= DT6.DT6_DOC
		AND DY4.DY4_SERIE	= DT6.DT6_SERIE
		AND DY4.DY4_CLIREM  = DTC.DTC_CLIREM 
		AND DY4.DY4_LOJREM  = DTC.DTC_LOJREM 
		AND DY4.DY4_NUMNFC  = DTC.DTC_NUMNFC 
		AND DY4.DY4_SERNFC  = DTC.DTC_SERNFC 

		WHERE DT6.DT6_FILIAL = %xFilial:DT6%
			AND (DT6.DT6_FILDOC = %report_param:(cAliasDT6)->DT6_FILDOC% OR DT6.DT6_FILDCO = %report_param:(cAliasDT6)->DT6_FILDOC%)
			AND (DT6.DT6_DOC    = %report_param:(cAliasDT6)->DT6_DOC% OR DT6.DT6_DOCDCO    = %report_param:(cAliasDT6)->DT6_DOC%)
			AND (DT6.DT6_SERIE  = %report_param:(cAliasDT6)->DT6_SERIE% OR DT6.DT6_SERDCO  = %report_param:(cAliasDT6)->DT6_SERIE%)
			AND DT6.%NotDel%
			AND '1' = (CASE WHEN DT6.DT6_DOCTMS IN('6','7') AND 
						EXISTS(
							SELECT 1 FROM %table:DY4% Y4
							WHERE
								Y4.%NotDel%
								AND Y4.DY4_CLIREM = DTC.DTC_CLIREM
								AND Y4.DY4_LOJREM = DTC.DTC_LOJREM
								AND Y4.DY4_NUMNFC = DTC.DTC_NUMNFC
								AND Y4.DY4_SERNFC = DTC.DTC_SERNFC) THEN '1'
						WHEN DT6.DT6_DOCTMS NOT IN('6','7') THEN '1' ELSE '2' END)

	EndSql

END REPORT QUERY oNotaFiscal

TRPosition():New(oVeiculo,"DUT",1,{|| xFilial("DUT")+(cAliasDA3)->DA3_TIPVEI })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(DTX->(LastRec()))

dbSelectArea(cAliasDTX)
While !oReport:Cancel() .And. !(cAliasDTX)->(Eof())

	//-- Manifesto
	oManif:Init()
	oManif:PrintLine()
	oManif:Finish()

	//-- Filial
	oFilial:Init()
	oFilial:PrintLine()
	oFilial:Finish()

	//-- Veiculos
	oVeiculo:ExecSql()
	dbSelectArea(cAliasDA3)
	oVeiculo:Init()
	While !oReport:Cancel() .And. !(cAliasDA3)->(Eof())
		cCodVei := (cAliasDA3)->DTR_CODVEI
		oVeiculo:PrintLine()
		dbSelectArea(cAliasDA3)
		(cAliasDA3)->(dbSkip())

		While (cAliasDA3)->DTR_CODVEI = cCodVei

			oVeiculo:Cell("DA3_COD"):Hide()
			oVeiculo:Cell("DA3_DESC"):Hide()
			oVeiculo:Cell("DUT_DESCRI"):Hide()
			oVeiculo:Cell("DA3_PLACA"):Hide()
			oVeiculo:Cell("DA3_MUNPLA"):Hide()
			oVeiculo:Cell("DA3_ESTPLA"):Hide()

			oVeiculo:PrintLine()

			dbSelectArea(cAliasDA3)
			(cAliasDA3)->(dbSkip())
		EndDo
		oVeiculo:Cell("DA3_COD"):Show()
		oVeiculo:Cell("DA3_DESC"):Show()
		oVeiculo:Cell("DUT_DESCRI"):Show()
		oVeiculo:Cell("DA3_PLACA"):Show()
		oVeiculo:Cell("DA3_MUNPLA"):Show()
		oVeiculo:Cell("DA3_ESTPLA"):Show()
	EndDo
	oVeiculo:Finish()

	//Motoristas
	oMotorista:ExecSql()
	dbSelectArea(cAliasDA4)
	oMotorista:Init()
	While !oReport:Cancel() .And. !(cAliasDA4)->(Eof())

		oMotorista:PrintLine()

		dbSelectArea(cAliasDA4)
		(cAliasDA4)->(dbSkip())

	EndDo
	oMotorista:Finish()

	//-- Observacao da Viagem
	oObs:Init()
	oObs:PrintLine()
	oObs:Finish()

	//-- CTRCs
	oDocumento:ExecSql()
	dbSelectArea(cAliasDT6)
	While !oReport:Cancel() .And. !(cAliasDT6)->(Eof())
		oDocumento:Init()

		oDocumento:PrintLine()

		//-- Notas-Fiscais e Endercamento
		oNotaFiscal:ExecSql()
		dbSelectArea(cAliasDTC)
		While !oReport:Cancel() .And. !(cAliasDTC)->(Eof())
			cFilNfc := (cAliasDTC)->DTC_FILORI
			cNumNfc := (cAliasDTC)->DTC_NUMNFC
			cSerNfc := (cAliasDTC)->DTC_SERNFC
			oNotaFiscal:Init()
			oNotaFiscal:PrintLine()

			dbSelectArea(cAliasDTC)
			(cAliasDTC)->(dbSkip())

			While (cAliasDTC)->(DTC_FILORI == cFilNfc .And. DTC_NUMNFC == cNumNfc .And. DTC_SERNFC == cSerNfc)

				oNotaFiscal:Cell("DTC_NUMNFC"):Hide()
				oNotaFiscal:Cell("DTC_SERNFC"):Hide()

				oNotaFiscal:PrintLine()
				dbSelectArea(cAliasDTC)
				(cAliasDTC)->(dbSkip())
			EndDo
			oNotaFiscal:Cell("DTC_NUMNFC"):Show()
			oNotaFiscal:Cell("DTC_SERNFC"):Show()
		EndDo

		oNotaFiscal:Finish()

		oDocumento:Finish()

		dbSelectArea(cAliasDT6)
		(cAliasDT6)->(dbSkip())

	EndDo

	//-- Resumo por Manifesto
	oTotManif:Init()
	oTotManif:Cell("TEXTO"):SetValue(STR0054) //"CIF"
	oTotManif:Cell("VALMER"):SetValue(oDocumento:GetFunction("VALMER_CIF_PAG"):ReportValue())
	oTotManif:Cell("VALFRE"):SetValue(oDocumento:GetFunction("VALFRE_CIF_PAG"):ReportValue())
	oTotManif:Cell("VALNTRIB"):SetValue(oDocumento:GetFunction("VALNTRIB_CIF_PAG"):ReportValue())
	oTotManif:Cell("VALTRIB"):SetValue(oDocumento:GetFunction("VALTRIB_CIF_PAG"):ReportValue())
	oTotManif:Cell("VALICMS"):SetValue(oDocumento:GetFunction("VALICM_CIF_PAG"):ReportValue())
	oTotManif:Cell("VOLUME"):SetValue(oDocumento:GetFunction("QTDVOL_CIF_PAG"):ReportValue())
	oTotManif:Cell("PESOREAL"):SetValue(oDocumento:GetFunction("PESO_CIF_PAG"):ReportValue())
	oTotManif:Cell("PESOCOB"):SetValue(oDocumento:GetFunction("PESCOB_CIF_PAG"):ReportValue())
	oTotManif:Cell("QTDCTRC"):SetValue(oDocumento:GetFunction("QTDCTRC_CIF_PAG"):ReportValue())
	oTotManif:PrintLine()

	oTotManif:Cell("TEXTO"):SetValue(STR0055) //"FOB"
	oTotManif:Cell("VALMER"):SetValue(oDocumento:GetFunction("VALMER_FOB_PAG"):ReportValue())
	oTotManif:Cell("VALFRE"):SetValue(oDocumento:GetFunction("VALFRE_FOB_PAG"):ReportValue())
	oTotManif:Cell("VALNTRIB"):SetValue(oDocumento:GetFunction("VALNTRIB_FOB_PAG"):ReportValue())
	oTotManif:Cell("VALTRIB"):SetValue(oDocumento:GetFunction("VALTRIB_FOB_PAG"):ReportValue())
	oTotManif:Cell("VALICMS"):SetValue(oDocumento:GetFunction("VALICM_FOB_PAG"):ReportValue())
	oTotManif:Cell("VOLUME"):SetValue(oDocumento:GetFunction("QTDVOL_FOB_PAG"):ReportValue())
	oTotManif:Cell("PESOREAL"):SetValue(oDocumento:GetFunction("PESO_FOB_PAG"):ReportValue())
	oTotManif:Cell("PESOCOB"):SetValue(oDocumento:GetFunction("PESCOB_FOB_PAG"):ReportValue())
	oTotManif:Cell("QTDCTRC"):SetValue(oDocumento:GetFunction("QTDCTRC_FOB_PAG"):ReportValue())
	oTotManif:PrintLine()

	oTotManif:Cell("TEXTO"):SetValue(STR0056) //"TOTAL"
	oTotManif:Cell("VALMER"):SetValue(oDocumento:GetFunction("VALMER_CIF_PAG"):ReportValue() + oDocumento:GetFunction("VALMER_FOB_PAG"):ReportValue())
	oTotManif:Cell("VALFRE"):SetValue(oDocumento:GetFunction("VALFRE_CIF_PAG"):ReportValue() + oDocumento:GetFunction("VALFRE_FOB_PAG"):ReportValue())
	oTotManif:Cell("VALNTRIB"):SetValue(oDocumento:GetFunction("VALNTRIB_CIF_PAG"):ReportValue() + oDocumento:GetFunction("VALNTRIB_FOB_PAG"):ReportValue())
	oTotManif:Cell("VALTRIB"):SetValue(oDocumento:GetFunction("VALTRIB_CIF_PAG"):ReportValue() + oDocumento:GetFunction("VALTRIB_FOB_PAG"):ReportValue())
	oTotManif:Cell("VALICMS"):SetValue(oDocumento:GetFunction("VALICM_CIF_PAG"):ReportValue() + oDocumento:GetFunction("VALICM_FOB_PAG"):ReportValue())
	oTotManif:Cell("VOLUME"):SetValue(oDocumento:GetFunction("QTDVOL_CIF_PAG"):ReportValue() + oDocumento:GetFunction("QTDVOL_FOB_PAG"):ReportValue())
	oTotManif:Cell("PESOREAL"):SetValue(oDocumento:GetFunction("PESO_CIF_PAG"):ReportValue() + oDocumento:GetFunction("PESO_FOB_PAG"):ReportValue())
	oTotManif:Cell("PESOCOB"):SetValue(oDocumento:GetFunction("PESCOB_CIF_PAG"):ReportValue() + oDocumento:GetFunction("PESCOB_FOB_PAG"):ReportValue())
	oTotManif:Cell("QTDCTRC"):SetValue(oDocumento:GetFunction("QTDCTRC_CIF_PAG"):ReportValue() + oDocumento:GetFunction("QTDCTRC_FOB_PAG"):ReportValue())
	oTotManif:PrintLine()
	oTotManif:Finish()

	//-- Zerar apos a impressao devido a quebra por manifesto
	oDocumento:GetFunction("VALMER_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("VALFRE_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("VALNTRIB_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("VALTRIB_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("VALICM_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("QTDVOL_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("PESO_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("PESCOB_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("QTDCTRC_CIF_PAG"):ResetReport()
	oDocumento:GetFunction("VALMER_FOB_PAG"):ResetReport()
	oDocumento:GetFunction("VALFRE_FOB_PAG"):ResetReport()
	oDocumento:GetFunction("VALNTRIB_FOB_PAG"):ResetReport()
	oDocumento:GetFunction("VALTRIB_FOB_PAG"):ResetReport()
	oDocumento:GetFunction("VALICM_FOB_PAG"):ResetReport()
	oDocumento:GetFunction("QTDVOL_FOB_PAG"):ResetReport()
	oDocumento:GetFunction("PESO_FOB_PAG"):ResetReport()
	oDocumento:GetFunction("PESCOB_FOB_PAG"):ResetReport()
	oDocumento:GetFunction("QTDCTRC_FOB_PAG"):ResetReport()

	dbSelectArea(cAliasDTX)
	(cAliasDTX)->(dbSkip())
	oReport:IncMeter()
EndDo

//-- Impressao do Resumo Geral do Manifesto na ultima pagina
oTotGeral:Init()
oTotGeral:Cell("TEXTO"):SetValue(STR0054) //"CIF"
oTotGeral:Cell("VALMER"):SetValue(oDocumento:GetFunction("VALMER_CIF"):ReportValue())
oTotGeral:Cell("VALFRE"):SetValue(oDocumento:GetFunction("VALFRE_CIF"):ReportValue())
oTotGeral:Cell("VALNTRIB"):SetValue(oDocumento:GetFunction("VALNTRIB_CIF"):ReportValue())
oTotGeral:Cell("VALTRIB"):SetValue(oDocumento:GetFunction("VALTRIB_CIF"):ReportValue())
oTotGeral:Cell("VALICMS"):SetValue(oDocumento:GetFunction("VALICM_CIF"):ReportValue())
oTotGeral:Cell("VOLUME"):SetValue(oDocumento:GetFunction("QTDVOL_CIF"):ReportValue())
oTotGeral:Cell("PESOREAL"):SetValue(oDocumento:GetFunction("PESO_CIF"):ReportValue())
oTotGeral:Cell("PESOCOB"):SetValue(oDocumento:GetFunction("PESCOB_CIF"):ReportValue())
oTotGeral:Cell("QTDCTRC"):SetValue(oDocumento:GetFunction("QTDCTRC_CIF"):ReportValue())
oTotGeral:PrintLine()

oTotGeral:Cell("TEXTO"):SetValue(STR0055) //"FOB"
oTotGeral:Cell("VALMER"):SetValue(oDocumento:GetFunction("VALMER_FOB"):ReportValue())
oTotGeral:Cell("VALFRE"):SetValue(oDocumento:GetFunction("VALFRE_FOB"):ReportValue())
oTotGeral:Cell("VALNTRIB"):SetValue(oDocumento:GetFunction("VALNTRIB_FOB"):ReportValue())
oTotGeral:Cell("VALTRIB"):SetValue(oDocumento:GetFunction("VALTRIB_FOB"):ReportValue())
oTotGeral:Cell("VALICMS"):SetValue(oDocumento:GetFunction("VALICM_FOB"):ReportValue())
oTotGeral:Cell("VOLUME"):SetValue(oDocumento:GetFunction("QTDVOL_FOB"):ReportValue())
oTotGeral:Cell("PESOREAL"):SetValue(oDocumento:GetFunction("PESO_FOB"):ReportValue())
oTotGeral:Cell("PESOCOB"):SetValue(oDocumento:GetFunction("PESCOB_FOB"):ReportValue())
oTotGeral:Cell("QTDCTRC"):SetValue(oDocumento:GetFunction("QTDCTRC_FOB"):ReportValue())
oTotGeral:PrintLine()

oTotGeral:Cell("TEXTO"):SetValue(STR0056) //"TOTAL"
oTotGeral:Cell("VALMER"):SetValue(oDocumento:GetFunction("VALMER_CIF"):ReportValue() + oDocumento:GetFunction("VALMER_FOB"):ReportValue())
oTotGeral:Cell("VALFRE"):SetValue(oDocumento:GetFunction("VALFRE_CIF"):ReportValue() + oDocumento:GetFunction("VALFRE_FOB"):ReportValue())
oTotGeral:Cell("VALNTRIB"):SetValue(oDocumento:GetFunction("VALNTRIB_CIF"):ReportValue() + oDocumento:GetFunction("VALNTRIB_FOB"):ReportValue())
oTotGeral:Cell("VALTRIB"):SetValue(oDocumento:GetFunction("VALTRIB_CIF"):ReportValue() + oDocumento:GetFunction("VALTRIB_FOB"):ReportValue())
oTotGeral:Cell("VALICMS"):SetValue(oDocumento:GetFunction("VALICM_CIF"):ReportValue() + oDocumento:GetFunction("VALICM_FOB"):ReportValue())
oTotGeral:Cell("VOLUME"):SetValue(oDocumento:GetFunction("QTDVOL_CIF"):ReportValue() + oDocumento:GetFunction("QTDVOL_FOB"):ReportValue())
oTotGeral:Cell("PESOREAL"):SetValue(oDocumento:GetFunction("PESO_CIF"):ReportValue() + oDocumento:GetFunction("PESO_FOB"):ReportValue())
oTotGeral:Cell("PESOCOB"):SetValue(oDocumento:GetFunction("PESCOB_CIF"):ReportValue() + oDocumento:GetFunction("PESCOB_FOB"):ReportValue())
oTotGeral:Cell("QTDCTRC"):SetValue(oDocumento:GetFunction("QTDCTRC_CIF"):ReportValue() + oDocumento:GetFunction("QTDCTRC_FOB"):ReportValue())
oTotGeral:PrintLine()
oTotGeral:Finish()

Return
