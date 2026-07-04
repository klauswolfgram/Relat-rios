/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "RwMake.ch"
#Include "Protheus.ch"
#Include "TopConn.ch"
#Include "FINR121.ch"

#define PIX_DIF_COLUNA_VALORES		340		// Pixel inicial para impressao dos tracos das colunas dinamicas
#define PIX_INICIAL_VALORES			000		// Pixel para impressao do traco vertical
#define PIX_EQUIVALENTE				010		// Pixel inicial para impressao das colunas dinamicas

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR121  ³ Autor ³ Francisco Junior          ³ Data ³  01.06.10  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Caixas e Bancos - Movimento Efetivo Caixa                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Localidade Peru                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³             ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data    ³ BOPS/FNC  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Francisco Jr³01/06/10 ³0030358-09 ³Inclusao do fonte de emissao de relatorio ³±±
±±³            ³         ³           ³finr122, rotina de carga na FR0 - Tabelas ³±±
±±³            ³         ³           ³Genericas tabela TP - Tipos de Pagamento. ³±±
±±³ Marco A.   ³06/12/16 ³SERINN001- ³Se realizan cambios, para aplicar CTREE y ³±±
±±³            ³         ³128        ³evitar que se generen tablas temporales en³±±
±±³            ³         ³           ³system fisicamente. (PER)                 ³±±
±±³Veronica Flo³10/07/19 ³DMINA-6847 ³Se compatibiliza el fuente para versión   ³±±
±±³            ³         ³		     ³11.8 y 12.1.17	PER						³±±
±±³gsantacruz  ³10/01/20³DMINA-8172  ³Estabilizacion realizada por Percy con    ³±±
±±³            ³        ³            ³RSM.                                      ³±±
±±³Marco A. Glz³10/08/21³DMINA-13391 ³Se modifica la func. GerReporte, para     ³±±
±±³            ³        ³            ³imprimir valores en cero cuando no haya   ³±±
±±³            ³        ³            ³movs. en las ctas. seleccionadas. (PER)   ³±±
±±³Oscar G.    ³30/09/21³DMINA-13602 ³Se sustituye imp. con Say por PrintText,  ³±±
±±³            ³        ³            ³ademas de ajusta margen sup., izq. e inf. ³±±
±±³            ³        ³            ³para impresion dif. de planilla. (PER)    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function FINR121()

	Local cPerg		:= "FIN121"
	Local olReport	:= Nil

	Private aRenglon := {}

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ mv_par01 - Data Inicial?	- Data inicial dos livros fiscais  ³
	³ mv_par02 - Data Final?	- Data final dos livros fiscais    ³
	³ mv_par03 - De Filial?		- Filial Inicial                   ³
	³ mv_par04 - A Filial?		- Filial Final                     ³
	³ MV_PAR05 - ¿Generar Archivo TXT? 							   ³
	³ MV_PAR06 - ¿Ruta para generar  TXT? 						   ³
	³ MV_PAR07 - ¿Moneda? 										   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

	Pergunte(cPerg, .F.)
	olReport := FinRelat(cPerg)
	olReport:SetParam(cPerg)
	olReport:PrintDialog()

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FINRelat  ³ Autor ³ Totvs                 ³ Data | 01/06/10 ³±±
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

	Local clNomProg		:= FunName()
	Local clTitulo 		:= STR0001 //"Detalhes da Diferenca de Cambio"
	Local clDesc   		:= STR0001 //"Detalhes da Diferenca de Cambio"
	Local olReport

	olReport := TReport():New(clNomProg,clTitulo,cPerg,{|olReport| FINPRO121(olReport)},clDesc)

	olReport:SetPortrait()					// Formato paisagem
	olReport:oPage:nPaperSize	:= 9		// Impresion en papel A4
	olReport:lHeaderVisible 	:= .F. 		// Não imprime cabeçalho do protheus
	olReport:lFooterVisible 	:= .F.		// Não imprime rodapé do protheus
	olReport:lParamPage			:= .F.		// Não imprime pagina de parametros

