/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "SIGAWIN.CH"        // incluido pelo assistente de conversao do AP5 IDE em 09/09/99
#include "FINR998.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR998   º Autor ³                    º Data ³             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Programa para imprimir as listagem das ordens de pago      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr998()

	Local oReport	:= Nil
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport	:= ReportDef()
	oReport:PrintDialog()

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

Local oReport	:= Nil
Local oSection1	:= Nil
Local oSection2	:= Nil
Local cReport	:= "FINR998"
Local cTitulo	:= OemToAnsi(STR0009)	// "Informe de Pagos"
Local cDescri	:= OemToAnsi(STR0001)  + OemToAnsi(STR0002) //"Imprime informe de las ordenes de pago" - "emitidas, sinteticamente."

oReport  := TReport():New( cReport, cTitulo, "FIR998" , { |oReport| ReportPrint( oReport, "SEK" ) }, cDescri )

oSection1 := TRSection():New( oReport,OemToAnsi(STR0043), {"SA2"}, ) //"Proveedor"

TRCell():New( oSection1, "A2_COD" 	,"SA2",/*X3Titulo*/	,/*Picture*/,TamSX3("A2_COD")[1]+TamSx3("A2_LOJA")[1]+2,/*lPixel*/,)
TRCell():New( oSection1, "A2_NOME"	,"SA2",/*X3Titulo*/	,/*Picture*/,20/*Tamanho*/,/*lPixel*/,)
oSection1:SetNofilter({"SA2"})

oSection2 := TRSection():New( oSection1,OemToAnsi(STR0044) , {"SEK"}) //"Orden de Pago"
TRCell():New( oSection2,"EK_ORDPAGO","SEK",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection2,"A2_COD"	,"SA2",/*X3Titulo*/	,/*Picture*/,TamSX3("A2_COD")[1]+TamSx3("A2_LOJA")[1]+2/*Tamanho*/,/*lPixel*/,/*bBlock*/,"Right",)
TRCell():New( oSection2,"A2_NOME"	,"SA2",/*X3Titulo*/	,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*bBlock*/,"Right",)
TRCell():New( oSection2,"EK_EMISSAO","SEK", /*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*bBlock*/,"Right",)
TRCell():New( oSection2, "VLTOTTIT"	,"",OemToAnsi(STR0033)+ CHR(13)+CHR(10) + OemToAnsi(STR0034)/*X3Titulo*/	,PesqPict("SE2","E2_VALOR")/*Picture*/,14/*Tamanho*/,/*lPixel*/,/*bBlock*/,"Right",) //"Valor Total" - " Titulos"
TRCell():New( oSection2, "VLTOTCHP"	,"",OemToAnsi(STR0035)+ CHR(13)+CHR(10) +OemToAnsi(STR0036)/*X3Titulo*/	,PesqPict("SE2","E2_VALOR")/*Picture*/,14/*Tamanho*/,/*lPixel*/,/*bBlock*/,"Right",) //"Tot. Pagos" - "   Propios"
TRCell():New( oSection2, "VLTOTCHT","",OemToAnsi(STR0037)+ CHR(13)+CHR(10) +OemToAnsi(STR0038)/*X3Titulo*/		,PesqPict("SE2","E2_VALOR")/*Picture*/,14/*Tamanho*/,/*lPixel*/,/*bBlock*/,"Right",) //"Tot. Pagos" - "  Terceros"
TRCell():New( oSection2, "VLTOTDES"	,"",OemToAnsi(STR0039)+  CHR(13)+CHR(10)+OemToAnsi(STR0040)/*X3Titulo*/	,PesqPict("SE2","E2_VALOR")/*Picture*/,14/*Tamanho*/,/*lPixel*/,/*bBlock*/,"Right",) //"Descuentos de" - "Pag At y FC"
If cPaisLoc == "PTG"
	TRCell():New( oSection2, "VLTOTDESP"	,"",OemToAnsi(STR0045)/*X3Titulo*/	,PesqPict("SE2","E2_VALOR")/*Picture*/,14/*Tamanho*/,/*lPixel*/,)//"Despesas"
