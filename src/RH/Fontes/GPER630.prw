/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER630.CH"
#INCLUDE "REPORT.CH"
/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ GPER630	³ Autor ³ Marinaldo de Jesus	³ Data ³27/07/2000³			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Valores de Rescisoes                          			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_GPER630(void)							 				    		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³											   				  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso  	 ³ Generico 								  				  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 		ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.		     	  		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³          ³      ³                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ FNC  ³ Motivo da Alteracao								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Carlos E. O.³18/07/2013³ M12RH01 197402 ³ Inclusao do relatorio na P12.            ³±±
±±³            ³          ³                ³ Retirada funcao de ajuste do dicionario  ³±±
±±³            ³          ³                ³ AjustaSX1().                             ³±±
±±³            ³          ³                ³ Retirados todos tratamentos para forma-  ³±±
±±³            ³          ³                ³ to R3.                                   ³±±
±±³            ³          ³                ³ Substituicao no codigo onde estava       ³±±
±±³            ³          ³                ³ tabela SI3 por CTT e os respectivos      ³±±
±±³            ³          ³                ³ campos.                                  ³±±
±±³            ³          ³                ³ Retiradas do codigo as linhas para       ³±±
±±³            ³          ³                ³ quando nao era conexao via Top com banco.³±±
±±³Sidney O.   ³22/04/14  |M_RH003   295105|Replica / compatibilizacao de fonte para  ³±±
±±³            ³          |                |  a versao 12.                            ³±±
±±³Renan Borges³30/06/2014³			 TPYGWU³Ajuste para imprimir corretamente o rela- ³±±
±±³			   ³		  ³				   ³tório quando ordenado por c. de custo.    ³±±
±±³Cícero Alves³11/12/2015³			 TTXUCY³Alterada query para não trazer registros  ³±±
±±³			   ³		  ³				   ³deletados da CTT e da SRV				  ³±±
±±³Raquel Hager³08/04/2016³			 TUXKZE³Alterada query para não trazer registros  ³±±
±±³			    ³		  ³				   ³deletados da SR6.						  ³±±
±±³Jônatas A.T.³25/11/16  |MRH-2397  191591|Alterada máscara dos campos de valores p/ ³±±
±±³            ³          |                |contemplar valores maiores.               ³±±
±±ºOswaldo    ³03/01/2017³MRH-4340        ³Substituimos as chamadas da função         º±±
±±ºLeite      ³          ³                ³“fGetJOINGestaoEmpresa”                    º±±
±±º           ³          ³                ³por “fGetJOINGestEmp”                      º±±
±±³Gabriel A.  ³20/02/17  |MRH-7098        |Alteração na busca dos turnos quando o    ³±±
±±³            ³          |                |cadastro for exclusivo por filial.        ³±±
±±³M.Camargo   ³12/02/19  |DMINA-6070      |Réplica dmina-4512 Localización Colombia  ³±±
±±³            ³          |                |                                          ³±±
±±³Alf. Medrano³05/04/20  |DMINA-8744      |en fun PrintReport se valida la pregunta  ³±±
±±³            ³          |                |MV_PAR15, se asigna orden a query y se    ³±±
±±³            ³          |                |agrega query para obtener registros de SRC³±±
±±³            ³          |                |y SRD MEX                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER630()
	Local oReport

	Private cAliasMov	:= "SRA"
	Private cTurnoAnt	:= ""
	Private cCCAnt		:= ""
	Private cFilaInfo	:= ""
	Private cAliasSRV	:= "SRV"

	If FindFunction("fConfigSV") .And. fConfigSV() .And. MsgYesNo(OemToAnsi(STR0065), OemToAnsi(STR0063)) //"Deseja imprimir Relatório de Valores de Rescisões pelo Smart View?" ### "Atenção"
		GPERSV630()
		Return
	EndIf 

	//-- Interface de impressao
	Pergunte("GPER630",.F.)
	oReport:= ReportDef()
	oReport:SetLandScape()
	oReport:PrintDialog()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ R.H. - Tatiane Matias ³ Data ³ 13.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do relatorio                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

	//-- Objeto Relatorio
	Local oReport

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

	//-- Descricao do Relatorio
	Local	cDesc		:=	STR0006 + " "+STR0007  //"Emiss„o de Valores de F‚rias."#"Dever  ser emitido ap¢s o Calculo de Rescisoes."#"Ser  impresso de acordo com os parametros solicitados pelo usu rio."

	//-- Ordens utilizadas pelo relatorio
	If cPaisLoc == "COL"
	 	aOrd     :={	STR0001,;	//"Matricula"
						STR0002 }	//"Centro de Custo"
	Else
	 	aOrd     :={	STR0001,; 	//"Matricula"
						STR0002,;	//"Centro de Custo"
						STR0003,;	//"Nome"
						STR0004,;	//"Centro de Custo + Nome"
						STR0005 }	//"Turno"
	EndIf

	//-- Inicio definicao do Relatorio
	DEFINE REPORT oReport NAME "GPER630" TITLE STR0011 PARAMETER "GPER630" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc TOTAL IN COLUMN

		//-- Section de Filial
	DEFINE SECTION oSection1 OF oReport TABLES "SRA" TITLE STR0012 ORDERS aOrd  TOTAL IN COLUMN
	oSection1:SetHeaderBreak(.T.)

	If cPaisLoc == "COL"
		DEFINE CELL NAME "RA_FILIAL"	OF oSection1 ALIAS "SRA" //"Surcursal"
		DEFINE CELL NAME "DESCRICAO"	OF oSection1 TITLE STR0060 BLOCK {|| AllTrim( aInfo[3] )} SIZE 30 //"Descripcion"
		DEFINE CELL NAME "NIT"			OF oSection1 TITLE STR0061 BLOCK {|| AllTrim( aInfo[8] )} SIZE 15 //"NIT"
	Else
		DEFINE CELL NAME "RA_FILIAL"	OF oSection1 ALIAS "SRA"
		DEFINE CELL NAME "DESCRICAO"	OF oSection1 					BLOCK {|| AllTrim( aInfo[2] )} SIZE 30
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Utilizada essa section para as ordens 1=Matricula e 3=Nome   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//-- Section de Funcionario
	DEFINE SECTION oSection2 OF oSection1 TABLES "SRA" TITLE STR0031 +STR0001+"/"+STR0003 TOTAL IN COLUMN //oRDEM DE MATRICULA/NOME
	oSection2:SetHeaderBreak(.T.)
	oSection2:SetLineBreak(.t.)
	If cPaisLoc == "COL"
		DEFINE CELL NAME "RA_MAT"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_NOMECMP"	OF oSection2 ALIAS "SRA" SIZE 40
		DEFINE CELL NAME "RA_TPCIC"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_CIC"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_CC"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "CCDESCRIP"	OF oSection2 TITLE STR0062  BLOCK {|| POSICIONE( "CTT", 1, XFILIAL("CTT") + (cAliasMov)->RA_CC   , "CTT_DESC01" ) } SIZE 15
		DEFINE CELL NAME "RA_DEPTO"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "DEPTODESC"	OF oSection2 TITLE STR0062  BLOCK {|| POSICIONE( "SQB", 1, XFILIAL("SQB") + (cAliasMov)->RA_DEPTO, "QB_DESCRIC" ) } SIZE 15

		oSection2:Cell("DEPTODESC"):SetCellBreak()

		DEFINE CELL NAME "RA_CARGO"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "CARGODESC"	OF oSection2 TITLE STR0062  BLOCK {|| POSICIONE( "SQ3", 1, XFILIAL("SQ3") + (cAliasMov)->RA_CARGO  , "Q3_DESCSUM" ) } SIZE 15
		DEFINE CELL NAME "RA_CODFUNC"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "CODFUNDESC"	OF oSection2 TITLE STR0062  BLOCK {|| POSICIONE( "SRJ", 1, XFILIAL("SRJ") + (cAliasMov)->RA_CODFUNC, "RJ_DESC"    ) } SIZE 15
		DEFINE CELL NAME "RA_PROCES"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "PROCESDES"	OF oSection2 TITLE STR0062  BLOCK {|| POSICIONE( "RCJ", 1, XFILIAL("RCJ") + (cAliasMov)->RA_PROCES , "RCJ_DESCRI" ) } SIZE 15
		DEFINE CELL NAME "RA_CODRPAT"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "CODRPATDES"	OF oSection2 TITLE STR0062  BLOCK {|| fDescRCC("S008",(cAliasMov)->RA_CODRPAT,1,17,18,80) } SIZE 15

		oSection2:Cell("CODRPATDES"):SetCellBreak()

		DEFINE CELL NAME "RA_CODAFP"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "CODAFPDES"	OF oSection2 TITLE STR0062  BLOCK {|| fDescRCC("S008",(cAliasMov)->RA_CODAFP,1,17,18,80)  } SIZE 15
		DEFINE CELL NAME "RA_NITARL"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "NITARLDES"	OF oSection2 TITLE STR0062  BLOCK {|| fDescRCC("S008",(cAliasMov)->RA_NITARL,1,17,18,80) } SIZE 15
		DEFINE CELL NAME "RA_CXCOMP"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "CXCOMPDES"	OF oSection2 TITLE STR0062  BLOCK {|| fDescRCC("S008",(cAliasMov)->RA_CXCOMP,1,17,18,80) } SIZE 15
		DEFINE CELL NAME "RA_OFICIO"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "OFICIODES"	OF oSection2 TITLE STR0062  BLOCK {|| fDescRCC("S017",(cAliasMov)->RA_OFICIO,1,6,7,40)   } SIZE 15

		oSection2:Cell("OFICIODES"):SetCellBreak()

		DEFINE CELL NAME "RA_HRSMES"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_TIPOPRC"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_PERCIR"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_SALARIO"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_ADMISSA"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_DTREC"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_TIPOCO"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_DEMISSA"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_TIPFIN "	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "FINCIODES"	OF oSection2 TITLE STR0062  BLOCK {|| fDescRCC("S020",(cAliasMov)->RA_TIPFIN,1,2,3,80)   } SIZE 45

	Else
		DEFINE CELL NAME "RA_CC"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_TNOTRAB"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_MAT"		OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_NOME"		OF oSection2 ALIAS "SRA"

		DEFINE CELL NAME "RA_DEPIR"	OF oSection2 ALIAS "SRA"
		DEFINE CELL NAME "RA_DEPSF"	OF oSection2 ALIAS "SRA"
	EndIF

	//-- Section de Cabecalho da Rescisao (SRG)
	DEFINE SECTION oSection3 OF oSection2 TABLES "SRG" TITLE STR0055 TOTAL IN COLUMN
	oSection3:SetHeaderBreak(.T.)

	DEFINE CELL NAME "RG_DATADEM" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_DATAHOM" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_DTAVISO" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_DTGERAR" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_DAVISO" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_TIPORES" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_DESCTPR" 	OF oSection3 BLOCK {|| fDescRCC("S043",(cAliasSRG)->RG_TIPORES,1,2,3,30) } SIZE 20
	DEFINE CELL NAME "RG_MEDATU" 	OF oSection3 BLOCK {|| IF( (cAliasSRG)->RG_MEDATU == "S", STR0022 , STR0023 )}
	DEFINE CELL NAME "RG_DFERVEN" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_DFERPRO" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALMES" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALDIA" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALHORA" 	OF oSection3 ALIAS "SRG"
	DEFINE CELL NAME "RG_EFETIVA" 	OF oSection3 ALIAS "SRG"

	//-- Section de Valores da Rescisao (SRR)
	If cPaisLoc <> "BRA" .and. cPaisLoc <> "BOL"
		DEFINE SECTION oSection4 OF oSection3 TABLES "SRC", "SRV" TITLE STR0011 TOTAL IN COLUMN
	Else
		DEFINE SECTION oSection4 OF oSection3 TABLES "SRR", "SRV" TITLE STR0011 TOTAL IN COLUMN
	EndIf
	oSection4:SetHeaderBreak(.T.)
	If cPaisLoc <> "BRA" .and. cPaisLoc <> "BOL"
		DEFINE CELL NAME "RC_PD" 		OF oSection4 ALIAS "SRC"
		DEFINE CELL NAME "RV_DESC" 		OF oSection4 ALIAS "SRV"	//BLOCK {|| DescPd((cAliasSRR)->RR_PD)}
		DEFINE CELL NAME "RC_HORAS" 	OF oSection4 ALIAS "SRC"   BLOCK {|| If((cAliasSRC)->RC_TIPO1 == "V" .And. (cAliasSRC)->RC_HORAS > 0, fConvHoras((cAliasSRC)->RC_HORAS,"1"), (cAliasSRC)->RC_HORAS)} PICTURE "@E 9999.99"
		DEFINE CELL NAME "PROVENTOS" 	OF oSection4 TITLE STR0056 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "1",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15
		DEFINE CELL NAME "DESCONTOS" 	OF oSection4 TITLE STR0057 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "2",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15
		DEFINE CELL NAME "BASES" 		OF oSection4 TITLE STR0058 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD $ "3/4",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15
	Else
		DEFINE CELL NAME "RR_PD" 		OF oSection4 ALIAS "SRR"
		DEFINE CELL NAME "RV_DESC" 		OF oSection4 ALIAS "SRV"	//BLOCK {|| DescPd((cAliasSRR)->RR_PD)}
		DEFINE CELL NAME "RR_HORAS" 	OF oSection4 ALIAS "SRR"   BLOCK {|| If(lHoraSexag .And. (cAliasSRR)->RR_TIPO1 == "H" .And. (cAliasSRR)->RR_HORAS > 0, fConvHoras((cAliasSRR)->RR_HORAS,"1"), (cAliasSRR)->RR_HORAS)} PICTURE "@E 9999.99"
		DEFINE CELL NAME "PROVENTOS" 	OF oSection4 TITLE STR0056 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT
		DEFINE CELL NAME "DESCONTOS" 	OF oSection4 TITLE STR0057 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT
		DEFINE CELL NAME "BASES" 		OF oSection4 TITLE STR0058 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD $ "3/4",(cAliasSRR)->RR_VALOR,0) } PICTURE "@E 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT
	EndIf
	//-- Posiciona a tabela de verbas
	If cPaisLoc <> "BRA" .and. cPaisLoc <> "BOL"
		TRPosition():New(oSection4,"SRV",1,{|| RhFilial("SRV", (cAliasMov)->RA_FILIAL)+(cAliasSRC)->RC_PD})
	Else
		TRPosition():New(oSection4,"SRV",1,{|| RhFilial("SRV", (cAliasMov)->RA_FILIAL)+(cAliasSRR)->RR_PD})
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Utilizada essa section para as ordens 2=Centro de Custo e 4=Centro de Custo + Nome³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//-- Section de Centro de Custo
  	DEFINE SECTION oSection5 OF oSection1 TABLES "SRA", "CTT" TITLE STR0031 +STR0002+"/"+STR0004 TOTAL IN COLUMN
	oSection5:SetHeaderBreak(.T.)

	DEFINE CELL NAME "RA_CC"	OF oSection5 ALIAS "SRA"
	DEFINE CELL NAME "CTT_DESC01"	OF oSection5 ALIAS "CTT"

	//-- Posiciona a tabela de centro de custo
	TRPosition():New(oSection5,"CTT",1,{|| RhFilial("CTT", (cAliasMov)->RA_FILIAL)+(cAliasMov)->RA_CC})

	//-- Section de Funcionario
	DEFINE SECTION oSection6 OF oSection5 TABLES "SRA" TITLE STR0054 TOTAL IN COLUMN
	oSection6:SetHeaderBreak(.T.)

	DEFINE CELL NAME "RA_CC"		OF oSection6 ALIAS "SRA"
	DEFINE CELL NAME "RA_TNOTRAB"	OF oSection6 ALIAS "SRA"
	DEFINE CELL NAME "RA_MAT"		OF oSection6 ALIAS "SRA"
	DEFINE CELL NAME "RA_NOME"		OF oSection6 ALIAS "SRA"
	DEFINE CELL NAME "RA_DEPIR"		OF oSection6 ALIAS "SRA"
	DEFINE CELL NAME "RA_DEPSF"		OF oSection6 ALIAS "SRA"

	//-- Section de Cabecalho da Rescisao (SRG)
	DEFINE SECTION oSection7 OF oSection6 TABLES "SRG" TITLE STR0055 TOTAL IN COLUMN
	oSection7:SetHeaderBreak(.T.)

	DEFINE CELL NAME "RG_DATADEM" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_DATAHOM" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_DTAVISO" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_DTGERAR" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_DAVISO" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_TIPORES" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_DESCTPR" 	OF oSection7 					BLOCK {|| fDescRCC("S043",(cAliasSRG)->RG_TIPORES,1,2,3,30) } SIZE 20
	DEFINE CELL NAME "RG_MEDATU" 	OF oSection7 					BLOCK {|| IF( (cAliasSRG)->RG_MEDATU == "S", STR0022 , STR0023 )}
	DEFINE CELL NAME "RG_DFERVEN" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_DFERPRO" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALMES" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALDIA" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALHORA" 	OF oSection7 ALIAS "SRG"
	DEFINE CELL NAME "RG_EFETIVA" 	OF oSection7 ALIAS "SRG"

	//-- Section de Valores da Rescisao (SRR)
	If cPaisLoc == "BRA" .or. cPaisLoc == "BOL"
		DEFINE SECTION oSection8 OF oSection7 TABLES "SRR", "SRV" TITLE STR0011 TOTAL IN COLUMN
		oSection8:SetHeaderBreak(.T.)

		DEFINE CELL NAME "RR_PD" 		OF oSection8 ALIAS "SRR"
		DEFINE CELL NAME "RV_DESC"   	OF oSection8 ALIAS "SRV"	//BLOCK {|| DescPd((cAliasSRR)->RR_PD)}
		DEFINE CELL NAME "RR_HORAS" 	OF oSection8 ALIAS "SRR"   BLOCK {|| If(lHoraSexag .And. (cAliasSRR)->RR_TIPO1 == "H" .And. (cAliasSRR)->RR_HORAS > 0, fConvHoras((cAliasSRR)->RR_HORAS,"1"), (cAliasSRR)->RR_HORAS)} PICTURE "@E 9999.99"
		DEFINE CELL NAME "PROVENTOS" 	OF oSection8 TITLE STR0056 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) } PICTURE "@EZ 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT
		DEFINE CELL NAME "DESCONTOS" 	OF oSection8 TITLE STR0057 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) } PICTURE "@EZ 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT
		DEFINE CELL NAME "BASES" 		OF oSection8 TITLE STR0058 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD $ "3/4",(cAliasSRR)->RR_VALOR,0) } PICTURE "@EZ 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT

		//-- Posiciona a tabela de verbas
		TRPosition():New(oSection8,"SRV",1,{|| RhFilial("SRV", (cAliasMov)->RA_FILIAL)+(cAliasSRR)->RR_PD})
	Else
		DEFINE SECTION oSection8 OF oSection7 TABLES "SRC", "SRV" TITLE STR0011 TOTAL IN COLUMN
		oSection8:SetHeaderBreak(.T.)

		DEFINE CELL NAME "RC_PD" 		OF oSection8 ALIAS "SRC"
		DEFINE CELL NAME "RV_DESC"    	OF oSection8 ALIAS "SRV"	//BLOCK {|| DescPd((cAliasSRR)->RR_PD)}
		DEFINE CELL NAME "RC_HORAS" 	OF oSection8 ALIAS "SRC"   BLOCK {|| If((cAliasSRC)->RC_TIPO1 == "V" .And. (cAliasSRC)->RC_HORAS > 0, fConvHoras((cAliasSRC)->RC_HORAS,"1"), (cAliasSRC)->RC_HORAS)} PICTURE "@E 9999.99"
		DEFINE CELL NAME "PROVENTOS" 	OF oSection8 TITLE STR0056 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "1",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15
		DEFINE CELL NAME "DESCONTOS" 	OF oSection8 TITLE STR0057 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "2",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15
		DEFINE CELL NAME "BASES" 		OF oSection8 TITLE STR0058 BLOCK {|| If((cAliasSRV)->RV_TIPOCOD $ "3/4",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15
		//-- Posiciona a tabela de verbas
		TRPosition():New(oSection8,"SRV",1,{|| RhFilial("SRV", (cAliasMov)->RA_FILIAL)+(cAliasSRC)->RC_PD})

	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Utilizada essa section para as ordens 5=Turno ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//-- Section de Turno
	DEFINE SECTION oSection9 OF oSection1 TABLES "SRA", "SR6" TITLE STR0031 +STR0005 TOTAL IN COLUMN
	oSection9:SetHeaderBreak(.T.)

	DEFINE CELL NAME "RA_TNOTRAB"	OF oSection9 ALIAS "SRA"
	DEFINE CELL NAME "R6_DESC"		OF oSection9 ALIAS "SR6"

	//-- Posiciona a tabela de turno
	TRPosition():New(oSection9,"SR6",1,{|| RhFilial("SR6", (cAliasMov)->RA_FILIAL)+(cAliasMov)->RA_TNOTRAB})

	//-- Section de Funcionario
	DEFINE SECTION oSection10 OF oSection9 TABLES "SRA" TITLE STR0054 TOTAL IN COLUMN
	oSection10:SetHeaderBreak(.T.)

	DEFINE CELL NAME "RA_CC"		OF oSection10 ALIAS "SRA"
	DEFINE CELL NAME "RA_TNOTRAB"	OF oSection10 ALIAS "SRA"
	DEFINE CELL NAME "RA_MAT"		OF oSection10 ALIAS "SRA"
	DEFINE CELL NAME "RA_NOME"		OF oSection10 ALIAS "SRA"
	DEFINE CELL NAME "RA_DEPIR"		OF oSection10 ALIAS "SRA"
	DEFINE CELL NAME "RA_DEPSF"		OF oSection10 ALIAS "SRA"

	//-- Section de Cabecalho da Rescisao (SRG)
	DEFINE SECTION oSection11 OF oSection10 TABLES "SRG" TITLE STR0055 TOTAL IN COLUMN
	oSection11:SetHeaderBreak(.T.)

	DEFINE CELL NAME "RG_DATADEM" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_DATAHOM" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_DTAVISO" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_DTGERAR" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_DAVISO" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_TIPORES" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_DESCTPR" 	OF oSection11 					BLOCK {|| fDescRCC("S043",(cAliasSRG)->RG_TIPORES,1,2,3,30) } SIZE 20
	DEFINE CELL NAME "RG_MEDATU" 	OF oSection11 					BLOCK {|| IF( (cAliasSRG)->RG_MEDATU == "S", STR0022 , STR0023 )}
	DEFINE CELL NAME "RG_DFERVEN" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_DFERPRO" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALMES" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALDIA" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_SALHORA" 	OF oSection11 ALIAS "SRG"
	DEFINE CELL NAME "RG_EFETIVA" 	OF oSection11 ALIAS "SRG"

	//-- Section de Valores da Rescisao (SRR)
	If cPaisLoc == "BRA" .or. cPaisLoc == "BOL"
		DEFINE SECTION oSection12 OF oSection11 TABLES "SRR", "SRV" TITLE STR0011 TOTAL IN COLUMN
		oSection12:SetHeaderBreak(.T.)

		DEFINE CELL NAME "RR_PD" 		OF oSection12 ALIAS "SRR"
		DEFINE CELL NAME "RV_DESC" 		OF oSection12 ALIAS "SRV"		//BLOCK {|| DescPd((cAliasSRR)->RR_PD)}
		DEFINE CELL NAME "RR_HORAS" 	OF oSection12 ALIAS "SRR" 		BLOCK {|| If(lHoraSexag .And. (cAliasSRR)->RR_TIPO1 == "H" .And. (cAliasSRR)->RR_HORAS > 0, fConvHoras((cAliasSRR)->RR_HORAS,"1"), (cAliasSRR)->RR_HORAS)} PICTURE "@E 9999.99"
		DEFINE CELL NAME "PROVENTOS" 	OF oSection12 TITLE STR0056 	BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "1",(cAliasSRR)->RR_VALOR,0) } PICTURE "@EZ 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT
		DEFINE CELL NAME "DESCONTOS" 	OF oSection12 TITLE STR0057 	BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "2",(cAliasSRR)->RR_VALOR,0) } PICTURE "@EZ 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT
		DEFINE CELL NAME "BASES" 		OF oSection12 TITLE STR0058 	BLOCK {|| If((cAliasSRV)->RV_TIPOCOD $ "3/4",(cAliasSRR)->RR_VALOR,0) } PICTURE "@EZ 9,999,999,999,999.99" SIZE 21 HEADER ALIGN RIGHT
		//-- Posiciona a tabela de verbas
		TRPosition():New(oSection12,"SRV",1,{|| RhFilial("SRV", (cAliasMov)->RA_FILIAL)+(cAliasSRR)->RR_PD})
	Else
		DEFINE SECTION oSection12 OF oSection11 TABLES "SRC", "SRV" TITLE STR0011 TOTAL IN COLUMN
		oSection12:SetHeaderBreak(.T.)

		DEFINE CELL NAME "RC_PD" 		OF oSection12 ALIAS "SRC"
		DEFINE CELL NAME "RV_DESC" 	OF oSection12 ALIAS "SRV"		//BLOCK {|| DescPd((cAliasSRR)->RR_PD)}
		DEFINE CELL NAME "RC_HORAS" 	OF oSection12 ALIAS "SRC" 		BLOCK {|| If((cAliasSRC)->RC_TIPO1 == "V" .And. (cAliasSRC)->RC_HORAS > 0, fConvHoras((cAliasSRC)->RC_HORAS,"1"), (cAliasSRC)->RC_HORAS)} PICTURE "@E 9999.99"
		DEFINE CELL NAME "PROVENTOS" OF oSection12 TITLE STR0056 	BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "1",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15
		DEFINE CELL NAME "DESCONTOS" OF oSection12 TITLE STR0057 	BLOCK {|| If((cAliasSRV)->RV_TIPOCOD == "2",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15
		DEFINE CELL NAME "BASES" 		OF oSection12 TITLE STR0058 	BLOCK {|| If((cAliasSRV)->RV_TIPOCOD $ "3/4",(cAliasSRC)->RC_VALOR,0) } PICTURE "@EZ 999,999,999.99" SIZE 15

		//-- Posiciona a tabela de verbas
		TRPosition():New(oSection12,"SRV",1,{|| RhFilial("SRV", (cAliasMov)->RA_FILIAL)+(cAliasSRC)->RC_PD})
	EndIf
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrintReport³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 13.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valores de Rescisao - Relatorio Personalizavel                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Locais                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Numerico
Local nOrdem   	:= oReport:Section(1):GetOrder()
Local nCont			:= 0

//-- Objeto
Local oSection1
Local oSection2
Local oSection3
Local oSection4
Local oSection5
Local oBreakFil
Local oBreakMat
Local oBreakCC
Local oBreakTrn
Local oLiquido
Local oLiqFil
Local oLiqCC
Local oLiqTrn

//-- String
Local cFiltro		:= ""
Local cTitulo		:= ""
Local cAcessaSRG	:= ChkRH( "GPER630" , "SRG" , "2" )
Local cAcessaSRR	:= ChkRH( "GPER630" , "SRR" , "2" )
Local cAcessaSRC	:= ChkRH( "GPER630" , "SRC" , "2" )
Local cAcessaCTT	:= ChkRH( "GPER630" , "CTT" , "2" )

Local cSitQuery		:= ""
Local cCatQuery		:= ""
Local cEfetQuery	:= ""
Local cOrdem		:= ""
Local cDepenContr	:= ""
Local cFilSRV		:= Space(FWGETTAMFILIAL)
Local cFilSR6		:= Space(FWGETTAMFILIAL)
Local cFilCTT		:= Space(FWGETTAMFILIAL)
Local cFiltroSQL  	:= Space(FWGETTAMFILIAL)
Local cReinteg		:= "%%"

//-- Logico
Local lImpEmp  		:= If(mv_par16 == 1,.T.,.F.)			// Impressao da Empresa
Local lCpoReint		:= SRG->(ColumnPos( 'RG_REINTEG' )) > 0 

//-- Array
Local aPosics		:= Array(3)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Privates                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Array
Private aCodFol	:= {}
Private aInfo	:= {}

//-- String
Private cAliasSRG	:= "SRG"
Private cAliasSRR	:= "SRR"
Private cAliasSRC	:= "SRC"
private cAliasCTT	:= "CTT"

//-- Bloco
Private bEval		:= { |e| &(e) }

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private cAcessaSRA	:= ChkRH( "GPER630" , "SRA" , "2" )

	cSituacao	:=  mv_par06															//Situacoes  a Imprimir
	cCategoria	:=  mv_par07															//Categorias a Imprimir
	lTipoRel	:=  IF( mv_par12 == 1 , .T. , .F. )									//Tipo de Relacao			( 1 - Analitica		, 2 - Sintetica	)
	lSaltaCc	:=  IF( mv_par13 == 1 , .T. , .F. )									//Quebra Pag. Cent. Custo	( 1 - Sim			, 2 - Nao		)
	lSaltaTno	:=  IF( mv_par14 == 1 , .T. , .F. )									//Quebra Pag. Turno			( 1 - Sim			, 2 - Nao		)
	If cPaisLoc == "COL"
		If mv_par17 == 1
			cEfetiva := "12345"
		Else
			cEfetiva := STR(mv_par15)
		EndIf
	ElseIf cPaisLoc == "MEX"

		iif(mv_par15 == 1, cEfetiva := "3",iif(mv_par15 == 2, cEfetiva := "2", iif(mv_par15 == 3, cEfetiva := "23", ) )) // 2 = calculada 3 = aplicada
	Else
		cEfetiva    :=  IF( mv_par15 == 1 , " S", IF( mv_par15 == 2 , "N" , " SN"))	//Imprimir Rescisoes		( 1 - Efetivadas	, 2 - Simuladas , 3 - Ambas )

	EndIf

	If cPaisLoc == "BRA" .And. lCpoReint
		cReinteg := "% SRG.RG_REINTEG <> '1' AND %"
	EndIf
	
	lHoraSexag 		:= ValType(mv_par17) == "C" .Or. mv_par17 == 1 //Imprime verbas de referência horas no formato sexagesimal 1=Sim; 2=Nao

	oSection1 	:= oReport:Section(1)		//Dados Filial

	// Formato Tabela e Sintético
	If oReport:lXlstable .And. !lTipoRel 
		//"Atenção"###"Impressão para o Tipo Relatório Sintético para o Tipo de Planilha Tabela para não é suportado."
		Aviso(OemToAnsi(STR0063),OemToAnsi(STR0064), {"OK"})
		Return(.F.)
	EndIf


   //-- Matricula ou Nome
	If nOrdem == 1 .OR. nOrdem == 3

		//-- Desabilitar as sections que nao serao utilizadas (ordem 2,4 e 5)
		oSection1:Section(2):Disable()
		oSection1:Section(3):Disable()

		oSection2 	:= oSection1:Section(1) // Dados Funcionario
		oSection3 	:= oSection2:Section(1) // Cabecalho Rescisao
		oSection4 	:= oSection3:Section(1) // Valores Rescisao
		oSection5 	:= NIL

	 	If lTipoRel
	   		DEFINE BREAK oBreakMat OF oReport WHEN  If(!oReport:lXlstable,{|| (cAliasMov)->(RA_FILIAL +RA_MAT)},oSection2:Cell("RA_MAT")) TITLE STR0029
			//-- Total do Funcionario e Total da Empresa
			DEFINE FUNCTION NAME "TOTAL1" FROM oSection4:Cell("PROVENTOS") 	FUNCTION SUM BREAK oBreakMat 	 NO END REPORT NO END SECTION TITLE STR0056
			DEFINE FUNCTION NAME "TOTAL2" FROM oSection4:Cell("DESCONTOS") 	FUNCTION SUM Break oBreakMat	 NO END REPORT NO END SECTION TITLE STR0057
			If oReport:nDevice <> 4 .And. oReport:nExcelPrintType == 1
				DEFINE FUNCTION oLiquido      FROM oSection4:Cell("DESCONTOS") 	FUNCTION ONPRINT BREAK oBreakMat  NO END SECTION NO END REPORT TITLE STR0051 FORMULA  {|| oBreakMat:GetFunction("TOTAL1"):GetLastValue() - oBreakMat:GetFunction("TOTAL2"):GetLastValue() }
				oLiquido:ShowHeader()
			EndIf
		Endif

		//-- Total da Filial e Total da Empresa
		DEFINE BREAK oBreakFil OF oReport WHEN If(!oReport:lXlstable,{|| (cAliasMov)->(RA_FILIAL)},oSection1:Cell("RA_FILIAL"))  TITLE {|| STR0034 + cFilaInfo }
		DEFINE FUNCTION NAME "TOTAL1" FROM oSection4:Cell("PROVENTOS") 	FUNCTION SUM 		BREAK oBreakFil NO END SECTION 				  TITLE STR0056
		DEFINE FUNCTION NAME "TOTAL2" FROM oSection4:Cell("DESCONTOS") 	FUNCTION SUM 		BREAK oBreakFil NO END SECTION 				  TITLE STR0057
		If oReport:nDevice <> 4 .And. oReport:nExcelPrintType == 1
			DEFINE FUNCTION oLiqFil 	  FROM oSection4:Cell("DESCONTOS")  FUNCTION ONPRINT 	BREAK oBreakFil NO END SECTION  			  TITLE STR0051 FORMULA {|| oBreakFil:GetFunction("TOTAL1"):GetLastValue() - oBreakFil:GetFunction("TOTAL2"):GetLastValue() }
			oLiqFil:ShowHeader()
		EndIf

		oBreakFil:OnBreak({|x,y| cFilaInfo := x })
		oBreakFil:FunctionBefore(.F.)

		If lImpEmp
			DEFINE COLLECTION OF oSection4 FUNCTION SUM FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " + oSection4:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection4:Cell("PROVENTOS") 	BREAK oBreakFil  TITLE OemToAnsi(STR0056) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "1" }
			DEFINE COLLECTION OF oSection4 FUNCTION SUM FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " + oSection4:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection4:Cell("DESCONTOS") 	BREAK oBreakFil  TITLE OemToAnsi(STR0057) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "2" }
			DEFINE COLLECTION OF oSection4 FUNCTION SUM FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " + oSection4:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection4:Cell("BASES") 		BREAK oBreakFil  TITLE OemToAnsi(STR0058) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "3" }
		Else
			DEFINE COLLECTION OF oSection4 FUNCTION SUM FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " + oSection4:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection4:Cell("PROVENTOS") 	BREAK oBreakFil  TITLE OemToAnsi(STR0056) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "1" }
			DEFINE COLLECTION OF oSection4 FUNCTION SUM FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " + oSection4:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection4:Cell("DESCONTOS") 	BREAK oBreakFil  TITLE OemToAnsi(STR0057) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "2" }
			DEFINE COLLECTION OF oSection4 FUNCTION SUM FORMULA {|| oSection4:Cell("RR_PD"):GetValue(.T.) + " - " + oSection4:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection4:Cell("BASES") 		BREAK oBreakFil  TITLE OemToAnsi(STR0058) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "3" }
		EndIf
	Else
	   																 // Dados C. Custo 		- Dados Turno
		oSection2 	:= If(nOrdem == 2 .OR. nOrdem == 4, oSection1:Section(2), 	oSection1:Section(3))
		oSection3 	:= oSection2:Section(1) // Dados Funcionario
		oSection4 	:= oSection3:Section(1) // Cabecalho Rescisao
		oSection5 	:= oSection4:Section(1) // Valores Rescisao

		oSection3:SetTotalText(STR0029)


	   //-- Centro de Custo ou Centro de Custo + Nome
		If nOrdem == 2 .OR. nOrdem == 4

			//-- Desabilitar as sections que nao serao utilizadas (ordem 1, 3 e 5)
			oSection1:Section(1):Disable()
			oSection1:Section(3):Disable()

			//-- Total do Centro de Custo
			DEFINE BREAK oBreakCC OF oReport WHEN If(!oReport:lXlstable,{|| (cAliasMov)->(RA_CC)},oSection2:Cell("RA_CC")) TITLE {|| STR0035 + cCCAnt }
			oBreakCC:OnBreak({|x,y|  cCCAnt := x })
			DEFINE FUNCTION NAME "TOTAL1" FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM 		BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0056
			DEFINE FUNCTION NAME "TOTAL2" FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM 		BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0057
			If oReport:nDevice <> 4 .And. oReport:nExcelPrintType == 1
				DEFINE FUNCTION oLiqCC 		  FROM oSection5:Cell("PROVENTOS") 	FUNCTION ONPRINT 	BREAK oBreakCC NO END SECTION NO END REPORT TITLE STR0051 FORMULA {|| oSection5:GetFunction("TOTAL1"):GetLastValue() - oSection5:GetFunction("TOTAL2"):GetLastValue() }
				oLiqCC:ShowHeader()
			EndIf
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("PROVENTOS") 	BREAK oBreakCC  TITLE OemToAnsi(STR0056) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "1" }
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("DESCONTOS") 	BREAK oBreakCC  TITLE OemToAnsi(STR0057) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "2" }
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("BASES") 		BREAK oBreakCC  TITLE OemToAnsi(STR0058) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "3" }

			oBreakCC:FunctionBefore(.F.)

			If lSaltaCc
				oBreakCC:SetPageBreak(.T.)
			EndIf
	   //-- Turno
		Else

			//-- Desabilitar as sections que nao serao utilizadas (ordem 1 a 4)
			oSection1:Section(1):Disable()
			oSection1:Section(2):Disable()

			//-- Total do Turno
			DEFINE BREAK oBreakTrn OF oReport WHEN If(!oReport:lXlstable,{|| (cAliasMov)->(RA_TNOTRAB)},oSection2:Cell("RA_TNOTRAB")) TITLE {|| STR0036 + cTurnoAnt }
			oBreakTrn:OnBreak({|x,y|  cTurnoAnt := x })
			DEFINE FUNCTION NAME "TOTAL1" FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM 		BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0056
			DEFINE FUNCTION NAME "TOTAL2" FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM 		BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0057
			If oReport:nDevice <> 4 .And. oReport:nExcelPrintType == 1
				DEFINE FUNCTION oLiqTrn 	  FROM oSection5:Cell("PROVENTOS") 	FUNCTION ONPRINT 	BREAK oBreakTrn NO END SECTION NO END REPORT TITLE STR0051 FORMULA {|| oSection5:GetFunction("TOTAL1"):GetLastValue() - oSection5:GetFunction("TOTAL2"):GetLastValue() }
				oLiqTrn:ShowHeader()
			EndIf

			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("PROVENTOS") 	BREAK oBreakTrn  TITLE OemToAnsi(STR0056) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "1" }
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("DESCONTOS") 	BREAK oBreakTrn  TITLE OemToAnsi(STR0057) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "2" }
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("BASES") 		   BREAK oBreakTrn  TITLE OemToAnsi(STR0058) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "3" }

			oBreakTrn:FunctionBefore(.F.)

			If lSaltaTno
				oBreakTrn:SetPageBreak(.T.)
			EndIf
		EndIf

		//-- Total da Filial
		DEFINE BREAK oBreakFil OF oReport WHEN If(!oReport:lXlstable,{|| (cAliasMov)->(RA_FILIAL)},oSection1:Cell("RA_FILIAL")) TITLE {|| STR0034 + cFilaInfo }
		DEFINE FUNCTION NAME "TOTAL1" FROM oSection5:Cell("PROVENTOS") 	FUNCTION SUM 		BREAK oBreakFil NO END SECTION TITLE STR0056
		DEFINE FUNCTION NAME "TOTAL2" FROM oSection5:Cell("DESCONTOS") 	FUNCTION SUM 		BREAK oBreakFil NO END SECTION TITLE STR0057
		If oReport:nDevice <> 4 .And. oReport:nExcelPrintType == 1
			DEFINE FUNCTION oLiqFil 	  FROM oSection5:Cell("PROVENTOS") 	FUNCTION ONPRINT 	BREAK oBreakFil NO END SECTION TITLE STR0051 FORMULA {|| oBreakFil:GetFunction("TOTAL1"):GetLastValue() - oBreakFil:GetFunction("TOTAL2"):GetLastValue() }
			oLiqFil:ShowHeader()
		EndIf

		oBreakFil:OnBreak({|x,y|  cFilaInfo := x })
		oBreakFil:FunctionBefore(.F.)

		If lImpEmp
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("PROVENTOS") 	BREAK oBreakFil  TITLE OemToAnsi(STR0056) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "1" }
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("DESCONTOS") 	BREAK oBreakFil  TITLE OemToAnsi(STR0057) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "2" }
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("BASES") 		BREAK oBreakFil  TITLE OemToAnsi(STR0058) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "3" }
		Else
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("PROVENTOS") 	BREAK oBreakFil  TITLE OemToAnsi(STR0056) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "1" }
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("DESCONTOS") 	BREAK oBreakFil  TITLE OemToAnsi(STR0057) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "2" }
			DEFINE COLLECTION OF oSection5 FUNCTION SUM FORMULA {|| oSection5:Cell("RR_PD"):GetValue(.T.) + " - " + oSection5:Cell("RV_DESC"):GetValue(.T.)} CONTENT oSection5:Cell("BASES") 		BREAK oBreakFil  TITLE OemToAnsi(STR0058) PICTURE "@EZ 9,999,999,999,999.99" NO END SECTION  NO END REPORT WHEN {|| PosSrv((cAliasSRV)->RV_COD,(cAliasMov)->RA_FILIAL,"RV_TIPOCOD") == "3" }
		EndIf
	EndIf
	oReport:FunctionBefore(.F.)

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Posiciona no Primeiro Registro Selecionado nos Parametros De/Ate     ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	cTitulo  := If(AllTrim(oReport:Title()) == AllTrim(cTitulo), cTitulo, oReport:Title())

	IF nOrdem == 1					//Matricula
		cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0038 , STR0039 ) + ' - ' + STR0031 +  STR0001 + " ) "
	ElseIF nOrdem == 2				//Centro de Custo
		cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0038 , STR0039 ) + ' - ' + STR0031 +  STR0002 + " ) "
	ElseIF nOrdem == 3				//Nome
		cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0038 , STR0039 ) + ' - ' + STR0031 +  STR0003 + " ) "
	ElseIF nOrdem == 4				//Centro de Custo + Nome
		cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0038 , STR0039 ) + ' - ' + STR0031 +  STR0004 + " ) "
	ElseIF nOrdem == 5				//Turno de Trabalho
		cTitulo	:= cTitulo + " ( " + IF( lTipoRel , STR0038 , STR0039 ) + ' - ' + STR0031 +  STR0005 + " ) "
	EndIF
	oReport:SetTitle(cTitulo)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz filtro no arquivo...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cAliasMov 	:= GetNextAlias()
	cAliasSRG   := cAliasMov
	cAliasSRR   := cAliasMov
	cAliasSRV	:= cAliasMov

	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr("GPER630")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Modifica variaveis para a Query                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//-- Situacao do Funcionario
	cSitQuery := ""
	For nCont:=1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nCont,1)+"'"
		If ( nCont+1 ) <= Len(cSituacao)
			cSitQuery += ","
		Endif
	Next nCont
	cSitQuery := "%" + cSitQuery + "%"


	//-- Categoria do Funcionario
	cCatQuery := ""
	For nCont:=1 to Len(cCategoria)
		cCatQuery += "'"+Subs(cCategoria,nCont,1)+"'"
		If ( nCont+1 ) <= Len(cCategoria)
			cCatQuery += ","
		Endif
	Next nCont
	cCatQuery := "%" + cCatQuery + "%"

  	cEfetQuery := ""
	For nCont:=1 to Len(cEfetiva)
		cEfetQuery += "'"+Subs(cEfetiva,nCont,1)+"'"
		If ( nCont+1 ) <= Len(cEfetiva)
			cEfetQuery += ","
		Endif
	Next nCont
	cEfetQuery := "%" + cEfetQuery + "%"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta string de ordenacao                                          		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc $ "MEX|COL"
		If nOrdem == 1												// Matricula
			cOrdem := "%RA_FILIAL, RA_MAT%"
		ElseIf nOrdem == 2										// Centro de Custo
			cOrdem := "%RA_FILIAL, RA_CC, RA_MAT%"
		ElseIf nOrdem == 3										// Nome
			cOrdem := "%RA_FILIAL, RA_NOME, RA_MAT%"
		ElseIf nOrdem == 4										// Centro de Custo + Nome
			cOrdem := "%RA_FILIAL, RA_CC, RA_NOME%"
		ElseIf nOrdem == 5 										// Turno
			cOrdem := "%RA_FILIAL, RA_TNOTRAB, RA_SEQTURN, RA_REGRA, RA_MAT%"
		EndIf
	Else
		If nOrdem == 1												// Matricula
			cOrdem := "%RA_FILIAL, RA_MAT, RR_PD%"
		ElseIf nOrdem == 2										// Centro de Custo
			cOrdem := "%RA_FILIAL, RA_CC, RA_MAT, RR_PD%"
		ElseIf nOrdem == 3										// Nome
			cOrdem := "%RA_FILIAL, RA_NOME, RA_MAT, RR_PD%"
		ElseIf nOrdem == 4										// Centro de Custo + Nome
			cOrdem := "%RA_FILIAL, RA_CC, RA_NOME, RR_PD%"
		ElseIf nOrdem == 5 										// Turno
			cOrdem := "%RA_FILIAL, RA_TNOTRAB, RA_SEQTURN, RA_REGRA, RA_MAT, RR_PD%"
		EndIf
	Endif

	cFilSRV := "% " + FWJoinFilial("SRV", "SRA") + " AND %"
	cFilSR6 := "% " + FWJoinFilial("SR6", "SRA") + " AND %"

	If ( TCGetDB() $ 'DB2|ORACLE|POSTGRES|INFORMIX' )
		cFilSRV := StrTran(cFilSRV, "SUBSTRING", "SUBSTR")
		cFilSR6 := StrTran(cFilSR6, "SUBSTRING", "SUBSTR")
	EndIf

	For nCont := 1 to 3
		aPosics[nCont] := Len(FWSM0Layout(,nCont)) //Pega quantidade de caracteres usados para empresa, unid. negocio, filial
	Next

	cFilCTT := "% " + fWJoinFilial('CTT','SRA') + " AND %"


	cDepenContr	:= "% SRA.RA_DEPIR, SRA.RA_DEPSF %"

			cFiltroSQL := "% "
		//-- Adiciona no filtro o parametro tipo Range
		//-- Filial
		If !Empty(mv_par01)
			cFiltroSQL += " AND " + mv_par01
		EndIf

		//-- Centro de Custo
		If !Empty(mv_par02)
			cFiltroSQL += " AND " + mv_par02
		EndIf

		//-- Turno
		If !Empty(mv_par03)
			cFiltroSQL += " AND " + mv_par03
		EndIf

		//-- Matricula
		If !Empty(mv_par04)
			cFiltroSQL += " AND " + mv_par04
		EndIf

		//-- Nome
		If !Empty(mv_par05)
			cFiltroSQL += " AND " + mv_par05
		EndIf

		//-- Tipo de Resciosion
		If !Empty(mv_par08)
			cFiltroSQL += " AND " + mv_par08
		EndIf

		//-- Fecha Despido
		If !Empty(mv_par09)
			cFiltroSQL += " AND " + mv_par09
		EndIf

		//-- Fecha Homolog
		If !Empty(mv_par10)
			cFiltroSQL += " AND " + mv_par10
		EndIf

		//-- Fecha Generación
		If !Empty(mv_par11)
			cFiltroSQL += " AND " + mv_par11
		EndIf

		cFiltroSQL += " %"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa Query                                                  		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	If cPaisLoc == "COL"
			BeginSql alias cAliasMov
				SELECT RA_FILIAL, RA_CC, RA_TNOTRAB, RA_MAT, RA_NOME, RA_NOMECMP, RA_TPCIC, RA_CIC, RA_DEPTO, RA_CARGO,
					RA_CODFUNC, RA_PROCES, RA_CODRPAT, RA_CODAFP, RA_NITARL, RA_CXCOMP, RA_OFICIO, RA_HRSMES, RA_TIPOPRC,
					RA_PERCIR, RA_SALARIO, RA_ADMISSA, RA_DTREC, RA_TIPOCO, RA_DEMISSA, RA_TIPFIN, %exp:cDepenContr%,
					RG_FILIAL, RG_MAT, RG_DATADEM, RG_DATAHOM, RG_DTAVISO, RG_DTGERAR, RG_DAVISO, RG_TIPORES, RG_MEDATU,
					RG_DFERVEN, RG_DFERPRO, RG_SALMES, RG_SALDIA, RG_SALHORA, RG_EFETIVA,
					RC_FILIAL, RC_MAT, RC_PD, RC_HORAS, RC_TIPO1, RC_VALOR, RC_TIPO2, RC_DATA,
					RV_COD, RV_DESC, RV_TIPOCOD,
					R6_DESC, CTT_DESC01
				FROM %table:SRA% SRA, %table:SRG% SRG, %table:SRC% SRC, %table:SRV% SRV,
				     %table:SR6% SR6, %table:CTT% CTT
				WHERE SRA.RA_FILIAL 	= SRG.RG_FILIAL				AND
					SRA.RA_MAT 	= SRG.RG_MAT						AND
					SRA.RA_FILIAL = SRC.RC_FILIAL					AND
					SRA.RA_MAT 	= SRC.RC_MAT						AND
					%exp:cFilSRV%
					SRC.RC_PD		= SRV.RV_COD					AND
				   	%exp:cFilSR6%
					SR6.R6_TURNO	= SRA.RA_TNOTRAB				AND
					%exp:cFilCTT%
					CTT.CTT_CUSTO	= SRA.RA_CC						AND
					SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%)		AND
					SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%)		AND
			  		SRG.RG_EFETIVA IN (%exp:cEfetQuery%)			AND
					SRA.%notDel%									AND
					SRG.%notDel%									AND
					SRC.%notDel%									AND
					SRV.%notDel%									AND
					SR6.%notDel%									AND
					CTT.%notDel%
					%exp:cFiltroSQL%
				UNION
					(SELECT RA_FILIAL, RA_CC, RA_TNOTRAB, RA_MAT, RA_NOME, RA_NOMECMP, RA_TPCIC, RA_CIC, RA_DEPTO, RA_CARGO,
						 RA_CODFUNC, RA_PROCES, RA_CODRPAT, RA_CODAFP, RA_NITARL, RA_CXCOMP, RA_OFICIO, RA_HRSMES, RA_TIPOPRC,
						 RA_PERCIR, RA_SALARIO, RA_ADMISSA, RA_DTREC, RA_TIPOCO, RA_DEMISSA, RA_TIPFIN, %exp:cDepenContr%,
						 RG_FILIAL, RG_MAT, RG_DATADEM, RG_DATAHOM, RG_DTAVISO, RG_DTGERAR, RG_DAVISO, RG_TIPORES, RG_MEDATU,
						 RG_DFERVEN, RG_DFERPRO, RG_SALMES, RG_SALDIA, RG_SALHORA, RG_EFETIVA,
						 RD_FILIAL, RD_MAT, RD_PD, RD_HORAS, RD_TIPO1, RD_VALOR, RD_TIPO2, RD_DATARQ,
						 RV_COD, RV_DESC, RV_TIPOCOD,
						 R6_DESC, CTT_DESC01
					FROM %table:SRA% SRA, %table:SRG% SRG, %table:SRD% SRD, %table:SRV% SRV,
					     %table:SR6% SR6, %table:CTT% CTT
					WHERE SRA.RA_FILIAL 	= SRG.RG_FILIAL				AND
						SRA.RA_MAT 	= SRG.RG_MAT						AND
						SRA.RA_FILIAL = SRD.RD_FILIAL					AND
						SRA.RA_MAT 	= SRD.RD_MAT						AND
						%exp:cFilSRV%
						SRD.RD_PD		= SRV.RV_COD					AND
					   	%exp:cFilSR6%
						SR6.R6_TURNO	= SRA.RA_TNOTRAB				AND
						%exp:cFilCTT%
						CTT.CTT_CUSTO	= SRA.RA_CC						AND
						SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%)		AND
						SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%)		AND
				  		SRG.RG_EFETIVA IN (%exp:cEfetQuery%)			AND
						SRA.%notDel%									AND
						SRG.%notDel%									AND
						SRD.%notDel%									AND
						SRV.%notDel%									AND
						SR6.%notDel%									AND
						CTT.%notDel%
						%exp:cFiltroSQL%
					)
				ORDER BY %exp:cOrdem%
			EndSql

	ElseIf cPaisLoc == "MEX"

		BeginSql alias cAliasMov
			SELECT RA_FILIAL, RA_CC, RA_TNOTRAB, RA_MAT, RA_NOME, %exp:cDepenContr%,
					RG_FILIAL, RG_MAT, RG_DATADEM, RG_DATAHOM, RG_DTAVISO, RG_DTGERAR, RG_DAVISO, RG_TIPORES, RG_MEDATU,
					RG_DFERVEN, RG_DFERPRO, RG_SALMES, RG_SALDIA, RG_SALHORA, RG_EFETIVA,
					RC_FILIAL, RC_MAT, RC_PD, RC_HORAS, RC_TIPO1, RC_VALOR,RC_TIPO2, RC_DATA,
					RV_COD, RV_DESC, RV_TIPOCOD,
					R6_DESC, CTT_DESC01
			FROM %table:SRA% SRA, %table:SRG% SRG, %table:SRC% SRC, %table:SRV% SRV,
			     %table:SR6% SR6, %table:CTT% CTT
			WHERE SRA.RA_FILIAL 	= SRG.RG_FILIAL				AND
				SRA.RA_MAT 		= SRG.RG_MAT					AND
				SRA.RA_FILIAL 	= SRC.RC_FILIAL					AND
				SRA.RA_MAT 		= SRC.RC_MAT					AND
				%exp:cFilSRV%
				SRC.RC_PD		= SRV.RV_COD					AND
				%exp:cFilSR6%
				SR6.R6_TURNO	= SRA.RA_TNOTRAB				AND
				%exp:cFilCTT%
				CTT.CTT_CUSTO	= SRA.RA_CC						AND
				SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%)	   	AND
				SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%)		AND
		  		SRG.RG_EFETIVA IN (%exp:cEfetQuery%)			AND
				SRA.%notDel%									AND
				SRG.%notDel%									AND
				SRC.%notDel%									AND
				CTT.%notDel%									AND
				SRV.%notDel%									AND
				SR6.%notDel%
				%exp:cFiltroSQL%

				UNION
					(SELECT RA_FILIAL, RA_CC, RA_TNOTRAB, RA_MAT, RA_NOME, %exp:cDepenContr%,
							RG_FILIAL, RG_MAT, RG_DATADEM, RG_DATAHOM, RG_DTAVISO, RG_DTGERAR, RG_DAVISO, RG_TIPORES, RG_MEDATU,
							RG_DFERVEN, RG_DFERPRO, RG_SALMES, RG_SALDIA, RG_SALHORA, RG_EFETIVA,
							RD_FILIAL, RD_MAT, RD_PD, RD_HORAS, RD_TIPO1, RD_VALOR,RD_TIPO2, RD_DATARQ,
							RV_COD, RV_DESC, RV_TIPOCOD,
							R6_DESC, CTT_DESC01
					FROM %table:SRA% SRA, %table:SRG% SRG, %table:SRD% SRD, %table:SRV% SRV,
					     %table:SR6% SR6, %table:CTT% CTT
					WHERE SRA.RA_FILIAL 	= SRG.RG_FILIAL				AND
						SRA.RA_MAT 	= SRG.RG_MAT						AND
						SRA.RA_FILIAL = SRD.RD_FILIAL					AND
						SRA.RA_MAT 	= SRD.RD_MAT						AND
						%exp:cFilSRV%
						SRD.RD_PD		= SRV.RV_COD					AND
					   	%exp:cFilSR6%
						SR6.R6_TURNO	= SRA.RA_TNOTRAB				AND
						%exp:cFilCTT%
						CTT.CTT_CUSTO	= SRA.RA_CC						AND
						SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%)		AND
						SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%)		AND
				  		SRG.RG_EFETIVA IN (%exp:cEfetQuery%)			AND
						SRA.%notDel%									AND
						SRG.%notDel%									AND
						SRD.%notDel%									AND
						SRV.%notDel%									AND
						SR6.%notDel%									AND
						CTT.%notDel%
						%exp:cFiltroSQL%
					)

				ORDER BY %exp:cOrdem%
			EndSql

	Else
		BeginSql alias cAliasMov
		SELECT RA_FILIAL, RA_CC, RA_TNOTRAB, RA_MAT, RA_NOME, %exp:cDepenContr%,
			RG_FILIAL, RG_MAT, RG_DATADEM, RG_DATAHOM, RG_DTAVISO, RG_DTGERAR, RG_DAVISO, RG_TIPORES, RG_MEDATU,
			RG_DFERVEN, RG_DFERPRO, RG_SALMES, RG_SALDIA, RG_SALHORA, RG_EFETIVA,
			RR_FILIAL, RR_MAT, RR_PD, RR_HORAS, RR_TIPO1, RR_VALOR, RR_TIPO3, RR_DATA,
			RV_COD, RV_DESC, RV_TIPOCOD,
			R6_DESC, CTT_DESC01
		FROM %table:SRA% SRA, %table:SRG% SRG, %table:SRR% SRR, %table:SRV% SRV,
		     %table:SR6% SR6, %table:CTT% CTT
		WHERE SRA.RA_FILIAL 	= SRG.RG_FILIAL				AND
			SRA.RA_MAT 		= SRG.RG_MAT					AND
			SRA.RA_FILIAL 	= SRR.RR_FILIAL					AND
			SRA.RA_MAT 		= SRR.RR_MAT					AND
			SRR.RR_TIPO3	= 'R'							AND
			%exp:cFilSRV%
			SRR.RR_PD		= SRV.RV_COD					AND
			%exp:cFilSR6%
			SR6.R6_TURNO	= SRA.RA_TNOTRAB				AND
			%exp:cFilCTT%
			CTT.CTT_CUSTO	= SRA.RA_CC						AND
			SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%)	   	AND
			SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%)		AND
	  		SRG.RG_EFETIVA IN (%exp:cEfetQuery%)			AND
			%exp:cReinteg%									
			SRA.%notDel%									AND
			SRG.%notDel%									AND
			SRR.%notDel%									AND
			CTT.%notDel%									AND
			SRV.%notDel%									AND
			SR6.%notDel%
			%exp:cFiltroSQL%
			ORDER BY %exp:cOrdem%
		EndSql
	EndIf
	/*
	Prepara relatorio para executar a query gerada pelo Embedded SQL passando como
	parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados
	pela funcao MakeSqlExpr para serem adicionados a query
	*/
	END REPORT QUERY oSection1

	//-- Utiliza a query do Pai (Section2) - Funcionarios
	oSection2:SetParentQuery()
	oSection2:SetParentFilter({|cParam| (cAliasMov)->RA_FILIAL == cParam},{|| (cAliasMov)->RA_FILIAL })

	If nOrdem == 1 .or. nOrdem == 3

		//-- Condicao de relacionamento da secao filha em relacao a sua secao pai

		oSection3:SetParentQuery()
		oSection3:SetParentFilter({|cParam| (cAliasMov)->RG_FILIAL + (cAliasMov)->RG_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})
		oSection4:SetParentQuery()

		If cPaisLoc == "BRA" .or. cPaisLoc == "BOL"
			oSection4:SetParentFilter({|cParam| (cAliasMov)->RR_FILIAL + (cAliasMov)->RR_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})
		Else
			oSection4:SetParentFilter({|cParam| (cAliasMov)->RC_FILIAL + (cAliasMov)->RC_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})
		EndIf

	Else
		oSection3:SetParentQuery()
		oSection3:SetParentFilter({|cParam| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})

		oSection4:SetParentQuery()
		oSection4:SetParentFilter({|cParam| (cAliasMov)->RG_FILIAL + (cAliasMov)->RG_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})

		oSection5:SetParentQuery()
		If cPaisLoc == "BRA" .or. cPaisLoc == "BOL"
			oSection5:SetParentFilter({|cParam| (cAliasMov)->RR_FILIAL + (cAliasMov)->RR_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})
		Else
			oSection5:SetParentFilter({|cParam| (cAliasMov)->RC_FILIAL + (cAliasMov)->RC_MAT == cParam},{|| (cAliasMov)->RA_FILIAL + (cAliasMov)->RA_MAT})
		EndIf

	EndIf


	//-- Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter((cAliasMov)->( RecCount() ))

	//-- Condicao para Impressao das Sections
	oSection1:SetLineCondition({|| fCondFil(oReport) })
	oSection2:SetLineCondition({|| fCondSRA() })

	If nOrdem == 1 .or. nOrdem == 3
		oSection3:SetLineCondition({|| Eval( bEval , cAcessaSRG ) })
		If cPaisLoc == "BRA" .or. cPaisLoc == "BOL"
			oSection4:SetLineCondition({|| Eval( bEval , cAcessaSRR ) .AND. !( (cAliasSRR)->RR_PD $ aCodFol[ 126 , 1 ]) .AND. (cAliasSRR)->RR_DATA == (cAliasSRG)->RG_DTGERAR })
		Else
			oSection4:SetLineCondition({|| Eval( bEval , cAcessaSRC ) .AND. !( (cAliasSRC)->RC_PD $ aCodFol[ 126 , 1 ]) .AND. (cAliasSRC)->RC_DATA == (cAliasSRG)->RG_DTGERAR })
		EndIf
	Else
		oSection3:SetLineCondition({|| fCondSRA() })
		oSection4:SetLineCondition({|| Eval( bEval , cAcessaSRG ) })
		If cPaisLoc == "BRA" .or. cPaisLoc == "BOL"
			oSection5:SetLineCondition({|| Eval( bEval , cAcessaSRR ) .AND. !( (cAliasSRR)->RR_PD $ aCodFol[ 126 , 1 ]) .AND. (cAliasSRR)->RR_DATA == (cAliasSRG)->RG_DTGERAR })
		Else
			oSection5:SetLineCondition({|| Eval( bEval , cAcessaSRC ) .AND. !( (cAliasSRC)->RC_PD $ aCodFol[ 126 , 1 ]) .AND. (cAliasSRC)->RC_DATA == (cAliasSRG)->RG_DTGERAR })
		EndIF
	EndIf

	If !lTipoRel

		oSection2:Hide()
		oSection3:Hide()
		oSection4:Hide()
		If (nOrdem == 1 .or. nOrdem == 3)
			oSection1:Hide()
		EndIf

		If !(nOrdem == 1 .or. nOrdem == 3)
			oSection5:Hide()
		EndIf
	EndIf
	oSection1:Print()

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCondFil   ³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 13.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a linha deve ser impressa                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCondFil()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCondFil(oReport)

//-- Variavel de Retorno
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
			If !fp_CodFol(@aCodFol,cFilaInfo,.F.) .Or. !fInfo(@aInfo,cFilaInfo)
				oReport:lCanceled	:= .T.
			Endif
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
Return .T.