Return olReport

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FINPRO121 ³ Autor ³ Totvs                 ³ Data | 01/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressão do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FINPRO121( ExpC1 )         				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 = Objeto tReport                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FINPRO121(olReport)

	Local lAutomato   := isBlind() //Variable utilizada para automatización.

	Private cTabela14	:= ""
	Private cExpMda		:= ""

	// Carrega a tabela 14 - Da mesma forma como feita no extrato bancario - FINR470
	SX5->(DbSetOrder(1)) //X5_FILIAL + X5_TABELA + X5_CHAVE
	SX5->(MsSeek(xFilial("SX5")+"14"))
	While SX5->(!Eof()) .And. SX5->X5_TABELA == "14"
		cTabela14 += (Alltrim(SX5->X5_CHAVE) + "/")
		SX5->(DbSkip())
	End
	cTabela14 += If(cPaisLoc=="BRA","","/$ ")
	cExpMda	:= " E5_MOEDA NOT IN " + FormatIn(cTabela14,"/")

	If MV_PAR05 == 1 //¿Generar Archivo TXT?
		If !lAutomato
   			Processa({|| GerArq(AllTrim(MV_PAR06))},,STR0041 ) //"Generando Archivo Electrónico"
		Else
			ConOut(STR0041) //"Generando Archivo Electrónico"
			GerArq(AllTrim(MV_PAR06))
		EndIf
	Else
		If !lAutomato
			Processa({|| GerReporte(olReport,AllTrim(MV_PAR06))},,STR0042) //"Generando Informe"
		Else
			ConOut(STR0042) //"Generando Informe"
			GerReporte(olReport,AllTrim(MV_PAR06))
		EndIf
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FINR121  ºAutor  ³Microsiga           ºFecha ³  11/04/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GerReporte(olReport,cDir)

	Local nReg			:= 0 //Quantidade de registros impressos
	Local nPag			:= 0 //Quantidade de paginas por pagina
	Local nCol			:= 0
	Local cBanco		:= SuperGetMv("MV_CAJALF",.t.,"CX1/CX2/C01")
	Local aColFin       := { STR0027, STR0009, STR0007,	"", "","","" } //"Número Correlativo del" # "Fecha de la" # "Descripción"
	Local aColFin2      := { STR0028, STR0010, STR0011, "", "", "" ,""} //"Registro o Código" # "Operación" # "    OPERAC. "

	Local aColFin3      := {"", "", "", STR0012, STR0014, STR0015, STR0017} //"Codigo" # "Denominación" # "Deudor" # "ACREE."

	// Deve obedecer a ordem das colunas do relatorio, caso não tenha campo na Query, identificar a primeira letra com "n - numerico, c - caracter"
	Local aEquivale 	:= { "E5_NODIA", "E5_DATA", "E5_HISTOR","CT2_CREDIT", "CT1_DESC01", "E5_VALOR","" }
	Local nInc			:= 0
	Local nPosEquiv		:= 0
	Local nTotDeb		:= 0
	Local nTotCre		:= 0
	Local nTotSup		:= 0
	Local lIni			:= .T.
	Local nDeb 			:= 0
	Local nCred 		:= 0
	Local nSldIni 		:= 0
	Local np			:= 0
	Local nX			:= 0
	Local aCuentas		:= {}
	Local aCUOsCta		:= {}
	Local cCtaCtb		:= ""
	Local lImprime		:= .T.
	Local aSaldAnt		:= {}
	Local aVert			:= {}
	Local aVertSal		:= {}
	Local nRowImp		:= 0
	Local nOpcImp		:= olReport:nDevice //1-Archivo,2-Impresora,3-Email,4-Planilla, 5-Html y 6-PDF
	Local nLimReg		:= IIf(nOpcImp == 6, 40,46)

	Private oTmpTable	:= Nil
	private _cAliasBco
	private cContCtb	:= ""
	private cNomCon	    := ""
	Private nMarIz		:= 110 //Margen a la izquierdo

	If Empty(cBanco)
		MsgInfo(OemToAnsi(STR0043), OemToAnsi(STR0039))	// "Por favor, configurar el parámetro MV_CAJALF." ## "Atención"
		Return
	Endif

	aVert		:= { nMarIz, 340 + nMarIz, 680, 1020, 1360, 1700, 2040, 2380 }
	aVertSal	:= { nMarIz, 1700, 2040, 2380 }
	_cAliasBco := getNextAlias()

	vsql := "SELECT A6_COD,A6_AGENCIA,A6_NUMCON,A6_CONTA,A6_NOME,A6_IDFIN,A6_CGC"
	vsql += "  FROM "+RetSqlName("SA6")
	vsql += " WHERE A6_FILIAL='"+xFilial("SA6")+"'"
	vsql += "   AND A6_COD IN "+Formatin(cBanco,"/")
	vsql += "   AND A6_CONTA<>''  AND D_E_L_E_T_=''"

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, vsql ), _cAliasBco,.T.,.T.)

	If (_cAliasBco)->(!Eof())

		FCabR161( olReport, nCol, aColFin, aColFin2, aColFin3, aVert) //Impressão do cabeçalho
		olReport:OnPageBreak( { || FCabR161( olReport, nCol, aColFin, aColFin2, aColFin3, aVert ) } )
		olReport:SetMeter( RecCount() )

		While (_cAliasBco)->(!Eof())
			
			If (_cAliasBco)->A6_CONTA <> cCtaCtb
				If !Empty(cCtaCtb).And. lImprime
					FR121Tot(olReport, aSaldAnt, @nTotDeb, @nTotCre, @nSldIni, aVertSal)
					olReport:EndPage()
					nPag := 0
					nCred := 0
					nDeb := 0
					lIni := .T.
				EndIf
				cCtaCtb := (_cAliasBco)->A6_CONTA
			EndIf

			aSize(aCuentas, 0)
			cBenef := ""
			cBanMov := (_cAliasBco)->A6_COD
			cConMov := (_cAliasBco)->A6_NUMCON
			cAgeMov := (_cAliasBco)->A6_AGENCIA
			cNomCon  := (_cAliasBco)->A6_NOME
			cContCtb := (_cAliasBco)->A6_CONTA
			cCodEntFin := (_cAliasBco)->A6_IDFIN
			cCtaBanCon := (_cAliasBco)->A6_NUMCON
			cFechaOpe  := SPACE(8)
			cDesOpeBan := ""
			cNumTraBan := ""
			cCtaCajas := fgetCajas(cBanco)
			cNumCorre := ""
			cCodUniOpe := ""
			lVerCorr := .F.
			lSoloSE5 := .f.
			aSize(aCUOsCta, 0)

			If !Empty(cContCtb)
				aCUOsCta := getCUOs(cContCtb)
			EndIf

			for np := 1 to len(aCUOsCta)

				hAlias := getNextAlias()
				cCtaCtb := (_cAliasBco)->A6_CONTA

				cQry := "SELECT CT2_FILIAL,CT2_KEY,CT2_ROTINA,CT2_LP,CT2_LINHA,CT2_NODIA,CT2_SEGOFI,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_HIST,CT2_DATA"
				cQry += "  FROM " + RetSqlName("CT2") + " CT2"
				cQry += " WHERE CT2_SEGOFI = '" + aCUOsCta[np][1] + "'"
				cQry += "   AND CT2_FILIAL BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
				cQry += "   AND CT2_DEBITO<>''"
				cQry += "   AND CT2_DEBITO<>'"+cCtaCtb+"'"
				cQry += "   AND ( SUBSTRING(CT2_DEBITO,1,1)<>'9' AND SUBSTRING(CT2_DEBITO,1,2)<>'79' )"
				cQry += "   AND CT2_VALOR>0"
				cQry += "   AND CT2_MOEDLC='"+MV_PAR07+"'"
				cQry += "   AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
				cQry += "   AND CT2.D_E_L_E_T_='' "
				cQry += " UNION ALL "
				cQry += "SELECT CT2_FILIAL,CT2_KEY,CT2_ROTINA,CT2_LP,CT2_LINHA,CT2_NODIA,CT2_SEGOFI,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_HIST,CT2_DATA"
				cQry += "  FROM " + RetSqlName("CT2") + " CT2"
				cQry += " WHERE CT2_SEGOFI = '" + aCUOsCta[np][1] + "'"
				cQry += "   AND CT2_FILIAL BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
				cQry += "   AND CT2_CREDIT<>''"
				cQry += "   AND CT2_CREDIT<>'"+cCtaCtb+"'"
				cQry += "   AND ( SUBSTRING(CT2_CREDIT,1,1)<>'9' AND SUBSTRING(CT2_CREDIT,1,2)<>'79' )"
				cQry += "   AND CT2_VALOR>0"
				cQry += "   AND CT2_MOEDLC='"+MV_PAR07+"'"
				cQry += "   AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
				cQry += "   AND CT2.D_E_L_E_T_='' "

				dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), hAlias,.T.,.T.)

				if (hAlias)->( !Eof() )

					while (hAlias)->( !Eof() )

						aDtaOrigen := {}
						aDtaOrigen := ObtInfo((hAlias)->CT2_KEY,(hAlias)->CT2_LP)
						cCodUniOpe := Alltrim((hAlias)->CT2_LINHA)
						cContCtb := Iif( empty((hAlias)->CT2_CREDIT),(hAlias)->CT2_DEBITO,(hAlias)->CT2_CREDIT )
						cNumCorre := (hAlias)->CT2_SEGOFI
						cGlosa := AllTrim((hAlias)->CT2_HIST)

						If CT1->(MsSeek(xFilial("CT1") + cContCtb))
							cNomCon := AllTrim(CT1->CT1_DESC01)
						Endif

						cContSup := cCtaCtb		//F121CTSUP(cContCtb)

						Aadd( aCuentas, {	cCodUniOpe			,;							// 01
											cContCtb			,;							// 02
											cNomCon				,;							// 03
											(hAlias)->CT2_VALOR	,;							// 04
											cNumCorre			,;							// 05
											if(empty((hAlias)->CT2_CREDIT),"D","C"),;		// 06
											(hAlias)->CT2_CREDIT,;							// 07
											(hAlias)->CT2_DEBITO,;							// 08
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
											cContSup			;							// 21 - Cta superior
						}  )

						(hAlias)->(DbSkip())

					End

				EndIf

				(hAlias)->( dbCLoseArea() )

			Next np

			// aqui imprime
			// ------------
			if len(aCuentas)>0
				lImprime := .T.
				nTotSup := 1
				lIni := .T.

				for nX := 1 to len(aCuentas)

					If olReport:Cancel()
						Exit
					EndIf
					nPosEquiv 	:= (PIX_EQUIVALENTE + nMarIz)
					If lIni
						If nTotSup > 1
							FR161Prnt( olReport, aVert )
							olReport:Box(olReport:Row()+2, nMarIz, olReport:Row()+2, 2380 )
							olReport:SkipLine( 1 )
						EndIf
						aSaldAnt := SaldoCT7Fil(aCuentas[nX][2],MV_PAR01-1,MV_PAR07,"1","FINR121")
						FR121ImpPl(olReport, 2)
						olReport:PrintText( STR0035, olReport:Row(), 690)		// "Saldo Inicial"
						FR121ImpPl(olReport, 3)
						olReport:PrintText( Transform(aSaldAnt[1], "@E 9999,999,999,999.99"), olReport:Row(), 2050)
						
						FR161Prnt( olReport, aVertSal )
						olReport:SkipLine( 1 )
						olReport:Line(olReport:Row(), nMarIz, olReport:Row(), 2380 )
						lIni := .F.
						nSldIni := aSaldAnt[1]
						nPag := 0
					EndIf

					// Imprime a linhas verticais e passa para proxima linha
					FR161Prnt( olReport, aVert )
					nRowImp := olReport:Row()
					For nInc := 1 To Len( aEquivale )
						If nInc > 1
							nPosEquiv 	+= PIX_DIF_COLUNA_VALORES
						EndIf
						If aEquivale[nInc]=="E5_NODIA"
							olReport:PrintText( Substr( aCuentas[nX][5],1,25), nRowImp, nPosEquiv )
						ElseIf aEquivale[nInc]=="E5_DATA"
							olReport:PrintText( PADR(dtOc(sTOd( aCuentas[nX][18] ) ),30), nRowImp, nPosEquiv )
							nPosEquiv -= nMarIz
						ElseIf aEquivale[nInc]=="E5_HISTOR"
							If nOpcImp <> 4
								olReport:PrintText( Substr( aCuentas[nX][14],  1, 22), nRowImp, nPosEquiv )
								olReport:PrintText( Substr( aCuentas[nX][14], 23, 44), nRowImp+30, nPosEquiv )
							Else
								olReport:PrintText( aCuentas[nX][14], nRowImp, nPosEquiv )
							EndIf
						ElseIf aEquivale[nInc]=="CT2_CREDIT"
							if !empty(aCuentas[nX][7])
								olReport:PrintText( Substr( aCuentas[nX][7],1,25), nRowImp, nPosEquiv )
							else
								olReport:PrintText( Substr( aCuentas[nX][8],1,25), nRowImp, nPosEquiv )
							endif
						ElseIf aEquivale[nInc]=="CT1_DESC01"
							If nOpcImp <> 4
								olReport:PrintText( Substr( aCuentas[nX][3],  1, 22), nRowImp, nPosEquiv )
								olReport:PrintText( Substr( aCuentas[nX][3],  23, 44), nRowImp+30, nPosEquiv )
								FR161Prnt( olReport, aVert )
							Else
								olReport:PrintText( aCuentas[nX][3], nRowImp, nPosEquiv )
							EndIf
						ElseIf aEquivale[nInc] == "E5_VALOR"
							If aCuentas[nX][6]=="C"
								olReport:PrintText( Transform( aCuentas[nX][4], "@E 9999,999,999,999.99"), nRowImp, nPosEquiv )
								nTotDeb 	+= aCuentas[nX][4]
								nDeb += aCuentas[nX][4]
							Else
								FR121ImpPl(olReport, 1)
								olReport:PrintText( Transform( aCuentas[nX][4], "@E 9999,999,999,999.99"), nRowImp, nPosEquiv + PIX_DIF_COLUNA_VALORES )
								nTotCre		+= aCuentas[nX][4]
								nCred += aCuentas[nX][4]
							Endif
						Endif

					Next
					olReport:SetRow(nRowImp)
					olReport:SkipLine( IIf(nOpcImp <> 4,2,1) )
					olReport:Box( olReport:Row() + 2, nMarIz, olReport:Row() + 2, 2380 )
					If nOpcImp <> 4 .And. nPag > nLimReg
						olReport:EndPage()
						olReport:Box( olReport:Row(), olReport:Col(), olReport:Row(), olReport:Col() )
						nPag := 0
					EndIf
					nRowImp := olReport:Row()
					If	aCuentas[nX][21] != (_cAliasBco)->A6_CONTA
						olReport:PrintText( STR0036 + DtoC(MV_PAR02), nRowImp, 690) //"Saldo final en "
						olReport:PrintText( Transform((nCred) - (aSaldAnt[1] + nDeb), "@E 9999,999,999,999.99"), nRowImp, 2050)
						olReport:Box( nRowImp + 2,nMarIz, nRowImp + 2, 2380)

						FR161Prnt( olReport,aVert)
						olReport:SkipLine( 1 )
						nTotSup++
						lIni := .T.
						nDeb := nCred := 0
					EndIf

					olReport:IncMeter()
					nPag++ // Quantidade de registros por pagina
					nReg++ // Quantidade de registros impressos

				next nX
			Else
				lImprime := .F.
				FR121ImpPl(olReport, 2)
				olReport:PrintText( STR0035, olReport:Row(), 690 ) // "Saldo Inicial"
				FR121ImpPl(olReport, 3)
				olReport:PrintText( Transform(0.00, "@E 9999,999,999,999.99"), olReport:Row(), 2050 )
				FR161Prnt( olReport, aVertSal )
				olReport:SkipLine( 1 )
				olReport:Box(olReport:Row() + 2, nMarIz, olReport:Row()+2, 2380)
				nPag := 0
				nCred := 0
				nDeb := 0
				FR121Tot(olReport, , 0, 0, 0, aVertSal)
				olReport:EndPage()
			EndIf
			// ------------
			(_cAliasBco)->( dbSkip() )
		end

	endif

	If lImprime
		FR121Tot(olReport, aSaldAnt, @nTotDeb, @nTotCre, @nSldIni, aVertSal)
	EndIf

	(_cAliasBco)->( dbCLoseArea() )

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FCabR161  ³ Autor ³ Totvs                 ³ Data | 01/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabeçalho do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FCabR161(Expo1,ExpN1,ExpA1)  				                  ³±±
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
Static Function FCabR161( olReport, nCol, aColFin, aColFin2, aColFin3, aVert )

	Local nInc			:= 0
	Local nX			:= 0
	Local nColPix		:= 0
	Local nIniDin		:= PIX_INICIAL_VALORES // Pixel redimencionado dinamicamente
	Local nOpcImp		:= olReport:nDevice //1-Archivo,2-Impresora,3-Email,4-Planilla, 5-Html y 6-PDF
	Local nTamPad		:= 0
	Local nCharPCol		:= 30 // Quantidade de caracteres por coluna
	Local nRowRes		:= 0
	Local aImpTit		:= {aColFin, aColFin2, aColFin3}

	olReport:SetCol(nMarIz)
	nColPix := olReport:Col()

	If nOpcImp <> 4 //Espacios encabezado
		olReport:PrintText("", olReport:Row(), olReport:Col())
		olReport:PrintText("", olReport:Row()+34, olReport:Col())
		olReport:PrintText("", olReport:Row()+34, olReport:Col())
	EndIf

	olReport:PrintText( STR0020,olReport:Row() ,nColPix) //"FORMATO 1.1: 'LIBRO CAJA Y BANCOS - DETALLE DE LOS MOVIMIENTOS DEL EFECTIVO'"
	olReport:SkipLine(1)
	olReport:PrintText( STR0004 + dToC( MV_PAR01 ) + " - " + dToC( MV_PAR02 ) ,olReport:Row() ,nColPix) //Periodo
	olReport:PrintText( STR0005 + AllTrim( SM0->M0_CGC),olReport:Row()+35, nColPix) //RUC
	olReport:PrintText( STR0006 + " " + AllTrim(SM0->M0_NOMECOM),olReport:Row()+40, nColPix) //Nome Contribuinte
	olReport:PrintText( STR0044 + AllTrim( (_cAliasBco)->A6_CONTA ) + " - " + Posicione("SA6",1,xFilial("SA6")+(_cAliasBco)->A6_COD,"A6_NOME") ,olReport:Row()+35,nColPix )
	olReport:SkipLine(2)

	nRowRes := olReport:Row()

	olReport:Box(nRowRes-004,nColPix, nRowRes+030, 1020)

	// Primeira linha
	nTamPad	:= Len( aColFin ) * nCharPCol
	FR121ImpPl(olReport, 3)
	olReport:Box( nRowRes - 004, 1020, nRowRes + 030, 1700)
	olReport:PrintText( Alltrim(STR0013), nRowRes-003, 1220) //   CUENTA CONTABLE ASOCIADA
	
	FR121ImpPl(olReport, 1)
	olReport:Box( nRowRes - 004, 1700, nRowRes + 030, 2380)
	olReport:PrintText( Alltrim(STR0016), nRowRes-003, 1900) //          SALDOS Y MOVIMIENTOS
	nIniDin += ( PIX_DIF_COLUNA_VALORES * Len( aColFin ) )

	olReport:SkipLine( 1 )
	// Imprime as contas
	For nX :=1 To Len(aImpTit)
		nIniDin	:= PIX_INICIAL_VALORES + nMarIz
		nRowRes := olReport:Row()
		For nInc := 1 To Len( aImpTit[nX] )
			nIniDin -= IIF(nInc==2,nMarIz/2,0)
			olReport:PrintText( PadC(AllTrim(aImpTit[nX][nInc]),25), nRowRes+1, nIniDin)
			nIniDin += (PIX_DIF_COLUNA_VALORES - IIF(nInc==2,nMarIz/2,0))
		Next
		FR161Prnt( olReport, aVert )
		olReport:SkipLine( 1 )
	Next nX

	olReport:Line(olReport:Row() + 2, nMarIz, olReport:Row() + 2, 2380)

Return()

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR161Prnt ³ Autor ³ Totvs                 ³ Data | 01/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime as linhas verticais e horizontais do relatorio      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FR161Prnt( ExpA1 )         				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1 = Array com as colunas                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR161Prnt( olReport, aCol )

	Local nInc 		:= 1
	Local nLinPix   := 34

	For nInc := 1 To Len( aCol )
		olReport:Box( olReport:Row(), aCol[nInc], olReport:Row()+nLinPix, aCol[nInc] ) 			// traco vertical
	Next

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F121CTSUP ºAutor  ³ Pedro Pereira Lima º Data ³  08/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F121CTSUP(cCtaCtb)

	Local aArea 	:= GetArea()
	Local cCtaSup 	:= ""

	DbSelectArea("CT1")
	DbSetOrder(1)
	If MsSeek(xFilial("CT1")+cCtaCtb)
		If !Empty(CT1->CT1_CTASUP)
			cCtaSup := F121CTSUP(CT1->CT1_CTASUP)
		Else
			cCtaSup := cCtaCtb
		EndIf
	Else
		cCtaSup := Space(TamSX3("CT1_CTASUP")[1])
	EndIf

	RestArea(aArea)

Return cCtaSup

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ZFINR121  ºAutor  ³Microsiga           º Data ³  10/29/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fgetCajas(cCajas)

	local vArea := getArea()
	local cQry := ""
	local Jalias := getNextAlias()
	local cCContab := ""

	cQry := "SELECT A6_CONTA"
	cQry += "  FROM " + RetSqlName("SA6")
	cQry += " WHERE A6_FILIAL = '" + xFilial("SA6") + "'"
	cQry += "   AND A6_COD IN "+Formatin(cCajas,"/")+ "   AND D_E_L_E_T_='' "

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), Jalias,.T.,.T.)

	if (jalias)->( !Eof() )
		while (jalias)->( !Eof() )
			cCContab += alltrim((jalias)->A6_CONTA)+"|"
			(jalias)->( dbSkip() )
		end
	endif

	(jalias)->( dbCloseArea() )

	RestArea(vArea)

