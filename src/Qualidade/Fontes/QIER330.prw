/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIER330.CH"
#Include "PROTHEUS.CH"
#Include "REPORT.CH"  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIER330  ³ Autor ³ Leandro S. Sabino     ³ Data ³ 30/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Amarracao Produto X Cliente     			                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs:      ³ (Versao Relatorio Personalizavel) 		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER330	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function QIER330()
Local oReport
Private cPerg	:= "QER330"

/*----------------------------------------------
Variaveis utilizadas para parametros
mv_par01             // Cliente De
mv_par02             // Loja do Cliente de
mv_par03             // Cliente Ate
mv_par04             // Loja do Cliente ate
----------------------------------------------*/
Pergunte(cPerg,.F.)
oReport := ReportDef()
oReport:PrintDialog()
   
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 30.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER330                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport                                             
Local oSection1 
Local oSection2 

oReport   := TReport():New("QIER330",OemToAnsi(STR0003),"QER330",{|oReport| PrintReport(oReport)},OemToAnsi(STR0001)+OemToAnsi(STR0002))
oReport:SetLandscape(.T.)
//"Amarracao Produto x Cliente"##"Serao relacionados os Clientes com seus "##"respectivos Produtos."

oSection1 := TRSection():New(oReport,OemToAnsi(TitSX3("A7_PRODUTO")[1]),{"SA7","SA1"})
TRCell():New(oSection1,"A7_PRODUTO" ,"SA7") 
TRCell():New(oSection1,"cDESCPO"    ,"   ",TitSX3("QE6_DESCPO")[1] ,,40,,{|| })
TRPosition():New(oReport:Section(1),"SA1", 1, {|| xFilial("SA1")+SA7->A7_CLIENTE+SA7->A7_LOJA})


oSection2 := TRSection():New(oSection1,OemToAnsi(TitSX3("QF6_PLAMO")[1]),{"QE6","QF6","SB1"}) //"Amarracao Produto x Cliente"
TRCell():New(oSection2,"cOP"  	  ,"QF6",TitSX3("QF6_ENSAIO")[1] ,,08,,{|| })//"ENSAIO"
TRCell():New(oSection2,"cTIPAMO" ,"QF6",TitSX3("QF6_TIPAMO")[1] ,,14,,{|| })//"DESCR.PL. AMOSTRAGEM"
TRCell():New(oSection2,"cPLAMO"  ,"QF6",TitSX3("QF6_PLAMO")[1]  ,,02,,{|| })//"PLANO AMOSTRAGEM"
TRCell():New(oSection2,"cNQA"  	  ,"QF6",TitSX3("QF6_NQA")[1]    ,,05,,{|| })//"NQA"
TRCell():New(oSection2,"cNIVEL"  ,"QF6",TitSX3("QF6_NIVEL")[1]  ,,02,,{|| })//"NIVEL"
TRPosition():New(oReport:Section(1):Section(1),"SB1", 1, {|| xFilial("SB1")+SA7->A7_PRODUTO})

Return oReport


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ RF080Imp      ³ Autor ³ Leandro Sabino   ³ Data ³ 22.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ RF080Imp(ExpO1)   	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR080                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport( oReport )
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local cUltRev    := " "
Local cPlano     := " "  
Local cCli       := " "
Local lFirst 	 := .T.

MakeAdvplExpr(oReport:uParam)

cFiltro:= 'A7_FILIAL==   "' +xFilial("SA7")+'" .And. '
cFiltro+= 'A7_CLIENTE >= "' +mv_par01      +'" .And. A7_CLIENTE <= "' +mv_par03+'".And. '
cFiltro+= 'A7_LOJA >=    "' +mv_par02      +'" .And. A7_LOJA <=    "' +mv_par04+'"'

oSection1:SetFilter(cFiltro,"A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO")

dbSelectArea("SA7")
SA7->(DbGOTOP())

While !oReport:Cancel() .And. SA7->(!Eof())

	//Primeira Secao	
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("SA7")))
		If !SA7->(&(oReport:Section(1):GetAdvplExp("SA7")))
			SA7->(dbSkip())   
			cCli := SA7->A7_CLIENTE
			Loop
		Endif
	EndIf

	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("SA1")))
		If !SA1->(&(oReport:Section(1):GetAdvplExp("SA1")))
			SA7->(dbSkip())       
			cCli := SA7->A7_CLIENTE
			Loop
		Endif
	EndIf

	//Segunda Secao
	If !Empty(AllTrim(oReport:Section(1):Section(1):GetAdvplExp("SB1")))
		If !SB1->(&(oReport:Section(1):Section(1):GetAdvplExp("SB1")))
			SA7->(dbSkip())       
			cCli := SA7->A7_CLIENTE			
			Loop
		Endif
	EndIf


	If !Empty(AllTrim(oReport:Section(1):Section(1):GetAdvplExp("QE6")))
		If !QE6->(&(oReport:Section(1):Section(1):GetAdvplExp("QE6")))
			SA7->(dbSkip())       
			cCli := SA7->A7_CLIENTE			
			Loop
		Endif
	EndIf


	If !Empty(AllTrim(oReport:Section(1):Section(1):GetAdvplExp("QF6")))
		If !QF6->(&(oReport:Section(1):Section(1):GetAdvplExp("QF6")))
			SA7->(dbSkip())       
			cCli := SA7->A7_CLIENTE			
			Loop
		Endif
	EndIf

	If 	cCli <> SA7->A7_CLIENTE
		oSection1:Finish()
		oSection1:Init()
		oReport:SkipLine(1) 
		oReport:ThinLine()
		dbSelectArea("SA1")
		SA1->(dbSetOrder(1))
		SA1->(dbSeek(xFilial("SA1")+SA7->A7_CLIENTE+SA7->A7_LOJA))
		oReport:PrintText((TitSx3("A7_CLIENTE")[1])+": "+SA7->A7_CLIENTE+ " - " + AllTrim(SA7->A7_LOJA) +" - " + SA1->A1_NOME,oReport:Row(),025) 
		oReport:SkipLine(1)	
		oReport:ThinLine()
	Endif
	
	cCli := SA7->A7_CLIENTE	

	cCliAnt := SA7->A7_CLIENTE+SA7->A7_LOJA
	
	While !Eof() .and. SA7->A7_FILIAL+SA7->A7_CLIENTE+SA7->A7_LOJA == xFilial("SA7")+cCliAnt

		dbSelectArea("QE6")
		QE6->(dbSetOrder(1))
		If QE6->(dbseek(xFilial("QE6") + SA7->A7_PRODUTO))
			oSection1:Cell("cDESCPO"):SetValue(QE6->QE6_DESCPO)
 	    Else 
 	    	oSection1:Cell("cDESCPO"):SetValue("")
 	    EndIf
        
		oSection1:PrintLine()

   		lFirst  := .T.
		cUltRev	:= QA_UltRevEsp(SA7->A7_PRODUTO,dDataBase,.F.,,"QIE")

		dbSelectArea("QF6")
		QF6->(dbSetOrder(1))
		QF6->(dbSeek(xFilial("QF6")+SA7->A7_CLIENTE+SA7->A7_LOJA+SA7->A7_PRODUTO+cUltRev,.T.))   
		
		While QF6->(!Eof()) .And. xFilial("QF6") == QF6->QF6_FILIAL .And.;
			(QF6->QF6_CLIENT+QF6->QF6_LOJCLI+QF6->QF6_PRODUT+QF6->QF6_REVI) ==;
			(SA7->A7_CLIENTE+SA7->A7_LOJA+SA7->A7_PRODUTO+cUltRev)
         
       	    //Descricao do plano de Amostragem	
			If QF6->QF6_TIPAMO=="1"			
				cPlano := STR0018 //"NBR5426"
			ElseIf QF6->QF6_TIPAMO=="2"			
			    cPlano := STR0019 //"Zero Defeito"
			ElseIf QF6->QF6_TIPAMO=="3"			
				cPlano := STR0020 //"Plano Interno"
			ElseIf QF6->QF6_TIPAMO=="4"			
				cPlano := STR0020 //"Plano Interno"
			Else          
				cPlano := STR0022 //"NBR5429"
			EndIf              
			
			If lFirst
				oSection2:Finish()
				oSection2:Init()  
				lFirst := .F.
			Endif
	
			oSection2:Cell("cOP"):SetValue(QF6->QF6_ENSAIO)
			oSection2:Cell("cTIPAMO"):SetValue(cPlano)
			oSection2:Cell("cPLAMO"):SetValue(QF6->QF6_PLAMO)
			oSection2:Cell("cNQA"):SetValue(QF6->QF6_NQA)
			oSection2:Cell("cNIVEL"):SetValue(QF6->QF6_NIVEL)			
			oSection2:PrintLine() 
		
			QF6->(dbSkip())			
		EndDo

		dbSelectArea("SA7")
		SA7->(dbSkip())
	EndDo	
EndDo

dbSelectArea("SA7")
Set Filter To
dbSetOrder(1)

Return