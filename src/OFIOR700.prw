/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 15     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "PROTHEUS.CH"
#Include "FONT.CH"
#Include "COLORS.CH"
#Include "OFIOR700.CH"  

/*/{Protheus.doc} mil_ver()
    Versao do fonte modelo novo

    @author Andre Luis Almeida
    @since  13/11/2017
/*/
Static Function mil_ver()
	If .F.
		mil_ver()
	EndIf
Return "007398_1"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIOR700 ³ Autor ³  THIAGO               ³ Data ³ 08/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Copia de Requisicao de Pecas                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR700()

Local aObjects := {} , aPosObj := {} , aPosObjApon := {} , aInfo := {}
Local aSizeAut := MsAdvSize(.t.)  // Tamanho Maximo da Janela (.t.=TOOLBAR,.f.=SEM TOOLBAR)
Local nCntTam := 0
Local aCores := {{ 'VO1->VO1_STATUS == "A"', 'BR_VERDE'  } ,;  // Aberta
				{ 'VO1->VO1_STATUS == "D"', 'BR_AZUL'    } ,;  // Liberada
				{ 'VO1->VO1_STATUS == "F"', 'BR_VERMELHO'} ,;  // Fechado
				{ 'VO1->VO1_STATUS == "C"', 'BR_PRETO'   }}    // Cancelado

Private aRotina  := 	MenuDef()
Private cCadastro:= STR0001 // Copia de Requisicao de Pecas
Private cAlias   := "VO1"
Private oOk      := LoadBitmap( GetResources(), "LBOK" )
Private lMarcar  := .F.
Private oNo      := LoadBitmap( GetResources(), "LBNO" )
Private oTik     := LoadBitmap( GetResources(), "LBTIK" )
Private aVetReq1 := {"","","","",0,0,0} ; aVetReq := {}
Private nOpca    := 2
Private cAlmMor  := Space(2)
DEFINE FONT oFnt1 NAME "Arial" SIZE 08,14 BOLD

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Endereca a funcao de BROWSE                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPref := "      "
aPref := {STR0002,STR0003,STR0044} // Requisição Oficina / Requisição Balcao / Romaneio Balcao

AAdd( aObjects, { 0,  0 , .T. , .F. } ) 	

// Fator de reducao de 80%
for nCntTam := 1 to Len(aSizeAut)
	aSizeAut[nCntTam] := INT(aSizeAut[nCntTam] * 0.3)
next

aInfo := {aSizeAut[1] , aSizeAut[2] , aSizeAut[3] , aSizeAut[4] , 2 , 2 }
aPosObj := MsObjSize (aInfo, aObjects,.F.)    
	
DEFINE MSDIALOG oDlgPerg TITLE STR0004 FROM  aSizeAut[7],000 to aSizeAut[6],aSizeAut[5] OF oMainWnd PIXEL

@ aPosObj[1,1]+018,aPosObj[1,2] TO aPosObj[1,3]+44,aPosObj[1,4] LABEL STR0005 OF oDlgPerg PIXEL // Tipo de Movimento
@ aPosObj[1,1]+025,aPosObj[1,2]+003 MSCOMBOBOX oPref VAR cPref SIZE 175,50 ITEMS aPref OF oDlgPerg PIXEL

ACTIVATE MSDIALOG oDlgPerg CENTER ON INIT EnchoiceBar(oDlgPerg,{|| nOpca := 1,oDlgPerg:End()},{|| oDlgPerg:End()})

