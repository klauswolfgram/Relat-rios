/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "CTBR810.CH"
/*/{Protheus.doc} CTBR810
Relatório do Livro Diário - chamada do Pergunte

@author Wilson.Possani
@since 18/04/2014
@version P120
/*/
User Function CTBR810()
Local lContinua	:= .T.

Private Titulo		:= STR0001 //"Livro Diário"
Private NomeProg	:= "CTBR810"
Private cPerg		:= "CTBR810"
                                                                                   
If TRepInUse()
	lContinua:=Pergunte(cPerg, .T.)

	If lContinua .And. MV_PAR02 < MV_PAR01
		Help(" ",1,"LANCINV",,STR0002,1,0)  //"Digite- Lançamento Inicial Menor que o Final !"
		lContinua := .F.
	EndIf


	If lContinua .And. MV_PAR04 < MV_PAR03
		Help(" ",1,"DATAINV",,STR0003,1,0)  //"Digite Data Inicial Menor que a Data Final !"
		lContinua := .F.
	EndIf

	If lContinua
		oReport := CTBR810B()
		oReport:PrintDialog()
	EndIf
Else
	MsgAlert(STR0015)		//"Relatório disponível somente para versão personalizada."
Endif
Return()



/*/{Protheus.doc} CTBR810B
Montar as Celulas

@author Wilson.Possani
@since 18/04/2014
@version P120

/*/

Static Function CTBR810B()
Local cReport	:= "CTBR810"
Local cTitulo	:= Titulo
Local cDesc		:= STR0004 //"Este programa imprime o Livro Diário."
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local aTamDesc		:= TAMSX3("CT1_DESC01")
Local cQry1     	:= ""
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4

oReport	:= TReport():New(cReport, cTitulo, cPerg, {|oReport| CTBR810C(oReport, oSection1, oSection2, oSection3, oSection4)}, cDesc)
oReport:SetPortrait()
oReport:SetTotalInLine(.F.)

Pergunte(oReport:uParam, .F.)

oReport:nFontBody := 6

oSection1 := TRSection():New(oReport, STR0005, {}, , ,) //"Cabeçalho"
oSection1:SetTotalInLine(.F.)
oSection1:SetHeaderPage()
oSection1:SetLinesBefore(0)

oSection2 := TRSection():New(oReport, STR0006, {}, , ,)//"Detalhes"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderPage()
oSection2:SetLinesBefore(0)

oSection3 := TRSection():New(oReport, STR0007, {}, , ,) //"Totais"
oSection3:SetTotalInLine(.F.)
oSection3:SetHeaderPage()
oSection3:SetLinesBefore(0)

oSection4 := TRSection():New(oReport, STR0008, {}, , ,) //"Total Geral"
oSection4:SetTotalInLine(.F.)
oSection4:SetHeaderPage()
oSection4:SetLinesBefore(0)

Return oReport

/*/{Protheus.doc} CTBR810C
Imprimir o Livro Diário.

@author Wilson.Possani
@since 18/04/2014
@version P120

/*/

Static Function CTBR810C(oReport, oSection1, oSection2, oSection3, oSection4)
Local nTamDesc	:= TAMSX3("CT1_DESC01")[1]
Local nTamConta:= TAMSX3("CT1_CONTA")[1]
Local nTamVlr	:= TAMSX3("CT2_VALOR")[1]
Local nTamAsi	:= TAMSX3("CT2_LANC")[1]
Local nTamFec	:= 10
Local nTamAgp	:= TAMSX3("CWS_DSCGRP")[1]
Local cQry      := ""
Local cComp     := ""
Local nCont     := 0
Local n         := 0
Local nTotCre   := 0
Local nTotDeb   := 0
Local nTotGCre  := 0
Local nTotGDeb  := 0
Local cArqTmp

cTabQry := GetNextAlias()
cQry := " SELECT CWS_LANC, CWS_DTLANC, CWS_DSCGRP, CWT_CONTA, CT1_DESC01 , CWT_DEBITO, CWT_CREDIT"
cQry += " FROM "+RetSqlName("CWS")+" CWS"
cQry += " INNER JOIN "+RetSqlName("CWT")+" CWT"
cQry += " ON CWS_LANC = CWT_LANC"
cQry += " AND CWT.D_E_L_E_T_ = ' '"
cQry += " INNER JOIN "+RetSqlName("CT1")+" CT1"
cQry += " ON CT1_CONTA = CWT_CONTA"
cQry += " AND CT1.D_E_L_E_T_ = ' '"
cQry += " WHERE CWS_LANC BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
cQry += " AND CWS_DTLANC BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"'"
cQry += " AND CWS.D_E_L_E_T_ = ' '"

