/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER094
Relatório de Docto sem Provisão
Generico.

@sample
U_GFER094()

@author Israel A. Possoli
@since 01/03/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER094()
	Local   oReport
	Private cDados
	Private cFilialIni
	Private cFilialFim
	Private dDataIni
	Private dDataFim
	Private cTabGW1	

	Pergunte("GFER094",.T.)
	
	cFilialIni := MV_PAR01
	cFilialFim := MV_PAR02
	dDataIni   := MV_PAR03
	dDataFim   := MV_PAR04

	If dDataIni > dDataFim
		Help( ,, 'HELP',, "Data inicial deve ser menor que a data final.", 1, 0,)
		Return Nil
	EndIf

	If TRepInUse() // teste padrão
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	GFEDelTab(cTabGW1)

Return

Static Function ReportDef()
	Local oReport
	Local oSection1
	Local aOrdem    := {}

	cTabGW1 := DefTabGW1()

	aAdd(aOrdem, "Documento sem provisão")

	oReport:= TReport():New("GFER094", "Documento de carga sem provisão","GFER094", {|oReport| ReportPrint(oReport)}, "Documento de Carga sem provisão")
	oReport:HideParamPage()

	oSection1 := TRSection():New(oReport,"Documento de Carga",{"(cTabGW1)"}, aOrdem)
	oSection1:SetHeaderSection(.T.)
	oSection1:lHeaderVisible := .F.

	TRCell():New(oSection1, "(cTabGW1)->FILIAL"  	, "(cTabGW1)", "Filial"       , ""  , 12                      , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->EMISDC"		, "(cTabGW1)", "Cod Emissor"  , "@!", TamSX3("GW1_EMISDC")[1] , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->NMEMIS"		, "(cTabGW1)", "Nome Emissor" , "@!", 55 					  , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->CDTPDC"    	, "(cTabGW1)", "Tipo"   	  , "@!", TamSX3("GW1_CDTPDC")[1] , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->SERDC"		, "(cTabGW1)", "Série"    	, "!!!",TamSX3("GW1_SERDC")[1]  , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->NRDC"    	, "(cTabGW1)", "Nr Docto"     , "@!", TamSX3("GW1_NRDC")[1]   , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->TRECHO"    	, "(cTabGW1)", "Trecho"       , "@!", TamSX3("GWU_SEQ")[1]    , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->DTEMIS"    	, "(cTabGW1)", "Data Emissão" , ""  ,  10      				  , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->VLCALC"    	, "(cTabGW1)", "Vl Cálculo"	  , "@E 999,999,999.99",  15   	  , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->NRCALC"    	, "(cTabGW1)", "Cálculo" 	  , "@!",  9                      , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->NRPF"    	, "(cTabGW1)", "Pré-Fatura"	  , "@!",  9                      , .T., /*{|| code-block de impressao }*/ )
	TRCell():New(oSection1, "(cTabGW1)->MOTIVO"    	, "(cTabGW1)", "Motivo" 	  , "@!",  50                     , .T., /*{|| code-block de impressao }*/ )

Return(oReport)

Static Function ReportPrint(oReport)
	Local oSection1  := oReport:Section(1)

	cFilialIni 		:= MV_PAR01
	cFilialFim 		:= MV_PAR02
	dDataIni   		:= MV_PAR03
	dDataFim   		:= MV_PAR04

	CarregaDado(oReport)

	oSection1:Init()

	dbSelectArea((cTabGW1))
	dbGoTop()
	While !oReport:Cancel() .AND. !(cTabGW1)->( Eof() )
		oSection1:PrintLine()

		(cTabGW1)->(dbSkip())
	EndDo
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaDados
Realiza a busca dos documentos de carga conforme a seleção e cria a tabela temporária de impressão
Generico.

@sample
CarregaDados()