Return(cCContab)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ZFINR121  ºAutor  ³Microsiga           º Data ³  10/29/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function getCUOs(xCtaCtb)

	local _vArea  := getArea()
	local _vAlias := getNextAlias()
	local _aCuosg := {}

	cQry := "SELECT CT2_FILIAL,CT2_KEY,CT2_ROTINA,CT2_LP,CT2_LINHA,CT2_NODIA,CT2_SEGOFI,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_DATA,CT2_HIST,CT2_LOTE,CT2_SBLOTE"
	cQry += "  FROM " + RetSqlName("CT2")
	cQry += " WHERE CT2_FILIAL BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
	cQry += "   AND CT2_DEBITO<>''"
	cQry += "   AND CT2_DEBITO='"+xCtaCtb+"'"
	cQry += "   AND ( SUBSTRING(CT2_DEBITO,1,1)<>'9' AND SUBSTRING(CT2_DEBITO,1,2)<>'79')"
	cQry += "   AND CT2_VALOR>0"
	cQry += "   AND CT2_MOEDLC='"+strzero(val(MV_PAR07),2)+"'"
	cQry += "   AND D_E_L_E_T_='' "
	cQry += "   AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
	cQry += " UNION ALL "
	cQry += "SELECT CT2_FILIAL,CT2_KEY,CT2_ROTINA,CT2_LP,CT2_LINHA,CT2_NODIA,CT2_SEGOFI,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_DATA,CT2_HIST,CT2_LOTE,CT2_SBLOTE"
	cQry += "  FROM " + RetSqlName("CT2")
	cQry += " WHERE CT2_FILIAL BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
	cQry += "   AND CT2_CREDIT<>''"
	cQry += "   AND CT2_CREDIT='"+xCtaCtb+"'"
	cQry += "   AND ( SUBSTRING(CT2_CREDIT,1,1)<>'9' AND SUBSTRING(CT2_CREDIT,1,2)<>'79')"
	cQry += "   AND CT2_VALOR>0"
	cQry += "   AND CT2_MOEDLC='"+strzero(val(MV_PAR07),2)+"'"
	cQry += "   AND CT2_DATA BETWEEN '" + DTOS( mv_par01 ) + "' AND '" + DTOS ( mv_par02 ) + "' "
	cQry += "   AND D_E_L_E_T_=''  ORDER BY CT2_DATA"

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
									(_vAlias)->CT2_LOTE							,;			// 11
									(_vAlias)->CT2_SBLOTE						,;			// 12
									(_vAlias)->CT2_FILIAL						;			// 13
					})
			endif
			(_vAlias)->( dbSkip() )
		end

	endif

	(_vAlias)->( dbCloseArea() )

	restArea(_vArea)

Return(_aCuosg)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ZFINR121  ºAutor  ³Microsiga           º Data ³  10/29/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ObtInfo(ct2Key,ct2Lp)

	Local cQry := ""
	Local aCampos := {}
	Local cKeyArr := ""
	Local nX := 0
	Local aKey := {}
	Local vAlias := getNextAlias()
	Local cCampo := ""

	dbSelectArea("CTL")
	dbSetOrder(1) //CTL_FILIAL + CTL_LP

	If CTL->(MsSeek(xFilial("CTL") + ct2Lp))
		cKeyArr := CTL->CTL_KEY
	EndIf

	If !Empty(cKeyArr)
		aCampos := StrTokArr( cKeyArr, "+" )
	EndIf

	If ct2Lp $ "575/576"

		nPos := 1

		cQry := "SELECT EL_FILIAL,EL_CLIENTE,EL_LOJA,EL_RECIBO,EL_MOEDA,EL_TIPO,EL_PREFIXO,EL_NUMERO "
	    cQry += " FROM " + RetSqlName("SEL") + " WHERE D_E_L_E_T_='' "

		For nX := 1 To Len(aCampos)
			cCampo := substr(ct2Key,nPos,TamSx3(aCampos[nX])[1] )
			If "'" $ cCampo
				cCampo := Strtran(cCampo, "'", "''")
			EndIf

			cQry += " AND " + alltrim(aCampos[nX]) + "='" + cCampo + "'"
			nPos += TamSx3(aCampos[nX])[1]
		Next nX

	    If Select("TRBSEK") > 1
			TRBSEK->( DbCLoseArea() )
		EndIf

		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQry ), "TRBSEK",.T.,.T.)

		DbSelectArea( "TRBSEK" )
		TRBSEK->( DbGoTop() )

		if TRBSEK->( !Eof() )

			SA1->( dbSetOrder(1) )
			SA1->( MsSeek( xFilial("SA1")+TRBSEK->EL_CLIENTE+TRBSEK->EL_LOJA ) )

			vQry := "SELECT EL_FILIAL,EL_CLIENTE,EL_LOJA,EL_RECIBO,EL_MOEDA,EL_TIPO,EL_PREFIXO,EL_NUMERO "
		    vQry += " FROM " + RetSqlName("SEL")
		    vQry += " WHERE D_E_L_E_T_=''   AND EL_FILIAL='"+xFilial("SEK")+"'"
		    vQry += "   AND EL_RECIBO='"+TRBSEK->EL_RECIBO+"'   AND EL_TIPO='NF'"

			dbUseArea( .T., "TOPCONN", TcGenQry( ,, vQry ), vAlias,.T.,.T.)
			if (vAlias)->(!eof())
				SF2->( dbSetOrder(1) )
				SF2->( MsSeek( xFilial("SF2")+(vAlias)->EL_NUMERO+(vAlias)->EL_PREFIXO+(vAlias)->EL_CLIENTE+(vAlias)->EL_LOJA ) )
			endif
			(vAlias)->( dbCloseArea() )

			Aadd( aKey, { TRBSEK->EL_CLIENTE	,;
						  TRBSEK->EL_LOJA		,;
						  SA1->A1_NOME			,;
						  SA1->A1_TIPDOC		,;
						  SA1->A1_CGC			,;
						  SA1->A1_PFISICA		,;
						  TRBSEK->EL_RECIBO		,;
						  TRBSEK->EL_TIPO		,;
						  TRBSEK->EL_MOEDA		,;
						  SF2->F2_SERIE2		,;						//TRBSEK->EL_PREFIXO	,;				// 10 - SERIE
						  SF2->F2_TPDOC			,;
						  SF2->F2_DOC			,;
						  SF2->F2_NODIA			,;
						  ""					;
			} )
		else
			Aadd( aKey, { "" ,"","" ,"" ,"" ,"" ,"" ,"" , "" ,"" ,"" ,"" ,"" ,""} )

		Endif

	ElseIf ct2Lp $ "570/571"

		// EK_FILIAL+EK_ORDPAGO+EK_TIPODOC+EK_PREFIXO+EK_NUM+EK_PARCELA+EK_TIPO
		nPos := 1

		cQry := "SELECT EK_FILIAL,EK_FORNECE,EK_LOJA,EK_ORDPAGO,EK_MOEDA,EK_TIPO,EK_PREFIXO,EK_NUM "
	    cQry += " FROM " + RetSqlName("SEK") + " WHERE D_E_L_E_T_='' "
		For nX := 1 To Len(aCampos)
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

			vQry := "SELECT EK_FILIAL,EK_FORNECE,EK_LOJA,EK_ORDPAGO,EK_MOEDA,EK_TIPO,EK_PREFIXO,EK_NUM "
		    vQry += " FROM " + RetSqlName("SEK")
		    vQry += " WHERE D_E_L_E_T_=''  AND EK_FILIAL='"+xFilial("SEK")+"'"
		    vQry += "   AND EK_ORDPAGO='"+TRBSEK->EK_ORDPAGO+"'  AND EK_TIPO='NF'"

			dbUseArea( .T., "TOPCONN", TcGenQry( ,, vQry ), vAlias,.T.,.T.)
			if (vAlias)->(!eof())
				SF1->( dbSetOrder(1) )
				SF1->( MsSeek( xFilial("SF1")+(vAlias)->EK_NUM+(vAlias)->EK_PREFIXO+(vAlias)->EK_FORNECE+(vAlias)->EK_LOJA ) )
			endif
			(vAlias)->( dbCloseArea() )


			SA2->( dbSetOrder(1) )
			SA2->( MsSeek( xFilial("SA2")+TRBSEK->EK_FORNECE+TRBSEK->EK_LOJA ) )

			Aadd( aKey, { TRBSEK->EK_FORNECE	,;
						  TRBSEK->EK_LOJA		,;
						  SA2->A2_NOME			,;
						  SA2->A2_TIPDOC		,;
						  SA2->A2_CGC			,;
						  SA2->A2_PFISICA		,;
						  TRBSEK->EK_ORDPAGO	,;
						  TRBSEK->EK_TIPO		,;
						  TRBSEK->EK_MOEDA		,;
						  SF1->F1_SERIE2		,;
						  SF1->F1_TPDOC			,;
						  SF1->F1_DOC			,;
						  SF1->F1_NODIA			,;
						  SA2->A2_DOMICIL		;
			} )
		else
			Aadd( aKey, { "" ,"","" ,"" ,"" ,"" ,"" ,"" , "" ,"" ,"" ,"" ,"" ,""} )

		Endif

	ElseIf ct2Lp $ "560/561|562/563|564/565"	// TB salida-pagar / entrada-cobrar

		//E5_FILIAL+DTOS(E5_DATA)+E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ
		nPos := 1

		cQry := "SELECT E5_FILIAL,E5_DTDIGIT,E5_BANCO,E5_AGENCIA,E5_CONTA,E5_NUMCHEQ,E5_DOCUMEN,E5_RECPAG,E5_HISTOR,E5_TIPO,E5_MOEDA,E5_ORDREC,E5_NODIA"
	    cQry += " FROM " + RetSqlName("SE5")  + " WHERE D_E_L_E_T_='' "

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

			Aadd( aKey, { (_cAliasBco)->A6_NOME			,;
						  ""							,;
						  (_cAliasBco)->A6_NOME			,;
						  "6"		  					,;
						  (_cAliasBco)->A6_CGC			,;
						  ""							,;
						  iif(empty(TRBSEK->E5_DOCUMEN),TRBSEK->E5_NUMCHEQ,TRBSEK->E5_DOCUMEN)	,;
						  TRBSEK->E5_TIPO		,;
						  TRBSEK->E5_MOEDA		,;
						  ""					,;
						  iif( ( alltrim(TRBSEK->E5_TIPO)$"TF/EF" .Or. empty(TRBSEK->E5_TIPO) ),"00","01")	,;
						  TRBSEK->E5_ORDREC		,;
						  TRBSEK->E5_NODIA		,;
						  ""					;
			} )

		else
			Aadd( aKey, { "" ,"","" ,"" ,"" ,"" ,"" ,"" , "" ,"" ,"" ,"" ,"" ,""} )
		Endif

	else
		Aadd( aKey, { "" ,"","" ,"" ,"" ,"" ,"" ,"" , "" ,"" ,"" ,"" ,"" ,""} )

	EndIf

	If Select("TRBSEK") > 1
		TRBSEK->( DbCLoseArea() )
	Endif

