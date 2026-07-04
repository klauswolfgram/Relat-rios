/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "finr875.ch"
#INCLUDE "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR875      ³Autor ³ Cristiano Denardi    ³Data³ 02.05.05   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio com a relacao de titulos retentores e retidos      ³±±
±±³          ³ conforme Lei 10.925                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Manutencao Efetuada                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Pedro P Lima³08/11/07³132956³ Foram ajustados os tamanhos dos campos para³±±
±±³  TI6434    ³        ³      ³ as linhas com os valores, que estavam fora ³±±
±±³            ³        ³      ³ de alinhamento. Tambem foi feito o         ³±±
±±³            ³        ³      ³ tratamento que considerava as baixas       ³±±
±±³            ³        ³      ³ canceladas e duplicava os registros no     ³±±
±±³            ³        ³      ³ corpo do relatorio.                        ³±±
±±³            ³        ³      ³ Foi realizada tambem uma manutencao        ³±±                                      
±±³            ³        ³      ³ para o erro contido no BOPS 128048, que nao³±±                                      
±±³            ³        ³      ³ foi gerado para a versao 9.12.             ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR875

Local cDesc1		:= STR0001 //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2		:= STR0002 //"dos Titulos Retentores e Retidos pela lei n.10.925."
Local cDesc3		:= ""

Local titulo		:= STR0003 //"Relacao de Titulos Retentores e Retidos pela lei n.10.925"
Local titulo0		:= STR0011 //"Relacao de Titulos Retentores e Retidos pela lei n.10.925 (Filiais selecionadas para o relatorio)"

Local nLin			:= 80
Local lPrint		:= .F.

Local Cabec0		:= STR0012 //"Código         Empresa                                      Unidade de Negócio           Filial"

Local Cabec1		:= STR0014+Space(70)+STR0015 //"TITULO RETENTOR   TITULOS COM IMPOSTOS RETIDOS NO TITULO RETENTOR"
Local Cabec2		:= ""
Local imprime		:= .T.
Local aOrd			:= {}   
Local nTamNum		:= TamSx3("E2_NUM")[1]
Local nTamParc		:= TamSx3("E2_PARCELA")[1]
Local nTamTipo		:= TamSx3("E2_TIPO")[1]
Local nTamForn		:= TamSx3("E2_FORNECE")[1]
Local nTamLoja		:= TamSx3("E2_LOJA")[1]
Local nTamVal		:= TamSx3("E2_VRETPIS")[1]

Private lEnd		:= .F.
Private lAbortPrint	:= .F.
Private limite		:= 220
Private tamanho		:= "G"
Private nomeprog	:= "FINR875"
Private nTipo		:= 18
Private aReturn		:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey	:= 0
Private cPerg		:= "FIR875"
Private cbtxt		:= Space(10)
Private cbcont		:= 00
Private CONTFL		:= 01
Private m_pag		:= 01
Private wnrel		:= nomeprog
Private cString 	:= ""
Private cBx10925	:= 0
Private cAliasBsc	:= ""
Private lBx2		:= .F.

//Montagem do Cabe‡alho 

