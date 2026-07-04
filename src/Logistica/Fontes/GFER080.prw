/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFERBI01
Relatorio de Freight Expenses Fact
Generico.

@sample
GFER040()

@author Felipe M.
@since 21/12/11
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER080()
	Local oReport   //objeto que contem o relatorio
	Local aArea := GetArea()

	Private nFreteCalc 	:= 0 
	Private nFretPrTon	:= 0 
	Private nFretPrVl 	:= 0 
	Private nFretReal 	:= 0 
	Private nFreRetTn 	:= 0 
	Private nFretReVl 	:= 0 
	Private nPrevReal 	:= 0
	Private oTmpTabDf   := Nil
	Private aCacheGV3 	:= LoadGV3()
	Private aCacheGV5 	:= LoadGV5()

	cAliasDf := U_GFE80TtDF()

	If TRepInUse() // teste padrão 
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf 

	GFEDelTab(cAliasDf)  

	RestArea( aArea )
Return     

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Relatorio de -------------------------------
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
	Local oFieldHide

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
	oReport:= TReport():New("GFER080","Freight Expenses Fact","GFER080", {|oReport| ReportPrint(oReport)},"BI - Freight Expenses Fact.")  
	oReport:SetLandscape()   // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	oReport:nFontBody	:= 10 // Define o tamanho da fonte.
	oReport:nLineHeight	:= 50 // Define a altura da linha.    
	oReport:NDEVICE := 4     

	Pergunte("GFER080",.F.)

	Aadd(aOrdem, "Freight Expenses Fact" ) // "Sequência" //"Codigo"

	oSection1 := TRSection():New(oReport,"Freight Expenses Fact",{"(cAliasDf)"},aOrdem) 
	oSection1:SetLineStyle() //Define a impressao da secao em linha
	oSection1:SetTotalInLine(.F.)

	TRCell():New(oSection1,"(cAliasDf)->FILIAL"      ,"(cAliasDf)","Filial"                ,"@!",02,/*lPixel*/,{|| If( "_" $ (cAliasDf)->FILIAL  ,"",(cAliasDf)->FILIAL  ) })
	TRCell():New(oSection1,"(cAliasDf)->GW1_NRDC"    ,"(cAliasDf)","Numero Doc"            ,"@!",16,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GW1_NRDC      ,"",(cAliasDf)->GW1_NRDC   ) })
	TRCell():New(oSection1,"(cAliasDf)->GW1_SERDC"   ,"(cAliasDf)","Serie"                 ,"@!",05,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GW1_SERDC  ,"",(cAliasDf)->GW1_SERDC  ) })
	TRCell():New(oSection1,"(cAliasDf)->ROMANEIO"    ,"(cAliasDf)","Nm Romaneio"           ,"@!",16,/*lPixel*/,{|| If( "_" $ (cAliasDf)->ROMANEIO      ,"",(cAliasDf)->ROMANEIO   ) })
	TRCell():New(oSection1,"(cAliasDf)->GW_NMEMI"    ,"(cAliasDf)","Nm Transportador"      ,"@!",50,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GW_NMEMI      ,"",(cAliasDf)->GW_NMEMI   ) })
	TRCell():New(oSection1,"(cAliasDf)->GV5_DSTPDC"  ,"(cAliasDf)","Des Tipo de Doc"       ,"@!",20,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GV5_DSTPDC    ,"",(cAliasDf)->GV5_DSTPDC    ) })
	TRCell():New(oSection1,"(cAliasDf)->GW1_DTEMIS"  ,"(cAliasDf)","Data de Emissão"		,"@!",12,/*lPixel*/,{|| If( (cAliasDf)->GW1_DTEMIS == CtoD("01/01/1800") ,"", (cAliasDf)->GW1_DTEMIS ) })
	TRCell():New(oSection1,"(cAliasDf)->CLASSFRETE"  ,"(cAliasDf)","Class de Frete"			,"@!",04,/*lPixel*/,{|| If( "_" $ (cAliasDf)->CLASSFRETE 	,"",(cAliasDf)->CLASSFRETE 	) })
	TRCell():New(oSection1,"(cAliasDf)->GUB_DSCLFR"  ,"(cAliasDf)","Des Class de Frete"		,"@!",20,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GUB_DSCLFR 	,"",(cAliasDf)->GUB_DSCLFR 	) })
	TRCell():New(oSection1,"(cAliasDf)->GWN_CDTPOP"  ,"(cAliasDf)","Tipo de Operação"		,"@!",10,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GWN_CDTPOP 	,"",(cAliasDf)->GWN_CDTPOP 	) })
	TRCell():New(oSection1,"(cAliasDf)->GV4_DSTPOP"  ,"(cAliasDf)","Des Tipo de Operação"	,"@!",20,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GV4_DSTPOP 	,"",(cAliasDf)->GV4_DSTPOP 	) })

	oFieldHide := TRCell():New(oSection1, "(cAliasDf)->LACRE" , "(cAliasDf)", "Nr Lacre"          , "@!",TamSX3("GWN_LACRE" )[1],.T.,{||If( "_" $ (cAliasDf)->LACRE      ,"",(cAliasDf)->LACRE   )})
	oFieldHide:lUserEnabled := .F.

	TRCell():New(oSection1,"(cAliasDf)->GV5_SENTID"  ,"(cAliasDf)","Sentido"				,"@!",15,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GV5_SENTID 	,"",(cAliasDf)->GV5_SENTID 	) })
	TRCell():New(oSection1,"cTpValor"                ,""          ,"Tipo Valor"           	,"@!",15,/*lPixel*/,{|| cTpValor := GFEFldInfo("GV5_FRCTB",Posicione("GV5",1,xFilial("GV5")+(cAliasDf)->TIPO_DC,"GV5_FRCTB"),2) } )
	TRCell():New(oSection1,"(cAliasDf)->GW1_NMREM"   ,"(cAliasDf)","Nome Remetente"			,"@!",50,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GW1_NMREM 	,"",(cAliasDf)->GW1_NMREM 	) })
	TRCell():New(oSection1,"cCidRem"                 ,""          ,"Cid.Rem."           	,"@!",50,/*lPixel*/,{|| cCidRem := Posicione("GU7", 1, xFilial("GU7") + posicione("GU3",1,xFilial("GU3")+(cAliasDf)->REMETENTE,"GU3_NRCID"), "GU7_NMCID") } )
	TRCell():New(oSection1,"cUfRem"                  ,""          ,"UF.Rem."             	,"@!",02,/*lPixel*/,{|| cUFRem  := Posicione("GU7", 1, xFilial("GU7") + posicione("GU3",1,xFilial("GU3")+(cAliasDf)->REMETENTE,"GU3_NRCID"), "GU7_CDUF")  } )
	TRCell():New(oSection1,"(cAliasDf)->GW1_NMDEST"  ,"(cAliasDf)","Nome Destinatario"		,"@!",50,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GW1_NMDEST 	,"",(cAliasDf)->GW1_NMDEST 	) })
	TRCell():New(oSection1,"cCidDes"                 ,""          ,"Cid.Des."           	,"@!",50,/*lPixel*/,{|| cCidDes := Posicione("GU7", 1, xFilial("GU7") + posicione("GU3",1,xFilial("GU3")+(cAliasDf)->DESTINATA,"GU3_NRCID"), "GU7_NMCID") } )
	TRCell():New(oSection1,"cUfDes"                  ,""          ,"UF.Des."             	,"@!",02,/*lPixel*/,{|| cUFDes  := Posicione("GU7", 1, xFilial("GU7") + posicione("GU3",1,xFilial("GU3")+(cAliasDf)->DESTINATA,"GU3_NRCID"), "GU7_CDUF")  } )
	TRCell():New(oSection1,"cRegDes"                 ,""          ,"Região Geren. Des."             	,"@!",20,/*lPixel*/,{|| cRegDes := Posicione("GU7", 1, xFilial("GU7") + posicione("GU3",1,xFilial("GU3")+(cAliasDf)->DESTINATA,"GU3_NRCID"), "GU7_REGREL")  } )
	TRCell():New(oSection1,"(cAliasDf)->GW1_REPRES"  ,"(cAliasDf)","Repres."                ,"@!",20,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GW1_REPRES 	,"",(cAliasDf)->GW1_REPRES 	) })
	TRCell():New(oSection1,"(cAliasDf)->REGIAOCOM"	 ,"(cAliasDf)","Região Comercial"		,"@!",12,/*lPixel*/,{|| If( "_" $ (cAliasDf)->REGIAOCOM 	,"",(cAliasDf)->REGIAOCOM 	) })
	TRCell():New(oSection1,"(cAliasDf)->GW1_USO"     ,"(cAliasDf)","Uso"					,"@!",15,/*lPixel*/,{|| If( "_" $ (cAliasDf)->GW1_USO 		,"",(cAliasDf)->GW1_USO 	) })
	TRCell():New(oSection1,"(cAliasDf)->ITEM"    	 ,"(cAliasDf)","Item"					,"@!",16,/*lPixel*/,{|| If( "_" $ (cAliasDf)->ITEM 		,"",(cAliasDf)->ITEM 	) })
	TRCell():New(oSection1,"cDesItem"                ,""          ,"Descrição"           	,"@!",20,/*lPixel*/,{|| cDesItem := posicione("GW8",1,(cAliasDf)->FILIAL+(cAliasDf)->TIPO_DC+(cAliasDf)->GW1_EMISDC+(cAliasDf)->GW1_SERDC+(cAliasDf)->GW1_NRDC+(cAliasDf)->ITEM,"GW8_DSITEM") } )
	TRCell():New(oSection1,"(cAliasDf)->GW8_QTDE"    ,"(cAliasDf)","Quantidade"				,"@E 9,999,999.99999"	,18,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliasDf)->GW8_VALOR"   ,"(cAliasDf)","Valor"					,"@E 99,999,999.99"		,13,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliasDf)->GW8_PESOR"   ,"(cAliasDf)","Peso Real"				,"@E 9,999,999.99999"	,18,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliasDf)->GW8_PESOC"   ,"(cAliasDf)","Peso Cubado"			,"@E 9,999,999.99999"	,18,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"(cAliasDf)->GW8_VOLUME"  ,"(cAliasDf)","Volume"					,"@E 99,999,999.99"		,13,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"nFreteCalc"   			 ,""		  ,"Frete Calculado"		,"@E 999,999.99",12,/*lPixel*/,{||nFreteCalc})
	TRCell():New(oSection1,"nFretPrTon"              ,""          ,"Frete Calc/Ton"       	,"@E 999,999.99",12,/*lPixel*/,{||FretPrTon	:=   nFreteCalc /( (cAliasDf)->GW8_PESOR / 1000 )} )
	TRCell():New(oSection1,"nFretPrVl"               ,""          ,"% Frete Calc/$"         ,"@E 999,999.99",12,/*lPixel*/,{||FretPrVl 	:= ( nFreteCalc /  (cAliasDf)->GW8_VALOR) * 100  } )
	TRCell():New(oSection1,"nFretReal"   			 ,""		  ,"Frete Real"			    ,"@E 999,999.99",12,/*lPixel*/,{||nFretReal})
	TRCell():New(oSection1,"nFreRetTn"               ,""          ,"Frete Real/Ton"       	,"@E 999,999.99",12,/*lPixel*/,{||FretReTon	:=   nFretReal /( (cAliasDf)->GW8_PESOR / 1000 )} )
	TRCell():New(oSection1,"nFretReVl"               ,""          ,"% Frete Real/$"         ,"@E 999,999.99",12,/*lPixel*/,{||FretReVl 	:= ( nFretReal /  (cAliasDf)->GW8_VALOR) * 100  } )
	TRCell():New(oSection1,"nPrevReal"               ,""          ,"% Real/Previsto"       	,"@E 999,999.99",12,/*lPixel*/,{||PrevReal 	:= ( nFretReal /  nFreteCalc) * 100  } )
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
	Local aParam    := Array(2,2)
	Local oSection1 := oReport:Section(1)
	Local cAliasGWF := ""
	Local cAliasGW3 := ""
	Local cSerDc    := ""

	aParam[1][1] := MV_PAR01 //Filial de
	aParam[1][2] := MV_PAR02 //Filial até
	aParam[2][1] := MV_PAR03 //Data de emissão de
	aParam[2][2] := MV_PAR04 //Data de emissão até

	cAliasDf := U_GFE80DISPF(aParam)

	oSection1:Init()
	(cAliasDf)->(dbGoTop())
	Do While (cAliasDf)->(!Eof() )
		//oReport:IncMeter()
		nFreteCalc := 0
		nFretReal  := 0

		If (cAliasDf)->Re_VlAuto == 0 //Transportador (se for transportador o valor do campo referente a autonomo estará zerado)
			//Se descontar credito for sim
			If MV_PAR05 == 1
				cSerDc := IIf("_" $ (cAliasDf)->GW1_SERDC, "     ", (cAliasDf)->GW1_SERDC )

				//busca no calculo se Gera credito ICMS e PIS/COFINS
				cAliasGWF := GetNextAlias()
				BeginSQL Alias cAliasGWF
					SELECT GWF.GWF_CRDICM, GWF.GWF_CRDPC
					FROM %Table:GWH% GWH
					INNER JOIN %Table:GWF% GWF
					ON GWF.GWF_FILIAL = GWH.GWH_FILIAL
					AND GWF.GWF_NRCALC = GWH.GWH_NRCALC
					AND GWF.%NotDel%
					WHERE GWH.GWH_FILIAL = %Exp:(cAliasDf)->FILIAL%
					AND GWH.GWH_CDTPDC = %Exp:(cAliasDf)->TIPO_DC%
					AND GWH.GWH_EMISDC = %Exp:(cAliasDf)->GW1_EMISDC%
					AND GWH.GWH_SERDC = %Exp:cSerDc%
					AND GWH.GWH_NRDC = %Exp:(cAliasDf)->GW1_NRDC%
					AND GWH.%NotDel%
				EndSQL
				If (cAliasGWF)->(!Eof())
					nFreteCalc := (cAliasDf)->VALORFRETE

					If (cAliasGWF)->GWF_CRDICM == "1"
						nFreteCalc -= (cAliasDf)->VL_ICMS
					EndIf

					If (cAliasGWF)->GWF_CRDPC == "1"
						nFreteCalc -= (cAliasDf)->Pr_TotPisC
					EndIf
				EndIf
				(cAliasGWF)->(dbCloseArea())

				cAliasGW3 := GetNextAlias()	
				BeginSQL Alias cAliasGW3
					SELECT GW3.GW3_CRDICM, GW3.GW3_CRDPC
					FROM %Table:GW4% GW4
					INNER JOIN %Table:GW3% GW3
					ON GW3.GW3_FILIAL = GW4.GW4_FILIAL
					AND GW3.GW3_CDESP = GW4.GW4_CDESP
					AND GW3.GW3_EMISDF = GW4.GW4_EMISDF
					AND GW3.GW3_SERDF = GW4.GW4_SERDF
					AND GW3.GW3_NRDF = GW4.GW4_NRDF
					AND GW3.GW3_DTEMIS = GW4.GW4_DTEMIS
					AND GW3.%NotDel%
					WHERE GW4.GW4_FILIAL = %Exp:(cAliasDf)->FILIAL%
					AND GW4.GW4_EMISDC = %Exp:(cAliasDf)->GW1_EMISDC%
					AND GW4.GW4_SERDC = %Exp:cSerDc%
					AND GW4.GW4_NRDC = %Exp:(cAliasDf)->GW1_NRDC%
					AND GW4.GW4_TPDC = %Exp:(cAliasDf)->TIPO_DC%
					AND GW4.%NotDel%
				EndSQL
				If (cAliasGW3)->(!EoF())
					nFretReal := (cAliasDf)->Re_TotFrt

					If (cAliasGW3)->GW3_CRDICM == "1"
						nFretReal -= (cAliasDf)->Re_TotICMS
					EndIf

					If (cAliasGW3)->GW3_CRDPC == "1"
						nFretReal -= (cAliasDf)->Re_TotPisC
					EndIf
				EndIf
				(cAliasGW3)->(dbCloseArea())
			Else
				nFreteCalc := (cAliasDf)->VALORFRETE
				nFretReal  := (cAliasDf)->Re_TotFrt
			EndIf
		Else //Autonomo
			nFreteCalc := (cAliasDf)->VALORFRETE    //No valor calculado não é acrescentado os impostos

			If MV_PAR06 == 1  //Liquido
				nFretReal  := (cAliasDf)->Re_VlAuto
			Else
				nFretReal  := (cAliasDf)->Re_VlAuto + (cAliasDf)->Re_TaxAuto + (cAliasDf)->Re_INSSAut
			EndIf
		EndIf
		oSection1:PrintLine()
		(cAliasDf)->( dbSkip() )
	EndDo
	oSection1:Finish()
