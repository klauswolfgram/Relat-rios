/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 14     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#Include "OFIOR170.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIOR170 ³ Autor ³  Caio Cesar           ³ Data ³ 22/07/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Analise diaria da Oficina                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ (Veiculos)                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR170

PRIVATE aReturn  := { OemToAnsi(STR0001), 1,OemToAnsi(STR0002), 2, 2, 2,,1 } //"Vendedor"###"Nome"
Private cAlias ,cNomRel , cPerg , cTitulo, cDesc1, cDesc2 , cDesc3, aOrdem , lHabil := .f. , wnRel , NomeRel
Private aErro := {}
Private aPassagem := {}
Private nCli := 0
Private nDesloc := 0
Private nGaran := 0
Private nInter := 0
Private nPassou := 0

Private aNumOs := {} // Vetor que grava OS com mesma data de abertura e mesmo chassi.
Private aNum := {}

Private cAliasVO1 := "SQLVO1"
Private cAliasVO4 := "SQLVO4"
Private cAliasVV1 := "SQLVV1"
Private cAliasVV2 := "SQLVV2"
Private cAliasVOI := "SQLVOI"
Private cAliasVOK := "SQLVOK"
Private cAliasVSC := "SQLVSC"
Private cAliasVEC := "SQLVEC" 
Private cAliasSD1 := "SQLSD1" 
Private cQuery    := ""

cAlias  := "VSC"
cNomRel := "OFIOR170"
cPerg   := "OFR170"
cTitulo := STR0003 //"Analise diaria da Oficina"
cDesc1  := STR0003 //"Analise diaria da Oficina"
cDesc2  := cDesc3 := ""
aOrdem  := {STR0004,STR0005} //"Nosso Numero"###"Codigo do Item"
lHabil  := .f.
wnRel   := ""
cTamanho:= "G"
Limite  := 220
ValidPerg()

NomeRel:= SetPrint(cAlias,cNomRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lHabil,,,cTamanho)

If nlastkey == 27
	Return
EndIf

Pergunte("OFR170",.f.)

SetDefault(aReturn,cAlias)

RptStatus( { |lEnd| FS_IMPOR170(@lEnd,wnRel,'VSC') } , cTitulo )

If aReturn[5] == 1
	
	OurSpool( cNomRel )
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_IMPOR17ºAutor  ³Caio                º Data ³  22/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime relatorio                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPOR170()

Local bLinha := {|nSoma| FS_LINHA( nSoma ) }
Local aVetCampos := {} , cNumOsv , cXString := ""
Local cArqTra , cArqInd1 , cArqInd2 , cArqInd3 , nBarra := 0 , nCol := 0, ix1 := 0
Local cSomaPass := "", cSitTpo := ""
Local aVetADO   := {}
Local aVet := {}
Local nPec := 0
Local nSrc := 0

Private nLin := 1


Set Printer to &NomeRel
Set Printer On
Set device to Printer

&& Cria Arquivo de Trabalho
aAdd(aVetCampos,{ "TRB_DATVEN" , "D" , 8  , 0 })  && Data da venda
aAdd(aVetCampos,{ "TRB_NUMOSV" , "C" , 8  , 0 })  && Nro Os
aAdd(aVetCampos,{ "TRB_TTOTAL" , "C" , 1  , 0 })  && Tipo de Total
aAdd(aVetCampos,{ "TRB_SITTPO" , "C" , 1  , 0 })  && Sit. Tipo de tempo
aAdd(aVetCampos,{ "TRB_ADO345" , "N" , 12 , 2 })  && ADO Tipo de OS
aAdd(aVetCampos,{ "TRB_ADO06"  , "N" , 12 , 2 })  && ADO 06
aAdd(aVetCampos,{ "TRB_ADO07"  , "N" , 12 , 2 })  && ADO 07
aAdd(aVetCampos,{ "TRB_ADO08"  , "N" , 12 , 2 })  && ADO 08
aAdd(aVetCampos,{ "TRB_ADO09"  , "N" , 12 , 2 })  && ADO 09
aAdd(aVetCampos,{ "TRB_ADO10"  , "N" , 12 , 2 })  && ADO 10
aAdd(aVetCampos,{ "TRB_ADO11"  , "N" , 12 , 2 })  && ADO 11
aAdd(aVetCampos,{ "TRB_ADO12"  , "N" , 12 , 2 })  && ADO 12
aAdd(aVetCampos,{ "TRB_ADO13"  , "N" , 12 , 2 })  && ADO 13
aAdd(aVetCampos,{ "TRB_ADO14"  , "N" , 12 , 2 })  && ADO 14
aAdd(aVetCampos,{ "TRB_ADO15"  , "N" , 12 , 2 })  && ADO 15
aAdd(aVetCampos,{ "TRB_ADO16"  , "N" , 12 , 2 })  && ADO 16
aAdd(aVetCampos,{ "TRB_ADO17"  , "N" , 12 , 2 })  && ADO 17
aAdd(aVetCampos,{ "TRB_ADO18"  , "N" , 12 , 2 })  && ADO 18
aAdd(aVetCampos,{ "TRB_ADO19"  , "N" , 12 , 2 })  && ADO 19
aAdd(aVetCampos,{ "TRB_ADO20"  , "N" , 12 , 2 })  && ADO 20
aAdd(aVetCampos,{ "TRB_ADO21"  , "N" , 12 , 2 })  && ADO 21
aAdd(aVetCampos,{ "TRB_ADO22"  , "N" , 12 , 2 })  && ADO 22
aAdd(aVetCampos,{ "TRB_ADO23"  , "N" , 12 , 2 })  && ADO 23
aAdd(aVetCampos,{ "TRB_ADO24"  , "N" , 12 , 2 })  && ADO 24
aAdd(aVetCampos,{ "TRB_ADO25"  , "N" , 12 , 2 })  && ADO 25
aAdd(aVetCampos,{ "TRB_ADO26"  , "N" , 12 , 2 })  && ADO 26
aAdd(aVetCampos,{ "TRB_ADO27"  , "N" , 12 , 2 })  && ADO 27
aAdd(aVetCampos,{ "TRB_DESLO"  , "N" , 12 , 2 })  && Deslocamento venda material
aAdd(aVetCampos,{ "TRB_MBRDL"  , "N" , 12 , 2 })  && Deslocamento mao de obra deslocamento
aAdd(aVetCampos,{ "TRB_TERCE"  , "C" , 1 , 0 })  //Servico de Terceiro
aAdd(aVetCampos,{ "TRB_TPSER"  , "C" , 3 , 0 })  //Tipo de Servico
aAdd(aVetCampos,{ "TRB_VALPEC" , "N" ,12 , 2 })  //Valor da peca
aAdd(aVetCampos,{ "TRB_CHAINT" , "C" ,25 , 0 })  //Chassi

cArqInd1 := CriaTrab(NIL, .F.)
cArqInd2 := CriaTrab(NIL, .F.)
cArqInd3 := CriaTrab(NIL, .F.)
oObjTempTable := OFDMSTempTable():New()
oObjTempTable:cAlias := "TRB"
oObjTempTable:aVetCampos := aVetCampos
oObjTempTable:AddIndex(cArqInd1, {"TRB_DATVEN","TRB_TTOTAL","TRB_NUMOSV","TRB_SITTPO"} )
oObjTempTable:AddIndex(cArqInd2, {"TRB_DATVEN","TRB_TTOTAL","TRB_SITTPO"} )
oObjTempTable:AddIndex(cArqInd3, {"TRB_TTOTAL","TRB_SITTPO"} )
oObjTempTable:CreateTable()

SetRegua( nBarra )

&& Servicos
&& Levantamento dos dados

If Select(cAliasVSC) > 0
	( cAliasVSC )->( DbCloseArea() )
EndIf
cQuery := "SELECT VSC.VSC_DATVEN, VSC.VSC_NUMOSV, VSC.VSC_TIPTEM, VSC.VSC_CODSEC, VSC.VSC_RECVO4, VSC.VSC_VALSER, VSC.VSC_TIPSER, VSC.VSC_NUMNFI, VSC.VSC_SERNFI "
cQuery += "FROM "+RetSqlName( "VSC" ) + " VSC "
cQuery += "WHERE "
cQuery += "VSC.VSC_FILIAL='"+ xFilial("VSC")+ "' AND VSC.VSC_DATVEN >= '"+dtos(MV_PAR11)+"' AND VSC.VSC_DATVEN <= '"+dtos(MV_PAR12)+"' AND "
cQuery += "VSC.D_E_L_E_T_=' ' "
cQuery += "Order By VSC_DATVEN, VSC_TIPSER, VSC_CODSER"

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVSC, .T., .T. )

aadd(aNumOS,{"","",""})

