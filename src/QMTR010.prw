/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR010.Ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR010  ³ Autor ³ Cicero Cruz           ³ Data ³ 24.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Instrumentos a Calibrar                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR010(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QMTR010()
Local oReport        
Private cAliasQM2  := "QM2"  
Private cAliasQMR  := "QMR" 
Private aInstr     := {}
Private cConQuebra := ""
Private cFAnt      := ""
Private nTam       := 0
Private advMV_01   := ""
Private advMV_02   := ""
Private advMV_03   := ""
Private advMV_05   := ""
Private advMV_06   := ""
Private advMV_07   := ""
Private advMV_08   := ""
Private advMV_12   := ""
Private advMV_13   := ""
Private lRange     := .T.

If TRepInUse() .AND. !IsBlind()
	// Interface de impressao
	DbSelectarea("QM1") 
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	U_QMTR010R3()
EndIf    

Return
                 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Cicero Cruz           ³ Data ³ 24.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QMTR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport 
Local oSection1
Local cPerg		:="QMR010 "
Private aOrdem    := {}

If lRange
	cPerg	:="QMR010R"
EndIf
Pergunte(cPerg,.F.) 

DEFINE REPORT oReport NAME "QMTR010" TITLE STR0005 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION STR0001+STR0002 // "Relatorio de Instrumentos a Calibrar" ### "Este programa ir  emitir a rela‡„o de" ### "instrumentos a calibrar."

oReport:SetLandscape()	   

aOrdem := {	STR0026,; 	// "Departamento"
			STR0010,;   // "Data"
		    STR0016,;  	// "Instrumento"
		    STR0018} 	// "Familia"

DEFINE SECTION oSection1 OF oReport   TITLE STR0016 TABLES "QM2" ORDERS aOrdem
DEFINE SECTION oSection2 OF oSection1 TITLE STR0027 TABLES "QMR" ORDERS aOrdem

DEFINE CELL NAME "QM2_DEPTO"   	OF oSection1 ALIAS "QM2" 	SIZE TamSx3("QM2_DEPTO")[1]
DEFINE CELL NAME "QM2_INSTR"   	OF oSection1 ALIAS "QM2"	
DEFINE CELL NAME "QM2_TIPO"    	OF oSection1 ALIAS "QM2"	
DEFINE CELL NAME "QM2_DESCR"   	OF oSection1             	SIZE   30 	TITLE STR0023 					BLOCK {|| Posicione("QM1", 1, XFILIAL("QM1")+&(cAliasQM2+"->QM2_TIPO"), "QM1_DESCR" )} //"Descricao"
DEFINE CELL NAME "QM2_FABR"    	OF oSection1 ALIAS "QM2"	
DEFINE CELL NAME "QM2_FREQAF"  	OF oSection1 ALIAS "QM2"	SIZE    3  	TITLE STR0019+CRLF+STR0020  // "Freq" ### "Dias"
If lRange
	DEFINE CELL NAME "QM2_VALDAF"  	OF oSection1 ALIAS "QM2" 				                               	BLOCK {|| 	 Iif(mv_par15 == 2,StrZero(MONTH(&(cAliasQM2+"->QM2_VALDAF")),2)+"/"+Str(YEAR (&(cAliasQM2+"->QM2_VALDAF")),4),&(cAliasQM2+"->QM2_VALDAF"))}
Else
	DEFINE CELL NAME "QM2_VALDAF"  	OF oSection1 ALIAS "QM2" 				                               	BLOCK {|| 	 Iif(mv_par24 == 2,StrZero(MONTH(&(cAliasQM2+"->QM2_VALDAF")),2)+"/"+Str(YEAR (&(cAliasQM2+"->QM2_VALDAF")),4),&(cAliasQM2+"->QM2_VALDAF"))}
EndIf
DEFINE CELL NAME "QM2_RESP"    	OF oSection1 ALIAS "QM2" 	SIZE   30	TITLE STR0028   				BLOCK {|| 	 Posicione("QAA", 1, XFILIAL("QAA")+&(cAliasQM2+"->QM2_RESP"), "QAA_NOME" )} 
DEFINE CELL NAME "QM2_LAUDO"   	OF oSection1 ALIAS "QM2"   	SIZE   15 	TITLE STR0021            		BLOCK {||	 Iif(&(cAliasQM2+"->QM2_LAUDO")=="3",Tabela("QA","APROV"),;   // "Laudo"
															 											 			 Iif(&(cAliasQM2+"->QM2_LAUDO")=="2",Tabela("QA","APREST"),;
															 									        	         Iif(&(cAliasQM2+"->QM2_LAUDO")=="1",Tabela("QA","REPROV"),STR0014)))} //"Nao Calibrado"
DEFINE CELL NAME "QM2_LOCAL"   	OF oSection1 ALIAS "QM2"	SIZE   15 	TITLE STR0022 					BLOCK {|| &(cAliasQM2+"->QM2_LOCAL") }	// "Localizacao"
DEFINE CELL NAME "QMR_ESCALA"  	OF oSection2 ALIAS "QMR" 	 

If lRange
	DEFINE CELL NAME "QMR_REDUT"   	OF oSection2 ALIAS "QMR" 	AUTO SIZE 	TITLE STR0029					BLOCK {|| 	Iif(mv_par11 == 1 .AND. QMR->QMR_CAOBRI == "S", QMR->QMR_REDUT , "")}
	DEFINE CELL NAME "QMR_TOLPRO"  	OF oSection2 ALIAS "QMR" 	AUTO SIZE 	TITLE STR0030					BLOCK {|| 	Iif(mv_par11 == 1 .AND. QMR->QMR_CAOBRI == "S", QMR->QMR_TOLPRO, "")}
Else
	DEFINE CELL NAME "QMR_REDUT"   	OF oSection2 ALIAS "QMR" 	AUTO SIZE 	TITLE STR0029					BLOCK {|| 	Iif(mv_par18 == 1 .AND. QMR->QMR_CAOBRI == "S", QMR->QMR_REDUT , "")}
	DEFINE CELL NAME "QMR_TOLPRO"  	OF oSection2 ALIAS "QMR" 	AUTO SIZE 	TITLE STR0030					BLOCK {|| 	Iif(mv_par18 == 1 .AND. QMR->QMR_CAOBRI == "S", QMR->QMR_TOLPRO, "")}
EndIf

DEFINE BREAK oBreak1 OF oSection1 WHEN {|| &(U_MTR010_FC( oReport )) } TITLE OemToAnsi(STR0024) //"Sub-Total "

DEFINE FUNCTION oFunc FROM oSection1:Cell("QM2_DEPTO") ;
			 OF oSection1 FUNCTION COUNT  BREAK oBreak1 TITLE OemToAnsi(STR0025) NO END SECTION //"Total Geral"    
	 
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³PrintRepor³ Autor ³ Cicero Cruz           ³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao R4	 		                            		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR010													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport( oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oBreak    := oReport:Section(1):ABREAK[1]    
Local cPerg		:= "QMR010 "    
Local cOrdem    := ""   
Local lCab 		:= .F.
Local nInt		:= 0
Local cRevAtual := ""
Local cUltRev   := ""

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
//³ mv_par12   : Fam¡lia de                               ³
//³ mv_par13   : Fam¡lia ate                              ³
//³ mv_par14   : Fabricante de                            ³
//³ mv_par15   : Fabricante ate                           ³
//³ mv_par16   : Impr.Desc.Fam¡lia      Sim - N„o         ³
//³ mv_par17   : Impr.Localiza‡„o       Sim - N„o         ³
//³ mv_par18   : Impr.Tol.Proc./Redutor Sim - N„o         ³
//³ mv_par19   : Status de                                ³
//³ mv_par20   : Status ate                               ³
//³ mv_par21   : Usu rio de                               ³
//³ mv_par22   : Usu rio ate                              ³
//³ mv_par23   : Quebra por Depto                         ³
//³ mv_par24   : Formato da Data                          ³
//³ mv_par25   : Quebra por Pagina                        ³
//³ mv_par26   : Filtra Status                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRange
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                  ³
	//³ mv_par01   : Instrumento(s)                           ³
	//³ mv_par02   : Periodo(s)                               ³
	//³ mv_par03   : Departamento(s)		                  ³
	//³ mv_par04   : Orgao Calibrador Todos/Interno/Externo   ³
	//³ mv_par05   : Orgao(s) Calibrador(es) interno(s)       ³
	//³ mv_par06   : Orgao(s) Calibrador(es) externo(s)       ³
	//³ mv_par07   : Fam¡lia(s)                               ³
	//³ mv_par08   : Fabricante(s)                            ³
	//³ mv_par09   : Impr.Desc.Fam¡lia      Sim - N„o         ³
	//³ mv_par10   : Impr.Localiza‡„o       Sim - N„o         ³
	//³ mv_par11   : Impr.Tol.Proc./Redutor Sim - N„o         ³
	//³ mv_par12   : Status                                   ³
	//³ mv_par13   : Usu rio(s)                               ³
	//³ mv_par14   : Quebra por Depto                         ³
	//³ mv_par15   : Formato da Data                          ³
	//³ mv_par16   : Quebra por Pagina                        ³
	//³ mv_par17   : Filtra Status                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cPerg		:= "QMR010R"                       
EndIf
Pergunte(cPerg,.F.)           

If lRange 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tratamento dos Ranges para query                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TrataPar(cPerg, {"01","02","05","06","07","08","12","13"}, oReport, .T.)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cAliasQM2 := GetNextAlias()

Do Case
	Case oSection1:GetOrder() == 1
		cOrdem := '% 1, 7, 2, 4 %'
   	Case oSection1:GetOrder() == 2
		cOrdem := '% 1, 5, 2, 4 %'
	Case oSection1:GetOrder() == 3
		cOrdem := '% 1, 2, 4 %'    
	Case oSection1:GetOrder() == 4
		cOrdem := '% 1, 9, 2, 4 %' 
EndCase 

If lRange 
	BEGIN REPORT QUERY oSection1    
	
		BeginSql Alias cAliasQM2

		SELECT QM2.QM2_FILIAL, QM2.QM2_INSTR, QM2.QM2_REVINS, QM2.QM2_REVINV, QM2.QM2_VALDAF, QM2.QM2_FREQAF,
		       QM2.QM2_DEPTO,  QM2.QM2_RESP , QM2.QM2_TIPO  , QM2.QM2_FABR  , QM2.QM2_STATUS, QM2.QM2_LAUDO ,
		       QM2.QM2_LOCAL,  QM2.QM2_FLAG , QM2.QM2_FILRES 
		 	FROM %table:QM2% QM2 	
			WHERE QM2.QM2_FILIAL = %xFilial:QM2% AND 
			      QM2.%notDel%  		 
			ORDER BY %Exp:cOrdem%  
	 			
		EndSql
		
        	END REPORT QUERY oSection1 PARAM mv_par01, mv_par02, mv_par07, mv_par08, mv_par13
Else 
	BEGIN REPORT QUERY oSection1 
	
		BeginSql Alias cAliasQM2
		
			SELECT QM2.QM2_FILIAL, QM2.QM2_INSTR, QM2.QM2_REVINS, QM2.QM2_REVINV, QM2.QM2_VALDAF, QM2.QM2_FREQAF,
		       QM2.QM2_DEPTO,  QM2.QM2_RESP , QM2.QM2_TIPO  , QM2.QM2_FABR  , QM2.QM2_STATUS, QM2.QM2_LAUDO ,
		       QM2.QM2_LOCAL,  QM2.QM2_FLAG , QM2.QM2_FILRES 
		 	FROM %table:QM2% QM2 	
			WHERE QM2.QM2_FILIAL = %xFilial:QM2% AND 
				  QM2.QM2_INSTR BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
			      QM2.QM2_DEPTO BETWEEN %Exp:mv_par05% AND %Exp:mv_par06% AND         
			      QM2.QM2_TIPO  BETWEEN %Exp:mv_par12% AND %Exp:mv_par13% AND
			      QM2.QM2_FABR  BETWEEN %Exp:mv_par14% AND %Exp:mv_par15% AND
			      QM2.QM2_RESP  BETWEEN %Exp:mv_par21% AND %Exp:mv_par22% AND 
			      QM2.%notDel%  		 
			ORDER BY %Exp:cOrdem%  
	 			
        EndSql    
        
        END REPORT QUERY oSection1    
EndIf


BEGIN REPORT QUERY  oSection2 
cAliasQMR := GetNextAlias()

	BeginSql Alias cAliasQMR    
	
	  SELECT QMR.QMR_FILIAL, QMR.QMR_REDUT, QMR.QMR_TOLPRO, QMR.QMR_CAOBRI, QMR.QMR_ESCALA, QMR.QMR_INSTR
		FROM %table:QMR% QMR		
		WHERE QMR.QMR_FILIAL = %report_param:(cAliasQM2)->QM2_FILIAL% AND 
			QMR.QMR_INSTR  = %report_param:(cAliasQM2)->QM2_INSTR% AND
			QMR.QMR_REVINS = %report_param:(cAliasQM2)->QM2_REVINS%  AND
			QMR.%notDel%			
	    ORDER BY QMR_INSTR,QMR_REVINS
	    
	EndSql

END REPORT QUERY oSection2	

If lRange 
	If MV_PAR17 == 1
		oBreak:SetPageBreak(.T.) 
	ElseIf MV_PAR15 == 1
		oBreak:SetPageBreak(.F.)
	EndIf
Else
	If MV_PAR25 == 1
		oBreak:SetPageBreak(.T.) 
	ElseIf MV_PAR23 == 1
		oBreak:SetPageBreak(.F.)
	EndIf
Endif

While !&(cAliasQM2)->(EOF())
    	
	cRevAtual:= &(cAliasQM2+"->QM2_REVINS")
	cUltRev  := QMA010UltR(&(cAliasQM2+"->QM2_INSTR"))
	
	If cRevAtual == cUltRev

		If lRange
			If !U_MTR010CS1R(oReport)
				&(cAliasQM2)->(DbSkip())
				Loop
			EndIf
		Else
			If !U_MTR010_CS1(oReport)
				&(cAliasQM2)->(DbSkip())
				Loop
			EndIf
		EndIf 
		oSection1:Init()
		oSection1:PrintLine()	
	
	    lCab := .T.  
		oSection2:Init()
		oSection2:ExecSQL()       
	
		oReport:SkipLine(1)
		While !&(cAliasQMR)->(EOF()) .and. (cAliasQMR)->QMR_INSTR == (cAliasQM2)->QM2_INSTR
			If !U_MTR010_CS2(oReport)
				&(cAliasQMR)->(DbSkip())
				Loop
			EndIf
			oSection2:PrintLine()
			&(cAliasQMR)->(DbSkip())
		Enddo
		oSection2:Finish()
		oReport:SkipLine(2)	
	    oReport:FatLine()	 
		oReport:SkipLine()	
    Endif
    
	&(cAliasQM2)->(DbSkip())  
	nInt ++
		
Enddo

oSection1:Finish()	
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR010_CS1³ Autor ³ Cicero Cruz			³ Data ³ 25.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR010_CS1(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR010_CS1(oReport)

Local lRet 		:= .T.      
Local oSection1 := oReport:Section(1)
Local aComp := {;
	&(cAliasQM2+"->(QM2_FILIAL+QM2_INSTR)"),; //1
	&(cAliasQM2+"->QM2_STATUS"),;//2
	&(cAliasQM2+"->QM2_VALDAF"),;//3
	&(cAliasQM2+"->QM2_INSTR"),;//4
	&(cAliasQM2+"->QM2_REVINS"),;//5
	&(cAliasQM2+"->QM2_DEPTO");//6
}

If mv_par26 == 2  
	If QMTXSTAT(aComp[2]) 
		If DTOS(aComp[3]) >= DTOS(MV_PAR03) .And. DTOS(aComp[3]) <= DTOS(MV_PAR04)				
		   lRet := .T.
		Else
		   lRet := .F.
		Endif
	Else
		lRet := .F.
	Endif
Else
	If ( DTOS(aComp[3]) >= DTOS(MV_PAR03) .And. DTOS(aComp[3]) <= DTOS(MV_PAR04) ) .AND. lRet				
	   	lRet := .T.
	Else
		lRet := .F.
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se status do instrumento esta ativo                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( aComp[2] < mv_par19 .or. aComp[2] > mv_par20 )
	  	lRet := .F.
	Endif	
Endif	


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico O.C. interno e externo                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 == 1 .AND. lRet
	If !Calibrador(0,mv_par08,mv_par09,mv_par10,mv_par11,aComp[4],aComp[5])
	   lRet := .F.
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico O.C. interno                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 == 2 .AND. lRet
	If !Calibrador(1,mv_par08,mv_par09,,,aComp[4],aComp[5]) .AND. lRet
	   lRet := .F.
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico O.C. externo                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 == 3 .AND. lRet
	If ! Calibrador(2,,,mv_par10,mv_par11,aComp[4],aComp[5])
	   lRet := .F.
	EndIf
EndIf
           
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Procura o departamento no QAD - Centro de Custo.             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QAD->(dbSetOrder(1))
If !QAD->(dbSeek( xFilial("QAD") + aComp[6] ))
   lRet := .F.    
Endif    

If ( mv_par10 == 2 )
	oSection1:Cell("QM2_LOCAL"):Disable()  
EndIf                          

If ( mv_par16 == 2 )
	oSection1:Cell("QM2_DESCR"):Disable()
EndIf

if lRet
	If !Empty(aInstr)
		If Ascan(aInstr, {|x| x[1] == &(cAliasQM2+"->QM2_FILIAL")+&(cAliasQM2+"->QM2_INSTR")}) > 0
			lRet := .F.
		Else
			aAdd(aInstr, {&(cAliasQM2+"->QM2_FILIAL")+&(cAliasQM2+"->QM2_INSTR")})	
		EndIf
	Else
		aAdd(aInstr, {&(cAliasQM2+"->QM2_FILIAL")+&(cAliasQM2+"->QM2_INSTR")})
	Endif	
	
EndIf
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR010CS1R³ Autor ³ Cicero Cruz			³ Data ³ 25.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR010CS1R(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/               
User Function MTR010CS1R(oReport)

Local lRet 		:= .T.      
Local oSection1 := oReport:Section(1)
Local cAuxExpr  := ""
Local cAuxExpr1 := ""
Local cAuxExpr2 := ""
Local aComp :={;
	&(cAliasQM2+"->(QM2_FILIAL+QM2_INSTR)"),; //1
	&(cAliasQM2+"->QM2_STATUS"),; //2
	&(cAliasQM2+"->QM2_VALDAF"),;//3
	&(cAliasQM2+"->QM2_INSTR"),;//4
	&(cAliasQM2+"->QM2_REVINS"),;//5
	&(cAliasQM2+"->QM2_DEPTO");//6
}

If mv_par17 == 2  
	If QMTXSTAT(aComp[2]) 
		cAuxExpr := advMV_02
		cAuxExpr := StrTran( cAuxExpr, "QM2_VALDAF", cAliasQM2+"->QM2_VALDAF" )
		If &cAuxExpr				
		   lRet := .T.
		Else
		   lRet := .F.
		Endif
	Else
		lRet := .F.
	Endif
Else
	cAuxExpr := advMV_02
	cAuxExpr := StrTran( cAuxExpr, "QM2_VALDAF", cAliasQM2+"->QM2_VALDAF" )
	If &cAuxExpr .AND. lRet				
	   	lRet := .T.
	Else
		lRet := .F.
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se status do instrumento esta ativo                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAuxExpr := advMV_12
	cAuxExpr := StrTran( cAuxExpr, "QM2_STATUS", cAliasQM2+"->QM2_STATUS" )
	If !&cAuxExpr
	  	lRet := .F.
	Endif	
Endif	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico O.C. interno e externo                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par04 == 1 .AND. lRet
	cAuxExpr1 := advMV_05
	cAuxExpr1 := StrTran( cAuxExpr1, "QM9_DEPTO", "QM9->QM9_DEPTO" )
	cAuxExpr2 := advMV_06
	cAuxExpr2 := StrTran( cAuxExpr2, "QM9_LABOR", "QM9->QM9_LABOR" )
	If !Calibrador(0,Iif(Empty(cAuxExpr1),".T.",cAuxExpr1),Nil,Iif(Empty(cAuxExpr2),".T.",cAuxExpr2),Nil,aComp[4],aComp[5],.T.)
	   lRet := .F.
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico O.C. interno                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par04 == 2 .AND. lRet
	cAuxExpr := advMV_05
	cAuxExpr := StrTran( cAuxExpr, "QM2_DEPTO", "QM9->QM9_DEPTO" )
	If !Calibrador(1,Iif(Empty(cAuxExpr),".T.",cAuxExpr),Nil,,,aComp[4],aComp[5],.T.) .AND. lRet
	   lRet := .F.
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico O.C. externo                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par04 == 3 .AND. lRet
	cAuxExpr := advMV_06
	cAuxExpr := StrTran( cAuxExpr, "QM9_LABOR", "QM9->QM9_LABOR" )
	If !Calibrador(2,,,Iif(Empty(cAuxExpr),".T.",cAuxExpr),Nil,acomp[4],aComp[5],.T.)
	   lRet := .F.
	EndIf
EndIf
           
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Procura o departamento no QAD - Centro de Custo.             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QAD->(dbSetOrder(1))
If !QAD->(dbSeek( xFilial("QAD") + aComp[6] ))
   lRet := .F.    
Endif    

If ( mv_par10 == 2 )
	oSection1:Cell("QM2_LOCAL"):Disable()  
EndIf                          

If ( mv_par16 == 2 )
	oSection1:Cell("QM2_DESCR"):Disable()
EndIf

if lRet
	If !Empty(aInstr)
		If Ascan(aInstr, {|x| x[1] == acomp[1]}) > 0
			lRet := .F.
		Else
			aAdd(aInstr, {acomp[1]})	
		EndIf
	Else
		aAdd(aInstr, {aComp[1]})
	Endif	
endIf

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR010_CS2³ Autor ³ Cicero Cruz			³ Data ³ 25.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR010_CS2(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR010_CS2(oReport)       
Local lRet := .T.

If lRange
	If ( mv_par11 == 2 )
		lRet := .F.
	Endif 
Else
	If ( mv_par18 == 2 )
		lRet := .F.
	Endif 
EndIf	
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR010_FC ³ Autor ³ Cicero Cruz			³ Data ³ 25.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Altera o tipo de quebra de acordo com a ordem escolhida    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR010_FC(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR010_FC( oReport )
Local cCond     := ""

If lRange 
	If MV_PAR14 == 1 
		If oReport:Section(1):nOrder == 1 .And. mv_par14 == 1
			cCond := cAliasQM2+"->QM2_DEPTO"
		ElseIf oReport:Section(1):nOrder == 2 .And. mv_par15 == 1
			cCond := cAliasQM2+"->QM2_VALDAF"
		ElseIf oReport:Section(1):nOrder == 2 .And. mv_par15 == 2
			cCond := StrZero(MONTH(&(cAliasQM2+"->QM2_VALDAF")),2)+"/"+Str(YEAR (&(cAliasQM2+"->QM2_VALDAF")),4)
		ElseIf oReport:Section(1):nOrder == 3
			cCond := cAliasQM2+"->QM2_INSTR"
		ElseIf oReport:Section(1):nOrder == 4
			cCond := cAliasQM2+"->QM2_TIPO"
		EndIf
	Endif
Else 
	If MV_PAR23 == 1 
		If oReport:Section(1):nOrder == 1 .And. mv_par23 == 1
			cCond := cAliasQM2+"->QM2_DEPTO"
		ElseIf oReport:Section(1):nOrder == 2 .And. mv_par24 == 1
			cCond := cAliasQM2+"->QM2_VALDAF"
		ElseIf oReport:Section(1):nOrder == 2 .And. mv_par24 == 2
			cCond := StrZero(MONTH(&(cAliasQM2+"->QM2_VALDAF")),2)+"/"+Str(YEAR (&(cAliasQM2+"->QM2_VALDAF")),4)
		ElseIf oReport:Section(1):nOrder == 3
			cCond := cAliasQM2+"->QM2_INSTR"
		ElseIf oReport:Section(1):nOrder == 4
			cCond := cAliasQM2+"->QM2_TIPO"
		EndIf
	Endif
EndIf
Return cCond

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR010R3³ Autor ³ Alessandro B. Freire  ³ Data ³ 23.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de instrumentos a calibrar                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR010R3(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis     ³Melhor³ Melhora de Performance - Utilizacao de Query's am-  ³±± 
±±³          ³      ³ biente Top e Arquivo Temporario para ambiente Code  ³±±
±±³          ³      ³ Base.												  ³±±
±±³Denis     ³Melhor³ Acerto na impressao do relatorio qdo da utilizacao  ³±± 
±±³          ³      ³ do indice data.                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR010R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1	:= OemToAnsi( STR0001 ) // "Este programa ir  emitir a rela‡„o de"
Local cDesc2	:= OemToAnsi( STR0002 ) // "instrumentos a calibrar."
Local cDesc3	:= ""
Local wnrel    := ""
Local lImpLin2	:= .T.
Local cString	 :="QM2"

Private titulo	 := OemToAnsi(STR0013) //Instrumentos a Calibrar
Private cabec1	 := ""
Private cabec2	 := ""
Private aReturn	 := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 1, 2, 1, "",1 } //"Zebrado"###"Administra‡„o"
Private nomeprog :="QMTR010"
Private cPerg	 :="QMR010"
Private cTamanho := "G"

aOrd := { OemToAnsi(STR0009), OemToAnsi(STR0010), OemToAnsi(STR0016), OemToAnsi(STR0018) }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR010",.F.)
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
//³ mv_par12   : Fam¡lia de                               ³
//³ mv_par13   : Fam¡lia ate                              ³
//³ mv_par14   : Fabricante de                            ³
//³ mv_par15   : Fabricante ate                           ³
//³ mv_par16   : Impr.Desc.Fam¡lia      Sim - N„o         ³
//³ mv_par17   : Impr.Localiza‡„o       Sim - N„o         ³
//³ mv_par18   : Impr.Tol.Proc./Redutor Sim - N„o         ³
//³ mv_par19   : Status de                                ³
//³ mv_par20   : Status ate                               ³
//³ mv_par21   : Usu rio de                               ³
//³ mv_par22   : Usu rio ate                              ³
//³ mv_par23   : Quebra por Depto                         ³
//³ mv_par24   : Formato da Data                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR010"   //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,cTamanho,{},.F.)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| MTR010Imp(@lEnd,wnRel,cString,lImpLin2)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MTR010IMP³ Autor ³ Alessandro B.Freire   ³ Data ³ 23.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Sugestao de Bloqueio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MTR010IMP(lEnd,wnRel,cString)                              ³±±
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
Static Function MTR010Imp(lEnd,wnRel,cString,lImpLin2)

Local CbCont
Local CbTxt
Local nOrdem		:= IndexOrd()
Local cAlias		:= Alias()
Local nCntParc		:= 0    // Contador para subtotal
Local nCntTot		:= 0    // Contador para total
Local nIndex		:= 0
Local cKey			:= ""
Local lVez			:= .t.
Local nTm			:= 1
Local cLbDepto		:= TitSx3("QM2_DEPTO")[1]
Local cLbInstr		:= TitSx3("QM2_INSTR")[1]
Local cLbTipo		:= TitSx3("QM2_TIPO")[1]
Local cLbFabr		:= TiTSx3("QM2_FABR")[1]
Local cLbFreq		:= Subs(TitSx3("QM2_FREQAF")[1],1,4)
Local cLbValDaf		:= TitSx3("QM2_VALDAF")[1]
Local cLbResp		:= TitSx3("QM2_RESP")[1]
Local cLbLocal		:= TitSx3("QM2_LOCAL")[1]
Local cLbDescr		:= TitSx3("QM1_DESCR")[1]
Local cLbEscal		:= TitSx3("QM9_ESCALA")[1]
Local cLbRedut		:= Subs(TitSx3("QMR_REDUT")[1],1,10)
Local cLbTol		:= TitSx3("QMR_TOLPRO")[1]
Local cChv			:= ""
Local cRevAtual 	:= ""
Local cUltRev   	:= ""
			
Private cIndex      := ""
Private lAbortPrint := .F.
Private cFilialTRB	
Private TRB_FILIAL	
Private TRB_INSTRL	
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
Private TRB_FILRES
Private aInstru := {}
Private lImpSub := .F.
nCntTot := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi( STR0005 ) // "Relatorio de Instrumentos a Calibrar"
	/*
   	          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6          7         8         9         20        1         2
	012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678900123456789012345678901234567890123456789012345678901234567890
	Departamento      Instrumento         Familia                                   Fabricante               Freq.   Val.Calibr.                Responsavel                    Laudo
   	                  Localizacao         Descricao                                                          Dias    Escala                     Redutor        Toler. Processo
	XXXXXXXXXX        XXXXXXXXXXXXXXXX    XXXXXXXXXXXXXXXX                          XXXXXXXXXXXXXXXX         9999    99/99/99                   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXX
   	                  XXXXXXXXXXXXXXXX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                        XXXXXXXXXXXXXXXX           XX             XXXXXXXXXX
	*/

cabec1 :=	cLbDepto+space(10)+cLbInstr+space(14)+cLbTipo+space(20)+cLbFabr+space(16)+;
					cLbFreq+Space(14)+cLbValDaf+Space(20)+cLbResp+Space(20)+STR0006

cabec2 :=space(30)+;
			If( mv_par17 == 1,cLbLocal,SPACE(LEN(cLbLocal)))+space(11)+;
			If( mv_par16 == 1,cLbDescr,SPACE(LEN(cLbDescr)))+space(43)+;
			STR0007+"      "+;
			If( mv_par18 == 1,cLbEscal,SPACE(LEN(cLbEscal)))+space(5)+;
			If( mv_par18 == 1,cLbRedut,SPACE(10))+"          "+;
			If( mv_par18 == 1,cLbTol,SPACE(LEN(cLbTol)))

If ( mv_par16 == 2 ) .And. ( mv_par17 == 2 ) .And. ( mv_par18 == 2 )
	cabec2	:= ""
	lImpLin2	:= .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a Ordem (informada na SetPrint)  ser utilizada      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QM2")
dbSetOrder(01)            

Do Case
	Case aReturn[8] == 1 // Indice por Depto/Data
		cKey := "QM2_FILIAL+QM2_DEPTO+QM2_REVINV"
   	Case aReturn[8] == 2 // Indice por Data
		cKey := "QM2_FILIAL+DTOS(QM2_VALDAF)+QM2_REVINV"
	Case aReturn[8] == 3 // Indice por Instrumento
		cKey := "QM2_FILIAL+QM2_INSTR+QM2_REVINV"    
	Case aReturn[8] == 4 // Indice por familia
		cKey := "QM2_FILIAL+QM2_TIPO+QM2_REVINV"  
EndCase

cQuery := "SELECT QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_REVINV,QM2_VALDAF,QM2_FREQAF,"
cQuery += "QM2_DEPTO,QM2_RESP,QM2_TIPO,QM2_FABR,QM2_STATUS,QM2_LAUDO,QM2_LOCAL,QM2_FLAG,QM2_FILRES "
cQuery += "FROM "+RetSqlName("QM2")+" QM2 "					
cQuery += "WHERE "
cQuery += "QM2.QM2_FILIAL = '"			+xFilial("QM2")+	"' AND "
cQuery += "QM2.QM2_INSTR  BetWeen '"	+ mv_par01 +		"' AND '" + mv_par02 +			"' AND " 
cQuery += "QM2.QM2_DEPTO BetWeen '"		+ mv_par05 +		"' AND '" + mv_par06 + 			"' AND " 
cQuery += "QM2.QM2_TIPO BetWeen '"		+ mv_par12 +		"' AND '" + mv_par13 + 			"' AND " 
cQuery += "QM2.QM2_FABR BetWeen '"		+ mv_par14 +		"' AND '" + mv_par15 + 			"' AND " 
cQuery += "QM2.QM2_RESP BetWeen '"		+ mv_par21 +		"' AND '" + mv_par22 + 			"' AND " 
cQuery += "QM2.D_E_L_E_T_= ' ' "
cQuery += "ORDER BY " + SqlOrder(cKey)

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QM2_VALDAF","D",8,0)
dbSelectArea( "TRB" )                 
While !Eof()
	cRevAtual:= TRB->QM2_REVINS                       	
	cUltRev  := QMA010UltR(TRB->QM2_INSTR)	
	If cRevAtual == cUltRev
		If mv_par26 == 2
			If QMTXSTAT(TRB->QM2_STATUS)
				If DtoS(TRB->QM2_VALDAF) >= DtoS(mv_par03) .and. DtoS(TRB->QM2_VALDAF) <= DtoS(mv_par04) 
					Aadd(aInstru,{TRB->QM2_FILIAL,TRB->QM2_INSTR,TRB->QM2_REVINS,TRB->QM2_REVINV,;
					TRB->QM2_VALDAF,TRB->QM2_FREQAF,TRB->QM2_DEPTO,TRB->QM2_RESP,;
					TRB->QM2_TIPO,TRB->QM2_FABR,TRB->QM2_STATUS,TRB->QM2_LAUDO,;
					TRB->QM2_LOCAL,TRB->QM2_FILRES})
				Endif		
			Endif
		Else	           
			If DtoS(TRB->QM2_VALDAF) >= DtoS(mv_par03) .and. DtoS(TRB->QM2_VALDAF) <= DtoS(mv_par04) 
				Aadd(aInstru,{TRB->QM2_FILIAL,TRB->QM2_INSTR,TRB->QM2_REVINS,TRB->QM2_REVINV,;
				TRB->QM2_VALDAF,TRB->QM2_FREQAF,TRB->QM2_DEPTO,TRB->QM2_RESP,;
				TRB->QM2_TIPO,TRB->QM2_FABR,TRB->QM2_STATUS,TRB->QM2_LAUDO,;
				TRB->QM2_LOCAL,TRB->QM2_FILRES})
			Endif						
		Endif
	Endif	
	dbSkip()
Enddo

SetRegua(RecCount())                  

While nTm <= Len(aInstru) 
	cFilialTRB	:= aInstru[nTm][1]
	TRB_INSTR	:= aInstru[nTm][2]
	TRB_REVINS	:= aInstru[nTm][3]
	TRB_REVINV	:= aInstru[nTm][4]
	TRB_VALDAF	:= aInstru[nTm][5]
	TRB_FREQAF	:= aInstru[nTm][6]
	TRB_DEPTO	:= aInstru[nTm][7]
	TRB_RESP	:= aInstru[nTm][8]
	TRB_TIPO	:= aInstru[nTm][9]
	TRB_FABR	:= aInstru[nTm][10]
	TRB_STATUS	:= aInstru[nTm][11]
	TRB_LAUDO	:= aInstru[nTm][12]
	TRB_LOCAL	:= aInstru[nTm][13] 
	TRB_FILRES	:= aInstru[nTm][14]				
		
	IncRegua()
	
	If lAbortPrint
		li := li + 1
      	@li,001 PSAY OemToAnsi(STR0008)  //"CANCELADO PELO OPERADOR"
		Exit
	EndIf

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica se status do instrumento esta ativo                    ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If mv_par26 == 2
	   If !QMTXSTAT(TRB_STATUS)
			nTm++   		
			dbskip()
			loop
	   EndIf
   Else
		If ( TRB_STATUS < mv_par19) .Or. (TRB_STATUS > mv_par20)
			nTm++   		
			dbskip()
			loop	
		Endif
   Endif
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

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura o departamento no QAD - Centro de Custo.             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	dbSelectArea("QAD")
	dbSetOrder(1)
	If dbSeek( xFilial("QAD") + TRB_DEPTO )
	    TRB_CUSTO := QAD->QAD_CUSTO
	Else
	    nTm++
	    dbSkip()
	    Loop
	Endif    

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura a descricao da familia no QM1                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "QM1" )
	dbSetOrder( 1 )
	dbSeek( xFilial("QM1") + TRB_TIPO )
	TRB_TDESCR	:= QM1->QM1_DESCR
	TRB_FILRES	:= aInstru[nTm][14]
	TRB_DATCO 	:= StrZero(Month(TRB_VALDAF),2) + "/"+ Str(YEAR(TRB_VALDAF),4)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Atribui indice a cChave (Departamento/Val.Afericao(Inteiro)/Val.Afericao)³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If aReturn[8] == 1 .And. mv_par23 == 1
		If mv_par23 == 1 //Quebra Departamento e pagina
			If !Empty(cChv) //Primeira vez nao imprimir subtotal
				If (!TRB_DEPTO == cChv)
					MTR010Sub(@cChv,@nCntParc,@nCntTot)		
					cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
					lVez := .F.
				Endif	
			Endif	
			cChv := TRB_DEPTO
		Else
			lVez := .T.
		Endif
	ElseIf aReturn[8] == 2 .And. mv_par24 == 1
		If mv_par23 == 1 //Quebra Data completa e pagina
			If !Empty(cChv) //Primeira vez nao imprimir subtotal
				If (!DtoS(TRB_VALDAF) == cChv)
					MTR010Sub(@cChv,@nCntParc,@nCntTot)		
					cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
					lVez := .F.
				Endif	
			Endif	
			cChv := dtos(TRB_VALDAF)
		Else
			lVez := .T.
		Endif
	ElseIf aReturn[8] == 2 .And. mv_par24 == 2
		If mv_par23 == 1 //Quebra Data resumida e pagina
			If !Empty(cChv) //Primeira vez nao imprimir subtotal
				If (!TRB_DATCO == cChv)
					MTR010Sub(@cChv,@nCntParc,@nCntTot)		
					cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
					lVez := .F.
				Endif	
			Endif	
			cChv := StrZero(Month(TRB_VALDAF),2) + "/" + Str(YEAR(TRB_VALDAF),4)
		Else
			lVez := .T.
		Endif
	ElseIf aReturn[8] == 3 //Ordem por Instrumento
		If mv_par23 == 1 //Quebra Data resumida e pagina
			If !Empty(cChv) //Primeira vez nao imprimir subtotal
				If (!TRB_INSTR == cChv)
					MTR010Sub(@cChv,@nCntParc,@nCntTot)		
					cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
					lVez := .F.
				Endif	
			Endif	
			cChv := TRB_INSTR
		Else
			lVez := .T.
		Endif
	ElseIf aReturn[8] == 4 //Tipo
		If mv_par23 == 1 //Quebra Data resumida e pagina
			If !Empty(cChv) //Primeira vez nao imprimir subtotal
				If (!TRB_TIPO == cChv)
					MTR010Sub(@cChv,@nCntParc,@nCntTot)		
					cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
					lVez := .F.
				Endif	
			Endif	
			cChv := TRB_TIPO
		Else
			lVez := .T.
		Endif	
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica a se deve dar subtotal - caso nao exista quebra por pagina		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lVez
		MTR010Sub(@cChv,@nCntParc,@nCntTot)     
	Endif

	lVez := .T.

	If  mv_par16 == 1 .or. mv_par17 == 1 .or.mv_par18 == 1  //Se imprime?   
		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
	Else
		If li > 55
			cabec(titulo,cabec1,"",nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
    Endif
	/*
   	       1         2         3         4         5         6         7         8         9         0         1         2         3            4         5         6         7         8         9         0
	012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	Departamento      Instrumento         Familia                                   Fabricante        Freq.                       Val.Calibr.                     Usuario                 Laudo
   	                  		Localizacao         Descricao                                             Dias    ESCALA                     REDUTOR        TOLER. PROCESSO
	XXXXXXXXXX        XXXXXXXXXXXXXXXX    XXXXXXXXXXXXXXXX                     XXXXXXXXXXXXXXXX       9999    99/99/99            XXXXXXXXXXX                     XXXXXXXXXX              XXXXXXXXXXXXXXXXX
   	                        XXXXXXXXXXXXXXXX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                           XXXXXXXXXXXXXXXX           XX             XXXXXXXXXX
	*/

	@ li,000 PSAY TRB_CUSTO
	@ li,022 PSAY TRB_INSTR
	@ li,048 PSAY TRB_TIPO
	@ li,080 PSAY TRB_FABR
	@ li,108 PSAY ALLTRIM(STR(TRB_FREQAF,4))
	If mv_par24 == 2
		cValDaf := StrZero(MONTH(TRB_VALDAF),2)+"/"+;
					  Str(YEAR (TRB_VALDAF),4)
	Else
		cValDaf := Dtoc(TRB_VALDAF)
	EndIf
	@ li,126 PSAY cValDaf

	QAA->(DbSetOrder(1))
	QAA->(DbSeek(TRB_FILRES+TRB_RESP))
	If !QAA->(Eof())
		@ li,158 PSAY SubStr(QAA->QAA_NOME,1,30)
	EndIf

	If TRB_LAUDO=="3"
	   @ li,190 PSAY Tabela("QA","APROV") //182
	Elseif TRB_LAUDO=="2"
	   @ li,190 PSAY Tabela("QA","APREST")
	ElseIf TRB_LAUDO=="1"
	   @ li,190 PSAY Tabela("QA","REPROV")
	Else                                    
		@ li,190 PSAY OemToAnsi(STR0014) //Nao Calibrado
	EndIf
	li++  

	If lImpLin2
		If mv_par16 == 1 .or. mv_par17 == 1 .or. mv_par18 == 1
			If li > 50
				cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
			EndIf
		Else
			If li > 55
				cabec(titulo,cabec1,"",nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
			EndIf
		Endif	

		@li,030 PSAY IIF(mv_par17 == 1, TRB_LOCAL, " ")
		@li,053 PSAY IIF(mv_par16 == 1, TRB_TDESCR, " ") 

		If mv_par18 == 1    
			// Pego o redutor do instrumento por escala
			dbSelectArea("QMR")
			dbSetOrder(1)
			If dbSeek(xFilial("QMR")+TRB_INSTR+TRB_REVINS)
				While ! Eof() .And. QMR->QMR_FILIAL+QMR->QMR_INSTR+QMR->QMR_REVINS == ;
					xFilial("QMR")+TRB_INSTR+TRB_REVINS
					If QMR->QMR_CAOBRI == "S"
						li++
						@li,118 PSAY QMR->QMR_ESCALA
						@li,135 PSAY QMR->QMR_REDUT
						@li,155 PSAY QMR->QMR_TOLPRO					
					EndIf						
					dbSkip()
				EndDo
				li++
				@li,00 PSAY __PrtThinLine()
			EndIf				
		Else
			li++			
		EndIf
	EndIf
	li++
	nCntParc++
	nCntTot++
	nTm++
EndDo

If Len(aInstru) > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica a se deve dar subtotal                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	MTR010Sub(@cChv,@nCntParc,@nCntTot)

    If !lImpSub //Garantir impressao do ultimo subtotal
		li++
		If  mv_par16 == 1 .or. mv_par17 == 1 .or.mv_par18 == 1  //Se imprime?   
			If li > 50
				cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
			EndIf
		Else
			If li > 55
				cabec(titulo,cabec1,"",nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
			EndIf
		Endif
		@ li,010 PSAY OemToAnsi(STR0011)+Str(nCntParc,5)    	
		li++
    Endif
	
	li:= li+2

	If  mv_par16 == 1 .or. mv_par17 == 1 .or.mv_par18 == 1  //Se imprime?   
		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
	Else
		If li > 55
			cabec(titulo,cabec1,"",nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
	Endif

	If nCntTot > 0
		@ li,010 PSAY OemToAnsi(STR0012)+Str(nCntTot,5) //Total........................:
	Endif
	li++                     
		If  mv_par16 == 1 .or. mv_par17 == 1 .or.mv_par18 == 1  //Se imprime?   
		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
	Else
		If li > 55
			cabec(titulo,cabec1,"",nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
    Endif
	@li,00 PSAY __PrtThinLine() 
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se a linha for 80, ‚ porque nao foi impresso nem a 1§ pag    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If li != 80
	 Roda( cbCont, cbTxt, cTamanho )
EndIf

Set Device To Screen

If File(cIndex+OrdBagExt())
	Set Filter To
	RetIndex("QM2")
	dbClearInd()
	FErase(cIndex+OrdBagExt())
	dbCloseArea()
Else	
	dbSelectArea("TRB")
	dbCloseArea()
	dbSelectArea("QM2")
	dbSetOrder(1)
EndIf
dbSelectArea(cAlias)
dbSetOrder(nOrdem)

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
±±³Fun‡…o    ³ MTR010SUB³ Autor ³ Wanderley Goncalves   ³ Data ³ 24.06.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime subtotal                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MTR010SUB()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTR010Sub(cChv,nCntParc,nCntTot)

If (aReturn[8] == 1 .and. mv_par23 == 1 .and. !(TRB_DEPTO == cChv)) .or.; 	     // Por departamento com quebra
   (areturn[8] == 2 .and. mv_par24 == 1 .and. !(cChv == dtos(TRB_VALDAF))) .or.; // Por data cheia
   (areturn[8] == 2 .and. mv_par24 == 2 .and. !(cChv == StrZero(Month(TRB_VALDAF),2)+ "/"+Str(YEAR(TRB_VALDAF),4)) .or.;  // Por data no formato MM/AAAA
   (aReturn[8] == 3 .and. mv_par23 == 1 .and. !(TRB_INSTR == cChv)).or.;         //Por instrumento
   (aReturn[8] == 4 .and. mv_par23 == 1 .and. !(TRB_TIPO == cChv)))              //Por tipo              						
	li++
	If  mv_par16 == 1 .or. mv_par17 == 1 .or.mv_par18 == 1  //Se imprime?   
		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
	Else
		If li > 55
			cabec(titulo,cabec1,"",nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
    Endif
    If nCntParc >0 
		@ li,010 PSAY OemToAnsi(STR0011)+Str(nCntParc,5)	//Subtotal.....................:
	Endif
	li++
	If  mv_par16 == 1 .or. mv_par17 == 1 .or.mv_par18 == 1  //Se imprime?   
		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
	Else
		If li > 55
			cabec(titulo,cabec1,"",nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
		EndIf
    Endif
	@li,00 PSAY __PrtThinLine() 
	nCntParc := 0
	li:= li+2
	lImpSub := .T.
Else
	lImpSub := .F.
EndIf

//Atribui valores a cChv (Ordem de impressao)
If aReturn[8] == 1 .and. mv_par23 == 1
	cChv := TRB_DEPTO 
ElseIf areturn[8] == 2 .and. mv_par24 == 1
	cChv := dtos(TRB_VALDAF)
ElseIf areturn[8] == 2 .and. mv_par24 == 2
	cChv := StrZero(Month(TRB_VALDAF),2)+ "/"+Str(YEAR(TRB_VALDAF),4)
ElseIf areturn[8] == 3 
	cChv := TRB_INSTR
ElseIf areturn[8] == 4 
	cChv := TRB_TIPO
Endif

Return(Nil)
