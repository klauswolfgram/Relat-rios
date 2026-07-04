/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "QNCR040.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QNCR040   ºAutor  ³Leandro Sabino      º Data ³  22/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ de Plano de Acao pre-impressas                             º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QNCR040()
Local oReport

Private lTMKPMS := If(GetMv("MV_QTMKPMS",.F.,1) == 1,.F.,.T.)//Integracao do QNC com TMK e PMS: 1-Sem integracao,2-TMKxQNC,3-QNCxPMS,4-TMKxQNCxPMS ³


Pergunte("QNR040",.F.)

cFilDe   := mv_par01
cFilAte  := mv_par02
cAnoDe   := mv_par03
cAnoAte  := mv_par04
cAcaoDe  := mv_par05
cAcaoAte := mv_par06
cRevDe   := mv_par07
cRevAte  := mv_par08
nEtapa   := mv_par09
nAcao    := mv_par10
cStatus  := mv_par11
nRelac   := mv_par12
    
oReport := ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 22/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR040                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local aStatus   := {OemtoAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015)}	// "Registrada" ### "Em Analise" ### "Procede" ### "Nao Procede" ### "Cancelada"
Local aTipQI3	 := {OemToAnsi(STR0008),OemToAnsi(STR0009),OemToAnsi(STR0010)}	// "Corretiva" ### "Preventiva" ### "Melhoria"
Local cTitulo   := STR0007		//"PLANO DE ACAO"
Local cDesc1 	:= STR0001		//"Relatorio de Plano de Acao."
Local cDesc2 	:= STR0002		//"Ser  impresso de acordo com os parametros solicitados pelo usuario."
Local oSection1 
Local aOrdem	:= {OemToAnsi(STR0003),OemToAnsi(STR0004)}

DEFINE REPORT oReport NAME "QNCR040" TITLE cTitulo PARAMETER "QNR040" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)

DEFINE SECTION oSection1 OF oReport TITLE OemToAnsi(STR0034) TABLES "QI3" ORDERS aOrdem	// "Cabecalho"
DEFINE CELL NAME "cCODIGO"     OF oSection1 ALIAS "   " TITLE OemToAnsi(STR0016)  SIZE 17 BLOCK {||+TransForm(QI3->QI3_CODIGO,PesqPict("QI3","QI3_CODIGO"))}
DEFINE CELL NAME "QI3_REV"     OF oSection1 ALIAS "QI3" 
DEFINE CELL NAME "QI3_ABERTU"  OF oSection1 ALIAS "QI3" 
DEFINE CELL NAME "QI3_ENCREA0" OF oSection1 ALIAS "QI3" 
DEFINE CELL NAME "cAcao"       OF oSection1 ALIAS "   " TITLE OemToAnsi(STR0020)  SIZE 15 BLOCK {||aTipQI3[Val(QI3->QI3_TIPO)]} // "Acao "

DEFINE SECTION oSection2    OF oSection1 TITLE OemToAnsi(STR0021) TABLES "QI3" // "Responsavel: "
DEFINE CELL NAME "cResp"    OF oSection2 ALIAS "" TITLE OemToAnsi(STR0031)  SIZE 30 BLOCK {|| QA_NUSR(QI3->QI3_FILMAT,QI3->QI3_MAT,.F.)}
DEFINE CELL NAME "cStatus"  OF oSection2 ALIAS "" TITLE OemToAnsi(STR0032)  SIZE 12 BLOCK {|| aStatus[Val(QI3->QI3_STATUS)]}

DEFINE SECTION oSection3    OF oSection2 TITLE OemToAnsi(STR0023)  TABLES "QI3" // "Descricao Detalhada"
DEFINE CELL NAME "cPROBLE"  OF oSection3 ALIAS "" TITLE OemToAnsi(STR0023)  SIZE 90 BLOCK {|| MSMM(QI3->QI3_PROBLE)} // "Descricao Detalhada" 
oSection3:Cell("cPROBLE"):SeTLineBREAK(.T.)

DEFINE SECTION oSection4   OF oSection3 TITLE OemToAnsi(STR0035) TABLES "QI5" // "Descricao das Etapas"
DEFINE CELL NAME "cDESCCO" OF oSection4 ALIAS "" TITLE  SIZE 90 BLOCK {|| MSMM(QI5->QI5_DESCCO)}
oSection4:Cell("cDESCCO"):SeTLineBREAK(.T.)

