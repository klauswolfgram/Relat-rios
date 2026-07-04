/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 05     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#Include "Veicr530.ch"
#Include "fileio.ch"
#Include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ VEICR530 ³ Autor ³  Fabio                ³ Data ³ 05/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Frota do Cliente                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ (Veiculos)                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR530()
Local aArea     := GetArea()
Local aParamBox := {}
Private aRetSX1 := {}
Private lNewVend    := ( VCF->(FieldPos("VCF_VENVEU")) > 0 ) // Possui campos novos Vendedores
Private lA1_SEGMER1 := ( SA1->(FieldPos("A1_SEGMER1")) > 0 )
aAdd(aParamBox,{1,STR0002,Space(TamSX3("VC3_CODCLI")[1]),"@!","","SA1","",40,.f.}) 								// 1
aAdd(aParamBox,{1,Alltrim(RetTitle("VC3_LOJA")),Space(TamSX3("VC3_LOJA")[1]),"@!","","","",20,.f.})				// 2
aAdd(aParamBox,{2,STR0006,"1",{"1="+STR0003,"2="+STR0004},60,"",.F.})											// 3
aAdd(aParamBox,{1,Alltrim(RetTitle("VCF_VENPEC")),Space(TamSX3("VCF_VENPEC")[1]),"@!","","SA3","",40,.f.}) 		// 4
aAdd(aParamBox,{1,Alltrim(RetTitle("VCF_VENSRV")),Space(TamSX3("VCF_VENSRV")[1]),"@!","","SA3","",40,.f.}) 		// 5
aAdd(aParamBox,{1,Alltrim(RetTitle("VCF_VENVEI")),Space(TamSX3("VCF_VENVEI")[1]),"@!","","SA3","",40,.f.}) 		// 6
If lNewVend // Vendedores: Usados / Pneus / Outros
	aAdd(aParamBox,{1,Alltrim(RetTitle("VCF_VENVEU")),Space(TamSX3("VCF_VENVEU")[1]),"@!","","SA3","",40,.f.}) 	// 7
	aAdd(aParamBox,{1,Alltrim(RetTitle("VCF_VENPNE")),Space(TamSX3("VCF_VENPNE")[1]),"@!","","SA3","",40,.f.}) 	// 8
	aAdd(aParamBox,{1,Alltrim(RetTitle("VCF_VENOUT")),Space(TamSX3("VCF_VENOUT")[1]),"@!","","SA3","",40,.f.}) 	// 9
EndIf
If lA1_SEGMER1 // Campo customizado
	aAdd(aParamBox,{1,RetTitle("A1_SEGMER1"),Space(TamSX3("A1_SEGMER1")[1]),"@!","","VX5MZ1","",40,.f.}) 		// 7 ou 10
EndIf
If ParamBox(aParamBox,STR0001,@aRetSX1,,,,,,,,.f.)
	FS_VCR530R3()
EndIf
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_VCR530R3³ Autor ³ Andre Luis Almeida   ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_VCR530R3()
Local cCliFro := " "
Local lVCF    := .f.
PRIVATE aReturn := { STR0011, 1,STR0012, 2, 2, 1, "",1 }//Zebrado # Administracao
cAlias := "VC3"
cNomRel:= "VEICR530"
cTitulo:= STR0001
cDesc1 := STR0001
cDesc2 := cDesc3 := ""
lHabil := .f.
wnRel:=cTamanho:= "P"
NomeRel := SetPrint(cAlias,cNomRel,,@cTitulo,cDesc1,cDesc2,cDesc3,lHabil,,,cTamanho)
If nlastkey == 27
	Return
EndIf
SetDefault(aReturn,cAlias)
Set Printer to &NomeRel
Set Printer On
Set device to Printer
cbTxt    := Space(10)
cbCont   := 0
cString  := "VC1"
Li       := 80
m_Pag    := 1
wnRel    := "VEICR530"
nLin     := 1
cTitulo  := STR0001
cabec1   := " "+STR0003+" "+left(If(aRetSX1[3]=="1"," ",STR0004)+space(25),25)+" "+STR0005+" "+STR0014
cabec2   := ""
nomeprog := "VEICR530"
tamanho  := "P"
nCaracter:= 15
nTotal   := 0
nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
DbSelectArea("VC3")
DbSetOrder(1)
if !Empty(aRetSX1[1]+aRetSX1[2])
	DbSeek(xFilial("VC3")+aRetSX1[1]+aRetSX1[2])
Else
	DbSeek(xFilial("VC3"))