//STR0016+Space(2)+STR0017+Space(4)+STR0018+Space(3)+STR0019+Space(2)+STR0020+Space(15)+STR0021+Space(2)+STR0022+Space(21)+STR0016+Space(4)+STR0017+Space(7)+STR0018+Space(4)+STR0019+Space(6)+STR0020+Space(12)+STR0021+Space(4)+STR0022+Space(8)+STR0023+Space(8)+STR0024+Space(10)+STR0025 //"Prf Numero P Tpo Cod.Fo Lj Nome Fornecedor                    Prf Numero P Tpo Cod.Fo Lj Nome Fornecedor                          Vlr PIS        Vlr COFINS          Vlr CSLL"
//"Prf Numero P Tpo Cod.Fo Lj Nome Fornecedor                    Prf Numero P Tpo Cod.Fo Lj Nome Fornecedor                          Vlr PIS        Vlr COFINS          Vlr CSLL"
Cabec2 := STR0016 + Space(1)								//Prf
Cabec2 += STR0017 + Space((nTamNum  - Len(STR0017)) + 1 )	//Numero
Cabec2 += STR0018 + Space((nTamParc - Len(STR0018)) + 1 )	//P
Cabec2 += STR0019 + Space((nTamTipo - Len(STR0019)) + 1 )	//Tpo
Cabec2 += STR0020 + Space((nTamForn - Len(STR0020)) + 1 )	//Cod.Fo
Cabec2 += STR0021 + Space((nTamLoja - Len(STR0021)) + 1 )	//Lj
Cabec2 += STR0022 + Space((30 - Len(STR0022)) + 5 )			//Nome Fornecedor
Cabec2 += STR0016 + Space(1)								//Prf
Cabec2 += STR0017 + Space((nTamNum  - Len(STR0017)) + 1 )	//Numero
Cabec2 += STR0018 + Space((nTamParc - Len(STR0018)) + 1 )	//P
Cabec2 += STR0019 + Space((nTamTipo - Len(STR0019)) + 1 )	//Tpo
Cabec2 += STR0020 + Space((nTamForn - Len(STR0020)) + 1 )	//Cod.Fo
Cabec2 += STR0021 + Space((nTamLoja - Len(STR0021)) + 1 )	//Lj
Cabec2 += PADR(STR0022,30) + Space(4)						//Nome Fornecedor
Cabec2 += PadL(Alltrim(STR0023),nTamVal) + Space(3)			//Vlr PIS
Cabec2 += PadL(Alltrim(STR0024),nTamVal) + Space(3)			//Vlr COFINS
Cabec2 += PadL(Alltrim(STR0025),nTamVal) 					//Vlr CSLL

cBx10925 := GetNewPar("MV_BX10925","3")
Do Case 
	Case cBx10925 == "1"
		cAliasBsc := "SE5"
		cString   := "SE5"
		
	Case cBx10925 == "2"
		cAliasBsc := "SE2"
		cString   := "SE2"
		lBx2	  := .T.
		
	/////////////////////////////////////////////
	// Nao Existe MV_BX10925
	// provalvel que todos os parametros e campos
	// nao tenham sidos criados.
	Case cBx10925 == "3" 
		MsgAlert(STR0010) //"Paramentro MV_BX10925 inexistente, favor rodar a rotina U_AtuMP10925 para cria-lo."
		Return
		
End Case

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ POR MAIS ESTRANHO QUE PARE€A, ESTA FUNCAO DEVE SER CHAMADA AQUI! ³
//³                                                                  ³
//³ A fun‡„o SomaAbat reabre o SE2 com outro nome pela ChkFile para  ³
//³ efeito de performance. Se o alias auxiliar para a SumAbat() n„o  ³
//³ estiver aberto antes da IndRegua, ocorre Erro de & na ChkFile,   ³
//³ pois o Filtro do SE2 uptrapassa 255 Caracteres.                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SomaAbat("","","","P")

dbSelectArea(cAliasBsc)
dbSetOrder(1)

lPrint := pergunte(cPerg,.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01            // Da  Data                          ³
//³ mv_par02            // At‚ Data                          ³
//³ mv_par03            // Do  Fornecedor                    ³
//³ mv_par04            // At‚ Fornecedor                    ³
//³ mv_par05            // Da  Loja                          ³
//³ mv_par06            // At‚ Loja                          ³
//³ mv_par07            // Selecionar Filiais ?              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
If lPrint
	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)
	
	If nLastKey == 27
		Return
	Endif
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
	   Return
	Endif
	
	nTipo := If(aReturn[4]==1,15,18)
	
	RptStatus({|| FINR875Rpt(Cabec0,Cabec1,Cabec2,Titulo0,Titulo,nLin) },Titulo)
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR875Rpt   ³Autor ³ Cristiano Denardi    ³Data³ 02.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento do relatorio	                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FINR875Rpt(Cabec0,Cabec1,Cabec2,Titulo0,Titulo,nLin)

Local nOrdem	:= 0     
Local nIndOrd	:= 0
Local aTam		:= {}
Local cNomArq	:= ""
Local nLoop		:= 0
Local cQuery	:= ""
Local cKey		:= ""
Local cFiltro	:= ""
Local cChvSFQ	:= ""
Local aTotSFQ	:= {}
Local aTot		:= {}
Local cNomeFor	:= ""
Local nQtdTit	:= 0
Local nTotPis	:= 0
Local nTotCof	:= 0
Local nTotCSL	:= 0
Local nPis    := 0
Local nCof    := 0
Local nCsl    := 0
Local cPictPis  := PesqPict("SE5","E5_VRETPIS")
Local cPictCof  := PesqPict("SE5","E5_VRETCOF")
Local cPictCSL  := PesqPict("SE5","E5_VRETCSL")

Local aAreaSM0
Local lGestao   := ( FWSizeFilial() > 2 )
Local lSE2Excl  := Iif( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
Local lSE5Excl  := Iif( lGestao, FWModeAccess("SE5",1) == "E", FWModeAccess("SE5",3) == "E")
Local nX := 1
Local nC := 1
Local aSelFil := {}
Local cFilialAnt := cFilAnt
Local lPrtFil := .T.
Local aSM0 := {}
Local cFilQry := ""
Local lPrtTotais := .F.
Local lSE2Mode	:= FWModeAccess("SE2") == "E"
Local lSE5Mode	:= FWModeAccess("SE5") == "E"

Local nTamNum	:= TamSx3("E2_NUM")[1]
Local nTamParc	:= TamSx3("E2_PARCELA")[1]
Local nTamTipo	:= TamSx3("E2_TIPO")[1]
Local nTamForn	:= TamSx3("E2_FORNECE")[1]
Local nTamLoja	:= TamSx3("E2_LOJA")[1]
Local nTamVal	:= TamSx3("E2_VRETPIS")[1]
Local nColPis	:= 0
Local nColCof	:= 0
Local nColCsl	:= 0

Private lQuery	:= .F.

#IFDEF TOP
   If TcSrvType() != "AS/400"
      lQuery := .T.
   Endif
#ENDIF

// Chave de Ordenacao
If lBx2
	cKey := "E2_FILIAL+E2_FORNECE+E2_LOJA+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO"

#IFDEF TOP
	If (lSE2Excl .and. mv_par07 == 1)
		aAreaSM0 := SM0->(GetArea())
		If lGestao
			aSelFil := FwSelectGC()
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SE2")
		EndIf
		RestArea(aAreaSM0)
	Endif

	If mv_par07 == 1 .And. Empty(aSelFil)//Usuario nao selecionou filial
		mv_par07 := 2
	EndIf

	If mv_par07 == 1
		aSort(aSelFil)
		aSM0 := FWLoadSM0()
		nTamEmp := Len(FWSM0LayOut(,1))
		nTamUnNeg := Len(FWSM0LayOut(,2))
		For nX := 1 To Len(aSelFil)
			If nLin > 55
				nLin := cabec(titulo0,cabec0,"",nomeprog,tamanho,GetMv("MV_COMP"))
				nLin++
			EndIf
			nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX] .And. sm0[SM0_GRPEMP] == cEmpAnt})
			If nLinha > 0
				cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
				@ nLin,0 PSAY cFilSel
				@ nLin,15 PSAY aSM0[nLinha,SM0_DESCEMP]
				@ nLin,60 PSAY aSM0[nLinha,SM0_DESCUN]
				@ nLin++,90 PSAY aSM0[nLinha,SM0_NOMRED]
			Endif
		Next
		nLin := 80
	Else
		aSelFil := {cFilAnt}
	EndIf
#ENDIF
Else
	cKey := "E5_FILIAL+E5_CLIFOR+E5_LOJA+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO"
#IFDEF TOP
	If (lSE5Excl .and. mv_par07 == 1)
		aAreaSM0 := SM0->(GetArea())
		If lGestao
			aSelFil := FwSelectGC()
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SE2")
		EndIf
		RestArea(aAreaSM0)
	Endif

	If mv_par07 == 1 .And. Empty(aSelFil)//Usuario nao selecionou filial
		mv_par07 := 2
	EndIf

	If mv_par07 == 1
		aSort(aSelFil)
		nTamEmp := Len(FWSM0LayOut(,1))
		nTamUnNeg := Len(FWSM0LayOut(,2))
		For nX := 1 To Len(aSelFil)
			If nLin > 55
				nLin := cabec(titulo0,cabec0,"",nomeprog,tamanho,GetMv("MV_COMP"))
				nLin++
			EndIf
			nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX] .And. sm0[SM0_GRPEMP] == cEmpAnt})
			If nLinha > 0
				cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
				@ nLin,0 PSAY cFilSel
				@ nLin,15 PSAY aSM0[nLinha,SM0_DESCEMP]
				@ nLin,60 PSAY aSM0[nLinha,SM0_DESCUN]
				@ nLin++,90 PSAY aSM0[nLinha,SM0_NOMRED]
			Endif
		Next
		nLin := 80
	Else
		aSelFil := {cFilAnt}
	EndIf
