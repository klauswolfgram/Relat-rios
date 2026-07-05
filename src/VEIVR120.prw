/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 06     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#include "Protheus.ch"
#Include "Veivr120.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VEIVR120 ºAutor  ³Andre Luis Almeida  º Data ³  27/02/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Estoque de Veiculos // Antigo ESTVEI                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Veiculos MIL                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEIVR120
cAlias    := "VV1"
nLin      := 0
aPag      := 1
aReturn   := {STR0002,1,STR0003,2,2,1,"",1}
cTamanho  := "P"           // P/M/G
Limite    := 80           // 80/132/220
aOrdem    := {}           // Ordem do Relatorio
cTitulo   := STR0001
cDesc1    := STR0001
cDesc2    := ""
cDesc3    := ""
cNomeRel  := "VEIVR120"
nLastKey  := 0
nCaracter := 15
cabec1    := ""
cabec2    := ""
cPerg     := "VER120"
cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
If nLastKey == 27
	Return
EndIf
PERGUNTE(cPerg,.f.)
SetDefault(aReturn,cAlias)
RptStatus( { |lEnd| FS_IMPESTVEI(@lEnd,cNomeRel,cAlias) } , cTitulo )
If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf
MS_Flush()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FS_IMPESTVEI ºAutor ³Andre Luis Almeida ºData³  27/02/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime estoque do veiculo.		                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Veiculos MIL                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPESTVEI()
Local cQAlVV1 := "SQLVV1"
Local cQuery := ""
Local nNovoUsado := 0
Local ni := 0
Local cCor      := "INICIAR"
Local cQuebra   := "INICIAR"
Local cSitVei   := "INICIAR"
Local cMod      := "INICIAR"
Local cQuebraMod:="INICIAR"
Local nTotal    := 0
Local lOK       := .f.
Local aNumEst   := {}
Local aGrpEst   := {}
Local aTotMod   := {}
Local aTotSit   := {}
Local aTotDisp  := {}
Local aModDisp  := {}
Local aCorDisp  := {}
Local aInfVei   := {}
Private cString := "VV1"
Private Li      := 80
Private m_Pag   := 1

aAdd(aTotSit,{ "0" , "0" , 0 })  // Na Empresa - Veiculos Novos
aAdd(aTotSit,{ "0" , "1" , 0 })  // Na Empresa - Veiculos Usados
aAdd(aTotSit,{ "3" , "0" , 0 })  // Com Terceiros - Veiculos Novos
aAdd(aTotSit,{ "3" , "1" , 0 })  // Com Terceiros - Veiculos Usados
aAdd(aTotSit,{ "6" , "0" , 0 })  // Bloqueados - Veiculos Novos
aAdd(aTotSit,{ "6" , "1" , 0 })  // Bloqueados - Veiculos Usados
aAdd(aTotSit,{ "4" , "0" , 0 })  // Consignados - Veiculos Novos
aAdd(aTotSit,{ "4" , "1" , 0 })  // Consignados - Veiculos Usados

aAdd(aTotDisp,{ STR0004 , "0" , 0 })  // Disponiveis para Venda  - Veiculos Novos
aAdd(aTotDisp,{ STR0005 , "1" , 0 })  // Disponiveis para Venda  - Veiculos Usados

Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer

cQuery := "SELECT VV1.VV1_SITVEI , VV1.VV1_ESTVEI , VV1.VV1_TRACPA , VV1.VV1_NUMTRA , VV1.VV1_CHASSI , VV1.VV1_CODMAR , VV1.VV1_MODVEI , VV1.VV1_CORVEI , VV1.VV1_DTHRES , VV1.VV1_DTHVAL , VV1.VV1_FABMOD , VV1.VV1_PLAVEI "
cQuery += "FROM "+RetSqlName("VV1")+" VV1 WHERE VV1.VV1_FILIAL='"+xFilial("VV1")+"' AND VV1.VV1_SITVEI IN ('0','3','4','6') AND VV1.D_E_L_E_T_=' ' ORDER BY VV1.VV1_SITVEI , VV1.VV1_CODMAR , VV1.VV1_MODVEI , VV1.VV1_CORVEI "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVV1 , .F., .T. )
SetRegua( ( cQAlVV1 )->( RecCount() ) )
Do While !( cQAlVV1 )->( Eof() )
	
	IncRegua()
	If ( cQAlVV1 )->( VV1_SITVEI ) == "0" .and. left(( cQAlVV1 )->( VV1_TRACPA ),6) == "FATDIR"
		( cQAlVV1 )->(	DbSkip() )
		Loop
	EndIf
	
	aadd(aInfVei,( cQAlVV1 )->( VV1_CHASSI ))
	
	DbSelectArea("VVF")
	DbSetOrder(1)
	DbSeek(xFilial("VVF") + ( cQAlVV1 )->( VV1_TRACPA ) )
	if !Empty(MV_PAR08) .or. !Empty(MV_PAR09)
		if VVF->VVF_DATMOV < MV_PAR08 .or. VVF->VVF_DATMOV > MV_PAR09
			( cQAlVV1 )->( DbSkip() )
			Loop
		Endif
	Endif
	if MV_PAR10 > 0
		if (ddatabase-VVF->VVF_DATMOV) < MV_PAR10
			( cQAlVV1 )->( DbSkip() )
			Loop
		Endif
	Endif
	
	nTotal++
	
	nPos := 0
	nPos := aScan(aTotSit,{|x| x[1] + x[2] == ( cQAlVV1 )->( VV1_SITVEI ) + ( cQAlVV1 )->( VV1_ESTVEI ) })
	If nPos > 0
		aTotSit[nPos,3]++
	EndIf
	
	If cMod <> ( ( cQAlVV1 )->( VV1_CODMAR ) + ( cQAlVV1 )->( VV1_MODVEI ) )
		cMod := ( ( cQAlVV1 )->( VV1_CODMAR ) + ( cQAlVV1 )->( VV1_MODVEI ) )
		DbSelectArea("VV2")
		DbSetOrder(1)
		DbSeek( xFilial("VV2") + cMod )
	EndIf
	nPos := 0
	nPos := aScan(aTotMod,{|x| x[1] + x[2] + x[3] + x[4] == ( cQAlVV1 )->( VV1_SITVEI ) + ( cQAlVV1 )->( VV1_ESTVEI ) + ( cQAlVV1 )->( VV1_CODMAR ) + left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) })
	If nPos == 0
		aAdd(aTotMod,{ ( cQAlVV1 )->( VV1_SITVEI ) , ( cQAlVV1 )->( VV1_ESTVEI ) , ( cQAlVV1 )->( VV1_CODMAR ) , left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) , 1 })
	Else
		aTotMod[nPos,5]++
	EndIf
	
	If cCor <> ( ( cQAlVV1 )->( VV1_CODMAR ) + ( cQAlVV1 )->( VV1_CORVEI ) )
		cCor := ( ( cQAlVV1 )->( VV1_CODMAR ) + ( cQAlVV1 )->( VV1_CORVEI ) )
		DbSelectArea("VVC")
		DbSetOrder(1)
		DbSeek( xFilial("VVC") + cCor )
	EndIf
	nPos := 0
	nPos := aScan(aGrpEst,{|x| x[1] + x[2] + x[3] + x[4] + x[5] == ( cQAlVV1 )->( VV1_SITVEI ) + ( cQAlVV1 )->( VV1_ESTVEI ) + ( cQAlVV1 )->( VV1_CODMAR ) + left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) + VVC->VVC_DESCRI })
	If nPos == 0
		aAdd(aGrpEst,{ ( cQAlVV1 )->( VV1_SITVEI ) , ( cQAlVV1 )->( VV1_ESTVEI ) , ( cQAlVV1 )->( VV1_CODMAR ) , left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) , VVC->VVC_DESCRI , 1 })
	Else
		aGrpEst[nPos,6]++
	EndIf
	
	cTerceiro := ""
	cReserva  := ""
	If (!Empty(stod(( cQAlVV1 )->( VV1_DTHRES ))).and.(ctod(substr(( cQAlVV1 )->( VV1_DTHVAL ),1,8)) > dDataBase)) .or. ( cQAlVV1 )->( VV1_SITVEI ) == "3"
		DbSelectArea("VV0")
		DbSetOrder(1)
		DbSeek(xFilial("VV0") + ( cQAlVV1 )->( VV1_NUMTRA ) )
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial("SA1") + VV0->VV0_CODCLI + VV0->VV0_LOJA )
		If ( cQAlVV1 )->( VV1_SITVEI ) == "3"
			cTerceiro := left(SA1->A1_NOME,27)
		EndIf
		If (!Empty(stod(( cQAlVV1 )->( VV1_DTHRES ))).and.(ctod(substr(( cQAlVV1 )->( VV1_DTHVAL ),1,8)) > dDataBase))
			cReserva := STR0006 +" "+ substr(( cQAlVV1 )->( VV1_DTHVAL ),1,8) +" "+ left(SA1->A1_NOME,16)
		EndIf
	EndIf
	
	aAdd(aNumEst,{ ( cQAlVV1 )->( VV1_SITVEI ) , ( cQAlVV1 )->( VV1_ESTVEI ) , ( cQAlVV1 )->( VV1_CODMAR ) , left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) , VVC->VVC_DESCRI , ( cQAlVV1 )->( VV1_CHASSI ) , Transform(( cQAlVV1 )->( VV1_FABMOD ),"@R 9999/9999") , VVF->VVF_DATMOV , cReserva , Dtos(VVF->VVF_DATMOV), cTerceiro , ( cQAlVV1 )->( VV1_MODVEI ) , ( cQAlVV1 )->( VV1_PLAVEI ) })
	
	If ( cQAlVV1 )->( VV1_SITVEI ) # "6"
		If ( cQAlVV1 )->( VV1_ESTVEI ) == "0"
			aTotDisp[1,3]++
		ElseIf ( cQAlVV1 )->( VV1_ESTVEI ) == "1"
			aTotDisp[2,3]++
		EndIf
		nPos := 0
		nPos := aScan(aModDisp,{|x| x[1] + x[2] + x[3] == ( cQAlVV1 )->( VV1_ESTVEI ) + ( cQAlVV1 )->( VV1_CODMAR ) + left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) })
		If nPos == 0
			aAdd(aModDisp,{ ( cQAlVV1 )->( VV1_ESTVEI ) , ( cQAlVV1 )->( VV1_CODMAR ) , left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) , 1 })
		Else
			aModDisp[nPos,4]++
		EndIf
		nPos := 0
		nPos := aScan(aCorDisp,{|x| x[1] + x[2] + x[3] + x[4] == ( cQAlVV1 )->( VV1_ESTVEI ) + ( cQAlVV1 )->( VV1_CODMAR ) + left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) + VVC->VVC_DESCRI })
		If nPos == 0
			aAdd(aCorDisp,{ ( cQAlVV1 )->( VV1_ESTVEI ) , ( cQAlVV1 )->( VV1_CODMAR ) , left(Alltrim(( cQAlVV1 )->( VV1_MODVEI ))+" "+VV2->VV2_DESMOD+space(40),40) , VVC->VVC_DESCRI , 1 })
		Else
			aCorDisp[nPos,5]++
		EndIf
	EndIf
	
	( cQAlVV1 )->( DbSkip() )
