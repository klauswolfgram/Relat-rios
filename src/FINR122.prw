/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"
#Include "FINR122.ch"

#define PIX_DIF_COLUNA_VALORES		300		// Pixel inicial para impressao dos tracos das colunas dinamicas
#define PIX_INICIAL_VALORES			110		// Pixel para impressao do traco vertical
#define PIX_EQUIVALENTE				120		// Pixel inicial para impressao das colunas dinamicas
#define PIX_TAM_VERT                030     // Tamaño de lineas verticales por renglón.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR1_02  º Autor ³ Totvs              º Data ³  14/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³LIBRO CAJA Y BANCOS DETALLE DE LOS MOV. LA CUENTA CORRIENTE º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³FINR1_02 - Localização Peru                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR122()
	
	Local cPerg		:= "FIN122"
	Local olReport	:= Nil
	
	Private aRenglon := {}

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ MV_PAR01 - ¿De fecha?                                            ³
	³ MV_PAR02 - ¿A fecha?                                             ³
	³ MV_PAR03 - ¿De Sucursal? 										   ³
	³ MV_PAR04 - ¿A Sucursal?										   ³
	³ MV_PAR05 - ¿Generar Archivo TXT? 							       ³
	³ MV_PAR06 - ¿Ruta para generar  TXT? 							   ³
	³ MV_PAR07 - ¿Moneda? 										       ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	olReport := FinRelat(cPerg)
	olReport:SetParam(cPerg)
	olReport:PrintDialog()
	
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FINRelat  ³ Autor ³ Totvs                 ³ Data | 14/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Criação do objeto TReport para a impressão do relatorio.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FinRelat( cPerg )           				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 = Perguntas dos parametros                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FinRelat( cPerg )
Local clNomProg	:= FunName()
Local clTitulo 	:= STR0038 + STR0001 //"FORMATO 1.2:"+"LIBRO CAJA Y BANCOS – DETALLE DE LOS MOVIMIENTOS DE LA CUENTA CORRIENTE"
Local clDesc   	:= STR0038 + STR0001 //"FORMATO 1.2:"+"LIBRO CAJA Y BANCOS – DETALLE DE LOS MOVIMIENTOS DE LA CUENTA CORRIENTE"
Local olReport	:= Nil

olReport:=TReport():New(clNomProg,clTitulo,cPerg,{|olReport| FinPrc122(olReport)},clDesc)
olReport:SetLandscape()					// Formato paisagem
olReport:lHeaderVisible 	:= .F. 		// Não imprime cabeçalho do protheus
olReport:lFooterVisible 	:= .F.		// Não imprime rodapé do protheus
olReport:lParamPage			:= .F.		// Não imprime pagina de parametros
olReport:oPage:nPaperSize	:= 9		// Impresion en papel A4

