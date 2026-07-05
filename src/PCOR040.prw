/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "pcor040.ch"
#INCLUDE "PROTHEUS.CH"
#DEFINE CELLTAMDATA (TOTAL->TOT_TAMCOL*8)
#DEFINE TAMCELLDATA (TOTFOL->TOT_TAMCOL*8)

Static aPosCol := {}, aCabConteudo := {}, nUltCol := 0
Static _oPCOR0401
Static _oPCOR0402
Static _oPCOR0403

/*/
_F_U_N_C_ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ PCOR040  ³ AUTOR ³ Edson Maricate        ³ DATA ³ 07-01-2004 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Programa de impressao da planilha Visao orcamentaria.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ USO      ³ SIGAPCO                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³_DOCUMEN_ ³ PCOR040                                                      ³±±
±±³_DESCRI_  ³ Programa de impressao da planilha visao orcamentaria.        ³±±
±±³_FUNC_    ³ Esta funcao devera ser utilizada com a sua chamada normal a  ³±±
±±³          ³ partir do Menu do sistema.                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PCOR040(lCallPrg, aPerg)
Local aArea			:= GetArea()
Local aAreaAKO		:= AKO->(GetArea())
Local aAreaTMPAK1
Local lOk			:= .F.
Local oOk			:= LoadBitMap(GetResources(), "LBTIK")
Local oNo			:= LoadBitMap(GetResources(), "LBNO")
Local oDlg, oListBox
Local cR1, cR2, lPrintRel, bPrintRel, aPerVisao

Private nLin	:= 200
Private aTotList := {}
Private aTotBlock := {}
Private cRevisa

Default lCallPrg := .F.
Default aPerg := {}

If lCallPrg
	aAreaTMPAK1	:= TMPAK1->(GetArea())
	lOk := .T.
Else
	//quando chamado a partir do menu
	If Pergunte("PCRVIS", .T.)
		dbSelectArea("AKN")
		dbSetOrder(1)
		lOk := !Empty(MV_PAR01) .And. dbSeek(xFilial("AKN")+MV_PAR01)
		If lOk
			cR1 := NIL
			cR2 := NIL
			lPrintRel := .T.
			bPrintRel := {||U_PCOR040(.T.)}
			aPerVisao := {Str(MV_PAR02,1), MV_PAR03, MV_PAR04}
			PCO180EXE("AKN", AKN->(Recno()), 2, cR1, cR2, aPerVisao, lPrintRel, bPrintRel)
		EndIf
    EndIf
    Return  //retorna sempre pois ja gerou o relatorio
EndIf

If lOk
	dbSelectArea("AKQ")
	dbSetOrder(1)
	dbSeek(xFilial("AKQ"))
	
	While ! Eof() .And. AKQ_FILIAL == xFilial("AKQ")
		aAdd(aTotList,{.F.,AKQ->AKQ_COD,AKQ->AKQ_DESCRI})
		aAdd(aTotBlock, { AKQ->(Recno()), AKQ->AKQ_BLOCK } ) 
	    dbSkip()
	End
	
	If Len(aTotList) > 0
		DEFINE MSDIALOG oDlg FROM 40,168 TO 380,730 TITLE STR0001 Of oMainWnd PIXEL  //"Escolha os Totais Visao Orcamentaria"
		
			@ 0,0 BITMAP oBmp RESNAME "PROJETOAP" Of oDlg SIZE 100,300 NOBORDER When .F. PIXEL
			oListBox := TWBrowse():New( 10,10,206,152,,{" OK ",STR0002,STR0003},,oDlg,,,,,,,,,,,,.F.,,.T.,,.F.,,,) //"Codigo"###"Descricao"
			oListBox:SetArray(aTotList)
			oListBox:bLine := { || {If(aTotList[oListBox:nAt,1],oOk,oNo),aTotList[oListBox:nAT][2],aTotList[oListBox:nAT][3]}}
			oListBox:bLDblClick := { ||InverteSel(oListBox, oListBox:nAt, .T.)}
		
		   @ 10,230 BUTTON STR0004 		SIZE 45 ,10   FONT oDlg:oFont ACTION (lOk:=.T.,oDlg:End())  OF oDlg PIXEL   //'Confirma >>'
		   @ 25,230 BUTTON STR0005  		SIZE 45 ,10   FONT oDlg:oFont ACTION (lOk:=.F.,oDlg:End())  OF oDlg PIXEL   //'<< Cancela'
		   @ 40,230 BUTTON STR0006  		SIZE 45 ,10   FONT oDlg:oFont ACTION (MarcaTodos(oListBox, .F., .T.))  OF oDlg PIXEL   //'Marcar Todos'
		   @ 55,230 BUTTON STR0007 	SIZE 45 ,10   FONT oDlg:oFont ACTION (MarcaTodos(oListBox, .F., .F.))  OF oDlg PIXEL   //'Desmarcar Todos'
		   @ 70,230 BUTTON STR0008	SIZE 45 ,10   FONT oDlg:oFont ACTION (MarcaTodos(oListBox, .T.))  OF oDlg PIXEL   //'Inverter Selecao'
		   @ 85,230 BUTTON STR0009		SIZE 45 ,10   FONT oDlg:oFont ACTION (InverteSel(oListBox, oListBox:nAt, .T.))  OF oDlg PIXEL   //'Marca/Desmarca'
		
		ACTIVATE MSDIALOG oDlg CENTERED
	Else
		HELP("  ",1,"PCOR0401")//Cadastro de totais visao orcamentaria esta vazio. Verifique!
		lOk := .F.
	EndIf	
		
	If lOk .And. (lOk := Elem_Selec(aTotList))
		If Len(aPerg) == 0
			oPrint := PcoPrtIni(STR0010,.T.,2,,@lOk,"PCR030") //"Planilha Total Visao Orcamentaria"
		Else
			aEval(aPerg, {|x, y| &("MV_PAR"+StrZero(y,2)) := x})
			oPrint := PcoPrtIni(STR0010,.T.,2,,@lOk,"") //"Planilha Total Visao Orcamentaria"
		EndIf
	EndIf
	
	If lOk
		RptStatus( {|lEnd| U_PCOR040Imp(@lEnd,oPrint)})
		PcoPrtEnd(oPrint)
	EndIf
	
EndIf

RestArea(aAreaTMPAK1)
RestArea(aAreaAKO)
RestArea(aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PCOR040Imp³ Autor ³ Edson Maricate        ³ Data ³07-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao da planilha orcamentaria.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_PCOR040Imp(lEnd)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd - Variavel para cancelamento da impressao pelo usuario³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PCOR040Imp(lEnd,oPrint)
Local cAlias           := Alias()
Local aEstrutAKO       := {}, cArqConta
Local aEstrutTOT       := {}, cArqTotal
Local aEstrutTFL       := {}, cArqTFl

Local aChave1			:= {}
Local aChave2			:= {}
Local aChave3			:= {}

Private Acols, aRet := {}, nCols
Private cVisGer     := TMPAK1->AK1_CODIGO
Private cDesAK1     := TMPAK1->AK1_DESCRI
Private dIniPer     := TMPAK1->AK1_INIPER
Private dFimPer     := TMPAK1->AK1_FIMPER
Private nTpPeri     := TMPAK1->AK1_TPPERI

AADD(aEstrutAKO,{'XKO_RECNO'	,'C',10,0})
AADD(aEstrutAKO,{'XKO_LDESC'	,'C',1,0})
AADD(aEstrutAKO,{'XKO_ORCAME'	,'C',Len(AKO->AKO_CODIGO),0})
AADD(aEstrutAKO,{'XKO_CO'		,'C',Len(AKO->AKO_CO),0})
AADD(aEstrutAKO,{'XKO_NIVEL'	,'C',Len(AKO->AKO_NIVEL),0})
AADD(aEstrutAKO,{'XKO_DESCRI'	,'C',Len(AKO->AKO_DESCRI),0})
AADD(aEstrutAKO,{'XKO_TIPO'	,'C',Len(AKO->AKO_CLASSE),0})

If _oPCOR0401 <> Nil
	_oPCOR0401:Delete()
	_oPCOR0401:= Nil
Endif

aChave1	:= {"XKO_RECNO"}

_oPCOR0401 := FWTemporaryTable():New("CONTA")
_oPCOR0401:SetFields( aEstrutAKO )

_oPCOR0401:AddIndex("1", aChave1)	
_oPCOR0401:Create()

cArqConta		:= _oPCOR0401:GetRealName()


AADD(aEstrutTFL,{'TOT_RECNO'	,'C',10,0})
AADD(aEstrutTFL,{'TOT_SEQUEN'	,'C',3,0})
AADD(aEstrutTFL,{'TOT_LDESC'	,'C',1,0})
AADD(aEstrutTFL,{'TOT_LINHA'	,'N',10,0})
AADD(aEstrutTFL,{'TOT_COLUNA'	,'N',10,0})
AADD(aEstrutTFL,{'TOT_CONTEU'	,'C',100,0})
AADD(aEstrutTFL,{'TOT_NROCOL'	,'N',10,0})
AADD(aEstrutTFL,{'TOT_TAMCOL'	,'N',10,0})
AADD(aEstrutTFL,{'TOT_LINIMP'	,'N',10,0})
AADD(aEstrutTFL,{'TOT_COLIMP'	,'N',10,0})

If _oPCOR0402 <> Nil
	_oPCOR0402:Delete()
	_oPCOR0402:= Nil
Endif

aChave2	:= {"TOT_RECNO","TOT_SEQUEN","TOT_LINHA","TOT_COLUNA"}

_oPCOR0402 := FWTemporaryTable():New("TOTFOL")
_oPCOR0402:SetFields( aEstrutTFL )

_oPCOR0402:AddIndex("1", aChave2)	
_oPCOR0402:Create()

cArqTFL 		:= _oPCOR0402:GetRealName()

dbSelectArea("TOTFOL")
dbSetOrder(1)

AADD(aEstrutTOT,{'TOT_RECNO'	,'C',10,0})
AADD(aEstrutTOT,{'TOT_SEQUEN'	,'C',3,0})
AADD(aEstrutTOT,{'TOT_LDESC'	,'C',1,0})
AADD(aEstrutTOT,{'TOT_LINHA'	,'N',10,0})
AADD(aEstrutTOT,{'TOT_COLUNA'	,'N',10,0})
AADD(aEstrutTOT,{'TOT_CONTEU'	,'C',100,0})
AADD(aEstrutTOT,{'TOT_NROCOL'	,'N',10,0})
AADD(aEstrutTOT,{'TOT_TAMCOL'	,'N',10,0})
AADD(aEstrutTOT,{'TOT_LINIMP'	,'N',10,0})

If _oPCOR0403 <> Nil
	_oPCOR0403:Delete()
	_oPCOR0403:= Nil
Endif

aChave3	:= {"TOT_RECNO","TOT_SEQUEN"}

_oPCOR0403 := FWTemporaryTable():New("TOTAL")
_oPCOR0403:SetFields( aEstrutTOT )

_oPCOR0403:AddIndex("1", aChave3)	
_oPCOR0403:Create()

cArqTotal 		:= _oPCOR0403:GetRealName()

dbSelectArea("TOTAL")
dbSetOrder(1)

dbSelectArea("AKO")
dbSetOrder(3)

If MsSeek(xFilial()+PadR(cVisGer,Len(AKO->AKO_CODIGO))+"001")
	While !Eof() .And. 	AKO_FILIAL+AKO_CODIGO+AKO_NIVEL==;
						xFilial("AKO")+PadR(cVisGer,Len(AKO->AKO_CODIGO))+"001"
		U_PCOR040It(AKO_CODIGO,AKO_CO)
		dbSelectArea("AKO")
		dbSkip()
	End
EndIf

//Impressao do relatorio
dbSelectArea("CONTA")
dbGoTop()
If !Eof()
	R040Cabec()
EndIf

While ! Eof()
	
	If PcoPrtLim(nLin+150)
		nLin := 200
		R040Cabec()
		R040QuebraPag()
	EndIf

	R040DetConta()

	dbSelectArea("CONTA")
	CONTA->(dbSkip())
	
End

If TOTFOL->(!Eof())
	nLin := 200
	R040Cabec()
	R040QuebraPag()
EndIf

dbSelectArea("CONTA")
dbCloseArea()
If _oPCOR0401 <> Nil
	_oPCOR0401:Delete()
	_oPCOR0401:= Nil
Endif

dbSelectArea("TOTFOL")
dbCloseArea()
If _oPCOR0402 <> Nil
	_oPCOR0402:Delete()
	_oPCOR0402:= Nil
Endif

dbSelectArea("TOTAL")
dbCloseArea()
If _oPCOR0403 <> Nil
	_oPCOR0403:Delete()
	_oPCOR0403:= Nil
Endif

dbSelectArea(cAlias)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PCOR040It ³ Autor ³ Edson Maricate        ³ Data ³07-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao da planilha orcamentaria.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_PCOR040Imp(lEnd)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd - Variavel para cancelamento da impressao pelo usuario³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PCOR040It(cVisGer,cCO)
Local aArea		:= GetArea()
Local aAreaAKO	:= AKO->(GetArea())
                  
// Se o centro Orcamentario pertence ao filtro que foi selecionado
IF (AKO->AKO_CO >= MV_PAR01 .AND. AKO->AKO_CO <= MV_PAR02 )
	// Se o Nivel pertence ao filtro que foi selecionado
	IF (AKO->AKO_NIVEL >= MV_PAR03 .AND. AKO->AKO_NIVEL <= MV_PAR04 )
		R040ContaOrc()				
		R040Totais(aTotList, aTotBlock)
	EndIf
EndIf
dbSelectArea("AKO")
dbSetOrder(2)
If MsSeek(xFilial()+cVisGer+cCO)
   	While !Eof() .And. AKO->AKO_FILIAL+AKO->AKO_CODIGO+AKO->AKO_COPAI==xFilial("AKO")+cVisGer+cCO
		U_PCOR040It(AKO_CODIGO,AKO_CO)
		dbSelectArea("AKO")
		dbSkip()
	End
EndIf

RestArea(aAreaAKO)
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³InverteSelºAutor  ³Paulo Carnelossi    º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inverte Selecao do list box - totalizadores                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function InverteSel(oListBox,nLin, lInverte, lMarca) 
DEFAULT nLin := oListBox:nAt

If lInverte
	oListbox:aArray[nLin,1] := ! oListbox:aArray[nLin,1]

Else
   If lMarca
	   oListbox:aArray[nLin,1] := .T.
   Else
	   oListbox:aArray[nLin,1] := .F.
   EndIf
EndIf   

aTotList[nLin,1] := oListbox:aArray[nLin,1]

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MarcaTodosºAutor  ³Paulo Carnelossi    º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Marca todos as opcoes do list box - totalizadores           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MarcaTodos(oListBox, lInverte, lMarca)
Local nX
DEFAULT lMarca := .T.

For nX := 1 TO Len(oListbox:aArray)
	InverteSel(oListBox,nX, lInverte, lMarca)
Next

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Elem_SelecºAutor  ³Paulo Carnelossi    º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se ha pelo menos uma opcao do list box selecionada º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Elem_Selec(aTotList)
Local nX, lRet := .F.
For nX := 1 TO Len(aTotList)
  If aTotList[nX][1]
     lRet := .T.
     Exit
  EndIf   
Next 

If !lRet
	HELP("  ",1,"PCOR0202") //Nao selecionado nenhuma totalizacao. Verifique!
EndIf	

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040TotaisºAutor  ³Paulo Carnelossi    º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Executa os blocos de codigos contidos no array atotBlock    º±±
±±º          ³do list box selecionado (aTotBlock - array recno TABELA AKQ)º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040Totais(aTotList, aTotBlock)
Local nX, aResult := {}
For nX := 1 TO Len(aTotList)
	If aTotList[nX][1]
		AKQ->(dbGoto(aTotBlock[nX][1]))
		If !Empty(AKQ->AKQ_BLOCK)
			aResult := PCOExecForm(AKQ->AKQ_BLOCK)
			If Len(aResult) > 1  // primeira elemento e o cabecalho
				R040TotOrc(aResult[1], aResult[2], aResult[3], nX)
			EndIf
			aResult := {}
		EndIf
	EndIf
Next

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040ContaOrcºAutor  ³Paulo Carnelossi  º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava as contas orcamentarias em arquivo temporario para    º±±
±±º          ³posterior impressao                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040ContaOrc()				

CONTA->(dbAppend())
CONTA->XKO_RECNO	:= StrZero(AKO->(Recno()),10)
CONTA->XKO_LDESC	:= "1"
CONTA->XKO_ORCAME	:= AKO->AKO_CODIGO
CONTA->XKO_CO		:= AKO->AKO_CO
CONTA->XKO_NIVEL	:= AKO->AKO_NIVEL
CONTA->XKO_DESCRI	:= AKO->AKO_DESCRI
CONTA->XKO_TIPO		:= AKO->AKO_CLASSE

Return						

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040TotOrc  ºAutor  ³Paulo Carnelossi  º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava totais das contas orcamentarias em arquivo temporario º±±
±±º          ³posterior impressao                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040TotOrc(aRet, aCols, nCols, nTotBlock)
Local nX, nY

For nX := 1 TO Len(aRet)
	For nY := 1 TO Len(aCols)
		TOTAL->(dbAppend())
		TOTAL->TOT_RECNO	:= StrZero(AKO->(Recno()),10)
        TOTAL->TOT_SEQUEN   := StrZero(nTotBlock, 3)
		TOTAL->TOT_LDESC	:= "1"
		TOTAL->TOT_LINHA	:= nX
		TOTAL->TOT_COLUNA	:= nY
		TOTAL->TOT_CONTEU	:= aRet[nX][nY]
		TOTAL->TOT_NROCOL	:= nCols
		TOTAL->TOT_TAMCOL   := aCols[nY]
		TOTAL->TOT_LINIMP	:= 0
    Next
Next
    
Return						

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040TotFolhaºAutor  ³Paulo Carnelossi  º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava totais das contas orcamentarias em arquivo temporario º±±
±±º          ³que nao foram impressos na pagina principal - continuacao   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040TotFolha()
TOTFOL->(dbSetOrder(1))
If TOTFOL->(!dbSeek(TOTAL->TOT_RECNO+TOTAL->TOT_SEQUEN+STRZERO(TOTAL->TOT_LINHA,3)+STRZERO(TOTAL->TOT_COLUNA,3)))
	TOTFOL->(dbAppend())
	TOTFOL->TOT_RECNO	:= TOTAL->TOT_RECNO
	TOTFOL->TOT_SEQUEN  := TOTAL->TOT_SEQUEN
	TOTFOL->TOT_LDESC	:= TOTAL->TOT_LDESC
	TOTFOL->TOT_LINHA	:= TOTAL->TOT_LINHA
	TOTFOL->TOT_COLUNA	:= TOTAL->TOT_COLUNA
	TOTFOL->TOT_CONTEU	:= TOTAL->TOT_CONTEU
	TOTFOL->TOT_NROCOL	:= TOTAL->TOT_NROCOL
	TOTFOL->TOT_TAMCOL  := TOTAL->TOT_TAMCOL
	TOTFOL->TOT_LINIMP	:= TOTAL->TOT_LINIMP
	TOTFOL->TOT_COLIMP	:= 0
	EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040Cabec   ºAutor  ³Paulo Carnelossi  º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cabecalho principal do relatorio                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040Cabec()

PcoPrtCab(oPrint)
PcoPrtCol({20,370,470,2075,2250})
PcoPrtCell(PcoPrtPos(1),nLin,PcoPrtTam(1),60,cVisGer,oPrint,4,2,/*RgbColor*/,STR0002) //"Codigo"
PcoPrtCell(PcoPrtPos(2),nLin,PcoPrtTam(2),60,"",oPrint,4,2,/*RgbColor*/,"")
PcoPrtCell(PcoPrtPos(3),nLin,PcoPrtTam(3),60,cDesAK1,oPrint,4,2,/*RgbColor*/,STR0003) //"Descricao"
PcoPrtCell(PcoPrtPos(4),nLin,PcoPrtTam(4),60,DTOC(dIniPer),oPrint,4,2,/*RgbColor*/,STR0011) //"Dt.Inicio"
PcoPrtCell(PcoPrtPos(5),nLin,PcoPrtTam(5),60,DTOC(dFimPer),oPrint,4,2,/*RgbColor*/,STR0012) //"Dt.Fim"
nLin+=70

