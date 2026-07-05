/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "QADR060.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOTVS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QADR060   ºAutor  ³Leandro Sabino      º Data ³  14/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Encerramento da Auditoria 					              º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAQAD	                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QADR060()
Local oReport
Private cPerg   := "QAR060    "
Private cChkIni := ""
Private cChkFim := ""
Private cRevIni := ""
Private cRevFim := ""
Private cTopIni := ""
Private cTopFim := ""

Pergunte(cPerg,.F.) 
oReport := ReportDef()
oReport:PrintDialog()
  
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 14/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR060                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local aUsrMat   := QA_USUARIO()
Local cAudAtual := QAA->QAA_NOME
Local cDesc1    := STR0001 //"Este relatorio tem o objetivo de imprimir uma ou mais auditorias"
Local cDesc2    := STR0002 //"com a descricao das perguntas e espaco para digitacao de notas e evidencias."
Local cMatCod   := aUsrMat[3]
Local cMatFil   := aUsrMat[2]
Local cTitulo   := STR0003 //'Listagem de Check List' 
Local lSoLider  := GetMv("MV_AUDSLID", .T., .F.) // Somente para usuarios diferentes do administrador
Local oSection1 := Nil

DEFINE REPORT oReport NAME "QADR060" 	TITLE cTitulo PARAMETER "QAR060" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)
DEFINE SECTION oSection1  OF oReport   	TITLE cTitulo 							 TABLES "QUB","QUH" LINE STYLE
DEFINE SECTION oSection2a OF oSection1 	TITLE STR0017				   			 TABLES "QU2"       LINE STYLE //"Check List"
DEFINE SECTION oSection2b OF oSection1 	TITLE STR0018 							 TABLES "QU3"       LINE STYLE //"Topico"
DEFINE SECTION oSection3  OF oSection2b TITLE STR0019 				  			 TABLES "QUD","QU4"            //"Questoes"
DEFINE SECTION oSection4  OF oSection3 	TITLE STR0020				 			 TABLES "QU4"                  //"Observacao da Questao" 
DEFINE SECTION oSection5  OF oSection4 	TITLE STR0021 						 	 TABLES "QUD"                  //"Evidencia"
DEFINE SECTION oSection6  OF oReport 	TITLE STR0022 				 			 TABLES "QUG"                  //"Nao-Conformidades" 
DEFINE SECTION oSection7  OF oReport 	TITLE STR0023 							 TABLES "QUB"                  //"Sugestao/Observacao da Auditoria"
DEFINE SECTION oSection8  OF oReport	TITLE STR0024			 			 	 TABLES "QUB"                  //"Conclusao da Auditoria"

//Cabecalho-Auditoria
DEFINE CELL NAME "QUB_NUMAUD" 	OF oSection1 ALIAS "QUB" TITLE TitSX3("QUB_NUMAUD")[1] ;  
			SIZE 18 BLOCK {||QUB->QUB_NUMAUD +IIf(lSoLider .And. Empty(QUB->QUB_ENCREA) .And. QUB->QUB_FILMAT + QUB->QUB_AUDLID <> cMatFil + cMatCod,STR0012 + cMatCod + " - " + cAudAtual,"")} CELL BREAK

DEFINE CELL NAME "QUH_CCUSTO" 	OF oSection1 ALIAS "QUH" TITLE TitSX3("QUH_CCUSTO")[1]  SIZE   50	BLOCK {|| IIF(QAD->(dbSeek(xFilial("QAD")+QUH->QUH_CCUSTO)), AllTrim(QUH->QUH_CCUSTO)+ " - " + QAD->QAD_DESC, AllTrim(QUH->QUH_CCUSTO))} 	CELL BREAK
DEFINE CELL NAME "QUH_DESTIN" 	OF oSection1 ALIAS "QUH" TITLE TitSX3("QUH_DESTIN")[1]  			BLOCK {|| QUH->QUH_DESTIN} 									 	CELL BREAK

