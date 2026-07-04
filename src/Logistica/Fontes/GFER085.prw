/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER085
Relatorio de Despesa de Frete por Transp, UF e Região

@sample

@author Gustavo H. Baptista
@since 16/04/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER085()
	Local oReport := Nil

	If TRepInUse() // teste padrão 
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
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
	aTTTransp:={{"CDTRP","C",TamSX3("GWM_CDTRP" )[1],0},;
				{"DSTRP","C",45,0}}
	
	cAliasTransp := GFECriaTab({aTTTransp, {"CDTRP"}})
	
	aTT :={ {"UFREGTRP","C",TamSX3("GW1_CDDEST" )[1],0},;
			{"UF","C",TamSX3("GW1_CDDEST" )[1],0},;
			{"REGREL","C",30,0},;
			{"CDTRP","C",TamSX3("GWM_CDTRP" )[1],0},;
			{"PESO", "N", 17, 5},;
			{"VALOR","N",14, 2},;
			{"VOLUME","N",17, 5},;
			{"QTDE","N",17, 5},;
			{"DESPFRETE","N",14, 2},;
			{"FRPESO","N",14, 2},;
			{"FRVAL","N",14, 2},;
			{"FRVOL","N",14, 2},;
			{"FRQTD","N",14, 2},;
			{"QTDDC","N",7,0}}
			
	cAliasRel := GFECriaTab({aTT, {"UF","UFREGTRP","CDTRP"}})

	aTotalTable := {{"CDTRP","C",TamSX3("GWM_CDTRP" )[1],0},;
					{"TPESO","N", 17, 5},;
					{"TVAL","N",14, 2},;
					{"TVOL","N",17, 5},;
					{"TQTD","N",17, 5},;
					{"TFRETE","N",14, 2},;
					{"TFRPESO","N",14, 2},;
					{"TFRVAL","N",14, 2},;
					{"TFRVOL","N",14, 2},;
					{"TFRQTD","N",14, 2},;
					{"TQTDDC","N",7,0}}

	cAliasTot 	:= GFECriaTab({aTotalTable, {"CDTRP"}})
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
	Local oReport  := TReport():New("GFER085","Relatório de Frete por Transportador, UF e Região","GFER085", {|oReport| ReportPrint(oReport)},"Despesa de Frete por Transp, UF e Região")
	Local aOrdem   := {}
	Local cTotparc :="Total : "
	
	oReport:SetLandscape()   // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	//oReport:nFontBody	:= 10 // Define o tamanho da fonte.
	//oReport:nLineHeight	:= 50 // Define a altura da linha.    
	oReport:NDEVICE := 4     

	Pergunte("GFER085",.F.)

	Aadd( aOrdem, "Despesa de Frete por Transp, UF e Região" )

	oSection1 := TRSection():New(oReport,"Despesa de Frete por Transp, UF e Região",{"(cAliasTransp)"},aOrdem) 
	oSection1:SetTotalInLine(.F.)
	oSection1:SetHeaderSection(.T.)

	TRCell():New(oSection1,"(cAliasTransp)->CDTRP" 	,"(cAliasTransp)","Transportador"	,"@!", TamSX3("GWM_CDTRP" )[1],/*lPixel*/, )
	TRCell():New(oSection1,"(cAliasTransp)->DSTRP"	,"(cAliasTransp)","" 		,"@!",45 ,/*lPixel*/, )

	oSection2 := TRSection():New(oSection1,"Despesa de Frete por Transp, UF e Região",{"(cAliasRel)"},aOrdem) //  //"Total Parcial"
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.T.)
	TRCell():New(oSection2,"(cAliasRel)->UF"     ,"(cAliasRel)","UF" 							,"@!", 7,/*lPixel*/, )
	TRCell():New(oSection2,"(cAliasRel)->REGREL" ,"(cAliasRel)","Região" 					,"@!", 30,/*lPixel*/, )
	TRCell():New(oSection2,"(cAliasRel)->QTDDC"  ,"(cAliasRel)","Qtd. Doctos"				,"@E 99999999999", 11,/*lPixel*/, )
	TRCell():New(oSection2,"(cAliasRel)->PESO"   ,"(cAliasRel)","Peso Total"				,"@E 99,999,999,999.99999", 20 /*TamSX3("GW8_PESOR")[1]+5+TamSX3("GW8_PESOR")[2]*/,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->VALOR"  ,"(cAliasRel)","Valor Total"				,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->VOLUME" ,"(cAliasRel)","Volume Total"				,"@E 99,999,999,999.99999", 20,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->QTDE"      ,"(cAliasRel)","Qtde Total"				,"@E 99,999,999,999.99999", 20,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->DESPFRETE" 	,"(cAliasRel)","Despesa Frete"		,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->FRPESO" 	,"(cAliasRel)","$ Frete x Peso"			,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->FRVAL" 	,"(cAliasRel)","% Frete x Valor"			,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->FRVOL" 	,"(cAliasRel)","$ Frete x Volume"			,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection2,"(cAliasRel)->FRQTD" 	,"(cAliasRel)","$ Frete x Quantidade"	,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")

	oSection3 := TRSection():New(oSection1,"Total ",{"cAliasTot"},aOrdem) //  //"Total Parcial"
	oSection3:SetTotalInLine(.F.)
	oSection3:SetHeaderSection(.F.)
	TRCell():New(oSection3,"cTotparc"    ,"","Total "   ,"@!",7,/*lPixel*/,{||cTotparc})
	TRCell():New(oSection3,""    ,"",""   ,"@!",30,/*lPixel*/,)
	TRCell():New(oSection3,"(cAliasTot)->TQTDDC" 	,"(cAliasTot)","Qtd. Doctos"				,"@E 99999999999", 11,/*lPixel*/, )
	TRCell():New(oSection3,"(cAliasTot)->TPESO" 	,"(cAliasTot)","Peso Total"				,"@E 99,999,999,999.99999", 20 /*TamSX3("GW8_PESOR" )[1]+5+TamSX3("GW8_PESOR" )[2]*/,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TVAL" 	,"(cAliasTot)","Valor Total"				,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TVOL" 	,"(cAliasTot)","Volume Total"				,"@E 99,999,999,999.99999", 20,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TQTD" 	,"(cAliasTot)","Qtde Total"				,"@E 99,999,999,999.99999", 20,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRETE" 	,"(cAliasTot)","Despesa Frete"			,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRPESO" 	,"(cAliasTot)","$ Frete x Peso"		,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRVAL" 	,"(cAliasTot)","% Frete x Valor"			,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRVOL" 	,"(cAliasTot)","$ Frete x Volume"			,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")
	TRCell():New(oSection3,"(cAliasTot)->TFRQTD" 	,"(cAliasTot)","$ Frete x Quantidade"	,"@E 99,999,999,999.99", 17,/*lPixel*/,,,,"RIGHT")

