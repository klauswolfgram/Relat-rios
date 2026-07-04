/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#include "MSGRAPHI.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FWCOMMAND.CH"
#INCLUDE "FWBROWSE.CH"
#INCLUDE "CTBR811.CH"

/*{Protheus.doc} CTBR811
Relatório do Livro Diário - chamada do Pergunte

@author Wilson.Possani
@since 18/04/2014
@version P120
*/
User Function CTBR811()
	
	Local lContinua := .T.
	
	Private aMod		:= {}
	Private Titulo		:= STR0001 //"Livro Sub-Diário"
	Private NomeProg	:= "CTBR811"
	Private cPerg		:= "CTBR811"

	aMod := U_C811Mark(.T.)
	lContinua := IIf(Len(aMod) <> 0, .T., .F.)

	If lContinua
		lContinua := Pergunte(cPerg, .T.)
	EndIf 

	If lContinua .And. MV_PAR02 < MV_PAR01
		Help(" ", 1, "LANCINV", , STR0002, 1, 0)  //"Digite- Lançamento Inicial Menor que o Final !"
		lContinua := .F.
	EndIf

	If lContinua .And. MV_PAR04 < MV_PAR03
		Help(" ", 1, "DATAINV", , STR0003, 1, 0)  //"Digite- Grupo Inicial Menor que Final !"
		lContinua := .F.
	EndIf

	If lContinua .And. MV_PAR06 < MV_PAR05
		Help(" ", 1, "DATAINV", , STR0004, 1, 0)  //"Digite Data Inicial Menor que a Data Final !"
		lContinua := .F.
	EndIf

	If lContinua
		oReport := CTBR811B()
		oReport:PrintDialog()

		CTBR811B()
	EndIf

Return

/*{Protheus.doc} CTBR811B
Monta as Celulas

@author Wilson.Possani
@since 18/04/2014
@version P120

*/
Static Function CTBR811B()
	
	Local cReport	:= "CTBR811"
	Local cTitulo	:= Titulo
	Local cDesc		:= STR0005 //"Este programa imprime o livro sub-diario"
	Local aTamConta	:= TAMSX3("CT1_CONTA")
	Local aTamDesc	:= TAMSX3("CT1_DESC01")
	Local cQry1		:= ""
	Local oReport	
	Local oSection1	
	Local oSection2	
	Local oSection3	
	Local oSection4	

	oReport	:= TReport():New(cReport, cTitulo, cPerg, {|oReport| CTBR811C(oReport, oSection1, oSection2, oSection3, oSection4)}, cDesc)
	oReport:SetLandScape()
	oReport:SetTotalInLine(.F.)

	Pergunte(oReport:uParam, .F.)

	oReport:nFontBody := 6

	oSection1 := TRSection():New(oReport, STR0006, {}, , ,) //"Seção1"
	oSection1:SetTotalInLine(.F.)
	oSection1:SetAutoSize(.F.)
	oReport:Section(1):SetHeaderPage()

	oSection2 := TRSection():New(oReport, STR0007, {}, , ,) //"Seção2"
	oSection2:SetTotalInLine(.F.)
	oSection2:SetAutoSize(.F.)
	oReport:Section(2):SetHeaderPage()

	oSection3 := TRSection():New(oReport, STR0008, {}, , ,)//"Seção3"
	oSection3:SetTotalInLine(.F.)
	oSection3:SetAutoSize(.F.)
	oReport:Section(3):SetHeaderPage()

	oSection4 := TRSection():New(oReport, STR0009, {}, , ,)//"Seção4"
	oSection4:SetTotalInLine(.F.)
	oSection4:SetAutoSize(.F.)
	oReport:Section(4):SetHeaderPage()
	
Return oReport

