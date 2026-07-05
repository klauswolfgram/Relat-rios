/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR550.CH"
#INCLUDE "REPORT.CH"
Static cAutoPerg := "ATR550"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR550   ³ Autor ³ Eduardo Riera         ³ Data ³ 30.11.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Demonstrativo de Custos por OS.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Thiago H. ³14/07/06³99275 ³Desenvolvimento relatorio personalizavel R4 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TECR550()
Local oReport				// Objeto para geracao do relatorio
Local aArea := GetArea()	// Salva a area

Pergunte("ATR550",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TCR550RptDef()
oReport:PrintDialog()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a area³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea( aArea )
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³RetLayOut ³ Autor ³ Kleber Dias Gomes     ³ Data ³ 17/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o LayOut a ser impresso                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Array com o LayOut                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RetLayOut()

Local aLay := Array(11)

//
//								   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//						 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aLay[01] := 			"+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[02] :=	STR0013	//	"|                                  FICHA DE HELP DESK                        | Nr.Chamado: ########## Sequencia: ## | Folha: ######|"
aLay[03] := 			"+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[04] :=	STR0014 //	"|Cliente: ######/## - ########################################                                                        Estado:   ## |"
aLay[05] :=	STR0015 //	"|End.   : ######################################## Cidade: ############### Bairro: ######################### Tel.: ############### |"
aLay[06] :=	STR0016 //	"|Tecnico: ###### - ############################## Ocorrencia/Problema: ###### - ##############################                     |"
aLay[07] :=	STR0017	//	"|Origem : ################### Tempo de atendimento: ####:## Situacao: #########                                                    |"
aLay[08] :=				"+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[09] :=	STR0018 //	"|Laudo: ###########################################################################################################################|"
aLay[10] := 			"|       ###########################################################################################################################|"
aLay[11] := 			"+----------------------------------------------------------------------------------------------------------------------------------+"

Return(aLay)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TCR550RptDºAutor  ³Thiago Honorato     º Data ³  14/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no relaº±±
±±º          ³latorio                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGATEC                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TCR550RptDef()
Local oReport											// Objeto do relatorio
Local oSection1											// Objeto da secao 1	
Local oSection2											// Objeto da secao 2	
Local cAlias1	:= "ABK"								// Pega o proximo Alias Disponivel
Local aSituacao	:= {STR0006,STR0007} //"ENCERRADO"###"EM ABERTO"
Local aOrigem	:= {STR0008,STR0009,STR0010,STR0011} //"CHAMADO"###"REDIRECIONAMENTO"###"REMINDER"###"AGREGA CONHECIMENTO"

#IFDEF TOP
	cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
#ENDIF	

DEFINE REPORT oReport NAME "TECR550" TITLE STR0001 PARAMETER "ATR550" ACTION {|oReport| TCR550PrtRpt(oReport, cAlias1)} DESCRIPTION STR0002 + STR0003
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definido a sessao PAI                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0021 TABLES "ABK","SA1","AA1","AAG"    // "Ficha de Cadastro"
		
		oSection1:SetPageBreak()
		
		DEFINE CELL NAME "ABK_NRCHAM" 	OF oSection1 ALIAS "ABK"
		DEFINE CELL NAME "ABK_SEQ" 		OF oSection1 ALIAS "ABK"
		DEFINE CELL NAME "NOME"			OF oSection1 ALIAS "SA1" TITLE STR0020 		SIZE 30 BLOCK {|| SA1->A1_COD+"/"+SA1->A1_LOJA }	//Nome
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_EST" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_END" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_MUN" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_BAIRRO"	OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_TEL"		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "AA1_CODTEC" 	OF oSection1 ALIAS "AA1"
		DEFINE CELL NAME "AA1_NOMTEC" 	OF oSection1 ALIAS "AA1"
		DEFINE CELL NAME "AAG_CODPRB" 	OF oSection1 ALIAS "AAG"
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection1 ALIAS "AAG"
		DEFINE CELL NAME "ABK_ORIGEM" 	OF oSection1 ALIAS "ABK" 		BLOCK {|| aOrigem[Val((cAlias1)->ABK_ORIGEM)] }	
		DEFINE CELL NAME "ABK_TEMPO" 	OF oSection1 ALIAS "ABK"
		DEFINE CELL NAME "ABK_SITUAC" 	OF oSection1 ALIAS "ABK" 		BLOCK {|| aSituacao[Val((cAlias1)->ABK_SITUAC)] }	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definido a sessao FILHA                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	DEFINE SECTION oSection2 OF oSection1 TITLE STR0022 TABLES "ABK" 	// "Cadastro de Cliente"
		DEFINE CELL NAME "ABK_CODMEM" 	OF oSection2 ALIAS "ABK" SIZE 80 TITLE STR0019		BLOCK {|| MSMM((cAlias1)->ABK_CODMEM) } 
Return oReport 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TCR550PrtRptºAutor  ³Thiago Honorato     º Data ³  14/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGATEC                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TCR550PrtRpt(oReport, cAlias1)
Local oSection1 := oReport:Section(1)					// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)					// Define que a secao 2 sera filha da secao 1
Local cWhere1		:= "%%" 							//expressao 1
Local cWhere2		:= "%%"								//expressao 2

#IFDEF TOP
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("ABK")
	DbSetOrder(1)
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
	
	MakeSqlExpr("ATR550")
	
	BEGIN REPORT QUERY oSection1
	
		BeginSql alias cAlias1
			SELECT	 ABK_NRCHAM,		ABK_SEQ   ,		ABK_ORIGEM,		ABK_TEMPO ,		
					 ABK_SITUAC,		A1_COD    ,		A1_LOJA   ,		A1_NOME   ,		 
					 A1_EST    ,        A1_END    ,     A1_MUN    ,		A1_BAIRRO ,
					 A1_TEL    ,	 	AA1_CODTEC,		AA1_NOMTEC, 	AAG_CODPRB, 	
					 AAG_DESCRI, 		ABK_CODMEM
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
			ORDER BY %ORDER:ABK%
		EndSql
	END REPORT QUERY oSection1     
	
	If Val( ( cAlias1 )->ABK_ORIGEM ) == 0
		oSection1:Cell("ABK_ORIGEM"):Hide()
	Endif

	oSection2:SetParentQuery()			
	oSection2:SetParentFilter({|cParam| (cAlias1)->ABK_NRCHAM == cParam},{|| (cAlias1)->ABK_NRCHAM })

	oSection1:SetHeaderSection(.T.)		//Define que o header vai ser apresentado
#ELSE
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR550")
	
	DbSelectArea("ABK")
	DbSetOrder(1)

	cFiltro	:= "ABK_FILIAL ='"+xFilial("ABK")+"'"
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

	oSection1:SetFilter( cFiltro )	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona os itens                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1") + (cAlias1)->ABK_CODCLI + (cAlias1)->ABK_LOJA})
	TRPosition():New(oSection1,"AA1",1,{|| xFilial("AA1") + (cAlias1)->ABK_CODTEC})
	TRPosition():New(oSection1,"AAG",1,{|| xFilial("AAG") + (cAlias1)->ABK_CODPRB})
	
	oSection2:SetParentFilter({|cParam|  (cAlias1)->ABK_NRCHAM == cParam},{|| (cAlias1)->ABK_NRCHAM })
	oSection1:SetHeaderSection(.T.)		
	
#ENDIF	
oSection1:SetLineBreak()
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

Return Tcr550RptDef()

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

Return Tcr550PrtRpt( oReport , GetNextAlias())

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