R040CabConta()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040Cabec   ºAutor  ³Paulo Carnelossi  º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cabecalho secundario (contas orcamentarias)do relatorio     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040CabConta()

PcoPrtCol({20,370,470,2150})
PcoPrtCell(PcoPrtPos(1),nLin,PcoPrtTam(1),30,STR0013,oPrint,2,1,RGB(230,230,230)) //"C.O."
PcoPrtCell(PcoPrtPos(2),nLin,PcoPrtTam(2),30,STR0014,oPrint,2,1,RGB(230,230,230)) //"Nivel"
PcoPrtCell(PcoPrtPos(3),nLin,PcoPrtTam(3),30,STR0003,oPrint,2,1,RGB(230,230,230)) //"Descricao"
PcoPrtCell(PcoPrtPos(4),nLin,PcoPrtTam(4),30,STR0015,oPrint,2,1,RGB(230,230,230)) //"Tipo"
nLin+=75

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040DetContaºAutor  ³Paulo Carnelossi  º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Detalhe do relatorio - contas orcamentarias                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040DetConta()
Local lDescricao := (CONTA->XKO_LDESC=="1")
Local nX

If lDescricao
	PcoPrtCol({20,370,470,2150})
	PcoPrtCell(PcoPrtPos(1),nLin,,60,CONTA->XKO_CO,oPrint,5,3)
	PcoPrtCell(PcoPrtPos(2),nLin,,60,CONTA->XKO_NIVEL,oPrint,5,3)
	PcoPrtCell(PcoPrtPos(3),nLin,,60,SPACE((VAL(CONTA->XKO_NIVEL)-1)*3)+CONTA->XKO_DESCRI,oPrint,5,3)
	If Empty(CONTA->XKO_TIPO).Or.CONTA->XKO_TIPO == "1"
		PcoPrtCell(PcoPrtPos(4),nLin,,60,STR0016,oPrint,5,3) //"Sintetica"
	Else
		PcoPrtCell(PcoPrtPos(4),nLin,,60,STR0017,oPrint,5,3) //"Analitica"
	EndIf
	CONTA->XKO_LDESC := "0"  //