/*{Protheus.doc} CTBR811C(oReport, oSection1, oSection2, oSection3, oSection4)
Relatório do Livro Diário 

@author Wilson.Possani
@since 18/04/2014
@version P120
*/
Static Function CTBR811C(oReport, oSection1, oSection2, oSection3, oSection4)

	Local nTamLote	:= TAMSX3("CT2_LOTE")[1]
	Local nTamSLot	:= TAMSX3("CT2_SBLOTE")[1]
	Local nTamDoc	:= TAMSX3("CT2_DOC")[1]
	Local nTamCont	:= TAMSX3("CT1_CONTA")[1]
	Local nTamVlr	:= TAMSX3("CT2_VALOR")[1]
	Local nTamAsi	:= TAMSX3("CT2_LANC")[1]
	Local nTamFec	:= 10
	Local nTamTip	:= TAMSX3("F2_TIPO")[1]
	Local nTamSer	:= SerieNfId('SF2',6,'F2_SERIE')	//TAMSX3("F2_SERIE")[1]
	Local nTamCom	:= TAMSX3("F2_DOC")[1]
	Local nTamCli	:= TAMSX3("A1_COD")[1]
	Local nTamRaz	:= TAMSX3("A1_NOME")[1]
	Local cQry		:= ""
	Local cQry1		:= ""
	Local cQry2		:= ""
	Local cChave	:= ""
	Local cChav		:= ""
	Local cComp		:= ""
	Local cSer		:= ""
	Local cTipo		:= ""
	Local cCliPro	:= ""
	Local cRazSoc	:= ""
	Local cConta	:= ""
	Local cLanc		:= ""
	Local nVlrCrd	:= 0
	Local nVlrDeb	:= 0
	Local nTotCrd	:= 0
	Local nTotDeb	:= 0
	Local nModCrd	:= 0
	Local nModDeb	:= 0
	Local nGerCrd	:= 0
	Local nGerDeb	:= 0
	Local dFecha	:= CTOD("//")
	Local nCont		:= 0
	Local nX		:= 0
	Local nZ		:= 0
	Local aCompr	:= {}
	Local cTab		:= ""

	DEFAULT aMod	:= {}

	aCompr := {	{"02", "SF1",    "SF1->F1_DOC"		, "SF1->F1_SERIE"	, "SF1->F1_TIPO", "SA2", "SF1->F1_FORNECE", "A2_NOME", "SF1->F1_EMISSAO", "SF1->F1_LOJA"},;
				{"02", "SD1",    "SD1->D1_DOC"		, "SD1->D1_SERIE"	, "SD1->D1_TIPO", "SA2", "SD1->D1_FORNECE", "A2_NOME", "SD1->D1_EMISSAO", "SD1->D1_LOJA"},;
				{"02", "SF2",    "SF2->F2_DOC"		, "SF2->F2_SERIE"	, "SF2->F2_TIPO", "SA1", "SF2->F2_CLIENTE", "A1_NOME", "SF2->F2_EMISSAO", "SF2->F2_LOJA"},;
				{"02", "SD2",    "SD2->D2_DOC"		, "SD2->D2_SERIE"	, "SD2->D2_TIPO", "SA1", "SD2->D2_CLIENTE", "A1_NOME", "SD2->D2_EMISSAO", "SD2->F2_LOJA"},;
				{"06", "SE1",    "SE1->E1_NUM"		, "SE1->E1_PREFIXO"	, "SE1->E1_TIPO", "SA1", "SE1->E1_CLIENTE", "A1_NOME", "SE1->E1_EMISSAO", "SE1->E1_LOJA"},;
				{"06", "SE2",    "SE2->E2_NUM"		, "SE2->E2_PREFIXO"	, "SE2->E2_TIPO", "SA2", "SE2->E2_FORNECE", "A2_NOME", "SE2->E2_EMISSAO", "SE2->E2_LOJA"},;
				{"06", "SE5",    "SE5->E5_NUMERO"	, "SE5->E5_PREFIXO"	, "SE5->E5_TIPO",    "",                "",        "", "SE5->E5_DATA"   , ""            },;
				{"06", "SEF",    "SEF->EF_NUM"		, "SEF->EF_PREFIXO"	, "SEF->EF_TIPO",    "",                "",        "", "SEF->EF_DATA"   , ""            },;
				{"01", "SN3",    "SN3->N3_CBASE"	, "SN3->N3_ITEM"	, "SN3->N3_TIPO",    "",                "",        "", "SN3->N3_AQUISIC", ""            },;
				{"04", "SD3",    "SD3->D3_TM"		, "SD3->D3_DOC"		, "SD3->D3_QUANT",  "",                "",        "", "SD3->D3_EMISSAO", ""            },;
				{"07", "SRZ",    "SRZ->RZ_PD"		, "SRZ->RZ_OCORREN"	, "SRZ->RZ_TIPO",    "",                "",        "", ""               , ""            }}

	//Celulas Impressão
	TRCell():New(oSection1, "CUENTA"  , , STR0010  , , nTamCont, , {|| (cTabQry)->CWT_CONTA}            , "LEFT", ,   "LEFT")//"Conta"
	TRCell():New(oSection1, "LOTE"    , , STR0011  , , nTamLote, , {|| (cTabQry)->CWT_LOTE  }            , "LEFT", ,   "LEFT")//"Lote"
	TRCell():New(oSection1, "SUBLOTE" , , STR0012  , , nTamSLot, , {|| (cTabQry)->CWT_SUBLOT}            , "LEFT", ,   "LEFT")//"SLot"   
	TRCell():New(oSection1, "DOCTO"   , , STR0013  , ,  nTamDoc, , {|| (cTabQry)->CWT_DOC   }            , "LEFT", ,   "LEFT")//"Doc.  "
	TRCell():New(oSection1, "FECHACTB", , STR0014 , ,  nTamFec, , {|| DTOC(STOD((cTabQry1)->CT2_DATA))} , "LEFT", ,   "LEFT")//"Dt. Ctb."
	TRCell():New(oSection1, "ASIENTO" , , STR0015  , ,  nTamAsi, , {|| (cTabQry)->CWT_LANC}            , "LEFT", ,   "LEFT")//"Lançamento"
	TRCell():New(oSection1, "FECHA"   , , STR0016  , ,  nTamFec, , {|| DTOC(STOD((cTabQry)->CWS_DTLANC))}, "LEFT", ,   "LEFT")//"Dt.Lanc."
	//Compras / Financeiro
	TRCell():New(oSection1, "F1TIPO"  , , STR0017  , ,  nTamTip, , {|| cTipo          }            , "LEFT", ,   "LEFT")//"Tip"
	TRCell():New(oSection1, "F1SERIE" , , STR0018  , ,  nTamSer, , {|| cSer           }            , "LEFT", ,   "LEFT")//"Ser."
	TRCell():New(oSection1, "F1NUMERO", , STR0019  , ,  nTamCom, , {|| cComp          }            , "LEFT", ,   "LEFT")//"Comprovante "
	//Ativo
	TRCell():New(oSection1, "N3CBASE" , , STR0020 , ,  nTamTip, , {|| cTipo          }            , "LEFT", ,   "LEFT")//"Codigo Base"
	TRCell():New(oSection1, "N3ITEM"  , , STR0021 , ,  nTamSer, , {|| cSer           }            , "LEFT", ,   "LEFT")//"Item."
	TRCell():New(oSection1, "N3TIPO"  , , STR0022 , ,  nTamCom, , {|| cComp          }            , "LEFT", ,   "LEFT")//"Tipo"
	//Estoque/Custos
	TRCell():New(oSection1, "D3TM"    , , STR0023 , ,  nTamTip, , {|| cTipo          }            , "LEFT", ,   "LEFT")//"Tm"
	TRCell():New(oSection1, "D3DOC"   , , STR0024 , ,  nTamSer, , {|| cSer           }            , "LEFT", ,   "LEFT")//"Documento"
	TRCell():New(oSection1, "D3QUANT" , , STR0025 , ,  nTamCom, , {|| cComp          }            , "LEFT", ,   "LEFT")//"Quantid."
	//Gestão Pessoal
	TRCell():New(oSection1, "RZPD"    , , STR0017 , ,  nTamTip, , {|| cTipo          }            , "LEFT", ,   "LEFT")//"Tip "
	TRCell():New(oSection1, "RZOCORR" , , STR0026 , ,  nTamSer, , {|| cSer           }            , "LEFT", ,   "LEFT")//"Ocorrencia"
	TRCell():New(oSection1, "RZTIPOCO", , STR0027 , ,  nTamCom, , {|| cComp          }            , "LEFT", ,   "LEFT")//"Tipo Ocorr."
	// o Resto
	TRCell():New(oSection1, "FECHAEMI", , STR0028 , ,  nTamFec, , {|| Iif(dFecha!= Nil, DTOC(dFecha),"") }, "LEFT", ,   "LEFT")//"Emissão "
	TRCell():New(oSection1, "CLIPRO"  , , STR0029 , ,  nTamCli, , {|| cCliPro        }            , "LEFT", ,   "LEFT")//"For/Cli"
	TRCell():New(oSection1, "RAZSOC"  , , STR0030 , ,  nTamRaz, , {|| cRazSoc        }            , "LEFT", ,   "LEFT")//"Razão Social"
	TRCell():New(oSection1, "VLRDEB"  , , STR0031 , ,  nTamVlr, , {||  nVlrDeb       }            ,"RIGHT", ,  "RIGHT")//"Vlr. Debito"
	TRCell():New(oSection1, "VLRCRD"  , , STR0032 , ,  nTamVlr, , {||  nVlrCrd     }            ,"RIGHT", ,  "RIGHT")//"Vlr. Credito"

	//Totais da Conta
	TRCell():New(oSection2, "CUENTA"  , , "", , nTamCont, ,             ,  "LEFT", , "LEFT")
	TRCell():New(oSection2, "LOTE"    , , "", , nTamLote, ,             ,  "LEFT", , "LEFT")
	TRCell():New(oSection2, "SUBLOTE" , , "", , nTamSLot, ,             ,  "LEFT", , "LEFT")
	TRCell():New(oSection2, "DOCTO"   , , "", ,  nTamDoc, ,             ,  "LEFT", , "LEFT")
	TRCell():New(oSection2, "FECHACTB", , "", ,  nTamFec, ,             ,  "LEFT", , "LEFT")
	TRCell():New(oSection2, "ASIENTO" , , "", ,  nTamAsi, ,             ,  "LEFT", , "LEFT")
	TRCell():New(oSection2, "FECHA"   , , "", ,  nTamFec, ,             ,  "LEFT", , "LEFT")
	//Compras / Financeiro
	TRCell():New(oSection2, "F1TIPO"  , , "", ,  nTamTip, ,            , "LEFT", ,   "LEFT")
	TRCell():New(oSection2, "F1SERIE" , , "", ,  nTamSer, ,             , "LEFT", ,   "LEFT")
	TRCell():New(oSection2, "F1NUMERO", , "", ,  nTamCom, ,            , "LEFT", ,   "LEFT")
	//Ativo
	TRCell():New(oSection2, "N3CBASE" , , "" , ,  nTamTip, ,             , "LEFT", ,   "LEFT")
	TRCell():New(oSection2, "N3ITEM"  , , "" , ,  nTamSer, ,            , "LEFT", ,   "LEFT")
	TRCell():New(oSection2, "N3TIPO"  , , "", ,  nTamCom, ,           , "LEFT", ,   "LEFT")
	//Estoque/Custos
	TRCell():New(oSection2, "D3TM"    , , "", ,  nTamTip, ,             , "LEFT", ,   "LEFT")
	TRCell():New(oSection2, "D3DOC"   , , "" , ,  nTamSer, ,             , "LEFT", ,   "LEFT")
	TRCell():New(oSection2, "D3QUANT" , , "", ,  nTamCom+8, ,            , "LEFT", ,   "LEFT")
	//Gestão Pessoal
	TRCell():New(oSection2, "RZPD"     , , "", ,  nTamTip, ,            , "LEFT", ,   "LEFT")
	TRCell():New(oSection2, "RZOCORR" , , "" , ,  nTamSer, ,             , "LEFT", ,   "LEFT")
	TRCell():New(oSection2, "RZTIPOCO" , , "", ,  nTamCom, ,             , "LEFT", ,   "LEFT")
	// o Resto
	TRCell():New(oSection2, "FECHAEMI", , "", ,  nTamFec, , {|| STR0033}              ,  "LEFT", , "LEFT")//"Tot.Lancto:"
	TRCell():New(oSection2, "CLIPRO"  , , "", ,  nTamCli, ,             ,  "LEFT", , "LEFT")
	TRCell():New(oSection2, "RAZSOC"  , , "", ,  nTamRaz+8, ,             ,  "LEFT", , "LEFT")
	TRCell():New(oSection2, "TOTDEB"  , , "", ,  nTamVlr, , {|| TransForm(ntotDeb, "@E 999,999,999,999.99") },   "RIGHT", ,  "RIGHT")
	TRCell():New(oSection2, "TOTCRD"  , , "", ,  nTamVlr, , {|| TransForm(nTotCrd, "@E 999,999,999,999.99") },   "RIGHT", ,  "RIGHT")

	//Totais Modulo
	TRCell():New(oSection3, "CUENTA"  , , "", , nTamCont, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection3, "LOTE"    , , "", , nTamLote, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection3, "SUBLOTE" , , "", , nTamSLot, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection3, "DOCTO"   , , "", ,  nTamDoc, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection3, "FECHACTB", , "", ,  nTamFec, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection3, "ASIENTO" , , "", ,  nTamAsi, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection3, "FECHA"   , , "", ,  nTamFec, ,                                                 ,  "CENTER", , "CENTER")
	//Compras / Financeiro
	TRCell():New(oSection3, "F1TIPO"    , , "", ,  nTamTip, ,                                                , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "F1SERIE"   , , "", ,  nTamSer, ,                                                , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "F1NUMERO"  , , "", ,  nTamCom, ,                                                , "LEFT", ,   "LEFT")
	//Ativo
	TRCell():New(oSection3, "N3CBASE" , , "" , ,  nTamTip, ,                                                  , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "N3ITEM"   , , "", ,  nTamSer, ,                                                  , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "N3TIPO"  , , "", ,  nTamCom, ,                                                   , "LEFT", ,   "LEFT")
	//Estoque/Custos
	TRCell():New(oSection3, "D3TM"     , , "" , ,  nTamTip, ,                                                  , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "D3DOC"   , , "" , ,  nTamSer, ,                                                   , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "D3QUANT"  , , "", ,  nTamCom+8, ,                                                , "LEFT", ,   "LEFT")
	//Gestão Pessoal
	TRCell():New(oSection3, "RZPD"    , , "" , ,  nTamTip, ,                                                   , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "RZOCORR"   , , "" , ,  nTamSer, ,                                                 , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "RZTIPOCO"  , , "", ,  nTamCom, ,                                                  , "LEFT", ,   "LEFT")
	//o Resto
	TRCell():New(oSection3, "FECHAEMI", , "", ,  nTamFec, , {||  STR0034  }                                  ,  "RIGHT", , "RIGHT")//"Tot.Modulo:"
	TRCell():New(oSection3, "CLIPRO"  , , "", ,  nTamCli, ,                                                    ,  "CENTER", , "CENTER")
	TRCell():New(oSection3, "RAZSOC"  , , "", ,  nTamRaz+8, ,                                                  ,  "LEFT", , "LEFT")
	TRCell():New(oSection3, "TOTDEB"  , , "", ,  nTamVlr, , {||  TransForm(nModDeb, "@E 999,999,999,999.99")},   "RIGHT", ,  "RIGHT")
	TRCell():New(oSection3, "TOTCRD"  , , "", ,  nTamVlr, , {|| TransForm(nModCrd, "@E 999,999,999,999.99")},   "RIGHT", ,  "RIGHT")	

	//Totais Geral
	TRCell():New(oSection4, "CUENTA"  , , "", , nTamCont, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection4, "LOTE"    , , "", , nTamLote, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection4, "SUBLOTE" , , "", , nTamSLot, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection4, "DOCTO"   , , "", ,  nTamDoc, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection4, "FECHACTB", , "", ,  nTamFec, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection4, "ASIENTO" , , "", ,  nTamAsi, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection4, "FECHA"   , , "", ,  nTamFec, ,                                                 ,  "CENTER", , "CENTER")
	//Compras / Financeiro
	TRCell():New(oSection4, "F1TIPO"    , , "" , ,  nTamTip, ,                                                  , "CENTER", ,   "CENTER")
	TRCell():New(oSection4, "F1SERIE"   , , "" , ,  nTamSer, ,                                                  , "CENTER", ,   "CENTER")
	TRCell():New(oSection4, "F1NUMERO"  , , "", ,  nTamCom, ,                                                   , "CENTER", ,   "CENTER")
	//Ativo
	TRCell():New(oSection4, "N3CBASE" , , "" , ,  nTamTip, ,                                                  , "CENTER", ,   "CENTER")
	TRCell():New(oSection4, "N3ITEM"   , , "" , ,  nTamSer, ,                                                  , "CENTER", ,   "CENTER")
	TRCell():New(oSection4, "N3TIPO"  , , " ", ,  nTamCom, ,                                                 , "CENTER", ,   "CENTER")
	//Estoque/Custos
	TRCell():New(oSection4, "D3TM"     , , "" , ,  nTamTip, ,                                                  , "CENTER", ,   "CENTER")
	TRCell():New(oSection4, "D3DOC"   , , "" , ,  nTamSer, ,                                                 , "CENTER", ,   "CENTER")
	TRCell():New(oSection4, "D3QUANT"  , , "", ,  nTamCom+8, ,                                                  , "CENTER", ,   "CENTER")
	//Gestão Pessoal
	TRCell():New(oSection4, "RZPD"    , , ""  , ,  nTamTip, ,                                                  , "CENTER", ,   "CENTER")
	TRCell():New(oSection4, "RZOCORR"   , , "" , ,  nTamSer, ,                                                  , "CENTER", ,   "CENTER")
	TRCell():New(oSection4, "RZTIPOCO"  , , "", ,  nTamCom, ,                                                  , "CENTER", ,   "CENTER")
	//o Resto
	TRCell():New(oSection4, "FECHAEMI", , "", ,  nTamFec, ,  {|| STR0035}                             ,  "CENTER", , "CENTER")//"Tot.Geral"
	TRCell():New(oSection4, "CLIPRO"  , , "", ,  nTamCli, ,                                                 ,  "CENTER", , "CENTER")
	TRCell():New(oSection4, "RAZSOC"  , , "", ,  nTamRaz+8, ,                                               ,  "CENTER", , "CENTER")
	TRCell():New(oSection4, "TOTDEB"  , , "", ,  nTamVlr, , {|| TransForm(nGerDeb, "@E 999,999,999,999.99") },   "RIGHT", ,  "RIGHT")
	TRCell():New(oSection4, "TOTCRD"  , , "", ,  nTamVlr, , {|| TransForm(nGerCrd, "@E 999,999,999,999.99")},   "RIGHT", ,  "RIGHT")


	cTabQry := GetNextAlias()
	cQry := " SELECT CWT_LANC, CWT_LOTE, CWT_SUBLOT, CWT_DOC, CWT_CONTA, CWS_DTLANC "+CRLF
	cQry += " FROM "+RetSqlName("CWS")+" CWS "+CRLF
	cQry += " INNER JOIN "+RetSqlName("CWT")+" CWT "+CRLF
	cQry += " ON CWT_LANC = CWS_LANC "+CRLF

	If Empty(MV_PAR01) .AND. Empty(MV_PAR02)
		cQry += " WHERE CWS_GRUPO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+CRLF
	ElseIf Empty(MV_PAR03) .AND. Empty(MV_PAR04)
		cQry += " WHERE CWS_LANC BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+CRLF
	EndIf

	cQry += " AND CWS_DTLANC BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"'"+CRLF
	cQry += " AND CWS.D_E_L_E_T_ = ' ' "+CRLF
	cQry += " AND CWT.D_E_L_E_T_ = ' ' "+CRLF

	If MV_PAR08 == 1
		cQry += " ORDER BY CWT_LOTE, CWT_CONTA, CWT_LANC "+CRLF
		cChav := "(cTabQry)->CWT_LOTE+(cTabQry)->CWT_CONTA"
	Else
		cQry += " ORDER BY CWT_CONTA, CWT_LOTE, CWT_LANC "+CRLF
		cChav := "(cTabQry)->CWT_CONTA+(cTabQry)->CWT_LOTE"
	EndIf

	If Select(cTabQry)<>0
		DbSelectArea(cTabQry)
		DbCloseArea()
	EndIf

	cQry := ChangeQuery(cQry)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQrY),cTabQry,.T.,.T.)
	oReport:oPage:nPage := MV_PAR07
	For nX:=1 To Len(aMod) 
		cTab:= ""
		For nZ:=1 To Len(aCompr)
			If(aMod[nX][1]==aCompr[nZ][1])
				If !Empty(cTab)
					cTab+= ","
				EndIf
				cTab+= "'"+aCompr[nZ][2]+"'"
			EndIf
		Next nZ

		U_C811Disable(nX, oSection1, oSection2, oSection3, oSection4)

		(cTabQry)->(DbGoTop())
		Count To _nRows

		oReport:SetMeter(_nRows)
		oReport:Section(1):Init()

		//oReport:oPage:nPage := MV_PAR07
		(cTabQry)->(DbGoTop())
		cChave := &(cChav)

		While (cTabQry)->(!Eof())
			cTabQry1 := GetNextAlias()
			cQry1 := " SELECT * "+CRLF
			cQry1 += " FROM "+RetSqlName("CT2")+" CT2 "+CRLF
			cQry1 += " WHERE CT2_FILIAL = '"+xFilial("CT2")+"' "+CRLF
			cQry1 += " AND (CT2_CREDIT = '"+(cTabQry)->CWT_CONTA+"' OR CT2_DEBITO = '"+(cTabQry)->CWT_CONTA+"') "+CRLF		
			If !Empty( (cTabQry)->CWT_DOC ) .AND. !Empty( (cTabQry)->CWT_LOTE ) .AND. !Empty( (cTabQry)->CWT_SUBLOT )
				cQry1 += " AND CT2_DOC = '"+(cTabQry)->CWT_DOC+"' "+CRLF		
				cQry1 += " AND CT2_LOTE = '"+(cTabQry)->CWT_LOTE+"' "+CRLF
				cQry1 += " AND CT2_SBLOTE = '"+(cTabQry)->CWT_SUBLOT+"' "+CRLF
			Endif
			cQry1 += " AND CT2_LANC = '"+(cTabQry)->CWT_LANC+"' "+CRLF
			cQry1 += " AND CT2.D_E_L_E_T_ = ' ' "+CRLF

			If Select(cTabQry1)<>0
				(cTabQry1)->(DbCloseArea())
			EndIf

			cQry1 := ChangeQuery(cQry1)

			dbUseArea(.T., "TOPCONN", TcGenQry(, , cQry1), cTabQry1, .T., .T.)

			While (cTabQry1)->(!Eof())

				cTabQry2 := GetNextAlias()
				cQry2 := " SELECT CV3_RECORI REC, CV3_TABORI TAB "+CRLF
				cQry2 += " FROM "+RetSqlName("CV3")+" CV3 "+CRLF
				cQry2 += " WHERE CV3_SEQUEN = '"+(cTabQry1)->CT2_SEQUEN+"' "+CRLF
				cQry2 += " AND CV3_DC = '"+(cTabQry1)->CT2_DC+"' "+CRLF
				cQry2 += " AND CV3_LP = '"+(cTabQry1)->CT2_LP+"' "+CRLF
				cQry2 += " AND CV3_RECDES = "+AllTrim(Str((cTabQry1)->R_E_C_N_O_))
				cQry2 += " AND CV3_TABORI IN ("+cTab+") "+CRLF
				cQry2 += " AND CV3.D_E_L_E_T_ = ' ' "+CRLF

				If Select(cTabQry2) <> 0
					(cTabQry2)->(DbCloseArea())
				EndIf

				cQry2 := ChangeQuery(cQry2)

				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry2),cTabQry2,.T.,.T.)

				nPos := aScan(aCompr,{|x| AllTrim(x[1]) == AllTrim(aMod[nX][1])})
				If nPos > 0
					nPos := aScan(aCompr,{|x| AllTrim(x[2]) == AllTrim((cTabQry2)->TAB)})
				EndIf
				If nPos > 0 .AND. AllTrim((cTabQry2)->TAB) $ cTab
					(cTabQry2)->(DbGoTop())
					If (cTabQry2)->(!Eof()) .AND. !Empty((cTabQry2)->TAB)
						DbSelectArea((cTabQry2)->TAB)
						DbGoTo(Int(Val((cTabQry2)->REC)))
						nPos := aScan(aCompr,{|x| AllTrim(x[1]) == AllTrim(aMod[nX][1])})
						If nPos > 0
							nPos := aScan(aCompr,{|x| AllTrim(x[2]) == AllTrim((cTabQry2)->TAB)})
						EndIf
						If nPos > 0
							cComp   := &(aCompr[nPos,3])
							cSer    := &(aCompr[nPos,4])
							cTipo   := &(aCompr[nPos,5])
							dFecha  := &(aCompr[nPos,9])
							If (cTabQry2)->TAB $ "SE1|SE2|SF1|SF2"
								cCliPro := &(aCompr[nPos,7])
								cRazSoc := Posicione(aCompr[nPos,6], 1, xFilial(aCompr[nPos,6])+&(aCompr[nPos,7])+&(aCompr[nPos,10]), aCompr[nPos,8])
							ElseIf (cTabQry2)->TAB == "SE5"
								cCliPro := SE5->E5_CLIFOR
								If SE5->E5_RECPAG == "R"
									cRazSoc := Posicione("SA1", 1, xFilial("SA1")+SE5->E5_CLIFOR+SE5->E5_LOJA, "A1_NOME")
								Else
									cRazSoc := Posicione("SA2", 1, xFilial("SA2")+SE5->E5_CLIFOR+SE5->E5_LOJA, "A2_NOME")
								EndIf
							ElseIf (cTabQry2)->TAB == "SEF"
								If !Empty(SEF->EF_FORNECE)
									cCliPro := SEF->EF_FORNECE
									cRazSoc := Posicione("SA2", 1, xFilial("SA2")+SEF->EF_FORNECE+SEF->EF_LOJA, "A2_NOME")
								Else
									cCliPro := SEF->EF_CLIENTE
									cRazSoc := Posicione("SA1", 1, xFilial("SA1")+SEF->EF_CLIENTE+SEF->EF_LOJACLI, "A1_NOME")
								EndIf
							Else
								cCliPro := ""
								cRazSoc := ""
							EndIf
						Else
							cComp   := ""
							cSer    := ""
							cTipo   := ""
							cCliPro := ""
							cRazSoc := ""
							dFecha  := CTOD("//")
						EndIf
					EndIf

					If cChave == &(cChav)
						If (cTabQry)->CWT_CONTA == (cTabQry1)->CT2_CREDIT
							nVlrCrd := TransForm((cTabQry1)->CT2_VALOR, "@E 999,999,999,999.99")
							nVlrDeb := TransForm(0, "@E 999,999,999,999.99")
							nTotCrd += (cTabQry1)->CT2_VALOR
							nModCrd += (cTabQry1)->CT2_VALOR
							nGerCrd += (cTabQry1)->CT2_VALOR
						Endif
						If  (cTabQry)->CWT_CONTA == (cTabQry1)->CT2_DEBITO
							nVlrDeb := TransForm((cTabQry1)->CT2_VALOR, "@E 999,999,999,999.99")
							nVlrCrd := TransForm(0, "@E 999,999,999,999.99")
							nTotDeb += (cTabQry1)->CT2_VALOR
							nModDeb += (cTabQry1)->CT2_VALOR
							nGerDeb += (cTabQry1)->CT2_VALOR
						Endif
						oReport:Section(1):PrintLine()
					Else

						If nTotCrd <> 0 .Or. nTotDeb <> 0
							oReport:Section(2):Init()
							oReport:Section(2):PrintLine()
							oReport:Section(2):Finish()
							oReport:SkipLine()
						Endif

						nTotCrd := 0
						nTotDeb := 0


						If (cTabQry)->CWT_CONTA == (cTabQry1)->CT2_CREDIT
							nVlrCrd := TransForm((cTabQry1)->CT2_VALOR, "@E 999,999,999,999.99")
							nVlrDeb := TransForm(0, "@E 999,999,999,999.99")
							nTotCrd += (cTabQry1)->CT2_VALOR
							nModCrd += (cTabQry1)->CT2_VALOR
							nGerCrd += (cTabQry1)->CT2_VALOR
						Endif
						If (cTabQry)->CWT_CONTA == (cTabQry1)->CT2_DEBITO
							nVlrDeb := TransForm((cTabQry1)->CT2_VALOR, "@E 999,999,999,999.99")
							nVlrCrd := TransForm(0, "@E 999,999,999,999.99")
							nTotDeb += (cTabQry1)->CT2_VALOR
							nModDeb += (cTabQry1)->CT2_VALOR
							nGerDeb += (cTabQry1)->CT2_VALOR
						Endif

						oReport:Section(1):PrintLine()
						cChave := &(cChav)
					EndIf
				EndIf
				(cTabQry1)->(DbSkip())
			End

			cComp   := ""
			cSer    := ""
			cTipo   := ""
			cCliPro := ""
			cRazSoc := ""
			dFecha  := CTOD("//")

			oReport:IncMeter()

			cConta := (cTabQry)->CWT_CONTA
			cLanc :=  (cTabQry)->CWT_LANC
			While !((cTabQry)->(Eof())) .And. (cTabQry)->CWT_CONTA == cConta .And. (cTabQry)->CWT_LANC == cLanc
				(cTabQry)->(DbSkip())
			Enddo
		End
		oReport:Section(1):Finish()
		If nTotDeb <> 0 .Or. nTotCrd <> 0                                                   
			oReport:Section(2):Init()
			oReport:Section(2):PrintLine()
			oReport:Section(2):Finish()
			oReport:SkipLine()		
		Endif
		If nModCrd <> 0 .Or. nModDeb <> 0		
			oReport:Section(3):Init()
			oReport:Section(3):Cell("RAZSOC"):SetValue(AllTrim(aMod[nX][2]))
			oReport:Section(3):PrintLine()
			oReport:SkipLine()
			oReport:FatLine()
			oReport:Section(3):Finish()
		Endif		
		nTotCrd := 0
		nTotDeb := 0
		nModCrd := 0
		nModDeb := 0
	Next nX
	If nGerDeb <> 0 .Or. nGerCrd <> 0
		oReport:SkipLine()
		oReport:Section(4):Init()
		oReport:Section(4):PrintLine()
		oReport:Section(4):Finish()
	Endif
	
