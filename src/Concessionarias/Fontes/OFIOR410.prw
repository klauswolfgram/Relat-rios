/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 14     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#INCLUDE "ofior410.ch"
#include "protheus.ch"
#include "TOPCONN.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIOR410 ³ Autor ³ Thiago                ³ Data ³ 22/02/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Demonstrativo de Venda Perdidas                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR410

Local cAlias :="VE6"
Local cDesc3 := ""
Private nLin := 1
Private aPag := 1
Private cDesc1     := STR0001  //"Demonstrativo de Vendas Perdidas"
//////////////////////////////////////////////////////
// ANTONIO - FNC 27317 - NAO TINHA CABECALHO
//                               1         2         3         4         5         6         7         8         9         10        11        12        13        14
//                     012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////
Private cCabec1    := STR0012
Private cDesc2     := ""
Private cCabec2    := ""
Private aReturn    := { STR0002, 1,STR0003, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"{"Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
Private cTamanho   := "G"           // P/M/G
Private Limite     := 132          // 80/132/220
Private cTitulo    := STR0001
Private cNomProg   := "OFIOR410"
Private cNomeRel   := "OFIOR410"
Private nLastKey   := 0
Private nCaracter  := 15
Private cPerg      := "OFI410"
Private aVetCampos := {}
Private nTotValF   := 0
Private nTotGValF  := 0
//Private cArqTra
Private cArqTra,cArqInd1
Private cArqTra1,cArqInd2

Private cGruite
Private cCodUsu
Private cCenCus
Private cMotivo
Private dData
Private cCampo
Private cKeyAce
Private cGruFor := "04"

Private o1TempTable, o2TempTable
/*                       -
Parametros:

mv_par01 = Data Inicial
mv_par02 = Datas Final
mv_par03 = Formula p/ preco pecas
mv_par04 = Agrupar por:    1- Grupo da Peca   2- Usuario    3- Centro de Custo   4- Motivo   5- Data
mv_par05 = bloqueado:      1- Sim             2- Nao
*/

ValidPerg(cPerg)
Pergunte(cPerg, .F.)

cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,.t.,cTamanho)

if nlastkey == 27
	return
Endif

if mv_par05 == 1
	cTitulo    := STR0011 + " ( " + dtoc(MV_PAR01) + " a " + dtoc(MV_PAR02) + " )"  //Relacao de Requisicao de Compras
Else
	cTitulo    := STR0001 + " ( " + dtoc(MV_PAR01) + " a " + dtoc(MV_PAR02) + " )"  //Relacao de Vendas Perdidas
Endif


set printer to &cNomeRel
set printer on
set device to printer

SetDefault(aReturn,cAlias)

RptStatus({|lEnd| ImpOSInt(@lEnd,cNomeRel,cAlias)},cTitulo)
Return


///////////////////////////////////////////
Static Function ImpOSInt(lEnd,wNRel,cAlias)
Local cSQLVdaPer := "SQLVS3"
Local i          := 0
Local cMotivos   := ""
Local cMotNCons  := ""
Local cMot       := ""

