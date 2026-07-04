/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GPER530.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER530   บAutor  ณPedro Eloy          บ Data ณ  07/26/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio de Deducao do Salario Maternidade do 13บ Salario บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER530                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPROGRAMADOR | DATA   |CHAMADO/REQ|  MOTIVO DA ALTERACAO                ณฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบMOHANAD     |11/02/14|M12RH01    |UNIfICACAO DA FOLHA V12              บฑฑ
ฑฑบ            |        |     RQ0326|                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function GPER530()
Local oReport 
Private cAlias	:= "SRA"

//INTERFACE DE IMPRESSAO
Pergunte("GPER530",.F.)

// VARIAVEIS UTILIZADAS PARA PARAMETROS
// MV_PAR01        //  FILIAL
// MV_PAR02        //  CENTRO DE CUSTO
// MV_PAR03        //  MATRICULA
// MV_PAR04        //  NOME
// MV_PAR05        //  IMPRIME C.C EM OUTRA PAGINA
// MV_PAR06        //  FOLHA/FERIAS,13บ SALARIO
oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER520   บAutor  ณEquipe - RH         บ Data ณ  12/06/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ReportDef()
Local oReport 
Local oSection
Local cDesc		:=	STR0001+". "+STR0002	//"Relat๓rio de Dedu็ใo do Salแrio Maternidade 13บ Salแrio"
Local aOrd    	:= {STR0004,STR0005,STR0006,STR0007}	//"Matricula"###"Centro de Custo"###"Nome"###"Centro de Custo + Nome"

DEFINE REPORT oReport NAME "GPER530" TITLE OemToAnsi(STR0010) PARAMETER "GPER530" ACTION {|oReport| R530Imp(oReport)} DESCRIPTION cDesc  TOTAL IN COLUMN // "RELATำRIO DE DEDUวรO DO SALมRIO MATERNIDADE 13บ SALมRIO"

	DEFINE SECTION oSRA OF oReport TITLE OemToAnsi(STR0019) ORDERS aOrd TABLES "SRA" TOTAL TEXT STR0020  PAGE HEADER  TOTAL IN COLUMN
	DEFINE CELL NAME "RA_FILIAL" 	OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_CC" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_MAT" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "RA_NOME" 		OF oSRA ALIAS "SRA"
	DEFINE CELL NAME "13AVOS" 		OF oSRA 				TITLE STR0016	Picture "@E 999"
	DEFINE CELL NAME "DIAS_AFAST" 	OF oSRA 				TITLE STR0017   Picture "@E 999"
	DEFINE CELL NAME "VLDED"			OF oSRA 				TITLE STR0018   Picture "@E 999,999,999.99"

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER530   บAutor  ณMicrosiga           บ Data ณ  09/12/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function R530Imp(oReport)
Local oSection 	:= oReport:Section(1)    
Local aOrdBag    	:= {}
Local oBreakCc
Local CbCont
Local aDeducao    :={}
Local dDtFimAf 
Local nItem       := 0
Local nCt         := 0
Local nVl13Sal    := 0
Local nDiasSM     := 0
Local nAvos       := 0
Local nValDed     := 0
Local nDiaIni
Local nOrdem		:= oSection:GetOrder()
Local cMesArqRef	:= ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER530","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER530","SRC","2") + "}")
Local cAcessaSRI  := &("{ || " + ChkRH("GPER530","SRI","2") + "}")
Local cArqMov 	  := cAliasMov := ""
Local dDtBaseIni
Local dDtBaseFim
Local cIndCond	:= ""
Local cCond		:= ""
Local cTitCC	:= ""
Local nValDed13 := 0
Local lAchou	:= .F.
Local lAchouDed	:= .F.
Local bCondDed	:= { || (.T.) }
Private cFilPar	:= MV_PAR01
Private cCcPar	:= MV_PAR02
Private cMatPar	:= MV_PAR03
Private cNomPar	:= MV_PAR04
Private lSalta	:= If(MV_PAR05 == 1 , .T. , .F.)
Private dDataRef	:= MV_PAR06
Private aCodFol	:={}
Private aInfo		:= {}

dDtBaseIni  := CtoD("01/01/"+RIGHT(STR(YEAR(dDataRef)),4),"DDMMYY")
dDtBaseFim  := CtoD("31/12/"+RIGHT(STR(YEAR(dDataRef)),4),"DDMMYY")

//"MATRICULA"###"CENTRO DE CUSTO"###"NOME"###"CENTRO DE CUSTO + NOME"//
If nOrdem = 1
	oBreakCc 	:= TRBreak():New(oSection, oSection:Cell("RA_FILIAL"),STR0020, .F.,,.f.)  // STR0004
	oBreakCc:OnBreak({|x,y|cTitCC:=OemToAnsi(STR0020)+" "+x})
	oSection:SetTotalText({||cTitCC})

