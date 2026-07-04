/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER082
Relatorio de Despesas Transporte por Doc Carga
Generico.

@sample
GFER081()

@author Felipe M.
@since 21/12/11
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER082()
	Local oReport                   //objeto que contem o relatorio
	Local aArea := GetArea()

	Private cAlias
	Private lDetalhado

	Pergunte("GFER082",.F.)

	If TRepInUse() // teste padrão
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	GFEDelTab(cAlias)
	RestArea( aArea )
Return

/*/--------------------------------------------------------------------------------------------------
ReportDef()
Relatorio de Despesa de Frete por Transportador
Generico.

@sample
ReportDef()

@author Felipe M.
@since 21/12/11
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport, oSection1
	Local aOrdem    := {}

	CriaTable()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
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
	oReport:= TReport():New("GFER082"," Despesas Transporte por Doc Carga","GFER082", {|oReport| ReportPrint(oReport)}," Despesas Transporte por Doc Carga")
	oReport:SetLandscape()   // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	oReport:nFontBody	:= 10 // Define o tamanho da fonte.
	oReport:nLineHeight	:= 50 // Define a altura da linha.
	//oReport:NDEVICE := 4

	Aadd( aOrdem, "Despesa de Frete por Transportador" ) // "Sequência" //"Codigo"

	oSection1 := TRSection():New(oReport,"Despesas Transporte por Doc Carga",{"(cAlias)"},aOrdem)
	oSection1:SetLineStyle() //Define a impressao da secao em linha
	oSection1:SetTotalInLine(.F.)

	TRCell():New(oSection1,"(cAlias)->GW_CDTPDC" ,(cAlias),"Cod. Tipo Doc"					,"@!", TamSX3("GW1_CDTPDC" )[1],/*lPixel*/, )
	TRCell():New(oSection1,"(cAlias)->GW_EMISDC" ,(cAlias),"Cod Emissor"					,"@!", TamSX3("GW1_EMISDC" )[1],/*lPixel*/, )
	TRCell():New(oSection1,"(cAlias)->GW_SERDC"  ,(cAlias),"Serie"				   	,"!!!",TamSX3("GW1_SERDC" )[1],/*lPixel*/, )
	TRCell():New(oSection1,"(cAlias)->GW_NRDC"   ,(cAlias),"Número"				   			,"",   TamSX3("GW1_NRDC" )[1],/*lPixel*/, )
	TRCell():New(oSection1,"(cAlias)->GW_DTEMIS" ,(cAlias),"Data Emissão"					,"",   TamSX3("GW1_DTEMIS" )[1],/*lPixel*/, )

	TRCell():New(oSection1,"(cAlias)->PREV_TOT"  ,(cAlias),"Prev Total"					,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, )//Frete Previsto Total,

	TRCell():New(oSection1,"(cAlias)->PREV_NOR"  ,(cAlias),"Prev Normal"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, )//Frete Previsto Normal,
	TRCell():New(oSection1,"(cAlias)->PREV_RED"  ,(cAlias),"Prev Redesp"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, )//Frete Previsto Redesp,
	TRCell():New(oSection1,"(cAlias)->PREV_REE"  ,(cAlias),"Prev Reentr"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, ) //Frete Previsto Reentr,
	TRCell():New(oSection1,"(cAlias)->PREV_DEV"  ,(cAlias),"Prev Devol"				    ,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, )//Frete Previsto Devol,
	TRCell():New(oSection1,"(cAlias)->PREV_SER"  ,(cAlias),"Prev Serviço"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, )//Frete Previsto Serviço,
	TRCell():New(oSection1,"(cAlias)->PREV_COM"  ,(cAlias),"Prev Complen"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, ) //Frete Previsto Compl,

	TRCell():New(oSection1,"(cAlias)->REAL_TOT"  ,(cAlias),"Real Total"					,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, ) //Frete Real Total,

	TRCell():New(oSection1,"(cAlias)->REAL_NOR"  ,(cAlias),"Real Normal"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, ) //Frete Real Normal,
	TRCell():New(oSection1,"(cAlias)->REAL_RED"  ,(cAlias),"Real Redesp"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, )//Frete Real Redesp,
	TRCell():New(oSection1,"(cAlias)->REAL_REE"  ,(cAlias),"Real Reentr"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, ) //Frete Real Reentr,
	TRCell():New(oSection1,"(cAlias)->REAL_DEV"  ,(cAlias),"Real Devol"					,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, )//Frete Real Devol,
	TRCell():New(oSection1,"(cAlias)->REAL_SER"  ,(cAlias),"Real Serviço"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, ) //Frete Real Serviço,
	TRCell():New(oSection1,"(cAlias)->REAL_COM"  ,(cAlias),"Real Complen"				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, ) //Frete Real Compl,
	TRCell():New(oSection1,"(cAlias)->REAL_AUT"  ,(cAlias),"Real Auton."				,"@E 99,999,999.99",TamSX3("GWI_VLFRET" )[1],/*lPixel*/, ) //Frete Real Autonomo,

