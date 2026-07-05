/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 15     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "Protheus.ch"
#Include "VEIVR230.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ VEIVR230 ³ Autor ³ Andre Luis Almeida    ³ Data ³ 23/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Movimento de Entrada e Saida de Veiculos                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEIVR230

Local cDesc1	 := STR0016 //Movimento de Entrada e Saida de Veiculos
Local cDesc2	 := ""
Local cDesc3	 := ""
Local cAlias	 := "SD1"
Private nLin 	 := 0
Private aReturn := { STR0017, 1,STR0018, 2, 2, 1, "",1 }  //Zebrado # Administracao
Private cTamanho:= "G"     	// P/M/G
Private Limite  := 220     	// 80/132/220
Private nCaracter:=15
Private aOrdem  := {}      	// Ordem do Relatorio
Private cTitulo := STR0016 	//Movimento de Entrada e Saida de Veiculos
Private cNomProg:= "VEIVR230"
Private cNomeRel:= "VEIVR230"
Private nLastKey:= 0
Private cPerg   := "OFR779"
Private cLivFol := " " 	//GetMv("MV_LIVFOL")
Private nLivro  := 0 	//val(substr(cLivFol,1,3))
Private nFolha  := 0 	//val(substr(cLivFol,4,4))
Private nNumFol := 0

ValidPerg(cPerg)

cPerg := left(cPerg+space(15),len(SX1->X1_GRUPO))

cLivFol := GetMv("MV_LIVFOL")
nLivro := val(substr(cLivFol,1,3))
nFolha := val(substr(cLivFol,4,4))

DbSelectArea("SX1")
DbSetOrder(1)
if DbSeek(cPerg+"03")
	RecLock("SX1",.f.)
	X1_CNT01 := Transform(nLivro,"999")
	MsUnlock()
endif

if DbSeek(cPerg+"04")
	RecLock("SX1",.f.)
	X1_CNT01 := Transform(nFolha,"9999")
	MsUnlock()
endif

cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,.t.,cTamanho)
If nLastKey == 27
	Return
EndIf

PERGUNTE(cPerg,.f.)
nLivro := MV_PAR03
nFolha := MV_PAR04

SetDefault(aReturn,cAlias)
RptStatus( { |lEnd| U_ImpVVR230(@lEnd,cNomeRel,cAlias) } , cTitulo )
If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ImpVVR230 | Autor ³ Andre Luis Almeida   ³ Data ³ 23/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Movimento de Entrada e Saida de Veiculos                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ImpVVR230(lEnd,wNRel,cAlias)
Local ni := 1
Local j:=1
Local cNomMOT2 := ""
Local cEndMOT2 := ""
Local cCidMot2 := ""
Local cGruVei  := left(GetNewPar("MV_GRUVEI","VEIC")+space(10),len(SB1->B1_GRUPO))
Local ii       := 0
Local lMostraVei := .f.
Local cQuery    := ""
Local aMovVV1   := {}
Local aSM0     := {}
Private aMov    := {} 	// Vetor de Movimentos no Estoque
Private aMovO   := {} 	// Vetor de Movimentos na Oficina
Private Li    := 220
Private m_Pag := 1
Private lAbortPrint := .f.
Private cabec1 := ""
Private cabec2 := ""

Private aVeics := {}
Private cQAlSD1 := "SQLSD1" // SD1
Private cQAlSD2 := "SQLSD2" // SD2
Private cQAlVO3 := "SQLVO3" // VO3
Private cQAlVO4 := "SQLVO4" // VO4
Private cQAlVV1 := "SQLVV1" // VV1

Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer

/////////
// SD1 //
/////////
cQuery := "SELECT DISTINCT SD1.D1_COD FROM "+RetSqlName("SD1")+" SD1 WHERE SD1.D1_FILIAL='"+xFilial("SD1")+"' AND "
cQuery += "SD1.D1_EMISSAO>='"+Dtos(MV_PAR01)+"' AND SD1.D1_EMISSAO<='"+Dtos(MV_PAR02)+"' AND "
cQuery += "SD1.D1_GRUPO='"+cGruVei+"' AND SD1.D1_TIPO IN ('N','B','D') AND SD1.D_E_L_E_T_=' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSD1 , .F., .T. )
While !( cQAlSD1 )->( Eof() )
	aAdd(aVeics,( cQAlSD1 )->( D1_COD ) )
	( cQAlSD1 )->( DbSkip() )
Enddo
( cQAlSD1 )->( DbCloseArea() )

/////////
// SD2 //
/////////
cQuery := "SELECT DISTINCT SD2.D2_COD FROM "+RetSqlName("SD2")+" SD2 WHERE SD2.D2_FILIAL='"+xFilial("SD2")+"' AND "
cQuery += "SD2.D2_EMISSAO>='"+Dtos(MV_PAR01)+"' AND SD2.D2_EMISSAO<='"+Dtos(MV_PAR02)+"' AND "
cQuery += "SD2.D2_GRUPO='"+cGruVei+"' AND SD2.D2_TIPO IN ('N','B','D') AND SD2.D_E_L_E_T_=' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSD2 , .F., .T. )
While !( cQAlSD2 )->( Eof() )
	If aScan(aVeics,( cQAlSD2 )->( D2_COD )) == 0
		aAdd(aVeics,( cQAlSD2 )->( D2_COD ) )
	EndIf
	( cQAlSD2 )->( DbSkip() )
Enddo
( cQAlSD2 )->( DbCloseArea() )

