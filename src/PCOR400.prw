/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PCOR400.ch"
#INCLUDE "PROTHEUS.CH"

#define ANTES_LACO   	1
#define COND_LACO 		2
#define PROC_LACO 		3
#define DEPOIS_LACO 	4
#define PROC_FILTRO 	5
#define PROC_CARGO		6
#define BLOCK_FILTRO 	7

#define LIM_PERG 11
#define QUEB_INDEX 01
#define QUEB_LACO 02
#define QUEB_SEEK 03
#define QUEB_COND 04
#define QUEB_TITSUB 05
#define QUEB_FILTRO 06
#define COL_TIT 01
#define COL_IMPR 02
#define COL_TAM 03
#define COL_ORDEM 04
#define COL_ALIGN 05
#define COL_TRUNCA 06

// Release 4
#define TAM_CO			35		// Tamanho da celula conta orcamentaria
#define TAM_CLASSE		30		// Tamanho da celula classe
#define TAM_OPER		30		// Tamanho da celula operacao
#define TAM_HIST		40		// Tamanho da celula historico
#define TAM_PROCES		10		// Tamanho da celula Processo
#define TAM_DATA		12		// Tamanho da celula Data


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ PCOR400  ³ AUTOR ³ Paulo Carnelossi      ³ DATA ³ 09/03/2005 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Programa de impressao dos movimentos (tabela AKD)            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ USO      ³ SIGAPCO                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³_DOCUMEN_ ³ PCOR400                                                      ³±±
±±³_DESCRI_  ³ Programa de impressao dos movimentos mod SIGAPCO.            ³±±
±±³_FUNC_    ³ Esta funcao devera ser utilizada com a sua chamada normal a  ³±±
±±³          ³ partir do Menu do sistema.                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PCOR400()

Local aArea	:= GetArea()
Local cPerg := "PCR400"

Local nX	:= 1		// Contador generico

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef( cPerg )

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf	             

oReport:PrintDialog()

RestArea(aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Gustavo Henrique   º Data ³  03/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Grupo de perguntas do relatorio                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Planejamento e Controle Orcamentario                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef( cPerg )

Local oReport
Local oMovOrdem1
Local oMovOrdem2
Local oMovOrdem3
Local oMovOrdem4
Local oMovOrdem5
Local nX, aTotFunc := {}

Local cReport 		:= "PCOR400" // Nome do relatorio
Local cAliasQry		:= GetNextAlias()

Local aOrdem		:= { STR0018, STR0019, STR0020, STR0021, STR0022 }	// "C.O.+Data" ### "C.O.+Classe+Operação" ### "Classe+Operação" ### "Operação" ### "Data+C.O.+Classe+Operação"

// Define blocos de codigo para impressao do codigo e descricao dos campos de quebra
Local bCO  			:= { || (cAliasQry)->( AllTrim( PcoRetCo(AKD_CO) + "-" + AK5_DESCRI) ) }
Local bClasse		:= { || (cAliasQry)->( AllTrim( AKD_CLASSE ) + "-" + AK6_DESCRI ) }
Local bOper  		:= { || (cAliasQry)->( AllTrim( AKD_OPER   ) + "-" + AKF_DESCRI ) }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// "Relacao de Movimentos" ### "Este relatorio ira imprimir a Relação de Movimentos de acordo com os parâmetros solicitados pelo usuário. Para mais informações sobre este relatorio consulte o Help do Programa ( F1 )."
oReport := TReport():New( cReport, STR0001, cPerg, { |oReport| PCOR400Prt( oReport, cAliasQry, aOrdem, aTotFunc ) }, STR0017 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio - C.O. + Data                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMovOrdem1 := TRSection():New( oReport, STR0025+":"+STR0018, { cAliasQry, "AKD","AK1","AK5","AK6","AKF","AL2","CTT","CTD","CTH"} , aOrdem )

TRCell():New( oMovOrdem1, "AKD_CO"    , "AKD", STR0008, /*Picture*/, TAM_CO		, /*lPixel*/, bCO		) 	// Conta Orcamentaria
TRCell():New( oMovOrdem1, "AKD_DATA"  , "AKD", STR0011, /*Picture*/, TAM_DATA	, /*lPixel*/, 			)	// Dt.Movim.
TRCell():New( oMovOrdem1, "AKD_CLASSE", "AKD", STR0012, /*Picture*/, TAM_CLASSE	, /*lPixel*/, bClasse	) 	// Classe
TRCell():New( oMovOrdem1, "AKD_OPER"  , "AKD", STR0013, /*Picture*/, TAM_OPER		, /*lPixel*/, bOper		) 	// Operacao
TRCell():New( oMovOrdem1, "AKD_HIST"  , "AKD", STR0014, /*Picture*/, TAM_HIST		, /*lPixel*/, 			)	// Historico
TRCell():New( oMovOrdem1, "AKD_PROCES", "AKD", STR0015, /*Picture*/, TAM_PROCES		, /*lPixel*/,			)	// Processo
TRCell():New( oMovOrdem1, "AKD_VALOR1", "AKD", STR0016, "@E 999,999,999.99"/*Picture*/, /*Tamanho*/, /*lPixel*/, {||AKD_VALOR1*IIf(AKD_TIPO=="1",1,-1)}/*CodeBlock*/ )	// Valor
oMovOrdem1:Cell("AKD_CO"):SetLineBreak()
oMovOrdem1:Cell("AKD_CLASSE"):SetLineBreak()
oMovOrdem1:Cell("AKD_OPER"):SetLineBreak()
oMovOrdem1:Cell("AKD_HIST"):SetLineBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 2a. secao do relatorio - C.O. + Classe + Operacao     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMovOrdem2 := TRSection():New( oReport, STR0025+":"+STR0019, { cAliasQry, "AKD","AK1","AK5","AK6","AKF","AL2","CTT","CTD","CTH" } )

TRCell():New( oMovOrdem2, "AKD_CO"    , "AKD", STR0008, /*Picture*/, TAM_CO		, /*lPixel*/, bCO    	)	// Conta Orcamentaria
TRCell():New( oMovOrdem2, "AKD_CLASSE", "AKD", STR0012, /*Picture*/, TAM_CLASSE	, /*lPixel*/, bClasse	)	// Classe
TRCell():New( oMovOrdem2, "AKD_OPER"  , "AKD", STR0013, /*Picture*/, TAM_OPER		, /*lPixel*/, bOper 	)	// Operacao
TRCell():New( oMovOrdem2, "AKD_DATA"  , "AKD", STR0011, /*Picture*/, TAM_DATA		, /*lPixel*/, 			)	// Dt.Movim.
TRCell():New( oMovOrdem2, "AKD_HIST"  , "AKD", STR0014, /*Picture*/, TAM_HIST		, /*lPixel*/, 			)	// Historico
TRCell():New( oMovOrdem2, "AKD_PROCES", "AKD", STR0015, /*Picture*/, TAM_PROCES		, /*lPixel*/, 			)	// Processo
TRCell():New( oMovOrdem2, "AKD_VALOR1", "AKD", STR0016, "@E 999,999,999.99"/*Picture*/, /*Tamanho*/, /*lPixel*/, {|| AKD_VALOR1 * IIf( AKD_TIPO=="1",1,-1 ) }/*CodeBlock*/ )	// Valor
oMovOrdem2:Cell("AKD_CO"):SetLineBreak()
oMovOrdem2:Cell("AKD_CLASSE"):SetLineBreak()
oMovOrdem2:Cell("AKD_OPER"):SetLineBreak()
oMovOrdem2:Cell("AKD_HIST"):SetLineBreak()
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 3a. secao do relatorio - Classe + Operacao            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMovOrdem3 := TRSection():New( oReport, STR0025+":"+STR0020, { cAliasQry, "AKD","AK1","AK5","AK6","AKF","AL2","CTT","CTD","CTH" } )

TRCell():New( oMovOrdem3, "AKD_CLASSE", "AKD", STR0012, /*Picture*/, TAM_CLASSE, /*lPixel*/, bClasse	)	// Classe
TRCell():New( oMovOrdem3, "AKD_OPER"  , "AKD", STR0013, /*Picture*/, TAM_OPER	, /*lPixel*/, bOper  	)	// Operacao
TRCell():New( oMovOrdem3, "AKD_CO"    , "AKD", STR0008, /*Picture*/, TAM_CO	, /*lPixel*/, bCO    	)	// Conta Orcamentaria
TRCell():New( oMovOrdem3, "AKD_DATA"  , "AKD", STR0011, /*Picture*/, TAM_DATA	, /*lPixel*/,			)	// Dt.Movim.
TRCell():New( oMovOrdem3, "AKD_HIST"  , "AKD", STR0014, /*Picture*/, TAM_HIST	, /*lPixel*/, 			)	// Historico
TRCell():New( oMovOrdem3, "AKD_PROCES", "AKD", STR0015, /*Picture*/, TAM_PROCES	, /*lPixel*/, 			)	// Processo
TRCell():New( oMovOrdem3, "AKD_VALOR1", "AKD", STR0016, "@E 999,999,999.99"/*Picture*/, /*Tamanho*/, /*lPixel*/, {|| AKD_VALOR1 * IIf( AKD_TIPO=="1",1,-1 ) }/*CodeBlock*/ )	// Valor
oMovOrdem3:Cell("AKD_CO"):SetLineBreak()
oMovOrdem3:Cell("AKD_CLASSE"):SetLineBreak()
oMovOrdem3:Cell("AKD_OPER"):SetLineBreak()
oMovOrdem3:Cell("AKD_HIST"):SetLineBreak()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 4a. secao do relatorio - Operacao                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMovOrdem4 := TRSection():New( oReport, STR0025+":"+STR0021, { cAliasQry, "AKD","AK1","AK5","AK6","AKF","AL2","CTT","CTD","CTH" } )

TRCell():New( oMovOrdem4, "AKD_OPER"  , "AKD", STR0013, /*Picture*/, TAM_OPER	, /*lPixel*/, bOper		)	// Operacao
TRCell():New( oMovOrdem4, "AKD_CLASSE", "AKD", STR0012, /*Picture*/, TAM_CLASSE, /*lPixel*/, bClasse	)	// Classe
TRCell():New( oMovOrdem4, "AKD_CO"    , "AKD", STR0008, /*Picture*/, TAM_CO	, /*lPixel*/, bCO		)	// Conta Orcamentaria
TRCell():New( oMovOrdem4, "AKD_DATA"  , "AKD", STR0011, /*Picture*/, TAM_DATA	, /*lPixel*/, 			)	// Dt.Movim.
TRCell():New( oMovOrdem4, "AKD_HIST"  , "AKD", STR0014, /*Picture*/, TAM_HIST	, /*lPixel*/, 			)	// Historico
TRCell():New( oMovOrdem4, "AKD_PROCES", "AKD", STR0015, /*Picture*/, TAM_PROCES	, /*lPixel*/, 			)	// Processo
TRCell():New( oMovOrdem4, "AKD_VALOR1", "AKD", STR0016, "@E 999,999,999.99"/*Picture*/, /*Tamanho*/, /*lPixel*/, {|| AKD_VALOR1 * IIf( AKD_TIPO=="1",1,-1 ) }/*CodeBlock*/ )	// Valor
oMovOrdem4:Cell("AKD_CO"):SetLineBreak()
oMovOrdem4:Cell("AKD_CLASSE"):SetLineBreak()
oMovOrdem4:Cell("AKD_OPER"):SetLineBreak()
oMovOrdem4:Cell("AKD_HIST"):SetLineBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 5a. secao do relatorio - Data + CO + Classe + Operacao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oMovOrdem5 := TRSection():New( oReport, STR0025+":"+STR0022, { cAliasQry, "AKD","AK1","AK5","AK6","AKF","AL2","CTT","CTD","CTH" } )

TRCell():New( oMovOrdem5, "AKD_DATA"  , "AKD", STR0011, /*Picture*/, TAM_DATA	, /*lPixel*/,         	)	// Dt.Movim.
TRCell():New( oMovOrdem5, "AKD_CO"    , "AKD", STR0008, /*Picture*/, TAM_CO	, /*lPixel*/, bCO		)	// Conta Orcamentaria
TRCell():New( oMovOrdem5, "AKD_CLASSE", "AKD", STR0012, /*Picture*/, TAM_CLASSE, /*lPixel*/, bClasse	)	// Classe
TRCell():New( oMovOrdem5, "AKD_OPER"  , "AKD", STR0013, /*Picture*/, TAM_OPER	, /*lPixel*/, bOper		)	// Operacao
TRCell():New( oMovOrdem5, "AKD_HIST"  , "AKD", STR0014, /*Picture*/, TAM_HIST	, /*lPixel*/, 			)	// Historico
TRCell():New( oMovOrdem5, "AKD_PROCES", "AKD", STR0015, /*Picture*/, TAM_PROCES	, /*lPixel*/, /*CodeBlock*/ )	// Processo
TRCell():New( oMovOrdem5, "AKD_VALOR1", "AKD", STR0016, "@E 999,999,999.99"/*Picture*/, /*Tamanho*/, /*lPixel*/, {|| AKD_VALOR1 * IIf( AKD_TIPO=="1",1,-1 ) }/*CodeBlock*/ )	// Valor
oMovOrdem5:Cell("AKD_CO"):SetLineBreak()
oMovOrdem5:Cell("AKD_CLASSE"):SetLineBreak()
oMovOrdem5:Cell("AKD_OPER"):SetLineBreak()
oMovOrdem5:Cell("AKD_HIST"):SetLineBreak()

oReport:SetTotalInLine( .F. )		// Configura total geral para impressao em colunas

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PCOR400Prt ºAutor ³ Gustavo Henrique  º Data ³  03/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Executa query de consulta na tabela de movimentos (AKD) e  º±±
±±º          ³ imprime o objeto oReport definido na funcao ReportDef.     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto tReport com a definicao das secoes e celulasº±±
±±º          ³ para impressao do relatorio.                               º±±
±±º          ³ EXPC2 - Alias da query do relatorio                        º±±
±±º          ³ EXPA3 - Array com as ordens do relatorio                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Planejamento e Controle Orcamentario                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PCOR400Prt( oReport, cAliasQry, aOrdem, aTotFunc )
                           
Local oSection1 

Local nOrdem	:= oReport:Section(1):GetOrder() 
Local nX		:= 1					// Contador generico
Local nCont		:= 1					// Contador generico

Local aQuebras	:= {}					// Array com as condicoes de quebra do relatorio

Local cSqlExp	:= ""					// Expressao SQL de filtros do relatorio
Local cCO		:= ""					// Codigo da Conta orcamentaria
Local cClasse	:= ""					// Codigo da Classe
Local cOper		:= ""					// Codigo da Operacao
Local dData		:= CToD( "  /  /  " )	// Data do lancamento  
Local cQuery := ""
Local cQuery1:= ""
Local cDesc  := "" 
Local nQt    := 5    
Local aControle := {}
Local oBreak1 
Local oBreak2
Local oBreak3
Local oBreak4

Static nQtdEntid := Iif(cPaisLoc$"RUS",PCOQtdEntd(),CtbQtdEntd())                                    


MakeSqlExp( oReport:uParam )   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta descricao e query para atender 				³
//³a abertura de (n) entidades                      	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If nQtdEntid == Nil
	If cPaisLoc == "RUS"
		nQtdEntid := PCOQtdEntd() 
	Else
		nQtdEntid := CtbQtdEntd() 
	EndIf	
Else
	aArea := GetArea()
	If nQtdEntid > 4
		While nQt <= nQtdEntid
			DbSelectArea('CT0')
			DbSetOrder(1)
			DbSeek(xFilial()+STRZERO(nQt,2))
			If AScan(aControle,CT0_ALIAS) == 0
				AADD(aControle, CT0_ALIAS)
				If &("AKD->AKD_ENT"+STRZERO(nQt,2)) == ""
					cDesc += ", "+CT0_CPODSC 
					cQuery1 += " LEFT OUTER JOIN "  
					cQuery1 += RetSqlName(CT0_ALIAS)+" "+CT0_ALIAS
					DbSelectArea('SX3')
					DbSetOrder(1)
					DbSeek(CT0->CT0_ALIAS+"01")          
					cQuery1 += " ON "+CT0->CT0_ALIAS+"." + X3_CAMPO +" = '"+xFilial(CT0->CT0_ALIAS)+"' "   
					cQuery1 += " AND "+CT0->CT0_ALIAS+"." + CT0->CT0_CPOCHV +" = AKD.AKD_ENT"+STRZERO(nQt,2)
					cQuery1 += " AND "+CT0->CT0_ALIAS+".D_E_L_E_T_ = ' ' "
				EndIf
			Endif
			nQt += 1
		CT0->(DbSkip())
		Enddo
	Endif       
	RestArea(aArea)          
Endif        

cDesc += ", AMF_DESCRI"

cQuery1 += " LEFT OUTER JOIN "
cQuery1 += RetSqlName("AMF")+" AMF ON "
cQuery1 += " AMF_FILIAL = '"+xFilial("AMF")+"' "
cQuery1 += " AND AMF_CODIGO = AKD.AKD_UNIORC "
cQuery1 += " AND AMF.D_E_L_E_T_ = ' ' "

cDesc	:= '%' + cDesc + '%'
cQuery1	:= '%' + cQuery1 + '%'
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta expressao de filtro da query com os parametros informados                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSqlExp += " AND AKD_DATA	BETWEEN '" + DtoS(mv_par01) + "' AND '" + DtoS(mv_par02) + "'"
cSqlExp += " AND AKD_CO		BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"
cSqlExp += " AND AKD_CLASSE	BETWEEN '" + mv_par05 + "' AND '" + mv_par06 + "'"
cSqlExp += " AND AKD_OPER	BETWEEN '" + mv_par07 + "' AND '" + mv_par08 + "'"

If !Empty(mv_par09)
	cSqlExp += " AND AKD_TPSALD = '" + mv_par09 + "'"
Else
	Aviso(STR0023,STR0026, {"Ok"})  //"Atencao"##"Tipo de Saldo nao Informado. Verifique."
	oReport:CancelPrint()
	Return
EndIf

cSqlExp += " AND AKD_PROCES	BETWEEN '" + mv_par10 + "' AND '" + mv_par11 + "'"
//nao considera os lancamentos estornados
cSqlExp += " AND AKD_STATUS != '3'"

cSqlExp := "%" + cSqlExp + "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria objetos de quebra e totalizacao de acordo com a ordem escolhida no relatorio      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1			// C.O. + Data
                
	oSection1 := oReport:Section(nOrdem)

	AAdd( aQuebras, { { || cCO   <> (cAliasQry)->AKD_CO   }, "AKD_CO"  , { || cCO   := (cAliasQry)->AKD_CO   }, .F. } )	
	AAdd( aQuebras, { { || dData <> (cAliasQry)->AKD_DATA }, "AKD_DATA", { || dData := (cAliasQry)->AKD_DATA }, .F. } )
	
	cOrder := "%" + " AKD_CO , AKD_DATA" + "%"
	
	oBreak1 := TRBreak():New( oSection1, { || (cAliasQry)->( AKD_CO + DtoS(AKD_DATA) )	}, STR0004 )	// "* Total da Data *"
	oBreak2 := TRBreak():New( oSection1, { || (cAliasQry)->( AKD_CO )					}, STR0003 )	// "* Total da Conta Orcamentaria *"
	           
	TRFunction():New( oSection1:Cell("AKD_VALOR1"), , "SUM", oBreak1, , , , .F. )
	TRFunction():New( oSection1:Cell("AKD_VALOR1"), , "SUM", oBreak2, , , , .F. )
	                                                    
ElseIf nOrdem == 2		// C.O. + Classe + Oper

	oSection1 := oReport:Section(nOrdem)

	AAdd( aQuebras, { { || cCO     <> (cAliasQry)->AKD_CO     }, "AKD_CO"    , { || cCO     := (cAliasQry)->AKD_CO     }, .F. } )	
	AAdd( aQuebras, { { || cClasse <> (cAliasQry)->AKD_CLASSE }, "AKD_CLASSE", { || cClasse := (cAliasQry)->AKD_CLASSE }, .F. } )
	AAdd( aQuebras, { { || cOper   <> (cAliasQry)->AKD_OPER   }, "AKD_OPER"  , { || cOper   := (cAliasQry)->AKD_OPER   }, .F. } )
	
	cOrder := "%" + " AKD_CO , AKD_CLASSE , AKD_OPER" + "%"
	
	oBreak1 := TRBreak():New( oSection1, { || (cAliasQry)->( AKD_CO + AKD_CLASSE + AKD_OPER )	}, STR0006 )	// "* Total Operação *"
	oBreak2 := TRBreak():New( oSection1, { || (cAliasQry)->( AKD_CO + AKD_CLASSE ) 				}, STR0005 )	// "* Total da Classe *"
	oBreak3 := TRBreak():New( oSection1, { || (cAliasQry)->( AKD_CO )							}, STR0003 )	// "* Total da Conta Orcamentaria *"
	
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak1,,,, .F. )
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak2,,,, .F. )
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak3,,,, .F. )

ElseIf nOrdem == 3		// Classe + Oper

	oSection1 := oReport:Section(nOrdem)

	AAdd( aQuebras, { { || cClasse <> (cAliasQry)->AKD_CLASSE }, "AKD_CLASSE", { || cClasse := (cAliasQry)->AKD_CLASSE }, .F. } )
	AAdd( aQuebras, { { || cOper   <> (cAliasQry)->AKD_OPER   }, "AKD_OPER"  , { || cOper   := (cAliasQry)->AKD_OPER   }, .F. } )
	
	cOrder := "%" + " AKD_CLASSE , AKD_OPER" + "%"
	
	oBreak1 := TRBreak():New( oSection1, { || (cAliasQry)->( AKD_CLASSE + AKD_OPER )	}, STR0006 )	// "* Total Operação *"
	oBreak2 := TRBreak():New( oSection1, { || (cAliasQry)->( AKD_CLASSE )			}, STR0005 )	// "* Total da Classe *"
		           
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak1,,,, .F. )
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak2,,,, .F. )

ElseIf nOrdem == 4		// Operacao

	oSection1 := oReport:Section(nOrdem)

	AAdd( aQuebras, { { || cOper <> (cAliasQry)->AKD_OPER }, "AKD_OPER", { || cOper := (cAliasQry)->AKD_OPER }, .F. } )
	
	cOrder := "%" + " AKD_OPER" + "%"

	oBreak1 := TRBreak():New( oSection1, { || (cAliasQry)->AKD_OPER }, STR0006 )	// "* Total Operação *"
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak1,,,, .F. ) 

ElseIf nOrdem == 5		// Data + CO + Classe + Operacao

	oSection1 := oReport:Section(nOrdem)

	AAdd( aQuebras, { { || dData   <> (cAliasQry)->AKD_DATA   }, "AKD_DATA"  , { || dData   := (cAliasQry)->AKD_DATA   }, .F. } )
	AAdd( aQuebras, { { || cCO     <> (cAliasQry)->AKD_CO     }, "AKD_CO"    , { || cCO     := (cAliasQry)->AKD_CO     }, .F. } )	
	AAdd( aQuebras, { { || cClasse <> (cAliasQry)->AKD_CLASSE }, "AKD_CLASSE", { || cClasse := (cAliasQry)->AKD_CLASSE }, .F. } )
	AAdd( aQuebras, { { || cOper   <> (cAliasQry)->AKD_OPER   }, "AKD_OPER"  , { || cOper   := (cAliasQry)->AKD_OPER   }, .F. } )
	
	cOrder := "%" + " AKD_DATA , AKD_CO , AKD_CLASSE , AKD_OPER" + "%"
	
	oBreak1 := TRBreak():New( oSection1, { || (cAliasQry)->( DtoS(AKD_DATA) + AKD_CO + AKD_CLASSE + AKD_OPER )	}, STR0006 )	// "* Total Operação *"
	oBreak2 := TRBreak():New( oSection1, { || (cAliasQry)->( DtoS(AKD_DATA) + AKD_CO + AKD_CLASSE )         		}, STR0005 )	// "* Total da Classe *"
	oBreak3 := TRBreak():New( oSection1, { || (cAliasQry)->( DtoS(AKD_DATA) + AKD_CO )                      		}, STR0003 )	// "* Total da Conta Orcamentaria *"
	oBreak4 := TRBreak():New( oSection1, { || (cAliasQry)->( DtoS(AKD_DATA) )                               		}, STR0004 )	// "* Total da Data *"
		           
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak1,,,, .F. )
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak2,,,, .F. )
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak3,,,, .F. )
	TRFunction():New( oSection1:Cell("AKD_VALOR1"),, "SUM", oBreak4,,,, .F. )
	
EndIf

oReport:SetTitle( oReport:Title() + IIf(cPaisLoc$"RUS",STR0028," - Por ordem de " ) + aOrdem[nOrdem] )//" - Por ordem de "

nLenQuebra := Len( aQuebras )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Query do relatorio para a secao 1                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()

BeginSql Alias cAliasQry

	SELECT
		AKD_CO, AKD_DATA, AKD_CLASSE, AKD_OPER, AKD_HIST, AKD_PROCES,;
		AKD_TIPO, AKD_VALOR1, AK5_DESCRI, AK6_DESCRI, AKF_DESCRI %exp:cDesc%
	FROM 
		%table:AKD% AKD 

			LEFT OUTER JOIN %table:AK1% AK1
			ON 	AK1.AK1_FILIAL = %xfilial:AK1%
				AND AK1_CODIGO = AKD_CODPLA
				AND AK1.%notDel%

			LEFT OUTER JOIN %table:AK5% AK5
			ON 	AK5.AK5_FILIAL = %xfilial:AK5%
				AND AK5_CODIGO = AKD_CO
				AND AK5.%notDel%

			LEFT OUTER JOIN %table:AK6% AK6
			ON	AK6.AK6_FILIAL = %xfilial:AK6%
				AND AK6_CODIGO = AKD_CLASSE
				AND AK6.%notDel%

			LEFT OUTER JOIN %table:AKF% AKF
			ON  AKF.AKF_FILIAL = %xfilial:AKF%
				AND AKF_CODIGO = AKD_OPER
				AND AKF.%notDel%

			LEFT OUTER JOIN %table:AL2% AL2
			ON 	AL2.AL2_FILIAL = %xfilial:AL2%
				AND AL2_TPSALD = AKD_TPSALD
				AND AL2.%notDel%

			LEFT OUTER JOIN %table:CTT% CTT
			ON  CTT.CTT_FILIAL = %xfilial:CTT%
				AND CTT_CUSTO  = AKD_CC
				AND CTT.%notDel%

			LEFT OUTER JOIN %table:CTD% CTD
			ON  CTD.CTD_FILIAL = %xfilial:CTD%
				AND CTD_ITEM  = AKD_ITCTB
				AND CTD.%notDel%

			LEFT OUTER JOIN %table:CTH% CTH
			ON  CTH.CTH_FILIAL = %xfilial:CTH%
				AND CTH_CLASSE  = AKD_CLVLR
				AND CTH.%notDel%             
				
			%exp:cQuery1%	       
			
	WHERE
		AKD.AKD_FILIAL = %xfilial:AKD%
		AND AKD.%notDel%
		%exp:cSqlExp%
	ORDER BY %exp:cOrder%

EndSql	
                      
oSection1:EndQuery()
TcSetField( cAliasQry, "AKD_DATA", "D", 8, 0 )
TcSetField( cAliasQry, "AKD_VALOR1", "N", 18, 2 )


oSection1:SetHeaderPage()			// Configura cabecalho para impressao no inicio de cada pagina

oReport:SetMeter( AKD->( RecCount() ) )
         
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia impressao do relatorio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
(cAliasQry)->( dbGoTop() )

If (cAliasQry)->( Eof() )

	Aviso( STR0023, STR0024, {"Ok"} )	// "Atenção" ### "Não existem dados para os parâmetros especificados."

	oReport:CancelPrint()

Else	

	oSection1:Init()
	
	Do While (cAliasQry)->( ! EoF() ) .And. !oReport:Cancel()
	                    
		If oReport:Cancel()
			Exit
		EndIf		                    
	                                    
		oReport:IncMeter()
	
	    For nX := 1 To nLenQuebra
			If Eval( aQuebras[ nX, 1 ] ) .Or. ( nX > 1 .And. aQuebras[ nX-1, 4 ] )
				oSection1:Cell( aQuebras[ nX, 2 ] ):Show()
				Eval( aQuebras[ nX, 3 ] )
				aQuebras[ nX, 4 ] := .T.
			EndIf
		Next nX
	                                     
	 	oSection1:PrintLine()
	                         
		For nX := 1 To nLenQuebra
			If aQuebras[ nX, 4 ]
				oSection1:Cell( aQuebras[ nX, 2 ] ):Hide()
				aQuebras[ nX, 4 ] := .F.     
			EndIf
		Next nX
	     
		(cAliasQry)->( dbSkip() )
		
	EndDo           
	
	oSection1:Finish()

EndIf
	
Return
