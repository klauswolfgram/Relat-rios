/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 8      º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#include "Ofior500.ch"
#include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIOR500 ³ Autor ³ Thiago                ³ Data ³ 16/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Demonstrativo de Contrato/Acordo Manutencao                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR500

Local cAlias := "VO1"
Private nLin := 1
Private aPag := 1

//Variaveis padrao de relatorio
Private cDesc1       := STR0001
Private cCabec1      := STR0001
Private cCabec2      := ""
Private cDesc2       := ""
Private cDesc3       := ""
Private aReturn      := { STR0002, 1,STR0003, 2, 2, 1, "",1 }
Private cTamanho     := "G"           // P/M/G
Private Limite       := 220           // 80/132/220
Private cTitulo      := STR0004
Private cNomProg     := "OFIOR500"
Private cNomeRel     := "OFIOR500"
Private nLastKey     := 0
Private nCaracter    := 15
Private cPerg        := "OFI500"

//Variaveis da Pergunte
//MV_PAR01 = data inicial
//MV_PAR02 = data final
//MV_PAR03 = Tipo de Relatorio         1- Resumido           2- Sintetico         3- Analitico
//MV_PAR04 = Listar                    1- Apenas Acordo de Manutencao             2- Tudo(Acordo + Gar & Clientes)
//MV_PAR05 = Valores                   1- Valor de Custo     2- Valor de NF       3- Valor de Moeda Forte             4- Valor Atual
//MV_PAR06 = Tp Tpo p/MOB Publi-Srv
//MV_PAR07 = Formula para pecas
//MV_PAR08 = Tp Tpo p/MOB Publi-Pec
//MV_PAR09 = Cliente
//MV_PAR10 = Loja
//MV_PAR11 = Chassi

//ValidPerg()

cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)

If nLastKey == 27
	return
EndIf

Pergunte(cPerg,.F.)

SetDefault(aReturn,cAlias)

RptStatus({|lEnd| ImpOSInt(@lEnd,cNomeRel,cAlias)},cTitulo)

Return

*******************************************
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ImpOSInt ³ Autor ³ Thiago                ³ Data ³ 16/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Inpressao do relatorio						              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpOSInt(lEnd,wNRel,cAlias)

// Valor Media
Local nMedPredPad := 0, nMedPredTra := 0, nMedPredVal := 0, nMedPredPec := 0, nMedPrevPad := 0, nMedPrevTra := 0 ,;
nMedPrevVal := 0, nMedPrevPec := 0, nMedCorPad  := 0, nMedCorTra  := 0, nMedCorVal  := 0, nMedCorPec  := 0 ,;
nMedLubrif  := 0, nMedSrvTer  := 0, nMedGarPad  := 0, nMedGarTra  := 0, nMedGarVal  := 0, nMedGarPec  := 0 ,;
nMedGarSrv  := 0, nMedCliPad  := 0, nMedCliTra  := 0, nMedCliVal  := 0, nMedCliPec  := 0, nMedCliSrv  := 0 ,;
nMedOdomet  := 0, nMedTotal   := 0, nMedPgto    := 0, nMedKm      := 0

// Valor Maximo
Local nMaPredPad := 0, nMaPredTra := 0, nMaPredVal := 0, nMaPredPec := 0, nMaPrevPad := 0, nMaPrevTra := 0, nMaPrevVal := 0,;
nMaPrevPec := 0, nMaCorPad  := 0, nMaCorTra  := 0, nMaCorVal  := 0, nMaCorPec  := 0, nMaLubrif  := 0, nMaSrvTer  := 0,;
nMaGarPad  := 0, nMaGarTra  := 0, nMaGarVal  := 0, nMaGarPec  := 0, nMaGarSrv  := 0, nMaCliPad  := 0, nMaCliTra  := 0,;
nMaCliVal  := 0, nMaCliPec  := 0, nMaCliSrv  := 0, nMaOdomet  := 0, nMaTotal   := 0, nMaPgto    := 0, nMakM      := 0

// Valor Minimo
Local nMiPredPad := 99999999999, nMiPredTra := 99999999999, nMiPredVal := 99999999999, nMiPredPec := 99999999999 ,;
nMiPrevTra := 99999999999, nMiPrevVal := 99999999999, nMiPrevPec := 99999999999, nMiCorPad  := 99999999999 ,;
nMiCorTra  := 99999999999, nMiCorVal  := 99999999999, nMiCorPec  := 99999999999, nMiLubrif  := 99999999999 ,;
nMiSrvTer  := 99999999999, nMiGarPad  := 99999999999, nMiGarTra  := 99999999999, nMiGarVal  := 99999999999 ,;
nMiGarPec  := 99999999999, nMiGarSrv  := 99999999999, nMiCliPad  := 99999999999, nMiCliTra  := 99999999999 ,;
nMiCliVal  := 99999999999, nMiCliPec  := 99999999999, nMiCliSrv  := 99999999999, nMiOdomet  := 99999999999 ,;
nMiTotal   := 99999999999, nMiPgto    := 99999999999, nMiKm      := 99999999999, nMiPrevPad := 99999999999

Local nCGarPad  := 0, nCGarTra  := 0, nCGarVal  := 0, nCGarPec  := 0, nCGarSrv  := 0, nCCliPad  := 0, nCCliTra  := 0,;
nCCliVal  := 0, nCCliPec  := 0, nCCliSrv  := 0, nGarPar   := 0, nGarTra   := 0, nGarVal   := 0, nGarPec   := 0,;
nGarSrv   := 0, nCliPad   := 0, nCliPrev  := 0, nCliVal   := 0, nCliPec   := 0, nCliSrv   := 0, nTGarPad  := 0,;
nTGarTra  := 0, nTGarVal  := 0, nTGarPec  := 0, nTGarSrv  := 0, nTCliPad  := 0, nTCliPrev := 0, nTCliVal  := 0,;
nTCliPec  := 0, nTCliSrv  := 0

Local nValFor      := 0, nValForPec   := 0, nTPadPred    := 0, nTTraPred    := 0, nTValPred    := 0, nTPecPred    := 0,;
nTPadPrev    := 0, nTTraPrev    := 0, nTValPrev    := 0, nTPecPrev    := 0, nTPadCor     := 0, nTTraCor     := 0,;
nTValCor     := 0, nTPecCor     := 0, nTLubrif     := 0, nTSrvTerc    := 0, nTOdomet     := 0, nTTotal      := 0,;
nTPgto       := 0, nTKm         := 0

//Variaveis para Impressao do Valor do Custo
Local nCusVPred    := 0, nCusPPred    := 0, nCusVPrev    := 0, nCusPPrev    := 0, nCusVCor     := 0, nCusPCor     := 0,;
nCusLub      := 0, nCusSrvT     := 0, nHtrPred     := 0, nHpdPred     := 0, nHtrPrev     := 0, nHpdPrev     := 0,;
nHtrCor      := 0, nHpdCor      := 0, nHtrGar      := 0, nHpdGar      := 0, nHtrCli      := 0, nHpdCli      := 0

Local nPosTC := 0, x := 0, y := 0, z := 0
Local nOdometro := 0, nPgto := 0, nPos := 0, cCodCli := "", cCatAco := ""
Local lVF4Found := .f. , lFound := .F., aCodSer := {}
Local cQuery := ""
Local cQAlAux := "AliasAQL"

Private aCatAco := {}, aTotCat := {}, aTotCli := {}

M_PAG    := 1
nLin     := 80
aPag     := 1
clin     := 1

set print to &cNomeRel
set print on
set device to print
cNumOsv := ""
nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg,cTamanho,nCaracter)+1

@ nLin, 001 pSay STR0005
nLin++
@ nLin, 001 pSay STR0006
nLin++

SetRegua(VO1->(RecCount()))

DbSelectArea("VO1")
DbSetOrder(1)
DbSeek(xFilial("VO1") )

