/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR110.CH"
#include "Protheus.ch"

Static lFWCodFil := .t.
STATIC lIsRussia	:= If(cPaisLoc$"RUS",.T.,.F.) // CAZARINI - Flag to indicate if is Russia location

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR110  ³ Autor ³ Wagner Xavier         ³ Data ³ 03.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relacao das aquisicoes                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe 	 ³ ATFR110                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR110

Local oReport
Local lRetorno	:= .T.
Local aArea		:= SM0->( GetArea() )
Local cFlAnt	:= cFilAnt  
/* GESTAO - inicio */
Private aSelFil	:= {}
/* GESTAO - fim */
Private aSelClass := {} //Filtro de classificações patrimoniais

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01            // a partir da data                  ³
//³ mv_par02            // ate a data                        ³
//³ mv_par03            // da conta                          ³
//³ mv_par04            // ate a conta                       ³
//³ mv_par05            // do centro de custo                ³
//³ mv_par06            // ate o centro de custo             ³
//³ mv_par07            // valores na moeda                  ³
//³ mv_par08            // Considera itens baixados			 ³
//³ mv_par09            // Considera filiais abaixo			 ³
//³ mv_par10            // filial de						 ³
//³ mv_par11            // filial ate						 ³
//³ mv_par12            // Considera itens (Norm, Ad, Ambos) ³ 
//³ mv_par13            // Selec Classif Patrimonial?        ³ 
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte( "AFR110" , .F. )


oReport := ReportDef()
	
// Verificacao de seguranca para executar versao R4
If Valtype(oReport) == 'O'
	oReport:PrintDialog()
Else
	lRetorno := .F.
EndIf
	
	
oReport := Nil


RestArea( aArea	)
cFilAnt	:= cFlAnt
Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³28/06/2006  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os   ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 30/03/99 ³ Alice         ³Reposicionar o relat¢rio. Conta com tamanho 20³±±
±±³ 20/04/99 ³ Alice         ³Alteracao de macro.                           ³±±
±±³ 28/08/09 ³ William Pires ³Revisao e correcao das funcoes que auxiliam a ³±±
±±³			 |		         |construcao do relatorio.						³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(cRespINI,cRespFIM,cCBASEINI,cItemINI,cCBaseFIM,cItemFIM)

Local oReport, oSection1
Local cReport 	:= "ATFR110"
Local cTitulo 	:= STR0003 // "Relacao dos bens adquiridos"
Local cDescri 	:= STR0001 + " " + STR0002 // "Este programa ira' emitir a rela‡„o das aquisi‡”es efetuadas dentro de um periodo."

// Definicao do Titulo do Relatorio no momento da impressao
Local bReport 	:= { |oReport|	cMoeda := Str(mv_par07,1),;
										oReport:SetTitle(oReport:Title() + OemToAnsi(STR0009)+; // " por "
										aOrd[oSection1:nOrder] + OemToAnsi(STR0010) +; //" em "
										Getmv("MV_MOEDA" + cMoeda) + OemToAnsi(STR0011) +; //" entre "
										DTOC(mv_par01) + OemToAnsi(STR0012) + DTOC(mv_par02)),; // " a "
									 	ReportPrint( oReport ) }
Local cMoeda 	:= ""
Local aOrd 		:= {}
Local aArea		:= GetArea()
Local aAreaSX3 	:= SX3->(GetArea())

// Forca a abertura do SN1
DbSelectArea("SN1")

aOrd := {OemToAnsi(STR0004),; // "Conta"
		 OemToAnsi(STR0005),; // "C Custo"
		 OemToAnsi(STR0006)}  // "Data Aquisicao"

cMoeda := Str(mv_par07,1)

If mv_par15 == 1 .And. Len( aSelFil ) <= 0 
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		Return
	EndIf 
EndIf


oReport  := TReport():New( cReport, cTitulo, "AFR110" , bReport, cDescri ) 

//Desabilita o botao GESTAO CORPORATIVA do relatório
oReport:SetUseGC(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0021, {"SN3","SN1" } , aOrd ) // "Dados do Bem"
TRCell():New( oSection1, "N3_CBASE"  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_ITEM"   	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_TIPO"   	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_TPSALDO" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_DESCRIC"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_AQUISIC"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_QUANTD" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_NFISCAL"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_CHAPA"	  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_GRUPO"	  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCUSTO" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_LOCAL"	  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_FORNEC" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_LOJA"   	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A2_NREDUZ" 	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_DINDEPR"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_TXDEPR"	, ,"Tx.An.Depr",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N3_VORIG" 	, ,"Val Orig",PesqPict("SN3","N3_VORIG" + cMoeda)/*Picture*/,TAMSX3("N3_VORIG" + cMoeda)[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "N3_VRDACM"	, ,"Depr Acum",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "N3_VRCACM"	, ,"Cor.Acm.",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "N3_DTBAIXA"  	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCONTAB"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCORREC"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CDEPREC"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCDEPR"	, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CDESP"		, ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection1:SetLineBreak()
oSection1:SetTotalInLine(.T.)
oSection1:SetHeaderPage(.T.)

oReport:SetLandScape()

RestArea(aAreaSx3)
RestArea(aArea)

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

Local oSection1 	:= oReport:Section(1)
Local cChave		:= ""
Local cChaveSQL		:= ""
Local cQuery 		:= ""
Local nOrder   		:= oSection1:nOrder
Local cMoeda		:= Str(mv_par07,1)
Local cWhere		:= ""       
Local cBemAnt		:= ""
Local bTitle 		:= { |cCampo| SX3->(DbSetOrder(2)), SX3->(MsSeek(cCampo)), X3Titulo() }
Local cFilDe 		:= ""
Local cFilAte		:= ""
Local oBreak1
Local oBreak2
Local bVOrig
Local oTotOrdem
Local oTotFil
Local oTotGer
Local cFilRep		:= ""
Local cFilBrk		:= "" 
Local cContaBrk		:= ""
Local cCustoBrk 	:= ""
Local dAquisBrk 	:= ""
Local cAliasSN3		:= "SN3"
Local cFiltro		:= ""
Local cFilterUser 	:= ""


// Verificação da classificação de Ativo se sofre depreciação
Local lAtClDepr 	:= .F.
Local cFilBkp
Local cChaveAux
Local lAtfCusPrv := AFXAtCsPrv()
/* GESTAO - inicio */
Local nX			:= 0
Local nLenSelFil	:= 0
Local nTamEmp		:= 0
Local lTotEmp		:= .F.
Local cTmpFil		:= ""
Local cNomEmp		:= ""
Local oBrkEmp		:= Nil
Local oTotEmp		:= Nil
/* GESTAO - fim */




If mv_par13 == 1
	aSelClass := AdmGetClass()	
	If Len( aSelClass ) <= 0
		Return
	EndIf 	
EndIf 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza registro inicial                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cChave := GetChave( nOrder )

// Retorna o o filtro escolhido pelo usuario
cUserFilter := oSection1:GetSqlExp() 
/*
GESTAO - inicio */
If MV_PAR15 == 1
	If Empty(aSelFil)
		If  FindFunction("AdmSelecFil")
			AdmSelecFil("AFR110",15,.F.,@aSelFil,"SN3",.F.)
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SN3")
			If Empty(aSelFil)
				Aadd(aSelFil,cFilAnt)
			Endif
		Endif
	Endif
Else
	Aadd(aSelFil,cFilAnt)
Endif
nLenSelFil := Len(aSelFil)
cFilDe := aSelFil[1]
cFilAte := aSelFil[nLenSelFil]
nTamEmp := Len(FWSM0LayOut(,1))
lTotEmp := .F.
/*
Verifico se e necessario a impressao de total por empresa: se as filiais selecionadas pertencem a empresas distintas. */
If nLenSelFil > 1
	lTotFil := .T.
	nX := 1 
	While nX < nLenSelFil .And. !lTotEmp
		nX++
		lTotEmp := !(Substr(aSelFil[nX-1],1,nTamEmp) == Substr(aSelFil[nX],1,nTamEmp))
	Enddo
Endif
/* GESTAO - fim
*/
// Efetua o filtro para o relatorio
U_Atf110Tmp( @cAliasSN3, @cChave, @cFiltro, cUserFilter, @cTmpFil )

// Montagem da quebra do relatorio
IF nOrder == 1
	SN3->(dbSetOrder(2))
	oBreak1 := TRBreak():New( oSection1, {|| (cAliasSN3)->(N3_FILIAL+N3_CCONTAB)}, STR0022 + " : " + (cAliasSN3)->N3_CCONTAB) // "Total da Conta"

ElseIf nOrder == 2
	SN3->(dbSetOrder(3))
	oBreak1 := TRBreak():New( oSection1, {|| (cAliasSN3)->(N3_FILIAL+N3_CCUSTO)}, STR0023 + " : " + (cAliasSN3)->N3_CCUSTO) // "Total do Centro de Custo"

ElseIf nOrder == 3
	oBreak1 := TRBreak():New( oSection1, {|| (cAliasSN3)->N3_FILIAL+DTOS((cAliasSN3)->N3_AQUISIC)}, STR0024 + " : " + DTOS((cAliasSN3)->N3_AQUISIC)) // "Total da Data de Aquisição"
	
End
oBreak1:OnPrintTotal( { || oReport:SkipLine()} )		/* GESTAO */

oBreak2:= TRBreak():New(oSection1, {|| (cAliasSN3)->(N3_FILIAL) }, {|| STR0025+(cAliasSN3)->(N3_FILIAL) } ) //"TOTAL FILIAL:
oBreak2:OnPrintTotal( { || oReport:SkipLine()} )		/* GESTAO */

oSection1:SetLineCondition({|| If(	(cAliasSN3)->(N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO) != cBemAnt,;
									(cBemAnt := (cAliasSN3)->(N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO), .T.),.F.) } )
          
TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2",(cAliasSN3)->N3_FILIAL)+(cAliasSN3)->(N1_FORNEC+N1_LOJA)})
// Verificação da classificação de Ativo se sofre depreciação
//lAtClDepr := Iif(FindFunction("AtClssVer"),AtClssVer((cAliasSN3)->N1_PATRIM),(cAliasSN3)->N1_PATRIM $ "NID")

bVOrig := { ||lAtClDepr:= AtClssVer( (cAliasSN3)->N1_PATRIM) ,;
				cFilBrk 	:= (cAliasSN3)->N3_FILIAL, cContaBrk 	:= (cAliasSN3)->N3_CCONTAB, cCustoBrk 	:= (cAliasSN3)->N3_CCUSTO,;
				cNomEmp := Substr((cAliasSN3)->N3_FILIAL,1,nTamEmp),;
			 	dAquisBrk 	:= (cAliasSN3)->N3_AQUISIC,;
				nValor:=Af110VOrig((cAliasSN3)->N3_FILIAL,cMoeda,(cAliasSN3)->N3_CBASE,(cAliasSN3)->N3_ITEM,(cAliasSN3)->N3_TIPO),;
				Iif(lAtClDepr .OR. (cAliasSN3)->N1_PATRIM $ " P",(cAliasSN3)->&("N3_VORIG"+cMoeda),(cAliasSN3)->&("N3_VORIG"+cMoeda)*(-1)) }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas com os campos das tabelas A2 e N1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cAliasSN3 == 'SN3'
	oSection1:Cell("A2_NREDUZ" 	):SetBlock( {|| SA2->A2_NREDUZ  	})
	oSection1:Cell("N3_DTBAIXA" ):SetBlock( {|| (cAliasSN3)->N3_DTBAIXA  		})
	oSection1:Cell("N1_DESCRIC"	):SetBlock( {|| SN1->N1_DESCRIC		})
	oSection1:Cell("N1_QUANTD" 	):SetBlock( {|| SN1->N1_QUANTD 		})
	oSection1:Cell("N1_NFISCAL"	):SetBlock( {|| SN1->N1_NFISCAL		})
	oSection1:Cell("N1_CHAPA"	):SetBlock( {|| SN1->N1_CHAPA		})
	oSection1:Cell("N1_GRUPO"	):SetBlock( {|| SN1->N1_GRUPO		})
	oSection1:Cell("N1_LOCAL"	):SetBlock( {|| SN1->N1_Local		})
	oSection1:Cell("N1_FORNEC" 	):SetBlock( {|| SN1->N1_FORNEC 		})
	oSection1:Cell("N1_LOJA"   	):SetBlock( {|| SN1->N1_LOJA   		})
Else
	oSection1:Cell("A2_NREDUZ" 	):SetBlock( {|| SA2->A2_NREDUZ })  
	oSection1:Cell("N3_DTBAIXA" ):SetBlock( {|| (cAliasSN3)->N3_DTBAIXA })
	oSection1:Cell("N1_DESCRIC"	):SetBlock( {|| (cAliasSN3)->N1_DESCRIC})
	oSection1:Cell("N1_QUANTD" 	):SetBlock( {|| (cAliasSN3)->N1_QUANTD })
	oSection1:Cell("N1_NFISCAL"	):SetBlock( {|| (cAliasSN3)->N1_NFISCAL})
	oSection1:Cell("N1_CHAPA"	):SetBlock( {|| (cAliasSN3)->N1_CHAPA	})
	oSection1:Cell("N1_GRUPO"	):SetBlock( {|| (cAliasSN3)->N1_GRUPO	})
	oSection1:Cell("N1_LOCAL"	):SetBlock( {|| (cAliasSN3)->N1_Local	})
	oSection1:Cell("N1_FORNEC" 	):SetBlock( {|| (cAliasSN3)->N1_FORNEC })
	oSection1:Cell("N1_LOJA"   	):SetBlock( {|| (cAliasSN3)->N1_LOJA   })
EndIf

oSection1:Cell("N3_TXDEPR"):SetTitle( FWX3Titulo("N3_TXDEPR"+cMoeda) )
oSection1:Cell("N3_VORIG"):SetTitle( FWX3Titulo("N3_VORIG"+cMoeda) )
oSection1:Cell("N3_VRDACM"):SetTitle ( FWX3Titulo("N3_VRDACM"+cMoeda) )
oSection1:Cell("N3_VRCACM"):SetTitle ( FWX3Titulo("N3_VRCACM"+cMoeda) )



oSection1:Cell("N3_CBASE"  	):SetBlock( {|| (cAliasSN3)->N3_CBASE  	})
oSection1:Cell("N3_ITEM"   	):SetBlock( {|| (cAliasSN3)->N3_ITEM   	})
oSection1:Cell("N3_TIPO"   	):SetBlock( {|| (cAliasSN3)->N3_TIPO   	})
oSection1:Cell("N3_TPSALDO" ):SetBlock( {|| (cAliasSN3)->N3_TPSALDO   	})
oSection1:Cell("N3_AQUISIC"	):SetBlock( {|| (cAliasSN3)->N3_AQUISIC	})
oSection1:Cell("N3_CCUSTO" 	):SetBlock( {|| (cAliasSN3)->N3_CCUSTO 	})
oSection1:Cell("N3_DINDEPR"	):SetBlock( {|| (cAliasSN3)->N3_DINDEPR	})
oSection1:Cell("N3_TXDEPR"	):SetBlock( {|| (cAliasSN3)->&("N3_TXDEPR"+cMoeda)})
oSection1:Cell("N3_VORIG" 	):SetBlock( {|| (cAliasSN3)->&("N3_VORIG" +cMoeda)})
oSection1:Cell("N3_VRDACM"	):SetBlock( {|| (cAliasSN3)->&("N3_VRDACM"+cMoeda)})
oSection1:Cell("N3_VRCACM"	):SetBlock( {|| (cAliasSN3)->&("N3_VRCACM"+cMoeda)})
oSection1:Cell("N3_CCONTAB"	):SetBlock( {|| (cAliasSN3)->N3_CCONTAB	})
oSection1:Cell("N3_CCORREC"	):SetBlock( {|| (cAliasSN3)->N3_CCORREC	})
oSection1:Cell("N3_CDEPREC"	):SetBlock( {|| (cAliasSN3)->N3_CDEPREC	})
oSection1:Cell("N3_CCDEPR"	):SetBlock( {|| (cAliasSN3)->N3_CCDEPR 	})
oSection1:Cell("N3_CDESP"	):SetBlock( {|| (cAliasSN3)->N3_CDESP		})

oSection1:SetLineBreak()

oBreak1:SetTotalText( { ||  Iif(nOrder == 1, STR0022+" : "+cContaBrk, Iif(nOrder == 2, STR0023+" : "+cCustoBrk, STR0024+" : "+DTOC(dAquisBrk)))} )
 
oBreak2:SetTotalText( { ||  STR0025+cFilBrk } )

//oTotOrdem	:= TRFunction():New(oSection1:Cell("N3_VORIG")	,, "SUM"	,oBreak1 	,,,(cAliasSN3 + "->N3_VORIG"  + cMoeda)		,.F.,.F.,.F.,oSection1)
//oTotFil		:= TRFunction():New(oSection1:Cell("N3_VORIG")	,, "SUM"	,oBreak2 	,,,(cAliasSN3 + "->N3_VORIG"  + cMoeda)		,.F.,.F.,.F.,oSection1)
oTotOrdem	:= TRFunction():New(oSection1:Cell("N3_VORIG" )	,, "SUM"	,oBreak1 	,,,bVOrig		,.F.,.F.,.F.,oSection1)
oTotFil		:= TRFunction():New(oSection1:Cell("N3_VORIG" )	,, "SUM"	,oBreak2 	,,,bVOrig		,.F.,.F.,.F.,oSection1)
oTotGer		:= TRFunction():New(oSection1:Cell("N3_VORIG" )	,, "SUM"	,			,,,	bVOrig	,.F.,.T.)
/* GESTAO - inicio */
/* Desabilito o subtotal por filial, quando apenas uma for selecionada para o relatorio. */
If nLenSelFil <= 1 
	oTotFil:Disable()
Endif
/*Crio o total por empresa. */
If lTotEmp
	oBrkEmp := TRBreak():New(oSection1,{|| Substr((cAliasSN3)->N3_FILIAL,1,nTamEmp)},{|| STR0026 + " " + cNomEmp})		//"Total Empresa"
	oBrkEmp:OnPrintTotal( { || oReport:SkipLine(2)} )
	oTotEmp := TRFunction():New(oSection1:Cell("N3_VORIG"),,"SUM",oBrkEmp,,,bVOrig,.F.,.F.,.F.,oSection1)
Endif
/* GESTAO - fim
*/
oReport:SetMeter(RecCount())                  
oReport:SetTotalText(STR0017) //"TOTAL GERAL: "
oReport:SetTotalInLine(.F.)

	cFilBkp := cFilAnt
	If nOrder == 3
		cChaveAux := StrTran(cChave, ",", "+")
		cChaveAux := StrTran(cChaveAux, "N3_AQUISIC", "DTOS(N3_AQUISIC)")
	Else
		cChaveAux := StrTran(cChave, ",", "+")    //Necessario pois vai executar macro da expressao contida em cChave
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:Init()
	While (cAliasSN3)->(!Eof())
		If oReport:Cancel()
			Exit
		EndIf
		
		cFilRep := (cAliasSN3)->N3_FILIAL
		If FwModeAccess("SN3",3) == "E"
			cFilAnt := (cAliasSN3)->N3_FILIAL
		EndIf
		While (cAliasSN3)->(!Eof()) .And. (cAliasSN3)->N3_FILIAL == cFilRep
			cQuebra := (cAliasSN3)->(&cChaveAux)
			While (cAliasSN3)->(!Eof()) .And. (cAliasSN3)->(&cChaveAux) == cQuebra
                // Necessario para imprimir campos adicionados pelo usuario em tempo de execucao
				SN3->( DBGOTO( (cAliasSN3)->RECNOSN3 ) )
				SN1->( DBGOTO( (cAliasSN3)->RECNOSN1 ) )

				oSection1:PrintLine()
				(cAliasSN3)->(DbSkip())
			EndDo
		EndDo
		
		oReport:IncMeter()
	EndDo
	oSection1:Finish()
	cFilAnt := cFilBkp
	/*
	GESTAO - inicio */
	If !Empty(cTmpFil)
		CtbTmpErase(cTmpFil)
	Endif
	/* GESTAO - fim 	*/

	oSection1 := Nil

Return Nil                                                             



/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ AFR110Filt ³ Autor ³ Cesar C S Prado       ³ Data ³ 03.08.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Filtra indice alternativo no periodo solicitado              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Void U_AFR110Filtro()                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AFR110Filtro()
Local cFiltro
Local lAtfCusPrv := AFXAtCsPrv()

Local cTypes10	:= IIF(lIsRussia,"*" + AtfNValMod({1}, "*"),"") // CAZARINI - 29/03/2017 - If is Russia, add new valuations models - main models
cFiltro := 'N3_FILIAL == "'  + xFilial("SN3")  + '" .And. '
cFiltro += 'DTOS(N3_AQUISIC) >= "' + DtoS( mv_par01) + '" .And. '
cFiltro += 'DTOS(N3_AQUISIC) <= "' + DtoS( mv_par02) + '"  '
If mv_par12 == 1 // Itens normais
	cFiltro += '.AND. N3_TIPO $ "01*10' + cTypes10 + '" ' 
Endif	
If mv_par12 == 2 // Itens Adiantamentos
	cFiltro += '.AND. N3_TIPO == "03" '
Endif	
If mv_par12 == 3 // Itens normais e adiantamentos
	cFiltro += '.AND. (N3_TIPO $ "01*10' + cTypes10 + '" .Or. N3_TIPO == "03") '
Endif	
                 
If mv_par13 == 1 // Filtra classificação patrimonial
	If Len(aSelClass) > 0
		cFiltro += ' .And. (N1_PATRIM $ ' +  FormatClass(aSelClass,.F.) +  ')'
	EndIf
Endif	

If lAtfCusPrv .And. MV_PAR14 == 2
	cFiltro += " .And. SN3.N3_ATFCPR <> '1' "
EndIf 

Return cFiltro


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Af110VOrig³ Autor ³ Claudio D. de Souza   ³ Data ³ 23/07/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o valor original do bem                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ ATFR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Af110VOrig(cFilSN3,cMoeda,cBase,cItem,cTipo)
Local aAreaSn3 := SN3->(GetArea())
Local nVOrig := 0
                                        
SN3->(DbSetOrder(1))
SN3->(MsSeek(cFilSN3+cBase+cItem+cTipo))

While SN3->(!Eof()) .And. SN3->(N3_FILIAL+N3_CBASE+N3_ITEM+SN3->N3_TIPO) == cFilSN3+cBase+cItem+cTipo
	nVOrig += SN3->&("N3_VORIG"+cMoeda)
	SN3->(DbSkip())
End			
SN3->(RestArea(aAreaSn3))

Return nVOrig




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Atf110Tmp ºAutor  ³Renato		         º Data ³  21/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de retorno do conteudo a ser impresso pelo relatorioº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR110                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Atf110Tmp( cAliasTMP, cChave, cFiltro, cUserFilter, cTmpFil )
Local aArea		:= GetArea()
Local cCampos	:= ""
Local cQuery	:= ""
Local cFilDe	:= ""
Local cFilAte	:= ""
Local cTipoN3	:= "'01','10','12','16','17'"
Local aStruSn1	:= {}
Local aStruSn3	:= {}
Local nI		:= 0
Local lAtfCusPrv := AFXAtCsPrv()
Local cTypesNM	:= IIF(lIsRussia,"|" + AtfNValMod({1,2}, "|"),"") // CAZARINI - 10/04/2017 - If is Russia, add new valuations models - main and recoverable models
Local aTypesNM	:= {}
Local nTypesNM	:= 0
DEFAULT cChave		:= ""
DEFAULT cFiltro		:= ""
/* GESTAO - inicio */
DEFAULT cTmpFil	:= ""
/* GESTAO - fim */
*/
If lIsRussia // CAZARINI - Flag to indicate if is Russia location
	aTypesNM := Separa(cTypesNM, '|', .f.)
	
	If len(aTypesNM) > 0
		For nTypesNM := 1 to len(aTypesNM)
			cTipoN3 += ",'" + aTypesNM[nTypesNM] + "'"
		Next nTypesNM
	Endif
Endif

If cPaisLoc == "COL"
	cTipoN3	:= "'01','50','51','52','53','54'"
EndIf

cAliasTMP := "cAtfTmp"

If Select( cAliasTMP ) > 0
	DbSelectArea( cAliasTMP )
	DbCloseArea()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis ref a filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/* 
GESTAO - inicio */
If Empty(aSelFil)
	If mv_par09 == 2
		cFilDe  := cFilAnt
		cFilAte := cFilAnt
	ELSE
		cFilDe := mv_par10	// Todas as filiais
		cFilAte:= mv_par11
	Endif
Else
	cFilDe := aSelFil[1]
	cFilAte := aSelFil[Len(aSelFil)]
Endif
/* GESTAO - fim */

	// montagem da query para SN1
	aStruSn1 := SN1->( dbStruct() )
	For nI := 1 to Len( aStruSn1 )
		If !Empty( cCampos )
			cCampos += ", "
		Endif
	
		cCampos += aStruSn1[nI,1]
	Next ni	  		  	
	
	// montagem da query para SN3
	aStruSn3 := SN3->( dbStruct() )
	For nI := 1 to Len( aStruSn3 )
		If !Empty( cCampos )
			cCampos += ", "
		Endif
	
		cCampos += aStruSn3[nI,1]
	Next ni	  		  	
	
	cQuery := "SELECT " 
	cQuery += cCampos + ", SN3.R_E_C_N_O_ RECNOSN3 , SN1.R_E_C_N_O_ RECNOSN1 "
	cQuery += " FROM " + RetSqlName( "SN3" ) + " SN3"

	cQuery += " 	LEFT JOIN " + RetSqlName( "SN1" ) + " SN1 ON "
	cQuery += " 		SN1.N1_FILIAL  = SN3.N3_FILIAL AND " 
	CqUERY += "			SN1.N1_CBASE   = SN3.N3_CBASE AND "
	cQuery += " 		SN1.N1_ITEM    = SN3.N3_ITEM AND 
	cQuery += "			SN1.D_E_L_E_T_ <> '*'"

	// clausulas do filtro
	cQuery += " WHERE "

	// faixa de filiais
	/*
	GESTAO - inicio */
	If Empty(aSelFil)
		If !Empty( cFilDe )
			cQuery += "SN3.N3_FILIAL >= '" + xFilial("SN3",cFilDe) + "' AND "
		Endif
		If !Empty( cFilAte )
			cQuery += "SN3.N3_FILIAL <= '" + xFilial("SN3",cFilAte)+ "' AND "
		Endif
	Else
		cQuery += " SN3.N3_FILIAL " + GetRngFil( aSelFil, "SN3", .T., @cTmpFil) + " AND "
	Endif
	/* GESTAO - fim
	*/
	// faixa de contas contabeis
	If !Empty( mv_par03 )
		cQuery += "SN3.N3_CCONTAB >= '" + mv_par03 + "' AND "
	Endif
	If !Empty( mv_par04 )
		cQuery += "SN3.N3_CCONTAB <= '" + mv_par04 + "' AND "
	Endif

	// faixa de centros de custo
	If !Empty( mv_par05 )
		cQuery += "SN3.N3_CCUSTO  >= '" + mv_par05 + "' AND "
	Endif
	If !Empty( mv_par06 )
		cQuery += "SN3.N3_CCUSTO  <= '" + mv_par06 + "' AND "
	Endif

	// faixa de aquisicoes
	If !Empty( mv_par01 )
		cQuery += "SN3.N3_AQUISIC >= '" + DTOS( mv_par01 ) + "' AND "
	Endif
	If !Empty( mv_par02 )
		cQuery += "SN3.N3_AQUISIC <= '" + DTOS( mv_par02 ) + "' AND "
	Endif
		
	// faixa de itens
	IF mv_par12 == 1 // Itens normais
		cQuery += "SN3.N3_TIPO in ( " + cTipoN3 + " ) AND "
	ElseIf mv_par12 == 2 // Itens Adiantamentos
		cQuery += "SN3.N3_TIPO = '03' AND "
	ElseIf mv_par12 == 3 // Itens normais e adiantamentos
		cQuery += "(SN3.N3_TIPO in ( " + cTipoN3 + " ) OR SN3.N3_TIPO = '03') AND "
	Endif
	
	//Filtra classificações patrimoniais
	IF mv_par13 == 1 // Itens normais
		If Len(aSelClass) > 0
			cQuery +=  "SN1.N1_PATRIM in  " +  FormatClass(aSelClass,.T.) +  "  And "
		EndIf
	EndIf	
	
	If lAtfCusPrv .And. MV_PAR14 == 2
		cQuery += "  SN3.N3_ATFCPR <> '1' AND  "
	EndIf


	// Se nao considera itens baixados, filtra na query
	If mv_par08 == 2
		cQuery += "SN3.N3_BAIXA = '0' AND "
	Endif	

	// filtro dos nao deletados
	cQuery += "SN3.D_E_L_E_T_ <> '*'"

	// efetua o filtro do usuario	
	If !Empty( cUserFilter )
		cQuery += " AND " +  cUserFilter 
	Endif

	// ordem baseada na chave passada
	If !Empty( cChave )
		cQuery += " ORDER BY " + STRTRAN( cChave , "+" , "," )
	Endif
                                   
	//retira os espacos em branco da query e transforma no padrao ANSI
	cQuery := ChangeQuery( cQuery )
		
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasTMP, .T., .T.)
	
	// reconstruo o tipo do campo, conforme estrutura da tabela
	For nI := 1 to Len( aStruSn1 )
		If aStruSn1[nI,2] != "C"
			TCSetField( cAliasTMP, aStruSn1[nI,1] /*Nome*/, aStruSn1[nI,2]/*tipo*/,aStruSn1[nI,3]/*tamanho*/,aStruSn1[nI,4] /*precisao*/ )	
		Endif
	Next
	For nI := 1 to Len( aStruSn3 )
		If aStruSn3[nI,2] != "C" 
			TCSetField( cAliasTMP, aStruSn3[nI,1] /*Nome*/, aStruSn3[nI,2]/*tipo*/,aStruSn3[nI,3]/*tamanho*/,aStruSn3[nI,4] /*precisao*/ )	
		Endif
	Next

	If Select( cAliasTMP ) <= 0
		Conout( 'Erro na montagem da query'	+ CRLF + cQuery )
	Endif     
   
RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR110   ºAutor  ³Microsiga           º Data ³  10/20/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetChave( nOrder )
/*Local Declarations*/
Local lResult	:= .T.
Local cChave	:= ""

/*Initialization*/
Default nOrder	:= 1       

/*Implementation*/
If lResult
	IF		nOrder == 1
		cChave	:= "N3_FILIAL,N3_CCONTAB,N3_CBASE,N3_ITEM"
	ElseIF	nOrder == 2
		cChave	:= "N3_FILIAL,N3_CCUSTO,N3_CBASE,N3_ITEM"
	ElseIF	nOrder == 3
		cChave	:= "N3_FILIAL,N3_AQUISIC,N3_CBASE,N3_ITEM"
	EndIf
Endif

Return ( cChave )