Return(oReport)

/*{Protheus.doc} CTBR811V
Validação parametros do agrupador

@author Wilson.Possani
@since 18/04/2014
@version P120

*/
User Function CTBR811V(nTipo)

	Local lRet    := .T.
	Default nTipo := 0

	If nTipo == 1
		If !Empty(AllTrim(MV_PAR03)) .OR. !Empty(AllTrim(MV_PAR04))
			If !Empty(MV_PAR01) .OR. !Empty(MV_PAR02)
				Help(" ",1,"NAOLANAG",,STR0037,1,0)  //"Não pode Carregar dados de lançamento quando o agrupamento está informado."
				lRet := .F.
			EndIf
		EndIf
	ElseIf nTipo == 2
		If !Empty(AllTrim(MV_PAR01)) .OR. !Empty(AllTrim(MV_PAR02))
			If !Empty(MV_PAR03) .OR. !Empty(MV_PAR04)
				Help(" ",1,"NAOAGLAN",,STR0038,1,0)  //"Não pode Carregar dados de Agrupador quando o Lançamento está informado."
				lRet := .F.
			EndIf
		EndIf
	EndIf
	
Return lRet

/*{Protheus.doc} C811Mark
MarkBrowse com os Modulos que podem ser impressos.

@author Wilson.Possani
@since 30/04/2014
@version P120

*/
User Function C811Mark(lDest)

	Local aArea		:= GetArea()
	Local aStruct	:= {}
	Local aModulo	:= {{"01",STR0039},{"02",STR0040},{"06",STR0041},{"07",STR0042},{"04",STR0043}}//"Ativo Fixo","Compras","Faturamento","Financeiro","Gestão de Pessoas","Estoque/Custos"
	Local aColumns	:= {}
	Local oDlg		:= Nil
	Local aSize		:= {}
	Local aRet		:= {}
	Local cMarca	:= ThisMark()
	Local nX		:= 0
	Local lInvert	:= ThisInv()
	Local cTexto	:= ""
	Local cEOL		:= CHR(10)+CHR(13)
	Local oMemo		:= Nil
	Local aRecSel	:= {}
	Local aOrdem	:= {}
	
	Private aMod		:= {}
	Private cMark		:= GetMark()
	Private cArqTMP		:= ""
	Private oTmpTable	:= Nil
	Private cArqTrab	:= ""

	Private oMrkBrowse := FWMarkBrowse():New()

	//Cria estrutura e tabela tmp com os campos necessarios da CTT
	Aadd(aStruct, {"OK"		, "C", 1 , 0})
	Aadd(aStruct, {"NUMMOD"	, "C", 2 , 1, 0})
	Aadd(aStruct, {"MODULO"	, "C", 50, 1, 0})
	
	aOrdem := {"OK", "NUMMOD", "MODULO"}
	
	cArqTrab := CriaTrab(Nil, .F.)
	oTmpTable := FWTemporaryTable():New(cArqTrab)
	oTmpTable:SetFields(aStruct)
	oTmpTable:AddIndex("IN1", aOrdem)
	oTmpTable:Create()

	//Preenche Tabela TMP com as informações filtradas
	For nX := 1 To Len(aModulo)
		RecLock(cArqTrab,.T.)
		(cArqTrab)->NUMMOD := aModulo[nX][1] 
		(cArqTrab)->MODULO := aModulo[nX][2] 
		MsUnlock()
		(cArqTrab)->(dbSkip())
	Next nX

	//----------------MarkBrowse----------------------------------------------------
	For nX := 1 To Len(aStruct)
		If    aStruct[nX][1] $ "MODULO"
			AAdd(aColumns,FWBrwColumn():New())
			aColumns[Len(aColumns)]:SetData( &("{||"+aStruct[nX][1]+"}") )
			aColumns[Len(aColumns)]:SetTitle(aStruct[nX][1])
			aColumns[Len(aColumns)]:SetSize(aStruct[nX][3]) 
			aColumns[Len(aColumns)]:SetDecimal(aStruct[nX][4])
			aColumns[Len(aColumns)]:SetPicture(PesqPict(cArqTrab,aStruct[nX][1])) 
		EndIf       
	Next nX 

	(cArqTrab)->(DbGoTop())
	If (cArqTrab)->(!Eof())
		DEFINE MSDIALOG oDlg TITLE STR0044 From 300,0 To 700,600 PIXEL //"Selecione os Módulos"
		oMrkBrowse:SetFieldMark("OK")
		oMrkBrowse:SetOwner(oDlg)
		oMrkBrowse:SetAlias(cArqTrab) //Seta o arquivo temporario para exibir a seleção dos dados
		oMrkBrowse:bMark := {||U_C811bMark(oMrkBrowse,cArqTrab)}
		oMrkBrowse:SetColumns(aColumns)
		oMrkBrowse:DisableReport()
		oMrkBrowse:SetMenuDef("")
		oMrkBrowse:Activate()
		ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg,{|| If(U_C811Grava(cArqTrab,aMod),(oMrkBrowse:Deactivate(), oDlg:End()), Nil)},{ ||oDlg:End()},,))

		//ACTIVATE MSDIALOG oDlg CENTERED //ON INIT EnchoiceBar(oDlg,{|| oDlg:End()},{|| oDlg:End()})
	EndIf
	
	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil
	EndIf
	
