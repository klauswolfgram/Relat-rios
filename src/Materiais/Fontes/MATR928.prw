/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.Ch"
#Include "Matr928.Ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³MATR928      ³Autor³ Sergio S. Fuzinaka   ³ Data ³    27.09.04    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Demonstrativo das Prestacoes de Servico de Transporte e do Credito³±±
±±³          ³Outorgado                                                     	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     		³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   		³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                            	³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr928()

Local wnRel		:= ""
Local cString	:= "SF3"
Local cPerg		:= "MTR928"
Local cTam		:= "G"
Local cTitulo	:= STR0001	//"Demonstrativo das Prestacoes de Servico de Transporte e do Credito Outorgado"
Local cDescr1	:= STR0002	//"Este programa emitira o Relatorio Demonstrativo das Prestacoes de Servico de"
Local cDescr2	:= STR0003	//"Transporte e do Credito Outorgado."
Local lVerpesssen := Iif(FindFunction("Verpesssen"),Verpesssen(),.T.)

Private aReturn	:= {STR0004,1,STR0005,2,2,1,"",1}	//"Zebrado"###"Administracao"
Private lEnd  	:= 	.F.		// Controle de cancelamento do relatorio
Private m_pag 	:= 	1  		// Contador de Paginas

If lVerpesssen
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                                    ³
	//³ mv_par01        // Data Inicial                                         ³
	//³ mv_par02        // Data Final                                           ³
	//³ mv_par03        // Somente SP                                           ³
	//³ mv_par04        // Imprime Cancelada                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("MTR928",.F.)
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnRel := "MATR928"
	wnRel := SetPrint(cString,wnRel,cPerg,cTitulo,cDescr1,cDescr2,,.F.,,,cTam)
	If nLastKey = 27
		dbClearFilter()
		Return
	Endif
	SetDefault(aReturn,cString)
	If nLastKey = 27
		dbClearFilter()
		Return
	Endif

	RptStatus({|lEnd| R928Imp(@lEnd,wnRel,cString,cTitulo,cTam)},cTitulo)  // Chamada do Relatorio
EndIf

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³LayOut     ³Autor ³ Sergio S. Fuzinaka    ³ Data ³ 27.09.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Layout do Relatorio                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R928Imp(lEnd,WnRel,cString,cTitulo,cTam)

Local cAlias   		:= "SF3"
Local dDtIni   		:= mv_par01
Local dDtFim   		:= mv_par02
Local aStru	   		:= {}
Local cQuery   		:= ""
Local lQuery   		:= .F.
Local cInd	   		:= ""
Local nInd	   		:= 0
Local nLin	  		:= 0
Local aDados		:= Array(10)
Local nPercent 		:= GetNewPar("MV_MTR9281",20)/100					//Percentual aplicado para calculo do credito de Icms
Local cNfEsp		:= Upper(Alltrim(GetNewPar("MV_MTR9282","CTR")))	//Especie da Nota Fiscal
Local aL	   		:= Array(08)
Local aTotGer  		:= {0,0,0,0}
Local aSubTot  		:= {0,0,0,0}
Local nCredOut		:= 0
Local nX			:= 0
Local cRD			:= ""
Local cMVRDR928		:=	GetNewPar("MV_RDR928","C=N;P=N;")
Local cFilterUser 	:= aReturn[7]
Local lRet			:= .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o LayOut do Relatorio                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LayOut(@aL)

#IFDEF TOP
    If TcSrvType() <> "AS/400"
    	lQuery := .T.
    Endif
#ENDIF

