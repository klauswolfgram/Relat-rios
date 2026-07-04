/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "QDOR040.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "Report.CH"

Static lQLTDispSVR := NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QDOR040   ºAutor  ³Leandro Sabino      º Data ³  29/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio Lista Mestra Resumida de Documentos              º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QDOR040()
Local oReport := ReportDef()

lQLTDispSVR := Iif(lQLTDispSVR == Nil, FindFunction("QLTDispSVR"), lQLTDispSVR)

If lQLTDispSVR .AND. FWSX1Util():ExistPergunte( "QDR040SV" ) .AND. QLTDispSVR("manufacturing.sv.qdo.documents")
	Return
Else
	Pergunte("QDR040",.F.)
	oReport:PrintDialog()
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 29/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR040                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cDesc1    := OemToAnsi(STR0002) //"Este programa ir  imprimir uma rela‡„o dos documentos, seus "
Local cDesc2    := OemToAnsi(STR0003) //"elaboradores, revisores, aprovadores e homologadores, "
Local cDesc3    := OemToAnsi(STR0004) //"de acordo com os parametros definidos pelo usu rio."
Local cTitulo   := OemToAnsi(STR0001) //"LISTA MESTRA RESUMIDA DE DOCUMENTOS"
Local nTamName  := GetSX3Cache("QAA_NOME","X3_TAMANHO")
Local oSection1 := NIL

DEFINE REPORT oReport NAME "QDOR040" TITLE cTitulo PARAMETER "QDR040" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2+cDesc3)
oReport:SetPortrait()

DEFINE SECTION oSection1 OF oReport TITLE STR0015 TABLES "QDH" // "Documentos"
DEFINE CELL NAME "cDOCTO"       OF oSection1 ALIAS "  "  TITLE FWX3Titulo("QDH_DOCTO")	  SIZE GetSX3Cache("QDH_DOCTO","X3_TAMANHO")
DEFINE CELL NAME "cRV"          OF oSection1 ALIAS "  "  TITLE FWX3Titulo("QDH_RV")		  SIZE GetSX3Cache("QDH_RV","X3_TAMANHO")
DEFINE CELL NAME "cTITULO"      OF oSection1 ALIAS "  "  TITLE FWX3Titulo("QDH_TITULO")	  AUTO SIZE
DEFINE CELL NAME "cElaborador"  OF oSection1 ALIAS "  "  TITLE X3CboxDesc("QD0_AUT", "E") SIZE nTamName//15 //"Elaboradores"
DEFINE CELL NAME "cRevisor"     OF oSection1 ALIAS "  "  TITLE X3CboxDesc("QD0_AUT", "R") SIZE nTamName//15 //"Revisores"
DEFINE CELL NAME "cAprovador"   OF oSection1 ALIAS "  "  TITLE X3CboxDesc("QD0_AUT", "A") SIZE nTamName//15 //"Aprovadores"
DEFINE CELL NAME "cHomologador" OF oSection1 ALIAS "  "  TITLE X3CboxDesc("QD0_AUT", "H") SIZE nTamName//15 //"Homologadores"
DEFINE CELL NAME "cDTVIG"       OF oSection1 ALIAS "QDH" TITLE FWX3Titulo("QDH_DTVIG") 	  SIZE GetSX3Cache("QDH_DTVIG","X3_TAMANHO")
			
Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 26/06/06 ³±±
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
Local cFilialQD0     := xFilial("QD0")
Local cFiltro        := ""
Local nI             := 0
Local nTamMax        := 0
Local nTamName       := GetSX3Cache("QAA_NOME","X3_TAMANHO")
Local oSection1      := oReport:Section(1)

DbSelectArea("QDH")
QDH->(DbSetOrder(1))

DbSelectArea("QD0")
QD0->(DbSetOrder(1))

DbSelectArea("QDG")
QDG->(DbSetOrder(1))

MakeAdvplExpr("QDR040")

cFiltro:= 'QDH_FILIAL == "'+xFilial("QDH")+'"
cFiltro+= ' .AND. QDH_STATUS == "L  "'
cFiltro+= ' .AND. QDH_CANCEL <> "S" .AND. QDH_OBSOL <> "S"'
cFiltro+= ' .AND. QDH_CODTP >= "'+mv_par01+'" .AND. QDH_CODTP <= "'+mv_par02+'"'
cFiltro+= ' .AND. QDH_DOCTO >= "'+mv_par03+'" .AND. QDH_DOCTO <= "'+mv_par04+'"'

