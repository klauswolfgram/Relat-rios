/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CNTR010.CH" 
#INCLUDE "PROTHEUS.CH"

/*----------Versao TReport-------------*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ CNTR010  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Contratos - Convertido com base no fonte da rotina CNTR010R3³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CNTR010(nRecNo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01     // Contrato de:                                 ³
//³ mv_par02     // Revisao de                                   ³
//³ mv_par03     // Vigencia de:                                 ³
//³ mv_par04     // Vigencia ate:                                ³
//³ mv_par05     // Situacao de:                                 ³
//³ mv_par06     // Fornecedor de:                               ³
//³ mv_par07     // Tipo de Contrato ?                           ³
//³ mv_par08     // Exibir Textos do Contrato					 ³
//³ mv_par09     // Exibir Detalhes da Medicao					 ³
//³ mv_par10     // Cliente de: 		                         ³
//| mv_par11     // Imprimir valores - Moeda do ctr/Outra moeda  ³
//| mv_par12     // Moeda: 										 ³
//| mv_par13     // Data de Referencia:							 ³
//| mv_par15     // Exibir Aprovadores Contrato? Sim/Não: 		 ³
//| mv_par16     // Exibir Aprovadores Itens? Sim/Não: 			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("CNR011",.F.)

If nRecNo != Nil
	CN9->(dbGoTo(nRecNo))
	
	MV_PAR01 := CN9->CN9_NUMERO								
	MV_PAR02 := CN9->CN9_REVISA
	MV_PAR03 := CN9->CN9_DTINIC
	MV_PAR04 := CN9->CN9_DTFIM
	MV_PAR05 := CN9->CN9_SITUAC
	MV_PAR06 := ""
	MV_PAR07 := CN9->CN9_TPCTO
	MV_PAR08 := 1
	MV_PAR09 := 1
	MV_PAR10 := ""
	MV_PAR11 := 1
	MV_PAR12 := 1
	MV_PAR13 := CTOD("  /  /  ")
	MV_PAR14 := Iif(Cn300RetSt('COMPRA'),1,2)
	MV_PAR15 := 1
	MV_PAR16 := 1
EndIf

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Define a configuracao do relatorio de contratos            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport
Local oSectCab// Sessao Cabecalho
Local oSectPla// Sessao Planilhas
Local oSectItm// Sessao Itens de Planilhas
Local oSectAgr// Sessao Agrupadores
Local oSectCac// Sessao Caucoes
Local oSectFrn// Sessao Fornecedores
Local oSectCli// Sessao Cliente
Local oSectCro// Sessao Cronograma
Local oSectMul// Sessao Multas
Local oSectMed// Sessao Medicoes
Local oSectIMe// Sessao Itens de medicoes
Local oSectBon// Sessao Multas/Bonificacoes
Local oSectDes// Sessao Descontos
Local oSectCtb// Sessao Cronograma Contabil

Local nCNBTamPrd:= TamSX3("CNB_PRODUT")[1]
Local nCNETamPrd:= TamSX3("CNE_PRODUT")[1]
Local nTamData	:= 10

oReport := TReport():New("CNTR010",OemToAnsi(STR0001),"CNR011",{|oReport| CR010Imp(oReport)},"Imprime relatorio de contratos")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cabecalho do contrato                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectCab := TRSection():New(oReport,OemToAnsi(STR0067),{"CN9","SE4","CN1"})

TRCell():New(oSectCab,"CN9_NUMERO","CN9",,,TamSx3("CN9_NUMERO"	)[1]+11)
TRCell():New(oSectCab,"CN9_REVISA","CN9",,,TamSx3("CN9_REVISA"	)[1])
TRCell():New(oSectCab,"CN1_DESCRI","CN1",STR0072,,TamSx3("CN1_DESCRI"	)[1])//Tipo
TRCell():New(oSectCab,"CN9_SITUAC","CN9",,,TamSx3("CN9_SITUAC")[1],,{|| QA_CBox("CN9_SITUAC",AllTrim(QRYCN9->CN9_SITUAC))})

TRCell():New(oSectCab,"CN9_DTPROP","CN9",		,,nTamData)
TRCell():New(oSectCab,"CN9_DTINIC","CN9",STR0076,,nTamData)//Inicio
TRCell():New(oSectCab,"CN9_ASSINA","CN9",STR0077,,nTamData)//Assinatura
TRCell():New(oSectCab,"CN9_DTREV" ,"CN9",		,,nTamData)
TRCell():New(oSectCab,"CN9_DTFIM" ,"CN9",STR0078,,nTamData)//Final

TRCell():New(oSectCab,"CN9_VLINI","CN9",,,,,{|| QRYCN9->(U_C010xMoeda(.T.,CN9_NUMERO,CN9_REVISA,"CN9_VLINI"))})
TRCell():New(oSectCab,"CN9_VLATU","CN9",,,,,{|| QRYCN9->(U_C010xMoeda(.T.,CN9_NUMERO,CN9_REVISA,"CN9_VLATU"))})
TRCell():New(oSectCab,"CN9_SALDO","CN9",,,,,{|| QRYCN9->(U_C010xMoeda(.T.,CN9_NUMERO,CN9_REVISA,"CN9_SALDO"))})

TRCell():New(oSectCab,"CN9_FLGREJ","CN9",,,TamSx3("CN9_FLGREJ")[1],,{|| QA_CBox("CN9_FLGREJ",AllTrim(QRYCN9->CN9_FLGREJ))})
TRCell():New(oSectCab,"CN6_DESCRI","CN6",RetTitle("CN9_INDICE"),,TamSx3("CN6_DESCRI")[1],,{||Alltrim(QRYCN9->CN6_DESCRI)})
oSectCab:Cell("CN1_DESCRI"):SetLineBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//- Aprovadores Contrato
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectApC := TRSection():New(oSectCab,OemToAnsi(STR0069))
oSectApC:lHeaderVisible := .T.
TrCell():New(oSectApC,"CR_NUM"		, "SCR",/*4*/,/*5*/,35,/*7*/,/*8*/)
TrCell():New(oSectApC,"CR_TIPO"		, "SCR",OemToAnsi(STR0072),/*5*/,TamSx3("CR_TIPO")[1]	,/*7*/,/*8*/)
TrCell():New(oSectApC,"CR_NIVEL"	, "SCR",/*4*/,/*5*/,TamSx3("CR_NIVEL")[1],/*7*/,/*8*/)
TrCell():New(oSectApC,"CR_USER"		, "SCR",OemToAnsi(STR0070),/*5*/,TamSx3("AK_NOME")[1]	,/*7*/,{|| QRYSCR->(UsrRetName(CR_USER))})
TrCell():New(oSectApC,"CR_USERLIB"	, "SCR",OemToAnsi(STR0073),/*5*/,TamSx3("AK_NOME")[1]	,/*7*/,{|| QRYSCR->(UsrRetName(CR_USERLIBE))})
TrCell():New(oSectApC,"CR_STATUS"	, "SCR",OemToAnsi(STR0071),/*5*/,/*6*/,/*7*/,/*8*/)
TrCell():New(oSectApC,"CR_DATALIB"	, "SCR",,,nTamData)
TrCell():New(oSectApC,"CR_OBS"		, "SCR",/*4*/,/*5*/,/*6*/,/*7*/,{|| QRYSCR->(U_C010GtMemo(R_E_C_N_O_))})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fornecedores                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectFrn := TRSection():New(oSectCab,OemToAnsi(STR0041),{"CNC","SA2"})
oSectFrn:lHeaderVisible := .T.
TRCell():New(oSectFrn,"CNC_CODIGO","CNC")
TRCell():New(oSectFrn,"CNC_LOJA","CNC")
TRCell():New(oSectFrn,"A2_NOME","SA2",RetTitle("CNC_NOME"))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cliente                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectCli := TRSection():New(oSectCab,OemToAnsi(STR0063),{"CNC","SA1"})
TRCell():New(oSectCli,"CNC_CLIENT","CNC")
TRCell():New(oSectCli,"CNC_LOJACL","CNC")
TRCell():New(oSectCli,"A1_NOME","SA1",RetTitle("A1_NOME"))
oSectCli:lHeaderVisible := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Multas                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectMul := TRSection():New(oSectCab,OemToAnsi(STR0042),{"CNH","CN4"})
oSectMul:lHeaderVisible := .T.
TRCell():New(oSectMul,"CNH_CODIGO","CNH")
TRCell():New(oSectMul,"CN4_DESCRI","CN4")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caucoes                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectCac := TRSection():New(oSectCab,OemToAnsi(STR0043),{"CN8","CN3"})
oSectCac:lHeaderVisible := .T.
TRCell():New(oSectCac,"CN8_CODIGO","CN8")
TRCell():New(oSectCac,"CN3_DESCRI","CN3")
TRCell():New(oSectCac,"CN8_FORNECE","CN8")
TRCell():New(oSectCac,"CN8_LOJA","CN8")
TRCell():New(oSectCac,"CN8_NUMDOC","CN8")
TRCell():New(oSectCac,"CN8_DTINVI","CN8")
TRCell():New(oSectCac,"CN8_DTFIVI","CN8")
TRCell():New(oSectCac,"CN8_VLEFET","CN8",,,,,{|| QRYCN8->(U_C010xMoeda(.T.,CN8_CONTRA,CN8_REVISA,"CN8_VLEFET"))})
TRCell():New(oSectCac,"CN8_MOEDA","CN8")
TRCell():New(oSectCac,"CN8_EMITEN","CN8")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cabecalho das Planilhas                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectPla := TRSection():New(oSectCab,OemToAnsi(STR0044),{"CNA","CNL"})
oSectPla:lHeaderVisible := .T.
TRCell():New(oSectPla,"CNA_NUMERO","CNA")
TRCell():New(oSectPla,"CNL_DESCRI","CNL",STR0072)//Tipo
TRCell():New(oSectPla,"CNA_FORNEC","CNA")
TRCell():New(oSectPla,"CNA_LJFORN","CNA")
TRCell():New(oSectPla,"CNA_CLIENT","CNA")
TRCell():New(oSectPla,"CNA_LOJACL","CNA")
TRCell():New(oSectPla,"CNA_DTINI" ,"CNA")
TRCell():New(oSectPla,"CNA_DTFIM" ,"CNA")
TRCell():New(oSectPla,"CNA_VLTOT","CNA",,,,,{|| QRYCNA->(U_C010xMoeda(.T.,CNA_CONTRA,CNA_REVISA,"CNA_VLTOT"))})
TRCell():New(oSectPla,"CNA_SALDO","CNA",,,,,{|| QRYCNA->(U_C010xMoeda(.T.,CNA_CONTRA,CNA_REVISA,"CNA_SALDO"))})
TRCell():New(oSectPla,"CNA_FLREAJ","CNA",,,TamSx3("CNA_FLREAJ")[1],,{|| QA_CBox("CNA_FLREAJ",AllTrim(QRYCNA->CNA_FLREAJ))})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Itens das planilhas                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectItm := TRSection():New(oSectPla,OemToAnsi(STR0045),{"CNB"})
oSectItm:lHeaderVisible := .T.
TRCell():New(oSectItm,"CNB_ITEM","CNB")
TRCell():New(oSectItm,"CNB_PRODUT","CNB",,,nCNBTamPrd)
TRCell():New(oSectItm,"CNB_QUANT","CNB")
TRCell():New(oSectItm,"CNB_VLUNIT","CNB",,,,,{|| QRYCNB->(U_C010xMoeda(.T.,CNB_CONTRA,CNB_REVISA,"CNB_VLUNIT"))})
TRCell():New(oSectItm,"CNB_VLTOT","CNB",,,,,{|| QRYCNB->(U_C010xMoeda(.T.,CNB_CONTRA,CNB_REVISA,"CNB_VLTOT"))})
TRCell():New(oSectItm,"CNB_DESC","CNB")
TRCell():New(oSectItm,"CNB_VLDESC","CNB",,,,,{|| QRYCNB->(U_C010xMoeda(.T.,CNB_CONTRA,CNB_REVISA,"CNB_VLDESC"))})
TRCell():New(oSectItm,"CNB_QTDMED","CNB")
TRCell():New(oSectItm,"CNB_SLDMED","CNB")

