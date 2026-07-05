/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QNCR120.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QNCR120  ³ Autor ³ Leandro S. Sabino     ³ Data ³ 07/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime as Nao-Conformidades por Produto                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs:      ³ (Versao Relatorio Personalizavel) 		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQNC	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function QNCR120()
Local oReport

Pergunte("QNR120",.F.)
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
±±³ Uso      ³ QNCR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport                                             
Local oSection1 
Local oSection2
Local oTotaliz


oReport   := TReport():New("QNCR120",OemToAnsi(STR0001),"QNR120",{|oReport| PrintReport(oReport)},OemToAnsi(STR0002)+OemToAnsi(STR0003))
oReport:SetPortrait()
//"LISTA DE TRANSFERENCIA"##"Este programa ir  imprimir uma rela‡ao de transferencias"##"de acordo com os parƒmetros definidos pelo usu rio."

oSection1 := TRSection():New(oReport,OemToAnsi(STR0006),{"QI2"})
TRCell():New(oSection1,"QI2_FNC"   ,"QI2")
TRCell():New(oSection1,"QI2_REV"   ,"QI2") 
TRCell():New(oSection1,"QI2_OCORRE","QI2") 
TRCell():New(oSection1,"QI2_REGIST","QI2") 
TRCell():New(oSection1,"cClaNFC"  ,"",TitSX3("QI2_TPFIC")[1],,20)
TRCell():New(oSection1,"cCONREA"  ,"",TitSX3("QI2_CONREA")[1],,07,,{||IIf (Empty( (QI2->QI2_CONREA) ),STR0012, STR0013)}) //"Pendente"###"Baixada"

oSection2 := TRSection():New(oSection1,OemToAnsi(STR0020)) 
TRCell():New(oSection2,"cProduto"  ,"   ",OemToAnsi(STR0017),,20)	
TRCell():New(oSection2,"cBaixada"  ,"   ",OemToAnsi(STR0018),,20)
TRCell():New(oSection2,"cPendente" ,"   ",OemToAnsi(STR0019),,20)
TRCell():New(oSection2,"cTotal"    ,"   ",OemToAnsi(STR0020),,20)

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
Local cFiltro 
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
Local cAlias     := "" 

MakeAdvplExpr("QNR120")
              
DbSelectArea("QI2")
dbSetOrder(7)

cFiltro := "QI2_FILIAL == '" + xFilial("QI2") + "' .AND. "
cFiltro += "QI2_CODPRO >= '" + mv_par03 + "' .And. QI2_CODPRO <= '" + mv_par04 + "' .AND. "

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
cFiltro += "Dtos(" + cDesDat + ") >= '" + Dtos(mv_par08) + "' .And. Dtos(" + cDesDat + ") <= '" + Dtos(mv_par09) + "' "

oSection1:SetFilter(cFiltro)

While  QI2->(!Eof())

	If 	cCodProd <> QI2->QI2_CODPRO 
		cCodProd := QI2->QI2_CODPRO
		oSection1:Init()
		oReport:SkipLine(1) 
		oReport:ThinLine()
		oReport:PrintText((TitSx3("QI2_CODPRO")[1])+": "+QI2->QI2_CODPRO + " / " + AllTrim(FQNCDESPRO(cCodProd)),oReport:Row(),025) 
		oReport:SkipLine(1)	
		oReport:ThinLine()
	Endif

	nTotFNC    := 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Enquanto for o mesmo produto faz-se as somas e imprime os campos³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !Eof() .And. QI2->QI2_CODPRO == cCodProd
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Esse array traz todas as descricoes existentes no ComboBox do campo QI2_TPFIC. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aRetBox1   := RetSx3Box( Posicione('SX3', 2, 'QI2_TPFIC', 'X3CBox()' ),,, 1 )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Pega do array a descricao da NFC que foi pego pela funcao RetSx3Box.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cClaNFC := AllTrim( aRetBox1[ Ascan( aRetBox1, { |x| x[ 2 ] == QI2->QI2_TPFIC } ) , 3 ] )
		oSection1:Cell("cClaNFC"):SetValue(cClaNFC)
		
		// Pesquisa pelo produto no array aTotal
		nPos := Ascan( aTotal, {|x| AllTrim(x[1]) == AllTrim(cCodProd) })
		                                          
		nTotBaixa += IIf (Empty( (QI2->QI2_CONREA)),0,1) // Soma FNC Baixada
		nTotPende += IIf (Empty( (QI2->QI2_CONREA)),1,0) // Soma FNC Pendente

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Caso seja o mesmo produto soma quantidade, senao ³
		//³gera novo produto com a quantidade inicial.      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nPos > 0		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Soma NFC Baixada e FNC Pendente.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aTotal[nPos,2] += IIf (Empty( (QI2->QI2_CONREA)),0,1) // Soma FNC Baixada
			aTotal[nPos,3] += IIf (Empty( (QI2->QI2_CONREA)),1,0) // Soma FNC Pendente
			nTotBaixa := 0
			nTotPende := 0
		Else
			nTotBaixa -= IIf( nTotBaixa > 1, 1, 0)
			nTotPende -= IIf( nTotPende > 1, 1, 0)
			Aadd(aTotal,{cCodProd,nTotBaixa,nTotPende})
			nTotBaixa := 0                                                                    
			nTotPende := 0
		Endif	
		nTotFNC ++
		oSection1:PrintLine()
		("QI2")->(dbSkip())
	Enddo
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Gera total da quantidade de Produto.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:ThinLine()
	oReport:PrintText(OemToAnsi(STR0014)+"  "+Alltrim(Transform(nTotFNC,"99999")) +"  " +STR0015,oReport:Row(),025) 
	oReport:SkipLine(1)	
	oReport:ThinLine()
	oReport:SkipLine(1)	

Enddo

	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impressao do Subtotal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd(aTotGer,{0,0,0})
If Len(aTotal) > 0		
	oReport:SkipLine(1) 
	oReport:ThinLine()
	oReport:PrintText(OemToAnsi(STR0021),oReport:Row(),025) 
	oReport:SkipLine(1)	
	oReport:ThinLine()
	oSection2:Init()
	
	For nInd := 1 to Len(aTotal)	
		// Array contendo o total geral do relatorio
		aTotGer[Len(aTotGer),1] += aTotal[nInd,2]
		aTotGer[Len(aTotGer),2] += aTotal[nInd,3]
		aTotGer[Len(aTotGer),3] += aTotal[nInd,2] + aTotal[nInd,3]

		oSection2:Cell("cProduto"):SetValue(AllTrim(aTotal[nInd,1]))
		oSection2:Cell("cBaixada"):SetValue(Alltrim(Transform(aTotal[nInd,2],"99999")))
		oSection2:Cell("cPendente"):SetValue(Alltrim(Transform(aTotal[nInd,3],"99999")))
		oSection2:Cell("cTotal"):SetValue(Alltrim(Transform(aTotal[nInd,2] + aTotal[nInd,3] ,"99999")))
		oSection2:PrintLine()
	Next		
Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Total Geral.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:FatLine()                                 	
	oReport:PrintText(Alltrim(Transform(aTotGer[Len(aTotGer),1],"99999")),oReport:Row(),0305) 
	oReport:PrintText(Alltrim(Transform(aTotGer[Len(aTotGer),2],"99999")),oReport:Row(),0597) 
	oReport:PrintText(Alltrim(Transform(aTotGer[Len(aTotGer),3],"99999")),oReport:Row(),0893) 
	oReport:SkipLine(1) 
	oReport:FatLine()
	
	oReport:SkipLine(1)	
	oReport:ThinLine()
	
	oSection1:Finish()
	oSection2:Finish()

Return
