/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Rwmake.ch"
#Include "TOPCONN.ch"
#Include "Protheus.ch"
#Include "CTBR823.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CTBR823  บ Autor ณ Marco A. Gonzalez  บFecha ณ  04/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑณDescri…o ณ Comprobantes Contables (COL)                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSintaxe   ณ U_CTBR823(ExpL1)                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ ExpL1 = Si Imprime                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGACTB                                                    บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             บฑฑ
ฑฑฬออออออออออออัออออออออัออออออัออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบProgramador ณ Data   ณ BOPS ณ  Motivo da Alteracao                     บฑฑ
ฑฑฬออออออออออออุออออออออุออออออุออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAlf. Medranoณ20/07/16ณTVQQA6ณse quita impresion de descrip de Centro deบฑฑ
ฑฑบ            ณ        ณ      ณcosto en func CTBR823Det() COL            บฑฑ
ฑฑฬออออออออออออุออออออออุออออออุออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบMarco A.    ณ12/09/16ณ      ณMerge V12.1.13, para Colombia.            บฑฑ
ฑฑศออออออออออออฯออออออออฯออออออฯออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function CTBR823(lBand)

	Private cPerg	:= "CTBR823"
	Private lRet	:= .T.

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณmv_par01 - De Documento?  ณ
	//ณmv_par02 - A Documento?   ณ
	//ณmv_par03 - De Lote?       ณ
	//ณmv_par04 - A Lote?        ณ
	//ณmv_par05 - Sublote?       ณ
	//ณmv_par06 - De Fecha?      ณ
	//ณmv_par07 - A Fecha?       ณ
	//ณmv_par08 - Tipo de Saldo? ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If lBand == NIL
		lRet := .F.
	Else
		lRet := .T.
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Imprimir relatorio desde Botใo Imprimir no PE - MT462MNU ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If Upper(Funname()) == "MATA101N" .AND. lBand == Nil		//Factura de Entrada
		
		dDataIn		:= CTOD("")
		dDataFin	:= CTOD("")
		cLotIni		:= ""
		cLotFin		:= ""
		cSbLotIni	:= ""
		cSbLotFin	:= ""
		cDctoIni	:= ""
		cDctoFin	:= ""
		cTipMon		:= "1"	//--- Tipo de Moneda
		cNomEmp		:= Posicione("SM0", 1, CEMPANT + CFILANT, "M0_NOMECOM")
		cNIT		:= Posicione("SM0", 1, CEMPANT + CFILANT, "M0_CGC")

		Pergunte(cPerg,.F.)
		CTBR823CT2(@dDataIn,@dDataFin,@cLotIni,@cLotFin,@cSbLotIni,@cSbLotFin,@cDctoIni,@cDctoFin)
		If !Empty(cDctoIni)
			Processa({ |lEnd| CTBR823Pri(), OemToAnsi(STR0002)}, OemToAnsi(STR0003)) //"Generando el Informe..." - "Espere un momento por favor..."
		Else
			Aviso(STR0004, STR0005 + SF1->F1_DOC + "/" + SF1->F1_SERIE, {STR0006}) //"Comprobante Contable" - "No se encontr๓ el comprobante contable para la Factura - " - "OK"
		EndIf
		Return
	Endif

	If !lBand
		If	( !Pergunte(cPerg,.T.) )
			Return
		Else
			cDctoIni	:= mv_par01			//--- Numero de Documento inicial
			cDctoFin	:= mv_par02			//--- Numero de Documento Final
			cLotIni		:= ALLTRIM(mv_par03)	//--- Lote Inicial
			cLotFin		:= ALLTRIM(mv_par04)	//--- Lote final
			cSbLotIni	:= ALLTRIM(mv_par05)	//--- Sub-Lote Tipo-Ingreso, Egreso, Diario
			cSbLotFin	:= ALLTRIM(mv_par05)
			dDataIn		:= mv_par06			//--- Fecha Inicial
			dDataFin	:= mv_par07			//--- Fecha Final
			cTipMon		:= mv_par08			//--- Tipo de Moneda
			cNomEmp		:= POSICIONE("SM0",1,CEMPANT+CFILANT,"M0_NOMECOM")
			cNIT		:= POSICIONE("SM0",1,CEMPANT+CFILANT,"M0_CGC")
		EndIf
		Processa({ |lEnd| CTBR823Pri(), OemToAnsi(STR0002)}, OemToAnsi(STR0003)) //"Generando el Informe..." - "Espere un momento por favor..."
	Else
		If IsInCallStack("U_CTB105OUTM")	//Ejecuci๓n antes de grabar CT2
			cDctoIni	:= PARAMIXB[4]		//--- Numero de Documento inicial
			cDctoFin	:= PARAMIXB[4]		//--- Numero de Documento Final
			cLotIni		:= PARAMIXB[2]		//--- Lote inicia
			cLotFin		:= PARAMIXB[2]		//--- Lote final
			cSbLotIni	:= PARAMIXB[3]		//--- Sublote inicial
			cSbLotFin	:= PARAMIXB[3]		//--- Sublote final
			dDataIn		:= dtos(PARAMIXB[1])	//--- Fecha Inicial
			dDataFin	:= PARAMIXB[1]		//--- Fecha Final
			cNomEmp   	:= POSICIONE("SM0",1,CEMPANT+CFILANT,"M0_NOMECOM")
			cNIT      	:= POSICIONE("SM0",1,CEMPANT+CFILANT,"M0_CGC")

		ElseIf IsInCallStack("U_DEPCTBGRV")	//Ejecucion despues de grabar CT2

			dDataIn		:= 	dtos(PARAMIXB[2])	//--- Fecha Inicial
			dDataFin	:=  PARAMIXB[2]		//--- Fecha Final
			cLotIni		:=  PARAMIXB[3]		//--- Lote Inicial
			cLotFin		:=  PARAMIXB[3]		//--- Lote Final
			cSbLotIni	:=  PARAMIXB[4]		//--- Sublote Inicial
			cSbLotFin	:=  PARAMIXB[4]		//--- Sublote final
			cDctoIni	:=  PARAMIXB[5]		//--- Numero de Documento inicial
			cDctoFin	:=  PARAMIXB[5]		//--- Numero de Documento Final
			cNomEmp		:= POSICIONE("SM0",1,CEMPANT+CFILANT,"M0_NOMECOM")
			cNIT		:= POSICIONE("SM0",1,CEMPANT+CFILANT,"M0_CGC")
		EndIf

		Processa({ |lEnd| CTBR823Pri(), OemToAnsi(STR0002)}, OemToAnsi(STR0003)) //"Generando el Informe..." - "Espere un momento por favor..."
	EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR823Priบ Autor ณ Marco A. Gonzalez  บFecha ณ  04/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑณDescri…o ณ Impresion del Titulos (COL)                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR823                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function  CTBR823Pri()

	Private oPrint		:= TMSPrinter():New(OemToAnsi(STR0007)) //"Comprobantes Contables"
	Private oBrush		:= TBrush():New(,4)
	Private oPen		:= TPen():New(0,5,CLR_BLACK)
	Private oFont07		:= TFont():New('Arial', 07, 07, , .F., , , ,.T., .F.)
	Private oFont07n	:= TFont():New('Arial', 07, 07, , .T., , , ,.T., .F.)
	Private oFont08		:= TFont():New('Arial', 08, 08, , .F., , , ,.T., .F.)
	Private oFont08n	:= TFont():New('Arial', 08, 08, , .T., , , ,.T., .F.)
	Private oFont09		:= TFont():New('Arial', 09, 09, , .F., , , ,.T., .F.)
	Private oFont09n	:= TFont():New('Arial', 09, 09, , .T., , , ,.T., .F.)
	Private oFont10		:= TFont():New('Arial', 10, 10, , .F., , , ,.T., .F.)
	Private oFont10n	:= TFont():New('Arial', 10, 10, , .T., , , ,.T., .F.)
	Private oFont11		:= TFont():New('Arial', 11, 11, , .F., , , ,.T., .F.)
	Private oFont12		:= TFont():New('Arial', 12, 12, , .T., , , ,.T., .F.)
	Private oFont14n	:= TFont():New('Arial', 14, 14, , .T., , , ,.T., .F.)
	Private oFont16		:= TFont():New('Arial', 16, 16, , .T., , , ,.T., .F.)
	Private oFont18		:= TFont():New('Arial', 18, 18, , .T., , , ,.T., .T.)
	Private nRegLin		:= 470
	Private nTMoeda		:= '$'
	Private nValDesc	:= 0
	Private nValImp		:= 0
	Private oFont22		:= TFont():New('Arial', 22, 22, , .T., , , , .T., .F.)

	Private cTitulo		:= STR0008 + ALLTRIM(cNomemp) //"COMPROBANTE CONTABLE "
	Private cSubTit		:= STR0009 + ALLTRIM(cNIT) //"NIT: "
	Private nTotalDebe	:= 0
	Private nTotalHabe	:= 0
	Private nLinea		:= 100
	Private nDocDebe	:= 0
	Private nDocHaber	:= 0
	Private nLotDebe	:= 0
	Private nLotHaber	:= 0
	Private nMesDebe	:= 0
	Private nMesHaber	:= 0

	oPrint:StartPage()
	CTBR823Cab()

	If !lRet
		CTBR823Det()
	Else
		CTBR823DeP()
	EndIf

	oPrint:Preview()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR823Cabบ Autor ณ Marco A. Gonzalez  บFecha ณ  04/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑณDescri…o ณ Impresion del Encabezado (COL)                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR823                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function CTBR823Cab()

	Local cLog1		:= ""
	Local cFileLog1	:=  GetSrvProfString(STR0010,"") + cLog1	// Logo seg๚n filial en caso de requerirse //STR -> "Startpath"

	// PARA INCLUSION DE LOGO EN EL INFORMES
	oPrint:SayBitmap(050,050,cFileLog1,0300,300) //  y,x,archivo, ancho, alto     LOGO DE MOTO
	oPrint:Say(0150, 0400,  ALLTRIM(cNomEmp),oFont16)
	oPrint:Say(0230, 1100, STR0008, oFont10) //COMPROBANTE CONTABLE "
	oPrint:Say(0220, 0400,  STR0009 + ALLTRIM(cNIT),oFont16) //"NIT: "

	oPrint:Box(0385, 0050, 0455, 3420)
	oPrint:Say(0399, 0060, STR0011, oFont10) //"Cuenta."
	oPrint:Say(0399, 0270, STR0012, oFont10) //"Descripcion"
	oPrint:Say(0399, 0890, STR0013, oFont10) //"Historial"
	oPrint:Say(0399, 1690, STR0014, oFont10) //"C.C. D/H."
	oPrint:Say(0399, 2090, STR0015, oFont10) //"NIT D/H."
	oPrint:Say(0399, 2790, STR0016, oFont10) //"Debito."
	oPrint:Say(0399, 3280, STR0017, oFont10) //"Credito."

	nLinea := 500

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR823Detบ Autor ณ Marco A. Gonzalez  บFecha ณ  04/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑณDescri…o ณ Impresion del Detalle (COL)                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR823                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function CTBR823Det()

	Local cArea			:= GetArea()
	Local cQuery		:= ""
	Local cTablaTemp	:= CriaTrab(nil, .f.)
	Local cTabCT2		:= InitSqlName("CT2")
	Local cTabCT1		:= InitSqlName("CT1")
	Local cFilCT1		:= xFilial("CT1")
	Local cTabCTT		:= InitSqlName("CTT")
	Local cTabCTD		:= InitSqlName("CTD")
	Local cTabCTH		:= InitSqlName("CTH")
	Local cDoc			:= ""
	Local nLote			:= ""
	Local dFecha		:= ""
	Local nDocDebe		:= 0
	Local nDocHaber		:= 0
	Local nLoteDebe		:= 0
	Local nLoteHaber	:= 0
	Local nMesDebe		:= 0
	Local nMesHaber		:= 0
	Local nTotalDebe	:= 0
	Local nTotalHabe	:= 0
	Local cTipoC		:= ""
	Local nCredito		:= 0
	Local nDebito		:= 0
	Local cObservac		:= ""
	Local cNumInt		:= ""
	Local cPicture 		:= "@r 999,999,999,999,999.99"

	cQryWhere := ""

	IF (ALLTRIM(cDctoIni) = "" .AND. ALLTRIM(cDctoFin) = "ZZZZZZ")
	ELSE
		cQryWhere += " AND CT2_DOC BETWEEN '" + cDctoIni + "' AND '" + cDctoFin + "'"
	END IF
	IF (cLotIni = "" .AND. cLotFin = "ZZZZZZ")
	ELSE
		cQryWhere += " AND CT2_LOTE BETWEEN '" + ALLTRIM(cLotIni) + "' AND '" + ALLTRIM(cLotFin) + "'"
	END IF

	cSbCod := POSICIONE("SX5",1,xFilial("SX5")+"SB","X5_CHAVE")

	cQryWhere += " AND CT2_SBLOTE = '" + ALLTRIM(cSbLotFin) + "'"

	cQuery := "SELECT CT2_DC,CT2_DOC, CT2_DATA, CT2_DEBITO, CT2_CREDIT, CT2_OBSCNF,CT2_ATIVDE,CT2_EC05DB,CT2_EC05CR,"
	cQuery += "  CASE WHEN (CT1.CT1_DESC01) IS NULL THEN '' ELSE CT1.CT1_DESC01 END CT1_DESC01,"
	cQuery += "  CASE WHEN (CT1_2.CT1_DESC01) IS NULL THEN '' ELSE CT1_2.CT1_DESC01 END CT1_2_DESC01,"
	cQuery += "  CT2_LINHA, CT2_HIST, CT2_CCD,"
	cQuery += "  CASE WHEN (CTT.CTT_DESC01) IS NULL THEN '' ELSE CTT.CTT_DESC01 END CTT_DESC01,"
	cQuery += "  CT2_CCC,"
	cQuery += "  CT2_ITEMD,"
	cQuery += "  CASE WHEN (CTD.CTD_DESC01) IS NULL THEN '' ELSE CTD.CTD_DESC01 END CTD_DESC01,"
	cQuery += "  CT2_ITEMC,"
	cQuery += "  CASE WHEN (CTD_2.CTD_DESC01) IS NULL THEN '' ELSE CTD_2.CTD_DESC01 END CTD_2_DESC01,"
	cQuery += "  CT2_CLVLDB,"
	cQuery += "  CT2_MOEDLC, CT2_VALOR, CT2_LOTE, CT2_SBLOTE"

	If AllTrim(cFilCT1) <> "" //Verifica si la Tabla de CT1 estแ Exclusiva
		cQuery += " FROM "+ cTabCT2 +" CT2 LEFT JOIN " + cTabCT1 + " CT1 ON CT2.CT2_FILIAL = CT1.CT1_FILIAL"
		cQuery += "   AND CT2.CT2_DEBITO = CT1.CT1_CONTA AND CT1.D_E_L_E_T_ = '' "
		cQuery += " LEFT JOIN " + cTabCT1 + " CT1_2 ON  CT2.CT2_FILIAL = CT1_2.CT1_FILIAL"
	Else //Verifica si la Tabla de CT1 estแ Compartida
		cQuery += " FROM "+ cTabCT2 +" CT2 LEFT JOIN " + cTabCT1 + " CT1 ON CT2.CT2_DEBITO = CT1.CT1_CONTA"
		cQuery += "   AND CT2.CT2_DEBITO = CT1.CT1_CONTA AND CT1.D_E_L_E_T_ = '' "
		cQuery += " LEFT JOIN " + cTabCT1 + " CT1_2 ON CT2.CT2_CREDIT = CT1_2.CT1_CONTA"
	End If

	cQuery += " AND CT2.CT2_CREDIT   = CT1_2.CT1_CONTA AND CT1_2.D_E_L_E_T_ = '' "
	cQuery += " LEFT JOIN " + cTabCTT + " CTT ON  CT2.CT2_FILIAL = CTT.CTT_FILIAL"
	cQuery += " AND CT2.CT2_CCD    = CTT.CTT_CUSTO AND CTT.D_E_L_E_T_ = '' "
	cQuery += " LEFT JOIN " + cTabCTT + " CTT_2 ON  CT2.CT2_FILIAL = CTT_2.CTT_FILIAL"
	cQuery += " AND CT2.CT2_CCC      = CTT_2.CTT_CUSTO AND CTT_2.D_E_L_E_T_ = '' "
	cQuery += " LEFT JOIN " + cTabCTD + " CTD ON  CT2.CT2_FILIAL = CTD.CTD_FILIAL"
	cQuery += " AND CT2.CT2_ITEMD  = CTD.CTD_ITEM AND CTD.D_E_L_E_T_ = '' "
	cQuery += " LEFT JOIN " + cTabCTD + " CTD_2 ON  CT2.CT2_FILIAL = CTD_2.CTD_FILIAL"
	cQuery += " AND CT2.CT2_ITEMC    = CTD_2.CTD_ITEM AND CTD_2.D_E_L_E_T_ = '' "
	cQuery += " LEFT JOIN " + cTabCTH + " CTH ON  CT2.CT2_FILIAL = CTH.CTH_FILIAL"
	cQuery += " AND CT2.CT2_CLVLDB = CTH.CTH_CLVL AND CTH.D_E_L_E_T_ = '' "
	cQuery += " LEFT JOIN " + cTabCTH + " CTH_2 ON  CT2.CT2_FILIAL = CTH_2.CTH_FILIAL"
	cQuery += " AND CT2.CT2_CLVLCR   = CTH_2.CTH_CLVL AND CTH_2.D_E_L_E_T_ = '' "
	cQuery += " WHERE CT2.D_E_L_E_T_ = ''"
	cQuery += " AND CT2_DATA BETWEEN '" + DTOS(dDataIn) + "' AND '" + DTOS(dDataFin) + "'"
	cQuery += cQryWhere
	cQuery += " ORDER BY CT2.CT2_DATA ASC, CT2.CT2_LOTE, CT2.CT2_SBLOTE, CT2.CT2_DOC,CT2.CT2_LINHA"
	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T., "TOPCONN", TcGenQry(,,cQuery), cTablaTemp, .T., .T.)

	Do While !( (cTablaTemp)->(EOF()) )
		IF ((cTablaTemp)->(CT2_LOTE) >= cLotIni .AND. (cTablaTemp)->(CT2_LOTE) <= cLotFin) // Verifica que este en el rango de lotes
			IF ALLTRIM((cTablaTemp)->(CT2_SBLOTE)) == cSbLotFin // verifica el sublote
				IF ((cTablaTemp)->(CT2_DOC) >= cDctoIni .AND. (cTablaTemp)->(CT2_DOC) <= cDctoFin )   // que este dentro de los documentos

					IF (cTablaTemp)->(CT2_MOEDLC) <> "01"
						(cTablaTemp)->(dbSkip())
					END IF
					If (cDoc >= cDctoIni  .and. cDoc <= cDctoFin) .and. (cDoc <> (cTablaTemp)->(CT2_DOC) .OR. nLote <> (cTablaTemp)->(CT2_LOTE) .OR. dFecha <> (cTablaTemp)->(CT2_DATA)) // Si cambia cualquiera cambia de poliza
						nLinea:= nLinea + 100
						oPrint:Say(0330, 0060, STR0018 + cDoc + "-" + nLote  + "-" + cSbLotFin,oFont12) //"N๚mero de comprobante "
						oPrint:Say(0330, 1250, SubStr(dFecha,7,2) + "/" + SubStr(dFecha,5,2) + "/" + SubStr(dFecha,1,4),oFont12)
						oPrint:Say(0330, 2000, STR0019 + (cTablaTemp)->(CT2_ATIVDE) ,oFont12) //"Num Int: "

						oPrint:Say(nLinea, 0060, STR0020 + cDoc + transform(nLote,  "@r 999") + cSbLotFin, oFont12) //"Total Comprobante: "
						oPrint:Say(nLinea, 2900, RTrim(transform(nDocDebe ,cPicture)), oFont12, , , , 1) //Total Debito
						oPrint:Say(nLinea, 3400, RTrim(transform(nDocHaber,cPicture)), oFont12, , , , 1) //Total Credito
						nDocDebe  := 0
						nDocHaber := 0
						nLinea    := 2500
					END IF
					IF nLinea > 2300
						CTBR823Pag()
					END IF

					//Para hacer los acumulados
					If (cTablaTemp)->(CT2_DC) = "3"
						cTipoC   := "P"
						nCredito := (cTablaTemp)->(CT2_VALOR)
						nDebito  := (cTablaTemp)->(CT2_VALOR)
					ElseIf (cTablaTemp)->(CT2_DC) = "2"
						cTipoC   := "C"
						nCredito := (cTablaTemp)->(CT2_VALOR)
						nDebito  := 0
					Else
						cTipoC   := "D"
						nDebito  := (cTablaTemp)->(CT2_VALOR)
						nCredito := 0
					Endif

					If (cTablaTemp)->(CT2_DC) = "3"
						oPrint:Say(nLinea, 0060, ALLTRIM((cTablaTemp)->(CT2_DEBITO)), oFont10)						//CuentaDeb
						oPrint:Say(nLinea, 0270, ALLTRIM(SUBSTR((cTablaTemp)->(CT1_DESC01)		, 1, 30)), oFont08)	//Descripcion
						nLinea := nLinea + 100
						oPrint:Say(nLinea, 0060, ALLTRIM((cTablaTemp)->(CT2_CREDIT)), oFont10)						//CuentaCrd
						oPrint:Say(nLinea, 0270, ALLTRIM(SUBSTR((cTablaTemp)->(CT1_2_DESC01)	, 1, 30)), oFont08)	//Descripcion
					Else
						oPrint:Say(nLinea, 0060, ALLTRIM((cTablaTemp)->(CT2_DEBITO)), oFont10)						//CuentaDeb
						oPrint:Say(nLinea, 0060, ALLTRIM((cTablaTemp)->(CT2_CREDIT)), oFont10)						//CuentaCrd
						oPrint:Say(nLinea, 0270, ALLTRIM(SUBSTR((cTablaTemp)->(CT1_DESC01)		, 1, 30)), oFont08)	//Descripcion
						oPrint:Say(nLinea, 0270, ALLTRIM(SUBSTR((cTablaTemp)->(CT1_2_DESC01)	, 1, 30)), oFont08)	//Descripcion
					End If
					IF ALLTRIM((cTablaTemp)->(CT2_DC)) <> "4"
						IF ALLTRIM((cTablaTemp)->(CT2_DC)) == "3"
							oPrint:Say(nLinea-100, 2900, rTrim(transform(nDebito,	cPicture))	,oFont10, , , , 1)	//Linea Debito
							oPrint:Say(nLinea, 3400, rTrim(transform(nCredito,	cPicture))	, oFont10, , , , 1)	//Linea Credito
						ELSE
							IF nDebito > 0
								oPrint:Say(nLinea, 2900, rTrim(transform(nDebito,	cPicture))	, oFont10, , , , 1)	//Linea Debito
							END IF
							IF nCredito > 0
								oPrint:Say(nLinea, 3400, rTrim(transform(nCredito,	cPicture))	, oFont10, , , , 1)	//Linea Credito
							END IF
						END IF
					ENDIF
					If ALLTRIM((cTablaTemp)->(CT2_DC)) == "3"
						nLinea := nLinea - 100
						oPrint:Say(nLinea, 0890, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_HIST)	, 1, 30)), oFont08)	//Historial
						oPrint:Say(nLinea, 1690, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_CCD)	, 1, 9 )), oFont10)	//CC.Debe
						oPrint:Say(nLinea, 2090, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_EC05DB)	, 1, 16)), oFont10)	//NIT Debito
						nLinea := nLinea + 100
						oPrint:Say(nLinea, 0890, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_HIST)	, 1, 30)), oFont08)	//Historial
						oPrint:Say(nLinea, 1690, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_CCC)	, 1, 9 )), oFont10)	//CC.Haber
						oPrint:Say(nLinea, 2090, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_EC05CR)	, 1, 16)), oFont10)	//NIT Credito
					Else
						oPrint:Say(nLinea, 0890, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_HIST)		, 1, 30)), oFont08)	//Historial
						oPrint:Say(nLinea, 1690, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_CCD)		, 1, 9 )), oFont10)	//CC.Debe
						oPrint:Say(nLinea, 1690, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_CCC)		, 1, 9 )), oFont10)	//CC.Haber
						oPrint:Say(nLinea, 2090, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_EC05DB)		, 1, 16)), oFont10)	//NIT D
						oPrint:Say(nLinea, 2090, ALLTRIM(SUBSTR((cTablaTemp)->(CT2_EC05CR)		, 1, 16)), oFont10)	//NIT C
					EndIf
					//----- Suma Los valores a calcular -------////
					nDocDebe	:= nDocDebe	+ nDebito
					nDocHaber	:= nDocHaber	+ nCredito
					nLoteDebe	:= nLoteDebe	+ nDebito
					nLoteHaber	:= nLoteHaber	+ nCredito
					nMesDebe	:= nMesDebe	+ nDebito
					nMesHaber	:= nMesHaber	+ nCredito
					nTotalDebe	:= nTotalDebe	+ nDebito
					nTotalHabe	:= nTotalHabe	+ nCredito
					cObservac	+= ALLTRIM((cTablaTemp)->(CT2_OBSCNF))
					cNumInt	:= (cTablaTemp)->(CT2_ATIVDE)
					//----- Termina Suma Los valores a calcular -------////
					nLinea := nLinea + 100
					cDoc  := (cTablaTemp)->(CT2_DOC)
				END IF // validacion de documento
				cSbLotIni :=CT2->CT2_SBLOTE
			END IF // validacion del lote
			nLote  := (cTablaTemp)->(CT2_LOTE)
			dFecha := (cTablaTemp)->(CT2_DATA)
		END IF // validacion del parametro
		(cTablaTemp)->(dbSkip())
	EndDo

	oPrint:Say(0330, 0060, STR0018 + cDoc + "-" + nLote + "-" + cSbLotFin, oFont12) //"N๚mero de Comprobante "
	oPrint:Say(0330, 1250, SubStr((dFecha), 7, 2) + "/" + SubStr((dFecha), 5, 2) + "/" + SubStr((dFecha), 1, 4), oFont12)
	oPrint:Say(0330, 2000, STR0019 +  (cTablaTemp)->(CT2_ATIVDE) ,oFont12) //"Num Int: "
	nLinea := nLinea + 100
	oPrint:Say(nLinea, 0060, STR0021 + STR0021, oFont10) //"----------------------------------------------------------------------------------------------"
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0022 +  cObservac, oFont12) //"Observaciones: "
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0021 + STR0021, oFont10) //"----------------------------------------------------------------------------------------------"
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0018 + cDoc + transform(nLote,  "@r 999") + cSbLotFin, oFont12) //"Total Comprobante: "
	oPrint:Say(nLinea, 2900, RTrim(transform(nDocDebe,  cPicture)), oFont12, , , , 1)
	oPrint:Say(nLinea, 3400, RTrim(transform(nDocHaber, cPicture)), oFont12, , , , 1)
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0021 + STR0021, oFont10) //"----------------------------------------------------------------------------------------------"
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0023,oFont14n) //"Total General Informe: "
	oPrint:Say(nLinea, 2900, RTrim(transform(nTotalDebe,	cPicture)), oFont12, , , , 1)
	oPrint:Say(nLinea, 3400, RTrim(transform(nTotalHabe,	cPicture)), oFont12, , , , 1)
	nLinea:= nLinea + 30

	(cTablaTemp)->(dbCloseArea())
	RestArea(cArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR823Pagบ Autor ณ Marco A. Gonzalez  บFecha ณ  04/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑณDescri…o ณ Funcion para revisar el salto de pagina del informe (COL)  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR823                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function CTBR823Pag()
	If (nLinea >= 2300)
		CTBR823Cab()
		nLinea := 360
		oPrint:EndPage()
		oPrint:StartPage()
		CTBR823Cab()
	EndIf
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR823DePบ Autor ณ Marco A. Gonzalez  บFecha ณ  04/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑณDescri…o ณ Impresion del Detalle P (COL)                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR823                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function CTBR823DeP()

	Local cArea			:= GetArea()
	Local nDocDebe		:= 0
	Local nDocHaber		:= 0
	Local nLoteDebe		:= 0
	Local nLoteHaber	:= 0
	Local nMesDebe		:= 0
	Local nMesHaber		:= 0
	Local nTotalDebe	:= 0
	Local nTotalHabe	:= 0
	Local cTipoC		:= ""
	Local nCredito		:= 0
	Local nDebito		:= 0
	Local cObservac		:= ""
	Local cNumInt		:= TMP->CT2_ATIVDE
	Local cPicture 		:= "@r 999,999,999,999,999.99"

	IF nLinea > 2300
		CTBR823Pag()
	END IF

	//Para hacer los acumulados
	TMP->(DBGOTOP())
	While !(TMP->(EOF()))
		IF nLinea > 2300
			CTBR823Pag()
		END IF
		If TMP->CT2_FLAG
			TMP->(dbSkip())
			Loop
		EndIf
		If TMP->CT2_DC = "3"
			cTipoC   := "P"
			nCredito := TMP->CT2_VALOR
			nDebito  := TMP->CT2_VALOR
		ElseIf TMP->CT2_DC = "2"
			cTipoC   := "C"
			nCredito := TMP->CT2_VALOR
			nDebito  := 0
		Else
			cTipoC   := "D"
			nDebito  := TMP->CT2_VALOR
			nCredito := 0
		Endif

		// Para impresion desde orden de pago.
		If TMP->CT2_DC = "3"
			oPrint:Say(nLinea, 0060, ALLTRIM(TMP->CT2_DEBITO), oFont07)	//CuentaDeb
			cDesc:=SUBSTR(Posicione("CT1", 1, xfilial("CT1")+TMP->CT2_DEBITO, "CT1_DESC01"), 1, 30)
			oPrint:Say(nLinea, 0270, ALLTRIM(cDesc) ,oFont07)	//Descripcion
			nLinea := nLinea + 100
			oPrint:Say(nLinea, 0060, ALLTRIM(TMP->CT2_CREDIT) ,oFont07)
			cDesc:=SUBSTR(Posicione("CT1", 1, xfilial("CT1")+TMP->CT2_CREDIT, "CT1_DESC01"), 1, 30)
			oPrint:Say(nLinea, 0270, ALLTRIM(cDesc) ,oFont07)	//Descripcion
		Else
			oPrint:Say(nLinea, 0060, ALLTRIM(TMP->CT2_DEBITO) ,oFont07)	//CuentaDeb
			oPrint:Say(nLinea, 0060, ALLTRIM(TMP->CT2_CREDIT) ,oFont07)	//CuentaCrd
			cDesc:=SUBSTR(Posicione("CT1", 1, xfilial("CT1")+TMP->CT2_DEBITO, "CT1_DESC01"), 1, 30)
			oPrint:Say(nLinea, 0270, ALLTRIM(cDesc) ,oFont07)	//Descripcion
			cDesc:=SUBSTR(Posicione("CT1", 1, xfilial("CT1")+TMP->CT2_CREDIT, "CT1_DESC01"), 1, 30)
			oPrint:Say(nLinea, 0270, ALLTRIM(cDesc), oFont07)	//Descripcion
		End If
		IF ALLTRIM(TMP->CT2_DC) <> "4"
			IF ALLTRIM(TMP->CT2_DC) == "3"
				oPrint:Say(nLinea-100, 2900, RTrim(transform(nDebito,	cPicture)), oFont07, , , , 1)	//Linea Debito
				oPrint:Say(nLinea, 3400, RTrim(transform(nCredito,	cPicture)), oFont07, , , , 1)	//Linea Credito
			ELSE
				IF nDebito > 0
					oPrint:Say(nLinea, 2900, RTrim(transform(nDebito,	cPicture)), oFont07, , , , 1)	//Linea Debito
				END IF
				IF nCredito > 0
					oPrint:Say(nLinea, 3400, RTrim(transform(nCredito,	cPicture)), oFont07, , , , 1)	//Linea Credito
				END IF
			ENDIF
		ENDIF
		If ALLTRIM(TMP->CT2_DC) == "3"
			nLinea := nLinea - 100
			oPrint:Say(nLinea, 0890, ALLTRIM(SUBSTR(TMP->CT2_HIST	, 1, 30)), oFont07)	//Historial
			oPrint:Say(nLinea, 1690, ALLTRIM(SUBSTR(TMP->CT2_CCD		, 1, 9 )), oFont07)	//CC.Debe
			oPrint:Say(nLinea, 2090, ALLTRIM(SUBSTR(TMP->CT2_EC05DB	, 1, 16)), oFont07)	//NIT Debito
			nLinea := nLinea + 100
			oPrint:Say(nLinea, 0890, ALLTRIM(SUBSTR(TMP->CT2_HIST	, 1, 30)), oFont07)	//Historial
			oPrint:Say(nLinea, 1690, ALLTRIM(SUBSTR(TMP->CT2_CCC		, 1, 9 )), oFont07)	//CC.Haber
			oPrint:Say(nLinea, 2090, ALLTRIM(SUBSTR(TMP->CT2_EC05CR	, 1, 16)), oFont07)	//NIT Credito
		Else
			oPrint:Say(nLinea, 0890, ALLTRIM(SUBSTR(TMP->CT2_HIST	, 1, 30)), oFont07)	//Historial
			oPrint:Say(nLinea, 1690, ALLTRIM(SUBSTR(TMP->CT2_CCD		, 1, 16)), oFont07)	//CC.Debe
			oPrint:Say(nLinea, 1690, ALLTRIM(SUBSTR(TMP->CT2_CCC		, 1, 16)), oFont07)	//CC.Haber
			oPrint:Say(nLinea, 2090, ALLTRIM(SUBSTR(TMP->CT2_EC05DB	, 1, 9 )), oFont07)	//NIT D
			oPrint:Say(nLinea, 2090, ALLTRIM(SUBSTR(TMP->CT2_EC05CR	, 1, 9 )), oFont07)	//NIT C
		EndIf

		//----- Suma Los valores a calcular -------////
		nDocDebe	:= nDocDebe	+ nDebito
		nDocHaber	:= nDocHaber	+ nCredito
		nLoteDebe	:= nLoteDebe	+ nDebito
		nLoteHaber	:= nLoteHaber	+ nCredito
		nMesDebe	:= nMesDebe	+ nDebito
		nMesHaber	:= nMesHaber	+ nCredito
		nTotalDebe	:= nTotalDebe	+ nDebito
		nTotalHabe	:= nTotalHabe	+ nCredito
		cObservac	:= cObservac	+ ALLTRIM(TMP->CT2_OBSCNF)
		//----- Termina Suma Los valores a calcular -------////
		nLinea := nLinea + 100
		TMP->(dbSkip())
	Enddo

	oPrint:Say(0330, 0060, STR0018 + cDctoIni + "-" + cLotIni + "-" + cSbLotIni, oFont12) //STR->"N๚mero de comprobante "
	oPrint:Say(0330, 1250, SubStr((dDataIn), 7, 2) + "/" + SubStr((dDataIn), 5, 2) + "/" + SubStr((dDataIn), 1, 4), oFont12)
	oPrint:Say(0330, 2000, STR0019 +  cNumInt, oFont12) //"Num Int: "
	nLinea := nLinea + 100
	oPrint:Say(nLinea, 0060, STR0021 + STR0021, oFont10) //"----------------------------------------------------------------------------------------------"
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0022 +  cObservac, oFont12) //"Observaciones: "
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0021 + STR0021, oFont10) //"----------------------------------------------------------------------------------------------"
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0020 + cDctoIni + transform(cLotIni,  "@r 999") + cSbLotIni, oFont12) //"Total comprobante: "
	oPrint:Say(nLinea, 2900, RTrim(transform(nDocDebe,	cPicture)), oFont12, , , , 1)
	oPrint:Say(nLinea, 3400, RTrim(transform(nDocHaber,	cPicture)), oFont12, , , , 1)
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0021 + STR0021, oFont10) //"----------------------------------------------------------------------------------------------"
	nLinea:= nLinea + 30
	oPrint:Say(nLinea, 0060, STR0023,oFont14n) //"Total General Informe: "
	oPrint:Say(nLinea, 2900, RTrim(transform(nTotalDebe,	cPicture)), oFont12, , , , 1)
	oPrint:Say(nLinea, 3400, RTrim(transform(nTotalHabe,	cPicture)), oFont12, , , , 1)
	nLinea:= nLinea + 30

	TMP->(DBGOTOP())
	RestArea(cArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR823CT2บ Autor ณ Marco A. Gonzalez  บFecha ณ  04/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑณDescri…o ณ Busca CT2 - Asientos Contables (COL)                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTBR823                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function CTBR823CT2(dDataIn,dDataFin,cLotIni,cLotFin,cSbLotIni,cSbLotFin,cDctoIni,cDctoFin)

	Local cQuery	:= ""
	Local cKey		:= SF1->F1_FILIAL+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA+SF1->F1_TIPO+SF1->F1_ESPECIE

	cQuery := "SELECT * "
	cQuery += " FROM " + RetSqlName("CT2") + " CT2"
	cQuery += " WHERE CT2.D_E_L_E_T_ = '' "
	cQuery += " AND CT2_KEY = '" + cKey + "'"
	cQuery := ChangeQuery(cQuery)

	If Select("StrSQL") > 0  //En uso
		StrSQL->(DbCloseArea())
	Endif
	dbUseArea(.T.,'TOPCONN', TCGenQry(,,cQuery),"StrSQL", .F., .T.)

	DbSelectArea("StrSQL")
	DbGoTop()
	If !Empty(StrSQL->(CT2_DOC))
		dDataIn		:= STOD(StrSQL->(CT2_DATA))
		dDataFin	:= STOD(StrSQL->(CT2_DATA))
		cLotIni		:= StrSQL->(CT2_LOTE)
		cLotFin		:= StrSQL->(CT2_LOTE)
		cSbLotIni	:= StrSQL->(CT2_SBLOTE)
		cSbLotFin	:= StrSQL->(CT2_SBLOTE)
		cDctoIni	:= StrSQL->(CT2_DOC)
		cDctoFin	:= StrSQL->(CT2_DOC)
	Else
		dDataIn		:= ""
		dDataFin	:= ""
		cLotIni		:= ""
		cLotFin		:= ""
		cSbLotIni	:= ""
		cSbLotFin	:= ""
		cDctoIni	:= ""
		cDctoFin	:= ""
	Endif
	StrSQL->(dbCloseArea())

Return
