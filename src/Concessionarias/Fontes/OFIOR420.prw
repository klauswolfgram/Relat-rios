/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ofior420.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIOR420 ³ Autor ³ Andre Luis Almeida    ³ Data ³ 13/08/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Demonstrativo de Liberacao de Vendas                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR420
FS_OFR420R3()
Return

Static Function FS_OFR420R3()
Local cAlias :="VS6"
Local cDesc3 := ""
Private nLin := 1
Private aPag := 1
Private cDesc1     := STR0001  //"Demonstrativo de Liberacao de Vendas"
Private cCabec1    := STR0001
Private cDesc2     := ""
Private cCabec2    := ""
Private aReturn    := { STR0002, 1,STR0003, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"{"Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
Private cTamanho   := "M"           // P/M/G
Private Limite     := 132          // 80/132/220
Private cTitulo    := STR0001
Private cNomProg   := "OFIOR420"
Private cNomeRel   := "OFIOR420"
Private nLastKey   := 0
Private nCaracter  := 15
Private cPerg      := "OFI420"
Private aVetCampos := {}
Private cGruVei
Private cArqTra,cArqInd1
Private cProVei
Private cEstVei
Private cPrefix
/*
MV_PAR01 = Data Inicial
MV_PAR02 = Data Final
MV_PAR03 = Usuario Requisicao
MV_PAR04 = Usuario Liberacao
MV_PAR05 = Cliente
MV_PAR06 = Apresenta        1- Tudo              2- Somente Pecas     3- Somente Servicos      4- Somente Veiculos    5- Veiculos & Pecas
MV_PAR07 = Cont. Apresen    1- Veiculos & Pecas  2 - Pecas & Servicos
MV_PAR08 = % Desc Desejado de
MV_PAR09 = % Desc Desejado Até
*/
set printer to &cNomeRel
set printer on
set device to printer

cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,.t.,cTamanho)
if nlastkey == 27
	return
Endif
PERGUNTE(cPerg,.f.)
SetDefault(aReturn,cAlias)
RptStatus({|lEnd| FS_IMP420(@lEnd,cNomeRel,cAlias)},cTitulo)
Return
////////////////////////////////////////////////////
Static Function FS_IMP420(lEnd,wNRel,cAlias)
Local aVetImp := {}
Local lPula   := .f.
Local cDesc   := ""
Local cTipo   := ""
Local cObserv := ""
Local cDescSrv:= ""
Local ni := 0
Local cUserReq := ""
Local cUserLib := ""
If !Empty(MV_PAR03)
	cUserReq := UsrRetName(MV_PAR03)
EndIf
If !Empty(MV_PAR04)
	cUserLib := UsrRetName(MV_PAR04)
EndIf
M_PAG    := 1
nLin     := 80
aPag     := 1
DbSelectArea("VS6")
DbSetOrder(1)
DbSeek(xFilial("VS6"))
SetRegua(RecCount())
Do While !Eof() .and. VS6->VS6_FILIAL == xFilial("VS6")
	IncRegua()
	if !Empty(MV_PAR01) .and. !Empty(MV_PAR02)
		if VS6->VS6_DATOCO < MV_PAR01 .or. VS6->VS6_DATOCO > MV_PAR02
			DbSelectArea("VS6")
			DbSkip()
			Loop
		Endif
	Endif
	if !Empty(cUserReq)
		if Alltrim(cUserReq) # Alltrim(VS6->VS6_USUARI)
			DbSelectArea("VS6")
			DbSkip()
			Loop
		Endif
	Endif
	if !Empty(cUserLib)
		if Alltrim(cUserLib) # Alltrim(VS6->VS6_LIBPRO)
			DbSelectArea("VS6")
			DbSkip()
			Loop
		Endif
	Endif
	if !Empty(MV_PAR05)
		if MV_PAR05 # VS6->VS6_CODCLI
			DbSelectArea("VS6")
			DbSkip()
			Loop
		Endif
	Endif
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial("SA1")+VS6->VS6_CODCLI+VS6->VS6_LOJA)
	DbSelectArea("VS7")
	DbSetOrder(1)
	DbSeek(xFilial("VS7")+VS6->VS6_NUMIDE)
	Do While !Eof() .and. xFilial("VS7") == VS7->VS7_FILIAL .and. VS6->VS6_NUMIDE == VS7->VS7_NUMIDE
		lPula := .f.
		If MV_PAR08 > 0
			 If VS7->VS7_DESDES < MV_PAR08
					lPula := .t.
			 Endif 
		Endif
		If MV_PAR09 > 0 
			 If VS7->VS7_DESDES > MV_PAR09
					lPula := .t.
			 Endif 
		Endif
		If !lPula
			if MV_PAR06 <> 5
				If MV_PAR06 <> 1
					If MV_PAR06 == 2 // Pecas
						If VS7->VS7_TIPAUT <> "1"
							lPula := .t.
						EndIf
					ElseIf MV_PAR06 == 3 // Servicos
						if VS7->VS7_TIPAUT <> "2"
							lPula := .t.
						EndIf
					ElseIf MV_PAR06 == 4 // Veiculos
						If VS7->VS7_TIPAUT <> "3"
							lPula := .t.
						EndIf
					EndIf
				EndIf
			Else
				if MV_PAR07 == 1
					If VS7->VS7_TIPAUT == "2"
						lPula := .t.
					EndIf
				Elseif MV_PAR07 == 2
					If VS7->VS7_TIPAUT == "3"
						lPula := .t.
					EndIf
				Endif
			Endif
		Endif
		If lPula
			DbSelectArea("VS7")
			DbSkip()
			Loop
		EndIf
		cTipo := space(20)
		cDesc := space(50)
		If VS7->VS7_TIPAUT == "1" // Peca
			cTipo := STR0010
			DbSelectArea("SB1")
			DbSetOrder(7)
			DbSeek(xFilial("SB1")+VS7->VS7_GRUITE+VS7->VS7_CODITE)
			cDesc := left(VS7->VS7_GRUITE+" "+Alltrim(VS7->VS7_CODITE)+" "+SB1->B1_DESC+space(47),47)
		ElseIf VS7->VS7_TIPAUT == "2" // Servico
			cTipo := STR0011
			cDescSrv := ""
			DbSelectArea("VO6")
			DbSetOrder(4)
			If DbSeek(xFilial("VO6")+VS7->VS7_CODSER)
				If VO6->VO6_GRUSER == VS7->VS7_GRUSER
					cDescSrv := VO6->VO6_DESSER
				EndIf
			EndIf
			cDesc := left(VS7->VS7_TIPSER+" "+VS7->VS7_GRUSER+" "+Alltrim(VS7->VS7_CODSER)+" "+cDescSrv+space(47),47)
		Else	// VS7->VS7_TIPAUT == "3" // Veiculos
			DbSelectArea("VV1")
			DbSetOrder(2)
			DbSeek(xFilial("VV1")+VS7->VS7_CODITE)
			If VV1->VV1_PROVEI <> cProVei .or. VV1->VV1_ESTVEI <> cEstVei
				If VV1->VV1_PROVEI == "2 " .and. VV1->VV1_ESTVEI == "0"
					cTipo := STR0006
				ElseIf VV1->VV1_PROVEI == "2 " .and. VV1->VV1_ESTVEI == "1"
					cTipo := STR0007
				ElseIf VV1->VV1_PROVEI == "1 " .and. VV1->VV1_ESTVEI == "0"
					cTipo := STR0008
				Else
					cTipo := STR0009
				EndIf
			EndIf
			cDesc := left(Alltrim(VV1->VV1_CHASSI)+" "+VV1->VV1_MODVEI+space(47),47)
		EndIf
		Aadd(aVetImp,{VS6->VS6_TIPOCO+" "+VS6->VS6_DESOCO,cTipo,cDesc,VS7->VS7_DESPER,VS7->VS7_DESDES,VS7->VS7_VALORI,VS7->VS7_VALPER,VS7->VS7_VALDES,VS7->VS7_ITELIB,VS6->VS6_NUMORC,VS6->VS6_CODCLI+"-"+VS6->VS6_LOJA+" "+left(SA1->A1_NOME,20),transform(VS6->VS6_DATOCO,"@D"),transform(VS6->VS6_HOROCO,"@E 99:99"),VS6->VS6_USUARI,VS6->VS6_LIBPRO,transform(VS6->VS6_DATAUT,"@D"),transform(VS6->VS6_HORAUT,"@E 99:99"),VS6->VS6_OBSMEM})
		DbSelectArea("VS7")
		DbSkip()
	EndDo
	DbSelectArea("VS6")
	DbSkip()
