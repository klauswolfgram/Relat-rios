/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "QNCR030.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QNCR030   ºAutor  ³Leandro Sabino      º Data ³  21/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de Follow-Up 		                              º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QNCR030(nRegImp)
Local oReport

Private	cFilAte  := ""
Private	cAnoDe   := ""
Private	cAnoAte  := ""
Private	cAcaoDe  := ""
Private	cAcaoAte := ""
Private	cRevDe   := ""
Private	cRevAte  := ""
Private	cMatDe   := ""
Private	cMatAte  := ""
Private	nEtapa   := ""
Private lTMKPMS   := If(GetMv("MV_QTMKPMS",.F.,1) == 1,.F.,.T.)//Integracao do QNC com TMK e PMS: 1-Sem integracao,2-TMKxQNC,3-QNCxPMS,4-TMKxQNCxPMS ³
Default nRegImp := 0

Pergunte("QNR030",.F.)
oReport := ReportDef(nRegImp)
oReport:PrintDialog()
If nRegImp <> 0
	oReport:ParamReadOnly()
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 21/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(nRegImp)
Local aPerSit 	:= {"  0 %"," 25 %"," 50 %"," 75 %","100 %","REPROV"}
Local cTitulo	:= OemToAnsi(STR0001) // "LISTA AUSENCIA TEMPORARIA"
Local cDesc1 	:= STR0001		//"Relatorio de Follow-UP de Plano de Acao."
Local cDesc2 	:= STR0002		//"Ser  impresso de acordo com os parametros solicitados pelo usuario."
Local oSection1 
Local oSection2

Private aOrdem  := {}

DEFINE REPORT oReport NAME "QNCR030" TITLE cTitulo PARAMETER "QNR030" ACTION {|oReport| PrintReport(oReport,nRegImp)} DESCRIPTION (cDesc1+cDesc2)
oReport:SetLandscape(.T.)

aOrdem := {	STR0003,; 	// "Codigo+Rev+Sequencia"
		    STR0004} 	// "Fil.Usuario+Mat.Usuario"

DEFINE SECTION oSection1 OF oReport TABLES "QI5" TITLE STR0012 ORDERS aOrdem // "Acao"
DEFINE CELL NAME "cCODIGO"    OF oSection1 ALIAS "QI5"  TITLE TitSX3("QI5_CODIGO")[1] SIZE 19 BLOCK {|| TRANSFORM(QI5->QI5_CODIGO,X3PICTURE("QI5_CODIGO"))+"-"+QI5->QI5_REV}
DEFINE CELL NAME "cMAT"       OF oSection1 ALIAS "QI5"  TITLE OemToAnsi(STR0011)      SIZE 35 BLOCK {|| QI5->QI5_FILMAT+"-"+alltrim(QI5->QI5_MAT)+" "+QA_NUSR(QI5->QI5_FILMAT,QI5->QI5_MAT,.F.,"A")}//"Responsavel"
DEFINE CELL NAME "cTPACAO"    OF oSection1 ALIAS "QI5"  TITLE TitSX3("QI5_TPACAO")[1] SIZE 20 BLOCK {|| QI5->QI5_TPACAO+"-"+Left(FQNCDSX5("QD",QI5->QI5_TPACAO),20)}
DEFINE CELL NAME "cSTATUS"    OF oSection1 ALIAS "QI5"  TITLE TitSX3("QI5_STATUS")[1] SIZE 06 BLOCK {|| aPerSit[Val(QI5->QI5_STATUS)+1]}
DEFINE CELL NAME "QI5_PRAZO"  OF oSection1 ALIAS "QI5" 
DEFINE CELL NAME "QI5_REALIZ" OF oSection1 ALIAS "QI5" 
DEFINE CELL NAME "cDESCRE"    OF oSection1 ALIAS "QI5"  TITLE TitSX3("QI5_DESCRE")[1] SIZE 50 BLOCK{|| Alltrim(QI5->QI5_DESCRE)+Replicate("_",50-Len(Alltrim(QI5->QI5_DESCRE)))}
DEFINE CELL NAME "cCodFNC"    OF oSection1 ALIAS "   "  TITLE TitSX3("QI9_FNC")[1] SIZE 20 

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 21/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport,nRegImp) 
Local oSection1 := oReport:Section(1)
Local nTamanho  
Local nOrdem    := 0
Local cParam    := ""

MakeAdvplExpr(oReport:uParam)

