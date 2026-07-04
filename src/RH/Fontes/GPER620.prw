/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'GPER620.CH'
#Include 'Report.ch'  
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±|Fun‡…o    | GPER620    | Autor | Ricardo                    | Data | 18/05/01 |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±|Descri‡…o | Impressao da pesquisa gerencial.                                  |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±|Sintaxe   | U_GPER620()                                                         |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±|Uso       | Especifico                                                        |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±|         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                    |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±|Programador | Data     | BOPS/FNCS |  Motivo da Alteracao                     |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±|			   |		  |			  |				                             |±±
±±|Carlos E. O.|30/10/2013|M12RH01    |Retirados tratamentos de relatorio no for-|±±
±±|        	   |          |RQ0323     |mato R3, ficou apenas o R4.               |±±
±±|Renan Borges|05/06/2015|     TSJAV5|Ajuste para imprimir relatório Sintético  |±±
±±|        	   |          |           |quando não houver totalizador de func.    |±±
±±|Esther V.   |14/06/2016|  TVFY37   |Ajuste na documentacao do fonte.			 |±±
±±|Esther V.   |14/06/2016|  TVFY37   |Ajuste na validacao de acesso de usuario. |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER620()

	Local oReport
	Local aArea			:= GetArea()
	Local cFilAux		:= cFilAnt				//Guarda filial atual

	Private	cString		:= "SRA"				// alias do arquivo principal (Base)
	Private cPerg		:= "GP620R"
	Private aOrd		:= { STR0004, STR0005, STR0006 }	//"Matricula"##"Centro de custo"##"Nome"=> Matriz de selecao de ordem de impressao
	Private cTitulo		:= OemToAnsi(STR0001)
	Private cTotal		:= ""
	Private lArqInBd	:= .T.
	Private cNomeUser	:= ""

	cNomeUser := StrTran(cUserName,".","")
	cNomeUser := StrTran(cNomeUser,"-","")
	cNomeUser := StrTran(cNomeUser,"/","")
	cNomeUser := StrTran(cNomeUser,"_","")
	cNomeUser := StrTran(cNomeUser," ","")

	lArqInBd	:= fPSQInBd()

	If lArqInBd
		// Verifica as perguntas selecionadas.
		pergunte(cPerg,.F.) 

		// Ajusta filtro do arquivo SRU.
		dbSelectArea( 'SRU' )
		Set Filter To Empty( SRU->RU_SEQUE ) .and. !Empty( SRU->RU_CODIGO )

		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	RestArea( aArea )
	cFilAnt := cFilAux   //Retorna filial que entrou
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef()
Pesquisa Gerencial - definição da estrutura do relatório.
@author Andreia dos Santos
@since 17/07/2006
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Local oReport 
	Local oSection1 
	Local oSection2 
	Local oSection3 
	Local oSection4 
	Local oSection5 
	Local oSection6 
	Local oSection7 
	
	Local cDesc		:=	STR0029 //"Este relatorio serve para imprimir a Pesquisa Gerencial " + "Ser  impresso de acordo com os parametros solicitados pelo usuario."
	Local aOrd     	:=	{STR0004,; 	//"Matricula"
			 			 STR0005,; 	//"Centro de Custo"
			 			 STR0006 } 	//"Nome"
	
	//-- Inicio definicao do Relatorio
	DEFINE REPORT oReport NAME "GPER620" TITLE OemToAnsi(STR0009) PARAMETER "GP620R" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc LANDSCAPE

		DEFINE SECTION oSection1 OF oReport ORDERS aOrd TABLES "SRA","CTT" TITLE "Funcionario"
		oSection1:SetHeaderBreak(.T.)
				
			DEFINE CELL NAME "RA_FILIAL"	OF oSection1 ALIAS "SRA"
			DEFINE CELL NAME "RA_CC" 		OF oSection1 ALIAS "SRA"
			DEFINE CELL NAME "DESCCC"		OF oSection1 ALIAS "SRA" TITLE "    "
			DEFINE CELL NAME "RA_MAT" 		OF oSection1 ALIAS "SRA"
			DEFINE CELL NAME "RA_NOME" 		OF oSection1 ALIAS "SRA"

			//-- Section de Verbas
			DEFINE SECTION oSection2 OF oSection1 TITLE "Verbas"
			oSection2:SetHeaderPage(.T.)
				
				DEFINE CELL NAME "VERBA" 		OF oSection2 ALIAS "   " TITLE "Verba" SIZE 20 PIXEL
				DEFINE CELL NAME "VALOR01" 		OF oSection2 ALIAS "   " TITLE "01" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR02" 		OF oSection2 ALIAS "   " TITLE "02" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR03" 		OF oSection2 ALIAS "   " TITLE "03" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR04" 		OF oSection2 ALIAS "   " TITLE "04" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR05" 		OF oSection2 ALIAS "   " TITLE "05" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR06" 		OF oSection2 ALIAS "   " TITLE "06" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR07" 		OF oSection2 ALIAS "   " TITLE "07" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR08" 		OF oSection2 ALIAS "   " TITLE "08" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR09" 		OF oSection2 ALIAS "   " TITLE "09" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR10" 		OF oSection2 ALIAS "   " TITLE "10" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR11" 		OF oSection2 ALIAS "   " TITLE "11" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR12" 		OF oSection2 ALIAS "   " TITLE "12" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VALOR13" 		OF oSection2 ALIAS "   " TITLE "13" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL

			DEFINE SECTION oSection3 OF oSection2 TITLE "Variacao"
			oSection3:SetHeaderBreak(.F.)
			oSection3:SetHeaderSection(.F.)

				DEFINE CELL NAME "VARIACAO"	OF oSection3 ALIAS "  " TITLE "Variacao" BLOCK {||space(03)+"Var. Mensal(%)    "} SIZE 25
				DEFINE CELL NAME "VAR01" 	OF oSection3 ALIAS "  " TITLE "VAR01" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR02" 	OF oSection3 ALIAS "  " TITLE "VAR02" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR03" 	OF oSection3 ALIAS "  " TITLE "VAR03" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR04" 	OF oSection3 ALIAS "  " TITLE "VAR04" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR05" 	OF oSection3 ALIAS "  " TITLE "VAR05" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR06" 	OF oSection3 ALIAS "  " TITLE "VAR06" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR07" 	OF oSection3 ALIAS "  " TITLE "VAR07" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR08" 	OF oSection3 ALIAS "  " TITLE "VAR08" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR09" 	OF oSection3 ALIAS "  " TITLE "VAR09" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR10" 	OF oSection3 ALIAS "  " TITLE "VAR10" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR11" 	OF oSection3 ALIAS "  " TITLE "VAR11" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR12" 	OF oSection3 ALIAS "  " TITLE "VAR12" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "VAR13" 	OF oSection3 ALIAS "  " TITLE "VAR13" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL

			DEFINE SECTION oSection4 OF oSection2 TITLE "Percentual"
			oSection4:SetHeaderBreak(.F.)
			oSection4:SetHeaderSection(.F.)
			
				DEFINE CELL NAME "PERCENTUAL"	OF oSection4 ALIAS "   " TITLE "Percentual" BLOCK {||space(03)+"(%)em rel./  total"} SIZE 25
				DEFINE CELL NAME "PERC01" 		OF oSection4 ALIAS "   " TITLE "PERC01" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC02" 		OF oSection4 ALIAS "   " TITLE "PERC02" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC03" 		OF oSection4 ALIAS "   " TITLE "PERC03" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC04" 		OF oSection4 ALIAS "   " TITLE "PERC04" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC05" 		OF oSection4 ALIAS "   " TITLE "PERC05" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC06" 		OF oSection4 ALIAS "   " TITLE "PERC06" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC07" 		OF oSection4 ALIAS "   " TITLE "PERC07" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC08" 		OF oSection4 ALIAS "   " TITLE "PERC08" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC09" 		OF oSection4 ALIAS "   " TITLE "PERC09" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC10" 		OF oSection4 ALIAS "   " TITLE "PERC10" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC11" 		OF oSection4 ALIAS "   " TITLE "PERC11" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC12" 		OF oSection4 ALIAS "   " TITLE "PERC12" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "PERC13" 		OF oSection4 ALIAS "   " TITLE "PERC13" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL


			DEFINE SECTION oSection5 OF oSection1 TITLE "Total"
			oSection5:SetHeaderBreak(.F.)
			oSection5:SetHeaderSection(.F.)
			
				DEFINE CELL NAME "TOTAL"		OF oSection5 ALIAS "   " TITLE "Total"  SIZE 25 
				DEFINE CELL NAME "TOT01" 		OF oSection5 ALIAS "   " TITLE "TOT01" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT02" 		OF oSection5 ALIAS "   " TITLE "TOT02" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT03" 		OF oSection5 ALIAS "   " TITLE "TOT03" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT04" 		OF oSection5 ALIAS "   " TITLE "TOT04" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT05" 		OF oSection5 ALIAS "   " TITLE "TOT05" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT06" 		OF oSection5 ALIAS "   " TITLE "TOT06" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT07" 		OF oSection5 ALIAS "   " TITLE "TOT07" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT08" 		OF oSection5 ALIAS "   " TITLE "TOT08" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT09" 		OF oSection5 ALIAS "   " TITLE "TOT09" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT10" 		OF oSection5 ALIAS "   " TITLE "TOT10" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT11" 		OF oSection5 ALIAS "   " TITLE "TOT11" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT12" 		OF oSection5 ALIAS "   " TITLE "TOT12" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOT13" 		OF oSection5 ALIAS "   " TITLE "TOT13" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL

			DEFINE SECTION oSection6 OF oSection5 TITLE "Variacao Total"
			oSection6:SetHeaderBreak(.F.)
			oSection6:SetHeaderSection(.F.)
			
				DEFINE CELL NAME "TOTAL_VAR"		OF oSection6 ALIAS "   " TITLE "Total Variacao"  BLOCK {||space(03)+"Var. Mensal(%)    "} SIZE 25
				DEFINE CELL NAME "TOTVAR01" 		OF oSection6 ALIAS "   " TITLE "TOTVAR01" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR02" 		OF oSection6 ALIAS "   " TITLE "TOTVAR02" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR03" 		OF oSection6 ALIAS "   " TITLE "TOTVAR03" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR04" 		OF oSection6 ALIAS "   " TITLE "TOTVAR04" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR05" 		OF oSection6 ALIAS "   " TITLE "TOTVAR05" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR06" 		OF oSection6 ALIAS "   " TITLE "TOTVAR06" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR07" 		OF oSection6 ALIAS "   " TITLE "TOTVAR07" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR08" 		OF oSection6 ALIAS "   " TITLE "TOTVAR08" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR09" 		OF oSection6 ALIAS "   " TITLE "TOTVAR09" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR10" 		OF oSection6 ALIAS "   " TITLE "TOTVAR10" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR11" 		OF oSection6 ALIAS "   " TITLE "TOTVAR11" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR12" 		OF oSection6 ALIAS "   " TITLE "TOTVAR12" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTVAR13" 		OF oSection6 ALIAS "   " TITLE "TOTVAR13" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL

			DEFINE SECTION oSection7 OF oSection5 TITLE "Percentual Total"
			oSection7:SetHeaderBreak(.F.)
			oSection7:SetHeaderSection(.F.)
			
				DEFINE CELL NAME "TOTAL_PER"		OF oSection7 ALIAS "   " TITLE "Total Percentual"  BLOCK {||space(03)+"(%)em rel./total"} SIZE 25
				DEFINE CELL NAME "TOTPERC01" 		OF oSection7 ALIAS "   " TITLE "TOTPERC01" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC02" 		OF oSection7 ALIAS "   " TITLE "TOTPERC02" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC03" 		OF oSection7 ALIAS "   " TITLE "TOTPERC03" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC04" 		OF oSection7 ALIAS "   " TITLE "TOTPERC04" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC05" 		OF oSection7 ALIAS "   " TITLE "TOTPERC05" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC06" 		OF oSection7 ALIAS "   " TITLE "TOTPERC06" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC07" 		OF oSection7 ALIAS "   " TITLE "TOTPERC07" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC08" 		OF oSection7 ALIAS "   " TITLE "TOTPERC08" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC09" 		OF oSection7 ALIAS "   " TITLE "TOTPERC09" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC10" 		OF oSection7 ALIAS "   " TITLE "TOTPERC10" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC11" 		OF oSection7 ALIAS "   " TITLE "TOTPERC11" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC12" 		OF oSection7 ALIAS "   " TITLE "TOTPERC12" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL
				DEFINE CELL NAME "TOTPERC13" 		OF oSection7 ALIAS "   " TITLE "TOTPERC13" PICTURE "@E  999,999,999.99" SIZE 14 PIXEL

				TRPosition():New(oSection1,"CTT",1,{|| xFilial("CTT") + SRA->RA_CC})                   

			DEFINE SECTION oSection8 OF oReport TITLE "Totais"
				oSection8:SetHeaderBreak(.T.)
				oSection8:SetHeaderSection(.F.)
				oSection8:SetPageBreak(.T.)
				DEFINE CELL NAME "TOTSEC01"		OF oSection8 TITLE "TOTSEC"  SIZE 40 BLOCK {|| cTotal }

