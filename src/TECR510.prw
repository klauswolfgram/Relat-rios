/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR510.CH"
#INCLUDE "REPORT.CH"

#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR510"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR510   ³ Autor ³ Eduardo Riera         ³ Data ³ 24.11.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Atendimento da OS                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 22/08/06 ³ Cleber M.     ³Bops 99270: Conversao para relatorio perso- ³±±
±±³          ³               ³nalizavel (Release 4).                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR510(cOs)
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

Pergunte("ATR510",.F.)
If ( !Empty(cOs) )
	MV_PAR01 := cOs
	MV_PAR02 := cOs
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr510RptDef()
oReport:PrintDialog()

RestArea( aArea )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr510RptDef ºAutor  ³Cleber Martinez     º Data ³  22/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR510 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr510RptDef()
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
// "Ficha de Atendimento da OS"
// "     Este programa ira emitir as Fichas de Atendimento da OS conforme os "
// "parametros solicitados."
DEFINE REPORT oReport NAME "TECR510" TITLE STR0001 PARAMETER "ATR510" ACTION {|oReport| Tcr510PrtRpt(oReport, cAlias1)} DESCRIPTION STR0002 + STR0003 + STR0004 
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0043 TABLES "AB7","AB6","AB1" // "Ficha de Atendimento"
		oSection1:SetLineStyle()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "AB7_NUMOS" 	OF oSection1 ALIAS "AB7" CELL BREAK
		DEFINE CELL NAME "A1_COD" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_LOJA" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1" 
		DEFINE CELL NAME "A1_EST" 		OF oSection1 ALIAS "SA1" CELL BREAK
		DEFINE CELL NAME "A1_END" 		OF oSection1 ALIAS "SA1" 
		DEFINE CELL NAME "A1_MUN" 		OF oSection1 ALIAS "SA1" 
		DEFINE CELL NAME "A1_BAIRRO" 	OF oSection1 ALIAS "SA1" 
		DEFINE CELL NAME "A1_TEL" 		OF oSection1 ALIAS "SA1" CELL BREAK
		DEFINE CELL NAME "AB1_CONTAT" 	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "AB1_NRCHAM" 	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "AB1_EMISSA" 	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "AB1_HORAF" 	OF oSection1 ALIAS "AB1" CELL BREAK
		DEFINE CELL NAME "cObservacao"	OF oSection1 ALIAS " " TITLE STR0027 CELL BREAK	//"Observ. "
		DEFINE CELL NAME "AB7_CODPRO" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_NUMSER" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_CODPRB" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection1 ALIAS "AAG" CELL BREAK
		DEFINE CELL NAME "cGarantia" 	OF oSection1 ALIAS " " TITLE STR0028 SIZE 15 BLOCK {|| Tcr510Gar(cAlias1) } //"Garantia "
		DEFINE CELL NAME "cContrato" 	OF oSection1 ALIAS " " TITLE STR0029 SIZE 15 BLOCK {|| Tcr510Contr(cAlias1) } //"Contrato "
		DEFINE CELL NAME "cAcumulador" 	OF oSection1 ALIAS " " TITLE STR0030 CELL BREAK	//"Acumulador "

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0044 TABLE "AB6","AB7" // "Itens do orçamento"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "cKit_Prod" 	OF oSection2 ALIAS " " TITLE STR0031 SIZE 20	//"Produto"
			DEFINE CELL NAME "cKit_Descr" 	OF oSection2 ALIAS " " TITLE STR0032 SIZE 40	//"Descricao"
			DEFINE CELL NAME "nKit_Qtde" 	OF oSection2 ALIAS " " TITLE STR0033 SIZE 15	//"Quantidade"

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ Tcr510Gar  ºAutor  ³Cleber Martinez     º Data ³  23/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que indica se o produto esta em Garantia               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³cRet: Sim / Nao                                             	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cAlias1: Alias da tabela principal do relatorio	        	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR510 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr510Gar(cAlias1)
Local cRet := ""	//Retorno da funcao
If AtIsGar( (cAlias1)->AB7_CODFAB,(cAlias1)->AB7_LOJAFA,(cAlias1)->AB7_CODPRO,(cAlias1)->AB7_NUMSER )
	cRet := STR0023	//"Sim"
