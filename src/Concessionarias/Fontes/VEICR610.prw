/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 0      º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "Veicr610.ch"
#Include "fileio.ch"
#Include "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ VEICR610 ³ Autor ³  Fabio                ³ Data ³ 19/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Seguro por Vigencia                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ (Veiculos)                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR610
Local oReport
Local aArea := GetArea()
Private cImp := ""
Private lA1_IBGE := If(SA1->(FieldPos("A1_IBGE"))>0,.t.,.f.)
If FindFunction("TRepInUse") .And. TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	FS_VCR610R3()
EndIf
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef³ Autor ³ Andre Luis Almeida    ³ Data ³ 04/07/06 ³±±
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
Local oCell

oReport := TReport():New("VEICR610",STR0001,"VCR610",{|oReport| U_VCR610IMP(oReport)})

oSection1 := TRSection():New(oReport,OemToAnsi(STR0020),{})
TRCell():New(oSection1,"",,"","@!",132,,{|| cImp })

oSection2 := TRSection():New(oReport,OemToAnsi(STR0021),{"VC6","SA1","VV2","VC8","VC9"})
TRCell():New(oSection2,"VC6_CODCLI","VC6",)
TRCell():New(oSection2,"VC6_LOJA"  ,"VC6",)
TRCell():New(oSection2,"A1_NREDUZ" ,"SA1",)
TRCell():New(oSection2,"A1_TEL"    ,"SA1",)
TRCell():New(oSection2,"VC6_CODMAR","VC6",)
TRCell():New(oSection2,"VV2_DESMOD","VV2",)
TRCell():New(oSection2,"VC6_QTDVEI","VC6",,"@E 999")
TRCell():New(oSection2,"VC8_DESSEG","VC8",,,14)
TRCell():New(oSection2,"VC6_PERBON","VC6",,"@E 999.9999")
TRCell():New(oSection2,"VC9_DESSEG","VC9",)

if lA1_IBGE
	oSection3 := TRSection():New(oReport,OemToAnsi(STR0022 ),{"VC6","VAM"})
	TRCell():New(oSection3,"",,"","@!",10,,{|| space(10) })
	TRCell():New(oSection3,"VAM_DESCID","VAM","",,25)
	TRCell():New(oSection3,"VAM_ESTADO","VAM","",,2)
	TRCell():New(oSection3,"VC6_VAL_DM","VC6","","@E 9999,999,999.99",15)
	TRCell():New(oSection3,"",,"","@!",len(STR0016),,{|| STR0016 })
	TRCell():New(oSection3,"VC6_VAL_DP","VC6","","@E 9999,999,999.99",15)
	TRCell():New(oSection3,"",,"","@!",len(STR0017),,{|| STR0017 })
	TRCell():New(oSection3,"VC6_VALCAS","VC6","","@E 9999,999,999.99",15)
	TRCell():New(oSection3,"",,"","@!",len(STR0018),,{|| STR0018 })
	TRCell():New(oSection3,"",,"","@!",len(STR0019),,{|| STR0019 })
	TRCell():New(oSection3,"VC6_DATVIG","VC6","","@D")
	TRCell():New(oSection3,"",,"","@!",len(STR0004),,{|| STR0004 })
	TRCell():New(oSection3,"VC6_VENSEG","VC6","","@D")
else
	oSection3 := TRSection():New(oReport,OemToAnsi(STR0022 ),{"VC6","SA1"})
	TRCell():New(oSection3,"",,"","@!",10,,{|| space(10) })
	TRCell():New(oSection3,"A1_MUN","SA1","",,25)
	TRCell():New(oSection3,"A1_EST","SA1","",,2)
	TRCell():New(oSection3,"VC6_VAL_DM","VC6","","@E 9999,999,999.99",15)
	TRCell():New(oSection3,"",,"","@!",len(STR0016),,{|| STR0016 })
	TRCell():New(oSection3,"VC6_VAL_DP","VC6","","@E 9999,999,999.99",15)
	TRCell():New(oSection3,"",,"","@!",len(STR0017),,{|| STR0017 })
	TRCell():New(oSection3,"VC6_VALCAS","VC6","","@E 9999,999,999.99",15)
	TRCell():New(oSection3,"",,"","@!",len(STR0018),,{|| STR0018 })
	TRCell():New(oSection3,"",,"","@!",len(STR0019),,{|| STR0019 })
	TRCell():New(oSection3,"VC6_DATVIG","VC6","","@D")
	TRCell():New(oSection3,"",,"","@!",len(STR0004),,{|| STR0004 })
	TRCell():New(oSection3,"VC6_VENSEG","VC6","","@D")
endif
TRPosition():New(oSection2,"SA1",1,{|| xFilial()+VC6->VC6_CODCLI+VC6->VC6_LOJA })
TRPosition():New(oSection2,"VV2",1,{|| xFilial()+VC6->VC6_CODMAR+VC6->VC6_MODVEI })
TRPosition():New(oSection2,"VC8",1,{|| xFilial()+VC6->VC6_TIPSEG })
TRPosition():New(oSection2,"VC9",1,{|| xFilial()+VC6->VC6_SEGURA })

if lA1_IBGE
	TRPosition():New(oSection3,"VAM",1,{|| xFilial()+SA1->A1_IBGE })
endif