EndIf	
nLin+= 70

For nX := 1 TO Len(aTotList)
	If aTotList[nX][1]
		R040Total(CONTA->XKO_RECNO+StrZero(nX,3),lDescricao)
	EndIf
	nLin += 40
Next
nLin+= 70

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040Total   ºAutor  ³Paulo Carnelossi  º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao dos totalizadores para conta orcamentaria impressaº±±
±±º          ³no detalhe do relatorio                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040Total(cChave, lDescricao)
Local nTam
//Impressao do relatorio
dbSelectArea("TOTAL")
dbSeek(cChave)

nTam := 300

If dbSeek(cChave)
	While TOTAL->(! Eof() .And. TOT_RECNO+TOT_SEQUEN == cChave)
		R040TotImpr(cChave, lDescricao, nTam)
	End
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040TotImpr ºAutor  ³Paulo Carnelossi  º Data ³  04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao dos totalizadores para conta orcamentaria impressaº±±
±±º          ³no detalhe do relatorio                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040TotImpr(cChave, lDescricao, nTamOrig)
Local nX, nTam := 0, nLinImpr 

nTam += nTamOrig

If PcoPrtLim(nLin)
	nLin := 200
	R040Cabec()
	R040QuebraPag()
EndIf

If TOTAL->TOT_LINHA == 1  //monta cabecalho dos totais
	//primeiro monta cabecalho
	aPosCol := {}
	aCabConteudo := {}

	While TOTAL->(! Eof() .And. TOT_RECNO+TOT_SEQUEN == cChave .And. ;
		TOT_LINHA == 1 .And.  (nTam+CELLTAMDATA) <= 3100 )
		aAdd(aPosCol, nTam)
		nTam += CELLTAMDATA
		aAdd(aCabConteudo, TOTAL->TOT_CONTEU)
		nUltCol := TOTAL->TOT_COLUNA
		
		TOTAL->(dbDelete())
		TOTAL->(dbSkip())
	End
	//desprezaos registros que nao sao necessarios
	While TOTAL->(! Eof() .And. TOT_RECNO+TOT_SEQUEN == cChave .And. ;
			TOTAL->TOT_LINHA == 1 .And. TOT_COLUNA > nUltCol) 
		TOTAL->TOT_LINIMP := nLin
		R040TotFolha()
		TOTAL->(dbDelete())
		TOTAL->(dbSkip())
	End

	PcoPrtCol(aPosCol)

	//agora imprime o cabecalho
   	For nX := 1 TO Len(aCabConteudo)
		PcoPrtCell(PcoPrtPos(nX),nLin,PcoPrtTam(nX),30,aCabConteudo[nX],oPrint,2,1,RGB(230,230,230))
   	Next
	nLin+=30