Return

/*--------------------------------------------------------------------------------------------------
Função responsavel por buscar os registro e retornar o nome da tabela temporaria com os registros
Generico.

@sample
U_GFE80DISPF(aParam)

@author
@since
@version
--------------------------------------------------------------------------------------------------*/
User Function GFE80DISPF(aParam,aParamGW1)
	Local cMV_CriRat  	:= SuperGetMv("MV_CRIRAT", .F., "1")
	Local cFilAux     	:= {}
	Local cSQLCriRat  	:= ""
	Local cSQLWhere   	:= ""
	Local cCompGW1		:= FWModeAccess("GW1", 1) + FWModeAccess("GW1", 2) + FWModeAccess("GW1", 3)
	Local cCompGU3   	:= FWModeAccess("GU3", 1) + FWModeAccess("GU3", 2) + FWModeAccess("GU3", 3)
	Local lGU3Comp   	:= .T.
	Local cSQLGU3		:= ""
	Local cSQLDesGU3 	:= ""
	Local cSQLTrpGU3	:= ""
	Local cInnerGWN     := ""
	
	Private cAliGWM := GetNextAlias()

	If cCompGW1 == cCompGU3
		lGU3Comp := .F.
	EndIf

	If lGU3Comp
		cSQLGU3 := "%"
		cSQLGU3 += "ON GU3.GU3_FILIAL = '" + xFilial("GU3") + "' "
		cSQLGU3 += "%"
		
		cSQLDesGU3 := "%"
		cSQLDesGU3 += "ON GU3REM.GU3_FILIAL = '" + xFilial("GU3") + "' "
		cSQLDesGU3 += "%"

		cSQLTrpGU3 := "%"
		cSQLTrpGU3 += "ON GU3TRP.GU3_FILIAL = '" + xFilial("GU3") + "' "
		cSQLTrpGU3 += "%"
	Else
		cSQLGU3 := "%"
		cSQLGU3	+= "ON GU3.GU3_FILIAL = GW1.GW1_FILIAL "
		cSQLGU3 += "%"

		cSQLDesGU3 := "%"
		cSQLDesGU3 += "ON GU3REM.GU3_FILIAL = GW1.GW1_FILIAL "
		cSQLDesGU3 += "%"

		cSQLTrpGU3 += "%"
		cSQLTrpGU3 += "ON GU3TRP.GU3_FILIAL = GWN.GWN_FILIAL "
		cSQLTrpGU3 += "%"
	EndIf
	
	If Empty(aParam[1][1])
		cFilAux := GFEGETFIL(cEmpAnt)
		aParam[1][1] := cFilAux[1][1]
	EndIf
	
	cSQLCriRat := "%"
	If cMV_CriRat == "2"
		cSQLCriRat += " MAX(GWM_VLFRE1) AS VL_FRETE, "
		cSQLCriRat += " (MAX(GWM_VLPIS1) + MAX(GWM_VLCOF1)) AS VL_PISCOF, "
		cSQLCriRat += " MAX(GWM_VLICM1) AS VL_ICMS, "
		cSQLCriRat += " MAX(GWM_VLINA1) AS VL_INAU, "
		cSQLCriRat += " MAX(GWM_VLINE1) AS VL_INEM, "
		cSQLCriRat += " MAX(GWM_VLIRR1) AS VL_IRRF, "
		cSQLCriRat += " MAX(GWM_VLSES1) AS VL_SEST, "
	ElseIf cMV_CriRat == "3"
		cSQLCriRat += " MAX(GWM_VLFRE3) AS VL_FRETE, "
		cSQLCriRat += " (MAX(GWM_VLPIS3) + MAX(GWM_VLCOF3)) AS VL_PISCOF, "
		cSQLCriRat += " MAX(GWM_VLICM3) AS VL_ICMS, "
		cSQLCriRat += " MAX(GWM_VLINA3) AS VL_INAU, "
		cSQLCriRat += " MAX(GWM_VLINE3) AS VL_INEM, "
		cSQLCriRat += " MAX(GWM_VLIRR3) AS VL_IRRF, "
		cSQLCriRat += " MAX(GWM_VLSES3) AS VL_SEST, "
	ElseIf cMV_CriRat == "4"
		cSQLCriRat += " MAX(GWM_VLFRE2) AS VL_FRETE, "
		cSQLCriRat += " (MAX(GWM_VLPIS2) + MAX(GWM_VLCOF2)) AS VL_PISCOF, "
		cSQLCriRat += " MAX(GWM_VLICM2) AS VL_ICMS, "
		cSQLCriRat += " MAX(GWM_VLINA2) AS VL_INAU, "
		cSQLCriRat += " MAX(GWM_VLINE2) AS VL_INEM, "
		cSQLCriRat += " MAX(GWM_VLIRR2) AS VL_IRRF, "
		cSQLCriRat += " MAX(GWM_VLSES2) AS VL_SEST, "
	Else
		// Critério padrão: Peso
		cSQLCriRat += " MAX(GWM_VLFRET) AS VL_FRETE, "
		cSQLCriRat += " (MAX(GWM_VLPIS) + MAX(GWM_VLCOFI)) AS VL_PISCOF, "
		cSQLCriRat += " MAX(GWM_VLICMS) AS VL_ICMS, "
		cSQLCriRat += " MAX(GWM_VLINAU) AS VL_INAU, "
		cSQLCriRat += " MAX(GWM_VLINEM) AS VL_INEM, "
		cSQLCriRat += " MAX(GWM_VLIRRF) AS VL_IRRF, "
		cSQLCriRat += " MAX(GWM_VLSEST) AS VL_SEST, "	
	EndIf
	cSQLCriRat += "%"
	
	cSQLWhere := "%"
		If Len(aParam) > 1
			cSQLWhere += " GW1.GW1_FILIAL BETWEEN '" + Alltrim(aParam[1][1]) + "' AND '" + Alltrim(aParam[1][2]) + "'"
			cSQLWhere += " AND GW1.GW1_DTEMIS BETWEEN '" + DtoS(aParam[2][1]) + "' AND '" + DToS(aParam[2][2]) + "'"
		EndIf
	cSQLWhere += "%"

	If GFXCP1212210('GW1_FILROM')
		cInnerGWN := "GW1.GW1_FILROM"
	Else
		cInnerGWN := "GW1.GW1_FILIAL"
	EndIf
	cInnerGWN := "%" + cInnerGWN + "%"
		
	BeginSql Alias cAliGWM
		SELECT DISTINCT '' AS FILIAL,
				GWM_FILIAL,
				GWM_CDTPDC,
				GWM_EMISDC,
				GWM_SERDC,
				GWM_NRDC,
				GWM_ITEM,
				GWM_NRDOC,
				GWM_TPDOC,
				GWM_CDTRP,
				GU3.GU3_NMEMIT AS GU3_NMEMIT,
				GU3.GU3_NRCID AS GU3_NRCID,
				GU7.GU7_CDUF AS GU7_CDUF,
				GU7.GU7_NMCID AS GU7_NMCID,
				GU7.GU7_CDPAIS AS GU7_CDPAIS,
				SYA.YA_DESCR AS YA_DESCR,
				GU7ENT.GU7_CDUF AS ENT_CDUF,
				GU7ENT.GU7_NMCID AS ENT_NMCID,
				GU7ENT.GU7_CDPAIS AS ENT_CDPAIS,
				SYAB.YA_DESCR AS YABDESCR,
				GU3REM.GU3_NMEMIT AS REM_NMEMIT,
				GU3TRP.GU3_NMEMIT AS TRP_NMEMIT,
				GV3.GV3_DSTPVC AS GV3_DSTPVC,
				GV4.GV4_DSTPOP AS GV4_DSTPOP,
				GUB.GUB_DSCLFR AS GUB_DSCLFR,
				MAX(GW1_REGCOM) AS REGIAOCOM,
				MAX(GW1_REPRES) AS GW1_REPRES,
				MAX(GW1_CDREM) AS REMETENTE,
				MAX(GW1_CDDEST) AS DESTINATA,
				MAX(GW1_ENTNRC) AS GW1_ENTNRC,
				MAX(GW1_CDTPDC) AS TIPO_DC,
				MAX(GW1_TPFRET) AS TIPOFRETE,
				MAX(GW1_SERDC) AS GW1_SERDC,
				MAX(GW1_NRDC) AS GW1_NRDC,
				MAX(GW1_NRROM) AS ROMANEIO,
				MAX(GW1_DTIMPL) AS GW1_DTIMPL,
				MAX(GW1_DTEMIS) AS GW1_DTEMIS,
				MAX(GW1_HRIMPL) AS GW1_HRIMPL,
				MAX(GW1_DTSAI) AS GW1_DTSAI,
				MAX(GW1_HRSAI) AS GW1_HRSAI,
				MAX(GW1_DTPENT) AS GW1_DTPENT,
				MAX(GW1_HRPENT) AS GW1_HRPENT,
				MAX(GWN_CDCLFR) AS GWN_CDCLFR,
				MAX(GWN_LACRE) AS GWN_LACRE,
				MAX(GW1_DTPSAI) AS GW1_DTPSAI,
				MAX(GW1_USO) AS GW1_USO,
				MAX(GW1_EMISDC) AS GW1_EMISDC,
				MAX(GW8_QTDE) AS GW8_QTDE,
				MAX(GW8_PESOR) AS GW8_PESOR,
				MAX(GW8_VOLUME) AS GW8_VOLUME,
				MAX(GW8_PESOC) AS GW8_PESOC,
				MAX(GW8_UNINEG) AS UNINEG,
				MAX(GW8_INFO1) AS NATUOPER,
				MAX(GW8_INFO2) AS CANALVENDA,
				MAX(GW8_ITEM) AS ITEM,
				GW8_SEQ AS SEQUENCIA,
				MAX(GW8_VALOR) AS GW8_VALOR,
				MAX(GW1_HRPSAI) AS GW1_HRPSAI,
				MAX(GWN_CDTPOP) AS GWN_CDTPOP,
				MAX(GWN_CDTPVC) AS VEICULO,
				MAX(GWM.GWM_CDTRP) AS GWN_CDTRP,
				CASE MAX(GWM.GWM_TPDOC) WHEN '1' THEN MAX(GWF.GWF_TPCALC) || ';' || MAX(GWF.GWF_FINCAL) WHEN '2' THEN MAX(GW3.GW3_TPDF) || ';0' ELSE '0;0' END AS TPCALC,
				MAX(GW8_INFO2) AS CANALVENDA,
				0 AS TOT_PISCOF,
				%Exp:cSQLCriRat%
				MAX(GU9_NMREG) AS GU9_NMREG,
				MAX(GWU_DTENT) AS GWU_DTENT,
				MAX(GWU_HRENT) AS GWU_HRENT
		FROM %Table:GWM% GWM
		LEFT JOIN %Table:GW1% GW1
		ON GW1.GW1_FILIAL = GWM.GWM_FILIAL
		AND GW1.GW1_CDTPDC = GWM.GWM_CDTPDC
		AND GW1.GW1_EMISDC = GWM.GWM_EMISDC
		AND GW1.GW1_SERDC = GWM.GWM_SERDC
		AND GW1.GW1_NRDC = GWM.GWM_NRDC
		AND GW1.%NotDel%
		LEFT JOIN %Table:GW8% GW8
		ON GW8.GW8_FILIAL = GWM.GWM_FILIAL
		AND GW8.GW8_CDTPDC = GWM.GWM_CDTPDC
		AND GW8.GW8_EMISDC = GWM.GWM_EMISDC
		AND GW8.GW8_SERDC = GWM.GWM_SERDC
		AND GW8.GW8_NRDC = GWM.GWM_NRDC
		AND GW8.GW8_ITEM = GWM.GWM_ITEM
		AND GW8.GW8_SEQ = GWM.GWM_SEQGW8
		AND GW8.%NotDel%
		LEFT JOIN %Table:GWN% GWN
		ON GWN.GWN_FILIAL = %Exp:cInnerGWN%
		AND GWN.GWN_NRROM = GW1.GW1_NRROM
		AND GWN.%NotDel%
		LEFT JOIN %Table:GWF% GWF
		ON GWF.GWF_FILIAL = GWM.GWM_FILIAL
		AND GWF.GWF_NRCALC = GWM.GWM_NRDOC
		AND GWF.%NotDel%
		LEFT JOIN %Table:GW3% GW3
		ON GW3.GW3_FILIAL = GWM.GWM_FILIAL
		AND GW3.GW3_CDESP = GWM.GWM_CDESP
		AND GW3.GW3_EMISDF = GWM.GWM_CDTRP
		AND GW3.GW3_SERDF = GWM.GWM_SERDOC
		AND GW3.GW3_NRDF = GWM.GWM_NRDOC
		AND GW3.GW3_DTEMIS = GWM.GWM_DTEMIS
		AND GW3.%NotDel%
		LEFT JOIN %Table:GWG% GWG
		ON GWG.GWG_FILIAL = GWF.GWF_FILIAL
		AND GWG.GWG_NRCALC = GWF.GWF_NRCALC
		AND GWG.%NotDel%
		LEFT JOIN %Table:GV8% GV8
		ON GV8.GV8_FILIAL = %xFilial:GV8%
		AND GV8.GV8_CDEMIT = GWG.GWG_CDEMIT
		AND GV8.GV8_NRTAB = GWG.GWG_NRTAB
		AND GV8.GV8_NRNEG = GWG.GWG_NRNEG
		AND GV8.GV8_NRROTA = GWG.GWG_NRROTA
		AND GV8.%NotDel%
		LEFT JOIN %Table:GU9% GU9
		ON GU9.GU9_FILIAL = %xFilial:GU9%
		AND GU9.GU9_NRREG = GV8.GV8_NRREDS
		AND GU9.%NotDel%
		LEFT JOIN %Table:GWU% GWU
		ON GWU.GWU_FILIAL = GW1.GW1_FILIAL
		AND GWU.GWU_CDTPDC = GW1.GW1_CDTPDC
		AND GWU.GWU_EMISDC = GW1.GW1_EMISDC
		AND GWU.GWU_SERDC = GW1.GW1_SERDC
		AND GWU.GWU_NRDC = GW1.GW1_NRDC
		AND GWU.GWU_PAGAR = '1'
		AND GWU.%NotDel%
		LEFT JOIN %Table:GU3% GU3
		%Exp:cSQLGU3%
		AND GU3.GU3_CDEMIT = GW1.GW1_CDDEST
		AND GU3.%NotDel%
  		LEFT JOIN %Table:GU7% GU7
		ON GU7.GU7_FILIAL = %xFilial:GU7%
		AND GU7.GU7_NRCID = GU3.GU3_NRCID
		AND GU7.%NotDel%
  		LEFT JOIN %Table:SYA% SYA
		ON SYA.YA_FILIAL = %xFilial:SYA%
		AND SYA.YA_CODGI = GU7.GU7_CDPAIS
		AND SYA.%NotDel%
		LEFT JOIN %Table:GU7% GU7ENT
		ON GU7ENT.GU7_FILIAL = %xFilial:GU7%
		AND GU7ENT.GU7_NRCID = GW1.GW1_ENTNRC
		AND GU7ENT.%NotDel%
  		LEFT JOIN %Table:SYA% SYAB
		ON SYAB.YA_FILIAL = %xFilial:SYA%
		AND SYAB.YA_CODGI = GU7.GU7_CDPAIS
		AND SYAB.%NotDel%
		LEFT JOIN %Table:GU3% GU3REM
		%Exp:cSQLDesGU3%
		AND GU3REM.GU3_CDEMIT = GW1.GW1_CDREM
		AND GU3REM.%NotDel%
		LEFT JOIN %Table:GU3% GU3TRP
		%Exp:cSQLTrpGU3%
		AND GU3TRP.GU3_CDEMIT = GWN.GWN_CDTRP
		AND GU3TRP.%NotDel%		
		LEFT JOIN %Table:GV3% GV3
		ON GV3.GV3_FILIAL = %xFilial:GV3%
		AND GV3.GV3_CDTPVC = GWN.GWN_CDTPVC
		AND GV3.%NotDel%
		LEFT JOIN %Table:GV4% GV4
		ON GV4.GV4_FILIAL = %xFilial:GV4%
		AND GV4.GV4_CDTPOP = GWN.GWN_CDTPOP
		AND GV4.%NotDel%
		LEFT JOIN %Table:GUB% GUB
		ON GUB.GUB_FILIAL = %xFilial:GUB%
		AND GUB.GUB_CDCLFR = GWN.GWN_CDCLFR
		AND GUB.%NotDel%

		WHERE %Exp:cSQLWhere%
		  AND GWM.%NotDel%

		GROUP BY GWM_FILIAL, GWM_CDTPDC, GWM_EMISDC, GWM_SERDC, GWM_NRDC, GWM_CDTRP, GWM_ITEM, GW8_SEQ, GWM_TPDOC, GWM_NRDOC, GU3.GU3_NMEMIT, GU3.GU3_NRCID, GU7.GU7_CDUF, GU7.GU7_NMCID
		    , GU7.GU7_CDPAIS, SYA.YA_DESCR, GU7ENT.GU7_CDUF, GU7ENT.GU7_NMCID, GU7ENT.GU7_CDPAIS, SYAB.YA_DESCR, GU3REM.GU3_NMEMIT, GU3TRP.GU3_NMEMIT, GV3.GV3_DSTPVC, GV4.GV4_DSTPOP, GUB.GUB_DSCLFR
	EndSql
	
	ProcRegua(RecCount())
	Do While (cAliGWM)->(!Eof())
		GravaTT()

		(cAliGWM)->( dbSkip() )
	EndDo
	GFEDelTab(cAliGWM)
