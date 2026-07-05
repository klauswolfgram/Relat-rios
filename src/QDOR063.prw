/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "QDOR063.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QDOR063   ºAutor  ³Leandro Sabino      º Data ³  04/07/06	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Protocolo de Recolhimento de Documentos                    º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QDOR063(lBat,cDocto,cRv)

	Local oReport := Nil

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variavel utiLizada para verificar se o relatorio foi iniciado³
	//³ pelo MNU ou pela rotina de documentos.                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lBat:= If(lBat == NIL,.F.,lBat)

	Private cPerg   := If(lBat,"QDR061","QDR060")

	Pergunte(cPerg,.F.) 
	oReport := ReportDef(lBat,cDocto,cRv)
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
±±³ Uso      ³ QDOR063                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(lBat,cDocto,cRv)

	Local cDesc1    := OemToAnsi(STR0002) //"Este programa ir  imprimir o Protocolo de Recolhimento de Documentos"
	Local cDesc2    := OemToAnsi(STR0003) //"e Registros da QuaLidade, que assegura o recebimento de documentos e"
	Local cDesc3    := OemToAnsi(STR0004) //"recolhimento da Revisao anterior por todos os envolvidos em sua implementa‡„o"
	Local cTitulo   := OemToAnsi(STR0001) //"PROTOCOLO DE RECOLHIMENTO DE DOCUMENTOS E REGISTROS DA QUALIDADE"
	Local oSection1 := Nil
	Local oSection2 := Nil
	Local oSection3 := Nil

	DEFINE REPORT oReport NAME "QDOR063" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,lBat, cDocto,cRv)} DESCRIPTION (cDesc1+cDesc2+cDesc3)
	oReport:SetLandscape(.T.)

	DEFINE SECTION oSection1 OF oReport TABLES "TRB","QDH" TITLE OemToAnsi(STR0019)
	DEFINE CELL NAME "DOC"    OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0019) SIZE 16 //"Documento"
	DEFINE CELL NAME "REV"    OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0020) SIZE 03 //"Revisao"
	DEFINE CELL NAME "TITULO" OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0021) SIZE 70 //"Titulo"

	DEFINE SECTION oSection2 OF oSection1 TABLES "TRB","QDH" TITLE OemToAnsi(STR0022)
	DEFINE CELL NAME "PROTOCOLO" OF oSection2 ALIAS "TRB" TITLE OemToAnsi(STR0022) SIZE 80 //"Protocolo"
	oSection2:Cell("PROTOCOLO"):SeTLineBREAK(.T.)

	DEFINE SECTION oSection3 OF oSection2 TABLES "TRB","QD1" TITLE OemToAnsi(STR0023)
	DEFINE CELL NAME "DEPTO" OF oSection3 ALIAS "TRB" TITLE OemToAnsi(STR0023) SIZE 50 //"Departamento"

	DEFINE SECTION oSection4 OF oSection3 TABLES "TRB","QD1" TITLE OemToAnsi(STR0017)
	DEFINE CELL NAME "Usu"   OF oSection4 ALIAS "TRB" TITLE OemToAnsi(STR0024) SIZE 20 //"Responsavel"
	DEFINE CELL NAME "Tipo"  OF oSection4 ALIAS "TRB" TITLE OemToAnsi(STR0025) SIZE 13 //"Tipo"
	DEFINE CELL NAME "Copia" OF oSection4 ALIAS "TRB" TITLE OemToAnsi(STR0026) SIZE 22 //"Copias"
	DEFINE CELL NAME "DataDOC"  OF oSection4 ALIAS "TRB" TITLE OemToAnsi(STR0027) SIZE 10 //"Data"
	DEFINE CELL NAME "Assin" OF oSection4 ALIAS "TRB" TITLE OemToAnsi(STR0028) SIZE 13 //"Assinatura"

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 01/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1,ExpO21)   	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          | ExpO2 = variavel lBat									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR080                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport( oReport,lBat,cDocto,cRv)

Local aCampos   := {}
Local aRegQDG   := {}
Local cAliasQDH := "QDH"
Local cAliasQry := GetNextAlias()
Local cChave1   := ""
Local cChave2   := ""
Local cChave3   := ""
Local cFilDep   := xFilial("QAD")
Local cFiltro   := ""
Local cIndex1   := ""
Local cKey      := ""
Local cRvAnt    := ""
Local cTPDIST   := ""
Local lBreak    := .F.
Local nTpDisp   := 0
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1)
Local oSection4 := oReport:Section(1):Section(1):Section(1):Section(1)

