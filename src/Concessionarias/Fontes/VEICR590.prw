/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 04     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "VEICR590.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao   ³ VEICR590 ³ Autor ³ Andre Luis Almeida ³ Data ³ 03/06/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao³ Analise CEV - Ano / Mes / Vendedor                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR590()
Local aArea       := GetArea()
Private cAlias    := "VC1"
Private cDesc1    := STR0001
Private cDesc2    := ""
Private cDesc3    := ""
Private cCabec1   := ""
Private cCabec2   := ""
Private aReturn   := {STR0002,1,STR0003,2,2,1,"",1} //"Zebrado"###"Administracao"
Private cTamanho  := "P"           // P/M/G
Private Limite    := 80            // 80/132/220
Private cTitulo   := STR0001
Private cNomeProg := "VEICR590"
Private cNomeRel  := "VEICR590"
Private nLastKey  := 0
Private nCaracter := 18
Private cPerg     := "VCR590"
cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
If nLastKey == 27
	Return
EndIf
Pergunte(cPerg,.f.)
RptStatus( { |lEnd| FS_IMPRIME(@lEnd,cNomeRel,cAlias) } , cTitulo )
If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf
MS_Flush()
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao   ³FS_IMPRIME³ Autor ³ Andre Luis Almeida ³ Data ³ 03/06/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao³ Impressao Analise CEV - Ano / Mes / Vendedor            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPRIME()
Local ni      := 0
Local nj      := 0
Local aImp    := {}
Local aImpA   := {}
Local cCli    := "INICIAL"
Local cMes    := "INICIAL"
Local lCli    := .f.
Local nPos    := 0
Local cIndex  := ""
Local nIndex  := 0
Local dDtIni  := ctod("01/01/"+substr(MV_PAR01,3,2))
Local dDtFin  := ctod("31/12/"+substr(MV_PAR01,3,2))
Local nTot1   := 0
Local nTot2   := 0
Local nTot3   := 0
Local nTot4   := 0
Local nTTot1  := 0
Local nTTot2  := 0
Local nTTot3  := 0
Local nTTot4  := 0
Local cGruVei := left(Alltrim(GetNewPar("MV_GRUVEI","VEI"))+space(4),4)
Local cCodCli := ""
Local cLojCli := ""
Local lCEVOUT := ( VAI->(FieldPos("VAI_CEVOUT")) > 0 ) // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
If MV_PAR02 == 3
	cCabec1 := "<<< "+MV_PAR01+" >>>                 ----( 1 )--- ----( 2 )--- ----( 3 )---"
	cCabec2 := "            "+STR0004
Else
	cCabec1 := "<<< "+MV_PAR01+" >>>"+STR0004
	cCabec2 := ""
EndIf
M_PAG := 1
nLin  := 80
aPag  := 1
//
VAI->(DbSetOrder(4))
VAI->(DbSeek( xFilial("VAI") + __CUSERID ))
//
SetDefault(aReturn,cAlias)
Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer
nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter) + 1
DbSelectArea("VC1")
DbSetOrder(7)
DbSeek( xFilial("VC1") )
SetRegua(RecCount())
While !Eof() .and. xFilial("VC1") == VC1->VC1_FILIAL
	IncRegua()
	If Empty(VC1->VC1_DATVIS)
		DbSelectArea("VC1")
		DbSkip()
		Loop
	EndIf
	If strzero(Year(VC1->VC1_DATVIS),4) # MV_PAR01
		DbSelectArea("VC1")
		DbSkip()
		Loop
	EndIf
	If lCEVOUT .and. VAI->VAI_CEVOUT == "0"
		If VC1->VC1_CODVEN <> VAI->VAI_CODVEN
			DbSelectArea("VC1")
			DbSkip()
			Loop
		EndIf
	EndIf
	If cCli # ( VC1->VC1_CODCLI + VC1->VC1_LOJA )
		cCli := ( VC1->VC1_CODCLI + VC1->VC1_LOJA )
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek( xFilial("SA1") + VC1->VC1_CODCLI + VC1->VC1_LOJA )
		lCli := .t.
	Else
		lCli := .f.
	EndIf
	nPos := 0
	nPos := aScan(aImp,{|x| x[1] + x[2] == strzero(month(VC1->VC1_DATVIS),2) + VC1->VC1_CODVEN })
	If nPos == 0
		DbSelectArea("SA3")
		DbSetOrder(1)
		DbSeek( xFilial("SA3") + VC1->VC1_CODVEN )
		aAdd(aImp,{strzero(month(VC1->VC1_DATVIS),2),VC1->VC1_CODVEN,left(SA3->A3_NREDUZ,15),IIf(lCli,1,0),IIf(!lCli,1,0),0})
	Else
		If lCli
			aImp[nPos,4]++
		Else
			aImp[nPos,5]++
		EndIf
	EndIf
	If MV_PAR02 == 3 // Analitico
		aAdd(aImpA,{strzero(month(VC1->VC1_DATVIS),2),VC1->VC1_CODVEN,1,IIf(lCli,"(1) ","(2) ")+VC1->VC1_TIPAGE+" "+Transform(VC1->VC1_DATVIS,"@D")+" "+VC1->VC1_CODCLI+"-"+VC1->VC1_LOJA+" "+SA1->A1_NOME})
	EndIf
	DbSelectArea("VC1")
	DbSkip()
