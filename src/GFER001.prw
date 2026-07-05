/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

User Function GFER001()
	Local oReport := Nil // Objeto que contém o relatório
	
	Private cTabMov		:= ""
	Private cTabLot 	:= ""
	Private cTabSub 	:= ""
	Private cCriRat 	:= SuperGetMV("MV_CRIRAT",,"1")
	Private cTpDesp		:= ""
	Private cTotLot 	:= 0
	Private cTotSub 	:= 0
	Private cCtICMS 	:= ""
	Private cCcICMS 	:= ""
	Private cCtPIS		:= ""
	Private cCcPIS		:= ""
	Private cCtCOF  	:= ""
	Private cCcCOF		:= ""
	Private cCredICMS 	:= 0
	Private cCredIBS 	:= 0
	Private cCredIBM 	:= 0
	Private cCredCBS 	:= 0
	Private cCredPIS	:= 0
	Private cCredCOFI	:= 0
	Private nVlFret 	:= 0
	Private nVlFrTot 	:= 0
	Private cNRCALC := ""
	Private cTPCALC := ""
	Private cNMCIDORI := ""
	Private cCDUFORI := ""
	Private cNMCIDDES := ""
	Private cCDUFDES := ""

	Pergunte("GFER001", .F.)

	If TRepInUse() // teste padrão
		//-- Interface de impressão
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

Return

Static Function ReportDef()
	Local oReport, oSection1