Return olReport

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FinpRC122 ³ Autor ³ Totvs                 ³ Data | 14/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressão do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FinProc( ExpC1 )         				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 = Objeto tReport                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FinPrc122( olReport )

	Private cTabela14	:= ""
	Private cExpMda		:= ""
	Private cBanco		:= GetMv("MV_CAJALF")
	Private lAutomato   := isBlind() //Variable utilizada para automatización.
	Private lImpSldIni	:= .T.

	Pergunte(olReport:GetParam(),.F.)
	
	DbSelectArea("CT1")
	CT1->(DbSetOrder(1)) //CT1_FILIAL+CT1_CONTA
	DbSelectArea("CT2")
	CT2->(DbSetORder(16)) //CT2_FILIAL+CT2_NODIA

	// Carrega a tabela 14 - Da mesma forma como feita no extrato bancario - FINR470
	SX5->(DbSetOrder(1)) //X5_FILIAL + X5_TABELA + X5_CHAVE
	SX5->(MsSeek(xFilial("SX5")+"14"))
	While SX5->(!Eof()) .And. SX5->X5_TABELA == "14"
		cTabela14 += (Alltrim(SX5->X5_CHAVE) + "/")
		SX5->(DbSkip())
	End

	cTabela14 += If(cPaisLoc=="BRA","","/$ ")
	cExpMda	:= " E5_MOEDA NOT IN " + FormatIn(cTabela14,"/")

	If MV_PAR05== 1
		if !lAutomato
   			Processa({|| GerArq(AllTrim(MV_PAR06),olReport)},,STR0040 ) //"Generando archivo"
		Else
			ConOut(STR0040)
			GerArq(AllTrim(MV_PAR06),olReport)
		EndIf
	Else
		if !lAutomato
			Processa({|| GerReporte(olReport,AllTrim(MV_PAR06))},,"Imprimiendo" )
		Else
			GerReporte(olReport,AllTrim(MV_PAR06))
		EndIf
	EndIf
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GerReporte³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Define la impresion del informe.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GerReporte(ExpO1,ExpC1)  				                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1 = Objeto tReport                                      ³±±
±±³          ³ExpC1 = Ruta de generación del informe.                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GerReporte(olReport,cDir)

	Local nReg			:= 0 //Quantidade de registros impressos
	Local nPag			:= 0 //Quantidade de paginas por pagina
	Local nCol			:= 0
	Local aColFin       := { STR0002, "", "", "", "", STR0015, "", "", "", ""} // {"NUMERO CORRELATIVO","","","","","N.DE TRANS.BANCARIA","","","",""}
	Local aColFin2      := { STR0010, STR0011, STR0012, STR0032,	STR0014, ; //{"DEL REGISTRO O","  FECHA","MEDIO DE PAGO"," DESCRIPCIÓN ","APELLIDOS Y NOMBRES",
							STR0024, "","","",""} // "DE DOC.SUSTENT. O DE","","","",""}
	Local aColFin3      := {STR0017, STR0018, STR0046, STR0018, STR0023,; // { "CODIGO UNICO DE","DE LA OPERACIÓN","(TABLA 001)","DE LA OPERACIÓN","O RAZON SOCIAL",
						 	STR0045, STR0025, STR0026, STR0027, STR0028} // "CONTROL INTERNO","CODIGO","DENOMINACION"," DEUDOR  ","ACREEDOR"}
	Local aColFin4      := {STR0047, "", " ", "", "",STR0018, "", "", "", ""} //"LA OPERACION" - "DE LA OPERACIÓN"
	
	// Deve obedecer a ordem das colunas do relatorio, caso não tenha campo na Query, identificar a primeira letra com "n - numerico, c - caracter"
	Local aEquivale 	:= { "E5_NODIA", "E5_DATA", "E5_TIPO","E5_HISTOR", "E5_BENEF", "E5_NUMERO","CT2_CREDIT","CT1_DESC01","E5_MOEDA","E5_VALOR"}
	Local nInc			:= 0
	Local nPosEquiv		:= 0
	Local aVert			:= {PIX_INICIAL_VALORES }
	Local nIniDin		:= PIX_INICIAL_VALORES					// Pixel redimencionado dinamicamente
	Local nLimitrofe	:= 4850
	Local cNomCon	    := ""
	Local cContCtb		:= ""  // armazena conta contabil, se E5_RECPAG = "P", CT2_CREDIT, senao CT2_DEBITO
	Local nTotDeb 		:= 0
	Local nTotDeb_A 	:= 0
	Local nTotDeb_B 	:= 0
	Local nTotDeb_T		:= 0        // totalizadores para Banco/Agencia/Conta
	Local nTotCre 		:= 0
	Local nTotCre_A 	:= 0
	Local nTotCre_B 	:= 0
	Local nTotCre_T 	:= 0        // totalizadores para Banco/Agencia/Conta
	Local cTipPer       := ""
	Local cBanMov 		:= ""
	Local cConMov 		:= ""
	Local cAgeMov		:= ""
	Local lNext			:= .T.
	Local cCodEntFin    := ""
	Local cCtaBanCon    := ""
	Local cFechaOpe     := ""
	Local cDesOpeBan    := ""
	Local cNumTraBan    := ""
	Local cBenef        := ""
	Local nValDeu       := 0
	Local cNumCorre     := ""
	Local cCodUniOpe    := ""
	Local lVerCorr		:= .F.
	Local nTasa   		:= 1
	local aCuentas		:= {}
	local cCtaCtb		:= ""
	Local hAlias		:= ''
	Local np			:= 0
	Local nX			:= 0
	Local aCUOsCta		:= {}
	Local nTipoImp		:= olReport:nDevice //1-Archivo,2-Impresora,3-Email,4-Planilla, 5-Html y 6-PDF
	Local nPosSal		:= 0
	Local aLinVert		:= {}
	Local nRespRow		:= 0
	Local lPlanilla		:= (nTipoImp == 4)
	Local nCantLin		:= 0
	Local nIteracion	:= 0
	Local nTamCampo		:= 0
	Local nSaltoLin		:= 0
	Local aTamImp		:= {}
	Local nRegImp		:= 0
	Local nResFinLin	:= 0

	Private nLeftMarg	:= 110 //Variable privada para agregar margen izquierdo de impresion

	For nInc := 1 To Len(aEquivale)
		nIniDin += PIX_DIF_COLUNA_VALORES
		aAdd( aVert, nIniDin )
	Next

	aLinVert := {nLeftMarg,;
				300 + nLeftMarg,;
				600 + nLeftMarg,;
				1200 + nLeftMarg,;
				1500 + nLeftMarg,;
				1800 + nLeftMarg,;
				2100 + nLeftMarg,;
				2400 + nLeftMarg,;
				2700 + nLeftMarg,;
				3000 + nLeftMarg}

	Pergunte(olReport:GetParam(),.F.)
	
	vsql := "SELECT A6_COD, A6_AGENCIA, A6_NUMCON, A6_CONTA, A6_NOME, A6_IDFIN, A6_CGC, A6_MOEDA"
	vsql += "  FROM "+RetSqlName("SA6")
	vsql += " WHERE A6_FILIAL='"+xFilial("SA6")+"'"
	vsql += "   AND A6_COD NOT IN "+Formatin(cBanco,"/")
	If Alltrim(Upper(TCGetDB())) == "ORACLE"
		vsql += "   AND A6_CONTA<>' '   AND D_E_L_E_T_=' '"
	Else	
		vsql += "   AND A6_CONTA<>''   AND D_E_L_E_T_=''"
	EndIf

	If Select("PER") > 1
		PER->( DbCLoseArea() )
	Endif

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, vsql ), "PER",.T.,.T.)

	DbSelectArea( "PER" )
	PER->( DbGoTop() )

	If PER->( !Eof() )
		FCabR122( olReport, nCol, aColFin, aColFin2, aColFin3,aColFin4) //Impressão do cabeçalho
		olReport:SetMeter( RecCount() )
		olReport:OnPageBreak( { || FCabR122( olReport, nCol, aColFin, aColFin2, aColFin3,aColFin4 ) } )
	Endif

	nTotDeb		:= 0
	nTotCre		:= 0
	nValDeu		:= 0
	nValAcre	:= 0
	
	nPosSal		:= olReport:Row()

	While PER->(!Eof())

		If olReport:Cancel()
			Exit
		EndIf

		If PER->A6_CONTA<>cCtaCtb
			cCtaCtb := PER->A6_CONTA
			aSldAnt := SaldoCT7Fil(PER->A6_CONTA,MV_PAR01-1,MV_PAR07,"1","FINR122")
			nSalIni := aSldAnt[1]
			olReport:Box( olReport:Row(), olReport:Col(), olReport:Row(), olReport:Col())
			FR122Prnt( olReport, aLinVert )
			
			If lImpSldIni
				olReport:PrintText(STR0035, nPosSal, 610+nLeftMarg)
				IF lPlanilla //Si es tipo planilla
					FR122ImpPl(olReport, IIf( nSalIni > 0, 8, 7)) //Imprime celdas en blanco
				Endif
				olReport:PrintText(Transform(IIf(nSalIni > 0, nSalIni, nSalIni * -1), "@E 9999,999,999,999.99"), nPosSal, IIf(nSalIni <= 0,2410+nLeftMarg,2710+nLeftMarg))
				olReport:Line(nPosSal+30, nLeftMarg, nPosSal+30, 3000 + nLeftMarg) //Imprime linea de lado a lado
				olReport:SkipLine(1)
				lImpSldIni := .F.
			EndIf
			olReport:Box(nPosSal, nLeftMarg, nPosSal, 3000 + nLeftMarg)
			lNext := .F.
	      	nTotDeb := 0
	      	nTotCre := 0
		EndIf

		cBenef := ""
		cBanMov := PER->A6_COD
		cConMov := PER->A6_NUMCON
		cAgeMov := PER->A6_AGENCIA
		cNomCon  := ""
		cContCtb := ""
		cCodEntFin := PER->A6_IDFIN
		cCtaBanCon := PER->A6_NUMCON
		cFechaOpe  := SPACE(8)
		cDesOpeBan := ""
		cNumTraBan := ""

		cNumCorre := ""
		cCodUniOpe := ""
		lVerCorr := .F.
		lSoloSE5 := .f.
		
		aSize(aCuentas, 0)
		aSize(aCUOsCta, 0)

		If !Empty(PER->A6_CONTA)
			aCUOsCta := getCUOs(PER->A6_CONTA,olReport)
		EndIf

		For np := 1 To Len(aCUOsCta)

			hAlias := getNextAlias()

			cQry := "SELECT CT2_FILIAL,CT2_KEY,CT2_ROTINA,CT2_LP,CT2_LINHA,CT2_NODIA,CT2_SEGOFI,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_HIST,CT2_DATA,CT2_AGLUT,CT2_DC"
			cQry += "  FROM " + RetSqlName("CT2") + " CT2"
			cQry += " WHERE CT2_SEGOFI = '" + aCUOsCta[np][1] + "'"
			cQry += "   AND CT2_FILIAL BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
			cQry += "   AND CT2_DEBITO<>'"+cCtaCtb+"'"
			cQry += "   AND CT2_VALOR>0"
			cQry += "   AND CT2_MOEDLC='"+strzero(val(MV_PAR07),2)+"'"
			cQry += "   AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
			If Alltrim(Upper(TCGetDB())) == "ORACLE"
				cQry += "   AND CT2_DEBITO<>' '"
				cQry += "   AND ( SUBSTR(CT2_DEBITO,1,1)<>'9' AND SUBSTR(CT2_DEBITO,1,2)<>'79' )"
				cQry += "   AND CT2.D_E_L_E_T_=' ' "
			Else
				cQry += "   AND CT2_DEBITO<>''"
				cQry += "   AND ( SUBSTRING(CT2_DEBITO,1,1)<>'9' AND SUBSTRING(CT2_DEBITO,1,2)<>'79' )"
				cQry += "   AND CT2.D_E_L_E_T_='' "
			EndIf
			cQry += " UNION ALL "
			cQry += "SELECT CT2_FILIAL,CT2_KEY,CT2_ROTINA,CT2_LP,CT2_LINHA,CT2_NODIA,CT2_SEGOFI,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_HIST,CT2_DATA,CT2_AGLUT,CT2_DC"
			cQry += "  FROM " + RetSqlName("CT2") + " CT2"
			cQry += " WHERE CT2_SEGOFI = '" + aCUOsCta[np][1] + "'"
			cQry += "   AND CT2_FILIAL BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
			cQry += "   AND CT2_CREDIT<>'"+cCtaCtb+"'"
			cQry += "   AND CT2_VALOR>0"
			cQry += "   AND CT2_MOEDLC='"+strzero(val(MV_PAR07),2)+"'"
			cQry += "   AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
			If Alltrim(Upper(TCGetDB())) == "ORACLE"
				cQry += "   AND CT2_CREDIT<>' '"
				cQry += "   AND ( SUBSTR(CT2_CREDIT,1,1)<>'9' AND SUBSTR(CT2_CREDIT,1,2)<>'79' )"
				cQry += "   AND CT2.D_E_L_E_T_=' ' "
			Else
				cQry += "   AND CT2_CREDIT<>''"
				cQry += "   AND ( SUBSTRING(CT2_CREDIT,1,1)<>'9' AND SUBSTRING(CT2_CREDIT,1,2)<>'79' )"
				cQry += "   AND CT2.D_E_L_E_T_='' "
			EndIf
			cQry += " ORDER BY CT2_FILIAL,CT2_DATA,CT2_SEGOFI"

			dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), hAlias,.T.,.T.)

			If (hAlias)->( !Eof() )

				While (hAlias)->( !Eof() )

					aDtaOrigen := {}
					aDtaOrigen := ObtInfo((hAlias)->CT2_KEY,(hAlias)->CT2_LP,(hAlias)->CT2_DC,(hAlias)->CT2_SEGOFI,((hAlias)->CT2_AGLUT=="1"))
					cCodUniOpe := Alltrim((hAlias)->CT2_LINHA)
					cContCtb := Iif( empty((hAlias)->CT2_CREDIT),(hAlias)->CT2_DEBITO,(hAlias)->CT2_CREDIT )
					cNumCorre := (hAlias)->CT2_SEGOFI
					cGlosa := (hAlias)->CT2_HIST

					If CT1->(MsSeek(xFilial("CT1") + cContCtb))
						cNomCon := AllTrim(CT1->CT1_DESC01)
					Endif

					Aadd( aCuentas, {	cCodUniOpe			,;							// 01
										cContCtb			,;							// 02
										cNomCon				,;							// 03
										(hAlias)->CT2_VALOR	,;							// 04
										cNumCorre			,;							// 05
										if(empty((hAlias)->CT2_CREDIT),"D","C"),;		// 06
										(hAlias)->CT2_CREDIT	,;						// 07
										(hAlias)->CT2_DEBITO	,;						// 08
										aDtaOrigen[1][3]	,;							// 09 - nombre
										aDtaOrigen[1][4]	,;							// 10 - tipo documento
										aDtaOrigen[1][5]	,;							// 11 - ruc
										aDtaOrigen[1][6]	,;							// 12 - dni
										aDtaOrigen[1][7]	,;							// 13 - ORDEN PAGO
										cGlosa				,;							// 14 - glosa
										aCUOsCta[np][2]		,;							// 15 - valor cuenta
										aCUOsCta[np][3]		,;							// 16 - linea
										aCUOsCta[np][4]		,;							// 17 - C o D
										(hAlias)->CT2_DATA	,;							// 18 - FECHA
										aDtaOrigen[1][8]	,;							// 19 - TIPO DOC SE5
										aDtaOrigen[1][9]	,;							// 20 - MOEDA SE5
										aCUOsCta[np][11]	}  )						// 21 - FILIAL

					(hAlias)->(DbSkip())
				EndDo
			EndIf
			(hAlias)->( dbCLoseArea() )
		Next np

		nTasa := 1

		If len(aCuentas) > 0

			For nX := 1 To len(aCuentas)

				nPosEquiv := PIX_EQUIVALENTE
				cCodUniOpe := aCuentas[nX][1]
				nValDeu	  := 0
				nValAcre  := 0
				
				If !lPlanilla //Si no es Planilla (Excel)
					aTamImp := {}
					nSaltoLin := 0

					Aadd(aTamImp, Len(RTrim(aCuentas[nX][3])))	//Tamaño CT1_DESC01
					Aadd(aTamImp, Len(RTrim(aCuentas[nX][14])))	//Tamaño E5_HISTOR
					Aadd(aTamImp, Len(RTrim(aCuentas[nX][9])))	//Tamaño E5_BENEF

					//Se determina el tamaño maximo de los campos guardados en aTamImp
					For nInc := 1 To Len(aTamImp)
						nTamCampo := aTamImp[nInc]
						If nTamCampo % 20 > 0
							nCantLin := NoRound(nTamCampo / 20, 0) + 1
						Else
							nCantLin := nTamCampo / 20
						EndIf
						If nCantLin > nSaltoLin
							nSaltoLin := nCantLin
						EndIf
					Next nInc

					nRegImp += nSaltoLin
					If nRegImp > 60
						olReport:EndPage()
						olReport:Box( olReport:Row(), olReport:Col(), olReport:Row(), olReport:Col())
						nRegImp := 0
					EndIf

					nRespRow := olReport:Row()
					olReport:Line(nRespRow+(30*nSaltoLin), nLeftMarg, nRespRow+(30*nSaltoLin), 3000 + nLeftMarg)
					
					//Imprime lineas verticales y pasa a la próxima línea
					For nIteracion := 1 To nSaltoLin - 1
						FR122Prnt( olReport, aVert, PIX_TAM_VERT * 2)
						olReport:SkipLine(1)
					Next nIteracion
					nResFinLin := olReport:Row()
					olReport:SetRow(nRespRow)
				EndIf

				For nInc := 1 To Len( aEquivale )

					If nInc > 1
						nPosEquiv += PIX_DIF_COLUNA_VALORES
					EndIf

			    	If aEquivale[nInc] == "CT2_CREDIT"
						olReport:PrintText(aCuentas[nX][2], nRespRow, nPosEquiv)
					ElseIf aEquivale[nInc] == "CT1_DESC01"
						If lPlanilla //Si es Tipo planilla
							olReport:PrintText(RTrim(aCuentas[nX][3]), nRespRow, nPosEquiv)
						Else
							//Impresion de Campo de forma dinámica
							FR122Campo(@olReport, aCuentas[nX][3], nPosEquiv)
						EndIf
					Else
						If aEquivale[nInc] == "E5_TIPO" .and. cPaisLoc == "PER"
							If !Empty(aCuentas[nX][19])
								cTipPer := Posicione("FR0",1 ,xFilial("FR0") + "PE1" + aCuentas[nX][19], "FR0_CHVAUX")
							Else
								cTipPer := Posicione("FR0",1 ,xFilial("FR0") + "PE1" + aCuentas[nX][20], "FR0_CHVAUX")
							EndIf
							If Empty(cTipPer)
								cTipPer := PadR("999",TamSX3("FR0_CHVAUX")[1]) //Outros
							EndIf
							olReport:PrintText(PadC(cTipPer,21), nRespRow, nPosEquiv)
						Elseif aEquivale[nInc] == "E5_NODIA" .and. cPaisLoc == "PER"
							cNumCorre := aCuentas[nX][5]
							olReport:PrintText(Substr(cNumCorre,1,21), nRespRow, nPosEquiv)
						Elseif aEquivale[nInc] == "E5_HISTOR" .and. cPaisLoc == "PER"
							If lPlanilla //Si es tipo planilla
								olReport:PrintText(RTrim(aCuentas[nX][14]), nRespRow, nPosEquiv)
							Else
								//Impresion de Campo de forma dinámica
								FR122Campo(@olReport, aCuentas[nX][14], nPosEquiv)
							EndIf
						Elseif aEquivale[nInc] == "E5_BENEF"
							If lPlanilla //Si es Tipo planilla
								olReport:PrintText(RTrim(aCuentas[nX][9]), nRespRow, nPosEquiv)
							Else
								//Impresion de Campo de forma dinámica
								FR122Campo(@olReport, aCuentas[nX][9], nPosEquiv)
							EndIf
						Elseif aEquivale[nInc] == "E5_NUMERO"
							olReport:PrintText(Substr( aCuentas[nX][13],1,21), nRespRow, nPosEquiv)
						Endif
						If aEquivale[nInc] == "E5_VALOR" .and. nInc <= 10
							if aCuentas[nX][6]=="C"
								olReport:PrintText(Transform( aCuentas[nX][4], "@E 999,999,999.99"), nRespRow, nPosEquiv-300)
								nTotDeb	  += aCuentas[nX][4]
							Else
								If lPlanilla
									olReport:PrintText("", nRespRow, nPosEquiv + 50)
									olReport:PrintText(Transform( aCuentas[nX][4], "@E 999,999,999.99"), nRespRow, nPosEquiv + 50)
								Else
									olReport:PrintText(Transform( aCuentas[nX][4], "@E 999,999,999.99"), nRespRow, nPosEquiv + 50)
								EndIf
								nTotCre	  += aCuentas[nX][4]
							Endif
						EndIf
						If aEquivale[nInc] == "E5_DATA"
							olReport:PrintText(DTOC(STOD( aCuentas[nX][18] ) ), nRespRow, nPosEquiv)
						EndIf
					Endif

				Next nInc

				If aCuentas[nX][17]=="C"
					nValDeu	  := aCuentas[nX][15]
				Else
					nValAcre  := aCuentas[nX][15]
				Endif
				
				nIniDin	:= nLeftMarg

				For nInc := 1 To Len(aEquivale)
					nIniDin += PIX_DIF_COLUNA_VALORES
				Next

				nLimitrofe := nIniDin

				If lPlanilla //Si es Tipo planilla
					olReport:SkipLine(1)
				Else
					olReport:SetRow(nResFinLin+28)
				EndIf

			Next nX
		EndIf

		DbSelectArea("PER")
		PER->( DbSkip() )

		nPag++ // Quantidade de registros por pagina
		nReg++ // Quantidade de registros impressos

	    If PER->A6_COD + PER->A6_AGENCIA + PER->A6_NUMCON <> cBanMov + cAgeMov + cConMov
			Do case
			case PER->A6_NUMCON <> cConMov // total conta
				nTotDeb_A = nTotDeb_A + nTotDeb // acumula no total da Agencia
				nTotCre_A = nTotCre_A + nTotCre

				olReport:Box(olReport:Row(),nLeftMarg,olReport:Row(),3000+nLeftMarg)
				FR122Prnt( olReport, aLinVert )
				olReport:PrintText(STR0036 + DtoC(MV_PAR02), olReport:Row(), 610+nLeftMarg)
				If nTotDeb > nTotCre
					nSalIni -= (nTotDeb - nTotCre)
				Else
					nSalIni += (nTotCre - nTotDeb)
				EndIf
				If lPlanilla
					FR122ImpPl(olReport, IIf( nSalIni > 0, 8, 7)) //Imprime celdas en blanco
				EndIf
				olReport:PrintText(Transform(IIf(nSalIni > 0,nSalIni,nSalIni * -1),"@E 9999,999,999,999.99"), olReport:Row(), IIf(nSalIni <= 0,2410,2710))
				nSalIni := 0
				olReport:SkipLine( 1 )
				olReport:Box(olReport:Row(),nLeftMarg,olReport:Row(),3000+nLeftMarg)

				fTotR122(olReport, STR0029, nTotDeb, nTotCre)
				olReport:EndPage()
				lNext := .T.
				nPag := 0
		      	nTotDeb := 0
		      	nTotCre := 0
	        	// imprime total agencia
			case PER->A6_AGENCIA <> cAgeMov .and. PER->A6_NUMCON <> cConMov
				nTotDeb_B = nTotDeb_B + Iif(nTotDeb_A = 0, nTotdeb, nTotDeb_A)
				nTotCre_B = nTotCre_B + Iif(nTotCre_A = 0, nTotCre, nTotCre_A)

				olReport:Box(olReport:Row(),nLeftMarg,olReport:Row(),3000+nLeftMarg)
				FR122Prnt( olReport, aLinVert )
				olReport:PrintText(STR0036 + DtoC(MV_PAR02), olReport:Row(), 610+nLeftMarg)
				If nTotDeb_A > nTotCre_A
					nSalIni -= (nTotDeb_A - nTotCre_A)
				Else
					nSalIni += (nTotCre_A - nTotDeb_A)
				EndIf
				If lPlanilla
					FR122ImpPl(olReport, IIf( nSalIni > 0, 8, 7)) //Imprime celdas en blanco
				EndIf
				olReport:PrintText(Transform(IIf(nSalIni > 0,nSalIni,nSalIni * -1),"@E 9999,999,999,999.99"), olReport:Row(), IIf(nSalIni <= 0,2410+nLeftMarg,2710+nLeftMarg))
				nSalIni := 0
				olReport:SkipLine( 1 )
				olReport:Box(olReport:Row(),nLeftMarg,olReport:Row(),3000+nLeftMarg)

				If nTotDeb_A + nTotCre_A > 0 // caso conta e agencia sejam diferentes
					fTotR122(olReport, STR0030, nTotDeb_A, nTotCre_A)
				Endif
				olReport:EndPage()
				lNext := .T.
				nPag := 0
				nTotDeb_A := 0
	       		nTotCre_A := 0
		      	nTotDeb := 0
		      	nTotCre := 0
				// Imprime total do Banco
			case PER->A6_COD <> cBanMov .and. PER->A6_AGENCIA <> cAgeMov .and. PER->A6_NUMCON <> cConMov
				nTotDeb_T = nTotDeb_T + nTotDeb_B
				nTotCre_T = nTotCre_T + nTotCre_B

				olReport:Box(olReport:Row(),nLeftMarg,olReport:Row(),3000+nLeftMarg)
				FR122Prnt( olReport, aLinVert )
				olReport:PrintText(STR0036 + DtoC(MV_PAR02), olReport:Row(), 610+nLeftMarg)
				If nTotDeb_B > nTotCre_B
					nSalIni -= (nTotDeb_B - nTotCre_B)
				Else
					nSalIni += (nTotCre_B - nTotDeb_B)
				EndIf
				If lPlanilla
					FR122ImpPl(olReport, IIf( nSalIni > 0, 8, 7)) //Imprime celdas en blanco
				EndIf
				olReport:PrintText(Transform(IIf(nSalIni > 0,nSalIni,nSalIni * -1),"@E 9999,999,999,999.99"), olReport:Row(), IIf(nSalIni <= 0,2410+nLeftMarg,2710+nLeftMarg))
				nSalIni := 0
				olReport:SkipLine( 1 )
				olReport:Box(olReport:Row(),nLeftMarg,olReport:Row(),3000+nLeftMarg)

				If nTotDeb_B <> nTotDeb_A
					fTotR122(olReport, STR0019, nTotDeb_B, nTotCre_B)
					olReport:EndPage()
					lNext := .T.
					nPag := 0
					nTotDeb_B := 0
		        	nTotCre_B := 0
				Endif
		      	nTotDeb := 0
		      	nTotCre := 0
			Endcase
		EndIf

		If nPag > 55
			olReport:EndPage()
			nPag := 0
		EndIf

	EndDo

	olReport:IncMeter()

	If nTotDeb + nTotCre <> 0
		FTotR122(olReport, STR0019, nTotDeb, nTotCre)
	Endif

	PER->( DbCLoseArea() )