&& Cria Arquivo de Trabalho
aadd(aVetCampos,{ "TRB_GRUPO"  , "C" , 4 , 0 })  && Grupo
aadd(aVetCampos,{ "TRB_CODITE" , "C" ,27 , 0 })  && Codigo da Peca
aadd(aVetCampos,{ "TRB_DESCRI" , "C" ,30 , 0 })  && Descricao
aadd(aVetCampos,{ "TRB_CODUSU" , "C" , 6 , 0 })  && Codigo do Usuario
aadd(aVetCampos,{ "TRB_NOMUSU" , "C" ,15 , 0 })  && Nome do Usuario
aadd(aVetCampos,{ "TRB_CENCUS" , "C" , 9 , 0 })  && Centro de Custo
aadd(aVetCampos,{ "TRB_DESCUS" , "C" ,25 , 0 })  && Descricao do Centro de Custo
aadd(aVetCampos,{ "TRB_CODMOT" , "C" , 6 , 0 })  && Motivo
aadd(aVetCampos,{ "TRB_DESMOT" , "C" ,30 , 0 })  && Descricao do Motivo
aadd(aVetCampos,{ "TRB_DATA"   , "D" , 8 , 0 })  && Data
aadd(aVetCampos,{ "TRB_VALFOR" , "N" ,14 , 2 })  && Valor da Formula
aadd(aVetCampos,{ "TRB_DESGRU" , "C" ,35 , 0 })  && Descricao do Grupo
aadd(aVetCampos,{ "TRB_OBSMEM" , "C" ,80, 0 })  && Observacao do Memo
aadd(aVetCampos,{ "TRB_NOMCLI" , "C" ,30 , 0 })  && Nome do Cliente
aadd(aVetCampos,{ "TRB_FONCLI" , "C" ,15, 0 })  && Telefone do CLiente
aadd(aVetCampos,{ "TRB_QTDITE" , "N" , 6, 0 })  && Quantidade do Item
aadd(aVetCampos,{ "TRB_LOCAL"  , "C" , 2, 0 })  && Almoxarifado
aadd(aVetCampos,{ "TRB_QATU"   , "N" , 6, 0 })  && Quantidade Atual no Estoque
aadd(aVetCampos,{ "TRB_QPED"   , "N" , 6, 0 })  && Quantidade de Pedidos
cArqInd1 := CriaTrab(NIL, .F.)
oObjTempTable := OFDMSTempTable():New()
oObjTempTable:cAlias := "TRB"
oObjTempTable:aVetCampos := aVetCampos
If mv_par04 == 1 //Grupo da Peca
	oObjTempTable:AddIndex(cArqInd1, {"TRB_GRUPO","TRB_CODITE"} )
ElseIf mv_par04 == 2
	oObjTempTable:AddIndex(cArqInd1, {"TRB_CODUSU","TRB_GRUPO","TRB_CODITE"} )
ElseIf mv_par04 == 3 //Centro de Custo
	oObjTempTable:AddIndex(cArqInd1, {"TRB_CENCUS","TRB_GRUPO","TRB_CODITE"} )
ElseIf mv_par04 == 4 //Motivo
	oObjTempTable:AddIndex(cArqInd1, {"TRB_CODMOT","TRB_GRUPO","TRB_CODITE"} )
Else //Data
	oObjTempTable:AddIndex(cArqInd1, {"TRB_DATA","TRB_GRUPO","TRB_CODITE"} )
EndIf
oObjTempTable:CreateTable()

aVetCampos := {}
aadd(aVetCampos,{ "TR1_CHAVE" , "C" ,10 , 0 })  && Chave
aadd(aVetCampos,{ "TR1_TOTAL" , "N" ,12 , 2 })  && Total
cArqInd2 := CriaTrab(NIL, .F.)
o2ObjTempTable := OFDMSTempTable():New()
o2ObjTempTable:cAlias := "TR1"
o2ObjTempTable:aVetCampos := aVetCampos
o2ObjTempTable:AddIndex(cArqInd2, {"TR1_CHAVE"} )
o2ObjTempTable:CreateTable()

M_PAG    := 1
nLin     := 80
aPag     := 1
clin     := 1

nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg,cTamanho,nCaracter)+1

