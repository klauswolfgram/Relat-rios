/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TMKR039.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR039  ³ Autor ³ Vendas Clientes       ³ Data ³ 20/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Ligacoes realizadas no atendimento de Televendas com o tipo³±±
±±³          ³ atendimento.                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Televendas (SUA)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR039()
Local oReport					// Objeto Report
Local aArea := GetArea()		// Salva a area 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                          ³
//³ Mv_Par01           // Do Operador                             ³
//³ Mv_Par02           // Ate o Operador                          ³
//³ Mv_Par03           // A Partir de                             ³
//³ Mv_Par04           // Ate o dia                               ³
//³ Mv_Par05           // Da Midia                                ³
//³ Mv_Par06           // Ate a Midia                             ³
//³ Mv_Par07           // Campanha         - Vazio entra tudo     ³
//³ Mv_Par08           // Tipo da Entidade - SA1, SUS ou TODAS    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK039",.F.)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                       
oReport := ReportDef()
oReport:PrintDialog()
 
RestArea( aArea )

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Vendas Clientes     º Data ³  28/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR039                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport				// Objeto do relatorio
Local oSection1				// Objeto da secao 1
Local oSection2				// Objeto da secao 2
Local oSection3				// Objeto da secao 3
Local cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
Local cAlias2		:= cAlias1								// Deixa o cAlias2 igual ao cAlias1
Local cAlias3		:= cAlias1								// Deixa o cAlias3 igual ao cAlias1
Local lEntObf		:= FATPDIsObfuscate("A1_NOME",Nil,.T.) .Or. FATPDIsObfuscate("US_NOME",Nil,.T.)
Local cNEntObf		:= ""  

If lEntObf
	cNEntObf := FATPDObfuscate("Obfuscate")  
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gera a tela com os dados para a confirmação da geracao do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//"Atendimentos Realizados - Televendas"
// "Este programa irá emitir uma relação das ligações realizadas pelo operador no atendimento Televendas."
// "Apenas as ligações registradas como ATENDIMENTO serão emitidas neste relatório." # "Os dados serão emitidos conforme os parâmetros informados."
DEFINE REPORT oReport NAME "TMKR039" TITLE STR0001 PARAMETER "TMK039" ACTION {|oReport| TKR039PrtRpt( oReport, cAlias1 )} DESCRIPTION STR0002 + STR0003 + STR0004
oReport:SetLandscape()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, com quebra por filial ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0034 TABLES "SUA","SU5","SUC" 	////"Orcamentos Televendas" 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "UA_EMISSAO"	OF oSection1 ALIAS "SUA"
DEFINE CELL NAME "UA_CODCONT"	OF oSection1 ALIAS "SUA" //SIZE 35 BLOCK {|| (cAlias1)->UA_CODCONT + " - " + Posicione("SU5",1,xFilial("SU5") + (cAlias1)->UA_CODCONT,"U5_CONTAT") }
DEFINE CELL NAME "UA_NUM"		OF oSection1 ALIAS "SUA"
DEFINE CELL NAME "U5_FCOM1"		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "UA_OPERADO"	OF oSection1 ALIAS "SUA" //SIZE 35 BLOCK {|| (cAlias1)->UA_OPERADO + " - " + Posicione("SU7",1,xFilial("SU7") + (cAlias1)->UA_OPERADO,"U7_NOME") }
DEFINE CELL NAME "U5_EMAIL"		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "UA_VEND"		OF oSection1 ALIAS "SUA" //SIZE 35 BLOCK {|| (cAlias1)->UA_VEND + " - " + Posicione("SA3",1,xFilial("SA3") + (cAlias1)->UA_VEND,"A3_NOME") }
DEFINE CELL NAME "UA_CLIENTE"	OF oSection1 ALIAS "SUA" TITLE STR0049 SIZE 50 BLOCK {|| IIF((cAlias1)->UA_PROSPEC,STR0050,STR0051) + " - " +;   		//"Entidade"
																						(cAlias1)->UA_CLIENTE + " - " + IIF(Empty(cNEntObf),IIF((cAlias1)->UA_PROSPEC,;     //"PROSPECT"#"CLIENTE"
																						POSICIONE("SUS",1,XFILIAL("SUS")+(cAlias1)->UA_CLIENTE+(cAlias1)->UA_LOJA,"US_NOME"),;
																						POSICIONE("SA1",1,XFILIAL("SA1")+(cAlias1)->UA_CLIENTE+(cAlias1)->UA_LOJA,'A1_NOME')),cNEntObf) }   
