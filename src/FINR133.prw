/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH" 
#INCLUDE "FINR133.CH"

Static _oFINR1331

Static __dData01
Static __dData02
Static __dData03
Static __dData04
Static __dData05
Static __dData06
Static __dData07
Static __dData08
Static __dData09
Static __dData10
Static __dData11

Static __dDataRef
Static __nPeriodos
Static __nTipoPer
Static __nPerAnt
Static __nSldChq

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR133 ³ Autor ³Jose Lucas/Diego Rivero³ Data ³ 09.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Razonete de Cliente                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR133(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ[ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Localizacoes paises ConeSul...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//

User Function FINR133()
Local oReport

Private aSelFil	:= {}

/* OS RELATORIOS MODELO R3 ESTÃO SENDO DESCONTINUADOS */
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport	:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Augusto          ³ Data ³28/06/2006³±±
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

Local oReport
Local cReport 	:= "FINR133"
Local cTitulo 	:= OemToAnsi(STR0003) 
Local cDescri	:= OemToAnsi(STR0001)+" "+OemToAnsi(STR0002)
Local lLGPD   		:= RetGlbLGPD("A1_NREDUZ")
Local nTamEnd		:= TamSx3("A1_END")[1]+ TamSx3("A1_MUN")[1] + TamSx3("A1_EST")[1]+TamSx3("A1_TEL")[1] + 22 
Local nTamSec1 		:=TamSx3("A1_LOJA")[1]+TamSx3("A1_NREDUZ")[1]+nTamEnd+TamSx3("A1_VEND")[1]+TamSx3("A3_NOME")[1]
Local nTamSec2 		:=FWSizeFilial()+TamSx3("E1_VENCREA")[1]+TamSx3("E1_TIPO")[1]+TamSx3("E1_PREFIXO")[1]+TamSx3("E1_NUM")[1]+5+TamSx3("E1_PARCELA")[1]+170

Pergunte( "FIR133" , .F. )

oReport := TReport():New( cReport, cTitulo, "FIR133" , { |oReport| ReportPrint( oReport ) }, cDescri )

oReport:SetUseGC(.F.)

oReport:SetLandScape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport,STR0082 , {"TMP","SA1"},{STR0073,STR0074,STR0075},/*Campos do SX3*/,/*Campos do SIX*/)                      //"Cliente"

TRCell():New( oSection1, "A1_COD" 	,"SA1",,,TamSx3("A1_COD")[1]+TamSx3("A1_LOJA")[1]+5,,{||TMP->CODIGO+"-"+TMP->LOJA})

If lLGPD
	TRCell():New( oSection1, "A1_NREDUZ","SA1",,,TamSx3("A1_NREDUZ")[1]+5,,{||Replicate("*", TamSx3("A1_NREDUZ")[1])})	
Else
	TRCell():New( oSection1, "A1_NREDUZ","SA1",,,TamSx3("A1_NREDUZ")[1]+5,,{||SA1->A1_NREDUZ})	
Endif

If RetGlbLGPD("A1_END") .Or. RetGlbLGPD("A1_MUN") .Or. RetGlbLGPD("A1_TEL")
	TRCell():New( oSection1, "A1_END"	,"SA1",,,nTamEnd,,{|| Replicate("*", TamSx3("A1_END")[1] + TamSx3("A1_MUN")[1] + TamSx3("A1_TEL")[1] )})	
Else
	TRCell():New( oSection1, "A1_END"	,"SA1",,,nTamEnd,,{||Alltrim(SA1->A1_END) + " - "  +Alltrim(SA1->A1_MUN) + "-"+ SA1->A1_EST +"  "+OemtoAnsi(STR0051) +SA1->A1_TEL})	
Endif

TRCell():New( oSection1, "A1_VEND"	,"SA1",,,TamSx3("A1_VEND")[1]+5,,/*{SA1->A1_VEND}*/)
TRCell():New( oSection1, "A3_NOME"	,"SA3",,,TamSx3("A3_NOME")[1]+nTamSec2-nTamSec1+17/*Tamanho*/,,/*{SA1->A1_VEND}*/)

oSection2 := TRSection():New( oSection1,STR0083 , {"TMP","SE1"} ) //"Titulos a receber"

TRCell():New( oSection2, "E1_FILORIG"	, ""	,			,  , FWSizeFilial()         ,, {|| TMP->FILORIG })
TRCell():New( oSection2, "E1_VENCREA"	, "SE1"	,			,  , TamSx3("E1_VENCREA")[1],,                   )
TRCell():New( oSection2, "E1_TIPO" 	 	, "SE1"	, 			,  , TamSx3("E1_TIPO")[1]   ,,                   ,,,,,0,.T.)
TRCell():New( oSection2, "E1_PREFIXO"	, "SE1"	, 			,  , TamSx3("E1_PREFIXO")[1]+3,,                   ,,,,,0,.T.)
TRCell():New( oSection2, "E1_NUM" 	 	, "SE1"	,   		,  , TamSx3("E1_NUM")[1]+4  ,,                   ,,,,,0,.T.)	
TRCell():New( oSection2, "E1_PARCELA"	, "SE1"	, 			,  , TamSx3("E1_PARCELA")[1]+4,,                   ,,,,,0,.T.)

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportPrint³ Autor ³ Lucas               ³ Data ³ 11.11.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Razonete de Cliente                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ReportPrint( oReport )                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint( oReport )

Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oSection1:Section(1)
Local oBreak1 
Local nOrder		:=oReport:Section(1):GetOrder()
Local aCampos		:= {}
Local cImpSldChq 
Local nTotCheque	:= 0
Local nAcumCh		:= 0
Local nVlCli00	   
Local nVlCli01	   
Local nVlCli02	   
Local nVlCli03	   
Local nVlCli04	   
Local nVlCli05	   
Local nVlCli06	  
Local nVlCli07	   
Local nVlCli08	   
Local nVlCli09	   
Local nVlCli10	   
Local nVlCli11	   
Local nSalCliFim	
Local cFltSE1 
Local aDatas 		:= {}

Private cClieIni   := mv_par01
Private cClieFim   := mv_par02
Private dFechaIni  := mv_par03
Private dFechaFim  := Min(mv_par04,dDataBase)
Private nInforme   := mv_par05
Private nMoeda     := mv_par10
Private lConverte  := (mv_par11==1)
Private nDecs      := MsDecimais(nMoeda)

aDatas := F133DefDt()

If ValType(aDatas) != "A" .Or. Len(aDatas) == 0
	Return .F.
Endif

/* GESTAO - inicio */
If MV_PAR14 == 1
	If Empty(aSelFil)
		If  FindFunction("AdmSelecFil")
			AdmSelecFil("FIR133",14,.F.,@aSelFil,"SE1",.F.)
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SE1")
			If Empty(aSelFil)
				Aadd(aSelFil,cFilAnt)
			Endif
		Endif
	Endif
Else
	Aadd(aSelFil,cFilAnt)
Endif
/* GESTAO - fim */

cImpSldChq := IIF(__nSldChq == 1,'nInforme == 1 .And. TMP->TIPO <> "CH "',"nInforme == 1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo := OemToAnsi(STR0004) //"DEUDAS VENCIDAS Y A VENCER DE CLIENTES"
Titulo += Space(1)
Titulo += OemToAnsi(STR0038)+DTOC(dFechaIni)+OemToAnsi(STR0039)+DTOC(dFechaFim)  //" De Emision: "###"  Hasta : "

TRCell():New( oSection2, "VALOR00" 	 , ""   , aDatas[01], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR00   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR01" 	 , ""   , aDatas[02], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR01   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR02" 	 , ""   , aDatas[03], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR02   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR03" 	 , ""   , aDatas[04], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR03   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR04" 	 , ""   , aDatas[05], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR04   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR05" 	 , ""   , aDatas[06], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR05   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR06" 	 , ""   , aDatas[07], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR06   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR07" 	 , ""   , aDatas[08], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR07   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR08" 	 , ""   , aDatas[09], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR08   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR09" 	 , ""   , aDatas[10], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR09   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR10" 	 , ""   , aDatas[11], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR10   },,,,,0,.T.)
TRCell():New( oSection2, "VALOR11" 	 , ""   , aDatas[12], PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP->VALOR11   },,,,,0,.T.)
TRCell():New( oSection2, "SALDOFIM"	 , ""   , STR0078   , PesqPict("SE1","E1_VALOR"), TamSx3("E1_VALOR")[1]  ,, {|| TMP-> SALDOFIM },,,,,0,.T.)
TRCell():New( oSection2, "TPSALDO" 	 , ""   ,           ,                           ,  1                     ,, {||Iif(TMP->SALDOFIM<0,"C","D") })

