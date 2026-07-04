/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "QADR110.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QADR110   ºAutor  ³Leandro Sabino      º Data ³  20/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Listagem de Nao-conformidades                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QADR110()
Local oReport

If TRepInUse()
	Pergunte('QAR110',.F.) 
    oReport := ReportDef()
    oReport:PrintDialog()
Else
	U_QADR110R3()	// Executa versão anterior do fonte
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 13/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cTitulo    := STR0003 //"Listagem de Nao Conformidades"
Local cDesc1     := STR0001 //"Este relatorio tem o objetivo de imprimir a lista de nao conformidades"
Local cDesc2     := STR0002 //"separadas por areas"
Local oSection1 
Local oSection2 
Local oSection3 
Local oSection4 
Local oSection5 
Local oSection6 
Local oTtNCArea
Local OTtNCAud 
Local oTtNCAr
                                               
DEFINE REPORT oReport NAME "QADR110" TITLE cTitulo PARAMETER "QAR110" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)

DEFINE SECTION oSection1 OF oReport TABLES "QUB","QAA" TITLE TitSX3("QUB_NUMAUD")[1]
DEFINE CELL NAME "QUB_NUMAUD" OF oSection1 ALIAS "QUB"
DEFINE CELL NAME "QUB_INIAUD" OF oSection1 ALIAS "QUB"
DEFINE CELL NAME "QUB_ENCAUD" OF oSection1 ALIAS "QUB" 
DEFINE CELL NAME "QUB_REFAUD" OF oSection1 ALIAS "QUB"
DEFINE CELL NAME "QUB_ENCREA" OF oSection1 ALIAS "QUB"
DEFINE CELL NAME "QUB_PONPOS" OF oSection1 ALIAS "QUB" 
DEFINE CELL NAME "QUB_PONOBT" OF oSection1 ALIAS "QUB" 
DEFINE CELL NAME "QUB_AUDLID" OF oSection1 ALIAS "QUB" 
DEFINE CELL NAME "QAA_NOME"   OF oSection1 ALIAS "QAA" TITLE TitSX3("QAA_NOME")[1] BLOCK {|| Posicione("QAA",1,QUB->QUB_FILMAT+QUB->QUB_AUDLID,"QAA_NOME")} 

DEFINE SECTION oSection2 OF oSection1 TABLES TITLE STR0008
DEFINE CELL NAME "cDESCHV" OF oSection2 ALIAS TITLE STR0008 SIZE 100
oSection2:Cell("cDESCHV"):SeTLineBREAK(.T.)

DEFINE SECTION oSection3 OF oSection2 TABLES TITLE STR0013//Area
DEFINE CELL NAME "cARea" OF oSection3 ALIAS " " TITLE STR0009 SIZE 80

DEFINE SECTION oSection4 OF oSection3 TABLES "QUH","QUG" TITLE TitSX3("QUH_DESTIN")[1]
DEFINE CELL NAME "QUH_DESTIN" OF oSection4 ALIAS "QUH" TITLE OemToAnsi(STR0013)    SIZE TamSX3("QUH_DESTIN")[1]//"Area"
DEFINE CELL NAME "cNorma"     OF oSection4 ALIAS ""    TITLE TitSX3("QU3_NORMA")[1]  SIZE 10
DEFINE CELL NAME "nQtdNC"     OF oSection4 ALIAS ""    TITLE TitSX3("AA2_ITEM")[1]   SIZE 4
DEFINE CELL NAME "cTxtNC"     OF oSection4 ALIAS ""    TITLE TitSX3("QUG_DESC1")[1]  SIZE 80
oSection4:Cell("cTxtNC"):SeTLineBREAK(.T.)

DEFINE SECTION oSection5 OF oSection4 TABLES TITLE STR0011
DEFINE CELL NAME "nTtNCAr"  OF oSection5 ALIAS "" TITLE STR0011  SIZE 10 //"Total de NC Area"

DEFINE SECTION oSection6 OF oSection5 TABLES  TITLE STR0012
DEFINE CELL NAME "nTtNCAud"   OF oSection6 ALIAS "" TITLE STR0012  SIZE 10 //"Total de NC Auditoria"

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport) 
Local oSection1 := oReport:Section(1)
Local oSection2 := oSection1:Section(1)
Local oSection3 := oSection2:Section(1)
Local oSection4 := oSection3:Section(1)
Local oSection5 := oSection4:Section(1)
Local oSection6 := oSection5:Section(1)

