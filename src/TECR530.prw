/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR530.CH"
#INCLUDE "REPORT.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR530"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR530   ³ Autor ³ Eduardo Riera         ³ Data ³ 26.11.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Histograma de Atendimento.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Thiago H. ³18/07/06³99273 ³Desenvolvimento relatorio personalizavel R4 ³±±
±±³Cleber M. ³24/08/06³99273 ³Revisao do Relatorio personalizavel (R4).   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TECR530()
Local oReport				// Objeto para geracao do relatorio
Local aArea := GetArea()	// Salva a area

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//³                                                                        ³
//³ MV_PAR01: Chamado de ?                                                 ³
//³ MV_PAR02: Chamado ate?                                                 ³
//³ MV_PAR03: Cliente de ?                                                 ³
//³ MV_PAR04: Cliente Ate?                                                 ³
//³ MV_PAR05: Dt.Chamado de?                                               ³
//³ MV_PAR06: Dt.Chamado ate?                                              ³
//³ MV_PAR07: Produto de ?                                                 ³
//³ MV_PAR08: Produto ate?                                                 ³
//³ MV_PAR09: Ocorrencia/Problema de ?                                     ³
//³ MV_PAR10: Ocorrencia/Problema ate?                                     ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("ATR530",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TCR530RptDef()
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
±±ºPrograma  ³TCR530RptDºAutor  ³Thiago Honorato     º Data ³  18/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no relaº±±
±±º          ³latorio                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGATEC                                                    º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cleber M. ³06/09/06³99273 ³Inclusao de headers nos totalizadors.       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TCR530RptDef()
Local oReport									// Objeto do relatorio
Local oSection1									// Objeto da secao 1	
Local oBreak									// Obj. de quebra da secao por cliente
Local oTotal									// Obj. totalizador de soma
Local oMedia									// Obj. totalizador de media
Local cAlias1	:= "AB2"						// Pega o proximo Alias Disponivel
Local nTotal	:= 0.00							// Total do tempo de atendimento

#IFDEF TOP
	cAlias1		:= GetNextAlias()				// Pega o proximo Alias Disponivel
#ENDIF	