If MV_PAR06 == 1
	cQry += " ORDER BY CWS_LANC, CWT_CONTA"
	cChav := "(cTabQry)->CWS_LANC"
ElseIf MV_PAR06 == 2
	cQry += " ORDER BY CWS_DTLANC,CWS_LANC,CWT_CONTA"
	cChav := "(cTabQry)->CWS_LANC"
Else
	cQry += " ORDER BY  CWT_CONTA,CWS_LANC"
	cChav := "(cTabQry)->CWT_CONTA"		
EndIf
If Select(cTabQry)<>0
	(cTabQry)->(DbCloseArea())
EndIf

cQry := ChangeQuery(cQry)
	
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cTabQry,.F.,.T.)
oReport:SetTitle(STR0001)//"Livro Diário"

If MV_PAR06 == 3
	//Celula cabeçalho
	TRCell():New(oSection1, "CUENTA", , STR0012 , , nTamConta, ,{|| (cTabQry)->CWT_CONTA}                                    , "CENTER", , "CENTER")//"Conta"
	TRCell():New(oSection1, "DESCRI", , STR0011 , , nTamDesc , ,{|| (cTabQry)->CT1_DESC01}                                    ,   "LEFT", ,   "LEFT")//"Descrição"
	
	//Celula Detalhe
	TRCell():New(oSection2, STR0010 , , STR0010 , , nTamFec, , {|| DTOC(STOD((cTabQry)->CWS_DTLANC))}, "CENTER", , "CENTER") //"Data"
	TRCell():New(oSection2, STR0009 , , STR0009 , , nTamAsi, , {|| (cTabQry)->CWS_LANC}            , "CENTER", , "CENTER") //"Lançamento"
	TRCell():New(oSection2, STR0011 , , STR0011 , , nTamAgp, , {|| (cTabQry)->CWS_DSCGRP}            ,   "LEFT", ,   "LEFT") //"Descrição"
	TRCell():New(oSection2, "VLRDEB", , STR0013 , , nTamVlr  , ,{|| TransForm((cTabQry)->CWT_DEBITO, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")//"Vlr. Débito"
	TRCell():New(oSection2, "VLRCRD", , STR0014 , , nTamVlr  , ,{|| TransForm((cTabQry)->CWT_CREDIT, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")//"Vlr. Crédito"
		
	//Totais 
	TRCell():New(oSection3, STR0010 , , "", , nTamFec, , , "CENTER", , "CENTER")
	TRCell():New(oSection3, STR0009 , , "", , nTamAsi, , , "CENTER", , "CENTER")
	TRCell():New(oSection3, STR0011 , , "", , nTamAgp, , , "LEFT", ,   "LEFT")
	TRCell():New(oSection3, "TTLDEB", , "", , nTamVlr  , , {|| TransForm(nTotDeb, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")
	TRCell():New(oSection3, "TTLCRD", , "", , nTamVlr  , , {|| TransForm(nTotCre, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")

	//Total Geral
	TRCell():New(oSection4, STR0010 , , "", , nTamFec, , , "CENTER", , "CENTER")
	TRCell():New(oSection4, STR0009 , , "", , nTamAsi, , , "CENTER", , "CENTER")
	TRCell():New(oSection4, STR0011 , , "", , nTamAgp, , {|| STR0008}            ,   "LEFT", ,   "LEFT")		//"Total Geral"
	TRCell():New(oSection4, "TTLDEB", , "", , nTamVlr  , , {|| TransForm(nTotGDeb, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")
	TRCell():New(oSection4, "TTLCRD", , "", , nTamVlr  , , {|| TransForm(nTotGCre, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")
	
Else
	//Celula cabeçalho
	TRCell():New(oSection1, STR0009 , , STR0009 , , nTamAsi, , {|| (cTabQry)->CWS_LANC}            , "CENTER", , "CENTER") //"Lançamento"
	TRCell():New(oSection1, STR0010 , , STR0010 , , nTamFec, , {|| DTOC(STOD((cTabQry)->CWS_DTLANC))}, "CENTER", , "CENTER") //"Data"
	TRCell():New(oSection1, STR0011 , , STR0011 , , nTamAgp, , {|| (cTabQry)->CWS_DSCGRP}            ,   "LEFT", ,   "LEFT") //"Descrição"

	//Celula Detalhe
	TRCell():New(oSection2, "CUENTA", , STR0012 , , nTamConta, ,{|| (cTabQry)->CWT_CONTA}                                    , "CENTER", , "CENTER")//"Conta"
	TRCell():New(oSection2, "DESCRI", , STR0011 , , nTamDesc , ,{|| (cTabQry)->CT1_DESC01}                                    ,   "LEFT", ,   "LEFT")//"Descrição"
	TRCell():New(oSection2, "VLRDEB", , STR0013 , , nTamVlr  , ,{|| TransForm((cTabQry)->CWT_DEBITO, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")//"Vlr. Débito"
	TRCell():New(oSection2, "VLRCRD", , STR0014 , , nTamVlr  , ,{|| TransForm((cTabQry)->CWT_CREDIT, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")//"Vlr. Crédito"

	//Totais 
	TRCell():New(oSection3, "CUENTA", , "", , nTamConta, ,                                                 , "CENTER", , "CENTER")
	TRCell():New(oSection3, "DESCRI", , "", , nTamDesc , ,                                                 , "CENTER", , "CENTER")
	TRCell():New(oSection3, "TTLDEB", , "", , nTamVlr  , , {|| TransForm(nTotDeb, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")
	TRCell():New(oSection3, "TTLCRD", , "", , nTamVlr  , , {|| TransForm(nTotCre, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")

	//Total Geral
	TRCell():New(oSection4, "CUENTA", , "", , nTamConta, ,                                                 , "CENTER", , "CENTER")
	TRCell():New(oSection4, "DESCRI", , "", , nTamDesc , , {|| STR0008}                              , "CENTER", , "CENTER")		// "Total Geral"
	TRCell():New(oSection4, "TTLDEB", , "", , nTamVlr  , , {|| TransForm(nTotGDeb, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")
	TRCell():New(oSection4, "TTLCRD", , "", , nTamVlr  , , {|| TransForm(nTotGCre, "@E 999,999,999,999.99")},  "RIGHT", ,  "RIGHT")
Endif

Count To _nRows

oReport:SetMeter(_nRows)
oReport:Section(1):Init()
oReport:Section(2):Init()
oReport:Section(3):Init()
oReport:Section(4):Init()
oReport:oPage:nPage := MV_PAR05
(cTabQry)->(DbGoTop())
cComp := &(cChav)

oReport:Section(1):PrintLine()

While (cTabQry)->(!Eof())
	If oReport:Cancel()
		nTotCre := 0
		nTotDeb := 0
		nTotGCre := 0
		nTotGDeb := 0
		Exit
	EndIf
	If cComp == &(cChav)
		oReport:Section(2):PrintLine()
		nTotCre += (cTabQry)->CWT_CREDIT
		nTotDeb += (cTabQry)->CWT_DEBITO
		//Total Geral	
		nTotGCre += (cTabQry)->CWT_CREDIT
		nTotGDeb += (cTabQry)->CWT_DEBITO		
	Else
		oReport:ThinLine()
		oReport:Section(3):PrintLine()
		oReport:SkipLine(1)
		oReport:Section(1):PrintLine()
		oReport:Section(2):PrintLine()
		cComp := &(cChav)
		nTotCre := 0
		nTotDeb := 0
		nTotCre += (cTabQry)->CWT_CREDIT
		nTotDeb += (cTabQry)->CWT_DEBITO
		//Total Geral
		nTotGCre += (cTabQry)->CWT_CREDIT
		nTotGDeb += (cTabQry)->CWT_DEBITO	
	EndIf
	oReport:IncMeter()
	(cTabQry)->(DbSkip())
End

If nTotCre <> 0 .Or. nTotDeb <> 0
	oReport:ThinLine()
	oReport:Section(3):PrintLine()
	oReport:SkipLine(2)
Endif

If nTotGCre <> 0 .Or. nTotGDeb <> 0
	oReport:FatLine()
	oReport:Section(4):PrintLine()
Endif

oReport:Section(1):Finish()
oReport:Section(2):Finish()	
oReport:Section(3):Finish()	
oReport:Section(4):Finish()	
Return(oReport)