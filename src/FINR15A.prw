/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"        
#Include "FINR15A.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR15A  ³ Autor ³ Lucas                   ³ Data ³ 15.03.00   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Titulos a Pagar                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR15A(void)                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Argentina                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ FECHA  ³   BOPS  ³  MOTIVO DE LA ALTERACION                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Joao          ³31.05.00³xxxxxx   ³Alteracao do Programa para Contas a Pagar³±±
±±³Paulo Augusto ³06.07.06³xxxxxx   ³Conversao para o release 4               ³±±
±±³   Marco A.   ³08/12/16³SERINN001³ Se aplica CTREE para evitar la creacion ³±±
±±³              ³        ³-133     ³ de tablas temporales de manera fisica   ³±±
±±³              ³        ³         ³ en system. (ARG)                        ³±±
±±³Dora Vega     ³16.03.17³ MMI-254 ³ Merge de Replica del llamado TVCCOX.    ³±±
±±³              ³        ³         ³Cambios en funcion GrvSldXXX al generar  ³±±
±±³              ³        ³         ³el reporte, error con proveedores. (ARG) ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FINR15A()

	Local oReport	:= Nil

	Private lImpGraf	:= .F.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atendimento ao requisito Operatoria 1 - Determina se ³
	//³ a empresa trabalha com Inspecao de Qualidade.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private lInspCQ		:= GetNewPar("MV_FINCQ", .F.)
	Private lOperat1	:= .T.

	If (cPaisLoc == "ARG") .And. lInspCQ
		lOperat1 := .T. 
	Else
		lOperat1 := .F. 
	EndIf

	If TRepInUse() 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lImpGraf	:= .T.
		oReport		:= ReportDef()
		oReport:PrintDialog()
	Else
		U_FINR15AR3()
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Augusto          ³ Data ³28/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

	Local oReport	:= Nil
	Local oSection1	:= Nil
	Local cReport	:= "FINR15A"
	Local cTitulo	:= OemToAnsi(STR0004) 
	Local cDescri	:= OemToAnsi(STR0001) + " " + OemToAnsi(STR0002) + OemToAnsi(STR0003)

	//--- Tamanho de Celulas
	Local nTamE2Forn  := TamSx3("E2_FORNECE")[1]+TamSx3("E2_LOJA")[1]+1
	Local nTamA2Nome  := 15
	Local nTamE2Pref  := TamSx3("E2_PREFIXO")[1]+TamSx3("E2_NUM")[1]+TamSx3("E2_PARCELA")[1]+10
	Local nTamE2Saldo := 14
	Local nTamSalAtu  := 14
	Local nTamE2Valor := 14
	Local nTamTitVenc := 12
	Local nTamE2Acres := 9
	Local nTamAtraso  := 4
	Local nTamSalFin  := 14

	Pergunte("FIN15A" , .F.)

	oReport := TReport():New( cReport, cTitulo, "FIN15A", {|oReport| ReportPrint(oReport, "TRB")}, cDescri)

	oReport:SetLandScape()         
	oReport:lDisableOrientation := .T.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1 := TRSection():New( oReport,STR0070, {"TRB","SA2","SED"},{OemToAnsi(STR0027 ),OemToAnsi(STR0028),OemToAnsi(STR0029 )},/*Campos do SX3*/,/*Campos do SIX*/)    
	oSection1:SetTotalInLine(.T.)                                                                                                                                                                                                                                                       
	oReport:SetTotalInLine(.F.)                                                                                                                                                                                                                                                         

	TRCell():New(oSection1, "E2_FORNECE"	, "SE2", /*X3Titulo()*/							, /*Picture*/, nTamE2Forn  , /*lPixel*/ , {|| TRB->CODIGO + " " + TRB->LOJA}) 
	TRCell():New(oSection1, "A2_NOME"		, "SA2", /*X3Titulo()*/							, /*Picture*/, nTamA2Nome  , /*lPixel*/ , {|| TRB->FORNECE})	  
	TRCell():New(oSection1, "E2_PREFIXO" 	, "SE2", STR0048 + CHR(13)+CHR(10) + STR0049	, /*Picture*/, nTamE2Pref  , /*lPixel*/ , {|| TRB->PREFIXO + Trans(TRB->NUMERO,"@R /9999999999999") + " " + TRB->PARCELA})	
	TRCell():New(oSection1, "E2_TIPO"    	, "SE2", /*X3Titulo()*/							, /*Picture*/, /*Tamanho*/ , /*lPixel*/ , {|| IIf( AllTrim(TRB->TIPO) $ "NF", "FT", TRB->TIPO)})	              
	TRCell():New(oSection1, "E2_NATUREZ"	, "SE2", /*X3Titulo()*/							, /*Picture*/, TamSx3("E2_NATUREZ")[1] + 5, /*lPixel*/, {|| AllTrim(MascNat(TRB->NATUREZA))})                                            

	If lOperat1
		TRCell():New(oSection1, "LIBCQ", "   ", STR0071 + CHR(13)+CHR(10) + STR0072	, "@!", 2, /*lPixel*/, {|| PrtnCQ(TRB->NUMERO, TRB->PREFIXO, TRB->CODIGO, TRB->LOJA)})    
	EndIf

	TRCell():New(oSection1, "E2_EMIS"			, "SE2", STR0052 + CHR(13)+CHR(10) + STR0053	, /*Picture*/, nTamTitVenc, /*lPixel*/, {|| TRB->EMISSAO}) 
	TRCell():New(oSection1, "E2_VENCTO"		, "SE2", /*X3Titulo()*/												, /*Picture*/, nTamTitVenc, /*lPixel*/, {|| IIf( TRB->VENCTO == dDataBase, OemToAnsi(STR0034), TRB->VENCTO)}) 
	TRCell():New(oSection1, "E2_VENCREA"	, "SE2", STR0054 + CHR(13)+CHR(10) + STR0055	,				 , nTamTitVenc, /*lPixel*/, {|| TRB->VENCREA}) 

	If lOperat1
		TRCell():New( oSection1, "VALCQ"		,"   " 	, STR0077                               , PesqPict("SE2","E2_VALOR") , nTamE2Saldo , /*lPixel*/ , {|| PrtVlCQ( TRB->NUMERO, TRB->PREFIXO, TRB->CODIGO, TRB->LOJA, TRB->TIPO, TRB->VALOR ) } ) 
	EndIf

	TRCell():New(oSection1, "E2_SALDO"	, "SE2"	, STR0056 + CHR(13)+CHR(10) + STR0057, /*Picture*/                , nTamE2Saldo , /*lPixel*/ , {|| IIf(TRB->TIPO $ "PA " + MV_CPNEG, TRB->VALOR * -1, TRB->VALOR )}) 
	TRCell():New(oSection1, "SALDOATU"	, ""	, STR0058 + CHR(13)+CHR(10) + STR0059, PesqPict("SE2","E2_VALOR") , nTamSalAtu  , /*lPixel*/ , {|| IIf(dDataBase >= TRB->VENCREA, IIf(TRB->TIPO $ "PA " + MV_CPNEG, (TRB->SALTIT) * -1, TRB->SALTIT), 0)})                                   
	TRCell():New(oSection1, "E2_VALOR"	, "SE2" , STR0060 + CHR(13)+CHR(10) + STR0061, /*Picture*/                , nTamE2Valor , /*lPixel*/ , {|| IIf(dDataBase >= TRB->VENCREA, IIf(TRB->TIPO $ "PA " + MV_CPNEG, (TRB->SALTIT + TRB->JUROS) * -1, TRB->SALTIT + TRB->JUROS), 0)})
	TRCell():New(oSection1, "TITVENC"	, ""	, STR0062 + CHR(13)+CHR(10) + STR0063, PesqPict("SE2","E2_VALOR") , nTamTitVenc , /*lPixel*/ , {|| IIf(dDataBase < TRB->VENCREA, IIf(TRB->TIPO $ "PA " + MV_CPNEG, (TRB->SALTIT + TRB->JUROS) * -1, TRB->SALTIT + TRB->JUROS), 0)}) 
	TRCell():New(oSection1, "E2_ACRESC"	, "SE2"	, STR0064 + CHR(13)+CHR(10) + STR0065, /*Picture*/                , nTamE2Acres , /*lPixel*/ , {|| TRB->JUROS})                                                                                            
	TRCell():New(oSection1, "ATRASO"	, ""	, STR0066 + CHR(13)+CHR(10) + STR0067, "@E 9999"                  , nTamAtraso  , /*lPixel*/ , {|| TRB->ATRASO })   
	TRCell():New(oSection1, "SALDOFIN"	, ""	, STR0068 + CHR(13)+CHR(10) + STR0069, PesqPict("SE2","E2_VALOR") , nTamSalFin  , /*lPixel*/ , {|| IIf(TRB->TIPO $ "PA " + MV_CPNEG,(TRB->SALTIT + TRB->JUROS) * -1, TRB->SALTIT + TRB->JUROS)})     

	oSection1:SetNoFilter( {'SED'} ) 

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)

	Local oSection1	:= oReport:Section(1)
	Local oBreak1	:= Nil
	Local nOrder	:= oReport:Section(1):GetOrder()
	Local aCampos	:= {}
	Local cbcont	:= 0
	Local cbtxt		:= Space(10)
	Local aOrdem	:= {}

	Local nCol		:= 0 
	Local nPos		:= 0
	Local nRow		:= 0
	Local nTamRel	:= oReport:PageWidth()
	Local nFatAjst	:= 1
	Local cAux		:= " "
	Local cDesFor	:= " "
	
	Private oTmpTable	:= Nil

	nSaldoAtu	:= 0.00
	nSalAtuG	:= 0.00
	nSalAntG	:= 0.00
	aSaldos		:= {}
	dEmissao	:= CTOD("")
	dVencto		:= CTOD("")

	cProvIni	:= mv_par01
	cProvFim	:= mv_par02
	cLojaIni	:= mv_par03
	cLojaFim	:= mv_par04
	dFechaIni	:= mv_par05
	dFechaFim	:= Min(mv_par06,dDataBase)
	nInforme	:= mv_par07
	nSituacao	:= 1
	dFechaBase	:= dDataBase
	dBaixa		:= dDataBase
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ MV_PAR01 -> De Proveedor                                  ³
	//³ MV_PAR02 -> A Proveedor                                   ³
	//³ MV_PAR03 -> De Sucursal                                   ³
	//³ mv_par04 -> A Sucursal                                    ³
	//³ MV_PAR05 -> A Fecha de Emision                            ³
	//³ MV_PAR06 -> A Fecha de Emision                            ³
	//³ MV_PAR07 -> Informe                                       ³
	//³ MV_PAR08 -> Considera NC, ND, PA                          ³
	//³ MV_PAR09 -> Importes en                                   ³
	//³ MV_PAR10 -> Convierte valores por                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
	aAdd(aCampos, {"CODIGO"  , "C", TamSX3('A2_COD')[1],0})
	aAdd(aCampos, {"LOJA"    , "C", TamSX3('A2_LOJA')[1],0})
	aAdd(aCampos, {"FORNECE" , "C", 25, 0})
	aAdd(aCampos, {"TELEFONE", "C", 15, 0})
	aAdd(aCampos, {"VENDEDOR", "C", 03, 0})
	aAdd(aCampos, {"NOMEVEND", "C", 25, 0})
	aAdd(aCampos, {"TELEVEND", "C", 15, 0})
	aAdd(aCampos, {"NATUREZA", "C", 10, 0})
	aAdd(aCampos, {"PREFIXO" , "C", 03, 0})
	aAdd(aCampos, {"NUMERO"  , "C", TamSX3('E2_NUM')[1],0})
	aAdd(aCampos, {"TIPO"    , "C", 03, 0})
	aAdd(aCampos, {"SIGLA"   , "C", 03, 0})
	aAdd(aCampos, {"PARCELA" , "C", TamSX3('E2_PARCELA')[1],0})
	aAdd(aCampos, {"BANCO"   , "C", 03, 0})
	aAdd(aCampos, {"NUMBCO"  , "C", 10, 0})
	aAdd(aCampos, {"PORTADOR", "C", 03, 0})
	aAdd(aCampos, {"SITUACAO", "C", 01, 0})
	aAdd(aCampos, {"MOEDA"   , "N", 02, 0})
	aAdd(aCampos, {"EMISSAO" , "D", 08, 0})
	aAdd(aCampos, {"VENCTO"  , "D", 08, 0})
	aAdd(aCampos, {"VENCREA" , "D", 08, 0})
	aAdd(aCampos, {"BAIXA"   , "D", 08, 0})
	aAdd(aCampos, {"HISTOR"  , "C", 20, 0})
	aAdd(aCampos, {"VALOR"   , "N", 18, 2})
	aAdd(aCampos, {"DEBITO"  , "N", 18, 2})
	aAdd(aCampos, {"CREDITO" , "N", 18, 2})
	aAdd(aCampos, {"SALDO"   , "N", 18, 2})
	aAdd(aCampos, {"SALTIT"  , "N", 18, 2})
	aAdd(aCampos, {"DC"      , "C",  1, 0})
	aAdd(aCampos, {"JUROS"   , "N", 18, 2})
	aAdd(aCampos, {"ATRASO"  , "N",  4, 0})
	
	aOrdem := {"CODIGO", "LOJA", "EMISSAO"}
	
	If nOrder == 1
		aOrdem := {"CODIGO", "LOJA", "EMISSAO"}
	ElseIf nOrder == 2
		aOrdem := {"FORNECE", "EMISSAO"}
	ElseIf nOrder == 3
		aOrdem := {"CODIGO", "LOJA", "NATUREZA", "EMISSAO"}
	EndIf
		
	oTmpTable := FWTemporaryTable():New("TRB")
	oTmpTable:SetFields(aCampos)
	oTmpTable:AddIndex("IN1", aOrdem)
	
	oTmpTable:Create()
	
	Processa({|lEnd| GrvSldXXX(.T., oSection1:GetAdvPlExp('SA2'))}, , OemToAnsi(STR0033)) // Substituido por el asistente de conversión del AP5 IDE en 01/06/00 ==> Processa({|lEnd| Execute(GrvSldXXX) },,OemToAnsi("Preparando Transit¢rio..."))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia rotina de impressao                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("TRB")
	dbGoTop()

	//--- Inicializacao da variavel que descreve o Fornecedor no Total
	If nOrder == 3   // Por Natureza
		cDesFor := TRB->NATUREZA
	Else
		cDesFor := TRB->CODIGO + "/" + TRB->LOJA + "-" + TRB->FORNECE
	EndIf

	//-- Header de Texto no Resumido
	If nInforme <> 1 //Detallado

		oSection1:Hide()

		nRow := oReport:Row()
		oReport:PrintText(" ", nRow )

		//-------------------------------
		//---------- Valor Original / 1
		//-------------------------------
		nRow := oReport:Row()

		If lOperat1
			If nTamRel > 2446
				nFatAjst := 2
				cAux := STR0080  
			Else
				//--- nFatAjst = Default da Inicializacao
				cAux := STR0078  
			EndIf
		Else
			If nTamRel > 2446
				nFatAjst := 0
				cAux := STR0075  
			Else
				//--- nFatAjst = Default da Inicializacao
				cAux := STR0073  
			EndIf
		EndIf

		nCol := (nTamRel / 2) + (Len(cAux) * nFatAjst / 2) 

		oReport:Say(nRow, nCol, cAux)   

		oReport:SkipLine()

		//-------------------------------
		//---------- Valor Original / 2 -
		//-------------------------------
		nRow := oReport:Row()

		If lOperat1
			If nTamRel > 2446
				nFatAjst := 2
				cAux := STR0081
			Else
				cAux := STR0079
			EndIf
		Else
			If nTamRel > 2446
				nFatAjst := 0
				cAux := STR0076
			Else
				cAux := STR0074
			EndIf
		EndIf

		nCol := (nTamRel / 2) + (Len(cAux) * nFatAjst / 2) 

		oReport:Say(nRow, nCol, cAux)   
		oReport:SkipLine()
	EndIf


	oSection1:Cell("SALDOFIN"):Hide()
	oSection1:SetOrder(1)
	oSection1:SetLineCondition({|| !Alltrim(TRB->TIPO)$"OP" .And. IIf(MV_PAR08 == 2, !Alltrim(TRB->TIPO) $ "FT|NF", .T.).And. Empty(BAIXA)})

	If nOrder == 3   // Por Natureza
		oBreak1 := TRBreak():New( oSection1, {|| TRB->NATUREZA } , )
		oBreak1:SetTitle({|| STR0035 + MascNat(cDesFor) }) // "TOTAL  POR  MODALIDAD ----> "
		oBreak1:OnPrintTotal({|| cDesFor := TRB->NATUREZA } )
	Else
		oBreak1 := TRBreak():New( oSection1, {|| TRB->CODIGO + TRB->LOJA } , )
		oBreak1:SetTitle({|| STR0036 + cDesFor }) // "TOTAL  POR  PROVEEDOR ----> "
		oBreak1:OnPrintTotal({|| cDesFor := TRB->CODIGO + "/" + TRB->LOJA + "-" + TRB->FORNECE } )
	EndIf

	Trposition():New(oReport:Section(1),"SED",1,{|| xFilial()+TRB->NATUREZA})  
	Trposition():New(oReport:Section(1),"SA2",1,{|| xFilial()+TRB->CODIGO+TRB->LOJA})

	If lOperat1
		TRFunction():New(oSection1:Cell("VALCQ"), , "SUM", oBreak1, , , , .F. ,)
	EndIf

	TRFunction():New(oSection1:Cell("E2_SALDO"	), , "SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection1:Cell("SALDOATU"	), , "SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection1:Cell("E2_VALOR"	), , "SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection1:Cell("TITVENC"	), , "SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection1:Cell("E2_ACRESC"	), , "SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection1:Cell("SALDOFIN"	), , "SUM", oBreak1, , , , .F. ,)

	oSection1:NoUserFilter()

	oSection1:Print()

	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil
	EndIf

	dbSelectArea("SA1")
	RetIndex("SA1")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SA2")
	RetIndex("SA2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE2")
	RetIndex("SE2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE2")
	RetIndex("SE2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE5")
	RetIndex("SE5")
	dbSetOrder(1)
	DbClearFilter()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PrtnCQ  ³ Autor ³ Carlos Eduardo Chigres ³ Data ³ 23/08/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao que Imprime a coluna da celula LIBCQ                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Caracter                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrtnCQ(cE2Num, cE2Pref, cE2Cod, cE2Loja)

	Local cReto := "X"

	Local lTestCQ := OnOrRejQA( cE2Num, cE2Pref, cE2Cod, cE2Loja )

	If lTestCQ
		cReto := "N"
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Titulo Liberado para a Selecao ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cReto := "S"
	EndIf

Return (cReto)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PrtVlCQ ³ Autor ³ Carlos Eduardo Chigres ³ Data ³ 23/08/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao que calcula e Imprime a coluna da celula VALCQ      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Numerico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrtVlCQ(cE2Num, cE2Pref, cE2Cod, cE2Loja, cTipo, nValor)

	Local nReto		:= 0.00   // Manter essa inicializacao
	Local lTestCQ	:= OnOrRejQA(cE2Num, cE2Pref, cE2Cod, cE2Loja)

	If lTestCQ
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Titulo ainda em Processo de CQ ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cTipo $ ( "PA " + MV_CPNEG )
			nReto := nValor * -1
		Else
			nReto := nValor
		EndIf
	EndIf

Return (nReto)


User Function Finr15aR3()	// incluido por el asistente de conversión del AP5 IDE en 01/06/00

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaración de variables utilizadas en el programa a través de la función    ³
	//³ SetPrvt, va a crear sólo las variables definidas por el usuario,    ³
	//³ identificando las variables públicas del sistema utilizadas en el código ³
	//³ Incluido por el asistente de conversión del AP5 IDE                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	SetPrvt("CDESC1,CDESC2,CDESC3,LIMITE,CSTRING,TAMANHO")
	SetPrvt("TITULO,CABEC1,CABEC2,ARETURN,NOMEPROG,ALINHA")
	SetPrvt("NLASTKEY,CPERG,WNREL,AORD,NSALDOATU")
	SetPrvt("NSALATUG,NSALANTG,ASALDOS,DEMISSAO,DVENCTO,CPROVINI")
	SetPrvt("CPROVFIM,CLOJAINI,CLOJAFIM,DFECHAINI,DFECHAFIM,NINFORME")
	SetPrvt("NSITUACAO,DFECHABASE,DBAIXA,NORDEM,CBTXT")
	SetPrvt("CBCONT,LI,M_PAG,ACAMPOS,CNOMEARQ,CINDEXKEY")
	SetPrvt("NTGTITULOS,NTGNORMAL,NTGATRASO,NTGCORRIG,NTGVENCER,NTGJUROS")
	SetPrvt("NTITULOS,NVLRNORMAL,NVLRATRASO,NVLRCORRIG,NVLRVENCER,NVLRJUROS")
	SetPrvt("CCODPROV,CLOJAPROV,CRAZSOCIAL,CTELEFONE,CMODALIDAD,LIMPPROV")
	SetPrvt("CCONDWPROV,LEND,NJUROS,NATRASO,CTOTAL,_SALIAS")
	SetPrvt("I,J,EXPC1,EXPC2,EXPN1,EXPL1")
	SetPrvt("EXPL2,EXPC3,NDEBITO,NCREDITO,CHISTOR,")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cDesc1 := OemToAnsi(STR0001)  // "Este programa imprimir  la demostraci¢n contable de Proveedores"
	cDesc2 := OemToAnsi(STR0002)  // "Se puede  emitir  todo  el movimiento de los mismos, o apenas  "
	cDesc3 := OemToAnsi(STR0003)  // "los valores originales.                                        "

	limite  := 220
	cString := "SE2"
	Tamanho := "G"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Defini‡„o dos cabe‡alhos ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	titulo := OemToAnsi(STR0004)  // "Posici¢n de los T¡tulos a Pagar"
	cabec1 := OemToAnsi(STR0005)  // "Codigo    Nombre Proveedor     Prf-N£mero          TP  Modalidad  Fecha de   Vencto     Vencto     Banco Valor Original|       T¡tulos  Vencidos       |T¡tulos a Vencer| Num        Vlr.Inter‚s   D¡as              Saldo"
	cabec2 := OemToAnsi(STR0006)  // "                               Cuota                              Emisi¢n    T¡tulo     Real                           | Valor Nominal  Valor Corregido|  Valor Nominal | Banco     o Permanencia  Atraso            Final"

	If lOperat1 
		cAux := STRTRAN( cabec1, "TP", "CQ" )
		cabec1 := cAux
	EndIf

	aReturn  := { OemToAnsi(STR0007), 1,OemToAnsi(STR0008), 2, 2, 2,"",1 }  //"Especial","Administracao"

	nomeprog := "FINR15A"

	aLinha   := {}
	nLastKey := 0
	cPerg    := "FIN15A"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


	Pergunte("FIN15A",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel := "FINR15A"            //Nome Default do relatorio em Disco

	aOrd := { OemToAnsi(STR0027),;  //"Por C¢digo"
	OemToAnsi(STR0028),;  //"Por Nombre"
	OemToAnsi(STR0029) }  //"Por Modalidad"

	wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,"",.F.)

	If nLastKey == 27
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	EndIf

	RptStatus({|| FA15AImp()},OemToAnsi(STR0030),OemToAnsi(STR0031))// Substituido por el asistente de conversión del AP5 IDE en 01/06/00 ==> RptStatus({|| Execute(FA15AImp)},"Posici¢n de Proveedores","Imprimiendo...")  //"Posici¢n de Proveedores","Imprimiendo..."

	Set Device To Screen
	If aReturn[5] == 1
		Set Printer To
		Commit
		Ourspool(wnrel)
	Endif
	MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FA15AImp ³ Autor ³Jose Lucas/Diego Rivero³ Data ³ 09.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Razonete de Cliente/Fornecedores                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA15AImp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
// Substituido por el asistente de conversión del AP5 IDE en 01/06/00 ==> Function FA15AImp
Static Function FA15AImp()

	Local aOrdem := {}
	
	Private oTmpTable := Nil

	nSaldoAtu	:= 0.00
	nSalAtuG	:= 0.00
	nSalAntG	:= 0.00
	aSaldos		:= {}
	dEmissao	:= CTOD("")
	dVencto		:= CTOD("")

	cProvIni	:= mv_par01
	cProvFim	:= mv_par02
	cLojaIni	:= mv_par03
	cLojaFim	:= mv_par04
	dFechaIni	:= mv_par05
	dFechaFim	:= Min(mv_par06,dDataBase)
	nInforme	:= mv_par07
	nSituacao	:= 1
	dFechaBase	:= dDataBase

	dBaixa		:= dDataBase
	nOrdem		:= aReturn[8]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cbtxt	:= Space(10)
	cbcont	:= 0
	li		:= 80
	m_pag	:= 1

	aCampos := {}
	aAdd(aCampos, {"CODIGO"  , "C", 06, 0})
	aAdd(aCampos, {"LOJA"    , "C", 02, 0})
	aAdd(aCampos, {"FORNECE" , "C", 25, 0})
	aAdd(aCampos, {"TELEFONE", "C", 15, 0})
	aAdd(aCampos, {"VENDEDOR", "C", 03, 0})
	aAdd(aCampos, {"NOMEVEND", "C", 25, 0})
	aAdd(aCampos, {"TELEVEND", "C", 15, 0})
	aAdd(aCampos, {"NATUREZA", "C", 10, 0})
	aAdd(aCampos, {"PREFIXO" , "C", 03, 0})
	aAdd(aCampos, {"NUMERO"  , "C", 15, 0})
	aAdd(aCampos, {"TIPO"    , "C", 03, 0})
	aAdd(aCampos, {"SIGLA"   , "C", 03, 0})
	aAdd(aCampos, {"PARCELA" , "C", 01, 0})
	aAdd(aCampos, {"BANCO"   , "C", 03, 0})
	aAdd(aCampos, {"NUMBCO"  , "C", 10, 0})
	aAdd(aCampos, {"PORTADOR", "C", 03, 0})
	aAdd(aCampos, {"SITUACAO", "C", 01, 0})
	aAdd(aCampos, {"MOEDA"   , "N", 02, 0})
	aAdd(aCampos, {"EMISSAO" , "D", 08, 0})
	aAdd(aCampos, {"VENCTO"  , "D", 08, 0})
	aAdd(aCampos, {"VENCREA" , "D", 08, 0})
	aAdd(aCampos, {"BAIXA"   , "D", 08, 0})
	aAdd(aCampos, {"HISTOR"  , "C", 20, 0})
	aAdd(aCampos, {"VALOR"   , "N", 18, 2})
	aAdd(aCampos, {"DEBITO"  , "N", 18, 2})
	aAdd(aCampos, {"CREDITO" , "N", 18, 2})
	aAdd(aCampos, {"SALDO"   , "N", 18, 2})
	aAdd(aCampos, {"SALTIT"  , "N", 18, 2})
	aAdd(aCampos, {"DC"      , "C", 1 , 0})
	
	aOrdem := {"CODIGO", "LOJA", "EMISSAO"}
	
	If nOrdem == 1
		aOrdem := {"CODIGO", "LOJA", "EMISSAO"}
	ElseIf nOrdem == 2
		aOrdem := {"FORNECE", "EMISSAO"}
	ElseIf nOrdem == 3
		aOrdem := {"CODIGO", "LOJA", "NATUREZA", "EMISSAO"}
	EndIf
		
	oTmpTable := FWTemporaryTable():New("TRB")
	oTmpTable:SetFields(aCampos)
	oTmpTable:AddIndex("IN1", aOrdem)
	
	oTmpTable:Create()

	Processa({|lEnd| GrvSldXXX(.F.) },,OemToAnsi(STR0033) ) // Substituido por el asistente de conversión del AP5 IDE en 01/06/00 ==> Processa({|lEnd| Execute(GrvSldXXX) },,OemToAnsi("Preparando Transit¢rio..."))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia rotina de impressao                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("TRB")
	dbGoTop()

	nTGTitulos := 0.00
	nTGNormal  := 0.00
	nTGAtraso  := 0.00
	nTGCorrig  := 0.00
	nTGVencer  := 0.00
	nTGJuros   := 0.00

	SetRegua(RecCount())

	While !Eof()

		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIf(aReturn[4] == 1, 15, 18))
			li := 09
		EndIf

		nTitulos := 0.00

		nVlrNormal := 0.00
		nVlrAtraso := 0.00
		nVlrCorrig := 0.00
		nVlrVencer := 0.00
		nVlrJuros  := 0.00

		cCodProv   := TRB->CODIGO
		cLojaProv  := TRB->LOJA
		cRazSocial := TRB->FORNECE
		cTelefone  := TRB->TELEFONE
		cModalidad := TRB->NATUREZA

		lImpProv := .T.

		If nOrdem == 3
			cCondWProv := "!Eof() .And. TRB->NATUREZA == cModalidad"
		Else
			cCondWProv := "!Eof() .And. TRB->CODIGO == cCodProv .And. TRB->LOJA == cLojaProv"
		EndIf

		//While &( cCondWProv )
		While If(nOrdem == 3, !Eof() .And. TRB->NATUREZA == cModalidad, !Eof() .And. TRB->CODIGO == cCodProv .And. TRB->LOJA == cLojaProv)

			IncRegua()

			If lEnd
				Exit
			EndIf

			If li>50
				cabec(titulo, cabec1, cabec2, nomeprog, tamanho, IIf(aReturn[4] == 1, 15, 18))
				li := 9
			EndIf

			If Alltrim(TIPO) $ "OP"
				dbSkip()
				Loop
			EndIf

			If mv_par08 == 2
				If ! AllTrim(TIPO) $ "FT.NF"
					dbSkip()
					Loop
				EndIf
			EndIf

			If !Empty(BAIXA)
				dbSkip()
				Loop
			EndIf

			nJuros := 0
			dbSelectArea("SE2")

			If dbSeek(xFilial("SE2")+TRB->PREFIXO+TRB->NUMERO+TRB->PARCELA)
				FA070Juros( mv_par09 )
			EndIf

			dbSelectArea("TRB")
			nAtraso := 0
			
			If !Empty(VENCREA) .And. dDataBase > VENCREA
				nAtraso := dDataBase - VENCTO
				If Dow(VENCTO) == 1 .Or. Dow(VENCTO) == 7
					If Dow(dBaixa) == 2 .And. nAtraso <= 2
						nAtraso := 0
					EndIf
				EndIF
				nAtraso := IIf(nAtraso < 0, 0, nAtraso)
			EndIf

			If nInforme == 1 //Detallado

				@li, 00 PSAY CODIGO + " " + LOJA
				@li, 10 PSAY SubStr(FORNECE, 1, 20)
				@li, 31 PSAY PREFIXO + Trans(NUMERO, "@R /9999999999999") + " " + PARCELA 

				If lOperat1 
					@li, 51 PSAY PrtnCQ( TRB->NUMERO, TRB->PREFIXO, TRB->CODIGO, TRB->LOJA )
				Else
					@li, 51 PSAY If(Alltrim(TIPO) $ "NF", "FT", TIPO)
				EndIf

				@li, 54 PSAY AllTrim(MascNat(NATUREZA))
				@li, 66 PSAY EMISSAO

				If VENCTO == dDataBase
					@li, 77 PSAY OemToAnsi(STR0034) // "Vence Hoy"
				Else
					@li, 77 PSAY VENCTO
				EndIf

				@li, 88 PSAY VENCREA
				@li, 99 PSAY PORTADOR+" "+SITUACAO

				If TIPO $ "PA "+MV_CPNEG
					@li,105 PSAY VALOR * -1	Picture tm (TRB->VALOR,14)
				Else
					@li,105 PSAY VALOR	Picture tm (TRB->VALOR,14)
				EndIf

				If dDataBase > VENCREA
					@li,120 PSAY SALTIT	Picture tm ( SALTIT, 14 )
					@li,137 PSAY SALTIT + nJuros  Picture tm(SALTIT+nJuros,14)
				Else
					@li,154 PSAY SALTIT	Picture tm ( SALTIT, 14 )
				EndIf

				@ li, 170 PSAY NUMBCO

				If nJuros > 0
					@ Li,181 PSAY nJuros Picture Tm(nJuros,12)
				EndIf

				If nAtraso > 0
					@li ,197 PSAY nAtraso Picture "9999"
				EndIf

				li := li + 1
			EndIf

			If TIPO $ "PA /"+MV_CPNEG
				nVlrNormal	:= nVlrNormal - SALTIT
				nTGNormal	:= nTGNormal - SALTIT

				If dDataBase > VENCREA
					nVlrAtraso	:= nVlrATraso - SALTIT
					nVlrCorrig	:= nVlrCorrig - (SALTIT + nJuros)
					nTGAtraso	:= nTGATraso - SALTIT
					nTGCorrig	:= nTGCorrig - (SALTIT + nJuros)
				Else
					nVlrVencer := nVlrVencer - SALTIT
					nTGVencer  := nTGVencer - SALTIT
				EndIf

			Else
				nVlrNormal	:= nVlrNormal + SALTIT
				nTGNormal	:= nTGNormal + SALTIT
				If dDataBase > VENCREA
					nVlrAtraso	:= nVlrATraso + SALTIT
					nVlrCorrig	:= nVlrCorrig + (SALTIT + nJuros)
					nTGAtraso	:= nTGATraso + SALTIT
					nTGCorrig	:= nTGCorrig + (SALTIT + nJuros)
				Else
					nVlrVencer	:= nVlrVencer + SALTIT
					nTGVencer	:= nTGVencer + SALTIT
				EndIf
			EndIf

			nTitulos	:= nTitulos + 1
			nTGTitulos	:= nTGTitulos + 1
			nVlrJuros	:= nVlrJuros + nJuros
			nTGJuros	:= nTGJuros + nJuros

			dbSelectArea("TRB")
			dbSkip()
		Enddo

		If nInforme == 1 //Detallado

			If nTitulos > 0
				If li > 50
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIf(aReturn[4]==1,15,18))
					li := 9
				EndIf
				li := li + 1

				If nOrdem == 3
					cTotal := OemToAnsi(STR0035) // "T O T A L  P O R  M O D A L I D A D ----> "
				Else
					cTotal := OemToAnsi(STR0036) // "T O T A L  P O R  P R O V E E D O R ----> "
				EndIf

				@li,000 PSAY cTotal
				@li,043 PSAY "( Titulos "+Str(nTitulos,4)+" )"
				@li,106 PSAY nVlrNormal		Picture TM(nVlrNormal,14)
				@li,121 PSAY nVlrAtraso		Picture TM(nVlrAtraso,14)
				@li,138 PSAY nVlrCorrig		Picture TM(nVlrCorrig,14)
				@li,155 PSAY nVlrVencer 	Picture TM(nVlrVencer,14)

				If nVlrJuros > 0
					@li,181 PSAY nVlrJuros	Picture TM(nTotJur,12)
				Endif

				@li,203 PSAY nVlrNormal Picture TM(nVlrNormal,14)
				@li,219 PSAY If(nVlrNormal>0,"D","C")
				li := li + 2
			Endif

		Else
			If nTitulos > 0
				If nOrdem == 3
					SED->(dbSetOrder(1))
					SED->(dbSeek(xFilial("SED")+cModalidad))
					If SED->(Found())
						@li,  0 PSAY MascNat(cModalidad)
						@li, 15 PSAY SED->ED_DESCRIC
					Endif
				Else
					@li,  0 PSAY cCodProv+"-"+cLojaProv
					@li, 11 PSAY cRazSocial
				EndIf
				@li,043 PSAY "( "+OemToAnsi(STR0037)+" "+Str(nTitulos,4)+" )"  //"Titulos "
				@li,106 PSAY nVlrNormal		Picture TM(nVlrNormal,14)
				@li,121 PSAY nVlrAtraso		Picture TM(nVlrAtraso,14)
				@li,138 PSAY nVlrCorrig		Picture TM(nVlrCorrig,14)
				@li,155 PSAY nVlrVencer 	Picture TM(nVlrVencer,14)
				If nVlrJuros > 0
					@li,181 PSAY nVlrJuros	Picture TM(nTotJur,12)
				Endif
				@li,203 PSAY nVlrNormal		Picture TM(nVlrNormal,14)
				@li,219 PSAY If(nVlrNormal>0,"D","C")
				li := li + 2
			Endif
		Endif

	Enddo

	If nTGTitulos > 0
		If li > 50
			cabec(titulo, cabec1, cabec2, nomeprog, tamanho, IIf(aReturn[4] == 1, 15, 18))
			li := 9
		EndIf
		li := li + 1
		@li,000 PSAY Replicate("-",220)
		li := li + 1
		@li,000 PSAY OemToAnsi(STR0038) // "T O T A L     G E N E R A L         ----> "
		@li,043 PSAY "( " + OemToAnsi(STR0037) + " " + Str(nTGTitulos, 4) + " )"  // "Titulos"
		@li,106 PSAY nTGNormal	Picture TM(nVlrNormal,14)
		@li,121 PSAY nTGAtraso	Picture TM(nVlrAtraso,14)
		@li,138 PSAY nTGCorrig	Picture TM(nVlrCorrig,14)
		@li,155 PSAY nTGVencer	Picture TM(nVlrVencer,14)
		If nVlrJuros > 0
			@li,181 PSAY nTGJuros	Picture TM(nTotJur,12)
		Endif
		@li,203 PSAY nTGNormal	Picture TM(nVlrNormal,14)
		@li,219 PSAY If(nTGNormal > 0, "D", "C")
		li := li + 1
		@li,000 PSAY Replicate("-",220)
		li := li + 1
	EndIf

	Roda( cbCont, cbTxt, Tamanho )

	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil
	EndIf

	dbSelectArea("SA1")
	RetIndex("SA1")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SA2")
	RetIndex("SA2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE2")
	RetIndex("SE2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE2")
	RetIndex("SE2")
	dbSetOrder(1)
	DbClearFilter()

	dbSelectArea("SE5")
	RetIndex("SE5")
	dbSetOrder(1)
	DbClearFilter()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ GrvSldClie³ Autor ³ Lucas       	  		³ Data ³ 05/02/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grabar uno archivo transit¢rio (TRB) con los salods de los ³±±
±±³          ³ Clientes. Baseado en las leyes y denificiones de Localiza- ³±±
±±³          ³ ciones de los paises del ConeSul y Andinos.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GrvSldClie(ExpC1,ExpC2,ExpN1,ExpL1,ExpC3)                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 := C¢digo Inicial del Cliente                        ³±±
±±³          ³ ExpC2 := C¢digo Final del Cliente                          ³±±
±±³          ³ ExpN1 := Selecci¢n del Tipo de T¡tulos                     ³±±
±±³          ³ ExpL1 := Identifica lo Cierre por Vendedor o Cliente		  ³±±
±±³          ³ ExpL2 := Imprimir con Historico o No (Saldo > 0)    		  ³±±
±±³          ³ ExpC3 := Nombre do Relat¢rio. Ejemplo: "FINR152"           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Localizacoes ConeSul y Andinos                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
// Substituido por el asistente de conversión del AP5 IDE en 01/06/00 ==> Function GrvSldXXX
Static Function GrvSldXXX(lFiltro,cFiltSA2)
	Local nTaxa:= 0
	lOCAL nMoeda:= mv_par09
	Local lGravou:=.F.
	Local aSM0 := FWLoadSM0()
	Local aFilProc := {}
	Local nLoop := 0
	Local nPosFil := 0
	Local nTamFil := FwSizeFilial()
	Local cFilAnt := ""
	Local nAux:=0
	Local lAux:=.T.
	nDebito := 0.00
	nCredito := 0.00

	For nLoop := 1 To Len(aSM0)
		If aSM0[nLoop][2] >= cLojaIni .And. aSM0[nLoop][2] <= cLojaFim
			nPosFil := aScan(aFilProc,{|x| x == xFilial("SE2",aSM0[nLoop][2])})	
			If nPosFil == 0
				aAdd(aFilProc,xFilial("SE2",aSM0[nLoop][2]))
			EndIf
		EndIf
	Next
	
	For nLoop := 1 To Len(aFilProc)
		cFilAnt := PADR(aFilProc[nLoop],nTamFil)
		ProcRegua(SE2->(RecCount()))
	
		dbSelectArea("SE2")
		SE2->(DBSetOrder(6)) //E2_FILIAL+E2_FORNECE
		SE2->(dbSeek(cFilAnt + cProvIni,.T.))
	
		While !Eof() .And. SE2->E2_FILIAL == cFilAnt .And. (SE2->E2_FORNECE >= cProvIni .And. SE2->E2_FORNECE <= cProvFim)
			lAux:=.T.
			// Tratamento da correcao monetaria para a Argentina
			If cPaisLoc <> "BRA" .And. SE2->E2_CONVERT == 'N'
				dbSkip()
				Loop
			Endif
			If lFiltro	
				SA2->(dbSetOrder(1))
				SA2->(MsSeek( xFilial() + SE2->E2_FORNECE + SE2->E2_LOJA ))
				If !Empty(cFiltSA2)
					If !SA2->(&(cFiltSA2))
						DbSelectArea("SE2")
						DbSkip()
						Loop
					Endif
				Endif
			EndIf
			If ! SubStr( SE2->E2_TIPO, 1, 2 ) $ "TF~CH" 
			
				If nSituacao == 1 //Historico
					If SE2->E2_EMISSAO <= dFechaFim
						If DToS( SE2->E2_EMISSAO ) < DToS( dFechaIni )
							If ALLTRIM(SE2->E2_TIPO) $ MV_CPNEG .OR. SubStr(SE2->E2_TIPO, 3, 1) == "-"
								nCredito := SE2->E2_VLCRUZ
							Else
								nDebito := SE2->E2_VLCRUZ
							EndIf
						ElseIf DToS(SE2->E2_EMISSAO) >= DToS( dFechaIni) .And. DToS(SE2->E2_EMISSAO) <= DToS(dFechaFim)
						nAux:=SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,nMoeda,,dFechaBase,SE2->E2_LOJA,,nTaxa)
						IF cPaisLoc=='ARG' .and. nAux==0
							lAux:=.F.
						ENDIF
						IF lAux
							SA2->(dbSetOrder(1))
							SA2->(MsSeek( xFilial() + SE2->E2_FORNECE + SE2->E2_LOJA )) //Posiciono SA2 para utilizar os dados corretos do fornecefdor
							RecLock("TRB", .T.)
							TRB->CODIGO		:= SE2->E2_FORNECE
							TRB->LOJA		:= SE2->E2_LOJA
							TRB->FORNECE	:= SA2->A2_NOME
							TRB->TELEFONE	:= SA2->A2_TEL
							TRB->NUMERO		:= SE2->E2_NUM
							If ALLTRIM(SE2->E2_TIPO) $ MV_CPNEG .OR. SubStr(SE2->E2_TIPO, 3, 1) == "-"
								TRB->CREDITO := SE2->E2_VLCRUZ
							Else
								TRB->DEBITO := SE2->E2_VLCRUZ
							EndIf
							TRB->NUMERO		:= SE2->E2_NUM
							TRB->TIPO		:= SE2->E2_TIPO
							TRB->SIGLA		:= SE2->E2_TIPO
							TRB->PARCELA	:= SE2->E2_PARCELA
							TRB->PREFIXO	:= SE2->E2_PREFIXO
							nTaxa:= IIf(MV_PAR10 == 2, IIf(SE2->E2_TXMOEDA>0,SE2->E2_TXMOEDA,RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0)
							TRB->VALOR	:=  xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,nMoeda,DDATABASE,MsDecimais(nMoeda),nTaxa)
							TRB->SALTIT	:=  nAux
							//TRB->SALTIT:=  xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,1,DDATABASE)
							If TRB->SALTIT > 0.00
								If SE2->E2_VENCTO == dDataBase
									TRB->VENCTO	:= dDataBase
								ElseIf SE2->E2_VENCTO < dDataBase.And.!Empty(SE2->E2_VENCTO )
									TRB->VENCTO		:= SE2->E2_VENCTO
									TRB->VENCREA	:= SE2->E2_VENCREA
								Else
									TRB->VENCTO		:= SE2->E2_VENCTO
									TRB->VENCREA	:= SE2->E2_VENCREA
								EndIf
							Else
								TRB->VENCTO		:= SE2->E2_BAIXA
								TRB->VENCREA	:= SE2->E2_BAIXA
								TRB->BAIXA		:= SE2->E2_BAIXA
							EndIf
							TRB->EMISSAO	:=  SE2->E2_EMISSAO
							TRB->SALDO		:= TRB->DEBITO - TRB->CREDITO
							lGravou := .T.
							MsUnLock()
						ENDIF
						EndIf
					EndIf
				Else
					If DToS( SE2->E2_EMISSAO ) < DToS( dFechaIni )
						If ALLTRIM(SE2->E2_TIPO)$MV_CPNEG.OR.SubStr(SE2->E2_TIPO,3,1)=="-"
							nCredito := SE2->E2_VLCRUZ
						Else
							nDebito := SE2->E2_VLCRUZ
						EndIf
					ElseIf DToS( SE2->E2_EMISSAO ) >= DToS( dFechaIni ) .And. DToS( SE2->E2_EMISSAO ) <= DToS( dFechaFim )
						RecLock( "TRB", .T. )
						TRB->CODIGO		:= SE2->E2_FORNECE
						TRB->LOJA		:= SE2->E2_LOJA
						TRB->FORNECE	:= SA2->A2_NOME
						TRB->TELEFONE	:= SA2->A2_TEL
						TRB->NUMERO		:= SE2->E2_NUM
						If ALLTRIM(SE2->E2_TIPO)$MV_CPNEG .OR. SubStr(SE2->E2_TIPO,3,1)=="-"
							TRB->CREDITO := SE2->E2_VLCRUZ
						Else
							TRB->DEBITO := SE2->E2_VLCRUZ
						EndIf
						TRB->NUMERO		:= SE2->E2_NUM
						TRB->TIPO		:= SE2->E2_TIPO
						TRB->SIGLA		:= SE2->E2_TIPO
						TRB->PARCELA	:= SE2->E2_PARCELA
						TRB->PREFIXO	:= SE2->E2_PREFIXO
						nTaxa := IIf(MV_PAR10 == 2,IIf(SE2->E2_TXMOEDA>0,SE2->E2_TXMOEDA,RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0)
						TRB->VALOR	:= xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,nMoeda,DDATABASE,MsDecimais(nMoeda),nTaxa)
						TRB->SALTIT	:= SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,nMoeda,,dFechaBase,SE2->E2_LOJA,,nTaxa)
						//TRB->SALTIT:=  xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,1,DDATABASE)
						If TRB->SALTIT > 0.00
							If SE2->E2_VENCTO == dDataBase
								TRB->VENCTO  := dDataBase
								TRB->VENCREA := dDataBase
							ElseIf SE2->E2_VENCTO < dDataBase.And.!Empty(SE2->E2_VENCTO )
								TRB->VENCTO  := SE2->E2_VENCTO
								TRB->VENCREA := SE2->E2_VENCTO
							Else
								TRB->VENCTO  := SE2->E2_VENCTO
								TRB->VENCREA := SE2->E2_VENCTO
							EndIf
						Else
							TRB->VENCTO  := SE2->E2_BAIXA
							TRB->VENCREA := SE2->E2_VENCTO
							TRB->BAIXA   := SE2->E2_BAIXA
						EndIf
						TRB->EMISSAO  :=  SE2->E2_EMISSAO
						TRB->SALDO    := TRB->DEBITO - TRB->CREDITO
						lGravou:=.T.
						MsUnLock()
						
					EndIf
				EndIf
				
				cHistor := ""
				If SE2->E2_TIPO == "NCP"
					cHistor := OemToAnsi(STR0039) //"NOTA DE CREDITO No. "
				ElseIf SE2->E2_TIPO == "NDP"
					cHistor := OemToAnsi(STR0040) // "NOTA DE DEBITO No. "
				ElseIf SE2->E2_TIPO == "NF "
					cHistor := OemToAnsi(STR0041) // "FACTURA No. "
				ElseIf SE2->E2_TIPO == "FT "
					cHistor := OemToAnsi(STR0041) // "FACTURA No. "
				ElseIf SE2->E2_TIPO == "PA "
					cHistor := OemToAnsi(STR0042) // "ANTICIPO"
				ElseIf SE2->E2_TIPO == "NCE"
					cHistor := OemToAnsi(STR0043) // "NOTA DE CRED. EXTERNA"
				ElseIf SE2->E2_TIPO == "NDE"
					cHistor := OemToAnsi(STR0044) // "NOTA DE DEB. EXTERNA"
				Else
					cHistor := OemToAnsi(STR0045) // "NO CLASIFICADO..."
				EndIf  
				
				If lGravou
					RecLock("TRB",.F.)
					TRB->HISTOR := cHistor
					MsUnLock()
				EndIf
				
				If !lImpGraf .And. lGravou
					RecLock("TRB",.F.)
					TRB-> NATUREZA := SE2->E2_NATUREZ
					MsUnLock()
				EndIf
				// Calcula Juros Release 4
				If lImpGraf .And. lGravou
					nJuros	:= 0
					nAtraso	:= 0
					dbSelectArea("TRB")
	
					RecLock("TRB",.F.)
					TRB-> NATUREZA:= SE2->E2_NATUREZ
					If !Empty(VENCREA) .And. dDataBase >= VENCREA
						FA070Juros( mv_par09 )
						nAtraso := dDataBase-VENCTO
						If Dow(VENCTO) == 1 .Or. Dow(VENCTO) == 7
							If Dow(dBaixa) == 2 .And. nAtraso <= 2
								nAtraso := 0
							EndIf
						EndIF
						nAtraso := IIf(nAtraso<0,0,nAtraso)
					EndIf  
					If 	nJuros > 0 .Or. nAtraso>0
						TRB->JUROS	:= nJuros
						TRB->ATRASO	:=	nAtraso
					EndIf
					MsUnLock() 
				EndIF
			EndIf
			lGravou := .F.
			dbSelectArea("SE2")
			dbSkip()
		End
	Next
	For nLoop := 1 To Len(aFilProc)
		cFilAnt := PADR(aFilProc[nLoop],nTamFil)
	
		dbSelectArea("SEK")
		SEK->(DBSetOrder(2)) //EK_FILIAL+EK_FORNECE
		SEK->(dbSeek( cFilAnt + TRB->CODIGO,.T. ))
	
		While !Eof() .And. SEK->EK_FILIAL == cFilAnt .And. (SEK->EK_FORNECE >= cProvIni .And. SEK->EK_FORNECE <= cProvFim)
	
			SA2->(dbSetOrder(1))
			SA2->(MsSeek( xFilial() + SEK->EK_FORNECE + SEK->EK_LOJA ))
			cHistor := ""
			If SEK->EK_TIPODOC $ "TB.EF.CH.LT"
				cHistor := OemToAnsi(STR0046) // "RECIBO No. "
			ElseIf SEK->EK_TIPODOC == "RG"
				cHistor := OemToAnsi(STR0047)  // "RET. IMPUESTOS"
			ElseIf SEK->EK_TIPODOC == "PA"
				cHistor := OemToAnsi(STR0042)  // "ANTICIPO"
			EndIf
	
			If nSituacao == 1 //Historico
	
				If SEK->EK_TIPODOC $ "TB.PA"
					If SEK->EK_DTDIGIT <= dFechaFim .And.  ! SEK->EK_CANCEL
						If DToS( SEK->EK_DTDIGIT ) < DToS( dFechaIni )
							nCredito := SEK->EK_VLMOED1
							dbSkip()
							Loop
						ElseIf DToS( SEK->EK_DTDIGIT ) >= DToS( dFechaInI ) .And. DToS( SEK->EK_DTDIGIT ) <= DToS( dFechaFim )
							RecLock("TRB",.T.)
							TRB->CODIGO		:=  SEK->EK_FORNECE
							TRB->LOJA		:=  SEK->EK_LOJA
							TRB->FORNECE	:=  SA2->A2_NOME
							TRB->TELEFONE	:=  SA2->A2_TEL
							TRB->NUMERO		:=  AllTrim( SEK->EK_ORDPAGO )
							TRB->PARCELA	:=  SEK->EK_PARCELA
							TRB->TIPO		:=  "OP"
							TRB->SIGLA		:=  "OP"
							TRB->EMISSAO	:=  SEK->EK_DTDIGIT
							TRB->VENCTO		:=  SEK->EK_DTDIGIT
							nTaxa := 0
							If Val(SEK->EK_MOEDA) > 1 .And. MV_PAR10 == 2
								ccampo := ('EK_TXMOE' + StrZero(Val(SEK->EK_MOEDA), 2))
								If SEK->(FieldPos(ccampo)) > 0 .And. SEK->(&cCampo) >0
									nTaxa := SEK->(&cCampo)
								EndIf
							EndIf
	
							TRB->CREDITO	:= TRB->CREDITO + xMoeda(SEK->EK_VALOR, Val(SEK->EK_MOEDA), nMoeda, DDATABASE, MsDecimais(nMoeda), nTaxa)
							TRB->SALDO		:= TRB->CREDITO * -1
							TRB->HISTOR		:= cHistor
							MsUnLock()
						EndIf
					EndIf
				EndIf
	
			Else //Piendente
	
				If SEK->EK_TIPODOC $ "TB.PA"
					If ! SEK->EK_CANCEL
						If DToS( SEK->EK_DTDIGIT ) < DToS( dFechaIni )
							nCredito := SEK->EK_VLMOED1
							dbSkip()
							Loop
						ElseIf DToS( SEK->EK_DTDIGIT ) >= DToS( dFechaIni ) .And. DToS( SEK->EK_DTDIGIT ) <= DToS( dFechaFim )
							RecLock("TRB",.T.)
							TRB->CODIGO		:= SEK->EK_FORNECE
							TRB->LOJA		:= SEK->EK_LOJA
							TRB->FORNECE	:= SA2->A2_NOME
							TRB->TELEFONE	:= SA2->A2_TEL
							TRB->NUMERO		:= AllTrim( SEK->EK_ORDPAGO )
							TRB->PARCELA	:= SEK->EK_PARCELA
							TRB->TIPO		:= "OP"
							TRB->SIGLA		:= "OP"
							TRB->EMISSAO	:= SEK->EK_DTDIGIT
							TRB->VENCTO		:= SEK->EK_DTDIGIT
							If Val(SEK->EK_MOEDA) > 1 .And. ( SEK->(FieldPos("EK_TXMOE" + StrZero(Val(SEK->EK_MOEDA), 2))) > 0)
								nTaxa := If(SEK->("EK_TXMOE" + StrZero(Val(SEK->EK_MOEDA),2))> 0 .And. MV_PAR10 == 2, SEK->("EK_TXMOE" + StrZero(Val(SEK->EK_MOEDA), 2)),0)
							Else
								nTaxa := 0
							EndIf
							TRB->CREDITO	:= TRB->CREDITO + xMoeda(SEK->EK_VALOR, Val(SEK->EK_MOEDA), nMoeda, DDATABASE, MsDecimais(nMoeda), nTaxa)
							TRB->SALDO		:= TRB->CREDITO * -1
							TRB->HISTOR		:= cHistor
							MsUnLock()
						EndIf
					EndIf
				EndIf
			EndIf
			dbSelectArea("SEK")
			dbSkip()
		End
	Next
Return 