oSection2:Cell("E1_TIPO"   ):SetTitle(STR0086)//-- Tp
oSection2:Cell("E1_PREFIXO"):SetTitle(STR0087)//-- Pref
oSection2:Cell("E1_PARCELA"):SetTitle(STR0088)//-- Parc

oSection2:Cell("E1_FILORIG"):lHeaderSize :=	.T.
oSection2:Cell("E1_VENCREA"):lHeaderSize :=	.T.
oSection2:Cell("E1_TIPO"   ):lHeaderSize :=	.T.
oSection2:Cell("E1_PREFIXO"):lHeaderSize :=	.T.
oSection2:Cell("E1_NUM"    ):lHeaderSize :=	.T.
oSection2:Cell("E1_PARCELA"):lHeaderSize :=	.T.
oSection2:Cell("VALOR00"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR01"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR02"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR03"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR04"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR05"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR06"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR07"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR08"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR09"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR10"   ):lHeaderSize :=	.T.
oSection2:Cell("VALOR11"   ):lHeaderSize :=	.T.

AADD(aCampos,{"FILORIG" ,"C",FWSizeFilial(),0})
AADD(aCampos,{"CODIGO"  ,"C",TamSx3('E1_CLIENTE')[1],0})
AADD(aCampos,{"LOJA"    ,"C",TamSx3('E1_LOJA')[1],0})
AADD(aCampos,{"CLIENTE" ,"C",25,0})
AADD(aCampos,{"TELEFONE","C",15,0})
AADD(aCampos,{"VENDEDOR","C",06,0})
AADD(aCampos,{"NOMEVEND","C",25,0})
AADD(aCampos,{"TELEVEND","C",15,0})
AADD(aCampos,{"NATUREZA","C",10,0})
AADD(aCampos,{"PREFIXO" ,"C",TamSx3('E1_PREFIXO')[1],0})
AADD(aCampos,{"NUMERO"  ,"C",TamSx3('E1_NUM')[1],0})
AADD(aCampos,{"TIPO"    ,"C",TamSx3('E1_TIPO')[1],0})
AADD(aCampos,{"PARCELA" ,"C",TamSx3('E1_PARCELA')[1],0})
AADD(aCampos,{"BANCO"   ,"C",03,0})
AADD(aCampos,{"EMISSAO" ,"D",08,0})
AADD(aCampos,{"BAIXA"   ,"D",08,0})
AADD(aCampos,{"VENCTO"  ,"D",08,0})
AADD(aCampos,{"VALOR"   ,"N",18,nDecs})
AADD(aCampos,{"DEBITO"  ,"N",18,nDecs})
AADD(aCampos,{"CREDITO" ,"N",18,nDecs})
AADD(aCampos,{"SALDO"   ,"N",18,nDecs})
AADD(aCampos,{"SALTIT"  ,"N",18,nDecs})
AADD(aCampos,{"DC"      ,"C", 1,0})
AADD(aCampos,{"SIGLA"   ,"C",03,0})
AADD(aCampos,{"VALOR00" ,"N",18,nDecs})
AADD(aCampos,{"VALOR01" ,"N",18,nDecs})
AADD(aCampos,{"VALOR02" ,"N",18,nDecs})
AADD(aCampos,{"VALOR03" ,"N",18,nDecs})
AADD(aCampos,{"VALOR04" ,"N",18,nDecs})
AADD(aCampos,{"VALOR05" ,"N",18,nDecs})
AADD(aCampos,{"VALOR06" ,"N",18,nDecs})
AADD(aCampos,{"VALOR07" ,"N",18,nDecs})
AADD(aCampos,{"VALOR08" ,"N",18,nDecs})
AADD(aCampos,{"VALOR09" ,"N",18,nDecs})
AADD(aCampos,{"VALOR10" ,"N",18,nDecs})
AADD(aCampos,{"VALOR11" ,"N",18,nDecs})
AADD(aCampos,{"VALOR12" ,"N",18,nDecs})
AADD(aCampos,{"VALOR13" ,"N",18,nDecs})
AADD(aCampos,{"TOTCHEQ" ,"N",18,nDecs})
AADD(aCampos,{"SALDOFIM","N",18,nDecs})