Return(oReport)

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportPrint
Relatorio de Documentos de Carga
Generico.

@sample
ReportPrint(oReport)

@author Felipe M.
@since 14/10/09
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint(oReport)
	Local aParam    := Array(10)
	Local oSection1 := oReport:Section(1)

	Private aCols   := Array(9)
	Private cCriRat := SuperGetMv("MV_CRIRAT",.F.,"1")

	If Empty(cCriRat) .Or. !(cCriRat $ "1234")
		cCriRat := "1"
	EndIf
	aCols := GetRatCols()

	aParam[1]  := MV_PAR01
	aParam[2]  := MV_PAR02
	aParam[3]  := MV_PAR03
	aParam[4]  := MV_PAR04
	aParam[5]  := If(MV_PAR05==1,.T.,.F.)
	aParam[6]  := If(MV_PAR06==1,.F.,.T.)
	aParam[7]  := If(MV_PAR07==2,.T.,.F.)
	lDetalhado := aParam[7]

	oReport:SetMeter(0)
	FeedTable(aParam, oReport)

   	If !lDetalhado
		oSection1:aCell[7]:Disable()
		oSection1:aCell[8]:Disable()
		oSection1:aCell[9]:Disable()
		oSection1:aCell[10]:Disable()
		oSection1:aCell[11]:Disable()
		oSection1:aCell[12]:Disable()
		oSection1:aCell[14]:Disable()
		oSection1:aCell[15]:Disable()
		oSection1:aCell[16]:Disable()
		oSection1:aCell[17]:Disable()
		oSection1:aCell[18]:Disable()
		oSection1:aCell[19]:Disable()
		oSection1:aCell[20]:Disable()
	EndIf

	dbSelectArea(cAlias)
	oReport:SetMeter((cAlias)->( LastRec() ))
	(cAlias)->( dbGoTop() )

	oSection1:Init()

	While !((cAlias)->( Eof() )	)
		oSection1:PrintLine()

		(cAlias)->( dbSkip() )
	EndDo

	oSection1:Finish()
Return