EndDo
( cQAlVV1 )->( DbCloseArea() )

cabec1 := space(6)+STR0008 + Transform(nTotal,"@E 99999,999")
nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 7
@ nLin++ , 13 psay STR0009
@ nLin++ , 13 psay "|                                                  |"
@ nLin++ , 13 psay "|   " + STR0010 + Transform(aTotDisp[1,3],"@E 99,999") + "     " + Transform(aTotDisp[2,3],"@E 99,999") + "   |"
@ nLin++ , 13 psay "|                                                  |"
@ nLin++ , 13 psay "|   " + STR0011 + Transform(aTotSit[1,3],"@E 99,999")  + "     " + Transform(aTotSit[2,3],"@E 99,999")  + "   |"
@ nLin++ , 13 psay "|                                                  |"
@ nLin++ , 13 psay "|   " + STR0012 + Transform(aTotSit[3,3],"@E 99,999")  + "     " + Transform(aTotSit[4,3],"@E 99,999")  + "   |"
@ nLin++ , 13 psay "|                                                  |"
@ nLin++ , 13 psay "|   " + STR0013 + Transform(aTotSit[5,3],"@E 99,999")  + "     " + Transform(aTotSit[6,3],"@E 99,999")  + "   |"
@ nLin++ , 13 psay "|                                                  |"
@ nLin++ , 13 psay "|   " + STR0014 + Transform(aTotSit[7,3],"@E 99,999")  + "     " + Transform(aTotSit[8,3],"@E 99,999")  + "   |"
@ nLin++ , 13 psay "|                                                  |"
@ nLin++ , 13 psay "|   " + STR0015 +  Transform(aTotDisp[1,3]+aTotSit[5,3],"@E 99,999") + "     " + Transform(aTotDisp[2,3]+aTotSit[6,3],"@E 99,999") + "   |"
@ nLin++ , 13 psay "|                                                  |"
@ nLin++ , 13 psay STR0016