DEFINE CELL NAME "UA_MIDIA"		OF oSection1 ALIAS "SUA" //SIZE 35 BLOCK {|| (cAlias1)->UA_MIDIA + " - " + Posicione("SUH",1,xFilial("SUH") + (cAlias1)->UA_MIDIA,"UH_DESC") }
DEFINE CELL NAME "UA_CODCAMP"	OF oSection1 ALIAS "SUA"
DEFINE CELL NAME "UA_CODLIG"	OF oSection1 ALIAS "SUA"
DEFINE CELL NAME "UA_TABELA"	OF oSection1 ALIAS "SUA"
DEFINE CELL NAME "UA_OPER"		OF oSection1 ALIAS "SUA"
DEFINE CELL NAME "UA_TMK"		OF oSection1 ALIAS "SUA"
DEFINE CELL NAME "UA_TPFRETE"	OF oSection1 ALIAS "SUA"
DEFINE CELL NAME "UC_PENDENT"	OF oSection1 ALIAS "SUC"
DEFINE CELL NAME "UA_CODOBS"	OF oSection1 ALIAS "SUA" PICTURE "@!" SIZE 100 BLOCK {|| MSMM((cAlias1)->UA_CODOBS,43) }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao2 do relatorio, informando que o arquivo principal utlizado eh o SL3 e o complementar o SB1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection2 OF oSection1 TITLE STR0035 TABLES "SUB","SB1" 	//"Itens do Orcamento Televendas" 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME "UB_ITEM"		OF oSection2 ALIAS "SUB" TITLE STR0024	//"It"
DEFINE CELL NAME "UB_PRODUTO"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "B1_DESC"		OF oSection2 ALIAS "SB1"
DEFINE CELL NAME "UB_SITPROD"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_QUANT"		OF oSection2 ALIAS "SUB" TITLE STR0025	//"Qtdade"
DEFINE CELL NAME "UB_VRUNIT"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_VLRITEM"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_DESC"		OF oSection2 ALIAS "SUB" TITLE STR0026	//"%Desc"
DEFINE CELL NAME "UB_VALDESC"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_ACRE"		OF oSection2 ALIAS "SUB" TITLE STR0027	//"%Acre"
DEFINE CELL NAME "UB_VALACRE"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_TES"		OF oSection2 ALIAS "SUB" TITLE STR0028	//"TES"
DEFINE CELL NAME "UB_CF"		OF oSection2 ALIAS "SUB" TITLE STR0029	//"CFOP"
DEFINE CELL NAME "UB_PRCTAB"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_BASEICM"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_LOCAL"		OF oSection2 ALIAS "SUB" TITLE STR0030	//"LP"
DEFINE CELL NAME "UB_UM"		OF oSection2 ALIAS "SUB" TITLE STR0031	//"UM"
DEFINE CELL NAME "UB_DTENTRE"	OF oSection2 ALIAS "SUB" TITLE STR0032	//"Entrega"
DEFINE CELL NAME "UB_LOTE"		OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_SUBLOTE"	OF oSection2 ALIAS "SUB"
DEFINE CELL NAME "UB_DTVALID"	OF oSection2 ALIAS "SUB" TITLE STR0033	//"Validade"

DEFINE FUNCTION FROM oSection2:Cell("UB_QUANT")		FUNCTION SUM NO END REPORT
DEFINE FUNCTION FROM oSection2:Cell("UB_VLRITEM")	FUNCTION SUM NO END REPORT
DEFINE FUNCTION FROM oSection2:Cell("UB_VALDESC")	FUNCTION SUM NO END REPORT
DEFINE FUNCTION FROM oSection2:Cell("UB_VALACRE")	FUNCTION SUM NO END REPORT

oSection1:SetTotalText("")
oSection1:SetLineStyle()
oSection2:SetTotalText("")
oSection2:SetTotalInLine(.F.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TKR039PrtRptºAutor  ³Vendas Clientes     º Data ³  28/08/06   º±±                                  		
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR039                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TKR039PrtRpt( oReport, cAlias1 )

Local oSection1 := oReport:Section(1)		// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)		// Define que a secao 2 serah filha da secao 1
Local cFiltro	:= ""						// Variavel utilizada para o filtro
Local cQuery1	:= "%"    					//	Armazena valores para a query
Local oCollMidia							// Objeto do Collection da Midia
Local oCollCampa							// Objeto do Collection da Campanha
Local oPerMidia								// Objeto do Percentual do Collection da Midia
Local oPerCamp								// Objeto do Percentual do Collection da Campanha
Local oTotAten								// Objeto do total de atendimentos

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Abre o arquivo de telecobranca pelo indice do cliente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SUA")
DbSetOrder(1)

MakeSqlExpr("TMK039")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciono somente a campanha informada nos parametros³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(MV_PAR07)
	cQuery1 +=	"	AND SUA.UA_CODCAMP = '" + MV_PAR07 +	"'  "
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciono somente o tipo de entidade dos parametros³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ       
If MV_PAR08 <> 3		// Ambos
	If MV_PAR08 == 1	// Clientes
		cQuery1 +=	"	AND	SUA.UA_PROSPEC	=	'F'	"    
		TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1")+(cAlias1)->UA_CLIENTE +(cAlias1)->UA_LOJA})
	Else				// Prospects
		cQuery1 +=	"	AND	SUA.UA_PROSPEC = 'T'	"
	Endif                                   

Endif   
cQuery1 += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query utilizada para filtrar todos os dados necessarios ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BeginSql alias cAlias1
	SELECT	UA_EMISSAO,	UA_NUM,		UA_OPERADO,	UA_CODCONT, 
			UA_VEND,	UA_MIDIA,	UA_CODCAMP,	UA_CODLIG,	
			UA_TABELA,	UA_OPER,	UA_TMK,		UA_TPFRETE,	
			UA_CODOBS,	UA_CLIENTE,	UA_LOJA, 	UA_FILIAL, 
			UA_PROSPEC, UB_ITEM,	UB_PRODUTO,	B1_DESC,	
			B1_COD, 	UB_SITPROD,	UB_QUANT,	UB_VRUNIT,	
			UB_VLRITEM,	UB_DESC,	UB_VALDESC,	UB_ACRE,	
			UB_VALACRE,	UB_TES,		UB_CF,		UB_PRCTAB,	
			UB_BASEICM,	UB_LOCAL,	UB_UM,		UB_DTENTRE,	
			UB_LOTE,	UB_SUBLOTE,	UB_DTVALID,	UB_NUM


	FROM %table:SUA% SUA

	LEFT JOIN %table:SUB% SUB ON
		SUB.UB_FILIAL = %xfilial:SUB% AND SUB.UB_NUM = SUA.UA_NUM AND SUB.%notDel%

	LEFT JOIN %table:SB1% SB1 ON
		B1_FILIAL = %xfilial:SB1% AND SB1.B1_COD = SUB.UB_PRODUTO AND SB1.%notDel%

	WHERE	UA_FILIAL	=	%xfilial:SUA%			AND
			UA_OPERADO	>=	%exp:mv_par01%			AND
			UA_OPERADO	<=	%exp:mv_par02%			AND
			UA_EMISSAO	>=	%exp:DtoS(mv_par03)%	AND
			UA_EMISSAO	<=	%exp:DtoS(mv_par04)%	AND
			UA_MIDIA	>=	%exp:mv_par05%			AND
			UA_MIDIA	<=	%exp:mv_par06%			AND
			UA_CANC		=	' '						AND
			UA_OPER		=	'3'						AND
			SUA.%notDel%
			%exp:cQuery1%							
	ORDER BY %Order:SUA%
EndSql
END REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Baseada na query da secao1, utiliza filtro para saber quando deve sair do laco de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:SetParentQuery()

oSection2:SetParentFilter( { | cParam | (cAlias1)->UA_NUM == cParam},{|| (cAlias1)->UB_NUM } ) 

TRPosition():New(oSection1,"SU5",1,{|| xFilial("SU5")+ (cAlias1)->UA_CODCONT})  
TRPosition():New(oSection1,"SUH",1,{|| xFilial("SUH")+ (cAlias1)->UA_MIDIA}) 
TRPosition():New(oSection1,"SA3",1,{|| xFilial("SA3")+ (cAlias1)->UA_VEND}) 
TRPosition():New(oSection1,"SU7",1,{|| xFilial("SU7")+ (cAlias1)->UA_OPERADO}) 

TRCollection():New(/*cName*/,"COUNT"/*cFunction*/,/*oBreak*/,STR0020/*uTitle*/,/*cPicture*/,oSection1:Cell('UA_OPER')/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,oSection1/*oParent*/,/*bCondition*/,oSection1:Cell('UA_OPER')/*uContent*/)	//"OPERACAO"

TRCollection():New(/*cName*/,"SUM"/*cFunction*/,/*oBreak*/," "/*uTitle*/,/*cPicture*/,oSection1:Cell('UA_OPER')/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,oSection2/*oParent*/,/*bCondition*/,oSection2:Cell('UB_VLRITEM')/*uContent*/)

TRCollection():New(/*cName*/,"COUNT"/*cFunction*/,/*oBreak*/,STR0021/*uTitle*/,/*cPicture*/,oSection1:Cell('UA_OPERADO')/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,oSection1/*oParent*/,/*bCondition*/,oSection1:Cell('UA_OPERADO')/*uContent*/)	//"OPERADOR"

oPerMidia := TRFunction():New(oSection1:Cell('UA_MIDIA')/*oCell*/,/*cName*/,"COUNT"/*cFunction*/,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oParent*/,/*bCondition*/,/*lDisable*/,/*bCanPrint*/)
oPerMidia:Hide()

oTotAten := TRFunction():New(oSection1:Cell('UA_NUM')/*oCell*/,/*cName*/,"COUNT"/*cFunction*/,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oParent*/,/*bCondition*/,/*lDisable*/,/*bCanPrint*/)
oTotAten:Hide()

oPerCamp := TRFunction():New(oSection1:Cell('UA_CODCAMP')/*oCell*/,/*cName*/,"COUNT"/*cFunction*/,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oParent*/,/*bCondition*/,/*lDisable*/,/*bCanPrint*/)
oPerCamp:Hide()

oCollMidia := TRCollection():New(/*cName*/,"COUNT"/*cFunction*/,/*oBreak*/,STR0022/*uTitle*/,/*cPicture*/,oSection1:Cell('UA_MIDIA')/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,oSection1/*oParent*/,/*bCondition*/,oSection1:Cell('UA_MIDIA')/*uContent*/)

TRCollection():New(/*cName*/,"ONPRINT"/*cFunction*/,/*oBreak*/,"% "+STR0022/*uTitle*/,'@E 999.99 %'/*cPicture*/,oSection1:Cell('UA_MIDIA')/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,oSection1/*oParent*/,/*bCondition*/,;
					{|a1,a2,a3,a4|  (oCollMidia:GetFunction(a4:name()):GetLastValue()/oTotAten:GetValue())*100 }/*uContent*/)	//"MIDIA"

oCollCampa := TRCollection():New(/*cName*/,"COUNT"/*cFunction*/,/*oBreak*/,STR0023/*uTitle*/,/*cPicture*/,oSection1:Cell('UA_CODCAMP')/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,oSection1/*oParent*/,/*bCondition*/,oSection1:Cell('UA_CODCAMP')/*uContent*/)

TRCollection():New(/*cName*/,"ONPRINT"/*cFunction*/,/*oBreak*/,"% "+STR0023/*uTitle*/,'@E 999.99 %'/*cPicture*/,oSection1:Cell('UA_CODCAMP')/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,oSection1/*oParent*/,/*bCondition*/,;
					{|a1,a2,a3,a4|  (oCollCampa:GetFunction(a4:name()):GetLastValue()/oTotAten:GetValue())*100 }/*uContent*/)

oSection1:Print()

Return Nil   

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive