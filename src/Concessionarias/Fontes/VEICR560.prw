/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 7      º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "PROTHEUS.CH"              
#Include "VEICR560.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VEICR560 ³ Autor ³  Fabio                ³ Data ³ 19/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Frota por Regiao / Cidade-UF                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ (Veiculos)                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR560()
Local oReport
Local aArea := GetArea()
Private cImp := ""
Private lA1_IBGE := IIf(SA1->(FieldPos("A1_IBGE"))>0,.t.,.f.)
if !lA1_IBGE
	MsgInfo(STR0011,STR0012)
	return
endif
If FindFunction("TRepInUse") .and. TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	FS_V560R3()
EndIf
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef³ Autor ³ Andre Luis Almeida    ³ Data ³ 29/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio usando o TReport                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oCell

oReport := TReport():New("VEICR560",STR0001,"VCR560",{|oReport| U_VCR560IMP(oReport)})

oSection1 := TRSection():New(oReport,OemToAnsi(STR0010),{"VC3","SA1","VAM","VV2"})
TRCell():New(oSection1,"",,"","@!",132,,{|| cImp })

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VCR560IMP³ Autor ³ Andre Luis Almeida    ³ Data ³ 29/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Executa a impressao do relatorio do TReport                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Oficina                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VCR560IMP(oReport)
Local oSection1 := oReport:Section(1)
Local cCodCli   := "INICIAL"
Local cIBGE     := "INICIAL"
Local aFrota    := {}
Local i := 0
Local nQtdFro   := 0
Local nTotal    := 0
Local nTotGeral := 0
Local cDesc     := ""
PERGUNTE("VCR560",.F.)
DbSelectArea("VC3")
DbSetOrder(1)
DbSeek(xFilial("VC3"))
oReport:SetMeter(RecCount()*2)
oSection1:Init()
While !Eof() .and. !oReport:Cancel() .and. xFilial("VC3") == VC3->VC3_FILIAL
	oReport:IncMeter()
	If cCodCli # VC3->VC3_CODCLI+VC3->VC3_LOJA
		cCodCli := VC3->VC3_CODCLI+VC3->VC3_LOJA
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial("SA1")+VC3->VC3_CODCLI+VC3->VC3_LOJA)
		If cIBGE # SA1->A1_IBGE
			cIBGE := SA1->A1_IBGE
			DbSelectArea("VAM")
			DbSetOrder(1)
			DbSeek(xFilial("VAM")+SA1->A1_IBGE)
		EndIf
	EndIf
	If !Empty(MV_PAR01) .and. left(VAM->VAM_REGIAO,3) # left(MV_PAR01,3)
		DbSelectArea("VC3")
		DbSkip()
		Loop
	EndIf
	If !Empty(MV_PAR03+MV_PAR04) .and. ( (left(VAM->VAM_DESCID+space(40),40)+left(VAM->VAM_ESTADO,2)) # (left(MV_PAR03+space(40),40)+left(MV_PAR04,2)) )
		DbSelectArea("VC3")
		DbSkip()
		Loop
	EndIf
	DbSelectArea("VV2")
	DbSetOrder(1)
	If DbSeek(xFilial("VV2")+VC3->VC3_CODMAR+VC3->VC3_MODVEI)
		cDesc := left(VV2->VV2_DESMOD+space(30),30)
	Else
		cDesc := left(VC3->VC3_MODVEI+space(30),30)
	EndIf
	Aadd(aFrota,{left(VAM->VAM_DESCID,14)+"-"+VAM->VAM_ESTADO,VC3->VC3_CODMAR,cDesc,VC3->VC3_FABMOD,VC3->VC3_QTDFRO})
	DbSelectArea("VC3")
	DbSkip()
EndDo
If len(aFrota) > 0
	Asort(aFrota,1,,{|x,y|x[1]+x[2]+x[3]+strzero(100000000-val(x[4]),8) < y[1]+y[2]+y[3]+strzero(100000000-val(y[4]),8)})
	cQuebra    := aFrota[1,1]+aFrota[1,2]+aFrota[1,3]+aFrota[1,4]
	cMunicipio := aFrota[1,1]
	lMunicipio := .t.
	If !Empty(MV_PAR01)
		cImp := STR0002+" "+MV_PAR01+" "+MV_PAR02 + IIf(!Empty(MV_PAR03),STR0003+" "+Alltrim(MV_PAR03)+"-"+MV_PAR04,"") //"Regiao" - "Cidade"
		oSection1:PrintLine()
	EndIf
	cImp := left(STR0003+Space(19),19)+STR0004+Space(1)+STR0005+Space(23)+STR0006+Space(04)+STR0007 //"Municipio"###"Marca"###"Modelo"###"Fabricacao"###"Quantidade"
	oSection1:PrintLine()
	oReport:SkipLine()
	For i:=1 to Len(aFrota)
		oReport:IncMeter()
		If aFrota[i,1]+aFrota[i,2]+aFrota[i,3]+aFrota[i,4] # cQuebra
			cImp := "."+IIf(lMunicipio,left(aFrota[i-1,1],17),Space(17))+" "+aFrota[i-1,2]+" "+aFrota[i-1,3]+" "+Transform(aFrota[i-1,4],"@R 9999/9999")+"   "+Transform(nQtdFro,"@E 999,999,999")
			oSection1:PrintLine()
			nQtdFro := 0
			cQuebra    := aFrota[i,1]+aFrota[i,2]+aFrota[i,3]+aFrota[i,4]
			lMunicipio := .f.
			If aFrota[i,1] # cMunicipio
				cImp := "."+space(59)+STR0008+" "+Transform(nTotal,"@E 999,999,999") //"Total"
				oSection1:PrintLine()
				oReport:SkipLine()
				cMunicipio := aFrota[i,1]
				lMunicipio := .t.
				nTotal := 0
			EndIf
		EndIf
		nQtdFro   += aFrota[i,5]
		nTotal    += aFrota[i,5]
		nTotGeral += aFrota[i,5]
	Next
	cImp := "."+IIf(lMunicipio,left(aFrota[i-1,1],17),Space(17))+" "+aFrota[i-1,2]+" "+aFrota[i-1,3]+" "+Transform(aFrota[i-1,4],"@R 9999/9999")+"   "+Transform(nQtdFro,"@E 999,999,999")
	oSection1:PrintLine()
	nQtdFro := 0
	cImp := "."+space(59)+STR0008+" "+Transform(nTotal,"@E 999,999,999") //"Total"
	oSection1:PrintLine()
	oReport:SkipLine()
	cImp := "."+space(53)+STR0009+" "+Transform(nTotGeral,"@E 999,999,999") //"Total Geral"
	oSection1:PrintLine()
EndIf
oSection1:Finish()
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_V560R3³ Autor ³  Fabio                ³ Data ³ 19/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao R3                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_V560R3()

Local i := 0
Private aReturn  := { OemToAnsi(STR0001), 1,OemToAnsi(STR0002), 2, 2, 2,,1 },aFrota:={} //"Frota"###"Regiao"

cAlias  := "VC3"
cNomRel := "VEICR560"
cPerg   := "VCR560"
cTitulo := STR0001 //"Frota"
cDesc1  := STR0001 //"Frota"
cDesc2  := cDesc3 := ""
lHabil  := .f.
wnRel   := cTamanho:= "P"
NomeRel := SetPrint(cAlias,cNomRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lHabil,,,cTamanho)

If nlastkey == 27
	Return
EndIf

Pergunte(cPerg,.f.)

SetDefault(aReturn,cAlias)

Set Printer to &NomeRel
Set Printer On
Set device to Printer

cbTxt    := Space(10)
cbCont   := 0
cString  := "VC1"
Li       := 80
m_Pag    := 1
wnRel    := "VEICR560"
nLin     := 1
cTitulo  := STR0001 //"Frota"
cabec1   := STR0002+" "+MV_PAR01+" "+MV_PAR02 + IIf(!Empty(MV_PAR03),STR0003+" "+Alltrim(MV_PAR03)+"-"+MV_PAR04,"") //"Regiao" - "Cidade"
cabec2   := STR0003+Space(7)+STR0004+Space(1)+STR0005+Space(23)+STR0006+Space(04)+STR0007 //"Municipio"###"Marca"###"Modelo"###"Fabricacao"###"Quantidade"
nomeprog := "VEICR560"
tamanho  := "P"
nCaracter:= 15
nTotal   := 0
cCodCli  := ""
cIBGE    := ""
nTotGeral:= 0
aFrota   := {}

DbSelectArea("VC3")
DbSetOrder(1)
DbSeek(xFilial("VC3"))
Do While !Eof()
	If cCodCli # VC3->VC3_CODCLI+VC3->VC3_LOJA
		cCodCli := VC3->VC3_CODCLI+VC3->VC3_LOJA
		SA1->(DbSeek(xFilial("SA1")+VC3->VC3_CODCLI+VC3->VC3_LOJA))
		If cIBGE # SA1->A1_IBGE
			cIBGE := SA1->A1_IBGE
			FG_Seek("VAM","SA1->A1_IBGE",1,.f.) // CIDADE
			If !Empty(mv_par01) .and. VAM->VAM_REGIAO # mv_par01
				DbSelectArea("VC3")
				DbSkip()
				Loop
			EndIf
			If !Empty(mv_par03+mv_par04) .and. ( (VAM->VAM_DESCID+VAM->VAM_ESTADO) # (mv_par03+mv_par04) )
				DbSelectArea("VC3")
				DbSkip()
				Loop
			EndIf
		EndIf
	EndIf
	DbSelectArea("VV2")
	DbSetOrder(1)
	If DbSeek(xFilial("VV2")+VC3->VC3_CODMAR+VC3->VC3_MODVEI)
		cDesc := left(VV2->VV2_DESMOD+space(30),30)
	Else
		cDesc := left(VC3->VC3_MODVEI+space(30),30)
	EndIf
	Aadd(aFrota,{left(VAM->VAM_DESCID,15)+"-"+VAM->VAM_ESTADO,VC3->VC3_CODMAR,cDesc,VC3->VC3_FABMOD,VC3->VC3_QTDFRO})
	DbSelectArea("VC3")
	DbSkip()
EndDo

If len(aFrota) == 0
	Set Printer to
	Set device to Screen
	MS_FLUSH()
	OurSpool( NomeRel )
	Return .t.
EndIf

Asort(aFrota,1,,{|x,y|x[1]+x[2]+x[3]+x[4] > y[1]+y[2]+y[3]+y[4]})

cQuebra   := aFrota[1,1]+aFrota[1,2]+aFrota[1,3]+aFrota[1,4]
cMunicipio:=aFrota[1,1]
nTotal    := nQtdFro := 0
lMunicipio:=.t.

For i:=1 to Len(aFrota)
	If nLin == 1
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	EndIf
	If aFrota[i,1]+aFrota[i,2]+aFrota[i,3]+aFrota[i,4] # cQuebra
		@ nLin++,0 PSAY IIf(lMunicipio,aFrota[i-1,1],Space(18))+" "+aFrota[i-1,2]+" "+aFrota[i-1,3]+" "+Transform(aFrota[i-1,4],"@R 9999/9999")+"   "+Transform(nQtdFro,"@E 999,999,999")
		cQuebra   := aFrota[i,1]+aFrota[i,2]+aFrota[i,3]+aFrota[i,4]
		lMunicipio:=.f.
		If aFrota[i,1] # cMunicipio
			@ nLin++,65 PSAY Repl("-",12)
			@ nLin++,60 PSAY STR0008+" "+Transform(nTotal,"@E 999,999,999") //"Total"
			@ nLin++,65 PSAY Repl("-",12)
			@ nLin+=2
			cMunicipio:=aFrota[i,1]
			lMunicipio:=.t.
			nTotal := 0
		EndIf
	EndIf
	nQtdFro   := aFrota[i,5]
	nTotal    := nTotal+nQtdFro
	nTotGeral := nTotGeral+nQtdFro
	If nLin > 63
		nLin := 1
	EndIf
Next

@ nLin++,00 PSAY aFrota[i-1,1]+" "+aFrota[i-1,2]+" "+aFrota[i-1,3]+" "+Transform(aFrota[i-1,4],"@R 9999/9999")+"   "+Transform(nQtdFro,"@E 999,999,999")
@ nLin++,65 PSAY Repl("-",12)
@ nLin++,60 PSAY STR0008+" "+Transform(nTotal,"@E 999,999,999") //"Total"
@ nLin++,65 PSAY Repl("-",12)
@ nLin++,54 PSAY STR0009+" "+Transform(nTotGeral,"@E 999,999,999") //"Total Geral"

Eject
Set Printer to
Set device to Screen
MS_FLUSH()
If aReturn[5] == 1
	OurSpool( NomeRel )
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_VCR560³ Autor ³  Fabio                ³ Data ³ 19/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Valida VCB ( Regiao )                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_VCR560(nOpcx)
local lRet := .t.
Default nOpcx:=1
If nOpcx == 1
	If !Empty(mv_par01)
		if !FG_VALIDA(,"VCBTMV_PAR01*","MV_PAR02 := VCB->VCB_DESREG")
			lret := .f.
		Endif
	Endif
Endif
Return(lRet)