@author Israel A. Possoli
@since 01/03/12
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaDado(oReport)
	Local   cAliasGW1
	Local	lCalcTrecho
	Local	lSemProvisao
	Local	cMotivo
	Local	aSitPrefat[5]
	Local  aSitLote := {}
	Local	nVlCalc
	Local	cNrCalc
	Local	cNrPreFat
	Local 	lExistGXD := ChkFile("GXD")
	
	aSitPrefat[1] := "Não enviada"
	aSitPrefat[2] := "Pendente"
	aSitPrefat[3] := "Rejeitada"
	aSitPrefat[4] := "Atualizada"
	aSitPrefat[5] := "Pendente Desatualização"
	
	aSitLote 		:= StrToKArr(Posicione("SX3",2,"GXE_SIT","X3_CBOX"),";")
	
	// Faz a busca dos dados dos movimentos, movimentos contábeis e cálculo de frete
	cAliasGW1 := GetNextAlias()
	cQuery := "SELECT * FROM " + RetSQLName("GW1") + " GW1 WHERE"
	cQuery += " 	GW1.GW1_FILIAL >= '" + cFilialIni     + "' AND GW1.GW1_FILIAL <= '" + cFilialFim     + "' AND "
	cQuery += " 	GW1.GW1_DTEMIS >= '" + DTOS(dDataIni) + "' AND GW1.GW1_DTEMIS <= '" + DTOS(dDataFim) + "' AND "
	cQuery += "     GW1.D_E_L_E_T_ = ' '"
	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGW1, .F., .T.)

	dbSelectArea((cAliasGW1))
	(cAliasGW1)->( dbGoTop() )

	oReport:SetMeter((cAliasGW1)->(LastRec()))

	If lExistGXD
		dbSelectArea("GXD")
	EndIf
	
	dbSelectArea("GXE")
	dbSelectArea("GWJ")

	While !oReport:Cancel() .AND. !(cAliasGW1)->( Eof() )
		oReport:IncMeter()

		dbSelectArea("GWU")
		dbSetOrder(1)
		dbSeek((cAliasGW1)->GW1_FILIAL + (cAliasGW1)->GW1_CDTPDC + (cAliasGW1)->GW1_EMISDC + (cAliasGW1)->GW1_SERDC + (cAliasGW1)->GW1_NRDC)
		While !GWU->(Eof()) .AND. GWU->GWU_FILIAL == (cAliasGW1)->GW1_FILIAL ;
							.AND. GWU->GWU_CDTPDC == (cAliasGW1)->GW1_CDTPDC ;
							.AND. GWU->GWU_SERDC  == (cAliasGW1)->GW1_SERDC ;
							.AND. GWU->GWU_NRDC   == (cAliasGW1)->GW1_NRDC

			/**************************************************
				Verifica se o trecho é Pago
			**************************************************/
			If GWU->GWU_PAGAR == "2"
				(cAliasGW1)->(dbSkip())
				Loop
			EndIf

			nVlCalc		 := 0
			cNrCalc		 := ""
			cNrPreFat	 := ""
			cMotivo		 := ""
			lSemProvisao := .F.
			lCalcTrecho	 := .F.

			/**************************************************
				Busca o cálculo do trecho
			**************************************************/
			dbSelectArea("GWH")
			GWH->( dbSetOrder(2) )
			If !GWH->( dbSeek((cAliasGW1)->GW1_FILIAL + (cAliasGW1)->GW1_CDTPDC + (cAliasGW1)->GW1_EMISDC + (cAliasGW1)->GW1_SERDC + (cAliasGW1)->GW1_NRDC) )
				cMotivo		 := "Sem cálculo"
				lSemProvisao := .T.
				lCalcTrecho	 := .F.
			EndIF

			If !lSemProvisao
				While !GWH->( Eof() ) .AND. GWH->GWH_FILIAL == (cAliasGW1)->GW1_FILIAL ;
				                      .AND. GWH->GWH_CDTPDC == (cAliasGW1)->GW1_CDTPDC ;
									  .AND. GWH->GWH_EMISDC == (cAliasGW1)->GW1_EMISDC ;
									  .AND. GWH->GWH_SERDC  == (cAliasGW1)->GW1_SERDC ;
									  .AND. GWH->GWH_NRDC   == (cAliasGW1)->GW1_NRDC .AND. !lSemProvisao
						
					dbSelectArea("GWF")
					GWF->( dbSetOrder(1) )
					If GWF->( dbSeek(GWH->GWH_FILIAL + GWH->GWH_NRCALC) )

						If AllTrim(GWF->GWF_SEQTRE) == AllTrim(GWU->GWU_SEQ)

							cNrCalc := GWF->GWF_NRCALC
							nVlCalc := VLTOTFRET(GWF->GWF_FILIAL,  GWF->GWF_NRCALC)

							lCalcTrecho := .T.

							/**************************************************
								Verifica se existe pré-fatura e se está integrada
							**************************************************/
							GWJ->(dbSetOrder(1))
							If GWJ->( dbSeek(GWF->GWF_FILPRE + GWF->GWF_NRPREF) )
								cNrPreFat := GWJ->GWJ_NRPF
								If GWJ->GWJ_SITFIN != "4"
									lSemProvisao := .T.

									If Empty(GWJ->GWJ_SITFIN)
										cMotivo	:= "Pré-fatura não integrada: Situação inválida"
									Else
										cMotivo	:= "Pré-fatura não integrada: " + aSitPrefat[Val(GWJ->GWJ_SITFIN)]
									EndIf
								EndIf

							Else
								If lExistGXD
									GXD->(dbSetOrder(2))
									If GXD->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC))
										GXE->(dbSetOrder(1))
										If GXE->(dbSeek(GXD->GXD_FILIAL+GXD->GXD_CODLOT))
											If GXE->GXE_SIT != "4"
												lSemProvisao := .T.

												If Empty(GXE->GXE_SIT)
													cMotivo := "Lote contábil não integrado: Situação inválida"
												Else
													cMotivo := "Lote contábil não integrado: " + SubStr(aSitLote[Val(GXE->GXE_SIT)], 3)
												EndIf
											EndIf
										Else
											lSemProvisao := .T.
											cMotivo	:= "Lote contábil de provisionamento não encontrado"	
										EndIf
									Else
										lSemProvisao := .T.
										cMotivo := "Sem provisão"	
									EndIf
								Else
									lSemProvisao := .T.
									cMotivo := "Sem pré-fatura"	
								EndIf
							EndIf
						EndIf
					EndIf

				    GWH->(dbSkip())
				EndDo

				If !lCalcTrecho
					cMotivo		 := "Sem cálculo"
					lSemProvisao := .T.
				EndIf
			EndIf


			/**************************************************
				Grava o DC se não possuir previsão
			**************************************************/
			If lSemProvisao
				RecLock(cTabGW1, .T.)
					(cTabGW1)->FILIAL	:= (cAliasGW1)->GW1_FILIAL
					(cTabGW1)->EMISDC	:= (cAliasGW1)->GW1_EMISDC
					(cTabGW1)->NMEMIS	:= Posicione("GU3",1,xFilial("GU3")+(cAliasGW1)->GW1_EMISDC,"GU3_NMEMIT")
					(cTabGW1)->CDTPDC	:= (cAliasGW1)->GW1_CDTPDC
					(cTabGW1)->SERDC	:= (cAliasGW1)->GW1_SERDC
					(cTabGW1)->NRDC		:= (cAliasGW1)->GW1_NRDC
					(cTabGW1)->TRECHO	:= GWU->GWU_SEQ
					(cTabGW1)->DTEMIS	:= STOD((cAliasGW1)->GW1_DTEMIS)
					(cTabGW1)->NRCALC	:= cNrCalc
					(cTabGW1)->NRPF		:= cNrPreFat
					(cTabGW1)->VLCALC	:= nVlCalc
					(cTabGW1)->MOTIVO	:= cMotivo
				MsUnLock(cTabGW1)
			EndIf

			GWU->(dbSkip())
		EndDo

		(cAliasGW1)->(dbSkip())
	EndDo
	(cAliasGW1)->(dbCloseArea())
