/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 12     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼ 
#Include "PROTHEUS.Ch"
#Include "OFIPR160.Ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIPR160 ³ Autor ³ Andre Luis Almeida    ³ Data ³ 10/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao das Divergencias do Inventario                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIPR160(cVPE)
Default cVPE   := ""
Private cDesc1 := STR0001
Private cDesc2 := ""
Private cDesc3 := ""
Private tamanho:= "M"
Private limite := 132 
Private cString:= "VPG"
Private titulo := STR0001
Private cabec1 := ""
Private cabec2 := ""
Private aReturn := {STR0002,1,STR0003,1,2,1,"",1}  
Private nomeprog:= "OFIPR160"
Private aLinha  := { },nLastKey := 0
Private cPerg   := If(Empty(cVPE),"OFP160",nil)
//////////// PERGUNTE - OFP160 ////////////
//  01  Codigo Contagem  MV_PAR01  C  6  //
//  02  Codigo Contagem  MV_PAR01  C  6  //
///////////////////////////////////////////

nomeprog := SetPrint(cString,nomeprog,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)
If nLastKey == 27
	Return
EndIf     
If Empty(cVPE)
	Pergunte(cPerg,.f.)
Else
	MV_PAR01 := cVPE
	MV_PAR02 := 1
EndIf
SetDefault(aReturn,cString)
RptStatus( { |lEnd| FS_OFIPR160(@lEnd,nomeprog,cString) } , Titulo )
If aReturn[5] == 1
   OurSpool( nomeprog )
EndIf
MS_Flush()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OFIPR160 ³ Autor ³ Andre Luis Almeida ³ Data ³ 10/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao das Divergencias do Inventario                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OFIPR160()
Local ni := 0
Local nQtd := 0
Local nDig := 0
Local nPIte := 0
Local nPDiv := 0
Local nPCus := 0
Local nNIte := 0
Local nNDiv := 0
Local nNCus := 0
Local cQuery := ""
Local cQAlVPG := "SQLVPG"  // VPG


titulo := STR0001+" ( "+MV_PAR01+" )"
nLin  := 0
m_pag := 1
Set Printer to &nomeprog
Set Printer On
Set Device  to Printer
DbSelectArea("VPE")
DbSetOrder(1)
If DbSeek(xFilial("VPE")+MV_PAR01)
	cabec1 := space(36)+STR0004+" - "+STR0005+Transform(VPE->VPE_DATINI,"@D")+" "+Transform(VPE->VPE_HORINI,"@R 99:99")+" "+STR0008
	If VPE->VPE_FASE == "99"
		cabec1 += " - "+STR0006+Transform(VPE->VPE_DATFIN,"@D")+" "+Transform(VPE->VPE_HORFIN,"@R 99:99")+" "+STR0008
		cabec2 := STR0009
	ElseIf VPE->VPE_FASE == "XX"
		cabec1 += " - "+STR0007+Transform(VPE->VPE_DATFIN,"@D")+" "+Transform(VPE->VPE_HORFIN,"@R 99:99")+" "+STR0008
	EndIf
	nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15) + 1
	DbSelectArea("VPG")
	cQuery := "SELECT VPG.VPG_QTDEST , VPG.VPG_DIVERG , VPG.VPG_CUSTO , VPG.VPG_GRUITE , VPG.VPG_CODITE , VPG.VPG_ALMOX , VPG.VPG_LOCAC , SB1.B1_DESC "
	cQuery += "  FROM "+RetSqlName("VPG")+" VPG "
	cQuery += "  JOIN "+RetSqlName("SB1")+" SB1 ON ( SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_GRUPO = VPG.VPG_GRUITE AND SB1.B1_CODITE = VPG.VPG_CODITE AND SB1.D_E_L_E_T_=' ' ) "
	cQuery += " WHERE VPG.VPG_FILIAL='"+xFilial("VPG")+"' AND VPG.VPG_CODIGO = '"+MV_PAR01+"' "
	cQuery += "   AND VPG.D_E_L_E_T_=' ' "
	If MV_PAR02 == 1 //Grupo e Código
		cQuery += " ORDER BY VPG.VPG_GRUITE , VPG.VPG_CODITE "
	ElseIf MV_PAR02 == 2 //Locação
		cQuery += " ORDER BY VPG.VPG_LOCAC , VPG.VPG_GRUITE , VPG.VPG_CODITE "
	ElseIf MV_PAR02 == 3 //Descrição
		cQuery += " ORDER BY SB1.B1_DESC , VPG.VPG_GRUITE , VPG.VPG_CODITE , VPG.VPG_LOCAC"
	EndIf
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVPG, .F., .T. ) 
	While !( cQAlVPG )->( Eof() )
		If nLin >= 60
			nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15) + 1
		EndIf
		ni++
		nQtd += ( cQAlVPG )->VPG_QTDEST
		nDig += ( cQAlVPG )->VPG_QTDEST+( cQAlVPG )->VPG_DIVERG
		If ( cQAlVPG )->VPG_DIVERG > 0
			nPIte++
			nPDiv += ( cQAlVPG )->VPG_DIVERG
			nPCus += ( cQAlVPG )->VPG_CUSTO
		Else
			nNIte++
			nNDiv += ( cQAlVPG )->VPG_DIVERG
			nNCus += ( cQAlVPG )->VPG_CUSTO
		EndIf
		@nLin++, 00 PSAY strzero(ni,6)+" "+( cQAlVPG )->VPG_GRUITE+" "+( cQAlVPG )->VPG_CODITE+" "+( cQAlVPG )->VPG_ALMOX+" "+( cQAlVPG )->VPG_LOCAC+" "+left(( cQAlVPG )->B1_DESC,20)+Transform(( cQAlVPG )->VPG_QTDEST+( cQAlVPG )->VPG_DIVERG,"@E 99,999,999.99")+Transform(( cQAlVPG )->VPG_QTDEST,"@E 99,999,999.99")+Transform(( cQAlVPG )->VPG_DIVERG,"@E 99,999,999.99")+Transform(( cQAlVPG )->VPG_CUSTO,"@E 9,999,999.9999")
		( cQAlVPG )-> (DbSkip())
	EndDo
	( cQAlVPG )-> (DbCloseArea())
	DbSelectArea("VPG")
	@nLin++, 00 PSAY repl("-",132)
	@nLin++, 00 PSAY space(75)+STR0019
	@nLin++, 00 PSAY left(STR0010+space(30),30)+left("("+Transform(nPIte,"@E 999,999")+" "+STR0013+" )"+space(70),70)+Transform(nPDiv,"@E 99,999,999.99")+"  "+Transform(nPCus,"@E 999,999,999.9999")
	@nLin++, 00 PSAY left(STR0011+space(30),30)+left("("+Transform(nNIte,"@E 999,999")+" "+STR0013+" )"+space(70),70)+Transform(nNDiv,"@E 99,999,999.99")+"  "+Transform(nNCus,"@E 999,999,999.9999")
	@nLin++, 00 PSAY left(STR0012+space(30),30)+left("("+Transform(nPIte+nNIte,"@E 999,999")+" "+STR0013+" )"+space(44),44)+Transform(nDig,"@E 99,999,999.99")+Transform(nQtd,"@E 99,999,999.99")+Transform(nPDiv+ABS(nNDiv),"@E 99,999,999.99")+"  "+Transform(nPCus+nNCus,"@E 999,999,999.9999")
	@nLin++, 00 PSAY repl("-",132)
EndIf
Set Printer to
Set Device  to Screen
Return
