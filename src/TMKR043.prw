/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR043.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR043  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 07/11/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio do Cenário de Telecobranca.	   	              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_TMKR043(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGATMK                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ANALISTA     ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR043()

Local oReport
Local aArea := GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ Mv_Par01           // Do Grupo de Atendimento                ³
//³ Mv_Par02           // Ate o Grupo de Atendimento             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK043",.F.) 

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
±±ºPrograma  ³ReportDef ºAutor  ³Hanna               º Data ³  26/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR043                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAnalista  ³ Data/Bops/Ver ºManutencao Efetuada                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍËÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³        º      º                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport	:= Nil						// Objeto do relatorio
Local oSection1	:= Nil						// Objeto da secao 1
Local oSection2	:= Nil						// Objeto da secao 2
Local oSection3	:= Nil						// Objeto da secao 3
Local oSection4	:= Nil						// Objeto da secao 4
Local cAlias1	:= GetNextAlias()			// Pega o proximo Alias Disponivel
Local cAlias3	:= GetNextAlias()			// Pega o proximo Alias Disponivel
Local cAlias4	:= GetNextAlias()			// Pega o proximo Alias Disponivel
Local nTamDSit	:= GetSx3Cache("ACG_DSITCB","X3_TAMANHO")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gera a tela com os dados para a confirmação da geracao do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//"Cenário de Telecobrança"
// "Este programa irá emitir uma relação dos Grupos de Atendimento e as regras que cada Grupo possui." # "A emissão ocorrerá baseada nos parâmetros do relatório"
DEFINE REPORT oReport NAME "TMKR043" TITLE STR0001 PARAMETER "TMK043" ACTION {|oReport| Tkr043PrtRpt(oReport, cAlias1, cAlias3, cAlias4)} DESCRIPTION STR0002 + STR0003

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0039 TABLES "SU0","SK0","SK2" COLUMNS 2		// "Detalhes do Grupo de Atendimento"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "GRPATEND"		OF oSection1 SIZE 20 PICTURE "@!" TITLE STR0007
DEFINE CELL NAME "U0_CODIGO"	OF oSection1 ALIAS "SU0" TITLE StrTran(STR0008,":","")
DEFINE CELL NAME "U0_NOME" 		OF oSection1 ALIAS "SU0" TITLE StrTran(STR0009,":","")
DEFINE CELL NAME "U0_REGSEL" 	OF oSection1 ALIAS "SU0" TITLE StrTran(STR0010,":","")
DEFINE CELL NAME "K0_DESC" 		OF oSection1 ALIAS "SK0" TITLE StrTran(STR0011,":","")
DEFINE CELL NAME "U0_REGNEG" 	OF oSection1 ALIAS "SU0" TITLE StrTran(STR0012,":","")
DEFINE CELL NAME "K2_DESC" 		OF oSection1 ALIAS "SK2" TITLE StrTran(STR0013,":","")
DEFINE CELL NAME "U0_TIPOIE" 	OF oSection1 ALIAS "SU0" TITLE StrTran(STR0014,":","")
DEFINE CELL NAME "U0_TLCMAIL" 	OF oSection1 ALIAS "SU0" TITLE StrTran(STR0015,":","")	
DEFINE CELL NAME "REGRASE"		OF oSection1 SIZE 20 PICTURE "@!" TITLE StrTran(STR0016,":","")
DEFINE CELL NAME "K0_ORDEM" 	OF oSection1 ALIAS "SK0"
DEFINE CELL NAME "K0_PRAZO" 	OF oSection1 ALIAS "SK0"
DEFINE CELL NAME "K0_PREFIXO" 	OF oSection1 ALIAS "SK0"
DEFINE CELL NAME "K0_NATUREZ" 	OF oSection1 ALIAS "SK0" 
If nTamDSit <> Nil
	DEFINE CELL NAME "DSCSITUACA" OF oSection1 TITLE StrTran(STR0021,":","") SIZE nTamDSit;
	BLOCK {|| Capital( AllTrim( Posicione("FRV",1,xFilial("FRV")+(cAlias1)->K0_SITUACA,"FRV_DESCRI") ) ) } //Situacao:
Else
	DEFINE CELL NAME "K0_SITUACA" OF oSection1 ALIAS "SK0"     
EndIf
DEFINE CELL NAME "K0_PORTADO" 	OF oSection1 ALIAS "SK0"
DEFINE CELL NAME "REGRANE"		OF oSection1 SIZE 20 PICTURE "@!" TITLE STR0023
DEFINE CELL NAME "K2_ALTTIT" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_CREDITO" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_SELTIT" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_DIAREAG" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_DIAPROR" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_DIADESC" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_DSCNOM" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_DSCJUR" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_ACRESC" 	OF oSection1 ALIAS "SK2"
DEFINE CELL NAME "K2_DECRES" 	OF oSection1 ALIAS "SK2"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao2 (que sera filha da secao1)  e o arquivo principal utilizado na secao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection2 OF oSection1 TITLE STR0040 TABLES "SU7"	// "Operadores"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Define as celulas que irao aparecer na secao2³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE CELL NAME "U7_COD"		OF oSection2 ALIAS "SU7"
	DEFINE CELL NAME "U7_NREDUZ"	OF oSection2 ALIAS "SU7"
	DEFINE CELL NAME "U7_NOME"		OF oSection2 ALIAS "SU7"
	DEFINE CELL NAME "U7_TIPOATE"	OF oSection2 ALIAS "SU7"
	DEFINE CELL NAME "U7_REGIAO"	OF oSection2 ALIAS "SU7"
	DEFINE CELL NAME "U7_VALIDO"	OF oSection2 ALIAS "SU7"
	DEFINE CELL NAME "U7_TIPO"		OF oSection2 ALIAS "SU7"
	DEFINE CELL NAME "U7_HABIL"		OF oSection2 ALIAS "SU7"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao3 (que sera filha do oReport  e o arquivo principal utilizado na secao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection3 OF oReport TITLE STR0041 TABLES "SX5"	// "Detalhes da promoção de cobrança"
	DEFINE CELL NAME "REFENCIA"		OF oSection3 SIZE 20 PICTURE "@!" TITLE STR0035
	DEFINE CELL NAME "PROMOCAO"		OF oSection3 SIZE 20 PICTURE "@!" TITLE STR0036

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao3 (que sera filha da secao2)  e o arquivo principal utilizado na secao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection4 OF oSection3 TITLE STR0042 TABLES "SK3"	// "Itens da promoçaõ de cobrança"
	DEFINE CELL NAME "K3_CODIGO"	OF oSection4 ALIAS "SK3"
	DEFINE CELL NAME "K3_DESC"		OF oSection4 ALIAS "SK3"
	DEFINE CELL NAME "K3_INICIO"	OF oSection4 ALIAS "SK3"
	DEFINE CELL NAME "K3_FINAL"		OF oSection4 ALIAS "SK3"
	DEFINE CELL NAME "K3_VCTINI"	OF oSection4 ALIAS "SK3"
	DEFINE CELL NAME "K3_VCTFIM"	OF oSection4 ALIAS "SK3"
	DEFINE CELL NAME "K3_DIADESC"	OF oSection4 ALIAS "SK3"
	DEFINE CELL NAME "K3_DSCNOM"	OF oSection4 ALIAS "SK3"
	DEFINE CELL NAME "K3_DSCJUR"	OF oSection4 ALIAS "SK3"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Pula pagina quando houver a quebra da secao e define a secao 1, com estilo enchoice ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3:SetPageBreak(.T.) 
oSection1:SetLineStyle()
oSection3:SetLineStyle()
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TKR043PrtRptºAutor  ³Hanna               º Data ³  27/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR043                                                      º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ANALISTA     ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Conrado Q.   ³30/03/07³121875³-Faltava no SELECT o campo K3_FILIAL      ³±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TKR043PrtRpt( oReport,cAlias1, cAlias3, cAlias )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 serah filha da secao 1
Local oSection3 := oReport:Section(2)				// Define que a secao 3 serah filha do objeto oReport
Local oSection4 := oSection3:Section(1)				// Define que a secao 4 serah filha do objeto oSection3

oSection1:Cell("GRPATEND"):SetCellBreak()
oSection1:Cell("U0_TLCMAIL"):SetCellBreak()
oSection1:Cell("REGRASE"):SetCellBreak()
oSection1:Cell("K0_PORTADO"):SetCellBreak()
oSection1:Cell("REGRANE"):SetCellBreak()
oSection3:Cell("REFENCIA"):SetValue( SuperGetMv( "MV_TMKSK1" ) )
oSection3:Cell("REFENCIA"):SetCellBreak()
oSection3:Cell("PROMOCAO"):SetCellBreak()


DbSelectArea("SU0")
DbSetOrder(1)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMK043")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query da secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BeginSql alias cAlias1
	SELECT	U0_CODIGO,	U0_NOME,	U0_REGSEL,	U0_REGNEG,	U0_TIPOIE,	U0_TLCMAIL,	K0_DESC,	
			K0_ORDEM,	K0_PRAZO,	K0_PREFIXO,	K0_NATUREZ,	K0_SITUACA,	K0_PORTADO,	K2_DESC,	
			K2_ALTTIT,	K2_CREDITO,	K2_SELTIT,	K2_DIAREAG,	K2_DIAPROR,	K2_DIADESC,	K2_DSCNOM,	
			K2_DSCJUR,	K2_ACRESC,	K2_DECRES,	U7_COD,		U7_NREDUZ,	U7_NOME,	U7_TIPOATE,	
			U7_REGIAO,	U7_VALIDO,	U7_TIPO,	U7_HABIL,	U7_POSTO

	FROM %table:SU0% SU0,	%table:SU7% SU7, %table:SK0% SK0, %table:SK2% SK2
	WHERE	U0_FILIAL	=	%xfilial:SU0%	AND
			U0_CODIGO	>=	%exp:MV_PAR01%	AND
			U0_CODIGO	<=	%exp:MV_PAR02%	AND
			U0_REGSEL	=	K0_REGSEL		AND
			U0_REGNEG	=	K2_REGNEG		AND
			U0_CODIGO	=	U7_POSTO		AND
			SU0.%notDel%					AND
			SU7.%notDel%					AND
			SK0.%notDel%					AND
			SK2.%notDel%
	ORDER BY %Order:SU0%
EndSql
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Indica o fim da query, caso utilize range, deve-se informar como parametro ³
//³{MV_?,MV_?} para que seja incluido no select automaticamente               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
END REPORT QUERY oSection1 //PARAM mv_par01,mv_par02
	oSection2:SetParentQuery()
oSection2:SetParentFilter({|cParam| (cAlias1)->U7_POSTO == cParam},{|| (cAlias1)->U0_CODIGO } )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 4³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection3
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query da secao 4³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BeginSql alias cAlias3
	SELECT	K3_FILIAL,	K3_CODIGO,	K3_DESC,	K3_INICIO,	K3_FINAL,	K3_VCTINI,
			K3_VCTFIM,	K3_DIADESC,	K3_DSCNOM,	K3_DSCJUR
	FROM %table:SK3% SK3
	WHERE	K3_FILIAL	=	%xfilial:SK3%	AND
			SK3.%notDel%
	ORDER BY %Order:SK3%
EndSql
END REPORT QUERY oSection3

oSection4:SetParentQuery()
oSection4:SetParentFilter({|cParam| (cAlias3)->K3_FILIAL == cParam},{|| (cAlias3)->K3_FILIAL } )
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Print()
oSection3:Print()

Return