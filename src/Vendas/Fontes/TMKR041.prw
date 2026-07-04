/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR041.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ TMKR041  ³ Autor ³ Marcos Daniel         ³ Data ³ 29/09/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Cobrancas pendentes que estao na carteira de cobrancas     ³±±
±±³          ³ de um Operador.                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AP8                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR041()

Local oReport
Local aArea := GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                          ³
//³ Mv_Par01           // Da Filial                               ³
//³ Mv_Par02           // Ate a Filial                            ³
//³ Mv_Par03           // Do Grupo                                ³
//³ Mv_Par04           // Ate o Grupo                             ³
//³ Mv_Par05           // Do Operador                             ³
//³ Mv_Par06           // Ate o Operador                          ³
//³ Mv_Par07           // Tipo: 1-Interno; 2-Externo; 3-Ambos     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK041",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ReportDef ºAutor  ³Hanna               º Data ³  30/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR041                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport				// Objeto do relatorio
Local oSection1				// Objeto da secao 1
Local oSection2				// Objeto da secao 2
Local oSection3				// Objeto da secao 2
Local oSection3x			// Objeto da secao 2.2
Local oBreak				// Objeto da secao 2
Local cAlias1	:= "ACG"	// Pega o proximo Alias Disponivel

cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gera a tela com os dados para a confirmação da geracao do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//"Pendências agendadas para o Operador"
// "Este programa irá emitir uma relação das " # "cobranças pendentes que estão na carteira " # "de cobrança de um Operador."
DEFINE REPORT oReport NAME "TMKR041" TITLE STR0001 PARAMETER "TMK041" ACTION {|oReport| Tkr041PrtRpt( oReport, cAlias1 )} DESCRIPTION STR0002 + STR0003 + STR0003

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, com quebra por filial ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0022 TABLES "SM0" 	//"Quebra por Filial"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "M0_CODFIL"	OF oSection1 TITLE STR0019 SIZE 2	BLOCK {|| TKR041RetEmp( cAlias1, "M0_CODFIL" ) }
DEFINE CELL NAME "M0_FILIAL"	OF oSection1 TITLE STR0020 SIZE 15	BLOCK {|| TKR041RetEmp( cAlias1, "M0_FILIAL" ) }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao2 do relatorio, informando que o arquivo principal utlizado eh o SL3 e o complementar o SB1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection2 OF oSection1 TITLE STR0023 TABLES "SU7" 	//"Operadores"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "U7_COD"	OF oSection2 ALIAS "SU7"
DEFINE CELL NAME "U7_NOME"	OF oSection2 ALIAS "SU7"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao2 (que sera filha da secao1)  e o arquivo principal utilizado na secao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection3 OF oSection2 TITLE STR0024 TABLES "ACF","SA1","SU4","SU5","SU6","ACG"		//"Itens x Pendencia"
DEFINE SECTION oSection3x OF oSection3 TITLE STR0024 TABLES "ACF","SA1","SU4","SU5","SU6","ACG"		//"Itens x Pendencia"

DEFINE CELL NAME "A1_COD"		OF oSection3 ALIAS "SA1"
DEFINE CELL NAME "A1_LOJA"		OF oSection3 ALIAS "SA1"
DEFINE CELL NAME "A1_NOME"		OF oSection3 ALIAS "SA1"
DEFINE CELL NAME "A1_CGC"		OF oSection3 ALIAS "SA1" SIZE 20
DEFINE CELL NAME "ACG_VALOR"	OF oSection3 ALIAS "ACG"
DEFINE CELL NAME "U4_DATA"		OF oSection3 ALIAS "SU4"
DEFINE CELL NAME "ACF_PENDEN"	OF oSection3 ALIAS "ACF"
DEFINE CELL NAME "ACF_HRPEND"	OF oSection3 ALIAS "ACF"
DEFINE CELL NAME "U5_CONTAT"	OF oSection3 ALIAS "SU5"
DEFINE CELL NAME "U6_CODLIG"	OF oSection3x ALIAS "SU6"
DEFINE CELL NAME "ACF_DATA"		OF oSection3x ALIAS "ACF"
DEFINE CELL NAME "ACF_OPERA"	OF oSection3x ALIAS "ACF"

oSection3:SetTotalText("")
DEFINE FUNCTION FROM oSection3:Cell("ACG_VALOR") FUNCTION SUM TITLE STR0013 NO END SECTION

DEFINE BREAK oBreak OF oSection1 WHEN oSection3:Cell("ACG_VALOR")
oBreak:SetTotalInLine(.T.)		// Imprime total em linha ou coluna (default .T. - linha )
DEFINE FUNCTION FROM oSection3:Cell("ACG_VALOR") FUNCTION SUM BREAK oBreak NO END SECTION NO END REPORT TITLE STR0018

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TKR041PrtRptºAutor  ³Hanna               º Data ³  30/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR041                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TKR041PrtRpt( oReport, cAlias1 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 serah filha da secao 1
Local oSection3 := oSection2:Section(1)				// Define que a secao 3 serah filha da secao 2
Local oSection3x := oSection3:Section(1)			// Define que a secao 3x será filha da secao 3
Local cFiltro	:= ""								// Variavel utilizada para o filtro
Local cQuery	:= "%%"								// Variavel da cQuery
Local cQuery1	:= "%%"								// Variavel da cQuery1
Local nTotSec3	:= 0								// Total da Secao 3
Local aFilial	:= {}								// Vetor com todas as filiais selecionadas no SX1
Local nPosFil	:= 1								// Posicao da filial no vetor
Local lExclu	:= FWModeAccess("ACF",3) == "E"		// Verifica se eh exclusivo o ACF
Local cAlias2	:= ""								// Quando for Codebase, utiliza arquivo temporario
Local aTam		:= {}								// Estrutura do arquivo temporario
Local nAuxFor	:= 0								// Contador para o For... Next
Local cFilACF	:= ""								// Filial do ACF
Local aCampos	:= {}								// Vetor com os campos do arquivo de trabalho
Local cDbMs		:= ""								//Nome do BD              
Local cSelect	:= ""								//Campos a adicionar na query

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Abre o arquivo de telecobranca pelo indice do cliente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SU7")
DbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Valida as filiais de acordo com os parametros do SX1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SM0")
DbGotop()
While !Eof()
	If M0_CODIGO <> cEmpAnt .OR. FWGETCODFILIAL < MV_PAR01 .OR. FWGETCODFILIAL > MV_PAR02
		DbSkip()
		Loop
	Endif
	Aadd(aFilial,{M0_CODIGO, FWGETCODFILIAL, M0_FILIAL})
	DbSkip()
End

MakeSqlExpr("TMK041")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Valida o tipo de atendimento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR07 <> 3
	cQuery	:= "%U0_TIPOIE		=	'"	+ Alltrim(Str(Mv_Par07)) + "' AND %"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime apenas as pendencias de Cobranca que estao ativas e que sejam originadas por Pendencias³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cDbMs	:= UPPER(TcGetDb())  //define o tipo de banco para diferenciar o operador de soma

If cDbMs $ "MSSQL"
	cSelect := "%	A1_COD+A1_LOJA	%"
Else
	cSelect := "%	A1_COD||A1_LOJA	%"
EndIf		

cQuery1	:= "% (U4_STATUS = '1' AND U4_TIPO = '2' AND U4_FORMA = '5') %"  	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query utilizada para filtrar todos os dados necessarios ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BeginSql alias cAlias1
	SELECT	A1_FILIAL,	A1_NOME,	A1_CGC,	
			U4_FILIAL,	U4_DATA,	U4_LISTA,
			U5_FILIAL,	U5_CODCONT,	U5_CONTAT,
			U6_FILIAL,	U6_CODENT,	U6_CODLIG, 	
			U7_FILIAL,	U7_POSTO,	U7_COD,		U7_NOME,
			ACG_FILIAL,	ACG_VALOR,
			ACF_FILIAL,	ACF_PENDEN,	ACF_HRPEND,	ACF_DATA,	ACF_OPERA,	ACF_CODIGO

	FROM %table:SU7% SU7, %table:SU0% SU0, %table:SU4% SU4, %table:SU6% SU6, %table:SA1% SA1, %table:ACF% ACF, %table:SU5% SU5, %table:ACG% ACG
	WHERE	U7_FILIAL	=	%xfilial:SU7%			AND
			%exp:cQuery%
			U7_POSTO	=	U0_CODIGO				AND
			%exp:cQuery1%							AND
			U7_COD		=	U4_OPERAD				AND
			U4_LISTA	=	U6_LISTA				AND
			ACF_CODIGO	=	U6_CODLIG				AND
			ACF_CODCON	=	U5_CODCONT				AND
			ACF_CODIGO	=	ACG_CODIGO				AND
			ACF_FILIAL	=	ACG_FILIAL				AND
			U7_POSTO	>=	%exp:mv_par03%			AND
			U7_POSTO	<=	%exp:mv_par04%			AND
			U7_COD		>=	%exp:mv_par05%			AND
			U7_COD		<=	%exp:mv_par06%			AND
			U6_CODENT	=	%exp:cSelect%	        AND
			ACF.%notDel%							AND
			ACG.%notDel%							AND
			SU7.%notDel%							AND
			SU0.%notDel%							AND
			SU4.%notDel%							AND
			SU6.%notDel%							AND
			SU5.%notDel%							AND
			SA1.%notDel%

	ORDER BY ACF_FILIAL, U6_CODLIG
EndSql                     

END REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Controla a impressao do arquivo gerado pelo SELECT ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
(cAlias1)->( DbGotop() )
While (cAlias1)->( !EOF() )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se nao for compartilhado o ACF, quebra por filial³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lExclu .OR. !Empty( (cAlias1)->ACF_FILIAL )
		nPosFil	:= Ascan(aFilial, {|x| x[2] == (cAlias1)->ACF_FILIAL })
		If nPosFil == 0
			(cAlias1)->( DbSkip() )
			Loop
		Else
			DbSelectArea("SM0")
			DbSetOrder(1)
			MsSeek( aFilial[nPosFil][1] + aFilial[nPosFil][2] )
		Endif
	Endif

	If Len( aFilial ) == 0
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicia e imprime o conteudo da Secao1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:Init()
	oSection1:PrintLine()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Varre o ACF enquanto for da mesma filial³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While (cAlias1)->( !EOF() ) .AND. ;
		  ( ( aFilial[nPosFil][2] == (cAlias1)->ACF_FILIAL ) .OR. Empty( (cAlias1)->ACF_FILIAL ) )
			  
		cCodLig	:= (cAlias1)->U6_CODLIG

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona nas tabelas³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SU7->( DbSetOrder(1) )
		SU7->( MsSeek( (cAlias1)->U7_FILIAL + (cAlias1)->U7_COD ))

		SU4->( DbSetOrder(5) )
		SU4->( MsSeek( (cAlias1)->U4_FILIAL + (cAlias1)->U4_LISTA ))

		SU5->( DbSetOrder(1) )
		SU5->( MsSeek( (cAlias1)->U5_FILIAL + (cAlias1)->U5_CODCONT ))

		SU6->( DbSetOrder(1) )
		SU6->( MsSeek( (cAlias1)->U6_FILIAL + (cAlias1)->U4_LISTA ))

		SA1->( DbSetOrder(1) )
		SA1->( MsSeek( (cAlias1)->A1_FILIAL + (cAlias1)->U6_CODENT ))

		ACF->( DbSetOrder(1) )
		ACF->( MsSeek( (cAlias1)->ACF_FILIAL + (cAlias1)->ACF_CODIGO ))

		ACG->( DbSetOrder(1) )
		ACG->( MsSeek( (cAlias1)->ACG_FILIAL + (cAlias1)->ACF_CODIGO ))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Gera a barra de processamento. Inicia a Secao 2 e 3³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:IncMeter()

		oSection2:Init()
		oSection2:PrintLine()
	
		oSection3:Init()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Soma os valores do ACG, pois na celula eh somente apresentado o total³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		While (cAlias1)->( !EOF() ) .AND. cCodLig	== (cAlias1)->U6_CODLIG
				nTotSec3	:= nTotSec3 + (cAlias1)->ACG_VALOR
			(cAlias1)->( DbSkip() )
		End

		oSection3:Cell("A1_CGC"):SetPicture(IIf(RetPessoa(SA1->A1_CGC) == "J","@R! NN.NNN.NNN/NNNN-99","@R 999.999.999-99"))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Coloca o valor total do ACG na celula e finaliza as secoes³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection3:Cell("ACG_VALOR"):SetValue( nTotSec3 )
		nTotSec3 := 0
		oSection3:PrintLine()

		oSection3x:Init()
		oSection3x:PrintLine()

		oSection3x:Finish()
		oSection3:Finish()
		oSection2:Finish()
	End
	oSection1:Finish()		
End

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TKR041RetEmpºAutor  ³Hanna Caroline    º Data ³  10/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para retornar a empresa que esta sendo processada    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR041                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TKR041RetEmp( cAlias1, cCampo )
Local cCmpFil	:= ""

DbSelectArea("SM0")
DbSetOrder(1)


cCmpFil	:= (cAlias1)->ACF_FILIAL

If !MsSeek( cEmpAnt + cCmpFil )
	If cCampo == M0_FILIAL .AND. Empty( cCmpFil )
		cCampo := "M0_NOME"
	Endif
Endif

Return &(cCampo)
