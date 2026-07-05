/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR850.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE VALORPAGO 	3

Static __nTamPref := 0
Static __nTamNum  := 0
Static __nTamParc := 0
Static __nTamTipo := 0
Static __nTamForn := 0
Static __nTamOcor := 0

//---------------------------------------------
/*/{Protheus.doc} FinR850
Relatorio do Arquivo de Retorno SISPAG

@author Julio Wittwer / Jose Novaes 
@since 06/12/1999
@version P12
/*/
//---------------------------------------------
User Function FinR850()
	Local aAreaR4 As Array
	Local oReport As Object
	
	If !IsBlind()
		If GetRpoRelease() >= "12.1.033" .and. FindFunction("MsgExpRot")
			MsgExpRot("FINR850",;
						STR0040,; // "Relatório Retorno CNAB (FINR650)"
						"https://tdn.totvs.com/x/KGO5Jw",;
						"20220820",,; 
						"20220820" )  
			If Date() >= CTOD("20/08/2022")
				MsgAlert(STR0041, STR0042) //"Rotina descontinuada" # "Alerta"
				Return
			EndIf
		EndIf
	EndIf

	//Inicializa variáveis
	aAreaR4	:= GetArea()
	oReport := ReportDef()
	
	oReport:PrintDialog()
	
	RestArea(aAreaR4)
	FwFreeArray(aAreaR4)
Return

//---------------------------------------------
/*/{Protheus.doc} ReportDef
Definicao do objeto do relatorio personalizavel 
e das secoes que serao utilizadas.

@author Julio Wittwer / Jose Novaes 
@since 28/08/2006
@version P12
/*/
//---------------------------------------------
Static Function ReportDef()
	Local cReport 	As Char
	Local cDescri 	As Char
	Local cTitulo 	As Char
	Local cPerg		As Char	
	Local oReport   As Object
	Local oSection1 As Object
	Local oSection2 As Object
	
	//Inicialização das variáveis
	cReport := "FINR850"
	cDescri := STR0001 + " " + STR0002 + STR0003
	cTitulo := STR0004
	cPerg   := "FIN850"
	oReport   := Nil
	oSection1 := Nil
	oSection2 := Nil
	
	IniStatic()
	pergunte("FIN850", .F.)
	
	//Criacao do objeto de impressao                                                                       ³
	oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport)}, cDescri)
	oReport:SetPortrait()
	
	//Seção 1
	oSection1 := TRSection():New(oReport, STR0035, "SE2")
	TRCell():New(oSection1, "PREFIXO", "SE2", STR0028, PesqPict("SE2","E2_PREFIXO"), __nTamPref,   /*lPixel*/, {||SE2->E2_PREFIXO})	//PRF
	TRCell():New(oSection1, "NUM"  	 , "SE2", STR0029, PesqPict("SE2","E2_NUM"),    (__nTamNum+1), /*lPixel*/, {||SE2->E2_NUM})	    //TITULO
	TRCell():New(oSection1, "PARCELA", "SE2", STR0030, PesqPict("SE2","E2_PARCELA"), __nTamParc,   /*lPixel*/, {||SE2->E2_PARCELA})	//PC
	TRCell():New(oSection1, "TIPO",    "SE2", STR0031, PesqPict("SE2","E2_TIPO"),    __nTamTipo,   /*lPixel*/, {||SE2->E2_TIPO})	//TP
	TRCell():New(oSection1, "FORNECE", "SE2", STR0032, PesqPict("SE2","E2_FORNECE"), __nTamForn,   /*lPixel*/, {||SE2->E2_FORNECE})	//FORNECEDOR
	TRCell():New(oSection1, "VALOR",   "",    STR0033, TM(0,13),                             13,   /*lPixel*/, /*CodeBlock*/, "RIGHT",,"RIGHT") //VALOR
	TRCell():New(oSection1, "OCORR",   "",    STR0034, /*Picture*/,                          30 ,  /*lPixel*/, /*CodeBlock*/) //OCORRENCIA
	oSection1:SetNoFilter("SE2")
	
	//Seção 2
	oSection2 := TRSection():New(oReport, STR0036, "SE2")
	TRCell():New(oSection2, "TXTSTR", "", STR0025,       Nil, 32, Nil, Nil) //Totais do Relatorio
	TRCell():New(oSection2, "TOTVLR", "", STR0033, TM(0, 13), 13, Nil, Nil, "RIGHT", Nil, "RIGHT") //VALOR
	oSection2:SetHeaderSection(.F.)
	oSection2:SetNoFilter("")
Return oReport

//---------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o objeto oReport definido na funcao ReportDef

@author Julio Wittwer / Jose Novaes 
@since 28/08/2006
@version P12
/*/
//---------------------------------------------
Static Function ReportPrint(oReport)
	Local lPaMov    As Logical
	Local lNewDetJ  As Logical
	Local lNewDetO  As Logical
	Local lDataGrv  As Logical
	Local lDifPag   As Logical
	Local lAchouTit As Logical
	Local cArqConf  As Char
	Local cArqEnt   As Char
	Local cBuffer   As Char
	Local cTabela   As Char
	Local cRegistro As Char
	Local cRetorno  As Char
	Local cSegmento As Char
	Local cValpag   As Char
	Local cTabRej 	As Char
	Local cDescric  As Char
	Local cDesc1    As Char
	Local cDesc2    As Char
	Local cDesc3    As Char
	Local cDesc4    As Char
	Local cDescRej  As Char
	Local cKeySE5   As Char
	Local cNumtit   As Char
	Local nBytes    As Numeric
	Local nTamArq   As Numeric
	Local nLidos    As Numeric
	Local nHdlConf  As Numeric
	Local nRectit   As Numeric
	Local nAscan    As Numeric
	Local nValt     As Numeric
	Local nX 		As Numeric
	Local nTamTit 	As Numeric
	Local oSection1 As Array
	Local oSection2 As Array
	Local aHeadA    As Array
	Local aHead1    As Array
	Local aHead2    As Array
	Local aDetA     As Array
	Local aDetB     As Array
	Local aDetJ     As Array
	Local aTraiA    As Array
	Local aTrai1    As Array
	Local aTrai2    As Array
	Local aDetN     As Array
	Local aDetO     As Array
	Local aCntOco   As Array	
	
	//Inicializa variáveis.
	lPaMov    := .F.
	lNewDetJ  := .F.
	lNewDetO  := .F.
	lDataGrv  := .F.
	lDifPag   := SuperGetMV("MV_DIFPAG", .F., .F.)
	lAchouTit := .T.
	cArqConf  := ""
	cArqEnt   := ""
	cBuffer   := ""
	cTabela   := ""
	cRegistro := ""
	cRetorno  := ""
	cSegmento := ""
	cValpag   := ""
	cTabRej   := SuperGetMV("MV_TABREJ", .F., "")
	cDescric  := ""
	cDesc1    := "DATA"
	cDesc2    := "PRINCIPAL"
	cDesc3    := "MULTA"
	cDesc4    := "JUROS"
	cDescRej  := ""
	cKeySE5   := ""
	cNumtit   := ""
	nBytes    := 0
	nTamArq   := 0
	nLidos    := 0
	nHdlConf  := 0
	nRectit   := 0
	nAscan    := 0
	nValt     := 0 
	nX 		  := 0
	nTamTit   := ( __nTamPref+__nTamNum+__nTamParc+__nTamTipo+__nTamForn)
	oSection1 := oReport:Section(1)
	oSection2 := oReport:Section(2)	
	aHeadA    := {}
	aHead1    := {}
	aHead2    := {}
	aDetA     := {}
	aDetB     := {}
	aDetJ     := {}
	aTraiA    := {}
	aTrai1    := {}
	aTrai2    := {}
	aDetN     := {}
	aDetO     := {}
	aCntOco   := {}
	
	//Definicoes das secoes
	oSection1:Cell("VALOR"):SetBlock({||nvalpag})
	SA6->(DbSeek(xFilial("SA6")+mv_par03+mv_par04+mv_par05))
	
	//Verifica configuracao
	If !SEE->(DbSeek(xFilial("SEE")+mv_par03+mv_par04+mv_par05+mv_par06))
		Help(" ",1,"PAR150")
		Return .F.
	Endif
	
	//Verifica se a tabela existe
	cTabela := Iif(Empty(SEE->EE_TABELA), "17" , SEE->EE_TABELA)
	
	If !SX5->(dbSeek(cFilial+cTabela))
		Help(" ",1,"PAR150")
		Return .F.
	Endif
	
	//Leitura da Configuracao SISPAG
	cArqConf := AllTrim(mv_par02)
	
	If !FILE(cArqConf)
		Help(" ", 1, "NOARQPAR")
		Return .F.
	Endif
	
	If (nHdlConf := FOPEN(cArqConf, 0)) < 0
		Help(" ",1,"NOARQUIVO",,cArqConf,5,1)
		Return .F.
	Endif
	
	nTamArq := FSEEK(nHdlConf, 0, 2)
	FSEEK(nHdlConf, 0, 0)
	cBuffer := Space(85)
	
	//Preenche os arrays de acordo com o Identificador
	While nBytes < nTamArq
		FREAD(nHdlConf,@cBuffer,85)
		IF SubStr(cBuffer,1,1) == "A" .or. SubStr(cBuffer,1,1) == Chr(1)
		AADD(aHeadA,{  SubStr(cBuffer,02,15),;
						SubStr(cBuffer,17,03),;
						SubStr(cBuffer,20,03),;
						SubStr(cBuffer,23,01),;
						SubStr(cBuffer,24,60)})
		ElseIf SubStr(cBuffer,1,1) == "B" .or. SubStr(cBuffer,1,1) == Chr(2)
			AADD(aHead1,{  SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
								SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
								SubStr(cBuffer,24,60 ) } )
		ElseIf SubStr(cBuffer,1,1) == "C" .or. SubStr(cBuffer,1,1) == Chr(3)
			AADD(aHead2,{  SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
								SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
								SubStr(cBuffer,24,60 ) } )
		Elseif SubStr(cBuffer,1,1) == "D" .or. SubStr(cBuffer,1,1) == Chr(4)
			AADD(aTrai1,{  SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
								SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
								SubStr(cBuffer,24,60) } )
		Elseif SubStr(cBuffer,1,1) == "E" .or. SubStr(cBuffer,1,1) == Chr(5)
			AADD(aTrai2,{  SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
								SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
								SubStr(cBuffer,24,60) } )
		Elseif SubStr(cBuffer,1,1) == "F" .or. SubStr(cBuffer,1,1) == Chr(6)
			AADD(aTraiA,{  SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
								SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
								SubStr(cBuffer,24,60) } )
		Elseif SubStr(cBuffer,1,1) == "G" .or. SubStr(cBuffer,1,1) == Chr(7)
			AADD(aDetA,{   SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
								SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
								SubStr(cBuffer,24,60) } )
		Elseif SubStr(cBuffer,1,1) == "H" .or. SubStr(cBuffer,1,1) == Chr(8)
			AADD(aDetB,{   SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
								SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
								SubStr(cBuffer,24,60) } )
		Elseif SubStr(cBuffer,1,1) == "J" .or. SubStr(cBuffer,1,1) == Chr(10)
			AADD(aDetJ,{   SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
								SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
								SubStr(cBuffer,24,60) } )
		Elseif SubStr(cBuffer,1,1) == "N" .or. SubStr(cBuffer,1,1) == Chr(16)
			AADD(aDetN,{   SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
				SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
				SubStr(cBuffer,24,60) } )
		Elseif SubStr(cBuffer,1,1) == "O" .or. SubStr(cBuffer,1,1) == Chr(17)
			AADD(aDetO,{   SubStr(cBuffer,02,15) ,SubStr(cBuffer,17,03),;
				SubStr(cBuffer,20,03) ,SubStr(cBuffer,23,01),;
				SubStr(cBuffer,24,60) } )
		Endif
		nBytes += 85
	Enddo
	
	Fclose(nHdlConf)
	
	If Len(aHeadA) == 0 .And. Len(aHead1) == 0 .And. Len(aHead2) == 0 .And. Len(aTrai1) == 0 .And. Len(aTrai2) == 0;
	.And. Len(aDetA)  == 0 .And. Len(aDetB)  == 0 .And. Len(aDetJ)  == 0 .And. Len(aDetN)  == 0 .And. Len(aDetO)  == 0
		Help(" ", 1, "AX044BCO")
		Return .F.
	Endif
	
	//Valida se há arquivo de entrada
	If !FILE((cArqEnt := mv_par01))
		Help(" ",1,"NOARQENT")
		Return .F.
	Endif
	
	//Abre arquivo enviado pelo banco
	If (nHdlBco := FOPEN(cArqEnt, 0)) < 0
		Help(" ", 1, "NOARQUIVO", Nil, cArqEnt, 5, 1)
		Return .F.
	Endif
	
	lNewDetJ := (Len(aDetJ) > 23)  //Verifica se está com a nova estrutura do Segmento J que incluiu o Fator de Vencimento.
	lNewDetO := (Len(aDetO) >= 21) //Verifica se está com a nova estrutura do Segmento O que incluiu o Fator de Vencimento.
	nLidos   := 0
	nTamArq  := FSEEK(nHdlBco, 0, 2)
	cBuffer  := Space(242)
	
	FSEEK(nHdlBco, 0, 0)
	oReport:SetMeter(nTamArq / Len(cBuffer))
	DbSelectArea("SEB")
	SEB->(DbSetOrder(1))
	dbSelectArea("SE5")
	SE5->(DbSetOrder(2))
	DbSelectArea("SE2")	
	
	While nLidos <= nTamArq
		//Le linha do arquivo retorno
		FREAD(nHdlBco,@cBuffer,242)
		nLidos += 242
		oReport:IncMeter()
		cRegistro := Subst(cBuffer, Val(aHeada[3,2]), 1 + Val(aHeada[3,3]) - Val(aHeada[3,2]))
		
		If cRegistro $ "0|1"
			Loop
		EndIf
		
		If cRegistro == "9"
			Exit
		Endif

		If cRegistro != "3"
			Loop
		Endif
		
		//Segmentos opcionais B. Obs: Segmentos A e J possuem informacoes sobre o retorno
		cSegmento := Subst(cBuffer, Val(aDeta[5,2]), 1 + Val(aDeta[5,3]) - Val(aDeta[5,2]))
		
		If cSegmento == "A"
			cRetorno := Subst(cBuffer, Val(aDeta[Len(aDeta),2]) , 1 + Val(aDeta[Len(aDeta),3]) - Val(aDeta[Len(aDeta),2]))
			cNumTit  := Subst(cBuffer, Val(aDeta[11,2]), 1 + Val(aDeta[11,3]) - Val(aDeta[11,2]))
			cValPag  := Subst(cBuffer, Val(aDeta[15,2]), 1 + Val(aDeta[15,3]) - Val(aDeta[15,2]))
		ElseIf cSegmento == "J"
			cRetorno := Subst(cBuffer, Val(aDetJ[Len(aDetJ),2]), 1 + Val(aDetJ[Len(aDetJ),3]) - Val(aDetJ[Len(aDetJ),2]))
			
			If lNewDetJ	
				cNumTit := Subst(cBuffer, Val(aDetJ[21,2]), 1 + Val(aDetJ[21,3]) - Val(aDetJ[21,2]))
				cValPag := Subst(cBuffer, Val(aDetJ[19,2]), 1 + Val(aDetJ[19,3]) - Val(aDetJ[19,2]))
			Else
				cNumTit := Subst(cBuffer, Val(aDetJ[20,2]), 1 + Val(aDetJ[20,3]) - Val(aDetJ[20,2]))
				cValPag := Subst(cBuffer, Val(aDetJ[18,2]), 1 + Val(aDetJ[18,3]) - Val(aDetJ[18,2]))
			Endif
		ElseIf cSegmento == "N"
			If !lDifPag
				cRetorno := Subst(cBuffer, Val(aDetN[Len(aDetN),2]), 1 + Val(aDetN[Len(aDetN),3]) - Val(aDetN[Len(aDetN),2]))
			Else
				If (nAscan := Ascan(aDetN, {|e| AllTrim(Upper(e[1])) == "OCORRENCIAS"})) > 0
					cRetorno := Subst(cBuffer, Val(aDetN[nAscan,2]), 1 + Val(aDetN[nAscan,3]) - Val(aDetN[nAscan,2]))		
				Else
					ApMsgAlert(STR0026 + "OCORRENCIAS" + STR0027)
				EndIf
			EndIf
			
			//Procura a posicao do numero do titulo
			If (nAscan := Ascan(aDetN, {|e| AllTrim(Upper(e[1])) == "SEU NUMERO"})) > 0
				cNumTit := Subst(cBuffer, Val(aDetN[nAscan,2]), 1 + Val(aDetN[nAscan,3]) - Val(aDetN[nAscan,2]))		
			Else
				ApMsgAlert(STR0017)
			EndIf
			
			//Verifica o tipo do imposto para saber qual posicao do array que contem as posicoes dos campos com os dados do tributo
			cTipoImp := Substr(cBuffer, Val(aDetN[07,2]), 1 + Val(aDetN[07,3]) - Val(aDetN[07,2]))	
			
			//Retorno contem configuracao de campos de acordo com o tipo do tributo
			If lDifPag    
				Do Case
					Case cTipoImp == "01" //GPS
						cDesc1 := "DATA GPS" 
						cDesc2 := "PRINCIPAL GPS"     
						cDesc3 := "MULTA GPS"
						cDesc4 := "JUROS GPS"			
					Case cTipoImp == "02" //DARF
						cDesc1 := "DATA DARF"
						cDesc2 := "PRINCIPAL DARF"     
						cDesc3 := "MULTA DARF"
						cDesc4 := "JUROS DARF"
					Case cTipoImp == "03" //DARF Simples
						cDesc1 := "DATA SIMPLES"
						cDesc2 := "PRINC. SIMPLES"	
						cDesc3 := "MULTA SIMPLES"
						cDesc4 := "JUROS SIMPLES"
					Case cTipoImp == "04" //DARJ 
						cDesc1 := "DATA DARJ"
						cDesc2 := "PRINCIPAL DARJ"			
						cDesc3 := "MULTA DARJ"
						cDesc4 := "JUROS DARJ"
					Case cTipoImp == "05" //ICMS SP
						cDesc1 := "DATA ICMS"
						cDesc2 := "PRINCIPAL ICMS"			
						cDesc3 := "MULTA ICMS"
						cDesc4 := "JUROS ICMS"
					Case cTipoImp $ "07#08"	//07 - IPVA (SP e MG), 08 - DPVAT
						cDesc1 := "DATA IPVA"
						cDesc2 := "PRINCIPAL IPVA"			
						cDesc3 := "MULTA IPVA"
						cDesc4 := "JUROS IPVA"
					Case cTipoImp $ "11"	//11 - FGTS
						cDesc1 := "DATA FGTS"
						cDesc2 := "PRINCIPAL FGTS"								
				EndCase
			Else
				If (nPos := Ascan(aDetN, {|e| AllTrim(Upper(e[1]))=="DATA"})) <= 0
					If cTipoImp == "01" //GPS
						nPos := 15
					ElseIf cTipoImp == "02" //DARF
						nPos := 18			
					ElseIf cTipoImp $ "03#04#05" //DARF Simples, 04 - DARJ e 05 - ICMS SP
						nPos := 20	
					ElseIf cTipoImp $ "11" //11 - FGTS	// MGOMES - 21/06/2018 - ISSUE
						nPos := 16		
					Endif
				Endif
				
				//Verifico o tipo do imposto para saber qual posicao do array contem as posicoes das datas de baixa.
				cData    := Substr(cBuffer, Val(aDetN[nPos,2]), 1 + Val(aDetN[nPos,3] ) - Val(aDetN[nPos,2]))
				cData    := ChangDate(cData, SEE->EE_TIPODAT)
				dBaixa   := Ctod(Substr(cData, 1, 2) + "/" + Substr(cData, 3, 2) + "/" + Substr(cData, 5), "ddmm" + Replicate("y", Len(Substr(cData,5))))
				lDataGrv := .T.	   
			EndIF
			
			//Procura a posicao da data do tributo		
			If !lDataGrv .And. lDifPag 
				nAscan := Ascan(aDetN, {|e| AllTrim(Upper(e[1])) == cDesc1})
				
				If nAscan > 0
					cData  := Substr(cBuffer, Val(aDetN[nAscan,2]), 1 + Val(aDetN[nAscan,3] ) - Val(aDetN[nAscan,2]))
					cData  := ChangDate(cData, SEE->EE_TIPODAT)
					dBaixa := Ctod(Substr(cData, 1, 2) + "/" + Substr(cData,3,2) + "/" + Substr(cData,5),"ddmm" + Replicate("y", Len(Substr(cData,5))))
				Else
					ApMsgAlert(STR0026+ cDesc1 + STR0027)
				Endif	
			EndIf
			
			//Procura a posicao do valor principal do tributo		
			nAscan := Ascan(aDetN, {|e| AllTrim(Upper(e[1])) == cDesc2})
			
			If nAscan > 0
				cValPag := Subst(cBuffer, Val(aDetN[nAscan,2]), 1 + Val(aDetN[nAscan,3] ) - Val(aDetN[nAscan,2]))
			Else
				ApMsgAlert(STR0026+ cDesc2 + STR0027)
			Endif
			
			//Procura a posicao da multa do tributo
			nAscan := Ascan(aDetN, {|e| AllTrim(Upper(e[1]))==cDesc3})
			
			If cTipoImp $ "11" //FGTS
				nMulta := 0
			ElseIf nAscan > 0
				nMulta := Round(Val(Subst( cBuffer, Val(aDetN[nAscan,2])         , 1+Val(aDetN[nAscan,3] )-Val(aDetN[nAscan,2])))/100,2)
			Else
				ApMsgAlert(STR0026+ cDesc3 + STR0027)
			Endif
			
			//Procura a posicao do juros do tributo			
			nAscan := Ascan(aDetN, {|e| AllTrim(Upper(e[1])) == cDesc4})
			
			If cTipoImp $ "11" //FGTS
				nJuros := 0
			ElseIf nAscan > 0
				cValJur := Subst( cBuffer, Val(aDetN[nAscan,2]), 1 + Val(aDetN[nAscan,3]) - Val(aDetN[nAscan,2]))
				nJuros	:= Val(cValJur)/100       
			Else
				ApMsgAlert(STR0026+ cDesc4 + STR0027)
			Endif	  
		ElseIf cSegmento == "O"
			cRetorno := Subst(cBuffer, Val(aDetO[Len(aDetO),2]), 1 + Val(aDetO[Len(aDetO),3]) - Val(aDetO[Len(aDetO),2]))
			
			If lNewDetO
				cNumTit := Subst(cBuffer, Val(aDetO[18,2]), 1 + Val(aDetO[18,3] ) - Val(aDetO[18,2]))
			Else
				cNumTit := Subst(cBuffer, Val(aDetO[16,2]), 1 + Val(aDetO[16,3] ) - Val(aDetO[16,2]))
			EndIf
			
			cValPag := Subst(cBuffer, Val(aDetO[14,2]), 1 + Val(aDetO[14,3] ) - Val(aDetO[14,2]))
		Else
			Loop
		Endif
		
		nvalpag := val(cvalpag)/100
		
		//Totalizador Geral do Arquivo de Retorno	
		nValT  += nValPag
		
		//Verifica se existe o titulo no SE2
		dbSelectArea("SE2")
		lAchouTit := .T.
		
		//Busca por IdCnab (sem filial)
		nRecTit := SE2->(Recno())
		SE2->(dbSetOrder(13))
		
		If SE2->(MsSeek(Substr(cNumTit, 1, 10)))
			cFilAnt	:= SE2->E2_FILORIG
		Endif
		
		//Se nao achou, utiliza metodo antigo (titulo)
		If SE2->(!Found())
			SE2->(dbSetOrder(1))
			If !SE2->(DbSeek(xFilial("SE2")+Pad(cNumTit, nTamTit)))
				cNumTit := SubStr(cNumTit, 1, __nTamPref) + Padr(Substr(cNumTit, 4, 6), __nTamNum) + SubStr(cNumTit, 10)
				
				If !SE2->(DbSeek(xFilial("SE2")+Pad(cNumTit, nTamTit)))
					lAchouTit := .F.	
				Endif
			Endif
		Endif	      
		
		//Verifico existencia de movimento anterior (arquivo reprocessado)
		lPaMov = .F.
		cKeySe5 := xFilial("SE5")+IIF(SE2->E2_TIPO $ MVPAGANT,"PA","TX")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA)
		cKeySe5 += IIF(SE2->E2_TIPO $ MVPAGANT,"PA ","TXA")
		
		If SE5->(MsSeek(cKeySe5))
			While !SE5->(EOF()) .And. SE5->(E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO) == cKeySe5
				If (lPaMov := SE2->(E2_FORNECE+E2_LOJA) == SE5->(E5_CLIFOR+E5_LOJA))
					Exit
				EndIf
				SE5->(DbSkip())
			Enddo
		Endif
		
		oSection1:Init()
		
		If !lAchouTit
			oSection1:Cell("PREFIXO"):Hide()
			oSection1:Cell("NUM"):SetBlock ( { || cNumtit } )	         
			oSection1:Cell("PARCELA"):Hide()
			oSection1:Cell("TIPO"):Hide()
			oSection1:Cell("FORNECE"):Hide()
			oSection1:Cell("VALOR"):SetBlock({||nValPag}) 
			oSection1:Cell("OCORR"):SetBlock({||STR0009}) //TITULO NAO ENCONTRADO
			oSection1:PrintLine()
			
			//Totaliza Ocorrencia
			TotOcorr (cRetorno,STR0021,nValPag,aCntOco)	//"Titulos nao encontrados"
			oSection1:Cell("PREFIXO"):Show()
			oSection1:Cell("PARCELA"):Show()
			oSection1:Cell("TIPO"):Show()
			oSection1:Cell("FORNECE"):Show()
			SE2->(DbGoTo(nRecTit))
			Loop
		Else
			If "00" $ cRetorno			
				If SE2->E2_SALDO == 0
					oSection1:Cell("OCORR"):SetBlock ( { || OemToAnsi(STR0011) } )
					oSection1:PrintLine()
					//Totaliza Ocorrencia
					TotOcorr(cRetorno, STR0022, nValPag, aCntOco) //Titulos ja baixados
					SE2->(DbGoTo(nRecTit))
					Loop
				ElseIf lPaMov .and. SE2->E2_TIPO $ MVPAGANT+"#"+MVTXA
					oSection1:Cell("OCORR"):SetBlock({||STR0037}) //PA JA DEBITADO
					oSection1:PrintLine()
					//Totaliza Ocorrencia
					TotOcorr (cRetorno, STR0037, nValPag, aCntOco) //PA ja Debitado
					SE2->(DbGoTo(nRecTit))
					Loop			
				Endif
				
				SEB->(DbSeek(xFilial("SEB")+mv_par03+Substr(cRetorno, 1, __nTamOcor) + "R"))
				
				If !LEFT(SEB->EB_OCORR,2) $ "06/07/08"  //Baixa do Titulo
					oSection1:Cell("OCORR"):SetBlock ( { || OemToAnsi(STR0008) } ) //OCORRENCIA NAO ENCONTRADA
					oSection1:PrintLine()
					//Totaliza Ocorrencia
					TotOcorr (cRetorno, STR0008, nValPag, aCntOco) //"Ocorrencia nao encontrada"	
					Loop			
				Else
					nJuros     := Iif(Type("nJuros")   != "N", 0, nJuros	)
					nMulta	   := Iif(Type("nMulta")   != "N", 0, nMulta	)
					nDescont   := Iif(Type("nDescont") != "N", 0, nDescont	)
					nValPadrao := nValPag-(nJuros+nMulta-nDescont)
					nTotAbat   := SumAbatPag(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_FORNECE,SE2->E2_MOEDA,"S",dDatabase,SE2->E2_LOJA)
					
					If Round(NoRound((SE2->E2_SALDO-nTotAbat),3),2) < Round(NoRound(nValPadrao,3),2)
						oSection1:Cell("OCORR"):SetBlock ( { || STR0038} ) //"VLR PAGO MAIOR"
					ElseIf Round(NoRound((SE2->E2_SALDO-nTotAbat),3),2) > Round(NoRound(nValPadrao,3),2)
						oSection1:Cell("OCORR"):SetBlock({||STR0039}) //VLR PAGO MENOR
					Else
						oSection1:Cell("OCORR"):SetBlock({||STR0010}) //TITULO OK
					Endif
					
					oSection1:PrintLine()
					//Totaliza Ocorrencia
					TotOcorr(cRetorno, "", nValPag, aCntOco)
				EndIf
			ElseIf ("BD" $ cRetorno)
				oSection1:Cell("OCORR"):SetBlock ( { || STR0015 } )	//"PAGAMENTO AGENDADO"
				oSection1:PrintLine()
				
				TotOcorr (cRetorno, STR0015, nValPag, aCntOco) //PAGAMENTO AGENDADO
			ElseIf ("BE" $ cRetorno) 
				oSection1:Cell("OCORR"):SetBlock({||STR0016}) //PGTO AGENDADO ALTER. P/ OP
				oSection1:PrintLine()
				
				TotOcorr (cRetorno, STR0016, nValPag, aCntOco) //PGTO AGENDADO ALTER. P/ OP
			Elseif !Empty(cTabRej)
				cDescRej  := STR0008 //OCORRENCIA NAO ENCONTRADA
				
				If SEB->(DbSeek(xFilial("SEB")+mv_par03+Substr(cRetorno, 1, __nTamOcor)+"R")) // Pesquiso a descrição na Tabela SEB
					cDescRej := SEB->EB_DESCRI
				Else
					cRetorno := AllTrim(cRetorno)
					
					If Empty(cDescric := Tabela(cTabRej, cRetorno, .F.))
						cDescric := Tabela(cTabRej, SubStr(cRetorno, 1, 2), .F.)
					EndIf
					
					If !Empty(cDescric)
						cDescRej := Left(cDescric, 30)
					EndIf				
				EndIf
				
				oSection1:Cell("OCORR"):SetBlock ({||cDescRej})
				oSection1:PrintLine()
				TotOcorr(cRetorno, cDescRej, nValPag, aCntOco)
				cDescRej := "" 
			Endif			
		Endif
	Enddo
	
	oSection1:Finish()
	
	//Imprime Subtotais por ocorrencia
	oReport:SkipLine(2)
	oReport:PrintText(STR0024) //SubTotais do Relatorio
	
	For nX :=1 to Len(aCntOco)         
		oSection2:Init()
		oSection2:Cell("TXTSTR"):SetBlock({||AllTrim(aCntOco[nX][1]) + " - " + Substr(aCntOco[nX][2], 1, 30)})
		oSection2:Cell("TOTVLR"):SetBlock({||aCntOco[nX][VALORPAGO]})
		oSection2:PrintLine()
	Next nX
	
	oSection2:Finish()
	
	//Imprime Totais
	oSection2:Init()
	oSection2:Cell("TXTSTR"):SetBlock({||STR0025})
	oSection2:Cell("TOTVLR"):SetBlock({||nValT})
	oSection2:PrintLine()
	oSection2:Finish()
	
	//Fecha os Arquivos ASCII
	FCLOSE(nHdlBco)
	FwFreeArray(aHeadA)
	FwFreeArray(aHead1)
	FwFreeArray(aHead2)
	FwFreeArray(aDetA)
	FwFreeArray(aDetB)
	FwFreeArray(aDetJ)
	FwFreeArray(aTraiA)
	FwFreeArray(aTrai1)
	FwFreeArray(aTrai2)
	FwFreeArray(aDetN)
	FwFreeArray(aDetO)
	FwFreeArray(aCntOco)	
Return

//---------------------------------------------
/*/{Protheus.doc} TotOcorr
Acumula o valor pago por ocorrencia