If nOpca == 1 // OK
	If cPref == STR0002 // Requisição Oficina
		cIndex := CriaTrab(nil,.f.)
		cKey   := "VO1_FILIAL+VO1_NUMOSV"
		cCond := ""
		dbSelectArea("VO1")
		IndRegua("VO1",cIndex,cKey,,cCond,STR0006)  // Selecionando registros...
		nIndexVO1 := RetIndex("VO1")
		#IFNDEF TOP
			dbSetIndex(cIndex+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndexVO1+1)
		mBrowse( 6, 1,22,75,"VO1",,,,,,aCores)
		dbSelectArea("VO1")
		#IFNDEF TOP
			RetIndex()
			dbSetOrder(1)
			If File(cIndex+OrdBagExt())
				fErase(cIndex+OrdBagExt())
			Endif
		#Else
			Set Filter to
		#ENDIF
	ElseIf cPref == STR0003 // Requisição Balcão
		cIndex := CriaTrab(nil,.f.)
		cKey   := "VS1_FILIAL+VS1_NUMORC"
		cCond := "VS1->VS1_TIPORC == '1'" 
		dbSelectArea("VS1")
		IndRegua("VS1",cIndex,cKey,,cCond,STR0006)  // Selecionando registros...
		nIndexVO1 := RetIndex("VS1")
		#IFNDEF TOP
			dbSetIndex(cIndex+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndexVO1+1)
		mBrowse(6,1,22,75,"VS1")
		dbSelectArea("VS1")
		#IFNDEF TOP
			RetIndex()
			dbSetOrder(1)
			If File(cIndex+OrdBagExt())
				fErase(cIndex+OrdBagExt())
			Endif
		#Else
			Set Filter to
		#ENDIF
	ElseIf cPref == STR0044 // Romaneio Balcão
		ExistBlock("ROMBALCAO")
		ExecBlock("ROMBALCAO",.f.,.f.)
	EndIf
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³COPRQ     ºAutor  ³Manoel Filho        º Data ³  08/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Levanta requisicoes a serem impressas e chama PRW Impressaoº±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COPRQ(cAlias,nReg,nOpc)
Local ialm := 0
Private nCkPerg := 1

aVetAlm := {}

DbSelectArea("NNR")
DbSetOrder(1)
DbSeek(xFilial("NNR") + "01" )
aadd(aVetAlm,"01-"+left(NNR->NNR_DESCRI,7))

cAlmMor  := Left(cAlmMor,2)

if cPref == STR0002 // Requisição Oficina
	DbSelectArea("VO1")
	DbSetOrder(1)
	
	DbSelectArea("VO2")
	DbSetOrder(1)
	DbSeek(xFilial("VO2")+VO1->VO1_NUMOSV)
	
	aVetReq := {}
	
	While !eof() .and. xFilial("VO2")==VO2->VO2_FILIAL .and. VO2->VO2_NUMOSV==VO1->VO1_NUMOSV
		
		If VO2->VO2_TIPREQ <> "P"
			DbSelectArea("VO2")
			DbSKip()
			Loop
		Endif
		
		aadd(aVetReq,{.f.,VO2->VO2_NOSNUM,VO2->VO2_DATREQ,VO2->VO2_HORREQ,IIf(VO2->VO2_DEVOLU == "0",STR0007,STR0008)}) // Dev / Req
		cNumosv := VO2->VO2_NUMOSV
		
		DbSelectArea("VO2")
		DbSKip()
		
	Enddo

	DbSelectArea("VO2")
	DbSetOrder(1)
	DbSeek(xFilial("VO2")+VO1->VO1_NUMOSV)
	
	If Len(aVetReq) > 0
		
		DEFINE MSDIALOG oDlg TITLE STR0009 FROM  01,11 TO 28,65 OF oMainWnd // Requisicoes / Devolucoes de Pecas
		
		@ 065,001  LISTBOX oLbox FIELDS HEADER " ",STR0016,STR0017,STR0018,STR0019 COLSIZES 40,40,30,40 SIZE 213,140 OF Odlg PIXEL ON DBLCLICK (aVetReq[oLbox:nAt,1]:=!aVetReq[oLbox:nAt,1],oLbox:Refresh()) // Numero / Data / Hora / Status
		oLbox:bHeaderClick := {|oObj,nCol| IIf( nCol==1 , ( lMarcar := !lMarcar , FS_TIK(lMarcar) , oLbox:Refresh() ) , .t. ) , }
		oLbox:SetArray(aVetReq)
		oLbox:bLine := { || { IIf(!aVetReq[oLbox:nAt,01],oNo,oTik),;
		aVetReq[oLbox:nAt,02],;
		aVetReq[oLbox:nAt,03],;
		transform(aVetReq[oLbox:nAt,04],"@E 99:99"),;
		aVetReq[oLbox:nAt,05]}}

		@ 007,004 SAY STR0010 SIZE 170,40  Of oDlg PIXEL FONT oFnt1 // Nro. OS:
		@ 007,040 SAY cNumosv SIZE 170,40 Of oDlg PIXEL FONT oFnt1
		@ 007,130 BUTTON oFiltro PROMPT STR0011 OF oDlg SIZE 70,10 PIXEL ACTION FS_COPREQ(oLbox:nAt)  // <<< I M P R I M I R >>>
		@ 018,130 BUTTON oVisual PROMPT STR0012 OF oDlg SIZE 70,10 PIXEL ACTION FS_VISUALIZA()        // <<< VISUALIZA PECAS >>>
		@ 029,130 BUTTON oSair   PROMPT STR0013 OF oDlg SIZE 70,10 PIXEL ACTION oDlg:End()            // <<<     S A I R     >>>
		@ 019,004 SAY STR0014 OF oDlg PIXEL COLOR CLR_BLUE FONT oFnt1 // Almoxarifado
		@ 029,004 MSCOMBOBOX oVetAlm VAR cAlmMor SIZE 77,33 FONT oFnt1 COLOR CLR_BLACK ITEMS aVetAlm OF oDlg PIXEL    
		@ 046,004 SAY STR0041 OF oDlg PIXEL COLOR CLR_BLUE FONT oFnt1 // Imprimir requisições/devoluções
		@ 045,110 RADIO oRadio1 VAR nCkPerg 3D SIZE 80,10 PROMPT STR0042,STR0043 OF oDlg PIXEL  // "Agrupadas" / "Separadas"

		ACTIVATE MSDIALOG oDlg CENTER
		
	Else
		
		MsgStop(STR0021,STR0020) // Nao ha Requisicoes ou Devolucoes para esta O.S. / Atencao
		
	Endif
