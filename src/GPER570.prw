/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "GPEA1110.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "Report.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER570 ³ Autor ³ Natie Sugahara         ³ Data ³ 30/12/03     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relaciona os Lancamento Futuros do SRK                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 			ALTERACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Data     ³ FNC      ³ Programador ³ Descricao                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³14/03/2013³M12RH01   ³Raquel Hager ³Remocao de funcoes e tratamentos para  ³±±
±±³        	 ³RQ4502    ³             ³imp. do relatorio com 2 ordens.        ³±± 
±±³28/10/2013³M12RH01   ³Raquel Hager ³Remocao de tratamentos para quando nao ³±±
±±³        	 ³RQ4502    ³             ³for Top Connect.					      ³±±
±±³30/05/2016³TVFY37    ³Gustavo M.	  ³Ajuste no controle dos acessos do usua-³±±
±±³        	 ³		    ³             ³rio.								      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/                                
User Function GPER570()  
Local	aArea 	:= GetArea()
Local 	oReport 
Private aOrd	:={	OemToAnsi(STR0046)+"+"+OemToAnsi(STR0071)							,;	// "Matricula+Lançcamentos"	
					OemToAnsi(STR0069)+"+"+OemToAnsi(STR0046)+"+"+OemToAnsi(STR0071)	,;	// "C.Custo+Matricula+Lancamentos"
					OemToAnsi(STR0068)+"+"+OemToAnsi(STR0071)}								// "Verba+Lancamentos"
Private cPerg		:= "GP570F4"
Private cVerbas		:= ""
Private cAliasDyn	:= "" 
	    
	// Interface de impressao
	Pergunte(cPerg,.F.)
	oReport := ReportDef()
	oReport:PrintDialog()
	
	RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef ³ Autor ³ Tatiane Matias       ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao do relatorio.                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()   
