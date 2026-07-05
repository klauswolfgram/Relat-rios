/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR551.CH"
//#INCLUDE "FIVEWIN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR551  ³ Autor ³ Wagner Xavier         ³ Data ³ 25.02.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Mayor de Contas Pagar e Recibir                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR551(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Localizacoes Paises do ConeSul...                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±Luis Eníquez 12/12/2016 SERINN001-139 Se hizo merge contra 12.1.15       ±±
±±                                      Inovação para eliminar creación de ±±
±±                                      archivo .dtc en carpeta system al  ±±
±±                                      utilizar tablas temporales.        ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr551()        // incluido pelo assistente de conversao do AP5 IDE em 09/09/99

	Local oReport
	Private nValTran:=0
	Private cIndE1 :=cIndE2 :=cIndE5 :=cIndA1 :=cIndA2 :=" "

	If FindFunction("TRepInUse") .And. TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport	:= ReportDef()
		oReport:PrintDialog()
	Else
		U_FINR551R3()
	EndIf

	If Select("TRB") > 0
		DbSelectArea("TRB")
		DbCloseArea()
	EndIf


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Augusto       º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tratamanto release 04                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef() 

	Local oReport,oSection1,oSection2
	Local cReport := "FINR551"
	Local cTitulo :=OemToAnsi(STR0004) 	// "Informe de Pagos"
	Local cDescri :=OemToAnsi(STR0001)+" "+ OemToAnsi(STR0002) +" "+OemToAnsi(STR0003)  

	oReport  := TReport():New( cReport, cTitulo, "FIN551" , { |oReport| ReportPrint( oReport, "SE2" ) }, cDescri )

	oSection1 := TRSection():New( oReport,STR0051 + ' / ' + STR0052, {"SE2"}, ) //"Contas a Pagar / Ordens de Pago"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         

	TRCell():New( oSection1, "DESCCOL1" 	,"","" /*X3Titulo*/	,/*Picture*/,40,/*lPixel*/,)
	TRCell():New( oSection1, "DESCCOL2" 	,"","" /*X3Titulo*/	,/*Picture*/,40,/*lPixel*/,)
	TRCell():New( oSection1, "DESCCOL3" 	,"","" /*X3Titulo*/	,/*Picture*/,60,/*lPixel*/,)

	oSection2 := TRSection():New( oSection1,STR0051 , {"SEK"} ) //"Contas a Pagar"
	TRCell():New( oSection2,"DATA"		,"",OemToAnsi(STR0045)/*X3Titulo*/	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)                                              
	TRCell():New( oSection2,"HISTORICO"	,"",OemToAnsi(STR0046),,30,,,,.T.,,,,.T.)
	TRCell():New( oSection2,"PREFIXO"	,"",OemToAnsi(STR0050)/*X3Titulo*/	,/*Picture*/,TamSX3("E2_PREFIXO")[1],/*lPixel*/,)                                              
	TRCell():New( oSection2,"E2_NUM"	,"SE2",/*X3Titulo*/	,/*Picture*/,TamSX3("E2_NUM")[1]+4/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2,"E2_PARCELA","SE2",/*X3Titulo*/	,/*Picture*/,TamSX3("E2_PARCELA")[1],/*lPixel*/,)
	TRCell():New( oSection2,"E2_EMISSAO","SE2",/*OemToAnsi(STR0036)+ CHR(13)+CHR(10) + OemToAnsi(STR0037)X3Titulo*/	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2,"E2_VENCTO","SE2",/*OemToAnsi(STR0036)+ CHR(13)+CHR(10) + OemToAnsi(STR0037)X3Titulo*/	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2,"E2_BAIXA","SE2",/*OemToAnsi(STR0036)+ CHR(13)+CHR(10) + OemToAnsi(STR0037)X3Titulo*/	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2,"DEBITO"	,"   ",OemToAnsi(STR0011)/*OemToAnsi(STR0040)X3Titulo*/		,PesqPict("SE2","E2_VALOR")/*Picture*/,12/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2,"CREDITO"	,"   ",OemToAnsi(STR0012)/*OemToAnsi(STR0040)X3Titulo*/		,PesqPict("SE2","E2_VALOR")/*Picture*/,12/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2,"SALDO"		,"   ",OemToAnsi(STR0049)/*OemToAnsi(STR0041)+  CHR(13)+CHR(10)+OemToAnsi(STR0042)X3Titulo*/	,PesqPict("SE2","E2_VALOR")/*Picture*/,12/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection2,"TPSALDO"	,"   ",/*OemToAnsi(STR0041)+  CHR(13)+CHR(10)+OemToAnsi(STR0042)X3Titulo*/	,/*Picture*/,1/*Tamanho*/,/*lPixel*/,)

	oSection3:= TRSection():New( oSection1, STR0052 , {"SEK"} )  //"Ordens de Pago"                                         
	TRCell():New( oSection3,"DATA"		,"",OemToAnsi(STR0045)/*X3Titulo*/	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)                                              
	TRCell():New( oSection3,"HISTORICO"	,"",OemToAnsi(STR0046),,30,,,,.T.,,,,.T.)
	TRCell():New( oSection3,"PREFIXO"	,"",OemToAnsi(STR0050)/*X3Titulo*/	,/*Picture*/,TamSX3("E2_PREFIXO")[1],/*lPixel*/,)                                              
	TRCell():New( oSection3,"E2_NUM"	,"SE2",/*X3Titulo*/	,/*Picture*/,TamSX3("E2_NUM")[1]+4/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection3,"E2_PARCELA","SE2",/*X3Titulo*/	,/*Picture*/,TamSX3("E2_PARCELA")[1],/*lPixel*/,)
	TRCell():New( oSection3,"E2_EMISSAO","SE2",/*OemToAnsi(STR0036)+ CHR(13)+CHR(10) + OemToAnsi(STR0037)X3Titulo*/	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection3,"E2_VENCTO","SE2",/*OemToAnsi(STR0036)+ CHR(13)+CHR(10) + OemToAnsi(STR0037)X3Titulo*/	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection3,"E2_BAIXA","SE2",/*OemToAnsi(STR0036)+ CHR(13)+CHR(10) + OemToAnsi(STR0037)X3Titulo*/	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection3,"DEBITO"	,"   ",OemToAnsi(STR0047)/*OemToAnsi(STR0040)X3Titulo*/		,PesqPict("SE2","E2_VALOR")/*Picture*/,12/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection3,"CREDITO"	,"   ",OemToAnsi(STR0048)/*OemToAnsi(STR0040)X3Titulo*/		,PesqPict("SE2","E2_VALOR")/*Picture*/,12/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection3,"SALDO"		,"   ",OemToAnsi(STR0049)/*OemToAnsi(STR0041)+  CHR(13)+CHR(10)+OemToAnsi(STR0042)X3Titulo*/	,PesqPict("SE2","E2_VALOR")/*Picture*/,12/*Tamanho*/,/*lPixel*/,)
	TRCell():New( oSection3,"TPSALDO"	,"   ",/*OemToAnsi(STR0041)+  CHR(13)+CHR(10)+OemToAnsi(STR0042)X3Titulo*/	,/*Picture*/,1/*Tamanho*/,/*lPixel*/,)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de impressao                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint( oReport )

	Local oSection1 := oReport:Section(1)
	Local oSection2 := oSection1:Section(1)  
	Local oSection3 := oSection1:Section(2)  
	LOCAL cString:="SE1"
	LOCAL CbCont,CbTxt
	LOCAL nQuebra:=0,lImprAnt := .F.
	LOCAL cNome,nTotDeb:=0,nTotCrd:=0,nSaldoAtu:=0,nTotDebG:=0,nTotCrdG:=0,nSalAtuG:=0,nSalAntG:=0
	LOCAL aSaldos:={},j,dEmissao:=CTOD(""),dVencto:=CTOD("")
	LOCAL nRec,nPrim,cPrefixo,cNumero,cParcela,cTipo,cNaturez,nValliq
	LOCAL nAnterior:=0,cAnterior,cFornece,dDtDigit,cRecPag,nRec1,cSeq
	LOCAL nTotAbat:=0 
	Local cCodigo:=""
	Local cLoja:=""
	LOCAL nRegistro
	LOCAL lNoSkip := .T.
	LOCAL lFlag := .F.
	LOCAL nSaldoFinal:=0
	LOCAL aCampos:={},aTam:={}
	LOCAL aInd:={}
	LOCAL cCondE1:=cCondE2:=cCondE5:=" "
	LOCAL nRegAtu,lImprime
	Local aOrdem	:={} //gsa
	LOCAL nRegSe1Atu := SE1->(RecNo())
	LOCAL nOrdSe1Atu := SE1->(IndexOrd())
	LOCAL lBaixa     := .F.
	LOCAL nRegSe2Atu := SE2->(RecNo())
	LOCAL nOrdSe2Atu := SE2->(IndexOrd())
	LOCAL cChaveSe1
	LOCAL cChaveSe2
	LOCAL nDecs:=2
	LOCAL cPosTp
	Local cUniao	 := Alltrim(GetMv("MV_UNIAO"))
	Local nX,nI
	Local cSimb  	:=	""
	Local cSimbolo	:=	""
	Local lImp:=.T.
	Private lPagNova :=.F.
	Private cNomeArq
	Private oTmpTable //gsa

	Private cTipos           := ""

	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf	                            

	oReport:SetTitle(OemToAnsi(STR0007)+IIF(mv_par03==1,OemToAnsi(STR0008), OemToAnsi(STR0009)) ) //"RAZONETE DE CONTAS CORRENTES DE "###"CLIENTES"###"FORNECEDORES"              
	nDecs:=MsDecimais(MV_PAR16)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ponto de entrada para Filtrar os tipos sem entrar na tela do ³
	//³ FINRTIPOS(), localizacao Argentina.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	IF cPaisLoc <> "BRA" .And. EXISTBLOCK("FARGTIP")
		cTipos   := EXECBLOCK("FARGTIP")
	ENDIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                        ³
	//³ mv_par01            // A partir de                          ³
	//³ mv_par02            // Ate a data                           ³
	//³ mv_par03            // Carteira (Receber ou Pagar)          ³
	//³ mv_par04            // Do Codigo                            ³
	//³ mv_par05            // Ate o Codigo                         ³
	//³ mv_par06            // Imprime Valores Financeiros (Sim/Nao)³
	//³ mv_par07            // Impime (Todos,Normais,Adiantamentos) ³
	//³ mv_par08            // Do Prefixo                           ³
	//³ mv_par09            // Ate o Prefixo                        ³
	//³ mv_par09            // Ate o Prefixo                        ³
	//³ mv_par10            // Lista Por 1 - Filial     2 -Empresa  ³
	//³ mv_par11            // Seleciona Tipos                      ³
	//³ mv_par12            // Natureza de  ?                       ³
	//³ mv_par13            // Natureza ate ?                       ³
	//³ mv_par14            // Anal¡tico/Sint‚tico                  ³
	//³ mv_par15            // Todos/Em Aberto                      ³
	//³ mv_par16            // Cual Moneda                          ³
	//³ mv_par17            // Otras Moneda  Converter/No Imprimir  ³
	//³ mv_par18            // Por fecha/Factura                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


	If cPaisLoc != "BRA"
		For nX := 1 to MoedFin()                
			cSimbolo := GetMv("MV_SIMB"+Str(nX,1))
			If !Empty(cSimbolo)
				cSimb    += PadR(cSimbolo,3)+","
			EndIf
			cSimbolo    := ""   
		Next nX
		cSimb  := Substr(cSimb,1,len(cSimb)-1)  //Contem os simbolos das moedas utilizadas pelo sistema 
	EndIf                                       //para realizar o filtro

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Referencia para imprimir descricao dos tipos de cliente A1_TIPO ³
	//ÀÄLocalizacoesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc != "BRA"
		SX3->(dbSetOrder(2))
		SX3->(dbSeek("A1_TIPO"))
		If SX3->(Found())
			cTipoCli := AllTrim(SX3->(X3CBox()) )
			cTipoCli := '{"'+StrTran(cTipoCli,';','","')+'"}'
			aTipoCli := &(cTipoCli)
		Else
			cTipoCli := ""
			aTipoCli := {}
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se seleciona tipos                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par11 == 1
		finRTipos()                                                  

	End


	// Quebra de pagina

	//oReport:SetPageFooter(7,{||F551RODAPE(oReport,oSection1,oSection3,nSaldoAtu,lImp)} )
	//oReport:OnPageBreak({||F551TRANSP(oReport,oSection1,oSection3,nquebra,nValTran,cCodigo,cLoja)  })
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gera arquivo de Trabalho                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aTam:=TamSX3("E1_CLIENTE")
	AADD(aCampos,{"CODIGO" ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_LOJA")
	AADD(aCampos,{"LOJA"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_EMISSAO")
	AADD(aCampos,{"DATAEMI","D",aTam[1],aTam[2]})
	AADD(aCampos,{"NUMERO" ,"C",TamSX3("E1_PREFIXO")[1]+TamSX3("E1_NUM")[1]+TamSX3("E1_PARCELA")[1],0})
	aTam:=TamSX3("E1_TIPO")
	AADD(aCampos,{"TIPO"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_PORTADO")
	AADD(aCampos,{"BANCO"  ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_EMISSAO")
	AADD(aCampos,{"EMISSAO","D",aTam[1],aTam[2]})
	AADD(aCampos,{"BAIXA"  ,"D",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_VENCREA")
	AADD(aCampos,{"VENCTO" ,"D",aTam[1],aTam[2]})
	AADD(aCampos,{"VALOR"  ,"N",18,2})
	AADD(aCampos,{"HISTOR" ,"C",40,0})
	AADD(aCampos,{"DC"     ,"C", 1,0})
	//GSA cNomeArq:=CriaTrab(aCampos)
	//GSAdbUseArea( .T., __cRDDNTTS, cNomeArq, "cNomeArq", if(.F. .Or. .F., !.F., NIL), .F. )
	//Creacion de Objeto

	oTmpTable := FWTemporaryTable():New("cNomeArq") //gsa
	oTmpTable:SetFields( aCampos ) //gsa
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia rotina de impressao                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//gsa  dbSelectArea("cNomeArq")
	If mv_par18 == 1
		aOrdem	:=	{"CODIGO","LOJA","DATAEMI","NUMERO","HISTOR"} //gsa
	Else
		aOrdem	:=	{"CODIGO","LOJA","EMISSAO","NUMERO","TIPO","BAIXA","HISTOR"} //gsa
	Endif

	//GSA IndRegua("cNomeArq",cNomeArq,cOrdem,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
	//GSA dbGoTop()
	oTmpTable:AddIndex("T1ORD1", aOrdem) //gsa

	//Creacion de la tabla

	oTmpTable:Create() //gsa

	IF mv_par03 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza e grava titulos a receber dentro dos parametros     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE1")
		dbSetOrder(2) // Filial+Cliente+Loja+Prefixo+Num+Parcela+Tipo
		If mv_par10 = 1 // 1=Filial ou 2=Empresa
			dbSeek(xFilial()+mv_par04,.T.)
			cCondE1:="'"+xFilial()+"'==E1_FILIAL .and. SE1->E1_CLIENTE >= '"+mv_par04+"' .And. SE1->E1_CLIENTE <= '"+mv_par05+"'"
		Else
			cArqTrab :=CriaTrab(NIL,.F.)
			AADD(aInd,cArqTrab)
			cIndE1   :=IndexKey()
			cIndE1   :=Right(cIndE1,Len(cIndE1)-10)
			IndRegua("SE1",cArqTrab,cIndE1,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
			cCondE1:="E1_CLIENTE >='" +mv_par04+"' .And. SE1->E1_CLIENTE <='"+ mv_par05+"'"
			dbCommit()
			nIndex:=RetIndex("SE1")
			dbSelectArea("SE1")
			#IFNDEF TOP
			dbSetIndex(cArqTrab+OrdBagExt())
			#ENDIF
			dbSetOrder(nIndex+1)
			dbSeek(mv_par04,.T.)
		EndIf
		While !SE1->(Eof()) .and. &(cCondE1)

			If mv_par15 <> 1 .And.SE1->E1_SALDO <= 0
				SE1->(dbSkip())
				Loop
			Endif
			If SE1->E1_PREFIXO < mv_par08 .Or. SE1->E1_PREFIXO > mv_par09 .or. SE1->E1_EMISSAO > dDataBase
				SE1->(dbSkip())
				Loop
			End

			If ( SE1->E1_NATUREZ < mv_par12 .Or. SE1->E1_NATUREZ > mv_par13 )
				SE1->(dbSkip())
				Loop
			EndIf

			IF SubStr(SE1->E1_TIPO,1,2) == MVPROVIS
				SE1->(dbSkip())
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica quais serao impressos                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par07 == 1 .And. (E1_TIPO $ MVRECANT+","+MV_CRNEG .Or. Substr(E1_TIPO,3,1)=="-") .And. ;
			E1_PREFIXO == "REC" // Exclui Adiantamentos gerados por recibo para nao serem considerados duas vezes
				dbSkip( )
				Loop
			End

			If mv_par07 == 2 .And. E1_TIPO $ MVRECANT+","+MV_CRNEG // So'Normais
				dbSkip( )
				Loop
			End

			If mv_par07 == 3 .And. ! (E1_TIPO $ MVRECANT+","+MV_CRNEG)  //So'Adiantamentos
				dbSkip( )
				Loop
			End

			If Alltrim(SE1->E1_CLIENTE) == cUniao
				SE1->(dbSkip())
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Le registros com data anterior a data inicial (para compor   ³
			//³ os saldos anteriores) ate a data final.                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SE1->E1_EMISSAO > mv_par02
				SE1->(dbSkip( ) )
				Loop
			End

			IF ! Inside(SE1->E1_TIPO)
				dbSkip()
				Loop
			End

			if MV_PAR17==2 .AND. MV_PAR16<>SE1->E1_MOEDA
				DbSkip()
				Loop
			Endif
			//Ignora titulos a vista gerados pelo Loja
			If cPaisLoc <> "BRA" .And. IsMoney(E1_TIPO) 
				dbSkip()
				Loop
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava debito no arquivo de trabalho                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SX5->( dbSetOrder(1) )
			SX5->( dbSeek(xFilial("SX5")+"05"+SE1->E1_TIPO) )
			cHistor    := X5DESCRI()
			If Empty(cHistor)
				cHistor := If(Empty(SE1->E1_HIST),OemToAnsi(STR0012),SE1->E1_HIST)  //"Pela Emissao do Titulo"
			Endif
			dbSelectArea("cNomeArq")
			Reclock("cNomeArq",.t.)
			Replace CODIGO  With SE1->E1_CLIENTE
			Replace LOJA    With SE1->E1_LOJA
			Replace DATAEMI With SE1->E1_EMISSAO
			Replace NUMERO  With SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA
			Replace TIPO    With SE1->E1_TIPO
			Replace BANCO   With SE1->E1_PORTADO
			Replace EMISSAO With SE1->E1_EMISSAO
			Replace VENCTO  With SE1->E1_VENCREA
			Replace VALOR   With IIf(mv_par15==1,xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,MV_PAR16,,nDecs+1),xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,MV_PAR16,,nDecs+1))
			Replace HISTOR  With cHistor
			If SE1->E1_TIPO $ MV_CRNEG+","+MVRECANT+","+MVCHEQUES .Or. SubStr( SE1->E1_TIPO,3,1 ) == "-"
				Replace DC   With "C"
			Else
				Replace DC   With "D"
			End
			MsUnlock()

			nRegSe1Atu := SE1->(RecNo())
			nOrdSe1Atu := SE1->(IndexOrd())
			lBaixa     := .F.
			If SE1->E1_FATURA == "NOTFAT"
				dbSelectArea("SE1")
				dbSetOrder(10)
				cChaveSe1 := xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA+SE1->E1_PREFIXO+SE1->E1_NUM
				If (dbSeek(cChaveSe1))
					If E1_DTFATUR <= dDataBase .and. SE1->E1_BAIXA <= mv_par02
						lBaixa := .T.
					Endif
				Endif
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se houve a substituicao do NF -> DP                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lBaixa
				dbSelectArea("cNomeArq")
				If !(dbSeek(SE1->E1_CLIENTE+SE1->E1_LOJA+DTOS(SE1->E1_DTFATUR)+SE1->E1_PREFIXO+SE1->E1_NUM))
					dbSelectArea("SE1")
					While !Eof() .and. (E1_FILIAL+SE1->E1_CLIENTE+SE1->E1_LOJA+SE1->E1_FATPREF+SE1->E1_FATURA == cChaveSe1)

						//If ! dbSeek(SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)

						if MV_PAR17==2 .AND. MV_PAR16<>SE1->E1_MOEDA
							dbSelectArea("SE1")   // Paulo
							dbSkip()
						else
							Reclock("cNomeArq",.T.)
							Replace CODIGO		With SE1->E1_CLIENTE
							Replace LOJA		With SE1->E1_LOJA
							Replace DATAEMI With SE1->E1_DTFATUR
							Replace NUMERO		With SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA
							Replace HISTOR		With STR0013 + SE1->E1_FATURA
							Replace EMISSAO	With SE1->E1_EMISSAO
							Replace VALOR		With IIf(mv_par15==1,xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,MV_PAR16,,nDecs+1),xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,MV_PAR16,,nDecs+1))
							Replace VENCTO		With SE1->E1_VENCREA
							Replace TIPO    With SE1->E1_TIPO
							If Substr(SE1->E1_TIPO,3,1) != "-" .And. !(SE1->E1_TIPO $ MV_CRNEG+","+MVRECANT+","+MVCHEQUES)
								Replace DC     With "C"
							Else
								Replace DC     With "D"    //Abatimentos/RA/NCC
							Endif
							MsUnlock()
							dbSelectArea("SE1")
							dbSkip()
						EndIf
					Enddo
				Endif
			Endif
			dbSelectArea("SE1")
			dbSetOrder(nOrdSe1Atu)
			dbGoto(nRegSe1Atu)
			dbSkip()
		Enddo
	Endif

	IF mv_par03 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza e grava titulos a pagar dentro dos parametros       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbSetOrder (6)
		If mv_par10 = 1
			dbSeek(xFilial()+mv_par04,.T.)
			cCondE2:="E2_FILIAL=='"+xFilial() +"'.and. E2_FORNECE >='"+ mv_par04+"' .And. E2_FORNECE <= '"+mv_par05+"'"
		Else
			cArqTrab :=CriaTrab(NIL,.F.)
			AADD(aInd,cArqTrab)
			cIndE2   :=IndexKey()
			cIndE2   :=Right(cIndE2,Len(cIndE2)-10)
			IndRegua("SE2",cArqTrab,cIndE2,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
			cCondE2:="E2_FORNECE >='"+ mv_par04+"' .And. E2_FORNECE <='"+ mv_par05+"'"
			dbCommit()
			nIndex:=RetIndex("SE2")
			dbSelectArea("SE2")
			#IFNDEF TOP
			dbSetIndex(cArqTrab+OrdBagExt())
			#ENDIF
			dbSetOrder(nIndex+1)
			dbSeek(mv_par04,.T.)
		EndIf

		While !SE2->(Eof()) .and. &(cCondE2)

			If mv_par15 <> 1.And. SE2->E2_SALDO > 0
				SE2->(dbSkip())
				Loop
			Endif

			If SE2->E2_PREFIXO < mv_par08 .Or. SE2->E2_PREFIXO > mv_par09  .Or. SE2->E2_EMIS1 > dDataBase
				SE2->(dbSkip())
				Loop
			EndIf

			If ( SE2->E2_NATUREZ < mv_par12 .Or. SE2->E2_NATUREZ > mv_par13 )
				SE2->(dbSkip())
				Loop
			EndIf

			IF SubStr(SE2->E2_TIPO,1,2) == "PR"
				SE2->(dbSkip())
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica quais serao impressos                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par07 == 2 .and. (SE2->E2_TIPO $ "PA /"+MV_CPNEG)  // So'Normais
				dbSkip()
				Loop
			Endif

			If mv_par07 == 3 .And. !(SE2->E2_TIPO $ MVPAGANT+","+MV_CPNEG) //So'Adiantamentos
				dbSkip()
				Loop
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Le registros com data anterior a data inicial (para compor   ³
			//³ os saldos anteriores) ate a data final.                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SE2->E2_EMIS1 > mv_par02
				SE2->(dbSkip())
				Loop
			End

			if MV_PAR17==2 .AND. MV_PAR16<>SE2->E2_MOEDA
				DbSkip()
				Loop
			Endif

			if ! Inside(SE2->E2_TIPO)
				dbSkip()
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava debito no arquivo de trabalho                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//If ! dbSeek(SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA)
			Reclock("cNomeArq",.t.)
			Replace CODIGO		With SE2->E2_FORNECE
			Replace LOJA		With SE2->E2_LOJA
			Replace DATAEMI 	With SE2->E2_EMIS1
			Replace NUMERO		With SubStr(SE2->E2_PREFIXO,1,TamSX3("E2_PREFIXO")[1])+;
			SubStr(SE2->E2_NUM,1,TamSX3("E2_NUM")[1])+;
			SubStr(SE2->E2_PARCELA,1,TamSX3("E2_PARCELA")[1])
			Replace TIPO		With SE2->E2_TIPO
			Replace BANCO		With SE2->E2_PORTADO
			Replace EMISSAO		With SE2->E2_EMISSAO
			Replace VENCTO		With SE2->E2_VENCREA
			Replace VALOR		With IIf(mv_par15==1,xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,MV_PAR16,,nDecs+1),xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,MV_PAR16,,nDecs+1))

			If cPaisLoc <> "BRA"
				cHistor := ""
				If SE2->E2_TIPO == "NCP"
					cHistor := OemToAnsi(STR0030)	// "NOTA DE CREDITO No. "
				ElseIf SE2->E2_TIPO == "NDP"
					cHistor := OemToAnsi(STR0031)	// "NOTA DE DEBITO No. "
				ElseIf SE2->E2_TIPO $ "NF |FT "
					cHistor := OemToAnsi(STR0032)	// "FACTURA No. "
				ElseIf SE2->E2_TIPO == "NCE"
					cHistor := OemToAnsi(STR0036)	// "NOTA DE CRED. EXTERNA"
				ElseIf SE2->E2_TIPO == "NDE"
					cHistor := OemToAnsi(STR0037)	// "NOTA DE DEB. EXTERNA"
				ElseIf SE2->E2_TIPO == "PA "
					cHistor := OemToAnsi(STR0033)	// "ANTICIPO"
				ElseIf SE2->E2_TIPO == "CH "
					cHistor := OemToAnsi(STR0044)	// "CHEQUE"
				EndIf
				Replace HISTOR  With IIF(Empty(SE2->E2_HIST),cHistor,SE2->E2_HIST)
			ElseIf SE2->E2_FATURA="NOTFAT" .and. cPaisLoc == 'BRA'
				Replace HISTOR  With IIF(Empty(SE2->E2_HIST),OemToAnsi(STR0029),SE2->E2_HIST)  //"Pela Emissao da Fatura"
			Else
				Replace HISTOR  With IIF(Empty(SE2->E2_HIST),OemToAnsi(STR0012),SE2->E2_HIST)  //"Pela Emissao do Titulo"
			Endif
			IF SE2->E2_TIPO $ MV_CPNEG+","+MVPAGANT .Or. (SE2->E2_TIPO $ MVCHEQUES .And. AllTrim(SE2->E2_ORIGEM) != "FINA085A")  .Or. SubStr(SE2->E2_TIPO,3,1) == "-"
				Replace DC     With "D"
			Else
				Replace DC     With "C"     //Abatimentos
			Endif
			MsUnlock()
			//EndIf

			nRegSe2Atu := SE2->(RecNo())
			nOrdSe2Atu := SE2->(IndexOrd())
			lBaixa     := .F.

			If SE2->E2_FATURA == "NOTFAT"
				dbSelectArea("SE2")
				dbSetOrder(9)
				cChaveSe2 := xFilial()+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_PREFIXO+SE2->E2_NUM
				If (dbSeek(cChaveSe2))
					If E2_DTFATUR <= dDataBase .and. SE2->E2_BAIXA <= mv_par02
						lBaixa := .T.
					Endif
				Endif
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se houve a substituicao do NF -> DP                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lBaixa
				dbSelectArea("cNomeArq")
				If !(dbSeek(SE2->E2_FORNECE+SE2->E2_LOJA+DTOS(SE2->E2_DTFATUR)+SE2->E2_PREFIXO+SE2->E2_NUM))
					dbSelectArea("SE2")
					While !Eof() .and. cChaveSe2 == xFilial()+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_FATPREF+SE2->E2_FATURA

						//If ! dbSeek(SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)

						if MV_PAR17==2 .AND. MV_PAR16<>SE2->E2_MOEDA
							dbSelectArea("SE2")
							dbSkip()
						else
							Reclock("cNomeArq",.T.)
							Replace CODIGO		With SE2->E2_FORNECE
							Replace LOJA		With SE2->E2_LOJA
							Replace DATAEMI With SE2->E2_DTFATUR
							Replace NUMERO		With SubStr(SE2->E2_PREFIXO,1,TamSX3("E2_PREFIXO")[1])+;
							SubStr(SE2->E2_NUM,1,TamSX3("E2_NUM")[1])+;
							SubStr(SE2->E2_PARCELA,1,TamSX3("E2_PARCELA")[1])
							Replace EMISSAO	With SE2->E2_EMIS1
							Replace HISTOR		With STR0013 + SE2->E2_FATURA
							Replace VALOR		With IIf(mv_par15==1,xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,MV_PAR16,,nDecs+1),xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,mv_par16,,ndecs+1))
							Replace VENCTO		With SE2->E2_VENCREA

							IF Substr(SE2->E2_TIPO,3,1) != "-" .and. ! ( SE2->E2_TIPO $ "PA /"+MV_CPNEG)
								Replace DC     With "D"
							Else
								Replace DC     With "C"    //Abatimentos/PA/NDF
							Endif
							MsUnlock()
							dbSelectArea("SE2")
							dbSkip()
						EndIf

					Enddo
				Endif
			Endif
			dbSelectArea("SE2")
			dbSetOrder(nOrdSe2Atu)
			dbGoto(nRegSe2Atu)
			dbSkip()
		Enddo
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza na movimentacao bancaria, os titulos do periodo     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE5")
	dbSetOrder(7)
	If mv_par10 = 1
		dbSeek(xFilial(),.T.) // Com SoftSeek ON
		cCondE5:="'"+xFilial('SE5')+"' == SE5->E5_FILIAL"
	Else
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE5   :=IndexKey()
		cIndE5   :=Right(cIndE5,Len(cIndE5)-10)
		IndRegua("SE5",cArqTrab,cIndE5,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
		cCondE5:=".T."
		dbCommit()
		nIndex:=RetIndex("SE5")
		dbSelectArea("SE5")
		#IFNDEF TOP
		dbSetIndex(cArqTrab+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGoTop()

		// SE1
		dbSelectArea("SE1")
		dbSetOrder(1)
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE1   :=IndexKey()
		cIndE1   :=Right(cIndE1,Len(cIndE1)-10)
		IndRegua("SE1",cArqTrab,cIndE1,,,OemToAnsi(STR0011)) //"Selecionando Registros..."
		dbCommit()
		nIndex:=RetIndex("SE1")
		dbSelectArea("SE1")
		#IFNDEF TOP
		dbSetIndex(cArqTrab+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGoTop()

		//SE2
		dbSelectArea("SE2")
		dbSetOrder(1)
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE2   :=IndexKey()
		cIndE2   :=Right(cIndE2,Len(cIndE2)-10)
		IndRegua("SE2",cArqTrab,cIndE2,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
		dbCommit()
		nIndex:=RetIndex("SE2")
		dbSelectArea("SE2")
		#IFNDEF TOP
		dbSetIndex(cArqTrab+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGotop()
	EndIf
	If mv_par15==1
		dbSelectArea("SE5")
		While !SE5->(Eof()) .and. &(cCondE5)

			If Empty(SE5->E5_NUMERO) .Or. SE5->E5_SITUACA = "C" .Or. !SE5->E5_TIPODOC $ "VLüBAüCPüV2üLJüES"
				SE5->(dbSkip())
				Loop
			EndIf
			//Ignorar baixas do Loja de titulos a vista
			If cPaisLoc <> "BRA" .And. SE5->E5_RECPAG=='R' .And. IsMoney(SE5->E5_TIPO) .And. SE5->E5_TIPODOC == "LJ"
				SE5->(dbSkip())
				Loop
			EndIf

			If SE5->E5_PREFIXO < mv_par08 .Or. SE5->E5_PREFIXO > mv_par09
				SE5->(dbSkip())
				Loop
			EndIf

			If  ( SE5->E5_NATUREZ < mv_par12 .Or. SE5->E5_NATUREZ > mv_par13 )
				SE5->(dbSkip())
				Loop
			EndIf

			If cPaisLoc	# "BRA"
				SA6->(DbSetOrder(1))
				SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
				nMoedaBco := Max(SA6->A6_MOEDA,1)
			else
				nMoedaBco:=1
			Endif

			if MV_PAR17==2 .AND. MV_PAR16<>nMoedaBco
				SE5->(dbskip())
				Loop
			endif

			If SE5->E5_RECPAG == "R"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica quais serao impressos                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par07 == 2 .and. (E5_TIPO $ MVRECANT+","+MV_CRNEG)    // So'Normais
					dbSkip()
					Loop
				Endif

				If mv_par07 == 3 .and. !(E5_TIPO $ MVRECANT+","+MV_CRNEG)  //So'Adiantamentos
					dbSkip()
					Loop
				Endif
			ElseIf SE5->E5_RECPAG == "P"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica quais serao impressos                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par07 == 2 .and. ( E5_TIPO $ MVPAGANT+","+MV_CPNEG ) // So'Normais
					dbSkip( )
					Loop
				Endif

				If mv_par07 == 3 .and. E5_TIPO != MVPAGANT+","+MV_CPNEG  //So'Adiantamentos
					dbSkip()
					Loop
				Endif

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Ignora PA's pagos com Junta de Cheque                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If E5_TIPO=="PA " .and. E5_TIPODOC == "BA" .and. !empty(E5_NUMCHEQ)
					DbSkip()
					Loop
				Endif
			Endif

			IF SE5->E5_DTDIGIT > mv_par02
				SE5->(dbSkip( ) )
				Loop
			Endif

			IF SE5->E5_CLIFOR < mv_par04 .Or. SE5->E5_CLIFOR > mv_par05
				SE5->(dbSkip())
				Loop
			EndIF

			if mv_par03 == 1 .and. SE5->E5_RECPAG == "R" .and. SE5->E5_TIPODOC =="ES"
				dbskip()
				loop
			Elseif mv_par03 == 2 .and. SE5->E5_RECPAG == "P" .and. SE5->E5_TIPODOC =="ES"
				dbskip()
				loop
			endif

			IF mv_par03 == 1 .and. SE5->E5_RECPAG != "R"
				If ! (SE5->E5_TIPO $ MVRECANT+","+MV_CRNEG) .And. SE5->E5_TIPODOC != "ES"     //Baixa de RA
					SE5->(dbSkip())
					Loop
				End
			EndIF

			IF mv_par03 == 2 .and. SE5->E5_RECPAG != "P"
				If ! (SE5->E5_TIPO $ MVPAGANT+","+MV_CPNEG) .And. SE5->E5_TIPODOC != "ES"       //Baixa de PA
					SE5->(dbSkip())
					Loop
				End
			End

			If mv_par03 == 1        // Se for baixa de adiantamentos
				If SE5->E5_RECPAG == "R" .and. E5_TIPO $ MVPAGANT+","+MV_CPNEG .And. SE5->E5_TIPODOC $ "VL/BA"
					dbSkip()
					LOOP
				End
			End

			If mv_par03 == 2        // Se for baixa de adiantamentos
				If SE5->E5_RECPAG == "P" .and. E5_TIPO $ MVRECANT+","+MV_CRNEG .And. SE5->E5_TIPODOC $ "VL/BA"
					dbSkip()
					LOOP
				End
			End

			If ! Inside(SE5->E5_TIPO)
				dbSkip()
				Loop
			Endif

			nRec := SE5 -> ( Recno () )
			nPrim:= 0
			cPrefixo := SE5->E5_PREFIXO
			cNumero  := SE5->E5_NUMERO
			cParcela := SE5->E5_PARCELA
			cTipo    := SE5->E5_TIPO
			cNaturez := SE5->E5_NATUREZ
			nValliq  := 0
			cFornece := SE5->E5_CLIFOR
			cLoja    := SE5->E5_LOJA
			dDtDigit := SE5->E5_DTDIGIT
			cRecPag  := SE5->E5_RECPAG
			cSeq     := SE5->E5_SEQ

			IF nAnterior = 0
				cAnterior := cPrefixo+cNumero+cParcela+cTipo+cFornece+Dtos(dDtDigit)+SE5->E5_RECPAG
				nAnterior := 1
				If mv_par10 = 1
					dbSeek(xFilial()+cPrefixo+cNumero+cParcela+cTipo+cFornece+cLoja+cSeq)
				Else
					dbSeek(cPrefixo+cNumero+cParcela+cTipo+cFornece+cLoja+cSeq)
				EndIf
			EndIF

			While ! SE5->(Eof()) .and. SE5->E5_PREFIXO==cPrefixo .and. ;
			SE5->E5_NUMERO==cNumero   .and. ;
			SE5->E5_PARCELA==cParcela .and. ;
			SE5->E5_TIPO==cTipo       .and. ;
			SE5->E5_CLIFOR==cFornece  .and. ;
			SE5->E5_LOJA==cLoja       .and. ;
			SE5->E5_SEQ==cSeq

				If mv_par03 == 2 .and. SE5->E5_CLIFOR+E5_LOJA != cFornece+cLoja
					Exit
				Endif

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Devera' ser considerado o valor sem liquido da baixa         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF Empty(SE5->E5_NUMERO) .Or. SE5->E5_SITUACA = "C"
					SE5->(dbSkip())
					Loop
				EndIF

				IF SE5->E5_DTDIGIT > mv_par02
					SE5->(dbSkip( ) )
					Loop
				End

				IF SE5->E5_CLIFOR < mv_par04 .Or. SE5->E5_CLIFOR > mv_par05
					SE5->(dbSkip())
					Loop
				EndIF

				/*			If cPaisLoc<>"BRA" .and. E5_TIPO=="EF " .and. !Empty(E5_ORDREC)
				dbskip()
				Loop
				Endif
				*/			IF mv_par03 == 1 .and. SE5->E5_RECPAG != "R"
				If ! ( SE5->E5_TIPO $ MVRECANT+","+MV_CRNEG ) .AND. SE5->E5_TIPODOC !="ES"       //Baixa de RA
					SE5->(dbSkip())
					Loop
				Endif
			EndIF

			IF mv_par03 == 2 .and. SE5->E5_RECPAG != "P"
				If ! ( SE5->E5_TIPO $ MVPAGANT+","+MV_CPNEG ) .AND. SE5->E5_TIPODOC !="ES"       //Baixa de PA
					SE5->(dbSkip())
					Loop
				Endif
			Endif


			if MV_PAR17==2 .AND. MV_PAR16 <> nMoedaBco
				SE5->(dbSkip())
				Loop
			endif

			If nPrim == 0
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Localiza o cliente ou fornecedor                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cCarteira := SE5->E5_RECPAG
				If SE5->E5_RECPAG == "R"
					If (SE5->E5_TIPO $ MVPAGANT+","+MV_CPNEG).and.SE5->E5_TIPODOC $ "BAüVL" .and. !Empty(SE5->E5_BANCO);
					.OR. SE5->E5_TIPODOC =="ES"
						cCarteira := "P"        //Baixa de adiantamento (inverte)
					End
				End

				If SE5->E5_RECPAG == "P"
					If SE5->E5_TIPO $ MVRECANT+","+MV_CRNEG .And. SE5->E5_TIPODOC $ "BAüVL" .And.!Empty(SE5->E5_BANCO);
					.OR. SE5->E5_TIPODOC =="ES"
						cCarteira := "R"        //Baixa de adiantamento (inverte)
					End
				End

				IF cCarteira == "R"
					dbSelectArea("SE1")
					If mv_par10 = 1
						dbSetOrder(1)
						dbSeek(xFilial()+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO)
					Else
						dbSeek(SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO)
					EndIf
				Else
					dbSelectArea("SE2")
					If mv_par10 = 1
						dbSetOrder(1)
						dbSeek(xFilial()+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA)
					Else
						dbSeek(SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA)
					EndIf
				End

				dbSelectArea("SE5")
				IF cCarteira == "R"
					dEmissao := SE1->E1_EMISSAO
					dVencto  := SE1->E1_VENCREA
				Else
					dEmissao := SE2->E2_EMISSAO
					dVencto  := SE2->E2_VENCREA
				End
				nPrim++
			End


			If SE5->E5_TIPODOC $ "VLüBAüCPüV2üLJüES"
				nValliq+=xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1)
				IIF(mv_par06==1,GravaTrab("B",dEmissao,dVencto),NIL)
			ElseIf SE5->E5_TIPODOC $ "DC/D2"
				nValliq+=xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1)
				IIF(mv_par06==1,GravaTrab("D",dEmissao,dVencto),NIL)
			Elseif SE5->E5_TIPODOC $ "MT/JR/J2/M2"
				IIF(mv_par06==1,GravaTrab("M",dEmissao,dVencto),NIL)
				nValliq-=xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1)
			Elseif SE5->E5_TIPODOC $ "CM/C2/CX"
				IIF(mv_par06==1,GravaTrab("C",dEmissao,dVencto),NIL)
				nValLiq-=xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1)
			End
			SE5->(dbSkip())
		End
		nRec1 := SE5 -> ( Recno () )
		dbGoto(nRec)
		if mv_par06==2 .and. nValLiq != 0
			GravaTrab("B",dEmissao,dVencto,nValLiq)
		End
		dbGoto(nRec1)
		nAnterior := 0
	End
	Endif
	nTotDebG := 0
	nTotCrdG := 0
	nSalAtuG := 0


	DbSelectArea("cNomeArq")
	oReport:SetMeter(RecCount())
	oSection1:SetHeaderPage()
	oSection2:SetHeaderPage()
	oSection3:SetHeaderSection(.F.)

	DbGoTop()
	While !Eof()

		cCodigo  := CODIGO
		cLoja    := LOJA
		nSaldoAtu:= 0
		nTotDeb     := 0
		nTotCrd  := 0

		nRegAtu := RecNo()
		lImprime := .F.
		While cNomeArq->CODIGO == cCodigo .And. cNomeArq->LOJA == cLoja .And. ! Eof()
			oReport:IncMeter()	
			If (If(mv_par18==1,DATAEMI,EMISSAO) >= mv_par01 )   // Procura titulos no intervalo e
				lImprime := .T.     // se houver, dever  imprimir
				Exit
			Endif
			dbSkip()
		Enddo
		dbGoto(nRegAtu)

		While cNomeArq->CODIGO == cCodigo .And. cNomeArq->LOJA == cLoja .And. ! Eof()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Loop para calculo do saldo anterior                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While cNomeArq->CODIGO == cCodigo .And. cNomeArq->LOJA == cLoja .And. ;
			If(mv_par18==1,cNomeArq->DATAEMI,cNomeArq->EMISSAO) < mv_par01 .And. ! Eof()
				If DC == "C"
					nSaldoAtu += cNomeArq->VALOR
				Else
					nSaldoAtu -= cNomeArq->VALOR
				EndIf

				oReport:IncMeter()

				dbSkip()
				If cNomearq->CODIGO != ccodigo .Or. cNomeArq->LOJA != cLoja
					lNoSkip := .T.
				Endif
			Enddo

			If nQuebra == 0 .and. (lImprime .Or. nSaldoAtu != 0 )
				nQuebra  := 1
				lImprAnt := .F.
				IF mv_par03 == 1
					dbSelectArea("SA1")
					If mv_par10 = 1
						dbSeek(xFilial()+cCodigo+cLoja)
					Else
						If cIndA1 == " "
							cArqTrab :=CriaTrab(NIL,.F.)
							AADD(aInd,cArqTrab)
							cIndA1   :=IndexKey()
							cIndA1   :=Right(cIndA1,Len(cIndA1)-10)
							IndRegua("SA1",cArqTrab,cIndA1,,,STR0011 )  //"Selecionando Registros..."
							dbCommit()
							nIndex:=RetIndex("SA1")
							dbSelectArea("SA1")
							#IFNDEF TOP
							dbSetIndex(cArqTrab+OrdBagEXt())
							#ENDIF
							dbSetOrder(nIndex+1)
						EndIf
						dbSeek(cCodigo+cLoja)
					EndIf
					cNome := SA1->A1_NOME+" "+SA1->A1_CGC+" "+SA1->A1_CONTA
				Else
					dbSelectArea("SA2")
					If mv_par10 = 1
						dbSeek(xFilial()+cCodigo+cLoja)
					Else
						If cIndA2 == " "
							cArqTrab :=CriaTrab(NIL,.F.)
							AADD(aInd,cArqTrab)
							cIndA2   :=IndexKey()
							cIndA2   :=Right(cIndA2,Len(cIndA2)-10)
							IndRegua("SA2",cArqTrab,cIndA2,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
							dbCommit()
							nIndex:=RetIndex("SA2")
							dbSelectArea("SA2")
							#IFNDEF TOP
							dbSetIndex(cArqTrab+OrdBagExt())
							#ENDIF
							dbSetOrder(nIndex+1)
						EndIf
						dbSeek(cCodigo+cLoja)
					EndIf
					cNome := SA2->A2_NOME+" "+SA2->A2_CGC+" "+SA2->A2_CONTA
				EndIF

				If cPaisLoc == "BRA" 
					oSection1:Init()

					oSection1:Cell("DESCCOL1"):SetBlock({|| cCodigo + "-" + cLoja + " " + cNome })	
					oSection1:PrintLine()
					oSection1:Finish()

					dbSelectArea("cNomeArq")

					oSection2:Init()

					oSection2:Cell("DATA"):Hide()

					oSection2:Cell("HISTORICO"):SetBlock({||OemToAnsi(STR0016)}) 

					oSection2:Cell("PREFIXO"):Hide()
					oSection2:Cell("E2_NUM"):Hide()
					oSection2:Cell("E2_PARCELA"):Hide()
					oSection2:Cell("E2_EMISSAO"):Hide()
					oSection2:Cell("E2_VENCTO"):Hide()
					oSection2:Cell("E2_BAIXA"):Hide()
					oSection2:Cell("DEBITO"):Hide()
					oSection2:Cell("CREDITO"):Hide()
					oSection2:Cell("SALDO"):SetBlock({||Abs(nSaldoAtu)})
					oSection2:Cell("TPSALDO"):SetBlock({|| IIF(nSaldoAtu<0," D",IIF(nSaldoAtu>0," C"," "))})
					oSection2:PrintLine()
					oSection2:Finish()
					nSalAntG += nSaldoAtu

				Else

					If mv_par03 == 1
						SA1->( dbSetOrder(1) )
						SA1->( dbSeek(xFilial("SA1")+cCodigo+cLoja) )
					Else
						SA2->( dbSetOrder(1) )
						SA2->( dbSeek(xFilial("SA2")+cCodigo+cLoja) )
					Endif


					oSection1:Init()
					oSection1:Cell("DESCCOL1"):SetBlock({|| If(mv_par03==1,Subs(SA1->A1_NOME,1,40),Subs(SA2->A2_NOME,1,40) ) })	
					oSection1:Cell("DESCCOL2"):SetBlock({||cCodigo + "-" + cLoja })	
					oSection1:PrintLine()
					oSection1:Finish()


					oSection2:Init()

					oSection2:Cell("DATA"):Hide()

					oSection2:Cell("HISTORICO"):SetBlock({||OemToAnsi(STR0016)}) 

					oSection2:Cell("PREFIXO"):Hide()
					oSection2:Cell("E2_NUM"):Hide()
					oSection2:Cell("E2_PARCELA"):Hide()
					oSection2:Cell("E2_EMISSAO"):Hide()
					oSection2:Cell("E2_VENCTO"):Hide()
					oSection2:Cell("E2_BAIXA"):Hide()
					oSection2:Cell("DEBITO"):Hide()
					oSection2:Cell("CREDITO"):Hide()
					oSection2:Cell("SALDO"):SetBlock({||Abs(nSaldoAtu)})
					oSection2:Cell("TPSALDO"):SetBlock({||IIF(nSaldoAtu>0,"D",IIF(nSaldoAtu<0,"C"," "))})
					oSection2:PrintLine()
					oSection2:Finish()

					nSalAntG += nSaldoAtu
					oReport:SkipLine()


					If mv_par03 == 1
						SX5->( dbSetOrder(1) )
						SX5->( dbSeek(xFilial("SX5")+"12"+SA1->A1_EST) )
						cProvincia := X5DESCRI()
						cTipoCli := TABELA("SF",SA1->A1_TIPO,.F.)

						oSection1:Init()
						oSection1:Cell("DESCCOL1"):SetBlock({|| SA1->A1_END})	
						oSection1:Cell("DESCCOL2"):SetBlock({|| RetTitle("A1_TEL")+SA1->A1_TEL})	
						oSection1:Cell("DESCCOL3"):SetBlock({|| OemToAnsi(STR0038) +SA1->A1_VEND})	
						oSection1:PrintLine()

						oSection1:Cell("DESCCOL1"):SetBlock({|| SA1->A1_CEP+" - " +SA1->A1_MUN})	
						oSection1:Cell("DESCCOL2"):SetValue("")
						oSection1:Cell("DESCCOL3"):SetValue("")
						oSection1:PrintLine()	


						oSection1:Cell("DESCCOL1"):SetBlock({|| cTipoCli})	
						oSection1:Cell("DESCCOL2"):SetBlock({|| Transform(SA1->A1_CGC,Pesqpict("SA1","A1_CGC"))})	
						oSection1:Cell("DESCCOL3"):SetValue("")
						oSection1:PrintLine()					

						oSection1:Cell("DESCCOL1"):SetBlock({|| cProvincia})	
						oSection1:Cell("DESCCOL2"):SetValue("")
						oSection1:Cell("DESCCOL3"):SetValue("")
						oSection1:PrintLine()					
						oSection1:Finish()
						oReport:SkipLine()				

					Else
						SX5->( dbSetOrder(1) )
						SX5->( dbSeek(xFilial("SX5")+"12"+SA2->A2_EST) )
						cProvincia := X5DESCRI()
						cTipoCli := TABELA("SF",SA2->A2_TIPO,.F.)

						oSection1:Init()
						oSection1:Cell("DESCCOL1"):SetBlock({|| SA2->A2_END})	
						oSection1:Cell("DESCCOL2"):SetBlock({|| RetTitle("A2_TEL")+SA2->A2_TEL})	
						oSection1:Cell("DESCCOL3"):SetBlock({|| OemToAnsi(STR0039)})	
						oSection1:PrintLine()

						oSection1:Cell("DESCCOL1"):SetBlock({||  SA2->A2_CEP+" - " +SA2->A2_MUN})	
						oSection1:Cell("DESCCOL2"):SetValue("")
						oSection1:Cell("DESCCOL3"):SetValue("")
						oSection1:PrintLine()	                

						oSection1:Cell("DESCCOL1"):SetBlock({|| cTipoCli})	
						oSection1:Cell("DESCCOL2"):SetBlock({|| Transform(SA2->A2_CGC,Pesqpict("SA2","A2_CGC"))})	
						oSection1:Cell("DESCCOL3"):SetValue("")
						oSection1:PrintLine()					

						oSection1:Cell("DESCCOL1"):SetBlock({|| cProvincia})	
						oSection1:Cell("DESCCOL2"):SetValue("")
						oSection1:Cell("DESCCOL3"):SetValue("")
						oSection1:PrintLine()					
						oSection1:Finish()
						oReport:SkipLine()				

					EndIf

				EndIf

			End
			dbSelectArea("cNomeArq")

			If (If(mv_par18==1,cNomeArq->DATAEMI,cNomeArq->EMISSAO) >= mv_par01 ).And. !lNoSkip
				If DC == "D"
					nSaldoAtu -= cNomeArq->VALOR
					nTotDeb   += cNomeArq->VALOR
					nTotDebG  += cNomeArq->VALOR
					nSalAtuG  -= cNomeArq->VALOR
				Else
					nSaldoAtu += cNomeArq->VALOR
					nTotCrd   += cNomeArq->VALOR
					nTotCrdG  += cNomeArq->VALOR
					nSalAtuG  += cNomeArq->VALOR
				End
				If mv_par14 == 1  // Analitico 
					oSection2:Cell("DATA"):Show()
					oSection2:Cell("HISTORICO"):Show()
					oSection2:Cell("PREFIXO"):Show()
					oSection2:Cell("E2_NUM"):Show()
					oSection2:Cell("E2_PARCELA"):Show()
					oSection2:Cell("E2_EMISSAO"):Show()
					oSection2:Cell("E2_VENCTO"):Show()
					If Empty(cNomeArq->BAIXA)
						oSection2:Cell("E2_BAIXA"):Hide()
					Else
						oSection2:Cell("E2_BAIXA"):Show()				
					EndIf
					oSection2:Cell("DEBITO"):Show()
					oSection2:Cell("CREDITO"):Show()


					oSection2:Init()

					oSection2:Cell("DATA"):SetBlock({||DtoC(cNomeArq->DATAEMI)}) 

					If Subs(HISTOR,1,7)== OemToAnsi(STR0041)	// "Recibo:"
						oSection2:Cell("HISTORICO"):SetBlock({||OemToAnsi(STR0040) + SubStr(cNomeArq->HISTOR,8,8)})	// "RECIBO No.: "
					ElseIf Subs(HISTOR,1,11)== OemToAnsi(STR0043)	// "Baja recibo"
						oSection2:Cell("HISTORICO"):SetBlock({||OemToAnsi(STR0040) + SubStr(cNomeArq->HISTOR,17,6)}) 
					Else
						oSection2:Cell("HISTORICO"):SetBlock({||SubStr(cNomeArq->HISTOR,1,40)}) 
					EndIf
					oSection2:Cell("PREFIXO"):SetBlock({||SubStr(cNomeArq->NUMERO, 1,TamSX3("E2_PREFIXO")[1])}) 
					oSection2:Cell("E2_NUM"):SetBlock({||SubStr(cNomeArq->NUMERO, TamSX3("E2_PREFIXO")[1]+1, TamSX3("E2_NUM")[1])}) 
					oSection2:Cell("E2_PARCELA"):SetBlock({||SubStr(cNomeArq->NUMERO,TamSX3("E2_PREFIXO")[1]+TamSX3("E2_NUM")[1]+1,TamSX3("E2_PARCELA")[1])})
					oSection2:Cell("E2_EMISSAO"):SetBlock({||cNomeArq->EMISSAO}) 
					oSection2:Cell("E2_VENCTO"):SetBlock({||cNomeArq->VENCTO}) 
					oSection2:Cell("E2_BAIXA"):SetBlock({||cNomeArq->BAIXA}) 

					IF(DC=="D")
						oSection2:Cell("DEBITO"):SetBlock({||cNomeArq->VALOR}) 
						oSection2:Cell("CREDITO"):Hide()
					Else
						oSection2:Cell("DEBITO"):Hide()
						oSection2:Cell("CREDITO"):SetBlock({||cNomeArq->VALOR})				
					EndIf
					oSection2:Cell("SALDO"):SetBlock({||Abs(nSaldoAtu)})
					oSection2:Cell("TPSALDO"):SetBlock({|| IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))})
					oSection2:PrintLine()


				Endif
			End
			lFlag := .T.
			If ! lNoSkip
				oReport:IncMeter()
				dbSkip( )
			End
			lNoSkip := .F.
		End
		If lImprime .Or. nSaldoAtu != 0
			oReport:SkipLine(IIF(mv_par14 == 1 , 2 , 1 ))
			oReport:PrintText(OemToAnsi(STR0017)+IIF(mv_par03==1,OemToAnsi(STR0018),OemToAnsi(STR0019)) ) //"T o t a i s  d o  "###"C l i e n t e"###"F o r n e c e d o r"
			oSection2:Init()
			oSection2:Cell("HISTORICO"):SetValue("")
			oSection2:Cell("DATA"):SetValue("")
			oSection2:Cell("PREFIXO"):SetValue("")
			oSection2:Cell("E2_NUM"):SetValue("")
			oSection2:Cell("E2_PARCELA"):SetValue("")
			oSection2:Cell("E2_EMISSAO"):SetValue("")
			oSection2:Cell("E2_VENCTO"):SetValue("")
			oSection2:Cell("E2_BAIXA"):SetValue("")
			oSection2:Cell("DEBITO"):Show()
			oSection2:Cell("CREDITO"):Show()
			oSection2:Cell("SALDO"):Show()
			oSection2:Cell("TPSALDO"):Show()

			oSection2:Cell("DEBITO"):SetBlock({||nTotDeb})
			oSection2:Cell("CREDITO"):SetBlock({||nTotCrd})
			oSection2:Cell("SALDO"):SetBlock({||Abs(nSaldoAtu)})
			oSection2:Cell("TPSALDO"):SetBlock({|| IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))})
			oSection2:PrintLine()
			oSection2:Finish()
			oreport:SkipLine()
			oReport:ThinLine()
		Endif
		nQuebra:=0
	End

	If nQuebra # 0 .and.(lImprime .Or. nSaldoAtu != 0)
		oReport:SkipLine()
		oReport:PrintText(OemToAnsi(STR0017)+IIF(mv_par03==1,OemToAnsi(STR0018),OemToAnsi(STR0019)))  //"T o t a i s  d o  "###"C l i e n t e"###"F o r n e c e d o r"
		oSection2:Init()
		oSection2:Cell("HISTORICO"):SetValue("")
		oSection2:Cell("DATA"):SetValue("")
		oSection2:Cell("PREFIXO"):SetValue("")
		oSection2:Cell("E2_NUM"):SetValue("")
		oSection2:Cell("E2_PARCELA"):SetValue("")
		oSection2:Cell("E2_EMISSAO"):SetValue("")
		oSection2:Cell("E2_VENCTO"):SetValue("")
		oSection2:Cell("E2_BAIXA"):SetValue("") 
		oSection2:Cell("DEBITO"):Show()
		oSection2:Cell("CREDITO"):Show()
		oSection2:Cell("SALDO"):Show()
		oSection2:Cell("TPSALDO"):Show()
		oSection2:Cell("DEBITO"):SetBlock({||nTotDeb})
		oSection2:Cell("CREDITO"):SetBlock({||nTotCrd})
		oSection2:Cell("SALDO"):SetBlock({||Abs(nSaldoAtu)})
		oSection2:Cell("TPSALDO"):SetBlock({||IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu<0,"C"," "))})
		oSection2:PrintLine()
		oSection2:Finish()
	End
	If lFlag
		oReport:SkipLine()  
		oReport:PrintText( OemToAnsi(STR0020)+IIF(mv_par03==1,OemToAnsi(STR0021),OemToAnsi(STR0022)))  //"T o t a l   G e r a l  d o s  "###"C l i e n t e s"###"F o r n e c e d o r e s"

		oSection2:Init()
		oSection2:Cell("HISTORICO"):SetValue("")
		oSection2:Cell("DATA"):SetValue("")
		oSection2:Cell("PREFIXO"):SetValue("")
		oSection2:Cell("E2_NUM"):SetValue("")
		oSection2:Cell("E2_PARCELA"):SetValue("")
		oSection2:Cell("E2_EMISSAO"):SetValue("")
		oSection2:Cell("E2_VENCTO"):SetValue("")
		oSection2:Cell("E2_BAIXA"):SetValue("")
		oSection2:Cell("DEBITO"):Show()
		oSection2:Cell("CREDITO"):Show()
		oSection2:Cell("SALDO"):Show()
		oSection2:Cell("TPSALDO"):Show()
		oSection2:Cell("DEBITO"):SetBlock({||nTotDebG})
		oSection2:Cell("CREDITO"):SetBlock({||nTotCrdG})
		oSection2:Cell("SALDO"):SetBlock({||Abs(nSalAtuG)})
		oSection2:Cell("TPSALDO"):SetBlock({||IIF(nSalAtuG<0,"D",IIF(nSalAtuG>0,"C"," "))})

		oSection2:PrintLine()


		oReport:SkipLine()
		oReport:ThinLine()
		oReport:SkipLine()
		oReport:PrintText(OemToAnsi(STR0023) ) //"S a l d o   F i n a l   d o   R e l a t o r i o : "
		nSaldoFinal := (nSalAntG-nTotDebG+nTotCrdG)
		oSection2:Cell("SALDO"):Show()
		oSection2:Cell("TPSALDO"):Show()
		oSection2:Cell("DEBITO"):Hide()
		oSection2:Cell("CREDITO"):Hide()
		oSection2:Cell("DEBITO"):SetValue("")
		oSection2:Cell("CREDITO"):SetValue("")
		oSection2:Cell("SALDO"):Show()
		oSection2:Cell("TPSALDO"):Show()

		oSection2:Cell("SALDO"):SetBlock({||Abs(nSaldoFinal)})
		oSection2:Cell("TPSALDO"):SetBlock({||IIF(nSaldoFinal<0,"D",IIF(nSaldoFinal>0,"C"," "))})
		oSection2:PrintLine()
		oSection2:Finish()

		oReport:SkipLine()
		oReport:FatLine()
	End

	//gsa dbSelectArea("cNomeArq")
	//gsa Use
	//GSA
	If oTmpTable <> Nil   //gsa
		oTmpTable:Delete()  //gsa
		oTmpTable := Nil //gsa
	Endif //gsa

	dbSelectArea("SA1")
	RetIndex("SA1")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SA2")
	RetIndex("SA2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE1")
	RetIndex("SE1")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE2")
	RetIndex("SE2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE5")
	RetIndex("SE5")
	dbSetOrder(1)
	DbClearFilter()

	For nI:=1 to Len(aInd)
		if File(aInd[nI]+OrdBagExt())
			Ferase(aInd[nI]+OrdBagExt())
		Endif
		If File(aInd[nI]+GetDBExtension())
			Ferase(aInd[nI]+GetDBExtension())
		Endif
	Next

	oSection2:Cell("DATA"):SetValue("")
	oSection2:Cell("PREFIXO"):SetValue("")
	oSection2:Cell("E2_NUM"):SetValue("")
	oSection2:Cell("E2_PARCELA"):SetValue("")
	oSection2:Cell("E2_EMISSAO"):SetValue("")
	oSection2:Cell("E2_VENCTO"):SetValue("")
	oSection2:Cell("E2_BAIXA"):SetValue("")
	oSection2:Cell("DEBITO"):SetValue("")
	oSection2:Cell("CREDITO"):SetValue("")
	oSection2:Cell("HISTORICO"):SetValue("")
	oSection2:Cell("SALDO"):SetValue("")
	oSection2:Cell("TPSALDO"):SetValue("")
	lImp:=.F.
Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³F551RODAPE³ Autor ³ Paulo Augusto         ³ Data ³ 10.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ rotina de impressao dos totais na quebra da pagina R4      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ F551RODAPE                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Localizacoes Paises do ConeSul...                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß


Static Function F551RODAPE(oReport,oSection1,oSection3,nSaldoAtu,lImp)

If lImp
oReport:SkipLine()
oSection3:Init()

oSection3:Cell("DATA"):Hide()

oSection3:Cell("HISTORICO"):SetBlock({|| OemToAnsi(STR0015)}) 

oSection3:Cell("PREFIXO"):Hide()
oSection3:Cell("E2_NUM"):Hide()
oSection3:Cell("E2_PARCELA"):Hide()
oSection3:Cell("E2_EMISSAO"):Hide()
oSection3:Cell("E2_VENCTO"):Hide()
oSection3:Cell("E2_BAIXA"):Hide()
oSection3:Cell("DEBITO"):Hide()
oSection3:Cell("CREDITO"):Hide()                                                      

oSection3:Cell("SALDO"):Show()
oSection3:Cell("TPSALDO"):Show()

oSection3:Cell("SALDO"):SetBlock({||Abs(nSaldoAtu) })
oSection3:Cell("TPSALDO"):SetBlock({||IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))})
oSection3:PrintLine()
oSection3:Finish()   
nValTran:=nSaldoAtu
EndIf
Return()


ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³F551TRANSP³ Autor ³ Paulo Augusto         ³ Data ³ 10.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do cabecalho na quebra de pagina R4              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ F551RODAPE                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Localizacoes Paises do ConeSul...                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Static Function F551TRANSP(oReport,oSection1,oSection3,nquebra,nValTran,cCodigo,cLoja)

