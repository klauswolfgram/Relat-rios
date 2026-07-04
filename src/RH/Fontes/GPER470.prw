/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER470.CH"
#include "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER470   บAutor  ณMicrosiga           บ Data ณ  21/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Descriminacao Das Parcelas do Salario Contribuicao        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ 
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณProgramador ณ Data   ณ BOPS  ณ  Motivo da Alteracao                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณCarlos E. O.ณ21/11/13ณM12RH01ณ Remocao dos tratamentos referentes ao   ณฑฑ
ฑฑณ            ณ        ณ       ณ formato de relatorio R3.                ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ 
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function GPER470()

	Local oReport 
	Private cAlias	:= "SRA"
	Private nXPos	:= 1
	Private aContr	:= {}
	Private aInfo	:= {}
	
	//-- Interface de impressao
	Pergunte("GPR470",.F.)
  	oReport := ReportDef()
	oReport:PrintDialog()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER470   บAutor  ณEquipe - RH         บ Data ณ  21/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
	
Static Function ReportDef()
Local oReport 
Local oSection
Local cDesc		:=	OemtoAnsi(STR0004 + ". " + STR0005 + " " + STR0006)  //"Relao das Parcelas do Salario de Contribuio" 
Local aOrd   	:= { STR0001,STR0002,STR0003 }  	//"Matricula"###"Centro de Custo"###"Nome" 

DEFINE REPORT oReport NAME "GPER470" TITLE OemToAnsi(STR0004) PARAMETER "GPR470" ACTION {|oReport| R470Imp(oReport)} DESCRIPTION cDesc TOTAL IN COLUMN 

	DEFINE SECTION o1SRA OF oReport TITLE OemToAnsi(STR0009) ORDERS aOrd

	DEFINE CELL BORDER OF o1SRA EDGE_LEFT
	DEFINE CELL BORDER OF o1SRA EDGE_RIGHT
	DEFINE CELL HEADER BORDER OF o1SRA EDGE_ALL
	DEFINE BORDER OF o1SRA EDGE_BOTTOM

	DEFINE CELL NAME "MES" 			OF o1SRA   	Block {|| aContr[nXPos,1] } TITLE STR0026 
	DEFINE CELL NAME "SALARIO"		OF o1SRA   	Block {|| aContr[nXPos,2] } TITLE STR0027 Picture "@E 999,999.99"
	DEFINE CELL NAME "DESC1" 		OF o1SRA 	Block {|| aContr[nXPos,3] }	TITLE STR0028 Picture "@E 999,999.99"
	DEFINE CELL NAME "DESC2" 		OF o1SRA 	Block {|| aContr[nXPos,4] }	TITLE STR0029 Picture "@E 999,999.99"
	DEFINE CELL NAME "DESC3" 		OF o1SRA 	Block {|| aContr[nXPos,5] }	TITLE STR0030 Picture "@E 999,999.99"
	DEFINE CELL NAME "DESC4" 		OF o1SRA	Block {|| aContr[nXPos,6] }	TITLE STR0031 Picture "@E 999,999.99"
	DEFINE CELL NAME "DESC5" 		OF o1SRA 	Block {|| aContr[nXPos,7] }	TITLE STR0032 Picture "@E 999,999.99"
	DEFINE CELL NAME "DESC6" 		OF o1SRA 	Block {|| aContr[nXPos,8] }	TITLE STR0033 Picture "@E 999,999.99"
	DEFINE CELL NAME "TOTAL" 		OF o1SRA 	Block {|| aContr[nXPos,2]+aContr[nXPos,3]+aContr[nXPos,4]+aContr[nXPos,5]+aContr[nXPos,6]+aContr[nXPos,7]+aContr[nXPos,8]} PICTURE "@E 999,999,999.99" TITLE STR0034 SIZE 14

	DEFINE SECTION oSRA OF oReport TITLE OemToAnsi(STR0001) ORDERS aOrd TABLES "SRA"
      	oSRA:SetLineStyle()    // Impressao da descricao e conteudo do campo na mesma linha
		DEFINE CELL NAME "RA_FILIAL" 	OF oSRA ALIAS "SRA"
		DEFINE CELL NAME "RA_MAT"		OF oSRA ALIAS "SRA"
		DEFINE CELL NAME "RA_CC"		OF oSRA ALIAS "SRA"
		DEFINE CELL NAME "RA_NOME"		OF oSRA ALIAS "SRA"

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER470   บAutor  ณMicrosiga           บ Data ณ  08/21/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function R470Imp(oReport)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ  Declaracao de variaveis                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ  Declaracao de variaveis                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local nOrdem		:= oSection1:GetOrder()
Local CbTxt       // Ambiente
Local CbCont
Local lCabecalho 	:= .T.
Local aCodFol    	:= {}
Local cAnoP01    	:= "  "
Local nLinaux    	:= 0
Local nSalario   	:= nVal01 := nVal02 := nVal03 := nVal04 := nVal05 := nVal06 := 0
Local cVer1      	:= cCol1  := cVer2  := cCol2  := cVer3  := cCol3  := cVer4  := cCol4  := cVer5  := cCol5  := cVer6  := cCol6  := ""
Local cVerPF1    	:= cVerPF2:= ""
Local cExclui	 	:= ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER470","SRA","2") + "}")
Local cAcessaSRD  := &("{ || " + ChkRH("GPER470","SRD","2") + "}")
Local x
Local nX
Local cSitQuery	:= ""
local cCatQuery	:= ""
Local nReg			:= 0 


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Carregando variaveis mv_par?? para Variaveis do Sistema.     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Carregando variaveis mv_par?? para Variaveis do Sistema.     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cFilDe    := mv_par01
cFilAte   := mv_par02
cCcDe     := mv_par03
cCcAte    := mv_par04
cMatDe    := mv_par05
cMatAte   := mv_par06
cNomeDe   := mv_par07
cNomeAte  := mv_par08
cSituacao := mv_par09
cCategoria:= mv_par10
cVerbPF1  := mv_par11
cVerbPF2  := mv_par12
cNome1    := mv_par13
cVerba1   := mv_par14
cCont1	  := mv_par15
cNome2    := mv_par16
cVerba2   := mv_par17
cCont2	  := mv_par18
cNome3    := mv_par19
cVerba3   := mv_par20
cCont3	  := mv_par21
cNome4    := mv_par22
cVerba4   := mv_par23
cCont4	  := mv_par24
cNome5    := mv_par25
cVerba5   := mv_par26
cCont5	  := mv_par27
cNome6    := mv_par28
cVerba6   := mv_par29
cCont6	  := mv_par30
cAno      := mv_par31
nNumParc  := IF( mv_par32 < 12 , 12 , mv_par32 )