Return oReport


//-------------------------------------------------------------------
/*/{Protheus.doc} PrintReport()
Pesquisa Gerencial - Release 4 - funcao para impressao do relatorio.

@author Andreia dos Santos
@since 18/04/2006
@version 1.0
@param oReport = objeto com a estrutura do relatorio
@example
PrintReport(oReport)
/*/
//-------------------------------------------------------------------
Static Function PrintReport(oReport)

//-- Objeto
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oSection1:Section(1)
Local oSection3 	:= oSection2:Section(1)
Local oSection4 	:= oSection2:Section(2)
Local oSection5		:= oSection1:Section(2)
Local oSection6 	:= oSection5:Section(1)
Local oSection7 	:= oSection5:Section(2)
Local oSection8 	:= oReport:Section(2)

Local oBreakMat

Local aArea			:= SRA->( GetArea() )	// Ponteiros atuais do arquivo SRA
Local cNomArq		:= ""	// Nomes do arquivo de pesquisa (Base)
Local cNomInd		:= ""	// Nomes do arquivo de pesquisa (Indice)
Local cDatIni		:= ""	// Data inicial de pesquisa
Local cDatFin		:= ""	// Data final da pesquisa
Local cImpNom		:= ""	// Nomes do arquivo de impressao (Base)
Local cImpInd		:= ""	// Nomes do arquivo de impressao (Indice)
Local cMascCus		:= ""	// Mascara co Centro de custo.
Local nMascCus		:= 0	// Mascara co Centro de custo.
Local cFiltro		:= ""
Local cCcAux		:= ""
Local cRDD			:= "TOPCONN"
Local nReg,nRegs,i	:= 1
Local nJ			:= 0
Local nI  			:= 0
Local nX			:= 0
Local TITULO		:= ""
Local aTotal		:= {}
Local aColunas		:= {}
Local nMeses		:= 0
Local aTransf       := {}	// Matriz com os dados das transferencias.
Local aCCTransf     := {}	// Matriz com os C.Custos das transferencias.
Local lImprime      := .F.
Local aFilPerg		:= {}
Local cFilAcess		:= fValidFil()
Local cBranchRA		:= "" 

