/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ IMPORTANTE: A vari vel aFim que est  sendo utilizada como    ³
//³ private, dever  ser passada por parƒmetro em implementa‡”es  ³
//³ futuras nas fun‡”es a150calrr e a150currr                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#INCLUDE "QMTR210.CH"
#Include "PROTHEUS.CH"
#Include "report.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR210  ³ Autor ³ Cicero Cruz           ³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Listagem Geral de Resultados de R&R                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR210(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QMTR210()
Local oReport

Private cInstAnt  := ""
Private nTamC := QA_NUMDEC(QM4->QM4_LIE)
Private aFIM := {}
Private nCtUser := 0
Private aTabela := {}
Private lExist := .T.
Private nRefere := 0
Private nVlrRef	:= 0
Private aUseRef := {}
Private nVlRef := 0
Private nPosEns  // Posicao do Ensaiador na aCols
Private nPosCic  // Posicao do Ciclo na aCols
Private nPosPec  // Posicao da Peca na aCols
Private nPosAtr  // Posicao da Coleta do Atributo na aCols
Private nPosali  // Posicao do Alias do Arquivo
Private nPosrec  // Posicao do Recno do registro
Private bCampo := { |nField| Field(nField) }
Private cQM5Tmp
Private cQM5ATP
Private cAliasQM2 := "QM2"
Private cAliasQM4 := "QM4"
Private lRelR3    := .T.
Private cPerg		:="QMR210"

If TRepInUse()
	// Interface de impressao
	Pergunte(cperg,.F.)
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	lRelR3:= .F.
	U_QMTR210R3()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Cicero Cruz           ³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QMTR210                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport
Local oSection1
Local aOrdem    := {}

/* Criacao do objeto REPORT
DEFINE REPORT oReport NAME <Nome do relatorio> ;
					  TITLE <Titulo> 		   ;
					  PARAMETER <Pergunte>     ;
					  ACTION <Bloco de codigo que sera executado na confirmacao da impressao> ;
					  DESCRIPTION <Descricao>
*/
DEFINE REPORT oReport NAME "QMTR210" TITLE STR0005 PARAMETER "QMR210" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION STR0001+" "+STR0002

oReport:SetLandscape()

aOrdem := {}
/*
Criacao do objeto secao utilizada pelo relatorio
DEFINE SECTION  <Nome> OF <Objeto TReport que a secao pertence>  ;
       TITLE  <Descricao da secao>                               ;
       TABLES <Tabelas a ser usadas>                             ;
       ORDERS <Array com as Ordens do relatorio>                 ;
       LOAD CELLS            									 ; // Carrega campos do SX3 como celulas
       TOTAL TEXT //Carrega ordens do Sindex
*/
DEFINE SECTION oSection OF oReport TITLE STR0005 TABLES "QM2","QM4" //ORDERS aOrdem

/*
DEFINE CELL NAME <Nome da celula do relatorio>                          ;
            OF <Objeto TSection que a secao pertence>                   ;
            ALIAS <Nome da tabela de referencia da celula>              ;
            TITLE <Titulo da celula>                                    ;
            Picture <Picture>                                           ;
            SIZE <Tamanho> 												;
            PIXEL 														;//Informe se o tamanho esta em pixel
            BLOCK <Bloco de codigo para impressao>
*/