DEFINE SECTION oSection5 OF oSection4 TITLE OemToAnsi(STR0029) TABLES "QI2","QI9" // "Ficha Ocorrencias/Nao-conformidades Relacionadas"
DEFINE CELL NAME "cFNC"          OF oSection5 ALIAS "   " TITLE TitSX3("QI2_FNC")[1]   SIZE 17 BLOCK {||Transform(QI2->QI2_FNC,PesqPict("QI2","QI2_FNC"))}
DEFINE CELL NAME "QI2_REV"       OF oSection5 ALIAS "QI2" 
DEFINE CELL NAME "cOriginador"   OF oSection5 ALIAS "   " TITLE OemToAnsi(STR0033)SIZE 30 BLOCK {||QA_NUSR(QI2->QI2_FILMAT,QI2->QI2_MAT,.F.)}	// "Originador"
DEFINE CELL NAME "QI2_OCORRE"    OF oSection5 ALIAS "QI2" 
DEFINE CELL NAME "QI2_DESCR"     OF oSection5 ALIAS "QI2" 

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 22/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR040                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport) 
Local oSection1  := oReport:Section(1) 
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(1):Section(1)
Local oSection4  := oReport:Section(1):Section(1):Section(1):Section(1)
Local oSection5  := oReport:Section(1):Section(1):Section(1):Section(1):Section(1)
Local cTxtDet 	 := ""
Local lPend   	 := .F.
Local cFiltro 	 := "" 
Local cIndex1 	 := CriaTrab( Nil, .f. )
Local aTxtDet    := {} // Inicializacao do array de textos
Local nContEta
Local nT
Local nEt
Local nOrdem	:= oSection1:GetOrder()

Local aUsrMat	:= QNCUSUARIO()
Local cMatFil  	:= aUsrMat[2]
Local cMatCod	:= aUsrMat[3]
Local lSigiloso := .f.
MakeAdvplExpr(oReport:uParam)

dbSelectArea( "QI3" )
dbSetOrder( nOrdem )

cFiltro:= '( QI3->QI3_ANO >= "'+ cAnoDe  +'" ) .And. '
cFiltro+= '( QI3->QI3_ANO <= "'+ cAnoAte +'" ) .And. '
cFiltro+= '( QI3->QI3_REV >= "'+ cRevDe  +'" ) .And. '
cFiltro+= '( QI3->QI3_REV <= "'+ cRevAte +'" ) .And. '
cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,15) >= "'+ Right(Alltrim(cAcaoDe ),4) + Left(cAcaoDe ,15) + '" ) .And. '
cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,15) <= "'+ Right(Alltrim(cAcaoAte),4) + Left(cAcaoAte,15) + '" ) .And. '
cFiltro+= ' QI3->QI3_STATUS $ "'+ cStatus + '"'

oSection1:SetFilter(cFiltro)

If nOrdem == 1
	dbSeek(IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilDe) + cAnoDe + cAcaoDe + cRevDe,.T.)
	cInicio  := "QI3->QI3_FILIAL + QI3->QI3_ANO + QI3->QI3_CODIGO + QI3->QI3_REV"
	cFim     := IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilAte) + cAnoAte + cAcaoAte + cRevAte
ElseIf nOrdem == 2
	dbSeek(IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilDe) + cAcaoDe + cRevDe,.T.)
	cInicio  := "QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV"
	cFim     := IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilAte) + cAcaoAte + cRevAte
Endif