oSection1:Cell("DESC1"):SetTitle(Left(Upper(cNome1),14))
oSection1:Cell("DESC2"):SetTitle(Left(Upper(cNome2),14))
oSection1:Cell("DESC3"):SetTitle(Left(Upper(cNome3),14))
oSection1:Cell("DESC4"):SetTitle(Left(Upper(cNome4),14))
oSection1:Cell("DESC5"):SetTitle(Left(Upper(cNome5),14))
oSection1:Cell("DESC6"):SetTitle(Left(Upper(cNome6),14))

For X = 1 To 60 Step 3 
	cVerPF1 += SubStr(cVerbPF1,X,3)
	cVerPF1 += "*"
	cVerPF2 += SubStr(cVerbPF2,X,3)
	cVerPF2 += "*"
	cVer1   += SubStr(cVerba1,X,3)
	cVer1   += "*"
	cCol1   += SubStr(cCont1,X,3)
	cCol1   += "*"
	cVer2   += SubStr(cVerba2,X,3)
	cVer2   += "*"
	cCol2   += SubStr(cCont2,X,3)
	cCol2   += "*"
	cVer3   += SubStr(cVerba3,X,3)
	cVer3   += "*"
	cCol3   += SubStr(cCont3,X,3)
	cCol3   += "*"
	cVer4   += SubStr(cVerba4,X,3)
	cVer4   += "*"
	cCol4   += SubStr(cCont4,X,3)
	cCol4   += "*"
	cVer5   += SubStr(cVerba5,X,3)
	cVer5   += "*"
	cCol5   += SubStr(cCont5,X,3)
	cCol5   += "*"
	cVer6   += SubStr(cVerba6,X,3)
	cVer6   += "*"
	cCol6   += SubStr(cCont6,X,3)
	cCol6   += "*"
Next X

cAnoP01   := StrZero( ( Val(cAno) -  ( nNumParc / 12 )  ) , 4 )
cMes      := StrZero( Month(dDataBase) , 2 )