Enddo
nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg,cTamanho,nCaracter)+1
If len(aVetImp) > 0
	INCLUI := .f. // Declarar para nao dar erro no MEMO
	ALTERA := .f. // Declarar para nao dar erro no MEMO
	asort(aVetImp,,,{|x,y| x[1]+x[10]+x[12]+x[13]+x[2]+x[3] < y[1]+y[10]+y[12]+y[13]+y[2]+y[3] })
	cQuebra1 := "INICIAL"
	cQuebra2 := "INICIAL"
	cQuebra3 := "INICIAL"
	cQuebra4 := "INICIAL"
	For ni := 1 to len(aVetImp)
		If nLin >= 58
			nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomProg,cTamanho,nCaracter)+1
		EndIf
		If cQuebra1 <> Alltrim(aVetImp[ni,1])
			cQuebra1 := Alltrim(aVetImp[ni,1])
			nLin += 2
			@ nLin++, 001 pSay STR0014 +" "+ cQuebra1
			cQuebra2 := "INICIAL"
		EndIf
		If cQuebra2 <> aVetImp[ni,10]
			cQuebra2 := aVetImp[ni,10]
			nLin += 2
			@ nLin++, 001 pSay "<<< "+STR0012+" "+cQuebra2+" - "+STR0013+" "+aVetImp[ni,11]+" >>>"
			cQuebra3 := "INICIAL"
		EndIf
		If cQuebra3 <> ( aVetImp[ni,12]+" "+aVetImp[ni,13] )
			cQuebra3 := ( aVetImp[ni,12]+" "+aVetImp[ni,13] )
			cObserv := E_MSMM(aVetImp[ni,18],80)
			nLin++
			@ nLin++, 003 pSay STR0005+" "+cQuebra3+" "+aVetImp[ni,14]
			If !Empty(cObserv)
				@ nLin++, 003 pSay cObserv
			EndIf
			cQuebra4 := "INICIAL"
		EndIf
		If cQuebra4 <> aVetImp[ni,2]
			cQuebra4 := aVetImp[ni,2]
			nLin++
			@ nLin++, 005 pSay left(cQuebra4+space(47),47)+STR0004
		EndIf
		@ nLin++, 005 pSay aVetImp[ni,3]+transform(aVetImp[ni,5],"@E 99.999")+transform(aVetImp[ni,4],"@E 999.999")+transform(aVetImp[ni,6],"@E 9999,999.99")+transform(aVetImp[ni,8],"@E 9999,999.99")+transform(aVetImp[ni,7],"@E 9999,999.99")+" "+aVetImp[ni,16]+" "+aVetImp[ni,17]+" "+aVetImp[ni,15]
	Next
EndIf
Set Printer to
Set device to Screen
MS_FLUSH()
If aReturn[5] == 1
	OurSpool(cNomeRel)
EndIf
Return