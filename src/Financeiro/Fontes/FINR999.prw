/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "FINR999.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ FUNCAO   ³ FINR999  ³ AUTOR ³ Bruno Sobieski            ³ DATA ³  21.12.98  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ DESCRICAO³ Relacao das Ordenes de Pago por fornecedor.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ USO      ³ Generico                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³   BOPS   ³  MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jeniffer      ³23/01/01³  xxxxxx  ³Pictures dos valores dos titulos.         ³±±
±±³Jeniffer      ³23/01/01³  xxxxxx  ³Inclusao dos arrays aTot e aMoeda para    ³±±
±±³              ³        ³          ³descricao dos totais e descricao de cada  ³±±
±±³              ³        ³          ³moeda, conforme o titulo.                 ³±±
±±³Marco A. Glez.³13/06/17³TSSERMI01-³Se corrige error error presentado al gene-³±±
±±³              ³        ³117       ³rar reporte. Se utiliza funcionalidad im- ³±±
±±³              ³        ³          ³plementada en issue MMI-5916. Paises TODOS³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Finr999()

	Local oReport	:= Nil
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport	:= ReportDef()
	oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Ana Paula Silva     º Data ³  31/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tratamanto release 04                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

	Local oReport	:= Nil
	Local oSection1	:= Nil
	Local oSection2	:= Nil
	Local cReport	:= "FINR999"
	Local cTitulo	:= OemToAnsi(STR0005)	// "Informe de Pagos"
	Local cDescri	:= OemToAnsi(STR0001)  + OemToAnsi(STR0002) //"Imprime informacion de las ordenes de pago" - "Emitidas, separadas por proveedor."

	oReport := TReport():New( cReport, cTitulo, "FIR999" , { |oReport| ReportPrint( oReport, "SEK" ) }, cDescri )

	oSection1 := TRSection():New( oReport,OemToAnsi(STR0010), {"SA2"}, ) //"Proveedor: "

	TRCell():New(oSection1, "A2_CGC"	, "SA2"	, RetTitle("A2_CGC")	, /*Picture*/, /*Tamanho*/					, /*lPixel*/, )
	TRCell():New(oSection1, "A2_NOME"	, "SA2"	, OemToAnsi(STR0010)	, /*Picture*/, TamSx3("A2_NOME")[1]			, /*lPixel*/, ) //"Proveedor: "
	TRCell():New(oSection1, "SALDUP"	, ""	, OemToAnsi(STR0011)	, /*Picture*/, TamSx3("A2_SALDUP")[1]+10	, /*lPixel*/, ) //"SALDO : "
	oSection1:SetNofilter({"SA2"})

	//TITULO
	oSection2 := TRSection():New( oSection1,/*OemToAnsi(STR0044)*/OemToAnsi(STR0012) , {"SEK"} ) //"Orden de pago: "
	If cPaisLoc == "PTG"
		TRCell():New( oSection2,"DESPESA","",	,/*Picture*/,60/*Tamanho*/,/*lPixel*/,)
	Endif
	TRCell():New(oSection2, "EK_ORDPAGO"	, "", /*X3Titulo*/, /*Picture*/, TamSx3("EK_ORDPAGO")[1]+ 15	, /*lPixel*/, )
	TRCell():New(oSection2, "EK_EMISSAO"	, "", /*X3Titulo*/, /*Picture*/, TamSx3("EK_EMISSAO")[1]+10		, /*lPixel*/, )
	TRCell():New(oSection2, "TIPO"			, "", /*X3Titulo*/, /*Picture*/, TamSx3("EK_TIPO")[1]			, /*lPixel*/, )
	TRCell():New(oSection2, "NUMERO"		, "", /*X3Titulo*/, /*Picture*/, TamSx3("EK_NUM")[1]			, /*lPixel*/, )
	TRCell():New(oSection2, "EK_PREFIXO"	, "", /*X3Titulo*/, /*Picture*/, TamSx3("EK_PREFIXO")[1]		, /*lPixel*/, )
	TRCell():New(oSection2, "EK_PARCELA"	, "", /*X3Titulo*/, /*Picture*/, TamSx3("EK_PARCELA")[1]+ 10	, /*lPixel*/, )
	TRCell():New(oSection2, "EK_VENCTO"		, "", /*X3Titulo*/, /*Picture*/, TamSx3("EK_VENCTO")[1]+10		, /*lPixel*/, )
	TRCell():New(oSection2, "EK_VALOR"		, "", /*X3Titulo*/, /*Picture*/, TamSx3("EK_VALOR")[1]+10		, /*lPixel*/, )
	TRCell():New(oSection2, "TIPORET"		, "", /*X3Titulo*/, /*Picture*/, 10								, /*lPixel*/, )
	TRCell():New(oSection2, "RETENCAO"		, "", /*X3Titulo*/, /*Picture*/, 10								, /*lPixel*/, )
	TRCell():New(oSection2, "PAGANT"		, "", /*X3Titulo*/, /*Picture*/, 10								, /*lPixel*/, )

	//FORMAS PAGTO
	TRCell():New(oSection2, "EK_BANCO"		, "", , /*Picture*/, TamSx3("EK_VALOR")[1]+10	, /*lPixel*/, )
	TRCell():New(oSection2, "EK_AGENCIA"	, "", , /*Picture*/, TamSx3("EK_AGENCIA")[1]+10	, /*lPixel*/, )
	TRCell():New(oSection2, "EK_CONTA"		, "", , /*Picture*/, TamSx3("EK_CONTA")[1]+10	, /*lPixel*/, )
	TRCell():New(oSection2, "EK_NUM"		, "", , /*Picture*/, TamSx3("EK_NUM")[1]+10		, /*lPixel*/, )
	TRCell():New(oSection2, "VALOR"			, "", , /*Picture*/, TamSx3("EK_VALOR")[1]		, /*lPixel*/, )
	TRCell():New(oSection2, "CLIENTE"		, "", , /*Picture*/, 40							, /*lPixel*/, )

	oSection2:SetNofilter({"SEK"})

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Ana Paula Silva     º Data ³  31/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de impressao                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)
	
	Local nC			:= 0
	Local nX			:= 0
	Local nInd			:= 0
	Local dData			:= CToD(Space(08))
	Local nMoedaOri		:= 0
	Local nDecimais		:= 0
	Local nValor		:= 0
	Local nTxMoedOri	:= 0
	Local nTxMoedDes	:= 0
	local cOrdemPago	:= ""
	Local cDtemis		:= ""
	Local oSection1		:= oReport:Section(1)
	Local oSection2		:= oSection1:Section(1)
	Local aSX3Box		:= {}
	Local nReg			:= 0
	
	If cPaisLoc == "PTG"
		aSX3Box := RetSx3Box( Posicione("SX3", 2, "EK_TPDESP", "X3CBox()" ),,, 1 )
	EndIf

	Private cPrefixo	:= ""
	Private cValorTit	:= ""
	Private cParcela	:= ""
	Private cVenc		:= ""
	Private cvalor		:= ""
	Private cTipo		:= ""
	Private ctipoRet	:= ""
	Private nNum		:= ""
	Private cCliente	:= ""
	Private cBanco		:= ""
	Private cAgencia	:= ""
	Private cConta		:= ""
	Private nNumChq		:= ""
	Private aDesp		:= {}

	nRetencGer	:= 0
	cLibOrd		:= Alltrim(GetMv("MV_LIBORD"))
	cLiberada	:= " "
	lAgregSEK	:= .F.
	aTot		:= {}
	aMoeda		:= {}

	Pergunte("FIR999",.F.)
	lContinua:=	.T.

	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf

	For nC:=	1 to MoedFin()
		Aadd(aTot,0)
		Aadd(aMoeda,{GetMV("MV_MOEDA"+AllTrim(Str(nC))),GetMV("MV_MOEDAP"+AllTrim(Str(nC)))})
	Next
	dbSelectArea("SEK")
	cAliasSEK := "SEKTMP"
	If Select(cAliasSEK)<>0
		DbSelectArea(cAliasSEK)
		DbCloseArea()
	Endif
	cQuery:="SELECT * FROM "+RetSqlName("SEK")+" "+cAliasSEK+" "
	cQuery+="WHERE EK_FILIAL='"+xFilial("SEK")+"'  AND D_E_L_E_T_<>'*' AND EK_CANCEL<>'T'"
	cQuery+= " AND EK_ORDPAGO>='"+MV_PAR03+"'"
	cQuery+= " AND EK_ORDPAGO<='"+MV_PAR04+"'"
	If cPaisLoc <> "BRA"
		cQuery+=" ORDER BY EK_ORDPAGO,EK_TIPODOC"
		lAgregSEK	:= .T.
	Else
		cQuery += " AND EK_FORNECE>='"+MV_PAR01+"' .AND. EK_FORNECE<='"+MV_PAR02+"'"
		cQuery += " ORDER BY EK_FORNECE,EK_LOJA,EK_ORDPAGO,EK_TIPODOC"
		Titulo += OemToAnsi(STR0008)  // " - Por Proveedor"
	EndIf
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasSEK,.F.,.T.)
	
	Count to nReg
	oReport:SetMeter(nReg)
	
	TCSetField(cAliasSEK, "EK_EMISSAO"	, "D", 8, 0)
	TCSetField(cAliasSEK, "EK_VENCTO"	, "D", 8, 0)
	TCSetField(cAliasSEK, "EK_DTDIGIT"	, "D", 8, 0)
	TCSetField(cAliasSEK, "EK_DTREC"	, "D", 8, 0)
	//+------------------------+
	//¦ Impresión para Formato de tabla   ¦
	//+------------------------+
	If cPaisLoc == "ARG" .and. oReport:nDevice == 4 .and. oReport:NEXCELPRINTTYPE == 3
		(cAliasSEK)->(DBGoTop())
		While (cAliasSEK)->( !EOF() ) .and. lContinua
			
			oReport:IncMeter()
			//+------------------------+
			//¦ Considera parametros   ¦
			//+------------------------+
			If (cAliasSEK)->EK_DTDIGIT < MV_PAR05 .or. (cAliasSEK)->EK_DTDIGIT > MV_PAR06
				dbSkip()
				Loop
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se agregou por fornecedor³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAgregSEK .and. !Empty((cAliasSEK)->EK_FORNEPG)
				If	!((cAliasSEK)->EK_FORNEPG >= mv_par01 .and. (cAliasSEK)->EK_FORNEPG <= mv_par02)
					DbSkip()
					Loop
				EndIf
				cCarAnt := (cAliasSEK)->EK_FORNEPG + (cAliasSEK)->EK_LOJAPG
			Else
				cCarAnt := (cAliasSEK)->EK_FORNECE + (cAliasSEK)->EK_LOJA
			EndIf

			DbSelectArea("SA2")
			DbSetOrder(1) //A2_FILIAL+A2_COD+A2_LOJA 
			DbSeek(xFilial("SA2")+cCarAnt)
			oSection1:Init()
			cCGC:=SA2->A2_CGC
			cCliente:= Subs(A2_NOME,1,25)
			cSaldo:= Alltrim(Transform(A2_SALDUP,PesqPict("SA2","A2_SALDUP"))) + " " + If(A2_SALDUP>1,GetMV("MV_MOEDAP1"),GetMV("MV_MOEDA1"))

			oSection1:Cell("A2_CGC"):SetBlock({||cCGC})
			oSection1:Cell("A2_NOME"):SetBlock({||cCliente})
			oSection1:Cell("SALDUP"):SetValue({||cSaldo})

			nRetencAc:=0


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se agregou por fornecedor³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAgregSEK .and. !Empty((cAliasSEK)->EK_FORNEPG)
				If	!((cAliasSEK)->EK_FORNEPG + (cAliasSEK)->EK_LOJAPG == cCarAnt)
					Exit
				EndIf
			Else
				If	!((cAliasSEK)->EK_FORNECE + (cAliasSEK)->EK_LOJA == cCarAnt)
					Exit
				EndIf
			EndIf

			nC:=1    //Esta var. auxiliar deve ser reiniciada sempre que precisar entrar no loop
			For nC:= 1 to MoedFin()
				aTot[nC]:=0
			Next

			cOrdPagAnt	:= (cAliasSEK)->EK_ORDPAGO
			dDtEmis		:= (cAliasSEK)->EK_EMISSAO
			aTitulos	:= {}
			aRetenc		:= {}
			aChequePr	:= {}
			aChequeTer	:= {}
			aDesp		:= {}
			aPas		:= {}
			
			
			cOrdemPago	:= OemToAnsi(STR0012) + cOrdPagAnt  			//"ORDEN DE PAGO : "
			cDtemis		:= OemToAnsi(STR0035) + DTOC(dDtEmis)
			oSection2:Init()
			oSection2:Cell("EK_ORDPAGO"):SetBlock({||cOrdemPago})
			oSection2:Cell("EK_EMISSAO"):SetBlock({||cDtemis})
			
			DbSelectArea(cAliasSEK)
			If MV_PAR08 == 1
				If nMoedaOri>1
					nTxMoedOri := Iif( cPaisLoc <> "BRA", &((cAliasSEK)->("EK_TXMOE"+StrZero(nMoedaOri,2))),0)
        		EndIf
        		If MV_PAR07>1
        			nTxMoedDes := Iif( cPaisLoc <> "BRA", &((cAliasSEK)->("EK_TXMOE"+StrZero(MV_PAR07,2 ))),0)
        		EndIf
			EndiF
			
			If nTxMoedOri == 0
				nTxMoedOri := RecMoeda(dData,nMoedaOri)
			EndIf

			If nTxMoedDes == 0
				nTxMoedDes := RecMoeda(dData,MV_PAR07)
			EndIf
			cText := ""			
			If ((cAliasSEK)->EK_TIPODOC=="RG")
				dData     := (cAliasSEK)->EK_DTDIGIT
				nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
				nDecimais := MsDecimais(MV_PAR07)
				nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,nTxMoedOri,nTxMoedDes),nDecimais)
				
				Aadd(aRetenc,{(cAliasSEK)->EK_TIPO,(cAliasSEK)->EK_NUM,nValor,MV_PAR07}	)
				
				ctipoRet	:= aRetenc[1][1]
				nNum		:= aRetenc[1][2]
				nRetencao	:= Transform(aRetenc[1][3],TM(aRetenc[1][3],18,MsDecimais(MV_PAR07))) + " " + If(ABS(aRetenc[1][3])>1,aMoeda[aRetenc[1][4]][2],aMoeda[aRetenc[1][4]][1]) //Valor
				
				
				oSection2:Cell("TIPO"):SetBlock({||cText})
				oSection2:Cell("NUMERO"):SetBlock({||cText})
				oSection2:Cell("EK_PREFIXO"):SetBlock({||cText})
				oSection2:Cell("EK_PARCELA"):SetBlock({||cText})
				oSection2:Cell("EK_VENCTO"):SetBlock({||cText})
				oSection2:Cell("EK_VALOR"):SetBlock({||cText})
				oSection2:Cell("TIPORET"):SetBlock({||ctipoRet})
				oSection2:Cell("RETENCAO"):SetBlock({||nRetencao})
				oSection2:Cell("PAGANT"):SetBlock({||cText})

				oSection2:Cell("EK_BANCO"):SetBlock({||cText})
				oSection2:Cell("EK_AGENCIA"):SetBlock({||cText})
				oSection2:Cell("EK_CONTA"):SetBlock({||cText})
				oSection2:Cell("EK_NUM"):SetBlock({|| nNum})
				oSection2:Cell("VALOR"):SetBlock({||cText})
				oSection2:Cell("CLIENTE"):SetBlock({||cText})
				
				
				
				
				
				
				
			ElseIf (cAliasSEK)->EK_TIPODOC == "DE"
				dData     := (cAliasSEK)->EK_DTDIGIT
				nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
				nDecimais := MsDecimais(MV_PAR07)
				nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,RecMoeda(dData,nMoedaOri),nTxMoedDes),nDecimais)
				If (nPosDesp :=	Ascan(aSX3Box,{|x| x[2] == (cAliasSEK)->EK_TPDESP})) >0
					Aadd(aDesp, {aSX3Box[nPosDesp,3],nValor,Val((cAliasSEK)->EK_MOEDA)})
				Else
					Aadd(aDesp, {STR0040,nValor,Val((cAliasSEK)->EK_MOEDA)}) //"Despesa"
				Endif
				
				cValor := OemToAnsi(STR0037) + Alltrim(Transform(aDesp[1][2],TM(aDesp[1][1],18,2) )) //"Valor : "
				If cPaisLoc == "PTG"
					oSection2:Cell("DESPESA"):SetBlock({|| STR0042+aDesp[1][1]})//"Tipo: "
				EndIf
				
				
				oSection2:Cell("TIPO"):SetBlock({||cText})
				oSection2:Cell("NUMERO"):SetBlock({||cText})
				oSection2:Cell("EK_PREFIXO"):SetBlock({||cText})
				oSection2:Cell("EK_PARCELA"):SetBlock({||cText})
				oSection2:Cell("EK_VENCTO"):SetBlock({||cText})
				oSection2:Cell("EK_VALOR"):SetBlock({||cText})
				oSection2:Cell("TIPORET"):SetBlock({||cText})
				oSection2:Cell("RETENCAO"):SetBlock({||cText})
				oSection2:Cell("PAGANT"):SetBlock({||cText})

				oSection2:Cell("EK_BANCO"):SetBlock({||cText})
				oSection2:Cell("EK_AGENCIA"):SetBlock({||cText})
				oSection2:Cell("EK_CONTA"):SetBlock({||cText})
				oSection2:Cell("EK_NUM"):SetBlock({|| cText})
				oSection2:Cell("VALOR"):SetBlock({||cValor})
				oSection2:Cell("CLIENTE"):SetBlock({||cText})
				
				
				
				
			Elseif (cAliasSEK)->EK_TIPODOC=="TB"
				dData     := (cAliasSEK)->EK_DTDIGIT
				nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
				nDecimais := MsDecimais(MV_PAR07)
				nValor    := Round(xMoeda(((cAliasSEK)->EK_VALOR+(cAliasSEK)->EK_JUROS-(cAliasSEK)->EK_DESCONT)*IIF((cAliasSEK)->EK_TIPO$"RA /"+MV_CPNEG+MVPAGANT,-1,1),nMoedaOri,MV_PAR07,dData,nDecimais+1,nTxMoedOri,nTxMoedDes),nDecimais)
				Aadd(aTitulos,{(cAliasSEK)->EK_TIPO,(cAliasSEK)->EK_NUM,(cAliasSEK)->EK_PREFIXO,(cAliasSEK)->EK_PARCELA,(cAliasSEK)->EK_EMISSAO,(cAliasSEK)->EK_VENCTO,nValor,MV_PAR07})	 //Inclusao do EK_MOEDA - Jeniffer 15/01/01			
				
				aTot[aTitulos[1][8]] += aTitulos[1][7]
				cValorTit	:= Transform(aTitulos[1][7],TM(aTitulos[1][7],18,MsDecimais(aTitulos[1][8]))) + " " + If(ABS(aTitulos[1][7])>1,aMoeda[aTitulos[1][8]][2],aMoeda[aTitulos[1][8]][1])
				cParcela	:= OemToAnsi(STR0038) + aTitulos[1][4] //"Cuota : "
				cVenc		:= OemToAnsi(STR0036) + DTOC(aTitulos[1][6]) //"Venc. : "
				cvalor		:= OemToAnsi(STR0037) + Alltrim(cValorTit) //"Valor : "

				cPrefixo	:= aTitulos[1][3]
				cTipo		:= aTitulos[1][1]
				nNumero		:= aTitulos[1][2]
				
				oSection2:Cell("TIPO"):SetBlock({||cTipo})
				oSection2:Cell("NUMERO"):SetBlock({||nNumero})
				oSection2:Cell("EK_PREFIXO"):SetBlock({||cPrefixo})
				oSection2:Cell("EK_PARCELA"):SetBlock({||cParcela})
				oSection2:Cell("EK_VENCTO"):SetBlock({||cVenc})
				oSection2:Cell("EK_VALOR"):SetBlock({||cText})
				oSection2:Cell("TIPORET"):SetBlock({||cText})
				oSection2:Cell("RETENCAO"):SetBlock({||cText})
				oSection2:Cell("PAGANT"):SetBlock({||cText})

				oSection2:Cell("EK_BANCO"):SetBlock({||cText})
				oSection2:Cell("EK_AGENCIA"):SetBlock({||cText})
				oSection2:Cell("EK_CONTA"):SetBlock({||cText})
				oSection2:Cell("EK_NUM"):SetBlock({|| cText})
				oSection2:Cell("VALOR"):SetBlock({||cValor})
				oSection2:Cell("CLIENTE"):SetBlock({||cText})
				
				
				
				
				
				
				
				
				
				
				
			Elseif (cAliasSEK)->EK_TIPODOC=="CP"
				dData     := (cAliasSEK)->EK_DTDIGIT
				nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
				nDecimais := MsDecimais(MV_PAR07)
				nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,RecMoeda(dData,nMoedaOri),nTxMoedDes),nDecimais)
				
				Aadd(aChequePr,{(cAliasSEK)->EK_BANCO,(cAliasSEK)->EK_AGENCIA,(cAliasSEK)->EK_CONTA,(cAliasSEK)->EK_NUM,nValor,MV_PAR07,(cAliasSEK)->EK_TIPO})
				nVlr := TransForm(aChequePr[1][5],TM(aChequePr[1][5],18,MsDecimais(aChequePr[1][6]))) + " " + If(ABS(aChequePr[1][5])>1,aMoeda[aChequePr[1][6]][2],aMoeda[aChequePr[1][6]][1]) // - Inclusao do tipo da Moeda - Jeniffer 23/01/01
				cBanco  := OemToAnsi(STR0021) + aChequePr[1][1]	//"BCO "
				cAgencia:= OemToAnsi(STR0022) + aChequePr[1][2]	//"Ag : "
				cConta  := OemToAnsi(STR0023) + aChequePr[1][3]	//"Cta : "
				nNumChq := OemToAnsi(STR0024) + Alltrim(aChequePr[1][7])+ " : " + aChequePr[1][4]	//"Nro Ch : "
				nValor  := OemToAnsi(STR0020)	 + nVlr							// "Valor : "
				
				oSection2:Cell("TIPO"):SetBlock({||cText})
				oSection2:Cell("NUMERO"):SetBlock({||cText})
				oSection2:Cell("EK_PREFIXO"):SetBlock({||cText})
				oSection2:Cell("EK_PARCELA"):SetBlock({||cText})
				oSection2:Cell("EK_VENCTO"):SetBlock({||cText})
				oSection2:Cell("EK_VALOR"):SetBlock({||cText})
				oSection2:Cell("TIPORET"):SetBlock({||cText})
				oSection2:Cell("RETENCAO"):SetBlock({||cText})
				oSection2:Cell("PAGANT"):SetBlock({||cText})
				
				oSection2:Cell("EK_BANCO"):SetBlock({||cBanco})
				oSection2:Cell("EK_AGENCIA"):SetBlock({||cAgencia})
				oSection2:Cell("EK_CONTA"):SetBlock({||cConta})
				oSection2:Cell("EK_NUM"):SetBlock({||nNumChq})
				oSection2:Cell("VALOR"):SetBlock({||nValor})
				oSection2:Cell("CLIENTE"):SetBlock({||cText})
				
				
				
			Elseif (cAliasSEK)->EK_TIPODOC=="CT"
				dData     := (cAliasSEK)->EK_DTDIGIT
				nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
				nDecimais := MsDecimais(MV_PAR07)
				nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,nTxMoedOri,nTxMoedDes),nDecimais)
				Aadd(aChequeTer,{(cAliasSEK)->EK_BANCO,(cAliasSEK)->EK_AGENCIA,(cAliasSEK)->EK_CONTA,(cAliasSEK)->EK_NUM,nValor,(cAliasSEK)->EK_ENTRCLI,(cAliasSEK)->EK_LOJCLI,MV_PAR07,(cAliasSEK)->EK_TIPO})
				nValor		:= TransForm(aChequeTer[1][5],TM(aChequeTer[1][5],18,MsDecimais(aChequeTer[1][8]))) + " " + If(ABS(aChequeTer[1][5])>1,aMoeda[aChequeTer[1][8]][2],aMoeda[aChequeTer[1][8]][1]) 	// Inclusao do tipo da Moeda - Jeniffer 23/01/01
				cCliente	:= OemToAnsi(STR0026)+aChequeTer[1][6]+"-"+aChequeTer[1][7]+ " )"  //"(De Cliente : "
				cBanco		:= OemToAnsi(STR0021) + aChequeTer[1][1]	//"BCO : "
				cAgencia	:= OemToAnsi(STR0022) + aChequeTer[1][2]	//"Ag : "
				cConta		:= OemToAnsi(STR0023) + aChequeTer[1][3]	//"Cta : "
				nNumChq		:= OemToAnsi(STR0024) + Alltrim(aChequeTer[1][9])+ " : " + aChequeTer[1][4]	//"Nro Ch : "
				cTipo		:= OemToAnsi(STR0025)


				oSection2:Cell("TIPO"):SetBlock({||cText})
				oSection2:Cell("NUMERO"):SetBlock({||cText})
				oSection2:Cell("EK_PREFIXO"):SetBlock({||cText})
				oSection2:Cell("EK_PARCELA"):SetBlock({||cText})
				oSection2:Cell("EK_VENCTO"):SetBlock({||cText})
				oSection2:Cell("EK_VALOR"):SetBlock({||cText})
				oSection2:Cell("TIPORET"):SetBlock({||cText})
				oSection2:Cell("RETENCAO"):SetBlock({||cText})
				oSection2:Cell("PAGANT"):SetBlock({||cText})

				oSection2:Cell("EK_BANCO"):SetBlock({||cBanco + cTipo})
				oSection2:Cell("EK_AGENCIA"):SetBlock({||cAgencia})
				oSection2:Cell("EK_CONTA"):SetBlock({||cConta})
				oSection2:Cell("EK_NUM"):SetBlock({||nNumChq})
				oSection2:Cell("VALOR"):SetBlock({||nValor})
				oSection2:Cell("CLIENTE"):SetBlock({||cCliente})				
								
			Elseif (cAliasSEK)->EK_TIPODOC=="PA"
				dData     := (cAliasSEK)->EK_DTDIGIT
				nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
				nDecimais := MsDecimais(MV_PAR07)
				nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,nTxMoedOri,nTxMoedDes),nDecimais)
				Aadd(aPas,{(cAliasSEK)->EK_NUM,nValor,MV_PAR07})
				nVlr	:= TRANSFORM(aPas[1][2],TM(aPas[1][2],18,MsDecimais(aPas[1][3]))) + " " + If(ABS(aPas[1][2])>1,aMoeda[aPas[1][3]][2],aMoeda[aPas[1][3]][1]) //"Valor : " - Inclusao do tipo da Moeda - Jeniffer 15/01/01
				nValor	:= OemToAnsi(STR0020)	 + nVlr //"Vlr : "

				
				oSection2:Cell("TIPO"):SetBlock({||cText})
				oSection2:Cell("NUMERO"):SetBlock({||cText})
				oSection2:Cell("EK_PREFIXO"):SetBlock({||cText})
				oSection2:Cell("EK_PARCELA"):SetBlock({||cText})
				oSection2:Cell("EK_VENCTO"):SetBlock({||cText})
				oSection2:Cell("EK_VALOR"):SetBlock({||cText})
				oSection2:Cell("TIPORET"):SetBlock({||cText})
				oSection2:Cell("RETENCAO"):SetBlock({||cText})
				oSection2:Cell("PAGANT"):SetBlock({||cText})

				oSection2:Cell("EK_BANCO"):SetBlock({||cText})
				oSection2:Cell("EK_AGENCIA"):SetBlock({||cText})
				oSection2:Cell("EK_CONTA"):SetBlock({||cText})
				oSection2:Cell("EK_NUM"):SetBlock({|| cText})
				oSection2:Cell("VALOR"):SetBlock({||nValor})
				oSection2:Cell("CLIENTE"):SetBlock({||cText})
				

			EndIf

			If Empty((cAliasSEK)->EK_DTREC)  .and. cLibOrd=="S"
				cLiberada:= "N"
			Endif
			oSection1:PrintLine()
			oSection2:PrintLine()
			oReport:SkipLine(3)
			(cAliasSEK)->( DBSKIP() )
		EndDo
	else
		(cAliasSEK)->(DBGoTop())
		While !(cAliasSEK)->(Eof()) .and. lContinua
			oReport:IncMeter()
			//+------------------------+
			//¦ Considera parametros   ¦
			//+------------------------+
			If (cAliasSEK)->EK_DTDIGIT < MV_PAR05 .or. (cAliasSEK)->EK_DTDIGIT > MV_PAR06
				dbSkip()
				Loop
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se agregou por fornecedor³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAgregSEK .and. !Empty((cAliasSEK)->EK_FORNEPG)
				If	!((cAliasSEK)->EK_FORNEPG >= mv_par01 .and. (cAliasSEK)->EK_FORNEPG <= mv_par02)
					DbSkip()
					Loop
				EndIf
				cCarAnt := (cAliasSEK)->EK_FORNEPG + (cAliasSEK)->EK_LOJAPG
			Else
				cCarAnt := (cAliasSEK)->EK_FORNECE + (cAliasSEK)->EK_LOJA
			EndIf

			DbSelectArea("SA2")
			DbSetOrder(1) //A2_FILIAL+A2_COD+A2_LOJA 
			DbSeek(xFilial("SA2")+cCarAnt)
			oSection1:Init()
			cCGC:=SA2->A2_CGC
			cCliente:= Subs(A2_NOME,1,25)
			cSaldo:= Alltrim(Transform(A2_SALDUP,PesqPict("SA2","A2_SALDUP"))) + " " + If(A2_SALDUP>1,GetMV("MV_MOEDAP1"),GetMV("MV_MOEDA1"))

			oSection1:Cell("A2_CGC"):SetBlock({||cCGC})
			oSection1:Cell("A2_NOME"):SetBlock({||cCliente})
			oSection1:Cell("SALDUP"):SetValue({||cSaldo})
			oSection1:PrintLine()
			oSection1:Finish()

			nRetencAc:=0

			DbSelectArea(cAliasSEK)
			While !Eof() .and. lContinua

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifica se agregou por fornecedor³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lAgregSEK .and. !Empty((cAliasSEK)->EK_FORNEPG)
					If	!((cAliasSEK)->EK_FORNEPG + (cAliasSEK)->EK_LOJAPG == cCarAnt)
						Exit
					EndIf
				Else
					If	!((cAliasSEK)->EK_FORNECE + (cAliasSEK)->EK_LOJA == cCarAnt)
						Exit
					EndIf
				EndIf

				cOrdPagAnt	:= (cAliasSEK)->EK_ORDPAGO
				dDtEmis		:= (cAliasSEK)->EK_EMISSAO
				aTitulos	:= {}
				aRetenc		:= {}
				aChequePr	:= {}
				aChequeTer	:= {}
				aDesp		:= {}
				aPas		:= {}
				DbSelectArea(cAliasSEK)
				Do while cOrdPagAnt	== (cAliasSEK)->EK_ORDPAGO
					nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
					nTxMoedOri := 0
					If MV_PAR08 == 1
						If nMoedaOri>1
							nTxMoedOri := Iif( cPaisLoc <> "BRA", &((cAliasSEK)->("EK_TXMOE"+StrZero(nMoedaOri,2))),0)
						EndIf
						If MV_PAR07>1
							nTxMoedDes := Iif( cPaisLoc <> "BRA", &((cAliasSEK)->("EK_TXMOE"+StrZero(MV_PAR07,2 ))),0)
						EndIf
					EndiF
					
					If nTxMoedOri == 0 .and. nMoedaOri > 1
						nTxMoedOri := RecMoeda(dData,nMoedaOri)
					EndIf
		
					If nTxMoedDes == 0
						nTxMoedDes := RecMoeda(dData,MV_PAR07)
					EndIf
					
					If ((cAliasSEK)->EK_TIPODOC=="RG")
						dData     := (cAliasSEK)->EK_DTDIGIT
						nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
						nDecimais := MsDecimais(MV_PAR07)
						nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,nTxMoedOri,nTxMoedDes),nDecimais)
						Aadd(aRetenc,{(cAliasSEK)->EK_TIPO,(cAliasSEK)->EK_NUM,nValor,MV_PAR07}	)
					ElseIf (cAliasSEK)->EK_TIPODOC == "DE"
						dData     := (cAliasSEK)->EK_DTDIGIT
						nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
						nDecimais := MsDecimais(MV_PAR07)
						nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,RecMoeda(dData,nMoedaOri),nTxMoedDes),nDecimais)
						If (nPosDesp :=	Ascan(aSX3Box,{|x| x[2] == (cAliasSEK)->EK_TPDESP})) >0
							Aadd(aDesp, {aSX3Box[nPosDesp,3],nValor,Val((cAliasSEK)->EK_MOEDA)})
						Else
							Aadd(aDesp, {STR0040,nValor,Val((cAliasSEK)->EK_MOEDA)}) //"Despesa"
						Endif
					Elseif (cAliasSEK)->EK_TIPODOC=="TB"
						dData     := (cAliasSEK)->EK_DTDIGIT
						nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
						nDecimais := MsDecimais(MV_PAR07)
						nValor    := Round(xMoeda(((cAliasSEK)->EK_VALOR+(cAliasSEK)->EK_JUROS-(cAliasSEK)->EK_DESCONT)*IIF((cAliasSEK)->EK_TIPO$"RA /"+MV_CPNEG+MVPAGANT,-1,1),nMoedaOri,MV_PAR07,dData,nDecimais+1,nTxMoedOri,nTxMoedDes),nDecimais)
						Aadd(aTitulos,{(cAliasSEK)->EK_TIPO,(cAliasSEK)->EK_NUM,(cAliasSEK)->EK_PREFIXO,(cAliasSEK)->EK_PARCELA,(cAliasSEK)->EK_EMISSAO,(cAliasSEK)->EK_VENCTO,nValor,MV_PAR07})	 //Inclusao do EK_MOEDA - Jeniffer 15/01/01
					Elseif (cAliasSEK)->EK_TIPODOC=="CP"
						dData     := (cAliasSEK)->EK_DTDIGIT
						nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
						nDecimais := MsDecimais(MV_PAR07)
						nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,RecMoeda(dData,nMoedaOri),nTxMoedDes),nDecimais)
						Aadd(aChequePr,{(cAliasSEK)->EK_BANCO,(cAliasSEK)->EK_AGENCIA,(cAliasSEK)->EK_CONTA,(cAliasSEK)->EK_NUM,nValor,MV_PAR07,(cAliasSEK)->EK_TIPO})
					Elseif (cAliasSEK)->EK_TIPODOC=="CT"
						dData     := (cAliasSEK)->EK_DTDIGIT
						nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
						nDecimais := MsDecimais(MV_PAR07)
						nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,nTxMoedOri,nTxMoedDes),nDecimais)
						Aadd(aChequeTer,{(cAliasSEK)->EK_BANCO,(cAliasSEK)->EK_AGENCIA,(cAliasSEK)->EK_CONTA,(cAliasSEK)->EK_NUM,nValor,(cAliasSEK)->EK_ENTRCLI,(cAliasSEK)->EK_LOJCLI,MV_PAR07,(cAliasSEK)->EK_TIPO})
					Elseif (cAliasSEK)->EK_TIPODOC=="PA"
						dData     := (cAliasSEK)->EK_DTDIGIT
						nMoedaOri := Max(Val((cAliasSEK)->EK_MOEDA),1)
						nDecimais := MsDecimais(MV_PAR07)
						nValor    := Round(xMoeda((cAliasSEK)->EK_VALOR,nMoedaOri,MV_PAR07,dData,nDecimais+1,nTxMoedOri,nTxMoedDes),nDecimais)
						Aadd(aPas,{(cAliasSEK)->EK_NUM,nValor,MV_PAR07})
					EndIf

					If Empty((cAliasSEK)->EK_DTREC)  .and. cLibOrd=="S"
						cLiberada:= "N"
					Endif

					DbSkip()
				EndDo

				//TITULOS PAGADOS
				nRetenc	:=0

				oSection2:Init()
				If cPaisLoc == "PTG"
					oSection2:Cell("DESPESA"):Disable()
				Endif
				oSection2:Cell("EK_PARCELA"):Disable()
				oSection2:Cell("EK_VENCTO"):Disable()
				oSection2:Cell("EK_VALOR"):Disable()
				oSection2:Cell("TIPORET"):Disable()
				oSection2:Cell("RETENCAO"):Disable()
				oSection2:Cell("CLIENTE"):Disable()
				oSection2:Cell("EK_PREFIXO"):Disable()
				oSection2:Cell("PAGANT"):Disable()
				oSection2:Cell("EK_BANCO"):Disable()
				oSection2:Cell("EK_AGENCIA"):Disable()
				oSection2:Cell("EK_CONTA"):Disable()
				oSection2:Cell("EK_NUM"):Disable()
				oSection2:Cell("VALOR"):Disable()
				oSection2:Cell("TIPO"):Disable()

				If cPaisLoc == "PTG"
					oSection2:Cell("DESPESA"):HideHeader()
				Endif
				oSection2:Cell("EK_ORDPAGO"):HideHeader()
				oSection2:Cell("EK_EMISSAO"):HideHeader()
				oSection2:Cell("NUMERO"):HideHeader()
				oSection2:Cell("EK_PARCELA"):HideHeader()
				oSection2:Cell("EK_VENCTO"):HideHeader()
				oSection2:Cell("EK_VALOR"):HideHeader()
				oSection2:Cell("TIPORET"):HideHeader()
				oSection2:Cell("RETENCAO"):HideHeader()
				oSection2:Cell("CLIENTE"):HideHeader()
				oSection2:Cell("EK_PREFIXO"):HideHeader()
				oSection2:Cell("PAGANT"):HideHeader()
				oSection2:Cell("EK_BANCO"):HideHeader()
				oSection2:Cell("EK_AGENCIA"):HideHeader()
				oSection2:Cell("EK_CONTA"):HideHeader()
				oSection2:Cell("EK_NUM"):HideHeader()
				oSection2:Cell("VALOR"):HideHeader()
				oSection2:Cell("TIPO"):HideHeader()

				cOrdemPago	:= OemToAnsi(STR0012) + cOrdPagAnt  			//"ORDEN DE PAGO : "
				cDtemis		:= OemToAnsi(STR0035) + DTOC(dDtEmis)
				oSection2:Cell("EK_ORDPAGO"):Enable()
				oSection2:Cell("EK_EMISSAO"):Enable()
				oSection2:Cell("EK_ORDPAGO"):SetBlock({||cOrdemPago})
				oSection2:Cell("EK_EMISSAO"):SetBlock({||cDtemis})
				oSection2:PrintLine()

				If cLiberada== "N"
					oReport:PrintText(OemToAnsi(STR0039)) //"No Aprobada"
					cLiberada:= " "
				Endif
				oReport:SkipLine()
				oReport:PrintText(OemToAnsi(STR0013) + STR(LEN(aTitulos)))//"Titulos pagados : "

				//Reinicializacao do Array aTot utilizado para armazenar os totais por moeda de cada Fornecedor -  Jeniffer - 23/01/01
				nC:=1    //Esta var. auxiliar deve ser reiniciada sempre que precisar entrar no loop
				For nC:= 1 to MoedFin()
					aTot[nC]:=0
				Next

				oSection2:Cell("TIPO"):Enable()
				oSection2:Cell("NUMERO"):Enable()
				oSection2:Cell("EK_PREFIXO"):Enable()
				oSection2:Cell("EK_PARCELA"):Enable()
				oSection2:Cell("EK_VENCTO"):Enable()
				oSection2:Cell("VALOR"):Enable()
				oSection2:Cell("EK_VALOR"):Enable()
				oSection2:Cell("PAGANT"):Enable()
				oSection2:Cell("EK_ORDPAGO"):Disable()
				oSection2:Cell("EK_EMISSAO"):Disable()
				oSection2:Cell("EK_NUM"):Disable()
				For nX := 1 To LEN(aTitulos)
					aTot[aTitulos[nx][8]] += aTitulos[nx][7]
					cValorTit	:= Transform(aTitulos[nx][7],TM(aTitulos[nx][7],18,MsDecimais(aTitulos[nx][8]))) + " " + If(ABS(aTitulos[nx][7])>1,aMoeda[aTitulos[nx][8]][2],aMoeda[aTitulos[nx][8]][1])
					cParcela	:= OemToAnsi(STR0038) + aTitulos[nX][4] //"Cuota : "
					cVenc		:= OemToAnsi(STR0036) + DTOC(aTitulos[nX][6]) //"Venc. : "
					cvalor		:= OemToAnsi(STR0037) + Alltrim(cValorTit) //"Valor : "

					cPrefixo	:= aTitulos[nX][3]
					cTipo		:= aTitulos[nX][1]
					nNumero		:= aTitulos[nX][2]
					oSection2:Cell("TIPO"):SetBlock({||cTipo})
					oSection2:Cell("NUMERO"):SetBlock({||nNumero})
					oSection2:Cell("EK_PREFIXO"):SetBlock({||cPrefixo})
					oSection2:Cell("EK_PARCELA"):SetBlock({||cParcela})
					oSection2:Cell("EK_VENCTO"):SetBlock({||cVenc})
					oSection2:Cell("VALOR"):SetBlock({||cValor})
					oSection2:PrintLine()
				Next nX
				oReport:SkipLine()

				If cPaisLoc $ "ARG/URU/BOL/PTG"
					//ABATIMIENTOS
					oReport:PrintText(OemToAnsi(STR0014) + " " + Alltrim(STR(LEN(aRetenc))))  //"Retenciones     : "

					oSection2:Cell("TIPORET"):Enable()
					oSection2:Cell("EK_NUM"):Enable()
					oSection2:Cell("RETENCAO"):Enable()

					oSection2:Cell("NUMERO"):Disable()
					oSection2:Cell("EK_PARCELA"):Disable()
					oSection2:Cell("EK_VENCTO"):Disable()
					oSection2:Cell("EK_VALOR"):Disable()
					oSection2:Cell("CLIENTE"):Disable()
					oSection2:Cell("EK_PREFIXO"):Disable()
					oSection2:Cell("PAGANT"):Disable()
					oSection2:Cell("EK_BANCO"):Disable()
					oSection2:Cell("EK_AGENCIA"):Disable()
					oSection2:Cell("EK_CONTA"):Disable()
					oSection2:Cell("VALOR"):Disable()
					oSection2:Cell("TIPO"):Disable()

					For nX := 1 To len(aRetenc)
						ctipoRet	:= aRetenc[nX][1]
						nNum		:= aRetenc[nX][2]
						oSection2:Cell("TIPORET"):SetBlock({||ctipoRet})
						oSection2:Cell("EK_NUM"):SetBlock({|| nNum})
						nRetencao	:= Transform(aRetenc[nX][3],TM(aRetenc[nX][3],18,MsDecimais(MV_PAR07))) + " " + If(ABS(aRetenc[nX][3])>1,aMoeda[aRetenc[nX][4]][2],aMoeda[aRetenc[nX][4]][1]) //Valor
						oSection2:Cell("RETENCAO"):SetBlock({||nRetencao})
						nRetenc		:= nRetenc + aRetenc[nX][3]
						oSection2	:PrintLine()
					Next nX
					oReport:SkipLine()
					oSection2:Cell("TIPORET"):Disable()
					oSection2:Cell("EK_NUM"):Disable()
					oSection2:Cell("RETENCAO"):Disable()
				Endif

				If Len(aDesp) > 0
					oReport:PrintText(OemToAnsi(STR0041) + STR(LEN(aDesp)))//"Despesas pagas : "
					oReport:SkipLine()
					If cPaisLoc == "PTG"
						oSection2:Cell("DESPESA"):Enable()
					EndIf
					oSection2:Cell("TIPO"):Disable()
					oSection2:Cell("NUMERO"):Disable()
					oSection2:Cell("EK_PREFIXO"):Disable()
					oSection2:Cell("EK_PARCELA"):Disable()
					oSection2:Cell("EK_VENCTO"):Disable()
					oSection2:Cell("VALOR"):Enable()
					oSection2:Cell("EK_VALOR"):Disable()
					oSection2:Cell("PAGANT"):Disable()
					oSection2:Cell("EK_ORDPAGO"):Disable()
					oSection2:Cell("EK_EMISSAO"):Disable()
					oSection2:Cell("EK_NUM"):Disable()
					For nX:=1 To LEN(aDesp)
						cValor := OemToAnsi(STR0037) + Alltrim(Transform(aDesp[nx][2],TM(aDesp[nx][1],18,2) )) //"Valor : "
						If cPaisLoc == "PTG"
							oSection2:Cell("DESPESA"):SetBlock({|| STR0042+aDesp[nX,1]})//"Tipo: "
						EndIf
						oSection2:Cell("VALOR"):SetBlock({||cValor})
						oSection2:PrintLine()
					Next
					If cPaisLoc == "PTG"
						oSection2:Cell("DESPESA"):Disable()
					EndIf
					oReport:SkipLine()
				Endif
				For nInd:=1 TO Len(aTot)
					If aTot[nInd]>0
						oReport:PrintText(OemToAnsi(STR0033) + Transform(aTot[nInd],TM(aTot[nInd],18,MsDecimais(Val(aMoeda[nInd][1])))) + " " + If(ABS(aTot[nInd])>1,aMoeda[nInd][2],aMoeda[nInd][1])) // Valor Total - Jeniffer - 23/01/01//
					Endif
				Next

				If Len(aPas) > 0 .Or. Len(aChequePr) > 0 .Or. Len(aChequeTer) > 0
					oReport:PrintText(OemToAnsi(STR0018))  // "Pagado con  : "
				EndIf
				oSection2:Cell("VALOR"):Enable()
				For	nX	:=	1  to Len(aPas)  //Pagos anticipados
					oSection2:Cell("VALOR"):Enable()
					nVlr	:= TRANSFORM(aPas[nX][2],TM(aPas[nx][2],18,MsDecimais(aPas[nx][3]))) + " " + If(ABS(aPas[nX][2])>1,aMoeda[aPas[nx][3]][2],aMoeda[aPas[nx][3]][1]) //"Valor : " - Inclusao do tipo da Moeda - Jeniffer 15/01/01
					nValor	:= OemToAnsi(STR0020)	 + nVlr //"Vlr : "
					oReport:PrintText(OemToAnsi(STR0019) +	aPas[nX][1] + Space(10) + nValor) //"Descontado de Pago adelantado Nro.: "
					oReport:SkipLine()
				Next
				oSection2:Cell("EK_PARCELA"):Disable()
				oSection2:Cell("EK_VENCTO"):Disable()
				oSection2:Cell("EK_VALOR"):Disable()
				oSection2:Cell("TIPORET"):Disable()
				oSection2:Cell("RETENCAO"):Disable()
				oSection2:Cell("NUMERO"):Disable()
				oSection2:Cell("CLIENTE"):Disable()
				oSection2:Cell("EK_PREFIXO"):Disable()
				oSection2:Cell("TIPO"):Disable()
				oSection2:Cell("PAGANT"):Disable()
				For nX := 1 To len(aChequePr) //CHEQUE Proprio
					nVlr := TransForm(aChequePr[nX][5],TM(aChequePr[nx][5],18,MsDecimais(aChequePr[nx][6]))) + " " + If(ABS(aChequePr[nX][5])>1,aMoeda[aChequePr[nx][6]][2],aMoeda[aChequePr[nx][6]][1]) // - Inclusao do tipo da Moeda - Jeniffer 23/01/01

					cBanco  := OemToAnsi(STR0021) + aChequePr[nX][1]	//"BCO "
					cAgencia:= OemToAnsi(STR0022) + aChequePr[nX][2]	//"Ag : "
					cConta  := OemToAnsi(STR0023) + aChequePr[nX][3]	//"Cta : "
					nNumChq := OemToAnsi(STR0024) + Alltrim(aChequePr[nX][7])+ " : " + aChequePr[nX][4]	//"Nro Ch : "
					nValor  := OemToAnsi(STR0020)	 + nVlr							// "Valor : "

					oSection2:Cell("EK_BANCO"):Enable()
					oSection2:Cell("EK_AGENCIA"):Enable()
					oSection2:Cell("EK_CONTA"):Enable()
					oSection2:Cell("EK_NUM"):Enable()
					oSection2:Cell("VALOR"):Enable()
					oSection2:Cell("NUMERO"):Disable()
					oSection2:Cell("EK_BANCO"):SetBlock({||cBanco})
					oSection2:Cell("EK_AGENCIA"):SetBlock({||cAgencia})
					oSection2:Cell("EK_CONTA"):SetBlock({||cConta})
					oSection2:Cell("EK_NUM"):SetBlock({||nNumChq})
					oSection2:Cell("VALOR"):SetBlock({||nValor})
					oSection2:PrintLine()
					oReport:SkipLine()
				Next nX
				For nX := 1 To len(aChequeTer)										//CHEQUE Tercero
					nValor		:= TransForm(aChequeTer[nX][5],TM(aChequeTer[nx][5],18,MsDecimais(aChequeTer[nx][8]))) + " " + If(ABS(aChequeTer[nX][5])>1,aMoeda[aChequeTer[nx][8]][2],aMoeda[aChequeTer[nx][8]][1]) 	// Inclusao do tipo da Moeda - Jeniffer 23/01/01
					cCliente	:= OemToAnsi(STR0026)+aChequeTer[nX][6]+"-"+aChequeTer[nX][7]+ " )"  //"(De Cliente : "
					cBanco		:= OemToAnsi(STR0021) + aChequeTer[nX][1]	//"BCO : "
					cAgencia	:= OemToAnsi(STR0022) + aChequeTer[nX][2]	//"Ag : "
					cConta		:= OemToAnsi(STR0023) + aChequeTer[nX][3]	//"Cta : "
					nNumChq		:= OemToAnsi(STR0024) + Alltrim(aChequeTer[nX][9])+ " : " + aChequeTer[nX][4]	//"Nro Ch : "
					cTipo		:= OemToAnsi(STR0025)

					oSection2:Cell("EK_BANCO"):Enable()
					oSection2:Cell("EK_AGENCIA"):Enable()
					oSection2:Cell("EK_CONTA"):Enable()
					oSection2:Cell("EK_NUM"):Enable()
					oSection2:Cell("VALOR"):Enable()
					oSection2:Cell("CLIENTE"):Enable()

					oSection2:Cell("EK_BANCO"):SetBlock({||cBanco + cTipo})
					oSection2:Cell("EK_AGENCIA"):SetBlock({||cAgencia})
					oSection2:Cell("EK_CONTA"):SetBlock({||cConta})
					oSection2:Cell("EK_NUM"):SetBlock({||nNumChq})
					oSection2:Cell("VALOR"):SetBlock({||nValor})
					oSection2:Cell("CLIENTE"):SetBlock({||cCliente})
					oSection2:PrintLine()
					oReport:SkipLine()
				Next nX
				oReport:SkipLine(3)
				nRetencAc := nRetencAc + nRetenc
			EndDo
			nRetencGer := nRetencGer+nRetencAc
			oSection2:Finish()
		EndDo
	EndIf
	DbSelectArea(cAliasSEK)
	DbCloseArea()

Return
