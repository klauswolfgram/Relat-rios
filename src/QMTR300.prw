/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR300.Ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QMTR300   ºAutor  ³Leandro Sabino      º Data ³  12/07/06	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relacao de instrumentos        							  º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QMTR300()
Local oReport                    

If TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                  ³
	//³ mv_par01   : Instrumento Inicial                      ³
	//³ mv_par02   : Instrumento Final                        ³
	//³ mv_par03   : Periodo Inicial                          ³
	//³ mv_par04   : Periodo Final                            ³
	//³ mv_par05   : Departamento Inicial                     ³
	//³ mv_par06   : Departamento Final                       ³
	//³ mv_par07   : Orgao Calibrador Todos/Interno/Externo   ³
	//³ mv_par08   : Orgao Calibrador interno de              ³
	//³ mv_par09   : Orgao Calibrador interno ate             ³
	//³ mv_par10   : Orgao Calibrador externo de              ³
	//³ mv_par11   : Orgao Calibrador externo ate             ³
	//³ mv_par12   : Usu rio de                               ³
	//³ mv_par13   : Usu rio ate                              ³
	//³ mv_par14   : Status de                                ³
	//³ mv_par15   : Status ate                               ³
	//³ mv_par16   : Quebra Depto / Pagina                    ³
	//³ mv_par17   : Imprime Legenda do Status                ³
	//³ mv_par18   : Imprime Nao Habilitado                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	Pergunte("QMR300",.F.) 
    oReport := ReportDef()
    oReport:PrintDialog()
Else
    U_QMTR300R3()	// Executa versão anterior do fonte
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 12/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR240                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local ctitulo  := OemToAnsi( STR0005 ) // "Listagem de Instrumento"
Local cDesc1   := OemToAnsi( STR0001 ) // "Este programa ira emitir a listagem de"
Local cDesc2   := OemToAnsi( STR0002 ) // "instrumentos"
Local oSection1 
Local oSection2 
Local aOrdem	:= {}

//Definicao de Indices
Aadd( aOrdem, OemToAnsi(STR0012) ) // "Departamento"
Aadd( aOrdem, OemToAnsi(STR0013) ) // "Instrumento"
Aadd( aOrdem, OemToAnsi(STR0011) ) // "Departamento/Instrumento"

DEFINE REPORT oReport NAME "QMTR300" TITLE cTitulo PARAMETER "QMR300" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)
oReport:SetLandscape(.T.)

