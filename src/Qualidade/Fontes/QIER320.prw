/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER320.CH"
#INCLUDE "Report.CH"
#INCLUDE "TOTVS.CH"

Static lQLTDispSVR := Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QIER320   ºAutor  ³Leandro Sabino      º Data ³  04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ficha de Produto sem Entradas                              º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QIER320()

	Local oReport := Nil

	lQLTDispSVR   := Iif(lQLTDispSVR == Nil, FindFunction("QLTDispSVR"), lQLTDispSVR)

	If !lQLTDispSVR .OR. !QLTDispSVR("manufacturing.sv.qie.inspectionform")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utilizadas para parametros						 ³
		//³ mv_par01 = Fornecedor			?				 			 ³
		//³ mv_par02 = Loja Fornecedor		?    		 				 ³
		//³ mv_par03 = Produto				?			 				 ³
		//³ mv_par04 = Do Laborat¢rio 	    ?				     		 ³
		//³ mv_par05 = At‚ Laborat¢rio      ?					 		 ³
		//³ mv_par06 = Considera Entrada    ? 1)-Normal		 	 		 ³
		//³  							  	  2)-Beneficiamento 	 	 ³
		//³  							  	  3)-Devolucoes     	 	 ³
		//³ mv_par07 = Linhas para Medicoes ? 							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Pergunte("QER320",.F.)
		oReport := ReportDef()
		oReport:PrintDialog()

	EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 04/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER320                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(cProg,lImpres,nConta)
Local oReport                                             
Local oSection0,oSection1,oSection2,oSection3,oSection4
Local cTitulo   := OemToAnsi(STR0001) // "Plano de Inspecao"
Local cDesc1    := OemToAnsi(STR0002) // "Neste relat¢rio ser„o relacionados os ensaios a serem realizados em ca-"
Local cDesc2 	:= OemToAnsi(STR0003) // "da laborat¢rio, para a valida‡„o da Entrada."

DEFINE REPORT oReport NAME "QIER320" TITLE cTitulo PARAMETER "QER320" ACTION {|oReport| PrintReport(oReport,cProg,lImpres,nConta)} DESCRIPTION (cDesc1+cDesc2)
oReport:SetPortrait()

DEFINE SECTION oSection0 OF oReport TABLES "QE7","QE8"  TITLE STR0037//Cabecalho
oSection0:SetEdit(.F.)

DEFINE SECTION oSection1 OF oReport TABLES "QE7","QE8" TITLE TitSX3("QE7_ENSAIO")[1]//Ensaio
DEFINE CELL NAME "cENSAIO"  OF oSection1 ALIAS "" SIZE TAMSX3("QE7_DESENS")[1] TITLE TitSX3("QE7_ENSAIO")[1]
DEFINE CELL NAME "cMETODO"  OF oSection1 ALIAS "" SIZE TAMSX3("QE7_METODO")[1] TITLE TitSX3("QE7_METODO")[1]
DEFINE CELL NAME "cTIPO"    OF oSection1 ALIAS "" SIZE TAMSX3("QE7_TIPO")[1]   TITLE TitSX3("QE7_TIPO")[1]
DEFINE CELL NAME "cUM"      OF oSection1 ALIAS "" SIZE 40 TITLE STR0009 LINE BREAK //"Un. Med."
DEFINE CELL NAME "cNominal" OF oSection1 ALIAS "" SIZE 06 TITLE STR0010//"Nominal"
DEFINE CELL NAME "cLIE"     OF oSection1 ALIAS "" SIZE 08 TITLE STR0011//"L.I.E." 
DEFINE CELL NAME "cLSE"     OF oSection1 ALIAS "" SIZE 08 TITLE STR0012//"L.S.E."
DEFINE CELL NAME "cPl"      OF oSection1 ALIAS "" SIZE 03 TITLE STR0013//"Pl "
DEFINE CELL NAME "cNIVEL"   OF oSection1 ALIAS "" SIZE TAMSX3("QE7_NIVEL")[1] TITLE TitSX3("QE7_NIVEL")[1]
DEFINE CELL NAME "cAI"      OF oSection1 ALIAS "" SIZE 03 TITLE STR0014//"A/I" 
DEFINE CELL NAME "cST"      OF oSection1 ALIAS "" SIZE 03 TITLE STR0015//"ST"