Do While !(cAliasVSC)->(Eof())
	
	
	// filtragem que separa caminhoes e onibus <-- Luis

	If Select(cAliasVO1) > 0
		( cAliasVO1 )->( DbCloseArea() )
	EndIf             
	
	cQuery := "SELECT VO1.VO1_CHAINT, VO1.VO1_CONSUL, VO1.VO1_DATABE, VO1.VO1_CHASSI, VO1.VO1_NUMOSV, VO1.VO1_KILOME "
	If VO1->(FieldPos("VO1_CONSUL")) == 0
		cQuery := "SELECT VO1.VO1_CHAINT, VO1.VO1_DATABE, VO1.VO1_CHASSI, VO1.VO1_NUMOSV, VO1.VO1_KILOME "
	EndIf
	cQuery += "FROM "+RetSqlName( "VO1" ) + " VO1 "
	cQuery += "WHERE "
	cQuery += "VO1.VO1_FILIAL='"+ xFilial("VO1")+ "' AND VO1.VO1_NUMOSV = '"+(cAliasVSC)->VSC_NUMOSV+"' AND "
	cQuery += "VO1.D_E_L_E_T_=' ' "
	cQuery += "Order By VO1_NUMOSV"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO1, .T., .T. )
	
	If Select(cAliasVV1) > 0
		( cAliasVV1 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VV1.VV1_CODMAR, VV1.VV1_MODVEI "
	cQuery += "FROM "+RetSqlName( "VV1" ) + " VV1 "
	cQuery += "WHERE "
	cQuery += "VV1.VV1_FILIAL='"+ xFilial("VV1")+ "' AND VV1.VV1_CHAINT = '"+(cAliasVO1)->VO1_CHAINT+"' AND "
	cQuery += "VV1.D_E_L_E_T_=' ' "
	cQuery += "Order By VV1_CHAINT"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV1, .T., .T. )
	
	If Select(cAliasVV2) > 0
		( cAliasVV2 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VV2.VV2_TIPVEI "
	cQuery += "FROM "+RetSqlName( "VV2" ) + " VV2 "
	cQuery += "WHERE "
	cQuery += "VV2.VV2_FILIAL='"+ xFilial("VV2") + "' AND VV2.VV2_CODMAR = '"+(cAliasVV1)->VV1_CODMAR+"' AND VV2.VV2_MODVEI = '"+(cAliasVV1)->VV1_MODVEI+"' AND "
	cQuery += "VV2.D_E_L_E_T_=' ' "
	cQuery += "Order By VV2_CODMAR,VV2_MODVEI"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV2, .T., .T. )
	
	if !Empty(mv_par20)
		if !((cAliasVV1)->VV1_CODMAR $ mv_par20)
			dbSelectArea(cAliasVSC)
			dbSkip()
			Loop
		Endif
	Endif
	
	lCaminhao := .f.
	lOnibus   := .f.
	lOutro    := .f.
	
	if ( cAliasVV2 )->VV2_TIPVEI $ mv_par15
		lCaminhao := .t.
	elseif  ( cAliasVV2 )->VV2_TIPVEI $ mv_par16
		lOnibus   := .t.
	elseif ( cAliasVV2 )->VV2_TIPVEI $ mv_par17
		lPasseio  := .t.
	else
		aAdd(aErro, STR0061 +( cAliasVO1 )->VO1_CHAINT+ STR0062 +( cAliasVV2 )->VV2_TIPVEI )  // "O veiculo"###" possui tipo de modelo nao cadastrado :"
	endif
	
	if (mv_par14 == 3  .and. !lCaminhao) .or. (mv_par14 == 4  .and. !lOnibus)
		DBSelectArea(cAliasVSC)
		dbSkip()
		Loop
	endif
	
	DBSelectArea(cAliasVSC)
	
	&& Servico de terceiro
	
	If Select(cAliasVOK) > 0
		( cAliasVOK )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VOK.VOK_INCMOB "
	cQuery += "FROM "+RetSqlName( "VOK" ) + " VOK "
	cQuery += "WHERE "
	cQuery += "VOK.VOK_FILIAL='"+ xFilial("VOK") + "' AND VOK.VOK_TIPSER = '"+(cAliasVSC)->VSC_TIPSER+"' AND "
	cQuery += "VOK.D_E_L_E_T_=' ' "
	cQuery += "Order By VOK_TIPSER"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVOK, .T., .T. )
	
	If (cAliasVSC)->VSC_CODSEC $ mv_par01 ;
		.Or. (cAliasVSC)->VSC_CODSEC $ mv_par02 ;
		.Or. (cAliasVSC)->VSC_CODSEC $ mv_par03 ;
		.Or. (cAliasVSC)->VSC_CODSEC $ mv_par04 ;
		.Or. (cAliasVSC)->VSC_CODSEC $ mv_par05 ;
		.Or. (cAliasVOK)->VOK_INCMOB == "2" ;
		.Or. (cAliasVSC)->VSC_CODSEC $ mv_par06;
		.Or. (cAliasVSC)->VSC_CODSEC $ mv_par07;
		.Or. (cAliasVSC)->VSC_TIPSER $ mv_par19
		
		If Select(cAliasVOI) > 0
			( cAliasVOI )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VOI.VOI_SITTPO "
		cQuery += "FROM "+RetSqlName( "VOI" ) + " VOI "
		cQuery += "WHERE "
		cQuery += "VOI.VOI_FILIAL='"+ xFilial("VOI") + "' AND VOI.VOI_TIPTEM = '"+(cAliasVSC)->VSC_TIPTEM+"' AND "
		cQuery += "VOI.D_E_L_E_T_=' ' "
		cQuery += "Order By VOI_TIPTEM"
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVOI, .T., .T. )
		
		if ( cAliasVOI )->VOI_SITTPO = "3" .AND. ( (cAliasVO1)->(FieldPos("VO1_CONSUL"))==0 .Or. ( cAliasVO1 )->VO1_CONSUL # mv_par18 )
			
			DBSelectArea("VO4")
			DBGoto(val((cAliasVSC)->VSC_RECVO4))
			
			FS_GRATRAB( Stod( (cAliasVSC)->VSC_DATVEN ) , (cAliasVSC)->VSC_TIPTEM , (cAliasVSC)->VSC_NUMOSV , (cAliasVSC)->VSC_CODSEC , VO4->VO4_VALINT , "S"  , ( cSomaPass # (cAliasVSC)->VSC_NUMOSV + (cAliasVSC)->VSC_CODSEC ), (cAliasVSC)->VSC_TIPSER , ( cAliasVO1 )->VO1_CHAINT)
			
			nPos := aScan(aPassagem,{|x| x[1] + x[2] == ( cAliasVO1 )->VO1_DATABE + ( cAliasVO1 )->VO1_CHASSI})
			If nPos == 0
				aadd(aPassagem,{( cAliasVO1 )->VO1_DATABE,( cAliasVO1 )->VO1_CHASSI,( cAliasVO1 )->VO1_NUMOSV})
				nInter++
				
				nPassou++
			Else
				nPos3 := aScan(aNum,{|x| x[1] == (cAliasVSC)->VSC_NUMOSV})
				If nPos3 == 0
					aadd(aNum,{(cAliasVSC)->VSC_NUMOSV})
					nPos2 := Len(aNumOs)
					If aNumOs[nPos2,1] # ( cAliasVO1 )->VO1_NUMOSV .AND. aPassagem[nPos,3] # ( cAliasVO1 )->VO1_NUMOSV
						aadd(aNumOs,{( cAliasVO1 )->VO1_NUMOSV,dToc(Stod(( cAliasVO1 )->VO1_DATABE)),dToc(Stod((cAliasVSC)->VSC_DATVEN)),( cAliasVO1 )->VO1_CHASSI,Transform(( cAliasVO1 )->VO1_KILOME,"@E 99,999,999")})
					EndIf
				EndIf
			EndIf
			
			DbSelectArea(cAliasVO1)
			DbSkip()
			
		elseif ( (cAliasVO1)->(FieldPos("VO1_CONSUL"))==0 .Or. ( cAliasVO1 )->VO1_CONSUL # mv_par18 )
			
			&& Grava arquivo de trabalho
			FS_GRATRAB( Stod((cAliasVSC)->VSC_DATVEN) , (cAliasVSC)->VSC_TIPTEM , (cAliasVSC)->VSC_NUMOSV , (cAliasVSC)->VSC_CODSEC , (cAliasVSC)->VSC_VALSER , "S"  , ( cSomaPass # (cAliasVSC)->VSC_NUMOSV + (cAliasVSC)->VSC_CODSEC ), (cAliasVSC)->VSC_TIPSER, ( cAliasVO1 )->VO1_CHAINT  )
			
			DbSelectArea(cAliasVO1)
			nPos := aScan(aPassagem,{|x| x[1] + x[2] == ( cAliasVO1 )->VO1_DATABE + ( cAliasVO1 )->VO1_CHASSI})
			If nPos == 0
				aadd(aPassagem,{( cAliasVO1 )->VO1_DATABE,( cAliasVO1 )->VO1_CHASSI,( cAliasVO1 )->VO1_NUMOSV})
				if (cAliasVSC)->VSC_TIPSER $ MV_PAR19
					nDesloc++
				Elseif ( cAliasVOI )->VOI_SITTPO = "1"
					nCli++
					
				ElseIf ( cAliasVOI )->VOI_SITTPO = "2"
					nGaran++
					
				ElseIf ( cAliasVOI )->VOI_SITTPO = "3"
					nInter++
					
				EndIf
				nPassou++
			Else
				nPos3 := aScan(aNum,{|x| x[1] == (cAliasVSC)->VSC_NUMOSV})
				If nPos3 == 0
					aadd(aNum,{(cAliasVSC)->VSC_NUMOSV})
					nPos2 := Len(aNumOs)
					If aNumOs[nPos2,1] # ( cAliasVO1 )->VO1_NUMOSV .AND. aPassagem[nPos,3] # ( cAliasVO1 )->VO1_NUMOSV
						aadd(aNumOs,{( cAliasVO1 )->VO1_NUMOSV,dToc(Stod(( cAliasVO1 )->VO1_DATABE)),dToc(Stod((cAliasVSC)->VSC_DATVEN)),( cAliasVO1 )->VO1_CHASSI,Transform(( cAliasVO1 )->VO1_KILOME,"@E 99,999,999")})
					EndIf
				EndIf
			EndIf
			
		Endif
	EndIf
	
	cSomaPass := (cAliasVSC)->VSC_CODSEC + (cAliasVSC)->VSC_NUMOSV
	
	IncRegua()
	
	DbSelectArea(cAliasVSC)
	DbSkip()
	
EndDo

&& Pecas
&& Levantamento dos dados

If Select(cAliasVEC) > 0
	( cAliasVEC )->( DbCloseArea() )
EndIf
cQuery := "SELECT VEC.VEC_BALOFI,VEC.VEC_NUMOSV,VEC.VEC_GRUITE,VEC.VEC_CODITE,VEC.VEC_DATVEN,VEC.VEC_TIPTEM,VEC.VEC_VALVDA,VEC.VEC_DESACE,VEC.VEC_VALSEG,VEC.VEC_VALFRE,VEC.VEC_VALIPI,VEC.VEC_ICMSRT,VEC.VEC_NUMNFI,VEC.VEC_SERNFI "
cQuery += "FROM "+RetSqlName( "VEC" ) + " VEC "
cQuery += "WHERE "
cQuery += "VEC.VEC_FILIAL='"+ xFilial("VEC")+ "' AND VEC.VEC_DATVEN >= '"+dtos(MV_PAR11)+"' AND VEC.VEC_DATVEN <= '"+dtos(MV_PAR12)+"' AND "
cQuery += "VEC.D_E_L_E_T_=' ' "
cQuery += "Order By VEC_DATVEN, VEC_GRUITE, VEC_CODITE"

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVEC, .T., .T. )

Do While !(cAliasVEC)->(Eof())
	
	If (cAliasVEC)->VEC_BALOFI == "B"
		dbSkip()
		Loop
	EndIf
	
	// filtragem que separa caminhoes e onibus <-- Luis
	
	If Select(cAliasVO1) > 0
		( cAliasVO1 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VO1.VO1_CHAINT, VO1.VO1_CONSUL, VO1.VO1_DATABE, VO1.VO1_CHASSI, VO1.VO1_NUMOSV, VO1.VO1_KILOME , VO1.VO1_PROVEI , VO1.VO1_LOJPRO "
	If VO1->(FieldPos("VO1_CONSUL")) == 0
		cQuery := "SELECT VO1.VO1_CHAINT, VO1.VO1_DATABE, VO1.VO1_CHASSI, VO1.VO1_NUMOSV, VO1.VO1_KILOME , VO1.VO1_PROVEI , VO1.VO1_LOJPRO "
	EndIf
	cQuery += "FROM "+RetSqlName( "VO1" ) + " VO1 "
	cQuery += "WHERE "
	cQuery += "VO1.VO1_FILIAL='"+ xFilial("VO1")+ "' AND VO1.VO1_NUMOSV = '"+(cAliasVEC)->VEC_NUMOSV+"' AND "
	cQuery += "VO1.D_E_L_E_T_=' ' "
	cQuery += "Order By VO1_NUMOSV"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO1, .T., .T. )
	
	If Select(cAliasVV1) > 0
		( cAliasVV1 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VV1.VV1_CODMAR, VV1.VV1_MODVEI "
	cQuery += "FROM "+RetSqlName( "VV1" ) + " VV1 "
	cQuery += "WHERE "
	cQuery += "VV1.VV1_FILIAL='"+ xFilial("VV1")+ "' AND VV1.VV1_CHAINT = '"+(cAliasVO1)->VO1_CHAINT+"' AND "
	cQuery += "VV1.D_E_L_E_T_=' ' "
	cQuery += "Order By VV1_CHAINT"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV1, .T., .T. )
	
	If Select(cAliasVV2) > 0
		( cAliasVV2 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VV2.VV2_TIPVEI "
	cQuery += "FROM "+RetSqlName( "VV2" ) + " VV2 "
	cQuery += "WHERE "
	cQuery += "VV2.VV2_FILIAL='"+ xFilial("VV2") + "' AND VV2.VV2_CODMAR = '"+(cAliasVV1)->VV1_CODMAR+"' AND VV2.VV2_MODVEI = '"+(cAliasVV1)->VV1_MODVEI+"' AND "
	cQuery += "VV2.D_E_L_E_T_=' ' "
	cQuery += "Order By VV2_CODMAR,VV2_MODVEI"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV2, .T., .T. )
	
	
	lCaminhao := .f.
	lOnibus   := .f.
	lOutro    := .f.
	lPasseio  := .f.
	if ( cAliasVV2 )->VV2_TIPVEI $ mv_par15
		lCaminhao := .t.
	elseif ( cAliasVV2 )->VV2_TIPVEI $ mv_par16
		lOnibus   := .t.
	else
		lPasseio  := .t.
	endif
	
	if (mv_par14 == 1  .and. !lPasseio).or. (mv_par14 == 2  .and. !(lonibus .or. lCaminhao)) .or.  (mv_par14 == 3  .and. !lCaminhao) .or. (mv_par14 == 4  .and. !lOnibus)
		DBSelectArea(cAliasVEC)
		dbSkip()
		Loop
	endif
	if !Empty(mv_par20)
		if !((cAliasVV1)->VV1_CODMAR $ mv_par20)
			dbSelectArea(cAliasVEC)
			dbSkip()
			Loop
		Endif
	Endif
	DBSelectArea(cAliasVEC)
	
	If Alltrim((cAliasVEC)->VEC_GRUITE) $ ALLTRIM(mv_par08) ;
		.Or. Alltrim((cAliasVEC)->VEC_GRUITE) $ ALLTRIM(mv_par09) ;
		.Or. Alltrim((cAliasVEC)->VEC_GRUITE) $ ALLTRIM(mv_par10) .AND. ( (cAliasVO1)->(FieldPos("VO1_CONSUL"))==0 .Or. ( cAliasVO1 )->VO1_CONSUL # mv_par18	)
		
		&& Grava arquivo de trabalho
		FS_GRATRAB( Stod((cAliasVEC)->VEC_DATVEN) , (cAliasVEC)->VEC_TIPTEM , (cAliasVEC)->VEC_NUMOSV , (cAliasVEC)->VEC_GRUITE ,  (cAliasVEC)->VEC_VALVDA+(cAliasVEC)->VEC_DESACE+(cAliasVEC)->VEC_VALSEG+(cAliasVEC)->VEC_VALFRE+(cAliasVEC)->VEC_VALIPI+(cAliasVEC)->VEC_ICMSRT , "P" ,(cAliasVO1)->VO1_CHAINT)
		
		If Select(cAliasVOI) > 0
			( cAliasVOI )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VOI.VOI_SITTPO "
		cQuery += "FROM "+RetSqlName( "VOI" ) + " VOI "
		cQuery += "WHERE "
		cQuery += "VOI.VOI_FILIAL='"+ xFilial("VOI") + "' AND VOI.VOI_TIPTEM = '"+(cAliasVEC)->VEC_TIPTEM+"' AND "
		cQuery += "VOI.D_E_L_E_T_=' ' "
		cQuery += "Order By VOI_TIPTEM"
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVOI, .T., .T. )
		
		nPos := aScan(aPassagem,{|x| x[1] + x[2] == ( cAliasVO1 )->VO1_DATABE + ( cAliasVO1 )->VO1_CHASSI})
		If nPos == 0
			aadd(aPassagem,{( cAliasVO1 )->VO1_DATABE,( cAliasVO1 )->VO1_CHASSI,( cAliasVO1 )->VO1_NUMOSV})
			
		Else
			
			nPos3 := aScan(aNum,{|x| x[1] == (cAliasVEC)->VEC_NUMOSV})
			If nPos3 == 0
				aadd(aNum,{(cAliasVEC)->VEC_NUMOSV,( cAliasVO1 )->VO1_CHASSI})
				nPos2 := Len(aNumOs)
				if len(aNumOS) = 0
					aadd(aNumOs,{( cAliasVO1 )->VO1_NUMOSV,dToc(Stod(( cAliasVO1 )->VO1_DATABE)),dToc(Stod((cAliasVEC)->VEC_DATVEN)),( cAliasVO1 )->VO1_CHASSI,Transform(( cAliasVO1 )->VO1_KILOME,"@E 99,999,999")})
				elseif aNumOs[nPos2,1] # ( cAliasVO1 )->VO1_NUMOSV .AND. aPassagem[nPos,3] # ( cAliasVO1 )->VO1_NUMOSV
					aadd(aNumOs,{( cAliasVO1 )->VO1_NUMOSV,dToc(Stod(( cAliasVO1 )->VO1_DATABE)),dToc(Stod((cAliasVEC)->VEC_DATVEN)),( cAliasVO1 )->VO1_CHASSI,Transform(( cAliasVO1 )->VO1_KILOME,"@E 99,999,999")})
				EndIf
			EndIf
		EndIf
		
	EndIf
	
	IncRegua()
	DbSelectArea(cAliasVEC)
	DbSkip()
	
EndDo
( cAliasVEC )->( DbCloseArea() )
If Select(cAliasVO1) > 0
	( cAliasVO1 )->( DbCloseArea() )
EndIf

//Deduz devolucao              
cQuery := "SELECT DISTINCT SD1.D1_NFORI,SD1.D1_SERIORI,SD1.D1_DTDIGIT FROM "
cQuery += RetSqlName( "SD1" ) + " SD1 , "+RetSqlName("SF4")+" SF4 , "+RetSqlName("SF2")+" SF2 "
cQuery += "WHERE SD1.D1_FILIAL='"+ xFilial("SD1")+ "' AND "
cQuery += "SD1.D1_TIPO = 'D' AND SD1.D1_DTDIGIT >= '"+dtos(MV_PAR11)+"' AND SD1.D1_DTDIGIT <= '"+dtos(MV_PAR12)+"' AND "
cQuery += "SF4.F4_CODIGO = SD1.D1_TES AND SF4.F4_ESTOQUE = 'S' AND SF4.F4_OPEMOV = '09' AND "
cQuery += "SF2.F2_FILIAL = '"+xFilial("SF2")+"' AND SF2.F2_DOC = SD1.D1_NFORI AND SF2.F2_SERIE = SD1.D1_SERIORI AND " 
cQuery += "SF2.F2_PREFORI = '"+GetNewPar("MV_PREFOFI","OFI")+"' AND "
cQuery += "SD1.D_E_L_E_T_=' ' AND SF4.D_E_L_E_T_=' ' AND SF2.D_E_L_E_T_=' '"
	
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSD1, .T., .T. )
			
while !( (cAliasSD1)->(eof()) ) 
    
	cQuery := "SELECT VEC.VEC_DATVEN , VEC.VEC_TIPTEM , VEC.VEC_NUMOSV , VEC.VEC_GRUITE , VEC.VEC_VALVDA , VEC.VEC_DESACE , VEC.VEC_VALSEG , VEC.VEC_VALFRE , VEC.VEC_VALIPI , VEC.VEC_ICMSRT, VO1.VO1_CHAINT FROM "
	cQuery += RetSqlName( "VEC" ) + " VEC, "+RetSqlName( "VO1" ) + " VO1 "
	cQuery += "WHERE VEC.VEC_FILIAL='"+ xFilial("VEC")+ "' AND "
	cQuery += "VEC.VEC_NUMNFI = '"+(cAliasSD1)->D1_NFORI+"' AND VEC.VEC_SERNFI = '"+(cAliasSD1)->D1_SERIORI+"' AND "
	cQuery += "VO1.VO1_FILIAL='"+ xFilial("VO1")+ "' AND VO1.VO1_NUMOSV = VEC.VEC_NUMOSV AND "
	cQuery += "VO1.D_E_L_E_T_=' ' AND VEC.D_E_L_E_T_=' '"

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVEC, .T., .T. )
	while !( (cAliasVEC)->(eof()) ) 

		If Select(cAliasVO1) > 0
			( cAliasVO1 )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VO1.VO1_CHAINT, VO1.VO1_CONSUL, VO1.VO1_DATABE, VO1.VO1_CHASSI, VO1.VO1_NUMOSV, VO1.VO1_KILOME , VO1.VO1_PROVEI , VO1.VO1_LOJPRO "
		If VO1->(FieldPos("VO1_CONSUL")) == 0
			cQuery := "SELECT VO1.VO1_CHAINT, VO1.VO1_DATABE, VO1.VO1_CHASSI, VO1.VO1_NUMOSV, VO1.VO1_KILOME , VO1.VO1_PROVEI , VO1.VO1_LOJPRO "
		EndIf
		cQuery += "FROM "+RetSqlName( "VO1" ) + " VO1 "
		cQuery += "WHERE "
		cQuery += "VO1.VO1_FILIAL='"+ xFilial("VO1")+ "' AND VO1.VO1_NUMOSV = '"+(cAliasVEC)->VEC_NUMOSV+"' AND "
		cQuery += "VO1.D_E_L_E_T_=' ' "
		cQuery += "Order By VO1_NUMOSV"
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO1, .T., .T. )
	
		If Select(cAliasVV1) > 0
			( cAliasVV1 )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VV1.VV1_CODMAR, VV1.VV1_MODVEI "
		cQuery += "FROM "+RetSqlName( "VV1" ) + " VV1 "
		cQuery += "WHERE "
		cQuery += "VV1.VV1_FILIAL='"+ xFilial("VV1")+ "' AND VV1.VV1_CHAINT = '"+(cAliasVO1)->VO1_CHAINT+"' AND "
		cQuery += "VV1.D_E_L_E_T_=' ' "
		cQuery += "Order By VV1_CHAINT"
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV1, .T., .T. )
		
		If Select(cAliasVV2) > 0
			( cAliasVV2 )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VV2.VV2_TIPVEI "
		cQuery += "FROM "+RetSqlName( "VV2" ) + " VV2 "
		cQuery += "WHERE "
		cQuery += "VV2.VV2_FILIAL='"+ xFilial("VV2") + "' AND VV2.VV2_CODMAR = '"+(cAliasVV1)->VV1_CODMAR+"' AND VV2.VV2_MODVEI = '"+(cAliasVV1)->VV1_MODVEI+"' AND "
		cQuery += "VV2.D_E_L_E_T_=' ' "
		cQuery += "Order By VV2_CODMAR,VV2_MODVEI"
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV2, .T., .T. )
	
		lCaminhao := .f.
		lOnibus   := .f.
		lOutro    := .f.
	
		if ( cAliasVV2 )->VV2_TIPVEI $ mv_par15
			lCaminhao := .t.
		elseif  ( cAliasVV2 )->VV2_TIPVEI $ mv_par16
			lOnibus   := .t.
		else
			lPasseio  := .t.
		endif
		
		if (mv_par14 == 3  .and. !lCaminhao) .or. (mv_par14 == 4  .and. !lOnibus)
			DBSelectArea(cAliasVEC)
			dbSkip()
			Loop
		endif

		&& Grava arquivo de trabalho
		FS_GRATRAB( Stod((cAliasSD1)->D1_DTDIGIT) , (cAliasVEC)->VEC_TIPTEM , (cAliasVEC)->VEC_NUMOSV , (cAliasVEC)->VEC_GRUITE , (cAliasVEC)->VEC_VALVDA+(cAliasVEC)->VEC_DESACE+(cAliasVEC)->VEC_VALSEG+(cAliasVEC)->VEC_VALFRE+(cAliasVEC)->VEC_VALIPI+(cAliasVEC)->VEC_ICMSRT , "D" ,(cAliasVEC)->VO1_CHAINT)
		
		( cAliasVEC )->( DbSkip() )
		
	Enddo
	( cAliasVEC )->( DbCloseArea() )

	( cAliasSD1 )->( DbSkip() )
	
