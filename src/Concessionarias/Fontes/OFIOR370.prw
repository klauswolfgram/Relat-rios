/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 17     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "Protheus.ch"
#Include "Ofior370.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIOR370 ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Copia da Nota Fiscal                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR370
OFIOC160("S") // Consulta NF com possibilidade de impressao da mesma
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ImpNotaPS ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime nota fiscal de Saida                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ImpNotaPS(cAlias,nReg,nOpc)

Local bCampo := { |nCPO| Field(nCPO) }
Local aPages := {}, aVar:={}
Local nPar := 1
Local i := 0 , _ni := 0

Local oWAreaGeral
Local aSize   := FWGetDialogSize( oMainWnd )

Private aNewBot := {}

aadd(aNewBot,{"RELATORIO" ,{||U_Mc090Cons(1,aPedidos)},STR0032}) 	//Consulta Pedido
if nModulo == 11
	aadd(aNewBot,{"NOVACELULA",{||U_FS_MEMO()},STR0033})		//Consulta Observacao
Endif
If cPaisLoc == "BRA"
	aadd(aNewBot,{"PRECO"     ,{||U_FS_AVALIACAO()},STR0034})		//Avaliacao do Resultado
EndIf

For i:=1 to Len(aNewBot)
	Private cFunc&(alltrim(Str(i))) := aNewBot[i,2]
Next

Private cFcBot
Private cCodVen
Private oLbEntIte
Private aTELA[0][0], aGETS[0], aHeader[0]
Private lConsulta   := .f.
Private cNumPed     := ""
Private aPedidos    := {}
Private nTotDes     := 0
Private nTotOrc     := 0
Private nTotPec     := 0
Private nTotSrv     := 0
Private nC          := 1
Private nNF         := 1
Private lPri        := .t.
Private aCabPV      := {}
Private aItePV      := {}
Private lAbortPrint := .f.
Private cNumIde	  := ""

aRotina := { { STR0003 ,"OFIOR370" , 0, 1},;      //Pesquisar
{ STR0004 ,"OFIOR370" , 0, 2}};      //Imprimir

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcoes de acesso para a Modelo 3                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cTitulo        := STR0029 //Consulta Nota Fiscal
cAliasEnchoice := "SF2"
cLinOk         := "AllwaysTrue()"
cTudoOk        := "AllwaysTrue()"
cFieldOk       := "FG_MEMVAR()"

if nOpc == 2
	lConsulta := .t.
Endif

nOpc :=2
nOpcE:=2
nOpcG:=2

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Variavel interna para funcionamento correto dos campos MEMOS na Visualizacao por outras Rotinas //
/////////////////////////////////////////////////////////////////////////////////////////////////////
If nOpc == 2 .and. FunName() != "OFIOR370" // Necessario utilizar a funcao FUNNAME (chamada no MENU)
	SetStartMod(.t.)	
Endif
/////////////////////////////////////////////////////////////////////////////////////////////////////

nOpca:=0

lRefresh := .t.
Inclui   := .f.
lVirtual := .f.
nLinhas  := 99

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posciona no Tipos de Condicao de Pagamento                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SE4")
DbSeek(xFilial("SE4")+SF2->F2_COND)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posciona no cliente                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SF2->F2_TIPO $ "BD"
	DbSelectArea("SA2")
	DbSeek(xFilial("SA2")+SF2->F2_CLIENTE+SF2->F2_LOJA)
Else
	DbSelectArea("SA1")
	DbSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria variaveis M->????? da Enchoice                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory("SF2",.T.)
aCpoEnchoice  :={}
DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SF2")
While !Eof().and.(x3_arquivo=="SF2")
	If X3USO(x3_usado).and.x3_nivel>0  // .and. ( AllTrim(x3_campo) $ [F2_DOC#F2_SERIE#F2_CLIENTE#F2_LOJA#F2_EMISSAO#F2_VALBRUT])
		AADD(aCpoEnchoice,x3_campo)
	Endif
	&("M->"+Alltrim(x3_campo)) := &(x3_campo)
	dbSkip()
End

DbSelectArea("SF2")
For i:=1 to fCount()
	&("M->"+FieldName(i)) := &("SF2->"+FieldName(i))
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o aCols Pecas                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nUsadoNF:=0
nSB1 := 0
dbSelectArea("SX3")
dbSeek("SD2")
aHeaderNF:={}
While !Eof().And.(x3_arquivo=="SD2")
	If X3USO(x3_usado) // .and. ( AllTrim(SX3->X3_CAMPO) $ "D2_ITEM#D2_COD#D2_QUANT#D2_PRCVEN#D2_TOTAL#D2_TES#D2_PEDIDO#" )
		nUsadoNF++
		Aadd(aHeaderNF,{ TRIM(X3Titulo()), x3_campo, x3_picture,;
		x3_tamanho, x3_decimal,x3_valid,;
		x3_usado, x3_tipo, x3_arquivo, x3_context, x3_relacao, x3_reserv } )
		&("M->"+Alltrim(x3_campo)) := CriaVar(x3_campo)
		If alltrim(x3_campo) == "D2_CODITE"
			nUsadoNF++
			nSB1 := nUsadoNF
			dbSelectArea("SX3")
			dbSetOrder(2)
			dbSeek("B1_DESC")
			Aadd(aHeaderNF,{ TRIM(X3Titulo()), x3_campo, x3_picture,;
			x3_tamanho, x3_decimal,x3_valid,;
			x3_usado, x3_tipo, x3_arquivo, x3_context, x3_relacao, x3_reserv } )
			&("M->"+Alltrim(x3_campo)) := CriaVar(x3_campo)
			dbSelectArea("SX3")
			dbSetOrder(2)
			dbSeek("D2_CODITE")
			dbSelectArea("SX3")
			dbSetOrder(1)
		EndIf
	Endif
	dbSkip()
EndDo

