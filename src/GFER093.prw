/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER093
Relatório de Conciliação Contábil
Generico.

@sample    
U_GFER093()  
           
@author Israel A. Possoli
@since 17/12/12
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER093()
	Local oReport
	// Local aArea := GetArea()
	Private cDados
	Private cFilialIni
	Private cFilialFim
	Private dDataIni
	Private dDataFim
	Private lDetalhado	// Relatório detalhado
	Private lLanctos	// Detalhe dos lançamentos contábeis
	Private cFiltro		// 1=Todos; 2=Com Diferença; 3=Sem Valor Contábil
	Private cPreFatIni
	Private cPreFatFim	
	Private cFaturaIni
	Private cFaturaFim
	Private lDocPendentes := .F.
	Private lListaDC := .F.
	Private cDtUso

	Pergunte("GFER093",.F.)

	If TRepInUse() // teste padrão
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

Return

/**/
Static Function ReportDef()
	Local oReport
	Local oSection1, oSection2
	Local aOrdem    := {}
	Local cSubTitulo := "Provisão e Realização"
	
	// Define Sub Título do relatório
	If cDados == 1
		cSubTitulo := "Provisão"
	ElseIf cDados == 2
		cSubTitulo := "Realização"
	EndIf

	aAdd(aOrdem, "Teste Ordem")

	oReport:= TReport():New("GFER093", "Conciliação Contábil - " + cSubTitulo,"GFER093", {|oReport| ReportPrint(oReport)}, "Conciliação Contábil B")
	oReport:HideParamPage()

	oSection1 := TRSection():New(oReport,"Pré-Fatura",{"(cTabGWJ)"}, aOrdem)
	oSection1:SetHeaderSection(.T.)
	oSection1:lHeaderVisible := .F.
	
	TRCell():New(oSection1, "(cTabGWJ)->FILIAL"  , "(cTabGWJ)", "Filial"        , /* Picture */      , 16, .T., /*{|| code-block de impressao }*/)
	TRCell():New(oSection1, "(cTabGWJ)->NRPF"    , "(cTabGWJ)", "Pré-Fatura"    , /* Picture */      , 16, .T., /*{|| code-block de impressao }*/)
	TRCell():New(oSection1, "(cTabGWJ)->VALORCTB", "(cTabGWJ)", "Valor Contábil", "@E 999,999,999.99", 14, .T., /*{|| code-block de impressao }*/)
	TRCell():New(oSection1, "(cTabGWJ)->DTATUALAP", "(cTabGWJ)", "Dt Atual AP", /* Picture */  , 14, .T., /*{|| code-block de impressao }*/)
	
	oSection2 := TRSection():New(oReport,"Fatura",{"(cTabGW6)"}, aOrdem)
	oSection2:SetHeaderSection(.T.)
	oSection2:lHeaderVisible := .F.

	TRCell():New(oSection2, "(cTabGW6)->FILIAL"  , "(cTabGW6)", "Filial"        , /* Picture */      , Len(cFilAnt), .T., /*{|| code-block de impressao }*/)
	TRCell():New(oSection2, "(cTabGW6)->EMIFAT"  , "(cTabGW6)", "Transp."       , /* Picture */      , TamSX3("GW6_EMIFAT")[1], .T., /*{|| code-block de impressao }*/)
	TRCell():New(oSection2, "(cTabGW6)->NRFAT"   , "(cTabGW6)", "Fatura"        , /* Picture */      , TamSX3("GW6_NRFAT")[1], .T., /*{|| code-block de impressao }*/)
	TRCell():New(oSection2, "(cTabGW6)->VALORCTB", "(cTabGW6)", "Valor Contábil", "@E 999,999,999.99", 14, .T., /*{|| code-block de impressao }*/)
	TRCell():New(oSection2, "(cTabGW6)->DTATUAP", "(cTabGW6)", "Dt Atual AP", /* Picture */			, 14, .T., /*{|| code-block de impressao }*/)

Return(oReport)
 