#ENDIF
Endif

For nC := 1 To Len(aSelFil)

	cFilAnt := aSelFil[nC]
	nOrdem	:= 0     
	nIndOrd := 0
	aTam := {}
	cNomArq := ""
	nLoop := 0
	cQuery := ""
	cFiltro := ""
	cChvSFQ := ""
	aTotSFQ := {}
	aTot := {}
	cNomeFor := ""
	nQtdTit := 0
	nTotPis := 0
	nTotCof := 0
	nTotCSL := 0
	lPrtFil := .T.

	ChkFile(cAliasBsc,.F.,"newAR")

	If lQuery
		cQuery += " Select "        
		If lBx2
			cQuery += " E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_NATUREZ, E2_FORNECE, E2_LOJA, "
			cQuery += " E2_EMISSAO, E2_VENCTO, E2_VENCREA, E2_VALOR, E2_BAIXA, E2_MOTIVO, E2_SALDO, E2_DESCONT, "
			cQuery += " E2_MULTA, E2_JUROS, E2_CORREC, E2_VALLIQ, E2_VENCORI, E2_VALJUR, E2_PORCJUR, E2_DTVARIA, "
			cQuery += " E2_VLCRUZ, E2_ACRESC, E2_TITORIG, E2_TXMOEDA, E2_PARCPIS, E2_PARCCOF, E2_PARCSLL, "
			cQuery += " E2_PIS, E2_COFINS, E2_CSLL, E2_TITPIS, E2_TITCOF, E2_TITCSL, E2_VRETPIS, E2_VRETCOF, "
			cQuery += " E2_VRETCSL, E2_PRETPIS, E2_PRETCOF, E2_PRETCSL, E2_SEQBX, E2_BASEPIS, E2_BASECOF, E2_BASECSL, E2_FILORIG "
			cQuery += " From " + RetSqlName( "SE2" ) + " SE2 " 
			cQuery += " Where "                    
			cQuery += " E2_FILIAL = '" + xFilial("SE2") + "' " 
			cQuery += " and D_E_L_E_T_ != '*' "
		Else
			cQuery += " E5_FILIAL, E5_DATA, E5_TIPO, E5_VALOR, E5_NATUREZ, E5_DOCUMEN, E5_VENCTO, E5_RECPAG, E5_TIPODOC, "
			cQuery += " E5_VLMOED2, E5_LA, E5_SITUACA, E5_LOTE, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_CLIFOR, E5_LOJA, "
			cQuery += " E5_DTDIGIT, E5_MOTBX, E5_SEQ, E5_DTDISPO, E5_ORDREC, E5_FILORIG, E5_VLJUROS, E5_VLMULTA, E5_VLCORRE, "
			cQuery += " E5_VLDESCO, E5_CNABOC, E5_SITUA, E5_TXMOEDA, E5_VRETPIS, E5_VRETCOF, E5_VRETCSL, E5_PRETPIS, "
			cQuery += " E5_PRETCOF, E5_PRETCSL "
			cQuery += " From " + RetSqlName( "SE5" ) + " SE5 " 
			cQuery += " Where "                    
			cQuery += " E5_FILIAL = '" + xFilial("SE5") + "' " 
			cQuery += " and D_E_L_E_T_ != '*' "
		Endif
		///////////////////////
		// Filtro das Perguntas
		If lBx2
			cQuery += " and E2_VENCREA >= '" + DtoS(mv_par01) + "' "
			cQuery += " and E2_VENCREA <= '" + DtoS(mv_par02) + "' "
			cQuery += " and E2_FORNECE >= '" + mv_par03       + "' "
			cQuery += " and E2_FORNECE <= '" + mv_par04       + "' "
			cQuery += " and E2_LOJA    >= '" + mv_par05       + "' "
			cQuery += " and E2_LOJA    <= '" + mv_par06       + "' "
			//////////////////////////////////
			// Somente Tit. Retentor da 10.925
			cQuery += " and E2_VRETPIS+E2_VRETCOF+E2_VRETCSL > 0 "
			cQuery += " and E2_PRETPIS IN (' ','4') "
			cQuery += " and E2_PRETCOF IN (' ','4') "
			cQuery += " and E2_PRETCSL IN (' ','4') "
		Else
			cQuery += " and E5_DATA   >= '" + DtoS(mv_par01) + "' "
			cQuery += " and E5_DATA   <= '" + DtoS(mv_par02) + "' "
			cQuery += " and E5_CLIFOR >= '" + mv_par03       + "' "
			cQuery += " and E5_CLIFOR <= '" + mv_par04       + "' "
			cQuery += " and E5_LOJA   >= '" + mv_par05       + "' "
			cQuery += " and E5_LOJA   <= '" + mv_par06       + "' "
			//////////////////////////////////
			// Somente Tit. Retentor da 10.925
			cQuery += " and E5_VRETPIS+E5_VRETCOF+E5_VRETCSL > 0 "
			cQuery += " and E5_PRETPIS IN (' ','4') "
			cQuery += " and E5_PRETCOF IN (' ','4') "
			cQuery += " and E5_PRETCSL IN (' ','4') "
		Endif
		If !lBx2
			cQuery += " and E5_SITUACA <> 'C' "
		EndIf
		cQuery += " Order By " + StrTran( cKey, "+", "," )
		
		(cAliasBsc)->(DBCLOSEAREA())
		cQuery := ChangeQuery(cQuery)
		If lBx2
			cQuery := FBX2(cQuery)
		Endif
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasBsc, .F., .T.)
	Else
		//////////////////
		// Chave de filtro 
			cFiltro := "E5_FILIAL == xFilial('SE5')"
			///////////////////////
			// Filtro das Perguntas   
			If lBX2
				cFiltro += " .And. "
				cFiltro += " ( E2_VENCREA >= mv_par01 .And. E2_VENCREA <= mv_par02 ) "
				cFiltro += " .And. "
				cFiltro += " ( E2_FORNECE >= mv_par03 .And. E2_FORNECE <= mv_par04 ) "
				cFiltro += " .And. "
				cFiltro += " ( E2_LOJA >= mv_par05 .And. E2_LOJA <= mv_par06 ) "
			Else
				cFiltro += " .And. "
				cFiltro += " ( E5_DATA >= mv_par01 .And. E5_DATA <= mv_par02 ) "
				cFiltro += " .And. "
				cFiltro += " ( E5_CLIFOR >= mv_par03 .And. E5_CLIFOR <= mv_par04 ) "
				cFiltro += " .And. "
				cFiltro += " ( E5_LOJA >= mv_par05 .And. E5_LOJA <= mv_par06 ) "
			Endif
			//////////////////////////////////
			// Somente Tit. Retentor da 10.925
			cFiltro += " .And. "
			cFiltro += " ( E5_VRETPIS >0 .OR. E5_VRETCOF >0 .OR. E5_VRETCSL > 0 ) "
			
			cFiltro += " .And. "
			cFiltro += " ( E5_PRETPIS $ ' #4' ) "
			cFiltro += " .And. "
			cFiltro += " ( E5_PRETCOF $ ' #4' ) "
			cFiltro += " .And. "
			cFiltro += " ( E5_PRETCSL $ ' #4' ) "
			If !lBx2
				cFiltro += " .And. "    
				cFiltro += " ( E5_SITUACA != 'C' ) "
		EndIf

		// Chave de filtro
		//////////////////
		
		If lBX2
			cFiltro := FBX2(cFiltro)
		Endif                 
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria arquivo de Trabalho                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cNomArq := CriaTrab(,.F.)
		
		IndRegua(cAliasBsc,cNomArq,cKey,,cFiltro,OemToAnsi(STR0006)) //"Selecionando Registros..."
		nIndOrd := RetIndex(cAliasBsc)
				
		#IFNDEF TOP 
			dbSetIndex( cNomArq + OrdBagExt() )
		#ENDIF 	

	Endif

	dbSelectarea(cAliasBsc)
	#IFNDEF TOP 
		dbSetOrder(nIndOrd+1)
	#ENDIF 	
	dbGoTop()

	SetRegua(RecCount())

	If lbx2
		cFilQry := Iif(lSE2Mode,(cAliasBsc)->E2_FILIAL,(cAliasBsc)->E2_FILORIG)
	Else
		cFilQry := Iif(lSE5Mode,(cAliasBsc)->E5_FILIAL,(cAliasBsc)->E5_FILORIG)
	EndIf

	While !( (cAliasBsc)->(EOF()) ) .And. cFilAnt == cFilQry

		nLoop++
		nTotPis	:= 0
		nTotCof	:= 0
		nTotCSL	:= 0

		If lAbortPrint
			@nLin,00 PSAY STR0007 //"*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		//Desconsidero as baixas estornadas caso MV_BX10925 = 1
		If !lBx2 .and. TemBxCanc((cAliasBsc)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))	
			(cAliasBsc)->(dbSkip())
			If lbx2
				cFilQry := Iif(lSE2Mode,(cAliasBsc)->E2_FILIAL,(cAliasBsc)->E2_FILORIG)
			Else
				cFilQry := Iif(lSE5Mode,(cAliasBsc)->E5_FILIAL,(cAliasBsc)->E5_FILORIG)
			EndIf
			Loop
		Endif		

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do cabecalho do relatorio. . .                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif
		
		If ( nLoop == 1 )
			nLin++
		Endif       

		If lPrtFil .And. mv_par07 == 1
			If nLin > 55
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif
			nLin += 2
			If lBx2
				@nLin,0 PSAY STR0013 + xFilial("SE2") // "Filial : "
			Else
				@nLin,0 PSAY STR0013 + xFilial("SE5") // "Filial : "
			EndIf
			nLin += 2
			lPrtFil := .F.
		EndIf

		// Titulo Retentor
		nColuna := 0
		@nLin,nColuna pSay If( lBX2, SE2->E2_PREFIXO, SE5->E5_PREFIXO )
		nColuna += 4
		@nLin,nColuna pSay If( lBX2, SE2->E2_NUM    , SE5->E5_NUMERO  )
		nColuna += nTamNum + 1
		@nLin,nColuna pSay If( lBX2, SE2->E2_PARCELA, SE5->E5_PARCELA )
		nColuna += nTamParc + 1
		@nLin,nColuna pSay If( lBX2, SE2->E2_TIPO   , SE5->E5_TIPO    )
		nColuna += nTamTipo + 1
		@nLin,nColuna pSay If( lBX2, SE2->E2_FORNECE, SE5->E5_CLIFOR )
		nColuna += nTamForn + 1
		@nLin,nColuna pSay If( lBX2, SE2->E2_LOJA   , SE5->E5_LOJA   )
		If LBX2
			cNomeFor := FR875NmFor( SE2->E2_FORNECE , SE2->E2_LOJA )
		Else
			cNomeFor := FR875NmFor( SE5->E5_CLIFOR  , SE5->E5_LOJA )
		Endif
		nColuna += nTamLoja + 1
		@nLin,nColuna pSay SubStr( cNomeFor, 1, 30 )
		nColuna += 31
		@nLin,nColuna pSay "->"
		nColuna += 4

		If lBX2
			cChvSFQ := "xFilial('SFQ')+'SE2'+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA"	
		Else
			If SE5->E5_MOTBX == "PCC" //Impostos gerados pelo bordero
				cChvSFQ := "xFilial('SFQ')+'SE2'+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA"	
			Else
				cChvSFQ := "xFilial('SFQ')+'SE5'+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA"			
			Endif
		Endif
		
		//////////////////
		// Titulos Retidos
		dbSelectArea("SFQ")
		dbSetOrder(1)
		If dbSeek( &cChvSFQ )
			While !Eof() .And. &cChvSFQ == FQ_FILIAL+FQ_ENTORI+FQ_PREFORI+FQ_NUMORI+FQ_PARCORI+FQ_TIPOORI+FQ_CFORI+FQ_LOJAORI
				lIsBord := (SE5->E5_MOTBX == "PCC" .and. !lBx2)		
				aTotSFQ	:= FR875VlRet( FQ_PREFDES, FQ_NUMDES, FQ_PARCDES, FQ_TIPODES, FQ_CFDES, FQ_LOJADES, FQ_SEQDES , , lIsBord  )
				nQtdTit	+= 1
				nTotPis	+= aTotSFQ[1]
				nTotCof	+= aTotSFQ[2]
				nTotCSL	+= aTotSFQ[3]
			
				nColRet := nColuna
				@nLin,nColRet pSay FQ_PREFDES
				nColRet += 4
				@nLin,nColRet pSay FQ_NUMDES
				nColRet += nTamNum + 1
				@nLin,nColRet pSay FQ_PARCDES
				nColRet += nTamParc + 1
				@nLin,nColRet pSay FQ_TIPODES
				nColRet += nTamTipo + 1
				@nLin,118 pSay FQ_CFDES
				nColRet += nTamForn + 1
				@nLin,138 pSay FQ_LOJADES	
				nColRet += nTamLoja + 1

				cNomeFor := FR875NmFor( FQ_CFDES, FQ_LOJADES ) 			
				@nLin,nColRet pSay SubStr( cNomeFor, 1, 30 )
				nColRet += 31
				@nLin,nColRet pSay aTotSFQ[1] Picture cPictPis
				nColRet += (nTamVal + 2)
				@nLin,nColRet pSay aTotSFQ[2] Picture cPictCof
				nColRet += (nTamVal + 2)
				@nLin,nColRet pSay aTotSFQ[3] Picture cPictCSL
				
				nLin++
				SFQ->(dbSkip())
			EndDo
		Endif              
		
		dbSelectArea(cAliasBsc)     
		
		/////////////////////////////////
		// Adiciona tb o Titulo retentor
		// como retido e usa seus valores
		If lBX2
			aTot := FR875VlRet( E2_PREFIXO, E2_NUM   , E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA,       , .T. )
		Else
			aTot := FR875VlRet( E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR , E5_LOJA, E5_SEQ, .T. )
		Endif

		nColRet := nColuna
		@nLin,nColRet pSay If( lBX2, SE2->E2_PREFIXO, SE5->E5_PREFIXO )
		nColRet += 4
		@nLin,nColRet pSay If( lBX2, SE2->E2_NUM    , SE5->E5_NUMERO  )
		nColRet += nTamNum + 1
		@nLin,nColRet pSay If( lBX2, SE2->E2_PARCELA, SE5->E5_PARCELA )
		nColRet += nTamParc + 1
		@nLin,nColRet pSay If( lBX2, SE2->E2_TIPO   , SE5->E5_TIPO    )
		nColRet += nTamTipo + 1
		@nLin,nColRet pSay If( lBX2, SE2->E2_FORNECE, SE5->E5_CLIFOR )
		nColRet += nTamForn + 1
		@nLin,nColRet pSay If( lBX2, SE2->E2_LOJA   , SE5->E5_LOJA   )
		nColRet += nTamLoja + 1

		If lBX2
			cNomeFor := FR875NmFor( SE2->E2_FORNECE, SE2->E2_LOJA )
		Else
			cNomeFor := FR875NmFor( SE5->E5_CLIFOR , SE5->E5_LOJA )
		Endif	
		@nLin,nColRet pSay SubStr( cNomeFor, 1, 30 )
		nColRet += 31
		nColPis := nColRet
		@nLin,nColRet pSay (aTot[1]-nTotPis) Picture cPictPis
		nColRet += (nTamVal + 2)
		nColCof := nColRet
		@nLin,nColRet pSay (aTot[2]-nTotCof) Picture cPictCof
		nColRet += (nTamVal + 2)
		nColCsl := nColRet
		@nLin,nColRet pSay (aTot[3]-nTotCSL) Picture cPictCSL		
		
		nQtdTit += 1
		nTotPis	+= aTot[1]-nTotPis
		nTotCof	+= aTot[2]-nTotCof
		nTotCSL	+= aTot[3]-nTotCSL
		//"Total Geral do PCC"
		nPis += nTotPis
		nCof += nTotCof
		nCsl += nTotCSL

		lPrtTotais := .T.

		nLin++

		(cAliasBsc)->(dbSkip())

		If lbx2
			cFilQry := Iif(lSE2Mode,(cAliasBsc)->E2_FILIAL,(cAliasBsc)->E2_FILORIG)
		Else
			cFilQry := Iif(lSE5Mode,(cAliasBsc)->E5_FILIAL,(cAliasBsc)->E5_FILORIG)
		EndIf
	EndDo
	newAR->(dbCloseArea())
	#IFDEF TOP
		(cAliasBsc)->(dbCloseArea())
		ChKFile(cAliasBsc)
		dbSelectArea(cAliasBsc)
		dbSetOrder(1)
	#ENDIF

	If lPrtTotais
		////////
		// TOTAL
		nLin++
		nColPis := IIF(nColPis == 0, 156,nColPis)
		nColCof := IIF(nColCof == 0, 172,nColCof)		
		nColCsl := IIF(nColCsl == 0, 190,nColCsl)
		@nLin,nColPis - 20 pSay STR0008 //"Totais"
		@nLin,nColPis pSay nPis Picture cPictPis
		@nLin,nColCof pSay nCof Picture cPictCof
		@nLin,nColCsl pSay nCSL Picture cPictCSL
		
		nLin++
		@nLin,nColPis - 31  pSay STR0009 //"Qtde Tit. Retidos"
		@nLin,nColPis pSay nQtdTit Picture "@E 999,999"

		nLin++
		nLin++
		lPrtTotais := .F.
	EndIf

