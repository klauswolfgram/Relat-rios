/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MATR881.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR881  ³ Autor ³ Ary Medeiros          ³ Data ³ 03/09/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao da Projecao de Estoques                             ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR881(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Rodrigo Sart³19/05/98³10819A³ Acerto na impressao e totalizacao dos    ³±±
±±³            ³        ³15264A³ valores.                                 ³±±
±±³Rodrigo Sart³18/02/99³15209A³ Acerto na abertura dos indices           ³±±
±±³Cesar       ³31/03/99³XXXXXX³Manutencao na SetPrint()                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
User Function MATR881(lUsed)
Local titulo 		:=STR0001	// "Relacao da Projecao de Estoques"
LOCAL cString		:="SB1"
Local wnrel			:="MATR881"
LOCAL cDesc 		:=STR0002	//"Este programa ira imprimir a Rela‡„o da Proje‡„o de Estoques"
LOCAL tamanho		:="M"
PRIVATE aReturn	    := {STR0003,1,STR0004, 1, 2, 1, "",1 }	//"Zebrado"###"Administracao"
PRIVATE nLastKey	:= 0
PRIVATE cPerg 		:= "MTR880"
Default lAutoMacao  := .F.

// mv_par01 - Lista ? Tudo     So' c/ Saidas   So' c/ Neces.
//                    1        2               3

Pergunte(cPerg,.F.)

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc,"","",.F.,"",,Tamanho)
nParRel:=mv_par01

If nLastKey = 27
	dbClearFilter()
	Return
Endif

IF !lAutoMacao
	SetDefault(aReturn,cString)
ENDIF

If nLastKey = 27
	dbClearFilter()
	Return
Endif

RptStatus({|lEnd| R881Imp(@lEnd,wnRel,titulo,tamanho,lUsed)},titulo)

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R881Imp  ³ Autor ³ Waldemiro L. Lustosa  ³ Data ³ 13.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR881			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R881Imp(lEnd,wnRel,titulo,tamanho,lUsed)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL CbTxt,i,j
LOCAL CbCont,cabec1,cabec2
LOCAL limite       :=132
LOCAL nomeprog     :="MATR881"
LOCAL cArquivo, nTotLin
LOCAL aOrdem       := Array(6), lLista, lImprimiu
LOCAL cCondSH5     := "H5_PRODUTO != '"+Space(15)+"'"
LOCAL aPeriodos    :={}
LOCAL nTotProd     :=0,nTotal:=0
LOCAL cDrvSH5      :="TOPCONN"
Default lAutoMacao := .F.

aOrdem[1] := STR0005	//"Saldo Ant. "
aOrdem[2] := STR0006	//"Entradas   "
aOrdem[3] := STR0007	//"Saidas     "
aOrdem[4] := STR0008	//"Saldo      "
aOrdem[5] := STR0009	//"Necessidade"
aOrdem[6] := STR0010	//"Valor      "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

IF !lAutoMacao
	dbSelectArea("SH5")
	If !Empty(dbFilter())
		dbClearFilter()
	EndIf
	dbSetOrder(1)
	dbGotop()
	aPeriodos:=R881PER()
	Set Filter to &cCondSH5
	dbGotop()

	SetRegua(LastRec())

	nTotLin := Len(aPeriodos) / 6 // 6 Periodos por linha
	nTotLin := if(Len(aPeriodos) % 6 > 0,++nTotLin,nTotLin)
	While !Eof()

		IF lEnd
			@ Prow()+1,001 PSay STR0012	//"CANCELADO PELO OPERADOR"
			Exit
		EndIF

		IncRegua()

		IF li > 50
			cabec(titulo,"","",nomeprog,tamanho,18)
			@ li,00 PSay __PrtFatLine()
			li++
		EndIF
		nRec := Recno()
		DbSelectArea("SB1")
		DbSeek(cFilial+SH5->H5_PRODUTO)
		lLista := R881FILTRO(aPeriodos,nParRel)
		lImprimiu := .f.
		If Found() .and. lLista
			nTotProd:=0
			lImprimiu := .t.
			@ li,00 PSay STR0013 +B1_COD +SPACE(3) + Substr(B1_DESC,1,30) + SPACE(3) +STR0014;	//"PRODUTO: "###"UM:"
				+ B1_UM + SPACE(3)+STR0015 + Str(RetFldProd(SB1->B1_COD,"B1_LE"), Posicione("SX3", 2, "B1_LE", "X3_TAMANHO"), Posicione("SX3", 2, "B1_LE", "X3_DECIMAL")) + SPACE(3) + Upper(AllTrim(RetTitle("B1_ESTSEG"))) + ": " + Str(RetFldProd(SB1->B1_COD,"B1_ESTSEG"), Posicione("SX3", 2, "B1_ESTSEG", "X3_TAMANHO"), Posicione("SX3", 2, "B1_ESTSEG", "X3_DECIMAL")) + Space(3) + STR0016+ B1_TIPO	//"LOTE ECON: "### "TIPO: "
			li++
			dbSelectArea("SH5")
			nPerIni := 1
			While .t.
				DbGoto(nRec)
				nCol := 23
				li++
				@ li,00 PSay STR0017	//"Periodos"
				For i:= nPerIni to nPerIni+5
					if i > Len(aPeriodos)
						Exit
					endif
					@ li,nCol PSay DtoC(aPeriodos[i])
					nCol += 15
				Next i
				li+= 2
				For i := 1 to 6
					nCol := 16
					@ li,00 PSay aOrdem[i]
					For j := nPerIni to nPerIni+5
						if j > Len(aPeriodos)
							Exit
						endif
						cCampo := "H5_PER"+StrZero(j,2)
						@ li,nCol PSay &cCampo Picture "999999999999.99"
						nCol+=15
						If i == 6
							nTotProd+=&cCampo
							nTotal+=&cCampo
						EndIf
					Next
					DbSkip()
					li++
				Next
				nPerIni+=6
				if nPerIni > Len(aPeriodos)
					Exit
				endif
				If li > 50
					cabec(titulo,"","",nomeprog,tamanho,18)
					@ li,00 PSay __PrtFatLine()
					li++
				EndIf
			End
			li++
			@ li,00 PSay STR0018	//"Tot Vl. Produto:"
			@ li,16 PSay nTotProd Picture "999999999999.99"
			li++
		Endif
		dbSelectArea("SH5")
		DbGoto(nRec)
		DbSkip(6)
		If lImprimiu
			@ li,00 PSay __PrtThinLine()
			li++
		Endif
	End
	li++
	@ li,00 PSay STR0019	//"Total Valores:"
	@ li,18 PSay nTotal
			
	If li != 80
		roda(cbcont,cbtxt)
	EndIF

	if lUsed != .t.
		dbSelectArea("SH5")
		dbCloseArea()
	endif
ENDIF

dbSelectArea("SB1")
dbClearFilter()
dbSetOrder(1)

If aReturn[5] = 1
	Set Printer TO
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()

Return NIL

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R881Per    ³ Autor ³Rodrigo de A. Sartorio³ Data ³ 03/02/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina de montagem de array aperiodos para Impressao        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR881                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R881PER()
Local nTipo, i, dInicio
Local aRet:={}
Local nPosAno, nTamAno, cForAno
Local lConsSabDom:=.f.
Default lAutoMacao := .F.

Pergunte("MTA710",.F.)
lConsSabDom:=mv_par17 == 1

If __SetCentury()
	nPosAno := 1
	nTamAno := 4
	cForAno := "ddmmyyyy"
Else	
	nPosAno := 3
	nTamAno := 2
	cForAno := "ddmmyy"
Endif

IF !lAutoMacao
	nTipo   := SH5->H5_TIPOPER
	dInicio := SH5->H5_DTINI
ELSE
	nTipo   := 7
	dInicio := dDataBase
ENDIF
if (nTipo == 2)                         // Semanal
	While Dow(dInicio)!=2
		dInicio--
	end
elseif (nTipo == 3) .or. (nTipo=4)      // Quinzenal ou Mensal
	dInicio:= CtoD("01"+Substr(Dtoc(dInicio),3),cForAno)
