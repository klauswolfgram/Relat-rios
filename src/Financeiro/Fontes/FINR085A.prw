/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "FINR085A.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ FINR085A º Autor ³ Jose Novaes Romeu  º Data ³  12/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao da Ordem de Pagamento                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Localizacoes                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

/*Raul Ortiz M |13/03/18|DMICNS-1230| Se modifica la rutina para considerar 
				 |        |           |el rango de ordenes de pago - Argentina
				 |        |           |*/
				 
User Function FINR085A()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1		:= OemToAnsi(STR0001)  //Este programa imprime as Ordens de Pagamento
Local cDesc2		:= ""
Local cDesc3		:= ""
Local wnrel			:= "FINR085A"
Local cString		:= "SEK"
Local cPerg			:= "FIR85A"
Local cChave        := ""
Local lAgregSEK	    := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratamento para chamada do modulo SIGACTB(Relacionamentos-CTL)³
//³ atraves da rotina de Rastreamento de Lancamento(CTBC010).     ³
//³ Pelo cadastro de Relacionamento pode ser configurada a chamada³
//³ desta rotina, atraves do campo CTL_EXECUT, com a finalidade de³
//³ rastreamento dos lancamentos contabeis                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lRastroCTB    := AllTrim(ProcName(1)) == "CTBORDPAGO"
Local cQuery 		:= ""
Local aStru 		:= {}
Local nLoop 		:= 0 
Local cPosReg 		:= ""
Local nTamFil		:= TamSX3("EK_FILIAL")[1]
Local lTRepAndin	:= (cPaisLoc $ "EQU" .And. FunName() == "FINR085A" .And. TRepInUse())
Private tamanho		:= "P"
Private limite		:= 80
Private titulo		:= OemToAnsi(STR0002)  //Impressao das Ordens de Pagamento
Private aReturn		:= { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 2, 2,1,"",1 }  //Zebrado#Administracao
Private nomeprog	:= "FINR085A"
Private nTipo		:= 18
Private nLastKey	:= 0
Private m_pag		:= 1
Private lEnd		:= .F.
Private cArqTrab
Private nReImprimir := 0
Private cTabTmp		:= ""
Private lAgSEK		:= .F.
Private lRasCTB		:= .F.
Private cTmpQry		:= ""

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01			// Data De                              ³
//³ mv_par02			// Data Ate                             ³
//³ mv_par03			// De  PO                               ³
//³ mv_par04			// Ate PO                               ³
//³ mv_par05			// Fornecedor De                        ³
//³ mv_par06			// Fornecedor Ate                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lTRepAndin
	wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,"",.T.,tamanho,"",.T.)
	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
	Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)
EndIf

If cPaisLoc == "ARG" .AND. (GetNewPar("MV_CERTRET","N") == "S")
	nReImprimir := MV_PAR07
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Preparacao do arquivo de trabalho                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cString)
dbSetOrder(3)

lAgregSEK	:= .T.

If lRastroCTB .And. !Empty(CTL->CTL_KEY)
	cPosReg := Alltrim(CV3->CV3_KEY)
	dbSetOrder(1)	
	dbSeek(cPosReg)
	cChave    := &(CTL->CTL_KEY)
	mv_par01  := CV3->CV3_DTSEQ  
	mv_par02  := CV3->CV3_DTSEQ
	If !(FUNNAME() == "CTBA102" .AND. CPAISLOC == "ARG")
		mv_par03  := Substr(cChave,nTamFil+1,TamSX3("EK_ORDPAGO")[1])      
		mv_par04  := Substr(cChave,nTamFil+1,TamSX3("EK_ORDPAGO")[1])
	EndIf               
	mv_par05  := ""   
	mv_par06  := "ZZZZZZ"   
EndIf
           
dbSelectArea("SEK")
If !lTRepAndin
	cFilterUser:=aReturn[7]
EndIf
cString		:= getNextAlias()
aStru := SEK->(dbStruct())
//dbCloseArea()
dbSelectArea("SA2") //Este comando eh necessario. Nao apague!!!!
			
cQuery := "SELECT * FROM " + RetSQLname("SEK")
cQuery += " WHERE D_E_L_E_T_ <> '*'"
cQuery += " AND EK_FILIAL  = '"  + xFilial("SEK") + "'"
If !lTRepAndin
	cQuery += " AND EK_DTDIGIT BETWEEN '" + DTOS(mv_par01) + "' AND '" + DTOS(mv_par02) + "'"
	cQuery += " AND EK_ORDPAGO BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"
EndIf
If !lAgregSEK
	cQuery += " AND EK_FORNECE BETWEEN '" + mv_par05 + "' AND '" + mv_par06 + "'"
EndIf
If !lRastroCTB	
	cQuery += " AND EK_CANCEL <> 'T'"
EndIf   
If !lTRepAndin
	cQuery += " ORDER BY EK_FILIAL, EK_ORDPAGO "
EndIf

//Para TReport el area se crea despues de confirmar la generación del informe
If lTRepAndin
	cTmpQry := cQuery
Else
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cString, .F., .T.)
	For nLoop := 1 to Len(aStru)
		If aStru[nLoop,2] <> "C"
			TCSetField(cString, aStru[nLoop,1], aStru[nLoop,2],;
			aStru[nLoop,3], aStru[nLoop,4])
		Endif
	Next

	dbSelectArea(cString)
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lTRepAndin
	cTabTmp	:= cString
	lAgSEK	:= lAgregSEK
	lRasCTB	:= lRastroCTB
	
	oReport := ReportDef()
   	oReport:PrintDialog()
Else
	RptStatus({|lEnd| Fa085Imp(@lEnd,wnrel,cString,lAgregSEK,lRastroCTB) },Titulo)
EndIf
Return