DEFINE REPORT oReport NAME "TECR530" TITLE STR0001 PARAMETER "ATR530" ;
	ACTION {|oReport| TCR530PrtRpt(oReport, cAlias1)} ;
	DESCRIPTION STR0002 + STR0003 + STR0004 ;
	TOTAL TEXT STR0012 TOTAL IN COLUMN 	//"TOTAL GERAL"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao da sessao Principal            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0001 TABLES "AB2", "AB1", "AB3", "AB4", "AB6", "AB7", "SA1"
		oSection1:SetHeaderPage(.T.)
		oSection1:SetLineBreak()
		oSection1:SetTotalInLine(.F.)
		                                                        
		DEFINE CELL NAME "AB2_CODCLI" 	OF oSection1 ALIAS "AB2"
		DEFINE CELL NAME "AB2_LOJA" 	OF oSection1 ALIAS "AB2"
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "AB2_NRCHAM" 	OF oSection1 ALIAS "AB2"
		DEFINE CELL NAME "AB1_EMISSA"	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "AB1_HORAF"	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "AB2_BXDATA"	OF oSection1 ALIAS "AB2"
		DEFINE CELL NAME "AB2_BXHORA"	OF oSection1 ALIAS "AB2"
		DEFINE CELL NAME "AB2_TIPO"		OF oSection1 ALIAS "AB2"
		DEFINE CELL NAME "AB3_NUMORC"	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB3_EMISSA"	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB3_HORA"		OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB4_BXDATA"	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB4_BXHORA"	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB4_TIPO"		OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB6_NUMOS"	OF oSection1 ALIAS "AB6" BLOCK {|| TEC530Posic( 1, (cAlias1)->AB2_NUMOS, AB4->AB4_NUMOS ) } 
		DEFINE CELL NAME "AB6_EMISSA"	OF oSection1 ALIAS "AB6" BLOCK {|| TEC530Posic( 2, (cAlias1)->AB2_NUMOS, AB4->AB4_NUMOS ) }
		DEFINE CELL NAME "AB6_HORA"		OF oSection1 ALIAS "AB6" BLOCK {|| TEC530Posic( 3, (cAlias1)->AB2_NUMOS, AB4->AB4_NUMOS ) }
		DEFINE CELL NAME "dDtFim"		OF oSection1 ALIAS " "	TITLE STR0014 BLOCK {|| TEC530DatHora( 1, cAlias1 ) }	//"Data Direcionado"
		DEFINE CELL NAME "cHrFim"		OF oSection1 ALIAS " "	TITLE STR0015 BLOCK {|| TEC530DatHora( 2, cAlias1 ) }	//"Hora Direcionado"
		DEFINE CELL NAME "AB7_TIPO"		OF oSection1 ALIAS "AB7" BLOCK {|| TEC530Posic( 4, (cAlias1)->AB2_NUMOS, AB4->AB4_NUMOS ) }
		DEFINE CELL NAME "nTotal"		OF oSection1 ALIAS " " TITLE STR0016 PICTURE TM(nTotal,12,2) ;	//"Tempo de Atend.(HS)"
		BLOCK {|| TEC530Total(cAlias1,oSection1) }
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Definicao de quebra por cliente ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE BREAK oBreak OF oSection1 WHEN oSection1:Cell("AB2_CODCLI") TITLE STR0010 
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Definicao das funcoes de totalizacao e media ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE FUNCTION oTotal FROM oSection1:Cell("nTotal") FUNCTION SUM 	BREAK oBreak	TITLE Substr(STR0010,1,5) NO END SECTION 
		DEFINE FUNCTION oMedia FROM oSection1:Cell("nTotal") FUNCTION AVERAGE BREAK oBreak	TITLE Substr(STR0011,1,5) NO END SECTION 
        
		oTotal:ShowHeader()
		oMedia:ShowHeader()
		        
Return oReport 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TCR530PrtRptºAutor  ³Thiago Honorato     º Data ³  18/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGATEC                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TCR530PrtRpt(oReport, cAlias1)
Local oSection1 := oReport:Section(1)			// Define a secao 1 do relatorio
Local cFiltro   := ""							// Filtro
Local cOrder	:= ""							// Ordem de impressao do relatorio

#IFDEF TOP
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("AB2")
	DbSetOrder(1)
	
	MakeSqlExpr("ATR530")
	
	cOrder := "% AB2_FILIAL,AB2_CODCLI,AB2_LOJA %"
	
	BEGIN REPORT QUERY oSection1
	
	BeginSql alias cAlias1
		SELECT	 AB2_NRCHAM,	AB2_CODCLI,		AB2_LOJA,		AB2_NUMORC,	
				 AB2_BXDATA,	AB2_BXHORA,     AB2_TIPO,		AB2_NUMOS
				 					 
		FROM %table:AB2% AB2
		
		WHERE	AB2_FILIAL			= 	%xfilial:AB2%  			AND
				AB2_NRCHAM			>=	%exp:MV_PAR01%  		AND
				AB2_NRCHAM			<=	%exp:MV_PAR02%  		AND	
				AB2_CODCLI			>=	%exp:MV_PAR03%  		AND
				AB2_CODCLI			<=	%exp:MV_PAR04%  		AND
				AB2_EMISSA			>=	%exp:DTOS(MV_PAR05)%  	AND
				AB2_EMISSA			<=	%exp:DTOS(MV_PAR06)%  	AND
				AB2_CODPRO			>=	%exp:MV_PAR07%  		AND
				AB2_CODPRO			<=	%exp:MV_PAR08%  		AND
				AB2_CODPRB			>=	%exp:MV_PAR09%  		AND
				AB2_CODPRB			<=	%exp:MV_PAR10%  		AND
				AB2.%notDel%
		
		ORDER BY %exp:cOrder%
	EndSql
		
	END REPORT QUERY oSection1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicionando nas tabelas 						  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1") + (cAlias1)->AB2_CODCLI+(cAlias1)->AB2_LOJA }) 
	TRPosition():New(oSection1,"AB1",1,{|| xFilial("AB1") + (cAlias1)->AB2_NRCHAM } )  
	TRPosition():New(oSection1,"AB4",1,{|| xFilial("AB4") + (cAlias1)->AB2_NUMORC } )  
	TRPosition():New(oSection1,"AB3",1,{|| xFilial("AB3") + AB4->AB4_NUMORC } )  
    