Local cSeekQUG 
Local nTotQtdNC := 0
Local lImpCapa  := .T.
Local lImpTotNc := .F.
Local lImpTot   := .F.
Local nQtdNC 	:= 0
Local nCtdArea	:= 0

MakeAdvplExpr(oReport:uParam)

DbSelectArea("QUB")
DbSetOrder(1)
QUB->(dbSeek(xFilial("QUB")+mv_par01,.T.))

DbSelectArea("QUH")
DbSetOrder(1)

While QUB->(!Eof()) .And. QUB->(QUB_FILIAL+QUB_NUMAUD) >= (xFilial("QUB")+mv_par01) .And.;
	QUB->(QUB_FILIAL+QUB_NUMAUD) <= xFilial("QUB")+mv_par02
    
	TRPosition():New(oReport:Section(1),"QAA",1,{|| xFilial("QUB")+QUB->QUB_AUDLID })
	
	If !Empty(AllTrim(oReport:Section(1):GetSQLExp("QAA")))					
		If !Empty(oReport:Section(1):GetSQLExp("QAA"))
			If !QAA->(&(oReport:Section(1):GetSQLExp("QAA")))
				QUB->(DbSkip())
				loop
			Endif
		Endif								
	EndIf

	nTotQtdNC := 0
	lImpCapa  := .T.
	
	QUH->(dbSetOrder(1))
	If QUH->(dbSeek(xFilial("QUH")+QUB->QUB_NUMAUD))
		While QUH->(!Eof()) .And. QUH->(QUH_FILIAL+QUH_NUMAUD) ==	xFilial("QUH")+QUB->QUB_NUMAUD
				
			If !Empty(AllTrim(oSection4:GetSQLExp("QUH")))					
				If !Empty(oSection4:GetSQLExp("QUH"))
					If !QUH->(&(oSection4:GetSQLExp("QUH")))
						QUH->(DbSkip())
						loop
					Endif
				Endif								
			EndIf
			
			If mv_par03 > QUH->QUH_CCUSTO .Or. QUH->QUH_CCUSTO > mv_par04
				QUH->(dbSkip())
				Loop
			Endif	
		
			nQtdNC    := 0
		 	cSeekQUG  := xFilial("QUG")+QUH->QUH_NUMAUD+QUH->QUH_SEQ	
			QUG->(dbSetOrder(1))
			QUG->(dbSeek(cSeekQUG))
		 
			While QUG->(!Eof()).And. QUG->(QUG_FILIAL+QUG_NUMAUD+QUG_SEQ) == cSeekQUG
	
				If !Empty(AllTrim(oSection4:GetSQLExp("QUG")))					
					If !Empty(oSection4:GetSQLExp("QUG"))
						If !QUG->(&(oSection4:GetSQLExp("QUG")))
							QUG->(DbSkip())
							loop
						Endif
					Endif								
				EndIf
						
				If lImpCapa  
					oSection1:Init()
					oSection1:PrintLine()	
					
					oSection2:Init()			
					oSection2:CELL("cDESCHV"):SetValue(MSMM(QUB->QUB_DESCHV))
					oSection2:PrintLine()
			
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime a Capa da Auditoria	  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par05 == 1    
					   
						lImpCapa := .F.
	                	aAreaQUH := QUH->(GetArea())	

						QUH->(dbSetOrder(1))
						QUH->(dbSeek(xFilial("QUH") + QUB->QUB_NUMAUD))
						oSection3:Init()
						While QUH->(!Eof()) .And. QUH->QUH_FILIAL == xFilial("QUH") .And.;
							QUH->QUH_NUMAUD == QUB->QUB_NUMAUD
							nCtdArea:= nCtdArea + 1
							oSection3:CELL("cARea"):SetValue(StrZero(nCtdArea,4)+"  "+QUH->QUH_DESTIN)
						    QUH->(dbSkip())
						    oSection3:PrintLine()														
						EndDo							
						QUH->(RestArea(aAreaQUH))
					EndIf
	            EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Areas com nao-conformidades									 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    	    QU3->(dbSetOrder(1))
				If QU3->(dbSeek(xFilial("QU3")+QUG->QUG_CHKLST+QUG->QUG_REVIS+QUG->QUG_CHKITE))
					cNorma := QU3->QU3_NORMA
				Else
					cNorma := ""
				EndIf
				nQtdNC++               
				oSection4:Init()
				oSection4:CELL("cNorma"):SetValue(cNorma)
				oSection4:CELL("nQtdNC"):SetValue(StrZero(nQtdNC,4))
				oSection4:CELL("cTxtNC"):SetValue(MSMM(QUG->QUG_DESCHV))
				oSection4:PrintLine()	
			
				QUG->(dbSkip())
				lImpTotNc := .T.

			EndDo

			If lImpTotNc .And. nCtdArea > 0
			    oSection5:Init()
				oSection5:Cell("nTtNCAr"):SetValue(StrZero(nQtdNC,4))
				oSection5:PrintLine()     
				oSection5:Finish()
				lImpTot   := .T.
				lImpTotNc := .F.
				nTotQtdNC += nQtdNC
			Endif	

			QUH->(dbSkip())
			oReport:SkipLine(3) 
		EndDo          
	Endif


	If lImpTot .And. nTotQtdNC > 0 
		oSection6:Init()
		oSection6:Cell("nTtNCAud"):SetValue(StrZero(nTotQtdNC,4))             
		oSection6:PrintLine()     
		oSection6:Finish()
		lImpTotNc := .F.
		lImpTot   := .F.
	Endif		

	
	QUB->(dbSkip())	
	oSection1:Finish()
	oSection2:Finish()
	oSection3:Finish()
	oSection4:Finish()
	oSection5:Finish()
	oSection6:Finish()
	