DEFINE CELL NAME "QUH_DTIN" OF oSection1 ALIAS "QUH" TITLE TitSX3("QUH_DTIN")[1]  			BLOCK {|| QUH->QUH_DTIN} 									 	CELL BREAK
DEFINE CELL NAME "QUH_HRIN" OF oSection1 ALIAS "QUH" TITLE TitSX3("QUH_HRIN")[1]  			BLOCK {|| QUH->QUH_HRIN} 									 	CELL BREAK
DEFINE CELL NAME "QUH_DTFI" OF oSection1 ALIAS "QUH" TITLE TitSX3("QUH_DTFI")[1]  			BLOCK {|| QUH->QUH_DTFI} 									 	CELL BREAK
DEFINE CELL NAME "QUH_HRFI" OF oSection1 ALIAS "QUH" TITLE TitSX3("QUH_HRFI")[1]  			BLOCK {|| QUH->QUH_HRFI} 									 	CELL BREAK

DEFINE CELL NAME "QUB_NOMAUD" 	OF oSection1 ALIAS "QUB" TITLE TitSX3("QUB_NOMAUD")[1]  SIZE   40	BLOCK {|| QAA->QAA_NOME} 									 	CELL BREAK
DEFINE CELL NAME "QUB_MOTAUD" 	OF oSection1 ALIAS "QUB" TITLE TitSX3("QUB_MOTAUD")[1]  SIZE   40	BLOCK {|| Posicione("SX5", 1, xFilial("SX5") + Left(CpoRetF3("QUB_MOTAUD", "QE"), 2) + QUB->QUB_MOTAUD, "X5DESCRI()")}  CELL BREAK
DEFINE CELL NAME "QUB_TIPAUD" 	OF oSection1 ALIAS "QUB" TITLE TitSX3("QUB_TIPAUD")[1]  			BLOCK {|| QADCBox("QUB_TIPAUD", QUB->QUB_TIPAUD)} 				CELL BREAK
If mv_par15 = 1
	DEFINE CELL NAME "CPONOBT" 	OF oSection1 			 TITLE TitSX3("QUB_PONOBT")[1] 	 SIZE   10	BLOCK {|| AllTrim(Transform(QUB->QUB_PONOBT, PesqPict("QUB", "QUB_PONOBT")))} 						CELL BREAK HEADER ALIGN LEFT 
Endif

DEFINE CELL NAME "cFOR" 		OF oSection1    		 TITLE TitSX3("QUB_CODFOR")[1] 	 SIZE   40

//Cabecalho-Check List 
DEFINE CELL NAME "QU2_CHKLST" 	OF oSection2a ALIAS "QU2" TITLE TitSX3("QU2_CHKLST")[1]  SIZE 20
DEFINE CELL NAME "QU2_REVIS" 	OF oSection2a ALIAS "QU2" CELL BREAK
DEFINE CELL NAME "QU2_DESCRI" 	OF oSection2a ALIAS "QU2" CELL BREAK
		
//Cabecalho	-Topico
DEFINE CELL NAME "QU3_CHKITE" 	OF oSection2b ALIAS "QU3" CELL BREAK
DEFINE CELL NAME "QU3_NORMA"  	OF oSection2b ALIAS "QU3" CELL BREAK
DEFINE CELL NAME "QU3_DESCRI" 	OF oSection2b ALIAS "QU3" CELL BREAK

//Regua-Questoes
DEFINE CELL NAME "QUD_QSTITE" 	OF oSection3 ALIAS "QUD"
DEFINE CELL NAME "cTXTCHV"    	OF oSection3 ALIAS "QU4" TITLE STR0016  SIZE 80 LINE BREAK  //"Descricao"

DEFINE CELL NAME "cFaixINI"  	OF oSection3 ALIAS "QU4" TITLE TitSX3("QU4_FAIXIN")[1]  SIZE 05 
DEFINE CELL NAME "cFaixFIN"  	OF oSection3 ALIAS "QU4" TITLE TitSX3("QU4_FAIXFI")[1]  SIZE 05 

DEFINE CELL NAME "cNOTA"      	OF oSection3 ALIAS "QUD" TITLE TitSX3("QUD_NOTA")[1]    SIZE 10 
DEFINE CELL NAME "QUD_APLICA" 	OF oSection3 ALIAS "QUD" TITLE TitSX3("QUD_APLICA")[1]  SIZE 18 BLOCK {|| QA_CBox("QUD_APLICA",If(Empty(QUD->QUD_APLICA),"1",QUD->QUD_APLICA))}
                                