if MV_PAR08 == 1 .or. MV_PAR08 == 3
	DbSelectArea("VE6")
	DbSetOrder(1)
	DbSeek(xFilial("VE6"))
	
	SetRegua(RecCount())
	
	nTotGValF := 0

	do While !Eof() .and. VE6->VE6_FILIAL == xFilial("VE6")
		IncRegua()
		if !Empty(mv_par01) .and. !Empty(mv_par02)
			if VE6->VE6_DATREG < mv_par01 .or. VE6->VE6_DATREG > mv_par02
				DbSelectArea("VE6")
				DbSkip()
				Loop
			Endif
		Endif
		
		if Alltrim(VE6->VE6_CODMOT) $ MV_PAR07
			DbSelectArea("VE6")
			DbSkip()
			Loop
		Endif
		
		if mv_par05 == 1
			cInd := "0"
		Else
			cInd := "1"
		Endif
		
		if !VE6->VE6_INDREG == cInd
			DbSelectArea("VE6")
			DbSkip()
			Loop
		Endif
		
		DbSelectArea("SB1")
		DbSetOrder(7)
		DbSeek(xFilial("SB1")+VE6->VE6_GRUITE+VE6->VE6_CODITE)
		
		DbSelectArea("SB5")
		DbSetOrder(1)
		DbSeek(xFilial("SB5")+SB1->B1_COD)
	
		DbSelectArea("SB2")
		DbSetOrder(1)
		DbSeek(xFilial("SB2")+SB1->B1_COD)
		
		if MV_PAR06 == 1
			DbSelectArea("VEG")
			DbSetOrder(2)
			DbSeek(xFilial("VEG")+"04"+strzero(val(Mv_Par03),6))
			wVar := VEG->VEG_FORMUL
			nValFor   := &wVar
		else
			nValFor := VE6->VE6_VALPEC
		endif
		
		DbSelectArea("VE7")
		DbSetOrder(1)
		DbSeek(xFilial("VE7")+VE6->VE6_INDREG+VE6->VE6_CODMOT)
		
		DbSelectArea("SBM")
		DbSetOrder(1)
		DbSeek(xFilial("SBM")+VE6->VE6_GRUITE)
		
		DbSelectArea("VAI")
		DbSetOrder(4)
		DbSeek(xFilial("VAI")+VE6->VE6_CODUSU)
		
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial("SA1")+VE6->VE6_CODCLI+VE6->VE6_LOJCLI)
		
		dbSelectArea("SB2")
		dbSetOrder(1)
		dbSeek(xFilial("SB2")+SB1->B1_COD)
		
		
		cNomeUser := UsrRetName(VE6->VE6_CODUSU)
		
		i:= 1
		
		cCampo  := "cObser"+STRZERO(i,2)
		cKeyAce := VE6->VE6_OBSMEM + strzero(i,3)
		
		if FG_SEEK("SYP","cKeyAce",1,.f.)
			
			nPos := AT("\13\10",SYP->YP_TEXTO)
			
			if nPos > 0
				nPos-=1
			Else
				nPos := AT("\13",SYP->YP_TEXTO)
				if nPos > 0
					nPos-=1
				Else
					nPos := Len(SYP->YP_TEXTO)
				Endif
			Endif
			
			&cCampo := Substr(SYP->YP_TEXTO,1,nPos)
			
		Else
			&cCampo := " "
		Endif
		
		nSalAtu:=CalcEst(SB1->B1_COD,"01",VE6->VE6_DATREG+1)[1]
		
		cQuery := "SELECT SC7.C7_PRODUTO, SUM(C7_QUANT) AS C7_QTDPED "
		cQuery += "FROM "+RetSqlName("SC7")+" SC7 "
		cQuery += "WHERE SC7.C7_FILIAL = '"+xFilial("SC7")+"' And SC7.C7_PRODUTO = '"+SB1->B1_COD+"' And (SC7.C7_QUANT-SC7.C7_QUJE) > 0 And SC7.C7_RESIDUO <> 'S' And SC7.D_E_L_E_T_ = ' ' "
		cQuery += "GROUP BY SC7.C7_PRODUTO "
		
		TcQuery cQuery New Alias "TMPSC7"
		nQtdPed := TMPSC7->C7_QTDPED
		
		TMPSC7->(DbCloseArea())
		
		DbSelectArea("CTT")
		DbSetOrder(1)
		DbSeek( xFilial("CTT") + VAI->VAI_CC )
		
		DbSelectArea("TRB")
		RecLock("TRB",.t.)
		TRB->TRB_GRUPO   := VE6->VE6_GRUITE
		TRB->TRB_DESGRU  := SBM->BM_DESC
		TRB->TRB_CODITE  := VE6->VE6_CODITE
		TRB->TRB_DESCRI  := SB1->B1_DESC
		TRB->TRB_CODUSU  := VE6->VE6_CODUSU
		TRB->TRB_NOMUSU  := cNomeUser
		TRB->TRB_CENCUS  := VAI->VAI_CC
		TRB->TRB_DESCUS  := CTT->CTT_DESC01
		TRB->TRB_CODMOT  := VE6->VE6_CODMOT
		TRB->TRB_DESMOT  := VE7->VE7_DESMOT
		TRB->TRB_DATA    := VE6->VE6_DATREG
		TRB->TRB_NOMCLI  := SA1->A1_NOME
		TRB->TRB_FONCLI  := SA1->A1_TEL
		TRB->TRB_OBSMEM  := &cCampo
		TRB->TRB_VALFOR  := nValFor
		TRB->TRB_QTDITE  := VE6->VE6_QTDITE
		TRB->TRB_LOCAL   := SB2->B2_LOCAL
		
		TRB->TRB_QATU    := nSalAtu
		TRB->TRB_QPED    := nQtdPed
		
		MsUnlock()
		
		nTotGValF += TRB->TRB_QTDITE*TRB->TRB_VALFOR
		
		DbSelectArea("VE6")
		DbSkip()
		
	Enddo