For nNovoUsado:=1 to 2
	
	If MV_PAR07 == 1 .or. MV_PAR07 == (nNovoUsado+1)
		
		If MV_PAR01 == 1
			aSort(aNumEst,1,,{|x,y| x[2]+x[3]+x[4]+x[5]+x[10]+x[6] < y[2]+y[3]+y[4]+y[5]+y[10]+y[6] })
			For ni:=1 to len(aNumEst)
				If aNumEst[ni,2] == str(nNovoUsado-1,1)
					If aNumEst[ni,1] # "6"
						If cSitVei # aNumEst[ni,2]
							cSitVei := aNumEst[ni,2]
							If cSitVei == "0"
								cabec1 := space(4)+STR0017+ Transform(aTotDisp[1,3],"@E 99,999") // "***   NOVOS DISPONIVEIS PARA VENDA   ***                  Total:"
								nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
								cabec1 := space(4)+STR0018 // "***   NOVOS DISPONIVEIS PARA VENDA   ***                Continuacao..."
							Else
								cabec1 := space(4)+STR0019+ Transform(aTotDisp[2,3],"@E 99,999") // "***   USADOS DISPONIVEIS PARA VENDA   ***                 Total:"
								nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
								cabec1 := space(4)+STR0020 // "***   USADOS DISPONIVEIS PARA VENDA   ***               Continuacao..."
							EndIf
						EndIf
						If ( cQuebraMod # ( aNumEst[ni,2]+aNumEst[ni,3]+aNumEst[ni,4] ))
							cQuebraMod := ( aNumEst[ni,2]+aNumEst[ni,3]+aNumEst[ni,4] )
							If nLin > 52
								nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							EndIf
							nPos := 0
							nPos := aScan(aModDisp,{|x| x[1] + x[2] + x[3] == cQuebraMod })
							nLin++
							@ nLin++ , 05 psay aModDisp[nPos,2] + " " + aModDisp[nPos,3] + right(STR0021,19) + Transform(aModDisp[nPos,4],"@E 99,999") // "   Total do Modelo:"
						EndIf
						If	( cQuebra # ( aNumEst[ni,2]+aNumEst[ni,3]+aNumEst[ni,4]+aNumEst[ni,5] ))
							cQuebra := ( aNumEst[ni,2]+aNumEst[ni,3]+aNumEst[ni,4]+aNumEst[ni,5] )
							If nLin > 55
								nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							EndIf
							nPos := 0
							nPos := aScan(aCorDisp,{|x| x[1] + x[2] + x[3] + x[4] == cQuebra })
							nLin++
							@ nLin++ , 03 psay Transform(aCorDisp[nPos,5],"@E 99,999") + " " + aCorDisp[nPos,4]
						EndIf
						If nLin > 59
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
						EndIf
						If cSitVei == "0"
							@ nLin++ , 10 psay aNumEst[ni,6] +" "+ aNumEst[ni,7] +" "+ If(Empty(aNumEst[ni,9]),Transform(dDataBase-aNumEst[ni,8],"@E 999,999")+STR0022,aNumEst[ni,9]) // " dias  "
						Else
							@ nLin++ , 10 psay left(aNumEst[ni,6],20) +" "+ Transform(aNumEst[ni,13],VV1->(X3PICTURE("VV1_PLAVEI"))) +" "+ aNumEst[ni,7] +" "+ If(Empty(aNumEst[ni,9]),Transform(dDataBase-aNumEst[ni,8],"@E 999,999")+STR0022,aNumEst[ni,9]) // " dias  "
						EndIf
					EndIf
				EndIf
			Next
		EndIf
		
		cQuebra    := "INICIAR"
		cQuebraMod := "INICIAR"
		aSort(aNumEst,1,,{|x,y| x[1]+x[2]+x[3]+x[4]+x[5]+x[10]+x[6] < y[1]+y[2]+y[3]+y[4]+y[5]+y[10]+y[6] })
		For ni:=1 to len(aNumEst)
			lOK := .f.
			If aNumEst[ni,1]=="0" .and. MV_PAR02==1
				lOK := .t.
			ElseIf aNumEst[ni,1]=="3" .and. MV_PAR03==1
				lOK := .t.
			ElseIf aNumEst[ni,1]=="4" .and. MV_PAR04==1
				lOK := .t.
			ElseIf aNumEst[ni,1]=="6" .and. MV_PAR05==1
				lOK := .t.
			EndIf
			If lOK
				If aNumEst[ni,2] == str(nNovoUsado-1,1)
					If cSitVei # aNumEst[ni,1]+aNumEst[ni,2]
						cSitVei := aNumEst[ni,1]+aNumEst[ni,2]
						If cSitVei == "00"
							cabec1 := space(4)+STR0023+Transform(aTotSit[1,3],"@E 99,999") // "***   VEICULOS  NOVOS  EM  ESTOQUE  NA  EMPRESA   ***     Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0024 // "***   VEICULOS  NOVOS  EM  ESTOQUE  NA  EMPRESA   ***   Continuacao..."
						ElseIf cSitVei == "01"
							cabec1 := space(4)+STR0025+Transform(aTotSit[2,3],"@E 99,999") // "***   VEICULOS  USADOS  EM  ESTOQUE  NA  EMPRESA   ***    Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0026 // "***   VEICULOS  USADOS  EM  ESTOQUE  NA  EMPRESA   ***  Continuacao..."
						ElseIf cSitVei == "30"
							cabec1 := space(4)+STR0027+Transform(aTotSit[3,3],"@E 99,999") // "***   VEICULOS  NOVOS  EM  PODER  DE  TERCEIROS   ***     Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0028 // "***   VEICULOS  NOVOS  EM  PODER  DE  TERCEIROS   ***   Continuacao..."
						ElseIf cSitVei == "31"
							cabec1 := space(4)+STR0029+Transform(aTotSit[4,3],"@E 99,999") // "***   VEICULOS  USADOS  EM  PODER  DE  TERCEIROS   ***    Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0030 // "***   VEICULOS  USADOS  EM  PODER  DE  TERCEIROS   ***  Continuacao..."
						ElseIf cSitVei == "60"
							cabec1 := space(4)+STR0031+Transform(aTotSit[5,3],"@E 99,999") // "***   VEICULOS  NOVOS  RESERVADOS   ***                   Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0032 // "***   VEICULOS  NOVOS  RESERVADOS   ***                 Continuacao..."
						ElseIf cSitVei == "61"
							cabec1 := space(4)+STR0033+Transform(aTotSit[6,3],"@E 99,999") // "***   VEICULOS  USADOS  RESERVADOS   ***                  Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0034 // "***   VEICULOS  USADOS  RESERVADOS   ***                Continuacao..."
						ElseIf cSitVei == "40"
							cabec1 := space(4)+STR0035+Transform(aTotSit[7,3],"@E 99,999") // "***   VEICULOS  NOVOS  CONSIGNADOS   ***                  Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0036 // "***   VEICULOS  NOVOS  CONSIGNADOS   ***                Continuacao..."
						ElseIf cSitVei == "41"
							cabec1 := space(4)+STR0037+Transform(aTotSit[8,3],"@E 99,999") // "***   VEICULOS  USADOS  CONSIGNADOS   ***                 Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0038 // "***   VEICULOS  USADOS  CONSIGNADOS   ***               Continuacao..."
						EndIf
					EndIf
					If ( cQuebraMod # ( aNumEst[ni,1]+aNumEst[ni,2]+aNumEst[ni,3]+aNumEst[ni,4] ))
						cQuebraMod := ( aNumEst[ni,1]+aNumEst[ni,2]+aNumEst[ni,3]+aNumEst[ni,4] )
						If nLin > 52
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
						EndIf
						nPos := 0
						nPos := aScan(aTotMod,{|x| x[1] + x[2] + x[3] + x[4] == cQuebraMod })
						nLin++
						@ nLin++ , 05 psay aTotMod[nPos,3] + " " + aTotMod[nPos,4] + right(STR0021,19) + Transform(aTotMod[nPos,5],"@E 99,999") // "   Total do Modelo:"
					EndIf
					If ( cQuebra # ( aNumEst[ni,1]+aNumEst[ni,2]+aNumEst[ni,3]+aNumEst[ni,4]+aNumEst[ni,5] ))
						cQuebra := ( aNumEst[ni,1]+aNumEst[ni,2]+aNumEst[ni,3]+aNumEst[ni,4]+aNumEst[ni,5] )
						If nLin > 55
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
						EndIf
						nPos := 0
						nPos := aScan(aGrpEst,{|x| x[1] + x[2] + x[3] + x[4] + x[5] == cQuebra })
						nLin++
						@ nLin++ , 03 psay Transform(aGrpEst[nPos,6],"@E 99,999") + " " + aGrpEst[nPos,5]
					EndIf
					If nLin > 59
						nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
					EndIf
					If cSitVei == "0"
						@ nLin++ , 10 psay aNumEst[ni,6] +" "+ aNumEst[ni,7] +" "+ If(aNumEst[ni,1]=="3",aNumEst[ni,11], If(Empty(aNumEst[ni,9]),Transform(dDataBase-aNumEst[ni,8],"@E 999,999")+STR0022,aNumEst[ni,9])) // " dias  "
					Else
						@ nLin++ , 10 psay left(aNumEst[ni,6],20) +" "+ Transform(aNumEst[ni,13],VV1->(X3PICTURE("VV1_PLAVEI"))) +" "+ aNumEst[ni,7] +" "+ If(aNumEst[ni,1]=="3",aNumEst[ni,11], If(Empty(aNumEst[ni,9]),Transform(dDataBase-aNumEst[ni,8],"@E 999,999")+STR0022,aNumEst[ni,9])) // " dias  "
					EndIf
				EndIf
			EndIf
		Next
		
		cSitVei := "INICIAL"
		If MV_PAR06 == 1
			aSort(aNumEst,1,,{|x,y| x[2]+x[3]+x[4]+x[6]+x[5]+x[7] < y[2]+y[3]+y[4]+y[6]+y[5]+y[7] })
			For ni:=1 to len(aNumEst)
				If aNumEst[ni,2] == str(nNovoUsado-1,1)
					If cSitVei # aNumEst[ni,2]
						cSitVei := aNumEst[ni,2]
						If cSitVei == "0"
							cabec1 := space(4)+STR0039+Transform(aTotDisp[1,3]+aTotSit[5,3],"@E 99,999") // "***   NOVOS ESTOQUE FISCAL   ***                          Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0040 // "***   NOVOS ESTOQUE FISCAL   ***                        Continuacao..."
						Else
							cabec1 := space(4)+STR0041+Transform(aTotDisp[2,3]+aTotSit[6,3],"@E 99,999") // "***   USADOS ESTOQUE FISCAL   ***                         Total:"
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
							cabec1 := space(4)+STR0042 // "***   USADOS ESTOQUE FISCAL   ***                       Continuacao..."
						EndIf
					EndIf
					If nLin > 59
						nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
					EndIf
					If cSitVei == "0"
						@ nLin++ , 02 psay aNumEst[ni,3] + " " + left(aNumEst[ni,4],25) + " " + aNumEst[ni,6] + left(aNumEst[ni,5],12) + " " + aNumEst[ni,7]
					Else
						@ nLin++ , 01 psay aNumEst[ni,3] + left(aNumEst[ni,4],25) + " " + left(aNumEst[ni,6],20) + left(aNumEst[ni,13],7) + " " + left(aNumEst[ni,5],12) + " " + aNumEst[ni,7]
					EndIf
				EndIf
			Next
		EndIf
		
	EndIf
	
Next

////////////// Estoque por Chassi //////////////
Outputfile := FCREATE(__RELDIR+"ESTVEI.txt",0)
For ni := 1 to Len(aInfVei)
	fwrite(outputfile,aInfVei[ni]+CHR(10))
next
fclose(Outputfile)
////////////////////////////////////////////////

Set Printer to
Set Device  to Screen
Return
