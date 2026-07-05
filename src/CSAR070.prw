/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.CH"
#INCLUDE "CSAR070.CH"        
#INCLUDE "Report.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CSAR070  ³ Autor ³ Emerson Grassi Rocha  ³ Data ³ 19/06/2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Tabela Salarial (Grafico)                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CSAR070(void)                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia Car.³30/07/2014³TPZVV4³Incluido o fonte da 11 para a 12 e efetua-³±±
±±³            ³          ³      ³da a limpeza.                             ³±±
±±³Allyson M   ³24/06/2016³TVLFGZ³Ajuste p/ executar xFilial() no filtro de ³±±
±±³            ³          ³      ³filial da RBR e executar FwJoinFilial()   ³±±
±±³            ³          ³      ³nos joins                                 ³±±
±±³Willian U.  ³23/06/2017³DRHPONTP-1031³Gera o relatório em Excel modo     ³±±
±±³            ³          ³             ³tabela, com a repetição de todas as³±±
±±³            ³          ³             ³classes, sem alterar o leiaute do  ³±±
±±³            ³          ³             ³relatório padrão.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CSAR070()
Local oReport
Local aArea := GetArea()

Private cAliasQry	:= "RBR"

pergunte("CSR071",.F.)
oReport := ReportDef()
oReport:PrintDialog()	
RestArea( aArea )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef() ³ Autor ³ Emerson Grassi Rocha³ Data ³ 19/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Definicao do Componente de Impressao do Relatorio           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oSection2
Local oSection3
Local aOrdem    := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:=TReport():New("CSAR070",STR0001,"CSR071",{|oReport| PrintReport(oReport)},OemToAnsi(STR0014))	
//"Impressao de Tabela Salarial."###"Este relatorio lista a Tabela Salarial conforme Nivel e Classe selecionados pelo usuario."
oReport:SetTotalInLine(.F.) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Primeira Secao:³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
oSection1 := TRSection():New(oReport,OemToAnsi(STR0007),{"RBR"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	//"Tabela Salarial"
oSection1:SetTotalInLine(.F.)
TRCell():New(oSection1,"RBR_FILIAL","RBR")	//"Filial da Tabela Salarial"
TRCell():New(oSection1,"RBR_TABELA","RBR",STR0011)	//"Codigo da Tabela Salarial"
TRCell():New(oSection1,"RBR_DESCTA","RBR","")		//Descricao da Tabela
TRCell():New(oSection1,"RBR_DTREF","RBR",,,13)	//Data de Referencia da Tabela Salarial
TRCell():New(oSection1,"RBR_VLREF","RBR",,"@E 999,999,999.99",18,.T.,,"LEFT")	//Valor de Referencia da Tabela Salarial
TRCell():New(oSection1,"RBR_APLIC","RBR",STR0017,,12,,{|| If ( (cAliasQry)->RBR_APLIC == "1",STR0018,STR0019 ) }) //"Situacao da Tabela"#"Aplicada"#"Não Aplicada" 

oSection1:SetLineStyle()  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Segunda Secao: ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,OemToansi(STR0015),{"RB6","RBR","RBF","SQ3"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	//Classes e Cargos
oSection2:SetTotalInLine(.F.) 
TRCell():New(oSection2,"RB6_CLASSE","RB6")			//Classe Salarial
TRCell():New(oSection2,"RBF_DESC","RBF","")		//Descricao da Classe
TRCell():New(oSection2,"Q3_CARGO","SQ3",STR0010) 	//Cargo
TRCell():New(oSection2,"Q3_DESCSUM","SQ3","")		//Descricao do Cargo   
oSection2:SetLeftMargin(3)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Terceira Secao:³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3 := TrSection():New(oSection1,OemToAnsi(STR0016),{"RB6","RBR"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	//"Niveis, Faixas e Pontos"
TRCell():New(oSection3,"RB6_NIVEL","RB6",STR0012)	//"Nivel"
TRCell():New(oSection3,"RB6_FAIXA","RB6",STR0013)	//"Faixa"
TRCell():New(oSection3,"RB6_COEFIC","RB6")			//"Coeficiente da Faixa"
TRCell():New(oSection3,"RB6_VALOR","RB6")			//Valor
TRCell():New(oSection3,"RB6_PTOMIN","RB6",STR0009)	//"Pontos"
TRCell():New(oSection3,"RB6_PTOMAX","RB6","")		//
oSection3:SetLeftMargin(5)

Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrintReport ³ Autor ³ Emerson Grassi Rocha³ Data ³ 19/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Relatorio (Tabela Salarial)		              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)

Local cAcessaRBR:= &("{ || " + ChkRH(FunName(),"RBR","2") + "}")
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)  
Local oSection3 := oReport:Section(1):Section(2)

Local cTab		:= ""
Local cFilRbf	:= ""
Local cFilRb6	:= ""
Local cFilSq3	:= "" 
Local cAliasSq3	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas na pergunte                                 ³
//³ mv_par01				// Filial De                             ³
//³ mv_par02				// Filial Ate                            ³
//³ mv_par03				// Tabela Salarial De                    ³
//³ mv_par04				// Tabela Salarial Ate                   ³
//³ mv_par05				// Data de Referencia De                 ³
//³ mv_par06				// Data de Referencia Ate                ³
//³ mv_par07				// Nivel da Tabela De                    ³
//³ mv_par08				// Nivel da Tabela Ate                   ³
//³ mv_par09				// Classe Salarial De 					 ³
//³ mv_par10				// Classe Salarial Ate 					 ³
//³ mv_par11				// Listar Cargos    	 				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cFiltro	:= ""
Local lQuery    := .F. 
Local cWhere	:= ""
Local cOrder	:= ""                                                                                  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Suprimir os Cargos		      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par11 == 2
	oSection2:Cell("Q3_CARGO"):Disable()
	oSection2:Cell("Q3_DESCSUM"):Disable()
EndIf                   
        
//-- Filtragem do relatório
//-- Query do relatório da secao 1
lQuery := .T.          
cAliasQry := GetNextAlias()
cAliasSq3 := GetNextAlias()

cFilRb6 := "%AND " + FWJoinFilial("RB6", "RBR") + "%"
cFilRbf := "%AND " + FWJoinFilial("RBF", "RBR") + "%"
cFilSq3 := "%AND " + FWJoinFilial("SQ3", "RBR") + "%"
	
BEGIN REPORT QUERY oSection1

BeginSql Alias cAliasQry

	SELECT 	RBR_FILIAL,RBR_TABELA,RBR_DESCTA,RBR_DTREF,RBR_VLREF,RBR_APLIC,RB6_FILIAL,RB6_TABELA,
			RB6_CLASSE,RBF_DESC,RB6_NIVEL,RB6_COEFIC,RB6_FAIXA,RB6_VALOR,RB6_PTOMIN,RB6_PTOMAX
	FROM 	%table:RBR% RBR
	                                                                                                                
	LEFT JOIN %table:RB6% RB6
		ON  RB6_TABELA = RBR_TABELA %Exp:cFilRb6%
		AND RB6_DTREF = RBR_DTREF
		AND RB6.%NotDel%  
	
	LEFT JOIN %table:RBF% RBF
		ON  RBF_CLASSE = RB6_CLASSE %Exp:cFilRbf%
		AND RBF.%NotDel%  
	WHERE RBR_FILIAL 	>= %Exp:xFilial("RBR", mv_par01)% AND RBR_FILIAL 	<= %Exp:xFilial("RBR", mv_par02)%
		AND RBR_TABELA 	>= %Exp:mv_par03% AND RBR_TABELA 	<= %Exp:mv_par04%
		AND RBR_DTREF 	>= %Exp:mv_par05% AND RBR_DTREF 	<= %Exp:mv_par06%			
		AND RB6_NIVEL 	>= %Exp:mv_par07% AND RB6_NIVEL 	<= %Exp:mv_par08%
		AND RB6_CLASSE 	>= %Exp:mv_par09% AND RB6_CLASSE	<= %Exp:mv_par10%			
		AND RBR.%NotDel%   										
	ORDER BY RBR_FILIAL,RBR_TABELA,RBR_DTREF,RB6_NIVEL,RB6_FAIXA,RB6_CLASSE
EndSql

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
END REPORT QUERY oSection1 

BEGIN REPORT QUERY oSection2

BeginSql Alias cAliasSQ3

	SELECT DISTINCT RBR_FILIAL,RBR_TABELA,RBR_DTREF,RB6_CLASSE,Q3_CARGO, Q3_DESCSUM,RBF_DESC
	FROM 	%table:RBR% RBR
	
	LEFT JOIN %table:RB6% RB6   
		ON RB6_TABELA = RBR.RBR_TABELA 	%Exp:cFilRb6% 
		AND RB6_DTREF = RBR.RBR_DTREF
		AND RB6.%NotDel% 
	
	LEFT JOIN %table:SQ3% SQ3
		ON SQ3.Q3_CLASSE = RB6.RB6_CLASSE  %exp:cFilSq3%
		AND SQ3.%NotDel%  	

	LEFT JOIN %table:RBF% RBF   
		ON RBF_CLASSE = RB6.RB6_CLASSE 	%Exp:cFilRbf%
		AND RBF.%NotDel% 
		 			 										
	WHERE RBR_FILIAL	>= %Exp:xFilial("RBR", mv_par01)% AND RBR_FILIAL 	<= %Exp:xFilial("RBR", mv_par02)% 
		AND RBR_TABELA 	>= %Exp:mv_par03% AND RBR_TABELA 	<= %Exp:mv_par04%
		AND RBR_DTREF 	>= %Exp:mv_par05% AND RBR_DTREF 	<= %Exp:mv_par06%
		AND RB6_NIVEL 	>= %Exp:mv_par07% AND RB6_NIVEL 	<= %Exp:mv_par08%
		AND RB6_CLASSE 	>= %Exp:mv_par09% AND RB6_CLASSE 	<= %Exp:mv_par10%			
		AND RB6.%NotDel%   										
		AND RBR.RBR_TABELA= %report_param: (cAliasQry)->RBR_TABELA%
		AND SQ3.Q3_TABELA = %report_param: (cAliasQry)->RBR_TABELA%
		AND RBR.RBR_DTREF = %report_param: (cAliasQry)->RBR_DTREF%
		AND RB6_CLASSE = %report_param: (cAliasQry)->RB6_CLASSE%
	ORDER BY RBR_FILIAL,RBR_TABELA,RBR_DTREF,RB6_CLASSE
EndSql

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
END REPORT QUERY oSection2

oSection3:SetParentQuery()
 	oSection3:SetParentFilter({|cParam| (cAliasQry)->RBR_FILIAL+(cAliasQry)->RBR_TABELA+DTOS((cAliasQry)->(RBR_DTREF))+(cAliasQry)->RB6_CLASSE == cParam},{|| (cAliasQry)->RBR_FILIAL+(cAliasQry)->RBR_TABELA+DTOS((cAliasQry)->(RBR_DTREF))+(cAliasQry)->RB6_CLASSE}) 

lSec1First := .T.
lSec2First := .T.
/*oSection1:SetLineCondition({|| If(lSec1First, oSection1:Show(), oSection1:Hide()), ;
										 lSec1First := .F., lSec2First := .T. ,.T. })*/	
oSection1:SetLineCondition({|| lSec2First := .T., .T. })
     
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Validação para caso o relatório for impresso em Excel modo tabela.      ³
//³Há repetição em todas as linhas dos cargos, as classes referentes mesmo ³
//³que haja repetição.                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oReport:nDevice <> 4
	oSection2:SetLineCondition({|| U_fHideCargo(@oSection2, @lSec2First), 	;
								Iif(mv_par11==2 .And. Empty((cAliasSq3)->RB6_CLASSE),.F.,.T.) })
EndIf 

dbSelectArea(cAliasQry)
dbGoTop()

oReport:SetMeter((cAliasQry)->(LastRec()))

oSection1:Print()    

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fHideCargo     ³ Autor ³ Tania Bronzeri   ³ Data ³15/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta opcao do Sx1                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fHideCargo(oSection, lFirst)

Local lRetorno := .T.
	
	If lFirst
		oSection:Cell("RB6_CLASSE"):Show()	 
		oSection:Cell("RBF_DESC"):Show()				
	Else
		oSection:Cell("RB6_CLASSE"):Hide()	 
		oSection:Cell("RBF_DESC"):Hide()				
	EndIf
	
	lFirst := .F.

Return lRetorno