/*/{Protheus.doc} ReportDef
	Creacion de objeto TReport FINR085A
	@type  Static Function
	@author oscar.lopez
	@since 02/06/2022
	@version 1.0
	@return oReport, objeto, Objeto TReport
	@example
	ReportDef()
/*/
Static Function ReportDef()
	Local nTamVal		:= GetSx3Cache("EK_VALOR", "X3_TAMANHO") + GetSx3Cache("EK_VALOR", "X3_DECIMAL") + 1
	Local cPictVal		:= GetSx3Cache("EK_VALOR", "X3_PICTURE")
	Local cMoedaP1		:= AllTrim(SuperGetmv("MV_MOEDAP1",.F.,""))
	Local nTamTipo		:= GetSx3Cache("EK_TIPO", "X3_TAMANHO")
	Local nTamNum		:= GetSx3Cache("EK_NUM", "X3_TAMANHO")
	Local nTamMoed		:= GetSx3Cache("EK_MOEDA", "X3_TAMANHO")
	Local nTamVenc		:= GetSx3Cache("EK_VENCTO", "X3_TAMANHO")
	Private oReport		:= Nil
	Private oSection1	:= Nil
	Private oSection2	:= Nil
	Private oSection3	:= Nil
	Private oSection4	:= Nil
	Private oSection5	:= Nil

	///ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
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
	oReport:= TReport():New("FINR085A",STR0002,"FIR85A", {|oReport| ReportPrint(oReport)},STR0002) //"Impresion de las Ordenes de Pago"
	oReport:ShowHeader()			// Imprimir el encabezado del informe (por default)
	oReport:oPage:nPaperSize:= 9	// Impressão em papel A4
	oReport:nFontBody		:= 8 	// Tamaño fuente del documento
	oReport:nLineHeight		:= 30 	// Altura de linea

	//							1		2	      3  4 5 6 7 8   9   10   11  12 13 14 15   16 17 18 19
	oSection1:=TRSection():New(oReport,STR0009,"SEK", , , , , , .F., .F., .F.,  ,  ,  ,  , .T.,  ,  ,  ) //"ORDEN DE PAGO DE LOS SIGUIENTES DOCUMENTOS:"

	TRCell():New(oSection1,'EK_PREFIXO'	,'SEK'	,STR0035,/*Picture*/,nTamTipo		, /*lPixel*/,/*{|| code-block de impressao }*/) //"SER"
	TRCell():New(oSection1,'EK_NUM'		,'SEK'	,STR0052,/*Picture*/,nTamNum		, /*lPixel*/,/*{|| code-block de impressao }*/) //"/NUMERO"
	TRCell():New(oSection1,'EK_VALOR'	,'SEK'	,STR0036,cPictVal	,nTamVal		, /*lPixel*/,/*{|| code-block de impressao }*/) //"VALOR PAGO"
	TRCell():New(oSection1,'EK_MOEDA'	,'SEK'	,STR0037,/*Picture*/,nTamMoed		, /*lPixel*/,/*{|| code-block de impressao }*/) //"MDA"
	TRCell():New(oSection1,'EK_VENCTO'	,'SEK'	,STR0038,/*Picture*/,nTamVenc		, /*lPixel*/,/*{|| code-block de impressao }*/) //"VENCTO"
	TRCell():New(oSection1,'EK_VALOR2'	,		,STR0039+cMoedaP1,	,nTamVal		, /*lPixel*/,/*{|| code-block de impressao }*/) //"VALOR EN "

	oSection2:=TRSection():New(oReport,"","SFE", , , , , , .F., .F., .F.,  ,  ,  ,  , .F.,  ,  ,  ) //""

	TRCell():New(oSection2,'FE_NROCERT'	,		,		,/*Picture*/,80				, /*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'X1'			,		, 		,/*Picture*/,1				, /*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,'FE_RETENC'	,		,		,cPictVal	,nTamVal		, /*lPixel*/,/*{|| code-block de impressao }*/)

	oSection2:SetHeaderSection(.F.)

	oSection3:=TRSection():New(oReport,STR0016,"SEK", , , , , , .F., .F., .F.,  ,  ,  ,  , .T.,  ,  ,  ) //"DESCONTADOS LOS SIGUIENTES ANTICIPOS/CRÉDITOS:"

	TRCell():New(oSection3,'EK_NUM'		,'SEK'	,STR0040,/*Picture*/,nTamNum									, /*lPixel*/,/*{|| code-block de impressao }*/) //"NUMERO"
	TRCell():New(oSection3,'EK_VALOR'	,'SEK'	,STR0041,cPictVal	,nTamVal									, /*lPixel*/,/*{|| code-block de impressao }*/) //"VALOR"
	TRCell():New(oSection3,'EK_MOEDA'	,'SEK'	,STR0037,/*Picture*/,nTamMoed									, /*lPixel*/,/*{|| code-block de impressao }*/) //"MDA"
	TRCell():New(oSection3,'EK_EMISSAO'	,'SEK'	,STR0042,/*Picture*/,GetSx3Cache("EK_EMISSAO", "X3_TAMANHO")	, /*lPixel*/,/*{|| code-block de impressao }*/) //"EMISION"
	TRCell():New(oSection3,'EK_VLMOED1'	,'SEK'	,STR0039+cMoedaP1,GetSx3Cache("EK_VLMOED1", "X3_PICTURE"),GetSx3Cache("EK_VLMOED1", "X3_TAMANHO")	, /*lPixel*/,/*{|| code-block de impressao }*/) //"VALOR EN "
	
	oSection4:=TRSection():New(oReport,STR0031,"SEK", , , , , , .F., .F., .F.,  ,  ,  ,  , .F.,  ,  ,  ) //"GASTOS DEL PAGO: "

	TRCell():New(oSection4,'EK_TPDESP'	,'SEK'	,STR0043,/*Picture*/,GetSx3Cache("EK_TPDESP", "X3_TAMANHO")		, /*lPixel*/,/*{|| code-block de impressao }*/) //"TP"
	TRCell():New(oSection4,'EK_VALOR'	,'SEK'	,STR0041,cPictVal	,nTamVal									, /*lPixel*/,/*{|| code-block de impressao }*/) //"VALOR"
	TRCell():New(oSection4,'EK_MOEDA'	,'SEK'	,STR0037,/*Picture*/,nTamMoed									, /*lPixel*/,/*{|| code-block de impressao }*/) //"MDA"

	oSection5:=TRSection():New(oReport,STR0018,"SEK", , , , , , .F., .F., .F.,  ,  ,  ,  , .T.,  ,  ,  ) //"EN EL SIGUIENTE DETALLE (CHEQUES-EFECTIVO-TRANSFERENCIAS):"

	TRCell():New(oSection5,'EK_TIPO'	,'SEK'	,STR0043,/*Picture*/,nTamTipo									, /*lPixel*/,/*{|| code-block de impressao }*/) //"TP"
	TRCell():New(oSection5,'EK_NUM'		,'SEK'	,STR0052,/*Picture*/,nTamNum									, /*lPixel*/,/*{|| code-block de impressao }*/) //"/NUMERO"
	TRCell():New(oSection5,'EK_VALOR'	,'SEK'	,STR0041,cPictVal	,nTamVal									, /*lPixel*/,/*{|| code-block de impressao }*/) //"VALOR"
	TRCell():New(oSection5,'EK_MOEDA'	,'SEK'	,STR0037,/*Picture*/,nTamMoed									, /*lPixel*/,/*{|| code-block de impressao }*/) //"MDA"
	TRCell():New(oSection5,'EK_BANCO'	,'SEK'	,STR0044,/*Picture*/,GetSx3Cache("EK_BANCO", "X3_TAMANHO")		, /*lPixel*/,/*{|| code-block de impressao }*/) //"BCO"
	TRCell():New(oSection5,'EK_AGENCIA'	,'SEK'	,STR0045,/*Picture*/,GetSx3Cache("EK_AGENCIA", "X3_TAMANHO")	, /*lPixel*/,/*{|| code-block de impressao }*/) //"AGEN"
	TRCell():New(oSection5,'EK_CONTA'	,'SEK'	,STR0046,/*Picture*/,GetSx3Cache("EK_CONTA", "X3_TAMANHO")		, /*lPixel*/,/*{|| code-block de impressao }*/) //"CUENTA"
	TRCell():New(oSection5,'EK_VENCTO'	,'SEK'	,STR0047,/*Picture*/,nTamVenc									, /*lPixel*/,/*{|| code-block de impressao }*/) //"VENC."

	oSection6:=TRSection():New(oReport,STR0022,"SEK", , , , , , .F., .F., .F.,  ,  ,  ,  , .F.,  ,  ,  ) //"EN CONCEPTO DE PAGO ANTICIPADO DE TITULOS:"

	TRCell():New(oSection6,'EK_NUM'		,'SEK'	,STR0040,/*Picture*/,nTamNum		, /*lPixel*/,/*{|| code-block de impressao }*/) //"NUMERO"
	TRCell():New(oSection6,'EK_VALOR'	,'SEK'	,STR0041,cPictVal	,nTamVal		, /*lPixel*/,/*{|| code-block de impressao }*/) //"VALOR"
	TRCell():New(oSection6,'EK_MOEDA'	,'SEK'	,STR0037,/*Picture*/,nTamMoed		, /*lPixel*/,/*{|| code-block de impressao }*/) //"MDA"

