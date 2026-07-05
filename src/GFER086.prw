/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER086
Relatorio de Despesa de Frete por Classificação de Frete

@sample


@author Gustavo H. Baptista
@since 16/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER086()

	Local oReport
	Local aArea := GetArea()
	
	Private cDados
	Private cFilialIni
	Private cFilialFim
	Private dDataIni
	Private dDataFim
	Private cClassIni
	Private cClassFim
	Private cImpRecup
	Private cImpAuton
	Private cDctSemDesp
	Private cTipDesp
	Private cCritRat
	Private nVlIss 
	Private nVlIrrf
	Private nVlInau
	Private nVlInem 
	Private nVlSest
	Private nVlIBS 
	Private nVlIBM 
	Private nVlCBS 

	Private nVlFret
	Private nVlIcms 
	Private nVlPis
	Private nVlCofi
	Private cAliasRel, cAliasTot

	/*
  	aParam[1] - Filial de
	aParam[2] - Filial até
	aParam[3] - Data Emis de
	aParam[4] - Data Emis até
	aParam[5] - Classificação Ini
	aParam[6] - Classificação Fim
	aParam[7] - Impost Recup
	aParam[8] - Impost Auton
	aParam[9] - cDctSemDesp
	aParam[10] - Tipo Despesa
	aParam[11] - Critério de Rateio
	*/	

	If TRepInUse() // teste padrão 
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	GFEDelTab(cAliasRel)
	GFEDelTab(cAliasTot) 
	RestArea( aArea )	

Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CriaTabela
Cria tabelas auxiliares para a geração do relatório.

@sample