oSectItm:Cell("CNB_PRODUT"):SetLineBreak()

//- Agrupadores de estoque -------------------------------------------
oSectAgr	:= TRSection():New(oSectPla,OemToAnsi(STR0068),{"CXM"})
//oSectAgr:= TRSection():New(oSectPla,'Agrupadores de Estoque',{"CXM"})
oSectAgr:lHeaderVisible := .T.
TRCell():New(oSectAgr,"CXM_ITEMID","CXM")
TRCell():New(oSectAgr,"CXM_AGRTIP","CXM",,,nCNBTamPrd)
TRCell():New(oSectAgr,"CXM_AGRGRP","CXM",,,nCNBTamPrd)
TRCell():New(oSectAgr,"CXM_AGRCAT","CXM",,,nCNBTamPrd)
TRCell():New(oSectAgr,"CXM_VLMAX ","CXM",,,,,{|| QRYCXM->(U_C010xMoeda(.T.,CXM_CONTRA,CXM_REVISA,"CXM_VLMAX"))})
TRCell():New(oSectAgr,"CXM_VLMED ","CXM",,,,,{|| QRYCXM->(U_C010xMoeda(.T.,CXM_CONTRA,CXM_REVISA,"CXM_VLMED"))})

oSectAgr:Cell("CXM_ITEMID"):SetLineBreak()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cronogramas                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectCro := TRSection():New(oSectPla,OemToAnsi(STR0046),{"CNF"})
oSectCro:lHeaderVisible := .T.
TRCell():New(oSectCro,"CNF_NUMERO","CNF")
TRCell():New(oSectCro,"CNF_PARCEL","CNF")
TRCell():New(oSectCro,"CNF_COMPET","CNF")
TRCell():New(oSectCro,"CNF_VLPREV","CNF",,,,,{|| QRYCNF->(U_C010xMoeda(.T.,CNF_CONTRA,CNF_REVISA,"CNF_VLPREV"))})
TRCell():New(oSectCro,"CNF_VLREAL","CNF",,,,,{|| QRYCNF->(U_C010xMoeda(.T.,CNF_CONTRA,CNF_REVISA,"CNF_VLREAL"))})
TRCell():New(oSectCro,"CNF_SALDO","CNF",,,,,{|| QRYCNF->(U_C010xMoeda(.T.,CNF_CONTRA,CNF_REVISA,"CNF_SALDO"))})
TRCell():New(oSectCro,"CNF_DTVENC","CNF")
TRCell():New(oSectCro,"CNF_PRUMED","CNF")
TRCell():New(oSectCro,"CNF_DTREAL","CNF")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parcelas do Cronograma Contabil                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectCtb := TRSection():New(oSectPla,OemToAnsi(STR0055),{"CNW"})
oSectCtb:lHeaderVisible := .T.
TRCell():New(oSectCtb,"CNW_NUMERO","CNW")
TRCell():New(oSectCtb,"CNW_PARCEL","CNW")
TRCell():New(oSectCtb,"CNW_DTPREV","CNW")
TRCell():New(oSectCtb,"CNW_VLPREV","CNW",,,,,{|| QRYCNW->(U_C010xMoeda(.T.,CNW_CONTRA,CNW_REVISA,"CNW_VLPREV"))})
TRCell():New(oSectCtb,"CNW_HIST","CNW")
TRCell():New(oSectCtb,"CNW_CC","CNW")
TRCell():New(oSectCtb,"CNW_DTLANC","CNW")
TRCell():New(oSectCtb,"CNW_ITEMCT","CNW")
TRCell():New(oSectCtb,"CNW_CLVL","CNW")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cabecalho das Medicoes                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectMed := TRSection():New(oSectCab,OemToAnsi(STR0047),{"CND"})
oSectMed:lHeaderVisible := .T.
TRCell():New(oSectMed,"CND_NUMMED","CND")
TRCell():New(oSectMed,"CND_NUMERO","CND")
TRCell():New(oSectMed,"CND_FORNEC","CND")
TRCell():New(oSectMed,"CND_LJFORN","CND")
TRCell():New(oSectMed,"CND_COMPET","CND")
TRCell():New(oSectMed,"CND_VLTOT","CND",,,,,{|| QRYCND->(U_C010xMoeda(.T.,CND_CONTRA,CND_REVISA,"CND_VLTOT"))})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Itens de Medicoes                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectIMe := TRSection():New(oSectMed,OemToAnsi(STR0048),{"CNE"})
oSectIMe:lHeaderVisible := .T.
TRCell():New(oSectIMe,"CNE_ITEM","CNE")
TRCell():New(oSectIMe,"CNE_PRODUT","CNE",,,nCNETamPrd)
TRCell():New(oSectIMe,"CNE_QTDSOL","CNE")
TRCell():New(oSectIMe,"CNE_QUANT","CNE")
TRCell():New(oSectIMe,"CNE_VLUNIT","CNE",,,,,{|| QRYCNE->(U_C010xMoeda(.T.,CNE_CONTRA,CNE_REVISA,"CNE_VLUNIT"))})
TRCell():New(oSectIMe,"CNE_VLTOT","CNE",,,,,{|| QRYCNE->(U_C010xMoeda(.T.,CNE_CONTRA,CNE_REVISA,"CNE_VLTOT"))})