// Quebra do relatorio
If nOrdem == 1
	oBreakCc 	:= TRBreak():New(oSection1,{|| (cAlias)->RA_MAT},STR0001,.F.,,.T.) 				// quebra por Matricula
ElseIf nOrdem == 2
	oBreakCc 	:= TRBreak():New(oSection1,{|| (cAlias)->RA_CC+(cAlias)->RA_NOME},STR0002,.F.,,.T.)	// quebra por centro de custo
ElseIf nOrdem == 3
	oBreakCc 	:= TRBreak():New(oSection1,{|| (cAlias)->RA_NOME},STR0003,.F.,,.T.)				// quebra por Nome
Endif


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Faz filtro no arquivo...                                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cAlias	:= GetNextAlias()

//-- Modifica variaveis para a Query
For nReg:=1 to Len(cSituacao)
	cSitQuery += "'"+Substr(cSituacao,nReg,1)+"'"
	If ( nReg+1 ) <= Len(cSituacao)
		cSitQuery += "," 
	Endif
Next nReg     
cSitQuery := "%" + cSitQuery + "%"

For nReg:=1 to Len(cCategoria)
	cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
	If ( nReg+1 ) <= Len(cCategoria)
		cCatQuery += "," 
	Endif
Next nReg
cCatQuery := "%" + cCatQuery + "%"

oSection1:BeginQuery()

	If nOrdem == 1
		cOrdem := "%RA_FILIAL,RA_MAT%"
	ElseIf nOrdem == 2
		cOrdem := "%RA_FILIAL, RA_CC, RA_MAT%"
	ElseIf nOrdem == 3
		cOrdem := "%RA_FILIAL, RA_NOME, RA_MAT%"
	Endif
	
	BeginSql alias cAlias
	
		SELECT *
		FROM %table:SRA% SRA 
		WHERE	SRA.RA_FILIAL 	>= %exp:MV_PAR01% AND SRA.RA_FILIAL	<= %exp:MV_PAR02% AND
				SRA.RA_CC 		>= %exp:MV_PAR03% AND SRA.RA_CC		<= %exp:MV_PAR04% AND
				SRA.RA_MAT 		>= %exp:MV_PAR05% AND SRA.RA_MAT	<= %exp:MV_PAR06% AND
				SRA.RA_NOME		>= %exp:MV_PAR07% AND SRA.RA_NOME	<= %exp:MV_PAR08% AND
				SRA.RA_SITFOLH IN (%exp:Upper(cSitQuery)%) AND
			   	SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%) AND
			  	SRA.%notDel%   
				ORDER BY %exp:cOrdem%
		
	EndSql
	
oSection1:EndQuery()

TRPosition():New(oSection2,"SRA",1,{|| (cAlias)->RA_FILIAL + (cAlias)->RA_MAT },.T.)


cFilialAnt := Replicate("!", FWGETTAMFILIAL)

//-- Imprime Rodape do relatorio
oReport:SetPageFooter(10, {|| fRodape(oReport) })
                                
//-- Imprime Cabecalho do relatorio
oReport:OnPageBreak({||	fCabec(oReport) })								

//-- Define o total da regua da tela de processamento do relatorio
(cAlias)->(dbSelectArea(cAlias))
oReport:SetMeter((cAlias)->( RecCount() ))
(cAlias)->(dbGotop())  

While (cAlias)->( !EOF() )
                   
	//-- Incrementa a r้gua da tela de processamento do relat๓rio
	oReport:IncMeter()
                                
	//-- Verifica se o usuแrio cancelou a impressใo do relatorio
	If oReport:Cancel()
		Exit
	EndIf               

	If (cAlias)->RA_FILIAL # cFilialAnt
		If !Fp_CodFol(@aCodFol,(cAlias)->RA_FILIAL) .OR. !fInfo(@aInfo,(cAlias)->RA_FILIAL)
			Exit
		Endif
		dbSelectArea( cAlias )
		cFilialAnt := (cAlias)->RA_FILIAL
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Consiste controle de acessos e filiais validas               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !((cAlias)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		dbSelectArea( cAlias )
		dbSkip()
		Loop
	EndIf

	aContr     := {}
	lCabecalho := .T.	
	nLinaux    := 11		
	cVerSal    := cVerPF1 + "*" + cVerPF2 
	cVer1      += "*" + cCol1
	cVer2      += "*" + cCol2
	cVer3      += "*" + cCol3
	cVer4      += "*" + cCol4
	cVer5      += "*" + cCol5
	cVer6      += "*" + cCol6
	nSalario   := nVal01 := nVal02 := nVal03 := nVal04 := nVal05 := nVal06 := 0	

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Pesquisa Acumulado Para Pegar os Ultimos Salarios            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea( "SRD" )
	dbSeek( (cAlias)->( RA_FILIAL + RA_MAT ) + cAnoP01 + cMes , .T. )

	 While !SRD->(Eof()) .and. RD_FILIAL + RD_MAT == (cAlias)->( RA_FILIAL + RA_MAT )
		If SRD->( !(RD_PD $ cVerSal) .and. !(RD_PD $ cVer1) .and. !(RD_PD $ cVer2) .and. !(RD_PD $ cVer3) .and. !(RD_PD $ cVer4) .and. !(RD_PD $ cVer5).and. !(RD_PD $ cVer6) )
			dbSkip()
			Loop
		Endif 					
		If MesAno( dDataBase ) == SRD->RD_DATARQ .Or. Left(SRD->RD_DATARQ,4) > cAno
			dbSkip()
			Loop
		Endif					

		// -- Despreza os lanctos de transferencias de outras empresas
        If SRD->RD_EMPRESA # cEmpAnt .And. !Empty(SRD->RD_EMPRESA)
			dbSkip()
			Loop
		Endif

		// Despreza Lactos de 13.Salario
		If Right(SRD->RD_DATARQ,2) == "13"
			dbSkip()
			Loop
		Endif
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Consiste controle de acessos								 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If !Eval(cAcessaSRD)
			dbSkip()
			Loop
		EndIf

		cMesAno := SRD->( Subst(RD_DATARQ,-2) + "/" + Subst(RD_DATARQ,1,4) )
		
		If PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_TIPOCOD") $ "1/3" // Indica codigo de provento
			If SRD->RD_PD$ cVerSal
				nSalario += SRD->RD_VALOR
			Endif
			If SRD->RD_PD$ cVer1
				nVal01 += SRD->RD_VALOR
			Endif			
			If SRD->RD_PD$ cVer2
				nVal02 += SRD->RD_VALOR
			Endif						
			If SRD->RD_PD$ cVer3
				nVal03 += SRD->RD_VALOR
			Endif			
			If SRD->RD_PD$ cVer4
				nVal04 += SRD->RD_VALOR
			Endif			
			If SRD->RD_PD$ cVer5
				nVal05 += SRD->RD_VALOR
			Endif
			If SRD->RD_PD$ cVer6
				nVal06 += SRD->RD_VALOR
			Endif
		ElseIf PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_TIPOCOD") == "2" // Indica codigo de desconto
			If SRD->RD_PD$ cVerSal
				nSalario -= SRD->RD_VALOR
			Endif
			If SRD->RD_PD$ cVer1
				nVal01 -= SRD->RD_VALOR
			Endif			
			If SRD->RD_PD$ cVer2
				nVal02 -= SRD->RD_VALOR
			Endif						
			If SRD->RD_PD$ cVer3
				nVal03 -= SRD->RD_VALOR
			Endif			
			If SRD->RD_PD$ cVer4
				nVal04 -= SRD->RD_VALOR
			Endif			
			If SRD->RD_PD$ cVer5
				nVal05 -= SRD->RD_VALOR
			Endif
			If SRD->RD_PD$ cVer6
				nVal06 -= SRD->RD_VALOR
			Endif
		Endif
		nPos1 := Ascan( aContr , { |X| X[1] == cMesAno } )		
		If nPos1 == 0						
			Aadd( aContr , { cMesAno , nSalario , nVal01 , nVal02 , nVal03 , nVal04 , nVal05 , nVal06 , SRD->RD_DATARQ } )
		Else
			aContr[nPos1,1] := cMesAno
			aContr[nPos1,2] += nSalario
			aContr[nPos1,3] += nVal01
			aContr[nPos1,4] += nVal02
			aContr[nPos1,5] += nVal03
			aContr[nPos1,6] += nVal04
			aContr[nPos1,7] += nVal05
			aContr[nPos1,8] += nVal06
			aContr[nPos1,9] := SRD->RD_DATARQ			
		Endif
		nSalario := nVal01 := nVal02 := nVal03 := nVal04 := nVal05  := nVal06 := 0
		dbSelectArea("SRD")
		dbSkip()
	Enddo

	nSalario := nVal01 := nVal02 := nVal03 := nVal04 := nVal05 := nVal06 := 0	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Ordena aContr de Acordo com o Ano/Mes de Pagamento e  Retornaณ
	//ณ caso funcionario nao Tenha dados a serem Impressos.          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF Len(aContr) > 0
		aSort( aContr,,,{ |x,y| x[9] < y[9] } )		
    Else
  		dbSelectArea(cAlias)
  		dbSkip()
  		Loop  
    EndIF

	oSection1:Init()
	For nX := 1 To Len(aContr)		
		nXPos	:= nX
		oSection1:PrintLine()
	Next Nx		

	oSection1:Finish()

	dbSelectArea( cAlias )	
	dbSkip()	
Enddo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER470   บAutor  ณTatiane Matias      บ Data ณ  18/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime cabecalho do relatorio personalizado.              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCabec(oReport)

	oReport:SkipLine()
	oReport:PrintText("  \|/")
	oReport:PrintText("\|/|\|/" + Space(20) + STR0021,oReport:Row(),oReport:Col())
	oReport:Box(oReport:Row(),oReport:Col(),oReport:Row()+oReport:LineHeight()*3,oReport:Col()+oReport:Char2Pix(STR0022+STR0023+STR0024)+10)
	oReport:Line(oReport:Row(), oReport:Col()+oReport:Char2Pix(STR0022), oReport:Row()+oReport:LineHeight()*3, oReport:Col()+oReport:Char2Pix(STR0022))
	oReport:PrintText(STR0022,oReport:Row(),oReport:Col())
	oReport:Line(oReport:Row(), oReport:Col()+oReport:Char2Pix(STR0023), oReport:Row()+oReport:LineHeight()*3, oReport:Col()+oReport:Char2Pix(STR0023))
	oReport:PrintText(STR0023,oReport:Row(),oReport:Col())
	oReport:PrintText(STR0024)
	oReport:PrintText(" |\|/|")
	oReport:PrintText("   |")
	oReport:PrintText(STR0025)
	oReport:SkipLine()
	
Return NIL                                     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER470   บAutor  ณTatiane Matias      บ Data ณ  18/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime rodape do relatorio personalizado.                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fRodape(oReport)

Local oSection2 	:= oReport:Section(2)
                                       
	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()

	oReport:SkipLine()
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:PrintText("         "+SUBS(aInfo[5],1,20)+","+DTOC(dDatabase))
	oReport:PrintText("        --------------------------------------------           ----------------------------------------------------------    ")
	oReport:PrintText( STR0014 )

Return NIL

/*
ฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟ
ณFun…o	   ณGper470Pds		ณAutorณMarinaldo de Jesus ณ Data ณ11/09/2003ณ
รฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤด
ณDescri…o ณChamada a f_Opcoes() com filtro de Verbas que ja foram  seleณ
ณ          ณcionadas em outra pergunta									ณ
รฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
ณSintaxe   ณ<Vide Parametros Formais>									ณ
รฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
ณParametrosณ<Vide Parametros Formais>									ณ
รฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
ณRetorno   ณNIL															ณ
รฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
ณUso	   ณX1_VALID do grupo GPR470 nas perguntas de selecao de Verbas	ณ
ภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
User Function Gper470Pds( cMvPar , nElemen )

DEFAULT cMvPar := ReadVar()          
DEFAULT nElemen:= 10

cMvPar := Upper( AllTrim( cMvPar ) )

Do Case
	Case ( cMvPar == "MV_PAR11" )	; fVerbas( NIL , MV_PAR12 , nElemen )
	Case ( cMvPar == "MV_PAR12" )	; fVerbas( NIL , MV_PAR11 , nElemen )
	Case ( cMvPar == "MV_PAR14" )	; fVerbas( NIL , MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR15" )	; fVerbas( NIL , MV_PAR14 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR17" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR18" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR20" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR21" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR23" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR24" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR26 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR26" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR27 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR27" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR29 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR29" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR30 , nElemen )
	Case ( cMvPar == "MV_PAR30" )	; fVerbas( NIL , MV_PAR14 + MV_PAR15 + MV_PAR17 + MV_PAR18 + MV_PAR20 + MV_PAR21 + MV_PAR23 + MV_PAR24 + MV_PAR26 + MV_PAR27 + MV_PAR29 , nElemen )
OtherWise
	fVerbas(,,nElemen)	
End Case

Return( .T. )
