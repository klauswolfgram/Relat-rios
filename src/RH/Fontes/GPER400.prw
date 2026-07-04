/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER400.CH"
#INCLUDE "report.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER400  ³ Autor ³ R.H. - Marcos Stiefano           ³ Data ³ 25.05.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Programacao de Ferias                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER400(void)                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ BOPS           ³  Motivo da Alteracao                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sidney O.   ³07/07/2014³M_RH007  TPRMXI ³ Ajuste para apresentacao da descricao   ³±±
±±³            ³          ³                ³ do centro de custo                      ³±±
±±³Sidney O.   ³11/07/2014³M_RH007  TPRMXI ³ Ajuste na apresentacao da descricao CC  ³±±
±±³Claudinei S.³04/09/2014³          TQGCCM³Incluidos 2 novos perguntes, Data Limite ³±±
±±³            ³          ³                ³Maximo e Data Limite Ideal, para informar³±±
±±³            ³          ³                ³a qtd de dias a considerar no calculo dos³±±
±±³            ³          ³                ³campos Dt Limite ideal e Dt Limite Maximo³±±
±±³            ³          ³                ³do relatorio.      						 ³±±
±±³Thiago Y.M.N³06/01/2015³   TRCTX1       ³Ajuste p/ quando a pergunta tipo do rela-³±±
±±³            ³          ³                ³torio(mv_par08)for 3-Ambos e existir data³±±
±±³ 		   ³          ³                ³de programacao no registro em questao,que³±±
±±³			   ³          ³                ³seja considerada verificacao dentro do   ³±±
±±³			   ³          ³                ³range de datas De\Ate de programacao sen-³±±
±±³            ³          ³                ³do (mv_par09 e mv_par10).                ³±±
±±³Cícero Alves³22/12/2015³ TTVXFZ         ³Ajuste para buscar as informações direto ³±±
±±³            ³          ³                ³da SRF em vez de chamar a função CALC_FER³±±
±±³P. Pompeu   ³04/02/2016³ TUKW09         ³ Correção na tipagem da var. dDataAte 	 ³±±
±±³Gustavo M.  ³01/03/2016³ TUOZGY         ³ Correcao no skip dos funcionarios.	 	 ³±±
±±³Marco A. Glz³02/06/2016³ PCDEF2015_     ³ Se declaran variables necesarias en las ³±±
±±³	     	   ³          ³ 2016-5708      ³ funciones fGetLastPer() y fCarPeriodo()  ±±
±±³Marco A. Glz³02/06/2016³ PCDEF2015_     ³ Se declaran variables necesarias en las ³±±
±±³	     	   ³          ³ 2016-5708      ³ funciones fGetLastPer() y fCarPeriodo()  ±±
±±³Eduardo K.  ³	      ³ MPRIMESP-465   ³ Ajuste na picture de campos que apresen- ±±
±±³			   ³	      ³ 			   ³ tam valores numericos.					  ±±
±±³Paulo O. I. ³29/03/2017³ MRH-7862      ³ remoção de dbsetorder incorreto - SRF    ±±
±±|Claudinei S.|28/04/2017| MRH-482        |Ajustade para considerar corretamente as |±±
±±|            |          |	               |faltas dos funcionários com Regime de    |±±
±±|            |          | 	           |Tempo Parcial quando elas forem          |±±
±±|            |          | 	           |inferiores a 8 faltas.                   |±±
±±³Gabriel A.  ³10/05/2017³DRHPAG-9        ³Ajuste na validação dos períodos por     ³±±
±±³            ³          ³                ³filiais.                                 ³±±
±±³Isabel N.   ³09/08/2017³DRHPAG-4171     ³Alteração no nome do campo "Faltas Venci_³±±
±±³            ³          ³                ³das" p/"D.Abat. Faltas".                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPER400()

	Local	oReport
	Local	aArea 		:= GetArea()

	Private cString	:= "SRA"				// alias do arquivo principal (Base)
	Private cPerg		:= fGetPerg()
	Private aOrd    	:= {OemToAnsi(STR0001),OemToAnsi(STR0002),OemToAnsi(STR0016),OemToAnsi(STR0017),OemToAnsi(STR0018),OemToAnsi(STR0019)}//"Centro de Custo"###"Matricula"###"Nome"###"C.Custo + Nome"###"Filial + Dt.Base"###"Filial + Dt.Inicio"
	Private cAliasSRF	:= "SRF"
	Private dDataAte	:= CtoD("")

	Private nTamMat     := 5 + TamSX3("RA_MAT")[1]
	Private nTamNome    := 32 - TamSX3("RA_MAT")[1]

		/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Carregar os Mnemonicos 	                                   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	SetMnemonicos(NIL,NIL,.T.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte(cPerg,.F.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Forca a impressao no modo Landscape(horizontal)               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()

	RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef  ³ Autor ³ Tatiane               ³ Data ³24/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relacao de Programacao de Ferias  - Release 4                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER400                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GPER400 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oSection3

Local cDesc		:= OemToAnsi(STR0003) + OemToAnsi(STR0004) + " " + OemToAnsi(STR0005)
Local aOrd    	:= If(cPaisLoc <> "MEX",{OemToAnsi(STR0001),OemToAnsi(STR0002),OemToAnsi(STR0016),OemToAnsi(STR0017),OemToAnsi(STR0018),OemToAnsi(STR0019)},{OemToAnsi(STR0001),OemToAnsi(STR0002),OemToAnsi(STR0016),OemToAnsi(STR0017),OemToAnsi(STR0018)})//"Centro de Custo"###"Matricula"###"Nome"###"C.Custo + Nome"###"Filial + Dt.Base"###"Filial + Dt.Inicio"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao dos componentes de impressao                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Inicio definicao do Relatorio
	DEFINE REPORT oReport NAME "GPER400" TITLE OemToAnsi(STR0008) PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc

		oReport:SetTotalInLine(.F.)	// PARA TOTALIZAR EM LINHAS

		DEFINE SECTION oSection1 OF oReport TABLES "SRA", "SRF" TITLE OemToAnsi(STR0047) TOTAL IN COLUMN ORDERS aOrd

			DEFINE CELL NAME "RA_FILIAL" 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_CC" 	 	OF oSection1 ALIAS cString
			DEFINE CELL NAME "RA_MAT" 	 	OF oSection1 ALIAS cString SIZE nTamMat
			DEFINE CELL NAME "RA_NOME" 		OF oSection1 ALIAS cString SIZE nTamNome
			DEFINE CELL NAME "RA_ADMISSA"	OF oSection1 ALIAS cString SIZE 14
			If cPaisLoc == "MEX"				
				DEFINE CELL NAME "DATABAS"		OF oSection1 ALIAS "   "  BLOCK {||cDtBase } 	TITLE oemToAnsi(STR0065) SIZE 10													//-- Data Inicial
				DEFINE CELL NAME "DATAFIM"		OF oSection1 ALIAS "   "  BLOCK {||cPerAquis } 	TITLE oemToAnsi(STR0066) SIZE 22													//-- Data Final
				DEFINE CELL NAME "FERIASVENC"	OF oSection1 ALIAS "   "  BLOCK {||cFerVenc }	TITLE oemToAnsi(STR0067) SIZE 7 PICTURE "@E 9999.9"									//-- Dias da Quantidade de Referencia
				DEFINE CELL NAME "FALTASVEN"	OF oSection1 ALIAS "   "  BLOCK {||cFaltasVen } TITLE oemToAnsi(STR0068) SIZE 7 PICTURE "@E 9999.9"									//-- Dias de Ferias Vencias
				DEFINE CELL NAME "FERIASPRO"	OF oSection1 ALIAS "   "  BLOCK {||cFerProp } 	TITLE oemToAnsi(STR0069) SIZE 7 PICTURE "@E 9999.9"									//-- Dias de Ferias Proporcionais
				DEFINE CELL NAME "FALTAPROP"	OF oSection1 ALIAS "   "  BLOCK {||cFaltasProp }TITLE oemToAnsi(STR0070) SIZE 7 PICTURE "@E 9999.9"									//-- Dias de Faltas Pagos
				DEFINE CELL NAME "TOTAL"		OF oSection1 ALIAS "   "  BLOCK {||cTotal } 	TITLE oemToAnsi(STR0043) SIZE 7 PICTURE "@E 9999.9"									//-- Total de Ferias ( nDiasVenc + nDiasProp - nDFaltaV - nDFaltaP )
			EndIf

			DEFINE SECTION oSection2 OF oSection1 TABLES "SRF" TOTAL IN COLUMN TITLE STR0049
			oSection2:SetHeaderSection(.F.)

				DEFINE CELL NAME "PROGFER"	OF oSection2	ALIAS "   " BLOCK {|| cProgrFer} SIZE 100    //-- Programacao de ferias
				DEFINE CELL NAME "DIASFER"	OF oSection2	ALIAS "   " BLOCK {|| cDiasFer } SIZE 016	 //-- Dias de ferias
				DEFINE CELL NAME "PERC13S"	OF oSection2    ALIAS "   " BLOCK {|| cPerc13  } SIZE 016    //-- Percentual 13 Sal. 
				DEFINE CELL NAME "DIASABO"	OF oSection2	ALIAS "   " BLOCK {|| cDiasAbo } SIZE 070    //-- Dias de Abono

		DEFINE SECTION oSection3  OF oReport TABLES "SRA" TOTAL IN COLUMN  TITLE STR0001

			DEFINE CELL NAME "RA_CC" 		OF oSection3 ALIAS "SRA" TITLE oemToAnsi(STR0001)
			DEFINE CELL NAME "CDESCCC" 		OF oSection3 ALIAS "   "  BLOCK {|| cDescCC } TITLE "" SIZE 50

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReport ºAutor  ³Tatiane Matias      º Data ³  24/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                              º±±
±±º          ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//-- Numerico
Local nOrdem	:= oReport:Section(1):GetOrder()
Local nDiasFer1	:= 0
Local nDiasFer2	:= 0
Local nDiasFer3	:= 0
Local nDiasAbo1	:= 0
Local nDiasAbo2	:= 0
Local nDiasAbo3	:= 0
Local nCnt1		:= 0
Local nX		:= 0
Local nDiasMax	:= 0
Local nDiasIdeal:= 0
Local X			:= 0
Local nPosTbFer	:= 0
Local nTempoParc:= 0
Local nDiasAboN	:= 0
Local nDMes12  	:= 0
Local nDMes01 	:= 0
Local aAreaSRF	:= {}

//-- Objeto
Local oBreakCc
Local oBreakFil
Local oSection1	:= oReport:Section(1)
Local oSection2	:= oSection1:Section(1)
Local oSection3	:= oReport:Section(2)

//-- String
Local cAcessaSRA	:= &("{ || " + ChkRH("GPER400","SRA","2") + "}")
Local cTitulo		:= OemToAnsi(STR0008) // "RELACAO DE PROGRAMACAO DE FERIAS"
Local cFiltro		:= "%"
Local cRProc 		:= ""
Local cRot			:= ""
Local cBreakCC
Local cBreakFil
Local cUserFiltro	:= ""
Local cUsrFt1		:= ""
Local cUsrFt2		:= ""
Local cUltFilCC		:= ""
Local cOldDescCC 	:= ""
Local cLocDescCC 	:= ""
Local cDtAteDesc 	:= ""
Local cValidPer		:= ""
Local cQuebra		:= Replicate("-",75)
Local cDia2501    	:= SuperGetMv("MV_DIA2501", ,"N")

//-- Data
Local DFimPAqui		:= ""
Local DPRPAqui		:= ""
Local dDtIProg1
Local dDtIProg2
Local dDtIProg3
Local dDataFim

//-- Logico
Local lTemCpoProg
Local lUnicoPer		:= .F.
Local lOldDescCC	:= .F.
Local lRCHComp		:= .F.

//-- Array
Local aLogFil		:= {}
Local aLogDtInv		:= {}
Local aLog			:= {}
Local cAliasQry		:= GetNextAlias()
Local cVerbaFer		:= FGetCodFol("0072", .T.)
Local cProcAnt		:= ""
Local aProc			:= {}
Local cChaveAnt		:= ""
Local nReg			:= 0
Local oSX1

Local aFields       := {}
Local cAliasTemp    := ""
Local cMatAnt       := ""
Local nCountTemp    := 0
Local aAreaTemp     := {}
Local oTmpImpr

//Redefine o tamanho da celula RA_ADMISSA quando a impressão for PDF
If oReport:nDevice == 6 //PDF
	If ValType(oSection1:cell('RA_ADMISSA')) == "O"
		oSection1:cell("RA_ADMISSA"):SetSize(17)
	EndIf
EndIf

lMetFalP 	:= If( Type("lMetFalP") == "U", .F. , lMetFalP)
lMetFalV 	:= If( Type("lMetFalV") == "U", .F. , lMetFalV)
lMetadeFal	:= If( Type("lMetadeFal") == "U", .F. , lMetadeFal)
lTempoParc	:= If( Type("lTempoParc") == "U", .F. , lTempoParc)

SetMnemonicos(xFilial("RCA"),NIL,.T.,"P_REGPARCI")
P_REGPARCI	:= If( Type("P_REGPARCI") == "U", .F. , P_REGPARCI)

SetMnemonicos(xFilial("RCA"),NIL,.T.,"lRegTemPar")
lRegTemPar			:= If( Type("lRegTemPar") == "U", .F., lRegTemPar)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Numerico
Private Normal	:= 0
Private Descanso	:= 0

//-- Array
Private aTabFer	:= {}		// Tabela para calculo dos dias de ferias
Private aTabFer2	:= {}    	// Tabela para calculo dos dias de ferias para regime de tempo parcial
Private nDiasDir	:= 0		//# Nr. Dias de Direito
Private aCodFol	:= If(cPaisLoc=="BRA",ARRAY(1),{})		          // Incializada para nao ser carregada em Calc_Fer

//-- String
Private cPerFeAc   := If(cPaisLoc=="URU","S",GetMv("MV_FERPAC",,"N")) // Ferias por ano civil
Private cProgrFer  := ""
Private cPerc13    := ""
Private cDiasFer   := ""
Private cDiasAbo   := ""
Private cDescCC    := ""
Private cProcesso  := ""
Private cPeriodo   := ""
Private cSemana    := ""
Private cAnoMes	   := ""
Private lUltSemana := ""
Private nPosSem    := ""
Private cTurno     := ""
Private cTipoRot		:= ""

//-- Logico
Private lFirst		:= .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a existencia dos campos de programacao ferias no SRF³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lTemCpoProg := fTCpoProg()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transforma parametros do tipo Range em  expressao ADPL para  ³
//³ ser utilizada no filtro                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSQLExpr(cPerg)								//--Deve ser antes de alimentar as mv's

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega pergunte                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilAtual	:= mv_par01                          			//  Filial
cCCusto		:= mv_par02                          			//  Centro de Custo De
cMatric		:= mv_par03                          			//  Matricula De
cNome		:= mv_par04                          			//  Nome Ate
cSituacao	:= mv_par05										//  Situacao Funcionario
cCategoria	:= mv_par06                          			//  Categoria Funcionario
lSalta		:= If( mv_par07 == 1 , .T. , .F. )   			//  Salta Pagina Quebra C.Custo
nTipFerias	:= mv_par08                          			//  1-Nao programadas, 2-Programadas e 3-Ambas
dProgDe		:= mv_par09                          			//  Data inicial para ferias programdas
dProgAte	:= mv_par10                          			//  Data Final   para ferias programdas
nPeriodo	:= mv_par11							 			//  Imprimir 1 periodo, 2 periodos ou os 3 periodos
cProcesso	:= If( Empty(mv_par12),"", AllTrim(mv_par12) )	//  Processo
If cPaisLoc <> "BRA"										//  Asegurar que no de errores en la impresion de parametros
	mv_par16 := mv_par13
	mv_par17 := mv_par14
	mv_par18 := mv_par15
EndIf
cDataRef	:= If( Empty(mv_par18),dDataBase, mv_par18)		//  Data de referência a qual será usada para projeção de férias proporcionais

//Ajuste a variável cSituacao quando execução vier via job.
If isBlind() .And. Empty(SubStr(mv_par05, 5, 1))
	cSituacao := SubStr(mv_par05, 5, 1) + SubStr(mv_par05, 1, 4)
EndIf

If cPerg == "GP400RB"
	cTurno := mv_par19
ElseIf GetApoInfo("MSLIB.PRW")[4] >= CTOD("04/09/2018")
	oSX1 := FWSX1Util():New()

	oSX1:AddGroup(cPerg)
	oSX1:SearchGroup()

	If Len(oSX1:aGrupo) >= 1 .And. Len(oSX1:aGrupo[1][2]) >= 19
		cTurno := mv_par19
	EndIf

	FreeObj(oSX1)
Else
	DbSelectArea("SX1")
	DbSetorder(1)

	If SX1->( DbSeek("GP400RA   19") )
		cTurno := mv_par19
	EndIf
EndIf

DbSelectArea("RCH")
RCH->( DbSetOrder(1) )
lRCHComp := Empty(RCH->RCH_FILIAL)

If cPaisLoc == "BRA"
	nTipo	   	:= mv_par13										// 1-Programacao de Ferias, 2-Programacao de Recesso
Else
	nTipo := 1
EndIf

If nTipo == 1
	cCategoria 	:= mv_par06                          	//  Categoria Funcionario
Else
	cCategoria 	:= "EG"                          		//  Categoria Estagiario Horista e Mensalista
Endif

If nTipo == 2
	nPeriodo	:= 1
	cVerbaFer	:= FGetCodFol("0891", .T.)
Endif

If cPaisLoc == "BRA"
	nDiasMax	:= If( Empty(mv_par14), 45 , val(mv_par14) )
	nDiasIdeal	:= If( Empty(mv_par15), 30 , val(mv_par15) )
Else
	nDiasMax	:= 45
	nDiasIdeal	:= 30
EndIf

If ValType(mv_par16) == "N"
	nFilPer := mv_par16
Else
	nFilPer := 2
EndIf
If ValType(mv_par17) == "N"
	nFilDat := mv_par17
Else
	nFilDat := 2
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera Titulo do relatorio                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTipo == 1
	cTitulo 	:= If(AllTrim(oReport:Title())==AllTrim(cTitulo),cTitulo,oReport:Title()  )  + " "
	cTitulo 	+= If(nOrdem==1,STR0012,If(nOrdem==2,STR0013,If(nOrdem==3,STR0020,If(nOrdem==4,STR0021,If(nOrdem==5,STR0022,STR0023))))) //"RELACAO DE PROGRAMACAO DE FERIAS "###"( C.CUSTO )"###"( MATRICULA )"###"( NOME )"###"( C.CUSTO + NOME )"###"( DATA BASE )"###"( DATA INICIO )"

Else
	cTitulo 	:= OemToAnsi(STR0051) + " "
	cTitulo 	+= If(nOrdem==1,STR0012,If(nOrdem==2,STR0013,If(nOrdem==3,STR0020,If(nOrdem==4,STR0021,If(nOrdem==5,STR0022,STR0023))))) //"RELACAO DE PROGRAMACAO DE RECESSO "###"( C.CUSTO )"###"( MATRICULA )"###"( NOME )"###"( C.CUSTO + NOME )"###"( DATA BASE )"###"( DATA INICIO )"

Endif

oReport:SetTitle(cTitulo)

If oReport:GetOrientation() == 2
	oSection2:Cell("DIASABO"):SetSize(90)
EndIf

If nTipo == 2 
		//-- Estagiario
	   	DEFINE CELL NAME "DATABAS"		OF oSection1 ALIAS "   "  BLOCK {||cDtBase } 	TITLE oemToansi(STR0033) + CRLF + oemToAnsi(STR0055) SIZE 10			//-- Data Base Recesso
		DEFINE CELL NAME "PERQUISITI"	OF oSection1 ALIAS "   "  BLOCK {||cPerAquis } 	TITLE oemToansi(STR0034) + CRLF + oemToAnsi(STR0072) SIZE 22			//-- Periodo de Recesso
		DEFINE CELL NAME "DT_LIDEAL"	OF oSection1 ALIAS "   "  BLOCK {||dLimideal } 	TITLE oemToAnsi(STR0036) + CRLF + oemToAnsi(STR0037) SIZE 10			//-- Dt.Limite ideal ( DFIMPAQUI + 30)=DT_LIDEAL
		DEFINE CELL NAME "DT_LMAX"		OF oSection1 ALIAS "   "  BLOCK {||dLimMax } 	TITLE oemToAnsi(STR0036) + CRLF + oemToAnsi(STR0038) SIZE 10 			//-- Dt.Limite maxima (DPRPAQUI - 45) =DT_LMAX
		DEFINE CELL NAME "FERIASVENC"	OF oSection1 ALIAS "   "  BLOCK {||cFerVenc }	TITLE oemToAnsi(STR0055) + CRLF + oemToAnsi(STR0056) PICTURE "@E 999.9"	//-- Dias de Recesso Vencidos
	   	DEFINE CELL NAME "FERIASPRO"	OF oSection1 ALIAS "   "  BLOCK {||cFerProp } 	TITLE oemToAnsi(STR0055) + CRLF + oemToAnsi(STR0041) PICTURE "@E 999.9"	//-- Dias de Recesso Proporcionais
	  	DEFINE CELL NAME "TOTAL"		OF oSection1 ALIAS "   "  BLOCK {||cTotal } 	TITLE oemToAnsi(STR0043) + CRLF + oemToAnsi(STR0055) PICTURE "@E 999.9"	//-- Total Recesso ( nDiasVenc + nDiasProp - nDFaltaV - nDFaltaP )	  	
ElseIf cPaisLoc <> "MEX"
		DEFINE CELL NAME "DATABAS"		OF oSection1 ALIAS "   "  BLOCK {||cDtBase } 	TITLE oemToansi(STR0033) + CRLF + oemToAnsi(STR0039) SIZE 14						//-- Data Base de Ferias
		DEFINE CELL NAME "PERQUISITI"	OF oSection1 ALIAS "   "  BLOCK {||cPerAquis } 	TITLE oemToansi(STR0034) + CRLF + oemToAnsi(STR0035) SIZE 33						//-- Periodo aquisitivo
		DEFINE CELL NAME "DT_LIDEAL"	OF oSection1 ALIAS "   "  BLOCK {||dLimideal } 	TITLE oemToAnsi(STR0036) + CRLF + oemToAnsi(STR0037) SIZE 14						//-- Dt.Limite ideal ( DFIMPAQUI + 30)=DT_LIDEAL
		DEFINE CELL NAME "DT_LMAX"		OF oSection1 ALIAS "   "  BLOCK {||dLimMax } 	TITLE oemToAnsi(STR0036) + CRLF + oemToAnsi(STR0038) SIZE 14 						//-- Dt.Limite maxima (DPRPAQUI - 45) =DT_LMAX
		DEFINE CELL NAME "FERIASVENC"	OF oSection1 ALIAS "   "  BLOCK {||cFerVenc }	TITLE oemToAnsi(STR0039) + CRLF + oemToAnsi(STR0040) SIZE 6 PICTURE "@E 9999.9"		//-- Dias de Recesso Vencidas
		DEFINE CELL NAME "FALTASVEN"	OF oSection1 ALIAS "   "  BLOCK {||cFaltasVen } TITLE oemToAnsi(STR0078) + CRLF + oemToAnsi(STR0042) SIZE 6 PICTURE "@E 9999.9"		//-- D. Abat. Faltas
		DEFINE CELL NAME "FERIASPRO"	OF oSection1 ALIAS "   "  BLOCK {||cFerProp } 	TITLE oemToAnsi(STR0039) + CRLF + oemToAnsi(STR0041) SIZE 6 PICTURE "@E 9999.9"		//-- Dias de Ferias Proporcionais
		DEFINE CELL NAME "FALTAPROP"	OF oSection1 ALIAS "   "  BLOCK {||cFaltasProp }TITLE oemToAnsi(STR0042) + CRLF + oemToAnsi(STR0041) SIZE 6 PICTURE "@E 9999.9"		//-- Dias de Faltas proporcionais
		DEFINE CELL NAME "TOTAL"		OF oSection1 ALIAS "   "  BLOCK {||cTotal } 	TITLE oemToAnsi(STR0043) + CRLF + oemToAnsi(AllTrim(STR0039)) SIZE 6 PICTURE "@E 9999.9"		//-- Total de Ferias ( nDiasVenc + nDiasProp - nDFaltaV - nDFaltaP )
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quebra de pagina C.Custo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (nOrdem = 1 .or. nOrdem = 4 .or. (nordem = 5 .and. lSalta))
	DEFINE BREAK oBreakCc OF oReport WHEN {|| SRA->RA_FILIAL+SRA->RA_CC } TITLE { || OemToansi(STR0064 + STR0063) }
	oBreakCc:OnBreak({|x,y| cBreakCC := OemToansi(STR0064 + STR0063) + oSection1:Cell("RA_CC"):GetText() + " - " + Iif(lOldDescCC , cOldDescCC, cLocDescCC) })
	oBreakCc:SetTotalText({||cBreakCC})

	DEFINE FUNCTION FROM oSection1:Cell("FERIASVENC") FUNCTION SUM BREAK oBreakCC NO END SECTION PICTURE "@E 9999.9"
	DEFINE FUNCTION FROM oSection1:Cell("FERIASPRO") FUNCTION SUM BREAK oBreakCC NO END SECTION PICTURE "@E 9999.9"

	If nTipo == 1
		DEFINE FUNCTION FROM oSection1:Cell("FALTASVEN") FUNCTION SUM BREAK oBreakCC NO END SECTION PICTURE "@E 9999.9"
		DEFINE FUNCTION FROM oSection1:Cell("FALTAPROP") FUNCTION SUM BREAK oBreakCC NO END SECTION PICTURE "@E 9999.9"
	Endif

	DEFINE FUNCTION FROM oSection1:Cell("TOTAL") FUNCTION SUM BREAK oBreakCC NO END SECTION PICTURE "@E 99999.9"

	If lSalta
		oBreakCc:SetPageBreak(.T.)
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quebra de pagina Filial                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE BREAK oBreakFil OF oReport WHEN {|| SRA->RA_FILIAL }  TITLE { || OemToansi(STR0064 + STR0062) + cBreakFil }
oBreakFil:OnBreak({|x,y| cBreakFil := x })
DEFINE FUNCTION FROM oSection1:Cell("FERIASVENC") FUNCTION SUM BREAK oBreakFil NO END SECTION PICTURE "@E 9999.9"
DEFINE FUNCTION FROM oSection1:Cell("FERIASPRO") FUNCTION SUM BREAK oBreakFil NO END SECTION PICTURE "@E 9999.9"

If nTipo == 1
	DEFINE FUNCTION FROM oSection1:Cell("FALTASVEN") FUNCTION SUM BREAK oBreakFil NO END SECTION PICTURE "@E 9999.9"
	DEFINE FUNCTION FROM oSection1:Cell("FALTAPROP") FUNCTION SUM BREAK oBreakFil NO END SECTION PICTURE "@E 9999.9"
Endif

DEFINE FUNCTION FROM oSection1:Cell("TOTAL") FUNCTION SUM BREAK oBreakFil NO END SECTION PICTURE "@E 99999.9"

oBreakFil:SetPageBreak(.F.)
oSection1:SetHeaderPage(.T.)    //-- Imprime Cabecalho padrao
oSection2:SetHeaderPage(.F.)    //-- Imprime Cabecalho padrao
oSection3:SetHeaderPage(.F.)    //-- Imprime Cabecalho padrao

IF lSalta
	If nOrdem == 1
		cOrdem	:= "%SRA.RA_FILIAL , SRA.RA_CC , SRA.RA_MAT, SRF.RF_DATABAS%"
	ElseIf nOrdem == 2
		cOrdem	:= "%SRA.RA_FILIAL , SRA.RA_MAT, SRA.RA_CC, SRF.RF_DATABAS%"
	ElseIf nOrdem == 3
		cOrdem	:= "%SRA.RA_FILIAL , SRA.RA_NOME , SRA.RA_MAT, SRA.RA_CC, SRF.RF_DATABAS%"
	ElseIf nOrdem == 4
		cOrdem	:= "%SRA.RA_FILIAL , SRA.RA_CC , SRA.RA_NOME, SRF.RF_DATABAS%"
	ElseIf nOrdem == 5
		cOrdem	:= "%SRF.RF_FILIAL , SRF.RF_DATABAS , SRF.RF_MAT, SRA.RA_CC%"
	ElseIf nOrdem == 6
		cOrdem	:= "%SRF.RF_FILIAL , SRF.RF_DATAINI , SRF.RF_MAT, SRA.RA_CC%"
	EndIf
Else
	If nOrdem == 1
		cOrdem	:= "%SRA.RA_FILIAL , SRA.RA_CC , SRA.RA_MAT, SRF.RF_DATABAS%"
	ElseIf nOrdem == 2
		cOrdem	:= "%SRA.RA_FILIAL , SRA.RA_MAT, SRF.RF_DATABAS%"
	ElseIf nOrdem == 3
		cOrdem	:= "%SRA.RA_FILIAL , SRA.RA_NOME , SRA.RA_MAT, SRF.RF_DATABAS%"
	ElseIf nOrdem == 4
		cOrdem	:= "%SRA.RA_FILIAL , SRA.RA_CC , SRA.RA_NOME, SRF.RF_DATABAS%"
	ElseIf nOrdem == 5
		cOrdem	:= "%SRF.RF_FILIAL , SRF.RF_DATABAS , SRF.RF_MAT, SRA.RA_CC%"
	ElseIf nOrdem == 6
		cOrdem	:= "%SRF.RF_FILIAL , SRF.RF_DATAINI , SRF.RF_MAT%"
	EndIf
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona no filtro o parametro tipo Range                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !cFilAtual=Space(FwGetTamFilial)
	cFiltro += cFilAtual + " AND "
EndIf

If !Empty(cCCusto)
	cFiltro += cCCusto + " AND "
EndIf

If !Empty(cMatric)
	cFiltro += cMatric + " AND "
EndIf

If !Empty(cNome)
	cFiltro += cNome + " AND "
EndIf

If !Empty(cTurno)
	cFiltro += cTurno + " AND "
EndIf


/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Monta a string de Processos para Impressao                   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If !Empty(cProcesso) .And. AllTrim(cProcesso) <> "*"
	cRProc := ""
	nTamCod := GetSx3Cache( "RCJ_CODIGO" , "X3_TAMANHO" )
	For X := 1 to Len(cProcesso) step 5
		If Len(Subs(cProcesso,X,5)) < nTamCod
			cAuxPrc := Subs(cProcesso,X,5) + Space(nTamCod - Len(Subs(cProcesso,X,5)))
		Else
			cAuxPrc := Subs(cProcesso,X,5)
		EndIf
		cRProc += "'" + cAuxPrc + "',"
	Next X
	cRProc := SubStr(cRProc,1,Len(cRProc)-1)

	cFiltro += "RA_PROCES IN (" + cRProc + ") AND "
EndIf

// Seção Funcionários
cUsrFt1	:= oSection1:GetUserExp( cString,.T.)

// Seção Centro de Custo
cUsrFt2 := oSection3:GetUserExp( cString,.T.)

cUserFiltro := If( !Empty(cUsrFt1), cUsrFt1, "" )

cUserFiltro += If( !Empty(cUserFiltro) .And. !Empty(cUsrFt2), " AND " + cUsrFt2 , If( !Empty(cUsrFt2), cUsrFt2 ,"" ) )

cUserFiltro += If( !Empty(cUserFiltro), " AND ", "" )

cFiltro += If( !Empty(cUserFiltro), cUserFiltro, "" )

cFiltro += 'RA_SITFOLH IN ( ' + fSqlIN(cSituacao,1) + ' ) AND '
cFiltro += 'RA_CATFUNC IN ( ' + fSqlIN(cCategoria,1) + ') %'

BeginSql alias cAliasQry
	SELECT SRA.RA_FILIAL, SRA.RA_MAT, SRA.R_E_C_N_O_ AS RARECNO, SRF.R_E_C_N_O_ AS SRFRECNO, SRF.RF_DATAINI
	FROM %table:SRA% SRA
	INNER JOIN %table:SRF% SRF ON SRA.RA_FILIAL = SRF.RF_FILIAL AND SRA.RA_MAT = SRF.RF_MAT AND SRF.RF_PD = %exp:cVerbaFer% AND SRF.%NotDel% AND SRF.RF_STATUS IN (' ','1')
	WHERE %exp:cFiltro%
	AND SRA.%NotDel%
	ORDER BY %exp:cOrdem%
EndSql

COUNT TO nReg
(cAliasQry)->(dbGotop())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o total da regua da tela de processamento do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(nReg)

cFiAnt := Space(FwGetTamFilial)
cCcAnt := Space(20)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa a cada quebra de pagina                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:OnPageBreak( {|| lFirst:= .T. }  )

If nOrdem == 5 .Or. nOrdem == 6
	AAdd( aFields, { "RA_FILIAL", "C", FWGETTAMFILIAL     , 0 } )
	AAdd( aFields, { "RA_MAT"   , "C", TamSx3("RA_MAT")[1], 0 } )
	AAdd( aFields, { "RARECNO"  , "N", 08                 , 0 } )
	AAdd( aFields, { "SRFRECNO" , "N", 08                 , 0 } )
	AAdd( aFields, { "RECNOTMP" , "N", 08                 , 0 } )
	AAdd( aFields, { "RECNOTMP2", "N", 08                 , 0 } )

	If nOrdem == 6
		AAdd(aFields, {"RF_DATAINI", "D", TamSx3("RF_DATAINI")[1], 0 })
	EndIf

	cAliasTemp := GetNextAlias()

	oTmpImpr := FWTemporaryTable():New(cAliasTemp, aFields)
	oTmpImpr:AddIndex("IND01", {"RA_FILIAL", "RA_MAT", "RECNOTMP"})
	oTmpImpr:AddIndex("IND02", {"RECNOTMP"}) //Ordem da query
	oTmpImpr:AddIndex("IND03", {"RECNOTMP2", "RECNOTMP"}) //Ordem de impressão
	
	If nOrdem == 6
		oTmpImpr:AddIndex("IND04", {"RA_FILIAL", "RF_DATAINI"}) //Ordem de impressão
	EndIf

	oTmpImpr:Create()

	While !( (cAliasQry)->( EOF() ) )
		RecLock( cAliasTemp,.T. )
			(cAliasTemp)->RA_FILIAL 	:= (cAliasQry)->RA_FILIAL
			(cAliasTemp)->RA_MAT    	:= (cAliasQry)->RA_MAT
			(cAliasTemp)->RARECNO   	:= (cAliasQry)->RARECNO
			(cAliasTemp)->SRFRECNO		:= (cAliasQry)->SRFRECNO
			
			If nOrdem == 6
				(cAliasTemp)->RF_DATAINI := sTod((cAliasQry)->RF_DATAINI)
			EndIf
			
			nCountTemp++
			(cAliasTemp)->RECNOTMP  := nCountTemp
			(cAliasTemp)->RECNOTMP2 := 0

		(cAliasTemp)->( MsUnlock() )

		(cAliasQry)->( DbSkip() )
	EndDo

	(cAliasQry)->( DbCloseArea() )

	nCountTemp := 0
	(cAliasTemp)->( DbSetOrder(2) ) //RECNOTMP
	(cAliasTemp)->( DbGoTop() )

	While !( (cAliasTemp)->( EOF() ) )
		If !( Empty( (cAliasTemp)->RECNOTMP2 ) )
			(cAliasTemp)->( DbSkip() )
			Loop
		EndIf

		cMatAnt   := (cAliasTemp)->RA_FILIAL + (cAliasTemp)->RA_MAT
		aAreaTemp := (cAliasTemp)->( GetArea() )
		
		(cAliasTemp)->( DbSetOrder(1) ) //RA_FILIAL+RA_MAT+RECNOTMP

		If (cAliasTemp)->(MsSeek(cMatAnt))
			nCountTemp++

			While (cAliasTemp)->RA_FILIAL + (cAliasTemp)->RA_MAT == cMatAnt
				(cAliasTemp)->RECNOTMP2 := nCountTemp	
				(cAliasTemp)->( DbSkip() )
			EndDo
		EndIf
		
		RestArea( aAreaTemp )
		(cAliasTemp)->( DbSkip() )
	EndDo

	cAliasQry := cAliasTemp
	If nOrdem == 6
		(cAliasQry)->(DbSetOrder(4)) // RA_FILIAL + RF_DATAINI
	Else
		(cAliasQry)->(DbSetOrder(3)) //RECNOTMP2
	EndIf

	(cAliasTemp)->( DbGoTop() )
EndIf

//-- Incializa impressão
While !(cAliasQry)->(Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Incrementa Regua Processamento                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SRA")
	SRA->(dbGoto((cAliasQry)->RARECNO))

	dbSelectArea("SRF")
	SRF->(dbGoto((cAliasQry)->SRFRECNO))

	If nFilPer == 1 .And. Ascan(aProc,{|x| x == SRA->RA_FILIAL+SRA->RA_MAT}) > 0
		//somente 1 periodo aberto por funcionario
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	oReport:IncMeter()

	If oReport:Cancel()
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Carrega tabela para apuracao dos dias de ferias - aTabFer    |
	//| 1-Meses Periodo    2-Nro Periodos   3-Dias do Mes    4-Fator |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc == "VEN"
		//# Tratamento pra Venezuela - Busca Tabela S006
		fRetTab(@aTabFer,"S006",4,,fCalcFimAq(Iif(empty(dDataRef),dDataBase,dDataRef)),SRA->RA_SINDICA)
		If len(aTabFer)<> 0 		//Previne qdo aTabFer estiver vazia, devido RCC vazia
			nDiasDir := aTabFer[6]
		Endif

	ElseIf cPaisLoc == "PER"
		//# Tratamento pro Peru - Busca Tabela S017
		fRetTab(@aTabFer,"S017",,,fCalcFimAq(Iif(dDataRef==Nil,dDataBase,dDataRef)),)

		If SRA->RA_MEIOPER == "1" //# Part Time
			If len(aTabFer)<> 0
				nDiasDir := aTabFer[6]
			EndIf
		Else
			If len(aTabFer)<> 0
				nDiasDir := aTabFer[5]
			Endif
		EndIf
	Else
		If (cProcAnt <> SRA->RA_PROCES .And. IIF(lSalta, cChaveAnt <> SRA->(RA_FILIAL+RA_MAT+RA_CC), cChaveAnt <> SRA->(RA_FILIAL+RA_MAT)))
			cProcesso 	:= SRA->RA_PROCES
			cProcAnt	:= cProcesso
			cTipoRot	:= "3"
			cRot 		:= fGetCalcRot(cTipoRot)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carrega o periodo atual de calculo (aberto)                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fGetLastPer( @cPeriodo,@cSemana , cProcesso, cRot , .T., .F., @cAnoMes )

			aPeriodo := {}

			If Empty(cPeriodo)
				MsgAlert(STR0071) //"A configuração dos períodos esta incorreta. Verifique o cadastro de períodos."
			EndIf

			//Carrega todos os dados do periodo
			fCarPeriodo( cPeriodo , cRot , @aPeriodo, @lUltSemana, @nPosSem)

			If Len(aPeriodo) == 0
				If lRCHComp
					If !( cPeriodo $ cValidPer )
						cValidPer += cPeriodo + "/"
						aAdd(aLogFil,cPeriodo)
					EndIf

					(cAliasQry)->(dbSkip())
					Loop
				Else
					If !( SRA->RA_FILIAL + cPeriodo $ cValidPer )
						cValidPer += SRA->RA_FILIAL + cPeriodo + "/"
						aAdd(aLogFil,SRA->RA_FILIAL + Space(Max(1,7-FWGETTAMFILIAL)) + cPeriodo)
					EndIf

					(cAliasQry)->(dbSkip())
					Loop
				EndIf
			Else
		    	dDataDe := aPeriodo[nPosSem,3]
		    	dDataAte := aPeriodo[nPosSem,4]
			EndIf
		Else
			If lRCHComp
				If ( cPeriodo $ cValidPer )
					(cAliasQry)->(dbSkip())
					Loop
				EndIf
			Else
				If ( SRA->RA_FILIAL + cPeriodo $ cValidPer )
					(cAliasQry)->(dbSkip())
					Loop
				EndIf
			EndIf
		EndIf

		If (lSalta .AND. cChaveAnt <> SRA->(RA_FILIAL+RA_MAT+RA_CC)) .OR. (!lSalta .AND. cChaveAnt <> SRA->(RA_FILIAL+RA_MAT))
		 	fTab_Fer(@aTabFer,,@aTabFer2)
			//Se as horas semanais forem inferiores a 26, e o Mnemonico P_REGPARCI estiver ativo,
			//utiliza os dias de férias da tabela S065 - Tabela de férias tempo parcial (Artigo 130A da CLT)
			If cPaisLoc == "BRA"
				nTempoParc := SRA->RA_HRSEMAN
				If SRA->RA_HOPARC == "1" .And. nTempoParc <= 25 .And. nTempoParc  > 0 .And. Len(aTabFer2) > 0	.And. P_REGPARCI
					nPosTbFer := Ascan(aTabFer2, { |X|  nTempoParc <= X[6] .And. nTempoParc > X[5] })
					If nPosTbFer > 0
						aTabFer := aClone(aTabFer2[nPosTbFer])
					Endif
				Endif
			EndIf

			If len(aTabFer)<> 0
				nDiasDir := aTabFer[3]
			EndIf
		EndIf
	EndIf


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calculo dos Dias de Ferias Vencidas e a Vencer               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAreaSRF := SRF->(GetArea())

	nDiasVenc := nDiasProp := nDiasAbono := 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calculo dias de ferias pela data de inicio das ferias progrmadas³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nDiaVen	:= 0 												//Dias de Ferias qdo efetua programacao
	nDiaPro	:= 0

	aPerFerias := {}
	Calc_Fer(@aPerFerias,cDataRef,,,,,,.F.,SRF->RF_DATABAS)		

	//Posicionar no periodo aberto atual
	nPosFer	:= aScan(aPerFerias,{ |X| X[8] == "1" .And. SRF->RF_DATABAS = X[1] })

	If nPosFer <= 0
		aAdd(aLogDtInv,SRF->RF_FILIAL + ' | ' + SRF->RF_MAT + ' | '+ DTOC(cDataRef) + '')
		(cAliasQry)->(dbSkip())
		Loop
	EndIf
	nDiasVenc  := aPerFerias[nPosFer][3]
	nDiasProp  := aPerFerias[nPosFer][4]

	If nDiasVenc > 0 .And. aPerFerias[nPosFer][14] > 0
		nDiasVenc	:= Max(nDiasVenc - aPerFerias[nPosFer][14], 0)
	Elseif nDiasVenc == 0 .And. nDiasProp > 0 .And. aPerFerias[nPosFer][14] > 0
		nDiasProp   :=  nDiasProp - aPerFerias[nPosFer][14]
	Endif

	If ! Empty(SRF->RF_DATAINI)
		// aPerFerias - Mnemonico tipo Publico com os Periodos de Ferias
		nDiaVen := SRF->RF_DFERVAT
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calculo dias de  faltas                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nDFaltaV:= SRF->RF_DFALVAT
	nDFaltaP:= SRF->RF_DFALAAT
	
	//Dt. Referência futura: Possui dias vencidos, não possui dias proporcionais.. converte faltas proporcionais em faltas vencidas
	If nDiasVenc > 0 .And. Empty(nDiasProp) 
		If Empty(nDFaltaV) .And. nDFaltaP > 0
			nDFaltaV := nDFaltaP
			nDFaltaP := 0
		EndIf
	EndIf

	TabFaltas(@nDFaltaV)
	lMetFalV := lMetadeFal
	TabFaltas(@nDFaltaP)
	lMetFalP := lMetadeFal
	If !lMetFalP
		nDFaltaP := (nDFaltaP / 30) * nDiasProp
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Montagem da data do inicio da programacao das ferias         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dDtIProg1 	:= SRF->RF_DATAINI
	dDtIProg2 	:= dDtIProg3 := CTOD("")
	nDiasFer1 	:= nDiasFer2 := nDiasFer3 := 0
	nDiasAbo1	:= nDiasAbo2 := nDiasAbo3 := 0
	lUnicoPer	:= .F.

	//-- Prioriza as informacoes digitadas no novos cpos de program.
	If lTemCpoProg
		dDtIProg2 := SRF->RF_DATINI2
		dDtIProg3 := SRF->RF_DATINI3
		nDiasFer1 := SRF->RF_DFEPRO1
		nDiasFer2 := SRF->RF_DFEPRO2
		nDiasFer3 := SRF->RF_DFEPRO3
		nDiasAbo1 := SRF->RF_DABPRO1
		nDiasAbo2 := SRF->RF_DABPRO2

		If cPaisLoc == "BRA" .or. cPaisLoc == "PTG"
			nDiasAbo3 := SRF->RF_DABPRO3
		EndIf

		lUnicoPer := If(  (nDiasFer1+nDiasAbo1) == nDiaVen , .T., lUnicoPer)
	EndIf

	If cPaisLoc == "BRA"
		//-- Calcula dias de abono
		If SRF->RF_TEMABPE == "S" .And.  ! Empty(SRF->RF_DATAINI) .And. nDiasAbo1 = 0 .And. nDiasFer1 = 0
			nDiasAboN	:= Min(nDiaVen-(cAliasSRF)->RF_DFERANT,aTabFer[3])
			nDiasAbo1	:= ( nDiasAboN - If(!lMetFalV, If(!lTempoParc, nDFaltaV, 0), nDiasAboN / 2 )) /3
			nDiasAbo1	:= Int(nDiasAbo1)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se Ferias forem  gozadas em  um  unico periodo, proporcionaliza³
			//³ o abono pecuniario, se nao, utiliza o que for informado nos cam³
			//³ pos de dias de ferias e abono de cada  periodo                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ElseIf SRF->RF_TEMABPE == "S" .And. lUnicoPer
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Garantir que os dias de gozo e abono pecuniario estejam iguais ³
			//³ ao total de dias de ferias vencidas antes de fazer a proporcio-³
			//³ nalizacao dos dias de abono pecuniario em funcao das faltas no ³
			//³ periodo aquisitivo.                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nDiasAbo1	:= int( ( nDiaVen - IF(!lMetFalV, If(!lTempoParc, nDFaltaV, 0), nDiaVen / 2 )) / 3 )
		EndIf
	Endif

	//--------------------------------------------------------------------//
	//  Impressao nTipFerias = 1-Nao programadas, 2-Programadas e 3-Ambas //
	//--------------------------------------------------------------------//
	If nTipFerias == 1 .AND.  ;			
		(((nDiasFer1 + nDiasFer2 + nDiasFer3 + nDiasAbo1 + nDiasAbo2 + nDiasAbo3) >= (IIf(Empty(SRF->RF_DATAINI),nDiasVenc,nDiaVen) + nDiasProp)) .OR.; //todos os dias estao programados
		(!Empty(dDtIProg1) .AND. !Empty(dDtIProg2) .AND. !Empty(dDtIProg3))) //possui todas as programacoes
		(cAliasQry)->(dbSkip())
		Loop
	ElseIf Empty(dDtIProg1) .And. Empty(dDtIProg2) .And. Empty(dDtIProg3) .And. nTipFerias == 2
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Ferias Programdas no Intervalo Definido			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nTipFerias == 2 .Or. (nTipFerias == 3 .And. (!Empty(dDtIProg1) .Or. !Empty(dDtIProg2) .Or. !Empty(dDtIProg3)))) .And.;
		(dDtIProg1 < dProgDe .Or. dDtIProg1 > dProgAte) .And.;
		(dDtIProg2 < dProgDe .Or. dDtIProg2 > dProgAte) .And.;
		(dDtIProg3 < dProgDe .Or. dDtIProg3 > dProgAte)

		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica Quebra de Centro de Custo e Filial                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If nOrdem == 1 .Or. nOrdem == 4 .OR. lSalta
		If !(cCcAnt == SRA->RA_CC) .or. !(cFiAnt == SRA->RA_FILIAL)
			If !(cCcAnt == Space(20))
				oReport:ThinLine()
			EndIf

			If SRA->RA_FILIAL+SRA->RA_CC != cUltFilCC
				If !Empty(cUltFilCC)
					cOldDescCC := cDescCC
					lOldDescCC := .T.
				EndIf
				cUltFilCC := SRA->RA_FILIAL+SRA->RA_CC
			Else
				lOldDescCC := .F.
			EndIf

			cCcAnt 		:= SRA->RA_CC
			cDescCC		:= Fdesc("CTT", SRA->RA_CC , "CTT_DESC01", , SRA->RA_FILIAL)
			cLocDescCC	:= cDescCC
			oSection3:Init(.T.)
			oSection3:PrintLine()
			oSection3:Finish()
		Endif
	EndIf

	If !(cFiAnt == SRA->RA_FILIAL)
		cFiAnt := SRA->RA_FILIAL
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Periodo Aquisitivo                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DFIMPAQUI := aPerFerias[nPosFer][2]
	DPRPAQUI  := fCalcFimAq(DFIMPAQUI+1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa 1a Secao                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:Init()
	// Garante posicionamento correto do funcionário
	SRA->(dbGoto((cAliasQry)->RARECNO))
	If nOrdem == 1 .or. nOrdem == 4
		lFirst	:= .F.
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Detalhe Para o Funcionario                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cDtBase			:= SRF->RF_DATABAS									//-- Data base de ferias
	If cPaisLoc <> "MEX"
		cPerAquis		:= DtoC(SRF->RF_DATABAS) + Space(2) + DtoC(DFIMPAQUI)
		dLimideal		:= DFIMPAQUI + nDiasIdeal										//-- Data limite Ideal
		dLimMax			:= DPRPAQUI - nDiasMax  										//-- Data Limite Maximo
		cFerVenc		:= nDiasVenc 													//-- Ferias Vencidas
		cFaltasVen		:= nDFaltaV														//-- Faltas Vencidas
		cFerProp		:= nDiasProp													//-- Ferias Proporcionais
		cFaltasProp		:= nDFaltaP														//-- Faltas Proporcionais
		cTotal			:= (nDiasVenc + nDiasProp - If(!lMetFalV, If(!lTempoParc, nDFaltaV, 0), nDiasVenc/2) - If(!lMetFalP, If(!lTempoParc, nDFaltaP, 0), nDiasProp / 2))//-- Total de Ferias
	Else
		cPerAquis		:= DtoC(SRF->RF_DATAFIM)									//-- Data Final
		cFerVenc 		:= SRF->RF_DIASDIR											//-- Quantidade Referencia
		cFaltasVen  	:= SRF->RF_DFERVAT											//-- Vencidas
		cFerProp		:= SRF->RF_DFERAAT											//-- Proporcionais
		cFaltasProp 	:= SRF->RF_DFERANT											//-- Pagos
		cTotal 		:= SRF->RF_DFERVAT + SRF->RF_DFERAAT - SRF->RF_DFERANT	// -- Totais
	EndIf

	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Efetua impressao da Section1 e atualiza impress.Cabecalho     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:SkipLine()

		oSection1:PrintLine()
		oSection1:cell("RA_FILIAL"):Show()
		oSection1:cell("RA_MAT"):Show()
		oSection1:cell("RA_CC"):Show()
		oSection1:cell("RA_NOME"):Show()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Campos de Programacao de ferias                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCnt1 := 1 To nPeriodo

		cPerc13	:=  "13o S |___|"
		If nTipo == 1
			dDtIniProg := If(nCnt1 == 1, dDtIProg1, If(nCnt1 == 2, dDtIProg2, dDtIProg3))
			nDiasAbono := If(nCnt1 == 1, nDiasAbo1, If(nCnt1 == 2, nDiasAbo2, nDiasAbo3))
		Else
			dDtIniProg := dDtIProg1
		Endif

		If nFilDat == 1 .And. ( (nCnt1 == 1 .And. !Empty(dDtIniProg) .And. (dDtIniProg < dProgDe .Or. dDtIniProg > dProgAte)) .Or.;
			(nCnt1 != 1 .And. (dDtIniProg < dProgDe .Or. dDtIniProg > dProgAte)) )
			Loop
		EndIf

		nDiasFePro := If(nCnt1 == 1, If(nDiasFer1=0, nDiaVen,If( lUnicoPer,(nDiaVen- If(!lMetFalV, If(!lTempoParc, nDFaltaV, 0), nDiaVen/2) -nDiasAbo1),nDiasFer1)), If(nCnt1 == 2, nDiasFer2, nDiasFer3))

		//-- Abater Dias de Abono quando  nao houver os campos de programacao com dias ou quando
		//-- existir os campos e estiver zerado.
		If nCnt1 == 1 .And. ! Empty(SRF->RF_DATAINI) .And. ;
			(! lTemCpoProg ) .Or. ( lTemCpoProg .And. SRF->RF_DFEPRO1 = 0  .And. SRF->RF_DABPRO1 = 0 )
			nDiasFePro -= ( (cAliasSRF)->RF_DFERANT + If(!lMetFalV, If(!lTempoParc, nDFaltaV, 0), (cAliasSRF)->RF_DFERANT / 2) + nDiasAbono)
		Endif

		nDiasFePro := Max(nDiasFePro, 0)
		nDiasFePro := Min(nDiasFePro,nDiasDir)

		If nTipo == 1
			cProgrFer :=LTrim(If(nCnt1 == 1,STR0025,if(nCnt1 == 2,STR0026,STR0027)))//"1a -  P R O G R A M A C A O  D E  F E R I A S"#"2a -  P R O G R A M A C A O  D E  F E R I A S"#"3a -  P R O G R A M A C A O  D E  F E R I A S"
		Else
			cProgrFer := LTrim(STR0057)
		Endif

		//-- Periodo de gozo de ferias
		If !Empty(dDtIniProg)
			If nDiasFePro  > 0
				cDtAteDesc	:= DtoC(dDtIniProg+(nDiasFePro-1))
				dDataFim	:= dDtIniProg+(nDiasFePro-1)
			ElseIf nDiaVen > 0
				cDtAteDesc	:= DtoC(dDtIniProg+nDiaVen  -1)
				dDataFim	:= dDtIniProg+(nDiaVen  -1)
			Else
				cDtAteDesc	:= "___/___/___"
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se Deve Considerar dias 24/12, 25/12, 31/12 e 01/01 ³
			//| como licenca remunerada.                                     |
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fChkLicRem( dDtIniProg, dDataFim, @nDMes12, @nDMes01, cDia2501)
			If nDMes12 + nDMes01 > 0
				dDataFim += nDMes12 + nDMes01
				cDtAteDesc	:= DtoC(dDataFim)
			EndIf

			If SRF->RF_PERC13S > 0 .And. nCnt1 == 1
				cPerc13	:= "13o S" +Space(1) + TransForm(SRF->RF_PERC13S,"999.9")  
			ElseIf SRF->RF_PER13S2 > 0 .And. nCnt1 == 2
				cPerc13	:= "13o S" +Space(1) + TransForm(SRF->RF_PER13S2,"999.9")  
			ElseIf SRF->RF_PER13S3 > 0 .And. nCnt1 == 3 
				cPerc13	:= "13o S" +Space(1) + TransForm(SRF->RF_PER13S3,"999.9") 
			Endif

			cProgrFer	+= PadC(DtoC(dDtIniProg),15)
			cProgrFer	+= RTrim(STR0014)
			cProgrFer	+= PadC(cDtAteDesc,15)   //"  A  "
		Else
			cProgrFer   += If(cPaisLoc <> "MEX",STR0015,STR0061)	//"______/______/______  A  ______/______/______"
		EndIf

		If cPaisLoc <> "MEX"

			//Dias de Ferias Proporcionais
			If nTipo == 1
				cDiasFer	:= LTrim(STR0028)	//D.FER.
			Else
				cDiasFer	:= LTrim(STR0059)	//D.REC.
			Endif

			If nDiasFePro > 0
				cDiasFer += Space(1) + TransForm(nDiasFePro,"999.9")			//"D.Ferias
			Else
				cDiasFer += space(1)+ "|___|" 								//"D.Ferias
			Endif

			//Dias de Abono
			If nTipo == 1
				If nDiasAbono > 0
					cDiasAbo	:= STR0029+ space(1)+ TransForm(nDiasAbono,"999.9") + Space(2) + oemtoAnsi(STR0046)+  Space(1)+oemtoAnsi(STR0047)+ Space(2)+Replicate("_", 30) 	//"D.AB.  + Assinatura "

				Elseif nDiasAbono = 0 .And. (cAliasSRF)->RF_TEMABPE == "S" .And. nDiasFePro = 0
					cDiasAbo	:= STR0029+ space(2)+ STR0030 + Space(2)+ oemtoAnsi(STR0046)+  Space(2)+ oemtoAnsi(STR0047)+ Space(2)+Replicate("_", 30)							//"D.AB. + 'Sim'    + Assinatura "

				Else
					cDiasAbo	:= STR0029+ space(1)+ "|___|"  + Space(2) + oemtoAnsi(STR0046)+ Space(1)+ oemtoAnsi(STR0047)+ Space(2)+Replicate("_", 30)						//"D.AB. +|______|  + Assinatura "
				Endif
			Else
				cDiasAbo		:=	oemtoAnsi(STR0046)+ Space(1)+ oemtoAnsi(STR0058)+ Space(1)+ Replicate("_", 40)	//Assinatura do##Estagiario
			Endif

		Else
			cDiasFer := "|___|"
			cDiasAbo := Replicate("_", 25) //"D.Ferias + Assinatura
		EndIf

		oReport:SkipLine()
		oSection2:Init(.F.)
		oSection2:Printline()
		oSection2:Finish()
	Next nCnt1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza impressao inicializada pelo metodo Init             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:Finish()

	cFiAnt	:= SRA->RA_FILIAL
	cCcAnt	:= SRA->RA_CC
	If nFilPer == 1 .And. Ascan(aProc,{|x| x == SRA->RA_FILIAL+SRA->RA_MAT}) == 0
		aadd(aProc,SRA->RA_FILIAL+SRA->RA_MAT)
	EndIf

	RestArea(aAreaSRF)

	IF lSalta
		cChaveAnt := SRA->RA_FILIAL+SRA->RA_MAT+SRA->RA_CC
	Else
		cChaveAnt := SRA->RA_FILIAL+SRA->RA_MAT
	EndIf

	(cAliasQry)->(dbSkip())
Enddo

(cAliasQry)->(dbCloseArea())

If Len(aLogFil) > 0

	If lRCHComp
		aAdd(aLog,STR0073) //"Não há roteiro de férias cadastrado para os seguintes períodos: "
		aAdd(aLog,"")
	Else
		aAdd(aLog,STR0074) //"Não há roteiro de férias cadastrado para as seguintes filiais e períodos: "
		aAdd(aLog,"")
		aAdd(aLog,STR0075 + Space(Max(FWGETTAMFILIAL - 5,1)) + STR0076) //"Filial" + "Período"
	EndIf

	For nX := 1 To Len(aLogFil)
		aAdd(aLog,aLogFil[nX])
	Next nX

EndIf

If Len(aLogDtInv) > 0
	aAdd(aLog,cQuebra)
	aAdd(aLog, STR0080) //"Matriulas que não possuem período programado de féias na data informada no parâmetro 10 - Programadas At?"
	aAdd(aLog,"")
	aAdd(aLog,STR0081) //"Filial" + "Período"
	For nX := 1 To Len(aLogDtInv)
		aAdd(aLog,aLogDtInv[nX])
	Next nX
EndIf

If Len(aLogFil) > 0 .Or. Len(aLogDtInv) > 0

	MsAguarde( { || fMakeLog( {aLog},{} , FunName() , NIL , FunName() , STR0077,,,,.F. ) } ,  STR0077 ) //"Log de períodos não cadastrados"

EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Scheddef    ³ Autor ³ Silvio C. Stecca   ³ Data ³07/08/2019³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Trazer o grupo de perguntas GPER400 quando houver schedule ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function SchedDef()

	Local aParam	:= {}
	Local cPerg		:= fGetPerg()
	Local aOrd    	:= If(cPaisLoc <> "MEX", {	OemToAnsi(STR0001), OemToAnsi(STR0002), OemToAnsi(STR0016), OemToAnsi(STR0017), ;
												OemToAnsi(STR0018), OemToAnsi(STR0019)}, {OemToAnsi(STR0001), OemToAnsi(STR0002), ;
												OemToAnsi(STR0016), OemToAnsi(STR0017), OemToAnsi(STR0018)}) //"Centro de Custo"###"Matricula"###"Nome"###"C.Custo + Nome"###"Filial + Dt.Base"###"Filial + Dt.Inicio"

	aParam := {	"R"			, ; // Tipo R para relatorio P para processo
				cPerg		, ;	// Pergunte do relatorio, caso nao use passar ParamDef
				""			, ; // Alias
   				aOrd		, ; // Array de ordens
				""			}

Return aParam

/*/{Protheus.doc} fGetPerg
Retorna o grupo de perguntas que deve ser utilizado no relatorio
@author martins.marcio
@since 23/08/2021
@version 1.0
/*/
Static Function fGetPerg()

	Local cPergRet := "GP400RA"
	Local oSX1

	If GetApoInfo("MSLIB.PRW")[4] >= CTOD("04/09/2018")
		oSX1 := FWSX1Util():New()
		oSX1:AddGroup("GP400RB")
		oSX1:SearchGroup()

		If !Empty(oSX1:GetGroup("GP400RB")[2])
			cPergRet := "GP400RB"
		EndIf
		FreeObj(oSX1)
	EndIf

Return cPergRet
