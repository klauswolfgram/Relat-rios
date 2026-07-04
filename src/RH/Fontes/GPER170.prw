/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.ch"
#INCLUDE "GPER170.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER170  ³ Autor ³ R.H. - Marcos Stiefano     ³ Data ³ 04.01.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Contribuicoes:                                     ³±±
±±³          ³ -Sindical(ID.068), Assistencial(ID.069), Confederativa(ID.175)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER170(void)                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                  ³±±±±±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄ¿±±
±±³Programador ³ Data   ³ Chd./Requisito ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Ademar Jr. ³18/03/13|Requisito:      ³-Unificacao dos fontes da fase padrao com ³±±
±±³            ³        ³RHU210_09_12    ³ a fase 4 (localizacoes).                 ³±±
±±³            ³        ³                ³                                          ³±±
±±³ Gabriel A. ³06/02/17|MRH-6046        ³Melhora de performance no relatório.      ³±±
±±³ Gabriel A. ³21/02/17|MRH-6864        ³Ajuste para ordenar sempre por sindicato  ³±±
±±³            ³        |                ³na impressão do boleto.                   ³±±
±±³ Eduardo K. ³21/02/17|MPRIMESP-9595   ³Ajuste no posicionamento da tabela SRA,   ³±±
±±³            ³        |                ³para impressão correta dos dados.         ³±±
±±³ Cecilia C. ³05/06/17|DRHPAG-2405     ³Efetuado ajuste para gerar a GRCS correta-³±±
±±³            ³        |                ³mente.                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER170()
Local aArea 	:= GetArea()
Private oReport
Private aReturn := {STR0008,1,STR0009,2,1,1,"",1 }			//"Zebrado"###"Administra‡„o"
Private cDesc1	:= STR0001 + ". " +STR0002 +" "+ STR0003	//"Rela‡„o da Contribui‡„o Sindical / Assistencial / Confederativa" ### "Ser  impresso de acordo com os parametros solicitados pelo"  ### "usu rio."
Private cTitulo	:= OemToAnsi(STR0013)						//"RELACAO DA CONTRIBUICAO "
Private nTamanho:= "M"
Private nTpImpre:= 0
Private cPerg	:= ""
Private wnrel	:="GPER170"            //Nome Default do relatorio em Disco
Private oPrint 	:= TMSPrinter():New( STR0007 ) //GRCS - Guia de Recolhimento da Contribuição Sindical

cPerg := "GPE170R"

nTpImpre := U_fxRadioPerg(@nTpImpre)
If nTpImpre <= 0
	RestArea(aArea)
	Return
EndIf

//CARREGAR OS MNEMONICOS
SetMnemonicos(NIL,NIL,.T.)

pergunte(cPerg,.F.)
oReport := ReportDef()
oReport:PrintDialog()

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fxRadioPerg³ Autor ³ Equipe R.H.          ³ Data ³ 01/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Monta dialogo para selecao com botoes de radio             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fxRadioPerg(nOpcRadio)
Local nOpcAux
Local oRadio
Local oDlg
Local oGroup
Local oFont
Local nReg
Local bSet15 := {||}
Local bSet24 := {||}
//DECLARAÇÃO DE ARRAYS PARA DIMENSIONAR TELA
Local aAdvSize		:= {}
Local aInfoAdvSize	:= {}
Local aObjSize		:= {}
Local aObjCoords	:= {}

nOpcAux   := nOpcRadio
nOpcRadio := 0


//MONTA AS DIMENSOES DOS OBJETOS
aAdvSize	:= MsAdvSize()
aAdvSize[5]	:=	400 //horizontal
aAdvSize[3]	:=	202 // LARGURA
aAdvSize[4]	:=	87  // ALTURA
aAdvSize[6]	:=  200 //Vertical

aInfoAdvSize := { aAdvSize[1] , aAdvSize[2] , aAdvSize[3] , aAdvSize[4] , 3 , 3 }
aAdd( aObjCoords , { 000 , 000 , .T. , .T. } )
aObjSize	 := MsObjSize( aInfoAdvSize , aObjCoords )

DEFINE FONT oFont NAME "Arial" SIZE 0,-11 BOLD
DEFINE MSDIALOG oDlg FROM aAdvSize[7],0 TO aAdvSize[6],aAdvSize[5] TITLE OemToAnsi(STR0001) PIXEL

	@ aObjSize[1,1], aObjSize[1,2] GROUP oGroup TO aObjSize[1,3], aObjSize[1,4] LABEL OemToAnsi(STR0047) OF oDlg PIXEL //-"Selecione a opcao desejada: "
	oGroup:oFont:=oFont

	@ aObjSize[1,1]+10, aObjSize[1,2]+10 RADIO oRadio VAR nOpcAux ITEMS STR0048,STR0067,STR0068 SIZE 115,010 OF oDlg PIXEL	//-"Relatorio"###"GRCS Grafico"###"GRCS Boleto"

	bSet15	:= {|| nOpcRadio := nOpcAux, oDlg:End() }
	bSet24	:= {|| nOpcRadio := -1, oDlg:End()}

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg, bSet15, bSet24) CENTERED

Return( nOpcRadio )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef  ³ Autor ³ Tatiane Matias        ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio Contribui‡„o Sindical/Assistencial/Confederativa   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER170(void)                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GPER170 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oCell

Private aOrd    := {STR0004,STR0005,STR0006,STR0007}	//"Matr¡cula" ### "Centro de Custo" ### "Nome" ### "Sindicato"