Enddo
( cAliasSD1 )->( DbCloseArea() )

&& Totalizacao
DbSelectArea("TRB")
DbSetOrder( 1 )
DbGoTop()

Do While !Eof()
	
	RecLock( "TRB" , .F. )
	If TRB_TTOTAL > "0"
		RecLock( "TRB" , .F. )
		TRB_ADO345 := 0
		TRB_ADO06  := 0
		TRB_ADO07  := 0
		TRB_ADO11  := 0
		TRB_ADO09  := 0
		TRB_ADO10  := 0
		TRB_ADO12  := 0
		TRB_ADO13  := 0
		TRB_ADO14  := 0
		TRB_ADO15  := 0
		MsUnLock()
		dbSkip()
		Loop
	EndIf
	lTerc07 := .f.
	lTerc11 := .f.
	if TRB_TERCE == "2" .and. TRB_ADO07 > 0
		lTerc07 := .t.
	Elseif TRB_TERCE == "2" .and. TRB_ADO11 > 0
		lTerc11 := .t.
	Endif
	
	TRB_ADO06  := 0
	TRB_ADO07  := 0
	TRB_ADO11  := 0
	
	if TRB_TERCE == "2"
		TRB_ADO06  := 1
    Endif
	If TRB_ADO14 > 0 .or. TRB_ADO15 > 0
		//      TRB_ADO345 := 1
	EndIf
	
	If TRB_ADO12 > 0 .or. TRB_ADO13 > 0 .or. lTerc11
		//      TRB_ADO345 := 1
		TRB_ADO06  := 1
		TRB_ADO11  := 1
	EndIf
	
	If TRB_ADO08 > 0 .or. TRB_ADO09 > 0 .or. TRB_ADO10 > 0 .or. lTerc07
		//      TRB_ADO345 := 1
		TRB_ADO06  := 1
		TRB_ADO07  := 1
	EndIf
	//   cSitTpo := If(TRB_SITTPO == "4","2",TRB_SITTPO)
	ix1 := aScan(aVetADO,{ |x| x[01] == TRB_DATVEN .and. x[02] == TRB_SITTPO } )
	
	If ix1 == 0
		nPec := TRB_ADO16+TRB_ADO17+TRB_ADO18
		nSrv := TRB_ADO19+TRB_ADO20+TRB_ADO21+TRB_ADO22+TRB_ADO23+TRB_ADO24
