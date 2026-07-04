/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 8      º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "OFIRVW02.CH"

/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|Função    |  OFIRVW02  | Autor | Luis Delorme          | Data | 17/04/13 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|Descrição |  Geração do relatório PPA (Performance de Peças e Acessorios)|##
##|          |  para Caminhões e Ônibus VW/MAN                              |##
##|          |  Versão 04/2013                                              |##
##+----------+--------------------------------------------------------------+##
##|Uso       |  VOLSWAGEN CAMINHOES E ONIBUS - OFICINA                      |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
User Function OFIRVW02()

Local cDesc1  := STR0001
Local cDesc2  := STR0002
Local cDesc3  := STR0003
Local aSay := {}
Local aButton := {}
//
Private cTitulo := STR0004
Private cPerg 	:= 'ORVW02'
Private cNomRel := 'OFIRVW02'
Private nOpc
//
Private cGruVei     := PadR(AllTrim(GetNewPar("MV_GRUVEI","VEIC")),TamSx3("B1_GRUPO")[1]," ") // Grupo do Veiculo
Private cGruSrv     := PadR(AllTrim(GetNewPar("MV_GRUSRV","SRVC")),TamSx3("B1_GRUPO")[1]," ") // Grupo do Servico
//
CriaSX1()
//
aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )
aAdd( aSay, cDesc3 )
//
aAdd( aButton, { 5, .T., {|| Pergunte(cPerg,.t. )    }} )
aAdd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
aAdd( aButton, { 2, .T., {|| FechaBatch()            }} )
//

FormBatch( cTitulo, aSay, aButton )
//
If nOpc <> 1
	Return
Endif
//
Pergunte(cPerg,.f.)
//
oProcTTP := MsNewProcess():New({ |lEnd| RunProc() },' ','',.f.)
oProcTTP:Activate()
//
return
/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|Função    | RunProc    | Autor | André Delorme         | Data | 17/04/13 |##
##+----------+------------+-------+-----------------------+------+----------+##
###############################################################################
===============================================================================
*/
Static Function RunProc(lEnd)
Local nCntFor, ni
Local lAdjustToLegacy := .F.
Local lDisableSetup  := .T.
Local oPrinter
Local cImposto := ""
cAliasSBM := GetNextAlias()

//
Private oVerdana9 := TFont():New( 'Verdana' , 6 , 10 , , .F. , , , , .T. , .F. )
//
CSTARTPATH := GETPVPROFSTRING(GETENVSERVER(),'StartPath','ERROR',GETADV97())
CSTARTPATH += IF(RIGHT(CSTARTPATH,1) <> '\','\','')
CSTARTPATH = '\spool\'
//
oPrinter := FWMSPrinter():New('OFIRVW02', IMP_PDF, lAdjustToLegacy,CSTARTPATH , lDisableSetup)
oPrinter:SetLandscape()
oPrinter:SetPaperSize(DMPAPER_A4)
oPrinter:SetMargin(0,0,0,0)
oPrinter:cPathPDF := CSTARTPATH
//
cCliGov := MV_PAR03
cCliSegur := MV_PAR04
cCliLoja := MV_PAR05
cCliOfiInd := MV_PAR06
cCliRede := MV_PAR07
cCliFrot := MV_PAR08
cForFabr := MV_PAR09
cForDSH := MV_PAR10
cGLubComb := MV_PAR11
cGAce := MV_PAR12
cGrupoOut := MV_PAR13
cDescTip := MV_PAR14
cMarcaVW := MV_PAR15
cMarcaMAN := MV_PAR16
cCFOTrans := MV_PAR17
cCFOTraSai := mv_par18

cConsidera := mv_par22

//
nPag = 1
cStrTit := DTOC(MV_PAR01) + ' - ' + DTOC(MV_PAR02)
//
aPPA := {;
{1,0,0,7,1,'C','@!',STR0054+" " + cStrTit},{2,1,0,2,1,'C','@!',STR0046},{3,2,0,1,8,'C','@!',STR0015},;
{4,2,1,1,1,'C','@!',STR0007},{5,3,1,1,1,'C','@!',STR0008},{6,4,1,1,1,'C','@!',STR0009},{7,5,1,1,1,'C','@!',STR0010},;
{8,6,1,1,1,'C','@!',STR0056},{9,7,1,1,1,'C','@!',STR0035},{10,8,1,1,1,'C','@!',STR0023},{11,9,1,1,1,'C','@!',STR0016},;
{12,1,2,1,1,'C','@!',STR0038},{13,2,2,1,1,'N','@E 999,999,999.99',0},{14,3,2,1,1,'N','@E 999,999,999.99',0},{15,4,2,1,1,'N','@E 999,999,999.99',0},{16,5,2,1,1,'N','@E 999,999,999.99',0},;
{17,6,2,1,1,'N','@E 999,999,999.99',0},{18,7,2,1,1,'N','@E 999,999,999.99',0},{19,8,2,1,1,'N','@E 999,999,999.99',0},{20,9,2,1,1,'N','@E 999,999,999.99',0},{21,1,3,1,1,'C','@!',STR0018},;
{22,2,3,1,1,'N','@E 999,999,999.99',0},{23,3,3,1,1,'N','@E 999,999,999.99',0},{24,4,3,1,1,'N','@E 999,999,999.99',0},{25,5,3,1,1,'N','@E 999,999,999.99',0},{26,6,3,1,1,'N','@E 999,999,999.99',0},;
{27,7,3,1,1,'N','@E 999,999,999.99',0},{28,8,3,1,1,'N','@E 999,999,999.99',0},{29,9,3,1,1,'N','@E 999,999,999.99',0},{30,1,4,2,1,'C','@!',STR0046},;
{31,2,4,1,8,'C','@!',STR0064},{32,2,5,1,1,'C','@!',STR0033},{33,3,5,1,1,'C','@!',STR0032},;
{34,4,5,1,1,'C','@!',STR0031},{35,5,5,1,1,'C','@!',STR0030},{36,6,5,1,1,'C','@!',STR0060},;
{37,7,5,1,1,'C','@!',STR0059},{38,8,5,1,1,'C','@!',STR0037},{39,9,5,1,1,'C','@!',STR0061},;
{40,1,6,1,1,'C','@!',STR0039},{41,2,6,1,1,'N','@E 999,999,999.99',0},{42,3,6,1,1,'N','@E 999,999,999.99',0},{43,4,6,1,1,'N','@E 999,999,999.99',0},{44,5,6,1,1,'N','@E 999,999,999.99',0},;
{45,6,6,1,1,'N','@E 999,999,999.99',0},{46,7,6,1,1,'N','@E 999,999,999.99',0},{47,8,6,1,1,'N','@E 999,999,999.99',0},{48,9,6,1,1,'N','@E 999,999,999.99',0},{49,10,0,2,1,'C','@!',STR0046},;
{50,11,0,1,7,'C','@!',STR0047},{51,11,1,1,1,'C','@!',STR0007},{52,12,1,1,1,'C','@!',STR0035},{53,13,1,1,1,'C','@!',STR0008},;
{54,14,1,1,1,'C','@!',STR0027},{55,15,1,1,1,'C','@!',STR0036},{56,16,1,1,1,'C','@!',STR0023},;
{57,17,1,1,1,'C','@!',STR0062},{58,10,2,1,1,'C','@!',STR0038},{59,11,2,1,1,'N','@E 999,999,999.99',0},{60,12,2,1,1,'N','@E 999,999,999.99',0},;
{61,13,2,1,1,'N','@E 999,999,999.99',0},{62,14,2,1,1,'N','@E 999,999,999.99',0},{63,15,2,1,1,'N','@E 999,999,999.99',0},{64,16,2,1,1,'N','@E 999,999,999.99',0},{65,17,2,1,1,'N','@E 999,999,999.99',0},;
{66,10,3,1,1,'C','@!',STR0018},{67,11,3,1,1,'N','@E 999,999,999.99',0},{68,12,3,1,1,'N','@E 999,999,999.99',0},{69,13,3,1,1,'N','@E 999,999,999.99',0},{70,14,3,1,1,'N','@E 999,999,999.99',0},;
{71,15,3,1,1,'N','@E 999,999,999.99',0},{72,16,3,1,1,'N','@E 999,999,999.99',0},{73,17,3,1,1,'N','@E 999,999,999.99',0},{74,10,4,2,1,'C','@!',STR0046},;
{75,11,4,1,6,'C','@!',STR0022},{76,11,5,1,1,'C','@!',STR0026},{77,12,5,1,1,'C','@!',STR0029},{78,13,5,1,1,'C','@!',STR0056},;
{79,14,5,1,1,'C','@!',STR0043},{80,15,5,1,1,'C','@!',STR0034},{81,16,5,1,1,'C','@!',STR0049},;
{82,10,6,1,1,'C','@!',STR0039},{83,11,6,1,1,'N','@E 999,999,999.99',0},{84,12,6,1,1,'N','@E 999,999,999.99',0},{85,13,6,1,1,'N','@E 999,999,999.99',0},;
{86,14,6,1,1,'N','@E 999,999,999.99',0},{87,15,6,1,1,'N','@E 999,999,999.99',0},{88,16,6,1,1,'N','@E 999,999,999.99',0},{89,17,4,2,1,'C','@!',STR0046},;
{90,17,6,1,1,'C','@!',STR0024},{91,18,0,2,1,'C','@!',STR0046},{92,19,1,1,1,'C','@!',STR0013},{93,20,1,1,1,'C','@!',STR0050},;
{94,18,2,1,1,'C','@!',STR0038},{95,19,2,1,1,'N','@E 999,999,999.99',0},{96,20,2,1,1,'N','@E 999,999,999.99',0},{97,18,3,1,1,'C','@!',STR0018},;
{98,19,3,1,1,'N','@E 999,999,999.99',0},{99,20,3,1,1,'N','@E 999,999,999.99',0},{100,18,4,1,3,'C','@!',STR0051},;
{101,18,5,1,1,'C','@!',STR0017},{102,19,5,1,1,'C','@!',STR0055},{103,20,5,1,1,'C','@!',STR0014},;
{104,18,6,1,1,'N','@E 999,999,999.99',0},{105,19,6,1,1,'N','@E 999,999,999.99',0},{106,20,6,1,1,'N','@E 999,999,999.99',0},{107,19,0,1,2,'C','@!',STR0051} }
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
cFornVW := ""
cFornMAN := ""
DBSelectArea("VE4")
DBGoTop()
while !eof() .and. xFilial("VE4") == VE4->VE4_FILIAL
	if VE4->VE4_PREFAB $ cMarcaVW
		cFornVW +=Left(VE4->VE4_CGCFAB,8)+"|"
	elseif VE4->VE4_PREFAB $ cMarcaMAN
		cFornMAN +=Left(VE4->VE4_CGCFAB,8)+"|"
	endif
	DBSkip()
enddo
//
cQryAl001 := GetNextAlias()
cQuery := " SELECT DISTINCT VEC_NUMOSV NUMOSV, VEC_TIPTEM TIPTEM, VEC_GRUITE GRUITE ,VEC_CODITE CODITE FROM " + RetSqlName('VEC')
cQuery += " WHERE VEC_FILIAL = '"+xFilial('VEC')+"' AND D_E_L_E_T_ = ' ' AND VEC_DATVEN BETWEEN '"+dtos(MV_PAR01)+"' AND '"+dtos(MV_PAR02)+"'"
//
dbUseArea( .T., 'TOPCONN', TcGenQry( ,, cQuery ), cQryAl001, .F., .T. )
aOSTTP := {}
while !((cQryAl001)->(eof()))
	If Select(cAliasSBM) > 0
		( cAliasSBM )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SBM.BM_CODMAR, SBM.BM_DESC, SBM.BM_PROORI, SBM.BM_GRUPO ,SBM.BM_TIPGRU "
	cQuery += "FROM "+RetSqlName( "SBM" ) + " SBM "
	cQuery += "WHERE "
	cQuery += "SBM.BM_FILIAL='"+ xFilial("SBM")+ "' AND "
	cQuery += "SBM.BM_GRUPO='"+(cQryAl001)->(GRUITE)+"' AND "
	cQuery += "SBM.D_E_L_E_T_=' ' ORDER BY SBM.BM_GRUPO"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSBM, .T., .T. )

	if MV_PAR22 == 1
		if Alltrim((cAliasSBM)->BM_TIPGRU) == "3"
			DbSelectArea(cQryAl001)
			Dbskip()
			loop
		Endif	
	Elseif MV_PAR22 == 2
		if Alltrim((cAliasSBM)->BM_TIPGRU) <> "3"
			DbSelectArea(cQryAl001)
			Dbskip()
			loop
		Endif	
   Endif
