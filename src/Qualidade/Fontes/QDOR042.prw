/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QDOR042.CH"
#INCLUDE "Totvs.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QDOR042   ºAutor  ³Leandro Sabino      º Data ³  29/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Lista Mestra de Documentos por Departamento                º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QDOR042()
Local oReport

If TRepInUse()
	Pergunte("QDR041",.F.) 
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_QDOR042R3()	// Executa versão anterior do fonte
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
±±³ Uso      ³ QDOR042                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cDesc1    := OemToAnsi(STR0002) // "Este programa ir  imprimir uma rela‡„o dos documentos,"
Local cDesc2    := OemToAnsi(STR0003) // "seus elaboradores, revisores, aprovadores com quebra"
Local cDesc3    := OemToAnsi(STR0004) // "por departamento e parƒmetros selecionados pelo usu rio."
Local cTitulo   := OemToAnsi(STR0001) // "LISTA MESTRA DE DOCUMENTOS POR DEPARTAMENTO"
Local oSection1 := Nil

DEFINE REPORT oReport NAME "QDOR042" TITLE cTitulo PARAMETER "QDR041" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2+cDesc3)
oReport:SetLandscape(.T.)

DEFINE SECTION oSection1 OF oReport TITLE STR0018 TABLES "QDJ","QDH" // "Documentos"
DEFINE CELL NAME "QDJ_DOCTO"    OF oSection1 ALIAS "QDJ" 
DEFINE CELL NAME "QDJ_RV"       OF oSection1 ALIAS "QDJ" 
DEFINE CELL NAME "QDH_TITULO"   OF oSection1 ALIAS "QDH" SIZE GetSX3Cache("QDH_TITULO","X3_TAMANHO")
DEFINE CELL NAME "cElaborador"  OF oSection1 ALIAS "  " TITLE OemToAnsi(STR0015)  SIZE GetSX3Cache("QAA_APELID","X3_TAMANHO") //"Elaboradores"
DEFINE CELL NAME "cRevisor"     OF oSection1 ALIAS "  " TITLE OemToAnsi(STR0016)  SIZE GetSX3Cache("QAA_APELID","X3_TAMANHO") //"Revisores"
DEFINE CELL NAME "cAprovador"   OF oSection1 ALIAS "  " TITLE OemToAnsi(STR0017)  SIZE GetSX3Cache("QAA_APELID","X3_TAMANHO") //"Aprovadores"
DEFINE CELL NAME "cDTVIG"       OF oSection1 ALIAS "  " TITLE TitSX3("QDH_DTVIG")[1] SIZE 10 BLOCK {|| QDH->QDH_DTVIG}
	
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
Local cCDep          := ""
Local cDepto         := Space(9)
Local cFDep          := ""
Local cFDocto        := ""
Local cFilDep        := xFilial("QAD")
Local cFiltro        := ""
Local cQDIDTVG       := SuperGetMv("MV_QDIDTVG", .F., "N")
Local cRDocto        := ""
Local lImprime       := .T.
Local lList          := .t. // Utilizado para verificar se lista ou nao documento
Local nAcho          := 0
Local nI             := 0
Local nTam1          := 0
Local nTamMax        := 0
Local oSection1      := oReport:Section(1)

MakeAdvplExpr(oReport:uParam)
	
DbSelectArea("QDJ")
DbSetOrder(1)

DbSelectArea("QDH")
DbSetOrder(1)

DbSelectArea("QD0")
DbSetOrder(1)

DbSelectArea("QD1")
DbSetOrder(1)

cFiltro := ' QDJ_FILIAL == "' + xFilial("QDJ")+'"'
cFiltro += ' .AND. QDJ_FILMAT >= "'+mv_par08+'"'
cFiltro += ' .AND. QDJ_DEPTO  >= "'+mv_par01+'"'
cFiltro += ' .AND. QDJ_FILMAT <= "'+mv_par09+'"'
cFiltro += ' .AND. QDJ_DEPTO <= "' +mv_par02+'"'
cFiltro += ' .AND. QDJ_DOCTO >= "' +mv_par05+'"'
cFiltro += ' .AND. QDJ_DOCTO <= "' +mv_par06+'"'

