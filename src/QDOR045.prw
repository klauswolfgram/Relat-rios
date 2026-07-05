/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QDOR045.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "Report.CH"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR045  ³ Autor ³ Leandro S. Sabino     ³ Data ³ 21/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Generico dos rel.das Listas Resumida                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs:      ³ (Versao Relatorio Personalizavel) 		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQDO0	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function QDOR045()
Local oReport

Pergunte("QDR045",.F.) 
oReport := ReportDef()
oReport:PrintDialog()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 21/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR045                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cTitulo := ""
Local cDesc1  := OemToAnsi(STR0004) // "Este programa ir  imprimir uma rela‡„o dos documentos, "
Local cDesc2  := OemToAnsi(STR0005) // " elaboradores, revisores, aprovadores e/ou homologadores, "
Local cDesc3  := OemToAnsi(STR0006) // " de acordo com os parƒmetros definidos."
Local oSection1 

DEFINE REPORT oReport NAME "QDOR045" TITLE  PARAMETER "QDR045" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2+cDesc3)

DEFINE SECTION oSection1 OF oReport TABLES "TRB"
DEFINE CELL NAME "DOCTO"        OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0007)  SIZE 16 //"Cod. Doc"
DEFINE CELL NAME "RV"           OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0008)  SIZE 03 //"Revisao"
DEFINE CELL NAME "TITULO"       OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0009)  SIZE 50 //"Titulo"
DEFINE CELL NAME "cElaborador"  OF oSection1 ALIAS "  "  TITLE OemToAnsi(STR0010)  SIZE 15 //"Elaboradores"
DEFINE CELL NAME "cRevisor"     OF oSection1 ALIAS "  "  TITLE OemToAnsi(STR0011)  SIZE 15 //"Revisores"
DEFINE CELL NAME "cAprovador"   OF oSection1 ALIAS "  "  TITLE OemToAnsi(STR0012)  SIZE 14 //"Aprovadores"
DEFINE CELL NAME "cHomologador" OF oSection1 ALIAS "  "  TITLE OemToAnsi(STR0013)  SIZE 15 //"Homologadores"
DEFINE CELL NAME "DTVIG"        OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0014)  SIZE 08 //"Dt. Vigencia"
	
Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 21/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR045                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport)
Local oTempTable    := NIL
Local oSection1     := oReport:Section(1)
Local cFilDep       := xFilial("QAD")
Local aElaboradores := {}
Local aAprovadores  := {}
Local aDigitadores  := {}
Local aRevisores	:= {}
Local aHomologadores:= {}
Local aCampos       := {}    
local cDepto 		:= ""
Local cFiltro       := ""
Local cArq          := ""
Local cArq2         := ""
Local cFDep   		:= ""
Local cCDep   		:= ""
Local cFDocto 		:= ""
Local cRDocto 		:= ""
Local cQDIDTVG      := SuperGetMv("MV_QDIDTVG", .F., "N")

DbSelectArea("QDH")
DbSetOrder(1)

DbSelectArea("QD0")
DbSetOrder(1)

DbSelectArea("QDJ")
DbSetOrder(1)

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tratamento do titulo do relatorio de acordo com o parametro selecionado³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Do Case
	Case mv_par10= 1
	  cTitulo:= STR0001//"LISTA MESTRA RESUMIDA DE DOCUMENTOS"  
	Case mv_par10= 2  
	  cTitulo:= STR0002//"LISTA MESTRA COMPLETA DE DOCUMENTOS"
	Case mv_par10= 3
	  cTitulo:= STR0003//"LISTA MESTRA DE DOCUMENTOS POR DEPARTAMENTO"
EndCase

oReport:SetTitle(cTitulo)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo de Trabalho ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd(aCampos,{"FILIAL"	,"C",03,0})
Aadd(aCampos,{"DOCTO"	,"C",16,0})
Aadd(aCampos,{"TITULO"	,"C",100,0})
Aadd(aCampos,{"RV"		,"C",03,0})
Aadd(aCampos,{"DEPTO"	,"C",15,0})
Aadd(aCampos,{"DTVIG"	,"D",08,0})
Aadd(aCampos,{"FILMAT"	,"C",03,0})

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"FILIAL","DOCTO","RV"} )
oTempTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tabela de Documentos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QDH")
dbSetOrder(1)
cArq  := CriaTrab(NIL,.F.)
cFiltro:= 'QDH_FILIAL == "'+xFilial("QDH")+'"
cFiltro+= ' .AND. QDH_STATUS == "L  "'
cFiltro+= ' .AND. QDH_CANCEL <> "S" .AND. QDH_OBSOL <> "S"'
cFiltro+= ' .AND. QDH_CODTP >= "'+mv_par03+'" .AND. QDH_CODTP <= "'+mv_par04+'"'
cFiltro+= ' .AND. QDH_DOCTO >= "'+mv_par05+'" .AND. QDH_DOCTO <= "'+mv_par06+'"'
If mv_par07	== 2
	cFiltro+='.AND. QDH->QDH_DTOIE == "I"'
Elseif mv_par07 == 3
	cFiltro+='.AND. QDH->QDH_DTOIE == "E"'
EndIf
IndRegua("QDH",cArq,"QDH_FILIAL+QDH_DOCTO+QDH_RV",,cFiltro,)	
dbGotop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tabela de Destinos   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QDJ")
dbSetOrder(1)
cArq2 := CriaTrab(NIL,.F.)
cFiltro := 'QDJ_FILIAL == "' + xFilial("QDJ")+'"'
cFiltro += ' .AND. QDJ_FILMAT >= "'+mv_par08+'"'
cFiltro += ' .AND. QDJ_DEPTO >= "' +mv_par01+'"'
cFiltro += ' .AND. QDJ_FILMAT <= "'+mv_par09+'"'
cFiltro += ' .AND. QDJ_DEPTO <= "' +mv_par02+'"'
cFiltro += ' .AND. QDJ_DOCTO >= "' +mv_par05+'"'
cFiltro += ' .AND. QDJ_DOCTO <= "' +mv_par06+'"'
IndRegua("QDJ",cArq2,"QDJ_FILIAL+QDJ_DOCTO+QDJ_RV",,cFiltro,STR0006)		//"Selecionando Registros..."
dbGoTop()

QDH->(dbGoTop())

While ("QDH")->(!Eof())
	If mv_par10 = 3 //Filtro por departamento
		If QDJ->(DbSeek(xFilial("QDH")+QDH->QDH_DOCTO+QDH->QDH_RV))
			While QDJ->(!Eof()) .And. xFilial("QDJ") == QDJ->QDJ_FILIAL .And. QDJ->QDJ_DOCTO == QDH->QDH_DOCTO .And. ;
			    QDJ->QDJ_RV == QDH->QDH_RV  
				Reclock("TRB",.T.)
				TRB->FILIAL  := QDJ->QDJ_FILMAT
				TRB->DOCTO	 := QDJ->QDJ_DOCTO
				TRB->TITULO	 := QDH->QDH_TITULO
				TRB->RV	     := QDJ->QDJ_RV
				TRB->DEPTO   := QDJ->QDJ_DEPTO
				TRB->DTVIG   := QDH->QDH_DTVIG
				TRB->FILMAT  := QDJ->QDJ_FILMAT
				MsUnlock()
				QDJ->(dbSkip())
			EndDo
		Endif	
	Else
	   	Reclock("TRB",.T.)
		TRB->FILIAL  := QDH->QDH_FILMAT
		TRB->DOCTO	 := QDH->QDH_DOCTO
		TRB->TITULO	 := QDH->QDH_TITULO
		TRB->RV	     := QDH->QDH_RV
		TRB->DEPTO   := ""
		TRB->DTVIG   := QDH->QDH_DTVIG
		TRB->FILMAT  := ""
		MsUnlock()
	EndIf
	
	("QDH")->(DbSkip())
