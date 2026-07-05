/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "REPORT.CH"
#INCLUDE "TMKR020.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Tmkr020  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 17/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio  Lista de Contatos                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_TMKR020(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Relatorio Personalizavel									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Danilo Ca.³30/06/06³99191 ³Desenvolvimento relatorio personalizavel R4.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TMKR020()
Local oReport				// Objeto para geracao do relatorio
Local aArea := GetArea()	// Salva a area

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ Mv_Par01           // Entidade                               ³
//³ Mv_Par02           // Do Contato                             ³
//³ Mv_Par03           // Ate o Contato                          ³
//³ Mv_Par04           // Status do Contato - Atualizado,Nao,Ambs³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK020",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
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
±±ºPrograma  ³Report Def DºAutor  ³Danilo Calil        º Data ³  30/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no relaº±±
±±º          ³latorio                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport											// Objeto do relatorio
Local oSection1											// Objeto da secao 1	
Local oSection2											// Objeto da secao 2
Local cAlias1		:= "SU6"								// Pega o proximo Alias Disponivel
Local aU4_TipoTel	:= TkSx3Box("U4_TIPOTEL")			// Busca no DD SX3 as opcoes para o campo
Local aU4_TipoEnd	:= TkSx3Box("U4_TIPOEND")			// Busca no DD SX3 as opcoes para o campo
Local aU4_Label	:= TkSx3Box("U4_LABEL")				// Busca no DD SX3 as opcoes para o campo
Local aU4_Forma	:= TkSx3Box("U4_FORMA")				// Busca no DD SX3 as opcoes para o campo
Local aU4_Tipo	:= TkSx3Box("U4_TIPO")				// Busca no DD SX3 as opcoes para o campo
Local aU6_Origem	:= TkSx3Box("U6_ORIGEM")			// Busca no DD SX3 as opcoes para o campo
Local aU6_Status	:= TkSx3Box("U6_STATUS")			// Busca no DD SX3 as opcoes para o campo
Local oBreak
Local lCRMA530		:= Funname() == "CRMA530"

#IFDEF TOP
	cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
#ENDIF	

// "Lista de Contatos"
// "Este programa ira emitir a selecäo da Lista de Contatos que sera trabalhada na agenda do operador."
// "Os dados serão apresentados conforme os parametros especificados pelo usuário do sistema."
// "As listas mostradas neste relatorio estäo separadas e totalizadas por data de execucäo."
DEFINE REPORT oReport NAME "TMKR020" TITLE STR0001 PARAMETER "TMK020" ACTION {|oReport| TKR020PrtRpt(oReport, cAlias1)} DESCRIPTION STR0002 + STR0003 + STR0004

DEFINE SECTION oSection1 	OF oReport TITLE STR0028 TABLES "SU4" // "Data de execução"

DEFINE CELL NAME "U4_DATA" 	OF oSection1 ALIAS "SU4" 

DEFINE SECTION oSection2 		OF oSection1 TITLE STR0029 TABLES "SU4" // "Lista de contatos"
If !lCRMA530
	DEFINE CELL NAME "U4_OPERAD"	OF oSection2 ALIAS "SU4" SIZE TamSX3("U4_OPERAD")[1]+9
Else
	DEFINE CELL NAME "U4_HORA1"	OF oSection2 ALIAS "SU4" SIZE TamSX3("U4_HORA1")[1]+3
EndIf
DEFINE CELL NAME "U4_LISTA"		OF oSection2 ALIAS "SU4" SIZE TamSX3("U4_LISTA")[1]+5
DEFINE CELL NAME "U4_DESC"	 	OF oSection2 ALIAS "SU4" 
DEFINE CELL NAME "U4_TIPO" 		OF oSection2 ALIAS "SU4" BLOCK {|| PadR(IIF(!Empty(SU4->U4_TIPO),aU4_Tipo[Val(SU4->U4_TIPO)],""),45)} 
If !lCRMA530
	DEFINE CELL NAME "U4_FORMA"		OF oSection2 ALIAS "SU4" BLOCK {|| PadR(IIF(!Empty(SU4->U4_FORMA),aU4_Forma[Val(SU4->U4_FORMA)],""),45)} 