oSection1:SetFilter(cFiltro,'QDJ_FILIAL+QDJ_FILMAT+QDJ_DEPTO+QDJ_DOCTO+QDJ_RV+QDJ_TIPO')
	
While QDJ->(!Eof()) .And. QDJ->QDJ_FILIAL == xFilial( "QDJ" )
   	lList    := .F.
    lImprime := .T. 
	
	If QDH->(DbSeek(xFilial("QDJ")+QDJ->QDJ_DOCTO+QDJ->QDJ_RV))

		cFDep   := QDJ->QDJ_FILMAT
		cCDep   := QDJ->QDJ_DEPTO
		cFDocto := QDJ->QDJ_DOCTO
		cRDocto := QDJ->QDJ_RV

		If QD1->(DbSeek(xFilial("QDJ")+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_DEPTO))
		   If QD1->QD1_SIT == "I"
		       lImprime:= .F.
		   Endif    
		Endif   
		
		If QDH->QDH_STATUS == "L  " .And. QDH->QDH_CANCEL <> "S" .And. QDH->QDH_OBSOL <> "S"
			If QDH->QDH_CODTP >= mv_par03 .And. QDH->QDH_CODTP <= mv_par04
				If mv_par07 == 1 .Or. QDH->QDH_DTOIE == If(mv_par07 == 2,'I','E')
					lList := .t.
		  		EndIf
			EndIf
	  	EndIf	
	EndIf
    
	If !lList
		QDJ->(DbSkip())
		Loop
 	Endif
 	
	If QDJ->QDJ_DEPTO != cDepto .AND. lImprime
		
		If FWModeAccess("QAD") == "E" // !Empty(cFilDep)
			cFilDep:= QDJ->QDJ_FILMAT
		EndIf			

        oSection1:Finish()
        oSection1:SetPageBreak(.T.)    
        oSection1:Init()
	   	
	   	oReport:SkipLine(1) 
		oReport:ThinLine()
		oReport:PrintText(Upper(OemToAnsi(STR0019))+" "+AllTrim(QDJ->QDJ_FILMAT),oReport:Row(),005)  //Filial do Departamento		
		oReport:PrintText(Upper(OemToAnsi(STR0008))+AllTrim(QDJ->QDJ_DEPTO)+" - "+QA_NDEPT(QDJ->QDJ_DEPTO,.T.,cFilDep),oReport:Row(),350)  //"Departamento: "
		oReport:SkipLine(1)	
		oReport:ThinLine()
		oReport:SkipLine(1)	
		
	EndIf 
    
   	If lImprime
	   	aElaboradores  := {}
		aRevisores     := {}
		aAprovadores   := {}
		aHomologadores := {}    
		
		If QD0->(DbSeek(xFilial("QD0")+QDJ->QDJ_DOCTO+QDJ->QDJ_RV))
			While QD0->(!Eof()) .And. QD0->QD0_FILIAL+QD0->QD0_DOCTO+QD0->QD0_RV == xFilial("QD0")+QDJ->QDJ_DOCTO+QDJ->QDJ_RV
	
		     	If QD0->QD0_AUT == "E"
	           		nAcho := Ascan( aElaboradores, { |x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT } )
		           	If nAcho == 0
		              	Aadd( aElaboradores, { QD0->QD0_FILMAT, QD0->QD0_MAT } )
		           	EndIf
	        	Endif
	        	
	        	If QD0->QD0_AUT == "R"
		           	nAcho := Ascan( aRevisores, { |x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT } )
		            If nAcho == 0
		            	Aadd( aRevisores, { QD0->QD0_FILMAT, QD0->QD0_MAT } )
		            EndIf
	      	    Endif
	      	    
	      	    If QD0->QD0_AUT == "A"
		          	nAcho := Ascan( aAprovadores, { |x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT } )
		          	If nAcho == 0
		             	Aadd( aAprovadores, { QD0->QD0_FILMAT, QD0->QD0_MAT } )
		           	EndIf
	        	EndIf
				QD0->(DbSkip())
			Enddo	  
		Endif			
	     	
		If cQDIDTVG <> "S"
			oSection1:Cell("cDTVIG"):Hide()  
			oSection1:Cell("cDTVIG"):HideHeader()
		Endif
		
		nTam1  := Max(Len(aElaboradores),Len(aRevisores))
		nTamMax:= Max(nTam1,Len(aAprovadores))
	
	 	For nI:= 1 To nTamMax

		  	If Len( aElaboradores ) >= nI
				oSection1:Cell("cElaborador"):SetValue(QA_NUSR(aElaboradores[nI,1],aElaboradores[nI,2],.T.,"A"))
			Else
				oSection1:Cell("cElaborador"):SetValue(Space(15))	
			EndIf		
				
			If Len( aRevisores ) >= nI
				oSection1:Cell("cRevisor"):SetValue(QA_NUSR(aRevisores[nI,1],aRevisores[nI,2],.T.,"A"))
			Else
				oSection1:Cell("cRevisor"):SetValue(Space(15))
			EndIf
		
			If Len( aAprovadores ) >= nI
				oSection1:Cell("cAprovador"):SetValue(QA_NUSR(aAprovadores[nI,1],aAprovadores[nI,2],.T.,"A"))
			Else
				oSection1:Cell("cAprovador"):SetValue(Space(15))
			EndIf     
		    
			oSection1:PrintLine() 
			
			oSection1:Cell("QDJ_DOCTO"):Hide()
			oSection1:Cell("QDJ_RV"):Hide()
			oSection1:Cell("QDH_TITULO"):Hide()

		Next nI	

		oSection1:Cell("QDJ_DOCTO"):Show()
		oSection1:Cell("QDJ_RV"):Show()
		oSection1:Cell("QDH_TITULO"):Show()

    Endif
    	
	cDepto  := QDJ->QDJ_DEPTO
	QDJ->(DbSkip())
    
   	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se existe departamentos iguais para o mesmo Docto ³
	//³A variavel lList ira controlar a atualizacao das variaveis ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  cFDep == QDJ->QDJ_FILMAT .And. ;
		cCDep == QDJ->QDJ_DEPTO .And. ;
		cFDocto == QDJ->QDJ_DOCTO .And. ;
		cRDocto == QDJ->QDJ_RV
		While QDJ->(!Eof()) .And. 	cFDep == QDJ->QDJ_FILMAT .And. ;
									cCDep == QDJ->QDJ_DEPTO .And. ;
									cFDocto == QDJ->QDJ_DOCTO .And. ;
									cRDocto == QDJ->QDJ_RV
			QDJ->(DbSkip())
			Loop
		EndDo
 	EndIf   
        
