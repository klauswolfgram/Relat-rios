/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR090.CH"
#include "Protheus.ch"


// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

// TRADUCAO DE CH'S PARA PORTUGAL - 21/07/08         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR090  ³ Autor ³ Wagner Xavier         ³ Data ³ 28.01.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rela‡„o de Adiantamentos                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR090                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	Last change:  CIA   4 Jan 96    2:11 pm
*/
User Function ATFR090
Local oReport 

oReport:=ReportDef()
oReport:PrintDialog()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³28/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport,oSection1,oSection11
Local cReport := "ATFR090"
Local cAlias1 := "SN3"
Local cTitulo := STR0004 // "Rela‡„o dos Adiantamentos"
Local cDescri :=	STR0001 + " " + ;	// "Este programa ir  a rela‡„o dos bens adquiridos como"
						STR0002 + " " + ;	// "adiantamentos. Poder  ser listado por C¢digo, Conta, C.Custo,"
						STR0003 				// "Projeto ou Data de Aquisi‡„o."
Local bReport := { |oReport|	oReport:SetTitle( oReport:Title() + " - " + OemToAnsi(STR0010)+; // " Valores em " 
																AllTrim(GETMV("MV_SIMB" + Str(mv_par11,1,0)))),;
										ReportPrint( oReport ) }
Local aOrd

aOrd  := { 	OemToAnsi(STR0005),; // "Por C¢digo"
				OemToAnsi(STR0006),; //	"Por Conta"
				OemToAnsi(STR0007),; // "Por C.Custo"
				OemToAnsi(STR0008),; // "Projeto"
				OemToAnsi(STR0009),; // "Data
				STR0017 				,; // "Item Contabil"
				STR0018           }  // "Classe de Valor"

Pergunte( "AFR090" , .F. )
oReport  := TReport():New( cReport, cTitulo, "AFR090" , bReport, cDescri )

oReport:SetLandScape(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0029, {cAlias1}, aOrd )		//"Ordem dos Adiantamentos"