Return oReport

/*/{Protheus.doc} ReportPrint
	Función para realizar impresión mediante TReport.
	@type Static Function
	@author oscar.lopez
	@since 09/06/2022
	@version 1.0
	@param oReport, objeto, Objeto TReport
	/*/
Static Function ReportPrint(oReport)
	Local lEnd		:= .F.
	Local cQuery	:= cTmpQry
	Local aStru		:= SEK->(dbStruct())
	Local nX		:= 0
	Private lDev4	:= (oReport:nDevice == 4)
	Private aSM0inf	:= FWSM0Util():GetSM0Data( cEmpAnt , cFilAnt , { "M0_NOMECOM",  "M0_ENDCOB", "M0_CEPCOB", "M0_CIDCOB"} ) 
	oSection1	:= oReport:Section(1)
	oSection2	:= oReport:Section(2)
	oSection3	:= oReport:Section(3)
	oSection4	:= oReport:Section(4)
	oSection5	:= oReport:Section(5)
	oSection6	:= oReport:Section(6)
	cQuery += " AND EK_DTDIGIT BETWEEN '" + DTOS(mv_par01) + "' AND '" + DTOS(mv_par02) + "'"
	cQuery += " AND EK_ORDPAGO BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"
	cQuery += " ORDER BY EK_FILIAL, EK_ORDPAGO "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cTabTmp, .F., .T.)
	For nX := 1 to Len(aStru)
		If aStru[nX,2] <> "C"
			TCSetField(cTabTmp, aStru[nX,1], aStru[nX,2],;
			aStru[nX,3], aStru[nX,4])
		Endif
	Next

	dbSelectArea(cTabTmp)
	Processa({|lEnd| Fa085Imp(@lEnd, "FINR085A", cTabTmp, lAgSEK, lRasCTB)},, STR0002, .T.)
Return


/*/{Protheus.doc} CabFR085A
	Impresión de encabezado por TReport.
	@type  Function
	@author oscar.lopez
	@since 07/06/2022
	@version 1.0
	@param oReport, objeto, Objeto TReport
	@param aSM0inf, arreglo, Arreglo con información de empresa
	@param cOrdPgo, string, Número de orden de pago.
	@return Nil
	@example
		CabFR085A(oReport, aSM0inf, cOrdPgo)
	/*/
Static Function CabFR085A(oReport, aSM0inf, cOrdPgo)
	Local nRow	:= oReport:Row()
	Local nCol	:= oReport:Col()

	oReport:PrintText(AllTrim(aSM0inf[1][2]),nRow,nCol)
	oReport:PrintText(STR0007 + cOrdPgo,nRow,nCol+1000) //"ORDEN DE PAGO NR "
	IIf(lDev4,oReport:SkipLine(1),nRow+=30)

	oReport:PrintText(AllTrim(aSM0inf[2][2]),nRow,nCol)
	oReport:PrintText(DToC(dFchBaja),nRow,nCol+1000)
	IIf(lDev4,oReport:SkipLine(1),nRow+=30)

	oReport:PrintText(AllTrim(aSM0inf[3][2]) + " - " + AllTrim(aSM0inf[4][2]),nRow,nCol)
	IIf(lDev4,oReport:SkipLine(1),nRow+=60)

	oReport:PrintText(STR0008 + Alltrim(SA2->A2_COD) + " - " + AllTrim(SA2->A2_NOME),nRow,nCol) //"BENEFICIARIO: "
	IIf(lDev4,oReport:SkipLine(1),nRow+=60)

	oReport:Line(nRow, nCol, nRow, oReport:GetWidth()-70)
	oReport:SetRow(nRow+30)