Static Function ReportPrint(oReport)
	Local oSection1  := oReport:Section(1)
	Local oSection2  := oReport:Section(2)
	Local lHeaderUn	 := .T.
	Local lMovimentosOk := .T.
	//Local aAreaAnt := GetArea()
	Private cTabGWJ		// Provisão - Pré-Fatura
	Private cTabGWF		// Provisão - Cálculo de Frete
	Private cTabGWK		// Provisão - Movimentos contábeis da pré-fatura
	Private cTabGW6		// Realização - Fatura
	Private cTabGW7		// Realização - Movimentos Contábeis da Fatura
	Private cTabGW3		// Realização - Documentos de Frete
	Private cTabGWA		// Provisão e Realização - Movimentos Contábeis: Cálculo e Documento de Frete
	Private cTabGW1	
	Private cTabGW1F 
	
	cDados     := MV_PAR01
	cFilialIni := MV_PAR02
	cFilialFim := MV_PAR03
	cDtUso     := MV_PAR04
	dDataIni   := MV_PAR05
	dDataFim   := MV_PAR06
	lDetalhado := If(MV_PAR07 == 2, .T., .F.)
	lLanctos   := If(MV_PAR08 == 1, .T., .F.)
	cFiltro    := MV_PAR09
	lListaDC   := If(MV_PAR10 == 1, .T., .F.)
	cPreFatIni := MV_PAR11
	cPreFatFim := MV_PAR12
	cFaturaIni := MV_PAR13
	cFaturaFim := MV_PAR14
	lDocPendentes := If(MV_PAR15 == 1, .T., .F.)
	lHeaderUn	 := If(!lDetalhado .AND. !lLanctos, .T., .F.)
	
	oReport:SetMeter(0)

	/* ----------------------------------------------------------------
	   Criação das tabelas temporárias
	   ---------------------------------------------------------------- */
	// --- Provisão ------------------
	If cDados == 1 .OR. cDados == 3
		cTabGWJ := DefTabGWJ()
		If lDetalhado
			cTabGWF := DefTabGWF()
		EndIf

		If lLanctos
			cTabGWK := DefTabGWK()
		EndIf
		
		If lListaDC
			cTabGW1 := DefTabGW1(.F.)
		EndIf
		
	EndIf

	// --- Realização ----------------
	If cDados == 2 .OR. cDados == 3
		cTabGW6 := DefTabGW6()
		If lDetalhado
			cTabGW3 := DefTabGW3()
		EndIf
 
		If lLanctos
			cTabGW7 := DefTabGW7()
		EndIf
		
		If lListaDC
			cTabGW1F := DefTabGW1(.T.)
		EndIf
	EndIf

	// --- Provisão e Realização -----
	If lLanctos
		cTabGWA := DefTabGWA()
	EndIf


	/* ----------------------------------------------------------------
	   Provisão
	   ---------------------------------------------------------------- */
	If cDados == 3
		oReport:PrintText("P R O V I S Ã O")
		oReport:FatLine()
		oReport:SkipLine()
	EndIf

	If cDados == 1 .OR. cDados == 3
		CarregaProvisao(oReport)

		If lHeaderUn
			oSection1:Init()
		EndIf

		dbSelectArea((cTabGWJ))
		dbGoTop()
		While !oReport:Cancel() .AND. !(cTabGWJ)->( Eof() )
			// Filtro: Com diferença
			// Desconsidera: Valores iguais ou Valor contábil zerado
			If cFiltro == 2
				If Empty((cTabGWJ)->VALORCTB)
					(cTabGWJ)->( dbSkip() )
					Loop
				EndIf

				If (cTabGWJ)->VALORPRE == (cTabGWJ)->VALORCTB
					(cTabGWJ)->( dbSkip() )
					Loop
				EndIf
			EndIf

			// Filtro: Valor Contábil zerado
			If cFiltro == 3
				If !Empty((cTabGWJ)->VALORCTB)
					(cTabGWJ)->( dbSkip() )
					Loop
				EndIf
			EndIf
			
			If cFiltro == 4
				If (cTabGWJ)->VALORPRE == (cTabGWJ)->VALORCTB
					(cTabGWJ)->( dbSkip() )
					Loop
				EndIf			
			EndIf

			If !lHeaderUn
				oSection1:Init()
			EndIf
			oSection1:PrintLine()

		// Mostra lançamentos
			If lLanctos
				dbSelectArea((cTabGWK))
				dbSetOrder(1)
				If dbSeek((cTabGWJ)->FILIAL + (cTabGWJ)->NRPF)
					oReport:SkipLine()
					oReport:PrintText(Space(4) + "Conta Contábil       Centro de Custo      Valor ")
					oReport:PrintText(Space(4) + "-------------------- -------------------- ------------------")

					While !(cTabGWK)->( Eof() ) 				  .AND. ;
						   (cTabGWK)->FILIAL == (cTabGWJ)->FILIAL .AND. ;
						   (cTabGWK)->NRPF   == (cTabGWJ)->NRPF
						oReport:PrintText(Space(4) + ;
										  PrintField((cTabGWK)->CTACTB, 21) + ;
										  PrintField((cTabGWK)->CCUSTO, 21) + ;
										  PrintField(Transform((cTabGWK)->VLMOV, "@E 999,999,999,999.99"), 18))
						(cTabGWK)->( dbSkip() )
					EndDo
				Else
					oReport:PrintText(Space(4) + "** Nenhum movimento contábil encontrado.")
				EndIf
			EndIf

			If lDetalhado
				dbSelectArea((cTabGWF))
				dbSetOrder(1)
				If dbSeek((cTabGWJ)->FILIAL + (cTabGWJ)->NRPF)
					oReport:SkipLine()
					oReport:PrintText(Space(4) + "Filial    Cálculo    Valor              Valor Contábil")
					If !lLanctos
						oReport:PrintText(Space(4) + "--------- ---------- ------------------ ------------------ ")
					EndIf
					
					lMovimentosOk := .T.

					While !(cTabGWF)->( Eof() ) 				 .AND. ;
						   (cTabGWF)->FILPF == (cTabGWJ)->FILIAL .AND. ;
						   (cTabGWF)->NRPF  == (cTabGWJ)->NRPF
						   
						If cFiltro == 4
							If (cTabGWF)->VALORCALC == (cTabGWF)->VALORCTB
								(cTabGWF)->( dbSkip() )
								Loop
							Endif
						EndIf
						
						lMovimentosOk := .F.

						If lLanctos
							oReport:PrintText(Space(4) + "--------- ---------- ------------------ ------------------ ")
						EndIf

						oReport:PrintText(Space(4) + ;
										  PrintField((cTabGWF)->FILIAL, 10) + ;
										  PrintField((cTabGWF)->NRCALC, 11) + ;
										  PrintField(Transform((cTabGWF)->VALORCALC, "@E 999,999,999,999.99"), 19) + ;
										  PrintField(Transform((cTabGWF)->VALORCTB, "@E 999,999,999,999.99"), 18))

						If lLanctos
							// Movimentos Contábeis do Cálculo
							dbSelectArea((cTabGWA))
							dbSetOrder(1)
							If dbSeek((cTabGWF)->FILIAL + "1" + (cTabGWF)->NRCALC)
								While !(cTabGWA)->( Eof() ) 				   .AND. ;
									   (cTabGWA)->FILIAL  == (cTabGWF)->FILIAL .AND. ;
									   (cTabGWA)->TPDOC   == "1" 			   .AND. ;
									   (cTabGWA)->NRCALC  == (cTabGWF)->NRCALC
									oReport:PrintText(Space(4) + ;
													  "Conta Contábil: " + PrintField((cTabGWA)->CTADEB, 22) + ;
													  "C. Custo: " + PrintField((cTabGWA)->CCDEB, 22) + ;
										  			  "Valor: " + AllTrim(Transform((cTabGWA)->VLMOV, "@E 999,999,999,999.99")))
									(cTabGWA)->( dbSkip() )
								EndDo
							Else
								oReport:PrintText(Space(8) + "** Nenhum movimento contábil encontrado para o cálculo.")
							EndIf

						EndIf

						(cTabGWF)->( dbSkip() )

					EndDo
					
					If lMovimentosOk
						oReport:PrintText(Space(4) + "MOVIMENTOS CONTÁBEIS OK.")
					EndIf
				EndIf
				
				//Mostra os outros documentos de carga relacionados a pré-fatura
				If lListaDc	
				
					oReport:PrintText(Space(4) + "Filial     ",oReport:Row(),)
					oReport:PrintText(" Dt Emissão",oReport:Row(),)
					oReport:PrintText(" Série",oReport:Row(),)
					oReport:PrintText(" Número          ",oReport:Row(),)
					oReport:PrintText(" Emissor         ",oReport:Row(),)
					oReport:PrintText(" Valor Frete   ",oReport:Row(),)
					oReport:PrintText(" Transp ",oReport:Row(),)
					oReport:SkipLine()
					oReport:PrintText(Space(4) + "-----------",oReport:Row(),)
					oReport:PrintText(" ----------",oReport:Row(),)
					oReport:PrintText(" -----",oReport:Row(),)
					oReport:PrintText(" ----------------",oReport:Row(),)
					oReport:PrintText(" ----------------",oReport:Row(),)
					oReport:PrintText(" --------------",oReport:Row(),)
					oReport:PrintText(" -------------------------",oReport:Row(),)
					oReport:SkipLine()
				
					dbSelectArea((cTabGW1))
					(cTabGW1)->( dbSetOrder(2) )
					If (cTabGW1)->( dbSeek((cTabGWJ)->FILIAL+(cTabGWJ)->NRPF) )
						While !(cTabGW1)->( Eof() ) .And. ((cTabGW1)->NRPF == (cTabGWJ)->NRPF)
							oReport:PrintText(Space(4) + PadR(PrintField((cTabGW1)->FILDC, Len(cFilAnt)), 12),oReport:Row(),)
							oReport:PrintText(PadR((cTabGW1)->DTEMIS, 11),oReport:Row(),)
							oReport:PrintText(PadR(PrintField((cTabGW1)->SERDC, 5), 6),oReport:Row(),)
							oReport:PrintText(PadR(PrintField((cTabGW1)->NRDC, 16), 17),oReport:Row(),)
							oReport:PrintText(PadR(PrintField((cTabGW1)->EMISDC, 16), 17),oReport:Row(),)
							oReport:PrintText(PadR(PrintField(Transform((cTabGW1)->VLFRET, "@E 999,999,999.99"), 14), 15),oReport:Row(),)
							oReport:PrintText(PrintField((cTabGW1)->TRANSP, 40),oReport:Row(),)
							oReport:SkipLine()	
						(cTabGW1)->( dbSkip() )
						EndDo
					Else
						oReport:PrintText(Space(4) + "** Nenhum Documento de Carga encontrado para a pré-fatura.")
					EndIf
				
					oReport:SkipLine(2)	
				
				EndIf
				
				
			EndIf

			If !lHeaderUn
				oReport:SkipLine()
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf

		If !lHeaderUn
			oSection1:Finish()
		EndIf

		(cTabGWJ)->( dbSkip() )
		EndDo

		If lHeaderUn
			oSection1:Finish()
		EndIf
	EndIf



	/* ----------------------------------------------------------------
	   Realização
	   ---------------------------------------------------------------- */
	If cDados == 3
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:PrintText("R E A L I Z A Ç Ã O")
		oReport:FatLine()
		oReport:SkipLine()
	EndIf

	If cDados == 2 .OR. cDados == 3
		CarregaRealizacao(oReport)

		If lHeaderUn
			oSection2:Init()
		EndIf

		dbSelectArea((cTabGW6))
		dbGoTop()
		While !oReport:Cancel() .AND. !(cTabGW6)->( Eof() )
			// Filtro: Com diferença
			// Desconsidera: Valores iguais ou Valor contábil zerado
			If cFiltro == 2
				If Empty((cTabGW6)->VALORCTB)
					(cTabGW6)->( dbSkip() )
					Loop
				EndIf

				If (cTabGW6)->VALORFAT == (cTabGW6)->VALORCTB
					(cTabGW6)->( dbSkip() )
					Loop
				EndIf
			EndIf

			// Filtro: Valor Contábil zerado
			If cFiltro == 3
				If !Empty((cTabGW6)->VALORCTB)
					(cTabGW6)->( dbSkip() )
					Loop
				EndIf
			EndIf
			
			// Todas Inconsistências
			If cFiltro == 4
				If (cTabGW6)->VALORFAT == (cTabGW6)->VALORCTB
					(cTabGW6)->( dbSkip() )
					Loop
				EndIf
			EndIf			

			If !lHeaderUn
				oSection2:Init()
			EndIf
			oSection2:PrintLine()

			// Mostra lançamentos
			If lLanctos
				dbSelectArea((cTabGW7))
				dbSetOrder(1)
				If dbSeek((cTabGW6)->FILIAL + (cTabGW6)->EMIFAT + (cTabGW6)->NRFAT)
					oReport:SkipLine()
					oReport:PrintText(Space(4) + "Conta Contábil       Centro de Custo      Valor ")
					oReport:PrintText(Space(4) + "-------------------- -------------------- ------------------")

					While !(cTabGW7)->( Eof() ) 				  .AND. ;
						   (cTabGW7)->FILIAL == (cTabGW6)->FILIAL .AND. ;
						   (cTabGW7)->EMIFAT == (cTabGW6)->EMIFAT .AND. ;
						   (cTabGW7)->NRFAT  == (cTabGW6)->NRFAT
						oReport:PrintText(Space(4) + ;
										  PrintField((cTabGW7)->CTACTB, 21) + ;
										  PrintField((cTabGW7)->CCUSTO, 21) + ;
										  PrintField(Transform((cTabGW7)->VLMOV, "@E 999,999,999,999.99"), 18))
						(cTabGW7)->( dbSkip() )
					EndDo
				Else
					oReport:PrintText(Space(4) + "** Nenhum movimento contábil encontrado.")
				EndIf
			EndIf
			
			If lDetalhado
				dbSelectArea((cTabGW3))
				dbSetOrder(1)
				If dbSeek((cTabGW6)->FILIAL + (cTabGW6)->EMIFAT + (cTabGW6)->NRFAT)
					oReport:SkipLine()
					oReport:PrintText(Space(4) + "Filial    Docto. Frete   Valor              Valor Contábil")
					If !lLanctos
						oReport:PrintText(Space(4) + "--------- -------------- ------------------ ------------------ ")
					EndIf

					lMovimentosOk := .T.
					
					While !(cTabGW3)->( Eof() ) 				  .AND. ;
						   (cTabGW3)->FILFAT == (cTabGW6)->FILIAL .AND. ;
						   (cTabGW3)->EMIFAT == (cTabGW6)->EMIFAT .AND. ;
						   (cTabGW3)->NRFAT  == (cTabGW6)->NRFAT
						   
						If cFiltro == 4
							If (cTabGW3)->VALORDF == (cTabGW3)->VALORCTB
								(cTabGW3)->( dbSkip() )
								Loop
							Endif
						EndIf
						
						lMovimentosOk := .F.

						If lLanctos
							oReport:PrintText(Space(4) + "--------- -------------- ------------------ ------------------ ")
						EndIf

						oReport:PrintText(Space(4) + ;
										  PrintField((cTabGW3)->FILIAL, 10) + ;
										  PrintField((cTabGW3)->NRDF, 15) + ;
										  PrintField(Transform((cTabGW3)->VALORDF,   "@E 999,999,999,999.99"), 19) + ;
										  PrintField(Transform((cTabGW3)->VALORCTB,  "@E 999,999,999,999.99"), 18))

						If lLanctos
							dbSelectArea((cTabGWA))
							dbSetOrder(2)

							If dbSeek((cTabGW3)->FILIAL + "2" + (cTabGW3)->EMISDF + (cTabGW3)->NRDF)
								While !(cTabGWA)->( Eof() ) 				   .AND. ;
									   (cTabGWA)->FILIAL  == (cTabGW3)->FILIAL .AND. ;
									   (cTabGWA)->TPDOC   == "2" 			   .AND. ;
									   (cTabGWA)->EMISDF  == (cTabGW3)->EMISDF .AND. ;
									   (cTabGWA)->NRDF    == (cTabGW3)->NRDF

									oReport:PrintText(Space(4) + ;
													  "Conta Contábil: " + PrintField((cTabGWA)->CTADEB, 22) + ;
													  "C. Custo: "       + PrintField((cTabGWA)->CCDEB, 22) + ;
										  			  "Valor: "          + AllTrim(Transform((cTabGWA)->VLMOV, "@E 999,999,999,999.99")))
									(cTabGWA)->( dbSkip() )
								EndDo
							Else
								oReport:PrintText(Space(8) + "** Nenhum movimento contábil encontrado para o documento de frete.")
							EndIf

						EndIf

						(cTabGW3)->( dbSkip() )

					EndDo
					
					If lMovimentosOk
						oReport:PrintText(Space(4) + "MOVIMENTOS CONTÁBEIS OK.")
					EndIf
										
				EndIf
			EndIf
			
			If lListaDC
			
				oReport:PrintText(Space(4) + "Filial     ",oReport:Row(),)
				oReport:PrintText(" Dt Emissão",oReport:Row(),)
				oReport:PrintText(" Série",oReport:Row(),)
				oReport:PrintText(" Nota            ",oReport:Row(),)
				oReport:SkipLine()
				oReport:PrintText(Space(4) + "-----------",oReport:Row(),)
				oReport:PrintText(" ----------",oReport:Row(),)
				oReport:PrintText(" -----",oReport:Row(),)
				oReport:PrintText(" ----------------",oReport:Row(),)
				oReport:SkipLine()
				
			
				dbSelectArea((cTabGW1F))
				(cTabGW1F)->( dbSetOrder(2) )
				If (cTabGW1F)->( dbSeek((cTabGW6)->FILIAL+(cTabGW6)->NRFAT) )
					While !(cTabGW1F)->( Eof() ) .And. ((cTabGW1F)->NRFAT == (cTabGW6)->NRFAT)
						oReport:PrintText(Space(4) + PadR(PrintField((cTabGW1F)->FILDC, Len(cFilAnt)), 12),oReport:Row(),)
						oReport:PrintText(PadR((cTabGW1F)->DTEMIS, 11),oReport:Row(),)
						oReport:PrintText(PadR(PrintField((cTabGW1F)->SERDC, 5), 6),oReport:Row(),)
						oReport:PrintText(PadR(PrintField((cTabGW1F)->NRDC, 16), 17),oReport:Row(),)
						oReport:SkipLine()	
					(cTabGW1F)->( dbSkip() )
					EndDo
				Else
					oReport:PrintText(Space(4) + "** Nenhum Documento de Carga encontrado para a fatura.")
				EndIf
				oReport:SkipLine(2)
				
			EndIf

			If !lHeaderUn
				oReport:SkipLine()
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf

		If !lHeaderUn
			oSection2:Finish()
		EndIf

		(cTabGW6)->( dbSkip() )
		EndDo

		If lHeaderUn
			oSection2:Finish()
		EndIf
	EndIf




	/* ----------------------------------------------------------------
	   Eliminação das tabelas temporárias
	   ---------------------------------------------------------------- */
	// --- Provisão -----------------
	If cDados == 1 .OR. cDados == 3
		GFEDelTab(cTabGWJ)
		If lDetalhado
			GFEDelTab(cTabGWF)
		EndIf

		 If lLanctos
		 	GFEDelTab(cTabGWK)
		 EndIf
		 
		 If lListaDC
		 	GFEDelTab(cTabGw1)
		 EndIf
	EndIf

	// --- Realização --------------
	If cDados == 2 .OR. cDados == 3
		GFEDelTab(cTabGW6)
		If lDetalhado
			GFEDelTab(cTabGW3)
		EndIf

		 If lLanctos
		 	GFEDelTab(cTabGW7)
		 EndIf
		 
		 If lListaDC
		 	GFEDelTab(cTabGW1F)
		 EndIf
	EndIf

	// --- Provisão e Realização --
	If lLanctos
	 	GFEDelTab(cTabGWA)
	EndIf

Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaProvisao
Carrega os dados relacionados a Provisão
Interno.

