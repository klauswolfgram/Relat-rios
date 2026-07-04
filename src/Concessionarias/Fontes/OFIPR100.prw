/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 09     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#Include "OFIPR100.ch"

/*/{Protheus.doc} mil_ver()
    Versao do fonte modelo novo

    @author Andre Luis Almeida
    @since  13/11/2017
/*/
Static Function mil_ver()
	If .F.
		mil_ver()
	EndIf
Return "007398_1"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OFIPR100 ºAutor  ³Andre Luis / ANDRE  º Data ³  08/02/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao do Saldo por Almoxarifado                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MIL                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIPR100()
Private cPerg := "OFP100"

U_OPR100R3() // Executa versão anterior do fonte

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OFIPR100 ºAutor  ³Andre Luis Almeida  º Data ³  08/02/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do Saldo por Almoxarifado                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MIL                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OPR100R3

cDesc1    := STR0001
cDesc2    := ""
cDesc3    := ""
cAlias    := "SB2"
aRegistros:= {}
nLin      := 0
aPag      := 1
nIte      := 1
aReturn   := { OemToAnsi(STR0002), 1,OemToAnsi(STR0003), 2, 2, 1, "",1 }
cTamanho  := "G"           // P/M/G
Limite    := 220           // 80/132/220
aOrdem    := {}           // Ordem do Relatorio
cTitulo   := STR0004
cNomeProg := "OFIPR100"
cNomeRel  := "OFIPR100"
nLastKey  := 0
nCaracter := 15
cabec1    := ""
cabec2    := ""
cPerg     := "OFP100"
nPosAlm   := 0

ValidPerg()
PERGUNTE(cPerg,.f.)

cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
If nLastKey == 27
	Return
EndIf

SetDefault(aReturn,cAlias)
RptStatus( { |lEnd| FS_IMPSALALM(@lEnd,cNomeRel,cAlias) } , cTitulo )

If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf

MS_Flush()
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_IMPSALALM ºAutor  ³Andre Luis Almeida  º Data ³  08/02/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do Saldo por Almoxarifado                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MIL                                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPSALALM()

Local ni := 0
Local cMV_GRUVEI  := PadR(AllTrim(GetMv("MV_GRUVEI")),TamSx3("B1_GRUPO")[1]," ") // Grupo do Veiculo

Local nPos := 0

Private cbTxt    := Space(10)
Private cbCont   := 0
Private cString  := "SB2"
Private Li       := 220
Private m_Pag    := 1
Private wnRel    := "OFIPR100"
Private aAlmox   := {}
Private aTotal   := {}
Private aVetCampos:={}

Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer

aAlmox := {}

If Alltrim(MV_PAR02) == "" // Todos Armazens
	DbSelectArea("NNR")
	DbSetOrder(1)
	DbSeek( xFilial("NNR") )
	While !Eof() .And. NNR->NNR_FILIAL == xFilial("NNR")
		If !NNR->NNR_CODIGO $ "DV/IM/SV"
			aAdd(aAlmox,NNR->NNR_CODIGO)
		EndIf
		DbSelectArea("NNR")
		DbSkip()
	EndDo
Else
	aAdd(aAlmox,MV_PAR02)
EndIf

cabecT := STR0005
nAlmox := len(aAlmox)
cabecT := cabecT + " "
For ni:=1 to nAlmox
	cabecT := cabecT + "     -" + aAlmox[ni] + "-   "
