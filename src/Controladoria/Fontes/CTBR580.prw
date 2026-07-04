/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ctbr580.ch"
#Include "PROTHEUS.Ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±±³Fun‡…o	 ³ Ctbr580	³ Autor ³ José Lucas	 		 ³ Data ³ 16.02.10 ³±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±±³Descri‡…o ³ Demonstracao de Resultados                 			  	   ³±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±±³Retorno	 ³ Nenhum       											   ³±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±±³Parametros³ Nenhum													   ³±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbR580()          

Private dFinalA
Private dFinal
Private nomeprog	:= "CTBR580"    
Private dPeriodo0

If TRepInUse() 
	U_CTBR580R4()
Else
	Help(" ",1,"CTBR580",,STR0020,1,0,,,,,,{STR0021}) //"Relatório disponível apenas em TReport."###"Confira o parâmentro MV_TREPORT."
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR580R4  Autor ³ José Lucas	 		 ³ Data ³ 16.02.10 ³±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Demostrativo de balancos patrimoniais - R4		          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR115R4												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR580R4()                           

PRIVATE cPerg := "CTR580"        

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ            
Pergunte( cPerg, .T. )

// faz a validação do livro
If ! VdSetOfBook( mv_par06 , .T. )
   //Return .F.
Endif

oReport := ReportDef()      

If VALTYPE( oReport ) == "O"
	oReport :PrintDialog()      
EndIf

oReport := nil

Return                                

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef    Autor ³ José Lucas	 		 ³ Data ³ 16.02.10 ³±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo relatorio.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß    
/*/          
Static Function ReportDef()     

Local aSetOfBook	:= CTBSetOf(mv_par06)
Local aCtbMoeda	:= {}
Local cDescMoeda 	:= ""
local aArea	   	:= GetArea()   
Local CREPORT		:= "CTBR580"
Local CTITULO		:= STR0001				// DEMONSTRATIVO DE GRUPO CONTABIL x CONTA
Local CDESC			:= OemToAnsi(STR0014) + ; 			//"Este programa irá imprimir a Demonstração de Resultados, "
	   				   OemToAnsi(STR0015) 				//"de acordo com os parâmetros informados pelo usuário."
Local aTamCta       := {30}	//TamSX3("CT1_CONTA")
Local aTamDesc      := TamSX3("CT1_DESC01")
Local aTamCCusto    := TamSX3("CTT_CUSTO")
Local aTamItem 	    := TamSX3("CTD_ITEM") 
Local aTamCLVL		:= TamSX3("CTH_CLVL")  
Local aTamVal		:= TamSX3("CT2_VALOR")
                 
aCtbMoeda := CtbMoeda(mv_par07, aSetOfBook[9])
cDescMoeda 	:= AllTrim(aCtbMoeda[3])

If Empty(aCtbMoeda[1])                       
	Help(" ",1,"NOMOEDA")
    Return .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)	  	     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(mv_par06)
	If !Ct040Valid(mv_par06)
		Return
	EndIf
EndIf		

If !Empty(aSetOfBook[10]) .And. Valtype(mv_par14)=="N" .And. mv_par14 == 1
	CTITULO := CTBNomeVis( aSetOfBook[5] )
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport	:= TReport():New( CREPORT,CTITULO,CPERG, { |oReport| ReportPrint( oReport ) }, CDESC ) 
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataBase,ctitulo,,,,,oReport) } )                                        
oReport:ParamReadOnly()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                                                                      
If Empty(mv_par06)
	oSection1 := TRSection():New( oReport, STR0012, {"cArqTmp"},, .F., .F. )        //"Contas/Saldos"
	TRCell():New( oSection1, "CONTA"	,"",						/*Titulo*/,/*Picture*/,aTamCta[1]		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
	TRCell():New( oSection1, "DESCRICAO","",						/*Titulo*/,/*Picture*/,aTamDesc[1]		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
	TRCell():New( oSection1, "CUSTO"	,"",						/*Titulo*/,/*Picture*/,aTamCCusto[1]	/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
	TRCell():New( oSection1, "ITEM"		,"",						/*Titulo*/,/*Picture*/,aTamItem[1]		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
	TRCell():New( oSection1, "CLVL"		,"",						/*Titulo*/,/*Picture*/,aTamCLVL[1]		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
	TRCell():New( oSection1, "SALDOATU"	,"",						/*Titulo*/,/*Picture*/,aTamVal[1]+2		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
	TRCell():New( oSection1, "SALDOANT"	,"",						/*Titulo*/,/*Picture*/,aTamVal[1]+2		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
	oSection1:SetHeaderPage()
	oSection1:SetTotalInLine(.F.) 
Else
	oSection1 := TRSection():New( oReport, STR0012, {"cArqTmp"},, .F., .F. )        //"Contas/Saldos"
	TRCell():New( oSection1, "DESCRICAO","",						/*Titulo*/,/*Picture*/,aTamDesc[1]		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	
	TRCell():New( oSection1, "SALDOATU"	,"",						/*Titulo*/,/*Picture*/,aTamVal[1]+2		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
	TRCell():New( oSection1, "SALDOANT"	,"",						/*Titulo*/,/*Picture*/,aTamVal[1]+2		/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
	oSection1:SetTotalInLine(.F.) 
EndIf

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint Autor ³ José Lucas	 		 ³ Data ³ 16.02.10 ³±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±³          ³Nesta funcao deve ser criada a query das secoes se SQL ou   ³±±
±±³          ³definido o relacionamento e filtros das tabelas em CodeBase.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportPrint(oReport)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±            

±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )    

Local oSection1 	:= oReport:Section(1) 
Local aSetOfBook	:= CTBSetOf(mv_par06)
Local aCtbMoeda	:= {}
Local lin 			:= 3001
Local cArqTmp
Local cTpValor		:= GetMV("MV_TPVALOR")
Local cPicture
Local cDescMoeda
Local lFirstPage	:= .T.               
Local nTraco		:= 0
Local nSaldo        := 0
Local nTamLin		:= 2350
Local aPosCol		:= { 1740, 2045 }
Local nPosCol		:= 0
Local cArqTrm		:= ""
Local lVlrZerado	:= If(MV_PAR11 == 1,.T.,.F.)
Local lMovPeriodo   := If(MV_PAR12 == 1,.T.,.F.)
Local aTamVal		:= TAMSX3("CT2_VALOR")
Local cMoedaDesc	:= MV_PAR13
Local lPeriodoAnt 	:= (mv_par08 == 1)
Local cContaIni     := mv_par02
Local cContaFim     := mv_par03
Local cCCustoIni    := Space(TamSX3("CTT_CUSTO")[1])
Local cCCustoFim    := Repl("Z",TamSX3("CTT_CUSTO")[1])
Local cItemIni   	:= Space(TamSX3("CTD_ITEM")[1])
Local cItemFim    	:= Repl("Z",TamSX3("CTD_ITEM")[1])
Local cClVlIni      := Space(TamSX3("CTH_CLVL")[1])
Local cClVlFim	    := Repl("Z",TamSX3("CTH_CLVL")[1])
Local nSaldoAtu 	:= 0.00
Local nSaldoAnt 	:= 0.00                             
Local nTotGrpAtu 	:= 0.00              
Local nTotGrpAnt 	:= 0.00
Local nTGeGrpAtu 	:= 0.00         
Local nTGeGrpAnt 	:= 0.00
Local lTotGrupo     := .T.
Local lTotGeral     := .F.             
Local cAliasCTR     := "CTR"
	
aCtbMoeda := CtbMoeda(mv_par07, aSetOfBook[9])
If Empty(aCtbMoeda[1])                       
	Help(" ",1,"NOMOEDA")
    Return .F.
Endif

cDescMoeda 	:= AllTrim(aCtbMoeda[3])
nDecimais 	:= DecimalCTB(aSetOfBook,mv_par07)
cPicture 	:= aSetOfBook[4]

If ! Empty(cPicture) .And. Len(Trans(0, cPicture)) > 17
	cPicture := ""
Endif

dFinal		:= mv_par01
dFinalA		:= dFinal
nDivide     := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao					     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
			CTGerPlan(	oMeter,;
						oText,;
						oDlg,;
						@lEnd,;
						@cArqTmp,;
						dFinalA+1,;
						dFinal,;
						"CT7",;
						"",;
						cContaIni,; 
						cContaFim,;
						cCCustoIni,;
						cCCustoFim,;
						cItemIni,; 
						cItemFim,;
						cClVlIni,;
						cClVlFim,;
						mv_par07,;
						MV_PAR09,; 
						aSetOfBook,; 
						Space(2),;  
						Space(20),; 
						Repl("Z", 20),; 
						Space(30) ,,,,,;
						.F.,,;
						nDivide,;                                                                                        						
						lVlrZerado,,,,,,,,,,,,,,,,,,,,,,,,,;                                 						
						cMoedaDesc,;
						lMovPeriodo)},STR0006, STR0001) //"Criando Arquivo Temporario..."###"DEMONSTRATIVO DE GRUPO CONTABIL X CONTA"
						
dbSelectArea("cArqTmp")       

If Empty(mv_par06)	//Imprime relatório independente da Visão

	cFiltroTmp1 := 'TIPOCONTA == "2" '
	cFiltroTmp1 += ' .And. GRUPO >= "'+mv_par04+'" .And. GRUPO <= "'+mv_par05+'"'

	cArqTmp1 := CriaTrab(, .F.)
	IndRegua("cArqTmp",cArqTmp1,"GRUPO+CONTA+CUSTO+ITEM+CLVL",,cFiltroTmp1,STR0022)  //"Selecionando Registros..."
                     
	nIndex := RetIndex("cArqTmp")
	dbSelectArea("cArqTmp")
	dbSetOrder(nIndex+1)
	dbGoTop()

	oReport:SetMeter( RecCount() )

	oReport:SetPageNumber(mv_par10) //mv_par07 - Pagina Inicial
                                      
	Do While !Eof() .And. !oReport:Cancel() //.And. Eval(bCond)
         
		If oReport:Cancel()
			Exit
		EndIf	
                                     
		If Empty(cArqTmp->GRUPO) .OR. cArqTmp->TIPOCONTA == "1"
			cArqTmp->(DbSkip())
			Loop
		EndIf
  
		(cAliasCTR)->(dbSetOrder(1))
		(cAliasCTR)->(dbSeek(xFilial("CTR")+cArqTmp->GRUPO))
				
    	oReport:IncMeter() 
    
		TRPosition():New(oSection1,"CT1",1,{|| xFilial("CT1") + cArqTmp->CONTA })   
		TRPosition():New(oSection1,"CTT",1,{|| xFilial("CTT") + cArqTmp->CUSTO})
		TRPosition():New(oSection1,"CTD",1,{|| xFilial("CTD") + cArqTmp->ITEM})
		TRPosition():New(oSection1,"CTR",1,{|| xFilial("CTR") + cArqTmp->GRUPO})

		oSection1:Cell("CONTA"    ):SetBlock( { || cArqTmp->GRUPO } )		
		oSection1:Cell("DESCRICAO"):SetBlock( { || (cAliasCTR)->CTR_DESC } )
		oSection1:Cell("SALDOATU" ):SetBlock( { || Space(aTamVal[1]) } )	  
		oSection1:Cell("SALDOANT" ):SetBlock( { || Space(aTamVal[1]) } )

		oSection1:Init()
		oSection1:PrintLine()
		oSection1:Finish()

		cGrupo := cArqTmp->GRUPO
	
		Do While !Eof() .And. !oReport:Cancel() .And. cArqTmp->GRUPO == cGrupo

			oReport:IncMeter()

			If oReport:Cancel()
				Exit
			EndIf
		
			oSection1:Cell("CONTA"    ):SetBlock( { || cArqTmp->CONTA } )		
			oSection1:Cell("DESCRICAO"):SetBlock( { || Iif(cArqTmp->COLUNA<2,Iif(cArqTmp->TIPOCONTA="2",cArqTmp->DESCCTA,cArqTmp->DESCCTA),"") } )				
			oSection1:Cell("CUSTO"    ):SetBlock( { || cArqTmp->CUSTO } )
			oSection1:Cell("ITEM"     ):SetBlock( { || cArqTmp->ITEM } )
			oSection1:Cell("CLVL"     ):SetBlock( { || cArqTmp->CLVL } ) 
			oSection1:Cell("SALDOATU" ):SetBlock( { || ValorCTB( If(lMovPeriodo,cArqTmp->(SALDOATU-SALDOANT),cArqTmp->SALDOATU),,,aTamVal[1],nDecimais,.T.,cPicture,;
  	                                                 cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F. ) } )
			If lPeriodoAnt
				oSection1:Cell("SALDOANT" ):SetBlock( { || ValorCTB( If(lMovPeriodo,cArqTmp->MOVPERANT,cArqTmp->SALDOANT),,,aTamVal[1],nDecimais,.T.,cPicture,;
													 cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F. ) } )
			EndIf

			oSection1:Init()
			oSection1:PrintLine()
			oSection1:Finish()
		
	    	nSaldoAtu := R580Soma("1")      
    		nSaldoAnt := R580Soma("2")
                             
			nTotGrpAtu += nSaldoAtu	                                
			nTotGrpAnt += nSaldoAnt

			nTGeGrpAtu += nSaldoAtu              
			nTGeGrpAnt += nSaldoAnt
	
			cArqTmp->( dbskip()  )  
 		EndDo
 		
		// TOTALIZA O GRUPO	
		If lTotGrupo
			If ( cGrupo <> cArqTmp->GRUPO )

				oSection1:Cell("CONTA"):SetBlock( { || STR0018+" ("+AllTrim(cGrupo)+") " } ) //"TOTAL POR GRUPO"									
				oSection1:Cell("DESCRICAO"):SetBlock( { || Space(Len(cArqTmp->DESCCTA)) } )				
 				oSection1:Cell("SALDOATU" ):SetBlock( { || ValorCTB(nTotGrpAtu,,,aTamVal[1],nDecimais,.T.,cPicture,cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F. ) } )
				If lPeriodoAnt
					oSection1:Cell("SALDOANT"):SetBlock( { || ValorCTB(nTotGrpAnt,,,aTamVal[1],nDecimais,.T.,cPicture,cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F. ) } )
				EndIf
			
				oSection1:Init()
				oSection1:Printline()
				oSection1:Finish()
							
				nTotGrpAtu := 0	
				nTotGrpAnt := 0					
	   		EndIf		
		EndIf		   
	EndDo
            
Else				//Imprime relatório considerando a Visão selecionada.

	oReport:SetPageNumber(mv_par10) //mv_par07 - Pagina Inicial

	oSection1:Cell("SALDOATU" ):SetTitle(Dtoc(dFinal))
	If lPeriodoAnt
		oSection1:Cell("SALDOANT" ):SetTitle(Dtoc(dFinalA))
	Else
		oSection1:Cell("SALDOANT" ):Disable()
	EndIf

	oSection1:Cell("DESCRICAO"):SetBlock( { || Iif(cArqTmp->COLUNA<2,Iif(cArqTmp->TIPOCONTA="2",cArqTmp->DESCCTA,cArqTmp->DESCCTA),"") } )		

	If cArqTmp->IDENTIFI < "5"
		oSection1:Cell("SALDOATU" ):SetBlock( { || ValorCTB( If(lMovPeriodo,cArqTmp->(SALDOATU-SALDOANT),cArqTmp->SALDOATU),,,aTamVal[1],nDecimais,.T.,cPicture,;
    	                                                 cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F. ) } )

		If lPeriodoAnt
			oSection1:Cell("SALDOANT" ):SetBlock( { || ValorCTB( If(lMovPeriodo,cArqTmp->MOVPERANT,cArqTmp->SALDOANT),,,aTamVal[1],nDecimais,.T.,cPicture,;
															 cArqTmp->NORMAL,cArqTmp->CONTA,,,cTpValor,,,.F. ) } )
		EndIf
	EndIf

	oSection1:Print()

EndIf	   
DbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
 
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF	

Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³CTR500ESP ³ Autor ³ José Lucas	 		 ³ Data ³ 16.02.10 ³±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho Especifico do relatorio CTBR041.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTR500ESP(ParO1,ParC1)			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpC1 = Descricao da moeda sendo impressa                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACTB                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTR580Esp(oPrint,cDescMoeda,aPosCol,nTamLin)

Local cColuna  		:= "(Em " + cDescMoeda + ")"
Local aCabecalho    := { Dtoc(dFinal, "ddmmyyyy"), Dtoc(dFinalA, "ddmmyyyy") }
Local nPosCol

oPrint:Line(250,150,300,150)   	// vertical

oPrint:Say(260,195,cColuna,oArial10)

For nPosCol := 1 To Len(aCabecalho)
	oPrint:Say(260,aPosCol[nPosCol] + 30,aCabecalho[nPosCol],oArial10)
Next

oPrint:Line(250,nTamLin,300,nTamLin)   	// vertical

oPrint:Line(300,150,300,nTamLin)   	// horizontal

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³CTR580ATU ³ Autor ³ José Lucas	 		³ Data ³ 16.02.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho para impressao apenas da coluna de Saldo Atual.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_CTR580ESP(ParO1,ParC1)			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpC1 = Descricao da moeda sendo impressa                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACTB                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTR580ATU(oPrint,cDescMoeda,aPosCol,nTamLin)

Local cColuna  		:= "(Em " + cDescMoeda + ")"
Local aCabecalho    := { Dtoc(dFinal, "ddmmyyyy") }
Local nPosCol       := 1

oPrint:Line(250,150,300,150)   	// vertical

oPrint:Say(260,195,cColuna,oArial10)

oPrint:Say(260,aPosCol[nPosCol+1] + 30,aCabecalho[nPosCol],oArial10)


oPrint:Line(250,nTamLin,300,nTamLin)   	// vertical

oPrint:Line(300,150,300,nTamLin)   	// horizontal

Return Nil  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R580Soma	³ Autor ³ José Lucas	 		 ³ Data ³ 16.02.10 ³±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR580                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R580Soma(cTipoSaldo)
Local nRetValor := 0               
If cTipoSaldo == "1"
	nRetValor := cArqTmp->SALDOATU
Else	                          
	nRetValor := cArqTmp->SALDOANT
EndIf	
Return nRetValor                                                                         