Enddo

dbSelectArea("TRB")
TRB->(dbGoTop())

While !oReport:Cancel() .And. TRB->(!Eof())

	cFDep   := TRB->FILIAL
	cCDep   := TRB->DEPTO
	cFDocto := TRB->DOCTO
	cRDocto := TRB->RV
    
	If mv_par10 = 3 
		If TRB->DEPTO != cDepto
    		
    		If FWModeAccess("QAD") == "E" //!Empty(cFilDep)
				cFilDep:= TRB->FILMAT
			EndIf
	                                        
			oSection1:Finish()
	        oSection1:Init()
	   	
		   	oReport:SkipLine(1) 
			oReport:ThinLine()                                                              
			oReport:PrintText(Upper(OemToAnsi(STR0015))+AllTrim(TRB->DEPTO)+" - "+Posicione("QAD",1,xFilial("QAD")+TRB->DEPTO,"QAD_DESC"),oReport:Row(),025)  //"Departamento: "
			oReport:SkipLine(1)	
			oReport:ThinLine()
			
		EndIf 
	Else
        oSection1:Init()
	EndIf 	
    
   	aElaboradores  := {}
	aRevisores     := {}
	aAprovadores   := {}
	aHomologadores := {}    

	If QD0->(DbSeek(xFilial("QD0")+TRB->DOCTO+TRB->RV))
		While QD0->(!Eof()) .And. QD0->QD0_FILIAL+QD0->QD0_DOCTO+QD0->QD0_RV == xFilial("QD0")+TRB->DOCTO+TRB->RV
			If QD0->QD0_AUT == "E"
				nAcho:= ASCAN(aElaboradores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
				If nAcho == 0
					AADD(aElaboradores,{QD0->QD0_FILMAT,QD0->QD0_MAT})
				EndIf
			ElseIf QD0->QD0_AUT == "R"
				nAcho:= ASCAN(aRevisores,{|x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT})
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

	  
	If Len( aElaboradores ) >= 1
		oSection1:Cell("cElaborador"):SetValue(QA_NUSR(aElaboradores[1,1],aElaboradores[1,2],.T.,"A"))
	EndIf		
		
	If Len( aRevisores ) >= 1
		oSection1:Cell("cRevisor"):SetValue(QA_NUSR(aRevisores[1,1],aRevisores[1,2],.T.,"A"))
	EndIf

	If Len( aAprovadores ) >= 1
		oSection1:Cell("cAprovador"):SetValue(QA_NUSR(aAprovadores[1,1],aAprovadores[1,2],.T.,"A"))
	EndIf
    
    If mv_par10 <> 1
		If Len(aHomologadores) >= 1
			oSection1:Cell("cHomologador"):SetValue(QA_NUSR(aHomologadores[1,1],aHomologadores[1,2],.T.,"A"))
		EndIf
	Else
		oSection1:Cell("cHomologador"):HideHeader()
	Endif
	
	If cQDIDTVG == "N"
		oSection1:Cell("DTVIG"):Hide()
		oSection1:Cell("DTVIG"):HideHeader()
	Endif

	oSection1:PrintLine() 

	cDepto  := TRB->DEPTO

	TRB->(DbSkip())
	
	If  cFDep == TRB->FILIAL .And. ;
		cCDep == TRB->DEPTO .And. ;
		cFDocto == TRB->DOCTO .And. ;
		cRDocto == TRB->RV
		While TRB->(!Eof()) .And. 	cFDep == TRB->FILIAL .And. ;
									cCDep == TRB->DEPTO .And. ;
									cFDocto == TRB->DOCTO .And. ;
									cRDocto == TRB->RV
			TRB->(DbSkip())
			Loop
		EndDo
 	EndIf   
    
EndDo 
 
oSection1:Finish()

oTempTable:Delete()
QDH->(DbCloseArea())
QD0->(DbCloseArea())
QDJ->(DbCloseArea())

Return NIL