oSectIMe:Cell("CNE_PRODUT"):SetLineBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Multas/Bonificacoes                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectBon := TRSection():New(oSectMed,OemToAnsi(STR0058),{"CNR"})
oSectBon:lHeaderVisible := .T.
oSectBon:SetTotalText("")
TRCell():New(oSectBon,"CNR_TIPO","CNR")
TRCell():New(oSectBon,"CNR_DESCRI","CNR")
TRCell():New(oSectBon,"CNR_VALOR","CNR",,,,,{|| QRYCNR->(U_C010xMoeda(.T.,QRYCND->CND_CONTRA,QRYCND->CND_REVISA,"CNR_VALOR"))})
TRFunction():New(oSectBon:Cell("CNR_VALOR"),NIL,"SUM",/*oBreak*/,OemToAnsi(STR0060),/*cPicture*/,/*uFormula*/,.T.,.F.,,oSectBon,{|| IIf( QRYCNR->CNR_TIPO == "1" , .T. , .F. ) } )
TRFunction():New(oSectBon:Cell("CNR_VALOR"),NIL,"SUM",/*oBreak*/,OemToAnsi(STR0061),/*cPicture*/,/*uFormula*/,.T.,.F.,,oSectBon,{|| IIf( QRYCNR->CNR_TIPO == "2" , .T. , .F. ) } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Descontos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectDes := TRSection():New(oSectMed,OemToAnsi(STR0059),{"CNQ","CNP"})
oSectDes:lHeaderVisible := .T.
oSectDes:SetTotalText("")
TRCell():New(oSectDes,"CNQ_TPDESC","CNQ")
TRCell():New(oSectDes,"CNP_DESCRI","CNP")
TRCell():New(oSectDes,"CNQ_VALOR","CNQ",,,,,{|| QRYCNQ->(U_C010xMoeda(.T.,QRYCND->CND_CONTRA,QRYCND->CND_REVISA,"CNQ_VALOR"))})
TRFunction():New(oSectDes:Cell("CNQ_VALOR"),NIL,"SUM",,OemToAnsi(STR0062),,,.T.,.F.,,oSectDes)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Imp  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Executa impressao do relatorio de contratos                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Objeto principal do relatorio - TReport           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CR010Imp(oReport)
Local oSectCab := oReport:Section(1)//Cabecalho do contrato
Local oSectApC := oReport:Section(1):Section(1)//Aprovadores do contrato
Local oSectFrn := oReport:Section(1):Section(2)//Fornecedores
Local oSectCli := oReport:Section(1):Section(3)//Cliente
Local oSectMul := oReport:Section(1):Section(4)//Multas
Local oSectCac := oReport:Section(1):Section(5)//Caucoes

Local oSectPla := oReport:Section(1):Section(6)//Cabecalho da planilha
Local oSectItm := oReport:Section(1):Section(6):Section(1)//Itens de Planilhas
Local oSectAgr := oReport:Section(1):Section(6):Section(2)//Agrupadores de Estoque
Local oSectCro := oReport:Section(1):Section(6):Section(3)//Cronogramas
Local oSectCtb := oReport:Section(1):Section(6):Section(4)//Cronograma Contabil

Local oSectMed := oReport:Section(1):Section(7)//Medicoes
Local oSectIMe := oReport:Section(1):Section(7):Section(1)//Itens de Medicoes
Local oSectBon := oReport:Section(1):Section(7):Section(2)//Multas e Bonificacoes de Medicoes
Local oSectDes := oReport:Section(1):Section(7):Section(3)//Descontos de Medicoes
Local nTotLinha
Local nX
Local lRetrato := (oReport:GetOrientation() == 1)
Local bShowCell:= {|x|  IIF(Empty(QRYCN9->&(x)), oSectCab:Cell(x):Disable(), oSectCab:Cell(x):Enable())  }
Local aCellsCab:= {'CN9_DTPROP', 'CN9_ASSINA', 'CN9_DTREV', 'CN6_DESCRI' }
Local lExcel   := oReport:nDevice == 4

oSectCab:SetTitle(Upper(oSectCab:Title())) //Cabecalho do contrato
oSectApC:SetTitle(Upper(oSectApC:Title()))
oSectFrn:SetTitle(Upper(oSectFrn:Title()))
oSectCli:SetTitle(Upper(oSectCli:Title()))
oSectMul:SetTitle(Upper(oSectMul:Title()))
oSectCac:SetTitle(Upper(oSectCac:Title()))

oSectPla:SetTitle(Upper(oSectPla:Title())) //Cabecalho da planilha
oSectItm:SetTitle(Upper(oSectItm:Title()))
oSectAgr:SetTitle(Upper(oSectAgr:Title()))
oSectCro:SetTitle(Upper(oSectCro:Title()))
oSectCtb:SetTitle(Upper(oSectCtb:Title()))

oSectMed:SetTitle(Upper(oSectMed:Title())) //Medicoes
oSectIMe:SetTitle(Upper(oSectIMe:Title()))
oSectBon:SetTitle(Upper(oSectBon:Title()))
oSectDes:SetTitle(Upper(oSectDes:Title()))

If mv_par11 == 2
	oReport:SetTitle(oReport:Title() +STR0065 +AllTrim(GetMv("MV_SIMB" +Ltrim(Str(mv_par12)))) +")")
	oSectCac:Cell("CN8_MOEDA"):Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura perguntas do tipo Range                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(PadR("CNR011",10))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define querys para impressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
U_CR010Cab(oSectCab) //-- Cabeçalho

If mv_par15 == 1 .Or. mv_par16 == 1
	U_CR010ApC(oSectApC) //-- Aprovadores
Else
	oSectApC:Disable()
EndIf

If mv_par14 == 1
	U_CR010Frn(oSectFrn) //-- Fornecedores
	oSectCli:Disable()
	oSectPla:Cell("CNA_CLIENT"):Disable()
	oSectPla:Cell("CNA_LOJACL"):Disable()
Else
	U_CR010Cli(oSectCli) //-- Clientes
	oSectFrn:Disable()
	oSectPla:Cell("CNA_FORNEC"):Disable()
	oSectPla:Cell("CNA_LJFORN"):Disable()
EndIf

If lRetrato
	oSectCab:SetLineBreak(.T.)
	oSectApC:SetLineBreak(.T.)
EndIf

U_CR010Mul(oSectMul) //-- Multas e Bonificações
U_CR010Cac(oSectCac) //-- Cauções
U_CR010Pla(oSectPla) //-- Planilhas
U_CR010Itm(oSectItm) //-- Itens da Planilha
U_CR010Agr(oSectAgr) //-- Agrupadore de Estoque
U_CR010Cro(oSectCro) //-- Cronograma
U_CR010Ctb(oSectCtb) //-- Cronograma Contábil
U_CR010Med(oSectMed) //-- Medições
U_CR010IMe(oSectIMe) //-- Itens da Medição

If MV_PAR09 == 1
	U_CR010Bon(oSectBon) //-- Multas e Bonificações da Medição
	U_CR010Des(oSectDes) //-- Descontos da Medição
Else
	oSectBon:Disable()
	oSectDes:Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa relatorio                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectCab:Init()
While !QRYCN9->(Eof())
	If oReport:Cancel()
		Exit
	EndIf

	If lRetrato .And.  !lExcel // Verifica se a geração do relatório não é por Excel/Planilha
		aEval(aCellsCab, bShowCell)		
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho do contrato                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSectCab:PrintLine()

	If MV_PAR08 == 1
		oReport:SkipLine()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Texto do Objeto do Contrato   						   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotLinha := MlCount(MSMM(QRYCN9->CN9_CODOBJ,,,,,160))
		oReport:PrintText(STR0023)
		oReport:SkipLine()
		For nX := 1 To nTotLinha
			oReport:PrintText(MemoLine(MSMM(QRYCN9->CN9_CODOBJ,,,,,160),160,nX))
			oReport:SkipLine()
		Next nX
		If nTotLinha == 0
			oReport:PrintText(OemToAnsi(STR0040))
		EndIf
		oReport:SkipLine()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Texto de Clausulas do Contrato					      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotLinha := MlCount(MSMM(QRYCN9->CN9_CODCLA,,,,,160))
		oReport:PrintText(STR0024)
		oReport:SkipLine()
		For nX := 1 To nTotLinha
			oReport:PrintText(MemoLine(MSMM(QRYCN9->CN9_CODCLA,,,,,160),160,nX))
			oReport:SkipLine()
		Next nX
		If nTotLinha == 0
			oReport:PrintText(OemToAnsi(STR0040))
		EndIf
		oReport:SkipLine()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Texto de Justificativas do Contrato				      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotLinha := MlCount(MSMM(QRYCN9->CN9_CODJUS,,,,,160))
		oReport:PrintText(STR0025)
		oReport:SkipLine()
		For nX := 1 To nTotLinha
			oReport:PrintText(MemoLine(MSMM(QRYCN9->CN9_CODJUS,,,,,160),160,nX))
			oReport:SkipLine()
		Next nX
		If nTotLinha == 0
			oReport:PrintText(OemToAnsi(STR0040))
		EndIf
		oReport:SkipLine()
	EndIf

	//- Imprime listagem de Aprovadores do contrato
	If oSectApC:lEnabled
		oSectApC:Print()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime listagem de fornecedores                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 1
		oSectFrn:Print()
	Else
		oSectCli:Print()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime listagem de multas do contrato             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If oSectMul:lEnabled
		oSectMul:Print()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime caucoes do contrato                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If oSectCac:lEnabled
		oSectCac:Print()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime planilhas/itens/cronogramas                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If oSectPla:lEnabled
		oSectPla:Print()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime medicoes do contrato                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If oSectMed:lEnabled
		oSectMed:Print()
	EndIf

	QRYCN9->(dbSkip())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pula pagina quando quebrar contrato                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !QRYCN9->(Eof())
		oReport:EndPage()
	EndIf
EndDo

oSectCab:Finish()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Box  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime box com texto centralizado                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CR010Box(oExp01,cExp02)                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Objeto do relatorio                               ³±±
±±³          ³ cExp02 - Texto impresso                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Box(oReport,cTexto)
Local nCol1 := 7
Local nCol2 := oReport:PageWidth()-40

oReport:Box(oReport:Row()-10,2,oReport:Row()+38,oReport:PageWidth()-35)
oReport:Box(oReport:Row()-5,nCol1,oReport:Row()+33,nCol2)
oReport:PrintText(cTexto,oReport:Row(),((nCol2-nCol1)/2)-((Len(alltrim(cTexto))/2)*20))
oReport:SkipLine()
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Cab  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao do cabecalho de contratos                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao do cabecalho - TRSection                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Cab(oSectCab)
Local cContra	:= Replace(MV_PAR01,"CN9_NUMERO","CN9_NUMERO")
Local cRevisa	:= Replace(mv_par02,"CN9_REVISA","CN9_REVISA")
Local cPart	:= "%"
Local cCamp	:= "%"

cCamp += ",CN9_FILCTR"

If !Empty(mv_par07)
	cPart += "AND CN9.CN9_TPCTO = '" +mv_par07 +"' "
EndIf
If !Empty(mv_par14)
	cPart += "AND CN1.CN1_ESPCTR = '" +Str(mv_par14,1) +"' "
EndIf

cPart += '%'
cCamp += '%'

oSectCab:BeginQuery()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro dos contratos                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BeginSql alias "QRYCN9"

SELECT CN9_FILIAL,
		CN9_NUMERO,
		CN9_REVISA,
		CN9_DTINIC,
		CN9_SITUAC,
		CN9_DTFIM,
		CN9_DTPROP,
		CN9_ASSINA,
		CN9_DTENCE,
		CN9_CONDPG,
		CN9_TPCTO,
		CN9_DTULST,
		CN9_VIGE,
		CN9_INDICE,
		CN9_FLGCAU,
		CN9_MINCAU,
		CN9_FLGREJ,
		CN9_REVATU,
		CN9_VLINI,
		CN9_VLATU,
		CN9_SALDO,
		CN9_CODOBJ,
		CN9_CODCLA,
		CN9_CODJUS,
		CN9_UNVIGE,
		CN9_CLIENT,
		CN9_LOJACL,
		CN9_DTREV, 
		CN6_DESCRI
		%Exp:cCamp%

FROM 	%table:CN9% CN9

JOIN 	%Table:CN1% CN1 ON
		CN1.%NotDel% AND
		CN1.CN1_FILIAL = %xFilial:CN1% AND
		CN1.CN1_CODIGO = CN9.CN9_TPCTO

LEFT 	JOIN %table:CNC% CNC ON
		CNC.%notDel% AND
		CNC.CNC_FILIAL = %xfilial:CNC% AND
		CNC.CNC_NUMERO = CN9.CN9_NUMERO AND
		CNC.CNC_REVISA = CN9.CN9_REVISA

LEFT	JOIN %table:CN6% CN6 ON
		CN6.%notDel% AND
		CN6.CN6_FILIAL = %xfilial:CN6% AND
		CN6.CN6_CODIGO = CN9.CN9_INDICE

WHERE 	CN9.CN9_FILIAL = %xfilial:CN9% AND
     	CN9.CN9_DTINIC >= %exp:dtos(mv_par03)% AND
     	CN9.CN9_DTFIM  <= %exp:dtos(mv_par04)% AND
     	CN9.%notDel% %exp:cPart%
GROUP BY
		CN9_FILIAL,
		CN9_NUMERO,
		CN9_REVISA,
		CN9_DTINIC,
		CN9_SITUAC,
		CN9_DTFIM,
		CN9_DTPROP,
		CN9_ASSINA,
		CN9_DTENCE,
		CN9_CONDPG,
		CN9_TPCTO,
		CN9_DTULST,
		CN9_VIGE,
		CN9_INDICE,
		CN9_FLGCAU,
		CN9_MINCAU,
		CN9_FLGREJ,
		CN9_REVATU,
		CN9_VLINI,
		CN9_VLATU,
		CN9_SALDO,
		CN9_CODOBJ,
		CN9_CODCLA,
		CN9_CODJUS,
		CN9_UNVIGE,
		CN9_CLIENT,
		CN9_LOJACL,
		CN9_DTREV,
		CN6_DESCRI
		%Exp:cCamp%

ORDER BY CN9_NUMERO, CN9_REVISA

EndSql

If mv_par14 == 1
	oSectCab:EndQuery({cContra,cRevisa,MV_PAR05,MV_PAR06})
Else
	oSectCab:EndQuery({cContra,cRevisa,MV_PAR05,MV_PAR10})
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura posicionamento das tabelas filhas        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSectCab,"SE4",1,"xFilial('SE4')+QRYCN9->CN9_CONDPG")//Cond. Pagto
TRPosition():New(oSectCab,"CN1",1,"xFilial('CN1')+QRYCN9->CN9_TPCTO")//Tipo de Contrato
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010ApC  ³ Autor ³ Israel.Escorizza     ³ Data ³ 28.11.16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao do cabecalho de Aprovações                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oE\xp01 - Sessao do cabecalho - TRSection                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010ApC(oSectApC)
Local cTipApr := ""
Local nTamCtr := TAMSX3('CN9_NUMERO')[1]
local nTamRev := TAMSX3('CN9_REVISA')[1]
Local nDe	  := 1