/*/--------------------------------------------------------------------------------------------------
CriaTable()
Generico.

@sample
CriaTable()

@author Felipe M.
@since 14/10/09
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CriaTable()

	// Criacao da tabela temporaria p/ imprimir o relat
	aTT := {{"GW_CDTPDC" , "C", TamSX3("GW1_CDTPDC" )[1], 0},;//Código Tipo Docto,
			{"GW_EMISDC" , "C", TamSX3("GW1_EMISDC" )[1], 0},;//Emisor,
			{"GW_SERDC"  , "C", TamSX3("GW1_SERDC"  )[1], 0},;//Serie,
			{"GW_NRDC"   , "C", TamSX3("GW1_NRDC"   )[1], 0},;//Numero DC,
			{"GW_DTEMIS" , "D", TamSX3("GW1_DTEMIS" )[1], 0},;//Data de Emissão,
			{"PREV_TOT"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Previsto Total,
			{"PREV_NOR"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Previsto Normal,
			{"PREV_RED"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Previsto Redesp,
			{"PREV_REE"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Previsto Reentr,
			{"PREV_DEV"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Previsto Devol,
			{"PREV_SER"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Previsto Serviço,
			{"PREV_COM"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Previsto Compl,
			{"REAL_TOT"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Real Total,
			{"REAL_NOR"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Real Normal,
			{"REAL_RED"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Real Redesp,
			{"REAL_REE"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Real Reentr,
			{"REAL_DEV"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Real Devol,
			{"REAL_SER"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Real Serviço,
			{"REAL_COM"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]},;   //Frete Real Compl,
			{"REAL_AUT"  , "N", TamSX3("GWI_VLFRET" )[1], TamSX3("GWI_VLFRET")[2]}}    //Frete Real Autonomo,

	cAlias := GFECriaTab({aTT, {"GW_CDTPDC+GW_EMISDC+GW_SERDC+GW_NRDC"}})
Return

/*/--------------------------------------------------------------------------------------------------
FeedTable()
Generico.

@Param = aParam
aParam[1] - Filial de
aParam[2] - Filial até
aParam[3] - Data Emis de
aParam[4] - Data Emis até
aParam[5] - Impost Recup
aParam[6] - Impost Auton

@sample
ReportPrint(oReport)