Return Nil

/*/{Protheus.doc} PieFR085A
	(long_description)
	@type  Static Function
	@author user
	@since 07/06/2022
	@version 1.0
	@param oReport, objeto, Objeto TReport
	@param dFchBaja, fecha, Fecha de generación
	@param nTotMon1, numero, Monto total en moneda 1
	@return Nil
	@example
		PieFR085A(oReport, dFchBaja, nTotMon1)
/*/
Static Function PieFR085A(oReport, dFchBaja, nTotMon1)
	Local nX		:= 0
	Local nPosRow	:= oReport:Row()
	Local nPosCol	:= oReport:Col()
	Local aTasas := {}

	For nX := 1  To ContaMoeda()
		Aadd(aTasas,IIf(RecMoeda(dFchBaja,StrZero(nX,1))==0,1,RecMoeda(dFchBaja,StrZero(nX,1))))
	Next
	If Len(aTasas) > 0
		If nTotMon1 > 0
			oReport:PrintText(STR0024+Alltrim(GetMv("MV_MOEDAP1"))+" : "+AllTrim(Transform(nTotMon1, GetSx3Cache("EK_VALOR", "X3_PICTURE"))), nPosRow, nPosCol) //"TOTAL EN "
		EndIf
		IIf(lDev4,oReport:SkipLine(1),nPosRow+=60)
		oReport:Line(nPosRow, nPosCol, nPosRow, oReport:GetWidth()-70)
		nPosRow+=30
		oReport:PrintText(STR0025+ Dtoc(SM2->M2_DATA) + " => ", nPosRow, nPosCol) //"TASAS EN "
		For nX:=2  to Len(aTasas)
			If (nX % 2) == 0
				oReport:PrintText(Alltrim(GetMv("MV_MOEDA"+STR(nX,1)))+" : "+Transform(aTasas[nX],"99,999.9999"), nPosRow, nPosCol+500)
			Else
				oReport:PrintText(Alltrim(GetMv("MV_MOEDA"+STR(nX,1)))+" : "+Transform(aTasas[nX],"99,999.9999"), nPosRow, nPosCol+1300)
				nPosRow+=30
			Endif
		Next
	EndIf
	If lDev4
		oReport:SkipLine(2)
	EndIf
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ Fa085Imp º Autor ³ Jose Novaes Romeu  º Data ³  12/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Impressao dos detalhes do relatorio.                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ U_FINR085A()                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fa085Imp(lEnd,wnrel,cString,lAgregSEK,lRastroCTB)

Local nLin		:= 80
Local cbCont	:= 0
Local cbTxt		:= Space(10)
Local Cabec1 := Cabec2 := ""
Local cFornece, cLoja, cOrdPago, dDtBaixa, nBaixa, nTotal, cTipoOp
Local nBaixaMd1, nTotMd1, i, aTasas, nValorMd1
Local aPaApl, aNFs, aChqPr, aChqTer, aPaGer, aRets,aDesp
Local lCabec      := .F.
Local aSX3Box
Local lCancelado  := .F.  
Local cTcMoeda    := ""
Local nTxMoeda    := 0
Local cTipoRet	  := ""
Local lCBU		  := .F.
Local lTRepAndin  := (cPaisLoc $ "EQU" .And. FunName() == "FINR085A" .And. TRepInUse())
Local nRow		  := 0
Local nCol		  := 0
Local cPictVal	  := GetSx3Cache("EK_VALOR", "X3_PICTURE")
Private dFchBaja	:= CtoD(" / / ")
Private cOrdPgo		:= ""
Private nTotMon1	:= 0

If lTRepAndin
	nCol := oReport:Col()
EndIf

If cPaisLoc == "PTG"
	aSx3Box 	:= RetSx3Box( Posicione("SX3", 2, "EK_TPDESP", "X3CBox()" ),,, 1 )		
Endif	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

IIf(!lTRepAndin, SetRegua(RecCount()), .T.)

dbGotop()