TRCell():New( oSection1, "N1_PROJETO"		, "SN1",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_AQUISIC"		, "SN1",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CBASE"			, cAlias1,STR0028 /*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Código"
TRCell():New( oSection1, "N3_CCONTAB"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_SUBCTA"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CLVL"			, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCUSTO"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection11 := TRSection():New( oSection1, STR0030, {cAlias1} )		//"Movimentos de Adiantamentos"
TRCell():New( oSection11, "N3_CBASE"		, cAlias1,STR0028 /*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Código"
TRCell():New( oSection11, "N3_ITEM"			, cAlias1,STR0027 /*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Item"
TRCell():New( oSection11, "N3_CCONTAB"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_CCUSTO"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N1_PROJETO"		, "SN1",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_AQUISIC"		, "SN3",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "VALOR"			,      ,STR0026 /*X3Titulo*/     ,PesqPict("SN3","N3_VORIG"+Str( mv_par11, 1 ),18,mv_par11)/*Picture*/,18/*Tamanho*/,/*lPixel*/, /* { || code-block de impressoa } */ ) // "Valor Adiatamento"
TRCell():New( oSection11, "N3_CDEPREC"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_CCDEPR"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_CCORREC"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_SUBCTA"		, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_CLVL"			, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Claudio D. de Souza º Data ³  23/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local oSection1  	:= oReport:Section(1)
Local oSection11 	:= oReport:Section(1):Section(1)
Local cChave
Local cQuery		:= "SN3"
Local cAliasSn1	:= "SN1"
Local cQuebra		:= ""
Local cWhere		:= ""
Local nOrder   := oSection1:GetOrder()
Local bFilter
Local bQuebra
Local bTexto := { || "" }
Local bValor
Local cNomeArq
Local nIndex 
Local aStru
Local cFilterUser 
Local aClassif := {}
Local cClassif := ""
Local lRealProv := .F.

/*
 * Verificação do campo para ativos de custo de provisão
 */
If Select("SN3") == 0
	DbSelectArea("SN3")	
EndIf

lRealProv := .T.

Do Case
Case nOrder != 4 .And. nOrder != 5
	cChave := SN3->(IndexKey(nOrder))
Case nOrder	== 4
	cChave := "N1_FILIAL + N1_PROJETO + N1_CBASE + N1_ITEM"
Case nOrder	== 5
	cChave := "N1_FILIAL + DTOS(N1_AQUISIC) + N1_CBASE + N1_ITEM"
EndCase	

If mv_par17 == 1
	aClassif := AdmGetClass()
	If Len( aClassif ) <= 0
		Return
	EndIf 	
EndIf	
	
cQuery 		:= GetNextAlias()
cAliasSn1	:= cQuery
cChave 	:= "%"+SqlOrder(cChave)+"%"
// Se nao considera itens baixados, seleciona apenas os itens em aberto
If mv_par16 == 2
	cWhere := "N3_BAIXA = '0' AND"
Endif	
	 
//Filtra Classificação Patrimonial
If mv_par17 == 1 .And. Len(aClassif) > 0
	cWhere += " N1_PATRIM IN " + FORMATCLAS(aClassif,.T.) + " AND "
Endif	
	
cFilterUser := oSection1:GetSqlExp("SN3")
	 
//Adiciona o Filtro do usuario, caso o mesmo seja informado
If !Empty(cFilterUser)
	cWhere := cWhere + cFilterUser + " AND "
Endif
	
If lRealProv .AND. MV_PAR18 == 2
	cWhere += " SN3.N3_ATFCPR IN ('2',' ') AND "
EndIf
	
cWhere   := "%" + cWhere + "%"
	
oSection1:BeginQuery()
	
BeginSql Alias cQuery
	SELECT 
		N3_FILIAL, N3_CBASE, N3_ITEM, N3_CCONTAB, N3_CCUSTO, N3_SUBCTA, N3_CLVL, N3_AQUISIC, N3_VORIG1, N3_VORIG2,
		N3_VORIG3, N3_VORIG4, N3_VORIG5, N3_VRCACM1, N3_AMPLIA1, N3_AMPLIA2, N3_AMPLIA3, N3_AMPLIA4, N3_AMPLIA5,
		N3_CDEPREC, N3_CCDEPR, N3_CCORREC, N1_FILIAL, N1_AQUISIC, N1_CBASE, N1_ITEM, N1_PROJETO
	FROM %table:SN3% SN3
		JOIN %table:SN1% SN1 ON
		SN1.N1_FILIAL = %xfilial:SN1% AND
		SN3.N3_CBASE = SN1.N1_CBASE AND
		SN3.N3_ITEM = SN1.N1_ITEM AND
		SN1.%notDel%
	WHERE
		SN3.N3_FILIAL = %xfilial:SN3% AND
		SN1.N1_AQUISIC >= %Exp:mv_par01% AND 
		SN1.N1_AQUISIC <= %Exp:mv_par02% AND 
		SN3.N3_CCONTAB >= %Exp:mv_par03% AND 
		SN3.N3_CCONTAB <= %Exp:mv_par04% AND 
		SN3.N3_CCUSTO 	>= %Exp:mv_par05% AND 
		SN3.N3_CCUSTO 	<= %Exp:mv_par06% AND 
		SN3.N3_CBASE 	>= %Exp:mv_par07% AND 
		SN3.N3_CBASE 	<= %Exp:mv_par08% AND 
		SN1.N1_PROJETO >= %Exp:mv_par09% AND 
		SN1.N1_PROJETO <= %Exp:mv_par10% AND 
		SN3.N3_SUBCTA	>= %Exp:mv_par12% AND 
		SN3.N3_SUBCTA	<= %Exp:mv_par13% AND 
		SN3.N3_CLVL 	>= %Exp:mv_par14% AND 
		SN3.N3_CLVL 	<= %Exp:mv_par15% AND 
		SN3.N3_TIPO = '03' AND
		%Exp:cWhere%
		SN3.%notDel%
	ORDER BY %Exp:cChave%
EndSql

oSection1:EndQuery()
oSection11:SetParentQuery()

oSection1:Cell("N1_PROJETO"):Disable()
oSection1:Cell("N1_AQUISIC"):Disable()
oSection1:Cell("N3_CBASE"):Disable()
oSection1:Cell("N3_CCONTAB"):Disable()
oSection1:Cell("N3_SUBCTA"):Disable()
oSection1:Cell("N3_CLVL"):Disable()
oSection1:Cell("N3_CCUSTO"):Disable()

Do Case
Case nOrder == 1
	bFilter	:= {|cParam| (cQuery)->N3_CBASE == cParam }
	bQuebra	:= {|| (cQuery)->N3_CBASE }
	bTexto 	:= { || STR0021 }  // " DO CODIGO BASE "
	oSection1:Cell("N3_CBASE"):Enable()
	oSection11:Cell("N3_CBASE"):Disable()
Case nOrder == 2
	bFilter	:= {|cParam| (cQuery)->N3_CCONTAB == cParam }
	bQuebra	:= {|| (cQuery)->N3_CCONTAB }	
	bTexto 	:= { || STR0022 }  // " DA CONTA CONTABIL "
	oSection1:Cell("N3_CCONTAB"):Enable()
	oSection11:Cell("N3_CCONTAB"):Disable()
Case nOrder == 3
	bFilter	:= {|cParam| (cQuery)->N3_CCUSTO == cParam }
	bQuebra	:= {|| (cQuery)->N3_CCUSTO }		
	bTexto := { || STR0025 } // " DO CENTRO DE CUSTO "
	oSection1:Cell("N3_CCUSTO"):Enable()
	oSection11:Cell("N3_CCUSTO"):Disable()
Case nOrder == 4
	bFilter	:= {|cParam| (cAliasSn1)->N1_PROJETO == cParam }
	bQuebra	:= {|| (cAliasSn1)->N1_PROJETO }
	oSection1:Cell("N1_PROJETO"):Enable()
	oSection11:Cell("N1_PROJETO"):Disable()
Case nOrder == 5
	bFilter	:= {|cParam| Dtoc((cAliasSn1)->N1_AQUISIC) == cParam }
	bQuebra	:= {|| Dtoc((cAliasSn1)->N1_AQUISIC) }
	oSection1:Cell("N1_AQUISIC"):Enable()
	oSection11:Cell("N3_AQUISIC"):Disable()
Case nOrder == 6
	bFilter	:= {|cParam| (cQuery)->N3_SUBCTA == cParam }
	bQuebra	:= {|| (cQuery)->N3_SUBCTA }		
	bTexto 	:= { || STR0023 }  // " DO ITEM CONTABIL "
	oSection1:Cell("N3_SUBCTA"):Enable()
	oSection11:Cell("N3_SUBCTA"):Disable()
Case nOrder == 7
	bFilter	:= {|cParam| (cQuery)->N3_CLVL == cParam }
	bQuebra	:= {|| (cQuery)->N3_CLVL }
	bTexto 	:= { || STR0024 } // " DA CLASSE DE VALOR "
	oSection1:Cell("N3_CLVL"):Enable()
	oSection11:Cell("N3_CLVL"):Disable()
EndCase

bValor := "{||" + 'N3_VORIG'+Str(mv_par11,1)+'+N3_AMPLIA'+Str(mv_par11,1)+If(mv_par11==1,'+N3_VRCACM'+Str(mv_par11,1),"") + "}"
bValor := &bValor
oSection11:Cell("VALOR"):SetBlock( bValor )
oSection11:Cell("N1_PROJETO"):SetBlock( { || (cAliasSn1)->N1_PROJETO } )
oSection11:Cell("N3_AQUISIC"):SetBlock( { || (cAliasSn1)->N1_AQUISIC } )

oSection1:Cell("N1_PROJETO"):SetBlock( { || (cAliasSn1)->N1_PROJETO } )
oSection1:Cell("N1_AQUISIC"):SetBlock( { || (cAliasSn1)->N1_AQUISIC } )

TRFunction():New(oSection11:Cell("VALOR"),,"SUM",,,, /* bAction */, .T. , .T. )

// Cria variável a ser usada para impressao do texto da quebra da secao
oSection11:OnPrintLine( { ||	cQuebra := Eval(bQuebra), .T. } )

// Forma o titulo da quebra, conforme a ordem escolhida
oSection11:SetTotalText({ ||  OemToAnsi(STR0016) + Eval(bTexto) + cQuebra } )
oSection11:SetTotalInLine(.F.)
oSection11:SetParentFilter(bFilter,bQuebra)

oSection1:Print()

Return Nil