EndDo	

Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QADR110R3³ Autor ³ Marcelo Iuspa			³ Data ³ 19/12/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Listagem de Nao-conformidades							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQAD                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Paulo Emidio³18/12/00³------³Foram ajustados e complementados os STR's ³±±
±±³            ³	    ³      ³e os arquivos CH's, para que os mesmos pos³±±
±±³            ³	    ³      ³sam ser traduzidos.						  ³±±
±±³Robson Ramir³15/05/02³ Meta ³Alteracao do alias da familia QU para QA  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QADR110R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1     := STR0001 //"Este relatorio tem o objetivo de imprimir a lista de nao conformidades"
Local cDesc2     := STR0002 //"separadas por areas"
Local cDesc3     := ''
Local cString    := 'QUG'
Local lEnd       := .F.
Local Titulo     := STR0003 //"Listagem de Nao Conformidades"
Local wnRel      := 'QADR110' 

Private cTamanho := 'M'
Private aReturn  := {STR0004, 1, STR0005, 1, 2, 1, '', 1}  //"Zebrado"#"Administracao"
Private cPerg    := 'QAR110' 
                             
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg, .F.)

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,cTamanho,"",.F.)

If nLastKey == 27
	Set Filter To
	Return Nil
Endif

SetDefault(aReturn, cString)

If nLastKey == 27
	Set Filter To
	Return Nil
Endif

RptStatus({|lEnd| Qad110Imp(@lEnd,wnRel,cString,Titulo)},Titulo)

Set Filter To