While !Eof()

	If !lTRepAndin
		IncRegua()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o cancelamento pelo usuario...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lEnd
			@Prow()+1,00 PSAY OemToAnsi(STR0006)  //CANCELADO PELO OPERADOR
			Exit
		Endif                
	EndIf
	
	dbSelectArea(cString)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lTRepAndin .And. !Empty(cFilterUser).and.!(&cFilterUser)
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tratamento de OP agrupada por Fornecedor³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAgregSEK .And. !Empty(EK_FORNEPG)
		If EK_FORNEPG < mv_par05 .or. EK_FORNEPG > mv_par06
			DbSkip()
			Loop
		EndIf
		cFornece	:= EK_FORNEPG
		cLoja		:= EK_LOJAPG
	Else
		cFornece	:= EK_FORNECE
		cLoja		:= EK_LOJA
	EndIf
	
	cOrdPago	:= EK_ORDPAGO
	dDtBaixa	:= EK_DTDIGIT
	cTipoOp		:= EK_TIPO
	aPaApl		:= {}
	aNFs		:= {}
	aChqPr		:= {}
	aChqTer		:= {}
	aPaGer		:= {}
	aDesp		:= {}
	aRets		:= {}
	nTotal		:= 0.00
	nTotMd1		:= 0.00
    lCabec      := .F.
    lCancelado  := lRastroCTB .And. EK_CANCEL 
	dFchBaja	:= dDtBaixa
	cOrdPgo		:= cOrdPago
	If lTRepAndin
		oReport:SetPageFooter(6,{|| PieFR085A(oReport,dFchBaja, nTotMon1)})
	EndIf
    If (cString)->(FieldPos("EK_PGCBU")) > 0
    	lCBU := (cString)->EK_PGCBU
    Endif
    DbSelectArea(cString)
	While !Eof() .and. EK_ORDPAGO == cOrdPago
		If EK_TIPODOC == "TB"
			If EK_TIPO $ MVPAGANT + "/" + MV_CPNEG
				Aadd(aPaApl,{EK_NUM,EK_VALOR,EK_MOEDA,EK_EMISSAO,EK_VLMOED1})
			Else
				nBaixa		:= EK_VALOR
				nTotal		+= nBaixa
				If EK_MOEDA == "1"
					nBaixaMd1 := nBaixa
				Else
					cTcMoeda  := "EK_TXMOE0" + EK_MOEDA
					nTxMoeda  := IIf(FieldPos(cTcMoeda) > 0, &cTcMoeda, 0)
					nBaixaMd1 := Round(xMoeda(nBaixa, Val(EK_MOEDA), 1, dDtBaixa, 5, nTxMoeda), MsDecimais(1))
				Endif
				nTotMd1		+= nBaixaMd1  
				cPref:= EK_PREFIXO
				
				If cPaisLoc=="PER" .And. SEK->(FieldPos("EK_SERORI")>0) .And.  !Empty(EK_SERORI)
			   		cPref:=EK_SERORI
				EndIf
				Aadd(aNfs,{cPref,EK_NUM,EK_PARCELA,nBaixa,EK_MOEDA,EK_VENCTO,nBaixaMd1,(cString)->(FieldPos('EK_CANPARC')) > 0 .And.!Empty((cString)->EK_CANPARC)})
			Endif
		ElseIf EK_TIPODOC == "CP"
			Aadd(aChqPr  ,{EK_TIPO,EK_NUM,EK_VALOR,EK_MOEDA,EK_BANCO,EK_AGENCIA,EK_CONTA,EK_VENCTO})
		ElseIf EK_TIPODOC == "CT"
			Aadd(aChqTer ,{EK_NUM,EK_VALOR,EK_MOEDA,EK_BANCO,EK_AGENCIA,EK_CONTA,EK_ENTRCLI,EK_LOJCLI,;
							EK_VLMOED1})
		ElseIf EK_TIPODOC == "PA"
			nBaixa		:= EK_VALOR
			nBaixaMd1	:= IIf(EK_MOEDA=="1",nBaixa,xMoeda(nBaixa,Val(EK_MOEDA),1,dDtBaixa))
			nTotMd1		-= nBaixaMd1
			Aadd(aPaGer  ,{EK_NUM,EK_VALOR,EK_MOEDA})
		ElseIf EK_TIPODOC == "DE"
			If (nPosDesp	:=	Ascan(aSX3BOX,{|x| x[2]== EK_TPDESP})) >0
				Aadd(aDesp   ,{aSX3Box[nPosDesp,3],EK_VALOR,EK_MOEDA})
			Else
				Aadd(aDesp   ,{STR0030,EK_VALOR,EK_MOEDA})
			Endif
		EndIf
		DbSelectArea(cString)
		DbSkip()
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acumular retencoes                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc != "CHI"	
	   dbSelectArea("SFE")
	   dbSetOrder(2)
	   dbSeek(xFilial("SFE")+cOrdPago)
	   While !Eof() .And. FE_ORDPAGO == cOrdPago
		  If FE_RETENC <> 0
			 nPosRet  := Ascan(aRets,{|X| X[1]+X[3]==FE_NROCERT+FE_TIPO})
			 If nPosRet ==  0
				Aadd(aRets,{FE_NROCERT,FE_RETENC,FE_TIPO})
			 Else
				aRets[nPosRet][2]:=aRets[nPosRet][2]+FE_RETENC
			 EndIf
		  EndIf
		  dbSkip()
	   EndDo
    EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona fornecedor                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SA2")
	dbSetOrder(1)
	dbSeek(xFilial("SA2") + cFornece + cLoja )

	If lTRepAndin
		oReport:PrintText("")
		CabFR085A(oReport, aSM0inf, cOrdPgo)
	EndIf
	If nTotal > 0 
		If !lTRepAndin
			lCabec  := .T.
			Cabec85A(cOrdpago,@nLin,Cabec1,Cabec2,dDtBaixa,lCBU)
		EndIf
		If lCancelado
		   nLin ++		
		   @ nLin, 025 PSAY OemToAnsi(STR0028)  //STR0028  "*** DOCUMENTO ANULADO ***"		         		 		
		   nLin ++				   
		EndIf   
		nLin ++				
		@ nLin, 000 PSAY OemToAnsi(STR0009)  //ORDEM DE PAGAMENTO DOS SEGUINTES DOCUMENTOS:
		nLin ++		
		@ nLin, 000 PSAY Subs(OemToAnsi(STR0010)+Getmv("MV_MOEDAP1"),1,limite) //PRE/NUMERO       /PAR           VALOR PAGO  MDA   EMISSAO     VALOR EM
		If lTRepAndin
			oReport:PrintText("")
			oReport:PrintText(STR0009) //"EN EL SIGUIENTE DETALLE (CHEQUES-EFECTIVO-TRANSFERENCIAS):"
			oSection1:Init()
		EndIf
		For i := 1 to Len(aNfs)
			nLin ++
			@ nLin, 000 PSAY aNfs[i][1]
			@ nLin, 005 PSAY aNfs[i][2]
			@ nLin, 019 PSAY aNfs[i][3]
			@ nLin, 025 PSAY aNfs[i][4]	PICTURE PesqPict("SEK","EK_VALOR")
			@ nLin, 046 PSAY aNfs[i][5]
			@ nLin, 050 PSAY aNfs[i][6]
			If aNfs[i][8]
				@ nLin, 061 PSAY STR0029 
			Else
				@ nLin, 061 PSAY aNfs[i][7]	PICTURE PesqPict('SEK','EK_VALOR',17,MsDecimais(1))
			Endif
			If nLin > 50
				nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
			EndIf
			If lTRepAndin
				oSection1:cell('EK_PREFIXO'):SetValue(aNfs[i][1])
				oSection1:cell('EK_NUM'):SetValue(aNfs[i][2] + " " + aNfs[i][3])
				oSection1:cell('EK_VALOR'):SetValue(aNfs[i][4])
				oSection1:cell('EK_MOEDA'):SetValue(aNfs[i][5])
				oSection1:cell('EK_VENCTO'):SetValue(aNfs[i][6])
				If aNfs[i][8]
					oSection1:cell('EK_VALOR2'):SetValue(STR0029)
				Else
					oSection1:cell('EK_VALOR2'):SetValue(AllTrim(Transform(aNfs[i][7], GetSx3Cache("EK_VALOR", "X3_PICTURE"))))
				EndIf
				oSection1:PrintLine()
			EndIf
		Next
		If lTRepAndin
			oSection1:Finish()
		EndIf
		nLin ++
		If Len(aRets) > 0
			If lTRepAndin
				oReport:SkipLine(1)
				oSection2:Init(.F.)
			EndIf
			For i:= 1 to Len(aRets)
			    If aRets[i][2] < 0 .Or. aRets[i][2] > 0
					nLin ++
					If cPaisLoc == "ARG"
						cTipoRet:=IIf(aRets[i][3]=="G",OemToAnsi(STR0011),Iif(aRets[i][3]=="B",OemToAnsi(STR0012),Iif(aRets[i][3]=="S",OemToAnsi(STR0027),OemToAnsi(STR0013))))  //LUCROS#ENT. BR.#I.V.A.#S.U.S.S.
					ElseIf cPaisLoc$"URU|BOL"
						cTipoRet:=OemToAnsi(STR0026) 
					ElseIf cPaisLoc == "PTG"
						cTipoRet:=Iif(aRets[i][3]=="R",OemToAnsi('I.R.C.'),OemToAnsi(STR0013))
					ElseIf cPaisLoc == "ANG"
						cTipoRet:=OemToAnsi('R.I.E.')
					ElseIf cPaisLoc == "PER"
						If aRets[i][3] == "I"
							cTipoRet := OemToAnsi( "I.G.V." )
						EndIf
					EndIf

					@ nLin,000 PSAY OemToAnsi(STR0014)+cTipoRet+OemToAnsi(STR0015)+aRets[i][1]  //EMITIDO CERTIFICADO DE RETENCAO DE # NR 
					@ nLin,062 PSAY (aRets[i][2] *  - 1 ) PICTURE Pesqpict("SFE","FE_RETENC")
					If nLin > 50
						nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
					EndIf

					If lTRepAndin
						oSection2:cell('FE_NROCERT'):SetValue(STR0014 + cTipoRet + STR0015 + aRets[i][1])
						oSection2:cell('FE_RETENC'):SetValue(aRets[i][2] *  - 1)
						oSection2:PrintLine()
					EndIf
				EndIf
			Next
			nLin++
			If lTRepAndin
				oSection2:Finish()
			EndIf
		EndIf
	EndIf
	//Impressao do cabecalho qdo OP nao tem titulos baixados(nTotal=0). Situacao: geracao de PA
	If !lTRepAndin .And. !lCabec 
		Cabec85A(cOrdpago,@nLin,Cabec1,Cabec2,dDtBaixa,lCBU)
	EndIf
	If Len(aPaApl) > 0
		nLin ++
		@ nLin, 000 PSAY OemToAnsi(STR0016)  //DESCONTADOS OS SEGUINTES ADIANTAMENTOS/CREDITOS:
		nLin ++
		@ nLin, 000 PSAY Subs(OemToAnsi(STR0017)+Getmv("MV_MOEDAP1"),1,limite)  //NUMERO                          VALOR PAGO  MDA   EMISSAO     VALOR EM
		If lTRepAndin
			oReport:PrintText("")
			oReport:PrintText(STR0016) //"DESCONTADOS LOS SIGUIENTES ANTICIPOS/CRÉDITOS:"
			oSection3:Init(.T.)
		EndIf
		For i := 1 to Len(aPaApl)
			nLin ++
			@ nLin,000 PSAY aPaApl[i][1]
			@ nLin,024 PSAY (aPaApl[i][2]* -1) PICTURE PesqPict("SEK","EK_VALOR")
			@ nLin,045 PSAY aPaApl[i][3]
			@ nLin,049 PSAY aPaApl[i][4]
			@ nLin,062 PSAY (aPaApl[i][5]* -1) PICTURE PesqPict("SEK","EK_VLMOED1")
			If nLin > 50
				nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
			EndIf
			If lTRepAndin
				oSection3:cell('EK_NUM'):SetValue(aPaApl[i][1])
				oSection3:cell('EK_VALOR'):SetValue(aPaApl[i][2] * -1)
				oSection3:cell('EK_MOEDA'):SetValue(aPaApl[i][3])
				oSection3:cell('EK_EMISSAO'):SetValue(aPaApl[i][4])
				oSection3:cell('EK_VLMOED1'):SetValue(aPaApl[i][5] * -1)
				oSection3:PrintLine()
			EndIf

			nTotal	-= aPaApl[i][2]
			nTotMd1	-= aPaApl[i][5]
		Next
		If lTRepAndin
			oSection3:Finish()
		EndIf
		nLin ++
	EndIf
	If len(aDesp) > 0
		nLin ++
		@ nLin,000 PSAY OemToAnsi(STR0031) //"DESPESAS DO PAGAMENTO : "
		nLin ++
		@ nLin,000 PSAY OemToAnsi(STR0032) //"TIPO DE DESPESA           VALOR PAGO  MDA "
		If lTRepAndin
			oReport:PrintText("")
			oReport:PrintText(STR0031) //"GASTOS DEL PAGO: "
			oSection4:Init()
		EndIf
		For i:=1  to LEN(aDesp)
			nLin ++
			@nLin,000 PSAY aDesp[i][1]
			@nLin,018 PSAY aDesp[i][2] PICTURE Pesqpict("SEK","EK_VALOR")
			@nLin,039 PSAY aDesp[i][3]
			If nLin > 50
				nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
			EndIf
			If lTRepAndin
				oSection4:cell('EK_TPDESP'):SetValue(aDesp[i][1])
				oSection4:cell('EK_VALOR'):SetValue(aDesp[i][2])
				oSection4:cell('EK_MOEDA'):SetValue(aDesp[i][3])
				oSection4:PrintLine()
			EndIf
		Next
		If lTRepAndin
			oSection4:Finish()
		EndIf
		nLin ++
	Endif
	If len(aChqPr) > 0
		nLin ++
		@ nLin,000 PSAY OemToAnsi(STR0018)  //NO SEGUINTE DETALHE (CHEQUES-EFETIVO-TRANSFERENCIAS):
		nLin ++
		@ nLin,000 PSAY OemToAnsi(STR0019)  //TP /NUMERO                   VALOR MDA BCO AGENC CUENTA               VENCTO
		If lTRepAndin
			oReport:PrintText("")
			oReport:PrintText(STR0018) //"EN EL SIGUIENTE DETALLE (CHEQUES-EFECTIVO-TRANSFERENCIAS):"
			oSection5:Init()
		EndIf
		For i:=1  to LEN(aChqPr)
			nLin ++
			@nLin,000 PSAY aChqPr[i][1]
			@nLin,004 PSAY aChqPr[i][2]
	 		@nLin,018 PSAY aChqPr[i][3] PICTURE Pesqpict("SEK","EK_VALOR")
			@nLin,038 PSAY aChqPr[i][4]
			@nLin,041 PSAY aChqPr[i][5]
			@nLin,045 PSAY aChqPr[i][6]
			@nLin,051 PSAY aChqPr[i][7]
			@nLin,072 PSAY aChqPr[i][8]
			If nLin > 50
				nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
			EndIf
			If lTRepAndin
				oSection5:cell('EK_TIPO'):SetValue(aChqPr[i][1])
				oSection5:cell('EK_NUM'):SetValue(aChqPr[i][2])
				oSection5:cell('EK_VALOR'):SetValue(aChqPr[i][3])
				oSection5:cell('EK_MOEDA'):SetValue(aChqPr[i][4])
				oSection5:cell('EK_BANCO'):SetValue(aChqPr[i][5])
				oSection5:cell('EK_AGENCIA'):SetValue(aChqPr[i][6])
				oSection5:cell('EK_CONTA'):SetValue(aChqPr[i][7])
				oSection5:cell('EK_VENCTO'):SetValue(aChqPr[i][8])
				oSection5:PrintLine()
			EndIf
		Next
		If lTRepAndin
			oSection5:Finish()
		EndIf
		nLin ++
	Endif
	If len(aChqTer) > 0                                                                 
		nLin ++
		If cPaisLoc <> "PTG"
			@ nLin,000 PSAY OemToAnsi(STR0020)  //CHEQUES DE TERCEIROS ENTREGUES:
		Else
			@ nLin,000 PSAY OemToAnsi(STR0033) //"Titulos a receber compensados"
		Endif
		nLin ++
		@ nLin,000 PSAY OemToAnsi(STR0021)  //PRE/NUMERO                VALOR PAGO  MDA  BCO  AGENCIA  CONTA          VENCTO
		For i:=1  to LEN(aChqTer)
			nLin ++
			@ nLin,000 PSAY aChqTer[i][1]
			@ nLin,014 PSAY aChqTer[i][2] PICTURE Pesqpict("SEK","EK_VALOR")
			@ nLin,036 PSAY aChqTer[i][3]
			@ nLin,041 PSAY aChqTer[i][4]
			@ nLin	,047 PSAY aChqTer[i][5]
			@ nLin,057 PSAY aChqTer[i][6]
			@ nLin,071 PSAY aChqTer[i][7]+"-"+aChqTer[i][8]
			If nLin > 50
				nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
			EndIf
		Next
		nLin ++
	Endif
	If Len(aPaGer) > 0
	    nLin ++
		If Len(aRets) > 0
			For i:= 1 to Len(aRets)
			    If aRets[i][2] > 0
					nLin ++
					If cPaisLoc == "ARG"
						cTipoRet:=IIf(aRets[i][3]=="G",OemToAnsi(STR0011),Iif(aRets[i][3]=="B",OemToAnsi(STR0012),Iif(aRets[i][3]=="S",OemToAnsi(STR0027),OemToAnsi(STR0013))))  //LUCROS#ENT. BR.#I.V.A.#S.U.S.S.
					ElseIf cPaisLoc == "URU"
						cTipoRet:=OemToAnsi(STR0026) 
					ElseIf cPaisLoc == "ANG"
						cTipoRet:=OemToAnsi('R.I.E.')
					EndIf
					@ nLin,000 PSAY OemToAnsi(STR0014)+cTipoRet+OemToAnsi(STR0015)+aRets[i][1]  //EMITIDO CERTIFICADO DE RETENCAO DE # NR 
					@ nLin,062 PSAY (aRets[i][2] * - 1 ) PICTURE Pesqpict("SFE","FE_RETENC")
					If nLin > 50
						nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
					EndIf
				ENDIF
			Next
			nLin++
		EndIf
	    nLin ++
		@ nLin,000 PSAY OemToAnsi(STR0022)  //POR VERBA DE PAGAMENTO ANTECIPADO DE TITULOS:
		nLin ++
		@ nLin,000 PSAY OemToAnsi(STR0023)  //NUMERO                VALOR PAGO   MDA
		If lTRepAndin
			oReport:PrintText("")
			oReport:PrintText(STR0022) //"EN CONCEPTO DE PAGO ANTICIPADO DE TITULOS:"
			oSection6:Init()
		EndIf
		For i := 1 To Len(aPaGer)
			nLin ++
			@ nLin,000 PSAY aPaGer[i][1]
			@ nLin,014 PSAY aPaGer[i][2] PICTURE Pesqpict("SEK","EK_VALOR")
			@ nLin,036 PSAY aPaGer[i][3]
			If nLin > 50
				nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
			EndIf
			If lTRepAndin
				oSection6:cell('EK_NUM'):SetValue(aPaGer[i][1])
				oSection6:cell('EK_VALOR'):SetValue(aPaGer[i][2])
				oSection6:cell('EK_MOEDA'):SetValue(aPaGer[i][3])
				oSection6:PrintLine()
			EndIf
		Next
		If lTRepAndin
			oSection6:Finish()
		EndIf
		nLin ++
	EndIf
	nLin := 54
	IF nTotMd1 >= 0
	   @ nLin,000		PSAY OemToAnsi(STR0024)+Alltrim(GetMv("MV_MOEDAP1"))+" : "  //TOTAL EM
	   @ nLin,PCOL()+1	PSAY nTotMd1 PICTURE Pesqpict("SEK","EK_VALOR")
	ELSE
	   @ nLin,000		PSAY ""
	   @ nLin,PCOL()+1	PSAY ""
	ENDIF
	nLin ++
	@ nLin,000 PSAY REPLICATE("_",limite)
	If !lTRepAndin .And. !(cPaisLoc $ "POR|EUA")
		aTasas := {}
		For i := 1  To ContaMoeda()
			Aadd(aTasas,IIf(RecMoeda(dDtBaixa,StrZero(i,1))==0,1,RecMoeda(dDtBaixa,StrZero(i,1))))
		Next
		If Len(aTasas) > 0
			nLin ++
			@ nLin,000 PSAY OemToAnsi(STR0025)+ Dtoc(SM2->M2_DATA) + " => "  //TAXAS EM
			For i:=2  to Len(aTasas)
				If i < 4
					@ nLin,IIf(i==2,25,55) PSAY Alltrim(GetMv("MV_MOEDA"+STR(i,1)))+" : "+Transform(aTasas[i],"99,999.9999")
				Else
					nLin := IIf(i==4,nLin+1,nLin)
					@ nLin,IIf(i==4,25,55) PSAY Alltrim(GetMv("MV_MOEDA"+STR(i,1)))+" : "+Transform(aTasas[i],"99,999.9999")
				Endif
			Next
		EndIf
    EndIf
	
	If lTRepAndin
		nTotMon1 := nTotMd1
		oReport:EndPage()
		nTotMon1:= 0
	EndIf

	If cPaisLoc == "ARG" .AND. nReImprimir == 1
		ImpCertificado(cOrdPago, cTipoOp)
	EndIf
	
	dbSelectArea(cString)
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o rodape                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IIf(nLin < 80, 	Roda(cbcont,cbtxt,tamanho),.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice ou consulta(Query)                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cString)
dbCloseArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
   dbCommitAll()	
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABEC85A  ºAutor  ³ Jose Novaes Romeu  º Data ³  12/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao de cabecalho personalizado.                      º±±
±±º          ³ Para manter compatibilidade com o que ja existe.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR085A                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Cabec85A(cOrdpago,nLin,Cabec1,Cabec2,dDtBaixa,lCBU)