Return()

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FCabR122  ³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabeçalho do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FCabR122(Expo1,ExpN1,ExpA1)  				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1 = Objeto tReport                                      ³±±
±±³          ³ExpN1 = Posição da coluna de impressão                      ³±±
±±³          ³ExpA1 = Array com as contas do ativo                        ³±±
±±³          ³ExpA2 = Array com as contas do passivo                      ³±±
±±³          ³ExpA3 = Array com as contas de patrimonio                   ³±±
±±³          ³ExpA4 = Array com as contas de gasto                        ³±±
±±³          ³ExpA5 = Array com as contas de receita                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FCabR122( olReport, nCol, aColFin, aColFin2, aColFin3, aColFin4)

	Local nInc			:= 0
	Local nColPixEnc	:= olReport:Col() + 100 //Margen izquierdo del encabezado
	Local aVert			:= {olReport:Col() + nLeftMarg, PIX_INICIAL_VALORES}
	Local nIniDin		:= PIX_INICIAL_VALORES // Pixel redimencionado dinamicamente
	Local nLimitrofe	:= 4850
	Local nTamPad		:= 0
	Local nCharPCol		:= 30 // Quantidade de caracteres por coluna
	Local nIncrCol		:= nLeftMarg
	Local nTipoImp		:= olReport:nDevice //1-Archivo,2-Impresora,3-Email,4-Planilla, 5-Html y 6-PDF
	Local nResRowBox	:= 0
	Local nResColBox	:= 0
	Local nResRowTxt	:= 0
	Local nAuxResp		:= 0
	Local lPlanilla 	:= (nTipoImp == 4)
	
	Pergunte(olReport:GetParam(),.F.)
	
	nCol := olReport:Col() + 1
	lImpSldIni := .T.

	If nTipoImp <> 4 //Si no es Tipo Planilla
		olReport:PrintText("", olReport:Row(), nColPixEnc)
		olReport:PrintText("", olReport:Row()+35, nColPixEnc)
		olReport:PrintText("", olReport:Row()+35, nColPixEnc)
	EndIf
	
	olReport:PrintText( " " + STR0038 + STR0001, olReport:Row(), nColPixEnc) //"FORMATO 1.2:"+"LIBRO CAJA Y BANCOS – DETALLE DE LOS MOVIMIENTOS DE LA CUENTA CORRIENTE"
	olReport:SkipLine()
	olReport:PrintText( STR0004 + dToC( MV_PAR01 ) + " - " + dToC( MV_PAR02 ), olReport:Row()+35, nColPixEnc) //+ STR0033 + MV_PAR05 + STR0034 + MV_PAR06,olReport:Row()   ,nColPix) //Periodo
	If lPlanilla
		olReport:SkipLine(1)
	EndIf
	olReport:PrintText( STR0005 + AllTrim( SM0->M0_CGC), olReport:Row()+35, nColPixEnc) //RUC
	If lPlanilla
		olReport:SkipLine(1)
	EndIf
	olReport:PrintText( STR0006 + " " + AllTrim(SM0->M0_NOMECOM), olReport:Row()+35, nColPixEnc) //APELLIDOS Y NOMBRES, DENOMINACIÓN O RAZÓN SOCIAL:"
	If lPlanilla
		olReport:SkipLine(1)
	EndIf
	olReport:PrintText( STR0007 + FR122DesId(PER->A6_IDFIN) + " - " + AllTrim(PER->A6_NOME), olReport:Row()+35, nColPixEnc ) //ENTIDAD FINANCIERA: "
	If lPlanilla
		olReport:SkipLine(1)
	EndIf
	olReport:PrintText( STR0008 + " " + Alltrim(PER->A6_NUMCON), olReport:Row()+35, nColPixEnc ) //CÓDIGO DE LA CUENTA CORRIENTE: "

	olReport:SkipLine( 2 )

	olReport:SetRow(olReport:Row()+35)

	// Primeira linha
	nTamPad	:= Len( aColFin ) * nCharPCol
	olReport:SetCol(nIncrCol)
	nResRowBox := olReport:Row()-004

	olReport:Box(nResRowBox, olReport:Col(), nResRowBox+034, nResColBox := (600 + nIncrCol) ) //Imprime celda en blanco superior izquierda
	nAuxResp := nResColBox
	olReport:Box(nResRowBox, nAuxResp, nResRowBox+034, nResColBox := (1800 + nIncrCol) )  								// box
	nResRowTxt := olReport:Row()-003
	nAuxResp := nResColBox
	If lPlanilla
		FR122ImpPl(olReport, 3) //Imprime celdas en blanco
	EndIf
	olReport:PrintText(STR0003 + " " + STR0009, nResRowTxt,	(1050 + nIncrCol)) //  Operaciones Bancarias
	olReport:Box(nResRowBox, nAuxResp, nResRowBox+034, nResColBox := (2400 + nIncrCol) ) // box
	If lPlanilla
		FR122ImpPl(olReport, 2) //Imprime celdas en blanco
	EndIf
	olReport:PrintText(STR0013, nResRowTxt, (1900 + nIncrCol)) // CUENTA CONTABLE ASOCIADA
	nAuxResp := nResColBox
	olReport:Box(nResRowBox, nAuxResp, nResRowBox+034, 3000 + nIncrCol ) // box
	If lPlanilla
		FR122ImpPl(olReport, 1) //Imprime celdas en blanco
	EndIf
	olReport:PrintText(STR0016, nResRowTxt, (2450 + nIncrCol)) // SALDOS Y MOVIMIENTOS

	nIniDin += ( PIX_DIF_COLUNA_VALORES * Len( aColFin ) )

	aAdd( aVert, nIniDin )

	nLimitrofe := nIniDin
	FR122Prnt( olReport, aVert ) // Imprime a linhas verticais e passa para proxima linha
	olReport:SkipLine( 1 )
	
	// Segunda linha - Imprime as contas
	nIniDin	:= PIX_INICIAL_VALORES
	For nInc := 1 To Len( aColFin )
		olReport:PrintText(PadC( Alltrim(aColFin[nInc]), 25 ), olReport:Row(), nIniDin)
		nIniDin += PIX_DIF_COLUNA_VALORES
		aAdd( aVert, nIniDin )
	Next

	FR122Prnt( olReport, aVert ) // Imprime a linhas verticais e passa para proxima linha
	olReport:SkipLine( 1 )

	// Terceira linha - Imprime as contas
	nIniDin	:= PIX_INICIAL_VALORES

	For nInc := 1 To Len( aColFin2 )
		olReport:PrintText(PadC( Alltrim(aColFin2[nInc]), 25 ), olReport:Row(), nIniDin)
		nIniDin += PIX_DIF_COLUNA_VALORES
		aAdd( aVert, nIniDin )
	Next

	FR122Prnt( olReport, aVert ) // Imprime a linhas verticais e passa para proxima linha
	olReport:SkipLine( 1 )

	nIniDin	:= PIX_INICIAL_VALORES

	For nInc := 1 To Len( aColFin3 )
		olReport:PrintText(PadC( Alltrim(aColFin3[nInc]), 25 ), olReport:Row(), nIniDin)
		nIniDin += PIX_DIF_COLUNA_VALORES
		aAdd( aVert, nIniDin )
	Next

	FR122Prnt( olReport, aVert ) // Imprime a linhas verticais e passa para proxima linha
	olReport:SkipLine( 1 )

	nIniDin	:= PIX_INICIAL_VALORES

	For nInc := 1 To Len( aColFin4 )
		olReport:PrintText(PadC( Alltrim(aColFin4[nInc]), 25 ), olReport:Row(), nIniDin)
		nIniDin += PIX_DIF_COLUNA_VALORES
		aAdd( aVert, nIniDin )
	Next

	olReport:Line(olReport:Row()+nCharPCol, nIncrCol, olReport:Row()+nCharPCol, 3000 + nIncrCol) //Imprime linea de lado a lado
	FR122Prnt( olReport, aVert ) // Imprime a linhas verticais e passa para proxima linha
	olReport:SkipLine( 1 )

	olReport:Row() := 330