If nRegImp <> 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³O Relatorio devera se  comportar como o botao  Follow-up³
	//³ou seja devera todos  os  dados                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//esse passo vem pelo cadastro de ocorrencia de nao conformidade botao Folow up e esta entrando em loop
	mv_par01 := QI2->QI2_FILIAL
	mv_par02 := QI2->QI2_FILIAL
	mv_par03 := QI2->QI2_ANO //Ano de Inclusao da FNC 
	mv_par04 := STR(VAL(QI2->QI2_ANO)+1,4)//Ano de Inclusao da FNC + 1
	mv_par05 := QI2->QI2_CODACA
	mv_par06 := QI2->QI2_CODACA
	mv_par07 := QI2->QI2_REVACA 
	mv_par08 := QI2->QI2_REVACA
	mv_par09 := "          "    // Imprimo todos os usuarios
	mv_par10 := "ZZZZZZZZZZ"
	mv_par11 := 3
	mv_par12 := 1

EndIf
                                                                                        
cFilDe   := mv_par01
cFilAte  := mv_par02
cAnoDe   := mv_par03
cAnoAte  := mv_par04
cAcaoDe  := mv_par05
cAcaoAte := mv_par06
cRevDe   := mv_par07
cRevAte  := mv_par08
cMatDe   := mv_par09
cMatAte  := mv_par10
nEtapa   := mv_par11

Do Case
	Case oSection1:GetOrder() == 1
		nOrdem := 1
   	Case oSection1:GetOrder() == 2
		nOrdem := 2
EndCase
IF( mv_par12 == 1 )
	nTamanho  :="M"
Else
	nTamanho  :="G"
Endif

dbSelectArea("QI9")
dBSetOrder(1)

dbSelectArea("QI5")
dbGoTop()
If nOrdem == 1
	dbSetOrder( 1 )
	dbSeek(IF((FWModeAccess("QI5") == "C"),xFilial("QI5"),cFilDe) + cAcaoDe + cRevDe,.T.)
	cInicio  := "QI5->QI5_FILIAL + QI5->QI5_CODIGO + QI5->QI5_REV"
	cFim     := IF((FWModeAccess("QI5") == "C"),xFilial("QI5"),cFilAte) + cAcaoAte + cRevAte
ElseIf nOrdem == 2
	dbSetOrder( 2 )
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio  := "QI5->QI5_FILMAT + QI5->QI5_MAT"
	cFim     := cFilAte + cMatAte
Endif

While !oReport:Cancel() .And. QI5->(!Eof()) 
    If &cInicio <= cFim
		oSection1:Init()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	 	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cParam:= (Right(QI5->QI5_CODIGO,4)+Left(QI5->QI5_CODIGO,15)) < (Right(cAcaoDe,4)+Left(cAcaoDe,15)) .Or. ;
			 (Right(QI5->QI5_CODIGO,4)+Left(QI5->QI5_CODIGO,15)) > (Right(cAcaoAte,4)+Left(cAcaoAte,15))  
 
		If 	cParam .Or. ;
		  	(Right(QI5->QI5_CODIGO,4) < cAnoDe) .Or. ( Right(QI5->QI5_CODIGO,4) > cAnoAte ) .Or. ;
			(QI5->QI5_REV < cRevDe ) .Or. ( QI5->QI5_REV > cRevAte ) .Or. ;
			(QI5->QI5_FILIAL < cFilDe ) .Or. ( QI5->QI5_FILIAL > cFilAte ) .Or. ;
			(QI5->QI5_MAT < cMatDe ) .Or. ( QI5->QI5_MAT > cMatAte )
			QI5->(dbSkip()) 
			Loop
		Endif
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	 	//³ Consiste o Status dos Plano de Acao                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nEtapa <> 3 .And. ((nEtapa == 1 .And. QI5->QI5_STATUS == "4").Or. (nEtapa == 2 .And. QI5->QI5_STATUS <> "4") )
			QI5->(dbSkip())
			Loop
		Endif
	
		IF nTamanho=="M"  //Sintetico
			oSection1:CELL("cCODIGO"):Hide()
			oSection1:CELL("cCODIGO"):HideHeader()
		    oSection1:CELL("cCodFNC"):Hide() 
		    oSection1:CELL("cCodFNC"):HideHeader()
		Else
			IF QI9->(DBSeek(xFilial("QI9",QI5->QI5_FILIAL)+QI5->QI5_CODIGO+QI5->QI5_REV))
				oSection1:CELL("cCodFNC"):SetValue(TRANSFORM(QI9->QI9_FNC,X3PICTURE("QI9_FNC"))+"-"+QI9->QI9_REVFNC)
			Else
				oSection1:CELL("cCodFNC"):SetValue(SPACE(TAMSX3("QI9_CODIGO")[1]+	2+TAMSX3("QI9_REV")[1]))
			ENDIF
		Endif
		 
		oSection1:PrintLine()
	 Endif
 	QI5->(dbSkip()) 
Enddo

oSection1:Finish()

QI9->(DbCloseArea())
QI5->(DbCloseArea())

Return NIL