If mv_par05	== 2
	cFiltro+='.AND. QDH->QDH_DTOIE == "I"'
Elseif mv_par05 == 3
	cFiltro+='.AND. QDH->QDH_DTOIE == "E"'
EndIf

oSection1:SetFilter(cFiltro)

QDH->(dbGoTop())

While !oReport:Cancel() .And. QDH->(!Eof())
    
	FwFreeArray(aAprovadores)
	FwFreeArray(aHomologadores)
	FwFreeArray(aRevisores)
	FwFreeArray(aElaboradores)
	aAprovadores   := {}
	aHomologadores := {}
	aRevisores     := {}
 	aElaboradores  := {}

    oSection1:Init()

	If QD0->(DbSeek(cFilialQD0+QDH->(QDH_DOCTO+QDH_RV)))
		While QD0->(!Eof()) .And. QD0->(QD0_FILIAL+QD0_DOCTO+QD0_RV) == cFilialQD0+QDH->(QDH_DOCTO+QDH_RV)
			If QD0->QD0_AUT == "E"
				nAcho:= ASCAN(aElaboradores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aElaboradores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			ElseIf QD0->QD0_AUT == "R"
				nAcho:=ASCAN(aRevisores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aRevisores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			ElseIf QD0->QD0_AUT == "A"
				nAcho:= ASCAN(aAprovadores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aAprovadores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			ElseIf QD0->QD0_AUT == "H"
				nAcho:= ASCAN(aHomologadores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aHomologadores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			EndIf
			QD0->(DbSkip()) 
		EndDo
    EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tamanho maximo do La‡o (For-Next)               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTamMax := Max(Len(aElaboradores),Len(aRevisores))
	nTamMax := Max(nTamMax,Len(aAprovadores))
	nTamMax := Max(nTamMax,Len(aHomologadores))

	For nI:= 1 To nTamMax
		If nI = 1
			oSection1:Cell("cDOCTO"):SetValue(QDH->QDH_DOCTO)
			oSection1:Cell("cRV"):SetValue(QDH->QDH_RV)
			oSection1:Cell("cTITULO"):SetValue(QDH->QDH_TITULO)
			If !Empty(QDH->QDH_DTVIG) 
				oSection1:Cell("cDTVIG"):SetValue(QDH->QDH_DTVIG)
			Else		
				oSection1:Cell("cDOCTO"):SetValue("")
			EndIf
		Else
			oSection1:Cell("cDOCTO"):SetValue("")		
			oSection1:Cell("cRV"):SetValue("")				
			oSection1:Cell("cDTVIG"):SetValue("") 
			oSection1:Cell("cTITULO"):SetValue("")
		Endif
		
		If Len( aElaboradores ) >= nI
			oSection1:Cell("cElaborador"):SetValue(QA_NUSR(aElaboradores[nI,1],aElaboradores[nI,2],.T.,"A" ))
		Else
			oSection1:Cell("cElaborador"):SetValue(Space(nTamName))	
		EndIf		

		If Len( aRevisores ) >= nI
			oSection1:Cell("cRevisor"):SetValue(QA_NUSR(aRevisores[nI,1],aRevisores[nI,2],.T.,"A"))
		Else
			oSection1:Cell("cRevisor"):SetValue(Space(nTamName))	
		EndIf		

		If Len( aAprovadores ) >= nI
			oSection1:Cell("cAprovador"):SetValue(QA_NUSR(aAprovadores[nI,1],aAprovadores[nI,2],.T.,"A"))
		Else
			oSection1:Cell("cAprovador"):SetValue(Space(nTamName))	
		EndIf

		If Len( aHomologadores ) >= nI
			oSection1:Cell("cHomologador"):SetValue(QA_NUSR(aHomologadores[nI,1],aHomologadores[nI,2],.T.,"A"))
		Else
			oSection1:Cell("cHomologador"):SetValue(Space(nTamName))	
		EndIf		

	   	oSection1:PrintLine() 
	Next nI
	QDH->(DbSkip())
EndDo

oSection1:Finish()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve as ordens originais dos arquivos                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("QDH")
Set Filter to

Return NIL