cQuery := "SELECT  VO1.R_E_C_N_O_ RECVO1 , VV1.R_E_C_N_O_ RECVV1 , VO5.R_E_C_N_O_ RECVO5 , SA1.R_E_C_N_O_ RECSA1 FROM "+RetSqlName("VO1")+" VO1 "
cQuery	+="LEFT JOIN "+ RetSqlName("VV1")+" VV1 ON ( VV1.VV1_FILIAL='"+xFilial("VV1")+"' AND VV1.VV1_CHAINT=VO1.VO1_CHAINT AND VV1.D_E_L_E_T_=' ') "
cQuery	+="LEFT JOIN "+ RetSqlName("VO5")+" VO5 ON ( VO5.VO5_FILIAL='"+xFilial("VO5")+"' AND VO5.VO5_CHAINT=VO1.VO1_CHAINT AND VO5.D_E_L_E_T_=' ') "
cQuery	+="LEFT JOIN "+ RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL='"+xFilial("SA1")+"' AND SA1.A1_COD=VV1.VV1_PROATU AND SA1.A1_LOJA=VV1.VV1_LJPATU AND SA1.D_E_L_E_T_=' ') "
//cQuery	+="LEFT JOIN "+ RetSqlName("VF4")+" VF4 ON ( VF4.VF4_FILIAL='"+xFilial("VF4")+"' AND VF4.VF4_NUMOSV=VO1.VO1_NUMOSV AND VF4.D_E_L_E_T_=' ') "
cQuery	+="WHERE  "
//  03/05/2010 - Caio
If !Empty(mv_par11)//chassi
	cQuery	+="( VV1.VV1_CHARED='" +mv_par11 +"' OR VV1.VV1_CHASSI='"+ mv_par11 +"' ) AND "
EndIF
cQuery	+="( (VO5.VO5_DATENT <= '"+ dtos(Mv_Par01) +"' AND VO5.VO5_DATSAI >= '"+ dtos(Mv_Par02) +"') OR "
cQuery  +="  (VO5.VO5_DATENT >= '"+ dtos(Mv_Par01) +"' AND VO5.VO5_DATENT <= '"+ dtos(Mv_Par02) +"' AND VO5.VO5_DATSAI >= '"+ dtos(Mv_Par02) +"' ) OR "
cQuery	+="  (VO5.VO5_DATSAI >= '"+ dtos(Mv_Par01) +"' AND VO5.VO5_DATSAI <= '"+ dtos(Mv_Par02) +"') ) AND "
If !Empty(mv_par09) .and. !Empty(mv_par10)//cliente/loja
	cQuery	+="SA1.A1_COD='"+ alltrim(mv_par09) +"' AND SA1.A1_LOJA='"+ alltrim(mv_par10) +"' AND "
EndIF
If !Empty(mv_par12) //Consultor
	cQuery	+="VO1.VO1_FUNABE='"+ alltrim(mv_par12) +"' AND "
EndIF
cQuery	+="VO1.VO1_FILIAL='"+xFilial("VO1")+"' AND VO1.D_E_L_E_T_=' '"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )

Do While !( cQAlAux )->( Eof() )
	
	DbSelectArea("SA1")
	DbGoTo((cQAlAux)->RECSA1)
	
	DbSelectArea("VO1")
	DbGoTo((cQAlAux)->RECVO1)
	
	DbSelectArea("VV1")
	DbGoTo((cQAlAux)->RECVV1)
	
	/*	DbSelectArea("VF4")
	DbGoTo((cQAlAux)->RECVF4)*/
	
	DbSelectArea("VO5")
	DbGoTo((cQAlAux)->RECVO5)
	
	/*
	//	03/05/2010 - Caio
	If !Empty(mv_par11)//chassi
	If mv_par11 <> VV1->VV1_CHARED
	if mv_par11 <> VV1->VV1_CHASSI
	DbSelectArea("VO1")
	DbSkip()
	Loop
	endif
	EndIf
	EndIf
	//
	*/
	
	//	DbSelectArea("VO5")
	//	DbGoTo(RECVO5)
	//DbSeek(xFilial("VO5")+VO1->VO1_CHAINT)
	
	// Manoel - 05/07/2007 - Problema levantado pelo Ze' Eduardo (RIbeirao)
	// O Veiculo era do acordo no periodo solicitado, mas nao e' atualmente.
	// Como estava na linha comentada abaixo ele so' listava os que eram do acordo no momento atual.
	// Entao fizemos a verificacao por periodo de Entrada e Saida do veiculo no acordo
	//	If VO5->VO5_VEIACO # "0"       && Veiculo do Acordo
	
	//	If (VO5->VO5_DATENT <= Mv_Par01 .and. VO5->VO5_DATSAI >= Mv_Par02) .or. ;
	//		(VO5->VO5_DATENT >= MV_PAR01 .and. VO5->VO5_DATENT <= MV_PAR02 .and. VO5->VO5_DATSAI >= Mv_Par02 )
	
	DbSelectArea("VF2")
	DbSetOrder(1)
	DbSeek(xFilial("VF2")+VV1->VV1_PROATU+VV1->VV1_LJPATU+VO5->VO5_CATACO)
	
	//		DbSelectArea("SA1")
	//		DbSetOrder(1)
	//		DbSeek(xFilial("SA1")+VV1->VV1_PROATU+VV1->VV1_LJPATU)
	
	/*
	//		03/05/2010 - Caio
	If !Empty(mv_par09) .and. !Empty(mv_par10)//cliente/loja
	If SA1->A1_COD + SA1->A1_LOJA <> mv_par09 + mv_par10
	DbSelectArea("VO1")
	DbSkip()
	Loop
	EndIf
	EndIf
	*/
	
	
	DbSelectArea("VF4")
	DbSetOrder(4)
	DbSeek( xFilial("VF4") + VO1->VO1_NUMOSV )
	
	lFound    := .f.
	lVF4Found := .f.
	If ( VF4->VF4_DATKIL >= MV_PAR01 .And. VF4->VF4_DATKIL <= MV_PAR02 )
		lVF4Found := .t.
	EndIf
	
	aCodSer := {}
	nValForPec   := 0
	nValFor      := 0
	
	nHtrPred     := 0
	nHpdPred     := 0
	nCusVPred    := 0
	nCusPPred    := 0
	nHtrPrev     := 0
	nHpdPrev     := 0
	nCusVPrev    := 0
	nCusPPrev    := 0
	nHtrCor      := 0
	nHpdCor      := 0
	nCusVCor     := 0
	nCusPCor     := 0
	nCusLub      := 0
	nCusSrvT     := 0
	nHtrGar      := 0
	nHpdGar      := 0
	nGarVal      := 0
	nGarPec      := 0
	nGarSrv      := 0
	nHtrCli      := 0
	nHpdCli      := 0
	nCliVal      := 0
	nCliPec      := 0
	nCliSrv      := 0
	
	DbSelectArea("VEC")
	DbSetOrder(5)
	DbSeek(xFilial("VEC")+VO1->VO1_NUMOSV)
	Do While !Eof() .And. VEC->VEC_FILIAL+VEC->VEC_NUMOSV == xFilial("VEC")+VO1->VO1_NUMOSV
		
		if !Empty(mv_par13)
			DbSelectArea( "VOO" )
			DbSetOrder(4)
			DbSeek( xFilial("VOO") + VEC->VEC_NUMNFI + VEC->VEC_SERNFI , .t. )
			cSeekSF2 := VEC->VEC_NUMNFI + VEC->VEC_SERNFI + VOO->VOO_FATPAR + VOO->VOO_LOJA
			DbSelectArea("SF2")
			DbSetOrder(1)
			DbSeek(xFilial("SF2")+cSeekSF2)
			if SF2->F2_VEND1 <> mv_par13
				dbSelectArea("SF2")
				dbSkip()
				Loop
			Endif
		Endif
		If ( lVF4Found .Or. ( VEC->VEC_DATVEN >= MV_PAR01 .And. VEC->VEC_DATVEN <= MV_PAR02 ) )
			
			lFound := .T.
			
			DbSelectArea("VOI")
			DbSetOrder(1)
			DbSeek(xFilial("VOI")+VEC->VEC_TIPTEM)
			
			if !empty(MV_PAR08)	// tp de tempo de Peca
				if VEC->VEC_TIPTEM <> Left(mv_par08,4)
					dbSelectArea("VEC")
					dbSkip()
					Loop
				Endif
/*/			else                  
//				dbSelectArea("VEC")
				dbSkip()
				Loop*/
			Endif
			
			DbSelectArea("SBM")
			DbSetOrder(1)
			DbSeek(xFilial("SBM")+VEC->VEC_GRUITE)
			
			DbSelectArea("SB1")
			DbSetOrder(7)
			DbSeek(xFilial("SB1")+VEC->VEC_GRUITE+VEC->VEC_CODITE)
			
			DbSelectArea("SB2")
			DbSetOrder(1)
			DbSeek(xFilial("SB2")+SB1->B1_COD+VOI->VOI_CODALM)
			
			DbSelectArea("SB5")
			DbSetOrder(1)
			DbSeek(xFilial("SB5")+SB1->B1_COD)
			
			DbSelectArea("VEG")
			DbSetOrder(2)
			lValid := .f.
			If !Empty(MV_PAR07)
				If DbSeek(xFilial("VEG")+"04"+strzero(val(MV_PAR07),6)) // 29/04/10 - Caio
					lValid := .t.
				EndIf
			EndIf
			
			If lValid
				nValForPec := ( VEC->VEC_QTDITE * &(VEG->VEG_FORMUL) )
			Else
				nValForPec := VEC->VEC_VALVDA
				If MV_PAR05 == 3
					nValForPec := ( VEC->VEC_QTDITE * FG_VALPEC(VEC->VEC_TIPTEM,,VEC->VEC_GRUITE,VEC->VEC_CODITE,,.f.,.t.) )
				EndIf
			EndIf
			
			If VOI->VOI_SITTPO == "3" .And. AllTrim(SBM->BM_TIPGRU) == "2" 	&& Lubrificante
				
				nCusLub += nValForPec
				
			Else
				
				If VOI->VOI_SITTPO == "1"		&& Cliente
					
					nCliPec += nValForPec
					
				ElseIf VOI->VOI_SITTPO == "3"		&& Interno
					
					If FS_SITUAC("P",VEC->VEC_GRUITE,VEC->VEC_CODITE) == "2"    && Preventiva
						
						nCusPPrev += nValForPec
						
					ElseIf FS_SITUAC("P",VEC->VEC_GRUITE,VEC->VEC_CODITE) == "3"		&& Corretiva
						
						nCusPCor += nValForPec
						
					EndIf
					
				ElseIf VOI->VOI_SITTPO $ "2/4"		&& Garantia
					
					nGarPec += nValForPec
					
				EndIf
				
			EndIf
			
		EndIf
		
		DbSelectArea("VEC")
		DbSkip()
		
	EndDo
	
	
	nOdometro := 0
	nPgto     := 0
	DbSelectArea("VSC")
	DbSetOrder(1)
	DbSeek(xFilial("VSC")+VO1->VO1_NUMOSV)
	
	Do While !Eof() .And. VSC->VSC_FILIAL+VSC->VSC_NUMOSV == xFilial("VSC")+VO1->VO1_NUMOSV
		
		if !Empty(mv_par13)
			DbSelectArea( "VOO" )
			DbSetOrder(4)
			DbSeek( xFilial("VOO") + VSC->VSC_NUMNFI + VSC->VSC_SERNFI , .t. )
			cSeekSF2 := VSC->VSC_NUMNFI + VSC->VSC_SERNFI + VOO->VOO_FATPAR + VOO->VOO_LOJA
			DbSelectArea("SF2")
			DbSetOrder(1)
			DbSeek(xFilial("SF2")+cSeekSF2)
			if SF2->F2_VEND1 <> mv_par13
				dbSelectArea("SF2")
				dbSkip()
				Loop
			Endif
		Endif
		If ( lVF4Found .Or. ( VSC->VSC_DATVEN >= MV_PAR01 .And. VSC->VSC_DATVEN <= MV_PAR02 ) )
			
			lFound := .T.
			
			DbSelectArea("VOI")
			DbSetOrder(1)
			DbSeek(xFilial("VOI")+VSC->VSC_TIPTEM)
			
			//				Manoel/Silvania - 05/11/2008 - Descobrimos que o Parametro MV_Par06 nao era tratado neste PRW
			//			   if VSC->VSC_TIPTEM <> "M   "
			//			   if !(VSC->VSC_TIPTEM $ Left(Mv_Par06,4)+".K   ")
			
			if !empty(MV_PAR06)	// tp de tempo de Srv
				if !(VSC->VSC_TIPTEM $ Left(mv_par06,4)+".K   " )
					dbSelectArea("VSC")
					dbSkip()
					Loop
				Endif
/*			else
				dbSelectArea("VSC")
				dbSkip()
				Loop*/
			Endif
			
			DbSelectArea("VOK")
			DbSetOrder(1)
			DbSeek( xFilial("VOK") + VSC->VSC_TIPSER )
			
			DbSelectArea("VO4")
			DbSetOrder(1)
			DbGoTo(Val(VSC->VSC_RECVO4))
			
			aCodSer := FG_CALVLSER( aCodSer , VSC->VSC_TIPTEM+VSC->VSC_TIPSER+VSC->VSC_CODSER , If(MV_PAR05==3,"A","F") )
			
			If VOI->VOI_SITTPO == "3"
				
				DbSelectArea("VO4")
				DbSetOrder(1)
				DbGoTo(Val(VSC->VSC_RECVO4))
				
				aCodSer[1] := VO4->VO4_VALINT
				
			EndIf
			
			If VOK->VOK_INCMOB == "2"  && Servico de terceiro
				
				If VOI->VOI_SITTPO == "3"
					nCusSrvT += aCodSer[1]   && Valor Srv
				Else
					nCliSrv  += aCodSer[1]   && Valor Srv
				Endif
				
			ElseIf VOI->VOI_TPOKLM == "1"			&& Acordo de manutencao
				
				nOdometro += VSC->VSC_KILROD
				nPgto     += aCodSer[1]
				
			Else
				
				If VOI->VOI_SITTPO == "1"					&& Cliente
					
					If aCodSer[6]  && se nao foi somado soma
						
						nHpdCli += aCodSer[2]   && tempo padrao
						
					EndIf
					
					nHtrCli  += aCodSer[5]   && tempo trabalhado
					nCliSrv  += aCodSer[1]   && Valor Srv
					nCliVal  += aCodSer[1]   && Valor Srv
					
				ElseIf VOI->VOI_SITTPO $ "3" 				&& Interno
					
					If FS_SITUAC("S",,,VSC->VSC_CODSER) == "2"    && Preventiva
						
						If aCodSer[6]  && se nao foi somado soma
							
							nHpdPrev += aCodSer[2]   && tempo padrao
							
						EndIf
						
						nHtrPrev  += aCodSer[5]   && tempo trabalhado
						nCusVPrev += aCodSer[1]   && Valor Srv
						
					ElseIf FS_SITUAC("S",,,VSC->VSC_CODSER) == "3"		&& Corretiva
						
						If aCodSer[6]  && se nao foi somado soma
							
							nHpdCor += aCodSer[2]   && tempo padrao
							
						EndIf
						
						nHtrCor  += aCodSer[5]   && tempo trabalhado
						nCusVCor += aCodSer[1]   && Valor Srv
						
					EndIf
					
				ElseIf VOI->VOI_SITTPO $ "2/4"		&& Garantia
					
					If aCodSer[6]  && se nao foi somado soma
						
						nHpdGar += aCodSer[2]   && tempo padrao
						
					EndIf
					
					nHtrGar  += aCodSer[5]   && tempo trabalhado
					nGarSrv  += aCodSer[1]   && Valor Srv
					nGarVal  += aCodSer[1]   && Valor Srv
					
				EndIf
				
			EndIf
			
		EndIf
		
		DbSelectArea("VSC")
		DbSkip()
		
	EndDo
	
	If ( lVF4Found .Or. lFound )
		
		If ( Len(aCatAco) == 0 .Or. ( nPos := Ascan(aCatAco, {|x| x[1] == VV1->VV1_CHASSI} ) ) == 0 )
			
			Aadd(aCatAco,{ VV1->VV1_CHASSI,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"","","","","",""} )
			nPos := Len(aCatAco)
			
		EndIf
		
		aCatAco[nPos,1]  := VV1->VV1_CHASSI
		aCatAco[nPos,2]  += nHpdPred     &&
		aCatAco[nPos,3]  += nHtrPred     &&
		aCatAco[nPos,4]  += nCusVPred    &&
		aCatAco[nPos,5]  += nCusPPred    &&
		aCatAco[nPos,6]  += nHpdPrev     &&
		aCatAco[nPos,7]  += nHtrPrev     &&
		aCatAco[nPos,8]  += nCusVPrev    &&
		aCatAco[nPos,9]  += nCusPPrev    &&
		aCatAco[nPos,10] += nHpdCor      &&
		aCatAco[nPos,11] += nHtrCor      &&
		aCatAco[nPos,12] += nCusVCor     &&
		aCatAco[nPos,13] += nCusPCor     &&
		aCatAco[nPos,14] += nCusLub      &&
		aCatAco[nPos,15] += nCusSrvT     &&
		aCatAco[nPos,16] += nHpdGar      &&
		aCatAco[nPos,17] += nHtrGar      &&
		aCatAco[nPos,18] += nGarVal      &&
		aCatAco[nPos,19] += nGarPec      &&
		aCatAco[nPos,20] += nGarSrv      &&
		aCatAco[nPos,21] += nHpdCli      &&
		aCatAco[nPos,22] += nHtrCli      &&
		aCatAco[nPos,23] += nCliVal      &&
		aCatAco[nPos,24] += nCliPec      &&
		aCatAco[nPos,25] += nCliSrv      &&
		
		aCatAco[nPos,26] += nOdometro
		aCatAco[nPos,28] += nPgto
		
		aCatAco[nPos,27] := (( aCatAco[nPos,4] + aCatAco[nPos,5] ) + ( aCatAco[nPos,8] + aCatAco[nPos,9] ) + ( aCatAco[nPos,12] + aCatAco[nPos,13] ) + aCatAco[nPos,14] + aCatAco[nPos,15] )
		aCatAco[nPos,29] := ( aCatAco[nPos,28] / aCatAco[nPos,26] )
		aCatAco[nPos,30] := VO1->VO1_CHAINT
		aCatAco[nPos,31] := VF2->VF2_CATACO
		aCatAco[nPos,32] := VF2->VF2_DESCAT
		aCatAco[nPos,33] := VF2->VF2_CODCLI
		aCatAco[nPos,34] := VF2->VF2_LOJA
		aCatAco[nPos,35] := SA1->A1_NOME
		
	EndIf
	
	//	EndIf
	
	IncRegua()
	( cQAlAux )->( DbSkip() )
	
EndDo

( cQAlAux )->( DbCloseArea() )
DbSelectArea("VO1")

For z := 1 to Len(aCatAco)
	
	// Valor Maximo
	If aCatAco[z,2] > nMaPredPad
		nMaPredPad := aCatAco[z,2]
	EndIf
	If aCatAco[z,3] > nMaPredTra
		nMaPredTra := aCatAco[z,3]
	EndIf
	If aCatAco[z,4] > nMaPredVal
		nMaPredVal := aCatAco[z,4]
	EndIf
	If aCatAco[z,5] > nMaPredPec
		nMaPredPec := aCatAco[z,5]
	EndIf
	If aCatAco[z,6] > nMaPrevPad
		nMaPrevPad := aCatAco[z,6]
	EndIf
	If aCatAco[z,7] > nMaPrevTra
		nMaPrevTra := aCatAco[z,7]
	EndIf
	If aCatAco[z,8] > nMaPrevVal
		nMaPrevVal := aCatAco[z,8]
	EndIf
	If aCatAco[z,9] > nMaPrevPec
		nMaPrevPec := aCatAco[z,9]
	EndIf
	If aCatAco[z,10] > nMaCorPad
		nMaCorPad := aCatAco[z,10]
	EndIf
	If aCatAco[z,11] > nMaCorTra
		nMaCorTra := aCatAco[z,11]
	EndIf
	If aCatAco[z,12] > nMaCorVal
		nMaCorVal := aCatAco[z,12]
	EndIf
	If aCatAco[z,13] > nMaCorPec
		nMaCorPec := aCatAco[z,13]
	EndIf
	If aCatAco[z,14] > nMaLubrif
		nMaLubrif := aCatAco[z,14]
	EndIf
	If aCatAco[z,15] > nMaSrvTer
		nMaSrvTer := aCatAco[z,15]
	EndIf
	If aCatAco[z,16] > nMaGarPad
		nMaGarPad := aCatAco[z,16]
	EndIf
	If aCatAco[z,17] > nMaGarTra
		nMaGarTra := aCatAco[z,17]
	EndIf
	If aCatAco[z,18] > nMaGarVal
		nMaGarVal := aCatAco[z,18]
	EndIf
	If aCatAco[z,19] > nMaGarPec
		nMaGarPec := aCatAco[z,19]
	EndIf
	If aCatAco[z,20] > nMaGarSrv
		nMaGarSrv := aCatAco[z,20]
	EndIf
	If aCatAco[z,21] > nMaCliPad
		nMaCliPad := aCatAco[z,21]
	EndIf
	If aCatAco[z,22] > nMaCliTra
		nMaCliTra := aCatAco[z,22]
	EndIf
	If aCatAco[z,23] > nMaCliVal
		nMaCliVal := aCatAco[z,23]
	EndIf
	If aCatAco[z,24] > nMaCliPec
		nMaCliPec := aCatAco[z,24]
	EndIf
	If aCatAco[z,25] > nMaCliSrv
		nMaCliSrv := aCatAco[z,25]
	EndIf
	If aCatAco[z,26] > nMaOdomet
		nMaOdomet := aCatAco[z,26]
	EndIf
	If aCatAco[z,27] > nMaTotal
		nMaTotal := aCatAco[z,27]
	EndIf
	If aCatAco[z,28] > nMaPgto
		nMapgto := aCatAco[z,28]
	EndIf
	If aCatAco[z,29] > nMaKM
		nMaKm := aCatAco[z,29]
	EndIf
	
	// Valor Minimo
	If aCatAco[z,2] < nMiPredPad
		nMiPredPad := aCatAco[z,2]
	EndIf
	If aCatAco[z,3] < nMiPredTra
		nMiPredTra := aCatAco[z,3]
	EndIf
	If aCatAco[z,4] < nMiPredVal
		nMiPredVal := aCatAco[z,4]
	EndIf
	If aCatAco[z,5] < nMiPredPec
		nMiPredPec := aCatAco[z,5]
	EndIf
	If aCatAco[z,6] < nMiPrevPad
		nMiPrevPad := aCatAco[z,6]
	EndIf
	If aCatAco[z,7] < nMiPrevTra
		nMiPrevTra := aCatAco[z,7]
	EndIf
	If aCatAco[z,8] < nMiPrevVal
		nMiPrevVal := aCatAco[z,8]
	EndIf
	If aCatAco[z,9] < nMiPrevPec
		nMiPrevPec := aCatAco[z,9]
	EndIf
	If aCatAco[z,10] < nMiCorPad
		nMiCorPad := aCatAco[z,10]
	EndIf
	If aCatAco[z,11] < nMiCorTra
		nMiCorTra := aCatAco[z,11]
	EndIf
	If aCatAco[z,12] < nMiCorVal
		nMiCorVal := aCatAco[z,12]
	EndIf
	If aCatAco[z,13] < nMiCorPec
		nMiCorPec := aCatAco[z,13]
	EndIf
	If aCatAco[z,14] < nMiLubrif
		nMiLubrif := aCatAco[z,14]
	EndIf
	If aCatAco[z,15] < nMiSrvTer
		nMiSrvTer := aCatAco[z,15]
	EndIf
	If aCatAco[z,16] < nMiGarPad
		nMiGarPad := aCatAco[z,16]
	EndIf
	If aCatAco[z,17] < nMiGarTra
		nMiGarTra := aCatAco[z,17]
	EndIf
	If aCatAco[z,18] < nMiGarVal
		nMiGarVal := aCatAco[z,18]
	EndIf
	If aCatAco[z,19] < nMiGarPec
		nMiGarPec := aCatAco[z,19]
	EndIf
	If aCatAco[z,20] < nMiGarSrv
		nMiGarSrv := aCatAco[z,20]
	EndIf
	If aCatAco[z,21] < nMiCliPad
		nMiCliPad := aCatAco[z,21]
	EndIf
	If aCatAco[z,22] < nMiCliTra
		nMiCliTra := aCatAco[z,22]
	EndIf
	If aCatAco[z,23] < nMiCliVal
		nMiCliVal := aCatAco[z,23]
	EndIf
	If aCatAco[z,24] < nMiCliPec
		nMiCliPec := aCatAco[z,24]
	EndIf
	If aCatAco[z,25] < nMiCliSrv
		nMiCliSrv := aCatAco[z,25]
	EndIf
	If aCatAco[z,26] < nMiOdomet
		nMiOdomet := aCatAco[z,26]
	EndIf
	If aCatAco[z,27] < nMiTotal
		nMiTotal := aCatAco[z,27]
	EndIf
	If aCatAco[z,28] < nMiPgto
		nMiPgto := aCatAco[z,28]
	EndIf
	If aCatAco[z,29] < nMiKm
		nMiKm := aCatAco[z,29]
	EndIf
Next

// Zera Valor Minimo
If Len(aCatAco) == 0
	nMiPredPad := nMiPredTra := nMiPredVal := nMiPredPec := nMiPrevPad := nMiPrevTra := nMiPrevVal := nMiPrevPec := 0
	nMiCorPad  := nMiCorTra  := nMiCorVal  := nMiCorPec  := nMiLubrif  := nMiSrvTer  := nMiGarPad  := nMiGarTra  := 0
	nMiGarVal  := nMiGarPec  := nMiGarSrv  := nMiCliPad  := nMiCliTra  := nMiCliVal  := nMiCliPec  := nMiCliSrv  := 0
	nMiOdomet  := nMiTotal   := nMiPgto    := nMiKm      := 0
EndIf

&& Media
nMedPredPad += ( nMaPredPad+nMiPredPad ) / 2
nMedPredTra += ( nMaPredTra+nMiPredTra ) / 2
nMedPredVal += ( nMaPredVal+nMiPredVal ) / 2
nMedPredPec += ( nMaPredPec+nMiPredPec ) / 2
nMedPrevPad += ( nMaPrevPad+nMiPrevPad ) / 2
nMedPrevTra += ( nMaPrevTra+nMiPrevTra ) / 2
nMedPrevVal += ( nMaPrevVal+nMiPrevVal ) / 2
nMedPrevPec += ( nMaPrevPec+nMiPrevPec ) / 2
nMedCorPad  += ( nMaCorPad +nMiCorPad  ) / 2
nMedCorTra  += ( nMaCorTra +nMiCorTra  ) / 2
nMedCorVal  += ( nMaCorVal +nMiCorVal  ) / 2
nMedCorPec  += ( nMaCorPec +nMiCorPec  ) / 2
nMedLubrif  += ( nMaLubrif +nMiLubrif  ) / 2
nMedSrvTer  += ( nMaSrvTer +nMiSrvTer  ) / 2
nMedGarPad  += ( nMaGarPad +nMiGarPad  ) / 2
nMedGarTra  += ( nMaGarTra +nMiGarTra  ) / 2
nMedGarVal  += ( nMaGarVal +nMiGarVal  ) / 2
nMedGarPec  += ( nMaGarPec +nMiGarPec  ) / 2
nMedGarSrv  += ( nMaGarSrv +nMiGarSrv  ) / 2
nMedCliPad  += ( nMaCliPad +nMiCliPad  ) / 2
nMedCliTra  += ( nMaCliTra +nMiCliTra  ) / 2
nMedCliVal  += ( nMaCliVal +nMiCliVal  ) / 2
nMedCliPec  += ( nMaCliPec +nMiCliPec  ) / 2
nMedCliSrv  += ( nMaCliSrv +nMiCliSrv  ) / 2
nMedOdomet  += ( nMaOdomet +nMiOdomet  ) / 2
nMedTotal   += ( nMaTotal  +nMiTotal   ) / 2
nMedPgto    += ( nMaPgto   +nMiPgto    ) / 2
nMedKm      += ( nMakM     +nMiKm      ) / 2

aTotCat := {}
aTotCli := {}

// Indexa Array por ordem de Categoria do Acordo
If len(aCatAco) == 0
	Aadd(aCatAco,{ "",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"","","","","",""} )
EndIf
aSort(aCatAco,,,{|x,y| x[33]+x[34]+x[31] > y[33]+y[34]+y[31] })

cCatAco := aCatAco[1,31]
cCodCli := aCatAco[1,33]+aCatAco[1,34]