Private aFilial		:= {}	// Matriz de total da filial.
Private aTotEmp		:= {}	// Matriz de total geral.
Private aCC			:= {}	// Matriz de total do Centro de Custo.
Private aNiveis 	:= {}	// Matriz de niveis de quebra.
Private nNiveis		:= 0	// Controle de niveis de quebra
Private aMeses		:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de Acesso do Usuario                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cAcessaSRA	:= &( " { || " + ChkRH( "GPER620" , "SRA" , "2" ) + " } " )


	DEFINE BREAK oBreakMat OF oSection1 WHEN oSection1:Cell("RA_MAT") TITLE "Quebra de Matricula"

	// Ajusta parametros para impressao.
	cPesq		:= mv_par01
	cSituacao	:= mv_par06
	cCategoria	:= mv_par07
	lVariacao	:= (mv_par08=1)
	lTotal		:= (mv_par09=1)
	lImpNiv		:= (mv_par10=1)
	lAnalitico	:= (mv_par11=2)
	lTotFunc	:= (mv_par12=1)
	nOrdem		:= oSection1:GetOrder()

	// Verifica se selecionou uma pesquisa.
	If Empty( cPesq )
		Aviso( STR0010, STR0011, { STR0012 } )
		dbSelectArea( 'SRU' )
		Set Filter To
		dbSelectArea( 'SRA' )
		SRA->( RestArea( aArea ) )
		Return
	Endif

	// Atualiza variaveis dos nomes do arquivo de pesquisa.
		cNomArq := 'PSQ' + AllTrim(cPesq) + AllTrim( Substr( cNomeUser, 1, 20 ) )
		cNomInd := cNomArq + "1"
		
	// Verifica se o calculo foi efetuado para a pesquisa selecionada.
	If !MsFile( cNomArq,, cRDD )
		Aviso( STR0010, STR0013, { STR0012 } )//##"Atencao" ##"Nao foi encontrado o arquivo de calculo da pesquisa gerencial solicitada"##OK
		dbSelectArea( 'SRU' )
		Set Filter To
		 RestArea( aArea ) 
		Return
	Endif

	// Abre o arquivo de pesquisa gerencial.
	dbUseArea( .T., cRDD, cNomArq, 'TRB', .F. )
	dbSelectArea( 'TRB' )
	Set Index To ( cNomInd )
	TRB->( dbSeek( PadR('PR', FWGETTAMFILIAL)+'DATINI' ) )
	cDatIni := Trim( TRB->RU_PARAM )
	TRB->( dbSeek( PadR('PR', FWGETTAMFILIAL)+'DATFIN' ) )
	cDatFin := Trim( TRB->RU_PARAM )

	dbSelectArea( 'SRU' )
	dbSeek( xFilial( 'SRU' ) + cPesq )

	TITULO += cPesq + ' - ' + SRU->RU_DESC

	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeAdvplExpr("GP620R")

	//-- Filial
	If !Empty(mv_par02)
		cFiltro += mv_par02 + " .AND. "
	EndIf
	
	//-- C.Custo
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

	cFiltro += 'RA_SITFOLH $ "' + cSituacao + '" .AND.'
	cFiltro += 'RA_CATFUNC $ "' + cCategoria + '"'

	dbSelectArea("SRA")
	If nOrdem == 1
		SRA->(dbSetOrder( 1 ))
	ElseIf nOrdem == 2
		SRA->(dbSetOrder( 2 ))
	ElseIf nOrdem == 3
		SRA->(dbSetOrder( 3 ))
	EndIf
	SRA->(dbGoTop())

	oSection1:SetFilter(cFiltro) 

	cTitulo  := If(AllTrim(oReport:Title()) == AllTrim(cTitulo), cTitulo, oReport:Title())
	oReport:SetTitle(cTitulo+"   "+TITULO)

	// Ajusta parametros matriz de meses para impressao.
	cCabec1 := Padc( STR0016, 25, '-' ) + space(11) 
	oSection2:Cell("VERBA"):SetTitle(cCabec1)
	aMeses	:= {}
	For nJ := 1 to 12
		If	cDatIni > cDatFin
			oSection2:Cell("VALOR"+StrZero(nJ,2)):Disable()
		Else
			nMeses ++
			AAdd( aMeses, cDatIni ) 
			cCabec1 := SPACE(08)+Padc( Right( cDatIni, 2 ) + '/' + Left( cDatIni, 4 ), 13, '-' ) //+ space(08)
			If Right( cDatIni, 2 ) = '12'
				cDatIni := StrZero( Val( Left( cDatIni, 4 ) ) + 1, 4, 0 ) + '01'
			Else
				cDatIni := Left( cDatIni, 4 ) + StrZero( Val( Right( cDatIni, 2 ) ) + 1, 2, 0 ) 
			Endif
			oSection2:Cell("VALOR"+StrZero(nJ,2)):SetTitle(cCabec1)
		EndIf
	Next
	cCabec1 := Padc( STR0017, 10, '-' )

	oSection2:Cell("VALOR"+StrZero(nMeses+1,2)):enable()
	oSection2:Cell("VALOR"+StrZero(nMeses+1,2)):SetTitle(cCabec1)
	
	If nMeses < 12
		oSection2:Cell("VALOR13"):disable()
	EndIf

	// Verifica quebra de centro de custo.
	If lImpNiv .and. nOrdem == 2

		// Inicializa variaveis de trabalho.
		cMascCus	:= GetMv('MV_MASCCUS')
		nMascCus	:= Len( cMascCus )
		aNiveis		:= {}
		aNiveis:= MontaMasc(cMascCus)

		// Cria matriz de totalizadores.
		nNiveis := Len( aNiveis )
	    For nI = 1 To nNiveis
   		    cI := Str( nI, 1 )
        	Private aTotCc&cI	:= {}
	        Private cCcAnt&cI 	:= ''    
		Next
	Endif 

	oReport:SetMeter(SRA->( RecCount()) ) 

	oSection1:INIT()

	Do While SRA->(!Eof())
		oReport:IncMeter()

		If oReport:Cancel()
			Exit
		EndIf	

		// Cria matriz com valores da pesquisa gerencial.
		If TRB->( dbSeek( SRA->RA_FILIAL + SRA->RA_MAT ) )
		
			If !( SRA->RA_CATFUNC $ cCategoria ) .Or. !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
				dbSelectArea( "SRA" )
				SRA->( dbSkip())
				Loop
			EndIf

			lImprime := .T.

			// Busca informacoes de transferencias de Centro de Custo.
			dbSelectArea( "SRE" )
			fTransfCc( @aTransf,,.F.,.F.,.T.,.F.,.F. ) 
			nRegsTranf := Len( aTransf )

			//Nao adiciona C.Custos repetidos
			If nRegsTranf > 0
				For nReg := 1 To nRegsTranf
					If ( nPonteiro := Ascan( aCCTransf, { |x| x = aTransf[nReg,3] } ) ) > 0
						aAdd( aCCTransf, aTransf[nReg][6] )
					ElseIf ( nPonteiro := Ascan( aCCTransf, { |x| x = aTransf[nReg,6] } ) ) > 0
						aAdd( aCCTransf, aTransf[nReg][3] )
					Else		
						aAdd( aCCTransf, aTransf[nReg][3] )
						aAdd( aCCTransf, aTransf[nReg][6] )
					EndIf
				Next  
			Else
				aCCTransf := {1}
			EndIf

			dbSelectArea( 'TRB' )
			aColunas	:= gp620Vis( .f., cPesq, .f. )


			// Totaliza matrizes de totais.
			fTotaliza( aColunas, @aFilial )
			fTotaliza( aColunas, @aCC )
			fTotaliza( aColunas, @aTotEmp )

			// Totaliza matrizes de totais de centro de custo por niveis.
			If lImpNiv .and. nOrdem = 2 .and. nNiveis > 0
				For nI = 1 To nNiveis
					cI := Str(nI,1)
					fTotaliza( aColunas, @aTotCC&cI )
				Next
			Endif

			//Se houver transferencias guarda o array para tratar os dados
			If nRegsTranf > 0
				aColunasAux := aClone( aColunas )
				aColunas    := {}
			EndIf

			// Imprime funcionario.
			For nRegs := 1 To Len(aCCTransf)

				oSection2:INIT(.F.)

				//Se houver transferencias, imprime os dados para cada C.Custo separadamente
				If nRegsTranf > 0
					For i := 1 To Len(aColunasAux)
						If aColunasAux[i][2] == aCCTransf[nRegs]
							aAdd( aColunas, aColunasAux[i] )
						EndIf
					Next
				EndIf

				If lAnalitico

					// Imprime secao 03 - verbas.
					For nI := 1 To len( aColunas )

						//Imprime os dados do Funcionario apenas na primeira leitura das verbas - formato analitico
						If nI == 1
							cCcAux	:= aColunas[nI,2]
							If Empty(cCcAux)
								For nX := 2 to Len(aColunas)
									If !Empty(aColunas[nX,2])
										cCcAux := aColunas[nX,2]
										Exit
									EndIf
								Next nX
							EndIf
							
							If Empty(cCcAux)
								cCcAux := SRA->RA_CC
							EndIf

							oSection1:Cell("RA_CC"):SetValue( AllTrim(cCcAux) )
							oSection1:Cell("DESCCC"):SetSize(30)
							oSection1:Cell("DESCCC"):SetValue( fDesc('CTT', AllTrim(cCcAux), 'CTT_DESC01' ) )
							oSection1:PrintLine()				
						EndIf

						// Impressao da linha dos valores das verbas.
						cLinha := Pad( aColunas[nI,1], 20 ) + ' '
						oSection2:Cell("VERBA"):SetValue(cLinha)
						For nJ := 3 To Len( aColunas[nI] ) - 1
							cCelula		:= "VALOR"+Strzero((nJ-2),2)
							oSection2:Cell(cCelula):SetValue(aColunas[nI,nJ])
						Next
						oSection2:PrintLine()	

						// Limpa o conteudo da celula
						For nJ := 3 To Len( aColunas[nI] ) - 1
							cCelula		:= "VALOR"+Strzero((nJ-2),2)
							oSection2:Cell(cCelula):SetValue()
						Next

						// Impressao da linha de variacao mensal.
						If lVariacao
							oSection3:INIT(.F.)
							For nJ := 4 To Len( aColunas[nI] ) - 2
								cLinha 	:= Variacao( aColunas[nI,nJ-1], aColunas[nI,nJ] )
								cCelula	:= "VAR"+Strzero((nJ-2),2)
								oSection3:Cell(cCelula):SetValue(cLinha)
							Next
							oSection3:PrintLine()

							// Limpa o conteudo da celula
							For nJ := 4 To Len( aColunas[nI] ) - 2
								cCelula	:= "VAR"+Strzero((nJ-2),2)
								oSection3:Cell(cCelula):SetValue()
							Next
							oSection3:Finish()
						Endif

						// Impressao da linha de percentual sobre o total.
						If lTotal
							oSection4:INIT(.F.)
							nTotal	:= 0
							For nJ := 3 To Len( aColunas[nI] ) - 2
								nPerc	:= NoRound( aColunas[nI,nJ]*100/aColunas[nI,Len(aColunas[nI])-1], 2 )
								nTotal	+= nPerc
								cCelula	:= "PERC"+Strzero((nJ-2),2)
								oSection4:Cell(cCelula):SetValue(nPerc)
							Next
							oSection4:PrintLine()	

							// Limpa o conteudo da celula
							For nJ := 3 To Len( aColunas[nI] ) - 2
								cCelula	:= "PERC"+Strzero((nJ-2),2)
								oSection4:Cell(cCelula):SetValue()
							Next
							
							oSection4:Finish()
						Endif
					Next
					oSection2:Finish()
				Endif 

				
 				If lTotFunc 
 				
					If Len ( aColunas ) > 0
						aTotal := fProvDesc( aColunas )
					
					
						For nI := 1 To len(aTotal) 

							//Imprime os dados do Funcionario apenas na primeira leitura das verbas - formato sintetico
							If !lAnalitico .And. nI = 1
								oSection1:Cell("RA_CC"):SetValue(aColunas[nI,2])
								oSection1:Cell("DESCCC"):SetSize(30)
								oSection1:Cell("DESCCC"):SetValue( fDesc('CTT', AllTrim(aColunas[nI,2]), 'CTT_DESC01' ) )
								oSection1:PrintLine()
							EndIf

							oReport:SkipLine()

							//Total de proventos
							oSection5:INIT(.F.)	
						
							cLinha := Pad( aTotal[nI,1], 25 ) + ' '
							oSection5:Cell("TOTAL"):SetValue(cLinha)
							For nJ := 3 To Len( aTotal[nI] ) - 1
								cCelula		:= "TOT"+Strzero((nJ-2),2)
								oSection5:Cell(cCelula):SetValue(aTotal[nI,nJ])
							Next
							oSection5:PrintLine()	

							// Limpa o conteudo da celula
							For nJ := 3 To Len( aTotal[nI] ) - 1
								cCelula		:= "TOT"+Strzero((nJ-2),2)
								oSection5:Cell(cCelula):SetValue()
							Next
							oSection5:Finish()

							// Verifica impressao da linha de percentual sobre o total.
							If lVariacao
								oSection6:INIT(.F.)
								For nJ := 4 To Len( aTotal[nI] ) - 2
									cLinha 	:= Variacao( aTotal[nI,nJ-1], aTotal[nI,nJ] )
									cCelula	:= "TOTVAR"+Strzero((nJ-2),2)
									oSection6:Cell(cCelula):SetValue(cLinha)
								Next
								oSection6:PrintLine()	

								// Limpa o conteudo da celula.
								For nJ := 4 To Len( aTotal[nI] ) - 2
									cCelula	:= "TOTVAR"+Strzero((nJ-2),2)
									oSection6:Cell(cCelula):SetValue()
								Next
								oSection6:Finish()	
							Endif

							// Verifica impressao da linha de percentual sobre o total.
							If lTotal
								oSection7:INIT(.F.)
								nTotal	:= 0
								For nJ := 3 To Len( aTotal[nI] ) - 2
									nPerc	:= NoRound( aTotal[nI,nJ]*100/aTotal[nI,Len(aTotal[nI])-1], 2 )
									nTotal	+= nPerc
									cCelula	:= "TOTPERC"+Strzero((nJ-2),2)
									oSection7:Cell(cCelula):SetValue(nPerc)
								Next
								oSection7:PrintLine()	

								// Limpa o conteudo da celula.
								For nJ := 3 To Len( aTotal[nI] ) - 2
									cCelula	:= "TOTPERC"+Strzero((nJ-2),2)
									oSection7:Cell(cCelula):SetValue()
								Next
								oSection7:Finish()	
							Endif  
						Next

						If Len( aColunas ) > 0
							oReport:SkipLine()
							oReport:ThinLine()	
						EndIf
						
					EndIf

					oSection2:Finish()
					aColunas := {}
					aTotal   := {}
				Endif	
			Next
		EndIf  

		// Quebras e Skips.
		dbSelectArea( "SRA" )
		cFilAnt	:= SRA->RA_FILIAL	// Filial atual
		cCusAnt	:= SRA->RA_CC		// Centro de custo atual
		SRA->( dbSkip() )
		
		nTotIni:= 0
		nTotFim:= 0
       	lPrintLine:= .F.

		If Eof()
           	nTotIni := 3
           	nTotFim := 3
           	lPrintLine:= .T.
			lImprime := .F.
		Elseif ((cFilAnt != SRA->RA_FILIAL) .And. (lImprime))
           	nTotIni := 1
           	nTotFim := 2
           	lPrintLine:= .T.
			lImprime := .F.
		ElseIf ((cCusAnt != SRA->RA_CC) .And. (lImprime))
           nTotIni := 1
           nTotFim := 1
		   lImprime := .F.
		Endif   
		If nTotIni #0 .and. nTotFim #0 
	
			For nx := nTotIni to nTotFim
	                //Totalizacoes 
	            If nx == 1 .and. nOrdem # 2
	            	loop
	            EndIf	
                If nx ==1
	                cTotal := STR0024 + cCusAnt //"Total do Centro de Custo : "
                ElseIF nX==2                                 
 	                cTotal := STR0022+ cFilAnt //"Total da Filial: "
				ElseIf nX ==3
 	                cTotal := STR0023 //"Total Geral"
				EndIf    
				oSection8:Init(.F.)
				oSection8:PrintLine()	
				oSection8:Finish()
	
				If nx ==1  //totaliza CC
					aColTot := aclone(aCC)
				ElseIf nx ==2 //Totaliza Filial	
					aColTot := aclone(aFilial)
				Else
					aColTot := aclone(aTotEmp)
				EndIf	

				// Imprime secao 03 - verbas.
				ASort( aColTot,,,{ | x,y | x[1] < y[1] } )
				aColTotAux := aClone(aColTot)
				aColTot    := {}

				// Atualiza matriz de total para somar as verbas iguais.
				For nI = 1 To Len( aColTotAux )
					nLoop := Len( aColTotAux[nI] ) - 1
					If ( nPonteiro := Ascan( aColTot, { | x | x[1] = aColTotAux[nI,1] } ) ) > 0
						For nJ = 3 To nLoop
							aColTot[nPonteiro][nJ]	+= aColTotAux[nI][nJ]
						Next
					Else           
						Aadd( aColTot, aColTotAux[nI] )
					Endif			
				Next  				
				
				For nI := 1 To len( aColTot )

					// Impressao da linha dos valores das verbas.
					oSection2:INIT(.F.)
					cLinha := Pad( aColTot[nI,1], 20 ) + ' '
	   				oSection2:Cell("VERBA"):SetValue(cLinha)

					For nJ := 3 To Len( aColTot[nI] ) - 1
						cCelula		:= "VALOR"+Strzero((nJ-2),2)
		   				oSection2:Cell(cCelula):SetValue(aColTot[nI,nJ])
					Next
					oSection2:PrintLine()	

					// Limpa o conteudo da celula.
					For nJ := 3 To Len( aColTot[nI] ) - 1
						cCelula		:= "VALOR"+Strzero((nJ-2),2)
		   				oSection2:Cell(cCelula):SetValue()
					Next

					// Impressao da linha de variacao mensal.
					If lVariacao
						oSection3:INIT(.F.)
						For nJ := 4 To Len( aColTot[nI] ) - 2
							cLinha 	:= Variacao( aColTot[nI,nJ-1], aColTot[nI,nJ] )
							cCelula	:= "VAR"+Strzero((nJ-2),2)
			   				oSection3:Cell(cCelula):SetValue(cLinha)
						Next
						oSection3:PrintLine()	

						// Limpa o conteudo da celula.
						For nJ := 4 To Len( aColTot[nI] ) - 2
							cCelula	:= "VAR"+Strzero((nJ-2),2)
			   				oSection3:Cell(cCelula):SetValue()
						Next
						oSection3:Finish()
					Endif

					// Impressao da linha de variacao percentual sobre o total.
					If lTotal
						oSection4:INIT(.F.)
						nTotal	:= 0
						For nJ := 3 To Len( aColTot[nI] ) - 2
							nPerc	:= NoRound( aColTot[nI,nJ]*100/aColTot[nI,Len(aColTot[nI])-1], 2 )
							nTotal	+= nPerc
							cCelula	:= "PERC"+Strzero((nJ-2),2)
			   				oSection4:Cell(cCelula):SetValue(nPerc)
						Next
						oSection4:PrintLine()	

						// Limpa o conteudo da celula.
						For nJ := 3 To Len( aColTot[nI] ) - 2
							cCelula	:= "PERC"+Strzero((nJ-2),2)
			   				oSection4:Cell(cCelula):SetValue()
						Next
						oSection4:Finish()	
					Endif
				Next

				// Imprime os totais gerais de Provento, Desconto e Liquido.
				aTotal := fProvDesc( aColTot )
				For nI := 1 To len(aTotal)

	 				oReport:SkipLine()

					// Total de proventos.
					oSection5:INIT(.F.)	
					cLinha := Pad( aTotal[nI,1], 25 ) + ' '
					oSection5:Cell("TOTAL"):SetValue(cLinha)
					For nJ := 3 To Len( aTotal[nI] ) - 1
						cCelula		:= "TOT"+Strzero((nJ-2),2)
	   					oSection5:Cell(cCelula):SetValue(aTotal[nI,nJ])
					Next
					oSection5:PrintLine()	

					// Limpa o conteudo da celula.
					For nJ := 3 To Len( aTotal[nI] ) - 1
						cCelula		:= "TOT"+Strzero((nJ-2),2)
		   				oSection5:Cell(cCelula):SetValue()
					Next
					oSection5:Finish()

					//|Total de Variacao.
					If lVariacao
						oSection6:INIT(.F.)
						For nJ := 4 To Len( aTotal[nI] ) - 2
							cLinha 	:= Variacao( aTotal[nI,nJ-1], aTotal[nI,nJ] )
							cCelula	:= "TOTVAR"+Strzero((nJ-2),2)
			   				oSection6:Cell(cCelula):SetValue(cLinha)
						Next
						oSection6:PrintLine()	

						// Limpa o conteudo da celula.
						For nJ := 4 To Len( aTotal[nI] ) - 2
							cCelula	:= "TOTVAR"+Strzero((nJ-2),2)
			   				oSection6:Cell(cCelula):SetValue()
						Next
						oSection6:Finish()	
					Endif

					// Total de Percentual.
					If lTotal
						oSection7:INIT(.F.)
						nTotal	:= 0
						For nJ := 3 To Len( aTotal[nI] ) - 2
							nPerc	:= NoRound( aTotal[nI,nJ]*100/aTotal[nI,Len(aTotal[nI])-1], 2 )
							nTotal	+= nPerc
							cCelula	:= "TOTPERC"+Strzero((nJ-2),2)
			   				oSection7:Cell(cCelula):SetValue(nPerc)
						Next
						oSection7:PrintLine()	

						// Limpa o conteudo da celula.
						For nJ := 3 To Len( aTotal[nI] ) - 2
							cCelula	:= "TOTPERC"+Strzero((nJ-2),2)
			   				oSection7:Cell(cCelula):SetValue()
						Next
						oSection7:Finish()	
					Endif
					
				Next

				oSection2:Finish()
			Next
		EndIf

		aTransf   := {}
		aCCTransf := {}
	Enddo

	oSection1:Finish()	

