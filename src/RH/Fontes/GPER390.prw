/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER390.CH"
#include "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออหออออออออออหอออออออหออออออออออออออออออออออออออออหออออออหอออออออออออออปฑฑ
ฑฑบPrograma  บ GPER390  บ Autor บ Equipe RH                  บ Data บ  26/07/06   บฑฑ
ฑฑฬออออออออออฮออออออออออสอออออออสออออออออออออออออออออออออออออสออออออสอออออออออออออนฑฑ
ฑฑบDescricao บ  RelaCAo de Frias Vencidas No Mes                                 บฑฑ
ฑฑฬออออออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSintaxe   บ U_GPER390()                                                          บฑฑ
ฑฑฬออออออออออสออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ           ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                    บฑฑ
ฑฑฬออออออออออออหออออออออหออออออออออออออหออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบProgramador บ Data   บ FNC          บ Motivo da Alteracao                      บฑฑ
ฑฑฬออออออออออออฮออออออออฮออออออออออออออฮออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRaquel Hagerบ04/11/13บM12RH01 196701บUnificacao das Folhas de Pagamento.       บฑฑ
ฑฑบCํcero Alvesบ10/12/15บTTWWBG 	   บCorre็ใo para nใo apresentar informa็๕es  บฑฑ
ฑฑบ			   บ		บ		 	   บrepetidas								  บฑฑ
ฑฑบRenan Borgesบ30/05/16บTVFSTF 	   บAjuste para imprimir f้rias vencidas no   บฑฑ
ฑฑบ			   บ		บ		 	   บmes desejado corretamente.          	  บฑฑ
ฑฑ|Claudinei S.|28/04/17|MRH-482       |Ajuste para considerar corretamente as    |ฑฑ
ฑฑ|            |        |			   |faltas dos funcionแrios com Regime de     |ฑฑ
ฑฑ|            |        | 	           |Tempo Parcial que possuam menos de 8      |ฑฑ
ฑฑ|            |        | 	           |faltas.                                   |ฑฑ
ฑฑศออออออออออออสออออออออสออออออออออออออสออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function GPER390()
Local oReport
Private cAlias		:= "SRA"

	/*
	ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	ณ Carregar os Mnemonicos 	                                   ณ
	ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	SetMnemonicos(NIL,NIL,.T.)

	// Verifica as perguntas selecionadas

	// Variaveis utilizadas para parametros
	// mv_par01	// Filial
	// mv_par02	// Centro de Custo
	// mv_par03	// Matricula
	// mv_par04	// Data de Referencia
	// mv_par05	// Salta Pagina Quebra C.Custo
	// mv_par06	// Situacao
	// mv_par07	// Categorias
	// mv_par08	// Salta Pagina por Filial
	// mv_par09 // Somente ferias dobradas
	// mv_par10 // Data limite maxima
	Pergunte("GP390R",.F.)

	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณ ReportDef บ Autor ณ Equipe RH         บ Data ณ  12/06/06   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Definicao de Colunas.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER390                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ReportDef()
Local oReport
Local oSection
Local cDesc		:=	STR0001 + STR0002 + STR0003 		//Relacao de Ferias Vencidas No Mes
Local aOrd    	:= {STR0001 ,STR0002}					//"Matricula"###"Centro de Custo"

	DEFINE REPORT oReport NAME "GPER390" TITLE OemToAnsi(STR0008) PARAMETER "GP390R" ACTION {|oReport| R390Imp(oReport)} DESCRIPTION OemToAnsi(STR0014)

	DEFINE SECTION oSRA OF oReport TITLE OemToAnsi(STR0003) ORDERS aOrd TABLES "SRA","SRF" PAGE HEADER

	DEFINE CELL NAME "RA_FILIAL" 	OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_CC" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_MAT" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_NOME" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RF_IVENPEN" 	OF oSRA ALIAS "SRF"
	DEFINE CELL NAME "RF_DVENPEN" 	OF oSRA ALIAS "SRF"					ALIGN Right 	PICTURE "@E 9,999,999,999.9"
	DEFINE CELL NAME "DI_FALTA"	  	OF oSRA								TITLE STR0012	PICTURE	"@E 9,999,999,999.9"
	DEFINE CELL NAME "FE_ANTE"	  	OF oSRA								TITLE STR0013	PICTURE "@E 9,999,999,999.9"

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณ R390Imp  บ Autor ณ Equipe RH          บ Data ณ  24/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao do relatorio.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER390                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function R390Imp(oReport)
Local aOrdBagRI		:= {}
Local aOrdBag    	:= {}
Local aValBenef  	:= {}
Local aCodFol		:= {}
Local aPerFerias	:= {}
Local cAcessaSRA  := &("{ || " + ChkRH("GPER390","SRA","2") + "}")
Local cSitQuery	:= ""
Local cCatQuery := ""
Local lTemNormal,lTemPendente
Local nReg	:= 1
Local nFor	:= 0
Local oSection 		:= oReport:Section(1)
Local nOrdem		:= oSection:GetOrder()
Local nPosFer		:=	0
Local oBreakCc
Local oBreakFun
Local oBreakFil

LOCAL LDOBRADA  := MV_PAR09 == 1
LOCAL nDiasMax  := If( Empty(mv_par10), 45 , val(mv_par10) )
LOCAL DFIMPAQUI := 0
LOCAL DPRPAQUI  := 0
LOCAL nLimMax	:= 0

lMetadeFal	:= If( Type("lMetadeFal") == "U", .F. , lMetadeFal)
lTempoParc	:= If( Type("lTempoParc") == "U", .F. , lTempoParc)
cTipoRot	:= If( Type( "cTipoRot" ) == "U",	"", cTipoRot)

Private dDataRef	:= mv_par04							// Data de Referencia
Private lSalta		:= If( mv_par05 == 1 , .T. , .F. )	// Salta Pagina Quebra C.Custo
Private cSituacao	:= mv_par06							// Situacao
Private cCategoria	:= mv_par07							// Categoria
Private cFilialSv	:= ""
Private lQuebFil	:= If( Empty(mv_par08), .T., If( mv_par08 == 1 , .T. , .F.) )	// Salta Pagina por Filial

	// Complementa o Titulo do Relatorio com a Data de Referencia
	oReport:SetTitle( oReport:Title() + STR0011 + DtoC( dDataRef ) )

	If nOrdem = 2
		oBreakFun := TRBreak():New(oSection, oSection:Cell("RA_MAT"),, .F.,,.F.)
		TRfunction():New(oSection:Cell("RF_DVENPEN"),,"SUM",oBreakFun,,"@E 9,999,999,999.9",,.F.,.F.)
		TRfunction():New(oSection:Cell("DI_FALTA"),,"SUM",oBreakFun,,"@E 9,999,999,999.9",,.F.,.F.)
		TRfunction():New(oSection:Cell("FE_ANTE"),,"SUM",oBreakFun,,"@E 9,999,999,999.9",,.F.,.F.)
		oBreakCc := TRBreak():New(oSection, oSection:Cell("RA_CC"),, .F.,, lSalta ) // ultimo parametro quebra mesma pagina
	Else
		oBreakFun := TRBreak():New(oSection, oSection:Cell("RA_MAT"),, .F.,,.F.)
		TRfunction():New(oSection:Cell("RF_DVENPEN"),"SOMADVEN","SUM",oBreakFun,,"@E 9,999,999,999.9",,.F.,.F.)
		TRfunction():New(oSection:Cell("DI_FALTA"),"SOMAFALTA","SUM",oBreakFun,,"@E 9,999,999,999.9",,.F.,.F.)
		TRfunction():New(oSection:Cell("FE_ANTE"),"SOMAVLRD","SUM",oBreakFun,,"@E 9,999,999,999.9",,.F.,.F.)
	EndIf

	// Quebra de pagina por Filial - Independente da ordem de impressao ser CC ou Mat
	oBreakFil := TRBreak():New(oSection, oSection:Cell("RA_FILIAL"), "Filial", .F.,, lQuebFil ) // ultimo parametro quebra mesma pagina

	// Faz filtro no arquivo...
	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr("GP390R")

	cAlias	:= GetNextAlias()

	// Modifica variaveis para a Query
	For nReg:=1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cSituacao)
			cSitQuery += ","
		Endif
	Next nReg
	cSitQuery := "%" + cSitQuery + "%"

	For nReg:=1 to Len(cCategoria)
		cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cCategoria)
			cCatQuery += ","
		Endif
	Next nReg
	cCatQuery := "%" + cCatQuery + "%"

	// "Matricula"###"Centro de Custo"
	If nOrdem == 1
		cOrdem := "%RA_FILIAL,RA_MAT%"
	ElseIf nOrdem == 2
		cOrdem := "%RA_FILIAL,RA_CC,RA_MAT%"
	EndIf

	BEGIN REPORT QUERY oSection

		BeginSql alias cAlias  // "SRA"

		SELECT SRA.RA_FILIAL,  SRA.RA_CC,      SRA.RA_MAT,     SRA.RA_NOME,    SRF.RF_FILIAL,  SRF.RF_MAT,
			   SRA.RA_SITFOLH, SRA.RA_CATFUNC, SRA.RA_ADMISSA, MIN(SRF.RF_DATABAS) RF_DATABAS
		FROM %table:SRA% SRA
			LEFT JOIN %table:SRF% SRF
				ON	SRA.RA_FILIAL	= 	SRF.RF_FILIAL AND
					SRA.RA_MAT	=	SRF.RF_MAT
		WHERE	SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%) AND
			   	SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%) AND
			  	SRA.%notDel%   AND
			  	SRF.RF_STATUS = '1' AND SRF.%notDel%
		GROUP BY SRA.RA_FILIAL,  SRA.RA_CC,      SRA.RA_MAT,     SRA.RA_NOME,    SRF.RF_FILIAL,  SRF.RF_MAT,
				SRA.RA_SITFOLH, SRA.RA_CATFUNC, SRA.RA_ADMISSA
		ORDER BY %exp:cOrdem%
		EndSql
	/*
	Prepara relatorio para executar a query gerada pelo Embedded SQL passando como
	parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados
	pela funcao MakeSqlExpr para serem adicionados a query
	*/
	END REPORT QUERY oSection PARAM mv_par01, mv_par02, mv_par03


	FilAnt := Replicate("!", FWGETTAMFILIAL)
	dbSelectArea( cAlias )
	dbGotop()

	// Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter((cAlias)->( RecCount() ))

	cFilialSv := Space(FWGETTAMFILIAL)

	While (cAlias)->( !EOF() )

		// Retorna para a area principal do relatorio
		dbSelectArea( cAlias )

		// Verifica se o usuแrio cancelou a impressใo do relatorio
		If oReport:Cancel()
			Exit
		EndIf

		// Incrementa a r้gua da tela de processamento do relat๓rio
		oReport:IncMeter()

		If (cAlias)->RA_FILIAL # cFilialSv
			cFilialSv := (cAlias)->RA_FILIAL
		Endif

		// Testa Situacao do Funcionario na Folha
		If (cAlias)->RA_SITFOLH $ "D*E"
			dbSkip()
			Loop
		EndIf

		// Consiste controle de acessos e filiais validas
		If !((cAlias)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
			dbSelectArea( cAlias )
			dbSkip()
			Loop
		EndIf

		// Despreza Registros Conforme Situacao e Categoria Funcionarios
		If	!( (cAlias)->RA_SITFOLH $ cSituacao ) .Or. !( (cAlias)->RA_CATFUNC $ cCategoria )
			dbSkip()
			Loop
		EndIf

		SRA->(dbSeek( (cAlias)->(RA_FILIAL) + (cAlias)->(RA_MAT) ) )

		aPerFerias := {}
		Calc_Fer( @aPerFerias,dDataRef,,,,,,.F., (cAlias)->(RF_DATABAS) )

		For nFor := 1 to Len(aPerFerias)
			lTemNormal   := .T.
			lTemPendente := .T.

			If Month(aPerFerias[nFor][1]) <> Month(dDataRef) .Or.; //Inicio Database de Ferias
		       Year(aPerFerias[nFor][1]) >= Year(dDataRef)
				lTemNormal := .F.
			Endif

			If Month(aPerFerias[nFor][13]) <> Month(dDataRef) .Or.; //Data Inicia Vencido Pendente
		       Year(aPerFerias[nFor][13]) >= Year(dDataRef)
				lTemPendente := .F.
			Endif

			If !lTemNormal .And. !lTemPendente
				Loop
			EndIf

			DFIMPAQUI := 0
			DPRPAQUI  := 0
			nLimMax   := 0

			IF  LDOBRADA // SOMENTE FERIAS DOBRADASADMIN
					DFIMPAQUI := aPerFerias[nFor][1]
					DPRPAQUI  := fCalcFimAq(DFIMPAQUI+1)
					nLimMax	  := DPRPAQUI - nDiasMax
					if nLimMax + 365 > dDataRef
						Loop
					Endif
			EndIf

			nDiasFalta	:= 	aPerFerias[nFor][15] //Dias de Faltas Vencidas
			nDiasAntec	:= 	aPerFerias[nFor][14] //Dias de Ferias Antecipadas
			nDiasVenc   :=	aPerFerias[nFor][03] //Dias de ferias vencidas

			TabFaltas(@nDiasFalta)

			// "FIL C. CUSTO              MAT.   NOME                           DT. BASE FERIAS  DIAS FER.VENCIDAS  DIAS FALTAS  FER.ANTECIPADAS"
			//  99 99999999999999999999  999999 999999999999999999999999999999 99/99/9999                     999          999              999

			oSection:Init()
			oSection:Cell("RA_FILIAL"):Show()
			oSection:Cell("RA_CC"):Show()
			oSection:Cell("RA_MAT"):Show()
			oSection:Cell("RA_NOME"):Show()

			If lTemPendente
				oSection:Cell("RF_IVENPEN"):SetBlock({|| aPerFerias[nFor][12] }) //Data Inicia Vencido Pendente
				oSection:Cell("RF_DVENPEN"):SetBlock({|| aPerFerias[nFor][11] }) //Dias Vencidos Pendentes
				oSection:Cell("DI_FALTA"):SetBlock({|| 0})
				oSection:Cell("FE_ANTE"):SetBlock({|| 0})

				oSection:PrintLine()
			EndIf

			If lTemNormal
				If lTemPendente
					oSection:Cell("RA_FILIAL"):HIDE()
					oSection:Cell("RA_CC"):HIDE()
					oSection:Cell("RA_MAT"):HIDE()
					oSection:Cell("RA_NOME"):HIDE()
				EndIf

				nDiasVenc	:= (nDiasVenc - If(!lMetadeFal, If(!lTempoParc, nDiasFalta, 0), nDiasVenc / 2) - nDiasAntec)

				oSection:Cell("RF_IVENPEN"):SetBlock({|| PADR(DtoC(aPerFerias[nFor][1]),10) }) //Inicio Database de Ferias
				oSection:Cell("RF_DVENPEN"):SetBlock({|| If(nDiasVenc < 0,0,nDiasVenc) })
				oSection:Cell("DI_FALTA"):SetBlock({|| If( !lMetadefal, If(!lTempoParc, nDiasFalta, 0), nDiasVenc ) })
				oSection:Cell("FE_ANTE"):SetBlock({|| nDiasAntec })

				oSection:PrintLine()
			EndIf


		Next nFor

		( cAlias )->(dbSkip() )
	EndDo

	oSection:Finish()

Return Nil