//		if !(TRB_SITTPO <> "3" .and. !Empty(nPec) .and. Empty(nSrv))
			//                            01          02          03         04          05         06         07          08         09         10         11          12         13
			aAdd(aVetADO,{ TRB_DATVEN, TRB_SITTPO, TRB_ADO345, TRB_ADO06, TRB_ADO07, TRB_ADO11, TRB_ADO08, TRB_ADO09, TRB_ADO10, TRB_ADO12, TRB_ADO13, TRB_ADO14, TRB_ADO15, TRB_CHAINT,nPec,nSrv} )
			aAdd(aVet,{ TRB_DATVEN, TRB_SITTPO, TRB_CHAINT} )
//		Endif
	Else
		nPec := TRB_ADO16+TRB_ADO17+TRB_ADO18
		nSrv := TRB_ADO19+TRB_ADO20+TRB_ADO21+TRB_ADO22+TRB_ADO23+TRB_ADO24
		
		if !(TRB_SITTPO <> "3" .and. !Empty(nPec) .and. Empty(nSrv))
			If TRB->TRB_SITTPO $ "1/2/3/4"
				//    		If val(TRB->TRB_SITTPO) == ix1
				aVetADO[ix1,03] += TRB->TRB_ADO345
				//    		EndIf
			Else
				aVetADO[ix1,03] += TRB->TRB_ADO345
			EndIf
		Endif
		nachou := aScan(aVet,{ |x| x[01] == TRB_DATVEN .and. x[02] == TRB_SITTPO .and. x[03] == TRB_CHAINT } )
		if nachou == 0
			aAdd(aVet,{ TRB_DATVEN, TRB_SITTPO, TRB_CHAINT} )
			aVetADO[ix1,04] += TRB_ADO06
		Endif
		ix1 := aScan(aVetADO,{ |x| x[01] == TRB_DATVEN .and. x[02] == TRB_SITTPO } )
		aVetADO[ix1,05] += TRB_ADO07
		aVetADO[ix1,06] += TRB_ADO11
		aVetADO[ix1,07] += TRB_ADO08
		aVetADO[ix1,08] += TRB_ADO09
		aVetADO[ix1,09] += TRB_ADO10
		aVetADO[ix1,10] += TRB_ADO12
		aVetADO[ix1,11] += TRB_ADO13
		aVetADO[ix1,12] += TRB_ADO14
		aVetADO[ix1,13] += TRB_ADO15
		aVetADO[ix1,15] += nPec
		aVetADO[ix1,16] += nSrv
	EndIf
	
	MsUnLock()
	
	dbSkip()
	
EndDo

aSort(aVetADO,1,,{ |x,y| dtos(x[01])+x[02] < dtos(y[01])+y[02] })

For ix1 := 5 to len(aVetADO) step 5
	aVetADO[ix1,04] := aVetAdo[ix1 -4,04]+aVetAdo[ix1 -3,04]+aVetAdo[ix1 -2,04]+aVetAdo[ix1 -1,04]
	aVetADO[ix1,05] := aVetAdo[ix1 -4,05]+aVetAdo[ix1 -3,05]+aVetAdo[ix1 -2,05]+aVetAdo[ix1 -1,05]
	aVetADO[ix1,06] := aVetAdo[ix1 -4,06]+aVetAdo[ix1 -3,06]+aVetAdo[ix1 -2,06]+aVetAdo[ix1 -1,06]
	aVetADO[ix1,07] := aVetAdo[ix1 -4,07]+aVetAdo[ix1 -3,07]+aVetAdo[ix1 -2,07]+aVetAdo[ix1 -1,07]
	aVetADO[ix1,08] := aVetAdo[ix1 -4,08]+aVetAdo[ix1 -3,08]+aVetAdo[ix1 -2,08]+aVetAdo[ix1 -1,08]
	aVetADO[ix1,09] := aVetAdo[ix1 -4,09]+aVetAdo[ix1 -3,09]+aVetAdo[ix1 -2,09]+aVetAdo[ix1 -1,09]
	aVetADO[ix1,10] := aVetAdo[ix1 -4,10]+aVetAdo[ix1 -3,10]+aVetAdo[ix1 -2,10]+aVetAdo[ix1 -1,10]
	aVetADO[ix1,11] := aVetAdo[ix1 -4,11]+aVetAdo[ix1 -3,11]+aVetAdo[ix1 -2,11]+aVetAdo[ix1 -1,11]
	aVetADO[ix1,12] := aVetAdo[ix1 -4,12]+aVetAdo[ix1 -3,12]+aVetAdo[ix1 -2,12]+aVetAdo[ix1 -1,12]
	aVetADO[ix1,13] := aVetAdo[ix1 -4,13]+aVetAdo[ix1 -3,13]+aVetAdo[ix1 -2,13]+aVetAdo[ix1 -1,13]
next

If len(aVetADO) > 0
	
	For ix1 := 1 to len(aVetADO) 
	
   	  if (aVetADO[ix1,02] <> "3" .and. !Empty(aVetADO[ix1,15]) .and. Empty(aVetADO[ix1,16]))
	     Loop
	  Endif   
		
		DbSetOrder( 2 )
		If DbSeek( Dtos( aVetADO[ix1,01] ) + "1" + aVetADO[ix1,02] )
			RecLock( "TRB" , .F. )
			TRB_ADO345 += aVetADO[ix1,03]
			TRB_ADO06  := aVetADO[ix1,04]
			TRB_ADO07  := aVetADO[ix1,05]
			TRB_ADO11  := aVetADO[ix1,06]
			TRB_ADO09  := aVetADO[ix1,08]
			TRB_ADO10  := aVetADO[ix1,09]
			TRB_ADO12  := aVetADO[ix1,10]
			TRB_ADO13  := aVetADO[ix1,11]
			TRB_ADO14  := aVetADO[ix1,12]
			TRB_ADO15  := aVetADO[ix1,13]
			
		EndIf
		DbSetOrder( 3 )
		If DbSeek( "2" + aVetADO[ix1,02] )
			
			RecLock( "TRB" , .F. )
			
			TRB_ADO345 += aVetADO[ix1,03]
			TRB_ADO06  += aVetADO[ix1,04]
			TRB_ADO07  += aVetADO[ix1,05]
			TRB_ADO11  += aVetADO[ix1,06]
			TRB_ADO09  += aVetADO[ix1,08]
			TRB_ADO10  += aVetADO[ix1,09]
			TRB_ADO12  += aVetADO[ix1,10]
			TRB_ADO13  += aVetADO[ix1,11]
			TRB_ADO14  += aVetADO[ix1,12]
			TRB_ADO15  += aVetADO[ix1,13]
			
		EndIf
		
	Next
	
EndIf

&& Impressao
DbSelectArea("TRB")
DbSetOrder( 1 )
DbGoTop()

nBarra  := 0
cNumOsv := ""
nLin    := 1