Else	
	cRet := STR0024 //"Nao"
EndIf

Return Upper(cRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr510Contr ºAutor  ³Cleber Martinez     º Data ³  23/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que indica se o produto tem Contrato de Manutencao		º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³cRet: Sim / Nao                                             	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cAlias1: Alias da tabela principal do relatorio	        	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR510 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr510Contr(cAlias1)
Local cRet := ""		//Retorno da funcao
If AtIsCtrMan( (cAlias1)->AB7_CODFAB,(cAlias1)->AB7_LOJAFA,(cAlias1)->AB7_CODPRO,(cAlias1)->AB7_NUMSER )
	cRet := STR0023	//"Sim"
Else
	cRet := STR0024 //"Nao"
EndIf

Return Upper(cRet)
      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr510PrtRptºAutor  ³Cleber Martinez     º Data ³  22/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³cAlias1: Alias da tabela principal do relatorio            	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR510 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr510PrtRpt( oReport, cAlias1 )
Local oSection1 := oReport:Section(1)			// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)			// Define que a secao 2 sera filha da secao 1
Local nLoop		:= 1							// Usada em lacos For...Next
Local nI		:= 1							// Usada em lacos For...Next

#IFDEF TOP
	DbSelectArea("AB7") 
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR510")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB7_NUMOS,	AB7_CODPRO,	AB7_NUMSER,	AB7_CODPRB,
				AB7_CODFAB,	AB7_LOJAFA,	AB7_NRCHAM,	AB7_NUMORC
				
		FROM %table:AB7% AB7
		
		WHERE	AB7_FILIAL = %xfilial:AB7%		AND
				AB7_NUMOS >= %exp:mv_par01%		AND  
				AB7_NUMOS <= %exp:mv_par02%		AND
				AB7.%notDel%
				
		ORDER BY %Order:AB7%

	EndSql
	
	END REPORT QUERY oSection1

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR510")

	DbSelectArea(cAlias1)
	DbSetOrder(1)

	cFiltro := "AB7_FILIAL == '" + xFilial("AB7") + "' .AND. "
	cFiltro += "AB7_NUMOS >= '" + mv_par01 + "' .AND. "
	cFiltro += "AB7_NUMOS <= '" + mv_par02 + "'" 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua o filtro de acordo com a expressao do arquivo AB7 (Itens da OS)		 						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro )
	
#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAlias1)->(LastRec()))
DbSelectArea(cAlias1)
If !isBlind()
	oSection1:Init()
EndIf
While !oReport:Cancel() .AND. !(cAlias1)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf

	dbSelectArea("AB6")
	dbSetOrder(1)
	MsSeek(xFilial("AB6")+(cAlias1)->AB7_NUMOS)
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	MsSeek(xFilial("SA1")+AB6->AB6_CODCLI+AB6->AB6_LOJA)
	
	dbSelectArea("AAG")
	dbSetOrder(1)
	MsSeek(xFilial("AAG")+(cAlias1)->AB7_CODPRB)
	
	If ( Empty((cAlias1)->AB7_NRCHAM) )
		dbSelectArea("AB4")
		dbSetOrder(1)
		MsSeek(xFilial("AB4")+(cAlias1)->AB7_NUMORC)
		
		dbSelectArea("AB2")
		dbSetOrder(1)
		MsSeek(xFilial("AB2")+AB4->AB4_NRCHAM)
	Else
    	dbSelectArea("AB2")
		dbSetOrder(1)
		MsSeek(xFilial("AB2")+(cAlias1)->AB7_NRCHAM)
	EndIf
	dbSelectArea("AB1")
	dbSetOrder(1)
	MsSeek(xFilial("AB1")+AB2->AB2_NRCHAM)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a secao 1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !isBlind()
		oSection1:PrintLine() 
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime manualmente as demais linhas do relatorio ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	oReport:SkipLine()
 	oReport:ThinLine()
 	oReport:PrintText(STR0034)	//"DATA CHEGADA:     /     /        HORA CHEGADA:      :       HS   DATA SAIDA:        /      /       HORA SAIDA:         :      HS"
 	oReport:PrintText(STR0035)	//"DATA INICIO :     /     /        HORA INICIO:       :       HS   DATA TERMINO:      /      /       HORA TERMINO:       :      HS"
	oReport:ThinLine() 	
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:ThinLine() 		
	oReport:PrintText(STR0036)	//"Defeito Constatado: "
	For nI:=1 to 7
		oReport:SkipLine()
	Next nI
	oReport:ThinLine() 	
	oReport:PrintText(STR0037)	//"Causa Provavel: "
	For nI:=1 to 7
		oReport:SkipLine()
	Next nI
	oReport:ThinLine() 	
	oReport:PrintText(STR0038)	//"Servico Executado: "
	For nI:=1 to 8
		oReport:SkipLine()
	Next nI
	oReport:ThinLine() 	
	oReport:PrintText(STR0039)	//"Produto         Nr. Serie            Fabricante     Descricao                     Quantidade     Observacao "
	For nI:=1 to 22
		oReport:SkipLine()
	Next nI	
	oReport:ThinLine()
	oReport:PrintText(STR0040)	//"Sugestao : "
	For nI:=1 to 6
		oReport:SkipLine()
	Next nI
	oReport:ThinLine() 
	For nI:=1 to 4
		oReport:SkipLine()
	Next nI
	oReport:PrintText("         _______________________________________             ________________________________________              ______________________________________   ")
	oReport:PrintText(STR0041)	//"                        CLIENTE                                               TECNICO                                              GERENTE                  "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o kit de atendimento                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR03 == 2 	//Sim

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Retorna o kit de atendimento para o produto / ocorrencia               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aKit := AtRetKit( (cAlias1)->AB7_CODPRO, (cAlias1)->AB7_CODPRB ) 
		
		If Len(aKit) > 0
			oReport:EndPage()
			If !isBlind()
				oSection1:PrintLine()
			EndIf
			oReport:SkipLine()
			oReport:PrintText(oReport:Title() + " - " + STR0042)	//"KIT DE ATENDIMENTO "
			oReport:ThinLine()
		    oReport:SkipLine()
		    If !isBlind()
		    	oSection2:Init()
		    EndIf
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Percorre o kit de atendimento                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nLoop := 1 To Len( aKit ) 
	
			oSection2:Cell("cKit_Prod"):SetValue(aKit[nLoop,1])
			oSection2:Cell("cKit_Descr"):SetValue(aKit[nLoop,2])
			oSection2:Cell("nKit_Qtde"):SetValue(Transform(aKit[nLoop, 3],"@E 999,999,999.99"))

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a secao 2 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !isBlind()	
				oSection2:PrintLine()
			EndIf
		Next nLoop 
		
		
		If Len(aKit) > 0
			oSection2:Finish()
		EndIf
		
	EndIf 
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua quebra de pagina e avanca para o prox. registro ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:EndPage()
	
	dbSelectArea(cAlias1)
	dbSkip()
End

oSection1:Finish()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³RetLayOut ³ Autor ³ Eduardo Riera         ³ Data ³ 24.11.98 ³±±
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

Static ;
User Function RetLayOut()

Local aLay    := Array(62)
Local aLayKit := Array(04)
//
//                     1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//           01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