Return(NIL)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Qad110Imp ³ Autor ³ Marcelo Iuspa			³ Data ³19/10/00  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Manutencao do encerramento da Auditoria					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Qad110Imp(lEnd, wnRel, cTamanho, Titulo)					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Qad110Imp(lEnd,wnRel,cString,Titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cSeekQUG
Local aTxtDes         
Local aTxtNc                                      
Local cDesAud 
Local aAreaQUH                      
Local lImpCapa
Local nTotQtdNC 
Local nQtdNC   
Local lCabNc  
Local lImpTotNc
Local cNomAudLid 
Local cMsgAreDes
Local cNorma          
Local nX
		
Private nLin   
Private m_pag   := 1
Private cCabec1 := STR0006 //"NUMERO     DATA                                         PONTOS               AUDITOR    "
Private cCabec2 := STR0007 //"AUDITORIA  INICIO     ENCERRAM   REFERENC   REAL        POSSIV.    OBTIDOS   CODIGO   NOME"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros utilizados                                                        ³
//³ mv_par01 - Auditoria de                                                      ³
//³ mv_par02 - Auditoria ate                                                     ³
//³ mv_par03 - Area de                                                           ³
//³ mv_par04 - Area ate                                                          ³
//³ mv_par05 - Imprime a Apresentacao 1 = Sim                                    ³
//³ 								  2 = Nao								     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(QUB->(LastRec()))
QUB->(dbSetOrder(1))
QUB->(dbSeek(xFilial("QUB")+mv_par01,.T.))

While QUB->(!Eof()) .And. QUB->(QUB_FILIAL+QUB_NUMAUD) >= (xFilial("QUB")+mv_par01) .And.;
	QUB->(QUB_FILIAL+QUB_NUMAUD) <= xFilial("QUB")+mv_par02
	
	IncRegua()
	                
	nTotQtdNC := 0
	lImpCapa  := .T.

	QUH->(dbSetOrder(1))
	If QUH->(dbSeek(xFilial("QUH")+QUB->QUB_NUMAUD))
		While QUH->(!Eof()) .And. QUH->(QUH_FILIAL+QUH_NUMAUD) ==;
			xFilial("QUH")+QUB->QUB_NUMAUD
				
			If mv_par03 > QUH->QUH_CCUSTO .Or. QUH->QUH_CCUSTO > mv_par04
				QUH->(dbSkip())
				Loop
			Endif	
	                    
	  		nQtdNC    := 0
	  		lCabNC    := .T.
			lImpTotNc := .F.
		    cSeekQUG  := xFilial("QUG")+QUH->QUH_NUMAUD+QUH->QUH_SEQ	
		    
			QUG->(dbSetOrder(1))
			QUG->(dbSeek(cSeekQUG))
			While QUG->(!Eof()).And. QUG->(QUG_FILIAL+QUG_NUMAUD+QUG_SEQ) == cSeekQUG
			
				If lImpCapa  
				
					Cabec(titulo,cCabec1,cCabec2,wnRel,ctamanho)
					nLin   := 9
				    lCabNc := .T.		
	
					//NUMERO     DATA                                         PONTOS               RESPONSAVEL"
					//AUDITORIA  INICIO     ENCERRAM   REFERENC   REAL        POSSIV.    OBTIDOS   CODIGO   NOME"
					//XXXXXX     XX/XX/XX   XX/XX/XX   XX/XX/XX   XX/XX/XX   XXXXXXXX   XXXXXXXX   XXXXXX   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		                                                       
		            QAA->(dbSetorder(1))
		            If QAA->(dbSeek(QUB->QUB_FILMAT+QUB->QUB_AUDLID))
		            	cNomAudLid := QAA->QAA_NOME
					Else            	
						cNomAudLid := ""
		            EndIf	
					@ nLin, 00 pSay QUB->QUB_NUMAUD
					@ nLin, 11 pSay QUB->QUB_INIAUD 
					@ nLin, 22 pSay QUB->QUB_ENCAUD			
					@ nLin, 33 pSay QUB->QUB_REFAUD 
					@ nLin, 44 pSay QUB->QUB_ENCREA
					@ nLin, 55 pSay Transf(QUB->QUB_PONPOS,"@r 99999.99")					
					@ nLin, 66 pSay Transf(QUB->QUB_PONOBT,"@r 99999.99")			
					@ nLin, 77 pSay QUB->QUB_AUDLID    
					@ nLin, 90 pSay cNomAudLid
					nLin++
					@ nLin, 00 pSay __prtthinline()
					nLin+=2
					aTxtDes := JustificaTXT(MSMM(QUB->QUB_DESCHV,TamSX3('QUB_DESCR1')[1]),68,.T.)	  	
					
					cDesAud := STR0008 //"Descricao da Auditoria"				
					@ nLin, 00 pSay cDesAud
					nLin++
					@ nLin, 00 pSay Repl("-",Len(cDesAud))
					nLin+=2
					
					For nX := 1 to Len(aTxtDes)            
						If !Empty(aTxtDes[nX])				
							If nLin > 55
				   				Cabec(titulo,cCabec1,cCabec2,wnRel,ctamanho)
								nLin   := 9    
								lCabNc := .T.
							EndIf	
	
							@ nLin, 00 pSay aTxtDes[nX]				
							nLin++
						EndIf	
					Next  
						        
					@ nLin, 00 pSay __prtthinline()
					nLin+=2
	
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime a Capa da Auditoria									 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par05 == 1    
					   
						lImpCapa := .F.
	
	                	aAreaQUH := QUH->(GetArea())	
	                	cMsgAreDes := STR0009 //"Esta auditoria se destina a seguintes areas"
						nLin++
						@ nLin, 00 pSay cMsgAreDes                
						nLin++
						@ nLin, 00 pSay Repl("-",Len(cMsgAreDes))
						nLin+=1
					
						nCtdArea := 1
						QUH->(dbSetOrder(1))
						QUH->(dbSeek(xFilial("QUH") + QUB->QUB_NUMAUD))
						While QUH->(!Eof()) .And. QUH->QUH_FILIAL == xFilial("QUH") .And.;
							QUH->QUH_NUMAUD == QUB->QUB_NUMAUD
							@ nLin, 00 pSay StrZero(nCtdArea,4)
							@ nLin, 06 PSay QUH->QUH_DESTIN
							nLin++
							QUH->(dbSkip())
							nCtdArea++
					
						EndDo
						QUH->(RestArea(aAreaQUH))
					
					EndIf
			
	            EndIf
	            nLin++
	            
				If nLin > 55
	   				Cabec(titulo,cCabec1,cCabec2,wnRel,ctamanho)
					nLin   := 9    
					lCabNc := .T.
				EndIf	
	                    
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Areas com nao-conformidades									 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lCabNc                         
					@ nLin, 00 pSay STR0010 //"AREA                                      NORMA       ITEM   DESCRICAO"
					nLin++
					@ nLin, 00 pSay __prtthinline()
					nLin++
					lCabNc := .F.
				EndIf	
				
				//AREA                                      NORMA       ITEM   DESCRICAO"			
				//-----------------------------------------------------------------------------------------------------------------------------------
				
	    	    QU3->(dbSetOrder(1))
				If QU3->(dbSeek(xFilial("QU3")+QUG->QUG_CHKLST+QUG->QUG_REVIS+QUG->QUG_CHKITE))
					cNorma := QU3->QU3_NORMA
				Else
					cNorma := ""
				EndIf
				nQtdNC++               
	
				aTxtNC := JustificaTXT(MSMM(QUG->QUG_DESCHV,TamSX3('QUG_DESC1')[1]),68,.T.)	  	
				
				For nX := 1 to Len(aTxtNC)
					If !Empty(aTxtNC[nX])
					
						If nLin > 55
			   				Cabec(titulo,cCabec1,cCabec2,wnRel,ctamanho)
							nLin   := 9    
							lCabNc := .T.
						EndIf	
	
						If nX == 1
							@ nLin, 00 pSay QUH->QUH_DESTIN
							@ nLin, 42 pSay cNorma           
							@ nLin, 54 pSay StrZero(nQtdNC,4)
							@ nLin, 61 pSay aTxtNC[nX]
							nLin++
						Else        
							@ nLin, 61 pSay aTxtNC[nX]				
							nLin++
						Endif           
					EndIf                  
				Next  
				nLin++
 	            
				QUG->(dbSkip())
				lImpTotNc := .T.
			EndDo
			If nQtdNC > 0
				nTotQtdNC += nQtdNC
				@ nLin, 00 pSay STR0011+StrZero(nQtdNC,4) //"Total de nao-conformidades na area -> "
				nLin+=2
		    EndIf 
			QUH->(dbSkip())
		EndDo          
		If nTotQtdNC > 0
			nLin++
			If nLin > 55
				Cabec(titulo,cCabec1,cCabec2,wnRel,ctamanho)
				nLin   := 9    
				lCabNc := .T.
			EndIf	
			@ nLin, 00 pSay STR0012+StrZero(nTotQtdNC,4) //"Total de nao-conformidades na Auditoria -> "
			nLin++                  
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existem nao-conformidades							  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	QUB->(dbSkip())	
	
EndDo	

If nLin # 80
    Roda(,,cTamanho)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set device to Screen

If aReturn[5] == 1
	Set Printer To 
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return(NIL)    