Endif
Do While !Eof() .and. VC3->VC3_FILIAL == xFilial("VC3")
	If !Empty(aRetSX1[1]+aRetSX1[2])
		if VC3->VC3_CODCLI+VC3->VC3_LOJA # aRetSX1[1]+aRetSX1[2]
			DbSelectArea("VC3")
			DbSkip()
			Loop
		Endif
	EndIf
	if cCliFro # VC3->VC3_CODCLI+VC3->VC3_LOJA
		lVCF := .f.
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial("SA1")+ VC3->VC3_CODCLI+VC3->VC3_LOJA)
		DbSelectArea("VCF") 
		DbSetOrder(1)
		If DbSeek(xFilial("VCF")+ VC3->VC3_CODCLI+VC3->VC3_LOJA)
			lVCF := .t.
		EndIf
	EndIf
	If !lVCF .and. !Empty(aRetSX1[4]+aRetSX1[5]+aRetSX1[6]+IIf(lNewVend,aRetSX1[7]+aRetSX1[8]+aRetSX1[9],""))
		DbSelectArea("VC3")
		DbSkip()
		Loop
	ElseIf lVCF
		If !Empty(aRetSX1[4]) .and. aRetSX1[4] <> VCF->VCF_VENPEC
			dbSelectArea("VC3")
			dbSkip()
			Loop
		EndIf
		If !Empty(aRetSX1[5]) .and. aRetSX1[5] <> VCF->VCF_VENSRV
			dbSelectArea("VC3")
			dbSkip()
			Loop
		EndIf
		If !Empty(aRetSX1[6]) .and. aRetSX1[6] <> VCF->VCF_VENVEI
			dbSelectArea("VC3")
			dbSkip()
			Loop
		EndIf
		If lNewVend // Vendedores: Usados / Pneus / Outros
			If !Empty(aRetSX1[7]) .and. aRetSX1[7] <> VCF->VCF_VENVEU
				dbSelectArea("VC3")
				dbSkip()
				Loop
			EndIf
			If !Empty(aRetSX1[8]) .and. aRetSX1[8] <> VCF->VCF_VENPNE
				dbSelectArea("VC3")
				dbSkip()
				Loop
			EndIf
			If !Empty(aRetSX1[9]) .and. aRetSX1[9] <> VCF->VCF_VENOUT
				dbSelectArea("VC3")
				dbSkip()
				Loop
			EndIf
		EndIf
	EndIf
	If lA1_SEGMER1 // Campo Customizado
		If lNewVend // Vendedores: Usados / Pneus / Outros
			If !Empty(aRetSX1[10]) .and. SA1->A1_SEGMER1 <> aRetSX1[10]
				dbSelectArea("VC3")
				dbSkip()
				Loop
			EndIf
		Else
			If !Empty(aRetSX1[7]) .and. SA1->A1_SEGMER1 <> aRetSX1[7]
				dbSelectArea("VC3")
				dbSkip()
				Loop
			EndIf
		EndIf
	EndIf
	If nLin >= 58
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	EndIf
	if cCliFro # VC3->VC3_CODCLI+VC3->VC3_LOJA
		cCliFro := VC3->VC3_CODCLI+VC3->VC3_LOJA
		nLin++
		@ nlin++,00 PSAY left(STR0002+" "+VC3->VC3_CODCLI + "-" + VC3->VC3_LOJA + " " + SA1->A1_NOME,60)+" "+left(IIf(lA1_SEGMER1,OFIOA560DS("033",SA1->A1_SEGMER1),""),19)
	Endif
	if aRetSX1[3]=="1" // Modelo
		DbSelectArea("VV2")
		DbSetOrder(1)
		DbSeek(xFilial("VV2")+VC3->VC3_CODMAR+VC3->VC3_MODVEI)
		@ nLin++,01 PSAY VC3->VC3_CODMAR+"  "+substr(VC3->VC3_MODVEI,1,12)+" "+left(VV2->VV2_DESMOD+space(25),25)+" "+Transform(VC3->VC3_FABMOD,"@R 9999/9999")+Space(6)+Str(VC3->VC3_QTDFRO,4)+" "+DtoC(VC3->VC3_DATATU)
	else // Chassi Veiculo
		@ nLin++,01 PSAY VC3->VC3_CODMAR+"  "+substr(VC3->VC3_MODVEI,1,12)+" "+left(VC3->VC3_CHASSI+space(25),25)+" "+Transform(VC3->VC3_FABMOD,"@R 9999/9999")+Space(6)+Str(VC3->VC3_QTDFRO,4)+" "+DtoC(VC3->VC3_DATATU)
	endif
	nTotal += VC3->VC3_QTDFRO
	DbSelectArea("VC3")
	DbSkip()
EndDo
@ nLin++,55 PSAY Repl("-",10)
@ nLin++,48 PSAY STR0006+" "+Str(nTotal,10)
Eject
Set Printer to
Set device to Screen
MS_FLUSH()
OurSpool(NomeRel)
Return()