If (mv_par13) # 3
	
	Do While !Eof()
		
		If mv_par14 == 1 .And. ( TRB->TRB_TTOTAL # "0" .And. TRB->TRB_SITTPO # "5" ) && Veiculos de passeio
			
			DbSelectArea("TRB")
			DbSkip()
			Loop
			
		EndIf
		
		If TRB->TRB_TTOTAL # "0" && Sintetico
			
			
			If TRB->TRB_SITTPO == "1"
				
				If TRB->TRB_TTOTAL == "1"
					
					@ Eval( bLinha , 1 ),1 PSAY Repl("-",3) + STR0007 + Dtoc( TRB->TRB_DATVEN ) + Repl("-",202) //"TOTAL "
					
				Else
					
					@ Eval( bLinha , 1 ),1 PSAY Repl("-",3) + STR0008 + Repl("-",201) //"TOTAL ACUMULADO"
					
				EndIf
				
				@ Eval( bLinha , 0 ),1 PSAY STR0009 + Str( TRB->TRB_ADO345 , 3 ) + "***" + "**** |" //"Cliente        "
				
			ElseIf TRB->TRB_SITTPO == "2"
				
				@ Eval( bLinha , 0 ),1 PSAY STR0010 + " *" + Str( TRB->TRB_ADO345 , 3 ) + "***** |" //"Garantia      "
				
			ElseIf TRB->TRB_SITTPO == "3"
				
				@ Eval( bLinha , 0 ),1 PSAY STR0011 + " *" + "**" + Str( TRB->TRB_ADO345 , 3 ) + "*** |" //"Interno       "
				
			Elseif TRB->TRB_SITTPO == "4"
				
				if TRB->TRB_TTOTAL == "1"
					if !Empty(MV_PAR19)
						If TRB->TRB_TPSER $ Alltrim(MV_PAR19)
							
							@ Eval( bLinha , 0 ),1 PSAY STR0076 + " **" + "***" + Str( TRB->TRB_ADO345 , 3 ) + "* |" //"Deslogamento     "
							
						Endif
					Endif
				Else
					@ Eval( bLinha , 0 ),1 PSAY STR0076 + " **" + "***" + Str( TRB->TRB_ADO345 , 3 ) + "* |" //"Deslogamento     "
				Endif
			Else
				
				If mv_par14 == 1  && Veiculos de passeio
					
					If TRB->TRB_TTOTAL == "1"
						
						@ Eval( bLinha , 1 ),1 PSAY Repl("-",3) + STR0007 + Dtoc( TRB->TRB_DATVEN ) + Repl("-",202) //"TOTAL "
						
					Else
						
						@ Eval( bLinha , 1 ),1 PSAY Repl("-",3) + STR0012 + Repl("-",204) //"TOTAL GERAL "
						
					EndIf
					
				EndIf
				
				@ Eval( bLinha , 0 ),1 PSAY STR0013 + Str( TRB->TRB_ADO345 , 3 ) + " -- |" //"** TOTAL **----  "
				
				//				@ Eval( bLinha , 0 ),1 PSAY "** TOTAL **--- " + Str( nPassou , 5 ) + " --- |"
				
				
			EndIf
			
			if TRB->TRB_SITTPO == "4"
				                 
				
				if TRB->TRB_TTOTAL == "1"
					if !Empty(MV_PAR19)
						If TRB->TRB_TPSER $ Alltrim(MV_PAR19)
							@ Eval( bLinha , 0 ) ,26 PSAY   " "+Transform( TRB->TRB_ADO06 , "@E 999" )  + " "+ Transform( TRB->TRB_ADO07 , "@E 999" )  + " "+Transform( TRB->TRB_ADO08 , "@E 999" )  +" "+ Transform( TRB->TRB_ADO09 , "@E 999" ) ;
							+ " "+Transform( TRB->TRB_ADO10 , "@E 999" )  +" "+ Transform( TRB->TRB_ADO11 , "@E 999" )  +" "+ Transform( TRB->TRB_ADO12 , "@E 999" )  +" "+ Transform( TRB->TRB_ADO13 , "@E 999" ) + "|";
							+ Transform( TRB->TRB_ADO14 , "@E 999" )  + Transform( TRB->TRB_ADO15 , "@E 999" )
						Endif
					Endif
				Else
					@ Eval( bLinha , 0 ) ,26 PSAY   " "+Transform( TRB->TRB_ADO06 , "@E 999" )  + " "+Transform( TRB->TRB_ADO07 , "@E 999" )  + " "+Transform( TRB->TRB_ADO08 , "@E 999" )  + " "+Transform( TRB->TRB_ADO09 , "@E 999" ) ;
					+ " "+Transform( TRB->TRB_ADO10 , "@E 999" )  + " "+Transform( TRB->TRB_ADO11 , "@E 999" )  + " "+Transform( TRB->TRB_ADO12 , "@E 999" )  + " "+Transform( TRB->TRB_ADO13 , "@E 999" ) + "|";
					+ Transform( TRB->TRB_ADO14 , "@E 999" )  + Transform( TRB->TRB_ADO15 , "@E 999" )
				Endif
			Else
				@ Eval( bLinha , 0 ) ,26 PSAY   " "+Transform( TRB->TRB_ADO06 , "@E 999" )  + " "+Transform( TRB->TRB_ADO07 , "@E 999" )  + " "+Transform( TRB->TRB_ADO08 , "@E 999" )  + " "+Transform( TRB->TRB_ADO09 , "@E 999" ) ;
				+ " "+Transform( TRB->TRB_ADO10 , "@E 999" )  + " "+Transform( TRB->TRB_ADO11 , "@E 999" )  + " "+Transform( TRB->TRB_ADO12 , "@E 999" )  + " "+Transform( TRB->TRB_ADO13 , "@E 999" ) + "|";
				+ Transform( TRB->TRB_ADO14 , "@E 999" )  + Transform( TRB->TRB_ADO15 , "@E 999" )
			Endif
		Else   && Analitico
			
			If MV_PAR13 == 2
				
				DbSelectArea("TRB")
				DbSkip()
				Loop
				
			EndIf
			
			cXString := ""
			
			For nCol := 6 to 13
				
				If !Empty( &( "TRB->TRB_ADO" + StrZero(nCol,2) ) )
					
					cXString += Space( 3 ) + "X"
					
				Else
					
					cXString += Space( 4 )
					
				EndIf
				
			Next
			                                                                                                                       
			
			
			If TRB->TRB_SITTPO == "5" .Or. ;
				( !( "X" $ cXString ) .And.	;
				( Empty(TRB->TRB_ADO16) .And. Empty(TRB->TRB_ADO17) .And. Empty(TRB->TRB_ADO18) .And. Empty(TRB->TRB_VALPEC) .And. Empty(TRB->TRB_DESLO) .And. Empty(TRB->TRB_MBRDL) .And. Empty(TRB->TRB_ADO24) ) )
				//			If TRB->TRB_SITTPO == "5" .Or. ;
				//				( !( "X" $ cXString ) .And.	;
				//				( Empty(TRB->TRB_ADO16) .And. Empty(TRB->TRB_ADO17) .And. Empty(TRB->TRB_ADO18) ) )
				
				DbSelectArea("TRB")
				DbSkip()
				Loop
				
			EndIf
			
			If TRB->TRB_NUMOSV # cNumOsv && Caminhoes
				
				nBarra++
				cNumOsv := TRB->TRB_NUMOSV
				
				If mv_par14 >= 2   && Caminhoes
					
					@ Eval( bLinha , 0 ),01 PSAY Str( nBarra , 3 )
					
				EndIf
				
			EndIf
			
			@ Eval( bLinha , 0 ),05 PSAY "|" + TRB->TRB_NUMOSV + "|"
			
			if TRB->TRB_SITTPO == "1"
				cSitTpo := "1"
			Elseif TRB->TRB_SITTPO == "2"
				cSitTpo := "3"
			Elseif TRB->TRB_SITTPO == "3"
				cSitTpo := "5"
			Endif
			if !Empty(MV_PAR19)
				If TRB->TRB_TPSER $ Alltrim(MV_PAR19)
					cSitTpo := "7"
				Endif
			Endif
			@ Eval( bLinha , 0 ), ( 15 + ( ( Val(cSitTpo) ) ) ) PSAY "X"
			
			@ Eval( bLinha , 0 ),25 PSAY "|" + cXString + "|"
			
		EndIf
		
		if TRB->TRB_SITTPO == "4"
			
			if TRB->TRB_TTOTAL == "1"
				if !Empty(MV_PAR19)
					If TRB->TRB_TPSER $ Alltrim(MV_PAR19)
						@ Eval( bLinha , 1 ),65 PSAY "|" + Transform( TRB->TRB_ADO16 , "@E 9,999,999.99" )  + Transform( TRB->TRB_ADO17 , "@E 9,999,999.99" )  + Transform( TRB->TRB_ADO18 , "@E 9999,999.99" ) + Transform( TRB->TRB_DESLO , "@E 99,999.99" )  +  "|" ;
						+ Transform( TRB->TRB_ADO19 , "@E 9999,999.99" )   + Transform( TRB->TRB_ADO20 , "@E 9999,999.99" )   + Transform( TRB->TRB_ADO21 , "@E 9999,999.99" )  + Transform( TRB->TRB_ADO22 , "@E 999,999.99" )  + Transform( TRB->TRB_ADO23 , "@E 999,999.99" ) + Transform( TRB->TRB_MBRDL , "@E 999,999.99" ) + "|" ;
						+ Transform( TRB->TRB_ADO24 , "@E 9,999,999.99" )   + Transform( TRB->TRB_ADO25 , "@E 999,999.99" )   + Transform( TRB->TRB_ADO26 , "@E 999,999.99" )  + "|" ;
						+ Transform( TRB->TRB_ADO27 , "@E 9,999,999.99" )
					Endif
				Endif
			Else
				@ Eval( bLinha , 1 ),65 PSAY "|" + Transform( TRB->TRB_ADO16 , "@E 9,999,999.99" )  + Transform( TRB->TRB_ADO17 , "@E 9,999,999.99" )  + Transform( TRB->TRB_ADO18 , "@E 9999,999.99" ) + Transform( TRB->TRB_DESLO , "@E 99,999.99" )  +  "|" ;
				+ Transform( TRB->TRB_ADO19 , "@E 9999,999.99" )   + Transform( TRB->TRB_ADO20 , "@E 9999,999.99" )   + Transform( TRB->TRB_ADO21 , "@E 9999,999.99" )  + Transform( TRB->TRB_ADO22 , "@E 999,999.99" )  + Transform( TRB->TRB_ADO23 , "@E 999,999.99" ) + Transform( TRB->TRB_MBRDL , "@E 999,999.99" ) + "|" ;
				+ Transform( TRB->TRB_ADO24 , "@E 9,999,999.99" )   + Transform( TRB->TRB_ADO25 , "@E 999,999.99" )   + Transform( TRB->TRB_ADO26 , "@E 999,999.99" )  + "|" ;
				+ Transform( TRB->TRB_ADO27 , "@E 9,999,999.99" )
			Endif
		Else
			@ Eval( bLinha , 1 ),65 PSAY "|" + Transform( TRB->TRB_ADO16 , "@E 9,999,999.99" )  + Transform( TRB->TRB_ADO17 , "@E 9,999,999.99" )  + Transform( TRB->TRB_ADO18 , "@E 9999,999.99" ) + Transform( TRB->TRB_DESLO , "@E 99,999.99" )  +  "|" ;
			+ Transform( TRB->TRB_ADO19 , "@E 9999,999.99" )   + Transform( TRB->TRB_ADO20 , "@E 9999,999.99" )   + Transform( TRB->TRB_ADO21 , "@E 9999,999.99" )  + Transform( TRB->TRB_ADO22 , "@E 999,999.99" )  + Transform( TRB->TRB_ADO23 , "@E 999,999.99" ) + Transform( TRB->TRB_MBRDL , "@E 999,999.99" ) + "|" ;
			+ Transform( TRB->TRB_ADO24 , "@E 9,999,999.99" )   + Transform( TRB->TRB_ADO25 , "@E 999,999.99" )   + Transform( TRB->TRB_ADO26 , "@E 999,999.99" )  + "|" ;
			+ Transform( TRB->TRB_ADO27 , "@E 9,999,999.99" )
		Endif
		If TRB->TRB_SITTPO == "5"
			
			@ Eval( bLinha , 1 ),1 PSAY Repl("-",219)
			
		EndIf
		
		DbSelectArea("TRB")
		DbSkip()
		
	EndDo
	
EndIf


&& Imprime resumido
FS_RESUMIDO()

Eject

Set Printer to
Set device to Screen

MS_FLUSH()

// Fecha alias das query.
If Select(cAliasVO1) > 0
	( cAliasVO1 )->( dbCloseArea() )
EndIf
If Select(cAliasVO4) > 0
	( cAliasVO4 )->( dbCloseArea() )
EndIf
If Select(cAliasVV1) > 0
	( cAliasVV1 )->( dbCloseArea() )
EndIf
If Select(cAliasVV2) > 0
	( cAliasVV2 )->( dbCloseArea() )
EndIf
If Select(cAliasVOI) > 0
	( cAliasVOI )->( dbCloseArea() )
EndIf
If Select(cAliasVOK) > 0
	( cAliasVOK )->( dbCloseArea() )
EndIf
If Select(cAliasVSC) > 0
	( cAliasVSC )->( dbCloseArea() )
EndIf
If Select(cAliasVEC) > 0
	( cAliasVEC )->( dbCloseArea() )
EndIf

oObjTempTable:CloseTable()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_GRATRABºAutor  ³Caio Cesar          º Data ³  22/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava arquivo de trabalho                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_GRATRAB( dDataVen , cTipTem , cNumOsv , cGruSec , nValor , cPecSrv , lSomaPassagem , cTipSer , cChaint)

Local nTo := 0 , nReg := 0 , cColuna := ""
&& Cria registro para Cliente/ garantia/ interno/ total
DbSelectArea("TRB")

For nTo := 2 to 0 Step -1
	
	For nReg := 5 to 1 Step -1
		
		If nTo == 0
			
			DbSetOrder( 1 )
			If DbSeek( Dtos( dDataVen ) + StrZero( nTo , 1 ) + cNumOsv + StrZero( nReg , 1 ) )
				Loop
			EndIF
			
		ElseIf nTo == 1
			
			DbSetOrder( 2 )
			If DbSeek( Dtos( dDataVen ) + StrZero( nTo , 1 ) + StrZero( nReg , 1 ) )
				Loop
			EndIf
			
		Else
			
			DbSetOrder( 3 )
			
			If DbSeek( StrZero( nTo , 1 ) + StrZero( nReg , 1 ) ) .And. TRB->TRB_DATVEN >= dDataVen
				
				Loop
				
			EndIf
			
		EndIf
		cAchou := Found()
		dbSelectArea("VOI")
		dbSetOrder(1)
		dbSeek(xFilial("VOI")+cTipTem)
		if cPecSrv == "P" .and. VOI->VOI_SITTPO == "3"
			lSomentP := .f.
			if !cAchou
				lSomentP := .t.
			Endif
		Endif
		
		&& Grava no arquivo de trabalho
		RecLock( "TRB" , !cAchou)
		
		TRB->TRB_DATVEN := dDataVen
		TRB->TRB_NUMOSV := cNumOsv
		TRB->TRB_CHAINT := cChaint
		TRB->TRB_TTOTAL := StrZero( nTo  , 1 )
		TRB->TRB_SITTPO := StrZero( nReg , 1 )
		if cPecSrv == "S"
			TRB->TRB_TPSER := cTipSer
		Endif
		if ((cPecSrv == "P" .or. cPecSrv == "D") .and. VOI->VOI_SITTPO == "3")
			if lSomentP .and. TRB->TRB_SITTPO == "3"
				if cPecSrv == "D"
					TRB->TRB_VALPEC := TRB->TRB_VALPEC - nValor
                else
					TRB->TRB_VALPEC := nValor
				Endif
			Endif
		Endif
		
		MsUnLock()
		
	Next
	
Next

//DbSelectArea("VOI")
//DbSetOrder( 1 )
//DbSeek( xFilial("VOI") + cTipTem )

If Select(cAliasVOI) > 0
	( cAliasVOI )->( DbCloseArea() )
EndIf
cQuery := "SELECT VOI.VOI_SITTPO "
cQuery += "FROM "+RetSqlName( "VOI" ) + " VOI "
cQuery += "WHERE "
cQuery += "VOI.VOI_FILIAL='"+ xFilial("VOI") + "' AND VOI.VOI_TIPTEM = '"+cTipTem+"' AND "
cQuery += "VOI.D_E_L_E_T_=' ' "
cQuery += "Order By VOI_TIPTEM"
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVOI, .T., .T. )