If mv_par15 == 1 .And. mv_par16 == 1
	cTipApr := "CT','IC','RV','IR"
ElseIf mv_par15 == 1
	cTipApr := "CT','RV"
ElseIf mv_par16 == 1
	cTipApr := "IC','IR"
EndIf

BEGIN REPORT QUERY oSectApC
BeginSQL Alias "QRYSCR"

SELECT
	CR_NUM,
	CR_TIPO,
	CR_NIVEL,
	CR_APROV,
	CR_USER,
	CR_USERLIB,
	CR_STATUS,
	CR_DATALIB,
	R_E_C_N_O_
FROM
	%TABLE:SCR% SCR
WHERE
	(
	SCR.CR_FILIAL = %report_param:QRYCN9->CN9_FILIAL%
	OR
	SCR.CR_FILIAL = %report_param:QRYCN9->CN9_FILCTR%
	)
	AND

	SCR.CR_TIPO in (%exp:cTipApr%) AND
	(
		(SCR.CR_TIPO in ('CT','IC') AND %report_param:QRYCN9->CN9_NUMERO% = SUBSTRING(CR_NUM,%exp:nDe%,%exp:nTamCtr%) AND %report_param:QRYCN9->CN9_REVISA% = %exp:space(nTamRev)% )
		OR
		(SCR.CR_TIPO in ('RV','IR') AND SUBSTRING(CR_NUM,%Exp:nDe%,%exp:nTamCtr+nTamRev%) = %report_param:QRYCN9->(CN9_NUMERO+CN9_REVISA)% )
	) AND
	SCR.%notDel%

