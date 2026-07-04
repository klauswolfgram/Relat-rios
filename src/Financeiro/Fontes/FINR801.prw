/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR801.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "fwcommand.ch"

Static _oCTBR8011

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Finr801	³ Autor ³ Claudio D. de Souza   ³ Data ³ 25.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Comparativo de Movto. de titulos de clientes ate 6 meses    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Finr801()                                			 		     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum        											 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ SigaFin     											  				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr801()

Local oReport
Local aArea := GetArea()

oReport := ReportDef()
oReport:PrintDialog()

RestArea(aArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marcio Menon          ³ Data ³ 24/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oSection2
Local oSecFil	:= Nil
Local cReport 	:= "FINR801" 			// Nome do relatorio
Local cDescri 	:= STR0001 + " " +; 	//"Este programa imprimirá o Comparativo dos movimentos de Clientes"
				   STR0002 +;			//"até 6 meses.  Os valores são ref. as movimentações de títulos   "
				   STR0003 				//" no periodo solicitado. "
Local cTitulo 	:= STR0004 				//"Comparativo de movimentos de Clientes até 6 meses"
Local cPerg		:= "FIN801"				// Nome do grupo de perguntas

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport, cPerg, cTitulo)}, cDescri)
oReport:lDisableOrientation := .T.
oReport:SetLandscape() 	//Formata a impressao para paisagem

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³                      Definicao das Secoes                              ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 01                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport, STR0021, {"TRB"})

TRCell():New(oSection1, "CODIGO"    , "TRB", STR0011 , PesqPict("SE1","E1_CLIENTE"), TamSX3("E1_CLIENTE")[1],/*lPixel*/,{|| TRB->CLIENTE})		//"CODIGO"
TRCell():New(oSection1, "LOJA"      , "TRB", "LJ"    , PesqPict("SE1","E1_LOJA")   , 02 ,/*lPixel*/,{|| TRB->LOJA})
TRCell():New(oSection1, "NOME"      , "TRB", STR0012 , PesqPict("SA1","A1_NOME")   , 35 ,/*lPixel*/,{|| TRB->NOME})	//"N  O  M  E"
TRCell():New(oSection1, "TXTPREV"   , "TRB", STR0015 , /*Picture*/ , 11 ,/*lPixel*/,{|| TRB->TXTPREV}) 					//"Previsto ->"
TRCell():New(oSection1, "PREVPER01" , "TRB", SubStr(STR0013,004,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->PREVPER01}) 	//"MOV. PERIODO 01"
TRCell():New(oSection1, "PREVPER02" , "TRB", SubStr(STR0013,026,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->PREVPER02})		//"MOV. PERIODO 02"
TRCell():New(oSection1, "PREVPER03" , "TRB", SubStr(STR0013,048,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->PREVPER03})		//"MOV. PERIODO 03"
TRCell():New(oSection1, "PREVPER04" , "TRB", SubStr(STR0013,070,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->PREVPER04})		//"MOV. PERIODO 04"
TRCell():New(oSection1, "PREVPER05" , "TRB", SubStr(STR0013,092,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->PREVPER05})		//"MOV. PERIODO 05"
TRCell():New(oSection1, "PREVPER06" , "TRB", SubStr(STR0013,114,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->PREVPER06})		//"MOV. PERIODO 06"
TRCell():New(oSection1, "TOTPREVPER", "TRB", SubStr(STR0013,136,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->TOTPREVPER})	//"TOTAL  GERAL"

//Faz o alinhamento do cabecalho das celulas
oSection1:Cell("CODIGO"    ):SetHeaderAlign("CENTER")
oSection1:Cell("LOJA"      ):SetHeaderAlign("CENTER")
oSection1:Cell("NOME"      ):SetHeaderAlign("CENTER")
oSection1:Cell("PREVPER01" ):SetHeaderAlign("CENTER")
oSection1:Cell("PREVPER02" ):SetHeaderAlign("CENTER")
oSection1:Cell("PREVPER03" ):SetHeaderAlign("CENTER")
oSection1:Cell("PREVPER04" ):SetHeaderAlign("CENTER")
oSection1:Cell("PREVPER05" ):SetHeaderAlign("CENTER")
oSection1:Cell("PREVPER06" ):SetHeaderAlign("CENTER")
oSection1:Cell("TOTPREVPER"):SetHeaderAlign("CENTER")

