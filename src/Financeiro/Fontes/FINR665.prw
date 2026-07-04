/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "FINR665.ch"

Static lF665FilBr 	:= ExistBlock("F665FilBrw")

/*/{Protheus.doc} FINR665
Relatório - Mapa de Viagem

@author Alexandre Felicio
@since 04/09/2015
@version P12 R12.1.7

@return Nil
/*/
User Function FINR665()

	Local lRet		:= .T.
	Local cPerg		:= "FINR665"

	Private aSelFil 	:= {}
	Private aUsuario	:= {}

	aUsuario := FN683PARTI()

	If aUsuario[1] == "NO"
		FwFreeArray(aUsuario)
		Help(" ", 1, "F665ACESSO",, STR0022, 1, 0)
		Return Nil
	EndIf

	lRet := Pergunte(cPerg , .T.)

	If MV_PAR21 == 1 .And. Len(aSelFil) <= 0 .And. lRet
		aSelFil := AdmGetFil()
		If Len(aSelFil) <= 0
			lRet := .F.
		EndIf
	EndIf

	If lRet
		oReport := ReportDef(cPerg)
		oReport:PrintDialog()
	EndIf

	FwFreeArray(aUsuario)
	F665ClrTmp()

Return Nil

/*/{Protheus.doc} ReportDef
Definição de layout do relatório

@author Alexandre Felicio
@since 04/09/2015
@version P12 R12.1.7

@return Nil
/*/
Static Function ReportDef(cPerg)

Local oSection	    := Nil
Local oSessao1		:= Nil
Local oSessao2		:= Nil
Local oSessao3		:= Nil
Local oSessao4		:= Nil
Local oSessao5		:= Nil
Local oSessao6		:= Nil
Local oSessao7		:= Nil
Local oSessao8		:= Nil
Local oSessao9		:= Nil
Local oReport		:= Nil

                                   ///"Mapa de Viagens"                                 ///"Mapa de Viagens" 
oReport := TReport():New("FINR665",STR0001,cPerg,{|oReport| PrintReport(oReport,cPerg)},STR0001	,.T.		,			,.F.			,			,				,				,			)
									
										///"Viagem"
oSection := TRSection():New( oReport	,STR0002	,"FL5"	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Viagem
                         ///"Viagem"
TRCell():New( oSection	,"VIAGEM" 		,"FL5"  ,STR0002,			,8		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New( oSection	,"FL5_FILIAL"	,"FL5"	,		,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)
TRCell():New( oSection	,"FL5_VIAGEM"	,"FL5"	,		,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)
TRCell():New( oSection	,"FL5_DESORI"	,"FL5"	,		,			,		,		,		,		,.T.		,				,			,			,.T.		,			,			,		) 
TRCell():New( oSection	,"FL5_DESDES"	,"FL5"	,		,			,		,		,		,		,.T.		,				,			,			,.T.		,			,			,		)
TRCell():New( oSection	,"FL5_DTINI"	,"FL5"	,		,			,		,		,		,		,.T.		,				,			,			,.T.		,			,			,		) 
TRCell():New( oSection	,"FL5_DTFIM"	,"FL5"	,		,			,		,		,		,		,.T.		,				,			,			,.T.		,			,			,		) 
TRCell():New( oSection	,"A1_NOME"   	,"FL5"	,		,			,		,		,		,		,.T.		,				,			,			,.T.		,			,			,		)
TRCell():New( oSection	,"FL5_STATUS"	,"FL5"	,		,			,		,		,		,		,.T.		,				,			,			,.T.		,			,			,		)

									    ///"Aéreo"
oSessao1 := TRSection():New( oReport,STR0003	,'FL7'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Aéreo
TRCell():New(oSessao1,"AEREO"		,"FL7",STR0003	,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao1,"FL7_NOME"   	,"FL7",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao1,"FL7_ORIGEM" 	,"FL7",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao1,"FL7_DESTIN" 	,"FL7",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao1,"FL7_DSAIDA" 	,"FL7",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao1,"FL7_DCHEGA" 	,"FL7",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)  
									
										///"Hospedagem"
oSessao2 := TRSection():New( oReport,STR0004	,'FL9'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Hospedagem
TRCell():New(oSessao2,"HOSPEDAGEM"	,"FL9",STR0004	,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao2,"FL9_NOME"   	,"FL9",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao2,"FL9_DIARIA" 	,"FL9",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao2,"FL9_DCHKIN" 	,"FL9",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao2,"FL9_HCHKIN" 	,"FL9",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao2,"FL9_DCHKOU" 	,"FL9",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)  
TRCell():New(oSessao2,"FL9_HCHKOU" 	,"FL9",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)  
									
										///"Rodoviário"
oSessao3 := TRSection():New( oReport	,STR0005	,'FL8'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Rodoviário
TRCell():New(oSessao3,"RODOVIARIO" ,"FL8",STR0005	,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao3,"FL8_NOME"   ,"FL8",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao3,"FL8_ORIGEM" ,"FL8",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao3,"FL8_DESTIN" ,"FL8",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao3,"FL8_DSAIDA" ,"FL8",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao3,"FL8_DCHEGA" ,"FL8",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)  
									
										///"Locação Veículos"
oSessao4 := TRSection():New( oReport	,STR0006	,'FLB'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Locação Veículo
TRCell():New(oSessao4,"LOCACAO" 	,"FLB",STR0006	,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao4,"FLB_NOME" 	,"FLB",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao4,"FLB_TIPVEI" 	,"FLB",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao4,"FLB_DIARIA" 	,"FLB",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao4,"FLB_DRETIR" 	,"FLB",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao4,"FLB_DDEVOL" 	,"FLB",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)  
										
										 //"Adiantamentos"
oSessao5 := TRSection():New( oReport	,STR0007	,'FLD'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Adiantamentos
TRCell():New(oSessao5,"ADIANTAMENTO","FLD",STR0007	,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao5,"RD0_NOME" 	,"FLD",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao5,"FLD_VALOR" 	,"FLD",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao5,"FLD_DTSOLI" 	,"FLD",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao5,"FLD_DTPAGT" 	,"FLD",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao5,"FLD_STATUS" 	,"FLD",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)  

										///"Prestação de Contas"
oSessao6 := TRSection():New( oReport	,STR0008,'FLF'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Prestação de Contas
TRCell():New(oSessao6,"PRESTCONTAS"	,"FLF",STR0008	,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao6,"RD0_NOME" 	,"FLF",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao6,"FLF_TDESP1" 	,"FLF",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao6,"FLF_TDESP2" 	,"FLF",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao6,"FLF_TDESP3" 	,"FLF",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)  
TRCell():New(oSessao6,"FLF_TVLRE1" 	,"FLF",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao6,"FLF_TVLRE2" 	,"FLF",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao6,"FLF_TVLRE3" 	,"FLF",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)
TRCell():New(oSessao6,"FLF_STATUS" 	,"FLF",			,	    	,		,		, {|| U_FINR665STA(FLF_STATUS)}		,		,.T.			,				,			,			,.T.			,			,			,		)  
  													
 										///"Conferência de Serviços"
oSessao7 := TRSection():New( oReport	,STR0009	,'FLQ'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Conferência de Serviços
TRCell():New(oSessao7,"CONFSERV" 	,"FLQ", STR0009 ,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao7,"A2_NOME"    	,"FLQ",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao7,"FLQ_DATA"   	,"FLQ",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao7,"FLQ_TOTAL"  	,"FLQ",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao7,"FLQ_TPPGTO" 	,"FLQ",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao7,"DOCUMENTO"  	,"FLQ",	STR0012	,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		)  
										 ///"Documento"
										 
										 ///"Centro de Custo"
oSessao8 := TRSection():New( oReport	,STR0010,'FLH'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Centro de Custo
TRCell():New(oSessao8,"CCUSTO"    	,"FLH",STR0010	,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao8,"FLH_CC"		,"FLH",			,			,		,		,		,"LEFT"	,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao8,"FLH_PORCEN"	,"FLH",			,			,		,		,		,		,.T.			,				,			,			,.T.			,			,			,		) 

										//"Aprovadores"
oSessao9 := TRSection():New( oReport	,STR0011	,'FLJ'	,		,			,			,			,.F.			,				,				,			,			,				,			,			,			,				,				,		,			,			,			) //Aprovadores
TRCell():New(oSessao9,"APROVADORES"	,"FLJ",STR0011	,			,		,		,		,"LEFT" ,.T.			,				,			,			,.T.			,			,	CLR_RED		,	.T.	)
TRCell():New(oSessao9,"FLJ_NOME"	,"FLJ",			,			,		,		,		,"LEFT"	,.T.			,				,			,			,.T.			,			,			,		) 
TRCell():New(oSessao9,"FLJ_EMAIL"	,"FLJ",			,			,		,		,		,"LEFT"	,.T.			,				,			,			,.T.			,			,			,		) 


Return  oReport

/*/{Protheus.doc} PrintReport
Realiza Rotina de impressao de dados

@author Alexandre Felicio
@since 04/09/2015
@version P12 R12.1.7

@return Nil
/*/
Static Function PrintReport(oReport, cPerg)

	Local cAlsFL5		:= GetNextAlias()
	Local cAlsFL7		:= GetNextAlias()
	Local cAlsFL9		:= GetNextAlias()
	Local cAlsFL8		:= GetNextAlias()
	Local cAlsFLB		:= GetNextAlias()
	Local cAlsFLD		:= GetNextAlias()
	Local cAlsFLF		:= GetNextAlias()
	Local cAlsFLQ		:= GetNextAlias()
	Local cAlsFLH		:= GetNextAlias()
	Local cAlsFLJ		:= GetNextAlias()
	Local oSection		:= oReport:Section(1)
	Local oSessao1		:= oReport:Section(2)
	Local oSessao2		:= oReport:Section(3)
	Local oSessao3		:= oReport:Section(4)
	Local oSessao4		:= oReport:Section(5)
	Local oSessao5		:= oReport:Section(6)
	Local oSessao6		:= oReport:Section(7)
	Local oSessao7		:= oReport:Section(8)
	Local oSessao8		:= oReport:Section(9)
	Local oSessao9		:= oReport:Section(10)
	Local cFilFL5 		:= ""
	Local cFilSA1		:= ""
	Local cTmpFL5Fil	:= ""
	Local cTmpSA1Fil	:= ""
	Local cRngFilFL5	:= ""

	Local cRngFilSA1	:= ""
	Local cWhere		:= ""
	Local cViag			:= ""
	Local cNextV		:= ""
	Local cJoinSA1		:= ""
	Local cJoinFL6		:= ""
	Local cJoinFLH		:= ""
	Local cJoinFLJ		:= ""
	Local cJoinFLF		:= ""
	Local cJoin			:= ""
	Local cFiltro		:= ".T."

	//Caso seja executado via schedule não aplica regras de filtro usadas no Browse da rotina FINA665
	If !(FwGetRunSchedule())
		If IsBlind()
			aUsuario := FN683PARTI()
		EndIf
		If !(aUsuario[1] == "ALL")
			If lF665FilBr
				cFiltro := ExecBlock("F665FilBrw", .F., .F., {aUsuario})
			Else
				cFiltro := "F665Filtro(aUsuario)"
			EndIf
		EndIf
	EndIf

	If Empty(aSelFil)
		aSelFil := {cFilAnt}
		cFilFL5 := " FL5.FL5_FILIAL = '" + xFilial("FL5") + "' AND "
		cFilSA1 := " SA1.A1_FILIAL = '"  + xFilial("SA1") + "' AND "
	Else
		cRngFilFL5 := GetRngFil(aSelFil, "FL5", .T., @cTmpFL5Fil)
		cRngFilSA1 := GetRngFil(aSelFil, "SA1", .T., @cTmpSA1Fil)

		cFilFL5 := " FL5.FL5_FILIAL " + cRngFilFL5 + " AND "
		cFilSA1 := " SA1.A1_FILIAL "  + cRngFilSA1 + " AND "
	EndIf

	cFilFL5 := "%" + cFilFL5 + "%"

	If MV_PAR07 == 2 //Nacional
		cWhere += "AND FL5.FL5_NACION = '1' "
	ElseIf MV_PAR07 == 3 //Internacional
		cWhere += "AND FL5.FL5_NACION = '2' "
	EndIf

	cWhere := "%" + cWhere + "%"

	MakeSQLExp(cPerg)

	// LEFT JOIN FL5 X SA1
	cJoinSA1 := " LEFT JOIN " + RetSQLName("SA1") + " SA1 ON " +;
		cFilSA1 + " SA1.A1_COD = FL5.FL5_CLIENT AND SA1.A1_LOJA = FL5.FL5_LOJA AND SA1.D_E_L_E_T_ = ' ' "
	
	// INNER JOIN FL5 x FL6
	cJoinFL6 := " INNER JOIN " + RetSQLName("FL6") + " FL6 ON " +;
		" FL6.FL6_FILIAL = FL5.FL5_FILIAL AND FL6.FL6_VIAGEM = FL5.FL5_VIAGEM AND FL6.D_E_L_E_T_ = ' ' "
	
	If (!Empty(MV_PAR16) .And. !Empty(MV_PAR17)) .Or. (Empty(MV_PAR16) .And. !VerParAte(MV_PAR17))
		cJoinFL6 += " AND FL6.FL6_PARTSO BETWEEN '" + MV_PAR16 + "' AND '" + MV_PAR17 + "' "
	EndIf

	//1. Se De/Ate em branco				= não necessário filtrar as tabelas FLF, FLH e FLJ
	//2. Se De em branco e Ate preenchido	= necessário filtrar as tabelas FLF, FLH e FJH (inner join)
	//3. Se De em branco e Ate ZZZZZZ		= não necessário filtrar as tabelas FLF, FLH e FLJ
	//4. Se De/Ate preenchidos				= necessário filtrar as tabelas FLF, FLH e FJH (inner join)

	// JOIN FL5 x FLH
	If (!Empty(MV_PAR14) .And. !Empty(MV_PAR15)) .Or. (Empty(MV_PAR14) .And. !(Empty(MV_PAR15)) .And. !VerParAte(MV_PAR15))
		cJoinFLH := " INNER JOIN " + RetSQLName("FLH") + " FLH ON " +;
			" FLH.FLH_FILIAL = FL5.FL5_FILIAL AND FLH.FLH_VIAGEM = FL5.FL5_VIAGEM AND FLH.D_E_L_E_T_ = ' ' " +;
			" AND FLH.FLH_CC BETWEEN '" + MV_PAR14 + "' AND '" + MV_PAR15 + "' "
	EndIf

	// JOIN FL5 x FLJ
	If (!Empty(MV_PAR08) .And. !Empty(MV_PAR09)) .Or. (Empty(MV_PAR08) .And. !(Empty(MV_PAR09)) .And. !VerParAte(MV_PAR09))
		cJoinFLJ := " INNER JOIN " + RetSQLName("FLJ") + " FLJ ON " +;
			" FLJ.FLJ_FILIAL = FL5.FL5_FILIAL AND FLJ.FLJ_VIAGEM = FL5.FL5_VIAGEM AND FLJ.D_E_L_E_T_ = ' ' " +;
			" AND FLJ.FLJ_PARTIC BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' "
	EndIf

	// JOIN FL5 x FLF - AND FLF.FLF_PARTIC BETWEEN exp:MV_PAR22 AND exp:MV_PAR23
	If (!Empty(MV_PAR22) .And. !Empty(MV_PAR23)) .Or. (Empty(MV_PAR22) .And. !(Empty(MV_PAR23)) .And. !VerParAte(MV_PAR23))
		cJoinFLF := " INNER JOIN " + RetSQLName("FLF") + " FLF ON " +;
			" FLF.FLF_FILIAL = FL5.FL5_FILIAL AND FLF.FLF_VIAGEM = FL5.FL5_VIAGEM AND FLF.D_E_L_E_T_ = ' ' " +;
			" AND FLF.FLF_PARTIC BETWEEN '" + MV_PAR22 + "' AND '" + MV_PAR23 + "' "

		If MV_PAR18 == 1 //Em Aberto
			cJoinFLF += " AND FLF.FLF_STATUS NOT IN ('8', '9') "  ///  8 e 9  - Finalizados e Encerrados
		ElseIf MV_PAR18 == 2 //Encerrado
			cJoinFLF += " AND FLF.FLF_STATUS IN ('8', '9') "
		EndIf
	EndIf

	cJoin	:= "%" + cJoinSA1 + cJoinFL6 + cJoinFLH + cJoinFLJ + cJoinFLF + "%" 

	///Query principal aonde sao considerados os Parametros do Relatório, exceção a Filial que também é considerada nas demais queries abaixo.
	BEGIN REPORT QUERY oSection //// Viagem

	BeginSql alias cAlsFL5//// Viagem
		SELECT
			FL5.FL5_FILIAL,FL5.FL5_VIAGEM, FL5.FL5_DESORI, FL5.FL5_DESDES, FL5.FL5_DTINI, FL5.FL5_DTFIM, FL5.FL5_STATUS, COALESCE(SA1.A1_NOME, '') A1_NOME, FL5.R_E_C_N_O_
		FROM
			%table:FL5% FL5
			%exp:cJoin%
		WHERE 
			%exp:cFilFL5%

			//Filtros FL5 - Viagem
			FL5.FL5_VIAGEM BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
		AND FL5.FL5_DTINI  BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
		AND FL5.FL5_CLIENT BETWEEN %exp:MV_PAR10% AND %exp:MV_PAR12%
		AND FL5.FL5_LOJA   BETWEEN %exp:MV_PAR11% AND %exp:MV_PAR13%
		AND FL5.FL5_DTFIM  BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
		AND FL5.%notDel%

		%exp:cWhere%

		GROUP BY FL5.FL5_FILIAL, FL5.FL5_VIAGEM, FL5.FL5_DESORI, FL5.FL5_DESDES, FL5.FL5_DTINI, FL5.FL5_DTFIM, FL5.FL5_STATUS, SA1.A1_NOME, FL5.R_E_C_N_O_
		ORDER BY FL5.FL5_FILIAL, FL5_VIAGEM
	EndSql

	END REPORT QUERY oSection//// Viagem

	oReport:SetMeter((cAlsFL5)->(RecCount()))
	FL5->(DbSetOrder(1))

	/// a partir da query principal, aonde se encontram as viagens, as demais tabelas(seções do Relatório) são filtradas a partir da VIAGEM posicionada, nas FILIAIS selecionadas ou logada.
	(cAlsFL5)->(DbGoTop())
	While (cAlsFL5)->(!EoF()) //// Viagem
		
		FL5->(DbGoTo((cAlsFL5)->R_E_C_N_O_)) //Posiciona na FL5 para utilização do cFiltro (Browse da rotina FINA665)
		If !(&(cFiltro))
			(cAlsFL5)->(DbSkip())
			Loop
		EndIf

		If !Empty(cNextV)
			oSection:Finish()
			oSection:SetPageBreak(.T.)
		EndIf

		///armazena a Viagem para filtrar as queries abaixo
		cViag := "%'" + (cAlsFL5)->FL5_VIAGEM + "'%"

		oSection:Init()
		oReport:IncMeter()
		oReport:SkipLine()

		oSection:PrintLine(.T.)

		/////Seleciona registros(Aéreo) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao1//// Aéreo

		BeginSql alias cAlsFL7//// Aéreo
			SELECT
				FL7.FL7_VIAGEM, FL7.FL7_NOME, FL7.FL7_ORIGEM, FL7.FL7_DESTIN, FL7.FL7_DSAIDA, FL7.FL7_DCHEGA
			FROM
				%table:FL7% FL7
			WHERE FL7.FL7_FILIAL = %exp:(cAlsFL5)->FL5_FILIAL%
			AND FL7.%notDel%
			AND FL7.FL7_VIAGEM = %exp:cViag%
		EndSql

		END REPORT QUERY oSessao1//// Aéreo

		oSessao1:Init()
		(cAlsFL7)->(DbGoTop())
		While (cAlsFL7)->(!EoF()) //// Aéreo
			oSessao1:PrintLine(.T.)
			cNextV := '*'
			(cAlsFL7)->(DbSkip())
		EndDo
		oSessao1:Finish()

		oReport:IncMeter()
		oReport:ThinLine()

		/////Seleciona registros(Hotel) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao2//// Hotel

		BeginSql alias cAlsFL9//// Hotel
			SELECT
					FL9.FL9_VIAGEM,FL9.FL9_NOME,FL9.FL9_DIARIA, FL9.FL9_DCHKIN ,FL9.FL9_HCHKIN ,FL9.FL9_DCHKOU ,FL9.FL9_HCHKOU
			FROM
				%table:FL9% FL9
			WHERE FL9.FL9_FILIAL = %exp:(cAlsFL5)->FL5_FILIAL%
			AND	FL9.%notDel%
			AND FL9.FL9_VIAGEM = %exp:cViag%
		EndSql

		END REPORT QUERY oSessao2//// Hotel

		oSessao2:Init()
		(cAlsFL9)->(DbGoTop())
		While (cAlsFL9)->(!EoF()) //// Hotel
			oSessao2:PrintLine(.T.)
			cNextV := '*'
			(cAlsFL9)->(DbSkip())
		EndDo
		oSessao2:Finish()

		/////Seleciona registros(Rodoviário) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao3//// Rodoviário

		BeginSql alias cAlsFL8//// Rodoviário
			SELECT
				FL8.FL8_VIAGEM,FL8.FL8_NOME,FL8.FL8_ORIGEM,FL8.FL8_DESTIN,FL8.FL8_DSAIDA,FL8.FL8_DCHEGA
			FROM
				%table:FL8% FL8
			WHERE FL8.FL8_FILIAL = %exp:(cAlsFL5)->FL5_FILIAL%
			AND	FL8.%notDel%
			AND FL8.FL8_VIAGEM = %exp:cViag%
		EndSql

		END REPORT QUERY oSessao3//// Rodoviário

		oSessao3:Init()
		(cAlsFL8)->(DbGoTop())
		While (cAlsFL8)->(!EoF()) //// Rodoviário
			oSessao3:PrintLine(.T.)
			cNextV := '*'
			(cAlsFL8)->(DbSkip())
		EndDo
		oSessao3:Finish()

		/////Seleciona registros(Locação de Veiculos) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao4//// Locação de Veiculos

		BeginSql alias cAlsFLB////  Locação de Veiculos
			SELECT
				FLB.FLB_VIAGEM,FLB.FLB_NOME,FLB.FLB_TIPVEI,FLB.FLB_DIARIA,FLB.FLB_DRETIR,FLB.FLB_DDEVOL
			FROM
				%table:FLB% FLB
			WHERE FLB.FLB_FILIAL = %exp:(cAlsFL5)->FL5_FILIAL%
			AND FLB.%notDel%
			AND FLB.FLB_VIAGEM = %exp:cViag%
		EndSql

		END REPORT QUERY oSessao4////  Locação de Veiculos

		oSessao4:Init()
		(cAlsFLB)->(DbGoTop())
		While (cAlsFLB)->(!EoF()) ////Locação de Veículos
			oSessao4:PrintLine(.T.)
			cNextV := '*'
			(cAlsFLB)->(DbSkip())
		EndDo
		oSessao4:Finish()

		/////Seleciona registros(Adiantamentos) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao5//// Adiantamentos

		BeginSql alias cAlsFLD////  Adiantamentos
			SELECT
					FLD.FLD_VIAGEM,RD0.RD0_NOME, FLD.FLD_VALOR, FLD.FLD_DTSOLI,FLD.FLD_DTPAGT,FLD.FLD_STATUS
			FROM
				%table:FLD% FLD ,
				%Table:RD0% RD0
			WHERE FLD.FLD_FILIAL = %exp:(cAlsFL5)->FL5_FILIAL%
			AND	RD0.RD0_FILIAL = %xfilial:RD0%
			AND FLD.%notDel%
			AND	RD0.%notDel%
			AND	FLD.%notDel%
			AND FLD.FLD_PARTIC = RD0.RD0_CODIGO
			AND FLD.FLD_VIAGEM = %exp:cViag%
		EndSql

		END REPORT QUERY oSessao5////  Adiantamentos

		oSessao5:Init()
		(cAlsFLD)->(DbGoTop())
		While (cAlsFLD)->(!EoF()) ////Adiantamentos
			oSessao5:PrintLine(.T.)
			cNextV := '*'
			(cAlsFLD)->(DbSkip())
		EndDo
		oSessao5:Finish()

		/////Seleciona registros(Prestacao de Contas) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao6//// Prestacao de Contas

		BeginSql alias cAlsFLF//// Prestacao de Contas
			SELECT
					RD0.RD0_NOME,FLF.FLF_VIAGEM, FLF.FLF_TDESP1, FLF.FLF_TDESP2, FLF.FLF_TDESP3,
					FLF.FLF_TVLRE1, FLF.FLF_TVLRE2,  FLF.FLF_TVLRE3, FLF.FLF_STATUS
			FROM
				%table:FLF% FLF ,
				%Table:RD0% RD0
			WHERE FLF.FLF_FILIAL =  %exp:(cAlsFL5)->FL5_FILIAL%
			AND	RD0.RD0_FILIAL = %xfilial:RD0%
			AND	FLF.%notDel%
			AND FLF.FLF_PARTIC = RD0.RD0_CODIGO
			AND FLF.FLF_VIAGEM = %exp:cViag%
		EndSql

		END REPORT QUERY oSessao6////  Prestacao de Contas

		oSessao6:Init()
		(cAlsFLF)->(DbGoTop())
		While (cAlsFLF)->(!EoF()) ////Prestação de Contas
			oSessao6:PrintLine(.T.)
			cNextV := '*'
			(cAlsFLF)->(DbSkip())
		EndDo
		oSessao6:Finish()

		/////Seleciona registros(Conferencia de Servicos) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao7//// Conferencia de Servicos

		BeginSql alias cAlsFLQ//// Conferencia de Servicos
			SELECT
				distinct SA2.A2_NOME,FLV.FLV_VIAGEM,FLQ.FLQ_CONFER,FLQ.FLQ_DATA,FLQ.FLQ_TOTAL,FLQ.FLQ_TPPGTO,
				Case when FLQ.FLQ_TPPGTO in ( '1','3') then FLQ.FLQ_NUMTIT ELSE FLQ.FLQ_PEDIDO  END DOCUMENTO
			FROM
				%table:FLQ% FLQ ,
				%table:FLV% FLV ,
				%Table:SA2% SA2
			WHERE FLV.FLV_FILIAL =  %exp:(cAlsFL5)->FL5_FILIAL%
			AND SA2.A2_FILIAL = %xfilial:SA2%
			AND	FLQ.%notDel%
			AND	FLV.%notDel%
			AND	SA2.%notDel%
			AND FLV.FLV_FILIAL =  FLQ.FLQ_FILIAL
			AND FLV.FLV_CONFER = FLQ.FLQ_CONFER
			AND FLQ.FLQ_FORNEC = SA2.A2_COD
			AND FLQ.FLQ_LOJA = SA2.A2_LOJA
			AND FLQ.FLQ_DATA BETWEEN %exp:MV_PAR19% AND %exp:MV_PAR20%
			AND FLV.FLV_VIAGEM = %exp:cViag%

		EndSql

		END REPORT QUERY oSessao7////  Conferencia de Servicos

		oSessao7:Init()
		(cAlsFLQ)->(DbGoTop())
		While (cAlsFLQ)->(!EoF()) ////Conferencia de Servicos
			oSessao7:PrintLine(.T.)
			cNextV := '*'
			(cAlsFLQ)->(DbSkip())
		EndDo
		oSessao7:Finish()

		/////Seleciona registros(Centro de Custo) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao8//// Centro de Custo

		BeginSql alias cAlsFLH//// Centro de Custo
			SELECT
				FLH.FLH_FILIAL, FLH.FLH_VIAGEM, FLH.FLH_CC, FLH.FLH_PORCEN
			FROM
				%table:FLH% FLH
			WHERE FLH.FLH_FILIAL = %exp:(cAlsFL5)->FL5_FILIAL%
			AND	FLH.%notDel%
			AND FLH.FLH_VIAGEM = %exp:cViag%
		EndSql

		END REPORT QUERY oSessao8//// Centro de Custo

		oSessao8:Init()
		(cAlsFLH)->(DbGoTop())
		While (cAlsFLH)->(!EoF()) ////Centro de Custo
			oSessao8:PrintLine(.T.)
			cNextV := '*'
			(cAlsFLH)->(DbSkip())
		EndDo
		oSessao8:Finish()

		/////Seleciona registros(Aprovadores) para aquela viagem/Filial dentro do laço(while)
		BEGIN REPORT QUERY oSessao9//// Aprovadores

		BeginSql alias cAlsFLJ////Aprovadores
			SELECT
				FLJ.FLJ_VIAGEM,FLJ.FLJ_NOME,FLJ.FLJ_EMAIL
			FROM
				%table:FLJ% FLJ
			WHERE FLJ.FLJ_FILIAL = %exp:(cAlsFL5)->FL5_FILIAL%
			AND	FLJ.%notDel%
			AND FLJ.FLJ_VIAGEM = %exp:cViag%
		EndSql

		END REPORT QUERY oSessao9////Aprovadores

		oSessao9:Init()
		(cAlsFLJ)->(DbGoTop())
		While (cAlsFLJ)->(!EoF()) ////Aprovadores
			oSessao9:PrintLine(.T.)
			cNextV := '*'
			(cAlsFLJ)->(DbSkip())
		EndDo
		oSessao9:Finish()

	(cAlsFL5)->(DbSkip())
	EndDo

	oSection:Finish()
	(cAlsFL5)->(DbCloseArea())

Return Nil

/*/{Protheus.doc} FINR665STA
Função para identificar a descrição do status da prestação de contas

@author Alexandre Felicio
@since 04/09/2015
@version P12 R12.1.7

@return Nil
/*/
User Function FINR665STA(cStatus)

	Local cDescStat := ""

	Default cStatus := ""

	Do Case
		Case cStatus == "1"
			cDescStat := STR0013 //"Em aberto"

		Case cStatus == "2"
			cDescStat := STR0014 //"Em conferência"

		Case cStatus == "3"
			cDescStat := STR0015 //"Com bloqueio"

		Case cStatus == "4"
			cDescStat := STR0016 //"Em avaliação"

		Case cStatus == "5"
			cDescStat := STR0017 //"Reprovada"

		Case cStatus == "6"
			cDescStat := STR0018 //"Aprovada"

		Case cStatus == "7"
			cDescStat := STR0019 //"Liberado pagto"

		Case cStatus == "8"
			cDescStat := STR0020 //"Finalizada"

		Case cStatus == "9"
			cDescStat := STR0021 //"Encerrados"
	EndCase

Return cDescStat

/*/{Protheus.doc} VerParAte
Valida se o parâmetro informado está como "ZZZZZZ" (fim da tabela)

@author 	Rafael Riego
@since	 	08/03/2021
@param		cParamAte, character, parâmetro ATE
@return 	logical, verdadeiro caso seja ZZZZZZ
/*/
Static Function VerParAte(cParamAte As Character) As Logical

	Local lIsZZZZZZZ	As Logical

	Default cParamAte	:= ""

	lIsZZZZZZZ := .F.

	If !(Empty(cParamAte)) .And. Empty(AllTrim(StrTran(Upper(cParamAte), "Z", "")))
		lIsZZZZZZZ := .T.
	EndIf

Return lIsZZZZZZZ