ElseIf nOrdem = 2 .And. lSalta
	oBreakCc 	:= TRBreak():New(oSection,{|| SRA->RA_CC},, .F.,,.t.)  //STR0005
	oBreakCc:OnBreak({|x,y|cTitCC:=OemToAnsi(STR0005)+" "+x})
	oSection:SetTotalText({||cTitCC})

ElseIf nOrdem = 3
	oBreakCc 	:= TRBreak():New(oSection,{|| SRA->RA_NOME },   , .F.,,.f.) //STR0006
Else
	DEFINE BREAK oBreakCc OF oReport WHEN {|| SRA->RA_CC+SRA->RA_NOME } TITLE {|| STR0005 + " + "+STR0006 }
EndIf

DEFINE FUNCTION FROM oSection:Cell("VLDED") FUNCTION SUM BREAK oBreakCC  NO END SECTION

//FAZ FILTRO NO ARQUIVO...
//TRANSFORMA PARAMETROS DO TIPO RANGE EM EXPRESSAO ADVPL PARA SER UTILIZADA NO FILTRO
MakeSqlExpr("GPER530")

cAlias	:= GetNextAlias()

oSection:BeginQuery()

//"MATRICULA"###"CENTRO DE CUSTO"###"NOME"###"CENTRO DE CUSTO + NOME"//
If nOrdem == 1
	cOrdem := "%RA_FILIAL,RA_MAT%"
ElseIf nOrdem == 2
	cOrdem := "%RA_FILIAL,RA_CC%"
ElseIf nOrdem == 3
	cOrdem := "%RA_FILIAL,RA_NOME%"
ElseIf nOrdem == 4
	cOrdem := "%RA_FILIAL,RA_CC,RA_NOME%"
EndIf

BeginSql alias cAlias

SELECT SRA.*
FROM %table:SRA% SRA 
WHERE	SRA.%notDel%   
		ORDER BY %exp:cOrdem%
EndSql       

/* PREPARA RELATORIO PARA EXECUTAR A QUERY GERADA PELO EMBEDDED SQL PASSANDO COMO 
PARAMETRO A PERGUNTA OU VETOR COM PERGUNTAS DO TIPO RANGE QUE FORAM ALTERADOS 
PELA FUNCAO MAKESQLEXPR PARA SEREM ADICIONADOS A QUERY*/
END REPORT QUERY oSection PARAM MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR04


cFilialAnt := Replicate("!", FWGETTAMFILIAL)
cCcAnt     := Space(9)

dbGotop()	

//DEFINE O TOTAL DA REGUA DA TELA DE PROCESSAMENTO DO RELATORIO
oReport:SetMeter((cAlias)->(RecCount()))  

