/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "SIGAWIN.CH"        // incluido pelo assistente de conversao do AP5 IDE em 09/09/99
#include "FINR899.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR899   ºAutor  ³Bruno Sobieski      º Data ³  21/12/98   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relacao dos Recibos por cliente                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Finr899()        // incluido pelo assistente de conversao do AP5 IDE em 09/09/99
	Local oReport

	oReport	:= ReportDef()
	oReport:PrintDialog()

	If Select("TRB") > 0
		DbSelectArea("TRB")
		DbCloseArea()
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Augusto       º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tratamanto release 04                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef() 

	Local oReport,oSection1,oSection2
	Local cReport := "FINR899"
	Local cDescri := STR0001 + STR0002
	Local lVersao 	:= .F.
	Local cPerg		:= ""

	If cPaisLoc == "ARG"
		DbSelectArea("SEL")
		lVersao := .T.
		cPerg := "FIR899A"
	Else
		cPerg := "FIR899"
	EndIf

	oReport  := TReport():New( cReport, STR0009, cPerg , { |oReport| ReportPrint( oReport ) }, cDescri )

	oSection1 := TRSection():New( oReport,STR0060, {"SEL"}, )
	TRCell():New( oSection1, "A1_COD" 	,"SA1",/*X3Titulo*/	,/*Picture*/,,/*lPixel*/,{||SA1->A1_COD + "-" + SA1->A1_LOJA})
	TRCell():New( oSection1, "A1_NOME"	,"SA1",/*X3Titulo*/	,/*Picture*/,20/*Tamanho*/,/*lPixel*/,)
																												
	oSection2 := TRSection():New( oSection1,STR0061, {"SEL"} )
	TRCell():New( oSection2, "CODIGO" 	,"",OemToAnsi(STR0044)/*X3Titulo*/	,/*Picture*/,TamSX3("A1_COD")[1]/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "LOJA" 	,"",OemToAnsi(STR0045)/*X3Titulo*/	,/*Picture*/,TamSX3("A1_LOJA")[1]/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NOME"		,"",OemToAnsi(STR0046)/*X3Titulo*/	,/*Picture*/,20/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "EL_RECIBO"	,"SEL",/*X3Titulo*/	,/*Picture*/,TamSX3("EL_RECIBO")[1]/*Tamanho*/,/*lPixel*/,)
	If lVersao
		TRCell():New( oSection2, "EL_VERSAO" ,"SEL",/*X3Titulo*/,/*Picture*/,TamSX3("EL_VERSAO")[1]/*Tamanho*/,/*lPixel*/,)	
	EndIf
	TRCell():New( oSection2, "EL_DTDIGIT" 	,"SEL",/*X3Titulo*/	,/*Picture*/,8/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NVALBX","",OemToAnsi(STR0047)+ CHR(13)+CHR(10) + OemToAnsi(STR0048)/*X3Titulo*/		,PesqPict("SEL","EL_VALOR")/*Picture*/,13/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NVALDN"	,"",OemToAnsi(STR0049)+ CHR(13)+CHR(10) + OemToAnsi(STR0050)/*X3Titulo*/	,PesqPict("SEL","EL_VALOR")/*Picture*/,13/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NVALDEP"	,"",OemToAnsi(STR0051) + CHR(13)+CHR(10) + OemToAnsi(STR0052)/*X3Titulo*/	,PesqPict("SEL","EL_VALOR")/*Picture*/,13/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NVALRA" 	,"",OemToAnsi(STR0053)+ CHR(13)+CHR(10) +OemToAnsi(STR0059) /*X3Titulo*/	,PesqPict("SEL","EL_VALOR")/*Picture*/,13/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NVALRET"	,"",OemToAnsi(STR0055)/*X3Titulo*/	,PesqPict("SEL","EL_VALOR")/*Picture*/,13/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NVALNCC"	,"",OemToAnsi(STR0056) /*X3Titulo*/	,PesqPict("SEL","EL_VALOR")/*Picture*/,13/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NVALCOMP"	,"",OemToAnsi(STR0057)/*X3Titulo*/	,PesqPict("SEL","EL_VALOR")/*Picture*/,13/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2, "NVALDESC","",OemToAnsi(STR0058)/*X3Titulo*/	,PesqPict("SEL","EL_VALOR")/*Picture*/,13/*Tamanho*/,/*lPixel*/,)   

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de impressao                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint( oReport )
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oSection1:Section(1)  
	Local oBreak
	Local lConvert := .F. 
	Local cCLIENTE:= ""
	Local nDecs :=2
	Local nRetGral 	:= 0
	Local nTotBajado:= 0
	Local nTotDesc 	:= 0
	Local nTotComp	:=	0
	Local nPrGral	:= 0
	Local nDepGral	:= 0
	Local nTotAnt	:= 0
	Local nTotChDia	:= 0
	Local nTotChAde	:= 0
	Local nTotDin	:= 0
	Local nTotCC	:= 0
	Local nOrdenes := 0
	Local lPrim:=.t.
	Local cDescCli :=""
	Local nRecOld, nRecNew
	Local cFilterUser := ""
	Local lVersao 	:= .F.
	Local cVersao 	:= ""
	Local cVerDe	:= ""
	Local cVerAte	:= ""
	Local dDtIni	:= dDataBase
	Local dDtFim	:= dDataBase
	Local nMoeInf	:= 1
	Local cSerDe	:= ""
	Local cSerAte	:= ""
	Local nOutMoe	:= 0
	Local cAliasTmp	:= GetNextAlias()
	Local cMoeda	:= ""
	Local nCD		:= 0
	Local nTotCD	:= 0
	Local nRecSEL	:= 0
	Local nTmpSEL	:= 0
	Local aFR899Rec	:= {}
	Local lFR899Rec	:= (cPaisLoc $ "MEX|PER|COL|EQU" .And. ExistBlock("FR899REC"))

	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf

	cVerDe   := MV_PAR06
	cVerAte  := MV_PAR07
	dDtIni   := IIf(cPaisLoc == "ARG", MV_PAR08, MV_PAR06)
	dDtFim   := IIf(cPaisLoc == "ARG", MV_PAR09, MV_PAR07)
	nMoeInf  := IIf(cPaisLoc == "ARG", MV_PAR10, MV_PAR08)
	cSerDe   := IIf(cPaisLoc == "ARG", MV_PAR11, MV_PAR09)
	cSerAte  := IIf(cPaisLoc == "ARG", MV_PAR12, MV_PAR10)
	nOutMoe  := IIf(cPaisLoc == "ARG", MV_PAR13, MV_PAR11)

	If cPaisLoc $ "ARG"
		DbSelectArea("SEL")
		lVersao := .T.
	EndIf

	lConvert := ( nOutMoe == 1 )

	cMoeda := AllTrim(Str(nMoeInf))

	oReport:SetTitle( oReport:Title() +;
							If(MV_PAR01==1,STR0010,If(MV_PAR01==2,STR0011,If(MV_PAR01==3,STR0012,STR0036))) +;
							STR0039 + GetMv("MV_MOEDA" + cMoeda) )	// " - Por Cliente")

	Do Case
		Case MV_PAR01	==	1
			If cPaisLoc $ "ARG" .And. lVersao
				cKey   := "EL_FILIAL+EL_SERIE+EL_RECIBO+EL_VERSAO+EL_TIPODOC"
				cOrdem := "EL_SERIE+EL_RECIBO+EL_VERSAO"
			Else
				cKey   := "EL_FILIAL+EL_SERIE+EL_RECIBO+EL_TIPODOC"
				cOrdem := "EL_SERIE+EL_RECIBO"
			EndIf
			nCount := Val(MV_PAR05)-Val(MV_PAR04)
		Case MV_PAR01 	==	2
			If cPaisLoc $ "ARG" .And. lVersao
				cKey   := "EL_FILIAL+EL_CLIORIG+EL_LOJORIG+EL_SERIE+EL_RECIBO+EL_TIPODOC"
				cOrdem := "EL_CLIORIG+EL_LOJORIG"
			Else			
				cKey   := "EL_FILIAL+EL_CLIORIG+EL_LOJORIG+EL_SERIE+EL_RECIBO+EL_TIPODOC"
				cOrdem := "EL_CLIORIG+EL_LOJORIG"
			EndIf
			nCount := Val(MV_PAR03)-Val(MV_PAR02)
		Case MV_PAR01 	==	3
			If cPaisLoc $ "ARG" .And. lVersao
				cKey   := "EL_FILIAL+EL_CLIORIG+EL_LOJORIG+EL_SERIE+EL_RECIBO+EL_VERSAO+EL_TIPODOC"
				cOrdem := "EL_CLIORIG+EL_LOJORIG+EL_SERIE+EL_RECIBO+EL_VERSAO"
			Else			
				cKey   := "EL_FILIAL+EL_CLIORIG+EL_LOJORIG+EL_SERIE+EL_RECIBO+EL_TIPODOC"
				cOrdem := "EL_CLIORIG+EL_LOJORIG+EL_SERIE+EL_RECIBO"
			EndIf
			nCount := Val(MV_PAR05)-Val(MV_PAR04)
		Case MV_PAR01	==	4
			If cPaisLoc $ "ARG" .And. lVersao
				cKey   := "EL_FILIAL+EL_DTDIGIT+EL_SERIE+EL_RECIBO+EL_VERSAO+EL_TIPODOC"
				cOrdem := "EL_SERIE+EL_RECIBO+EL_VERSAO"
			Else			
				cKey   := "EL_FILIAL+EL_DTDIGIT+EL_SERIE+EL_RECIBO+EL_TIPODOC"
				cOrdem := "EL_SERIE+EL_RECIBO"
			EndIf
			nCount := Val(MV_PAR05)-Val(MV_PAR04)
	EndCase

	cCondicao	:=  " EL_CLIORIG >= '" 		+ MV_PAR02		+ "' AND EL_CLIORIG <= '" 	+ MV_PAR03 		+ "'"
	cCondicao	+=	" AND EL_RECIBO >= '" 	+ MV_PAR04 		+ "' AND EL_RECIBO <= '" 	+ MV_PAR05 		+ "'"
	cCondicao	+=	" AND EL_SERIE >= '" 	+ cSerDe		+ "' AND EL_SERIE <= '" 	+ cSerAte 		+ "'"
	cCondicao	+=	" AND EL_DTDIGIT >= '" 	+ DToS(dDtIni)	+ "' AND EL_DTDIGIT <= '"	+ DToS(dDtFim)	+ "' AND EL_FILIAL = '" + xFilial("SEL") + "'"
	If cPaisLoc $ "ARG" .And. lVersao
		cCondicao += " AND EL_VERSAO >= '" + cVerDe + "' AND EL_VERSAO <= '" + cVerAte + "'"
	EndIf

	If !lConvert
		cCondicao += " AND  ( EL_MOEDA = '" + cMoeda + "'"
		If Len(cMoeda) == 1
			cCondicao += " OR EL_MOEDA = '0" + cMoeda + "' "
		EndIf
		cCondicao += ')'
	EndIf

	cCondicao += " AND EL_CANCEL = 'F' "

	If MV_PAR01 == 3
		cCondicao += " AND EL_TIPODOC <> 'TJ' "
	EndIf

	cFilterUser := oSection1:GetSQLExp("SEL")
	If !Empty(cFilterUser)
		cCondicao += " AND " + cFilterUser
	EndIf

	//Cria a tabela temporária
	F899TMP(cAliasTmp, cKey, cCondicao)

	oReport:NoUserFilter()

	oReport:SetMeter(RecCount())

	If MV_PAR01==3 

		oBreak:= TRBreak():New(oSection2,{||.T.},OemToAnsi(STR0016))                                                                                 

		TRFunction():New(oSection2:Cell("NVALBX")	, , "SUM" ,oBreak , , , ,.f. ,.F. )
		TRFunction():New(oSection2:Cell("NVALDN")	, , "SUM" ,oBreak , , , , .f. ,.F. )
		TRFunction():New(oSection2:Cell("NVALDEP")	, , "SUM" , oBreak, , , ,.f. ,.F. )
		TRFunction():New(oSection2:Cell("NVALRA")	, , "SUM" ,oBreak, , , ,.f. ,.F. )
		If cPaisLoc <> "BRA"
			TRFunction():New(oSection2:Cell("NVALRET")	, , "SUM" ,oBreak , , , ,.f. ,.F. )
		EndIf
		TRFunction():New(oSection2:Cell("NVALNCC"), , "SUM" ,oBreak , , , , .f. ,.F. )
		TRFunction():New(oSection2:Cell("NVALDEP")	, , "SUM" ,oBreak, , , ,.f. ,.F. )
		TRFunction():New(oSection2:Cell("NVALCOMP"), , "SUM" ,oBreak, , , ,.f. ,.F. )
		TRFunction():New(oSection2:Cell("NVALDESC"), , "SUM" ,oBreak, , , ,.f. ,.F. )
	EndIf

	DbSelectArea('SEL')
	dbSelectArea(cAliasTmp)

	While  (cAliasTmp)->(!Eof())
		
		cOrdAnt	:=	&cOrdem
		cRecibo	:=	(cAliasTmp)->EL_RECIBO
		cSerie  :=  (cAliasTmp)->EL_SERIE
		If cPaisLoc $ "ARG" .And. lVersao
			cVersao := (cAliasTmp)->EL_VERSAO
		EndIf
		dAntDtDigit	:=	(cAliasTmp)->EL_DTDIGIT
		SA1->(DbSetOrder(1))
		SA1->(DbSeek(xFilial("SA1") + (cAliasTmp)->EL_CLIORIG + (cAliasTmp)->EL_LOJORIG ))
		If MV_PAR01==3
			lPrim	:=	IIf(cCLIENTE == (cAliasTmp)->EL_CLIORIG +"-"+ (cAliasTmp)->EL_LOJORIG,.F.,.T.)
		EndIf
		
		cCLIENTE	:= (cAliasTmp)->EL_CLIORIG +"-"+ (cAliasTmp)->EL_LOJORIG
		cNomeClie	:= GetLGPDValue('SA1','A1_NOME')
		nValBaj		:= 0.00
		nValDesc	:= 0.00
		nValRa 		:= 0.00
		nValRet		:= 0.00
		nValDep		:= 0.00
		nValPr		:= 0.00
		nValPaNc	:= 0.00
		nCheqd		:= 0.00
		nChead		:= 0.00
		nDin		:= 0.00
		nCC 		:= 0.00
		nCD			:= 0.00
		
		If	lPrim   .And. MV_PAR01==3
			oSection1:Init()
			oSection1 :PrintLine()
			oSection1 :Finish()
		EndIf       
		
		If 	lPrim	
			lPrim	:=	.F.
			oSection2:Init()
		EndIf
	
		dbSelectArea(cAliasTmp)
		nRecOld := (cAliasTmp)->(Recno())
		nRecSEL	:=(cAliasTmp)->RECNO
		While cOrdAnt == &cOrdem .And. (cAliasTmp)->(!Eof())
		
			If ( Substr((cAliasTmp)->EL_TIPODOC,1,2) $ "RG|RI|RB|RS|RM")
				nValRet  := nValRet  +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
			Elseif	(Substr((cAliasTmp)->EL_TIPODOC,1,2) == "TB")
				If !((cAliasTmp)->EL_TIPO $ MV_CRNEG+"|"+MVRECANT)  //Tratamento para NCCs e RAs
					nValBaj  := nValBaj  +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
					nValDesc := nValDesc +  Round(xMoeda((cAliasTmp)->EL_DESCONT,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR),nDecs)
				Else
					nValPaNc := nValPaNc +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
					nValDesc := nValDesc -  Round(xMoeda((cAliasTmp)->EL_DESCONT,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR),nDecs)
				EndIf
			Elseif	(Substr((cAliasTmp)->EL_TIPODOC,1,2) == "TF")
				nValDep  := nValDep  +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
			Elseif	(Substr((cAliasTmp)->EL_TIPODOC,1,2) == "TJ") 
				nCC      := nCC      +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
			Elseif (Substr((cAliasTmp)->EL_TIPODOC,1,2) == "CC") 
				nCC      := nCC      +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)	
			Elseif (Substr((cAliasTmp)->EL_TIPODOC,1,2) == "CD")	
				nCD      := nCD      +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
			Elseif	(Substr((cAliasTmp)->EL_TIPODOC,1,2) $ "CH|EF")
				nValPr   := nValPr   +  Round( IIf( nMoeInf==1, (cAliasTmp)->EL_VLMOED1, xMoeda( (cAliasTmp)->EL_VALOR, Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
				If Substr((cAliasTmp)->EL_TIPODOC,1,2) == "CH"
					If (cAliasTmp)->EL_EMISSAO < (cAliasTmp)->EL_DTVCTO
						nChead:= nChead + Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
					Else
						nCheqd:= nCheqd + Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
					EndIf
				Else
					nDin:= nDin + Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
				EndIf
			Elseif	(Substr((cAliasTmp)->EL_TIPODOC,1,2) == "RA")
				nValRa   := nValRa   +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
			ElseIf ((cAliasTmp)->EL_TIPODOC$(GetSESTipos({|| ES_RCOPGER == "2"},"1")))
				nValPr   := nValPr   +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
				nDin:= nDin + Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
			ElseIf  ((cAliasTmp)->EL_TIPODOC$(GetSESTipos({|| ES_RCOPGER == "1"},"1")))
				nValPr   := nValPr   +  Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
				nChead:= nChead + Round(IIf(nMoeInf==1,(cAliasTmp)->EL_VLMOED1,xMoeda((cAliasTmp)->EL_VALOR,Max(Val((cAliasTmp)->EL_MOEDA),1),nMoeInf,(cAliasTmp)->EL_DTDIGIT,nDecs+1,(cAliasTmp)->EL_VLMOED1/(cAliasTmp)->EL_VALOR)),nDecs)
			EndIf
			If lFR899Rec //Solo aplica para Mercado Internacional
				aFR899Rec := {MV_PAR01, (cAliasTmp)->EL_FILIAL, (cAliasTmp)->EL_SERIE, (cAliasTmp)->EL_RECIBO, (cAliasTmp)->EL_CLIORIG, (cAliasTmp)->EL_LOJORIG}
			EndIf
			(cAliasTmp)->(DbSkip())
			
			nRecNew := (cAliasTmp)->(Recno())

		EndDo

		//-- Posiciona no resgistro que esta sendo impresso, para permitir personalização de leiaute (TReport)
		If lFR899Rec //Solo aplica para Mercado Internacional
			nTmpSEL	:= ExecBlock("FR899REC",.F.,.F.,aFR899Rec)
			nRecSEL := IIf(nTmpSEL > 0, nTmpSEL, nRecSEL)
		EndIf

		SEL->(dbGoTo(nRecSEL))

		dbSelectArea(cAliasTmp)		
		(cAliasTmp)->(dbGoTo(nRecOld))
		
		If MV_PAR01 == 1 .Or. MV_PAR01 == 4           
			oSection2:Cell("CODIGO"):Disable()
			oSection2:Cell("LOJA"):Disable()
			oSection2:Cell("EL_RECIBO"):SetBlock({||IIf(Empty(cSerie),"    ",cSerie+"-")+cRecibo})	///Tipo
			If cPaisLoc $ "ARG" .And. lVersao
				oSection2:Cell("EL_VERSAO"):SetBlock({|| cVersao })	///Revisão do Recibo
			EndIf
			cDescCli:= Alltrim(cCLIENTE+" "+Substr(cNomeClie,1,30))
			oSection2:Cell("NOME"):SetBlock({||cDescCli})	//Ag
			oSection2:Cell("EL_DTDIGIT"):SetBlock({||dAntDtDigit})	//Ag
		Elseif MV_PAR01==2    
			oSection2:Cell("CODIGO"):Disable()
			oSection2:Cell("LOJA"):Disable()           
			oSection2:Cell("EL_RECIBO"):Disable()           
			If cPaisLoc $ "ARG" .And. lVersao
				oSection2:Cell("EL_VERSAO"):Disable()
			EndIf
			oSection2:Cell("EL_DTDIGIT"):Disable()           
			cDescCli:= Alltrim(cCLIENTE+" "+Substr(cNomeClie,1,30))
			oSection2:Cell("NOME"):SetBlock({||cDescCli})	//Ag
		Else 
			oSection2:Cell("CODIGO"):Disable()
			oSection2:Cell("LOJA"):Disable()
			oSection2:Cell("NOME"):Disable()
			oSection2:Cell("EL_RECIBO"):SetBlock({||IIf(Empty(cSerie),"    ",cSerie+"-")+cRecibo})	///Tipo
			If cPaisLoc $ "ARG" .And. lVersao
				oSection2:Cell("EL_RECIBO"):SetBlock({|| cVersao })	///Tipo
			EndIf
			oSection2:Cell("EL_DTDIGIT"):SetBlock({||dAntDtDigit})	//Ag
			If nCC = 0
				BuscaCC(@nCC)
			EndIf
		EndIf  
		
		oSection2:Cell("NVALBX"):SetBlock({||nValBaj})	///Tipo
		oSection2:Cell("NVALDN"):SetBlock({||nValPr})	//Ag
		oSection2:Cell("NVALDEP"):SetBlock({||nValDep})	//Serie
		oSection2:Cell("NVALRA"):SetBlock({||nValRA})	//Parcela  
		If cPaisLoc <> "BRA"
			oSection2:Cell("NVALRET"):SetBlock({||nValRet})	//Serie
		EndIf	
		oSection2:Cell("NVALNCC"):SetBlock({||nCC+nCD})	//Emissao
		oSection2:Cell("NVALCOMP"):SetBlock({||nValPaNc})	//Vencto                                                                                                            
		oSection2:Cell("NVALDESC"):SetBlock({||nValDesc})//Valor 
		oSection2:PrintLine()

		nRetGral 	:= nRetGral		+ nValRet
		nTotBajado	:= nTotBajado	+ nValBaj
		nTotDesc   	:= nTotDesc   	+ nValDesc
		nTotComp	:= nTotComp		+ nValPaNc
		nPrGral		:= nPrGral 		+ nValPr
		nDepGral	:= nDepGral 	+ nValDep
		nTotAnt		:= nTotAnt 		+ nValRa
		nTotChDia	:= nTotChDia 	+ nCheqd
		nTotChAde	:= nTotChAde 	+ nChead
		nTotDin		:= nTotdin 		+ nDin
		nTotCC		:= nTotCC 		+ nCC
		nTotCD		:= nTotCD 		+ nCD
		dbSelectArea(cAliasTmp)		// voltar para alias existente, se nao, nao funciona
		nOrdenes    := nOrdenes + 1
		If(cCLIENTE <> (cAliasTmp)->EL_CLIORIG +"-"+ (cAliasTmp)->EL_LOJORIG) .And. MV_PAR01==3
			oSection2 :Finish()
		EndIf
		
		(cAliasTmp)->(dbGoTo(nRecNew))
	Enddo
	If MV_PAR01<>3 .And. !lPrim
		oSection2 :Finish()
	EndIf	
	If nOrdenes > 0
		//Imprimir Totales
		oReport:SkipLine()
		nTotNetoGral	:=	nTotBajado - nRetGral - nTotComp + nTotAnt
		If (MV_PAR01<>2)
			oReport:PrintText(OemToAnsi(STR0017) + TransForm(nOrdenes,"@R 999,999"))  //"Recibos emitidos  -> "
		EndIf
		oReport:PrintText(OemToAnsi(STR0019) + TransForm(nTotDin,tm(nTotDin,15,nDecs)))//"TOTAL DINHEIRO       ----> "
		oReport:PrintText(OemToAnsi(STR0037) + TransForm(nTotChDia,tm(nTotChDia,15,nDecs)))  //"TOTAL CHEQ AL DIA. ----> "
		oReport:PrintText(If (cPaisLoc<>"CHI",OemToAnsi(STR0038),OemToAnsi(STR0041)) + TransForm(nTotChAde,tm(nTotChAde,15,nDecs)))  //"TOTAL CHEQ ADELANTADO ----> "
		oReport:PrintText(OemToAnsi(STR0020) + TransForm(nDepGral,tm(nDepGral,15,nDecs)))  //"TOTAL DEPOSITADO  ----> "

		If cPaisLoc <> "BRA"
			oReport:PrintText(OemToAnsi(STR0022) + TransForm(nRetGral,tm(nRetGral,15,nDecs)))  //"TOTAL RETENCIONES ----> "
		EndIf                                                                                     
		
		oReport:PrintText(OemToAnsi(STR0040) + TransForm(nTotCC,tm(nTotCC,15,nDecs)))  //"TOTAL CARTAO CREDITO ----> "
		oReport:PrintText(OemToAnsi(STR0062) + TransForm(nTotCD,tm(nTotCD,15,nDecs)))  //"TOTAL CARTAO DEBITO --> "
		oReport:PrintText(OemToAnsi(STR0018) + TransForm(nTotBajado,tm(nTotBajado,15,nDecs)))//"TOTAL BRUTO       ----> " 
		oReport:PrintText(OemToAnsi(STR0043) + TransForm(nTotComp,tm(nTotComp,15,nDecs)))  //"TOTAL COMPENSADO      ----> "
		oReport:PrintText(OemToAnsi(STR0021) + TransForm(nTotAnt,tm(nTotAnt,15,nDecs)))  //"TOTAL ANTICIPO    ----> "
		oReport:PrintText(OemToAnsi(STR0042)+" "+ TransForm(nTotDesc,tm(nTotDesc,15,nDecs)))  //"TOTAL DESCONTADO  ----> "
		oReport:PrintText(OemToAnsi(STR0023) + TransForm(nTotNetoGral,tm(nTotNetoGral,15,nDecs)))  //"TOTAL RECIBIDO    ----> "
	EndIf

	(cAliasTmp)->(DbCloseArea())

Return	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³BuscaCC   ºAutor  ³Fernando Machima    ºFecha ³  18/09/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Busca registros de cartao de credito no recibo              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR899                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BuscaCC(nValCC)

	LOCAL aArea    := GetArea()

	DbSelectArea("SEL")
	DbSetOrder(8)
	If DbSeek(xFilial("SEL")+cSerie+cRecibo+"TJ")
		While !Eof() .And. xFilial() == SEL->EL_FILIAL .And. cRecibo+"TJ" == SEL->EL_RECIBO + AllTrim(SEL->EL_TIPODOC) .And. cSerie == SEL->EL_SERIE
			nValCC	+=	SEL->EL_VALOR
			DbSkip()
		End
	EndIf
	RestArea(aArea)

Return

/*/{Protheus.doc} F899TMP
Monta tabela temporário para o relatório
@type  Function
@author Renato.ito
@since 20/02/2020
@param cAliasTmp, Character, tabela temporária
@param cOrder, Character, ordenação para query
@param cCondicao, Character, filtro para query
/*/
Static Function F899TMP(cAliasTmp As Character, cOrder As Character, cCondicao As Character)

	cCondicao	:= "%" + cCondicao + "%"
	cOrder		:= "%" + StrTran(cOrder, "+" , ",") + "%" 

	BeginSql Alias cAliasTmp

		SELECT
			EL_FILIAL,
			EL_SERIE,
			EL_RECIBO,
			EL_VERSAO,
			EL_TIPODOC,
			EL_CLIORIG, 
			EL_LOJORIG,
			EL_MOEDA,
			EL_TIPO, 
			EL_VALOR,
			EL_VLMOED1,
			EL_DESCONT, 
			EL_CANCEL,
			EL_EMISSAO,
			EL_DTVCTO,
			EL_DTDIGIT,
			R_E_C_N_O_ RECNO
		FROM
			%table:SEL% SEL
		WHERE
			SEL.%notDel% AND
			%exp:cCondicao%
		ORDER BY
			%exp:cOrder%
	EndSql

	TcSetField(cAliasTmp,"EL_DTDIGIT","D",TamSX3("EL_DTDIGIT")[1],TamSX3("EL_DTDIGIT")[2])

Return