//	Local cData := __FWLibVersion()
	
	oReport:= TReport():New("GFER001","Extrato Contábil de Frete","GFER001", {|oReport| ReportPrint(oReport)},)
	oReport:SetLandscape()   
	oReport:HideParamPage()
	oReport:SetTotalInLine(.F.)
	oReport:SetColSpace(2,.F.)
	oReport:nFontBody := 10
	oReport:SetUseGC(.F.) // Desabilita a Gestão de Empresas, mesmo existindo
	
	if .T. //(cData >= "20180413") // Somente a partir desta versão existe a propriedade lExcelWrXml no TReport
		oReport:lExcelWrXml := .T.
	EndIf

	oSection1 := TRSection():New(oReport,"Extrato Contábil de Frete",)
	oSection1:SetLineStyle() //Define a impressao da secao em linha
	oSection1:SetTotalInLine(.F.)

	
	TRCell():New(oSection1, "SToD((cTabMov)->DTMOV)"		, "(cTabMov)"	, "DATA DE MOVIMENTO"			, "@!"							,TamSX3("GXE_FILIAL")[1]	,.T.,)
	TRCell():New(oSection1, "cTpDesp"						, "(cTabMov)"	, "TIPO DE DESPESA"		    	, "@!"							,20							,.T.,{|| cTpDesp})
	TRCell():New(oSection1, "(cTabMov)->GWM_FILIAL"			, "(cTabMov)"	, "FILIAL"						, "@!"							,TamSX3("GWM_FILIAL")[1]	,.T.,)
	
	TRCell():New(oSection1, "cNomeFil", "(cTabMov)"	, "NOME DA FILIAL"			    , "@!"							,50							,.T., {|| FwFilName(cEmpAnt,(cTabMov)->GWM_FILIAL)})
	
	TRCell():New(oSection1, "(cTabMov)->IDEMIS"				, "(cTabMov)"	, "CNPJ/CPF EMISSOR" 			, "@!"							,TamSX3("GU3_IDFED")[1] 	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->NMEMIS"				, "(cTabMov)"	, "EMISSOR DOC CARGA"			, "@!"							,TamSX3("GU3_NMEMIT")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_SERDC"			, "(cTabMov)"	, "SÉRIE"						, "@!"							,TamSX3("GW1_SERDC")[1] 	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_NRDC"			, "(cTabMov)"	, "NR DOC CARGA"				, "@!"							,TamSX3("GW1_NRDC")[1]  	,.T.,)
	TRCell():New(oSection1, "SToD((cTabMov)->GWM_DTEMDC)"	, "(cTabMov)"	, "EMISSÃO DOC CARGA"			, "@!"							,TamSX3("GW1_EMISDC")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_CDTPDC"			, "(cTabMov)"	, "TIPO DOC CARGA"				, "@!"							,TamSX3("GW1_CDTPDC")[1]	,.T.,)
	//------------init-----------
	TRCell():New(oSection1, "cTipoCont"						, "(cTabMov)"   , "TIPO CONTÁBIL"				, "@!"							,TamSX3("GV5_FRCTB")[1]		,.T.,{||U_RetTpCtb((cTabMov)->GWM_CDTPDC)})
	
	TRCell():New(oSection1, "cFinDocCarg", "(cTabMov)"  	, "FINALIDADE DOC CARGA"	    , "@!"							,30							,.T.,{||U_RetUso((cTabMov)->GWM_FILIAL, (cTabMov)->GWM_CDTPDC, (cTabMov)->GW1_EMISDC, ;
					          																																						   (cTabMov)->GWM_SERDC, (cTabMov)->GWM_NRDC)})
	oFldHide := TRCell():New(oSection1, "(cTabMov)->IDREM"	, "(cTabMov)"	, "CNPJ/CPF REMETENTE" 			, "@!"							,TamSX3("GU3_IDFED")[1] 	,.T.,)
	oFldHide:lUserEnabled := .F.
	
	TRCell():New(oSection1, "(cTabMov)->NMREM"				, "(cTabMov)"	, "REMETENTE"					, "@!"							,TamSX3("GU3_NMEMIT")[1]	,.T.,)
	
	oFldHide := TRCell():New(oSection1, "(cTabMov)->IDDEST"	, "(cTabMov)"	, "CNPJ/CPF DESTINATÁRIO"    	, "@!"							,TamSX3("GU3_IDFED")[1] 	,.T.,)
	oFldHide:lUserEnabled := .F.
	
	TRCell():New(oSection1, "(cTabMov)->NMDEST"				, "(cTabMov)"	, "DESTINATÁRIO"				, "@!"							,TamSX3("GU3_NMEMIT")[1]	,.T.,)
	//------------end----------
	TRCell():New(oSection1, "(cTabMov)->GWM_NRDOC"			, "(cTabMov)"	, "NR CÁLCULO"					, "@!"							,TamSX3("GWM_NRDOC")[1] 	,.T.,{|| cNRCALC})
	TRCell():New(oSection1, "(cTabMov)->GXD_CODLOT"			, "(cTabMov)"	, "LOTE DE PROVISÃO"			, "@!"							,TamSX3("GXD_CODLOT")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GXE_PERIOD"			, "(cTabMov)"	, "PERÍODO DO LOTE"				, "@!"							,TamSX3("GXE_PERIOD")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GXE_SIT"			, "(cTabMov)"	, "SITUAÇÃO DO LOTE"			, "@!"							,30	  						,.T.,{|| U_RetSitGXE((cTabMov)->GXE_SIT)})
	TRCell():New(oSection1, "(cTabMov)->GXF_VALOR"          , "(cTabMov)"   , "VALOR DO LOTE"				, "@E 999,999,999,999.9999"		,TamSX3("GXF_VALOR")[1] 	,.T.,{|| cTotLot})
	TRCell():New(oSection1, "(cTabMov)->GXD_CODEST"			, "(cTabMov)"	, "SUBLOTE DE ESTORNO"  		, "@!"							,TamSX3("GXD_CODEST")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GXD_MOTIES"			, "(cTabMov)" 	, "MOTIVO DE ESTORNO"  			, "@!"							,30							,.T.,{|| U_RetMotGXD((cTabMov)->GXD_MOTIES)})
	TRCell():New(oSection1, "(cTabMov)->GXN_PERIES"			, "(cTabMov)"	, "PERÍODO DO SUBLOTE"  		, "@!"							,TamSX3("GXN_PERIES")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GXN_SIT" 			, "(cTabMov)"	, "SITUAÇÃO DO SUBLOTE" 		, "@!" 							,TamSX3("GXN_SIT")[1] 		,.T.,{|| U_RetSitGXN((cTabMov)->GXN_SIT)})
	TRCell():New(oSection1, "(cTabMov)->GXO_VALOR"			, "(cTabMov)"	, "VALOR DO SUBLOTE"	   		, "@E 999,999,999,999.9999" 	,TamSX3("GXO_VALOR")[1]		,.T.,{|| cTotSub})
	TRCell():New(oSection1, "(cTabMov)->GW3_SERDF"			, "(cTabMov)"	, "SÉRIE DOC FRETE"				, "@!"							,TamSX3("GW3_SERDF")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW3_NRDF"			, "(cTabMov)"	, "NR DOC FRETE"				, "@!"							,TamSX3("GW3_NRDF")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW3_CDESP"			, "(cTabMov)"	, "ESPÉCIE DOC FRETE"			, "@!"							,TamSX3("GW3_CDESP")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW3_TPDF"			, "(cTabMov)"	, "TIPO DOC FRETE"				, "@!"							,30							,.T.,{|| U_RetTpGW3((cTabMov)->GW3_TPDF)})
	TRCell():New(oSection1, "SToD((cTabMov)->GW3_DTEMIS)"	, "(cTabMov)"	, "EMISSÃO DOC FRETE"			, "@!"							,TamSX3("GW3_DTEMIS")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW3_SIT"			, "(cTabMov)"	, "SITUAÇÃO DOC FRETE"			, "@!"							,30							,.T.,{|| U_RetSitGW3((cTabMov)->GW3_SIT)})
	TRCell():New(oSection1, "(cTabMov)->GW3_SITFIS"			, "(cTabMov)"	, "SITUAÇÃO FISCAL DOC FRETE"	, "@!"							,30							,.T.,{|| U_RetFisGW3((cTabMov)->GW3_SITFIS)})
	TRCell():New(oSection1, "SToD((cTabMov)->GW3_DTFIS)"	, "(cTabMov)"	, "DATA FISCAL"					, "@!"							,TamSX3("GW3_DTFIS")[1]		,.T.,)
	//------------init---------------------
	TRCell():New(oSection1, "(cTabMov)->GW3_SITREC"			, "(cTabMov)"	, "SITUAÇÃO REC"				, "@!"							,TamSX3("GW3_SITREC")[1]	,.T.,{||U_RetFisGW3((cTabMov)->GW3_SITREC)})
	TRCell():New(oSection1, "SToD((cTabMov)->GW3_DTREC)"	, "(cTabMov)"	, "DATA REC"					, "@!"							,TamSX3("GW3_DTREC")[1]		,.T.,)
	//--------------end-------------------
	TRCell():New(oSection1, "(cTabMov)->GW3_VLDF"			, "(cTabMov)"	, "VALOR DOC FRETE"				, "@E 999,999,999,999.9999"		,TamSX3("GW3_VLDF")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW6_NRFAT"			, "(cTabMov)"	, "NR FATURA"					, "@!"							,TamSX3("GW6_NRFAT")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW6_SITAPR"			, "(cTabMov)"	, "SITUAÇÃO FATURA"				, "@!"							,30							,.T.,{|| U_RetSitGW6((cTabMov)->GW6_SITAPR)})
	TRCell():New(oSection1, "(cTabMov)->GW6_SITFIN"			, "(cTabMov)" 	, "SITUAÇÃO FIN FATURA"			, "@!"							,30							,.T.,{|| U_RetFinGW6((cTabMov)->GW6_SITFIN)})
	TRCell():New(oSection1, "SToD((cTabMov)->GW6_DTFIN)"	, "(cTabMov)"	, "DATA FIN FATURA"				, "@!"							,TamSX3("GW6_DTFIN")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW6_VLFATU"			, "(cTabMov)"	, "VALOR FATURA"				, "@E 999,999,999,999.9999"		,TamSX3("GW6_VLFATU")[1]	,.T.,)
	//----------------init------------------
	TRCell():New(oSection1, "(cTabMov)->GWF_TPCALC"			, "(cTabMov)"	, "TIPO DE FRETE"				, "@!"							,TamSX3("GWF_TPCALC")[1] 	,.T.,{||U_RetTpGW3(cTPCALC)})
	TRCell():New(oSection1, "(cTabMov)->TPSERV"			    , "(cTabMov)"	, "TIPO DE SERVIÇO"				, "@!"							,TamSX3("GWF_CDTPSE")[1] 	,.T.,)
	//----------------end------------------
	TRCell():New(oSection1, "(cTabMov)->GWM_CDTRP"			, "(cTabMov)"	, "COD TRANSPORTADOR"			, "@!"							,TamSX3("GU3_CDEMIT")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->IDTRP"				, "(cTabMov)"	, "CNPJ/CPF TRANSPORTADOR"		, "@!"							,TamSX3("GU3_IDFED")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->NMTRP"				, "(cTabMov)"	, "TRANSPORTADOR"				, "@!"							,TamSX3("GU3_NMEMIT")[1]	,.T.,)
	//----------------init------------------
	TRCell():New(oSection1, "(cTabMov)->TPTRP"				, "(cTabMov)"	, "TIPO TRANSPORTADOR"			, "@!"							,TamSX3("GU3_TRANSP")[1]	,.T.,{||U_RetTpTrp((cTabMov)->AUTON)})
	TRCell():New(oSection1, "(cTabMov)->TPTRIB"			    , "(cTabMov)"	, "REGIME TRIBUTÁRIO"			, "@!"							,TamSX3("GU3_TPTRIB")[1]	,.T.,{||U_RetTpTrb((cTabMov)->TPTRIB)})
	TRCell():New(oSection1, "(cTabMov)->GU3_MODAL"			, "(cTabMov)"	, "MODAL"						, "@!"							,TamSX3("GU3_MODAL")[1]	    ,.T.,{||U_RetTpMod((cTabMov)->GU3_MODAL)})
	//----------------end------------------
	TRCell():New(oSection1, "(cTabMov)->GWU_NRCIDO"			, "(cTabMov)"	, "CIDADE ORIGEM"				, "@!"							,TamSX3("GWU_NRCIDO")[1]	,.T.,{|| cNMCIDORI })
	TRCell():New(oSection1, "(cTabMov)->GWU_UFO"			, "(cTabMov)"	, "UF DE ORIGEM"				, "@!"							,TamSX3("GWU_UFO")[1]		,.T.,{|| cCDUFORI })
	TRCell():New(oSection1, "(cTabMov)->GWU_NRCIDD"			, "(cTabMov)"	, "CIDADE DESTINO"				, "@!"							,TamSX3("GWU_NRCIDD")[1]	,.T.,{|| cNMCIDDES })
	TRCell():New(oSection1, "(cTabMov)->GWU_UFD"			, "(cTabMov)"	, "UF DE DESTINO"				, "@!"							,TamSX3("GWU_UFD")[1]		,.T.,{|| cCDUFDES })
	TRCell():New(oSection1, "(cTabMov)->GWM_ITEM"			, "(cTabMov)"	, "CÓDIGO DO ITEM"				, "@!"							,TamSX3("GWM_ITEM")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW8_DSITEM"			, "(cTabMov)"	, "DESCRIÇÃO DO ITEM"			, "@!"							,TamSX3("GW8_DSITEM")[1]	,.T.,)
	//----------------init------------------
	If 	SuperGetMV('MV_ERPGFE',,'1') == '1'
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO1"		, "(cTabMov)"	, "NATUREZA DE OPERAÇÃO"	, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO2"		, "(cTabMov)"	, "CANAL DE VENDAS"			, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO3"		, "(cTabMov)"	, "GRUPO DE ESTOQUE"		, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO4"		, "(cTabMov)"	, "FAMÍLIA COMERCIAL"		, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO5"		, "(cTabMov)"	, "FAMÍLIA DE MATERIAIS"	, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
	Else
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO1"		, "(cTabMov)"	, "TIPO PRODUTO"			, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO2"		, "(cTabMov)"	, "GRUPO"					, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO3"		, "(cTabMov)"	, "TIPO SAIDA"				, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO4"		, "(cTabMov)"	, "CLASSE VALOR"			, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
		TRCell():New(oSection1, "(cTabMov)->GW8_INFO5"		, "(cTabMov)"	, "CENTRO DE CUSTO"			, "@!"							,TamSX3("GW8_INFO1")[1]		,.T.,)
	EndIf
	TRCell():New(oSection1, "(cTabMov)->GW8_VOLUME"			, "(cTabMov)"	, "CUBAGEM"					, "@!"							,TamSX3("GW8_VOLUME")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW8_QTDE"			, "(cTabMov)"	, "QUANTIDADE"				, "@!"							,TamSX3("GW8_QTDE")[1]		,.T.,)
	If GFXCP12123("GW8_UNIMED") 
		TRCell():New(oSection1, "(cTabMov)->GW8_UNIMED"		, "(cTabMov)"	, "UNIDADE DE MEDIDA"		, "@!"		,TamSX3("GW8_UNIMED")[1]		,.T.,)
	EndIf
	TRCell():New(oSection1, "(cTabMov)->GW8_QTDALT"			, "(cTabMov)"	, "PESO LÍQUIDO"			, "@E 999,999,999,999.9999"		,TamSX3("GW8_QTDALT")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW8_PESOC"			, "(cTabMov)"	, "PESO CUBADO"				, "@E 999,999,999,999.9999"		,TamSX3("GW8_PESOC")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GW8_PESOR"			, "(cTabMov)"	, "PESO REAL"				, "@E 999,999,999,999.9999"		,TamSX3("GW8_PESOR")[1]		,.T.,)
	
	TRCell():New(oSection1, "(cTabMov)->GW8_VALOR"			, "(cTabMov)"	, "VALOR DO ITEM"			, "@E 999,999,999,999.9999"		,TamSX3("GW8_VALOR")[1]		,.T.,)
	
	TRCell():New(oSection1, "(cTabMov)->GWM_GRP1"			, "(cTabMov)"	, "GRUPO CONTÁBIL - " + U_RetTpGrp(SuperGetMV('MV_TPGRP1',,'1'))  , "@!"				,TamSX3("GWM_GRP1")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_GRP2"			, "(cTabMov)"	, "GRUPO CONTÁBIL - " + U_RetTpGrp(SuperGetMV('MV_TPGRP2',,'1'))  , "@!"				,TamSX3("GWM_GRP2")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_GRP3"			, "(cTabMov)"	, "GRUPO CONTÁBIL - " + U_RetTpGrp(SuperGetMV('MV_TPGRP3',,'1'))  , "@!"				,TamSX3("GWM_GRP3")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_GRP4"			, "(cTabMov)"	, "GRUPO CONTÁBIL - " + U_RetTpGrp(SuperGetMV('MV_TPGRP4',,'1'))  , "@!"				,TamSX3("GWM_GRP4")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_GRP5"			, "(cTabMov)"	, "GRUPO CONTÁBIL - " + U_RetTpGrp(SuperGetMV('MV_TPGRP5',,'1'))  , "@!"				,TamSX3("GWM_GRP5")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_GRP6"			, "(cTabMov)"	, "GRUPO CONTÁBIL - " + U_RetTpGrp(SuperGetMV('MV_TPGRP6',,'1'))  , "@!"				,TamSX3("GWM_GRP6")[1]		,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_GRP7"			, "(cTabMov)"	, "GRUPO CONTÁBIL - " + U_RetTpGrp(SuperGetMV('MV_TPGRP7',,'1'))  , "@!"				,TamSX3("GWM_GRP7")[1]		,.T.,)
	//----------------end------------------
	TRCell():New(oSection1, "(cTabMov)->GWM_UNINEG"			, "(cTabMov)"	, "UNIDADE DE NEGÓCIO"			, "@!"							,TamSX3("GWM_UNINEG")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_CTFRET"			, "(cTabMov)"	, "CONTA CONTÁBIL DE FRETE"		, "@!"							,TamSX3("GWM_CTFRET")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_CCFRET"			, "(cTabMov)"	, "CENTRO DE CUSTO DE FRETE"	, "@!"							,TamSX3("GWM_CCFRET")[1]	,.T.,)
	TRCell():New(oSection1, "(cTabMov)->GWM_VLFRET"			, "(cTabMov)"	, "VALOR DE FRETE TOTAL" 		, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLFRET")[1]	,.T.,{|| nVlFrTot})
	TRCell():New(oSection1, "nVlFret"			, "(cTabMov)"	, "VALOR DE FRETE"				, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLFRET")[1]	,.T.,{|| nVlFret})	
	TRCell():New(oSection1, "(cTabMov)->GWM_CTICMS"			, "(cTabMov)" 	, "CONTA CONTÁBIL DE ICMS"		, "@!"							,TamSX3("GWM_CTICMS")[1]	,.T.,{|| cCtICMS})
	TRCell():New(oSection1, "(cTabMov)->GWM_CCICMS"			, "(cTabMov)" 	, "CENTRO DE CUSTO DE ICMS"		, "@!"							,TamSX3("GWM_CCICMS")[1]	,.T.,{|| cCcICMS})
	TRCell():New(oSection1, "(cTabMov)->GWM_VLICMS"			, "(cTabMov)"	, "VALOR DE ICMS"				, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLICMS")[1]	,.T.,)
	TRCell():New(oSection1, "cCredICMS"			, "(cTabMov)"	, "CRÉDITO DE ICMS"				, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLICMS")[1] 	,.T.,{|| cCredICMS})
	TRCell():New(oSection1, "(cTabMov)->GWM_VLISS"			, "(cTabMov)"	, "VALOR DE ISS"				, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLISS")[1]		,.T.,)
	TRCell():New(oSection1, "cISSRet"						, "(cTabMov)"	, "VALOR DE ISS RETIDO"			, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLISS")[1]		,.T.,{|| cISSRet})

	If GFXCP2510('GWM_VLIBS')
		TRCell():New(oSection1, "(cTabMov)->GWM_VLIBS"			, "(cTabMov)"	, "VALOR DE IBS ESTADUAL"		, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLIBS")[1]	,.T.,)
	EndIf
	If GFXCP2510('GWM_VLIBM')
		TRCell():New(oSection1, "(cTabMov)->GWM_VLIBM"			, "(cTabMov)"	, "VALOR DE IBS MUNICIPAL"		, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLIBM")[1]	,.T.,)
	EndIf
	If GFXCP2510('GWM_VLCBS')
		TRCell():New(oSection1, "(cTabMov)->GWM_VLCBS"			, "(cTabMov)"	, "VALOR DE CBS"				, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLCBS")[1]	,.T.,)
	EndIf
	
	TRCell():New(oSection1, "cCtPIS"						, "(cTabMov)" 	, "CONTA CONTÁBIL DE PIS"		, "@!"							,TamSX3("GWM_CTPIS")[1]		,.T.,{|| cCtPIS})
	TRCell():New(oSection1, "cCcPIS"						, "(cTabMov)" 	, "CENTRO DE CUSTO DE PIS"		, "@!"							,TamSX3("GWM_CCPIS")[1]		,.T.,{|| cCcPIS})
	TRCell():New(oSection1, "cCredPIS"						, "(cTabMov)" 	, "CRÉDITO DE PIS"				, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLPIS")[1]		,.T.,{|| cCredPIS})
	TRCell():New(oSection1, "cCtCOFI"						, "(cTabMov)" 	, "CONTA CONTÁBIL DE COFINS"	, "@!"							,TamSX3("GWM_CTCOFI")[1]	,.T.,{|| cCtCOFI})
	TRCell():New(oSection1, "cCcCOFI"						, "(cTabMov)" 	, "CENTRO DE CUSTO DE COFINS"	, "@!"							,TamSX3("GWM_CCCOFI")[1]	,.T.,{|| cCcCOFI})
	TRCell():New(oSection1, "cCredCOFI"						, "(cTabMov)" 	, "CRÉDITO DE COFINS"			, "@E 999,999,999,999.9999"		,TamSX3("GWM_VLCOFI")[1]	,.T.,{|| cCredCOFI})

Return oReport

Static Function ReportPrint(oReport)
	Local oSection1 	:= oReport:Section(1)
	Local cQuery  		:= ""
	Local cTabGXE 		:= ""
	Local cTabGXN		:= ""
	Local lExiLote		:= .F.
	Local lExiEst		:= .F.
	Local aPeriodo  	:= U_RetPeri()
	Local oFilUser 		:= GFEFilialPermissaoUsuario():New()
	Local lFilExcE    	:= FWModeAccess("GXE",1) == "E"
	Local lFilExcN    	:= FWModeAccess("GXN",1) == "E"
	Local lFilExcM    	:= FWModeAccess("GWM",1) == "E"
	Local lFilExc6    	:= FWModeAccess("GX6",1) == "E"
	Local cLstFil		:= ""
	Local cLstFilE 		:= ""
	Local cLstFilN		:= "" 
	Local cLstFilM 		:= ""
	Local cLstFil6 		:= ""
	Local aFilPerg 		:= {}
	Local nCount 		:= 0
	Local cMvPar01 		:= AllTrim(MV_PAR01)
	Local cMvPar05		:= IF(!Empty(MV_PAR05),MV_PAR05,2)	
	Local cMvPar06		:= IF(!Empty(MV_PAR06),MV_PAR06,2)
	Local cMvPar07		:= IF(!Empty(MV_PAR07),MV_PAR07,2)
	Local cMvPar08		:= IF(!Empty(MV_PAR08),MV_PAR08,1)
	Local cMvPar09		:= IF(!Empty(MV_PAR09),MV_PAR09,"C:\Temp\")
	Local nX 			:= 0
	Local cMvPar 		:= ''
	Local cTmp
	Local c_TPEST 		:= SuperGetMV("MV_TPEST",,"1")
	Local cAntPer 		:= ""
	Local lExiAntLote 	:= .F.
	Local cMV_DPSERV 	:= SuperGetMV("MV_DPSERV", .F., "1")
	Local aInfCal[2]
	Local aInfCid[4]
	Local nHandle
	Local lMV_PAR06   := !Empty(MV_PAR06)

	If !lMV_PAR06
		Alert("Necessário atualizar o pergunte GFER001!")
		Return .F.
	EndIf
	
	If cMvPar08 == 2
		cMVPar09 := AllTrim(cMVPar09)
		cMVPar09 := cMVPar09 + "GFER001.txt"
		nHandle := FCreate(cMVPar09)
		
		If nHandle < 0
			MsgAlert("Erro durante criação do arquivo.")
			Return .F.
		Else
			nLinha := "Data de Movimento;Tipo de Despesa;Filial;Nome da Filial;CNPJ/CPF Emissor;"
			nLinha += "Emissor Doc Carga;Série;Nr Doc Carga;Emissão Doc Carga;Tipo Doc Carga;"
			nLinha += "Tipo Contábil;Finalidade;CNPJ/CPF Remetente;Remetente;CNPJ/CPF Destinatário;Destinatário;"
			nLinha += "Nr Cálculo;Lote de Provisão;Período do Lote;Situação do Lote;Valor do Lote;Sublote de Estorno;"
			nLinha += "Motivo de Estorno;Período do Sublote;Situação do Sublote;Valor do Sublote;Série Doc Frete;"
			nLinha += "Nr Doc Frete;Espécie Doc Frete;Tipo Doc Frete;Emissão Doc Frete;Situação Doc Frete;"
			nLinha += "Situação Fiscal Doc Frete;Data Fiscal;Situação Rec;Data Rec;Cod Transportador;CNPJ/CPF Transportador;"
			nLinha += "Transportador;Tipo Transportador;Regime Tributário;Modal;Cidade Origem;UF de Origem;Cidade Destino; UF de Destino;"
			nLinha += "Código do Item;Descrição do Item;"
			
			If 	SuperGetMV('MV_ERPGFE',,'1') == '1'
				nLinha += "Natureza de Operação;Canal de Vendas;Grupo de Estoque;Família Comercial;Família de Materiais"
			Else
				nLinha += "Tipo Produto;Grupo;Tipo Saída;Classe Valor;Centro de Custo;"
			EndIf
			
			nLinha += "Cubagem;Quantidade;Unidade de Medida;Peso Líquido;Peso Cubado;Peso Real;Valor do Item;"
			nLinha += U_RetTpGrp(SuperGetMV('MV_TPGRP1',,'1')) + ";" + U_RetTpGrp(SuperGetMV('MV_TPGRP2',,'1')) + ";" + U_RetTpGrp(SuperGetMV('MV_TPGRP3',,'1')) + ";" + U_RetTpGrp(SuperGetMV('MV_TPGRP4',,'1')) + ";"
			nLinha += U_RetTpGrp(SuperGetMV('MV_TPGRP5',,'1')) + ";" + U_RetTpGrp(SuperGetMV('MV_TPGRP6',,'1')) + ";" + U_RetTpGrp(SuperGetMV('MV_TPGRP7',,'1')) + ";"
			nLinha += "Unidade de Negócio;Conta Contábil de Frete;Centro de Custo de Frete;Valor de Frete Total;Valor de Frete;Conta Contábil de ICMS;"
			nLinha += "Centro de Custo de ICMS;Valor de ICMS;Crédito de ICMS;Valor de ISS;Valor de ISS Retido;Conta Contábil de PIS;Centro de Custo de PIS;Crédito de PIS;"
			nLinha += "Conta Contábil de COFINS;Centro de Custo de COFINS;Crédito de COFINS"
			
			FWrite(nHandle, nLinha + CRLF)
		EndIf
	EndIf

	If !Empty(cMvPar01)
		For nX:= Len(cMvPar01) to 1 step -1
			cTmp := SubStr(cMvPar01,nX,1)
			if cTmp != "'"
				cMvPar := cTmp + cMvPar
			EndIf
		Next
		
		aFilPerg := Str2Arr(Upper(cMvPar), ";")
	EndIf
	
	For nCount := 1 To Len(aFilPerg)
		oFilUser:setAddFilUser(aFilPerg[nCount])
	Next nCount

	oFilUser:= GFEFilialPermissaoUsuario():New()
	oFilUser:MontaFilUsr()
	cLstFil := oFilUser:getFilSQLIn()
	oFilUser:Destroy(oFilUser)

	If lFilExcE
		cLstFilE := cLstFil
	EndIf
	
	If lFilExcN
		cLstFilN := cLstFil
	EndIf
	
	If lFilExcM
		cLstFilM := cLstFil
	EndIf
	
	If lFilExc6
		cLstFil6 := cLstFil
	EndIf

	oSection1:Init()
	
	// Provisão por Lote
	cQuery := "SELECT GXE.GXE_CODLOT "
	cQuery += "FROM " + RetSQLName("GXE") + " GXE "
	cQuery += "WHERE GXE.GXE_PERIOD = '" + aPeriodo[3] + "' "
	cQuery += "AND GXE.D_E_L_E_T_ = '' "
	
	cTabGXE := GetNextAlias()
	cQuery  := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabGXE, .F., .T.)
	
	If !(cTabGXE)->(Eof())
		lExiLote := .T.
	EndIf
	
	(cTabGXE)->(dbCloseArea())
	
	// Item 1: Todos
	// Item 2: Prov. e Estorno
	// Item 3: Som. Provisão
	// Item 4: Som. Estorno
	// Item 5: Som. Realizado
	// Item 6: Prov. e Realizado

	If cMvPar05 == 1
	
		cTpDesp := "PROVISÃO"
		
		If lExiLote
			cQuery := "SELECT GWM.GWM_FILIAL, GWM.GWM_NRDOC NRCALC, GWM.GWM_CDTRP, GU32.GU3_IDFED AS IDTRP, GU32.GU3_NMEMIT AS NMTRP, GWM.GWM_UNINEG, GWM.GWM_CTFRET, GWM.GWM_CCFRET, "
			cQuery += "GU31.GU3_IDFED AS IDEMIS, GU31.GU3_NMEMIT AS NMEMIS, GWM.GWM_CDTPDC, GWM.GWM_SERDC, GWM.GWM_NRDC, GWM.GWM_DTEMDC, "
			//---------init---------
			cQuery += "GU33.GU3_IDFED AS IDREM, GU33.GU3_NMEMIT AS NMREM, GU34.GU3_IDFED AS IDDEST, GU34.GU3_NMEMIT AS NMDEST, "
			cQuery += "GWF.GWF_TPCALC, GWF.GWF_CDTPSE AS TPSERV, "
			cQuery += "GU32.GU3_TRANSP AS TRANSP, GU32.GU3_AUTON AS AUTON, GU32.GU3_TPTRIB AS TPTRIB, GU32.GU3_MODAL, "
			cQuery += "GW1.GW1_EMISDC, "
			//----------end--------
			Do Case
				Case cCriRat = "1"
					cQuery += "GWM.GWM_VLICMS GWM_VLICMS, GWM.GWM_VLPIS GWM_VLPIS, GWM.GWM_VLCOFI GWM_VLCOFI, GWM.GWM_VLFRET GWM_VLFRET, GWM.GWM_VLISS GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS') .And. GFXCP2510('GWM_VLIBM') .And. GFXCP2510('GWM_VLCBS')
						cQuery += "GWM.GWM_VLIBS GWM_VLIBS, GWM.GWM_VLIBM GWM_VLIBM, GWM.GWM_VLCBS GWM_VLCBS, "
					EndIf
				Case cCriRat = "2"
					cQuery += "GWM.GWM_VLICM1 GWM_VLICMS, GWM.GWM_VLPIS1 GWM_VLPIS, GWM.GWM_VLCOF1 GWM_VLCOFI, GWM.GWM_VLFRE1 GWM_VLFRET, GWM.GWM_VLISS1 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS1') .And. GFXCP2510('GWM_VLIBM1') .And. GFXCP2510('GWM_VLCBS1')
						cQuery += "GWM.GWM_VLIBS1 GWM_VLIBS, GWM.GWM_VLIBM1 GWM_VLIBM, GWM.GWM_VLCBS1 GWM_VLCBS, "
					EndIf
				Case cCriRat = "3"
					cQuery += "GWM.GWM_VLICM3 GWM_VLICMS, GWM.GWM_VLPIS3 GWM_VLPIS, GWM.GWM_VLCOF3 GWM_VLCOFI, GWM.GWM_VLFRE3 GWM_VLFRET, GWM.GWM_VLISS3 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS3') .And. GFXCP2510('GWM_VLIBM3') .And. GFXCP2510('GWM_VLCBS3')
						cQuery += "GWM.GWM_VLIBS3 GWM_VLIBS, GWM.GWM_VLIBM3 GWM_VLIBM, GWM.GWM_VLCBS3 GWM_VLCBS, "
					EndIf
				Case cCriRat = "4"
					cQuery += "GWM.GWM_VLICM2 GWM_VLICMS, GWM.GWM_VLPIS2 GWM_VLPIS, GWM.GWM_VLCOF2 GWM_VLCOFI, GWM.GWM_VLFRE2 GWM_VLFRET, GWM.GWM_VLISS2 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS2') .And. GFXCP2510('GWM_VLIBM2') .And. GFXCP2510('GWM_VLCBS2')
						cQuery += "GWM.GWM_VLIBS2 GWM_VLIBS, GWM.GWM_VLIBM2 GWM_VLIBM, GWM.GWM_VLCBS2 GWM_VLCBS, "
					EndIf
			EndCase
			cQuery += "GWM.GWM_SEQGW8, GWM.GWM_ITEM, GW8.GW8_DSITEM, "
			//--------------init-------------------------------
			cQuery += "GW8.GW8_INFO1, GW8.GW8_INFO2, GW8.GW8_INFO3, GW8.GW8_INFO4, GW8.GW8_INFO5, GW8.GW8_VOLUME, GW8.GW8_QTDE, GW8.GW8_PESOR, GW8.GW8_QTDALT, "
			cQuery += "GW8.GW8_PESOC, GW8.GW8_PESOR, GW8.GW8_VALOR, "
			If GFXCP12123("GW8_UNIMED")
				cQuery += "GW8.GW8_UNIMED, "
			EndIf
			cQuery += "GWM.GWM_GRP1, GWM.GWM_GRP2, GWM.GWM_GRP3, GWM.GWM_GRP4, GWM.GWM_GRP5, GWM.GWM_GRP6, GWM.GWM_GRP7, "
			//-------------end---------------------------------- 
			cQuery += "GXD.GXD_CODLOT, GXD.GXD_CODEST, GXD.GXD_MOTIES, GXE.GXE_PERIOD, GXE.GXE_SIT, GWF.GWF_DTCRIA DTMOV, GWF.GWF_CRDICM CRDICM, GWF.GWF_CRDPC CRDPC, GXN.GXN_PERIES, GXN.GXN_SIT, "
			cQuery += "GU7ORI.GU7_NMCID NMCIDORI, GU7ORI.GU7_CDUF AS CDUFORI, GU7DES.GU7_NMCID AS NMCIDDES, GU7DES.GU7_CDUF AS CDUFDES, "
			cQuery += "GUS.GUS_CTTRIC, GUS.GUS_CCTRIC, GUS.GUS_CTTRPI, GUS.GUS_CCTRPI, GUS.GUS_CTTRCO, GUS.GUS_CCTRCO, "
			cQuery += "'' GW6_NRFAT, '' GW6_SITAPR, '' GW6_SITFIN, '' GW6_DTFIN, '' GW6_VLFATU, "
			cQuery += "'' as GW3_FILIAL, '' GW3_SERDF, '' GW3_NRDF, '' GW3_CDESP, '' GW3_TPDF, '' GW3_DTEMIS, '' GW3_SIT, '' GW3_SITFIS, '' GW3_DTFIS, '' GW3_VLDF, '' GW3_SITREC, '' GW3_DTREC "		
			cQuery += "FROM " + RetSQLName("GWM") + " GWM "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU31 "
			cQuery += "ON GU31.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU31.GU3_CDEMIT = GWM.GWM_EMISDC "
			cQuery += "AND GU31.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU32 "
			cQuery += "ON GU32.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU32.GU3_CDEMIT = GWM.GWM_CDTRP "
			cQuery += "AND GU32.D_E_L_E_T_ = '' "
			//--------------init------------

			cQuery += "INNER JOIN " + RetSQLName("GW1") + " GW1 "
			cQuery += "ON GW1.GW1_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GW1.GW1_NRDC = GWM.GWM_NRDC "
			cQuery += "AND GW1.GW1_CDTPDC = GWM.GWM_CDTPDC "
			cQuery += "AND GW1.GW1_EMISDC = GWM.GWM_EMISDC "
			cQuery += "AND GW1.GW1_SERDC = GWM.GWM_SERDC "
			cQuery += "AND GW1.D_E_L_E_T_ = '' "

			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU33 "
			cQuery += "ON GU33.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU33.GU3_CDEMIT = GW1.GW1_CDREM "
			cQuery += "AND GU33.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU34 "
			cQuery += "ON GU34.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU34.GU3_CDEMIT = GW1.GW1_CDDEST "
			cQuery += "AND GU34.D_E_L_E_T_ = '' "
			//---------------end-------------
			cQuery += "INNER JOIN " + RetSQLName("GWF") + " GWF "
			cQuery += "ON GWF.GWF_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GWF.GWF_NRCALC = GWM.GWM_NRDOC "
			cQuery += "AND GWF.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU7") + " GU7ORI "
			cQuery += "ON GU7ORI.GU7_FILIAL = '" + xFilial("GU7") + "' "
			cQuery += "AND GU7ORI.GU7_NRCID = GWF.GWF_CIDORI "
			cQuery += "AND GU7ORI.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU7") + " GU7DES "
			cQuery += "ON GU7DES.GU7_FILIAL = '" + xFilial("GU7") + "' "
			cQuery += "AND GU7DES.GU7_NRCID = GWF.GWF_CIDDES "
			cQuery += "AND GU7DES.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GXD") + " GXD "
			cQuery += "ON GXD.GXD_FILCAL = GWF.GWF_FILIAL "
			cQuery += "AND GXD.GXD_NRCALC = GWF.GWF_NRCALC "
			cQuery += "AND GXD.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GXE") + " GXE "
			cQuery += "ON GXE.GXE_FILIAL = GXD.GXD_FILIAL "
			cQuery += "AND GXE.GXE_CODLOT = GXD.GXD_CODLOT "
			cQuery += "AND GXE.D_E_L_E_T_ = '' "
			cQuery += "LEFT JOIN " + RetSQLName("GXN") + " GXN "
			cQuery += "ON GXN.GXN_FILIAL = GXD.GXD_FILIAL "
			cQuery += "AND GXN.GXN_CODLOT = GXD.GXD_CODLOT "
			cQuery += "AND GXN.GXN_CODEST = GXD.GXD_CODEST "
			cQuery += "AND GXN.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GUS") + " GUS "
			cQuery += "ON GUS.GUS_FILCTB = GWM.GWM_FILIAL "
			cQuery += "AND GUS.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GW8") + " GW8 "
			cQuery += "ON GW8.GW8_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GW8.GW8_CDTPDC = GWM.GWM_CDTPDC "
			cQuery += "AND GW8.GW8_EMISDC = GWM.GWM_EMISDC "
			cQuery += "AND GW8.GW8_SERDC = GWM.GWM_SERDC "
			cQuery += "AND GW8.GW8_NRDC = GWM.GWM_NRDC "
			cQuery += "AND GW8.GW8_SEQ = GWM.GWM_SEQGW8 "
			cQuery += "AND GW8.D_E_L_E_T_ = '' "
			cQuery += "WHERE GXE.GXE_PERIOD = '" + aPeriodo[3] + "' "
			cQuery += "AND GWM.D_E_L_E_T_ = '' " 		
			If lFilExcE .And. !Empty(cLstFilE)
				cQuery += " AND GXE.GXE_FILIAL IN ("+ cLstFilE +")"
			EndIf
		EndIf

		cTabMov := GetNextAlias()
		cQuery  := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabMov, .F., .T.)

		While !(cTabMov)->(Eof())
		
			cNRCALC := (cTabMov)->NRCALC
			cTPCALC := (cTabMov)->GWF_TPCALC
			cNMCIDORI := (cTabMov)->NMCIDORI
			cCDUFORI := (cTabMov)->CDUFORI
			cNMCIDDES := (cTabMov)->NMCIDDES
			cCDUFDES := (cTabMov)->CDUFDES
				
			cCtICMS 	:= ""
			cCcICMS 	:= ""
			cCredICMS 	:= 0
			cCredIBS 	:= 0
			cCredIBM 	:= 0
			cCredCBS 	:= 0
			
			cCtPIS 		:= ""
			cCcPIS 		:= ""
			cCredPIS 	:= 0
			
			cCtCOFI 	:= ""
			cCcCOFI 	:= ""
			cCredCOFI 	:= 0
					
			cISSRet		:= 0
					
			If (cTabMov)->GWM_VLICMS > 0 .And. (cTabMov)->CRDICM == "1"
				cCtICMS 	:= (cTabMov)->GUS_CTTRIC
				cCcICMS   	:= (cTabMov)->GUS_CCTRIC
				cCredICMS 	:= (cTabMov)->GWM_VLICMS
			EndIf

			If GFXCP2510('GWM_VLIBS')
				cCredIBS 	:= (cTabMov)->GWM_VLIBS
			EndIf
			If GFXCP2510('GWM_VLIBM')
				cCredIBM 	:= (cTabMov)->GWM_VLIBM
			EndIf
			If GFXCP2510('GWM_VLCBS')
				cCredCBS 	:= (cTabMov)->GWM_VLCBS
			EndIf
			
			If (cTabMov)->GWM_VLPIS > 0 .And. (cTabMov)->CRDPC == "1"
				cCtPIS 		:= (cTabMov)->GUS_CTTRPI
				cCcPIS 		:= (cTabMov)->GUS_CCTRPI
				cCredPIS	:= (cTabMov)->GWM_VLPIS
			EndIf
			
			If (cTabMov)->GWM_VLCOFI > 0 .And. (cTabMov)->CRDPC == "1"
				cCtCOFI 	:= (cTabMov)->GUS_CTTRCO
				cCcCOFI 	:= (cTabMov)->GUS_CCTRCO
				cCredCOFI	:= (cTabMov)->GWM_VLCOFI 
			EndIf
			
			nVlFret := (cTabMov)->GWM_VLFRET - (cCredICMS + cCredPIS + cCredCOFI + cCredIBS + cCredIBM + cCredCBS)
			nVlFrTot := (cTabMov)->GWM_VLFRET		
				
			cTotLot := 0
						
			If !Empty((cTabMov)->GXD_CODLOT)
				cQuery := "SELECT SUM(GXF_VALOR) GXF_VALOR "
				cQuery += "FROM " + RetSQLName("GXF") + " GXF "
				cQuery += "INNER JOIN " + RetSQLName("GXE") + " GXE "
				cQuery += "ON GXE.GXE_FILIAL = GXF.GXF_FILIAL "
				cQuery += "AND GXE.GXE_CODLOT = GXF.GXF_CODLOT "
				cQuery += "AND GXE.D_E_L_E_T_ = '' "
				cQuery += "WHERE GXE.GXE_FILIAL = '" + (cTabMov)->GWM_FILIAL + "' "
				cQuery += "AND GXE.GXE_CODLOT = '" + (cTabMov)->GXD_CODLOT + "' "
				cQuery += "AND GXF.D_E_L_E_T_ = '' "
					
				cTabLot := GetNextAlias()
				cQuery  := ChangeQuery(cQuery)
				dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabLot, .F., .T.)
					
				If !(cTabLot)->(Eof())
					cTotLot := (cTabLot)->GXF_VALOR
				EndIf
					
				(cTabLot)->(dbCloseArea())
			EndIf
				
			cTotSub := 0
				
			If !Empty((cTabMov)->GXD_CODEST)
				cQuery := "SELECT SUM(GXO_VALOR) GXO_VALOR "
				cQuery += "FROM " + RetSQLName("GXO") + " GXO "
				cQuery += "INNER JOIN " + RetSQLName("GXN") + " GXN "
				cQuery += "ON GXN.GXN_FILIAL = GXO.GXO_FILIAL "
				cQuery += "AND GXN.GXN_CODLOT = GXO.GXO_CODLOT "
				cQuery += "AND GXN.GXN_CODEST = GXO.GXO_CODEST "
				cQuery += "AND GXN.D_E_L_E_T_ = '' "
				cQuery += "WHERE GXN.GXN_FILIAL = '" + (cTabMov)->GWM_FILIAL + "' "
				cQuery += "AND GXN.GXN_CODLOT = '" + (cTabMov)->GXD_CODLOT + "' "
				cQuery += "AND GXN.GXN_CODEST = '" + (cTabMov)->GXD_CODEST + "' "
				cQuery += "AND GXO.D_E_L_E_T_ = '' "
					
				cTabSub := GetNextAlias()
				cQuery  := ChangeQuery(cQuery)
				dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabSub, .F., .T.)
				
				If !(cTabSub)->(Eof())
					cTotSub := (cTabSub)->GXO_VALOR
				EndIf
					
				(cTabSub)->(dbCloseArea())
			EndIf
				
			If cMvPar08 == 2
				nLinha := (cTabMov)->DTMOV + ";" + cTpDesp + ";" + (cTabMov)->GWM_FILIAL + ";"
				nLinha += FwFilName(cEmpAnt,(cTabMov)->GWM_FILIAL) + ";" + (cTabMov)->IDEMIS + ";" + (cTabMov)->NMEMIS + ";"
				nLinha += (cTabMov)->GWM_SERDC + ";" + (cTabMov)->GWM_NRDC + ";" + (cTabMov)->GWM_DTEMDC + ";" + (cTabMov)->GWM_CDTPDC + ";"
				nLinha += U_RetTpCtb((cTabMov)->GWM_CDTPDC) + ";" + U_RetUso((cTabMov)->GWM_FILIAL, (cTabMov)->GWM_CDTPDC, (cTabMov)->GW1_EMISDC, (cTabMov)->GWM_SERDC, (cTabMov)->GWM_NRDC) + ";"
				nLinha += (cTabMov)->IDREM + ";" + (cTabMov)->NMREM + ";" + (cTabMov)->IDDEST + ";" + (cTabMov)->NMDEST + ";" + cNrCalc + ";" + (cTabMov)->GXD_CODLOT + ";"
				nLinha += (cTabMov)->GXE_PERIOD + ";" + U_RetSitGXE((cTabMov)->GXE_SIT) + ";" + STR(cTotLot) + ";" + (cTabMov)->GXD_CODEST + ";" + U_RetMotGXD((cTabMov)->GXD_MOTIES) + ";"
				nLinha += (cTabMov)->GXN_PERIES + ";" + U_RetSitGXN((cTabMov)->GXN_SIT) + ";" + STR(cTotSub) + ";" + (cTabMov)->GW3_SERDF + ";" + (cTabMov)->GW3_NRDF + ";" + (cTabMov)->GW3_CDESP + ";"
				nLinha += U_RetTpGW3((cTabMov)->GW3_TPDF) + ";" + (cTabMov)->GW3_DTEMIS + ";" + U_RetSitGW3((cTabMov)->GW3_SIT) + ";" + U_RetFisGW3((cTabMov)->GW3_SITFIS) + ";" + (cTabMov)->GW3_DTFIS + ";"
				nLinha += U_RetFisGW3((cTabMov)->GW3_SITREC) + ";" + (cTabMov)->GW3_DTREC + ";" + (cTabMov)->GWM_CDTRP + ";" + (cTabMov)->IDTRP + ";" + (cTabMov)->NMTRP + ";" + U_RetTpTrp((cTabMov)->AUTON) + ";"
				nLinha += U_RetTpTrb((cTabMov)->TPTRIB) + ";" + U_RetTpMod((cTabMov)->GU3_MODAL) + ";" + cNMCIDORI + ";" + cCDUFORI + ";" + cNMCIDDES + ";" + cCDUFDES + ";" + (cTabMov)->GWM_ITEM + ";" + (cTabMov)->GW8_DSITEM + ";"
				nLinha += (cTabMov)->GW8_INFO1 + ";" + (cTabMov)->GW8_INFO2 + ";" + (cTabMov)->GW8_INFO3 + ";" + (cTabMov)->GW8_INFO4 + ";" + (cTabMov)->GW8_INFO5 + ";"
				nLinha += STR((cTabMov)->GW8_VOLUME) + ";" + STR((cTabMov)->GW8_QTDE) + ";" + (cTabMov)->GW8_UNIMED + ";" + STR((cTabMov)->GW8_QTDALT) + ";" + STR((cTabMov)->GW8_PESOC) + ";" + STR((cTabMov)->GW8_PESOR) + ";"
				nLinha += STR((cTabMov)->GW8_VALOR) + ";" + (cTabMov)->GWM_GRP1 + ";" + (cTabMov)->GWM_GRP2 + ";" + (cTabMov)->GWM_GRP3 + ";" + (cTabMov)->GWM_GRP4 + ";"
				nLinha += (cTabMov)->GWM_GRP5 + ";" + (cTabMov)->GWM_GRP6 + ";" + (cTabMov)->GWM_GRP7 + ";" + (cTabMov)->GWM_UNINEG + ";" + (cTabMov)->GWM_CTFRET + ";" + (cTabMov)->GWM_CCFRET + ";"
				nLinha += STR(nVlFrTot) + ";" + STR(nVlFret) + ";" + cCtICMS + ";" + cCcICMS + ";" + STR((cTabMov)->GWM_VLICMS) + ";" + STR(cCredICMS) + ";" + STR((cTabMov)->GWM_VLISS) + ";" + STR(cISSRet)  + ";" + cCtPIS + ";" + cCcPIS + ";"
				nLinha += STR(cCredPIS) + ";" + cCtCOFI + ";" + cCcCOFI + ";" + STR(cCredCOFI) 
				If GFXCP2510('GWM_VLIBS')
					nLinha += ";" + STR((cTabMov)->GWM_VLIBS)
				EndIf
				If GFXCP2510('GWM_VLIBM')
					nLinha += ";" + STR((cTabMov)->GWM_VLIBM)
				EndIf
				If GFXCP2510('GWM_VLCBS')
					nLinha += ";" + STR((cTabMov)->GWM_VLCBS)
				EndIf
				
				FWrite(nHandle, nLinha + CRLF)
			Else
				oSection1:PrintLine()
			EndIf
				   		 
			(cTabMov)->(dbSkip())
		EndDo
		
		(cTabMov)->(dbCloseArea())
	EndIf
	
	If cMvPar06 == 1
		// Estorno por sublote
		cQuery := "SELECT GXN.GXN_CODEST "
		cQuery += "FROM " + RetSQLName("GXN") + " GXN "
		cQuery += "WHERE GXN.GXN_PERIES = '" + aPeriodo[3] + "' "
		cQuery += "AND GXN.D_E_L_E_T_ = '' "
		
		cTabGXN := GetNextAlias()
		cQuery  := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabGXN, .F., .T.)
		
		If !(cTabGXN)->(Eof())
			lExiEst := .T.
		EndIf
		
		(cTabGXN)->(dbCloseArea())
		
		cTpDesp := "ESTORNO"
		
		If lExiEst
			cQuery := "SELECT GWM.GWM_FILIAL, GWM.GWM_NRDOC NRCALC, GWM.GWM_CDTRP, GU32.GU3_IDFED AS IDTRP, GU32.GU3_NMEMIT AS NMTRP, GWM.GWM_UNINEG, GWM.GWM_CTFRET, GWM.GWM_CCFRET, "
			cQuery += "GU31.GU3_IDFED AS IDEMIS, GU31.GU3_NMEMIT AS NMEMIS, GWM.GWM_CDTPDC, GWM.GWM_SERDC, GWM.GWM_NRDC, GWM.GWM_DTEMDC, "
			//--------init----------
			cQuery += "GU33.GU3_IDFED AS IDREM, GU33.GU3_NMEMIT AS NMREM, GU34.GU3_IDFED AS IDDEST, GU34.GU3_NMEMIT AS NMDEST, "
			cQuery += "GWF.GWF_TPCALC, GWF.GWF_CDTPSE AS TPSERV, "
			cQuery += "GU32.GU3_TRANSP AS TRANSP, GU32.GU3_AUTON AS AUTON, GU32.GU3_TPTRIB AS TPTRIB, GU32.GU3_MODAL, "
			cQuery += "GW1.GW1_EMISDC, "
			//---------end---------
			Do Case
				Case cCriRat = "1"
					cQuery += "GWM.GWM_VLICMS GWM_VLICMS, GWM.GWM_VLPIS GWM_VLPIS, GWM.GWM_VLCOFI GWM_VLCOFI, GWM.GWM_VLFRET GWM_VLFRET, GWM.GWM_VLISS GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS') .And. GFXCP2510('GWM_VLIBM') .And. GFXCP2510('GWM_VLCBS')
						cQuery += "GWM.GWM_VLIBS GWM_VLIBS, GWM.GWM_VLIBM GWM_VLIBM, GWM.GWM_VLCBS GWM_VLCBS, "
					EndIf
				Case cCriRat = "2"
					cQuery += "GWM.GWM_VLICM1 GWM_VLICMS, GWM.GWM_VLPIS1 GWM_VLPIS, GWM.GWM_VLCOF1 GWM_VLCOFI, GWM.GWM_VLFRE1 GWM_VLFRET, GWM.GWM_VLISS1 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS1') .And. GFXCP2510('GWM_VLIBM1') .And. GFXCP2510('GWM_VLCBS1')
						cQuery += "GWM.GWM_VLIBS1 GWM_VLIBS, GWM.GWM_VLIBM1 GWM_VLIBM, GWM.GWM_VLCBS1 GWM_VLCBS, "
					EndIf
				Case cCriRat = "3"
					cQuery += "GWM.GWM_VLICM3 GWM_VLICMS, GWM.GWM_VLPIS3 GWM_VLPIS, GWM.GWM_VLCOF3 GWM_VLCOFI, GWM.GWM_VLFRE3 GWM_VLFRET, GWM.GWM_VLISS3 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS3') .And. GFXCP2510('GWM_VLIBM3') .And. GFXCP2510('GWM_VLCBS3')
						cQuery += "GWM.GWM_VLIBS3 GWM_VLIBS, GWM.GWM_VLIBM3 GWM_VLIBM, GWM.GWM_VLCBS3 GWM_VLCBS, "
					EndIf
				Case cCriRat = "4"
					cQuery += "GWM.GWM_VLICM2 GWM_VLICMS, GWM.GWM_VLPIS2 GWM_VLPIS, GWM.GWM_VLCOF2 GWM_VLCOFI, GWM.GWM_VLFRE2 GWM_VLFRET, GWM.GWM_VLISS2 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS2') .And. GFXCP2510('GWM_VLIBM2') .And. GFXCP2510('GWM_VLCBS2')
						cQuery += "GWM.GWM_VLIBS2 GWM_VLIBS, GWM.GWM_VLIBM2 GWM_VLIBM, GWM.GWM_VLCBS2 GWM_VLCBS, "
					EndIf
			EndCase
			cQuery += "GWM.GWM_SEQGW8, GWM.GWM_ITEM, GW8.GW8_DSITEM, "
			//--------------init-------------------------------
			cQuery += "GW8.GW8_INFO1, GW8.GW8_INFO2, GW8.GW8_INFO3, GW8.GW8_INFO4, GW8.GW8_INFO5, GW8.GW8_VOLUME, GW8.GW8_QTDE, GW8.GW8_PESOR, GW8.GW8_QTDALT, "
			cQuery += "GW8.GW8_PESOC, GW8.GW8_PESOR, GW8.GW8_VALOR, "
			If GFXCP12123("GW8_UNIMED")
				cQuery += "GW8.GW8_UNIMED, "
			EndIf
			cQuery += "GWM.GWM_GRP1, GWM.GWM_GRP2, GWM.GWM_GRP3, GWM.GWM_GRP4, GWM.GWM_GRP5, GWM.GWM_GRP6, GWM.GWM_GRP7, "
			//-------------end---------------------------------- 
			cQuery += "GXD.GXD_CODLOT, GXD.GXD_CODEST, GXD.GXD_MOTIES, GXE.GXE_PERIOD, GXE.GXE_SIT, '" + DtoS(aPeriodo[2]) + "' DTMOV, GWF.GWF_CRDICM CRDICM, GWF.GWF_CRDPC CRDPC, GXN.GXN_PERIES, GXN.GXN_SIT, "
			cQuery += "GU7ORI.GU7_NMCID AS NMCIDORI, GU7ORI.GU7_CDUF AS CDUFORI, GU7DES.GU7_NMCID AS NMCIDDES, GU7DES.GU7_CDUF AS CDUFDES, "
			cQuery += "GUS.GUS_CTTRIC, GUS.GUS_CCTRIC, GUS.GUS_CTTRPI, GUS.GUS_CCTRPI, GUS.GUS_CTTRCO, GUS.GUS_CCTRCO, "
			cQuery += "'' GW6_NRFAT, '' GW6_SITAPR, '' GW6_SITFIN, '' GW6_DTFIN, '' GW6_VLFATU, "
			cQuery += "'' as GW3_FILIAL, '' GW3_SERDF, '' GW3_NRDF, '' GW3_CDESP, '' GW3_TPDF, '' GW3_DTEMIS, '' GW3_SIT, '' GW3_SITFIS, '' GW3_DTFIS, '' GW3_VLDF, '' GW3_SITREC, '' GW3_DTREC "
			cQuery += "FROM " + RetSQLName("GWM") + " GWM "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU31 "
			cQuery += "ON GU31.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU31.GU3_CDEMIT = GWM.GWM_EMISDC "
			cQuery += "AND GU31.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU32 "
			cQuery += "ON GU32.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU32.GU3_CDEMIT = GWM.GWM_CDTRP "
			cQuery += "AND GU32.D_E_L_E_T_ = '' "
			//--------------init------------

			cQuery += "INNER JOIN " + RetSQLName("GW1") + " GW1 "
			cQuery += "ON GW1.GW1_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GW1.GW1_NRDC = GWM.GWM_NRDC "
			cQuery += "AND GW1.GW1_CDTPDC = GWM.GWM_CDTPDC "
			cQuery += "AND GW1.GW1_EMISDC = GWM.GWM_EMISDC "
			cQuery += "AND GW1.GW1_SERDC = GWM.GWM_SERDC "
			cQuery += "AND GW1.D_E_L_E_T_ = '' "

			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU33 "
			cQuery += "ON GU33.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU33.GU3_CDEMIT = GW1.GW1_CDREM "
			cQuery += "AND GU33.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU34 "
			cQuery += "ON GU34.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU34.GU3_CDEMIT = GW1.GW1_CDDEST "
			cQuery += "AND GU34.D_E_L_E_T_ = '' "
			//---------------end-------------
			cQuery += "INNER JOIN " + RetSQLName("GWF") + " GWF "
			cQuery += "ON GWF.GWF_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GWF.GWF_NRCALC = GWM.GWM_NRDOC "
			cQuery += "AND GWF.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU7") + " GU7ORI "
			cQuery += "ON GU7ORI.GU7_FILIAL = '" + xFilial("GU7") + "' "
			cQuery += "AND GU7ORI.GU7_NRCID = GWF.GWF_CIDORI "
			cQuery += "AND GU7ORI.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU7") + " GU7DES "
			cQuery += "ON GU7DES.GU7_FILIAL = '" + xFilial("GU7") + "' "
			cQuery += "AND GU7DES.GU7_NRCID = GWF.GWF_CIDDES "
			cQuery += "AND GU7DES.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GXD") + " GXD "
			cQuery += "ON GXD.GXD_FILCAL = GWF.GWF_FILIAL "
			cQuery += "AND GXD.GXD_NRCALC = GWF.GWF_NRCALC "
			cQuery += "AND GXD.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GXE") + " GXE "
			cQuery += "ON GXE.GXE_FILIAL = GXD.GXD_FILIAL "
			cQuery += "AND GXE.GXE_CODLOT = GXD.GXD_CODLOT "
			cQuery += "AND GXE.D_E_L_E_T_ = '' "
			
			cQuery += "LEFT JOIN " + RetSQLName("GXN") + " GXN "
			cQuery += "ON GXN.GXN_FILIAL = GXD.GXD_FILIAL "
			cQuery += "AND GXN.GXN_CODLOT = GXD.GXD_CODLOT "
			cQuery += "AND GXN.GXN_CODEST = GXD.GXD_CODEST "
			cQuery += "AND GXN.D_E_L_E_T_ = '' "
						
			cQuery += "INNER JOIN " + RetSQLName("GUS") + " GUS "
			cQuery += "ON GUS.GUS_FILCTB = GWM.GWM_FILIAL "
			cQuery += "AND GUS.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GW8") + " GW8 "
			cQuery += "ON GW8.GW8_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GW8.GW8_CDTPDC = GWM.GWM_CDTPDC "
			cQuery += "AND GW8.GW8_EMISDC = GWM.GWM_EMISDC "
			cQuery += "AND GW8.GW8_SERDC = GWM.GWM_SERDC "
			cQuery += "AND GW8.GW8_NRDC = GWM.GWM_NRDC "
			cQuery += "AND GW8.GW8_SEQ = GWM.GWM_SEQGW8 "
			cQuery += "AND GW8.D_E_L_E_T_ = '' "
			cQuery += "WHERE GXN.GXN_PERIES = '" + aPeriodo[3] + "' "
			cQuery += "AND GWM.D_E_L_E_T_ = '' "
			If lFilExcN .And. !Empty(cLstFilN)
				cQuery += " AND GXN.GXN_FILIAL IN ("+ cLstFilN +")"
			EndIf
		Else
			// Busca do Lote do período anterior
			If Substr(aPeriodo[3],6,2) == "01"
				cAntPer := AllTrim(Str(Val(Substr(aPeriodo[3],1,4)) - 1)) + "/12"
			Else
				If Val(Substr(aPeriodo[3],6,2)) <= 10
					cAntPer := Substr(aPeriodo[3],1,4) + "/0" + AllTrim(Str(Val(Substr(aPeriodo[3],6,2)) - 1))
				Else
					cAntPer := Substr(aPeriodo[3],1,4) + "/" + AllTrim(Str(Val(Substr(aPeriodo[3],6,2)) - 1))
				EndIf
			EndIf
			
			cQuery := "SELECT GXE.GXE_CODLOT "
			cQuery += "FROM " + RetSQLName("GXE") + " GXE "
			cQuery += "WHERE GXE.GXE_PERIOD = '" + cAntPer + "' "			
			cQuery += "AND GXE.D_E_L_E_T_ = '' "
			
			cTabGXE := GetNextAlias()
			cQuery  := ChangeQuery(cQuery)
			dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabGXE, .F., .T.)
			
			If !(cTabGXE)->(Eof())
				lExiAntLote := .T.
			EndIf
		
			cQuery := "SELECT GWM.GWM_FILIAL, GWM.GWM_NRDOC NRCALC, GWM.GWM_CDTRP, GU32.GU3_IDFED AS IDTRP, GU32.GU3_NMEMIT AS NMTRP, GWM.GWM_UNINEG, GWM.GWM_CTFRET, GWM.GWM_CCFRET, "
			cQuery += "GU31.GU3_IDFED AS IDEMIS, GU31.GU3_NMEMIT AS NMEMIS, GWM.GWM_CDTPDC, GWM.GWM_SERDC, GWM.GWM_NRDC, GWM.GWM_DTEMDC, "
			//--------init----------
			cQuery += "GU33.GU3_IDFED AS IDREM, GU33.GU3_NMEMIT AS NMREM, GU34.GU3_IDFED AS IDDEST, GU34.GU3_NMEMIT AS NMDEST, "
			cQuery += "GWF.GWF_TPCALC, GWF.GWF_CDTPSE AS TPSERV, "
			cQuery += "GU32.GU3_TRANSP AS TRANSP, GU32.GU3_AUTON AS AUTON, GU32.GU3_TPTRIB AS TPTRIB, GU32.GU3_MODAL, "
			cQuery += "GW1.GW1_EMISDC, "
			//----------end--------
			Do Case
				Case cCriRat = "1"
					cQuery += "GWM.GWM_VLICMS GWM_VLICMS, GWM.GWM_VLPIS GWM_VLPIS, GWM.GWM_VLCOFI GWM_VLCOFI, GWM.GWM_VLFRET GWM_VLFRET, GWM.GWM_VLISS GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS') .And. GFXCP2510('GWM_VLIBM') .And. GFXCP2510('GWM_VLCBS')
						cQuery += "GWM.GWM_VLIBS GWM_VLIBS, GWM.GWM_VLIBM GWM_VLIBM, GWM.GWM_VLCBS GWM_VLCBS, "
					EndIf
				Case cCriRat = "2"
					cQuery += "GWM.GWM_VLICM1 GWM_VLICMS, GWM.GWM_VLPIS1 GWM_VLPIS, GWM.GWM_VLCOF1 GWM_VLCOFI, GWM.GWM_VLFRE1 GWM_VLFRET, GWM.GWM_VLISS1 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS1') .And. GFXCP2510('GWM_VLIBM1') .And. GFXCP2510('GWM_VLCBS1')
						cQuery += "GWM.GWM_VLIBS1 GWM_VLIBS, GWM.GWM_VLIBM1 GWM_VLIBM, GWM.GWM_VLCBS1 GWM_VLCBS, "
					EndIf
				Case cCriRat = "3"
					cQuery += "GWM.GWM_VLICM3 GWM_VLICMS, GWM.GWM_VLPIS3 GWM_VLPIS, GWM.GWM_VLCOF3 GWM_VLCOFI, GWM.GWM_VLFRE3 GWM_VLFRET, GWM.GWM_VLISS3 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS3') .And. GFXCP2510('GWM_VLIBM3') .And. GFXCP2510('GWM_VLCBS3')
						cQuery += "GWM.GWM_VLIBS3 GWM_VLIBS, GWM.GWM_VLIBM3 GWM_VLIBM, GWM.GWM_VLCBS3 GWM_VLCBS, "
					EndIf
				Case cCriRat = "4"
					cQuery += "GWM.GWM_VLICM2 GWM_VLICMS, GWM.GWM_VLPIS2 GWM_VLPIS, GWM.GWM_VLCOF2 GWM_VLCOFI, GWM.GWM_VLFRE2 GWM_VLFRET, GWM.GWM_VLISS2 GWM_VLISS, "
					If GFXCP2510('GWM_VLIBS2') .And. GFXCP2510('GWM_VLIBM2') .And. GFXCP2510('GWM_VLCBS2')
						cQuery += "GWM.GWM_VLIBS2 GWM_VLIBS, GWM.GWM_VLIBM2 GWM_VLIBM, GWM.GWM_VLCBS2 GWM_VLCBS, "
					EndIf
			EndCase
			cQuery += "GWM.GWM_SEQGW8, GWM.GWM_ITEM, GW8.GW8_DSITEM, "
			//--------------init-------------------------------
			cQuery += "GW8.GW8_INFO1, GW8.GW8_INFO2, GW8.GW8_INFO3, GW8.GW8_INFO4, GW8.GW8_INFO5, GW8.GW8_VOLUME, GW8.GW8_QTDE, GW8.GW8_PESOR, GW8.GW8_QTDALT, "
			cQuery += "GW8.GW8_PESOC, GW8.GW8_PESOR, GW8.GW8_VALOR, "
			If GFXCP12123("GW8_UNIMED")
				cQuery += "GW8.GW8_UNIMED, "
			EndIf
			cQuery += "GWM.GWM_GRP1, GWM.GWM_GRP2, GWM.GWM_GRP3, GWM.GWM_GRP4, GWM.GWM_GRP5, GWM.GWM_GRP6, GWM.GWM_GRP7, "
			//-------------end---------------------------------- 
			cQuery += "GXD.GXD_CODLOT, GXD.GXD_CODEST, GXD.GXD_MOTIES, GXE.GXE_PERIOD, GXE.GXE_SIT,  '" + DtoS(aPeriodo[2]) + "' DTMOV, GWF.GWF_CRDICM CRDICM, GWF.GWF_CRDPC CRDPC, '' GXN_PERIES, '' GXN_SIT, "
			cQuery += "GU7ORI.GU7_NMCID AS NMCIDORI, GU7ORI.GU7_CDUF AS CDUFORI, GU7DES.GU7_NMCID AS NMCIDDES, GU7DES.GU7_CDUF AS CDUFDES, "
			cQuery += "GUS.GUS_CTTRIC, GUS.GUS_CCTRIC, GUS.GUS_CTTRPI, GUS.GUS_CCTRPI, GUS.GUS_CTTRCO, GUS.GUS_CCTRCO, "
			cQuery += "GW6.GW6_NRFAT, GW6.GW6_SITAPR, GW6.GW6_SITFIN, GW6.GW6_DTFIN, GW6.GW6_VLFATU, GW3.GW3_NRDF, GW3.GW3_SERDF, GW3.GW3_EMISDF, GW3.GW3_DTEMIS, "
			cQuery += "'' as GW3_FILIAL, GW3.GW3_SERDF, GW3.GW3_NRDF, GW3.GW3_CDESP, GW3.GW3_TPDF, GW3.GW3_DTEMIS, GW3.GW3_SIT, GW3.GW3_SITFIS, GW3.GW3_DTFIS, GW3.GW3_VLDF, "
			//----------------init------------------
			cQuery += "GW3.GW3_SITREC, GW3.GW3_DTREC "
			//------------------end-----------------
			cQuery += "FROM " + RetSQLName("GWM") + " GWM "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU31 "
			cQuery += "ON GU31.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU31.GU3_CDEMIT = GWM.GWM_EMISDC "
			cQuery += "AND GU31.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU32 "
			cQuery += "ON GU32.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU32.GU3_CDEMIT = GWM.GWM_CDTRP "
			cQuery += "AND GU32.D_E_L_E_T_ = '' "
			//-------------init-------------
	
			cQuery += "INNER JOIN " + RetSQLName("GW1") + " GW1 "
			cQuery += "ON GW1.GW1_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GW1.GW1_NRDC = GWM.GWM_NRDC "
			cQuery += "AND GW1.GW1_CDTPDC = GWM.GWM_CDTPDC "
			cQuery += "AND GW1.GW1_EMISDC = GWM.GWM_EMISDC "
			cQuery += "AND GW1.GW1_SERDC = GWM.GWM_SERDC "
			cQuery += "AND GW1.D_E_L_E_T_ = '' "

			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU33 "
			cQuery += "ON GU33.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU33.GU3_CDEMIT = GW1.GW1_CDREM "
			cQuery += "AND GU33.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU34 "
			cQuery += "ON GU34.GU3_FILIAL = '" + xFilial("GU3") + "' "
			cQuery += "AND GU34.GU3_CDEMIT = GW1.GW1_CDDEST "
			cQuery += "AND GU34.D_E_L_E_T_ = '' "
			//-------------end---------------
			cQuery += "INNER JOIN " + RetSQLName("GUS") + " GUS "
			cQuery += "ON GUS.GUS_FILCTB = GWM.GWM_FILIAL "
			cQuery += "AND GUS.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GW8") + " GW8 "
			cQuery += "ON GW8.GW8_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GW8.GW8_CDTPDC = GWM.GWM_CDTPDC "
			cQuery += "AND GW8.GW8_EMISDC = GWM.GWM_EMISDC "
			cQuery += "AND GW8.GW8_SERDC = GWM.GWM_SERDC "
			cQuery += "AND GW8.GW8_NRDC = GWM.GWM_NRDC "
			cQuery += "AND GW8.GW8_SEQ = GWM.GWM_SEQGW8 "
			cQuery += "AND GW8.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GWF") + " GWF "
			cQuery += "ON GWF.GWF_FILIAL = GWM.GWM_FILIAL "
			cQuery += "AND GWF.GWF_NRCALC = GWM.GWM_NRDOC "
			cQuery += "AND GWF.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU7") + " GU7ORI "
			cQuery += "ON GU7ORI.GU7_FILIAL = '" + xFilial("GU7") + "' "
			cQuery += "AND GU7ORI.GU7_NRCID = GWF.GWF_CIDORI "
			cQuery += "AND GU7ORI.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GU7") + " GU7DES "
			cQuery += "ON GU7DES.GU7_FILIAL = '" + xFilial("GU7") + "' "
			cQuery += "AND GU7DES.GU7_NRCID = GWF.GWF_CIDDES "
			cQuery += "AND GU7DES.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GXD") + " GXD "
			cQuery += "ON GXD.GXD_FILCAL = GWF.GWF_FILIAL "
			cQuery += "AND GXD.GXD_NRCALC = GWF.GWF_NRCALC "
			cQuery += "AND GXD.D_E_L_E_T_ = '' "
			cQuery += "INNER JOIN " + RetSQLName("GXE") + " GXE "
			cQuery += "ON GXE.GXE_FILIAL = GXD.GXD_FILIAL "
			cQuery += "AND GXE.GXE_CODLOT = GXD.GXD_CODLOT "
			cQuery += "AND GXE.D_E_L_E_T_ = '' "
			
			If lExiAntLote .And. c_TPEST == '1'
			   If cMV_DPSERV == '1'
			   	  	cQuery += "LEFT JOIN " + RetSQLName("GW3") + " GW3 "							 
					cQuery += "ON GW3.GW3_FILIAL = GWF.GWF_FILIAL "
					cQuery += "AND GW3.GW3_CDESP = GWF.GWF_CDESP "
					cQuery += "AND GW3.GW3_EMISDF = GWF.GWF_EMISDF "
					cQuery += "AND GW3.GW3_SERDF = GWF.GWF_SERDF "
					cQuery += "AND GW3.GW3_NRDF = GWF.GWF_NRDF "
					cQuery += "AND GW3.GW3_DTEMIS = GWF.GWF_DTEMDF "
					cQuery += "AND GW3.D_E_L_E_T_ = '' "    
			   Else 	
					cQuery += "LEFT JOIN " + RetSQlName("GW4") + " GW4 "
					cQuery += "ON GW4.GW4_FILIAL = GWM.GWM_FILIAL "
					cQuery += "AND GW4.GW4_NRDC = GWM.GWM_NRDC "
					cQuery += "AND GW4.GW4_TPDC = GWM.GWM_CDTPDC "
					cQuery += "AND GW4.GW4_SERDC = GWM.GWM_SERDC "
					cQuery += "AND GW4.GW4_EMISDC = GWM.GWM_EMISDC "
					cQuery += "AND GW4.GW4_EMISDF = GWF.GWF_TRANSP "
					cQuery += "AND GW4.D_E_L_E_T_ = '' "
					cQuery += "LEFT JOIN " + RetSQLName("GW3") + " GW3 "							 
					cQuery += "ON GW3.GW3_FILIAL = GW4.GW4_FILIAL "
					cQuery += "AND GW3.GW3_EMISDF = GW4.GW4_EMISDF "
					cQuery += "AND GW3.GW3_SERDF = GW4.GW4_SERDF "
					cQuery += "AND GW3.GW3_NRDF = GW4.GW4_NRDF "
					cQuery += "AND GW3.GW3_DTEMIS = GW4.GW4_DTEMIS "
					cQuery += "AND GW3.D_E_L_E_T_ = '' " 
					cQuery += "AND GW3.GW3_TPDF = GWF.GWF_TPCALC "	
				End			
				cQuery += "LEFT JOIN " + RetSQLName("GW6") + " GW6 "
				cQuery += "ON GW6.GW6_FILIAL = GW3.GW3_FILFAT "
				cQuery += "AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT "
				cQuery += "AND GW6.GW6_SERFAT = GW3.GW3_SERFAT "
				cQuery += "AND GW6.GW6_NRFAT = GW3.GW3_NRFAT "
				cQuery += "AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA "
				cQuery += "AND GW6.D_E_L_E_T_ = '' "
				cQuery += "WHERE GXE.GXE_PERIOD = '" + cAntPer + "' "				
				cQuery += "AND GWM.GWM_TPDOC = '1' "
				cQuery += "AND GWM.D_E_L_E_T_ = '' "
				If lFilExcM .And. !Empty(cLstFilM)
					cQuery += " AND GWM.GWM_FILIAL IN ("+ cLstFilM +")"
				EndIf
			Else
				cQuery += "INNER JOIN " + RetSQlName("GW4") + " GW4 "
				cQuery += "ON GW4.GW4_FILIAL = GWM.GWM_FILIAL "
				cQuery += "AND GW4.GW4_NRDC = GWM.GWM_NRDC "
				cQuery += "AND GW4.GW4_TPDC = GWM.GWM_CDTPDC "
				cQuery += "AND GW4.GW4_SERDC = GWM.GWM_SERDC "
				cQuery += "AND GW4.GW4_EMISDC = GWM.GWM_EMISDC "
				cQuery += "AND GW4.GW4_EMISDF = GWF.GWF_TRANSP "
				cQuery += "AND GW4.D_E_L_E_T_ = '' "
				cQuery += "INNER JOIN " + RetSQLName("GW3") + " GW3 "
				cQuery += "ON GW3.GW3_FILIAl = GW4.GW4_FILIAL "
				cQuery += "AND GW3.GW3_EMISDF = GW4.GW4_EMISDF "
				cQuery += "AND GW3.GW3_SERDF = GW4.GW4_SERDF "
				cQuery += "AND GW3.GW3_NRDF = GW4.GW4_NRDF "
				cQuery += "AND GW3.GW3_DTEMIS = GW4.GW4_DTEMIS "
				cQuery += "AND GW3.D_E_L_E_T_ = '' "
				cQuery += "AND GW3.GW3_TPDF = GWF.GWF_TPCALC " 
				cQuery += "INNER JOIN " + RetSQLName("GW6") + " GW6 "
				cQuery += "ON GW6.GW6_FILIAL = GW3.GW3_FILFAT "
				cQuery += "AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT "
				cQuery += "AND GW6.GW6_SERFAT = GW3.GW3_SERFAT "
				cQuery += "AND GW6.GW6_NRFAT = GW3.GW3_NRFAT "
				cQuery += "AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA "
				cQuery += "AND GW6.D_E_L_E_T_ = '' "
				cQuery += "WHERE GW6.GW6_SITFIN = '4' "
				cQuery += "AND GW6.GW6_DTFIN >= '" + DtoS(aPeriodo[1]) + "' "
				cQuery += "AND GW6.GW6_DTFIN <= '" + DtoS(aPeriodo[2]) + "' "
				cQuery += "AND GWM.GWM_TPDOC = '1' "
				cQuery += "AND GXD.GXD_CODLOT <> '' "
				cQuery += "AND GXD.GXD_CODEST = '' "
				cQuery += "AND GWM.D_E_L_E_T_ = '' "
				If lFilExc6 .And. !Empty(cLstFil6)
					cQuery += " AND GW6.GW6_FILIAL IN ("+ cLstFil6 +")"
				EndIf
			EndIf
		EndIf
		
		cTabMov := GetNextAlias()
		cQuery  := ChangeQuery(cQuery)
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabMov, .F., .T.)
		
		While !(cTabMov)->(Eof())
		
			cNRCALC := (cTabMov)->NRCALC
			cTPCALC := (cTabMov)->GWF_TPCALC
			cNMCIDORI := (cTabMov)->NMCIDORI
			cCDUFORI := (cTabMov)->CDUFORI
			cNMCIDDES := (cTabMov)->NMCIDDES
			cCDUFDES := (cTabMov)->CDUFDES
		
			cCtICMS 	:= ""
			cCcICMS 	:= ""
			cCredICMS 	:= 0
			
			cCtPIS 		:= ""
			cCcPIS 		:= ""
			cCredPIS 	:= 0
			
			cCtCOFI 	:= ""
			cCcCOFI 	:= ""
			cCredCOFI 	:= 0
			
			cISSRet		:= 0

			cCredIBS 	:= 0
			cCredIBM 	:= 0
			cCredCBS 	:= 0
					
			If (cTabMov)->GWM_VLICMS > 0 .And. (cTabMov)->CRDICM == "1"
				cCtICMS 	:= (cTabMov)->GUS_CTTRIC
				cCcICMS   	:= (cTabMov)->GUS_CCTRIC
				cCredICMS 	:= (cTabMov)->GWM_VLICMS
			EndIf
			
			If (cTabMov)->GWM_VLPIS > 0 .And. (cTabMov)->CRDPC == "1"
				cCtPIS 		:= (cTabMov)->GUS_CTTRPI
				cCcPIS 		:= (cTabMov)->GUS_CCTRPI
				cCredPIS	:= (cTabMov)->GWM_VLPIS
			EndIf
			
			If (cTabMov)->GWM_VLCOFI > 0 .And. (cTabMov)->CRDPC == "1"
				cCtCOFI 	:= (cTabMov)->GUS_CTTRCO
				cCcCOFI 	:= (cTabMov)->GUS_CCTRCO
				cCredCOFI	:= (cTabMov)->GWM_VLCOFI 
			EndIf

			If GFXCP2510('GWM_VLIBS')
				cCredIBS 	:= (cTabMov)->GWM_VLIBS
			EndIf
			If GFXCP2510('GWM_VLIBM')
				cCredIBM 	:= (cTabMov)->GWM_VLIBM
			EndIf
			If GFXCP2510('GWM_VLCBS')
				cCredCBS 	:= (cTabMov)->GWM_VLCBS
			EndIf
							
			nVlFret := (cTabMov)->GWM_VLFRET - (cCredICMS + cCredPIS + cCredCOFI + cCredIBS + cCredIBM + cCredCBS)
			nVlFrTot := (cTabMov)->GWM_VLFRET				
			
			cTotLot := 0
				
			If !Empty((cTabMov)->GXD_CODLOT)
				cQuery := "SELECT SUM(GXF_VALOR) GXF_VALOR "
				cQuery += "FROM " + RetSQLName("GXF") + " GXF "
				cQuery += "INNER JOIN " + RetSQLName("GXE") + " GXE "
				cQuery += "ON GXE.GXE_FILIAL = GXF.GXF_FILIAL "
				cQuery += "AND GXE.GXE_CODLOT = GXF.GXF_CODLOT "
				cQuery += "AND GXE.D_E_L_E_T_ = '' "
				cQuery += "WHERE GXE.GXE_FILIAL = '" + (cTabMov)->GWM_FILIAL + "' "
				cQuery += "AND GXE.GXE_CODLOT = '" + (cTabMov)->GXD_CODLOT + "' "
				cQuery += "AND GXF.D_E_L_E_T_ = '' "
					
				cTabLot := GetNextAlias()
				cQuery  := ChangeQuery(cQuery)
				dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabLot, .F., .T.)
					
				If !(cTabLot)->(Eof())
					cTotLot := (cTabLot)->GXF_VALOR
				EndIf
					
				(cTabLot)->(dbCloseArea())
			EndIf
				
			cTotSub := 0
				
			If !Empty((cTabMov)->GXD_CODEST)
				cQuery := "SELECT SUM(GXO_VALOR) GXO_VALOR "
				cQuery += "FROM " + RetSQLName("GXO") + " GXO "
				cQuery += "INNER JOIN " + RetSQLName("GXN") + " GXN "
				cQuery += "ON GXN.GXN_FILIAL = GXO.GXO_FILIAL "
				cQuery += "AND GXN.GXN_CODLOT = GXO.GXO_CODLOT "
				cQuery += "AND GXN.GXN_CODEST = GXO.GXO_CODEST "
				cQuery += "AND GXN.D_E_L_E_T_ = '' "
				cQuery += "WHERE GXN.GXN_FILIAL = '" + (cTabMov)->GWM_FILIAL + "' "
				cQuery += "AND GXN.GXN_CODLOT = '" + (cTabMov)->GXD_CODLOT + "' "
				cQuery += "AND GXN.GXN_CODEST = '" + (cTabMov)->GXD_CODEST + "' "
				cQuery += "AND GXO.D_E_L_E_T_ = '' "
				
				cTabSub := GetNextAlias()
				cQuery  := ChangeQuery(cQuery)
				dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabSub, .F., .T.)
					
				If !(cTabSub)->(Eof())
					cTotSub := (cTabSub)->GXO_VALOR
				EndIf
					
				(cTabSub)->(dbCloseArea())
			EndIf

			If cMvPar08 == 2
				nLinha := (cTabMov)->DTMOV + ";" + cTpDesp + ";" + (cTabMov)->GWM_FILIAL + ";"
				nLinha += FwFilName(cEmpAnt,(cTabMov)->GWM_FILIAL) + ";" + (cTabMov)->IDEMIS + ";" + (cTabMov)->NMEMIS + ";"
				nLinha += (cTabMov)->GWM_SERDC + ";" + (cTabMov)->GWM_NRDC + ";" + (cTabMov)->GWM_DTEMDC + ";" + (cTabMov)->GWM_CDTPDC + ";"
				nLinha += U_RetTpCtb((cTabMov)->GWM_CDTPDC) + ";" + U_RetUso((cTabMov)->GWM_FILIAL, (cTabMov)->GWM_CDTPDC, (cTabMov)->GW1_EMISDC, (cTabMov)->GWM_SERDC, (cTabMov)->GWM_NRDC) + ";"
				nLinha += (cTabMov)->IDREM + ";" + (cTabMov)->NMREM + ";" + (cTabMov)->IDDEST + ";" + (cTabMov)->NMDEST + ";" + cNrCalc + ";" + (cTabMov)->GXD_CODLOT + ";"
				nLinha += (cTabMov)->GXE_PERIOD + ";" + U_RetSitGXE((cTabMov)->GXE_SIT) + ";" + STR(cTotLot) + ";" + (cTabMov)->GXD_CODEST + ";" + U_RetMotGXD((cTabMov)->GXD_MOTIES) + ";"
				nLinha += (cTabMov)->GXN_PERIES + ";" + U_RetSitGXN((cTabMov)->GXN_SIT) + ";" + STR(cTotSub) + ";" + (cTabMov)->GW3_SERDF + ";" + (cTabMov)->GW3_NRDF + ";" + (cTabMov)->GW3_CDESP + ";"
				nLinha += U_RetTpGW3((cTabMov)->GW3_TPDF) + ";" + (cTabMov)->GW3_DTEMIS + ";" + U_RetSitGW3((cTabMov)->GW3_SIT) + ";" + U_RetFisGW3((cTabMov)->GW3_SITFIS) + ";" + (cTabMov)->GW3_DTFIS + ";"
				nLinha += U_RetFisGW3((cTabMov)->GW3_SITREC) + ";" + (cTabMov)->GW3_DTREC + ";" + (cTabMov)->GWM_CDTRP + ";" + (cTabMov)->IDTRP + ";" + (cTabMov)->NMTRP + ";" + U_RetTpTrp((cTabMov)->AUTON) + ";"
				nLinha += U_RetTpTrb((cTabMov)->TPTRIB) + ";" + U_RetTpMod((cTabMov)->GU3_MODAL) + ";" + cNMCIDORI + ";" + cCDUFORI + ";" + cNMCIDDES + ";" + cCDUFDES + ";" + (cTabMov)->GWM_ITEM + ";" + (cTabMov)->GW8_DSITEM + ";"
				nLinha += (cTabMov)->GW8_INFO1 + ";" + (cTabMov)->GW8_INFO2 + ";" + (cTabMov)->GW8_INFO3 + ";" + (cTabMov)->GW8_INFO4 + ";" + (cTabMov)->GW8_INFO5 + ";"
				nLinha += STR((cTabMov)->GW8_VOLUME) + ";" + STR((cTabMov)->GW8_QTDE) + ";" + (cTabMov)->GW8_UNIMED + ";" + STR((cTabMov)->GW8_QTDALT) + ";" + STR((cTabMov)->GW8_PESOC) + ";" + STR((cTabMov)->GW8_PESOR) + ";"
				nLinha += STR((cTabMov)->GW8_VALOR) + ";" + (cTabMov)->GWM_GRP1 + ";" + (cTabMov)->GWM_GRP2 + ";" + (cTabMov)->GWM_GRP3 + ";" + (cTabMov)->GWM_GRP4 + ";"
				nLinha += (cTabMov)->GWM_GRP5 + ";" + (cTabMov)->GWM_GRP6 + ";" + (cTabMov)->GWM_GRP7 + ";" + (cTabMov)->GWM_UNINEG + ";" + (cTabMov)->GWM_CTFRET + ";" + (cTabMov)->GWM_CCFRET + ";"
				nLinha += STR(nVlFrTot) + ";" + STR(nVlFret) + ";" + cCtICMS + ";" + cCcICMS + ";" + STR((cTabMov)->GWM_VLICMS) + ";" + STR(cCredICMS) + ";" + STR((cTabMov)->GWM_VLISS) + ";" + STR(cISSRet)  + ";" + cCtPIS + ";" + cCcPIS + ";"
				nLinha += STR(cCredPIS) + ";" + cCtCOFI + ";" + cCcCOFI + ";" + STR(cCredCOFI) 
				If GFXCP2510('GWM_VLIBS')
					nLinha += ";" + STR((cTabMov)->GWM_VLIBS)
				EndIf
				If GFXCP2510('GWM_VLIBM')
					nLinha += ";" + STR((cTabMov)->GWM_VLIBM)
				EndIf
				If GFXCP2510('GWM_VLCBS')
					nLinha += ";" + STR((cTabMov)->GWM_VLCBS)
				EndIf
				
				FWrite(nHandle, nLinha + CRLF)
			Else
				oSection1:PrintLine()
			EndIf

			(cTabMov)->(dbSkip())
		EndDo
		
		(cTabMov)->(dbCloseArea())
	EndIf
	
	If cMvPar07 == 1	
		// Realizado
		cTpDesp := "REALIZADO"
		
		cQuery := "SELECT GWM.GWM_FILIAL, GWM.GWM_CDTRP, GU32.GU3_IDFED AS IDTRP, GU32.GU3_NMEMIT AS NMTRP, GWM.GWM_UNINEG, GWM.GWM_CTFRET, GWM.GWM_CCFRET, "
		cQuery += "GU31.GU3_IDFED AS IDEMIS, GU31.GU3_NMEMIT AS NMEMIS, GWM.GWM_CDTPDC, GWM.GWM_SERDC, GWM.GWM_NRDC, GWM.GWM_DTEMDC, "
		//-------init-----------
		cQuery += "GU33.GU3_IDFED AS IDREM, GU33.GU3_NMEMIT AS NMREM, GU34.GU3_IDFED AS IDDEST, GU34.GU3_NMEMIT AS NMDEST, '' as GWF_TPCALC,"
		cQuery += "GU32.GU3_TRANSP AS TRANSP, GU32.GU3_AUTON AS AUTON, GU32.GU3_TPTRIB AS TPTRIB, GU32.GU3_MODAL, "
		cQuery += "GW1.GW1_EMISDC, "
		//--------end----------
		Do Case
			Case cCriRat = "1"
				cQuery += "GWM.GWM_VLICMS GWM_VLICMS, GWM.GWM_VLPIS GWM_VLPIS, GWM.GWM_VLCOFI GWM_VLCOFI, GWM.GWM_VLFRET GWM_VLFRET, GWM.GWM_VLISS GWM_VLISS, "
				If GFXCP2510('GWM_VLIBS') .And. GFXCP2510('GWM_VLIBM') .And. GFXCP2510('GWM_VLCBS')
					cQuery += "GWM.GWM_VLIBS GWM_VLIBS, GWM.GWM_VLIBM GWM_VLIBM, GWM.GWM_VLCBS GWM_VLCBS, "
				EndIf
			Case cCriRat = "2"
				cQuery += "GWM.GWM_VLICM1 GWM_VLICMS, GWM.GWM_VLPIS1 GWM_VLPIS, GWM.GWM_VLCOF1 GWM_VLCOFI, GWM.GWM_VLFRE1 GWM_VLFRET, GWM.GWM_VLISS1 GWM_VLISS, "
				If GFXCP2510('GWM_VLIBS1') .And. GFXCP2510('GWM_VLIBM1') .And. GFXCP2510('GWM_VLCBS1')
					cQuery += "GWM.GWM_VLIBS1 GWM_VLIBS, GWM.GWM_VLIBM1 GWM_VLIBM, GWM.GWM_VLCBS1 GWM_VLCBS, "
				EndIf
			Case cCriRat = "3"
				cQuery += "GWM.GWM_VLICM3 GWM_VLICMS, GWM.GWM_VLPIS3 GWM_VLPIS, GWM.GWM_VLCOF3 GWM_VLCOFI, GWM.GWM_VLFRE3 GWM_VLFRET, GWM.GWM_VLISS3 GWM_VLISS, "
				If GFXCP2510('GWM_VLIBS3') .And. GFXCP2510('GWM_VLIBM3') .And. GFXCP2510('GWM_VLCBS3')
					cQuery += "GWM.GWM_VLIBS3 GWM_VLIBS, GWM.GWM_VLIBM3 GWM_VLIBM, GWM.GWM_VLCBS3 GWM_VLCBS, "
				EndIf
			Case cCriRat = "4"
				cQuery += "GWM.GWM_VLICM2 GWM_VLICMS, GWM.GWM_VLPIS2 GWM_VLPIS, GWM.GWM_VLCOF2 GWM_VLCOFI, GWM.GWM_VLFRE2 GWM_VLFRET, GWM.GWM_VLISS2 GWM_VLISS, "
				If GFXCP2510('GWM_VLIBS2') .And. GFXCP2510('GWM_VLIBM2') .And. GFXCP2510('GWM_VLCBS2')
					cQuery += "GWM.GWM_VLIBS2 GWM_VLIBS, GWM.GWM_VLIBM2 GWM_VLIBM, GWM.GWM_VLCBS2 GWM_VLCBS, "
				EndIf
		EndCase
		cQuery += "GWM.GWM_SEQGW8, GWM.GWM_ITEM, GW8.GW8_DSITEM, "
		//--------------init-------------------------------
		cQuery += "GW8.GW8_INFO1, GW8.GW8_INFO2, GW8.GW8_INFO3, GW8.GW8_INFO4, GW8.GW8_INFO5, GW8.GW8_VOLUME, GW8.GW8_QTDE, GW8.GW8_PESOR, GW8.GW8_QTDALT, "
		cQuery += "GW8.GW8_PESOC, GW8.GW8_PESOR, GW8.GW8_VALOR, "
		If GFXCP12123("GW8_UNIMED")
			cQuery += "GW8.GW8_UNIMED, "
		EndIf
		cQuery += "GWM.GWM_GRP1, GWM.GWM_GRP2, GWM.GWM_GRP3, GWM.GWM_GRP4, GWM.GWM_GRP5, GWM.GWM_GRP6, GWM.GWM_GRP7, "
		//-------------end---------------------------------- 
		cQuery += "'' as NRCALC, GW3.GW3_CRDICM CRDICM, GW3.GW3_CRDPC CRDPC, '' GXD_CODLOT, '' GXE_PERIOD, '' GXD_CODEST, '' GXD_MOTIES, '' GXN_PERIES, '' GXE_SIT, '' GXN_SIT, "
		cQuery += "'' AS NMCIDORI, '' AS CDUFORI, '' AS NMCIDDES, '' AS CDUFDES, "
		cQuery += "GUS.GUS_CTICMS, GUS.GUS_CCICMS, GUS.GUS_CTPIS, GUS.GUS_CCPIS, GUS.GUS_CTCOFI, GUS.GUS_CCCOFI, "
		cQuery += "GW6.GW6_NRFAT, GW6.GW6_SITAPR, GW6.GW6_SITFIN, GW6.GW6_DTFIN, GW6.GW6_DTFIN DTMOV, GW6.GW6_VLFATU, GW3.GW3_NRDF, GW3.GW3_SERDF, GW3.GW3_EMISDF, GW3.GW3_DTEMIS, "
		cQuery += "GW3.GW3_FILIAL, GW3.GW3_SERDF, GW3.GW3_NRDF, GW3.GW3_CDESP, GW3.GW3_TPDF, GW3.GW3_DTEMIS, GW3.GW3_SIT, GW3.GW3_SITFIS, GW3.GW3_DTFIS, GW3.GW3_VLDF, GW3.GW3_CDTPSE AS TPSERV, "		
		//----------------init------------------
		cQuery += "GW3.GW3_SITREC, GW3.GW3_DTREC, GW6.GW6_VLISRE "
		//------------------end-----------------
		cQuery += "FROM " + RetSQLName("GWM") + " GWM "
		cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU31 "
		cQuery += "ON GU31.GU3_FILIAL = '" + xFilial("GU3") + "' "
		cQuery += "AND GU31.GU3_CDEMIT = GWM.GWM_EMISDC "
		cQuery += "AND GU31.D_E_L_E_T_ = '' "
		cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU32 "
		cQuery += "ON GU32.GU3_FILIAL = '" + xFilial("GU3") + "' "
		cQuery += "AND GU32.GU3_CDEMIT = GWM.GWM_CDTRP "
		cQuery += "AND GU32.D_E_L_E_T_ = '' "
		//-------------init-------------

		cQuery += "INNER JOIN " + RetSQLName("GW1") + " GW1 "
		cQuery += "ON GW1.GW1_FILIAL = GWM.GWM_FILIAL "
		cQuery += "AND GW1.GW1_NRDC = GWM.GWM_NRDC "
		cQuery += "AND GW1.GW1_CDTPDC = GWM.GWM_CDTPDC "
		cQuery += "AND GW1.GW1_EMISDC = GWM.GWM_EMISDC "
		cQuery += "AND GW1.GW1_SERDC = GWM.GWM_SERDC "
		cQuery += "AND GW1.D_E_L_E_T_ = '' "

		cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU33 "
		cQuery += "ON GU33.GU3_FILIAL = '" + xFilial("GU3") + "' "
		cQuery += "AND GU33.GU3_CDEMIT = GW1.GW1_CDREM "
		cQuery += "AND GU33.D_E_L_E_T_ = '' "
		cQuery += "INNER JOIN " + RetSQLName("GU3") + " GU34 "
		cQuery += "ON GU34.GU3_FILIAL = '" + xFilial("GU3") + "' "
		cQuery += "AND GU34.GU3_CDEMIT = GW1.GW1_CDDEST "
		cQuery += "AND GU34.D_E_L_E_T_ = '' "
		//--------------end--------------
		cQuery += "INNER JOIN " + RetSQLName("GW3") + " GW3 "
		cQuery += "ON GW3.GW3_FILIAl = GWM.GWM_FILIAL "
		cQuery += "AND GW3.GW3_EMISDF = GWM.GWM_CDTRP "
		cQuery += "AND GW3.GW3_SERDF = GWM.GWM_SERDOC "
		cQuery += "AND GW3.GW3_NRDF = GWM.GWM_NRDOC "
		cQuery += "AND GW3.GW3_DTEMIS = GWM.GWM_DTEMIS "
		cQuery += "AND GW3.D_E_L_E_T_ = '' " 
		cQuery += "INNER JOIN " + RetSQLName("GW6") + " GW6 "
		cQuery += "ON GW6.GW6_FILIAL = GW3.GW3_FILFAT "
		cQuery += "AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT "
		cQuery += "AND GW6.GW6_SERFAT = GW3.GW3_SERFAT "
		cQuery += "AND GW6.GW6_NRFAT = GW3.GW3_NRFAT "
		cQuery += "AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA "
		cQuery += "AND GW6.D_E_L_E_T_ = '' "
		cQuery += "INNER JOIN " + RetSQLName("GUS") + " GUS "
		cQuery += "ON GUS.GUS_FILCTB = GWM.GWM_FILIAL "
		cQuery += "AND GUS.D_E_L_E_T_ = '' "
		cQuery += "INNER JOIN " + RetSQLName("GW8") + " GW8 "
		cQuery += "ON GW8.GW8_FILIAL = GWM.GWM_FILIAL "
		cQuery += "AND GW8.GW8_CDTPDC = GWM.GWM_CDTPDC "
		cQuery += "AND GW8.GW8_EMISDC = GWM.GWM_EMISDC "
		cQuery += "AND GW8.GW8_SERDC = GWM.GWM_SERDC "
		cQuery += "AND GW8.GW8_NRDC = GWM.GWM_NRDC "
		cQuery += "AND GW8.GW8_SEQ = GWM.GWM_SEQGW8 "
		cQuery += "AND GW8.D_E_L_E_T_ = '' "
		cQuery += "WHERE GWM.D_E_L_E_T_ = '' "
		cQuery += "AND GWM.GWM_TPDOC = '2' "
		cQuery += "AND GW6.GW6_SITFIN = '4' "
		If lFilExc6 .And. !Empty(cLstFil6)
			cQuery += " AND GW6.GW6_FILIAL IN ("+ cLstFil6 +")"
		EndIf
		
		cQuery += "AND GW6.GW6_DTFIN >= '" + DtoS(aPeriodo[1]) + "' "
		cQuery += "AND GW6.GW6_DTFIN <= '" + DtoS(aPeriodo[2]) + "' "
		
		cTabMov := GetNextAlias()
		cQuery  := ChangeQuery(cQuery)
		
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabMov, .F., .T.)
		
		While !(cTabMov)->(Eof())
		
			aInfCal := U_GFERInfCal((cTabMov)->GW3_FILIAL, (cTabMov)->GW3_CDESP, (cTabMov)->GW3_EMISDF, (cTabMov)->GW3_SERDF, (cTabMov)->GW3_NRDF, (cTabMov)->GW3_DTEMIS, (cTabMov)->GWM_NRDC)
			aInfCid := U_GFERInfCid((cTabMov)->GW3_FILIAL, (cTabMov)->GW3_CDESP, (cTabMov)->GW3_EMISDF, (cTabMov)->GW3_SERDF, (cTabMov)->GW3_NRDF, (cTabMov)->GW3_DTEMIS, (cTabMov)->GWM_NRDC)
		
			cNRCALC := aInfCal[2]
			cTPCALC := aInfCal[1]
			cNMCIDORI := aInfCid[1]
			cCDUFORI := aInfCid[2]
			cNMCIDDES := aInfCid[3]
			cCDUFDES := aInfCid[4]
			
			cCtICMS 	:= ""
			cCcICMS 	:= ""
			cCredICMS 	:= 0
			
			cCtPIS 		:= ""
			cCcPIS 		:= ""
			cCredPIS 	:= 0
			
			cCtCOFI 	:= ""
			cCcCOFI 	:= ""
			cCredCOFI 	:= 0
			
			cISSRet		:= 0

			cCredIBS 	:= 0
			cCredIBM 	:= 0
			cCredCBS 	:= 0
			
			If (cTabMov)->GWM_VLICMS > 0 .And. (cTabMov)->CRDICM == "1"
				cCtICMS 	:= (cTabMov)->GUS_CTICMS
				cCcICMS   	:= (cTabMov)->GUS_CCICMS
				cCredICMS 	:= (cTabMov)->GWM_VLICMS
			EndIf
			
			If (cTabMov)->GWM_VLPIS > 0 .And. (cTabMov)->CRDPC == "1"
				cCtPIS 		:= (cTabMov)->GUS_CTPIS
				cCcPIS 		:= (cTabMov)->GUS_CCPIS
				cCredPIS	:= (cTabMov)->GWM_VLPIS
			EndIf
			
			If (cTabMov)->GWM_VLCOFI > 0 .And. (cTabMov)->CRDPC == "1"
				cCtCOFI 	:= (cTabMov)->GUS_CTCOFI
				cCcCOFI 	:= (cTabMov)->GUS_CCCOFI
				cCredCOFI	:= (cTabMov)->GWM_VLCOFI 
			EndIf

			If GFXCP2510('GWM_VLIBS')
				cCredIBS 	:= (cTabMov)->GWM_VLIBS
			EndIf
			If GFXCP2510('GWM_VLIBM')
				cCredIBM 	:= (cTabMov)->GWM_VLIBM
			EndIf
			If GFXCP2510('GWM_VLCBS')
				cCredCBS 	:= (cTabMov)->GWM_VLCBS
			EndIf
			
			If (cTabMov)->GW6_VLISRE > 0
				cISSRet		:= (cTabMov)->GWM_VLISS
			EndIf
			
			nVlFret := (cTabMov)->GWM_VLFRET - (cCredICMS + cCredPIS + cCredCOFI + cCredIBS + cCredIBM + cCredCBS)
			nVlFrTot := (cTabMov)->GWM_VLFRET				
			
			cTotLot := 0
			
			If !Empty((cTabMov)->GXD_CODLOT)
				cQuery := "SELECT SUM(GXF_VALOR) GXF_VALOR "
				cQuery += "FROM " + RetSQLName("GXF") + " GXF "
				cQuery += "INNER JOIN " + RetSQLName("GXE") + " GXE "
				cQuery += "ON GXE.GXE_FILIAL = GXF.GXF_FILIAL "
				cQuery += "AND GXE.GXE_CODLOT = GXF.GXF_CODLOT "
				cQuery += "AND GXE.D_E_L_E_T_ = '' "
				cQuery += "WHERE GXE.GXE_FILIAL = '" + (cTabMov)->GWM_FILIAL + "' "
				cQuery += "AND GXE.GXE_CODLOT = '" + (cTabMov)->GXD_CODLOT + "' "
				cQuery += "AND GXF.D_E_L_E_T_ = '' "
				
				cTabLot := GetNextAlias()
				cQuery  := ChangeQuery(cQuery)
				dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabLot, .F., .T.)
					
				If !(cTabLot)->(Eof())
					cTotLot := (cTabLot)->GXF_VALOR
				EndIf
					
				(cTabLot)->(dbCloseArea())
			EndIf
				
			cTotSub := 0
				
			If !Empty((cTabMov)->GXD_CODEST)
				cQuery := "SELECT SUM(GXO_VALOR) GXO_VALOR "
				cQuery += "FROM " + RetSQLName("GXO") + " GXO "
				cQuery += "INNER JOIN " + RetSQLName("GXN") + " GXN "
				cQuery += "ON GXN.GXN_FILIAL = GXO.GXO_FILIAL "
				cQuery += "AND GXN.GXN_CODLOT = GXO.GXO_CODLOT "
				cQuery += "AND GXN.GXN_CODEST = GXO.GXO_CODEST "
				cQuery += "AND GXN.D_E_L_E_T_ = '' "
				cQuery += "WHERE GXN.GXN_FILIAL = '" + (cTabMov)->GWM_FILIAL + "' "
				cQuery += "AND GXN.GXN_CODLOT = '" + (cTabMov)->GXD_CODLOT + "' "
				cQuery += "AND GXN.GXN_CODEST = '" + (cTabMov)->GXD_CODEST + "' "
				cQuery += "AND GXO.D_E_L_E_T_ = '' "
				
				cTabSub := GetNextAlias()
				cQuery  := ChangeQuery(cQuery)
				dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabSub, .F., .T.)
			
				If !(cTabSub)->(Eof())
					cTotSub := (cTabSub)->GXO_VALOR
				EndIf
				
				(cTabSub)->(dbCloseArea())
			EndIf

			If cMvPar08 == 2
				nLinha := (cTabMov)->DTMOV + ";" + cTpDesp + ";" + (cTabMov)->GWM_FILIAL + ";"
				nLinha += FwFilName(cEmpAnt,(cTabMov)->GWM_FILIAL) + ";" + (cTabMov)->IDEMIS + ";" + (cTabMov)->NMEMIS + ";"
				nLinha += (cTabMov)->GWM_SERDC + ";" + (cTabMov)->GWM_NRDC + ";" + (cTabMov)->GWM_DTEMDC + ";" + (cTabMov)->GWM_CDTPDC + ";"
				nLinha += U_RetTpCtb((cTabMov)->GWM_CDTPDC) + ";" + U_RetUso((cTabMov)->GWM_FILIAL, (cTabMov)->GWM_CDTPDC, (cTabMov)->GW1_EMISDC, (cTabMov)->GWM_SERDC, (cTabMov)->GWM_NRDC) + ";"
				nLinha += (cTabMov)->IDREM + ";" + (cTabMov)->NMREM + ";" + (cTabMov)->IDDEST + ";" + (cTabMov)->NMDEST + ";" + cNrCalc + ";" + (cTabMov)->GXD_CODLOT + ";"
				nLinha += (cTabMov)->GXE_PERIOD + ";" + U_RetSitGXE((cTabMov)->GXE_SIT) + ";" + STR(cTotLot) + ";" + (cTabMov)->GXD_CODEST + ";" + U_RetMotGXD((cTabMov)->GXD_MOTIES) + ";"
				nLinha += (cTabMov)->GXN_PERIES + ";" + U_RetSitGXN((cTabMov)->GXN_SIT) + ";" + STR(cTotSub) + ";" + (cTabMov)->GW3_SERDF + ";" + (cTabMov)->GW3_NRDF + ";" + (cTabMov)->GW3_CDESP + ";"
				nLinha += U_RetTpGW3((cTabMov)->GW3_TPDF) + ";" + (cTabMov)->GW3_DTEMIS + ";" + U_RetSitGW3((cTabMov)->GW3_SIT) + ";" + U_RetFisGW3((cTabMov)->GW3_SITFIS) + ";" + (cTabMov)->GW3_DTFIS + ";"
				nLinha += U_RetFisGW3((cTabMov)->GW3_SITREC) + ";" + (cTabMov)->GW3_DTREC + ";" + (cTabMov)->GWM_CDTRP + ";" + (cTabMov)->IDTRP + ";" + (cTabMov)->NMTRP + ";" + U_RetTpTrp((cTabMov)->AUTON) + ";"
				nLinha += U_RetTpTrb((cTabMov)->TPTRIB) + ";" + U_RetTpMod((cTabMov)->GU3_MODAL) + ";" + cNMCIDORI + ";" + cCDUFORI + ";" + cNMCIDDES + ";" + cCDUFDES + ";" + (cTabMov)->GWM_ITEM + ";" + (cTabMov)->GW8_DSITEM + ";"
				nLinha += (cTabMov)->GW8_INFO1 + ";" + (cTabMov)->GW8_INFO2 + ";" + (cTabMov)->GW8_INFO3 + ";" + (cTabMov)->GW8_INFO4 + ";" + (cTabMov)->GW8_INFO5 + ";"
				nLinha += STR((cTabMov)->GW8_VOLUME) + ";" + STR((cTabMov)->GW8_QTDE) + ";" + (cTabMov)->GW8_UNIMED + ";" + STR((cTabMov)->GW8_QTDALT) + ";" + STR((cTabMov)->GW8_PESOC) + ";" + STR((cTabMov)->GW8_PESOR) + ";"
				nLinha += STR((cTabMov)->GW8_VALOR) + ";" + (cTabMov)->GWM_GRP1 + ";" + (cTabMov)->GWM_GRP2 + ";" + (cTabMov)->GWM_GRP3 + ";" + (cTabMov)->GWM_GRP4 + ";"
				nLinha += (cTabMov)->GWM_GRP5 + ";" + (cTabMov)->GWM_GRP6 + ";" + (cTabMov)->GWM_GRP7 + ";" + (cTabMov)->GWM_UNINEG + ";" + (cTabMov)->GWM_CTFRET + ";" + (cTabMov)->GWM_CCFRET + ";"
				nLinha += STR(nVlFrTot) + ";" + STR(nVlFret) + ";" + cCtICMS + ";" + cCcICMS + ";" + STR((cTabMov)->GWM_VLICMS) + ";" + STR(cCredICMS) + ";" + STR((cTabMov)->GWM_VLISS) + ";" + STR(cISSRet)  + ";" + cCtPIS + ";" + cCcPIS + ";"
				nLinha += STR(cCredPIS) + ";" + cCtCOFI + ";" + cCcCOFI + ";" + STR(cCredCOFI) 
				If GFXCP2510('GWM_VLIBS')
					nLinha += ";" + STR((cTabMov)->GWM_VLIBS)
				EndIf
				If GFXCP2510('GWM_VLIBM')
					nLinha += ";" + STR((cTabMov)->GWM_VLIBM)
				EndIf
				If GFXCP2510('GWM_VLCBS')
					nLinha += ";" + STR((cTabMov)->GWM_VLCBS)
				EndIf
				
				FWrite(nHandle, nLinha + CRLF)
			Else
				oSection1:PrintLine()
			EndIf
				   		 
			(cTabMov)->(dbSkip())
		EndDo
		
		(cTabMov)->(dbCloseArea())
	EndIf
	
	If nHandle > 0
		FClose(nHandle)
	EndIf
	
	oSection1:Finish()