Return( aKey )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FINR121  ºAutor  ³Microsiga           ºFecha ³  11/04/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GerArq(cDir)

	Local cBanco		:= SuperGetMv("MV_CAJALF",.t.,"CX1/CX2/C01")
	Local nTotDeb		:= 0
	Local nTotCre		:= 0
	Local cCRLF			:= (chr(13)+chr(10))
	Local cPeriodo      := AllTrim(StrZero(Year(MV_PAR01),4)) + AllTrim(StrZero(Month(MV_PAR01),2)) + "00"
	Local cEdoOpe       := "1"
	Local np			:= 0
	Local nX			:= 0
	Local nCont			:= 0
	Local nPos			:= 0
	Local aCuentas		:= {}
	Local aCUOsCta		:= {}

	Private cLbSiDom	:= SuperGetMv("MV_LFSDOM",.t.,"080100")
	Private cLbNoDom	:= SuperGetMv("MV_LFNDOM",.t.,"080200")
	Private cLbVenta	:= SuperGetMv("MV_LFVENT",.t.,"140100")
	Private oTmpTable	:= Nil
	Private _cAliasBco
	Private cContCtb	:= ""
	Private cNomCon	    := ""

	If Empty(cBanco)
		MsgInfo(OemToAnsi(STR0043), OemToAnsi(STR0039))	// "Por favor, configurar el parámetro MV_CAJALF." ## "Atención"
		Return
	Endif

	_cAliasBco := getNextAlias()

	vsql := "SELECT A6_COD,A6_AGENCIA,A6_NUMCON,A6_CONTA,A6_NOME,A6_IDFIN,A6_CGC"
	vsql += "  FROM "+RetSqlName("SA6")
	vsql += " WHERE A6_FILIAL='"+xFilial("SA6")+"'"
	vsql += "   AND A6_COD IN "+Formatin(cBanco,"/")
	vsql += "   AND A6_CONTA<>'' AND D_E_L_E_T_=''"

	If Select(_cAliasBco) > 0
		(_cAliasBco)->( DbCLoseArea() )
	Endif

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, vsql ), _cAliasBco,.T.,.T.)

	(_cAliasBco)->( DbGoTop() )

	nTotDeb	  := 0
	nTotCre	  := 0
	nValDeu  := 0
	nValAcre := 0

	While (_cAliasBco)->(!Eof())

		aSize(aCuentas, 0)
		cBenef := ""
		cBanMov := (_cAliasBco)->A6_COD
		cConMov := (_cAliasBco)->A6_NUMCON
		cAgeMov := (_cAliasBco)->A6_AGENCIA
		cNomCon  := ""
		cContCtb := ""
		cCodEntFin := (_cAliasBco)->A6_IDFIN
		cCtaBanCon := (_cAliasBco)->A6_NUMCON
		cFechaOpe  := SPACE(8)
		cDesOpeBan := ""
		cNumTraBan := ""
		cCtaCajas := fgetCajas(cBanco)
		cNumCorre := ""
		cCodUniOpe := ""
		lVerCorr := .F.
		lSoloSE5 := .f.
		aSize(aCUOsCta, 0)

		If !Empty((_cAliasBco)->A6_CONTA)
			aCUOsCta := getCUOs((_cAliasBco)->A6_CONTA)
		EndIf

		if len(aCUOsCta) > 0

			for np := 1 to len(aCUOsCta)

				aDtaOrigen := {}
				aDtaOrigen := ObtInfo(aCUOsCta[np][5],aCUOsCta[np][6])
				cCodUniOpe := Alltrim(aCUOsCta[np][3])
				cContCtb := Iif( empty(aCUOsCta[np][7]),aCUOsCta[np][8],aCUOsCta[np][7] )
				cNumCorre := aCUOsCta[np][1]
				cGlosa := aCUOsCta[np][9]

				If CT1->(MsSeek(xFilial("CT1") + cContCtb))
					cNomCon := Substr(CT1->CT1_DESC01,1,21)
				Endif

				Aadd( aCuentas, {	cCodUniOpe			,;							// 01
									cContCtb			,;							// 02
									cNomCon				,;							// 03
									aCUOsCta[np][2]		,;							// 04
									cNumCorre			,;							// 05 - SEGOFI
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
									aCUOsCta[np][11]	,;							// 21 - LOTE
									aCUOsCta[np][12]	,;							// 22 - SBLOTE
									aDtaOrigen[1][10]	,;							// 23 - PREFIXO/SERIE
									aDtaOrigen[1][11]	,;							// 24 - TPDOC
									aDtaOrigen[1][12]	,;							// 25 - DOC
									aCUOsCta[np][13]	,;							// 26 - CT2-FILIAL
									aDtaOrigen[1][13]	,;							// 27 - NODIA SF1-SF2
									aDtaOrigen[1][14]	;							// 28 - DOMICILIADO/SA2
				}  )


			Next np

		endif

		if len(aCuentas)>0

			for nX := 1 to len(aCuentas)

				if aScan(aRenglon,{|x| x[3] == aCuentas[nX][5] .And. x[16] == aCuentas[nX][1] }) == 0

					c2Benef := alltrim(fSekOrdRec(aCuentas[nX][7],if(aCuentas[nX][6]=="C","P","R")))


					cBenef := aCuentas[nX][9]

					If aCuentas[nX][6]=="D"
						nValDeu	  := aCuentas[nX][15]
						nValAcre  := 0
					Else
						nValDeu	  := 0
						nValAcre  := aCuentas[nX][15]
					Endif

					aAdd(aRenglon,{	cPeriodo,;																// 01
									"M"+aCuentas[nX][1],;													// 02
									aCuentas[nX][5],;														// 03 - SEGOFI
									aCuentas[nX][2],;														// 04
									cCtaBanCon,;															// 05
									aCuentas[nX][18],;														// 06 - fechas
									Alltrim(aCuentas[nX][19]),;												// 07 - tipo de doc - se5
									Alltrim(aCuentas[nX][14]),;												// 08 - glosa
									iif(empty(c2Benef),Alltrim(aCuentas[nX][10]),"-"),;						// 09 - TIPO DOC
									iif(empty(c2Benef),Alltrim(aCuentas[nX][11]),"-"),;						// 10 - RUC
									iif(empty(c2Benef),Alltrim(cBenef),c2Benef),;							// 11
									alltrim(aCuentas[nX][13]),;												// 12 - orden de pago
									Alltrim(Str(nValDeu,12,2)),;											// 13
						   			Alltrim(Str(nValAcre,12,2)),;											// 14
						   			cEdoOpe,;																// 15
						   			aCuentas[nX][1],;														// 16 - CUO
						   			aCuentas[nX][21],;														// 17 - lote
						   			aCuentas[nX][22],;														// 18 - sub lote
						   			aCuentas[nX][20],;														// 19 - moneda
						   			aCuentas[nX][10],;														// 20 - tipodoc
						   			aCuentas[nX][6],;														// 21 - C o D
						   			aCuentas[nX][23],;														// 22 - SERIE O PREFIXO / SF1/SF2
						   			aCuentas[nX][24],;														// 23 - TPDOC / SF1/SF2
						   			aCuentas[nX][25],;														// 24 - DOC / SF1/SF2
						   			iif(empty(aCuentas[nX][11]),aCuentas[nX][12],aCuentas[nX][11]),;		// 25 - RUC O DNI
						   			aCuentas[nX][26] ,;														// 26 - CT2_FILIAL
						   			aCuentas[nX][27] ,;														// 27 - NODIA / SF1/SF2
						   			aCuentas[nX][28] ;														// 28 - DOMICILIADO SA2
					})

				endif

			next nX

		endif

		(_cAliasBco)->( DbSkip() )

	End

	(_cAliasBco)->( DbCLoseArea() )

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
	cArchivo +=  AllTrim(StrZero(Month(MV_PAR02),2))  // Mes
	cArchivo += "00"                                  // Fixo '00'
	cArchivo += "010100"                              // Fixo '010200'
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
		ApMsgStop("Ocurrió un error generar archivo TXT de Libro Caja y Bancos.")
		Return
	endif

	For nPos := 1 To Len(aRenglon)

		if aRenglon[nPos][21]=="D"
			nValor1 := alltrim(transform(val(aRenglon[nPos][13]),"@E 9999999999999.99"))
			nValor2 := alltrim(transform(0,"@E 9999999999999.99"))
		else
			nValor1 := alltrim(transform(0,"@E 9999999999999.99"))
			nValor2 := alltrim(transform(val(aRenglon[nPos][14]),"@E 9999999999999.99"))
		endif

		cCodLibr := ""
		cCodAnid := ""
		if left(AllTrim(aRenglon[nPos][27]),2)=="14"
			cCodLibr := cLbVenta
		elseif left(AllTrim(aRenglon[nPos][27]),2)=="08"
			if !empty(aRenglon[nPos][28])
				if AllTrim(aRenglon[nPos][28])=='1'	// domiciliados
					cCodLibr := cLbSiDom
				else
					cCodLibr := cLbNoDom
				endif
			endif
		endif

		if !empty(cCodLibr)
			cCodAnid := fgenAnidado(	aRenglon[nPos][24]	,;		// documento
										aRenglon[nPos][25]	,;		// fornece/cliente - id
										mv_par01			,;		// fecha inicial
										mv_par02			,;		// fecha final
										cCodLibr			,;		// codigo libro
										aRenglon[nPos][3]	,;		// segofi
										aRenglon[nPos][2]	,;		// cuenta aux
										aRenglon[nPos][26])			// ct2_filial
		else
			cCodAnid := ""
		endif

		cLinea :=	aRenglon[nPos][1] + "|" +;																					// 01 - periodo
					aRenglon[nPos][3] + "|" +;																					// 02 - correlativo CUO
					aRenglon[nPos][2] + "|" +;																					// 03 - linea del asiento
					alltrim(aRenglon[nPos][4]) + "|" +;																			// 04 - conta contable
					alltrim(aRenglon[nPos][3])+"&"+alltrim(aRenglon[nPos][17])+"&"+alltrim(aRenglon[nPos][18]) + "|" +;			// 05 - correlativo+lote+sublote
					"|" +;																							  			// 06 - centro de costo
					if(alltrim(aRenglon[nPos][19])$"01|M1|$","PEN","USD") + "|" +;												// 07 - moneda
					if(empty(aRenglon[nPos][23]),"00",aRenglon[nPos][23]) + "|" +;												// 08 - tipo de documento
					if(empty(aRenglon[nPos][22]),"0000",aRenglon[nPos][22]) + "|" +;											// 09 - serie de doc
					aRenglon[nPos][12] + "|" +;																					// 10 - numero de doc
					dtoc(stod(aRenglon[nPos][6])) + "|" +;																		// 11 - fecha contable
					dtoc(stod(aRenglon[nPos][6])) + "|" +;																		// 12 - fecha vencimento
					dtoc(stod(aRenglon[nPos][6])) + "|" +;																		// 13 - fecha emision
					aRenglon[nPos][8] + "|" +;																					// 14 - glosa
					"|" +;																										// 15 - glosa referencial
					nValor1 + "|" +;																							// 16 - valor credito
					nValor2 + "|" +;																							// 17 - valor debito
					cCodAnid + "|" +;																							// 18 - codigo anidado
					"1|" + cCRLF																								// 19 - estado de la operacion
		fWrite(nHdl,cLinea)
	Next nPos

	fClose(nHdl)
	MsgAlert( OemToAnsi(STR0040) + cDir + cArchivo, OemToAnsi(STR0039) ) // "Archivo plano, de Libro en Efectivo, generado con éxito en " ## "Atención"

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ZFINR121  ºAutor  ³Microsiga           ºFecha ³  11/04/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fSekOrdRec( cIdDoc, cRecPag )

	local dArea		:= getArea()
	local cQry		:= ""
	local _cAlias	:= getNextAlias()
	local nX		:= 0

	if cRecPag=="R"

		cQry := "SELECT EL_RECIBO,EL_CLIENTE, COUNT(*) NCONT FROM "+RetSqlName("SEL")
		cQry += " WHERE EL_FILIAL='"+xFilial("SEL")+"'"
		cQry += "   AND EL_RECIBO='"+cIdDoc+"'"
		cQry += "   AND EL_TIPO='NF'"
		cQry += "   AND D_E_L_E_T_=''"
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
		cQry += " WHERE EK_FILIAL='"+xFilial("SEK")+"'"
		cQry += "   AND EK_ORDPAGO='"+cIdDoc+"'"
		cQry += "   AND EK_TIPO='NF'"
		cQry += "   AND D_E_L_E_T_=''"
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