Endif
if MV_PAR08 == 2 .or. MV_PAR08 == 3
	// Venda Perdida
	If !Empty(MV_PAR07)
		cMot := MV_PAR07
		For i := 1 to Len(cMot)
			nPos := AT("/",cMot)
			nPos1 := nPos
			If nPos > 0
				nPos -= 1
			Else
				nPos := Len(cMot)
			Endif

			If !Empty(cMotivos)
				cMotivos := alltrim(Substr(cMot,1,nPos))
				cMotNCons += "'"+cMotivos+"'"
			EndIf

			cMot := Substr(cMot,nPos+2,len(cMot))
			If Empty(Alltrim(cMot))
				Exit
			Endif

			If !Empty(cMotNCons)
				cMotNCons += ","
			EndIf
		Next
	EndIf

	cQuery := "SELECT VS3.VS3_GRUITE,SBM.BM_DESC,VS3.VS3_CODITE,VS3.VS3_MOTPED,VS3.VS3_VALPEC,VS3.VS3_QTDINI,VS3.VS3_QTDITE,VS3.VS3_LOCAL,SB1.B1_COD,SB1.B1_DESC,VS1.VS1_CENCUS,VS1.VS1_DATORC,VS1.VS1_CODVEN,VS1.VS1_TIPORC,SA3.A3_NOME,CTT.CTT_DESC01,VS0.VS0_DESMOT,SA1.A1_NOME,SA1.A1_TEL "
	cQuery += "FROM " + RetSQLName("VS3") + " VS3"
	cQuery += " INNER JOIN " + RetSQLName("VS1") + " VS1 ON (VS1.VS1_FILIAL = '"+xFilial("VS1")+"' AND VS1.VS1_NUMORC = VS3.VS3_NUMORC AND VS1.D_E_L_E_T_ = ' ')"
	cQuery += " INNER JOIN " + RetSQLName("SB1") + " SB1 ON (SB1.B1_FILIAL = '"+xFilial("SB1")+"' AND VS3.VS3_GRUITE = SB1.B1_GRUPO AND VS3.VS3_CODITE = SB1.B1_CODITE AND SB1.D_E_L_E_T_ = ' ')"
	cQuery += " INNER JOIN " + RetSQLName("SBM") + " SBM ON (SBM.BM_FILIAL = '"+xFilial("SBM")+"' AND SB1.B1_GRUPO = SBM.BM_GRUPO AND SBM.D_E_L_E_T_ = ' ')"
	cQuery += " LEFT JOIN " + RetSQLName("SA3") + " SA3 ON (SA3.A3_FILIAL = '"+xFilial("SA3")+"' AND SA3.A3_COD = VS1.VS1_CODVEN AND SA3.D_E_L_E_T_ = ' ')"
	cQuery += " LEFT JOIN " + RetSQLName("CTT") + " CTT ON (CTT.CTT_FILIAL = '"+xFilial("CTT")+"' AND CTT.CTT_CUSTO = VS1.VS1_CENCUS AND SA3.D_E_L_E_T_ = ' ')"
	cQuery += " LEFT JOIN " + RetSQLName("VS0") + " VS0 ON (VS0.VS0_FILIAL = '"+xFilial("VS0")+"' AND VS0.VS0_TIPASS = '000004' AND VS0.VS0_CODMOT = VS3.VS3_MOTPED AND VS0.D_E_L_E_T_ = ' ')"
	cQuery += " LEFT JOIN " + RetSQLName("SA1") + " SA1 ON (SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VS1.VS1_CLIFAT AND SA1.A1_LOJA = VS1.VS1_LOJA AND SA1.D_E_L_E_T_ = ' ')"
	cQuery += " WHERE VS3.VS3_FILIAL = '"+xFilial("VS3")+"' AND VS1.VS1_DATORC >= '"+dtos(MV_PAR01)+"' AND VS1.VS1_DATORC <= '"+dtos(MV_PAR02)+"' AND VS3.VS3_MOTPED <> ' ' AND "
	if !Empty(cMotNCons)
		cQuery += " VS3.VS3_MOTPED NOT IN ("+cMotNCons+") AND "
	Endif	
	cQuery += "VS3.D_E_L_E_T_ = ' '"
	
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cSQLVdaPer , .F. , .T. )
	
	While !(cSQLVdaPer)->(Eof())
	
		nSalAtu:=CalcEst((cSQLVdaPer)->B1_COD,"01",stod((cSQLVdaPer)->VS1_DATORC)+1)[1]
	
		cQuery := "SELECT SC7.C7_PRODUTO, SUM(C7_QUANT) AS C7_QTDPED "
		cQuery += "FROM "+RetSqlName("SC7")+" SC7 "
		cQuery += "WHERE SC7.C7_FILIAL = '"+xFilial("SC7")+"' And SC7.C7_PRODUTO = '"+(cSQLVdaPer)->B1_COD+"' And (SC7.C7_QUANT-SC7.C7_QUJE) > 0 And SC7.C7_RESIDUO <> 'S' And SC7.D_E_L_E_T_ = ' ' "
		cQuery += "GROUP BY SC7.C7_PRODUTO "
		
		TcQuery cQuery New Alias "TMPSC7"
		nQtdPed := TMPSC7->C7_QTDPED
		
		TMPSC7->(DbCloseArea())
	
		DbSelectArea("TRB")
		RecLock("TRB",.t.)
		TRB->TRB_GRUPO   := (cSQLVdaPer)->VS3_GRUITE
		TRB->TRB_DESGRU  := (cSQLVdaPer)->BM_DESC
		TRB->TRB_CODITE  := (cSQLVdaPer)->VS3_CODITE
		TRB->TRB_DESCRI  := (cSQLVdaPer)->B1_DESC
		TRB->TRB_CODUSU  := (cSQLVdaPer)->VS1_CODVEN
		TRB->TRB_NOMUSU  := (cSQLVdaPer)->A3_NOME
		TRB->TRB_CENCUS  := (cSQLVdaPer)->VS1_CENCUS
		TRB->TRB_DESCUS  := (cSQLVdaPer)->CTT_DESC01
		TRB->TRB_CODMOT  := (cSQLVdaPer)->VS3_MOTPED
		TRB->TRB_DESMOT  := (cSQLVdaPer)->VS0_DESMOT
		TRB->TRB_DATA    := stod((cSQLVdaPer)->VS1_DATORC)
		TRB->TRB_NOMCLI  := (cSQLVdaPer)->A1_NOME
		TRB->TRB_FONCLI  := (cSQLVdaPer)->A1_TEL
	//	TRB->TRB_OBSMEM  := &cCampo
		TRB->TRB_VALFOR  := (cSQLVdaPer)->VS3_VALPEC
		TRB->TRB_QTDITE  := IIF((cSQLVdaPer)->VS1_TIPORC == "P", (cSQLVdaPer)->VS3_QTDINI, (cSQLVdaPer)->VS3_QTDITE)
		TRB->TRB_LOCAL   := (cSQLVdaPer)->VS3_LOCAL
		
		TRB->TRB_QATU    := nSalAtu
		TRB->TRB_QPED    := nQtdPed
		
		MsUnlock()
		
		nTotGValF += TRB->TRB_QTDITE*TRB->TRB_VALFOR
	
		DbSelectArea(cSQLVdaPer)
		(cSQLVdaPer)->(DbSkip())
	
	Enddo
	(cSQLVdaPer)->(DbCloseArea())