//	aOSTTPC := FMX_CALPEC((cQryAl001)->(NUMOSV), (cQryAl001)->(TIPTEM),,,.f.,.f.,.t.,.f.,.t.,.t.,.f.,,"VEC_DATVEN BETWEEN '"+dtos(MV_PAR01)+"' AND '"+dtos(MV_PAR02)+"'" )
	aOSTTPC := FMX_CALPEC((cQryAl001)->(NUMOSV),,(cQryAl001)->(GRUITE),(cQryAl001)->(CODITE),.f.,.f.,.t.,.f.,.t.,.t.,.f.,,"VEC_DATVEN BETWEEN '"+dtos(MV_PAR01)+"' AND '"+dtos(MV_PAR02)+"'" )
	if len(aOSTTPC) > 0
		for nCntFor := 1 to Len(aOSTTPC)
			aAdd(aOSTTP,aOSTTPC[nCntFor])
		next
	endif
	DbSelectArea(cQryAl001)
	(cQryAl001)->(dbSkip())
enddo
//
DBSelectArea('VOI')
DBSetOrder(1)
//
DBSelectArea('SA1')
DBSetOrder(1)
//
DBSelectArea('SF2')
DBSetOrder(1)
//
(cQryAl001)->(dbCloseArea())
for nCntFor := 1 to Len(aOSTTP)
	// VOI_SITTPO:  1=Publico;2=Garantia;3=Interno;4=Revisao
	if !VOI->(DBSeek(xFilial('VOI')+aOSTTP[nCntFor,3]))
		MsgInfo(STR0058 + aOSTTP[nCntFor,3])
		loop
	endif
	if !SA1->(DBSeek(xFilial('SA1')+aOSTTP[nCntFor,15]+aOSTTP[nCntFor,16]))
		MsgInfo(STR0021 + aOSTTP[nCntFor,15] + '/' + aOSTTP[nCntFor,16])
		loop
	endif
	if VOI->VOI_SITTPO == '3'
		aPPA[64,8] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7] - aOSTTP[nCntFor,33]
		aPPA[72,8] += aOSTTP[nCntFor,31]
	elseif VOI->VOI_SITTPO == '2'
		aPPA[63,8] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7] - aOSTTP[nCntFor,33]
		aPPA[71,8] += aOSTTP[nCntFor,31]
	elseif aOSTTP[nCntFor,1] $ cGLubComb
		aPPA[96,8] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7] - aOSTTP[nCntFor,33]
		aPPA[99,8] += aOSTTP[nCntFor,31]
	elseif aOSTTP[nCntFor,1] $ cGAce
		aPPA[95,8] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7] - aOSTTP[nCntFor,33]
		aPPA[98,8] += aOSTTP[nCntFor,31]
	elseif SA1->A1_SATIV1 $ Alltrim(cCliGov)
		aPPA[59,8] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7] - aOSTTP[nCntFor,33]
		aPPA[67,8] += aOSTTP[nCntFor,31]
	elseif SA1->A1_SATIV1 $ Alltrim(cCliSegur)
		aPPA[61,8] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7] - aOSTTP[nCntFor,33]
		aPPA[69,8] += aOSTTP[nCntFor,31]
	elseif SA1->A1_SATIV1 $ Alltrim(cCliFrot)
		aPPA[60,8] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7] - aOSTTP[nCntFor,33]
		aPPA[68,8] += aOSTTP[nCntFor,31]
	else
		aPPA[62,8] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7] - aOSTTP[nCntFor,33]
		aPPA[70,8] += aOSTTP[nCntFor,31]
	endif