ORDER BY CR_NUM,CR_NIVEL,CR_DATALIB

EndSQL
END REPORT QUERY oSectApC

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Pla  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao do cabecalho de planilhas                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oE\xp01 - Sessao do cabecalho - TRSection                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Pla(oSectPla)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro das planilhas                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectPla
BeginSQL Alias "QRYCNA"

SELECT CNA_NUMERO, CNA_FORNEC, CNA_LJFORN, CNA_CRONOG, CNA_DTINI, CNA_VLTOT, CNA_SALDO, CNA_TIPPLA,
		CNA_DTFIM, CNA_FLREAJ, CNA_CONTRA, CNA_REVISA, CNA_CRONCT, CNA_CLIENT, CNA_LOJACL
FROM %Table:CNA% CNA
WHERE CNA_FILIAL = %xfilial:CNA% AND
	CNA.CNA_CONTRA = %report_param:QRYCN9->CN9_NUMERO% AND
	CNA.CNA_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CNA.%NotDel%
ORDER BY CNA_CONTRA, CNA_REVISA, CNA_NUMERO

EndSQL
END REPORT QUERY oSectPla


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura posicionamento das tabelas filhas        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSectPla,"CNL",1,"xFilial('CNL')+QRYCNA->CNA_TIPPLA")//Tipos de Tabelas

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Itm  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao dos itens de planilhas                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao dos itens - TRSection                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Itm(oSectItm)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro dos itens de planilhas        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectItm
BeginSQL Alias "QRYCNB"
SELECT CNB.CNB_ITEM, CNB.CNB_PRODUT, CNB.CNB_QUANT, CNB.CNB_VLUNIT, CNB.CNB_VLTOT, CNB.CNB_VLTOT, CNB.CNB_DESC,
	CNB.CNB_VLDESC, CNB.CNB_QTDMED, CNB.CNB_SLDMED, CNB.CNB_CONTRA, CNB.CNB_REVISA, CNB.CNB_NUMERO