Else
	//primeiro monta linha com as colunas
	nLinImpr := TOTAL->TOT_LINHA
	aPosCol := {}
	aCabConteudo := {}
	
	While TOTAL->(! Eof() .And. TOT_RECNO+TOT_SEQUEN == cChave .And. ;
		TOT_LINHA == nLinImpr .And.  (nTam+CELLTAMDATA) <= 3100 )
		aAdd(aPosCol, nTam)
		nTam += CELLTAMDATA
		aAdd(aCabConteudo, TOTAL->TOT_CONTEU)
		TOTAL->(dbDelete())
		TOTAL->(dbSkip())
	End 
	
	//ja avanca os registros que nao sao necessarios
	While TOTAL->(! Eof() .And. TOT_RECNO+TOT_SEQUEN == cChave .And. ;
			TOTAL->TOT_LINHA == nLinImpr .And. TOT_COLUNA > nUltCol)
		TOTAL->TOT_LINIMP := nLin
		R040TotFolha()
		TOTAL->(dbDelete())
		TOTAL->(dbSkip())
	End

	//agora imprime a linha
	PcoPrtCol(aPosCol)
	
   	For nX := 1 TO Len(aCabConteudo)
		PcoPrtCell(PcoPrtPos(nX),nLin,PcoPrtTam(nX),40,aCabConteudo[nX],oPrint,5,3,,,nX!=1)
   	Next
	nLin+=40