@sample
U_GFER093()

@author Israel A. Possoli
@since 19/12/12
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaProvisao(oReport)
	Local cAliasGWJ
	Local cAliasGWF
	Local nValorPreFat
	Local nValorContabil
	Local nValorCalculo
	Local nValorCtbCalc
	Local nValorFret

	// Faz a busca dos dados da pré-fatura, movimentos contábeis e cálculo de frete
	cAliasGWJ := GetNextAlias()
	cQuery := " SELECT GWJ.* FROM " + RetSQLName("GWJ") + " GWJ WHERE "
	cQuery += " 	GWJ.GWJ_FILIAL >= '" + cFilialIni     + "' AND GWJ.GWJ_FILIAL <= '" + cFilialFim     + "' AND "
	If !Empty(cPreFatIni)
		cQuery += " 	GWJ.GWJ_NRPF >= '" + cPreFatIni + "' AND "
	ENDIF
	
	If cPreFatFim != Replicate("Z", TamSX3("GWJ_NRPF")[1])
		cQuery += " 	GWJ.GWJ_NRPF <= '" + cPreFatFim + "' AND "
	ENDIF	
	cQuery += " 	GWJ.GWJ_DTIMPL >= '" + DTOS(dDataIni) + "' AND GWJ.GWJ_DTIMPL <= '" + DTOS(dDataFim) + "' AND "
	
	If lDocPendentes
		cQuery += " 	(GWJ.GWJ_SITFIN  = '1' OR GWJ.GWJ_SITFIN  = '3')  AND "
	EndIf	

	cQuery += "     GWJ.GWJ_SIT = '3' AND "
	cQuery += "     GWJ.D_E_L_E_T_ =  ' ' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGWJ, .F., .T.)

	dbSelectArea((cAliasGWJ))
	(cAliasGWJ)->( dbGoTop() )

	While !(cAliasGWJ)->( Eof() )
		oReport:IncMeter()

		// Busca os cálculos de frete
		cAliasGWF := GetNextAlias()
		cQuery := " SELECT GWF.* FROM " + RetSQLName("GWF") + " GWF WHERE "
		cQuery += " 	GWF.GWF_FILPRE = '" + (cAliasGWJ)->GWJ_FILIAL + "' AND GWF.GWF_NRPREF = '" + (cAliasGWJ)->GWJ_NRPF + "' AND "
		cQuery += "     GWF.D_E_L_E_T_ =  ' ' "
		cQuery := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGWF, .F., .T.)
		dbSelectArea((cAliasGWF))
		(cAliasGWF)->( dbGoTop() )

		nValorPreFat   := 0
		nValorContabil := 0
		nValorCalculo  := 0
		nValorCtbCalc  := 0
		While !(cAliasGWF)->( Eof() )
			nValorCtbCalc := 0
			
			If lListaDC
				dbSelectArea("GWH")
				GWH->( dbSetOrder(1) )
				If GWH->( dbSeek((cAliasGWF)->(GWF_FILIAL+GWF_NRCALC)) )
					While !GWH->( Eof() ) .And. ;
					GWH->(GWH_FILIAL+GWH_NRCALC) == ;
					(cAliasGWF)->(GWF_FILIAL+GWF_NRCALC)
						dbSelectArea("GW1")
						GW1->( dbSetOrder(1) )
						If GW1->( dbSeek(GWH->(GWH_FILIAL+GWH_CDTPDC+GWH_EMISDC+GWH_SERDC+GWH_NRDC)) )
							While !GW1->( Eof() ) .And. ;
							( GWH->(GWH_FILIAL+GWH_CDTPDC+GWH_EMISDC+GWH_SERDC+GWH_NRDC) == ;
							GW1->(GW1_FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC) )
								       
									nValorFret := 0
									//Posiciona na GWM para fazer a soma por item da nota
									dbSelectArea("GWM")
									dbSetOrder(2)
									If dbSeek(GW1->(GW1_FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC))
										While !GWM->( Eof() ) .And. ;
										( GWM->(GWM_FILIAL+GWM_CDTPDC+GWM_EMISDC+GWM_SERDC+GWM_NRDC) == ;
										GW1->(GW1_FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC) )
										
											nValorFret += GWM->GWM_VLFRET //armazena o valor total do frete.
											GWM->( dbSkip() )
										EndDo
									EndIf
									
									RecLock(cTabGW1, .T.)
										(cTabGW1)->FILDC := GW1->GW1_FILIAL
										(cTabGW1)->SERDC := GW1->GW1_SERDC
										(cTabGW1)->NRDC := GW1->GW1_NRDC
										(cTabGW1)->EMISDC := GW1->GW1_EMISDC
										(cTabGW1)->DTEMIS := GW1->GW1_DTEMIS
										(cTabGW1)->VLFRET := nValorFret
										(cTabGW1)->TRANSP := Posicione("GU3",1,xFilial("GU3") + Posicione("GWU", 1, GW1->(GW1_FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC), "GWU_CDTRP"),"GU3_NMEMIT")
										(cTabGW1)->NRPF := (cAliasGWF)->GWF_NRPREF
										(cTabGW1)->FILIAL := (cAliasGWJ)->GWJ_FILIAL
									MsUnlock(cTabGW1)
					
								GW1->( dbSkip() )
							EndDo
						EndIf
						GWH->( dbSkip() )
						EndDo
				EndIf
			EndIf
			
			// Movimentos contábeis do cálculo
			dbSelectArea("GWA")
			dbSetOrder(3)
			dbSeek((cAliasGWF)->GWF_FILIAL + "1" + PadR((cAliasGWF)->GWF_NRCALC,TamSX3("GWA_NRDOC")[1]))
			While !GWA->( Eof() ) .AND. ;
				   GWA->GWA_FILIAL == (cAliasGWF)->GWF_FILIAL .AND. ;
				   GWA->GWA_TPDOC  == "1"					  .AND. ;
				   GWA->GWA_NRDOC  == PadR((cAliasGWF)->GWF_NRCALC,TamSX3("GWA_NRDOC")[1])

				nValorCtbCalc := GWA->GWA_VLMOV

				If lDetalhado .AND. lLanctos
					RecLock(cTabGWA, .T.)
						(cTabGWA)->FILIAL := (cAliasGWF)->GWF_FILIAL
						(cTabGWA)->NRCALC := (cAliasGWF)->GWF_NRCALC
						(cTabGWA)->TPDOC :=  "1"
						(cTabGWA)->CTADEB := GWA->GWA_CTADEB
						(cTabGWA)->CCDEB  := GWA->GWA_CCDEB
						(cTabGWA)->VLMOV  := GWA->GWA_VLMOV
					MsUnLock(cTabGWF)
				EndIf

				GWA->( dbSkip() )
			EndDo

			//nValorCalculo := VLTOTFRET((cAliasGWF)->GWF_FILIAL, (cAliasGWF)->GWF_NRCALC)
			//
			// Para comparação com o valor provisionado, a função VLFRTPROV vai trazer o valor do cálculo conforme
			// o parâmetro de provisionamento (MV_PROVCON), ou seja, valor total, valor menos impostos recebíveis 
			// ou valor menos impostos
			//
			nValorCalculo := VLFRTPROV((cAliasGWF)->GWF_FILIAL, (cAliasGWF)->GWF_NRCALC)
			nValorPreFat  += nValorCalculo

			If lDetalhado
				RecLock(cTabGWF, .T.)
					(cTabGWF)->FILPF  := (cAliasGWJ)->GWJ_FILIAL
					(cTabGWF)->NRPF   := (cAliasGWJ)->GWJ_NRPF
					(cTabGWF)->FILIAL := (cAliasGWF)->GWF_FILIAL
					(cTabGWF)->NRCALC := (cAliasGWF)->GWF_NRCALC
					(cTabGWF)->VALORCALC := nValorCalculo
					(cTabGWF)->VALORCTB  := nValorCtbCalc
				MsUnLock(cTabGWF)
			EndIf


			(cAliasGWF)->( dbSkip() )
		EndDo
		(cAliasGWF)->(dbCloseArea())

		// Busca os movimentos contábeis
		dbSelectArea("GWK")
		dbSetOrder(1)
		dbSeek((cAliasGWJ)->GWJ_FILIAL + (cAliasGWJ)->GWJ_NRPF)
		While !GWK->( Eof() ) .AND. ;
			   GWK->GWK_FILIAL == (cAliasGWJ)->GWJ_FILIAL .AND. ;
			   GWK->GWK_NRPF   == (cAliasGWJ)->GWJ_NRPF

			If lLanctos
				RecLock(cTabGWK, .T.)
					(cTabGWK)->FILIAL	:= GWK->GWK_FILIAL
					(cTabGWK)->NRPF		:= GWK->GWK_NRPF
					(cTabGWK)->CTACTB	:= GWK->GWK_CTACTB
					(cTabGWK)->CCUSTO	:= GWK->GWK_CCUSTO
					(cTabGWK)->VLMOV	:= GWK->GWK_VLMOV
				MsUnlock(cTabGWK)
			EndIf

			nValorContabil += GWK->GWK_VLMOV
			GWK->( dbSkip() )
		EndDo

		RecLock(cTabGWJ, .T.)
			(cTabGWJ)->FILIAL   := (cAliasGWJ)->GWJ_FILIAL
			(cTabGWJ)->NRPF     := (cAliasGWJ)->GWJ_NRPF
			(cTabGWJ)->VALORPRE := nValorPreFat
			(cTabGWJ)->VALORCTB := nValorContabil
			(cTabGWJ)->DTATUALAP  := Iif(Empty((cAliasGWJ)->GWJ_DTFIN),"Não Atualizado",ConvData((cAliasGWJ)->GWJ_DTFIN))
			
			If (cTabGWJ)->VALORPRE == (cTabGWJ)->VALORCTB
				(cTabGWJ)->SITUACAO := "OK"	
			Else
				(cTabGWJ)->SITUACAO := "INCONSISTENTE"	
			EndIf 			
		MsUnLock(cTabGWJ)

		(cAliasGWJ)->( dbSkip() )
	EndDo

	(cAliasGWJ)->(dbCloseArea())