Return

User Function RetSitGXE(cSit)
	Local cDescSit := ""
	
	Do Case
		Case cSit == "1"
			cDescSit := "Não enviado"
		Case cSit == "2"
			cDescSit := "Pendente"
		Case cSit == "3"
			cDescSit := "Rejeitado"
		Case cSit == "4"
			cDescSit := "Atualizado"
		Case cSit == "5"
			cDescSit := "Pendente Estorno"
		Case cSit == "6"
			cDescSit := "Estornado"
		Case cSit == "7"
			cDescSit := "Pendente Estorno Parcial"
		Case cSit == "8"
			cDescSit := "Estornado Parcial"
	EndCase
Return cDescSit

User Function RetSitGXN(cSit)
	Local cDescSit := ""
	
	Do Case
		Case cSit == "1"
			cDescSit := "Não enviado"
		Case cSit == "2"
			cDescSit := "Pendente"
		Case cSit == "3"
			cDescSit := "Rejeitado"
		Case cSit == "4"
			cDescSit := "Atualizado"
		Case cSit == "5"
			cDescSit := "Pendente Desatualização"
		Case cSit == "6"
			cDescSit := "Estornado"
	EndCase
Return cDescSit

User Function RetPeri()
	Local aPeriodo[3]

	Local cMes := SubStr(MV_PAR02, 6, 2)
	Local cAno := SubStr(MV_PAR02, 1, 4)
	Local cDiaIni := IIF(Empty(MV_PAR03),'01',MV_PAR03)
	Local cDiaFim := IIF(Empty(MV_PAR04),cValToChar(Day(LastDay(CtoD('01/' + cMes + "/" + cAno)))),MV_PAR04)

	aPeriodo[1] := CtoD(cDiaIni + '/' + cMes + '/' + cAno)
	aPeriodo[2] := CtoD(cDiaFim + '/' + cMes + '/' + cAno)
	aPeriodo[3] := MV_PAR02

