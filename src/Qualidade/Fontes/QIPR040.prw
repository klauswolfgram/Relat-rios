/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIPR040.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOTVS.CH"

Static lQLTDispSVR := Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QIPR040	³ Autor ³ Marcelo Pimentel      ³ Data ³ 21.06.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Produtos - Uso        			       		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_QIPR040()												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Siga Quality - Celerina                            		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³ 			                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                          
User Function QIPR040(cProg,cOrdProd,cLote,cNumSer)

	Local oReport     := Nil

	PRIVATE cPerg     := "QPR040"
	PRIVATE cTmpAlias := "TRB"

	lQLTDispSVR   := Iif(lQLTDispSVR == Nil, FindFunction("QLTDispSVR"), lQLTDispSVR)

	Pergunte(cPerg,.F.)  
	If cProg == "MATA650"
		mv_par01 := cOrdProd
		mv_par02 := cLote   
		mv_par03 := cNumSer  
		mv_par04 := cOrdProd
		mv_par05 := cLote    
		mv_par06 := cNumSer 
		mv_par07 := '  '
		mv_par08 := 'ZZ'
		mv_par09 := 2
		mv_par10 := Space(6)
		mv_par11 := Space(2)
		mv_par12 := Space(6)
		mv_par13 := "ZZZZZZ"
		mv_par14 := 1
	Endif

	If !lQLTDispSVR .OR. !QLTDispSVR("manufacturing.sv.qip.inspectionplan",,,,QLTTReportsManager():mountDefaultParams(cPerg, .F.))
		oReport := ReportDef(cProg,cOrdProd,cLote,cNumSer)
		oReport:PrintDialog() 
	EndIf


Return   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ReportDef  ºAutor  ³Cleber Souza        º Data ³  07/17/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicoes do relatorio de Formulas R4.		              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIPR150                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef(cProg,cOrdProd,cLote,cNumSer)

Local cPrograma  :='QIPR040'
LOCAL cDesc1	 :=OemToAnsi(STR0001) //"Neste relat¢rio ser„o relacionados os ensaios a serem realizados em ca-"
LOCAL cDesc2	 :=OemToAnsi(STR0002) //"da laborat¢rio, para a valida‡„o da producao."
Local cTitulo	 := STR0003	//"PRODUTO"

cLote   := If(cLote==NIL .Or. Len(cLote)==0,CriaVar("QPK_LOTE"),cLote) 
cNumSer := If(cNumSer==NIL .Or.Len(cNumSer)==0,CriaVar("QPK_NUMSER"),cNumSer)

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintRepor(oReport,cProg,cOrdProd,cLote,cNumSer)} DESCRIPTION (cDesc1+cDesc2)

DEFINE SECTION oSection1 OF oReport TITLE TitSx3("QPK_OP")[1] TABLES "QPK","QP6" LINE STYLE 
DEFINE CELL NAME "QPK_OP"     	OF oSection1 	SIZE TamSx3("QPK_OP")[1]+TamSx3("QPK_LOTE")[1]+TamSx3("QPK_NUMSER")[1]+4  TITLE  AllTrim(TitSx3("QPK_OP")[1])+"............................." CELL BREAK 
DEFINE CELL NAME "QPK_TAMLOT" 	OF oSection1 	SIZE TamSx3("QPK_TAMLOT")[1]+1	TITLE  TitSx3("QPK_TAMLOT")[1]+"............................." CELL BREAK 
DEFINE CELL NAME "AMOSTRA"    	OF oSection1 	SIZE TamSx3("QPK_LOTE")[1]    	TITLE  STR0036+"..............................." CELL BREAK 	//'Tam.Amostr'
DEFINE CELL NAME "QP6_PRODUT" 	OF oSection1 	SIZE 30 					  	TITLE  AllTrim(TitSx3("QP6_PRODUT")[1])+".................................." CELL BREAK 
DEFINE CELL NAME "QP6_DESCPO" 	OF oSection1 	SIZE 50 					  	TITLE  AllTrim(TitSx3("QP6_DESCPO")[1])+"................................" CELL BREAK 
DEFINE CELL NAME "CLIENTE"    	OF oSection1 	SIZE TamSx3("A1_NOME")[1]     	TITLE  AllTrim(TitSx3("A1_NOME")[1])+"................................" 	CELL BREAK 
DEFINE CELL NAME "DATAS"      	OF oSection1 	SIZE TamSx3("QP6_DTCAD")[1]+TamSx3("QP6_DTDES")[1]+TamSx3("QP6_RVDES")[1] TITLE  AllTrim(TitSx3("QP6_DTCAD")[1])+"/"+AllTrim(TitSx3("QP6_DTDES")[1])+"/"+AllTrim(TitSx3("QP6_RVDES")[1])+"..." CELL BREAK 
DEFINE CELL NAME "QP6_DTINI"  	OF oSection1 	SIZE 10						 	TITLE  AllTrim(TitSx3("QP6_DTINI")[1])+"............................." CELL BREAK 
DEFINE CELL NAME "QP6_DOCOBR" 	OF oSection1 	SIZE 5						 	TITLE  AllTrim(TitSx3("QP6_DOCOBR")[1])+"............................." CELL BREAK 
DEFINE CELL NAME "QP6_HISTOR" 	OF oSection1 	SIZE 100                     	TITLE  AllTrim(TitSx3("QP6_HISTOR")[1]) LINE BREAK 
              
DEFINE SECTION oSection2 OF oReport TITLE OemToAnsi(STR0048) LINE STYLE
DEFINE CELL NAME "CODREC"  		OF oSection2 	SIZE 100	TITLE  STR0048+"......"		CELL BREAK   //"ROTEIRO"

DEFINE SECTION oSection3 OF oReport TITLE TitSx3("QP7_OPERAC")[1] LINE STYLE
DEFINE CELL NAME "QP7_OPERAC"  	OF oSection3 	SIZE 100	TITLE  STR0049+"....."		CELL BREAK  //"OPERACAO"

DEFINE SECTION oSection4 OF oReport TABLES "QP7" TITLE TitSx3("QP7_LABOR")[1]
DEFINE CELL NAME "QP7_ENSAIO"  	OF oSection4 	SIZE 50   						TITLE  AllTrim(TitSx3("QP7_ENSAIO")[1]) 
DEFINE CELL NAME "QP7_LABOR"   	OF oSection4 	SIZE TamSx3("QP7_LABOR")[1]    	TITLE  STR0013                              AUTO SIZE	//"Labor."	
DEFINE CELL NAME "QP7_METODO"  	OF oSection4 	SIZE TamSx3("QP7_METODO")[1]   	TITLE  AllTrim(TitSx3("QP7_METODO")[1])    AUTO SIZE
DEFINE CELL NAME "QP7_UNIMED"  	OF oSection4 	SIZE TamSx3("QP7_UNIMED")[1]   	TITLE  STR0014	                  	        AUTO SIZE 	//"Un. Med."
DEFINE CELL NAME "QP8_TEXTO"   	OF oSection4 	SIZE 45    						TITLE  AllTrim(TitSx3("QP8_TEXTO")[1]) 		LINE BREAK	
DEFINE CELL NAME "QP7_NOMINA"  	OF oSection4 	SIZE TamSx3("QP7_NOMINA")[1]   	TITLE  STR0015	                  	        AUTO SIZE	//"Nominal"	
DEFINE CELL NAME "QP7_LIE"     	OF oSection4 	SIZE TamSx3("QP7_LIE")[1]  	   	TITLE  STR0016	                  	        AUTO SIZE	//"L.I.E."	
DEFINE CELL NAME "QP7_LSE"     	OF oSection4 	SIZE TamSx3("QP7_LSE")[1]      	TITLE  STR0017	                  	        AUTO SIZE	//"L.S.E."	
DEFINE CELL NAME "QP7_PLAMO"   	OF oSection4 	SIZE TamSx3("QP7_PLAMO")[1]    	TITLE  STR0018	                  	        AUTO SIZE//"Pl "	
DEFINE CELL NAME "QP7_NIVEL"   	OF oSection4 	SIZE TamSx3("QP7_NIVEL")[1]    	TITLE  AllTrim(TitSx3("QP7_NIVEL")[1])	    AUTO SIZE
DEFINE CELL NAME "QQ1_INSTR"   	OF oSection4 	SIZE TamSx3("QQ1_INSTR")[1]    	TITLE  AllTrim(TitSx3("QQ1_INSTR")[1])  
DEFINE CELL NAME "ST"          	OF oSection4 	SIZE 5						   	TITLE  STR0050	                  	        //"ST"	
		
DEFINE SECTION oSection5 OF oReport TITLE TitSx3("QP7_ENSAIO")[1] TABLES "QA7" 
DEFINE CELL NAME "ENSAIO"     	OF oSection5 	SIZE TamSx3("QP7_ENSAIO")[1]   	TITLE  AllTrim(TitSx3("QP7_ENSAIO")[1]) 
DEFINE CELL NAME "ACEITE"     	OF oSection5 	SIZE TamSx3("QA7_NO_ACE")[1]   	TITLE  STR0051 //"Aceite"
DEFINE CELL NAME "REJEITE"    	OF oSection5 	SIZE TamSx3("QA7_NO_REJ")[1]   	TITLE  STR0052 // "Rejeite" 
DEFINE CELL NAME "AMOSTRA"   	OF oSection5 	SIZE TamSx3("QA7_NO_AMO")[1]   	TITLE  STR0053 //"Tam. Amostra"
DEFINE CELL NAME "PLANO"      	OF oSection5 	SIZE 100						TITLE  STR0032	//'Plano de Amostragem'