Endif
TRCell():New( oSection2, "VLTOTRET"	,"",OemToAnsi(STR0041)/*X3Titulo*/	,PesqPict("SE2","E2_VALOR")/*Picture*/,14/*Tamanho*/,/*lPixel*/,) //"Retenc."
TRCell():New( oSection2, "NUMPROV" 	,"",OemToAnsi(STR0042) /*X3Titulo*/	,/*Picture*/,14/*Tamanho*/,/*lPixel*/,) //"Nº Proveedor"
oSection2:SetNofilter({"SEK"})

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

Local nI			:= 1
Local oSection1		:= oReport:Section(1)
Local oSection2		:= oSection1:Section(1)
Local cLibOrd		:= Alltrim(GetMv("MV_LIBORD"))
Local cLiberada		:= " "
Local nTotProv1		:= 0
Local nTotProv2		:= 0
Local nTotProv3		:= 0
Local nTotProv4		:= 0
Local nTotProv5		:= 0
Local nTotProv6		:= 0

Local nTotNetoGral	:= 0.00
Local nRetGral		:= 0.00
Local nPrGral		:= 0.00
Local nTerGral		:= 0.00
Local nTotComp		:= 0.00
Local nTotBajado	:= 0.00
Local nOrdenes		:= 0
Local cFornece		:= ""
Local nOrdProv		:= 0
Local nDecs			:= 2
Local lConvert		:= .T.
Local nDespGral		:= 0
Local nValDesp		:= 0

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf

oReport:SetTitle(OemToAnsi(STR0009) + " - En "  + GetMv("MV_MOEDA"+LTrim(Str(MV_PAR06)))) //"Informe de Pagos"

nDecs	:= MsDecimais(mv_par06)

lConvert := ( mv_par07 = 1 )

aStru := SEK->(dbStruct())
If MV_PAR01 == 1
	cQuery := "SELECT * "
	cQuery += "FROM "+ RetSQLName("SEK") +" SEK "
	cQuery += "Where SEK.EK_FILIAL = '"+xFilial("SEK")+"' AND "
	cQuery += "SEK.EK_ORDPAGO >= '"+MV_PAR02+"' AND "
	cQuery += "SEK.EK_ORDPAGO <= '"+MV_PAR03+"' AND "
	If !lConvert
		cQuery += "SEK.EK_MOEDA = '"+Alltrim(Str(MV_PAR06))+"' AND "
	Endif
	cQuery += "(SEK.EK_CANCEL = 'F' OR SEK.EK_CANCEL = ' ') AND "
	cQuery += "SEK.EK_DTDIGIT >= '"+Dtos(MV_PAR04)+"' AND "
	cQuery += "SEK.EK_DTDIGIT <= '"+Dtos(MV_PAR05)+"' AND "
	cQuery += "SEK.D_E_L_E_T_ = ' '"
	cQuery += "ORDER BY SEK.EK_ORDPAGO"
	cOrdem	:=	"EK_ORDPAGO"
Else
	cQuery := "SELECT * "
	cQuery += "FROM "+ RetSQLName("SEK") +" SEK "
	cQuery += "Where SEK.EK_FILIAL = '"+xFilial("SEK")+"' AND "
	cQuery += "SEK.EK_FORNECE >= '"+MV_PAR02+"' AND "
	cQuery += "SEK.EK_FORNECE <= '"+MV_PAR03+"' AND "
	If !lConvert
		cQuery += "SEK.EK_MOEDA = '"+Alltrim(Str(MV_PAR06))+"' AND "
	Endif
	cQuery += "(SEK.EK_CANCEL = 'F' OR SEK.EK_CANCEL = ' ') AND "
	cQuery += "SEK.EK_DTDIGIT >= '"+Dtos(MV_PAR04)+"' AND "
	cQuery += "SEK.EK_DTDIGIT <= '"+Dtos(MV_PAR05)+"' AND "
	cQuery += "SEK.D_E_L_E_T_ = ' '"
	If MV_PAR01 == 2
		cQuery += "ORDER BY SEK.EK_FORNECE, SEK.EK_LOJA"
		cOrdem := "EK_FORNECE+EK_LOJA"
	Else
		cQuery += "ORDER BY SEK.EK_FORNECE, SEK.EK_LOJA, SEK.EK_ORDPAGO"
		cOrdem := "EK_FORNECE+EK_LOJA+EK_ORDPAGO"
	EndIf