DEFINE SECTION oSection2 OF oSection1 TABLES "QEK" TITLE STR0038 //Ultimas Entradas 
DEFINE CELL NAME "cUltEnt"   OF oSection2 ALIAS "" SIZE 20						TITLE STR0017		//"Ultimas Entradas"
DEFINE CELL NAME "cDTENTR"   OF oSection2 ALIAS "" SIZE TAMSX3("QEK_DTENTR")[1]	TITLE STR0018		//"Data Entrada"
DEFINE CELL NAME "cLOTE"     OF oSection2 ALIAS "" SIZE TAMSX3("QEK_LOTE")[1]	TITLE STR0019		//"Lote"
DEFINE CELL NAME "cSkipLote" OF oSection2 ALIAS "" SIZE TAMSX3("QEK_VERIFI")[1]	TITLE STR0020		//"Skip-Lote"
DEFINE CELL NAME "cLaudo"    OF oSection2 ALIAS "" SIZE TAMSX3("QED_DESCPO")[1]	TITLE STR0021		//"Laudo"
DEFINE CELL NAME "cDOCENT"   OF oSection2 ALIAS "" SIZE TAMSX3("QEK_DOCENT")[1]	TITLE FwX3Titulo("QEK_DOCENT")		//"Lote Fornec"

Return oReport


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 04/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Ficha de Produto sem Entradas                			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER320                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±                    
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport)
Local oTempTable:= NIL
Local oSection0 := oReport:Section(1)
Local oSection1 := oReport:Section(2)
Local oSection2 := oReport:Section(2):Section(1)
Local cProd    := mv_par03
Local cRevi    := " "
Local cFor     := mv_par01
Local cLojFor  := mv_par02
Local cLaborat := " "
Local cDescLab := " "
Local nCont    := 0
Local cSkipLote:= " "
Local cLaudo   := " "
Local aEntrada := {}
Local aEnsaios := {}
Local aLabEns  := {}
Local cChave   := " "
Local cEspeci  := " "
Local aCampos  := {}
Local cUM      := " " 
Local nX
Local nC
Local nColEns
Local cCabec  := ""
Local nPag    := 0
Local cDescPrd := ""
Local cQEGNivel:= ""

If __LANGUAGE == "PORTUGUESE"
	cQEGNivel := Space(TamSx3("QEG_NIVEL")[1])
ElseIf __LANGUAGE == "SPANISH"
	cQEGNivel := Space(TamSx3("QEG_NIVESP")[1])
ElseIf __LANGUAGE == "ENGLISH"
	cQEGNivel := Space(TamSx3("QEG_NIVING")[1])
Endif

//Numero de linhas padrao para Impressao das colunas de medicoes
mv_par07 := If(mv_par07==0,1,mv_par07)

DbSelectArea("QE6")
DbSetOrder(1)
DbSeek(xFilial("QE6")+cProd)
IF !Found()
	Set Device to Screen
	Help(" ",1,"QE_NAOPRRV",,cProd+" / "+cRevi,2,1) // "Produto/Revisao nao cadastrados:
	Return .F.