Return aPeriodo

User Function RetSitGW6(cSit)
	Local cDescSit := ""
	
	Do Case
		Case cSit == "1"
			cDescSit := "Recebida"
		Case cSit == "2"
			cDescSit := "Bloqueada"
		Case cSit == "3"
			cDescSit := "Aprovada Sistema"
		Case cSit == "4"
			cDescSit := "Aprovada Usuário"
	EndCase
Return cDescSit

User Function RetFinGW6(cSit)
	Local cDescSit := ""
	
	Do Case
		Case cSit == "1"
			cDescSit := "Não enviada"
		Case cSit == "2"
			cDescSit := "Pendente"
		Case cSit == "3"
			cDescSit := "Rejeitada"
		Case cSit == "4"
			cDescSit := "Atualizada"
		Case cSit == "5"
			cDescSit := "Pendente Desatualização"
	EndCase
Return cDescSit

User Function RetSitGW3(cSit)
	Local cDescSit := ""
	
	Do Case
		Case cSit == "1"
			cDescSit := "Recebido"
		Case cSit == "2"
			cDescSit := "Bloqueado"
		Case cSit == "3"
			cDescSit := "Aprov. Sistema"
		Case cSit == "4"
			cDescSit := "Aprov. Usuário"
	EndCase
Return cDescSit

User Function RetTpGW3(cTp)
	Local cDescTp := ""
	
	Do Case
		Case cTp == "1"
			cDescTp := "Normal"
		Case cTp == "2"
			cDescTp := "Complementar Valor"
		Case cTp == "3"
			cDescTp := "Complementar Imposto"
		Case cTp == "4"
			cDescTp := "Reentrega"
		Case cTp == "5"
			cDescTp := "Devolução"
		Case cTp == "6"
			cDescTp := "Redespacho"
		Case cTp == "7"
			cDescTp := "Serviço"
	EndCase
Return cDescTp

User Function RetFisGW3(cSit)
	Local cDescSit := ""
	
	Do Case
		Case cSit == "1"
			cDescSit := "Não Enviado"
		Case cSit == "2"
			cDescSit := "Pendente"
		Case cSit == "3"
			cDescSit := "Rejeitado"
		Case cSit == "4"
			cDescSit := "Atualizado"
		Case cSit == "5"
			cDescSit := "Pendente Desatualização"
		Case cSit == "6"
			cDescSit := "Não se Aplica"
	EndCase
Return cDescSit

User Function RetMotGXD(cSit)
	Local cDescSit := ""
	
	Do Case
		Case cSit == "03"
			cDescSit := "Realização"
		Case cSit == "05"
			cDescSit := "Prescrição"
	EndCase
Return cDescSit

User Function RetTpTrp(cAuton)
	Local cTpTrp := ""
	
	cTpTrp := IIF(cAuton == '1' ,'AUTÔNOMO','TRANSPORTADOR')

Return cTpTrp

User Function RetTpTrb(cTp)
	Local cDescTp := ""
	
		Do Case
			Case cTp == "1"
				cDescTp := "Normal"
			Case cTp == "2"
				cDescTp := "Simplificado"
			Case cTp == "3"
				cDescTp := "Especial"
			Case cTp == '4'
				cDescTp := 'Imune'
		EndCase

Return cDescTp

User Function RetTpMod(cTp)
	Local cDescMod := ""
	
		Do Case
			Case cTp == "1"
				cDescMod := "Nao-Informado"
			Case cTp == "2"
				cDescMod := "Rodoviario"
			Case cTp == "3"
				cDescMod := "Ferroviario"
			Case cTp == '4'
				cDescMod := 'Aereo'
			Case cTp == '5'
				cDescMod := 'Aquaviario'
			Case cTp == '6'
				cDescMod := 'Dutoviario'
			Case cTp == '7'
				cDescMod := 'Multimodal'
		EndCase

Return cDescMod

User Function RetUso(cFilDc, cCdTpDc, cEmisDc, cSerDc, cNrDc)
	
	Local cDesc := ''
	Local cUso  := ''

	cUso := Posicione('GW1',1,cFilDc + cCdTpDc + cEmisDc + cSerDc  + cNrDc, 'GW1_USO')

	Do Case
		Case cUso == '1'
			cDesc := 'Industrialização/Venda'
		Case cUso == '2'
			cDesc := 'Uso/Consumo'
		Case cUso == '3'
			cDesc := 'Ativo Imobilizado'
	EndCase

Return cDesc

User Function RetTpCtb(cCdTpDc)
	
	Local cDesc := ''
	Local cTpDc := ''

	cTpDc := Posicione('GV5',1,FWxFilial("GV5") + cCdTpDc ,'GV5_FRCTB')

	Do Case
		Case cTpDc == "1"
			cDesc := 'Despesa'
		Case cTpDc == "2"
			cDesc := 'Custo'
		Case cTpDc == "3"
			cDesc := 'Nenhum'
	EndCase 

Return cDesc

User Function RetTpGrp(cCod)
	
	Local cDesc := ''
	Local cInt  := ''

	cInt := SuperGetMV('MV_ERPGFE',,'1') == '1'
	
	Do Case
		Case cCod == '0'
			cDesc := 'NENHUM'
		Case cCod == '1'
			cDesc := 'FILIAL'
		Case cCod == '2'
			cDesc := 'TIPO OPERAÇÃO'
		Case cCod == '3'
			cDesc := 'ITEM'
		Case cCod == '4'
			cDesc := 'REG COMERCIAL'
		Case cCod == '5'
			cDesc := 'GRUPO EMITENTE'
		Case cCod == '6'
			cDesc := 'TIPO DOC CARGA'
		Case cCod == '7'
			cDesc := 'CLASSIFICAÇÂO FRETE'
		Case cCod == '8'
			cDesc := 'TIPO DE FRETE'
		Case cCod == '9'
			If cInt
				cDesc := 'NATUREZA DE OPERAÇÃO'
			Else
				cDesc := 'INFO CTB 1'
			EndIf
		Case cCod == '10'
			If cInt
				cDesc := 'CANAL DE VENDAS'
			Else
				cDesc := 'INFO CTB 2'
			EndIf
		Case cCod == '11'
			If cInt
				cDesc := 'GRUPO DE ESTOQUE'
			Else
				cDesc := 'INFO CTB 3'
			EndIf
		Case cCod == '12'
			If cInt
				cDesc := 'FAMILIA COMERCIAL'
			Else
				cDesc := 'INFO CTB 4'
			EndIf
		Case cCod == '13'
			If cInt
				cDesc := 'FAMILIA DE MATERIAIS'
			Else
				cDesc := 'INFO CTB 5'
			EndIf
		Case cCod == '14'
			cDesc := 'REPRESENTANTE'
		Case cCod == '15'
			cDesc := 'UNIDADE DE NEGÓCIO'
		Case cCod == '16'
			cDesc := 'CFOP ITEM DOC CARGA'
		Case cCod == '16'
			cDesc := 'TIPO DE SERVIÇO'
		OtherWise
			cDesc := 'NENHUM'
	EndCase
