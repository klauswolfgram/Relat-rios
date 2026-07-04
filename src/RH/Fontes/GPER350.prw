/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER350.CH"
#INCLUDE "report.ch"

/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER350  ³ Autor ³ R.H. - Marcos Stiefano  ³ Data ³ 22.04.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Classificacao por Cargos                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER350(void)                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia Car.³06/06/2014³TPSZBM³Incluido o fonte da 11 para a 12 e efetua-³±± 
±±³            ³          ³      ³da a limpeza.                             ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER350()
Local	oReport   
Local	aArea 	:= GetArea()
Private	cString	:= "SRA"				// alias do arquivo principal (Base)
Private cPerg	:= "GP350R"
Private aOrd    := {OemToAnsi(STR0001),OemToAnsi(STR0002),OemToAnsi(STR0003)}	
					//"C.Custo + Matricula "###"C.Custo + Nome"###"C.Custo + Fun‡„o"
Private cTitulo	:= OemToAnsi(STR0009)	//"RELA€ŽO DE CLASSIFICA€ŽO POR CARGOS"

	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.) 

oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef  ³ Autor ³ Tania Bronzeri        ³ Data ³20/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relacao de Classificacao por Cargos                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER350                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GPER350 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport 
Local oSection1 
Local oMedATpServ
Local oMedMTpServ       
Local oMedTServ
Local cDesc1	:= OemToAnsi(STR0004) + OemToAnsi(STR0005) + OemToAnsi(STR0006)	
Local nTamData	:= TamSX3("RA_DEMISSA")[1] + 10
//"Rela‡„o de Classifica‡„o por Cargos." ### "Ser  impresso de acordo com os parametros solicitados pelo" ### "usu rio."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "GPER350" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| R350Imp(oReport)} DESCRIPTION OemtoAnsi(STR0021) TOTAL IN COLUMN	 
//"Este programa emite Relacao de Classificacao por Cargos."

	DEFINE SECTION oSection1 OF oReport TITLE OemToAnsi(STR0040) TABLES "SRA" TOTAL IN COLUMN ORDERS aOrd

		DEFINE CELL NAME "RA_FILIAL" 	OF oSection1 ALIAS cString
		DEFINE CELL NAME "RA_MAT" 	 	OF oSection1 ALIAS cString SIZE 20
		DEFINE CELL NAME "RA_NOME" 	 	OF oSection1 ALIAS cString
		DEFINE CELL NAME "RA_CC"		OF oSection1 ALIAS cString
		DEFINE CELL NAME "CTT_DESC01"	OF oSection1 ALIAS "CTT" SIZE 20
		DEFINE CELL NAME "RA_CODFUNC"	OF oSection1 ALIAS cString
		DEFINE CELL NAME "RJ_DESC"		OF oSection1 ALIAS "SRJ"
		DEFINE CELL NAME "RA_NASC"		OF oSection1 ALIAS cString SIZE 15
		DEFINE CELL NAME "RA_DEMISSA"	OF oSection1 ALIAS cString SIZE nTamData 
		DEFINE CELL NAME "IDADE"		OF oSection1 TITLE OemToAnsi(STR0022) PICTURE "99" SIZE 6;	// "IDADE"
				BLOCK {||Int((dDataBase - (cAliasQry)->RA_NASC) / 365)}
		DEFINE CELL NAME "TEMPOSERV"	OF oSection1 TITLE OemToAnsi(STR0023) SIZE 20;	// "TEMPO SERVICO"
				BLOCK {||U_fBuscaTempoServ("T")}
		DEFINE CELL NAME "ATEMPOSERV"	OF oSection1 TITLE OemToAnsi(STR0023) SIZE 4 PICTURE "@E 99"	;	// "TEMPO SERVICO"	//Ano
				BLOCK {||U_fBuscaTempoServ("A")}
		DEFINE CELL NAME "MTEMPOSERV"	OF oSection1 TITLE OemToAnsi(STR0023) SIZE 2 PICTURE "@E 99"	;	// "TEMPO SERVICO"	//Mes
				BLOCK {||U_fBuscaTempoServ("M")}
		DEFINE CELL NAME "SALARIOMES"	OF oSection1 TITLE OemToAnsi(STR0024) PICTURE "@E 99,999,999.99" SIZE 18	;	// "SALARIO MES"
				BLOCK {||U_fBuscaSalario("M")}
		DEFINE CELL NAME "SALARIODIA"	OF oSection1 TITLE OemToAnsi(STR0025) PICTURE "@E 99,999,999.99" SIZE 18	;	// "SALARIO DIA"
				BLOCK {||U_fBuscaSalario("D")}

		TRPosition():New(oSection1,"CTT",1,{|| RhFilial("CTT",SRA->RA_FILIAL)+SRA->RA_CC},.T.)
		TRPosition():New(oSection1,"SRJ",1,{|| RhFilial("SRJ",SRA->RA_FILIAL)+SRA->RA_CODFUNC},.T.)
		
		/*
		DEFINE FUNCTION NAME "TOTAL"       FROM oSection1:Cell("RA_MAT")     FUNCTION COUNT   TITLE OemToAnsi(STR0026) OF oSection1 									NO END SECTION								//"TOTAL"
		DEFINE FUNCTION NAME "MASCULINO"   FROM oSection1:Cell("RA_MAT")     FUNCTION COUNT   TITLE OemToAnsi(STR0027) OF oSection1 									NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"TOTAL MASCUL."
		DEFINE FUNCTION NAME "FEMININO"    FROM oSection1:Cell("RA_MAT")     FUNCTION COUNT   TITLE OemToAnsi(STR0028) OF oSection1 									NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"TOTAL FEMIN."
		DEFINE FUNCTION NAME "TOTSALAR"    FROM oSection1:Cell("SALARIOMES") FUNCTION SUM     TITLE OemToAnsi(STR0029) OF oSection1 PICTURE "@E 999,999,999,999.99"	NO END SECTION                            	//"TOTAL SALARIOS"
		DEFINE FUNCTION NAME "MEDSALMAS"   FROM oSection1:Cell("SALARIOMES") FUNCTION AVERAGE TITLE OemToAnsi(STR0030) OF oSection1 PICTURE "@E 999,999,999,999.99"	NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"MEDIA SAL. MASC."
		DEFINE FUNCTION NAME "MEDSALFEM"   FROM oSection1:Cell("SALARIOMES") FUNCTION AVERAGE TITLE OemToAnsi(STR0031) OF oSection1 PICTURE "@E 999,999,999,999.99"	NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"MEDIA SAL. FEM."

		DEFINE FUNCTION oMedATpServ  NAME "MEDATPSERV"  FROM oSection1:Cell("ATEMPOSERV") 	FUNCTION SUM 	 TITLE OemToAnsi(STR0032) OF oSection1 PICTURE "@E 99"					NO END SECTION 								//"MED. TEMPO SERV."	//Ano
		DEFINE FUNCTION oMedMTpServ  NAME "MEDMTPSERV"  FROM oSection1:Cell("MTEMPOSERV") 	FUNCTION SUM 	 TITLE OemToAnsi(STR0032) OF oSection1 PICTURE "@E 99"					NO END SECTION 								//"MED. TEMPO SERV."	//Mes
		DEFINE FUNCTION oMedTServ	 NAME "MEDTSERV"    FROM oSection1:Cell("TEMPOSERV")	FUNCTION ONPRINT TITLE OemToAnsi(STR0032) OF oSection1 FORMULA {||CalcMedTS(oSection1:GetFunction("MEDATPSERV"  ):GetLastValue(),oSection1:GetFunction("MEDMTPSERV" ):GetLastValue(),oSection1:GetFunction("TOTAL"    ):GetLastValue()) }  NO END SECTION 	//"MED. TEMPO SERV."

		DEFINE FUNCTION oMedATpServM NAME "MEDATPSERVM"  FROM oSection1:Cell("ATEMPOSERV") 	FUNCTION SUM	 TITLE OemToAnsi(STR0033) OF oSection1 PICTURE "@E 99"	NO END SECTION WHEN {||SRA->RA_SEXO=="M"} 								//"MED. TEMPO SERV.MASC."	//Ano
		DEFINE FUNCTION oMedMTpServM NAME "MEDMTPSERVM"  FROM oSection1:Cell("MTEMPOSERV") 	FUNCTION SUM	 TITLE OemToAnsi(STR0033) OF oSection1 PICTURE "@E 99"	NO END SECTION WHEN {||SRA->RA_SEXO=="M"} 								//"MED. TEMPO SERV.MASC."	//Mes
		DEFINE FUNCTION oMedTServM	 NAME "MEDTSERVM"    FROM oSection1:Cell("TEMPOSERV")	FUNCTION ONPRINT TITLE OemToAnsi(STR0033) OF oSection1 FORMULA {||CalcMedTS(oSection1:GetFunction("MEDATPSERVM" ):GetLastValue(),oSection1:GetFunction("MEDMTPSERVM"):GetLastValue(),oSection1:GetFunction("MASCULINO"):GetLastValue()) }  NO END SECTION 	//"MED. TEMPO SERV.MASC."

		DEFINE FUNCTION oMedATpServF NAME "MEDATPSERVF"  FROM oSection1:Cell("ATEMPOSERV") 	FUNCTION SUM	 TITLE OemToAnsi(STR0034) OF oSection1 PICTURE "@E 99"	NO END SECTION WHEN {||SRA->RA_SEXO=="F"} 								//"MED. TEMPO SERV.FEM."	//Ano
		DEFINE FUNCTION oMedMTpServF NAME "MEDMTPSERVF"  FROM oSection1:Cell("MTEMPOSERV") 	FUNCTION SUM	 TITLE OemToAnsi(STR0034) OF oSection1 PICTURE "@E 99"	NO END SECTION WHEN {||SRA->RA_SEXO=="F"} 								//"MED. TEMPO SERV.FEM."	//Mes
		DEFINE FUNCTION oMedTServF	 NAME "MEDTSERVF"    FROM oSection1:Cell("TEMPOSERV")	FUNCTION ONPRINT TITLE OemToAnsi(STR0034) OF oSection1 FORMULA {||CalcMedTS(oSection1:GetFunction("MEDATPSERVF" ):GetLastValue(),oSection1:GetFunction("MEDMTPSERVF"):GetLastValue(),oSection1:GetFunction("FEMININO" ):GetLastValue()) }  NO END SECTION 	//"MED. TEMPO SERV.FEM."

		DEFINE FUNCTION NAME "MEDIDADES"   FROM oSection1:Cell("IDADE")      FUNCTION AVERAGE TITLE OemToAnsi(STR0035) 									NO END SECTION 								//"MEDIA IDADES TOTAL"
		DEFINE FUNCTION NAME "MEDIDADEMAS" FROM oSection1:Cell("IDADE")      FUNCTION AVERAGE TITLE OemToAnsi(STR0036) 									NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"MEDIA IDADES MASC."
		DEFINE FUNCTION NAME "MEDIDADEFEM" FROM oSection1:Cell("IDADE")      FUNCTION AVERAGE TITLE OemToAnsi(STR0037) 									NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"MEDIA IDADES FEM."
		*/
		
		oSection1:Cell("RA_CC"):Disable()
		oSection1:Cell("ATEMPOSERV" ):Disable()
		oSection1:Cell("MTEMPOSERV" ):Disable()
		//oSection1:Cell("CTT_DESC01" ):SetAutoSize() 

		//oMedATpServ:Disable()
		//oMedMTpServ:Disable()
		//oMedATpServM:Disable()
		//oMedMTpServM:Disable()
		//oMedATpServF:Disable()
		//oMedMTpServF:Disable()
	