If _oFINR1331 <> Nil
	_oFINR1331:Delete()
	_oFINR1331 := Nil
Endif

_oFINR1331 := FWTemporaryTable():New( "TMP" )  
_oFINR1331:SetFields(aCampos) 	

If nOrder	==	1
	_oFINR1331:AddIndex("1", {"CODIGO","LOJA","VENCTO"})
ElseIf nOrder	==	2
	_oFINR1331:AddIndex("1", {"CODIGO","LOJA","PREFIXO","NUMERO","PARCELA","TIPO"})
Else
	_oFINR1331:AddIndex("1", {"CODIGO","LOJA","EMISSAO"})
Endif

//------------------
//Criação da tabela temporaria
//------------------
_oFINR1331:Create()				

Processa({|lEnd| GeraTra(oSection1:GetAdvplExp('SE1'),oSection1:GetAdvplExp('SA1'))},,OemToAnsi(STR0041))  //"Preparando Transit¢rio..."
cFltSE1 := oSection1:GetAdvplExp('SE1')
R133fechas()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia rotina de impressao                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TMP")
dbGoTop()


oSection2:SetParentFilter({|cParam| TMP->CODIGO+TMP->LOJA == cParam },{||SA1->A1_COD+SA1->A1_LOJA}) 
If mv_par05 == 1
	oBreak1 := TRBreak():New( oSection2,{||.T.},STR0042)
	TRFunction():New(oSection2:Cell("VALOR00")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR01")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR02")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR03")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR04")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR05")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR06")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR07")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR08")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR09")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR10")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR11")	, ,"SUM", oBreak1, , , , .F. ,)
	TRFunction():New(oSection2:Cell("SALDOFIM")	, ,"SUM", oBreak1, , , , .F. ,)
Else
	//Totalizadores
	TRFunction():New(oSection2:Cell("VALOR00")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR01")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR02")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR03")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR04")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR05")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR06")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR07")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR08")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR09")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR10")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("VALOR11")	, ,"SUM", , , , , .F. ,)
	TRFunction():New(oSection2:Cell("SALDOFIM")	, ,"SUM", , , , , .F. ,)			
	
	//oculta
	oSection2:Cell("E1_VENCREA"):Hide()
	oSection2:Cell("E1_TIPO"):Hide()
	oSection2:Cell("E1_PREFIXO"):Hide()
	oSection2:Cell("E1_NUM"):Hide()
	oSection2:Cell("E1_PARCELA"):Hide()
	oSection2:Cell("E1_FILORIG"):Hide()
	
	//Define valores para as secoes
	oSection2:Cell("VALOR00"):SetBlock({|| nVlCli00 })
	oSection2:Cell("VALOR01"):SetBlock({|| nVlCli01 })
	oSection2:Cell("VALOR02"):SetBlock({|| nVlCli02 })
	oSection2:Cell("VALOR03"):SetBlock({|| nVlCli03 })
	oSection2:Cell("VALOR04"):SetBlock({|| nVlCli04 })
	oSection2:Cell("VALOR05"):SetBlock({|| nVlCli05 })
	oSection2:Cell("VALOR06"):SetBlock({|| nVlCli06 })
	oSection2:Cell("VALOR07"):SetBlock({|| nVlCli07 })
	oSection2:Cell("VALOR08"):SetBlock({|| nVlCli08 })
	oSection2:Cell("VALOR09"):SetBlock({|| nVlCli09 })
	oSection2:Cell("VALOR10"):SetBlock({|| nVlCli10 })
	oSection2:Cell("VALOR11"):SetBlock({|| nVlCli11 })
	oSection2:Cell("SALDOFIM"):SetBlock({|| nSalCliFim })	
EndIf
oSection1:SetOrder(1) 
oSection1:SetTotalInLine(.T.)
oReport:SetTotalInLine(.F.)

Trposition():New(oSection1,"SA1",1,{|| xFilial('SA1',TMP->FILORIG)+TMP->CODIGO+TMP->LOJA})  
Trposition():New(oSection1,"SA3",1,{|| xFilial('SA3',TMP->FILORIG)+SA1->A1_VEND} )  

oSection2:SetLineCondition({||&cImpSldChq})


oSection2:SetHeaderPage()

Trposition():New(oSection2,"SE1",1,{|| xFilial('SE1',TMP->FILORIG)+TMP->PREFIXO+TMP->NUMERO+TMP->PARCELA+TMP->SIGLA})  

oReport:SetTitle(titulo)
oReport:SetMeter(RecCount())
dbSelectArea("TMP")
DbGotop()

oSection1:Init() 
nTotCheque:=0
While !TMP->(EOF())  
	oSection1:PrintLine()      
	oSection2:Init()
  	If mv_par05 == 2 //Sintetico
		nVlCli00	   := 0
		nVlCli01	   := 0
		nVlCli02	   := 0
		nVlCli03	   := 0
		nVlCli04	   := 0
		nVlCli05	   := 0
		nVlCli06	   := 0
		nVlCli07	   := 0
		nVlCli08	   := 0
		nVlCli09	   := 0
		nVlCli10	   := 0
		nVlCli11	   := 0
		nSalCliFim	:= 0
	EndIf 	
	cCliente:=TMP->CODIGO+TMP->LOJA
	While cCliente==TMP->CODIGO+TMP->LOJA  .And. !TMP->(EOF())
		oReport:IncMeter()    	
  		If mv_par05 == 2 //Sintetico
			nVlCli00	   += TMP->VALOR00
			nVlCli01	   += TMP->VALOR01
			nVlCli02	   += TMP->VALOR02
			nVlCli03	   += TMP->VALOR03
			nVlCli04	   += TMP->VALOR04
			nVlCli05	   += TMP->VALOR05
			nVlCli06	   += TMP->VALOR06
			nVlCli07	   += TMP->VALOR07
			nVlCli08	   += TMP->VALOR08
			nVlCli09	   += TMP->VALOR09
			nVlCli10	   += TMP->VALOR10
			nVlCli11	   += TMP->VALOR11
			nSalCliFim	+= TMP->SALDOFIM
		EndIf
		If &cImpSldChq .and. mv_par05 == 1 // analitico
			oSection2:PrintLine()	
		EndIf
		nTotCheque:= nTotCheque + TMP->TOTCHEQ
		Dbskip()
	EndDo  

  	If !Empty(cFltSE1) .and. mv_par05 == 2 //Sintetico
		Dbskip(-1)
		oSection2:PrintLine()
		Dbskip()
	ElseIf mv_par05 == 2 //Sintetico
		oSection2:PrintLine()
	EndIf

	If nTotCheque >0
		oReport:ThinLine()
		oReport:PrintText(OemToAnsi(STR0043) + Space(01)+ Dtoc(__dDataRef) + " : " +Alltrim(Transf(nTotCheque,PesqPict("SE1","E1_VALOR"))))
	EndIf 

	oSection2:Finish()	
	oReport:ThinLine()
	nAcumCh:=nAcumCh + nTotCheque
	nTotCheque:=0

EndDo     
If nAcumCh > 0
	oReport:PrintText(OemToAnsi(STR0045) + Space(01)+ Dtoc(__dDataRef) + " : " + Alltrim(Transf(nAcumCh,PesqPict("SE1","E1_VALOR"))))
	oReport:ThinLine()
EndIf 
oSection1:Finish()		

dbSelectArea("TMP")
dbCloseArea()

//Deleta tabela temporária no banco de dados
If _oFINR1331 <> Nil
	_oFINR1331:Delete()
	_oFINR1331 := Nil
Endif

dbSelectArea("SA1")
RetIndex("SA1")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE1")
RetIndex("SE1")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE5")
RetIndex("SE5")
dbSetOrder(1)
DbClearFilter()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R133Fechas³ Autor ³ Jose Lucas            ³ Data ³ 03.11.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Grava um registro no arquivo de trabalho para impressao     ³±±
±±³          ³do Razonete.                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³R133Fechas()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR133                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R133Fechas()
Local nValor := 0.00
Local nSldTit := 0.00
Local cImpSldChq := IIf(__nSldChq == 1,'TMP->TIPO <> "CH"',".T.")