EndDo
DbSelectArea("VV0")
DbSetOrder(2)
DbSeek( xFilial("VV0") + "0" +  dtos(dDtIni) , .t. )
SetRegua(RecCount())
While !Eof() .and. VV0->VV0_FILIAL == xFilial("VV0") .and. ( VV0->VV0_DATMOV <= dDtFin ) .and. VV0->VV0_OPEMOV == "0"
	IncRegua()
	If ( VV0->VV0_SITNFI == "0" ) // NF Cancelada
		DbSelectArea("VV0")
		DbSkip()
		Loop
	EndIf
	If lCEVOUT .and. VAI->VAI_CEVOUT == "0"
		If VC1->VC1_CODVEN <> VV0->VV0_CODVEN
			DbSelectArea("VV0")
			DbSkip()
			Loop
		EndIf
	EndIf
	DbSelectArea("VVA")
	DbSetOrder(1)
	DbSeek( xFilial("VVA") + VV0->VV0_NUMTRA )
	DbSelectArea("SF4")
	DbSetOrder(1)
	DbSeek( xFilial("SF4") + VVA->VVA_CODTES )
	If SF4->F4_DUPLIC == "N"
		DbSelectArea("VV0")
		DbSkip()
		Loop
	EndIf
	DbSelectArea("VV1")
	DbSetOrder(2)
	DbSeek( xFilial("VV1") + VVA->VVA_CHASSI )
	If VV1->VV1_ESTVEI == "0" // Veiculos Novos
		If VV0->VV0_TIPFAT # "2" // Normal
			If Alltrim(SF4->F4_ATUATF) # "S"
				If Empty(VV0->VV0_NUMNFI)
					DbSelectArea("VV0")
					DbSkip()
					Loop
				EndIf
				FGX_VV1SB1("CHAINT", VV1->VV1_CHAINT , /* cMVMIL0010 */ , cGruVei )
				cCodCli := VV0->VV0_CODCLI
				cLojCli := VV0->VV0_LOJA
				// LEASING -> Cliente Banco //
				If VV0->VV0_CATVEN == "7" .and. !Empty(VV0->VV0_CLIALI+VV0->VV0_LOJALI)
					cCodCli := VV0->VV0_CLIALI
					cLojCli := VV0->VV0_LOJALI
				EndIf
				DbSelectArea( "SD2" )
				DbSetOrder(3)
				DbSeek( xFilial("SD2") + VV0->VV0_NUMNFI + VV0->VV0_SERNFI + cCodCli + cLojCli + SB1->B1_COD )
				If SD2->D2_TIPO # "N"
					DbSelectArea("VV0")
					DbSkip()
					Loop
				EndIf
				nPos := 0
				nPos := aScan(aImp,{|x| x[1] + x[2] == strzero(month(VV0->VV0_DATMOV),2) + VV0->VV0_CODVEN })
				If nPos == 0
					DbSelectArea("SA3")
					DbSetOrder(1)
					DbSeek( xFilial("SA3") + VV0->VV0_CODVEN )
					aAdd(aImp,{strzero(month(VV0->VV0_DATMOV),2),VV0->VV0_CODVEN,left(SA3->A3_NREDUZ,15),0,0,1})
				Else
					aImp[nPos,6]++
				EndIf
				If MV_PAR02 == 3 // Analitico
					aAdd(aImpA,{strzero(month(VV0->VV0_DATMOV),2),VV0->VV0_CODVEN,1,"(3) "+Transform(VV0->VV0_DATMOV,"@D")+" "+VVA->VVA_CHASSI})
				EndIf
			EndIf
		Else
			nPos := 0
			nPos := aScan(aImp,{|x| x[1] + x[2] == strzero(month(VV0->VV0_DATMOV),2) + VV0->VV0_CODVEN })
			If nPos == 0
				DbSelectArea("SA3")
				DbSetOrder(1)
				DbSeek( xFilial("SA3") + VV0->VV0_CODVEN )
				aAdd(aImp,{strzero(month(VV0->VV0_DATMOV),2),VV0->VV0_CODVEN,left(SA3->A3_NREDUZ,15),0,0,1})
			Else
				aImp[nPos,6]++
			EndIf
			If MV_PAR02 == 3 // Analitico
				aAdd(aImpA,{strzero(month(VV0->VV0_DATMOV),2),VV0->VV0_CODVEN,1,"(3) "+Transform(VV0->VV0_DATMOV,"@D")+" "+VVA->VVA_CHASSI})
			EndIf
		EndIf
	EndIf
	DbSelectArea("VV0")
	DbSkip()
EndDo
DbSelectArea("SF1")
DbSetOrder(1)
DbSeek( xFilial("SF1") )
SetRegua(RecCount())
While !Eof() .and. SF1->F1_FILIAL == xFilial("SF1")
	IncRegua()
	If ( SF1->F1_DTDIGIT < dDtIni ) .or. ( SF1->F1_DTDIGIT > dDtFin )
		DbSelectArea("SF1")
		Dbskip()
		Loop
	EndIf
	If SF1->F1_TIPO == "D"
		DbSelectArea("SD1")
		DbSetOrder(1)
		DbSeek( xFilial("SD1") + SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA )
		While !Eof() .and. SD1->D1_FILIAL == xFilial("SD1") .and. SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA == SD1->D1_DOC + SD1->D1_SERIE + SD1->D1_FORNECE + SD1->D1_LOJA
			DbSelectArea("SF4")
			DbSetOrder(1)
			DbSeek( xFilial("SF4") + SD1->D1_TES )
			If SF4->F4_ESTOQUE == "S"
				DbSelectArea("SF2")
				DbSetOrder(1)
				DbSeek( xFilial("SF2") + SD1->D1_NFORI + SD1->D1_SERIORI , .f. )
				If SF2->F2_PREFORI == GetNewPar("MV_PREFVEI","VEI")
					DbSelectArea("VV0")
					DbSetOrder(4)
					DbSeek( xFilial("VV0") + SF2->F2_DOC + SF2->F2_SERIE )
					If lCEVOUT .and. VAI->VAI_CEVOUT == "0"
						If VC1->VC1_CODVEN <> VV0->VV0_CODVEN
							DbSelectArea("SD1")
							Dbskip()
							Loop
						EndIf
					EndIf
					If VV0->VV0_OPEMOV == "0"
						DbSelectArea("VVA")
						DbSetOrder(1)
						DbSeek( xFilial("VVA") + VV0->VV0_NUMTRA )
						DbSelectArea("VV1")
						DbSetOrder(2)
						DbSeek( xFilial("VV1") + VVA->VVA_CHASSI )
						If VV1->VV1_ESTVEI == "0" // Veiculos Novos
							nPos := 0
							nPos := aScan(aImp,{|x| x[1] + x[2] == strzero(month(VV0->VV0_DATMOV),2) + VV0->VV0_CODVEN })
							If nPos == 0
								DbSelectArea("SA3")
								DbSetOrder(1)
								DbSeek( xFilial("SA3") + VV0->VV0_CODVEN )
								aAdd(aImp,{strzero(month(VV0->VV0_DATMOV),2),VV0->VV0_CODVEN,left(SA3->A3_NREDUZ,15),0,0,-1})
							Else
								aImp[nPos,6]--
							EndIf
							If MV_PAR02 == 3 // Analitico
								aAdd(aImpA,{strzero(month(VV0->VV0_DATMOV),2),VV0->VV0_CODVEN,-1,"(3) "+Transform(VV0->VV0_DATMOV,"@D")+" "+VVA->VVA_CHASSI})
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			DbSelectArea("SD1")
			DbSkip()
		EndDo
	EndIf
	DbSelectArea("SF1")
	Dbskip()