Local oReport 
Local oSecSRA
Local oSecSRV
Local oSecSRK
Local oSecCTT
	
	DEFINE REPORT oReport NAME "GPER570" TITLE OemToAnsi(STR0009) PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION oEmToAnsi(STR0045) TOTAL IN COLUMN	
	// "Valores Futuros"###"Esta rotina gera um extrato dos valores futuros lancados e que serão gerados em  folha de pagamento conforme  a data de vencimento. "
	oReport:SetLandscape(.T.)
	oReport:nFontBody	:= 8
	oReport:SetDynamic()  		//Indica que e um relatorio dinamico, ou seja, posso escolher a ordem do mesmo
	  	
		DEFINE SECTION oSecSRA OF oReport TABLES "SRA" ORDERS aOrd TITLE OemToAnsi(STR0040) TOTAL IN COLUMN // "Funcionarios"
			
			DEFINE CELL NAME "RA_FILIAL" 	OF oSecSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_MAT" 		OF oSecSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_NOME"		OF oSecSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_CC"      	OF oSecSRA ALIAS "SRA" 
	
			oSecSRA:Disable()
			oSecSRA:SetDynamicKey(OemToAnsi(STR0046))	//"Matrícula"
	
	
		DEFINE SECTION oSecCTT OF oReport TABLES "CTT" ORDERS aOrd TITLE OemToAnsi(STR0070) TOTAL IN COLUMN // "Centro de Custo"
			
			DEFINE CELL NAME "CTT_FILIAL" 	OF oSecCTT ALIAS "CTT"
			DEFINE CELL NAME "CTT_CUSTO"   	OF oSecCTT ALIAS "CTT" 
	
			oSecCTT:Disable()
			oSecCTT:SetDynamicKey(OemToAnsi(STR0069))	//"C.Custo"
	
	
		DEFINE SECTION oSecSRK OF oReport TABLES "SRA", "SRK", "SRV" TITLE OemToAnsi(STR0009) // " Valores Futuros "
		oSecSRK:AutoSize()
			TRPosition():New(oSecSRK,"SRV",1,{||RhFilial("SRV",(cAliasDyn)->RK_FILIAL)+(cAliasDyn)->RK_PD})
			
			DEFINE CELL NAME "RA_FILIAL" 	OF oSecSRK ALIAS "SRA"
			DEFINE CELL NAME "RA_MAT" 		OF oSecSRK ALIAS "SRA" SIZE TamSx3("RA_MAT")[1]
			DEFINE CELL NAME "RA_NOME"		OF oSecSRK ALIAS "SRA" SIZE 15 
	
			DEFINE CELL NAME "RK_PD" 		OF oSecSRK ALIAS "SRK" TITLE STR0068 			// "Verba"
			DEFINE CELL NAME "RV_DESC"		OF oSecSRK ALIAS "SRV" SIZE 8
			DEFINE CELL NAME "RK_VALORTO"	OF oSecSRK ALIAS "SRK" TITLE STR0040 SIZE 12 	// "Vlr. Princ."
			DEFINE CELL NAME "RK_PARCELA"	OF oSecSRK ALIAS "SRK" TITLE STR0049 SIZE 4 	// "Parc."
			DEFINE CELL NAME "RK_VALORPA"	OF oSecSRK ALIAS "SRK" TITLE STR0042 SIZE 12 	// "Vlr Parc."
			DEFINE CELL NAME "RK_JUROANO"	OF oSecSRK ALIAS "SRK" TITLE STR0050			// "Jrs.Ano"
			DEFINE CELL NAME "RK_JUROMES"	OF oSecSRK ALIAS "SRK" TITLE STR0051			// "Jrs.Mes"
			DEFINE CELL NAME "VLCOMJUROS"	OF oSecSRK ALIAS "   " TITLE STR0041 PICTURE "@E 999,999,999.99" // "Vlr c/ Jrs"
			DEFINE CELL NAME "RK_VLRPAGO"	OF oSecSRK ALIAS "SRK" TITLE STR0043 SIZE 12	// "Vlr.Pago"
			DEFINE CELL NAME "RK_VALORAR"	OF oSecSRK ALIAS "SRK" TITLE STR0047 SIZE 12	// "Vlr.Residuo"
			DEFINE CELL NAME "RK_VLSALDO" 	OF oSecSRK ALIAS "SRK" SIZE 12
			DEFINE CELL NAME "RK_DTVENC"	OF oSecSRK ALIAS "SRK"
			DEFINE CELL NAME "RK_DTMOVI"	OF oSecSRK ALIAS "SRK" TITLE STR0052			// "Dt.Mov."
			DEFINE CELL NAME "RK_PERINI"	OF oSecSRK ALIAS "SRK" TITLE STR0053 SIZE 6		// "Per. Ini"
			DEFINE CELL NAME "RK_NUMPAGO"	OF oSecSRK ALIAS "SRK" TITLE "Pg" 	 SIZE 2
	
			
			oSecSRK:Cell("RA_FILIAL"):Disable()
			oSecSRK:Cell("RA_MAT"   ):Disable()
			oSecSRK:Cell("RA_NOME"  ):Disable()

			oSecSRK:Disable()
			oSecSRK:SetDynamicKey(OemToAnsi(STR0071))	//"Lançamentos"
	 
	
		DEFINE SECTION oSecSRV OF oReport TABLES "SRV", "SRK" TITLE OemToAnsi(STR0068) // "Verba"
		oSecSRV:SetLineStyle()
		TRPosition():New(oSecSRV,"SRV",1,{||RhFilial("SRV",(cAliasDyn)->RK_FILIAL)+(cAliasDyn)->RK_PD})		
	
			DEFINE CELL NAME "RV_COD" 		OF oSecSRV ALIAS "SRV" TITLE STR0068 			// "Verba"
			DEFINE CELL NAME "RV_DESC"		OF oSecSRV ALIAS "SRV" SIZE 10
	
			oSecSRV:SetDynamicKey(OemToAnsi(STR0068))	//"Verba"
			oSecSRV:Disable()   
			
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport ³ Autor ³ Tatiane Matias       ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao do relatorio.                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport) 
Local oSection1 	 
Local oSection2
Local oSection3 	
Local cFiltro		:= ""  
Local cOrdem		:= ""
Local cQVerba		:= ""  
Local cAcessaSRK	:= ChkRH( "GPER570" , "SRK" , "2" )
Local cTopAcessaSrk	:= If( Type(cAcessaSRK)!="L", " AND ("+GPEParSQL(cAcessaSRK)+")","")
Local cAliasSRK		:= "" 
Local cRProc		:= ""
Local cAuxPrc 		:= ""
Local cIndCond		:= ""
Local cTitCc		:= ""
Local cTitFil 		:= ""
Local cTitPd		:= ""
Local cValidFil		:= ""
Local aValidFil		:= StrToArray(fValidFil(),"/")
Local nX			:= 0
Local nReg			:= 0
Local nTamCod		:= 0
Local nOrdem		:= oReport:GetOrder() 
Local nSRKOrdem		:= RetOrdem("SRK","RK_FILIAL+RK_MAT+RK_PD+DTOS(RK_DTMOVI)" )
Local dVenc, dMov
 
	cAcessaSRK	:= &( " { || " + cAcessaSRK + " } " )                        
	
  // Acessa parametros do relatorio...                                        
  //Variaveis utilizadas para parametros                                    
	cVerbas 	:= mv_par06												// Verbas 
	cProcessos	:= If( Empty(mv_par07),"", AllTrim(mv_par07) )			// Processos para Impressao
	nSaldo		:= mv_par08												// Opcao Impressao Saldo
	cPeriodoDe	:= mv_par09		  										// Periodo De
	cNroPagoDe	:= mv_par10												// Numero de Pagamento De
	cPeriodoAte	:= mv_par11		  										// Periodo Ate
	cNroPagoAte	:= mv_par12		  										// Numero de Pagamento Ate
	dVenc 		:= mv_par05
	dMov		:= mv_par04
	                                                     
	If nOrdem == 1
		cOrdem := "%RA_FILIAL,RA_MAT,RK_PD,RK_DTMOVI%"	// Matricula + Verba
		oSection1	:= oReport:Section(1)                                                   
		oSection2	:= oReport:Section(3)
		oSection2:SetCellBorder("ALL",,,.T.)
		oSection2:SetCellBorder("RIGHT")
		oSection2:SetCellBorder("LEFT")
		oSection2:SetCellBorder("BOTTOM") 
		oSection1:SetLineStyle()
		if oReport:nDevice == 4 .And. oReport:nExcelPrintType == 3
			oSection2:Cell("RA_FILIAL"):Enable()
			oSection2:Cell("RA_MAT"):Enable()
			oSection2:Cell("RA_NOME"):Enable()
		endif 
	ElseIf nOrdem == 2
		cOrdem := "%RA_FILIAL,RA_CC,RA_MAT,RK_PD,RK_DTMOVI%"	// Centro de Custo + Matrícula + Verba                 
		oSection1	:= oReport:Section(2)
		oSection2	:= oReport:Section(1)
		oSection3	:= oReport:Section(3)
		oSection2:Cell("RA_FILIAL"):Disable()
		oSection2:Cell("RA_CC"    ):Disable()
		if oReport:nDevice == 4 .And. oReport:nExcelPrintType == 3
			oSection3:Cell("RA_FILIAL"):Enable()
			oSection3:Cell("RA_MAT"):Enable()
			oSection3:Cell("RA_NOME"):Enable()
		endif 
		oSection3:SetCellBorder("ALL",,,.T.)
		oSection3:SetCellBorder("RIGHT")
		oSection3:SetCellBorder("LEFT")
		oSection3:SetCellBorder("BOTTOM") 
		oSection1:SetLineStyle()
		oSection2:SetLineStyle()
	ElseIf nOrdem == 3
		cOrdem := "%RK_FILIAL,RK_PD,RK_MAT%"	// Verba + Matrícula 
		oSection1	:= oReport:Section(4)
		oSection2	:= oReport:Section(3)
		oSection2:SetLeftMargin(5)
		oSection2:Cell("RA_FILIAL"):Enable()
		oSection2:Cell("RA_MAT"   ):Enable()
		oSection2:Cell("RA_NOME"  ):Enable()
		oSection2:Cell("RK_PD"    ):Disable()
		oSection2:Cell("RV_DESC"  ):Disable()
	EndIf

		
	If nOrdem == 1         
	
		DEFINE BREAK oBreak OF oReport WHEN oSection1:Cell("RA_FILIAL") TITLE OemToAnsi(STR0021) 		// "Total da Filial"   
			
			DEFINE FUNCTION FROM oSection2:Cell("RK_VALORTO") FUNCTION SUM BREAK oBreak NO END SECTION NO END REPORT
			DEFINE FUNCTION FROM oSection2:Cell("RK_VALORPA") FUNCTION SUM BREAK oBreak NO END SECTION NO END REPORT
			DEFINE FUNCTION FROM oSection2:Cell("VLCOMJUROS") FUNCTION SUM BREAK oBreak NO END SECTION NO END REPORT
			DEFINE FUNCTION FROM oSection2:Cell("RK_VLRPAGO") FUNCTION SUM BREAK oBreak NO END SECTION NO END REPORT
			DEFINE FUNCTION FROM oSection2:Cell("RK_VALORAR") FUNCTION SUM BREAK oBreak NO END SECTION NO END REPORT
			DEFINE FUNCTION FROM oSection2:Cell("RK_VLSALDO") FUNCTION SUM BREAK oBreak NO END SECTION NO END REPORT
		
			oBreak:OnBreak({|x,y|cTitFil:=OemToAnsi(STR0021)+": "+x}) // "Total da Filial"
			oBreak:SetTotalText({||cTitFil})
			
			DEFINE COLLECTION OF oSection2 FUNCTION SUM FORMULA {|| oSection2:Cell("RK_PD"):GetValue(.T.) + " - " + oSection2:Cell("RV_DESC"):GetValue(.T.) } CONTENT oSection2:Cell("RK_VALORTO") 	BREAK oBreak  TITLE OemToAnsi(STR0040) PICTURE "@E 999,999,999.99" 	NO END SECTION NO END REPORT	// "Vlr. Princ."
			DEFINE COLLECTION OF oSection2 FUNCTION SUM FORMULA {|| oSection2:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection2:Cell("RK_VALORPA") 	BREAK oBreak  NO END SECTION NO END REPORT TITLE OemToAnsi(STR0042) PICTURE "@E 999,999,999.99" 		// "Vlr.Parc."
			DEFINE COLLECTION OF oSection2 FUNCTION SUM FORMULA {|| oSection2:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection2:Cell("VLCOMJUROS") 	BREAK oBreak  NO END SECTION NO END REPORT TITLE OemToAnsi(STR0041) PICTURE "@E 999,999,999.99" 		// "Vlr c/ Jrs"
			DEFINE COLLECTION OF oSection2 FUNCTION SUM FORMULA {|| oSection2:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection2:Cell("RK_VLRPAGO") 	BREAK oBreak  NO END SECTION NO END REPORT TITLE OemToAnsi(STR0043) PICTURE "@E 999,999,999.99" 		// "Vlr Pago"
			DEFINE COLLECTION OF oSection2 FUNCTION SUM FORMULA {|| oSection2:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection2:Cell("RK_VALORAR") 	BREAK oBreak  NO END SECTION NO END REPORT TITLE OemToAnsi(STR0047) PICTURE "@E 999,999,999.99"			// "Vlr Residuo"
			DEFINE COLLECTION OF oSection2 FUNCTION SUM FORMULA {|| oSection2:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection2:Cell("RK_VLSALDO") 	BREAK oBreak  NO END SECTION NO END REPORT TITLE OemToAnsi(STR0048) PICTURE "@E 999,999,999.99"			// "Saldo"
	
	ElseIf nOrdem == 2    
	
		DEFINE BREAK oBreakCC OF oReport WHEN  oSection1:Cell("CTT_CUSTO") TITLE OemToAnsi(STR0044) //"Total do Centro de Custo "
			DEFINE FUNCTION NAME "CVALORTO" FROM oSection3:Cell("RK_VALORTO") FUNCTION SUM  BREAK oBreakCc NO END SECTION NO END REPORT TITLE OemToAnsi(STR0040) PICTURE "@E 99,999,999,999.99"     //"Vlr.Princ."
			DEFINE FUNCTION NAME "CVALORPA" FROM oSection3:Cell("RK_VALORPA") FUNCTION SUM  BREAK oBreakCc NO END SECTION NO END REPORT TITLE OemToAnsi(STR0042) PICTURE "@E 99,999,999,999.99"     //"Vlr.Parc."
			DEFINE FUNCTION NAME "CVLCJURS" FROM oSection3:Cell("VLCOMJUROS") FUNCTION SUM  BREAK oBreakCc NO END SECTION NO END REPORT TITLE OemToAnsi(STR0041) PICTURE "@E 99,999,999,999.99"  	//"Vlr.c/Jrs."
			DEFINE FUNCTION NAME "CVLRPAGO" FROM oSection3:Cell("RK_VLRPAGO") FUNCTION SUM  BREAK oBreakCc NO END SECTION NO END REPORT TITLE OemToAnsi(STR0043) PICTURE "@E 99,999,999,999.99"  	//"Vlr.Pago"
			DEFINE FUNCTION NAME "CVALORAR" FROM oSection3:Cell("RK_VALORAR") FUNCTION SUM  BREAK oBreakCc NO END SECTION NO END REPORT TITLE OemToAnsi(STR0047) PICTURE "@E 99,999,999,999.99"  	//"Vlr.Residuo"
			DEFINE FUNCTION NAME "CVLSALDO" FROM oSection3:Cell("RK_VLSALDO") FUNCTION SUM  BREAK oBreakCc NO END SECTION NO END REPORT TITLE OemToAnsi(STR0048) PICTURE "@E 99,999,999,999.99"  	//"Saldo"
			oBreakCc:OnBreak({|x,y|cTitCc:=OemToAnsi(STR0044)+" "+x})	//"Total do Centro de Custo"
	    	oBreakCc:SetTotalText({||cTitCc})
	    	oBreakCc:SetTotalInLine(.F.)                                        
	
		DEFINE BREAK oBreak OF oReport WHEN oSection1:Cell("CTT_FILIAL") TITLE OemToAnsi(STR0021)		// "Total da Filial"
			DEFINE FUNCTION FROM oSection3:Cell("RK_VALORTO") FUNCTION SUM BREAK oBreak NO END SECTION 	NO END REPORT
			DEFINE FUNCTION FROM oSection3:Cell("RK_VALORPA") FUNCTION SUM BREAK oBreak NO END SECTION	NO END REPORT
			DEFINE FUNCTION FROM oSection3:Cell("VLCOMJUROS") FUNCTION SUM BREAK oBreak NO END SECTION	NO END REPORT
			DEFINE FUNCTION FROM oSection3:Cell("RK_VLRPAGO") FUNCTION SUM BREAK oBreak NO END SECTION	NO END REPORT
			DEFINE FUNCTION FROM oSection3:Cell("RK_VALORAR") FUNCTION SUM BREAK oBreak NO END SECTION	NO END REPORT
			DEFINE FUNCTION FROM oSection3:Cell("RK_VLSALDO") FUNCTION SUM BREAK oBreak NO END SECTION	NO END REPORT
		
			oBreak:OnBreak({|x,y|cTitFil:=OemToAnsi(STR0021)+": "+x}) //"Total da Filial"
			oBreak:SetTotalText({||cTitFil})
			
			DEFINE COLLECTION OF oSection3 FUNCTION SUM FORMULA {|| oSection3:Cell("RK_PD"):GetValue(.T.) + " - " + oSection3:Cell("RV_DESC"):GetValue(.T.) } CONTENT oSection3:Cell("RK_VALORTO") 	BREAK oBreak  TITLE OemToAnsi(STR0040) PICTURE "@E 999,999,999.99" 	NO END SECTION NO END REPORT	// "Vlr. Princ."
			DEFINE COLLECTION OF oSection3 FUNCTION SUM FORMULA {|| oSection3:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection3:Cell("RK_VALORPA") 	BREAK oBreak  NO END SECTION NO END REPORT	TITLE OemToAnsi(STR0042) PICTURE "@E 999,999,999.99" 		// "Vlr Parc."
			DEFINE COLLECTION OF oSection3 FUNCTION SUM FORMULA {|| oSection3:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection3:Cell("VLCOMJUROS") 	BREAK oBreak  NO END SECTION NO END REPORT	TITLE OemToAnsi(STR0041) PICTURE "@E 999,999,999.99" 		// "Vlr c/ Jrs"
			DEFINE COLLECTION OF oSection3 FUNCTION SUM FORMULA {|| oSection3:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection3:Cell("RK_VLRPAGO") 	BREAK oBreak  NO END SECTION NO END REPORT	TITLE OemToAnsi(STR0043) PICTURE "@E 999,999,999.99" 		// "Vlr Pago"
			DEFINE COLLECTION OF oSection3 FUNCTION SUM FORMULA {|| oSection3:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection3:Cell("RK_VALORAR") 	BREAK oBreak  NO END SECTION NO END REPORT	TITLE OemToAnsi(STR0047) PICTURE "@E 999,999,999.99"		// "Vlr Residuo"
			DEFINE COLLECTION OF oSection3 FUNCTION SUM FORMULA {|| oSection3:Cell("RK_PD"):GetValue(.T.) } CONTENT oSection3:Cell("RK_VLSALDO") 	BREAK oBreak  NO END SECTION NO END REPORT	TITLE OemToAnsi(STR0048) PICTURE "@E 999,999,999.99"		// "Saldo"
			
	ElseIf nOrdem == 3 
	
		DEFINE BREAK oBreakPd OF oReport WHEN  oSection1:Cell("RV_COD") TITLE OemToAnsi(STR0038) //"Total da Verba"
			DEFINE FUNCTION NAME "VVALORTO" FROM oSection2:Cell("RK_VALORTO") FUNCTION SUM     BREAK oBreakPd NO END SECTION NO END REPORT TITLE OemToAnsi(STR0040) PICTURE "@E 99,999,999,999.99"		//"Vlr.Princ."
			DEFINE FUNCTION NAME "VVALORPA" FROM oSection2:Cell("RK_VALORPA") FUNCTION SUM     BREAK oBreakPd NO END SECTION NO END REPORT TITLE OemToAnsi(STR0042) PICTURE "@E 99,999,999,999.99"     //"Vlr.Parc."
			DEFINE FUNCTION NAME "VVLCJURS" FROM oSection2:Cell("VLCOMJUROS") FUNCTION SUM     BREAK oBreakPd NO END SECTION NO END REPORT TITLE OemToAnsi(STR0041) PICTURE "@E 99,999,999,999.99"		//"Vlr.c/Jrs."
			DEFINE FUNCTION NAME "VVLRPAGO" FROM oSection2:Cell("RK_VLRPAGO") FUNCTION SUM     BREAK oBreakPd NO END SECTION NO END REPORT TITLE OemToAnsi(STR0043) PICTURE "@E 99,999,999,999.99"		//"Vlr.Pago"
			DEFINE FUNCTION NAME "VVALORAR" FROM oSection2:Cell("RK_VALORAR") FUNCTION SUM     BREAK oBreakPd NO END SECTION NO END REPORT TITLE OemToAnsi(STR0047) PICTURE "@E 99,999,999,999.99"		//"Vlr.Residuo"
			DEFINE FUNCTION NAME "VVLSALDO" FROM oSection2:Cell("RK_VLSALDO") FUNCTION SUM     BREAK oBreakPd NO END SECTION NO END REPORT TITLE OemToAnsi(STR0048) PICTURE "@E 99,999,999,999.99"		//"Saldo"
			oBreakPd:OnBreak({|x,y|cTitPd:=OemToAnsi(STR0038)+" "+x})	//"Total da Verba"
	    	oBreakPd:SetTotalText({||cTitPd})
	    	oBreakPd:SetTotalInLine(.F.)

	EndIf

	// Faz filtro no arquivo...
	cAliasDyn	:= GetNextAlias()

	MakeSqlExpr(cPerg)

	For nX:= 1 to Len(aValidFil)
		cValidFil += ", '" + aValidFil[nX] + "' "
	Next
	cFiltro := "SRA.RA_FILIAL IN ('' " + cValidFil +") AND "

	IF !Empty(dMov)
		CFILTRO += " SRK.RK_DTMOVI = '" + DTOS(DMOV) + "' AND "
	EndIf

	IF !Empty(dVenc)
		CFILTRO += " SRK.RK_DTVENC = '" + DTOS(dVenc) + "' AND "
	EndIf

	// Gerar lista de Itens dos Processos.
	If AllTrim( cProcessos  ) <> "*"
		nTamCod := GetSx3Cache( "RCJ_CODIGO" , "X3_TAMANHO" )
		For nReg := 1 to Len(cProcessos) step 5
			If Len(Subs(cProcessos,nReg,5)) < nTamCod
				cAuxPrc := Subs(cProcessos,nReg,5) + Space(nTamCod - Len(Subs(cProcessos,nReg,5)))
			Else
				cAuxPrc := Subs(cProcessos,nReg,5)
			EndIf
			cRProc += "'" + cAuxPrc + "',"
		Next nReg
		cRProc := Substr( cRProc, 1, Len(cRProc)-1)
	    If !Empty(cRProc)
			cFiltro += " SRA.RA_PROCES  IN (" + cRProc + ") AND "
		EndIf	

	EndIf         
	
	// Monta o as Verbas                                            
	If AllTrim( cVerbas  ) <> "*"
		cVerbas := Alltrim(cVerbas)
		cQVerba := ""
		For nReg := 1 To Len(cVerbas) Step 3
			cQVerba += "'"+Subs(cVerbas,nReg,3)+"'"
			If ( nReg+3 ) <= Len(cVerbas)
				cQVerba += "," 
			EndIf
		Next
		If !Empty(cQVerba)
			cFiltro += " SRK.RK_PD IN (" + cQVerba + ") AND "
		EndIf
	EndIf
                                  
	If nSaldo == 1
		cFiltro += " SRK.RK_VLSALDO	<> 0 AND "
	ElseIf nSaldo == 2
		cFiltro += " SRK.RK_VLSALDO = 0 AND "
	EndIf             
	
	cFiltro += " ((SRK.RK_PERINI BETWEEN '" + cPeriodoDe + "' AND '" + cPeriodoAte + "') OR " + ;
 			  	" (SRK.RK_PERINI = '" + cPeriodoDe + "' AND SRK.RK_NUMPAGO >= '" + cNroPagoDe + "') OR " + ;
 			  	" (SRK.RK_PERINI = '" + cPeriodoAte + "' AND SRK.RK_NUMPAGO <= '" + cNroPagoAte + "'))"
   
	cFiltro := If( !Empty(cTopAcessaSRK), cFiltro := "(" + cFiltro + cTopAcessaSrk + ")", cFiltro)
	cFiltro := "%" + cFiltro + "%"

	If nOrdem == 1 
		BEGIN REPORT QUERY oSection1
	
		BeginSql alias cAliasDyn                             
			%noparser% //nao passa pelo topconnect
			SELECT 	SRA.RA_FILIAL,  SRA.RA_MAT,     SRA.RA_NOME,    SRA.RA_CC,      SRK.RK_FILIAL,  SRK.RK_MAT, 
					SRK.RK_PD,      SRK.RK_VALORTO, SRK.RK_PARCELA, SRK.RK_VALORPA, SRK.RK_JUROANO, SRK.RK_JUROMES, 
					SRK.RK_VLRPAGO, SRK.RK_VALORAR, SRK.RK_VLSALDO, SRK.RK_DTVENC,  SRK.RK_DTMOVI,  SRK.RK_PERINI,
					SRK.RK_NUMPAGO, (SRK.RK_VALORPA * SRK.RK_PARCELA) VLCOMJUROS, SRV.RV_FILIAL,	 SRV.RV_COD,     SRV.RV_DESC 
			FROM 	%table:SRA% SRA 
			INNER JOIN %table:SRK% SRK 
			ON 		SRA.RA_FILIAL 	= SRK.RK_FILIAL 	AND
					SRA.RA_MAT 		= SRK.RK_MAT 		
			INNER JOIN %table:SRV% SRV 
			ON		SRV.RV_FILIAL = %exp:xFilial("SRV", SRK->RK_FILIAL)% AND 
					SRK.RK_PD		= SRV.RV_COD		 					
			WHERE	%exp:cFiltro%	AND
				 	SRA.%notDel%   	AND
				  	SRK.%notDel%	AND
				  	SRV.%notDel%    
			ORDER BY %exp:cOrdem%
	
		EndSql
	
		END REPORT QUERY oSection1 PARAM MV_PAR01, MV_PAR02, MV_PAR03
		
	ElseIf nOrdem == 2

		BEGIN REPORT QUERY oSection1
	
		BeginSql alias cAliasDyn                             
			%noparser% //Nao passa pelo topconnect
			SELECT 	SRA.RA_FILIAL,  SRA.RA_MAT,     SRA.RA_NOME,    SRA.RA_CC,      SRK.RK_FILIAL,  SRK.RK_MAT, 
					SRK.RK_PD,      SRK.RK_VALORTO, SRK.RK_PARCELA, SRK.RK_VALORPA, SRK.RK_JUROANO, SRK.RK_JUROMES,
					SRK.RK_VLRPAGO, SRK.RK_VALORAR, SRK.RK_VLSALDO, SRK.RK_DTVENC,  SRK.RK_DTMOVI,  SRK.RK_PERINI,
					SRK.RK_NUMPAGO, (SRK.RK_VALORPA * SRK.RK_PARCELA) VLCOMJUROS,   CTT.CTT_FILIAL, CTT.CTT_CUSTO,
					SRV.RV_FILIAL,	 SRV.RV_COD,     SRV.RV_DESC 
			FROM 	%table:SRA% SRA 
			INNER JOIN %table:SRK% SRK 
			ON 		SRA.RA_FILIAL 	= SRK.RK_FILIAL 	AND
					SRA.RA_MAT 		= SRK.RK_MAT 		
			LEFT JOIN %table:CTT% CTT
			ON		SRA.RA_FILIAL	= CTT.CTT_FILIAL	AND
					SRA.RA_CC		= CTT.CTT_CUSTO
			INNER JOIN %table:SRV% SRV 
			ON		SRV.RV_FILIAL = %exp:xFilial("SRV", SRK->RK_FILIAL)% AND 
					SRK.RK_PD		= SRV.RV_COD
			WHERE	%exp:cFiltro%	AND
				 	SRA.%notDel%   	AND
				  	SRK.%notDel%	AND 
				  	SRV.%notDel%    AND
				  	CTT.%notDel%
			ORDER BY %exp:cOrdem%
	
		EndSql
	
		END REPORT QUERY oSection1 PARAM MV_PAR01, MV_PAR02, MV_PAR03
		
	Else
		BEGIN REPORT QUERY oSection1
	
		BeginSql alias cAliasDyn                             
			%noparser% 
			SELECT 	SRK.RK_FILIAL,  SRK.RK_MAT,     SRK.RK_PD,      SRK.RK_VALORTO, SRK.RK_PARCELA, 
					SRK.RK_VALORPA, SRK.RK_JUROANO, SRK.RK_JUROMES, SRK.RK_VLRPAGO, SRK.RK_VALORAR, 
					SRK.RK_VLSALDO, SRK.RK_DTVENC,  SRK.RK_DTMOVI,  SRK.RK_PERINI,  SRK.RK_NUMPAGO, 
					(SRK.RK_VALORPA * SRK.RK_PARCELA) VLCOMJUROS,   SRA.RA_FILIAL,  SRA.RA_MAT,     
					SRA.RA_NOME,    SRA.RA_CC,      SRV.RV_FILIAL,	 SRV.RV_COD,     SRV.RV_DESC      
			FROM 	%table:SRK% SRK
			INNER JOIN %table:SRV% SRV 
			ON		SRV.RV_FILIAL = %exp:xFilial("SRV", SRK->RK_FILIAL)% AND 
					SRK.RK_PD		= SRV.RV_COD		 
			INNER JOIN %table:SRA% SRA 
			ON 		SRK.RK_FILIAL 	= SRA.RA_FILIAL 	AND
					SRK.RK_MAT 		= SRA.RA_MAT 		
			WHERE	%exp:cFiltro%	AND
				 	SRK.%notDel%   	AND
				  	SRA.%notDel%	AND
				  	SRV.%notDel%
			ORDER BY %exp:cOrdem%
	
		EndSql
	
		END REPORT QUERY oSection1 PARAM MV_PAR01, MV_PAR02, MV_PAR03
	
	EndIf
	
	// Relaciona a Section Filha (Valores Futuros) com a Section Pai (Funcionario)
	If nOrdem == 1
		// Matricula x Lancamentos
		oSection2:SetParentQuery()                   
		oSection2:SetParentFilter({|cParam|RK_FILIAL+RK_MAT==cParam},{||(cAliasDyn)->RA_FILIAL+(cAliasDyn)->RA_MAT })
		oSection2:SetLineCondition({|| (cAliasDyn)->( ( RK_FILIAL $ fValidFil() )/* .And. Eval( cAcessaSRK )*/) } )
	ElseIf nOrdem == 2
		// C.Custo x Matricula
		oSection2:SetParentQuery()    
		oSection2:SetParentFilter({|cParam|RA_FILIAL+RA_CC==cParam},{||(cAliasDyn)->CTT_FILIAL+(cAliasDyn)->CTT_CUSTO})
		// Matricula x Lancamentos
	    oSection3:SetParentQuery()
		oSection3:SetParentFilter({|cParam|RK_FILIAL+RK_MAT==cParam},{||(cAliasDyn)->RA_FILIAL+(cAliasDyn)->RA_MAT})
		oSection3:SetLineCondition({|| (cAliasDyn)->( ( RK_FILIAL $ fValidFil() ) /*.And. Eval( cAcessaSRK )*/) } )
	ElseIf nOrdem == 3
		// Verba x Lancamentos 
		oSection2:SetParentQuery()
        oSection2:SetParentFilter({|cParam|RK_FILIAL+RK_PD==cParam},{||(cAliasDyn)->RK_FILIAL+(cAliasDyn)->RK_PD})
		oSection2:SetLineCondition({|| (cAliasDyn)->( RK_FILIAL $ fValidFil() ) /*.And. Eval( cAcessaSRK )*/ } )
	EndIf
		
	oSection1:Print()
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³ U_Gp570ValidVerba()  ³ Autor ³ Tatiane Matias	  ³ Data ³ 11/07/2006     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Valida Verbas para Impressao dos Valores Futuros.					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ GPER570        	       	   	   	 	   	   	   	 	                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Gp570ValidVerba( )
Local lValid	:=	.F.  
	            
	lValid	:=	IIf ( Substr ( cVerbas , 1 , 1 ) == "*" , .T. , .F. )
	
	If !lValid
		lValid := fVerbas()
	EndIf
	
	If !lValid
		lValid := IIf ( Empty ( cVerbas ) , .F. , .T. )
	EndIf
     
Return ( lValid )    