@author Ricardo A. Canteras
@since 05/10/2005
@version P12
/*/
//---------------------------------------------
Static Function TotOcorr(cOcorr As Char, cDescr As Char, nValPag As Numeric, aCntOco As Array)
	Local nCntOco As Numeric
	
	//Inicializa variáveis
	nCntOco := 0
	
	Default cOcorr  := ""
	Default cDescr  := ""
	Default nValPag := 0
	Default aCntOco := {}
	
	//Efetua contagem dos SubTotais por ocorrencia
	If SEB->(DbSeek(xFilial("SEB")+mv_par03+Pad(cOcorr, __nTamOcor)+"R"))
		If (nCntOco := Ascan(aCntOco, { |X| X[1] == SEB->EB_OCORR})) == 0
			Aadd(aCntOco, {SEB->EB_OCORR, Subs(SEB->EB_DESCRI, 1, 27), nValPAG})
		Endif
	ElseIf (nCntOco := Ascan(aCntOco, { |X| X[1] == Pad(cOcorr, Len(SEB->EB_OCORR))})) == 0
		Aadd(aCntOco, {Pad(cOcorr, Len(SEB->EB_OCORR)), Subs(cDescr, 1, 27), nValPAG})
	Endif
	
	If nCntOco > 0
		aCntOco[nCntOco][VALORPAGO] += nValPag
	EndIf
Return Nil

//-------------------------------
/*/{Protheus.doc} IniStatic
Inicializa variáveis static

@author Sivaldo Oliveira
@since 06/10/2021
@version P12
/*/
//-------------------------------
Static Function IniStatic()
	__nTamPref := TamSX3("E2_PREFIXO")[1]
	__nTamNum  := TamSX3("E2_NUM")[1]
	__nTamParc := TamSX3("E2_PARCELA")[1]
	__nTamTipo := TamSX3("E2_TIPO")[1]
	__nTamForn := TamSX3("E2_FORNECE")[1]
	__nTamOcor := TamSX3("EB_REFBAN")[1]
Return Nil