@author Felipe M.
@since 14/10/09
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function FeedTable(aParam, oReport)
	Local cAliasGW1
	Local cTransp

	Private aFrtPrev := Array(7), aFrtReal := Array(8)

	// Faz a busca dos documentos de carga de acordo com o filtro
	cAliasGW1 := GetNextAlias()
	cQuery := "SELECT * "
	cQuery += " FROM " + RetSQLName("GW1") + " GW1 "
	cQuery += " WHERE GW1.GW1_FILIAL >= '" + aParam[1]       + "' AND GW1.GW1_FILIAL <= '" + aParam[2]       + "'"
	cQuery += " AND	GW1.GW1_DTEMIS >= '" + DTOS(aParam[3]) + "' AND GW1.GW1_DTEMIS <= '" + DTOS(aParam[4]) + "'"
	cQuery += " AND GW1.D_E_L_E_T_ = ' '"
	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGW1, .F., .T.)

	dbSelectArea((cAliasGW1))
	(cAliasGW1)->( dbGoTop() )

	While !oReport:Cancel() .AND. !(cAliasGW1)->( Eof() )
		oReport:IncMeter()

		AFill(aFrtPrev, 0)
		AFill(aFrtReal, 0)

		dbSelectArea("GWM")
		dbSetOrder(2)
		dbSeek((cAliasGW1)->GW1_FILIAL + (cAliasGW1)->GW1_CDTPDC + (cAliasGW1)->GW1_EMISDC + (cAliasGW1)->GW1_SERDC + (cAliasGW1)->GW1_NRDC)
		While !GWM->( Eof() ) .AND. GWM->GWM_FILIAL == (cAliasGW1)->GW1_FILIAL ;
							  .AND.	GWM->GWM_CDTPDC == (cAliasGW1)->GW1_CDTPDC ;
							  .AND.	GWM->GWM_EMISDC == (cAliasGW1)->GW1_EMISDC ;
							  .AND.	GWM->GWM_SERDC  == (cAliasGW1)->GW1_SERDC ;
							  .AND.	GWM->GWM_NRDC   == (cAliasGW1)->GW1_NRDC

			/***********************************************
				Define o transportador do Rateio Contábil
			 ***********************************************/
			// Se estimativa, não entra no relatório
			If GWM->GWM_TPDOC == '4'
				GWM->(dbSkip())
				Loop
			EndIf

			// Cálculo
			If GWM->GWM_TPDOC == '1'
				dbSelectArea("GWF")
				dbSetOrder(1)
				dbSeek(GWM->GWM_FILIAL + GWM->GWM_NRDOC)
				cTransp := GWF->GWF_TRANSP
			EndIf

			// Documento de Frete
			If GWM->GWM_TPDOC == '2'
				cTransp := GWM->GWM_CDTRP
			EndIf

			// Contrato com Autônomo
			If GWM->GWM_TPDOC == '3'
				dbSelectArea("GW2")
				dbSetOrder(1)
				dbSeek(GWM->GWM_FILIAL + GWM->GWM_NRDOC)
				cTransp := GW2->GW2_CDPROP
			EndIf

			// Valida a existência do transportador/emitente
	    	DbSelectArea("GU3")
	    	dbSetOrder(1)
	    	If !dbSeek(xFilial("GU3")+cTransp)
	    		GWM->(dbSkip())
	    		Loop
	    	EndIf

			/***********************************************
				Busca os valores de Previsão/Realização
			 ***********************************************/
			// Cálculo de Frete - Despesas de Previsão
	   		If GWM->GWM_TPDOC == '1'
				FretePrevisto(	If(GU3->GU3_AUTON=='1',aParam[6],aParam[5]),; //Imposto Recuperáveis
								If(GU3->GU3_AUTON=='1',.T.,.F.) )   //Autonomo?
			EndIf

			// Documento de Frete - Realizado
			If GWM->GWM_TPDOC == '2'
	 			FreteReal(aParam[5] ,; //Impost Recup
	 					  .F.) //Autonomo?
	 		End

	 		// Contrato - Realizado
	 		If GWM->GWM_TPDOC == '3'
				FreteReal(aParam[6] ,;//Impost Auton
				          .T.) //Autonomo?
			EndIf

	    	GWM->(dbSkip())
	    EndDo

		RecLock((cAlias), .T.)
		(cAlias)->GW_CDTPDC := (cAliasGW1)->GW1_CDTPDC
		(cAlias)->GW_EMISDC := (cAliasGW1)->GW1_EMISDC
		(cAlias)->GW_SERDC  := (cAliasGW1)->GW1_SERDC
		(cAlias)->GW_NRDC   := (cAliasGW1)->GW1_NRDC
		(cAlias)->GW_DTEMIS := STOD((cAliasGW1)->GW1_DTEMIS)
		(cAlias)->PREV_NOR  := aFrtPrev[1]
		(cAlias)->PREV_RED  := aFrtPrev[6]
		(cAlias)->PREV_REE  := aFrtPrev[4]
		(cAlias)->PREV_DEV  := aFrtPrev[5]
		(cAlias)->PREV_SER  := aFrtPrev[7]
		(cAlias)->PREV_COM  := aFrtPrev[2] + aFrtPrev[3]
		(cAlias)->PREV_TOT  := aFrtPrev[1] + aFrtPrev[2] + aFrtPrev[3] + aFrtPrev[4] + aFrtPrev[5] + aFrtPrev[6] + aFrtPrev[7]
		(cAlias)->REAL_NOR  := aFrtReal[1]
		(cAlias)->REAL_RED  := aFrtReal[6]
		(cAlias)->REAL_REE  := aFrtReal[4]
		(cAlias)->REAL_DEV  := aFrtReal[5]
		(cAlias)->REAL_SER  := aFrtReal[7]
		(cAlias)->REAL_COM  := aFrtReal[2] + aFrtReal[3]
		(cAlias)->REAL_TOT  := aFrtReal[1] + aFrtReal[2] + aFrtReal[3] + aFrtReal[4] + aFrtReal[5] + aFrtReal[6] + aFrtReal[7]
		(cAlias)->REAL_AUT  := aFrtReal[8]
		MsUnlock()

		If (cAlias)->PREV_TOT == 0 .And. (cAlias)->REAL_TOT == 0 .And. (cAlias)->REAL_AUT == 0
			RecLock(cAlias,.F.)
				(cAlias)->(dbDelete())
			(cAlias)->(MsUnLock())
		EndIf

		(cAliasGW1)->(dbSkip())
	EndDo

   (cAliasGW1)->(dbCloseArea())