FROM %Table:CNB% CNB
WHERE CNB.CNB_FILIAL = %xFilial:CNB% AND
	CNB.CNB_CONTRA = %report_param:QRYCN9->CN9_NUMERO% AND
	CNB.CNB_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CNB.CNB_NUMERO = %report_param:QRYCNA->CNA_NUMERO% AND
	CNB.%NotDel%
ORDER BY CNB.CNB_CONTRA, CNB.CNB_REVISA, CNB.CNB_NUMERO, CNB.CNB_ITEM

EndSQL
END REPORT QUERY oSectItm

Return


//--------------------------------------------------------------------------------------------------------------
User Function CR010Agr(oSectAgr)

//- Gera query de filtro dos itens de planilhas        ³
BEGIN REPORT QUERY oSectAgr
BeginSQL Alias "QRYCXM"

SELECT CXM.CXM_CONTRA,
		CXM.CXM_REVISA,
		CXM.CXM_NUMERO,
		CXM.CXM_ITEMID,
		CXM.CXM_AGRTIP,
		CXM.CXM_AGRGRP,
		CXM.CXM_AGRCAT,
		CXM.CXM_VLMAX,
		CXM.CXM_VLMED

FROM 	%Table:CXM% CXM

WHERE 	CXM.CXM_FILIAL = %xFilial:CXM% 							AND
		CXM.CXM_CONTRA = %report_param:QRYCN9->CN9_NUMERO% 	AND
		CXM.CXM_REVISA = %report_param:QRYCN9->CN9_REVISA% 	AND
		CXM.CXM_NUMERO = %report_param:QRYCNA->CNA_NUMERO% 	AND
		CXM.%NotDel%

ORDER BY CXM.CXM_CONTRA, CXM.CXM_REVISA, CXM.CXM_NUMERO, CXM.CXM_ITEMID