next
//
cAliasVO3 := GetNextAlias()
cAliasVO2 := GetNextAlias()
cAliasSB1 := GetNextAlias()
cAliasSB2 := GetNextAlias()
nIcm := 0
nCof := GetMV("MV_TXCOFIN")
nPis := GetMV("MV_TXPIS")
cIcm := AllTrim(GetMV("MV_ESTICM"))
aSM0 := FWArrFilAtu(cEmpAnt,cFilAnt) // Filial Origem (Filial logada)
cBkpFil := SM0->(Recno())
dbSelectArea("SM0")
dbSetOrder(1)
dbSeek(aSM0[1]+aSM0[2])
nI := AT( SM0->M0_ESTENT , cICM )
If nI <> 0 
	nI += 2
	While nI <= Len(cIcm)
		If IsAlpha(SubStr(cIcm,nI,1))
			Exit
		Else
			cImposto += SubStr(cIcm,nI,1)
		EndIf
		nI++
	End
	nIcm := Val(cImposto)
EndIf
SM0->(DbGoto(cBkpFil))
//
If Select(cAliasVO3) > 0
	( cAliasVO3 )->( DbCloseArea() )
EndIf
cQuery := "SELECT VO3.VO3_DATFEC, VO3.VO3_DATCAN, VO3.VO3_NOSNUM, VO3.VO3_GRUITE, VO3.VO3_CODITE, VO3.VO3_VALPEC, VO3.VO3_QTDREQ, VO3.VO3_FATPAR, VO3.VO3_LOJA, VO3.VO3_NUMNFI, VO3.VO3_SERNFI, VO3.VO3_VALLIQ "
cQuery += "FROM "+RetSqlName( "VO3" ) + " VO3 "
cQuery += "INNER JOIN "+RetSqlName( "VOI" ) + " VOI ON VO3.VO3_TIPTEM = VOI.VOI_TIPTEM AND VOI.D_E_L_E_T_=' ' "
cQuery += "WHERE "
cQuery += "VO3.VO3_FILIAL='"+ xFilial("VO3")+ "' AND "
cQuery += "VO3.VO3_DATFEC='        ' AND "
cQuery += "VO3.VO3_DATCAN='        ' AND "
cQuery += "VO3.D_E_L_E_T_=' ' AND VOI.VOI_SITTPO <> '3' "
cQuery += "ORDER BY VO3.VO3_DATFEC, VO3.VO3_TIPTEM "
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO3, .T., .T. )

While !(cAliasVO3)->(Eof())
	If Select(cAliasVO2) > 0
		( cAliasVO2 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VO2.VO2_DEVOLU, VO2.VO2_DATREQ "
	cQuery += "FROM "+RetSqlName( "VO2" ) + " VO2 "
	cQuery += "WHERE "
	cQuery += "VO2.VO2_FILIAL='"+ xFilial("VO2")+ "' AND "
	cQuery += "VO2.VO2_NOSNUM='"+(cAliasVO3)->VO3_NOSNUM+"' AND "
	cQuery += "VO2.D_E_L_E_T_=' ' ORDER BY VO2.VO2_NOSNUM"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO2, .T., .T. )

	If Select(cAliasSBM) > 0
		( cAliasSBM )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SBM.BM_CODMAR, SBM.BM_DESC, SBM.BM_PROORI, SBM.BM_GRUPO ,SBM.BM_TIPGRU "
	cQuery += "FROM "+RetSqlName( "SBM" ) + " SBM "
	cQuery += "WHERE "
	cQuery += "SBM.BM_FILIAL='"+ xFilial("SBM")+ "' AND "
	cQuery += "SBM.BM_GRUPO='"+(cAliasVO3)->VO3_GRUITE+"' AND "
	cQuery += "SBM.D_E_L_E_T_=' ' ORDER BY SBM.BM_GRUPO"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSBM, .T., .T. )

	if MV_PAR22 == 1
		if Alltrim((cAliasSBM)->BM_TIPGRU) == "3"
			DbSelectArea(cAliasVO3)
			Dbskip()
			loop
		Endif	
	Elseif MV_PAR22 == 2
		if Alltrim((cAliasSBM)->BM_TIPGRU) <> "3"
			DbSelectArea(cAliasVO3)
			Dbskip()
			loop
		Endif	
   Endif
	
	If (cAliasVO2)->VO2_DATREQ > DTOS(MV_PAR02)    // Despresa o registro se a data da requisicao for maior que a data final do parametro.
		DbSelectArea(cAliasVO3)
		Dbskip()
		loop
	EndIf
	
	SB1->(DbSetOrder(7))
	SB1->(DbSeek(xFilial("SB1")+(cAliasVO3)->VO3_GRUITE+(cAliasVO3)->VO3_CODITE))
	SB1->(DbSetOrder(1))
	
	If Select(cAliasSB2) > 0
		( cAliasSB2 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SB2.B2_COD, SB2.B2_CM1, SB2.B2_LOCAL "                 
	cQuery += "FROM "+RetSqlName( "SB2" ) + " SB2 "
	cQuery += "WHERE "
	cQuery += "SB2.B2_FILIAL='"+ xFilial("SB2")+ "' AND "
	cQuery += "SB2.B2_COD='"+SB1->B1_COD+"' AND SB2.B2_LOCAL='"+FM_PRODSBZ(SB1->B1_COD,"SB1->B1_LOCPAD")+"' AND "
	cQuery += "SB2.D_E_L_E_T_=' ' ORDER BY SB2.B2_COD, SB2.B2_LOCAL"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSB2, .T., .T. )
	
	nPvalvda := ((cAliasVO3)->VO3_VALLIQ - ((nPis + nCof + nIcm)/100) * (cAliasVO3)->VO3_VALLIQ)
	nPvalvda := ( nPvalvda * (cAliasVO3)->VO3_QTDREQ )
	nPvalcus := (cAliasSB2)->B2_CM1
	nPvalvda := If((cAliasVO2)->VO2_DEVOLU == "0",((-1)*(nPvalvda)),nPvalvda)
	if (cAliasVO2)->VO2_DEVOLU == "0"
		nPvalcus := ((-1)*(nPvalcus))
	Endif

	aPPA[65,8] += nPvalvda
	aPPA[73,8] += nPvalcus
	DbSelectArea(cAliasVO3)
	Dbskip()
EndDo
( cAliasVO3 )->( DbCloseArea() )
//
cQryAl002 := GetNextAlias()
cQuery := "SELECT VEC.VEC_VALBRU, VEC.VEC_TOTIMP, VEC.VEC_VALDES, VEC_ICMSRT, VEC_CUSTOT, SB1.B1_GRUPO,"
cQuery += " SD2.D2_CLIENTE, SD2.D2_LOJA, SD2.D2_DOC, SD2.D2_SERIE, SF4.F4_ESTOQUE, SF4.F4_OPEMOV "
cQuery += "FROM "+RetSqlName( "VEC" ) + " VEC INNER JOIN "+RetSqlName( "SB1" ) + " SB1 ON"
cQuery += "      ( SB1.B1_FILIAL='"+ xFilial("SB1")+ "' AND "
cQuery += "        SB1.B1_GRUPO = VEC.VEC_GRUITE AND "
cQuery += "        SB1.B1_CODITE = VEC.VEC_CODITE AND "
cQuery += "        SB1.D_E_L_E_T_=' ' )"
cQuery += "INNER JOIN "+RetSqlName( "SD2" ) + " SD2 ON"
cQuery += "      ( SD2.D2_FILIAL='"+ xFilial("SD2")+ "' AND "
cQuery += "        SD2.D2_DOC = VEC.VEC_NUMNFI AND "
cQuery += "        SD2.D2_SERIE = VEC.VEC_SERNFI AND "
cQuery += "        SD2.D2_COD = SB1.B1_COD AND "
cQuery += "        SD2.D2_ITEM = VEC.VEC_ITENFI AND "  
cQuery += "        SD2.D_E_L_E_T_=' ' )"
cQuery += "INNER JOIN "+RetSqlName( "SF4" ) + " SF4 ON"
cQuery += "      ( SF4.F4_FILIAL='"+ xFilial("SF4")+ "' AND "
cQuery += "        SF4.F4_CODIGO = SD2.D2_TES AND "
cQuery += "        (SF4.F4_OPEMOV = '05' OR SF4.F4_OPEMOV = '04')  AND "
cQuery += "        SF4.D_E_L_E_T_=' ' )"
cQuery += "WHERE "
cQuery += " VEC.VEC_FILIAL='" + xFilial("VEC") + "' AND "
cQuery += " VEC.VEC_DATVEN >= '" + Dtos(MV_PAR01) + "' AND "
cQuery += " VEC.VEC_DATVEN <= '" + Dtos(MV_PAR02) + "' AND "
cQuery += " VEC.VEC_BALOFI = 'B' AND VEC.D_E_L_E_T_=' '"

dbUseArea( .T., 'TOPCONN', TcGenQry(,,cQuery), cQryAl002, .T., .T. )

while !((cQryAl002)->(eof()))
	if !SA1->(DBSeek(xFilial('SA1')+(cQryAl002)->(D2_CLIENTE)+(cQryAl002)->(D2_LOJA)))
		MsgInfo(STR0021 + (cQryAl002)->(D2_CLIENTE) + '/' + (cQryAl002)->(D2_LOJA))
		loop
	endif
	if !SF2->(DBSeek(xFilial('SF2')+(cQryAl002)->(D2_DOC)+(cQryAl002)->(D2_SERIE)+(cQryAl002)->(D2_CLIENTE)+(cQryAl002)->(D2_LOJA)))
		loop
	endif

	If Select(cAliasSBM) > 0
		( cAliasSBM )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SBM.BM_CODMAR, SBM.BM_DESC, SBM.BM_PROORI, SBM.BM_GRUPO ,SBM.BM_TIPGRU "
	cQuery += "FROM "+RetSqlName( "SBM" ) + " SBM "
	cQuery += "WHERE "
	cQuery += "SBM.BM_FILIAL='"+ xFilial("SBM")+ "' AND "
	cQuery += "SBM.BM_GRUPO='"+(cQryAl002)->B1_GRUPO+"' AND "
	cQuery += "SBM.D_E_L_E_T_=' ' ORDER BY SBM.BM_GRUPO"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSBM, .T., .T. )

	if MV_PAR22 == 1
		if Alltrim((cAliasSBM)->BM_TIPGRU) == "3"
			DbSelectArea(cQryAl002)
			Dbskip()
			loop
		Endif	
	Elseif MV_PAR22 == 2
		if Alltrim((cAliasSBM)->BM_TIPGRU) <> "3"
			DbSelectArea(cQryAl002)
			Dbskip()
			loop
		Endif	
   Endif
	
	if (cQryAl002)->(F4_OPEMOV) = '04' .and. (cQryAl002)->(F4_ESTOQUE) == "S" .and. Alltrim(SF2->F2_PREFORI) != Alltrim(GetNewPar("MV_PREFOFI","OFI")) .and. Alltrim(SF2->F2_PREFORI) != Alltrim(GetNewPar("MV_PREFVEI","VEI"))
		aPPA[19,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[28,8] += (cQryAl002)->(VEC_CUSTOT)
	elseif (cQryAl002)->(B1_GRUPO) $ Alltrim(cGLubComb)
		aPPA[96,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[99,8] += (cQryAl002)->(VEC_CUSTOT)
	elseif (cQryAl002)->(B1_GRUPO) $ Alltrim(cGAce)
		aPPA[95,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[98,8] += (cQryAl002)->(VEC_CUSTOT)
	elseif SA1->A1_SATIV1 $ Alltrim(cCliGov)
		aPPA[13,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[22,8] += (cQryAl002)->(VEC_CUSTOT)
	elseif SA1->A1_SATIV1 $ Alltrim(cCliSegur)
		aPPA[14,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[23,8] += (cQryAl002)->(VEC_CUSTOT)
	elseif SA1->A1_SATIV1 $ Alltrim(cCliLoja)
		aPPA[15,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[24,8] += (cQryAl002)->(VEC_CUSTOT)
	elseif SA1->A1_SATIV1 $ Alltrim(cCliOfiInd)
		aPPA[16,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[25,8] += (cQryAl002)->(VEC_CUSTOT)
	elseif SA1->A1_SATIV1 $ Alltrim(cCliRede)
		aPPA[17,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[26,8] += (cQryAl002)->(VEC_CUSTOT)
	elseif SA1->A1_SATIV1 $ Alltrim(cCliFrot)
		aPPA[18,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[27,8] += (cQryAl002)->(VEC_CUSTOT)
	else
		aPPA[20,8] += (cQryAl002)->(VEC_VALBRU) - (cQryAl002)->(VEC_TOTIMP)  -  (cQryAl002)->(VEC_VALDES)  -  (cQryAl002)->(VEC_ICMSRT)
		aPPA[29,8] += (cQryAl002)->(VEC_CUSTOT)
	endif
	DbSelectArea(cQryAl002)
	(cQryAl002)->(dbSkip())
enddo
( cQryAl002 )->( DbCloseArea() )

if MsgYesNo(STR0065,STR0066)
	cQryAl003 := GetNextAlias()
	//
	cQuery := "SELECT SB2.B2_COD, SB2.B2_CM1, SB2.B2_LOCAL, SB1.B1_GRUPO, SB1.B1_GRUDES, "
	cQuery += " SB1.B1_CODITE, SB1.B1_ORIGEM, SBM.BM_CODMAR, "
	cQuery += " SBM.BM_DESC, SBM.BM_PROORI"
	cQuery += " FROM "+RetSqlName( "SB2" ) + " SB2 INNER JOIN " + RetSqlName( "SB1" ) + " SB1 ON"
	cQuery += "    ( SB1.B1_FILIAL = '"+ xFilial("SB1")+ "' AND "
	cQuery += "      SB1.B1_COD = SB2.B2_COD AND SB1.D_E_L_E_T_=' ' AND
	cQuery += "      SB1.B1_GRUPO <> '"+ cGruVei +"' AND SB1.B1_GRUPO <> '" + cGruSrv + "') "
	cQuery += " INNER JOIN "+RetSqlName( "SBM" ) + " SBM ON"
	cQuery += "    ( SBM.BM_FILIAL = '"+ xFilial("SBM")+ "' AND "
	if MV_PAR22 == 1
		cQuery += "   SBM.BM_TIPGRU <> '3' AND "
	Elseif MV_PAR22 == 2
		cQuery += "   SBM.BM_TIPGRU = '3' AND "
   Endif
	cQuery += "      SBM.BM_GRUPO = SB1.B1_GRUPO  AND SBM.D_E_L_E_T_=' ' )"
	cQuery += " WHERE "
	cQuery += " SB2.B2_FILIAL='"+ xFilial("SB2")+ "' AND "
	cQuery += " SB2.D_E_L_E_T_=' ' ORDER BY SB2.B2_COD, SB2.B2_LOCAL"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cQryAl003, .T., .T. )
	//
	While !(cQryAl003)->(Eof())
		If (cQryAl003)->B1_GRUPO $ cDescTip
			DbSelectArea(cQryAl003)
			Dbskip()
			loop
		EndIf
		//
		nValEst := CalcEst((cQryAl003)->B2_COD,(cQryAl003)->B2_LOCAL,MV_PAR02)[2]
		//
		If ExistBlock("ORVW02E1")
			ExecBlock("ORVW02E1",.f.,.f.)
		else
			//
			If (cQryAl003)->B1_GRUPO $ cGrupoOut
				aPPA[44,8] += nValEst
			elseIf (cQryAl003)->BM_CODMAR $  cMarcaVW .and. (cQryAl003)->BM_PROORI == '1'
				aPPA[41,8] += nValEst
			elseif(cQryAl003)->BM_CODMAR $  cMarcaMAN .and. (cQryAl003)->BM_PROORI == '1'
				aPPA[42,8] += nValEst
			else
				aPPA[43,8] += nValEst
			endif
			//
		endif
		DbSelectArea(cQryAl003)
		Dbskip()
	EndDo
	( cQryAl003 )->( DbCloseArea() )
endif

//
cAliasSD1 := GetNextAlias()
cAliasVE4 := GetNextAlias()
cAliasSB1 := GetNextAlias()
cAliasSBM := GetNextAlias()

cQuery := "SELECT SD1.D1_GRUPO, SD1.D1_COD, SD1.D1_CF, SD1.D1_TES, SD1.D1_CUSTO "
cQuery += "FROM "+RetSqlName( "SD1" ) + " SD1 "
cQuery += "WHERE "
cQuery += "SD1.D1_FILIAL='"+ xFilial("SD1")+ "' AND "
cQuery += "SD1.D1_DTDIGIT>='"+DTOS(MV_PAR01)+"' AND "
cQuery += "SD1.D1_DTDIGIT<='"+DTOS(MV_PAR02)+"' AND "
cQuery += "SD1.D_E_L_E_T_=' ' ORDER BY SD1.D1_DTDIGIT, SD1.D1_NUMSEQ"
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSD1, .T., .T. )

While !(cAliasSD1)->(Eof())


	If Select(cAliasSBM) > 0
		( cAliasSBM )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SBM.BM_CODMAR, SBM.BM_DESC, SBM.BM_PROORI, SBM.BM_GRUPO ,SBM.BM_TIPGRU "
	cQuery += "FROM "+RetSqlName( "SBM" ) + " SBM "
	cQuery += "WHERE "
	cQuery += "SBM.BM_FILIAL='"+ xFilial("SBM")+ "' AND "
	cQuery += "SBM.BM_GRUPO='"+(cAliasSD1)->D1_GRUPO+"' AND "
	cQuery += "SBM.D_E_L_E_T_=' ' ORDER BY SBM.BM_GRUPO"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSBM, .T., .T. )

	if MV_PAR22 == 1
		if Alltrim((cAliasSBM)->BM_TIPGRU) == "3"
			DbSelectArea(cAliasSD1)
			Dbskip()
			loop
		Endif	
	Elseif MV_PAR22 == 2
		if Alltrim((cAliasSBM)->BM_TIPGRU) <> "3"
			DbSelectArea(cAliasSD1)
			Dbskip()
			loop
		Endif	
   Endif
	if !Empty((cAliasSBM)->BM_TIPGRU) .and. (cAliasSBM)->BM_TIPGRU $ cDescTip
		DbSelectArea(cAliasSD1)
		Dbskip()
		loop
	endif

	If Select(cAliasVE4) > 0
		( cAliasVE4 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VE4.VE4_PREFAB, VE4.VE4_CDOPEN "
	cQuery += "FROM "+RetSqlName( "VE4" ) + " VE4 "
	cQuery += "WHERE "
	cQuery += "VE4.VE4_FILIAL='"+ xFilial("VE4")+ "' AND VE4.VE4_PREFAB='"+(cAliasSBM)->BM_CODMAR+"' AND "
	cQuery += "VE4.D_E_L_E_T_=' ' ORDER BY VE4.VE4_PREFAB"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVE4, .T., .T. )

	If Select(cAliasSB1) > 0
		( cAliasSB1 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SB1.B1_COD, SB1.B1_GRUPO, SB1.B1_CODITE, SB1.B1_ORIGEM "
	cQuery += "FROM "+RetSqlName( "SB1" ) + " SB1 "
	cQuery += "WHERE "
	cQuery += "SB1.B1_FILIAL='"+ xFilial("SB1")+ "' AND "
	cQuery += "SB1.B1_COD='"+(cAliasSD1)->D1_COD+"' AND "
	cQuery += "SB1.D_E_L_E_T_=' ' ORDER BY SB1.B1_COD"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSB1, .T., .T. )

	If ( !((cAliasSD1)->D1_CF $ cCFOTrans ) .Or. ( (cAliasVE4)->VE4_PREFAB == (cAliasSBM)->BM_CODMAR .And. (cAliasSD1)->D1_TES == FG_TABTRIB((cAliasVE4)->VE4_CDOPEN,(cAliasSB1)->B1_ORIGEM) ) )
		DbSelectArea(cAliasSD1)
		Dbskip()
		loop
	EndIf
	If ExistBlock("ORVW02E2")
		ExecBlock("ORVW02E2",.f.,.f.)
	else
		If (cAliasSBM)->BM_GRUPO $ cGAce .or. (cAliasSBM)->BM_CODMAR $  cMarcaVW .OR. (cAliasSBM)->BM_CODMAR $  cMarcaMAN
			aPPA[45,8] +=(cAliasSD1)->D1_CUSTO
		Else
			aPPA[46,8] +=(cAliasSD1)->D1_CUSTO
		EndIf
	endif
	DbSelectArea(cAliasSD1)
	Dbskip()
EndDo
If Select(cAliasSD1) > 0
	( cAliasSD1 )->( DbCloseArea() )
ENDIF	
If Select(cAliasVE4) > 0
	( cAliasVE4 )->( DbCloseArea() )
ENDIF
If Select(cAliasSB1) > 0	
	( cAliasSB1 )->( DbCloseArea() )
ENDIF
If Select(cAliasSBM) > 0	
( cAliasSBM )->( DbCloseArea() )
ENDIF

cAliasSD2 := GetNextAlias()
cAliasSF4 := GetNextAlias()
cAliasSA2 := GetNextAlias()
cAliasVE4 := GetNextAlias()

If Select(cAliasSD2) > 0
	( cAliasSD2 )->( DbCloseArea() )
EndIf
cQuery := "SELECT SD2.D2_NFORI, SD2.D2_SERIORI, SD2.D2_CLIENTE, SD2.D2_LOJA, SD2.D2_GRUPO, SD2.D2_COD, SD2.D2_CF, SD2.D2_TES,"
cQuery += " SD2.D2_TOTAL, SD2.D2_DESPESA, SD2.D2_VALFRE, SD2.D2_SEGURO, SD2.D2_VALIPI, SD2.D2_ICMSRET, SD2.D2_TIPO, SD2.D2_CUSTO1, SD2.D2_ITEMORI "
cQuery += "FROM "+RetSqlName( "SD2" ) + " SD2 WHERE "
cQuery += "SD2.D2_FILIAL='"+ xFilial("SD2")+ "' AND "
If !Empty(MV_PAR01)
	cQuery += "SD2.D2_EMISSAO >= '"+DTOS(MV_PAR01)+"' AND "
EndIf
If !Empty(MV_PAR02)
	cQuery += "SD2.D2_EMISSAO <= '"+DTOS(MV_PAR02)+"' AND "
EndIf
cQuery += "SD2.D_E_L_E_T_=' ' ORDER BY SD2.D2_EMISSAO, SD2.D2_NUMSEQ"
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSD2, .T., .T. )

While !(cAliasSD2)->(Eof())

	If Select(cAliasSBM) > 0
		( cAliasSBM )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SBM.BM_CODMAR, SBM.BM_DESC, SBM.BM_PROORI, SBM.BM_GRUPO, SBM.BM_TIPGRU "
	cQuery += "FROM "+RetSqlName( "SBM" ) + " SBM "
	cQuery += "WHERE "
	cQuery += "SBM.BM_FILIAL = '"+ xFilial("SBM")+ "' AND "
	cQuery += "SBM.BM_GRUPO = '"+(cAliasSD2)->D2_GRUPO+"' AND " 
	cQuery += "SBM.D_E_L_E_T_=' ' ORDER BY SBM.BM_GRUPO"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSBM, .T., .T. )

	if MV_PAR22 == 1
		if Alltrim((cAliasSBM)->BM_TIPGRU) == "3"
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
	Elseif MV_PAR22 == 2
		if Alltrim((cAliasSBM)->BM_TIPGRU) <> "3"
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
   Endif

	if Alltrim((cAliasSBM)->BM_TIPGRU) $ cDescTip
		DbSelectArea(cAliasSD2)
		DbSkip()
		loop
	endif

	If Select(cAliasVE4) > 0
		( cAliasVE4 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VE4.VE4_CDOPSA, VE4.VE4_CODFOR, VE4.VE4_LOJFOR, VE4.VE4_CDOPEN, VE4.VE4_PREFAB "
	cQuery += "FROM "+RetSqlName( "VE4" ) + " VE4 "
	cQuery += "WHERE "
	cQuery += "VE4.VE4_FILIAL='"+ xFilial("VE4")+ "' AND VE4.VE4_PREFAB='"+(cAliasSBM)->BM_CODMAR+"' AND "
	cQuery += "VE4.D_E_L_E_T_=' ' ORDER BY VE4.VE4_PREFAB"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVE4, .T., .T. )

	If Select(cAliasSB1) > 0
		( cAliasSB1 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SB1.B1_COD, SB1.B1_GRUPO, SB1.B1_CODITE, SB1.B1_ORIGEM "
	cQuery += "FROM "+RetSqlName( "SB1" ) + " SB1 "
	cQuery += "WHERE "
	cQuery += "SB1.B1_FILIAL='"+ xFilial("SB1")+ "' AND "
	cQuery += "SB1.B1_COD='"+(cAliasSD2)->D2_COD+"' AND "
	cQuery += "SB1.D_E_L_E_T_=' ' ORDER BY SB1.B1_COD"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSB1, .T., .T. ) 
	
	If Select(cAliasSF4) > 0
		( cAliasSF4 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SF4.F4_DUPLIC, SF4.F4_ESTOQUE, SF4.F4_OPEMOV "
	cQuery += "FROM "+RetSqlName( "SF4" ) + " SF4 "
	cQuery += "WHERE "
	cQuery += "SF4.F4_FILIAL='"+ xFilial('SF4')+ "' AND "
	cQuery += "SF4.F4_CODIGO='"+(cAliasSD2)->D2_TES+"' AND "
	cQuery += "SF4.D_E_L_E_T_=' ' ORDER BY SF4.F4_CODIGO"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSF4, .T., .T. )
	//      
	if !Empty((cAliasSD2)->D2_NFORI) .and. Alltrim((cAliasSF4)->F4_OPEMOV) == "09" .and. Alltrim((cAliasSD2)->D2_TIPO) == "D"
		DBSelectArea("SF1")
		DBSetOrder(1)
		if !DBSeek(xFilial("SF1") + (cAliasSD2)->D2_NFORI + (cAliasSD2)->D2_SERIORI + (cAliasSD2)->D2_CLIENTE + (cAliasSD2)->D2_LOJA)
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
		//
		DBSelectArea("SD1")
		DBSetOrder(1)
		if !DBSeek(xFilial("SD1") + (cAliasSD2)->D2_NFORI + (cAliasSD2)->D2_SERIORI + (cAliasSD2)->D2_CLIENTE + (cAliasSD2)->D2_LOJA + (cAliasSD2)->D2_COD + (cAliasSD2)->D2_ITEMORI )
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
		//
		DBSelectArea("SA2")
		DBSetOrder(1)
		if !DBSeek(xFilial("SA2") +  (cAliasSD2)->D2_CLIENTE + (cAliasSD2)->D2_LOJA)
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
		//
		DBSelectArea("SF4")
		DBSetOrder(1)
		if !DBSeek( xFilial("SF4") + SD1->D1_TES)  
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
		//
		DBSelectArea("SB1")
		DBSetOrder(1)
		if !DBSeek( xFilial("SB1") + (cAliasSD2)->D2_COD)  
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
		//
		DBSelectArea("SBM")
		DBSetOrder(1)
		if !DBSeek( xFilial("SBM") + SB1->B1_GRUPO)  
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
		
		if !Empty(SBM->BM_TIPGRU) .and. SBM->BM_TIPGRU $ cDescTip
			DbSelectArea(cAliasSD2)
			DbSkip()
			loop
		endif
		
		if Alltrim(SF4->F4_OPEMOV) == "01"
			if Left(SA2->A2_CGC,8) $ cFornVW
				aPPA[83,8] -= (cAliasSD2)->D2_CUSTO1
			elseif (SA2->A2_SATIV1) $ Alltrim(cForDSH) .or. Left((SA2->A2_CGC),8) $ cFornMAN
				aPPA[84,8] -= (cAliasSD2)->D2_CUSTO1
			elseif (SA2->A2_SATIV1) $ Alltrim(cCliRede)
				aPPA[85,8] -= (cAliasSD2)->D2_CUSTO1
			elseif (SA2->A2_SATIV1) $ Alltrim(cCliLoja)
				aPPA[86,8] -= (cAliasSD2)->D2_CUSTO1
			elseif (SA2->A2_SATIV1) $ Alltrim(cForFabr)
				aPPA[87,8] -= (cAliasSD2)->D2_CUSTO1
			Else
				aPPA[88,8] -= (cAliasSD2)->D2_CUSTO1
			endif
		endif
	else
		If ( !((cAliasSD2)->D2_CF $ cCFOTraSai) .Or. ( (cAliasVE4)->VE4_PREFAB == (cAliasSBM)->BM_CODMAR .And. (cAliasSD2)->D2_TES == FG_TABTRIB((cAliasVE4)->VE4_CDOPSA,(cAliasSB1)->B1_ORIGEM) ) )
			DbSelectArea(cAliasSD2)
			Dbskip()
			loop
		EndIf
		If ExistBlock("ORVW02E3")
			ExecBlock("ORVW02E3",.f.,.f.)
		else
			If (cAliasSBM)->BM_GRUPO $ cGAce  .or. (cAliasSBM)->BM_CODMAR $  cMarcaVW .OR. (cAliasSBM)->BM_CODMAR $  cMarcaMAN
				aPPA[47,8] +=(cAliasSD2)->D2_TOTAL + (cAliasSD2)->D2_DESPESA + (cAliasSD2)->D2_VALFRE + (cAliasSD2)->D2_SEGURO + (cAliasSD2)->D2_VALIPI + IIF((cAliasSD2)->D2_ICMSRET > 0,(cAliasSD2)->D2_ICMSRET,0)
			Else
				aPPA[48,8] +=(cAliasSD2)->D2_TOTAL + (cAliasSD2)->D2_DESPESA + (cAliasSD2)->D2_VALFRE + (cAliasSD2)->D2_SEGURO + (cAliasSD2)->D2_VALIPI + IIF((cAliasSD2)->D2_ICMSRET > 0,(cAliasSD2)->D2_ICMSRET,0)
			EndIf
		endif	
	endif
	DbSelectArea(cAliasSD2)
	DbSkip()
EndDo
//
cAliasSD2 := GetNextAlias()
cAliasSF4 := GetNextAlias()
cAliasSA2 := GetNextAlias()
cAliasVE4 := GetNextAlias()
//
If Select(cAliasSD1) > 0
	( cAliasSD1 )->( DbCloseArea() )
EndIf
//
cQuery := "SELECT D1_TIPO, D1_LOCAL, D1_TES, D1_GRUPO, D1_COD, D1_FORNECE, D1_LOJA, D1_TOTAL, D1_CUSTO, D1_NFORI, D1_SERIORI, D1_ITEMORI, R_E_C_N_O_ RECSD1 "
cQuery += " FROM "+RetSqlName( "SD1" ) + " SD1 "
cQuery += " WHERE "
cQuery += " SD1.D1_FILIAL='"+ xFilial("SD1")+ "' AND "
cQuery += " SD1.D1_DTDIGIT >= '"+DTOS(MV_PAR01)+"' AND SD1.D1_DTDIGIT <= '"+DTOS(MV_PAR02)+"' AND "
cQuery += " SD1.D_E_L_E_T_=' ' ORDER BY SD1.D1_DTDIGIT, SD1.D1_NUMSEQ"
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSD1, .T., .T. )
//
While !( cAliasSD1 )->(Eof())
	If !((cAliasSD1)->D1_TIPO == 'D')
		If !((cAliasSD1)->D1_TIPO $ 'N/C')
			DbSelectArea(cAliasSD1)
			DbSkip()
			Loop
		EndIf
	endif
	If Select(cAliasSF4) > 0
		( cAliasSF4 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SF4.F4_DUPLIC, SF4.F4_ESTOQUE, SF4.F4_OPEMOV "
	cQuery += "FROM "+RetSqlName( "SF4" ) + " SF4 "
	cQuery += "WHERE "
	cQuery += "SF4.F4_FILIAL='" + xFilial('SF4') + "' AND "
	cQuery += "SF4.F4_CODIGO='" + (cAliasSD1)->D1_TES + "' AND "
	cQuery += "SF4.D_E_L_E_T_=' ' ORDER BY SF4.F4_CODIGO"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSF4, .T., .T. )
	If (cAliasSF4)->F4_ESTOQUE # 'S' .or.  ( (cAliasSF4)->F4_OPEMOV != '01' .and. (cAliasSF4)->F4_OPEMOV != '09' )
		DbSelectArea(cAliasSD1)
		DbSkip()
		Loop
	EndIf

	If Select(cAliasSBM) > 0
		( cAliasSBM )->( DbCloseArea() )
	EndIf

	cQuery := 'SELECT SBM.BM_CODMAR, SBM.BM_DESC, SBM.BM_PROORI, SBM.BM_GRUPO, SBM.BM_TIPGRU '
	cQuery += "FROM "+RetSqlName( "SBM" ) + " SBM "
	cQuery += "WHERE "
	cQuery += "SBM.BM_FILIAL='"+ xFilial("SBM")+ "' AND SBM.BM_GRUPO='"+(cAliasSD1)->D1_GRUPO+"' AND "
	cQuery += "SBM.D_E_L_E_T_=' ' ORDER BY SBM.BM_GRUPO"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSBM, .T., .T. )   

	if MV_PAR22 == 1
		if Alltrim((cAliasSBM)->BM_TIPGRU) == "3"
			DbSelectArea(cAliasSD1)
			DbSkip()
			loop
		endif
	Elseif MV_PAR22 == 2
		if Alltrim((cAliasSBM)->BM_TIPGRU) <> "3"
			DbSelectArea(cAliasSD1)
			DbSkip()                                    
			loop
		endif
   Endif

	if !Empty((cAliasSBM)->BM_TIPGRU) .and. (cAliasSBM)->BM_TIPGRU $ cDescTip
		DbSelectArea(cAliasSD1)
		DbSkip()
		loop
	endif

	If Select(cAliasSB1) > 0
		( cAliasSB1 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SB1.B1_GRUPO, SB1.B1_COD, SB1.B1_ORIGEM, SB1.B1_CODITE, SB1.B1_GRUPO "
	cQuery += "FROM "+RetSqlName( "SB1" ) + " SB1 "
	cQuery += "WHERE "
	cQuery += "SB1.B1_FILIAL='"+ xFilial("SB1")+ "' AND SB1.B1_COD='"+(cAliasSD1)->D1_COD+"' AND "
	cQuery += "SB1.D_E_L_E_T_=' ' ORDER BY SB1.B1_COD"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSB1, .T., .T. )
	//
	If Select(cAliasSA2) > 0
		( cAliasSA2 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT SA2.A2_NOME, SA2.A2_SATIV1, SA2.A2_CGC "
	cQuery += "FROM "+RetSqlName( "SA2" ) + " SA2 "
	cQuery += "WHERE "
	cQuery += "SA2.A2_FILIAL='"+ xFilial("SA2")+ "' AND SA2.A2_COD='"+(cAliasSD1)->D1_FORNECE+"' AND SA2.A2_LOJA='"+(cAliasSD1)->D1_LOJA+"' AND "
	cQuery += "SA2.D_E_L_E_T_=' ' ORDER BY SA2.A2_COD, SA2.A2_LOJA"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSA2, .T., .T. )
	//
	DBSelectArea("VE4")
	//
	If  (cAliasSF4)->F4_OPEMOV == '01' .and.  Alltrim((cAliasSD1)->D1_TIPO) $ 'NC' // !((cAliasSD1)->D1_TIPO == 'D')
		if Left((cAliasSA2)->(A2_CGC),8) $ cFornVW
			aPPA[83,8] += (cAliasSD1)->D1_CUSTO
		elseif (cAliasSA2)->(A2_SATIV1) $ Alltrim(cForDSH) .or. Left((cAliasSA2)->(A2_CGC),8) $ cFornMAN
			aPPA[84,8] += (cAliasSD1)->D1_CUSTO
		elseif (cAliasSA2)->(A2_SATIV1) $ Alltrim(cCliRede)
			aPPA[85,8] += (cAliasSD1)->D1_CUSTO
		elseif (cAliasSA2)->(A2_SATIV1) $ Alltrim(cCliLoja)
			aPPA[86,8] += (cAliasSD1)->D1_CUSTO
		elseif (cAliasSA2)->(A2_SATIV1) $ Alltrim(cForFabr)
			aPPA[87,8] += (cAliasSD1)->D1_CUSTO
		Else
			aPPA[88,8] += (cAliasSD1)->D1_CUSTO
		endif
	elseif (cAliasSD1)->D1_TIPO == 'D'
		//
		if !Empty((cAliasSD1)->D1_NFORI)
			DBSelectArea("SF2")
			DbSetOrder(1)
			if !DbSeek( xFilial("SF2") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI , .f. )
				DbSelectArea(cAliasSD1)
				Dbskip()
				loop
			endif
			//
			DBSelectArea("SD2")
			DBSetOrder(3)
			if !DBSeek( xFilial("SD2") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI + SF2->F2_CLIENTE + SF2->F2_LOJA + (cAliasSD1)->D1_COD + (cAliasSD1)->D1_ITEMORI )
				DbSelectArea(cAliasSD1)
				Dbskip()
				loop
			endif
			//
			DBSelectArea("SF4")
			DBSetOrder(1)
			if !DBSeek( xFilial("SF4") + SD2->D2_TES)
				DbSelectArea(cAliasSD1)
				Dbskip()
				loop
			endif
			//
			DBSelectArea("VEC")
			DBSetOrder(4)
			if !DBSeek( xFilial("VEC") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI + (cAliasSB1)->B1_GRUPO + (cAliasSB1)->B1_CODITE )
				DbSelectArea(cAliasSD1)
				Dbskip()
				loop
			endif
			//
			DBSelectArea("SA1")
			DBSetOrder(1)
			if !DBSeek(xFilial('SA1')+SD2->D2_CLIENTE+SD2->D2_LOJA)			
				DbSelectArea(cAliasSD1)
				Dbskip()
				loop
			endif
			//
			SD1->(DBGoTo((cAliasSD1)->RECSD1))
			//
			nValLiqD := SD1->D1_TOTAL + SD1->D1_VALIPI + SD1->D1_ICMSRET + SD1->D1_DESPESA + SD1->D1_SEGURO + SD1->D1_VALFRE - SD1->D1_VALDESC - SD1->D1_VALIMP6 - SD1->D1_VALIMP5 - SD1->D1_VALICM
			nCustoD := SD1->D1_CUSTO
			//
			If ExistBlock("ORVW02E4")
				ExecBlock("ORVW02E4",.f.,.f.)
			endif
			//
			if Alltrim(SF2->F2_PREFORI) == Alltrim(GetNewPar("MV_PREFOFI","OFI"))
			    DBSelectArea("VOI")
			    DBSetOrder(1)
				if Empty(VEC->VEC_TIPTEM) .or. !DBSeek(xFilial('VOI')+VEC->VEC_TIPTEM) 
			   		DbSelectArea(cAliasSD1)
			   		Dbskip()
			   		loop
				endif
				if VOI->VOI_SITTPO == '3'
					aPPA[64,8] -= nValLiqD
					aPPA[72,8] -= nCustoD
				elseif VOI->VOI_SITTPO == '2'
					aPPA[63,8] -= nValLiqD
					aPPA[71,8] -= nCustoD
				elseif (cAliasSB1)->B1_GRUPO $ cGLubComb
					aPPA[96,8] -= nValLiqD
					aPPA[99,8] -= nCustoD
				elseif (cAliasSB1)->B1_GRUPO $ cGAce
					aPPA[95,8] -= nValLiqD
					aPPA[98,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliGov)
					aPPA[59,8] -= nValLiqD
					aPPA[67,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliSegur)
					aPPA[61,8] -= nValLiqD
					aPPA[69,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliFrot)
					aPPA[60,8] -= nValLiqD
					aPPA[68,8] -= nCustoD
				else
					aPPA[62,8] -= nValLiqD
					aPPA[70,8] -= nCustoD
				endif
			elseif Alltrim(SF2->F2_PREFORI) != Alltrim(GetNewPar("MV_PREFVEI","VEI"))
				if SF4->F4_OPEMOV = '04' .and. SF4->F4_ESTOQUE == "S" .and. Alltrim(SF2->F2_PREFORI) != Alltrim(GetNewPar("MV_PREFOFI","OFI")) .and. Alltrim(SF2->F2_PREFORI) != Alltrim(GetNewPar("MV_PREFVEI","VEI"))
					aPPA[19,8] -= nValLiqD
					aPPA[28,8] -= nCustoD
				elseif (cAliasSB1)->(B1_GRUPO) $ Alltrim(cGLubComb)
					aPPA[96,8] -= nValLiqD
					aPPA[99,8] -= nCustoD
				elseif (cAliasSB1)->(B1_GRUPO) $ Alltrim(cGAce)
					aPPA[95,8] -= nValLiqD
					aPPA[98,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliGov)
					aPPA[13,8] -= nValLiqD
					aPPA[22,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliSegur)
					aPPA[14,8] -= nValLiqD
					aPPA[23,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliLoja)
					aPPA[15,8] -= nValLiqD
					aPPA[24,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliOfiInd)
					aPPA[16,8] -= nValLiqD
					aPPA[25,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliRede)
					aPPA[17,8] -= nValLiqD
					aPPA[26,8] -= nCustoD
				elseif SA1->A1_SATIV1 $ Alltrim(cCliFrot)
					aPPA[18,8] -= nValLiqD
					aPPA[27,8] -= nCustoD
				else
					aPPA[20,8] -= nValLiqD
					aPPA[29,8] -= nCustoD
				endif
			endif
		endif			
	endif
	//
	DbSelectArea(cAliasSD1)
	Dbskip()
EndDo
If Select(cAliasSD1) > 0
	( cAliasSD1 )->( DbCloseArea() )
endif	
If Select(cAliasSF4) > 0
	( cAliasSF4 )->( DbCloseArea() )
endif
If Select(cAliasSBM) > 0	
	( cAliasSBM )->( DbCloseArea() )
endif	
If Select(cAliasSB1) > 0
	( cAliasSB1 )->( DbCloseArea() )
endif
If Select(cAliasSA2) > 0	
	( cAliasSA2 )->( DbCloseArea() )
endif	

aPPA[104,8] = MV_PAR19
aPPA[105,8] = MV_PAR20
aPPA[106,8] = MV_PAR21
//
oPrinter:StartPage()
//
nMax := FGX_MntTab(oPrinter, aPPA, 20, 40,,110,18 )
//
oPrinter:EndPage()
oPrinter:Setup()
if oPrinter:nModalResult == PD_OK
	oPrinter:Preview()
EndIf
Return
/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|Função    | CriaSX1    | Autor | André Delorme         | Data | 17/04/13 |##
##+----------+------------+-------+-----------------------+------+----------+##
###############################################################################
===============================================================================
*/
Static Function CriaSX1()
Local aSX1    := {}
Local aEstrut := {}
Local i       := 0
Local j       := 0
Local lSX1	  := .F.
//
if cPerg == ''
	return
endif
//
aEstrut:= { 'X1_GRUPO'  ,'X1_ORDEM','X1_PERGUNT','X1_PERSPA','X1_PERENG' ,'X1_VARIAVL','X1_TIPO' ,'X1_TAMANHO','X1_DECIMAL','X1_PRESEL'	,;
'X1_GSC'    ,'X1_VALID','X1_VAR01'  ,'X1_DEF01' ,'X1_DEFSPA1','X1_DEFENG1','X1_CNT01','X1_VAR02'  ,'X1_DEF02'  ,'X1_DEFSPA2'	,;
'X1_DEFENG2','X1_CNT02','X1_VAR03'  ,'X1_DEF03' ,'X1_DEFSPA3','X1_DEFENG3','X1_CNT03','X1_VAR04'  ,'X1_DEF04'  ,'X1_DEFSPA4'	,;
'X1_DEFENG4','X1_CNT04','X1_VAR05'  ,'X1_DEF05' ,'X1_DEFSPA5','X1_DEFENG5','X1_CNT05','X1_F3'     ,'X1_GRPSXG' ,'X1_PYME'}
//################################################################
//# aAdd a Pergunta                                              #
//################################################################
aAdd(aSX1,{cPerg,'01',STR0005,STR0005,STR0005,'MV_CH1','D',8 ,0,0,'G','','mv_par01','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'02',STR0006,STR0006,STR0006,'MV_CH2','D',8 ,0,0,'G','','mv_par02','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'03',STR0007,STR0007,STR0007,'MV_CH3','C',60,0,0,'G','','mv_par03','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'04',STR0008,STR0008,STR0008,'MV_CH4','C',60,0,0,'G','','mv_par04','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'05',STR0009,STR0009,STR0009,'MV_CH5','C',60,0,0,'G','','mv_par05','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'06',STR0010,STR0010,STR0010,'MV_CH6','C',60,0,0,'G','','mv_par06','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'07',STR0011,STR0011,STR0011,'MV_CH7','C',60,0,0,'G','','mv_par07','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'08',STR0012,STR0012,STR0012,'MV_CH8','C',60,0,0,'G','','mv_par08','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'09',STR0034,STR0034,STR0034,'MV_CH9','C',40,0,0,'G','','mv_par09','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'10',STR0029,STR0029,STR0029,'MV_CHA','C',40,0,0,'G','','mv_par10','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'11',STR0040,STR0040,STR0040,'MV_CHB','C',40,0,0,'G','','mv_par11','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'12',STR0063,STR0063,STR0063,'MV_CHC','C',40,0,0,'G','','mv_par12','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'13',STR0041,STR0041,STR0041,'MV_CHD','C',40,0,0,'G','','mv_par13','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'14',STR0028,STR0028,STR0028,'MV_CHE','C',40,0,0,'G','','mv_par14','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'15',STR0045,STR0045,STR0045,'MV_CHF','C',40,0,0,'G','','mv_par15','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'16',STR0044,STR0044,STR0044,'MV_CHG','C',40,0,0,'G','','mv_par16','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'17',STR0019,STR0019,STR0019,'MV_CHH','C',60,0,0,'G','','mv_par17','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'18',STR0020,STR0020,STR0020,'MV_CHI','C',60,0,0,'G','','mv_par18','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'19',STR0017,STR0017,STR0017,'MV_CHJ','N',05,2,0,'G','','mv_par19','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'20',STR0055,STR0055,STR0055,'MV_CHK','N',08,2,0,'G','','mv_par20','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'21',STR0014,STR0014,STR0014,'MV_CHL','N',08,2,0,'G','','mv_par21','','','','','','','','','','','','','','','','','','','','','','','','','',''	,'S'})
aAdd(aSX1,{cPerg,'22',STR0067,STR0067,STR0067,'MV_CHM','C',01,0,0,'C','','mv_par22',STR0068,'','','','',STR0069,'','','','',STR0070,'','','','','','','','','','','','','','',''	,'S'})
//
ProcRegua(Len(aSX1))
//
dbSelectArea('SX1')
dbSetOrder(1)
For i:= 1 To Len(aSX1)
	If !Empty(aSX1[i][1])
		lAchou := dbSeek(Left(Alltrim(aSX1[i,1])+SPACE(100),Len(SX1->X1_GRUPO))+aSX1[i,2])
		lSX1 := .T.
		RecLock('SX1',!lAchou)
		For j:=1 To Len(aSX1[i])
			If !Empty(FieldName(FieldPos(aEstrut[j])))
				if !lAchou .or. Left(aEstrut[j],6) != 'X1_CNT'
					FieldPut(FieldPos(aEstrut[j]),aSX1[i,j])
				endif
			EndIf
		Next j
		dbCommit()
		MsUnLock()
	EndIf
Next i
//
return