elseif (nTipo == 5)                     // Trimestral
	if Month(dInicio) < 4
		dInicio := CtoD("01/01/"+Substr(DtoC(dInicio),7),cForAno)
	elseif (Month(dInicio) >= 4) .and. (Month(dInicio) < 7)
		dInicio := CtoD("01/04/"+Substr(DtoC(dInicio),7),cForAno)
	elseif (Month(dInicio) >= 7) .and. (Month(dInicio) < 10)
		dInicio := CtoD("01/07/"+Substr(DtoC(dInicio),7),cForAno)
	elseif (Month(dInicio) >=10)
		dInicio := CtoD("01/10/"+Substr(DtoC(dInicio),7),cForAno)
	endif
elseif (nTipo == 6)                     // Semestral
	if Month(dInicio) <= 6
		dInicio := CtoD("01/01/"+Substr(DtoC(dInicio),7),cForAno)
	else
		dInicio := CtoD("01/07/"+Substr(DtoC(dInicio),7),cForAno)
	endif
endif
If nTipo != 7
	For i := 1 to Val(H5_TIPO)
		AADD(aRet,dInicio)
		if nTipo == 1
			dInicio ++
			While !lConsSabDom .And. ( DOW(dInicio) == 1 .or. DOW(dInicio) == 7 )
				dInicio++
			end
		elseif nTipo == 2
			dInicio+=7
		elseif nTipo == 3
			dInicio := CtoD(if(Substr(DtoC(dInicio),1,2)="01","15"+Substr(DtoC(dInicio),3),;
				"01/"+if(Month(dInicio)+1<=12,StrZero(Month(dInicio)+1,2)+"/"+;
				SubStr(DtoC(dInicio),7),"01/"+Substr(Str(Year(dInicio)+1,4),nPosAno,nTamAno))),cForAno)
		elseif nTipo == 4
			dInicio := CtoD("01/"+if(Month(dInicio)+1<=12,StrZero(Month(dInicio)+1,2)+;
				"/"+Substr(Str(Year(dInicio),4),nPosAno,nTamAno),"01/"+Substr(Str(Year(dInicio)+1,4),nPosAno,nTamAno)),cForAno)
		elseif nTipo == 5
			dInicio := CtoD("01/"+if(Month(dInicio)+3<=12,StrZero(Month(dInicio)+3,2)+;
				"/"+Substr(Str(Year(dInicio),4),nPosAno,nTamAno),"01/"+Substr(Str(Year(dInicio)+1,4),nPosAno,nTamAno)),cForAno)
		elseif nTipo == 6
			dInicio := CtoD("01/"+if(Month(dInicio)+6<=12,StrZero(Month(dInicio)+6,2)+;
				"/"+Substr(Str(Year(dInicio),4),nPosAno,nTamAno),"01/"+Substr(Str(Year(dInicio)+1,4),nPosAno,nTamAno)),cForAno)
		endif
	Next i
Else
	IF !lAutoMacao
		dbSelectArea("SH5")
		dbGoTop()
		cTipo := H5_TIPO
		While !Eof() .And. H5_TIPO == cTipo
			AADD(aRet,H5_DTINI)
			dbSkip()
		End
	ENDIF
Endif
Return aRet

Static Function R881FILTRO(aPeriodos,nTipo)
Local ni,lRet := .f.,cAlias := Alias(),nReg := SH5->(Recno())
If nTipo == 1
	Return .t.
Endif
dbSelectArea("SH5")
If nTipo == 2
	dbSkip(2)
	For ni := 1 to Len(aPeriodos) 	
			cCampo := "H5_PER"+StrZero(ni,2)
			If &(cCampo) != 0
				lRet := .t.
				Exit
			Endif
	Next
ElseIf nTipo == 3
	dbSkip(4)
	For ni := 1 to Len(aPeriodos) 	
			cCampo := "H5_PER"+StrZero(ni,2)
			If &(cCampo) != 0
				lRet := .t.
				Exit
			Endif
	Next
Endif
dbSelectArea(cAlias)
SH5->(dbGoto(nReg))
Return (lRet)