aColsNF := {}
cGrpCod := ""
DbSelectArea("SD2")
dbSetOrder(3)
Fg_Seek("SD2","SF2->F2_DOC+SF2->F2_SERIE",3,.F.)
While SD2->D2_DOC == SF2->F2_DOC .and. SD2->D2_SERIE == SF2->F2_SERIE .and. !eof()
	AADD(aColsNF,Array(nUsadoNF+1))
	For _ni:=1 to nUsadoNF
		If _ni # nSB1
			If _ni < nSB1
				If _ni == ( nSB1 - 2 ) // Grupo
					cGrpCod := If(aHeaderNF[_ni,10] # "V",FieldGet(FieldPos(aHeaderNF[_ni,2])),CriaVar(aHeaderNF[_ni,2]))
				EndIf
				If _ni == ( nSB1 - 1 ) // Codigo Item
					cGrpCod += If(aHeaderNF[_ni,10] # "V",FieldGet(FieldPos(aHeaderNF[_ni,2])),CriaVar(aHeaderNF[_ni,2]))
				EndIf
			EndIf
			aColsNF[Len(aColsNF),_ni]:=If(aHeaderNF[_ni,10] # "V",FieldGet(FieldPos(aHeaderNF[_ni,2])),CriaVar(aHeaderNF[_ni,2]))
		Else
			DbSelectArea("SB1")
			DbSetOrder(7)
			DbSeek( xFilial("SB1") + cGrpCod )
			aColsNF[Len(aColsNF),_ni]:= SB1->B1_DESC
			cGrpCod := ""
			DbSelectArea("SD2")
		EndIf
	Next
	if aScan(aPedidos,SD2->D2_PEDIDO) = 0
		aAdd(aPedidos,SD2->D2_PEDIDO)
	Endif
	aColsNF[Len(aColsNF),nUsadoNF+1]:=.F.
	cNumPed := SD2->D2_PEDIDO
	DbSelectArea("SD2")
	DbSkip()
EndDo
cNumPed := SF2->F2_DUPL // Devido a mudanca do numero do titulo se tornou o número da nota

if Len(aColsNF) == 0
	aColsNF:={Array(nUsadoNF+1)}
	aColsNF[1,nUsadoNF+1]:=.F.
	For _ni:=1 to nUsadoNF
		aColsNF[1,_ni]:=CriaVar(aHeaderNF[_ni,2])
	Next
Endif

Private oOk := LoadBitmap( GetResources(), "LBTIK" )
Private oNo := LoadBitmap( GetResources(), "LBNO" )

nTotPec := SF2->F2_VALBRUT+SF2->F2_DESCONT
nTotDes := SF2->F2_DESCONT
nTotOrc := SF2->F2_VALBRUT

aEntrada := {}
aDescEnt := {}
aIteParc := {}

DbSelectarea("VS1")
DbSetOrder(3)
DbSeek(xFilial("VS1")+SF2->F2_DOC+SF2->F2_SERIE)
if cTipoNF == "T"
	if !VS1->( Found() )
		DbSelectarea("VV0")
		DbSetOrder(4)
		if !DbSeek(xFilial("VV0")+SF2->F2_DOC+SF2->F2_SERIE)
			DbSelectarea("VOO")
			DbSetOrder(4)
			if DbSeek(xFilial("VOO")+SF2->F2_DOC+SF2->F2_SERIE)
				DbSelectarea("SE1")
				DbSetOrder(1)
				DbSeek(xFilial("SE1")+SF2->F2_PREFIXO+cNumPed)
				cNumIde := cNumPed+space(TamSx3("VS9_NUMIDE")[1]-Len(AllTrim(cNumPed)))
				cTipoNF := "O"
			Endif
		Else
			DbSelectArea("SE1")
			DbSetOrder(1)
			DbSeek(xFilial("SE1")+SF2->F2_PREFIXO+VV0->VV0_NUMTRA)
			cNumIde := VV0->VV0_NUMTRA
			cTipoNF := "V"
		Endif
	Else
		DbSelectArea("SE1")
		DbSetOrder(1)
		DbSeek(xFilial("SE1")+SF2->F2_PREFIXO+cNumPed)
		cNumIde := VS1->VS1_NUMORC
		cTipoNF := " "
	Endif
Elseif cTipoNF == "B"
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek(xFilial("SE1")+SF2->F2_PREFIXO+cNumPed)
	cNumIde := VS1->VS1_NUMORC
Elseif cTipoNF == "V"
	DbSelectArea("VV0")
	DbSetOrder(4)
	DbSeek(xFilial("VV0")+SF2->F2_DOC+SF2->F2_SERIE)
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek(xFilial("SE1")+SF2->F2_PREFIXO+VV0->VV0_NUMTRA)
	cNumIde := VV0->VV0_NUMTRA
Else
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek(xFilial("SE1")+SF2->F2_PREFIXO+cNumPed)
	cNumIde := cNumPed+space(TamSx3("VS9_NUMIDE")[1]-Len(AllTrim(cNumPed)))
Endif

&& Parcelas
DbSelectArea("SE1")
DbSetOrder(1)
Do While !EOF() .and. (E1_PREFIXO+Alltrim(E1_NUM) == SF2->F2_PREFIXO+Alltrim(cNumPed))
	if 	(cTipoNF =="B" .and. E1_PREFORI != GetNewPar("MV_PREFBAL","BAL")) .or.;
		(cTipoNF =="O" .and. E1_PREFORI != GetNewPar("MV_PREFOFI","OFI")) .or.;
		(cTipoNF =="V" .and. E1_PREFORI != GetNewPar("MV_PREFVEI","VEI"))
		DBSkip()
		loop
	endif
	aadd(aIteParc,{E1_VENCREA,E1_VALOR})
	DbSkip()
Enddo

if Len(aIteParc) == 0
	aadd(aIteParc,{cTod(""),0})
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o aCols e aHeader da Condicao de Pagamento             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nUsadoC:=0
DbSelectArea("SX3")
DbSeek("VS9")
aHeaderC:={}
While !Eof().And.(x3_arquivo=="VS9")
	//      If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ( Trim(SX3->X3_CAMPO) $ "VS9_TIPPAG#VS9_DESPAG#VS9_DATPAG#VS9_VALPAG#VS9_REFPAG#VS9_OBSERV#VS9_SEQUEN")
	If cNivel >= x3_nivel .And. ( Trim(SX3->X3_CAMPO) $ "VS9_TIPPAG#VS9_DESPAG#VS9_DATPAG#VS9_VALPAG#VS9_REFPAG#VS9_OBSERV#VS9_SEQUEN")
		nUsadoC++
		Aadd(aHeaderC,{ TRIM(X3Titulo()), x3_campo, x3_picture,;
		x3_tamanho, x3_decimal,x3_valid,;
		x3_usado, x3_tipo, x3_arquivo, x3_context, x3_relacao, x3_reserv } )
		&("M->"+Alltrim(x3_campo)) := CriaVar(x3_campo)
	Endif
	dbSkip()
EndDo

aColsC := {}
DbSelectarea("VS9")
DbSetOrder(1)
if DbSeek(xFilial("VS9")+cNumIde+cTipoNF)
	nPar := 1
	Do While !Eof() .and. xFilial("VS9") == VS9->VS9_FILIAL .and. alltrim(VS9->VS9_NUMIDE) == alltrim(cNumIde) .and. VS9->VS9_TIPOPE == cTipoNF
		lOk := .f.
		DbSelectArea("SE1")
		DbSetOrder(1)
		DbSeek(xFilial("SE1")+SF2->F2_PREFIXO+cNumPed+Str(nPar,1)+VS9->VS9_TIPPAG)
		while E1_FILIAL+E1_PREFIXO+alltrim(E1_NUM)+E1_PARCELA+E1_TIPO == xFilial("SE1")+SF2->F2_PREFIXO+cNumPed+Str(nPar,1)+VS9->VS9_TIPPAG
			if E1_PREFORI == GetNewPar("MV_PREFBAL","BAL")
				if Empty(SE1->E1_BAIXA)
					lOk := .f.
				Else
					lOk := .t.
				Endif
				exit
			endif
			DBSkip()
		enddo
		
		DbSelectArea("VS9")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta o aCols da Entrada                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		AADD(aColsC,Array(nUsadoC+1))
		aColsC[Len(aColsC),Len(aColsC[Len(aColsC)])] := lOk
		For _ni:=1 to nUsadoC
			aColsC[Len(aColsC),_ni]:=If(aHeaderC[_ni,10] # "V",FieldGet(FieldPos(aHeaderC[_ni,2])),CriaVar(aHeaderC[_ni,2]))
		Next
		nPar++
		DbSkip()
	Enddo
Endif 

if Len(aColsC) == 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta o aCols da Entrada                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aColsC:={Array(nUsadoC+1)}
	aColsC[1,nUsadoC+1]:=.F.
	For _ni:=1 to nUsadoC
		aColsC[1,_ni]:=CriaVar(aHeaderC[_ni,2])
	Next
Else
	DbSelectArea("VSE")
	if DbSeek(xFilial("VSE")+cNumIde+cTipoNF+aColsC[1,FG_POSVAR("VS9_TIPPAG","aHeaderC")]+aColsC[1,FG_POSVAR("VS9_SEQUEN","aHeaderC")])
		Do While !Eof() .and. alltrim(VSE->VSE_NUMIDE) == Alltrim(cNumIde) .and. VSE->VSE_TIPOPE == cTipoNF .and. VSE->VSE_TIPPAG == aColsC[1,FG_POSVAR("VS9_TIPPAG","aHeaderC")] .and. VSE->VSE_SEQUEN == aColsC[1,FG_POSVAR("VS9_SEQUEN","aHeaderC")]
			aadd(aDescEnt,{VSE->VSE_DESCCP,VSE->VSE_VALDIG})
			DbSkip()
		Enddo
	Endif
Endif

if Len(aDescEnt) == 0
	aadd(aDescEnt,{"",""})
Endif

Private aTitles  := {OemToAnsi(STR0030),OemToAnsi(STR0031)}
Private oFolder

oDlgOR370 := MSDialog():New( aSize[1], aSize[2], aSize[3], aSize[4], cTitulo, , , , nOr( WS_VISIBLE, WS_POPUP ), , , , , .T., , , , .F. )

oWAreaGeral := FWUIWorkArea():New( oDlgOR370 )
		
oWAreaGeral:CreateHorizontalBox( "LINE01", 33 )
oWAreaGeral:SetBoxCols( "LINE01", { "OBJTESQ" , "OBJTDIR" } )
oWAreaGeral:CreateHorizontalBox( "LINE02", 34 )
oWAreaGeral:SetBoxCols( "LINE02", { "OBJMEIO" } )
oWAreaGeral:CreateHorizontalBox( "LINE03", 23 )
oWAreaGeral:SetBoxCols( "LINE03", { "OBJRESQ" , "OBJRDIR" } )
oWAreaGeral:Activate()

oWAreaRDIR := FWUIWorkArea():New( oWAreaGeral:GetPanel("OBJRDIR") )
oWAreaRDIR:CreateHorizontalBox( "LINE01", 100 )
oWAreaRDIR:SetBoxCols( "LINE01", { "OBJPARCELAS" , "OBJTOTAIS" } )
oWAreaRDIR:Activate()

Zero()
nHRes := int( oMainWnd:nClientWidth / 4 ) // Resolucao horizontal do monitor
oGetMGet:= MsMGet():New("SF2",0,nOpcE,,,,aCpoEnchoice,{000,000,nHRes,nHRes},,2,,,,oWAreaGeral:GetPanel("OBJTESQ"),,.T.,.F.,,,,,,,.T.)
oGetMGet:oBox:Align := CONTROL_ALIGN_ALLCLIENT

aHeader  := aClone(aHeaderNF)
aCols    := aClone(aColsNF)
oGetPecas                       := MsGetDados():New(000,000,100,100,nOpcG,cLinOk,cTudoOk,"",.T.,,,,nLinhas,cFieldOk,,,,oWAreaGeral:GetPanel("OBJMEIO"))
oGetPecas:oBrowse:default()
oGetPecas:oBrowse:bGotFocus     := {|| aHeader := aClone(aHeaderNF),aCols := aClone(aColsNF),n := nNF, oGetPecas:oBrowse:SetFocus()}
oGetPecas:oBrowse:bLostFocus    := {|| aHeaderNF:= aClone(aHeader), aColsNF:= aClone(aCols), nNF:= n }
oGetPecas:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT

aHeader  := aClone(aHeaderC)
aCols    := aClone(aColsC)
oEntrada                       := MsGetDados():New(000,000,100,100,nOpcG,cLinOk,cTudoOk,"",.T.,,,,nLinhas,cFieldOk,,,,oWAreaGeral:GetPanel("OBJTDIR"))
oEntrada:oBrowse:default()
oEntrada:oBrowse:bChange       := {|| U_FS_MUDATP(n,cTipoNF) }
oEntrada:oBrowse:bEditCol      := {|| .t. }
oEntrada:oBrowse:bDelete       := {|| .t. }
oEntrada:oBrowse:bGotFocus     := {|| aHeader := aClone(aHeaderC),aCols := aClone(aColsC),n := nC, oEntrada:oBrowse:SetFocus()}
oEntrada:oBrowse:bLostFocus    := {|| aHeaderC:= aClone(aHeader), aColsC:= aClone(aCols), nC:= n }
oEntrada:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT

@ 000,000 LISTBOX oLbParc FIELDS HEADER  OemToAnsi(STR0042),OemToAnsi(STR0043);  //Data # Valor
COLSIZES 40,50;
SIZE 100,100 OF oWAreaGeral:GetPanel("OBJRESQ") PIXEL
oLbParc:Align := CONTROL_ALIGN_ALLCLIENT
oLbParc:SetArray(aIteParc)
oLbParc:bLine := { || { dToc(aIteParc[oLbParc:nAt,1]),;
Transform(aIteParc[oLbParc:nAt,2],"@E 999,999,999.99")}}

@ 000,000 LISTBOX oLbEntIte FIELDS HEADER OemToAnsi(STR0040),;		//Descricao
OemToAnsi(STR0041);       //Valor
COLSIZES 60,100 ;
SIZE 100,100 OF oWAreaRDIR:GetPanel("OBJPARCELAS") PIXEL
oLbEntIte:Align := CONTROL_ALIGN_ALLCLIENT
oLbEntIte:SetArray(aDescEnt)
oLbEntIte:bLine := { || { aDescEnt[oLbEntIte:nAt,1] ,;
aDescEnt[oLbEntIte:nAt,2] }}

@ 003,005 Say OemToAnsi(STR0037)    SIZE 40,08 OF oWAreaRDIR:GetPanel("OBJTOTAIS") PIXEL COLOR CLR_BLUE	//Itens
@ 003,035 msget oTotPec VAR nTotPec Picture "@E 999,999,999.99" SIZE 60,08 OF oWAreaRDIR:GetPanel("OBJTOTAIS") PIXEL COLOR CLR_BLACK when .f.
@ 015,005 Say OemToAnsi(STR0038) SIZE 60,08 OF oWAreaRDIR:GetPanel("OBJTOTAIS") PIXEL COLOR CLR_BLUE		//Desconto
@ 015,035 msget oTotDes VAR nTotDes Picture "@E 999,999,999.99" SIZE 60,08 OF oWAreaRDIR:GetPanel("OBJTOTAIS") PIXEL COLOR CLR_BLACK when .f.
@ 027,005 Say OemToAnsi(STR0039)    SIZE 50,08 OF oWAreaRDIR:GetPanel("OBJTOTAIS") PIXEL COLOR CLR_BLUE	//Total
@ 027,035 msget oTotOrc VAR nTotOrc Picture "@E 999,999,999.99" SIZE 60,08 OF oWAreaRDIR:GetPanel("OBJTOTAIS") PIXEL COLOR CLR_BLACK when .f.

aHeader  := aClone(aHeaderNF)
aCols    := aClone(aColsNF)

ACTIVATE MSDIALOG oDlgOR370 ON INIT (EnchoiceBar(oDlgOR370,{|| nOpca := 1, oDlgOR370:End()},{|| nOpca := 2,oDlgOR370:End()},,aNewBot) )

if nOpca == 1 .and. !lConsulta
	Processa( {|| U_FS_IMPNOTPS() } )
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_IMPNOTPS³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime nota fiscal                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_IMPNOTPS()

if cTipoNF == "V"
	If ExistBlock("NFSAIVEI")
		ExecBlock("NFSAIVEI",.f.,.f.,{SF2->F2_DOC,SF2->F2_SERIE,"SN"}) // SN - NF Saida (Normal)
	Endif
Else
	If ExistBlock("NFPECSER")
		ExecBlock("NFPECSER",.f.,.f.,{SF2->F2_DOC,SF2->F2_SERIE}) // SN - NF Saida (Normal)
	Endif
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_MUDATP  ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Muda tipo de pagto                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_MUDATP(nLin,cTipoNF)

if lPri == .t.
	lPri := .f.
	Return
Endif

aDescEnt := {}

DbSelectArea("VSE")
if DbSeek(xFilial("VSE")+cNumIde+cTipoNF+aCols[nLin,FG_POSVAR("VS9_TIPPAG","aHeaderC")]+aCols[nLin,FG_POSVAR("VS9_SEQUEN","aHeaderC")])
	Do While !Eof() .and. alltrim(VSE->VSE_NUMIDE) == Alltrim(cNumIde) .and. VSE->VSE_TIPOPE == cTipoNF .and. VSE->VSE_TIPPAG == aColsC[nLin,FG_POSVAR("VS9_TIPPAG","aHeaderC")] .and. VSE->VSE_SEQUEN == aColsC[nLin,FG_POSVAR("VS9_SEQUEN","aHeaderC")]
		aadd(aDescEnt,{VSE->VSE_DESCCP,VSE->VSE_VALDIG})
		DbSkip()
	Enddo
Endif

if Len(aDescEnt) == 0
	AADD(aDescEnt,{"",""})
Endif

oLbEntIte:SetArray(aDescEnt)
oLbEntIte:bLine := { || { aDescEnt[oLbEntIte:nAt,1] ,;
aDescEnt[oLbEntIte:nAt,2] }}

oLbEntIte:Refresh()

Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Mc090Cons  ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Gera pedido				                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Mc090Cons(nTipo,aPedido,cTexto)

Local aArea      := GetArea()
Local aSavHead   := aClone(aHeader)
Local aSavCols   := aClone(aCols)
Local aRecNo     := {}
Local nSavN      := N
Local nUsado     := 0
Local nX         := 0
Local nY         := 0
Local oDlg
Local oGetDad
Local oBtn

Private aHeader := {}
Private aCols   := {}
Private N		:= 1

Do Case
	Case ( nTipo == 1 )
		If ( Len(aPedido) > 1 )
			dbSelectArea("SX3")
			dbSetOrder(1)
			MsSeek("SC5")
			While ( !Eof() .And. SX3->X3_ARQUIVO=="SC5" )
				If ( SX3->X3_BROWSE=="S" )
					Aadd(aHeader,{ AllTrim(X3Titulo()),;
					SX3->X3_CAMPO,;
					SX3->X3_PICTURE,;
					SX3->X3_TAMANHO,;
					SX3->X3_DECIMAL,;
					SX3->X3_VALID,;
					SX3->X3_USADO,;
					SX3->X3_TIPO,;
					SX3->X3_ARQUIVO,;
					SX3->X3_CONTEXT} )
					nUsado++
				EndIf
				dbSelectArea("SX3")
				dbSkip()
			EndDo
			For nX := 1 To Len(aPedido)
				dbSelectArea("SC5")
				dbSetOrder(1)
				MsSeek(xFilial("SC5")+aPedido[nX])
				aadd(aRecNo,RecNo())
				aadd(aCols,Array(nUsado))
				For nY := 1 To Len(aHeader)
					If ( aHeader[nY][10] != "V" )
						aCols[Len(aCols)][nY] := FieldGet(FieldPos(aHeader[nY][2]))
					Else
						aCols[Len(aCols)][nY] := CriaVar(aHeader[nY][2],.T.)
					EndIf
				Next nY
			Next nX
			DEFINE MSDIALOG oDlg FROM	09,0 TO 28,80 TITLE OemToAnsi(STR0044) OF oMainWnd //Pedidos
			@ 001,002 TO 031,267 OF oDlg	PIXEL
			@ 015,005 SAY OemToAnsi(STR0045)+":" SIZE 020,009 OF oDlg PIXEL  //N.Fiscal
			@ 015,030 SAY cTexto             SIZE 150,009 OF oDlg PIXEL
			oGetDad := MsGetDados():New(035,002,135,315,2)
			DEFINE SBUTTON 		FROM 005,280 TYPE 1  ENABLE OF oDlg ACTION ( oDlg:End() )
			DEFINE SBUTTON oBtn FROM 020,280 TYPE 15 ENABLE OF oDlg ACTION ( oGetDad:oBrowse:lDisablePaint:=.T.,U_Mc090Most(1,aRecNo[N]),oGetDad:oBrowse:lDisablePaint:=.F. )
			oBtn:lAutDisable := .F.
			ACTIVATE MSDIALOG oDlg
		Else
			dbSelectArea("SC5")
			dbSetOrder(1)
			MsSeek(xFilial("SC5")+aPedido[1])
			U_Mc090Most(1,RecNo())
		EndIf
	Otherwise
		Alert(STR0046)	//Opcao nao disponivel
EndCase

N       := nSavN
aCols   := aClone(aSavCols)
aHeader := aClone(aSavHead)

RestArea(aArea)

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Mc090Most  ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Mostra pedido                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Mc090Most(nTipo,nRecNo)

Local aArea := GetArea()
Local aSavHead   := aClone(aHeader)
Local aSavCols   := aClone(aCols)
Local nSavN      := N
Private N        := 1
Do Case
	Case ( nTipo == 1 )
		dbSelectArea("SC5")
		dbSetOrder(1)
		MsGoto(nRecNo)
		A410Visual("SC5",nRecNo,2)
EndCase
N       := nSavN
aCols   := aClone(aSavCols)
aHeader := aClone(aSavHead)
RestArea(aArea)

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Fs_Tipo    ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Validacao no prefori                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fs_Tipo()

Local lRet := .t.

Do Case
	Case cTipoNF == "B"
		if SF2->F2_PREFORI <> GetNewPar("MV_PREFBAL","BAL")
			lRet := .f.
		Endif
	Case cTipoNF == "V"
		if SF2->F2_PREFORI <> GetNewPar("MV_PREFVEI","VEI")
			lRet := .f.
		Endif
	Case cTipoNF == "O"
		if SF2->F2_PREFORI <> GetNewPar("MV_PREFOFI","OFI")
			lRet := .f.
		Endif
	Case cTipoNF == "T"
		if SF2->F2_PREFORI = GetNewPar("MV_PREFVEI","VEI")
			lRet := .f.
		Endif
EndCase
DbSelectarea("SF2")

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_AVALIACAO³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Avaliacao			                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_AVALIACAO()

Local nCont     := 0
Local aVetVal   := {}
Local aSomaStru := {}
Local bCampo    := { |nCPO| Field(nCPO) }
Local x := 0 , _ni := 0 , n_ := 0 , i := 0 , nT := 0 , iAg := 0
Local nCnt := 0 , nItot := 0 , nCtFor := 0 , nStep := 0
Local cAliasVEC := GetNextAlias()
Local cAliasVSC := GetNextAlias()
Local cSQL := ""

Local lVV0_MOEDA    := ( VV0->(FieldPos("VV0_MOEDA")) > 0 )

Private cSimVda := ""
Private aStruP  := {}
Private aStruS  := {}
Private aStruO  := {}
Private cCodMap
Private cOutMoed
Private cSimOMoe
Private lCalcTot:= .f.
Private cCpoDiv := "    1"
Private cNumIde
Private lLIBVOO := VOO->(FieldPos("VOO_LIBVOO")) > 0

Do Case
	Case SF2->F2_PREFORI == GetNewPar("MV_PREFBAL","BAL")
		cTipoNF := "B"
	Case SF2->F2_PREFORI == GetNewPar("MV_PREFOFI","OFI")
		cTipoNF := "O"
	Case SF2->F2_PREFORI == GetNewPar("MV_PREFVEI","VEI")
		cTipoNF := "V"
EndCase

If cTipoNF == "B"  //Pecas
	
	Private aColsP
	Private aHeaderP
	Private nUsadoP
	Private cCodVen
	Private nTotNot,nTotDes
	Private aColsc,aIteParc
	cSimVda := "P"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona no VS1 p/ pegar o Vendedor                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	DbSelectArea("VS1")
	DbSetOrder(3)
	DbSeek(xFilial("VS1")+SF2->F2_DOC+SF2->F2_SERIE)
	For x:=1 to FCount()
		&("M->"+FieldName(x)) := &(FieldName(x))
	Next
	
	DbSelectArea("SA3")
	DbSetOrder(1)
	DbSeek(xFilial("SA3")+VS1->VS1_CODVEN)
	cCodVen := SA3->A3_COD
	nTotDes := VS1->VS1_VALDES
	nTotNot := VS1->VS1_VTOTNF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria o aCols Pecas                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	nUsadoP:=0
	DbSelectArea("SX3")
	DbSeek("VS3")
	aHeaderP:={}
	While !Eof().And.(x3_arquivo=="VS3")
		If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ( ! Trim(SX3->X3_CAMPO) $ "VS3_NUMORC" )
			nUsadoP++
			Aadd(aHeaderP,{ TRIM(X3Titulo()), x3_campo, x3_picture,;
			x3_tamanho, x3_decimal,x3_valid,;
			x3_usado, x3_tipo, x3_arquivo, x3_context, x3_relacao, x3_reserv } )
			&("M->"+Alltrim(x3_campo)) := CriaVar(x3_campo)
		Endif
		DbSkip()
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta o aCols Pecas                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aColsP := {}
	DbSelectArea("VS3")
	DbSetOrder(1)
	DbGotop()
	Fg_Seek("VS3","VS1->VS1_NUMORC",1,.F.)
	While VS3->VS3_FILIAL == xFilial("VS3") .and. VS3->VS3_NUMORC == VS1->VS1_NUMORC .and. !eof()
		aAdd(aColsP,Array(nUsadoP+1))
		For _ni:=1 to nUsadoP
			aColsP[Len(aColsP),_ni]:=If(aHeaderP[_ni,10] # "V",FieldGet(FieldPos(aHeaderP[_ni,2])),CriaVar(aHeaderP[_ni,2]))
		Next
		DbSkip()
	Enddo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta o aCols da Entrada                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	nUsadoC:=0
	DbSelectArea("SX3")
	DbSeek("VS9")
	aHeaderC:={}
	While !Eof().And.(x3_arquivo=="VS9")
		If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ( Trim(SX3->X3_CAMPO) $ "VS9_TIPPAG#VS9_DESPAG#VS9_DATPAG#VS9_VALPAG#VS9_REFPAG")
			nUsadoC++
			Aadd(aHeaderC,{ TRIM(X3Titulo()), x3_campo, x3_picture,;
			x3_tamanho, x3_decimal,x3_valid,;
			x3_usado, x3_tipo, x3_arquivo, x3_context, x3_relacao, x3_reserv } )
			
			&("M->"+Alltrim(x3_campo)) := CriaVar(x3_campo)
			
		Endif
		DbSkip()
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta o aCols da Entrada                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aColsC:={Array(nUsadoC+1)}
	aColsC[1,nUsadoC+1]:=.F.
	For _ni:=1 to nUsadoC
		aColsC[1,_ni]:=CriaVar(aHeaderC[_ni,2])
	Next
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Itens do Parcelamento                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aIteParc := {{cTod(""),0}}
	
	cTipAva  := "2"
	cOpeMov2 := if(VS1->VS1_NOROUT=="0","1","2")
	
	FG_AVALRES()
	
Elseif cTipoNF == "O"
	
	cSimVda := "S"
	
	lIndividual := FM_SQL("SELECT COUNT(*) FROM " + RetSQLName("VOO") + " WHERE VOO_FILIAL = '" + xFilial("VOO") + "' AND VOO_NUMNFI = '" + SF2->F2_DOC + "' AND VOO_SERNFI = '" + SF2->F2_SERIE + "' AND D_E_L_E_T_ = ' '") == 1 
	
	If lIndividual
		
		cTipAva := "4"
		
		If !PERGUNTE("ATDOFI")
			Return .t.
		EndIf
		
		cMapPecas := Mv_Par01
		cMapSrvcs := Mv_Par02
		cMapOdSrv := Mv_Par03
		
		cOutMoed := GetMv("MV_SIMB"+Alltrim(GetMv("MV_INDMFT")))
		cSimOMoe := Val(Alltrim(GetMv("MV_INDMFT")))
		
		DbSelectArea("VOO")
		DbSetOrder(4)
		DbSeek(xFilial("VOO")+SF2->F2_DOC+SF2->F2_SERIE)
		
		cParPro := "1"
		cContChv:= "VEC_NUMIDE"
		cParTem := ""
		
		//Avaliacao de Pecas
		
		aSomaStru := {}
		cCpoDiv   := "    1"
		lCalcTot  := .f.
		cNumIde   := ""
		
		cSQL := "SELECT R_E_C_N_O_ VECRECNO "
		cSQL +=  " FROM " + RetSQLName("VEC") + " VEC "
		cSQL += " WHERE VEC_FILIAL = '" + xFilial("VEC") + "'"
		cSQL +=   " AND VEC_NUMOSV = '" + VOO->VOO_NUMOSV + "'"
		cSQL +=   " AND VEC_TIPTEM = '" + VOO->VOO_TIPTEM + "'"
		If lLIBVOO
			cSQL +=   " AND VEC_LIBVOO = '" + VOO->VOO_LIBVOO + "'"
		EndIf
		cSQL += " AND D_E_L_E_T_ = ' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cSQL ), cAliasVEC , .F., .T. )
		
		If !(cAliasVEC)->(Eof())
			U_FS_GETVSY(VOO->VOO_NUMOSV,VOO->VOO_TIPTEM,IIf( lLIBVOO , VOO->VOO_LIBVOO , "" ))
		
			VOQ->(DbSetOrder(1))
			
			While !(cAliasVEC)->(Eof())
			
				VEC->(DbGoTo((cAliasVEC)->(VECRECNO)))
				
				DbSelectArea("VOQ")
				VOQ->(dbSeek( xFilial("VOQ") + cMapPecas ))
				
				SB1->(dbSetOrder(7))
				SB1->(dbSeek( xFilial("SB1") + VEC->VEC_GRUITE + VEC->VEC_CODITE ))
				SB1->(dbSetOrder(1))
				
				nPosVet := aScan(aStruP,{|x| x[3]+x[7] == SB1->B1_COD+VOQ_CODIGO})
				ncont := nPosVet
				
				While cMapPecas == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !VOQ->(eof())
						
					If VOQ_INDATI != "1" // Sim
						DbSkip()
						Loop
					Endif
						
					cDescVOQ := IIf( VOQ->VOQ_ANASIN # "0" , Space(7)+VOQ_DESAVA,VOQ_DESAVA )
						
					If nPosVet == 0
						aadd(aStruP,{ VEC->VEC_NUMOSV,,SB1->B1_COD,VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,SB1->B1_GRUPO+" "+SB1->B1_CODITE,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT})
						aadd(aSomaStru,{0,0,0,0,0,0})
					Else
							
						aStruP[nCont,1]  := VEC->VEC_NUMOSV
						aStruP[nCont,2]  := Nil
						aStruP[nCont,3]  := SB1->B1_COD
						aStruP[nCont,4]  := VOQ_CLAAVA
						aStruP[nCont,5]  := cDescVOQ
						aStruP[nCont,6]  := VOQ_ANASIN
						aStruP[nCont,7]  := VOQ_CODIGO
						aStruP[nCont,8]  := VOQ_SINFOR
						aStruP[nCont,9]  := 0
						aStruP[nCont,10] := 0
						aStruP[nCont,11] := SB1->B1_GRUPO+" "+SB1->B1_CODITE
						aStruP[nCont,12] := 0
						aStruP[nCont,13] := 0
						aStruP[nCont,14] := .f.
						aStruP[nCont,15] := VOQ->VOQ_PRIFAI
						aStruP[nCont,16] := VOQ->VOQ_SEGFAI
						aStruP[nCont,17] := VOQ_FUNADI
						aStruP[nCont,18] := VOQ_CODIMF
						aStruP[nCont,19] := dDataBase
						aStruP[nCont,20] := 0
						aStruP[nCont,21] := 0
						
					Endif
					
					nCont++
					
					VOQ->(DbSkip())
					
				Enddo
					
				DbSelectArea("VSY")
				DbSetOrder(1)
				DbSeek(xFilial("VSY")+alltrim(VEC->VEC_NUMIDE)+VEC->VEC_GRUITE+VEC->VEC_CODITE)
	
				DbSelectArea("VEC")
				cNumero := alltrim(VEC->VEC_NUMIDE)
				aStruP := FG_CalcVlrs(aStruP,SB1->B1_COD,cCpoDiv)
					
				If nPosVet == 0
					cCpoDiv := cCpoDiv + "#" + str(len(aStruP)+1,5)
				Endif
				
				VOQ->(DbSetOrder(1))
				VOQ->(dbSeek(xFilial("VOQ") + cMapPecas))
	
				SB1->(dbSetOrder(7))
				SB1->(dbSeek( xFilial("SB1") + VEC->VEC_GRUITE + VEC->VEC_CODITE ))
				SB1->(dbSetOrder(1))
				
				nPosVet := aScan(aStruP,{|x| x[3]+x[7] == SB1->B1_COD+VOQ->VOQ_CODIGO})
				If nPosVet == 0
					nPosVet := 1
				Endif
				
				For n_:=nPosVet to Len(aSomaStru)
					aSomaStru[n_,1] += aStruP[n_,9]
					aSomaStru[n_,3] += aStruP[n_,12]
					aSomaStru[n_,5] += aStruP[n_,20]
				Next
				
				For n_:=1 to Len(aSomaStru)
					aStruP[n_,9]  := aSomaStru[n_,1]
					aStruP[n_,12] := aSomaStru[n_,3]
					aStruP[n_,20] := aSomaStru[n_,5]
				Next
					
				(cAliasVEC)->(DbSkip())
			EndDo
			
			lCalcTot:= .t.
	
			DbSelectArea("VOQ")
			VOQ->(DbSetOrder(1))
			VOQ->(dbSeek( xFilial("VOQ") + cMapPecas ))
				
			While cMapPecas == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !VOQ->(Eof())
					
				If VOQ_INDATI != "1" && Sim
					DbSkip()
					Loop
				Endif
				
				cDescVOQ := IIf(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
				aadd(aStruP,{ VOO->VOO_NUMOSV,,STR0047,;						//Total da Venda
					VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,SB1->B1_GRUPO+" "+SB1->B1_CODITE,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT,.t.})
				
				DbSkip()
				
			EndDo
				
			(cAliasVEC)->(dbGoTop())
			VEC->(DbGoTo((cAliasVEC)->(VECRECNO)))
			dbSelectArea("VEC")
			cNumeroOS := VOO->VOO_NUMOSV
			cNumero   := alltrim(STR0047)
			aStruP    := FG_CalcVlrs(aStruP,STR0047,cCpoDiv)
			cNumeroOS := Nil
			
		EndIf
		(cAliasVEC)->(dbCloseArea())
		dbSelectArea("VEC")
		
		//Avaliacao de Servicos
		aSomaStru := {}
		lCalcTot  := .f.
		cCpoDiv   := "    1"
		
		cSQL := "SELECT R_E_C_N_O_ VSCRECNO "
		cSQL +=  " FROM " + RetSQLName("VSC") + " VSC "
		cSQL += " WHERE VSC_FILIAL = '" + xFilial("VSC") + "'"
		cSQL +=   " AND VSC_NUMOSV = '" + VOO->VOO_NUMOSV + "'"
		cSQL +=   " AND VSC_TIPTEM = '" + VOO->VOO_TIPTEM + "'"
		If lLIBVOO
			cSQL +=   " AND VSC_LIBVOO = '" + VOO->VOO_LIBVOO + "'"
		EndIf
		cSQL += " AND D_E_L_E_T_ = ' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cSQL ), cAliasVSC , .F., .T. )
		
		If !(cAliasVSC)->(Eof())
			U_FS_GETVSZ(VOO->VOO_NUMOSV,VOO->VOO_TIPTEM,IIf( lLIBVOO , VOO->VOO_LIBVOO , "" ))
		
			VOQ->(DbSetOrder(1))
			
			While !(cAliasVSC)->(Eof())
	
				VSC->(DbGoTo((cAliasVSC)->VSCRECNO))
	
				DbSelectArea("VOQ")
				VOQ->(dbSeek( xFilial("VOQ") + cMapSrvcs ))
				nPosVet := aScan(aStruS,{|x| x[3]+x[7] == VSC->VSC_CODSER+VOQ_CODIGO})
				nCont := nPosVet
					
				While cMapSrvcs == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !VOQ->(eof())
						
					If VOQ_INDATI != "1" && Sim
						DbSkip()
						Loop
					Endif
						
					cDescVOQ := IIf(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
						
					If nPosVet == 0
						aAdd(aStruS,{ VSC->VSC_NUMOSV,,VSC->VSC_CODSER,;
							VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,VSC->VSC_CODSER,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT})
						aAdd(aSomaStru,{0,0,0,0,0,0})
					Else
						aStruS[nCont,1]  := VSC->VSC_NUMOSV
						aStruS[nCont,2]  := Nil
						aStruS[nCont,3]  := VSC->VSC_CODSER
						aStruS[nCont,4]  := VOQ_CLAAVA
						aStruS[nCont,5]  := cDescVOQ
						aStruS[nCont,6]  := VOQ_ANASIN
						aStruS[nCont,7]  := VOQ_CODIGO
						aStruS[nCont,8]  := VOQ_SINFOR
						aStruS[nCont,9]  := 0
						aStruS[nCont,10] := 0
						aStruS[nCont,11] := VSC->VSC_CODSER
						aStruS[nCont,12] := 0
						aStruS[nCont,13] := 0
						aStruS[nCont,14] := .f.
						aStruS[nCont,15] := VOQ->VOQ_PRIFAI
						aStruS[nCont,16] := VOQ->VOQ_SEGFAI
						aStruS[nCont,17] := VOQ_FUNADI
						aStruS[nCont,18] := VOQ_CODIMF
						aStruS[nCont,19] := dDataBase
						aStruS[nCont,20] := 0
						aStruS[nCont,21] := 0
					Endif
					
					nCont ++
					
					DbSkip()
					
				EndDo
					
				DbSelectArea("VSZ")
				DbSetOrder(1)
				DbSeek(xFilial("VSZ")+Substr(VSC->VSC_NUMIDE,3)+VSC->VSC_CODSER+VSC->VSC_NUMOSV)
					
				DbSelectArea("VSC")
				cNumero := Substr(VSC->VSC_NUMIDE,3)
				aStruS  := FG_CalcVlrs(aStruS,VSC->VSC_CODSER,cCpoDiv)
					
				If nPosVet == 0
					cCpoDiv := cCpoDiv + "#" + str(len(aStruS)+1,5)
				Endif
	
				VOQ->(DbSetOrder(1))
				VOQ->(dbSeek(xFilial("VOQ") + cMapSrvcs))
				
				nPosVet := aScan(aStruS,{|x| x[3]+x[7] == VSC->VSC_CODSER+VOQ->VOQ_CODIGO})
				If nPosVet == 0
					nPosVet := 1
				Endif
				
				For n_:=nPosVet to Len(aSomaStru)
					aSomaStru[n_,1] += aStruS[n_,9]
					aSomaStru[n_,3] += aStruS[n_,12]
					aSomaStru[n_,5] += aStruS[n_,20]
				Next
				
				For n_:=1 to Len(aSomaStru)
					aStruS[n_,9]  := aSomaStru[n_,1]
					aStruS[n_,12] := aSomaStru[n_,3]
					aStruS[n_,20] := aSomaStru[n_,5]
				Next
				
				(cAliasVSC)->(dbSkip())
				
			EndDo
				
			lCalcTot:= .t.
				
			DbSelectArea("VOQ")
			VOQ->(DbSetOrder(1))
			VOQ->(dbSeek(xFilial("VOQ") + cMapSrvcs))
				
			while cMapSrvcs == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
					
				If VOQ_INDATI != "1" && Sim
					DbSkip()
					Loop
				Endif
				
				cDescVOQ := IIf(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
				aadd(aStruS,{ VSC->VSC_NUMOSV,,STR0047,;
					VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,VSC->VSC_CODSER,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT,.t.})
	
				DbSkip()
				
			EndDo
			
			(cAliasVSC)->(dbGoTop())
			VSC->(DbGoTo((cAliasVSC)->(VSCRECNO)))
			DbSelectArea("VSC")
			cNumeroOS := VSC->VSC_NUMOSV
			aStruS    := FG_CalcVlrs(aStruS,STR0047,cCpoDiv)
			cNumeroOS := Nil
			
		EndIf
		(cAliasVSC)->(dbCloseArea())
		DbSelectArea("VSC")
		
		//Avaliacao da Ordem de Servico
		aSomaStru := {}
		cCpoDiv   := "    1"
		
		cSQL := "SELECT R_E_C_N_O_ VECRECNO "
		cSQL +=  " FROM " + RetSQLName("VEC") + " VEC "
		cSQL += " WHERE VEC_FILIAL = '" + xFilial("VEC") + "'"
		cSQL +=   " AND VEC_NUMOSV = '" + VOO->VOO_NUMOSV + "'"
		cSQL +=   " AND VEC_TIPTEM = '" + VOO->VOO_TIPTEM + "'"
		If lLIBVOO
			cSQL +=   " AND VEC_LIBVOO = '" + VOO->VOO_LIBVOO + "'"
		EndIf
		cSQL += " AND D_E_L_E_T_ = ' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cSQL ), cAliasVEC , .F., .T. )
		
		While !(cAliasVEC)->(Eof())
		
			VEC->(dbGoTo( (cAliasVEC)->(VECRECNO) ))

			DbSelectArea("VOQ")
			VOQ->(DbSetOrder(1))
			VOQ->(dbSeek( xFilial("VOQ") + cMapOdSrv ))
				
			while cMapOdSrv == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
					
				If VOQ_INDATI != "1" && Sim
					DbSkip()
					Loop
				Endif
				
				SB1->(dbSetOrder(7))
				SB1->(dbSeek( xFilial("SB1") + VEC->VEC_GRUITE + VEC->VEC_CODITE ))
				SB1->(dbSetOrder(1))
				
				cDescVOQ := IIf(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
					
				aadd(aStruO,{ VEC->VEC_NUMOSV,,SB1->B1_COD,;
					VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,SB1->B1_GRUPO+" "+SB1->B1_CODITE,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT})
					
				DbSkip()
					
			Enddo
				
			DbSelectArea("VEC")
			cNumero   := alltrim(VEC->VEC_NUMIDE)
			cNumeroOS := VEC->VEC_NUMOSV
			aStruO    := FG_CalcVlrs(aStruO,SB1->B1_GRUPO+" "+SB1->B1_CODITE,cCpoDiv)
			cNumeroOS := Nil
			cCpoDiv   := cCpoDiv + "#" + str(len(aStruO)+1,5)
			
			(cAliasVEC)->(DbSkip())
				
		EndDo
		(cAliasVEC)->(DbCloseArea())
		DbSelectArea("VEC")

		cSQL := "SELECT R_E_C_N_O_ VSCRECNO "
		cSQL +=  " FROM " + RetSQLName("VSC") + " VSC "
		cSQL += " WHERE VSC_FILIAL = '" + xFilial("VSC") + "'"
		cSQL +=   " AND VSC_NUMOSV = '" + VOO->VOO_NUMOSV + "'"
		cSQL +=   " AND VSC_TIPTEM = '" + VOO->VOO_TIPTEM + "'"
		If lLIBVOO
			cSQL +=   " AND VSC_LIBVOO = '" + VOO->VOO_LIBVOO + "'"
		EndIf
		cSQL += " AND D_E_L_E_T_ = ' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cSQL ), cAliasVSC , .F., .T. )

		While !(cAliasVSC)->(Eof())
			
			DbSelectArea("VSC")
			VSC->(DbGoTo((cAliasVSC)->(VSCRECNO)))
			
			DbSelectArea("VOQ")
			dbSetOrder(1)
			VOQ->(dbSeek(xFilial("VOQ") + cMapOdSrv ))
				
			While cMapOdSrv == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
					
				If VOQ_INDATI != "1" && Sim
					DbSkip()
					Loop
				Endif
					
				cDescVOQ := IIf(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
				aadd(aStruO,{ VSC->VSC_NUMOSV,,VSC->VSC_CODSER,;
					VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,VSC->VSC_CODSER,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT})
				
				DbSkip()
				
			Enddo
				
			DbSelectArea("VSC")
			cNumero := Substr(VSC->VSC_NUMIDE,3)
			aStruO := FG_CalcVlrs(aStruO,VSC->VSC_CODSER,cCpoDiv)
			cCpoDiv := cCpoDiv + "#" + str(len(aStruO)+1,5)
				
			(cAliasVSC)->(DbSkip())
				
		EndDo
		(cAliasVSC)->(dbGoTop())
		VSC->(DbGoTo((cAliasVSC)->(VSCRECNO)))
		(cAliasVSC)->(DbCloseArea())
		
		lCalcTot:= .t.
		
		DbSelectArea("VOQ")
		dbSetOrder(1)
		dbSeek( xFilial("VOQ") + cMapOdSrv )
		
		While cMapOdSrv == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
			
			If VOQ_INDATI != "1" && Sim
				DbSkip()
				Loop
			Endif
			
			cDescVOQ := IIf(VOQ->VOQ_ANASIN#"0" , Space(7)+VOQ_DESAVA , VOQ_DESAVA)
			aadd(aStruO,{ VOO->VOO_NUMOSV,,STR0047,;
				VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,VSC->VSC_CODSER,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT,.t.})
			
			DbSkip()
			
		EndDo
		
		DbSelectArea("VSC")
		cNumeroOS := VSC->VSC_NUMOSV
		aStruO    := FG_CalcVlrs(aStruO,STR0047,cCpoDiv)
		cNumeroOS := Nil
		FG_ResAva(cOutMoed,3,"S","","OFIOM160",{aStruP,aStruS,aStruO})
		For i:=1 to Len(aNewBot)
			Private cFunc&(alltrim(Str(i))) := aNewBot[i,2]
		Next
		
	Else // Agrupada
		
		cTipAva := "4"
		
		If !PERGUNTE("ATDOFI")
			Return .t.
		EndIf
		
		cMapPecas := Mv_Par01
		cMapSrvcs := Mv_Par02
		cMapOdSrv := Mv_Par03
		
		cOutMoed := GetMv("MV_SIMB"+Alltrim(GetMv("MV_INDMFT")))
		cSimOMoe := Val(Alltrim(GetMv("MV_INDMFT")))
		
		DbSelectArea("VOO")
		DbSetOrder(4)
		DbSeek(xFilial("VOO")+SF2->F2_DOC+SF2->F2_SERIE)
		
		// CriaVSY a partir do VEC
		FG_SEEK("VEC","VOO->VOO_NUMNFI",4,.f.)
		U_FS_VSY_A(VOO->VOO_NUMNFI)
		
		cParPro := "1"
		cContChv:= "VEC_NUMNFI"
		cParTem := ""
		
		//Avaliacao de Pecas
		
		cCpoDiv   := "    1"
		lCalcTot  := .f.
		cNumIde   := ""
		lSoUmaVez := .t.
		
		If FG_SEEK("VEC","VOO->VOO_NUMNFI",4,.f.)
			
			DbSelectArea("VEC")
			DbSetOrder(4)
			
			lPriVezAgr := .t.
			While VEC->VEC_NUMNFI == VOO->VOO_NUMNFI .and. VEC->VEC_FILIAL == xFilial("VEC") .and. !eof()
				
				DbSelectArea("VOQ")
				FG_Seek("VOQ","cMapPecas",1,.f.)
				FG_SEEK("SB1","VEC->VEC_GRUITE+VEC->VEC_CODITE",7,.f.)
				nPosVet := aScan(aStruP,{|x| x[3]+x[7] == SB1->B1_COD+VOQ_CODIGO})
				aSomaStru := {}
				ncont := nPosVet
				nCC   := 0
				
				while cMapPecas == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
					
					If VOQ_INDATI != "1" && Sim
						DbSkip()
						Loop
					Endif
					
					cDescVOQ :=if(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
					
					If nPosVet == 0
						aadd(aStruP,{ VEC->VEC_NUMNFI,,SB1->B1_COD,;
						VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,SB1->B1_GRUPO+" "+SB1->B1_CODITE,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT})
					Else
						
						aAdd(aSomaStru,{aStruP[nPosVet+nCC,9],aStruP[nPosVet+nCC,12],aStruP[nPosVet+nCC,20]})
						nCC++
						
					Endif
					
					nCont++
					
					DbSkip()
					
				Enddo
				
				If lSoUmaVez
					nSvTam := Len(aStruP)
					lSoUmaVez := .f.
				Endif
				
				DbSelectArea("VSY")
				DbSetOrder(1)
				DbSeek(xFilial("VSY")+alltrim(VEC->VEC_NUMIDE)+VEC->VEC_GRUITE+VEC->VEC_CODITE)
				
				If nPosVet == 0 .and. !lPrivezAgr
					cCpoDiv := cCpoDiv + "#" + str(Len(aStruP)-nSvTam+1,5)
				Else
					lPriVezAgr := .f.
				Endif
				
				DbSelectArea("VEC")
				cNumero := alltrim(VEC->VEC_NUMNFI)
				aStruP := FG_CalcVlrs(aStruP,SB1->B1_COD,cCpoDiv)
				
				If Len(aSomaStru) > 1
					Ni := 0
					For n_:=nPosVet to nPosVet+Len(aSomaStru)-1
						ni++
						aStruP[n_,09] += aSomaStru[ni,1]
						aStruP[n_,12] += aSomaStru[ni,2]
						aStruP[n_,20] += aSomaStru[ni,3]
					Next
				Endif
				
				DbSkip()
				
			EndDo
			
			FG_SEEK("VEC","VOO->VOO_NUMNFI",4,.f.)
			lCalcTot:= .t.
			nITot := Len(aStruP)+1
			DbSelectArea("VOQ")
			FG_Seek("VOQ","cMapPecas",1,.f.)
			
			While cMapPecas == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
				
				If VOQ_INDATI != "1" && Sim
					DbSkip()
					Loop
				Endif
				
				cDescVOQ :=if(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
				aadd(aStruP,{ VEC->VEC_NUMNFI,,STR0047,; //Total da Venda
				VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,SB1->B1_GRUPO+" "+SB1->B1_CODITE,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT,.t.})
				
				DbSkip()
				
			EndDo
			
			cNumeroOS := VEC->VEC_NUMNFI
			cNumero   := alltrim(STR0047)
			nStep     := Val(Subs(cCpoDiv,7,5))-1
			nCtFor    := 1
			lPrivez   := .t.
			// Totaliza OS Agrupada
			For nT := nItot to Len(aStruP)
				for iAg := nCtFor to Len(aStruP) step nStep
					// 	          If iAg+nStep >= nItot+1
					If iAg+nStep >= Len(aStruP)
						exit
					Endif
					aStruP[nT,09] := aStruP[nT,09] + aStruP[iAg,09]
					aStruP[nT,12] := aStruP[nT,12] + aStruP[iAg,12]
					aStruP[nT,20] := aStruP[nT,20] + aStruP[iAg,20]
				Next
				If lPrivez
					lPrivez := .f.
					nTotPecR := aStruP[nItot,09]
					nTotPecM := aStruP[nItot,12]
					nTotPecp := aStruP[nItot,20]
				Endif
				aStruP[nt,10] :=( aStruP[nt,09] / nTotPecR ) * 100
				aStruP[nt,13] :=( aStruP[nt,12] / nTotPecM ) * 100
				aStruP[nt,21] :=( aStruP[nt,20] / nTotPecP ) * 100
				nCtFor++
			Next
			cNumeroOS := Nil
			
		EndIf
		
		
		//Avaliacao de Servicos
		
		aSomaStru := {}
		lCalcTot  := .f.
		cCpoDiv   := "    1"
		
		// CriaVSZ a partir do VSC
		FG_SEEK("VSC","VOO->VOO_NUMNFI",6,.f.)
		U_FS_VSZ_A(VOO->VOO_NUMNFI)
		lSoUmaVez := .t.
		
		If FG_SEEK("VSC","VOO->VOO_NUMNFI",6,.f.)
			
			DbSelectArea("VSC")
			DbSetOrder(6)
			
			lPriVezAgr := .t.
			While  VOO->VOO_NUMNFI == VSC_NUMNFI .and. VSC->VSC_FILIAL == xFilial("VSC") .and. !eof()
				
				aSomaStru := {}
				DbSelectArea("VOQ")
				FG_Seek("VOQ","cMapSrvcs",1,.f.)
				nPosVet := aScan(aStruS,{|x| x[3]+x[7] == VSC->VSC_CODSER+VOQ_CODIGO})
				nCont := nPosVet
				nCC   := 0
				
				While cMapSrvcs == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
					
					If VOQ_INDATI != "1" && Sim
						DbSkip()
						Loop
					Endif
					
					cDescVOQ :=if(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
					
					If nPosVet == 0
						aAdd(aStruS,{ VSC->VSC_NUMOSV,,VSC->VSC_CODSER,;
						VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,VSC->VSC_CODSER,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT})
					Else
						aAdd(aSomaStru,{aStruS[nPosVet+nCC,9],aStruS[nPosVet+nCC,12],aStruS[nPosVet+nCC,20]})
						nCC++
					Endif
					
					nCont ++
					
					DbSkip()
					
				EndDo
				
				If lSoUmaVez
					nSvTam := Len(aStruS)
					lSoUmaVez := .f.
				Endif
				
				DbSelectArea("VSZ")
				DbSetOrder(1)
				DbSeek(xFilial("VSZ")+Substr(VSC->VSC_NUMIDE,3)+VSC->VSC_CODSER+VSC->VSC_NUMOSV)
				
				If nPosVet == 0 .and. !lPrivezAgr
					cCpoDiv := cCpoDiv + "#" + str(Len(aStruS)-nSvTam+1,5)
				Else
					lPriVezAgr := .f.
				Endif
				
				DbSelectArea("VSC")
				cNumero := VSC->VSC_NUMNFI
				aStruS  := FG_CalcVlrs(aStruS,VSC->VSC_CODSER,cCpoDiv)
				
				If len(aSomaStru) > 1
					Ni := 0
					For n_:=nPosVet to nPosVet+Len(aSomaStru)-1
						ni++
						aStruS[n_,09] += aSomaStru[ni,1]
						aStruS[n_,12] += aSomaStru[ni,2]
						aStruS[n_,20] += aSomaStru[ni,3]
					Next
				Endif
				
				DbSelectArea("VSC")
				dbSkip()
				
			EndDo
			
			lCalcTot:= .t.
			nITot := Len(aStruS)+1
			
			DbSelectArea("VOQ")
			FG_SEEK("VOQ","cMapSrvcs",1,.f.)
			
			while cMapSrvcs == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
				
				If VOQ_INDATI != "1" && Sim
					DbSkip()
					Loop
				Endif
				
				cDescVOQ :=if(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
				aadd(aStruS,{ VSC->VSC_NUMOSV,,STR0047,;
				VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,VSC->VSC_CODSER,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT,.t.})
				DbSkip()
				
			EndDo
			
			FG_SEEK("VSC","VOO->VOO_NUMNFI",6,.f.)
			cNumeroOS := VSC->VSC_NUMOSV
			nStep     := Val(Subs(cCpoDiv,7,5))-1
			nCtFor    := 1
			lPrivez   := .t.
			// Totaliza OS
			For nT := nItot to Len(aStruS)
				for iAg := nCtFor to Len(aStruS) step nStep
					// 	          If iAg+nStep >= nItot+1
					If iAg+nStep > Len(aStruS)
						exit
					Endif
					aStruS[nT,09] := aStruS[nT,09] + aStruS[iAg,09]
					aStruS[nT,12] := aStruS[nT,12] + aStruS[iAg,12]
					aStruS[nT,20] := aStruS[nT,20] + aStruS[iAg,20]
				Next
				If lPrivez
					lPrivez := .f.
					nTotSrvR := aStruS[nItot,09]
					nTotSrvM := aStruS[nItot,12]
					nTotSrvp := aStruS[nItot,20]
				Endif
				aStruS[nt,10] :=( aStruS[nt,09] / nTotSrvR ) * 100
				aStruS[nt,13] :=( aStruS[nt,12] / nTotSrvM ) * 100
				aStruS[nt,21] :=( aStruS[nt,20] / nTotSrvP ) * 100
				nCtFor++
			Next
			
			cNumeroOS := Nil
			
		EndIf
		
		
		/////////////////////////////////////////////////////////////////
		
		/////////////////////////////////////////////////////////////////
		
		
		// Avaliacao da Ordem Agrupada
		
		aSomaStru := {}
		aStruO    := {}
		cCpoDiv   := "    1"
		lCalcTot  := .t.
		nNumOsv   := Space(10)
		aVetOS    := {}
		lSoUmaVez := .t.
		
		If FG_SEEK("VEC","VOO->VOO_NUMNFI",4,.f.)
			
			DbSelectArea("VEC")
			
			lPriVezAgr := .t.
			While VEC->VEC_NUMNFI == VOO->VOO_NUMNFI .and. VEC->VEC_FILIAL == xFilial("VEC") .and. !eof()
				
				If aScan(aVetOS,VEC->VEC_NUMOSV) > 0
					DbSkip()
					Loop
				Endif
				
				DbSelectArea("VOQ")
				FG_Seek("VOQ","cMapOdSrv",1,.f.)
				
				aSomaStru := {}
				nPosVet := aScan(aStruO,{|x| x[1] == VEC->VEC_NUMNFI})
				nCont := nPosVet
				nCC   := 0
				
				while cMapOdSrv == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
					
					If VOQ_INDATI != "1" && Sim
						DbSkip()
						Loop
					Endif
					
					FG_SEEK("SB1","VEC->VEC_GRUITE+VEC->VEC_CODITE",7,.f.)
					
					cDescVOQ :=if(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
					
					If nPosVet == 0
						aadd(aStruO,{ VEC->VEC_NUMNFI,,STR0047,;
						VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,SB1->B1_GRUPO+" "+SB1->B1_CODITE,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,dDataBase,0,0,VOQ_CTATOT,.t.})
					Else
						aAdd(aSomaStru,{aStruO[nPosVet+nCC,9],aStruO[nPosVet+nCC,12],aStruO[nPosVet+nCC,20]})
						nCC++
					Endif
					
					DbSkip()
					
				Enddo
				
				If lSoUmaVez
					nSvTam := Len(aStruO)
					lSoUmaVez := .f.
				Endif
				
				DbSelectArea("VSY")
				DbSetOrder(1)
				DbSeek(xFilial("VSY")+alltrim(VEC->VEC_NUMIDE)+VEC->VEC_GRUITE+VEC->VEC_CODITE)
				
				If nPosVet == 0 .and. !lPrivezAgr
					cCpoDiv := cCpoDiv + "#" + str(Len(aStruO)-nSvTam+1,5)
				Else
					lPriVezAgr := .f.
				Endif
				
				cNumero := alltrim(VEC->VEC_NUMNFI)
				cNumeroOS := VEC->VEC_NUMOSV
				aStruO    := FG_CalcVlrs(aStruO,STR0047,cCpoDiv)
				
				If Len(aSomaStru) > 1
					Ni := 0
					For n_:=nPosVet to nPosVet+Len(aSomaStru)-1
						ni++
						aStruO[n_,09] += aSomaStru[ni,1]
						aStruO[n_,12] += aSomaStru[ni,2]
						aStruO[n_,20] += aSomaStru[ni,3]
					Next
				Endif
				
				aadd(aVetOs,VEC->VEC_NUMOSV)
				
				DbSelectArea("VEC")
				DbSkip()
				
			EndDo
			
		EndIf
		
		
		If FG_SEEK("VSC","VOO->VOO_NUMNFI",6,.f.)
			
			DbSelectArea("VSC")
			aSomaStru := {}
			
			While VSC->VSC_NUMNFI == VOO->VOO_NUMNFI .and. VSC->VSC_FILIAL == xFilial("VEC") .and. !eof()
				
				
				If aScan(aVetOS,VSC->VSC_NUMOSV) > 0
					DbSkip()
					Loop
				Endif
				
				
				DbSelectArea("VOQ")
				FG_Seek("VOQ","cMapOdSrv",1,.f.)
				
				nCC   := 1
				
				while cMapOdSrv == VOQ->VOQ_CODMAP .and. VOQ->VOQ_FILIAL == xFilial("VOQ") .and. !eof()
					
					If VOQ_INDATI != "1" && Sim
						DbSkip()
						Loop
					Endif
					
					aAdd(aSomaStru,{aStruO[nCC,9],aStruO[nCC,12],aStruO[nCC,20]})
					nCC++
					
					DbSkip()
					
				Enddo
				
				DbSelectArea("VSZ")
				DbSetOrder(1)
				DbSeek(xFilial("VSZ")+Substr(VSC->VSC_NUMIDE,3)+VSC->VSC_CODSER+VSC->VSC_NUMOSV)
				
				DbSelectArea("VSC")
				
				cNumero   := VSC->VSC_NUMOSV
				cNumeroOS := VSC->VSC_NUMOSV
				aStruO  := FG_CalcVlrs(aStruO,STR0047,cCpoDiv)
				
				If nPosVet > 0
					Ni := 0
					For n_:=nPosVet to nPosVet+Len(aSomaStru)-1
						ni++
						aStruO[n_,09] += aSomaStru[ni,1]
						aStruO[n_,12] += aSomaStru[ni,2]
						aStruO[n_,20] += aSomaStru[ni,3]
					Next
				Endif
				
				aadd(aVetOS,VSC->VSC_NUMOSV)
				
				DbSelectArea("VSC")
				dbSkip()
				
			Enddo
			
		EndIf
		
		FG_ResAva(cOutMoed,3,"S","","OFIOM160",{aStruP,aStruS,aStruO})
		For i:=1 to Len(aNewBot)
			Private cFunc&(alltrim(Str(i))) := aNewBot[i,2]
		Next
		
	Endif
	
Else
	
	// Veiculos
	
	cTipAva := "1"
	
	If !Pergunte("LIBVEI")
		Return .t.
	EndIf
	cCodMap  := Mv_Par01
	cOutMoed := GetMv("MV_SIMB"+Alltrim(GetMv("MV_INDMFT")))
	cSimOMoe := Val(Alltrim(GetMv("MV_INDMFT")))
	
	DbSelectArea("VV0")
	DbSetOrder(4)
	DbSeek(xFilial("VV0")+SF2->F2_DOC+SF2->F2_SERIE)
	
	DbSelectArea("VVA")
	DbSetOrder(1)
	DbSeek(xFilial("VVA")+VV0->VV0_NUMTRA)
	
	DbSelectArea("VV1")
	DbSetOrder(2)
	DbSeek(xFilial("VV1")+VVA->VVA_CHASSI)
	
	FG_DesVei(VV1->VV1_TRACPA,VV1->VV1_CHAINT,"D",,VV1->VV1_FILENT,If(lVV0_MOEDA,VV0->VV0_MOEDA,))
	FG_DesVei(VV1->VV1_TRACPA,VV1->VV1_CHAINT,"R",,VV1->VV1_FILENT,If(lVV0_MOEDA,VV0->VV0_MOEDA,))
	
	aStru   := {}
	cTipAva := "1"
	cCpoDiv := "    1"
	cTipFat := VV0->VV0_TIPFAT
	lCarBott:= .t.
	cSimVda := "V"
	
	DbSelectArea("VS5")
	FG_Seek("VS5","cCodMap",1,.f.)
	
	DbSelectArea("VOQ")
	FG_Seek("VOQ","cCodMap",1,.f.)
	
	while !eof() .and. VOQ->VOQ_FILIAL == xFilial("VOQ")
		
		If !(cTipFat $ VOQ_TIPFAT)
			DbSkip()
			Loop
		Endif
		
		If VOQ_INDATI # "1" && Sim
			DbSkip()
			Loop
		Endif
		
		If VOQ_CODMAP # cCodMap
			Exit
		Endif
		
		cDescVOQ :=if(VOQ->VOQ_ANASIN#"0",Space(7)+VOQ_DESAVA,VOQ_DESAVA)
		aadd(aStru,{ VV0->VV0_NUMTRA,VV1->VV1_TRACPA,VV1->VV1_CHAINT,;
		VOQ_CLAAVA,cDescVOQ,VOQ_ANASIN,VOQ_CODIGO,VOQ_SINFOR,0,0,VV1->VV1_CHASSI,0,0,.f.,VOQ->VOQ_PRIFAI,VOQ->VOQ_SEGFAI,VOQ_FUNADI,VOQ_CODIMF,VV0->VV0_DATMOV,0,0,VOQ_CTATOT})
		
		DbSkip()
		
	Enddo
	
	DbSelectArea("VV0")
	For nCnt := 1 TO FCount()
		cNome := Substr(FieldName(nCnt),5)
		M->&(EVAL(bCampo,nCnt)) := &("VV0->VV0_"+cNome)
	Next
	
	DbSelectArea("VVA")
	For nCnt := 1 TO FCount()
		cNome := Substr(FieldName(nCnt),5)
		M->&(EVAL(bCampo,nCnt)) := &("VVA->VVA_"+cNome)
	Next
	
	FG_CalcVlrs(aStru,VV1->VV1_CHAINT)
	FG_RESAVA(cOutMoed,3,"V","","OFIOM170")
	For i:=1 to Len(aNewBot)
		Private cFunc&(alltrim(Str(i))) := aNewBot[i,2]
	Next
	
Endif

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_GETVSY   ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Validacao no VEC 	                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_GETVSY(cNumOsv,cTipTem,cLIBVOO)

Local bCampo := { |nCPO| Field(nCPO) }
Local aArea  := VEC->(GetArea())
Local nCnt := 0
Local lAchou := .f.
Local cNome := ""
Local cSQL := ""
Local cAuxAlias := GetNextAlias()


cSQL := "SELECT R_E_C_N_O_ VECRECNO "
cSQL +=  " FROM " + RetSQLName("VEC") + " VEC "
cSQL += " WHERE VEC_FILIAL = '" + xFilial("VEC") + "'"
cSQL +=   " AND VEC_NUMOSV = '" + cNumOsv + "'"
cSQL +=   " AND VEC_TIPTEM = '" + cTipTem + "'"
If lLIBVOO
	cSQL +=   " AND VEC_LIBVOO = '" + cLIBVOO + "'"
EndIf
cSQL += " AND D_E_L_E_T_ = ' '"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cSQL ), cAuxAlias , .F., .T. )

DbSelectArea("VSY")
DbSetOrder(2)
		
While !(cAuxAlias)->(Eof())

	VEC->(dbGoTo((cAuxAlias)->VECRECNO))

	DbSelectArea("VSY")
	If lLIBVOO
		lAchou := DbSeek(xFilial("VSY")+alltrim(VEC->VEC_NUMOSV)+VEC->VEC_GRUITE+VEC->VEC_CODITE+VEC->VEC_LIBVOO)
	Else
		lAchou := DbSeek(xFilial("VSY")+alltrim(VEC->VEC_NUMOSV)+VEC->VEC_GRUITE+VEC->VEC_CODITE)
	Endif
	
	RecLock("VSY",!lAchou)
	For nCnt := 1 TO FCount()
		cNome := Substr(FieldName(nCnt),5)
		VSY->&(EVAL(bCampo,nCnt)) := &("VEC->VEC_"+cNome)
	Next
	MsUnlock()
	
	(cAuxAlias)->(DbSkip())

Enddo
(cAuxAlias)->(DbCloseArea())

dbSelectArea("VEC")
VEC->(RestArea(aArea))

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_GETVSZ  ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Validacao no VSC 	                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_GETVSZ(cNumOsv,cTipTem,cLIBVOO)

Local bCampo := { |nCPO| Field(nCPO) }
Local aArea  := VSC->(GetArea())
Local nCnt := 0
Local lAchou := .f.
Local cNome := ""
Local cSQL := ""
Local cAuxAlias := GetNextAlias()

cSQL := "SELECT R_E_C_N_O_ VSCRECNO "
cSQL +=  " FROM " + RetSQLName("VSC") + " VSC "
cSQL += " WHERE VSC_FILIAL = '" + xFilial("VSC") + "'"
cSQL +=   " AND VSC_NUMOSV = '" + cNumOsv + "'"
cSQL +=   " AND VSC_TIPTEM = '" + cTipTem + "'"
If lLIBVOO
	cSQL +=   " AND VSC_LIBVOO = '" + cLIBVOO + "'"
EndIf
cSQL += " AND D_E_L_E_T_ = ' '"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cSQL ), cAuxAlias , .F., .T. )

DbSelectArea("VSZ")
DbSetOrder(1)

While !(cAuxAlias)->(Eof())

	VSC->(dbGoTo((cAuxAlias)->VSCRECNO))

	dbSelectArea("VSZ")
	If lLIBVOO
		lAchou := DbSeek(xFilial("VSZ")+Substr(VSC->VSC_NUMIDE,3)+VSC->VSC_CODSER+VSC->VSC_NUMOSV+VSC->VSC_LIBVOO)
	Else
		lAchou := DbSeek(xFilial("VSZ")+Substr(VSC->VSC_NUMIDE,3)+VSC->VSC_CODSER+VSC->VSC_NUMOSV)
	EndIf
	RecLock("VSZ",!lAchou)
	For nCnt := 1 TO FCount()
		cNome := Substr(FieldName(nCnt),5)
		if cNome = "NUMIDE"
			VSZ->&(EVAL(bCampo,nCnt)) := Substr(&("VSC->VSC_"+cNome),3)
		Else
			VSZ->&(EVAL(bCampo,nCnt)) := &("VSC->VSC_"+cNome)
		Endif
	Next
	MsUnlock()
	(cAuxAlias)->(DbSkip())
Enddo

(cAuxAlias)->(DbCloseArea())
dbSelectArea("VSC")

VSC->(RestArea(aArea))

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_MEMO    ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Memo				 	                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_MEMO()


if nModulo == 11 //Veiculo
	
	Private aMemos  := {{"VVA_OBSMEM","VVA_OBSERV"}}
	Private oFonte  := TFont():New( "Arial", 8,13 )
	
	dbSelectArea("VV0")
	dbSetOrder(4)
	dbSeek(xFilial("VV0")+SF2->F2_DOC+SF2->F2_SERIE)
	
	dbSelectArea("VVA")
	dbSetOrder(1)
	dbSeek(xFilial("VVA")+VV0->VV0_NUMTRA)
	
	//cObserv := MSMM(VS6->VS6_OBSMEM,TamSx3("VS6_OBSERV")[1])    //Cria um Memo em Branco
	cObserv := E_MSMM(VVA->VVA_OBSMEM,68)
	
	DEFINE MSDIALOG oDlg1 TITLE OemtoAnsi(STR0048) FROM  02,04 TO 14,56 OF oMainWnd
	
	DEFINE SBUTTON FROM 076,137 TYPE 1 ACTION (oDlg1:End()) ENABLE OF oDlg1
	DEFINE SBUTTON FROM 076,168 TYPE 2 ACTION (oDlg1:End()) ENABLE OF oDlg1
	
	@ 01,011 GET oObserv VAR cObserv OF oDlg1 MEMO SIZE 182,67 PIXEL
	oObserv:oFont := oFonte
	oObserv:bRClicked := {|| AllwaysTrue() }
	oObserv:SetFocus()
	
	ACTIVATE MSDIALOG oDlg1 CENTER
	
Endif

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_PSQ370   ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Pesquisa no SF2   	                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_PSQ370()

axPesqui()

DbSelectArea("SF2")
DbSetOrder(nIndexSF2+1)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_VSY_A    ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Busca ou cria VSY - OS Agrupada                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_VSY_A(cSeek) // Busca ou cria VSY - OS Agrupada

Local bCampo := { |nCPO| Field(nCPO) }
Local aArea  := VEC->(GetArea())
Local nCnt := 0
Local lAchou := .f.
Local cNome := ""

DbSelectArea("VEC")
DbSetOrder(4)
DbSeek(xFilial("VEC")+cSeek)

//While !Eof() .and. VEC->VEC_NUMOSV+VEC->VEC_TIPTEM == cSeek .and. VEC->VEC_FILIAL == xFilial("VEC")
While !Eof() .and. VEC->VEC_NUMNFI == cSeek .and. VEC->VEC_FILIAL == xFilial("VEC")
	DbSelectArea("VSY")
	DbSetOrder(1)
	lAchou := DbSeek(xFilial("VSY")+alltrim(VEC->VEC_NUMIDE)+VEC->VEC_GRUITE+VEC->VEC_CODITE)
	RecLock("VSY",!lAchou)
	For nCnt := 1 TO FCount()
		cNome := Substr(FieldName(nCnt),5)
		VSY->&(EVAL(bCampo,nCnt)) := &("VEC->VEC_"+cNome)
	Next
	MsUnlock()
	DbSelectArea("VEC")
	DbSkip()
Enddo

VEC->(RestArea(aArea))

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_VSZ_A    ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Busca ou cria VSZ - OS Agrupada                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_VSZ_A(cSeek) // Busca ou cria VSZ - OS Agrupada

Local bCampo := { |nCPO| Field(nCPO) }
Local aArea  := VSC->(GetArea())
Local nCnt := 0
Local cNome := ""

DbSelectArea("VSC")
DbSetOrder(6)
DbSeek(xFilial("VSC")+cSeek)

While !Eof() .and. VSC->VSC_NUMNFI == cSeek .and. VSC->VSC_FILIAL == xFilial("VSC")
	//While !Eof() .and. VSC->VSC_NUMOSV+VSC->VSC_TIPTEM == cSeek .and. VSC->VSC_FILIAL == xFilial("VSC")
	DbSelectArea("VSZ")
	DbSetOrder(1)
	lAchou := DbSeek(xFilial("VSZ")+Substr(VSC->VSC_NUMIDE,3)+VSC->VSC_CODSER+VSC->VSC_NUMOSV)
	RecLock("VSZ",(!lAchou.or.Substr(VSC->VSC_NUMIDE,3)#VSZ->VSZ_NUMIDE))
	For nCnt := 1 TO FCount()
		cNome := Substr(FieldName(nCnt),5)
		if cNome = "NUMIDE"
			VSZ->&(EVAL(bCampo,nCnt)) := Substr(&("VSC->VSC_"+cNome),3)
		Else
			VSZ->&(EVAL(bCampo,nCnt)) := &("VSC->VSC_"+cNome)
		Endif
	Next
	MsUnlock()
	DbSelectArea("VSC")
	DbSkip()
Enddo

VSC->(RestArea(aArea))

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FG_ImpResTel³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Imprimir							                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FG_ImpResTel()

Local _i_ := 0 , nTot := 0 , i := 0 , j := 0

If Len(aStruLB) > 1 .and. Len(aStruLBS) > 1 .and. Len(aStruLBO) > 1
	
	If oFolderAva:nOption == 1
		aVetImpress := aClone(aStruLB)
		If aVetImpress[1,3] != STR0047
			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek(xFilial("SB1")+aVetImpress[1,3])
			cItemAvali := STR0049 + Alltrim(SB1->B1_GRUPO) + " " + Alltrim(SB1->B1_CODITE) + "  -  " + Alltrim(SB1->B1_DESC)
		Else
			cItemAvali := STR0050 //"Resultado do Total das Pecas "
		Endif
	ElseIf oFolderAva:nOption == 2
		aVetImpress := aClone(aStruLBS)
		If aVetImpress[1,3] != STR0047
			DbSelectArea("VE4")
			DbSetOrder(1)
			DbSeek(xFilial("VE4"))
			DbSelectArea("VO6")
			DbSetOrder(2)
			DbSeek(xFilial("VO6")+VE4->VE4_PREFAB+aVetImpress[1,11])
			cItemAvali := STR0051 + VO6->VO6_CODSER + "  -  " + VO6->VO6_DESSER
		Else
			cItemAvali := STR0052 //"Resultado do Total dos Servicos "
		Endif
	ElseIf oFolderAva:nOption == 3
		aVetImpress := aClone(aStruLBO)
		If lIndividual
			cItemAvali  :=  STR0053 + SF2->F2_DOC + STR0054 + SF2->F2_SERIE + STR0055 + VOO->VOO_NUMOSV
		Else
			cItemAvali  :=  STR0056 // "Resultado do Total da Os Agrupada "
		Endif
	Endif
	
	If lIndividual
		DbSelectArea("VOO")
		DbSetOrder(4)
		DbSeek(xFilial("VOO")+SF2->F2_DOC+SF2->F2_SERIE)
		cNroNotOs := STR0057 + SF2->F2_DOC + STR0054 + SF2->F2_SERIE + STR0055 + VOO->VOO_NUMOSV
	Else
		cNroNotOs := STR0057 + SF2->F2_DOC + STR0054 + SF2->F2_SERIE + STR0058
	Endif
	
ElseIf Len(aStruLB) > 1
	aVetImpress := aClone(aStruLB)
	If aVetImpress[1,3] != STR0047
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+aVetImpress[1,3])
		cItemAvali := STR0049 + Alltrim(SB1->B1_GRUPO) + " " + Alltrim(SB1->B1_CODITE) + "  -  " + Alltrim(SB1->B1_DESC)
	Else
		cItemAvali := STR0050
	Endif
	cNroNotOs := STR0057 + SF2->F2_DOC + STR0054 + SF2->F2_SERIE
	
ElseIf Len(aStruLBS) > 1
	
	aVetImpress := aClone(aStruLBS)
	If aVetImpress[1,3] != STR0047
		DbSelectArea("VE4")
		DbSetOrder(1)
		DbSeek(xFilial("VE4"))
		DbSelectArea("VO6")
		DbSetOrder(2)
		DbSeek(xFilial("VO6")+VE4->VE4_PREFAB+aVetImpress[1,11])
		cItemAvali := STR0051 + VO6->VO6_CODSER + "  -  " + VO6->VO6_DESSER
	Else
		cItemAvali := STR0052
	Endif
	cNroNotOs := STR0057 + SF2->F2_DOC + STR0054 + SF2->F2_SERIE + STR0055 + VOO->VOO_NUMOSV
ElseIf Len(aStruLBO) > 1
	aVetImpress := aClone(aStruLBO)
	cItemAvali  :=  STR0053
	cNroNotOs := STR0057 + SF2->F2_DOC + STR0054 + SF2->F2_SERIE + STR0055 + VOO->VOO_NUMOSV
Endif

Private cAlias    := "SB1"
Private cDesc1    := STR0059 //"Mapa de Resultado por Item"
Private cDesc2    := ""
Private cDesc3    := ""
Private aRegistros:= {}
Private nLin      := 0
Private cTamanho  := "P"          // P/M/G
Private Tamanho   := "P"          // P/M/G
Private Limite    := 80           // 80/132/220
Private cTitulo   := STR0060 //"Resultado do Item"
Private Titulo    := STR0060
Private cNomeProg := "IMPR_RES"
Private cNomeRel  := "IMPR_RES"
Private nLastKey  := 0
Private nCaracter := 18
Private cabec1    := ""
Private cabec2    := ""
Private lAbortPrint := .f.
Private cString  := "SB1"
Private Li       := 80
Private m_Pag    := 1
Private wnRel    := "IMPR_RES"
Private nPos     := 0
Private ni       := 0
Private oOk      := LoadBitmap( GetResources(), "LBOK" )
Private oNo      := LoadBitmap( GetResources(), "LBNO" )
Private oTik     := LoadBitmap( GetResources(), "LBTIK" )
Private aReturn  := { OemToAnsi(STR0061), 1,OemToAnsi(STR0062), 1, 1, 1, "",2 }		//1-ZEBRADO,2-,3-ADMINISTRACAO,4-1:COMPACTA,2:NAO,5-MIDIA 1:DISCO,6-CRYSTAL,7-,8-ORDEM

Cabec1 := ""
Cabec2 := ""

wnrel:=SetPrint(cString,wnrel,,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho)

If nLastKey == 27
	Set Filter to
	Return
Endif

Set Printer to &wnrel
Set Printer On
Set Device  to Printer

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif

li         := 80
m_pag      := 1
Tamanho    := "G"
limite     := 132
nTipo      := 18
nCaracter  := 18
nomeprog := "IMPR_RES"

wnrel   := "IMPR_RES"

Titulo  := STR0063

cCabec1 := ""
cCabec2 := ""

nTot := Len(aVetImpress)

for _i_ := 1 to nTot
	
	
	If li > 56
		
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		@li,00  PSAY cNroNotOs
		li:=li+2
		@li,00  PSAY cItemAvali
		li:=li+3
		
	Endif
	
	@ li,00 PSAY Rtrim(aVetImpress[_i_,05])
	@ li,38 PSAY transform(aVetImpress[_i_,09],"@E 9,999,999.99")
	@ li,53 PSAY transform(aVetImpress[_i_,10],"@E 9999.99%")
	li++
	
Next

cCabec1 := ""
cCabec2 := ""
nStep := 0
if Type("oFolderAva") # "U"
	
	If oFolderAva:nOption == 1
		For i:= 1 to Len(aStrup)
			If Alltrim(aStrup[i,5]) == STR0065
				nStep := i
				exit
			Endif
		Next
		cVetCab := 	STR0064
		for i := 1 to nStep
			if aStrup[i,6] == "1"
				cVetCab +=   PadL(AllTrim(aStrup[i,5]),15) + " "
			Endif
		next
		if nStep > 0
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			@li,0 psay cVetCab
			for i := 1 to Len(aStrup) step nStep
				If li > 56
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
					@li,0 psay cVetCab
				endif
				If aStrup[i,3] != STR0047
					DbSelectArea("SB1")
					DbSetOrder(1)
					DbSeek(xFilial("SB1")+aStrup[i,3])
					cItemAvali := SB1->B1_GRUPO + " " + Left(SB1->B1_CODITE,15) + " " + Left(SB1->B1_DESC,20)
					cValores := ""
					for j := i to (nStep + i)
						if aStrup[j,6] == "1"
							cValores += Transform(aStrup[j,9],"@E 9999,999,999.99")+" "
						endif
					next
					@li,0 psay cItemAvali + cValores
				Endif
			next
		endif
	elseif oFolderAva:nOption == 2
		For i:= 1 to Len(aStruo)
			If Alltrim(aStruo[i,5]) == STR0065
				nStep := i
				exit
			Endif
		Next
		cVetCab := 	STR0066
		for i := 1 to nStep
			if aStruo[i,6] == "1"
				cVetCab +=   PadL(AllTrim(aStruo[i,5]),12) + " "
			Endif
		next
		if nStep > 0
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			@li,0 psay cVetCab
			for i := 1 to Len(aStruo) step nStep
				If li > 56
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
					@li,0 psay cVetCab
				endif
				cValores := ""
				If aStruo[i,3] != STR0047
					DbSelectArea("VO6")
					DbSetOrder(2)
					DbSeek(xFilial("VO6")+VE4->VE4_PREFAB+aVetImpress[1,11])
					cItemAvali :=  VO6->VO6_CODSER + "-" + Left(VO6->VO6_DESSER,20)
					cValores := ""
					for j := i to (nStep + i)
						if aStruo[j,6] == "1"
							cValores += Transform(aStruo[j,9],"@E 9,999,999.99")+" "
						endif
					next
					@li,0 psay cItemAvali + cValores
				Endif
			next
		endif
	endif
endif
ms_flush()

Set Printer to
set Device  to Screen

If aReturn[5] == 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif

Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³F_NOMEOR370 ³ Autor ³  Andre                ³ Data ³ 27/10/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Valida nome do cliente/fornecedor                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Geral                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function F_NOMEOR370()
Local _cRet

If SF2->F2_TIPO $ "BD"
	_cRet := Posicione("SA2",1,xFilial("SA2")+SF2->F2_CLIENTE+SF2->F2_LOJA,"A2_NOME")
Else
	_cRet := Posicione("SA1",1,xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA,"A1_NOME")
Endif

Return(_cRet)