// Volta ponteiros anteriores.
dbSelectArea( 'SRU' )
Set Filter To
TRB->( dbCloseArea())
RestArea( aArea ) 

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} U_gp620Prn()
Efetua a impressao do relatorio de pesquisa gerencial

@author Microsiga
@since 13/08/2001
@version 1.0
/*/
//-------------------------------------------------------------------
User Function gp620Prn()

// Define variaveis locais de trabalho.
Local cMascCus,nMascCus	// Mascara co Centro de custo.
Local nI,nJ,cI			// Variaveis para Loop.
Local nMapa				// Controle do mapa de centro de custo.
Local aColunas,nColunas	// Variaveis de montagem da pesquisa gerencial.
Local lTemMov	:= .F.	// Indica se o centro de custo tem movimento
Local lFound	:= .F.

Private aNiveis := {}	// Matriz de niveis de quebra.
Private nNiveis	:= 0	// Controle de niveis de quebra
Private aFilial			// Matriz de total da filial.
Private aTotal			// Matriz de total geral.
Private aCC				// Matriz de total do Centro de Custo.

// Verifica quebra de centro de custo.
If lImpNiv .and. nOrdem = 2
	
	// Inicializa variaveis de trabalho.
	cMascCus	:= GetMv('MV_MASCCUS')
	nMascCus	:= Len( cMascCus )
	aNiveis		:= {}

	aNiveis:= MontaMasc(cMascCus)

	// Cria matriz de totalizadores.
	nNiveis := Len( aNiveis )
    For nI = 1 To nNiveis
   	    cI := Str( nI, 1 )
        Private aTotCc&cI	:= {}
        Private cCcAnt&cI 	:= ''    
	Next
Endif

// Posiciona ponteiros.
dbSelectArea( 'SRA' )
dbSetOrder( 1 )
dbSelectArea( 'IMP' )
dbGoTop()
SetRegua( IMP->( RecCount() ) )

// Cria matriz de totalizadores.
aFilial := {}
aTotal	:= {}
aCC		:= {}

Do While !Eof()

	// Incrementa Regua de Processamento.
	IncRegua()

	// Cria matriz com valores da pesquisa gerencial.
	lFound	:= SRA->( dbSeek( IMP->IMP_FILIAL + IMP->IMP_MAT ) ) 
	If ( lFound )
		
		If !( SRA->RA_CATFUNC $ cCategoria )
			dbSelectArea( 'IMP' )
			fTestaTotal()
			Loop
		EndIf

		aColunas	:= gp620Vis( .f., cPesq )

		// Totaliza matrizes de totais.
		fTotaliza( aColunas, @aFilial )
		fTotaliza( aColunas, @aCC )
		fTotaliza( aColunas, @aTotal )
		
		// Totaliza matrizes de totais de centro de custo por niveis.
		If lImpNiv .and. nOrdem = 2 .and. nNiveis > 0
			For nI = 1 To nNiveis
				cI := Str(nI,1)
				fTotaliza( aColunas, @aTotCC&cI )
			Next
		Endif

		// Imprime funcionario.
		dbSelectArea( 'IMP' )
		dbGoTop()    

		If nOrdem == 1
			dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + SRA->RA_CC )
		ElseIf nOrdem == 2
			dbSeek( SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT )
		ElseIf nOrdem == 3
			dbSeek( SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT )
		EndIf

		lTemMov	:= .F.
		Do While !Eof() .and. IMP->IMP_FILIAL == SRA->RA_FILIAL .and. IMP->IMP_MAT == SRA->RA_MAT
			lTemMov:= ( Ascan(aColunas,{|x| Alltrim(x[2])  == AllTrim( IMP->IMP_CC )  } ) > 0  )
			
			If lAnalitico .and. lTemMov
				fImprime(Iif( 	__cSize = 'P',	;
				                {	STR0020 + SRA->RA_FILIAL + '  ' + STR0021 + IMP->IMP_CC + ' - ' + fDesc('CTT',  IMP->IMP_CC, 'CTT_DESC01' ), STR0014 + SRA->RA_MAT + '  ' + STR0015 + SRA->RA_NOME },;
	                            STR0020 + SRA->RA_FILIAL + '  ' + STR0021 + IMP->IMP_CC + ' - ' + fDesc( 'CTT', IMP->IMP_CC, 'CTT_DESC01' ) + '  ' + STR0014 + SRA->RA_MAT + '  ' + STR0015 + SRA->RA_NOME ),; //STR0020 + SRA->RA_FILIAL + '  ' + STR0014 + SRA->RA_MAT + '  ' + STR0015 + SRA->RA_NOME ),;
								aColunas,;
					   			.f., .f. ;
						     )
	
				If lTotFunc
					fImprime( '', fProvDescFunc( aColunas ), .f., .f. )
				Endif
				Impr( Replicate( '-', Iif( nTamanho = 'P', 80, Iif( nTamanho = 'M', 132, 220 ) ) ) )
	
			ElseIf lTotFunc .and. lTemMov
				fImprime( Iif( 	__cSize = 'P',	{	STR0020 + SRA->RA_FILIAL + '  ' + STR0021 + IMP->IMP_CC + ' - ' + fDesc( 'CTT', IMP->IMP_CC, 'CTT_DESC01' ), STR0014 + SRA->RA_MAT + '  ' + STR0015 + SRA->RA_NOME },STR0020 + SRA->RA_FILIAL + '  ' + STR0021 + IMP->IMP_CC + ' - ' + fDesc( 'CTT', +  IMP->IMP_CC, 'CTT_DESC01' ) + '  ' + STR0014 + SRA->RA_MAT + '  ' + STR0015 + SRA->RA_NOME ), fProvDescFunc( aColunas ), .f., .f. )
				Impr( Replicate( '-', Iif( nTamanho = 'P', 80, Iif( nTamanho = 'M', 132, 220 ) ) ) )
			Endif
			IMP->( dbSkip() )
		Enddo
		
	EndIf

	// Quebras e Skips.
	dbSelectArea( 'IMP' )
	If ( lFound )
		IMP->( dbSkip(-1) ) //Volta o registro devido ao Skip do 2o. While
	Else
		IMP->( dbSkip() )
	EndIf		
	fTestaTotal()
Enddo

// Finaliza impressao.
Impr( '', 'F' )
Set Device To Screen
If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool( WnRel )
Endif
MS_Flush()
Return


//-------------------------------------------------------------------
/*/{Protheus.doc} Variacao()
Calcula o percentual de variacao entre meses.

@author Microsiga
@since 17/08/2001
@version 1.0
@param nValor1 = valor do primeiro mes
@param nValor2 = valor do segundo mes
@return numerico, valor em decimal do percentual de variacao entre os dois parametros.
@example
Variacao( nValor1, nValor2 )
/*/
//-------------------------------------------------------------------
Static Function Variacao( nValor1, nValor2 )

// Verifica se nao houve variacao.
If nValor1 = 0 .or. nValor2 = 0 .or. nValor1 = nValor2
	Return 0
Endif

// Calcula e retorna a variacao.
Return NoRound( ( ( nValor2 * 100 / nValor1 ) - 100 ), 2 )


//-------------------------------------------------------------------
/*/{Protheus.doc} fImprime()
Executa a impressao do Funcionario.

@author Microsiga
@since 22/08/2001
@version 1.0
@param uCabRel = Cabecalho
@param aMatRel = Matriz de valores
@param lSalta  = Salta pagina antes?
@param lPula   = Pula pagina depois?
@example
fImprime( uCabRel, aMatRel, lSalta, lPula )
/*/
//-------------------------------------------------------------------
Static Function fImprime( 	uCabRel,;	// Cabecalho 
							aMatRel,;	// Matriz de valores
							lSalta,;	// Salta pagina antes?
							lPula )		// Pula pagina depois?

// Declara variaveis locais de execucao.
Local nI,nJ						// Variaveis para Loop
Local cLinha					// Linha  de impressao
Local nTotal,nPerc				// Variaveis auxiliares
Local nCabRel := Len( uCabRel )	// Tamanho do cabecalho
Local nMatRel := Len( aMatRel )	// Tamanho da matriz de valores
							
// Verifica salto de pagina.
If lSalta
	LI	:= 99
Endif

// Verifica tipo do cabecalho.
If ValType( uCabRel ) = 'A'
	For nI = 1 To nCabRel
		Impr( uCabRel[nI] )
		Impr( '' )
	Next
Else
	Impr( uCabRel )
	If !Empty( uCabRel )
		Impr( '' )
	Endif
Endif

// Imprime planilha de pesquisa gerencial.
For nI = 1 To nMatRel

	If AllTrim( aMatRel[nI,2] ) == AllTrim( IMP->IMP_CC )

		cLinha := Pad( aMatRel[nI,1], 25 ) + ' '
		For nJ = 3 To Len( aMatRel[nI] ) - 1
			cLinha += Transform( aMatRel[nI,nJ], '@E 999,999,999.99' )
		Next
		Impr( cLinha )

		// Verifica impressao da linha de variacao mensal.
		If lVariacao
			cLinha := Pad( STR0018, 25 ) +  '               '
			For nJ = 4 To Len( aMatRel[nI] ) - 2
				cLinha += Transform( Variacao( aMatRel[nI,nJ-1], aMatRel[nI,nJ] ), '@E 999,999,999.99' )
			Next
			Impr( cLinha )
		Endif

		// Verifica impressao da linha de percentual sobre o total.
		If lTotal
			cLinha	:= Pad( STR0019, 25 ) + ' '
			nTotal	:= 0
			For nJ = 3 To Len( aMatRel[nI] ) - 3
				nPerc	:= NoRound( aMatRel[nI,nJ]*100/aMatRel[nI,Len(aMatRel[nI])-1], 2 )
				nTotal	+= nPerc
				cLinha	+= Transform( nPerc, '@E 999,999,999.99' )
			Next
			cLinha += Transform( 100 - nTotal, '@E 999,999,999.99' )
			Impr( cLinha )			
		Endif
	EndIf
Next

// Verifica salto de pagina.
If lPula
	LI	:= 99
Endif

Return .t.


//-------------------------------------------------------------------
/*/{Protheus.doc} fImprimeTotais()
Executa a impressao do total.