@author Gustavo Baptista
@since 16/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CriaTabela()

	// Criacao da tabela temporaria p/ imprimir o relat
	aTT :={{"CDCLFR"   ,"C",TamSX3("GW8_CDCLFR")[1]  ,0},;
	       {"DSCLFR"   ,"C",TamSX3("GW8_DSCLFR")[1]  ,0},;
	       {"PESO"     ,"N",TamSX3("GW8_PESOR" )[1]+3,TamSX3("GW8_PESOR" )[2]},;
	       {"VALOR"    ,"N",TamSX3("GW8_VALOR" )[1]+3,TamSX3("GW8_VALOR" )[2]},;
	       {"VOLUME"   ,"N",TamSX3("GW8_VOLUME")[1]+3,TamSX3("GW8_VOLUME")[2]},;
	       {"QTDE"     ,"N",TamSX3("GW8_QTDE"  )[1]+3,TamSX3("GW8_QTDE"  )[2]},;
	       {"DESPFRETE","N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	       {"FRPESO"   ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	       {"FRVAL"    ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	       {"FRVOL"    ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	       {"FRQTD"    ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	       {"QTDDC"    ,"N",7,0}}

	cAliasRel := GFECriaTab({aTT, {"CDCLFR"}})
	
	aTotalTable := {{"TPESO"  ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TVAL"   ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TVOL"   ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TQTD"   ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TFRETE" ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TFRPESO","N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TFRVAL" ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TFRVOL" ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TFRQTD" ,"N",TamSX3("GWM_VLFRET")[1]+3,TamSX3("GWM_VLFRET")[2]},;
	                {"TQTDDC" ,"N",7,0}}
	
	cAliasTot := GFECriaTab({aTotalTable, {"TPESO"}})
Return
/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Monta a estrutura do relatório

@sample

@author Gustavo Baptista
@since 16/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport	:= Nil
	Local aOrdem    := {}
	Local cTotal    := "Total"

	CriaTabela()
	
	oReport	:= TReport():New("GFER086","Relatório de Frete por Classificação de Frete","GFER086", {|oReport| ReportPrint(oReport)},"Despesa de Frete por Classificação de Frete")
	oReport:SetLandscape()   // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	//oReport:nFontBody	:= 10 // Define o tamanho da fonte.
	//oReport:nLineHeight	:= 50 // Define a altura da linha.    
	oReport:NDEVICE := 4     

	Pergunte("GFER086",.F.)

	Aadd( aOrdem, "Despesa de Frete por Classificação de Frete" )

	oSection1 := TRSection():New(oReport,"Despesa de Frete por Classificação de Frete",{"(cAliasRel)"},aOrdem) 
	oSection1:SetTotalInLine(.F.)

    TRCell():New(oSection1,"(cAliasRel)->CDCLFR"    ,(cAliasRel),"Classificação"          ,"@!"                 ,TamSX3("GW8_CDCLFR")[1]    ,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->DSCLFR"    ,(cAliasRel),"Descrição Classificação","@!"                 ,TamSX3("GW8_DSCLFR")[1]    ,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->QTDDC"     ,(cAliasRel),"Qtd. Documentos "       ,"@E 9999999"         ,7                          ,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->PESO"      ,(cAliasRel),"Peso Total"             ,"@E 99,999,999,999.99",TamSX3("GW8_PESOR" )[1]+3,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->VALOR"     ,(cAliasRel),"Valor Total"            ,"@E 99,999,999,999.99",TamSX3("GW8_VALOR" )[1]+3,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->VOLUME"    ,(cAliasRel),"Volume Total"           ,"@E 99,999,999,999.99",TamSX3("GW8_VOLUME")[1]+3,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->QTDE"      ,(cAliasRel),"Qtde Total"             ,"@E 99,999,999,999.99",TamSX3("GW8_QTDE"  )[1]+3,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->DESPFRETE" ,(cAliasRel),"Despesa Frete"          ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET")[1]+3,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->FRPESO"    ,(cAliasRel),"$ Frete x Peso"         ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET")[1]+3,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->FRVAL"     ,(cAliasRel),"% Frete x Valor"        ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET")[1]+3,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->FRVOL"     ,(cAliasRel),"$ Frete x Volume"       ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET")[1]+3,/*lPixel*/)
    TRCell():New(oSection1,"(cAliasRel)->FRQTD"     ,(cAliasRel),"$ Frete x Qtde"         ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET")[1]+3,/*lPixel*/)

    oSection2 := TRSection():New(oSection1,"Totalizadores",{"cAliasTot"},aOrdem) //  //"Totalizadores"
    oSection2:SetTotalInLine(.F.)
    oSection2:SetHeaderSection(.F.)
    TRCell():New(oSection2,"cTotal"              ,""         ,"Totalizadores"         ,"@!"              ,2                              ,/*lPixel*/,{||cTotal})
    TRCell():New(oSection2,"cTotal"              ,""         ,""                      ,"@!"              ,2                              ,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TQTDDC" ,(cAliasTot),""                      ,"@E 9999999"      ,7                              ,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TPESO"  ,(cAliasTot),"Total Peso"            ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TVAL"   ,(cAliasTot),"Total Valor"           ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TVOL"   ,(cAliasTot),"Total Volume"          ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TQTD"   ,(cAliasTot),"Total Quantidade"      ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TFRETE" ,(cAliasTot),"Total Frete"           ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TFRPESO",(cAliasTot),"Total $ Frete x Peso"  ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TFRVAL" ,(cAliasTot),"Total % Frete x Valor" ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TFRVOL" ,(cAliasTot),"Total $ Frete x Volume","@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)
    TRCell():New(oSection2,"(cAliasTot)->TFRQTD" ,(cAliasTot),"Total $ Frete x Qtde"  ,"@E 99,999,999,999.99",TamSX3("GWM_VLFRET" )[1]+3,/*lPixel*/)

Return(oReport)

Static Function ReportPrint(oReport)
	Local oSection1 := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	
	oReport:SetMeter(0)

	CarregaDados(oReport)
	                
	dbSelectArea((cAliasRel))
	oReport:SetMeter((cAliasRel)->( LastRec() ))
	(cAliasRel)->( dbGoTop() )
		
	oSection1:Init()
	
	While !((cAliasRel)->( Eof() )	)
		oSection1:PrintLine()

		(cAliasRel)->( dbSkip() )
	EndDo    
	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()
	
	oSection1:Finish()
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaDados
Realiza a busca dos dados da seleção e cria a tabela temporária de impressão
Generico.

@sample
CarregaDados()

@author Gustavo Baptista
@since 16/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaDados(oReport)
	Local  cAliasGW1
	Local  cAliasGWM
	Local  lFrete    :=0
	Local  cNRDCAnt  :=""
	Local  cClassAnt :=""

	cFilialIni  := MV_PAR01
	cFilialFim  := MV_PAR02
	dDataIni    := MV_PAR03
	dDataFim    := MV_PAR04
	cClassIni   := MV_PAR05
	cClassFim   := MV_PAR06
	cImpRecup   := MV_PAR07
	cImpAuton   := MV_PAR08
	cDctSemDesp := MV_PAR09
	cTipDesp    := MV_PAR10
	cCritRat    := MV_PAR11

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

	While !oReport:Cancel() .AND. !(cAliasGW1)->( Eof() )

		cAliasGWM := GetNextAlias()

		oReport:IncMeter()
		cQuery := "SELECT * FROM " + RetSQLName("GWM") + " GWM WHERE"
		cQuery += " GWM.GWM_FILIAL = '"+(cAliasGW1)->GW1_FILIAL+"' AND "
		cQuery += " GWM.GWM_CDTPDC = '"+(cAliasGW1)->GW1_CDTPDC+"' AND "
		cQuery += " GWM.GWM_EMISDC = '"+(cAliasGW1)->GW1_EMISDC+"' AND "
		cQuery += " GWM.GWM_SERDC  = '"+(cAliasGW1)->GW1_SERDC+"' AND "
		cQuery += " GWM.GWM_NRDC   = '"+(cAliasGW1)->GW1_NRDC+"' AND "

		//cTipDesp     ->Tipo de Despesa 
		if cTipDesp == 1
			//considerar os registros de Rateios de Frete de Cálculo de Frete (GWM_TPDOC = 1)
			cQuery += " GWM.GWM_TPDOC = '1' AND"
			cQuery += " GWM.D_E_L_E_T_ = ' '"		
			cQuery := ChangeQuery(cQuery)	
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGWM, .F., .T.)

			dbSelectArea((cAliasGWM))
			(cAliasGWM)->( dbGoTop() )
				
		elseif cTipDesp == 2
			//considerar os registros de Rateios de Frete de Documento de Frete ou Contrato com Autônomo (GWM_TPDOC = 2 ou 3)
			cQuery += " (GWM.GWM_TPDOC = '2' OR GWM.GWM_TPDOC = '3') AND "
			cQuery += " GWM.D_E_L_E_T_ = ' '"
			cQuery := ChangeQuery(cQuery)
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGWM, .F., .T.)
	
			dbSelectArea((cAliasGWM))
			(cAliasGWM)->( dbGoTop())

		else
			//verificar primeiramente se o Documento de Carga possui Rateios de Frete de Documento de Frete 
			//ou Contrato com Autônomo (GWM_TPDOC = 2 ou 3) usando-o em caso positivo
			// e em caso negativo usando usar os Rateios de Frete de Cálculo de Frete (GWM_TPDOC = 1). 
			cQuery += " (GWM.GWM_TPDOC = '2' OR GWM.GWM_TPDOC = '3') AND "
			cQuery += " GWM.D_E_L_E_T_ = ' '"
			cQuery := ChangeQuery(cQuery)
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGWM, .F., .T.)
	
			dbSelectArea((cAliasGWM))
			(cAliasGWM)->( dbGoTop() )
			
			if (cAliasGWM)->( Eof() )
			
				dbSelectArea((cAliasGWM))
				dbCloseArea()
				
				cAliasGWM :=GetNextAlias()
				cQuery := "SELECT * FROM " + RetSQLName("GWM") + " GWM WHERE"
				cQuery += " GWM.GWM_FILIAL = '"+(cAliasGW1)->GW1_FILIAL+"' AND "
				cQuery += " GWM.GWM_CDTPDC = '"+(cAliasGW1)->GW1_CDTPDC+"' AND "
				cQuery += " GWM.GWM_EMISDC = '"+(cAliasGW1)->GW1_EMISDC+"' AND "
				cQuery += " GWM.GWM_SERDC  = '"+(cAliasGW1)->GW1_SERDC+"' AND "
				cQuery += " GWM.GWM_NRDC   = '"+(cAliasGW1)->GW1_NRDC+"' AND "
				cQuery += " GWM.GWM_TPDOC = '1' AND"
				cQuery += " GWM.D_E_L_E_T_ = ' '"		
				cQuery := ChangeQuery(cQuery)	
				dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGWM, .F., .T.)

				dbSelectArea((cAliasGWM))
				(cAliasGWM)->( dbGoTop() )		

			EndIf

		Endif
		//Se Documentos despesa = 2- Desconsiderar E documento de carga não tiver rateio (GWM), então não deve processar		
		If (cAliasGWM)->( Eof() ) .AND. cDctSemDesp == 2
			(cAliasGW1)->(dbSkip())

			dbSelectArea((cAliasGWM))
			dbCloseArea()

			Loop
			
		ElseIf (cAliasGWM)->( Eof() ) .AND. cDctSemDesp == 1
			
			dbSelectArea("GW8")
			GW8->( dbSetOrder(2) )
			GW8->( dbSeek((cAliasGW1)->GW1_FILIAL + (cAliasGW1)->GW1_CDTPDC + (cAliasGW1)->GW1_EMISDC + (cAliasGW1)->GW1_SERDC + (cAliasGW1)->GW1_NRDC)  )
			While !GW8->( Eof() ) .And. GW8->GW8_FILIAL == (cAliasGW1)->GW1_FILIAL .And. GW8->GW8_CDTPDC == (cAliasGW1)->GW1_CDTPDC .And. ;
				  GW8->GW8_EMISDC == (cAliasGW1)->GW1_EMISDC .And. GW8->GW8_SERDC == (cAliasGW1)->GW1_SERDC .And. GW8->GW8_NRDC == (cAliasGW1)->GW1_NRDC
			
				If Len(AllTrim(cClassIni))>0 .AND. Len(AllTrim(cClassFim))>0 
	
					If GW8->GW8_CDCLFR < cClassIni .OR. GW8->GW8_CDCLFR > cClassFim
						(cAliasGWM)->(dbSkip())
						Loop
					EndIf
	
				EndIf			
				
				dbSelectArea((cAliasRel))
				dbSetOrder(1)
				If dbSeek(GW8->GW8_CDCLFR)
				    // Altera o registro corrente
				    RecLock((cAliasRel), .F.)
				Else
					// Cria um novo registro com o novo item
					RecLock((cAliasRel), .T.)
					(cAliasRel)->CDCLFR  := GW8->GW8_CDCLFR
					
					dbSelectArea("GUB")
					dbSetOrder(1)
					If dbSeek(xFilial("GUB")+GW8->GW8_CDCLFR)
						(cAliasRel)->DSCLFR 	:= GUB->GUB_DSCLFR
					EndIf
				EndIf
				
				If (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC <> cNRDCAnt .Or.;
				   GW8->GW8_CDCLFR <> cClassAnt
					
					(cAliasRel)->QTDDC++
					cNRDCAnt  := (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC
					cClassAnt := GW8->GW8_CDCLFR
					
				EndIf
					
				(cAliasRel)->PESO   += GW8->GW8_PESOR
				(cAliasRel)->VALOR  += GW8->GW8_VALOR
				(cAliasRel)->VOLUME += GW8->GW8_VOLUME
				(cAliasRel)->QTDE	+= GW8->GW8_QTDE
				
				GW8->( dbSkip() )
				
			EndDo
			
		Endif

		While !(cAliasGWM)->( Eof() ) .AND. ;
			   (cAliasGWM)->GWM_FILIAL == (cAliasGW1)->GW1_FILIAL .AND.	;
			   (cAliasGWM)->GWM_CDTPDC == (cAliasGW1)->GW1_CDTPDC .AND.	;
			   (cAliasGWM)->GWM_EMISDC == (cAliasGW1)->GW1_EMISDC .AND.	;
			   (cAliasGWM)->GWM_SERDC  == (cAliasGW1)->GW1_SERDC  .AND.	;
			   (cAliasGWM)->GWM_NRDC   == (cAliasGW1)->GW1_NRDC

			CarregaImpostos(cAliasGWM)

			dbSelectArea("GW8")
			dbSetOrder(2)
			If dbSeek(xFilial("GW8") + (cAliasGWM)->GWM_CDTPDC + (cAliasGWM)->GWM_EMISDC + (cAliasGWM)->GWM_SERDC + (cAliasGWM)->GWM_NRDC + (cAliasGWM)->GWM_SEQGW8)
				/***********************************************
					Verifica se o Item está dentro da faixa informada
				***********************************************/
				If Len(AllTrim(cClassIni))>0 .AND. Len(AllTrim(cClassFim))>0 
	
					If GW8->GW8_CDCLFR < cClassIni .OR. GW8->GW8_CDCLFR > cClassFim
						(cAliasGWM)->(dbSkip())
						Loop
					EndIf
	
				EndIf			
				
				dbSelectArea((cAliasRel))
				dbSetOrder(1)
				If dbSeek(GW8->GW8_CDCLFR)
				    // Altera o registro corrente
				    RecLock((cAliasRel), .F.)
				Else
					// Cria um novo registro com o novo item
					RecLock((cAliasRel), .T.)
					(cAliasRel)->CDCLFR  := GW8->GW8_CDCLFR
					
					dbSelectArea("GUB")
					dbSetOrder(1)
					If dbSeek(xFilial("GUB")+GW8->GW8_CDCLFR)
						(cAliasRel)->DSCLFR 	:= GUB->GUB_DSCLFR
					EndIf
				EndIf
				
				If (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC <> cNRDCAnt .Or.;
				   GW8->GW8_CDCLFR <> cClassAnt
					
					(cAliasRel)->QTDDC++
					cNRDCAnt  := (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC
					cClassAnt := GW8->GW8_CDCLFR
					
				EndIf
					
				(cAliasRel)->PESO   += GW8->GW8_PESOR
				(cAliasRel)->VALOR  += GW8->GW8_VALOR
				(cAliasRel)->VOLUME += GW8->GW8_VOLUME
				(cAliasRel)->QTDE	+= GW8->GW8_QTDE
				
				lFrete := nVlFret
			EndIf
			//cImpRecup    ->Impostos a recuperar
			if cImpRecup == 1
				//1=Descontar, deve-se subtrair o valor de ICMS (GWM_VLICMS), PIS (GWM_VLPIS) do valor do frete (GWM_VLFRET)
				// 									e COFINS (GWM_VLCOFI) do valor do frete (GWM_VLFRET)
				if AllTrim((cAliasGWM)->GWM_TPDOC) == '1' 
					lFrete := FretePrevisto(lFrete,cAliasGWM)
				elseif AllTrim((cAliasGWM)->GWM_TPDOC) == '2'
					lFrete := FreteRealizado(lFrete,cAliasGWM)				 
				EndIf
			endif

			//cImpAuton    ->Impostos dos Autônomos
			if cImpAuton == 1 .AND. AllTrim((cAliasGWM)->GWM_TPDOC) == '3'
				lFrete += nVlIss + nVlIrrf + nVlInau + nVlInem + nVlSest + nVlIBM
			EndIf			
			(cAliasRel)->DESPFRETE	+= lFrete

			MsUnlock()

			(cAliasGWM)->( dbSkip() )
		EndDo

		dbSelectArea((cAliasGWM))
		dbCloseArea()

		(cAliasGW1)->(dbSkip())
	EndDo
	
	//Atualiza a tabela com os valores que precisam ser calculados. 
	(cAliasRel)->( dbGoTop() )
	RecLock((cAliasTot), .T.)
	While !((cAliasRel)->( Eof() )	)
		RecLock((cAliasRel), .F.)
	    	(cAliasRel)->FRPESO	:= ((cAliasRel)->DESPFRETE / (cAliasRel)->PESO )
			(cAliasRel)->FRVAL	:= ((cAliasRel)->DESPFRETE / (cAliasRel)->VALOR ) * 100
			(cAliasRel)->FRVOL	:= ((cAliasRel)->DESPFRETE / (cAliasRel)->VOLUME )
			(cAliasRel)->FRQTD	:= ((cAliasRel)->DESPFRETE / (cAliasRel)->QTDE )
		MsUnlock()
		
		//Gera totalizadores
		(cAliasTot)->TPESO	+= (cAliasRel)->PESO
		(cAliasTot)->TVAL	+= (cAliasRel)->VALOR
		(cAliasTot)->TVOL	+= (cAliasRel)->VOLUME
		(cAliasTot)->TQTD	+= (cAliasRel)->QTDE
		
		(cAliasTot)->TFRETE	+= (cAliasRel)->DESPFRETE
	   	(cAliasTot)->TFRPESO+= (cAliasRel)->FRPESO
	   	(cAliasTot)->TFRVAL	+= (cAliasRel)->FRVAL
		(cAliasTot)->TFRVOL	+= (cAliasRel)->FRVOL
		(cAliasTot)->TFRQTD	+= (cAliasRel)->FRQTD
		(cAliasTot)->TQTDDC	+= (cAliasRel)->QTDDC

		(cAliasRel)->( dbSkip() )
	EndDo
	MsUnlock()	

	dbSelectArea((cAliasGW1))
	dbCloseArea()

Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} FretePrevisto
Efetua os descontos do frete previsto ( se for possível)

@sample

@author Gustavo H. Baptista
@since 16/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/

Static Function FretePrevisto(lFrete,cAliasGWM)
	// Busca o cálculo de frete relacionado ao Movimento Contábil
	dbSelectArea("GWF")	
	dbSetOrder(1)
	If dbSeek((cAliasGWM)->GWM_FILIAL + (cAliasGWM)->GWM_NRDOC)
		// Descontar impostos recuperáveis
		//Retira o ICMS
		If GWF->GWF_CRDICM == "1"   
			lFrete -= (nVlIcms + nVlIBS)
		EndIf
			
		//Retira o PIS e COFINS
		If GWF->GWF_CRDPC == "1"  
			lFrete -= (nVlCofi + nVlPis + nVlCBS)
		EndIf	    
	EndIf
Return lFrete


/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} FreteRealizado
Efetua os descontos do frete realizado ( se for possível)

@sample


@author Gustavo H. Baptista
@since 16/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function FreteRealizado(lFrete,cAliasGWM)
	// Busca o cálculo de frete relacionado ao Movimento Contábil
	dbSelectArea("GW3")
	dbSetOrder(1)
	If dbSeek((cAliasGWM)->GWM_FILIAL + (cAliasGWM)->GWM_CDESP + (cAliasGWM)->GWM_CDTRP + (cAliasGWM)->GWM_SERDOC + (cAliasGWM)->GWM_NRDOC + (cAliasGWM)->GWM_DTEMIS)             
		// Descontar impostos recuperáveis
		// Retira o ICMS
		If GW3->GW3_CRDICM == "1"
			lFrete -= (nVlIcms + nVlIBS)
		EndIf
		
		//Retira o PIS e COFINS
		If GW3->GW3_CRDPC == "1"
			lFrete -= (nVlCofi + nVlPis + nVlCBS)
		EndIf	    
	EndIf
Return lFrete

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaImpostos
Carrega os valores de impostos que devem ser considerados no cálculo do frete

@sample


@author Gustavo H. Baptista
@since 19/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaImpostos(cAliasGWM)

	if cCritRat == 1 //Peso Carga
		nVlFret	:= (cAliasGWM)->GWM_VLFRET
		nVlIss 	:= (cAliasGWM)->GWM_VLISS 
		nVlIrrf	:= (cAliasGWM)->GWM_VLIRRF
		nVlInau	:= (cAliasGWM)->GWM_VLINAU
		nVlInem	:= (cAliasGWM)->GWM_VLINEM 
		nVlSest	:= (cAliasGWM)->GWM_VLSEST
		nVlIcms	:= (cAliasGWM)->GWM_VLICMS 
		nVlCofi	:= (cAliasGWM)->GWM_VLCOFI
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS"), (cAliasGWM)->GWM_VLIBS, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM"), (cAliasGWM)->GWM_VLIBM, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS"), (cAliasGWM)->GWM_VLCBS, 0)
	ElseIf cCritRat == 2 //Valor Carga
		nVlFret	:= (cAliasGWM)->GWM_VLFRE1
		nVlIss 	:= (cAliasGWM)->GWM_VLISS1 
		nVlIrrf	:= (cAliasGWM)->GWM_VLIRR1 
		nVlInau	:= (cAliasGWM)->GWM_VLINA1 
		nVlInem	:= (cAliasGWM)->GWM_VLINE1 
		nVlSest	:= (cAliasGWM)->GWM_VLSES1
		nVlIcms	:= (cAliasGWM)->GWM_VLICM1 
		nVlCofi	:= (cAliasGWM)->GWM_VLCOF1
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS1
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS1"), (cAliasGWM)->GWM_VLIBS1, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM1"), (cAliasGWM)->GWM_VLIBM1, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS1"), (cAliasGWM)->GWM_VLCBS1, 0)
	ElseIf cCritRat == 3 //Quantidade Itens
		nVlFret := (cAliasGWM)->GWM_VLFRE2
		nVlIss 	:= (cAliasGWM)->GWM_VLISS2 
		nVlIrrf := (cAliasGWM)->GWM_VLIRR2 
		nVlInau := (cAliasGWM)->GWM_VLINA2 
		nVlInem := (cAliasGWM)->GWM_VLINE2 
		nVlSest := (cAliasGWM)->GWM_VLSES2
		nVlIcms := (cAliasGWM)->GWM_VLICM2 
		nVlCofi := (cAliasGWM)->GWM_VLCOF2
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS2
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS2"), (cAliasGWM)->GWM_VLIBS2, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM2"), (cAliasGWM)->GWM_VLIBM2, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS2"), (cAliasGWM)->GWM_VLCBS2, 0)
	ElseIf cCritRat == 4 //Volume Carga
		nVlFret := (cAliasGWM)->GWM_VLFRE3
		nVlIss 	:= (cAliasGWM)->GWM_VLISS3 
		nVlIrrf := (cAliasGWM)->GWM_VLIRR3 
		nVlInau := (cAliasGWM)->GWM_VLINA3 
		nVlInem := (cAliasGWM)->GWM_VLINE3 
		nVlSest := (cAliasGWM)->GWM_VLSES3
		nVlIcms := (cAliasGWM)->GWM_VLICM3 
		nVlCofi := (cAliasGWM)->GWM_VLCOF3
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS3
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS3"), (cAliasGWM)->GWM_VLIBS3, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM3"), (cAliasGWM)->GWM_VLIBM3, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS3"), (cAliasGWM)->GWM_VLCBS3, 0)
	EndIf
Return