EndIf

cQuery := ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TCGenQry(,,cQuery), 'SEKTMP', .F., .T.)

For nI := 1 To Len(aStru)
	If aStru[nI,2] <> "C"
		TCSetField("SEKTMP", aStru[nI,1], aStru[nI,2],aStru[nI,3], aStru[nI,4])
	EndIf
Next nI

cAlias := "SEKTMP->"

If mv_par01==2
	oSection1:SetHeaderPage(.T.)
	oSection2:Cell("A2_COD"):Disable()
	oSection2:Cell("A2_NOME"):Disable()
	oSection2:Cell("EK_EMISSAO"):Disable()
	oSection2:Cell("EK_ORDPAGO"):Disable()
Else
	oSection1:SetHeaderSection(.F.)
EndIf
oSection2:SetHeaderPage(.T.)

oReport:SetMeter(RecCount())

While !Eof()

	oReport:IncMeter()
	cOrdPag	:=	&cAlias.EK_ORDPAGO
	dAntDtDigit	:=	&cAlias.EK_DTDIGIT
	cOrdFor := ""
	If cPaisLoc <> "BRA"
		cOrdFor :=&cAlias.EK_DOCREC
	EndIf
	SA2->(DbSetOrder(1)) //A2_FILIAL+A2_COD+A2_LOJA
	SA2->(DbSeek(xFilial("SA2")+&cAlias.EK_FORNECE+&cAlias.EK_LOJA))
	cFornece	:= &cAlias.EK_FORNECE+"-"+&cAlias.EK_LOJA
	cNomeFor	:=	SA2->A2_NOME
	nValBaj	:=	0.00
	nValRet	:=	0.00
	nValTer	:=	0.00
	nValPr	:=	0.00
	nValPaNc	:=	0.00
	nValDesp	:=	0.00
	
	While ((cOrdPag==&cAlias.EK_ORDPAGO .And. mv_par01==1) .or. (cFornece==&cAlias.EK_FORNECE+"-"+&cAlias.EK_LOJA .And. mv_par01==2)) .and. !Eof() .And. xFilial("SEK")==EK_FILIAL

		If MV_PAR08 == 1
			/*
			Favor manter este FieldPos.
			Caso EK_MOEDA for 1 (moeda corrente), não existe campo EK_TXMOE01
			Desta forma garantimos que não seja abortado o processamento em caso de inexistência de campo de taxa de moeda
			inclusive para novas moedas criadas no sistema.
			*/
			nTaxaOri:=Iif(SEK->(FieldPos("EK_TXMOE"+StrZero(Val(&cAlias.EK_MOEDA),2))) > 0,&("EK_TXMOE"+StrZero(Val(&cAlias.EK_MOEDA),2)),0)
        	nTaxaDes:=Iif(SEK->(FieldPos("EK_TXMOE"+StrZero(mv_par06,2)))    > 0,&("EK_TXMOE"+StrZero(mv_par06,2)),0)
        Else
			nTaxaOri:= 0
			nTaxaDes:= 0
        EndIf

		If ( Substr(&cAlias.EK_TIPODOC,1,2) == "RG")
			nValRet	:=	nValRet	+	Round(IIf(mv_par06==1,EK_VLMOED1,xMoeda(EK_VALOR,Max(VAL(EK_MOEDA),1),mv_par06,EK_DTDIGIT,nDecs+1,nTaxaOri,nTaxaDes)),nDecs)
		Elseif	(Substr(&cAlias.EK_TIPODOC,1,2) == "TB")
			If	(Subs(EK_TIPO,1,2)$"PA|NC")
				nValPaNc	 	:=	nValPaNc		+ Round(IIf(mv_par06==1,EK_VLMOED1,xMoeda(EK_VALOR,Max(VAL(EK_MOEDA),1),mv_par06,EK_DTDIGIT,nDecs+1,nTaxaOri,nTaxaDes)),nDecs)
			Else
				nValBaj	:=	nValBaj	+ Round(IIf(mv_par06==1,EK_VLMOED1,xMoeda(EK_VALOR,Max(VAL(EK_MOEDA),1),mv_par06,EK_DTDIGIT,nDecs+1,nTaxaOri,nTaxaDes)),nDecs)
			Endif
		Elseif	(Substr(&cAlias.EK_TIPODOC,1,2) == "CT")
			nValTer 	:= nValTer	+	Round(IIf(mv_par06==1,EK_VLMOED1,xMoeda(EK_VALOR,Max(VAL(EK_MOEDA),1),mv_par06,EK_DTDIGIT,nDecs+1,nTaxaOri,nTaxaDes)),nDecs)
		Elseif	(Substr(&cAlias.EK_TIPODOC,1,2) == "CP")
			nValPr 	:= nValPr	+	Round(IIf(mv_par06==1,EK_VLMOED1,xMoeda(EK_VALOR,Max(VAL(EK_MOEDA),1),mv_par06,EK_DTDIGIT,nDecs+1,nTaxaOri,nTaxaDes)),nDecs)
		ElseIf (Substr(&cAlias.EK_TIPODOC,1,2) == "DE" )
			nValDesp	:= nValDesp	+	Round(IIf(mv_par06==1,EK_VLMOED1,xMoeda(EK_VALOR,Max(VAL(EK_MOEDA),1),mv_par06,EK_DTDIGIT,nDecs+1,nTaxaOri,nTaxaDes)),nDecs)
		EndIf
		If Empty(&cAlias.EK_DTREC)  .and. cLibOrd=="S"
		   cLiberada:= "N"
		Endif

		dbskip()
	Enddo

	If mv_par01 == 1
		oSection2:Cell("EK_ORDPAGO"):SetBlock({||cOrdPag})
		oSection2:Cell("A2_COD"):SetBlock({||cFornece})
		oSection2:Cell("A2_NOME"):SetBlock({||Subs(cNomeFor,1,30)})
		oSection2:Cell("EK_EMISSAO"):SetBlock({||dAntDtDigit})
	Elseif mv_par01==2
		oSection1:Init()
		oSection1:Cell("A2_COD"):SetBlock({||cFornece })
		oSection1:Cell("A2_NOME"):SetBlock({||cNomeFor})
		oSection1:PrintLine()
		oSection1 :Finish()
		oSection2:Cell("A2_COD"):Hide()
		oSection2:Cell("A2_NOME"):Hide()
		oSection2:Cell("EK_EMISSAO"):Hide()
		oSection2:Cell("EK_ORDPAGO"):Hide()
    EndIf

	oSection2:Init()
	oSection2:Cell("VLTOTTIT"):SetBlock({||nValBaj })
	oSection2:Cell("VLTOTCHP"):SetBlock({||nValPr })
	oSection2:Cell("VLTOTCHT"):SetBlock({||nValTer})
	oSection2:Cell("VLTOTDES"):SetBlock({||nValPaNc})
	oSection2:Cell("VLTOTRET"):SetBlock({||nValRet})
	oSection2:Cell("NUMPROV"):SetBlock({||cOrdFor})
  If cPaisLoc == "PTG"
		oSection2:Cell("VLTOTDESP"):SetBlock({||nValDesp})
  Endif
	oSection2:Printline()
	nOrdProv := nOrdProv + 1
	nTotProv1:=	nTotProv1+nValBaj
	nTotProv2:=	nTotProv2+nValPr
	nTotProv3:=	nTotProv3+nValTer
	nTotProv4:=	nTotProv4+nValPaNc
	nTotProv5:=	nTotProv5+nValRet
  If cPaisLoc == "PTG"
		nTotProv6:=	nTotProv6+nValDesp
  Endif

	If cLiberada== "N"
		oReport:PrintText( OemToAnsi(STR0032)) //"No Aprobada"
		cLiberada:= " "
	Endif
	oReport:SkipLine()
	If mv_par01==3.and.&cAlias.EK_FORNECE+"-"+&cAlias.EK_LOJA#cFornece
		oReport:PrintText(OemToAnsi(STR0015) + TransForm(nOrdProv,"@R 999,999") ) //"Ordenes Proveedor  -> "
		oReport:PrintText(STR0016)  // "Totales Proveedor ------>"
		oSection2:Cell("NUMPROV"):Disable()
		oSection2:Cell("A2_COD"):Disable()
		oSection2:Cell("A2_NOME"):Disable()
		oSection2:Cell("EK_EMISSAO"):Disable()
		oSection2:Cell("EK_ORDPAGO"):Disable()
    	oSection2:Cell("VLTOTTIT"):SetBlock({||nTotProv1 })
		oSection2:Cell("VLTOTCHP"):SetBlock({||nTotProv2 })
		oSection2:Cell("VLTOTCHT"):SetBlock({||nTotProv3})
		oSection2:Cell("VLTOTDES"):SetBlock({||nTotProv4})
		oSection2:Cell("VLTOTRET"):SetBlock({||nTotProv3})
	  If cPaisLoc == "PTG"
			oSection2:Cell("VLTOTDESP"):SetBlock({||nTotProv6})
    Endif
		oSection2:PrintLine()
		nOrdProv  := 0
		nTotProv1 := 0
		nTotProv2 := 0
		nTotProv3 := 0
		nTotProv4 := 0
		nTotProv5 := 0
		nTotProv6 := 0
	Endif
	nRetGral 	:= nRetGral 	+ 	nValRet
	nTotBajado:= nTotBajado	+	nValBaj
	nTotComp	:= nTotComp	+	nValPaNc
	nPrGral		:= nPrGral  + nValPr
	nTerGral	:= nTerGral + nValTer
	nDespGral	:= nDespGral + nValDesp
	nOrdenes    := nOrdenes + 1
	oSection2 :Finish()