Next
cabecT := cabecT+space(16)+STR0014
///////////////////////////////////////////////////////////////////////////
//         C r i a     A r q u i v o    d e    T r a b a l h o           //
///////////////////////////////////////////////////////////////////////////
aadd(aVetCampos,{ "TRB_GRUPO"  , "C" , 4 , 0 })  //  Grupo da Peca    //
aadd(aVetCampos,{ "TRB_CODITE" , "C" ,27 , 0 })  //  Codigo da Peca   //
aadd(aVetCampos,{ "TRB_DESC"   , "C" ,30 , 0 })  //  Descricao Peca   //
aadd(aVetCampos,{ "TRB_ALMOXA" , "C" , 10 , 0 })  //  Almoxarifado 01  //
aadd(aVetCampos,{ "TRB_ALMOXB" , "C" , 10 , 0 })  //  Almoxarifado 02  //
aadd(aVetCampos,{ "TRB_ALMOXC" , "C" , 10 , 0 })  //  Almoxarifado 03  //
aadd(aVetCampos,{ "TRB_ALMOXD" , "C" , 10 , 0 })  //  Almoxarifado 04  //
aadd(aVetCampos,{ "TRB_ALMOXE" , "C" , 10 , 0 })  //  Almoxarifado 05  //
aadd(aVetCampos,{ "TRB_ALMOXF" , "C" , 10 , 0 })  //  Almoxarifado 06  //
aadd(aVetCampos,{ "TRB_ALMOXG" , "C" , 10 , 0 })  //  Almoxarifado 07  //
aadd(aVetCampos,{ "TRB_ALMOXH" , "C" , 10 , 0 })  //  Almoxarifado 08  //
aadd(aVetCampos,{ "TRB_ALMOXI" , "C" , 10 , 0 })  //  Almoxarifado 09  //
aadd(aVetCampos,{ "TRB_ALMOXJ" , "C" , 10 , 0 })  //  Almoxarifado 10  //
aadd(aVetCampos,{ "TRB_ALMOXK" , "C" , 10 , 0 })  //  Almoxarifado 11  //
aadd(aVetCampos,{ "TRB_ALMOXL" , "C" , 10 , 0 })  //  Almoxarifado 12  //
aadd(aVetCampos,{ "TRB_ALMOXM" , "C" , 10 , 0 })  //  Almoxarifado 13  //
aadd(aVetCampos,{ "TRB_ALMOXN" , "C" , 10 , 0 })  //  Almoxarifado 14  //
aadd(aVetCampos,{ "TRB_ALMOXO" , "C" , 10 , 0 })  //  Almoxarifado 15  //
aadd(aVetCampos,{ "TRB_ALMOXP" , "C" , 10 , 0 })  //  Almoxarifado 16  //
aadd(aVetCampos,{ "TRB_ALMOXQ" , "C" , 10 , 0 })  //  Almoxarifado 17  //
aadd(aVetCampos,{ "TRB_ALMOXR" , "C" , 10 , 0 })  //  Almoxarifado 18  //
aadd(aVetCampos,{ "TRB_ALMOXS" , "C" , 10 , 0 })  //  Almoxarifado 19  //
aadd(aVetCampos,{ "TRB_ALMOXT" , "C" , 10 , 0 })  //  Almoxarifado 20  //
aadd(aVetCampos,{ "TRB_ALMOXU" , "C" , 10 , 0 })  //  Almoxarifado 21  //
aadd(aVetCampos,{ "TRB_ALMOXV" , "C" , 10 , 0 })  //  Almoxarifado 22  //
aadd(aVetCampos,{ "TRB_ALMOXX" , "C" , 10 , 0 })  //  Almoxarifado 23  //
///////////////////////////////////////////////////////////////////////////

oObjTempTable := OFDMSTempTable():New()
oObjTempTable:cAlias := "TRB"
oObjTempTable:aVetCampos := aVetCampos
oObjTempTable:AddIndex(, {"TRB_GRUPO","TRB_CODITE"} )
oObjTempTable:CreateTable()

For ni:=1 to 23
	aAdd(aTotal, 0 )
Next

DbSelectArea("SB2")
DbSetOrder(1)
DbSeek( xFilial("SB2") )

SetRegua( RecCount()*(1.1) )

cCod := STR0013