Return()


/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR122Prnt ³ Autor ³ Totvs                 ³ Data | 07/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime as linhas verticais e horizontais do relatorio      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FR122Prnt( ExpA1 )         				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1 = Array com as colunas                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR122Prnt( olReport, aCol, nLinPix )
	Local nInc	:= 1
	
	Default nLinPix := PIX_TAM_VERT

	For nInc := 1 To Len( aCol )
		olReport:Box( olReport:Row(), aCol[nInc], olReport:Row()+nLinPix, aCol[nInc]) // traco vertical
	Next
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fTotR122  ºAutor  ³Microsiga           º Data ³  05/25/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do total                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FTotR122(olReport, cDescPrt, nTotDeb_P, nTotCre_P)
	Local nIncrCol	:= nLeftMarg
	Local nTipoImp	:= olReport:nDevice //1-Archivo,2-Impresora,3-Email,4-Planilla, 5-Html y 6-PDF

	olReport:Line( olReport:Row(), PIX_EQUIVALENTE , olReport:Row(), 2100 + nIncrCol)
	olReport:Box( olReport:Row(), 2100 + nIncrCol, olReport:Row() + 034, 2400 + nIncrCol)
	olReport:PrintText(cDescPrt, olReport:Row(), 2110 + nIncrCol)
	olReport:Box( olReport:Row(), 2400 + nIncrCol, olReport:Row() + 034, 2700 + nIncrCol)
	If nTipoImp == 4 //Si es impresión en planilla
		FR122ImpPl(olReport, 7) //Imprime celdas en blanco
	EndIf
	olReport:PrintText(Transform( nTotDeb_P, "@E 99,999,999,999.99"), olReport:Row(), 2435 + nIncrCol)
	olReport:Box( olReport:Row(), 2700 + nIncrCol, olReport:Row() + 034, 3000 + nIncrCol)
	olReport:PrintText(Transform( nTotCre_P, "@E 99,999,999,999.99"), olReport:Row(), 2734 + nIncrCol)

	If nTipoImp == 4 //Si es impresión en planilla
		olReport:SkipLine(3) //Se agregan saltos de línea para imprimir encabezado siguiente
	EndIf