EndSQL
END REPORT QUERY oSectAgr

Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Cro  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao dos cronogramas                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao dos cronogramas - TRSection                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Cro(oSectCro)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro dos cronogramas               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectCro
BeginSQL Alias "QRYCNF"

SELECT CNF.*
FROM %Table:CNF% CNF
WHERE CNF.CNF_FILIAL = %xFilial:CNF% AND
	CNF.CNF_CONTRA = %report_param:QRYCN9->CN9_NUMERO% AND
	CNF.CNF_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CNF.CNF_NUMERO = %report_param:QRYCNA->CNA_CRONOG% AND
	CNF.%NotDel%
ORDER BY CNF.CNF_CONTRA, CNF.CNF_REVISA, CNF.CNF_NUMERO, CNF.CNF_PARCEL

EndSQL
END REPORT QUERY oSectCro

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Cac  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao das caucoes                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao das caucoes  - TRSection                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Cac(oSectCac)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro das caucoes                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectCac
BeginSQL Alias "QRYCN8"

SELECT CN8.*
FROM %Table:CN8% CN8
WHERE CN8.CN8_FILIAL = %xFilial:CN8% AND
	CN8.CN8_CONTRA = %report_param:QRYCN9->CN9_NUMERO% AND
	CN8.CN8_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CN8.%NotDel%
ORDER BY CN8.CN8_CONTRA, CN8.CN8_REVISA, CN8.CN8_CODIGO

EndSQL
END REPORT QUERY oSectCac

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Frn  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao dos fornecedores de contratos             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao dos fornecedores - TRSection               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Frn(oSectFrn)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro dos fornecedores              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectFrn
BeginSQL Alias "QRYCNC"

SELECT CNC.CNC_NUMERO,CNC.CNC_REVISA,CNC.CNC_CODIGO,CNC.CNC_LOJA
FROM %Table:CNC% CNC
WHERE CNC.CNC_FILIAL = %xFilial:CNC% AND
	CNC.CNC_NUMERO = %report_param:QRYCN9->CN9_NUMERO% AND
	CNC.CNC_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CNC.%NotDel%
ORDER BY CNC.CNC_NUMERO, CNC.CNC_REVISA, CNC.CNC_CODIGO, CNC.CNC_LOJA

EndSQL
END REPORT QUERY oSectFrn

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura posicionamento das tabelas filhas        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSectFrn,"SA2",1,"xFilial('SA2')+QRYCNC->(CNC_CODIGO+CNC_LOJA)")//Fornecedores

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Cli  ³ Autor ³ Felipe Bittar         ³ Data ³ 05.03.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao do cliente do contrato                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao dos clientes - TRSection                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Cli(oSectCli)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro dos clientes	               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectCli

BeginSQL Alias "QRYCLI"

SELECT CNC.CNC_NUMERO, CNC.CNC_REVISA, CNC.CNC_CLIENT, CNC.CNC_LOJACL
FROM %Table:CNC% CNC
WHERE CNC.CNC_FILIAL = %xFilial:CNC% AND
	CNC.CNC_NUMERO = %report_param:QRYCN9->CN9_NUMERO% AND
	CNC.CNC_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CNC.%NotDel%
ORDER BY CNC_NUMERO, CNC_REVISA, CNC_CLIENT, CNC_LOJACL

EndSQL
END REPORT QUERY oSectCli

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura posicionamento das tabelas filhas        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSectCli,"SA1",1,"xFilial('SA1')+QRYCLI->(CNC_CLIENT+CNC_LOJACL)")//Cliente

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Mul  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao das multas de contratos                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao dos multas - TRSection                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Mul(oSectMul)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro das multas                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectMul
BeginSQL Alias "QRYCNH"

SELECT CNH.*
FROM %Table:CNH% CNH
WHERE CNH_FILIAL = %xFilial:CNH% AND
	CNH.CNH_NUMERO = %report_param:QRYCN9->CN9_NUMERO% AND
	CNH.CNH_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CNH.%NotDel%
ORDER BY CNH_NUMERO, CNH_CODIGO

EndSQL
END REPORT QUERY oSectMul

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura posicionamento das tabelas filhas        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSectMul,"CN4",1,"xFilial() + QRYCNH->CNH_CODIGO")//Tipos de Multas

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Med  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao dos cabecalhos de medicao                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao do cabecalho de medicao - TRSection        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Med(oSectMed)
Local cExpWhere := "%"

cExpWhere += "CND.CND_FILCTR = %report_param:QRYCN9->CN9_FILCTR% AND%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro das medicoes                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectMed
BeginSQL Alias "QRYCND"

SELECT CND.CND_FILIAL, CND.CND_NUMMED, CND.CND_NUMERO, CND.CND_CONTRA, CND.CND_REVISA, CND.CND_FORNEC, CND.CND_LJFORN,
	CND.CND_COMPET, CND.CND_DTVENC, CND.CND_VLMEAC, CND.CND_VLSALD, CND.CND_VLTOT
FROM %Table:CND% CND
WHERE %Exp:cExpWhere%
	CND.CND_CONTRA = %report_param:QRYCN9->CN9_NUMERO% AND
	CND.CND_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CND.%NotDel%
ORDER BY CND.CND_CONTRA, CND.CND_REVISA, CND.CND_NUMMED

EndSQL
END REPORT QUERY oSectMed

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010IMe  ³ Autor ³ Marcelo Custodio      ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao dos itens de medicoes                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao dos itens de medicoes - TRSection          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010IMe(oSectIMe)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro dos itens de medicoes         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectIMe
BeginSQL Alias "QRYCNE"

SELECT CNE.CNE_ITEM, CNE.CNE_CONTRA, CNE.CNE_REVISA, CNE.CNE_NUMMED, CNE.CNE_PRODUT, CNE.CNE_QTDSOL,
	 CNE.CNE_QTAMED, CNE.CNE_QUANT, CNE.CNE_PERC, CNE.CNE_VLUNIT, CNE.CNE_VLTOT
FROM %Table:CNE% CNE
WHERE CNE.CNE_FILIAL = %report_param:QRYCND->CND_FILIAL% AND
	CNE.CNE_CONTRA = %report_param:QRYCN9->CN9_NUMERO% AND
	CNE.CNE_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CNE.CNE_NUMMED = %report_param:QRYCND->CND_NUMMED% AND
	CNE.%NotDel%
ORDER BY CNE_CONTRA,CNE_REVISA,CNE_NUMMED,CNE_ITEM