oSection:Init()
While (cAlias)->(!EOF())

	//INCREMENTA A REGUA DA TELA DE PROCESSAMENTO DO RELATORIO
  	oReport:IncMeter()
                                
	//VERIfICA SE O USUARIO CANCELOU A IMPRESSAO DO RELATORIO
	If oReport:Cancel()
		Exit
	EndIf      

	If (cAlias)->RA_FILIAL # cFilialAnt
		If !Fp_CodFol(@aCodFol,(cAlias)->RA_FILIAL)      .Or. ;
			!fInfo(@aInfo,(cAlias)->RA_FILIAL)
			Exit
		EndIf
		dbSelectArea(cAlias)
		cFilialAnt := (cAlias)->RA_FILIAL
	EndIf
	
	//CONSISTE CONTROLE DE ACESSOS E FILIAIS VALIDAS
	If !((cAlias)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		dbSelectArea(cAlias)
		dbSkip()
		Loop
	EndIf

	//POSICIONA O CADASTRO DE FUNCIONARIO PARA USAR NA FUNCAO fPgMater
	dbSelectArea("SRA")
	dbSeek((cAlias)->RA_FILIAL+(cAlias)->RA_MAT,.F.)
	dbSelectArea(cAlias)

	//INICIALIZA VARIAVEIS A CADA FUNCIONARIO E APURA OS DIAS DE LICENCA MATERNIDADE OCORRIDOS NO ANO DA DATA DE REFERENCIA
	nDiasSM		:= fDiasSm13(Left(Dtos(dDataRef),4),(cAlias)->RA_FILIAL,(cAlias)->RA_MAT)
	nValDed13	:= 0
	lAchou		:= .F.
	lAchouDed	:= .F.
	bCondDed	:= { || (.T.) }

	If nDiasSM > 0
		dbSelectArea('SRC')
		dbSetOrder(1)
		//VERIfICA A EXISTENCIA DA VERBA DE DEDUCAO DE SAL.MATERNIDADE PARA 13บ SALARIO
		If aCodFol[670,1] <> "   "
			lAchouDed	:= dbSeek((cAlias)->RA_FILIAL + (cAlias)->RA_MAT + aCodFol[670,1])
			If lAchouDed
				//CONDICAO PARA TESTAR A VERBA DE DEDUCAO SAL.MATERN.13บ SAL.CASO EXISTA
				bCondDed	:= { || (SRC->RC_PD == aCodFol[670,1]) }
			EndIf
		EndIf
		//SE NAO ENCONTROU A VERBA DE DEDUCAO DE SAL.MATERNIDADE PARA 13บ SALARIO PESQUISA O MOVIMENTO INTEIRO PARA APURAR A DEDUCAO
		If !lAchouDed
			lAchou		:= dbSeek((cAlias)->RA_FILIAL + (cAlias)->RA_MAT)
		EndIf
		If lAchou .Or. lAchouDed
			While !Eof() .And. (cAlias)->RA_FILIAL + (cAlias)->RA_MAT == SRC->RC_FILIAL + SRC->RC_MAT .And. Eval(bCondDed)
				If !lAchouDed
					//CONSISTE CONTROLE DE ACESSOS
					If Eval(cAcessaSRC)
						//VERIf. 13บ SALARIO INDENIZADO E 13บ SAL. AV. PREVIO             
						//MEDIA 13บ SALARIO RESCISAO E MEDIA 13บ SALARIO SOBRE AVISO INDENIZADO RESCISAO
						If SRC->RC_PD == aCodFol[114,1] .Or. SRC->RC_PD == aCodFol[115,1] .or.;
								SRC->RC_PD == aCodFol[251,1] .or. SRC->RC_PD == aCodFol[253,1]
							If SRC->RC_PD == aCodFol[114,1] .or. SRC->RC_PD == aCodFol[115,1]
								nAvos += Int(SRC->RC_HORAS)
							EndIf
							nVl13Sal += SRC->RC_Valor
						EndIf
					EndIf
				Else
					//ACUMULO OS VALORES JA CALCULADOS DE DEDUCAO DE SAL MATERNIDADE PARA 13บ SALARIO
					nValDed13 += SRC->RC_VALOR
				EndIf
				dbSkip()
			Enddo
		EndIf
	EndIf

	If (nVl13Sal > 0 .Or. nValDed13 > 0) .And. nDiasSm > 0
		If nDiasSM > 0 .And. (nAvos > 0 .Or. nValDed13 > 0)
			nValDed := If(nValDed13==0,ROUND(((nVl13Sal/nAvos)/30)*nDiasSM,2),nValDed13)
			If nAvos == 0 .And. nValDed13 > 0
				nAvos	:= Round(nDiasSM / 30,2)
			EndIf
		EndIf
	EndIf
	//CALCULA O BLOCO PARA O FUNCIONARIO
	aPosicao1:={} // LIMPA ARRAYS
	Aadd(aPosicao1,{0,0,0})

	//ATUALIZA O BLOCO PARA OS TOTALIZADORES
   	If nAvos > 0 .And. nDiasSM > 0 .And. nValDed > 0
		nPos0 := nAvos
		nPos1 := nDiasSM
		nPos2 := nValDed
	Else
		nPos0 := 0    
		nPos1 := 0         
		nPos2 := 0       
	EndIf

	Atualiza(@aPosicao1,1,nPos0,nPos1,nPos2)

	//IMPRESSAO DO FUNCIONARIO
   	If nAvos > 0 .And. nDiasSM > 0 .And. nValDed > 0
	   	oSection:Cell("13AVOS"):SetValue(aPosicao1[1,1])
		oSection:Cell("DIAS_AFAST"):SetValue(aPosicao1[1,2])
		oSection:Cell("VLDED"):SetValue(aPosicao1[1,3])

		oSection:PrintLine()
   	EndIf

   	nVl13Sal   := 0
	nDiasSM    := 0
	nAvos      := 0
	nValDed    := 0

	dbSelectArea(cAlias)
	dbSkip()
Enddo	

//FINALIZA IMPRESSAO INICIALIZADA PELO METODO INIT
oSection:Finish()
			
//SELECIONA ARQ. DEFAUT DO SIGA CASO IMP. MOV. ANTERIORES
//ALTERADO DE LUGAR O RETORNO DO SRC ORIGINAL
If !Empty(cAliasMov)
	fFimArqMov(cAliasMov, aOrdBag, cArqMov)
EndIf

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtualiza  บAutor  ณMicrosiga           บ Data ณ  09/12/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function Atualiza(aMatriz,nElem,nPos0,nPos1,nPos2)

aMatriz[nElem,1] := nPos0
aMatriz[nElem,2] := nPos1
aMatriz[nElem,3] := nPos2

Return Nil