DbSelectArea("QD2")
QD2->(DbSetOrder(1))

DbSelectArea("QDG")
QDG->(DbSetOrder(3))

DbSelectarea("QD1")
QD1->(DbSetOrder(1))

DbSelectArea("QDH")
QDH->(DbSetOrder(1))

// Cria Arquivo de Trabalho temporario
Aadd(aCampos,{"DOC"	      ,"C",016,0})
Aadd(aCampos,{"Rev"	      ,"C",003,0})
Aadd(aCampos,{"TITULO"	  ,"C",100,0})
Aadd(aCampos,{"PROTOCOLO" ,"C",1000,0})
Aadd(aCampos,{"DEPTO"     ,"C",050,0})
Aadd(aCampos,{"Usu"	      ,"C",020,0})
Aadd(aCampos,{"Tipo"	  ,"C",013,0})
Aadd(aCampos,{"Copia"	  ,"C",022,0})
Aadd(aCampos,{"DataDoc"	  ,"C",010,0})
Aadd(aCampos,{"Assin"	  ,"C",013,0})

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"DOC","REV","DEPTO"} )
oTempTable:Create()

If lBat
	QDH->(DbSeek(M->QDH_FILIAL+cDocto+cRv)) // Retorna a Posicao do QDH - Documentos
Endif

If !lBat
	// Cria Indice Condicional nos arquivos utiLizados
	cIndex1:= CriaTrab(Nil,.F.)
	cKey   := QDH->(IndexKey())	
	cFiltro:= 'QDH->QDH_FILIAL == "'+xFiLial("QDH")+'".And. '
	cFiltro+= 'QDH->QDH_DOCTO >= "'+mv_par02+'".And. QDH->QDH_DOCTO <= "'+mv_par03+'".And. '
	cFiltro+= 'QDH->QDH_RV >= "'+mv_par04+'".And. QDH->QDH_RV <= "'+mv_par05+'"'
	IndRegua(cAliasQDH,cIndex1,cKey,,cFiltro,OemToAnsi(STR0007))	//"Selecionando Registros.."
	QDH->(dbGoTop())

	nTpDisp := MV_PAR08

Else

	Pergunte("QDR061",.F.)

	IF EMPTY(MV_PAR08)
		nTpDisp := MV_PAR02
	ELSE
		nTpDisp := MV_PAR08
	ENDIF

	// Posiciona o Documento na Revisao Anterior
	DbSelectArea("QDH")
	QDH->(DbSetOrder(1))
	QDH->(dbGoTop())
	If QDH->(DbSeek(M->QDH_FILIAL+cDocto))
		While QDH->(!Eof()) .And. QDH->(QDH_FILIAL+QDH->QDH_DOCTO) == M->(QDH_FILIAL+cDocto)
			If cRv == QDH->QDH_RV
				Exit
			Else
				cRvAnt:= QDH->QDH_RV
				QDH->(DbSkip())
			EndIf
		Enddo
		QDH->(DbSeek(M->QDH_FILIAL+cDocto+cRvAnt))
	EndIf

	// Cria Indice Condicional nos arquivos utiLizados
	cIndex1:= CriaTrab(Nil,.F.)
	cKey   := QDH->(IndexKey())	
	cFiltro:= 'QDH->QDH_FILIAL == "'+xFiLial("QDH")+'".And. '
	cFiltro+= 'QDH->QDH_DOCTO == "'+cDocto+'".And. '
	cFiltro+= 'QDH->QDH_RV == "'+cRvAnt+'"'
	IndRegua(cAliasQDH,cIndex1,cKey,,cFiltro,OemToAnsi(STR0007))	//"Selecionando Registros.."
	(cAliasQDH)->(dbGoTop())

EndIf