/////////
// VV1 //
/////////
cQuery := "SELECT DISTINCT SB1.B1_COD , VV1.VV1_CHASSI FROM "+RetSqlName("SB1")+" SB1 , "+RetSqlName("VV1")+" VV1 WHERE "
cQuery += "VV1.VV1_FILIAL='"+xFilial("VV1")+"' AND VV1.D_E_L_E_T_=' ' AND "
cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_GRUPO='"+cGruVei+"' AND SB1.B1_CODITE=VV1.VV1_CHAINT AND SB1.D_E_L_E_T_=' '"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVV1 , .F., .T. )
While !( cQAlVV1 )->( Eof() )
	If aScan(aVeics,( cQAlVV1 )->( B1_COD )) == 0
		aMovVV1 := FGX_VEIMOVS( ( cQAlVV1 )->( VV1_CHASSI ) , "SE" , ) // Retorna todas as movimentacoes do veiculo ( Entrada / Saida )
		// [1] - "E" ou "S" - Movimentacao de Entrada ou Saida
		// [2] - Filial da umtima movimentacao
		// [3] - TRACPA ou NUMTRA (dependendo do retorno [1]
		// [4] - Data da emissao (DTHEMI) ***CARACTERE*** AAMMDDHH:MM:SS
		// [5] - Operacao realizada na movimentacao (OPEMOV)
		// [6] - Data do Movimento  (Formato de DATA)
		// [7] - Codigo do Cliente/Fornecedor
		// [8] - Loja do Cliente/Fornecedor
		// [9] - Tip Fat. (0=Novo, 1=Usado, 2=Venda Fat. Direto )
		aSort(aMovVV1,,,{|x,y| x[4] < y[4] }) // Ordem cronologica
		lMostraVei := .f.
		For ii := 1 to len(aMovVV1)
			If aMovVV1[ii,6] > MV_PAR02
				Exit
			EndIf
			If aMovVV1[ii,1] == "E"
				If aMovVV1[ii,6] <= MV_PAR02 // Data menor ou igual a Data Final do Periodo
					lMostraVei := .t.
				Else
					lMostraVei := .f.
				EndIf
			ElseIf aMovVV1[ii,1] == "S"
				If aMovVV1[ii,6] >= MV_PAR01 // Data maior ou igual a Data Inicial do Periodo
					lMostraVei := .t.
				Else
					lMostraVei := .f.
				EndIf
			EndIf
		Next
		If lMostraVei
			aAdd(aVeics,( cQAlVV1 )->( B1_COD ) )
		EndIf
	EndIf
	( cQAlVV1 )->( DbSkip() )
Enddo
( cQAlVV1 )->( DbCloseArea() )

nTotV := Len(aVeics)
SetRegua((nTotV*2))

/////////
// SD1 //
/////////
SA1->(DbSetOrder(3))
aSM0 := FWArrFilAtu(cEmpAnt,cFilAnt) // Filial Origem (Filial logada)
SA1->(DbSeek(xFilial("SA1")+aSM0[18]))
SB1->(DbSetOrder(1))
For ii := 1 to nTotV
	IncRegua()
	cQuery := "SELECT SD1.D1_FORNECE , SD1.D1_LOJA , SD1.D1_DOC , SD1.D1_SERIE , "+ FGX_MILSNF("SD1", 3, "D1_SERIE") +" , SD1.D1_EMISSAO , SD1.D1_CF , VV1.VV1_CHASSI , VVF.VVF_DTHEMI "
	cQuery += "FROM "+RetSqlName("SD1")+" SD1 , "+RetSqlName("SB1")+" SB1 , "+RetSqlName("VV1")+" VV1 , "+RetSqlName("VVF")+" VVF WHERE "
	cQuery += "SD1.D1_FILIAL='"+xFilial("SD1")+"' AND SD1.D1_COD='"+aVeics[ii]+"' AND SD1.D1_GRUPO='"+cGruVei+"' AND SD1.D1_TIPO IN ('N','B','D') AND SD1.D_E_L_E_T_=' ' AND "
	cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_COD=SD1.D1_COD AND SB1.D_E_L_E_T_=' ' AND "
	cQuery += "VV1.VV1_FILIAL='"+xFilial("VV1")+"' AND VV1.VV1_CHAINT=SB1.B1_CODITE AND VV1.D_E_L_E_T_=' ' AND "
	cQuery += "VVF.VVF_FILIAL='"+xFilial("VVF")+"' AND VVF.VVF_CODFOR=SD1.D1_FORNECE AND VVF.VVF_LOJA=SD1.D1_LOJA AND VVF.VVF_NUMNFI=SD1.D1_DOC AND VVF.VVF_SERNFI=SD1.D1_SERIE AND VVF.D_E_L_E_T_=' ' "
	cQuery += "ORDER BY SD1.D1_DOC , SD1.D1_SERIE , SD1.D1_FORNECE , SD1.D1_LOJA "
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSD1 , .F., .T. )
	While !( cQAlSD1 )->( Eof() )
		If aScan(aMov,{|x| x[4]+x[14]+x[2] == ( cQAlSD1 )->( D1_DOC )+( cQAlSD1 )->( D1_SERIE )+"E"+( cQAlSD1 )->( D1_FORNECE )+( cQAlSD1 )->( D1_LOJA )}) == 0
			cHorEnt := subs(( cQAlSD1 )->( VVF_DTHEMI ),10,2)+subs(( cQAlSD1 )->( VVF_DTHEMI ),13,2)
			aAdd(aMov,{ stod(( cQAlSD1 )->( D1_EMISSAO )) , ( cQAlSD1 )->( D1_FORNECE )+( cQAlSD1 )->( D1_LOJA ) , ( cQAlSD1 )->( VV1_CHASSI ) , ( cQAlSD1 )->( D1_DOC )+( cQAlSD1 )->&( FGX_MILSNF("SD1", 3, "D1_SERIE") ) , "ESTOQUE",space(29),space(29),space(22),space(29),space(29),space(22),cHorEnt,( cQAlSD1 )->( D1_CF ),"E",SA1->A1_COD+SA1->A1_LOJA,""})
		Endif
		( cQAlSD1 )->( DbSkip() )
	Enddo
	( cQAlSD1 )->( DbCloseArea() )
Next