EndDo

Return NIL


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ QDOR042R3³ Autor ³ Nwton R. Ghiraldelli  ³ Data ³ 27/08/99    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio Lista Mestra de Documentos por Departamento         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QDOR042()                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ Siga Quality ( Controle de Documentos )                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³   Data ³ BOPS ³ Programador ³Alteracao                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³18/02/02³ META ³ Eduardo S.  ³ Alterado para Listar somente Doctos Vigente³±±
±±³28/03/02³ ---- ³ Eduardo S.  ³ Acerto para imprimir corretamente o Depto. ³±±
±±³08/10/02³ ---- ³ Eduardo S.  ³ Inclusao das perguntas 08 e 09 permitindo  ³±±
±±³        ³      ³             ³ filtrar por filial dos usuarios.           ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QDOR042R3()

Local cTitulo := OemToAnsi(STR0001) // "LISTA MESTRA DE DOCUMENTOS POR DEPARTAMENTO"
Local cDesc1  := OemToAnsi(STR0002) // "Este programa ir  imprimir uma rela‡„o dos documentos,"
Local cDesc2  := OemToAnsi(STR0003) // "seus elaboradores, revisores, aprovadores com quebra"
Local cDesc3  := OemToAnsi(STR0004) // "por departamento e parƒmetros selecionados pelo usu rio."
Local cString := "QDJ" 
Local wnrel   := "QDOR042"
Local Tamanho := "M"