If !lBat //Relatório Via Menu
		cQuery :=  " SELECT DISTINCT QD1.QD1_FILIAL, "
		cQuery +=  "                 QD1.QD1_FILMAT, "
		cQuery +=  "                 QD1.QD1_MAT, "
		cQuery +=  "                 QD1.QD1_TPDIST, "
		cQuery +=  "                 QD1.QD1_DOCTO, "
		cQuery +=  "                 QD1.QD1_RV, "
		cQuery +=  "                 QD1.QD1_DEPTO, "
		cQuery +=  "                 QD1.QD1_SIT "
		cQuery +=  "            FROM " +RetSQLName("QD1") +" QD1 "
		cQuery +=  "           WHERE QD1.QD1_FILIAL = '"+xFiLial("QD1")+"' "
		cQuery +=  "             AND QD1.QD1_DOCTO >= '"+mv_par02+"' " //Documento
		cQuery +=  "             AND QD1.QD1_DOCTO <= '"+mv_par03+"' " //Documento
		cQuery +=  "             AND QD1.QD1_RV    >= '"+mv_par04+"' " //Revisão
		cQuery +=  "             AND QD1.QD1_RV    <= '"+mv_par05+"' " //Revisão
		cQuery +=  "             AND QD1.QD1_DEPTO >= '"+mv_par06+"' " //Departamento
		cQuery +=  "             AND QD1.QD1_DEPTO <= '"+mv_par07+"' " //Departamento
		cQuery +=  "             AND QD1.QD1_SIT <> 'I' "
		cQuery +=  "             AND QD1.D_E_L_E_T_ = ' ' "
		cQuery +=  "             AND QD1.QD1_TPPEND = 'L'  "
	
		If mv_par08 == 1 
			cQuery +=  " AND (QD1.QD1_TPDIST = '1') "// 1-Eletrônicas  
		ElseIf mv_par08 == 2 
			cQuery +=  " AND (QD1.QD1_TPDIST = '2') "// 2-Em Papel     
		ElseIf mv_par08 == 3 
			cQuery +=  " AND (QD1.QD1_TPDIST = '3') "// 3-Eletr. e Pap.	
		ElseIf mv_par08 == 4
			cQuery +=  " AND (QD1.QD1_TPDIST = '4') "// 4-Não Recebe   
		EndIf
			
		cQuery +=  "           UNION "
			
		cQuery +=  " SELECT DISTINCT QDG.QDG_FILIAL, "
		cQuery +=  "                 QDG.QDG_FILMAT, "
		cQuery +=  "                 QDG.QDG_MAT, "
		cQuery +=  "                 QDG.QDG_TPRCBT, "
		cQuery +=  "                 QDG.QDG_DOCTO, "
		cQuery +=  "                 QDG.QDG_RV, "
		cQuery +=  "                 QDG.QDG_DEPTO, "
		cQuery +=  "                 QDG.QDG_SIT "
		cQuery +=  "            FROM " +RetSQLName("QDG") +" QDG "
		cQuery +=  "           WHERE QDG.QDG_FILIAL = '"+xFiLial("QDG")+"' "
		cQuery +=  "             AND QDG.QDG_DOCTO >= '"+mv_par02+"' " //Documento
		cQuery +=  "             AND QDG.QDG_DOCTO <= '"+mv_par03+"' " //Documento
		cQuery +=  "             AND QDG.QDG_RV    >= '"+mv_par04+"' " //Revisão
		cQuery +=  "             AND QDG.QDG_RV    <= '"+mv_par05+"' " //Revisão
		cQuery +=  "             AND QDG.QDG_DEPTO >= '"+mv_par06+"' " //Departamento
		cQuery +=  "             AND QDG.QDG_DEPTO <= '"+mv_par07+"' " //Departamento
		cQuery +=  "             AND QDG.QDG_SIT <> 'I' "
		cQuery +=  "             AND QDG.D_E_L_E_T_ = ' ' "
		
		If mv_par08 == 1 
			cQuery +=  " AND (QDG.QDG_TPRCBT = '1') "// 1-Eletrônicas  
		ElseIf mv_par08 == 2 
			cQuery +=  " AND (QDG.QDG_TPRCBT = '2') "// 2-Em Papel     
		ElseIf mv_par08 == 3 
			cQuery +=  " AND (QDG.QDG_TPRCBT = '3') "// 3-Eletr. e Pap.	
		ElseIf mv_par08 == 4
			cQuery +=  " AND (QDG.QDG_TPRCBT = '4') "// 4-Não Recebe   
		EndIf