oSection1 := TRSection():New(oReport,OemToAnsi(STR0011),{"QM2"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) //Departamento/Instrumento
DEFINE CELL NAME "cDEPTO"   OF oSection1 ALIAS "QM2" TITLE OemToAnsi(STR0014) SIZE 50 

DEFINE SECTION oSection2 OF oSection1 TABLES "QM2" TITLE TitSx3("QM2_INSTR")[1]
DEFINE CELL NAME "cINSTR"  OF oSection2 ALIAS "QM2" TITLE TitSx3("QM2_INSTR")[1]  SIZE 20  //Instrumento
DEFINE CELL NAME "cFABR"   OF oSection2 ALIAS "QM2" TITLE TitSx3("QM2_FABR")[1]   SIZE 20 //Fabrincante
DEFINE CELL NAME "cFREQAF" OF oSection2 ALIAS "QM2" TITLE TitSx3("QM2_FREQAF")[1] SIZE 04 //Frequencia em dias
DEFINE CELL NAME "cOrgao"  OF oSection2 ALIAS "QM2" TITLE OemToAnsi(STR0022)      SIZE 20  LINE BREAK //Orgao Calibrador
DEFINE CELL NAME "ccampo"  OF oSection2 ALIAS "QM2" TITLE OemToAnsi(STR0026) 	  SIZE 20 //Procedimento
DEFINE CELL NAME "cDTULTC" OF oSection2 ALIAS "QM2" TITLE OemToAnsi(STR0019)+" "+OemToAnsi(STR0020) SIZE 08 //Dt. Ult. Calib.
DEFINE CELL NAME "cVALDAF" OF oSection2 ALIAS "QM2" TITLE OemToAnsi(STR0019)+" "+OemToAnsi(STR0021) SIZE 08 //Dt. Prox. Calib.
DEFINE CELL NAME "cSG"     OF oSection2 ALIAS "QM2" TITLE OemToAnsi(STR0027)      SIZE 03 //"SG"
DEFINE CELL NAME "cCUSTO"  OF oSection2 ALIAS "QM2" TITLE OemToAnsi(STR0028)      SIZE (TamSx3("QM2_CUSTO")[1]) //CUSTO
DEFINE CELL NAME "cLOCAL"  OF oSection2 ALIAS "QM2" TITLE TitSx3("QM2_LOCAL")[1]  SIZE (TamSx3("QM2_LOCAL")[1]) //Localizacao
DEFINE CELL NAME "cLEIT"   OF oSection2 ALIAS "QM2" TITLE TitSx3("QM2_LEIT")[1]   SIZE (TamSx3("QM2_LEIT") [1])  //Leitura
DEFINE CELL NAME "cTIPO"   OF oSection2 ALIAS "QM2" TITLE TitSx3("QM1_TIPO")[1]   SIZE 20    //Familia
DEFINE CELL NAME "cDESQM1" OF oSection2 ALIAS "QM2" TITLE TitSx3("QM1_DESCR")[1]  SIZE 38 //Descricao
DEFINE CELL NAME "cSTATUS" OF oSection2 ALIAS "QM2" TITLE TitSx3("QM2_STATUS")[1] SIZE (TamSx3("QM2_STATUS")[1])//STATUS
DEFINE CELL NAME "cREVINS" OF oSection2 ALIAS "QM2" TITLE OemToAnsi(STR0029)      SIZE 02 //Revisao

Return oReport


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 12/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR240                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport) 
Local oSection1   := oReport:Section(1)
Local oSection2   := oReport:Section(1):Section(1)
Local aInstru 	  := {}
Local TRB_INSTR	  := "" 
Local TRB_REVINS  := "" 	
Local TRB_DEPTO   := "" 	
Local TRB_TIPO    := "" 
Local TRB_VALDAF  := "" 	
Local TRB_FREQAF  := "" 	
Local TRB_RESP	  := "" 
Local TRB_FABR	  := "" 
Local TRB_STATUS  := "" 	
Local TRB_TDESCR  := "" 
Local TRB_CUSTO   := "" 
Local TRB_SGUARD  := "" 
Local TRB_QM2CTS  := "" 
Local TRB_LEIT    := "" 
Local TRB_DESQM1  := "" 
Local TRB_DESPTO  := "" 
Local cChave	  := ""   // Auxiliar para quebra de subtotal
Local CINSTR      := ""
Local cDepto      := ""   
Local nCntParc	  := 0    // Contador para subtotal
Local nCntTot	  := 0    // Contador para total
Local nTm         := 1
Local cAliasQry	  := GetNextAlias()
Local nOrdem   	  := oReport:Section(1):GetOrder() 
Local aArea		  := GetArea()
Local nLin 		  := 0
Local cOrgao	  := ""

dbSelectArea( "QM2" )
dbSetOrder(1)

MakeSqlExpr(oReport:uParam)
	
cChave := "%QM2_FILIAL,QM2_INSTR,QM2_REVINV%"	
	
BeginSQL alias cAliasQry //"TRB"

	SELECT *
	FROM %table:QM2% QM2, %table:QM1% QM1 					
	WHERE 
		QM2.QM2_FILIAL = %xFilial:QM2% AND 
		QM2.QM2_INSTR  BetWeen %Exp:mv_par01%       AND %Exp:mv_par02% AND  
		QM2.QM2_VALDAF BetWeen %Exp:DtoS(mv_par03)% AND %Exp:DtoS(mv_par04)% AND  
		QM2.QM2_DEPTO  BetWeen %Exp:mv_par05%       AND %Exp:mv_par06% AND  
		QM2.QM2_RESP   BetWeen %Exp:mv_par12%       AND %Exp:mv_par13% AND  
		QM2.QM2_TIPO  = QM1.QM1_TIPO AND 
		QM2.%notDel% AND QM1.%notDel% 	
	ORDER BY %Exp:cChave%	        

EndSql

While (cAliasQry)->(!Eof())

	If !Empty(AllTrim(oReport:Section(1):GetSqlExp("QM2")))
		If !(cAliasQry)->(&(oReport:Section(1):GetSqlExp("QM2")))
			dbSkip()
			Loop
		Endif
	EndIf

	If !Empty(AllTrim(oSection2:GetSqlExp("QM2")))
		If !(cAliasQry)->(&(oSection2:GetSqlExp("QM2")))
			dbSkip()
			Loop
		Endif
	EndIf

	If (cAliasQry)->QM2_FILIAL+(cAliasQry)->QM2_INSTR <> cInstr
			Aadd(aInstru,{(cAliasQry)->QM2_FILIAL,(cAliasQry)->QM2_INSTR,(cAliasQry)->QM2_REVINS,;
				(cAliasQry)->QM2_VALDAF,(cAliasQry)->QM2_FREQAF,(cAliasQry)->QM2_DEPTO,(cAliasQry)->QM2_RESP,;
				(cAliasQry)->QM2_TIPO,(cAliasQry)->QM2_FABR,(cAliasQry)->QM2_STATUS,;
				(cAliasQry)->QM2_LOCAL,(cAliasQry)->QM2_SGUARD,(cAliasQry)->QM2_CUSTO,(cAliasQry)->QM2_LEIT,(cAliasQry)->QM1_PROCAL,;
				(cAliasQry)->QM1_DESCR,(cAliasQry)->QM2_REVINV})
	Endif	
	cInstr := (cAliasQry)->QM2_FILIAL+(cAliasQry)->QM2_INSTR
	dbSkip()