EndSQL
END REPORT QUERY oSectIMe

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Ctb  ³ Autor ³ Marcelo Custodio      ³ Data ³ 27.02.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao dos cronogramas contabeis                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao dos cronogramas contabeis - TRSection      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Ctb(oSectCtb)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro dos cronogramas               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectCtb
BeginSQL Alias "QRYCNW"

SELECT CNW.*
FROM %Table:CNW% CNW
WHERE CNW.CNW_FILIAL = %xFilial:CNW% AND
	CNW.CNW_CONTRA = %report_param:QRYCN9->CN9_NUMERO% AND
	CNW.CNW_REVISA = %report_param:QRYCN9->CN9_REVISA% AND
	CNW.CNW_NUMERO = %report_param:QRYCNA->CNA_CRONCT% AND
	CNW.%NotDel%
ORDER BY CNW.CNW_CONTRA, CNW.CNW_REVISA, CNW.CNW_NUMERO, CNW.CNW_PARCEL

EndSQL
END REPORT QUERY oSectCtb

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Des  ³ Autor ³ Felipe Bittar         ³ Data ³ 14.08.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao de multas/bonificacoes de medicoes        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao de multas/bonific de medicoes - TRSection  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Bon(oSectBon)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro das bonificacoes de medicoes  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectBon
BeginSQL Alias "QRYCNR"

SELECT CNR.CNR_NUMMED, CNR.CNR_TIPO, CNR.CNR_DESCRI, CNR.CNR_VALOR
FROM %Table:CNR% CNR
WHERE CNR.CNR_FILIAL = %report_param:QRYCND->CND_FILIAL% AND
	CNR.CNR_NUMMED = %report_param:QRYCND->CND_NUMMED% AND
	CNR.%NotDel%
ORDER BY CNR.CNR_NUMMED, CNR.CNR_TIPO

EndSQL
END REPORT QUERY oSectBon

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³CR010Des  ³ Autor ³ Felipe Bittar         ³ Data ³ 14.08.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Configura sessao dos descontos de medicoes                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CNTR010Imp                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oExp01 - Sessao de descontos de medicoes - TRSection       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CR010Des(oSectDes)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera query de filtro dos descontos de medicoes     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSectDes
BeginSQL Alias "QRYCNQ"

SELECT CNQ.CNQ_NUMMED, CNQ.CNQ_TPDESC, CNQ.CNQ_VALOR, CNP.CNP_DESCRI
FROM %Table:CNQ% CNQ
JOIN %Table:CNP% CNP ON
	CNP.CNP_FILIAL = %xFilial:CNP% AND
	CNP.%NotDel% AND
	CNP.CNP_CODIGO = CNQ.CNQ_TPDESC
WHERE CNQ.CNQ_FILIAL = %report_param:QRYCND->CND_FILIAL% AND
	CNQ.CNQ_NUMMED = %report_param:QRYCND->CND_NUMMED% AND
	CNQ.%NotDel%
ORDER BY CNQ.CNQ_NUMMED, CNQ.CNQ_TPDESC

EndSQL
END REPORT QUERY oSectDes

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CNR010ClFr³ Autor ³ Aline Sebrian         ³ Data ³ 04.01.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Valida os parametro do Cliente e Fornecedor no relatorio.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_CNR010ClFr()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³U_CNR010ClFr()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CNR010ClFr(cCnr,cTipo)
Local aSaveArea	:= GetArea()

If cCnr=="CNR010"
	If cTipo=="1"
		If !Empty(mv_par09) .Or. (!Empty(mv_par10) .And. UPPER(mv_par10) != REPLICATE("Z",TamSx3("CNC_CODIGO")[1]))
			mv_par23	:= Space(6)
			mv_par24	:= REPLICATE("Z",TamSx3("A1_COD")[1])
		EndIf
	Else
		If !Empty(mv_par23) .Or. (!Empty(mv_par24) .And. UPPER(mv_par24) != REPLICATE("Z",TamSx3("A1_COD")[1]))
			MV_PAR09	:= Space(6)
			MV_PAR10	:= REPLICATE("Z",TamSx3("CNC_CODIGO")[1])
		EndIf
	EndIf
Else
	If cTipo=="1"
		If !Empty(MV_PAR06)
			MV_PAR10	:= Space(6)
		EndIf
	Else
		If !Empty(MV_PAR10)
			MV_PAR06	:= Space(6)
		EndIf
	EndIf
EndIf

RestArea(aSaveArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³C010xMoedaºAutor  ³Microsiga           º Data ³  11/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Realiza a conversao entre moedas de um determinado valor.  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ lTReport: indica se a impressao e em TReport.			  º±±
±±º			 ³ cContra: numero do contrato que esta sendo impresso.		  º±±
±±º			 ³ cRev: revisao do contrato que esta sendo impresso.		  º±±
±±º			 ³ cCampo: nome do campo a ser convertido.					  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno	 ³ nRet: valor apos conversao								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CNTR010													  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function C010xMoeda(lTReport,cContra,cRev,cCampo)
Local dDataRef  := If(lTReport,mv_par13,mv_par27)
Local nMoedaOri	:= 0
Local nMoedaDes := 0
Local nRet 		:= 0

If "CNTR020" $ FunName()
	//-- Impressao da planilha e itens da planilha no CNTR020
	nRet := C020xMoeda(lTReport,cContra,cRev,cCampo)
Else
	If Empty(dDataRef)
		dDataRef := dDataBase
	EndIf
	nMoedaOri := If(Substr(cCampo,1,3) == "CN8",CN8_MOEDA,Posicione("CN9",1,xFilial("CN9")+cContra+cRev,"CN9_MOEDA"))
	nMoedaDes := nMoedaOri
	nRet	  := &(cCampo)

	If lTReport
		If mv_par11 == 2
			nMoedaDes := mv_par12
		EndIf
	ElseIf mv_par25 == 2
		nMoedaDes := mv_par26
	EndIf

	nRet := Round(xMoeda(nRet,nMoedaOri,nMoedaDes,dDataRef,6),TamSX3(cCampo)[2])
EndIf

Return nRet

//- Função para retornar Memo da SCR
User Function C010GtMemo(nRecno)
Local aAreaSCR:= SCR->(GetArea())
Local cRet 	:= ""
SCR->(MsGoto(nRecno))
cRet := AllTrim(SCR->CR_OBS)
RestArea(aAreaSCR)
Return cRet