Endif
	
dbSelectArea("TRB")
dbgotop()
cGruIte  := TRB->TRB_GRUPO
cCodUsu  := TRB->TRB_CODUSU
cCenCus  := TRB->TRB_CENCUS
cMotivo  := TRB->TRB_CODMOT
dData    := TRB->TRB_DATA
//cValFor  := TRB->TRB_QTDITE*TRB->TRB_VALFOR
while !EOF()
	if mv_par04 == 1  //Grupo
		if TRB->TRB_GRUPO == cGruIte
			dbSelectArea("TR1")
			lAchou := DbSeek(TRB->TRB_GRUPO)
			RecLock("TR1",!lAchou)
			TR1->TR1_CHAVE := TRB->TRB_GRUPO
			TR1->TR1_TOTAL := TR1->TR1_TOTAL + TRB->TRB_QTDITE*TRB->TRB_VALFOR
			MsUnlock()
		Endif
		
	Elseif mv_par04 == 2  //Usuario
		if TRB->TRB_CODUSU == cCodUsu
			dbSelectArea("TR1")
			lAchou :=  DbSeek(TRB->TRB_CODUSU)
			RecLock("TR1",!lAchou)
			TR1->TR1_CHAVE := TRB->TRB_CODUSU
			TR1->TR1_TOTAL := TR1->TR1_TOTAL + TRB->TRB_QTDITE*TRB->TRB_VALFOR
			MsUnlock()
		Endif
	Elseif mv_par04 == 3  //Centro de Custo
		if TRB->TRB_CENCUS == cCenCus
			dbSelectArea("TR1")
			lAchou := DbSeek(TRB->TRB_CENCUS)
			RecLock("TR1",!lAchou)
			TR1->TR1_CHAVE := TRB->TRB_CENCUS
			TR1->TR1_TOTAL := TR1->TR1_TOTAL + TRB->TRB_QTDITE*TRB->TRB_VALFOR
			MsUnlock()
		Endif
	Elseif mv_par04 == 4  //Motivo
		if TRB->TRB_CODMOT == cMotivo
			dbSelectArea("TR1")
			lAchou := DbSeek(TRB->TRB_CODMOT)
			RecLock("TR1",!lAchou)
			TR1->TR1_CHAVE := TRB->TRB_CODMOT
			TR1->TR1_TOTAL := TR1->TR1_TOTAL + TRB->TRB_QTDITE*TRB->TRB_VALFOR
			MsUnlock()
		Endif
	Else// mv_par04 == 5 //Data
		if TRB->TRB_DATA == dData
			dbSelectArea("TR1")
			lAchou := DbSeek(dtos(TRB->TRB_DATA))
			RecLock("TR1",!lAchou)
			TR1->TR1_CHAVE := dtos(TRB->TRB_DATA)
			TR1->TR1_TOTAL := TR1->TR1_TOTAL + TRB->TRB_QTDITE*TRB->TRB_VALFOR
			MsUnlock()
		Endif
		
	Endif
	
	DbSelectArea("TRB")
	DbSkip()
	cGruIte  := TRB->TRB_GRUPO
	cCodUsu  := TRB->TRB_CODUSU
	cCenCus  := TRB->TRB_CENCUS
	cMotivo  := TRB->TRB_CODMOT
	dData    := TRB->TRB_DATA
	