While !oReport:Cancel() .And. QI3->(!Eof()) .And. &cInicio <= cFim

		oSection1:Init()
		lPend:= .F.
	   	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	 	//³ Consiste o tipo de Plano de Acao                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nAcao <> 4 .And. Val(QI3->QI3_TIPO) <> nAcao
			QI3->(dbSkip())
			Loop
		Endif
	

		If nEtapa == 1 // Pendente
			If QI5->(DbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
				While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
					If QI5->QI5_STATUS <> "4"
						lPend:= .T.
						Exit       
					EndIf
					QI5->(DbSkip())
				EndDo		
			EndIf			
	
		ElseIf nEtapa == 2 // Baixada
			If QI5->(DbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
				While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
					If QI5->QI5_STATUS == "4"
						lPend:= .T.
						Exit
					EndIf
					QI5->(DbSkip())
				EndDo		
			EndIf			
		Else 
			lPend:= .T.
		EndIf
	
		If !lPend
			QI5->(DbSkip())
			Loop
		EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se Plano eh Sigiloso. Somente Responsavel (plano e etapas) pode Imprimir   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	lSigiloso := .f.
	If QI3->QI3_SIGILO == "1"	
		If cMatFil+cMatCod <> QI3->QI3_FILMAT+QI3->QI3_MAT 
			lSigiloso := .T.
			QI5->(dbSetOrder(1))
			If QI5->(dbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
				While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
					If QI5->QI5_FILMAT + QI5->QI5_MAT == cMatFil + cMatCod 
						lSigiloso := .f.
						Exit
					Endif
					QI5->(dbSkip())
				Enddo
			Endif							
		Endif
	Endif
		oSection2:Init()
		oSection1:PrintLine()
		oSection2:PrintLine()
	If lSigiloso
		oReport:SkipLine(1)
		oReport:PrintText(STR0036,oReport:Row(),025)  	// "Dados Sigilosos"				
		oReport:SkipLine(1)
		oReport:PrintText(STR0037 + AllTrim(Posicione("QAA",1, QI3->QI3_FILMAT+QI3->QI3_MAT,"QAA_NOME"))+ STR0038,oReport:Row(),025)  // "Acesso permitido a " ###" e aos responsáveis pelas etapas"
		oReport:SkipLine(1)
	Else
		
		oSection3:Init()
		oSection3:PrintLine()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	 	//³ Imprime as Etapas das Acoes                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nContEta := 0
		IF QI5->(dbSeek( QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV ))
	
			While !Eof() .And. QI5->QI5_FILIAL + QI5->QI5_CODIGO + QI5->QI5_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			 	//³ Consiste o Status dos Plano de Acao                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF nEtapa == 3 .Or. ;
		            ( nEtapa == 1 .And. QI5->QI5_STATUS <> "4" ) .Or. ;
		            ( nEtapa == 2 .And. QI5->QI5_STATUS == "4" ) 
	
					If nContEta == 0
						oReport:SkipLine(1)
						oReport:ThinLine()
						oReport:PrintText(OemToAnsi(STR0025),oReport:Row(),025)// "Acoes" 
					Endif
					oSection4:Init()
					oSection4:Cell("cDESCCO"):cTitle := QI5->QI5_TPACAO+"-"+FQNCDSX5("QD",QI5->QI5_TPACAO)
					oSection4:PrintLine()
					
												
					Q_MemoArray(MSMM(QI5->QI5_DESCCO), @aTxtDet, 128)
					If Len(aTxtDet) < 4
						For nT:=1 to (4-Len(aTxtDet))
							oReport:SkipLine(1) 
							oReport:PrintText(Replicate(".",128),oReport:Row(),025) 				
							oReport:SkipLine(1)
						Next
					Endif
					oReport:ThinLine()
					nContEta := nContEta + 1
			    EndIf
			    QI5->(dbSkip())
			    oSection4:Finish()
		    Enddo
	    Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	 	//³ Imprime as Etapas em branco para serem preenchidas           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nContEta < 5	//-- Sim
			For nEt := nContEta to 5
				oReport:ThinLine()
				For nT := 1 to 4
					oReport:SkipLine(1) 
					oReport:PrintText(Replicate(".",128),oReport:Row(),025) 
					oReport:SkipLine(1) 
				Next
				oReport:ThinLine()
			Next	
		Endif
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	 	//³ Imprime as Fichas de Ocorrencias/Nao-conformidades Relacionadas  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nRelac == 1	// Sim
			If QI9->(dbSeek(QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV))
				oReport:SkipLine(1) 
				oReport:ThinLine()
				oReport:PrintText(OemToAnsi(STR0029),oReport:Row(),025) 
				oReport:SkipLine(1) 
				While !Eof() .And. QI9->QI9_FILIAL + QI9->QI9_CODIGO + QI9->QI9_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
					IF QI2->(dbSeek(QI9->QI9_FILIAL+Right(QI9->QI9_FNC,4)+QI9->QI9_FNC+QI9->QI9_REVFNC))
						oSection5:Init()
						oSection5:PrintLine()
					Endif
					QI9->(dbSkip())
					oSection5:Finish()
					oReport:SkipLine(1) 
					oReport:ThinLine()
				Enddo
			Endif
		Endif	

    Endif
	QI3->(dbSkip())
	oSection1:SetPageBreak(.T.) 
	oSection1:Finish()
	oSection2:Finish()
	oSection3:Finish()
	oSection5:Finish()	
Enddo

Return NIL