Elseif cPref == STR0003 // Requisição Balcão
	cNumero := ""
	DbSelectArea("VS1")
	DbSetOrder(1)
	
	M->VS1_NUMORC := VS1->VS1_NUMORC
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek(xFilial("SF2")+VS1->VS1_NUMNFI+VS1->VS1_SERNFI)
	
	DbSelectArea("VS3")
	DbSetOrder(1)
	DbSeek(xFilial("VS3")+VS1->VS1_NUMORC)
	
	aVetReq1 := {}
	
	While !eof() .and. xFilial("VS3")==VS3->VS3_FILIAL .and. VS3->VS3_NUMORC==VS1->VS1_NUMORC
		
		dbSelectArea("SB1")
		dbSetOrder(7)
		dbSeek(xFilial("SB1")+VS3->VS3_GRUITE+VS3->VS3_CODITE)
		aadd(aVetReq1,{VS3->VS3_SEQUEN,VS3->VS3_GRUITE,VS3->VS3_CODITE,SB1->B1_DESC,VS3->VS3_QTDITE,VS3->VS3_VALPEC,VS3->VS3_VALTOT,VS1->VS1_NUMORC})
		if !Empty(VS1->VS1_SERNFI)
			cNumero := VS1->VS1_NUMNFI + "/" + FGX_MILSNF("VS1", 2, "VS1_SERNFI")
		Else
			cNumero := VS1->VS1_NUMNFI
		Endif
		DbSelectArea("VS3")
		DbSKip()
		
	Enddo
	
	If Len(aVetReq1) > 0

		DEFINE MSDIALOG oDlg2 TITLE STR0022 FROM  01,11 TO 27,56 OF oMainWnd // Pecas das Requisicoes
		
		@ 043,001  LISTBOX oLbox2 FIELDS HEADER STR0024,STR0025,STR0026,STR0027,STR0028,STR0029,STR0030 COLSIZES 10,20,40,50,30,30,30 SIZE 180,140 OF Odlg2 PIXEL oLbox2:SetArray(aVetReq1)
		oLbox2:SetArray(aVetReq1)
		oLbox2:bLine := { || { aVetReq1[oLbox2:nAt,01],;
		aVetReq1[oLbox2:nAt,02],;
		aVetReq1[oLbox2:nAt,03],;
		aVetReq1[oLbox2:nAt,04],;
		transform(aVetReq1[oLbox2:nAt,05],"9999"),;
		transform(aVetReq1[oLbox2:nAt,06],"@E 999,999.99"),;
		transform(aVetReq1[oLbox2:nAt,07],"@E 999,999.99")}}

		@ 17,004 SAY STR0023 SIZE 170,40  Of oDlg2 PIXEL FONT oFnt1 // Nro. Nota:
		@ 17,040 SAY cNumero SIZE 170,40 Of oDlg2 PIXEL FONT oFnt1
		@ 007,100 BUTTON oIncluir  PROMPT STR0011 OF oDlg2 SIZE 70,10 PIXEL ACTION FS_IMPRIMIR(cNumero) // <<< I M P R I M I R >>>
		@ 018,100 BUTTON oSair     PROMPT STR0013 OF oDlg2 SIZE 70,10 PIXEL ACTION oDlg2:End()   // <<<     S A I R     >>>
		
		ACTIVATE MSDIALOG oDlg2 CENTER
		
	Else
		
		MsgStop(STR0021,STR0020) // Nao ha Requisicoes ou Devolucoes para esta O.S. / Atencao
		
	Endif