dbSelectArea("TMP")
dbGoTop()
While !Eof()
	nSldTit := TMP->SALDO
	RecLock("TMP",.F.)
	If &(cImpSldChq)
		If TMP->VENCTO <= __dData01
			Replace VALOR00    With VALOR00 + nSldTit
		ElseIf TMP->VENCTO > __dData01 .and. TMP->VENCTO <= __dData02
			Replace VALOR01   With VALOR01 + nSldTit
		ElseIf TMP->VENCTO > __dData02 .and. TMP->VENCTO <= __dData03
			Replace VALOR02   With VALOR02 + nSldTit
		ElseIf TMP->VENCTO > __dData03 .and. TMP->VENCTO <= __dData04
			Replace VALOR03   With VALOR03 + nSldTit
		ElseIf TMP->VENCTO > __dData04 .and. TMP->VENCTO <= __dData05
			Replace VALOR04   With VALOR04 + nSldTit
		ElseIf TMP->VENCTO > __dData05 .and. TMP->VENCTO <= __dData06
			Replace VALOR05   With VALOR05 + nSldTit
		ElseIf TMP->VENCTO > __dData06 .and. TMP->VENCTO <= __dData07
			Replace VALOR06   With VALOR06 + nSldTit
		ElseIf TMP->VENCTO > __dData07 .and. TMP->VENCTO <= __dData08
			Replace VALOR07   With VALOR07 + nSldTit
		ElseIf TMP->VENCTO > __dData08 .and. TMP->VENCTO <= __dData09
			Replace VALOR08   With VALOR08 + nSldTit
		ElseIf TMP->VENCTO > __dData09 .and. TMP->VENCTO <= __dData10
			Replace VALOR09   With VALOR09 + nSldTit
		ElseIf TMP->VENCTO > __dData10 .and. TMP->VENCTO <= __dData11
			Replace VALOR10   With VALOR10 + nSldTit
		ElseIf TMP->VENCTO > __dData11
			Replace VALOR11   With VALOR11 + nSldTit
		EndIf

		nValor := VALOR00+VALOR01+VALOR02+VALOR03+VALOR04+VALOR05+VALOR06
		nValor += VALOR11+VALOR10+VALOR09+VALOR08+VALOR07
		Replace SALDOFIM  With nValor
	Else
		Replace TOTCHEQ With nSldTit
	Endif
	MsUnLock()
	dbSkip()
End
Return( NIL )

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GERATRA  ³ Autor ³ BRUNO SOBIESKI        ³ Data ³ 20.01.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Generacion del archivo temporal con la informacion de la   ³±±
±±³          ³ deuda con un Cliente.                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GeraTra(cFltSE1,cFltSA1)
Local nSigno
Local cTipos 		:=	""
Local nTaxa:= 0
Local nValPCC := 0
Local cQuery		:= ""
Local cAliasSE1		:= ""
Local cTmpSE1Fil	:= ""
Local cFilOrig		:= ""
Local aArea			:= {} 
Local lLGPD			:= RetGlbLGPD("A1_NREDUZ")
Local cFilSE1		:= FwxFilial("SE1")
Local cFilSE5		:= FwxFilial("SE5")
Local lVerCmpFil 	:= !Empty(cFilSE1) .And. !Empty(cFilSE5)

If ExistBlock("FR133TIP")
	cTipos   := ExecBlock("FR133TIP",.F.,.F.)
Endif

/* GESTAO - inicio */
cFilOrig := cFilAnt
aArea := GetArea()
	cQuery := " SELECT E1_CLIENTE,R_E_C_N_O_ FROM " + RetSQLName("SE1") + " WHERE " 
If !Empty(aSelFil)
	cQuery += " E1_FILIAL " + GetRngFil(aSelFil,"SE1",.T.,@cTmpSE1Fil)
Else
	cQuery += " E1_FILIAL = '" + FwxFilial("SE1") + "'"
Endif
cQuery += " and E1_CLIENTE >= '" + cClieIni + "'"
cQuery += " and E1_CLIENTE <= '" + cClieFim + "'"
cQuery += " and E1_EMISSAO >= '" + Dtos(dFechaIni) + "'"
cQuery += " and E1_EMISSAO <= '" + Dtos(MIN(__dDataRef,dFechaFim)) + "'"
If cPaisLoc == "ARG" .And. nMoeda <> 1
	cQuery += " and E1_CONVERT <> 'N'"
Endif
If !lConverte
	cQuery += " and E1_MOEDA = " + AllTrim(Str(nMoeda))
Endif
cQuery += " and D_E_L_E_T_ = ' '"
cQuery += " order by E1_CLIENTE" 
cQuery := ChangeQuery(cQuery)
cAliasSE1 := GetNextAlias()
DbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasSE1,.F.,.T.)

/* GESTAO - fim */
nCount := 1000

ProcRegua( nCount )