Return



/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaRealizacao
Carrega os dados relacionados a Realização
Interno.

@sample
U_GFER093()

@author Israel A. Possoli
@since 20/12/12
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaRealizacao(oReport)
	Local cAliasGW6
	Local cAliasGW3
	Local nValorContabil
	Local nValorDF
	Local nValorCtbDF


	// Faz a busca dos dados da pré-fatura, movimentos contábeis e cálculo de frete
	cAliasGW6 := GetNextAlias()
	cQuery := " SELECT GW6.* FROM " + RetSQLName("GW6") + " GW6 WHERE "
	cQuery += " 	GW6.GW6_FILIAL >= '" + cFilialIni     + "' AND GW6.GW6_FILIAL <= '" + cFilialFim     + "' AND "
	If !Empty(cFaturaIni)
		cQuery += " 	GW6.GW6_NRFAT >= '" + cFaturaIni + "' AND "
	ENDIF
	
	If cFaturaFim != Replicate("Z", TamSX3("GW6_NRFAT")[1])
		cQuery += " 	GW6.GW6_NRFAT <= '" + cFaturaFim + "' AND "
	ENDIF
	//verifica qual data será usada para o filtro.
	If cDtUso == 1
		cQuery += " GW6.GW6_DTEMIS >= '" + DTOS(dDataIni) + "' AND GW6.GW6_DTEMIS <= '" + DTOS(dDataFim) + "' AND "
	ElseIf cDtUso == 2
		cQuery += " GW6.GW6_DTCRIA >= '" + DTOS(dDataIni) + "' AND GW6.GW6_DTCRIA <= '" + DTOS(dDataFim) + "' AND "
	ElseIf cDtUso == 3
		cQuery += " GW6.GW6_DTFIN >= '" + DTOS(dDataIni) + "' AND GW6.GW6_DTFIN <= '" + DTOS(dDataFim) + "' AND "
	EndIf
	cQuery += "     (GW6.GW6_SITAPR = '3' OR GW6.GW6_SITAPR = '4') AND "
	If lDocPendentes
		cQuery += " 	(GW6.GW6_SITFIN  = '1' OR GW6.GW6_SITFIN  = '3')  AND "
	EndIf
	cQuery += "     GW6.D_E_L_E_T_ =  ' ' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGW6, .F., .T.)

	dbSelectArea((cAliasGW6))
	(cAliasGW6)->( dbGoTop() )

	While !(cAliasGW6)->( Eof() )
		oReport:IncMeter()

		nValorContabil := 0

		If lDetalhado
			// Busca os cálculos de frete
			cAliasGW3 := GetNextAlias()
			cQuery := " SELECT GW3.* FROM " + RetSQLName("GW3") + " GW3 WHERE "
			cQuery += " 	GW3.GW3_FILFAT = '" + (cAliasGW6)->GW6_FILIAL + "' AND "
			cQuery += " 	GW3.GW3_EMIFAT = '" + (cAliasGW6)->GW6_EMIFAT + "' AND "
			cQuery += " 	GW3.GW3_SERFAT = '" + (cAliasGW6)->GW6_SERFAT + "' AND "
			cQuery += " 	GW3.GW3_NRFAT  = '" + (cAliasGW6)->GW6_NRFAT  + "' AND "
			cQuery += " 	GW3.GW3_DTEMFA = '" + (cAliasGW6)->GW6_DTEMIS + "' AND "
			cQuery += "     GW3.D_E_L_E_T_ =  ' ' "
			cQuery := ChangeQuery(cQuery)
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGW3, .F., .T.)
			dbSelectArea((cAliasGW3))
			(cAliasGW3)->( dbGoTop() )

			nValorDF    := 0
			While !(cAliasGW3)->( Eof() )
				
				If lListaDC
					//Carrega os documentos de carga do Documento de Frete.
					dbSelectArea("GW4")
					GW4->( dbSetOrder(1) )
					GW4->( dbSeek((cAliasGW3)->(GW3_FILIAL+GW3_EMISDF+GW3_CDESP+GW3_SERDF+GW3_NRDF)) )
						While !GW4->( Eof() ) .And. ;
						GW4->(GW4_FILIAL+GW4_EMISDF+GW4_CDESP+GW4_SERDF+GW4_NRDF) == ;
						(cAliasGW3)->(GW3_FILIAL+GW3_EMISDF+GW3_CDESP+GW3_SERDF+GW3_NRDF)
							dbSelectArea("GW1")
							GW1->( dbSetOrder(1) )
							GW1->( dbSeek(GW4->(GW4_FILIAL+GW4_TPDC+GW4_EMISDC+GW4_SERDC+GW4_NRDC)) )
								While !GW1->( Eof() ) .And. ;
								GW4->(GW4_FILIAL+GW4_TPDC+GW4_EMISDC+GW4_SERDC+GW4_NRDC) == ;
								GW1->(GW1_FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC)
							
								RecLock(cTabGW1F, .T.)
									(cTabGW1F)->FILDC := GW1->GW1_FILIAL
									(cTabGW1F)->SERDC := GW1->GW1_SERDC
									(cTabGW1F)->NRDC := GW1->GW1_NRDC
									(cTabGW1F)->EMISDC := GW1->GW1_EMISDC
									(cTabGW1F)->DTEMIS := GW1->GW1_DTEMIS
									(cTabGW1F)->TRANSP := Posicione("GU3",1,xFilial("GU3") + Posicione("GWU", 1, GW1->(GW1_FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC), "GWU_CDTRP"),"GU3_NMEMIT")
									(cTabGW1F)->NRFAT := (cAliasGW6)->GW6_NRFAT
									(cTabGW1F)->FILIAL := (cAliasGW6)->GW6_FILIAL
								MsUnlock(cTabGW1F)
								
								GW1->( dbSkip() )
							EndDo
							GW4->( dbSkip() )
						EndDo
					EndIf
				
				// Movimentos contábeis do documento de frete				
				nValorCtbDF := 0
				dbSelectArea("GWA")
				dbSetOrder(3)
				dbSeek((cAliasGW3)->GW3_FILIAL + "2" + (cAliasGW3)->GW3_NRDF)
				While !GWA->( Eof() ) .AND. ;
					   GWA->GWA_FILIAL == (cAliasGW3)->GW3_FILIAL .AND. ;
					   GWA->GWA_TPDOC  == "2"					  .AND. ;
					   GWA->GWA_NRDOC  == (cAliasGW3)->GW3_NRDF
					   
					If GWA->GWA_CDEMIT == (cAliasGW3)->GW3_EMISDF .AND. GWA->GWA_SERIE  == (cAliasGW3)->GW3_SERDF
						nValorCtbDF += GWA->GWA_VLMOV
	
						If lLanctos
							RecLock(cTabGWA, .T.)
								(cTabGWA)->FILIAL := (cAliasGW3)->GW3_FILIAL
								(cTabGWA)->NRDF   := (cAliasGW3)->GW3_NRDF
								(cTabGWA)->EMISDF := (cAliasGW3)->GW3_EMISDF
								(cTabGWA)->TPDOC  :=  "2"
								(cTabGWA)->CTADEB := GWA->GWA_CTADEB
								(cTabGWA)->CCDEB  := GWA->GWA_CCDEB
								(cTabGWA)->VLMOV  := GWA->GWA_VLMOV
							MsUnLock(cTabGWA)
						EndIf
					EndIf

					GWA->( dbSkip() )
				EndDo

				RecLock(cTabGW3, .T.)
					(cTabGW3)->FILFAT 	 := (cAliasGW6)->GW6_FILIAL
					(cTabGW3)->EMIFAT    := (cAliasGW6)->GW6_EMIFAT
					(cTabGW3)->NRFAT 	 := (cAliasGW6)->GW6_NRFAT
					(cTabGW3)->FILIAL 	 := (cAliasGW3)->GW3_FILIAL
					(cTabGW3)->NRDF 	 := (cAliasGW3)->GW3_NRDF
					(cTabGW3)->EMISDF 	 := (cAliasGW3)->GW3_EMISDF
					(cTabGW3)->VALORDF   := (cAliasGW3)->GW3_VLDF
					(cTabGW3)->VALORCTB  := nValorCtbDF
				MsUnLock(cTabGW3)

				(cAliasGW3)->( dbSkip() )
			EndDo
			(cAliasGW3)->(dbCloseArea())
		EndIf

		// Busca os movimentos contábeis
		dbSelectArea("GW7")
		dbSetOrder(1)
		dbSeek((cAliasGW6)->GW6_FILIAL + (cAliasGW6)->GW6_EMIFAT + (cAliasGW6)->GW6_SERFAT + (cAliasGW6)->GW6_NRFAT + (cAliasGW6)->GW6_DTEMIS)
		While !GW7->( Eof() ) .AND. ;
			   GW7->GW7_FILIAL 		 == (cAliasGW6)->GW6_FILIAL .AND. ;
			   GW7->GW7_EMIFAT 		 == (cAliasGW6)->GW6_EMIFAT .AND. ;
			   GW7->GW7_SERFAT 		 == (cAliasGW6)->GW6_SERFAT .AND. ;
			   GW7->GW7_NRFAT        == (cAliasGW6)->GW6_NRFAT  .AND. ;
			   DTOS(GW7->GW7_DTEMIS) == (cAliasGW6)->GW6_DTEMIS

			If lLanctos
				RecLock(cTabGW7, .T.)
					(cTabGW7)->FILIAL	:= (cAliasGW6)->GW6_FILIAL
					(cTabGW7)->EMIFAT	:= (cAliasGW6)->GW6_EMIFAT
					(cTabGW7)->NRFAT	:= (cAliasGW6)->GW6_NRFAT
					(cTabGW7)->CTACTB	:= GW7->GW7_CTACTB
					(cTabGW7)->CCUSTO	:= GW7->GW7_CCUSTO
					(cTabGW7)->VLMOV	:= GW7->GW7_VLMOV
				MsUnlock(cTabGW7)
			EndIf

			nValorContabil += GW7->GW7_VLMOV
			GW7->( dbSkip() )
		EndDo

		RecLock(cTabGW6, .T.)
			(cTabGW6)->FILIAL   := (cAliasGW6)->GW6_FILIAL
			(cTabGW6)->EMIFAT   := (cAliasGW6)->GW6_EMIFAT
			(cTabGW6)->NRFAT    := (cAliasGW6)->GW6_NRFAT
			(cTabGW6)->VALORFAT := (cAliasGW6)->GW6_VLFATU
			(cTabGW6)->VALORCTB := nValorContabil
			(cTabGW6)->DTATUAP  := Iif(Empty((cAliasGW6)->GW6_DTFIN),"Não Atualizado",ConvData((cAliasGW6)->GW6_DTFIN))
 			
			If (cTabGW6)->VALORFAT == (cTabGW6)->VALORCTB
				(cTabGW6)->SITUACAO := "OK"
			Else
				(cTabGW6)->SITUACAO := "INCONSISTENTE"
			EndIf			
		MsUnLock(cTabGW6)

		(cAliasGW6)->( dbSkip() )
	EndDo

	(cAliasGW6)->(dbCloseArea())

Return




/*/--------------------------------------------------------------------------------------------------
DefTabGWJ
Retorna a definição da tabela temporária da pré-fatura
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGWJ()
	aTT   :=  {{"FILIAL"   ,"C",Len(cFilAnt),0},;
			   {"NRPF"     ,"C",TamSX3("GWJ_NRPF")[1],0},;
			   {"VALORPRE" ,"N",12,2},;
			   {"VALORCTB" ,"N",12,2},;
			   {"SITUACAO" ,"C",14,0},;
			   {"DTATUALAP", "C", 14, 0}}

Return GFECriaTab({ aTT,{"FILIAL+NRPF"} })

/*/--------------------------------------------------------------------------------------------------
DefTabGWK
Retorna a definição da tabela temporária dos movimentos contábeis da pré-fatura
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGWK()
	aTT   :=  {{"FILIAL"    ,"C",Len(cFilAnt),0},;
			   {"NRPF"      ,"C",TamSX3("GWJ_NRPF")[1], 0},;
			   {"CTACTB"    ,"C",20,0},;
			   {"CCUSTO"    ,"C",20,0},;
			   {"VLMOV"     ,"N",12,2}}

Return GFECriaTab({ aTT,{"FILIAL+NRPF"} })

/*/--------------------------------------------------------------------------------------------------
DefTabGWF
Retorna a definição da tabela temporária do cálculo de frete
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGWF()
	aTT   :=  {{"FILPF"     ,"C",Len(cFilAnt),0},;
			   {"NRPF"      ,"C",TamSX3("GWJ_NRPF")[1],0},;
       		   {"FILIAL"    ,"C",Len(cFilAnt),0},;
			   {"NRCALC"    ,"C",8,0},;
			   {"VALORCALC" ,"N",12,2},;
			   {"VALORCTB"  ,"N",12,2}}

Return GFECriaTab({ aTT,{"FILPF+NRPF+FILIAL+NRCALC"} })


 /*/--------------------------------------------------------------------------------------------------