Return oReport
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VCR610IMP³ Autor ³ Andre Luis Almeida    ³ Data ³ 04/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Executa a impressao do relatorio do TReport                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Oficina                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VCR610IMP(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
PERGUNTE("VCR610",.F.)
DbSelectArea("VC6")
DbSetOrder(3)
DbSeek(xFilial("VC6"))
oReport:SetMeter(RecCount())
oSection1:Init()
oSection2:Init()
oSection3:Init()
cImp := STR0005+" "+Transform(MV_PAR01,"@D")+STR0004+Transform(MV_PAR02,"@D")
oSection1:PrintLine()
oReport:SkipLine()
While !Eof() .and. !oReport:Cancel() .and. VC6->VC6_FILIAL == xFilial("VC6")
	oReport:IncMeter()
	If VC6->VC6_VENSEG >= MV_PAR01 .and. VC6->VC6_VENSEG <= MV_PAR02
		oSection2:PrintLine()
		oSection3:PrintLine()
		oReport:SkipLine()
   EndIf
   DbSelectArea("VC6")
   DbSkip()
EndDo
oSection1:Finish()
oSection2:Finish()
oSection3:Finish()
Return Nil


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function FS_VCR610R3()
PRIVATE aReturn  := { OemToAnsi(STR0002), 1,OemToAnsi(STR0003), 2, 2, 2,,1 }
Private titulo,wnrel,tamanho:="P"
wnRel := "VEICR610"
cAlias := "VC6"
cNomRel:= "VEICR610"
cPerg := "VCR610"
cTitulo:= STR0001
cDesc1 := STR0001
cDesc2 := cDesc3 := ""
lHabil := .f.
wnRel:=cTamanho:= "P"
NomeRel := SetPrint(cAlias,cNomRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lHabil,,,cTamanho)
If nlastkey == 27
   Return
EndIf
PERGUNTE(cPerg,.F.)
SetDefault(aReturn,cAlias)
RptStatus({|lEnd| U_FS_r610(@lEnd,wnRel,'SA1')},Titulo)
Return
/////////////////////////////////
User Function FS_r610()
Set Printer to &NomeRel
Set Printer On
Set device to Printer
cbTxt   := Space(10)
cbCont  := 0
cString := "VC6"
Li      := 80
m_Pag   := 1
wnRel   := "VEICR610"
nLin    := 1
cTitulo := STR0001
cabec1  := STR0005+" "+Dtoc(MV_PAR01)+STR0004+Dtoc(MV_PAR02)
cabec2  := STR0006+" "+STR0007+Space(17)+STR0009+Space(12)+STR0010+" "+STR0011+Space(15)+STR0012+" "+STR0013+Space(4)+STR0014+" "+STR0015
nomeprog:="VEICR610"
tamanho :="M"
nCaracter:=15
DbSelectArea("VC6")
DbSetOrder(3)
DbGoTop()
SetRegua(RecCount())
While !Eof()
   IncRegua()
   If VC6->VC6_VENSEG >= MV_PAR01 .and. VC6->VC6_VENSEG <= MV_PAR02
	   If nLin == 1
	      nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
   	EndIf
	   SA1->(DbSeek(xFilial("SA1")+VC6->VC6_CODCLI))
	   if lA1_IBGE
	      FG_Seek("VAM","SA1->A1_IBGE",1,.f.) // CIDADE
	   endif
   	@ nLin++,00 PSAY VC6->VC6_CODCLI+"  "+SA1->A1_NREDUZ+" "+SA1->A1_TEL+" "+VC6->VC6_CODMAR+"   "+Posicione("VV2",1,xFilial("VV2")+VC6->VC6_CODMAR+VC6->VC6_MODVEI,"VV2_DESMOD")+" "+Str(VC6->VC6_QTDVEI,3)+" "+Left(Posicione("VC8",1,xFilial("VC8")+VC6->VC6_TIPSEG,"VC8_DESSEG"),14)+" "+Transform(VC6->VC6_PERBON,"@E 999.9999")+" "+Posicione("VC9",1,xFilial("VC9")+VC6->VC6_SEGURA,"VC9_DESSEG")
	if lA1-IBGE
	   @ nLin++,10 PSAY VAM->VAM_DESCID+" "+VAM->VAM_ESTADO+" "+Transform(VC6->VC6_VAL_DM,"@E 99999,999,999.99")+STR0016+" "+Transform(VC6->VC6_VAL_DP,"@E 99999,999,999.99")+STR0017+" "+Transform(VC6->VC6_VALCAS,"@E 99999,999,999.99")+STR0018+" "+STR0019+" "+Dtoc(VC6->VC6_DATVIG) + STR0004 + Dtoc(VC6->VC6_VENSEG)
	else
		   @ nLin++,10 PSAY SA1->A1_MUN+" "+SA1->A1_EST+" "+Transform(VC6->VC6_VAL_DM,"@E 99999,999,999.99")+STR0016+" "+Transform(VC6->VC6_VAL_DP,"@E 99999,999,999.99")+STR0017+" "+Transform(VC6->VC6_VALCAS,"@E 99999,999,999.99")+STR0018+" "+STR0019+" "+Dtoc(VC6->VC6_DATVIG) + STR0004 + Dtoc(VC6->VC6_VENSEG)
	endif
   	If nLin > 63
	      nLin := 1
   	EndIf
   EndIf
   DbSelectArea("VC6")
   DbSkip()
EndDo
Eject
Set Printer to
Set device to Screen
MS_FLUSH()
OurSpool(NomeRel)
Return
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³OA110OK     ³ Autor ³  Ednilson           ³ Data ³ 24/10/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Funcao para o TudoOk                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_VALR610(cPar01,cPar02)
Local lRet := .t.
If cPar01 > cPar02
   Help(" ",1,"DATA2MOATU")
   lRet := .f.
EndIf
Return lRet