Else

	cQuery :=  " SELECT DISTINCT QD1.QD1_FILIAL, "
	cQuery +=  "                 QD1.QD1_FILMAT, "
	cQuery +=  "                 QD1.QD1_MAT, "
	cQuery +=  "                 QD1.QD1_TPDIST, "
	cQuery +=  "                 QD1.QD1_DOCTO, "
	cQuery +=  "                 QD1.QD1_RV, "
	cQuery +=  "                 QD1.QD1_DEPTO, "
	cQuery +=  "                 QD1.QD1_SIT "
	cQuery +=  "            FROM " +RetSQLName("QD1") +" QD1 "
	cQuery +=  "           WHERE QD1.QD1_FILIAL = '" + (cAliasQDH)->QDH_FILIAL + "' " 
	cQuery +=  "             AND QD1.QD1_DOCTO = '"+ (cAliasQDH)->QDH_DOCTO +"' " 
	cQuery +=  "             AND QD1.QD1_RV = '" + (cAliasQDH)->QDH_RV + "' "
	cQuery +=  "             AND QD1.QD1_SIT <> 'I' "
	cQuery +=  "             AND QD1.D_E_L_E_T_ = ' ' "
	cQuery +=  "             AND QD1.QD1_TPPEND = 'L'  "

	If nTpDisp == 1 
		cQuery +=  " AND (QD1.QD1_TPDIST = '1') "// 1-Eletrônicas  
	ElseIf nTpDisp == 2 
		cQuery +=  " AND (QD1.QD1_TPDIST = '2') "// 2-Em Papel     
	ElseIf nTpDisp == 3 
		cQuery +=  " AND (QD1.QD1_TPDIST = '3') "// 3-Eletr. e Pap.	
	ElseIf nTpDisp == 4
		cQuery +=  " AND (QD1.QD1_TPDIST = '4') "// 4-Não Recebe   
	EndIf
		
	cQuery +=  "           UNION "
		
	cQuery +=  " SELECT DISTINCT QDG.QDG_FILIAL, "
	cQuery +=  "                 QDG.QDG_FILMAT, "
	cQuery +=  "                 QDG.QDG_MAT, "
	cQuery +=  "                 QDG.QDG_TPRCBT, "
	cQuery +=  "                 QDG.QDG_DOCTO, "
	cQuery +=  "                 QDG.QDG_RV, "
	cQuery +=  "                 QDG.QDG_DEPTO, "
	cQuery +=  "                 QDG.QDG_SIT "
	cQuery +=  "            FROM " +RetSQLName("QDG") +" QDG "
	cQuery +=  "           WHERE QDG.QDG_FILIAL = '" + (cAliasQDH)->QDH_FILIAL + "' " 
	cQuery +=  "             AND QDG.QDG_DOCTO = '"+ (cAliasQDH)->QDH_DOCTO +"' " 
	cQuery +=  "             AND QDG.QDG_RV = '" + (cAliasQDH)->QDH_RV + "' "
	cQuery +=  "             AND QDG.QDG_SIT <> 'I' "
	cQuery +=  "             AND QDG.D_E_L_E_T_ = ' ' "

	If nTpDisp == 1 
		cQuery +=  " AND (QDG.QDG_TPRCBT = '1') "// 1-Eletrônicas   
	ElseIf nTpDisp == 2 
		cQuery +=  " AND (QDG.QDG_TPRCBT = '2') "// 2-Em Papel     
	ElseIf nTpDisp == 3 
		cQuery +=  " AND (QDG.QDG_TPRCBT = '3') "// 3-Eletr. e Pap.	
	ElseIf nTpDisp == 4
		cQuery +=  " AND (QDG.QDG_TPRCBT = '4') "// 4-Não Recebe    
	EndIf
EndIf
	
cQuery := ChangeQuery(cQuery)
DbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery), cAliasQry, .T., .T.)