Default lCBU := .F.

nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1

If lCBU
	@ nLin,045 PSAY OemToAnsi(STR0034)
	nLin ++
Endif
@ nLin,000 PSAY SM0->M0_NOMECOM
@ nLin,045 PSAY OemToAnsi(STR0007) + cOrdPago  //"ORDEM DE PGTO NR "
nLin ++
@ nLin,000 PSAY SM0->M0_ENDCOB
@ nLin,070 PSAY	dDtbaixa
nLin ++
@ nLin,000 PSAY SM0->M0_CEPCOB + " - " + SM0->M0_CIDCOB
nLin += 2
@ nLin,000 PSAY OemToAnsi(STR0008) + SA2->A2_COD + " - " + SA2->A2_NOME  //"BENEFICIARIO: "
nLin ++
@ nLin,000 PSAY REPLICATE("_",limite)
nLin ++

Return

Static Function ImpCertificado(cOrdPago, cTipoOp)	
	Local aArea		:= GetArea()
	Local aAreaSFE	:= SFE->( GetArea() )
	Local aCert		:= {}
	Local lCertGn	:= ExistBlock("CERTGAN")
	Local lCertIb	:= ExistBlock("CERTIB")
	Local lCertIvSus:= ExistBlock("CERTIVSUS")
	Local lCertCpr	:= ExistBlock("CERTCPR")
	Local i 		:= 0
	
	DbSelectArea("SFE")
	DbSetOrder(RETORDEM("SFE","FE_FILIAL+FE_ORDPAGO+FE_TIPO"))
	
	if SFE->(DbSeek(xFilial("SFE")+cOrdPago))
		while !SFE->(EOF()) .AND. xFilial("SFE") == SFE->FE_FILIAL .AND. SFE->FE_ORDPAGO == cOrdPago
			If !(Alltrim(SFE->FE_ORDPAGO) == "NORET") 	
				aadd(aCert,{SFE->FE_NROCERT,;	// [1]	Numero Certificado
							SFE->FE_TIPO,;		// [2]	Tipo
							"",;
							SFE->FE_CODASS,;
							SFE->FE_FORNECE,;
							SFE->FE_LOJA})					
			endif
			SFE->(dbSkip())
		End			
			
		for i := 1 To LEN(aCert)		
			If aCert[i][2] $ "G" .And. lCertGn
			 	ExecBlock("CERTGAN",.F.,.F.,{aCert[i],aCert[i][4]})
			ElseIf aCert[i][2] $ "I|S" .And. lCertIvSus
				ExecBlock("CERTIVSUS",.F.,.F.,{aCert[i],aCert[i][4],.F.})
			ElseIf aCert[i][2] $ "B" .And. lCertIb
				ExecBlock("CERTIB",.F.,.F.,{aCert[i],aCert[i][4],.F.})
			ElseIf aCert[i][2] $ "CPR" .And. lCertCpr
				ExecBlock("CERTCPR",.F.,.F.,{aCert[i],aCert[i][4],.F.})
			EndIf
		Next	
			
			
	Endif
	
	SFE->(RestArea( aAreaSFE ))
	RestArea( aArea )
	
Return