//Observacao da Questao
DEFINE CELL NAME "cOBSCHV"    	OF oSection4 ALIAS "QU4" TITLE OemToAnsi(STR0014) SIZE 120 LINE BREAK //"Observacao da Questao:"

//Evidencia
DEFINE CELL NAME "QUD_EVICHV"  	OF oSection5 ALIAS "QUD" TITLE OemToAnsi(STR0013) SIZE 120 LINE BREAK  BLOCK {||MSMM(QUD->QUD_EVICHV,TamSX3('QUD_EVIDE1')[1])}

//Nao-Conformidades   
DEFINE  CELL NAME "QUG_ITESEQ"  OF oSection6 ALIAS "QUG"
DEFINE  CELL NAME "QUG_CODNC"		OF oSection6 ALIAS "QUG"
DEFINE  CELL NAME "QUG_REVNC"		OF oSection6 ALIAS "QUG"
DEFINE  CELL NAME "QUG_DESCHV" 	OF oSection6 ALIAS "QUG" TITLE OemToAnsi(STR0011) SIZE 100 LINE BREAK  BLOCK {||MSMM(QUG->QUG_DESCHV,TamSX3('QUG_DESC1')[1]) }
                            
//Imprime a Sugestao/Observacao da Auditoria
DEFINE CELL NAME "QUB_SUGCHV" OF oSection7 ALIAS "QUB" TITLE OemToAnsi(STR0015)   SIZE 120 LINE BREAK  BLOCK {|| MSMM(QUB->QUB_SUGCHV,TamSX3('QUB_SUGOBS')[1])}

//Imprime a Conclusao da Auditoria                                  
DEFINE CELL NAME "QUB_CHAVE" OF oSection8 ALIAS "QUB" TITLE OemToAnsi(STR0007)    SIZE 120 LINE BREAK  BLOCK {|| MSMM(QUB->QUB_CHAVE,TamSX3('QUB_CONCLU')[1])}

Return oReport

