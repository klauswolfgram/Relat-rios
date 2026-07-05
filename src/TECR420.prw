/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR420.CH"
#include "Protheus.ch"
#INCLUDE "REPORT.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR420"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TECR420  ³ Autor ³ Cleber Martinez       ³ Data ³09/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Relatorio de despesas financeiras ( service )              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³19/10/06  ³Tatiana        ³Alteração de SUBSTRING para SUBSTR          ³±±
±±³20/04/07  ³Conrado Q.     ³Alteração de SUBSTR para SUBSTRING          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TECR420()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³                                                          ³
//³ mv_par01            // Dt. Atendimento de ?              ³
//³ mv_par02            // Dt. Atendimento ate?              ³
//³ mv_par03            // Tecnico de ?                      ³
//³ mv_par04            // Tecnico ate?                      ³
//³ mv_par05            // Servico de ?                      ³
//³ mv_par06            // Servico ate?                      ³
//³ mv_par07            // OS Inicial ?                      ³
//³ mv_par08            // OS Final   ?                      ³
//³ mv_par09            // Quanto as OS? Todas / Encerradas  ³
//³ mv_par10            // Exibe ? Gerados/Pendentes/Todos   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("ATR420",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr420RptDef()

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr420RptDef ºAutor  ³Cleber Martinez     º Data ³  10/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR420 R4                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º   DATA   ³ Programador   ³Manutencao efetuada                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º15/05/07  ³Conrado Q.     ³- Bops 125280: Remoção da utilização da        º±±
±±º          ³               ³dDataCheg, durante a montagem do relatório.    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr420RptDef()
Local oReport			// Objeto do relatorio
Local oSection			// Objeto da secao pai
Local oSection1			// Objeto da secao 1
Local cAlias := GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR420" TITLE STR0001 PARAMETER "ATR420" ACTION {|oReport| Tcr420PrtRpt(oReport,cAlias) } DESCRIPTION STR0002 + STR0003
	    
	//Sessão Pai
	DEFINE SECTION oSection OF oReport TITLE STR0015 TABLES "AA1" BREAK HEADER //"Pendências do apontamento tecnico"
	       
	   	//Celulas secao Pai
	  	DEFINE CELL NAME "AA1_CODTEC"	OF oSection  	BLOCK {|| (cAlias) ->AB9_CODTEC }
	  	DEFINE CELL NAME "AA1_NOMTEC" 	OF oSection	BLOCK {|| POSICIONE("AA1",1,XFILIAL("AA1") + (cAlias)->AB9_CODTEC,"AA1_NOMTEC")} 
	  	DEFINE CELL NAME "A2_COD"		OF oSection 	BLOCK {|| POSICIONE("AA1",1,XFILIAL("AA1") + (cAlias)->AB9_CODTEC,"AA1_CODFOR")}
	 	DEFINE CELL NAME "A2_LOJA" 		OF oSection	BLOCK {|| POSICIONE("AA1",1,XFILIAL("AA1") + (cAlias)->AB9_CODTEC,"AA1_LOJFOR")}
	 	DEFINE CELL NAME "A2_NOME" 		OF oSection	BLOCK {|| U_GetNomeFor((cAlias) ->AB9_CODTEC)}
	
	//Sessao 2
	DEFINE SECTION oSection1 OF oSection TITLE "Despesas Financeiras" TABLES "ABC","AB9","AB6","SB1" BREAK HEADER LINE BREAK
		
		//Celulas secao 2
	   	DEFINE CELL NAME "ABC_NUMOS" 	OF oSection1 ALIAS "ABC" 
		DEFINE CELL NAME "ABC_SEQ"	 	OF oSection1 ALIAS "ABC"
		DEFINE CELL NAME "AB9_DTCHEG" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "B1_COD" 		OF oSection1 				BLOCK {|| POSICIONE("SB1",1, xFilial( "SB1" ) + (cAlias)->ABC_CODPRO,"B1_COD")} 
		DEFINE CELL NAME "B1_DESC"	 	OF oSection1 				BLOCK {|| POSICIONE("SB1",1, xFilial( "SB1" ) + (cAlias)->ABC_CODPRO,"B1_DESC")}  
		DEFINE CELL NAME "ABC_CODSER" 	OF oSection1 ALIAS "ABC" 
		DEFINE CELL NAME "ABC_QUANT" 	OF oSection1 ALIAS "ABC" PICTURE "@E 999,999,999.99"
		DEFINE CELL NAME "ABC_VLUNIT" 	OF oSection1 ALIAS "ABC" PICTURE "@E 999,999,999.99"
		DEFINE CELL NAME "ABC_VALOR" 	OF oSection1 ALIAS "ABC" PICTURE "@E 999,999,999.99"
		DEFINE CELL NAME "cSituacao" 	OF oSection1 TITLE "Situação" SIZE 10 BLOCK {|| IIF (!EMPTY((cAlias)->ABC_NUMERO),STR0011,STR0010)}
		
	//Totalizador
	DEFINE FUNCTION FROM oSection1:Cell("ABC_VALOR") OF oSection1 FUNCTION SUM TITLE "Valor da Quebra" //"Verba"
	If !isBlind()
		oReport:PrintDialog()
	EndIf
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr420PrtRptºAutor  ³Cleber Martinez     º Data ³  10/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR420 R4                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º   DATA   ³ Programador   ³Manutencao efetuada                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º15/05/07  ³Conrado Q.     ³- Bops 125280: Remoção da utilização da       º±±
±±º          ³               ³dDataCheg, durante a montagem do relatório e  º±±
±±º          ³               ³adição da data da despesa na variável aRegABC º±±   
±±º          ³               ³para que essa possa ser exibida no relatório. º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr420PrtRpt( oReport, cAlias )
Local oSection1 	:= oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 	:= oSection1:Section(1)				// Objeto secao 2 do relatorio 
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio
Local cWhere1	:= ""								// expressao a adicionar no WHERE 
Local cWhere2	:= ""								// expressao a adicionar no WHERE 
Local cAliasAB7   := ""
Local cAliasAB9   := ""
Local cAliasABC   := ""
Local cKey        := "" 
Local cQuery      := ""
Local lQuery      := .F.
Local aRegABC     := {} 
Local bBlock      := { || .T. } 
Local nLoop       := 0
Local nValor      := 0 
Local nValorQueb  := 0 
Local nValorTot   := 0 
Local nX          := 0
Local nTamAB7_NUMOS	:= TamSx3("AB7_NUMOS")[1]
Local nTamDe		:= nTamAB7_NUMOS+1
Local nTamAB7_ITEM	:= TamSx3("AB7_ITEM")[1]

If MV_PAR10 == 1 
	bBlock := { || ABC->ABC_NUMERO <> Space( Len( ABC->ABC_NUMERO) ) } 
ElseIf MV_PAR10 == 2
	bBlock := { || ABC->ABC_NUMERO == Space( Len( ABC->ABC_NUMERO) ) } 
Else	
	bBlock := { || .T. } 	
EndIf                               
                          

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecao dos registros validos para o processamento           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR420")

	If mv_par10 == 1
		cWhere1 := "% ABC.ABC_NUMERO <> '" + Space(Len(ABC->ABC_NUMERO)) + "' AND %"	
	ElseIf mv_par10 == 2
		cWhere1 := "% ABC.ABC_NUMERO = '" + Space(Len(ABC->ABC_NUMERO)) + "' AND %"
	Else
		cWhere1 := "%%"
	EndIf                               
		
	If MV_PAR09 <> 1 
		cWhere2 := "% AB7.AB7_TIPO NOT IN('1','3') AND %"
	Else
		cWhere2 := "%%"
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query da secao 1³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BeginSql alias cAlias
	    
			SELECT	AB9.AB9_FILIAL,		AB9.AB9_NUMOS,		AB9.AB9_CODTEC,		AB9.AB9_SEQ,	
					AB9.AB9_DTCHEG,		ABC.ABC_VALOR, 		ABC.R_E_C_N_O_  ABCRECNO, ABC.ABC_CODPRO,
					ABC.ABC_CODTEC,		ABC.ABC_CODSER,		ABC.ABC_NUMOS,		ABC.ABC_SEQ, ABC.ABC_NUMERO,
					ABC.ABC_VLUNIT,ABC.ABC_QUANT

			FROM %table:ABC% ABC, %table:AB9% AB9, %table:AB7% AB7
			WHERE	ABC.ABC_FILIAL = %xfilial:ABC%		AND
					ABC.ABC_CODSER >= %exp:mv_par05%	AND  
					ABC.ABC_CODSER <= %exp:mv_par06%	AND
					%exp:cWhere1%				
					ABC.%notDel%						AND
					AB9.AB9_FILIAL = %xfilial:AB9%		AND
					AB9.AB9_NUMOS =	ABC.ABC_NUMOS		AND
					AB9.AB9_CODTEC= ABC.ABC_CODTEC		AND
					AB9.AB9_SEQ	= ABC.ABC_SEQ 			AND 
					AB9.AB9_DTFIM >= %exp:DtoS(mv_par01)%	AND
					AB9.AB9_DTFIM <= %exp:DtoS(mv_par02)%	AND
					AB9.AB9_CODTEC >= %exp:mv_par03%		AND
					AB9.AB9_CODTEC <= %exp:mv_par04%		AND
					AB9.AB9_NUMOS >=  %exp:mv_par07%		AND
					AB9.AB9_NUMOS <=  %exp:mv_par08+"zz"%	AND
					AB9.%notDel%							   AND
					AB7.AB7_FILIAL = %xfilial:AB7%			AND
					AB7.AB7_NUMOS = SUBSTRING(AB9.AB9_NUMOS,1,6) AND 
					AB7.AB7_ITEM = SUBSTRING(AB9.AB9_NUMOS,7,2) AND
					%exp:cWhere2%
					AB7.%notDel%
	
				ORDER BY %ORDER:AB9%  

		EndSql
	
	END REPORT QUERY oSection1 

	oSection2:SetParentQuery()	
	oSection2:SetParentFilter({|cAtend| (cAlias)->ABC_CODTEC == cAtend},{|| (cAlias)->AB9_CODTEC })
	oSection1:Print()

#ELSE
	
	cArqInd := CriaTrab(,.F.)
	cQuery  := "AB9_FILIAL=='"+xFilial("AB9")+"'.AND."
	cQuery  += "DTOS(AB9_DTFIM)>='"+DTOS(MV_PAR01)+"'.AND."
	cQuery  += "DTOS(AB9_DTFIM)<='"+DTOS(MV_PAR02)+"'.AND."
	cQuery  += "AB9_CODTEC>='"+MV_PAR03+"'.AND."
	cQuery  += "AB9_CODTEC<='"+MV_PAR04+"'.AND."
	cQuery  += "AB9_NUMOS>='" +MV_PAR07+"'.AND."
	cQuery  += "AB9_NUMOS<='" +MV_PAR08+"zz'"
	
	AB9->( dbSetOrder( 1 ) ) 
	cKey := AB9->( IndexKey() )        
	
	cAliasAB9 := "AB9" 

	dbSelectArea("AB9")
	IndRegua("AB9",cArqInd,cKey,,cQuery)
	dbGotop()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa a impressao dos dados, de acordo com o filtro ou query³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SetMeter((cAliasAB9)->(LastRec()))
	dbSelectArea(cAliasAB9)      
	
	aRegABC := {}
	nValor  := 0 
	
	While ( !oReport:Cancel() .AND. !Eof() .AND. (cAliasAB9)->AB9_FILIAL == xFilial("AB9") )
	
		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
			
		If !lQuery
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona os itens                                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("AB7")
			dbSetOrder(1)
			MsSeek(xFilial("AB7")+AB9->AB9_NUMOS)
			If MV_PAR09 == 1 .OR. !AB7->AB7_TIPO$'1#3'
				dbSelectArea("ABC")
				dbSetOrder(1)
				MsSeek(xFilial("ABC")+AB9->AB9_NUMOS+AB9->AB9_CODTEC+AB9->AB9_SEQ)
				While !Eof() .AND. xFilial("ABC") == ABC->ABC_FILIAL .AND.;
						AB9->AB9_NUMOS == ABC->ABC_NUMOS .AND.;
						AB9->AB9_CODTEC == ABC->ABC_CODTEC .AND.;
						AB9->AB9_SEQ == ABC->ABC_SEQ
						
					If Eval( bBlock ) .AND. ABC->ABC_CODSER >= MV_PAR05 .AND. ABC->ABC_CODSER <= MV_PAR06
					
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Calcula o valor da despesa financeira                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						nValor += ABC->ABC_VALOR
						aAdd(aRegABC, {ABC->(RecNo()),AB9->AB9_DTCHEG})
						
					EndIf
					dbSelectArea("ABC")
					dbSkip()
				End
			EndIf
		EndIf                                  
		
		cQuebra   := (cAliasAB9)->AB9_CODTEC
		
		dbSelectArea(cAliasAB9)
		dbSkip()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica a quebra de Tecnico                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (cAliasAB9)->(Eof()) .OR. cQuebra <> (cAliasAB9)->AB9_CODTEC
				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Gerar titulo financeiro                                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nValor > 0
				dbSelectArea("AA1")
				dbSetOrder(1)
				If MsSeek(xFilial("AA1")+cQuebra) .AND. !Empty(AA1->AA1_CODFOR)
	
					oReport:SkipLine()
					oReport:PrintText( STR0007 + AA1->AA1_CODTEC + " - " + AA1->AA1_NOMTEC,,/*oSection1:Cell("ABC_NUMOS"):ColPos()*/ ) //"Tecnico    : "
	
					SA2->( dbSetOrder( 1 ) ) 
					If SA2->( MsSeek( xFilial( "SA2" ) + AA1->AA1_CODFOR + AA1->AA1_LOJFOR ) )
						oReport:PrintText( STR0008 + SA2->A2_COD + "/" + SA2->A2_LOJA + " - " + SA2->A2_NOME,,/*oSection1:Cell("ABC_NUMOS"):ColPos()*/ ) //"Fornecedor : "
					EndIf 					
					oReport:SkipLine()
						
					oSection1:Init()
					For nX := 1 To Len(aRegABC)
						
						ABC->(MsGoto(aRegABC[nX,1]))	
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Posiciona os itens                                           ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						AB6->( dbSetOrder( 1 ) )
						AB6->( MsSeek( xFilial( "AB6" ) + ABC->ABC_NUMOS ) )
						
						SB1->( dbSetOrder( 1 ) ) 
						If SB1->( MsSeek( xFilial( "SB1" ) + ABC->ABC_CODPRO ) ) 
							  
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Imprime a secao 1 ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							oSection1:Cell("AB9_DTCHEG"):SetValue(aRegABC[nX,2])
							oSection1:Cell("ABC_VALOR"):SetValue(ABC->ABC_VALOR)
							If Empty(ABC->ABC_NUMERO)
								oSection1:Cell("cSituacao"):SetValue(STR0010)	//"PENDENTE"
							Else
								oSection1:Cell("cSituacao"):SetValue(STR0011)  //"GERADO"
							EndIf
							oSection1:PrintLine()
						
						EndIf 	
						
						nValorQueb += xMoeda(ABC->ABC_VALOR,AB6->AB6_MOEDA,1)
						nValorTot  += xMoeda(ABC->ABC_VALOR,AB6->AB6_MOEDA,1)
							
					Next nX  
					oSection1:Finish()
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime totalizador da quebra ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oReport:SkipLine()
					oReport:PrintText( STR0012 + Transform( nValorQueb, "@E 99,999,999,999.99" ) )	//"Valor da quebra : "
					oReport:SkipLine()
					nValorQueb := 0 
				EndIf
			EndIf
			
			nValor	:= 0
			aRegABC	:= {}
		EndIf
	
	End
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o valor total                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty( nValorTot ) 
		oReport:SkipLine()	
		oReport:FatLine()
		oReport:PrintText( STR0013 + Transform( nValorTot, "@E 99,999,999,999.99" ) )	//"Valor total : "
	EndIf 

#ENDIF
    

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetNomeFor
Realiza a busca do nome do fornecedor

@author Serviços
@since 20/10/2014
@version 1.0
/*/
//-------------------------------------------------------------------

User Function GetNomeFor(cCodTec)
Local cNome	:= ""
Local aArea	:= GetArea()

DbSelectArea("AA1")
DbSetOrder(1)

If AA1->(MsSeek(xFilial("AA1")+cCodTec)) .AND. !Empty(AA1->AA1_CODFOR)
	DbSelectArea("SA2")
	DbSetOrder(1) 
	If SA2->( MsSeek( xFilial( "SA2" ) + AA1->AA1_CODFOR + AA1->AA1_LOJFOR ) )
		cNome := SA2->A2_NOME
	EndIf 	
EndIf

RestArea(aArea)

Return(cNome)

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

Return Tcr420RptDef()

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

Return Tcr420PrtRpt( oReport , GetNextAlias() )

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