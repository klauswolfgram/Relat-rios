/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR570.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

#INCLUDE "REPORT.CH"
Static cAutoPerg := "ATR570"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR570   ³ Autor ³ Kleber Dias Gomes     ³ Data ³ 17/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao do Histograma do Help-Desk.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Thiago H. ³07/07/06³99277 ³Desenvolvimento relatorio personalizavel R4 ³±±
±±³Cleber M. ³28/08/06³99277 ³Revisao do fonte e inclusao dos totalizado- ³±±
±±³          ³        ³      ³res por tempo.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TECR570()
Local oReport				// Objeto para geracao do relatorio
Local aArea := GetArea()	// Salva a area

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas como parametros                         ³
//³ mv_par01        //  Chamado De                               ³
//³ mv_par02        //  Sequencia De                             ³
//³ mv_par03        //  Chamado Ate                              ³
//³ mv_par04        //  Sequencia Ate                            ³
//³ mv_par05        //  Cliente De                               ³
//³ mv_par06        //  Loja De                                  ³
//³ mv_par07        //  Cliente Ate                              ³
//³ mv_par08        //  Loja Ate                                 ³
//³ mv_par09        //  Tecnico De                               ³
//³ mv_par10        //  Tecnico Ate                              ³
//³ mv_par11        //  Origem(1=Chamado;2=Redirecionamento;     |
//|                            3=Reminder;4=Agrega conhecimento) |
//³ mv_par12        //  Data Inicio                              ³
//³ mv_par13        //  Ocorrencia                               ³
//³ mv_par14        //  Situacao(1=Encerrado;2=Em Aberto)        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("ATR570",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TCR570RptDef()
oReport:PrintDialog()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a area³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea( aArea )
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TCR570RptDºAutor  ³Thiago Honorato     º Data ³  07/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no relaº±±
±±º          ³latorio                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGATEC                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º   DATA   ³ Programador   ³Manutencao efetuada                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º 28/08/06 ³ Cleber M.     ³Bops 99277: Inclusao de quebras e totais.   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TCR570RptDef()
Local oReport											// Objeto do relatorio
Local oSection1											// Objeto da secao 1	
Local oBreak											// Objeto de quebra da secao
Local oTotal											// Objeto totalizador
Local oMedia											// Objeto totalizador
Local cAlias1	:= "ABK"								// Pega o proximo Alias Disponivel
Local aSituacao	:= {STR0006,STR0007} 					//"ENCERRADO"###"EM ABERTO"
Local aOrigem	:= {STR0008,STR0009,STR0010,STR0011} 	//"CHAMADO"###"REDIRECIONAMENTO"###"REMINDER"###"AGREGA CONHECIMENTO"

#IFDEF TOP
	cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
#ENDIF	

DEFINE REPORT oReport NAME "TECR570" TITLE STR0001 PARAMETER "ATR570" ;
	ACTION {|oReport| TCR570PrtRpt(oReport, cAlias1)} ;
	DESCRIPTION STR0002 + STR0003 ;
	TOTAL TEXT STR0017 TOTAL IN COLUMN 	//"TOTAL GERAL"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definida a secao Principal               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0018 TABLES "ABK","SA1","AA1","AAG"  // "Cadastro de Clientes"
		DEFINE CELL NAME "ABK_CODCLI"	OF oSection1 ALIAS "ABK" 
		DEFINE CELL NAME "ABK_LOJA"		OF oSection1 ALIAS "ABK" 
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "ABK_NRCHAM" 	OF oSection1 ALIAS "ABK"
		DEFINE CELL NAME "ABK_SEQ" 		OF oSection1 ALIAS "ABK"
		DEFINE CELL NAME "AA1_CODTEC" 	OF oSection1 ALIAS "AA1"
		DEFINE CELL NAME "AA1_NOMTEC" 	OF oSection1 ALIAS "AA1"
		DEFINE CELL NAME "AAG_CODPRB" 	OF oSection1 ALIAS "AAG"
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection1 ALIAS "AAG"
		DEFINE CELL NAME "ABK_ORIGEM" 	OF oSection1 ALIAS "ABK" BLOCK {|| IIf(!Empty((cAlias1)->ABK_ORIGEM), aOrigem[Val((cAlias1)->ABK_ORIGEM)], "") }
		DEFINE CELL NAME "ABK_SITUAC" 	OF oSection1 ALIAS "ABK" BLOCK {|| aSituacao[Val((cAlias1)->ABK_SITUAC)] }	
		DEFINE CELL NAME "ABK_TEMPO" 	OF oSection1 ALIAS "ABK" 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Definicao de quebra por cliente ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE BREAK oBreak OF oSection1 WHEN oSection1:Cell("ABK_CODCLI") TITLE STR0014
				
		DEFINE FUNCTION oMedia FROM oSection1:Cell("ABK_TEMPO") FUNCTION TIMEAVERAGE BREAK oBreak TITLE STR0015 PICTURE "@R 99:99" NO END SECTION 
		DEFINE FUNCTION oTotal FROM oSection1:Cell("ABK_TEMPO") FUNCTION TIMESUM BREAK oBreak TITLE STR0016 PICTURE "@R 99:99" NO END SECTION 
		
		oSection1:SetHeaderPage(.T.)
		oTotal:ShowHeader()
		oMedia:ShowHeader()
		
Return oReport 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TCR570PrtRptºAutor  ³Thiago Honorato     º Data ³  07/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGATEC                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º   DATA   ³ Programador   ³Manutencao efetuada                        	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º 12/09/06 ³ Cleber M.     ³Bops 99277: Acerto no ORDER BY da query.    	º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TCR570PrtRpt(oReport, cAlias1)
Local cWhere1	:= "%%" 							// Expressao 1
Local cWhere2	:= "%%"								// Expressao 2
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local cFiltro	:= ""						      	// Define o filtro para DBF
Local cOrder	:= ""								// Ordem de impressao do relatorio

#IFDEF TOP
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("ABK")
	DbSetOrder(1)

	MakeSqlExpr("TECR570")
	
	cOrder := "% ABK_FILIAL,ABK_CODCLI,ABK_LOJA  %"
		
	If MV_PAR11 == 5
	    cWhere1 := "%%"
	Else
	    cWhere1 := "%ABK_ORIGEM ='" + AllTrim(Str(MV_PAR11)) +"' AND%"
	Endif
	
	If MV_PAR14 == 3
	    cWhere2 := "%%"
	Else
	    cWhere2 := "%ABK_SITUAC ='" + AllTrim(Str(MV_PAR14)) +"' AND%"
	Endif
	
	BEGIN REPORT QUERY oSection1
		BeginSql alias cAlias1
			SELECT	 ABK_NRCHAM,		ABK_SEQ   ,		ABK_ORIGEM,		ABK_TEMPO,	
					 ABK_SITUAC,		A1_COD    ,		A1_LOJA   ,		A1_NOME  ,	
					 AA1_CODTEC,		AA1_NOMTEC, 	AAG_CODPRB, 	AAG_DESCRI,
					 ABK_CODCLI,		ABK_LOJA
					 
			FROM %table:ABK% ABK,%table:SA1% SA1, %table:AA1% AA1, %table:AAG% AAG
			
			WHERE	ABK_FILIAL  = %xfilial:ABK%  	AND
				 	ABK_NRCHAM >= %exp:MV_PAR01% 	AND
				 	ABK_NRCHAM <= %exp:MV_PAR03% 	AND
					ABK_SEQ    >= %exp:MV_PAR02% 	AND
					ABK_SEQ	   <= %exp:MV_PAR04% 	AND
					ABK_CODCLI >= %exp:MV_PAR05% 	AND
					ABK_CODCLI <= %exp:MV_PAR07% 	AND
					ABK_LOJA   >= %exp:MV_PAR06% 	AND
					ABK_LOJA   <= %exp:MV_PAR08% 	AND
					ABK_CODTEC >= %exp:MV_PAR09% 	AND
					ABK_CODTEC <= %exp:MV_PAR10% 	AND
					%exp:cWhere1%                	
					ABK_CODPRB >= %exp:MV_PAR12% 	AND
					ABK_CODPRB <= %exp:MV_PAR13% 	AND
					%exp:cWhere2%                	
					A1_FILIAL   = %xfilial:SA1%  	AND
					A1_COD		= ABK_CODCLI     	AND
					A1_LOJA		= ABK_LOJA		 	AND
					AA1_FILIAL  = %xfilial:AA1%  	AND
					AA1_CODTEC	= ABK_CODTEC	 	AND
					AAG_FILIAL  = %xfilial:AAG%  	AND
					AAG_CODPRB	= ABK_CODPRB	 	AND 					
					ABK.%notDel%				 	AND				
					SA1.%notDel%				 	AND				
					AA1.%notDel%				 	AND				
					AAG.%notDel%				 	
			
			ORDER BY %exp:cOrder%

		EndSql
	END REPORT QUERY oSection1     
                            
#ELSE									
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR570")

	DbSelectArea("ABK")
	DbSetOrder(1)
	
	cOrder := "ABK_FILIAL+ABK_CODCLI+ABK_LOJA"
		
	cFiltro	:= "ABK_FILIAL=='"+xFilial("ABK")+"'"
	cFiltro	+= ".AND. ABK_NRCHAM>='"+MV_PAR01+"'"
	cFiltro	+= ".AND. ABK_NRCHAM<='"+MV_PAR03+"'"
	cFiltro	+= ".AND. ABK_SEQ>='"+MV_PAR02+"'"
	cFiltro	+= ".AND. ABK_SEQ<='"+MV_PAR04+"'"
	cFiltro	+= ".AND. ABK_CODCLI>='"+MV_PAR05+"'"
	cFiltro	+= ".AND. ABK_CODCLI<='"+MV_PAR07+"'"
	cFiltro	+= ".AND. ABK_LOJA>='"+MV_PAR06+"'"
	cFiltro	+= ".AND. ABK_LOJA<='"+MV_PAR08+"'"
	cFiltro	+= ".AND. ABK_CODTEC>='"+MV_PAR09+"'"
	cFiltro	+= ".AND. ABK_CODTEC<='"+MV_PAR10+"'"
	cFiltro	+= If(MV_PAR11==5,"",".AND. ABK_ORIGEM=='"+AllTrim(Str(MV_PAR11))+"'")
	cFiltro	+= ".AND. ABK_CODPRB>='"+MV_PAR12+"'"
	cFiltro	+= ".AND. ABK_CODPRB<='"+MV_PAR13+"'"
	cFiltro	+= If(MV_PAR14==3,"",".AND. ABK_SITUAC=='"+AllTrim(Str(MV_PAR14))+"'")	 
	
	oSection1:SetFilter( cFiltro, cOrder )	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona os itens                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1") + ABK->ABK_CODCLI + ABK->ABK_LOJA})
	TRPosition():New(oSection1,"AAG",1,{|| xFilial("AAG") + ABK->ABK_CODPRB})	
	TRPosition():New(oSection1,"AA1",1,{|| xFilial("AA1") + ABK->ABK_CODTEC})
   
#ENDIF	
If !isBlind()
	oSection1:Print()
EndIf
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

Return Tcr570RptDef()

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

Return Tcr570PrtRpt( oReport , GetNextAlias())

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