Return()

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ObtInfo   ³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtiene información de Asientos Contables.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ObtInfo(ExpC1,ExpC2)  				                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 = Contiene la llave del asientos contable.            ³±±
±±³          ³ExpC2 = Contiene el código del asiento estándar.            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ObtInfo(ct2Key,ct2Lp,ct2Dc,ct2SegOfi,lAgluAsi)

Local cQry 	  := ""
Local aCampos := {}
Local cKeyArr := ""
Local nX      := 0
Local aKey    := {}
Local cNome   :=""
Local cTipDoc :=""
Local cCGC    :=""
Local cPfisica:=""
Local cCampo  :=""
Local lIndCam := .F.

Default ct2Key		:= ""
Default ct2Lp		:= ""
Default ct2Dc		:= ""
Default ct2SegOfi	:= ""
Default lAgluAsi	:=.F.

dbSelectArea("SA2")
SA2->(DBSETORDER(1))
dbSelectArea("SA1")
SA1->(DBSETORDER(1))
dbSelectArea("CTL")
ctl->(dbSetOrder(1)) //CTL_FILIAL + CTL_LP

If CTL->(MsSeek(xFilial("CTL") + ct2Lp))
	cKeyArr := CTL->CTL_KEY
EndIf

If !Empty(cKeyArr)
	aCampos := StrTokArr( cKeyArr, "+" )
EndIf

If ct2Lp $ "575/576"

	nPos := 1

	cQry := "SELECT EL_FILIAL,EL_CLIENTE,EL_LOJA,EL_RECIBO,EL_MOEDA,EL_TIPO "
	cQry += " FROM " + RetSqlName("SEL") 

	If ct2Dc != "3" .And. AT("TB", ct2Key) > 0
		ct2Key := FR122Ckey(ct2key,ct2SegOfi)	
	EndIf

	If lAgluAsi 
		aCampos	:= {"EL_FILIAL","EL_RECIBO"}
		cQry += " WHERE EL_TIPO IN ('TF','EF','CH','CC','CD')"
		lIndCam := .T.
	ElseIf Len(aCampos) > 0
		cQry += " WHERE "
	EndIf

	For nX := 1 To Len(aCampos)
		cCampo := substr(ct2Key,nPos,TamSx3(aCampos[nX])[1] )
		If "'" $ cCampo
			cCampo := Strtran(cCampo, "'", "''")
		EndIf
		If !(!lIndCam .AND. nX == 1)
			cQry += " AND "
		EndIF
		cQry += alltrim(aCampos[nX]) + "='" + cCampo + "'"
		nPos += TamSx3(aCampos[nX])[1]
	Next nX

	If Select("TRBSEK") > 1
		TRBSEK->( DbCLoseArea() )
	EndIf

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), "TRBSEK",.T.,.T.)

	DbSelectArea( "TRBSEK" )
	TRBSEK->( DbGoTop() )

	if TRBSEK->( !Eof() )
		cNome:=""
		cTipDoc:=""
		cCGC:=""
		cPfisica:=""

		SA1->(DBSETORDER(1))
		if SA1->(MsSeek(xFilial("SA1")+TRBSEK->EL_CLIENTE+TRBSEK->EL_LOJA))
			cNome:=SA1->A1_NOME
			cTipDoc:=SA1->A1_TIPDOC
			cCGC:=SA1->A1_CGC
			cPfisica:=SA1->A1_PFISICA
		endif

		Aadd( aKey, { TRBSEK->EL_CLIENTE	,;
						TRBSEK->EL_LOJA		,;
						cNome	,;
						cTipDoc	,;
						cCGC		,;
						cPfisica	,;
						TRBSEK->EL_RECIBO		,;
						TRBSEK->EL_TIPO		,;
						TRBSEK->EL_MOEDA			} )
	else
		Aadd( aKey, { "","","","","","","","",""})

	Endif