While !((cAliasSE1)->(Eof())) .and. (cAliasSE1)->E1_CLIENTE <= cClieFim

	DbSelectArea("SE1")
	SE1->(DbGoTo((cAliasSE1)->R_E_C_N_O_))
	cFilAnt := If(Empty(SE1->E1_FILORIG),SE1->E1_FILIAL,SE1->E1_FILORIG)
	
	If !Empty(cTipos).And. !(E1_TIPO $ cTipos)
		(cAliasSE1)->(DbSkip())
		Loop
	Endif

	If !Empty(cFltSE1) .And. !(&(cFltSE1))
		(cAliasSE1)->(DbSkip())
		Loop
	Endif

	If !Empty(cFltSA1) 
		DbSelectArea( "SA1" )
		DbSetOrder(1)
		MSSeek( xFilial( "SA1" ) + SE1->E1_CLIENTE + SE1->E1_LOJA )
		If !(&(cFltSA1))
			DbSelectArea( cAliasSE1 )
			DbSkip()
			Loop
		Endif	
		DbSelectArea( cAliasSE1 )
	Endif

    nTaxa:=Iif(MV_PAR13==1,0,Iif(!Empty(SE1->E1_TXMOEDA),SE1->E1_TXMOEDA, RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)))
	nSigno := IIf(SE1->E1_TIPO $ "RA "+"/"+MV_CRNEG+"/"+MVABATIM ,-1,1)
	nSaldo := 0
	
	nSaldo := Round( SaldoTit( SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_TIPO, SE1->E1_NATUREZ, "R", SE1->E1_CLIENTE, nMoeda, __dDataRef, ;
					__dDataRef, SE1->E1_LOJA,,nTaxa ), nDecs )

	If lVerCmpFil
		nSaldo -= Round(FRVlCompFil("R",SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_CLIENTE,SE1->E1_LOJA,,aSelFil,,, ;
					SE1->E1_MOEDA,MV_PAR10,SE1->E1_TXMOEDA,,.T.), nDecs )
	Endif					

	If (SE1->E1_TIPO $ MVABATIM .And. SE1->E1_SALDO == 0) .Or. (SE1->E1_TIPO $ "PIS#COF#CSL" .And. SE1->E1_SALDO == 0 .And. SE1->E1_BAIXA <= dDataBase)
		nSaldo := 0
	ElseIf (nSaldo == SE1->(E1_PIS + E1_COFINS + E1_CSLL + E1_INSS + E1_ISS + E1_IRRF)             .or. ;
	        nSaldo -  SE1->(E1_PIS + E1_COFINS + E1_CSLL + E1_INSS + E1_ISS + E1_IRRF) ==   0.01   .or. ; // ajuste de arredondamento
			nSaldo - SE1->(E1_PIS + E1_COFINS + E1_CSLL + E1_INSS + E1_ISS + E1_IRRF)  == - 0.01 ) .And. ;// ajuste de arredondamento
			SE1->E1_TIPO $ MVNOTAFIS .And. ( SE1->E1_SALDO == 0 .Or. SE1->E1_SALDO != SE1->E1_VALOR) .And. SE1->E1_BAIXA <= __dDataRef
		nSaldo := 0
	Endif 

	If  ! SE1->E1_TIPO $ MVABATIM .And. ;
		! (SE1->E1_TIPO $ MVRECANT+"/"+MV_CRNEG) .And. nSaldo > 0      

		nAbatim  := SumAbatRec(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_MOEDA,"V",__dDataRef)
		cChaveAb := xFilial("SE1")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+"AB-"
		nValPCC  := CalcPCC(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,dDataBase,SE1->E1_CLIENTE,SE1->E1_LOJA, mv_par10)
		
		If (SE1->E1_BAIXA <= dDataBase .And. !Empty(SE1->E1_BAIXA) .And. (nAbatim>0 .Or. nValPCC>0))
			If nSaldo == SE1->E1_VALOR
				nSaldo -= ( nAbatim + nValPCC )
			ElseIf nSaldo == nValPCC
				nSaldo -= nValPCC
			ElseIf nSaldo == nValPCC + nAbatim
				nSaldo -= ( nValPCC + nAbatim )
			Endif

			cArea := Alias()
			nInd  := IndexOrd()
			nRec  := Recno()   
		
			If nSaldo > 0
				DbSelectArea("SE1")
				DbSetOrder(1)
				DbGoTop()
			
				If DbSeek( cChaveAb)
					If SE1->E1_SALDO == 0 .And. !Empty(SE1->E1_BAIXA) .And. SE1->E1_BAIXA <= dDataBase 
						nSaldo -= SE1->E1_VALOR
					Else
						nSaldo += SE1->E1_VALOR
					EndIf
				EndIf
		
				DbSelectArea(cArea)
				DbSetOrder(nInd)
				DbGoTo(nRec)              
			EndIf
		EndIf   
	
	EndIf	                 

	IF nSaldo > 0

		DbSelectArea( "SA1" )
		DbSetOrder(1)
		MSSeek( xFilial( "SA1" ) + SE1->E1_CLIENTE + SE1->E1_LOJA )

		If lLGPD
			IncProc(OemtoAnsi(STR0064) + Replicate("*", TamSx3("A1_NREDUZ")[1]) )  //"Procesando cliente "
		Else
			IncProc(OemtoAnsi(STR0064) + Subst(SA1->A1_NREDUZ,1,27))  //"Procesando cliente "
		Endif

		DbSelectArea( "SE1" )

		RecLock("TMP",.T.)
		/* GESTAO - inicio */
		TMP->FILORIG	:= If(Empty(SE1->E1_FILORIG),SE1->E1_FILIAL,SE1->E1_FILORIG)
		/* GESTAO - fim */
		TMP->CODIGO    :=  SE1->E1_CLIENTE
		TMP->LOJA      :=  SE1->E1_LOJA

		If RetGlbLGPD("A1_NOME")
			TMP->CLIENTE   :=  Replicate("*", TamSx3("A1_NOME")[1] )
		Else
			TMP->CLIENTE   :=  SA1->A1_NOME
		Endif

		If RetGlbLGPD("A1_TEL")
			TMP->TELEFONE  :=  Replicate("*", TamSx3("A1_TEL")[1] )
		Else
			TMP->TELEFONE  :=  SA1->A1_TEL
		Endif

		TMP->VENDEDOR  :=  SA1->A1_VEND
		TMP->NUMERO    :=  SE1->E1_NUM
		TMP->TIPO      :=  SE1->E1_TIPO
		TMP->SIGLA     :=  SE1->E1_TIPO
		TMP->PARCELA   :=  SE1->E1_PARCELA
		TMP->PREFIXO   :=  SE1->E1_PREFIXO
		TMP->EMISSAO   :=  SE1->E1_EMISSAO
		TMP->VENCTO    :=  SE1->E1_VENCREA
		TMP->VALOR     :=  SE1->E1_VALOR  * nSigno
		TMP->SALDO     :=  nSaldo         * nSigno
		MsUnLock()
	ENDIF
	dbSelectArea(cAliasSE1)
	(cAliasSE1)->(dbSkip())