Next

cFilAnt := cFilialAnt
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()        

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FR875NmFor   ³Autor ³ Cristiano Denardi    ³Data³ 02.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Busca nome de Fornecedor 								  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR875NmFor( cCod, cLj )

Local aAreaSFQ	:= SFQ->(GetArea())
Local aAreaSE5	:= (cAliasBsc)->(GetArea())
Local cNom		:= ""

Default cCod	:= ""
Default cLj		:= ""

dbSelectArea("SA2")
dbSetOrder(1)
If DbSeek( xFilial("SA2")+cCod+cLj )
	cNom := GetLGPDValue("SA2","A2_NOME")
Endif

RestArea( aAreaSE5 )
RestArea( aAreaSFQ )
Return( cNom )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FR875VlRet   ³Autor ³ Cristiano Denardi    ³Data³ 02.05.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Busca valores de PIS, Cofins e CSSL do titulo retido       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR875VlRet( cPref, cNum, cParc, cTp, cCod, cLj, cSeq, lRet, lIsBord  )

Local aAreaSFQ	:= SFQ->(GetArea())
Local aAreaSE5	:= (cAliasBsc)->(GetArea())
Local aTot		:= {}

Default cPref	:= ""
Default cNum	:= ""
Default cParc	:= ""
Default cTp		:= ""
Default cCod	:= ""
Default cLj		:= ""
Default cSeq	:= ""
Default lIsBord	:= .F.