Return	(aMod)

/*{Protheus.doc}C811AllMark

Faz gravação no campo OK com a marcação.

@author Wilson Possani
@since  30/04/2014
@version 12
*/
User Function C811bMark(oMrkBrowse,cArqTrab)
	
	Local cMarca := oMrkBrowse:Mark()

	dbSelectArea(cArqTrab)
	(cArqTrab)->(DbGoTop())
	While !(cArqTrab)->(Eof())
		RecLock(cArqTrab, .F.)
		If (cArqTrab)->OK <> cMarca
			(cArqTrab)->OK := ' '
		Else
			(cArqTrab)->OK := cMarca
		EndIf
		MsUnlock()
		(cArqTrab)->(DbSkip())	
	End

	oMrkBrowse:oBrowse:Refresh(.T.)

Return .T.

/*{Protheus.doc}C811Grava

Grava em um array os Modulos Selecionados.

@author Wilson Possani
@since  30/04/2014
@version 12
*/
User Function C811Grava(cArqTrab, aMod)
	
	Local lRet		:= .T.
	Local nRecNo	:= 0

	dbSelectArea(cArqTrab)
	nRecno := (cArqTrab)->(RecNo())
	(cArqTrab)->(DbGoTop())
	While !(cArqTrab)->(Eof())
		If !Empty((cArqTrab)->OK)
			aAdd(aMod,{(cArqTrab)->NUMMOD,(cArqTrab)->MODULO})
		EndIf
		(cArqTrab)->(DbSkip())
	End