Return(oReport)



Static Function R350Imp(oReport)

Local oSection  := oReport:Section(1)
Local cFiltro 	:= "" 
Local cSitQuery	:= ""
Local cCatQuery	:= ""  
Local cArqNtx	:= ""
Local cTitCC	:= "" 
Local cTitFil	:= ""
Local nReg		:= 0
Local nIndex	:= 0

Local nOrdem	:= oSection:GetOrder()
Local cArqNtx   := cIndCond := ""

Local cFilSrj
Local cFilCtt

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        //  Filial                                   ³
//³ mv_par02        //  Centro de Custo                          ³
//³ mv_par03        //  Matricula                                ³
//³ mv_par04        //  Nome                                     ³
//³ mv_par05        //  Funcao                                   ³
//³ mv_par06        //  Data de Nascimento                       ³
//³ mv_par07        //  Situacoes                                ³
//³ mv_par08        //  Categorias                               ³
//³ mv_par09        //  Centro de Custo em Outra Pagina          ³
//³ mv_par10        //  Salario Base / Composto                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cSituacao  	:= mv_par07
Private cCategoria 	:= mv_par08
Private lSalta     	:= If( mv_par09 == 1 , .T. , .F. )
Private nBase		:= mv_par10							//  Sobre Salario 1-Composto 2-Base