Return

//***********************************************
Static Function FretePrevisto(lImposto,lAutom)

	dbSelectArea("GWF")
	dbSetOrder(1)
	If dbSeek(GWM->GWM_FILIAL + GWM->GWM_NRDOC)
		If GWF->GWF_TPCALC != "8" // Frete de estimativa não entra no frete previsto
			If lAutom
				aFrtPrev[VAL(GWF->GWF_TPCALC)] += &(aCols[1])

				If lImposto
					aFrtPrev[VAL(GWF->GWF_TPCALC)] += 	&(aCols[2]) + ;
														&(aCols[3]) + ;
														&(aCols[4]) + ;
														&(aCols[5]) + ;
														Iif(Len(aCols) > 9, &(aCols[11]), &("0")) + ;
														&(aCols[6])
				EndIf
			Else
		    	aFrtPrev[VAL(GWF->GWF_TPCALC)] += &(aCols[1])   //Armazena na posição do array correspondente ao tipo de calculo

			    //Retira o ICMS
				If lImposto .AND. GWF->GWF_CRDICM == "1"
					aFrtPrev[VAL(GWF->GWF_TPCALC)] -= ( &(aCols[7]) + &(Iif(Len(aCols) > 9, aCols[10], "0")) )
				EndIf

				//Retira o PIS e COFINS
				If lImposto .AND. GWF->GWF_CRDPC == "1"
					aFrtPrev[VAL(GWF->GWF_TPCALC)] -= (&(aCols[8]) + &(aCols[9]) + &(Iif(Len(aCols) > 9, aCols[12], "0")))
				EndIf
			EndIf
		EndIf
	EndIf

Return

//***********************************************
Static Function FreteReal(lImposto,lAutom)

	If lAutom   //Frete realizado autonomo vai ser sempre na posição 9, sem direito ao Tipo de Frete, conforme regra de negocio.
		aFrtReal[8] += &(aCols[1])
		If lImposto
			aFrtReal[8] +=  &(aCols[2]) + ;
							&(aCols[3]) + ;
							&(aCols[4]) + ;
							&(aCols[5]) + ;
							&(Iif(Len(aCols) > 9, aCols[11], "0")) + ;
							&(aCols[6])
		EndIf

	Else
		DbSelectArea("GW3")
	   	dbSetOrder(1)
	   	If DbSeek(GWM->GWM_FILIAL + GWM->GWM_CDESP + GWM->GWM_CDTRP + GWM->GWM_SERDOC + GWM->GWM_NRDOC + DTOS(GWM->GWM_DTEMIS))//GW3_FILIAL+GW3_CDESP+GW3_EMISDF+GW3_SERDF+GW3_NRDF+DTOS(GW3_DTEMIS)

        	aFrtReal[VAL(GW3->GW3_TPDF)] += &(aCols[1]) //Armazena na posição do array correspondente ao tipo de calculo

        	//Retira o ICMS
	       	If lImposto .AND. GW3->GW3_CRDICM == "1"
	        	aFrtReal[VAL(GW3->GW3_TPDF)] -= ( &(aCols[7]) + &(Iif(Len(aCols) > 9, aCols[10], "0")) )
        	EndIf

        	//Retira o PIS e COFINS
        	If lImposto .AND. GW3->GW3_CRDPC == "1"
        		aFrtReal[VAL(GW3->GW3_TPDF)] -= (&(aCols[8]) + &(aCols[9]) + &(Iif(Len(aCols) > 9, aCols[12], "0")))
        	EndIf
		EndIf
	EndIf

Return

