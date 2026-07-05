/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER330.CH"
#include "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma    ³ GPER330  ³ Autor ³ Pedro Eloy         ³ Data ³  31/07/06        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao   ³ Demonstrativo de Horas Trabalhadas                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso         ³ Generico                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºProgramador ³ Data     ³ FNC       ³  Motivo da Alteracao                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±  
±±ºRaquel Hager|12/04/2013³    M12RH01³Remocao de funcoes e tratamentos para imp-º±±
±±º        	   ³          ³     RQ3005³do relatorio em formato R3.               º±± 
±±ºRaquel Hager|20/06/2013³    M12RH01³Correcao para impressao impressao das coluº±±
±±º        	   ³          ³     RQ3005³nas.						                 º±±   
±±ºRaquel Hager|27/06/2013³    M12RH01³Adequacao para busca de periodos e de moviº±±
±±º        	   ³          ³     RQ3005³mento SRC/SRD.			                 º±±
±±ºGustavo M.  |24/05/2016³     TVFCOI³Ajuste na quebra para impressao do totali º±±
±±º        	   ³          ³     	  ³zador.					                 º±±  
±±|Claudinei S.|22/07/2016|TVQQXK     |Ajuste em R330Imp() para que em caso de   |±±
±±|            |          |           |Horista com jornada variavel, busque as   |±±
±±|            |          |           |verbas que estão no grupo 0 para compor as|±±
±±|            |          |           |horas normais no relatório                |±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER330()
Local oReport        

Private aInfo     	:= {}
Private cAliasSRA	:= "SRA"    
Private cFilialSv	:= ""
Private lHojorva 	:= SRA->(COLUMNPOS( "RA_HOJORVA" )) > 0
		
		Pergunte("GPR330",.F.)
		// Variaveis utilizadas para parametros 
		// mv_par01					// Processo
		// mv_par02					// Roteiro
		// mv_par03					// Periodo
		// mv_par04					// Numero de Pagamento                      
		// mv_par05					// Filial De
		// mv_par06					// Filial Ate
		// mv_par07					// Centro de Custo De
		// mv_par08					// Centro de Custo Ate
		// mv_par09					// Matricula De
		// mv_par10					// Matricula Ate
		// mv_par11					// Nome De
		// mv_par12					// Nome Ate
		// mv_par13					// Situacao Funcionario
		// mv_par14					// Verbas de Horas Extras 1
		// mv_par15					// Verbas de Horas Extras 1
		// mv_par16					// Verbas de Horas Extras 1
		// mv_par17					// Verbas de Repouso
		// mv_par18					// Verbas de Abono Medico
		// mv_par19					// Verbas de Falta (Era: Analitica / Sintetica)
		// mv_par20					// Salta Pagina Quebra C.Custo
		// mv_par21					// Separa DSR Mensal
		// mv_par22					// Analitica / Sintetica (Era: Verbas de Falta)
		oReport:= ReportDef()
		oReport:PrintDialog()
			   

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ GPER330  ³ Autor ³ Equipe - RH        ³ Data ³  12/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Declaracao de secoes.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER330                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()  
Local aOrd      := {STR0001,STR0002,STR0003} 	//"Centro de Custo"###"Matricula"###"Nome"
Local cDesc		:= STR0009 						//"DEMONSTRATIVO HORAS TRABALHADAS"
Local oReport 
Local oSection1
		
	DEFINE REPORT oReport NAME "GPER330" TITLE OemToAnsi(STR0009) PARAMETER "GPR330" ACTION {|oReport| R330Imp(oReport)}  DESCRIPTION OemtoAnsi(STR0004) TOTAL IN COLUMN
	
	DEFINE SECTION oSection1 OF oReport TITLE OemToAnsi(STR0009) ORDERS aOrd TABLES "SRA"
	
		DEFINE CELL NAME "RA_FILIAL" 	OF oSection1 ALIAS "SRA" Size FWGETTAMFILIAL TITLE STR0029
		DEFINE CELL NAME "RA_MAT" 		OF oSection1 ALIAS "SRA" Size 08 TITLE STR0030 
		DEFINE CELL NAME "RA_NOME" 		OF oSection1 ALIAS "SRA" Size 12
		
		DEFINE CELL NAME "QUANTF" 		OF oSection1 Size 05	TITLE STR0031 Picture "@E 9,999" 
		DEFINE CELL NAME "HORASNOR" 	OF oSection1 Size 11	TITLE STR0016 Picture "@E 9999,999.99"
		
		DEFINE CELL NAME "1HREXTRA"		OF oSection1 Size 11	TITLE STR0017 Picture "@E 9999,999.99"
		DEFINE CELL NAME "2HREXTRA"		OF oSection1 Size 11	TITLE STR0018 Picture "@E 9999,999.99"
		DEFINE CELL NAME "3HREXTRA"		OF oSection1 Size 09	TITLE STR0019 Picture "@E 999,999.99"
		DEFINE CELL NAME "TOTALEXT"		OF oSection1 Size 11	TITLE STR0020 Picture "@E 9999,999.99"
		
		DEFINE CELL NAME "PERCHREX"		OF oSection1 Size 09	TITLE STR0021 Picture "@E 999.99999"
		DEFINE CELL NAME "HRREPOUSO"	OF oSection1 Size 10	TITLE STR0022 Picture "@E 999,999.99"
		DEFINE CELL NAME "ABONOMED"		OF oSection1 Size 10	TITLE STR0023 Picture "@E 999,999.99"
		DEFINE CELL NAME "PERCABONO"	OF oSection1 Size 09	TITLE STR0024 Picture "@E 999.99999"
		DEFINE CELL NAME "HORASFAL"		OF oSection1 Size 10	TITLE STR0025 Picture "@E 999,999.99"
		DEFINE CELL NAME "PERCFAL"		OF oSection1 Size 09	TITLE STR0026 Picture "@E 999.99999"
		DEFINE CELL NAME "XDIAS"		OF oSection1 Size 06	TITLE STR0027 Picture "@E 999.99"
		DEFINE CELL NAME "HRPAGAS"		OF oSection1 Size 10	TITLE STR0028 Picture "@E 999,999.99"
	
	DEFINE SECTION oSection2 OF oReport ORDERS aOrd TABLES "SRA"
			
		DEFINE CELL NAME "QUANTF" 		OF oSection2 Size 05	TITLE STR0031 Picture "@E 9,999" 
		DEFINE CELL NAME "HORASNOR" 	OF oSection2 Size 11	TITLE STR0016 Picture "@E 9999,999.99"
		
		DEFINE CELL NAME "1HREXTRA"		OF oSection2 Size 11	TITLE STR0017 Picture "@E 9999,999.99"
		DEFINE CELL NAME "2HREXTRA"		OF oSection2 Size 11	TITLE STR0018 Picture "@E 9999,999.99"
		DEFINE CELL NAME "3HREXTRA"		OF oSection2 Size 09	TITLE STR0019 Picture "@E 999,999.99"
		DEFINE CELL NAME "TOTALEXT"		OF oSection2 Size 11	TITLE STR0020 Picture "@E 9999,999.99"
		
		DEFINE CELL NAME "PERCHREX"		OF oSection2 Size 09	TITLE STR0021 Picture "@E 999.99999"
		DEFINE CELL NAME "HRREPOUSO"	OF oSection2 Size 10	TITLE STR0022 Picture "@E 999,999.99"
		DEFINE CELL NAME "ABONOMED"		OF oSection2 Size 10	TITLE STR0023 Picture "@E 999,999.99"
		DEFINE CELL NAME "PERCABONO"	OF oSection2 Size 09	TITLE STR0024 Picture "@E 999.99999"
		DEFINE CELL NAME "HORASFAL"		OF oSection2 Size 10	TITLE STR0025 Picture "@E 999,999.99"
		DEFINE CELL NAME "PERCFAL"		OF oSection2 Size 09	TITLE STR0026 Picture "@E 999.99999"
		DEFINE CELL NAME "XDIAS"		OF oSection2 Size 06	TITLE STR0027 Picture "@E 999.99"
		DEFINE CELL NAME "HRPAGAS"		OF oSection2 Size 10	TITLE STR0028 Picture "@E 999,999.99"	