EndIf
DEFINE CELL NAME "U4_TELE" 		OF oSection2 ALIAS "SU4" SIZE TamSX3( "U4_TELE" )[1] + 20   
If !lCRMA530
	DEFINE CELL NAME "U4_CONFIG"	OF oSection2 ALIAS "SU4" SIZE TamSX3( "U4_CONFIG" )[1] + 7
	DEFINE CELL NAME "U4_TIPOTEL"	OF oSection2 ALIAS "SU4" BLOCK {|| PadR(IIF(!Empty(SU4->U4_TIPOTEL),aU4_TipoTel[Val(SU4->U4_TIPOTEL)],""),45)} 
	DEFINE CELL NAME "U4_MALADIR"	OF oSection2 ALIAS "SU4" 
	DEFINE CELL NAME "U4_TIPOEND"	OF oSection2 ALIAS "SU4" BLOCK {|| PadR(IIF(!Empty(SU4->U4_TIPOEND),aU4_TipoEnd[Val(SU4->U4_TIPOEND)],""),45)} 
	DEFINE CELL NAME "U4_LABEL" 	OF oSection2 ALIAS "SU4" BLOCK {|| PadR(IIF(!Empty(SU4->U4_LABEL),aU4_Label[Val(SU4->U4_LABEL)],""),45)} 
	DEFINE CELL NAME "U4_ETIQUET" 	OF oSection2 ALIAS "SU4"  
EndIf
DEFINE CELL NAME "U4_CODCAMP" 	OF oSection2 ALIAS "SU4" 
DEFINE CELL NAME "U4_SCRIPT" 	OF oSection2 ALIAS "SU4" 
If !lCRMA530
	DEFINE CELL NAME "U4_EVENTO" 	OF oSection2 ALIAS "SU4" 
Else
	DEFINE CELL NAME "U4_ORIGEM" 	OF oSection2 ALIAS "SU4"
	DEFINE CELL NAME "U4_CUSTO" 	OF oSection2 ALIAS "SU4" 
	DEFINE CELL NAME "U4_DTUPD" 	OF oSection2 ALIAS "SU4" 
	DEFINE CELL NAME "U4_DTUTIL" 	OF oSection2 ALIAS "SU4" 
EndIf

DEFINE SECTION oSection3 		OF oSection2 TITLE STR0030 TABLES "SU6","SU5" // "Itens da lista de contato"

If !lCRMA530
	DEFINE CELL NAME "U6_CONTATO" 	OF oSection3 ALIAS "SU6" 
	DEFINE CELL NAME "U5_CONTAT"	OF oSection3 ALIAS "SU5"
	DEFINE CELL NAME "U6_ENTIDA" 	OF oSection3 ALIAS "SU6" BLOCK {|| PadR(TkEntidade((cAlias1)->U6_ENTIDA,(cAlias1)->U6_CODENT,1),30)}
Else
	DEFINE CELL NAME "U6_ENTIDA" 	OF oSection3 ALIAS "SU6" BLOCK {|| PadR(Posicione("SX2",1,(cAlias1)->U6_ENTIDA,"X2NOME()"),10)}
EndIf
	 
If !lCRMA530	
	DEFINE CELL NAME "U5_FONE"		OF oSection3 ALIAS "SU5"
Else
	DEFINE CELL NAME "U6_CODENT"	OF oSection3 ALIAS "SU6" 
	DEFINE CELL NAME "U6_DESCENT"	OF oSection3 ALIAS "SU6" BLOCK {|| PadR(TkEntidade((cAlias1)->U6_ENTIDA,(cAlias1)->U6_CODENT,1),30)} 
EndIf
DEFINE CELL NAME "U6_DATA" 		OF oSection3 ALIAS "SU6" 
DEFINE CELL NAME "U6_HRINI"		OF oSection3 ALIAS "SU6" 
DEFINE CELL NAME "U6_HRFIM"		OF oSection3 ALIAS "SU6" 
DEFINE CELL NAME "U6_STATUS"	OF oSection3 ALIAS "SU6" BLOCK {|| PadR(IIF(!Empty((cAlias1)->U6_STATUS),aU6_Status[Val((cAlias1)->U6_STATUS)],""),13)} 

DEFINE BREAK oBreak OF oSection1 WHEN oSection3:Cell("U6_DATA")
oBreak:SetTotalInLine(.T.)		// Imprime total em linha ou coluna (default .T. - linha )

oSection2:SetLineBreak(.T.)


//"T O T A L  G E R A L  D E   L I G A C O E S  NO DIA"	 		
DEFINE FUNCTION FROM oSection3:Cell("U6_DATA") FUNCTION COUNT BREAK oBreak NO END SECTION NO END REPORT TITLE STR0027 
//"T O T A L  G E R A L  D E   L I G A C O E S  ---->"	 		
DEFINE FUNCTION FROM oSection3:Cell("U6_DATA") FUNCTION COUNT  NO END SECTION TITLE STR0009 

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKR020PrtºAutor  ³Danilo Calil        º Data ³  10/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TKR020PrtRpt(oReport, cAlias1)
Local cQuery		:= "%%"								// Primeira Query
Local cQuery1		:= "%%"								// Segunda Query
Local cQuery2		:= "%%"								// Primeira Query
Local cQuery3		:= "%%"								// Segunda Query
Local oSection1		:= oReport:Section(1)		   		// Define a secao 1 do relatorio
Local oSection2		:= oSection1:Section(1)				// Define que a secao 2 serah filha da secao 1
Local oSection3     := oSection2:Section(1)				// Define que a secao 3 serah filha da secao 1
Local cFiltro		:= ""								// Filtro para DBF
	
DbSelectArea("SU4")
DbSetOrder(3)

#IFDEF TOP

	If Funname() == "CRMA530"
		If !Empty(Mv_Par04)
			cQuery1 := "%SU4.U4_LISTA = '" + Mv_Par04 + "' AND%"
		Else
			cQuery := "%SU4.U4_OPERAD = '" + Space(TamSX3("U4_OPERAD")[1]) + "' AND%"
		EndIf
	Else
		If Empty(Mv_Par01)
			cQuery := "%SU4.U4_OPERAD <> '" + Space(TamSX3("U4_OPERAD")[1]) + "' AND%"
		Else
			cQuery := "%SU4.U4_OPERAD = '" + Mv_Par01 + "' AND%"
		Endif

		If !Empty(Mv_Par04)
			cQuery1 := "%SU6.U6_CONTATO = SU5.U5_CODCONT AND SU4.U4_LISTA = '" + Mv_Par04 + "' AND%"
		Else
			cQuery1 := "%SU6.U6_CONTATO = SU5.U5_CODCONT AND%"
		EndIf
		cQuery2 := "%U5_CODCONT, U5_CONTAT, U5_FONE, %"

		cQuery3 :="%," + RetSqlName("SU5") + " SU5%"
	EndIf

	MakeSqlExpr("TMKR020")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	U4_LISTA,  U4_OPERAD,  U4_LISTA,  U4_DESC,  
				U4_TIPO,   U4_FORMA,   U4_TELE,   U4_CONFIG,  
				U4_TIPOTEL,U4_MALADIR, U4_TIPOEND,U4_LABEL,
				U4_ETIQUET,U4_CODCAMP, U4_SCRIPT, U4_EVENTO,
				U6_FILIAL, U6_LISTA,   U6_CONTATO,U6_ORIGEM, 
				U6_DATA,   U6_HRINI,   U6_HRFIM,  U6_STATUS, 
				U6_ENTIDA, U6_CODENT,  
				%exp:cQuery2% 
				U4_DATA

		FROM %table:SU4% SU4,%table:SU6% SU6 %exp:cQuery3%
		WHERE	SU4.U4_FILIAL	= %xfilial:SU4%                                    	AND 
				SU4.U4_DATA BETWEEN %exp:DtoS(mv_par02)% AND %exp:DtoS(mv_par03)% 	AND
				SU4.%notDel%														AND
				SU4.U4_FILIAL	= %xfilial:SU4% 									AND
	  			%exp:cQuery%   					
				SU6.U6_LISTA = SU4.U4_LISTA 										AND
				%exp:cQuery1%     
				SU6.%notDel%				     

		ORDER BY %Order:SU4%
	EndSql
	
	END REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Baseada na query da secao1, utiliza filtro para saber quando deve sair do laco de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:SetParentQuery()
	oSection2:SetParentFilter( { | cParam | (cAlias1)->U4_DATA == cParam},{|| (cAlias1)->U4_DATA } )
	oSection1:SetHeaderSection(.T.)		//Define que o header vai ser apresentado

	TRPosition():New(oSection2,"SU4",1,{|| xFilial("SU4") + (cAlias1)->U4_LISTA })

	oSection3:SetParentQuery()
	oSection3:SetParentFilter( { | cParam | (cAlias1)->U6_LISTA == cParam},{|| (cAlias1)->U4_LISTA } )

#ELSE
    
	MakeSqlExpr("TMKR020")
    
    cFiltro := "U4_FILIAL = '" + xFilial("SU4") + "'" 
 	cFiltro += " .AND. DTOS(U4_DATA) >= '" + dToS(Mv_Par02) +"'"
 	cFiltro += " .AND. DTOS(U4_DATA) <= '" + dToS(Mv_Par03) +"'"

	If !Empty(Mv_Par01)
		cFiltro += " .AND. U4_OPERAD = '" + Mv_Par01 + "'"
	Endif

	If !Empty(Mv_Par04)
		cFiltro += " .AND. U4_LISTA = '" + Mv_Par04 + "'"
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa o filtro³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Totaliza por data³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:SetParentFilter( { | cParam | SU4->U4_DATA == cParam},{|| SU4->U4_DATA} )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Realiza busca no SU6³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection3:SetRelation({|| xFilial("SU6") + SU4->U4_LISTA},"SU6",1,.T.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Muda de linha e imprime o proximo³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection3:SetParentFilter( { | cParam | SU6->U6_LISTA == cParam},{|| SU4->U4_LISTA} )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Posiciona do SU5 para pegar nome³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New(oSection3,"SU5",1,{|| xFilial("SU5") + SU6->U6_CONTATO})    

#ENDIF	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Print()

Return				
