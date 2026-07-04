/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 04     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "VEICR640.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao   ³ VEICR640 ³ Autor ³ Andre Luis Almeida ³ Data ³ 09/02/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao³ Analise: Visita CEV x Vendas                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR640()
Local aArea := GetArea()
Private cAlias     := "VC1"
Private cDesc1     := STR0001+" x "+STR0002
Private cDesc2     := ""
Private cDesc3     := ""
Private cCabec1    := ""
Private cCabec2    := ""
Private aReturn    := {STR0003,1,STR0004,2,2,1,"",1} //"Zebrado"###"Administracao"
Private cTamanho   := "M"           // P/M/G
Private Limite     := 132           // 80/132/220
Private cTitulo    := STR0001+" x "+STR0002
Private cNomeProg  := "VEICR640"
Private cNomeRel   := "VEICR640"
Private nLastKey   := 0
Private nCaracter  := 15
Private cPerg      := "VCR640"
cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
If nLastKey == 27
	Return
EndIf
Pergunte(cPerg,.f.)
RptStatus( { |lEnd| FS_IMPVCR640(@lEnd,cNomeRel,cAlias) } , cTitulo )
If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf
MS_Flush()
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao   ³FS_IMPVCR640³ Autor³Andre Luis Almeida ³ Data ³ 09/02/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao³ Impressao Analise Visita CEV x Vendas                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPVCR640()
Local ni := 0
Local nPos := 0
Local aTotal  := {}
Local aVended := {}
Local aVendas := {}
Local cVended := ""
Local cClient := ""
Local cGruVei := left(Alltrim(GetNewPar("MV_GRUVEI","VEI"))+space(4),4)
Local cCodCli := ""
Local cLojCli := ""
Local lCEVOUT := ( VAI->(FieldPos("VAI_CEVOUT")) > 0 ) // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
Local cQuery    := ""
Local cAliasSQL := "SQLSF2"
Local cPrefVei  := GetNewPar("MV_PREFVEI","VEI")
Local cPrefOfi  := GetNewPar("MV_PREFOFI","OFI")
Local cPrefBal  := GetNewPar("MV_PREFBAL","BAL")
cTitulo := STR0001+" ("+Transform(MV_PAR03,"@D")+STR0005+Transform(MV_PAR04,"@D")+") x "+STR0002+" ("+Transform(MV_PAR05,"@D")+STR0005+Transform(MV_PAR06,"@D")+")"
cCabec1 := STR0006+" "+STR0008
cCabec2 := STR0007+" "+STR0009
M_PAG := 1
nLin  := 132
aPag  := 1
SetDefault(aReturn,cAlias)
Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer
SetRegua(6)
IncRegua()
aAdd(aTotal,{ "" , STR0010 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
//
VAI->(DbSetOrder(4))
VAI->(DbSeek( xFilial("VAI") + __CUSERID ))
//
DbSelectArea("VC1")
DbSetOrder(5)
DbSeek( xFilial("VC1") + MV_PAR01 + dtos(MV_PAR03) , .t. )
While !Eof() .and. xFilial("VC1") == VC1->VC1_FILIAL .and. VC1->VC1_TIPAGE == MV_PAR01 .and. ( VC1->VC1_DATVIS >= MV_PAR03 .and. VC1->VC1_DATVIS <= MV_PAR04 )
	If Empty(MV_PAR02) .or. MV_PAR02 == VC1->VC1_CODVEN
		If lCEVOUT .and. VAI->VAI_CEVOUT == "0"
			If VC1->VC1_CODVEN <> VAI->VAI_CODVEN
				DbSelectArea("VC1")
				DbSkip()
				Loop
			EndIf
		EndIf	
		aTotal[1,3]++
		nPos := 0
		nPos := aScan(aVended,{|x| x[1] == VC1->VC1_CODVEN })
		If nPos == 0
			DbSelectArea("SA3")
			DbSetOrder(1)
			DbSeek( xFilial("SA3") + VC1->VC1_CODVEN )
			aAdd(aVended,{ VC1->VC1_CODVEN , SA3->A3_NOME , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
		Else
			aVended[nPos,3]++
		EndIf
		nPos := 0
		nPos := aScan(aVendas,{|x| x[1] + x[2] + x[15] == VC1->VC1_CODVEN + VC1->VC1_CODCLI + VC1->VC1_LOJA })
		If nPos == 0
			aAdd(aVendas,{ VC1->VC1_CODVEN , VC1->VC1_CODCLI , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , VC1->VC1_LOJA })
		Else
			aVendas[nPos,3]++
		EndIf
	EndIf
	DbSelectArea("VC1")
	DbSkip()
EndDo
IncRegua()
For ni := 1 to len(aVendas)
	//
	cQuery := "SELECT F2_PREFORI , F2_DOC , F2_SERIE "
	cQuery += "  FROM " + RetSqlName("SF2")
	cQuery += " WHERE F2_FILIAL = '"+xFilial("SF2")+"'"
	cQuery += "   AND F2_CLIENTE = '"+aVendas[ni,2]+"'"
	cQuery += "   AND F2_LOJA = '"+aVendas[ni,15]+"'"
	cQuery += "   AND F2_EMISSAO >= '"+dtos(MV_PAR05)+"'"
	cQuery += "   AND F2_EMISSAO <= '"+dtos(MV_PAR06)+"'"
	cQuery += "   AND F2_TIPO = 'N'"
	cQuery += "   AND F2_VEND1 = '"+aVendas[ni,1]+"'"
	cQuery += "   AND D_E_L_E_T_ = ' '"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSQL, .T., .T. )
	Do While !( cAliasSQL )->( Eof() )
		//
		nPos := 0
		nPos := aScan(aVended,{|x| x[1] == aVendas[ni,1] })
		If ( cAliasSQL )->( F2_PREFORI ) == cPrefBal
			aTotal[1,4]++
			aVendas[ni,4]++
			aVended[nPos,4]++
			DbSelectArea("SD2")
			DbSetOrder(3)
			DbSeek( xFilial("SD2") + ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE ) )
			While !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SD2->D2_DOC + SD2->D2_SERIE == ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE )
				If	SD2->D2_VALISS > 0
					DbSelectArea("SD2")
					Dbskip()
					Loop
				EndIf
				DbSelectArea("SF4")
				DbSetOrder(1)
				DbSeek( xFilial("SF4") + SD2->D2_TES )
				If SF4->F4_DUPLIC == "N"
					DbSelectArea("SD2")
					Dbskip()
					Loop
				EndIf
				aTotal[1,5]    += SD2->D2_TOTAL
				aVendas[ni,5]  += SD2->D2_TOTAL
				aVended[nPos,5]+= SD2->D2_TOTAL
				DbSelectArea("VEC")
				DbSetOrder(4)
				DbSeek( xFilial("VEC") + SD2->D2_DOC + SD2->D2_SERIE )
				While !Eof() .and. VEC->VEC_FILIAL == xFilial("VEC") .and. VEC->VEC_NUMNFI + VEC->VEC_SERNFI == SD2->D2_DOC + SD2->D2_SERIE
					If VEC->VEC_PECINT == SD2->D2_COD
						aTotal[1,6]    += VEC->VEC_LUCBRU
						aVendas[ni,6]  += VEC->VEC_LUCBRU
						aVended[nPos,6]+= VEC->VEC_LUCBRU
						cConfere := ( VEC->VEC_NUMNFI + VEC->VEC_SERNFI + VEC->VEC_GRUITE + VEC->VEC_CODITE )
						DbSelectArea("VEC")
						Dbskip()
						If ( cConfere == ( VEC->VEC_NUMNFI + VEC->VEC_SERNFI + VEC->VEC_GRUITE + VEC->VEC_CODITE ) )
							DbSelectArea("VEC")
							Loop
						EndIf
						DbSelectArea("VEC")
						Dbskip(-1)
					EndIf
					DbSelectArea("VEC")
					DbSkip()
				EndDo
				DbSelectArea("SD2")
				DbSkip()
			EndDo
		ElseIf ( cAliasSQL )->( F2_PREFORI ) == cPrefOfi
			aTotal[1,7]++
			aVendas[ni,7]++
			aVended[nPos,7]++
			DbSelectArea("SD2")
			DbSetOrder(3)
			DbSeek( xFilial("SD2") + ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE ) )
			While !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SD2->D2_DOC + SD2->D2_SERIE == ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE )
				DbSelectArea("SF4")
				DbSetOrder(1)
				DbSeek( xFilial("SF4") + SD2->D2_TES )
				aTotal[1,8]    += SD2->D2_TOTAL
				aVendas[ni,8]  += SD2->D2_TOTAL
				aVended[nPos,8]+= SD2->D2_TOTAL
				DbSelectArea("VEC")
				DbSetOrder(4)
				DbSeek( xFilial("VEC") + SD2->D2_DOC + SD2->D2_SERIE )
				While !Eof() .and. VEC->VEC_FILIAL == xFilial("VEC") .and. VEC->VEC_NUMNFI + VEC->VEC_SERNFI == SD2->D2_DOC + SD2->D2_SERIE
					If VEC->VEC_PECINT == SD2->D2_COD
						If SF4->F4_DUPLIC == "N"
							DbSelectArea("VOI")
							DbSetOrder(1)
							DbSeek( xFilial("VOI") + VEC->VEC_TIPTEM )
							If VOI->VOI_SITTPO # "3"
								DbSelectArea("VEC")
								Dbskip()
								Loop
							EndIf
						EndIf
						aTotal[1,9]    += VEC->VEC_LUCBRU
						aVendas[ni,9]  += VEC->VEC_LUCBRU
						aVended[nPos,9]+= VEC->VEC_LUCBRU
						cConfere := ( VEC->VEC_NUMNFI + VEC->VEC_SERNFI + VEC->VEC_GRUITE + VEC->VEC_CODITE )
						DbSelectArea("VEC")
						Dbskip()
						If ( cConfere == ( VEC->VEC_NUMNFI + VEC->VEC_SERNFI + VEC->VEC_GRUITE + VEC->VEC_CODITE ) )
							DbSelectArea("VEC")
							Loop
						EndIf
						DbSelectArea("VEC")
						Dbskip(-1)
					EndIf
					DbSelectArea("VEC")
					DbSkip()
				EndDo
				DbSelectArea("SD2")
				DbSkip()
			EndDo
			DbSelectArea("VSC")
			DbSetOrder(4)
			DbSeek( xFilial("VSC") + ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE ) )
			While !Eof() .and. VSC->VSC_FILIAL == xFilial("VSC") .and. VSC->VSC_NUMNFI + VSC->VSC_SERNFI == ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE )
				DbSelectArea("VOI")
				DbSetOrder(1)
				DbSeek( xFilial("VOI") + VSC->VSC_TIPTEM )
				If VOI->VOI_SITTPO # "3"
					aTotal[1,8]    += VSC->VSC_VALSER
					aVendas[ni,8]  += VSC->VSC_VALSER
					aVended[nPos,8]+= VSC->VSC_VALSER
				Else
					VO4->(DbGoTo(Val(VSC->VSC_RECVO4)))
					aTotal[1,8]    += VO4->VO4_VALINT
					aVendas[ni,8]  += VO4->VO4_VALINT
					aVended[nPos,8]+= VO4->VO4_VALINT
				EndIf
				aTotal[1,9]    += VSC->VSC_LUCBRU
				aVendas[ni,9]  += VSC->VSC_LUCBRU
				aVended[nPos,9]+= VSC->VSC_LUCBRU
				DbSelectArea("VSC")
				DbSkip()
			EndDo
		ElseIf ( cAliasSQL )->( F2_PREFORI ) == cPrefVei
			aTotal[1,10]++
			aVendas[ni,10]++
			aVended[nPos,10]++
			DbSelectArea("VV0")
			DbSetOrder(4)
			DbSeek( xFilial("VV0") + ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE ) )
			While !Eof() .and. VV0->VV0_FILIAL == xFilial("VV0") .and. VV0->VV0_NUMNFI + VV0->VV0_SERNFI == ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE )
				If ( VV0->VV0_SITNFI == "0" .or. VV0->VV0_OPEMOV # "0" ) // NF Cancelada
					DbSelectArea("VV0")
					DbSkip()
					Loop
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
				If VV0->VV0_TIPFAT # "2"
					If Empty(VV0->VV0_NUMNFI)
						DbSelectArea("VV0")
						DbSkip()
						Loop
					EndIf
					DbSelectArea("VV1")
					DbSetOrder(1)
					DbSeek( xFilial("VV1") + VVA->VVA_CHAINT )
					DbSelectArea("VV2")
					DbSetOrder(1)
					DbSeek( xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )

					FGX_VV1SB1("CHAINT", VV1->VV1_CHAINT , /* cMVMIL0010 */ , cGruVei )

					cCodCli := VV0->VV0_CODCLI
					cLojCli := VV0->VV0_LOJA
					// LEASING -> Cliente Banco //
					If VV0->VV0_CATVEN == "7" .and. !Empty(VV0->VV0_CLIALI+VV0->VV0_LOJALI)
						cCodCli := VV0->VV0_CLIALI
						cLojCli := VV0->VV0_LOJALI
					EndIf
					DbSelectArea("SD2")
					DbSetOrder(3)
					DbSeek( xFilial("SD2") + VV0->VV0_NUMNFI + VV0->VV0_SERNFI + cCodCli + cLojCli + SB1->B1_COD)
					If SD2->D2_TIPO # "N"
						DbSelectArea("VV0")
						DbSkip()
						Loop
					EndIf
					aTotal[1,11]    += SD2->D2_TOTAL
					aVendas[ni,11]  += SD2->D2_TOTAL
					aVended[nPos,11]+= SD2->D2_TOTAL
					aTotal[1,12]    += ( SD2->D2_TOTAL - ( SD2->D2_CUSTO1 + VVA->VVA_TOTIMP ) )
					aVendas[ni,12]  += ( SD2->D2_TOTAL - ( SD2->D2_CUSTO1 + VVA->VVA_TOTIMP ) )
					aVended[nPos,12]+= ( SD2->D2_TOTAL - ( SD2->D2_CUSTO1 + VVA->VVA_TOTIMP ) )
				Else // VV0->VV0_TIPFAT == "2" -> Faturamento Direto
					aTotal[1,11]    += VVA->VVA_FATTOT
					aVendas[ni,11]  += VVA->VVA_FATTOT
					aVended[nPos,11]+= VVA->VVA_FATTOT
					aTotal[1,12]    += VVA->VVA_LUCBRU
					aVendas[ni,12]  += VVA->VVA_LUCBRU
					aVended[nPos,12]+= VVA->VVA_LUCBRU
				EndIf
				DbSelectArea("VV0")
				DbSkip()
			EndDo
		Else
			aTotal[1,13]++
			aVendas[ni,13]++
			aVended[nPos,13]++
			DbSelectArea("SD2")
			DbSetOrder(3)
			DbSeek( xFilial("SD2") + ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE ) )
			While !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SD2->D2_DOC + SD2->D2_SERIE == ( cAliasSQL )->( F2_DOC ) + ( cAliasSQL )->( F2_SERIE )
				aTotal[1,14]    += SD2->D2_TOTAL
				aVendas[ni,14]  += SD2->D2_TOTAL
				aVended[nPos,14]+= SD2->D2_TOTAL
				DbSelectArea("SD2")
				DbSkip()
			EndDo
		EndIf
		//
		( cAliasSQL )->(DbSkip())
	EndDo
	( cAliasSQL )->( dbCloseArea() )
	//
Next
DbSelectArea("SF2")
IncRegua()
IncRegua()
nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)+1
@ nLin++, 000 pSay left(aTotal[1,2]+space(25),25)+Transform(aTotal[1,3],"@E 99999");
+Transform(aTotal[1,4],"@E 9999")+Transform(aTotal[1,5],"@E 99,999,999")+Transform(aTotal[1,6],"@E 9999,999");
+Transform(aTotal[1,7],"@E 9999")+Transform(aTotal[1,8],"@E 99,999,999")+Transform(aTotal[1,9],"@E 9999,999");
+Transform(aTotal[1,10],"@E 9999")+Transform(aTotal[1,11],"@E 99,999,999")+Transform(aTotal[1,12],"@E 9999,999");
+Transform(aTotal[1,13],"@E 9999")+Transform(aTotal[1,14],"@E 99,999,999");
+Transform(aTotal[1,4]+aTotal[1,7]+aTotal[1,10]+aTotal[1,13],"@E 9999");
+Transform(aTotal[1,5]+aTotal[1,8]+aTotal[1,11]+aTotal[1,14],"@E 99,999,999");
+Transform(aTotal[1,6]+aTotal[1,9]+aTotal[1,12],"@E 9999,999")
IncRegua()
cVended := "INICIAL"
cClient := "INICIAL"
aSort(aVendas,1,,{|x,y| x[1]+x[2]+x[15] < y[1]+y[2]+y[15] })
For ni := 1 to len(aVendas)
	If cVended # aVendas[ni,1]
		cVended := aVendas[ni,1]
		If nLin >= 55
			nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		EndIf
		nLin++
		nPos := 0
		nPos := aScan(aVended,{|x| x[1] == aVendas[ni,1] })
		@ nLin++, 000 pSay left(aVended[nPos,1]+" "+aVended[nPos,2]+space(25),25)+Transform(aVended[nPos,3],"@E 99999");
		+Transform(aVended[nPos,4],"@E 9999")+Transform(aVended[nPos,5],"@E 99,999,999")+Transform(aVended[nPos,6],"@E 9999,999");
		+Transform(aVended[nPos,7],"@E 9999")+Transform(aVended[nPos,8],"@E 99,999,999")+Transform(aVended[nPos,9],"@E 9999,999");
		+Transform(aVended[nPos,10],"@E 9999")+Transform(aVended[nPos,11],"@E 99,999,999")+Transform(aVended[nPos,12],"@E 9999,999");
		+Transform(aVended[nPos,13],"@E 9999")+Transform(aVended[nPos,14],"@E 99,999,999");
		+Transform(aVended[nPos,4]+aVended[nPos,7]+aVended[nPos,10]+aVended[nPos,13],"@E 9999");
		+Transform(aVended[nPos,5]+aVended[nPos,8]+aVended[nPos,11]+aVended[nPos,14],"@E 99,999,999");
		+Transform(aVended[nPos,6]+aVended[nPos,9]+aVended[nPos,12],"@E 9999,999")
	EndIf
	If cClient # aVendas[ni,2]+aVendas[ni,15]
		cClient := aVendas[ni,2]+aVendas[ni,15]
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek( xFilial("SA1") + aVendas[ni,2] + aVendas[ni,15] )
	EndIf
	If nLin >= 58
		nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter) + 1
	EndIf
	@ nLin++, 003 pSay left(aVendas[ni,2]+"-"+aVendas[ni,15]+" "+SA1->A1_NOME+space(23),23)+Transform(aVendas[ni,3],"@E 9999");
	+Transform(aVendas[ni,4],"@E 9999")+Transform(aVendas[ni,5],"@E 99,999,999")+Transform(aVendas[ni,6],"@E 9999,999");
	+Transform(aVendas[ni,7],"@E 9999")+Transform(aVendas[ni,8],"@E 99,999,999")+Transform(aVendas[ni,9],"@E 9999,999");
	+Transform(aVendas[ni,10],"@E 9999")+Transform(aVendas[ni,11],"@E 99,999,999")+Transform(aVendas[ni,12],"@E 9999,999");
	+Transform(aVendas[ni,13],"@E 9999")+Transform(aVendas[ni,14],"@E 99,999,999");
	+Transform(aVendas[ni,4]+aVendas[ni,7]+aVendas[ni,10]+aVendas[ni,13],"@E 9999");
	+Transform(aVendas[ni,5]+aVendas[ni,8]+aVendas[ni,11]+aVendas[ni,14],"@E 99,999,999");
	+Transform(aVendas[ni,6]+aVendas[ni,9]+aVendas[ni,12],"@E 9999,999")
Next
IncRegua()
Set Printer to
Set Device to Screen
Return