Do While !Eof() .And. SB2->B2_FILIAL == xFilial("SB2")
	
	IncRegua()
	
	nPos := aScan(aAlmox,SB2->B2_LOCAL)
	
	If ( nPos >= 1 ) .and. ( nPos <= 23 )
		
		nQtd := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,MV_PAR01+1)[1]
		
		If ( nQtd > 0 )
			
			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek( xFilial("SB1") + SB2->B2_COD )

			If SB1->B1_GRUPO == cMV_GRUVEI
				DbSelectArea("VV1")
				DbSetOrder(1)
				DbSeek( xFilial("VV1") + SB1->B1_COD )
				DbSelectArea("VV2")
				DbSetOrder(1)
				DbSeek( xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
				cCodite := VV1->VV1_CHASSI
				cDescri := left(Alltrim(VV1->VV1_MODVEI) + " - " + VV2->VV2_DESMOD,30)
			Else
				cCodite := SB1->B1_CODITE
				cDescri := left(SB1->B1_DESC,30)
			EndIf
			
			If ( cCod # SB2->B2_COD )
				DbSelectArea("TRB")
				RecLock("TRB",.t.)
				TRB->TRB_GRUPO  := SB1->B1_GRUPO
				TRB->TRB_CODITE := cCodite
				TRB->TRB_DESC   := cDescri
				MsUnlock()
			EndIf
						
			If ( Subs(SB1->B1_GRUPO,1,3) == GetMv("MV_GRUVEI")+space(4-len(GetMv("MV_GRUVEI"))) )
				aTotal[nPos] := 1
			Else
				aTotal[nPos] := nQtd
			EndIf
			nValor :=0
			DbSelectArea("TRB")
			RecLock("TRB",.f.)
			If TRB->TRB_ALMOXA == "          " .or. TRB->TRB_ALMOXA == "         -"
				TRB->TRB_ALMOXA := IIf(aTotal[1]>0 ,Transform(aTotal[1] ,"@E 9999999999"),IIf(nAlmox>=1, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXB == "          " .or. TRB->TRB_ALMOXB == "         -"
				TRB->TRB_ALMOXB := IIf(aTotal[2]>0 ,Transform(aTotal[2] ,"@E 9999999999"),IIf(nAlmox>=2, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXC == "          " .or. TRB->TRB_ALMOXC == "         -"
				TRB->TRB_ALMOXC := IIf(aTotal[3]>0 ,Transform(aTotal[3] ,"@E 9999999999"),IIf(nAlmox>=3, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXD == "          " .or. TRB->TRB_ALMOXD == "         -"
				TRB->TRB_ALMOXD := IIf(aTotal[4]>0 ,Transform(aTotal[4] ,"@E 9999999999"),IIf(nAlmox>=4, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXE == "          " .or. TRB->TRB_ALMOXE == "         -"
				TRB->TRB_ALMOXE := IIf(aTotal[5]>0 ,Transform(aTotal[5] ,"@E 9999999999"),IIf(nAlmox>=5, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXF == "          " .or. TRB->TRB_ALMOXF == "         -"
				TRB->TRB_ALMOXF := IIf(aTotal[6]>0 ,Transform(aTotal[6] ,"@E 9999999999"),IIf(nAlmox>=6, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXG == "          " .or. TRB->TRB_ALMOXG == "         -"
				TRB->TRB_ALMOXG := IIf(aTotal[7]>0 ,Transform(aTotal[7] ,"@E 9999999999"),IIf(nAlmox>=7, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXH == "          " .or. TRB->TRB_ALMOXH == "         -"
				TRB->TRB_ALMOXH := IIf(aTotal[8]>0 ,Transform(aTotal[8] ,"@E 9999999999"),IIf(nAlmox>=8, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXI == "          " .or. TRB->TRB_ALMOXI == "         -"
				TRB->TRB_ALMOXI := IIf(aTotal[9]>0 ,Transform(aTotal[9] ,"@E 9999999999"),IIf(nAlmox>=9, "         -","          "))
			EndIf
			If TRB->TRB_ALMOXJ == "          " .or. TRB->TRB_ALMOXJ == "         -"
				TRB->TRB_ALMOXJ := IIf(aTotal[10]>0,Transform(aTotal[10],"@E 9999999999"),IIf(nAlmox>=10,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXK == "          " .or. TRB->TRB_ALMOXK == "         -"
				TRB->TRB_ALMOXK := IIf(aTotal[11]>0,Transform(aTotal[11],"@E 9999999999"),IIf(nAlmox>=11,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXL == "          " .or. TRB->TRB_ALMOXL == "         -"
				TRB->TRB_ALMOXL := IIf(aTotal[12]>0,Transform(aTotal[12],"@E 9999999999"),IIf(nAlmox>=12,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXM == "          " .or. TRB->TRB_ALMOXM == "         -"
				TRB->TRB_ALMOXM := IIf(aTotal[13]>0,Transform(aTotal[13],"@E 9999999999"),IIf(nAlmox>=13,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXN == "          " .or. TRB->TRB_ALMOXN == "         -"
				TRB->TRB_ALMOXN := IIf(aTotal[14]>0,Transform(aTotal[14],"@E 9999999999"),IIf(nAlmox>=14,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXO == "          " .or. TRB->TRB_ALMOXO == "         -"
				TRB->TRB_ALMOXO := IIf(aTotal[15]>0,Transform(aTotal[15],"@E 9999999999"),IIf(nAlmox>=15,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXP == "          " .or. TRB->TRB_ALMOXP == "         -"
				TRB->TRB_ALMOXP := IIf(aTotal[16]>0,Transform(aTotal[16],"@E 9999999999"),IIf(nAlmox>=16,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXQ == "          " .or. TRB->TRB_ALMOXQ == "         -"
				TRB->TRB_ALMOXQ := IIf(aTotal[17]>0,Transform(aTotal[17],"@E 9999999999"),IIf(nAlmox>=17,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXR == "          " .or. TRB->TRB_ALMOXR == "         -"
				TRB->TRB_ALMOXR := IIf(aTotal[18]>0,Transform(aTotal[18],"@E 9999999999"),IIf(nAlmox>=18,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXS == "          " .or. TRB->TRB_ALMOXS == "         -"
				TRB->TRB_ALMOXS := IIf(aTotal[19]>0,Transform(aTotal[19],"@E 9999999999"),IIf(nAlmox>=19,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXT == "          " .or. TRB->TRB_ALMOXT == "         -"
				TRB->TRB_ALMOXT := IIf(aTotal[20]>0,Transform(aTotal[20],"@E 9999999999"),IIf(nAlmox>=20,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXU == "          " .or. TRB->TRB_ALMOXU == "         -"
				TRB->TRB_ALMOXU := IIf(aTotal[21]>0,Transform(aTotal[21],"@E 9999999999"),IIf(nAlmox>=21,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXV == "          " .or. TRB->TRB_ALMOXV == "         -"
				TRB->TRB_ALMOXV := IIf(aTotal[22]>0,Transform(aTotal[22],"@E 9999999999"),IIf(nAlmox>=22,"         -","          "))
			EndIf
			If TRB->TRB_ALMOXX == "          " .or. TRB->TRB_ALMOXX == "         -"
				TRB->TRB_ALMOXX := IIf(aTotal[23]>0,Transform(aTotal[23],"@E 9999999999"),IIf(nAlmox>=23,"         -","          "))
			EndIf
			MsUnlock()
			
			cCod := SB2->B2_COD
			
			For ni:=1 to 23
				aTotal[ni] := 0
			Next
			
		EndIf
		
	EndIf
	
	DbSelectArea("SB2")
	DbSkip()
Enddo

cTitulo := STR0004 + "  " + Transform(MV_PAR01,"@D") + IIf( !Empty(MV_PAR02) , STR0007 + MV_PAR02 , "" )
nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
@ nLin++ , 01 psay cabecT
nLin++
nInc := 0

DbSelectArea("TRB")
DbGoTop()
Do While !Eof()
	nInc++
	If nInc == 10
		nInc := 0
		IncRegua()
	EndIf
	If nPosAlm > 0
		cAlmoxX := "TRB_ALMOX"+substr("ABCDEFGHIJK",nPosAlm,1)
		If TRB->&cAlmoxX == "         -"
			dbSkip()
			Loop
		EndIf
	EndIf
	If nLin > 63
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
		@ nLin++ , 01 psay cabecT
		nLin++
	EndIf
	dbSelectArea("SB1")
	dbSetOrder(7)
	dbSeek(xFilial("SB1")+TRB->TRB_GRUPO+TRB->TRB_CODITE)     
	cImprime := alltrim(TRB->TRB_ALMOXA) + alltrim(TRB->TRB_ALMOXB) + alltrim(TRB->TRB_ALMOXC) + alltrim(TRB->TRB_ALMOXD) + ;
	alltrim(TRB->TRB_ALMOXE) + alltrim(TRB->TRB_ALMOXF) + alltrim(TRB->TRB_ALMOXG) + alltrim(TRB->TRB_ALMOXH) + alltrim(TRB->TRB_ALMOXI) + alltrim(TRB->TRB_ALMOXJ) + alltrim(TRB->TRB_ALMOXK) + ;
	alltrim(TRB->TRB_ALMOXL) + alltrim(TRB->TRB_ALMOXM) + alltrim(TRB->TRB_ALMOXN) + alltrim(TRB->TRB_ALMOXO) + alltrim(TRB->TRB_ALMOXP) + alltrim(TRB->TRB_ALMOXQ) + alltrim(TRB->TRB_ALMOXR) + ;
	alltrim(TRB->TRB_ALMOXS) + alltrim(TRB->TRB_ALMOXT) + alltrim(TRB->TRB_ALMOXU) + alltrim(TRB->TRB_ALMOXV) + alltrim(TRB->TRB_ALMOXX)
	If len(cImprime) < 15
	   cImprime := cImprime + space(15-(len(cImprime)))
	EndIf   
	
	c_Impr :=  TRB->TRB_GRUPO + " " + TRB->TRB_CODITE + " " + TRB->TRB_DESC +"       "+ cImprime
	If !Empty(SB1->B1_COD)
		If !Empty(mv_par02)
			cIMP := Len(TRB->TRB_ALMOXB + TRB->TRB_ALMOXC + TRB->TRB_ALMOXD)
			If !Empty(TRB->TRB_ALMOXB + TRB->TRB_ALMOXC + TRB->TRB_ALMOXD)
				@ nLin++ , 01 psay c_Impr+"     "+ SB1->B1_COD
			Else
				@ nLin++ , 01 psay c_Impr+space(9)+ SB1->B1_COD
			EndIf
		Else
			@ nLin++ , 01 psay c_Impr+"  "+space(9)+ SB1->B1_COD  
			
		EndIf
	EndIf
	DbSelectArea("TRB")
	DbSkip()
EndDo

DbSelectArea("TRB")
oObjTempTable:CloseTable()

Set Printer to
Set Device  to Screen

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ValidPerg ³ Autor ³Rafael Goncalves       ³ Data ³03/02/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao de processamento da gravacao do SX1 - Perguntes     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Atualizacao OFI                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ValidPerg()

Local _sAlias := Alias()
Local aSX1 := {}
Local ni   := 0
Local nj   := 0
Local aEstrSX1 := { "X1_GRUPO","X1_ORDEM","X1_PERGUNT","X1_PERSPA","X1_PERENG","X1_VARIAVL","X1_TIPO","X1_TAMANHO","X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID","X1_VAR01","X1_DEF01","X1_DEFSPA1","X1_DEFENG1","X1_CNT01","X1_VAR02","X1_DEF02","X1_DEFSPA2","X1_DEFENG2","X1_CNT02","X1_VAR03","X1_DEF03","X1_DEFSPA3","X1_DEFENG3","X1_CNT03","X1_VAR04","X1_DEF04","X1_DEFSPA4","X1_DEFENG4","X1_CNT04","X1_VAR05","X1_DEF05","X1_DEFSPA5","X1_DEFENG5","X1_CNT05","X1_F3","X1_PYME","X1_GRPSXG","X1_HELP","X1_PICTURE","X1_IDFIL" }

dbSelectArea("SX1")
DbSetOrder(1)
if dbSeek(left(cPerg+space(len(SX1->X1_GRUPO)),len(SX1->X1_GRUPO))+'01')
	If Alltrim(SX1->X1_VALID) == '!EMPTY(MV_PAR01)'
		dbSelectArea(_sAlias)
		Return
	EndIF
EndIf

aAdd(aSX1,{cPerg,'01',STR0015,STR0015,STR0015,'mv_ch1','D',8,0,0,'G','!EMPTY(MV_PAR01)','mv_par01','','','','','','','','','','','','','','','','','','','','','','','','','','N','','','',''})
aAdd(aSX1,{cPerg,'02',STR0016,STR0016,STR0016,'mv_ch2','C',2,0,0,'G','','mv_par02','','','','01','','','','','','','','','','','','','','','','','','','','','NNR','N','','','',''})


dbSelectArea("SX1")
DbSetOrder(1)
For ni:= 1 To Len(aSX1)
	dbSeek(left(aSX1[ni,1]+space(len(SX1->X1_GRUPO)),len(SX1->X1_GRUPO))+aSX1[ni,2])//grupo + ordem  - +space(len(SX1->X1_GRUPO)),len(SX1->X1_GRUPO))
	RecLock("SX1",!Found())
	For nj:=1 To Len(aSX1[ni])
		If ( FieldPos(aEstrSX1[nj])>0 .and. aSX1[ni,nj] # NIL )
			FieldPut(FieldPos(aEstrSX1[nj]),aSX1[ni,nj])
		EndIf
	Next nj
	dbCommit()
	MsUnLock()
Next ni

dbSelectArea(_sAlias)

Return