EndDo

DbSelectArea(cAliasSE1)
DbCloseArea()
If !Empty(cTmpSE1Fil)
	CtbTmpErase(cTmpSE1Fil)
Endif
cFilAnt := cFilOrig
RestArea(aArea)

/* GESTAO - fim */
Return()

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FR133Data³ Autor ³ silva.wagner        ³ Data ³ 19.08.2019 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna um array com as datas corretas segundo os  		  ³±±
±±³				parametros informados.   								  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fr133Data(dData As Date, nPeriodo As Numeric, nTipo As Numeric, nPeriodAnt As Numeric) As Array

Local aDatas 	As Array
Local dDta		As Date
Local nColuna 	As Numeric
Local nRetPer	As Numeric	

aDatas	:= {}
dDta	:= CTOD("")
nColuna	:= 0
nRetPer	:= 0

If nTipo == 1 // Dia

	For nColuna := 1 To 11			
		nRetPer := nPeriodo * (nColuna - (nPeriodAnt+1) )
		dDta	:= DaySum( dData, nRetPer )			
		AAdd(aDatas, dDta)
	Next

ElseIf nTipo == 2  //Mes

	For nColuna := 1 To 11		
		nRetPer := nPeriodo * (nColuna - (nPeriodAnt+1) )
		If nRetPer < 0
			dDta :=	MonthSub(dData, ABS(nRetPer))
		Else
			dDta := MonthSum( dData, nRetPer )
		EndIf			
		AAdd(aDatas, dDta)
	Next

Endif

Return(aDatas)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CalcPCC   ³ Autor ³ Jose Delmondes		 ³ Data³29/01/2014 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula PCC em caso de saldo retroativo               	     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Finr133.prx                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CalcPCC(cPrefixo,cNumero,cParcela,__dDataRef,cCodCli,cLoja,nMoeda)

Local cAlias	:= Alias()
Local nOrdem	:= indexord()
Local cQuery	:= ""
Local nTotPcc	:= 0

DEFAULT nMoeda	:= 1

cQryAlias := GetNextAlias()

cQuery	:= " SELECT E1_FILIAL, E1_PREFIXO, E1_NUM, E1_TIPO, E1_EMISSAO, E1_VALOR, E1_TXMOEDA, E1_MOEDA, E1_TITPAI, R_E_C_N_O_ RECNO "
cQuery	+= " FROM "+RetSqlName("SE1")
cQuery	+= " WHERE E1_FILIAL = '"+xFilial("SE1")+"' AND "
cQuery	+= " E1_PREFIXO = '"+cPrefixo+"' AND "
cQuery	+= " E1_NUM = '"+cNumero+"' AND "
cQuery	+= " E1_CLIENTE = '"+cCodCli+"' AND "
cQuery	+= " E1_LOJA = '"+cLoja+"' AND "
cQuery	+= " E1_TIPO IN ('PIS','COF','CSL') AND "
cQuery	+= " E1_EMISSAO <= '"+Dtos(__dDataRef)+"' AND "
cQuery	+= " D_E_L_E_T_ = ' ' "

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cQryAlias , .F., .T.)

While (cQryAlias)->( !Eof() )
	nTotPcc += xMoeda((cQryAlias)->E1_VALOR,(cQryAlias)->E1_MOEDA,nMoeda,__dDataRef,,If(cPaisLoc=="BRA",(cQryAlias)->E1_TXMOEDA,0))
 	(cQryAlias)->(dbSkip())		
EndDo

(cQryAlias)->(dbCloseArea())

DbSelectArea(cAlias)
DbSetOrder(nOrdem)

Return(nTotPcc)

/*/{Protheus.doc} SchedDef
Utilizado somente se a rotina for executada via Schedule.
Permite usar o botao Parametros da nova rotina de Schedule
para definir os parametros(SX1) que serao passados a rotina agendada.
@author  TOTVS
@version 12.1.25
@since   13/11/2019
@return  aParam
/*/
Static Function Scheddef() As Array

Local aParam As Array 
Local aOrd	As Array     

aOrd := {STR0073,STR0074,STR0075}
// Vencimento , Prefixo+Titulo + Emissão 

aParam := {	"R"     ,; //Tipo R para relatorio P para processo   
			"FIR133",; // Pergunte do relatorio, caso nao use passar ParamDef            
			Nil     ,; // Alias            
			aOrd    ,; //Array de ordens   
			STR0003 }  // Títulos para Relatório  

