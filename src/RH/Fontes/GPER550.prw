/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GPER550.CH"
#INCLUDE "report.ch"
#include "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ GPER550	³ Autor ³ Marinaldo de Jesus	³ Data ³12/07/2000  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Valores de Ferias				                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_GPER550(void)									            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³												                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso  	 ³ Generico 												    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 		ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.		        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ BOPS  ³Motivo da Alteracao					    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Carlos E. O.³01/11/2013³M12RH01³Retiradas funcoes referentes ao formato  ³±±
±±³            ³          ³       ³de relatorio R3.                         ³±± 
±±³Sidney O.   ³28/04/2014³M_RH003³Ajuste para converter campos Datas em    ³±±
±±³            |          |295105 |STRING quando for efetuado importacao de ³±±
±±³            |          |       |relatorio em excel. Replica P12          ³±±
±±³M. Silveira ³20/08/2014³ TQDUP7³Ajuste na fCondSRA() p/ que registros de ³±±
±±³            ³          ³       ³ferias validos nao sejam desconsiderados ³±±
±±³            ³          ³       ³ao avaliar as transferencias antigas.    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER550() 
Local aArea    		:= GetArea()                                               
Local oReport
Local cPerg			:= "GP550R" 

Private cAliasMov 	:= "SRA" 
Private cTurnoAnt 	:= ""
Private cCCAnt		:= ""
Private cFilaInfo	:= ""
Private aInfo		:= {} 

Private aFldRot 	:= {'RA_NOME'}
Private aOfusca	 	:= If(FindFunction('ChkOfusca'), ChkOfusca(), {.T.,.F.}) //[1] Acesso; [2]Ofusca
Private lOfuscaNom 	:= .F. //RA_NOME
Private aFldOfusca	:= {}

If aOfusca[2]
	aFldOfusca := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRot ) // CAMPOS SEM ACESSO
	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_NOME" } ) > 0
		lOfuscaNom := FwProtectedDataUtil():IsFieldInList( "RA_NOME" )
	ENDIF
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Forca a impressao no modo Landscape(horizontal)               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef()
oReport:SetLandScape()
oReport:PrintDialog()

fVerTransf(.T.)
RestArea(aArea) 

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Microsiga           º Data ³  07/21/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static function  ReportDef() 

Local oReport 						//-- Obejto do Relatorio 

//-- Objeto Section
Local oSection1   
Local oSection2   
Local oSection3   
Local oSection4   
Local oSection5   
Local oSection6   
Local oSection7   
Local oSection8 
Local oSection9   
Local oSection10   
Local oSection11 
Local oSection12  
Local oFunctionProv 
Local oFunctionDesc 

//-- Descricao do Relatorio 
Local	cDesc		:=	STR0006 + STR0007 //"Emiss„o de Valores de F‚rias."#"Dever  ser emitido ap¢s o Calculo de Ferias ."#"Ser  impresso de acordo com os parametros solicitados pelo usu rio."