ElseIf ct2Lp $ "570/571"

	nPos := 1
	
	cQry := "SELECT EK_FILIAL,EK_FORNECE,EK_LOJA,EK_ORDPAGO,EK_MOEDA,EK_TIPO "
	cQry += " FROM " + RetSqlName("SEK") 

	If ct2Dc != "3" .And. AT("TB", ct2Key) > 0
		ct2Key := FR122Ckey(ct2key,ct2SegOfi)	
	EndIf

	If lAgluAsi .Or. (!lAgluAsi .And. MV_PAR05 == 1)
		aCampos	:= {"EK_FILIAL","EK_ORDPAGO"}
		cQry += " WHERE EK_TIPODOC='CP'"
		lIndCam := .T.
	ElseIf Len(aCampos)
		cQry += " WHERE "
	EndIf

	For nX := 1 To Len(aCampos)
		If !(!lIndCam .and. nX == 1)
			cQry += " AND "
		EndIf
		cQry += alltrim(aCampos[nX]) + "='" + substr(ct2Key,nPos,TamSx3(aCampos[nX])[1] ) + "'"
		nPos += TamSx3(aCampos[nX])[1]
	Next nX

	If Select("TRBSEK") > 1
		TRBSEK->( DbCLoseArea() )
	EndIf

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), "TRBSEK",.T.,.T.)

	DbSelectArea( "TRBSEK" )
	TRBSEK->( DbGoTop() )

	if TRBSEK->( !Eof() )
		cNome:=""
		cTipDoc:=""
		cCGC:=""
		cPfisica:=""

		SA2->(DBSETORDER(1))
		if SA2->(MsSeek(xFilial("SA2")+TRBSEK->EK_FORNECE+TRBSEK->EK_LOJA))
			cNome:=SA2->A2_NOME
			cTipDoc:=SA2->A2_TIPDOC
			cCGC:=SA2->A2_CGC
			cPfisica:=SA2->A2_PFISICA
		endif
		Aadd( aKey, { TRBSEK->EK_FORNECE	,;
						TRBSEK->EK_LOJA		,;
						cNome	,;
						cTipDoc	,;
						cCGC		,;
						cPfisica	,;
						TRBSEK->EK_ORDPAGO	,;
						TRBSEK->EK_TIPO		,;
						TRBSEK->EK_MOEDA		})

	else
		Aadd( aKey, { "","","","","","","","",""})
	Endif

	ElseIf ct2Lp $ "560/561|562/563|564/565"	// TB salida-pagar / entrada-cobrar

		nPos := 1

		cQry := "SELECT E5_FILIAL,E5_DTDIGIT,E5_BANCO,E5_AGENCIA,E5_CONTA,E5_NUMCHEQ,E5_DOCUMEN,E5_RECPAG,E5_HISTOR,E5_TIPO,E5_MOEDA"
	    cQry += " FROM " + RetSqlName("SE5") + " WHERE "
		If Alltrim(Upper(TCGetDB())) == "ORACLE"
		 	cQry +=  "D_E_L_E_T_=' '"
		Else
			cQry +=  "D_E_L_E_T_=''"
		Endif	

	    if ct2Lp$"561/563/565"		// receber
	    	cQry += " AND E5_RECPAG='R'"
	    else
	    	cQry += " AND E5_RECPAG='P'"
	    endif
		For nX := 1 To Len(aCampos)
			if "DTOS"$aCampos[nX]
				aCampos[nX] := strTran(aCampos[nX],"DTOS(","")
				aCampos[nX] := strTran(aCampos[nX],")","")
			endif
			cQry += " AND " + alltrim(aCampos[nX]) + "='" + substr(ct2Key,nPos,TamSx3(aCampos[nX])[1] ) + "'"
			nPos += TamSx3(aCampos[nX])[1]
		Next nX

	    If Select("TRBSEK") > 1
			TRBSEK->( DbCLoseArea() )
		EndIf

		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), "TRBSEK",.T.,.T.)

		DbSelectArea( "TRBSEK" )
		TRBSEK->( DbGoTop() )

		if TRBSEK->( !Eof() )

			Aadd( aKey, { PER->A6_NOME			,;
						  ""					,;
						  PER->A6_NOME			,;
						  "6"					,;
						  PER->A6_CGC			,;
						  ""					,;
						  iif(empty(TRBSEK->E5_DOCUMEN),TRBSEK->E5_NUMCHEQ,TRBSEK->E5_DOCUMEN)	,;
						  TRBSEK->E5_TIPO		,;
						  TRBSEK->E5_MOEDA		})


		else
			Aadd( aKey, { "" ,"","","","","","","",""})
		Endif
	else
		Aadd( aKey, { "" ,"","","","","","","",""})
EndIf

If Select("TRBSEK") > 1
	TRBSEK->( DbCLoseArea() )
Endif

Return( aKey )

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    fSekOrdRec ³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtiene información de SEK para Recibos y OP.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   fSekOrdRec(ExpC1,ExpC2, ExpC3)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 = Contiene la filial del documento.                   ³±±
±±³          ³ExpC2 = Contiene el numero del documento.                   ³±±
±±³          ³ExpC3 = Contiene identificador de Recibo u OP.              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fSekOrdRec( cIdFil, cIdDoc, cRecPag )

	local dArea		:= getArea()
	local cQry		:= ""
	local _cAlias	:= getNextAlias()
	local nX		:= 0

	if cRecPag=="R"

		cQry := "SELECT EL_RECIBO,EL_CLIENTE, COUNT(*) NCONT FROM "+RetSqlName("SEL")
		cQry += " WHERE EL_FILIAL='"+cIdFil+"'"
		cQry += "   AND EL_RECIBO='"+cIdDoc+"'"
		cQry += "   AND EL_TIPO='NF'"
		If Alltrim(Upper(TCGetDB())) == "ORACLE"
			cQry += "   AND D_E_L_E_T_=' '"
		Else
			cQry += "   AND D_E_L_E_T_=''"
		EndIf
		cQry += " GROUP BY EL_RECIBO,EL_CLIENTE"

		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), _cAlias,.T.,.T.)

		if (_cAlias)->(!eof())
			while (_cAlias)->(!eof())
				nX++
				(_cAlias)->( dbSkip() )
			end
		endif

		(_cAlias)->( dbCloseArea() )

	else

		cQry := "SELECT EK_ORDPAGO,EK_FORNECE,COUNT(*) NCONT FROM "+RetSqlName("SEK")
		cQry += " WHERE EK_FILIAL='"+cIdFil+"'"
		cQry += "   AND EK_ORDPAGO='"+cIdDoc+"'"
		cQry += "   AND EK_TIPO='NF'"
		If Alltrim(Upper(TCGetDB())) == "ORACLE"
			cQry += "   AND D_E_L_E_T_=' '"
		Else
			cQry += "   AND D_E_L_E_T_=''"
		Endif
		cQry += " GROUP BY EK_ORDPAGO,EK_FORNECE"

		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), _cAlias,.T.,.T.)

		if (_cAlias)->(!eof())
			while (_cAlias)->(!eof())
				nX++
				(_cAlias)->( dbSkip() )
			end
		endif

		(_cAlias)->( dbCloseArea() )

	endif

	restArea(dArea)

Return( if(nX>1,"VARIOS","") )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GerArq    ºAutor  ³ Luis Enríquez      º Data ³  17/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Función para generar archivo plano de Libro Caja y Bancos. º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±³Sintaxe   ³GerArq(cDir)			  				                      ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±³Parametros³cDir = Dirección donde será creado archivo.                 ³±±
±±³          ³olReport = Objeto TReport.                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±ºUso       ³ FINR122                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GerArq(cDir,olReport)

Local nHdl			:= 0
Local nPos			:= 0
Local cLinea		:= ""
Local cCRLF			:= (chr(13)+chr(10))
Local vsql			:= ""
Local aCuentas		:= {}
Local cPeriodo      := ""
Local cEdoOpe       := "1"
Local cCodEntFin    := ""
Local cCtaBanCon    := ""
Local cFechaOpe     := ""
Local cDesOpeBan    := ""
Local cNumTraBan    := ""
Local cTipoDoc      := ""
Local cBenef        := ""
Local nValDeu       := 0
Local cNumDoc       := ""
Local cNumCorre     := ""
Local cCodUniOpe    := ""
Local lMoeda		:= .f.
Local np			:= 0
Local nX			:= 0
Local nCont			:= 0
Local aCUOsCta		:= {}

Pergunte(olReport:GetParam(),.F.)
cPeriodo      := AllTrim(StrZero(Year(MV_PAR01),4)) + AllTrim(StrZero(Month(MV_PAR01),2)) + "00"
lMoeda := IIf(alltrim(MV_PAR07)$'01|1',.T.,.F.)

	vsql := "SELECT A6_COD,A6_AGENCIA,A6_NUMCON,A6_CONTA,A6_NOME,A6_IDFIN,A6_CGC"
	vsql += "  FROM "+RetSqlName("SA6")
	vsql += " WHERE A6_FILIAL='"+xFilial("SA6")+"'"
	vsql += "   AND A6_COD NOT IN "+Formatin(cBanco,"/")
	If Alltrim(Upper(TCGetDB())) == "ORACLE"
		vsql += "   AND A6_CONTA<>' '"
	Else	
		vsql += "   AND A6_CONTA<>''"
	EndIf

	If Select("PER") > 1
		PER->( DbCLoseArea() )
	Endif

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, vsql ), "PER",.T.,.T.)

	DbSelectArea( "PER" )
	PER->( DbGoTop() )

	nTotDeb	  := 0
	nTotCre	  := 0
	nValDeu  := 0
	nValAcre := 0

	While PER->(!Eof())

		aSize(aCuentas, 0)
		cBenef := ""
		cBanMov := PER->A6_COD
		cConMov := PER->A6_NUMCON
		cAgeMov := PER->A6_AGENCIA
		cNomCon  := ""
		cContCtb := ""
		cCodEntFin := PER->A6_IDFIN
		cCtaBanCon := PER->A6_NUMCON
		cFechaOpe  := SPACE(8)
		cDesOpeBan := ""
		cNumTraBan := ""

		cNumCorre := ""
		cCodUniOpe := ""
		lVerCorr := .F.
		lSoloSE5 := .f.
		aSize(aCUOsCta, 0)

		If !Empty(PER->A6_CONTA)
			aCUOsCta := getCUOs(PER->A6_CONTA,olReport)
		EndIf

		if len(aCUOsCta) > 0

			for np := 1 to len(aCUOsCta)

				aDtaOrigen := {}
				aDtaOrigen := ObtInfo(aCUOsCta[np][5],aCUOsCta[np][6],aCUOsCta[np][12],aCUOsCta[np][1],aCUOsCta[np][13])
				cCodUniOpe := Alltrim(aCUOsCta[np][3])
				cContCtb := Iif( empty(aCUOsCta[np][7]),aCUOsCta[np][8],aCUOsCta[np][7] )
				cNumCorre := aCUOsCta[np][1]
				cGlosa := aCUOsCta[np][9]

				If CT1->(MsSeek(xFilial("CT1") + cContCtb))
					cNomCon := Substr(CT1->CT1_DESC01,1,21)
				Endif

				If !Empty(aDtaOrigen[1][8])
					aDtaOrigen[1][8] := Posicione("FR0",1 ,xFilial("FR0") + "PE1" + aDtaOrigen[1][8], "FR0_CHVAUX")
				Else
					aDtaOrigen[1][8] := PadR("999",TamSX3("FR0_CHVAUX")[1]) //Outros
				EndIf

				Aadd( aCuentas, {	cCodUniOpe			,;							// 01
									cContCtb			,;							// 02
									cNomCon				,;							// 03
									aCUOsCta[np][2]		,;							// 04
									cNumCorre			,;							// 05
									if(empty(aCUOsCta[np][7]),"D","C"),;			// 06
									aCUOsCta[np][7]		,;							// 07
									aCUOsCta[np][8]		,;							// 08
									aDtaOrigen[1][3]	,;							// 09 - nombre
									aDtaOrigen[1][4]	,;							// 10 - tipo documento
									aDtaOrigen[1][5]	,;							// 11 - ruc
									aDtaOrigen[1][6]	,;							// 12 - dni
									aDtaOrigen[1][7]	,;							// 13 - ORDEN PAGO
									cGlosa				,;							// 14 - glosa
									aCUOsCta[np][2]		,;							// 15 - valor cuenta
									aCUOsCta[np][3]		,;							// 16 - linea
									aCUOsCta[np][4]		,;							// 17 - C o D
									aCUOsCta[np][10]	,;							// 18 - FECHA
									aDtaOrigen[1][8]	,;							// 19 - TIPO DOC SE5
									aDtaOrigen[1][9]	,;							// 20 - MOEDA SE5
									aCUOsCta[np][11]	}  )						// 21 - FILIAL

			Next np

		endif

		if len(aCuentas)>0

			for nX := 1 to len(aCuentas)

				if aScan(aRenglon,{|x| x[3] == aCuentas[nX][5] .And. x[16] == aCuentas[nX][1] }) == 0

					c2Benef := alltrim(fSekOrdRec(aCuentas[nX][21],aCuentas[nX][7],if(aCuentas[nX][6]=="C","P","R")))
					cTipoDoc := aCuentas[nX][10]
					cNumDoc := aCuentas[nX][11]
					cBenef := aCuentas[nX][9]

					If aCuentas[nX][6]=="D"
						nValDeu	  := aCuentas[nX][15]
						nValAcre  := 0
					Else
						nValDeu	  := 0
						nValAcre  := aCuentas[nX][15]
					Endif

					if empty(aCuentas[nX][11])
						aCuentas[nX][11] := aCuentas[nX][12]		// IDENTIFICA SI EL RUC ES VACIO, ENTONCES AGARRA EL DNI PARA CASO NO DOMICILIADOS
					endif

					aAdd(aRenglon,{	cPeriodo,;											// 01
									"M"+aCuentas[nX][1],;								// 02
									aCuentas[nX][5],;									// 03
									cCodEntFin,;										// 04
									cCtaBanCon,;										// 05
									aCuentas[nX][18],;									// 06
									Alltrim(aCuentas[nX][19]),;							// 07
									Alltrim(aCuentas[nX][14]),;							// 08
									iif(empty(c2Benef),Alltrim(aCuentas[nX][10]),"-"),;			// 09
									iif(empty(c2Benef),Alltrim(aCuentas[nX][11]),"-"),;			// 10	 - RUC
									iif(empty(c2Benef),Alltrim(cBenef),c2Benef),;		// 11
									alltrim(aCuentas[nX][13]),;							// 12
									Alltrim(Str(nValDeu,12,2)),;						// 13
						   			Alltrim(Str(nValAcre,12,2)),;						// 14
						   			cEdoOpe,;											// 15
						   			aCuentas[nX][1]})									// 16

				endif
			next nX
		endif

		DbSelectArea("PER")
		PER->( DbSkip() )

	End

	PER->( DbCLoseArea() )

	FOR nCont:=LEN(ALLTRIM(cDir)) TO 1 STEP -1
		IF SUBSTR(cDir,nCont,1)=='\'
			cDir:=Substr(cDir,1,nCont)
			EXIT
		ENDIF
	NEXT

	//---------------------------------//
	//nombre del archivo               //
	//LERRRRRRRRRRRAAAAMM0001020000OIM1//
	//123456789012345678901234567890123//
	//---------------------------------//
	cArchivo := ""
	cArchivo += "LE"                                  // Fijo  'LE'
	cArchivo +=  AllTrim(SM0->M0_CGC)                 // RUC
	cArchivo +=  AllTrim(StrZero(Year(MV_PAR01),4))   // Ano
	cArchivo +=  AllTrim(StrZero(Month(MV_PAR01),2))  // Mes
	cArchivo += "00"                                  // Fixo '00'
	cArchivo += "010200"                              // Fixo '010200'
	cArchivo += "00"                                  // Fixo '00'
	cArchivo += "1"                                   // Fixo 'O' - 0-cierre de operaciones 1-empresa operativa 2-cierre de libro
	If len(aRenglon) > 0
		cArchivo += "1"
	Else
		cArchivo += "0"
	EndIf
	cArchivo += Alltrim(Str(val(MV_PAR07)))+"1"		  // 1 -soles 2-doalres
	cArchivo += ".TXT"                                // Extensao

	nHdl := fCreate(cDir + cArchivo,nil,nil,.f.)

	If nHdl <= 0
		ApMsgStop(STR0041) // "Ocurrió un error generar archivo TXT de Libro Caja y Bancos."
		Return
	endif

	For nPos := 1 To Len(aRenglon)
		cLinea :=	aRenglon[nPos][1] + "|" +;									// 01 - periodo
					aRenglon[nPos][3] + "|" +;									// 02 - correlativo CUO
					aRenglon[nPos][2] + "|" +;									// 03 - nro linea CT2_LINHA
					aRenglon[nPos][4] + "|" +;									// 04 - entidad financiera A6_IDFIN
					alltrim(aRenglon[nPos][5]) + "|" +;							// 05 - cuenta banco
					dtoc(stod(aRenglon[nPos][6])) + "|" +;						// 06 - fecha de la operacion
					aRenglon[nPos][7] + "|" +;									// 07 - modo de pago
					aRenglon[nPos][8] + "|" +;									// 08 - descripcion de la operacion bancaria - glosa CT2_HIST
					if(alltrim(aRenglon[nPos][9])=="-",aRenglon[nPos][9],alltrim(str(val(aRenglon[nPos][9])))) + "|" +;			// 09 - tipo de documento
					if(empty(aRenglon[nPos][10]),"00000000000",aRenglon[nPos][10]) + "|" +;										// 10 - RUC de la entidad
					if(empty(aRenglon[nPos][11]),"-",aRenglon[nPos][11]) + "|" +;												// 11 - Nombre o razon social
					if(empty(aRenglon[nPos][12]),"000000",aRenglon[nPos][12]) + "|" +;											// 12 - numero del documento
					aRenglon[nPos][13] + "|" +;									// 13 - valor debito
					aRenglon[nPos][14]  + "|" +;								// 14 - valor credito
					aRenglon[nPos][15] + "|" + cCRLF							// 15
		fWrite(nHdl,cLinea)
	Next nPos
	MsgInfo(STR0042 + cArchivo + STR0043 + Alltrim(cDir), "") //"Archivo plano " //" de Libro Caja y Bancos generado con exito, en ruta "
	fClose(nHdl)

Return Nil

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    fSekOrdRec ³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtiene información de SEK para Recibos y OP.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   fSekOrdRec(ExpX1,ExpO1)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpX1 = Contiene el código de la Cuenta Contable.           ³±±
±±³          ³ExpO2 = Objeto TReport.                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function getCUOs(xCtaCtb,olReport)

	local _vArea  := getArea()
	local _vAlias := getNextAlias()
	local _aCuosg := {}

	Pergunte(olReport:GetParam(),.F.)

	cQry := "SELECT CT2_FILIAL,CT2_KEY,CT2_ROTINA,CT2_LP,CT2_LINHA,CT2_NODIA,CT2_SEGOFI,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_NODIA,CT2_DATA,CT2_HIST,CT2_DC,CT2_AGLUT"
	cQry += "  FROM " + RetSqlName("CT2")
	cQry += " WHERE CT2_FILIAL BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
	cQry += "   AND CT2_DEBITO='"+xCtaCtb+"'"
	cQry += "   AND CT2_VALOR>0"
	cQry += "   AND CT2_MOEDLC='"+strzero(val(MV_PAR07),2)+"'"
	If Alltrim(Upper(TCGetDB())) == "ORACLE"
		cQry += "   AND CT2_DEBITO<>' '"
		cQry += "   AND ( SUBSTR(CT2_DEBITO,1,1)<>'9' AND SUBSTR(CT2_DEBITO,1,2)<>'79')"
		cQry += "   AND D_E_L_E_T_=' ' "
	Else
		cQry += "   AND CT2_DEBITO<>''"
		cQry += "   AND ( SUBSTRING(CT2_DEBITO,1,1)<>'9' AND SUBSTRING(CT2_DEBITO,1,2)<>'79')"
		cQry += "   AND D_E_L_E_T_='' "
	EndIf
	cQry += "   AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
	cQry += " UNION ALL "
	cQry += "SELECT CT2_FILIAL,CT2_KEY,CT2_ROTINA,CT2_LP,CT2_LINHA,CT2_NODIA,CT2_SEGOFI,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_NODIA,CT2_DATA,CT2_HIST,CT2_DC,CT2_AGLUT"
	cQry += "  FROM " + RetSqlName("CT2")
	cQry += " WHERE CT2_FILIAL BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
	cQry += "   AND CT2_CREDIT='"+xCtaCtb+"'"
	cQry += "   AND CT2_VALOR>0"
	cQry += "   AND CT2_MOEDLC='"+strzero(val(MV_PAR07),2)+"'"
	cQry += "   AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
	If Alltrim(Upper(TCGetDB())) == "ORACLE"
		cQry += "   AND CT2_CREDIT<>' '"
		cQry += "   AND ( SUBSTR(CT2_CREDIT,1,1)<>'9' AND SUBSTR(CT2_CREDIT,1,2)<>'79')"
		cQry += "   AND D_E_L_E_T_=' ' "
	Else
		cQry += "   AND CT2_CREDIT<>''"
		cQry += "   AND ( SUBSTRING(CT2_CREDIT,1,1)<>'9' AND SUBSTRING(CT2_CREDIT,1,2)<>'79')"
		cQry += "   AND D_E_L_E_T_='' "
	EndIf
	cQry += " ORDER BY CT2_DATA"

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), _vAlias,.T.,.T.)

	IF (_vAlias)->( !Eof() )

		while (_vAlias)->( !Eof() )

			if aScan(_aCuosg,{|x| x[1] == (_vAlias)->CT2_SEGOFI }) == 0
				Aadd( _aCuosg, {	(_vAlias)->CT2_SEGOFI						,;			// 01
									(_vAlias)->CT2_VALOR						,;			// 02
									(_vAlias)->CT2_LINHA						,;			// 03
									if(!empty((_vAlias)->CT2_CREDIT),"C","D")	,;			// 04
									(_vAlias)->CT2_KEY							,;			// 05
									(_vAlias)->CT2_LP							,;			// 06
									(_vAlias)->CT2_CREDIT						,;			// 07
									(_vAlias)->CT2_DEBITO						,;			// 08
									(_vAlias)->CT2_HIST							,;			// 09
									(_vAlias)->CT2_DATA							,;			// 10
									(_vAlias)->CT2_FILIAL						,;			// 11
									(_vAlias)->CT2_DC							,;			// 12
									(_vAlias)->CT2_AGLUT == "1"					})			// 13

			endif
			(_vAlias)->( dbSkip() )
		end

	endif

	(_vAlias)->( dbCloseArea() )

	restArea(_vArea)

Return(_aCuosg)

/*/{Protheus.doc} FR122ImpPl
Función utilizada para impresión de líneas vacias en el formato
planilla.
@type Static Function
@author Marco Augusto Gonzalez Rivera
@since 10/09/2021
@version 1.0
@example FR122ImpPl(olReport, nNumLinImp)
@param olReport, Objeto Objeto TReport.
@param nPosRat, Numerico, Posicion de campo en encabezado.
/*/
Static Function FR122ImpPl(olReport, nNumLinImp)
	Local nIteracion := 0

	For nIteracion := 1 To nNumLinImp
		olReport:PrintText("", olReport:Row(), olReport:Col())
	Next nIteracion

Return

/*/{Protheus.doc} FR122DesId
	Función utilizada para retornar la descripción del Id Financiero
	configurado en el campo A6_IDFIN en base a la tabla XW - Entidad
	Financiera SUNAT.

	@type  Static Function
	@author marco.rivera
	@since 13/10/2021
	@version 1.0
	@param cIdFin, Caracter, Codigo de Id Financiero (A6_IDFIN)
	@return cDescIdFin, Caracter, Retorna la descripción del registro en SX5.
	@example
	FR122DesId(cIdFin)
	/*/
Static Function FR122DesId(cIdFin)
	Local aArea := GetArea()
	Local cDescIdFin := ""

	DbSelectArea("SX5")
	SX5->(DBSetOrder(1)) //X5_FILIAL + X5_TABELA + X5_CHAVE
	If SX5->(MsSeek(xFilial("SX5") + "XW" + cIdFin))
		cDescIdFin := AllTrim(X5Descri())
	EndIf

	RestArea(aArea)
	
Return cDescIdFin

/*/{Protheus.doc} FR122Campo
	
	Función utilizada para imprimir de forma dinámica los campos en el informe,
	para todo lo diferente a Planilla.
	
	@type  Static Function
	@author marco.rivera
	@since 15/10/2021
	@version 1.0
	@param olReport, Objeto, Objeto del Reporte
	@param cDescCampo, Caracter, Descripción del campo a procesar
	@param nPosEquiv, Numerico, Pixel para impresión de columnas
	@example
	FR122Campo(olReport, cDescCampo, nPosEquiv)
	/*/
Static Function FR122Campo(olReport, cDescCampo, nPosEquiv)

	Local nTamCampo		:= 0
	Local nCantLin		:= 0
	Local nIteracion	:= 0
	Local nRespRow		:= 0
	Local nLinIniImp	:= 1
	Local nSalto		:= 0
	
	Default olReport	:= Nil
	Default cDescCampo	:= ""
	Default nPosEquiv	:= 0

	nTamCampo := Len(RTrim(cDescCampo))

	If nTamCampo % 20 > 0
		nCantLin := NoRound(nTamCampo / 20, 0) + 1
	Else
		nCantLin := nTamCampo / 20
	EndIf

	nRespRow := olReport:Row()
	For nIteracion := 1 To nCantLin
		olReport:PrintText(Substr(cDescCampo, nLinIniImp, 20), nRespRow + nSalto, nPosEquiv)
		nLinIniImp += 20
		nSalto += 30
	Next nIteracion
	olReport:SetRow(nRespRow)

Return


/*/{Protheus.doc} FR122Ckey
Función utilizada para cambiar el valor ct2key del titulo dado de baja por el metodo de pago utilizado.
@type Static Function
@author Verónica Flores Falcón
@since 27/10/2021
@version 1.0
@example  FR122Ckey(ct2key,ct2SegOfi)
@param ct2key, Caracter, llave del titulo dado de baja de la tabla CT2.
@param ct2SegOfi, Caracter, Identificador del titulo dado de baja de la tabla CT2.
/*/
Static Function FR122Ckey(ct2key,ct2SegOfi)
	Local cAliasQry := GetNextAlias()
	Local cMoneda 	:= strzero(val(MV_PAR07),2) 
	Local nCad		:= AT("TB", ct2Key) - 1
	Local cNoPag	:= SUBSTR(ct2Key, 1, nCad) 
	Local cRet		:= ""
	Local cCond		:= ""

	If Alltrim(Upper(TCGetDB())) == "ORACLE"	
		cCond := "% SUBSTR(CT2.CT2_KEY,"+ Str(nCad+1) +",2) <> 'TB' AND SUBSTR(CT2.CT2_KEY,1," + Str(nCad) + ")%"
	Else
		cCond := "% SUBSTRING(CT2.CT2_KEY,"+ Str(nCad+1) +",2) <> 'TB' AND SUBSTRING(CT2.CT2_KEY,1," + Str(nCad) + ")%"
	EndIF

	BeginSQL Alias cAliasQry
		%noparser%
		SELECT CT2_KEY FROM %Table:CT2% CT2
			WHERE %Exp:cCond% = %Exp:cNoPag%
			AND CT2.CT2_SEGOFI= %Exp:ct2SegOfi%
			AND CT2.CT2_MOEDLC= %Exp:cMoneda%
			AND CT2.%NotDel%
	EndSQL
	If !Empty((cAliasQry)->CT2_KEY)
		cRet := (cAliasQry)->CT2_KEY
	else
		cRet := ct2key	
	EndIF	

	(cAliasQry)->(dbCloseArea())

Return cRet 