@author Microsiga
@since 22/08/2001
@version 1.0
@param uCabRel = Cabecalho
@param aMatRel = Matriz de valores
@param lSalta  = Salta pagina antes?
@param lPula   = Pula pagina depois?
@example
fImprimeTotais( uCabRel, aMatRel, lSalta, lPula )
/*/
//-------------------------------------------------------------------
Static Function fImprimeTotais( 	uCabRel,;	// Cabecalho 
									aMatRel,;	// Matriz de valores
									lSalta,;	// Salta pagina antes?
									lPula )		// Pula pagina depois?

// Declara variaveis locais de execucao.
Local nI,nJ						// Variaveis para Loop
Local cLinha					// Linha  de impressao
Local nTotal,nPerc				// Variaveis auxiliares
Local nCabRel := Len( uCabRel )	// Tamanho do cabecalho
Local nMatRel := Len( aMatRel )	// Tamanho da matriz de valores
Local aMatTot := {}
Local nMatTot

// Verifica salto de pagina.
If lSalta
	LI	:= 99
Endif

// Verifica tipo do cabecalho.
If ValType( uCabRel ) = 'A'
	For nI = 1 To nCabRel
		Impr( uCabRel[nI] )
		Impr( '' )
	Next
Else
	Impr( uCabRel )
	If !Empty( uCabRel )
		Impr( '' )
	Endif
Endif 

ASort( aMatRel,,,{ | x,y | x[1] < y[1] } )
For nI = 1 To nMatRel
	// Atualiza matriz de total.
	nLoop := Len( aMatRel[nI] ) - 1
	If ( nPonteiro := Ascan( aMatTot, { | x | x[1] = aMatRel[nI,1] } ) ) > 0
		For nJ = 3 To nLoop
			aMatTot[nPonteiro][nJ]	+= aMatRel[nI][nJ]
		Next
	Else           
		Aadd( aMatTot, aMatRel[nI] )
	Endif			
Next

nMatTot := Len( aMatTot )

// Imprime planilha de pesquisa gerencial.
//ASort( aMatRel,,,{ | x,y | x[1] < y[1] } )
For nI = 1 To nMatTot
	cLinha := Pad( aMatTot[nI,1], 25 ) + ' '
	For nJ = 3 To Len( aMatTot[nI] ) - 1
		cLinha += Transform( aMatTot[nI,nJ], '@E 999,999,999.99' )
	Next
	Impr( cLinha )

	// Verifica impressao da linha de variacao mensal.
	If lVariacao
		cLinha := Pad( STR0018, 25 ) +  '               '
		For nJ = 4 To Len( aMatTot[nI] ) - 2
			cLinha += Transform( Variacao( aMatTot[nI,nJ-1], aMatTot[nI,nJ] ), '@E 999,999,999.99' )
		Next
		Impr( cLinha )
	Endif

	// Verifica impressao da linha de percentual sobre o total.
	If lTotal
		cLinha	:= Pad( STR0019, 25 ) + ' '
		nTotal	:= 0
		For nJ = 3 To Len( aMatTot[nI] ) - 3
			nPerc	:= NoRound( aMatTot[nI,nJ]*100/aMatTot[nI,Len(aMatTot[nI])-1], 2 )
			nTotal	+= nPerc
			cLinha	+= Transform( nPerc, '@E 999,999,999.99' )
		Next
		cLinha += Transform( 100 - nTotal, '@E 999,999,999.99' )
		Impr( cLinha )			
	Endif
Next

// Verifica salto de pagina.
If lPula
	LI	:= 99
Endif

aMatRel := {}
aMatRel := aClone( aMatTot )

Return .t.


//-------------------------------------------------------------------
/*/{Protheus.doc} fTotaliza()
Totaliza matrizes de totais.

@author Microsiga
@since 22/08/2001
@version 1.0
@param aMatPsq = Matriz origem
@param aMatTot = Matriz destino
@example
fTotaliza( aMatPsq, aMatTot )
/*/
//-------------------------------------------------------------------
Static Function fTotaliza( 	aMatPsq,;	// Matriz origem
							aMatTot )	// Matriz destino

// Declara variaveis locais de execucao.
Local nMatPsq := Len( aMatPsq )	// Tamanho da matriz de pesquisa
Local nI
Local nJ
Local nPonteiro
Local nLoop  	// Variaveis auxiliares

For nI = 1 To nMatPsq

	// Atualiza matriz de total.
	nLoop := Len( aMatPsq[nI] ) - 1
	If ( nPonteiro := Ascan( aMatTot, { | x | x[1]+x[2] = aMatPsq[nI,1]+aMatPsq[nI,2] } ) ) > 0
		For nJ = 3 To nLoop
			aMatTot[nPonteiro][nJ]	+= aMatPsq[nI][nJ]
		Next
	Else
		Aadd( aMatTot, { aMatPsq[nI,1], aMatPsq[nI,2] } )
		nPonteiro := Len( aMatTot )
		For nJ = 3 To nLoop
			Aadd( aMatTot[nPonteiro], aMatPsq[nI][nJ] )
		Next
		Aadd( aMatTot[nPonteiro], .f. )
	Endif			
Next

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} fTestaTotal()
 Controla o avanco e quebras do relatorio.

@author Microsiga
@since 23/08/2001
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function fTestaTotal()
// Declara variaveis locais de execucao.
Local cFilAnt	:= IMP->IMP_FILIAL	// Filial atual
Local cCusAnt	:= IMP->IMP_CC		// Centro de custo atual
Local cI,nI							// Variaveis auxiliares

// Gera niveis de centro de custo atuais.
If lImpNiv .And. nNiveis > 0 .and. nOrdem = 2
    For nI = 1 To nNiveis
        cI			:= Str( nI, 1, 0 )
        cCcAnt&cI	:= Substr( cCusAnt, 1, aNiveis[nI] )
    Next
Endif

// Avanca registro.
dbSkip()

// Verifica se e fim de arquivo.
If Eof()

	// Imprime totais.
	fImpCC( IMP->IMP_CC, cCusAnt )
	fImpFil( cFilAnt )
	fImpTot()

// verifica se mudou filial.
Elseif cFilAnt != IMP->IMP_FILIAL

	// Imprime totais.
	fImpCC( IMP->IMP_CC, cCusAnt )
	fImpFil( cFilAnt )
ElseIf cCusAnt != IMP->IMP_CC

	// Imprime totais.
	fImpCC( IMP->IMP_CC, cCusAnt )
Endif
Return


//-------------------------------------------------------------------
/*/{Protheus.doc} fImpCC()
Efetua a impressao da quebra do centro de custo.

