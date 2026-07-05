/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

//#INCLUDE "MSOLE.CH"
#INCLUDE "PROTHEUS.CH"
//#INCLUDE "TBICONN.CH"
//#INCLUDE "TOPCONN.CH"
//#INCLUDE "RWMAKE.CH"
//#INCLUDE "REPORT.CH"
#INCLUDE "TECR930A.CH"

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR930A
Relatorio de Anexo de Fatura
@sample 	TECR930A
@param		Nenhum
@return		Nil
@since		31/01/2017
@author	Heimdall.Castro
@version	P12   
/*/
//------------------------------------------------------------------------------//
User Function TECR930A()

Local oReport

//Variáveis para uso com os dados do pergunte
Local cPergunte := "TECR930A"
Local cCntrSv   := ""
Local cContrt   := ""
Local cServEx   := ""
Local cNumMed   := ""
Local lImpImp   := .F.


If Pergunte(cPergunte)
	cNumMed := MV_PAR01
	lImpImp := MV_PAR02 == 1
	
	oReport := ReportDef(cPergunte, cNumMed, lImpImp) 
	oReport:PrintDialog()
EndIf

Return (Nil)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun??o    ³REPORTDEF ³ Autor ³ HEIMDALL              ³ Data ³ 06/07/06 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ReportDef(cPergunte, cNumMed, lImpImp)
                                             
//Variáveis utilizadas para geração do Report
Local oReport 
Local oSection0, oSection01, oSection01, oSection1, oSection30, oSection31, oSection40, oSection41,oSection42, oSection50, oSection51, oSection52, oSection60, oSection61, oSection70, oSection71
Local oCell
Local oCellQbr
Local oTotGer, oTotIR, oTotISS, oTotPIS, oTotCOF, oTotCSL, oTotGIM, oTotINS, oTotICM
Local oBreak
Local lVerif    := .F.
Local nIns		:= 0
Local nIr		:= 0
Local nIss		:= 0
Local nPis		:= 0
Local nCof		:= 0
Local nCsl		:= 0
Local nIcm		:= 0
Local nTotal	:= 0
Local nImp		:= 0
Local nTotSImp	:= 0
Local cMasc		:= PesqPict("TFL","TFL_TOTRH")
Local aIdent	:= {STR0041,STR0040,STR0039,STR0042,STR0043} //'3 - Materiais de Consumo' //'2 - Materiais de Implantação' //'1 - Recursos Humanos' //'4 - Locação de Equipamentos' //'5 - Despesas Adicionais'
Local nTamIdent := 0
Local lTWX		:= TableInDic("TWX")
Local nTamImp 	:= GetSx3Cache("C6_VALOR", "X3_TAMANHO")
Local nTamProd	:= GetSx3Cache("B1_COD", "X3_TAMANHO")
Local nTamDescr := GetSx3Cache("B1_DESC", "X3_TAMANHO")
Local oBreak	:= nil
Local oBreak0	:= nil
Local  cTpModCob := ""
Local aAreaSx3 := GetArea()
Local aModCob := {}
Local aTmp := {}
Local nTam := 0
Local aTmp2 := {}
Local nTamCob := 0
Local nPos := 0
Local cImpPic := GetSx3Cache("C6_VALOR", "X3_PICTURE")

cTpModCob := AllTrim(X3CBox(FwGetSx3Cache("TFZ_MODCOB", "X3_CBOX")))
aTmp := StrToArray(cTpModCob, ";")
aEval(aTmp , { |c| aTmp2 :=StrToArray(c, "="), nTamCob := Max(nTamCob, Len(aTmp2[2])),  Aadd(aModCob, aClone(aTmp2))})

If lImpImp //Se imprimir impostos e for uma medição fora do contrato nao imprime imposto
	TCV->(DbSetOrder(1))
	lImpImp := !TCV->(DbSeek(xFilial("TCV") + PadR(cNumMed, TamSX3("TCV_NUMAPU")[1]) ))
EndIf

aEval(aIdent, {|i| nTamIdent := Max(Len(i), nTamIdent)})

oReport := TReport():New("TECR930A",STR0001,cPergunte,{|oReport| RELIMP(oReport, cNumMed,  lImpImp,aIdent, lTWX)},"")                                                                                                                                                                                                                                                                                                                                                                                                                                    //"Anexo de Fatura"
oReport:SetLandScape()         
oReport:lDisableOrientation := .T.

oSection0 := TRSection():New(oReport,"" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ STR0044 ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */, /*<lHeaderBreak>*/ .F. , /*<lPageBreak>*/ .t. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 0 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ )  //"Total do Pedido/Nota"
//oBreak0 := TRBreak():New( oSection0 , { ||  QRYSQL->(CODMED+NUMNF+SERIE+PEDIDO) } , STR0044 , .T. , , .F.)  //"Total do Pedido/Nota"
oBreak0 := TRBreak():New( oSection0 , { ||  QRYSQL->(CODMED+NUMNF+SERIE+PEDIDO) } , "" , .F. , , .F.)  //"Total do Pedido/Nota"

oSection0:SetPageBreak(.T.)