Private cAcessaSRA	:= &("{ || " + ChkRH("GPER350","SRA","2") + "}")
Private cAliasQry	:= ""
Private aRoteiro	:= {}
         
cTitulo := oReport:Title() + " "
If nOrdem==1
	cTitulo +=	OemToAnsi(STR0013)		//"(C.CUSTO + MATRICULA)"
ElseIf nOrdem==2
	cTitulo +=	OemToAnsi(STR0014)		//"(C.CUSTO + NOME)"
ElseIf nOrdem==3 
	cTitulo +=	OemToAnsi(STR0015)		//"(C.CUSTO + FUNCAO)"
EndIf		


//-- Altera o titulo do relatorio
oReport:SetTitle(cTitulo)

//-- Quebrar  e Totalizar por Centro de Custo
DEFINE BREAK oBreakCCusto OF oSection WHEN oSection:Cell("RA_CC") TITLE OemToAnsi(STR0039)	//"TOTAL CENTRO CUSTO "
	DEFINE FUNCTION oBcTotal NAME "BCTOTAL"	FROM oSection:Cell("RA_MAT")     FUNCTION COUNT   BREAK oBreakCCusto TITLE OemToAnsi(STR0026) 			NO END REPORT NO END SECTION         						//"TOTAL"
	DEFINE FUNCTION oBcMasc  NAME "BCMASC"	FROM oSection:Cell("RA_MAT")     FUNCTION COUNT   BREAK oBreakCCusto TITLE OemToAnsi(STR0027) 			NO END REPORT NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"TOTAL MASCUL."
	DEFINE FUNCTION oBcFem   NAME "BCFEM"	FROM oSection:Cell("RA_MAT")     FUNCTION COUNT   BREAK oBreakCCusto TITLE OemToAnsi(STR0028) 			NO END REPORT NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"TOTAL FEMIN."
	
	DEFINE FUNCTION FROM oSection:Cell("SALARIOMES" ) FUNCTION SUM     BREAK oBreakCCusto TITLE OemToAnsi(STR0029) PICTURE "@E 999,999,999,999.99" 	NO END REPORT NO END SECTION                           	//"TOTAL SALARIOS"
	DEFINE FUNCTION oMdMasc NAME "SALARIOMESM" FROM oSection:Cell("SALARIOMES") FUNCTION AVERAGE BREAK oBreakCCusto TITLE OemToAnsi(STR0030) PICTURE "@E 999,999,999,999.99" 	NO END REPORT NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"MEDIA SAL. MASC."
	DEFINE FUNCTION oMdFem  NAME "SALARIOMESF" FROM oSection:Cell("SALARIOMES") FUNCTION AVERAGE BREAK oBreakCCusto TITLE OemToAnsi(STR0031) PICTURE "@E 999,999,999,999.99" 	NO END REPORT NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"MEDIA SAL. FEM."

	DEFINE FUNCTION oBcMedATpServ  NAME "BCMEDATPSERV"  FROM oSection:Cell("ATEMPOSERV") FUNCTION SUM	  BREAK oBreakCCusto TITLE OemToAnsi(STR0032) OF oSection PICTURE "@E 99"	NO END SECTION NO END REPORT		//"MED. TEMPO SERV."	//Ano
	DEFINE FUNCTION oBcMedMTpServ  NAME "BCMEDMTPSERV"  FROM oSection:Cell("MTEMPOSERV") FUNCTION SUM	  BREAK oBreakCCusto TITLE OemToAnsi(STR0032) OF oSection PICTURE "@E 99"	NO END SECTION NO END REPORT		//"MED. TEMPO SERV."	//Mes
	DEFINE FUNCTION oBcMedTServ    NAME "BCMEDTSERV"    FROM oSection:Cell("TEMPOSERV")  FUNCTION ONPRINT BREAK oBreakCCusto TITLE OemToAnsi(STR0032) OF oSection 					NO END SECTION NO END REPORT	;	//"MED. TEMPO SERV."
		FORMULA {|lSection,lReport,lPage| CalcMedTS(lSection,lReport,lPage,oSection:GetFunction("BCMEDATPSERV"  ),oSection:GetFunction("BCMEDMTPSERV" ),oSection:GetFunction("BCTOTAL" )) } 
                                          
	DEFINE FUNCTION oBcMedATpServM NAME "BCMEDATPSERVM" FROM oSection:Cell("ATEMPOSERV") FUNCTION SUM	  BREAK oBreakCCusto TITLE OemToAnsi(STR0033) OF oSection PICTURE "@E 99"	NO END SECTION NO END REPORT WHEN {||SRA->RA_SEXO=="M"}	//"MED. TEMPO SERV.MASC."	//Ano
	DEFINE FUNCTION oBcMedMTpServM NAME "BCMEDMTPSERVM" FROM oSection:Cell("MTEMPOSERV") FUNCTION SUM	  BREAK oBreakCCusto TITLE OemToAnsi(STR0033) OF oSection PICTURE "@E 99"	NO END SECTION NO END REPORT WHEN {||SRA->RA_SEXO=="M"}	//"MED. TEMPO SERV.MASC."	//Mes
	DEFINE FUNCTION oBcMedTServM   NAME "BCMEDTSERVM"   FROM oSection:Cell("TEMPOSERV")  FUNCTION ONPRINT BREAK oBreakCCusto TITLE OemToAnsi(STR0033) OF oSection 			 		NO END SECTION NO END REPORT	;	//"MED. TEMPO SERV.MASC."
		FORMULA {|lSection,lReport,lPage| CalcMedTS(lSection,lReport,lPage,oSection:GetFunction("BCMEDATPSERVM"  ),oSection:GetFunction("BCMEDMTPSERVM" ),oSection:GetFunction("BCMASC" )) } 

	DEFINE FUNCTION oBcMedATpServF NAME "BCMEDATPSERVF" FROM oSection:Cell("ATEMPOSERV") FUNCTION SUM 	  BREAK oBreakCCusto TITLE OemToAnsi(STR0034) OF oSection PICTURE "@E 99"	NO END SECTION NO END REPORT WHEN {||SRA->RA_SEXO=="F"}	//"MED. TEMPO SERV.FEM."	//Ano
	DEFINE FUNCTION oBcMedMTpServF NAME "BCMEDMTPSERVF" FROM oSection:Cell("MTEMPOSERV") FUNCTION SUM 	  BREAK oBreakCCusto TITLE OemToAnsi(STR0034) OF oSection PICTURE "@E 99"	NO END SECTION NO END REPORT WHEN {||SRA->RA_SEXO=="F"}	//"MED. TEMPO SERV.FEM."	//Mes
	DEFINE FUNCTION oBcMedTServF   NAME "BCMEDTSERVF"   FROM oSection:Cell("TEMPOSERV")  FUNCTION ONPRINT BREAK oBreakCCusto TITLE OemToAnsi(STR0034) OF oSection 	 	 			NO END SECTION NO END REPORT	;	//"MED. TEMPO SERV.FEM."
		FORMULA {|lSection,lReport,lPage| CalcMedTS(lSection,lReport,lPage,oSection:GetFunction("BCMEDATPSERVF"  ),oSection:GetFunction("BCMEDMTPSERVF" ),oSection:GetFunction("BCFEM" )) } 

	DEFINE FUNCTION FROM oSection:Cell("IDADE")      FUNCTION AVERAGE BREAK oBreakCCusto TITLE OemToAnsi(STR0035) 									NO END REPORT NO END SECTION 							//"MEDIA IDADES TOTAL"
	DEFINE FUNCTION FROM oSection:Cell("IDADE")      FUNCTION AVERAGE BREAK oBreakCCusto TITLE OemToAnsi(STR0036) 									NO END REPORT NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"MEDIA IDADES MASC."
	DEFINE FUNCTION FROM oSection:Cell("IDADE")      FUNCTION AVERAGE BREAK oBreakCCusto TITLE OemToAnsi(STR0037) 									NO END REPORT NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"MEDIA IDADES FEM."

	oBreakCCusto:OnBreak({|x,y|cTitCC:=OemToAnsi(STR0039)+x,oReport:ThinLine()})
    oBreakCCusto:SetTotalText({||cTitCC})
	