DefTabGWA
Retorna a definição da tabela temporária dos movimentos contábeis do cálculo
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGWA()
	aTT   :=  {{"FILIAL"    ,"C",Len(cFilAnt),0},;
			   {"TPDOC"     ,"C",1,  0},;
			   {"NRCALC"    ,"C",8,  0},;
			   {"EMISDF"    ,"C",14, 0},;
			   {"NRDF"      ,"C",16, 0},;
			   {"CTADEB"    ,"C",20, 0},;
			   {"CCDEB"     ,"C",20, 0},;
			   {"VLMOV"     ,"N",12, 2}}

Return GFECriaTab({ aTT,{"FILIAL+TPDOC+NRCALC", "FILIAL+TPDOC+EMISDF+NRDF"} })

/*/--------------------------------------------------------------------------------------------------
DefTabGW6
Retorna a definição da tabela temporária da fatura
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGW6()
	aTT   :=  {{"FILIAL"   ,"C",Len(cFilAnt),0},;
			   {"EMIFAT"   ,"C",TamSX3("GW6_EMIFAT")[1],0},;
			   {"NRFAT"    ,"C",TamSX3("GW6_NRFAT")[1],0},;
			   {"VALORFAT" ,"N",12,2},;
			   {"VALORCTB" ,"N",12,2},;
			   {"SITUACAO" ,"C",14,0},;
			   {"DTATUAP" ,"C",14,0}}

Return GFECriaTab({ aTT,{"FILIAL+EMIFAT+NRFAT"} })

/*/--------------------------------------------------------------------------------------------------
DefTabGW7
Retorna a definição da tabela temporária dos movimentos contábeis da fatura
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGW7()
	aTT   :=  {{"FILIAL"    ,"C",Len(cFilAnt),0},;
			   {"EMIFAT"    ,"C",14,0},;
			   {"NRFAT"     ,"C",16,0},;
			   {"CTACTB"    ,"C",20,0},;
			   {"CCUSTO"    ,"C",20,0},;
			   {"VLMOV"     ,"N",12,2}}

Return GFECriaTab({ aTT,{"FILIAL+EMIFAT+NRFAT"} })


/*/--------------------------------------------------------------------------------------------------
DefTabGW3
Retorna a definição da tabela temporária dos movimentos contábeis da fatura
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGW3()
	aTT   :=  {{"FILFAT"    ,"C",Len(cFilAnt),0},;
			   {"EMIFAT"    ,"C",14,0},;
			   {"NRFAT"     ,"C",16,0},;
			   {"FILIAL"    ,"C",Len(cFilAnt),0},;
			   {"EMISDF"    ,"C",14,0},;
			   {"NRDF"      ,"C",16,0},;
			   {"VALORDF"   ,"N",12,2},;
			   {"VALORCTB"  ,"N",12,2}}

Return GFECriaTab({ aTT,{"FILIAL+EMIFAT+NRFAT"} })
/*/--------------------------------------------------------------------------------------------------
DefTabGW1
Retorna a definição da tabela temporária dos movimentos contábeis da fatura
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGW1(lFat)

	Local cIndice

	aTT := {{"FILDC", "C", Len(cFilAnt), 0},;
			{"CDTPDC", "C", 5, 0},;
			{"SERDC", "C", 5, 0},;
			{"NRDC", "C", 16, 0},;
			{"EMISDC", "C", 14, 0},;
			{"DTEMIS", "D", 8, 0},;
			{"VLFRET", "N", 12, 2},;
			{"TRANSP", "C", 60, 0},;
			{"FILIAL", "C", Len(cFilAnt), 0}}
			
	If lFat
		Aadd(aTT, {"NRFAT", "C", TamSX3("GW6_NRFAT")[1], 0})
		cIndice := "NRFAT"
	Else
		Aadd(aTT, {"NRPF", "C", 8, 0})
		cIndice := "NRPF"
	EndIf


Return GFECriaTab({ aTT ,{"FILDC+SERDC+NRDC+EMISDC+CDTPDC", "FILIAL+"+cIndice }})

/*/--------------------------------------------------------------------------------------------------
PrintField
--------------------------------------------------------------------------------------------------/*/
Static Function PrintField(cValor, nTamanho, nDirecao)
	Local cRet := cValor
	Default nDirecao := 2

	If nDirecao == 1
		cRet := PadL(AllTrim(cValor), nTamanho)
	Else
		cRet := PadR(AllTrim(cValor), nTamanho)
	EndIf

Return (cRet)

Static function ConvData(cData)

	Local cDataC
	
	cDataC := substr(cData,7,2) + "/" + substr(cData,5,2) + "/" + substr(cData,1,4)

Return cDataC
