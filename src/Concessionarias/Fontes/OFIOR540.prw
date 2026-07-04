/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.Ch"
#Include "OFIOR540.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIOR540 ³ Autor ³ Andre Luis Almeida    ³ Data ³ 04.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao das Devolucoes de Requisicoes                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function OFIOR540()
Local oReport
Local aArea := GetArea()
Private cImp := ""
If FindFunction("TRepInUse") .And. TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	FS_OFR540R3()
EndIf
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef³ Autor ³ Andre Luis Almeida    ³ Data ³ 14/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio usando o TReport                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4
Local oCell
oReport := TReport():New("OFIOR540",STR0001,"OFR540",{|oReport| U_OFR540IMP(oReport)})

oSection1 := TRSection():New(oReport,OemToAnsi(STR0007),{"VO2"})  //Data
TRCell():New(oSection1,"VO2_DATREQ","VO2",,"@D",8)
                    
oSection2 := TRSection():New(oReport,OemToAnsi(STR0008),{})  //Separacao
TRCell():New(oSection2,"",,"","@!",80,,{|| repl("*",80) })

oSection3 := TRSection():New(oReport,OemToAnsi(STR0009),{"VO3","SB1"}) //Item
TRCell():New(oSection3,"",,"","@!",4,,{|| space(4) })
TRCell():New(oSection3,"VO3_GRUITE","VO3",,,4)
TRCell():New(oSection3,"VO3_CODITE","VO3",,,27)
TRCell():New(oSection3,"B1_DESC"   ,"SB1",,,24) 
TRCell():New(oSection3,"VO3_QTDREQ","VO3",,"@E 9999,999",8)
TRCell():New(oSection3,"",,"","@E 99999,999.99",12,,{|| ( VO3->VO3_VALPEC * VO3->VO3_QTDREQ ) })

oSection4 := TRSection():New(oReport,OemToAnsi(STR0010),{}) //Detalhes
TRCell():New(oSection4,"",,"","@!",80,,{|| cImp })

TRPosition():New(oSection3,"SB1",7,{|| xFilial()+VO3->VO3_GRUITE+VO3->VO3_CODITE })

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFR540IMP³ Autor ³ Andre Luis Almeida    ³ Data ³ 14/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Executa a impressao do relatorio do TReport                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Oficina                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFR540IMP(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local oSection4 := oReport:Section(4)
Local dDataAux := ctod("")
Local cOSerAux := "INICIAL"   
Local nCountOS := 0
PERGUNTE("OFR540",.F.)
DbSelectArea("VO2")
DbSetOrder(3)
DbSeek(xFilial("VO2")+Dtos(mv_par01),.T.)
oReport:SetMeter(RecCount())
oSection1:Init()
oSection2:Init()
oSection3:Init()
oSection4:Init()
While !Eof() .and. !oReport:Cancel() .and. VO2->VO2_FILIAL == xFilial("VO2") .and. ( VO2->VO2_DATREQ <= mv_par02 )
	oReport:IncMeter()
	If ( VO2->VO2_DEVOLU == "0" ) // Devolucao
		DbSelectArea("VO3")
		DbSetOrder(1)
		DbSeek(xFilial("VO3") + VO2->VO2_NOSNUM )
		While !Eof() .and. VO3->VO3_NOSNUM = VO2->VO2_NOSNUM
			If dDataAux <> VO2->VO2_DATREQ
				dDataAux := VO2->VO2_DATREQ
				cOSerAux := "INICIAL"
				oReport:SkipLine()
				oSection2:PrintLine()
				oSection1:PrintLine()
				oSection2:PrintLine()
			EndIf
			If cOSerAux <> VO2->VO2_NUMOSV
				cOSerAux := VO2->VO2_NUMOSV
				nCountOS++
				oReport:SkipLine()
				cImp := "."+left( STR0004 + VO2->VO2_NUMOSV + " " + repl("-",78) , 78 )
				oSection4:PrintLine()
			EndIf
			oSection3:PrintLine()
			DbSelectArea("VAI")
			DbSetOrder(1)
			DbSeek(xFilial("VAI") + VO2->VO2_FUNREQ )
			If !Empty(VO2->VO2_MOTDEV)
				cImp := "."+space(6)+VO2->VO2_MOTDEV+" "+If(Empty(VO3->VO3_DATCAN),left(VAI->VAI_NOMUSU,11),"") // -> Produtivo Requisitante
				oSection4:PrintLine()
			EndIf                     
			If !Empty(VO3->VO3_DATCAN)
				cImp := "."+space(6)+left(STR0005+Transform(VO3->VO3_DATCAN,"@D")+space(40),60) + " " + left(VAI->VAI_NOMUSU,11) // -> Produtivo Requisitante
				oSection4:PrintLine()
         EndIf
			DbSelectArea("VO3")
			DbSkip()
		EndDo
	EndIf
	DbSelectArea("VO2")
	DbSkip()
EndDo
oSection2:PrintLine()
cImp := "."+substr(STR0006,2)+Transform(nCountOS++,"@E 9999999,999")
oSection4:PrintLine()
oSection2:PrintLine()
oSection1:Finish()
oSection2:Finish()
oSection3:Finish()
oSection4:Finish()
Return Nil

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function FS_OFR540R3()
Private cDesc1 := STR0001
Private cDesc2 := ""
Private cDesc3 := ""
Private tamanho:= "P"
Private limite := 80
Private cString:= "VO2"
Private titulo := STR0001
Private cabec1 := ""
Private cabec2 := ""
Private cNomeArq
Private aReturn := {STR0002,1,STR0003,1,2,1,"",1}
Private nomeprog:="OFIOR540"
Private aLinha  := { },nLastKey := 0
Private cPerg   :="OFR540"
wnrel := nomeprog
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)
If nLastKey == 27
	Return