EndDo
aSort(aImp,1,,{|x,y| x[1]+x[2] < y[1]+y[2] })
aSort(aImpA,1,,{|x,y| x[1]+x[2]+x[4] < y[1]+y[2]+y[4] })
For ni := 1 to len(aImp)
	If aImp[ni,1] # cMes
		If nTot4 # 0
			If MV_PAR02 == 3 // Analitico
				nLin++
			EndIf
			@ nLin++, 000 pSay STR0006+"( "+cMes+" / "+MV_PAR01+" )  "+transform(nTot1,"@E 99999,999,999")+transform(nTot2,"@E 99999,999,999")+transform(nTot3,"@E 99999,999,999")+transform(nTot4,"@E 99999,999,999")
			nLin++
			nTot1 := 0
			nTot2 := 0
			nTot3 := 0
			nTot4 := 0
		EndIf
		If MV_PAR02 >= 2 // Sintetico ou Analitico
			If MV_PAR02 == 3 // Analitico
				nLin++
			EndIf
			If nLin >= 48
				nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter) + 1
			EndIf
			@ nLin++, 000 pSay "*** " + aImp[ni,1] + " - " + FG_CMONTH(ctod("01/"+aImp[ni,1]+"/"+substr(MV_PAR01,3,2))) + " " + MV_PAR01 + " ***"
		EndIf
		cMes := aImp[ni,1]
	EndIf
	If MV_PAR02 >= 2 // Sintetico ou Analitico
		If MV_PAR02 == 3 // Analitico
			nLin++
		EndIf
		If nLin >= 53
			nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter) + 1
		EndIf
		@ nLin++, 004 pSay aImp[ni,2]+" - "+aImp[ni,3]+transform(aImp[ni,4],"@E 99999,999,999")+transform(aImp[ni,5],"@E 99999,999,999")+transform(aImp[ni,6],"@E 99999,999,999")+transform(aImp[ni,4]+aImp[ni,5]+aImp[ni,6],"@E 99999,999,999")
		If MV_PAR02 == 3 // Analitico
			nPos := 0
			nPos := aScan(aImpA,{|x| x[1] + x[2] == aImp[ni,1] + aImp[ni,2] })
			If nPos > 0
				For nj := nPos to len(aImpA)
					If aImpA[nj,1]+aImpA[nj,2] # aImp[ni,1]+aImp[ni,2]
						Exit
					EndIf
					If nLin >= 58
						nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter) + 1
					EndIf
					@ nLin++, 007 pSay left(aImpA[nj,4]+space(60),60)+transform(aImpA[nj,3],"@EZ 99999,999,999")
				Next
			EndIf
		EndIf
	EndIf
	nTot1  += aImp[ni,4]
	nTot2  += aImp[ni,5]
	nTot3  += aImp[ni,6]
	nTot4  += ( aImp[ni,4] + aImp[ni,5] + aImp[ni,6] )
	nTTot1 += aImp[ni,4]
	nTTot2 += aImp[ni,5]
	nTTot3 += aImp[ni,6]
	nTTot4 += ( aImp[ni,4] + aImp[ni,5] + aImp[ni,6] )
Next
If nTot4 # 0
	If MV_PAR02 == 3 // Analitico
		nLin++
	EndIf
	@ nLin++, 000 pSay STR0006+"( "+cMes+" / "+MV_PAR01+" )  "+transform(nTot1,"@E 99999,999,999")+transform(nTot2,"@E 99999,999,999")+transform(nTot3,"@E 99999,999,999")+transform(nTot4,"@E 99999,999,999")
EndIf
If nTTot4 # 0
	nLin++
	nLin++
	@ nLin++, 000 pSay STR0007+MV_PAR01+transform(nTTot1,"@E 99999,999,999")+transform(nTTot2,"@E 99999,999,999")+transform(nTTot3,"@E 99999,999,999")+transform(nTTot4,"@E 99999,999,999")
EndIf
Set Printer to
Set Device to Screen
Return