oCell := TRCell():New(oSection0,"CODLOC","QRYSQL",STR0045	          ,, GetSx3Cache("ABS_LOCAL", "X3_TAMANHO"),,,"LEFT",,"LEFT")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            //"Código"
oCell := TRCell():New(oSection0,"LOCDSC","QRYSQL",STR0003		      ,,GetSx3Cache("ABS_DESCRI", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Desc. Local"
oCell := TRCell():New(oSection0,"PEDIDO","QRYSQL",STR0046		      ,,GetSx3Cache("C6_NUM", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Pedido"
oCell := TRCell():New(oSection0,"NUMNF" ,"QRYSQL",STR0004	          ,,GetSx3Cache("C5_NOTA", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Numero NF"
oCell := TRCell():New(oSection0,"SERIE" ,"QRYSQL",STR0047             ,, GetSx3Cache("C5_SERIE", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Serie NF"



oSection1 := TRSection():New(oSection0,"" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 5 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) 
oSection1:SetHeaderSection(.T.)

oCell := TRCell():New(oSection1,"ITEM","QRYSQL",STR0048	          ,, GetSx3Cache("C6_ITEM", "X3_TAMANHO"),,,"LEFT",,"LEFT")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           //"Item"
oCell := TRCell():New(oSection1,"C6_PRODUTO","QRYSQL",STR0045		      ,,nTamProd,,,"LEFT",,"LEFT") //"Código"
oCell := TRCell():New(oSection1,"B1_DESC","QRYSQL",STR0049		      ,,nTamDescr,,,"LEFT",,"LEFT") //"Descrição Produto"
oCell := TRCell():New(oSection1,"C6_QTDVEN","QRYSQL",STR0038		      ,GetSx3Cache("C6_QTDVEN", "X3_PICTURE"),GetSx3Cache("C6_QTDVEN", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Quantidade"
oCell := TRCell():New(oSection1,"C6_PRUNIT" ,"QRYSQL",GetSx3Cache("C6_PRUNIT", "X3_TITULO")	          ,GetSx3Cache("C6_PRUNIT", "X3_PICTURE"),GetSx3Cache("C6_PRUNIT", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Preço Unitário"
oCell := TRCell():New(oSection1,"C6_SUBTOT" ,"QRYSQL","SubTotal"         ,cImpPic,nTamImp,,{|| QRYSQL->(C6_QTDVEN*C6_PRUNIT) },"LEFT",,"LEFT") //"Preço Unitário"
//oCell := TRCell():New(oSection1,"C6_PRCVEN" ,"QRYSQL",STR0050	          ,GetSx3Cache("C6_PRCVEN", "X3_PICTURE"),GetSx3Cache("C6_PRCVEN", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Preço Unitário"

oCell := TRCell():New(oSection1,"C6_VALDESC" ,"QRYSQL",GetSx3Cache("C6_VALDESC", "X3_TITULO")        ,cImpPic,nTamImp,,,"LEFT",,"LEFT") //"Preço Unitário"
oCell := TRCell():New(oSection1,"C6_VALOR" ,"QRYSQL",STR0051	             ,cImpPic, nTamImp,,,"LEFT",,"LEFT") //"Preço Total"

oBreak := TRBreak():New( oSection1 , { ||  QRYSQL->(CODMED+NUMNF+SERIE+PEDIDO+CODLOC+ITEM) } , STR0052 , .T. , , .F.)  //"Total do Item"

	oSection30 := TRSection():New(oSection1,"" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .T. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 10 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) 
	oSection30:SetHeaderSection(.T.) 
	
	oCellQbr := TRCell():New(oSection30,"IDENT","QRYSQL",""                ,,nTamIdent,,,"LEFT",,"LEFT")
	
		oSection31 := TRSection():New(oSection30, STR0006, /*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ STR0053,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .f. , /*<lPageBreak>*/ .F. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 15 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ )//Recursos Humanos //"Total Recursos Humanos" //"Recursos Humanos"
		oSection31:SetHeaderSection(.T.)
		
		oCell := TRCell():New(oSection31,"PRDCOD"	,"QRYSQL",STR0045          	,,nTamProd,,,"LEFT",,"LEFT") //"Código"
		oCell := TRCell():New(oSection31,"PRDDSC"	,"QRYSQL",STR0049			 	,,nTamDescr,,,"LEFT",,"LEFT")//Descrição //"Descrição Produto"
		oCell := TRCell():New(oSection31,"QTDVEN"	,"QRYSQL",STR0054		     	,GetSx3Cache("TFF_QTDVEB", "X3_PICTURE"),GetSx3Cache("TFF_QTDVEB", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Qtde"
		oCell := TRCell():New(oSection31,"VLHORE"	,"QRYSQL","Vlr. H.E"		 	,GetSx3Cache("TFW_VLHORE", "X3_PICTURE"),GetSx3Cache("TFW_VLHORE", "X3_TAMANHO"),,,"LEFT",,"LEFT")
		oCell := TRCell():New(oSection31,"VLRMED"	,"QRYSQL",STR0055			 	,GetSx3Cache("TFW_VLRMED", "X3_PICTURE"),GetSx3Cache("TFW_VLRMED", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Valor Medido"
		oCell := TRCell():New(oSection31,"TOTMUL"	,"QRYSQL",STR0012          	,GetSx3Cache("TFW_TOTMUL", "X3_PICTURE"),GetSx3Cache("TFW_TOTMUL", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Multas"
		oCell := TRCell():New(oSection31,"TOTBON"	,"QRYSQL",STR0013		      	,GetSx3Cache("TFW_TOTBON", "X3_PICTURE"),GetSx3Cache("TFW_TOTBON", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Bonificações"
		oCell := TRCell():New(oSection31,"TOTDES"	,"QRYSQL",STR0014         	,GetSx3Cache("TFW_TOTDES", "X3_PICTURE"),GetSx3Cache("TFW_TOTDES", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Descontos"
	
	oSection40 := TRSection():New(oSection1,"" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 10 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) 
	oSection40:SetHeaderSection(.T.) 
	
	oCellQbr := TRCell():New(oSection40,"IDENT","QRYSQL",""            ,,nTamIdent,,,"LEFT",,"LEFT")
	

		oSection41 := TRSection():New(oSection40, STR0026, /*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ STR0056,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .T. , /*<lPageBreak>*/ .F. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 15 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) //Recursos Humanos //"Materiais de Implantação" //"Total Materiais de Implantação"
		oSection41:SetHeaderSection(.T.)
		
		oCell := TRCell():New(oSection41,"PRDCOD","QRYSQL",STR0045         	,,nTamProd,,,"LEFT",,"LEFT") //"Código"
		oCell := TRCell():New(oSection41,"PRDDSC","QRYSQL",STR0049    		,,nTamDescr,,,"LEFT",,"LEFT") //"Descrição Produto"
		oCell := TRCell():New(oSection41,"VLRMED","QRYSQL",STR0055			 	,GetSx3Cache("TFX_VLRMED", "X3_PICTURE"),GetSx3Cache("TFX_VLRMED", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Valor Medido"
		oCell := TRCell():New(oSection41,"TOTMUL","QRYSQL",STR0012        	,GetSx3Cache("TFX_TOTMUL", "X3_PICTURE"),GetSx3Cache("TFX_TOTMUL", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Multas"
		oCell := TRCell():New(oSection41,"TOTBON","QRYSQL",STR0013  		,GetSx3Cache("TFX_TOTBON", "X3_PICTURE"),GetSx3Cache("TFX_TOTBON", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Bonificações"
		oCell := TRCell():New(oSection41,"TOTDES","QRYSQL",STR0014     		,GetSx3Cache("TFX_TOTDES", "X3_PICTURE"),GetSx3Cache("TFX_TOTDES", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Descontos"

	oSection50 := TRSection():New(oSection1,"" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 10 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) 
	oSection50:SetHeaderSection(.T.) 
	oCellQbr := TRCell():New(oSection50,"IDENT","QRYSQL",""            ,,nTamIdent,,,"LEFT",,"LEFT")
	

		oSection51 := TRSection():New(oSection50, STR0029, /*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ STR0057,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 15 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) //Recursos Humanos //"Total Materiais de Consumo" //"Materiais de Consumo"
		oSection51:SetHeaderSection(.T.)
		
		oCell := TRCell():New(oSection51,"PRDCOD","QRYSQL",STR0045         	,,nTamProd,,,"LEFT",,"LEFT") //"Código"
		oCell := TRCell():New(oSection51,"PRDDSC","QRYSQL",STR0049    		,,nTamDescr,,,"LEFT",,"LEFT") //"Descrição Produto"
		oCell := TRCell():New(oSection51,"VLRMED","QRYSQL",STR0055			 	,GetSx3Cache("TFY_VLRMED", "X3_PICTURE"),GetSx3Cache("TFY_VLRMED", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Valor Medido"
		oCell := TRCell():New(oSection51,"TOTMUL","QRYSQL",STR0012        	,GetSx3Cache("TFY_TOTMUL", "X3_PICTURE"),GetSx3Cache("TFY_TOTMUL", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Multas"
		oCell := TRCell():New(oSection51,"TOTBON","QRYSQL",STR0013  		,GetSx3Cache("TFY_TOTBON", "X3_PICTURE"),GetSx3Cache("TFY_TOTBON", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Bonificações"
		oCell := TRCell():New(oSection51,"TOTDES","QRYSQL",STR0014     		,GetSx3Cache("TFY_TOTDES", "X3_PICTURE"),GetSx3Cache("TFY_TOTDES", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Descontos"

	
	oSection60 := TRSection():New(oSection1,"" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 10 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) 
	oSection60:SetHeaderSection(.T.) 
	oCellQbr := TRCell():New(oSection60,"IDENT","QRYSQL",""              ,,nTamIdent,,,"LEFT",,"LEFT")
	
		oSection61 := TRSection():New(oSection60, STR0031, /*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ STR0058,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 15 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ )//Recursos Humanos //"Total Locação de Equipamentos" //"Locação de Equipamentos"
		oSection61:SetHeaderSection(.T.)
		oCell := TRCell():New(oSection61,"PRDCOD","QRYSQL",STR0045         	,,nTamProd,,,"LEFT",,"LEFT") //"Código"
		oCell := TRCell():New(oSection61,"PRDDSC","QRYSQL",STR0049    		,,nTamDescr,,,"LEFT",,"LEFT") //"Descrição Produto"
		oCell := TRCell():New(oSection61,"VLRMED"	,"QRYSQL",STR0055			 	,GetSx3Cache("TFZ_TOTAL", "X3_PICTURE"),GetSx3Cache("TFZ_TOTAL", "X3_TAMANHO"),,,"LEFT",,"LEFT")//Vlr. Horas Extras //"Valor Medido"
		oCell := TRCell():New(oSection61,"MODCOB"	,"QRYSQL",STR0059			 	,,nTamCob,,{|| IIF((nPos := aScan(aModCob, {|m| AllTrim(m[1]) == Alltrim(QRYSQL->MODCOB)})) > 0,aModCob[nPos, 2],"")},"LEFT",,"LEFT") //"Cobrança"
		oCell := TRCell():New(oSection61,"VLRMED"	,"QRYSQL",STR0055			 	,GetSx3Cache("TFZ_TOTAL", "X3_PICTURE"),GetSx3Cache("TFZ_TOTAL", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Valor Medido"
		oCell := TRCell():New(oSection61,"TOTMUL"	,"QRYSQL",STR0012          	,GetSx3Cache("TFZ_TOTAL", "X3_PICTURE"),GetSx3Cache("TFZ_TOTAL", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Multas"
		oCell := TRCell():New(oSection61,"TOTBON"	,"QRYSQL",STR0013		      	,GetSx3Cache("TFZ_TOTAL", "X3_PICTURE"),GetSx3Cache("TFZ_TOTAL", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Bonificações"
		oCell := TRCell():New(oSection61,"TOTDES"	,"QRYSQL",STR0014         	,GetSx3Cache("TFZ_TOTAL", "X3_PICTURE"),GetSx3Cache("TFZ_TOTAL", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Descontos"
	
	oSection70 := TRSection():New(oSection1,"" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 10 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) 
	oSection70:SetHeaderSection(.T.) 
	oCellQbr := TRCell():New(oSection70,"IDENT","QRYSQL",""              ,,nTamIdent,,,"LEFT",,"LEFT")
	
		oSection71 := TRSection():New(oSection70,STR0036, /*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ STR0060,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/ 15 , /*<lLineStyle> */, /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) //Recursos Humanos //"Total Despesas Adicionais" //"Despesas Adicionais"
		oSection71:SetHeaderPage(.F.)
		oSection71:SetHeaderSection(.T.)
		oCell := TRCell():New(oSection71,"PRDCOD","QRYSQL",STR0045         	,,nTamProd,,,"LEFT",,"LEFT") //"Código"
		oCell := TRCell():New(oSection71,"PRDDSC","QRYSQL",STR0049    		,,nTamDescr,,,"LEFT",,"LEFT") //"Descrição Produto"
		oCell := TRCell():New(oSection71,"VLRMED"	,"QRYSQL",STR0055			 	,GetSx3Cache("TFX_VLRMED", "X3_PICTURE"),GetSx3Cache("TFX_VLRMED", "X3_TAMANHO"),,,"LEFT",,"LEFT")//Vlr. Horas Extras //"Valor Medido"


	If lImpImp
		oCell := TRCell():New(oSection1,"nIns"		,		 ,""                 	,, nTamImp,,,"LEFT",,"LEFT")
		oCell := TRCell():New(oSection1,"nIr" 		,		 ,""                  	,, nTamImp,,,"LEFT",,"LEFT")
		oCell := TRCell():New(oSection1,"nIss"		,		 ,""               	,, nTamImp,,,"LEFT",,"LEFT")
		oCell := TRCell():New(oSection1,"nPis"		,		 ,""                  	,, nTamImp,,,"LEFT",,"LEFT")
		oCell := TRCell():New(oSection1,"nCof"		,		 ,""                  	,, nTamImp,,,"LEFT",,"LEFT")
		oCell := TRCell():New(oSection1,"nCsl"		,		 ,""                  	,, nTamImp,,,"LEFT",,"LEFT")
		oCell := TRCell():New(oSection1,"nTotSImp"	,		 ,""                	,, nTamImp,,,"LEFT",,"LEFT")  
		oCell := TRCell():New(oSection1,"nImp"	    ,	      ,""		   	,cMasc,nTamImp,,,"LEFT",,"LEFT")  //"Total Impostos"
		
		oSection1:Cell("nIns"):Hide()
		oSection1:Cell("nIr"):Hide()
		oSection1:Cell("nIss"):Hide()
		oSection1:Cell("nPis"):Hide()
		oSection1:Cell("nCof"):Hide()
		oSection1:Cell("nCsl"):Hide()	
		oSection1:Cell("nTotSImp"):Hide()
		oSection1:Cell("nImp"):Hide()

		oTotIN2 := TRFunction():new(oSection1:Cell("nIns"),,"SUM",oBreak		,STR0018,cMasc,,.f.,.F.,.F.,oSection1,)//STR0018  //"Total INSS    "
		oTotIR2  := TRFunction():new(oSection1:Cell("nIr") ,,"SUM",oBreak		,STR0062,cMasc,,.f.,.F.,.F.,oSection1,)//"Total IR      " //"Total IR     "
		oTotIS2 := TRFunction():new(oSection1:Cell("nIss"),,"SUM",oBreak		,STR0020,cMasc,,.f.,.F.,.F.,oSection1,)//STR0020 //"Total ISS     "
		oTotPI2 := TRFunction():new(oSection1:Cell("nPis"),,"SUM",oBreak		,STR0021,cMasc,,.f.,.F.,.F.,oSection1,)//STR0021 //"Total PIS     "
		oTotCO2 := TRFunction():new(oSection1:Cell("nCof"),,"SUM",oBreak		,STR0022,cMasc,,.f.,.F.,.F.,oSection1,)//STR0022 //"Total COFINS  "
		oTotCS2 := TRFunction():new(oSection1:Cell("nCsl"),,"SUM",oBreak     	,STR0023,cMasc,,.f.,.F.,.F.,oSection1,)//STR0023 //"Total CSLL    "
		oTotGT2 := TRFunction():new(oSection1:Cell("nImp"),,"SUM",oBreak    	,STR0061,cMasc,,.f.,.F.,.F.,oSection1,)//   //"Total Impostos"
		oTotGM2 := TRFunction():new(oSection1:Cell("nTotSImp"),,"SUM",oBreak	,STR0024,cMasc,,.f.,.F.,.F.,oSection1,)//STR0024    //"Total Sem Imp."


		oTotIN := TRFunction():new(oSection1:Cell("C6_SUBTOT"),,"SUM",oBreak0		,"SubTotal dos Itens",cMasc,,.f.,.F.,.F.,oSection0,)//STR0018  //"Total INSS    "
		oTotIR  := TRFunction():new(oSection1:Cell("C6_VALDESC") ,,"SUM",oBreak0		,"Total Descontos dos Itens",cMasc,,.f.,.F.,.F.,oSection0,)//"Total IR      " //"Total IR     "
		oTotIS := TRFunction():new(oSection1:Cell("C6_VALOR"),,"SUM",oBreak0		,"Total dos Itens",cMasc,,.f.,.F.,.F.,oSection0,)//STR0020 //"Total ISS     "


		/*oTotIN := TRFunction():new(oSection1:Cell("nIns"),,"SUM",oBreak0		,STR0018,cMasc,,.F.,.F.,.F.,oSection0,)//STR0018  //"Total INSS    "
		oTotIR  := TRFunction():new(oSection1:Cell("nIr") ,,"SUM",oBreak0		,STR0019,cMasc,,.F.,.F.,.F.,oSection0)//STR0019 //"Total IR      "
		oTotIS := TRFunction():new(oSection1:Cell("nIss"),,"SUM",oBreak0		,STR0020,cMasc,,.F.,.F.,.F.,oSection0,)//STR0020 //"Total ISS     "
		oTotPI := TRFunction():new(oSection1:Cell("nPis"),,"SUM",oBreak0		,STR0021,cMasc,,.F.,.F.,.F.,oSection0,)//STR0021 //"Total PIS     "
		oTotCO := TRFunction():new(oSection1:Cell("nCof"),,"SUM",oBreak0		,STR0022,cMasc,,.F.,.F.,.F.,oSection0,)//STR0022 //"Total COFINS  "
		oTotCS := TRFunction():new(oSection1:Cell("nCsl"),,"SUM",oBreak0		,STR0023,cMasc,,.F.,.F.,.F.,oSection0,)//STR0023 //"Total CSLL    "
		oTotGT := TRFunction():new(oSection1:Cell("nImp"),,"SUM",oBreak0		,STR0061,cMasc,,.F.,.F.,.F.,oSection0,)//"Total Sem Imp."    //"Total Impostos"
		oTotGM := TRFunction():new(oSection1:Cell("nTotSImp"),,"SUM",oBreak0	,STR0024,cMasc,,.F.,.F.,.F.,oSection0,)//STR0024    //"Total Sem Imp."*/

		oSection00 := TRSection():New(oSection0,"Impostos do Pedido" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/  , .f., /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) 
		//DEFINE SECTION oSection00 OF oSection0 TITLE "Total de Impostos"
		oCell := TRCell():New(oSection00,"DESCR","QRYSQL",""	          ,, 30,,,"LEFT",,"LEFT")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            //"Código"

		oSection01 := TRSection():New(oSection00,"Impostos do Pedido" ,/*<uTable> */, /*<aOrder>*/ , /*<lLoadCells>*/ , /*<lLoadOrder>*/ , /*<uTotalText>*/ ,/*<lTotalInLine .T.*/ , /*<lHeaderPage> */.f., /*<lHeaderBreak>*/ .t. , /*<lPageBreak>*/ .f. , /*<lLineBreak>*/ ,/* <nLeftMargin>*/5  , .f., /*<nColSpace>*/ , /*<lAutoSize> */, /*<cCharSeparator>*/ , /*<nLinesBefore> */, /*<nCols> */, /*<nClrBack> */, /*<nClrFore> */, /*<nPercentage> */ ) 
		
		//DEFINE SECTION oSection01 OF oSection00  TITLE "Impostos do Pedido" LEFT MARGIN 5 //LINE STYLE COLUMNS 3
		oSection01:SetHeaderSection(.T.)		
		oCell := TRCell():New(oSection01,"SIGLA","QRYSQL","Sigla Imposto"	          ,, 4,,,"LEFT",,"LEFT")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            //"Código"
		oCell := TRCell():New(oSection01,"BASE","QRYSQL","Base Cálculo"		      ,cImpPic,nTamImp,,,"LEFT",,"LEFT") //"Desc. Local"
		oCell := TRCell():New(oSection01,"VALOR","QRYSQL","Valor Imposto"		      ,cImpPic,nTamImp,,,"LEFT",,"LEFT") //"Pedido"


		
	EndIf
	If lTWX
		oSection42 := TRSection():New(oSection41, '',,,,,,,,,,,13)//"Conteúdo do Kit"
		
		oCell := TRCell():New(oSection42,"PRDCOD","QRYSQL",STR0045         	,,nTamProd,,,"LEFT",,"LEFT") //"Código"
		oCell := TRCell():New(oSection42,"PRDDSC","QRYSQL",STR0049    		,,nTamDescr,,,"LEFT",,"LEFT") //"Descrição Produto"
		oCell := TRCell():New(oSection42,"QTDVEN","QRYSQL",STR0054    		,GetSx3Cache("TWX_QUANT", "X3_PICTURE"),GetSx3Cache("TWX_QUANT", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Qtde"

		oSection52 := TRSection():New(oSection51, ' ',,,,,,,,,,,13)//"Conteúdo do Kit"
		oCell := TRCell():New(oSection52,"PRDCOD","QRYSQL",STR0045         	,,nTamProd,,,"LEFT",,"LEFT") //"Código"
		oCell := TRCell():New(oSection52,"PRDDSC","QRYSQL",STR0049    		,,nTamDescr,,,"LEFT",,"LEFT") //"Descrição Produto"
		oCell := TRCell():New(oSection52,"QTDVEN","QRYSQL",STR0054   		,GetSx3Cache("TWX_QUANT", "X3_PICTURE"),GetSx3Cache("TWX_QUANT", "X3_TAMANHO"),,,"LEFT",,"LEFT") //"Qtde"
	
	EndIf

Return( oReport )

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ RELIMP   ³ Autor ³ Heimdall B. Castro    ³ Data ³ 04/09/07 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function RELIMP(oReport, cNumMed, lImpImp, aIdent, lTWX)
     
Local oSection0 := oReport:Section(1)
Local oSection1 := oSection0:Section(1)
Local oSection30 := oSection1:Section(1)
Local oSection31 := oSection30:Section(1)
Local oSection40 := oSection1:Section(2)
Local oSection41 := oSection40:Section(1)
Local oSection42 := IIF(lTWX, oSection41:Section(1), NIL)
Local oSection50 := oSection1:Section(3)
Local oSection51 := oSection50:Section(1)
Local oSection52 :=IIF(lTWX,  oSection51 :Section(1), NIL)
Local oSection60 := oSection1:Section(4)
Local oSection61 := oSection60:Section(1)
Local oSection70 := oSection1:Section(5)
Local oSection71 := oSection70:Section(1)
Local oSection00 := iif(lImpImp, oSection0:Section(2), nil)
Local oSection01 := iif(lImpImp, oSection00:Section(1), nil)
Local aImpostos := {}
Local nIns		:= 0
Local nIr		:= 0
Local nIss		:= 0
Local nPis		:= 0
Local nCof		:= 0
Local nCsl		:= 0
Local nIcm		:= 0
Local nTotal	:= 0
Local nImp		:= 0
Local nTotSImp	:= 0
Local cEspTES := Space(TamSX3("TFG_TES")[1])
Local cEspItem := Space(TamSX3("TFG_ITEM")[1])
Local cPaiRH := IiF(TW7->(ColumnPos("TW7_DESPAD"))> 0, "RH", "")
Local cPaiLE := IiF(TW7->(ColumnPos("TW7_DESPAD"))> 0, "LE", "")
Local cDesPad := "%"+ IiF(TW7->(ColumnPos("TW7_DESPAD"))> 0, " AND TW7.TW7_DESPAD = '1' ", "" ) +"%"
Local cQuery := ""
Local cQbrSec1 := ""
Local cQbrSecPed := ""
Local aImp := {}
Local cNFAtu := ""
Local cTamModCob := space(TamSx3("TFZ_MODCOB")[1])
Local nC := 0
Local aFisGet := {}
Local aFisGetSC5 := {}
                      
//cFrmRH := "%" +cFrmRH +"%"


FisGetInit(@aFisGet,@aFisGetSC5)

BEGIN REPORT QUERY oSection1
 
BeginSql alias "QRYSQL"
	SELECT 
		'1' AS IDENT, 
		TFV.TFV_CODIGO AS CODMED, 
		TFV.TFV_CONTRT AS CONTRT, 
		TFV.TFV_DTAPUR AS DTAPUR , 
		TFL.TFL_CODIGO AS TFLCOD, 
		TFL.TFL_LOCAL  AS CODLOC, 
		ABS.ABS_DESCRI AS LOCDSC, 
		TFW.TFW_CODIGO AS CODGRP, 
		TFW.TFW_CODTFF AS CODTFF, 
		TFW.TFW_VLRMED AS VLRMED , 
		TFW.TFW_VLHORN AS VLHORN , 
		TFW.TFW_VLHORE  AS VLHORE, 
		TFW.TFW_TOTDES AS TOTDES, 
		TFW.TFW_TOTMUL AS TOTMUL, 
		TFW.TFW_TOTBON AS TOTBON, 
		TFF.TFF_COD    AS PRDCOD, 
		SB1.B1_DESC    AS PRDDSC, 
		SC6.C6_ITEM  AS ITEM, 
		TFF.TFF_QTDVEN  AS QTDVEN, 
		TFF.TFF_PRCVEN AS PRCVEN, 
		TFJ.TFJ_GRPRH  AS GRPAPR, 
		TFJ.TFJ_TES    AS TESGRP, 
		SC5.C5_CLIENTE AS CLIENTE,
		CASE WHEN SC6.C6_NUM IS NULL THEN SC5.C5_NUM ELSE SC6.C6_NUM END AS PEDIDO, 
		CASE WHEN SC6.C6_NOTA IS NULL THEN SC5.C5_NOTA ELSE SC6.C6_NOTA	END AS NUMNF,
		CASE WHEN SC6.C6_SERIE IS NULL THEN SC5.C5_SERIE ELSE SC6.C6_SERIE END  AS SERIE, 
		SC6.C6_VALOR ,
		SC6.C6_PRODUTO,
		SB1_C6.B1_DESC,
		SC6.C6_QTDVEN,
		SC6.C6_PRCVEN,
		SC6.C6_TES,
		SC6.C6_PRUNIT,
		SC6.C6_VALDESC,
		SC5.C5_FRETE,
		SC5.C5_SEGURO,
		SC5.C5_FRETAUT,
		SC5.C5_DESPESA,
		SC5.C5_PDESCAB,
		SC5.C5_DESCONT,
		SC5.C5_CONDPAG,
		SC5.C5_CLIENT,
		SC5.C5_LOJAENT,
		%exp:cTamModCob% AS MODCOB,
		SC5.C5_LOJACLI
	FROM 
		%table:TFV% TFV 

		INNER JOIN  %table:TFW% TFW  ON (TFW.TFW_APURAC = TFV.TFV_CODIGO AND  TFW.TFW_FILIAL = %xfilial:TFW%  AND  TFW.%notDel%)
		LEFT JOIN %Table:TCV%  TCV ON ( TCV.TCV_NUMAPU = TFV.TFV_CODIGO AND TCV.TCV_FILIAL = %xfilial:TCV%  AND  TCV.%notDel% )
		INNER JOIN %table:TFF% TFF  ON ( TFF.TFF_COD  = TFW.TFW_CODTFF  AND TFF.TFF_CONTRT = TFV.TFV_CONTRT AND  TFF.TFF_FILIAL =  %xfilial:TFF%  AND  TFF.%notDel%)
		INNER JOIN %table:TFL% TFL  ON ( TFL.TFL_CODIGO = TFW.TFW_CODTFL AND TFL.TFL_CONTRT = TFV.TFV_CONTRT AND  TFL.TFL_FILIAL =  %xfilial:TFL%  AND  TFL.%notDel% )
		INNER JOIN %table:SC5% SC5  ON ( (  ( SC5.C5_MDCONTR = TFL.TFL_CONTRT AND SC5.C5_MDPLANI = TFL.TFL_PLAN AND SC5.C5_MDNUMED = TFW.TFW_NUMMED AND TFF.TFF_COBCTR <> '2')  OR 
											(TFF.TFF_COBCTR = '2'  AND TCV.TCV_NUMPED = SC5.C5_NUM ) 
										 ) AND   SC5.C5_FILIAL = %xfilial:SC5% AND  SC5.%notDel%  ) 
		INNER JOIN %table:ABS% ABS ON (ABS.ABS_LOCAL = TFL.TFL_LOCAL  AND ABS.ABS_FILIAL = %xfilial:ABS%  AND ABS.%notDel%)
		INNER JOIN %table:SB1% SB1  ON (SB1.B1_COD     = TFF.TFF_PRODUT AND   SB1.B1_FILIAL = %xfilial:SB1% AND  SB1.%notDel%)
		INNER JOIN %table:TFJ% TFJ  ON (TFJ.TFJ_CODIGO = TFL.TFL_CODPAI AND  TFJ.TFJ_FILIAL = %xfilial:TFJ% AND  TFJ.%notDel%)
		LEFT JOIN %table:CXJ% CXJ ON ( CXJ.CXJ_NUMMED = TFW.TFW_NUMMED  AND CXJ.CXJ_NUMPLA =  TFL.TFL_PLAN  AND CXJ.CXJ_ITEMPL = TFW_ITMED AND CXJ.CXJ_NUMPED  = SC5.C5_NUM AND   CXJ.CXJ_FILIAL = %xfilial:CXJ% AND  CXJ.%notDel%)
		LEFT JOIN %table:SC6%  SC6  ON (SC6.C6_NUM  = SC5.C5_NUM     AND   SC6.C6_FILIAL  = %xfilial:SC6% AND  SC6.%notDel% AND SC6.C6_ITEM  = CXJ.CXJ_ITEMPE)
		LEFT JOIN %table:SB1% SB1_C6  ON (SB1_C6.B1_COD    = SC6.C6_PRODUTO AND   SB1_C6.B1_FILIAL = %xfilial:SB1% AND  SB1_C6.%notDel%) 
	WHERE
			 TFV.TFV_CODIGO = %exp:cNumMed%
			AND TFV.TFV_FILIAL =  %xfilial:TFV% 
			AND TFV.%notDel%
			AND (  ( SC6.C6_ITEM = CXJ.CXJ_ITEMPE AND  CXJ.CXJ_NUMPED  = SC6.C6_NUM AND TFF.TFF_COBCTR <> '2' )  OR  TFF.TFF_COBCTR = '2'   ) 
 UNION
 	SELECT 
	 	'2' AS IDENT, 
	 	TFV.TFV_CODIGO AS CODMED, 
	 	TFV.TFV_CONTRT AS CONTRT, 
	 	TFV.TFV_DTAPUR  AS DTAPUR , 
	 	TFL.TFL_CODIGO AS TFLCOD, 
	 	TFL.TFL_LOCAL  AS CODLOC, 
	 	ABS.ABS_DESCRI AS LOCDSC, 
	 	TFX.TFX_CODIGO AS CODGRP, 
	 	TFX.TFX_CODTFF AS CODTFF, 
	 	TFX.TFX_VLRMED  AS VLRMED, 
	 	0 AS VLHORN, 
	 	0 AS VLHORE, 
	 	TFX.TFX_TOTDES AS TOTDES, 
	 	TFX.TFX_TOTMUL AS TOTMUL, 
	 	TFX.TFX_TOTBON AS TOTBON, 
	 	TFG.TFG_PRODUT AS PRDCOD, 
	 	SB1.B1_DESC    AS PRDDSC, 
	 	SC6.C6_ITEM AS ITEM,
	 	TFG.TFG_QTDVEN  AS QTDVEN, 
	 	TFG.TFG_PRCVEN AS PRCVEN ,  
	 	TFJ.TFJ_GRPMI  AS GRPAPR, 
	 	TFJ.TFJ_TESMI  AS TESGRP , 
		SC5.C5_CLIENTE AS CLIENTE,
		CASE WHEN SC6.C6_NUM IS NULL THEN SC5.C5_NUM ELSE SC6.C6_NUM END AS PEDIDO, 
		CASE WHEN SC6.C6_NOTA IS NULL THEN SC5.C5_NOTA ELSE SC6.C6_NOTA	END AS NUMNF,
		CASE WHEN SC6.C6_SERIE IS NULL THEN SC5.C5_SERIE ELSE SC6.C6_SERIE END  AS SERIE,  
		SC6.C6_VALOR ,
		SC6.C6_PRODUTO,
		SB1_C6.B1_DESC,
		SC6.C6_QTDVEN,
		SC6.C6_PRCVEN,
		SC6.C6_TES,
		SC6.C6_PRUNIT,
		SC6.C6_VALDESC,
		SC5.C5_FRETE,
		SC5.C5_SEGURO,
		SC5.C5_FRETAUT,
		SC5.C5_DESPESA,
		SC5.C5_PDESCAB,
		SC5.C5_DESCONT,
		SC5.C5_CONDPAG,
		SC5.C5_CLIENT,
		SC5.C5_LOJAENT,
		%exp:cTamModCob% AS MODCOB,
		SC5.C5_LOJACLI
	FROM 
		%table:TFV%  TFV
		LEFT JOIN %Table:TCV%  TCV ON ( TCV.TCV_NUMAPU = TFV.TFV_CODIGO AND TCV.TCV_FILIAL = %xfilial:TCV%  AND  TCV.%notDel% )
		INNER JOIN %table:TFX% TFX  ON (TFX.TFX_APURAC = TFV.TFV_CODIGO AND  TFX.TFX_FILIAL = %xfilial:TFX% AND  TFX.%notDel%) 
		INNER JOIN %table:TFL% TFL  ON (TFL.TFL_CODIGO = TFX.TFX_CODTFL AND  TFL.TFL_FILIAL = %xfilial:TFL% AND  TFL.%notDel% AND TFL.TFL_CONTRT = TFV.TFV_CONTRT)
		INNER JOIN %table:ABS% ABS ON (ABS.ABS_LOCAL = TFL.TFL_LOCAL  AND ABS.ABS_FILIAL = %xfilial:ABS% AND ABS.%notDel%)
		INNER JOIN %table:TFG% TFG  ON (TFG.TFG_COD    = TFX.TFX_CODTFG AND TFG.TFG_CONTRT = TFV.TFV_CONTRT AND   TFG.TFG_FILIAL = %xfilial:TFG% AND  TFG.%notDel%)
		INNER JOIN %table:SB1% SB1  ON (SB1.B1_COD     = TFG.TFG_PRODUT AND   SB1.B1_FILIAL = %xfilial:SB1% AND  SB1.%notDel%)
		INNER JOIN %table:TFJ% TFJ  ON (TFJ.TFJ_CONTRT = TFL.TFL_CONTRT AND  TFJ.TFJ_FILIAL = %xfilial:TFJ% AND  TFJ.%notDel%)
		INNER JOIN %table:SC5% SC5  ON ( SC5.C5_FILIAL = %xfilial:SC5% AND  SC5.%notDel% AND 
									     ( (SC5.C5_MDCONTR = TFL.TFL_CONTRT AND  SC5.C5_MDPLANI = TFL.TFL_PLAN AND SC5.C5_MDNUMED = TFX.TFX_NUMMED AND TFG.TFG_COBCTR <> '2') OR
									       ( TFG.TFG_COBCTR = '2' AND SC5.C5_NUM = TCV.TCV_NUMPED)
									      ) 
									     )
		LEFT JOIN %table:CXJ% CXJ ON ( CXJ.CXJ_NUMMED = TFX.TFX_NUMMED  AND CXJ.CXJ_NUMPLA =  TFL.TFL_PLAN  AND CXJ.CXJ_ITEMPL = TFX.TFX_ITMED AND CXJ.CXJ_NUMPED  = SC5.C5_NUM AND   CXJ.CXJ_FILIAL = %xfilial:CXJ% AND  CXJ.%notDel%)
		LEFT JOIN %table:SC6%  SC6  ON (SC6.C6_NUM  = SC5.C5_NUM     AND   SC6.C6_FILIAL  = %xfilial:SC6% AND  SC6.%notDel% AND SC6.C6_ITEM  = CXJ.CXJ_ITEMPE)
		LEFT JOIN %table:SB1% SB1_C6  ON (SB1_C6.B1_COD    = SC6.C6_PRODUTO AND   SB1_C6.B1_FILIAL = %xfilial:SB1% AND  SB1_C6.%notDel%) 

	WHERE
		 TFV.TFV_CODIGO = %exp:cNumMed%
		AND TFV.TFV_FILIAL = %xfilial:TFV%
		AND TFV.%notDel%
		AND ( (SC6.C6_ITEM = CXJ.CXJ_ITEMPE AND CXJ.CXJ_NUMPED  = SC6.C6_NUM AND   TFG.TFG_COBCTR <> '2' ) OR TFG.TFG_COBCTR = '2'  )
 UNION
 	SELECT 
		'3' AS IDENT     , 
		TFV.TFV_CODIGO AS CODMED, 
		TFV.TFV_CONTRT AS CONTRT, 
		TFV.TFV_DTAPUR  AS DTAPUR, 
		TFL.TFL_CODIGO AS TFLCOD, 
		TFL.TFL_LOCAL  AS CODLOC, 
		ABS.ABS_DESCRI AS LOCDSC, 
		TFY.TFY_CODIGO AS CODGRP, 
		TFY.TFY_CODTFF AS CODTFF, 
		TFY.TFY_VLRMED  AS VLRMED, 
		0 AS VLHORN, 
		0 AS VLHORE, 
		TFY.TFY_TOTDES AS TOTDES, 
		TFY.TFY_TOTMUL AS TOTMUL, 
		TFY.TFY_TOTBON AS TOTBON, 
		TFH.TFH_PRODUT AS PRDCOD, 
		SB1.B1_DESC    AS PRDDSC, 
		SC6.C6_ITEM AS ITEM, 
		TFH.TFH_QTDVEN  AS QTDVEN, 
		TFH.TFH_PRCVEN AS PRCVEN, 
		TFJ.TFJ_GRPMC  AS GRPAPR, 
		TFJ.TFJ_TESMC  AS TESGRP, 
		SC5.C5_CLIENTE AS CLIENTE,
		CASE WHEN SC6.C6_NUM IS NULL THEN SC5.C5_NUM ELSE SC6.C6_NUM END AS PEDIDO, 
		CASE WHEN SC6.C6_NOTA IS NULL THEN SC5.C5_NOTA ELSE SC6.C6_NOTA	END AS NUMNF,
		CASE WHEN SC6.C6_SERIE IS NULL THEN SC5.C5_SERIE ELSE SC6.C6_SERIE END  AS SERIE, 
		SC6.C6_VALOR ,
		SC6.C6_PRODUTO,
		SB1_C6.B1_DESC,
		SC6.C6_QTDVEN,
		SC6.C6_PRCVEN,
		SC6.C6_TES,
		SC6.C6_PRUNIT,
		SC6.C6_VALDESC,
		SC5.C5_FRETE,
		SC5.C5_SEGURO,
		SC5.C5_FRETAUT,
		SC5.C5_DESPESA,
		SC5.C5_PDESCAB,
		SC5.C5_DESCONT,
		SC5.C5_CONDPAG,
		SC5.C5_CLIENT,
		SC5.C5_LOJAENT,
		%exp:cTamModCob% AS MODCOB,
		SC5.C5_LOJACLI
	FROM 
		%table:TFV%  TFV
		LEFT JOIN %Table:TCV%  TCV ON ( TCV.TCV_NUMAPU = TFV.TFV_CODIGO AND TCV.TCV_FILIAL = %xfilial:TCV%  AND  TCV.%notDel% )
		INNER JOIN %table:TFY% TFY  ON (TFY.TFY_APURAC = TFV.TFV_CODIGO AND  TFY.TFY_FILIAL = %xfilial:TFY% AND  TFY.%notDel%)
		INNER JOIN %table:TFL% TFL  ON (TFL.TFL_CODIGO = TFY.TFY_CODTFL AND  TFL.TFL_FILIAL = %xfilial:TFL% AND  TFL.%notDel% AND 
										TFL.TFL_CONTRT = TFV.TFV_CONTRT)
		INNER JOIN %table:ABS% ABS ON (ABS.ABS_LOCAL = TFL.TFL_LOCAL  AND ABS.ABS_FILIAL = %xfilial:ABS% AND ABS.%notDel%)
		INNER JOIN %table:TFH% TFH  ON (TFH.TFH_COD    = TFY.TFY_CODTFH AND TFH.TFH_CONTRT = TFV.TFV_CONTRT AND  TFH.TFH_FILIAL = %xfilial:TFH% AND  TFH.%notDel%)
		INNER JOIN %table:SB1% SB1  ON (SB1.B1_COD     = TFH.TFH_PRODUT AND   SB1.B1_FILIAL = %xfilial:SB1% AND  SB1.%notDel%)
		INNER JOIN %table:TFJ% TFJ  ON (TFJ.TFJ_CONTRT = TFL.TFL_CONTRT AND  TFJ.TFJ_FILIAL = %xfilial:TFJ% AND  TFJ.%notDel%)
		INNER JOIN %table:SC5% SC5  ON (   SC5.C5_FILIAL = %xfilial:SC5% AND  SC5.%notDel% AND 
										(
		                                 ( SC5.C5_MDCONTR = TFL.TFL_CONTRT AND SC5.C5_MDPLANI = TFL.TFL_PLAN AND SC5.C5_MDNUMED = TFY.TFY_NUMMED AND TFH.TFH_COBCTR <> '2') OR
		                                 ( TFH.TFH_COBCTR = '2' AND TCV.TCV_NUMPED = SC5.C5_NUM )
		                                 )
		                                )
		LEFT JOIN %table:CXJ% CXJ ON ( CXJ.CXJ_NUMMED = TFY.TFY_NUMMED  AND CXJ.CXJ_NUMPLA =  TFL.TFL_PLAN  AND CXJ.CXJ_ITEMPL = TFY.TFY_ITMED AND CXJ.CXJ_NUMPED  = SC5.C5_NUM AND   CXJ.CXJ_FILIAL = %xfilial:CXJ% AND  CXJ.%notDel%)
		LEFT JOIN %table:SC6%  SC6  ON (SC6.C6_NUM  = SC5.C5_NUM     AND   SC6.C6_FILIAL  = %xfilial:SC6% AND  SC6.%notDel% AND SC6.C6_ITEM  = CXJ.CXJ_ITEMPE)
		LEFT JOIN %table:SB1% SB1_C6  ON (SB1_C6.B1_COD    = SC6.C6_PRODUTO AND   SB1_C6.B1_FILIAL = %xfilial:SB1% AND  SB1_C6.%notDel%) 
	WHERE	
		TFV.TFV_CODIGO = %exp:cNumMed%
		AND TFV.TFV_FILIAL = %xfilial:TFV%
		AND TFV.%notDel%
		AND  ( (SC6.C6_ITEM = CXJ.CXJ_ITEMPE AND CXJ.CXJ_NUMPED  = SC6.C6_NUM AND  TFH.TFH_COBCTR <> '2' ) OR TFH.TFH_COBCTR = '2'  )
 UNION
	 SELECT  
		'4' AS IDENT     , 
		TFV.TFV_CODIGO AS CODMED, 
		TFV.TFV_CONTRT AS CONTRT, 
		TFV.TFV_DTAPUR  AS DTAPUR, 
		TFL.TFL_CODIGO AS TFLCOD, 
		TFL.TFL_LOCAL  AS CODLOC, 
		ABS.ABS_DESCRI AS LOCDSC, 
		TFZ.TFZ_CODIGO AS CODGRP, 
		TFI.TFI_LOCAL  AS CODTFF, 
		TFZ.TFZ_TOTAL   AS VLRMED, 
		0 AS VLHORN, 
		0 AS VLHORE, 
		TW6.TOTDES, 
		TW7_MUL.TOTMUL, 
		TW7_BON.TOTBON, 
		TFI.TFI_PRODUT AS PRDCOD, 
		SB1.B1_DESC    AS PRDDSC, 
		SC6.C6_ITEM AS ITEM,
		TFZ.TFZ_QTDAPU  AS QTDVEN, 
		0 AS PRCVEN, 
		TFJ.TFJ_GRPLE  AS GRPAPR, 
		TFJ.TFJ_TESLE  AS TESGRP, 
		SC5.C5_CLIENTE AS CLIENTE,
		CASE WHEN SC6.C6_NUM IS NULL THEN SC5.C5_NUM ELSE SC6.C6_NUM END AS PEDIDO, 
		CASE WHEN SC6.C6_NOTA IS NULL THEN SC5.C5_NOTA ELSE SC6.C6_NOTA	END AS NUMNF,
		CASE WHEN SC6.C6_SERIE IS NULL THEN SC5.C5_SERIE ELSE SC6.C6_SERIE END  AS SERIE,
		SC6.C6_VALOR ,
		SC6.C6_PRODUTO,
		SB1_C6.B1_DESC,
		SC6.C6_QTDVEN,
		SC6.C6_PRCVEN,
		SC6.C6_TES,
		SC6.C6_PRUNIT,
		SC6.C6_VALDESC,
		SC5.C5_FRETE,
		SC5.C5_SEGURO,
		SC5.C5_FRETAUT,
		SC5.C5_DESPESA,
		SC5.C5_PDESCAB,
		SC5.C5_DESCONT,
		SC5.C5_CONDPAG,
		SC5.C5_CLIENT,
		SC5.C5_LOJAENT,
		TFZ.TFZ_MODCOB AS MODCOB,
		SC5.C5_LOJACLI
	FROM
		%table:TFV% TFV
		INNER JOIN %table:TFZ% TFZ  ON (TFZ.TFZ_APURAC = TFV.TFV_CODIGO AND  TFZ.TFZ_FILIAL = %xfilial:TFZ% AND  TFZ.%notDel%)
		INNER JOIN %table:TFI% TFI  ON (TFI.TFI_COD    = TFZ.TFZ_CODTFI AND  TFI.TFI_FILIAL = %xfilial:TFI% AND  TFI.%notDel%)
		INNER JOIN %table:TFL% TFL  ON (TFL.TFL_CODIGO = TFZ.TFZ_CODTFL AND  TFL.TFL_FILIAL = %xfilial:TFL% AND  TFL.%notDel% AND 
										TFL.TFL_CONTRT = TFV.TFV_CONTRT)
		INNER JOIN %table:ABS% ABS ON (ABS.ABS_LOCAL = TFL.TFL_LOCAL  AND ABS.ABS_FILIAL = %xfilial:ABS% AND ABS.%notDel%)
		INNER JOIN %table:SB1% SB1  ON (SB1.B1_COD     = TFI.TFI_PRODUT AND   SB1.B1_FILIAL = %xfilial:SB1% AND  SB1.%notDel%)
		INNER JOIN %table:TFJ% TFJ  ON (TFJ.TFJ_CONTRT = TFL.TFL_CONTRT AND  TFJ.TFJ_FILIAL = %xfilial:TFJ% AND  TFJ.%notDel%)
		INNER JOIN %table:SC5% SC5  ON (SC5.C5_MDCONTR = TFL.TFL_CONTRT AND   SC5.C5_FILIAL = %xfilial:SC5% AND  SC5.%notDel% AND 
										SC5.C5_MDPLANI = TFL.TFL_PLAN AND SC5.C5_MDNUMED = TFZ.TFZ_NUMMED)
		INNER JOIN %table:CXJ% CXJ ON ( CXJ.CXJ_NUMMED = TFZ.TFZ_NUMMED  AND CXJ.CXJ_NUMPLA =  TFL.TFL_PLAN  AND CXJ.CXJ_ITEMPL = TFZ.TFZ_ITMED AND CXJ.CXJ_NUMPED  = SC5.C5_NUM AND   CXJ.CXJ_FILIAL = %xfilial:CXJ% AND  CXJ.%notDel%)
		INNER JOIN %table:SC6%  SC6  ON (SC6.C6_NUM  = SC5.C5_NUM     AND   SC6.C6_FILIAL  = %xfilial:SC6% AND  SC6.%notDel% AND SC6.C6_ITEM  = CXJ.CXJ_ITEMPE)
		INNER JOIN %table:SB1% SB1_C6  ON (SB1_C6.B1_COD    = SC6.C6_PRODUTO AND   SB1_C6.B1_FILIAL = %xfilial:SB1% AND  SB1_C6.%notDel%) 	 		
		LEFT JOIN   (	SELECT TW7_CODPAI , SUM(TW7_VALOR)	AS TOTMUL
											FROM
											 %table:TW7%  TW7
											WHERE
											TW7.TW7_FILIAL = %xfilial:TW7%
											AND TW7.TW7_TPMOV = '1'
											AND TW7.%notDel%
											AND TW7.TW7_TPPAI = 'LE' GROUP BY TW7_CODPAI) TW7_MUL ON TW7_MUL.TW7_CODPAI = TFI.TFI_COD
		LEFT JOIN   (	SELECT TW7_CODPAI , SUM(TW7_VALOR)	AS TOTBON
											FROM
											 %table:TW7%  TW7
											WHERE
											TW7.TW7_FILIAL = %xfilial:TW7%
											AND TW7.TW7_TPMOV <> '1'
											AND TW7.%notDel%
											AND TW7.TW7_TPPAI = 'LE' GROUP BY TW7_CODPAI) TW7_BON  ON TW7_BON.TW7_CODPAI = TFI.TFI_COD											
		LEFT JOIN   (	SELECT TW6_CODPAI , SUM(TW6_VALOR)	AS TOTDES
											FROM %table:TW6%  TW6
											WHERE
											TW6.TW6_FILIAL = %xfilial:TW6%
											AND TW6.%notDel%
											AND TW6.TW6_TPPAI = 'LE'  GROUP BY TW6_CODPAI) TW6  ON TW6.TW6_CODPAI = TFI.TFI_COD	 
	 WHERE
		 TFV.TFV_CODIGO = %exp:cNumMed%
		AND TFV.TFV_FILIAL = %xfilial:TFV%
		AND TFV.%notDel%
 UNION
 	SELECT
		'5' AS IDENT     , 
		TFV.TFV_CODIGO AS CODMED, 
		TFV.TFV_CONTRT AS CONTRT, 
		TFV.TFV_DTAPUR  AS DTAPUR, 
		TFL.TFL_CODIGO AS TFLCOD, 
		TFL.TFL_LOCAL  AS CODLOC,
		 ABS.ABS_DESCRI AS LOCDSC, 
		TW7.TW7_CODIGO AS CODGRP, 
		TFW.TFW_CODTFF  AS CODTFF, 
		TW7.TW7_VALOR   AS VLRMED, 
		0 AS VLHORN, 
		0 AS VLHORE, 
		0 AS TOTDES, 
		0 AS TOTMUL, 
		0 AS TOTBON, 
		TW7.TW7_CODMOV AS PRDCOD, 
		TW7.TW7_DESCRI AS PRDDSC, 
		SC6.C6_ITEM AS ITEM,
		0 AS QTDVEN , 
		0 AS PRCVEN, 
		TFJ.TFJ_GRPLE  AS GRPAPR, 
		TFJ.TFJ_TESLE  AS TESGRP, 
		SC5.C5_CLIENTE AS CLIENTE,
		CASE WHEN SC6.C6_NUM IS NULL THEN SC5.C5_NUM ELSE SC6.C6_NUM END AS PEDIDO, 
		CASE WHEN SC6.C6_NOTA IS NULL THEN SC5.C5_NOTA ELSE SC6.C6_NOTA	END AS NUMNF,
		CASE WHEN SC6.C6_SERIE IS NULL THEN SC5.C5_SERIE ELSE SC6.C6_SERIE END  AS SERIE,
		SC6.C6_VALOR ,
		SC6.C6_PRODUTO,
		SB1_C6.B1_DESC,
		SC6.C6_QTDVEN,
		SC6.C6_PRCVEN,
		SC6.C6_TES,
		SC6.C6_PRUNIT,
		SC6.C6_VALDESC,
		SC5.C5_FRETE,
		SC5.C5_SEGURO,
		SC5.C5_FRETAUT,
		SC5.C5_DESPESA,
		SC5.C5_PDESCAB,
		SC5.C5_DESCONT,
		SC5.C5_CONDPAG,
		SC5.C5_CLIENT,
		SC5.C5_LOJAENT,
		%exp:cTamModCob% AS MODCOB,
		SC5.C5_LOJACLI
	FROM 
		%table:TW7% TW7 
		INNER JOIN %table:TFW% TFW  ON (TFW.TFW_CODIGO = TW7.TW7_CODPAI AND  TFW.TFW_FILIAL = %xfilial:TFW% AND  TFW.%notDel%)
		INNER JOIN %table:TFV% TFV  ON (TFV.TFV_CODIGO = TFW.TFW_APURAC AND  TFV.TFV_FILIAL = %xfilial:TFV% AND  TFV.%notDel% AND 
										TFV.TFV_CODIGO = %exp:cNumMed% )
		INNER JOIN %table:TFL% TFL  ON (TFL.TFL_CODIGO = TFW.TFW_CODTFL AND  TFL.TFL_FILIAL = %xfilial:TFL% AND  TFL.%notDel% AND 
										TFL.TFL_CONTRT = TFV.TFV_CONTRT)
		INNER JOIN %table:ABS% ABS ON (ABS.ABS_LOCAL = TFL.TFL_LOCAL  AND ABS.ABS_FILIAL = %xfilial:ABS% AND ABS.%notDel%)
		INNER JOIN %table:TFJ% TFJ  ON (TFJ.TFJ_CONTRT = TFL.TFL_CONTRT AND  TFJ.TFJ_FILIAL = %xfilial:TFJ% AND  TFJ.%notDel%)
		INNER JOIN %table:SC5% SC5  ON (SC5.C5_MDCONTR = TFL.TFL_CONTRT AND   SC5.C5_FILIAL = %xfilial:SC5% AND  SC5.%notDel% AND 
										SC5.C5_MDPLANI = TFL.TFL_PLAN AND SC5.C5_MDNUMED = TFW.TFW_NUMMED)
		INNER JOIN %table:CXJ% CXJ ON ( CXJ.CXJ_NUMMED = TFW.TFW_NUMMED  AND CXJ.CXJ_NUMPLA =  TFL.TFL_PLAN  AND CXJ.CXJ_ITEMPL = TFW.TFW_ITMED AND CXJ.CXJ_NUMPED  = SC5.C5_NUM AND   CXJ.CXJ_FILIAL = %xfilial:CXJ% AND  CXJ.%notDel%)
		INNER JOIN %table:SC6%  SC6  ON (SC6.C6_NUM  = SC5.C5_NUM     AND   SC6.C6_FILIAL  = %xfilial:SC6% AND  SC6.%notDel% AND SC6.C6_ITEM  = CXJ.CXJ_ITEMPE)
		INNER JOIN %table:SB1% SB1_C6  ON (SB1_C6.B1_COD    = SC6.C6_PRODUTO AND   SB1_C6.B1_FILIAL = %xfilial:SB1% AND  SB1_C6.%notDel%) 

		
	WHERE
		TW7.TW7_FILIAL = %xfilial:TW7%
		%exp:cDesPad%
		AND TW7.%notDel%
		AND TW7.TW7_TPPAI  = %exp:cPaiRH%
 UNION
 	SELECT
		'5' AS IDENT     , 
		TFV.TFV_CODIGO AS CODMED, 
		TFV.TFV_CONTRT AS CONTRT, 
		TFV.TFV_DTAPUR  AS DTAPUR, 
		TFL.TFL_CODIGO AS TFLCOD, 
		TFL.TFL_LOCAL  AS CODLOC, 
		ABS.ABS_DESCRI AS LOCDSC, 
		TW7.TW7_CODIGO AS CODGRP, 
		TFI.TFI_LOCAL  AS CODTFF, 
		TW7.TW7_VALOR   AS VLRMED, 
		0 AS VLHORN, 
		0 AS VLHORE, 
		0 AS TOTDES, 
		0 AS TOTMUL, 
		0 AS TOTBON, 
		TW7.TW7_CODMOV AS PRDCOD, 
		TW7.TW7_DESCRI AS PRDDSC, 
		SC6.C6_ITEM AS ITEM, 
		0 AS QTDVEN, 
		0 AS PRCVEN, 
		TFJ.TFJ_GRPLE  AS GRPAPR, 
		TFJ.TFJ_TESLE  AS TESGRP, 
		SC5.C5_CLIENTE AS CLIENTE,
		CASE WHEN SC6.C6_NUM IS NULL THEN SC5.C5_NUM ELSE SC6.C6_NUM END AS PEDIDO, 
		CASE WHEN SC6.C6_NOTA IS NULL THEN SC5.C5_NOTA ELSE SC6.C6_NOTA	END AS NUMNF,
		CASE WHEN SC6.C6_SERIE IS NULL THEN SC5.C5_SERIE ELSE SC6.C6_SERIE END  AS SERIE,
		SC6.C6_VALOR ,
		SC6.C6_PRODUTO,
		SB1_C6.B1_DESC,
		SC6.C6_QTDVEN,
		SC6.C6_PRCVEN,
		SC6.C6_TES,
		SC6.C6_PRUNIT,
		SC6.C6_VALDESC,
		SC5.C5_FRETE,
		SC5.C5_SEGURO,
		SC5.C5_FRETAUT,
		SC5.C5_DESPESA,
		SC5.C5_PDESCAB,
		SC5.C5_DESCONT,
		SC5.C5_CONDPAG,
		SC5.C5_CLIENT,
		SC5.C5_LOJAENT,
		%exp:cTamModCob% AS MODCOB,
		SC5.C5_LOJACLI
	FROM
		%table:TW7% TW7
		INNER JOIN %table:TFZ% TFZ  ON (TFZ.TFZ_CODIGO = TW7.TW7_CODIGO AND  TFZ.TFZ_FILIAL = %xfilial:TFZ% AND  TFZ.%notDel%)
		INNER JOIN %table:TFI% TFI  ON (TFI.TFI_COD    = TFZ.TFZ_CODTFI AND  TFI.TFI_FILIAL = %xfilial:TFI% AND  TFI.%notDel%)
		INNER JOIN %table:TFV% TFV  ON (TFV.TFV_CODIGO = TFZ.TFZ_APURAC AND  TFV.TFV_FILIAL = %xfilial:TFV% AND  TFV.%notDel% AND 
										TFV.TFV_CODIGO = %Exp:cNumMed% )
		INNER JOIN %table:TFL% TFL  ON (TFL.TFL_CODIGO = TFZ.TFZ_CODTFL AND  TFL.TFL_FILIAL = %xfilial:TFL% AND  TFL.%notDel% AND 
										TFL.TFL_CONTRT = TFV.TFV_CONTRT)
		INNER JOIN %table:ABS% ABS ON (ABS.ABS_LOCAL = TFL.TFL_LOCAL  AND ABS.ABS_FILIAL = %xfilial:ABS% AND ABS.%notDel%)
		INNER JOIN %table:TFJ% TFJ  ON (TFJ.TFJ_CONTRT = TFL.TFL_CONTRT AND  TFJ.TFJ_FILIAL = %xfilial:TFJ% AND  TFJ.%notDel%)
		INNER JOIN %table:SC5% SC5  ON (SC5.C5_MDCONTR = TFL.TFL_CONTRT AND   SC5.C5_FILIAL = %xfilial:SC5% AND  SC5.%notDel% AND 
										SC5.C5_MDPLANI = TFL.TFL_PLAN AND SC5.C5_MDNUMED = TFZ.TFZ_NUMMED)
		INNER JOIN %table:CXJ% CXJ ON ( CXJ.CXJ_NUMMED = TFZ.TFZ_NUMMED  AND CXJ.CXJ_NUMPLA =  TFL.TFL_PLAN  AND CXJ.CXJ_ITEMPL = TFZ.TFZ_ITMED AND CXJ.CXJ_NUMPED  = SC5.C5_NUM AND   CXJ.CXJ_FILIAL = %xfilial:CXJ% AND  CXJ.%notDel%)
		INNER JOIN %table:SC6%  SC6  ON (SC6.C6_NUM  = SC5.C5_NUM     AND   SC6.C6_FILIAL  = %xfilial:SC6% AND  SC6.%notDel% AND SC6.C6_ITEM  = CXJ.CXJ_ITEMPE)
		INNER JOIN %table:SB1% SB1_C6  ON (SB1_C6.B1_COD    = SC6.C6_PRODUTO AND   SB1_C6.B1_FILIAL = %xfilial:SB1% AND  SB1_C6.%notDel%) 
	WHERE
		TW7.TW7_FILIAL = %xfilial:TW7%
		%exp:cDesPad%
		AND TW7.%notDel%
		AND TW7.TW7_TPPAI = %exp:cPaiLE% 
				
 ORDER BY CODMED, NUMNF, SERIE, PEDIDO, CODLOC, ITEM,  IDENT 
 
EndSql 

END REPORT QUERY oSection1
QRYSQL->(DbGoTop())

While !QRYSQL->(EOF())

	
	If cQbrSec1 <> QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC)
	
		R930FSec(lImpImp, cQbrSec1, cQbrSecPed, "", ;
				@aImpostos, oSection0, oSection00, oSection01,;
				oSection1)
				
		oSection0:Init()
		oSection0:PrintLine()

		cQbrSec1 := QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC)
		cQbrSecPed:= ""

	Else
		While QRYSQL->(!Eof() .AND. NUMNF +SERIE+ PEDIDO+CODLOC == cQbrSec1)
		
			If cQbrSecPed <> QRYSQL->ITEM

				oSection1:Init()
			    If lImpImp .AND. !Empty(QRYSQL->ITEM)
			    	
			    
			    	aImp := R930AImp('IT_VALINS',QRYSQL->PEDIDO,QRYSQL->ITEM,"QRYSQL", {"IT_VALINS", "IT_VALIRR", "IT_VALISS", "IT_VALPIS", "IT_VALCOF", "IT_VALCSL", "IT_TOTAL"}, cQbrSec1, cNFAtu, aImpostos, aFisGet, aFisGetSC5)
			    	
			    	cNFAtu := cQbrSec1
					oSection1:Cell("nIns"):SetValue(aImp[01])
					oSection1:Cell("nIr"):SetValue(aImp[02])
					oSection1:Cell("nIss"):SetValue(aImp[03])
					oSection1:Cell("nPis"):SetValue(aImp[04])
					oSection1:Cell("nCof"):SetValue(aImp[05])
					oSection1:Cell("nCsl"):SetValue(aImp[06])
					oSection1:Cell("nImp"):SetValue(aImp[07] )	
					nTotSImp  := aImp[07]- (aImp[01]+aImp[02]+aImp[03]+aImp[04]+aImp[05]+aImp[06])					
					oSection1:Cell("nTotSImp"):SetValue(nTotSImp)
					
					oSection1:Printline()
		
				EndIf

				oReport:SkipLine(1)
				

				cQbrSecPed := QRYSQL->ITEM
			Else
				Do While !QRYSQL->(EOF()) .AND. QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .and. cQbrSecPed == QRYSQL->ITEM
		
					If QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND. AllTrim(QRYSQL->IDENT) == '1'
						oSection30:Init()
						oSection30:Cell("IDENT"):SetValue(aIdent[Val(QRYSQL->IDENT)])
						oSection30:PrintLine()
						
						oSection31:Init()
						While !QRYSQL->(EOF()) .AND.   QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND.  AllTrim(QRYSQL->IDENT) == '1'
							oSection31:Printline()
							
							QRYSQL->(DbSkip())
						EndDo
						
						oSection31:Finish()
						oSection30:Finish()
						oReport:SkipLine(2)		
					EndIf
				
					If QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND. AllTrim(QRYSQL->IDENT) == '2'
						oSection40:Init()
						oSection40:Cell("IDENT"):SetValue(aIdent[Val(QRYSQL->IDENT)])
						oSection40:PrintLine()
						
						oSection41:Init()
						While !QRYSQL->(EOF()) .AND.  QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND. AllTrim(QRYSQL->IDENT) == '2'
							oSection41:Printline()
							
							//Impressão de Kit de Materiais
							If lTWX .AND. Posicione('SB1', 1, xFilial('SB1') + QRYSQL->PRDCOD , 'B1_TIPO') == 'KT'
								TWX->(DbSetOrder(1))
								If TWX->(DbSeek(xFilial('TWX') + QRYSQL->PRDCOD ))
									While TWX->(!EOF()) .And. xFilial('TWX') + TWX->TWX_KITPRO == xFilial('TWX') + QRYSQL->PRDCOD
										oSection42:Init()
										oSection42:Cell("PRDCOD"):SetValue(TWX->TWX_CODPRO)
										oSection42:Cell("PRDDSC"):SetValue(Posicione('SB1', 1, xFilial('SB1') + TWX->TWX_CODPRO , 'B1_DESC'))
										oSection42:Cell("QTDVEN"):SetValue(TWX->TWX_QUANT)
										
										oSection42:PrintLine()						
										
										TWX->(DbSkip())
									EndDo
				
									oReport:SkipLine()
									oSection42:Finish()
								EndIf
							EndIf
							QRYSQL->(DbSkip())
						EndDo
						
						oSection41:Finish()
						oSection40:Finish()
						oReport:SkipLine(2)		
					EndIf
					
					
					If QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND. AllTrim(QRYSQL->IDENT) == '3'
						oSection50:Init()
						oSection50:Cell("IDENT"):SetValue(aIdent[Val(QRYSQL->IDENT)])
						oSection50:PrintLine()
						
						oSection51:Init()
						While !QRYSQL->(EOF()) .AND. QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND.  AllTrim(QRYSQL->IDENT) == '3'
							oSection51:Printline()
							
							//Impressão de Kit de Materiais
							If lTWX .AND. Posicione('SB1', 1, xFilial('SB1') + QRYSQL->PRDCOD , 'B1_TIPO') == 'KT'
								TWX->(DbSetOrder(1))
								If TWX->(DbSeek(xFilial('TWX') + QRYSQL->PRDCOD ))
									While TWX->(!EOF()) .And. xFilial('TWX') + TWX->TWX_KITPRO == xFilial('TWX') + QRYSQL->PRDCOD
										oSection52:Init()
										oSection52:Cell("PRDCOD"):SetValue(TWX->TWX_CODPRO)
										oSection52:Cell("PRDDSC"):SetValue(Posicione('SB1', 1, xFilial('SB1') + TWX->TWX_CODPRO , 'B1_DESC'))
										oSection52:Cell("QTDVEN"):SetValue(TWX->TWX_QUANT)
										
										oSection52:PrintLine()						
										
										TWX->(DbSkip())
									EndDo
									
									oReport:SkipLine()
									oSection52:Finish()
								EndIf
							EndIf
							QRYSQL->(DbSkip())
						EndDo
						
						oSection51:Finish()
						oSection50:Finish()
						oReport:SkipLine(2)		
					EndIf
					
					If QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND. AllTrim(QRYSQL->IDENT) == '4'
						oSection60:Init()
						oSection60:Cell("IDENT"):SetValue(aIdent[Val(QRYSQL->IDENT)])
						oSection60:PrintLine()
						
						oSection61:Init()
						While !QRYSQL->(EOF()) .AND. QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND.  AllTrim(QRYSQL->IDENT) == '4'
				
							oSection61:Printline()
							
							QRYSQL->(DbSkip())
						EndDo
						
						oSection61:Finish()
						oSection60:Finish()
						oReport:SkipLine(2)		
					EndIf	
					
					If !QRYSQL->(EOF()) .AND. QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND. AllTrim(QRYSQL->IDENT) == '5'
						oSection70:Init()
						oSection70:Cell("IDENT"):SetValue(aIdent[Val(QRYSQL->IDENT)])
						oSection70:PrintLine()
						
						oSection71:Init()
						While QRYSQL->(NUMNF +SERIE+ PEDIDO+CODLOC) == cQbrSec1 .AND. cQbrSecPed == QRYSQL->ITEM .AND. AllTrim(QRYSQL->IDENT) == '5'
		
							oSection71:Printline()
							
							QRYSQL->(DbSkip())
						EndDo
						
						oSection71:Finish()
						oSection70:Finish()
						oReport:SkipLine(2)		
					EndIf	
				EndDo
			EndIf
		EndDo
	EndIf
Enddo	

R930FSec(lImpImp, cQbrSec1, cQbrSecPed, cNFAtu, ;
		aImpostos, oSection0, oSection00, oSection01,;
		oSection1)

oReport:SetMeter(QRYSQL->(LastRec()))
 
Return(oReport)

/*/{Protheus.doc} R930FSec
Finaliza e imprime as quebras do pedido/NF
@author 	fabiana.silva
@since 		03/06/2019
@version 	12.1.23
/*/
Static Function R930FSec(lImpImp, cQbrSec1, cQbrSecPed, cNFAtu, aImpostos, oSection0, oSection00, oSection01,oSection1)
Local nC := 0

	If !Empty(cQbrSecPed)
		oSection1:Finish()
	EndIf
	
	If !Empty(cQbrSec1)
		//Imprime o totalizador dos impostos
		If lImpImp .AND. Len(aImpostos) > 0
			oSection00:Init()
			oSection00:Cell("DESCR"):SetValue("Total de Impostos")
			oSection00:PrintLine()
				oSection01:Init()
				For nC := 1 to Len(aImpostos)
					oSection01:Cell("SIGLA"):SetValue(aImpostos[nC, 01])
					oSection01:Cell("BASE"):SetValue(aImpostos[nC, 03])
					oSection01:Cell("VALOR"):SetValue(aImpostos[nC, 04])
					If !Empty(aImpostos[nC, 03]) .OR. !Empty(aImpostos[nC, 04])
						oSection01:PrintLine()
					EndIf
				Next nC
				aImpostos := {}
				oSection01:Finish()
			oSection00:Finish()

		EndIf
		oSection0:Finish()
	EndIf	
	
	If !Empty(cNFAtu)
		MaFisEnd()
	EndIf
Return


/*/{Protheus.doc} R930AImp
Retorna o valor dos impostos do pedido de venda
@author 	fabiana.silva
@since 		03/06/2019
@version 	12.1.23
/*/
Static Function R930AImp(cRef , cPedido , cItem, cAliasIt, aRef, cQbrSec1, cNFAtu, aImpostos, aFisGet, aFisGetSC5)
Local nImp 		:= 0
Local nItem     := 0
Local nQtdPeso  := 0
Local nValMerc  := 0
Local nPrcLista := 0
Local nAcresFin := 0
Local nDesconto := 0
Local xRet      
Local aArea     := GetArea()
Local aAreaSA1  := SA1->(GetArea())
Local nPos		:= 0
Local nC		:= 0
Local aRet		:= {0, 0, 0, 0,0, 0, 0}
Local nY		:= 0
Local nFisGet		:= 0
Local nFisGetSC5 := 0
Local uValue := 0
Local cProduto := ""
Local nVMercAux := 0
Local nPrcLsAux := 0
Local nAliqISS := 0
Local lRndIss   := SuperGetMv("MV_RNDISS",,.F.)
Local lDescISS	:= SuperGetMV("MV_DESCISS",,.F.)
Local lTpAbISS	:= SuperGetMV("MV_TPABISS",,"") == "1"
Local nValISS := 0
Local nVRetISS	:= SuperGetMV("MV_VRETISS",,0)
Local nISSNDesc := 0
Local nTotTit := 0


Default aFisGet := 0
Default nFisGetSC5 := 0

nFisGet		:= Len(aFisGet)
nFisGetSC5 := Len(aFisGetSC5)

If cQbrSec1 <>  cNFAtu
	SA1->(DbSetOrder(1)) //--A1_FILIAL+A1_COD+A1_LOJA
	SA1->(DbSeek(xFilial('SA1')+(cAliasIt)->(iif(Empty(C5_CLIENT) .And. Empty(C5_LOJAENT), CLIENTE+C5_LOJACLI, C5_CLIENT+C5_LOJAENT))))
	
	SE4->(DbSetOrder(1)) //--E4_FILIAL+E4_CODIGO
	SE4->(DbSeek(xFilial('SE4')+(cAliasIt)->C5_CONDPAG))

	aImpostos := {}
	MaFisSave()
	MaFisEnd()
	
	SC5->(DbSetOrder(1)) //--C5_FILIAL+C5_NUM
	
	SC6->(DbSetOrder(1)) //--C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
	If SC5->(DbSeek(xFilial('SC5')+cPedido)) .AND. SC6->(DbSeek(xFilial('SC6')+cPedido))
	
		MaFisIni(SA1->A1_COD,;		// 1-Codigo Cliente/Fornecedor
					SA1->A1_LOJA,;	// 2-Loja do Cliente/Fornecedor
					IIf(SC5->C5_TIPO$'DB',"F","C"),;															// 3-C:Cliente , F:Fornecedor
					SC5->C5_TIPO,;															// 4-Tipo da NF
					SC5->C5_TIPOCLI,;													// 5-Tipo do Cliente/Fornecedor
					NIL,;
					NIL,;
					NIL,;
					NIL,;
					"MATA461",;
					Nil,;
					Nil,;
					Nil,;
					Nil,;
					Nil,;
					Nil,;
					Nil,;
					NIL,;
					Nil,;
					Nil,;
					SC5->C5_NUM,;
					SC5->C5_CLIENTE,;
					SC5->C5_LOJACLI,;
					NIL,;
					Nil,;
					SC5->C5_TPFRETE)
	
	   For nY := 1 to nFisGetSC5
            If !Empty(uValue := SC5->(FieldGet(FieldPos(aFisGetSC5[nY][2]))))
                If aFisGetSC5[ny][1] == "NF_SUFRAMA"
                    MaFisAlt(aFisGetSC5[nY][1],Iif(uValue == "1",.T.,.F.),0,.T.)        
                Else
                    MaFisAlt(aFisGetSC5[nY][1],uValue,0,.T.)
                Endif    
            EndIf
        Next nY
        

		If SuperGetMV("MV_ISSXMUN",.F.,.F.)
			If !Empty(M->C5_MUNPRES)
				MaFisLoad("NF_CODMUN",AllTrim(M->C5_MUNPRES))
			EndIf
			
			If !Empty(M->C5_ESTPRES)
				MaFisLoad("NF_UFPREISS",AllTrim(M->C5_ESTPRES))
			EndIf
		EndIf
	
		Do While SC6->(!Eof() .AND. C6_NUM = cPedido)
		
		
			cProduto := SC6->C6_PRODUTO
			MatGrdPrRf(@cProduto)
			SB1->(dbSetOrder(1))
			If !SB1->(MsSeek(xFilial("SB1")+cProduto))
				SB1->(MsSeek(xFilial("SB1")+SC6->C6_PRODUTO))
			EndIf
			
			SF4->(DbSeek(xFilial('SF4')+SC6->C6_TES))
			
			nItem := Val(SC6->C6_ITEM)
		
			nValMerc  := SC6->C6_VALOR
			If SC6->C6_PRUNIT == 0
				nPrcLista := A410Arred(nValMerc / SC6->C6_QTDVEN, 'C6_PRCVEN')
			Else
				nPrcLista := SC6->C6_PRUNIT
			EndIf
		
		
			nAcresFin := A410Arred((SC6->C6_PRCVEN*SE4->E4_ACRSFIN)/100, 'D2_PRCVEN')
			nValMerc  += A410Arred(nAcresFin, 'D2_TOTAL')
			nDesconto := A410Arred(nPrcLista, 'D2_DESCON') - nValMerc
			nDesconto := If(nDesconto == 0, SC6->C6_VALDESC, nDesconto)
			nDesconto := Max(0,nDesconto)
			nPrcLista += nAcresFin
			nValMerc  += nDesconto
		
		



		
		
			// ------------------------------------
			// AGREGA OS ITENS PARA A FUNCAO FISCAL
			// ------------------------------------
			MaFisAdd(	SC6->C6_PRODUTO,;  	// 1-Codigo do Produto ( Obrigatorio )
						SC6->C6_TES,;	   	// 2-Codigo do TES ( Opcional )
						SC6->C6_QTDVEN,;  	// 3-Quantidade ( Obrigatorio )
						nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
						nDesconto,;  		// 5-Valor do Desconto ( Opcional )
						"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
						"",;				// 7-Serie da NF Original ( Devolucao/Benef )
						0,;					// 8-RecNo da NF Original no arq SD1/SD2
						0,;					// 9-Valor do Frete do Item ( Opcional )
						0,;					// 10-Valor da Despesa do item ( Opcional )
						0,;					// 11-Valor do Seguro do item ( Opcional )
						0,;					// 12-Valor do Frete Autonomo ( Opcional )
						nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
						0,;					// 14-Valor da Embalagem ( Opiconal )
						,;					// 15
						,;					// 16
						SC6->C6_ITEM,; //17
						0,;					// 18-Despesas nao tributadas - Portugal
						0,;					// 19-Tara - Portugal
						SC6->C6_CF,; // 20-CFO
						NIL,;            // 21-Array para o calculo do IVA Ajustado (opcional)	
						"",;// 22-Codigo Retencao - Equador
						SC6->C6_ABATISS,; //23-Valor Abatimento ISS
						SC6->C6_LOTECTL,; // 24-Lote Produto
						SC6->C6_NUMLOTE,;	// 25-Sub-Lote Produto
		            	,;
		            	,;
		            	Iif(Len(Alltrim(SC6->C6_CLASFIS))==3,SC6->C6_CLASFIS,""),; // 28-Classificação fiscal
						,; //29
						,; //30
						,; //31
						,; //32
						SC6->C6_OPER) // 33 - Tipo de Operação.

			// ------------------------------------
			// CALCULO DO ISS
			// ------------------------------------
			If ( SC5->C5_INCISS == "N" .And. SC5->C5_TIPO == "N")
				If ( SF4->F4_ISS=="S" )
					nAliqISS := MaAliqISS(nItem)
					nVMercAux := nValMerc
					nPrcLsAux := nPrcLista
					nPrcLista := a410Arred(nPrcLista/(1-(nAliqISS/100)),"D2_PRCVEN")
					If lRndIss
						//Quando configurado para arredondar ISS é nescessario calcular ISS por item
						//conforme ja realizado na funçao MaPvPrcIt (MATA461)
						nValMerc  := a410Arred(nValMerc / SC6->C6_QTDVEN/(1-(nAliqISS/100))) * SC6->C6_QTDVEN
						nValMerc  := a410Arred(nValMerc,"D2_PRCVEN")
					Else
						nValMerc  := nValMerc/(1-(nAliqISS/100))
					Endif
					MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
					MaFisAlt("IT_VALMERC",nValMerc,nItem)
					
				EndIf
			EndIf

            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
            //³Forca os valores de impostos que foram informados no SC6.              ³
            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            For nY := 1 to nFisGet
                If !Empty(uValue:=SC6->(FieldGet(FieldPos(aFisGet[ny][2]))))
                    MaFisAlt(aFisGet[ny][1], uValue,nItem)
                EndIf
            Next nY

            MafisRecal(,nItem)

			//Acumula ISS abaixo do minimo portanto nao descontou do total do titulo.
			If (MaFisRet(,"NF_RECISS")=="1" .And. lDescISS .And. lTpAbISS) .And.;
				!(SF4->F4_FRETISS == "2" .And. SA1->A1_FRETISS == "2")
				nValISS := MaFisRet(nItem,'IT_VALISS')
				If nValISS <= nVRetISS
					nISSNDesc += nValISS
				EndIf
			EndIf
			
			SC6->(DbSkip(1))
		
		EndDo
	
		// ------------------------------------------
		// INDICA OS VALORES DO CABECALHO
		// ------------------------------------------
		MaFisAlt("NF_FRETE", (cAliasIt)->C5_FRETE)
		MaFisAlt("NF_SEGURO", (cAliasIt)->C5_SEGURO)
		MaFisAlt("NF_AUTONOMO", (cAliasIt)->C5_FRETAUT)
		MaFisAlt("NF_DESPESA", (cAliasIt)->C5_DESPESA)
		MaFisAlt("NF_DESCONTO", MaFisRet(,"NF_DESCONTO")+MaFisRet(,"NF_VALMERC")*(cAliasIt)->C5_PDESCAB/100)
		MaFisAlt("NF_DESCONTO", MaFisRet(,"NF_DESCONTO")+(cAliasIt)->C5_DESCONT)
		
		
		//Corrige desconto devido ISS do item ter ficado menor que limite mas total de ISS ficou maior.
		If nISSNDesc > 0
			nValISS := MaFisRet(,"NF_VALISS")
			If nValISS > nVRetISS
				nTotTit := MaFisRet(,"NF_BASEDUP")
				MaFisAlt("NF_BASEDUP",nTotTit-nISSNDesc)
			EndIf
		EndIf
		
		MaFisWrite(1)
		
		aImpostos := MaFisRet(, "NF_IMPOSTOS2")
	
	EndIf

EndIf

nItem := Val((cAliasIt)->ITEM)
If MaFisFound("IT",nItem)
	aRet := {}
	
	For nC := 1 to len(aRef)
		xRet := MaFisRet(nItem ,aRef[nC])

		If ValType(xRet) == 'A'
			nImp	:= xRet[3]
		Else
			nImp	:= xRet
		EndIf
		aAdd(aRet, nImp)
	Next nC 

EndIf


RestArea(aArea)

return aRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FisGetInit³ Autor ³Eduardo Riera          ³ Data ³17.11.2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriaoo ³Inicializa as variaveis utilizadas no Programa              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FisGetInit(aFisGet,aFisGetSC5)

Local cValid      := ""
Local cReferencia := ""
Local nPosIni     := 0
Local nLen        := 0

Local aStruField := {}
Local cField     := ""
Local nC         := 0

aFisGet := {}

aStruField := FWSX3Util():GetAllFields("SC6")
If Len(aStruField) > 0
	For nC := 1 to Len(aStruField)
		cField := aStruField[nC]
		cValid := UPPER(AllTrim(GetSx3Cache(cField, "X3_VALID"))+AllTrim(GetSx3Cache(cField, "X3_VLDUSER")))
		If 'MAFISGET("'$cValid
			nPosIni     := AT('MAFISGET("',cValid)+10
			nLen        := AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			aAdd(aFisGet,{cReferencia,cField,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni        := AT('MAFISREF("',cValid) + 10
			cReferencia    :=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			aAdd(aFisGet,{cReferencia,cField,MaFisOrdem(cReferencia)})
		EndIf
	Next nC
EndIf

aSort(aFisGet,,,{|x,y| x[3]<y[3]})

aFisGetSC5 := {}

aStruField := FWSX3Util():GetAllFields("SC6")
If Len(aStruField) > 0
	For nC := 1 to Len(aStruField)
		cField := aStruField[nC]
		cValid := UPPER(AllTrim(GetSx3Cache(cField, "X3_VALID"))+AllTrim(GetSx3Cache(cField, "X3_VLDUSER")))
		If 'MAFISGET("'$cValid
			nPosIni     := AT('MAFISGET("',cValid)+10
			nLen        := AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			aAdd(aFisGetSC5,{cReferencia,cField,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni        := AT('MAFISREF("',cValid) + 10
			cReferencia    :=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			aAdd(aFisGetSC5,{cReferencia,cField,MaFisOrdem(cReferencia)})
		EndIf
	Next nC
EndIf
aSort(aFisGetSC5,,,{|x,y| x[3]<y[3]})

Return(.T.)