//CRIACAO DOS COMPONENTES DE IMPRESSAO
//-- Inicio definicao do Relatorio
DEFINE REPORT oReport NAME "GPER170" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc1
oReport:SetTotalInLine(.F.)

	DEFINE SECTION oSection1 OF oReport TABLES "SRA","SRJ" TITLE OemToAnsi(STR0028) TOTAL IN COLUMN ORDERS aOrd

		DEFINE CELL NAME "RA_SINDICA"	OF oSection1 ALIAS "SRA"		SIZE 09
		DEFINE CELL NAME "RA_FILIAL"	OF oSection1 ALIAS "SRA"
		DEFINE CELL NAME "RA_MAT"		OF oSection1 ALIAS "SRA"		SIZE 22

		If SRA->(FieldPos("RA_NOMECMP")) # 0
			DEFINE CELL NAME "RA_NOMECMP"	OF oSection1 ALIAS "SRA"
		Else
			DEFINE CELL NAME "RA_NOME"		OF oSection1 ALIAS "SRA"
		Endif
		DEFINE CELL NAME "RA_NUMCP"		OF oSection1 ALIAS "SRA"
		DEFINE CELL NAME "RA_SERCP"		OF oSection1 ALIAS "SRA"
		DEFINE CELL NAME "RA_ADMISSA"	OF oSection1 ALIAS "SRA"		SIZE 15
		DEFINE CELL NAME "NSALMES"		OF oSection1 ALIAS " "		TITLE OemToAnsi(STR0036)	SIZE 13	PICTURE "@E 9,999,999.99"
		DEFINE CELL NAME "NTCONTRIB"	OF oSection1 ALIAS " "		TITLE OemToAnsi(STR0037)	SIZE 15	PICTURE "@E 9,999,999.99"
		DEFINE CELL NAME "RJ_DESC"		OF oSection1 ALIAS "SRJ"	TITLE OemToAnsi(STR0038)
		DEFINE CELL NAME "RA_PIS"		OF oSection1 ALIAS "SRA"		SIZE 16

		TRPosition():New(oSection1,"SRJ",1,{|| xFilial("SRJ") + (cAliasQry)->RA_CODFUNC }, .T.)

		DEFINE FUNCTION FROM oSection1:Cell("NSALMES")		FUNCTION SUM NO END SECTION
		DEFINE FUNCTION FROM oSection1:Cell("NTCONTRIB")	FUNCTION SUM NO END SECTION

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PrintReport³ Autor ³ Tatiane Matias        ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(oReport)                      				    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PrintReport - Generico - Release 4                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)
Local aPerAberto		:= {}
Local aPerFechado		:= {}
Local aVerbasFunc		:= {}
Local aVerbas			:= {}
Local nSalMes			:= 0
Local nValor			:= 0
Local nValorBs			:= 0 						//-- Valor base para calculo da contribuicao
Local Nx				:= 0
Local nPos				:= 0
Local nTamSind			:= TamSX3("RCE_CODIGO")[1]
Local cVerbas			:= ""						//-- Verbas que compoem a base de calculo para contr.sindical
Local cCondBusca		:= ""
Local cMes				:= ""
Local cAno				:= ""
Local cTitSind			:= ""
Local cTitCC			:= ""
Local cTitFil			:= ""
Local cRotCalc 			:= ""
// VARIAVEIS DE ACESSO DO USUARIO
Local cAcessaSRA		:= &( " { || " + ChkRH( "GPER170" , "SRA" , "2" ) + " } " )
Local cAcessaSRC		:= &( " { || " + ChkRH( "GPER170" , "SRC" , "2" ) + " } " )
Local cOrder            := ""
Local cWhere            := ""
Local cWhereSRC         := ""
Local cWhereSRD         := ""
Local cFiliais          := ""

Local cAuxFil			:= Space(FWGETTAMFILIAL)
Local cMntFil			:= ""
Local nEmp				:= 0
Local nUnid				:= 0
Local nTamGrp			:= 0
Local cSelect			:= ""

//DEFINE VARIAVEIS DEFAULT
Default	oReport		:= ReportDef()