End 

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040QuebraPag ºAutor ³Paulo Carnelossi  º Data ³ 04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao da continuacao dos totalizadores para contas orc. º±±
±±º          ³impressas na pagina principal                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040QuebraPag()
Local cAlias := Alias()

dbSelectArea("TOTFOL")
dbSetOrder(0)
dbGoTop()

While ! Eof()
	R040DetQbPag()
End

dbSelectArea("TOTFOL")
dbGoTop()
If !Eof()
	nLin := 200
	R040Cabec()
	R040QuebraPag()
Else 
	dbSelectArea("TOTFOL")
    ZAP
	If CONTA->(!Eof())
		nLin := 200
		R040Cabec()
	EndIf	
EndIf

dbSelectArea(cAlias)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R040DetQbPag  ºAutor ³Paulo Carnelossi  º Data ³ 04/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao da continuacao dos totalizadores para contas orc. º±±
±±º          ³impressas na pagina principal                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040DetQbPag()
Local nX, nTam := 20, nLinImpr, cChave

cChave := TOTFOL->TOT_RECNO+TOTFOL->TOT_SEQUEN

If TOTFOL->TOT_LINHA == 1  //monta cabecalho dos totais
	//primeiro monta cabecalho
	aPosCol := {}
	aCabConteudo := {}
	nLin := TOTFOL->TOT_LINIMP
	While TOTFOL->(! Eof() .And. TOTFOL->TOT_RECNO+TOTFOL->TOT_SEQUEN==cChave .And. ;
		TOT_LINHA == 1 .And.  (nTam+TAMCELLDATA) <= 3100 )
		aAdd(aPosCol, nTam)
		nTam += TAMCELLDATA
		aAdd(aCabConteudo, TOTFOL->TOT_CONTEU)
		nUltCol := TOTAL->TOT_COLUNA
		TOTFOL->(dbDelete())
		TOTFOL->(dbSkip())
	End
	//desprezaos registros que nao sao necessarios
	While TOTFOL->(! Eof() .And. TOTFOL->TOT_LINHA == 1 .And. ;
		 TOTFOL->TOT_RECNO+TOTFOL->TOT_SEQUEN==cChave .And. TOT_COLUNA > nUltCol) 
		TOTFOL->(dbSkip())
	End

	PcoPrtCol(aPosCol)

	//agora imprime o cabecalho
   	For nX := 1 TO Len(aCabConteudo)
		PcoPrtCell(PcoPrtPos(nX),nLin,PcoPrtTam(nX),30,aCabConteudo[nX],oPrint,2,1,RGB(230,230,230))
   	Next
	nLin+=30