@author Microsiga
@since 23/08/2001
@version 1.0
@param cCusto = Centro de Custo do atual registro
@param cCusAnt = Centro de Custo anterior.
@example
fImpCC( cCusto, cCusAnt )
/*/
//-------------------------------------------------------------------
Static Function fImpCC( cCusto, cCusAnt )

// Declara variaveis locais.
Local cTitulo	// Titulo da impressao
Local nI,cI		// Variaveis auxiliares

// Verifica se a ordem e por centro de custo.
If nOrdem = 2

	// Verifica se solicitou quebra por niveis.
	If lImpNiv .and. nNiveis > 0

		// Imprime totais.
		For nI = nNiveis To 1 Step -1
			cI := Str( nI, 1, 0 )
			If Substr( cCusto, 1, aNiveis[nI] ) # cCCAnt&cI 
				cTitulo := STR0024 + cCCAnt&cI + '-' +  fDesc('CTT',  cCCAnt&cI, 'CTT_DESC01' )
				If len(aTotCC&cI)>0
					fImprimeTotais( cTitulo, aTotCC&cI, .t., .f. )
					fImprimeTotais( '', fProvDesc( aTotCC&cI ), .f., .t. )
				EndIf	
				aTotCC&cI := {}
			Endif
		Next
	Else

		// Imprime totais.
		cTitulo := STR0024 + cCusAnt + '-' +  fDesc( 'CTT',  cCusAnt, 'CTT_DESC01' )
		If len( aCC ) >0
			fImprimeTotais( cTitulo, aCC, .t., .f. )
			fImprimeTotais( '', fProvDesc( aCC ), .f., .t. )
		EndIf	
		aCC := {}
	Endif
Endif
Return Nil


//-------------------------------------------------------------------
/*/{Protheus.doc} fImpFil()
Efetua a impressao da quebra de filial.

@author Microsiga
@since 23/08/2001
@version 1.0
@param cCodFil = Filial que será impressa na quebra.
@example
fImpFil( cCodFil )
/*/
//-------------------------------------------------------------------
Static Function fImpFil( cCodFil )

// Declara variaveis locais de execussao.
Local cTitulo := STR0022 + cCodFil

// Imprime totais.
If len(aFilial) > 0
	fImprimeTotais( cTitulo, aFilial, .t., .f. )
	fImprimeTotais( '', fProvDesc( aFilial ), .f., .t. )
EndIF	
aFilial := {}
Return Nil   


//-------------------------------------------------------------------
/*/{Protheus.doc} fImpTot()
Efetua a impressao do total geral.

@author Microsiga
@since 23/08/2001
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function fImpTot()

// Imprime totais.
If len(aTotal) > 0
	fImprimeTotais( STR0023, aTotal, .t., .f. )
	fImprimeTotais( '', fProvDesc( aTotal ), .f., .t. )
EndIf	
Return Nil


//-------------------------------------------------------------------
/*/{Protheus.doc} fProvDesc()
Totaliza proventos e descontos.  

@author Microsiga
@since 22/08/2001
@version 1.0
@param aMatPsq = Matriz com dados da pesquisa
@return aDescontos = matriz com os valores de descontos
		aProventos = matriz com os valores de provento
		aLiquido   = matriz com os valores de líquido
@example
fProvDesc( aMatPsq )
/*/
//-------------------------------------------------------------------
Static Function fProvDesc( aMatPsq )

// Declara variaveis locais de execucao.
Local nMatPsq 		:= Len( aMatPsq )	// Tamanho da matriz de pesquisa
Local aProventos	:= {}				// Matriz de proventos
Local aDescontos	:= {}				// Martriz de descontos
Local aLiquido		:= {}				// Matriz de liquidos

// Variaveis Auxiliares.
Local nI
Local nJ
Local nLoop

// Inicializa matrizes de retorno de acordo com o num. de meses selecionados.
nLoop := Len(aMeses) + 1
Aadd( aProventos, STR0026 )
Aadd( aProventos, "" )
Aadd( aDescontos, STR0027 )
Aadd( aDescontos, "" )
Aadd( aLiquido  , STR0028 )
Aadd( aLiquido  , "" )

// Loop de acordo com  o numero de meses selecionados.
For nJ = 1 To nLoop
	Aadd( aProventos, 0 )
	Aadd( aDescontos, 0 )
	Aadd( aliquido  , 0 )
Next
Aadd( aProventos, .f. )
Aadd( aDescontos, .f. )
Aadd( aLiquido  , .f. )

For nI = 1 To nMatPsq
	// Atualiza matriz de total.
	nLoop := Len( aMatPsq[nI] ) - 1
	If fDesc( 'SRV', Left( aMatPsq[nI,1], 3 ), 'RV_TIPOCOD' ) = '1'
		For nJ = 3 To nLoop
			aProventos[nJ]	+= aMatPsq[nI][nJ]
			aLiquido[nJ]	+= aMatPsq[nI][nJ]
		Next
	ElseIf   fDesc( 'SRV', Left( aMatPsq[nI,1], 3 ), 'RV_TIPOCOD' ) = '2'
		For nJ = 3 To nLoop
			aDescontos[nJ]	+= aMatPsq[nI][nJ]
			aLiquido[nJ]	-= aMatPsq[nI][nJ]
		Next
	Endif
Next

// Verifica forma de retorno da matriz.
nLoop := Len( aProventos ) - 1
If aProventos[nLoop] > 0 .and. aDescontos[nLoop] > 0 
	Return { aProventos, aDescontos, aLiquido }
ElseIf aProventos[nLoop] > 0
	Return { aProventos }
Endif

Return { aDescontos }	


//-------------------------------------------------------------------
/*/{Protheus.doc} fProvDescFunc()
Totaliza proventos e descontos para cada funcionario processado.

@author Microsiga
@since 22/08/2001
@version 1.0
@param aMatPsq = Matriz com dados da pesquisa
@return aDescontos = matriz com os valores de descontos
		aProventos = matriz com os valores de provento
		aLiquido   = matriz com os valores de líquido
@example
fProvDescFunc( aMatPsq )
/*/
//-------------------------------------------------------------------
Static Function fProvDescFunc( aMatPsq )

// Declara variaveis locais de execucao.
Local nMatPsq 		:= Len( aMatPsq )	// Tamanho da matriz de pesquisa
Local aProventos	:= {}				// Matriz de proventos
Local aDescontos	:= {}				// Martriz de descontos
Local aLiquido		:= {}				// Matriz de liquidos

//Variaveis Auxiliares.
Local nI
Local nJ
Local nLoop  	 

// Inicializa matrizes de retorno de acordo com o num. de meses selecionados.
nLoop := Len(aMeses) + 1
Aadd( aProventos, STR0026 )
Aadd( aProventos, "" )
Aadd( aDescontos, STR0027 )
Aadd( aDescontos, "" )
Aadd( aLiquido  , STR0028 )
Aadd( aLiquido  , "" )

// Loop de acordo com  o numero de meses selecionados.
For nJ = 1 To nLoop
	Aadd( aProventos, 0 )
	Aadd( aDescontos, 0 )
	Aadd( aliquido  , 0 )
Next
Aadd( aProventos, .f. )
Aadd( aDescontos, .f. )
Aadd( aLiquido  , .f. )

For nI = 1 To nMatPsq
	// Atualiza matriz de total.
	If AllTrim( aMatPsq[nI,2] ) == AllTrim( IMP->IMP_CC )

		nLoop := Len( aMatPsq[nI] ) - 1
		If fDesc( 'SRV', Left( aMatPsq[nI,1], 3 ), 'RV_TIPOCOD' ) = '1'
			For nJ = 3 To nLoop                  
				aProventos[2]  := aMatPsq[nI][2]
				aProventos[nJ] += aMatPsq[nI][nJ]
				aLiquido[2]    := aMatPsq[nI][2]
				aLiquido[nJ]   += aMatPsq[nI][nJ]				
			Next
		ElseIf   fDesc( 'SRV', Left( aMatPsq[nI,1], 3 ), 'RV_TIPOCOD' ) = '2'
			For nJ = 3 To nLoop
				aDescontos[2]  := aMatPsq[nI][2]
				aDescontos[nJ] += aMatPsq[nI][nJ]
				aLiquido[2]    := aMatPsq[nI][2]
				aLiquido[nJ]   -= aMatPsq[nI][nJ]
			Next
		Endif

	Endif
Next

// Verifica forma de retorno da matriz.
nLoop := Len( aProventos ) - 1
If aProventos[nLoop] > 0 .and. aDescontos[nLoop] > 0 
	Return { aProventos, aDescontos, aLiquido }
ElseIf aProventos[nLoop] > 0
	Return { aProventos }
Endif

Return { aDescontos }