oSection1:SetHeaderPage(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 02                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oReport,STR0022, {"TRB"})

TRCell():New(oSection2, "CODIGO"    , "TRB", STR0011 , PesqPict("SE1","E1_CLIENTE"), TamSX3("E1_CLIENTE")[1],/*lPixel*/,{|| TRB->CLIENTE})		//"CODIGO"
TRCell():New(oSection2, "LOJA"      , "TRB", "LJ"    , PesqPict("SE1","E1_LOJA")   , 02 ,/*lPixel*/,{|| TRB->LOJA})
TRCell():New(oSection2, "NOME"      , "TRB", STR0012 , PesqPict("SA1","A1_NOME")   , 35 ,/*lPixel*/,{|| TRB->NOME})	//"N  O  M  E"
TRCell():New(oSection2, "TXTREAL"   , "TRB", STR0016 , /*Picture*/ , 11 ,/*lPixel*/,{|| TRB->TXTREAL})						//"Realizado->"
TRCell():New(oSection2, "REALPER01" , "TRB", SubStr(STR0013,004,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->REALPER01})		//"MOV. PERIODO 01"
TRCell():New(oSection2, "REALPER02" , "TRB", SubStr(STR0013,026,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->REALPER02})		//"MOV. PERIODO 01"
TRCell():New(oSection2, "REALPER03" , "TRB", SubStr(STR0013,048,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->REALPER03})		//"MOV. PERIODO 01"
TRCell():New(oSection2, "REALPER04" , "TRB", SubStr(STR0013,070,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->REALPER04})		//"MOV. PERIODO 01"
TRCell():New(oSection2, "REALPER05" , "TRB", SubStr(STR0013,092,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->REALPER05})		//"MOV. PERIODO 01"
TRCell():New(oSection2, "REALPER06" , "TRB", SubStr(STR0013,114,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->REALPER06})		//"MOV. PERIODO 01"
TRCell():New(oSection2, "TOTREALPER", "TRB", SubStr(STR0013,136,15), Tm(0,17) , 23,/*lPixel*/,{|| TRB->TOTREALPER})	//"TOTAL  GERAL"

//Oculta as celulas para nao sair na impressao
oSection2:Cell("CODIGO"):Hide()
oSection2:Cell("LOJA"):Hide()
oSection2:Cell("NOME"):Hide()

//Nao imprime o cabeçalho da secao 2
oSection2:SetHeaderSection(.F.)

/*GESTAO - inicio */
/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
TRCell():New(oSecFil,"CODFIL" ,,STR0023,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0024,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0025,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0026,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"
/* GESTAO - fim*/

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor³ Marcio Menon       º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime o objeto oReport definido na funcao ReportDef.     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto TReport do relatorio                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport, cPerg, cTitulo)

Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local nCont			:= 0
Local lOk			:= .F.
Local nPer			:= 0
Local cAliasTmp		:= ""
Local cArqTrb		:= ""
Local cArqInd2		:= ""
Local cArqInd3		:= ""
Local cArqInd4		:= ""
Local nPrevisto		:= 0
Local nRealizado	:= 0
Local nImpressos	:= 0
Local cFilterUser	:= ""
Local nDecs     	:= MsDecimais(Val(mv_par07))
Local nMoedaBco 	:= 1
Local aStru 		:= {}
Local cabec1		:= ""
Local cabec2		:= ""
Local aCabecMes		:= {}
Local aCabecDat		:= {}
Local nMeses		:= 1
Local aPeriodos		:= {}
Local dDataIni		:= CTOD("//")
Local aCtbMoeda		:= {}
Local aMeses		:= {}
Local nDivide		:= 1

//Gestao
Local cFilAtu 	:= cFilAnt
Local lGestao   := ( FWSizeFilial() > 2 ) 	// Indica se usa Gestao Corporativa
Local lSA1Excl  := Iif( lGestao, FWModeAccess("SA1",1) == "E", FWModeAccess("SA1",3) == "E")
Local lSE1Excl  := Iif( lGestao, FWModeAccess("SE1",1) == "E", FWModeAccess("SE1",3) == "E")
Local lSE5Excl  := Iif( lGestao, FWModeAccess("SE5",1) == "E", FWModeAccess("SE5",3) == "E")
Local lQuery 	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Local aSelFil 	:= {}
Local aTmpFil	:= {}
Local cTmpSE1Fil := ""
Local cTmpSE5Fil := ""
Local bWhile 	:= {|| .T. }
Local nX 		:= 0
Local cQuery	:= ""
Local cAliasSE5	:= "SE5"
Local oSecFil	:= oReport:Section("SECFIL")
Local nTmp := 0 //contador para exclusão das tabelas temp criadas no banco.

Pergunte(cPerg,.F.)

If mv_par10 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par10 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par10 == 4		// Divide por milhao
	nDivide := 1000000
EndIf

//Gestao
//Selecao de filiais
nRegSM0 := SM0->(Recno())
If lQuery .and. lSE1Excl .and. lSE5Excl .and. mv_par14 == 1
	aSelFil := FwSelectGC()
Endif
If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif
SM0->(DbGoTo(nRegSM0))

If Len(aSelFil) > 1
	cRngFilSE1 := GetRngFil( aSelFil, "SE1", .T., @cTmpSE1Fil )
	aAdd(aTmpFil, cTmpSE1Fil)
	cRngFilSE5 := GetRngFil( aSelFil, "SE5", .T., @cTmpSE5Fil )
	aAdd(aTmpFil, cTmpSE5Fil)
Endif

// Imprime a lista de filiais selecionadas para o relatorio
If Len(aSelFil) > 1
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0027 + ")")		//"Filiais selecionadas para o relatorio"
	oSecFil:Init()
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
	For nX := 1 To Len(aSelFil)
		nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX]})
		If nLinha > 0
			cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
			oSecFil:PrintLine()
		Endif
	Next nX
	oReport:SetTitle(cTitulo)
	oSecFil:Finish()
	oReport:EndPage()
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o cabecalho                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par08 == 1 // Se considera periodos contabeis
	aCtbMoeda  	:= CtbMoeda(mv_par07,nDivide)
	If Empty(aCtbMoeda[1])
      Help(" ",1,"NOMOEDA")
      Return .F.
   Endif
	aPeriodos := ctbPeriodos(mv_par07, mv_par01, mv_par02, .T., .F.)
Else
	// Monta tabela de periodos baseado nas datas inicial e final
	dDataIni  := mv_par01
	For nCont := 1 To 6
		// Monta data inicial e final do periodo
		Aadd(aPeriodos,{FirstDay(dDataIni),LastDay(dDataIni)})
		dDataIni := Ctod("01/"+	StrZero(If(Month(dDataIni)==12,1,Month(dDataIni)+1),2)+"/"+;
									   StrZero(Year(dDataIni)+If(Month(dDataIni)==12,1,0),4),"dd/mm/yyyy") // Proximo periodo
	Next nCont
Endif

For nCont := 1 to len(aPeriodos)
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If aPeriodos[nCont][1] >= If(mv_par08==1,mv_par01,FirstDay(mv_par01)) .And. ;
		aPeriodos[nCont][2] <= If(mv_par08==1,mv_par02,LastDay(mv_par02))
		If nMeses <= 6
			AADD(aMeses,{StrZero(nMeses,2),aPeriodos[nCont][1],aPeriodos[nCont][2]})
		EndIf
		nMeses += 1
	EndIf
Next nCont

// nMeses sera igual a 1 quando nenhum calendario estiver dentro do periodo solicitado
If nMeses == 1
	MsgAlert(STR0007) //"O período solicitado nao confere com o calendario contabil. Favor refazer o calendario contábil."
	Return .F.
ElseIf nMeses > 7
	//Se o periodo solicitado for maior que 6 meses, eh exibida uma mensagem que sera im-
	//presso somente de 6 meses
	MsgAlert(STR0008) //"O período solicitado ultrapassa o limite de 6 meses. Será impresso somente os 6 meses a partir da data inicial."
EndIf

cTitulo += 	STR0009 + DTOC(mv_par01) + STR0010 + Dtoc(aMeses[Len(aMeses)][3])				 //" de "###" a "
cTitulo += " "+	If(mv_par12 == 1,STR0017,; //"Em ordem de codigo"
			 	  	If(mv_par12 == 2,STR0018,; //"Em ordem de Previsto
			 		If(mv_par12 == 3,STR0019,; //"Em ordem de Realizado"
			 		If(mv_par12 == 4,STR0020,"")))) //"Em ordem de Previsto+Realizado"
cabec1 := "|"+Padc(STR0011,14)+"|"+PadC(STR0012,51)+"|" //"CODIGO"###"N  O  M  E"
// Para  periodos contabeis, o cabecalho utilizara periodos 01 a 06, devido o usuario
// poder informar datas fora da data inicial do periodo
If mv_par08 == 1
	cabec1 += STR0013 //"   MOV. PERIODO 01   |   MOV. PERIODO 02   |   MOV. PERIODO 03   |   MOV. PERIODO 04   |   MOV. PERIODO 05   |   MOV. PERIODO 06   |      TOTAL  GERAL |"
Else // Caso contrario, utiliza meses cheios (01 a fim do mes)
	// Cria a primeira linha do cabecalho com os meses dos periodos
	For nCont := 1 to Len(aMeses)
		//Monta os meses Jan, Fev, Mar, Abr...
		cabec1+=(PadC(Upper(MesExtenso(Month(aMeses[nCont][2]))), 21)+"|")
		aAdd(aCabecMes,MesExtenso(Month(aMeses[nCont][2])))
	Next nCont
	// completa a primeira linha do cabecalho ate 6 periodos
	For nCont := nCont To 6
		cabec1 += SPACE(21)+"|"
	Next nCont
	Cabec1 += STR0014 //"      TOTAL  GERAL |"
Endif
cabec2 := "|"+Space(14)+"|"+Space(51)+"|"
// Cria a segunda linha do cabecalho com as datas dos periodos
For nCont := 1 to Len(aMeses)
	//Monta as Datas 00/00/00-00/00/00
	cabec2+=SPACE(2)+DTOC(aMeses[nCont][2])+"-"+DTOC(aMeses[nCont][3]) +SPACE(2)+"|"
	aAdd(aCabecDat,DTOC(aMeses[nCont][2])+"-"+DTOC(aMeses[nCont][3]))
Next nCont
// Completa a segunda linha do cabecalho
For nCont := nCont To 7
	If nCont <= 6
		cabec2+=SPACE(21)+"|"
	Else
		cabec2+=SPACE(19)+"|"
	Endif
Next nCont

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o arquivo temporário TRB                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd( aStru, {	"CLIENTE","C",TamSx3("E1_CLIENTE")[1], 0 } )
Aadd( aStru, {	"NOME"   ,"C",TamSx3("A1_NOME")[1], 0 } )
Aadd( aStru, {	"LOJA"   ,"C",TamSx3("E1_LOJA")[1], 0 } )
For nCont := 1 To 6
	Aadd( aStru, {	"PREVPER"+StrZero(nCont,2),"N",18, 2 } )
	Aadd( aStru, {	"REALPER"+StrZero(nCont,2),"N",18, 2 } )
Next nCont
Aadd( aStru, {	"TOTPREVPER","N",18, 2 } )
Aadd( aStru, {	"TOTREALPER","N",18, 2 } )
Aadd( aStru, {	"TXTPREV"	,"C",11, 0 } )
Aadd( aStru, {	"TXTREAL"	,"C",11, 0 } )

TRB := GetNextAlias()

_oCTBR8011 := FWTemporaryTable():New("TRB")
_oCTBR8011:SetFields( aStru )

aChave0   := {"CLIENTE", "LOJA"}
aChave1   := {"TOTPREVPER","CLIENTE","LOJA"}
aChave2   := {"TOTREALPER","CLIENTE","LOJA"}
aChave3   := {"TOTPREVPER","TOTREALPER","CLIENTE","LOJA"}

_oCTBR8011:AddIndex("1", aChave0)
_oCTBR8011:AddIndex("2", aChave1)
_oCTBR8011:AddIndex("3", aChave2)
_oCTBR8011:AddIndex("4", aChave3)

_oCTBR8011:Create()

// Filtra arquivo
If lQuery
	aStru  := SE1->(dbStruct())
	cAliasTmp := "FINR801"
	cQuery := "SELECT * "
	cQuery += "FROM " + RetSqlName("SE1") + " SE1 "
	cQuery += "WHERE "
	//Gestao
	If mv_par14 == 1
		If Len(aSelFil) > 1
			cQuery += "SE1.E1_FILIAL " + cRngFilSE1 + " AND "
		Else
			cQuery += "SE1.E1_FILIAL = '"+xFilial("SE1",aSelFil[1])+"' AND "
		Endif
	Else
		cQuery += "SE1.E1_FILIAL = '"+xFilial("SE1")+"' AND "
	Endif
	cQuery += "SE1.E1_CLIENTE BETWEEN '"+mv_par03+"' AND '"+mv_par04+"' AND "
	cQuery += "SE1.E1_LOJA    BETWEEN '"+mv_par05+"' AND '"+mv_par06+"' AND "
	cQuery += "SE1.E1_EMISSAO BETWEEN '" + DTOS(mv_par01) + "' AND '" + DTOS(aMeses[Len(aMeses)][3]) + "' AND "
	cQuery += "SE1.D_E_L_E_T_=' ' "

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)

	For nX :=  1 To Len(aStru)
		If aStru[nX][2] <> "C"
			TcSetField(cAliasTmp,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
		EndIf
	Next nX
	bTop	 := { || .T. }
	bWhile := { || !Eof() }
	bFor	 := { || ! (cAliasTmp)->E1_TIPO $ MVPROVIS+"/"+MVABATIM .And.;
					  ((!Empty((cAliasTmp)->E1_FATURA) .And.;
			 		   Substr((cAliasTmp)->E1_FATURA,1,6)!="NOTFAT") .Or.;
	  				   Empty((cAliasTmp)->E1_FATURA)) .AND. ;
					   Empty((cAliasTmp)->E1_NUMLIQ) }

Else
	cAliasTmp := "SE1"
	bTop	 := { ||	dbSelectArea("SE1"),;
						dbSetOrder(6),;
						MsSeek(xFilial("SE1")+Dtos(mv_par01),.T.)}

	bWhile := { ||	!Eof() .And.;
						xFilial("SE1")==(cAliasTmp)->E1_FILIAL	.And.;
						(cAliasTmp)->E1_EMISSAO <= aMeses[Len(aMeses)][3] }

	bFor	 := { ||	(cAliasTmp)->E1_CLIENTE >= mv_par03 .And.;
						(cAliasTmp)->E1_CLIENTE <= mv_par04 .And.;
						(cAliasTmp)->E1_LOJA    >= mv_par05 .And.;
						(cAliasTmp)->E1_LOJA    <= mv_par06 .And. ;
						!(cAliasTmp)->E1_TIPO $ MVPROVIS+"/"+MVABATIM .And.;
						((!Empty((cAliasTmp)->E1_FATURA) .And.;
			 		    Substr((cAliasTmp)->E1_FATURA,1,6)!="NOTFAT") .Or.;
	  					Empty((cAliasTmp)->E1_FATURA)).AND. ;
					    Empty((cAliasTmp)->E1_NUMLIQ) }

Endif

DbSelectArea("TRB")
DbSetOrder(1)
DbGoTop()

dbSelectArea(cAliasTmp)
Eval(bTop)
oReport:SetMeter(LastRec())
// Gera arquivo temporario de trabalho
While Eval(bWhile)
   oReport:IncMeter()
	// Se o filtro de usuario estiver vazio ou se o registro atual passar pelo filtro
	// e pela condicao bFor.
	DbSelectArea("SA1") // Seleciona o SA1, pois o filtro de usuario eh feito sobre ele.
	If MsSeek(xFilial("SA1")+(cAliasTmp)->(E1_CLIENTE+E1_LOJA))
		lOk := (Empty(cFilterUser) .Or. (&cFilterUser))
		dbSelectArea(cAliasTmp)
		If lOk .And. Eval(bFor)
			// Identifica o periodo que o titulo se refere.
			nPer := Ascan(aMeses,{|e| (cAliasTmp)->E1_EMISSAO >= e[2] .And. (cAliasTmp)->E1_EMISSAO <= e[3] } )
			If nPer > 0
				// Pesquisa o cliente no arquivo temporario de trabalho
				DbSelectArea("TRB")
				If MsSeek((cAliasTmp)->E1_CLIENTE+(cAliasTmp)->E1_LOJA)
					RecLock("TRB") // Encontrou, trava o registro
				Else
					RecLock("TRB",.T.) // Nao encontrou, adiciona novo registro.
					TRB->CLIENTE	:= (cAliasTmp)->E1_CLIENTE
					TRB->LOJA		:= (cAliasTmp)->E1_LOJA
					TRB->NOME		:= If(MV_PAR09==1,GetLGPDValue("SA1","A1_NOME"),GetLGPDValue("SA1","A1_NREDUZ"))
					TRB->TXTPREV   := STR0015	//"Previsto ->"
					TRB->TXTREAL   := STR0016	//"Realizado->"
				Endif
				nPrevisto  := xMoeda((cAliasTmp)->E1_VALOR+(cAliasTmp)->E1_ACRESC-(cAliasTmp)->E1_DECRESC,(cAliasTmp)->E1_MOEDA,Val(mv_par07))
				nRealizado := 0
				// Grava o valor do titulo na coluna correspondente ao periodo
				If (!(cAliasTmp)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG)
					If mv_par11==1
						nPrevisto -= SomaAbat((cAliasTmp)->E1_PREFIXO,(cAliasTmp)->E1_NUM,(cAliasTmp)->E1_PARCELA,"R",1,,(cAliasTmp)->E1_CLIENTE,,,,(cAliasTmp)->E1_TIPO)
					Endif
					TRB->&("PREVPER"+StrZero(nPer,2)) += (nPrevisto/nDivide)
				Else
					TRB->&("PREVPER"+StrZero(nPer,2)) -= (nPrevisto/nDivide)
				Endif
			Endif
		Endif
	Endif
	DbSelectArea(cAliasTmp)
	DbSkip()
EndDo

// Calcula realizado
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE5 - Movimenta‡„o banc ria, para verificar     ³
//³ o realizado.                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lQuery
	//Gestao
	bWhile := {||.T.}
	cAliasSE5 := "FR801SE5"
	For nX := 1 to 2

		cQuery := "SELECT "

		If nX == 1
			cQuery += " COUNT(R_E_C_N_O_) NRECSSE5 "
		Else
			cQuery += "R_E_C_N_O_ RECNO "
		Endif

		cQuery += " FROM "+	RetSqlName("SE5") + " SE5 "
		cQuery += " WHERE "

		If mv_par14 == 1
			If Len(aSelFil) > 1
				cQuery += "E5_FILIAL " + cRngFilSE5 + " AND "
			Else
				cQuery += "E5_FILIAL = '"+xFilial("SE5",aSelFil[1])+"' AND "
			Endif
		Else
			cQuery += "E5_FILIAL = '"+xFilial("SE5")+"' AND "
		Endif

		cQuery += "E5_CLIFOR BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "' AND "
		cQuery += "E5_LOJA   BETWEEN '" + mv_par05 + "' AND '" + mv_par06 + "' AND "
		cQuery += "E5_DATA   BETWEEN '" + DTOS(mv_par01) + "' AND '" + DTOS(aMeses[Len(aMeses)][3]) + "' AND "
		cQuery += "E5_RECPAG = 'R' AND "
		cQuery += "E5_TIPODOC NOT IN ('DC','JR','MT','CM','D2','J2','M2','C2','TL','CP','BL','VA') AND "
		cQuery += "E5_SITUACA NOT IN ('C','X','E') AND "
		cQuery += "E5_CLIFOR <> ' ' AND "
		cQuery += "E5_MOTBX  <> ' ' AND "

		cQuery += "D_E_L_E_T_ = ' ' "

		cQuery := ChangeQuery(cQuery)

		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSE5,.T.,.T.)

		If nX == 1
			nTregs:= (cAliasSE5)->NRECSSE5
			oReport:SetMeter(nTregs)
			(cAliasSE5)->(dbCloseArea())
		Endif
	Next nX

Else
	bWhile := {|| SE5->E5_FILIAL==xFilial("SE5")}
	cAliasSE5 := "SE5"
	cIndex3 := CriaTrab(nil,.f.)
	dbSelectArea("SE5")
	dbSetOrder(7)
	cChave  := IndexKey()
	IndRegua("SE5",cIndex3,cChave,,U_FR801ChecF(aMeses),STR0008)  //"Selecionando Registros..."
	nIndex := RetIndex("SE5")
	dbSelectArea("SE5")
	dbSetIndex(cIndex3+OrdBagExt())
	dbSetOrder(nIndex+1)

	DbSeek(xFilial("SE5"))
Endif

SE5->(dbGoTop())
While SE5->(!Eof()) .and. Eval(bWhile)

	oReport:IncMeter()

	DbSelectArea("SA1") // Seleciona o SA1, pois o filtro de usuario eh feito sobre ele.
	MsSeek(xFilial("SA1")+(cAliasTmp)->(E1_CLIENTE+E1_LOJA))

	//Gestao
	//Posicionar no SE5 qdo lQuery
	DbSelectArea("SE5")
	If lQuery
		SE5->(DbGoTo((cAliasSE5)->RECNO))
	Endif

	If (!Empty(cFilterUser) .And. !(&cFilterUser))
		DbSelectArea(cAliasSE5)
		(cAliasSE5)->(dbSkip())
		Loop
	Endif

	If Empty(SE5->E5_CLIFOR)
		(cAliasSE5)->(dbSkip())
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe estorno para esta baixa                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TemBxCanc(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
		(cAliasSE5)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta‡”es especiais ou canceladas n„o aparecem no relat¢rio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF SE5->E5_TIPODOC $ "DCüJRüMTüCM/D2/J2/M2/C2/TL/CP/BL" .or. SE5->E5_SITUACA $ "C/X/E"
		(cAliasSE5)->(dbSkip())
		Loop
	EndIF

	If SE5->E5_TIPODOC == "CH"
		dbSelectArea("SEF")
		dbSetOrder(1)
		If dbSeek(xFilial("SEF",SE5->E5_FILORIG)+SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ))
			If SEF->EF_ORIGEM != "FINA390AVU"
				dbSelectArea(cAliasSE5)
				(cAliasSE5)->(dbSkip())
				Loop
			Endif
		Endif
	Endif

	If !Empty(SE5->E5_MOTBX)
		If !MovBcoBx(SE5->E5_MOTBX) .OR. Alltrim(SE5->E5_MOTBX) == "LIQ"
			(cAliasSE5)->(dbSkip())
			Loop
		EndIf
	EndIf

	If cPaisLoc	!= "BRA"
	   SA6->(DbSetOrder(1))
	   SA6->(DbSeek(xFilial("SE5",SE5->E5_FILORIG)+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
	   nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
	Endif

	nPer := Ascan(aMeses,{|e| SE5->E5_DATA >= e[2] .And. SE5->E5_DATA <= e[3] } )
	If nPer > 0
		// Pesquisa o cliente no arquivo temporario de trabalho
		DbSelectArea("TRB")
		If MsSeek(SE5->(E5_CLIFOR+E5_LOJA))
			RecLock("TRB") // Encontrou, trava o registro
		Else
			RecLock("TRB",.T.) // Nao encontrou, adiciona novo registro.
			TRB->CLIENTE	:= SE5->E5_CLIFOR
			TRB->LOJA		:= SE5->E5_LOJA
			TRB->NOME		:= SA1->&(If(mv_par09==1,"A1_NOME","A1_NREDUZ"))
		Endif
		nRealizado := Round(NoRound(xMoeda(SE5->E5_VALOR,nMoedaBco,Val(mv_par07),SE5->E5_DATA,nDecs+1),nDecs+1),nDecs+1)
		// Grava o valor da movimentacao na coluna correspondente ao periodo
		TRB->&("REALPER"+StrZero(nPer,2)) += (nRealizado/nDivide)
	Endif
	dbSelectArea(cAliasSE5)
	(cAliasSE5)->(dbSkip())
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do relatorio.                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
U_Fr801Total() // totaliza arquivo antes da impressao
DbSelectArea("TRB")
//mv_par12 == 1 - Ordem de codigo
//mv_par12 == 2 - Previsto
//mv_par12 == 3 - Realizado
//mv_par12 == 4 - Previsto+Realizado
DbSetOrder(mv_par12)

oReport:SetMeter(RecCount())		// Total de Elementos da regua

DbGoTop()
nImpressos := 1 // Imprimir quantos?

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alteracoes no cabecalho e celulas das secoes.                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Altera o titulo do relatorio e das celulas
oReport:SetTitle(cTitulo)

If mv_par08 <> 1  //Considera Periodo Contabil?
	//Altera os textos das celulas
	oSection1:Cell("TXTPREV"  ):SetTitle("")
	For nCont := 1 to Len(aCabecMes)
		oSection1:Cell("PREVPER"+StrZero(nCont,2)):SetTitle(aCabecMes[nCont] + CRLF + aCabecDat[nCont])
	Next nCont
	
	For nCont := nCont To 6
		oSection1:Cell("PREVPER"+StrZero(nCont,2)):SetTitle("")
	Next nCont
Else
	oSection1:Cell("TXTPREV"  ):SetTitle("")
	For nCont := 1 to Len(aMeses)
		oSection1:Cell("PREVPER"+StrZero(nCont,2)):SetTitle(oSection1:Cell("PREVPER"+StrZero(nCont,2)):Title()+;
																			CRLF+DTOC(aMeses[nCont][2])+"-"+DTOC(aMeses[nCont][3]))
	Next nCont
EndIf

//Inicia as secoes para a impressao
While !oReport:Cancel() .And. TRB->(!Eof()) .And. (mv_par13 == 0 .Or. nImpressos <= mv_par13)

	oSection1:Init()
	oSection1:PrintLine()
	oSection1:Finish()

	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()

	oReport:ThinLine()

	TRB->(dbSkip())
	nImpressos++
	oReport:IncMeter()

EndDo

dbSelectArea("TRB")
dbCloseArea()
fErase(cArqTrb+ GetDBExtension())
fErase(cArqInd2+OrdBagExt())
fErase(cArqInd3+OrdBagExt())
fErase(cArqInd4+OrdBagExt())

If lQuery
	DbSelectArea(cAliasTmp)
	DbCloseArea()
	DbSelectArea(cAliasSE5)
	DbCloseArea()
Endif

If len(aTmpFil) >= 1 
	For nTmp := 1 to len(aTmpFil)
		CtbTmpErase(aTmpFil[nTmp])
	Next nTmp	
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Fr801Total³ Autor ³ Claudio D. de Souza   ³ Data ³ 28.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Totaliza arquivo por cliente		  						        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_Fr801Total() 									 			           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ FINR801                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum											                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fr801Total

Local nCont
Local nSoma := 0
Local nX
Local cCampo

DbSelectArea("TRB")
DbSetOrder(1)
DbGoTop()
While !Eof()
	For nX := 1 To 2
		nSoma := 0
		For nCont := 1 To 6
			cCampo := If(nX == 1, "PREVPER"+StrZero(nCont,2), "REALPER"+StrZero(nCont,2))
			nSoma += TRB->&cCampo
		Next nCont
		RecLock("TRB")
		cCampo := If(nX == 1, "TOTPREVPER", "TOTREALPER")
		TRB->&cCampo := nSoma
	Next nX
	DbSkip()
End

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FR801ChecF³ Autor ³ Claudio D. de Souza   ³ Data ³ 19/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Filtra o arquivo de Movimenta‡„o Banc ria para analisar o  ³±±
±±³          ³ Realizado.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FR801ChecF()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR801                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FR801ChecF(aMeses)

Local cFiltro := "E5_FILIAL='"+xFilial("SE5")+"' .And. "

cFiltro += "E5_CLIFOR >= '" + mv_par03 + "' .AND. "
cFiltro += "E5_CLIFOR <= '" + mv_par04 + "' .AND. "
cFiltro += "E5_LOJA   >= '" + mv_par05 + "' .AND. "
cFiltro += "E5_LOJA   <= '" + mv_par06 + "' .AND. "
cFiltro += "DTOS(E5_DATA) >= '" + DTOS(mv_par01) + "' .AND. "
cFiltro += "DTOS(E5_DATA) <= '" + DTOS(aMeses[Len(aMeses)][3]) + "' .AND. "
cFiltro += "E5_RECPAG = 'R'"

Return cFiltro