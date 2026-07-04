/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 05     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "VEICR510.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ VEICR510 ³ Autor ³  Fabio                ³ Data ³ 08/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Contatos Realizados                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR510
Local aArea := GetArea()
Local aParamBox  := {}
Private lA1_IBGE := ( SA1->(FieldPos("A1_IBGE")) > 0 )
Private aReturn  := {STR0005,1,STR0006,2,2,2,,1}
Private aRetSX1  := {}
Private lA1_SEGMER1 := ( SA1->(FieldPos("A1_SEGMER1")) > 0 )
aAdd(aParamBox,{1,Alltrim(RetTitle("VC1_TIPAGE")),Space(TamSX3("VC1_TIPAGE")[1]),"@!","","VC5","",35,.f.})	// 1
aAdd(aParamBox,{1,Alltrim(RetTitle("VC1_CODVEN")),Space(TamSX3("VC1_CODVEN")[1]),"@!","","SA3","",40,.f.}) 	// 2
aAdd(aParamBox,{1,STR0007,dDataBase-day(dDataBase)+1,"@D","","","",50,.f.}) 								// 3
aAdd(aParamBox,{1,STR0008,dDataBase,"@D","","","",50,.f.}) 													// 4
aAdd(aParamBox,{2,STR0009,"0",{"0="+STR0010,"1="+STR0011},35,"",.F.})										// 5
If lA1_SEGMER1 // Campo customizado
	aAdd(aParamBox,{1,RetTitle("A1_SEGMER1"),Space(TamSX3("A1_SEGMER1")[1]),"@!","","VX5MZ1","",40,.f.}) 	// 6
EndIf
If !ParamBox(aParamBox,STR0001,@aRetSX1,,,,,,,,.f.)
	Return()
EndIf

cAlias  := "VC1"
cNomRel := "VEICR510"
cTitulo := STR0001
cDesc1  := STR0001
cDesc2  := ""
cDesc3  := ""
aOrdem  := {STR0003,STR0004}
lHabil  := .f.
cTamanho:= "P"

cNomRel:= SetPrint(cAlias,cNomRel,,@cTitulo,cDesc1,cDesc2,cDesc3,lHabil,,,cTamanho)

If nlastkey == 27
	Return
EndIf

SetDefault(aReturn,cAlias)

RptStatus({|lEnd| U_FS_IVCR510(@lEnd,cNomRel,'VC1')},cTitulo)

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FS_IVCR510³ Autor ³  Fabio                ³ Data ³ 08/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_IVCR510()
Local cDt      := ""
Local ni       := 0
Local nValor   := 0
Local cTexto   := ""
Local nPos     := 0
Local lCEVOUT  := ( VAI->(FieldPos("VAI_CEVOUT")) > 0 ) // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
Local cA1_SEGMER1 := ""

VAI->(DbSetOrder(4))
VAI->(DbSeek( xFilial("VAI") + __CUSERID ))

Set Printer to &cNomRel
Set Printer On
Set device to Printer

cbTxt    := Space(10)
cbCont   := 0
cString  := "VC1"
Li       := 132
m_Pag    := 1
cTitulo  := STR0001
cabec1   := STR0001
cabec2   := STR0002+" "+left(RetTitle("A1_EMAIL")+space(30),30)+" "+IIf(lA1_SEGMER1,RetTitle("A1_SEGMER1"),"")
nomeprog := "VEICR510"
tamanho  := "M"
nCaracter:= 15
nTotal   := 0
nLin     := 1

Count To nBarra For !Eof().And. VC1_FILIAL == xFilial('VC1') .And. (Empty(aRetSX1[1]).or. VC1_TIPAGE == aRetSX1[1])
SetRegua(nBarra)