//-- Ordens utilizadas pelo relatorio 
Local aOrd     := {	STR0001,; 			//"Matricula"
     			 	STR0002,;			//"Centro de Custo"
				 	STR0003,;			//"Nome"
				 	STR0004,;			//"Centro de Custo + Nome"
				 	STR0005 }			//"Turno"

	//-- Inicio definicao do Relatorio
	DEFINE REPORT oReport NAME "GPER550" TITLE STR0011 PARAMETER "GP550R" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc TOTAL IN COLUMN
	
		//-- Section de Filial
		DEFINE SECTION oSection1 OF oReport TABLES "SRA" TITLE STR0006 ORDERS aOrd  TOTAL IN COLUMN //EMISSAO DE VALORES DE FERIAS
		oSection1:SetHeaderBreak(.T.) 
		oSection1:SetLineStyle()										//-- Faz a impressao das celulas sequencialmente
				
			DEFINE CELL NAME "RA_FILIAL"	OF oSection1 ALIAS "SRA"
			DEFINE CELL NAME "DESCRICAO"	OF oSection1 				BLOCK {|| AllTrim( aInfo[2] )} SIZE 30

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Utilizada essa section para as ordens 1=Matricula e 3=Nome   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//-- Section de Funcionario
			DEFINE SECTION oSection2 OF oSection1 TABLES "SRA" TITLE STR0047 TOTAL IN COLUMN //"Ordens Matricula e Nome"
			oSection2:SetHeaderBreak(.T.)
			oSection2:SetLineStyle()       
				DEFINE CELL NAME "RA_FILIAL"	OF oSection2 ALIAS "SRA" 
				DEFINE CELL NAME "RA_CC"		OF oSection2 ALIAS "SRA"
				DEFINE CELL NAME "RA_TNOTRAB"	OF oSection2 ALIAS "SRA"
				DEFINE CELL NAME "RA_MAT"	    OF oSection2 ALIAS "SRA"
				DEFINE CELL NAME "RA_NOME"		OF oSection2 ALIAS "SRA"
				DEFINE CELL NAME "RA_DEPIR"		OF oSection2 ALIAS "SRA"  
				
				//-- Section de Cabecalho de Ferias (SRH)
				DEFINE SECTION oSection3 OF oSection2 TABLES "SRH" TITLE STR0048 TOTAL IN COLUMN //"Cabecalho de Ferias"
				oSection3:SetHeaderBreak(.T.)
				oSection3:SetLineStyle()
					DEFINE CELL NAME "RH_DATABAS" 	OF oSection3 ALIAS "SRH" BLOCK {|| Dtoc(SRH->RH_DATABAS) }
					DEFINE CELL NAME "RH_DBASEAT" 	OF oSection3 ALIAS "SRH" BLOCK {|| Dtoc(SRH->RH_DBASEAT) }
					DEFINE CELL NAME "RH_DATAINI" 	OF oSection3 ALIAS "SRH" BLOCK {|| Dtoc(SRH->RH_DATAINI) }
					DEFINE CELL NAME "RH_DATAFIM" 	OF oSection3 ALIAS "SRH" BLOCK {|| Dtoc(SRH->RH_DATAFIM) }
					DEFINE CELL NAME "RH_DTRECIB"	OF oSection3 ALIAS "SRH" BLOCK {|| Dtoc(SRH->RH_DTRECIB) }
					DEFINE CELL NAME "RH_PERC13S"	OF oSection3 ALIAS "SRH" CELL BREAK
					DEFINE CELL NAME "RH_DFERIAS" 	OF oSection3 ALIAS "SRH"
					DEFINE CELL NAME "RH_DABONPE" 	OF oSection3 ALIAS "SRH"
					DEFINE CELL NAME "RH_SALMES" 	OF oSection3 ALIAS "SRH"
					DEFINE CELL NAME "RH_SALDIA"	OF oSection3 ALIAS "SRH"
					DEFINE CELL NAME "RH_SALHRS"	OF oSection3 ALIAS "SRH" CELL BREAK
					DEFINE CELL NAME "RH_TIPCAL"	OF oSection3 ALIAS "SRH" SIZE 15 BLOCK {|| If( (cAliasSRH)->RH_TIPCAL $ "NP",STR0039 ,STR0040 ) }  
					
			      	//-- Section de Valores de ferias (SRR)
					DEFINE SECTION oSection4 OF oSection3 TABLES "SRR", "SRV" TITLE STR0049 TOTAL IN COLUMN //"Itens de Ferias"
					oSection4:SetHeaderBreak(.T.)

						DEFINE CELL NAME "RR_PD" 		OF oSection4 ALIAS "SRR" TITLE oemtoAnsi(STR0045)
						DEFINE CELL NAME "RV_DESCPD" 	OF oSection4 			 TITLE oemtoAnsi(STR0046)	BLOCK {|| DescPd((cAliasSRR)->RR_PD,(cAliasSRR)->RR_FILIAL)}
						DEFINE CELL NAME "RR_HORAS" 	OF oSection4 ALIAS "SRR" TITLE oemtoAnsi(STR0041)	BLOCK {|| If((cAliasSRR)->RR_TIPO1 == "H" .And. (cAliasSRR)->RR_HORAS > 0, fConvHoras((cAliasSRR)->RR_HORAS,"1"), (cAliasSRR)->RR_HORAS)} PICTURE "@E 9999.99"
						DEFINE CELL NAME "PROVENTOS" 	OF oSection4 			 TITLE oemtoAnsi(STR0042) 	BLOCK {|| If(SRV->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) } 			SIZE 15		PICTURE "@E 999,999,999.99" HEADER ALIGN RIGHT
						DEFINE CELL NAME "DESCONTOS" 	OF oSection4 			 TITLE oemtoAnsi(STR0043) 	BLOCK {|| If(SRV->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) } 			SIZE 15		PICTURE "@E 999,999,999.99" HEADER ALIGN RIGHT
						DEFINE CELL NAME "BASES" 		OF oSection4			 TITLE oemtoAnsi(STR0044) 	BLOCK {|| If(SRV->RV_TIPOCOD $ "3/4",(cAliasSRR)->RR_VALOR,0) } 			SIZE 15		PICTURE "@E 999,999,999.99" HEADER ALIGN RIGHT
						DEFINE CELL NAME "LIQUIDO" 		OF oSection4			 TITLE "Liquido"   	        BLOCK {|| (If(SRV->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) - ;
																						                           If(SRV->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) )  }  		SIZE 15		PICTURE "@E 999,999,999.99" HEADER ALIGN RIGHT
						oSection4:Cell("LIQUIDO"):Hide()						
						//-- Posiciona a tabela de verbas
						TRPosition():New(oSection4,"SRV",1,{|| xFilial("SRV")+(cAliasSRR)->RR_PD}  )

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Utilizada essa section para as ordens 2=Centro de Custo e 4=Centro de Custo + Nome³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//-- Section de Centro de Custo
			DEFINE SECTION oSection5 OF oSection1 TABLES "SRA", "CTT" TITLE STR0050 TOTAL IN COLUMN //"Ordens Centro de Custo e Centro de Custo+Nome"
			oSection5:SetHeaderBreak(.T.)
			oSection5:SetLineStyle()		
			
				DEFINE CELL NAME "RA_CC"	OF oSection5 ALIAS "SRA"
				DEFINE CELL NAME "CTT_DESC01"	OF oSection5 ALIAS "CTT"

				//-- Posiciona a tabela de centro de custo
				TRPosition():New(oSection5,"CTT",1,{|| xFilial("CTT")+(cAliasMov)->RA_CC})  

				//-- Section de Funcionario
				DEFINE SECTION oSection6 OF oSection5 TABLES "SRA" TITLE STR0051 TOTAL IN COLUMN //"Funcionario"
				oSection6:SetHeaderBreak(.T.)
				oSection6:SetLineStyle() 
					DEFINE CELL NAME "RA_FILIAL"	OF oSection6 ALIAS "SRA"
					DEFINE CELL NAME "RA_CC"		OF oSection6 ALIAS "SRA"
					DEFINE CELL NAME "RA_TNOTRAB"	OF oSection6 ALIAS "SRA"
					DEFINE CELL NAME "RA_MAT"	    OF oSection6 ALIAS "SRA"
					DEFINE CELL NAME "RA_NOME"		OF oSection6 ALIAS "SRA"
					DEFINE CELL NAME "RA_DEPIR"		OF oSection6 ALIAS "SRA"
				
					//-- Section de Cabecalho de Ferias (SRF)
					DEFINE SECTION oSection7 OF oSection6 TABLES "SRH" TITLE STR0048 TOTAL IN COLUMN //"Cabecalho de Ferias"
					oSection7:SetHeaderBreak(.T.)
					oSection7:SetLineStyle() 
							DEFINE CELL NAME "RH_DATABAS" 	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_DBASEAT" 	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_DATAINI" 	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_DATAFIM" 	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_DTRECIB"	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_PERC13S"	OF oSection7 ALIAS "SRH" 
							DEFINE CELL NAME "RH_DFERIAS" 	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_DABONPE" 	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_SALMES" 	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_SALDIA"	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_SALHRS"	OF oSection7 ALIAS "SRH"
							DEFINE CELL NAME "RH_TIPCAL"	OF oSection7 ALIAS "SRH" SIZE 15 BLOCK {|| If( (cAliasSRH)->RH_TIPCAL $ "NP",STR0039 ,STR0040 ) }  
		
							//-- Section de Valores de Ferias (SRR)

							DEFINE SECTION oSection8 OF oSection7 TABLES "SRR", "SRV" TITLE STR0049 TOTAL IN COLUMN //"Itens de Ferias"
							oSection8:SetHeaderBreak(.T.)
			
							DEFINE CELL NAME "RR_PD" 		OF oSection8 ALIAS "SRR"
							DEFINE CELL NAME "RV_DESCPD" 	OF oSection8 										BLOCK {|| DescPd((cAliasSRR)->RR_PD,(cAliasSRR)->RR_FILIAL)}
							DEFINE CELL NAME "RR_HORAS" 	OF oSection8 ALIAS "SRR" TITLE oemtoAnsi(STR0041)	BLOCK {|| If((cAliasSRR)->RR_TIPO1 == "H" .And. (cAliasSRR)->RR_HORAS > 0, fConvHoras((cAliasSRR)->RR_HORAS,"1"), (cAliasSRR)->RR_HORAS)} PICTURE "@E 9999.99"
							DEFINE CELL NAME "PROVENTOS" 	OF oSection8 			 TITLE oemtoAnsi(STR0042) 	BLOCK {|| If(SRV->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 999,999,999.99"
							DEFINE CELL NAME "DESCONTOS" 	OF oSection8 			 TITLE oemtoAnsi(STR0043) 	BLOCK {|| If(SRV->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 999,999,999.99"
							DEFINE CELL NAME "BASES" 		OF oSection8			 TITLE oemtoAnsi(STR0044) 	BLOCK {|| If(SRV->RV_TIPOCOD $ "3/4",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 999,999,999.99"
							DEFINE CELL NAME "LIQUIDO" 		OF oSection8			 TITLE "Liquido"   	        BLOCK {|| (If(SRV->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) - ;
																					                           If(SRV->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) )  }  		SIZE 15		PICTURE "@E 999,999,999.99" HEADER ALIGN RIGHT
							oSection8:Cell("LIQUIDO"):Hide()

							//-- Posiciona a tabela de verbas
							TRPosition():New(oSection8,"SRV",1,{|| xFilial("SRV")+(cAliasSRR)->RR_PD})  
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Utilizada essa section para as ordens 5=Turno ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//-- Section de Turno
			DEFINE SECTION oSection9 OF oSection1 TABLES "SRA", "SR6" TITLE STR0052 TOTAL IN COLUMN //"Ordem Turno"
			oSection9:SetHeaderBreak(.T.)
			oSection9:SetLineStyle()	
				DEFINE CELL NAME "RA_TNOTRAB"	OF oSection9 ALIAS "SRA"
				DEFINE CELL NAME "R6_DESC"		OF oSection9 ALIAS "SR6" 
				
				//-- Posiciona a tabela de turno
				TRPosition():New(oSection9,"SR6",1,{|| xFilial("SR6")+(cAliasMov)->RA_TNOTRAB}) 
				
				//-- Section de Funcionario
				DEFINE SECTION oSection10 OF oSection9  TABLES "SRA" TITLE STR0051 TOTAL IN COLUMN //"Funcionario"
				oSection10:SetHeaderBreak(.T.)
				oSection10:SetLineStyle() 
					DEFINE CELL NAME "RA_FILIAL"	OF oSection10 ALIAS "SRA"
					DEFINE CELL NAME "RA_CC"		OF oSection10 ALIAS "SRA"
					DEFINE CELL NAME "RA_TNOTRAB"	OF oSection10 ALIAS "SRA"
					DEFINE CELL NAME "RA_MAT"		OF oSection10 ALIAS "SRA"
					DEFINE CELL NAME "RA_NOME"		OF oSection10 ALIAS "SRA"
					DEFINE CELL NAME "RA_DEPIR"		OF oSection10 ALIAS "SRA"
		
					//-- Section de Cabecalho de Ferias (SRH)
					DEFINE SECTION oSection11 OF oSection10 TABLES "SRH" TITLE STR0048 TOTAL IN COLUMN //"Cabecalho de Ferias"
					oSection11:SetHeaderBreak(.T.)
					oSection11:SetLineStyle() 
						DEFINE CELL NAME "RH_DATABAS" 	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_DBASEAT" 	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_DATAINI" 	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_DATAFIM" 	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_DTRECIB"	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_PERC13S"	OF oSection11 ALIAS "SRH" 
						DEFINE CELL NAME "RH_DFERIAS" 	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_DABONPE" 	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_SALMES" 	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_SALDIA"	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_SALHRS"	OF oSection11 ALIAS "SRH"
						DEFINE CELL NAME "RH_TIPCAL"	OF oSection11 ALIAS "SRH" SIZE 15 BLOCK {|| If( (cAliasSRH)->RH_TIPCAL $ "NP",STR0039 ,STR0040 ) }  
				
						//-- Section de Valores da Rescisao (SRR)
						DEFINE SECTION oSection12 OF oSection11 TABLES "SRR", "SRV" TITLE STR0049 TOTAL IN COLUMN //"Itens de Ferias"					
						oSection12:SetHeaderBreak(.T.)
				
							DEFINE CELL NAME "RR_PD" 		OF oSection12 ALIAS "SRR"
							DEFINE CELL NAME "RV_DESCPD" 	OF oSection12 											BLOCK {|| DescPd((cAliasSRR)->RR_PD,(cAliasSRR)->RR_FILIAL)}
							DEFINE CELL NAME "RR_HORAS" 	OF oSection12 ALIAS "SRR" 	TITLE oemtoAnsi(STR0041)	BLOCK {|| If((cAliasSRR)->RR_TIPO1 == "H" .And. (cAliasSRR)->RR_HORAS > 0, fConvHoras((cAliasSRR)->RR_HORAS,"1"), (cAliasSRR)->RR_HORAS)} PICTURE "@E 9999.99"
							DEFINE CELL NAME "PROVENTOS" 	OF oSection12 			 	TITLE oemtoAnsi(STR0042) 	BLOCK {|| If(SRV->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 999,999,999.99"
							DEFINE CELL NAME "DESCONTOS" 	OF oSection12 			 	TITLE oemtoAnsi(STR0043) 	BLOCK {|| If(SRV->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 999,999,999.99"
							DEFINE CELL NAME "BASES" 		OF oSection12			 	TITLE oemtoAnsi(STR0044) 	BLOCK {|| If(SRV->RV_TIPOCOD $ "3/4",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 999,999,999.99"
							DEFINE CELL NAME "LIQUIDO" 		OF oSection12			 	TITLE "Liquido"   	        BLOCK {|| (If(SRV->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) - ;
																						                           If(SRV->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) )  }  		SIZE 15		PICTURE "@E 999,999,999.99" HEADER ALIGN RIGHT
							oSection12:Cell("LIQUIDO"):Hide()						
		
							//-- Posiciona a tabela de verbas
							TRPosition():New(oSection12,"SRV",1,{|| xFilial("SRV")+(cAliasSRR)->RR_PD})  		
							
Return oReport

 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PrintReport³ Autor ³ Natie                 ³ Data ³21/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relacao de Ferias                   Release 4                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER550                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GPER550 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Locais                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString		:= "SRA"										// Alias do arquivo principal (Base)
Local cFilialAnt	:= Space(FWGETTAMFILIAL)
Local cCustoAnt		:= Space(09)
Local cTurnoAnt		:= Space(03)
Local cFiltro		:= ""
Local cTitulo		:= oemToAnsi(STR0011) 
Local cTpFerias 	:= ""
Local aPdv			:= {}
Local aPdd			:= {}
Local aPdb			:= {}
Local aPdvEmp		:= {}
Local aPddEmp		:= {}
Local aPdbEmp		:= {}
Local aPdvFil		:= {}
Local aPddFil		:= {}
Local aPdbFil		:= {}
Local aPdvCc		:= {}
Local aPddCc		:= {}
Local aPdbCc		:= {}
Local aPdvTno		:= {}
Local aPddTno		:= {}
Local aPdbTno		:= {}
Local nTamanho		:= "M"
Local lAltFilial	:= .F.
Local nPos			:= 0.00
Local nCont			:= 0 
Local nColunas		:= IIF( nTamanho == "P" , 80 , IIF( nTamanho == "G" , 220 , 132 ) )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordem selecionada pelo usuario                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nOrdem		:= oReport:Section(1):GetOrder()
Local oSection1
Local oSection2
Local oSection3
Local oSection4
Local oSection5  
Local oBreakFil   
Local oBreakCC  
Local oBreakMat
Local oBreakTrn

//-- String
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private cAcessaSRA	:= ChkRH( "GPER550" , "SRA" , "2" )
Private cAcessaSRH	:= ChkRH( "GPER550" , "SRH" , "2" )
Private cAcessaSRR	:= ChkRH( "GPER550" , "SRR" , "2" )

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define Variaveis Private(Basicas)						       ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private nomeprog	:= "GPER550" 
Private cPerg		:= "GPR550" 
Private lEnd		:= .F. 

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis Private                                            ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private aCodFol		:= {}
Private bEval		:= { |e| &(e) }

Private cAliasMov 	:= "SRA"     
Private cAliasSRH   := "SRH"
Private cAliasSRR   := "SRR"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega pergunte                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSituacao   :=  mv_par08							//Situacoes  a Imprimir
cCategoria  :=  mv_par09							//Categorias a Imprimir
lTipoRel	:=  IF( mv_par10 == 1 , .T. , .F. ) 	//Tipo de Relacao			( 1 - Analitica	, 2 - Sintetica	)
lSaltaCc	:=  IF( mv_par11 == 1 , .T. , .F. ) 	//Quebra Pag. Cent. Custo	( 1 - Sim		, 2 - Nao		)
lSaltaTno   :=  IF( mv_par12 == 1 , .T. , .F. ) 	//Quebra Pag. Turno			( 1 - Sim		, 2 - Nao		)
cTpFerias 	:=  IF( mv_par13 == 1 , "NP", IF( mv_par13 == 2 , "C" , "NCP"))	 //Tipo de Ferias: Normais/Coletivas/Ambas 

oSection1 	:= oReport:Section(1)		//Dados Filial 

//-- Matricula ou Nome 
If nOrdem == 1 .OR. nOrdem == 3
	//-- Desabilitar as sections que nao serao utilizadas (ordem 2,4 e 5) 

	oSection1:Section(2):Disable()					//Desbilita section do CC
	oSection1:Section(3):Disable()					//Desbilita section do Turno

	oSection2 	:= oSection1:Section(1) 			// Dados Funcionario
	oSection3 	:= oSection2:Section(1) 			// Cabecalho Ferias 
	oSection4 	:= oSection3:Section(1) 			// Valores Ferias
                                   
	If lTipoRel										//-- Analitica 
		//-- Total do Funcionario e Total da Empresa 
		DEFINE BREAK oBreakMat  OF oReport WHEN {|| (cAliasMov)->(RA_FILIAL+ RA_MAT)} TITLE {|| STR0012 + cFilaInfo}
		DEFINE FUNCTION FROM oSection4:Cell("PROVENTOS") 	FUNCTION SUM TITLE STR0042    OF oSection2
		DEFINE FUNCTION FROM oSection4:Cell("DESCONTOS") 	FUNCTION SUM TITLE STR0043    OF oSection2 
		DEFINE FUNCTION FROM oSection4:Cell("LIQUIDO")		FUNCTION SUM TITLE STR0036    OF oSection2
		oSection2:SetTotalText({||STR0022+(cAliasMov)->RA_MAT + " - " + If(lOfuscaNom,Replicate('*',15),(cAliasMov)->RA_Nome) })
		oBreakMat:OnPrintTotal( {||oReport:ThinLine()  } ) 
                                                                                 
		//-- Total da Filial
		DEFINE BREAK oBreakFil OF oReport WHEN {|| (cAliasMov)->RA_FILIAL } TITLE {|| STR0012 + cFilaInfo}
		oBreakFil:FunctionBefore(.F.)

		//-- Totais dos lancamentos por filial 
		DEFINE COLLECTION OF oSection4 FUNCTION COUNT FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("RR_PD") 		BREAK oBreakFil	TITLE OemToAnsi(STR0045)  PICTURE "999"					NO END SECTION						//"Verbas" 
		DEFINE COLLECTION OF oSection4 FUNCTION SUM   FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("RR_HORAS") 	BREAK oBreakFil	TITLE OemToAnsi(STR0041)  PICTURE "@E 9999.99"			NO END SECTION						//"Qtde"
		DEFINE COLLECTION OF oSection4 FUNCTION SUM   FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("PROVENTOS")	BREAK oBreakFil	TITLE OemToAnsi(STR0042)  PICTURE "@E 999,999,999.99"	NO END SECTION                		//"Proventos"
		DEFINE COLLECTION OF oSection4 FUNCTION SUM   FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("DESCONTOS")	BREAK oBreakFil	TITLE OemToAnsi(STR0043)  PICTURE "@E 999,999,999.99"	NO END SECTION						//"Descontos"
		DEFINE COLLECTION OF oSection4 FUNCTION SUM   FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("BASES")		BREAK oBreakFil	TITLE OemToAnsi(STR0044)  PICTURE "@E 999,999,999.99"	NO END SECTION						//"Bases"
		
		DEFINE FUNCTION FROM oSection4:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0042 	OF oSection1
		DEFINE FUNCTION FROM oSection4:Cell("DESCONTOS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0043		OF oSection1
		DEFINE FUNCTION FROM oSection4:Cell("LIQUIDO")		FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0036 	OF oSection1
		
	Else						//-- Sintetica 
		//-- Total da Filial e Total da Empresa
		DEFINE BREAK oBreakFil OF oReport WHEN {|| (cAliasMov)->RA_FILIAL } TITLE {|| STR0012 + cFilaInfo }
		
		oBreakFil:FunctionBefore(.F.)

		DEFINE COLLECTION OF oSection4 FUNCTION SUM   FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("RR_HORAS") 	BREAK oBreakFil	TITLE OemToAnsi(STR0041)  PICTURE "@E 9999.99"			NO END SECTION						//"Qtde"
		DEFINE COLLECTION OF oSection4 FUNCTION SUM   FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("PROVENTOS")	BREAK oBreakFil	TITLE OemToAnsi(STR0042)  PICTURE "@E 999,999,999.99"	NO END SECTION                     	//"Proventos"
		DEFINE COLLECTION OF oSection4 FUNCTION SUM   FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("DESCONTOS")	BREAK oBreakFil	TITLE OemToAnsi(STR0043)  PICTURE "@E 999,999,999.99"	NO END SECTION						//"Descontos"
		DEFINE COLLECTION OF oSection4 FUNCTION SUM   FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection4:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection4:Cell("BASES")		BREAK oBreakFil	TITLE OemToAnsi(STR0044)  PICTURE "@E 999,999,999.99"	NO END SECTION						//"Bases"
		
		DEFINE FUNCTION FROM oSection4:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0042		OF oSection1
		DEFINE FUNCTION FROM oSection4:Cell("DESCONTOS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0043		OF oSection1
		DEFINE FUNCTION FROM oSection4:Cell("LIQUIDO")		FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0036     OF oSection1

		//Impressao do total geral
		DEFINE FUNCTION FROM oSection4:Cell("PROVENTOS") 	FUNCTION SUM NO END SECTION TITLE STR0042    OF oSection2
		DEFINE FUNCTION FROM oSection4:Cell("DESCONTOS") 	FUNCTION SUM NO END SECTION TITLE STR0043    OF oSection2 
		DEFINE FUNCTION FROM oSection4:Cell("LIQUIDO")		FUNCTION SUM NO END SECTION TITLE STR0036    OF oSection2		
 
	EndIf
	oBreakFil:OnBreak({|x,y| cFilaInfo := x })
	oBreakFil:OnPrintTotal( {||oReport:ThinLine()  } )
Else
	// Dados C. Custo 		- Dados Turno 
	oSection2 	:= If(nOrdem == 2 .OR. nOrdem == 4, oSection1:Section(2), 	oSection1:Section(3))
	oSection3 	:= oSection2:Section(1) 									// Dados do funcionario
	oSection4 	:= oSection2:Section(1):section(1) 						// Cabecalho Ferias
	oSection5 	:= oSection2:Section(1):section(1):Section(1) 				// Valores Ferias
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Modo Analitico                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lTipoRel						   										//-- Analitico
		// Relatorio analitico devem  ser impressas os dados dos funcionarios 
		// Total do Funcionario e Total da Empresa
		DEFINE BREAK oBreakMat OF oReport WHEN {|| (cAliasMov)->(RA_FILIAL+ RA_MAT)} TITLE {|| STR0012 + cFilaInfo}
		DEFINE FUNCTION FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM TITLE STR0042    OF oSection3
		DEFINE FUNCTION FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM TITLE STR0043    OF oSection3 
		DEFINE FUNCTION FROM oSection5:Cell("LIQUIDO")		FUNCTION SUM TITLE "liquido"  OF oSection3
		oSection3:SetTotalText({||STR0022+(cAliasMov)->RA_MAT + " - " + If(lOfuscaNom,Replicate('*',15),(cAliasMov)->RA_Nome) })
		oBreakMat:OnPrintTotal( {||oReport:ThinLine() } )
		
		//-- Centro de Custo ou Centro de Custo + Nome
		If nOrdem == 2 .OR. nOrdem == 4
			//-- Desabilitar as sections que nao serao utilizadas (ordem 1, 3 e 5)
			oSection1:Section(1):Disable()						//-- Desbilita section por Matricula 
			oSection1:Section(3):Disable()						//-- Desbilita section do Turno    
			//-- Total do Centro de Custo                                                                
			DEFINE BREAK oBreakCC OF oReport WHEN {|| (cAliasMov)->RA_CC } TITLE {|| STR0025 + cCCAnt }
			oBreakCC:FunctionBefore(.F.)
			
			DEFINE COLLECTION OF oSection5 FUNCTION COUNT FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("RR_PD") 		BREAK oBreakCc	TITLE OemToAnsi(STR0045)  PICTURE "999"					NO END SECTION			//"Verbas" 
			DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("RR_HORAS") 	BREAK oBreakCc	TITLE OemToAnsi(STR0041)  PICTURE "@E 9999.99"			NO END SECTION			//"Qtde"
			DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("PROVENTOS")	BREAK oBreakCc	TITLE OemToAnsi(STR0042)  PICTURE "@E 999,999,999.99"	NO END SECTION        	//"Proventos"
			DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("DESCONTOS")	BREAK oBreakCc	TITLE OemToAnsi(STR0043)  PICTURE "@E 999,999,999.99"	NO END SECTION			//"Descontos"
			DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("BASES")	   	BREAK oBreakCc	TITLE OemToAnsi(STR0044)  PICTURE "@E 999,999,999.99"	NO END SECTION			//"Bases"
			
			DEFINE FUNCTION FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0042 		OF oSection2
			DEFINE FUNCTION FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0043		OF oSection2
			DEFINE FUNCTION FROM oSection5:Cell("LIQUIDO")		FUNCTION SUM BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0036   	OF oSection2
			//-- Salta pagina na quebra do CC 
			If lSaltaCc
				oBreakCC:SetPageBreak(.T.)
			EndIf
			oBreakCC:OnBreak({|x,y|  cCCAnt := x }) 
		//-- Turno
		Else
			//-- Desabilitar as sections que nao serao utilizadas (ordem 1 a 4)
			oSection1:Section(1):Disable()			//-- Desbilita section por Matricula 
			oSection1:Section(2):Disable()			//-- Desbilita section por CC
	
			//-- Total do Centro Turno
			DEFINE BREAK oBreakTrn OF oReport WHEN {|| (cAliasMov)->RA_TNOTRAB } TITLE {|| STR0026 + cTurnoAnt }
			oBreakTrn:FunctionBefore(.F.)

			//-- Totais dos lancamentos por filial 
			DEFINE COLLECTION OF oSection5  FUNCTION COUNT FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("RR_PD") 	BREAK oBreakTrn TITLE OemToAnsi(STR0045)  PICTURE "999"					NO END SECTION			//"Verbas" 
			DEFINE COLLECTION OF oSection5  FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("RR_HORAS") 	BREAK oBreakTrn	TITLE OemToAnsi(STR0041)  PICTURE "@E 9999.99"			NO END SECTION			//"Qtde"
			DEFINE COLLECTION OF oSection5  FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("PROVENTOS")	BREAK oBreakTrn TITLE OemToAnsi(STR0042)  PICTURE "@E 999,999,999.99"	NO END SECTION       	//"Proventos"
			DEFINE COLLECTION OF oSection5  FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("DESCONTOS")	BREAK oBreakTrn TITLE OemToAnsi(STR0043)  PICTURE "@E 999,999,999.99"	NO END SECTION			//"Descontos"
			DEFINE COLLECTION OF oSection5  FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("BASES")		BREAK oBreakTrn TITLE OemToAnsi(STR0044)  PICTURE "@E 999,999,999.99"	NO END SECTION			//"Bases"
			
			DEFINE FUNCTION FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0042  	OF oSection2
			DEFINE FUNCTION FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0043  	OF oSection2
			DEFINE FUNCTION FROM oSection5:Cell("LIQUIDO")		FUNCTION SUM BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0036 	OF oSection2
			If lSaltaTno
				oBreakTrn:SetPageBreak(.T.)
			EndIf
			oBreakTrn:OnBreak({|x,y|  cTurnoAnt := x })
		EndIf
		
		DEFINE BREAK oBreakFil OF oReport WHEN {|| (cAliasMov)->RA_FILIAL } TITLE {|| STR0012 + cFilaInfo }
		oBreakFil:FunctionBefore(.F.)

		DEFINE COLLECTION OF oSection5 FUNCTION COUNT FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("RR_PD") 		BREAK oBreakFil	TITLE OemToAnsi(STR0045)  PICTURE "999"					NO END SECTION						//"Verbas" 
		DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("RR_HORAS") 	BREAK oBreakFil	TITLE OemToAnsi(STR0041)  PICTURE "@E 9999.99"			NO END SECTION						//"Qtde"
		DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("PROVENTOS")	BREAK oBreakFil	TITLE OemToAnsi(STR0042)  PICTURE "@E 999,999,999.99"	NO END SECTION                     	//"Proventos"
		DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("DESCONTOS")	BREAK oBreakFil	TITLE OemToAnsi(STR0043)  PICTURE "@E 999,999,999.99"	NO END SECTION						//"Descontos"
		DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("BASES")		BREAK oBreakFil	TITLE OemToAnsi(STR0044)  PICTURE "@E 999,999,999.99"	NO END SECTION						//"Bases"

		DEFINE FUNCTION FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0042 	OF oSection1
		DEFINE FUNCTION FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0043		OF oSection1
		DEFINE FUNCTION FROM oSection5:Cell("LIQUIDO")		FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0036		OF oSection1
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Modo Sintetico                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Else
		//-- Centro de Custo ou Centro de Custo + Nome
		If nOrdem == 2 .OR. nOrdem == 4
			//-- Desabilitar as sections que nao serao utilizadas (ordem 1, 3 e 5)
			oSection1:Section(1):Disable()						//-- Desbilita section por Matricula 
			oSection1:Section(3):Disable()						//-- Desbilita section do Turno 
			
			//-- Total do Centro de Custo
			DEFINE BREAK oBreakCC OF oReport WHEN {|| (cAliasMov)->RA_CC } TITLE {|| STR0025 + cCCAnt }
			oBreakCC:FunctionBefore(.F.)

			DEFINE COLLECTION OF oSection5 FUNCTION COUNT FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("RR_PD") 		BREAK oBreakCc	TITLE OemToAnsi(STR0045)  PICTURE "999"					NO END SECTION	NO END REPORT		//"Verbas" 
			DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("RR_HORAS") 	BREAK oBreakCc	TITLE OemToAnsi(STR0041)  PICTURE "@E 9999.99"			NO END SECTION	NO END REPORT		//"Qtde"
			DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("PROVENTOS")	BREAK oBreakCc	TITLE OemToAnsi(STR0042)  PICTURE "@E 999,999,999.99"	NO END SECTION  NO END REPORT      	//"Proventos"
			DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("DESCONTOS")	BREAK oBreakCc	TITLE OemToAnsi(STR0043)  PICTURE "@E 999,999,999.99"	NO END SECTION	NO END REPORT		//"Descontos"
			DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("BASES")		BREAK oBreakCc	TITLE OemToAnsi(STR0044)  PICTURE "@E 999,999,999.99"	NO END SECTION	NO END REPORT		//"Bases"
			
			DEFINE FUNCTION FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0042  	OF oSection2
			DEFINE FUNCTION FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0043		OF oSection2
			DEFINE FUNCTION FROM oSection5:Cell("LIQUIDO")		FUNCTION SUM BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0036 		OF oSection2
			oBreakCC:OnBreak({|x,y|  cCCAnt := x }) 
			If lSaltaCc
				oBreakCC:SetPageBreak(.T.)
			EndIf
		Else 
			//-- Desabilitar as sections que nao serao utilizadas (ordem 1 a 4)
			oSection1:Section(1):Disable()			//-- Desbilita section por Matricula 
			oSection1:Section(2):Disable()			//-- Desbilita section por CC
			//-- Total do Centro Turno
			DEFINE BREAK oBreakTrn OF oReport WHEN {|| (cAliasMov)->RA_TNOTRAB } TITLE {|| STR0026 + cTurnoAnt }
			oBreakTrn:FunctionBefore(.F.)

			//-- Totais dos lancamentos por filial 
			DEFINE COLLECTION OF oSection5  FUNCTION COUNT FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("RR_PD") 	BREAK oBreakTrn TITLE OemToAnsi(STR0045)  PICTURE "999"				NO END SECTION	NO END REPORT			//"Verbas" 
			DEFINE COLLECTION OF oSection5  FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("RR_HORAS") 	BREAK oBreakTrn TITLE OemToAnsi(STR0041)  PICTURE "@E 9999.99"			NO END SECTION	NO END REPORT		//"Qtde"
			DEFINE COLLECTION OF oSection5  FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("PROVENTOS")	BREAK oBreakTrn TITLE OemToAnsi(STR0042)  PICTURE "@E 999,999,999.99"	NO END SECTION  NO END REPORT     	//"Proventos"
			DEFINE COLLECTION OF oSection5  FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("DESCONTOS")	BREAK oBreakTrn TITLE OemToAnsi(STR0043)  PICTURE "@E 999,999,999.99"	NO END SECTION	NO END REPORT		//"Descontos"
			DEFINE COLLECTION OF oSection5  FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) }  CONTENT oSection5:Cell("BASES")		BREAK oBreakTrn TITLE OemToAnsi(STR0044)  PICTURE "@E 999,999,999.99"	NO END SECTION	NO END REPORT		//"Bases"
			
			DEFINE FUNCTION FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0042  	OF oSection2
			DEFINE FUNCTION FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0043		OF oSection2
			DEFINE FUNCTION FROM oSection5:Cell("LIQUIDO")		FUNCTION SUM BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0036		OF oSection2
			If lSaltaTno
				oBreakTrn:SetPageBreak(.T.)
			EndIf

			oBreakTrn:OnBreak({|x,y|  cTurnoAnt := x })
		Endif 
	
		DEFINE BREAK oBreakFil OF oReport WHEN {|| (cAliasMov)->RA_FILIAL } TITLE {|| STR0012 + cFilaInfo }
		oBreakFil:FunctionBefore(.F.)

		DEFINE COLLECTION OF oSection5 FUNCTION COUNT FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("RR_PD") 		BREAK oBreakFil	TITLE OemToAnsi(STR0045)  PICTURE "999"					NO END SECTION						//"Verbas" 
		DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("RR_HORAS") 	BREAK oBreakFil	TITLE OemToAnsi(STR0041)  PICTURE "@E 9999.99"			NO END SECTION						//"Qtde"
		DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("PROVENTOS")	BREAK oBreakFil	TITLE OemToAnsi(STR0042)  PICTURE "@E 999,999,999.99"	NO END SECTION                     	//"Proventos"
		DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("DESCONTOS")	BREAK oBreakFil	TITLE OemToAnsi(STR0043)  PICTURE "@E 999,999,999.99"	NO END SECTION						//"Descontos"
		DEFINE COLLECTION OF oSection5 FUNCTION SUM   FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " +  oSection5:Cell("RV_DESCPD"):GetValue(.T.) } CONTENT oSection5:Cell("BASES")		BREAK oBreakFil	TITLE OemToAnsi(STR0044)  PICTURE "@E 999,999,999.99"	NO END SECTION						//"Bases"
		
		DEFINE FUNCTION FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0042   OF oSection1
		DEFINE FUNCTION FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0043   OF oSection1
		DEFINE FUNCTION FROM oSection5:Cell("LIQUIDO")		FUNCTION SUM BREAK oBreakFil NO END SECTION NO END REPORT TITLE STR0036	  OF oSection1
		
		//Impressao do total geral
		DEFINE FUNCTION FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM NO END SECTION TITLE STR0042    OF oSection3
		DEFINE FUNCTION FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM NO END SECTION TITLE STR0043    OF oSection3 
		DEFINE FUNCTION FROM oSection5:Cell("LIQUIDO")		FUNCTION SUM NO END SECTION TITLE "liquido"  OF oSection3		
	EndIf	
	oBreakFil:OnBreak({|x,y|  cFilaInfo := x })
	oBreakFil:OnPrintTotal( {||oReport:ThinLine() } )
EndIf
oReport:FunctionBefore(.F.)

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³Troca Titulo do relatorio conforme ordem  escolhida           ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
cTitulo  := If(AllTrim(oReport:Title()) == AllTrim(cTitulo), cTitulo, oReport:Title())			

IF nOrdem == 1					//Matricula
	cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0032 , STR0033 ) + ' - ' + STR0024 +  STR0001 + " ) "
ElseIF nOrdem == 2				//Centro de Custo
	cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0032 , STR0033 ) + ' - ' + STR0024 +  STR0002 + " ) "
ElseIF nOrdem == 3				//Nome
	cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0032 , STR0033 ) + ' - ' + STR0024 +  STR0003 + " ) "
ElseIF nOrdem == 4				//Centro de Custo + Nome
	cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0032 , STR0033 ) + ' - ' + STR0024 +  STR0004 + " ) "
ElseIF nOrdem == 5				//Turno de Trabalho
	cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0032 , STR0033 ) + ' - ' + STR0024 +  STR0005 + " ) "
EndIF
  
oReport:SetTitle(cTitulo)

cAliasMov 	:= "SRA" 
cAliasSRH   := "SRH"
cAliasSRR   := "SRR"
cAliasSRV	:= "SRV"
//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
MakeAdvplExpr("GP550R")
          
dbSelectArea(cAliasMov)
cFiltro := ""
//-- Adiciona no filtro o parametro tipo Range
//-- Filial
If !Empty(mv_par01)
	cFiltro += mv_par01 + " .AND. "
EndIf                 

//-- Centro de Custo
If !Empty(mv_par02)
	cFiltro += mv_par02 + " .AND. "
EndIf

//-- Turno
If !Empty(mv_par03)
	cFiltro += mv_par03 + " .AND. "
EndIf                 

//-- Matricula
If !Empty(mv_par04)
	cFiltro += mv_par04 + " .AND. "
EndIf
//-- Nome
If !Empty(mv_par05)
	cFiltro += mv_par05 + " .AND. "
EndIf                 

cFiltro += 'RA_SITFOLH $ "' + cSituacao + '" .AND. '
cFiltro += 'RA_CATFUNC $ "' + cCategoria + '"' 
//-- Filtra Section de Filial
oSection1:SetFilter(cFiltro)
//-- Filtra Section Filha (Funcionario, Centro de Custo ou Turno)
oSection2:SetFilter(cFiltro)
oSection2:SetParentFilter({|cParam| (cAliasMov)->RA_FILIAL == cParam},{|| (cAliasMov)->RA_FILIAL})

If nOrdem == 2 .or. nOrdem == 4 .or. nOrdem == 5 	//Centro de Custo e Turno
	//-- Filtra Section de Funcionario
	oSection3:SetFilter(cFiltro)  	
	If  nOrdem == 2 .or. nOrdem == 4 
		If nOrdem == 4
			oSection1:SetIdxOrder ( 8 )
			oSection2:SetIdxOrder ( 8 )
			oSection3:SetIdxOrder ( 8 )   
		Endif	
		oSection3:SetParentFilter({|cParam| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_CC == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_CC})
	ELse
		oSection1:SetIdxOrder ( 4 ) 		
		oSection2:SetIdxOrder ( 4 ) 			
		oSection3:SetIdxOrder ( 4 ) 			
		oSection3:SetParentFilter({|cParam| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_TNOTRAB == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_TNOTRAB})
	Endif	
EndIf
	                    
cFiltro := ""
//-- Periodo de Férias 
If !Empty(mv_par06)
	cFiltro += mv_par06 + " .AND. "
EndIf 
                  
//-- Data Pagamento
If !Empty(mv_par07)
	cFiltro += mv_par07 + ".AND. "
EndIf

  	cFiltro += 'RH_TIPCAL $ "' + cTpFerias + '"'

If nOrdem == 1 .or. nOrdem == 3
	oSection3:SetFilter(cFiltro)
	oSection3:SetRelation({|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT }, "SRH",1,.T.)
	oSection3:SetParentFilter({|cParam| (cAliasSRH)->RH_FILIAL + (cAliasSRH)->RH_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})
	oSection4:SetRelation({|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT + "F" + dtos((cAliasSRH)->RH_DATAINI)}, "SRR",1,.T.)
	oSection4:SetParentFilter({|cParam| (cAliasSRR)->RR_FILIAL + (cAliasSRR)->RR_MAT + (cAliasSRR)->RR_TIPO3 == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT + "F"})
Else
	oSection4:SetFilter(cFiltro)
	oSection4:SetRelation({|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT }, "SRH",1,.T.)
	oSection4:SetParentFilter({|cParam| (cAliasSRH)->RH_FILIAL + (cAliasSRH)->RH_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})
	oSection5:SetRelation({|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT + "F" + dtos((cAliasSRH)->RH_DATAINI) }, "SRR",1,.T.)
	oSection5:SetParentFilter({|cParam| (cAliasSRR)->RR_FILIAL + (cAliasSRR)->RR_MAT + (cAliasSRR)->RR_TIPO3 == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT + "F"})
EndIf 

//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter((cAliasMov)->( RecCount() ))  
	
//-- Condicao para Impressao das Sections
oSection1:SetLineCondition({|| fCondFil() })
If nOrdem == 1 .or. nOrdem == 3 
	oSection2:SetLineCondition({|| fCondSRA() })
	oSection3:SetLineCondition({|| Eval( bEval , cAcessaSRH ) })
	oSection4:SetLineCondition({|| Eval( bEval , cAcessaSRR ) .AND. ; 
												!( (cAliasSRR)->RR_PD $ aCodFol[ 102 , 1 ] ) .AND. (cAliasSRR)->RR_DATAPAG == fDtBusFer() .and. (cAliasSRH)->RH_DATAINI == (cAliasSRR)->RR_DATA  }) 
Else
	oSection2:SetLineCondition({|| fCondSRA() })
	oSection3:SetLineCondition({|| fCondSRA() })
	oSection4:SetLineCondition({|| Eval( bEval , cAcessaSRH ) })
	oSection5:SetLineCondition({|| Eval( bEval , cAcessaSRR ) .AND. ;
												!( (cAliasSRR)->RR_PD $ aCodFol[ 102 , 1 ]) .AND. (cAliasSRR)->RR_DATAPAG == fDtBusFer() .and. (cAliasSRH)->RH_DATAINI == (cAliasSRR)->RR_DATA  })
EndIf

If !lTipoRel
	oSection2:Hide()
	oSection3:Hide()
	oSection4:Hide()

	If !(nOrdem == 1 .or. nOrdem == 3)
		oSection5:Hide()
	EndIf
EndIf
  
oSection1:Print()
	                  
Return nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCondFil  ºAutor  ³Microsiga           º Data ³  07/18/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Adiciona no filtro o parametro tipo Range                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER550 - Generico - Release 4                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 
Static Function  fCondFil()
Local lRetorno := .T.

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Verifica Quebra de Filial                                    ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If (cAliasMov)->RA_FILIAL # cFilaInfo .and. lRetorno 
	If !fp_CodFol(@aCodFol,(cAliasMov)->RA_FILIAL) .Or. !fInfo(@aInfo,(cAliasMov)->RA_FILIAL)
		//-- Registro nao deve ser impressao (Nao acessa Filial ou nao carregado os identificadores de calculo) 
		lRetorno := .F.                                    
		//-- Carrega os arrays com as informacoes da Filial anterior.
		fp_CodFol(@aCodFol,cFilaInfo)
		fInfo(@aInfo,cFilaInfo)
	Else
		cFilaInfo 		:= (cAliasMov)->RA_FILIAL
	EndIf
EndIf

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Consiste controle de acessos e filiais validas			   |
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If !((cAliasMov)->RA_FILIAL $ fValidFil()) .Or. !Eval( bEval , cAcessaSRA ) 
	//-- Registro nao deve ser impressao (Nao acessa tabela de Funcionarios ou Filial invalida) 
	lRetorno := .F.
EndIf

If lRetorno
	lRetorno := fCondSRA()
EndIf      
	
Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCondSRA   ³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 13.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a linha deve ser impressa                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCondSRA()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCondSRA()

Local lRetorno	:= .T.    

//Tratamento de transferencias  
Local aTransf		:= {}
Local cDataRecib	:= ""
Local cDataRec		:= ""
Local cDesconsid	:= ""
Local lExitLoop		:= .F.
Local nTransf		:= 0
Local nLenaTransf	:= 0
Local nCount		:= 0

	
//-- Registro nao deve ser impressao (Funcionario não possui registro a ser impresso) 
 	If !(SRH->( DbSeek( (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT , .T.) ))
  		lRetorno := .F.
  	EndIf
	
	IF lRetorno
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carrega as Transferencias para o AnoMes do DARF              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		cDataRecib	:= Dtos(SRH->RH_DTRECIB)
		cDataRec	:= Dtos(SRH->RH_DATAINI)
		fVerTransf( .F., aTransf , cEmpAnt + (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT)

		nLenaTransf	:=Len(aTransf)
	
		lExitLoop	:= .F.
		For nTransf:= nLenaTransf to  1 STEP -1

			//Se as Ferias corresponde a Matricula atual e transferencia mais recente, nao deve ser desprezado ao avaliar transferencias anteriores.
			If ( aTransf[nTransf, 10] + aTransf[nTransf, 11] ) == ( (cAliasMov)->(RA_FILIAL+RA_MAT) ) .And. ( SRH->(RH_FILIAL+RH_MAT) == (cAliasMov)->(RA_FILIAL+RA_MAT) )
				nCount ++
			EndIf

            IF cDataRecib >= Dtos(aTransf[nTransf, 07])
               	//-- Ver 'PARA'
				IF !( (aTransf[nTransf, 10] + aTransf[nTransf, 11] )  == ( (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT ) ) .And. nCount == 0
                 	lExitLoop	:= .T.
              	Endif     
                Exit
            Else
            	IF nTransf == 1 
                  	//-- Ver 'DE'
                  	IF !( (aTransf[nTransf, 08] + aTransf[nTransf, 09] )  == ( (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT ) )
                    	IF cDesconsid == SRH->RH_MAT + cDataRec  // se existir valores nas 2 filiais para mesmo periodo so imprime na primeira.
                    		lExitLoop	:= .T.
                    	EndIF
						IF ( (aTransf[nTransf, 08] + aTransf[nTransf, 09]+ Dtos(aTransf[nTransf, 07]))  == ( SRH->RH_FILIAL + SRH->RH_MAT + cDataRec ) )
                    		lExitLoop	:= .T.
     					EndIf
					Else
						cDesconsid:= SRH->RH_MAT + cDataRec //marca as ferias do funcionario como ja existente.     	                       	
					Endif
    	            Exit
     		    Endif   
            Endif
		Next nTransf  
                
        //-- Verifica se desconsidera os movimentos de ferias devido aos dados serem resultado de uma
        //-- Tranferencia
        IF lExitLoop 
           lRetorno	:= .F.
        Endif   
	Endif	                                                                         
		
      
Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fVerTransfºAutor  ³Mauricio MR         º Data ³  23/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Obtem as transferencias para tratamento de ferias			  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER550			                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fVerTransf(lZera, aAuxTransf, cChave)
Static cChaveAnt:= '!!'

DEFAULt lZera	:= .F.
IF lZera
   cChaveAnt:= NIL
Else   
	IF cChaveAnt <> cChave
		cChaveAnt := cChave  
		aAuxTransf:= {}
		fTransf( @aAuxTransf ,,Nil,Nil,NIL,NIL,.F.,.T.)
	Endif	
Endif
Return (.T.)