/////////
// SD2 //
/////////
SA2->(DbSetOrder(3))
SA2->(DbSeek(xFilial("SA2")+aSM0[6]))
For ii := 1 to nTotV
	IncRegua()
	cQuery := "SELECT SD2.D2_CLIENTE , SD2.D2_LOJA , SD2.D2_DOC , SD2.D2_SERIE , SD2."+FGX_MILSNF('SD2', 3, 'D2_SERIE')+" , SD2.D2_EMISSAO , SD2.D2_CF , VV1.VV1_CHASSI , VV0.VV0_DTHEMI "
	cQuery += "FROM "+RetSqlName("SD2")+" SD2 , "+RetSqlName("SB1")+" SB1 , "+RetSqlName("VV1")+" VV1 , "+RetSqlName("VV0")+" VV0 WHERE "
	cQuery += "SD2.D2_FILIAL='"+xFilial("SD2")+"' AND SD2.D2_COD='"+aVeics[ii]+"' AND SD2.D2_GRUPO='"+cGruVei+"' AND SD2.D2_TIPO IN ('N','B','D') AND SD2.D_E_L_E_T_=' ' AND "
	cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_COD=SD2.D2_COD AND SB1.D_E_L_E_T_=' ' AND "
	cQuery += "VV1.VV1_FILIAL='"+xFilial("VV1")+"' AND VV1.VV1_CHAINT=SB1.B1_CODITE AND VV1.D_E_L_E_T_=' ' AND "
	cQuery += "VV0.VV0_FILIAL='"+xFilial("VV0")+"' AND VV0.VV0_NUMNFI=SD2.D2_DOC AND VV0.VV0_SERNFI=SD2.D2_SERIE AND VV0.D_E_L_E_T_=' ' "
	cQuery += "ORDER BY SD2.D2_LOCAL , SD2.D2_NUMSEQ "
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSD2 , .F., .T. )
	While !( cQAlSD2 )->( Eof() )
		If aScan(aMov,{|x| x[4]+x[14] == ( cQAlSD2 )->( D2_DOC )+( cQAlSD2 )->( D2_SERIE )+"S"}) == 0
			cHorEnt := subs(( cQAlSD2 )->( VV0_DTHEMI ),10,2)+subs(( cQAlSD2 )->( VV0_DTHEMI ),13,2)
			aAdd(aMov,{ stod(( cQAlSD2 )->( D2_EMISSAO )) , ( cQAlSD2 )->( D2_CLIENTE )+( cQAlSD2 )->( D2_LOJA ) , ( cQAlSD2 )->( VV1_CHASSI ) , ( cQAlSD2 )->( D2_DOC )+( cQAlSD2 )->&( FGX_MILSNF('SD2', 3, 'D2_SERIE')  ) , "ESTOQUE",space(29),space(29),space(22),space(29),space(29),space(22),cHorEnt,( cQAlSD2 )->( D2_CF ),"S",SA2->A2_COD+SA2->A2_LOJA,""})
		Endif
		( cQAlSD2 )->( DbSkip() )
	Enddo
	( cQAlSD2 )->( DbCloseArea() )
Next

DbSelectArea("VO1")
DbSetOrder(5)
DbSeek( xFilial("VO1") + dtos(MV_PAR01) , .t. )
SetRegua(RecCount())
While !Eof() .and. VO1->VO1_FILIAL == xFilial("VO1") .and. VO1->VO1_DATABE <= MV_PAR02
	IncRegua()
	If VO1->VO1_STATUS # "C"
		cNomMOT := space(29)
		cEndMOT := space(29)
		cCidMot := space(22)
		cNomMOT2 := space(29)
		cEndMOT2 := space(29)
		cCidMot2 := space(22)
		aAdd(aMovO,{ VO1->VO1_DATABE , VO1->VO1_PROVEI + VO1->VO1_LOJPRO , VO1->VO1_CHASSI , VO1->VO1_NUMOSV , "OFICINA",space(29),space(29),space(22),space(29),space(29),space(22),STRZERO(VO1->VO1_HORABE,TAMSX3("VO1_HORABE")[1]),"Abertura","E","","","NO"})
		If VO1->VO1_STATUS == "F"
			cNumNfi := ""
			cSerNfi := ""
			DbSelectArea("VEC")
			DbSetOrder(5)
			if DbSeek( xFilial("VEC")+VO1->VO1_NUMOSV)
				cNumNfi := VEC->VEC_NUMNFI
				cSerNfi := VEC->VEC_SERNFI
			Endif
			if Empty(cNumNfi)
				dbSelectArea("VSC")
				dbSetOrder(1)
				if dbSeek(xFilial("VSC")+VO1->VO1_NUMOSV)
					cNumNfi := VSC->VSC_NUMNFI
					cSerNfi := VSC->VSC_SERNFI
				Endif
			Endif
			
			dbSelectArea("SD2")
			dbSetOrder(3)
			dbSeek(xFilial("SD2")+cNumNfi+cSerNfi)
			dbSelectArea("SF2")
			dbSetOrder(1)
			dbSeek(xFilial("SF2")+cNumNfi+cSerNfi)
			aAdd(aMovO,{ SD2->D2_EMISSAO , SD2->D2_CLIENTE + SD2->D2_LOJA , VO1->VO1_CHASSI , VO1->VO1_NUMOSV , "OFICINA",space(29),space(29),space(22),space(29),space(29),space(22),Left(SF2->F2_HORA,2)+Right(SF2->F2_HORA,2),"Saida "+SD2->D2_CF ,"S","",SD2->D2_DOC+ FGX_MILSNF("SD2", 2, "D2_SERIE") ,"NO"})
			
		Endif
	EndIf
	DbSelectArea("VO1")
	Dbskip()
EndDo

//
cQuery := "SELECT VO3.VO3_NUMOSV , VO3.VO3_NUMNFI, VO3.VO3_SERNFI FROM "+RetSqlName("VO3")+" VO3 WHERE VO3.VO3_FILIAL='"+xFilial("VO1")+"' AND "
cQuery += "VO3.VO3_DATFEC>='"+Dtos(Mv_Par01)+"' AND VO3.VO3_DATFEC<='"+Dtos(Mv_Par02)+"' AND VO3.VO3_DATCAN='"+space(8)+"' AND "
cQuery += "VO3.D_E_L_E_T_=' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVO3 , .F., .T. )