DEFINE SECTION oSection6 OF oReport TITLE STR0054 LINE STYLE //"Lote"
DEFINE CELL NAME "OBSERVACAO"  	OF oSection6 	SIZE 100   						TITLE  "" LINE BREAK	//"Observacoes :"

Return oReport 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReporºAutor  ³Cleber Souza		 º Data ³  31/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao relatorio R4.                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER280                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintRepor(oReport,cProg,cOrdProd,cLote,cNumSer)   
Local aAreaQPK   := GetArea()
Local aEnsaios   := {}
Local aImpPl     := {}
Local aTexObs    := ""
Local cALTESP    := ""
Local cCarta     := ""
Local cChave     := ""
Local cDescEns   := Space(30)
Local cFatCon    := ''
Local cGrupo     := ''
Local cMemo      := ''
Local cOp        := ''
Local cOperac    := ''
Local cOperacao  := ""
Local cOpImp     := ""
Local cProduto   := ''
Local cRevi      := ""
Local cRoteiro   := ''
Local cSkTes     := ''
Local cTamAmo    := ''
Local cTexObs    := ""
Local cTipCon    := ''
Local cTipoEns   := ''
Local cUnimed    := ''
Local lFezEnsaio := .T.
Local lFirst     := .T.
Local nC         := 0
Local nCert      := 0
Local nCont      := 0
Local nCount     := 0
Local nY         := 0
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(2)
Local oSection3  := oReport:Section(3)
Local oSection4  := oReport:Section(4)
Local oSection5  := oReport:Section(5)
Local oSection6  := oReport:Section(6)
Local oTempTable := NIL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					  	 ³
//³ mv_par01			  // Da Ordem de Produ‡Æo     ?    		 ³
//³ mv_par02			  // Do Lote   			   	  ?    		 ³
//³ mv_par03			  // Do Numero de Serie	      ?    		 ³
//³ mv_par04			  // Ate' Ordem de Produ‡Æo   ?       	 ³
//³ mv_par05			  // Ate Lote  			      ?    		 ³
//³ mv_par06			  // Ate Numero de Serie      ?    		 ³
//³ mv_par07			  // Da Operacao      		  ?		 	 ³
//³ mv_par08			  // Ate Operacao      		  ?	  	 	 ³
//³ mv_par09			  // Apenas a Ult. Operacao   ? 		 ³
//³ mv_par10			  // Cliente 	? 		                 ³
//³ mv_par11			  // Loja 	? 		                     ³  
//³ mv_par12			  // Laboratorio De                      ³  
//³ mv_par13			  // Laboratorio Ate                     ³  
//³ mv_par14			  // Imprime textos justificados ?       ³  
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLote   := If(cLote==NIL .Or. Len(cLote)==0,CriaVar("QPK_LOTE"),cLote) 
cNumSer := If(cNumSer==NIL .Or.Len(cNumSer)==0,CriaVar("QPK_NUMSER"),cNumSer)

Pergunte(cPerg,.F.)

If cProg == "MATA650"
	mv_par01 := cOrdProd
	mv_par02 := cLote   
	mv_par03 := cNumSer  
	mv_par04 := cOrdProd
	mv_par05 := cLote    
	mv_par06 := cNumSer 
	mv_par07 := '  '
	mv_par08 := 'ZZ'
	mv_par09 := 2
	mv_par10 := Space(6)
	mv_par11 := Space(2)
	mv_par12 := Space(6)
	mv_par13 := "ZZZZZZ"
	mv_par14 := 1
Endif         

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Funcao para gerar arquivo de Trabalho		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R040GTrab(@oTempTable)
dbSelectArea(cTmpAlias)
dbSetOrder( 2 )
If BOF() .and. EOF()
	HELP(" ",1,"RECNO")
	oTempTable:Delete()
	dbSelectArea("QPK")
	dbSetOrder( 1 )
	Return .T.
Endif

&(cTmpAlias)->(dbGoTop())
oReport:SetMeter(RecCount())
While !&(cTmpAlias)->(EOF())

	If oReport:Cancel()
		Exit
	EndIf

	oReport:IncMeter()	
	TRPosition():New(oReport:Section(1),"QPK",1,{|| xFilial("QPK")+(cTmpAlias)->(OP+LOTE)})
	TRPosition():New(oReport:Section(1),"QP6",2,{|| xFilial("QP6")+(cTmpAlias)->(PRODUT+REVI+ROTEIRO)})
	TRPosition():New(oReport:Section(4),"QP7",1,{|| xFilial("QP7")+(cTmpAlias)->(PRODUT+REVI+ROTEIRO+OPERAC+ENSAIO)})
	TRPosition():New(oReport:Section(4),"QP8",1,{|| xFilial("QP8")+(cTmpAlias)->(PRODUT+REVI+ROTEIRO+OPERAC+ENSAIO)})

	//Posiciona no grupo de produtos
	cGrupo := Posicione("QPA",2,xFilial("QPA")+&(cTmpAlias+"->PRODUT"),"QPA_GRUPO")
	
	nRecQQK     := &(cTmpAlias)->(Recno())
	cProduto	:= &(cTmpAlias+"->PRODUT")
	cRevi 		:= &(cTmpAlias+"->REVI")
	cOp	        := &(cTmpAlias+"->OP")	 
	cOperacao   := &(cTmpAlias+"->OPERAC") 
			
	If	mv_par09 == 1	 //Imprime somente a ultima operacao 
		While !&(cTmpAlias)->(EOF()) .And. ;
			&(cTmpAlias+"->PRODUT")+&(cTmpAlias+"->REVI")+&(cTmpAlias+"->OP") == cProduto+cRevi+cOp
			If &(cTmpAlias+"->OP")+&(cTmpAlias+"->OPERAC") != cOp+cOperacao
				nRecQQK := &(cTmpAlias)->(Recno())
				cOperacao   := &(cTmpAlias+"->OPERAC")
			EndIf
			&(cTmpAlias)->(DbSkip())
			Loop
		EndDo  
		&(cTmpAlias)->(dbGoTop())    // Solucao usando DBGoto nao funcionou nesta lib caso retorne testar este ponto
		While !&(cTmpAlias)->(EOF()) 
			If nRecQQK == &(cTmpAlias)->(Recno())
				Exit
    		Else
				&(cTmpAlias)->(DbSkip())
				Loop
			EndIf
		EndDo		
	EndIf
	
	If &(cTmpAlias+"->OPERAC")	!= cOperac
		cOperac := &(cTmpAlias+"->OPERAC")
	EndIf                                 
	
	If lFirst .Or. cOp != &(cTmpAlias+"->OP")+&(cTmpAlias+"->LOTE")+&(cTmpAlias+"->NUMSER")
		cOP := &(cTmpAlias+"->OP")+&(cTmpAlias+"->LOTE")+&(cTmpAlias+"->NUMSER")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define o Fator Conversao, se nao estiver definido             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If &(cTmpAlias+"->UNMED1") == &(cTmpAlias+"->C2UNIMED")
			cFatCon := &(cTmpAlias+"->FATCO1")
			cTipCon := &(cTmpAlias+"->TIPCO1")
		ElseIf &(cTmpAlias+"->UNMED2") == &(cTmpAlias+"->C2UNIMED")
			cFatCon := &(cTmpAlias+"->FATCO2")
			cTipCon := &(cTmpAlias+"->TIPCO2")
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o Tamanho da Amostra                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If Superval(cFatCon) <> 0
			cFatCon := StrTran(cFatcon,",",".")
			If cTipCon == "D"
				cTamAmo := Str(&(cTmpAlias+"->QUANT") / Superval(cFatCon))
			Else
				cTamAmo := Str(&(cTmpAlias+"->QUANT") * Superval(cFatCon))
			EndIf                 
		Else
			cTamAmo := Str(&(cTmpAlias+"->QUANT"))
		EndIf
		
		oSection1:Init()
		cOpImp:= &(cTmpAlias+"->OP")
		If !Empty(&(cTmpAlias+"->LOTE"))
			cOpImp+= " "+STR0045+" "+&(cTmpAlias+"->LOTE")
		EndIf
		If !Empty(&(cTmpAlias+"->NUMSER"))
			cOpImp+= " "+STR0046+" "+&(cTmpAlias+"->NUMSER")
		EndIF

		oSection1:Cell("QPK_OP"):SetValue(cOpImp)
		oSection1:Cell("QPK_TAMLOT"):SetValue(AllTrim(Str(&(cTmpAlias+"->QUANT"))))
		oSection1:Cell("AMOSTRA"):SetValue(AllTrim(Str(Int(Val(cTamAmo)))))
		oSection1:Cell("QP6_PRODUT"):SetValue(Alltrim(&(cTmpAlias+"->PRODUT")) + " - " + &(cTmpAlias+"->REVI"))
		oSection1:Cell("QP6_DESCPO"):SetValue(&(cTmpAlias+"->DESCPO"))
		If !Empty(mv_par10)
			oSection1:Cell("CLIENTE"):ENABLE()	   		
	   		oSection1:Cell("CLIENTE"):SetValue(mv_par10 + " / " + mv_par11 + " - " + Posicione( "SA1", 1, xFilial("SA1")+mv_par10+mv_par11, "A1_NOME" ))
		Else
			oSection1:Cell("CLIENTE"):DISABLE()	   		
		EndIf

		oSection1:Cell("DATAS"):SetValue(DTOC(&(cTmpAlias+"->DTCAD"))+" "+DTOC(&(cTmpAlias+"->DTDES"))+" "+&(cTmpAlias+"->RVDES"))
		oSection1:Cell("QP6_DTINI"):SetValue(&(cTmpAlias+"->DTINI"))
		oSection1:Cell("QP6_DOCOBR"):SetValue(QP6->QP6_APLIC)
		If !Empty(&(cTmpAlias+"->DOCOBR"))
			If QP6->QP6_DOCOBR=="S"
				oSection1:Cell("QP6_DOCOBR"):SetValue(OemToAnsi(STR0009))  //"Sim"
			Else	
				oSection1:Cell("QP6_DOCOBR"):SetValue(OemToAnsi(STR0010))  //"Nao"
			EndIf	
		Else
			oSection1:Cell("QP6_DOCOBR"):SetValue(Space(3)) 
		EndIF

		cMemo	:= MSMM(&(cTmpAlias+"->HISTOR"))
		If Empty(Alltrim(cMemo))
			oSection1:Cell("QP6_HISTOR"):Hide()
		Else
			oSection1:Cell("QP6_HISTOR"):Show()
			oSection1:Cell("QP6_HISTOR"):SetValue(cMemo) 
		Endif
	                      
		oSection1:PrintLine()
		oSection1:Finish()

		oSection2:Init()
		oSection2:Cell("CODREC"):SetValue(&(cTmpAlias+"->ROTEIRO")) 
		oSection2:PrintLine()
		oSection2:Finish()
		
	EndIf

	oSection3:Init()
	oSection3:Cell("QP7_OPERAC"):SetValue(&(cTmpAlias+"->OPERAC") + " - " + &(cTmpAlias+"->DESCRI")) 
	oSection3:PrintLine()
	oSection3:Finish()

	cALTESP	:= &(cTmpAlias+"->ALTESP")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializando Section					   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection4:Init()

	cChave	:=&(cTmpAlias+"->CHAVE")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Dados dos ensaios 						   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aEnsaios := {}
	lFezEnsaio := .F.
	dbSelectArea(cTmpAlias)
	While !&(cTmpAlias)->(EOF()) .And. cOperac == &(cTmpAlias+"->OPERAC") .And. cOp == &(cTmpAlias+"->OP")+&(cTmpAlias+"->LOTE")+&(cTmpAlias+"->NUMSER")
		lFezEnsaio := .T.   
		QP1->(dbSetOrder(1))
		IF QP1->(dbSeek(xFilial("QP1")+&(cTmpAlias+"->ENSAIO")))
			cDescEns := Substr(QP1->QP1_DESCPO,1,30)
			cTipoEns := QP1->QP1_TPCART
		Endif
		
		cProduto	:=&(cTmpAlias+"->PRODUT")
		cRoteiro	:=&(cTmpAlias+"->ROTEIRO")
		cOperac		:=&(cTmpAlias+"->OPERAC")
		cUnimed		:=&(cTmpAlias+"->C2UNIMED")
		
		AADD(aEnsaios,{&(cTmpAlias+"->ENSAIO"),cTipoEns,&(cTmpAlias+"->PLAMO"),&(cTmpAlias+"->DESPLA"),cProduto,&(cTmpAlias+"->REVI"),cRoteiro,cOperac,cTamAmo})

		oSection4:Cell("QP7_ENSAIO"):SetValue(Iif(&(cTmpAlias+"->ENSOBR")=="S","* ","  ") + &(cTmpAlias+"->ENSAIO") + " " + Subs(cDescEns,1,23))
		oSection4:Cell("QP7_LABOR"):SetValue(&(cTmpAlias+"->LABOR"))
		oSection4:Cell("QP7_METODO"):SetValue(&(cTmpAlias+"->METODO"))
		
		If cTipoEns <> "X"
			oSection4:Cell("QP7_UNIMED"):Enable()
			oSection4:Cell("QP7_NOMINA"):Enable()
			oSection4:Cell("QP7_LIE"):Enable()
			oSection4:Cell("QP7_LSE"):Enable()
			SAH->(dbSeek(xFilial("SAH")+&(cTmpAlias+"->UNIMED")))
			oSection4:Cell("QP7_UNIMED"):SetValue(Posicione("SAH",1,xFilial("SAH")+&(cTmpAlias+"->UNIMED"),"AH_UMRES"))
			oSection4:Cell("QP7_NOMINA"):SetValue(AllTrim(&(cTmpAlias+"->NOMINA")))
			If &(cTmpAlias+"->MINMAX") == "1"
				oSection4:Cell("QP7_LIE"):SetValue(AllTrim(&(cTmpAlias+"->LIE")))
				oSection4:Cell("QP7_LSE"):SetValue(AllTrim(&(cTmpAlias+"->LSE")))
			ElseIf &(cTmpAlias+"->MINMAX") == "2"
				oSection4:Cell("QP7_LIE"):SetValue(AllTrim(&(cTmpAlias+"->LIE")))
				oSection4:Cell("QP7_LSE"):SetValue(">>>")
			ElseIf &(cTmpAlias+"->MINMAX") == "3"
				oSection4:Cell("QP7_LIE"):SetValue("<<<")
				oSection4:Cell("QP7_LSE"):SetValue(AllTrim(&(cTmpAlias+"->LSE")))
			EndIf
			oSection4:Cell("QP8_TEXTO"):Disable()
			oSection4:Cell("QP8_TEXTO"):SetValue("")
		Else
			oSection4:Cell("QP7_UNIMED"):Disable()
			oSection4:Cell("QP8_TEXTO"):Enable()
			oSection4:Cell("QP8_TEXTO"):SetValue((cTmpAlias)->TEXTO)
			oSection4:Cell("QP7_NOMINA"):Disable()
			oSection4:Cell("QP7_LIE"):Disable()
			oSection4:Cell("QP7_LSE"):Disable()
		EndIf		
		oSection4:Cell("QP7_PLAMO"):SetValue(&(cTmpAlias+"->PLAMO"))
			
		If !Empty(&(cTmpAlias+"->NIVEL"))
			oSection4:Cell("QP7_NIVEL"):SetValue(Substr(TABELA("Q6",&(cTmpAlias+"->NIVEL")),1,10))
		Else
			oSection4:Cell("QP7_NIVEL"):SetValue(Space(10))
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica o skip-teste										 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		// Verifica se tem skip-teste definido
		cSkTes := "   "
		QPH->(dbSetOrder(1))
		If QPH->(dbSeek(xFilial("QPH")+cProduto+cRoteiro+cOperac+&(cTmpAlias+"->ENSAIO")))
			cSkTes := "CER"
			// Verifica o historico skip-teste individual
			QPY->(dbSetOrder(1))
			If QPY->(dbSeek(xFilial("QPY")+cRoteiro+cOperac+cProduto+Dtos(&(cTmpAlias+"->C2EMISSAO"))+&(cTmpAlias+"->LOTE")+&(cTmpAlias+"->ENSAIO")+cOP))
				While !QPY->(Eof()) .And. QPY->QPY_ENSAIO == &(cTmpAlias+"->ENSAIO")
					If ALLTRIM(QPY->QPY_ORDPRD) == ALLTRIM(padr(cOp,16))
						nCert++
					EndIf
					QPY->(dbSkip())
				Enddo
				If nCert > 0 
					cSkTes := "INS"
				EndIf 
			EndIf
		Else
			cSkTes := "N/A"   // indica que nao foi definido
		EndIf			
		If Empty(cSkTes) .Or. cSkTes == "N/A"
			// Verifica o historico skip-teste por grupo
			QPZ->(dbSetOrder(1))
			If QPZ->(dbSeek(xFilial("QPZ")+cGrupo+Dtos(&(cTmpAlias+"->C2EMISSAO"))+&(cTmpAlias+"->LOTE")+&(cTmpAlias+"->ENSAIO")))
				cSkTes := "INS"
			Else
				// Verifica se tem skip-teste definido
				QPI->(dbSetOrder(1))
				If QPI->(dbSeek(xFilial("QPI")+cGrupo+cRoteiro+cOperac+&(cTmpAlias+"->ENSAIO")))
					cSkTes := "CER"
				Else
					cSkTes := "N/A" //indica que nao foi definido
				EndIf
			EndIf
		EndIf      
		oSection4:Cell("ST"):SetValue(cSkTes)

		dbSelectArea("QQ1")
		QQ1->(dbSetOrder(1))
		If QQ1->(dbSeek(xFilial("QQ1")+&(cTmpAlias+"->PRODUT")+&(cTmpAlias+"->REVI")+&(cTmpAlias+"->OPERAC")+&(cTmpAlias+"->ENSAIO")))
			lPrimVez := .T.
			While  QQ1->(!Eof()) .And. xFilial("QQ1")   == QQ1_FILIAL              .And. ;
				                       QQ1->QQ1_PRODUT	== &(cTmpAlias+"->PRODUT") .And. ;
				                       QQ1->QQ1_REVI	== &(cTmpAlias+"->REVI")   .And. ;
				                       QQ1->QQ1_OPERAC	== &(cTmpAlias+"->OPERAC") .And. ;
				                       QQ1->QQ1_ENSAIO	== &(cTmpAlias+"->ENSAIO")
									
				If lPrimVez
					oSection4:Cell("QQ1_INSTR"):SetValue(QQ1->QQ1_INSTR)
					oSection4:PrintLine()
				Else 
					oSection4:Cell("QP7_ENSAIO"):SetValue(&(cTmpAlias+"->ENSAIO") + " " + cDescEns)
					oSection4:Cell("QP7_LABOR"):SetValue(&(cTmpAlias+"->LABOR"))

					oSection4:Cell("QP7_METODO"):HIDE()
					oSection4:Cell("QP7_UNIMED"):HIDE()
					oSection4:Cell("QP7_NOMINA"):HIDE()
					oSection4:Cell("QP7_LIE"):HIDE()
					oSection4:Cell("QP7_LSE"):HIDE()
					oSection4:Cell("QP8_TEXTO"):HIDE()
					oSection4:Cell("QP7_PLAMO"):HIDE()
					oSection4:Cell("QP7_NIVEL"):HIDE()
					oSection4:Cell("ST"):HIDE()
					oSection4:Cell("QQ1_INSTR"):SetValue(QQ1->QQ1_INSTR)
					oSection4:PrintLine()
				EndIf
				QQ1->(dbSkip())
			EndDo
		Else
			oSection4:Cell("QQ1_INSTR"):SetValue("")
			oSection4:PrintLine()
		EndIf
			
		oSection4:Cell("QP7_METODO"):SHOW()
		oSection4:Cell("QP7_UNIMED"):SHOW()
		oSection4:Cell("QP7_NOMINA"):SHOW()
		oSection4:Cell("QP7_LIE"):SHOW()
		oSection4:Cell("QP7_LSE"):SHOW()
		oSection4:Cell("QP8_TEXTO"):SHOW()
		oSection4:Cell("QP7_PLAMO"):SHOW()
		oSection4:Cell("QP7_NIVEL"):SHOW()
		oSection4:Cell("ST"):SHOW() 
       
		&(cTmpAlias)->(dbSkip())

	Enddo
	
	oSection4:Finish()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ CABECALHO DO PLANO DE AMOSTRAGEM³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aEnsaios) > 0	
		oSection5:Init()
		oSection5:Cell("ENSAIO"):SetValue("")
		oSection5:Cell("ACEITE"):SetValue("")
		oSection5:Cell("REJEITE"):SetValue("")
		oSection5:Cell("AMOSTRA"):SetValue("")
		oSection5:Cell("PLANO"):SetValue("")
		oSection5:PrintLine()	
		For nC := 1 To Len(aEnsaios)     
			cCarta := QPCarta(aEnsaios[nC,1])
			QQH->(dbSetOrder(1))
			If QQH->(dbSeek(xFilial('QQH')+aEnsaios[nC,5]+aEnsaios[nC,6]+aEnsaios[nC,7]+aEnsaios[nC,8]+aEnsaios[nC,1]))
				cAmost  := QQH->QQH_AMOST
				aImpPl  := QEP_RetAmostra(aEnsaios[nC,3],QQH->QQH_AMOST,QQH->QQH_NIVAMO,QQH->QQH_NQA,+Str(Int(Val(aEnsaios[nC,9])),8),"QPK_TAMLOT",.F.)
		
				If aEnsaios[nC,3]=="I"
					For nCount := 1 To Len(aImpPl)
						oSection5:Cell("ENSAIO"):SetValue(aEnsaios[nC,1])
						oSection5:Cell("ACEITE"):SetValue(aImpPl[nCount,1])
						oSection5:Cell("REJEITE"):SetValue(aImpPl[nCount,2])
						oSection5:Cell("AMOSTRA"):SetValue(aImpPl[nCount,3])
						oSection5:Cell("PLANO"):SetValue(aEnsaios[nC,3] +" "+Alltrim(aEnsaios[nC,4])+STR0045+aImpPl[nCount,7])
						oSection5:PrintLine()	
					Next nCount 
				Else                                                                
					oSection5:Cell("ENSAIO"):SetValue(aEnsaios[nC,1])
					oSection5:Cell("ACEITE"):SetValue(aImpPl[2] )
					oSection5:Cell("REJEITE"):SetValue(aImpPl[3])
					oSection5:Cell("AMOSTRA"):SetValue(aImpPl[1])
					oSection5:Cell("PLANO"):SetValue(aEnsaios[nC,3] +" "+Substr(aEnsaios[nC,4],1,90))
					oSection5:PrintLine()
				EndIF	
			EndIF			
		Next
		oSection5:Finish()
	EndIf
	
	oReport:SkipLine()                                  
	
	oReport:SkipLine()
	
	oReport:PrintText(STR0022,oReport:Row(),005)	// "Data        ____ /____ /____"
	oReport:PrintText(STR0023,oReport:Row(),700)	//"Lote        ____________________________"
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:PrintText(STR0024,oReport:Row(),005)	//"Equipamento _________________________"
	oReport:SkipLine()
	oReport:SkipLine()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ IMPRIME MENSAGEM DE NOVAS ESPECIFICACOES 	         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cALTESP == "S"
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:PrintText(STR0044,oReport:Row(),100)  //"*** ORDEM DE PRODUCAO COM NOVAS ESPECIFICACOES ***"
		oReport:SkipLine()
		oReport:SkipLine()
	EndIf        
	

	oReport:PrintText("|---------------------------------------------------------------------------------------------------------------------------------|")
	oReport:SkipLine()
	oReport:PrintText("|                | "+Left(TitSX3("QPT_INSTR")[1],9)+"  |"+STR0025+"|"+STR0026+"|")
	oReport:SkipLine()
	oReport:PrintText("|----------------+------------+-------------------+---------------+---------------+---------------+---------------+---------------|")
	oReport:SkipLine()

	For nCont := 1 to Len(aEnsaios)
		If aEnsaios[nCont,2] <> "X"
			oReport:PrintText( "| " + aEnsaios[nCont,1] + "       |            |                   |               |               |               |               |               |")
			oReport:SkipLine()
			oReport:PrintText("|----------------+------------+-------------------+---------------+---------------+---------------+---------------+---------------|")
			oReport:SkipLine()
		Else
			oReport:PrintText("| " + aEnsaios[nCont,1] + "       |            |                   |                                                                               |")
			oReport:SkipLine()
			oReport:PrintText("|---------------------------------------------------------------------------------------------------------------------------------|")
			oReport:SkipLine()
		Endif
	Next 

	aEnsaios:={}
	oReport:SkipLine()
	oReport:PrintText(STR0027+"_______________________" ,oReport:Row(),005)
	oReport:SkipLine()
	oReport:SkipLine()


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Converte a chave passada como param. p/ chave do texto		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTexObs:= QA_Rectxt(cChave,"QIPA010 ")
	If mv_par14 == 1
		aTexObs := JustificaTXT(cTexObs,130) 
		cTexObs:=""
		For nY:=1 to Len(aTexObs)
			cTexObs+=aTexObs[nY]+CHR(13)+CHR(10)
		Next nY
    Else 
		aTexObs := {}
		Q_MemoArray(cTexObs,aTexObs,130)
		cTexObs:=""
		For nY:=1 to Len(aTexObs)
			cTexObs+=aTexObs[nY]+CHR(13)+CHR(10)
		Next nY
	EndIF
	
	If !Empty(Alltrim(StrTran(cTexObs,CHR(13)+CHR(10),"")))
		oSection6:Init()
		oSection6:Cell("OBSERVACAO"):SetValue(cTexObs)
		oSection6:PrintLine()
		oSection6:Finish()
	EndIf
	
	If	mv_par09 == 1
		&(cTmpAlias)->(DbSkip())
	EndIf

	oSection1:SetPageBreak(.T.)
EndDo

QPZ->(dbSetOrder(1))
QPI->(dbSetOrder(1))
dbSelectArea(cTmpAlias)
oTempTable:Delete()

dbSelectArea("QPK")
dbSetOrder( 1 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura o registro QPK         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aAreaQPK)

Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³R040GTrab	³ Autor ³ Marcelo Pimentel 	  	³ Data ³ 11.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo de Trabalho 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ R040GTrab()												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040GTrab(oTempTable)
Local aCampos := {}
Local aTam    := {}
Local cQuery  := ''
Local nRecQQK := 0

//Cria Arquivo de Trabalho
aTam:=TamSX3("QQK_CODIGO")	;AADD(aCampos,{"ROTEIRO"  ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QQK_OPERAC")	;AADD(aCampos,{"OPERAC"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QQK_CHAVE" ) 	;AADD(aCampos,{"CHAVE"    ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QQK_DESCRI")	;AADD(aCampos,{"DESCRI"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QQK_OPERGR")	;AADD(aCampos,{"OPERGRP"  ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QPK_PRODUT")	;AADD(aCampos,{"PRODUT"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QPK_REVI"  )	;AADD(aCampos,{"REVI"     ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QPK_OP"    )	;AADD(aCampos,{"OP"       ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QPK_LOTE"  )	;AADD(aCampos,{"LOTE"     ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QPK_NUMSER")	;AADD(aCampos,{"NUMSER"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_FATCO1")	;AADD(aCampos,{"FATCO1"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_TIPCO1")	;AADD(aCampos,{"TIPCO1"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_FATCO2")	;AADD(aCampos,{"FATCO2"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_FATCO2")	;AADD(aCampos,{"TIPCO2"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_DESCPO")	;AADD(aCampos,{"DESCPO"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_DTCAD" )	;AADD(aCampos,{"DTCAD"    ,"D",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_DTDES" )	;AADD(aCampos,{"DTDES"    ,"D",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_RVDES" )	;AADD(aCampos,{"RVDES"    ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_DTINI" )	;AADD(aCampos,{"DTINI"    ,"D",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_DOCOBR")	;AADD(aCampos,{"DOCOBR"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_UNMED1")	;AADD(aCampos,{"UNMED1"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_UNMED2")	;AADD(aCampos,{"UNMED2"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_ENSAIO")	;AADD(aCampos,{"ENSAIO"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_ENSOBR")	;AADD(aCampos,{"ENSOBR"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_UNIMED")	;AADD(aCampos,{"UNIMED"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_NOMINA")	;AADD(aCampos,{"NOMINA"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_LIE"   )	;AADD(aCampos,{"LIE"      ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_LSE"   )	;AADD(aCampos,{"LSE"      ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_PLAMO" )	;AADD(aCampos,{"PLAMO"    ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_DESPLA")	;AADD(aCampos,{"DESPLA"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_NIVEL" )	;AADD(aCampos,{"NIVEL"    ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_LABOR" )	;AADD(aCampos,{"LABOR"    ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_SEQLAB")	;AADD(aCampos,{"SEQLAB"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_MINMAX")	;AADD(aCampos,{"MINMAX"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP7_METODO")	;AADD(aCampos,{"METODO"   ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QP8_TEXTO" )	;AADD(aCampos,{"TEXTO"    ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QPK_TAMLOT")	;AADD(aCampos,{"QUANT"    ,"N",aTam[1],aTam[2]})
aTam:=TamSX3("QPK_UM"     )	;AADD(aCampos,{"C2UNIMED" ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("QPK_EMISSA")	;AADD(aCampos,{"C2EMISSAO","D",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_HISTOR")	;AADD(aCampos,{"HISTOR"   ,"C",aTam[1],aTam[2]})
aTam:=TamSx3("QP6_ALTESP")	;AADD(aCampos,{"ALTESP"   ,"C",aTam[1],aTam[2]})

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"OP","LOTE","NUMSER"} )
oTempTable:AddIndex("indice2", {"OP","PRODUT","REVI","ROTEIRO","OPERAC","LABOR","SEQLAB"})
oTempTable:AddIndex("indice3", {"OPERAC","PRODUT","REVI","ROTEIRO","LABOR","SEQLAB"})
oTempTable:Create()

dbSelectArea("QPK")
dbSetOrder(1)

cQuery := "SELECT "  
cQuery += " QPK.QPK_OP OP, QPK.QPK_LOTE LOTE, QPK.QPK_NUMSER NUMSER," 
cQuery += " QPK.QPK_PRODUT PRODUT,QPK.QPK_REVI REVI,SC2.C2_ROTEIRO ROTEIRO," 
cQuery += " QPK.QPK_TAMLOT QUANT,QPK.QPK_UM C2UNIMED,QPK.QPK_EMISSA C2EMISSAO " 
cQuery += " FROM " 
cQuery += "	" + RetSQLName("QPK") + " QPK ,"                       
cQuery += "	" + RetSQLName("SC2") + " SC2 ,"                       
cQuery += "	" + RetSQLName("QP6") + " QP6 "                       
	
cQuery += " WHERE "
cQuery += " QPK.QPK_FILIAL = '" + xFilial("QPK") + "'"  
cQuery += " AND QP6.QP6_FILIAL = '" + xFilial("QP6") + "'" 
	 
cQuery += " AND QPK.QPK_PRODUT = QP6.QP6_PRODUT"  
cQuery += " AND QPK.QPK_REVI = QP6.QP6_REVI"
cQuery += " AND Substring(QPK.QPK_OP,1,6)  = SC2.C2_NUM"
cQuery += " AND Substring(QPK.QPK_OP,7,2)  = SC2.C2_ITEM"
cQuery += " AND Substring(QPK.QPK_OP,9,3)  = SC2.C2_SEQUEN"
cQuery += " AND Substring(QPK.QPK_OP,12,3) = SC2.C2_ITEMGRD"
cQuery += " AND SC2.C2_FILIAL              = '" + xFilial("SC2") +"'"	

cQuery += " AND LOWER(QPK.QPK_OP) >='"+LOWER(mv_par01) + "'"  
cQuery += " AND LOWER(QPK.QPK_LOTE) >='"+LOWER(mv_par02) + "'"  
cQuery += " AND LOWER(QPK.QPK_NUMSER) >='"+LOWER(mv_par03) + "'"  

cQuery += " AND LOWER(QPK.QPK_OP) <='"+LOWER(mv_par04) + "'"  
cQuery += " AND LOWER(QPK.QPK_LOTE) <='"+LOWER(mv_par05) + "'"  
cQuery += " AND LOWER(QPK.QPK_NUMSER) <='"+LOWER(mv_par06) + "'"  

cQuery += " AND QPK.D_E_L_E_T_ = ' '"  
cQuery += " AND SC2.D_E_L_E_T_ = ' '"  
cQuery += " AND QP6.D_E_L_E_T_ = ' '"  
cQuery += " ORDER BY " + SqlOrder(QPK->(IndexKey()))
cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),"TRBQPK", .F., .T.)
aTam := TamSx3("QPK_TAMLOT")
TcSetField( "TRBQPK", "QUANT"	,"N",aTam[1],aTam[2])
TcSetField( "TRBQPK", "C2EMISSAO"	,"D")

While !Eof()                                                                                                 
    cKey   := "QP6_PRODUT+QP6_REVI+QP7_CODREC+QP7_OPERAC+QP7_LABOR+QP7_SEQLAB"
	cQuery := "SELECT "  
	cQuery += " QP6.QP6_PRODUT PRODUT,QP6.QP6_REVI REVI,QP7.QP7_CODREC CODREC, "		 
	cQuery += " QP7.QP7_OPERAC OPERAC, QP7.QP7_LABOR LABOR, QP7.QP7_SEQLAB SEQLAB, "	 
	cQuery += " QP6.QP6_FATCO1 FATCO1, QP6.QP6_TIPCO1 TIPCO1, QP6.QP6_FATCO2 FATCO2, "	 
	cQuery += " QP6.QP6_TIPCO2 TIPCO2, QP6.QP6_DESCPO DESCPO, QP6.QP6_DTCAD DTCAD, "	 
	cQuery += " QP6.QP6_DTDES DTDES, QP6.QP6_RVDES RVDES, QP6.QP6_DTINI DTINI, "		 
	cQuery += " QP6.QP6_DOCOBR DOCOBR, QP6.QP6_UNMED1 UNMED1, QP6.QP6_UNMED2 UNMED2, "	 
	cQuery += " QQK.QQK_CHAVE CHAVE, QQK.QQK_DESCRI DESCRI, QQK.QQK_OPERGR OPERGRP, "		 
	cQuery += " QP7.QP7_ENSAIO ENSAIO, QP7.QP7_ENSOBR ENSOBR, QP7.QP7_UNIMED UNIMED, "	 
	cQuery += " QP7.QP7_NOMINA NOMINA, QP7.QP7_LIE LIE, QP7.QP7_NIVEL NIVEL, QP7.QP7_METODO METODO, "  
	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += " QQ7.QQ7_CLIENT CLIENT,QQ7.QQ7_LOJA LOJA, SA1.A1_NOME DESCLI, "		 
	EndIf
	
	cQuery += " QP6.QP6_HISTOR HISTOR,"  
	cQuery += " QP6.QP6_ALTESP ALTESP,"  


	cQuery += " QP7.QP7_LSE LSE, QP7.QP7_PLAMO PLAMO, QP7.QP7_DESPLA DESPLA, "  
	cQuery += " QP7.QP7_MINMAX MINMAX"  


	cQuery += " FROM "  
	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += "	" + RetSQLName("QQ7") + " QQ7, "   
		cQuery += "	" + RetSQLName("SA1") + " SA1, "   
	EndIf
	cQuery += "	" + RetSQLName("QPK") + " QPK, "  
	cQuery += "	" + RetSQLName("QP6") + " QP6, "  
	cQuery += "	" + RetSQLName("QQK") + " QQK, "  
	cQuery += "	" + RetSQLName("QP7") + " QP7 "  

	cQuery += " WHERE "  
	cQuery += " QPK.QPK_OP>='"			+TRBQPK->OP + "'"		 
	cQuery += " AND QPK.QPK_LOTE>='"	+TRBQPK->LOTE + "'"		 
	cQuery += " AND QPK.QPK_NUMSER>='"	+TRBQPK->NUMSER + "'"	 
	
	cQuery += " AND QPK.QPK_OP<='"		+TRBQPK->OP + "'"		 
	cQuery += " AND QPK.QPK_LOTE<='"	+TRBQPK->LOTE + "'"		 
	cQuery += " AND QPK.QPK_NUMSER<='"	+TRBQPK->NUMSER + "'"	 
	
	cQuery += " AND QP6.QP6_FILIAL = '" + xFilial("QP6") +"'"	 
	cQuery += " AND QQK.QQK_FILIAL  = '" + xFilial("QQK") +"'"	 
	cQuery += " AND QP7.QP7_FILIAL = '" + xFilial("QP7") +"'"	
    cQuery += " AND QPK.QPK_FILIAL = '" + xFilial("QPK") +"'"	

	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += " AND QQ7.QQ7_FILIAL = '" + xFilial("QQ7") +"'"	 
	EndIf

	cQuery += " AND QP6.QP6_PRODUT = '" + TRBQPK->PRODUT +"'"	 
	cQuery += " AND QP6.QP6_REVI = '" + TRBQPK->REVI +"'"	 
	cQuery += " AND QQK.QQK_PRODUT ='" + TRBQPK->PRODUT +"'"  
	cQuery += " AND QQK.QQK_CODIGO ='" + TRBQPK->ROTEIRO +"'"  
	cQuery += " AND LOWER(QQK.QQK_OPERAC) Between '" + LOWER(mv_par07)	+ "' and '" + LOWER(mv_par08) + "'"  
	cQuery += " AND QQK.QQK_REVIPR = QPK.QPK_REVI"		 
	cQuery += " AND QP7.QP7_PRODUT = QP6.QP6_PRODUT "	 
	cQuery += " AND QP7.QP7_REVI = QPK.QPK_REVI " 		 
	cQuery += " AND QP7.QP7_CODREC = QQK.QQK_CODIGO "	 
	cQuery += " AND QP7.QP7_OPERAC = QQK.QQK_OPERAC "	 
	cQuery += " AND LOWER(QP7.QP7_LABOR) Between '" + LOWER(mv_par12)	+ "' and '" + LOWER(mv_par13) + "'"  
	
	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += " AND LOWER(SA1.A1_COD) = '"+LOWER(mv_par10)+"'"	 
		cQuery += " AND LOWER(SA1.A1_LOJA) = '"+LOWER(mv_par11)+"'"	 
		cQuery += " AND QQ7.QQ7_PRODUT = QP7.QP7_PRODUT "	 
		cQuery += " AND QQ7.QQ7_ENSAIO = QP7.QP7_ENSAIO "	 
		cQuery += " AND QQ7.QQ7_LABOR = QP7.QP7_LABOR "		 
		cQuery += " AND QQ7.QQ7_CODREC = QP7.QP7_CODREC "	 
		cQuery += " AND QQ7.QQ7_OPERAC = QP7.QP7_OPERAC " 	 
		cQuery += " AND LOWER(QQ7.QQ7_CLIENT) = '"+ LOWER(mv_par10) +"'"	 
		cQuery += " AND LOWER(QQ7.QQ7_LOJA) = '" + LOWER(mv_par11) + "'"	 
	EndIf
	
	cQuery += " AND QPK.D_E_L_E_T_ = ' '"  
	cQuery += " AND QP6.D_E_L_E_T_ = ' '"  
	cQuery += " AND QQK.D_E_L_E_T_ = ' '"  
	cQuery += " AND QP7.D_E_L_E_T_ = ' '"  

	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += " AND QQ7.D_E_L_E_T_ = ' '"  
	EndIf
	cQuery += " ORDER BY " + SqlOrder(cKey)
	cQuery := ChangeQuery(cQuery)   
	dbUseArea(.T., "TOPCONN", TcGenQry(,,cQuery), 'TR1') 
	TcSetField( "TR1", "DTCAD"	,"D")
	TcSetField( "TR1", "DTDES"	,"D")
	TcSetField( "TR1", "DTINI"	,"D")
	QQK->(DbSetOrder(1))
	
	While !Eof()
		If	mv_par09 == 1	 //Imprime somente a ultima operacao
			If 	QQK->(dbSeek(xFilial("QQK")+TR1->PRODUT+TR1->REVI+If(Empty(TR1->CODREC),;
				"01", TR1->CODREC)))
				dbSelectArea("QQK")
				nRecQQK := Recno()
				While !Eof().And. xFilial("QQK")	==	QQK_FILIAL	.And.;
					QQK_PRODUT+QQK_REVIPR+QQK_CODIGO==TR1->PRODUT+TR1->REVI+If(Empty(TR1->CODREC),;
					"01", TR1->CODREC)
					nRecQQK := Recno()
					QQK->(dbSkip())
				EndDo
				dbGoTo(nRecQQK)
				dbSelectArea("TR1")
				If TR1->OPERAC <> QQK->QQK_OPERAC
					TR1->(DbSkip())
					Loop
				Endif
			Endif
		EndIf
		RecLock("TRB",.T.)
		TRB->OP  		:= TRBQPK->OP  
		TRB->LOTE       := TRBQPK->LOTE 
		TRB->NUMSER     := TRBQPK->NUMSER
		TRB->QUANT		:= TRBQPK->QUANT
		TRB->C2UNIMED	:= TRBQPK->C2UNIMED
		TRB->C2EMISSAO	:= TRBQPK->C2EMISSAO
		TRB->ROTEIRO	:= TR1->CODREC
		TRB->OPERAC		:= TR1->OPERAC
		TRB->CHAVE		:= TR1->CHAVE
		TRB->DESCRI		:= TR1->DESCRI
		TRB->OPERGRP	:= TR1->OPERGRP
		TRB->PRODUT		:= TR1->PRODUT
		TRB->REVI		:= TR1->REVI
		TRB->FATCO1		:= TR1->FATCO1
		TRB->TIPCO1		:= TR1->TIPCO1
		TRB->FATCO2		:= TR1->FATCO2
		TRB->TIPCO2		:= TR1->TIPCO2
		TRB->DESCPO		:= TR1->DESCPO
		TRB->DTCAD		:= TR1->DTCAD
		TRB->DTDES		:= TR1->DTDES
		TRB->RVDES		:= TR1->RVDES
		TRB->DTINI		:= TR1->DTINI
		TRB->DOCOBR		:= TR1->DOCOBR
		TRB->UNMED1		:= TR1->UNMED1
		TRB->UNMED2		:= TR1->UNMED2
		TRB->ENSAIO 	:= TR1->ENSAIO
		TRB->ENSOBR		:= TR1->ENSOBR
		TRB->UNIMED 	:= TR1->UNIMED
		TRB->NOMINA 	:= TR1->NOMINA
		TRB->LIE 		:= TR1->LIE
		TRB->LSE 		:= TR1->LSE
		TRB->PLAMO		:= TR1->PLAMO
		TRB->DESPLA		:= TR1->DESPLA
		TRB->NIVEL 	    := TR1->NIVEL
		TRB->LABOR		:= TR1->LABOR
		TRB->SEQLAB 	:= TR1->SEQLAB
		TRB->MINMAX 	:= TR1->MINMAX
		TRB->METODO 	:= TR1->METODO
		TRB->HISTOR		:= TR1->HISTOR
		TRB->ALTESP	:= TR1->ALTESP
	
		MsUnlock()
		dbSelectArea("TR1")
		TR1->(dbSkip())
	Enddo
	dbSelectArea("TR1")
	dbCloseArea()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Texto 														 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cKey   := "QP6_PRODUT+QP6_REVI+QP8_CODREC+QP8_OPERAC+QP8_LABOR+QP8_SEQLAB"
	cQuery := "SELECT "  
	cQuery += " QP6.QP6_PRODUT PRODUT,QP6.QP6_REVI REVI,QP8.QP8_CODREC CODREC, "	 
	cQuery += " QP8.QP8_OPERAC OPERAC, QP8.QP8_LABOR LABOR, QP8.QP8_SEQLAB SEQLAB, " 
	cQuery += " QP6.QP6_FATCO1 FATCO1, QP6.QP6_TIPCO1 TIPCO1, QP6.QP6_FATCO2 FATCO2, " 
	cQuery += " QP6.QP6_TIPCO2 TIPCO2, QP6.QP6_DESCPO DESCPO, QP6.QP6_DTCAD DTCAD, " 
	cQuery += " QP6.QP6_DTDES DTDES, QP6.QP6_RVDES RVDES, QP6.QP6_DTINI DTINI, "	 
	cQuery += " QP6.QP6_DOCOBR DOCOBR, QP6.QP6_UNMED1 UNMED1, QP6.QP6_UNMED2 UNMED2, " 
	cQuery += " QQK.QQK_CHAVE CHAVE, QQK.QQK_DESCRI DESCRI, QQK.QQK_OPERGR OPERGRP, "	 
	cQuery += " QP8.QP8_ENSAIO ENSAIO, QP8.QP8_ENSOBR ENSOBR, QP8.QP8_TEXTO TEXTO, QP8.QP8_METODO METODO, "	 
	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += " QQ7.QQ7_CLIENT CLIENT,QQ7.QQ7_LOJA LOJA, SA1.A1_NOME DESCLI, "	 
	EndIf
	
	cQuery += " QP6.QP6_HISTOR HISTOR, " 
	cQuery += " QP6.QP6_ALTESP ALTESP, " 

	cQuery += " QP8.QP8_PLAMO PLAMO, QP8.QP8_DESPLA DESPLA, QP8.QP8_NIVEL NIVEL "  

	cQuery += " FROM "  
	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += "	" + RetSQLName("QQ7") + " QQ7, "  
		cQuery += "	" + RetSQLName("SA1") + " SA1, "  
	EndIf
	cQuery += "	" + RetSQLName("QPK") + " QPK, "  
	cQuery += "	" + RetSQLName("QP6") + " QP6, "  
	cQuery += "	" + RetSQLName("QQK") + " QQK, "  
	cQuery += "	" + RetSQLName("QP8") + " QP8 "  

	cQuery += " WHERE "  
 
	cQuery += " QPK.QPK_OP>='"			+TRBQPK->OP + "'"		 
	cQuery += " AND QPK.QPK_LOTE>='"	+TRBQPK->LOTE + "'"		 
	cQuery += " AND QPK.QPK_NUMSER>='"	+TRBQPK->NUMSER + "'"	 
	
	cQuery += " AND QPK.QPK_OP<='"		+TRBQPK->OP + "'"		 
	cQuery += " AND QPK.QPK_LOTE<='"	+TRBQPK->LOTE + "'"		 
	cQuery += " AND QPK.QPK_NUMSER<='"	+TRBQPK->NUMSER + "'"	 

	cQuery += " AND QP6.QP6_FILIAL = '" + xFilial("QP6") +"'" 
	cQuery += " AND QQK.QQK_FILIAL  = '" + xFilial("QQK") +"'" 
	cQuery += " AND QP8.QP8_FILIAL = '" + xFilial("QP8") +"'" 
	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += " AND QQ7.QQ7_FILIAL = '" + xFilial("QQ7") +"'" 
	EndIf
	cQuery += " AND QP6.QP6_PRODUT = '"	+ TRBQPK->PRODUT	+"'" 
	cQuery += " AND QP6.QP6_REVI = '" 	+ TRBQPK->REVI		+"'" 
	cQuery += " AND QQK.QQK_PRODUT ='" 	+ TRBQPK->PRODUT	+"'" 
	cQuery += " AND QQK.QQK_CODIGO ='"  + TRBQPK->ROTEIRO   +"'"  
	cQuery += " AND LOWER(QQK.QQK_OPERAC) Between '" + LOWER(mv_par07)	+ "' and '" + LOWER(mv_par08) + "'"  
	cQuery += " AND QQK.QQK_REVIPR = QPK.QPK_REVI"			 
	cQuery += " AND QP8.QP8_PRODUT = QP6.QP6_PRODUT "		 
	cQuery += " AND QP8.QP8_REVI = QPK.QPK_REVI "			 
	cQuery += " AND QP8.QP8_CODREC = QQK.QQK_CODIGO "		 
	cQuery += " AND QP8.QP8_OPERAC = QQK.QQK_OPERAC "		 
	cQuery += " AND LOWER(QP8.QP8_LABOR) Between '" + LOWER(mv_par12)	+ "' and '" + LOWER(mv_par13) + "'"  
	
	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += " AND LOWER(SA1.A1_COD) = '"+ LOWER(mv_par10) +"'"	 
		cQuery += " AND LOWER(SA1.A1_LOJA) = '" + LOWER(mv_par11) + "'" 
		cQuery += " AND QQ7.QQ7_PRODUT = QP8.QP8_PRODUT " 
		cQuery += " AND QQ7.QQ7_ENSAIO = QP8.QP8_ENSAIO " 
		cQuery += " AND QQ7.QQ7_LABOR = QP8.QP8_LABOR "	 
		cQuery += " AND QQ7.QQ7_CODREC = QP8.QP8_CODREC " 
		cQuery += " AND QQ7.QQ7_OPERAC = QP8.QP8_OPERAC "  
		cQuery += " AND LOWER(QQ7.QQ7_CLIENT) = '"+ LOWER(mv_par10) +"'" 
		cQuery += " AND LOWER(QQ7.QQ7_LOJA) = '" + LOWER(mv_par11) + "'" 
	EndIf
	
	cQuery += " AND QPK.D_E_L_E_T_ = ' '" 
	cQuery += " AND QP6.D_E_L_E_T_ = ' '"  
	cQuery += " AND QQK.D_E_L_E_T_ = ' '"  
	cQuery += " AND QP8.D_E_L_E_T_ = ' '" 

	If !Empty(mv_par10) .And. !Empty(mv_par11)
		cQuery += " AND QQ7.D_E_L_E_T_ = ' '"  
	EndIf
	cQuery += " ORDER BY " + SqlOrder(cKey)
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TcGenQry(,,cQuery), 'TR2')
	TcSetField( "TR2", "DTCAD"	,"D")
	TcSetField( "TR2", "DTDES"	,"D")
	TcSetField( "TR2", "DTINI"	,"D")
	
	QQK->(DbSetOrder(1))
	While !Eof()
		If	mv_par09 == 1	 //Imprime somente a ultima operacao
			If 	QQK->(dbSeek(xFilial("QQK")+TR2->PRODUT+TR2->REVI+If(Empty(TR2->CODREC),;
				"01", TR2->CODREC)))
				dbSelectArea("QQK")
				nRecQQK := Recno()
				While !Eof().And. xFilial("QQK")	==	QQK_FILIAL	.And.;
					QQK_PRODUT+QQK_REVIPR+QQK_CODIGO==TR2->PRODUT+TR2->REVI+If(Empty(TR2->CODREC),;
					"01", TR2->CODREC)
					nRecQQK := Recno()
					QQK->(dbSkip())
				EndDo
				dbGoTo(nRecQQK)
				dbSelectArea("TR2")
				If TR2->OPERAC <> QQK->QQK_OPERAC
					TR2->(DbSkip())
					Loop
				Endif
			Endif
		EndIf
			
		RecLock("TRB",.T.)
		TRB->OP		    := TRBQPK->OP
		TRB->LOTE       := TRBQPK->LOTE 
		TRB->NUMSER     := TRBQPK->NUMSER
		TRB->QUANT		:= TRBQPK->QUANT
		TRB->C2UNIMED	:= TRBQPK->C2UNIMED
		TRB->C2EMISSAO	:= TRBQPK->C2EMISSAO
		TRB->ROTEIRO	:= TR2->CODREC
		TRB->OPERAC		:= TR2->OPERAC
		TRB->CHAVE		:= TR2->CHAVE
		TRB->DESCRI		:= TR2->DESCRI
		TRB->OPERGRP	:= TR2->OPERGRP
		TRB->PRODUT		:= TR2->PRODUT
		TRB->REVI		:= TR2->REVI
		TRB->FATCO1		:= TR2->FATCO1
		TRB->TIPCO1		:= TR2->TIPCO1
		TRB->FATCO2		:= TR2->FATCO2
		TRB->TIPCO2		:= TR2->TIPCO2
		TRB->DESCPO		:= TR2->DESCPO
		TRB->DTCAD		:= TR2->DTCAD
		TRB->DTDES		:= TR2->DTDES
		TRB->RVDES		:= TR2->RVDES
		TRB->DTINI		:= TR2->DTINI
		TRB->DOCOBR		:= TR2->DOCOBR
		TRB->UNMED1		:= TR2->UNMED1
		TRB->UNMED2		:= TR2->UNMED2
		TRB->ENSAIO 	:= TR2->ENSAIO
		TRB->ENSOBR		:= TR2->ENSOBR
		TRB->TEXTO		:= TR2->TEXTO
		TRB->PLAMO		:= TR2->PLAMO
		TRB->DESPLA		:= TR2->DESPLA
		TRB->NIVEL   	:= TR2->NIVEL
		TRB->LABOR		:= TR2->LABOR
		TRB->SEQLAB 	:= TR2->SEQLAB
		TRB->METODO 	:= TR2->METODO
		TRB->HISTOR		:= TR2->HISTOR
		TRB->ALTESP	:= TR2->ALTESP

		MsUnlock()
		dbSelectArea("TR2")
		TR2->(dbSkip())
	Enddo
	dbSelectArea("TR2")
	TR2->(dbCloseArea())

	dbSelectArea("TRBQPK")
	TRBQPK->(dbSkip())
EndDo
dbSelectArea("TRBQPK")
TRBQPK->(dbCloseArea())


Return .T.
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³QprImpPl	³ Autor ³ Marcelo Pimentel 	  	³ Data ³ 24.07.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna o Aceite/Rejeite/Tam.Amostra do ensaio com Plano Amo³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³U_QIPR040()  												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QprImpPl(cEnsaio,cTpCart,cPlamo,cDescPla,cProduto,cRevi,cRoteiro,cOperac,cTamAmo)
Local cPlAmEns	:= ""
Local cIntNor	:= ""
Local cCodAmo	:= ""
Local cAmost	:= ""
Local cNivAm	:= ""
Local nSequen	:= 0
Local aPlInt	:= {}
Local aArea		:= GetArea()
Local cCodNorma := QA_Plano(cPlamo)

cPlAmEns	:= Substr(cDescPla,If(cPlamo<>"B",9,33),2)

If cPlamo == "T"
	cPlAmEns	:= 'T'
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o Plano de Amostragem definido para o ensaio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QA6->(dbSetOrder(2))
QA6->(dbSeek(xFilial('QA6')+cCodNorma+cPlAmEns+Str(Int(Val(cTamAmo)),8),.T.))
While QA6->(!Eof()) .And. xFilial('QA6')+cCodNorma+cPlAmEns == QA6->QA6_FILIAL+QA6->QA6_PLANO+QA6->QA6_NIVEL
	If QA6->QA6_LOTINF <= Int(Val(cTamAmo)) .And. QA6->QA6_LOTSUP >= Int(Val(cTamAmo))
		cCodAmo := QA6->QA6_CODAMO
		Exit
	EndIf
	QA6->(dbSkip())
EndDo

If cPlamo == "I"	//Definido para Plano de Amostragem - Interno
	cPlAmEns	:= Substr(cDescPla,9,2)
	cIntNor		:= 'I'
	
ElseIf cPlamo == "T"
	cIntNor		:= 'T'
	cPlAmEns	:= 'T'
	Aadd(aPlInt,{0,1,1})
	
ElseIf cPlamo == "N" .Or. cPlamo == "B"
	QQH->(dbSetOrder(1))
	If QQH->(dbSeek(xFilial('QQH')+cProduto+cRevi+cRoteiro+cOperac+cEnsaio))
		cPlAmEns	:= QQH->QQH_NQA
		cIntNor		:= cPlamo
		cAmost		:= QQH->QQH_AMOST
		cNivAm		:= QQH->QQH_NIVAMO
		nSequen		:= If(Subs(QQH->QQH_AMOST,1,1) == 'S' .Or. cPlamo == "B",0,1)
		QA6->(dbSetOrder(2))
		QA6->(dbSeek(xFilial('QA6')+cCodNorma+cNivAm+Str(Int(Val(cTamAmo)),8),.T.))
		While QA6->(!Eof()) .And. xFilial('QA6')+cCodNorma+cNivAm == QA6->QA6_FILIAL+QA6->QA6_PLANO+QA6->QA6_NIVEL
			If QA6->QA6_LOTINF <= Int(Val(cTamAmo)) .And. QA6->QA6_LOTSUP >= Int(Val(cTamAmo))
				cCodAmo := QA6->QA6_CODAMO
				Exit
			EndIf
			QA6->(dbSkip())
		EndDo
	EndIf

ElseIf cPlamo == "Z"
	QQH->(dbSetOrder(1))
	If QQH->(dbSeek(xFilial('QQH')+cProduto+cRevi+cRoteiro+cOperac+cEnsaio))
		cPlAmEns	:= QQH->QQH_NQA
		cIntNor		:= 'Z'
		cNivAm		:= 'QS'

		QA6->(dbSetOrder(2))
		QA6->(dbSeek(xFilial('QA6')+cCodNorma+cNivAm+Str(Int(Val(cTamAmo)),8),.T.))
		While QA6->(!Eof()) .And. xFilial('QA6')+cCodNorma+cNivAm == QA6->QA6_FILIAL+QA6->QA6_PLANO+QA6->QA6_NIVEL
			If QA6->QA6_LOTINF <= Int(Val(cTamAmo)) .And. QA6->QA6_LOTSUP >= Int(Val(cTamAmo))
				cCodAmo := QA6->QA6_CODAMO
				Exit
			EndIf
			QA6->(dbSkip())
		EndDo
	EndIf
EndIf
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se tiver Pl. Amostragem def. para o ensaio, compara no. medicoes ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cPlAmEns)
	If cIntNor == 'I'
		QA7->(dbSetOrder(3))
		If QA7->(dbSeek(xFilial('QA7')+cCodNorma+"ESP"+cPlAmEns+cCodAmo))	//Plano de Amostragem Interno
			While !QA7->(Eof()).And.QA7->QA7_FILIAL==xFilial('QA7') .And. QA7->QA7_PLANO == cCodNorma .And.QA7->QA7_NQA =="ESP"+cPlAmEns .And.  ;
				QA7->QA7_CODAMO == cCodAmo
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Plano de Amostragem Simples Amostragem                           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cCpo		:= "QA7->QA7_NO_ACE"
				nAceite		:= &cCpo
				cCpo		:= "QA7->QA7_NO_REJ"
				nRejeite	:= &cCpo
				cCpo		:= "QA7->QA7_NO_AMO"
				nTamAmo		:= &cCpo
				cCpo		:= "QA7->QA7_NO_FOR"
				cTamFor		:= &cCpo
				If !Empty(cTamFor) .And. !Empty(cTamAmo)
					cTamFor := AllTrim(StrTran(cTamFor,"#Tam.Lote#",cTamAmo))
					nTamAmo := &(cTamFor)
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Tratar o tamanho da amostra caso seja valor inferior a 1         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nTamAmo < 1
					nTamAmo := 1
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Tratar o tamanho da amostra caso seja valor Superior a quantidade³
				//³ da Ordem de Producao                                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nTamAmo > Val(cTamAmo)
					nTamAmo := Val(cTamAmo)
				EndIf
				
				Aadd(aPlInt,{nAceite,nRejeite,Int(nTamAmo),cDescPla})
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Plano de Amostragem Dupla Amostragem - para que seja possivel    ³
				//³ utiliza-lo os campos Aceite/Rejeite/Tam.Amostra ou Amostra por   ³
				//³ Formula, devem estar preenchidos.                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cCpo		:= "QA7->QA7_SE_ACE"
				nAceite		:= &cCpo
				cCpo		:= "QA7->QA7_SE_REJ"
				nRejeite	:= &cCpo
				cCpo		:= "QA7->QA7_SE_AMO"
				nTamAmo		:= &cCpo
				cCpo		:= "QA7->QA7_SE_FOR"
				cTamFor		:= &cCpo
				If !Empty(cTamFor) .And. !Empty(cTamAmo)
					cTamFor := AllTrim(StrTran(cTamFor,"#Tam.Lote#",cTamAmo))
					nTamAmo := &(cTamFor)
				EndIf
				Aadd(aPlInt,{nAceite,nRejeite,Int(nTamAmo),cDescPla})
				QA7->(dbSkip())
			EndDo
		EndIf
	Else
		If !Empty(cCodAmo)
			QA7->(dbSetOrder(3))
			If QA7->(dbSeek(xFilial('QA7')+cCodNorma+cPlAmEns+cCodAmo+Alltrim(Str(nSequen))))
			
	   	        If cCodNorma == "NB5426"
				  	cTipo := If(Right(cAmost,1) == "A","AT",If(Right(cAmost,1) == "N","NO","SE"))
			    ElseIf cCodNorma == "NB5429"
				  	cTipo := If(AllTrim(cAmost)=="A","AT",If(AllTrim(cAmost)=="N","NO","SE"))
	        	ElseIf cCodNorma == "QS9000"
				  	cTipo := "QS"
		        EndIf
				
				If cPlamo<>'Z'
					cCpo		:= "QA7->QA7_"+cTipo+"_ACE"
					nAceite		:= &cCpo
					cCpo		:= "QA7->QA7_"+cTipo+"_REJ"
					nRejeite	:= &cCpo
					cCpo		:= "QA7->QA7_"+cTipo+"_AMO"
					nTamAmo		:= &cCpo
				Else
					nAceite		:= 0
					nRejeite	:= 1
					cCpo		:= "QA7->QA7_"+cTipo+"_AMO"
					nTamAmo		:= &cCpo
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Tratar o tamanho da amostra caso seja valor Superior a quantidade³
				//³ da Ordem de Producao                                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nTamAmo > Val(cTamAmo)
					nTamAmo := Val(cTamAmo)
				EndIf

				Aadd(aPlInt,{nAceite,nRejeite,Int(nTamAmo),cDescPla})
			EndIf
		EndIf
	EndIf
EndIf           

If Len(aPlInt) == 0
	Aadd(aPlInt,{0,1,1})
EndIf

RestArea(aArea)
Return(aPlInt)