Return ( oReport )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ R330Imp  ³ Autor ³ Equipe RH          ³ Data ³  09/15/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao do relatorio.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER330                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R330Imp(oReport)
Local aOrdBagRI		:= {}
Local aOrdBag    	:= {}
Local aValBenef  	:= {}
Local aCodFol		:= {}  
Local cAcessaSRA 	:= &("{ || " + ChkRH("GPER330","SRA","2") + "}")
Local cAcessa	 	:= ""
Local cMesArqRef 	:= StrZero(Month(dDataBase),2) + StrZero(Year(dDataBase),4)
Local cArqMov    	:= 	""
Local cAliasMov 	:= 	""
Local cIndCond 		:=	""
Local cCentroCusto	:= 	""  
Local cBreakFil		:= 	""
Local cSitQuery		:= 	""
Local lTemNormal
Local lTemPendente    
Local oSection1		:= oReport:Section(1)
Local oSection2		:= oReport:Section(2)  
Local nOrdem 		:= oSection1:GetOrder()
Local nReg			:= 1
Local X				:= 1	   
Local oBreakCc            
Local aPerAberto    := {}
Local aPerFechado   := {}
Local aPerTodos     := {} 
Local cRotPesq		:= Space(TamSx3("RCF_ROTEIR")[1]) 
Local cMes			:= ""
Local cAno			:= "" 
Local cFilMov  		:= "" 
Local cMatMov		:= ""  
Local cPdMov		:= "" 
Local cTp1Mov		:= "" 
Local cKey			:= ""
Local cVerbas_Aux	:= ""
Local cFilPD		:= ""
Local nHrsMov  		:= 0 
Local nVlrMov		:= 0 
Local nPosAb		:= 0 
Local nPosFc		:= 0  
Local nHorDSR		:= 0
Local cModRel		:= "GPE"

// Variaveis auxiliares
Private lAberto		:= .T.
Private lFechado	:= .T.	
// Carregando variaveis mv_par?? para Variaveis do Sistema. 
Private cProcesso	:= MV_PAR01		//  Processo
Private cRoteiro	:= MV_PAR02		//  Roteiro
Private cPeriodo	:= MV_PAR03		//  Periodo
Private cNrPagto	:= MV_PAR04     //  Nro. Pagamento
Private cFilDe     	:= MV_PAR05		//  Filial De
Private cFilAte    	:= MV_PAR06		//  Filial Ate
Private cCcDe      	:= MV_PAR07		//  Centro de Custo De
Private cCcAte     	:= MV_PAR08		//  Centro de Custo Ate
Private cMatDe     	:= MV_PAR09		//  Matricula De
Private cMatAte    	:= MV_PAR10		//  Matricula Ate
Private cNomeDe    	:= MV_PAR11		//  Nome De
Private cNomeAte   	:= MV_PAR12		//  Nome Ate
Private cSituacao  	:= MV_PAR13		//  Situacao Funcionario
Private cVerba1    	:= MV_PAR14		//  Verbas de Horas Extras 1
Private cVerba2    	:= MV_PAR15		//  Verbas de Horas Extras 1
Private cVerba3    	:= MV_PAR16		//  Verbas de Horas Extras 1
Private cVerba4    	:= MV_PAR17		//  Verbas de Repouso
Private cVerba5    	:= MV_PAR18		//  Verbas de Abono Medico
Private cVerba6	   	:= MV_PAR19		//  Verbas de Falta
Private lSalta     	:= If( MV_PAR20 == 1 , .T. , .F. )   //  Salta Pagina Quebra C.Custo
Private nSepara    	:= MV_PAR21
Private nAnaSin    	:= MV_PAR22                          //  Analitica / Sintetica

Private cVerHex1  := cVerhex2 := cVerHex3 := cVerRepo := cVerAbMe := cVerFalta:= ""
Private Descanso  := 0
Private Normal    := 0
Private nSalMin	  := 0
Private cTipoRot	  := fGetTipoRot( cRoteiro )
Private lGestPubl 	:= IIF(ExistFunc("fUsaGFP"),fUsaGFP(),.F.)	//Verifica se utiliza o modulo de Gestao de Folha Publica - SIGAGFP

If lGestPubl
	cModRel:= cModulo
Endif



	// Monta String para Testar as Verbas                           
	For X = 1 To 30 Step 3 
		cVerHex1 += SubStr(cVerba1,X,3)
		cVerHex1 += "*"
		cVerHex2 += SubStr(cVerba2,X,3)
		cVerHex2 += "*"
		cVerHex3 += SubStr(cVerba3,X,3)
		cVerHex3 += "*"
		cVerRepo += SubStr(cVerba4,X,3)
		cVerrepo += "*"
		cVerAbMe += SubStr(cVerba5,X,3)
		cVerAbMe += "*"
		cVerFalta+= SubStr(cVerba6,X,3)
		cVerFalta+= "*"
	Next
	
	If nOrdem = 1  
	
		DEFINE BREAK oBreakCC OF oReport WHEN {|| (cAliasSRA)->RA_CC } TITLE OemToAnsi(STR0032) 
	
			DEFINE FUNCTION 					FROM oSection1:Cell("QUANTF") 		FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 9,999"  		NO END SECTION NO END REPORT 
			DEFINE FUNCTION NAME "HORASNOR" 	FROM oSection1:Cell("HORASNOR") 	FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 9999,999.99" 	NO END SECTION NO END REPORT 
			DEFINE FUNCTION 					FROM oSection1:Cell("1HREXTRA") 	FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 9999,999.99" 	NO END SECTION NO END REPORT 
			DEFINE FUNCTION 					FROM oSection1:Cell("2HREXTRA") 	FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 9999,999.99" 	NO END SECTION NO END REPORT 
			DEFINE FUNCTION 					FROM oSection1:Cell("3HREXTRA") 	FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 999,999.99"		NO END SECTION NO END REPORT 
			DEFINE FUNCTION NAME "TOTALEXT" 	FROM oSection1:Cell("TOTALEXT") 	FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 9999,999.99"	NO END SECTION NO END REPORT 
			DEFINE FUNCTION 					FROM oSection1:Cell("PERCHREX") 	FUNCTION ONPRINT 	BREAK oBreakCC  PICTURE "@E 9999.99999"		NO END SECTION NO END REPORT  FORMULA {|| (oSection1:GetFunction("TOTALEXT"):GetLastValue() / oSection1:GetFunction("HORASNOR"):GetLastValue()) * 100 } 
			DEFINE FUNCTION 					FROM oSection1:Cell("HRREPOUSO") 	FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 999,999.99"		NO END SECTION NO END REPORT 
			DEFINE FUNCTION NAME "ABONOMED" 	FROM oSection1:Cell("ABONOMED") 	FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 999,999.99"		NO END SECTION NO END REPORT 
			DEFINE FUNCTION 					FROM oSection1:Cell("PERCABONO") 	FUNCTION ONPRINT 	BREAK oBreakCC  PICTURE "@E 9999.99999"		NO END SECTION NO END REPORT  FORMULA {|| (oSection1:GetFunction("ABONOMED"):GetLastValue() / oSection1:GetFunction("HORASNOR"):GetLastValue()) * 100 } 
			DEFINE FUNCTION NAME "HORASFAL" 	FROM oSection1:Cell("HORASFAL") 	FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 999,999.99"		NO END SECTION NO END REPORT 
			DEFINE FUNCTION 					FROM oSection1:Cell("PERCFAL") 		FUNCTION ONPRINT 	BREAK oBreakCC  PICTURE "@E 9999.99999"		NO END SECTION NO END REPORT  FORMULA {|| (oSection1:GetFunction("HORASFAL"):GetLastValue() / oSection1:GetFunction("HORASNOR"):GetLastValue()) * 100 } 
			DEFINE FUNCTION 					FROM oSection1:Cell("XDIAS")		FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 999.99"			NO END SECTION NO END REPORT 
			DEFINE FUNCTION 					FROM oSection1:Cell("HRPAGAS") 		FUNCTION SUM 		BREAK oBreakCC  PICTURE "@E 999,999.99"		NO END SECTION NO END REPORT 
	        
	        oBreakCc:OnBreak({|x,y|cCentroCusto := OemToAnsi(STR0032)+x})// "Total Centro de Custo: " 
	        oBreakCC:SetTotalText({||cCentroCusto})
			oBreakCC:SetPageBreak(lSalta)	        
			
			If nAnaSin == 2                      
				oBreakCc:SetTotalInLine(.T.)
			EndIf        

	EndIf
		
	DEFINE BREAK oBreakFil OF oReport WHEN oSection1:Cell("RA_FILIAL") TITLE  OemToAnsi(STR0033)                                       	

		DEFINE FUNCTION 					FROM oSection1:Cell("QUANTF") 		FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 9,999" 		NO END REPORT NO END SECTION 
		DEFINE FUNCTION NAME "FILHORASNOR" 	FROM oSection1:Cell("HORASNOR") 	FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 9999,999.99"	NO END REPORT NO END SECTION 
		DEFINE FUNCTION 					FROM oSection1:Cell("1HREXTRA") 	FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 9999,999.99"	NO END REPORT NO END SECTION 
		DEFINE FUNCTION 					FROM oSection1:Cell("2HREXTRA") 	FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 9999,999.99"	NO END REPORT NO END SECTION 
		DEFINE FUNCTION 					FROM oSection1:Cell("3HREXTRA") 	FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION 
		DEFINE FUNCTION NAME "FILTOTALEXT" 	FROM oSection1:Cell("TOTALEXT") 	FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 9999,999.99"	NO END REPORT NO END SECTION 
		DEFINE FUNCTION 					FROM oSection1:Cell("PERCHREX") 	FUNCTION ONPRINT 	BREAK oBreakFil  PICTURE "@E 9999.99999"	NO END REPORT NO END SECTION  FORMULA {|| (oSection1:GetFunction("FILTOTALEXT"):GetLastValue() / oSection1:GetFunction("FILHORASNOR"):GetLastValue()) * 100 } 
		DEFINE FUNCTION 					FROM oSection1:Cell("HRREPOUSO") 	FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION 
		DEFINE FUNCTION NAME "FILABONOMED" 	FROM oSection1:Cell("ABONOMED") 	FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION 
		DEFINE FUNCTION 					FROM oSection1:Cell("PERCABONO")	FUNCTION ONPRINT 	BREAK oBreakFil  PICTURE "@E 9999.99999"	NO END REPORT NO END SECTION  FORMULA {|| (oSection1:GetFunction("FILABONOMED"):GetLastValue() / oSection1:GetFunction("FILHORASNOR"):GetLastValue()) * 100 } 
		DEFINE FUNCTION NAME "FILHORASFAL" 	FROM oSection1:Cell("HORASFAL") 	FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION 
		DEFINE FUNCTION 					FROM oSection1:Cell("PERCFAL") 		FUNCTION ONPRINT 	BREAK oBreakFil  PICTURE "@E 9999.99999"	NO END REPORT NO END SECTION  FORMULA {|| (oSection1:GetFunction("FILHORASFAL"):GetLastValue() / oSection1:GetFunction("FILHORASNOR"):GetLastValue()) * 100 } 
		DEFINE FUNCTION 					FROM oSection1:Cell("XDIAS")		FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 999.99"		NO END REPORT NO END SECTION 
		DEFINE FUNCTION 					FROM oSection1:Cell("HRPAGAS") 		FUNCTION SUM 		BREAK oBreakFil  PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION 
	    
    oBreakFil:OnBreak({|x,y| cBreakFil := OemToAnsi(STR0033)+x}) // "Total Filial: " 
    oBreakFil:SetTotalText({||cBreakFil})  
    
    If nAnaSin == 2 
		oBreakFil:SetTotalInLine(.T.)
	EndIf  
	
	If nAnaSin == 2 
		oReport:SetTotalInLine(.T.)
	EndIf   
	    
	// Faz filtro no arquivo...                                                 
	
	cAliasSRA	:= GetNextAlias()

	//-- Modifica variaveis para a Query
	For nReg:=1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cSituacao)
			cSitQuery += "," 
		EndIf
	Next nReg     
	cSitQuery := "%" + cSitQuery + "%"
			    
	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr("GPR330")   
 
   		BEGIN REPORT QUERY oSection1
   		
   		// "Matr¡cula"###"Centro de Custo"###"Nome"###"Centro de Custo + Nome"//
		If nOrdem == 1
			cIndCond :=  "%RA_FILIAL,RA_CC,RA_MAT%"
		ElseIf nOrdem == 2
			cIndCond := "%RA_FILIAL,RA_MAT%"
		ElseIf nOrdem == 3
			cIndCond := "%RA_FILIAL,RA_NOME%"
		EndIf
   		
		BeginSql alias cAliasSRA  // "SRA"              
	
			SELECT SRA.*
			FROM %table:SRA% SRA 
			WHERE	SRA.RA_PROCES 	= %exp:cProcesso% AND
					SRA.RA_FILIAL 	>= %exp:cFilDe% AND SRA.RA_FILIAL	<= %exp:cFilAte% AND
					SRA.RA_CC	 	>= %exp:cCcDe% AND SRA.RA_CC		<= %exp:cCcAte% AND
					SRA.RA_MAT	 	>= %exp:cMatDe% AND SRA.RA_MAT	<= %exp:cMatAte% AND
					SRA.RA_NOME 	>= %exp:cNomeDe% AND SRA.RA_NOME	<= %exp:cNomeAte% AND	
					SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%) AND
				  	SRA.%notDel%   
					ORDER BY %exp:cIndCond%
		EndSql   
	 		    
	END REPORT QUERY oSection1 
	
	oSection2:SetParentQuery()
	
	cAno	:= SubStr(cPeriodo,1,4)		
    cMes	:= SubStr(cPeriodo,5,2) 
    fRetPerComp( 	cMes		  ,;	// Obrigatorio - Mes para localizar as informacoes
					cAno		  ,;	// Obrigatorio - Ano para localizar as informacoes
					xFilial("RCH"),;	// Opcional - Filial a Pesquisar
					cProcesso	  ,;	// Opcional - Filtro por Processo
				   	cRoteiro	  ,;	// Opcional - Filtro por Roteiro
				   	@aPerAberto	  ,;	// Por Referencia - Array com os periodos Abertos
					@aPerFechado, ;		// Por Referencia - Array com os periodos Fechados
					@aPerTodos    ;		// Por Referencia - Array com os periodos Abertos e Fechados em Ordem Crescente
				)  
    nPosAb	:= 	aScan(aPerAberto, {|x|  x[1]+x[2]+x[7]+x[8] == cPeriodo + cNrPagto + cProcesso + cRoteiro })
    lAberto	:= 	If(nPosAb == 0, .F., .T.)
    nPosFc	:=	aScan(aPerFechado, {|x|  x[1]+x[2]+x[7]+x[8] == cPeriodo + cNrPagto + cProcesso + cRoteiro })
    lFechado:= 	If(nPosFc == 0, .F., .T.)
	// Verifica se existe o arquivo do periodo 
  	If  !lAberto .And. !lFechado		 
		 MsgAlert( OemToAnsi( STR0036 ) , OemToAnsi( STR0034 ) ) //"Atencao"###"Periodo nao calculado!"  		
		Return (.F.) 
	EndIf  
	
	If( lAberto, cAliasMov	:= "SRC", cAliasMov := "SRD")   
	If lAberto
		cAcessa := &("{ || " + ChkRH("GPER330","SRC","2") + "}") 
	Else 
		cAcessa := &("{ || " + ChkRH("GPER330","SRD","2") + "}") 
	EndIf 
	
	dbGoTop()
	
	cFilialSv 	:= Space(FWGETTAMFILIAL)
	cCcAnt     	:= Space(9)
	
	dbSelectArea(cAliasSRA)  
	
	oSection1:Init()   
	
   	If nAnaSin == 2
		oSection1:Hide()
 	EndIf  
				
	While !EoF()
					
		dbSelectArea("SRA")
		SRA->( dbSetOrder(1) )
		SRA->( dbSeek( (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT ) )	   	
		dbSelectArea(cAliasSRA) 
		
					
		// Movimenta Regua Processamento                                
		// Incrementa a regua da tela de processamento do relatorio
	  	oReport:IncMeter()
	    
	    // Consiste controle de acessos e filiais validas                             
		IF !( (cAliasSRA)->RA_FILIAL $ fValidFil() .and. Eval( cAcessaSRA ) )
			dbSelectArea(cAliasSRA)
	      	dbSkip()
	       	Loop
 		EndIF
		
		// Verifica se o usuario cancelou a impressao do relatorio
		If oReport:Cancel()
			Exit
		EndIf      
	
	    If (cAliasSRA)->RA_FILIAL # cFilialSv
			If !Fp_CodFol(@aCodFol,(cAliasSRA)->RA_FILIAL)		.Or.;
				!fInfo(@aInfo,(cAliasSRA)->RA_FILIAL)			.Or.;
				Iif( !(cPaisLoc=="BRA"), .F., !Sal_Min(@nSalMin,MesAno(dDataBase),(cAliasSRA)->RA_FILIAL) )
				Exit
			EndIf	
			dbSelectArea(cAliasSRA)
			cFilialSv := (cAliasSRA)->RA_FILIAL
		EndIf
			
		nSalario   := 0
		nSalMes    := 0
		nSalDia    := 0
		nSalHora   := 0
	
		// Calcula Salario Mes , Dia , Hora do Funcionario              
		fSalario(@nSalario,@nSalHora,@nSalDia,@nSalMes)
		
		nConFun := nHorNor := nHorHe1 := nHorHe2 := nHorHe3 := nTotHex := 0
		nPerHex := nHorRep := nHorAme := nHorFal := nPerFal := nHor	:= nDias	:= 0
		
		// Calcula os Dois Blocos para o Funcionario                    
		aPosicao1:={} // Limpa Arrays
		Aadd(aPosicao1,{0,0,0,0,0,0,0,0,0,0,0,0,0,0})
	    
	    cKey	:= cPeriodo + cNrPagto + cAno + cMes + cProcesso +;
   					cRotPesq 

		cFilPD := xFilial("SRV")

		//Busca as verbas que irão compor a média salarial (HOJORVA)
		gp140GrpVerb(cFilPD,@cVerbas_Aux,"0",.F.)
		
		// Verifica as Horas Normais das Verbas de Salario.             
		dbSelectArea( cAliasMov )
		dbSetOrder( 1 )  
		
		If  dbSeek( (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT )        
			nConFun ++  
			While &(cAliasMov)->(!Eof()) .And. &(&(cAliasMov)->(PrefixoCpo(cAliasMov)+"_FILIAL")) + ;
												&(&(cAliasMov)->(PrefixoCpo(cAliasMov)+"_MAT")) ==;
												(cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT   
				cPdMov	:= &(&(cAliasMov)->(PrefixoCpo(cAliasMov)+"_PD"))       
				nHrsMov	:= &(&(cAliasMov)->(PrefixoCpo(cAliasMov)+"_HORAS"))     
				cTp1Mov	:= &(&(cAliasMov)->(PrefixoCpo(cAliasMov)+"_TIPO1"))      
				nVlrMov	:= &(&(cAliasMov)->(PrefixoCpo(cAliasMov)+"_VALOR")) 
				// Consiste controle de acessos								 
				If !Eval(cAcessa)
					dbSkip()
					Loop
				EndIf
	
				// Verifica as Horas Normais Mensalista e Horista               
				If (cPdMov == aCodFol[031,1]) .Or. (cPdMov == aCodFol[219,1]) .Or. (cPdMov == aCodFol[644,1])	
					// '031' para funcionario mensalista, '219' para estagiario mensalista	, '644' para funcionario estatutario	 					 					
					// Busca no periodo
   					dbSelectArea("RCF")
   					dbSetOrder(4) // RCF_FILIAL+RCF_PER+RCF_SEMANA+RCF_ANO+RCF_MES+RCF_PROCES+RCF_ROTEIR+RCF_TNOTRA+DTOS(RCF_DTINI)+DTOS(RCF_DTFIM)+RCF_MODULO 
   					cKeySeek	:= xFilial("RCF",(cAliasSRA)->RA_FILIAL) + cKey
					If RCF->(dbSeek(cKeySeek))  
						IF RCF->(DTOS(RCF_DTINI)+DTOS(RCF_DTFIM)+RCF_MODULO ) == If(lAberto, DtoS(aPerAberto[nPosAb][5]),DtoS(aPerFechado[nPosFc][5])) + If(lAberto, DtoS(aPerAberto[nPosAb][6]),DtoS(aPerFechado[nPosFc][6])) + cModRel
							IF (RCF->RCF_TNOTRA <> "@@@" .AND. RCF->RCF_TNOTRA == (cAliasSRA)->RA_TNOTRAB) .OR. RCF->RCF_TNOTRA == "@@@"
								nHor :=(cAliasSRA)->RA_HRSDIA * RCF->RCF_DUTEIS 
								If nSepara == 1   // Separa Dsr pra Mensalistas
									nHorDSR	 := (cAliasSRA)->RA_HRSDIA *  RCF->RCF_DIADSR
								EndIf
							EndIF
						EndIF
					EndIf

					dbSelectArea( cAliasMov )	
					nHorNor := nHor
					nHorRep += Round( nHorDSR , 2 ) 			
	
				EndIf    
				
				If  ((cPdMov == aCodFol[032,1]) .Or. (cPdMov == aCodFol[220,1])) .Or. (lHojorva .And. ;
					 (cAliasSRA)->RA_CATFUNC == "H" .and. (cAliasSRA)->RA_HOJORVA == "1" .And. ;
					 cPdMov $ cVerbas_Aux .And. cPdMov != aCodFol[033,1] )   
					// '032' para funcionario horista, '220' para estagiario horista
					//Se a verba for de desconto subtrai senão soma
					If POSSRV( cPDMov, (cAliasSRA)->RA_FILIAL, "RV_TIPOCOD" ) == "2"
						nHorNor -= nHrsMov
					Else
						nHorNor += nHrsMov
					Endif
				EndIf
	
				// Verifica as Horas Extras.                                    
				If cPdMov $ cVerHex1
					nHorHe1 += nHrsMov
				EndIf 
				
				If cPdMov $ cVerHex2
					nHorHe2 += nHrsMov
				EndIf
				
				If cPdMov $ cVerHex3
					nHorHe3 += nHrsMov
				EndIf
	
				// Verifica Horas de Repouso.                                   
				If cPdMov $ cVerRepo
					nHorRep += nHrsMov
				EndIf
	
				// Verifica Horas de Abono Medico.                              
				If cPdMov $ cVerAbMe     
					If cTp1Mov == "V"				// Valor
						If nSalHora # 0
							nHorAme += nVlrMov / nSalHora				
						EndIf	
					ElseIf cTp1Mov == "D"		// Dias
						nHorAme += ((cAliasSRA)->RA_HRSMES / 30) * nHrsMov
						nDias 	+= nHrsMov
					Else
						nHorAme += nHrsMov
					EndIf	
				EndIf
	
				// Verifica Horas de Faltas e Atrasos.                          
				If cPdMov $ cVerFalta
					If cTp1Mov == "V"	// Valor
						If nSalHora # 0
							nHorFal += nVlrMov / nSalHora				
						EndIf	
					ElseIf cTp1Mov == "D"	 // Dias
						nHorFal += ((cAliasSRA)->RA_HRSMES / 30) * nHrsMov
						nDias 	+= nHrsMov
					Else
						nHorFal += nHrsMov
					EndIf	
				EndIf
			
				&(cAliasMov)->(dbSkip())
				
			Enddo
			
		EndIf		
	
		// Elemento do Array                                            
		nPos00 := nConFun
		nPos01 := nHorNor
		nPos02 := nHorHe1
		nPos03 := nHorHe2
		nPos04 := nHorHe3
		nPos05 := ( nPos02 + nPos03 + nPos04 )
		nPos06 := ( nPos05 / nPos01 ) * 100
		nPos07 := nHorRep
		nPos08 := nHorAme
		nPos09 := ( nPos08 / nPos01 ) * 100
		nPos10 := nHorFal
		nPos11 := ( nPos10 / nPos01 ) * 100
		nPos12 := nDias
		nPos13 := ( ( nPos01 + nPos05 + nPos07 + nPos08 ) - nPos10 )
		Atualiza(@aPosicao1,1,nPos00,nPos01,nPos02,nPos03,nPos04,nPos05,nPos06,nPos07,nPos08,nPos09,nPos10,nPos11,nPos12,nPos13)
		      
		oSection1:Cell("QUANTF"):SetValue(nPos00)
		oSection1:Cell("HORASNOR"):SetValue(nPos01)
		oSection1:Cell("1HREXTRA"):SetValue(nPos02)
		oSection1:Cell("2HREXTRA"):SetValue(nPos03)
		oSection1:Cell("3HREXTRA"):SetValue(nPos04)
		oSection1:Cell("TOTALEXT"):SetValue(nPos05)
		oSection1:Cell("PERCHREX"):SetValue(nPos06)
		oSection1:Cell("HRREPOUSO"):SetValue(nPos07)
		oSection1:Cell("ABONOMED"):SetValue(nPos08)
		oSection1:Cell("PERCABONO"):SetValue(nPos09)
		oSection1:Cell("HORASFAL"):SetValue(nPos10)
		oSection1:Cell("PERCFAL"):SetValue(nPos11)
		oSection1:Cell("XDIAS"):SetValue(nPos12)
		oSection1:Cell("HRPAGAS"):SetValue(nPos13)
		 	   						
		oSection1:PrintLine()  
		
		If nAnaSin == 1
			oReport:ThinLine()
		EndIf
	
		dbSelectArea(cAliasSRA)
		dbSkip()   	
	Enddo     
		
	// Finaliza impressao inicializada pelo metodo Init             
	oSection1:Finish()

Return( Nil )         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ Atualiza    ³ Autor ³ Equipe RH       ³ Data ³  --/--/--   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Atualiza posicoes.            							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER330                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Atualiza(aMatriz,nElem,nPos00,nPos01,nPos02,nPos03,nPos04,nPos05,nPos06,nPos07,nPos08,nPos09,nPos10,nPos11,nPos12,nPos13)

	aMatriz[nElem,01] := nPos00
	aMatriz[nElem,02] := nPos01
	aMatriz[nElem,03] := nPos02
	aMatriz[nElem,04] := nPos03
	aMatriz[nElem,05] := nPos04
	aMatriz[nElem,06] := nPos05
	aMatriz[nElem,07] := nPos06
	aMatriz[nElem,08] := nPos07
	aMatriz[nElem,09] := nPos08
	aMatriz[nElem,10] := nPos09
	aMatriz[nElem,11] := nPos10
	aMatriz[nElem,12] := nPos11
	aMatriz[nElem,13] := nPos12
	aMatriz[nElem,14] := nPos13  

Return ( Nil )
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ fTestaTotal ³ Autor ³ Equipe RH       ³ Data ³  --/--/--   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Consiste controle de acessos e filiais validas.            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER330                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fTestaTotal()
Local aArea := GetArea()
	
	dbSelectArea("SRA")
		cFilialSv := SRA->RA_FILIAL   // Iguala Variaveis
		cCcAnt     := SRA->RA_CC
	dbSkip()
	
	If Eof()
		fImpCc()
		fImpFil()
		fImpEmp()
	ElseIf cFilialSv # SRA->RA_FILIAL
		fImpCc()
		fImpFil()
	ElseIf cCcAnt # SRA->RA_CC
		fImpCc()
	EndIf    
	
	RestArea(aArea)

Return ( Nil ) 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ fImpCc      ³ Autor ³ Equipe RH       ³ Data ³  --/--/--   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime Centro de Custo.							          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER330                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpCc()
Local cDescCc := ""
Local nImpCc  := 0	
	
	// Auxiliar para Tratamento do Bloco de Codigo                    
	
	AeVal(aTotCc1,{ |X| nImpCc += X[1] })  // Testa se a Soma == 0
	
	If nImpCc == 0
		Return Nil
	EndIf
	
	If Len(aTotCc1) == 0 .Or. nOrdem # 1
		Return Nil
	EndIf
	
	cDescCc := DescCc(cCcAnt,cFilialSv)
	cDescCc := SubStr( cDescCc + Space(20) , 1 , 20 )
	
	cDet    := cFilialSv+" "+Subs(AllTrim(cCcAnt)+ "-"+AllTrim(cDescCc)+Space(37),1,37)+ " * "
	fImpComp(aTotCc1,1) // Imprime
	aTotCc1 :={}      	// Zera
	
	cDet := Repl("-",220)
	Impr(cDet,"C")
	
	If nAnaSin == 1
		Impr("","C")
		cDet := Repl("-",220)
		Impr(cDet,"C")
	EndIf
		
	// Salta de Pagina na Quebra de Centro de Custo (lSalta = .T.) 
	If nAnaSin == 1 .And. lSalta
		Impr("","P")
	EndIf

Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	fImpFil    ³ Autor ³ Equipe RH       ³ Data ³  --/--/--   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime Filial.									          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER330                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpFil()
Local cDescFil := ""
Local nImpFi   := 0
	
	
	//Auxiliar para Tratamento do Bloco de Codigo                   
	AeVal(aTotFil1,{ |X| nImpFi += X[1] })  // Testa se a Soma == 0
	
	If nImpFi == 0
		Return Nil
	EndIf
	
	If Len(aTotFil1) == 0
		Return Nil
	EndIf
	
	cDescFil := aInfo[1]
	cDescFil := SubStr( cDescFil + Space(30) , 1 , 30 )
	
	cDet     := cFilialSv + " " + " " + Space(06) + cDescFil + " * "
	fImpComp(aTotFil1,2) 	// Imprime
	aTotFil1 :={}      		// Zera
	
	cDet := Repl("=",220)
	Impr(cDet,"C")

Return( Nil )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	fImpEmp    ³ Autor ³ Equipe RH       ³ Data ³  --/--/--   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime Empresa.									          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER330                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpEmp()
Local cDescEmp := ""
Local nImpEm   := 0
	
	// Auxiliar para Tratamento do Bloco de Codigo                    
	AeVal(aTotEmp1,{ |X| nImpEm += X[1] })  // Testa se a Soma == 0
	
	If nImpEm == 0
		Return Nil
	EndIf
	
	If Len(aTotEmp1) == 0
		Return Nil
	EndIf
	
	cDescEmp := Substr(aInfo[3] + Space(30) , 1  , 30 )
	cDet     := "  " + " " + " " + Space(06) + cDescEmp + " * "
	fImpComp(aTotEmp1,3) 	// Imprime
	aTotEmp1 :={}      		// Zera
	
	Impr("","F") 

Return ( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ fImpComp    ³ Autor ³ Equipe RH       ³ Data ³  --/--/--   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime complemento de impressao.				          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER330                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpComp(aPosicao,nQuebra) 
// aPosicao = Array Contendo o que vai ser impresso           
// Resultado de Impressao para testar se tudo nao esta zerado  
Local nResImp := 0
	
	// Auxiliar para Tratamento do Bloco de Codigo                    
	AeVal(aPosicao,{ |X| nResImp += X[1] })  // Testa se a Soma == 0
	aPosicao[01,07] := ( aPosicao[01,06] / aPosicao[01,02] ) * 100
	aPosicao[01,10] := ( aPosicao[01,09] / aPosicao[01,02] ) * 100
	aPosicao[01,12] := ( aPosicao[01,11] / aPosicao[01,02] ) * 100
	
	// Imprime se Possui Valores                                    
	If nResImp > 0
		cDet += TRANSFORM(aPosicao[01,01],"@E 99,999")       + " * "
		cDet += TRANSFORM(aPosicao[01,02],"@E 9999,999.99")  + " * "
		cDet += TRANSFORM(aPosicao[01,03],"@E 9999,999.99")  + "* "
		cDet += TRANSFORM(aPosicao[01,04],"@E 9999,999.99")  + "* "
		cDet += TRANSFORM(aPosicao[01,05],"@E 9999,999.99")  + "* "
		cDet += TRANSFORM(aPosicao[01,06],"@E 99999,999.99") + "* "
		cDet += TRANSFORM(aPosicao[01,07],"@E 999.99999")    + "* "
		cDet += TRANSFORM(aPosicao[01,08],"@E 999,999.99")   + "* "
		cDet += TRANSFORM(aPosicao[01,09],"@E 999,999.99")   + "*  "
		cDet += TRANSFORM(aPosicao[01,10],"@E 999.99999")    + " * "
		cDet += TRANSFORM(aPosicao[01,11],"@E 999,999.99")   + " *"
		cDet += TRANSFORM(aPosicao[01,12],"@E 999.99999")    + " *"
		cDet += TRANSFORM(aPosicao[01,13],"@E 999.99") 	  + " * "
		cDet += TRANSFORM(aPosicao[01,14],"@E 999,999.99")   + " * "
		IMPR(cDET,"C")
		Return .T.
	Else
		Return .F.
	EndIf

Return  

	