Return cAliasDf

Static Function GravaTT()
	Local nPos       := 0
	Local cSentido   := ""
	Local cDsTpDc    := ""
	Local cAliasQry  := GetNextAlias()
	Local cTmpTabDf  := "%" + oTmpTabDf:GetRealName() + "%"
	Local cSerDc     := IIf(Empty((cAliGWM)->GWM_SERDC), "_____", (cAliGWM)->GWM_SERDC)

	BeginSql Alias cAliasQry
		SELECT TDF.R_E_C_N_O_ RECNOTDF
		FROM %Exp:cTmpTabDf% TDF
		WHERE TDF.FILIAL = %Exp:(cAliGWM)->GWM_FILIAL%
		AND TDF.TIPO_DC = %Exp:(cAliGWM)->GWM_CDTPDC%
		AND TDF.GW1_EMISDC = %Exp:(cAliGWM)->GWM_EMISDC%
		AND TDF.GW1_SERDC = %Exp:cSerDc%
		AND TDF.GW1_NRDC = %Exp:(cAliGWM)->GWM_NRDC%
		AND TDF.TRANSP = %Exp:(cAliGWM)->GWM_CDTRP%
		AND TDF.ITEM = %Exp:(cAliGWM)->GWM_ITEM%
		AND TDF.SEQUENCIA = %Exp:(cAliGWM)->SEQUENCIA%
		AND TDF.%NotDel%
	EndSql
	If (cAliasQry)->(!Eof())
		(cAliasDf)->(dbGoto((cAliasQry)->RECNOTDF))
		// Alteração
		RecLock(cAliasDf, .F.)
			PreencheValores()
		(cAliasDf)->(MsUnlock())
	Else
		// Busca sentido e descrição do tipo de documento
		nPos := aScan(aCacheGV5, {|x| Alltrim(x[2]) == Alltrim((cAliGWM)->TIPO_DC)})
		If nPos > 0
			cSentido := aCacheGV5[nPos][4]
			cDsTpDc  := aCacheGV5[nPos][3]
		EndIf

		// Grava dados
		RecLock(cAliasDf, .T.)
			(cAliasDf)->EMPRESA	      := cEmpAnt
			(cAliasDf)->FILIAL	      := (cAliGWM)->GWM_FILIAL
			(cAliasDf)->REGIAOCOM     := (cAliGWM)->REGIAOCOM
			(cAliasDf)->GW1_REPRES    := IIf(Empty((cAliGWM)->GW1_REPRES), "0", (cAliGWM)->GW1_REPRES)
			(cAliasDf)->TRANSP    	  := (cAliGWM)->GWM_CDTRP
			(cAliasDf)->DESTINATA  	  := (cAliGWM)->DESTINATA
			(cAliasDf)->GW1_NMDEST    := Iif(!Empty((cAliGWM)->GU3_NMEMIT), (cAliGWM)->GU3_NMEMIT, '')
			(cAliasDf)->REMETENTE     := (cAliGWM)->REMETENTE
			(cAliasDf)->GW1_NMREM     := if(!Empty((cAliGWM)->REM_NMEMIT), (cAliGWM)->REM_NMEMIT, ' ') 
			(cAliasDf)->TIPO_DC    	  := (cAliGWM)->TIPO_DC
			(cAliasDf)->TIPOFRETE     := IIf(Empty((cAliGWM)->TIPOFRETE), "0", (cAliGWM)->TIPOFRETE)
			(cAliasDf)->GW1_SERDC     := cSerDc
			(cAliasDf)->GW1_NRDC      := (cAliGWM)->GW1_NRDC
			(cAliasDf)->ROMANEIO      := IIf(Empty((cAliGWM)->ROMANEIO), "0", (cAliGWM)->ROMANEIO)
			(cAliasDf)->LACRE         := IIf(Empty((cAliGWM)->GWN_LACRE), "0", (cAliGWM)->GWN_LACRE)
			(cAliasDf)->GW1_DTIMPL    := IIf(!Empty((cAliGWM)->GW1_DTIMPL),STOD((cAliGWM)->GW1_DTIMPL),CtoD("01/01/1800") )
			(cAliasDf)->GW1_DTEMIS    := IIf(!Empty((cAliGWM)->GW1_DTEMIS),STOD((cAliGWM)->GW1_DTEMIS),CtoD("01/01/1800") )
			(cAliasDf)->GW1_HRIMPL    := (cAliGWM)->GW1_HRIMPL
			(cAliasDf)->GW1_DTSAI     := IIf(!Empty((cAliGWM)->GW1_DTSAI),STOD((cAliGWM)->GW1_DTSAI),CtoD("01/01/1800") )
			(cAliasDf)->GW1_HRSAI     := (cAliGWM)->GW1_HRSAI
			(cAliasDf)->GW1_DTPENT    := IIf(!Empty((cAliGWM)->GW1_DTPENT),STOD((cAliGWM)->GW1_DTPENT),CtoD("01/01/1800") ) //20
			(cAliasDf)->GW1_HRPENT    := (cAliGWM)->GW1_HRPENT
			(cAliasDf)->GW1_DTPSAI    := IIf(!Empty((cAliGWM)->GW1_DTPSAI),STOD((cAliGWM)->GW1_DTPSAI),CtoD("01/01/1800") )
			(cAliasDf)->GW1_HRPSAI    := (cAliGWM)->GW1_HRPSAI
			(cAliasDf)->GW1_USO       := GFEFldInfo("GW1_USO", (cAliGWM)->GW1_USO, 2)
			(cAliasDf)->GW1_EMISDC    := (cAliGWM)->GWM_EMISDC
			(cAliasDf)->SEQUENCIA     := (cAliGWM)->SEQUENCIA
			(cAliasDf)->GW8_QTDE      := (cAliGWM)->GW8_QTDE
			(cAliasDf)->GW8_PESOR     := (cAliGWM)->GW8_PESOR
			(cAliasDf)->GW8_VOLUME    := (cAliGWM)->GW8_VOLUME
			(cAliasDf)->GW8_PESOC     := (cAliGWM)->GW8_PESOC //30
			(cAliasDf)->UNINEG    	  := (cAliGWM)->UNINEG
			(cAliasDf)->NATUOPER      := (cAliGWM)->NATUOPER
			(cAliasDf)->CANALVENDA 	  := (cAliGWM)->CANALVENDA
			(cAliasDf)->ITEM      	  := (cAliGWM)->ITEM
			(cAliasDf)->GW8_VALOR     := (cAliGWM)->GW8_VALOR
			(cAliasDf)->GWN_CDTPOP    := (cAliGWM)->GWN_CDTPOP
			(cAliasDf)->VEICULO       := (cAliGWM)->VEICULO
			(cAliasDf)->GV3_DSTPVC    := Iif(!Empty((cAliGWM)->GV3_DSTPVC), (cAliGWM)->GV3_DSTPVC, ' ')
			(cAliasDf)->GV4_DSTPOP    := Iif(!Empty((cAliGWM)->GV4_DSTPOP), (cAliGWM)->GV4_DSTPOP, " ")
			(cAliasDf)->GV5_SENTID    := cSentido
			(cAliasDf)->GV5_DSTPDC    := cDsTpDc
			(cAliasDf)->GUB_DSCLFR    := Iif(!Empty((cAliGWM)->GUB_DSCLFR), (cAliGWM)->GUB_DSCLFR, "") 
			(cAliasDf)->REGIAO        := (cAliGWM)->GU9_NMREG
			(cAliasDf)->GWU_DTENT     := Iif(!Empty((cAliGWM)->GWU_DTENT), SToD((cAliGWM)->GWU_DTENT),SToD("")) 
			(cAliasDf)->GWU_HRENT     := Iif(!Empty((cAliGWM)->GWU_DTENT), (cAliGWM)->GWU_HRENT,"") 
			(cAliasDf)->GW_CDCIDD     := Iif(!Empty((cAliGWM)->GW1_ENTNRC), (cAliGWM)->GW1_ENTNRC, Iif(!Empty((cAliGWM)->GU3_NRCID), (cAliGWM)->GU3_NRCID, ''))
			(cAliasDf)->UF       	  := Iif(!Empty((cAliGWM)->ENT_CDUF), (cAliGWM)->ENT_CDUF, Iif(!Empty((cAliGWM)->GU7_CDUF), (cAliGWM)->GU7_CDUF, ''))
			(cAliasDf)->CIDADE    	  := Iif(!Empty((cAliGWM)->ENT_CDUF), (cAliGWM)->ENT_NMCID, Iif(!Empty((cAliGWM)->GU7_NMCID), (cAliGWM)->GU7_NMCID, ''))
			(cAliasDf)->PAIS		  := Iif(!Empty((cAliGWM)->ENT_CDUF), (cAliGWM)->YABDESCR, Iif(!Empty((cAliGWM)->YA_DESCR), (cAliGWM)->YA_DESCR, ''))
			(cAliasDf)->GW_NMEMI      := Iif(!Empty((cAliGWM)->TRP_NMEMIT), (cAliGWM)->TRP_NMEMIT, ' ')
			(cAliasDf)->REDESPACHO    := If((cAliGWM)->TIPOFRETE $ "2/4/6", "1", "0")
			(cAliasDf)->CLASSFRETE    := (cAliGWM)->GWN_CDCLFR

			//Valores provisão.
			(cAliasDf)->VALORFRETE    := 0  
			(cAliasDf)->VL_DIARIA     := 0 
			(cAliasDf)->VL_ICMS       := 0 
			(cAliasDf)->Pr_TotPisC    := 0 
			(cAliasDf)->Pr_VlFrtNr    := 0 
			(cAliasDf)->Pr_ICMSnr     := 0 //60 
			(cAliasDf)->Pr_PISNorm    := 0 
			(cAliasDf)->Pr_Redesp     := 0 
			(cAliasDf)->Pr_ICMSRed    := 0 
			(cAliasDf)->Pr_PISRed     := 0 
			(cAliasDf)->Pr_TotRed     := 0 
			(cAliasDf)->Pr_ICMSDia    := 0 
			(cAliasDf)->Pr_PISDia     := 0 
			(cAliasDf)->Pr_TotDia     := 0 
			(cAliasDf)->Pr_VlReen     := 0 
			(cAliasDf)->Pr_ICMSRee    := 0 //70
			(cAliasDf)->Pr_PISRee     := 0 
			(cAliasDf)->Pr_TotReen    := 0 
			(cAliasDf)->Pr_VlDevol    := 0 
			(cAliasDf)->Pr_ICMSDev    := 0 
			(cAliasDf)->Pr_PISDev     := 0 
			(cAliasDf)->Pr_TotDev     := 0 
			(cAliasDf)->Pr_VlAuton    := 0 

			//Valores realização.
			(cAliasDf)->Re_TotFrt     := 0 
			(cAliasDf)->Re_TotICMS    := 0 
			(cAliasDf)->Re_TotPisC    := 0 //80
			(cAliasDf)->Re_FrtNorm    := 0 
			(cAliasDf)->Re_ICMSNr     := 0 
			(cAliasDf)->Re_PISNor     := 0 
			(cAliasDf)->Re_VlRedes    := 0 
			(cAliasDf)->Re_VlICRed    := 0 
			(cAliasDf)->Re_VlPisRe    := 0 
			(cAliasDf)->Re_TotRede    := 0 
			(cAliasDf)->Re_VlDiari    := 0 
			(cAliasDf)->Re_ICMSDia    := 0 
			(cAliasDf)->Re_PISDia     := 0 //90
			(cAliasDf)->Re_TotDia     := 0 
			(cAliasDf)->Re_VlTotRe    := 0 
			(cAliasDf)->Re_ICMSRe     := 0 
			(cAliasDf)->Re_PISRee     := 0 
			(cAliasDf)->Re_TotRee     := 0 
			(cAliasDf)->Re_VlTotDe    := 0 
			(cAliasDf)->Re_ICMSDev    := 0 
			(cAliasDf)->Re_PISDev     := 0 
			(cAliasDf)->Re_TotDev     := 0 
			(cAliasDf)->Re_VlAuto     := 0 //100
			(cAliasDf)->Re_TaxAuto    := 0 
			(cAliasDf)->Re_INSSAut    := 0

			PreencheValores()
		(cAliasDf)->( MsUnlock() )
	EndIf

	(cAliasQry)->(dbCloseArea())