/*/{Protheus.doc} FR121Tot
Imprime la secciones Totales y Saldo Final por caja.

@type Static Function
@author Marco Augusto González Rivera
@since 10/08/2021
@version 2.0
@param olReport, Objeto, Objeto del Reporte.
@param aSaldAnt, Array, Arreglo con saldos de la cuenta.
@param nTotDeb, Numérico, Valor Total de Débito.
@param nTotCre, Numérico, Valor Total de Crédito.
@param nSldIni, Numérico, Valor del Saldo Inicial.
@example FR121Tot(olReport, aSaldAnt, nTotDeb, nTotCre, nSldIni)
/*/
Static Function FR121Tot(olReport, aSaldAnt, nTotDeb, nTotCre, nSldIni, aVert)
	
	//Imprime Saldo Final
	FR121ImpPl(olReport, 2)
	olReport:PrintText( STR0036 + DtoC(MV_PAR02), olReport:Row(), 690 ) //"Saldo final en "
	FR121ImpPl(olReport, 3)
	olReport:PrintText( Transform(((nSldIni+nTotCre) - nTotDeb), "@E 9999,999,999,999.99"), olReport:Row(), 2050 )
	olReport:Box(olReport:Row()+2,olReport:Col()-004, olReport:Row()+2, 2380 )
	FR161Prnt( olReport,aVert)
	olReport:SkipLine( 1 )

	//Imprime Totales
	olReport:Line( olReport:Row(), nMarIz , olReport:Row(), 2380 )
	olReport:Box( olReport:Row(), 1360  , olReport:Row() + 034, 1700  )
	FR121ImpPl(olReport, 4)
	olReport:PrintText( STR0019, olReport:Row(), 1370 ) //"Totales"
	olReport:Box( olReport:Row(), 1700 , olReport:Row() + 034, 2040  )
	olReport:PrintText( Transform( nTotDeb, "@E 99,999,999,999.99"), olReport:Row(), 1739 )
	olReport:Box( olReport:Row(), 2040 , olReport:Row() + 034, 2380 )
	olReport:PrintText( Transform( nTotCre, "@E 99,999,999,999.99"), olReport:Row(), 2079 )
	olReport:SkipLine( 2 )

	nTotDeb := 0
	nTotCre := 0
	nSldIni := 0
Return

/*/{Protheus.doc} FR121ImpPl
Función utilizada para impresión de líneas vacias en el formato
planilla.
@type Static Function
@author Oscar García López
@since 29/09/2021
@version 1.0
@example FR121ImpPl(olReport, nNumLinImp)
@param olReport, Objeto Objeto TReport.
@param nNumLinImp, Numerico, Numero de espacios a imprimir.
/*/
Static Function FR121ImpPl(olReport, nNumLinImp)
	Local nOpcImp := olReport:nDevice //1-Archivo,2-Impresora,3-Email,4-Planilla, 5-Html y 6-PDF
	Local nIteracion := 0
	If nOpcImp == 4
		For nIteracion := 1 To nNumLinImp
			olReport:PrintText("", olReport:Row(), olReport:Col())
		Next nIteracion
	EndIf
Return