While !( cQAlVO3 )->( Eof() )
	If aScan(aMovO,{|x| x[4]+x[14] == ( cQAlVO3 )->( VO3_NUMOSV )+"E"}) == 0
		DbSelectArea("VO1")
		DbSetOrder(1)
		If DbSeek( xFilial("VO1") + ( cQAlVO3 )->( VO3_NUMOSV ) )
			aAdd(aMovO,{ VO1->VO1_DATABE , VO1->VO1_PROVEI + VO1->VO1_LOJPRO , VO1->VO1_CHASSI , VO1->VO1_NUMOSV , "OFICINA",space(29),space(29),space(22),space(29),space(29),space(22),STRZERO(VO1->VO1_HORABE,TAMSX3("VO1_HORABE")[1]),"Abertura","E","","","NO"})
		EndIf
	Endif
	If aScan(aMovO,{|x| x[4]+x[14] == ( cQAlVO3 )->( VO3_NUMOSV )+"S"}) == 0
		DbSelectArea("VO1")
		DbSetOrder(1)
		If DbSeek( xFilial("VO1") + ( cQAlVO3 )->( VO3_NUMOSV ) )
			dbSelectArea("SD2")
			dbSetOrder(3)
			If dbSeek(xFilial("SD2")+( cQAlVO3 )->( VO3_NUMNFI ) + ( cQAlVO3 )->( VO3_SERNFI ))
				dbSelectArea("SF2")
				dbSetOrder(1)
				If dbSeek(xFilial("SF2")+( cQAlVO3 )->( VO3_NUMNFI ) + ( cQAlVO3 )->( VO3_SERNFI ))
					aAdd(aMovO,{ SD2->D2_EMISSAO , SD2->D2_CLIENTE + SD2->D2_LOJA , VO1->VO1_CHASSI , VO1->VO1_NUMOSV , "OFICINA",space(29),space(29),space(22),space(29),space(29),space(22),Left(SF2->F2_HORA,2)+Right(SF2->F2_HORA,2),"Saida "+SD2->D2_CF ,"S","",SD2->D2_DOC+ FGX_MILSNF('SD2', 2, 'D2_SERIE') ,"NO"})
				EndIf
			EndIf
		EndIf
	Endif
	
	( cQAlVO3 )->( DbSkip() )
	
Enddo
( cQAlVO3 )->( DbCloseArea() )

//
cQuery := "SELECT VO4.VO4_NUMOSV , VO4.VO4_NUMNFI, VO4.VO4_SERNFI FROM "+RetSqlName("VO4")+" VO4 WHERE VO4.VO4_FILIAL='"+xFilial("VO1")+"' AND "
cQuery += "VO4.VO4_DATFEC>='"+Dtos(Mv_Par01)+"' AND VO4.VO4_DATFEC<='"+Dtos(Mv_Par02)+"' AND VO4.VO4_DATCAN='"+space(8)+"' AND "
cQuery += "VO4.D_E_L_E_T_=' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVO4 , .F., .T. )

While !( cQAlVO4 )->( Eof() )
	If aScan(aMovO,{|x| x[4]+x[14] == ( cQAlVO4 )->( VO4_NUMOSV )+"E"}) == 0
		DbSelectArea("VO1")
		DbSetOrder(1)
		If DbSeek( xFilial("VO1") + ( cQAlVO4 )->( VO4_NUMOSV ) )
			aAdd(aMovO,{ VO1->VO1_DATABE , VO1->VO1_PROVEI + VO1->VO1_LOJPRO , VO1->VO1_CHASSI , VO1->VO1_NUMOSV , "OFICINA",space(29),space(29),space(22),space(29),space(29),space(22),STRZERO(VO1->VO1_HORABE,TAMSX3("VO1_HORABE")[1]),"Abertura","E","","","NO"})
		Endif
	Endif
	If aScan(aMovO,{|x| x[4]+x[14] == ( cQAlVO4 )->( VO4_NUMOSV )+"S"}) == 0
		DbSelectArea("VO1")
		DbSetOrder(1)
		If DbSeek( xFilial("VO1") + ( cQAlVO4 )->( VO4_NUMOSV ) )
			dbSelectArea("SD2")
			dbSetOrder(3)
			If dbSeek(xFilial("SD2")+( cQAlVO4 )->( VO4_NUMNFI ) + ( cQAlVO4 )->( VO4_SERNFI ))
				dbSelectArea("SF2")
				dbSetOrder(1)
				If dbSeek(xFilial("SF2")+( cQAlVO4 )->( VO4_NUMNFI ) + ( cQAlVO4 )->( VO4_SERNFI ))
					aAdd(aMovO,{ SD2->D2_EMISSAO , SD2->D2_CLIENTE + SD2->D2_LOJA , VO1->VO1_CHASSI , VO1->VO1_NUMOSV , "OFICINA",space(29),space(29),space(22),space(29),space(29),space(22),Left(SF2->F2_HORA,2)+Right(SF2->F2_HORA,2),"Saida "+SD2->D2_CF ,"S","",SD2->D2_DOC+ FGX_MILSNF('SD2', 2, 'D2_SERIE') ,"NO"})
				EndIf
			Endif
		Endif
	Endif
	
	( cQAlVO4 )->( DbSkip() )
	
Enddo
( cQAlVO4 )->( DbCloseArea() )


// Impressao da Parte de Movimentacao de Estoque
aSort(aMov,1,,{|x,y| x[3]+dtos(x[1])+x[12] < y[3]+dtos(y[1])+y[12] })

//nLin := cabec(cTitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
nFolha++
@ nLin++, 05 pSay "Folha: "+Alltrim(str(nFolha))
nLin++
@ nLin++, 00 pSay Repl("-",220)
@ nLin++, 00 pSay space(90)+STR0019
@ nLin++, 00 pSay Repl("-",220)
nLin+=2

//For utilizado para zomar a quantidade de paginas do relatorio
nNumLin := 15
nNumFol := 2
For ni := 1 to len(aMov)
	If nNumLin >= 57
		nNumLin := 16
		nNumFol++
	EndIf
	nNumLin+=5
Next
nNumFol++

nFolAnt := nFolha