Enddo

nTotNetoGral	:=	nTotBajado - nRetGral - nTotComp + nDespGral
If (mv_par01<>2)
	OReport:PrintText(OemToAnsi(STR0017) + TransForm(nOrdenes,"@R 999,999"))  //"Ordenes emitidas  -> "
Endif
OReport:PrintText(OemToAnsi(STR0018) + TransForm(nTotBajado,tm(nTotBajado,19,nDecs)))  //"TOTAL BRUTO       ----> "
If cPaisLoc == "PTG"
	OReport:PrintText(OemToAnsi(STR0046 )+ TransForm(nDespGral,tm(nDespGral,19,nDecs)))  //"TOTAL DESPESAS    ----> "
Endif
OReport:PrintText(OemToAnsi(STR0019) + TransForm(nPrGral,tm(nPrGral,19,nDecs)))  //"TOTAL CHEQUES EMIT.---> "
OReport:PrintText(OemToAnsi(STR0020) + TransForm(nTerGral,tm(nTerGral,19,nDecs)))  //"TOTAL CHEQUES TERC.---> "
OReport:PrintText(OemToAnsi(STR0021) + " " +  TransForm(nRetGral,tm(nRetGral,19,nDecs)))  //"TOTAL RETENCIONES ----> "
OReport:PrintText(OemToAnsi(STR0022) + TransForm(nTotComp,tm(nTotComp,19,nDecs)))  //"TOTAL COMPENSADO  ----> "
OReport:PrintText(OemToAnsi(STR0023) + "  " +TransForm(nTotNetoGral,tm(nTotNetoGral,19,nDecs)))  //"TOTAL PAGADO      ----> "

DbSelectArea("SEKTMP")
dbCloseArea()

Return ()