Private cPerg   := "QDR041"
Private aReturn := {OemToAnsi(STR0005),1,OemToAnsi(STR0006),1,2,1,"",1} // "Zebrado" ### "Administra‡ao"
Private nLastKey:= 0
Private Inclui  := .f. // Colocada para utilizar as funcoes

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                               ³
//³ mv_par01	// De Departamento                                      ³
//³ mv_par02	// Ate Departamento                                     ³
//³ mv_par03	// De  Tipo de Documento                                ³
//³ mv_par04	// Ate Tipo de Documento                                ³
//³ mv_par05	// De  Documento                                        ³
//³ mv_par06	// Ate Documento                                        ³
//³ mv_par07	// Documento (Ambos/Interno/Externo)                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("QDJ")

Pergunte(cPerg,.F.)

wnrel := SetPrint(cString,wnrel,cPerg,ctitulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| QDOR042Imp(@lEnd,cTitulo,wnRel,Tamanho)},cTitulo)

Return .t.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³QDOR042Imp ³ Autor ³ Newton R. Ghiraldelli ³ Data ³ 13/07/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Envia para funcao que faz a impressao do relatorio.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QDOR042Imp(ExpL1,ExpC1,ExpC2,ExpC3)                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1 - Cancela Relatorio                                   ³±±
±±³          ³ ExpC1 - Titulo do Relatorio                                 ³±±
±±³          ³ ExpC2 - Nome do Relatorio                                   ³±±
±±³          ³ ExpC3 - Tamanho do Relatorio                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR042                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QDOR042Imp(lEnd,cTitulo,wnRel,Tamanho )

Local cCabec1       := ""
Local cCabec2       := "" 
Local cbtxt         := Space( 10 )
Local nTipo         := GetMV( "MV_COMP" )
Local cbcont        := 0
Local nTam1         := 0
Local nTamMax       := 0
Local nI            := 0
Local nAcho	        := 0
Local lList         := .t. // Utilizado para verificar se lista ou nao documento
Local aElaboradores := {}
Local aRevisores    := {}
Local aAprovadores  := {}
Local aHomologadores:= {}
Local cDepto        := Space(9)
Local cIndex1       := ""
Local cFiltro       := ""
Local cKey          := ""
Local cFilDep       := xFilial("QAD")
Local cFDep         := ""
Local cCDep         := ""
Local cFDocto       := ""
Local cRDocto       := ""
Local lImprime      := .T.
Local cQDIDTVG      := SuperGetMv("MV_QDIDTVG", .F., "N")

Private Limite:= 132
Private nIndex:= 0

cCabec1 := " "
cCabec2 := OemToAnsi(STR0010)+OemToAnsi(STR0011)//"DOCUMENTO        REV TITULO                                               ELABORADORES    REVISORES       APROVADORES"

If cQDIDTVG == "S"
	cCabec2 := cCabec2+OemToAnsi(STR0012) //"     VIGENCIA"
Endif

Li    := 80
m_pag := 1

QD0->(DbSetOrder(1))
QDH->(DbSetOrder(1))
QDJ->(DbSetOrder(1))
QD1->(DbSetOrder(1))

cKey   := "QDJ_FILIAL+QDJ_FILMAT+QDJ_DEPTO+QDJ_DOCTO+QDJ_RV+QDJ_TIPO"
cIndex1:= CriaTrab(Nil,.f.)

cFiltro := 'QDJ_FILIAL == "' + xFilial("QDJ")+'"'
cFiltro += ' .AND. QDJ_FILMAT >= "'+mv_par08+'"'
cFiltro += ' .AND. QDJ_DEPTO >= "' +mv_par01+'"'
cFiltro += ' .AND. QDJ_FILMAT <= "'+mv_par09+'"'
cFiltro += ' .AND. QDJ_DEPTO <= "' +mv_par02+'"'
cFiltro += ' .AND. QDJ_DOCTO >= "' +mv_par05+'"'
cFiltro += ' .AND. QDJ_DOCTO <= "' +mv_par06+'"'

