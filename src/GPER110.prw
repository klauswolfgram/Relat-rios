/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER110.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER110   ºAutor  ³Microsiga           º Data ³  06/29/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Extrato FGTS                                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia     ³15/05/14³TPQAJ1³Incluido o fonte da 11 para a 12 e efetu  ³±±
±±³            ³        ³      ³ada a limpeza.                            ³±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPER110()
Local oReport
	//-- Interface de impressao
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ mv_par01        //  Filial De                                ³
	//³ mv_par02        //  Filial Ate                               ³
	//³ mv_par03        //  Centro de Custo De                       ³
	//³ mv_par04        //  Centro de Custo Ate                      ³
	//³ mv_par05        //  Matricula De                             ³
	//³ mv_par06        //  Matricula Ate                            ³
	//³ mv_par07        //  Situacao do Funcionario                  ³
	//³ mv_par08        //  Data de                                  ³
	//³ mv_par08        //  Data Ate                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	Pergunte("GPR110",.F.)
   	oReport := ReportDef()
	oReport:PrintDialog()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER110   ºAutor  ³Microsiga           º Data ³  06/29/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()
Local oReport
Local cDesc1  	:= STR0001				//"Extrato do F.G.T.S.                  "
Local aOrd    	:= {STR0004,STR0005}  // "Matricula"###"Centro de Custo"
Local cPictSRS	:= AllTrim(GetSx3Cache( "RS_SALATU", "X3_PICTURE" ))

DEFINE REPORT oReport NAME "GPER110" TITLE OemToAnsi(STR0001) PARAMETER "GPR110" ACTION {|oReport| R110Imp(oReport)} DESCRIPTION OemtoAnsi(STR0029)
	DEFINE SECTION oSRA OF oReport TITLE OemToAnsi(STR0030) ORDERS aOrd TABLES "SRA","CTT" TOTAL IN COLUMN TOTAL TEXT PAGE BREAK

	DEFINE CELL NAME "RA_FILIAL" 	OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_MAT" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_NOME" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "CTT_DESC01" 	OF oSRA ALIAS "CTT"  TITLE STR0005
	DEFINE CELL NAME "RA_OPCAO"	 	OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_DEMISSA" 	OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_NUMCP" 	OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_SERCP" 	OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_RG" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_PIS" 		OF oSRA ALIAS "SRA"


DEFINE SECTION oSRS OF oSRA TITLE STR0031 TABLES "SRS" TOTAL IN COLUMN TOTAL TEXT STR0021

DEFINE CELL NAME "DATA" 		OF oSRS 			TITLE STR0023 	SIZE 10 ALIGN LEFT  BLOCK {|| SRS->RS_MES+"/"+SRS->RS_ANO }
DEFINE CELL NAME "RS_SALANT" 	OF oSRS ALIAS "SRS" TITLE STR0024
DEFINE CELL NAME "RS_PERJUR"	OF oSRS ALIAS "SRS"	TITLE STR0025
DEFINE CELL NAME "RS_VALJUR" 	OF oSRS ALIAS "SRS" TITLE STR0032
DEFINE CELL NAME "nAntrea" 		OF oSRS 			TITLE STR0026			BLOCK {|| SRS->RS_SALANT + SRS->RS_VALJUR}  Picture cPictSRS
DEFINE CELL NAME "RS_VALDEP"	OF oSRS ALIAS "SRS" TITLE STR0027
DEFINE CELL NAME "RS_SALATU"	OF oSRS ALIAS "SRS" TITLE STR0028

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER110   ºAutor  ³Microsiga           º Data ³  06/29/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R110Imp(oReport)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Declaracao de variaveis                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(1):Section(1)
Local cSitQuery		:= ""
Local nReg			:= 0
Local nOrdem		:= oSection1:GetOrder()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cSeek    	:= ""
Local nOrd     	:= 1
Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER110" , "SRA" , "2" ) + " } " )
Local cAcessaSRS	:= &( " { || " + ChkRH( "GPER110" , "SRS" , "2" ) + " } " )
Local cCcAnt    := Space(9)
Local cOrdem	:= ""
Local oBreakCc

Local cFilCtt
Private aTarefas    := {}      // Array que contera os valores de tarefa
Private cAlias		:= "SRA"
Private cAcessaConvSql 			//Variavel usada para passar o array de filtros a serem realizados
Private aArray := {} 			//Variavel usada para passar o array de filtros a serem realizados

//GERA O FILTRO PARA DBF
aArray := {"SRA", "SRS"}
ffiltro("GPER110",aArray,1)//1- Executa os Filtros

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilDe     := mv_par01
cFilAte    := mv_par02
cCcDe      := mv_par03
cCcAte     := mv_par04
cMatDe     := mv_par05
cMatAte    := mv_par06
cSituacao  := mv_par07
dDatade	   := mv_par08
dDataAte   := mv_par09

// Quebra do relatorio
If nOrdem == 1
	oBreakCc 	:= TRBreak():New(oSection1,{|| SRA->RA_MAT},STR0004, .F.,,.f.) 		// quebra por Matricula
ElseIf nOrdem == 2
	oBreakCc 	:= TRBreak():New(oSection1,{|| SRA->RA_CC},STR0005, .F.,,.f.)		// quebra por centro de custo
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAlias	:= GetNextAlias()

//-- Modifica variaveis para a Query
For nReg:=1 to Len(cSituacao)
	cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
	If ( nReg+1 ) <= Len(cSituacao)
		cSitQuery += ","
	Endif
Next nReg
cSitQuery := "%" + cSitQuery + "%"
oSection1:BeginQuery()

If nOrdem == 1
	cOrdem += "%RA_FILIAL,RA_MAT%"
ElseIf nOrdem == 2
	cOrdem += "%RA_FILIAL, RA_CC, RA_MAT%"
Endif

cFilCtt := If ( CTT->(xFilial()) == space(FWGETTAMFILIAL) , "%AND CTT.CTT_FILIAL = '" +space(FWGETTAMFILIAL) +"'%","%AND CTT.CTT_FILIAL = SRA.RA_FILIAL%")

//TRADUZ AS REGRAS PARA COMANDOS SQL
cAcessaConvSql := "%" + fConvExpPSql(cAcessaSRA) + "%"

BeginSql alias cAlias

		SELECT *
	FROM %table:SRA% SRA
	LEFT JOIN %table:CTT% CTT
		ON	SRA.RA_CC	=	CTT.CTT_CUSTO
		%exp:cFilCtt%
	WHERE	SRA.RA_FILIAL 	>= %exp:MV_PAR01% AND SRA.RA_FILIAL	<= %exp:MV_PAR02% AND
			SRA.RA_CC 		>= %exp:MV_PAR03% AND SRA.RA_CC		<= %exp:MV_PAR04% AND
			SRA.RA_MAT 		>= %exp:MV_PAR05% AND SRA.RA_MAT	<= %exp:MV_PAR06% AND
			SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%) AND
		  	SRA.%notDel%
			ORDER BY %exp:cOrdem%
	EndSql
oSection1:EndQuery()


cFilialAnt := space(FWGETTAMFILIAL)
cFuncaoAnt := "    "

//-- Define o total da regua da tela de processamento do relatorio
(cAlias)->(dbSelectArea(cAlias))
oReport:SetMeter((cAlias)->( RecCount() ))
(cAlias)->(dbGotop())

While !EOF()
	oSection1:Init()

	//-- Incrementa a régua da tela de processamento do relatório
	oReport:IncMeter()

	//-- Verifica se o usuário cancelou a impressão do relatorio
	If oReport:Cancel()
		Exit
	EndIf

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Consiste Filiais e Acessos                                             ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !( (cAlias)->RA_FILIAL $ fValidFil() .and. Eval( cAcessaSRA ) )
		dbSelectArea(cAlias)
      	dbSkip()
       	Loop
	EndIF

	TRPosition():New(oSection1,"CTT",1,{|| RhFilial("CTT",(cAlias)->RA_FILIAL)+(cAlias)->RA_CC},.T.)


	dbSelectArea( "SRS" )
	dbSetOrder(1)
	dbSeek( (cAlias)->RA_FILIAL + (cAlias)->RA_MAT )
	If ! Eof()
		oSection1:PrintLine()   //SO IMPREIME CABECALHO SE TIVER VALORES DE FGTS
	Endif
	oSection2:Init()


	While !Eof() .And. (cAlias)->RA_FILIAL + (cAlias)->RA_MAT == SRS->RS_FILIAL + SRS->RS_MAT

		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Consiste Filiais e Acessos                                             ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	    IF !( SRS->RS_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRS )
    	   	dbSelectArea("SRS")
	       	dbSkip()
    	   	Loop
	    EndIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Consiste Data de / Ate                                                 ³
	  	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    IF (SRS->RS_ANO+SRS->RS_MES) < MesAno(dDatade) .Or. (SRS->RS_ANO+SRS->RS_MES) > MesAno(dDataAte)
    	   	dbSelectArea("SRS")
	       	dbSkip()
    	   	Loop
	    EndIF

		If ((cAlias)->RA_FILIAL + (cAlias)->RA_MAT) # (SRS->RS_FILIAL + SRS->RS_MAT)
    	   	dbSelectArea("SRS")
	       	dbSkip()
    	   	Loop
	    EndIF

		oSection2:PrintLine()
        dbSelectArea("SRS")
		dbSkip()
	Enddo

	//LIMPA OS FILTROS DECLARADOS NO ARRAY, SOBRE UM PROCESSO
	ffiltro("GPER110",aArray,0)//0- Limpa os Filtros

	oSection2:Finish()
	oSection1:Finish()

	dbSelectArea(cAlias)
	dbSkip()
EndDo

Return
