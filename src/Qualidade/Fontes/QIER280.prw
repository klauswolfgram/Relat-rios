/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER280.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

#DEFINE TAMANHO_ATUAL 1
#DEFINE TAMANHO_MIN   3
#DEFINE TAMANHO_MAX   4

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ QIER280  ³ Autor ³ Cleber Souza          ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio Fornecedores Avaliados mod. Insp. Entrada        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SigaQie                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³ 		                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Qier280()

Local oReport	

Private cPerg    	:= "QER280"
Private cQEV_PRODUT := ""
Private cQEV_FORNEC := "" 
Private cLoja       := ""
Private cQEV_IQI  	:= ""
Private cQEV_IQIA 	:= ""
Private cQEV_IQF  	:= ""
Private cQEV_IQFA 	:= ""
Private cQEV_IQS  	:= ""
Private cQEV_ANO  	:= ""
Private cQEV_MES  	:= ""      

oReport := ReportDef()
oReport:PrintDialog()
Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ReportDef  ºAutor  ³Cleber Souza        º Data ³  31/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicoes do relatorio de Formulas R4.		              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER280                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local cPrograma  	:="QIER280"
Local cDesc1  	 	:=STR0001  // "Este relatorio relaciona os Fornecedores de cada Produto,"
Local cDesc2  	 	:=STR0002	// "informando seus índices de avaliação." 
Local cTitulo    	:=STR0003  // "FORNECEDORES AVALIADOS" 

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)

DEFINE SECTION oSection1 OF oReport TITLE TitSX3("A5_PRODUTO")[1] LINE STYLE
DEFINE CELL NAME "cProduto"  OF oSection1 SIZE 30  TITLE  AllTrim(TitSx3("A5_PRODUTO")[1])  		 

DEFINE SECTION oSection2 OF oReport TABLES "QEV" TITLE STR0008
DEFINE CELL NAME "cFornecedor"  OF oSection2 SIZE TamSx3("A2_NREDUZ")[1] 	TITLE  AllTrim(TitSX3("A2_NREDUZ")[1]) 		BLOCK {||POSICIONE('SA2',1,xFilial('SA2')+cQEV_FORNEC,'A2_NREDUZ')  }		 
DEFINE CELL NAME "cFR"			OF oSection2 SIZE TamSx3("A5_FABREV")[1]   	TITLE  Subst(TitSx3("A5_FABREV")[1],1,3)	BLOCK {||POSICIONE('SA5',2,xFilial('SA5')+cQEV_PRODUT+cQEV_FORNEC+cLoja ,'A5_FABREV') }  		 
DEFINE CELL NAME "cCodFor"  	OF oSection2 SIZE TamSx3("A5_FORNECE")[1]+TamSx3("A5_FORNECE")[1]  	TITLE  TitSx3("A5_LOJA")[1]  		 	BLOCK {||Alltrim(POSICIONE('SA5',2,xFilial('SA5')+cQEV_PRODUT+cQEV_FORNEC+cLoja ,'A5_FORNECE'))+" - "+SA5->A5_LOJA }  		 
DEFINE CELL NAME "cNivel"	  	OF oSection2 SIZE TamSx3("QEG_NIVEL")[1]  	TITLE  Subs(TitSx3("QEG_NIVEL")[1],1,15)  		 	
DEFINE CELL NAME "cQEV_IQI"	  	OF oSection2 SIZE TamSx3("QEV_IQI")[1] 		TITLE  AllTrim(TitSX3("QEV_IQI")[1]) 	BLOCK {|| IIF(cQEV_IQI==999.99 ,"N/A",AllTrim(Str(cQEV_IQI)))}
DEFINE CELL NAME "cQEV_IQIA"	OF oSection2 SIZE TamSx3("QEV_IQIA")[1] 	TITLE  AllTrim(TitSX3("QEV_IQIA")[1]) 	BLOCK {|| IIF(cQEV_IQIA==999.99,"N/A",AllTrim(Str(cQEV_IQIA)))}
DEFINE CELL NAME "cQEV_IQF"	  	OF oSection2 SIZE TamSx3("QEV_IQF")[1] 		TITLE  AllTrim(TitSX3("QEV_IQF")[1]) 	BLOCK {|| IIF(cQEV_IQF==999.99 ,"N/A",AllTrim(Str(cQEV_IQF)))}
DEFINE CELL NAME "cQEV_IQFA"	OF oSection2 SIZE TamSx3("QEV_IQFA")[1] 	TITLE  AllTrim(TitSX3("QEV_IQFA")[1]) 	BLOCK {|| IIF(cQEV_IQFA==999.99,"N/A",AllTrim(Str(cQEV_IQFA)))}
DEFINE CELL NAME "cQEV_IQS"	  	OF oSection2 SIZE TamSx3("QEV_IQS")[1] 		TITLE  AllTrim(TitSX3("QEV_IQS")[1]) 	BLOCK {|| IIF(cQEV_IQS==999.99 ,"N/A",AllTrim(Str(cQEV_IQS)))}
DEFINE CELL NAME "cRef"		  	OF oSection2 SIZE 7						  	TITLE  STR0007  // "Ref. "  

Return(oReport) 		 	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Cleber Souza		 º Data ³  31/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao relatorio R4.                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER280                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)   

Local oSection1    := oReport:Section(1)
Local oSection2    := oReport:Section(2)

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Guarda aquivo e indices correntes    ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cAlias	:= Alias()
Local nOldOrder := IndexOrd()
Local nOldSA5   := 0 
Local nOldSA2   := 0
Local nOldQEV   := 0
Local nOldQE6   := 0
Local nOldQEG   := 0
Local nRecAnt   := 0
Local nRec      := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando areas de trabalho                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SA5")             // PRODUTOxFORNECEDOR
nOldSA5 := SA5->(IndexOrd())
SA5->(dbSetOrder(2))                      // Filial/Produto/fornecedor/loja
dbSelectArea("SA2")             // Cadastro de Fornecedor
nOldSA2 := SA2->(IndexOrd())
SA2->(dbSetOrder(1))                     // Filial/Codigo/Loja
dbSelectArea("QEV")             // Relatorio de Indice de Qualidade
nOldQEV := QEV->(IndexOrd())
QEV->(dbSetOrder(4))                      // Filial/Fornecedor/Produto/Ano/Mes
dbSelectArea("QE6")             // Cadastro de Produto
nOldQE6 := QE6->(IndexOrd())
QE6->(dbSetOrder(1))                      // Filial/Codigo
dbSelectArea("QEG")             // Classes e Situacao Fornecedores
nOldQEG := QEG->(IndexOrd())
QEG->(dbSetOrder(1))                     // Filial/Stuacao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros						 ³
//³ mv_par01			  // Produto de   						 ³
//³ mv_par02			  // Produto ate    	    			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

dbSelectArea("QEV")                //Seleciona arquivo de Prod X Forn
QEV->(dbSeek(xFilial("QEV")+mv_par01,.T.))
oReport:SetMeter(QEV->(RecCount()))

While QEV->(!Eof()) .and. QEV->QEV_PRODUT <= mv_par02 ;
				.And. xFilial("QEV") == QEV->QEV_FILIAL
	
	If oReport:Cancel()
		Exit
	EndIf
	oReport:IncMeter()	

	cQEV_PRODUT := QEV->QEV_PRODUT
	cQEV_FORNEC := QEV->QEV_FORNEC
	
	While cQEV_PRODUT == QEV->QEV_PRODUT .And. ;
				cQEV_FORNEC == QEV->QEV_FORNEC .And. !QEV->(Eof())
		cQEV_IQI  := QEV->QEV_IQI
		cQEV_IQIA := QEV->QEV_IQIA
		cQEV_IQIA := QEV->QEV_IQIA
		cQEV_IQF  := QEV->QEV_IQF
		cQEV_IQFA := QEV->QEV_IQFA
		cQEV_IQS  := QEV->QEV_IQS
		cQEV_ANO  := QEV->QEV_ANO
		cQEV_MES  := QEV->QEV_MES
		
		QEV->(dbSkip())

	EndDo
				
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona arquivo de Cadastro de produto                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	dbSelectArea("QE6")
  	QE6->(dbSeek(xFilial("QE6")+cQEV_PRODUT))
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona arquivo de Fornecedores                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SA2")
  	If !SA2->(dbSeek(xFilial("SA2")+cQEV_FORNEC))
		dbSelectArea("QEV")
		Loop
	EndIf	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona arquivo Fornc./Prod.       			           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SA5->(dbSetOrder(2))
	SA5->(dbSeek(xFilial("SA5")+cQEV_PRODUT+cQEV_FORNEC)) 
	cLoja := SA5->A5_LOJA

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona arquivo de Classe Fornc./Prod.                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QEG")             // Classes e Situacao Fornecedores
	QEG->(dbSeek(xFilial("QEG")+SA5->A5_SITU)) 
	
	oSection1:Init()   
	oReport:SkipLine(2)	
	oSection1:Cell("cProduto"):SetValue(AllTrim(SA5->A5_PRODUTO)+" - "+AllTrim(QE6->QE6_DESCPO))
	oSection1:PrintLine()
	oSection1:Finish()
	
	oSection2:Init()    
	
	oSection2:Cell("cNivel"):SetValue(QEG->QEG_NIVEL)
	oSection2:Cell("cRef"):SetValue(cQEV_MES+"/"+cQEV_ANO)

	oSection2:PrintLine()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existem outras lojas do mesmo fornecedor, amarrados ³
	//³ ao mesmo Produto: mostra somente a Situacao                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SA5")
	SA5->(dbSkip())
	While SA5->A5_FORNECE == cQEV_FORNEC .And. ;
			SA5->A5_PRODUTO == cQEV_PRODUTO .And. ;
			SA5->A5_FILIAL  == xFilial("SA5") .And. !Eof()			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona arquivo de Classe Fornc./Prod.                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("QEG")             // Classes e Situacao Fornecedores
	    QEG->(dbSeek(xFilial("QEG")+SA5->A5_SITU))
        
		cLoja := SA5->A5_LOJA
		
		oSection2:Cell("cFornecedor"):HIDE()
		oSection2:Cell("cQEV_IQI"):HIDE()
		oSection2:Cell("cQEV_IQIA"):HIDE()
		oSection2:Cell("cQEV_IQF"):HIDE()
		oSection2:Cell("cQEV_IQFA"):HIDE()
		oSection2:Cell("cQEV_IQS"):HIDE()
		oSection2:Cell("cRef"):HIDE()
	    oSection2:Cell("cFR"):SHOW()
	    oSection2:Cell("cCodFor"):SHOW()
	    oSection2:Cell("cNivel"):SHOW()

	    //oSection2:Cell("cFR"):SetValue(AllTrim(SA5->A5_FABREV))
	    //oSection2:Cell("cCodFor"):SetValue(AllTrim(SA5->A5_FORNECE)+"-"+SA5->A5_LOJA)
	    oSection2:Cell("cNivel"):SetValue(QEG->QEG_NIVEL)
		
		nRecAnt := SA5->(Recno())
		oSection2:PrintLine()
		nRec :=  SA5->(Recno())
		If nRecAnt <> nRec
			SA5->(dbSkip())
		EndIf	
		
		SA5->(dbSkip())
	EndDo
    
	oSection2:Cell("cFornecedor"):SHOW()
	oSection2:Cell("cQEV_IQI"):SHOW()
	oSection2:Cell("cQEV_IQIA"):SHOW()
	oSection2:Cell("cQEV_IQF"):SHOW()
	oSection2:Cell("cQEV_IQFA"):SHOW()
	oSection2:Cell("cQEV_IQS"):SHOW()
	oSection2:Cell("cRef"):SHOW()
	oSection2:Finish()
	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Obs. O dbSkip ja foi dado no while antes da impressao        ³
  	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	dbSelectArea("QEV")                //Seleciona arquivo de Prod X Forn
EndDo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura o arq anterior             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SA5")             // PRODUTOxFORNECEDOR
SA5->(dbSetOrder(nOldSA5))      // Filial/Produto/fornecedor/loja
dbSelectArea("SA2")             // Cadastro de Fornecedor
SA2->(dbSetOrder(nOldSA2))             // Filial/Codigo/Loja
dbSelectArea("QEV")             // Relatorio de Indice de Qualidade
QEV->(dbSetOrder(nOldQEV))             // Filial/Fornecedor/Produto/Ano/Mes
dbSelectArea("QE6")             // Cadastro de Produto
QE6->(dbSetOrder(nOldQE6))             // Filial/Codigo
dbSelectArea("QEG")             // Classes e Situacao Fornecedores
QEG->(dbSetOrder(nOldQEG))             // Filial/Stuacao

dbSelectArea(cAlias)
dbSetOrder(nOldOrder)

Return .T.