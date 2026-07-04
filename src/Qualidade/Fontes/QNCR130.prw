/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QNCR130.ch"
#include "PROTHEUS.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QNCR130  ³ Autor ³ Leandro S. Sabino     ³ Data ³ 07/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime as Nao-Conformidades por Projeto                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs:      ³ (Versao Relatorio Personalizavel) 		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQNC	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

User Function QNCR130()
Local oReport 
Private cPerg   := "QNR130"

Pergunte(cPerg,.F.)
oReport := ReportDef()
oReport:PrintDialog()
  
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 07/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport                                             
Local oSection1 
Local oSection2
Local oTotaliz

oReport   := TReport():New("QNCR130",OemToAnsi(STR0001),"QNR130",{|oReport| PrintReport(oReport)},OemToAnsi(STR0002)+OemToAnsi(STR0003))
oReport:SetPortrait()
//"Relacao de Nao-Conformidades por Projeto"##"Emite as Nao-Conformidades por Projeto"##"conforme os parametros informados"

oSection1 := TRSection():New(oReport,OemToAnsi(STR0030),{"QI2"}) // "Cabecalho FNC"
TRCell():New(oSection1,"QI2_FNC"    ,"QI2")
TRCell():New(oSection1,"QI2_REV"    ,"QI2",OemToAnsi(STR0025)  ,,03) 
TRCell():New(oSection1,"QI2_NUMAUD" ,"QI2",OemToAnsi(STR0026)  ,,08) 
TRCell():New(oSection1,"QI2_REGIST" ,"QI2") 
TRCell():New(oSection1,"cClaNFC"    ,"",TitSX3("QI2_TPFIC")[1] ,,20)
TRCell():New(oSection1,"cResp"      ,"",STR0029,,30)
TRCell():New(oSection1,"cStatus"    ,"",OemToAnsi(STR0027),,10,,{||IIf (Empty( QI2->QI2_CONREA ),OemToAnsi(STR0015),OemToAnsi(STR0016))}) //"Pendente"###"Baixada"
TRCell():New(oSection1,"cCausa"     ,"",OemToAnsi(STR0028),,40)


oSection2 := TRSection():New(oSection1,OemToAnsi(STR0024)) // "Total"
TRCell():New(oSection2,"cProjeto"  ,"   ",OemToAnsi(STR0021),,20)	
TRCell():New(oSection2,"cBaixada"  ,"   ",OemToAnsi(STR0022),,20)
TRCell():New(oSection2,"cPendente" ,"   ",OemToAnsi(STR0023),,20)
TRCell():New(oSection2,"cTotal"    ,"   ",OemToAnsi(STR0024),,20)

Return oReport


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 07/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1) 	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQNC                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport( oReport )
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local cCodProd   := ""
Local cDesDat    := ""
Local cClaNFC    := ""
Local nTotFNC    := 0
Local nTotBaixa  := 0
Local nTotPende  := 0
Local aRetBox1   := {}
Local aTotal     := {}
Local aTotGer    := {}
Local nPos       := 0
Local nInd       := 0
Local cbTxt	     := Space(10)  // Variavel do Rodape
Local cbCont     := 00 // Variavel do Rodape
Local cFiltro    := "" // Filtro do IndRegua
Local cInd       := ""
Local cKey       := ""
Local cAlias     := ""
Local nTotCAU    := 0 
Local aTotCAU	 := {}
Local nPosCAU	 := 0
Local cCodProj   := "" 

MakeAdvplExpr("QNR130")
              
DbSelectArea("QI2")
dbSetOrder(8)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Faz o filtro baseado nos parametros estabelecidos pelo usuario³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFiltro := "QI2_FILIAL >= '" + mv_par01 + "' .AND. QI2_FILIAL <= '" + mv_par02 + "' .AND. "
cFiltro += "QI2_PROJET >= '" + mv_par03 + "' .AND. QI2_PROJET <= '" + mv_par04 + "' .AND. "
If mv_par05 != 4 // Caso seja ambos nao aplica o filtro
	cFiltro += "QI2_TPFIC == '" + StrZero(mv_par05,Len(QI2->QI2_TPFIC)) + "' .AND. "
EndIf
If mv_par06 != 3 // Caso seja ambos nao aplica o filtro
	If mv_par06 == 1 // Pendente
		If Upper(TcGetDb()) $ "DB2/400"
			cFiltro += "Dtos(QI2_CONREA)=='        ' .AND. "
		Else
			cFiltro += "Empty(Dtos(QI2_CONREA)) .AND. "
		Endif	
	Else
		If Upper(TcGetDb()) $ "DB2/400"
		    cFiltro += "Dtos(QI2_CONREA)=='        ' .AND. "
		Else
			cFiltro += "!Empty(Dtos(QI2_CONREA)) .AND. "
		Endif
	EndIf
EndIf
// Verifica se filtra pela Data de Registro ou pela Data de Ocorrencia
cDesDat := IIf ( mv_par07 == 1, "QI2_OCORRE", "QI2_REGIST" )
cFiltro += "Dtos(" + cDesDat + ") >= '" + Dtos(mv_par08) + "' .And. Dtos(" + cDesDat + ") <= '" + Dtos(mv_par09) + "' .AND. "
// filtra pela Causa
cFiltro += "QI2_CODCAU >= '" + mv_par10 + "' .And. QI2_CODCAU <= '" + mv_par11 + "' "

oSection1:SetFilter(cFiltro)

While  QI2->(!Eof())

	If 	cCodProj <> QI2->QI2_PROJET 
		cCodProj   := QI2->QI2_PROJET
		oSection1:Init()
		oReport:SkipLine(1) 
		oReport:ThinLine()
		oReport:PrintText((TitSx3("QI2_PROJET")[1])+": "+QI2->QI2_PROJET,oReport:Row(),025) 
		oReport:SkipLine(1)	
		oReport:ThinLine()
	Endif

	nTotFNC	:= 0
	nTotCAU	:= 0
	cCodCau := QI2->QI2_CODCAU
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Enquanto for o mesmo produto faz-se as somas e imprime os campos³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !Eof() .And. QI2->QI2_PROJET == cCodProj
		IF  cCodCau!= QI2->QI2_CODCAU
		   	IF mv_par12==1
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Gera total da causa de Projeto.³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	 			oReport:SkipLine(1) 
				oReport:FatLine()
				oReport:PrintText(OemToAnsi(STR0011)+Alltrim(cCodCau)+" - "+Alltrim(FQNCNTAB("1",cCodCau))+" = "+Alltrim(Transform(nTotCAU,"99999")) + OemToAnsi(STR0012),oReport:Row(),025) //"TOTAL DA CAUSA ===> "###" FICHA(S)"
				oReport:SkipLine(1)	
			Endif	

			nPosCAU:=Ascan(aTotCAU,{|X| X[1]==cCodCau})
			
			IF nPosCAU == 0 
				Aadd(aTotCAU,{cCodCau,nTotCAU})
			Else
				aTotCAU[nPosCAU,2]+=nTotCAU 
			Endif	
		
			nTotCAU	:=0
			cCodCau	:= QI2->QI2_CODCAU
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Esse array traz todas as descricoes existentes no ComboBox do campo QI2_TPFIC. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aRetBox1   := RetSx3Box( Posicione('SX3', 2, 'QI2_TPFIC', 'X3CBox()' ),,, 1 )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Pega do array a descricao da NFC que foi pego pela funcao RetSx3Box.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cClaNFC := AllTrim( aRetBox1[ Ascan( aRetBox1, { |x| x[ 2 ] == QI2->QI2_TPFIC } ) , 3 ] )
         
		oSection1:Cell("cClaNFC"):SetValue(cClaNFC)
	  	oSection1:Cell("cResp"):SetValue(QI2->QI2_FILRES+"-"+QI2->QI2_MATRES+"-"+Alltrim(QA_NUSR(QI2->QI2_FILRES,QI2->QI2_MATRES,.T.,"A")))
		oSection1:Cell("cCausa"):SetValue(QI2->QI2_CODCAU+" "+Alltrim(FQNCNTAB("1",QI2->QI2_CODCAU)))
		
	
		// Pesquisa pelo produto no array aTotal
		nPos := Ascan( aTotal, {|x| AllTrim(x[1]) == AllTrim(cCodProj) })
		
		nTotBaixa += IIf (Empty( QI2->QI2_CONREA),0,1) // Soma FNC Baixada
		nTotPende += IIf (Empty( QI2->QI2_CONREA),1,0) // Soma FNC Pendente
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Caso seja o mesmo projeto soma quantidade, senao ³
		//³gera novo produto com a quantidade inicial.      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nPos > 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Soma NFC Baixada e FNC Pendente.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aTotal[nPos,2] += IIf (Empty( QI2->QI2_CONREA),0,1) // Soma FNC Baixada
			aTotal[nPos,3] += IIf (Empty( QI2->QI2_CONREA),1,0) // Soma FNC Pendente
			nTotBaixa := 0
			nTotPende := 0
		Else
			nTotBaixa -= IIf( nTotBaixa > 1, 1, 0)
			nTotPende -= IIf( nTotPende > 1, 1, 0)
			Aadd(aTotal,{cCodProj,nTotBaixa,nTotPende})
			nTotBaixa := 0
			nTotPende := 0
		Endif
		nTotFNC ++
		nTotCAU ++		
		
		oSection1:PrintLine()
		("QI2")->(dbSkip())

	EndDo

	nPosCAU:=Ascan(aTotCAU,{|X| X[1]==cCodCau})
	IF nPosCAU == 0 
		Aadd(aTotCAU,{cCodCau,nTotCAU})
	Else
		aTotCAU[nPosCAU,2]+=nTotCAU 
	Endif	

	IF mv_par12==1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Gera total da causa de Projeto.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:ThinLine()
		oReport:PrintText(OemToAnsi(STR0011)+Iif(!empty(cCodCau),cCodCau,SPACE(8))+" - "+;
			         IIf(!Empty(cCodCau),FQNCNTAB("1",cCodCau),SPACE(TAMSX3("QI0_DESC")[1]))+" = "+;
			         Alltrim(Transform(nTotCAU,"99999")) + OemToAnsi(STR0012),oReport:Row(),025) //"TOTAL DA CAUSA ===> "###" FICHA(S)" 
		oReport:SkipLine(1)	
		oReport:ThinLine()
		oReport:SkipLine(1)	
		nTotCAU	:=0
		cCodCau	:=QI2->QI2_CODCAU
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Gera total da quantidade de Projeto.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:ThinLine()
	oReport:PrintText(OemToAnsi(STR0017)+Alltrim(cCodProj)+" = "+Alltrim(Transform(nTotFNC,"99999")) + OemToAnsi(STR0012),oReport:Row(),025) //"TOTAL POR PROJETO ===> "###" FICHA(S)"
	oReport:SkipLine(1)	
	oReport:ThinLine()
	oReport:SkipLine(1)	
EndDo


If Len(aTotal) > 0		
	oReport:SkipLine(1) 
	oReport:ThinLine()
	oReport:PrintText(OemToAnsi(STR0020),oReport:Row(),025) //Total Geral
	//oReport:SkipLine(1)	
	oSection2:Init()
	Aadd(aTotGer,{0,0,0})
	For nInd := 1 to Len(aTotal)	
		// Array contendo o total geral do relatorio
		aTotGer[Len(aTotGer),1] += aTotal[nInd,2]
		aTotGer[Len(aTotGer),2] += aTotal[nInd,3]
		aTotGer[Len(aTotGer),3] += aTotal[nInd,2] + aTotal[nInd,3]
	
		oSection2:Cell("cProjeto"):SetValue(AllTrim(aTotal[nInd,1]))
		oSection2:Cell("cBaixada"):SetValue(Alltrim(Transform(aTotal[nInd,2],"99999")))
		oSection2:Cell("cPendente"):SetValue(Alltrim(Transform(aTotal[nInd,3],"99999")))
		oSection2:Cell("cTotal"):SetValue(Alltrim(Transform(aTotal[nInd,2] + aTotal[nInd,3] ,"99999")))
		oSection2:PrintLine()
	Next		
Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total Geral³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
If len(aTotGer) >0
	oReport:FatLine()                                 	
	oReport:PrintText(Alltrim(Transform(aTotGer[Len(aTotGer),1],"99999")),oReport:Row(),0305) 
	oReport:PrintText(Alltrim(Transform(aTotGer[Len(aTotGer),2],"99999")),oReport:Row(),0597) 
	oReport:PrintText(Alltrim(Transform(aTotGer[Len(aTotGer),3],"99999")),oReport:Row(),0893) 
	oReport:SkipLine(1) 
	oReport:FatLine()
Endif    

oReport:SkipLine(2) 
oReport:SkipLine(1)

If len(aTotCAU) >0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total Geral da Causa³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:ThinLine()
	oReport:PrintText(OemToAnsi(STR0019),oReport:Row(),025) 
	oReport:SkipLine(1)	
	oReport:ThinLine()
	    

	For nInd := 1 to Len(aTotCAU)
		oReport:PrintText(IIf(!empty(aTotCAU[nInd,1]),aTotCAU[nInd,1],SPACE(8))+" - "+iif(!Empty(aTotCAU[nInd,1]),FQNCNTAB("1",aTotCAU[nInd,1]),SPACE(TAMSX3("QI0_DESC")[1]))+" = "+Alltrim(Transform(aTotCAU[nInd,2],"99999")) + OemToAnsi(STR0012),oReport:Row(),025) 
		oReport:SkipLine(1)	
	Next
	oReport:FatLine()          
Endif

	oSection1:Finish()
	oSection2:Finish()

Return
