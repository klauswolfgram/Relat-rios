/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
//#INCLUDE "TECR190"

//-------------------------------------------------------------------
/*/{Protheus.doc} TECR190
Elabora o relatorio de Extrato Locação

@author Cesar Bianchi
@since 02/10/2017
@version P12.1.20
/*/
//-------------------------------------------------------------------
Static cAutoPerg := "TECR190"

User Function TECR190()
	Local oReport	:= Nil
	Private cPerg	:= "TECR190" 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ PARAMETROS                                                             ³
	//³ MV_PAR01 : Data de ?                                                   ³
	//³ MV_PAR02 : Data ate?                                                   ³
	//³ MV_PAR03 : Cliente de ?                                                ³
	//³ MV_PAR04 : Cliente ate ?                                               ³
	//³ MV_PAR05 : Contrato de ?                                               ³
	//³ MV_PAR06 : Contrato ate ?                                              ³	
	//³ MV_PAR07 : Local de Atendimento de ?                                   ³
	//³ MV_PAR08 : Local de Atendimento  ate ?                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

	//Pinta o relatorio a partir das perguntas escolhidas
	oReport := ReportDef()   
	oReport:PrintDialog()  
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} reportDef
Monta as definiçoes do relatorio de Extrato Locação

@author Cesar Bianchi
@since 02/10/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()

	Local cTitulo 	:= "Extrato Locação"
	Local oReport
	Local oSection1
	Local oSection2
	Local oSection3
	Local oSection4
	Local oSection5
	
	If TYPE("cPerg") == "U"
		cPerg	:= "TECR190"
	EndIF
	
	oReport 	:= TReport():New(cPerg, cTitulo, cPerg , {|oReport| PrintReport(oReport)},"Extrato Locação")
	oSection1 := TRSection():New(oReport,"Contratos"				,{"AD1","ADY","TFJ","CN9"})					//"Contratos"
	oSection2 := TRSection():New(oReport,"Medições"				,{"TFZ","CND"})								//"Medições"
	oSection3 := TRSection():New(oReport,"Equipamentos"			,{"TFL","ABS","TFI","SB1","AA3","TEW"})		//"Equipamentos"
	oSection4 := TRSection():New(oReport,"Ordens de Serviço GS"	,{"AB6","AB7"})								//"Ordens de Serviço GS"
	oSection5 := TRSection():New(oReport,"Ordens de Serviço MNT"	,{"STJ"})									//"Ordens de Serviço MNT"
	
	//Define Propriedades do Relatorio (Cabeçalho, Orientação, Totais e SubTotais)
	oReport:ShowHeader()
	oReport:SetLandScape()
	oReport:SetTotalInLine(.F.)
	oSection1:SetTotalInLine(.F.)
	oSection2:SetTotalInLine(.F.)
	oSection3:SetTotalInLine(.F.)
	oSection4:SetTotalInLine(.F.)
	oSection5:SetTotalInLine(.F.)
	
	//Define colunas da SECAO 01 - CONTRATOS
	TRCell():New(oSection1, "AD1_NROPOR" 	, "AD1", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Nro Oportunidade"
	TRCell():New(oSection1, "ADY_PROPOS" 	, "ADY", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Nro Proposta"	
	TRCell():New(oSection1, "TFJ_CODIGO" 	, "TFJ", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Nro Orçamento"	
	TRCell():New(oSection1, "CN9_NUMERO" 	, "CN9", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Nro Contrato"
	TRCell():New(oSection1, "CN9_REVATU" 	, "CN9", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Rev Contrato"		
	TRCell():New(oSection1, "AD1_DESCRI" 	, "AD1", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Descrição"

	//Define colunas da SECAO 02 - MEDIÇOES
	TRCell():New(oSection2, "TFZ_APURAC" 	, "TFZ", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Nro Apuração"
	TRCell():New(oSection2, "TFZ_CODIGO" 	, "TFZ", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Item Apur."	
	TRCell():New(oSection2, "CND_NUMMED" 	, "CND", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Nro Medicao"	
	TRCell():New(oSection2, "CND_VLTOT" 	, "CN9", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Valor Total"		
	TRCell():New(oSection2, "CND_PEDIDO" 	, "AD1", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Pedido"
	
	//Define colunas da SECAO 03 - EQUIPAMENTOS
	TRCell():New(oSection3, "TFL_LOCAL" 	, "TFL", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Cod. Local de Atendimento"
	TRCell():New(oSection3, "ABS_DESCRI" 	, "ABS", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Descrição Local de Atendimento"
	TRCell():New(oSection3, "TEW_PRODUT" 	, "TEW", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Cód Produto"	
	TRCell():New(oSection3, "B1_DESC" 		, "SB1", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Descricao"	
	TRCell():New(oSection3, "AA3_NUMSER" 	, "AA3", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Numero de Serie"		
	TRCell():New(oSection3, "AA3_CHAPA" 	, "AA3", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Chapa"	
	TRCell():New(oSection3, "AA3_CODBEM" 	, "AA3", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//"Cód. Bem MNT"
	
	//Define colunas da SECAO 04 - ORDEM DE SERVIÇO GS
	TRCell():New(oSection4, "AB6_NUMOS" 	, "AB6", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//""
	TRCell():New(oSection4, "AB6_EMISSA" 	, "AB6", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//""
	
	//Define colunas da SECAO 04 - ORDEM DE SERVIÇO MNT
	TRCell():New(oSection5, "TJ_ORDEM" 		, "STJ", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//""
	TRCell():New(oSection5, "TJ_PLANO" 		, "STJ", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//""
	TRCell():New(oSection5, "TJ_DTORIGI" 	, "STJ", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//""
	TRCell():New(oSection5, "TJ_TIPOOS" 	, "STJ", /*Title*/ ,/*Picture*/		,/*Tam*/		,/*lPixel*/		,/*{|| code-block de impressao }*/)	//""
	
	//Define campos alinhados ao centro
	oSection4:Cell("AB6_EMISSA"):SetAlign("LEFT")
	oSection5:Cell("TJ_DTORIGI"):SetAlign("LEFT")	
	
Return (oReport) 


//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Busca os dados para impressao do relatorio de Extrato Locação

@author Cesar Bianchi
@since 02/10/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport(oReport)
	Local aArea		:= GetArea()	
	Local cCliDe	:= MV_PAR03
	Local cCliAt	:= MV_PAR04	
	Local oSection1	:= oReport:Section(1)
	Local oSection2	:= oReport:Section(2)
	Local oSection3	:= oReport:Section(3)
	Local oSection4	:= oReport:Section(4)
	Local oSection5	:= oReport:Section(5)
	
	Local cQrySct1	:= GetNextAlias()	
	Local cQrySct2	:= GetNextAlias()
	Local cQrySct3	:= GetNextAlias()
	Local cQrySct4	:= GetNextAlias()
	Local cQrySct5	:= GetNextAlias()
	
	//MakeSqlExp(cPerg)
	
	//**************************************//
	//*********** PRIMEIRA SECAO ***********//
	//**************************************//
	PrintSct1(oReport,@cQrySct1,cCliDe,cCliAt)
	
	dbSelectArea(cQrySct1)
	While (cQrySct1)->(!Eof())
		If !isBlind()
			oSection1:PrintLine()
		EndIf
		//*************************************//
		//*********** SEGUNDA SECAO ***********//
		//*************************************//	
		
		PrintSct2(oReport,@cQrySct2,(cQrySct1)->CN9_NUMERO,cCliDe,cCliAt)
		
		dbSelectArea(cQrySct2)
		While (cQrySct2)->(!Eof())
			If !isBlind()				
				oSection2:PrintLine()
			EndIf
			//**************************************//
			//*********** TERCEIRA SECAO ***********//
			//**************************************//
			
			PrintSct3(oReport,@cQrySct3,(cQrySct2)->CND_NUMMED,cCliDe,cCliAt)
			
			dbSelectArea(cQrySct3)
			While (cQrySct3)->(!Eof())
				If !isBlind()				
					oSection3:PrintLine()
				EndIf
				//**************************************//
				//*********** QUARTA SECAO ***********//
				//**************************************//
				
				PrintSct4(oReport,@cQrySct4,(cQrySct2)->CND_NUMMED,cCliDe,cCliAt)			
				
				dbSelectArea(cQrySct4)
				While (cQrySct4)->(!Eof())
					If !isBlind()				
						oSection4:PrintLine()
					EndIf
					//**************************************//
					//*********** QUINTA SECAO ***********//
					//**************************************//
				
					PrintSct5(oReport,@cQrySct5,(cQrySct2)->CND_NUMMED,cCliDe,cCliAt)
					
					While (cQrySct5)->(!Eof())
						If !isBlind()
							oSection5:PrintLine()
						EndIF
						(cQrySct5)->(dbSkip())
					EndDo
					
					(cQrySct5)->(dbCloseArea())
					oSection5:Finish()
					
					(cQrySct4)->(dbSkip())	
				EndDo
				
				(cQrySct4)->(dbCloseArea())
				oSection4:Finish()
				
				(cQrySct3)->(dbSkip())	
			EndDo
			
			(cQrySct3)->(dbCloseArea())
			oSection3:Finish()
			
			(cQrySct2)->(dbSkip())	
		EndDo
		
		(cQrySct2)->(dbCloseArea())
		oSection2:Finish()
		
				
		If oReport:Cancel()
			//botao cancelar
			Exit
		EndIf

		//Incremento da regua
		oReport:IncMeter()
		(cQrySct1)->(dbSkip())
	EndDo
	
	(cQrySct1)->(dbCloseArea())
	oSection1:Finish()

Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintSct1
Realiza a busca dos dados da primeira seção do relatorio

@author Cesar Bianchi
@since 02/10/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintSct1(oReport,cQrySct1,cCliDe,cCliAt)
	
	Local oSection1	:= oReport:Section(1)
	Local cWhrSct1	:= ""
	Local cWhrSct11	:= ""
	Local cWhrCN9	:= ""
	Local cCtrDe	:= MV_PAR05
	Local cCtrAt	:= MV_PAR06	
	
		BEGIN REPORT QUERY oReport:Section(1)
				
				//Monta a Clausula Where da Section 01
				cWhrSct1 	:= "% AND CNA.CNA_CLIENT BETWEEN '" + cCliDe + "' AND '" + cCliAt + "' %"
				cWhrSct11 	:= "% AND CN9.CN9_NUMERO BETWEEN '" + cCtrDe + "' AND '" + cCtrAt + "' %"
				cWhrCN9  	:= "% AND CN9.CN9_REVATU = ' ' %"
				
				//Monta a query da secao 1
				BeginSql alias cQrySct1
				
				SELECT ADY.ADY_PROPOS,AD1.AD1_DESCRI,CN9.CN9_NUMERO,
				CN9.CN9_DTINIC,CN9.CN9_DTFIM,CN9.CN9_VLINI,CN9.CN9_VLATU,CN9.CN9_SALDO, CN9.CN9_DTREV, 
				CN9.CN9_VLADIT, CN9.CN9_TPCTO, CN1.CN1_DESCRI, CN9.CN9_FLGCAU, CN9.CN9_MINCAU
				FROM %table:CN9% CN9
				
				JOIN %table:CN1% CN1
					ON CN1.CN1_FILIAL = %xfilial:CN1%
					AND CN1.CN1_CODIGO = CN9.CN9_TPCTO
					AND CN1.%notDel%
						
				LEFT JOIN %table:TFJ% TFJ
					ON TFJ.TFJ_FILIAL = %xfilial:TFJ%
					AND TFJ.TFJ_CONTRT = CN9.CN9_NUMERO
					AND TFJ.TFJ_CONREV = CN9.CN9_REVISA
					AND TFJ.%notDel%
						
				LEFT JOIN %table:ADY% ADY
					ON ADY.ADY_FILIAL = %xfilial:ADY%
					AND ADY.ADY_STATUS = 'B'
					AND ADY.ADY_PROPOS = TFJ.TFJ_PROPOS
					AND ADY.ADY_PREVIS = TFJ.TFJ_PREVIS
					AND ADY.%notDel%
					
				LEFT JOIN %table:AD1% AD1
					ON  AD1.AD1_FILIAL = %xfilial:AD1%
					AND AD1.AD1_NROPOR = ADY.ADY_OPORTU
					AND AD1.AD1_REVISA = ADY.ADY_REVISA
					AND AD1.AD1_STATUS = '9'
					AND AD1.%notDel%
									
				LEFT JOIN %table:SA3% SA3
					ON SA3.A3_FILIAL = %xfilial:SA3%
					AND SA3.A3_COD = AD1.AD1_VEND
					AND SA3.%notDel%
					
				WHERE CN9.CN9_FILIAL = %xfilial:CN9%
					AND CN9.CN9_REVATU = ' ' 
					AND CN9.CN9_SITUAC = '05'
					%exp:cWhrSct11%
					AND EXISTS ( 
							SELECT 1 FROM 
							%table:CNA% CNA
							WHERE CNA.CNA_FILIAL = %xfilial:CNA%
								AND CNA.CNA_CONTRA = CN9.CN9_NUMERO
								AND CNA.CNA_REVISA = CN9.CN9_REVISA
								%exp:cWhrSct1%
								AND CNA.%notDel% )
					%exp:cWhrCN9%
					AND CN9.%notDel%	
				
				EndSql
		
			END REPORT QUERY oReport:Section(1)	
		
			//Define tamanho da regua de processamento
			oReport:SetMeter((cQrySct1)->(RecCount()))
		
			//Monta a primeira secao do relatorio
			oSection1:Init()
			oSection1:SetHeaderSection(.T.)
Return 

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintSct2
Realiza a busca dos dados da segunda seção do relatorio

@author Cesar Bianchi
@since 02/10/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintSct2(oReport,cQrySct2,cContr,cCliDe,cCliAt)
	Local oSection2	:= oReport:Section(2)		
	Local cWhrSct2	:= ""
	Local cWhrCN9	:= ""
	Local cDtDe		:= MV_PAR01
	Local cDtAt		:= MV_PAR02	
		
		//Monta a Clausula Where da Section 02
		cWhrSct2 	:= "% AND CND.CND_CONTRA = '" + cContr + "' AND CND.CND_CLIENT BETWEEN '" + cCliDe + "' AND '" + cCliAt + "' AND CND.CND_DTINIC >= '" + Dtos(cDtDe) + "' AND CND.CND_DTFIM <= '" + Dtos(cDtAt) + "' %"
		cWhrCN9  := "% AND CN9.CN9_REVATU = ' ' %"
		BEGIN REPORT QUERY oReport:Section(2)
		
		//Monta a query da secao 2
		BeginSql alias cQrySct2
			SELECT ADY.ADY_PROPOS,AD1.AD1_DESCRI,CN9.CN9_NUMERO,
			CN9.CN9_DTINIC,CN9.CN9_DTFIM,CN9.CN9_VLINI,CN9.CN9_VLATU,CN9.CN9_SALDO,
			CND.CND_COMPET, CND.CND_NUMMED, CND.CND_DTINIC, CND.CND_VLTOT,CND.CND_DESCME,
			CND.CND_PEDIDO, CND.CND_NUMTIT, TFV.TFV_CODIGO
			FROM %table:CND% CND
			JOIN %table:CN9% CN9
				ON CN9.CN9_FILIAL = %xfilial:CN9%	
				AND CN9.CN9_NUMERO = CND.CND_CONTRA
				AND CN9.CN9_REVISA = CND.CND_REVISA
				%exp:cWhrCN9% 	
				AND CN9.%notDel%	 
			LEFT JOIN %table:TFJ% TFJ
				ON TFJ.TFJ_FILIAL = %xfilial:TFJ%
				AND TFJ.TFJ_CONTRT = CN9.CN9_NUMERO
				AND TFJ.TFJ_CONREV = CN9.CN9_REVISA
				AND TFJ.%notDel%
			LEFT JOIN %table:ADY% ADY
				ON ADY.ADY_FILIAL = %xfilial:ADY%
				AND ADY.ADY_PROPOS = TFJ.TFJ_PROPOS
				AND ADY.ADY_PREVIS = TFJ.TFJ_PREVIS
				AND ADY.%notDel%
			LEFT JOIN %table:AD1% AD1
				ON  AD1.AD1_FILIAL = %xfilial:AD1%
				AND AD1.AD1_NROPOR = ADY.ADY_OPORTU
				AND AD1.AD1_REVISA = ADY.ADY_REVISA
				AND AD1.AD1_CODCLI = CND.CND_CLIENT
				AND AD1.AD1_LOJCLI = CND.CND_LOJACL
				AND AD1.%notDel%	
			LEFT JOIN %table:TFV% TFV 
				ON TFV.TFV_FILIAL = %xfilial:TFV% 
				AND TFV.TFV_CONTRT = CND.CND_CONTRA
				AND TFV.TFV_REVISA = CND.CND_REVISA
				AND TFV.%notDel%
				AND ( 
					 EXISTS ( 
						SELECT 1 FROM %table:TFZ% TFZ
						WHERE TFZ.TFZ_FILIAL = %xfilial:TFZ%					
							AND TFZ.TFZ_APURAC = TFV.TFV_CODIGO
							AND TFZ.TFZ_NUMMED = CND.CND_NUMMED 
							AND TFZ.%notDel% ) 
					)
			WHERE CND.CND_FILIAL = %xfilial:CND%
				%exp:cWhrSct2% 
				AND CND.%notDel% 
			ORDER BY CN9.CN9_NUMERO, CN9.CN9_REVISA, CND.CND_NUMMED ASC 
		EndSql

		END REPORT QUERY oReport:Section(2)	
		
		//Monta a SEGUNDA secao do relatorio
		oSection2:Init()
		oSection2:SetHeaderSection(.T.)
Return 

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintSct3
Realiza a busca dos dados da terceira seção do relatorio

@author Cesar Bianchi
@since 02/10/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintSct3(oReport,cQrySct3,cNumMed,cCliDe,cCliAt)

	Local oSection3	:= oReport:Section(3)
	Local cWhrSct3	:= ""
	Local cWhrSct31	:= ""
	Local cWhrCN9	:= ""
	Local cWhrTFZ	:= ""
	Local cLocDe	:= MV_PAR07
	Local cLocAt	:= MV_PAR08		
		
		//Monta a Clausula Where da Section 02
		cWhrSct3  := "% AND AD1.AD1_CODCLI BETWEEN '" + cCliDe + "' AND '" + cCliAt + "' %"
		cWhrSct31 := "% AND TFL.TFL_LOCAL BETWEEN '" + cLocDe + "' AND '" + cLocAt + "' %"
		cWhrCN9  := "% AND CN9.CN9_REVATU = ' ' %"
		cWhrTFZ  := "% TFZ.TFZ_NUMMED = '" + cNumMed + "' %"
		BEGIN REPORT QUERY oReport:Section(3)
		
			//Monta a query da secao 3
			BeginSql alias cQrySct3
				SELECT TEW.TEW_BAATD, TEW.TEW_PRODUT, TEW.TEW_RESCOD, TEW.TEW_QTDRES, TEW.TEW_QTDVEN, TEW.TEW_QTDRET, 
				TEW.TEW_DTRINI, TEW.TEW_DTRFIM, TEW.TEW_DTSEPA, TEW.TEW_NUMPED, TEW.TEW_ITEMPV, TEW.TEW_SERSAI,
				TEW.TEW_NFSAI, TEW.TEW_ITSAI, TEW.TEW_CODKIT, TEW.TEW_KITSEQ,
				SB1.B1_DESC, CN9.CN9_NUMERO, ADY.ADY_PROPOS, AD1.AD1_NROPOR, AD1.AD1_DESCRI, TFL.TFL_LOCAL,
				ABS.ABS_DESCRI, TFI.TFI_ENTEQP, TFI.TFI_OSMONT, TFJ.TFJ_TPFRET, TFI.TFI_COLEQP,
				AA3.AA3_CODBEM, AA3.AA3_CHAPA, AA3.AA3_NUMSER
				FROM %table:TEW% TEW
					JOIN %table:TFI% TFI
						ON TFI.TFI_FILIAL = %xfilial:TFI%	
						 	AND TFI.TFI_COD = TEW.TEW_CODEQU 
						 	AND TFI.TFI_PRODUT = TEW.TEW_PRODUT
						 	AND TFI.%notDel%
					JOIN %table:TFZ% TFZ
						ON TFZ.TFZ_FILIAL = %xfilial:TFZ%	
						 	AND TFZ.TFZ_CODTFI = TFI.TFI_COD
						 	AND %exp:cWhrTFZ%
						 	AND TFZ.%notDel%	 	
					  JOIN %table:TIP% TIP
        				ON TIP.TIP_FILIAL = %xfilial:TIP%
           					AND TIP.TIP_ITAPUR = TFZ.TFZ_APURAC
           					AND TIP.TIP_CODEQU = TEW.TEW_BAATD
           					AND TIP.D_E_L_E_T_ = ' '  
					JOIN %table:TFL% TFL
						ON TFL.TFL_FILIAL = %xfilial:TFL%
						 	AND TFL.TFL_CODIGO = TFI.TFI_CODPAI 
						 	AND TFL.%notDel%
					JOIN %table:AA3% AA3
        				ON AA3.AA3_FILIAL = %xfilial:AA3%
           					AND AA3.AA3_CODPRO = TEW.TEW_PRODUT
           					AND AA3.AA3_NUMSER = TEW.TEW_BAATD
           					AND AA3.%notDel% 
					JOIN %table:TFJ% TFJ
						ON TFJ.TFJ_FILIAL = %xfilial:TFJ%
						 	AND TFJ.TFJ_CODIGO = TFL.TFL_CODPAI
						 	%exp:cWhrSct31%
						 	AND TFJ.%notDel%	
					JOIN %table:ADY% ADY
						ON ADY.ADY_FILIAL = %xfilial:ADY%
						 	AND ADY.ADY_PROPOS = TFJ.TFJ_PROPOS 
						 	AND ADY.ADY_PREVIS = TFJ.TFJ_PREVIS
						 	AND ADY.%notDel%	
					JOIN %table:AD1% AD1
						ON AD1.AD1_FILIAL = %xfilial:AD1%
						 	AND AD1.AD1_NROPOR = ADY.ADY_OPORTU 
						 	%exp:cWhrSct3%
						 	AND AD1.%notDel%
					JOIN %table:ABS% ABS
						ON ABS.ABS_FILIAL = %xfilial:ABS%
							AND ABS.ABS_LOCAL = TFL.TFL_LOCAL
						 	AND ABS.%notDel%	
					JOIN %table:SB1% SB1
						ON SB1.B1_FILIAL = %xfilial:SB1%
							AND SB1.B1_COD = TEW.TEW_PRODUT	
						 	AND SB1.%notDel%	
					JOIN %table:CN9% CN9
						 ON CN9.CN9_FILIAL = %xfilial:CN9%
						 	AND CN9.CN9_NUMERO = TFJ.TFJ_CONTRT 
						 	AND CN9.CN9_REVISA = TFJ.TFJ_CONREV
							%exp:cWhrCN9% 	
							AND CN9.CN9_SITUAC = '05'"
							AND CN9.%notDel%			
					 WHERE TEW.TEW_FILIAL = %xfilial:TEW%
					 	AND TEW.TEW_TIPO = '1' "
					 	AND TEW.TEW_MOTIVO NOT IN ('4','5') 
					 	AND TEW.TEW_DTSEPA <> ' '"
					 	AND TEW.TEW_DTRINI <> ' '"
					 	AND TEW.TEW_DTRFIM = ' ' "
					     AND TEW.TEW_BAATD <> ' ' "
						AND TEW.%notDel%	
					 ORDER BY TEW.TEW_BAATD, CN9.CN9_NUMERO	
				EndSql

		END REPORT QUERY oReport:Section(3)
		
		//Monta a Terceira secao do relatorio
		oSection3:Init()
		oSection3:SetHeaderSection(.T.)
Return 

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintSct4
Realiza a busca dos dados da quarta seção do relatorio

@author Cesar Bianchi
@since 02/10/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintSct4(oReport,cQrySct4,cNumMed,cCliDe,cCliAt)

	Local oSection4	:= oReport:Section(4)
	Local cWhrSct4	:= ""
	Local cWhrSct41	:= ""
	Local cWhrCN9	:= ""
	Local cWhrTFZ	:= ""
	Local cLocDe	:= MV_PAR07
	Local cLocAt	:= MV_PAR08		
		
		//Monta a Clausula Where da Section 02
		cWhrSct4  := "% AND AD1.AD1_CODCLI BETWEEN '" + cCliDe + "' AND '" + cCliAt + "' %"
		cWhrSct41 := "% AND TFL.TFL_LOCAL BETWEEN '" + cLocDe + "' AND '" + cLocAt + "' %"
		cWhrCN9  := "% AND CN9.CN9_REVATU = ' ' %"
		cWhrTFZ  := "% TFZ.TFZ_NUMMED = '" + cNumMed + "' %"
		BEGIN REPORT QUERY oReport:Section(4)
		
			//Monta a query da secao 3
			BeginSql alias cQrySct4
				SELECT TEW.TEW_BAATD, TEW.TEW_PRODUT, TEW.TEW_RESCOD, TEW.TEW_QTDRES, TEW.TEW_QTDVEN, TEW.TEW_QTDRET, 
				TEW.TEW_DTRINI, TEW.TEW_DTRFIM, TEW.TEW_DTSEPA, TEW.TEW_NUMPED, TEW.TEW_ITEMPV, TEW.TEW_SERSAI,
				TEW.TEW_NFSAI, TEW.TEW_ITSAI, TEW.TEW_CODKIT, TEW.TEW_KITSEQ,TEW.TEW_NUMOS,TEW.TEW_ITEMOS,
				SB1.B1_DESC, CN9.CN9_NUMERO, ADY.ADY_PROPOS, AD1.AD1_NROPOR, AD1.AD1_DESCRI, TFL.TFL_LOCAL,
				ABS.ABS_DESCRI, TFI.TFI_ENTEQP, TFI.TFI_OSMONT, TFJ.TFJ_TPFRET, TFI.TFI_COLEQP,
				AB6.AB6_NUMOS,AB6.AB6_EMISSA
				FROM %table:TEW% TEW
					JOIN %table:TFI% TFI
						ON TFI.TFI_FILIAL = %xfilial:TFI%	
						 	AND TFI.TFI_COD = TEW.TEW_CODEQU 
						 	AND TFI.TFI_PRODUT = TEW.TEW_PRODUT
						 	AND TFI.%notDel%
					JOIN %table:TFZ% TFZ
						ON TFZ.TFZ_FILIAL = %xfilial:TFZ%	
						 	AND TFZ.TFZ_CODTFI = TFI.TFI_COD
						 	AND %exp:cWhrTFZ%
						 	AND TFZ.%notDel%
					JOIN %table:AB6% AB6
						ON AB6.AB6_FILIAL = %xfilial:AB6%	
						 	AND AB6.AB6_NUMOS = TEW.TEW_NUMOS 
						 	AND AB6.%notDel%	 	
					JOIN %table:TFL% TFL
						ON TFL.TFL_FILIAL = %xfilial:TFL%
						 	AND TFL.TFL_CODIGO = TFI.TFI_CODPAI 
						 	AND TFL.%notDel%
					JOIN %table:TFJ% TFJ
						ON TFJ.TFJ_FILIAL = %xfilial:TFJ%
						 	AND TFJ.TFJ_CODIGO = TFL.TFL_CODPAI
						 	%exp:cWhrSct41%
						 	AND TFJ.%notDel%	
					JOIN %table:ADY% ADY
						ON ADY.ADY_FILIAL = %xfilial:ADY%
						 	AND ADY.ADY_PROPOS = TFJ.TFJ_PROPOS 
						 	AND ADY.ADY_PREVIS = TFJ.TFJ_PREVIS
						 	AND ADY.%notDel%	
					JOIN %table:AD1% AD1
						ON AD1.AD1_FILIAL = %xfilial:AD1%
						 	AND AD1.AD1_NROPOR = ADY.ADY_OPORTU 
						 	%exp:cWhrSct4%
						 	AND AD1.%notDel%
					JOIN %table:ABS% ABS
						ON ABS.ABS_FILIAL = %xfilial:ABS%
							AND ABS.ABS_LOCAL = TFL.TFL_LOCAL
						 	AND ABS.%notDel%	
					JOIN %table:SB1% SB1
						ON SB1.B1_FILIAL = %xfilial:SB1%
							AND SB1.B1_COD = TEW.TEW_PRODUT	
						 	AND SB1.%notDel%	
					JOIN %table:CN9% CN9
						 ON CN9.CN9_FILIAL = %xfilial:CN9%
						 	AND CN9.CN9_NUMERO = TFJ.TFJ_CONTRT 
						 	AND CN9.CN9_REVISA = TFJ.TFJ_CONREV
							%exp:cWhrCN9% 
							AND CN9.CN9_SITUAC = '05'"
							AND CN9.%notDel%			
					 WHERE TEW.TEW_FILIAL = %xfilial:TEW%
					 	AND TEW.TEW_TIPO = '1' "
					 	AND TEW.TEW_MOTIVO NOT IN ('4','5') 
					 	AND TEW.TEW_DTSEPA <> ' '"
					 	AND TEW.TEW_DTRINI <> ' '"
					 	AND TEW.TEW_DTRFIM = ' ' "
					     AND TEW.TEW_BAATD <> ' ' "
						AND TEW.%notDel%	
					 ORDER BY TEW.TEW_BAATD, CN9.CN9_NUMERO	
				EndSql

		END REPORT QUERY oReport:Section(3)
		
		//Monta a Terceira secao do relatorio
		oSection4:Init()
		oSection4:SetHeaderSection(.T.)
Return 

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintSct5
Realiza a busca dos dados da quinta seção do relatorio

@author Cesar Bianchi
@since 02/10/2017
@version P12.1.20
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintSct5(oReport,cQrySct5,cNumMed,cCliDe,cCliAt)

	Local oSection5	:= oReport:Section(5)
	Local cWhrSct5	:= ""
	Local cWhrSct51	:= ""
	Local cWhrCN9	:= ""
	Local cWhrTFZ	:= ""
	Local cLocDe	:= MV_PAR07
	Local cLocAt	:= MV_PAR08		
		
		//Monta a Clausula Where da Section 05
		cWhrSct5  := "% AND AD1.AD1_CODCLI BETWEEN '" + cCliDe + "' AND '" + cCliAt + "' %"
		cWhrSct51 := "% AND TFL.TFL_LOCAL BETWEEN '" + cLocDe + "' AND '" + cLocAt + "' %"
		cWhrCN9  := "% AND CN9.CN9_REVATU = ' ' %"
		cWhrTFZ  := "% TFZ.TFZ_NUMMED = '" + cNumMed + "' %"
		BEGIN REPORT QUERY oReport:Section(5)
		
			//Monta a query da secao 5
			BeginSql alias cQrySct5
				SELECT TEW.TEW_BAATD, TEW.TEW_PRODUT, TEW.TEW_RESCOD, TEW.TEW_QTDRES, TEW.TEW_QTDVEN, TEW.TEW_QTDRET, 
				TEW.TEW_DTRINI, TEW.TEW_DTRFIM, TEW.TEW_DTSEPA, TEW.TEW_NUMPED, TEW.TEW_ITEMPV, TEW.TEW_SERSAI,
				TEW.TEW_NFSAI, TEW.TEW_ITSAI, TEW.TEW_CODKIT, TEW.TEW_KITSEQ,TEW.TEW_NUMOS,TEW.TEW_ITEMOS,TEW.TEW_CODCLI,TEW.TEW_LOJCLI, 
				SB1.B1_DESC, CN9.CN9_NUMERO, ADY.ADY_PROPOS, AD1.AD1_NROPOR, AD1.AD1_DESCRI, TFL.TFL_LOCAL,
				ABS.ABS_DESCRI, TFI.TFI_ENTEQP, TFI.TFI_OSMONT, TFJ.TFJ_TPFRET, TFI.TFI_COLEQP,
				STJ.TJ_ORDEM,STJ.TJ_PLANO,STJ.TJ_DTORIGI,STJ.TJ_TIPOOS
				FROM %table:TEW% TEW
					JOIN %table:TFI% TFI
						ON TFI.TFI_FILIAL = %xfilial:TFI%	
						 	AND TFI.TFI_COD = TEW.TEW_CODEQU 
						 	AND TFI.TFI_PRODUT = TEW.TEW_PRODUT
						 	AND TFI.%notDel%
					JOIN %table:TFZ% TFZ
						ON TFZ.TFZ_FILIAL = %xfilial:TFZ%	
						 	AND TFZ.TFZ_CODTFI = TFI.TFI_COD
						 	AND %exp:cWhrTFZ%
						 	AND TFZ.%notDel%	 	
					JOIN %table:AA3% AA3
						ON AA3.AA3_FILIAL = %xfilial:AA3%	
						 	AND AA3.AA3_CODPRO = TEW.TEW_PRODUT
						 	AND AA3.AA3_NUMSER = TEW.TEW_BAATD
						 	AND AA3.AA3_CODCLI = TEW.TEW_CODCLI
						 	AND AA3.AA3_LOJA = TEW.TEW_LOJCLI 
						 	AND AA3.%notDel%	 	
					JOIN %table:ST9% ST9
						ON ST9.T9_FILIAL = %xfilial:ST9%	
						 	AND ST9.T9_CODESTO = AA3.AA3_CODPRO
						 	AND ST9.T9_SERIE = AA3.AA3_NUMSER
						 	AND ST9.T9_CODBEM = AA3.AA3_CODBEM
						 	AND ST9.%notDel%
					JOIN %table:STJ% STJ
						ON STJ.TJ_FILIAL = %xfilial:STJ%	
						 	AND STJ.TJ_CODBEM = ST9.T9_CODBEM
						 	AND STJ.%notDel%	 			 	
					JOIN %table:TFL% TFL
						ON TFL.TFL_FILIAL = %xfilial:TFL%
						 	AND TFL.TFL_CODIGO = TFI.TFI_CODPAI 
						 	AND TFL.%notDel%
					JOIN %table:TFJ% TFJ
						ON TFJ.TFJ_FILIAL = %xfilial:TFJ%
						 	AND TFJ.TFJ_CODIGO = TFL.TFL_CODPAI
						 	%exp:cWhrSct51%
						 	AND TFJ.%notDel%	
					JOIN %table:ADY% ADY
						ON ADY.ADY_FILIAL = %xfilial:ADY%
						 	AND ADY.ADY_PROPOS = TFJ.TFJ_PROPOS 
						 	AND ADY.ADY_PREVIS = TFJ.TFJ_PREVIS
						 	AND ADY.%notDel%	
					JOIN %table:AD1% AD1
						ON AD1.AD1_FILIAL = %xfilial:AD1%
						 	AND AD1.AD1_NROPOR = ADY.ADY_OPORTU 
						 	%exp:cWhrSct5%
						 	AND AD1.%notDel%
					JOIN %table:ABS% ABS
						ON ABS.ABS_FILIAL = %xfilial:ABS%
							AND ABS.ABS_LOCAL = TFL.TFL_LOCAL
						 	AND ABS.%notDel%	
					JOIN %table:SB1% SB1
						ON SB1.B1_FILIAL = %xfilial:SB1%
							AND SB1.B1_COD = TEW.TEW_PRODUT	
						 	AND SB1.%notDel%	
					JOIN %table:CN9% CN9
						 ON CN9.CN9_FILIAL = %xfilial:CN9%
						 	AND CN9.CN9_NUMERO = TFJ.TFJ_CONTRT 
						 	AND CN9.CN9_REVISA = TFJ.TFJ_CONREV
							%exp:cWhrCN9% 
							AND CN9.CN9_SITUAC = '05'"
							AND CN9.%notDel%			
					 WHERE TEW.TEW_FILIAL = %xfilial:TEW%
					 	AND TEW.TEW_TIPO = '1' "
					 	AND TEW.TEW_MOTIVO NOT IN ('4','5') 
					 	AND TEW.TEW_DTSEPA <> ' '"
					 	AND TEW.TEW_DTRINI <> ' '"
					 	AND TEW.TEW_DTRFIM = ' ' "
					     AND TEW.TEW_BAATD <> ' ' "
						AND TEW.%notDel%	
					 ORDER BY TEW.TEW_BAATD, CN9.CN9_NUMERO	
				EndSql

		END REPORT QUERY oReport:Section(5)
		
		//Monta a Terceira secao do relatorio
		oSection5:Init()
		oSection5:SetHeaderSection(.T.)
Return 

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg