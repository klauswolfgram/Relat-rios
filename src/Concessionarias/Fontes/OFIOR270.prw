/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma pr·tica e de f·cil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "ofior270.ch"
#Include "protheus.ch"
#Include "Fileio.ch"

/*/{Protheus.doc} mil_ver()
    Versao do fonte modelo novo

    @author Andre Luis Almeida
    @since  13/12/2017
/*/
Static Function mil_ver()
	If .F.
		mil_ver()
	EndIf
Return "007577_1"

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÑo    ≥ OFIOR270 ≥ Autor ≥ Fabio                 ≥ Data ≥ 27/11/00 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Descriáao ≥ Analise do Mecanico                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function OFIOR270

Local cDesc1	  := STR0001 //"Analise do Produtivo"
Local cDesc2 	  := ""
Local cDesc3 	  := ""
Local cAlias	  := "VO4"
Local aRegistros := {}

Private nLin     := 1
Private aPag     := 1
Private nIte     := 1
Private aReturn  := { STR0002, 1,STR0003, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private cTamanho := "G"           // P/M/G
Private Limite   := 220           // 80/132/220
Private aOrdem   := {}           // Ordem do Relatorio
Private cTitulo  := STR0001 //"Analise do Produtivo"
Private cNomProg := "OFIOR270"
Private cNomeRel := "OFIOR270"
Private nLastKey := 0
Private cPerg    := "OFR270" 
Private cAliasVAI:= "SQLVAI"
Private cAliasVOE:= "SQLVOE"
Private nCont    := 1
Private nHrsDisp := 0
Private nApro    := 0 
Private nAprov   := 0 
Private nProd    := 0
Private nProdut  := 0
Private nTmpDisp := 0
Private nHrsExt  := 0
Private nHEfTot  := 0
Private nTmpTra  := 0
Private nTmpVen  := 0
Private nTmpPed  := 0
Private nTmpHExt := 0
Private nEfic    := 0
Private nTmpPad  := 0
Private nTmpCob  := 0
Private aExpXLS  := {}
Private aExpXLST := {}

Private cFiltroVX5  := "052" // Filtro tabela VX5 - 052 - Habilidades do Tecnico

ValidPerga()

cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)

If nLastKey == 27
	Return
Endif

PERGUNTE("OFR270",.f.)

SetDefault(aReturn,cAlias)

RptStatus( { |lEnd| U_ImpOR270(@lEnd,cNomeRel,cAlias) } , cTitulo )

if mv_par12 <> 3 // Gerar em Excel
	If aReturn[5] == 1
		
		OurSpool( cNomeRel )
		
	EndIf
Endif

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ImpOR270  ∫Autor  ≥Fabio               ∫ Data ≥  11/13/00   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Imprime Analise do Mecanico                                 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Oficina                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function ImpOR270(lEnd,wNRel,cAlias)

Local nLin := 1, nPos := 0 , nTotTra := 0 , nTotpad := 0 , nTotVen := 0 , nPosC := 0, nPosL := 0, nPosN := 0
Local cStatus   := ""
Local aNumSer   := {}
Local aCodSer   := {}
Local aTotal    := {}
Local dDatRef   := {}
Local cNosNum   := "", cTipTem := "", cCodSer := "", cCodPro := "", nTpoTraUni := 0, nTpoTraTot := 0, nTpoExt := 0, nPercPadrao := 0, nRecVO4 := 0
Local lFilEscala:= .f.
Local nIniHora  := 0
Local nFinHora  := 0
Local lSomaHDisp:=.t.
Local nTp       := 0
Local cAliasVO4 := "SQLVO4"
Local cAreaVO4  := "TMPVO4"
Local lContinua := .f.
Local nCont   := 0
Local aFilAtu := FWArrFilAtu()
Local aSM0    := FWAllFilial( aFilAtu[3] , aFilAtu[4] , aFilAtu[1] , .f. )
Local cBkpFilAnt := cFilAnt
Local lProFil     := VAI->(FieldPos("VAI_PROFIL")) > 0
Local lVAI_CLAHAB := VAI->(FieldPos("VAI_CLAHAB")) > 0

Local nTotGLeg12 := 0
Local nTotGLeg13 := 0
Local nTotGLeg14 := 0
Local nTotGLeg15 := 0
Local nTotGLeg16 := 0
Local nTotGLeg17 := 0
Local nTotGLeg18 := 0
Local nTotGLeg19 := 0
Local nTotGLeg21 := 0
Local nTotGLeg22 := 0

Private cTamanho := "G"           // P/M/G
Private Limite   := 220           // 80/132/220
Private m_Pag    := 1
Private aOrdem   := {}           // Ordem do Relatorio
Private cTitulo  := STR0001 //"Analise do Mecanico"
//Private ctamanho := "P"

Private aDadosMec := {}

Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer

&& Inicio do levantamento e impressao
If FunName() == "OFIOR270"
	SetRegua( VAI->(RecCount()) * (MV_PAR03 - MV_PAR02) )
Endif

aTotal := {}
// tinha 23 Elementos - agora tem 24
aAdd( aTotal , { 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } )
For nCont := 1 to Len(aSM0)
	cFilAnt := aSM0[nCont]

	if aSM0[nCont] < MV_PAR10 .OR. aSM0[nCont] > MV_PAR11
		Loop
	Endif
	
	cQuery := "SELECT "
	cQuery += "VAI.VAI_CODTEC , VAI.VAI_DATADM , VAI.VAI_DATDEM , VAI.VAI_FUNCAO , VAI.VAI_NOMTEC , VAI.VAI_FUNPRO , VAI.VAI_FILPRO "
	if lProFil
		cQuery += ", VAI.VAI_PROFIL "
	Endif	
	cQuery += "FROM "+RetSqlName("VAI")+" VAI "
	cQuery += "WHERE VAI.VAI_FILIAL='"+xFilial("VAI")+"'"
	If !Empty(MV_PAR04)
		cQuery += " AND VAI.VAI_CODTEC = '"+MV_PAR04+"'"
	Endif
	cQuery += " AND VAI.VAI_FUNPRO = '1' "
	cQuery += " AND VAI.VAI_DATADM <= '"+dtos(MV_PAR03)+"'"
	cQuery += " AND ( VAI.VAI_DATDEM = ' ' OR VAI.VAI_DATDEM >= '"+dtos(MV_PAR02)+"' )"
	If lVAI_CLAHAB .and. !Empty(MV_PAR16)
		cQuery += " AND VAI.VAI_CLAHAB='"+MV_PAR16+"'"
	EndIf
	cQuery += " AND VAI.D_E_L_E_T_=' '"
	cQuery += " ORDER BY VAI.VAI_CODTEC"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasVAI,.T.,.T.)
	
	Do While !( cAliasVAI )->( Eof() )

		if lProFil
			If !Empty(MV_PAR10) .or. !Empty(MV_PAR11)
				if ( cAliasVAI )->VAI_PROFIL = "1" 
					if ( cAliasVAI )->VAI_FILPRO < MV_PAR10 .OR. ( cAliasVAI )->VAI_FILPRO > MV_PAR11
						dbSelectArea(cAliasVAI)
						( cAliasVAI )->(dbSkip())
						Loop
					Endif					
				Elseif ( cAliasVAI )->VAI_FILPRO <> cFilAnt       
					dbSelectArea(cAliasVAI)
					( cAliasVAI )->(dbSkip())
					Loop
				Endif
			Endif
		Else
			If !Empty(MV_PAR10) .or. !Empty(MV_PAR11)
				if ( cAliasVAI )->VAI_FILPRO <= MV_PAR10 .OR. ( cAliasVAI )->VAI_FILPRO >= MV_PAR11
					dbSelectArea(cAliasVAI)
					( cAliasVAI )->(dbSkip())
					Loop
				Endif
			Endif
		Endif
		
		aDadosMec := {}
		aNumSer   := {}
		nTotPad   := 0
		nTotVen   := 0
		nTotTra   := 0
		lFilEscala:= .f.
		
		// tinha 27 Elementos - agora tem 28
		aAdd( aDadosMec , { "T" , ;
						( cAliasVAI )->VAI_CODTEC , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							0 , ;
							CtoD ("  /  /  ") , ;
							0 , ;
							0 , ;
							0 } )
		
		For dDatRef := MV_PAR02 to MV_PAR03
		
			// Filtra relatorio por escala do produtivo
			If Select( cAliasVOE ) > 0
				( cAliasVOE )->(DbCloseArea())
			EndIf
			//

			cQuery := " SELECT VOE_CODPER "
			cQuery += " FROM " + RetSqlName("VOE") + " VOE "
			cQuery += " WHERE  VOE.VOE_FILIAL = '" + xFilial("VOE") + "' AND VOE.VOE_CODPRO = '" + ( cAliasVAI )->VAI_CODTEC + "' AND "
			cQuery += "		    VOE.VOE_DATESC <= '"+ Dtos(dDatRef)  + "' " 
			If !Empty(MV_PAR09)
				cQuery += " AND VOE.VOE_CODPER = '" + MV_PAR09 + "' "
			EndIf		
			cQuery += "AND VOE.D_E_L_E_T_=' ' ORDER BY VOE.VOE_DATESC DESC "
			dbUseArea( .T., "TOPCONN", TCGenQry(,,cQuery),cAliasVOE,.T.,.T.)		

			If ( cAliasVOE )->(Eof())
				( cAliasVOE )->(DbCloseArea())
				Loop
			Else
				lFilEscala := .t.
			EndIf		


			&& Monta esquema para periodo noturno.
			nIniHora := 0
			nFinHora := 2359
			if (dDatRef == dDatabase)
				nFinHora := VAL(Left(TIME(),2)+Subs(TIME(),4,2))
			endif
			lSomaHDisp:=.t.
		
			DbSelectArea("VOH")
			DbSetOrder(1)
			If DbSeek(xFilial("VOH")+( cAliasVOE )->VOE_CODPER)
			
				If VOH->VOH_INIPER > VOH->VOH_FINPER
				
					If dDatRef == MV_PAR02
						nIniHora := VOH->VOH_INIPER
						nFinHora := 2359
					ElseIf dDatRef == MV_PAR03
						nIniHora := 0
						nFinHora := VOH->VOH_FINPER
					EndIf
				
				EndIf
			
			EndIf
		
			If lSomaHDisp 
				aDadosMec[1,03] += FS_OR270CALTEM(( cAliasVAI )->VAI_CODTEC,dDatRef,"0",nIniHora,nFinHora)      // Horas Disponiveis
			EndIf
			aDadosMec[1,04] += FS_OR270CALTEM(( cAliasVAI )->VAI_CODTEC,dDatRef,"4",nIniHora,nFinHora)      // Horas Ausentes
			aDadosMec[1,23] += FS_OR270CALTEM(( cAliasVAI )->VAI_CODTEC,dDatRef,"9",nIniHora,nFinHora)     // Estoque de Horas Nao Liberadas
			aDadosMec[1,24] += FS_OR270CALTEM(( cAliasVAI )->VAI_CODTEC,dDatRef,"A",nIniHora,nFinHora)     // Estoque de Horas Liberadas
			
			cQuery := "SELECT VO4.R_E_C_N_O_ VO4RECNO "
			cQuery +=  " FROM " + RetSqlName("VO4") + " VO4 "
			cQuery += " WHERE VO4.VO4_FILIAL = '" + xFilial("VO4") + "'"
			cQuery +=   " AND VO4.VO4_CODPRO = '" + ( cAliasVAI )->VAI_CODTEC + "'"
			If MV_PAR15 == 1 // Considera Data de Apontamento
				cQuery += " AND VO4.VO4_DATINI = '"+Dtos(dDatRef)+"'"
				cQuery += " AND VO4.VO4_DATINI >= '"+( cAliasVAI )->VAI_DATADM+"'"
				If !Empty( ( cAliasVAI )->VAI_DATDEM )
					cQuery += " AND VO4.VO4_DATINI <= '"+( cAliasVAI )->VAI_DATDEM+"'"
				Endif
			ElseIf MV_PAR15 == 2 // Considera Data de Fechamento
				cQuery += " AND VO4.VO4_DATFEC = '"+Dtos(dDatRef)+"'"
			Endif
			Do Case
				Case ( MV_PAR08 == 2 ) // Status de OS Aberta
					cQuery += " AND VO4.VO4_DATDIS = ' '"
					cQuery += " AND VO4.VO4_DATFEC = ' '"
					cQuery += " AND VO4.VO4_DATCAN = ' '"
				Case ( MV_PAR08 == 3 ) // Status de OS Liberada
					cQuery += " AND VO4.VO4_DATDIS <> ' '"
					cQuery += " AND VO4.VO4_DATFEC = ' '"
					cQuery += " AND VO4.VO4_DATCAN = ' '"
				Case ( MV_PAR08 == 4 ) // Status de OS Fechada
					cQuery += " AND VO4.VO4_DATFEC <> ' '"
					cQuery += " AND VO4.VO4_DATCAN = ' '"
				Case ( MV_PAR08 == 5 ) // Status de OS Cancelada
					cQuery += " AND VO4.VO4_DATCAN <> ' '"
			EndCase			
			cQuery += " AND VO4.D_E_L_E_T_=' ' ORDER BY VO4.VO4_CODPRO"
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasVO4,.T.,.T.)

			Do While !( cAliasVO4 )->( Eof() )
				
				DbSelectArea("VO4")
				dbgoto( ( cAliasVO4 )->( VO4RECNO ) )

				If MV_PAR15 == 2 // Considera Data de Fechamento
					lContinua := .t.
				ElseIf MV_PAR15 == 1 // Considera Data de Apontamento
					lContinua := ( VO4->VO4_HORINI >= nIniHora .And. VO4->VO4_HORINI <= nFinHora )
				Endif
			
				If lContinua
				
					cStatus := FS_VERSTA()
					If ( MV_PAR08 == 2 .and. cStatus != "A" ) ;
						.Or. ( MV_PAR08 == 3 .and. cStatus != "D" ) ;
						.Or. ( MV_PAR08 == 4 .and. cStatus != "F" ) ;
						.Or. ( MV_PAR08 == 5 .and. cStatus != "C" )

						( cAliasVO4 )->( DbSkip() )
						Loop

					EndIf
				
					DbSelectArea("VO2")
					DbSetOrder(2)
					DbSeek( xFilial("VO2") + VO4->VO4_NOSNUM )
					
					DbSelectArea("VO1")
					DbSetOrder(1)
					DbSeek( xFilial("VO1") + VO2->VO2_NUMOSV )
					
					DbSelectArea("VV1")
					DbSetOrder(1)
					DbSeek(xFilial("VV1") + VO1->VO1_CHAINT )
					
					DbSelectArea("VO6")
					DbSetOrder(2)
					DbSeek( xFilial("VO6") + VV1->VV1_CODMAR + VO4->VO4_CODSER )
					
					// Levanta Totais por Tipo de Servico
					nPos := 0
					If MV_PAR06 == 1
						If Empty(VO4->VO4_DATCAN)
							dbSelectArea( "VOK" )
							dbSetOrder(1)
							dbSeek( xFilial("VOK") + VO4->VO4_TIPSER )
							nPos := aScan(aNumSer, {|x| x[1] == VO4->VO4_TIPSER})
							If nPos == 0
								aAdd(aNumSer,{VO4->VO4_TIPSER,VOK->VOK_DESSER,VO4->VO4_TEMPAD,VO4->VO4_TEMTRA,.f.})
								IF VO4->VO4_HOREXT $ "OE"
									nTotTra += VO4->VO4_TEMTRA 
								ENDIF
							Else
								aNumSer[nPos,04] += VO4->VO4_TEMTRA
								IF VO4->VO4_HOREXT $ "OE"
									nTotTra += VO4->VO4_TEMTRA
								ENDIF
							EndIf
							
						EndIf
						
					EndIf
				
					If ( Len(aCodSer) == 0 .Or. ( nPosC := aScan(aCodSer, {|x| x[1]+x[2]+x[3]+x[4]+x[5] == VO1->VO1_NUMOSV+VO4->VO4_TIPTEM+VO4->VO4_TIPSER+VO4->VO4_CODSER+VO4->VO4_CODPRO}) ) == 0 )
					
						If VO4->VO4_NOSNUM != "99999999" //Ausencias
					
							// Levanta a quantidade de produtivo que trabalho no servico.
							cNosNum    := VO4->VO4_NOSNUM
							cTipTem    := VO4->VO4_TIPTEM
							cCodSer    := VO4->VO4_CODSER
							cCodPro    := VO4->VO4_CODPRO
							nTpoTraTot := 0
							nTpoTraUni := 0
							nTpoTraFor := 0
							nTpoTraPro := 0

							VOK->(dbSetOrder(1))
							VOK->(MSSeek( xFilial("VOK") + VO4->VO4_TIPSER ))
						   
							cQuery := " SELECT VO4_TEMTRA, VO4_TEMVEN, VO4_DATFIN, VO4_CODPRO "
							cQuery += " FROM " + RetSqlName("VO4") + " VO4 "
							cQuery += " WHERE VO4_FILIAL = '" + xFilial("VO4") + "'"
							cQuery +=   " AND VO4_NOSNUM = '" + cNosNum + "' "
							cQuery +=   " AND VO4_TIPTEM = '" + cTipTem + "' "
							cQuery +=   " AND VO4_CODSER = '" + cCodSer + "' "
							cQuery +=   " AND VO4.D_E_L_E_T_ = ' ' "
							dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAreaVO4,.T.,.T.)
							
							Do While !( cAreaVO4 )->( Eof() )
							
								// Tempo trabalhado de todos os produtivos
								nTpoTraTot += ( cAreaVO4 )->VO4_TEMTRA
						
								// Tempo trabalhado do produtivo
								If ( cAreaVO4 )->VO4_CODPRO == cCodPro

									nTpoTraPro += ( cAreaVO4 )->VO4_TEMTRA

									If MV_PAR15 == 1 // Considera Data de Apontamento
										if Stod( ( cAreaVO4 )->VO4_DATFIN ) < MV_PAR02 .OR. Stod( ( cAreaVO4 )->VO4_DATFIN ) > MV_PAR03
											nTpoTraFor +=( cAreaVO4 )->VO4_TEMTRA
										endif
										nTpoTraUni += ( cAreaVO4 )->VO4_TEMTRA
									Elseif MV_PAR15 == 2 // Considera Data de Fechamento
										nTpoTraUni += ( cAreaVO4 )->VO4_TEMTRA
									Endif

									If VOK->VOK_INCTEM == "3" // Tempo Trabalhado - VO4 j· estara rateado
										nTotVen += ( cAreaVO4 )->VO4_TEMVEN
									EndIf

								EndIf

								(cAreaVO4)->(DbSkip())

							EndDo
							( cAreaVO4 )->(DbCloseArea())
							DbSelectArea("VO4")

							nPercPadrao := ( (nTpoTraUni-nTpoTraFor) / nTpoTraTot ) // Percentual para Calculo do Tempo Padrao
							nPercVendido := ( nTpoTraPro / nTpoTraTot ) // Percentual para Calculo do Tempo Vendido
					
							aAdd(aCodSer,{;
								VO1->VO1_NUMOSV,; // 1
								VO4->VO4_TIPTEM,; // 2
								VO4->VO4_TIPSER,; // 3
								VO4->VO4_CODSER,; // 4
								VO4->VO4_CODPRO,; // 5
								nPercPadrao,; // 6
								}) // 7
							nPosC := Len(aCodSer)
						
							If nPos # 0 .And. nPos <= Len(aNumSer)
								aNumSer[nPos,03] += ( VO4->VO4_TEMPAD * aCodSer[nPosC,6] )
							EndIf
							if nPos == 0 .and. Len(aNumSer) > 0 .and. aNumSer[Len(aNumSer),5] == .f.
								aNumSer[Len(aNumSer),03] = aNumSer[Len(aNumSer),03] * aCodSer[nPosC,6]
								aNumSer[Len(aNumSer),5] = .t.
							endif
						
							nTotPad += ( VO4->VO4_TEMPAD * aCodSer[nPosC,6] )
							If VOK->VOK_INCTEM == "3" // Tempo Trabalhado - VO4 j· estara rateado
							Else
								nTotVen += ( VO4->VO4_TEMVEN * aCodSer[nPosC,6] )
							EndIf

						Else
							aAdd(aCodSer,{VO1->VO1_NUMOSV,VO4->VO4_TIPTEM,VO4->VO4_TIPSER,VO4->VO4_CODSER,VO4->VO4_CODPRO, VO4->VO4_TEMTRA,  })
							nPosC := Len(aCodSer)
						EndIf
					EndIf
				
					DbSelectArea("VOB")
					DbSetOrder(1)
					DbSeek( xFilial("VOB") + VO4->VO4_CODPRO + Dtos( VO4->VO4_DATINI ) )
				
					DbSelectArea("VO6")
					DbSetOrder(2)
					DbSeek( xFilial("VO6") + VV1->VV1_CODMAR + VO4->VO4_CODSER )
				
					DbSelectArea("VO4")
					
					nTpoTraAux := Iif(VO4->VO4_NOSNUM == "99999999",	VO4->VO4_TEMTRA, FS_VERPER(VO4->VO4_NOSNUM,VO4->VO4_TIPTEM,VO4->VO4_CODSER,VO4->VO4_TEMTRA))

					// tinha 21 Elementos - agora tem 28
					aAdd( aDadosMec , { "A" ,; // 1
										VO4->VO4_CODPRO ,; // 2
										VO1->VO1_NUMOSV ,; // 3
										cStatus         ,; // 4
										VO4->VO4_TIPTEM ,; // 5
										VO4->VO4_CODSER ,; // 6
										Substr( VO6->VO6_DESSER , 1, 23 ) ,; // 7
										VO4->VO4_DATINI ,; // 8
										VO4->VO4_HORINI ,; // 9
										VO4->VO4_DATFIN ,; // 10
										VO4->VO4_HORFIN ,; // 11
										( VO4->VO4_TEMPAD * aCodSer[nPosC,6] ) ,; // 12 - Tempo Vendido
										VO4->VO4_TEMTRA ,; // 13
										VO4->VO4_TEMCOB ,; // 14
										IIF( VOK->VOK_INCMOB == "3" , VO4->VO4_TEMVEN , VO4->VO4_TEMVEN * aCodSer[nPosC,6] ),; // 15
										VO4->VO4_HOREXT ,; // 16
										VO4->VO4_TIPAUS ,; // 17
										VO4->VO4_TEMAUS ,; // 18
										( VO4->VO4_TEMTRA / nTpoTraAux ) * 100 ,; // 19
										,; // 20
										,; // 21
										,; // 22
										,; // 23
										,; // 24
										,; // 25
										,; // 26
										,; // 27
										, } ) // 28
				
				EndIf
			
				( cAliasVO4 )->( DbSkip() )
			
			EndDo
			(cAliasVO4)->(DbCloseArea())
			DbSelectarea("VO4")
		
			If FunName() == "OFIOR270"
				IncRegua()
			Endif
		
		Next
	
		If lFilEscala
			aDadosMec[1,07] := 0
			aDadosMec[1,08] := 0
			For nTp:=1 to Len(aDadosMec)
				
				If aDadosMec[nTp,01] # "T" .and. aDadosMec[nTp,01] # "R"
				
					If aDadosMec[nTp,16] == "O"
						aDadosMec[1,07] += INT(FS_VLSERTP(aDadosMec[nTp,08],aDadosMec[nTp,09],aDadosMec[nTp,10],aDadosMec[nTp,11],30))    // Horas Trabalhadas
					EndIf
					
					If aDadosMec[nTp,16] == "E"
						aDadosMec[1,08] += INT(FS_VLSERTP(aDadosMec[nTp,08],aDadosMec[nTp,09],aDadosMec[nTp,10],aDadosMec[nTp,11],30))    // Horas Extras
					EndIf
					
					aDadosMec[1,11] += aDadosMec[nTp,14]    // Horas Cobrada

				EndIf
				
			Next
		
			aDadosMec[1,10] := nTotPad    // Horas Padrao
			aDadosMec[1,12] += nTotVen    // Horas Vendida
			aDadosMec[1,05] := aDadosMec[1,03] - aDadosMec[1,04]           // Horas Efetivas = Tempo Disponivel - Tempo Ausente
			aDadosMec[1,06] := aDadosMec[1,05] - aDadosMec[1,07]           // Horas Paradas
			If aDadosMec[1,06] <= 0
				aDadosMec[1,06] := 0
			EndIf
		
			If ( nTpoExt := ( (aDadosMec[1,07]+aDadosMec[1,08]) - aDadosMec[1,10] ) ) > 0
				aDadosMec[1,09] := nTpoExt         									  // Horas Estourado
			EndIf
		
			aDadosMec[1,13] := FG_CALTEM(,,"B",,MV_PAR07)                 // Estoque de Horas Liberadas
		
			If ( MV_PAR08 # 1 .And. MV_PAR08 # 2 )  && Se contiver status aberto nao mostra eficiencia
			
				// % Eficiencia sobre Tempo Padrao 
				aDadosMec[1,14] := ( aDadosMec[1,10] / aDadosMec[1,7] ) * 100                      // (Tempo Aplicado/Tempo Padrao) * 100
				aDadosMec[1,15] := ( aDadosMec[1,10] / ( aDadosMec[1,7] + aDadosMec[1,8] ) ) * 100 // (Tempo Padrao/(Tempo Aplicado+Tempo Extra)) * 100
			
				// % Eficiencia sobre Tempo Cobrado 
				aDadosMec[1,16] := ( aDadosMec[1,11] / aDadosMec[1,7] ) * 100                      // (Tempo Aplicado/Tempo Cobrado) * 100
				aDadosMec[1,17] := ( aDadosMec[1,11] / ( aDadosMec[1,7] + aDadosMec[1,8] ) ) * 100 // ((Tempo Aplicado+Tempo Extra)/Tempo Cobrado) * 100

				// % Eficiencia sobre Tempo Vendido 
				aDadosMec[1,18] := ( aDadosMec[1,12] / aDadosMec[1,7] ) * 100                      // (Tempo Aplicado/Tempo Vendido) * 100
				aDadosMec[1,19] := ( aDadosMec[1,12] / ( aDadosMec[1,7] + aDadosMec[1,8] ) )* 100 // ((Tempo Aplicado+Tempo Extra)/Tempo Vendido) * 100
			
				// % Produtividade sobre Tempo Efetivo (Tempo Aplicado/Tempo Efetivo)
				aDadosMec[1,20] :=  ( aDadosMec[1,7] / aDadosMec[1,5] ) * 100
				// % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo)
				aDadosMec[1,21] := ( ( aDadosMec[1,7] + aDadosMec[1,8] ) / aDadosMec[1,5] ) * 100
				// % Produtividade (Tempo Cobrado/Tempo Padrao) * 100
				aDadosMec[1,22] := ( aDadosMec[1,11] / aDadosMec[1,10] ) * 100
				// % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo+TempoExtra)
				aDadosMec[1,28] := ( ( aDadosMec[1,7] + aDadosMec[1,8] ) / ( aDadosMec[1,5]+aDadosMec[1,8] ) ) * 100
			
			EndIf
			
			//Teste, impressao estava aqui

		EndIf

		If (  aDadosMec[1,07] + aDadosMec[1,08] + aDadosMec[1,09] + aDadosMec[1,10] +;
				aDadosMec[1,11] + aDadosMec[1,12] > 0 ) .or. ( cAliasVAI )->VAI_FILPRO == xFilial("VO4")
		
				nLin := FS_IMPVET( aDadosMec , nLin, aNumSer, nTotPad, nTotTra , aTotal )
		EndIf
	
		If FunName() == "OFIOR270"
			IncRegua()
		Endif
	
		DbSelectArea(cAliasVAI)
		( cAliasVAI )->(DbSkip())
	
	EndDo  
	(cAliasVAI)->(dbCloseArea())
Next	                  
cFilAnt := cBkpFilAnt

if mv_par12 == 3 // Gerar em Excel
	U_OF270XLS()
Endif
If nLin > 55
	nLin := 1
EndIf

if mv_par12 == 1 // Analise do Mec.
	If FunName() == "OFIOR270"

		nTotGLeg12 := ( aTotal[1,8] /  aTotal[1,5] )*100 
		nTotGLeg13 := ( aTotal[1,8] / (aTotal[1,5] +   aTotal[1,6] ) ) * 100
		nTotGLeg14 := ( aTotal[1,9] /  aTotal[1,5] ) * 100
		nTotGLeg15 := ( aTotal[1,9] / (aTotal[1,5] +   aTotal[1,6] ) ) * 100
		nTotGLeg16 := ( aTotal[1,10] /  aTotal[1,5] ) * 100
		nTotGLeg17 := ( aTotal[1,10] / (aTotal[1,5] +   aTotal[1,6] ) ) * 100
		nTotGLeg18 := ( aTotal[1,5] /  aTotal[1,3] ) * 100
		nTotGLeg19 := ((aTotal[1,5] +  aTotal[1,6] ) / aTotal[1,3] ) * 100
		nTotGLeg20 := ((aTotal[1,9] /  aTotal[1,8] )) * 100
		nTotGLeg21 := ( aTotal[1,5] /  aTotal[1,1] ) * 100 

		@ nLin++ , 00 psay ""
		@ nLin++ , 15 psay STR0038 //           --- 0 1 --- 0 2 --- 0 3 --- 0 4 --- 0 5 --- 0 6 --- 0 7 --- 0 8 --- 0 9 --- 1 0 --- 1 1  --- 1 2  ---- 1 3  --- 1 4  --- 1 5  --- 1 6  --- 1 7  --- 1 8  --- 1 9  --- 2 1 --- 2 2 --- 2 3 --- 2 4 -
		@ nLin++ , 00 psay Repl("*",220)

		@ nLin++ , 01 psay STR0004 +space(10)+ ;
							RetHora(aTotal[1,1] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,2] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,3] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,4] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,5] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,6] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,7] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,8] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,9] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,10], "@R 9999:99" ) + Space(1) + ;
							Transform( NoRound( aTotal[1,11],2)  , "@E 9999.99" ) + Space(1) + ;
							Transform( nTotGLeg12/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(2) + ;
							Transform( nTotGLeg13/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							Transform( nTotGLeg14/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							Transform( nTotGLeg15/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							Transform( nTotGLeg16/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							Transform( nTotGLeg17/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							Transform( nTotGLeg18/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							Transform( nTotGLeg19/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							Transform( nTotGLeg20/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							Transform( nTotGLeg21/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + ;
							RetHora(aTotal[1,21] , "@R 9999:99" ) + Space(1) + ;
							RetHora(aTotal[1,22], "@R 9999:99" )
		@ nLin++ , 00 psay 	Repl("*",220)
	Else
		
		fwrite(outputfile,""+CHR(13)+CHR(10))
		fwrite(outputfile,STR0038+CHR(13)+CHR(10))
		fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
		fwrite(outputfile,STR0004 +space(10)+ RetHora(aTotal[1,1] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,2] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,3] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,4] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,5] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,6] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,7] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,8] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,9] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,10] , "@R 9999:99" ) + Space(1) + Transform( NoRound( aTotal[1,11],2) , "@E 9999.99" )  ;  //"T    O    T    A    L               "
		+ Space(1) + Transform( aTotal[1,12]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(2) + Transform( aTotal[1,13]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + Transform( aTotal[1,14]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + Transform( aTotal[1,15]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + Transform( aTotal[1,16]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + Transform( aTotal[1,17]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + Transform( aTotal[1,18]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + Transform( aTotal[1,19]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + Transform( aTotal[1,20]/aTotal[1,23] , "@E 9999.99" ) + "%" + Space(1) + RetHora(aTotal[1,21] , "@R 9999:99" ) + Space(1) + RetHora(aTotal[1,22] , "@R 9999:99" )+CHR(13)+CHR(10))
		fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
	Endif
Else // Mapa de Produt.
	nLin++
	@ nLin++,00 psay Repl("*",220)
	@ nLin++ , 043 psay STR0004 + Space(12) + ;
						RetHora(nHrsDisp , "@R 999999:99" ) + Space(3) + ;
						RetHora(nTmpDisp, "@R 999999:99" ) + Space(3) + ;
						RetHora(nHrsExt , "@R 999999:99" ) + Space(5) + ;
						RetHora(nHEfTot, "@R 999999:99" ) + Space(5) + ;
						RetHora(nTmpTra, "@R 999999:99" ) + Space(5) + ;
						RetHora(nTmpPed, "@R 999999:99" ) + Space(5) + ;
						RetHora(nTmpHExt, "@R 999999:99" ) + Space(7) + ;
						Transform(nProdut, "@R 999999.99" ) + "%" + Space(7) + ;
						Transform(nEfic , "@E 9999.99" ) + "%" + Space(6) + ;
						Transform(nAprov, "@R 999999.99" ) + "%"  //"T    O    T    A    L               "
	@ nLin++,00 psay Repl("*",220)
Endif
If MV_PAR05 == 1
	
	if nLin > 20
		nLin := 1
	Else
		If FunName() == "OFIOR270"
			nLin ++
			nLin ++
			nLin ++
			nLin ++
		Else
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,""+CHR(13)+CHR(10))
		Endif
	EndIf
	
	If FunName() == "OFIOR270"
		@ nLin++ , 00 psay ""
		@ nLin++ , 00 psay STR0005 //"Legenda -"
		@ nLin++ , 00 psay ""
		@ nLin++ , 00 psay STR0006 //"01 - Tempo Disponivel, de acordo com a escala"
		@ nLin++ , 00 psay STR0007 //"02 - Tempo Ausente"
		@ nLin++ , 00 psay STR0008 //"03 - Tempo Efetivo = Tempo Disponivel - Tempo Ausente"
		@ nLin++ , 00 psay STR0009 //"04 - Tempo Sem Aplicacao ou parado"
		@ nLin++ , 00 psay STR0010 //"05 - Tempo Aplicado ou Trabalhado"
		@ nLin++ , 00 psay STR0011 //"06 - Tempo Extra, ou Tempo Aplicado FORA da escala normal"
		@ nLin++ , 00 psay STR0012 //"07 - Tempo Estourado, ou total do tempo de execucao fora da tabela"
		@ nLin++ , 00 psay STR0013 //"08 - Tempo Padrao"
		@ nLin++ , 00 psay STR0014 //"09 - Tempo Cobrado, ou Tempo Padrao com Acrescimos ou Descontos"
		@ nLin++ , 00 psay STR0015 //"10 - Tempo que realmente foi Vendido"
		@ nLin++ , 00 psay STR0016 //"11 - Criterio a escolha do usuario, cujo resultado ser† obtido atraves do uso de formula criada pelo mesmo"
		@ nLin++ , 00 psay STR0017 //"12 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / Tempo Aplicado ) * 100"
		@ nLin++ , 00 psay STR0018 //"13 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / ( Tempo Aplicado + Tempo Extra ) ) * 100"
		@ nLin++ , 00 psay STR0019 //"14 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / Tempo Aplicado) * 100"
		@ nLin++ , 00 psay STR0020 //"15 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / ( Tempo Aplicado + Tempo Extra ) ) * 100"
		@ nLin++ , 00 psay STR0021 //"16 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / Tempo Aplicado) * 100"
		@ nLin++ , 00 psay STR0022 //"17 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / ( Tempo Aplicado + Tempo Extra ) ) * 100"
		@ nLin++ , 00 psay STR0023 //"18 - % Produtividade sobre Tempo Efetivo (Tempo Aplicado/Tempo Efetivo)"
		@ nLin++ , 00 psay STR0024 //"19 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo)"
		@ nLin++ , 00 psay STR0098 //"20 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo+Tempo Extra)"
		@ nLin++ , 00 psay STR0025 //"21 - % Produtividade (Tempo Cobrado/Tempo Padrao) * 100"
		@ nLin++ , 00 psay STR0026 //"22 - % aproveitamento (tempo trabalhado/tempo disponÌvel) * 100"
		@ nLin++ , 00 psay STR0027 //"23 - Horas Aplicadas e nao Liberadas"
		@ nLin++ , 00 psay STR0076 //"24 - Horas Aplicadas e Liberadas"

	Else
		fwrite(outputfile,""+CHR(13)+CHR(10))
		fwrite(outputfile,STR0005+CHR(13)+CHR(10)) //"Legenda -"
		fwrite(outputfile,""+CHR(13)+CHR(10))
		fwrite(outputfile,STR0006+CHR(13)+CHR(10)) //"01 - Tempo Disponivel, de acordo com a escala"
		fwrite(outputfile,STR0007+CHR(13)+CHR(10)) //"02 - Tempo Ausente"
		fwrite(outputfile,STR0008+CHR(13)+CHR(10)) //"03 - Tempo Efetivo = Tempo Disponivel - Tempo Ausente"
		fwrite(outputfile,STR0009+CHR(13)+CHR(10)) //"04 - Tempo Sem Aplicacao ou parado"
		fwrite(outputfile,STR0010+CHR(13)+CHR(10)) //"05 - Tempo Aplicado ou Trabalhado"
		fwrite(outputfile,STR0011+CHR(13)+CHR(10)) //"06 - Tempo Extra, ou Tempo Aplicado FORA da escala normal"
		fwrite(outputfile,STR0012+CHR(13)+CHR(10)) //"07 - Tempo Estourado, ou total do tempo de execucao fora da tabela"
		fwrite(outputfile,STR0013+CHR(13)+CHR(10)) //"08 - Tempo Padrao"
		fwrite(outputfile,STR0014+CHR(13)+CHR(10)) //"09 - Tempo Cobrado, ou Tempo Padrao com Acrescimos ou Descontos"
		fwrite(outputfile,STR0015+CHR(13)+CHR(10)) //"10 - Tempo que realmente foi Vendido"
		fwrite(outputfile,STR0016+CHR(13)+CHR(10)) //"11 - Criterio a escolha do usuario, cujo resultado ser† obtido atraves do uso de formula criada pelo mesmo"
		fwrite(outputfile,STR0017+CHR(13)+CHR(10)) //"12 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / Tempo Aplicado ) * 100"
		fwrite(outputfile,STR0018+CHR(13)+CHR(10)) //"13 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / ( Tempo Aplicado + Tempo Extra ) ) * 100"
		fwrite(outputfile,STR0019+CHR(13)+CHR(10)) //"14 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / Tempo Aplicado) * 100"
		fwrite(outputfile,STR0020+CHR(13)+CHR(10)) //"15 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / ( Tempo Aplicado + Tempo Extra ) ) * 100"
		fwrite(outputfile,STR0021+CHR(13)+CHR(10)) //"16 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / Tempo Aplicado) * 100"
		fwrite(outputfile,STR0022+CHR(13)+CHR(10)) //"17 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / ( Tempo Aplicado + Tempo Extra ) ) * 100"
		fwrite(outputfile,STR0023+CHR(13)+CHR(10)) //"18 - % Produtividade sobre Tempo Efetivo (Tempo Aplicado/Tempo Efetivo)"
		fwrite(outputfile,STR0024+CHR(13)+CHR(10)) //"19 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo)"
		fwrite(outputfile,STR0025+CHR(13)+CHR(10)) //"20 - % Produtividade (Tempo Cobrado/Tempo Padrao) * 100"
		fwrite(outputfile,STR0026+CHR(13)+CHR(10)) //"21 - Horas Aplicadas e nao Liberadas"
		fwrite(outputfile,STR0027+CHR(13)+CHR(10)) //"22 - Horas Aplicadas e Liberadas"
	Endif
	
EndIf

Ms_Flush()

Set Printer to
Set Device  to Screen

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥FS_IMPVET ∫Autor  ≥Fabio               ∫ Data ≥  11/27/00   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Imprime veto                                                ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Oficina                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function FS_IMPVET( aImpVet , nLin, aImpSer, ntotpad, ntottra , aTotal )

Local ni := 0

Private cbTxt    := Space(10)
Private cbCont   := 0
Private cString  := "VO4"
Private Li       := 80
Private wnRel    := "OFIOR270"

cTitulo:= STR0001 //"Analise do Produtivo"
cabec1 := ""
cabec2 := ""

nomeprog:="OFIOR270"
tamanho:="G"
nCaracter:=15

If nLin == 1
	
	If FunName() == "OFIOR270"
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
		@ nLin++,00 psay Repl("*",220)
	Else
		fwrite(outputfile," "+CHR(15)+CHR(13)+CHR(10))
		fwrite(outputfile,"*** "+cTitulo+" ***"+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile,STR0039+cEmpr+STR0040+cFil+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
	EndIf
EndIf
if mv_par12 == 1 // Analise do Mec.
	For ni := 1 to Len( aImpVet )
		
		If nLin > 58
			nLin := 1
		EndIf
		
		If nLin == 1
			
			If FunName() == "OFIOR270"
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				@ nLin++,00 psay Repl("*",220)
			Else
				fwrite(outputfile," "+CHR(15)+CHR(13)+CHR(10))
				fwrite(outputfile,"*** "+cTitulo+" ***"+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,STR0039+cEmpr+STR0040+cFil+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
			EndIf
			
		EndIf
		
		If aImpVet[ni,1] == "T"

			nTotLeg12 := ( aImpVet[ni,10] /  aImpVet[ni,07] )*100 
			nTotLeg13 := ( aImpVet[ni,10] / (aImpVet[ni,07] +   aImpVet[ni,08] ) ) * 100
			nTotLeg14 := ( aImpVet[ni,11] /  aImpVet[ni,07] ) * 100
			nTotLeg15 := ( aImpVet[ni,11] / (aImpVet[ni,07] +   aImpVet[ni,08] ) ) * 100
			nTotLeg16 := ( aImpVet[ni,12] /  aImpVet[ni,07] ) * 100
			nTotLeg17 := ( aImpVet[ni,12] / (aImpVet[ni,07] +   aImpVet[ni,08] ) ) * 100
			nTotLeg18 := ( aImpVet[ni,07] /  aImpVet[ni,05] ) * 100
			nTotLeg19 := ((aImpVet[ni,07] +  aImpVet[ni,08] ) / aImpVet[ni,05] ) * 100
			nTotLeg21 := ((aImpVet[ni,11] /  aImpVet[ni,10] )) * 100
			nTotLeg22 := ( aImpVet[ni,07] /  aImpVet[ni,03] ) * 100 

			aTotal[1,01] += aImpVet[ni,3]
			aTotal[1,02] += aImpVet[ni,4]
			aTotal[1,03] += aImpVet[ni,5]
			aTotal[1,04] += aImpVet[ni,6]
			aTotal[1,05] += aImpVet[ni,7]
			aTotal[1,06] += aImpVet[ni,8]
			aTotal[1,07] += aImpVet[ni,9]
			aTotal[1,08] += aImpVet[ni,10]
			aTotal[1,09] += aImpVet[ni,11]
			aTotal[1,10] += aImpVet[ni,12]
			aTotal[1,11] += aImpVet[ni,13]

			aTotal[1,12] += nTotLeg12
			aTotal[1,13] += nTotLeg13
			aTotal[1,14] += nTotLeg14
			aTotal[1,15] += nTotLeg15
			aTotal[1,16] += nTotLeg16
			aTotal[1,17] += nTotLeg17
			aTotal[1,18] += nTotLeg18
			aTotal[1,19] += nTotLeg19
			aTotal[1,20] += nTotLeg21

			aTotal[1,21] += aImpVet[ni,23]
			aTotal[1,22] += aImpVet[ni,24]
			
			If !( Empty(aImpVet[ni,07]) .And. !Empty(aImpVet[ni,04]) )
				aTotal[1,23] += 1
			EndIf
			aTotal[1,24] += aImpVet[ni,28]
			
		EndIf
		
		// Imprime o Total
		If aImpVet[ni,1] == "T"
			
			dbSelectArea("SRJ")
			dbSetOrder(1)
			dbSeek( xFilial("SRJ") + ( cAliasVAI )->VAI_FUNCAO )

			If MV_PAR01 > 1 .Or. nLin <= 7
				
				If FunName() == "OFIOR270"
					nLin++
					nLin++
					@ nLin++,00 psay Space(36)+STR0041
					@ nLin++,00 psay Space(36)+STR0028 //                                  " Tempo   Tempo   Tempo   Tempo   Tempo   Tempo   Tempo   Tempo   Tempo   Tempo  --------------- E f i c i e n c i a -------------------- ---- Produtividade ---- Estoque  Horas"
					@ nLin++,00 psay STR0029 //"Produtivo------------ FunÁ„o------- Dispon. Ausente Efectivo -Parado Trabalh  Extra  Estour. -Padr„o Cobrado Vendido Utiliz. Padr.SE -Padr.CE Cobr.SE Cobr.CE Vend.SE Vend.CE Efet SE Efect CE Cob/Pad Aprovei Nao Lib Liberad" 
					
					OR270_1(nLin, aImpVet, ni, ( cAliasVAI )->VAI_NOMTEC)

				Else

					fwrite(outputfile,""+CHR(13)+CHR(10))
					fwrite(outputfile,""+CHR(13)+CHR(10))
					fwrite(outputfile, Space(44) + STR0041 + CHR(13)+CHR(10) )
					fwrite(outputfile, Space(44) + STR0028 + CHR(13)+CHR(10) ) //                                  " Tempo   Tempo   Tempo   Tempo   Tempo   Tempo   Tempo   Tempo   Tempo   Tempo  --------------- E f i c i e n c i a -------------------- ---- Produtividade ---- Estoque  Horas"
					fwrite(outputfile,STR0029+CHR(13)+CHR(10)) //"Produtivo------------ FunÁ„o------- Dispon. Ausente Efectivo -Parado Trabalh  Extra  Estour. -Padr„o Cobrado Vendido Utiliz. Padr.SE -Padr.CE Cobr.SE Cobr.CE Vend.SE Vend.CE Efet SE Efect CE Cob/Pad Aprovei Nao Lib Liberad" 
					fwrite(outputfile,aImpVet[ni,2] + Space(1) + Substr( ( cAliasVAI )->VAI_NOMTEC ,1 ,14 ) + Space(1) + Substr( SRJ->RJ_DESC ,1 ,13 ) + Space(1) + RetHora(aImpVet[ni,3], "@R 9999:99" ) + Space(1) + RetHora(aImpVet[ni,4] , "@R 9999:99" ) + Space(1) + RetHora(aImpVet[ni,5], "@R 9999:99" ) + Space(1) + RetHora(aImpVet[ni,6], "@R 9999:99" ) + Space(1) + RetHora(aImpVet[ni,7], "@R 9999:99" ) + Space(1) + RetHora(aImpVet[ni,8] , "@R 9999:99" ) + Space(1) + RetHora(aImpVet[ni,9] , "@R 9999:99" )  + Space(1) + RetHora(aImpVet[ni,10] , "@R 9999:99" )  + Space(1) + RetHora(aImpVet[ni,11] , "@R 9999:99" ) + Space(1) + RetHora(aImpVet[ni,12] , "@R 9999:99" ) ;
					+ space(1) + Transform( NoRound( aImpVet[ni,13] ,2) , "@E 9999.99" ) + space(1) + Transform(nTotLeg12, "@E 999.99" ) + "%" + space(1) + Transform(nTotLeg13 , "@E 9999.99" ) + "%" + space(1) + Transform(nTotLeg14 , "@E 999.99" ) + "%" + space(1) + Transform( nTotLeg15 , "@E 999.99" ) + "%" + space(1) + Transform( nTotLeg16 , "@E 999.99" ) + "%" + space(1) + Transform( nTotLeg17 , "@E 999.99" ) + "%" + space(1) + Transform( nTotLeg18 , "@E 999.99" ) + "%" + space(1) + Transform( nTotLeg19 , "@E 999.99" ) + "%" + space(1) + Transform( nTotLeg21 , "@E 999.99" ) + "%" + Space(1) + Transform(nTotLeg22 , "@E 999.99" ) + "%" + Space(1)                        + RetHora(aImpVet[ni,23] , "@R 9999:99" ) + Space(1) + RetHora(aImpVet[ni,24] , "@R 9999:99" )+CHR(13)+CHR(10))
				EndIf
				
			Elseif MV_PAR01 == 1 .and. nLin > 7

					nLin++
					OR270_1(nLin, aImpVet, ni, ( cAliasVAI )->VAI_NOMTEC)

			EndIf
			
			If MV_PAR01 > 2
				If FunName() == "OFIOR270"
					nLin++
					@ nLin++ , 00 psay STR0030 //" Nro OS  S T Inicio Servico Term.  Servico Tipo de Registro--- Servico Executado----------------------- Padrao Aplic. Cobrad Vendid Ausenc"
				Else
					fwrite(outputfile,""+CHR(13)+CHR(10))
					fwrite(outputfile,""+STR0030+CHR(13)+CHR(10))
				EndIf
			EndIf
		Else
			If MV_PAR01 > 2
				If FunName() == "OFIOR270"
					@ nLin++ , 00 psay ;
						aImpVet[ni,3] + Space(1) + ;
						aImpVet[ni,4] + Space(1) + ;
						aImpVet[ni,5] + Space(1) + ;
						OR270FDATA(aImpVet[ni,8]) + Space(1) + ;
						RetHora(aImpVet[ni,9],"@R 99:99") + Space(1) + ;
						OR270FDATA(aImpVet[ni,10]) + Space(1) + ;
						RetHora(aImpVet[ni,11], "@R 99:99" ) + Space(1) + ;
						If( Empty( aImpVet[ni,17] ) , aImpVet[ni,16]+ " - " + If( aImpVet[ni,16] == "E" , STR0031+Space(5) ,STR0032 ) , aImpVet[ni,17] + "- " + Substr( Posicione("SX5",1,xFilial("SX5")+"TA"+aImpVet[ni,17] , "X5_DESCRI" ) ,1,15 ) ) + Space(1) + ;
						aImpVet[ni,6] + Space(1) + ;
						aImpVet[ni,7] + Space(2) + ;
						RetHora(aImpVet[ni,12], "@R 999:99" ) + Space(1) + ;
						RetHora(aImpVet[ni,13], "@R 999:99" ) + Space(1) + ;
						RetHora(aImpVet[ni,14], "@R 999:99" ) + Space(1) + ;
						RetHora(aImpVet[ni,15], "@R 999:99" ) + Space(1) + ;
						RetHora(aImpVet[ni,18] , "@R 999:99"  ) 
				Else
					fwrite(outputfile,aImpVet[ni,3] + Space(1) + aImpVet[ni,4] + Space(1) + aImpVet[ni,5] + Space(1) + OR270FDATA(aImpVet[ni,8]) + Space(1) + RetHora(aImpVet[ni,9],"@R 99:99") + Space(1) + OR270FDATA(aImpVet[ni,10]) + Space(1) + RetHora(aImpVet[ni,11], "@R 99:99" ) + Space(1) + If( Empty( aImpVet[ni,17] ) , aImpVet[ni,16]+ " - " + If( aImpVet[ni,16] == "E" , STR0031+Space(5) ,STR0032 ) , aImpVet[ni,17] + "- " + Substr( Posicione("SX5",1,xFilial("SX5")+"TA"+aImpVet[ni,17] , "X5_DESCRI" ) ,1,15 ) ) + Space(1) + aImpVet[ni,6] + Space(1) + aImpVet[ni,7] + Space(2) + RetHora(aImpVet[ni,12], "@R 999:99" ) + Space(1) + RetHora(aImpVet[ni,13], "@R 999:99" ) + Space(1) + RetHora(aImpVet[ni,14], "@R 999:99" ) + Space(1) + RetHora(aImpVet[ni,15], "@R 999:99" ) + Space(1) + RetHora(aImpVet[ni,18],"@R 999:99" )+CHR(13)+CHR(10)) //"Hora Extra"###"Trabalho Normal"
				Endif
			EndIf
		EndIf
		
	Next
Elseif mv_par12 == 2 // Mapa de Produt.
	if nCont == 1
		@ nLin++,00 psay STR0042
		@ nLin++,00 psay STR0043
		@ nLin++,00 psay STR0044
		nLin++
	Endif
	dbSelectArea("SRJ")
	dbSetOrder(1)
	MsSeek( xFilial("SRJ") + ( cAliasVAI )->VAI_FUNCAO )
	
	For ni := 1 to Len( aImpVet )
		
		If nLin > 58
			nLin := 1
		EndIf
		
		If nLin == 1
			
			nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
			@ nLin++,00 psay Repl("*",220)
			
		EndIf
		
		&& Imprime o Total

		if ni == 1  

			OR270_2(aImpVet, ni, ( cAliasVAI )->VAI_FUNCAO )

			@ nLin++ , 00 psay  aImpVet[ni,2] + Space(2) + ;
								transform(nCont,"9999") + Space(3) + ;
								Substr( ( cAliasVAI )->VAI_NOMTEC ,1 ,18 ) + Space(4) + ;
								( cAliasVAI )->VAI_FUNCAO + Space(1) + ;
								Substr( SRJ->RJ_DESC ,1 ,20 ) + Space(8) + ;
								RetHora(aImpVet[ni,3], "@R 9999:99" ) + Space(5) + ;
								RetHora(aImpVet[ni,5], "@R 9999:99" ) + Space(5) + ;
								RetHora(aImpVet[ni,8], "@R 9999:99" ) + Space(7) + ;
								RetHora(aImpVet[ni,5] + aImpVet[ni,8], "@R 9999:99" ) + Space(7) + ;
								RetHora(aImpVet[ni,7], "@R 9999:99" ) + Space(7) + ;
								RetHora(aImpVet[ni,6], "@R 9999:99" ) + Space(7) + ;
								RetHora(aImpVet[ni,7] + aImpVet[ni,8], "@R 9999:99" ) + Space(9) + ;
								Transform(nProd, "@R 9999.99" ) + "%" + Space(7) + ;
								Transform(aImpVet[ni,15] , "@R 9999.99" ) + "%" + Space(8) + ;
								Transform(nApro, "@R 9999.99" ) + "%"
		Endif
		nCont += 1
	Next

Else // Planilha Excel

	dbSelectArea("SRJ")
	dbSetOrder(1)
	MsSeek( xFilial("SRJ") + ( cAliasVAI )->VAI_FUNCAO )

	For ni := 1 to Len( aImpVet )

		if ni == 1   

			OR270_2(aImpVet, ni, ( cAliasVAI )->VAI_FUNCAO )

			nVarLeg12 :=  ( aImpVet[ni,10] /  aImpVet[ni,07] ) * 100																		// 12 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / Tempo Aplicado ) * 100"
			nVarLeg13 :=  ( aImpVet[ni,10] / (aImpVet[ni,07] + aImpVet[ni,8] ) ) * 100									// 13 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / ( Tempo Aplicado + Tempo Extra ) ) * 100"
			nVarLeg14 :=  ( aImpVet[ni,11] /  aImpVet[ni,07] ) * 100																		// 14 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / Tempo Aplicado) * 100"
			nVarLeg15 :=  ( aImpVet[ni,11] / (aImpVet[ni,07] + aImpVet[ni,8] ) ) * 100									// 15 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / ( Tempo Aplicado + Tempo Extra ) ) * 100"
			nVarLeg16 :=  ( aImpVet[ni,12] /  aImpVet[ni,07] ) * 100																		// 16 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / Tempo Aplicado) * 100"
			nVarLeg17 :=  ( aImpVet[ni,12] / (aImpVet[ni,07] + aImpVet[ni,8] ) ) * 100									// 17 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / ( Tempo Aplicado + Tempo Extra ) ) * 100"
			nVarLeg18 :=  ( aImpVet[ni,07] /  aImpVet[ni,05] ) * 100																		// 18 - % Produtividade sobre Tempo Efetivo (Tempo Aplicado/Tempo Efetivo)"
			nVarLeg19 := (( aImpVet[ni,07] +  aImpVet[ni,08] ) / aImpVet[ni,5] ) * 100									// 19 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo)"
			nVarLeg20 := (( aImpVet[ni,07] +  aImpVet[ni,08] ) / ( aImpVet[ni,5]+aImpVet[ni,8] ) ) * 100// 20 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo+Tempo Extra)"
			nVarLeg21 :=  ( aImpVet[ni,11] /  aImpVet[ni,10] ) * 100																		// 21 - % Produtividade (Tempo Cobrado/Tempo Padrao) * 100"
			nVarLeg22 :=  (aImpVet[ni,7]/aImpVet[ni,3]) * 100																						// 22 - % aproveitamento (tempo trabalhado/tempo disponÌvel) * 100"
			
			AADD(aExpXLS,{aImpVet[ni,2] , 																					;		// 01
										transform(nCont,"9999")																		,	; // 02
										Left( ( cAliasVAI )->VAI_NOMTEC ,18 )											,	; // 03
										( cAliasVAI )->VAI_FUNCAO+ " - " + Left( SRJ->RJ_DESC ,20 ),; // 04
										RetHora(aImpVet[ni,03] , "@R 9999:99" ) 									,	; // 05
										RetHora(aImpVet[ni,03]-aImpVet[ni,5] , "@R 9999:99" )			,	; // 06
										RetHora(aImpVet[ni,08] , "@R 9999:99" )										,	; // 07
										RetHora(aImpVet[ni,05]+aImpVet[ni,8], "@R 9999:99" )			,	; // 08
										RetHora(aImpVet[ni,07] , "@R 9999:99")										, ;	// 09
										RetHora(aImpVet[ni,12] , "@R 9999:99")										, ; // 10
										RetHora(aImpVet[ni,06] , "@R 9999:99")										, ; // 11
										RetHora(aImpVet[ni,07]+aImpVet[ni,8], "@R 9999:99" )			, ; // 12
										Transform(nVarLeg12      , "@E 9999.99")										, ; // 13 - 12 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / Tempo Aplicado ) * 100"
										Transform(nVarLeg13      , "@E 9999.99")										, ; // 14 - 13 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / ( Tempo Aplicado + Tempo Extra ) ) * 100"
										Transform(nVarLeg14      , "@E 999.99" )										, ; // 15 - 14 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / Tempo Aplicado) * 100"
										Transform(nVarLeg15      , "@E 999.99" )										, ; // 16 - 15 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / ( Tempo Aplicado + Tempo Extra ) ) * 100"
										Transform(nVarLeg16      , "@E 999.99" )										, ; // 17 - 16 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / Tempo Aplicado) * 100"
										Transform(nVarLeg17      , "@E 999.99" )										, ; // 18 - 17 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / ( Tempo Aplicado + Tempo Extra ) ) * 100"
										Transform(nVarLeg18      , "@E 999.99" )										, ; // 19 - 18 - % Produtividade sobre Tempo Efetivo (Tempo Aplicado/Tempo Efetivo)"
										Transform(nVarLeg19      , "@E 999.99" )										, ; // 20 - 19 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo)"
										Transform(nVarLeg20      , "@E 999.99" )										, ; // 21 - 20 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo+Tempo Extra)"
										Transform(nVarLeg21      , "@E 999.99" )										, ; // 22 - 21 - % Produtividade (Tempo Cobrado/Tempo Padrao) * 100"
										Transform(nVarLeg22      , "@E 999.99" ) } )										// 23 - 22 - % aproveitamento (tempo trabalhado/tempo disponÌvel) * 100"
		Endif

		nCont += 1

	Next

Endif

If MV_PAR06 == 1 .And. MV_PAR01 # 1 .And. MV_PAR12 == 1 // Analise do Mec.
	
	nLin++
	
	If Len ( aImpSer ) # 0
		
		
		For ni := 1 to Len( aImpSer )
			If ni == 1
				If FunName() == "OFIOR270"
					@ nLin++ , 00 psay STR0033 //"TOTAL POR TIPO DE SERVICO"
					nLin++
					@ nLin++ , 00 psay STR0034 //"TP.  Descricao             Padrao  Trabalh"
				Else
					fwrite(outputfile,STR0033+CHR(13)+CHR(10)) //"TOTAL POR TIPO DE SERVICO"
					fwrite(outputfile,""+CHR(13)+CHR(10))
					fwrite(outputfile,STR0034+CHR(13)+CHR(10)) //"TP.  Descricao             Padrao  Trabalh"
				Endif
			EndIf
			If FunName() == "OFIOR270"
				@ nLin++ , 00 psay aImpSer[ni,01] +Space(2)+ aImpSer[ni,02] +Space(1)+ RetHora(aImpSer[ni,03],"@R 9999:99") +Space(2)+RetHora(aImpSer[ni,04],"@R 9999:99")
			Else
				fwrite(outputfile,aImpSer[ni,01] +Space(2)+ aImpSer[ni,02] +Space(1)+ RetHora(aImpSer[ni,03],"@R 9999:99") +Space(2)+RetHora(aImpSer[ni,04],"@R 9999:99")+CHR(13)+CHR(10))
			Endif
			If ni == Len ( aImpSer )
				If FunName() == "OFIOR270"
					@ nLin++ , 00 psay STR0035 + RetHora(nTotPad,"@R 9999:99")+ Space(2) + RetHora(nTotTra,"@R 9999:99") //"T O T A L................ "
				Else
					fwrite(outputfile,STR0035 + RetHora(nTotPad,"@R 9999:99")+ Space(2) + RetHora(nTotTra,"@R 9999:99")+CHR(13)+CHR(10)) //"T O T A L................ "
				EndIf
			EndIf
		Next
	EndIf
	
	nLin++
	
Endif

Return( nLin )
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥FS_VERPER ∫Autor  ≥Emilton             ∫ Data ≥  08/21/01   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Calcula percentual de participacao no servico               ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Oficina                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function FS_VERPER(cNosNum,cTipTem,cCodSer,nTemTra)

Local nTotTra := 0
Local nPosReg := VO4->(recno())
Local nNOrdem := VO4->(IndexOrd())

VO4->(dbSetOrder(1))

VO4->(dbSeek( xFilial("VO4") + cNosNum + cTipTem + cCodSer ))

While cNosNum == VO4->VO4_NOSNUM .And. cTipTem == VO4->VO4_TIPTEM .And. cCodSer == VO4->VO4_CODSER;
	.And. VO4->VO4_FILIAL == xFilial("VO4") .And. !VO4->(Eof())
	
	nTotTra += VO4->VO4_TEMTRA
	VO4->(dbSkip())
	
EndDo

VO4->(dbSetOrder(nNOrdem))
VO4->(dbGoTo(nPosReg))

Return nTotTra

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥FS_VERSTA ∫Autor  ≥Emilton             ∫ Data ≥  01/15/02   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Verifica Status da Ordem de Servico                         ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Oficina                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function FS_VERSTA()

Local cStatus := "A"

Do Case
	Case !Empty(VO4->VO4_DATCAN)
		cStatus := "C"
	Case !Empty(VO4->VO4_DATFEC)
		cStatus := "F"
	Case !Empty(VO4->VO4_DATDIS)
		cStatus := "D"
EndCase

Return cStatus

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunÁ„o    ≥ FS_OR270C≥ Autor ≥  Fabio                ≥ Data ≥ 17/02/06 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriÁ„o ≥ Calcula tempo e valores dos produtivos                     ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ cCodPro - CÛdigo do Produtivo                              ≥±±
±±≥          ≥ dDatRef - Data de ReferÍncia para o Levantamento           ≥±±
±±≥          ≥ cAssunto- Assunto que a funÁ„o ir· levantar                ≥±±
±±≥          ≥           0 - Horas DisponÌvel                             ≥±±
±±≥          ≥           1 - Horas Padr„o                                 ≥±±
±±≥          ≥           2 - Horas Trabalhadas                            ≥±±
±±≥          ≥           3 - Horas Extras                                 ≥±±
±±≥          ≥           4 - Horas Ausentes                               ≥±±
±±≥          ≥           5 - Horas Vendidas                               ≥±±
±±≥          ≥           6 - Horas Cobradas - Requisicao                  ≥±±
±±≥          ≥           7 - Valor de Venda do ServiÁo                    ≥±±
±±≥          ≥           8 - Quantidade Requisitada de PeÁas              ≥±±
±±≥          ≥           9 - Estoque de Horas Liberadas                   ≥±±
±±≥          ≥           A - Estoque de Horas Nao Liberadas               ≥±±
±±≥          ≥           B - Formula do Usuario                           ≥±±
±±≥          ≥           C - Horas Cobradas - Venda                       ≥±±
±±≥          ≥           D - Totalizador de Pecas (Balcao/Oficina)        ≥±±
±±≥          ≥               com o parametro cTipTot                      ≥±±
±±≥          ≥           E - Totalizador de Pecas por Situacao de Tipo de ≥±±
±±≥          ≥               Tempo ou por Tipo de Tempo                   ≥±±
±±≥          ≥           F - Total de Passagens                           ≥±±
±±≥          ≥           G - Horas Trabalhadas e Fechadas (Audi)          ≥±±
±±≥          ≥           I - Horas Vendidas                               ≥±±
±±≥          ≥ dDatFin - Data Final                                       ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ Generico                                                   ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function FS_OR270CALTEM(cCodPro,dDatRef,cAssunto,nIniHora,nFinHora)

Local nRet       := 0
Local aVerPad    := {}
Local aVetTra    := {}
Local aArea      := {}
Local ix1        := 0
Local cSele      := Alias()
Local dDatIni    := dDatRef
Local ix1_       := 0
Local cAliasVO4  := "SQLVO4"
Local cAliasVO4a := "SQLVO4"

aArea := sGetArea(aArea , Alias())

Do Case
	Case cAssunto == "0"  // Horas Disponiveis
		
		dDatFin := dDatRef
		
		dbSelectArea("VAI")
		dbSetOrder(1)
		If dbSeek(xFilial("VAI")+cCodPro,.f.) .and. ( cAliasVAI )->VAI_FUNPRO == "1"
			For dDatRef := dDatIni to dDatFin
				
				If dDatRef < stod(( cAliasVAI )->VAI_DATADM) // Data Admissao 
					Loop
				EndIf

				If !Empty(stod(( cAliasVAI )->VAI_DATDEM)) .and. dDatRef > stod(( cAliasVAI )->VAI_DATDEM) // Data Demissao
					Loop
				EndIf
				
				//               nRet += FG_TEMPTRA(cCodPro,dDatRef,0,dDatRef,2359,"N",.f.,"D/O")
				
				DbSelectArea("VOE")
				DbSetOrder(1)
				If !DbSeek(xFilial("VOE")+cCodPro+Dtos(dDatRef),.t.)
					
					If eof()
						dbskip(-1)
					Endif
					while xFilial("VOE") == VOE->VOE_FILIAL .and. !bof()
						
						if( VOE->VOE_FILIAL+VOE->VOE_CODPRO # xFilial("VOE")+cCodPro .Or. ;
							( VOE->VOE_FILIAL+VOE->VOE_CODPRO == xFilial("VOE")+cCodPro  .and. VOE->VOE_DATESC > (dDatRef) ))
							DbSkip(-1)
							loop
						EndIf
						Exit
						
					EndDo
					
				EndIf
				
				If VOE->VOE_CODPRO == cCodPro
					
					DbSelectArea("VOH")
					DbSetOrder(1)
					If DbSeek(xFilial("VOH")+VOE->VOE_CODPER)
						
						aVetDis := {}
						Aadd( aVetDis ,VOH->VOH_INIPER)
						Aadd( aVetDis ,VOH->VOH_INICF1)
						Aadd( aVetDis ,VOH->VOH_FINCF1)
						Aadd( aVetDis ,VOH->VOH_INIREF)
						Aadd( aVetDis ,VOH->VOH_FINREF)
						Aadd( aVetDis ,VOH->VOH_INICF2)
						Aadd( aVetDis ,VOH->VOH_FINCF2)
						Aadd( aVetDis ,VOH->VOH_FINPER)
						
						For ix1:=1 to (Len(aVetDis)-1)
							For ix1_:=(ix1+1) to Len(aVetDis)
								If !Empty(aVetDis[ix1]) .And. !Empty(aVetDis[ix1_])
									
									If VOH->VOH_INIPER > VOH->VOH_FINPER
										If aVetDis[ix1] >= nIniHora .And. aVetDis[ix1] <= nFinHora ;
											.And. aVetDis[ix1_] >= nIniHora .And. aVetDis[ix1_] <= nFinHora
											
											nRet += FS_VLSERTP(dDatRef,aVetDis[ix1],dDatRef,(aVetDis[ix1_]+If(aVetDis[ix1_]<aVetDis[ix1],2400,0)))
											ix1:=ix1_
											Exit
											
										EndIf
									Else
										nRet += FS_VLSERTP(dDatRef,aVetDis[ix1],dDatRef,(aVetDis[ix1_]+If(aVetDis[ix1_]<aVetDis[ix1],2400,0)))
										ix1:=ix1_
										Exit
									EndIf
								EndIf
							Next
						Next
						
					EndIf
					
				EndIf
				
			Next
			
		EndIf
		
	Case cAssunto == "4"  // Horas Ausentes
		
		cQuery := "SELECT SUM(VO4.VO4_TEMAUS) FROM "+RetSqlName("VO4")+" VO4 "
		cQuery += "WHERE VO4.VO4_FILIAL='"+xFilial("VO4")+"' AND "
		cQuery += "VO4.VO4_CODPRO = '"+cCodPro+"' AND VO4.VO4_DATINI = '"+dtos(dDatRef)+"' AND VO4.VO4_HORINI >= '"+str(nIniHora)+"' AND VO4.VO4_HORINI <= '"+str(nFinHora)+"' AND "
		cQuery += "VO4.D_E_L_E_T_=' '"
		
		nRet += FM_SQL(cQuery)
		
	Case cAssunto $ "9/A"  // Estoque de Horas
		
		cQuery := "SELECT VO4.VO4_TIPSER,VO4.VO4_NOSNUM,VO4.VO4_TIPTEM,VO4.VO4_CODSER,VO4.VO4_TEMVEN,VO4.VO4_TEMTRA FROM "+RetSqlName("VO4")+" VO4 "
		cQuery += "WHERE VO4.VO4_FILIAL='"+xFilial("VO4")+"' AND "
		cQuery += "VO4.VO4_CODPRO = '"+cCodPro+"' AND VO4.VO4_DATINI = '"+dtos(dDatRef)+"' AND VO4.VO4_HORINI >= '"+str(nIniHora)+"' AND VO4.VO4_HORINI <= '"+str(nFinHora)+"' AND "
		if cAssunto == "9"
			cQuery += "VO4.VO4_DATDIS = '        ' AND "
		Else
			cQuery += "VO4.VO4_DATDIS <> '        ' AND "
		Endif
		cQuery += "VO4.VO4_DATFEC = '        ' AND "
		cQuery += "VO4.VO4_DATCAN = '        ' AND "
		cQuery += "VO4.D_E_L_E_T_=' '
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasVO4a,.T.,.T.)
		
		Do While !( cAliasVO4a )->( Eof() )
			
			dbSelectArea("VOK")
			dbSetOrder(1)
			If dbSeek(xFilial("VOK")+( cAliasVO4a )->VO4_TIPSER)
				If VOK->VOK_INCTEM == "3"
					nRet += ( cAliasVO4a )->VO4_TEMTRA
				Else
					ix1 := aScan(aVerPad, {|x| x[1]+x[2]+x[3] == ( cAliasVO4a )->VO4_NOSNUM+( cAliasVO4a )->VO4_TIPTEM+( cAliasVO4a )->VO4_CODSER})
					If ix1 == 0
						aAdd(aVerPad,{( cAliasVO4a )->VO4_NOSNUM,( cAliasVO4a )->VO4_TIPTEM,( cAliasVO4a )->VO4_CODSER})
						nRet += ( cAliasVO4a )->VO4_TEMVEN
					EndIf
				EndIf
			EndIf
			
			dbSelectArea(cAliasVO4a)
			( cAliasVO4a )->(dbSkip())
			
		EndDo
		( cAliasVO4a )->(dbCloseArea())
		
		
EndCase

DbSelectArea("VOH")
sRestArea(aArea)
dbSelectArea(cSele)

Return nRet
/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|FunáÑo    | OF270XLS   | Autor |  Thiago               | Data | 21/08/12 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|DescriáÑo | Exporta InformaÁıes para Planilha                            |##
##+----------+--------------------------------------------------------------+##
##|Uso       | Veiculos                                                     |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
User Function OF270XLS()
Local nCntFor
Local oExcel := FWMSEXCEL():New()
Local nCalcTot12 :=  ( nTmpPad /  nTmpTra )*100                            // 12 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / Tempo Aplicado ) * 100"
Local nCalcTot13 :=  ( nTmpPad / (nTmpTra + nHrsExt ) ) * 100              // 13 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / ( Tempo Aplicado + Tempo Extra ) ) * 100"
Local nCalcTot14 :=  ( nTmpCob /  nTmpTra ) * 100                          // 14 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / Tempo Aplicado) * 100"
Local nCalcTot15 :=  ( nTmpCob / (nTmpTra + nHrsExt ) ) * 100              // 15 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / ( Tempo Aplicado + Tempo Extra ) ) * 100"
Local nCalcTot16 :=  ( nTmpVen /  nTmpTra ) * 100                          // 16 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / Tempo Aplicado) * 100"
Local nCalcTot17 :=  ( nTmpVen / (nTmpTra + nHrsExt ) ) * 100              // 17 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / ( Tempo Aplicado + Tempo Extra ) ) * 100"
Local nCalcTot18 :=  ( nTmpTra /  nTmpDisp ) * 100                         // 18 - % Produtividade sobre Tempo Efetivo (Tempo Aplicado/Tempo Efetivo)"
Local nCalcTot19 := (( nTmpTra +  nHrsExt ) / nTmpDisp ) * 100             // 19 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo)"
Local nCalcTot20 := (( nTmpTra +  nHrsExt ) / ( nTmpDisp+nHrsExt ) ) * 100 // 20 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo+Tempo Extra)"
Local nCalcTot21 :=  ( nTmpCob /  nTmpPad ) * 100                          // 21 - % Produtividade (Tempo Cobrado/Tempo Padrao) * 100"
Local nCalcTot22 :=  ( nTmpTra /  nHrsDisp ) * 100                         // 22 - Aproveitamento

                             
oExcel:AddWorkSheet(STR0080)
oExcel:AddTable(STR0080,STR0080)

oExcel:AddColumn( STR0080 , STR0080 ,STR0081 , 1 , 1 ) // 01 Codigo
oExcel:AddColumn( STR0080 , STR0080 ,STR0082 , 1 , 1 ) // 02 Seq
oExcel:AddColumn( STR0080 , STR0080 ,STR0083 , 1 , 1 ) // 03 Produtivo
oExcel:AddColumn( STR0080 , STR0080 ,STR0084 , 1 , 1 ) // 04 FunÁ„o
oExcel:AddColumn( STR0080 , STR0080 ,STR0085 , 1 , 1 ) // 05 Tpo DisponÌvel
oExcel:AddColumn( STR0080 , STR0080 ,STR0086 , 1 , 1 ) // 06 Tpo Ausente
oExcel:AddColumn( STR0080 , STR0080 ,STR0087 , 1 , 1 ) // 07 Tpo Extra
oExcel:AddColumn( STR0080 , STR0080 ,STR0088 , 1 , 1 ) // 08 Tpo Efetivo
oExcel:AddColumn( STR0080 , STR0080 ,STR0089 , 1 , 1 ) // 09 Tpo Trabalhado
oExcel:AddColumn( STR0080 , STR0080 ,STR0096 , 1 , 1 ) // 10 Tpo Vendido
oExcel:AddColumn( STR0080 , STR0080 ,STR0090 , 1 , 1 ) // 11 Tpo Parado
oExcel:AddColumn( STR0080 , STR0080 ,STR0091 , 1 , 1 ) // 12 Tpo Trab + Extra

oExcel:AddColumn( STR0080 , STR0080 ,STR0099 , 1 , 1 ) // 13 Padr.SE (12)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0100 , 1 , 1 ) // 14 Padr.CE (13)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0101 , 1 , 1 ) // 15 Cobr.SE (14)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0102 , 1 , 1 ) // 16 Cobr.CE (15)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0103 , 1 , 1 ) // 17 Vend.SE (16)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0104 , 1 , 1 ) // 18 Vend.CE (17)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0105 , 1 , 1 ) // 19 Efet SE (18)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0106 , 1 , 1 ) // 20 Efet CE (19)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0107 , 1 , 1 ) // 21 Efet CE+E (20)"

oExcel:AddColumn( STR0080 , STR0080 ,STR0108 , 1 , 1 ) // 22 Cob/Pad (21)"
oExcel:AddColumn( STR0080 , STR0080 ,STR0109 , 1 , 1 ) // 23 Aprovei (22)"


nProdut := ((nTmpTra+nHrsExt)/(nTmpDisp+nHrsExt)*100)       
nAprov := 	100 * nTmpTra / nHrsDisp

// TOTAL
oExcel:AddRow( STR0080 , STR0080 , {  ,; 					//01
,;																								//02
,;																								//03
STR0056 ,;	 																			//04
RetHora(nHrsDisp   , "@R 9999:99" )			,;				//05
RetHora(nHrsDisp-nHEfTot,"@R 9999:99" ) ,;				//06
RetHora(nHrsExt    , "@R 9999:99" )			,;				//07
RetHora(nHEfTot    , "@R 9999:99" )			,;				//08
RetHora(nTmpTra    , "@R 9999:99" )			,;				//09
RetHora(nTmpVen    , "@R 9999:99" )			,; 				//10
RetHora(nTmpPed    , "@R 9999:99" )			,;				//11
RetHora(nTmpHExt   , "@R 9999:99" )			,; 				//12
Transform(nCalcTot12 , "@E 9999.99" ) + "%" 		,; 				//13
Transform(nCalcTot13 , "@E 9999.99" ) + "%" 		,; 				//14
Transform(nCalcTot14 , "@E 9999.99" ) + "%" 		,; 				//15
Transform(nCalcTot15 , "@E 9999.99" ) + "%" 		,; 				//16
Transform(nCalcTot16 , "@E 9999.99" ) + "%" 		,; 				//17
Transform(nCalcTot17 , "@E 9999.99" ) + "%" 		,; 				//18
Transform(nCalcTot18 , "@E 9999.99" ) + "%" 		,;				//19
Transform(nCalcTot19 , "@E 9999.99" ) + "%" 		,; 				//20
Transform(nCalcTot20 , "@E 9999.99" ) + "%" 		,; 				//21
Transform(nCalcTot21 , "@E 9999.99" ) + "%" 		,;				//22
Transform(nCalcTot22 , "@E 9999.99" ) + "%" })						//23

// Produtivos
for nCntFor := 1 to Len(aExpXLS)
	oExcel:AddRow( STR0080 , STR0080 , {  aExpXLS[nCntFor,01] ,  ; //01
										aExpXLS[nCntFor,02] ,  ; //02
										aExpXLS[nCntFor,03] ,  ; //03
										aExpXLS[nCntFor,04] ,  ; //04
										aExpXLS[nCntFor,05] ,  ; //05
										aExpXLS[nCntFor,06] ,  ; //06
										aExpXLS[nCntFor,07] ,  ; //07
										aExpXLS[nCntFor,08] ,  ; //08
										aExpXLS[nCntFor,09] ,  ; //09
										aExpXLS[nCntFor,10] ,  ; //10
										aExpXLS[nCntFor,11] ,  ; //11
										aExpXLS[nCntFor,12] ,  ; //12
										aExpXLS[nCntFor,13] + "%" ,  ; //13
										aExpXLS[nCntFor,14] + "%" ,  ; //14
										aExpXLS[nCntFor,15] + "%" ,  ; //15
										aExpXLS[nCntFor,16] + "%" ,  ; //16
										aExpXLS[nCntFor,17] + "%" ,  ; //17
										aExpXLS[nCntFor,18] + "%" ,  ; //18
										aExpXLS[nCntFor,19] + "%" ,  ; //19
										aExpXLS[nCntFor,20] + "%" ,  ; //20
										aExpXLS[nCntFor,21] + "%" ,  ; //21
										aExpXLS[nCntFor,22] + "%" ,  ; //22
										aExpXLS[nCntFor,23] + "%" } )  //23
Next
 
cNomeArq := Alltrim(mv_par14)+"OFIOR270.xls"   
 
MsgInfo(STR0095+CHR(13)+CHR(10)+Alltrim(mv_par14)+"OFIOR270.xls")

oExcel:Activate()

oExcel:GetXMLFile(cNomeArq)
oExcel:DeActivate()
 
Return
/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|FunáÑo    | RetHora    | Autor |  Luis Delorme         | Data | 21/05/13 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|DescriáÑo | Retorna a Hora conforme a opÁ„o de pictire escolhida         |##
##+----------+--------------------------------------------------------------+##
##|Uso       | Veiculos                                                     |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
Static Function RetHora(nHora,cPicture)
//	nValInt = INT(nHora/100)
//	nValResto = nHora % 100
//	nMin = Round(60 * nValResto / 100,0) 
//	nHora = nValInt * 100 + nMin 

if MV_PAR13 == 2
	cPicture := STUFF(cPicture, AT(":",cPicture),1, ".")
	cPicture := STUFF(cPicture, AT("R",cPicture),1, "E")
	return Transform(nHora/100,cPicture)
endif

return Transform(nHora,cPicture)

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ValidPergA   ∫Autor  ≥Fabio               ∫ Data ≥  11/13/00   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Criacao das perguntes.					                     ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Oficina                                                       ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ValidPergA

local _sAlias := Alias()
local aRegs := {}
local i,j
Local nOpcGetFil := GETF_LOCALHARD + GETF_NETWORKDRIVE + GETF_RETDIRECTORY

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

aAdd(aRegs,{cPerg,"09",STR0049,"","","mv_ch9","C",6,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","VOH",""})
aAdd(aRegs,{cPerg,"10",STR0050,"","","mv_chA","C",FwSizeFilial(),0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11",STR0051,"","","mv_chB","C",FwSizeFilial(),0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12",STR0052,"","","mv_chC","N",1,0,0,"C","","mv_par12",STR0053,"","","","",STR0054,"","","","",STR0055,"","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13",STR0057,"","","mv_chD","N",1,0,0,"C","","mv_par13",STR0058,"","","","",STR0059,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14",STR0060,"","","mv_chE","C",40,0,0,"G","!Vazio().or.(mv_par14:=cGetFile('Arquivos |*.*','',,,,"+AllTrim(Str(nOpcGetFil))+"))","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15",STR0077,"","","mv_chF","N",1,0,0,"C","","mv_par15",STR0078,"","","","",STR0079,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16",STR0097,"","","mv_chG","C",1,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","VX5AUX",""}) // Class. Habilidade TÈcnico

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

dbSelectArea(_sAlias)

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ OR270FDATA ∫Autor  ≥ Thiago             ∫ Data ≥  25/04/17 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Formata data para impress„o do relatorio                   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Parametros≥ dData - Data a ser formatada                               ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Oficina                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function OR270FDATA( dData )

Local cRetorno := ""

If Empty(dData)
	cRetorno := space(8)
Else
	cRetorno := StrZero(Day(dData),2) + "/" + StrZero(Month(dData),2) + "/" + Right(Str(Year(dData),4),2)
EndIf

Return cRetorno


/*/{Protheus.doc} OR270_1
Funcao responsavel por imprimir os Valores por Produtivo quando n„o È Excel
@author Manoel
@since 05/01/2018
@version 1.0
/*/
Static Function OR270_1(nLin, aimpVet, ni, cNomTec)

Local nTotLeg12 := ( aImpVet[ni,10] /  aImpVet[ni,07] ) * 100 
Local nTotLeg13 := ( aImpVet[ni,10] / (aImpVet[ni,07] +   aImpVet[ni,08] ) ) * 100
Local nTotLeg14 := ( aImpVet[ni,11] /  aImpVet[ni,07] ) * 100
Local nTotLeg15 := ( aImpVet[ni,11] / (aImpVet[ni,07] +   aImpVet[ni,08] ) ) * 100
Local nTotLeg16 := ( aImpVet[ni,12] /  aImpVet[ni,07] ) * 100
Local nTotLeg17 := ( aImpVet[ni,12] / (aImpVet[ni,07] +   aImpVet[ni,08] ) ) * 100
Local nTotLeg18 := ( aImpVet[ni,07] /  aImpVet[ni,05] ) * 100
Local nTotLeg19 := ((aImpVet[ni,07] +  aImpVet[ni,08] ) / aImpVet[ni,05] ) * 100
Local nTotLeg21 := ((aImpVet[ni,11] /  aImpVet[ni,10] )) * 100
Local nTotLeg22 := ( aImpVet[ni,07] /  aImpVet[ni,03] ) * 100 

@ nLin++ , 00 psay aImpVet[ni,2] + Space(1) + ;
									Left( cNomTec ,14 ) + Space(1) + ;
									Left( SRJ->RJ_DESC ,13 ) + Space(1) + ;
									RetHora(aImpVet[ni,3]  , "@R 9999:99" ) + Space(1) + ;    //"01 - Tempo Disponivel, de acordo com a escala"
									RetHora(aImpVet[ni,4]  , "@R 9999:99" ) + Space(1) + ;    //"02 - Tempo Ausente"
									RetHora(aImpVet[ni,5]  , "@R 9999:99" ) + Space(1) + ;    //"03 - Tempo Efetivo = Tempo Disponivel - Tempo Ausente"
									RetHora(aImpVet[ni,6]  , "@R 9999:99" ) + Space(1) + ;    //"04 - Tempo Sem Aplicacao ou parado"
									RetHora(aImpVet[ni,7]  , "@R 9999:99" ) + Space(1) + ;    //"05 - Tempo Aplicado ou Trabalhado"
									RetHora(aImpVet[ni,8]  , "@R 9999:99" ) + Space(1) + ;    //"06 - Tempo Extra, ou Tempo Aplicado FORA da escala normal"
									RetHora(aImpVet[ni,9]  , "@R 9999:99" ) + Space(1) + ;    //"07 - Tempo Estourado, ou total do tempo de execucao fora da tabela"
									RetHora(aImpVet[ni,10] , "@R 9999:99" ) + Space(1) + ;    //"08 - Tempo Padrao"
									RetHora(aImpVet[ni,11] , "@R 9999:99" ) + Space(1) + ;    //"09 - Tempo Cobrado, ou Tempo Padrao com Acrescimos ou Descontos"
									RetHora(aImpVet[ni,12] , "@R 9999:99" ) + space(1) + ;    //"10 - Tempo Vendido"
									Transform( NoRound( aImpVet[ni,13] ,2) , "@E 9999.99" ) + space(1) + ; //"11 - Estoque de Horas Liberadas"
									Transform(nTotLeg12    , "@E 9999.99" ) + "%" + space(1) + ;//"12 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / Tempo Aplicado ) * 100"
									Transform(nTotLeg13    , "@E 9999.99" ) + "%" + space(1) + ;//"13 - % Eficiencia sobre Tempo Padrao ( Tempo Padrao / ( Tempo Aplicado + Tempo Extra ) ) * 100"
									Transform(nTotLeg14    , "@E 999.99"  ) + "%" + space(1) + ;//"14 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / Tempo Aplicado) * 100"
									Transform(nTotLeg15    , "@E 999.99"  ) + "%" + space(1) + ;//"15 - % Eficiencia sobre Tempo Cobrado ( Tempo Cobrado / ( Tempo Aplicado + Tempo Extra ) ) * 100"
									Transform(nTotLeg16    , "@E 999.99"  ) + "%" + space(1) + ;//"16 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / Tempo Aplicado) * 100"
									Transform(nTotLeg17    , "@E 999.99"  ) + "%" + space(1) + ;//"17 - % Eficiencia sobre Tempo Vendido ( Tempo Vendido / ( Tempo Aplicado + Tempo Extra ) ) * 100"
									Transform(nTotLeg18    , "@E 999.99"  ) + "%" + space(1) + ;//"18 - % Produtividade sobre Tempo Efetivo (Tempo Aplicado/Tempo Efetivo)"
									Transform(nTotLeg19    , "@E 999.99"  ) + "%" + space(1) + ;//"19 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo)"
									Transform(nTotLeg21    , "@E 999.99"  ) + "%" + Space(1) + ;//"21 - % Produtividade (Tempo Cobrado/Tempo Padrao) * 100"
									Transform(nTotLeg22    , "@E 999.99"  ) + "%" + Space(1) + ;//"22 - % aproveitamento (tempo trabalhado/tempo disponÌvel) * 100"
									RetHora(aImpVet[ni,23] , "@R 9999:99" ) + Space(1) + ;    //"23 - Horas Aplicadas e nao Liberadas"
									RetHora(aImpVet[ni,24] , "@R 9999:99" )                   //"24 - Horas Aplicadas e Liberadas"

// N„o coube no relatÛrio mas est· no Excel
//									Transform(aImpVet[ni,28] , "@E 999.99" ) + "%" + space(1) + ; //"20 - % Produtividade sobre Tempo Efetivo ((Tempo Aplicado+Tempo Extra)/Tempo Efetivo+Tempo Extra)"

Return

/*/{Protheus.doc} OR270_2
Funcao responsavel por Totalizar os Valores conforme lÍ os Produtivos
@author Manoel
@since 05/01/2018
@version 1.0
/*/
Static Function OR270_2(aImpVet,ni,cFuncao)

nProd      := ((aImpVet[ni,7]+aImpVet[ni,8])/(aImpVet[ni,5]+aImpVet[ni,8])*100)
nApro      := (nProd*aImpVet[ni,15])/100
nHrsDisp   += aImpVet[ni,3]
nTmpDisp   += aImpVet[ni,5]
nHrsExt    += aImpVet[ni,8]
nHEfTot    += aImpVet[ni,5]+aImpVet[ni,8]
nTmpTra    += aImpVet[ni,7]
nTmpPed    += aImpVet[ni,6]
nTmpHExt   += aImpVet[ni,7]+aImpVet[ni,8]
nProdut    += nProd
nTmpVen    += aImpVet[ni,12]
nEfic      += aImpVet[ni,15]
nAprov     += nApro
nTmpPad    += aImpVet[ni,10]
nTmpCob    += aImpVet[ni,11]

Return

