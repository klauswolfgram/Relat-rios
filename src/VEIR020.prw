/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"
#INCLUDE "VEIR020.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ VEIR020  ³ Autor ³  Mauro / Innvare      ³ Data ³ 07/08/23 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Consulta Estoque de Veiculos                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEIR020()
Local aArea := GetArea()
U_FS_VR020Imp()
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_VR020Imp³ Autor ³ Mauro / Inoovare      ³ Data ³ 07/08/23 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao do Relatorio.	                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_VR020Imp()
Private aReturn := {STR0001, 1, STR0002, 2, 2, 1, "", 1} // Zebrado / Administracao
Private cPerg   := "VR020"
Private cTitulo := STR0003		//"Estoque de Veiculos"
Private oReport
Private oSection

IF !Pergunte(cPerg,.T.)
	Return NIL
Endif 

IIF(Select("TRB") > 0,TRB->(dbCloseArea()),)

SET CENTURY OFF
Processa( { |lEnd| Imp_VR020() ,STR0007},STR0008) // "Gerando o Relatório ... " "Aguarde..."
SET CENTURY ON
Return

Static function reportDef(cPerg)

oReport := TReport():new("VEIR020",STR0009,cPerg,{|| printReport()},STR0009) //"Relação dos Veículos/Máquinas"
oReport:SetLandscape() //orientação da página como paisagem
oReport:nFontBody := 04 //tamanho da fonte padrão
oReport:setTotalInLine(.F.)
oReport:showHeader()

oSection := TRSection():new(oReport,STR0009,{"TRB"})// "Relação dos Veículos/Máquinas"
oReport:setTotalInLine(.F.)
TRCell():new(oSection, "Veículos",,"")
oSection:cell("Veículos"):disable()

//define as colunas com o campo da tabela, tabela e cabeçalho que estará na planilha

TRCell():new(oSection, "TRB_TIPOVD" , "TRB",STR0010, "@!"   	     		,  04,, {|| TRB_TIPOVD },,,        ,,,,,,)  // "Tipo"
TRCell():new(oSection, "TRB_PROVVV"	, "TRB",STR0011, "@!"      	  			,  02,, {|| TRB_PROVVV },,,        ,,,,,,)  // "Orig."
TRCell():new(oSection, "TRB_PROVVD" , "TRB",STR0012, "@!"        			,  05,, {|| TRB_PROVVD },,,        ,,,,,,)  // "Descr."
TRCell():new(oSection, "TRB_DIAEST"	, "TRB",STR0013, "@9"  					,  06,, {|| TRB_DIAEST },,,"RIGHT" ,,,,,,)  // "Dias/Est."
TRCell():new(oSection, "TRB_FILIAL"	, "TRB",STR0014, "@!"        			,  04,, {|| TRB_FILIAL },,,        ,,,,,,)  // "Fil. Atu"
TRCell():new(oSection, "TRB_FILENT"	, "TRB",STR0015, "@!"        			,  04,, {|| TRB_FILENT },,,        ,,,,,,)  // "Fil. Ent"
TRCell():new(oSection, "TRB_NUMNFI"	, "TRB",STR0016, "@!"       			,  09,, {|| TRB_NUMNFI },,,        ,,,,,,)  // "N.Fiscal"
TRCell():new(oSection, "TRB_DTDIGI" , "TRB",STR0017, "@!"        			,  10,, {|| TRB_DTDIGI },,,        ,,,,,,)  // "Dt.Digit."
TRCell():new(oSection, "TRB_DATEMI" , "TRB",STR0018, "@!"        			,  10,, {|| TRB_DATEMI },,,        ,,,,,,)  // "Dt.Emiss."
TRCell():new(oSection, "TRB_FORNEC"	, "TRB",STR0019, "@!"        			,  15,, {|| TRB_FORNEC },,,        ,,,,,,)  // "Fornec."
TRCell():new(oSection, "TRB_MARMOD" , "TRB",STR0020, "@!"        			,  20,, {|| TRB_MARMOD },,,        ,,,,,,)  // "Marca/Modelo"
TRCell():new(oSection, "TRB_ANOMOD" , "TRB",STR0021, "@!"        			,  08,, {|| TRB_ANOMOD },,,        ,,,,,,)  // "Ano"
TRCell():new(oSection, "TRB_CHASSI" , "TRB",STR0022, "@!"        			,  25,, {|| TRB_CHASSI },,,        ,,,,,,)  // "Chassi"
TRCell():new(oSection, "TRB_CORVEI"	, "TRB",STR0023, "@!"        			,  15,, {|| TRB_CORVEI },,,        ,,,,,,)  // "Cor"
TRCell():new(oSection, "TRB_VALNFI"	, "TRB",STR0024, "@E 999,999,999.99" 	,  15,, {|| TRB_VALNFI },,,"RIGHT" ,,,,,,)  // "Valor Unit."
TRCell():new(oSection, "TRB_VALFRE"	, "TRB",STR0025, "@E 999,999,999.99" 	,  15,, {|| TRB_VALFRE },,,"RIGHT" ,,,,,,)  // "Frete"
TRCell():new(oSection, "TRB_CUSTOV"	, "TRB",STR0026, "@E 999,999,999.99" 	,  15,, {|| TRB_CUSTOV },,,"RIGHT" ,,,,,,)  // "S/ Corr."			
TRCell():new(oSection, "TRB_CUSATU"	, "TRB",STR0027, "@E 999,999,999.99" 	,  15,, {|| TRB_CUSATU },,,"RIGHT" ,,,,,,)  // "C/ Corr."			
TRCell():new(oSection, "TRB_CODIND"	, "TRB",STR0028, "@!"        			,  05,, {|| TRB_CODIND },,,        ,,,,,,)  // "Ind. Corr."	
TRCell():new(oSection, "TRB_DESIND"	, "TRB",STR0029, "@!"        			,  10,, {|| TRB_DESIND },,,        ,,,,,,)  // "Descrição"		
TRCell():new(oSection, "TRB_SITVEI"	, "TRB",STR0030, "@!"        			,  02,, {|| TRB_SITVEI },,,        ,,,,,,)  // "Situação"			
TRCell():new(oSection, "TRB_DESSIT"	, "TRB",STR0031, "@!"        			,  15,, {|| TRB_DESSIT },,,        ,,,,,,)  // "Descr. Sit."
TRCell():new(oSection, "TRB_PLAVEI"	, "TRB",STR0032, "@!"        			,  10,, {|| TRB_PLAVEI },,,        ,,,,,,)  // "Placa"
TRCell():new(oSection, "TRB_POSIPI"	, "TRB",STR0033, "@!"        			,  02,, {|| TRB_POSIPI },,,        ,,,,,,)  // "Clas. Fisc."
TRCell():new(oSection, "TRB_DISEIX"	, "TRB",STR0034, "@!"        			,  10,, {|| TRB_DISEIX },,,        ,,,,,,)  // "Eixos"

IF Mv_PAR08 == 1
	oBreak1 := TRBreak():New(oSection, oSection:Cell("TRB_TIPOVD"), {||STR0035}, .F.)//"Total por Tipo "
	TRFunction():New(oSection:Cell('TRB_TIPOVD'),NIL,"COUNT",oBreak1,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('TRB_VALNFI'),NIL,"SUM",oBreak1,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)

	oBreak2 := TRBreak():New(oSection, oSection:Cell("TRB_PROVVV"), {||STR0036}, .F.)//"Total por Origem "
	TRFunction():New(oSection:Cell('TRB_PROVVV'),NIL,"COUNT",oBreak2,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('TRB_VALNFI'),NIL,"SUM",oBreak2,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)

	oBreak3 := TRBreak():New(oSection, oSection:Cell("TRB_SITVEI"), {||STR0037}, .F.)//"Total por Situação "
	TRFunction():New(oSection:Cell('TRB_SITVEI'),NIL,"COUNT",oBreak3,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection:Cell('TRB_VALNFI'),NIL,"SUM",oBreak3,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
Endif

TRFunction():New(oSection:Cell("TRB_TIPOVD"),NIL,"COUNT",,"",,,.F.,.T.)
TRFunction():New(oSection:Cell("TRB_VALNFI"),NIL,"SUM"  ,,"",,,.F.,.T.)
oReport:SetTotalInLine(.F.)
	
//Aqui, farei uma quebra  por seção
oSection:SetPageBreak(.T.)
oSection:SetTotalText(" ")				

return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Imp_VEIVX060³ Autor ³ Mauro /Innovare       ³ Data ³ 07/08/23 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao do Relatorio.	                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Imp_VR020

Local cSQL, cAliasTMP := "TFILMOV", cHoraEnt, cHoraSai, cPoder3
Local cCHAINT := ""

Local aFilAtu   := FWArrFilAtu()
Local cFilBkp   := cFilAnt
Local nCont 	:= 0

Local cNamVV1   := RetSQLName("VV1")
Local cNamVVH   := RetSQLName("VVH")
Local cNamVVC   := RetSQLName("VVC")
Local cNamVV0   := RetSQLName("VV0")
Local cNamVVA   := RetSQLName("VVA")
Local cNamVVF   := RetSQLName("VVF")
Local cNamVVG   := RetSQLName("VVG")
Local cNamSF4   := RetSQLName("SF4")
Local cNamSA2   := RetSQLName("SA2")
Local cNamSA1   := RetSQLName("SA1")
Local cNamVVP   := RetSQLName("VVP")
Local cNamSB2   := RetSQLName("SB2")

Local cFilVV1   := ""
Local cFilVV2   := ""
Local cFilVVH   := ""
Local cFilVVC   := ""
Local cFilVV0   := ""
Local cFilVVF   := ""
Local cFilSF4   := ""
Local cFilSA2   := ""
Local cFilSA1   := ""
Local cFilVVP   := ""
Local cFilSB1   := ""
Local cFilSB2   := ""
Local cFornece  := ""
Local cVVFDTH   := Str(( 8 + 1 + TamSX3("VVF_DTHEMI")[1] ),2)
Local cVV0DTH   := Str(( 8 + 1 + TamSX3("VV0_DTHEMI")[1] ),2)

Private aSM0    	:= FWAllFilial( aFilAtu[3] , aFilAtu[4] , aFilAtu[1] , .f. )
Private cGruVei     := PadR(AllTrim(GetMv("MV_GRUVEI")),TamSx3("B1_GRUPO")[1]," ") // Grupo do Veiculo
Private nTotCUSCo	:= 0
Private cSGBD := Upper(TcGetDb())
Private oVR020SQL := DMS_SqlHelper():New()

// Cria Arquivo de Trabalho

aVetCampos := {}
aadd(aVetCampos,{ "TRB_FILIAL"  , "C" , FWSizeFilial()  , 0 })
aadd(aVetCampos,{ "TRB_FILENT"  , "C" , FWSizeFilial()  , 0 })
aadd(aVetCampos,{ "TRB_TIPOVV"  , "C" , 1  , 0 })
aadd(aVetCampos,{ "TRB_TIPOVD"  , "C" , 1  , 0 })
aadd(aVetCampos,{ "TRB_PROVVV"  , "C" , 1  , 0 })
aadd(aVetCampos,{ "TRB_PROVVD"  , "C" , 04 , 0 })
aadd(aVetCampos,{ "TRB_DIAEST"  , "N" , 6  , 0 })
aadd(aVetCampos,{ "TRB_NUMNFI"  , "C" , 9  , 0 })
aadd(aVetCampos,{ "TRB_DTDIGI"  , "D" , 8  , 0 })
aadd(aVetCampos,{ "TRB_FORNEC"  , "C" , 15 , 0 })
aadd(aVetCampos,{ "TRB_DATEMI"  , "D" , 8  , 0 })
aadd(aVetCampos,{ "TRB_MODELO"  , "C" , 24 , 0 })
aadd(aVetCampos,{ "TRB_MARMOD"  , "C" , 25 , 0 })
aadd(aVetCampos,{ "TRB_CHASSI"  , "C" , 25 , 0 })
aadd(aVetCampos,{ "TRB_CORVEI"  , "C" , 10 , 2 })
aadd(aVetCampos,{ "TRB_VALNFI"  , "N" , 12 , 2 })
aadd(aVetCampos,{ "TRB_ICMRET"  , "N" , 12 , 2 })
aadd(aVetCampos,{ "TRB_PICRET"  , "N" , 12 , 2 })
aadd(aVetCampos,{ "TRB_VALFRE"  , "N" , 12 , 2 })
aadd(aVetCampos,{ "TRB_VALTAB"  , "N" , 12 , 2 })
aadd(aVetCampos,{ "TRB_CODIND"  , "C" , 2  , 0 })
aadd(aVetCampos,{ "TRB_DESIND"  , "C" , 12 , 0 })
aadd(aVetCampos,{ "TRB_TIPFAT"  , "C" , 1  , 0 })
aadd(aVetCampos,{ "TRB_CUSTOV"  , "N" , 12 , 2 })
aadd(aVetCampos,{ "TRB_CUSATU"  , "N" , 12 , 2 })
aadd(aVetCampos,{ "TRB_SITVEI"  , "C" , 1  , 0 })
aadd(aVetCampos,{ "TRB_DESSIT"  , "C" , 20 , 0 })
aadd(aVetCampos,{ "TRB_PLAVEI"  , "C" , 10 , 0 })
aadd(aVetCampos,{ "TRB_ANOMOD"  , "C" , 8  , 0 })
aadd(aVetCampos,{ "TRB_DEPTO "  , "C" , 2  , 0 })
aadd(aVetCampos,{ "TRB_NFSAI "  , "C" , 9  , 0 })
aadd(aVetCampos,{ "TRB_MODVEI"  , "C" , 20 , 0 })
aadd(aVetCampos,{ "TRB_POSIPI"  , "C" , 8 , 0 })
aadd(aVetCampos,{ "TRB_DISEIX"  , "N" , 6 , 0 })

oObjTempTable := OFDMSTempTable():New()
oObjTempTable:cAlias := "TRB"
oObjTempTable:aVetCampos := aVetCampos
oObjTempTable:AddIndex(, {"TRB_TIPOVD","TRB_PROVVV","TRB_SITVEI","TRB_MODELO","TRB_CORVEI","TRB_CHASSI"} )
oObjTempTable:CreateTable()

dbSelectArea("VVF")
dbSetOrder(1)

dbSelectArea("VVG")
dbSetOrder(1)

dbSelectArea("VV1")
dbSetOrder(1)

dbSelectArea("VV2")
dbSetOrder(1)

dbSelectArea("VVH")
dbSetOrder(1)

If len(aSM0) > 0
	
	For nCont := 1 to Len(aSM0)
		
		cFilAnt := aSM0[nCont]
		
		If !(cFilAnt >= Mv_Par01 .and. cFilAnt <= Mv_Par02)
			loop
		Endif
		
		cFilVV1 := xFilial("VV1")
		cFilVV2 := xFilial("VV2")
		cFilVVH := xFilial("VVH")
		cFilVVC := xFilial("VVC")
		cFilVV0 := xFilial("VV0")
		cFilVVF := xFilial("VVF")
		cFilSF4 := xFilial("SF4")
		cFilSA2 := xFilial("SA2")
		cFilSA1 := xFilial("SA1")		
		cFilVVP := xFilial("VVP")
		cFilSB1 := xFilial("SB1")
		cFilSB2 := xFilial("SB2")
		
		cSQL := "SELECT CASE WHEN TENTRADA.CHAINT IS NOT NULL THEN TENTRADA.CHAINT"
		cSQL +=            " ELSE TSAIDA.CHAINT"
		cSQL +=        " END CHAINT,"
		cSQL +=        " TENTRADA.VVF_DATMOV, TENTRADA.VVF_OPEMOV, TENTRADA.VVF_TRACPA, TENTRADA.VVG_CODTES, TENTRADA.VVF_DTHEMI,"
		cSQL +=        " TSAIDA.VV0_DATMOV, TSAIDA.VV0_OPEMOV, TSAIDA.VV0_NUMTRA, TSAIDA.VVA_CODTES, TSAIDA.VV0_DTHEMI, TSAIDA.VV0_DEPTO, TSAIDA.VV0_NUMNFI"
		cSQL += " FROM ( SELECT TENTTMP.CHAINT, VVF2.VVF_DATMOV, VVF2.VVF_OPEMOV, VVF2.VVF_TRACPA, VVG2.VVG_CODTES, VVF2.VVF_DTHEMI, VVG2.VVG_ESTVEI"
		iif ("MSSQL" $ cSGBD,cSQL += " FROM ( SELECT VVG_CHAINT CHAINT , MAX(VVF_DATMOV + VVF_DTHEMI + VVF_TRACPA) VVFTMP",cSQL += " FROM ( SELECT VVG_CHAINT CHAINT , MAX(VVF_DATMOV || VVF_DTHEMI || VVF_TRACPA) VVFTMP")
		cSQL += " FROM "+cNamVVF+" VVF "
		cSQL += " JOIN "+cNamVVG+" VVG ON ( VVG_FILIAL=VVF_FILIAL AND VVG_TRACPA=VVF_TRACPA AND VVG.D_E_L_E_T_=' ' ) "
		cSQL += " JOIN "+cNamSF4+" F4 ON ( F4.F4_FILIAL='"+cFilSF4+"' AND F4.F4_CODIGO=VVG.VVG_CODTES AND "  // Somente TES que movimenta estoque
		if mv_par06 == 1
			cSQL += " F4.F4_ESTOQUE='S' AND "
		Elseif mv_par06 == 2
			cSQL += " F4.F4_ESTOQUE='N' AND "
		Endif	
		cSQL += " F4.D_E_L_E_T_=' ') "  
		if !Empty(MV_PAR03)
			cSQL += " JOIN "+cNamVV1+" VV1 ON ( VV1_FILIAL='"+cFilVV1+"' AND VV1_CHAINT=VVG_CHAINT AND VV1_CODMAR='"+MV_PAR03+"' "
			if MV_PAR07 == 1
				cSQL += " AND VV1_IMOBI = '1' "
			Elseif MV_PAR07 == 2
				cSQL += " AND VV1_IMOBI <> '1' "
			Endif
			cSQL += " AND VV1.D_E_L_E_T_=' ' ) " 
		Elseif MV_PAR07 <> 3
			cSQL += " JOIN "+cNamVV1+" VV1 ON ( VV1_FILIAL='"+cFilVV1+"' AND VV1_CHAINT=VVG_CHAINT "
			if MV_PAR07 == 1
				cSQL += " AND VV1_IMOBI = '1' "
			Elseif MV_PAR07 == 2
				cSQL += " AND VV1_IMOBI <> '1' "
			Endif
			cSQL += " AND VV1.D_E_L_E_T_=' ' ) "
		endif
		cSQL +=                  " WHERE "
		cSQL +=                    " VVF_FILIAL = '"+cFilVVF+"' AND "
		cSQL +=                    " VVF_OPEMOV IN ('0','1','2','3','4','5','7','8') "
		cSQL +=                    " AND VVF_DATMOV <= '"+DtoS(mv_par04)+"'"
		cSQL +=                    " AND VVF_SITNFI <> '0'"
		cSQL +=                    " AND VVF.D_E_L_E_T_ = ' '"
		cSQL +=                  " GROUP BY VVG_CHAINT ) TENTTMP"
		cSQL +=                 " JOIN "+cNamVVF+" VVF2 ON VVF2.VVF_FILIAL = '"+cFilVVF+"'"
		iif ("MSSQL" $ cSGBD ,cSQL +=" AND VVF2.VVF_TRACPA = SUBSTRING(TENTTMP.VVFTMP,"+cVVFDTH+",10)",cSQL +=" AND VVF2.VVF_TRACPA = SUBSTR(TENTTMP.VVFTMP,"+cVVFDTH+",10)")		
		cSQL +=                                 " AND VVF2.D_E_L_E_T_ = ' '"
		cSQL +=                 " JOIN "+cNamVVG+" VVG2 ON VVG2.VVG_FILIAL = '"+cFilVVF+"'"
		iif ("MSSQL" $ cSGBD ,cSQL +=" AND VVG2.VVG_TRACPA = SUBSTRING(TENTTMP.VVFTMP,"+cVVFDTH+",10)",cSQL +=" AND VVG2.VVG_TRACPA = SUBSTR(TENTTMP.VVFTMP,"+cVVFDTH+",10)")
		cSQL +=                                 " AND VVG2.VVG_CHAINT = TENTTMP.CHAINT "
		cSQL +=                                 " AND VVG2.D_E_L_E_T_ = ' '"
		cSQL +=        " ) TENTRADA"
		cSQL +=        " FULL JOIN"
		cSQL +=        " ( SELECT TSAITMP.CHAINT, VV02.VV0_DATMOV, VV02.VV0_OPEMOV, VV02.VV0_NUMTRA, VVA2.VVA_CODTES, VV02.VV0_DTHEMI, VV02.VV0_DEPTO, VV02.VV0_NUMNFI "
		iif ("MSSQL" $ cSGBD ,cSQL += " FROM ( SELECT VVA_CHAINT CHAINT, MAX(VV0_DATMOV + VV0_DTHEMI + VV0_NUMTRA) VV0TMP",cSQL += " FROM ( SELECT VVA_CHAINT CHAINT, MAX(VV0_DATMOV || VV0_DTHEMI || VV0_NUMTRA) VV0TMP")
		cSQL += " FROM "+cNamVV0+" VV0 "
		cSQL += " JOIN "+cNamVVA+" VVA ON ( VVA_FILIAL=VV0_FILIAL AND VVA_NUMTRA=VV0_NUMTRA AND VVA.D_E_L_E_T_=' ' ) "
		cSQL += " JOIN "+cNamSF4+" F4 ON ( F4.F4_FILIAL='"+cFilSF4+"' AND F4.F4_CODIGO=VVA.VVA_CODTES AND "  // Somente TES que movimenta estoque
		if mv_par06 == 1
			cSQL += " F4.F4_ESTOQUE='S' AND "
		Elseif mv_par06 == 2
			cSQL += " F4.F4_ESTOQUE='N' AND "
		Endif	                  
		cSQL += " F4.D_E_L_E_T_=' ') "  
		if !Empty(MV_PAR03)
			cSQL += " JOIN "+cNamVV1+" VV1 ON ( VV1_FILIAL='"+cFilVV1+"' AND VV1_CHAINT=VVA_CHAINT AND VV1_CODMAR='"+MV_PAR03+"' "
			if MV_PAR07 == 1
				cSQL += " AND VV1_IMOBI = '1' "
			Elseif MV_PAR07 == 2
				cSQL += " AND VV1_IMOBI <> '1' "
			Endif
			cSQL += " AND VV1.D_E_L_E_T_=' ' ) "
		Elseif MV_PAR07 <> 3
			cSQL += " JOIN "+cNamVV1+" VV1 ON ( VV1_FILIAL='"+cFilVV1+"' AND VV1_CHAINT=VVA_CHAINT " 
			if MV_PAR07 == 1
				cSQL += " AND VV1_IMOBI = '1' "
			Elseif MV_PAR07 == 2
				cSQL += " AND VV1_IMOBI <> '1' "
			Endif
			cSQL += " AND VV1.D_E_L_E_T_=' ' ) "
		Endif
		cSQL +=  " WHERE "
		cSQL +=  " VV0_FILIAL = '"+cFilVV0+"' AND"
		cSQL +=  " VV0_OPEMOV IN ('0','2','3','4','5','6','7')"
		cSQL +=  " AND VV0_DATMOV <= '"+DtoS(mv_par04)+"'"
		cSQL +=  " AND VV0_SITNFI <> '0'"
		cSQL +=  " AND VV0_NUMNFI <> ' '"
		cSQL +=  " AND VV0.D_E_L_E_T_ = ' '"
		cSQL +=  " GROUP BY VVA_CHAINT ) TSAITMP"
		cSQL +=  " JOIN "+cNamVV0+" VV02 ON VV02.VV0_FILIAL = '"+cFilVV0+"'"
		iif ("MSSQL" $ cSGBD, cSQL += " AND VV02.VV0_NUMTRA = SUBSTRING(TSAITMP.VV0TMP,"+cVV0DTH+",10)",cSQL += " AND VV02.VV0_NUMTRA = SUBSTR(TSAITMP.VV0TMP,"+cVV0DTH+",10)")
		cSQL +=                                   " AND VV02.D_E_L_E_T_ = ' '"
		cSQL +=                   " JOIN "+cNamVVA+" VVA2 ON VVA2.VVA_FILIAL = '"+cFilVV0+"'"
		iif ("MSSQL" $ cSGBD, cSQL += " AND VVA2.VVA_NUMTRA = SUBSTRING(TSAITMP.VV0TMP,"+cVV0DTH+",10)",cSQL += " AND VVA2.VVA_NUMTRA = SUBSTR(TSAITMP.VV0TMP,"+cVV0DTH+",10)")
		cSQL +=                                  " AND VVA2.VVA_CHAINT = TSAITMP.CHAINT "
		cSQL +=                                  " AND VVA2.D_E_L_E_T_ = ' '"
		cSQL +=        " ) TSAIDA"
		cSQL += " ON TENTRADA.CHAINT = TSAIDA.CHAINT"
		// Filtro por Estado do Veiculo
		if mv_par05 == 1 		// Veiculos Novos
			cSQL += " WHERE TENTRADA.VVG_ESTVEI = '0'"
			// Filtro por Estado do Veiculo
		Elseif mv_par05 == 2	// Veiculos Usados
			cSQL += " WHERE TENTRADA.VVG_ESTVEI = '1'"
		endif
		
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cSQL), cAliasTMP, .T., .T. )
		
		cCHAINT := ""
		
		dbSelectArea(cAliasTMP)
		dbGoTop()
		
		while !Eof()
			
			If cCHAINT <> ALLTRIM((cAliasTMP)->CHAINT)
				cCHAINT := (cAliasTMP)->CHAINT
			Else
				dbSelectArea(cAliasTMP)
				dbSkip()
				Loop
			EndIf
			
			If !VV1->(dbSeek(cFilVV1+(cAliasTMP)->CHAINT))
				MsgAlert(STR0004+" '"+(cAliasTMP)->CHAINT+"' "+STR0005,STR0006) // ChaInt 'XXXXXX' não encontrado no Cadastro de Veículos! / Atencao
				dbSelectArea(cAliasTMP)
				dbSkip()
				Loop
			endif

			if VV1->VV1_ULTMOV == "S" .and. VV1->VV1_SITVEI $ "1;5"	// 0=Estoque;1=Vendido;2=Em Transito;3=Remessa;4=Consignado;5=Transferido;6=Reservado;7=Progresso;8=Pedido
				dbSelectArea(cAliasTMP)
				dbSkip()
				Loop
			endif
			
			// Controla o Status do veiculo ...
			cTRB_SITVEI := ""
			
			c_ptodep := "**"
			c_nfsda  := space(9)
			
			// Houve saida dentro do periodo
			IF !Empty((cAliasTMP)->VV0_NUMTRA)
				
				cHoraEnt := AllTrim(Right((cAliasTMP)->VVF_DTHEMI,Len((cAliasTMP)->VVF_DTHEMI)-9))
				cHoraSai := AllTrim(Right((cAliasTMP)->VV0_DTHEMI,Len((cAliasTMP)->VV0_DTHEMI)-9))
				
				// Verifica se a ultima transacao foi de entrada ou saida
				// Se for a mesma data, verifica pela hora da transacao
				// Se a ultima for de saida, deve verificar qual foi o tipo da movimentacao
				IF ( (cAliasTMP)->VVF_DATMOV == (cAliasTMP)->VV0_DATMOV .and. cHoraSai > cHoraEnt) ;
					.or. (cAliasTMP)->VV0_DATMOV > (cAliasTMP)->VVF_DATMOV
					
					// Se for Saida por Remessa ou Consignacao , verifica se é uma remessa em poder de terceiro
					IF (cAliasTMP)->VV0_OPEMOV $ "3,5"
						// Se não for uma TES de remessa com controle de 3º, veiculo nao esta mais no estoque
						cPoder3 := FM_SQL("SELECT F4_PODER3 FROM "+cNamSF4+" WHERE F4_FILIAL='"+cFilSF4+"' AND F4_CODIGO='"+(cAliasTMP)->VVA_CODTES+"' AND D_E_L_E_T_=' '")
						IF cPoder3 == "R"
							IF (cAliasTMP)->VV0_OPEMOV == "3"
								cTRB_SITVEI = "7" // Remessa de Propria em Poder de Terceiro
							ELSEIF  (cAliasTMP)->VV0_OPEMOV == "5"
								cTRB_SITVEI = "4" // Consignado
							ENDIF
						ELSE
							// Veiculo não esta no estoque
							dbSelectArea(cAliasTMP)
							dbSkip()
							Loop
						ENDIF
						// Veiculo não esta no estoque
					ELSE
						dbSelectArea(cAliasTMP)
						dbSkip()
						Loop
					ENDIF
				else
					// Levantamento da SD3, transformar em função e corrigir a query para pegar o ultimo registro.
					if (mv_par06 == 1 .or. mv_par06 == 3)
						if !FS_LEVSD3VEI((cAliasTMP)->CHAINT,(cAliasTMP)->VVF_DATMOV)
							dbSelectArea(cAliasTMP)
							dbSkip()
							Loop
						Endif
					Endif
				ENDIF
			Else
				// Levantamento da SD3
				if (mv_par06 == 1 .or. mv_par06 == 3)
					if !FS_LEVSD3VEI((cAliasTMP)->CHAINT,(cAliasTMP)->VVF_DATMOV)
						dbSelectArea(cAliasTMP)
						dbSkip()
						Loop
					Endif
				Endif
			Endif
			// Se nao tiver em branco, se trata de uma remessa propria para terceiros e ja foi encontrado o STATUS do veiculo
			IF Empty(cTRB_SITVEI)
				
				// Mov. de Entrada Normal, Devolucao, Retorno de Remessa ou Retorno de Consig.
				if (cAliasTMP)->VVF_OPEMOV $ "0,5"
					cTRB_SITVEI := "0" // Estoque
					
					// Mov. de Entrada por Remessa ou Consignacao
				elseif (cAliasTMP)->VVF_OPEMOV $ "2,4"
					// Verifica se a TES é uma [R]emessa de poder de Terceiros
					cPoder3 := FM_SQL("SELECT F4_PODER3 FROM "+cNamSF4+" WHERE F4_FILIAL='"+cFilSF4+"' AND F4_CODIGO='"+(cAliasTMP)->VVG_CODTES+"' AND D_E_L_E_T_=' '")
					IF cPoder3 == "R"
						IF (cAliasTMP)->VVF_OPEMOV == "2"
							cTRB_SITVEI := "3" // Remessa de Terceiro em Nosso Poder
						ELSEIF (cAliasTMP)->VVF_OPEMOV == "4"
							cTRB_SITVEI := "4" // Consignado
						ENDIF
					ENDIF
					
					// Mov. de Entrada por Transferencia
				elseif (cAliasTMP)->VVF_OPEMOV == "3"
					cTRB_SITVEI := "5" // Transferido
					
					// Mov. de Entrada por Retorno de Remessa e Retorno de Consignacao
				elseif (cAliasTMP)->VVF_OPEMOV $ "7,8"
					// Verifica se a TES é uma [D]emessa de poder de Terceiros
					cPoder3 := FM_SQL("SELECT F4_PODER3 FROM "+cNamSF4+" WHERE F4_FILIAL='"+cFilSF4+"' AND F4_CODIGO='"+(cAliasTMP)->VVG_CODTES+"' AND D_E_L_E_T_=' '")
					IF cPoder3 == "D"
						cTRB_SITVEI := "0" // Estoque
					Else
						DBSelectArea("SB1")
						DBSetOrder(7)
						MsSeek(cFilSB1+cGruVei+VV1->VV1_CHAINT)
						iif (FM_SQL("SELECT R_E_C_N_O_ FROM "+cNamSB2+" WHERE B2_FILIAL='"+cFilSB2+"' AND B2_COD='"+SB1->B1_COD+"' AND B2_QATU>0  AND D_E_L_E_T_=' '") > 0,cTRB_SITVEI := "0" ,)// Estoque
					ENDIF
				endif
				//				
			ENDIF
			
			// Veiculo nao esta no estoque
			if Empty(cTRB_SITVEI)
				dbSelectArea(cAliasTMP)
				dbSkip()
				Loop
			endif
			
			VVF->(MsSeek(cFilVVF+(cAliasTMP)->VVF_TRACPA))
			VVG->(MsSeek(cFilVVF+(cAliasTMP)->VVF_TRACPA+VV1->VV1_CHAINT))
			VV2->(MsSeek(cFilVV2+VV1->VV1_CODMAR+VV1->VV1_MODVEI))
			
			nValTab := 0
			iif ("ORACLE" $ cSGBD, cSQL := "SELECT * FROM ( SELECT VVP_VALTAB ", cSQL := "SELECT TOP 1 VVP_VALTAB ")
			cSQL += " FROM "+cNamVVP+" VVP"
			cSQL += " WHERE "
			cSQL += "VVP.VVP_FILIAL='"+cFilVVP+"' AND"
			cSQL += " VVP.VVP_CODMAR = '"+VV1->VV1_CODMAR+"'"
			cSQL += " AND VVP.VVP_MODVEI = '"+VV1->VV1_MODVEI+"'"
			cSQL += " AND VVP.VVP_SEGMOD = '"+VV2->VV2_SEGMOD+"'"
			cSQL += " AND VVP.VVP_DATPRC >= '" + DtoS(MV_PAR04) + "'"
			cSQL += " AND VVP.D_E_L_E_T_ = ' '"
			cSQL += " ORDER BY VVP_DATPRC"
			iif ("ORACLE" $ cSGBD,cSQL += " ) WHERE ROWNUM <= 1","")
			dbUseArea( .T., "TOPCONN", TcGenQry(,,cSQL), "TVALTAB", .T., .T. )
			iIF (!TVALTAB->(Eof()),nValtab := TVALTAB->VVP_VALTAB,)
			TVALTAB->(dbCloseArea())
			
			cTipFat := VVG->VVG_ESTVEI
						
			if VVF->VVF_CLIFOR = "F"
				cFornece := FM_SQL("SELECT A2_NOME FROM "+cNamSA2+" WHERE A2_FILIAL='"+cFilSA2+"' AND A2_COD='"+VVF->VVF_CODFOR+"' AND A2_LOJA='"+VVF->VVF_LOJA+"' AND D_E_L_E_T_=' '")
			else
				cFornece := FM_SQL("SELECT A1_NOME FROM "+cNamSA1+" WHERE A1_FILIAL='"+cFilSA1+"' AND A1_COD='"+VVF->VVF_CODFOR+"' AND A1_LOJA='"+VVF->VVF_LOJA+"' AND D_E_L_E_T_=' '")			
			endif
			
			FGX_VV1SB1("CHAINT", VV1->VV1_CHAINT , /* cMVMIL0010 */ , cGruVei )
			
			DBSelectArea("SB2")
			DBSetOrder(1)
			MsSeek(cFilSB2+SB1->B1_COD+VV1->VV1_LOCPAD)
			
			DbSelectArea("TRB")
			RecLock("TRB",.t.)
			TRB_FILIAL  := VV1->VV1_FILENT
			TRB_FILENT  := VVF->VVF_FILIAL
			TRB_TIPOVV  := VVG->VVG_ESTVEI
			TRB_TIPOVD  := IIF(VVG->VVG_ESTVEI=="0","N","U")
			TRB_PROVVV  := if(left(VV1->VV1_PROVEI,1)$"0,3,4,5,8","0","1") //0-nacional, 1-importado
			TRB_PROVVD  := if(left(VV1->VV1_PROVEI,1)$"0,3,4,5,8","Nac.","Imp.") //0-nacional, 1-importado
			TRB_DIAEST  := iif( empty( VVF->VVF_DATMOV ), 0, mv_par04 - VVF->VVF_DATMOV )
			TRB_NUMNFI  := VVF->VVF_NUMNFI
			TRB_DATEMI  := VVF->VVF_DATEMI
			TRB_FORNEC  := cFornece
			TRB_DTDIGI  := VVF->VVF_DATMOV
			TRB_MODELO  := VV1->VV1_CODMAR+" "+Left(VV2->VV2_DESMOD,20)
			TRB_MARMOD  := VV1->VV1_CODMAR+" "+left(VV1->VV1_MODVEI,10)+"-"+Left(VV2->VV2_DESMOD,10)
			TRB_CHASSI  := VV1->VV1_CHASSI
			TRB_CORVEI  := left(FM_SQL("SELECT VVC_DESCRI FROM "+cNamVVC+" WHERE VVC_FILIAL='"+cFilVVC+"' AND VVC_CODMAR='"+VV1->VV1_CODMAR+"' AND VVC_CORVEI='"+VV1->VV1_CORVEI+"' AND D_E_L_E_T_=' '"),10)
			TRB_VALNFI  := VVG->VVG_VALUNI+iif(cPaisLoc=="BRA",VVG->VVG_VALIPI,0)+VVG->VVG_TOTSEG+VVG->VVG_TOTFRE+iif(cPaisLoc=="BRA",VVG->VVG_ICMRET,0)   
			TRB_PICRET  := iif(cPaisLoc=="BRA",VVG->VVG_PISENT,0)+VVG->VVG_COFENT      
			TRB_VALFRE  := VVG->VVG_VALFRE
			TRB_VALTAB  := nValTab
			TRB_CODIND  := VVG->VVG_CODIND
			TRB_DESIND  := FM_SQL("SELECT VVH_DESCRI FROM "+cNamVVH+" WHERE VVH_FILIAL='"+cFilVVH+"' AND VVH_CODIND='"+VVG->VVG_CODIND+"' AND D_E_L_E_T_=' '")
			TRB_TIPFAT  := cTipFat			
			TRB_CUSTOV := SB2->B2_CM1
			TRB_CUSATU := FG_CusVei(VV1->VV1_TRACPA,VV1->VV1_CHAINT,VVF->VVF_DATMOV,dDataBase)+FG_JurEst(VV1->VV1_TRACPA,VV1->VV1_CHAINT,VVF->VVF_DATMOV,dDataBase,"V")
			cDescrSit  := Alltrim(X3CBOXDESC("VV1_SITVEI", cTRB_SITVEI ))

			TRB_SITVEI := cTRB_SITVEI
			TRB_DESSIT := cDescrSit
			TRB_PLAVEI := VV1->VV1_PLAVEI
			TRB_MODVEI := VV1->VV1_MODVEI
			TRB_ANOMOD := VV1->VV1_FABMOD
			TRB_POSIPI := VV1->VV1_POSIPI
			TRB_DISEIX := VV1->VV1_DISEIX
			TRB_DEPTO  := c_ptodep
			TRB_NFSAI  := c_NFSda
			MsUnlock()
			nTotCUSCo  += SB2->B2_CM1
			DbSelectArea(cAliasTMP)
			DbSkip()
			
		Enddo
		
		(cAliasTMP)->(dbCloseArea())
		
	Next
	
Endif

cFilAnt := cFilBkp

DbSelectArea("TRB")
DbSetOrder(1)
DbGoTop()

//exibe um diálogo onde a execução de um processo pode ser monitorada através da régua de progressão.                
Processa({|| oReport := ReportDef(cPerg), oReport:PrintDialog()},STR0047) //"Imprmindo dados..."
return                           

Static function printReport()
local oSection := oReport:section(1)
oSection:init()   
dbSelectArea("TRB")
dbSetOrder(1)
oReport:setMeter(RecCount())
dbGoTop()
//percorre a tabela temporária e 'seta' os valores nas respectivas colunas
while !Eof()
	oSection:cell("TRB_TIPOVD"):setValue(TRB_TIPOVD)
	oSection:cell("TRB_PROVVV"):setValue(TRB_PROVVV)
	oSection:cell("TRB_PROVVD"):setValue(TRB_PROVVD)
	oSection:cell("TRB_DIAEST"):setValue(TRB_DIAEST)
	oSection:cell("TRB_FILIAL"):setValue(TRB_FILIAL)
	oSection:cell("TRB_FILENT"):setValue(TRB_FILENT)
	oSection:cell("TRB_NUMNFI"):setValue(TRB_NUMNFI)
	oSection:cell("TRB_DTDIGI"):setValue(TRB_DTDIGI)
	oSection:cell("TRB_DATEMI"):setValue(TRB_DATEMI)
	oSection:cell("TRB_FORNEC"):setValue(TRB_FORNEC)
	oSection:cell("TRB_MARMOD"):setValue(TRB_MARMOD)
	oSection:cell("TRB_ANOMOD"):setValue(TRB_ANOMOD)
	oSection:cell("TRB_CHASSI"):setValue(TRB_CHASSI)
	oSection:cell("TRB_CORVEI"):setValue(TRB_CORVEI)
	oSection:cell("TRB_VALNFI"):setValue(TRB_VALNFI)
	oSection:cell("TRB_VALFRE"):setValue(TRB_VALFRE)
	oSection:cell("TRB_CUSTOV"):setValue(TRB_CUSTOV)
	oSection:cell("TRB_CUSATU"):setValue(TRB_CUSATU)
	oSection:cell("TRB_CODIND"):setValue(TRB_CODIND)
	oSection:cell("TRB_DESIND"):setValue(TRB_DESIND)
	oSection:cell("TRB_SITVEI"):setValue(TRB_SITVEI)
	oSection:cell("TRB_DESSIT"):setValue(TRB_DESSIT)
	oSection:cell("TRB_PLAVEI"):setValue(TRB_PLAVEI)
	oSection:cell("TRB_POSIPI"):setValue(TRB_POSIPI)
	oSection:cell("TRB_DISEIX"):setValue(TRB_DISEIX)
	oSection:printLine()
	oReport:incMeter()
	dbSkip()
Enddo
oSection:finish()
return 

Static Function FS_LEVSD3VEI(cCodVei,cDatMov)

	Local cTamGruVei:= Alltrim(Str(TamSx3("B1_GRUPO")[1]+2))
	Local cTamChaInt:= Alltrim(Str(TamSX3("VV1_CHAINT")[1]))
	Local cAliasD3 := "TMOVD3"
	Local cSQLD3 := ""
	Local lVeiVend := .t.

	Default cCodVei := ""
	Default cDatMov := ""

	cSQLD3 := "SELECT SD3.D3_NUMSEQ NUMSEQ, SD3.D3_TM, SD3.D3_EMISSAO "
	cSQLD3 += " FROM "+RetSQLName("SD3")+" SD3 "
	cSQLD3 += " WHERE SD3.D3_FILIAL = '"+xFilial("SD3")+"' "
	cSQLD3 += " AND SD3.D3_GRUPO = '"+cGruVei+"' "
	cSQLD3 += " AND " + oVR020SQL:CompatFunc("SUBSTR") + "(SD3.D3_COD,"+cTamGruVei+","+cTamChaInt+") = '"+cCodVei+"'"
	cSQLD3 += " AND SD3.D3_EMISSAO <= '"+DtoS(mv_par04)+"' "
	cSQLD3 += " AND SD3.D_E_L_E_T_=' ' "
	cSQLD3 += " ORDER BY 1 DESC "

	cSQLD3 := oVR020SQL:TOPFunc(cSQLD3,1)

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cSQLD3), cAliasD3, .T., .T. )

	IF !(cAliasD3)->(Eof())
		if (cAliasD3)->D3_TM >= '500' .and. (cAliasD3)->D3_EMISSAO >= cDatMov
			lVeiVend := .f.
		Endif
	Endif

	(cAliasD3)->(dbCloseArea())

return lVeiVend