For nTo := 0 to 2
	
	For nReg := 0 to 1
		
		If ( cAliasVOI )->VOI_SITTPO == "1"
			
			cColuna := "1"
			
		ElseIf ( cAliasVOI )->VOI_SITTPO == "2" .Or. ( cAliasVOI )->VOI_SITTPO == "4"
			
			cColuna := "2"
			
		Else
			
			cColuna := "3"
			
		EndIf
		if cPecSrv == "S"
			if !Empty(MV_PAR19)
				if cTipSer $ Alltrim(MV_PAR19)
					
					cColuna := "4"
					
				Endif
			Endif
		Endif
		If nReg == 1
			
			cColuna := "5"
			
		EndIf
		
		DbSelectArea("TRB")
		If nTo == 0
			
			DbSetOrder( 1 )
			DbSeek( Dtos( dDataVen ) + StrZero( nTo , 1 ) + cNumOsv + cColuna )
			
		ElseIf nTo == 1
			
			DbSetOrder( 2 )
			DbSeek( Dtos( dDataVen ) + StrZero( nTo , 1 ) + cColuna )
			
		Else
			
			DbSetOrder( 3 )
			DbSeek( StrZero( nTo , 1 ) + cColuna )
			
		EndIf
		
		&& Grava no arquivo de trabalho
		RecLock( "TRB" , .f. )
		If cPecSrv == "P" 
			
			&& Pecas
			If cGruSec $ Alltrim(mv_par08)
				
				If ( cAliasVOI )->VOI_SITTPO # "3"          && nao lista vlr de servico/pecas interno.
					TRB->TRB_ADO16 += nValor
					
					TRB->TRB_ADO27 += nValor
				EndIf
				
			EndIf
			
			&& Acessorios
			If cGruSec $ Alltrim(mv_par09)
				
				If ( cAliasVOI )->VOI_SITTPO # "3"          && nao lista vlr de servico/pecas interno.
					TRB->TRB_ADO17 += nValor
					
					TRB->TRB_ADO27 += nValor
				EndIf
				
			EndIf
			If nTo == 0
				TRB_ADO345 := 1
			EndIf
			&& Outras mercadorias
			If cGruSec $ Alltrim(mv_par10)
				
				If ( cAliasVOI )->VOI_SITTPO # "3"          && nao lista vlr de servico/pecas interno.
					TRB->TRB_ADO18 += nValor
					
					TRB->TRB_ADO27 += nValor
				EndIf
				
			EndIf
			
			&& Combustivel Lubrificante
			If cGruSec $ Alltrim(mv_par07)
				
				TRB->TRB_ADO15 := If(nTo == 0,1,TRB->TRB_ADO15 + 1) && ADO( 15 )
				
				If ( cAliasVOI )->VOI_SITTPO # "3"          && nao lista vlr de servico/pecas interno.
					TRB->TRB_ADO26 += nValor
					
					TRB->TRB_ADO27 += nValor
				EndIf
				
			EndIf
			
			&& Deslacamento
			if cPecSrv == "S"
				if !Empty(MV_PAR19)
					If cTipSer $ Alltrim(MV_PAR19)
						
						TRB->TRB_DESLO += nValor
						
					EndIf
				Endif
			Endif
        Elseif cPecSrv == "D"
			&& Pecas
			If cGruSec $ Alltrim(mv_par08)
				
				If ( cAliasVOI )->VOI_SITTPO # "3"          && nao lista vlr de servico/pecas interno.
					TRB->TRB_ADO16 -= nValor
					
					TRB->TRB_ADO27 -= nValor
				EndIf
				
			EndIf
			
			&& Acessorios
			If cGruSec $ Alltrim(mv_par09)
				
				If ( cAliasVOI )->VOI_SITTPO # "3"          && nao lista vlr de servico/pecas interno.
					TRB->TRB_ADO17 -= nValor
					
					TRB->TRB_ADO27 -= nValor
				EndIf
				
			EndIf
			If nTo == 0
				TRB_ADO345 := 1
			EndIf
			&& Outras mercadorias
			If cGruSec $ Alltrim(mv_par10)
				
				If ( cAliasVOI )->VOI_SITTPO # "3"          && nao lista vlr de servico/pecas interno.
					TRB->TRB_ADO18 -= nValor
					
					TRB->TRB_ADO27 -= nValor
				EndIf
				
			EndIf
			
			&& Combustivel Lubrificante
			If cGruSec $ Alltrim(mv_par07)
				
				TRB->TRB_ADO15 := If(nTo == 0,1,TRB->TRB_ADO15 + 1) && ADO( 15 )
				
				If ( cAliasVOI )->VOI_SITTPO # "3"          && nao lista vlr de servico/pecas interno.
					TRB->TRB_ADO26 -= nValor
					
					TRB->TRB_ADO27 -= nValor
				EndIf
				
			EndIf
			
			&& Deslacamento
			if cPecSrv == "S"
				if !Empty(MV_PAR19)
					If cTipSer $ Alltrim(MV_PAR19)
						
						TRB->TRB_DESLO -= nValor
						
					EndIf
				Endif
			Endif
		Else
			
			&& Srv Rapido
			If cGruSec $ Alltrim(mv_par01)
				
				If lSomaPassagem
					
					TRB->TRB_ADO06 += 1 && ADO( 06 )
					TRB->TRB_ADO07 += 1 && ADO( 07 )
					TRB->TRB_ADO08 := If(nTo == 0,1,TRB->TRB_ADO08 + 1) && ADO( 08 )
					
				EndIf
				
				TRB->TRB_ADO19 += nValor
				
				TRB->TRB_ADO27 += nValor
				
			EndIf
			
			&& Revisao
			If cGruSec $ Alltrim(mv_par02)
				
				If lSomaPassagem
					
					TRB->TRB_ADO06 += 1 && ADO( 06 )
					TRB->TRB_ADO07 += 1 && ADO( 07 )
					TRB->TRB_ADO09 := If(nTo == 0,1,TRB->TRB_ADO09 + 1) && ADO( 09 )
					
				EndIf
				
				TRB->TRB_ADO20 += nValor
				
				TRB->TRB_ADO27 += nValor
				
			EndIf
			
			&& Mecanica
			If cGruSec $ Alltrim(mv_par03) .or. Empty(cGruSec)
				
				If lSomaPassagem
					
					TRB->TRB_ADO06 += 1 && ADO( 06 )
					TRB->TRB_ADO07 += 1 && ADO( 07 )
					TRB->TRB_ADO10 := If(nTo == 0,1,TRB->TRB_ADO10 + 1) && ADO( 10 )
					
				EndIf
				
				TRB->TRB_ADO21 += nValor
				
				TRB->TRB_ADO27 += nValor
				
			EndIf
			
			&& Funilaria
			If cGruSec $ Alltrim(mv_par04)
				
				If lSomaPassagem
					
					TRB->TRB_ADO06 += 1 && ADO( 06 )
					TRB->TRB_ADO07 += 1 && ADO( 07 )
					TRB->TRB_ADO11 += 1 && ADO( 11 )
					TRB->TRB_ADO12 := If(nTo == 0,1,TRB->TRB_ADO12 + 1) && ADO( 12 )
					
				EndIf
				
				TRB->TRB_ADO22 += nValor
				
				TRB->TRB_ADO27 += nValor
				
			EndIf
			
			&& Pintura
			If cGruSec $ Alltrim(mv_par05)
				
				If lSomaPassagem
					
					TRB->TRB_ADO06 += 1 && ADO( 06 )
					TRB->TRB_ADO07 += 1 && ADO( 07 )
					TRB->TRB_ADO11 += 1 && ADO( 11 )
					TRB->TRB_ADO13 := If(nTo == 0,1,TRB->TRB_ADO13 + 1) && ADO( 13 )
					
				EndIf
				
				
				TRB->TRB_ADO23 += nValor
				
				TRB->TRB_ADO27 += nValor
				
			EndIf
			
			If nTo == 0 .and. lSomaPassagem
				TRB_ADO345 := 1
			EndIf
			
			if cPecSrv == "S"
				if !Empty(MV_PAR19)
					If cTipSer $ Alltrim(MV_PAR19)
						
						TRB->TRB_MBRDL += nValor
						
					EndIf
				Endif
			Endif
			&& Servico de terceiro
			//		   DbSelectArea("VOK")
			//		   DbSetOrder( 1 )
			//		   DbSeek( xFilial("VOK") + (cAliasVSC)->VSC_TIPTEM )
			
			If Select(cAliasVOK) > 0
				( cAliasVOK )->( DbCloseArea() )
			EndIf
			cQuery := "SELECT VOK.VOK_INCMOB "
			cQuery += "FROM "+RetSqlName( "VOK" ) + " VOK "
			cQuery += "WHERE "
			cQuery += "VOK.VOK_FILIAL='"+ xFilial("VOK") + "' AND VOK.VOK_TIPSER = '"+(cAliasVSC)->VSC_TIPSER+"' AND "
			cQuery += "VOK.D_E_L_E_T_=' ' "
			cQuery += "Order By VOK_TIPSER"
			dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVOK, .T., .T. )
			
			If ( cAliasVOK )->VOK_INCMOB == "2"
				if ( cAliasVOI )->VOI_SITTPO  == "1"
					TRB->TRB_ADO06 += 1
 				Elseif ( cAliasVOI )->VOI_SITTPO == "2"
					TRB->TRB_ADO06 += 1
					TRB->TRB_ADO07 += 1
				Endif
				TRB->TRB_TERCE := "2"
				TRB->TRB_ADO24 += nValor
				
				TRB->TRB_ADO27 += nValor
				
			EndIf
			
			&& Lavagem
			If cGruSec $ Alltrim(mv_par06)
				
				If lSomaPassagem
					
					TRB->TRB_ADO14 := If(nTo == 0,1,TRB->TRB_ADO14 + 1) && ADO( 14 )
					
				EndIf
				
				TRB->TRB_ADO25 += nValor
				
				TRB->TRB_ADO27 += nValor
				
			EndIf
			
			
			&& Lubrificacao
			If cGruSec $ Alltrim(mv_par07)
				
				If lSomaPassagem
					
					TRB->TRB_ADO15 := If(nTo == 0,1,TRB->TRB_ADO15 + 1) && ADO( 15 )
					
				EndIf
				
				TRB->TRB_ADO25 += nValor
				
				TRB->TRB_ADO27 += nValor
				
			EndIf
			
			
			
		EndIf
		
		MsUnLock()
		
	Next
	
Next

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_OR170VAºAutor  ³Fabio               º Data ³  12/28/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Valida                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_OR170VALID()

Local nVal := 0 , nValVar := 0