//-- Quebrar e Totalizar por Filial
DEFINE BREAK oBreakFil OF oSection WHEN oSection:Cell("RA_FILIAL") TITLE OemToAnsi(STR0038)	PAGE BREAK		// "TOTAL FILIAL "
	DEFINE FUNCTION oBfTotal NAME "BFTOTAL"	FROM oSection:Cell("RA_MAT")     FUNCTION COUNT   BREAK oBreakFil TITLE OemToAnsi(STR0026) 			/*NO END REPORT*/ NO END SECTION        					//"TOTAL"
	DEFINE FUNCTION oBfMasc  NAME "BFMASC"	FROM oSection:Cell("RA_MAT")     FUNCTION COUNT   BREAK oBreakFil TITLE OemToAnsi(STR0027) 			/*NO END REPORT*/ NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"TOTAL MASCUL."
	DEFINE FUNCTION oBfFem   NAME "BFFEM"	FROM oSection:Cell("RA_MAT")     FUNCTION COUNT   BREAK oBreakFil TITLE OemToAnsi(STR0028) 			/*NO END REPORT*/ NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"TOTAL FEMIN."
	DEFINE FUNCTION FROM oSection:Cell("SALARIOMES") FUNCTION SUM     BREAK oBreakFil TITLE OemToAnsi(STR0029) PICTURE "@E 999,999,999,999.99" 	/*NO END REPORT*/ NO END SECTION                            //"TOTAL SALARIOS"

	DEFINE FUNCTION oMdMasc NAME "SALARIOMESM" FROM oSection:Cell("SALARIOMES") FUNCTION AVERAGE BREAK oBreakFil TITLE OemToAnsi(STR0030) PICTURE "@E 999,999,999,999.99" 	NO END REPORT NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"MEDIA SAL. MASC."
	DEFINE FUNCTION oMdFem  NAME "SALARIOMESF" FROM oSection:Cell("SALARIOMES") FUNCTION AVERAGE BREAK oBreakFil TITLE OemToAnsi(STR0031) PICTURE "@E 999,999,999,999.99" 	NO END REPORT NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"MEDIA SAL. FEM."

	DEFINE FUNCTION oBfMedATpServ  NAME "BFMEDATPSERV"   FROM oSection:Cell("ATEMPOSERV") FUNCTION SUM	  BREAK oBreakFil  TITLE OemToAnsi(STR0032) OF oSection PICTURE "@E 99"		//NO END SECTION //NO END REPORT				//"MED. TEMPO SERV."	//Ano
	DEFINE FUNCTION oBfMedMTpServ  NAME "BFMEDMTPSERV"   FROM oSection:Cell("MTEMPOSERV") FUNCTION SUM	  BREAK oBreakFil  TITLE OemToAnsi(STR0032) OF oSection PICTURE "@E 99"		//NO END SECTION //NO END REPORT				//"MED. TEMPO SERV."	//Mes
	DEFINE FUNCTION oBfMedTServ    NAME "BFMEDTSERV"     FROM oSection:Cell("TEMPOSERV")  FUNCTION ONPRINT BREAK oBreakFil TITLE OemToAnsi(STR0032) OF oSection NO END SECTION	;	//NO END REPORT	//"MED. TEMPO SERV."
		FORMULA {|lSection,lReport,lPage| CalcMedTS(lSection,lReport,lPage,oSection:GetFunction("BFMEDATPSERV"  ),oSection:GetFunction("BFMEDMTPSERV" ),oSection:GetFunction("BFTOTAL" )) } 
	
	DEFINE FUNCTION oBfMedATpServM NAME "BFMEDATPSERVM"  FROM oSection:Cell("ATEMPOSERV") 	FUNCTION SUM    BREAK oBreakFil  TITLE OemToAnsi(STR0033) OF oSection PICTURE "@E 99"	/*NO END SECTION NO END REPORT*/ WHEN {||SRA->RA_SEXO=="M"}				//"MED. TEMPO SERV.MASC."	//Ano
	DEFINE FUNCTION oBfMedMTpServM NAME "BFMEDMTPSERVM"  FROM oSection:Cell("MTEMPOSERV") 	FUNCTION SUM    BREAK oBreakFil  TITLE OemToAnsi(STR0033) OF oSection PICTURE "@E 99"	/*NO END SECTION NO END REPORT*/ WHEN {||SRA->RA_SEXO=="M"}				//"MED. TEMPO SERV.MASC."	//Mes
	DEFINE FUNCTION oBfMedTServM   NAME "BFMEDTSERVM"    FROM oSection:Cell("TEMPOSERV")	FUNCTION ONPRINT BREAK oBreakFil TITLE OemToAnsi(STR0033) OF oSection  NO END SECTION	;	//NO END REPORT	//"MED. TEMPO SERV.MASC."
		FORMULA {|lSection,lReport,lPage| CalcMedTS(lSection,lReport,lPage,oSection:GetFunction("BFMEDATPSERVM"  ),oSection:GetFunction("BFMEDMTPSERVM" ),oSection:GetFunction("BFMASC")) }

	DEFINE FUNCTION oBfMedATpServF NAME "BFMEDATPSERVF"  FROM oSection:Cell("ATEMPOSERV") 	FUNCTION SUM	BREAK oBreakFil  TITLE OemToAnsi(STR0034) OF oSection PICTURE "@E 99"	/*NO END SECTION NO END REPORT*/ WHEN {||SRA->RA_SEXO=="F"}				//"MED. TEMPO SERV.FEM."	//Ano
	DEFINE FUNCTION oBfMedMTpServF NAME "BFMEDMTPSERVF"  FROM oSection:Cell("MTEMPOSERV") 	FUNCTION SUM	BREAK oBreakFil  TITLE OemToAnsi(STR0034) OF oSection PICTURE "@E 99"	/*NO END SECTION NO END REPORT*/ WHEN {||SRA->RA_SEXO=="F"}				//"MED. TEMPO SERV.FEM."	//Mes
	DEFINE FUNCTION oBfMedTServF   NAME "BFMEDTSERVF"    FROM oSection:Cell("TEMPOSERV")	FUNCTION ONPRINT BREAK oBreakFil TITLE OemToAnsi(STR0034) OF oSection NO END SECTION	; 	//NO END REPORT	//"MED. TEMPO SERV.FEM."
		FORMULA {|lSection,lReport,lPage| CalcMedTS(lSection,lReport,lPage,oSection:GetFunction("BFMEDATPSERVF"  ),oSection:GetFunction("BFMEDMTPSERVF" ),oSection:GetFunction("BFFEM" ))}

	DEFINE FUNCTION FROM oSection:Cell("IDADE")      FUNCTION AVERAGE BREAK oBreakFil TITLE OemToAnsi(STR0035)	/*NO END REPORT*/ NO END SECTION 							//"MEDIA IDADES TOTAL"
	DEFINE FUNCTION FROM oSection:Cell("IDADE")      FUNCTION AVERAGE BREAK oBreakFil TITLE OemToAnsi(STR0036)	/*NO END REPORT*/ NO END SECTION WHEN {||SRA->RA_SEXO=="M"}	//"MEDIA IDADES MASC."
	DEFINE FUNCTION FROM oSection:Cell("IDADE")      FUNCTION AVERAGE BREAK oBreakFil TITLE OemToAnsi(STR0037)	/*NO END REPORT*/ NO END SECTION WHEN {||SRA->RA_SEXO=="F"}	//"MEDIA IDADES FEM."
	                                                    
	oBreakFil:OnBreak({|x,y|cTitFil:=OemToAnsi(STR0038)+x,oReport:ThinLine()})
    oBreakFil:SetTotalText({||cTitFil})
If lSalta  
	oBreakCCusto:SetPageBreak()
EndIf

oReport:SetLandscape()
oReport:SetTotalInLine(.T.)
oBreakFil:SetTotalInLine(.T.)
oBreakCCusto:SetTotalInLine(.T.)
oSection:SetHeaderBreak(.T.)

//-- Condicao de impressao do Funcionario
oSection:SetLineCondition({|| U_fGP350Cond(cAliasQry) }) 

cAliasQry := GetNextAlias()

//-- Modifica variaveis para a Query 
cSitQuery := ""
lDemitido := .F.
lTransf := .F.
For nReg:=1 to Len(cSituacao)
	If "D" $ cSituacao .and. !("T" $ cSituacao)
		lDemitido := .T.
	ElseIf !("D" $ cSituacao) .and. "T" $ cSituacao
		lTransf := .T.
	 	cSituacao:=SubStr(cSituacao,1,2)+"D"+SubStr(cSituacao,4,2)
	EndIf
	cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
	If ( nReg+1 ) <= Len(cSituacao)
		cSitQuery += "," 
	Endif
Next nReg        
cSitQuery := "%" + cSitQuery + "%"

cCatQuery := ""
For nReg:=1 to Len(cCategoria)
	cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
	If ( nReg+1 ) <= Len(cCategoria)
		cCatQuery += "," 
	Endif
Next nReg        
cCatQuery := "%" + cCatQuery + "%"

//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
MakeSqlExpr(cPerg)
	
BEGIN REPORT QUERY oSection

If nOrdem == 1
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
ElseIf nOrdem == 2
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_NOME%"
ElseIf nOrdem == 3
	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_CODFUNC%"
Endif
	

cFilSrj := If ( SRJ->(xFilial()) == Space(FWGETTAMFILIAL) , "%AND SRJ.RJ_FILIAL  = '"+Space(FWGETTAMFILIAL) +"'%","%AND " +  FWJoinFilial("SRA", "SRJ") +"%")
cFilCtt := If ( CTT->(xFilial()) == Space(FWGETTAMFILIAL) , "%AND CTT.CTT_FILIAL = '"+Space(FWGETTAMFILIAL) +"'%","%AND " +  FWJoinFilial("SRA", "CTT") +"%")


cFilDemi:= If(lDemitido,"%( ( SRA.RA_SITFOLH = 'D' AND SRA.RA_RESCRAI <> '30' AND SRA.RA_RESCRAI <> '31' ) OR ( SRA.RA_SITFOLH <> 'D' ) )%","%SRA.RA_SITFOLH <> 'Y'%")
cFilTran:=  If(lTransf,"%( ( SRA.RA_SITFOLH = 'D' AND ( SRA.RA_RESCRAI = '30' OR SRA.RA_RESCRAI = '31' ) ) OR ( SRA.RA_SITFOLH <> 'D' ) )%","%SRA.RA_SITFOLH <> 'Y'%")

BeginSql alias cAliasQry                                            
	SELECT	SRA.RA_FILIAL,  SRA.RA_CC,      SRA.RA_MAT,  SRA.RA_NOME,    SRA.RA_SITFOLH, SRA.RA_CATFUNC, 
			SRA.RA_ADMISSA, SRJ.RJ_FUNCAO,  SRJ.RJ_DESC, SRA.RA_CODFUNC, SRA.RA_SALARIO, SRA.RA_DEMISSA,
			CTT.CTT_CUSTO,  CTT.CTT_DESC01, SRA.RA_NASC, SRA.RA_DEMISSA, SRA.RA_TIPOPGT, SRA.RA_PROCES
	FROM %table:SRA% SRA
	LEFT JOIN %table:SRJ% SRJ
		ON	SRA.RA_CODFUNC	= 	SRJ.RJ_FUNCAO
		%exp:cFilSrj% AND 
	    	SRJ.%notDel%   
	LEFT JOIN %table:CTT% CTT
		ON	SRA.RA_CC		=	CTT.CTT_CUSTO                                   
		%exp:cFilCtt%			
	WHERE SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
		  SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
 	      %exp:cFilDemi%   AND
  		  %exp:cFilTran% 	AND
		  CTT.%notDel%		AND
 	      SRA.%notDel%   
	ORDER BY %exp:cOrdem%
EndSql

/*
Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
pela funcao MakeSqlExpr para serem adicionados a query
*/
END REPORT QUERY oSection PARAM mv_par01, mv_par02, mv_par03, mv_par04, mv_par05, mv_par06


//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter( 100 )  

oSection:Print()	 //Imprimir

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA" )
Set Filter to
If nOrdem == 3
	RetIndex( "SRA" )
Endif
dbSetOrder(1)
If nOrdem == 3
	fErase( cArqNtx + OrdBagExt() )
Endif	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fBuscaTempoServ³ Autor ³ Tania Bronzeri   ³ Data ³21/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula Tempo de Servico do Funcionario                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Relatorio Classificacao por Cargos                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fBuscaTempoServ(cEscopo)
Local AASER := MMSER := 00 
Local dDtBas:= ctod("  /  /  ")
Local uRet

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se o Funcionario Estiver Demitido Usar Data de Demissao      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (cAliasQry)->RA_SITFOLH == "D"
	dDtBas := (cAliasQry)->RA_DEMISSA
Else
	dDtBas := dDataBase
Endif

AASER := Year(dDtBas) - Year((cAliasQry)->RA_ADMISSA)
If Month((CAliasQry)->RA_ADMISSA) > Month(dDtBas)
	AASER := (AASER - 1)
	MMSER := (12 - Month((cAliasQry)->RA_ADMISSA)) + Month(dDtbas)
Else
	MMSER := (Month(dDtBas) - Month((cAliasQry)->RA_ADMISSA))
Endif
If MMSER == 12
	MMSER := 0
	AASER := (AASER + 1)
Endif 
If cEscopo == "T"
	uRet	:=	(STRZERO(AASER,2)+"/"+STRZERO(MMSER,2))
ElseIf cEscopo == "A"
	uRet	:=	Iif(!Empty(AASER),AASER,0)
Else
	uRet	:=	Iif(!Empty(MMSER),MMSER,0)
EndIf

Return uRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fBuscaSalario  ³ Autor ³ Tania Bronzeri   ³ Data ³21/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Busca Salario Mes ou Salario Dia do Funcionario            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Relatorio Classificacao por Cargos                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fBuscaSalario(cTipo)
Local aArea 	:= GetArea()
Local nSalario  := nSalMes := nSalDia := nSalHora := 0
Local nRetorno	:= 0
Local aPerAtual := {}
Local cPerAt    := ""

//===>>> Posiciona SRA para chamada das funcoes do GPEXCAL1
dbSelectArea("SRA")
dbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT)

fGetPerAtual( @aPerAtual, xFilial("RCH"), (cAliasQry)->RA_PROCES, fGetRotOrdinar() ) //Obtem ano e mes do periodo atual         
If !Empty(aPerAtual)
	cPerAt := aPerAtual[1,5]+aPerAtual[1,4] //RCH_ANO + RCH-MES
EndIf

// Sobre qual salario
If nBase == 1				// 1 - Base
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula Salario Incoeporado Mes , Dia , Hora do Funcionario  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	/*
		FOI NECESSÁRIO INCLUIR A BUSCA DO MNEMONICO AQUI, DEVIDO A CHAMADA DENTRO DO 
		FSALARIO DA VARIÁVEL P_NTOTDIAS
	*/
	SetMnemonicos((cAliasQry)->RA_FILIAL, NIL, .T., "P_NTOTDIAS", .T.)
	fSalario(@nSalario,@nSalHora,@nSalDia,@nSalmes,"A",cPerAt)
	nSalMes := nSalario			
	If (cAliasQry)->RA_TIPOPGT = "S" .And. SRA->RA_CATFUNC $ "S*T"
		nSalDia := Round(nSalario/7,2)
	Else
		nSalDia := Round(nSalario/30,3)
	EndIf
ElseIf nBase == 2   // 2 - Composto  
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula Salario Incoeporado Mes , Dia , Hora do Funcionario  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fSalInc(@nSalario,@nSalmes,@nSalHora,@nSalDia,.T.)
EndIf
 

nRetorno := IIF(cTipo=="M",nSalMes,nSalDia)
           
RestArea( aArea )
                                          
Return (nRetorno)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fGP350Cond    ³ Autor ³ Tania Bronzeri   ³ Data ³21/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica Condicao para Impressao da Linha do Relatorio     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ A partir do Release 4                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fGP350Cond(cAliasQry)
      
Local lRet	:= .T.            
Default cAliasQry	:= "SRA"                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Consiste controle de acessos e filiais validas               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !((cAliasQry)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
	lRet	:= .F.			 	
EndIF

Return lRet


/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CalcMedTS³ Autor ³ Tania Bronzeri        ³ Data ³14/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula Media de tempo de servico (Anos / Meses)           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CalcMedia(nXAno,nXMes,nXFunc)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Release 4 em diante                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CalcMedTS(lSection,lReport,lPage,nXAno,nXMes,nXFunc)
 
Local nMeses	:= 0
Local nAuxa 	:= nAuxb 	:= nAuxc := 0
Local nMedAno 	:= nMedMes 	:= 0

If lSection
	nXAno := nXAno:SectionValue()
	nXMes := nXMes:SectionValue()
	nXFunc := nXFunc:SectionValue()

ElseIf lReport
	nXAno := nXAno:ReportValue()
	nXMes := nXMes:ReportValue()
	nXFunc := nXFunc:ReportValue()

ElseIf lPage
	nXAno := nXAno:PageValue()
	nXMes := nXMes:PageValue()
	nXFunc := nXFunc:PageValue()

Else
	nXAno := nXAno:GetValue()
	nXMes := nXMes:GetValue()
	nXFunc := nXFunc:GetValue()
EndIf

nMeses := ( ((nXAno * 12) + nXMes) / nXFunc )
If nMeses >= 12
	nAuxa	:= nMeses / 12
	nAuxb	:= Int(nAuxa) * 12
	nAuxc := nMeses - nAuxb  
	
	nMedAno 	:= Int(nAuxa)
	nMedMes	:= nAuxc
Else
	nMedAno 	:= 0
	nMedMes	:= nMeses
EndIf         

If nMedMes >= 11.5 // Evitar que resulte 12 meses nas medias finais.
	nMedMes := 0
	nMedAno += 1
EndIf 

Return(StrZero(nMedAno,2)+"/"+StrZero(nMedMes,2))