// Processando os arquivos
dbSelectArea("QDH")
While (cAliasQDH)->(!Eof())
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QDH")))
		If !QDH->(&(oReport:Section(1):GetAdvplExp("QDH")))
			(cAliasQDH)->(DBSkip())
			Loop
		Endif
	Endif

	While (cAliasQry)->(!Eof()) 

		If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QD1")))
			If !(cAliasQry)->(&(oReport:Section(1):GetAdvplExp("QD1")))
				(cAliasQry)->(DBSkip())
				Loop
			Endif
		EndIf
		
		RecLock("TRB",.T.)
		
		TRB->DOC   := (cAliasQDH)->QDH_DOCTO
		TRB->Rev   := (cAliasQDH)->QDH_RV
		TRB->TITULO:= (cAliasQDH)->QDH_TITULO
		
		TRB->USU  := (SubsTr(QA_NUSR((cAliasQry)->QD1_FILMAT,(cAliasQry)->QD1_MAT,.T.),1,23)) 

		DbSelectArea("QD2")
		DbSetOrder(1)
		If QD2->(DbSeek(xFilial("QD2")+(cAliasQDH)->QDH_CODTP))
			TRB->Protocolo := MSMM(QD2->QD2_PROTOC)
		EndIf
		
		TRB->DEPTO := (cAliasQry)->QD1_DEPTO +" - "+QA_NDEPT((cAliasQry)->QD1_DEPTO,.T.,cFilDep)
		If nTpDisp <> 4
			If QDG->(DbSeek((cAliasQry)->(QD1_FILIAL + QD1_DOCTO + QD1_RV + QD1_FILMAT + QD1_DEPTO + QD1_MAT)))
				While QDG->(!Eof()) .And. QDG->(QDG_DOCTO + QDG_RV + QDG_FILMAT + QDG_DEPTO + QDG_MAT) == (cAliasQry)->(QD1_DOCTO + QD1_RV + QD1_FILMAT + QD1_DEPTO + QD1_MAT)
					If aScan(aRegQDG,{ |X| X == QDG->(Recno()) }) == 0 .AND. QDG->QDG_TPRCBT == (cAliasQry)->QD1_TPDIST
						aAdd(aRegQDG,QDG->(Recno()))
						Exit
					Endif
					QDG->(DbSkip())
				Enddo  
				If (QDG->QDG_TIPO == "D")
					TRB->TIPO :=OemToAnsi(STR0017)
				Else	
					TRB->TIPO :=OemToAnsi(STR0018)
				Endif	

				cTPDIST := U_QDORSTR63((cAliasQry)->QD1_TPDIST)

				TRB->Copia := (StrZero(QDG->QDG_NCOP,4))+" "+cTPDIST
		
			EndIf
		Else
			cTPDIST := U_QDORSTR63((cAliasQry)->QD1_TPDIST)

			TRB->Copia := (StrZero(00,4))+" "+cTPDIST
		EndIf   

		TRB->DATADOC  := "___/___/___"
		TRB->Assin := RepLicate("_",12)
		TRB->(MsUnlock())

		(cAliasQry)->(dbSkip())
	EndDo
	(cAliasQry)->(dbGoTop())
  	(cAliasQDH)->(dbSkip())

EndDo
(cAliasQry)->(DBCloseArea())

// Impressao do arquivo temporario
If MV_PAR01 == 1
	lBreak := .T.
Endif	

dbSelectArea("TRB")
dbGoTop()
While !oReport:Cancel() .And. TRB->(!Eof())
	If cChave3 = TRB->DOC+TRB->REV+TRB->DEPTO+TRB->USU
		TRB->(dbSkip())
		loop
	EndIf
  	If cChave1 <> TRB->DOC+TRB->REV
  	    oSection1:Finish()
		oSection2:Finish()
		oSection3:Finish()
		oSection4:Finish()
		oSection1:Init()
		oSection1:SetPageBreak(.T.) 
		oSection1:PrintLine()
		oSection2:Init()
		oSection2:PrintLine()
		oSection3:Init()
		oSection3:PrintLine()
		oSection4:Init()
    Else
       If cChave2 <> TRB->DEPTO
		 If lBreak
			oSection1:Finish()
			oSection2:Finish()
			oSection3:Finish()
			oSection4:Finish()
			oSection1:Init()
			oSection1:SetPageBreak(.T.) 
			oSection1:PrintLine()
			oSection2:Init()
			oSection2:PrintLine()
			oSection3:Init()
			oSection3:PrintLine()
			oSection4:Init()
	      Else
	   		oSection3:Finish()	
			oSection3:Init()
			oSection3:PrintLine()       
	      Endif
	   Endif
	EndIf
	
	oSection4:PrintLine()
	oReport:SkipLine(1)	      	

	cChave1 := TRB->DOC+TRB->REV
	cChave2 := TRB->DEPTO

	cChave3 := TRB->DOC+TRB->REV+TRB->DEPTO+TRB->USU
	TRB->(dbSkip())

Enddo
TRB->(DBCloseArea())

oTempTable:Delete()

Return

/*/{Protheus.doc} QDORSTR63
Função genérica para validar o tipo de distribuição
@type function
@version 
@author thiago.rover
@since 20/02/2020
@param cTPDIST, character, param_description
@return return_type, return_description
/*/
User Function QDORSTR63(cTPDIST)

	Local cSTRDIST := ""

	Do Case 
		Case cTPDIST == "1"
			cSTRDIST:=OemToAnsi(STR0011)// " Eletronicas"
		Case cTPDIST == "2"
			cSTRDIST:=OemToAnsi(STR0012)// " Em Papel"
		Case cTPDIST == "3"
			cSTRDIST:=OemToAnsi(STR0013)// " Eletronica/Papel"
		Case cTPDIST == "4"
			cSTRDIST:=OemToAnsi(STR0014)// " Nao Recebe"
	EndCase

Return cSTRDIST