/*/                                                                       
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 13/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±        
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR060                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
                 
Static Function PrintReport(oReport) 
Local aDesNC     := {}
Local aTxtConc   := {}
Local aUsrMat    := QA_USUARIO()
Local cAud       := ""
Local cChkIte    := ""
Local cChkLst    := ""
Local cConAud    := ""
Local cKeyCon    := ""
Local cMatCod    := aUsrMat[3]
Local cMatFil    := aUsrMat[2]
Local cNumAud    := ""
Local cSeq       := ""
Local lAltern    := .F.
Local lAud       := .F. //Controla a Impressão do Auditor
Local lCabec     := .T. //Controla a Impressão das Seções Cabeçalho
Local lChkIte    := .F.
Local lChkLst    := .F.
Local lConc      := .F. //Controla a Impressão da Conclusão
Local lFirst     := .T.
Local lImp       := .F. //Controla a Impressão da Seção 2a
Local lImpConc   := .F.
local lNumAud    := .F.
Local lObAu      := .F. //Controla a Impressão da Observação Auditoria
Local lQstZer    := GetMv("MV_QADQZER",.T.,.T.)
Local lSoLider   := GetMv("MV_AUDSLID", .T., .F.) // Somente para usuarios diferentes do administrador
Local oSection1  := oReport:Section(1)
Local oSection2a := oSection1:Section(1)
Local oSection2b := oSection1:Section(2)
Local oSection3  := oSection2b:Section(1)
Local oSection4  := oSection3:Section(1)
Local oSection5  := oSection4:Section(1)
Local oSection6  := oReport:Section(2)
Local oSection7  := oReport:Section(3)
Local oSection8  := oReport:Section(4)
Local x			 := 1


MakeAdvplExpr(oReport:uParam)

dbSelectArea("QUD")
dbSetOrder(1)
dbSeek(xFilial("QUD")+mv_par01,.T.) 

While !oReport:Cancel() .And. QUD->(!Eof()) .And. (QUD->QUD_FILIAL == xFilial("QUD")) .And.;
		QUD->QUD_NUMAUD <= mv_par02


	If mv_par16 <> 1
		If ((QUD->QUD_APLICA == " " .Or. QUD->QUD_APLICA == "1") .And. mv_par16 == 3 ) .Or. ;
		   (QUD->QUD_APLICA == "2" .And. mv_par16 == 2 )
			QUD->(dbSkip())
			Loop
		Endif
	Endif

	If QUD->QUD_CHKLST < mv_par05 .Or. QUD->QUD_CHKLST > mv_par06
		QUD->(dbSkip())
		Loop
	Endif
	
	If QUD->QUD_REVIS < mv_par07 .Or. QUD->QUD_REVIS >	mv_par08
		QUD->(dbSkip())
		Loop
	Endif
	
	If QUD->QUD_CHKITE < mv_par09 .Or. QUD->QUD_CHKITE > mv_par10
		QUD->(dbSkip())
		Loop
	Endif
	
	If QUD->QUD_QSTITE < mv_par11 .Or. QUD->QUD_QSTITE > mv_par12
		QUD->(dbSkip())
		Loop
	Endif

	QUH->(dbSeek(xFilial("QUH")+QUD->QUD_NUMAUD+QUD->QUD_SEQ))
	If 	lSoLider .And. QUB->(MsSeek(xFilial("QUB") + QUD->QUD_NUMAUD)) .And.;
		Empty(QUB->QUB_ENCREA) .And.;
		QUB->QUB_FILMAT + QUB->QUB_AUDLID # cMatFil + cMatCod .And.;
		QUH->QUH_FILMAT + QUH->QUH_CODAUD # cMatFil + cMatCod
		QUH->(dbSkip())
		Loop
	Endif

	If (QUH->QUH_CCUSTO < mv_par03) .Or. (QUH->QUH_CCUSTO > mv_par04)
		QUD->(dbSkip())
		Loop
	Endif
		
	If cAud + cSeq <> QUD->QUD_NUMAUD + QUD->QUD_SEQ
		oReport:EndPage()
		oSection1:Init()
		oSection2a:Init()    
		cAud := QUD->QUD_NUMAUD
		lCabec := .T.
		lAud   := .T.
	Endif	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se houve interrupcao pelo operador                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lFirst
		cConAud := QUD->QUD_NUMAUD
		lFirst  := .F.
	Endif

	lNumAud := (cNumAud + cSeq # QUD->QUD_NUMAUD + QUD->QUD_SEQ)	
	If lNumAud
		cNumAud := QUD->QUD_NUMAUD
		cSeq    := QUD->QUD_SEQ
	Endif

	lChkLst := (cChkLst # QUD->QUD_CHKLST)	
	If lChkLst .Or. lNumAud
		QU2->(dbSeek(xFilial("QU2") + QUD->QUD_CHKLST + QUD->QUD_REVIS))
		cChkLst := QUD->QUD_CHKLST
	Endif
	
	lChkIte := cChkIte <> QUD->QUD_CHKITE

	If cChkIte <> QUD->QUD_CHKITE .OR. lNumAud
		lImp := .T.	
		oSection2b:Init() 
		QU3->(dbSeek(xFilial("QU3") + QUD->QUD_CHKLST + QUD->QUD_REVIS + QUD->QUD_CHKITE))
		cChkIte := QUD->QUD_CHKITE
	Endif
	

	If lNumAud
		QUB->(dbSeek(xFilial("QUB")+QUD->QUD_NUMAUD))
		QAA->(dbSeek(QUH->QUH_FILMAT+QUH->QUH_CODAUD))
		QAD->(dbSeek(xFilial("QAD")+QUH->QUH_CCUSTO))
    EndIf

	If lCabec

		If !Empty(QUB->QUB_CODFOR) // Fornecedor
			DbSelectArea("SA2")
			If DbSeek(xFilial("SA2")+QUB->QUB_CODFOR)
				oSection1:Cell("cFOR"):Enable()
				oSection1:CELL("cFOR"):SetValue(Alltrim(QUB->QUB_CODFOR) + " - " + SA2->A2_NOME)
			EndIf
		Else
			oSection1:Cell("cFOR"):Disable()
		EndIf
		oSection1:Printline() 
		
		
		If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QUC")))
			If !QUC->(&(oReport:Section(1):GetAdvplExp("QUC")))   
				QUC->(dbSkip())
				Loop
			Endif
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Auditores         				             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If QUC->(DbSeek(xFilial("QUC")+QUB->QUB_NUMAUD)) .AND. lAud
			oReport:PrintText(Pad(OemToAnsi(STR0010),18)+": "+Alltrim(QUC->QUC_CODAUD)+" - "+Posicione("QAA",1,QUC->QUC_FILMAT+QUC->QUC_CODAUD,"QAA_NOME"),oReport:Row(),025)
			oReport:SkipLine(1) 
			QUC->(DbSkip())
			While QUC->(!Eof()) .And. QUC->QUC_FILIAL+QUC->QUC_NUMAUD == xFilial("QUC")+QUB->QUB_NUMAUD				
				oReport:PrintText("                    "+Alltrim(QUC->QUC_CODAUD)+" - "+Posicione("QAA",1,QUC->QUC_FILMAT+QUC->QUC_CODAUD,"QAA_NOME"),oReport:Row(),025)
				oReport:SkipLine(1)	
				QUC->(DbSkip())
			EndDo
			lAud   := .F.
		EndIf

	EndIf
	
	If Empty(QUD->QUD_TIPO) .Or. QUD->QUD_TIPO = "1"   // Questionario Padrao
		QU4->(dbSeek(xFilial("QU4") + QUD->QUD_CHKLST + QUD->QUD_REVIS + QUD->QUD_CHKITE + QUD->QUD_QSTITE))		
		oSection3:CELL("cTXTCHV"):SetValue(MsMM(QU4->QU4_TXTCHV,TamSX3('QU4_TXTQS1')[1]))
		oSection3:CELL("cFaixINI"):SetValue(AllTrim(Transform(QU4->QU4_FAIXIN, PesqPict("QU4", "QU4_FAIXIN"))))	
		oSection3:CELL("cFaixFIN"):SetValue(AllTrim(Transform(QU4->QU4_FAIXFI, PesqPict("QU4", "QU4_FAIXFI"))))
		nFaixIn := QU4->QU4_FAIXIN
		lAltern := If(QU4->QU4_USAALT=="1",.T.,.F.)	
	ElseIf QUD->QUD_TIPO = "2" // Questionario Adicional
		QUE->(dbSeek(xFilial("QUE") + QUD->QUD_NUMAUD + QUD->QUD_CHKLST + QUD->QUD_REVIS + QUD->QUD_CHKITE + QUD->QUD_QSTITE))	
		oSection3:CELL("cTXTCHV"):SetValue(MSMM(QUE->QUE_TXTCHV,TamSX3('QUE_TXTQS1')[1]))
		oSection3:CELL("cFaixINI"):SetValue(AllTrim(Transform(QUE->QUE_FAIXIN, PesqPict("QU4", "QU4_FAIXIN"))))	
		oSection3:CELL("cFaixFIN"):SetValue(AllTrim(Transform(QUE->QUE_FAIXFI, PesqPict("QU4", "QU4_FAIXFI"))))
		nFaixIn := QUE->QUE_FAIXIN
		lAltern := If(QUE->QUE_USAALT=="1",.T.,.F.)
	Endif

	nNota := QUD->QUD_NOTA
	If lQstZer .And. lAltern
		If nNota == nFaixIn
			nNota := 0
		EndIf	
	EndIf
	oSection3:CELL("cNOTA"):SetValue(AllTrim(Transform(nNota,PesqPict("QUD", "QUD_NOTA"))))

	
	oSection3:Cell("QUD_APLICA"):Show()

	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao da Obsevacao      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection3:Init()
	oSection4:Init()
	oSection5:Init()
		
	If mv_par18 == 1 
    	If Empty(QUD->QUD_TIPO) .Or. QUD->QUD_TIPO = "1"   // Questionario Padrao
			oSection4:Cell("cOBSCHV"):SetValue(MSMM(QU4->QU4_OBSCHV,TamSX3('QU4_OBSER1')[1]))
		ElseIf QUD->QUD_TIPO = "2" // Questionario Adicional
			oSection4:Cell("cOBSCHV"):SetValue(MSMM(QUE->QUE_OBSCHV,TamSX3('QUE_OBSER1')[1]))
		Endif
	EndIf

	If lCabec
		lImp := .F.
		oSection2a:Printline()   
		oSection2b:Printline()
		lCabec := .T. 
    Elseif lImp
	    oSection2b:Printline() 
	    lImp := .F.
	Endif	
	
	oSection3:Printline()
	If mv_par18 == 1
		oSection4:Printline()
	Endif

   	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao dos Resultados    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 1
		aTxtEviden := MSMM(QUD->QUD_EVICHV,TamSX3('QUD_EVIDE1')[1])
		nLargQst:= 125
		aTxtEviden := QADDivLin(aTxtEviden, nLargQst)

		If !Empty(aTxtEviden)
			For x := 1 to Len(aTxtEviden)
				oSection5:Cell("QUD_EVICHV"):SetValue(aTxtEviden[x])
				oSection5:Printline()
				oReport:SkipLine(1)
			Next 
		Else
 			oSection5:Cell("QUD_EVICHV"):SetValue("")
 			oSection5:Printline()
			For x:= 1 To mv_par13
				oReport:ThinLine()
				oReport:SkipLine(1)
			Next x
	    Endif
	   
	EndIf

	If mv_par14 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Nao-Conformidades                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		QUG->(dbSetOrder(3))
		If QUG->(dbSeek(xFilial("QUG")+QUD->QUD_NUMAUD+QUD->QUD_SEQ+QUD->QUD_CHKLST+QUD->QUD_REVIS+QUD->QUD_CHKITE+QUD->QUD_QSTITE))

			oSection6:Init()

			While QUG->(!Eof()) .And. ;
				xFilial("QUG")+QUG->QUG_NUMAUD+QUG->QUG_SEQ+QUG->QUG_CHKLST+QUG->QUG_REVIS+QUG->QUG_CHKITE+QUG->QUG_QSTITE == ;
				xFilial("QUG")+QUD->QUD_NUMAUD+QUD->QUD_SEQ+QUD->QUD_CHKLST+QUD->QUD_REVIS+QUD->QUD_CHKITE+QUD->QUD_QSTITE
                  
				IF !Empty(QUG->QUG_CODNC)
					oSection6:Cell("QUG_CODNC"):Enable()
					oSection6:Cell("QUG_REVNC"):Enable()					
					oSection6:Printline()
				Else
					oSection6:Cell("QUG_CODNC"):Disable()
					oSection6:Cell("QUG_REVNC"):Disable()

					If !Empty(QUG->QUG_DESCHV)
						aDesNC := JustificaTXT(MSMM(QUG->QUG_DESCHV,TamSX3('QUG_DESC1')[1]),100, .T.)
					EndIf
	
					If !Empty(aDesNC)
						oSection6:Cell("QUG_DESCHV"):Enable()
	
						For x := 1 to Len(aDesNC)
							oSection6:Cell("QUG_DESCHV"):SetValue(aDesNC[x])
							oSection6:Printline()
						Next
					EndIf
				EndIf
				
				QUG->(dbSkip())
			EndDo

			oSection6:Finish()
		Endif
	Else
		For x:= 1 To mv_par13
		  oReport:PrintText("  ",oReport:Row(),025)
		  oReport:SkipLine(1)
		Next x
	EndIf

	QUD->(dbSkip())
	lImpConc := .F.
	If cConAud # QUD->QUD_NUMAUD
		
		cKeyCon := QUB->QUB_CHAVE
		lImpConc := .T.
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime a Sugestao/Observacao da Auditoria                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If !Empty(QUB->QUB_SUGCHV)
			lObAu := .T.
			oSection7:Init()	  
		Else
			lObAu := .F.
		EndIf
		

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime a Conclusao da Auditoria                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par14 == 1
			oSection8:Init() 
			lConc := .T.
		Else
			oReport:PrintText((STR0007),oReport:Row(),025) //"Conclusao:"
			oReport:SkipLine(1)	
			For x:= 1 To 5
			  oReport:PrintText(" ",oReport:Row(),025)
			  oReport:SkipLine(1)	
			Next x		
			oReport:PrintText("____ / ____ / ____",oReport:Row(),050)
			oReport:SkipLine(1)	
			oReport:PrintText("",oReport:Row(),080)
			oReport:SkipLine(1)	
			oReport:PrintText(Padc(STR0008, 40),oReport:Row(),050)//"AUDITOR"
			oReport:SkipLine(1)	
			lConc := .F.
		EndIf
	
		cConAud := QUD->QUD_NUMAUD
	
	Else
		If lChkLst := (cChkLst # QUD->QUD_CHKLST)
			oReport:PrintText("",oReport:Row(),025)
			oReport:SkipLine(1)	
		Endif
	
		If lChkIte := (cChkIte # QUD->QUD_CHKITE) .And. ! lChkLst
			oReport:PrintText("",oReport:Row(),025)
			oReport:SkipLine(1)	
		Endif
	Endif

	If lObAu
		oSection7:Printline()
		lObAu:= .F.
	EndIf

	If AllTrim(cChkIte) <> AllTrim(QUD->QUD_CHKITE)
		oSection2b:Finish()
		oSection2b:Init() 
		lImp := .T.
	EndIf
	oSection1:Finish()
	oSection3:Finish()
	oSection4:Finish()
	oSection5:Finish()

	If lConc
		aTxtConc := JustificaTXT(MSMM(QUB->QUB_CHAVE,TamSX3('QUB_CONCLU')[1]),113,.T.)
		
		If !Empty(aTxtConc)				
			For x := 1 to Len(aTxtConc)
				oSection8:Cell("QUB_CHAVE"):SetValue(aTxtConc[x])
				oSection8:Printline()
			Next
		EndIf

		oSection8:Finish()
		oReport:SkipLine(2)	
		lConc := .F.
	EndIf
Enddo

If !lImpConc
	If mv_par14 == 1
		oSection8:Init() 
		aTxtConc := JustificaTXT(MSMM(QUB->QUB_CHAVE,TamSX3('QUB_CONCLU')[1]),113,.T.)
		If !Empty(aTxtConc)				
			For x := 1 to Len(aTxtConc)
				oSection8:Cell("QUB_CHAVE"):SetValue(aTxtConc[x])
				oSection8:Printline()
			Next
		EndIf
		oSection8:Finish()
		oReport:SkipLine(2)	
	Else
		oReport:PrintText((STR0007),oReport:Row(),025) //"Conclusao:"
		oReport:SkipLine(1)	
		For x:= 1 To 5
			oReport:PrintText(" ",oReport:Row(),025)
			oReport:SkipLine(1)	
		Next x		
		oReport:PrintText("____ / ____ / ____",oReport:Row(),050)
		oReport:SkipLine(1)	
		oReport:PrintText("",oReport:Row(),080)
		oReport:SkipLine(1)	
		oReport:PrintText(Padc(STR0008, 40),oReport:Row(),050)//"AUDITOR"
		oReport:SkipLine(1)	
	EndIf
EndIf

QUD->(DbCloseArea())
QU4->(DbCloseArea())
QUH->(DbCloseArea())
QUB->(DbCloseArea())
QU2->(DbCloseArea())
QU3->(DbCloseArea())
QUG->(DbCloseArea())

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QADR060Con³ Autor ³ Marcelo Iuspa			³ Data ³19/10/00  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Manutencao do encerramento da Auditoria					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QADR060Con(titulo,cabec1,cabec2,wnRel,tamanho)			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR060                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QADR060Con(titulo,cabec1,cabec2,wnRel,tamanho,cAuditoria)
Local x := 1

If li + 21 > 58
	Cabec(titulo,cabec1,cabec2,wnRel,tamanho)
	@ li++, 00 pSay cAuditoria
EndIf
@ li++,00 pSay STR0007 //"Conclusao:"
For x := 1 to 5
	li+=3
	@ li,05 pSay Replicate(__prtthinline(), 122)
Next
li+= 2
@ li,050 pSay "____ / ____ / ____"
@ li,80 pSay Replicate("_", 40)
@ ++li,80 pSay Padc(STR0008, 40) //"AUDITOR"
li+=2

Return(NIL) 