For x:=1 to Len(aCatAco)
	
	// Total Geral
	nTPadPred    += aCatAco[x,2]
	nTTraPred    += aCatAco[x,3]
	nTValPred    += aCatAco[x,4]
	nTPecPred    += aCatAco[x,5]
	nTPadPrev    += aCatAco[x,6]
	nTTraPrev    += aCatAco[x,7]
	nTValPrev    += aCatAco[x,8]
	nTPecPrev    += aCatAco[x,9]
	nTPadCor     += aCatAco[x,10]
	nTTraCor     += aCatAco[x,11]
	nTValCor     += aCatAco[x,12]
	nTPecCor     += aCatAco[x,13]
	nTLubrif     += aCatAco[x,14]
	nTSrvTerc    += aCatAco[x,15]
	nTGarPad     += aCatAco[x,16]
	nTGarTra     += aCatAco[x,17]
	nTGarVal     += aCatAco[x,18]
	nTGarPec     += aCatAco[x,19]
	nTGarSrv     += aCatAco[x,20]
	nTCliPad     += aCatAco[x,21]
	nTCliPrev    += aCatAco[x,22]
	nTCliVal     += aCataco[x,23]
	nTCliPec     += aCatAco[x,24]
	nTCliSrv     += aCatAco[x,25]
	nTOdomet     += aCatAco[x,26]
	nTTotal      += aCatAco[x,27]
	nTpgto       += aCatAco[x,28]
	nTKm         := ( nTpgto / nTOdomet )
	
	cCatAco := aCatAco[x,31]
	cCodCli := aCatAco[x,33]+aCatAco[x,34]
	
	aSort(aTotCli,,,{|x,y| x[1]+x[2] > y[1]+y[2] })
	nPos := Ascan(aTotCli,{|x| x[1]+x[2] == cCodCli})
	If nPos == 0
		aadd(aTotCli,{"","",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,""})
		nPos := Len(aTotCli)
	EndIf
	
	nPosTC := 3
	aTotCli[nPos,1]  := aCatAco[x,33]
	aTotCli[nPos,2]  := aCatAco[x,34]
	aTotCli[nPos,31] := aCatAco[x,35]
	For y:=2 to 29
		aTotCli[nPos,nPosTC] += aCatAco[x,y]
		nPosTC+=1
	Next
	aTotCli[nPos,30] := ( aTotCli[nPos,29]/aTotCli[nPos,27] )
	
	aSort(aTotCat,,,{|x,y| x[1]+x[2]+x[3] > y[1]+y[2]+y[3] })
	nPos := Ascan(aTotCat,{|x| x[1]+x[2]+x[3] == cCodCli+cCatAco})
	If nPos == 0
		aadd(aTotCat,{"","","","",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
		nPos := Len(aTotCat)
	EndIf
	
	nPosTC := 5
	aTotCat[nPos,1] := aCatAco[x,33]
	aTotCat[nPos,2] := aCatAco[x,34]
	aTotCat[nPos,3] := aCatAco[x,31]
	aTotCat[nPos,4] := aCatAco[x,32]
	For y:=2 to 29
		aTotCat[nPos,nPosTC] += aCatAco[x,y]
		nPosTC+=1
	Next
	aTotCat[nPos,32] := (aTotCat[nPos,31]/aTotCat[nPos,29])
	
Next

//                        -------------Preditiva -------------  -------------Preventiva-------------  ----------------Corretiva----------------"
//                        Padrao -Trabal -H.Valores -----Pecas  Padrao -Trabal -H.Valores -----Pecas  --Padrao- -Trabal-- -H.Valores -----Pecas  -Lubrifican   --Srv.Terc. ---Odometro -------Total Tot/Km --Pagamento Pag/Km"
//                       9999.99 9999.999999,999.999999,999.99 9999.99 9999.999999,999.999999,999.99  999999.99 999999.999999,999.999999,999.99  9999,999.99  9999,999.99  9999999999999,999,999.9999.999999999,999.9999.9999

// Impressao dos Valores Maximos
nLin++
@ nLin, 001 pSay space(16)+STR0007+" "+transform(nMaPredPad/100, "@E 9999.99")+" "+transform(nMaPredTra/100, "@E 9999.99")+transform(nMaPredVal, "@E 9999,999.99")+transform(nMaPredPec, "@E 9999,999.99")+" "+;
transform(nMaPrevPad/100, "@E 9999.99")+" "+transform(nMaPrevTra/100, "@E 9999.99")+transform(nMaPrevVal, "@E 9999,999.99")+transform(nMaPrevPec, "@E 9999,999.99")+"  "+;
transform(nMaCorPad/100, "@E 999999.99")+" "+transform(nMaCorTra/100, "@E 999999.99")+transform(nMaCorVal, "@E 9999,999.99")+transform(nMaCorPec, "@E 9999,999.99")+"  "+;
transform(nMaLubrif, "@E 9999,999.99")+"  "+transform(nMaSrvTer, "@E 9999,999.99")+"  "+transform(nMaOdomet, "99999999999")+transform(nMaTotal, "@E 99,999,999.99")+transform(nMaTotal/nMaOdomet, "@E 99.9999")+transform(nMaPgto, "@E 99999,999.99")+transform(nMaPgto/nMaOdomet, "@E 99.9999")

nLin++

// Impressao dos Valores da Media
@ nLin, 001 pSay space(16)+STR0008+"  "+transform(nMedPredPad/100, "@E 9999.99")+" "+transform(nMedPredTra/100, "@E 9999.99")+transform(nMedPredVal, "@E 9999,999.99")+transform(nMedPredPec, "@E 9999,999.99")+" "+;
transform(nMedPrevPad/100, "@E 9999.99")+" "+transform(nMedPrevTra/100, "@E 9999.99")+transform(nMedPrevVal, "@E 9999,999.99")+transform(nMedPrevPec, "@E 9999,999.99")+"  "+;
transform(nMedCorPad/100, "@E 999999.99")+" "+transform(nMedCorTra/100, "@E 999999.99")+transform(nMedCorVal, "@E 9999,999.99")+transform(nMedCorPec, "@E 9999,999.99")+"  "+;
transform(nMedLubrif, "@E 9999,999.99")+"  "+transform(nMedSrvTer, "@E 9999,999.99")+"  "+transform(nMedOdomet, "99999999999")+transform(nMedTotal, "@E 99,999,999.99")+transform(nMedTotal/nMedOdomet, "@E 99.9999")+transform(nMedPgto, "@E 99999,999.99")+transform(nMedPgto/nMedOdomet, "@E 99.9999")

nLin++

// Impressao dos Valores Minimos
@ nLin, 001 pSay space(16)+STR0009+" "+transform(nMiPredPad/100, "@E 9999.99")+" "+transform(nMiPredTra/100, "@E 9999.99")+transform(nMiPredVal, "@E 9999,999.99")+transform(nMiPredPec, "@E 9999,999.99")+" "+;
transform(nMiPrevPad/100, "@E 9999.99")+" "+transform(nMiPrevTra/100, "@E 9999.99")+transform(nMiPrevVal, "@E 9999,999.99")+transform(nMiPrevPec, "@E 9999,999.99")+"  "+;
transform(nMiCorPad/100, "@E 999999.99")+" "+transform(nMiCorTra/100, "@E 999999.99")+transform(nMiCorVal, "@E 9999,999.99")+transform(nMiCorPec, "@E 9999,999.99")+"  "+;
transform(nMiLubrif, "@E 9999,999.99")+"  "+transform(nMiSrvTer, "@E 9999,999.99")+"  "+transform(nMiOdomet, "99999999999")+transform(nMiTotal, "@E 99,999,999.99")+transform(nMiTotal/nMiOdomet, "@E 99.9999")+transform(nMiPgto, "@E 99999,999.99")+transform(nMiPgto/nMiOdomet, "@E 99.9999")

nLin+=3

@ nLin++, 001 pSay STR0010+space(12)+transform(nTPadPred/100, "@E 9999.99")+" "+transform(nTTraPred/100, "@E 9999.99")+transform(nTValPred, "@E 9999,999.99")+transform(nTPecPred, "@E 9999,999.99")+" "+;
transform(nTPadPrev/100, "@E 9999.99")+" "+transform(nTTraPrev/100, "@E 9999.99")+transform(nTValPrev, "@E 9999,999.99")+transform(nTPecPrev, "@E 9999,999.99")+"  "+;
transform(nTPadCor/100, "@E 999999.99")+" "+transform(nTTraCor/100, "@E 999999.99")+transform(nTValCor, "@E 9999,999.99")+transform(nTPecCor, "@E 9999,999.99")+"  "+;
transform(nTLubrif, "@E 9999,999.99")+"  "+transform(nTSrvTerc, "@E 9999,999.99")+"  "+transform(nTOdomet, "99999999999")+transform(nTTotal, "@E 99,999,999.99")+transform(nTTotal/nTOdomet, "@E 99.9999")+transform(nTPgto, "@E 99999,999.99")+transform(nTPgto/nTOdomet, "@E 99.9999")

aSort(aTotCli,,,{|x,y| x[1]+x[2] > y[1]+y[2] })
aSort(aTotCat,,,{|x,y| x[1]+x[2]+x[3] > y[1]+y[2]+y[3] })

SetRegua(Len(aTotCli)*2)

For x:=1 to Len(aTotCli)
	
	IncRegua()
	
	If nLin >= 55
		nLin := 1
		nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg, cTamanho,nCaracter)+1
		@ nLin, 001 pSay STR0005
		nLin++
		@ nLin, 001 pSay STR0006
		nLin++
	EndIf
	nLin++
	
	If ( !Empty(aTotCli[x,3]) .Or. !Empty(aTotCli[x,4]) .Or. !Empty(aTotCli[x,5]) .Or. !Empty(aTotCli[x,6]) .Or. !Empty(aTotCli[x,7]) .Or. !Empty(aTotCli[x,8]) .Or. !Empty(aTotCli[x,9]) .Or. !Empty(aTotCli[x,10]) .Or. !Empty(aTotCli[x,11]) .Or. !Empty(aTotCli[x,12]) ;
		.Or. !Empty(aTotCli[x,13]) .Or. !Empty(aTotCli[x,14]) .Or. !Empty(aTotCli[x,15]) .Or. !Empty(aTotCli[x,16]) .Or. !Empty(aTotCli[x,27]) .Or. !Empty(aTotCli[x,28]) .Or. !Empty(aTotCli[x,29]) .Or. !Empty(aTotCli[x,30]) )
		
		@ nLin++, 001 pSay substr(aTotCli[x,31],1,22)+" "+transform(aTotCli[x,3]/100, "@E 9999.99")+" "+transform(aTotCli[x,4]/100, "@E 9999.99")+transform(aTotCli[x,5], "@E 9999,999.99")+transform(aTotCli[x,6], "@E 9999,999.99")+" "+;
		transform(aTotCli[x,7]/100, "@E 9999.99")+" "+transform(aTotCli[x,8]/100, "@E 9999.99")+transform(aTotCli[x,9], "@E 9999,999.99")+transform(aTotCli[x,10], "@E 9999,999.99")+"  "+;
		transform(aTotCli[x,11]/100, "@E 999999.99")+" "+transform(aTotCli[x,12]/100, "@E 999999.99")+transform(aTotCli[x,13], "@E 9999,999.99")+transform(aTotCli[x,14], "@E 9999,999.99")+"  "+;
		transform(aTotCli[x,15], "@E 9999,999.99")+"  "+transform(aTotCli[x,16], "@E 9999,999.99")+"  "+transform(aTotCli[x,27], "99999999999")+transform(aTotCli[x,28], "@E 99,999,999.99")+transform(aTotCli[x,28]/aTotCli[x,27], "@E 99.9999")+transform(aTotCli[x,29], "@E 99999,999.99")+transform(aTotCli[x,29]/aTotCli[x,27], "@E 99.9999")
	EndIf
	
	nPos := Ascan(aTotCat,{|w| w[1]+w[2] == aTotCli[x,1]+aTotCli[x,2]})
	If nPos > 0
		
		For y:=1 to Len(aTotCat)
			
			If aTotCat[y,1]+aTotCat[y,2] == aTotCli[x,1]+aTotCli[x,2]
				
				If nLin >= 55
					nLin := 1
					nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg, cTamanho,nCaracter)+1
					@ nLin, 001 pSay STR0005
					nLin++
					@ nLin, 001 pSay STR0006
					nLin++
				EndIf
				
				If MV_PAR03 == 2 .or. MV_PAR03 == 3
					
					If ( !Empty(aTotCat[y,5]) .Or. !Empty(aTotCat[y,6]) .Or. !Empty(aTotCat[y,7]) .Or. !Empty(aTotCat[y,8]) .Or. !Empty(aTotCat[y,9]) .Or. !Empty(aTotCat[y,10]) .Or. !Empty(aTotCat[y,11]) .Or. !Empty(aTotCat[y,12]) .Or. !Empty(aTotCat[y,13]) ;
						.Or. !Empty(aTotCat[y,14]) .Or. !Empty(aTotCat[y,15]) .Or. !Empty(aTotCat[y,16]) .Or. !Empty(aTotCat[y,17]) .Or. !Empty(aTotCat[y,18]) .Or. !Empty(aTotCat[y,29]) .Or. !Empty(aTotCat[y,30]) .Or. !Empty(aTotCat[y,31]) .Or. !Empty(aTotCat[y,32]) )
						
						@ nLin++, 001 pSay aTotCat[y,3]+space(01)+Substr(aTotCat[y,4],1,18)+space(01)+transform(aTotCat[y,5]/100, "@E 9999.99")+" "+transform(aTotCat[y,6]/100, "@E 9999.99")+transform(aTotCat[y,7], "@E 9999,999.99")+transform(aTotCat[y,8], "@E 9999,999.99")+" "+;
						transform(aTotCat[y,9]/100, "@E 9999.99")+" "+transform(aTotCat[y,10]/100, "@E 9999.99")+transform(aTotCat[y,11], "@E 9999,999.99")+transform(aTotCat[y,12], "@E 9999,999.99")+"  "+;
						transform(aTotCat[y,13]/100, "@E 999999.99")+" "+transform(aTotCat[y,14]/100, "@E 999999.99")+transform(aTotCat[y,15], "@E 9999,999.99")+transform(aTotCat[y,16], "@E 9999,999.99")+"  "+;
						transform(aTotCat[y,17], "@E 9999,999.99")+"  "+transform(aTotCat[y,18], "@E 9999,999.99")+"  "+transform(aTotCat[y,29], "99999999999")+transform(aTotCat[y,30], "@E 99,999,999.99")+transform(aTotCat[y,30]/aTotCat[y,29], "@E 99.9999")+transform(aTotCat[y,31], "@E 99999,999.99")+transform(aTotCat[y,31]/aTotCat[y,29], "@E 99.9999")
					EndIf
					
				EndIf
				
				nPos := Ascan(aTotCat,{|w| w[1]+w[2] == aTotCli[x,1]+aTotCli[x,2]})
				If nPos > 0
					
					For z := 1 to Len(aCatAco)
						
						If aCatAco[z,33]+aCatAco[z,34]+aCatAco[z,31] == aTotCat[y,1]+aTotCat[y,2]+aTotCat[y,3]
							
							If MV_PAR03 == 3
								
								If nLin >= 55
									nLin := 1
									nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg, cTamanho,nCaracter)+1
									@ nLin, 001 pSay STR0005
									nLin++
									@ nLin, 001 pSay STR0006
									nLin++
								EndIf
								
								If ( !Empty(aCatAco[z,2]).Or. !Empty(aCatAco[z,3]).Or. !Empty(aCatAco[z,4]).Or. !Empty(aCatAco[z,5]).Or. !Empty(aCatAco[z,6]).Or. !Empty(aCatAco[z,7]).Or. !Empty(aCatAco[z,8]).Or. !Empty(aCatAco[z,9]).Or. !Empty(aCatAco[z,10]) ;
									.Or. !Empty(aCatAco[z,11]).Or. !Empty(aCatAco[z,12]).Or. !Empty(aCatAco[z,13]).Or. !Empty(aCatAco[z,14]).Or. !Empty(aCatAco[z,15]).Or. !Empty(aCatAco[z,26]).Or. !Empty(aCatAco[z,27]).Or. !Empty(aCatAco[z,28]).Or. !Empty(aCatAco[z,29]) )
									
									@ nLin++, 003 pSay substr(aCatAco[z,1],1,21)+transform(aCatAco[z,2]/100, "@E 9999.99")+" "+transform(aCatAco[z,3]/100, "@E 9999.99")+transform(aCatAco[z,4], "@E 9999,999.99")+transform(aCatAco[z,5], "@E 9999,999.99")+" "+;
									transform(aCatAco[z,6]/100, "@E 9999.99")+" "+transform(aCatAco[z,7]/100, "@E 9999.99")+transform(aCatAco[z,8], "@E 9999,999.99")+transform(aCatAco[z,9], "@E 9999,999.99")+"  "+;
									transform(aCatAco[z,10]/100, "@E 999999.99")+" "+transform(aCatAco[z,11]/100, "@E 999999.99")+transform(aCatAco[z,12], "@E 9999,999.99")+transform(aCatAco[z,13], "@E 9999,999.99")+"  "+;
									transform(aCatAco[z,14], "@E 9999,999.99")+"  "+transform(aCatAco[z,15], "@E 9999,999.99")+"  "+transform(aCatAco[z,26], "99999999999")+transform(aCatAco[z,27], "@E 99,999,999.99")+transform(aCatAco[z,27]/aCatAco[z,26], "@E 99.9999")+transform(aCatAco[z,28], "@E 99999,999.99")+transform(aCatAco[z,28]/aCatAco[z,26], "@E 99.9999")
								EndIf
								
							EndIf
							
						EndIf
						
					Next
					
				EndIf
				
			EndIf
			
		Next
		
	EndIf
	
Next

//Garantia / Cliente

nLin+=2
@ nLin, 001 pSay STR0011
nLin++
@ nLin, 001 pSay STR0012
nLin++

// Impressao dos Valores Maximos
nLin++
@ nLin, 001 pSay space(16)+STR0007+" "+transform(nMaGarPad/100, "@E 9999.99")+" "+transform(nMaGarTra/100, "@E 9999.99")+" "+transform(nMaGarVal, "@E 9999,999.99")+" "+transform(nMaGarPec, "@E 9999,999.99")+transform(nMaGarSrv, "@E 9999,999.99")+"  "+;
transform(nMaCliPad/100, "@E 9999.99")+" "+transform(nMaCliTra/100, "@E 9999.99")+" "+transform(nMaCliVal, "@E 9999,999.99")+space(1)+transform(nMaCliPec, "@E 9999,999.99")+" "+transform(nMaCliSrv, "@E 9999,999.99")

nLin++

// Impressao dos Valores da Media
@ nLin, 001 pSay space(16)+STR0008+"  "+transform(nMedGarPad/100, "@E 9999.99")+" "+transform(nMedGarTra/100, "@E 9999.99")+" "+transform(nMedGarVal, "@E 9999,999.99")+" "+transform(nMedGarPec, "@E 9999,999.99")+transform(nMedGarSrv, "@E 9999,999.99")+"  "+;
transform(nMedCliPad/100, "@E 9999.99")+" "+transform(nMedCliTra/100, "@E 9999.99")+" "+transform(nMedCliVal, "@E 9999,999.99")+space(1)+transform(nMedCliPec, "@E 9999,999.99")+" "+transform(nMedCliSrv, "@E 9999,999.99")

nLin++

// Impressao dos Valores Minimos
@ nLin, 001 pSay space(16)+STR0009+" "+transform(nMiGarPad/100, "@E 9999.99")+" "+transform(nMiGarTra/100, "@E 9999.99")+" "+transform(nMiGarVal, "@E 9999,999.99")+" "+transform(nMiGarPec, "@E 9999,999.99")+transform(nMiGarSrv, "@E 9999,999.99")+"  "+;
transform(nMiCliPad/100, "@E 9999.99")+" "+transform(nMiCliTra/100, "@E 9999.99")+" "+transform(nMiCliVal, "@E 9999,999.99")+space(1)+transform(nMiCliPec, "@E 9999,999.99")+" "+transform(nMiCliSrv, "@E 9999,999.99")

nLin+=3

@ nLin++, 001 pSay STR0010+space(12)+transform(nTGarPad/100, "@E 9999.99")+" "+transform(nTGarTra/100, "@E 9999.99")+" "+transform(nTGarVal, "@E 9999,999.99")+" "+transform(nTGarPec, "@E 9999,999.99")+transform(nTGarSrv, "@E 9999,999.99")+"  "+;
transform(nTCliPad/100, "@E 9999.99")+" "+transform(nTCliPrev/100, "@E 9999.99")+" "+transform(nTCliVal, "@E 9999,999.99")+space(1)+transform(nTCliPec, "@E 9999,999.99")+" "+transform(nTCliSrv, "@E 9999,999.99")

aSort(aTotCli,,,{|x,y| x[1]+x[2] > y[1]+y[2] })
aSort(aTotCat,,,{|x,y| x[1]+x[2]+x[3] > y[1]+y[2]+y[3] })

For x:=1 to Len(aTotCli)
	
	IncRegua()
	
	If nLin >= 55
		nLin := 1
		nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg, cTamanho,nCaracter)+1
		@ nLin, 001 pSay STR0011
		nLin++
		@ nLin, 001 pSay STR0012
		nLin++
	EndIf
	nLin++
	
	If ( !Empty(aTotCli[x,17]) .Or. !Empty(aTotCli[x,18]) .Or. !Empty(aTotCli[x,19]) .Or. !Empty(aTotCli[x,20]) .Or. !Empty(aTotCli[x,21]) .Or. !Empty(aTotCli[x,22]) .Or. !Empty(aTotCli[x,23]) .Or. !Empty(aTotCli[x,24]) .Or. !Empty(aTotCli[x,25]) .Or. !Empty(aTotCli[x,26]) )
		
		@ nLin++, 001 pSay substr(aTotCli[x,31],1,22)+" "+transform(aTotCli[x,17]/100, "@E 9999.99")+" "+transform(aTotCli[x,18]/100, "@E 9999.99")+" "+transform(aTotCli[x,19], "@E 9999,999.99")+" "+transform(aTotCli[x,20], "@E 9999,999.99")+transform(aTotCli[x,21], "@E 9999,999.99")+"  "+;
		transform(aTotCli[x,22]/100, "@E 9999.99")+" "+transform(aTotCli[x,23]/100, "@E 9999.99")+" "+transform(aTotCli[x,24], "@E 9999,999.99")+space(1)+transform(aTotCli[x,25], "@E 9999,999.99")+" "+transform(aTotCli[x,26], "@E 9999,999.99")
		
	EndIf
	
	nPos := Ascan(aTotCat,{|w| w[1]+w[2] == aTotCli[x,1]+aTotCli[x,2]})
	If nPos > 0
		
		For y:=1 to Len(aTotCat)
			
			If aTotCat[y,1]+aTotCat[y,2] == aTotCli[x,1]+aTotCli[x,2]
				
				If MV_PAR03 == 3 .or. MV_PAR03 == 2
					
					If nLin >= 55
						nLin := 1
						nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg, cTamanho,nCaracter)+1
						@ nLin, 001 pSay STR0011
						nLin++
						@ nLin, 001 pSay STR0012
						nLin++
					EndIf
					
					If MV_PAR03 == 2 .or. MV_PAR03 == 3
						
						If ( !Empty(aTotCat[y,19]) .Or. !Empty(aTotCat[y,20]) .Or. !Empty(aTotCat[y,21]) .Or. !Empty(aTotCat[y,22]) .Or. !Empty(aTotCat[y,23]) .Or. !Empty(aTotCat[y,24]) .Or. !Empty(aTotCat[y,25]) .Or. !Empty(aTotCat[y,26]) .Or. !Empty(aTotCat[y,27]) .Or. !Empty(aTotCat[y,28]) )
							
							@ nLin++, 001 pSay aTotCat[y,3]+space(01)+Substr(aTotCat[y,4],1,18)+space(01)+transform(aTotCat[y,19]/100, "@E 9999.99")+" "+transform(aTotCat[y,20]/100, "@E 9999.99")+" "+transform(aTotCat[y,21], "@E 9999,999.99")+" "+transform(aTotCat[y,22], "@E 9999,999.99")+transform(aTotCat[y,23], "@E 9999,999.99")+"  "+;
							transform(aTotCat[y,24]/100, "@E 9999.99")+" "+transform(aTotCat[y,25]/100, "@E 9999.99")+" "+transform(aTotCat[y,26], "@E 9999,999.99")+space(1)+transform(aTotCat[y,27], "@E 9999,999.99")+" "+transform(aTotCat[y,28], "@E 9999,999.99")
							
						EndIf
						
					EndIf
					
				EndIf
				
				For z := 1 to Len(aCatAco)
					
					If aCatAco[z,33]+aCatAco[z,34]+aCatAco[z,31] == aTotCat[y,1]+aTotCat[y,2]+aTotCat[y,3]
						
						If MV_PAR03 == 3
							
							If nLin >= 55
								nLin := 1
								nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg, cTamanho,nCaracter)+1
								@ nLin, 001 pSay STR0011
								nLin++
								@ nLin, 001 pSay STR0012
								nLin++
							EndIf
							
							If ( !Empty(aCatAco[z,16]) .Or. !Empty(aCatAco[z,17]) .Or. !Empty(aCatAco[z,18]) .Or. !Empty(aCatAco[z,19]) .Or. !Empty(aCatAco[z,20]) ;
								.Or. !Empty(aCatAco[z,21]) .Or. !Empty(aCatAco[z,22]) .Or. !Empty(aCatAco[z,23]) .Or. !Empty(aCatAco[z,24]) .Or. !Empty(aCatAco[z,25]) )
								
								@ nLin++, 003 pSay substr(aCatAco[z,1],1,21)+transform(aCatAco[z,16]/100, "@E 9999.99")+" "+transform(aCatAco[z,17]/100, "@E 9999.99")+" "+transform(aCatAco[z,18], "@E 9999,999.99")+" "+transform(aCatAco[z,19], "@E 9999,999.99")+transform(aCatAco[z,20], "@E 9999,999.99")+"  "+;
								transform(aCatAco[z,21]/100, "@E 9999.99")+" "+transform(aCatAco[z,22]/100, "@E 9999.99")+" "+transform(aCatAco[z,23], "@E 9999,999.99")+space(1)+transform(aCatAco[z,24], "@E 9999,999.99")+" "+transform(aCatAco[z,25], "@E 9999,999.99")
								
							EndIf
							
						EndIf
						
					EndIf
					
				Next
				
			EndIf
			
		Next
		
	EndIf
	
Next

Eject

Set Printer to
Set device to Screen

MS_FLUSH()

If aReturn[5] == 1
	
	OurSpool(cNomeRel)
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FS_SITUAC³ Autor ³ Thiago                ³ Data ³ 16/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Situacao do agrupamento de servico			              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_SITUAC(cIndOpe,cGruite,cCodIte,cCodSer)
************************************************

Local cSituac := "3"

If cIndOpe == "P"                                                  && Pecas
	
	VO8->(DbSetOrder(4))
	If VO8->( DbSeek( xFilial("VO8") + VV1->VV1_CODMAR+VV1->VV1_MODVEI+VV1->VV1_SEGMOD+cGruite+cCodIte ) )
		cSituac := "2"
	EndIf
	
ElseIf cIndOpe == "S"                                               && Servico
	
	VO8->(DbSetOrder(2))
	If VO8->( DbSeek( xFilial("VO8") + VV1->VV1_CODMAR+VV1->VV1_MODVEI+VV1->VV1_SEGMOD+cCodSer ) )
		cSituac := "2"
	EndIf
	
EndIf

Return cSituac

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ºFun‡„o    ³VALIDPERG º Autor ³ Caio Fraporti      º Data ³  29/04/10   º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Static Function ValidPerg

local _sAlias := Alias()
local aRegs := {}
local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))
//   1      2    3        4       5     6       7       8     9   10    11    12    13     14   15    16     17   18     19   20    21    22    23    24    25    26
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/ F3
aAdd(aRegs,{cPerg,"01",STR0019,"","","MV_CH1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02",STR0020,"","","MV_CH2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03",STR0021,"","","MV_CH3","N",1,0,3,"C","","mv_par03","1-Resumido","","","","","2-Sintetico","","","","","3-Analitico","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04",STR0022,"","","MV_CH4","N",1,0,1,"C","","mv_par04","Acordo Manutenc","","","","","Acordo+Gar+Cli","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05",STR0023,"","","MV_CH5","N",1,0,1,"C","","mv_par05","1-Valor de NF","","","","","2-Valor de MF","","","","","3-Valor Atual","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06",STR0024,"","","MV_CH6","C",4,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","VOI",""})
aAdd(aRegs,{cPerg,"07",STR0025,"","","MV_CH7","C",4,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","VEG",""})
aAdd(aRegs,{cPerg,"08",STR0014,"","","MV_CH8","C",4,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","VOI",""})
aAdd(aRegs,{cPerg,"09",STR0015,"","","MV_CH9","C",6,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","SA1",""})
aAdd(aRegs,{cPerg,"10",STR0016,"","","MV_CHA","C",2,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11",STR0017,"","","MV_CHB","C",25,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","VV1",""})
aAdd(aRegs,{cPerg,"12",STR0018,"","","MV_CHC","C", 6,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","VAI1",""})
aAdd(aRegs,{cPerg,"13",STR0013,"","","MV_CHD","C", 6,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","SA3",""})



For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

if dbSeek(cPerg+"12")
	RecLock("SX1",.F.)
	SX1->X1_VALID := "Empty(MV_PAR12) .OR. FG_SEEK('VAI','MV_PAR12',1,.F.)"
	MsUnlock()
EndIf
if dbSeek(cPerg+"13")
	RecLock("SX1",.F.)
	SX1->X1_VALID := "Empty(MV_PAR13) .OR. FG_SEEK('SA3','MV_PAR13',1,.F.)"
	MsUnlock()
EndIf

dbSelectArea(_sAlias)

Return
*/