If nQuebra == 1  .And. oReport:Page() >1
If mv_par03==1
dbSelectArea("SA1")
If mv_par10 = 1
dbSeek(xFilial()+cCodigo+cLoja)
Else
If cIndA1 == " "
cArqTrab :=CriaTrab(NIL,.F.)
AADD(aInd,cArqTrab)
cIndA1   :=IndexKey()
cIndA1   :=Right(cIndA1,Len(cIndA1)-10)
IndRegua("SA1",cArqTrab,cIndA1,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
dbCommit()
nIndex:=RetIndex("SA1")
dbSelectArea("SA1")
#IFNDEF TOP
dbSetIndex(cArqTrab+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
EndIf
dbSeek(cCodigo+cLoja)
EndIf
cNome := SA1->A1_NOME+" "+SA1->A1_CGC+" "+SA1->A1_CONTA
Else
dbSelectArea("SA2")
If mv_par10 = 1
dbSeek(xFilial()+cCodigo+cLoja)
Else
If cIndA2 == " "
cArqTrab :=CriaTrab(NIL,.F.)
AADD(aInd,cArqTrab)
cIndA2   :=IndexKey()
cIndA2   :=Right(cIndA2,Len(cIndA2)-10)
IndRegua("SA2",cArqTrab,cIndA2,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
dbCommit()
nIndex:=RetIndex("SA2")
dbSelectArea("SA2")
#IFNDEF TOP
dbSetIndex(cArqTrab+ordBagExt())
#ENDIF
dbSetOrder(nIndex+1)
EndIf
dbSeek(cCodigo+cLoja)
EndIf
cNome := SA2->A2_NOME+" "+SA2->A2_CGC+" "+SA2->A2_CONTA
EndIF
If cPaisLoc == 'BRA'

oSection1:Init()

oSection1:Cell("DESCCOL1"):SetBlock({||cCodigo + "-" + cLoja + " " + cNome })	
oSection1:PrintLine()
oSection1:Finish()

dbSelectArea("cNomeArq")

oSection3:Init()

oSection3:Cell("DATA"):Hide()
oSection3:Cell("HISTORICO"):SetBlock({||OemToAnsi(STR0028)}) 
oSection3:Cell("PREFIXO"):Hide()
oSection3:Cell("E2_NUM"):Hide()
oSection3:Cell("E2_PARCELA"):Hide()
oSection3:Cell("E2_EMISSAO"):Hide()
oSection3:Cell("E2_VENCTO"):Hide()
oSection3:Cell("E2_BAIXA"):Hide()
oSection3:Cell("DEBITO"):Hide()
oSection3:Cell("CREDITO"):Hide()
oSection3:Cell("SALDO"):SetBlock({||Abs(nValTran)})
oSection3:Cell("TPSALDO"):SetBlock({|| IIF(nValTran<0," D",IIF(nValTran>0," C"," "))})
oSection3:PrintLine()
oSection3:Finish()
Else
If mv_par03 == 1
SA1->( dbSetOrder(1) )
SA1->( dbSeek(xFilial("SA1")+cCodigo+cLoja) )
Else
SA2->( dbSetOrder(1) )
SA2->( dbSeek(xFilial("SA2")+cCodigo+cLoja) )
Endif


oSection1:Init()

oSection1:Cell("DESCCOL1"):SetBlock({||If(mv_par03==1,Subs(SA1->A1_NOME,1,40),Subs(SA2->A2_NOME,1,40) ) })	
oSection1:Cell("DESCCOL2"):SetBlock({||cCodigo + "-" + cLoja })	
oSection1:PrintLine()
oSection1:Finish()

dbSelectArea("cNomeArq")

oSection3:Init()

oSection3:Cell("DATA"):Hide()
oSection3:Cell("HISTORICO"):SetBlock({||OemToAnsi(STR0028) }) 
oSection3:Cell("PREFIXO"):Hide()
oSection3:Cell("E2_NUM"):Hide()
oSection3:Cell("E2_PARCELA"):Hide()
oSection3:Cell("E2_EMISSAO"):Hide()
oSection3:Cell("E2_VENCTO"):Hide()
oSection3:Cell("E2_BAIXA"):Hide()
oSection3:Cell("DEBITO"):Hide()
oSection3:Cell("CREDITO"):Hide()
oSection3:Cell("SALDO"):SetBlock({||Abs(nValTran)})
oSection3:Cell("TPSALDO"):SetBlock({|| IIF(nValTran<0," D",IIF(nValTran>0," C"," "))})
oSection3:PrintLine()
oSection3:Finish()

SX5->( dbSetOrder(1) )

If mv_par03 == 1
SX5->( dbSeek(xFilial("SX5")+"12"+SA1->A1_EST) )
cProvincia := X5DESCRI()
cTipoCli := TABELA("SF",SA1->A1_TIPO,.F.)

oSection1:Init()

oSection1:Cell("DESCCOL1"):SetBlock({||SA1->A1_END})	
oSection1:Cell("DESCCOL2"):SetBlock({||RetTitle("A1_TEL") +SA1->A1_TEL })	
oSection1:Cell("DESCCOL3"):SetBlock({||OemToAnsi(STR0038) +SA1->A1_VEND})	
oSection1:PrintLine()

oSection1:Cell("DESCCOL1"):SetBlock({||SA1->A1_CEP+" - " +SA1->A1_MUN})	
oSection1:Cell("DESCCOL2"):SetValue()
oSection1:Cell("DESCCOL3"):SetValue()
oSection1:PrintLine()


oSection1:Cell("DESCCOL1"):SetBlock({||cTipoCli})	
oSection1:Cell("DESCCOL2"):SetBlock({||Transform(SA1->A1_CGC,PESQPICT("SA1","A1_CGC")) })	
oSection1:Cell("DESCCOL3"):SetValue()
oSection1:PrintLine()


oSection1:Cell("DESCCOL1"):SetBlock({||cProvincia})	
oSection1:Cell("DESCCOL2"):SetValue()
oSection1:Cell("DESCCOL3"):SetValue()
oSection1:PrintLine()

Else
SX5->( dbSeek(xFilial("SX5")+"12"+SA2->A2_EST) )
cProvincia := X5DESCRI()
cTipoCli := TABELA("SF",SA2->A2_TIPO,.F.)

oSection1:Cell("DESCCOL1"):SetBlock({||SA2->A2_END})	
oSection1:Cell("DESCCOL2"):SetBlock({||"Te: "+SA2->A2_TEL})	
oSection1:Cell("DESCCOL3"):SetBlock({||OemToAnsi(STR0039)})	
oSection1:PrintLine()

oSection1:Cell("DESCCOL1"):SetBlock({||SA2->A2_CEP+" - " +SA2->A2_MUN})	
oSection1:Cell("DESCCOL2"):SetValue()
oSection1:Cell("DESCCOL3"):SetValue()
oSection1:PrintLine()



oSection1:Cell("DESCCOL1"):SetBlock({||cTipoCli})	
oSection1:Cell("DESCCOL2"):SetBlock({||Transform(SA2->A2_CGC,PESQPICT("SA2","A2_CGC"))})	
oSection1:Cell("DESCCOL3"):SetValue()
oSection1:PrintLine()


oSection1:Cell("DESCCOL1"):SetBlock({||cProvincia})	
oSection1:Cell("DESCCOL2"):SetValue()
oSection1:Cell("DESCCOL3"):SetValue()
oSection1:PrintLine()
oSection1:Finish()
oReport:SkipLine()
EndIf
EndIf
EndIf                            
Return()
/*/

/*----------------------------------------------------------------------------R3------------------------------------------------*/

User Function Finr551R3()      
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOCAL cDesc1 :=OemToAnsi(STR0001)  //"Este relatorio ir  imprimir o razonete de Clientes ou"
	LOCAL cDesc2 :=OemToAnsi(STR0002)  //"Fornecedores. Poder  ser emitida toda a movimenta‡„o "
	LOCAL cDesc3 :=OemToAnsi(STR0003)  //"dos mesmos, ou somente os valores originais."
	LOCAL wnrel
	LOCAL limite := 132
	LOCAL cString:="SE1"
	LOCAL Tamanho:= "M"

	PRIVATE titulo :=OemToAnsi(STR0004)  //"Razonete de Contas Correntes"
	PRIVATE cabec1
	PRIVATE cabec2
	PRIVATE aReturn := { OemToAnsi(STR0005), 1, OemToAnsi(STR0006) , 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
	PRIVATE nomeprog:= "FINR551"
	PRIVATE aLinha  := { },nLastKey := 0
	PRIVATE cPerg   := "FIN551"
	Private cTipos           := ""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	pergunte("FIN551",.F.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ponto de entrada para Filtrar os tipos sem entrar na tela do ³
	//³ FINRTIPOS(), localizacao Argentina.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	IF cPaisLoc <> "BRA" .And. EXISTBLOCK("FARGTIP")
		cTipos   := EXECBLOCK("FARGTIP")
	ENDIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                        ³
	//³ mv_par01            // A partir de                          ³
	//³ mv_par02            // Ate a data                           ³
	//³ mv_par03            // Carteira (Receber ou Pagar)          ³
	//³ mv_par04            // Do Codigo                            ³
	//³ mv_par05            // Ate o Codigo                         ³
	//³ mv_par06            // Imprime Valores Financeiros (Sim/Nao)³
	//³ mv_par07            // Impime (Todos,Normais,Adiantamentos) ³
	//³ mv_par08            // Do Prefixo                           ³
	//³ mv_par09            // Ate o Prefixo                        ³
	//³ mv_par09            // Ate o Prefixo                        ³
	//³ mv_par10            // Lista Por 1 - Filial     2 -Empresa  ³
	//³ mv_par11            // Seleciona Tipos                      ³
	//³ mv_par12            // Natureza de  ?                       ³
	//³ mv_par13            // Natureza ate ?                       ³
	//³ mv_par14            // Anal¡tico/Sint‚tico                  ³
	//³ mv_par15            // Todos/Em Aberto                      ³
	//³ mv_par16            // Cual Moneda                          ³
	//³ mv_par17            // Otras Moneda  Converter/No Imprimir  ³
	//³ mv_par18            // Por fecha/Factura                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel := "FINR551"            //Nome Default do relatorio em Disco
	wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,Tamanho,"",.F.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	#IFDEF WINDOWS
	RptStatus({|lEnd| FA551Imp(@lEnd,wnRel,cString)},titulo)
	#ELSE
	fA551Imp(.f.,Wnrel,cString)
	#ENDIF
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FA551Imp ³ Autor ³ Wagner Xavier         ³ Data ³ 25.02.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Razonete de Cliente/Fornecedores                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA551Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FA551Imp(lEnd,wnRel,cString)

	LOCAL CbCont,CbTxt
	LOCAL tamanho:="M"
	LOCAL nQuebra:=0,lImprAnt := .F.
	LOCAL cNome,nTotDeb:=0,nTotCrd:=0,nSaldoAtu:=0,nTotDebG:=0,nTotCrdG:=0,nSalAtuG:=0,nSalAntG:=0
	LOCAL aSaldos:={},j,dEmissao:=CTOD(""),dVencto:=CTOD("")
	LOCAL nRec,nPrim,cPrefixo,cNumero,cParcela,cTipo,cNaturez,nValliq
	LOCAL nAnterior:=0,cAnterior,cFornece,dDtDigit,cRecPag,nRec1,cSeq
	LOCAL nTotAbat,  cCodigo, cLoja
	LOCAL nRegistro
	LOCAL lNoSkip := .T.
	LOCAL lFlag := .F.
	LOCAL nSaldoFinal:=0
	LOCAL aCampos:={},aTam:={}
	LOCAL aInd:={}
	LOCAL cCondE1:=cCondE2:=cCondE5:=" "
	LOCAL cIndE1 :=cIndE2 :=cIndE5 :=cIndA1 :=cIndA2 :=" "
	LOCAL nRegAtu,lImprime
	Local cOrdem	:=""
	LOCAL nRegSe1Atu := SE1->(RecNo())
	LOCAL nOrdSe1Atu := SE1->(IndexOrd())
	LOCAL lBaixa     := .F.
	LOCAL nRegSe2Atu := SE2->(RecNo())
	LOCAL nOrdSe2Atu := SE2->(IndexOrd())
	LOCAL cChaveSe1
	LOCAL cChaveSe2
	LOCAL nDecs:=MsDecimais(MV_PAR16)
	LOCAL cPosTp
	Local cUniao	 := Alltrim(GetMv("MV_UNIAO"))
	Local nX,nI
	Local cSimb  	:=	""
	Local cSimbolo	:=	""

	If cPaisLoc != "BRA"
		For nX := 1 to MoedFin()                
			cSimbolo := GetMv("MV_SIMB"+Str(nX,1))
			If !Empty(cSimbolo)
				cSimb    += PadR(cSimbolo,3)+","
			EndIf
			cSimbolo    := ""   
		Next nX
		cSimb  := Substr(cSimb,1,len(cSimb)-1)  //Contem os simbolos das moedas utilizadas pelo sistema 
	EndIf                                       //para realizar o filtro

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cbtxt    := SPACE(10)
	cbcont   := 0
	li       := 80
	m_pag  := 1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Referencia para imprimir descricao dos tipos de cliente A1_TIPO ³
	//ÀÄLocalizacoesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc != "BRA"
		SX3->(dbSetOrder(2))
		SX3->(dbSeek("A1_TIPO"))
		If SX3->(Found())
			cTipoCli := AllTrim(SX3->(X3CBox()) )
			cTipoCli := '{"'+StrTran(cTipoCli,';','","')+'"}'
			aTipoCli := &(cTipoCli)
		Else
			cTipoCli := ""
			aTipoCli := {}
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se seleciona tipos                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par11 == 1
		finRTipos()
	End

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao dos cabecalhos                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	titulo := OemToAnsi(STR0007)+IIF(mv_par03==1,OemToAnsi(STR0008), OemToAnsi(STR0009))  //"RAZONETE DE CONTAS CORRENTES DE "###"CLIENTES"###"FORNECEDORES"
	cabec1 := OemToAnsi(STR0010)  //"DATA     HISTORICO             PRF NUMERO       PC  EMISSAO   VENCTO    BAIXA             DEBITO          CREDITO     SALDO ATUAL"
	cabec2 :=""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gera arquivo de Trabalho                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aTam:=TamSX3("E1_CLIENTE")
	AADD(aCampos,{"CODIGO" ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_LOJA")
	AADD(aCampos,{"LOJA"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_EMISSAO")
	AADD(aCampos,{"DATAEMI","D",aTam[1],aTam[2]})
	AADD(aCampos,{"NUMERO" ,"C",16,0})
	aTam:=TamSX3("E1_TIPO")
	AADD(aCampos,{"TIPO"   ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_PORTADO")
	AADD(aCampos,{"BANCO"  ,"C",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_EMISSAO")
	AADD(aCampos,{"EMISSAO","D",aTam[1],aTam[2]})
	AADD(aCampos,{"BAIXA"  ,"D",aTam[1],aTam[2]})
	aTam:=TamSX3("E1_VENCREA")
	AADD(aCampos,{"VENCTO" ,"D",aTam[1],aTam[2]})
	AADD(aCampos,{"VALOR"  ,"N",18,2})
	AADD(aCampos,{"HISTOR" ,"C",40,0})
	AADD(aCampos,{"DC"     ,"C", 1,0})

	//cNomeArq:=CriaTrab(aCampos) //leem
	//dbUseArea( .T., __cRDDNTTS, cNomeArq, "cNomeArq", if(.F. .Or. .F., !.F., NIL), .F. ) //leem

	//Creacion de Objeto

	oTmpTable := FWTemporaryTable():New("cNomeArq") //leem
	oTmpTable:SetFields( aCampos ) //leem

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia rotina de impressao                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//dbSelectArea("cNomeArq") //leem

	If mv_par18 == 1
		aOrdem	:=	{"CODIGO","LOJA","DATAEMI","NUMERO","HISTOR"} //leem
	Else
		aOrdem	:=	{"CODIGO","LOJA","EMISSAO","NUMERO","TIPO","DTOS(BAIXA)","HISTOR"} //leem
	Endif

	//IndRegua("cNomeArq",cNomeArq,cOrdem,,,OemToAnsi(STR0011))  //"Selecionando Registros..." //leem
	//dbGoTop() //leem

	oTmpTable:AddIndex("T1ORD1", aOrdem) //leem

	//Creacion de la tabla

	oTmpTable:Create() //leem

	IF mv_par03 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza e grava titulos a receber dentro dos parametros     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE1")
		dbSetOrder(2) // Filial+Cliente+Loja+Prefixo+Num+Parcela+Tipo
		If mv_par10 = 1 // 1=Filial ou 2=Empresa
			dbSeek(xFilial()+mv_par04,.T.)
			cCondE1:="'"+xFilial()+"'==E1_FILIAL .and. SE1->E1_CLIENTE >= '"+mv_par04+"' .And. SE1->E1_CLIENTE <= '"+mv_par05+"'"
		Else
			cArqTrab :=CriaTrab(NIL,.F.)
			AADD(aInd,cArqTrab)
			cIndE1   :=IndexKey()
			cIndE1   :=Right(cIndE1,Len(cIndE1)-10)
			IndRegua("SE1",cArqTrab,cIndE1,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
			cCondE1:="E1_CLIENTE >='" +mv_par04+"' .And. SE1->E1_CLIENTE <='"+ mv_par05+"'"
			dbCommit()
			nIndex:=RetIndex("SE1")
			dbSelectArea("SE1")
			#IFNDEF TOP
			dbSetIndex(cArqTrab+OrdBagExt())
			#ENDIF
			dbSetOrder(nIndex+1)
			dbSeek(mv_par04,.T.)
		EndIf
		While !SE1->(Eof()) .and. &(cCondE1)

			If mv_par15 <> 1 .And.SE1->E1_SALDO <= 0
				SE1->(dbSkip())
				Loop
			Endif
			If SE1->E1_PREFIXO < mv_par08 .Or. SE1->E1_PREFIXO > mv_par09 .or. SE1->E1_EMISSAO > dDataBase
				SE1->(dbSkip())
				Loop
			End

			If ( SE1->E1_NATUREZ < mv_par12 .Or. SE1->E1_NATUREZ > mv_par13 )
				SE1->(dbSkip())
				Loop
			EndIf

			IF SubStr(SE1->E1_TIPO,1,2) == MVPROVIS
				SE1->(dbSkip())
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica quais serao impressos                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par07 == 1 .And. (E1_TIPO $ MVRECANT+","+MV_CRNEG .Or. Substr(E1_TIPO,3,1)=="-") .And. ;
			E1_PREFIXO == "REC" // Exclui Adiantamentos gerados por recibo para nao serem considerados duas vezes
				dbSkip( )
				Loop
			End

			If mv_par07 == 2 .And. E1_TIPO $ MVRECANT+","+MV_CRNEG // So'Normais
				dbSkip( )
				Loop
			End

			If mv_par07 == 3 .And. ! (E1_TIPO $ MVRECANT+","+MV_CRNEG)  //So'Adiantamentos
				dbSkip( )
				Loop
			End

			If Alltrim(SE1->E1_CLIENTE) == cUniao
				SE1->(dbSkip())
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Le registros com data anterior a data inicial (para compor   ³
			//³ os saldos anteriores) ate a data final.                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SE1->E1_EMISSAO > mv_par02
				SE1->(dbSkip( ) )
				Loop
			End

			IF ! Inside(SE1->E1_TIPO)
				dbSkip()
				Loop
			End

			if MV_PAR17==2 .AND. MV_PAR16<>SE1->E1_MOEDA
				DbSkip()
				Loop
			Endif
			//Ignora titulos a vista gerados pelo Loja
			If cPaisLoc <> "BRA" .And. IsMoney(E1_TIPO) 
				dbSkip()
				Loop
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava debito no arquivo de trabalho                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SX5->( dbSetOrder(1) )
			SX5->( dbSeek(xFilial("SX5")+"05"+SE1->E1_TIPO) )
			cHistor    := X5DESCRI()
			If Empty(cHistor)
				cHistor := If(Empty(SE1->E1_HIST),OemToAnsi(STR0012),SE1->E1_HIST)  //"Pela Emissao do Titulo"
			Endif
			dbSelectArea("cNomeArq")
			Reclock("cNomeArq",.t.)
			Replace CODIGO  With SE1->E1_CLIENTE
			Replace LOJA    With SE1->E1_LOJA
			Replace DATAEMI With SE1->E1_EMISSAO
			Replace NUMERO  With SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA
			Replace TIPO    With SE1->E1_TIPO
			Replace BANCO   With SE1->E1_PORTADO
			Replace EMISSAO With SE1->E1_EMISSAO
			Replace VENCTO  With SE1->E1_VENCREA
			Replace VALOR   With IIf(mv_par15==1,xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,MV_PAR16,,nDecs+1),xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,MV_PAR16,,nDecs+1))
			Replace HISTOR  With cHistor
			If SE1->E1_TIPO $ MV_CRNEG+","+MVRECANT+","+MVCHEQUES .Or. SubStr( SE1->E1_TIPO,3,1 ) == "-"
				Replace DC   With "C"
			Else
				Replace DC   With "D"
			End
			MsUnlock()

			nRegSe1Atu := SE1->(RecNo())
			nOrdSe1Atu := SE1->(IndexOrd())
			lBaixa     := .F.
			If SE1->E1_FATURA == "NOTFAT"
				dbSelectArea("SE1")
				dbSetOrder(10)
				cChaveSe1 := xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA+SE1->E1_PREFIXO+SE1->E1_NUM
				If (dbSeek(cChaveSe1))
					If E1_DTFATUR <= dDataBase .and. SE1->E1_BAIXA <= mv_par02
						lBaixa := .T.
					Endif
				Endif
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se houve a substituicao do NF -> DP                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lBaixa
				dbSelectArea("cNomeArq")
				If !(dbSeek(SE1->E1_CLIENTE+SE1->E1_LOJA+DTOS(SE1->E1_DTFATUR)+SE1->E1_PREFIXO+SE1->E1_NUM))
					dbSelectArea("SE1")
					While !Eof() .and. (E1_FILIAL+SE1->E1_CLIENTE+SE1->E1_LOJA+SE1->E1_FATPREF+SE1->E1_FATURA == cChaveSe1)

						//If ! dbSeek(SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)

						if MV_PAR17==2 .AND. MV_PAR16<>SE1->E1_MOEDA
							dbSelectArea("SE1")   // Paulo
							dbSkip()
						else
							Reclock("cNomeArq",.T.)
							Replace CODIGO		With SE1->E1_CLIENTE
							Replace LOJA		With SE1->E1_LOJA
							Replace DATAEMI With SE1->E1_DTFATUR
							Replace NUMERO		With SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA
							Replace HISTOR		With STR0013 + SE1->E1_FATURA
							Replace EMISSAO	With SE1->E1_EMISSAO
							Replace VALOR		With IIf(mv_par15==1,xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,MV_PAR16,,nDecs+1),xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,MV_PAR16,,nDecs+1))
							Replace VENCTO		With SE1->E1_VENCREA
							Replace TIPO    With SE1->E1_TIPO
							If Substr(SE1->E1_TIPO,3,1) != "-" .And. !(SE1->E1_TIPO $ MV_CRNEG+","+MVRECANT+","+MVCHEQUES)
								Replace DC     With "C"
							Else
								Replace DC     With "D"    //Abatimentos/RA/NCC
							Endif
							MsUnlock()
							dbSelectArea("SE1")
							dbSkip()
						EndIf
					Enddo
				Endif
			Endif
			dbSelectArea("SE1")
			dbSetOrder(nOrdSe1Atu)
			dbGoto(nRegSe1Atu)
			dbSkip()
		Enddo
	Endif

	IF mv_par03 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza e grava titulos a pagar dentro dos parametros       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE2")
		dbSetOrder (6)
		If mv_par10 = 1
			dbSeek(xFilial()+mv_par04,.T.)
			cCondE2:="E2_FILIAL=='"+xFilial() +"'.and. E2_FORNECE >='"+ mv_par04+"' .And. E2_FORNECE <= '"+mv_par05+"'"
		Else
			cArqTrab :=CriaTrab(NIL,.F.)
			AADD(aInd,cArqTrab)
			cIndE2   :=IndexKey()
			cIndE2   :=Right(cIndE2,Len(cIndE2)-10)
			IndRegua("SE2",cArqTrab,cIndE2,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
			cCondE2:="E2_FORNECE >='"+ mv_par04+"' .And. E2_FORNECE <='"+ mv_par05+"'"
			dbCommit()
			nIndex:=RetIndex("SE2")
			dbSelectArea("SE2")
			#IFNDEF TOP
			dbSetIndex(cArqTrab+OrdBagExt())
			#ENDIF
			dbSetOrder(nIndex+1)
			dbSeek(mv_par04,.T.)
		EndIf

		While !SE2->(Eof()) .and. &(cCondE2)

			If mv_par15 <> 1.And. SE2->E2_SALDO > 0
				SE2->(dbSkip())
				Loop
			Endif

			If SE2->E2_PREFIXO < mv_par08 .Or. SE2->E2_PREFIXO > mv_par09  .Or. SE2->E2_EMIS1 > dDataBase
				SE2->(dbSkip())
				Loop
			EndIf

			If ( SE2->E2_NATUREZ < mv_par12 .Or. SE2->E2_NATUREZ > mv_par13 )
				SE2->(dbSkip())
				Loop
			EndIf

			IF SubStr(SE2->E2_TIPO,1,2) == "PR"
				SE2->(dbSkip())
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica quais serao impressos                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par07 == 2 .and. (SE2->E2_TIPO $ "PA /"+MV_CPNEG)  // So'Normais
				dbSkip()
				Loop
			Endif

			If mv_par07 == 3 .And. !(SE2->E2_TIPO $ MVPAGANT+","+MV_CPNEG) //So'Adiantamentos
				dbSkip()
				Loop
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Le registros com data anterior a data inicial (para compor   ³
			//³ os saldos anteriores) ate a data final.                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SE2->E2_EMIS1 > mv_par02
				SE2->(dbSkip())
				Loop
			End

			if MV_PAR17==2 .AND. MV_PAR16<>SE2->E2_MOEDA
				DbSkip()
				Loop
			Endif

			if ! Inside(SE2->E2_TIPO)
				dbSkip()
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava debito no arquivo de trabalho                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//If ! dbSeek(SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA)
			Reclock("cNomeArq",.t.)
			Replace CODIGO		With SE2->E2_FORNECE
			Replace LOJA		With SE2->E2_LOJA
			Replace DATAEMI 	With SE2->E2_EMIS1
			Replace NUMERO		With SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA
			Replace TIPO		With SE2->E2_TIPO
			Replace BANCO		With SE2->E2_PORTADO
			Replace EMISSAO		With SE2->E2_EMISSAO
			Replace VENCTO		With SE2->E2_VENCREA
			Replace VALOR		With IIf(mv_par15==1,xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,MV_PAR16,,nDecs+1),xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,MV_PAR16,,nDecs+1))

			If cPaisLoc <> "BRA"
				cHistor := ""
				If SE2->E2_TIPO == "NCP"
					cHistor := OemToAnsi(STR0030)	// "NOTA DE CREDITO No. "
				ElseIf SE2->E2_TIPO == "NDP"
					cHistor := OemToAnsi(STR0031)	// "NOTA DE DEBITO No. "
				ElseIf SE2->E2_TIPO $ "NF |FT "
					cHistor := OemToAnsi(STR0032)	// "FACTURA No. "
				ElseIf SE2->E2_TIPO == "NCE"
					cHistor := OemToAnsi(STR0036)	// "NOTA DE CRED. EXTERNA"
				ElseIf SE2->E2_TIPO == "NDE"
					cHistor := OemToAnsi(STR0037)	// "NOTA DE DEB. EXTERNA"
				ElseIf SE2->E2_TIPO == "PA "
					cHistor := OemToAnsi(STR0033)	// "ANTICIPO"
				ElseIf SE2->E2_TIPO == "CH "
					cHistor := OemToAnsi(STR0044)	// "CHEQUE"
				EndIf
				Replace HISTOR  With IIF(Empty(SE2->E2_HIST),cHistor,SE2->E2_HIST)
			ElseIf SE2->E2_FATURA="NOTFAT" .and. cPaisLoc == 'BRA'
				Replace HISTOR  With IIF(Empty(SE2->E2_HIST),OemToAnsi(STR0029),SE2->E2_HIST)  //"Pela Emissao da Fatura"
			Else
				Replace HISTOR  With IIF(Empty(SE2->E2_HIST),OemToAnsi(STR0012),SE2->E2_HIST)  //"Pela Emissao do Titulo"
			Endif
			IF SE2->E2_TIPO $ MV_CPNEG+","+MVPAGANT .Or. (SE2->E2_TIPO $ MVCHEQUES .And. AllTrim(SE2->E2_ORIGEM) != "FINA085A") .Or. SubStr(SE2->E2_TIPO,3,1) == "-"
				Replace DC     With "D"
			Else
				Replace DC     With "C"     //Abatimentos
			Endif
			MsUnlock()
			//EndIf

			nRegSe2Atu := SE2->(RecNo())
			nOrdSe2Atu := SE2->(IndexOrd())
			lBaixa     := .F.

			If SE2->E2_FATURA == "NOTFAT"
				dbSelectArea("SE2")
				dbSetOrder(9)
				cChaveSe2 := xFilial()+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_PREFIXO+SE2->E2_NUM
				If (dbSeek(cChaveSe2))
					If E2_DTFATUR <= dDataBase .and. SE2->E2_BAIXA <= mv_par02
						lBaixa := .T.
					Endif
				Endif
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se houve a substituicao do NF -> DP                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lBaixa
				dbSelectArea("cNomeArq")
				If !(dbSeek(SE2->E2_FORNECE+SE2->E2_LOJA+DTOS(SE2->E2_DTFATUR)+SE2->E2_PREFIXO+SE2->E2_NUM))
					dbSelectArea("SE2")
					While !Eof() .and. cChaveSe2 == xFilial()+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_FATPREF+SE2->E2_FATURA

						//If ! dbSeek(SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)

						if MV_PAR17==2 .AND. MV_PAR16<>SE2->E2_MOEDA
							dbSelectArea("SE2")
							dbSkip()
						else
							Reclock("cNomeArq",.T.)
							Replace CODIGO		With SE2->E2_FORNECE
							Replace LOJA		With SE2->E2_LOJA
							Replace DATAEMI With SE2->E2_DTFATUR
							Replace NUMERO		With SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA
							Replace EMISSAO	With SE2->E2_EMIS1
							Replace HISTOR		With STR0013 + SE2->E2_FATURA
							Replace VALOR		With IIf(mv_par15==1,xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,MV_PAR16,,nDecs+1),xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,mv_par16,,ndecs+1))
							Replace VENCTO		With SE2->E2_VENCREA

							IF Substr(SE2->E2_TIPO,3,1) != "-" .and. ! ( SE2->E2_TIPO $ "PA /"+MV_CPNEG)
								Replace DC     With "D"
							Else
								Replace DC     With "C"    //Abatimentos/PA/NDF
							Endif
							MsUnlock()
							dbSelectArea("SE2")
							dbSkip()
						EndIf

					Enddo
				Endif
			Endif
			dbSelectArea("SE2")
			dbSetOrder(nOrdSe2Atu)
			dbGoto(nRegSe2Atu)
			dbSkip()
		Enddo
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza na movimentacao bancaria, os titulos do periodo     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE5")
	dbSetOrder(7)
	If mv_par10 = 1
		dbSeek(xFilial(),.T.) // Com SoftSeek ON
		cCondE5:="'"+xFilial('SE5')+"' == SE5->E5_FILIAL"
	Else
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE5   :=IndexKey()
		cIndE5   :=Right(cIndE5,Len(cIndE5)-10)
		IndRegua("SE5",cArqTrab,cIndE5,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
		cCondE5:=".T."
		dbCommit()
		nIndex:=RetIndex("SE5")
		dbSelectArea("SE5")
		#IFNDEF TOP
		dbSetIndex(cArqTrab+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGoTop()

		// SE1
		dbSelectArea("SE1")
		dbSetOrder(1)
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE1   :=IndexKey()
		cIndE1   :=Right(cIndE1,Len(cIndE1)-10)
		IndRegua("SE1",cArqTrab,cIndE1,,,OemToAnsi(STR0011)) //"Selecionando Registros..."
		dbCommit()
		nIndex:=RetIndex("SE1")
		dbSelectArea("SE1")
		#IFNDEF TOP
		dbSetIndex(cArqTrab+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGoTop()

		//SE2
		dbSelectArea("SE2")
		dbSetOrder(1)
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE2   :=IndexKey()
		cIndE2   :=Right(cIndE2,Len(cIndE2)-10)
		IndRegua("SE2",cArqTrab,cIndE2,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
		dbCommit()
		nIndex:=RetIndex("SE2")
		dbSelectArea("SE2")
		#IFNDEF TOP
		dbSetIndex(cArqTrab+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGotop()
	EndIf
	If mv_par15==1
		dbSelectArea("SE5")
		While !SE5->(Eof()) .and. &(cCondE5)

			If Empty(SE5->E5_NUMERO) .Or. SE5->E5_SITUACA = "C" .Or. !SE5->E5_TIPODOC $ "VLüBAüCPüV2üLJüES"
				SE5->(dbSkip())
				Loop
			EndIf
			//Ignorar baixas do Loja de titulos a vista
			If cPaisLoc <> "BRA" .And. SE5->E5_RECPAG=='R' .And. IsMoney(SE5->E5_TIPO) .And. SE5->E5_TIPODOC == "LJ"
				SE5->(dbSkip())
				Loop
			EndIf

			If SE5->E5_PREFIXO < mv_par08 .Or. SE5->E5_PREFIXO > mv_par09
				SE5->(dbSkip())
				Loop
			EndIf

			If  ( SE5->E5_NATUREZ < mv_par12 .Or. SE5->E5_NATUREZ > mv_par13 )
				SE5->(dbSkip())
				Loop
			EndIf

			If cPaisLoc	# "BRA"
				SA6->(DbSetOrder(1))
				SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
				nMoedaBco := Max(SA6->A6_MOEDA,1)
			else
				nMoedaBco:=1
			Endif

			if MV_PAR17==2 .AND. MV_PAR16<>nMoedaBco
				SE5->(dbskip())
				Loop
			endif

			If SE5->E5_RECPAG == "R"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica quais serao impressos                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par07 == 2 .and. (E5_TIPO $ MVRECANT+","+MV_CRNEG)    // So'Normais
					dbSkip()
					Loop
				Endif

				If mv_par07 == 3 .and. !(E5_TIPO $ MVRECANT+","+MV_CRNEG)  //So'Adiantamentos
					dbSkip()
					Loop
				Endif
			ElseIf SE5->E5_RECPAG == "P"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica quais serao impressos                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par07 == 2 .and. ( E5_TIPO $ MVPAGANT+","+MV_CPNEG ) // So'Normais
					dbSkip( )
					Loop
				Endif

				If mv_par07 == 3 .and. E5_TIPO != MVPAGANT+","+MV_CPNEG  //So'Adiantamentos
					dbSkip()
					Loop
				Endif

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Ignora PA's pagos com Junta de Cheque                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If E5_TIPO=="PA " .and. E5_TIPODOC == "BA" .and. !empty(E5_NUMCHEQ)
					DbSkip()
					Loop
				Endif
			Endif

			IF SE5->E5_DTDIGIT > mv_par02
				SE5->(dbSkip( ) )
				Loop
			Endif

			IF SE5->E5_CLIFOR < mv_par04 .Or. SE5->E5_CLIFOR > mv_par05
				SE5->(dbSkip())
				Loop
			EndIF

			if mv_par03 == 1 .and. SE5->E5_RECPAG == "R" .and. SE5->E5_TIPODOC =="ES"
				dbskip()
				loop
			Elseif mv_par03 == 2 .and. SE5->E5_RECPAG == "P" .and. SE5->E5_TIPODOC =="ES"
				dbskip()
				loop
			endif

			IF mv_par03 == 1 .and. SE5->E5_RECPAG != "R"
				If ! (SE5->E5_TIPO $ MVRECANT+","+MV_CRNEG) .And. SE5->E5_TIPODOC != "ES"     //Baixa de RA
					SE5->(dbSkip())
					Loop
				End
			EndIF

			IF mv_par03 == 2 .and. SE5->E5_RECPAG != "P"
				If ! (SE5->E5_TIPO $ MVPAGANT+","+MV_CPNEG) .And. SE5->E5_TIPODOC != "ES"       //Baixa de PA
					SE5->(dbSkip())
					Loop
				End
			End

			If mv_par03 == 1        // Se for baixa de adiantamentos
				If SE5->E5_RECPAG == "R" .and. E5_TIPO $ MVPAGANT+","+MV_CPNEG .And. SE5->E5_TIPODOC $ "VL/BA"
					dbSkip()
					LOOP
				End
			End

			If mv_par03 == 2        // Se for baixa de adiantamentos
				If SE5->E5_RECPAG == "P" .and. E5_TIPO $ MVRECANT+","+MV_CRNEG .And. SE5->E5_TIPODOC $ "VL/BA"
					dbSkip()
					LOOP
				End
			End

			If ! Inside(SE5->E5_TIPO)
				dbSkip()
				Loop
			Endif

			nRec := SE5 -> ( Recno () )
			nPrim:= 0
			cPrefixo := SE5->E5_PREFIXO
			cNumero  := SE5->E5_NUMERO
			cParcela := SE5->E5_PARCELA
			cTipo    := SE5->E5_TIPO
			cNaturez := SE5->E5_NATUREZ
			nValliq  := 0
			cFornece := SE5->E5_CLIFOR
			cLoja    := SE5->E5_LOJA
			dDtDigit := SE5->E5_DTDIGIT
			cRecPag  := SE5->E5_RECPAG
			cSeq     := SE5->E5_SEQ

			IF nAnterior = 0
				cAnterior := cPrefixo+cNumero+cParcela+cTipo+cFornece+Dtos(dDtDigit)+SE5->E5_RECPAG
				nAnterior := 1
				If mv_par10 = 1
					dbSeek(xFilial()+cPrefixo+cNumero+cParcela+cTipo+cFornece+cLoja+cSeq)
				Else
					dbSeek(cPrefixo+cNumero+cParcela+cTipo+cFornece+cLoja+cSeq)
				EndIf
			EndIF

			While ! SE5->(Eof()) .and. SE5->E5_PREFIXO==cPrefixo .and. ;
			SE5->E5_NUMERO==cNumero   .and. ;
			SE5->E5_PARCELA==cParcela .and. ;
			SE5->E5_TIPO==cTipo       .and. ;
			SE5->E5_CLIFOR==cFornece  .and. ;
			SE5->E5_LOJA==cLoja       .and. ;
			SE5->E5_SEQ==cSeq

				If mv_par03 == 2 .and. SE5->E5_CLIFOR+E5_LOJA != cFornece+cLoja
					Exit
				Endif

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Devera' ser considerado o valor sem liquido da baixa         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF Empty(SE5->E5_NUMERO) .Or. SE5->E5_SITUACA = "C"
					SE5->(dbSkip())
					Loop
				EndIF

				IF SE5->E5_DTDIGIT > mv_par02
					SE5->(dbSkip( ) )
					Loop
				End

				IF SE5->E5_CLIFOR < mv_par04 .Or. SE5->E5_CLIFOR > mv_par05
					SE5->(dbSkip())
					Loop
				EndIF

				/*			If cPaisLoc<>"BRA" .and. E5_TIPO=="EF " .and. !Empty(E5_ORDREC)
				dbskip()
				Loop
				Endif
				*/			IF mv_par03 == 1 .and. SE5->E5_RECPAG != "R"
				If ! ( SE5->E5_TIPO $ MVRECANT+","+MV_CRNEG ) .AND. SE5->E5_TIPODOC !="ES"       //Baixa de RA
					SE5->(dbSkip())
					Loop
				Endif
			EndIF

			IF mv_par03 == 2 .and. SE5->E5_RECPAG != "P"
				If ! ( SE5->E5_TIPO $ MVPAGANT+","+MV_CPNEG ) .AND. SE5->E5_TIPODOC !="ES"       //Baixa de PA
					SE5->(dbSkip())
					Loop
				Endif
			Endif


			if MV_PAR17==2 .AND. MV_PAR16 <> nMoedaBco
				SE5->(dbSkip())
				Loop
			endif

			If nPrim == 0
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Localiza o cliente ou fornecedor                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cCarteira := SE5->E5_RECPAG
				If SE5->E5_RECPAG == "R"
					If (SE5->E5_TIPO $ MVPAGANT+","+MV_CPNEG).and.SE5->E5_TIPODOC $ "BAüVL" .and. !Empty(SE5->E5_BANCO);
					.OR. SE5->E5_TIPODOC =="ES"
						cCarteira := "P"        //Baixa de adiantamento (inverte)
					End
				End

				If SE5->E5_RECPAG == "P"
					If SE5->E5_TIPO $ MVRECANT+","+MV_CRNEG .And. SE5->E5_TIPODOC $ "BAüVL" .And.!Empty(SE5->E5_BANCO);
					.OR. SE5->E5_TIPODOC =="ES"
						cCarteira := "R"        //Baixa de adiantamento (inverte)
					End
				End

				IF cCarteira == "R"
					dbSelectArea("SE1")
					If mv_par10 = 1
						dbSetOrder(1)
						dbSeek(xFilial()+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO)
					Else
						dbSeek(SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO)
					EndIf
				Else
					dbSelectArea("SE2")
					If mv_par10 = 1
						dbSetOrder(1)
						dbSeek(xFilial()+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA)
					Else
						dbSeek(SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA)
					EndIf
				End

				dbSelectArea("SE5")
				IF cCarteira == "R"
					dEmissao := SE1->E1_EMISSAO
					dVencto  := SE1->E1_VENCREA
				Else
					dEmissao := SE2->E2_EMISSAO
					dVencto  := SE2->E2_VENCREA
				End
				nPrim++
			End


			If SE5->E5_TIPODOC $ "VLüBAüCPüV2üLJüES"
				nValliq+=xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1)
				IIF(mv_par06==1,GravaTrab("B",dEmissao,dVencto),NIL)
			ElseIf SE5->E5_TIPODOC $ "DC/D2"
				nValliq+=xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1)
				IIF(mv_par06==1,GravaTrab("D",dEmissao,dVencto),NIL)
			Elseif SE5->E5_TIPODOC $ "MT/JR/J2/M2"
				IIF(mv_par06==1,GravaTrab("M",dEmissao,dVencto),NIL)
				nValliq-=xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1)
			Elseif SE5->E5_TIPODOC $ "CM/C2/CX"
				IIF(mv_par06==1,GravaTrab("C",dEmissao,dVencto),NIL)
				nValLiq-=xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1)
			End
			SE5->(dbSkip())
		End
		nRec1 := SE5 -> ( Recno () )
		dbGoto(nRec)
		if mv_par06==2 .and. nValLiq != 0
			GravaTrab("B",dEmissao,dVencto,nValLiq)
		End
		dbGoto(nRec1)
		nAnterior := 0
	End
	Endif
	nTotDebG := 0
	nTotCrdG := 0
	nSalAtuG := 0

	SetRegua(RecCount())
	DbSelectArea("cNomeArq")
	DbGoTop()
	While !Eof()

		#IFNDEF WINDOWS
		Inkey()
		If LastKey() = K_ALT_A
			lEnd := .t.
		End
		#ENDIF

		IF lEnd
			@Prow()+1,0 PSAY OemToAnsi(STR0014) //"***** Cancelado pelo Operador *****"
			Exit
		End

		cCodigo  := CODIGO
		cLoja    := LOJA
		nSaldoAtu:= 0
		nTotDeb     := 0
		nTotCrd  := 0

		IF li>50
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			li:=8
		End

		nRegAtu := RecNo()
		lImprime := .F.
		While cNomeArq->CODIGO == cCodigo .And. cNomeArq->LOJA == cLoja .And. ! Eof()

			If (If(mv_par18==1,DATAEMI,EMISSAO) >= mv_par01 )   // Procura titulos no intervalo e
				lImprime := .T.     // se houver, dever  imprimir
				Exit
			Endif
			dbSkip()
		Enddo
		dbGoto(nRegAtu)

		While cNomeArq->CODIGO == cCodigo .And. cNomeArq->LOJA == cLoja .And. ! Eof()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Loop para calculo do saldo anterior                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While cNomeArq->CODIGO == cCodigo .And. cNomeArq->LOJA == cLoja .And. ;
			If(mv_par18==1,cNomeArq->DATAEMI,cNomeArq->EMISSAO) < mv_par01 .And. ! Eof()
				If DC == "C"
					nSaldoAtu += cNomeArq->VALOR
				Else
					nSaldoAtu -= cNomeArq->VALOR
				EndIf

				IncRegua()

				dbSkip()
				If cNomearq->CODIGO != ccodigo .Or. cNomeArq->LOJA != cLoja
					lNoSkip := .T.
				Endif
			Enddo

			If lImprime .Or. nSaldoAtu != 0
				If li > 50
					IF m_pag>1
						li++
						@ li,092 PSAY OemToAnsi(STR0015)  //"A TRANSPORTAR : "
						@ li,116 PSAY Abs(nSaldoAtu)    Picture tm(Abs(nSaldoAtu),14)
						@ li,131 PSAY IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))
					Endif

					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
					li:=8

					If nQuebra == 1
						If mv_par03==1
							dbSelectArea("SA1")
							If mv_par10 = 1
								dbSeek(xFilial()+cCodigo+cLoja)
							Else
								If cIndA1 == " "
									cArqTrab :=CriaTrab(NIL,.F.)
									AADD(aInd,cArqTrab)
									cIndA1   :=IndexKey()
									cIndA1   :=Right(cIndA1,Len(cIndA1)-10)
									IndRegua("SA1",cArqTrab,cIndA1,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
									dbCommit()
									nIndex:=RetIndex("SA1")
									dbSelectArea("SA1")
									#IFNDEF TOP
									dbSetIndex(cArqTrab+OrdBagExt())
									#ENDIF
									dbSetOrder(nIndex+1)
								EndIf
								dbSeek(cCodigo+cLoja)
							EndIf
							cNome := SA1->A1_NOME+" "+SA1->A1_CGC+" "+SA1->A1_CONTA
						Else
							dbSelectArea("SA2")
							If mv_par10 = 1
								dbSeek(xFilial()+cCodigo+cLoja)
							Else
								If cIndA2 == " "
									cArqTrab :=CriaTrab(NIL,.F.)
									AADD(aInd,cArqTrab)
									cIndA2   :=IndexKey()
									cIndA2   :=Right(cIndA2,Len(cIndA2)-10)
									IndRegua("SA2",cArqTrab,cIndA2,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
									dbCommit()
									nIndex:=RetIndex("SA2")
									dbSelectArea("SA2")
									#IFNDEF TOP
									dbSetIndex(cArqTrab+ordBagExt())
									#ENDIF
									dbSetOrder(nIndex+1)
								EndIf
								dbSeek(cCodigo+cLoja)
							EndIf
							cNome := SA2->A2_NOME+" "+SA2->A2_CGC+" "+SA2->A2_CONTA
						EndIF

						If cPaisLoc == 'BRA'
							@li,000 PSAY cCodigo + "-" + cLoja + " " + cNome
							li++
							@li,092 PSAY OemToAnsi(STR0028)  //"DE TRANSPORTE : "
							@li,116 PSAY Abs(nSaldoAtu) Picture tm(Abs(nSaldoAtu),14)
							@li,131 PSAY IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))
							li++
						Else
							If mv_par03 == 1
								SA1->( dbSetOrder(1) )
								SA1->( dbSeek(xFilial("SA1")+cCodigo+cLoja) )
							Else
								SA2->( dbSetOrder(1) )
								SA2->( dbSeek(xFilial("SA2")+cCodigo+cLoja) )
							Endif

							@li,000 PSAY If(mv_par03==1,Subs(SA1->A1_NOME,1,40),Subs(SA2->A2_NOME,1,40) )
							@li,050 PSAY cCodigo + "-" + cLoja
							@li,092 PSAY OemToAnsi(STR0028)  //"TRANSPORTAR : "
							@li,116 PSAY Abs(nSaldoAtu) Picture tm(Abs(nSaldoAtu),14)
							@li,131 PSAY IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))
							li+=1

							SX5->( dbSetOrder(1) )

							If mv_par03 == 1
								SX5->( dbSeek(xFilial("SX5")+"12"+SA1->A1_EST) )
								cProvincia := X5DESCRI()
								cTipoCli := TABELA("SF",SA1->A1_TIPO,.F.)

								@li,000 PSAY SA1->A1_END
								@li,050 PSAY RetTitle("A1_TEL") +SA1->A1_TEL
								@li,092 PSAY OemToAnsi(STR0038) +SA1->A1_VEND	// "VENDEDOR: "
								li+=1
								@li,000 PSAY SA1->A1_CEP+" - " +SA1->A1_MUN
								li+=1
								@li,000 PSAY cTipoCli
								@li,050 PSAY SA1->A1_CGC PICTURE PESQPICT("SA1","A1_CGC")
								li+=1
								@li,000 PSAY cProvincia   Picture "@!"
								li+=2
							Else
								SX5->( dbSeek(xFilial("SX5")+"12"+SA2->A2_EST) )
								cProvincia := X5DESCRI()
								cTipoCli := TABELA("SF",SA2->A2_TIPO,.F.)

								@li,000 PSAY SA2->A2_END
								@li,050 PSAY "Te: "+SA2->A2_TEL
								@li,092 PSAY OemToAnsi(STR0039)	// "COMPRADOR: "
								li+=1
								@li,000 PSAY SA2->A2_CEP+" - " +SA2->A2_MUN
								li+=1
								@li,000 PSAY cTipoCli
								@li,050 PSAY SA2->A2_CGC PICTURE PESQPICT("SA2","A2_CGC")
								li+=1
								@li,000 PSAY cProvincia   Picture "@!"
								li+=2
							EndIf
						EndIf

					EndIf
				Endif
			EndIf

			If nQuebra == 0 .and. (lImprime .Or. nSaldoAtu != 0 )
				nQuebra  := 1
				lImprAnt := .F.
				IF mv_par03 == 1
					dbSelectArea("SA1")
					If mv_par10 = 1
						dbSeek(xFilial()+cCodigo+cLoja)
					Else
						If cIndA1 == " "
							cArqTrab :=CriaTrab(NIL,.F.)
							AADD(aInd,cArqTrab)
							cIndA1   :=IndexKey()
							cIndA1   :=Right(cIndA1,Len(cIndA1)-10)
							IndRegua("SA1",cArqTrab,cIndA1,,,STR0011 )  //"Selecionando Registros..."
							dbCommit()
							nIndex:=RetIndex("SA1")
							dbSelectArea("SA1")
							#IFNDEF TOP
							dbSetIndex(cArqTrab+OrdBagEXt())
							#ENDIF
							dbSetOrder(nIndex+1)
						EndIf
						dbSeek(cCodigo+cLoja)
					EndIf
					cNome := SA1->A1_NOME+" "+SA1->A1_CGC+" "+SA1->A1_CONTA
				Else
					dbSelectArea("SA2")
					If mv_par10 = 1
						dbSeek(xFilial()+cCodigo+cLoja)
					Else
						If cIndA2 == " "
							cArqTrab :=CriaTrab(NIL,.F.)
							AADD(aInd,cArqTrab)
							cIndA2   :=IndexKey()
							cIndA2   :=Right(cIndA2,Len(cIndA2)-10)
							IndRegua("SA2",cArqTrab,cIndA2,,,OemToAnsi(STR0011))  //"Selecionando Registros..."
							dbCommit()
							nIndex:=RetIndex("SA2")
							dbSelectArea("SA2")
							#IFNDEF TOP
							dbSetIndex(cArqTrab+OrdBagExt())
							#ENDIF
							dbSetOrder(nIndex+1)
						EndIf
						dbSeek(cCodigo+cLoja)
					EndIf
					cNome := SA2->A2_NOME+" "+SA2->A2_CGC+" "+SA2->A2_CONTA
				EndIF

				If cPaisLoc == "BRA"
					@li,000 PSAY cCodigo + "-" + cLoja + " " + cNome
					dbSelectArea("cNomeArq")
					li++
					@li, 92 PSAY OemToAnsi(STR0016)  //"SALDO ANTERIOR : "
					@li,116 PSAY Abs(nSaldoAtu)     Picture tm(Abs(nSaldoAtu),14)
					@li,131 PSAY IIF(nSaldoAtu<0," D",IIF(nSaldoAtu>0," C"," "))
					nSalAntG += nSaldoAtu
					li++
				Else

					If mv_par03 == 1
						SA1->( dbSetOrder(1) )
						SA1->( dbSeek(xFilial("SA1")+cCodigo+cLoja) )
					Else
						SA2->( dbSetOrder(1) )
						SA2->( dbSeek(xFilial("SA2")+cCodigo+cLoja) )
					Endif

					@li,000 PSAY If(mv_par03==1,Subs(SA1->A1_NOME,1,40),Subs(SA2->A2_NOME,1,40) )
					@li,050 PSAY cCodigo + "-" + cLoja
					@li,092 PSAY OemToAnsi(STR0016)  //"SALDO ANTERIOR : "
					@li,116 PSAY Abs(nSaldoAtu) Picture tm(Abs(nSaldoAtu),14)
					@li,131 PSAY IIF(nSaldoAtu>0,"D",IIF(nSaldoAtu<0,"C"," "))
					nSalAntG += nSaldoAtu
					li+=2


					If mv_par03 == 1
						SX5->( dbSetOrder(1) )
						SX5->( dbSeek(xFilial("SX5")+"12"+SA1->A1_EST) )
						cProvincia := X5DESCRI()
						cTipoCli := TABELA("SF",SA1->A1_TIPO,.F.)

						@li,000 PSAY SA1->A1_END
						@li,050 PSAY RetTitle("A1_TEL")+SA1->A1_TEL
						@li,092 PSAY OemToAnsi(STR0038) +SA1->A1_VEND	// "VENDEDOR: "
						li+=1
						@li,000 PSAY SA1->A1_CEP+" - " +SA1->A1_MUN
						li+=1
						@li,000 PSAY cTipoCli
						@li,050 PSAY SA1->A1_CGC PICTURE Pesqpict("SA1","A1_CGC")
						li+=1
						@li,000 PSAY cProvincia   Picture "@!"
						li+=2
					Else
						SX5->( dbSetOrder(1) )
						SX5->( dbSeek(xFilial("SX5")+"12"+SA2->A2_EST) )
						cProvincia := X5DESCRI()
						cTipoCli := TABELA("SF",SA2->A2_TIPO,.F.)

						@li,000 PSAY SA2->A2_END
						@li,050 PSAY RetTitle("A2_TEL")+SA2->A2_TEL
						@li,092 PSAY OemToAnsi(STR0039)	// "COMPRADOR: "
						li+=1
						@li,000 PSAY SA2->A2_CEP+" - " +SA2->A2_MUN
						li+=1
						@li,000 PSAY cTipoCli
						@li,050 PSAY SA2->A2_CGC PICTURE Pesqpict("SA2","A2_CGC")
						li+=1
						@li,000 PSAY cProvincia   Picture "@!"
						li+=2
					EndIf

				EndIf

			End
			dbSelectArea("cNomeArq")

			If (If(mv_par18==1,cNomeArq->DATAEMI,cNomeArq->EMISSAO) >= mv_par01 ).And. !lNoSkip
				If DC == "D"
					nSaldoAtu -= cNomeArq->VALOR
					nTotDeb   += cNomeArq->VALOR
					nTotDebG  += cNomeArq->VALOR
					nSalAtuG  -= cNomeArq->VALOR
				Else
					nSaldoAtu += cNomeArq->VALOR
					nTotCrd   += cNomeArq->VALOR
					nTotCrdG  += cNomeArq->VALOR
					nSalAtuG  += cNomeArq->VALOR
				End
				If mv_par14 == 1  // Analitico
					li++
					aTam := TamSX3("E1_NUM")
					If !Empty(DATAEMI)
						@li,000 PSAY DATAEMI
					Endif
					If Subs(HISTOR,1,7)== OemToAnsi(STR0041)	// "Recibo:"
						@li,009 PSAY OemToAnsi(STR0040) + SubStr(HISTOR,8,8)	// "RECIBO No.: "
					ElseIf Subs(HISTOR,1,11)== OemToAnsi(STR0043)	// "Baja recibo"
						@li,009 PSAY OemToAnsi(STR0040) + SubStr(HISTOR,17,6)	// "RECIBO No.:"
					Else
						@li,009 PSAY SubStr(HISTOR,1,22)
					EndIf
					@li,033 PSAY SubStr(NUMERO, 1,3)
					@li,037 PSAY SubStr(NUMERO, 4,aTam[1])
					@li,051 PSAY SubStr(NUMERO,aTam[1]+4,1)
					@li,053 PSAY EMISSAO
					@li,064 PSAY VENCTO
					IF !Empty(BAIXA)
						@li,075 PSAY BAIXA
					End
					@li,IIF(DC=="D",86,101) PSAY cNomeArq->VALOR PicTure tm(cNomeArq->VALOR,14)
					@li,116 PSAY Abs(nSaldoAtu)      Picture tm(Abs(nSaldoAtu),14)
					@li,131 PSAY IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))
				Endif
			End
			lFlag := .T.
			If ! lNoSkip
				IncRegua()
				dbSkip( )
			End
			lNoSkip := .F.
		End
		If lImprime .Or. nSaldoAtu != 0
			li+= IIF(mv_par14 == 1 , 2 , 1 )
			@li,  0 PSAY OemToAnsi(STR0017)+IIF(mv_par03==1,OemToAnsi(STR0018),OemToAnsi(STR0019))  //"T o t a i s  d o  "###"C l i e n t e"###"F o r n e c e d o r"
			@li, 86 PSAY nTotDeb                Picture tm(nTotDeb,14)
			@li,101 PSAY nTotCrd                Picture tm(nTotCrd,14)
			@li,116 PSAY Abs(nSaldoAtu)     Picture tm(Abs(nSaldoAtu),14)
			@li,131 PSAY IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))
			li++
			@li,  0  PSAY Repl("-",132)
			li++
		Endif
		nQuebra:=0
	End

	If nQuebra # 0 .and.(lImprime .Or. nSaldoAtu != 0)
		li+=2
		@li,  0  PSAY OemToAnsi(STR0017)+IIF(mv_par03==1,OemToAnsi(STR0018),OemToAnsi(STR0019))  //"T o t a i s  d o  "###"C l i e n t e"###"F o r n e c e d o r"
		@li, 86  PSAY nTotDeb                    Picture tm(nTotDeb,14)
		@li,101  PSAY nTotCrd                    Picture tm(nTotCrd,14)
		@li,116  PSAY Abs(nSaldoAtu)     Picture tm(Abs(nSaldoAtu),14)
		@li,131  PSAY IIF(nSaldoAtu<0,"D",IIF(nSaldoAtu>0,"C"," "))
	End
	If lFlag
		li++
		IF li>50
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			li:=8
		End
		@li,  0  PSAY OemToAnsi(STR0020)+IIF(mv_par03==1,OemToAnsi(STR0021),OemToAnsi(STR0022))  //"T o t a l   G e r a l  d o s  "###"C l i e n t e s"###"F o r n e c e d o r e s"
		@li, 86  PSAY nTotDebG               Picture tm(nTotDebG,14)
		@li,101  PSAY nTotCrdG               Picture tm(nTotCrdG,14)
		@li,116  PSAY Abs(nSalAtuG)      Picture tm(Abs(nSalAtuG),14)
		@li,131  PSAY IIF(nSalAtuG<0,"D",IIF(nSalAtuG>0,"C"," "))
		li+=2
		@li, 0   PSAY Repl("-",132)
		li++
		@li,  0  PSAY OemToAnsi(STR0023)  //"S a l d o   F i n a l   d o   R e l a t o r i o : "
		nSaldoFinal := (nSalAntG-nTotDebG+nTotCrdG)
		@li, 116 PSAY Abs(nSaldoFinal)  Picture tm(Abs(nSaldoFinal),14)
		@li ,131 PSAY IIF(nSaldoFinal<0,"D",IIF(nSaldoFinal>0,"C"," "))
		li++
		@li, 0 PSAY Repl("-",132)
	End
	Roda( cbCont, cbTxt, Tamanho )
	dbSelectArea("cNomeArq")
	Use
	//Ferase(cNomeArq+GetDBExtension())         // Elimina arquivos de Trabalho
	//Ferase(cNomeArq+OrdBagExt())    // Elimina arquivos de Trabalho

	dbSelectArea("SA1")
	RetIndex("SA1")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SA2")
	RetIndex("SA2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE1")
	RetIndex("SE1")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE2")
	RetIndex("SE2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE5")
	RetIndex("SE5")
	dbSetOrder(1)
	DbClearFilter()

	For nI:=1 to Len(aInd)
		if File(aInd[nI]+OrdBagExt())
			Ferase(aInd[nI]+OrdBagExt())
		Endif
		If File(aInd[nI]+GetDBExtension())
			Ferase(aInd[nI]+GetDBExtension())
		Endif
	Next

	Set Device To Screen
	If aReturn[5] = 1
		Set Printer To
		Commit
		Ourspool(wnrel)
	Endif
	MS_FLUSH()
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GravaTrab ³ Autor ³ Wagner Xavier         ³ Data ³ 25.02.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Grava um registro no arquivo de trabalho para impressao     ³±±
±±³          ³do Razonete.                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³GravaTrab( ExpC1, ExpD1, ExpD2)                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GravaTrab( cTipo,dEmissao,dVencto,nValor )
	Local cHist,cDCR,cDCP,cAlias:=Alias()
	Local ndecs:=MsDecimais(MV_PAR16)
	Local aAreaSE2 := {}
	Local lCheque := .F.  
	Local cChaveSE5 := ""
	Local cFornece	:= ""
	Local cLoja 	:= "" 

	If cPaisLoc	# "BRA"
		SA6->(DbSetOrder(1))
		SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
		nMoedaBco := Max(SA6->A6_MOEDA,1)
	else
		nMoedaBco:=1
	Endif

	nValor := Iif( nValor=Nil,xmoeda(SE5->E5_VALOR,nMoedaBco,MV_PAR16,,nDecs+1),nValor )

	Do Case
		Case cTipo == "B"
		cHist := Iif(Empty(SE5->E5_HISTOR) .or. (cPaisloc<>"BRA" .and. SE5->E5_TIPODOC $ "VL".AND. Empty(SE5->E5_ORDREC)),OemToAnsi(STR0024),SE5->E5_HISTOR)  //"Ref. a Baixa do Titulo"
		cDCR="C"
		cDCP="D"
		Case cTipo == "D"
		cHist := OemToAnsi(STR0025)  //"Desconto sobre o titulo"
		cDCR="C"
		cDCP="D"
		Case cTipo == "M"
		cHist := OemToAnsi(STR0026)  //"Multa/Juros s/ o Titulo"
		cDCR="D"
		cDCP="C"
		OtherWise
		cHist := OemToAnsi(STR0027)  //"Corr.Monetaria s/ o Titulo"
		cDCR="D"
		cDCP="C"
	EndCase  

	//Gerou cheque no SE2
	If SE5->E5_TIPODOC $ "BA"

		cFornece := SE5->E5_CLIFOR
		cLoja := SE5->E5_LOJA 
		cChaveSE5 := xFilial("SE5")+Space(TamSx3("E5_PREFIXO")[1])+PadR(SE5->E5_ORDREC,TamSx3("E5_NUMERO")[1])+Space(TamSx3("E5_PARCELA")[1])

		dbSelectArea("SE2")
		aAreaSE2:= SE2->(GetArea())
		SE2->(dbSetOrder(1))

		If SE2->(dbSeek(cChaveSE5))
			While !SE2->(Eof()) .And. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA) == cChaveSE5 .And. SE2->(E2_FORNECE+E2_LOJA) == cFornece+cLoja 
				If SE2->(E2_TIPO) $ MVCHEQUES
					lCheque := .T.
					Exit	
				Endif	
				SE2->(dbSkip())
			EndDo
		Endif

		SE2->(RestArea(aAreaSE2))
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava registro no arquivo de trabalho                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc == "BRA"
		//   If ! dbSeek(SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA)
		Reclock("cNomeArq",.t.)
		Replace CODIGO  With SE5->E5_CLIFOR
		Replace LOJA    With SE5->E5_LOJA
		Replace NUMERO  With SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA
		Replace BANCO   With SE5->E5_BANCO
		Replace BAIXA   With SE5->E5_DATA
		Replace VALOR   With nValor
		Replace HISTOR  With cHist
		If mv_par18 == 1
			Replace DATAEMI With SE5->E5_DTDIGIT
			Replace EMISSAO With dEmissao
		Else
			Replace EMISSAO With dEmissao
		Endif
		Replace VENCTO  With dVencto
		Replace TIPO    With SE5->E5_TIPO
		If SE5->E5_RECPAG = "R"
			Replace DC With If( !( SE5->E5_TIPO $ MVRECANT+","+MV_CRNEG) .or.;
			SE5->E5_TIPODOC=="ES",cDCR,cDCP)
		Else
			Replace DC With If( !( SE5->E5_TIPO $ MVPAGANT+","+MV_CPNEG).or. ;
			SE5->E5_TIPODOC=="ES",cDCP,cDCR)
		EndIf
		MsUnlock()

	ElseIf SE5->E5_TIPO $ "TF ,EF " .Or. (SE5->E5_TIPO $ "NF " .And. SE5->E5_TIPODOC $ "DC") .Or. ( ( IIF( (cPaisLoc<>'BOL'),SE5->E5_TIPODOC $ "VL",SE5->E5_SITUACA<>'C')) .And. Empty(SE5->E5_ORDREC)) .Or. lCheque 

		If MV_PAR17==1 .or. MV_PAR16==SE2->E2_MOEDA

			Reclock("cNomeArq",.t.)
			Replace CODIGO  With SE5->E5_CLIFOR
			Replace LOJA    With SE5->E5_LOJA
			Replace NUMERO  With SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA
			Replace BANCO   With SE5->E5_BANCO
			Replace VALOR   With nValor
			Replace VENCTO  With dVencto
			Replace TIPO    With SE5->E5_TIPO
			If mv_par18 == 1
				Replace DATAEMI With SE5->E5_DTDIGIT
				Replace EMISSAO With dEmissao
			Else
				Replace EMISSAO With dEmissao
			Endif

			If SE5->E5_RECPAG = "R"
				Replace DC 		With If( !(SE5->E5_TIPO $ MVRECANT+","+MV_CRNEG),cDCR,cDCP)
				Replace BAIXA   With SE1->E1_EMISSAO
				If ! Empty(SE5->E5_ORDREC) .AND. SE5->E5_TIPODOC == "BA"
					Replace HISTOR  With  OemToAnsi(STR0041) + SE5->E5_ORDREC	// "RECIBO: "      // Diego 12/08/99
				Else
					Replace HISTOR  With cHist 
				EndIf
			ELSE
				Replace DC With If( !(SE5->E5_TIPO $ MVPAGANT+","+MV_CPNEG),cDCP,cDCR)
				Replace BAIXA   With SE5->E5_DATA
				If ! Empty(SE5->E5_ORDREC) .AND. SE5->E5_TIPODOC == "BA"
					Replace HISTOR  With  OemToAnsi(STR0042) + SE5->E5_ORDREC	// "ORDEN DE PAGO: "      // Diego 12/08/99
				Else
					Replace HISTOR  With cHist 
				EndIf
			EndIf

			lCheque := .F.
			MsUnlock()

		Endif
	EndIf

	dbSelectArea(cAlias)
Return Nil

Static Function InSide(cTp)
Return If(mv_par11 == 1, cTp $ cTipos, .t.)