Else
	//primeiro monta linha com as colunas
	nLinImpr := TOTFOL->TOT_LINHA
	aPosCol := {}
	aCabConteudo := {}
	nLin := TOTFOL->TOT_LINIMP
	
	While TOTFOL->(! Eof() .And. TOT_LINHA == nLinImpr .And.  ;
			 TOTFOL->TOT_RECNO+TOTFOL->TOT_SEQUEN==cChave .And.(nTam+TAMCELLDATA) <= 3100 )
		aAdd(aPosCol, nTam)
		nTam += TAMCELLDATA
		aAdd(aCabConteudo, TOTFOL->TOT_CONTEU)
		nUltCol := TOTAL->TOT_COLUNA
		TOTFOL->(dbDelete())
		TOTFOL->(dbSkip())
	End 
	
	//ja avanca os registros que nao sao necessarios
	While TOTFOL->(! Eof() .And. TOTFOL->TOT_LINHA == nLinImpr .And. ;
			 TOTFOL->TOT_RECNO+TOTFOL->TOT_SEQUEN==cChave .And. TOT_COLUNA > nUltCol)
		TOTFOL->(dbSkip())
	End

	//agora imprime a linha
	PcoPrtCol(aPosCol)

   	For nX := 1 TO Len(aCabConteudo)
		PcoPrtCell(PcoPrtPos(nX),nLin,PcoPrtTam(nX),40,aCabConteudo[nX],oPrint,5,3,,, .T.)
   	Next
	nLin+=40
End 

Return