#ELSE
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR530")
	
	cOrder := "AB2_FILIAL+AB2_CODCLI+AB2_LOJA"
	
	DbSelectArea(cAlias1)
	DbSetOrder(1)
	
	cFiltro	:= " AB2_FILIAL 			=	'"+xFilial("AB2")+"'"
	cFiltro += " .AND. AB2_NRCHAM		>=	'"+MV_PAR01+"'"
	cFiltro += " .AND. AB2_NRCHAM		<=	'"+MV_PAR02+"'"	
	cFiltro += " .AND. AB2_CODCLI		>=	'"+MV_PAR03+"'"
	cFiltro += " .AND. AB2_CODCLI		<=	'"+MV_PAR04+"'"
	cFiltro += " .AND. DTOS(AB2_EMISSA)	>=	'"+DTOS(MV_PAR05)+"'"
	cFiltro += " .AND. DTOS(AB2_EMISSA)	<=	'"+DTOS(MV_PAR06)+"'"
	cFiltro += " .AND. AB2_CODPRO		>=	'"+MV_PAR07+"'"
	cFiltro += " .AND. AB2_CODPRO		<=	'"+MV_PAR08+"'"
	cFiltro += " .AND. AB2_CODPRB		>=	'"+MV_PAR09+"'"
	cFiltro += " .AND. AB2_CODPRB		<=	'"+MV_PAR10+"'"

	oSection1:SetFilter( cFiltro, cOrder )	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicionando nas tabelas 						  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1") + (cAlias1)->AB2_CODCLI+(cAlias1)->AB2_LOJA }) 
	TRPosition():New(oSection1,"AB1",1,{|| xFilial("AB1") + (cAlias1)->AB2_NRCHAM } ) 
	TRPosition():New(oSection1,"AB4",1,{|| xFilial("AB4") + (cAlias1)->AB2_NUMORC } ) 
	TRPosition():New(oSection1,"AB3",1,{|| xFilial("AB3") + AB4->AB4_NUMORC } )

#ENDIF
If !isBlind()
	oSection1:Print()
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TEC530PosicºAutor  ³Thiago Honorato     º Data ³  18/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Posiciona nas tabelas auxiliares	                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR530 R4                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ExpN1 - Nr. do campo a retornar                             º±±
±±º          ³ExpC2 - Numero da Ordem de Servico                          º±±
±±º          ³ExpC3 - Numero da Ordem de Serv. no Orcamento (AB4)         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ExpC1 - Conteudo do campo desejado                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAnalista  ³ Data   ³Bops  ³Manutencao Efetuada                      	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºCleber M. ³25/08/06³99273 ³Revisao da funcao.                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TEC530Posic( nControle, cAB2NUMOS, cAB4NUMOS )

If ( !Empty(cAB2NUMOS) )
	DbSelectArea("AB7")
	DbSetOrder(1)
	MsSeek(xFilial("AB7") + cAB2NUMOS)
Else
	DbSelectArea("AB7")
	DbSetOrder(1)
	MsSeek(xFilial("AB7") + cAB4NUMOS)
EndIf

DbSelectArea("AB6")
DbSetOrder(1)
MsSeek(xFilial("AB6") + AB7->AB7_NUMOS)        