dbSelectArea("SF3")
dbSetOrder(1)
If lQuery 
	cAlias := "TopSF3"
	aStru  := SF3->(dbStruct())
	
	cQuery := "SELECT "
	cQuery += 	" SF3.F3_FILIAL,SF3.F3_ENTRADA,SF3.F3_NFISCAL,SF3.F3_SERIE,"
	cQuery +=  Iif(SerieNfId("SF3",3,"F3_SERIE")<>"F3_SERIE"," SF3."+SerieNfId("SF3",3,"F3_SERIE")+",","")
	cQuery +=  "SF3.F3_CLIEFOR,SF3.F3_LOJA,SF3.F3_CFO,SF3.F3_ALIQICM,"
	cQuery += 	" SF3.F3_DTCANC,SF3.F3_ESPECIE,SF3.F3_EMISSAO,SF3.F3_VALICM,SF3.F3_ICMSRET,SF3.F3_VALCONT,SA1.A1_EST,SA1.A1_INSCR,"
	cQuery += 	" SA1.A1_NOME "
	cQuery += "FROM "
	cQuery += 	RetSqlName("SF3")+" SF3, "+RetSqlName("SA1")+" SA1 "
	cQuery += "WHERE "
	cQuery += 	"SA1.A1_FILIAL='"+xFilial("SA1")+"' AND "
	cQuery += 	"SA1.A1_COD=F3_CLIEFOR AND "
	cQuery += 	"SA1.A1_LOJA=F3_LOJA AND "
	cQuery += 	"SF3.F3_FILIAL='"+xFilial("SF3")+"' AND "
	cQuery += 	"SF3.F3_ENTRADA>='"+Dtos(dDtIni)+"' AND "
	cQuery += 	"SF3.F3_ENTRADA<='"+Dtos(dDtFim)+"' AND "	
	cQuery += 	"SUBSTRING(SF3.F3_CFO,1,1)>='5' AND "

	If mv_par03 == 1
		cQuery += "SA1.A1_EST = 'SP' AND "
	EndIf
	If mv_par04 == 2
		cQuery += "SF3.F3_DTCANC = '' AND "
	EndIf

	cQuery += 	"SF3.D_E_L_E_T_ = ' ' AND "
	cQuery += 	"SA1.D_E_L_E_T_ = ' ' "
	cQuery += 	"ORDER BY "
	cQuery += 	SqlOrder(SF3->(IndexKey()))

	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)

	For nX := 1 To len(aStru)
		If aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 .And. aStru[nX][1]$cQuery
			TcSetField(cAlias,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
		EndIf
	Next nX
	dbSelectArea(cAlias)
Else
	cInd := CriaTrab(NIL,.F.)
	cFiltro := "Dtos(F3_ENTRADA)>='"+Dtos(dDtIni)+"' .And. Dtos(F3_ENTRADA)<='"+Dtos(dDtFim)+"' .And. Left(F3_CFO,1)>='5'"
	If mv_par04 == 2
		cFiltro += ".And. Empty(F3_DTCANC)"
	EndIf
	IndRegua("SF3",cInd,SF3->(IndexKey()),,cFiltro)
	nInd := RetIndex("SF3")
	dbSetIndex(cInd+OrdBagExt())
	dbSelectArea(cAlias)
	dbSetOrder(nInd+1)
	dbGoTop()
Endif

SetRegua(LastRec())
While !(cAlias)->(Eof())
	If lEnd
		Exit
	Endif
	IncRegua()

	If !Alltrim((cAlias)->F3_ESPECIE)$cNfEsp
		(cAlias)->(dbSkip())
		Loop
	EndIf    
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	If !Empty(cFilterUser) .And. !((cAliaS)->&(cFilterUser))
		(cAlias)->(dbSkip())
		Loop
	EndIf

	lRet	:=	U_VldMTR928(cAlias,lQuery,@cRD,cMVRDR928)
	If !lRet
		(cAlias)->(dbSkip())
		Loop
	Endif
	
	aDados := {	"",;	//01-Data de Emissao
				"",;	//02-Nota Fiscal
				"",;	//03-Serie 
				"",;	//04-Cfop
				"",;	//05-Tomador
				"",;	//06-IE
				cRD,;	//07-Remetente/Destinatario Paulista
				0,;		//08-Valor Contabil
				0,;		//09-ICMS Normal
				0,;		//10-ICMS ST
				0}		//11-Credito Outorgado

	If (nLin > 60 .Or. nLin == 0)
		If nLin > 60
			FmtLin(,aL[01],,,@nLin)
			FmtLin(aSubTot,aL[06],,,@nLin)				
			aSubTot := {0,0,0,0}				
		Endif				
		nLin := Cabec(STR0001+STR0009+Dtoc(dDtIni)+" a "+Dtoc(dDtFim),"","","MATR928",cTam,18)
		++nLin
		FmtLin(,{aL[01],aL[02],aL[03],aL[04],aL[01]},,,@nLin)	
	Endif

	aDados[01]	:= Dtoc((cAlias)->F3_EMISSAO)
	aDados[02]	:= (cAlias)->F3_NFISCAL
	aDados[03]	:= (cAlias)->&(SerieNfId("SF3",3,"F3_SERIE"))
	aDados[04]	:= (cAlias)->F3_CFO
	aDados[05] := SA1->A1_NOME
	aDados[06] := SA1->A1_INSCR
		
	nCredOut	:= Round( ((cAlias)->F3_VALICM + (cAlias)->F3_ICMSRET) * nPercent , 2 )
		
	If Empty((cAlias)->F3_DTCANC)
		aDados[08]	:= Transform((cAlias)->F3_VALCONT,"@E 999,999,999,999.99")
		aDados[09]	:= Transform((cAlias)->F3_VALICM,"@E 999,999,999,999.99")
		aDados[10]	:= Transform((cAlias)->F3_ICMSRET,"@E 999,999,999,999.99")
		aDados[11]	:= Transform(nCredOut,"@E 999,999,999,999.99")
			
		FmtLin(aDados,aL[05],,,@nLin)
			
		aSubTot[01]	+= (cAlias)->F3_VALCONT
		aSubTot[02]	+= (cAlias)->F3_VALICM
		aSubTot[03]	+= (cAlias)->F3_ICMSRET
		aSubTot[04]	+= nCredOut
			
		aTotGer[01]	+= (cAlias)->F3_VALCONT
		aTotGer[02]	+= (cAlias)->F3_VALICM
		aTotGer[03]	+= (cAlias)->F3_ICMSRET
		aTotGer[04]	+= nCredOut
	Else
		aDados[08]	:= ""
		aDados[09]	:= ""
		aDados[10]	:= ""
		aDados[11]	:= ""
			
		FmtLin(aDados,aL[08],,,@nLin)
	EndIf

    (cAlias)->(dbSkip())
Enddo

If nLin > 0
	FmtLin(,aL[01],,,@nLin)
	FmtLin(aSubTot,aL[06],,,@nLin)				

	FmtLin(,aL[07],,,@nLin)
	FmtLin(aTotGer,aL[06],,,@nLin)				
Endif

If lQuery
	dbSelectArea(cAlias)
	dbCloseArea()
Else
  	dbSelectArea("SF3")
	RetIndex("SF3")
	dbClearFilter()
	Ferase(cInd+OrdBagExt())
EndIf

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	Ourspool(wnRel)
EndIf
MS_FLUSH()

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³IsRD       ³Autor ³ Sergio S. Fuzinaka    ³ Data ³ 27.09.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Remetente ou Destinario - DT6                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function IsRD(cRD,cAlias)
Local aArea	:= GetArea()
Local cSeek := xFilial("DT6")+cFilAnt+(cAlias)->F3_NFISCAL+(cAlias)->F3_SERIE
Local lRet	:= .F.

cRD 	:= ""
dbSelectArea("DT6")
dbSetOrder(1)
If DT6->(dbSeek(cSeek))
	If DT6->DT6_DEVFRE $ "1"		//1-Remetente 2-Destinatario 3-Consignatario 4-Despachante
		cRD  := "R"
	ElseIf DT6->DT6_DEVFRE $ "2"	//1-Remetente 2-Destinatario 3-Consignatario 4-Despachante
		cRD  := "D"
	ElseIf DT6->DT6_DEVFRE $ "3"	//1-Remetente 2-Destinatario 3-Consignatario 4-Despachante
		cRD  := "C"
	ElseIf DT6->DT6_DEVFRE $ "4"		//1-Remetente 2-Destinatario 3-Consignatario 4-Despachante
		cRD  := "P"
	EndIf
	
	lRet := .T.
Endif	
RestArea(aArea)
Return(lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³LayOut     ³Autor ³ Sergio S. Fuzinaka    ³ Data ³ 27.09.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Layout do Relatorio                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LayOut(aL)

aL[01] := "+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
aL[02] := OemToAnsi(STR0006)
aL[03] := OemToAnsi(STR0007)
aL[04] := OemToAnsi(STR0008)
aL[05] := "|  ########  | ###### |  ###  | #### | ######################################## | ##################   | # | ################## | ################## | ################## | ################## |"
aL[06] := "                                                                                                             ##################   ##################   ##################   ##################"
aL[07] := "                                                                                                             ==================   ==================   ==================   =================="
aL[08] := "|  ########  | ###### |  ###  | #### | ######################################## | ##################   | # |                              N F   C A N C E L A D A                              |"
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³VldMTR928 ³ Autor ³ Luccas Curcio         ³ Data ³ 21/09/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Valida operação para impressão no relatório                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function VldMTR928 (cAlias,lQuery,cRD,cMVRDR928)

Local lRet			:=	.T.
	
Default cRD			:=	""
Default	cMVRDR928	:=	GetNewPar("MV_RDR928","C=N;P=N;")	

dbSelectArea("SA1")
dbSetOrder(1)
SA1->(dbSeek(xFilial("SA1")+(cAlias)->F3_CLIEFOR+(cAlias)->F3_LOJA))
If !lQuery .And. MV_PAR03==1 .And. SA1->A1_EST<>'SP'
	lRet	:=	.F.
EndIf

If IsRD(@cRD,cAlias)
	If cRD#"RD" .And. cRD+"="$cMVRDR928
		If SubStr(cMVRDR928, At(cRD+"=",cMVRDR928)+2, 1)=="N"
			lRet	:=	.F.
		ElseIf SubStr(cMVRDR928, At(cRD+"=",cMVRDR928)+2, 1)$"RD"
			cRD	:=	SubStr(cMVRDR928, At(cRD+"=",cMVRDR928)+2, 1)
		EndIf
	EndIf
EndIf

Return lRet