Endif

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_VISUALIZA³ Autor ³  THIAGO             ³ Data ³ 08/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Visualiza Pecas                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_VISUALIZA()
Local i := 0
aVetPec := {}

for i := 1 to Len(aVetReq)
	if aVetReq[i,1] == .t.
		DBSelectArea("VO3")
		DBSetOrder(1)
		DBSeek(xFilial("VO3") + aVetReq[i,2])
		while !eof() .and. xFilial("VO3")==VO3->VO3_FILIAL .and. VO3->VO3_NOSNUM==aVetReq[i,2]
			aAdd(aVetPec,{VO3->VO3_NOSNUM,VO3->VO3_TIPTEM,VO3->VO3_GRUITE,Left(VO3->VO3_CODITE,17),VO3->VO3_QTDREQ,Transform(VO3->VO3_VALPEC,"@E 999,999,999.99"),VO3->VO3_PROREQ})
			DbSkip()
		enddo
	endif
next

If Len(aVetPec) > 0
	
	DEFINE MSDIALOG oDlg2 TITLE STR0022 FROM  01,11 TO 27,56 OF oMainWnd // Pecas das Requisicoes

	@ 43,001  LISTBOX oLbox2 FIELDS HEADER STR0016,STR0031,STR0025,STR0026,STR0028,STR0029,STR0032 COLSIZES 30,10,20,30,10,40,30 SIZE 180,140 OF Odlg2 PIXEL oLbox2:SetArray(aVetPec) // Numero / T.T. / Grupo / Codigo do Item / Qtd. / Valor / Mecanico
	oLbox2:SetArray(aVetPec)
	oLbox2:bLine := { || { aVetPec[oLbox2:nAt,01],;
	aVetPec[oLbox2:nAt,02],;
	aVetPec[oLbox2:nAt,03],;
	aVetPec[oLbox2:nAt,04],;
	aVetPec[oLbox2:nAt,05],;
	aVetPec[oLbox2:nAt,06],;
	aVetPec[oLbox2:nAt,07]}}

	@ 17,004 SAY STR0010 SIZE 170,40 Of oDlg2 PIXEL FONT oFnt1 // Nro. OS: 
	@ 17,040 SAY cNumOsv SIZE 170,40 Of oDlg2 PIXEL FONT oFnt1
	@ 008,100 BUTTON oSair PROMPT STR0013 OF oDlg2 SIZE 70,10 PIXEL ACTION oDlg2:End() // <<<     S A I R     >>>

	ACTIVATE MSDIALOG oDlg2 CENTER
	
Else
	
	MsgStop(STR0033,STR0020) // Nao ha Pecas requsitadas nas requisicoes selecionadas. / Atencao
	
Endif

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_TIK     ³ Autor ³  THIAGO             ³ Data ³ 08/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Marca/Desmarca TOTAL Vetor de Requisicao                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_TIK(lMarcar)
Local nLine := 0
For nLine:=1 to Len(aVetReq)
	aVetReq[nLine,1] := lMarcar
Next
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_COPREQ  ³ Autor ³  THIAGO             ³ Data ³ 08/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chamada da ORDBUSCA                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_COPREQ()

SetPrvt("cAlias , cNomRel , cGPerg , cTitulo , cDesc1 , cDesc2 , cDesc3 , aOrdem , lHabil , cTamanho , aReturn , ")
SetPrvt("titulo,cabec1,cabec2,nLastKey,wnrel,tamanho")

Private aVetCampos := {}

cAlias := "VO3"
cNomRel:= "ORDBUSCA"
cGPerg := ""
cTitulo:= STR0034 // Requisicao de Pecas
cDesc1 := STR0035 // Ordem de Busca
cDesc2 := cDesc3 := ""
aOrdem := {STR0036,STR0026} // Nosso Numero / Codigo do Item
lHabil := .f.
lServer := ( GetMv("MV_LSERVER") == "S" )

cTamanho:= "P"
nLastKey:=0

aDriver := LeDriver()
cCompac := aDriver[1]
cNormal := aDriver[2]

cDrive  := GetMv("MV_DRVORB")
cPorta  := GetMv("MV_PORORB")

If nlastkey == 27
	Return(Allwaystrue())
EndIf

RptStatus({|lEnd| FS_IMPORDBUSC(@lEnd,"OFIM020",'VO3')},Titulo)

Return(Allwaystrue())

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_IMPORDBUSC³ Autor ³  THIAGO            ³ Data ³ 08/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chamada do PE -> ORDBUSCA                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPORDBUSC()
Local i          := 0
Local lAchou     := .f.
Local aReqNOSNUM := {}
Local aDevNOSNUM := {}
Private cReqDev  := "1"                   
For i := 1 to Len(aVetReq)  
	if aVetReq[i,1]                             
		lAchou := .t.
	Else
		Loop
	Endif
	if aVetReq[i,5] == STR0008
		aAdd(aReqNOSNUM,aVetReq[i,2])
	Else
		aAdd(aDevNOSNUM,aVetReq[i,2])
	Endif

	if nCkPerg == 2
		if ExistBlock("ORDBUSCA")
			If len(aReqNOSNUM) > 0
				cReqDev := "1"
				ExecBlock("ORDBUSCA",.f.,.f.,{aReqNOSNUM})
				aReqNOSNUM := {}				
			Endif
			If len(aDevNOSNUM) > 0
				cReqDev := "2"
				ExecBlock("ORDBUSCA",.f.,.f.,{aDevNOSNUM})
				aDevNOSNUM := {}
			Endif
		EndIf
   Endif

Next
if !lAchou
   MsgStop(STR0040)  
   Return(.f.)
Endif	
if nCkPerg == 1
	if ExistBlock("ORDBUSCA")
		If len(aReqNOSNUM) > 0
			cReqDev := "1"
			ExecBlock("ORDBUSCA",.f.,.f.,{aReqNOSNUM})
		Endif
		If len(aDevNOSNUM) > 0
			cReqDev := "2"
			ExecBlock("ORDBUSCA",.f.,.f.,{aDevNOSNUM})
		Endif
	EndIf
Endif
oDlg:End()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ F_GARANT    ³ Autor ³  THIAGO            ³ Data ³ 08/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Valida Garantia                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function F_GARANT( cChaInt , cTipTem , cGruIte , cCodIte , dDataGar , nKmGar , lTela )

Local nVar := 0 , dDataPesq := Ctod("  /  /  ") , nKmReq := 0
Local aArea := {} , aVetGar := {} , lRetorno := .f. , cVerificacao := ""
Local bTitulo   := {|cCampo| IIf( SX3->( DbSeek( cCampo ) ) , X3Titulo() , "" )  }
Local bConteudo := {|x,cCampo| Ascan( aVetGar[x] , cCampo )  }
local lAchou := .f.
Default cGruIte := ""
Default cCodIte := ""
Default dDataGar := Ctod("  /  /  ")
Default nKmGar := 0
Default lTela := .t.