Do Case
	Case ( nControle == 1 )
		Return AB6->AB6_NUMOS
	Case ( nControle == 2 ) 
		Return AB6->AB6_EMISSA
	Case ( nControle == 3 ) 
		Return AB6->AB6_HORA
	Case ( nControle == 4 ) 
		Return SubStr(X3Combo("AB7_TIPO",AB7->AB7_TIPO),1,10)
EndCase

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TEC530DatHoraºAutor  ³Thiago Honorato     º Data ³  18/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Busca a data e a hora final do Atendimento	              	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR530 R4                                                 	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ExpN1 - Numero do campo a retornar                          	º±±
±±º          ³ExpC2 - Alias da tabela principal do relatorio              	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ExpC  - Data ou Hora Final                                  	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAnalista  ³ Data   ³Bops  ³Manutencao Efetuada                      	  	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºCleber M. ³25/08/06³99273 ³Revisao da funcao.                          	º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TEC530DatHora( nControle, cAlias1 )
Local dDtFim := (cAlias1)->AB2_BXDATA	//Data final
Local cHrFim := (cAlias1)->AB2_BXHORA	//Hora final

dbSelectArea("AB4")
dbSetOrder(1)
MsSeek(xFilial("AB4")+(cAlias1)->AB2_NUMORC)

dbSelectArea("AB3")
dbSetOrder(1)
If ( MsSeek(xFilial("AB3")+AB4->AB4_NUMORC) )
	dDtFim := AB4->AB4_BXDATA
	cHrFim := AB4->AB4_BXHORA
EndIf

If ( !Empty((cAlias1)->AB2_NUMOS) )
	dbSelectArea("AB7")
	dbSetOrder(1)
	MsSeek(xFilial("AB7")+(cAlias1)->AB2_NUMOS)
Else
	dbSelectArea("AB7")
	dbSetOrder(1)
	MsSeek(xFilial("AB7")+AB4->AB4_NUMOS)
EndIf

If ( AB7->( Found() ) )
	dDtFim := Ctod("")
	cHrFim := ""
	dbSelectArea("AB9")
	dbSetOrder(1)
	MsSeek(xFilial("AB9")+AB7->AB7_NUMOS+AB7->AB7_ITEM)

	While ( !Eof() .And. xFilial("AB9") == AB9->AB9_FILIAL .And.;
					AB7->AB7_NUMOS+AB7->AB7_ITEM == AB9->AB9_NUMOS )
					
		If ( AB9->AB9_TIPO=="1" )
			dDtFim := AB9->AB9_DTFIM
			cHrFim := AB9->AB9_HRFIM
		EndIf
		dbSelectArea("AB9")
		dbSkip()
	End
Else
	dbSelectArea("AB7")
	dbGoto(LastRec())
	dbSkip()
EndIf
        
If nControle == 1
	Return dDtFim
ElseIf nControle == 2
	Return cHrFim
EndIf

Return
      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TEC530Total ºAutor  ³Cleber Martinez     º Data ³  18/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Busca o total de horas gastas no Chamado Tecnico          	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGATEC                                                    	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ExpC1 - Alias da tabela principal do relat. (AB2)           	º±±
±±º          ³ExpC2 - Obj. da secao1                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ExpN1 - Valor total na Ordem de Servico                     	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAnalista  ³ Data   ³Bops  ³Manutencao Efetuada                      	  	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³        ³      ³                                            	º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TEC530Total(cAlias1, oSection1)
Local nTotal:= 0										//Total a retornar
Local dData	:= oSection1:Cell("dDtFim"):GetValue(.T.)	//Data final impressa
Local cHora	:= oSection1:Cell("cHrFim"):GetValue(.T.)	//Hora final impressa

nTotal := SubtHoras(AB1->AB1_EMISSA,AB1->AB1_HORAF,If(Empty(dData),dDataBase,dData),If(Empty(cHora),Time(),cHora))

Return nTotal

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

Return Tcr530RptDef()

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

Return Tcr530PrtRpt( oReport , GetNextAlias())

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