Enddo    

If nOrdem == 1 		//Ordena por Depto
	aSort(aInstru,,,{|x,y| x[6] < y[6]})
ElseIf nOrdem == 2 //Instrumento
	aSort(aInstru,,,{|x,y| x[1]+x[2]< y[1]+y[2]})
ElseIf nOrdem == 3 //Instrumento/Depto
	aSort(aInstru,,,{|x,y| x[6]+x[1]+x[2] < y[6]+y[1]+y[2]})
Endif

If Len(aInstru) > 0
	cChave := aInstru[1][6]
Endif

dbSelectArea("QM2")
QM2->(dbSetOrder(1))	

While nTm <= Len(aInstru) 

	TRB_INSTR	:= aInstru[nTm][2]
	TRB_REVINS	:= aInstru[nTm][3]
	TRB_VALDAF	:= aInstru[nTm][4]
	TRB_FREQAF	:= aInstru[nTm][5]
	TRB_DEPTO	:= aInstru[nTm][6]
	TRB_RESP	:= aInstru[nTm][7]
	TRB_TIPO	:= aInstru[nTm][8]                                             	
	TRB_FABR	:= aInstru[nTm][9]
	TRB_STATUS	:= aInstru[nTm][10]
	TRB_LOCAL	:= aInstru[nTm][11]
	TRB_SGUARD	:= aInstru[nTm][12]
	TRB_QM2CTS  := aInstru[nTm][13]
	TRB_LEIT 	:= aInstru[nTm][14] 
	TRB_REVINV	:= aInstru[nTm][17] 

 	QM2->(Dbseek(xfilial("QM2")+TRB_INSTR+TRB_REVINV))  // posiciona QM2 para relatorio personalizado.

	TRB_TDESCR	:= aInstru[nTm][15]
	TRB_DESQM1 	:= aInstru[nTm][16]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno e externo                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1
		If ! Calibrador(0,mv_par08,mv_par09,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			nTm++
			dbSkip()
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 2
		If ! Calibrador(1,mv_par08,mv_par09,,,TRB_INSTR,TRB_REVINS)
			nTm++
			dbSkip()
			Loop
		Endif
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. externo                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 3
		If ! Calibrador(2,,,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			nTm++
			dbSkip()
			Loop
		EndIf
	EndIf

   	
   	If mv_par18 == 1 //Imprime Não Habilitados...
		If TRB_STATUS < mv_par14 .or. TRB_STATUS > mv_par15
			nTm++
			dbSkip()
			Loop	
		Endif
	Else
		If !QMTXSTAT(TRB_STATUS)
			nTm++
			dbSkip()
			Loop
		Endif
	Endif	
	
	If TRB_TIPO < mv_par19 .or. TRB_TIPO > mv_par20
		nTm++
		dbSkip()
		Loop
	EndIf
	
   	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura o departamento no QAD - Centro de Custo.             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QAD")
	dbSetOrder(1)
	If dbSeek( xFilial("QAD") + TRB_DEPTO )
	    TRB_CUSTO := QAD->QAD_CUSTO
		TRB_DESPTO := Alltrim(QAD->QAD_DESC)
	Else
		TRB_CUSTO := ""
		TRB_DESPTO := ""
	Endif    

	dbSelectArea( "QM1" )

   	oSection1:Init()
   	
   	QAD->(dbSeek( xFilial("QAD") + cChave ))
   
	If TRB_DEPTO <> cDepto
		If nCntParc <> 0
			oReport:SkipLine(1) 
			oReport:PrintText(OemToAnsi(STR0007)+Str(nCntParc,5),oReport:Row(),025) //"Subtotal.....................:"
			oReport:SkipLine(1)	
		Endif
		oSection1:Finish()
		oSection2:Finish()
		oSection1:Init()
	   	If mv_par16 == 1 
			oSection1:SetPageBreak(.T.) 
		Endif
		oSection1:Cell("cDEPTO"):SetValue(TRB_DEPTO+" - "+TRB_DESPTO)		
	    oSection1:PrintLine()
	    oSection2:Init()
	    nCntParc := 0    // Contador para subtotal
    Endif

	If !Empty(TRB_SGUARD)
		oSection2:Cell("cSG"):SetValue(SubStr(TRB_SGUARD,1,3))		
	Else
		oSection2:Cell("cSG"):SetValue("")			
	Endif	

	cOrgao	:= ""
	nLin 	:= 0
	
	dbSelectArea("QMK")
	dbSetOrder(1)
	If dbSeek(xFilial()+TRB_TIPO)
		dbSelectArea("QMR")
		dbSetOrder(1)
		If dbSeek(xFilial()+TRB_INSTR+TRB_REVINS)
			While !Eof() .And. xFilial()+TRB_INSTR+TRB_REVINS == QMR->(QMR_FILIAL+QMR_INSTR+QMR_REVINS)
				dbSelectArea("QM9")
				dbSetOrder(1)
				If dbSeek(xFilial()+QMR->QMR_ESCALA)
					If QM9->QM9_ORGAFE == "I"
						cOrgao += IIf(nLin == 0,STR0015,"/ "+STR0015)	//Interno
					Else
						cOrgao += IIf(nLin == 0,STR0016,"/ "+STR0016)	//Externo
					Endif
				Endif
				nLin++
				dbSelectArea("QMR")
				dbSkip()
			Enddo
			oSection2:Cell("cOrgao"):SetValue(cOrgao)
		Endif
	Endif	   	
   	
    //Nao considera revisao do instrumento, ou seja, uma vez calibrado o codigo do instrumento
    //essa coluna sera impressa
    dbSelectArea("QM6")
	dbSetOrder(4)
	If dbSeek(xFilial()+TRB_INSTR)
		oSection2:Cell("cDTULTC"):SetValue(DtoC(QM6->QM6_DATA))
	Else              
		oSection2:Cell("cDTULTC"):SetValue(STR0017)//"S/Calibra"
	Endif     
   	
   	oSection2:Cell("cINSTR"):SetValue(TRB_INSTR)
	oSection2:Cell("cFABR"):SetValue(TRB_FABR)
	oSection2:Cell("cFREQAF"):SetValue(TRB_FREQAF)
	oSection2:Cell("ccampo"):SetValue(TRB_TDESCR) 
	oSection2:Cell("cVALDAF"):SetValue(STOD(TRB_VALDAF))		
	oSection2:Cell("cCUSTO"):SetValue(TRB_QM2CTS)		
	oSection2:Cell("cLOCAL"):SetValue(TRB_LOCAL)
	oSection2:Cell("cLEIT"):SetValue(TRB_LEIT)
	oSection2:Cell("cTIPO"):SetValue(TRB_TIPO)
	oSection2:Cell("cDESQM1"):SetValue(TRB_DESQM1)
	oSection2:Cell("cSTATUS"):SetValue(TRB_STATUS)
	oSection2:Cell("cREVINS"):SetValue(Alltrim(TRB_REVINS))

	nCntParc++
	nCntTot++
	nTm++
    cDepto := TRB_DEPTO
	
	oSection2:PrintLine() 
	dbSkip()	
EndDo

If Len(aInstru) > 0 .And. nCntTot > 0
   
	oReport:SkipLine(1) 
	oReport:PrintText(OemToAnsi(STR0007)+Str(nCntParc,5),oReport:Row(),025)// "Subtotal.....................:"
	oReport:SkipLine(2)	
	oReport:PrintText(OemToAnsi(STR0008)+Str(nCntTot,5),oReport:Row(),025) //"Total........................:"
	oReport:SkipLine(1)	

	If mv_par17 == 1	
		oReport:SkipLine(1) 
		oReport:FatLine()
		oReport:PrintText(OemToAnsi(STR0024),oReport:Row(),055) // Legenda Status
		oReport:SkipLine(1)	
		oReport:FatLine()

		dbSelectArea("QMP")
		dbSetOrder(1)
		dbGoTop()
		While QMP->(!Eof())
			oReport:SkipLine(1) 
			oReport:PrintText(UPPER(QMP->QMP_STATUS)+" - "+Alltrim(QMP->QMP_DESCR),oReport:Row(),025) // Legenda Status
			dbSkip()
		Enddo
	Endif
Endif

oSection1:Finish()
(cAliasQry)->(DbCloseArea())
RestArea(aArea)

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR300R3³ Autor ³ Denis Martins         ³ Data ³ 25.09.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao de instrumentos                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR300(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis     ³      ³ Criacao do relatorio                                ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR300R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1	:= STR0001
Local cDesc2	:= STR0002
Local cDesc3	:= ""
Local wnrel		:= ""
Local cString	:="QM2"

Private titulo	:= OemToAnsi(STR0005)
Private cabec1	:= ""
Private cabec2	:= ""
Private aReturn	:= { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 1, 2, 1, "",1 } //"Zebrado"###"Administra‡„o"
Private nomeprog:="QMTR300"
Private cPerg	:="QMR300"
Private cTamanho:= "G"
Private aOrd := {OemToAnsi(STR0012),OemToAnsi(STR0013),OemToAnsi(STR0011)} // "Departamento" # "Instrumento" # "Departamento/Instrumento"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR300",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                  ³
//³ mv_par01   : Instrumento Inicial                      ³
//³ mv_par02   : Instrumento Final                        ³
//³ mv_par03   : Periodo Inicial                          ³
//³ mv_par04   : Periodo Final                            ³
//³ mv_par05   : Departamento Inicial                     ³
//³ mv_par06   : Departamento Final                       ³
//³ mv_par07   : Orgao Calibrador Todos/Interno/Externo   ³
//³ mv_par08   : Orgao Calibrador interno de              ³
//³ mv_par09   : Orgao Calibrador interno ate             ³
//³ mv_par10   : Orgao Calibrador externo de              ³
//³ mv_par11   : Orgao Calibrador externo ate             ³
//³ mv_par12   : Usu rio de                               ³
//³ mv_par13   : Usu rio ate                              ³
//³ mv_par14   : Status de                                ³
//³ mv_par15   : Status ate                               ³
//³ mv_par16   : Quebra Depto / Pagina                    ³
//³ mv_par17   : Imprime Legenda do Status                ³
//³ mv_par18   : Imprime Nao Habilitado                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR300"   //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,cTamanho,{},.F.)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| MTR300Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MTR300Imp³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Sugestao de Bloqueio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MTR300Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - Acao do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR300                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTR300Imp(lEnd,wnRel,cString)

Local CbCont
Local CbTxt
Local nOrdem		:= IndexOrd()
Local cAlias		:= Alias()
Local cInstr		:= ""
Local nCntParc		:= 0    // Contador para subtotal
Local nCntTot		:= 0    // Contador para total
Local cChave		:= ""   // Auxiliar para quebra de subtotal
Local nIndex		:= 0
Local cKey			:= ""
Local nTm			:= 1
Local cLbLeit		:= TitSx3("QM2_LEIT")[1]
Local cLbCust		:= TitSx3("QM2_CUSTO")[1]//SubStr(TitSx3("QM2_CUSTO")[1],1,5)
Local cLbInstr		:= TitSx3("QM2_INSTR")[1]
Local cLbTipo		:= TitSx3("QM2_TIPO")[1]
Local cLbLocal		:= TitSx3("QM2_LOCAL")[1]
Local cLbFre		:= TitSx3("QM2_FREQAF")[1]
Local cLbFabr		:= TitSx3("QM2_FABR")[1]
Local cLbStatus		:= SubStr(TitSx3("QM2_STATUS")[1],1,2)+"."
Local cLbDQM1		:= TitSx3("QM1_DESCR")[1]
Local cLbRevs	    := "Rv"
Local nLin			:= 0
Local nxCont        := 0
Private li			:= 60
Private cIndex      := ""
Private lAbortPrint := .F.
Private TRB_FILIAL	
Private TRB_INSTR	
Private TRB_REVINS	
Private TRB_REVINV	
Private TRB_DEPTO	
Private TRB_TIPO	
Private TRB_VALDAF	
Private TRB_FREQAF	
Private TRB_RESP	
Private TRB_FABR	
Private TRB_STATUS	
Private TRB_LAUDO
Private TRB_TDESCR
Private TRB_CUSTO
Private TRB_DATCO
Private TRB_SGUARD
Private TRB_QM2CTS
Private TRB_LEIT
Private TRB_DESQM1
Private TRB_DESPTO
Private aInstru := {}
Private lImpSub := .F.
Private axTextos :={}
nCntTot := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi(STR0005)

//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//Instrumento       Fabrincante       Freq Orgao Calibrador Procedimento       Data        Data        SG   CUSTO            Localizacao      Leitura          Familia           Descricao                      STATUS
//                                    Dias                                     Ult.Calib.  Prox.Calib.
//XXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXX  9999 XXXXXXX          XXXXXXXXXXXXXXXX   XX/XX/XXXX  XX/XX/XXXX  XXX  XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX X

cabec1 :=Alltrim(cLbInstr)+Space(7)+Alltrim(cLbFabr)+Space(8)+SubStr(cLbFre,1,4)+Space(1)+Alltrim(STR0022)+Space(1)+Alltrim(STR0023)+Space(7)+Alltrim(STR0019)+Space(8)+Alltrim(STR0019)+Space(8)+"SG"+Space(3)+Alltrim(cLbCust)+Space(17-Len(Alltrim(cLbCust)))+Alltrim(cLbLocal)+Space(6)+Alltrim(cLbLeit)+Space(18-Len(Alltrim(cLbLeit)))+Alltrim(cLbTipo)+Space(11)+Alltrim(cLbDQM1)+Space(26)+Alltrim(cLbStatus)+" "+Alltrim(cLbRevs)
cabec2 :=Space(36)+	Alltrim(STR0018)+Space(37)+Alltrim(STR0020)+Space(2)+Alltrim(STR0021)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := Space(10)
cbcont   := 0
li       := 80
m_pag    := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a Ordem (informada na SetPrint)  ser utilizada      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QM2")
dbSetOrder(01)            

cKey := "QM2_FILIAL+QM2_INSTR+QM2_REVINV" 
cQuery := "SELECT QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_REVINV,QM2_VALDAF,QM2_FREQAF,"
cQuery += "QM2_DEPTO,QM2_RESP,QM2_TIPO,QM2_FABR,QM2_STATUS,QM2_LAUDO,QM2_LOCAL,QM2_FLAG,"
cQuery += "QM2_CUSTO,QM2_SGUARD,QM2_LEIT,QM1_TIPO,QM1_PROCAL,QM1_DESCR "
cQuery += "FROM "+RetSqlName("QM2")+" QM2, "					
cQuery += RetSqlName("QM1")+" QM1 "					
cQuery += "WHERE "
cQuery += "QM2.QM2_FILIAL = '"			+xFilial("QM2")+	"' AND "
cQuery += "QM2.QM2_INSTR  BetWeen '"	+ mv_par01 +		"' AND '" + mv_par02 +			"' AND " 
cQuery += "QM2.QM2_VALDAF  BetWeen '"	+ DtoS(mv_par03) +		"' AND '" + DtoS(mv_par04) +			"' AND " 
cQuery += "QM2.QM2_DEPTO BetWeen '"		+ mv_par05 +		"' AND '" + mv_par06 + 			"' AND " 
cQuery += "QM2.QM2_RESP BetWeen '"		+ mv_par12 +		"' AND '" + mv_par13 + 			"' AND " 
cQuery += "QM2.QM2_TIPO  = QM1.QM1_TIPO AND " 
cQuery += "QM2.D_E_L_E_T_= ' ' "+ " AND " +"QM1.D_E_L_E_T_= ' ' "
cQuery += "ORDER BY " + SqlOrder(cKey)

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QM2_VALDAF","D",8,0)
dbSelectArea( "TRB" )                 
While !Eof()
	If TRB->QM2_FILIAL+TRB->QM2_INSTR <> cInstr
			Aadd(aInstru,{TRB->QM2_FILIAL,TRB->QM2_INSTR,TRB->QM2_REVINS,;
				TRB->QM2_VALDAF,TRB->QM2_FREQAF,TRB->QM2_DEPTO,TRB->QM2_RESP,;
				TRB->QM2_TIPO,TRB->QM2_FABR,TRB->QM2_STATUS,;
				TRB->QM2_LOCAL,TRB->QM2_SGUARD,TRB->QM2_CUSTO,TRB->QM2_LEIT,TRB->QM1_PROCAL,;
				TRB->QM1_DESCR})
	Endif	
	cInstr := TRB->QM2_FILIAL+TRB->QM2_INSTR
	dbSkip()
Enddo
		
If aReturn[8] == 1 //Ordena por Depto
	aSort(aInstru,,,{|x,y| x[6] < y[6]}) //Sorte por Depto 		
ElseIf aReturn[8] == 2 //Instrumento
	aSort(aInstru,,,{|x,y| x[1]+x[2] < y[1]+y[2]}) //Sorte por Instrumento 		
ElseIf aReturn[8] == 3 //Instrumento/Depto
	aSort(aInstru,,,{|x,y| x[6]+x[1]+x[2] < y[6]+y[1]+y[2]}) //Sorte por Instrumento+Depto 		
Endif
SetRegua(Len(aInstru))                  

If Len(aInstru) > 0
	cChave := aInstru[1][6]
Endif	

While nTm <= Len(aInstru) 
/*
2	TRB->QM2_INSTR
3	TRB->QM2_REVINS
4	TRB->QM2_VALDAF
5	TRB->QM2_FREQAF
6	TRB->QM2_DEPTO
7	TRB->QM2_RESP
8	TRB->QM2_TIPO
9	TRB->QM2_STATUS
10	TRB->QM2_LAUDO
11	TRB->QM2_LOCAL
12	TRB->QM2_SGUARD
13	TRB->QM2_QM2CTS
14	TRB->QM2_LEIT
15	TRB->QM1_PROCAL
*/
	TRB_INSTR	:= aInstru[nTm][2]
	TRB_REVINS	:= aInstru[nTm][3]
	TRB_VALDAF	:= aInstru[nTm][4]
	TRB_FREQAF	:= aInstru[nTm][5]
	TRB_DEPTO	:= aInstru[nTm][6]
	TRB_RESP	:= aInstru[nTm][7]
	TRB_TIPO	:= aInstru[nTm][8]
	TRB_FABR	:= aInstru[nTm][9]
	TRB_STATUS	:= aInstru[nTm][10]
	TRB_LOCAL	:= aInstru[nTm][11]
	TRB_SGUARD	:= aInstru[nTm][12]
	TRB_QM2CTS  := aInstru[nTm][13]
	TRB_LEIT 	:= aInstru[nTm][14]
	TRB_TDESCR	:= aInstru[nTm][15]
	TRB_DESQM1 	:= aInstru[nTm][16]
		
	IncRegua()
	
	If lAbortPrint
		li := li + 1
		@li,001 PSAY OemToAnsi(STR0006)  //"CANCELADO PELO OPERADOR"
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno e externo                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1
		If ! Calibrador(0,mv_par08,mv_par09,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			nTm++
			dbSkip()
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 2
		If ! Calibrador(1,mv_par08,mv_par09,,,TRB_INSTR,TRB_REVINS)
			nTm++
			dbSkip()
			Loop
		Endif
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. externo                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 3
		If ! Calibrador(2,,,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			nTm++
			dbSkip()
			Loop
		EndIf
	EndIf

	If mv_par18 == 1 //Imprime Não Habilitado
		If TRB_STATUS < mv_par14 .or. TRB_STATUS > mv_par15
			nTm++
			dbSkip()
			Loop	
		Endif
	Else
		If !QMTXSTAT(TRB_STATUS)
			nTm++
			dbSkip()
			Loop
		Endif
	Endif	
	If TRB_TIPO < mv_par19 .or. TRB_TIPO > mv_par20
		nTm++
		dbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura o departamento no QAD - Centro de Custo.             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	dbSelectArea("QAD")
	dbSetOrder(1)
	If dbSeek( xFilial("QAD") + TRB_DEPTO )
	    TRB_CUSTO := QAD->QAD_CUSTO
		TRB_DESPTO := Alltrim(QAD->QAD_DESC)
	Else
	    TRB_CUSTO := ""
		TRB_DESPTO := ""
	Endif    

	dbSelectArea("TRB")

	MTR300Sub(@cChave,@nCntParc)
	
	If li > 50
		Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		li++
		@li,000 PSAY OemToAnsi(STR0014)+TRB_DEPTO+" - "+TRB_DESPTO
		@li,000 PSAY OemToAnsi(STR0014)+QAD->QAD_CUSTO+" - "+ALLTRIM(QAD->QAD_DESC) 
		li := li + 2 
	EndIf

//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//Instrumento       Fabricante        Freq Orgao Calibrador Procedimento       Data        Data        SG   CUSTO            Localizacao      Leitura          Tipo       		 Descricao                            Status 
//                                    Dias                                     Ult.Calib.  Prox.Calib.
//XXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXX  9999 XXXXXXX          XXXXXXXXXXXXXXXX   XX/XX/XXXX  XX/XX/XXXX  XXX  XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX       X 


	@ li,000 PSAY TRB_INSTR
	@ li,018 PSAY TRB_FABR
	@ li,036 PSAY TRB_FREQAF

	cTpCal := ""
	nLin   := 0
	dbSelectArea("QMK")
	dbSetOrder(1)
	If dbSeek(xFilial()+TRB_TIPO)
		dbSelectArea("QMR")
		dbSetOrder(1)
		If dbSeek(xFilial()+TRB_INSTR+TRB_REVINS)
			While !Eof() .And. xFilial()+TRB_INSTR+TRB_REVINS == QMR->(QMR_FILIAL+QMR_INSTR+QMR_REVINS)
				dbSelectArea("QM9")
				dbSetOrder(1)
				If dbSeek(xFilial()+QMR->QMR_ESCALA)
					If QM9->QM9_ORGAFE == "I"
						cTpCal += IIf(nLin == 0,STR0015,"/"+STR0015)	//Interno 
					Else
						cTpCal += IIf(nLin == 0,STR0016,"/"+STR0016)	//Externo
					Endif
					axTextos := JustificaTXT(cTpCal,16,.F.,.T.)  
				Endif
				nLin++
				dbSelectArea("QMR")
				dbSkip()
			Enddo
		Endif
	Endif	

 
	cValDaf := Dtoc(TRB_VALDAF)
	@ li,058 PSAY TRB_TDESCR

    //Nao considera revisao do instrumento, ou seja, uma vez calibrado o codigo do instrumento
    //essa coluna sera impressa
    dbSelectArea("QM6")
	dbSetOrder(4)
	If dbSeek(xFilial()+TRB_INSTR)
		@ li,77 PSAY DtoC(QM6->QM6_DATA)
	Else              
		@ li,77 PSAY STR0017 //"S/Calibra"
	Endif     
		
	//Data da Proxima Calibracao
	@ li,89 PSAY DtoC(TRB_VALDAF)

	If !Empty(TRB_SGUARD)
		@ li,101 PSAY SubStr(TRB_SGUARD,1,3)	
	Endif	

    @ li,106 PSAY SubStr(TRB_QM2CTS,1,TamSx3("QM2_CUSTO")[1])
    @ li,123 PSAY SubStr(TRB_LOCAL,1,TamSx3("QM2_LOCAL")[1])
    @ li,140 PSAY SubStr(TRB_LEIT,1,TamSx3("QM2_LEIT")[1])	

    @ li,158 PSAY SubStr(TRB_TIPO,1,TamSx3("QM1_TIPO")[1])
    @ li,175 PSAY SubStr(TRB_DESQM1,1,TamSx3("QM1_DESCR")[1])	
    @ li,213 PSAY SubStr(TRB_STATUS,1,TamSx3("QM2_STATUS")[1])
    @ li,215 PSAY Alltrim(TRB_REVINS)
    For nxCont := 1 To Len(axTextos)
		@ li,041 PSAY axTextos[nxCont]
		@ li++
    Next  
    
	nCntParc++
	nCntTot++
	nTm++
	li++
EndDo

If Len(aInstru) > 0 .And. nCntTot > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica a se deve dar subtotal                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If nCntParc > 0
		li++
		If li > 50
			Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
			li++
			@li,000 PSAY OemToAnsi(STR0014)+TRB_DEPTO+" - "+TRB_DESPTO
			li := li + 2 
		EndIf
		@ li,010 PSAY OemToAnsi(STR0007)+Str(nCntParc,5) //"SubTotal................:"    	
    Endif
	
	li:= li+2

	If li > 50
		Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		li++
		@li,000 PSAY OemToAnsi(STR0014)+TRB_DEPTO+" - "+TRB_DESPTO
		li := li + 2 
	EndIf
	@ li,010 PSAY OemToAnsi(STR0008)+Str(nCntTot,5) //Total........................:
    li := li + 2
	If mv_par17 == 1 //Imprime Legenda
		li++
		If li > 50
			Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
			li++
		EndIf
		@ li,000 PSAY __PrtFatLine()
		li++
		If li > 50
			Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
			li++
		EndIf
		@ li,(220 - Len(STR0024))/2 PSAY OemToAnsi(STR0024) // Legenda Status
		li++
		If li > 50
			Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
			li++
		EndIf

		@ li,000 PSAY __PrtFatLine()

		dbSelectArea("QMP")
		dbSetOrder(1)
		dbGoTop()
		While QMP->(!Eof())
			li++
			If li > 50
				Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
				li++
			EndIf
			@ li,000 PSAY UPPER(QMP->QMP_STATUS)+" - "+Alltrim(QMP->QMP_DESCR)
			dbSkip()
		Enddo
	Endif

Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se a linha for 80, ‚ porque nao foi impresso nem a 1§ pag    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If li != 80
	 Roda( cbCont, cbTxt, cTamanho )
EndIf

Set Device To Screen

dbSelectArea("TRB")
dbCloseArea()
dbSelectArea("QM2")
dbSetOrder(1)		

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
EndIf
MS_FLUSH()

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MTR300SUB³ Autor ³ Denis Martins         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime subtotal                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MTR300SUB()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³cExp1: Chave a ser considerada - instrumento                ³±±
±±³          ³cExp2: Subtotal                                             ³±±
±±³          ³cExp3: Total                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTR300Sub(cChave,nCntParc)

If TRB_DEPTO <> cChave //Quebra por departamento                          
	li := li + 2
	If li > 50
		Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		QAD->(dbSeek( xFilial("QAD") + cChave ))
		@li,000 PSAY OemToAnsi(STR0014)+QAD->QAD_CUSTO+" - "+ALLTRIM(QAD->QAD_DESC) 
		li := li + 2 
	Endif	
	@ li,010 PSAY OemToAnsi(STR0007)+Str(nCntParc,5)	//Subtotal
	li := li + 2
	nCntParc := 0

	If mv_par16 == 1 .Or. Li > 50
		Cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		Li++ 
	Endif	
	@li,000 PSAY OemToAnsi(STR0014)+TRB_DEPTO+" - "+TRB_DESPTO
	li := li + 2 

	cChave := TRB_DEPTO
	
Endif

Return(Nil)
  