DbSelectArea("VC1")
DbSetOrder(5)
DbSeek( xFilial("VC1") + aRetSX1[1] + dtos(aRetSX1[3]) ,.t. )
Do While !Eof().And. VC1->VC1_FILIAL == xFilial('VC1') .And. (Empty(aRetSX1[1]).or. VC1->VC1_TIPAGE == aRetSX1[1])
	IncRegua()
	If lCEVOUT
		If VAI->VAI_CEVOUT == "0" // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
			If VAI->VAI_CODVEN <> VC1->VC1_CODVEN
				DbSelectArea("VC1")
				DbSkip()
				Loop
			EndIf
		EndIf
	EndIf
	If !Empty(VC1->VC1_DATVIS) .And. ((Empty(aRetSX1[3]).or. VC1->VC1_DATVIS >= aRetSX1[3]) .and.(Empty(aRetSX1[4]) .or. VC1->VC1_DATVIS <= aRetSX1[4])) .and. (Empty(aRetSX1[2]) .or. VC1->VC1_CODVEN == aRetSX1[2])
		If !Empty(VC1->VC1_CODCLI+VC1->VC1_LOJA) // Cliente
			DbSelectArea("SA1")
			DbSetOrder(1)
			DbSeek( xFilial("SA1") + VC1->VC1_CODCLI + VC1->VC1_LOJA )
			If lA1_SEGMER1 .and. !Empty(aRetSX1[6]) .and. SA1->A1_SEGMER1 <> aRetSX1[6]
					dbSelectArea("VC1")
					dbSkip()
					Loop
			EndIf
			cA1_SEGMER1 := IIf(lA1_SEGMER1,left(OFIOA560DS("033",SA1->A1_SEGMER1),20),"")
			if lA1_IBGE
				DbSelectArea("VAM")
				DbSetOrder(1)
				DbSeek( xFilial("VAM") + SA1->A1_IBGE )
			endif
		Else // Prospect
			DbSelectArea("SUS")
			DbSetOrder(1)
			DbSeek( xFilial("SUS") + VC1->VC1_CDPROS + VC1->VC1_LJPROS )
		EndIf
		DbSelectArea("SA3")
		DbSetOrder(1)
		DbSeek( xFilial("SA3") + VC1->VC1_CODVEN )
		cDt := left(Transform(VC1->VC1_DATVIS,"@D"),6)+right(Transform(VC1->VC1_DATVIS,"@D"),2)
		If nLin == 1
			nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
		EndIf
		If !Empty(VC1->VC1_CODCLI+VC1->VC1_LOJA) // Cliente
			if lA1_IBGE
				@ nLin++,00 PSAY VC1->VC1_TIPAGE+" "+cDt+" "+VC1->VC1_CODVEN+" "+left(SA3->A3_NOME,10)+" "+left(VC1->VC1_CODCLI+"-"+VC1->VC1_LOJA+" "+SA1->A1_NOME,33)+" "+left(VAM->VAM_DESCID,14)+"-"+VAM->VAM_ESTADO +" "+left(SA1->A1_EMAIL,30)+" "+cA1_SEGMER1 
			else
				@ nLin++,00 PSAY VC1->VC1_TIPAGE+" "+cDt+" "+VC1->VC1_CODVEN+" "+left(SA3->A3_NOME,10)+" "+left(VC1->VC1_CODCLI+"-"+VC1->VC1_LOJA+" "+SA1->A1_NOME,33)+" "+left(SA1->A1_MUN,14)+"-"+SA1->A1_EST +" "+left(SA1->A1_EMAIL,30)+" "+cA1_SEGMER1
			endif
		Else // Prospect
			@ nLin++,00 PSAY VC1->VC1_TIPAGE+" "+cDt+" "+VC1->VC1_CODVEN+" "+left(SA3->A3_NOME,10)+" "+left(VC1->VC1_CDPROS+"-"+VC1->VC1_LJPROS+" "+SUS->US_NOME,33)+" "+left(SUS->US_MUN,14)+"-"+SUS->US_EST +" "+left(SUS->US_EMAIL,30) +" ( "+STR0012+" )" // Prospect
		EndIf
		If aRetSX1[5] == "1" // Sim
			ni := 0
			DbSelectArea("SYP")
			DbSetOrder(1)
			DbSeek( xFilial("SYP") + VC1->VC1_OCOMEM )
			While !Eof() .and. SYP->YP_CHAVE == VC1->VC1_OCOMEM
				cTexto := Alltrim(SYP->YP_TEXTO)
				nPos := AT("___",cTexto)
				If nPos > 0
					DbSelectArea("SYP")
					DbSkip()
					Loop
				EndIf
				If ni == 0
					DbSelectArea("VC0")
					DbSetOrder(1)
					DbSeek( xFilial("VC0") + VC1->VC1_TIPCON )
					nValor := 0
					ni++
				EndIf
				nValor++
				nPos := AT("\13\10",cTexto)
				If nPos > 0
					nPos--
				Else
					nPos := Len(cTexto)
				EndIf
				If !Empty(Alltrim(Substr(cTexto,1,nPos)))
					If nLin >= 60
						nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
					EndIf
					@ nLin++,11 PSAY left(left(IIf(nValor==1,VC0->VC0_DESCON," ")+space(11),11)+Substr(cTexto,1,nPos),80)
				EndIf
				DbSelectArea("SYP")
				DbSkip()
			EndDo
			nLin++
			If nLin >= 53
				nLin := 1
			EndIf
		Else
			If nLin >= 60
				nLin := 1
			EndIf
		EndIf
	EndIf
	DbSelectArea("VC1")
	DbSkip()
EndDo

Eject
Set Printer to
Set device to Screen
MS_FLUSH()
OurSpool(cNomRel)

Return