Enddo

if mv_par04 == 1
	@ nLin, 001 pSay STR0006    //"...............G R U P O  D E  P E C A S.................."
	nLin+=2
Elseif mv_par04 == 2
	@ nLin, 001 pSay STR0007    //"......................U S U A R I O......................."
	nLin+=2
Elseif mv_par04 == 3
	@ nLin, 001 pSay STR0008    //"..............C E N T R O  D E  C U S T O................."
	nLin+=2
Elseif mv_par04 == 4
	@ nLin, 001 pSay STR0009    //"......................M O T I V O........................."
	nLin+=2
Else
	@ nLin, 001 pSay STR0010    //"........................D A T A..........................."
	nLin+=2
Endif

@ nLin, 001 pSay STR0005+" "+transform(nTotGValF, "@E 999,999,999.99")     //"Total Geral..............................................."
nLin+=2

dbSelectArea("TRB")
dbgotop()

cGruIte := " "
cCodUsu := " "
cCenCus := " "
cMotivo := " "
dData   := ctod("  /  /  ")

While !Eof()
	
	if mv_par04 == 1 // Grupo da Peca
		if TRB->TRB_GRUPO <> cGruIte
			TR1->(DbSeek(TRB->TRB_GRUPO))
			nLin++
			@ nLin++, 001 pSay TRB->TRB_GRUPO+" "+TRB->TRB_DESGRU+space(33)+transform(TR1->TR1_TOTAL, "@E 999,999,999.99")
			
		Endif
	Elseif mv_par04 == 2  // Usuario
		if TRB->TRB_CODUSU <> cCodUsu
			TR1->(DbSeek(TRB->TRB_CODUSU))
			nLin++
			@ nLin++, 001 pSay TRB->TRB_CODUSU+" "+TRB->TRB_NOMUSU+space(51)+transform(TR1->TR1_TOTAL, "@E 999,999,999.99")
			
		Endif
	Elseif mv_par04 == 3  // Centro de Custo
		if TRB->TRB_CENCUS <> cCenCus
			TR1->(DbSeek(TRB->TRB_CENCUS))
			nLin++
			@ nLin++, 001 pSay TRB->TRB_CENCUS+" "+TRB->TRB_DESCUS+space(38)+transform(TR1->TR1_TOTAL, "@E 999,999,999.99")
			
		Endif
	Elseif mv_par04 == 4  // Motivo
		if TRB->TRB_CODMOT <> cMotivo
			TR1->(DbSeek(TRB->TRB_CODMOT))
			nLin++
			@ nLin++, 001 pSay TRB->TRB_CODMOT+" "+TRB->TRB_DESMOT+space(36)+transform(TR1->TR1_TOTAL, "@E 999,999,999.99")
			
		Endif
	Else   //Data
		if TRB->TRB_DATA <> dData
			TR1->(DbSeek(dtos(TRB->TRB_DATA)))
			nLin++
			@ nLin++, 001 pSay Transform(TRB->TRB_DATA, "@D")+Space(65)+Transform(TR1->TR1_TOTAL, "@E 999,999,999.99")
			
		Endif
	Endif
	
	@ nLin++, 001 pSay Space(5)+TRB->TRB_GRUPO+" "+Substr(TRB->TRB_CODITE,1,23)+" "+Substr(TRB->TRB_DESCRI,1,20)+" "+Transform(TRB->TRB_QTDITE, "@E 99,999")+" "+Transform(TRB->TRB_QATU, "@E 99,999")+" "+Space(7)+Transform(TRB->TRB_QPED, "@E 99,999")+"  "+Transform(TRB->TRB_QTDITE*TRB->TRB_VALFOR, "@E 999,999.99")+"  "+Substr(TRB->TRB_NOMCLI,1,25)+" "+Substr(TRB->TRB_FONCLI,1,10)+" "+Substr(TRB->TRB_OBSMEM,1,10)+" "+Transform(TRB->TRB_DATA, "@D")
	
	if nlin > 55
		nlin := 1
		nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg,cTamanho,nCaracter)+1
		
		@ nLin, 001 pSay STR0005       //"Total Geral..............................................."
		nLin++
		
		@ nlin, 001 pSay "------------------------------------------------------------------------------------------------------------------------------------------------"
		nlin++
		
	Endif
	
	cGruIte  := TRB->TRB_GRUPO
	cCodUsu  := TRB->TRB_CODUSU
	cCenCus  := TRB->TRB_CENCUS
	cMotivo  := TRB->TRB_CODMOT
	dData    := TRB->TRB_DATA
	
	DbSelectArea("TRB")
	DbSkip()
	
Enddo

Eject

Set Printer to
Set device to Screen

MS_FLUSH()
If aReturn[5] == 1
	OurSpool(cNomeRel)
EndIf

oObjTempTable:CloseTable()
o2ObjTempTable:CloseTable()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ValidPergº Autor ³ Otavio Favarelli   º Data ³ 26/10/09    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Manipula SX1 Parametros                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Geral                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ValidPerg(cPerg)

local _sAlias := Alias()
local aRegs := {}
local i,j

dbSelectArea("SX1")
dbSetOrder(1)  
dbgotop()
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01",STR0013,"","","mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","N"})
aAdd(aRegs,{cPerg,"02",STR0014,"","","mv_ch2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","S"})
aAdd(aRegs,{cPerg,"03",STR0015,"","","mv_ch3","C",6,0,0,"G","NaoVazio().and.FG_SEEK('VEG','MV_PAR03',1,.F.)","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","","S"})
aAdd(aRegs,{cPerg,"04",STR0016,"","","mv_ch4","C",1,0,0,"C","","mv_par04",STR0017,"","","","",STR0018,"","","","",STR0019,"","","","",STR0020,"","","","",STR0021,"","","","","S"})
aAdd(aRegs,{cPerg,"05",STR0022,"","","mv_ch5","C",1,0,0,"C","","mv_par05",STR0023,"","","","",STR0024,"","","","","","","","","","","","","","","","","","","","S"})
aAdd(aRegs,{cPerg,"06",STR0025,"","","mv_ch6","C",1,0,0,"C","","mv_par06",STR0026,"","","","",STR0027,"","","","","","","","","","","","","","","","","","","","S"})
aAdd(aRegs,{cPerg,"07",STR0028,"","","mv_ch7","C",80,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","S"})
aAdd(aRegs,{cPerg,"08",STR0029,"","","mv_ch8","C",1,0,0,"C","","mv_par08",STR0030,"","","","",STR0031,"","","","",STR0032,"","","","","","","","","","","","","","","S"})

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