Return

Static Function PreencheValores()

	//GWM_TPDOC => 1=Calculo Frete;2=CTRC/NFS;3=Contrato Autonomo;4=Estimativa Frete
	
	/* Previsto - CALCULO DE FRETE */
	If (cAliGWM)->GWM_TPDOC == "1"
		// GWF_TPCALC => 1=Normal;2=Compl Valor;3=Compl Imposto;4=Reentrega;5=Devolucao;6=Redespacho;7=Servico;8=Estimativa
		
		//Total de PIS/COFINS
		(cAliasDf)->Pr_TotPisC += (cAliGWM)->VL_PISCOF 
		
		If SubStr((cAliGWM)->TPCALC, 3, 1) == "3"
			(cAliasDf)->Pr_VlAuton    += (cAliGWM)->VL_FRETE 
		EndIf
		
		// Normal
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "1" .Or. SubStr((cAliGWM)->TPCALC, 1, 1) == "2" .Or. SubStr((cAliGWM)->TPCALC, 1, 1) == "3"
			(cAliasDf)->Pr_VlFrtNr += (cAliGWM)->VL_FRETE
			(cAliasDf)->Pr_ICMSnr  += (cAliGWM)->VL_ICMS
			(cAliasDf)->Pr_PISNorm += (cAliGWM)->VL_PISCOF
		EndIf
		
		//Reentrega
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "4"
			(cAliasDf)->Pr_VlReen  += (cAliGWM)->VL_FRETE
			(cAliasDf)->Pr_ICMSRee += (cAliGWM)->VL_ICMS
			(cAliasDf)->Pr_PISRee  += (cAliGWM)->VL_PISCOF
			(cAliasDf)->Pr_TotReen += 1
		EndIf
		
		//Devolução
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "5"
			(cAliasDf)->Pr_VlDevol += (cAliGWM)->VL_FRETE
			(cAliasDf)->Pr_ICMSDev += (cAliGWM)->VL_ICMS
			(cAliasDf)->Pr_PISDev  += (cAliGWM)->VL_PISCOF
			(cAliasDf)->Pr_TotDev  += 1
		EndIf
		
		// Redespacho
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "6"
			(cAliasDf)->Pr_Redesp  += (cAliGWM)->VL_FRETE
			(cAliasDf)->Pr_ICMSRed += (cAliGWM)->VL_ICMS
			(cAliasDf)->Pr_PISRed  += (cAliGWM)->VL_PISCOF
			(cAliasDf)->Pr_TotRed  += 1
		EndIf
		
		//Serviço
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "7"
			(cAliasDf)->VL_DIARIA  += (cAliGWM)->VL_FRETE
			(cAliasDf)->Pr_ICMSDia += (cAliGWM)->VL_ICMS
			(cAliasDf)->Pr_PISDia  += (cAliGWM)->VL_PISCOF
			(cAliasDf)->Pr_TotDia  += 1
		EndIf
		
		(cAliasDf)->VALORFRETE := (cAliasDf)->Pr_VlFrtNr + (cAliasDf)->Pr_Redesp + (cAliasDf)->Pr_VlReen + (cAliasDf)->Pr_VlDevol + (cAliasDf)->VL_DIARIA
		(cAliasDf)->VL_ICMS    := (cAliasDf)->Pr_ICMSnr + (cAliasDf)->Pr_ICMSRed + (cAliasDf)->Pr_ICMSRee + (cAliasDf)->Pr_ICMSDev + (cAliasDf)->Pr_ICMSDia
	EndIf

	/* Realizado - DOCUMENTO DE FRETE */
	If (cAliGWM)->GWM_TPDOC == "2"
		// Normal
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "1" .Or. SubStr((cAliGWM)->TPCALC, 1, 1) == "2" .Or. SubStr((cAliGWM)->TPCALC, 1, 1) == "3"
			(cAliasDf)->Re_FrtNorm += (cAliGWM)->VL_FRETE
			(cAliasDf)->Re_ICMSNr  += (cAliGWM)->VL_ICMS
			(cAliasDf)->Re_PISNor  += (cAliGWM)->VL_PISCOF
		EndIf
		
		//Reentrega
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "4"	
			(cAliasDf)->Re_VlTotRe += (cAliGWM)->VL_FRETE
			(cAliasDf)->Re_ICMSRe  += (cAliGWM)->VL_ICMS
			(cAliasDf)->Re_PISRee  += (cAliGWM)->VL_PISCOF
			(cAliasDf)->Re_TotRee  += 1	
		EndIf
		
		//Devolução
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "5"	
			(cAliasDf)->Re_VlTotDe += (cAliGWM)->VL_FRETE
			(cAliasDf)->Re_ICMSDev += (cAliGWM)->VL_ICMS
			(cAliasDf)->Re_PISDev  += (cAliGWM)->VL_PISCOF
			(cAliasDf)->Re_TotDev  += 1
		EndIf
		
		//Redespacho
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "6"	
			(cAliasDf)->Re_VlRedes += (cAliGWM)->VL_FRETE
			(cAliasDf)->Re_VlICRed += (cAliGWM)->VL_ICMS
			(cAliasDf)->Re_VlPisRe += (cAliGWM)->VL_PISCOF
			(cAliasDf)->Re_TotRede += 1
		EndIf
		
		//Serviço
		If SubStr((cAliGWM)->TPCALC, 1, 1) == "7"	
			(cAliasDf)->Re_VlDiari += (cAliGWM)->VL_FRETE
			(cAliasDf)->Re_ICMSDia += (cAliGWM)->VL_ICMS
			(cAliasDf)->Re_PISDia  += (cAliGWM)->VL_PISCOF
			(cAliasDf)->Re_TotDia  += 1
		EndIf
		
		//Totais
		(cAliasDf)->Re_TotFrt  := (cAliasDf)->Re_FrtNorm  + (cAliasDf)->Re_VlRedes + (cAliasDf)->Re_VlTotRe + (cAliasDf)->Re_VlTotDe + (cAliasDf)->Re_VlDiari 
		(cAliasDf)->Re_TotICMS := (cAliasDf)->Re_ICMSNr + (cAliasDf)->Re_VlICRed + (cAliasDf)->Re_ICMSRe + (cAliasDf)->Re_ICMSDev + (cAliasDf)->Re_ICMSDia
		(cAliasDf)->Re_TotPisC := (cAliasDf)->Re_PISNor + (cAliasDf)->Re_VlPisRe + (cAliasDf)->Re_PISRee + (cAliasDf)->Re_PISDev + (cAliasDf)->Re_PISDia
	EndIf
	
	/* Realizado - CONTRATO AUTONOMO */
	If (cAliGWM)->GWM_TPDOC == "3" 
		(cAliasDf)->Re_VlAuto  += (cAliGWM)->VL_FRETE
		(cAliasDf)->Re_TaxAuto += (cAliGWM)->VL_INEM + (cAliGWM)->VL_IRRF + (cAliGWM)->VL_SEST
		(cAliasDf)->Re_INSSAut += (cAliGWM)->VL_INAU
	EndIf
Return

/*--------------------------------------------------------/
Função que cria a Tamp-table da despesa de frete
--------------------------------------------------------*/
User Function GFE80TtDF()
	Local aTT
	Local cTTBIDisp

	// Criacao da tabela temporaria p/ imprimir o relat
	aTT := {{"EMPRESA"   , "C", Len(FWCodFil())        , 0},;
			{"FILIAL"	 , "C", TamSX3("GW1_FILIAL")[1], 0},;
			{"CANALVENDA", "C", TamSX3("GW8_INFO2" )[1], 0},;
			{"GW_CDCIDD" , "C", TamSX3("GU7_NRCID" )[1], 0},;
			{"CIDADE"    , "C", TamSX3("GU7_NMCID" )[1], 0},;
			{"UF"   	 , "C", TamSX3("GU7_CDUF"  )[1], 0},;
			{"PAIS"   	 , "C", TamSX3("YA_DESCR")[1]  , 0},;
			{"REGIAOCOM" , "C", TamSX3("GW1_REGCOM")[1], 0},;
			{"REGIAO" 	 , "C", 40					   , 0},;
			{"NATUOPER"  , "C", TamSX3("GW8_INFO1" )[1], 0},;
			{"GW1_REPRES", "C", TamSX3("GW1_REPRES")[1], 0},;
			{"GW8_INFO5" , "C", TamSX3("GW8_INFO5" )[1], 0},;
			{"ITEM"  	 , "C", TamSX3("GW8_ITEM"  )[1], 0},;
			{"SEQUENCIA" , "C", TamSX3("GW8_SEQ"   )[1], 0},;
			{"GW1_EMISDC", "C", TamSX3("GW1_EMISDC")[1], 0},;
			{"TRANSP"	 , "C", TamSX3("GWU_CDTRP" )[1], 0},;
			{"GW_NMEMI"  , "C", TamSX3("GU3_NMEMIT")[1], 0},;
			{"DESTINATA" , "C", TamSX3("GW1_CDDEST")[1], 0},;
			{"GW1_NMDEST", "C", TamSX3("GW1_NMDEST")[1], 0},;
			{"REMETENTE" , "C", TamSX3("GW1_CDREM" )[1], 0},;                       //20
			{"GW1_NMREM" , "C", TamSX3("GW1_NMREM" )[1], 0},;
			{"TIPO_DC"	 , "C", TamSX3("GW1_CDTPDC")[1], 0},;
			{"GV5_DSTPDC", "C", TamSX3("GV5_DSTPDC")[1], 0},;
			{"TIPOFRETE" , "C", 1                      , 0},;
			{"VEICULO"   , "C", TamSX3("GWN_CDTPVC")[1], 0},;
			{"GV3_DSTPVC", "C", TamSX3("GV3_DSTPVC")[1], 0},;
			{"REDESPACHO", "C", 1					   , 0},;
			{"GW1_SERDC" , "C", TamSX3("GW1_SERDC" )[1], 0},;
			{"GW1_NRDC"  , "C", TamSX3("GW1_NRDC"  )[1], 0},;
			{"ROMANEIO"  , "C", TamSX3("GW1_NRROM" )[1], 0},;                       //30
			{"CLASSFRETE", "C", TamSX3("GW8_CDCLFR")[1], 0},;
			{"GUB_DSCLFR", "C", TamSX3("GUB_DSCLFR")[1], 0},;
			{"GW1_DTIMPL", "D", TamSX3("GW1_DTIMPL")[1], 0},;
			{"GW1_DTEMIS", "D", TamSX3("GW1_DTEMIS")[1], 0},;
			{"GW1_HRIMPL", "C", TamSX3("GW1_HRIMPL")[1], 0},;
			{"GW1_DTSAI" , "D", TamSX3("GW1_DTSAI" )[1], 0},;
			{"GW1_HRSAI" , "C", TamSX3("GW1_HRSAI" )[1], 0},;
			{"GWU_DTENT" , "D", TamSX3("GWU_DTENT" )[1], 0},;
			{"GWU_HRENT" , "C", TamSX3("GWU_HRENT" )[1], 0},;
			{"GW1_DTPENT", "D", TamSX3("GW1_DTPENT")[1], 0},;                       //40
			{"GW1_HRPENT", "C", TamSX3("GW1_HRPENT")[1], 0},;
			{"GW1_DTPSAI", "D", TamSX3("GW1_DTPSAI")[1], 0},;
			{"GW1_HRPSAI", "C", TamSX3("GW1_HRPSAI")[1], 0},;
			{"VALORFRETE", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"VL_DIARIA" , "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"VL_ICMS"   , "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"GW8_QTDE"  , "N", TamSX3("GW8_QTDE"  )[1], TamSX3("GW8_QTDE"  )[2]},;
			{"GW8_PESOR" , "N", TamSX3("GW8_PESOR" )[1], TamSX3("GW8_PESOR" )[2]},;
			{"GW8_VOLUME", "N", TamSX3("GW8_VOLUME")[1], TamSX3("GW8_VOLUME")[2]},;
			{"GW8_PESOC" , "N", TamSX3("GW8_PESOC" )[1], TamSX3("GW8_PESOC" )[2]},; //50
			{"GW8_VALOR" , "N", TamSX3("GW8_VALOR" )[1], TamSX3("GW8_VALOR" )[2]},;
			{"GWN_CDTPOP", "C", TamSX3("GWN_CDTPOP")[1], 0},;
			{"GV4_DSTPOP", "C", TamSX3("GV4_DSTPOP")[1], 0},;
			{"GV5_SENTID", "C", TamSX3("GV5_SENTID")[1], 0},;
			{"GW1_USO"   , "C", TamSX3("GW1_USO"   )[1], 0},;
			{"Pr_TotPisC", "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Pr_VlFrtNr", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Pr_ICMSnr" , "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Pr_PISNorm", "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},; //60
			{"Pr_Redesp" , "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Pr_ICMSRed", "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Pr_PISRed" , "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Pr_TotRed" , "N", TamSX3("GWU_SEQ"   )[1], 0},;
			{"Pr_ICMSDia", "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Pr_PISDia" , "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Pr_TotDia" , "N", 4                      , 0},;
			{"Pr_VlReen" , "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Pr_ICMSRee", "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Pr_PISRee" , "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},; //70
			{"Pr_TotReen", "N", 4                      , 0},;
			{"Pr_VlDevol", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Pr_ICMSDev", "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Pr_PISDev" , "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Pr_TotDev" , "N", 4                      , 0},;
			{"Pr_VlAuton", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_TotFrt" , "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_TotICMS", "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Re_TotPisC", "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_FrtNorm", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},; //80
			{"Re_ICMSNr" , "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Re_PISNor" , "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_VlRedes", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_VlICRed", "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Re_VlPisRe", "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_TotRede", "N", 4                      , 0},;
			{"Re_VlDiari", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_ICMSDia", "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Re_PISDia" , "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_TotDia" , "N", 4                      , 0},;                       //90
			{"Re_VlTotRe", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_ICMSRe" , "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Re_PISRee" , "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_TotRee" , "N", 4                      , 0},;
			{"Re_VlTotDe", "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_ICMSDev", "N", TamSX3("GWF_VLICMS")[1], TamSX3("GWF_VLICMS")[2]},;
			{"Re_PISDev" , "N", TamSX3("GWF_VLPIS" )[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_TotDev" , "N", 4                      , 0},;
			{"Re_VlAuto" , "N", TamSX3("GWI_VLFRET")[1], TamSX3("GWI_VLFRET")[2]},;
			{"Re_TaxAuto", "N", TamSX3("GW2_VLINSS")[1], TamSX3("GW2_VLINSS")[2]},; //100
			{"Re_INSSAut", "N", TamSX3("GW2_VLINSS")[1], TamSX3("GW2_VLINSS")[2]},;
			{"UNINEG"    , "C", TamSX3("GW8_UNINEG")[1], 0},;
			{"LACRE"     , "C", TamSX3("GWN_LACRE" )[1], 0}}

	cTTBIDisp := GFECriaTab({aTT, {"FILIAL+TIPO_DC+GW1_EMISDC+GW1_SERDC+GW1_NRDC+TRANSP+ITEM+SEQUENCIA"}}, @oTmpTabDf)
Return cTTBIDisp
