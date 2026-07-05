/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR520.CH"
#include "REPORT.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR520"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR520   ³ Autor ³ Eduardo Riera         ³ Data ³ 24.11.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Acompanhamento do Atendimento da OS            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 23/08/06 ³ Cleber M.     ³Bops 99272: Conversao para relatorio perso- ³±±
±±³          ³               ³nalizavel (Release 4).                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR520()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//³                                                                        ³
//³ MV_PAR01: Nr.Os de   ?                                                 ³
//³ MV_PAR02: Nr.Os ate  ?                                                 ³
//³ MV_PAR03: Cliente de ?                                                 ³
//³ MV_PAR04: Cliente ate?                                                 ³
//³ MV_PAR05: Data    de ?                                                 ³
//³ MV_PAR06: Data   ate ?                                                 ³
//³ MV_PAR07: Alocados/Nao Alocados/Ambos			                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("ATR520",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr520RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return	


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr520RptDef ºAutor  ³Cleber Martinez     º Data ³  23/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³TECR520 R4                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr520RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local cAlias1	:= ""	// Pega o proximo Alias Disponivel

#IFDEF TOP
	cAlias1	:= GetNextAlias()
#ELSE
	cAlias1	:= "AB7"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR520" TITLE STR0001 PARAMETER "ATR520" ACTION {|oReport| Tcr520PrtRpt(oReport, cAlias1)} DESCRIPTION STR0002 + STR0003 + STR0004

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0010 TABLES "AB7","SA1","AB2","AB1" // "Ordem de serviço"
		oSection1:SetHeaderPage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE CELL NAME "AB7_NUMOS" 	OF oSection1 ALIAS "AB7" 
		DEFINE CELL NAME "AB7_ITEM" 	OF oSection1 ALIAS "AB7" 
		DEFINE CELL NAME "AB7_CODCLI" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_LOJA" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1" 
		DEFINE CELL NAME "AB2_NRCHAM" 	OF oSection1 ALIAS "AB2" 
		DEFINE CELL NAME "AB1_EMISSA" 	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "AB1_HORAF" 	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "AB1_CONTAT" 	OF oSection1 ALIAS "AB1"
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0011 TABLE "ABB" // "Agenda do técnico"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "ABB_CODTEC" 	OF oSection2 ALIAS "ABB"
			DEFINE CELL NAME "ABB_DTINI" 	OF oSection2 ALIAS "ABB"
			DEFINE CELL NAME "ABB_HRINI" 	OF oSection2 ALIAS "ABB"
			DEFINE CELL NAME "ABB_HRTOT" 	OF oSection2 ALIAS "ABB"

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define margem esquerda para a secao2 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oSection2:SetLeftMargin(08)
            
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr520PrtRptºAutor  ³Cleber Martinez     º Data ³  24/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±³          ³cAlias1: Alias da tabela principal do relatorio             	³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR520 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr520PrtRpt( oReport, cAlias1 )
Local oSection1 := oReport:Section(1)			// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)			// Define que a secao 2 sera filha da secao 1
Local cOrder	:= ""							// Ordem de impressao		
Local cFiltro	:= ""							// Filtro para DBF

#IFDEF TOP

	DbSelectArea("AB7")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR520")

	cOrder := "% AB7_FILIAL,AB7_CODCLI,AB7_LOJA,AB7_EMISSA %"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB7_NUMOS,	AB7_ITEM,	AB7_CODCLI,	AB7_LOJA,
				AB7_NUMORC,	AB7_NRCHAM
				
		FROM %table:AB7% AB7
		
		WHERE	AB7_FILIAL = %xfilial:AB7%		AND
				AB7_NUMOS >= %exp:mv_par01%		AND  
				AB7_NUMOS <= %exp:mv_par02%		AND
				AB7_CODCLI >= %exp:mv_par03%	AND  
				AB7_CODCLI <= %exp:mv_par04%	AND  
				AB7_EMISSA >= %exp:Dtos(mv_par05)%	AND  
				AB7_EMISSA <= %exp:Dtos(mv_par06)%	AND  
				AB7.%notDel%
				
		ORDER BY %exp:cOrder%
				
	EndSql
	
	END REPORT QUERY oSection1 	
	
#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR520")

	DbSelectArea( cAlias1 ) 
	DbSetOrder(1)

	cOrder := "AB7_FILIAL+AB7_CODCLI+AB7_LOJA+DTOS(AB7_EMISSA)"

	cFiltro := "AB7_FILIAL=='"+xFilial("AB7")+"'.AND."
	cFiltro += "AB7_NUMOS>='"+MV_PAR01+"'.AND."
	cFiltro += "AB7_NUMOS<='"+MV_PAR02+"'.AND."
	cFiltro += "AB7_CODCLI>='"+MV_PAR03+"'.AND."
	cFiltro += "AB7_CODCLI<='"+MV_PAR04+"'.AND."
	cFiltro += "DTOS(AB7_EMISSA)>='"+DTOS(MV_PAR05)+"'.AND."
	cFiltro += "DTOS(AB7_EMISSA)<='"+DTOS(MV_PAR06)+"'"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua o filtro de acordo com a expressao do arquivo AB7 (Itens da Ordem de Servico)					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, cOrder )	

#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAlias1)->(LastRec()))
DbSelectArea(cAlias1)

While !oReport:Cancel() .AND. !(cAlias1)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf

	If ( Empty((cAlias1)->AB7_NRCHAM) )
    	dbSelectArea("AB4")
		dbSetOrder(1)
		dbSeek(xFilial("AB4")+(cAlias1)->AB7_NUMORC)
		
		dbSelectArea("AB2")
		dbSetOrder(1)
		dbSeek(xFilial("AB2")+AB4->AB4_NRCHAM)
	Else
		dbSelectArea("AB2")
		dbSetOrder(1)
		dbSeek(xFilial("AB2")+(cAlias1)->AB7_NRCHAM)
	EndIf
	
	dbSelectArea("AB1")
	dbSetOrder(1)
	dbSeek(xFilial("AB1")+AB2->AB2_NRCHAM)
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+(cAlias1)->AB7_CODCLI)
	
	dbSelectArea("ABB")
	dbSetOrder(3)
	dbSeek(xFilial("ABB")+(cAlias1)->AB7_NUMOS)
	
	If !isBlind()
		oSection1:Init()
	EndIf
	
	If  (ABB->(Found()) .And. MV_PAR07 == 1) .Or.;
		(!(ABB->(Found())) .And. MV_PAR07 == 2 ) .Or.;
		(MV_PAR07 == 3)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao 1 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !isBlind()			
			oSection1:PrintLine()
	      		
	       oSection2:Init()
       EndIf
		While ( !ABB->(Eof()) .AND. xFilial("ABB") == ABB->ABB_FILIAL .AND.;
									(cAlias1)->AB7_NUMOS == ABB->ABB_NUMOS )
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a secao 2 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !isBlind()
				oSection2:PrintLine()
			EndIf
			dbSelectArea("ABB")
			dbSkip()
		End
		oSection2:Finish()
		
	EndIf
	oSection1:Finish()
	
	dbSelectArea(cAlias1)
	dbSkip()
End

Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Monta as definiçoes do relatorio.
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()

Return Tcr520RptDef()

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Chama a função ReportPrint
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport ( oReport )

Return Tcr520PrtRpt( oReport , GetNextAlias())

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg