/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIPR060.CH"
#Include "PROTHEUS.CH"  
#Include "REPORT.CH"  

Static lQLTDispSVR := NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIPR060  ³ Autor ³ Antonio Aurelio       ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resultados                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QIPR060()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/     
User Function Qipr060()
Local oReport	

Private  __cPRODUTO := CriaVar("QP6_PRODUT") //Codigo do Produto, quando a Especificacao for em Grupo      
Private lProduto   := .F.

lQLTDispSVR := Iif(lQLTDispSVR == Nil, FindFunction("QLTDispSVR"), lQLTDispSVR)

If lQLTDispSVR .AND. GetRpoRelease() > "12.1.2210" .AND. QLTDispSVR("manufacturing.sv.qip.inspectionresult")
	Return
Endif

If  TRepInUse()
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	U_Qipr060R3()
EndIf       

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ReportDef  ºAutor  ³Cleber Souza        º Data ³  07/17/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicoes do relatorio de Resultados R4.	              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIPR060                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local cPrograma   :="QIPR060"
Local cDesc1      := STR0001  //"Neste relat¢rio ser„o impressos os resultados obtidos na inspe‡„o"
Local cDesc2      := STR0002  //"da Produ‡„o."
Local cTitulo 	  := STR0003	 //"Resultados"  
Local cPerg       := "QPR060"

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+" "+cDesc2)
oReport:SetLandscape(.T.)
	
DEFINE SECTION oSection1 OF oReport TITLE STR0044
DEFINE CELL NAME "cAbre"     OF oSection1  SIZE 30 

DEFINE SECTION oSection2 OF oReport TITLE TitSX3("QPT_INSTR")[1]  
DEFINE CELL NAME "QPT_INSTR"     OF oSection2  TITLE TitSX3("QPT_INSTR")[1]  
DEFINE CELL NAME "cQPR_ENSR"     OF oSection2  TITLE TitSX3("QPR_ENSR")[1]     //BLOCK {|| Substr(POSICIONE("QAA",1,xFilial("QAA")+&(cAliasQPR)->(QPR_ENSR),"QAA_APELID"),1,9)}  SIZE 30
DEFINE CELL NAME "QPR_DTMEDI"    OF oSection2  TITLE TitSX3("QPR_DTMEDI")[1]  BLOCK {||DTOC(&(cAliasQPR)->(QPR_DTMEDI))}
DEFINE CELL NAME "QPR_HRMEDI"    OF oSection2  TITLE TitSX3("QPR_HRMEDI")[1]  BLOCK {||&(cAliasQPR)->(QPR_HRMEDI)}
DEFINE CELL NAME "QPR_AMOSTR"    OF oSection2  TITLE STR0025 				  BLOCK {||AllTrim(Str(&(cAliasQPR)->(QPR_AMOSTR)))}
DEFINE CELL NAME "cCarta"        OF oSection2  TITLE STR0010				  SIZE 45
DEFINE CELL NAME "cAR"           OF oSection2  TITLE STR0021 				  BLOCK {||&(cAliasQPR)->(QPR_RESULT)}
DEFINE CELL NAME "cNConf"        OF oSection2  TITLE STR0022 
DEFINE CELL NAME "cNrConf"       OF oSection2  TITLE STR0023 
DEFINE CELL NAME "cClasse"       OF oSection2  TITLE STR0024 
DEFINE CELL NAME "cDIQI"         OF oSection2  TITLE STR0026 

DEFINE SECTION oSection3 OF oReport  TITLE STR0032
DEFINE CELL NAME "cNorma"        OF oSection3  TITLE STR0032  			 SIZE 9  //"NORMA"
DEFINE CELL NAME "cTP"           OF oSection3  TITLE STR0033    		 SIZE 50  //"TP"
oSection3:Cell("cTP"):SeTLineBREAK(.T.)
DEFINE CELL NAME "cPAmostra"     OF oSection3  TITLE STR0034  			 SIZE 6  //"PRIMEIRA AMOSTRA"
DEFINE CELL NAME "cPAceite"      OF oSection3  TITLE STR0035  			 SIZE 6  //"ACEITE"
DEFINE CELL NAME "cPRejeite"     OF oSection3  TITLE STR0036  	   		 SIZE 6  //"REJEITE"
DEFINE CELL NAME "cSAmostra"     OF oSection3  TITLE STR0037  			 SIZE 6  //"SEGUNDA AMOSTRA"
DEFINE CELL NAME "cSAceite"      OF oSection3  TITLE STR0035  			 SIZE 6  //"ACEITE"
DEFINE CELL NAME "cSRejeite"     OF oSection3  TITLE STR0036  		     SIZE 6  //"REJEITE"
DEFINE CELL NAME "cNMedicoes"    OF oSection3  TITLE STR0038 			 SIZE 6  //"NUMERO MEDICOES"
DEFINE CELL NAME "cMedia"	     OF oSection3  TITLE STR0039  			 SIZE 6  //"MEDIA"
DEFINE CELL NAME "cDesPad"       OF oSection3  TITLE STR0040  			 SIZE 9  //"DESVIO PADRAO"
DEFINE CELL NAME "cPI"           OF oSection3  TITLE STR0041  			 SIZE 9  //"PI"
DEFINE CELL NAME "cPS"     		 OF oSection3  TITLE STR0042  			 SIZE 9  //"PS"
DEFINE CELL NAME "cResultado"    OF oSection3  TITLE STR0043  	    	 SIZE 9  //"RESULTADO"
oSection1:SetEdit(.F.)

Return(oReport)                            

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Cleber Souza		 º Data ³  07/17/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao relatorio R4. (Resultados)                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIPR060                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
                                   
Local oSection1     := oReport:Section(1)
Local oSection2     := oReport:Section(2) 
Local oSection3     := oReport:Section(3)  
Local cDescLab		:= ""
Local cLabor		:= ""
Local aInstr		:= {}
Local aResult		:= {}
Local aNC			:= {}
Local cChave 		:= ""
Local aResTXT		:= {}
Local nTotInstr		:= 0
Local nTotnC		:= 0
Local nTot			:= 0
Local cMed			:= ""
Local nR			:= 0
Local nX			:= 0
Local aNCTxt		:= {}
Local cChNC			:= ""
Local cEnsaio		:= ""
Local cbCont		:= 00
Local cArqTemp		:= ""
Local cDat			:= ""
Local lCronica		:= .T.
Local cOperac		:= ""
Local cOP			:= ""
Local aCampos		:= {}
Local aCamposAux	:= {}
Local lMedicao
Local cNorma        := ""
Local aNBR5429      := {}              
Local aQtdMed       := {}
Local cCarta        := " "
Local aPlano        := {}
Local cAmost        := " "
Local cFatcon	    := ""
Local cTipCon	    := ""
Local cTamAmo       := ""
Local cCodMed       := ""
Local nNC           := 0
Local nC            := 0
Local nT            := 0     
Local cPerg         := "QPR060"
Local lPrint        := .F.    
Local cCond         := ""
Private cAliasQPR   := "QPR"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01           //  Do  Produto ?             	         ³
//³ mv_par02           //  At‚ Produto ?                         ³
//³ mv_par03           //  Da  RevisÆo ?                         ³
//³ mv_par04           //  At‚ RevisÆo ?                         ³
//³ mv_par05           //  Da  Ordem Producao ?                  ³
//³ mv_par06           //  Do  Lote			  ?                  ³
//³ mv_par07           //  Do  Numero de Serie ?                 ³
//³ mv_par08           //  At‚ Data de Producao ?                ³
//³ mv_par09           //  Ate Lote ?                            ³
//³ mv_par10           //  Ate Numero de Serie ?                 ³
//³ mv_par11           //  Da Data Producao ?                    ³
//³ mv_par12           //  Ate Data de Producao ?                ³
//³ mv_par13           //  Cliente ?                             ³
//³ mv_par14           //  Loja ?                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona a Origem da Entrada							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	MakeSqlExpr(oReport:uParam) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()	
cAliasQPR := GetNextAlias()  
BeginSql Alias cAliasQPR                   

	SELECT QPR.QPR_FILIAL , QPR.QPR_OP    , QPR.QPR_PRODUT, QPR.QPR_DTENTR, QPR.QPR_LOTE,
		QPR.QPR_REVI   , QPR.QPR_LABOR , QPR.QPR_ENSAIO, QPR.QPR_DTMEDI, QPR.QPR_HRMEDI,
		QPR.QPR_AMOSTR , QPR.QPR_ENSR  , QPR.QPR_RESULT, 
	    QPR.QPR_MBROWS, QPR.QPR_GRUPO , QPR.QPR_RASTRE, QPR.QPR_OPERAC,
		QPR.QPR_CHAVE  , QPR.QPR_ENTINS, QPR.QPR_ENTNC , QPR.QPR_DTINI , QPR.QPR_HRINI,
		QPR.QPR_DTFIM  , QPR.QPR_HRFIM , QPR.QPR_CLIENT, QPR.QPR_LOJA  , QPR.QPR_FILMAT,
		QPR.QPR_ROTEIR , QPR.QPR_NUMSER, QPR.QPR_METODO, QPR.QPR_RVDOC
 	FROM %table:QPR% QPR 	
	WHERE QPR.QPR_FILIAL = %xFilial:QPR% AND 
		  QPR.QPR_PRODUT BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
		  QPR.QPR_REVI   BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% AND
		  QPR.QPR_OP     BETWEEN %Exp:mv_par05% AND %Exp:mv_par08% AND
		  QPR.QPR_LOTE   BETWEEN %Exp:mv_par06% AND %Exp:mv_par09% AND
		  QPR.QPR_NUMSER BETWEEN %Exp:mv_par07% AND %Exp:mv_par10% AND
		  QPR.QPR_DTENTR BETWEEN %Exp:mv_par11% AND %Exp:mv_par12% AND
	      QPR.%notDel%
 		ORDER BY QPR_FILIAL,QPR_OP,QPR_LOTE,QPR_OPERAC,QPR_LABOR,QPR_ENSAIO,QPR_DTMEDI,QPR_HRMEDI	
EndSql   

oSection1:EndQuery()	
		

oSection1:Init()
oSection1:Cell("cAbre"):Hide()   

If &(cAliasQPR)->(Eof()) .and. &(cAliasQPR)->(Eof()) 
	HELP(" ",1,"RECNO")
	dbSelectArea("QPR")
	Set Filter To
	Return .T.
EndIf    

oReport:SetMeter(&(cAliasQPR)->(RecCount()))
&(cAliasQPR)->(dbGoTop())  

While &(cAliasQPR)->(!Eof())  

	If oReport:Cancel()
		Exit
	EndIf
	oReport:IncMeter()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe a amarracao do Produto x Cliente - QQ7     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(mv_par13)
		If SC2->(dbSeek(xFilial("SC2")+&(cAliasQPR)->(QPR_OP)))
			QQ7->(dbSetOrder(1))
			If 	!QQ7->(dbSeek(xFilial("QQ7")+ &(cAliasQPR)->(QPR_PRODUT) + mv_par13 + mv_par14 + ;
				&(cAliasQPR)->(QPR_LABOR) + &(cAliasQPR)->(QPR_ENSAIO) + SC2->C2_ROTEIRO + &(cAliasQPR)->(QPR_OPERAC)))
				&(cAliasQPR)->(dbSkip())
				Loop
			EndIf
		EndIf
	EndIf
	
	If oReport:Cancel()
		Exit
	EndIf

	If cOp != &(cAliasQPR)->(QPR_OP)+&(cAliasQPR)->(QPR_LOTE)+&(cAliasQPR)->(QPR_NUMSER)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza todos os itens que sÆo impressos neste cabe‡alho    ³
		//³  para fazer o controle                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cOp)
			oReport:EndPage()
		EndIF    

		cOp     :=  &(cAliasQPR)->(QPR_OP)+&(cAliasQPR)->(QPR_LOTE)+&(cAliasQPR)->(QPR_NUMSER)
		cOperac := ""
		cLabor  := ""
		cDat    := Dtos(&(cAliasQPR)->(QPR_DTENTR))+&(cAliasQPR)->(QPR_LOTE)
		                  
		QP6->(dbSeek(xFilial("QP6")+&(cAliasQPR)->(QPR_PRODUT)+Inverte(&(cAliasQPR)->(QPR_REVI))))
		SC2->(dbSeek(xFilial("SC2")+&(cAliasQPR)->(QPR_OP)))
		SAH->(dbSeek(xFilial("SAH")+SC2->C2_UM))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Periodo                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText (STR0007+Replicate(".",15-Len(STR0007))+":", oReport:ROW(),020) //"Periodo"
		oReport:PrintText (Dtoc(mv_par11) + " - " + Dtoc(mv_par12), oReport:ROW(),370) //"FATORES DO IQS :"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
		oReport:SkipLine ( )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Ordem Producao                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText (AllTrim(TitSX3("QPR_OP")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_OP")[1])))+":", oReport:ROW(),020) 
		oReport:PrintText (&(cAliasQPR)->(QPR_OP), oReport:ROW(),370)  
		oReport:SkipLine ( )
					
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Produto                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText (AllTrim(TitSX3("QPR_PRODUT")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_PRODUT")[1])))+":", oReport:ROW(),020)  
		oReport:PrintText (AllTrim(&(cAliasQPR)->(QPR_PRODUT)) + "-" +AllTrim(QP6->QP6_DESCPO)+" - "+&(cAliasQPR)->(QPR_REVI), oReport:ROW(),370)  
		oReport:SkipLine ( )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Data Producao                                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:PrintText (AllTrim(TitSX3("QPR_DTENTR")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_DTENTR")[1])))+":", oReport:ROW(),020)  
		oReport:PrintText (DTOC(&(cAliasQPR)->(QPR_DTENTR)), oReport:ROW(),370)  
		oReport:SkipLine ( )
		
		oReport:PrintText (AllTrim(TitSX3("QPR_LOTE")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_LOTE")[1])))+":", oReport:ROW(),020)  
		oReport:PrintText (&(cAliasQPR)->(QPR_LOTE), oReport:ROW(),370)  
		
		If !Empty(&(cAliasQPR)->(QPR_NUMSER))                       
			oReport:PrintText ( AllTrim(TitSX3("QPR_NUMSER")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_NUMSER")[1])))+":", oReport:ROW(),1220)  
			oReport:PrintText (&(cAliasQPR)->(QPR_NUMSER), oReport:ROW(),1520)  
		EndIF
		oReport:SkipLine ( )

		oReport:PrintText (AllTrim(TitSX3("C2_QUANT")[1])+Replicate(".",15-Len(AllTrim(TitSX3("C2_QUANT")[1])))+":", oReport:ROW(),020)  
		oReport:PrintText (AllTrim(Str(SC2->C2_QUANT))+" "+SAH->AH_UMRES, oReport:ROW(),370)  
		oReport:SkipLine ( )

		If !Empty(mv_par13)
			dbSelectArea("SA1")
			dbSetOrder(1)
			If dbSeek(xFilial("SA1")+mv_par13+mv_par14)
				oReport:PrintText (AllTrim(TitSX3("A7_CLIENTE")[1])+Replicate(".",15-Len(AllTrim(TitSX3("A7_CLIENTE")[1])))+":", oReport:ROW(),020)  				//@Li,19 PSAY mv_par13 + " / " + mv_par14 + " - " + SA1->A1_NOME
				oReport:PrintText (mv_par13 + " / " + mv_par14 + " - " + SA1->A1_NOME, oReport:ROW(),370)  
				oReport:SkipLine ( )
			EndIf
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ N£mero de Rastreamento                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(&(cAliasQPR)->(QPR_RASTRE))
			oReport:PrintText ( AllTrim(TitSX3("QPR_RASTRE")[1])+": "+&(cAliasQPR)->(QPR_RASTRE), oReport:ROW(),370)  
			oReport:SkipLine ( )
		EndIf	
				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Laudo Producao                                               ³ 
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                               
		QPL->(dbSetOrder(3))
		If	QPL->(dbSeek(xFilial("QPL")+&(cAliasQPR)->(QPR_OP)+&(cAliasQPR)->(QPR_LOTE)+&(cAliasQPR)->(QPR_NUMSER)+&(cAliasQPR)->(QPR_ROTEIR)+Space(2)+Space(TamSX3("QPL_LABOR")[1])))
			QPD->(dbSeek(xFilial("QPD")+QPL->QPL_LAUDO))
			oReport:SkipLine ( )
			oReport:PrintText (STR0017 +QPL->QPL_LAUDO + " - " + QPD->QPD_DESCPO, oReport:ROW(),020) 	//"Laudo Producao: " 
			oReport:PrintText (STR0018 +Dtoc(QPL->QPL_DTLAUD)+"-"+QPL->QPL_HRLAUD, oReport:ROW(),800)  //"Data/Hora : "
			oReport:PrintText (STR0019 +Dtoc(QPL->QPL_DTVAL), oReport:ROW(),1200) //"Validade : " 
			oReport:SkipLine ( )
			If !Empty(QPL->QPL_JUSTLA)
				oReport:PrintText (AllTrim(TitSX3("QPL_JUSTLA")[1])+": "+QPL->QPL_JUSTLA, oReport:ROW(),270)  
				oReport:SkipLine ( )
			EndIf
		EndIf	

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define o Fator Conversao, se nao estiver definido             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If QP6->QP6_UNMED1 == SC2->C2_UM
			cFatCon := QP6->QP6_FATCO1
			cTipCon := QP6->QP6_TIPCO1
		ElseIf QP6->QP6_UNMED2 == SC2->C2_UM
			cFatCon := QP6->QP6_FATCO2
			cTipCon := QP6->QP6_TIPCO2
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o Tamanho da Amostra                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If Superval(cFatCon) <> 0
			cFatCon := StrTran(cFatcon,",",".")
			If cTipCon == "D"
				cTamAmo := Alltrim(Str(SC2->C2_QUANT / Superval(cFatCon)))
			Else
				cTamAmo := Alltrim(Str(SC2->C2_QUANT * Superval(cFatCon)))
			EndIf
		Else		
			cTamAmo := Alltrim(Str(SC2->C2_QUANT))
		EndIf
		
		lLinha := .T.	// Habilita a impressao da linha como separador 
	EndIf
	    
	If cOperac != &(cAliasQPR)->(QPR_OPERAC)
		cOperac := &(cAliasQPR)->(QPR_OPERAC)
		cLabor  := ""
		oReport:SkipLine ( )
		oReport:PrintText (STR0027+&(cAliasQPR)->(QPR_OPERAC)+" - "+RetDesOper(&(cAliasQPR)->(QPR_OP),&(cAliasQPR)->(QPR_OPERAC),&(cAliasQPR)->(QPR_PRODUT),&(cAliasQPR)->(QPR_REVI)), oReport:ROW(),020)  //"OPERACAO :"
		oReport:SkipLine ( )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Laudo da Operacao                                      	      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		QPM->(dbSetOrder(3))
		If	QPM->(dbSeek(xFilial("QPM")+&(cAliasQPR)->(QPR_OP)+&(cAliasQPR)->(QPR_LOTE)+&(cAliasQPR)->(QPR_NUMSER)+&(cAliasQPR)->(QPR_ROTEIR)+&(cAliasQPR)->(QPR_OPERAC)+&(cAliasQPR)->(QPR_LABOR)))
			If !Empty(QPM->QPM_LAUDO)
				QPD->(dbSetOrder(1))
				QPD->(dbSeek(xFilial("QPD")+QPM->QPM_LAUDO))
				oReport:PrintText (STR0029+QPM->QPM_LAUDO + " - " + QPD->QPD_DESCPO, oReport:ROW(),020)  //"Laudo da Operacao: "
				oReport:PrintText (STR0018 +Dtoc(QPM->QPM_DTLAUD)+"-"+QPM->QPM_HRLAUD, oReport:ROW(),300) //"Data/Hora : "
				oReport:SkipLine ( )
			EndIf
		EndIf
	EndIf

	If cLabor != &(cAliasQPR)->(QPR_LABOR)
		cLabor  := &(cAliasQPR)->(QPR_LABOR)
		cEnsaio := ""
		cDescLab := Tabela("Q2",&(cAliasQPR)->(QPR_LABOR))
		oSection2:Finish()  
		oSection2:Init()
		oReport:SkipLine ( )
		oReport:PrintText (STR0008 + &(cAliasQPR)->(QPR_LABOR) + " - " + cDescLab, oReport:ROW(),020)	//"Laboratorio : "	
		oReport:SkipLine ( )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Laudo do Laborat¢rio                                         	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
		QPL->(dbSetOrder(3))
		If	QPL->(dbSeek(xFilial("QPL")+&(cAliasQPR)->(QPR_OP)+&(cAliasQPR)->(QPR_LOTE)+&(cAliasQPR)->(QPR_NUMSER)+&(cAliasQPR)->(QPR_ROTEIR)+&(cAliasQPR)->(QPR_OPERAC)+&(cAliasQPR)->(QPR_LABOR)))
			QPD->(dbSeek(xFilial("QPD")+QPL->QPL_LAUDO))
			oReport:PrintText (STR0020+QPL->QPL_LAUDO + " - " + QPD->QPD_DESCPO, oReport:ROW(),020)//"Laudo Laboratorio : "
			oReport:PrintText (STR0018 +Dtoc(QPL->QPL_DTLAUD)+"-"+QPL->QPL_HRLAUD, oReport:ROW(),1000)//"Data/Hora : "
			oReport:SkipLine ( )
		EndIf			
	EndIf
	
	QP1->(dbSeek(xFilial("QP1")+&(cAliasQPR)->(QPR_ENSAIO)))  // Ensaios
	If cEnsaio  <> &(cAliasQPR)->(QPR_ENSAIO)
		cEnsaio  := &(cAliasQPR)->(QPR_ENSAIO)
	    lMedicao := .T.
		aQtdMed  := {}
		oSection2:Finish()  
		oSection2:Init()
	
		If QP1->QP1_TPCART <> "X"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ$
			//³Ensaios do tipo Dimencional - QP7                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ$
			dbSelectArea("QP7")
			QP7->(dbSeek(xFilial("QP7")+&(cAliasQPR)->(QPR_PRODUT)+&(cAliasQPR)->(QPR_REVI)+SC2->C2_ROTEIRO+&(cAliasQPR)->(QPR_OPERAC)+&(cAliasQPR)->(QPR_ENSAIO)))
			SAH->(dbSeek(xFilial("SAH")+QP7->QP7_UNIMED))
			oReport:SkipLine ( )
			oReport:PrintText (AllTrim(TitSX3("QPR_ENSAIO")[1])+": "+AllTrim(&(cAliasQPR)->(QPR_ENSAIO)) + " - " + QP1->QP1_DESCPO, oReport:ROW(),020)
			oReport:SkipLine ( )
			
			oReport:PrintText (AllTrim(TitSX3("QP7_UNIMED")[1])+": "+SAH->AH_UMRES, oReport:ROW(),020)
			oReport:PrintText (AllTrim(TitSX3("QP7_NOMINA")[1])+": "+QP7->QP7_NOMINA, oReport:ROW(),500)
			If QP7->QP7_MINMAX $ "1"
				oReport:PrintText (AllTrim(TitSX3("QP7_LIE")[1])+": "+QP7->QP7_LIE, oReport:ROW(),800)
				oReport:PrintText (AllTrim(TitSX3("QP7_LSE")[1])+": "+QP7->QP7_LSE, oReport:ROW(),1100)
			ElseIf QP7->QP7_MINMAX == "2"
				oReport:PrintText (AllTrim(TitSX3("QP7_LIE")[1])+": "+QP7->QP7_LIE, oReport:ROW(),800)
				oReport:PrintText (AllTrim(TitSX3("QP7_LSE")[1])+":  >>>", oReport:ROW(),1100)
			ElseIf QP7->QP7_MINMAX == "3"
				oReport:PrintText (AllTrim(TitSX3("QP7_LIE")[1])+":  <<<", oReport:ROW(),800)
				oReport:PrintText (AllTrim(TitSX3("QP7_LSE")[1])+": "+QP7->QP7_LSE, oReport:ROW(),1100)
			EndIf
			oReport:SkipLine ( )
		Else
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ$
			//³Ensaios do tipo Texto - QP8                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ$
			dbSelectArea("QP8")
			dbSeek(xFilial("QP8")+&(cAliasQPR)->(QPR_PRODUT)+&(cAliasQPR)->(QPR_REVI)+SC2->C2_ROTEIRO+&(cAliasQPR)->(QPR_OPERAC)+&(cAliasQPR)->(QPR_ENSAIO))
			oReport:SkipLine ( )
			oReport:PrintText (AllTrim(TitSX3("QP8_ENSAIO")[1])+" : "+AllTrim(&(cAliasQPR)->(QPR_ENSAIO)) + " - " + QP1->QP1_DESCPO, oReport:ROW(),020)
			oReport:SkipLine ( )
			oReport:PrintText (STR0009+QP8->QP8_TEXTO, oReport:ROW(),020) //"Texto : "
			oReport:SkipLine ( )
		EndIf	
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chave de ligacao com o QPT - Instr. Utiliz. nas Medicoes     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cChave := &(cAliasQPR)->(QPR_CHAVE)
	cMed   := ""
			
	dbSelectArea("QPT")
	QPT->(dbSeek(xFilial("QPT")+cChave))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta array com os instrumentos de acordo com a chave        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	
	While QPT->(!Eof()) .And. xFilial("QPT") ==QPT->QPT_FILIAL .And.QPT->QPT_CODMED == cChave
		Aadd(aInstr,QPT->QPT_INSTR)
		QPT->(dbSkip())
	EndDo

	If QP1->QP1_TPCART <> "X"
		dbSelectArea("QPS")
		If QPS->(dbSeek(xFilial("QPS")+cChave))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta array c/ os valores de medicoes mensur veis(QPS)    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While QPS->(!Eof()) .And. xFilial("QPS") ==	QPS->QPS_FILIAL .And. ;
																		QPS->QPS_CODMED == cChave
				cMed+=QPS->QPS_MEDICA+" "+IIF(QPS->QPS_INDMED=="P","%","")
				
				//Acumula as Medicoes referentes ao Ensaio 
				If Alltrim(QP1->QP1_CARTA)=="P"
					IIF(QPS->QPS_INDMED=="P",Aadd(aQtdMed,QPS_MEDICA),.t.) 	
				ElseIf Alltrim(QP1->QP1_CARTA)=="U"
					IF cCodMed == QPS_CODMED
						Aadd(aQtdMed,QPS_MEDICA)
					EndIF						
					cCodMed := QPS_CODMED
				Else
					Aadd(aQtdMed,QPS_MEDICA)
				EndIf	                 
				
				QPS->(dbSkip())
			EndDo
		EndIf
		Aadd(aResult,cMed)
	Else
		dbSelectArea("QPQ")
		If dbSeek(xFilial("QPQ")+cChave)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta array c/ os valores de medicoes (Texto) - QPQ       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While !Eof() .And. xFilial("QPQ") == QPQ->QPQ_FILIAL .And. ;
																QPQ->QPQ_CODMED == cChave
				Aadd(aResTXT,QPQ->QPQ_MEDICA)
				QPQ->(dbSkip())
			EndDo
		EndIf
	EndIf

	dbSelectArea("QPU") // Nao-Conformidades
	If QPU->(dbSeek(xFilial("QPU")+cChave))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se a medicao tem NC                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		While QPU->(!Eof()) .And. QPU->QPU_FILIAL == xFilial("QPU")	.And. ;
																	QPU->QPU_CODMED == cChave
			AADD(aNC,{QPU->QPU_NAOCON,QPU->QPU_NUMNC,QPU->QPU_CLASSE,;
														 QPU->QPU_DEMIQI,QPU->QPU_CHAVE})
			QPU->(dbSkip())
		EndDo
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ligacao da NC com a Cronica                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aNC) > 0
		For nNC := 1 To Len(aNC)
			dbSelectArea("QA2")
			cChNC := aNC[nNC,5]
			QA2->(dbSeek(xFilial("QA2")+"QIPA210C"+cChNC))
			While QA2->(!Eof()) .And. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE;
							 == xFilial("QA2")+"QIPA210C"+cChNC
				Aadd(aNCTxt,{StrTran(QA2->QA2_TEXTO, "\13\10", ""),nNC})
				QA2->(dbSkip())
			EndDo
		Next nNC	
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico o maior total entre Instrumentos e Nao Conformidades     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTotInstr := Len(aInstr)
	nTotnC    := Len(aNC)
	nTot 		 := IIf(nTotInstr>nTotnC,nTotInstr,nTotnC)
	If Len(aResult) > nTot // Medicoes > instrum. ou nao conformidades  
								  // nTot assume valor menor que 44
		nTot	:= IIf(!Empty(Subs(aResult[1],46,44)),2,1)
	EndIf
    
	oSection2:Cell("QPT_INSTR"):Hide()   
	oSection2:Cell("cQPR_ENSR"):Hide()   
	oSection2:Cell("QPR_DTMEDI"):Hide()   
	oSection2:Cell("QPR_HRMEDI"):Hide()   
	oSection2:Cell("QPR_AMOSTR"):Hide()   
	oSection2:Cell("cCarta"):Hide()   
	oSection2:Cell("cAR"):Hide()   
	oSection2:Cell("cNConf"):Hide()   
	oSection2:Cell("cNrConf"):Hide()   
	oSection2:Cell("cClasse"):Hide()   
	oSection2:Cell("cDIQI"):Hide()  

	lPrint := .F. 

    If lMedicao
	    If mv_par15 == 2
	       lMedicao := .F.
	    EndIf	

		If nTot <> 0 
			For nT := 1 to nTot
					
				If Len(aInstr) >= nT
					oSection2:Cell("QPT_INSTR"):SetValue(aInstr[nT]) 
					oSection2:Cell("QPT_INSTR"):Show()
					oSection2:Cell("cQPR_ENSR"):SetValue("")
  					oSection2:Cell("QPR_DTMEDI"):SetValue("")
					oSection2:Cell("QPR_HRMEDI"):SetValue("")
					oSection2:Cell("QPR_AMOSTR"):SetValue("")
					oSection2:Cell("cCarta"):SetValue("")
					oSection2:Cell("cAR"):SetValue("")
				EndIf
				
				If nT == 1
					QAA->(dbSeek(cFilAnt+&(cAliasQPR)->(QPR_ENSR)))
					oSection2:Cell("cQPR_ENSR"):SetValue(Substr(Alltrim(QAA->QAA_APELID),1,9))
  					oSection2:Cell("QPR_DTMEDI"):SetValue((cAliasQPR)->QPR_DTMEDI)
					oSection2:Cell("QPR_HRMEDI"):SetValue((cAliasQPR)->QPR_HRMEDI)
					oSection2:Cell("QPR_AMOSTR"):SetValue((cAliasQPR)->QPR_AMOSTR)

					oSection2:Cell("cQPR_ENSR"):Show()   
  					oSection2:Cell("QPR_DTMEDI"):Show()   
					oSection2:Cell("QPR_HRMEDI"):Show()   
					oSection2:Cell("QPR_AMOSTR"):Show() 
					lPrint := .T. 
				Else
				
				EndIf
				
				If QP1->QP1_CARTA $"XBR/XBS/XMR/HIS/IND"
					oSection2:Cell("cCarta"):cTitle := STR0010		//"Medicoes"
				ElseIf AllTrim(QP1->QP1_CARTA) == "U"
					oSection2:Cell("cCarta"):cTitle := STR0011		//"Amostra / Nao Conformidades p/ Unid"
				ElseIf AllTrim(QP1->QP1_CARTA) == "NP"
					oSection2:Cell("cCarta"):cTitle := STR0012		//"Nao Conformes"
				Elseif AllTrim(QP1->QP1_CARTA) == "C"
					oSection2:Cell("cCarta"):cTitle := STR0013		//"Nao Conformidades"
				ElseIf AllTrim(QP1->QP1_CARTA) == "P"
					oSection2:Cell("cCarta"):cTitle := STR0014		//"Amostra/Unid.Nao Conforme/Porc. Nao Corforme"
				EndIf
									
				If QP1->QP1_TPCART <> "X"
					If Len(aResult) > 0
						If nT == 1
							oSection2:Cell("cCarta"):SetValue( Subs(aResult[1],1,44))
							oSection2:Cell("cCarta"):Show()
						ElseIf nT == 2 .And. !Empty(Subs(aResult[1],46,44))
							oSection2:Cell("cCarta"):SetValue( Subs(aResult[1],46,44))
							oSection2:Cell("cCarta"):Show()
						EndIf
					EndIf
				Else
					If Len(aResTxt) >= nT
						oSection2:Cell("cCarta"):SetValue( Subs(aResTxt[nT],1,44))
						oSection2:Cell("cCarta"):Show()
					EndIf
				Endif
					
				If nT == 1
					oSection2:Cell("cAR"):SetValue((cAliasQPR)->(QPR_RESULT))
					oSection2:Cell("cAR"):Show()
				EndIf
					
				If Len(aNC) >= nT
					oSection2:Cell("cNConf"):Show()   
					oSection2:Cell("cNConf"):SetValue(aNC[nT,1])   

					oSection2:Cell("cNrConf"):Show()   
					oSection2:Cell("cNrConf"):SetValue(AllTrim(Str(aNC[nT,2])))

					oSection2:Cell("cClasse"):Show()   
					oSection2:Cell("cClasse"):SetValue(aNC[nT,3])  
					
					oSection2:Cell("cDIQI"):Show()   
					oSection2:Cell("cDIQI"):SetValue(aNC[nT,4] )   
				EndIf
				
				oSection2:PrintLine()	
					
				For nC:= 1 to Len(aNCTxt)
					If nT == aNCTxt[nC,2]
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Ser  impresso a "Cronica" somente na 1a. vez          ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If lCronica
							oReport:PrintText (STR0015+aNCTxt[nC,1], oReport:ROW(),1300) 	//"Cronica : "
							lCronica := .F.
						Else
							oReport:PrintText (aNCTxt[nC,1], oReport:ROW(),1435) 	//"Cronica : "
						EndIf
						oReport:SkipLine ( )
					EndIf
				Next nC
				lCronica := .T.
	
			Next nT
		Else
			QAA->(dbSeek(cFilAnt+&(cAliasQPR)->(QPR_ENSR)))
			oSection2:Cell("cQPR_ENSR"):SetValue(Substr(Alltrim(QAA->QAA_APELID),1,9))
			oSection2:Cell("QPR_DTMEDI"):SetValue((cAliasQPR)->QPR_DTMEDI)
			oSection2:Cell("QPR_HRMEDI"):SetValue((cAliasQPR)->QPR_HRMEDI)
			oSection2:Cell("QPR_AMOSTR"):SetValue((cAliasQPR)->QPR_AMOSTR)
		
			oSection2:Cell("cQPR_ENSR"):Show()   
  			oSection2:Cell("QPR_DTMEDI"):Show()   
			oSection2:Cell("QPR_HRMEDI"):Show()   
			oSection2:Cell("QPR_AMOSTR"):Show() 
			If QP1->QP1_TPCART <> "X"
				If Len(aResult) > 0
					For nR := 1 To 2   
						If QP1->QP1_CARTA $"XBR/XBS/XMR/HIS/IND"
							oSection2:Cell("cCarta"):cTitle := STR0010		//"Medicoes"
						ElseIf AllTrim(QP1->QP1_CARTA) == "U"
							oSection2:Cell("cCarta"):cTitle := STR0011		//"Amostra / Nao Conformidades p/ Unid"
						ElseIf AllTrim(QP1->QP1_CARTA) == "NP"
							oSection2:Cell("cCarta"):cTitle := STR0012		//"Nao Conformes"
						Elseif AllTrim(QP1->QP1_CARTA) == "C"
							oSection2:Cell("cCarta"):cTitle := STR0013		//"Nao Conformidades"
						ElseIf AllTrim(QP1->QP1_CARTA) == "P"
							oSection2:Cell("cCarta"):cTitle := STR0014		//"Amostra/Unid.Nao Conforme/Porc. Nao Corforme"
						EndIf
						If nR == 1
							oSection2:Cell("cCarta"):SetValue( Subs(aResult[1],1,44))
							oSection2:Cell("cCarta"):Show()
						ElseIf nR == 2 .And. !Empty(Subs(aResult[1],46,44))
							oSection2:Cell("cCarta"):SetValue( Subs(aResult[1],46,44))
							oSection2:Cell("cCarta"):Show()
						EndIF
					Next nR
				EndIf
			Else
				If Len(aResTxt) > 0
					oSection2:Cell("cCarta"):SetValue( Subs(aResTxt[1],1,44) )
					oSection2:Cell("cCarta"):Show()
				EndIf
			Endif
			oSection2:Cell("cAR"):SetValue( &(cAliasQPR)->(QPR_RESULT))
			oSection2:Cell("cAR"):Show() 

			oSection2:PrintLine()	
		EndIf
	    
	EndIf
	
	aInstr  := {}
	aResult := {}
	aResTxt := {}
	aNC     := {}
	aNCTxt  := {}
			
	//Armazena dados da Medicao 
	cProduto  := &(cAliasQPR)->(QPR_PRODUT)
	cRevisao  := &(cAliasQPR)->(QPR_REVI)
	cOperacao := &(cAliasQPR)->(QPR_OPERAC)
			
	&(cAliasQPR)->(dbSkip())  
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Exibe o Estudo do Plano de Amostragem						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCarta  := QPCarta(cEnsaio)
	cPlaAmo := If(cCarta<>"TXT",QP7->QP7_PLAMO,QP8->QP8_PLAMO)    
	
	If (cEnsaio <> &(cAliasQPR)->(QPR_ENSAIO) .or. cOp != &(cAliasQPR)->(QPR_OP)+&(cAliasQPR)->(QPR_LOTE)+&(cAliasQPR)->(QPR_NUMSER)) .And. !Empty(cPlaAmo) 
	
	
		QQH->(dbSetOrder(1))
		If QQH->(dbSeek(xFilial('QQH')+cProduto+cRevisao+SC2->C2_ROTEIRO+cOperacao+cEnsaio))
			cAmost := QQH->QQH_AMOST
			If cCarta <> "TXT"
				aPlano := QEP_RetAmostra(QP7->QP7_PLAMO,QQH->QQH_AMOST,QQH->QQH_NIVAMO,QQH->QQH_NQA,+Str(Int(Val(cTamAmo)),8),"QPK_TAMLOT",.F.)
			Else
				aPlano := QEP_RetAmostra(QP8->QP8_PLAMO,QQH->QQH_AMOST,QQH->QQH_NIVAMO,QQH->QQH_NQA,+Str(Int(Val(cTamAmo)),8),"QPK_TAMLOT",.F.)
			EndIf
		Else 
			cAmost := " "				
		EndIf
			
		cNorma := QA_Plano(cPlaAmo)
		       
		If cNorma == "NB5426"
			cNorma := "NBR-5426"
		ElseIf cNorma == "QS9000"
			cNorma := "QS-9000"
		ElseIf cNorma == "NB5429"
			cNorma := "NBR-5429"
		EndIf
					
		If cCarta <> "TXT" .And. cPlaAmo == "B"
			aNBR5429 := QA_Def5429(aQtdMed,SuperVal(QP7->QP7_LIE),SuperVal(QP7->QP7_LSE),QA_Plano(QP7->QP7_PLAMO),aPlano[1])		
		Else 
			aNBR5429 := Afill(Array(5),0)
		EndIf					
		       
		oSection3:Init()
		
		oSection3:Cell("cNorma"):Hide()   
		oSection3:Cell("cTP"):Hide()   
		oSection3:Cell("cPAmostra"):Hide()   
		oSection3:Cell("cPAceite"):Hide()   
		oSection3:Cell("cPRejeite"):Hide()   
		oSection3:Cell("cSAmostra"):Hide()   
		oSection3:Cell("cSAceite"):Hide()   
		oSection3:Cell("cSRejeite"):Hide()   
		oSection3:Cell("cNMedicoes"):Hide()   
		oSection3:Cell("cMedia"):Hide()   
		oSection3:Cell("cDesPad"):Hide()   
		oSection3:Cell("cPI"):Hide()   
		oSection3:Cell("cPS"):Hide()   
		oSection3:Cell("cResultado"):Hide()   
			
		If cPlaAmo == "T"   
	  		oSection3:Cell("cNorma"):Show()
			oSection3:Cell("cTP"):Show()   
	  		oSection3:Cell("cNorma"):SetValue(cNorma)
			If(cCarta<>"TXT")
				oSection3:Cell("cTP"):SetValue(QP7->QP7_DESPLA)
			Else
				oSection3:Cell("cTP"):SetValue(QP8->QP8_DESPLA)
			Endif
			
			oSection3:PrintLine()					
		Else
	  		oSection3:Cell("cNorma"):SetValue(cNorma)
	  		oSection3:Cell("cNorma"):Show()

		   	If cNorma == "INTERN"
				For nX := 1 to Len(aPlano)	     
					oSection3:Cell("cTP"):SetValue(aPlano[nX,7])   
					oSection3:Cell("cTP"):Show()   
					oSection3:Cell("cPAmostra"):SetValue(aPlano[nX,3])   
					oSection3:Cell("cPAmostra"):Show()   

					oSection3:Cell("cPAceite"):SetValue(aPlano[nX,1])   
					oSection3:Cell("cPAceite"):Show()   

					oSection3:Cell("cPRejeite"):SetValue(aPlano[nX,2])   
					oSection3:Cell("cPRejeite"):Show()   

					oSection3:Cell("cSAmostra"):SetValue(aPlano[nX,6])   
					oSection3:Cell("cSAmostra"):Show()   

					oSection3:Cell("cSAceite"):SetValue(aPlano[nX,4])   
					oSection3:Cell("cSAceite"):Show()   

					oSection3:Cell("cSRejeite"):SetValue(aPlano[nX,5])   
					oSection3:Cell("cSRejeite"):Show()   

					oSection3:Cell("cPAmostra"):SetPicture(PesqPict("QA7","QA7_AT_AMO")  )
					oSection3:Cell("cPAceite"):SetPicture(PesqPict("QA7","QA7_AT_ACE")  )
					oSection3:Cell("cPRejeite"):SetPicture(PesqPict("QA7","QA7_AT_REJ")   )
					oSection3:Cell("cSAmostra"):SetPicture(PesqPict("QA7","QA7_AT_AMO")  )
					oSection3:Cell("cSAceite"):SetPicture(PesqPict("QA7","QA7_AT_ACE")  )
					oSection3:Cell("cSRejeite"):SetPicture( PesqPict("QA7","QA7_AT_REJ") )
					oSection3:PrintLine()			
				Next nX                             

			Else
				oSection3:Cell("cTP"):SetValue(cAmost)   
				oSection3:Cell("cTP"):Show()   

				oSection3:Cell("cPAmostra"):SetValue(aPlano[1])   
				oSection3:Cell("cPAmostra"):Show()   

				oSection3:Cell("cPAceite"):SetValue(aPlano[2])   
				oSection3:Cell("cPAceite"):Show()   

				oSection3:Cell("cPRejeite"):SetValue(aPlano[3])   
				oSection3:Cell("cPRejeite"):Show()   

				oSection3:Cell("cSAmostra"):SetValue(aPlano[4])   
				oSection3:Cell("cSAmostra"):Show()   

				oSection3:Cell("cSAceite"):SetValue(aPlano[5])   
				oSection3:Cell("cSAceite"):Show()   

				If len(aPlano) >= 6
					oSection3:Cell("cSRejeite"):SetValue(aPlano[6])   
				Else
					oSection3:Cell("cSRejeite"):SetValue("")   					
				Endif	
				oSection3:Cell("cSRejeite"):Show()   
				
				oSection3:Cell("cNMedicoes"):SetValue(Transf(Len(aQtdMed),"@E 999999")) //Numero de Medições  
				oSection3:Cell("cNMedicoes"):Show()   

				oSection3:Cell("cMedia"):SetValue(aNBR5429[1]) //Media   
				oSection3:Cell("cMedia"):Show()   

				oSection3:Cell("cDesPad"):SetValue(aNBR5429[2] ) //Desvio Padrao  
				oSection3:Cell("cDesPad"):Show()   

				oSection3:Cell("cPI"):SetValue(Transf(aNBR5429[3],"@E 99.99")) //PI    
				oSection3:Cell("cPI"):Show()   

				oSection3:Cell("cPS"):SetValue(Transf(aNBR5429[4],"@E 99.99"))  //PS 	 
				oSection3:Cell("cPS"):Show()   

				oSection3:Cell("cResultado"):SetValue(Transf(aNBR5429[5],"@E 999.99"))  //PI+PS			
				oSection3:Cell("cResultado"):Show()   

				oSection3:Cell("cPAmostra"):SetPicture(PesqPict("QA7","QA7_AT_AMO")  )
				oSection3:Cell("cPAceite"):SetPicture(PesqPict("QA7","QA7_AT_ACE")  )
				oSection3:Cell("cPRejeite"):SetPicture(PesqPict("QA7","QA7_AT_REJ")   )
				oSection3:Cell("cSAmostra"):SetPicture(PesqPict("QA7","QA7_AT_AMO")  )
				oSection3:Cell("cSAceite"):SetPicture(PesqPict("QA7","QA7_AT_ACE")  )
				oSection3:Cell("cSRejeite"):SetPicture( PesqPict("QA7","QA7_AT_REJ") )
				
				oSection3:PrintLine()					
			EndIF  
			
		EndIF	                    
		oSection3:Finish()
	EndIF
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIPR060R3³ Autor ³ Antonio Aurelio       ³ Data ³ 19.08.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resultados                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QIPR060()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo Pim.³26/03/01³------³Inclusao da impressao grafica no relatorio³±±
±±³Aldo Marini ³19/03/02³012266³Alterado para considerar o Filtro padrao  ³±±
±±³            ³        ³      ³da SetPrint junto com a IndRegua.         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/    
User Function Qipr060R3()

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Par„metros para a fun‡„o SetPrint () ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   := "QIPR060"
Local cString := "QPR"
Local cDesc1  := STR0001     //"Neste relat¢rio ser„o impressos os resultados obtidos na inspe‡„o"
Local cDesc2  := STR0002     //"da Produ‡„o."
Local cDesc3  := ""
Local aSetOrders := {}
// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Par„metros para a fun‡„o Cabec()  ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cTitulo 	 := STR0003	//"Resultados"
Local cRelatorio := "QIPR060"
Local nX         := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas pela fun‡„o SetDefault () ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0004, 1,STR0005,  1, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private nLastKey := 0 
Private nTamanho := "M"
Private cPerg    := "QPR060"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01           //  Do  Produto ?             	         ³
//³ mv_par02           //  At‚ Produto ?                         ³
//³ mv_par03           //  Da  RevisÆo ?                         ³
//³ mv_par04           //  At‚ RevisÆo ?                         ³
//³ mv_par05           //  Da  Ordem Producao ?                  ³
//³ mv_par06           //  Do  Lote			  ?                  ³
//³ mv_par07           //  Do  Numero de Serie ?                 ³
//³ mv_par08           //  At‚ Data de Producao ?                ³
//³ mv_par09           //  Ate Lote ?                            ³
//³ mv_par10           //  Ate Numero de Serie ?                 ³
//³ mv_par11           //  Da Data Producao ?                    ³
//³ mv_par12           //  Ate Data de Producao ?                ³
//³ mv_par13           //  Cliente ?                             ³
//³ mv_par14           //  Loja ?                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)

Default mv_par11 := dDatabase
Default mv_par12 := dDatabase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,ctitulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,nTamanho)

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Arquivos e seleciona Ordens.                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSetOrders := {	{"SA2",0},{"SC2",0},{"QP6",0},{"QPD",0},{"QPL",0},{"QPT",0},{"QP7",0},;
				{"QP8",0},{"QPU",0},{"QA2",0},{"QAA",0},{"QP1",0},{"SAH",0},{"SX3",0}}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Obs.: Especificamente neste caso todos os SetOrders vao para 1  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To Len(aSetOrders)
	dbSelectArea(aSetOrders[nX][1])
	aSetOrders[nX][2] := IndexOrd()
	dbSetOrder(1)
Next

RptStatus({|lEnd| A060Imp(@lEnd,wnRel,cString,ctitulo,cRelatorio)},ctitulo)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A040Imp  ³ Autor ³ Marcelo Pimentel      ³ Data ³ 31.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡Æo dos Resultados                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ A040Imp(lEnd,wnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A060Imp(lEnd,wnRel,cString,cTitulo,cRelatorio)
Local oTempTable	:= NIL
Local cDescLab	:= ""
Local cLabor		:= ""
Local aInstr		:= {}
Local aResult		:= {}
Local aNC			:= {}
Local cChave 		:= ""
Local aResTXT		:= {}
Local nTotInstr		:= 0
Local nTotnC		:= 0
Local nTot			:= 0
Local cMed			:= ""
Local nR			:= 0
Local nX			:= 0
Local aNCTxt		:= {}
Local cChNC			:= ""
Local cEnsaio		:= ""
Local cbCont		:= 00
Local cArqTemp		:= ""
Local cDat			:= ""
Local lCronica		:= .T.
Local cOperac		:= ""
Local cOP			:= ""
Local aCampos		:= {}
Local aCamposAux	:= {}
Local CbTxt
Local cCabNor1      := "              PRIMEIRA                   SEGUNDA                   NUMERO                  DESVIO"
Local cCabNor2      := "NORMA     TP  AMOSTRA   ACEITE  REJEITE  AMOSTRA  ACEITE  REJEITE  MEDICOES  MEDIA         PADRAO          PI     PS  RESULTADO"
Local lMedicao
Local cNorma
Local aNBR5429      := {}              
Local aQtdMed       := {}
Local cCarta        := " "
Local aPlano        := {}
Local cAmost        := " "
Local cFatcon	    := ""
Local cTipCon	    := ""
Local cTamAmo       := ""
Local cCodMed       := ""
Local nNC           := 0
Local nC            := 0
Local nT            := 0     
Local cCpoAux	    := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private li			:= 80
Private m_pag		:= 1

Private Titulo 	 := cTitulo
Private Cabec1 	 := ""
Private Cabec2	 := ""
Private	nomeprog := "QIPR060"
Private cTamanho := "M"
Private nTipo	 := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa os codigos de caracter Comprimido/Normal da impressora ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo de Trabalho - ( TRB )                  		 ³
//³ Todos os campos sao caracter ou data, por isso               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCamposAux := {	"QPR_FILIAL","QPR_PRODUT","QPR_REVI","QPR_OP","QPR_OPERAC","QPR_DTENTR",	;
				"QPR_LOTE","QPR_RASTRE","QPR_LABOR","QPR_ENSAIO","QPR_DTMEDI","QPR_HRMEDI",	;
				"QPR_AMOSTR","QPR_ENSR","QPR_RESULT","QPR_CHAVE","QPR_NUMSER","QPR_ROTEIR"}

For nX := 1 To Len(aCamposAux)
	cCpoAux	:= GetSx3Cache(aCamposAux[nX], "X3_CAMPO")
	If !Empty(cCpoAux)
		AADD(aCampos,{ "TRB" + Subs(cCpoAux,4,Len(cCpoAux) - 3), GetSx3Cache(cCpoAux, "X3_TIPO"), GetSx3Cache(cCpoAux, "X3_TAMANHO"), GetSx3Cache(cCpoAux, "X3_DECIMAL") })
	EndIf
Next

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"TRB_FILIAL"} )
oTempTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Funcao para gerar arquivo de Trabalho             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GeraTrab(aCampos)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa vari vel para controlar cursor de progress„o      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRB")

If BOF() .and. EOF()
	HELP(" ",1,"RECNO")
	
	oTempTable:Delete()
	dbSelectArea("QPR")
	Set Filter To
	Return .T.
EndIf

SetRegua(TRB->(LastRec()))

TRB->(dbGoTop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Neste Loop eh feito o processamento das operacoes vinculadas ³
//³ as ordens de Prod. Ainda sÆo tratados os laborat¢rios        ³
//³ seus ensaios, medi‡äes, nÆo conformidade e Instrumentos.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While TRB->(!Eof())
	dbSelectArea("TRB")	
	IncRegua()
	If lEnd
		@ PRow()+1,001 PSay OemToAnsi(STR0006)	//"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	
	If cOp != TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza todos os itens que sÆo impressos neste cabe‡alho    ³
		//³  para fazer o controle                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOp     := TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER
		cOperac := ""
		cLabor  := ""
		cDat    := Dtos(TRB->TRB_DTENTR)+TRB->TRB_LOTE
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia uma pag. nova para cada OP                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)

		R060CabOp()		// Habilita a impressao do Ensaio

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define o Fator Conversao, se nao estiver definido             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If QP6->QP6_UNMED1 == SC2->C2_UM
			cFatCon := QP6->QP6_FATCO1
			cTipCon := QP6->QP6_TIPCO1
		ElseIf QP6->QP6_UNMED2 == SC2->C2_UM
			cFatCon := QP6->QP6_FATCO2
			cTipCon := QP6->QP6_TIPCO2
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o Tamanho da Amostra                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If Superval(cFatCon) <> 0
			cFatCon := StrTran(cFatcon,",",".")
			If cTipCon == "D"
				cTamAmo := Alltrim(Str(SC2->C2_QUANT / Superval(cFatCon)))
			Else
				cTamAmo := Alltrim(Str(SC2->C2_QUANT * Superval(cFatCon)))
			EndIf
		Else		
			cTamAmo := Alltrim(Str(SC2->C2_QUANT))
		EndIf
		
		lLinha := .T.	// Habilita a impressao da linha como separador 
	EndIf

	If cOperac != TRB->TRB_OPERAC
		cOperac := TRB->TRB_OPERAC
		cLabor  := ""
		Li++
		@Li,001 PSAY STR0027+TRB->TRB_OPERAC+" - "+RetDesOper(TRB->TRB_OP,TRB->TRB_OPERAC,TRB->TRB_PRODUT,TRB->TRB_REVI)	//"OPERACAO :"
		Li++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Laudo da Operacao                                      	      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		QPM->(dbSetOrder(3))
		If	QPM->(dbSeek(xFilial("QPM")+TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER+TRB->TRB_ROTEIR+TRB->TRB_OPERAC+TRB->TRB_LABOR))
			If !Empty(QPM->QPM_LAUDO)
				QPD->(dbSetOrder(1))
				QPD->(dbSeek(xFilial("QPD")+QPM->QPM_LAUDO))
				@Li,01 PSAY STR0029+QPM->QPM_LAUDO + " - " + QPD->QPD_DESCPO //"Laudo da Operacao: "
				@Li,81 PSAY STR0018 +Dtoc(QPM->QPM_DTLAUD)+"-"+QPM->QPM_HRLAUD		//"Data/Hora : "
				Li++
			EndIf
		EndIf
	EndIf

	If li > 55
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
	EndIf	
		
	If cLabor != TRB->TRB_LABOR
		cLabor  := TRB->TRB_LABOR
		cEnsaio := ""
		cDescLab := Tabela("Q2",TRB->TRB_LABOR)
		If li > 55
			Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
		EndIf
		Li++
		@Li, 001 PSAY STR0008 + TRB->TRB_LABOR + " - " + cDescLab		//"Laboratorio : "
		Li++

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Laudo do Laborat¢rio                                         	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
		QPL->(dbSetOrder(3))
		If	QPL->(dbSeek(xFilial("QPL")+TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER+TRB->TRB_ROTEIR+TRB->TRB_OPERAC+TRB->TRB_LABOR))
			QPD->(dbSeek(xFilial("QPD")+QPL->QPL_LAUDO))
			@Li,01 PSAY STR0020+QPL->QPL_LAUDO + " - " + QPD->QPD_DESCPO		//"Laudo Laboratorio : "
			@Li,81 PSAY STR0018 +Dtoc(QPL->QPL_DTLAUD)+"-"+QPL->QPL_HRLAUD		//"Data/Hora : "
			Li++
		EndIf			
	EndIf
			
	If li > 55
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
	EndIf 
	QP1->(dbSeek(xFilial("QP1")+TRB->TRB_ENSAIO))  // Ensaios
	If cEnsaio  <> TRB->TRB_ENSAIO
		cEnsaio  := TRB->TRB_ENSAIO
	    lMedicao := .T.
		aQtdMed  := {}

		If QP1->QP1_TPCART <> "X"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cab das medicoes relacionadas com este Ensaio                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			// Ensaio: XX - XXXXXXXXXXXXXXXXXXXXXXXXXXX
			// Un.Media: XXX              Nominal: 999999        LIE: 999999         LSE: 999999
			dbSelectArea("QP7")
			QP7->(dbSeek(xFilial("QP7")+TRB->TRB_PRODUT+TRB->TRB_REVI+SC2->C2_ROTEIRO+TRB->TRB_OPERAC+TRB->TRB_ENSAIO))
			SAH->(dbSeek(xFilial("SAH")+QP7->QP7_UNIMED))
			Li++
			@Li,01 PSAY AllTrim(TitSX3("QPR_ENSAIO")[1])+": "+AllTrim(TRB->TRB_ENSAIO) + " - " + QP1->QP1_DESCPO
			Li++
			
			@Li,01 PSAY AllTrim(TitSX3("QP7_UNIMED")[1])+": "+SAH->AH_UMRES
			@Li,27 PSAY AllTrim(TitSX3("QP7_NOMINA")[1])+": "+QP7->QP7_NOMINA
			If QP7->QP7_MINMAX $ "1"
				@Li,50 PSAY AllTrim(TitSX3("QP7_LIE")[1])+": "+QP7->QP7_LIE
				@Li,69 PSAY AllTrim(TitSX3("QP7_LSE")[1])+": "+QP7->QP7_LSE
			ElseIf QP7->QP7_MINMAX == "2"
				@Li,50 PSAY AllTrim(TitSX3("QP7_LIE")[1])+": "+QP7->QP7_LIE
				@Li,69 PSAY AllTrim(TitSX3("QP7_LSE")[1])+":  >>>"
			ElseIf QP7->QP7_MINMAX == "3"
				@Li,50 PSAY AllTrim(TitSX3("QP7_LIE")[1])+":  <<<"
				@Li,69 PSAY AllTrim(TitSX3("QP7_LSE")[1])+": "+QP7->QP7_LSE
			EndIf
			Li++
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Medicoes tipo TXT relacionadas com este Ensaio               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
			// Ensaio: XX - XXXXXXXXXXXXXXXXXXXXXXXXXXX
			// Texto: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX      
			If li > 55
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			EndIf
			dbSelectArea("QP8")
			dbSeek(xFilial("QP8")+TRB->TRB_PRODUT+TRB->TRB_REVI+SC2->C2_ROTEIRO+TRB->TRB_OPERAC+TRB->TRB_ENSAIO)
			Li++
			@Li,01 PSAY AllTrim(TitSX3("QP8_ENSAIO")[1])+" : "+AllTrim(TRB->TRB_ENSAIO) + " - " + QP1->QP1_DESCPO
			Li++
			@Li,01 PSAY STR0009+QP8->QP8_TEXTO		//"Texto : "
			Li++
		EndIf	
		If li > 55
			Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cabe‡alho das Medicoes                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R060ResCab(Li)  
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chave de ligacao com o QPT - Instr. Utiliz. nas Medicoes     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cChave := TRB->TRB_CHAVE
	cMed   := ""
			
	dbSelectArea("QPT")
	QPT->(dbSeek(xFilial("QPT")+cChave))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta array com os instrumentos de acordo com a chave        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While QPT->(!Eof()) .And. xFilial("QPT") ==QPT->QPT_FILIAL .And.QPT->QPT_CODMED == cChave
		Aadd(aInstr,QPT->QPT_INSTR)
		QPT->(dbSkip())
	EndDo

	If QP1->QP1_TPCART <> "X"
		dbSelectArea("QPS")
		If QPS->(dbSeek(xFilial("QPS")+cChave))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta array c/ os valores de medicoes mensur veis(QPS)    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While QPS->(!Eof()) .And. xFilial("QPS") ==	QPS->QPS_FILIAL .And. ;
																		QPS->QPS_CODMED == cChave
				cMed+=QPS->QPS_MEDICA+" "+IIF(QPS->QPS_INDMED=="P","%","")
				
				//Acumula as Medicoes referentes ao Ensaio 
				If Alltrim(QP1->QP1_CARTA)=="P"
					IIF(QPS->QPS_INDMED=="P",Aadd(aQtdMed,QPS_MEDICA),.t.) 	
				ElseIf Alltrim(QP1->QP1_CARTA)=="U"
					IF cCodMed == QPS_CODMED
						Aadd(aQtdMed,QPS_MEDICA)
					EndIF						
					cCodMed := QPS_CODMED
				Else
					Aadd(aQtdMed,QPS_MEDICA)
				EndIf	                 
				
				QPS->(dbSkip())
			EndDo
		EndIf
		Aadd(aResult,cMed)
	Else
		dbSelectArea("QPQ")
		If dbSeek(xFilial("QPQ")+cChave)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta array c/ os valores de medicoes (Texto) - QPQ       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While !Eof() .And. xFilial("QPQ") == QPQ->QPQ_FILIAL .And. ;
																QPQ->QPQ_CODMED == cChave
				Aadd(aResTXT,QPQ->QPQ_MEDICA)
				QPQ->(dbSkip())
			EndDo
		EndIf
	EndIf

	dbSelectArea("QPU") // Nao-Conformidades
	If QPU->(dbSeek(xFilial("QPU")+cChave))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se a medicao tem NC                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		While QPU->(!Eof()) .And. QPU->QPU_FILIAL == xFilial("QPU")	.And. ;
																	QPU->QPU_CODMED == cChave
			AADD(aNC,{QPU->QPU_NAOCON,QPU->QPU_NUMNC,QPU->QPU_CLASSE,;
														 QPU->QPU_DEMIQI,QPU->QPU_CHAVE})
			QPU->(dbSkip())
		EndDo
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ligacao da NC com a Cronica                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aNC) > 0
		For nNC := 1 To Len(aNC)
			dbSelectArea("QA2")
			cChNC := aNC[nNC,5]
			QA2->(dbSeek(xFilial("QA2")+"QIPA210C"+cChNC))
			While QA2->(!Eof()) .And. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE;
							 == xFilial("QA2")+"QIPA210C"+cChNC
				Aadd(aNCTxt,{StrTran(QA2->QA2_TEXTO, "\13\10", ""),nNC})
				QA2->(dbSkip())
			EndDo
		Next nNC	
	EndIf

	If li > 55
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
		R060ResCab(Li)
	ElseIf Li == 6
		R060ResCab(Li)			
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico o maior total entre Instrumentos e Nao Conformidades     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTotInstr := Len(aInstr)
	nTotnC    := Len(aNC)
	nTot 		 := IIf(nTotInstr>nTotnC,nTotInstr,nTotnC)
	If Len(aResult) > nTot // Medicoes > instrum. ou nao conformidades  
								  // nTot assume valor menor que 44
		nTot	:= IIf(!Empty(Subs(aResult[1],46,44)),2,1)
	EndIf
		
    If lMedicao
	    If mv_par15 == 2
	       lMedicao := .F.
	    EndIf	

		If nTot <> 0 
			For nT := 1 to nTot
					
				If Len(aInstr) >= nT
					@Li,001 PSAY aInstr[nT]
				EndIf
					
				If nT == 1
					QAA->(dbSeek(cFilAnt+TRB->TRB_ENSR))
					@Li,018 PSAY Substr(QAA->QAA_APELID,1,9)
					@Li,028 PSAY Substr(Dtos(TRB->TRB_DTMEDI),7,2)+"/"+Substr(Dtos(TRB->TRB_DTMEDI),5,2)+"/"+Substr(Dtos(TRB->TRB_DTMEDI),3,2)
					@Li,040 PSAY TRB->TRB_HRMEDI
					@Li,050 PSAY AllTrim(Str(TRB->TRB_AMOSTR))
				EndIf
					
				If QP1->QP1_TPCART <> "X"
					If Len(aResult) > 0
						If nT == 1
							@Li,052 PSAY Subs(aResult[1],1,44)
						ElseIf nT == 2 .And. !Empty(Subs(aResult[1],46,44))
							@Li,052 PSAY Subs(aResult[1],46,44)
						EndIf
					EndIf
				Else
					If Len(aResTxt) >= nT
						@Li,054 PSAY Subs(aResTxt[nT],1,44)
					EndIf
				Endif
					
				If nT == 1
					@Li,100 PSAY TRB->TRB_RESULT
				EndIf
					
				If Len(aNC) >= nT
					@Li,103 PSAY	aNC[nT,1]
					@Li,112 PSAY	AllTrim(Str(aNC[nT,2]))
					@Li,122 PSAY	aNC[nT,3]
					@Li,129 PSAY	aNC[nT,4]
				EndIf
				Li++
				If li > 55
					Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
					If nT <> nTot
						R060ResCab(Li)
					EndIf
				EndIf	
					
				For nC:= 1 to Len(aNCTxt)
					If nT == aNCTxt[nC,2]
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Ser  impresso a "Cronica" somente na 1a. vez          ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If lCronica
							@Li,045 PSAY STR0015+aNCTxt[nC,1]	//"Cronica : "
							lCronica := .F.
						Else
							@Li,055 PSAY aNCTxt[nC,1]
						EndIf
						Li++
						If li > 55
							Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
							R060ResCab(Li)
						EndIf
					EndIf
				Next nC
				lCronica := .T.
	
			Next nT
		Else
			QAA->(dbSeek(cFilAnt+TRB->TRB_ENSR))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lay-Out do Ensaio se a carta do ensaio for <> TXT            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//
			//Instrumento      Ensaiador Data Med   Hora Med Am. Medicoes                                     A/R Nao Conf Nr NCs Classe Dem.IQI
			//---------------- --------- ---------- -------- --- -------------------------------------------- --- -------- ------ ------ -------
			//XXXXXXXXXXXXXXXX XXXXXXXX  XX/XX/XXXX  XX:XX    X  XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX  X  XXXXXX   XXXXX     X      S
			//          1	       2         3         4         5         6         7         8         9         10        11        12        13
			//123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		
			IncRegua()
		
			@Li,018 PSAY Substr(QAA->QAA_APELID,1,9)
			@Li,028 PSAY Substr(Dtos(TRB->TRB_DTMEDI),7,2)+"/"+Substr(Dtos(TRB->TRB_DTMEDI),5,2)+"/"+Substr(Dtos(TRB->TRB_DTMEDI),3,2)
			@Li,040 PSAY TRB->TRB_HRMEDI
			@Li,049 PSAY AllTrim(Str(TRB->TRB_AMOSTR))
			If QP1->QP1_TPCART <> "X"
				If Len(aResult) > 0
					For nR := 1 To 2
						If nR == 1
							@Li,052 PSAY Subs(aResult[1],1,44)
							@Li,098 PSAY TRB->TRB_RESULT
						ElseIf nR == 2 .And. !Empty(Subs(aResult[1],46,44))
							@Li,052 PSAY Subs(aResult[1],46,44)
						EndIf
						Li++
					Next nR
				EndIf
			Else
				If Len(aResTxt) > 0
					@Li,052 PSAY Subs(aResTxt[1],1,44)
					@Li,98 PSAY TRB->TRB_RESULT
					Li++
				EndIf
			Endif
		EndIf
	    
	EndIf
	
	aInstr  := {}
	aResult := {}
	aResTxt := {}
	aNC     := {}
	aNCTxt  := {}
			
	//Armazena dados da Medicao 
	cProduto  := TRB->TRB_PRODUT
	cRevisao  := TRB->TRB_REVI
	cOperacao := TRB->TRB_OPERAC
			
	dbSelectArea("TRB")
	dbSkip()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Exibe o Estudo do Plano de Amostragem						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCarta  := QPCarta(cEnsaio)
	cPlaAmo := If(cCarta<>"TXT",QP7->QP7_PLAMO,QP8->QP8_PLAMO)    
	
	If (cEnsaio <> TRB->TRB_ENSAIO .or. cOp != TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER) .And. !Empty(cPlaAmo) 
	
	
		QQH->(dbSetOrder(1))
		If QQH->(dbSeek(xFilial('QQH')+cProduto+cRevisao+SC2->C2_ROTEIRO+cOperacao+cEnsaio))
			cAmost := QQH->QQH_AMOST
			If cCarta <> "TXT"
				aPlano := QEP_RetAmostra(QP7->QP7_PLAMO,QQH->QQH_AMOST,QQH->QQH_NIVAMO,QQH->QQH_NQA,+Str(Int(Val(cTamAmo)),8),"QPK_TAMLOT",.F.)
			Else
				aPlano := QEP_RetAmostra(QP8->QP8_PLAMO,QQH->QQH_AMOST,QQH->QQH_NIVAMO,QQH->QQH_NQA,+Str(Int(Val(cTamAmo)),8),"QPK_TAMLOT",.F.)
			EndIf
		Else 
			cAmost := " "				
		EndIf
					
		cNorma := QA_Plano(cPlaAmo)
		       
		If cNorma == "NB5426"
			cNorma := "NBR-5426"
		ElseIf cNorma == "QS9000"
			cNorma := "QS-9000"
		ElseIf cNorma == "NB5429"
			cNorma := "NBR-5429"
		EndIf
					
		If cCarta <> "TXT" .And. cPlaAmo == "B"
			aNBR5429 := QA_Def5429(aQtdMed,SuperVal(QP7->QP7_LIE),SuperVal(QP7->QP7_LSE),QA_Plano(QP7->QP7_PLAMO),aPlano[1])		
		Else 
			aNBR5429 := Afill(Array(5),0)
		EndIf					
				
		If li > 50
			Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			R060ResCab(Li)
		EndIf			
				
		Li+=2	
		@ Li,00 PSAY cCabNor1
		Li++
		@ Li,00 PSAY cCabNor2
		Li++
		@ Li,00 PSAY Repl('=',132)
		Li++
	    
		If cPlaAmo == "T"   
			@ LI,000 PSAY cNorma
			@ LI,010 PSAY If(cCarta<>"TXT",QP7->QP7_DESPLA,QP8->QP8_DESPLA)
		Else
			@ LI,000 PSAY cNorma
		   	If cNorma == "INTERN"
				For nX := 1 to Len(aPlano)	     
					@ LI,010 PSAY aPlano[nX,7]
					@ LI,015 PSAY aPlano[nX,3] Picture PesqPict("QA7","QA7_AT_AMO")
					@ LI,023 PSAY aPlano[nX,1] Picture PesqPict("QA7","QA7_AT_ACE")
					@ LI,032 PSAY aPlano[nX,2] Picture PesqPict("QA7","QA7_AT_REJ") 
					@ LI,042 PSAY aPlano[nX,6] Picture PesqPict("QA7","QA7_AT_AMO")
					@ LI,049 PSAY aPlano[nX,4] Picture PesqPict("QA7","QA7_AT_ACE")
					@ LI,058 PSAY aPlano[nX,5] Picture PesqPict("QA7","QA7_AT_REJ") 
					Li++					
				Next nX
			Else
				@ LI,010 PSAY cAmost
	
				@ LI,015 PSAY aPlano[1] Picture PesqPict("QA7","QA7_AT_AMO")
				@ LI,023 PSAY aPlano[2] Picture PesqPict("QA7","QA7_AT_ACE")
				@ LI,032 PSAY aPlano[3] Picture PesqPict("QA7","QA7_AT_REJ") 
				@ LI,042 PSAY aPlano[4] Picture PesqPict("QA7","QA7_AT_AMO")
				@ LI,049 PSAY aPlano[5] Picture PesqPict("QA7","QA7_AT_ACE")
				If len(aPlano) >= 6
					@ LI,058 PSAY aPlano[6] Picture PesqPict("QA7","QA7_AT_REJ") 
				Else
					@ LI,058 PSAY "" 					
				Endif	
				
				@ LI,069 PSAY Transf(Len(aQtdMed),"@E 999999")  			
				@ LI,077 PSAY aNBR5429[1] 					  //Media 			
				@ LI,091 PSAY aNBR5429[2]                     //Desvio Padrao    
				@ LI,104 PSAY Transf(aNBR5429[3],"@E 99.99")  //PI   			
				@ LI,111 PSAY Transf(aNBR5429[4],"@E 99.99")  //PS 	
				@ LI,117 PSAY Transf(aNBR5429[5],"@E 999.99") //PI+PS			
				Li++
			EndIF
			
		EndIF
		Li++
		
	EndIf					
		
	dbSelectArea("TRB")
	
EndDo

If Li != 80
	roda(CbCont,cbtxt)
EnDif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice e o arquivo de trabalho                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTempTable:Delete()
dbSelectArea("QPR")
Set Filter To
dbSetOrder(1)

Set device to Screen
If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()
Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GeraTrab  ³ Autor ³ Marcelo Pimentel      ³ Data ³ 02.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo de Trabalho                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GeraTrab()                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GeraTrab(aCampos)

Local cKey		:= ""	
Local cNomArq	:= ""
Local nIndex	:= 0
Local cCond		:= ''
dbSelectArea("QPR")
dbSetOrder(8)

If !Empty(dbFilter())
	cCond	:= dbFilter()+'.And.'
Endif

cCond	+= 'QPR_PRODUT>="'+mv_par01+'" .And.QPR_PRODUT<="'+mv_par02+'"'
cCond	+= '.And.QPR_REVI>="'+mv_par03+'" .And.QPR_REVI<="'+mv_par04+'"'
cCond	+= '.And.QPR_OP>="'+mv_par05+'" .And.QPR_OP<="'+mv_par08+'"'
cCond	+= '.And.QPR_LOTE>="'+mv_par06+'" .And.QPR_LOTE<="'+mv_par09+'"'
cCond	+= '.And.QPR_NUMSER>="'+mv_par07+'" .And.QPR_NUMSER<="'+mv_par10+'"'
cCond	+= '.And.DTOS(QPR_DTENTR)>="'+DTOS(mv_par11)+'".And.DTOS(QPR_DTENTR)<="'+DTOS(mv_par12)+'"'
cKey	:= IndexKey()
cNomArq	:= CriaTrab(NIL,.F.)
IndRegua("QPR",cNomArq,cKey,,cCond,STR0016)		//"Selecionando Registros..."
nIndex := RetIndex("QPR")
dbSelectArea("QPR")
dbSetOrder(nIndex+1)
SetRegua(RecCount())
dbGoTop()
While QPR->(!Eof()) .And. xFilial("QPR") == QPR->QPR_FILIAL .And. ;
	QPR->QPR_LOTE <= mv_par09 .And.QPR->QPR_NUMSER <= mv_par10

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe a amarracao do Produto x Cliente - QQ7     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(mv_par13)
		If SC2->(dbSeek(xFilial("SC2")+QPR->QPR_OP))
			QQ7->(dbSetOrder(1))
			If 	!QQ7->(dbSeek(xFilial("QQ7")+ QPR->QPR_PRODUT + mv_par13 + mv_par14 + ;
				QPR->QPR_LABOR + QPR->QPR_ENSAIO + SC2->C2_ROTEIRO + QPR->QPR_OPERAC))
				QPR->(dbSkip())
				Loop
			EndIf
		EndIf
	EndIf
	
	RecLock("TRB",.T.)
	TRB_FILIAL	:=QPR->QPR_FILIAL
	TRB_PRODUT	:=QPR->QPR_PRODUT
	TRB_REVI	:=QPR->QPR_REVI
	TRB_OP		:=QPR->QPR_OP
	TRB_OPERAC	:=QPR->QPR_OPERAC
	TRB_DTENTR	:=QPR->QPR_DTENTR
	TRB_LOTE	:=QPR->QPR_LOTE
	TRB_RASTRE	:=QPR->QPR_RASTRE
	TRB_LABOR	:=QPR->QPR_LABOR
	TRB_ENSAIO	:=QPR->QPR_ENSAIO
	TRB_DTMEDI	:=QPR->QPR_DTMEDI
	TRB_HRMEDI	:=QPR->QPR_HRMEDI
	TRB_AMOSTR	:=QPR->QPR_AMOSTR
	TRB_ENSR	:=QPR->QPR_ENSR
	TRB_RESULT	:=QPR->QPR_RESULT
	TRB_CHAVE 	:=QPR->QPR_CHAVE 
	TRB_NUMSER 	:=QPR->QPR_NUMSER  
	TRB_ROTEIR 	:=QPR->QPR_ROTEIR  
	MsUnLock()
	QPR->(dbSkip())
EndDo

dbSelectArea("QPR")
FErase(cNomArq+OrdBagExt())
dbSetOrder(1)
Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R060ResCab()   ³Autor³Marcelo Pimentel    ³ Data ³ 23.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabecalho da Carta do Ensaio.                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R060ResCab(Lin)
Local cCarta := ''

@Li,001 PSAY AllTrim(TitSX3("QPT_INSTR")[1])
@Li,018 PSAY AllTrim(TitSX3("QPR_ENSR")[1])
@Li,028 PSAY Left(TitSX3("QPR_DTMEDI")[1],8)
@Li,039 PSAY Left(TitSX3("QPR_HRMEDI")[1],8)
@Li,048 PSAY STR0025	//"Am."
cCarta := STR0010		//"Medicoes"
If QP1->QP1_CARTA $"XBR/XBS/XMR/HIS/IND"
	cCarta := STR0010		//"Medicoes"
ElseIf AllTrim(QP1->QP1_CARTA) == "U"
	cCarta := STR0011		//"Amostra / Nao Conformidades p/ Unid"
ElseIf AllTrim(QP1->QP1_CARTA) == "NP"
	cCarta := STR0012		//"Nao Conformes"
Elseif AllTrim(QP1->QP1_CARTA) == "C"
	cCarta := STR0013		//"Nao Conformidades"
ElseIf AllTrim(QP1->QP1_CARTA) == "P"
	cCarta := STR0014		//"Amostra/Unid.Nao Conforme/Porc. Nao Corforme"
EndIf
@Li,054 PSAY cCarta
@Li,099 PSAY STR0021	//"A/R"
@Li,103 PSAY STR0022	//"Nao Conf"
@Li,112 PSAY STR0023	//"Nr NCs"
@Li,119 PSAY STR0024	//"Classe"
@Li,126 PSAY STR0026	//"Dem.IQI"
Li++
@Li,001 PSAY "---------------- --------- ---------- -------- ----- -------------------------------------------- --- -------- ------ ------ -------"
Li++
Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R060CabOp()    ³Autor³ Antonio Aurelio    ³ Data ³ 19.08.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabecalho da Ordem de Produ‡Æo                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R060CabOp()
QP6->(dbSeek(xFilial("QP6")+TRB->TRB_PRODUT+Inverte(TRB->TRB_REVI)))
SC2->(dbSeek(xFilial("SC2")+TRB->TRB_OP))
SAH->(dbSeek(xFilial("SAH")+SC2->C2_UM))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Periodo                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@Li,01 PSAY STR0007+Replicate(".",15-Len(STR0007))+":"		//"Periodo"
@Li,19 PSAY Dtoc(mv_par11) + " - " + Dtoc(mv_par12)
Li++
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordem Producao                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@Li,01 PSAY AllTrim(TitSX3("QPR_OP")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_OP")[1])))+":"
@Li,19 PSAY TRB->TRB_OP
Li++
			
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Produto                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@Li,01 PSAY AllTrim(TitSX3("QPR_PRODUT")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_PRODUT")[1])))+":"
@Li,19 PSAY AllTrim(TRB->TRB_PRODUT) + "-" +AllTrim(QP6->QP6_DESCPO)+" - "+TRB->TRB_REVI
Li++

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Data Producao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@Li,01 PSAY AllTrim(TitSX3("QPR_DTENTR")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_DTENTR")[1])))+":"
@Li,19 PSAY Dtoc(TRB->TRB_DTENTR)
Li++
@Li,01 PSAY AllTrim(TitSX3("QPR_LOTE")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_LOTE")[1])))+":"
@Li,19 PSAY TRB->TRB_LOTE 
If !Empty(TRB->TRB_NUMSER)                       
	@Li,49 PSAY AllTrim(TitSX3("QPR_NUMSER")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPR_NUMSER")[1])))+":"
	@Li,69 PSAY TRB->TRB_NUMSER 
EndIF
Li++
@Li,01 PSAY AllTrim(TitSX3("C2_QUANT")[1])+Replicate(".",15-Len(AllTrim(TitSX3("C2_QUANT")[1])))+":"
@Li,19 PSAY AllTrim(Str(SC2->C2_QUANT))+" "+SAH->AH_UMRES
Li++		

If !Empty(mv_par13)
	dbSelectArea("SA1")
	dbSetOrder(1)
	If dbSeek(xFilial("SA1")+mv_par13+mv_par14)
		Li++
		@Li,01 PSAY AllTrim(TitSX3("A7_CLIENTE")[1])+Replicate(".",15-Len(AllTrim(TitSX3("A7_CLIENTE")[1])))+":"
		@Li,19 PSAY mv_par13 + " / " + mv_par14 + " - " + SA1->A1_NOME
		Li++
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ N£mero de Rastreamento                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(TRB->TRB_RASTRE)
	@Li,01 PSAY AllTrim(TitSX3("QPR_RASTRE")[1])+": "+TRB->TRB_RASTRE
	Li++
EndIf	
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Laudo Producao                                               ³ 
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                               
QPL->(dbSetOrder(3))
If	QPL->(dbSeek(xFilial("QPL")+TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER+TRB->TRB_ROTEIR+Space(2)+Space(TamSX3("QPL_LABOR")[1])))
	QPD->(dbSeek(xFilial("QPD")+QPL->QPL_LAUDO))
	Li++
	@Li,001 PSAY STR0017 +QPL->QPL_LAUDO + " - " + QPD->QPD_DESCPO  	//"Laudo Producao: "
	@Li,053 PSAY STR0018 +Dtoc(QPL->QPL_DTLAUD)+"-"+QPL->QPL_HRLAUD	//"Data/Hora : "
	@Li,084 PSAY STR0019 +Dtoc(QPL->QPL_DTVAL)	               			//"Validade : "
	Li++ 
	If !Empty(QPL->QPL_JUSTLA)
		@Li,001 PSAY AllTrim(TitSX3("QPL_JUSTLA")[1])+": "+QPL->QPL_JUSTLA
		Li++
	EndIf
EndIf	
Return .T. 