DEFINE CELL NAME "QM2_INSTR"  OF oSection ALIAS "QM2" BLOCK {|| nCtUser := 0,QM2_INSTR }
DEFINE CELL NAME "QM2_REVINS" OF oSection ALIAS "QM2"
DEFINE CELL NAME "QM2_TIPO"   OF oSection ALIAS "QM2" TITLE OemToAnsi(STR0010)
DEFINE CELL NAME "QM2_DEPTO"  OF oSection ALIAS "QM2"
DEFINE CELL NAME "QM4_DATA"   OF oSection ALIAS "QM4"
DEFINE CELL NAME "QM4_NENSR"  OF oSection ALIAS "QM4"
DEFINE CELL NAME "QM4_NCICLO" OF oSection ALIAS "QM4"
DEFINE CELL NAME "QM4_NPECAS" OF oSection ALIAS "QM4"
DEFINE CELL NAME "PVE"        OF oSection Title "% V.E."            BLOCK {|| U_MTR210_PVE()}
DEFINE CELL NAME "PVA"        OF oSection Title "% V.A."            BLOCK {|| Iif(&(cAliasQM4+"->QM4_TIPO") $ "EP", U_MTR210_PVA(), "")}
DEFINE CELL NAME "PVP"        OF oSection Title "% V.P."            BLOCK {|| Iif(&(cAliasQM4+"->QM4_TIPO") $ "EP", U_MTR210_PVP(), "")}
DEFINE CELL NAME "PRR"        OF oSection Title "% R&R "            BLOCK {|| U_MTR210_PRR()}
DEFINE CELL NAME "PRT"        OF oSection Title "% R&R Tol."        BLOCK {|| U_MTR210_PRT()}
DEFINE CELL NAME "NDC"        OF oSection Title "  NDC "    SIZE 5  BLOCK {|| Iif(&(cAliasQM4+"->QM4_TIPO") $ "EP", U_MTR210_NDC(), "")}
DEFINE CELL NAME "RES"        OF oSection Title "Resultado" SIZE 12 BLOCK {|| U_MTR210_RES()}

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³PrintRepor³ Autor ³ Cicero Cruz           ³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao dos Textos	Reprogramacao R4	 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTr210													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport( oReport )
Local oSection1 := oReport:Section(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()

cAliasQM2 := GetNextAlias()
cAliasQM4 := cAliasQM2

cChave := "%QM4_FILIAL, QM4_INSTR, QM4_REVINS, QM4_DATA%"

BeginSql Alias cAliasQM2

SELECT QM4.QM4_FILIAL, QM4.QM4_INSTR, QM4.QM4_REVINS, QM4.QM4_DATA, QM4.QM4_NENSR, QM4.QM4_NCICLO, QM4.QM4_NPECAS, QM4.QM4_TIPO, QM4.QM4_HORA, QM4.QM4_LIE,
	   QM4.QM4_LSE, QM2.QM2_FILIAL, QM2.QM2_INSTR, QM2.QM2_REVINS, QM2.QM2_REVINV, QM2.QM2_DEPTO, QM2.QM2_TIPO, QM2.QM2_RESP, QM2.QM2_FABR, QM2.QM2_STATUS,
	   QM4.QM4_TPMSA,  QM4.QM4_TPATR, QM4.QM4_TOLESP
 	FROM %table:QM2% QM2, %table:QM4% QM4
	WHERE QM4.QM4_FILIAL = %xFilial:QM2%  AND
		  QM2.QM2_FILIAL = QM4.QM4_FILIAL AND
		  QM2.QM2_INSTR  = QM4.QM4_INSTR  AND
		  QM2.QM2_REVINS = QM4.QM4_REVINS AND
		  QM2.QM2_INSTR   BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
		  QM4.QM4_DATA    BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% AND
		  QM2.QM2_DEPTO   BETWEEN %Exp:mv_par05% AND %Exp:mv_par06% AND
		  QM2.QM2_TIPO    BETWEEN %Exp:mv_par07% AND %Exp:mv_par08% AND
		  QM2.QM2_FABR    BETWEEN %Exp:mv_par11% AND %Exp:mv_par12% AND
		  QM2.QM2_RESP    BETWEEN %Exp:mv_par09% AND %Exp:mv_par10% AND
	      QM2.%notDel%
 		ORDER BY %Exp:cChave%
EndSql
oSection1:EndQuery()

oSection1:SetLineCondition({|| U_MTR210_CON()})

oSection1:Print()
A150DelTmp()
A150DelATP()
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR210_PVE³ Autor ³ Cicero Cruz			³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR210_PVE(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR210_PVE()
Local cRet := ""
M->QM4_INSTR	:= &(cAliasQM2+"->QM2_INSTR")
M->QM4_REVINS	:= &(cAliasQM2+"->QM2_REVINS")
M->QM4_DATA		:= &(cAliasQM4+"->QM4_DATA")
M->QM4_HORA		:= &(cAliasQM4+"->QM4_HORA")
M->QM4_NENSR	:= &(cAliasQM4+"->QM4_NENSR")
M->QM4_NCICLO	:= &(cAliasQM4+"->QM4_NCICLO")
M->QM4_TIPO		:= &(cAliasQM4+"->QM4_TIPO")
M->QM4_NPECAS	:= &(cAliasQM4+"->QM4_NPECAS")
M->QM4_LIE		:= &(cAliasQM4+"->QM4_LIE")
M->QM4_LSE		:= &(cAliasQM4+"->QM4_LSE")
M->QM4_TPMSA	:= &(cAliasQM4+"->QM4_TPMSA")
M->QM4_TPATR	:= &(cAliasQM4+"->QM4_TPATR")
M->QM4_TOLESP	:= &(cAliasQM4+"->QM4_TOLESP")
If AllTrim(FunName()) <> AllTrim("QMTA150")
	ALTERA := .F.
	INCLUI := .F.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula R&R                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFim := {}
lNoImprs := .T.
U_R210CalRR()
If &(cAliasQM4+"->QM4_TIPO") $ "EP"
	cRet := IIf(Len(aFim)>0,Alltrim(Str(aFim[1,1],Len(Str(aFim[1,1])),nTamC)),"0.00")
EndIf
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR210_PVA³ Autor ³ Cicero Cruz			³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR210_PVA(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR210_PVA()
Local cRet := ""
cRet := IIf(Len(aFim)>0,Alltrim(Str(aFim[1,2],Len(Str(aFim[1,2])),nTamC)),"0.00")
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR210_PVP³ Autor ³ Cicero Cruz			³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR210_PVP(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR210_PVP()
Local cRet := ""
cRet := IIf(Len(aFim)>0,Alltrim(Str(aFim[1,4],Len(Str(aFim[1,4])),nTamC)),"0.00")
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR210_PRR³ Autor ³ Cicero Cruz			³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR210_PRR(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR210_PRR()
Local cRet := ""
If &(cAliasQM4+"->QM4_TIPO") $ "EP"
	cRet := IIf(Len(aFim)>0,Alltrim(Str(aFim[1,3],Len(Str(aFim[1,3])),nTamC)),"0.00")
Elseif &(cAliasQM4+"->QM4_TIPO") == "C"
	cRet := IIf(Len(aFim)>0,Alltrim(Str(aFim[1,4],Len(Str(aFim[1,4])),nTamC)),"0.00")
EndIf
Return cRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR210_PRRT³ Autor ³ Leonardo Quintania   ³ Data ³ 29.06.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR210_PRT(void)										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR210_PRT()
Local cRet := ""
If (&(cAliasQM4+"->QM4_TIPO")>"2").AND. &(cAliasQM4+"->QM4_TIPO") $ "P"
	cRet := IIf(Len(aFim)>0,Alltrim(Str(aFim[1,25],Len(Str(aFim[1,25])),nTamC)),"0.00")
EndIf
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR210_PVP³ Autor ³ Cicero Cruz			³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR210_PVP(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR210_NDC()
Local cRet := "0.00"
If &(cAliasQM4+"->QM4_TPMSA") == "1" .OR. &(cAliasQM4+"->QM4_TIPO")>"2"
   cRet := IIf(Len(aFim)>0,Alltrim(Str(aFim[1,24],Len(Str(aFim[1,24])),nTamC)),"0.00")
Endif
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR210_RES³ Autor ³ Cicero Cruz			³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR210_RES(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR210_RES()
Local cRet := ""
If &(cAliasQM4+"->QM4_TIPO") == "C"
	cRet := IIf(Len(aFim)>0,Alltrim(aFim[1,6])," ")
ElseIf &(cAliasQM4+"->QM4_TIPO") == "A"
	If aFim[1,1] == "N"
		cRet := OemToAnsi(STR0009)
	Else
		cRet := OemToAnsi(STR0008)
	Endif
Else
	cRet := IIf(Len(aFim)>0,Alltrim(aFim[1,5])," ")
EndIf

Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR210_CON³ Autor ³ Cicero Cruz			³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR210_CON(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR210_CON()
Local lRet := .T.

dbSelectArea( "QM4" )
dbSetOrder(1)
dbSeek(xFilial()+&(cAliasQM2+"->QM2_INSTR")+&(cAliasQM2+"->QM2_REVINS"))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica os instrumentos.                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !(&(cAliasQM2+"->QM2_INSTR") >= mv_par01 .and. &(cAliasQM2+"->QM2_INSTR") <= mv_par02)
	lRet := .F.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica os per¡odos.                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRet .AND. &(cAliasQM4)->(!Eof())
	If ( &(cAliasQM4+"->QM4_DATA") < mv_par03 ) .or. ( &(cAliasQM4+"->QM4_DATA") > mv_par04 )
		lRet := .F.
	EndIf
	If &(cAliasQM4+"->QM4_TIPO") == "A"
		If &(cAliasQM4+"->QM4_TPMSA") <> "2"
			lRet := .F.
		EndIf
	Endif
Elseif &(cAliasQM4)->(Eof())
	lRet := .F.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica os departamentos.                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRet
	If ( &(cAliasQM2+"->QM2_DEPTO") < mv_par05 .or. &(cAliasQM2+"->QM2_DEPTO") > mv_par06 )
		lRet := .F.
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se n„o ‚ a familia selecionada n„o Imprime. 					³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRet
	If ( &(cAliasQM2+"->QM2_TIPO") < mv_par07 .or. &(cAliasQM2+"->QM2_TIPO") > mv_par08 )
		lRet := .F.
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ N„o ‚ o usu rio selecionado. 									³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRet
	If ( &(cAliasQM2+"->QM2_RESP") < mv_par09 .or. &(cAliasQM2+"->QM2_RESP") > mv_par10 )
		lRet := .F.
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ N„o ‚ o fabricante selecionado. 							    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRet
	If ( &(cAliasQM2+"->QM2_FABR") < mv_par11 .and. &(cAliasQM2+"->QM2_FABR") > mv_par12 )
		lRet := .F.
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se status do instrumento esta ativo						  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If	lRet
	If !QMTXSTAT(&(cAliasQM2+"->QM2_STATUS"))
		lRet := .F.
	EndIf
EndIF

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR210  ³ Autor ³ Wanderley Goncalves   ³ Data ³ 04.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Listagem Geral de Resultados de R&R                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR210(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR210R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1	:=OemToAnsi( STR0001 ) // "Este programa ira emitir a"
Local cDesc2	:=OemToAnsi( STR0002 ) // "Listagem Geral de Resultados de R&R"
Local cDesc3	:=""
Local wnrel
Local lImpLin2	:= .T.
Local cString	:="QM2"
Private titulo
Private cabec1		:= ""
Private cabec2 	:= ""
Private aReturn	:= { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 1, 2, 1, "",1 } // "Zebrado"###"Administra‡„o"
Private nomeprog	:="QMTR210"
Private nLastKey	:= 0
Private cTamanho := "G"
Private nPosEns  // Posicao do Ensaiador na aCols
Private nPosCic  // Posicao do Ciclo na aCols
Private nPosPec  // Posicao da Peca na aCols
Private nPosAtr  // Posicao da Coleta do Atributo na aCols
Private bCampo := { |nField| Field(nField) }
Private aTabela := {}
Private aFIM := {} // Guarda resultados na array para impressao
Private cQM5Tmp
Private cQM5ATP
Private INCLUI := .F.
Private nRefere := 0
Private nCodig	:= 0
Private nVlrRef	:= 0
Private aUseRef := {}
Private nVlRef := 0

If AllTrim(FunName()) <> AllTrim("QMTA150")
	ALTERA := .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cperg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ vARIAVEIS UTILIZADAS PARA PARAMETROS                            ³
//³ mv_par01            // Instrumento Inicial                      ³
//³ mv_par02            // Instrumento Final                        ³
//³ mv_par03            // Periodo Inicial                          ³
//³ mv_par04            // Periodo Final                            ³
//³ mv_par05            // Departamento Inicial                     ³
//³ mv_par06            // Departamento Final                       ³
//³ mv_par07            // Familia                                  ³
//³ mv_par08            // Usuario                                  ³
//³ mv_par09            // Fabricante                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ vARIAVEIS UTILIZADAS PARA PARAMETROS                 ³
//³ mv_par01 // Instrumento Inicial                      ³
//³ mv_par02 // Instrumento Final                        ³
//³ mv_par03 // Periodo Inicial                          ³
//³ mv_par04 // Periodo Final                            ³
//³ mv_par05 // Departamento Inicial                     ³
//³ mv_par06 // Departamento Final                       ³
//³ mv_par07 // Familia DE                               ³
//³ mv_par08 // Familia ATE                              ³
//³ mv_par09 // Usuario DE                               ³
//³ mv_par10 // Usuario ATE                              ³
//³ mv_par11 // Fabricante DE                            ³
//³ mv_par12 // Fabricante ATE                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
		  1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
INSTRUMENTO-REV.     TIPO              DEPARTAMENTO      DATA    INSP. CICL. PECAS   % V.E.   % V.A.   % R & R  % V.P.     NDC        RESULTADO    %R&R Tol.

XXXXXXXXXXXXXXXX-XX XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX  99/99/99     99     99     99   999.99  999.99  999.99   999.99   999.99  999.99  XXXXXXXXXXX    999.99

*/

titulo := OemToAnsi( STR0005 ) // "REPETITIVIDADE / REPRODUTIBILIDADE"
cabec1 := "INSTRUMENTO-REV.     TIPO              DEPARTAMENTO       DATA    INSP. CICL. PECAS   % V.E.   % V.A.   % V.P.%  R & R  %R&R Tol.    NDC        RESULTADO    "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR210"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,cTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| MTR210Imp(@lEnd,wnRel,cString,lImpLin2)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MTR210IMP³ Autor ³ Wanderley Goncalves   ³ Data ³ 05.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime corpo da listagem geral de R&R                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MTR210IMP(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTR210Imp(lEnd,wnRel,cString,lImpLin2)

Local nOrder		:= IndexOrd()
Local cAlias		:= Alias()
Local nTam			:= 0
Local cQuery	:= ""
Local cChave

Private li
Private Tamanho		:= "G"
Private nCol
Private lExist := .T.
Private	TRB_INSTR
Private	TRB_DATA
Private	TRB_DEPTO
Private	TRB_TIPO
Private	TRB_RESP
Private	TRB_STATUS
Private	TRB_REVINS
Private	TRB_NENSR
Private	TRB_CICLO
Private	TRB_PECA
Private	TRB_TIPQM4
Private TRB_TPMSA
Private TRB_TPATR
Private nCtUser := 0
Private lNoImprs := .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbTxt    := SPACE(10)
cbCont   := 0
li       := 80
m_pag    := 1

SetRegua(RecCount())

dbSelectArea( "QM4" )
dbSetOrder(1)
dbSeek( xFilial() + mv_par01,  .T. )

cChave := "QM4_FILIAL+QM4_INSTR+QM4_REVINS+QM4_DATA"
cQuery := "SELECT QM4_FILIAL,QM4_INSTR,QM4_REVINS,QM4_DATA,QM4_NENSR,QM4_NCICLO,QM4_NPECAS,QM4_TIPO,QM4_HORA,QM4_LIE,"
cQuery += "QM4_LSE,QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_REVINV,QM2_DEPTO,QM2_TIPO,"
cQuery += "QM4_TPMSA,QM4_TPATR,QM4_TOLESP,"
cQuery += "QM2_RESP,QM2_FABR,QM2_STATUS,QM2_REVINV,QM2_DEPTO,QM2_TIPO "
cQuery += "FROM "+RetSqlName("QM4")+ " QM4, "
cQuery += RetSqlName("QM2") + " QM2 "
cQuery += "WHERE "
cQuery += "QM4.QM4_FILIAL = '"			+xFilial("QM4")+	"' AND "
cQuery += "QM2.QM2_FILIAL = QM4.QM4_FILIAL AND "
cQuery += "QM2.QM2_INSTR = QM4.QM4_INSTR AND "
cQuery += "QM2.QM2_REVINS = QM4.QM4_REVINS AND "
cQuery += "QM2.QM2_INSTR  BetWeen '"	+ mv_par01 +		"' AND '" + mv_par02 +			"' AND "
cQuery += "QM4.QM4_DATA   BetWeen '"	+ Dtos(mv_par03)+	"' AND '" + DtoS(mv_par04) +	"' AND "
cQuery += "QM2.QM2_DEPTO  BetWeen '"	+ mv_par05 +		"' AND '" + mv_par06 + 			"' AND "
cQuery += "QM2.QM2_TIPO   BetWeen '"	+ mv_par07 +		"' AND '" + mv_par08 + 			"' AND "
cQuery += "QM2.QM2_FABR   BetWeen '"	+ mv_par11 +		"' AND '" + mv_par12 + 			"' AND "
cQuery += "QM2.QM2_RESP   BetWeen '"	+ mv_par09 +		"' AND '" + mv_par10 + 			"' AND "
cQuery += "QM4.D_E_L_E_T_= ' ' "+ " AND " +"QM2.D_E_L_E_T_= ' ' "

cQuery += "ORDER BY " + SqlOrder(cChave)

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QM4_DATA","D",8,0)
dbSelectArea( "TRB" )

Do While !Eof()
	nCtUser := 0
	IF lEnd
		li++
		@li,001 PSAY OemToAnsi(STR0007)  //"CANCELADO PELO OPERADOR"
		EXIT
	ENDIF



	TRB_INSTR	:= TRB->QM2_INSTR
	TRB_DATA	:= TRB->QM4_DATA
	TRB_DEPTO	:= TRB->QM2_DEPTO
	TRB_TIPO  	:= TRB->QM2_TIPO
	TRB_RESP	:= TRB->QM2_RESP
	TRB_STATUS	:= TRB->QM2_STATUS
	TRB_REVINS	:= TRB->QM2_REVINS
	TRB_NENSR	:= TRB->QM4_NENSR
	TRB_CICLO	:= TRB->QM4_NCICLO
	TRB_PECA	:= TRB->QM4_NPECAS
	TRB_TIPQM4	:= TRB->QM4_TIPO
	TRB_TPMSA	:= TRB->QM4_TPMSA
	TRB_TPATR	:= TRB->QM4_TPATR
	M->QM4_INSTR	:= TRB->QM2_INSTR
	M->QM4_REVINS	:= TRB->QM2_REVINS
	M->QM4_DATA		:= TRB->QM4_DATA
	M->QM4_HORA		:= TRB->QM4_HORA
	M->QM4_NENSR	:= TRB->QM4_NENSR
	M->QM4_NCICLO	:= TRB->QM4_NCICLO
	M->QM4_TIPO		:= TRB->QM4_TIPO
	M->QM4_NPECAS	:= TRB->QM4_NPECAS
	M->QM4_LIE		:= TRB->QM4_LIE
	M->QM4_LSE		:= TRB->QM4_LSE
	M->QM4_TPMSA	:= TRB->QM4_TPMSA
	M->QM4_TPATR	:= TRB->QM4_TPATR
	M->QM4_TOLESP   := TRB->QM4_TOLESP

	If TRB->QM4_TIPO == "A"
		If TRB->QM4_TPMSA <> "2"
			dbSkip()
			Loop
		EndIf
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se status do instrumento esta ativo						  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If	!QMTXSTAT(TRB_STATUS)
		dbskip()
		loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao dos resgistros selecionados                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	IncRegua()

	IF li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,Tamanho,IIF(aReturn[4]==1,15,18))
	End

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula R&R                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aFim := {}
	lNoImprs := .T.
	U_R210CalRR()

//		  1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//INSTRUMENTO-REV.     TIPO              DEPARTAMENTO      DATA    INSP. CICL. PECAS   % V.E.   % V.A.   % R & R  % V.P.     NDC        RESULTADO    %R&R Tol.
//
//XXXXXXXXXXXXXXXX-XX XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX  99/99/99     99     99     99   999.99  999.99  999.99   999.99   999.99  999.99  XXXXXXXXXXX    999.99
//

	If lNoImprs
		//--> Imprime os dados
		@ li,000 PSAY TRB_INSTR+"-"+TRB_REVINS
		@ li,021 PSAY TRB_TIPO
		@ li,039 PSAY TRB_DEPTO
		@ li,057 PSAY DtoC(TRB_DATA)
		@ li,068 PSAY Alltrim(Str(TRB_NENSR,2))
		@ li,074 PSAY Alltrim(Str(TRB_CICLO,2))
		@ li,080 PSAY Alltrim(Str(TRB_PECA,2))

		nTam := QA_NUMDEC(M->QM4_LIE)
		If TRB_TIPQM4 $ "EP"
			@ li,087 PSAY Alltrim(Str(aFim[1,1],Len(Str(aFim[1,1])),nTam))  // PVE
			@ li,096 PSAY Alltrim(Str(aFim[1,2],Len(Str(aFim[1,2])),nTam))  // PVA
			@ li,105 PSAY Alltrim(Str(aFim[1,4],Len(Str(aFim[1,4])),nTam))  // PVP
			@ li,114 PSAY Alltrim(Str(aFim[1,3],Len(Str(aFim[1,3])),nTam))  // % R&R Sobre Processo
			If (TRB_TPMSA>"2")
				@ li,123 PSAY Alltrim(Str(aFim[1,25],Len(Str(aFim[1,25])),nTam)) //% R&R Sobre Tolerancia
			Endif

			If !TRB_TPMSA == "2"
				@ li,134 PSAY Alltrim(Str(aFim[1,24],Len(Str(aFim[1,24])),nTam)) //NDC
			Endif
			@ li,145 PSAY aFim[1,5]

		ElseIf TRB_TIPQM4 == "C"

			@ li,124 PSAY Alltrim(Str(aFim[1,4],Len(Str(aFim[1,4])),nTam))
			@ li,148 PSAY aFim[1,6]

		ElseIf TRB_TIPQM4 == "A"
	    	If aFim[1,1] == "N"
				@ li,148 PSAY OemToAnsi(STR0009)
			Else
				@ li,148 PSAY OemToAnsi(STR0008)
			Endif
		EndIf
		li++

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apaga arquivo temporario                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		A150DelTmp()
		A150DelATP()
	Endif

	dbSelectArea("TRB")
	DbSkip()

EndDo

DbCloseArea("TRB")

Roda( cbCont, cbTxt, Tamanho )

Set Device To Screen
Set Filter To
dbSelectArea(cAlias)
dbSetOrder(nOrder)

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
End
MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R210CALRR³ Autor ³ Wanderley Goncalves   ³ Data ³ 05.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula R&R para este tipo de relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R210CALRR()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR210                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R210CalRR()
Local nCntFor:= 1
Private aCols := {}
Private aHeader := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa as Variaveis                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !(Alltrim(FunName()) $ "QMTR210|QMTR220")
	dbSelectArea("QM4")
	For nCntFor:= 1 To FCount()
		M->&(EVAL(bCampo,nCntFor)) := FieldGet(nCntFor)
	Next nCntFor
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tabela de ensaiadores                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
A150TabEns()

IF (Upper(Alltrim(FunName())) == "QMTR210" .AND. lRelR3)
	TRB_NENSR := &(cAliasQM4+"->QM4_NENSR")
EndIf

If Len(aTabela) > 0 .and. nCtUser == TRB_NENSR
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta aCols e aHeader                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aCols := {}
	A150Monta()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Guarda posicao dos elementos nos acols                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	a150PosCol()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recupera medicoes cadastradas                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	a150Recup()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ As funcoes a150CalRR e a150CurRR atualizam os valores do     ³
	//³ array Private aFim                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Upper(Alltrim(FunName())) == "QMTM900"
		If QM4->QM4_TIPO $ "EP"
			a150CalRR(.f.)
		ElseIf QM4->QM4_TIPO == "C"
			a150CurRR(.f.)
		ElseIf QM4->QM4_TIPO == "A"
			a150CalAtri(.f.)
		EndIf
	Elseif (Upper(Alltrim(FunName())) == "QMTR210" .AND. lRelR3 )
		If &(cAliasQM4+"->QM4_TIPO") $ "EP"
			a150CalRR(.f.)
		ElseIf &(cAliasQM4+"->QM4_TIPO") == "C"
			a150CurRR(.f.)
		ElseIf &(cAliasQM4+"->QM4_TIPO") == "A"
			a150CalAtri(.f.)
		EndIf
	Else
		If  TRB_TIPQM4 $ "EP"
			a150CalRR(.f.)
		ElseIf TRB_TIPQM4 == "C"
			a150CurRR(.f.)
		ElseIf TRB_TIPQM4 == "A"
			a150CalAtri(.f.)
		EndIf
	Endif
Else
	lNoImprs := .F.
Endif

Return(Nil)