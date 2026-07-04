/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'
#Include 'CTBR662.ch'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR662   º Autor ³ Wilson P Godoi     º Data ³  13/04/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório de Tracker Contabil                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso         Tracker Contabil                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CTBR662(aCpoOri,aDocOri,aLanCT2)


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local oReport
	
	Private aDoc	:= Aclone(aDocOri)
	Private aCT2	:= Aclone(aLanCT2)
	Private aCPO	:= Aclone(aCpoOri)
	
	If TrepinUse()
		oReport:= ReportDef()
		oReport:SetTotalInline(.F.)
		oReport:PrintDialog()
	Else
		Help(" ",1,"NAOLANC",,STR0001,1,0)  //"Relatório somente disponivel para Treport"
	EndIf
Return

Static Function ReportDef()
	Local oReport	:= Nil
	Local oSecDoc	:= Nil
	Local oSecLanc	:= Nil
	Local oFields	:= FWFormStruct(1, 'CT2')
	Local aCpoCT2	:= {"CT2_DATA","CT2_LOTE","CT2_SBLOTE","CT2_DOC","CT2_DC","CT2_DEBITO","CT2_CREDIT","CT2_VALOR","CT2_HIST",;
						"CT2_CCD","CT2_CCC","CT2_ITEMD","CT2_ITEMC","CT2_CLVLDB","CT2_CLVLCR"}
	Local nX		:= 0
	Local nY		:= 0
	
	oReport:= TReport():New(STR0002,STR0003,,{|oReport| PrintReport(oReport)},STR0004) //"Tracker Contabil","Relatório de Rastreio Contabil"  ##  "Relatório com os Lançamentos Contabeis"
	oReport:HideParamPage()
	oReport:SetlandScape()
	oReport:DisableOrientation()
	
	oSecDoc := TRSection():New(oReport,STR0005) //"Documento Original"
	oSecDoc:SetHeaderPage()
	oSecLanc := TRSection():New(oReport,STR0006) //"Lançamentos"
	oSecLanc:SetHeaderPage()
	
	For nX := 1 To Len(aDoc)
	//	New(oSection1,"E1_PREFIXO", "SE1", STR0037	, PesqPict("SE1","E1_PREFIXO") 	, TamSX3("E1_PREFIXO")[1] ,/*lPixel*/,{ || SE1->E1_PREFIXO })//"Prf"
		TRCell():New(oSecDoc,aCPO[nX],, RetTitle(aCPO[nX]),, TamSX3(aCPO[nX])[1] + 10 ,,,,.T.)
	Next nX
	
	For nY := 1 to Len(oFields:aFields)
		If Ascan(aCpoCT2,Alltrim(oFields:aFields[nY][3])) > 0
			If oFields:aFields[nY][4]== 'D'
				TRCell():New(oSecLanc,oFields:aFields[nY][3],, RetTitle(oFields:aFields[nY][3]),, 20 ,,)
			Else
				TRCell():New(oSecLanc,oFields:aFields[nY][3],, RetTitle(oFields:aFields[nY][3]),, TamSX3(oFields:aFields[nY][3])[1] ,,,,.T.)
			EndIf
		Endif
	Next nY

Return oReport

Static Function PrintReport(oReport)
	Local oFields	:= FWFormStruct(1, 'CT2')
	Local aCpoCT2	:= {"CT2_DATA","CT2_LOTE","CT2_SBLOTE","CT2_DOC","CT2_DC","CT2_DEBITO","CT2_CREDIT","CT2_VALOR","CT2_HIST",;
						"CT2_CCD","CT2_CCC","CT2_ITEMD","CT2_ITEMC","CT2_CLVLDB","CT2_CLVLCR"}
	Local oSecDoc	:= oReport:Section(1)
	Local oSecLanc	:= oReport:Section(2)
	Local nX		:= 0
	Local nY		:= 0
	Local nZ		:= 0
	Local nPos		:= 0
	Local nInitCBox	:= 0
	Local cCampo	:= ""
	Local aCbox		:= {}
	Local aCboxCT5	:= {}
	
	SX3->(DbSetOrder(2))
	SX3->(DbSeek("CT5_DC"))
	aCbox := RetSX3Box(X3Cbox(),@nInitCBox,,SX3->X3_TAMANHO)
	If Empty(aCbox)
		Aadd(aCboxCT5,STR0007)	//"a debito"
		Aadd(aCboxCT5,STR0008)	//"a credito"	
		Aadd(aCboxCT5,STR0009)	//"partida dobrada"
	Else
		For nInitCBox := 1 To Len(aCbox)
			Aadd(aCboxCT5,aCbox[nInitCBox,3])
		Next
	Endif
	SX3->(DbSetOrder(1))
	
//Cabec - Documento	
	oSecDoc:Init()
	For nX := 1 To Len(aDoc)
		oSecDoc:Cell(nX):SetValue(aDoc[nX])
	Next nX
	nX:= Len(aDoc)
	oSecDoc:PrintLine()
	oReport:SkipLine()
	oSecDoc:Finish()
	
//Itens - Lançamentos
	oSecLanc:Init()
	For nY := 1 To Len(aCT2)
		For nZ := 1 To Len(oSecLanc:aCell)
			nPos := Ascan(oFields:aFields,{|cCampo| AllTrim(cCampo[3]) == AllTrim(oSecLanc:Cell(nZ):Name())})
			If AllTrim(oSecLanc:Cell(nZ):Name()) == "CT2_DC"
				oSecLanc:Cell(nZ):SetValue(aCboxCT5[Val(aCT2[nY,2,nPos])])
			Else 
				oSecLanc:Cell(nZ):SetValue(aCT2[nY,2,nPos])
			EndIf
		Next nZ
		oSecLanc:PrintLine()
	Next nY
	oSecLanc:Finish()
	
	Asize(aCbox,0)
	Asize(aCboxCT5,0)
	aCbox := Nil
	aCboxCT5 := Nil
Return		