EndIf
Pergunte(cPerg,.F.)
SetDefault(aReturn,cString)
RptStatus( { |lEnd| FS_IMPOFR540(@lEnd,wnrel,cString) } , Titulo )
If aReturn[5] == 1
	OurSpool( wnrel )
EndIf
MS_Flush()
Return
/////////////////////////////////////////
Static Function FS_IMPOFR540()
cbtxt    := SPACE(10)
cbcont   := 0
nLin     := 0
m_pag    := 1
dDataAux := ctod("")
cOSerAux := "NAO EXISTE"   
nCountOS := 0
Set Printer to &wnrel
Set Printer On
Set Device  to Printer
nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) + 1
DbSelectArea("VO2")
DbSetOrder(3)
DbSeek(xFilial("VO2")+Dtos(mv_par01),.T.)
SetRegua( RecCount() )
While !Eof() .and. ( VO2->VO2_FILIAL == xFilial("VO2") ) .and. ( VO2->VO2_DATREQ <= mv_par02 )
	IncRegua()
	If ( VO2->VO2_DEVOLU == "0" ) // Devolucao
		DbSelectArea("VO3")
		DbSetOrder(1)
		DbSeek(xFilial("VO3") + VO2->VO2_NOSNUM )
		While !Eof() .and. VO3->VO3_NOSNUM = VO2->VO2_NOSNUM
			If nLin >= 55
				nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) + 1
			EndIf
			DbSelectArea("SB1")
			DbSetOrder(7)
			DbSeek( xFilial() + VO3->VO3_GRUITE + VO3->VO3_CODITE )
			If dDataAux <> VO2->VO2_DATREQ
				dDataAux := VO2->VO2_DATREQ
				cOSerAux := "NAO EXISTE"
				nLin++
				@nLin++, 00 PSAY repl("*",80)
				@nLin++, 01 PSAY Transform(VO2->VO2_DATREQ,"@D")
				@nLin++, 00 PSAY repl("*",80)
			EndIf
			If cOSerAux <> VO2->VO2_NUMOSV
				cOSerAux := VO2->VO2_NUMOSV
				nCountOS++
				nLin++
				@nLin++, 01 PSAY left( STR0004 + VO2->VO2_NUMOSV + " " + repl("-",78) , 78 )
			EndIf
			If nLin >= 60
				nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) + 1
			EndIf
			DbSelectArea("VAI")
			DbSetOrder(1)
			DbSeek(xFilial("VAI") + VO2->VO2_FUNREQ )
			@nLin++, 04 PSAY left( VO3->VO3_GRUITE + " " + VO3->VO3_CODITE + " " + SB1->B1_DESC + space(50) , 55 ) + Transform(VO3->VO3_QTDREQ,"@E 9999,999") + Transform( ( VO3->VO3_VALPEC * VO3->VO3_QTDREQ ) ,"@E 99999,999.99")
			If !Empty(VO2->VO2_MOTDEV)
				@nLin++, 07 PSAY VO2->VO2_MOTDEV + " " + If(Empty(VO3->VO3_DATCAN),left(VAI->VAI_NOMUSU,11),"") // -> Produtivo Requisitante
			EndIf                     
			If !Empty(VO3->VO3_DATCAN)
				@nLin++, 07 PSAY left(STR0005+Transform(VO3->VO3_DATCAN,"@D")+space(40),60) + " " + left(VAI->VAI_NOMUSU,11) // -> Produtivo Requisitante
         EndIf
			DbSelectArea("VO3")
			DbSkip()
		EndDo
	EndIf
	DbSelectArea("VO2")
	DbSkip()
EndDo
If nLin >= 60
	nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) + 1
EndIf
nLin++
@ nLin++,00 pSay repl("=",80)
@nLin++, 00 PSAY STR0006+Transform(nCountOS++,"@E 9999999,999")
@ nLin++,00 pSay repl("=",80)
Set Printer to
Set Device  to Screen
Return
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