aLay[01] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[02] := STR0008 // "|                            FICHA DE ATENDIMENTO DA OS                                             | Nr.OS: ###### | Folha: ######|"
aLay[03] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[04] := STR0009 // "|Cliente  : ######/## - ########################################                                                      Estado:   ## |"
aLay[05] := STR0010 // "|End.     : ######################################## CIDADE: #################### BAIRRO : ################### Tel.:############## |"
aLay[06] := STR0011 // "|Contato  : #################### CHAMADO: ######## DT.CHAMADO ########## HORA: #####                                               |"
aLay[07] := STR0012 // "|Observ.  : ###################################################################################################################### |"
aLay[08] := STR0013 // "|Produto  : ############### Nr.Serie : #################### OCORRENCIA/PROBLEMA: ###### - ##############################           |"
aLay[09] := STR0014 // "|Garantia: ### Contrato: ### ACUMULADOR:                                                                                           |"
aLay[10] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[11] := STR0015 // "|DATA CHEGADA:     /     /        HORA CHEGADA:      :       HS   DATA SAIDA:        /      /       HORA SAIDA:         :      HS  |"
aLay[12] := STR0016 // "|DATA INICIO :     /     /        HORA INICIO:       :       HS   DATA TERMINO:      /      /       HORA TERMINO:       :      HS  |"
aLay[13] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[14] := STR0017 // "|Defeito Constatado:                                                                                                               |"
aLay[15] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[16] := "|                                                                                                                                  |"
aLay[17] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[18] := "|                                                                                                                                  |"
aLay[19] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[20] := STR0018 // "|Causa Provavel:                                                                                                                   |"
aLay[21] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[22] := "|                                                                                                                                  |"
aLay[23] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[24] := "|                                                                                                                                  |"
aLay[25] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[26] := STR0019 // "|Servico Executado:                                                                                                                |"
aLay[27] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[28] := "|                                                                                                                                  |"
aLay[29] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[30] := "|                                                                                                                                  |"
aLay[31] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[32] := "|                                                                                                                                  |"
aLay[33] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[34] := STR0020 // "|Produto        |Nr. Serie           |Fabricante|Descricao                     ³Quantidade|Observacao                              |"
aLay[35] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[36] := "|               |                    |          |                              |          |                                        |"
aLay[37] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[38] := "|               |                    |          |                              |          |                                        |"
aLay[39] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[40] := "|               |                    |          |                              |          |                                        |"
aLay[41] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[42] := "|               |                    |          |                              |          |                                        |"
aLay[43] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[44] := "|               |                    |          |                              |          |                                        |"
aLay[45] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[46] := "|               |                    |          |                              |          |                                        |"
aLay[47] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[48] := "|               |                    |          |                              |          |                                        |"
aLay[49] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[50] := "|               |                    |          |                              |          |                                        |"
aLay[51] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[52] := "|               |                    |          |                              |          |                                        |"
aLay[53] := "+---------------+--------------------+----------+------------------------------+----------+----------------------------------------+"
aLay[54] := STR0021 // "|Sugestao :                                                                                                                        |"
aLay[55] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[56] := "|                                                                                                                                  |"
aLay[57] := "+------------------------------------------+--------------------------------------------+------------------------------------------+"
aLay[58] := "|                                          |                                            |                                          |"
aLay[59] := "|                                          |                                            |                                          |"
aLay[60] := "+------------------------------------------+--------------------------------------------+------------------------------------------+"
aLay[61] := STR0022 // "|              CLIENTE                     |                 TECNICO                    |                 GERENTE                  |"
aLay[62] := "+----------------------------------------------------------------------------------------------------------------------------------+"

aLayKit[01] := STR0025 //"|                          FICHA DE ATENDIMENTO DA OS - KIT DE ATENDIMENTO                          | Nr.OS: ###### | Folha: ######|"
aLayKit[02] := "+---------------+------------------------------+-----------------------------------------------------------------------------------+"
aLayKit[03] := STR0026 //"|Produto        |Descricao                     |Quantidade                                                                         |"
aLayKit[04] := "|###############|##############################|##############                                                                     |"      

Return( { aLay, aLayKit } )

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

Return Tcr510RptDef()

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

Return Tcr510PrtRpt( oReport , GetNextAlias())

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