Return cDesc

User Function GFER01VLD(nTipo)
	Local lRet := .T.
	Local cTmp
	Local cMes := SubStr(MV_PAR02, 6, 2)
	Local cAno := SubStr(MV_PAR02, 1, 4)
	Local cPeriodo := cMes + '/' + cAno

	Do Case
		Case nTipo == 2 // Período
			cTmp := '01/' + cPeriodo
			if Empty(CTOD(cTmp))
				gfehelp('O período informado não é válido','O período informado deve corresponder ao mês e Ano (aaaa/mm) que seja listar as informações.','Período')
				lRet := .F.
			EndIf
		Case nTipo == 3 // Dia Inicial
			if !Empty(MV_PAR03)
				cTmp := MV_PAR03 + '/' + cPeriodo
				if Empty(CTOD(cTmp))
					gfehelp('O dia inicial informado não é válido para o período informado','Informe um dia válido que corresponde ao ano/mês informado no campo Período.','Dia inicial')
					lRet := .F.
				Else
					if !Empty(MV_PAR04)
						if Val(MV_PAR03) > val(MV_PAR04)
							gfehelp('O dia inicial é maior que o dia final','O dia inicial deve ser menor ou igual ao  dia final.','Dia inicial')
							lRet := .F.
						EndIf
					EndIf
				EndIf
			EndIf
		Case nTipo == 4 // Dia Final
			if !Empty(MV_PAR04)
				cTmp := MV_PAR04 + '/' + cPeriodo
				if Empty(CTOD(cTmp))
					gfehelp('O dia final informado não é válido para o período informado','Informe um dia válido que corresponde ao ano/mês informado no campo período.','Dia final')
					lRet := .F.
				Else
					if !Empty(MV_PAR03)
						if Val(MV_PAR03) > val(MV_PAR04)
							gfehelp('O dia inicial é maior que o dia final','O dia inicial deve ser menor ou igual ao dia final.','Dia final')
							lRet := .F.
						EndIf
					EndIf
				EndIf
			EndIf
	EndCase
Return lRet

User Function GFERInfCal(cGW3_FILIAL, cGW3_CDESP, cGW3_EMISDF, cGW3_SERDF, cGW3_NRDF, cGW3_DTEMIS, cGW1_NRDC)

	Local cQuery := ""
	Local cTabGWF := ""
	Local aRet[2]

	cQuery += "SELECT GWF.GWF_TPCALC, GWF.GWF_NRCALC "
	cQuery += "FROM " + RetSQLName("GWF") + " GWF "
	cQuery += "INNER JOIN " + RetSQLName("GW3") + " GW3 "
	cQuery += "ON GWF.GWF_FILIAL = GW3.GW3_FILIAL  "
	cQuery += "AND GWF.GWF_CDESP  = GW3.GW3_CDESP  "
	cQuery += "AND GWF.GWF_EMISDF = GW3.GW3_EMISDF  "
	cQuery += "AND GWF.GWF_SERDF  = GW3.GW3_SERDF  "
	cQuery += "AND GWF.GWF_NRDF   = GW3.GW3_NRDF    "
	cQuery += "AND GWF.GWF_DTEMDF = GW3.GW3_DTEMIS "
	cQuery += "AND GWF.D_E_L_E_T_ = ''  "
	cQuery += "INNER JOIN " + RetSQLName("GWH") + " GWH "
	cQuery += "ON GWF.GWF_FILIAL = GWH.GWH_FILIAL "
	cQuery += "AND GWF.GWF_NRCALC = GWH.GWH_NRCALC "
	cQuery += "AND GWH.D_E_L_E_T_ = '' "
	cQuery += "WHERE GW3.GW3_FILIAL = '" + cGW3_FILIAL + "' "
	cQuery += "AND GW3.GW3_CDESP = '" + cGW3_CDESP + "' "
	cQuery += "AND GW3.GW3_EMISDF = '" + cGW3_EMISDF + "' "
	cQuery += "AND GW3.GW3_SERDF = '" + cGW3_SERDF + "' "
	cQuery += "AND GW3.GW3_NRDF = '" + cGW3_NRDF + "' "
	cQuery += "AND GW3.GW3_DTEMIS = '" + cGW3_DTEMIS + "' "
	cQuery += "AND GWH.GWH_NRDC = '" + cGW1_NRDC + "' "
	cQuery += "AND GWF.D_E_L_E_T_ = ''

	cTabGWF := GetNextAlias()
	cQuery  := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabGWF, .F., .T.)
	
	(cTabGWF)->(dbGoTop())
	aRet[1] := (cTabGWF)->GWF_TPCALC
	aRet[2] := (cTabGWF)->GWF_NRCALC
	
	(cTabGWF)->( dbCloseArea() )
	
Return aRet

User Function GFERInfCid(cGW3_FILIAL, cGW3_CDESP, cGW3_EMISDF, cGW3_SERDF, cGW3_NRDF, cGW3_DTEMIS, cGW1_NRDC)
	Local aRet[4]
	Local cQuery  := ""
	Local cTabGWF := GetNextAlias()

	cQuery += "SELECT GU7ORI.GU7_NMCID AS NMCIDORI, GU7ORI.GU7_CDUF AS CDUFORI, GU7DES.GU7_NMCID AS NMCIDDES, GU7DES.GU7_CDUF AS CDUFDES "
	cQuery += 	   ", GU7GW3O.GU7_NMCID AS DFNMCIDORI, GU7GW3O.GU7_CDUF AS DFCDUFORI, GU7GW3D.GU7_NMCID AS DFNMCIDDES, GU7GW3D.GU7_CDUF AS DFCDUFDES"
	cQuery += " FROM " + RetSQLName("GW3") + " GW3"
	cQuery += " LEFT JOIN " + RetSQLName("GWF") + " GWF"
	cQuery += " ON GWF.GWF_FILIAL = GW3.GW3_FILIAL"
	cQuery += " AND GWF.GWF_CDESP = GW3.GW3_CDESP"
	cQuery += " AND GWF.GWF_EMISDF = GW3.GW3_EMISDF"
	cQuery += " AND GWF.GWF_SERDF = GW3.GW3_SERDF"
	cQuery += " AND GWF.GWF_NRDF = GW3.GW3_NRDF"
	cQuery += " AND GWF.GWF_DTEMDF = GW3.GW3_DTEMIS"
	cQuery += " AND GWF.D_E_L_E_T_ = ''"
	cQuery += " LEFT JOIN " + RetSQLName("GWH") + " GWH"
	cQuery += " ON GWH.GWH_FILIAL = GWF.GWF_FILIAL"
	cQuery += " AND GWH.GWH_NRCALC = GWF.GWF_NRCALC"
	cQuery += " AND GWH.GWH_NRDC = '" + cGW1_NRDC + "'"
	cQuery += " AND GWH.D_E_L_E_T_ = ''"
	cQuery += " LEFT JOIN " + RetSQLName("GU7") + " GU7ORI"
	cQuery += " ON GU7ORI.GU7_FILIAL = '" + xFilial("GU7") + "'"
	cQuery += " AND GU7ORI.GU7_NRCID = GWF.GWF_CIDORI"
	cQuery += " AND GU7ORI.D_E_L_E_T_ = ''"
	cQuery += " LEFT JOIN " + RetSQLName("GU7") + " GU7DES"
	cQuery += " ON GU7DES.GU7_FILIAL = '" + xFilial("GU7") + "'"
	cQuery += " AND GU7DES.GU7_NRCID = GWF.GWF_CIDDES"
	cQuery += " AND GU7DES.D_E_L_E_T_ = ''"
	cQuery += " LEFT JOIN " + RetSQLName("GU7") + " GU7GW3O"
	cQuery += " ON GU7GW3O.GU7_FILIAL = '" + xFilial("GU7") + "'"
	cQuery += " AND GU7GW3O.GU7_NRCID = GW3.GW3_MUNINI"
	cQuery += " AND GU7GW3O.GU7_CDUF = GW3.GW3_UFINI"
	cQuery += " AND GU7GW3O.D_E_L_E_T_ = ''"
	cQuery += " LEFT JOIN " + RetSQLName("GU7") + " GU7GW3D"
	cQuery += " ON GU7GW3D.GU7_FILIAL = '" + xFilial("GU7") + "'"
	cQuery += " AND GU7GW3D.GU7_NRCID = GW3.GW3_MUNFIM"
	cQuery += " AND GU7GW3D.GU7_CDUF = GW3.GW3_UFFIM"
	cQuery += " AND GU7GW3D.D_E_L_E_T_ = ''"
	cQuery += " WHERE GW3.GW3_FILIAL = '" + cGW3_FILIAL + "'"
	cQuery += " AND GW3.GW3_CDESP = '" + cGW3_CDESP + "'"
	cQuery += " AND GW3.GW3_EMISDF = '" + cGW3_EMISDF + "'"
	cQuery += " AND GW3.GW3_SERDF = '" + cGW3_SERDF + "'"
	cQuery += " AND GW3.GW3_NRDF = '" + cGW3_NRDF + "'"
	cQuery += " AND GW3.GW3_DTEMIS = '" + cGW3_DTEMIS + "'"
	cQuery += " AND GW3.D_E_L_E_T_ = ''"
	
	cQuery  := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cTabGWF, .F., .T.)
	
	(cTabGWF)->(dbGoTop())
	If !(cTabGWF)->(Eof())
		If !Empty((cTabGWF)->NMCIDORI) .Or. !Empty((cTabGWF)->NMCIDDES)
			aRet[1] := (cTabGWF)->NMCIDORI
			aRet[2] := (cTabGWF)->CDUFORI
			aRet[3] := (cTabGWF)->NMCIDDES
			aRet[4] := (cTabGWF)->CDUFDES
		Else
			aRet[1] := (cTabGWF)->DFNMCIDORI
			aRet[2] := (cTabGWF)->DFCDUFORI
			aRet[3] := (cTabGWF)->DFNMCIDDES
			aRet[4] := (cTabGWF)->DFCDUFDES
		EndIf
	EndIf
	
	(cTabGWF)->( dbCloseArea() )
	
Return aRet

Static Function SchedDef()
	Local aParam
	Local aOrd     := {"Filial"}

	aParam := { "R",;                      //Tipo R para relatorio P para processo   
				"GFER001",;// Pergunte do relatorio, caso nao use passar ParamDef            
				"GWM",;  // Alias            
				aOrd,;   //Array de ordens   
				"Schedule GFER001"}
Return aParam
