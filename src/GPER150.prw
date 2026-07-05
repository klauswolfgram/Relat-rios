/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GPER150.CH"
#INCLUDE "REPORT.CH" 
#INCLUDE "PROTHEUS.CH"
/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER150  ³ Autor ³ R.H. - Marcos Stiefano³ Data ³ 08.07.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao Liquidos ITAU                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER150(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sidney O    ³03/12/13³184704³Ajustes de adequação para a P12           ³±±
±±³            ³        ³      ³Remoção de funções de relatório modelo R3 ³±±
±±³            ³        ³      ³Remoção do AjustaSX1()                    ³±±
±±³Flavio Corr ³25/08/14³TQIDUL³Utilização da Pergunta MV_PAR026          ³±±
±±³Gustavo M   ³27/05/16³TVFFAD³Ajuste para respeitar o acesso do usuario.³±±
±±³Isabel N.  ³04/01/17³MRH4197³Ajuste nos nomes dos campos com mais de 10³±±
±±³           ³        ³       ³caracteres (RA_CTDEPSAL p/ RA_CTDEPSA e   ³±±
±±³           ³        ³       ³RA_BCDEPSAL p/ RA_BCDEPSA) conforme ATUSX.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER150()

	Local oReport 

	Private cDescImpr	:= ""
	Private cAgencia	:= ""     
	Private cContacc	:= ""
	Private cDac		:= ""      
	Private cAliasSRA	:= "SRA"
	Private dDtPgto		:= CtoD("//")
	Private aInfo		:= Array( 26 )

	Private cProcesso
	Private cRot
	Private aRoteiros	:= {}
	Private lValidFil		:= .T.
	//-- Inicializacao do conteudo de aInfo para a impressao do cabecalho sem informacoes 
	//-- quando o filtro realizado nos parametros nao retornar nenhum funcionario.
	Afill(aInfo,"")
	aInfo[15] := 0

	//-- Interface de impressao
	Pergunte("GP0150R",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()

Return
	
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ R.H. - Tatiane Matias ³ Data ³ 30.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do relatorio                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport 
Local oSection1
Local oSection2
Local oSection3
Local oBreak

Local cDesc	:=	STR0001 + oemtoAnsi(STR0053)  //"Rela‡„o Liquidos ITAU    " # Esta rotina efetua a impressao dos valores liquidos que serao pagos atraves do Banco Itau"
Local aOrd	:= {STR0004,;	//"Filial+Bco+Mat"
				STR0005,;	//"Filial+Bco+Cc+Mat"
				STR0006,;	//"Filial+Bco+Nome"
				STR0007,;	//"Filial+Bco+Cta"
				STR0008,;	//"Filial+Bco+Cc+Nome"					
				STR0009,;	//"Bco+Mat"
				STR0010,;	//"Bco+Cc+Mat"
				STR0011,;	//"Bco+Nome"
				STR0012,;	//"Bco+Cta"
				STR0013 }   //"Bco+Cc+Nome"

	//-- Relatorio
	oReport:= TReport():New("GPER150",OemToAnsi(STR0016),"GP0150R",{|oReport| GR150Imp(oReport)}, cDesc)

	oReport:SetTotalInLine(.F.)
	oReport:PageTotalInLine(.F.)
	oReport:PageTotalText(STR0021)
	oReport:PageTotalBefore(.T.) 
                     
		//-- Section 1
		//-- Forma Pagto Empresa                        Ag/Conta/Dac   CNPJ           Folha 
		//-- ------------------------------------------------------------------------------
		//--   01        											1024/42229 /5                 001
		oSection1:= TRSection():New(oReport,STR0041,{},aOrd)
		
			//-- Celulas
			TRCell():New(oSection1,"FORMAPAG","   ", oemToAnsi(STR0048),,12,, {|| "01" })									//-- "Forma Pagto"
			TRCell():New(oSection1,"EMPRESA" ,"   ", oemToAnsi(STR0049),,32,, {|| Subs(aInfo[3]+Space(40),1,30) }) 		//-- "Empresa"
			TRCell():New(oSection1,"AGCCDAC" ,"   ", oemToAnsi(STR0050),,15,, {|| cAgencia +"/"+ cContacc +"/"+ cDac })	//-- "Ag/Conta/Dac"
			TRCell():New(oSection1,"CGC"     ,"   ", oemToAnsi(STR0051),,16,, {|| aInfo[8] })								//-- "CNPJ"
			TRCell():New(oSection1,"FOLHA"   ,"   ", oemToAnsi(STR0034),,,, {|| Strzero(oReport:Page(),4) })				//-- "Folha"

		//-- Section 2
		//-- No de Ordem  Data Pgto   Tipo Pgto  Finalidade do Pagamento 
		//-- ------------------------------------------------------------
		//--    01        31/12/04     03        PAGAMENTO DE SALARIOS
		oSection2:= TRSection():New(oReport,STR0042,{},aOrd)
		
			//-- Celulas
			TRCell():New(oSection2,"NORDEM","   ", oemToAnsi(STR0044),,13,, {|| "01" })						//--"No de Ordem"
			TRCell():New(oSection2,"DTPGTO","   ", oemToAnsi(STR0045),,12,, {|| PADR(DtoC(dDtPgto),10) })	//--"Data Pgto"
			TRCell():New(oSection2,"TPPGTO","   ", oemToAnsi(STR0046),,12,, {|| "03" })						//--"Tipo Pgto"
			TRCell():New(oSection2,"FINALID","   ",oemToAnsi(STR0047) ,,,, {|| cDescImpr })					//--"Finalidade do Pagamento"
		
		//-- Section 3
		oSection3:= TRSection():New(oReport,STR0043,{"SRA"},aOrd)
		oSection3:SetTotalInLine(.F.)
		
			//-- Celulas
			TRCell():New(oSection3,"RA_NOME","SRA")
			TRCell():New(oSection3,"BANCO"	,"   ", oemToAnsi(STR0050),                        , 20,, {|| Substr( SRA->RA_BCDEPSA,4,5) + "/" + SRA->RA_CTDEPSA})		//--"Agencia/Conta/Dac"
			TRCell():New(oSection3,"VALOR"	,"   ", oemToAnsi(STR0052), "@e 999,999,999,999.99", 17)																		//--"Valor"
   
		//-- Totalizador
		TRFunction():New(oSection3:Cell("VALOR"),,"SUM",,,,,.F.,.T.,.T.)
			
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER150  ³ Autor ³ R.H. - Tatiane Matias ³ Data ³ 30.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao Liquidos ITAU - relatorio personalizavel           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GR150Imp(oReport)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Objeto
Local oSection1		:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local oSection3 	:= oReport:Section(3)

//-- String
Local cMesArqRef 	:= StrZero(Month(dDataBase),2) + StrZero(Year(dDataBase),4)
Local cArqMov    	:= ""
Local cAliasMov 	:= ""
Local cIndCond		:= ""
Local cFiltro		:= ""
Local cParBanco		:= ""
Local cParConta		:= ""
Local cCabec1		:= ""
Local cCabec2		:= ""
Local cCabec3		:= ""
Local cSitQuery		:= ""
Local cCatQuery		:= ""  
Local cOrdem		:= ""
Local cRCName

//-- Array
Local aOrdBag		:= {}
Local aValBenef  	:= {}
Local aCodFol    	:= {}
Local aPerLiq		:= {}

//-- Numerico
Local nOrdem		:= oReport:Section(1):GetOrder()
Local nPos			:= 0
Local nValor		:= 0
Local nCntP			:= 0
Local nReg			:= 0
Local nX			:= 0
Local nValLiq		:= 0

Local cTipoCalc		:= ""
Local cAddVerba		:= ""

Local lPerLiq		:= .F.

Local nFunBenAmb


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de Acesso do Usuario                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cAcessaSRA	:= &( " { || " + ChkRH( "GPER150" , "SRA" , "2" ) + " } " )
Private cAcessaSRC	:= &( " { || " + ChkRH( "GPER150" , "SRC" , "2" ) + " } " )
Private cAcessaSRD	:= &( " { || " + ChkRH( "GPER150" , "SRD" , "2" ) + " } " )
Private cAcessaSRG	:= &( " { || " + ChkRH( "GPER150" , "SRG" , "2" ) + " } " )
Private cAcessaSRH	:= &( " { || " + ChkRH( "GPER150" , "SRH" , "2" ) + " } " )
Private cAcessaSRR	:= &( " { || " + ChkRH( "GPER150" , "SRR" , "2" ) + " } " )
//
Private dDataDe := cToD("//")
Private dDataAte := cToD("//")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Carrega parametros da pergunte                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cProcesso	:= MV_PAR01
	cRot		:= MV_PAR02
	dPerDe		:= MV_PAR03
	cPagDe		:= MV_PAR04
	dPerAte		:= MV_PAR05
	cPagAte		:= MV_PAR06
	cFilDe		:= MV_PAR07
	cFilAte		:= MV_PAR08
	nFinalPgto	:= MV_PAR09
	cCCDe		:= MV_PAR10
	cCCAte		:= MV_PAR11
	cAgencia	:= MV_PAR12
	cContaCC	:= MV_PAR13
	cBancAgDe	:= MV_PAR14
	cBancAgAte	:= MV_PAR15
	cMatDe		:= MV_PAR16
	cMatAte		:= MV_PAR17
	cNomeDe		:= MV_PAR18
	cNomeAte	:= MV_PAR19
	cDac		:= MV_PAR20
	cCntCorDe	:= MV_PAR21
	cCntCorAte	:= MV_PAR22
	cSituacao	:= MV_PAR23
	cCategoria	:= MV_PAR24
	nFunBenAmb	:= MV_PAR25
	cFinalPgto	:= MV_PAR26
	dDataDe		:= MV_PAR27
	dDataAte	:= MV_PAR28
	dDtPgto		:= MV_PAR29	                  

    /* 
	// Data de Pagamento MV_PAR29 não deve possuir consistências pois trata-se apenas de impressão.
    If dDtPgto < dDataDe .Or. dDtPgto > dDataAte
		//"Atenção"###"Data de Pagamento está fora da Data de Pagamento De/Até informado, verificar as configurações informadas."
		Aviso(OemToAnsi(STR0054), OemToAnsi(STR0056), {"OK"})	
		Break
	EndIf
    */

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Define as celulas da section 4                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nFinalPgto == 1
		oSection3:Cell("BANCO"):Disable()		
	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Monta os cabecalhos                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCabec1 := STR0024 + "          " + IIf(nFinalPgto == 1, STR0025, STR0026 + "   ") + " " + STR0027

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define se devera ser impresso Funcionarios ou Beneficiarios  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SRQ" )
	lImprFunci  := ( nFunBenAmb # 2 )
	lImprBenef  := ( nFunBenAmb # 1 )

	dbSelectArea("SRY")
	If( dbSeek(xFilial("SRY")+cRot) )
		cTipoCalc := SRY->RY_TIPO

		Do Case
			Case cTipoCalc $ "1/9/7" 	// Folha de Pagto
				cAddVerba 	:= fGetCodFol("0047")
				cDescImpr	:= STR0034  //"Folha"
			Case cTipoCalc == "2"  //Adiantamento
				cAddVerba 	:= fGetCodFol("0546")
				cDescImpr	:= STR0033  //"Adiantamento"
			Case cTipoCalc == "3"  // Ferias
				cAddVerba 	:= fGetCodFol("0102")
				cDescImpr	:= STR0037  //"Ferias"
			Case cTipoCalc == "4"  // Rescisao
				cAddVerba	:= fGetCodFol("0126")
				cDescImpr	:= cDescImpr + STR0039  //"Rescisao"
			Case cTipoCalc == "5" .And. cPaisLoc == "BRA"  // 1a parcela 13o Salario
				cAddVerba 	:= fGetCodFol("0678")
				cDescImpr	:= STR0035  //"1a.parc 13º"
			Case cTipoCalc == "6" .Or. cTipoCalc == "5" // 2a parcela 13o Salario
				cAddVerba	:= fGetCodFol("0021")
				cDescImpr	:= STR0036  //"2a.parc 13º"
				If cTipoCalc == "6" .And. cPaisLoc $ "VEN"
					cAddVerba	:= fGetCodFol("1021")
				ElseIf cTipoCalc == "5" .And. cPaisLoc $ "VEN"
					cAddVerba	:= fGetCodFol("1022")
				EndIf			
			Case cTipoCalc == "A"  //Aplicacao de Rescisao - Mex
				cAddVerba	:= fGetCodFol("0126")
			Case cTipoCalc == "F"  // PLR
				cAddVerba	:= fGetCodFol("0836")
			Case cTipoCalc == "K"  // Valores Extras
				cAddVerba	:= fGetCodFol("1411")
		EndCase		
	EndIf
	
	If !Empty( cFinalPgto )
		cDescImpr := cFinalPgto
	EndIf      
	
	Aadd(aRoteiros, {cRot, cTipoCalc, cAddVerba} )

	cAliasSRA := GetNextAlias()	
	
	//--Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr("GP0150R")
	
	//-- Modifica variaveis para a Query
	For nReg:=1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cSituacao)
			cSitQuery += "," 
		EndIf
	Next nReg     
	cSitQuery := "%" + cSitQuery + "%"
	
	cCatQuery := ""
	For nReg:=1 to Len(cCategoria)
		cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cCategoria)
			cCatQuery += "," 
		EndIf
	Next nReg
	cCatQuery := "%" + cCatQuery + "%"

	If !Empty(cFiltro:=oSection3:GetSQLExp())
       	cFiltro := "% AND " + cFiltro + "%"
	Else
       	cFiltro := "%%"
	EndIf

	If nOrdem == 1
		cOrdem += "%SRA.RA_FILIAL, SRA.RA_BCDEPSA,SRA.RA_MAT%"
	ElseIf nOrdem == 2
		cOrdem += "%SRA.RA_FILIAL, SRA.RA_BCDEPSA, SRA.RA_CC, SRA.RA_MAT%"
	ElseIf nOrdem == 3
		cOrdem += "%SRA.RA_FILIAL, SRA.RA_BCDEPSA, SRA.RA_NOME%"
	Elseif nOrdem == 4
		cOrdem += "%SRA.RA_FILIAl, SRA.RA_BCDEPSA, SRA.RA_CTDEPSA%"
	ElseIf nOrdem == 5
		cOrdem += "%SRA.RA_FILIAL, SRA.RA_BCDEPSA, SRA.RA_CC, SRA.RA_NOME%"
	ElseIf nOrdem == 6
		cOrdem += "%SRA.RA_BCDEPSA, SRA.RA_MAT%"
	ElseIf nOrdem == 7
		cOrdem += "%SRA.RA_BCDEPSA, SRA.RA_CC, SRA.RA_Mat%"
	Elseif nOrdem == 8
		cOrdem += "%SRA.RA_BCDEPSA, SRA.RA_NOME%"
	ElseIf nOrdem == 9
		cOrdem += "%SRA.RA_BCDEPSA, SRA.RA_CTDEPSA%"
	ElseIf nOrdem == 10
		cOrdem += "%SRA.RA_BCDEPSA, SRA.RA_CC, SRA.RA_NOME%"
	EndIf
	
	dbSelectArea( "SRA" )

	oSection1:BeginQuery()

		BeginSql alias cAliasSRA

	    	SELECT SRA.*
				FROM %table:SRA% SRA
			WHERE  SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%) AND
				   SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%) AND
				   SRA.RA_PROCES = %exp:cProcesso% AND
				   SRA.RA_FILIAL >= %exp:cFilDe% AND SRA.RA_FILIAL <= %exp:cFilAte% AND
				   SRA.RA_CC >= %exp:cCCDe% AND SRA.RA_CC <= %exp:cCCAte% AND
				   SRA.RA_NOME >= %exp:cNomeDe% AND SRA.RA_NOME 	<= %exp:cNomeAte% AND
				   SRA.RA_MAT >= %exp:cMatDe% AND SRA.RA_MAT <= %exp:cMatAte% AND
				   SRA.RA_BCDEPSA >= %exp:cBancAgDe% AND SRA.RA_BCDEPSA	 <= %exp:cBancAgAte% AND
				   SRA.RA_CTDEPSA >= %exp:cCntCorDe% AND SRA.RA_CTDEPSA	<= %exp:cCntCorAte% AND
 				   SRA.%notDel%     
			   	   %exp:cFiltro%
			ORDER BY %exp:cOrdem%

		EndSql
		
	/*
	Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
	parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
	pela funcao MakeSqlExpr para serem adicionados a query
	*/
	oSection1:EndQuery()
	//->Verificar-> oSection1:EndQuery({mv_par13,mv_par14,mv_par15,mv_par16,mv_par17,mv_par18})
	
	oSection2:SetParentQuery()
	oSection3:SetParentQuery()

	FilAnt   := Space(FWGETTAMFILIAL)

	//-- Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter((cAliasSRA)->( RecCount() ))  
	
	oReport:OnPageBreak({|| fCabec(oReport,cCabec1)})

	//-- Rodape
	oReport:SetPageFooter(3,{|| oReport:PrintText(STR0040), oReport:PrintText(STR0019), oReport:PrintText(STR0020) }, .F.)
	
	//-- Incializa impressão   
	oSection3:Init()

	//Impressao de cada funcionario e seus beneficiarios
	While (cAliasSRA)->( !EOF() )
                   
		//-- Incrementa a régua da tela de processamento do relatório
  		oReport:IncMeter()
                                
		//-- Verifica se o usuário cancelou a impressão do relatorio
		If oReport:Cancel()
			Exit
		EndIf               
      
		nValor    	:= 0
		aValBenef 	:= {}
		aPerLiq		:= {}
		nValLiq		:= 0


		If	(cAliasSRA)->RA_FILIAL # FilAnt
			If	!FP_CODFOL(@aCodFol,(cAliasSRA)->RA_FILIAL) .Or. !fInfo(@aInfo,(cAliasSRA)->RA_FILIAL)
				Exit
			EndIf
			
			lValidFil := .T.
			
			FilAnt := (cAliasSRA)->RA_FILIAL
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste controle de acessos e filiais validas               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !((cAliasSRA)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
				(cAliasSRA)->( dbSkip() )
				lValidFil := .F.
				Loop
			EndIf
		EndIf
		
		If !lValidFil
			(cAliasSRA)->( dbSkip() )
			Loop		
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciono a matric.no SRA quando estiver usando Top Connect  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SRA->(RA_FILIAL+RA_MAT) != (cAliasSRA)->(RA_FILIAL+RA_MAT)
			SRA->(DbSetOrder(1))
			SRA->(DbSeek((cAliasSRA)->(RA_FILIAL+RA_MAT)))
		EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Busca os valores de Liquido e Beneficios                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cRCName := If( Empty(cAliasMov)	, NIL, cArqMov	)


		// Seleciono todos os períodos envolvidos de acordo com os parâmetros
		lPerLiq	:= fGetPerRange(xFilial("RCH",(cAliasSRA)->(RA_FILIAL)), @aPerLiq)
		If lPerLiq	
		
			For nX := 1 to Len(aPerLiq)

                If aPerLiq[nX][6] <= DtoS(dDataAte) .AND. aPerLiq[nX][6] >= DtoS(dDataDe) .Or. (aPerLiq[nX][4] $ "FER|RES")

                    nValLiq  := 0 
                    cNumPag	 := aPerLiq[nX][5]		

                    If !(aPerLiq[nX][4] $ "FER|RES")
                        dDataDe  := SToD(aPerLiq[nX][6])
                        dDataAte := SToD(aPerLiq[nX][6])
                    Endif

                    Gp020BuscaLiq(@nValLiq, @aValBenef, cAddVerba, cNumPag,(cAliasSRA)->RA_FILIAL,(cAliasSRA)->RA_MAT)
                    nValor += nValLiq

                    // Retorna variáveis aos seus valores originais.
                    dDataDe	 := MV_PAR27
                    dDataAte := MV_PAR28
                Endif
			Next nX
		else
			Aviso(OemToAnsi(STR0054), OemToAnsi(STR0057), {"OK"}) //"Periodos ou Numeros de Pagamento invalidos, verifique as configurações informadas. Selecione os periodos através da consulta padrão"			
			Return
		EndIf


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste parametros de banco e conta do beneficiario 		 ³
		//³ aValBenef: 1-Nome  2-Banco  3-Conta  4-Verba  5-Valor  6-CPF ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		//-- Para fazer o aEval no array aBenefCop, foi preciso criar os campos com 
		//-- X[2] ou X[3] ou .T., caso esteja vazio. 
		//-- Ex: (X[3] >= "000000000001" .AND. X[3] <= "999999999999")
		//-- ou
		//-- (.T. .AND. X[3] <= "999999999999")

		If Len(aValBenef) > 0
			aBenefCop  := aClone(aValBenef)
			aValBenef  := {}   
			                 
			If !Empty(cBancAgDe)
				cBAD := 'X[2] >= "' + cBancAgDe + '"'
			Else 
				cBAD := '.T.'
			EndIf
			
			If !Empty(cBancAgAte)
				cBAA := 'X[2] <= "' + cBancAgAte + '"'
			Else 
				cBAA := '.T.'
			EndIf
			
			If !Empty(cCntCorDe)
				cCCD := 'X[3] >= "' + cCntCorDe + '"'
			Else 
				cCCD := '.T.'
			EndIf
			
			If !Empty(cCntCorAte)
				cCCA := 'X[3] <= "' + cCntCorAte + '"'
			Else 
				cCCA := '.T.'
			EndIf
			
			&('Aeval(aBenefCop, { |X| If( ('+cBAD+' .AND. '+cBAA+') .And. ( '+cCCD+' .AND. '+cCCA+'), AADD(aValBenef, X), "" ) })')
		
		EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ 1- Testa Situacao do Funcionario na Folha                    ³
		//³ 2- Testa Categoria do Funcionario na Folha                   ³
		//³ 3- Testa  se Valor == 0                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( nValor == 0 .And. Len(aValBenef) == 0 )
			(cAliasSRA)->( dbSkip() )
			Loop
		Endif
	
		//-- Atualiza campo valor
	   oSection3:Cell("VALOR"):SetValue(nValor)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a linha                                        		 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection3:PrintLine()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao dos Beneficiarios                          		 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nCntP := 1 To Len(aValBenef) 
			If !Empty(aValBenef[nCntP,1]) .And. aValBenef[nCntP,5] > 0

				//-- Atualiza campo valor
	   			oSection3:Cell("RA_NOME"):SetValue("- " + aValBenef[nCntP,1])
	   			oSection3:Cell("VALOR"):SetValue(aValBenef[nCntP,5])
				If nFinalPgto <> 1
		   			oSection3:Cell("BANCO"):SetValue(Substr(aValBenef[nCntP,2],4,5) + "/" + aValBenef[nCntP,3])  
		  		EndIf
	   		
				oSection3:PrintLine()        
		
				oSection3:Cell("RA_NOME"):SetValue()
				oSection3:Cell("BANCO"):SetValue()  
				oSection3:Cell("BANCO"):SetBlock({|| Substr( (cAliasSRA)->RA_BCDEPSA,4,5) + "/" +(cAliasSRA)->RA_CTDEPSA})
				oSection3:Cell("VALOR"):SetValue()

			EndIf
		Next nCntP
		
		(cAliasSRA)->( dbSkip() )
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza impressao inicializada pelo metodo Init             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection3:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Termino do relatorio                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SRA" )

	Set Filter To
	RetIndex( "SRA" )
	dbSetOrder(1)
	
Return NIL

Static Function fCabec(oReport, cCabec1)  

Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)

If lValidFil
	oReport:PrintText(cCabec1)
	oReport:ThinLine()
	oSection1:Init()
	oSection1:PrintLine()
	oSection1:Finish()
	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()
	oReport:SkipLine()
Endif

Return NIL


/*/{Protheus.doc} fGetPerRange
Retorna Data de Pagamento + Número de Pagamento de Períodos Informados
@author raquel.andrade
@since 12/08/2022
@version 1.0
/*/
Static Function fGetPerRange(cFilRCH,aPerLiq)
Local aArea		:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cFromTable := "% " + RetSqlName("RCH") + " RCH %"
Local cWhere	:= ""
Local lRet		:= .F.

DEFAULT cFilRCH	:= xFilial("RCH")
DEFAULT aPerLiq	:= {}

cWhere := "%"
cWhere += " RCH.RCH_FILIAL = '" + cFilRCH + "' AND "
cWhere += " RCH.RCH_PROCES  = '" + cProcesso + "' AND "
cWhere += " RCH.RCH_PER BETWEEN '" + dPerDe + "' AND '" + dPerAte + "' AND "
cWhere += " RCH.RCH_ROTEIR = '" + cRot + "' AND "
cWhere += " RCH.RCH_NUMPAG BETWEEN '" + cPagDe + "' AND '" + cPagAte + "' AND "
cWhere += "%"

BeginSql alias cAliasQry
	SELECT RCH.RCH_FILIAL, RCH.RCH_PROCES,  RCH.RCH_PER , RCH.RCH_ROTEIR, RCH.RCH_NUMPAG, RCH.RCH_DTPAGO,
		   RCH.RCH_DTINI, RCH.RCH_DTFIM
	FROM
			%exp:cFromTable%
	WHERE
		 	%exp:cWhere%
			RCH.%NotDel%
			ORDER BY RCH.RCH_FILIAL, RCH.RCH_PROCES,  RCH.RCH_PER , RCH.RCH_ROTEIR, RCH.RCH_NUMPAG
		 	
EndSql

While (cAliasQry)->( !Eof() )
	aAdd(aPerliq,{(cAliasQry)->RCH_FILIAL,;
	 			  (cAliasQry)->RCH_PROCES,;
				  (cAliasQry)->RCH_PER ,;
				  (cAliasQry)->RCH_ROTEIR,;
				  (cAliasQry)->RCH_NUMPAG,;
				  (cAliasQry)->RCH_DTPAGO,; 
				  (cAliasQry)->RCH_DTINI,;
				  (cAliasQry)->RCH_DTFIM, })
	(cAliasQry)->(DbSkip())
EndDo

If Len(aPerliq) > 0 
	lRet := .T.
EndIf

(cAliasQry)->(dbCloseArea())

RestArea(aArea)
	
Return lRet
