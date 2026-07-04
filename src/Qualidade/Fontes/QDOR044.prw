/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QDOR044.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QDOR044   ºAutor  ³Leandro Sabino      º Data ³  03/07/06	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio Lista de Documentos                              º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QDOR044()

Local oReport := ReportDef()
Pergunte("QDR043",.F.) 
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 03/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR044                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cDesc1    := OemToAnsi(STR0002) // "Este programa ir  imprimir uma rela‡„o dos documentos, seus "
Local cDesc2    := OemToAnsi(STR0003) // "elaboradores, revisores, aprovadores e homologadores, "
Local cDesc3    := OemToAnsi(STR0004) // "de acordo com os parƒmetros definidos pelo usu rio."
Local cTitulo   := OemToAnsi(STR0001) // "LISTA DE DOCUMENTOS"
Local oSection1 := Nil

DEFINE REPORT oReport NAME "QDOR044" TITLE cTitulo PARAMETER "QDR043" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2+cDesc3)
oReport:SetLandscape(.T.)

DEFINE SECTION oSection1 OF oReport TABLES "QDH" TITLE OemToAnsi(STR0024)
DEFINE CELL NAME "QDH_DOCTO"    OF oSection1 ALIAS "QDH" SIZE 23 LINE BREAK
DEFINE CELL NAME "QDH_RV"       OF oSection1 ALIAS "QDH" SIZE 3  LINE BREAK
DEFINE CELL NAME "QDH_TITULO"   OF oSection1 ALIAS "QDH" SIZE 61 LINE BREAK
DEFINE CELL NAME "cElaborador"  OF oSection1 ALIAS "  " TITLE X3CboxDesc("QD0_AUT", "E")  SIZE 21 LINE BREAK//"Elaboradores"
DEFINE CELL NAME "cRevisor"     OF oSection1 ALIAS "  " TITLE X3CboxDesc("QD0_AUT", "R")  SIZE 21 LINE BREAK//"Revisores"
DEFINE CELL NAME "cAprovador"   OF oSection1 ALIAS "  " TITLE X3CboxDesc("QD0_AUT", "A")  SIZE 21 LINE BREAK//"Aprovadores"
DEFINE CELL NAME "cHomologador" OF oSection1 ALIAS "  " TITLE X3CboxDesc("QD0_AUT", "H")  SIZE 21 LINE BREAK//"Homologador"
DEFINE CELL NAME "cDescricao"   OF oSection1 ALIAS "  " TITLE OemToAnsi(STR0023)          SIZE 16 LINE BREAK//"Status"
DEFINE CELL NAME "QDH_DTVIG"    OF oSection1 ALIAS "QDH" SIZE 14 LINE BREAK

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 03/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR020                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport) 
Local aAprovadores   := {}
Local aElaboradores  := {}
Local aHomologadores := {}
Local aRevisores     := {}
Local cAliasQry      := GetNextAlias()
Local cFilQD0        := xFilial("QD0")
Local cFiltro        := ""
Local cQuery         := ""
Local nAcho          := 0
Local nI             := 0
Local nTam1          := 0
Local nTam2          := 0
Local nTamMax        := 0
Local nTamName       := GetSX3Cache("QAA_NOME","X3_TAMANHO")
Local oSection1      := oReport:Section(1)

MakeAdvplExpr(oReport:uParam)

mv_par20 := IIf( mv_par20 < mv_par19, mv_par19, mv_par20 )
	
DbSelectArea("QDH")
QDH->(DbSetOrder(1))

DbSelectArea("QDG")
QDG->(DbSetOrder(1))

DbSelectArea("QD0")
QD0->(DbSetOrder(1))

cFiltro:= 'QDH_STATUS $ "' +mv_par01+'" .AND.'
cFiltro+= 'QDH_CODTP >= "' +mv_par03+'" .AND. QDH_CODTP <= "' +mv_par04+'" .AND.'
cFiltro+= 'QDH_CODASS >= "'+mv_par05+'" .AND. QDH_CODASS <= "'+mv_par06+'" .AND.'
cFiltro+= 'QDH_FILDEP >= "'+mv_par24+'" .AND. '
cFiltro+= 'QDH_DEPTOD >= "'+mv_par07+'" .AND. '
cFiltro+= 'QDH_FILDEP <= "'+mv_par25+'" .AND. '
cFiltro+= 'QDH_DEPTOD <= "'+mv_par08+'" .AND. '
cFiltro+= 'QDH_FILMAT >= "'+mv_par26+'" .AND. '
cFiltro+= 'QDH_DEPTOE >= "'+mv_par09+'" .AND. '
cFiltro+= 'QDH_FILMAT <= "'+mv_par27+'" .AND. '
cFiltro+= 'QDH_DEPTOE <= "'+mv_par10+'" .AND. '
cFiltro+= 'QDH_DOCTO >= "' +mv_par15+'" .AND. QDH_DOCTO <= "' +mv_par16+'" .AND.'
cFiltro+= 'QDH_RV >= "'    +mv_par17+'" .AND. QDH_RV <= "'    +mv_par18+'" '

If mv_par02	== 1   // Vigente
	cFiltro+= ' .And. QDH_CANCEL<>"S".And. QDH_OBSOL<>"S".And.QDH_STATUS = "L  "'
Elseif mv_par02 == 2   // Obsoleto
	cFiltro+= ' .AND. QDH_CANCEL <> "S"'+' .AND. QDH_OBSOL == "S"'	
Elseif mv_par02 == 3   // Cancelado
	cFiltro+= ' .AND. QDH_CANCEL == "S"'
ElseIf mv_par02 == 4   // Todas Revisoes
	cFiltro+= ' .AND. QDH_CANCEL <> "S"'
EndIf

If mv_par23	== 2
	cFiltro+= ' .AND. QDH_DTOIE == "I"'
Elseif mv_par23 == 3
	cFiltro+= ' .AND. QDH_DTOIE == "E"'
EndIf

oSection1:SetFilter(cFiltro)

cQuery := " SELECT * "
cQuery += "   FROM " + RetSqlName("QDH") + " QDH"
cQuery += "  WHERE QDH.QDH_FILIAL = '"+xFilial("QDH")+"' "
cQuery += "    AND QDH.D_E_L_E_T_ = ' ' "

dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), cAliasQry, .F., .T. )
DbSelectArea(cAliasQry)
Set Filter To &(cFiltro)
(cAliasQry)->(DbGoTop())
While !oReport:Cancel() .And. (cAliasQry)->(!Eof())
	QDH->(DbGoTo((cAliasQry)->(R_E_C_N_O_)))
	If !QDOR044Vld()
		(cAliasQry)->(DbSkip())
		Loop
	EndIf

	If !Empty(mv_par19) .And. Alltrim(QDH_STATUS) == "L"
		If !( DTOS(QDH->QDH_DTVIG) >= DTOS(mv_par19) .And. DTOS(QDH->QDH_DTVIG) <= DTOS(mv_par20) )
			(cAliasQry)->(dbSkip())
			Loop
		Endif
	Endif

	FwFreeArray(aAprovadores)
	FwFreeArray(aElaboradores)
	FwFreeArray(aHomologadores)
	FwFreeArray(aRevisores)
	aAprovadores   := {}
 	aElaboradores  := {}
	aHomologadores := {}
	aRevisores     := {}

	If QD0->(DbSeek(cFilQD0+QDH->(QDH_DOCTO+QDH_RV)))
		While QD0->(!Eof());
			.And. QD0->QD0_FILIAL == cFilQD0;
			.And. QD0->QD0_DOCTO  == QDH->QDH_DOCTO;
			.And. QD0->QD0_RV     == QDH->QDH_RV

			If QD0->QD0_AUT == "E"
				nAcho:= ASCAN(aElaboradores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aElaboradores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			Endif
			If QD0->QD0_AUT == "R"
				nAcho:= ASCAN(aRevisores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aRevisores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			Endif
			If QD0->QD0_AUT == "A"
				nAcho:= ASCAN(aAprovadores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aAprovadores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			Endif
			If QD0->QD0_AUT == "H"
				nAcho:= ASCAN(aHomologadores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aHomologadores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			EndIf
			QD0->(DbSkip())
		EndDo
	EndIf
	
	oSection1:Init()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime STATUS de acordo com tabela Q7 - SX5    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If QDH->QDH_STATUS <> "L  "
		DbSelectArea("SX5")
		If SX5->(DbSeek(xFilial("SX5")+"Q7"+QDH->QDH_STATUS))
			oSection1:Cell("cDescricao"):SetValue(Substr(X5Descri(),1,12),1,15)
		EndIf		
	Else
		oSection1:Cell("cDescricao"):SetValue(OemToAnsi(STR0009),1,15)//"Publicado"
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tamanho maximo do La‡o (For-Next)               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTam1   := Max(Len(aElaboradores), Len(aRevisores))
	nTam2   := Max(Len(aAprovadores) , Len(aHomologadores))
	nTamMax := Max(nTam1             , nTam2)

	IF nTamMax == 0

		oSection1:Cell("QDH_DOCTO"):SetValue(QDH->QDH_DOCTO)
		oSection1:Cell("QDH_RV"):SetValue(QDH->QDH_RV)
		oSection1:Cell("QDH_TITULO"):SetValue(QDH->QDH_TITULO)
		oSection1:Cell("QDH_DTVIG"):SetValue(QDH->QDH_DTVIG)

		oSection1:Cell("QDH_DOCTO"):Show()
		oSection1:Cell("QDH_RV"):Show()
		oSection1:Cell("QDH_TITULO"):Show()		
		oSection1:Cell("cDescricao"):Show()
		oSection1:Cell("QDH_DTVIG"):Show()

		oSection1:PrintLine()

		(cAliasQry)->(DbSkip())
		LOOP
	ENDIF

	For nI:= 1 to nTamMax
		
		If nI > 1
			oSection1:Cell("QDH_DOCTO"):Hide()
			oSection1:Cell("QDH_RV"):Hide()
			oSection1:Cell("QDH_TITULO"):Hide()
			oSection1:Cell("cDescricao"):Hide()
			oSection1:Cell("QDH_DTVIG"):Hide()
		Else

			oSection1:Cell("QDH_DOCTO"):SetValue(QDH->QDH_DOCTO)
			oSection1:Cell("QDH_RV"):SetValue(QDH->QDH_RV)
			oSection1:Cell("QDH_TITULO"):SetValue(Alltrim(QDH->QDH_TITULO))
			oSection1:Cell("QDH_DTVIG"):SetValue(QDH->QDH_DTVIG)

			oSection1:Cell("QDH_DOCTO"):Show()
			oSection1:Cell("QDH_RV"):Show()
			oSection1:Cell("QDH_TITULO"):Show()		
			oSection1:Cell("cDescricao"):Show()
			oSection1:Cell("QDH_DTVIG"):Show()
		Endif	

		If Len( aElaboradores ) >= nI
			oSection1:Cell("cElaborador"):SetValue(QA_NUSR(aElaboradores[nI,1],aElaboradores[nI,2],.T.,"A"),1,nTamName)			
		Else
			oSection1:Cell("cElaborador"):SetValue(Space(nTamName))	
		EndIf		
			
		If Len( aRevisores ) >= nI
			oSection1:Cell("cRevisor"):SetValue(QA_NUSR(aRevisores[nI,1],aRevisores[nI,2],.T.,"A"),1,nTamName)
		Else
			oSection1:Cell("cRevisor"):SetValue(Space(nTamName))	
		EndIf
	
		If Len( aAprovadores ) >= nI
			oSection1:Cell("cAprovador"):SetValue(QA_NUSR(aAprovadores[nI,1],aAprovadores[nI,2],.T.,"A"),1,nTamName)
		Else
			oSection1:Cell("cAprovador"):SetValue(Space(nTamName))	
		EndIf
	
		If Len(aHomologadores) >= nI
			oSection1:Cell("cHomologador"):SetValue(QA_NUSR(aHomologadores[nI,1],aHomologadores[nI,2],.T.,"A"),1,nTamName)
		Else
			oSection1:Cell("cHomologador"):SetValue(Space(nTamName))	
		EndIf

		oSection1:PrintLine()
	Next nI
	(cAliasQry)->(DbSkip())
EndDo
(cAliasQry)->(DbCloseArea())

oSection1:Finish()

Return NIL

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³QDOR044Vld³ Autor ³ Eduardo de Souza      ³ Data ³ 19/02/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Valida registro para impressao                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QDOR044Vld()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR044                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QDOR044Vld()

Local lRet    := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida documento, Revisao e Status                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !(QDH->QDH_STATUS $ mv_par01 )
	lRet:= .F.
EndIf

If lRet
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Usuario Destino                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lRet:= .F.
	If QDG->(DbSeek(xFilial("QDG")+QDH->QDH_DOCTO+QDH->QDH_RV))
		While QDG->(!Eof()) .And. xFilial("QDG")+QDH->QDH_DOCTO+QDH->QDH_RV == QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV
			If QDG->QDG_SIT <> "I"
				If QDG->QDG_FILMAT >= mv_par28 .And. QDG->QDG_FILMAT <= mv_par29 .And. ;
					QDG->QDG_MAT >= mv_par13 .And. QDG->QDG_MAT <= mv_par14 .And. ;
					QDG->QDG_DEPTO >= mv_par11 .And. QDG->QDG_DEPTO <= mv_par12
					If QDG->QDG_CODMAN >= mv_par21 .And. QDG->QDG_CODMAN <= mv_par22 .And. QDG->QDG_RECEB=="S"
						lRet := .T.
						Exit
					Endif
				EndIf
			EndIf
			QDG->(DbSkip())
		Enddo
	Endif
EndIf

Return lRet