&& Salva posicoes do arquivo
aArea := sGetArea(aArea,Alias())
aArea := sGetArea(aArea,"VV1")
aArea := sGetArea(aArea,"VO5")
aArea := sGetArea(aArea,"VV2")
aArea := sGetArea(aArea,"VE4")
aArea := sGetArea(aArea,"VVL")
aArea := sGetArea(aArea,"VEC")
aArea := sGetArea(aArea,"SBM")
aArea := sGetArea(aArea,"VO1")
aArea := sGetArea(aArea,"VOI")
aArea := sGetArea(aArea,"VSC")
aArea := sGetArea(aArea,"VOU")
aArea := sGetArea(aArea,"VOP")

Aadd( aVetGar , {} )  && Cabecalho do veiculo
Aadd( aVetGar , {} )  && Conteudo do veiculo
Aadd( aVetGar , {} )  && Cabecalho do list box
Aadd( aVetGar , {} )  && Conteudo do list box

&& Verifica a garantia do veiculo

Aadd( aVetGar[2] , {} )

DbSelectArea("VV1")
DbSetOrder(1)
DbSeek( xFilial("VV1") + cChaInt )
For nVar := 1 to FCount()
	Aadd( aVetGar[1] , FieldName( nVar ) )
	Aadd( aVetGar[2,Len(aVetGar[2])] , FieldGet(nVar) )
Next

DbSelectArea("VO5")
DbSetOrder(1)
DbSeek( xFilial("VO5") + cChaInt )
For nVar := 1 to FCount()
	Aadd( aVetGar[1] , FieldName( nVar ) )
	Aadd( aVetGar[2,Len(aVetGar[2])] , FieldGet(nVar) )
Next

DbSelectArea("VV2")
DbSetOrder(1)
DbSeek( xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI + VV1->VV1_SEGMOD )

DbSelectArea("VE4")
DbSetOrder(1)
DbSeek( xFilial("VE4") + VV1->VV1_CODMAR )
If VE4->VE4_VDAREV == "1" //  1 - Data da venda do veiculo
	dDataPesq := VO5->VO5_DATVEN
ElseIf VE4->VE4_VDAREV == "2" // 2 - Data da primeira revisao do veiculo
	dDataPesq := VO5->VO5_PRIREV
Else // 3 - Data da entrega do veiculo
	dDataPesq := VO5->VO5_DATSAI
EndIf