Return aParam

/*/{Protheus.doc} F133DefDt
Utilizado para alimentar as variáveis static e retorno das datas para preencher o cabeçalho do relatório.

@author  richard.lopes
@version 12.1.25
@since   06/12/2019
@return  Array
/*/
Static Function F133DefDt() As Array
	Local aDate    As Array
	Local aDatas   As Array
	Local lOk      As Logical
	Local lPerg    As Logical
	Local lChkDRef As Logical
	Local nAux     As Numeric
	
	lOk 		:= .T.
	lPerg       := .F.
	lChkDRef	:= .F.
	aDate  		:= {}
	aDatas 		:= {}

	__dDataRef 	:= mv_par06
	__nPeriodos := IIf(mv_par09 == 0,1,mv_par09)
	__nTipoPer	:= mv_par08
	__nPerAnt	:= IIf(mv_par07 > 9,9,mv_par07)
	__nSldChq	:= mv_par12

	If __nTipoPer == 3 //Informado
		lOk	:=	.T.
		If Pergunte("FI133B",.T.)
			lPerg := .T.
		Else
			Return .F.
		Endif
		While lOk 
			If lPerg
				For nAux := 1 To 10
				cData1 := ("mv_par"+StrZero(nAux,2))
				cData2 := ("mv_par"+StrZero(nAux+1,2))
					If  &cData1. >= &cData2.
						lPerg := .F.
						nAux:=10
					Endif
				Next
			Endif
			If lPerg
				For nAux := 1 To 11
			cData1 := ("mv_par"+StrZero(nAux,2))
					If &cData1. == __dDataRef
						lChkDRef := .T.
						nAux := 11
					Endif
				Next
				If !lChkDRef
					MsgStop(OemToAnsi(STR0036)) //"Uma das datas deve coencidir com a Data de Referencia"
					RETURN (.F.)
				Endif
			Endif

			If lPerg
				__dData01  := mv_par01
				__dData02  := mv_par02
				__dData03  := mv_par03
				__dData04  := mv_par04
				__dData05  := mv_par05
				__dData06  := mv_par06
				__dData07  := mv_par07
				__dData08  := mv_par08
				__dData09  := mv_par09
				__dData10  := mv_par10
				__dData11  := mv_par11
				lOk   := .F.
			Else
				MsgStop(OemToAnsi(STR0037)) //"Erro de sequencia nas datas"
				RETURN (.F.)
			Endif
		Enddo
		//para restaurar os valores nas MV_PAR originais
		Pergunte("FIR133",.f.)
	Else
		aDate 	:= Fr133Data(__dDataRef,__nPeriodos,__nTipoPer,__nPerAnt)	
		__dData01 := aDate[01]
		__dData02 := aDate[02]
		__dData03 := aDate[03]
		__dData04 := aDate[04]
		__dData05 := aDate[05]
		__dData06 := aDate[06]
		__dData07 := aDate[07]
		__dData08 := aDate[08]
		__dData09 := aDate[09]
		__dData10 := aDate[10]
		__dData11 := aDate[11]
	EndIf

AADD(aDatas, (" " + CHR(13) + CHR(10) + " " + CHR(13) + CHR(10) + OemToAnsi(STR0079) + CHR(13) + CHR(10) + dToc(__dData01) ))
AADD(aDatas, (IIf(__dDataRef=__dData02,OemToAnsi(STR0084),Iif(__dDataRef=__dData01,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData01+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData02) ))
AADD(aDatas, (IIf(__dDataRef=__dData03,OemToAnsi(STR0084),Iif(__dDataRef=__dData02,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData02+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData03) ))
AADD(aDatas, (IIf(__dDataRef=__dData04,OemToAnsi(STR0084),Iif(__dDataRef=__dData03,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData03+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData04) ))
AADD(aDatas, (IIf(__dDataRef=__dData05,OemToAnsi(STR0084),Iif(__dDataRef=__dData04,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData04+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData05) ))
AADD(aDatas, (IIf(__dDataRef=__dData06,OemToAnsi(STR0084),Iif(__dDataRef=__dData05,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData05+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData06) ))
AADD(aDatas, (IIf(__dDataRef=__dData07,OemToAnsi(STR0084),Iif(__dDataRef=__dData06,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData06+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData07) ))
AADD(aDatas, (IIf(__dDataRef=__dData08,OemToAnsi(STR0084),Iif(__dDataRef=__dData07,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData07+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData08) ))
AADD(aDatas, (IIf(__dDataRef=__dData09,OemToAnsi(STR0084),Iif(__dDataRef=__dData08,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData08+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData09) ))
AADD(aDatas, (IIf(__dDataRef=__dData10,OemToAnsi(STR0084),Iif(__dDataRef=__dData09,STR0085," ")) + CHR(13) + CHR(10) + dToc(__dData09+1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData10) ))
AADD(aDatas, (" " + CHR(13) + CHR(10) + dToc(__dData10 +1) + CHR(13) + CHR(10) + OemToAnsi(STR0080) + CHR(13) + CHR(10) + dToc(__dData11  ) ))
AADD(aDatas, (" " + CHR(13) + CHR(10) + ""               + CHR(13) + CHR(10) + OemToAnsi(STR0081) + CHR(13) + CHR(10) + dToc(__dData11+1) ))

Return aDatas