Return


/*/--------------------------------------------------------------------------------------------------
DefTabGW1
Retorna a definição da tabela temporária do documento de carga
--------------------------------------------------------------------------------------------------/*/
Static Function DefTabGW1()

	aTT :=  {{"FILIAL", "C", Len(cFilAnt)			, 0},;
		     {"EMISDC", "C", TamSX3("GW1_EMISDC")[1], 0},;
		     {"NMEMIS", "C", TamSX3("GW1_NMEMIS")[1], 0},;
		     {"CDTPDC", "C", TamSX3("GW1_CDTPDC")[1], 0},;
		     {"SERDC" , "C", TamSX3("GW1_SERDC")[1] , 0},;
		     {"NRDC"  , "C", TamSX3("GW1_NRDC")[1]  , 0},;
		     {"TRECHO", "C", TamSX3("GWU_SEQ")[1]   , 0},;
		     {"DTEMIS", "D", 8						, 0},;
		     {"VLCALC", "N", 12						, 2},;
		     {"NRCALC", "C", 8						, 0},;
		     {"NRPF"  , "C", 8						, 0},;
		     {"MOTIVO", "C", 50						, 0}}

Return GFECriaTab({ aTT,{"FILIAL+EMISDC+CDTPDC+SERDC+NRDC"} })