If ReadVar() $ "MV_PAR01/MV_PAR02/MV_PAR03/MV_PAR04/MV_PAR05/MV_PAR06/MV_PAR07/MV_PAR08/MV_PAR09/MV_PAR10"
	
	For nVal := 1 to Len( &( ReadVar() ) ) Step 4
		
		If Empty( &( ReadVar() ) )
			
			Help("  ",1,"VCPOEMP")
			
			Exit
			
		EndIf
		
		If Empty( Substr( &( ReadVar() ) , nVal , 3 ) )
			
			Exit
			
		EndIf
		
		&& Secao
		If ReadVar() $ "MV_PAR01/MV_PAR02/MV_PAR03/MV_PAR04/MV_PAR05/MV_PAR06/MV_PAR07"
			
			DbSelectArea("VOD")
			DbSetOrder( 1 )
			If !DbSeek( xFilial("VOD") + Substr( &( ReadVar() ) , nVal , 3 ) )
				
				Help("  ",1,"VPARNVALID")
				Return( .f. )
				
			EndIf
			
			For nValVar := 1 to 7
				
				If "MV_PAR"+StrZero( nValVar ,2) # ReadVar() .And. Substr( &( ReadVar() ) , nVal , 3 ) $ &( "MV_PAR"+StrZero( nValVar ,2) )
					
					Help("  ",1,"VPARNVALID")
					Return( .f. )
					
				EndIf
				
			Next
			
		EndIf
	Next
	
	For nVal := 1 to Len( Alltrim(&( ReadVar() )) ) Step 5
		&& Grupo
		If ReadVar() $ "MV_PAR08/MV_PAR09/MV_PAR10"
			
			DbSelectArea("SBM")
			DbSetOrder( 1 )
			If !DbSeek( xFilial("SBM") + Substr( &( ReadVar() ) , nVal , 4 ) )
				
				Help("  ",1,"VPARNVALID")
				Return( .f. )
				
			EndIf
			
			For nValVar := 8 to 10
				
				If "MV_PAR"+StrZero( nValVar ,2) # ReadVar() .And. Substr( &( ReadVar() ) , nVal , 4 ) $ Alltrim(&( "MV_PAR"+StrZero( nValVar ,2)) )
					
					Help("  ",1,"VPARNVALID")
					Return( .f. )
					
				EndIf
				
			Next
			
		EndIf
		
	Next
	
EndIf

Return( .t. )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_OR170CAºAutor  ³Caio Cesar          º Data ³  22/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cabecalho                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_LINHA( nSoma )

Local nReturn := 0

If nLin >= 66
	
	nLin := 1
	
EndIf

If nLin == 1
	
	&& Impressao do relatorio
	cbTxt    := Space(10)
	cbCont   := 0
	cString  := "VSC"
	Li       := 80
	m_Pag    := 1
	
	wnRel    := "OFIOR170"
	
	cTitulo:= STR0014 //"Analise Diaria da Oficina - A.D.O - "
	If mv_par14 == 1
		cTitulo +=STR0016  //"Veiculos de Passeio"
	elseif mv_par14 == 2
		cTitulo +=STR0015  //"Caminhoes/Onibus"
	elseif mv_par14 == 3
		cTitulo +=STR0063  //"Caminhoes"
	else
		cTitulo +=STR0064  //"Onibus"
	endif
	cabec1 := ""
	cabec2 := ""
	nomeprog:="OFIOR170"
	tamanho:="G"
	nCaracter:=15
	nTotal := 0
	
	nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	@ nLin++,1 PSAY Repl("*",219)
	
	@ nLin++,1 PSAY Space(4) + STR0017 //"| Nro.OS |--Tipo OS--|-------VEICULOS  ATENDIDOS------|-POSTO-|----------VENDA  DE  MATERIAL----------|------------------VENDA  DE  NAO  DE  OBRA------------------|------------OUTRAS MARCAS-----------|---TOTAL DA OS"
	@ nLin++,1 PSAY If( MV_PAR14 == 2 , STR0018 , Space(4) ) + "|" + Space(8) + STR0019 + Space(7) + STR0020 + Space(3) + STR0021 //"Qtd."###"|   C  G  I |OFC  ---------PASSAGENS---------| LV  LB|"###"PECAS   ACESSORIOS    OUT.MERC.|    SERV.RAP     REVISAO    MECANICA   FUNILARIA     PINTURA|"###" DIVERSOS   LAV/LUBR.  COMB/LUBR.|"
	@ nLin++,1 PSAY If( MV_PAR14 == 2 , STR0022 , Space(4) ) + "|" + Space(8) + "|" + Space(10) + "|" + Space(4) + STR0023 + Space(6) + "|" + Space(44) + "|" + Space(63) + "|" + Space(32) + "|"  //"Veic"###"ST ---SECAO---  ST -SECAO-|"
 	@ nLin++,1 PSAY If( MV_PAR14 == 2 , STR0024 , Space(4) ) + "|" + Space(8) + "|" + Space(10) + "|" + Space(4) + STR0025 + Space(6) + "|" + Space(44) + "|" + Space(63) + "|" + Space(32) + "|"  //"Aten"###"SG  RP  RV  MC  SC  FN  PI|"

	@ nLin++,1 PSAY Repl("-",219)
	
	If mv_par14 == 2
		
		@ nLin++,1 PSAY Space(2) + "1" + Space(1) + "|" + Space(4) + "2" + Space(3) + "|" + Space(1) + "3" + Space(1) + "4" + Space(1) + "5" + "    |" + Space(3) + "6" ;
		+ Space(3) + "7" + Space(3) + "8" + Space(3) + "9" + Space(2) + "10" + Space(2) + "11" + Space(2) + "12" + Space(2) + "13|" + Space(1) + "14" + Space(1) + "15|" + Space(10) + "16" + Space(10) + "17" + Space(9) + "18" ;
		+ Space(7) + "19|" + Space(8) + "20" + Space(9) + "21" + Space(9) + "22" + Space(9) + "23" + Space(8) + "24" + Space(8) + "25|" + Space(10) + "26" + Space(8) + "27" + Space(8) + "28|" + Space(10) + "29"
		@ nLin++,1 PSAY Repl("-",219)
		
	EndIf
	
EndIf

nReturn := nLin
nLin    += nSoma

Return( nReturn )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_RESUMI ºAutor  ³Caio Cesar          º Data ³  22/09/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao Resumida                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_RESUMIDO()

Local aResumido := {} , nRes := 0 , nCol := 0
Local nTotalDia  := 0 , nTotal := 0
Local nM1 := 0 , nni := 0