FS_IMPTERMO()
//nLin++
nLin := 1
@ nLin++ , 02 psay "         "+STR0001+"                "+STR0002+": "+Transform(nLivro,"999")+"   "+STR0003+": "+Transform(nFolha,"9999")//"R  E  G  I  S  T  R  O      D  O      M  O  V  I  M  E  N  T  O      E  N  T  R  A  D  A  S      E      S  A  I  D  A  S      D  E      V  E  I  C  U  L  O  S # "LIVRO # Folha
nLin++
nRecSM0 := SM0->(Recno())
DbSelectArea("SM0")
DbSetOrder(1)
DbSeek( aSM0[1] + aSM0[2] )
@ nLin++ , 02 psay space(5)+STR0004+": "+ aSM0[1] +" - "+aSM0[17]+space(5)+STR0005+": "+Alltrim(aSM0[2])+" - "+Alltrim(aSM0[7])+" - "+Alltrim(SM0->M0_ENDCOB)+" - "+Alltrim(SM0->M0_BAIRCOB)+" - "+Alltrim(SM0->M0_CIDCOB)+" "+Alltrim(SM0->M0_ESTCOB) //EMPRESA # FILIAL
@ nLin++ , 02 psay space(5)+STR0006+": "+SM0->M0_INSC+space(45)+STR0007+": "+Transform(MV_PAR01,"@D")+" "+STR0015+" "+Transform(MV_PAR02,"@D")+space(40)+ STR0008+": "+Transform(aSM0[18],X3PICTURE("A1_CGC")) //Insc.Estadual # Periodo #CNPJ
nLin++
@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
@ nLin++ , 02 psay STR0010
@ nLin++ , 02 psay STR0011
@ nLin++ , 02 psay STR0012
@ nLin++ , 02 psay STR0013
@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

cQuebra := "INICIAL"
For ni := 1 to len(aMov)
	cData := space(8)
	cHoraFim := space(5)
	cNom1 := space(29)
	cIde1 := space(22)
	cEnd1 := space(29)
	cCid1 := space(22)
	cNom2 := space(29)
	cIde2 := space(22)
	cEnd2 := space(29)
	cCid2 := space(22)
	cDoc  := left(aMov[ni,4]+space(12),12)
	If aMov[ni,5] == "OFICINA" .and. aMov[ni,14] == "S" // Saida
		cDoc  := left(aMov[ni,16]+space(12),12)
	Endif
	
	If aMov[ni,14] == "S" // Saida
		If aMov[ni,1] < MV_PAR01 .or. aMov[ni,1] > MV_PAR02
			Loop
		EndIf
		cData := Transform(aMov[ni,1],"@D")//Transform(SF2->F2_EMISSAO,"@D")
		cData := left(cData,6)+right(cData,2) // Data com 8 caracteres
		cHoraFim := Transform(aMov[ni,12],"@R 99:99")//Transform(SF2->F2_HORA,"@R 99:99")
		DbSelectArea("SA2")
		DbSetOrder(1)
		DbSeek( xFilial("SA2") + aMov[ni,15] )
		cNom1 := left(SA2->A2_NOME,29)
		cIde1 := left(SA2->A2_CGC+space(8),22)
		cEnd1 := left(SA2->A2_END,29)
		cCid1 := left(SA2->A2_MUN,22)
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek( xFilial("SA1") + aMov[ni,2] )
		cNom2 := left(SA1->A1_NOME,29)
		cIde2 := left(SA1->A1_CGC+space(8),22)
		cEnd2 := left(SA1->A1_END,29)
		cCid2 := left(SA1->A1_MUN,22)
	Else // Entrada
		DbSelectArea("SA2")
		DbSetOrder(1)
		DbSeek( xFilial("SA2") + aMov[ni,2] )
		cNom1 := left(SA2->A2_NOME,29)
		cIde1 := left(SA2->A2_CGC+space(8),22)
		cEnd1 := left(SA2->A2_END,29)
		cCid1 := left(SA2->A2_MUN,22)
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek( xFilial("SA1") + aMov[ni,15] )
		cNom2 := left(SA1->A1_NOME,29)
		cIde2 := left(SA1->A1_CGC+space(8),22)
		cEnd2 := left(SA1->A1_END,29)
		cCid2 := left(SA1->A1_MUN,22)
	EndIf
	If aMov[ni,5] == "OFICINA"
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek( xFilial("SA1") + aMov[ni,2] )
		cNom1 := left(SA1->A1_NOME,29)
		cIde1 := left(SA1->A1_CGC+space(8),22)
		cEnd1 := left(SA1->A1_END,29)
		cCid1 := left(SA1->A1_MUN,22)
		cNom2 := space(29)
		cIde2 := space(22)
		cEnd2 := space(29)
		cCid2 := space(22)
	EndIf
	DbSelectArea("VV1")
	DbSetOrder(2)
	DbSeek( xFilial("VV1") + aMov[ni,3] )
	DbSelectArea( "VV2" )
	DbSetOrder(1)
	DbSeek( xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
	DbSelectArea("VVE")
	DbSetOrder(1)
	DbSeek( xFilial("VVE") + VV2->VV2_ESPVEI )
	DbSelectArea("VVC")
	DbSetOrder(1)
	DbSeek( xFilial("VVC") + VV1->VV1_CODMAR + VV1->VV1_CORVEI )
	If nLin >= 57
		nFolha++
		nLin := 1//cabec(cTitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
		nLin++
		@ nLin++ , 02 psay "         "+STR0014+"                "+STR0002+": "+Transform(nLivro,"999")+"   "+STR0003+": "+Transform(nFolha,"9999")//"R  E  G  I  S  T  R  O      D  O      M  O  V  I  M  E  N  T  O      E  N  T  R  A  D  A  S      E      S  A  I  D  A  S      D  E      V  E  I  C  U  L  O  S" # LIVRO # FOLHA
		nLin++
		@ nLin++ , 02 psay space(5)+STR0004+": "+ aSM0[1] +" - "+aSM0[17]+space(5)+STR0005+": "+Alltrim(aSM0[2])+" - "+Alltrim(aSM0[7])+" - "+Alltrim(SM0->M0_ENDCOB)+" - "+Alltrim(SM0->M0_BAIRCOB)+" - "+Alltrim(SM0->M0_CIDCOB)+" "+Alltrim(SM0->M0_ESTCOB) //EMPRESA # FILIAL
		@ nLin++ , 02 psay space(5)+STR0006+": "+SM0->M0_INSC+space(45)+STR0007+": "+Transform(MV_PAR01,"@D")+" "+STR0015+" "+Transform(MV_PAR02,"@D")+space(40)+ STR0008+": "+Transform(aSM0[18],X3PICTURE("A1_CGC")) //Insc.Estadual # Periodo #CNPJ
		nLin++
		@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		@ nLin++ , 02 psay STR0010
		@ nLin++ , 02 psay STR0011
		@ nLin++ , 02 psay STR0012
		@ nLin++ , 02 psay STR0013
		@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	EndIf
	cDataAux := Transform(aMov[ni,1],"@D")
	cDataAux := left(cDataAux,6)+right(cDataAux,2) // Data com 8 caracteres
	If cQuebra <> aMov[ni,3]
		@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		@ nLin++ , 02 psay If(aMov[ni,14] == "E",cDataAux,Space(8))+"|"+cNom1+"|"+cIde1+"|"+VV1->VV1_CODMAR+"       "+Transform(VV1->VV1_FABMOD,"@R 9999/9999")+" |"+left(VVC->VVC_DESCRI,17)+"|"+left(VV1->VV1_CHASSI+space(25),25)+"|"+left(cDoc,9)+"|"+cNom2+"|"+cIde2+"|"+cData+"|"+If(!Empty(aMov[ni,4]).and.Alltrim(aMov[ni,5])=="OFICINA","OS "+aMov[ni,4],Space(8))
		@ nLin++ , 02 psay If(aMov[ni,14] == "E",Transform(aMov[ni,12],"@R 99:99")+Space(3),Space(8)) +"|"+cEnd1+"|"+left(cCid1+space(22),22)+"|"+left(VV2->VV2_DESMOD,20)+"|"+left(VVE->VVE_DESCRI,17)+"|"+left(Transform(VV1->VV1_PLAVEI,VV1->(x3Picture("VV1_PLAVEI")))+space(25),25)+"|"+substr(cDoc,10,3)+"      |"+cEnd2+"|"+ left(cCid2+space(22),22)+"| "+cHoraFim+"  |"+aMov[ni,13]+"  "
		cQuebra := aMov[ni,3]
	Else
		nLin++
		@ nLin++ , 02 psay If(aMov[ni,14] == "E",cDataAux,Space(8))+"|"+cNom1+"|"+cIde1+"|"+Space(10)+Space(9)+" |"+Space(17)+"|"+space(25)+"|"+left(cDoc,9)+"|"+cNom2+"|"+cIde2+"|"+cData+"|"+If(!Empty(aMov[ni,4]).and.Alltrim(aMov[ni,5])=="OFICINA","OS "+aMov[ni,4],Space(8))
		@ nLin++ , 02 psay If(aMov[ni,14] == "E",Transform(aMov[ni,12],"@R 99:99")+Space(3),Space(8)) +"|"+cEnd1+"|"+left(cCid1+space(22),22)+"|"+Space(20)+"|"+Space(17)+"|"+Space(25)+"|"+substr(cDoc,10,3)+"      |"+cEnd2+"|"+ left(cCid2+space(22),22)+"| "+cHoraFim+"  |"+aMov[ni,13]+"  "
	Endif
Next

nLin := 1
@ nLin++ , 02 psay "         "+STR0001+"                "+STR0002+": "+Transform(nLivro,"999")+"   "+STR0003+": "+Transform(nFolha,"9999")//"R  E  G  I  S  T  R  O      D  O      M  O  V  I  M  E  N  T  O      E  N  T  R  A  D  A  S      E      S  A  I  D  A  S      D  E      V  E  I  C  U  L  O  S # "LIVRO # Folha
nLin++
@ nLin++ , 02 psay space(5)+STR0004+": "+ aSM0[1] +" - "+aSM0[17]+space(5)+STR0005+": "+Alltrim(aSM0[2])+" - "+Alltrim(aSM0[7])+" - "+Alltrim(SM0->M0_ENDCOB)+" - "+Alltrim(SM0->M0_BAIRCOB)+" - "+Alltrim(SM0->M0_CIDCOB)+" "+Alltrim(SM0->M0_ESTCOB) //EMPRESA # FILIAL
@ nLin++ , 02 psay space(5)+STR0006+": "+SM0->M0_INSC+space(45)+STR0007+": "+Transform(MV_PAR01,"@D")+" "+STR0015+" "+Transform(MV_PAR02,"@D")+space(40)+ STR0008+": "+Transform(aSM0[18],X3PICTURE("A1_CGC")) //Insc.Estadual # Periodo #CNPJ
nLin++
@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
@ nLin++ , 02 psay STR0010
@ nLin++ , 02 psay STR0011
@ nLin++ , 02 psay STR0012
@ nLin++ , 02 psay STR0013
@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

////////////////////////////////////////////////////////
// Verifica quais OSs serao impressas (Entrada/Saida) //
////////////////////////////////////////////////////////
nj := 0
cQuebra := "INICIAL"
If len(aMovO) > 0 .and. aMovO[1,14] == "E"
	cQuebra := aMovO[1,14]+aMovO[1,3]
EndIf
aSort(aMovO,1,,{|x,y| x[14]+x[3]+x[4] < y[14]+y[3]+y[4] })
For ni := 1 to len(aMovO)
	If !Empty(aMovO[ni,4])
		lOk := .f.
		If aMovO[ni,14] == "E" // Entrada
			If ni == len(aMovO) // ultima linha do vetor
				lOk := .t.
			ElseIf (ni+1) <= len(aMovO)
				If aMovO[ni+1,14] == "S" // proxima linha do vetor e' Saida
					lOk := .t.
				Else
					If cQuebra <> aMovO[ni+1,14]+aMovO[ni+1,3] // proxima linha do vetor e' diferente da linha atual
						cQuebra := aMovO[ni+1,14]+aMovO[ni+1,3]
						lOk := .t.
					EndIf
				EndIf
			EndIf
			If lOk // imprimir linha do vetor
				aMovO[ni,17] := "OK" // Entrada
				nj := aScan(aMovO,{|x| x[14]+x[4] == "S"+aMovO[ni,4]})
				If nj > 0 .and. ( MV_PAR01 >= aMovO[nj,1] .and. aMovO[nj,1] <= MV_PAR02 )
					aMovO[nj,17] := "OK" // mostra a Saida correspondente
				EndIf
			EndIf
		Else // Saida
			If ni == len(aMovO)  // ultima linha do vetor
				lOk := .t.
			ElseIf (ni+1) <= len(aMovO)
				If aMovO[ni+1,14] == "E" // proxima linha do vetor e' Entrada
					lOk := .t.
				Else
					If cQuebra <> aMovO[ni+1,14]+aMovO[ni+1,3] // proxima linha do vetor e' diferente da linha atual
						cQuebra := aMovO[ni+1,14]+aMovO[ni+1,3]
						lOk := .t.
					EndIf
				EndIf
			EndIf
			If lOk // imprimir linha do vetor
				aMovO[ni,17] := "OK" // Saida
				nj := aScan(aMovO,{|x| x[14]+x[4] == "E"+aMovO[ni,4]})
				If nj > 0
					aMovO[nj,17] := "OK" // mostra a Entrada correspondente
				EndIf
			EndIf
		EndIf
	EndIf
Next

// Impressao da Parte de Movimentacao da Oficina
aSort(aMovO,1,,{|x,y| x[3]+x[4]+dtos(x[1])+x[12] < y[3]+y[4]+dtos(y[1])+y[12] })
cQuebra := "INICIAL"
For ni := 1 to len(aMovO)
	//	If aMovO[ni,13] == "Abertura" .and. Empty(aMovO[ni,4])
	If aMovO[ni,17] == "NO"
		Loop
	Endif
	
	cData := space(8)
	cHoraFim := space(5)
	cDoc  := left(aMovO[ni,4]+space(12),12)
	
	If aMovO[ni,14] == "S" // Saida
		cDoc  := left(aMovO[ni,16]+space(12),12)
		cData := Transform(aMovO[ni,1],"@D")//Transform(SF2->F2_EMISSAO,"@D")
		cData := left(cData,6)+right(cData,2) // Data com 8 caracteres
		cHoraFim := Transform(aMovO[ni,12],"@R 99:99")//Transform(SF2->F2_HORA,"@R 99:99")
		If aMovO[ni,1] < MV_PAR01 .or. aMovO[ni,1] > MV_PAR02
			Loop
		EndIf
	EndIf
	
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek( xFilial("SA1") + aMovO[ni,2] )
	cNom1 := left(SA1->A1_NOME,29)
	cIde1 := left(SA1->A1_CGC+space(8),22)
	cEnd1 := left(SA1->A1_END,29)
	cCid1 := left(SA1->A1_MUN,22)
	cNom2 := space(29)
	cIde2 := space(22)
	cEnd2 := space(29)
	cCid2 := space(22)
	
	DbSelectArea("VV1")
	DbSetOrder(2)
	DbSeek( xFilial("VV1") + aMovO[ni,3] )
	DbSelectArea( "VV2" )
	DbSetOrder(1)
	DbSeek( xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
	DbSelectArea("VVE")
	DbSetOrder(1)
	DbSeek( xFilial("VVE") + VV2->VV2_ESPVEI )
	DbSelectArea("VVC")
	DbSetOrder(1)
	DbSeek( xFilial("VVC") + VV1->VV1_CODMAR + VV1->VV1_CORVEI )
	If nLin >= 57
		nFolha++
		nLin := 1//cabec(cTitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
		nLin++
		@ nLin++ , 02 psay "         "+STR0014+"                "+STR0002+": "+Transform(nLivro,"999")+"   "+STR0003+": "+Transform(nFolha,"9999")//"R  E  G  I  S  T  R  O      D  O      M  O  V  I  M  E  N  T  O      E  N  T  R  A  D  A  S      E      S  A  I  D  A  S      D  E      V  E  I  C  U  L  O  S" # LIVRO # FOLHA
		nLin++
		@ nLin++ , 02 psay space(5)+STR0004+": "+ aSM0[1] +" - "+aSM0[17]+space(5)+STR0005+": "+Alltrim(aSM0[2])+" - "+Alltrim(aSM0[7])+" - "+Alltrim(SM0->M0_ENDCOB)+" - "+Alltrim(SM0->M0_BAIRCOB)+" - "+Alltrim(SM0->M0_CIDCOB)+" "+Alltrim(SM0->M0_ESTCOB) //EMPRESA # FILIAL
		@ nLin++ , 02 psay space(5)+STR0006+": "+SM0->M0_INSC+space(45)+STR0007+": "+Transform(MV_PAR01,"@D")+" "+STR0015+" "+Transform(MV_PAR02,"@D")+space(40)+ STR0008+": "+Transform(aSM0[18],X3PICTURE("A1_CGC")) //Insc.Estadual # Periodo #CNPJ
		nLin++
		@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		@ nLin++ , 02 psay STR0010
		@ nLin++ , 02 psay STR0011
		@ nLin++ , 02 psay STR0012
		@ nLin++ , 02 psay STR0013
		@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	EndIf
	cDataAux := Transform(aMovO[ni,1],"@D")
	cDataAux := left(cDataAux,6)+right(cDataAux,2) // Data com 8 caracteres
	If cQuebra <> aMovO[ni,3]
		@ nLin++ , 02 psay "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		@ nLin++ , 02 psay If(aMovO[ni,14] == "E",cDataAux,Space(8))+"|"+cNom1+"|"+cIde1+"|"+VV1->VV1_CODMAR+"       "+Transform(VV1->VV1_FABMOD,"@R 9999/9999")+" |"+left(VVC->VVC_DESCRI,17)+"|"+left(VV1->VV1_CHASSI+space(25),25)+"|"+left(cDoc,9)+"|"+cNom2+"|"+cIde2+"|"+cData+"|"+If(!Empty(aMovO[ni,4]).and.Alltrim(aMovO[ni,5])=="OFICINA","OS "+aMovO[ni,4],Space(8))
		@ nLin++ , 02 psay If(aMovO[ni,14] == "E",Transform(aMovO[ni,12],"@R 99:99")+Space(3),Space(8)) +"|"+cEnd1+"|"+left(cCid1+space(22),22)+"|"+left(VV2->VV2_DESMOD,20)+"|"+left(VVE->VVE_DESCRI,17)+"|"+left(Transform(VV1->VV1_PLAVEI,VV1->(x3Picture("VV1_PLAVEI")))+space(25),25)+"|"+substr(cDoc,10,3)+"      |"+cEnd2+"|"+ left(cCid2+space(22),22)+"| "+cHoraFim+"  |"+aMovO[ni,13]+"  "
		cQuebra := aMovO[ni,3]
	Else
		nLin++
		@ nLin++ , 02 psay If(aMovO[ni,14] == "E",cDataAux,Space(8))+"|"+cNom1+"|"+cIde1+"|"+Space(10)+Space(9)+" |"+Space(17)+"|"+space(25)+"|"+left(cDoc,9)+"|"+cNom2+"|"+cIde2+"|"+cData+"|"+If(!Empty(aMovO[ni,4]).and.Alltrim(aMovO[ni,5])=="OFICINA","OS "+aMovO[ni,4],Space(8))
		@ nLin++ , 02 psay If(aMovO[ni,14] == "E",Transform(aMovO[ni,12],"@R 99:99")+Space(3),Space(8)) +"|"+cEnd1+"|"+left(cCid1+space(22),22)+"|"+Space(20)+"|"+Space(17)+"|"+Space(25)+"|"+substr(cDoc,10,3)+"      |"+cEnd2+"|"+ left(cCid2+space(22),22)+"| "+cHoraFim+"  |"+aMovO[ni,13]+"  "
	Endif
Next
SM0->(DbGoTo(nRecSM0))

nLin := 1

@ nLin++, 05 pSay "Folha: "+Alltrim(str((nFolAnt+nNumFol)-1))
nLin++
@ nLin++, 00 pSay Repl("-",220)
@ nLin++, 00 pSay space(90)+STR0050
@ nLin++, 00 pSay Repl("-",220)
nLin+=2

FS_IMPTERMO()
If MV_PAR05 == 1
	cLivFol := Transform(nLivro,"999")+Transform(nFolha,"9999")
	PutMv("MV_LIVFOL",cLivFol)
EndIf

Ms_Flush()
Set Printer to
Set Device  to Screen

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ValidPerg | Autor ³ Andre Luis Almeida   ³ Data ³ 23/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Criacao das perguntes.						                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg(cPerg)
Local j:=0
Local i:=0
Local _sAlias := Alias()
Local aRegs := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := left(cPerg+space(15),len(SX1->X1_GRUPO))
aRegs:={}
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01",STR0052,STR0052,STR0052,"mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02",STR0053,STR0053,STR0053,"mv_ch2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03",STR0054,STR0054,STR0054,"mv_ch3","N",3,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04",STR0055,STR0055,STR0055,"mv_ch4","N",4,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05",STR0056,STR0056,STR0056,"mv_ch5","N",1,0,0,"C","","mv_par05",STR0070,"","","","",STR0051,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06",STR0057,STR0057,STR0057,"mv_ch6","C",30,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07",STR0058,STR0058,STR0058,"mv_ch7","C",30,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08",STR0059,STR0059,STR0059,"mv_ch8","C",40,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"09",STR0060,STR0060,STR0060,"mv_ch9","C",20,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"10",STR0061,STR0061,STR0061,"mv_chA","C",20,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11",STR0062,STR0062,STR0062,"mv_chB","C",14,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12",STR0063,STR0063,STR0063,"mv_chC","C",14,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13",STR0064,STR0064,STR0064,"mv_chD","C",30,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14",STR0065,STR0065,STR0065,"mv_chE","C",40,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15",STR0066,STR0066,STR0066,"mv_chF","C",14,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16",STR0067,STR0067,STR0067,"mv_chG","C",40,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17",STR0068,STR0068,STR0068,"mv_chH","C",14,0,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"18",STR0069,STR0069,STR0069,"mv_chI","C",14,0,0,"G","","mv_par18","","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	if !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.t.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
		dbCommit()
	Endif
Next
dbSelectArea(_sAlias)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FS_IMPTERMO| Autor ³ Andre Luis Almeida  ³ Data ³ 23/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao do termo.	    					                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPTERMO()

if ExistBlock("IMPTERMO")
	ExecBlock("IMPTERMO",.f.,.f.)
Else
	@ nLin++,05 pSay STR0020+" "+Alltrim(str(nNumFol))+" "+STR0021+" "+Alltrim(str(nFolha))+" "+STR0022+" "+Alltrim(str((nFolha+nNumFol)-1))+" "+STR0023+transform(mv_par01,"@D")+" "+STR0024+" "+transform(mv_par02,"@D")+" "+STR0025
	nFolha++
	@ nLin++,01 pSay STR0026
Endif

nLin+=2
@ nLin++, 05 pSay STR0027+" "+mv_par07
nLin++
@ nLin++, 05 pSay STR0028+" "+mv_par08
nLin++
@ nLin++, 05 pSay STR0029+" "+mv_par09
nLin++
@ nLin++, 05 pSay STR0030+" "+mv_par10
nLin++
@ nLin++, 05 pSay STR0031+" "+mv_par11
nLin++
@ nLin++, 05 pSay STR0032+" "+mv_par12
nLin++
@ nLin++, 05 pSay STR0033+" "+mv_par13
nLin+=3
if substr(dtoc(dDataBase),4,2) == "01"
	cMes := STR0035
Elseif substr(dtoc(dDataBase),4,2) == "02"
	cMes := STR0036
Elseif substr(dtoc(dDataBase),4,2) == "03"
	cMes := STR0037
Elseif substr(dtoc(dDataBase),4,2) == "04"
	cMes := STR0038
Elseif substr(dtoc(dDataBase),4,2) == "05"
	cMes := STR0039
Elseif substr(dtoc(dDataBase),4,2) == "06"
	cMes := STR0040
Elseif substr(dtoc(dDataBase),4,2) == "07"
	cMes := STR0041
Elseif substr(dtoc(dDataBase),4,2) == "08"
	cMes := STR0042
Elseif substr(dtoc(dDataBase),4,2) == "09"
	cMes := STR0043
Elseif substr(dtoc(dDataBase),4,2) == "10"
	cMes := STR0044
Elseif substr(dtoc(dDataBase),4,2) == "11"
	cMes := STR0045
Else
	cMes := STR0046
Endif
@ nLin++, 00 pSay space(90)+mv_par10+","+substr(dtoc(dDataBase),1,2)+STR0034+" "+cMes+" "+STR0047+substr(dtos(dDatabase),1,4)
nLin+=15
@ nLin++, 05 pSay Repl("-",50)+space(40)+Repl("-",50)
nLin++
@ nLin++, 15 pSay mv_par14+space(50)+mv_par16
@ nLin++, 15 pSay STR0048+space(84)+STR0049
@ nLin++, 15 pSay "CPF: "+mv_par15+space(71)+"CPF: "+mv_par17
@ nLin++, 15 pSay space(90)+"CRC: "+mv_par18

Return(.t.)