dbSelectArea("newAR")
dbSetOrder( If(lBX2,1,7) )
If DbSeek( xFilial(cAliasBsc)+cPref+cNum+cParc+cTp+cCod+cLj+cSeq )
	If lBX2
		If lRet // Titulo Retentor
			aTot := {E2_VRETPIS,E2_VRETCOF,E2_VRETCSL}
		Else
			aTot := {E2_PIS,E2_COFINS,E2_CSLL}
		Endif
	Else
		aTot := {E5_VRETPIS,E5_VRETCOF,E5_VRETCSL}
	Endif
Else                                                                                       	
	If lIsBord .and. !lRet .and. !lBX2
		__SE2->(dbSetOrder(1))
		If __SE2->(MsSeek(xFilial("SE2")+(cAliasBsc)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
			aTot := {__SE2->E2_PIS,__SE2->E2_COFINS,__SE2->E2_CSLL}
		Else
			aTot := { 0, 0, 0 }		
		Endif
	Else
		aTot := { 0, 0, 0 }
	Endif
Endif

RestArea( aAreaSE5 )
RestArea( aAreaSFQ )
Return( aTot )

// Troca as string de E5 para E2
// para quando MV_BX10925 == 2
Static Function FBX2( cTxt )
	cTxt := StrTran( cTXT, "E5", "E2" )
Return cTxt