Return(oReport)

Static Function ReportPrint(oReport)
	Local oSection1      := oReport:Section(1)
	Local oSection2      := oReport:Section(1):Section(1)
	Local oSection3      := oReport:Section(1):Section(2)
	Local aArea          := GetArea()
	
	Private cDados       := ""
	Private cFilialIni   := ""
	Private cFilialFim   := ""
	Private dDataIni     := Nil
	Private dDataFim     := Nil
	Private cGrpTrp      := ""
	Private cTrpIni      := ""
	Private cTrpFim      := ""
	Private cImpRecup    := ""
	Private cImpAuton    := ""
	Private cDctSemDesp  := ""
	Private cTipDesp     := ""
	Private aTotais[10]
	Private cSeek        := ""
	Private cCritRat     := ""
	Private nVlFret      := 0
	Private nVlIss       := 0
	Private nVlIrrf      := 0
	Private nVlInau      := 0
	Private nVlInem      := 0
	Private nVlSest      := 0
	Private nVlIcms      := 0
	Private nVlCofi      := 0
	Private nVlPis       := 0
	Private nVlIBS       := 0
	Private nVlIBM       := 0
	Private nVlCBS       := 0

	Private cAliasRel    := ""
	Private cAliasTot    := ""
	Private cAliasTransp := ""
	
	oReport:SetMeter(0)

	aTotais[1] := 0
	aTotais[2] := 0
	aTotais[3] := 0
	aTotais[4] := 0	
	aTotais[5] := 0
	aTotais[6] := 0
	aTotais[7] := 0
	aTotais[8] := 0
	aTotais[9] := 0
	aTotais[10] := 0

	CriaTabela()

	CarregaDados(oReport)

	dbSelectArea((cAliasTransp))
	(cAliasTransp)->( dbGoTop() )
	oReport:SetMeter((cAliasRel)->( LastRec() ))

	Do While ((cAliasTransp)->(!Eof())) // Para cada Transportador
		oSection1:Init()
		oSection1:PrintLine()
		oSection1:Finish()
		oSection2:Init()
		dbSelectArea((cAliasRel))
		dbSetOrder(3)
		If dbSeek((cAliasTransp)->CDTRP)
			While (cAliasRel)->(!Eof()) .And. (cAliasRel)->CDTRP == (cAliasTransp)->CDTRP // Imprimir todas as Regioes
				oSection2:PrintLine()	
				
				(cAliasRel)->(dbSkip())
			EndDo
		EndIf
		oSection2:Finish()
		
		oSection3:Init()
		dbSelectArea((cAliasTot))
		dbSetOrder(1)
		If dbSeek((cAliasTransp)->CDTRP)
			Do While (cAliasTot)->(!Eof()).And. (cAliasTot)->CDTRP == (cAliasTransp)->CDTRP // Por Fim imprime o total do transportador (total parcial)
				oSection3:PrintLine()
				
				(cAliasTot)->(dbSkip())
			EndDo
		EndIf
		oSection3:Finish()

		(cAliasTransp)->( dbSkip() )
	EndDo 

	GFEDelTab(cAliasTot)
	GFEDelTab(cAliasRel)  
	GFEDelTab(cAliasTransp)
	RestArea( aArea )	

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
	Local cAliasGW1
	Local cAliasGWM
	Local lFrete   := 0
	Local cNRDCAnt := ""
	Local cRegiao  := ""
	 
	cFilialIni	:= MV_PAR01
	cFilialFim	:= MV_PAR02
	dDataIni  	:= MV_PAR03
	dDataFim  	:= MV_PAR04
	cTrpIni   	:= MV_PAR05
	cTrpFim		:= MV_PAR06
	cGrpTrp     := MV_PAR07
	cImpRecup 	:= MV_PAR08
	cImpAuton 	:= MV_PAR09
	cDctSemDesp	:= MV_PAR10
	cTipDesp   	:= MV_PAR11
	cCritRat	:= MV_PAR12	

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
		cQuery += " GWM.GWM_CDTRP  >= '"+cTrpIni+"' AND "
		cQuery += " GWM.GWM_CDTRP  <= '"+cTrpFim+"' AND "
		
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
				cQuery += " GWM.GWM_CDTRP  >= '"+cTrpIni+"' AND "
				cQuery += " GWM.GWM_CDTRP  <= '"+cTrpFim+"' AND "
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
			
			dbSelectArea("GU3")
			GU3->( dbSetOrder(1) )
			If GU3->( dbSeek(xFilial("GU3") + (cAliasGW1)->GW1_CDDEST) )
				
				dbSelectArea("GU7")
				GU7->( dbSetOrder(1) )
				If GU7->( dbSeek(xFilial("GU7") + GU3->GU3_NRCID) )
					
					dbSelectArea("GWU")
					GWU->( dbSetOrder(1) )
					GWU->( dbSeek((cAliasGW1)->GW1_FILIAL + (cAliasGW1)->GW1_CDTPDC + (cAliasGW1)->GW1_EMISDC + (cAliasGW1)->GW1_SERDC + (cAliasGW1)->GW1_NRDC) )
					While !GWU->( Eof() ) .And. GWU->GWU_FILIAL == (cAliasGW1)->GW1_FILIAL .And. GWU->GWU_CDTPDC == (cAliasGW1)->GW1_CDTPDC .And. ;
						  GWU->GWU_EMISDC == (cAliasGW1)->GW1_EMISDC .And. GWU->GWU_SERDC == (cAliasGW1)->GW1_SERDC .And. ;
						  GWU->GWU_NRDC == (cAliasGW1)->GW1_NRDC
												
						dbSelectArea("GU3")
						dbSetOrder(1)
						If dbSeek(xFilial("GU3") + GWU->GWU_CDTRP)
							
							If !Empty(cGrpTrp) .And. GU3->GU3_CDGRGL <> cGrpTrp
								GWU->( dbSkip() )
								Loop
							EndIf
							
							dbSelectArea((cAliasTransp))
							dbSetOrder(1)
							If !dbSeek(GU3->GU3_CDEMIT)
								// Cria um novo registro com o novo item
								RecLock((cAliasTransp), .T.)
									(cAliasTransp)->CDTRP := GU3->GU3_CDEMIT
									(cAliasTransp)->DSTRP := GU3->GU3_NMEMIT
								MsUnlock()
							EndIf
				
							// Cria um novo registro com o novo região
							dbSelectArea((cAliasRel))
							dbSetOrder(2)
							
							If Len(Alltrim(GU7->GU7_REGREL)) > 0 
								cRegiao := Alltrim(GU7->GU7_REGREL)
							Else
								cRegiao := "Sem Região"
							EndIf			
							
							cSeek:= AllTrim(GU7->GU7_CDUF)+Alltrim(cRegiao)+Alltrim(GU3->GU3_CDEMIT)
							If dbSeek(cSeek,.T.)
							    // Altera o registro corrente
							    RecLock((cAliasRel), .F.)
							Else
								// Cria um novo registro com o novo item
								RecLock((cAliasRel), .T.)
								(cAliasRel)->UF   	  := GU7->GU7_CDUF
								(cAliasRel)->CDTRP    := GU3->GU3_CDEMIT
								(cAliasRel)->REGREL   := cRegiao
								(cAliasRel)->UFREGTRP := AllTrim(GU7->GU7_CDUF)+Alltrim(cRegiao)+Alltrim(GU3->GU3_CDEMIT)
							EndIf
							
							If (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC <> cNRDCAnt
								(cAliasRel)->QTDDC++
								cNRDCAnt := (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC
							EndIf
							
							dbSelectArea("GW8")
							dbSetOrder(2)
							dbSeek((cAliasGW1)->GW1_FILIAL + (cAliasGW1)->GW1_CDTPDC + (cAliasGW1)->GW1_EMISDC + (cAliasGW1)->GW1_SERDC + (cAliasGW1)->GW1_NRDC)
					        While !GW8->( Eof() ) .And. GW8->GW8_FILIAL == (cAliasGW1)->GW1_FILIAL .And. GW8->GW8_CDTPDC == (cAliasGW1)->GW1_CDTPDC .And. ;
					        	  GW8->GW8_EMISDC == (cAliasGW1)->GW1_EMISDC .And. GW8->GW8_SERDC == (cAliasGW1)->GW1_SERDC .And. ;
					        	  GW8->GW8_NRDC == (cAliasGW1)->GW1_NRDC
					        
								(cAliasRel)->PESO   += GW8->GW8_PESOR
								(cAliasRel)->VALOR  += GW8->GW8_VALOR
								(cAliasRel)->VOLUME += GW8->GW8_VOLUME
								(cAliasRel)->QTDE	   += GW8->GW8_QTDE
								
								GW8->( dbSkip() )
								
							EndDo
							
							MsUnlock()
						
						EndIf
							
						GWU->( dbSkip() )
						
					EndDo
					
				EndIf
				
			EndIf
			
		EndIf

		//Carrega os dados de UF e Região
		dbSelectArea("GU3")
		dbSetOrder(1)
		If dbSeek(xFilial("GU3")+ (cAliasGW1)->GW1_CDDEST)
			dbSelectArea("GU7")
			dbSetOrder(1)
			dbSeek(xFilial("GU7")+ GU3->GU3_NRCID)
		EndIf

		While !(cAliasGWM)->( Eof() ) .AND.	;
			   (cAliasGWM)->GWM_FILIAL == (cAliasGW1)->GW1_FILIAL .AND.	;
			   (cAliasGWM)->GWM_CDTPDC == (cAliasGW1)->GW1_CDTPDC .AND.	;
			   (cAliasGWM)->GWM_EMISDC == (cAliasGW1)->GW1_EMISDC .AND.	;
			   (cAliasGWM)->GWM_SERDC  == (cAliasGW1)->GW1_SERDC  .AND.	;
			   (cAliasGWM)->GWM_NRDC   == (cAliasGW1)->GW1_NRDC
			
			CarregaImpostos(cAliasGWM)

			dbSelectArea("GU3")
			dbSetOrder(1)
			dbSeek(xFilial("GU3")+ (cAliasGWM)->GWM_CDTRP)

			//Se o Grupo não for igual ao informado, então não deve processar
			If !Empty(cGrpTrp) .And. GU3->GU3_CDGRGL <> cGrpTrp
				(cAliasGWM)->( dbSkip() )
				Loop
			EndIf

			//Cria um novo registro de Transportador
			dbSelectArea((cAliasTransp))
			dbSetOrder(1)
			If !dbSeek((cAliasGWM)->GWM_CDTRP)
				// Cria um novo registro com o novo item
				RecLock((cAliasTransp), .T.)
				(cAliasTransp)->CDTRP := (cAliasGWM)->GWM_CDTRP
				(cAliasTransp)->DSTRP := GU3->GU3_NMEMIT
				MsUnlock()
			EndIf

			// Cria um novo registro com o novo região
			dbSelectArea((cAliasRel))
			dbSetOrder(2)
			
			If Len(Alltrim(GU7->GU7_REGREL)) > 0 
				cRegiao := Alltrim(GU7->GU7_REGREL)
			Else
				cRegiao := "Sem Região"
			EndIf			
			
			cSeek:= AllTrim(GU7->GU7_CDUF)+Alltrim(cRegiao)+Alltrim((cAliasGWM)->GWM_CDTRP)
			If dbSeek(cSeek,.T.)
			    // Altera o registro corrente
			    RecLock((cAliasRel), .F.)
			Else
				// Cria um novo registro com o novo item
				RecLock((cAliasRel), .T.)
				(cAliasRel)->UF   	  := GU7->GU7_CDUF
				(cAliasRel)->CDTRP    := (cAliasGWM)->GWM_CDTRP
				(cAliasRel)->REGREL   := cRegiao
				(cAliasRel)->UFREGTRP := AllTrim(GU7->GU7_CDUF)+Alltrim(cRegiao)+Alltrim((cAliasGWM)->GWM_CDTRP)
			EndIf
			
			If (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC <> cNRDCAnt
				(cAliasRel)->QTDDC++
				cNRDCAnt := (cAliasGW1)->GW1_FILIAL+(cAliasGW1)->GW1_CDTPDC+(cAliasGW1)->GW1_EMISDC+(cAliasGW1)->GW1_SERDC+(cAliasGW1)->GW1_NRDC
			EndIf

			lFrete := nVlFret

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

			dbSelectArea("GW8")
			dbSetOrder(2)
			if dbSeek((cAliasGWM)->GWM_FILIAL+(cAliasGWM)->GWM_CDTPDC+(cAliasGWM)->GWM_EMISDC+(cAliasGWM)->GWM_SERDC+(cAliasGWM)->GWM_NRDC+(cAliasGWM)->GWM_SEQGW8)
	
				(cAliasRel)->PESO   += GW8->GW8_PESOR
				(cAliasRel)->VALOR  += GW8->GW8_VALOR
				(cAliasRel)->VOLUME	+= GW8->GW8_VOLUME
				(cAliasRel)->QTDE	+= GW8->GW8_QTDE
				
			EndIf
			
			MsUnlock()
			(cAliasGWM)->( dbSkip() )
		EndDo	
		
		dbSelectArea((cAliasGWM))
		dbCloseArea()
		
		(cAliasGW1)->(dbSkip())
	EndDo
	
	//Atualiza a tabela com os valores que precisam ser calculados. 
	(cAliasRel)->( dbGoTop() )
	While !((cAliasRel)->( Eof() )	)
		RecLock((cAliasRel), .F.)
	    	(cAliasRel)->FRPESO	:= ((cAliasRel)->DESPFRETE / (cAliasRel)->PESO )
			(cAliasRel)->FRVAL	:= ((cAliasRel)->DESPFRETE / (cAliasRel)->VALOR ) * 100
			(cAliasRel)->FRVOL	:= ((cAliasRel)->DESPFRETE / (cAliasRel)->VOLUME )
			(cAliasRel)->FRQTD	:= ((cAliasRel)->DESPFRETE / (cAliasRel)->QTDE )
		MsUnlock()

		dbselectArea(cAliasTot)
		dbSetOrder(1)
		if dbSeek((cAliasRel)->CDTRP)
			RecLock((cAliasTot),.F.)
		else
			RecLock((cAliasTot),.T.)
			(cAliasTot)->CDTRP := (cAliasRel)->CDTRP
		endif

		//Gera totalizadores finais
		(cAliasTot)->TPESO	+= (cAliasRel)->PESO
		(cAliasTot)->TVAL	+= (cAliasRel)->VALOR
		(cAliasTot)->TVOL	+= (cAliasRel)->VOLUME
		(cAliasTot)->TQTD	+= (cAliasRel)->QTDE
		(cAliasTot)->TFRETE	+= (cAliasRel)->DESPFRETE
		(cAliasTot)->TQTDDC	+= (cAliasRel)->QTDDC

		//Totalizadores para mostrar a média do total
		(cAliasTot)->TFRPESO	:= ((cAliasTot)->TFRETE / (cAliasTot)->TPESO)
		(cAliasTot)->TFRVAL		:= ((cAliasTot)->TFRETE / (cAliasTot)->TVAL) * 100
		(cAliasTot)->TFRVOL		:= ((cAliasTot)->TFRETE / (cAliasTot)->TVOL)
		(cAliasTot)->TFRQTD		:= ((cAliasTot)->TFRETE / (cAliasTot)->TQTD)

		MsUnlock()

		(cAliasRel)->( dbSkip() )
	EndDo

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
			lFrete -= nVlIcms + nVlIBS
		EndIf

		//Retira o PIS e COFINS
		If GWF->GWF_CRDPC == "1"
			lFrete -= nVlCofi + nVlPis + nVlCBS
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
	If dbSeek((cAliasGWM)->GWM_FILIAL +(cAliasGWM)->GWM_CDESP +(cAliasGWM)->GWM_CDTRP +(cAliasGWM)->GWM_SERDOC +(cAliasGWM)->GWM_NRDOC +(cAliasGWM)->GWM_DTEMIS)             
		// Descontar impostos recuperáveis
		// Retira o ICMS
		If GW3->GW3_CRDICM == "1"
			lFrete -= nVlIcms + nVlIBS
		EndIf
		
		//Retira o PIS e COFINS
		If GW3->GW3_CRDPC == "1"
			lFrete -= nVlCofi + nVlPis + nVlCBS
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
		nVlFret := (cAliasGWM)->GWM_VLFRET
		nVlIss 	:= (cAliasGWM)->GWM_VLISS 
		nVlIrrf := (cAliasGWM)->GWM_VLIRRF
		nVlInau := (cAliasGWM)->GWM_VLINAU
		nVlInem := (cAliasGWM)->GWM_VLINEM 
		nVlSest := (cAliasGWM)->GWM_VLSEST
		nVlIcms := (cAliasGWM)->GWM_VLICMS 
		nVlCofi := (cAliasGWM)->GWM_VLCOFI
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS"), (cAliasGWM)->GWM_VLIBS, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM"), (cAliasGWM)->GWM_VLIBM, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS"), (cAliasGWM)->GWM_VLCBS, 0)
	ElseIf cCritRat == 2 //Valor Carga
		nVlFret := (cAliasGWM)->GWM_VLFRE1
		nVlIss 	:= (cAliasGWM)->GWM_VLISS1 
		nVlIrrf := (cAliasGWM)->GWM_VLIRR1 
		nVlInau := (cAliasGWM)->GWM_VLINA1 
		nVlInem := (cAliasGWM)->GWM_VLINE1 
		nVlSest := (cAliasGWM)->GWM_VLSES1
		nVlIcms := (cAliasGWM)->GWM_VLICM1 
		nVlCofi := (cAliasGWM)->GWM_VLCOF1
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
		nVlFret	:= (cAliasGWM)->GWM_VLFRE3
		nVlIss 	:= (cAliasGWM)->GWM_VLISS3 
		nVlIrrf	:= (cAliasGWM)->GWM_VLIRR3 
		nVlInau	:= (cAliasGWM)->GWM_VLINA3 
		nVlInem	:= (cAliasGWM)->GWM_VLINE3 
		nVlSest	:= (cAliasGWM)->GWM_VLSES3
		nVlIcms	:= (cAliasGWM)->GWM_VLICM3 
		nVlCofi	:= (cAliasGWM)->GWM_VLCOF3
		nVlPis 	:= (cAliasGWM)->GWM_VLPIS3
		nVlIBS  := Iif(GFXCP2510("GWM_VLIBS3"), (cAliasGWM)->GWM_VLIBS3, 0)
		nVlIBM  := Iif(GFXCP2510("GWM_VLIBM3"), (cAliasGWM)->GWM_VLIBM3, 0)
		nVlCBS  := Iif(GFXCP2510("GWM_VLCBS3"), (cAliasGWM)->GWM_VLCBS3, 0)
	EndIf
Return