Private oSection	:= oReport:Section(1)
Private oBreakFil
Private oBreakSindi
Private oBreakCC
Private nOrdem		:= oReport:Section(1):GetOrder()
Private nTBaseSin1	:= 0
Private nTContrib	:= 0
Private nTBaseCc1	:= 0
Private nTBaseFil1	:= 0
Private nTBaseEmp1	:= 0
Private nNumEmpr	:= 0
Private aPosicao1	:= {} // Array das posicoes
Private aCodFol		:= {}
Private aRoteiro	:= {}
Private aInfo		:= {}
Private aTotSin1	:= {}
Private aTotCc1		:= {}
Private aTotFil1	:= {}
Private aTotEmp1	:= {}
Private cSinAnt		:= Space(nTamSind)
Private cAliasQry	:= GetNextAlias()

	//CARREGANDO VARIAVEIS MV_PARXX PARA VARIAVEIS DO SISTEMA
	cFilDe		:= mv_par01				//  Filial De
	cFilAte		:= mv_par02				//  Filial Ate
	cCcDe		:= mv_par03				//  Centro de Custo De
	cCcAte		:= mv_par04				//  Centro de Custo Ate
	cMatDe		:= mv_par05				//  Matricula De
	cMatAte		:= mv_par06				//  Matricula Ate
	cNomeDe		:= mv_par07				//  Nome De
	cNomeAte	:= mv_par08				//  Nome Ate
	nSindAssi	:= mv_par09				//  1-Sindical 2-Assistencial 3-Confederativa
	cSituacao	:= mv_par10				//  Situacoes
	cCategoria	:= mv_par11				//  Categorias
	lSalta		:= If( mv_par12 == 1 , .T. , .F. )	// Imprime Quebra em Outra Pagina
	nTipSal		:= mv_par13				//  Imprime Salario Base,Composto
	cSindDe		:= If(Empty(mv_par14), Space(nTamSind), mv_par14)				//  Sindicato De
	cSindAte	:= If(Empty(mv_par15), Replicate("Z",nTamSind), mv_par15)		//  Sindicato Ate
	cCodEsta	:= mv_par16				//  Codigo do Estabelecimento
	dIniAtiv	:= mv_par17				//  Inicio das Atividades da Empresa
	cDescAti	:= mv_par18				//  Atividade do Contribuinte
	cSubCod		:= mv_par19				//  Subcodigo do contribuinte
	nCapSoci	:= mv_par20				//  Capital Social da Empresa
	nEmpresa	:= mv_par21				//  Total da Empresa
	nEstabel	:= mv_par22				//  Deste Estabelecimento
	nCapEstb	:= mv_par23				//  Capital Atribuido a este estabelecimento
	nMulta		:= mv_par24				//  Vlr. Multa
	nJurosMo	:= mv_par25				//  Vlr. Juros de Mora
	nCorrMon	:= mv_par26				//  Vlr. Correcao Monetaria
	cCentFil	:= mv_par27				//  Centraliza Filial
	nVias		:= If(!Empty(mv_par28), If(mv_par28<=0,1,mv_par28),1) //  Numero de Vias a Imprimir
	dDtPg		:= mv_par29				//  Data de Pagamento da Guia - GRCS
	dDtRefe		:= If(Empty(mv_par30), dDataBase ,mv_par30)	//  Data de Referencia

	cLocPgt		:= mv_par31
	cAgcCxe		:= mv_par32
	cMesArqRef 	:= StrZero(Month(dDtRefe),2) + StrZero(Year(dDtRefe),4)

	cMes		:= StrZero(Month(dDtRefe),2)
	cAno		:= StrZero(Year(dDtRefe),4)
	cRotCalc	:= fGetCalcRot("1") //"FOL"

	//ALTERA O TITULO DO RELATORIO CONFORME O PARAMETRO SELECIONADO
	cTitulo := If(Alltrim(oReport:Title()) == Alltrim(cTitulo),STR0013+If(mv_par09=1 ,STR0014,If(mv_par09=2, STR0015, STR0016)), oReport:Title())	//"RELACAO DA CONTRIBUICAO " ### "SINDICAL" ### "ASSISTENCIAL" ### "CONFEDERATIVA"

	//ALTERA O TITULO DO RELATORIO
	oReport:SetTitle(cTitulo)

	//ALTERA O TITULO DA CELULA DE SALARIO CONFORME PARAMETRO SELECIONADO
	If (nTipSal == 1)
		oSection:Cell("NSALMES"):SetTitle(STR0036) //-- Salario Base

	ElseIf (nTipSal == 2)
		oSection:Cell("NSALMES"):SetTitle(STR0045) //-- Salario Composto
	EndIf

	//QUEBRA DE PAGINA
	//QUEBRAR POR FILIAL
	If nOrdem == 4
		//-- Total Sindicato
		DEFINE BREAK oBreakSindi OF oSection WHEN oSection:Cell("RA_SINDICA")  TITLE OemToansi(STR0043)  //"Total do Sindicato"

		DEFINE FUNCTION FROM oSection:Cell("NSALMES")	FUNCTION SUM BREAK oBreakSindi TITLE OemToAnsi(STR0041) NO END SECTION NO END REPORT //"Total Sal.Base"
		DEFINE FUNCTION FROM oSection:Cell("NTCONTRIB")	FUNCTION SUM BREAK oBreakSindi TITLE OemToAnsi(STR0042) NO END SECTION NO END REPORT //"Total Contribuicao"

		oBreakSindi:OnBreak({|x| cTitSind := OemToAnsi(STR0043) + " " + x + " - " + fDesc("RCE", x, "RCE_DESCRI",, xFilial("RCE",SRA->RA_FILIAL)) })	//"TOTAL do Sindicato "
		oBreakSindi:SetTotalText( {|| cTitSind } )

		If lSalta
			oBreakSindi:SetPageBreak(.T.)
		EndIf
	Else
		If nOrdem == 2
			//-- Total Centro de Custo
			DEFINE BREAK oBreakCC OF oSection WHEN {|| (cAliasQry)->RA_CC}  TITLE OemToansi(STR0005)  //"Total do Centro de Custo"

			DEFINE FUNCTION FROM oSection:Cell("NSALMES")	FUNCTION SUM BREAK oBreakCC TITLE OemToAnsi(STR0041) NO END SECTION NO END REPORT //"Total Sal.Base"
			DEFINE FUNCTION FROM oSection:Cell("NTCONTRIB")	FUNCTION SUM BREAK oBreakCC TITLE OemToAnsi(STR0042) NO END SECTION NO END REPORT //"Total Contribuicao"

			oBreakCC:OnBreak({|x| cTitCC := OemToAnsi(STR0046) + " " + x + " - " + fDesc("CTT", x, "CTT_DESC01",, xFilial("CTT", SRA->RA_FILIAL)) })	//"TOTAL do Centro de Custo "
			oBreakCC:SetTotalText( {|| cTitCC } )

			If lSalta
				oBreakCC:SetPageBreak(.T.)
			EndIf
		EndIf

		//-- Total Filial
		DEFINE BREAK oBreakFil OF oSection WHEN oSection:Cell("RA_FILIAL")  TITLE OemToansi(STR0040)

		DEFINE FUNCTION FROM oSection:Cell("NSALMES")	FUNCTION SUM BREAK oBreakFil TITLE OemToAnsi(STR0041) NO END SECTION NO END REPORT //"Total Sal.Base"
		DEFINE FUNCTION FROM oSection:Cell("NTCONTRIB")	FUNCTION SUM BREAK oBreakFil TITLE OemToAnsi(STR0042) NO END SECTION NO END REPORT //"Total Contribuicao"

		oBreakFil:OnBreak({|x| cTitFil := OemToAnsi(STR0040) + " " + x + " - " + FWFilName( cEmpAnt, x ) })	//"TOTAL FILIAL "
		oBreakFil:SetTotalText( {|| cTitFil } )

		If lSalta
			oBreakFil:SetPageBreak(.T.)
		EndIf
	EndIf

	If nOrdem == 1
		cOrder := "%RA_FILIAL,RA_MAT%"
	ElseIf nOrdem == 2
		cOrder := "%RA_FILIAL,RA_CC,RA_MAT%"
	ElseIf nOrdem == 3
		cOrder := "%RA_FILIAL,RA_NOME,RA_MAT%"
	ElseIf nOrdem == 4
		cOrder := "%RA_FILIAL,RA_SINDICA,RA_NOME%"
	EndIf

	//Contribuicao Sindical so deve ser impresso por ordem de sindicato
	If nOrdem # 4 .and. nSindAssi == 1 .and. (nTpImpre == 2 .or. nTpImpre == 3)
		nOrdem := 4
	EndIf

	cFilialAnt := Space(FWGETTAMFILIAL)
	cCcAnt     := Space(9)
	cSinAnt    := Space(nTamSind)
	nNumEmpr   := 0
	nTotEmp    := 0

	If !(Empty(cNomeDe))
		cWhere += " RA_NOME >= '" + cNomeDe + "' "
	EndIf

	If !(Empty(cNomeAte))
		If Empty(cWhere)
			cWhere += " RA_NOME <= '" + cNomeAte + "' "
		Else
			cWhere += " AND RA_NOME <= '" + cNomeAte + "' "
		EndIf
	EndIf

	If !(Empty(cMatDe))
		If Empty(cWhere)
			cWhere += " RA_MAT >= '" + cMatDe + "' "
		Else
			cWhere += " AND RA_MAT >= '" + cMatDe + "' "
		EndIf
	EndIf

	If !(Empty(cMatAte))
		If Empty(cWhere)
			cWhere += " RA_MAT <= '" + cMatAte + "' "
		Else
			cWhere += " AND RA_MAT <= '" + cMatAte + "' "
		EndIf
	EndIf

	If !(Empty(cCcDe))
		If Empty(cWhere)
			cWhere += " RA_CC >= '" + cCcDe + "' "
		Else
			cWhere += " AND RA_CC >= '" + cCcDe + "' "
		EndIf
	EndIf

	If !(Empty(cCCAte))
		If Empty(cWhere)
			cWhere += " RA_CC <= '" + cCCAte + "' "
		Else
			cWhere += " AND RA_CC <= '" + cCCAte + "' "
		EndIf
	EndIf

	If !(Empty(cSindDe))
		If Empty(cWhere)
			cWhere += " RA_SINDICA >= '" + cSindDe + "' "
		Else
			cWhere += " AND RA_SINDICA >= '" + cSindDe + "' "
		EndIf
	EndIf

	If !(Empty(cSindAte))
		If Empty(cWhere)
			cWhere += " RA_SINDICA <= '" + cSindAte + "' "
		Else
			cWhere += " AND RA_SINDICA <= '" + cSindAte + "' "
		EndIf
	EndIf

	If !(Empty(cSituacao))
		cSituacao := fSqlIN( cSituacao, 1 )
		If Empty(cWhere)
			cWhere += " RA_SITFOLH IN (" + cSituacao + ") "
		Else
			cWhere += " AND RA_SITFOLH IN (" + cSituacao + ") "
		EndIf
	EndIf

	If !(Empty(cCategoria))
		cCategoria := fSqlIN( cCategoria, 1 )
		If Empty(cWhere)
			cWhere += " RA_CATFUNC IN (" + cCategoria + ") "
		Else
			cWhere += " AND RA_CATFUNC IN (" + cCategoria + ") "
		EndIf
	EndIf

	cFiliais := StrTran(fValidFil(),"/","','")
	cFiliais := "'" + SubStr(cFiliais,1,Len(cFiliais)-2)

	If Empty(cWhere)
		cWhere += " RA_FILIAL IN (" + cFiliais + ") AND RA_FILIAL >= '" + cFilDe + "' AND RA_FILIAL <= '" + cFilAte + "' "
	Else
		cWhere += " AND RA_FILIAL IN (" + cFiliais + ") AND RA_FILIAL >= '" + cFilDe + "' AND RA_FILIAL <= '" + cFilAte + "' "
	EndIf

	cWhereSRC := cWhere + " AND RC_PERIODO = '" + cAno + cMes + "' "
	cWhereSRD := cWhere + " AND RD_PERIODO = '" + cAno + cMes + "' "

	If nTpImpre <> 1 //Obtem o número total de funcionários, com e sem contribuição

		cWheSRCAux	:= cWhereSRC
		cWheSRDAux	:= cWhereSRD
		cSelect		:= "%" + Iif(TCGETDB() $ "DB2|ORACLE|POSTGRES|INFORMIX", "COUNT(DISTINCT RA_FILIAL || '-' || RA_MAT)", "COUNT(DISTINCT RA_FILIAL + RA_MAT)") +  "AS TOTAL" + "%"
		cWhereSRC	:= "%" + cWhereSRC + "%"
		cWhereSRD	:= "%" + cWhereSRD + "%"

		BeginSql Alias cAliasQry
			SELECT
				%Exp:cSelect%
			FROM
				%Table:SRA% SRA
				INNER JOIN %Table:SRC% SRC ON RA_FILIAL = RC_FILIAL AND RA_MAT = RC_MAT
			WHERE
				%Exp:cWhereSRC%
				AND SRA.%NotDel%
				AND SRC.%NotDel%

			UNION

			SELECT
				%Exp:cSelect%
			FROM
				%Table:SRA% SRA
				INNER JOIN %Table:SRD% SRD ON RA_FILIAL = RD_FILIAL AND RA_MAT = RD_MAT
			WHERE
				%Exp:cWhereSRD%
				AND SRA.%NotDel%
				AND SRD.%NotDel%

		EndSql

		nTotEmp := 0

		While !( (cAliasQry)->(EOF()) )
			nTotEmp += (cAliasQry)->(TOTAL)
			(cAliasQry)->(DbSkip())
		EndDo

		(cAliasQry)->(DbCloseArea())

		cWhereSRC := cWheSRCAux
		cWhereSRD := cWheSRDAux
		cAliasQry	:= GetNextAlias()

	EndIf

	If nSindAssi == 1
		cWhereSRC += " AND RC_PD = '" + fGetCodFol("0068") + "' "
		cWhereSRD += " AND RD_PD = '" + fGetCodFol("0068") + "' "
	ElseIf nSindAssi == 2
		cWhereSRC += " AND RC_PD = '" + fGetCodFol("0069") + "' "
		cWhereSRD += " AND RD_PD = '" + fGetCodFol("0069") + "' "
	ElseIf nSindAssi == 3
		cWhereSRC += " AND RC_PD = '" + fGetCodFol("0175") + "' "
		cWhereSRD += " AND RD_PD = '" + fGetCodFol("0175") + "' "
	EndIf

	cWhereSRC := "%" + cWhereSRC + "%"
	cWhereSRD := "%" + cWhereSRD + "%"

	BeginSql Alias cAliasQry
		SELECT DISTINCT
			RA_FILIAL, RA_MAT, RA_SINDICA, RA_NOMECMP, RA_NOME, RA_NUMCP, RA_SERCP, RA_ADMISSA, RA_PIS
			, RA_CODFUNC, RA_CC, RA_SITFOLH, RA_CATFUNC, RA_SALARIO, RA_PROCES, RA_TIPOPGT, RA_HRSMES
		FROM
			%Table:SRA% SRA
			INNER JOIN %Table:SRC% SRC ON RA_FILIAL = RC_FILIAL AND RA_MAT = RC_MAT
		WHERE
			%Exp:cWhereSRC%
			AND SRA.%NotDel%
			AND SRC.%NotDel%

		UNION

		SELECT DISTINCT
			RA_FILIAL, RA_MAT, RA_SINDICA, RA_NOMECMP, RA_NOME, RA_NUMCP, RA_SERCP, RA_ADMISSA, RA_PIS
			, RA_CODFUNC, RA_CC, RA_SITFOLH, RA_CATFUNC, RA_SALARIO, RA_PROCES, RA_TIPOPGT, RA_HRSMES
		FROM
			%Table:SRA% SRA
			INNER JOIN %Table:SRD% SRD ON RA_FILIAL = RD_FILIAL AND RA_MAT = RD_MAT
		WHERE
			%Exp:cWhereSRD%
			AND SRA.%NotDel%
			AND SRD.%NotDel%

		ORDER BY %Exp:cOrder%
	EndSql

	If nTpImpre == 1
		oSection:Init() //INICIALIZA IMPRESSAO
		//-- Define o total da regua da tela de processamento do relatorio
		oReport:SetMeter( 100 )
	Else
		ProcRegua( (cAliasQry)->(RecCount()) )
	EndIf

	While !( (cAliasQry)->(EOF()) )
		//INCREMENTA REGUA PROCESSAMENTO
		If nTpImpre == 1
			oReport:IncMeter(1)
		Else
			IncProc(OemToAnsi(STR0044))	//"Emitindo a Guia"
		EndIf

		If oReport:Cancel()
			Exit
		EndIf

		If (cAliasQry)->RA_FILIAL # cFilialAnt
			If cCentFil # space(FWGETTAMFILIAL)
				If !Fp_CodFol(@aCodFol,cCentFil) .Or. !fInfo(@aInfo,cCentFil)
					Exit
				Endif
			Else
				If !Fp_CodFol(@aCodFol,(cAliasQry)->RA_FILIAL) .Or. !fInfo(@aInfo,(cAliasQry)->RA_FILIAL)
					Exit
				Endif
			Endif

			If (Empty(aPerAberto) .Or. Empty(aPerFechado)) .Or. xFilial("RCH",(cAliasQry)->RA_FILIAL) <> xFilial("RCH",cFilialAnt)
				aPerAberto := {}
				aPerFechado	:= {}
				fRetPerComp( cMes, cAno, xFilial("RCH",(cAliasQry)->RA_FILIAL), Nil, Nil, @aPerAberto, @aPerFechado)
			EndIf

			// CONSISTE TODAS AS VERBAS QUE TEM INCIDENCIA PARA CONTR.SINDICAL
			// ESTAS VERBAS IRAO SER SOMADAS AO SALARIO PARA COMPOR A BASE SIND.
			cCondBusca 	:= { || RV_SINDICA=="S" }
			cVerbas		:= ""
			R4fIncidencia(@cVerbas , @aVerbas, cCondBusca )
			DbSelectArea(cAliasQry)
			cFilialAnt := (cAliasQry)->RA_FILIAL
		Endif

		//CONSISTE ACESSOS
		If !Eval( cAcessaSRA )
			R4fTestaTotal()
			Loop
		EndIf

		DbSelectArea("SRA")
		DbSetOrder(1)  //RA_FILIAL + RA_MAT

		//CALCULA SALARIO MES,DIA,HORA FUNCIONARIO /VALOR INCORPORADO
		SRA->(DbSeek((cAliasQry)->RA_FILIAL+(cAliasQry)->RA_MAT))
		nSalMes := fBuscaSal(dDtRefe,,,.F.)
		If nSalMes == 0
			nSalMes := (cAliasQry)->RA_SALARIO
		Endif

		//AJUSTA SALARIO CONFORME CATEGORIA
		fR170AltSal(@nSalMes)

		nValor		:= 0
		nValorBs	:= 0
		cProcesso	:= (cAliasQry)->RA_PROCES

		If nSindAssi == 1
			If Eval( cAcessaSRC ) //-- Consiste Acesso
				If aScan(aVerbasFunc, {|x| x[3] == fGetCodFol("0068")}) == 0 .And.;
					aScan(aVerbas, {|x| x[1] == fGetCodFol("0068")}) = 0
					aAdd(aVerbas, {fGetCodFol("0068")})
				EndIf

				//Retorna as verbas do funcionario, de acordo com os periodos selecionados
				aVerbasFunc	:= RetornaVerbasFunc(	(cAliasQry)->RA_FILIAL		,;		// Filial do funcionario corrente
													(cAliasQry)->RA_MAT			,;		// Matricula do funcionario corrente
													NIL					,;		// Centro de Custo da verba (opcional)
													cRotCalc			,;		// Roteiro selecionado na pergunte
													aVerbas				,;		// Array com as verbas que deverão ser listadas. Se NIL retorna todas as verbas.
													aPerAberto			,;		// Array com os Periodos e Numero de pagamento abertos
													aPerFechado			)		// Array com os Periodos e Numero de pagamento fechados

				For nPos:= 1  to len(aVerbasFunc)
					If aVerbasFunc[nPos,7]>0 .and. aVerbasFunc[nPos,3] == fGetCodFol("0068")
						nValor+= aVerbasFunc[nPos,7]
					EndIf
				Next nPos

				If (nTipSal == 2) 	//-- Somente se for salario composto e tiver incidencia Contr.Sindical
					If Len(aVerbasFunc)>0
						For nX:=1 To Len(aVerbasFunc)
							If (aVerbasFunc[nX,3] # fGetCodFol("0068"))
								nValorBS+= aVerbasFunc[nX,7]
							EndIf
						Next nX
					EndIf
				EndIf
			EndIf

		ElseIf nSindAssi == 2
			If Eval( cAcessaSRC ) //-- Consiste Acesso
				If aScan(aVerbasFunc, {|x| x[3] == fGetCodFol("0069")}) == 0 .And.;
					aScan(aVerbas, {|x| x[1] == fGetCodFol("0069")}) = 0

					aAdd(aVerbas, {fGetCodFol("0069")})
				EndIf
				If aScan(aVerbasFunc, {|x| x[3] == fGetCodFol("0318")}) == 0 .And.;
					aScan(aVerbas, {|x| x[1] == fGetCodFol("0318")}) = 0

					aAdd(aVerbas, {fGetCodFol("0318")})
				EndIf

				//Retorna as verbas do funcionario, de acordo com os periodos selecionados
				aVerbasFunc	:= RetornaVerbasFunc(	(cAliasQry)->RA_FILIAL		,;		// Filial do funcionario corrente
													(cAliasQry)->RA_MAT			,;		// Matricula do funcionario corrente
													NIL					,;		// Centro de Custo da verba (opcional)
													cRotCalc			,;		// Roteiro selecionado na pergunte
													aVerbas				,;		// Array com as verbas que deverão ser listadas. Se NIL retorna todas as verbas.
													aPerAberto			,;		// Array com os Periodos e Numero de pagamento abertos
													aPerFechado			)		// Array com os Periodos e Numero de pagamento fechados

				For nPos:= 1  to len(aVerbasFunc)
					If aVerbasFunc[nPos,7]>0 .and. aVerbasFunc[nPos,3] == fGetCodFol("0069")
						nValor+= aVerbasFunc[nPos,7]
					EndIf

					If aVerbasFunc[nPos,7]>0 .and. aVerbasFunc[nPos,3] == fGetCodFol("0318")
						nValorBS+= aVerbasFunc[nPos,7]
					EndIf
				Next nPos

			EndIf

		ElseIf nSindAssi == 3
			If Eval( cAcessaSRC ) //-- Consiste Acesso
				If aScan(aVerbasFunc, {|x| x[3] == fGetCodFol("0175")}) == 0 .And.;
					aScan(aVerbas, {|x| x[1] == fGetCodFol("0175")}) = 0

					aAdd(aVerbas, {fGetCodFol("0175")})
				EndIf
				If aScan(aVerbasFunc, {|x| x[3] == fGetCodFol("0318")}) == 0 .And.;
					aScan(aVerbas, {|x| x[1] == fGetCodFol("0318")}) = 0

					aAdd(aVerbas, {fGetCodFol("0318")})
				EndIf

				//Retorna as verbas do funcionario, de acordo com os periodos selecionados
				aVerbasFunc	:= RetornaVerbasFunc(	(cAliasQry)->RA_FILIAL		,;		// Filial do funcionario corrente
													(cAliasQry)->RA_MAT			,;		// Matricula do funcionario corrente
													NIL					,;		// Centro de Custo da verba (opcional)
													cRotCalc			,;		// Roteiro selecionado na pergunte
													aVerbas				,;		// Array com as verbas que deverão ser listadas. Se NIL retorna todas as verbas.
													aPerAberto			,;		// Array com os Periodos e Numero de pagamento abertos
													aPerFechado			)		// Array com os Periodos e Numero de pagamento fechados


				For nPos:= 1  to len(aVerbasFunc)
					If aVerbasFunc[nPos,7]>0 .and. aVerbasFunc[nPos,3] == fGetCodFol("0175")
						nValor+= aVerbasFunc[nPos,7]
					EndIf

					If aVerbasFunc[nPos,7]>0 .and. aVerbasFunc[nPos,3] == fGetCodFol("0318")
						nValorBS+= aVerbasFunc[nPos,7]
					EndIf
				Next nPos
			EndIf
		Endif

		nSalMes	 += If(  nValorBs > 0 .and. nSindAssi==1 , nValorBs ,  0 )	//-- Se for somente "salario base"  não deve adicionar verbas com a incidencia da sindical

		//VERIFICA VALOR ZERADO
		If nValor = 0
			R4fTestaTotal()
			Loop
		Endif

		//COMISSIONADO OU TAREFEIRO MONTAR SALARIO SOBRE DESCONTO
		If nSindAssi == 1 .And. ((cAliasQry)->RA_CATFUNC$ "C/T" .Or. nTipSal = 3)
			nSalMes := Round( fRetDec(nValor) * 30,2)
		Endif

		//CALCULA O BLOCO PARA O FUNCIONARIO
		aPosicao1 := { } // Limpa Arrays
		Aadd( aPosicao1 , { 0 } )

		//ATUALIZA O BLOCO PARA OS TOTALIZADORES
		nPos0 := nValor
		R4Atualiza(@aPosicao1,1,nPos0)

		//ATUALIZANDO TOTALIZADORES
		fAtuCont(@aToTSin1) // Sindicato
		fAtuCont(@aToTCc1)  // Centro de Custo
		fAtuCont(@aTotFil1) // Filial
		fAtuCont(@aTotEmp1) // Empresa

		//IMPRESSAO DO FUNCIONARIO
		If  nTpImpre == 1	// Impressao 1-Relat 2-GRCS Pre-Impr 3-GRCS Zebrado
			R4fImpFun(nSalmes)
			R4fTestaTotal()  // Quebras e Skips
		ElseIf nOrdem == 4  .and.  nSindAssi == 1
			nTBaseSin1 += nSalMes
			nTContrib  += aPosicao1[1,1]
			nNumEmpr   ++
			R4fTestaTotal()
		ElseIf nSindAssi # 1 .and. ( nTpImpre = 2 .or.  nTpImpre = 3 )
			MsgAlert( OemToAnsi(STR0026), OemToAnsi(STR0025) )         //-- "A op‡„o de impress„o da GRCS s¢ ‚ v lida para a Guia de Contr. Sindical.Certifique-se de que os parƒmetros est„o configurados corretamente."
			Return(.F.)
		ElseIf  nSindAssi == 1 .and. nOrdem #4
			exit
		Endif
	EndDo

	If  nTpImpre == 1
		oSection:Finish() //TERMINO DO RELATORIO
	ElseIf nTpImpre == 2 .or. nTpImpre == 3
		oPrint:Preview()
		oReport:CancelPrint() //CANCELA IMPRESSAO QUANDO OPCAO NAO FOR RELATORIO
	Else
		oReport:CancelPrint() //CANCELA IMPRESSAO QUANDO OPCAO NAO FOR RELATORIO
	EndIf

	(cAliasQry)->( DbCloseArea() )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R4fTestaTotal³ Autor ³ R.H. - Tatiane Matias ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao dos Sindicatos                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R4fTestaTotal()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R4fTestaTotal()

DbSelectArea(cAliasQry)
cSinAnt    := (cAliasQry)->RA_SINDICA
cFilialAnt := (cAliasQry)->RA_FILIAL              // Iguala Variaveis
cCcAnt     := (cAliasQry)->RA_CC

(cAliasQry)->(DbSkip())

If ! Eof() .And. cSinAnt # (cAliasQry)->RA_SINDICA
	If  nTpImpre == 1
		R4fImpSin()
		R4fImpCc()
		R4fImpFil()
	ElseIf nOrdem == 4  .and.  nSindAssi == 1 		//Se contribuicao Sindical e Ordem "RA_FILIAL + RA_SINDICA + RA_NOME"
 		fImpGRCS()
	Endif

ElseIf cFilialAnt # (cAliasQry)->RA_FILIAL .or. EOF()
	If cCentFil == Space(FWGETTAMFILIAL)  			//Nao centraliza por Filial
		If nTpImpre == 1
			R4fImpSin()
			R4fImpCc()
			R4fImpFil()
			If eof() 			//-Fim de Arquivo ou do Filtro
				R4fImpEmp()
			Endif
		ElseIf nOrdem == 4 .and. nSindAssi == 1 		//Se contribuicao Sindical e Ordem "RA_FILIAL + RA_SINDICA + RA_NOME"
			fImpGRCS()
		Endif
	ElseIf eof()
		If  nTpImpre== 1
			R4fImpSin()
			R4fImpCc()
			R4fImpFil()
			R4fImpEmp()
		ElseIf  nOrdem == 4  .and.  nSindAssi == 1
			fImpGRCS()
		Endif
	Endif

ElseIf cCcAnt # (cAliasQry)->RA_CC
	R4fImpSin()
	R4fImpCc()
	R4fImpFil()
Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R4fImpFun³ Autor ³ R.H. - Tatiane Matias ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao dos Funcionarios                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R4fImpFun(nSalMes)                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R4fImpFun(nSalMes)

If (cAliasQry)->(FieldPos("RA_NOMECMP")) # 0
	If !empty((cAliasQry)->RA_NOMECMP)
		cNome:= (cAliasQry)->RA_NOMECMP
	Else
		cNome:= (cAliasQry)->RA_NOME
	Endif
	oSection:Cell("RA_NOMECMP"   ):SetValue(cNome)
Else
	cNome:= (cAliasQry)->RA_NOME
	oSection:Cell("RA_NOME"   ):SetValue(cNome)
Endif
	oSection:Cell("NSALMES"   ):SetValue(nSalMes)
	oSection:Cell("NTCONTRIB" ):SetValue(aPosicao1[1,1])
	oSection:Cell("RA_MAT"    ):SetValue( (cAliasQry)->RA_MAT )
	oSection:Cell("RA_ADMISSA"):SetValue( SToD( (cAliasQry)->RA_ADMISSA ) )
	oSection:Cell("RA_PIS"    ):SetValue( (cAliasQry)->RA_PIS )
	oSection:PrintLine()

	nTBaseSin1 += nSalMes
	nTBaseCc1  += nSalMes
	nTBaseFil1 += nSalMes
	nTBaseEmp1 += nSalMes

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R4fImpSin³ Autor ³ R.H. - Tatiane Matias ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao dos Sindicatos                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R4fImpSin()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R4fImpSin()

	If Len(aTotSin1) == 0 .Or. nOrdem # 4 .Or. cSinAnt == (cAliasQry)->RA_SINDICA
		Return Nil
	Endif

	R4fImpComp(nTBaseSin1,aTotSin1) // Imprime

	aTotSin1  :={}      // Zera
	nTBaseSin1:= 0      // Zera
	nNumEmpr  := 0		// Zera
	nTContrib := 0

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R4fImpCc ³ Autor ³ R.H. - Tatiane Matias ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao dos Centros de Custo                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R4fImpCc()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R4fImpCc()

	If Len(aTotCc1) == 0 .Or. nOrdem # 2 .Or. cCcAnt == (cAliasQry)->RA_CC
		Return Nil
	Endif

	R4fImpComp(nTBaseCc1,aTotCc1) // Imprime

	aTotCc1  :={}      // Zera
	nTBaseCc1:= 0      // Zera

oReport:FatLine()
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R4fImpFil³ Autor ³ R.H. - Tatiane Matias ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao das Filiais                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R4fImpFil()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R4fImpFil()

Local cDescFil

	If Len(aTotFil1) == 0 .Or. cFilialAnt == (cAliasQry)->RA_FILIAL .or. nOrdem ==4
		Return Nil
	Endif

	cDescFil := aInfo[1]

	R4fImpComp(nTBaseFil1,aTotFil1) // Imprime

	aTotFil1   :={}    // Zera
	nTBaseFil1 :=0     // Zera

oReport:FatLine()
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R4fImpEmp³ Autor ³ R.H. - Tatiane Matias ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao das Filiais                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R4fImpEmp()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R4fImpEmp()

	If Len(aTotEmp1) == 0
		Return Nil
	Endif

	R4fImpComp(nTBaseEmp1,aTotEmp1) // Imprime

	aTotEmp1   :={}      // Zera
	nTBaseEmp1 := 0      // Zera

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R4fImpComp³ Autor ³ R.H. - Tatiane Matias ³ Data ³31/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao das Filiais                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R4fImpComp(nTBaseSal,aPosicao)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R4fImpComp(nTBaseSal,aPosicao) // Complemento da Impressao
//nTBaseSal	= VARIAVEL CONTENDO O QUE VAI SER IMPRESSO
//aPosicao		= ARRAY CONTENDO O QUE VAI SER IMPRESSO
//RESULTADO DE IMPRESSAO PARA TESTAR SE TUDO NAO ESTA ZERADO
Local nResImp := 0

	//AUXIAR PARA TRATAMENTO DO BLOCO DE CODIGO
	AeVal(aPosicao,{ |X| nResImp += X[1] })  // Testa se a Soma == 0

	//IMPRIME SE POSSUI VALORES
	If nResImp > 0
		Return( .T. )
	Else
		Return( .F. )
	Endif


*--------------------------------------------*
Static Function R4Atualiza(aMatriz,nElem,nPos0)
*--------------------------------------------*
aMatriz[nElem,1] := nPos0

Return Nil


*---------------------------------------------------------*
Static Function fAtuCont(aArray1)  // Atualiza Acumuladores
*---------------------------------------------------------*
If Len(aArray1) > 0
	aArray1[1,1] += aPosicao1[1,1]
Else
	aArray1      := Aclone(aPosicao1)
Endif

Return Nil


*--------------------------------------------*
Static Function fImpGRCS()
*--------------------------------------------*
Local nX
Local lIMPGRCS	 := ExistBlock( "IMPGRCS",.F.,.T. )//variavel p/ PE "IMPFER"

	//IMPRESSAO GUIA CONTR.SINDICAL
	For Nx := 1 to nVias
		If nTBaseSin1 # 0
			if lIMPGRCS
				ExecBlock("IMPGRCS",.F.,.F.)
			else
				GPER993()
			endif
		Endif
	Next Nx
	aTotSin1  :={}		// Zera
	nTBaseSin1:= 0		// Zera
	nNumEmpr  := 0		// Zera
	nTContrib := 0
	nTotEmp	  := 0
Return nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER170   ºAutor  ³Microsiga           º Data ³  04/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fR170AltSal(nSal)
Local cDiasMes  	:= Getmv("MV_DIASMES")
Local nUlt_Dia  	:= F_ULTDIA(dDtRefe)

If (cAliasQry)->RA_TIPOPGT = "S" .And. (cAliasQry)->RA_CATFUNC $ "S*T"
	nSal	:= nSal / 7 * 30
ElseIf (cAliasQry)->RA_CATFUNC $ "H*T*G*J"
	If (cAliasQry)->RA_CATFUNC $ "H" .And. cDiasMes = "S"
		nSal	:= ((cAliasQry)->RA_SALARIO * (cAliasQry)->RA_HRSMES) /30 * nULT_DIA
	Else
		nSal	:= (cAliasQry)->RA_SALARIO * (cAliasQry)->RA_HRSMES
	Endif
ElseIf (cAliasQry)->RA_CATFUNC $ "D"
	nSal	:= ( nSal * 30 )
EndIf

Return nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER170   ºAutor  ³Microsiga           º Data ³  04/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Busca verbas no SRV conforme                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R4fIncidencia(cVerbas, aVerbas, cCondicao)
Local aArea	:= GetArea()
Local bCondSrv   := { |e| If (ValType(e) = "C",&(e),If (ValType(e) = "B",Eval(e),.F.)) }

If !(SRV->RV_COD $ cVerbas)
	SRV->(dBeval({||cVerbas += SRV->RV_COD + "/"},{||Eval(bCondSrv,cCondicao)} ))
EndIf

If aScan(aVerbas, {|x| x[1] == SRV->RV_COD}) = 0
	SRV->(dBeval({||aadd(aVerbas,{SRV->RV_COD})},{||Eval(bCondSrv,cCondicao)} ))
EndIf

RestArea(aArea)
Return