EndIf
cRevi:= QE6->QE6_REVI
dbSelectArea("QE7")
dbSetOrder(1)
dbSeek(xFilial("QE7")+cProd+cRevi)
dbSelectArea("QE8")
dbSetOrder(1)
dbSeek(xFilial("QE8")+cProd+cRevi)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo de Trabalho. 									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("QEK_PRODUT")
AADD(aCampos,{"PRODUTO","C",aTam[1],aTam[2]})
aTam:=TamSX3("QEK_REVI")
AADD(aCampos,{"REVI",   "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_ENSAIO")
AADD(aCampos,{"ENSAIO", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_METODO")
AADD(aCampos,{"METODO", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_TIPO")
AADD(aCampos,{"TIPO",   "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_UNIMED")
AADD(aCampos,{"UNIMED", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_NOMINA")
AADD(aCampos,{"NOMINA", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_LIE")
AADD(aCampos,{"LIE", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_LSE")
AADD(aCampos,{"LSE","C",aTam[1],aTam[2]})
aTam:=TamSX3("QF4_PLAMO")
AADD(aCampos,{"PLAMO",  "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_NIVEL")
AADD(aCampos,{"NIVEL", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_AM_INS")
AADD(aCampos,{"AM_INS", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_LABOR")
AADD(aCampos,{"LABOR",  "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_SEQLAB")
AADD(aCampos,{"SEQLAB", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE7_MINMAX")
AADD(aCampos,{"MINMAX", "C",aTam[1],aTam[2]})
aTam:=TamSX3("QE8_TEXTO")
AADD(aCampos,{"TEXTO",  "C",aTam[1],aTam[2]})
aTam:=TamSX3("QEK_VERIFI")
AADD(aCampos,{"Ok","C",aTam[1],aTam[2]})

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"LABOR","SEQLAB"} )
oTempTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Funcao para gerar arquivo de Trabalho			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GeraTrab(cProd,cRevi,.T.,oReport)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Identifica o Grupo do Produto								   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QEA->(dbSetOrder(2))
QEA->(dbSeek(xFilial("QEA")+cProd))
cGrupo := QEA->QEA_GRUPO
QEA->(dbSetOrder(1))

dbSelectArea("TRB")
If BOF() .and. EOF()
	HELP(" ",1,"RECNO")
	oTempTable:Delete()
	Return(.F.)
Endif
TRB->(dbGoTop())

While TRB->(!EOF())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Flag Verifica se j  foi impresso o laboratorio 				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->OK == "S"
		dbSelectArea("TRB")
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Laboratorio    									  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If	!Empty(mv_par04) .And. TRB->LABOR < mv_par04 .or.;
		!Empty(mv_par05) .And. TRB->LABOR > mv_par05
		dbSelectArea("TRB")
		dbSkip()
		Loop                   
	EndIf	

	If TRB->LABOR != cLaborat
		cLaborat := TRB->LABOR
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Descricao do Laboratorio									  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(TRB->LABOR)
		cDescLab := Tabela("Q2",TRB->LABOR)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ ARMAZENA NO ARRAY AS ULTIMAS ENTRADAS 				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QEK")
	dbSetOrder(2) 
	If QEK->(DbSeek(xFilial("QEK")+cFor+cLojFor+cProd))
		nCont   := 0
		While QEK->QEK_FILIAL+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT == ;
			  xFilial("QEK")+cFor+cLojFor+cProd .and. nCont < 4
			
			cSkipLote := If (QEK->QEK_VERIFI <> 2 , OemToAnsi(STR0007),OemToAnsi(STR0006)) //"NAO"###"SIM"
	
			dbSelectArea("QEL")
			QEL->(dbSetOrder(1))
			If QEL->(dbSeek(xFilial("QEL")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+Space(TamSX3("QEL_LABOR")[1])))
				QED->(dbSetOrder(1))
				QED->(dbSeek(xFilial("QED")+QEL->QEL_LAUDO))
				cLaudo := QED->QED_DESCPO
			Else
				cLaudo := Space(TamSX3("QED_DESCPO")[1])
			EndIf
			
			dbSelectArea("QEK")
			AADD(aEntrada,{QEK->QEK_DTENTR,QEK->QEK_LOTE,Upper(cSkipLote),cLaudo,QEK->QEK_DOCENT})
			nCont++
	
			QEK->(dbSkip())
		Enddo
	EndIf    

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Dados dos ensaios 						   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aEnsaios := {}
	aLabEns  := {}
	dbSelectArea("TRB")
	nRecTRB := Recno()
	While !EOF() .and. cLaborat == TRB->LABOR

		cSkTes := "N/A"   // indica que nao foi definido	

		RecLock("TRB",.F.)
		TRB->OK	 := "S"
		MsUnLock()
		dbSelectArea("QE1")
		dbSetOrder(1)
		IF dbSeek(xFilial("QE1")+TRB->ENSAIO)
			cDescEns := Substr(QE1_DESCPO,1,30)
			cTipoEns := QE1_CARTA
		Endif
		
		dbSelectArea("TRB")
		AADD(aEnsaios,{ENSAIO,cTipoEns})

		If cTipoEns <> "TXT"
			SAH->(dbSetOrder(1))
			If SAH->(dbSeek(xFilial("SAH")+TRB->UNIMED))
				cUM := SAH->AH_UMRES
			Else
				cUM := " "
			EndIf
		EndIf       

		If (AM_INS == "1")
			cAmIns := "AMO"
		ElseIf (AM_INS == "2")
			cAmIns := "INS"
		ElseIf (AM_INS == "3")
			cAmIns := "A/I"
		Else 
			cAmIns := " "
		EndIf	
		
		Aadd(aLabEns,{ENSAIO+" "+cDescEns,SubStr(METODO,1,13),TIPO,cTipoEns,cUM,NOMINA,;
			MINMAX,LIE,LSE,	Left(TEXTO,34),Subs(TEXTO,35,34),Subs(TEXTO,69),;
			PLAMO,NIVEL,cAmIns,	cSkTes})
		
		dbSelectArea("TRB")
		dbSkip()
		
	Enddo
	dbGoTo(nRecTRB)                             

	If Len(aLabEns) == 0
		TRB->(dbSkip())
		Loop
	EndIf

	If nPag > 0
		oSection0:SetPageBreak(.T.) 
		oSection0:Finish()
	Endif
	oSection0:Init()
	oSection0:PrintLine()
		
	oReport:PrintText(AllTrim(TitSX3("QE6_PRODUT")[1])+" - "+AllTrim(TitSX3("QE6_REVI")[1])+Replicate(".",38-(len(Alltrim(TitSx3("QE6_PRODUT")[1]))+len(Alltrim(TitSx3("QE6_REVI")[1]))))+":"+QE6->QE6_PRODUT + " - " + QE6->QE6_REVI,oReport:Row(),025) 
	oReport:SkipLine(1)	
	
	If __LANGUAGE == "PORTUGUESE"
		cDescPrd := "QE6_DESCPO"
	ElseIf __LANGUAGE == "SPANISH"
		cDescPrd := "QE6_DESCES"	
	ElseIf __LANGUAGE == "ENGLISH"
		cDescPrd := "QE6_DESCIN"
	Endif

	oReport:PrintText(AllTrim(TitSX3(cDescPrd)[1])+REPLICATE(".",41-Len(AllTrim(TitSX3(cDescPrd)[1])))+":"+QE6->&(cDescPrd),oReport:Row(),025) 
	oReport:SkipLine(1)	

	oReport:PrintText(AllTrim(TitSX3("QE6_APLIC")[1])+REPLICATE(".",41-Len(AllTrim(TitSX3("QE6_APLIC")[1])))+":"+QE6->QE6_APLIC,oReport:Row(),025) 
	oReport:SkipLine(1)	

	oReport:PrintText(AllTrim(TitSX3("QE6_CROQUI")[1])+REPLICATE(".",41-Len(AllTrim(TitSX3("QE6_CROQUI")[1])))+":"+QE6->QE6_CROQUI,oReport:Row(),025) 
	oReport:SkipLine(1)	

	oReport:PrintText(AllTrim(TitSX3("QE6_DTCAD")[1])+"/"+AllTrim(TitSX3("QE6_DTDES")[1])+"/"+AllTrim(TitSX3("QE6_RVDES")[1])+"...:"+Dtoc(QE6->QE6_DTCAD) +"  "+Dtoc(QE6->QE6_DTDES)+"  "+QE6->QE6_RVDES,oReport:Row(),025) 
	oReport:SkipLine(1)	

	oReport:PrintText(AllTrim(TitSX3("QE6_DTINI")[1])+REPLICATE(".",41-Len(AllTrim(TitSX3("QE6_DTINI")[1])))+":"+Dtoc(QE6->QE6_DTINI),oReport:Row(),025) 
	oReport:SkipLine(1)	

	If !Empty(QE6->QE6_DOCOBR)
		cCabec := AllTrim(TitSX3("QE6_DOCOBR")[1])+REPLICATE(".",41-Len(AllTrim(TitSX3("QE6_DOCOBR")[1])))+":"

		If(QE6->QE6_DOCOBR=="S")
			cCabec:= cCabec + OemToAnsi(STR0006) //"Sim"
		Else
			cCabec:= cCabec + OemToAnsi(STR0007)//"Nao"
		Endif
		
		oReport:PrintText(cCabec,oReport:Row(),025) 
		oReport:SkipLine(1)	
	EndIf

	//Descricao do Laboratorio 
	oReport:SkipLine(1)
	oReport:PrintText(OemToAnsi(STR0008) + TRB->LABOR + " - " + cDescLab,oReport:Row(),025) //"LABORATORIO ==> "
	oReport:SkipLine(2)	

	oSection1:Init()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os Ensaios associados ao Laboratorio				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 to Len(aLabEns)
	
		oSection1:CELL("cENSAIO"):SetValue(aLabEns[nX,1])//00
		oSection1:CELL("cMETODO"):SetValue(aLabEns[nX,2])//40
		oSection1:CELL("cTIPO"):SetValue(aLabEns[nX,3])  //53

		If aLabEns[nX,4] <> "TXT"
	
			oSection1:CELL("cUM"):SetValue(aLabEns[nX,5]) //70
            oSection1:CELL("cNominal"):SetValue(aLabEns[nX,6])//80
			oSection1:CELL("cNominal"):Show()
						
			If aLabEns[nX,7] == "1"
				oSection1:CELL("cLIE"):SetValue(AllTrim(aLabEns[nX,8]))
				oSection1:CELL("cLSE"):SetValue(AllTrim(aLabEns[nX,9]))
			ElseIf aLabEns[nX,7] == "2"	
				oSection1:CELL("cLIE"):SetValue(AllTrim(aLabEns[nX,8]))
				oSection1:CELL("cLSE"):SetValue(">>>")
			ElseIf aLabEns[nX,7] == "3"
				oSection1:CELL("cLIE"):SetValue("<<<")
				oSection1:CELL("cLSE"):SetValue(AllTrim(aLabEns[nX,9]))
			EndIf    			
		Else 
			oSection1:CELL("cUM"):SetValue(AllTrim(aLabEns[nX,10]+aLabEns[nX,11]+aLabEns[nX,12]))
			oSection1:CELL("cNominal"):Hide()
			oSection1:CELL("cLIE"):SetValue(AllTrim(aLabEns[nX,8]))
			oSection1:CELL("cLSE"):SetValue(AllTrim(aLabEns[nX,9]))
		
		EndIf			
	
		If !Empty(aLabEns[nX,14])
			oSection1:CELL("cNIVEL"):SetValue(Substr(TABELA("Q6",aLabEns[nX,14]),1,10))		
		else
			oSection1:CELL("cNIVEL"):SetValue("")
		Endif
	
		oSection1:CELL("cAI"):SetValue(aLabEns[nX,15])		
		oSection1:CELL("cST"):SetValue(aLabEns[nX,16])		
		oSection1:PrintLine()	

	Next nX
	oSection1:Finish()

	//Ultimas Entradas   
	If Len(aEntrada) > 0 
	 
		oReport:SkipLine(1)
		oSection2:Init()        
		
		For nC:= 1 to Len(aEntrada)
			oSection2:CELL("cUltEnt"):SetValue("")
			oSection2:CELL("cDTENTR"):SetValue(aEntrada[nC,1])
			oSection2:CELL("cLOTE"):SetValue(aEntrada[nC,2])
			oSection2:CELL("cSkipLote"):SetValue(aEntrada[nC,3])
			oSection2:CELL("cLaudo"):SetValue(aEntrada[nC,4])
			oSection2:CELL("cDOCENT"):SetValue(aEntrada[nC,5]) 
			oSection2:PrintLine()
		Next nC 

		aEntrada:={}

	Endif
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Posiciona em registros de outros Arquivos p/dados Fornecedor  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SA5")
	dbSetOrder(2)
	dbSeek(xFilial("SA5")+cProd+cFor+cLojFor)
	dbSelectArea("QEG")
	dbSetOrder(1)
	If dbSeek(xFilial("QEG")+SA5->A5_SITU)
		cQEGNivel := QaxIdioma("QEG_NIVEL","QEG_NIVING","QEG_NIVESP")
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Dados do Fornecedor/Cliente           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(mv_par06 == 2 .Or. mv_par06 == 3)	
		dbSelectArea("SA2")
		dbSetOrder(1)
		dbSeek(xFilial("SA2")+cFor+cLojFor)
	    oReport:SkipLine(1)
	    cForn := AllTrim(TitSX3("QEK_FORNEC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_FORNEC")[1])))+":"+cFor+"/"+cLojFor+" - "+SA2->A2_NREDUZ+"   ("+cQEGNivel+")" 
		oReport:PrintText(cForn,oReport:Row(),025) 
		oReport:SkipLine(1)	
	Else
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+cFor+cLojFor)
		oReport:SkipLine(1)
		cForn :=AllTrim(TitSX3("A7_CLIENTE")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A7_CLIENTE")[1])))+":"+cFor+"/"+cLojFor+" - "+SA1->A1_NREDUZ+"   ("+cQEGNivel+")"		
		oReport:PrintText(cForn,oReport:Row(),025) 
		oReport:SkipLine(1)	
	EndIf
    
	oReport:PrintText(AllTrim(TitSX3("A5_CODPRF")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A5_CODPRF")[1])))+":"+SA5->A5_CODPRF,oReport:Row(),025) 
	oReport:SkipLine(1)	

	oReport:PrintText(AllTrim(TitSX3("QEK_LOTE")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_LOTE")[1])))+":",oReport:Row(),025) 

	oReport:PrintText(AllTrim(TitSX3("QEK_NTFISC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_NTFISC")[1])))+":",oReport:Row(),1000) 
	oReport:SkipLine(1)	

	oReport:PrintText(AllTrim(TitSX3("QEK_TAMLOT")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_TAMLOT")[1])))+":",oReport:Row(),025) 

	oReport:PrintText(AllTrim(TitSX3("QEK_DTNFIS")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_DTNFIS")[1])))+":",oReport:Row(),1000) 
	oReport:SkipLine(1)	

	oReport:PrintText(AllTrim(TitSX3("QEK_DTENTR")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_DTENTR")[1])))+":",oReport:Row(),025) 

	oReport:PrintText(AllTrim(TitSX3("QEK_PEDIDO")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_PEDIDO")[1])))+":",oReport:Row(),1000) 
	oReport:SkipLine(1)	

	oReport:PrintText(AllTrim(FwX3Titulo("QEK_DOCENT"))+Replicate(".",23-Len(AllTrim(FwX3Titulo("QEK_DOCENT"))))+":",oReport:Row(),025) 

	oReport:PrintText(AllTrim(TitSX3("QEK_CERFOR")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_CERFOR")[1])))+":",oReport:Row(),1000) 
	oReport:SkipLine(1)	

	oReport:PrintText(OemToAnsi(STR0023),oReport:Row(),025) 
	oReport:SkipLine(1)	
		
	oReport:PrintText(AllTrim(TitSX3("QER_RASTRE")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QER_RASTRE")[1])))+":  __________________",oReport:Row(),025) 
 
	oReport:PrintText(AllTrim(TitSX3("QEL_DTENLA")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEL_DTENLA")[1])))+":  __________________",oReport:Row(),1000) 
	oReport:SkipLine(2)	

	oReport:PrintText("|---------------------------------------------------------------------------------------------------------------------------------|",oReport:Row(),025) 
	oReport:SkipLine(1) 
	oReport:PrintText("|                | "+Left(TitSX3("QET_INSTR")[1],9)+"  |"+OemToAnsi(STR0024)+"|"+OemToAnsi(STR0025)+"|",oReport:Row(),025)//"     Ensaiador     "###"                                     M E D I C O E S                           "
	oReport:SkipLine(1) 
	oReport:PrintText("|----------------+------------+-------------------+---------------+---------------+---------------+---------------+---------------|",oReport:Row(),025)
	oReport:SkipLine(1)	

	For nCont := 1 to Len(aEnsaios)

		//Imprime n linhas p/ as medicoes       
		For nColEns := 1 to mv_par07		
	
			If aEnsaios[nCont,2] <> "TXT"
				oReport:PrintText( "| " + aEnsaios[nCont,1] + "       |            |                   |               |               |               |               |               |",oReport:Row(),025) 
				oReport:SkipLine(1)	
				oReport:PrintText("|----------------+------------+-------------------+---------------+---------------+---------------+---------------+---------------|",oReport:Row(),025) 
				oReport:SkipLine(1)	
			Else
				oReport:PrintText("| " + aEnsaios[nCont,1] + "       |            |                   |                                                                               |",oReport:Row(),025) 
				oReport:SkipLine(1)	
				oReport:PrintText("|---------------------------------------------------------------------------------------------------------------------------------|",oReport:Row(),025) 
				oReport:SkipLine(1)	
			EndIf
	
		Next nColEns
		
	Next nCont

	oReport:SkipLine(1)	
	oReport:PrintText( OemToAnsi(STR0026)+"________________________",oReport:Row(),025)       //"Laudo : "
	oReport:SkipLine(1)	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Converte a chave passada como param. p/ chave do texto		 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cChave := QE6->QE6_CHAVE
	cEspeci:= "QIEA010 "
	dbSelectArea("QA2")
	QA2->(dbSetOrder(1))
	dbSeek(xFilial("QA2")+cEspeci+cChave)
	Do While !EOF() .and. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE ==;
		xFilial("QA2")+cEspeci+cChave
		oReport:SkipLine(1)	
		oReport:PrintText(StrTran(QA2_TEXTO, "\13\10", ""),oReport:Row(),025) 
		dbSkip()
	Enddo
	
	dbSelectArea("TRB")
	dbSkip()

	oSection2:Finish()	
	nPag += 1
EndDo

oTempTable:Delete()

Return (.T.)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³GeraTrab	³ Autor ³ Eduardo de Souza      ³ Data ³ 12/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo de Trabalho 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ GeraTrab()												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static FuncTion GeraTrab(cProd,cRevi,lR4,oReport)

Local cCondR4 			:= ""
Local aAreaQE7			:= QE7->(GetArea())
Local aAreaQE8			:= QE8->(GetArea())
Default lR4  			:= .F.
Default oReport			:= Nil

If lR4
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QE7")))
		cCondR4 += oReport:Section(1):GetAdvplExp("QE7") 
	EndIf
EndIf

dbSelectArea("QE7")
QE7->(dbSetOrder(1))
QE7->(dbGoTop())

If lR4
	If !Empty(cCondR4)
		While QE7->(!Eof()) 
			If xFilial("QE7") == QE7->QE7_FILIAL .And. Alltrim(QE7->QE7_PRODUT)+Alltrim(QE7->QE7_REVI) == Alltrim(cProd)+Alltrim(cRevi) .AND. QE7->(&(cCondR4))
				RecLock("TRB",.T.)
				TRB->PRODUTO	:= cProd
				TRB->REVI		:= cRevi
				TRB->ENSAIO 	:= QE7->QE7_ENSAIO
				TRB->METODO 	:= QE7->QE7_METODO
				TRB->TIPO		:= QE7->QE7_TIPO
				TRB->UNIMED 	:= QE7->QE7_UNIMED
				TRB->NOMINA 	:= QE7->QE7_NOMINA
				TRB->LIE 		:= QE7->QE7_LIE
				TRB->LSE 		:= QE7->QE7_LSE
				TRB->PLAMO		:= QE7->QE7_PLAMO
				TRB->NIVEL  	:= QE7->QE7_NIVEL
				TRB->AM_INS 	:= QE7->QE7_AM_INS
				TRB->LABOR		:= QE7->QE7_LABOR
				TRB->SEQLAB 	:= QE7->QE7_SEQLAB
				TRB->MINMAX 	:= QE7->QE7_MINMAX
				MsUnlock()
			Endif
			QE7->(DbSkip())
		Enddo
	Else
		While QE7->(!Eof()) 
			If xFilial("QE7") == QE7->QE7_FILIAL .And. Alltrim(QE7->QE7_PRODUT)+Alltrim(QE7->QE7_REVI) == Alltrim(cProd)+Alltrim(cRevi) 
				RecLock("TRB",.T.)
				TRB->PRODUTO	:= cProd
				TRB->REVI		:= cRevi
				TRB->ENSAIO 	:= QE7->QE7_ENSAIO
				TRB->METODO 	:= QE7->QE7_METODO
				TRB->TIPO		:= QE7->QE7_TIPO
				TRB->UNIMED 	:= QE7->QE7_UNIMED
				TRB->NOMINA 	:= QE7->QE7_NOMINA
				TRB->LIE 		:= QE7->QE7_LIE
				TRB->LSE 		:= QE7->QE7_LSE
				TRB->PLAMO		:= QE7->QE7_PLAMO
				TRB->NIVEL  	:= QE7->QE7_NIVEL
				TRB->AM_INS 	:= QE7->QE7_AM_INS
				TRB->LABOR		:= QE7->QE7_LABOR
				TRB->SEQLAB 	:= QE7->QE7_SEQLAB
				TRB->MINMAX 	:= QE7->QE7_MINMAX
				MsUnlock()
			Endif
			QE7->(DbSkip())
		Enddo
	Endif
Else
	While QE7->(!Eof()) 
		If xFilial("QE7") == QE7->QE7_FILIAL .And. Alltrim(QE7->QE7_PRODUT)+Alltrim(QE7->QE7_REVI) == Alltrim(cProd)+Alltrim(cRevi) 
			RecLock("TRB",.T.)
			TRB->PRODUTO	:= cProd
			TRB->REVI		:= cRevi
			TRB->ENSAIO 	:= QE7->QE7_ENSAIO
			TRB->METODO 	:= QE7->QE7_METODO
			TRB->TIPO		:= QE7->QE7_TIPO
			TRB->UNIMED 	:= QE7->QE7_UNIMED
			TRB->NOMINA 	:= QE7->QE7_NOMINA
			TRB->LIE 		:= QE7->QE7_LIE
			TRB->LSE 		:= QE7->QE7_LSE
			TRB->PLAMO		:= QE7->QE7_PLAMO
			TRB->NIVEL  	:= QE7->QE7_NIVEL
			TRB->AM_INS 	:= QE7->QE7_AM_INS
			TRB->LABOR		:= QE7->QE7_LABOR
			TRB->SEQLAB 	:= QE7->QE7_SEQLAB
			TRB->MINMAX 	:= QE7->QE7_MINMAX
			MsUnlock()
		Endif		
		QE7->(DbSkip())
	Enddo
Endif
		
If lR4
	cCondR4 := ""
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QE8")))
		cCondR4 += oReport:Section(1):GetAdvplExp("QE8") 
	EndIf
EndIf

dbSelectArea("QE8")
QE8->(dbSetOrder(1))
QE8->(dbGoTop())

If lR4
	If !Empty(cCondR4)
		While QE8->(!Eof()) 
			If xFilial("QE8") == QE8->QE8_FILIAL .And. Alltrim(QE8->QE8_PRODUT)+Alltrim(QE8->QE8_REVI) == Alltrim(cProd)+Alltrim(cRevi) .AND. QE8->(&(cCondR4))
				RecLock("TRB",.T.)
				TRB->PRODUTO := cProd
				TRB->REVI    := cRevi
				TRB->ENSAIO  := QE8->QE8_ENSAIO
				TRB->METODO  := QE8->QE8_METODO
				TRB->TIPO    := QE8->QE8_TIPO
				TRB->TEXTO   := QE8->QE8_TEXTO
				TRB->PLAMO   := QE8->QE8_PLAMO
				TRB->NIVEL   := QE8->QE8_NIVEL
				TRB->AM_INS  := QE8->QE8_AM_INS
				TRB->LABOR   := QE8->QE8_LABOR
				TRB->SEQLAB  := QE8->QE8_SEQLAB
				MsUnlock()
			Endif
			QE8->(DbSkip())
		Enddo
	Else
		While QE8->(!Eof()) 
			If xFilial("QE8") == QE8->QE8_FILIAL .And. Alltrim(QE8->QE8_PRODUT)+Alltrim(QE8->QE8_REVI) == Alltrim(cProd)+Alltrim(cRevi) 
				RecLock("TRB",.T.)
				TRB->PRODUTO := cProd
				TRB->REVI    := cRevi
				TRB->ENSAIO  := QE8->QE8_ENSAIO
				TRB->METODO  := QE8->QE8_METODO
				TRB->TIPO    := QE8->QE8_TIPO
				TRB->TEXTO   := QE8->QE8_TEXTO
				TRB->PLAMO   := QE8->QE8_PLAMO
				TRB->NIVEL   := QE8->QE8_NIVEL
				TRB->AM_INS  := QE8->QE8_AM_INS
				TRB->LABOR   := QE8->QE8_LABOR
				TRB->SEQLAB  := QE8->QE8_SEQLAB
				MsUnlock()
			Endif
			QE8->(DbSkip())
		Enddo
	Endif
Else
	While QE8->(!Eof()) 
		If xFilial("QE8") == QE8->QE8_FILIAL .And. Alltrim(QE8->QE8_PRODUT)+Alltrim(QE8->QE8_REVI) == Alltrim(cProd)+Alltrim(cRevi)
			RecLock("TRB",.T.)
			TRB->PRODUTO := cProd
			TRB->REVI    := cRevi
			TRB->ENSAIO  := QE8->QE8_ENSAIO
			TRB->METODO  := QE8->QE8_METODO
			TRB->TIPO    := QE8->QE8_TIPO
			TRB->TEXTO   := QE8->QE8_TEXTO
			TRB->PLAMO   := QE8->QE8_PLAMO
			TRB->NIVEL   := QE8->QE8_NIVEL
			TRB->AM_INS  := QE8->QE8_AM_INS
			TRB->LABOR   := QE8->QE8_LABOR
			TRB->SEQLAB  := QE8->QE8_SEQLAB
			MsUnlock()
		Endif
		QE8->(DbSkip())
	Enddo
Endif
		
RestArea(aAreaQE7)
RestArea(aAreaQE8)
		
Return .T.