DbSelectArea("VVL")
DbSetOrder(1)
If !DbSeek( xFilial("VVL") + VV1->VV1_CODMAR + VV1->VV1_MODVEI + VV1->VV1_SEGMOD + Dtos( dDataPesq ) , .t. ) ;
	.And. ( VVL->VVL_FILIAL+VVL->VVL_CODMAR+VVL->VVL_MODVEI+VVL->VVL_SEGMOD # xFilial("VVL") + VV1->VV1_CODMAR + VV1->VV1_MODVEI + VV1->VV1_SEGMOD .Or. VVL->VVL_DATGAR > dDataPesq )
	
	DbSkip(-1)
	
EndIf

&& Valida garantia por data
If VVL->VVL_FILIAL+VVL->VVL_CODMAR+VVL->VVL_MODVEI+VVL->VVL_SEGMOD == xFilial("VVL") + VV1->VV1_CODMAR + VV1->VV1_MODVEI + VV1->VV1_SEGMOD
	
	If !Empty( dDataGar )
		
		If ( dDataPesq + VVL->VVL_PERGAR ) >= dDataGar
			
			lRetorno := .t.
			
		EndIf
		
	EndIf
	
	&& Valida garantia por kilometro
	If !Empty( nKmGar )
		
		If VVL->VVL_KILGAR >= nKmGar
			
			lRetorno := .t.
			
		EndIf
		
	EndIf
	
EndIf

&& Verifica a garantia da peca ou da venda balcao

DbSelectArea("VEC")

For nVar := 1 to FCount()
	Aadd( aVetGar[3] , FieldName( nVar ) )
Next

Aadd( aVetGar[3] , "VSC_KILROD" )   && Armazenara o kilometro da aplicacao do item VSC

DbSelectArea("SBM")
DbSetOrder(1)
DbSeek( xFilial("SBM") + cGruIte )

DbSelectArea("VE4")
DbSetOrder(1)
DbSeek( xFilial("VE4") + SBM->BM_CODMAR )

DbSelectArea("VO1")
DbSetOrder(4)
DbSeek( xFilial("VO1") + cChaInt + "F" )

Do While !Eof() .and. xFilial("VO1")==VO1->VO1_FILIAL .and. VO1->VO1_CHAINT + VO1->VO1_STATUS == cChaInt + "F"
	
	&& Valida garantia por data
	If !Empty( dDataGar )
		
		DbSelectArea("VEC")
		DbSetOrder(5)
		DbSeek( xFilial("VEC") + VO1->VO1_NUMOSV )
		
		Do While !Eof() .and. xFilial("VEC")==VEC->VEC_FILIAL .and. VEC->VEC_NUMOSV==VO1->VO1_NUMOSV
			
			lCondicao := (alltrim(VEC->VEC_GRUITE) == alltrim(cGruIte) .And. alltrim(VEC->VEC_CODITE) == alltrim(cCodIte))

			If lCondicao
				
				DbSelectArea("VOI")
				DbSetOrder(1)
				DbSeek( xFilial("VOI") + VEC->VEC_TIPTEM )
				
				If VEC->VEC_BALOFI == "O"  && Verifica garantia de peca
					
					If !Empty( dDataGar ) //renata
						If  VEC->VEC_DATVEN + VE4->VE4_PERPEC >= dDataGar
							dDataPesq := VEC->VEC_DATVEN
							aVetGar[4] := {}
							lAchou := .t.
						EndIf
					EndIf
					
					&& Valida garantia por kilometro
					DbSelectArea("VSC")
					DbSetOrder(1)
					If DbSeek( xFilial("VSC") + VO1->VO1_NUMOSV )
						nKmReq := VSC->VSC_KILROD
					EndIf
					
					&& Adiciona no vetor
					DbSelectArea("VEC")
					Aadd( aVetGar[4] , {} )
					For nVar := 1 to FCount()
						Aadd( aVetGar[4,Len(aVetGar[4])] , FieldGet(nVar) )
					Next
					
					Aadd( aVetGar[4,Len(aVetGar[4])] , VSC->VSC_KILROD )
					
				ElseIf VEC->VEC_BALOFI == "B"  && Verifica garantia de peca balcao
					
					&& Salva a data da aplicadacao da peca balcao nao garantia
					If VOI->VOI_SITTPO # "2" .Or. Empty(dDataPesq) .Or. ( dDataPesq + VE4->VE4_PERBAL ) < VEC->VEC_DATVEN
						
						dDataPesq := VEC->VEC_DATVEN
						aVetGar[4] := {}
						
					EndIf
					
					&& Adiciona no vetor
					DbSelectArea("VEC")
					
					Aadd( aVetGar[4] , {} )
					For nVar := 1 to FCount()
						Aadd( aVetGar[4,Len(aVetGar[4])] , FieldGet(nVar) )
					Next
					
					Aadd( aVetGar[4,Len(aVetGar[4])] , 0 )
					
				EndIf
				
				cVerificacao := VEC->VEC_BALOFI
				
			EndIf
			
			DbSelectArea("VEC")
			DbSkip()
			
		EndDo
		
	EndIf
	
	DbSelectArea("VO1")
	DbSkip()
	
EndDo

If cVerificacao == "O"  && Verifica garantia de peca
	
	&& Valida garantia por kilometro
	If !Empty( nKmGar )
		If ( nKmReq + VE4->VE4_KILPEC ) >= nKmGar
			lRetorno := .t.
		EndIf
	EndIf
	
ElseIf cVerificacao == "B"             && Verifica garantia de peca BALCAO
	
	&& Valida garantia por data
	If !Empty( dDataGar )
		
		If ( dDataPesq + VE4->VE4_PERBAL ) >= dDataGar
			
			lRetorno := .t.
			
		EndIf
		
	EndIf
EndIf

DbSelectArea("VOI")
DbSetOrder(1)
DbSeek( xFilial("VOI") + cTipTem )

If VOI->VOI_SITTPO # "2"	     && Se o tipo de tempo nao for de garantia e a peca esta na garantia mostra historico da peca
	
	If lTela .And. lRetorno
		
		If Len(aVetGar[4]) == 0
			
			Aadd( aVetGar[4] , {} )
			For nVar := 1 to Len( aVetGar[3] )
				Aadd( aVetGar[4,Len(aVetGar[4])] , CriaVar(aVetGar[3,nVar]) )
			Next
			
		EndIf
		
		lAchou := .t.
	EndIf
	
	lRetorno := .t.
	
Else
	
	&& Verifica campanha
	DbSelectArea("VOU")
	DbSetOrder(2)
	DbSeek( xFilial("VOU") + VV1->VV1_CHASSI )
	Do While !Eof() .and. xFilial("VOU")==VOU->VOU_FILIAL .and. VOU->VOU_CHASSI==VV1->VV1_CHASSI
		
		DbSelectArea("VOP")
		DbSetOrder(1)
		If DbSeek( xFilial("VOP") + VOU->VOU_NUMINT ) ;
			.And. ( Empty(VOP->VOP_DATCAM) .Or. dDataGar >= VOP->VOP_DATCAM ) ;
			.And. ( Empty(VOP->VOP_DATVEN) .Or. dDataGar <= VOP->VOP_DATVEN )
			
			lRetorno := .t.
			Exit
			
		EndIf
		
		DbSelectArea("VOU")
		DbSkip()
		
	EndDo
	
EndIf

If !VO1->( Found() ) .Or. !VEC->( Found() )
	lRetorno := .t.
EndIf

&& Volta posicoes originais
sRestArea(aArea)

If !lRetorno .And. lTela
	Help("   ",1,"VGARNEXIST" )
EndIf

oDlg:End()

Return( lAchou )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_IMPRIMIR ³ Autor ³  THIAGO            ³ Data ³ 08/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao PE -> ORDBUSCB                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static function FS_IMPRIMIR(cNumNF)
Local nI := 0
Local aVetPec := {}
For nI := 1 to Len(aVetReq1)
	DBSelectArea("VS3")
	DBSetOrder(2)
	DbSeek(xFilial("VS3")+aVetReq1[nI,8]+aVetReq1[nI,2]+aVetReq1[nI,3])
	While !eof() .and. xFilial("VS3")==VS3->VS3_FILIAL .and. aVetReq1[nI,8]==VS3->VS3_NUMORC .AND. (aVetReq1[nI,2]+aVetReq1[nI,3]) == (VS3->VS3_GRUITE+VS3->VS3_CODITE)
		aAdd(aVetPec,{VS3->VS3_SEQUEN,VS3->VS3_GRUITE,VS3->VS3_CODITE,SB1->B1_DESC,VS3->VS3_QTDITE,VS3->VS3_VALPEC,VS3->VS3_VALTOT})
		DbSkip()
	EndDo
Next
If Len(aVetPec) > 0
	if ExistBlock("ORDBUSCB")
		If !Empty(cNumNF)
			ExecBlock("ORDBUSCB",.f.,.f.)
		Else
			ExecBlock("ORDBUSCB",.f.,.f.,{"O"})
		EndIf
	Endif
Else
	MsgStop(STR0033,STR0020) // Nao ha Pecas requsitadas nas requisicoes selecionadas. / Atencao
Endif
oDlg2:End()
Return(.t.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MenuDef  ³ Autor ³ THIAGO                            ³ Data ³ 30/03/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Menu (AROTINA)                                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MenuDef()
Local aRotina := {  { STR0037,"AxPesqui", 0 , 1} ,;     // Pesquisar
					{ STR0038,"COPRQ"   , 0 , 4},;   // Selecionar
					{ STR0039,"OM010LEG", 0 , 2,0,.f.}} // Legenda
Return aRotina