&& Cria Vetor Resumido
&& Analise
Aadd(aResumido, { "1" , STR0026              , STR0027       , 0 , 0 } ) && [ 1] //"ORDENS DE SERVICO"###"CLIENTE"
Aadd(aResumido, { "1" , ""                   , STR0028       , 0 , 0 } ) && [ 2] //"GARANTIA"
Aadd(aResumido, { "1" , ""                   , STR0029       , 0 , 0 } ) && [ 3] //"INTERNO"
Aadd(aResumido, { "1" , STR0030              , STR0031       , 0 , 0 } ) && [ 4] //"VEICULOS ATENDIDOS"###"NA OFICINA"
Aadd(aResumido, { "1" , ""                   , STR0032       , 0 , 0 } ) && [ 5] //"GERAIS"
Aadd(aResumido, { "1" , ""                   , STR0033       , 0 , 0 } ) && [ 6] //"SERV.RAPIDO"
Aadd(aResumido, { "1" , ""                   , STR0034       , 0 , 0 } ) && [ 7] //"MANUTENCAO"
Aadd(aResumido, { "1" , ""                   , STR0035       , 0 , 0 } ) && [ 8] //"MECANICA"
Aadd(aResumido, { "1" , ""                   , STR0036       , 0 , 0 } ) && [ 9] //"SEVICOS CARROCERIA"
Aadd(aResumido, { "1" , ""                   , STR0037       , 0 , 0 } ) && [10] //"FUNILARIA"
Aadd(aResumido, { "1" , ""                   , STR0038       , 0 , 0 } ) && [11] //"PINTURA"
Aadd(aResumido, { "1" , STR0039              , STR0040       , 0 , 0 } ) && [12] //"PASSAGENS POSTO"###"LAVAGEM"
Aadd(aResumido, { "1" , ""                   , STR0041       , 0 , 0 } ) && [13] //"LUBRIFICACAO"
Aadd(aResumido, { "1" , ""                   , STR0042       , 0 , 0 } ) && [14] //"RETORNO OFICINA"
&& Internas / Externas / garantia / cliente                                                      Interna   Extern  Garant   Cliente
Aadd(aResumido, { "2" , STR0043              , STR0044       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [15] //"VENDA DE MATERIAL"###"PECAS"
Aadd(aResumido, { "2" , ""                   , STR0045       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [16] //"ACESSORIOS"
Aadd(aResumido, { "2" , ""                   , STR0046       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [17] //"OUTRAS MERCADORIAS"
Aadd(aResumido, { "2" , STR0047              , STR0033       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [18] //"VENDA DE MAO DE OBRA"###"SERV.RAPIDO"
Aadd(aResumido, { "2" , ""                   , STR0034       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [19] //"MANUTENCAO"
Aadd(aResumido, { "2" , ""                   , STR0035       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [20] //"MECANICA"
Aadd(aResumido, { "2" , ""                   , STR0037       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [21] //"FUNILARIA"
Aadd(aResumido, { "2" , ""                   , STR0038       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [22] //"PINTURA"
Aadd(aResumido, { "2" , STR0048              , STR0049       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [23] //"OUTRAS VENDAS"###"DIVERSAS"
Aadd(aResumido, { "2" , ""                   , STR0050       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [24] //"LAVAGEM/LUBRIFICACAO"
Aadd(aResumido, { "2" , ""                   , STR0051       , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [25] //"COMBUST/LUBRIFICANTES"
Aadd(aResumido, { "2" , STR0052              , Space(16)     , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ) && [25] //"Total das Vendas"

DbSelectArea("TRB")

nTotDiaG := 0
nTotPerG := 0
&& Ordens de Servico
For nRes := 1 to 3
	
	&& No dia
	DbSetOrder( 2 )
	DbSeek( Dtos( dDataBase ) + "1" + StrZero( nRes , 1 ) )
	aResumido[ nRes , 4 ] := TRB->TRB_ADO06    && Total no dia Cliente/interno/garantia
	nTotDiaG += TRB->TRB_ADO06
	
	&& Total
	DbSetOrder( 3 )
	DbSeek( "2" + StrZero( nRes , 1 ) )
	aResumido[ nRes , 5 ] := TRB->TRB_ADO06   && Total Cliente/interno/garantia
	nTotPerG += TRB->TRB_ADO06
	
Next

&& Veiculos atendidos na oficina
DbSetOrder( 2 )
DbSeek( Dtos( dDataBase ) + "2" + "5" )
aResumido[ 4 , 4 ] := TRB->TRB_ADO06    && Total no dia Oficina

DbSetOrder( 3 )
DbSeek( "2" + "5" )
aResumido[ 4 , 5 ] := TRB->TRB_ADO06    && Total Oficina


&& Veiculos atendidos na oficina - Srv gerais/srv.rapido/manutencao/mecanica
DbSetOrder( 2 )
DbSeek( Dtos( dDataBase ) + "1" + "5" )
aResumido[ 5 , 4 ] := TRB->TRB_ADO07    && Total no dia  Srv.Gerais

aResumido[ 6 , 4 ] := TRB->TRB_ADO08    && Total no dia  Srv.Rapido
aResumido[ 7 , 4 ] := TRB->TRB_ADO09    && Total no dia  Manutencao
aResumido[ 8 , 4 ] := TRB->TRB_ADO10    && Total no dia  Mecanica
aResumido[ 9 , 4 ] := TRB->TRB_ADO11    && Total no dia  Carroceria
aResumido[10 , 4 ] := TRB->TRB_ADO12    && Total no dia  Funilaria
aResumido[11 , 4 ] := TRB->TRB_ADO13    && Total no dia  Pintura
aResumido[12 , 4 ] := TRB->TRB_ADO14    && Total no dia  Lavagem
aResumido[13 , 4 ] := TRB->TRB_ADO15    && Total no dia  Lubrificacao

//aResumido[14 , 4 ] := TRB->TRB_ADO15    && Total no dia  Retorno Oficina

DbSetOrder( 3 )
DbSeek( "2" + "5" )
aResumido[ 5 , 5 ] := TRB->TRB_ADO07    && Total    Srv.Gerais

aResumido[ 6 , 5 ] := TRB->TRB_ADO08    && Total    Srv.Rapido
aResumido[ 7 , 5 ] := TRB->TRB_ADO09    && Total    Manutencao
aResumido[ 8 , 5 ] := TRB->TRB_ADO10    && Total    Mecanica
aResumido[ 9 , 5 ] := TRB->TRB_ADO11    && Total    Carroceria
aResumido[10 , 5 ] := TRB->TRB_ADO12    && Total    Funilaria
aResumido[11 , 5 ] := TRB->TRB_ADO13    && Total    Pintura
aResumido[12 , 5 ] := TRB->TRB_ADO14    && Total    Lavagem
aResumido[13 , 5 ] := TRB->TRB_ADO15    && Total    Lubrificacao

//aResumido[14 , 4 ] := TRB->TRB_ADO15    && Total   Retorno Oficina

For nRes := 1 to 3
	
	If (mv_par14) == 1
		
		If nRes == 1 .Or. nRes == 2
			
			nCol := 10
			
		Else
			
			nCol := 8
			
		EndIf
		
	Else
		
		If nRes == 1
			
			nCol := 4
			
		ElseIf nRes == 2
			
			nCol := 6
			
		Else
			
			nCol := 8
			
		EndIf
		
	EndIf
	
	&& No dia
	DbSetOrder( 2 )
	DbSeek( Dtos( dDataBase ) + "1" + StrZero( nRes , 1 ) )
	aResumido[15 , nCol ] += TRB->TRB_ADO16    && Total no dia  Pecas
	aResumido[16 , nCol ] += TRB->TRB_ADO17    && Total no dia  Acessorios
	aResumido[17 , nCol ] += TRB->TRB_ADO18    && Total no dia  Out. Mercadorias
	
	aResumido[18 , nCol ] += TRB->TRB_ADO19    && Total no dia  Srv. Rapido
	aResumido[19 , nCol ] += TRB->TRB_ADO20    && Total no dia  Manutencao
	aResumido[20 , nCol ] += TRB->TRB_ADO21    && Total no dia  Mecanica
	aResumido[21 , nCol ] += TRB->TRB_ADO22    && Total no dia  Funilaria
	aResumido[22 , nCol ] += TRB->TRB_ADO23    && Total no dia  Pintura
	
	aResumido[23 , nCol ] += TRB->TRB_ADO24    && Total no dia  Diversas
	aResumido[24 , nCol ] += TRB->TRB_ADO25    && Total no dia  Lavagem
	aResumido[25 , nCol ] += TRB->TRB_ADO26    && Total no dia  Lubrificantes
	
	aResumido[26 , nCol ] +=   TRB->TRB_ADO16 + TRB->TRB_ADO17 + TRB->TRB_ADO18 + TRB->TRB_ADO19 + TRB->TRB_ADO20 + TRB->TRB_ADO21 ;
	+ TRB->TRB_ADO22 + TRB->TRB_ADO23 + TRB->TRB_ADO24 + TRB->TRB_ADO25
	&& Total
	DbSetOrder( 3 )
	DbSeek( "2" + StrZero( nRes , 1 ) )
	aResumido[15 , nCol+1 ] += TRB->TRB_ADO16    && Total    Pecas
	aResumido[16 , nCol+1 ] += TRB->TRB_ADO17    && Total    Acessorios
	aResumido[17 , nCol+1 ] += TRB->TRB_ADO18    && Total    Out. Mercadorias
	
	aResumido[18 , nCol+1 ] += TRB->TRB_ADO19    && Total    Srv. Rapido
	aResumido[19 , nCol+1 ] += TRB->TRB_ADO20    && Total    Manutencao
	aResumido[20 , nCol+1 ] += TRB->TRB_ADO21    && Total    Mecanica
	aResumido[21 , nCol+1 ] += TRB->TRB_ADO22    && Total    Funilaria
	aResumido[22 , nCol+1 ] += TRB->TRB_ADO23    && Total    Pintura
	
	aResumido[23 , nCol+1 ] += TRB->TRB_ADO24    && Total    Diversas
	aResumido[24 , nCol+1 ] += TRB->TRB_ADO25    && Total    Lavagem
	aResumido[25 , nCol+1 ] += TRB->TRB_ADO26    && Total    Lubrificantes
	
	aResumido[26 , nCol+1 ] +=    TRB->TRB_ADO16 + TRB->TRB_ADO17 + TRB->TRB_ADO18 + TRB->TRB_ADO19 + TRB->TRB_ADO20 + TRB->TRB_ADO21 ;
	+ TRB->TRB_ADO22 + TRB->TRB_ADO23 + TRB->TRB_ADO24 + TRB->TRB_ADO25
	
Next

&& Impressao do relatorio
cbTxt    := Space(10)
cbCont   := 0
cString  := "VSC"
Li       := 80
m_Pag    := 1

wnRel    := "OFIOR170"

cTitulo:= STR0053 //"Analise Diaria da Oficina - Resumido"
cabec1 := ""
cabec2 := ""
nomeprog:="OFIOR170"
tamanho:="P"
nCaracter:=15
nTotal := 0
nLin := 1

nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
@ nLin++,0 PSAY Repl("*",80)

nRes := 1
@ nLin++,0 PSAY STR0054 + Repl( "-" , 48 ) + STR0055 + Repl( "-" , 12 ) + STR0056 //"ANALISE"###"NO DIA"###"PERIODO"
Do While aResumido[ nRes , 1] == "1"
	
	if nLin > 50
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	endif
	
	@ nLin ,0  PSAY aResumido[ nRes , 2 ]
	@ nLin ,20 PSAY aResumido[ nRes , 3 ]
	
	@ nLin++ ,55  PSAY Transform( aResumido[ nRes , 4 ] , "@E 99,999") + Space( 13 ) + Transform( aResumido[ nRes , 5 ] , "@E 99,999")
	
	nRes++
	
EndDo

For nCol := 4 to 10 step 2
	
	If ( mv_par14 == 1 .And. nCol < 8 ) .Or. mv_par14 == 2 .And. nCol > 9
		
		Loop
		
	EndIf
	if nLin >= 50
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	endif
	@ nLin++,0 PSAY Repl( "-" , 35 ) ;
	+ " " + If( nCol == 4 ,STR0057, If( nCol == 6 ,STR0028, If( nCol == 8 ,STR0058, STR0059 ) ) ) ; //"CLIENTE "###"GARANTIA"###"INTERNAS"###"EXTERNAS"
	+ " " + Repl( "-" , 35 )
	
	nRes := Ascan( aResumido , {|x| x[1] == "2" } )
	
	Do While nRes <= Len( aResumido )
		
		@ nLin  ,0  PSAY aResumido[ nRes , 2 ]
		@ nLin  ,25 PSAY aResumido[ nRes , 3 ]
		
		@ nLin++  ,48  PSAY Transform( aResumido[ nRes , nCol ] , "@E 99,999,999.99") + Space( 6 ) + Transform( aResumido[ nRes ,  nCol + 1 ] , "@E 99,999,999.99")
		
		If nRes == Len( aResumido )
			
			nTotalDia  += aResumido[ nRes , nCol ]
			nTotal     += aResumido[ nRes , nCol + 1 ]
			
		EndIf
		
		nRes++
		
	EndDo
	
	@ nLin++,0 PSAY Repl("-",80)
	
Next

@ nLin++,0 PSAY Repl("-",80)

@ nLin    ,0 PSAY STR0060  //"TOTAL GERAL"
@ nLin++ ,48  PSAY Transform( nTotalDia , "@E 99,999,999.99") + Space( 6 ) + Transform( nTotal , "@E 99,999,999.99")

@ nLin++,0 PSAY Repl("-",80)

for nni := 1 to Len (aErro)
	if nLin > 50
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	endif
	@ nLin++,0 pSAY aErro[nni]
next

@ nLin++
@ nLin++
@ nLin++
@ nLin++,0 PSAY Repl("-",3) + STR0065 + Dtoc(mv_par11) + " a " + Dtoc(mv_par12)/*Dtoc( TRB->TRB_DATVEN )*/ + Repl("-",190)     // "TOTAL POR PASSAGEM "
@ nLin++,0 PSAY STR0009 + Str( nCli , 3 ) + "***" + "*** |"                //"Cliente        "
@ nLin++,0 PSAY STR0010 + " ***" + Str( nGaran , 3 ) + "*** |"             //"Garantia      "
@ nLin++,0 PSAY STR0011 + " ***" + "***" + Str( nInter , 3 ) + " |"        //"Interno       "
@ nLin++,0 PSAY STR0080 + " ***" + "***" + Str( nDesloc , 3 ) + " |"       //"Deslocamento  "
@ nLin++,0 PSAY "** "+STR0007+"**--- " + Str( nPassou , 5 ) + " --- |"     //"TOTAL "
@ nLin++,0 PSAY Repl("-",220)

@ nLin++

nLin := 60

for nM1 := 1 to len (aNumOs)
	if nLin > 50
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	endif
	if nM1 == 1
		@ nLin++ , 000 PSAY STR0066 + Repl("-",201)       // "--- OS COM CHASSI DUPLICADO "
	endif
	if !Empty(aNumOs[nM1,1])
		@ nLin++,0 PSAY STR0067 + aNumOs[nM1,1]              // "O.S.           : "
		@ nLin++,0 PSAY STR0068 + aNumOs[nM1,4]              // "Chassi         : "
		@ nLin++,0 PSAY STR0069 + aNumOs[nM1,2]              // "Dt Abertura    : "
		@ nLin++,0 PSAY STR0070 + aNumOs[nM1,3]              // "Dt Venda       : "
		
		nLin += 2
	endif
next

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg ºAutor  ³Caio Cesar          º Data ³  22/09/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida pergunte                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg()

Local i:=0, j:=0

_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))
aRegs:={}
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"14",,,,,,,,,,,,STR0072,,,,,STR0073,,,,,STR0074,,,,,STR0075,,,,,,,,,,})   //"Divisao?"###"Veic Passeio"###"Caminhao/Onibus"###"Apenas Caminhao"###"Apenas Onibus"
aAdd(aRegs,{cPerg,"15",STR0078,"","","mv_c15","C",20,0,0,"G","","mv_par15","","","",,"","","","","","","","","","","","","","","","","","","","","",""})   //"Consultor Desconsid?"
aAdd(aRegs,{cPerg,"16",STR0079,"","","mv_c16","C",20,0,0,"G","","mv_par16","","","",,"","","","","","","","","","","","","","","","","","","","","",""})   //"Consultor Desconsid?"
aAdd(aRegs,{cPerg,"17",STR0081,"","","mv_c17","C",20,0,0,"G","","mv_par17","","","",,"","","","","","","","","","","","","","","","","","","","","",""})   //"Consultor Desconsid?"
aAdd(aRegs,{cPerg,"18",STR0071,"","","mv_chi","C",06,0,0,"G","","mv_par18","","","",,"","","","","","","","","","","","","","","","","","","","","AA1",""})   //"Consultor Desconsid?"
aAdd(aRegs,{cPerg,"19",STR0077,"","","mv_chj","C",90,0,0,"G","","mv_par19","","","",,"","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"20",STR0082,"","","mv_chh","C",90,0,0,"G","","mv_par20","","","",,"","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	
	DbSeek(cPerg+aRegs[i,2])
	
	RecLock("SX1", !Found() )
	For j:=1 to Len(aRegs[i])
		If aRegs[i,j] # NIL
			FieldPut(j,aRegs[i,j])
		EndIf
	Next
	MsUnlock()
	dbCommit()
	
Next
dbSelectArea(_sAlias)

Return