Return lRet

/*{Protheus.doc}C811Disable

Funcion utilizada para deshabilitar o habilitar campos de diferentes modulos.

@author Wilson Possani
@since  30/04/2014
@version 12
*/
User Function C811Disable(nX, oSection1, oSection2, oSection3, oSection4)

	If aMod[nX][1] $ '02|06'
		//Habilita os campos do Compras / Financeiro	
		oSection1:Cell("F1TIPO"):Enable() 
		oSection2:Cell("F1TIPO"):Enable()
		oSection3:Cell("F1TIPO"):Enable()
		oSection4:Cell("F1TIPO"):Enable()

		oSection1:Cell("F1SERIE"):Enable() 
		oSection2:Cell("F1SERIE"):Enable()
		oSection3:Cell("F1SERIE"):Enable()
		oSection4:Cell("F1SERIE"):Enable()

		oSection1:Cell("F1NUMERO"):Enable() 
		oSection2:Cell("F1NUMERO"):Enable()
		oSection3:Cell("F1NUMERO"):Enable()
		oSection4:Cell("F1NUMERO"):Enable()

		oSection1:Cell("CLIPRO"):Enable() 
		oSection2:Cell("CLIPRO"):Enable()
		oSection3:Cell("CLIPRO"):Enable()
		oSection4:Cell("CLIPRO"):Enable()

		oSection1:Cell("RAZSOC"):Enable() 
		oSection2:Cell("RAZSOC"):Enable()
		oSection3:Cell("RAZSOC"):Enable()
		oSection4:Cell("RAZSOC"):Enable()

		//Desabilita os Campos dos outros Módulos
		oSection1:Cell("N3CBASE"):Disable() 
		oSection2:Cell("N3CBASE"):Disable()
		oSection3:Cell("N3CBASE"):Disable()
		oSection4:Cell("N3CBASE"):Disable()

		oSection1:Cell("N3ITEM"):Disable() 
		oSection2:Cell("N3ITEM"):Disable()
		oSection3:Cell("N3ITEM"):Disable()
		oSection4:Cell("N3ITEM"):Disable()

		oSection1:Cell("N3TIPO"):Disable() 
		oSection2:Cell("N3TIPO"):Disable()
		oSection3:Cell("N3TIPO"):Disable()
		oSection4:Cell("N3TIPO"):Disable()

		oSection1:Cell("D3TM"):Disable() 
		oSection2:Cell("D3TM"):Disable()
		oSection3:Cell("D3TM"):Disable()
		oSection4:Cell("D3TM"):Disable()

		oSection1:Cell("D3DOC"):Disable() 
		oSection2:Cell("D3DOC"):Disable()
		oSection3:Cell("D3DOC"):Disable()
		oSection4:Cell("D3DOC"):Disable()

		oSection1:Cell("D3QUANT"):Disable() 
		oSection2:Cell("D3QUANT"):Disable()
		oSection3:Cell("D3QUANT"):Disable()
		oSection4:Cell("D3QUANT"):Disable()

		oSection1:Cell("RZPD"):Disable() 
		oSection2:Cell("RZPD"):Disable()
		oSection3:Cell("RZPD"):Disable()
		oSection4:Cell("RZPD"):Disable()

		oSection1:Cell("RZOCORR"):Disable() 
		oSection2:Cell("RZOCORR"):Disable()
		oSection3:Cell("RZOCORR"):Disable()
		oSection4:Cell("RZOCORR"):Disable()

		oSection1:Cell("RZTIPOCO"):Disable() 
		oSection2:Cell("RZTIPOCO"):Disable()
		oSection3:Cell("RZTIPOCO"):Disable()
		oSection4:Cell("RZTIPOCO"):Disable()

	ElseIf aMod[nX][1] = '01'
		//Habilita os campos do Ativo Fixo
		oSection1:Cell("N3CBASE"):Enable() 
		oSection2:Cell("N3CBASE"):Enable() 
		oSection3:Cell("N3CBASE"):Enable() 
		oSection4:Cell("N3CBASE"):Enable()

		oSection1:Cell("N3ITEM"):Enable() 
		oSection2:Cell("N3ITEM"):Enable() 
		oSection3:Cell("N3ITEM"):Enable() 
		oSection4:Cell("N3ITEM"):Enable()

		oSection1:Cell("N3TIPO"):Enable() 
		oSection2:Cell("N3TIPO"):Enable() 
		oSection3:Cell("N3TIPO"):Enable() 
		oSection4:Cell("N3TIPO"):Enable()

		//Desabilita os Campos dos outros Módulos		
		oSection1:Cell("RZPD"):Disable() 
		oSection2:Cell("RZPD"):Disable() 
		oSection3:Cell("RZPD"):Disable() 
		oSection4:Cell("RZPD"):Disable()

		oSection1:Cell("RZOCORR"):Disable() 
		oSection2:Cell("RZOCORR"):Disable() 
		oSection3:Cell("RZOCORR"):Disable() 
		oSection4:Cell("RZOCORR"):Disable()

		oSection1:Cell("RZTIPOCO"):Disable() 
		oSection2:Cell("RZTIPOCO"):Disable() 
		oSection3:Cell("RZTIPOCO"):Disable() 
		oSection4:Cell("RZTIPOCO"):Disable()

		oSection1:Cell("F1TIPO"):Disable()
		oSection2:Cell("F1TIPO"):Disable()
		oSection3:Cell("F1TIPO"):Disable()
		oSection4:Cell("F1TIPO"):Disable()

		oSection1:Cell("F1SERIE"):Disable() 
		oSection2:Cell("F1SERIE"):Disable()
		oSection3:Cell("F1SERIE"):Disable()
		oSection4:Cell("F1SERIE"):Disable()

		oSection2:Cell("F1NUMERO"):Disable()
		oSection3:Cell("F1NUMERO"):Disable()
		oSection4:Cell("F1NUMERO"):Disable()

		oSection1:Cell("D3TM"):Disable() 
		oSection2:Cell("D3TM"):Disable()
		oSection3:Cell("D3TM"):Disable()
		oSection4:Cell("D3TM"):Disable()

		oSection1:Cell("D3DOC"):Disable() 
		oSection2:Cell("D3DOC"):Disable()
		oSection3:Cell("D3DOC"):Disable()
		oSection4:Cell("D3DOC"):Disable()

		oSection1:Cell("D3QUANT"):Disable() 
		oSection2:Cell("D3QUANT"):Disable()
		oSection3:Cell("D3QUANT"):Disable()
		oSection4:Cell("D3QUANT"):Disable()

		oSection1:Cell("CLIPRO"):Disable() 
		oSection2:Cell("CLIPRO"):Disable()
		oSection3:Cell("CLIPRO"):Disable()
		oSection4:Cell("CLIPRO"):Disable()

		oSection1:Cell("RAZSOC"):Disable() 
		oSection2:Cell("RAZSOC"):Disable()
		oSection3:Cell("RAZSOC"):Disable()
		oSection4:Cell("RAZSOC"):Disable()

	ElseIf aMod[nX][1] == '04'
		//Habilita os campos do Estoque/Custos
		oSection1:Cell("D3TM"):Enable() 
		oSection2:Cell("D3TM"):Enable() 
		oSection3:Cell("D3TM"):Enable() 
		oSection4:Cell("D3TM"):Enable()

		oSection1:Cell("D3DOC"):Enable() 
		oSection2:Cell("D3DOC"):Enable() 
		oSection3:Cell("D3DOC"):Enable() 
		oSection4:Cell("D3DOC"):Enable()

		oSection1:Cell("D3QUANT"):Enable() 
		oSection2:Cell("D3QUANT"):Enable() 
		oSection3:Cell("D3QUANT"):Enable() 
		oSection4:Cell("D3QUANT"):Enable()

		//Desabilita os Campos dos outros Módulos
		oSection1:Cell("RZPD"):Disable() 
		oSection2:Cell("RZPD"):Disable() 
		oSection3:Cell("RZPD"):Disable() 
		oSection4:Cell("RZPD"):Disable()

		oSection1:Cell("RZOCORR"):Disable() 
		oSection2:Cell("RZOCORR"):Disable() 
		oSection3:Cell("RZOCORR"):Disable() 
		oSection4:Cell("RZOCORR"):Disable()

		oSection1:Cell("RZTIPOCO"):Disable() 
		oSection2:Cell("RZTIPOCO"):Disable() 
		oSection3:Cell("RZTIPOCO"):Disable() 
		oSection4:Cell("RZTIPOCO"):Disable()

		oSection1:Cell("F1TIPO"):Disable()
		oSection2:Cell("F1TIPO"):Disable()
		oSection3:Cell("F1TIPO"):Disable()
		oSection4:Cell("F1TIPO"):Disable()

		oSection1:Cell("F1SERIE"):Disable() 
		oSection2:Cell("F1SERIE"):Disable()
		oSection3:Cell("F1SERIE"):Disable()
		oSection4:Cell("F1SERIE"):Disable()

		oSection1:Cell("F1NUMERO"):Disable()
		oSection2:Cell("F1NUMERO"):Disable()
		oSection3:Cell("F1NUMERO"):Disable()
		oSection4:Cell("F1NUMERO"):Disable()

		oSection1:Cell("N3CBASE"):Disable() 
		oSection2:Cell("N3CBASE"):Disable()
		oSection3:Cell("N3CBASE"):Disable()
		oSection4:Cell("N3CBASE"):Disable()

		oSection1:Cell("N3ITEM"):Disable() 
		oSection2:Cell("N3ITEM"):Disable()
		oSection3:Cell("N3ITEM"):Disable()
		oSection4:Cell("N3ITEM"):Disable()

		oSection1:Cell("N3TIPO"):Disable() 
		oSection2:Cell("N3TIPO"):Disable()
		oSection3:Cell("N3TIPO"):Disable()
		oSection4:Cell("N3TIPO"):Disable()

		oSection1:Cell("CLIPRO"):Disable() 
		oSection2:Cell("CLIPRO"):Disable()
		oSection3:Cell("CLIPRO"):Disable()
		oSection4:Cell("CLIPRO"):Disable()

		oSection1:Cell("RAZSOC"):Disable() 
		oSection2:Cell("RAZSOC"):Disable()
		oSection3:Cell("RAZSOC"):Disable()
		oSection4:Cell("RAZSOC"):Disable()

	ElseIf aMod[nX][1] = '07'
		//Habilita os campos da Gestão de Pessoas
		oSection1:Cell("RZPD"):Enable() 
		oSection2:Cell("RZPD"):Enable() 
		oSection3:Cell("RZPD"):Enable() 
		oSection4:Cell("RZPD"):Enable()

		oSection1:Cell("RZOCORR"):Enable() 
		oSection2:Cell("RZOCORR"):Enable() 
		oSection3:Cell("RZOCORR"):Enable() 
		oSection4:Cell("RZOCORR"):Enable()

		oSection1:Cell("RZTIPOCO"):Enable() 
		oSection2:Cell("RZTIPOCO"):Enable() 
		oSection3:Cell("RZTIPOCO"):Enable() 
		oSection4:Cell("RZTIPOCO"):Enable()

		//Desabilita os Campos dos outros Módulos
		oSection1:Cell("F1TIPO"):Disable()
		oSection2:Cell("F1TIPO"):Disable()
		oSection3:Cell("F1TIPO"):Disable()
		oSection4:Cell("F1TIPO"):Disable()

		oSection1:Cell("F1SERIE"):Disable() 
		oSection2:Cell("F1SERIE"):Disable()
		oSection3:Cell("F1SERIE"):Disable()
		oSection4:Cell("F1SERIE"):Disable()

		oSection1:Cell("F1NUMERO"):Disable()
		oSection2:Cell("F1NUMERO"):Disable()
		oSection3:Cell("F1NUMERO"):Disable()
		oSection4:Cell("F1NUMERO"):Disable()

		oSection1:Cell("N3CBASE"):Disable() 
		oSection2:Cell("N3CBASE"):Disable()
		oSection3:Cell("N3CBASE"):Disable()
		oSection4:Cell("N3CBASE"):Disable()

		oSection1:Cell("N3ITEM"):Disable() 
		oSection2:Cell("N3ITEM"):Disable()
		oSection3:Cell("N3ITEM"):Disable()
		oSection4:Cell("N3ITEM"):Disable()

		oSection1:Cell("N3TIPO"):Disable() 
		oSection2:Cell("N3TIPO"):Disable()
		oSection3:Cell("N3TIPO"):Disable()
		oSection4:Cell("N3TIPO"):Disable()

		oSection1:Cell("D3TM"):Disable() 
		oSection2:Cell("D3TM"):Disable()
		oSection3:Cell("D3TM"):Disable()
		oSection4:Cell("D3TM"):Disable()

		oSection1:Cell("D3DOC"):Disable() 
		oSection2:Cell("D3DOC"):Disable()
		oSection3:Cell("D3DOC"):Disable()
		oSection4:Cell("D3DOC"):Disable()

		oSection1:Cell("D3QUANT"):Disable() 
		oSection2:Cell("D3QUANT"):Disable()
		oSection3:Cell("D3QUANT"):Disable()
		oSection4:Cell("D3QUANT"):Disable()

		oSection1:Cell("CLIPRO"):Disable() 
		oSection2:Cell("CLIPRO"):Disable()
		oSection3:Cell("CLIPRO"):Disable()
		oSection4:Cell("CLIPRO"):Disable()

		oSection1:Cell("RAZSOC"):Disable() 
		oSection2:Cell("RAZSOC"):Disable()
		oSection3:Cell("RAZSOC"):Disable()
		oSection4:Cell("RAZSOC"):Disable()

	EndIf
	
Return