//Retorna o nome dos campos conforme o tipo de rateio
//***********************************************
Static Function GetRatCols()
	Local aCols := Array(9)

	If GFXCP2510("GWM_VLIBS") .And. GFXCP2510("GWM_VLIBM") .And. GFXCP2510("GWM_VLCBS")
		aCols := Array(12)
	EndIf

	Do Case
		Case cCriRat == '1'
			aCols[1] := 'GWM->GWM_VLFRET'
			aCols[2] := 'GWM->GWM_VLINEM'
			aCols[3] := 'GWM->GWM_VLIRRF'
			aCols[4] := 'GWM->GWM_VLSEST'
			aCols[5] := 'GWM->GWM_VLISS'
			aCols[6] := 'GWM->GWM_VLINAU'
			aCols[7] := 'GWM->GWM_VLICMS'
			aCols[8] := 'GWM->GWM_VLCOFI'
			aCols[9] := 'GWM->GWM_VLPIS'
			If GFXCP2510("GWM_VLIBS")
				aCols[10] := 'GWM->GWM_VLIBS'
			EndIf
			If GFXCP2510("GWM_VLIBM")
				aCols[11] := 'GWM->GWM_VLIBM'
			EndIf
			If GFXCP2510("GWM_VLCBS")
				aCols[12] := 'GWM->GWM_VLCBS'
			EndIf
		Case cCriRat == '2'
			aCols[1] := 'GWM->GWM_VLFRE1'
			aCols[2] := 'GWM->GWM_VLINE1'
			aCols[3] := 'GWM->GWM_VLIRR1'
			aCols[4] := 'GWM->GWM_VLSES1'
			aCols[5] := 'GWM->GWM_VLISS1'
			aCols[6] := 'GWM->GWM_VLINA1'
			aCols[7] := 'GWM->GWM_VLICM1'
			aCols[8] := 'GWM->GWM_VLCOF1'
			aCols[9] := 'GWM->GWM_VLPIS1'
			If GFXCP2510("GWM_VLIBS1")
				aCols[10] := 'GWM->GWM_VLIBS1'
			EndIf
			If GFXCP2510("GWM_VLIBM1")
				aCols[11] := 'GWM->GWM_VLIBM1'
			EndIf
			If GFXCP2510("GWM_VLCBS1")
				aCols[12] := 'GWM->GWM_VLCBS1'
			EndIf
		Case cCriRat == '3'
			aCols[1] := 'GWM->GWM_VLFRE3'
			aCols[2] := 'GWM->GWM_VLINE3'
			aCols[3] := 'GWM->GWM_VLIRR3'
			aCols[4] := 'GWM->GWM_VLSES3'
			aCols[5] := 'GWM->GWM_VLISS3'
			aCols[6] := 'GWM->GWM_VLINA3'
			aCols[7] := 'GWM->GWM_VLICM3'
			aCols[8] := 'GWM->GWM_VLCOF3'
			aCols[9] := 'GWM->GWM_VLPIS3'
			If GFXCP2510("GWM_VLIBS3")
				aCols[10] := 'GWM->GWM_VLIBS3'
			EndIf
			If GFXCP2510("GWM_VLIBM3")
				aCols[11] := 'GWM->GWM_VLIBM3'
			EndIf
			If GFXCP2510("GWM_VLCBS3")
				aCols[12] := 'GWM->GWM_VLCBS3'
			EndIf
		Case cCriRat == '4'
			aCols[1] := 'GWM->GWM_VLFRE2'
			aCols[2] := 'GWM->GWM_VLINE2'
			aCols[3] := 'GWM->GWM_VLIRR2'
			aCols[4] := 'GWM->GWM_VLSES2'
			aCols[5] := 'GWM->GWM_VLISS2'
			aCols[6] := 'GWM->GWM_VLINA2'
			aCols[7] := 'GWM->GWM_VLICM2'
			aCols[8] := 'GWM->GWM_VLCOF2'
			aCols[9] := 'GWM->GWM_VLPIS2'
			If GFXCP2510("GWM_VLIBS2")
				aCols[10] := 'GWM->GWM_VLIBS2'
			EndIf
			If GFXCP2510("GWM_VLIBM2")
				aCols[11] := 'GWM->GWM_VLIBM2'
			EndIf
			If GFXCP2510("GWM_VLCBS2")
				aCols[12] := 'GWM->GWM_VLCBS2'
			EndIf
	EndCase

Return aCols