If ! Empty(aReturn[7])	// Filtro de Usuario
	cFiltro += " .And. (" + aReturn[7] + ")"
Endif

IndRegua("QDJ",cIndex1,cKey,,cFiltro,OemToAnsi(STR0007)) // "Selecionando Registros.."
nIndex := RetIndex("QDJ")+1

DbSetOrder(nIndex)
DbSeek(xFilial("QDJ"))
SetRegua(LastRec()) // Total de Elementos da Regua

While QDJ->(!Eof())
	IncRegua()
	lList 	 := .F.
	lImprime := .T. 
	
 	If QDH->(DbSeek(xFilial("QDJ")+QDJ->QDJ_DOCTO+QDJ->QDJ_RV))

		cFDep   := QDJ->QDJ_FILMAT
		cCDep   := QDJ->QDJ_DEPTO
		cFDocto := QDJ->QDJ_DOCTO
		cRDocto := QDJ->QDJ_RV

		cTitulo1:= QDH->QDH_TITULO 
		If QD1->(DbSeek(xFilial("QDJ")+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_DEPTO))
		   If QD1->QD1_SIT == "I"
		       lImprime:= .F.
		   Endif    
		Endif   

		If QDH->QDH_STATUS == "L  " .And. QDH->QDH_CANCEL <> "S" .And. QDH->QDH_OBSOL <> "S"
			If QDH->QDH_CODTP >= mv_par03 .And. QDH->QDH_CODTP <= mv_par04
				If mv_par07 == 1 .Or. QDH->QDH_DTOIE == If(mv_par07 == 2,'I','E')
					lList := .t.
		  		EndIf
			EndIf
	  	EndIf	
	EndIf
    
	If !lList
		QDJ->(DbSkip())
		Loop
 	Endif
 	
	If QDJ->QDJ_DEPTO != cDepto .AND. lImprime
		If FWModeAccess("QAD") == "E" //!Empty(cFilDep)
			cFilDep:= QDJ->QDJ_FILMAT
		EndIf			
    	Li := 80
		cCabec1:= Upper(OemToAnsi(STR0019)+" "+AllTrim(QDJ->QDJ_FILMAT)+"    "+OemToAnsi(STR0008))+AllTrim(QDJ->QDJ_DEPTO)+" - "+QA_NDEPT(QDJ->QDJ_DEPTO,.T.,cFilDep) //"Departamento: "
		If Li > 58
			Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
		EndIf
		If lEnd
      	Li++
			@ PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
	EndIf 
	If lImprime
		aElaboradores  := {}
		aRevisores     := {}
		aAprovadores   := {}
		aHomologadores := {}    
		If QD0->(DbSeek(xFilial("QD0")+QDJ->QDJ_DOCTO+QDJ->QDJ_RV))
			While QD0->(!Eof()) .And. QD0->QD0_FILIAL+QD0->QD0_DOCTO+QD0->QD0_RV == xFilial("QD0")+QDJ->QDJ_DOCTO+QDJ->QDJ_RV
		     	If QD0->QD0_AUT == "E"
	           	nAcho := Ascan( aElaboradores, { |x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT } )
	           	If nAcho == 0
	              	Aadd( aElaboradores, { QD0->QD0_FILMAT, QD0->QD0_MAT } )
	           	EndIf
	        	ElseIf QD0->QD0_AUT == "R"
	           	nAcho := Ascan( aRevisores, { |x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT } )
	            If nAcho == 0
	            	Aadd( aRevisores, { QD0->QD0_FILMAT, QD0->QD0_MAT } )
	            EndIf
	      	ElseIf QD0->QD0_AUT == "A"
	          	nAcho := Ascan( aAprovadores, { |x| x[1] == QD0->QD0_FILMAT .And. x[2] == QD0->QD0_MAT } )
	          	If nAcho == 0
	             	Aadd( aAprovadores, { QD0->QD0_FILMAT, QD0->QD0_MAT } )
	           	EndIf
	        	EndIf
				QD0->(DbSkip())
			Enddo	  
		Endif			
	
	  	If lEnd
			Li++
			@ PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
	     	
		If Li > 58
	 		Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
		EndIf
	
		@ Li,000 PSay Substr(Alltrim(QDJ->QDJ_DOCTO),1,16)
	 	@ Li,017 PSay Substr(Alltrim(QDJ->QDJ_RV),1,3)
	  	@ Li,021 PSay Substr(Alltrim(cTitulo1),1,53)
	  	cTitulo1 := Substr(cTitulo1,54)	
		
		If Len( aElaboradores ) >= 1
	 		@ Li,075 PSay Substr(QA_NUSR(aElaboradores[1,1],aElaboradores[1,2],.T.,"A"),1,15)
	  	EndIf		
		If Len( aRevisores ) >= 1
	 		@ Li,091 PSay Substr(QA_NUSR(aRevisores[1,1],aRevisores[1,2],.T.,"A"),1,15)
	 	EndIf
		If Len( aAprovadores ) >= 1
			@ Li,107 PSay Substr(QA_NUSR(aAprovadores[1,1],aAprovadores[1,2],.T.,"A"),1,15)
	  	EndIf
	   		
		If cQDIDTVG == "S"
			@ Li,123 PSay QDH->QDH_DTVIG
		Endif

		Li++
			
	 	nTam1  := Max(Len(aElaboradores),Len(aRevisores))
		nTamMax:= Max(nTam1,Len(aAprovadores))
			
	 	For nI:= 2 To nTamMax
	  		If lEnd
	    		Li++							 
		      	@ PROW()+1,001 PSAY OemToAnsi(STR0009) // "CANCELADO PELO OPERADOR"
	        	Exit
	    	EndIf         	
	    	If Li > 58
	     		Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
	    	EndIf            
			If Len(Alltrim(cTitulo1)) > 0
	  			@ Li,021 PSay Substr(Alltrim(cTitulo1),1,53)
			  	cTitulo1 := Substr(cTitulo1,54)
	  		EndIf           
	     	If nI <= Len( aElaboradores )
	     		@ Li,075 PSay Substr(QA_NUSR(aElaboradores[nI,1],aElaboradores[nI,2],.T.,"A"),1,15)
	     	EndIf		            
	     	If nI <= Len( aRevisores )
	     		@ Li,091 PSay Substr(QA_NUSR(aRevisores[nI,1],aRevisores[nI,2],.T.,"A"),1,15)
	     	EndIf            
	     	If nI <= Len( aAprovadores )
	    		@ Li,107 PSay Substr(QA_NUSR(aAprovadores[nI,1],aAprovadores[nI,2],.T.,"A"),1,15)
			EndIf
			Li++
		Next nI	

		While Len(Alltrim(cTitulo1)) > 0
  			@ Li,021 PSay Substr(Alltrim(cTitulo1),1,53)
		  	cTitulo1 := Substr(cTitulo1,54) 
			Li++
	  	Enddo

		cDepto  := QDJ->QDJ_DEPTO
	Endif

	QDJ->(DbSkip())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se existe departamentos iguais para o mesmo Docto ³
	//³A variavel lList ira controlar a atualizacao das variaveis ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  cFDep == QDJ->QDJ_FILMAT .And. ;
		cCDep == QDJ->QDJ_DEPTO .And. ;
		cFDocto == QDJ->QDJ_DOCTO .And. ;
		cRDocto == QDJ->QDJ_RV
		While QDJ->(!Eof()) .And. 	cFDep == QDJ->QDJ_FILMAT .And. ;
									cCDep == QDJ->QDJ_DEPTO .And. ;
									cFDocto == QDJ->QDJ_DOCTO .And. ;
									cRDocto == QDJ->QDJ_RV
			QDJ->(DbSkip())
		EndDo
 	EndIf

	Li++
	
EndDo

If Li != 80
	Roda(cbCont,cbTxt,tamanho)
EndIf

RetIndex("QDJ")
Set Filter to
FErase(cIndex1 + OrdBagExt())

Set Device To Screen

If aReturn[5] = 1
	Set Printer To 
	dbCommitAll()
	Ourspool(wnrel)
Endif

Ms_Flush()

Return (.T.)
