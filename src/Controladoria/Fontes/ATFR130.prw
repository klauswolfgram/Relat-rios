/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Atfr130.ch"
#include "Protheus.ch"
//#Include "FWLIBVERSION.CH"

Static __lTabSld
Static __lMetric	:= FwLibVersion() >= "20210517" .And. GetSrvVersion() >= "19.3.0.6"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ATFR130  ³ Autor ³ Wagner Xavier         ³ Data ³ 03.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Raz„o Analitico do Ativo                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR130                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR130()

Local oReport := Nil

__lTabSld := .T.

oReport:=ReportDef()
oReport:PrintDialog()
PRIVATE aSelFil	:= {}

Return
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
Local oSection1		:= Nil
Local oSection11	:= Nil
Local oTotalDBF		:= Nil
Local cReport 		:= "ATFR130"
Local cAlias1		:= "SN5"
Local cTitulo		:= STR0003 // "Razao Auxiliar"
Local cDescri		:= STR0001 + " " + STR0002 // "Este relatorio ir  imprimir o Raz„o Auxiliar do Ativos Imobilizados (RAZORT) por Conta na moeda corrente."
Local bReport		:= {|| }
Local cPicture		:= ""
Local nX			:= 0

bReport := { |oReport|	oReport:SetTitle( oReport:Title() + OemToAnsi(STR0006)+AllTrim(GETMV("MV_SIMB" + Str(mv_par05+1,1,0)))), RepPrtTop( oReport ) }

Pergunte( "AFR130" , .F. )

oReport  := TReport():New( cReport, cTitulo, "AFR130" , bReport, cDescri )

oReport:SetUseGC(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0051, {cAlias1} ) // "Dados da Conta"
oSection1:SetHeaderPage(.T.)
oSection1:SetLinesBefore(2)
oSection1:SetAutoSize(.T.)
TRCell():New( oSection1, "N5_FILIAL"			, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N5_CONTA"			, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If CtbInUse()
	TRCell():New( oSection1, "CT1_DESC01"		, "CT1",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Else
	TRCell():New( oSection1, "I1_DESC"			, "SI1",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Endif
TRCell():New( oSection1, "SALDO ANTERIOR R$"	, cAlias1,STR0043 + AllTrim(GETMV("MV_SIMB1")),PesqPict("SN5","N5_VALOR1"      ,21,1)/*Picture*/,21/*Tamanho*/,/*lPixel*/, /*{|| code-block de impressao }*/,,,"RIGHT" ) // "Saldo anterior em "
TRCell():New( oSection1, "SDO ANT MOEDA ATIVO", cAlias1,STR0043 + AllTrim( GETMV("MV_SIMB" + Str(mv_par05+1,1,0) ) ),PesqPict("SN5","N5_VALOR"+Str(mv_par05+1,1),20,mv_par05+1)/*Picture*/,21/*Tamanho*/,/*lPixel*/, /*{|| code-block de impressao }*/,,,"RIGHT" ) // "Saldo anterior em "

For nX := 1 To Len(oSection1:aCell)
	oSection1:Cell(nX):SetBorder("BOTTOM")
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 2a. secao do relatorio Movimentacoes        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection11 := TRSection():New( oSection1, STR0052, {cAlias1} ) // "Movimentos"
oSection11:SetHeaderPage(.F.)
oSection11:SetHeaderSection(.T.)
oSection11:SetLinesBefore(0)
TRCell():New( oSection11, "N5_DATA"  	, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N5_CONTA"  	, cAlias1,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N5_TIPO"   	, cAlias1,STR0044,/*Picture*/,20/*Tamanho*/,/*lPixel*/, {|| AFDescSal( N5_TIPO ) } ) // "Histórico"
TRCell():New( oSection11, "N5_VALOR1"	, cAlias1,OemToAnsi(STR0004)+AllTrim(GETMV("MV_SIMB1"))/*X3Titulo*/   	,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| code-block de impressao }*/ )
TRCell():New( oSection11, "REFERENCIA"	, cAlias1,STR0045/*X3Titulo*/   	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Referência"
TRCell():New( oSection11, "N5_TAXA"		, cAlias1,OemToAnsi(STR0005) + AllTrim( GETMV("MV_SIMB" + Str(mv_par05+1,1,0) ) )/*X3Titulo*/   	,/*Picture*/,/*Tamanho*/,/*lPixel*/, /*{|| code-block de impressao }*/ )
cPicture := PesqPict("SN5","N5_VALOR"+Str(mv_par05+1,1),20,mv_par05+1)
TRCell():New( oSection11, "ACRESCIMO"	, cAlias1,STR0046/*X3Titulo*/   	,If("Z" $ cPicture,cPicture, "@Z"+cPicture)/*Picture*/,21/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*RIGHT*/,,"RIGHT") //"Acréscimo"
TRCell():New( oSection11, "DECRESCIMO"	, cAlias1,STR0047/*X3Titulo*/   	,If("Z" $ cPicture,cPicture, "@Z"+cPicture)/*Picture*/,21/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*RIGHT*/,,"RIGHT") // "Decréscimo"
TRCell():New( oSection11, "SALDO"		, cAlias1,STR0048/*X3Titulo*/   	,PesqPict("SN5","N5_VALOR"+Str(mv_par05+1,1),20,mv_par05+1)/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*RIGHT*/,,"RIGHT") // "Saldo atual"

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RepPrtTopºAutor  ³Claudio D. de Souza º Data ³  23/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio para ambiente Top            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RepPrtTop( oReport )
Local oSection1  	:= oReport:Section(1)
Local oSection11 	:= oReport:Section(1):Section(1)
Local cChave		:= ""
Local cQuery		:= "SN5"
Local cQuery2		:= "SN5"
Local cAliasCt		:= "CT1"
Local cCampoCt		:= "%CT1_NORMAL, CT1_DESC01%"
Local cQuebra		:= ""
Local cWhere		:= ""
Local aMeses     	:= {OemToAnsi(STR0010),OemToAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015),;  //"Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"
						OemToAnsi(STR0016),OemToAnsi(STR0017),OemToAnsi(STR0018),OemToAnsi(STR0019),OemToAnsi(STR0020),OemToAnsi(STR0021)}   //"Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"
Local aMesExt    	:= {OemToAnsi(STR0022),OemToAnsi(STR0023),OemToAnsi(STR0024),OemToAnsi(STR0025),OemToAnsi(STR0026),OemToAnsi(STR0027),;  //"Janeiro"###"Fevereiro"###"Marco"###"Abril"###"Maio"###"Junho"
						OemToAnsi(STR0028),OemToAnsi(STR0029),OemToAnsi(STR0030),OemToAnsi(STR0031),OemToAnsi(STR0032),OemToAnsi(STR0033)}   //"Julho"###"Agosto"###"Setembro"###"Outubro"###"Novembro"###"Dezembro"

Local cAtfMoeda 	:= GETMV("MV_ATFMOEDA")
Local nSaldo	 	:= 0
Local nValor	 	:= 0
Local aSaldoAnt		:= {}
Local cGrupoPass 	:= GetMv("MV_GRPASS")
Local lCtb       	:= CtbInUse()
Local oBreak0		:= Nil
Local oBreak1		:= Nil
Local oBreak2		:= Nil		// Quebra por conta
Local oBreak3		:= Nil		// Quebra do Acumulador
Local cPicture 		:= PesqPict("SN5","N5_VALOR"+Str(mv_par05+1,1),20,mv_par05+1)
Local cPicture1     := PesqPict("SN5","N5_VALOR1",21,1)
Local oFunction		:= Nil
Local cMascara   	:= Iif(!Empty(GetMV("MV_MASCARA")), GetMV("MV_MASCARA"), "")
Local cFilDe		:= ""
Local cFilAte		:= ""
Local lNatCont		:= GetNewPar("MV_ATFNAT", "P") == "C"
Local nAcExVl1		:= 0	//Acumulado no Exercicio N5_VALOR1
Local nAcExAcr		:= 0	//Acumulado no Exercicio Acrescimo  =>  N5_TIPO $ "1234679BCFGJKPQTUY"
Local nAcExDec		:= 0	//Acumulado no Exercicio Decrescimo => !N5_TIPO $ "1234679BCFGJKPQTUY"
Local oMovMesVl1	:= nil	//Movimento no Mes N5_VALOR1
Local oMovMesAcr	:= nil	//Movimento no Mes Acrescimo  =>  N5_TIPO $ "1234679BCFGJKPQTUY"
Local oMovMesDec	:= nil	//Movimento no Mes Decrescimo => !N5_TIPO $ "1234679BCFGJKPQTUY"
Local lInverte		:= .F.
Local cFilAtu		:= ""
Local cTipoBem		:= ""
Local lSelFil		:= .F.
Local cTmpFil		:= ""
Local cSQLFil		:= ""
Local nStart		:= 0
Default aSelFil		:= {}

//cPicture := If( "Z" $ cPicture, cPicture, "@Z" + cPicture )
//cPicture1 := If( "Z" $ cPicture1, cPicture1, "@Z" + cPicture1 )
cChave := SN5->(IndexKey())

//Iniciar telemetria - Tempo médio
If __lMetric
	nStart := Seconds()
EndIf

If __lTabSld
	If MV_PAR15 == 1 //Fiscal
		cTipoBem := ATFXTpBem(1)
	ElseIf MV_PAR15 == 2 //Gerencial
		cTipoBem := ATFXTpBem(2)
	ElseIf MV_PAR15 == 3 //Incentivada
		cTipoBem := ATFXTpBem(3)
	EndIf
EndIf

cChave 	:= "%"+SqlOrder(cChave)+"%"

lSelFil := (MV_PAR16 == 1 )

If lSelFil
	if !IsBlind()
		AdmSelecFil("AFR130",16,.F.,@aSelFil,"SN5",.F.)
	EndIf
	If Empty(aSelFil)
		Aadd(aSelFil,cFilAnt)
	Endif
	cFilDe := aSelFil[1]
	cFilAte := aSelFil[Len(aSelFil)]
Else
	If mv_par11 == 2
		cFilDe	:= xFilial( "SN5" )
		cFilAte	:= xFilial( "SN5" )
	ELSE
		cFilDe	:= XFilial("SN5",mv_par12)	// Todas as filiais
		cFilAte	:= XFilial("SN5",mv_par13)
	Endif
Endif

If lCtb
	cJoin := "LEFT JOIN " + RetSqlName("CT1") + " CT1 ON "
	cJoin += "CT1.CT1_FILIAL =  '" + xFilial("CT1") + "' "
	cJoin += "AND CT1.CT1_CONTA = SN5.N5_CONTA "
	cJoin += "AND CT1.D_E_L_E_T_ = ' ' "
Else
	cCampoCt	:= "%I1_NORMAL, I1_DESC%"
	cJoin := "LEFT JOIN " + RetSqlName("SI1") + " SI1 ON "
	cJoin += "SI1.I1_FILIAL =  '" + xFilial("SI1") + "' "
	cJoin += "AND SI1.I1_CODIGO = SN5.N5_CONTA "
	cJoin += "AND SI1.D_E_L_E_T_ = ' ' "
Endif
cJoin := "%" + cJoin + "%"

cQuery	:= GetNextAlias()
cWhere	+= "N5_DATA <= '" + DTOS(LastDay(Ctod("01/" + StrZero(mv_par04,2)+"/" + StrZero(Year(dDataBase),4))))  + "' AND "

If __lTabSld
	If !Empty(MV_PAR14) .And. MV_PAR14 <> '*'
		cWhere	+= " N5_TPSALDO = '" + MV_PAR14 + "' AND "
	EndIf

	If MV_PAR15 <> 4 .And. !Empty(cTipoBem) //se não for todas
		cWhere	+= " N5_TPBEM IN " + FormatIn(cTipoBem,"/") + " AND "
	EndIf
EndIf

cWhere	:= "%" + cWhere + "%"

If lSelFil
	MsgRun(STR0056,STR0003 ,{|| cSQLFil := GetRngFil(aSelFil,"SN5",.T.,@cTmpFil)}) //"Favor Aguardar....."###"Razao Auxiliar"
	cSQLFil := "%SN5.N5_FILIAL " + cSQLFil + "%"
Else
	cSQLFil := "%SN5.N5_FILIAL >= '" + cFilDe + "' AND SN5.N5_FILIAL <= '" + cFilAte + "'%"
Endif

oSection1:BeginQuery()

BeginSql Alias cQuery
	SELECT N5_FILIAL, N5_CONTA
	FROM %table:SN5% SN5
	WHERE
	%Exp:cSQLFil% AND
	SN5.N5_FILIAL <= %Exp:cFilAte% AND
	SN5.N5_CONTA >= %Exp:mv_par01% AND
	SN5.N5_CONTA <= %Exp:mv_par02% AND
	%Exp:cWhere%
	SN5.%notDel%
	GROUP BY N5_FILIAL,N5_CONTA
	ORDER BY N5_FILIAL,N5_CONTA
EndSql

oSection1:EndQuery()

cQuery2		:= GetNextAlias()
cAliasCt	:= cQuery2
cWhere 		:= "N5_DATA >= '" + DTOS(FirstDay(Ctod("01/" + StrZero(mv_par03,2)+"/" + StrZero(Year(dDataBase),4))))  + "' AND "
cWhere 		+= "N5_DATA <= '" + DTOS(LastDay(Ctod("01/" + StrZero(mv_par04,2)+"/" + StrZero(Year(dDataBase),4))))  + "' AND "

If __lTabSld
	If !Empty(MV_PAR14) .And. MV_PAR14 <> '*'
		cWhere	+= " N5_TPSALDO = '" + MV_PAR14 + "' AND "
	EndIf

	If MV_PAR15 <> 4 .And. !Empty(cTipoBem) //se não for todas
		cWhere	+= " N5_TPBEM IN " + FormatIn(cTipoBem,"/") + " AND "
	EndIf
EndIf

cWhere  	:= "%" + cWhere + "%"

oSection11:BeginQuery()

BeginSql Alias cQuery2
	SELECT
	N5_FILIAL, N5_CONTA, N5_DATA, N5_TIPO, N5_TAXA, %Exp:cCampoCt%, SUM(N5_VALOR1) N5_VALOR1, SUM(N5_VALOR2) N5_VALOR2, SUM(N5_VALOR3) N5_VALOR3, SUM(N5_VALOR4) N5_VALOR4, SUM(N5_VALOR5) N5_VALOR5
	FROM %table:SN5% SN5
	%Exp:cJoin%
	WHERE
	%Exp:cSQLFil% AND
	SN5.N5_CONTA >= %Exp:mv_par01% AND
	SN5.N5_CONTA <= %Exp:mv_par02% AND
	%Exp:cWhere%
	SN5.%notDel%
	GROUP BY N5_FILIAL, N5_CONTA, N5_DATA, N5_TIPO, N5_TAXA, %Exp:cCampoCt%
	ORDER BY N5_FILIAL,N5_CONTA,N5_DATA,N5_TIPO
EndSql
oSection11:EndQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define o bloco de codigo que retornara o conteudo de impressão da celula.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Cell("N5_FILIAL"			):SetBlock( { ||(cQuery)->N5_FILIAL })
oSection1:Cell("N5_CONTA"				):SetBlock( { || MascaraCTB(N5_CONTA,cMascara) } )
If lCtb
	oSection1:Cell("CT1_DESC01"		):SetBlock( { || U_AtfDesc( N5_CONTA ) } )
Else
	oSection1:Cell("I1_DESC"			):SetBlock( { || U_AtfDesc( N5_CONTA ) } )
Endif
oSection1:Cell("SALDO ANTERIOR R$"		):SetBlock( { || aSaldoAnt := U_AtfSaldoAnt( (cQuery)->N5_CONTA, (cQuery)->N5_FILIAL), nAcExVl1 := aSaldoAnt[1], aSaldoAnt[1] } )
oSection1:Cell("SDO ANT MOEDA ATIVO"	):SetBlock( { || aSaldoAnt[mv_par05+1] } )

oSection1:Cell("SDO ANT MOEDA ATIVO"	):SetTitle(STR0043 + AllTrim( GETMV("MV_SIMB" + Str(mv_par05+1,1,0) ) ))
oSection1:Cell("SDO ANT MOEDA ATIVO"	):SetPicture(PesqPict("SN5","N5_VALOR"+Str(mv_par05+1,1),20,mv_par05+1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Trata a quebra por conta                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBreak2 := TRBreak():New( oSection1, oSection1:Cell("N5_CONTA"	), STR0039 )	// Quebra por Conta
oBreak2:OnPrintTotal({|| nAcExAcr := 0, nAcExDec := 0, nSaldo := 0})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Salto de Página                                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par06 == 1
	oBreak2:SetPageBreak(.T.)
EndIf


oSection1:setLineBreak(.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Segunda secao - oSection11                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection11:Cell("N5_CONTA"		):SetBlock( {|| (cQuery2)->N5_CONTA } )
oSection11:Cell("N5_CONTA"		):Disable()
if lNatCont
	oSection11:Cell("N5_VALOR1"	):SetBlock( { || (cQuery2)->N5_VALOR1 * If( (cQuery2)->N5_TIPO $"1234679BCFGJKPQTUY" , U_ChkFator(lInverte, (cQuery2)->N5_CONTA, "N5_VALOR1") , (U_ChkFator(lInverte, N5_CONTA) * -1))  } )
else
	oSection11:Cell("N5_VALOR1"	):SetBlock( { ||(cQuery2)->N5_VALOR1 * IIf((lInverte .And. (cQuery2)->N5_TIPO $ "1234679BCFGJKPQSVY") .Or. !(cQuery2)->N5_TIPO $ "01234679BCFGJKPQTUY", -1, 1 ) } )
endif
oSection11:Cell("REFERENCIA"	):SetBlock( { || aMeses[Month((cQuery2)->N5_DATA)]+"/"+Subs(StrZero(Year((cQuery2)->N5_DATA),4),3,2) } )
oSection11:Cell("N5_TAXA"		):SetBlock( { || IIf( (cQuery2)->N5_TAXA # 0 .and. (mv_par05 + 1) = Val(cAtfMoeda), (cQuery2)->N5_TAXA, (cQuery2)->N5_VALOR1 / &("N5_VALOR"+Str(mv_par05+1,1)) ) } )
if lNatCont
	oSection11:Cell("ACRESCIMO"	):SetBlock( { || &("N5_VALOR"+Str(mv_par05+1,1)) * U_ChkFator(lInverte, (cQuery2)->N5_CONTA, "ACRESCIMO") } )
	oSection11:Cell("DECRESCIMO"):SetBlock( { || &("N5_VALOR"+Str(mv_par05+1,1)) * U_ChkFator(lInverte, (cQuery2)->N5_CONTA, "DECRESCIMO") } )
	oSection11:Cell("SALDO"		):SetBlock( { || nSaldo += &("N5_VALOR"+Str(mv_par05+1,1)) * (If( (cQuery2)->N5_TIPO $"1234679BCFGJKPQTUY" , U_ChkFator(lInverte, (cQuery2)->N5_CONTA), (U_ChkFator(lInverte, (cQuery2)->N5_CONTA) * -1) )), aSaldoAnt[mv_par05+1] + nSaldo } )
else
	oSection11:Cell("ACRESCIMO"	):SetBlock( { || IIf( (cQuery2)->N5_TIPO $"1234679BCFGJKPQTUY",  &("N5_VALOR"+Str(mv_par05+1,1)), 0 ) } )
	oSection11:Cell("DECRESCIMO"):SetBlock( { || IIf( !(cQuery2)->N5_TIPO $"1234679BCFGJKPQTUY",  &("N5_VALOR"+Str(mv_par05+1,1)), 0 ) } )
	oSection11:Cell("SALDO"		):SetBlock( { || nSaldo += &("N5_VALOR"+Str(mv_par05+1,1)) * (If( (cQuery2)->N5_TIPO $"1234679BCFGJKPQTUY", 1, -1)), aSaldoAnt[mv_par05+1] + nSaldo } )
endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Configuracao de titulos e mascaras de exibicao das colunas                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection11:Cell("N5_VALOR1"	):SetTitle(OemToAnsi(STR0004)+AllTrim(GETMV("MV_SIMB1")))
oSection11:Cell("N5_TAXA"	):SetTitle(OemToAnsi(STR0005) + AllTrim( GETMV("MV_SIMB" + Str(mv_par05+1,1,0) ) ))
oSection11:Cell("N5_VALOR1"	):SetPicture(cPicture1)
oSection11:Cell("ACRESCIMO"	):SetPicture(cPicture)
oSection11:Cell("DECRESCIMO"):SetPicture(cPicture)
oSection11:Cell("SALDO"		):SetPicture(PesqPict("SN5","N5_VALOR"+Str(mv_par05+1,1),20,mv_par05+1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Trata a quebra por mes                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 == 1
	oBreak1 := TRBreak():New( oSection11, oSection11:Cell("REFERENCIA"), STR0050) // "Total do Mes"
	oBreak3 := TRBreak():New( oSection11, oSection11:Cell("REFERENCIA"), STR0054) // "Acumulado na Conta"
Else
	oBreak3 := TRBreak():New( oSection11, oSection11:Cell("N5_CONTA"), STR0054) // "Acumulado na Conta"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Totalizadores                                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Quebra Mensal - oBreak1 ----------------------------------------------------------
TRFunction():New(oSection11:Cell("N5_VALOR1"	),,"SUM"		,oBreak1,,,, .F., .F. )
TRFunction():New(oSection11:Cell("ACRESCIMO"	),,"SUM"		,oBreak1,,,, .F., .F. )
TRFunction():New(oSection11:Cell("DECRESCIMO"	),,"SUM"		,oBreak1,,,, .F., .F. )
// Quebra do Acumulador Mensal - oBreak3 --------------------------------------------
oMovMesVl1 := TRFunction():New(oSection11:Cell("N5_VALOR1"	),,"SUM",oBreak3,,,,.F.,.F.,,,, .T. /*CanPrint*/ )
oMovMesAcr := TRFunction():New(oSection11:Cell("ACRESCIMO"	),,"SUM",oBreak3,,,,.F.,.F.,,,, .T. /*CanPrint*/ )
oMovMesDec := TRFunction():New(oSection11:Cell("DECRESCIMO"	),,"SUM",oBreak3,,,,.F.,.F.,,,, .T. /*CanPrint*/ )
// Imprime o Acumulado do Exercicio
TRFunction():New(oSection11:Cell("N5_VALOR1"	),"","ONPRINT",oBreak3,,,{|| nAcExVl1 += oMovMesVl1:GetValue()},.F.,.F.)
TRFunction():New(oSection11:Cell("ACRESCIMO"	),"","ONPRINT",oBreak3,,,{|| nAcExAcr += oMovMesAcr:GetValue()},.F.,.F.)
TRFunction():New(oSection11:Cell("DECRESCIMO"	),"","ONPRINT",oBreak3,,,{|| nAcExDec += oMovMesDec:GetValue()},.F.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Outras Configuracoes                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Cria variável a ser usada para impressao do texto da quebra da secao
oSection11:SetLineCondition( { ||	If(	cQuebra != (MascaraCTB(N5_CONTA,cMascara) + " - " + (cAliasCt)->&(If(lCtb,"CT1_DESC01","I1_DESC"))), Nil, Nil ),;
										cQuebra := (MascaraCTB(N5_CONTA,cMascara) + " - " + (cAliasCt)->&(If(lCtb,"CT1_DESC01","I1_DESC"))),;
										lInverte := (If(lCtb,(cAliasCt)->CT1_NORMAL=="1",(cAliasCt)->I1_NORMAL=="D") .And. SUBS(N5_CONTA,1,1)$cGrupoPass), N5_TIPO <> '0' } )
oSection11:SetTotalText({ ||  STR0049 + cQuebra } ) // "Total da Conta: "
oReport:SetPageNumber(Val(mv_par08))
oSection11:SetTotalInLine(.F.)  //Imprime os Totais das Colunas em linha

oSection11:SetParentFilter( {||	(cQuery)->(N5_FILIAL + N5_CONTA) == (cQuery2)->(N5_FILIAL + N5_CONTA) }, {|| (cQuery2)->(N5_FILIAL + N5_CONTA) } )

cFilAtu := (cQuery)->N5_FILIAL

oSection1:OnPrintLine( {|| If( cFilAtu <> (cQuery)->N5_FILIAL, (oReport:EndPage(),cfilAtu := (cQuery)->N5_FILIAL),)})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a Impressao                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Print()

If lSelFil
	If !Empty(cTmpFil)
		MsgRun(STR0056,STR0003 ,{|| CtbTmpErase(cTmpFil)}) //"Favor Aguardar....."###"Razao Auxiliar"
	Endif
Endif

//Gerar metrica FWMetrics - Tempo médio
If __lMetric
	ATR130Metrics("01" /*cEvent*/, nStart, "001" /*cSubEvent*/, Alltrim(ProcName()) /*cSubRoutine*/)
	nStart := 0
EndIf
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RepPrtDBFºAutor  ³Alvaro Camillo Neto          ³  15/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio para ambiente DBF            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RepPrtDBF( oReport )
Local oSection1  	:= oReport:Section(1)
Local oSection11 	:= oReport:Section(1):Section(1)
Local oTotalDBF 	:= oReport:Section(2)

Local cConta,aSaldos[5],nMoeda
Local nMesDe,nMesAte,nFirst:=0
Local lValor
Local nTotAcresc := 0
Local nTotDimin  := 0
Local cRefere    := " "
Local nValorX    := 0
Local nMoedaX    := 0
Local cAtfMoeda := GETMV("MV_ATFMOEDA")
Local aMeses     := {OemToAnsi(STR0010),OemToAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015),;  //"Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"
OemToAnsi(STR0016),OemToAnsi(STR0017),OemToAnsi(STR0018),OemToAnsi(STR0019),OemToAnsi(STR0020),OemToAnsi(STR0021)}   //"Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"

Local aMesExt    := {OemToAnsi(STR0022),OemToAnsi(STR0023),OemToAnsi(STR0024),OemToAnsi(STR0025),OemToAnsi(STR0026),OemToAnsi(STR0027),;  //"Janeiro"###"Fevereiro"###"Marco"###"Abril"###"Maio"###"Junho"
OemToAnsi(STR0028),OemToAnsi(STR0029),OemToAnsi(STR0030),OemToAnsi(STR0031),OemToAnsi(STR0032),OemToAnsi(STR0033)}   //"Julho"###"Agosto"###"Setembro"###"Outubro"###"Novembro"###"Dezembro"

Local aTotMeses		:= {0,0,0,0,0}
Local aSaldoDia		:= {0,0,0,0,0}
Local aSldConta		:= {}
Local dMesAtual  := cTod("")
Local nTacMes    := 0
Local nTdimMes   := 0
Local nSACMes    := 0
Local nSDIMMes   := 0
Local CbTxt
Local cbCont
Local limite:=132
Local cGrupoPass := GetMv("MV_GRPASS")
Local lInverte   := .F.
Local lCtb       := CtbInUse()
Local cFilDe  := cFilAnt
Local cFilAte := cFilAnt
Local cFilOld := cFilAnt
Local cTitAux
Local cMascara   := Iif(!Empty(GetMV("MV_MASCARA")), GetMV("MV_MASCARA"), "")
Local lNatCont	:= GetNewPar("MV_ATFNAT", "P") == "C"
Local nFator	:= 1
Local nInc		:= 0
Local aSM0		:= AdmAbreSM0()
Local cFilAtu	:= ""
Local cTipoBem		:= ""
Local n_pagini 	:= Val(MV_PAR08)
Local n_pagFim		:= Val(MV_PAR09)
Local n_pagRes		:= Val(MV_PAR10)
Local cFilProc		:= ""
Local lExclusivo	:= AdmTabExc("SN5") //Analisa se a tabela esta exclusiva

If __lTabSld
	If MV_PAR15 == 1 //Fiscal
		cTipoBem := ATFXTpBem(1)
	ElseIf MV_PAR15 == 2 //Gerencial
		cTipoBem := ATFXTpBem(2)
	ElseIf MV_PAR15 == 3 //Incentivada
		cTipoBem := ATFXTpBem(3)
	EndIf
EndIf

//Controle de reincio da numeracao de paginas
oReport:SetPageNumber(n_pagini)
oReport:OnPageBreak( {|| If((n_pagini+1) > n_pagFim, (n_pagini := n_pagRes,oReport:SetPageNumber(n_pagini-1)),n_pagini += 1) } )
oSection11:Cell("N5_CONTA"		):Disable()

oSection1:SetHeaderSection(.T.)
oSection11:SetHeaderSection(.T.)

oTotalDBF:Cell("REFERENCIA"):Hide()
oTotalDBF:Cell("N5_TAXA"):Hide()

If mv_par11 == 1 // considera filiais
	cFilDe := mv_par12
	cFilAte := mv_par13
Endif

// Processa todo o arquivo de filiais ou apenas a filial atual
For nInc := 1 To Len( aSM0 )
	If aSM0[nInc][1] == cEmpAnt .AND. aSM0[nInc][2] >= cFilDe .AND. aSM0[nInc][2] <= cFilAte
		cFilAnt := aSM0[nInc][2]
		//titulo := cTitAux + Iif(mv_par11==1," / Filial " + cFilAnt+" - " + AllTrim(SM0->M0_FILIAL),"")

		//Tratamento Gestao Corporativa
		If Len(AllTrim(xFilial("SN5")) ) > 2
			If Alltrim(cFilProc) != Alltrim(xFilial("SN5"))
				cFilProc:= xFilial("SN5")
			Else
				Loop
			EndIf
		EndIf

		dbSelectArea( "SN5" )
		dbseek( xFilial("SN5")+mv_par01, .T. )

		If oReport:Cancel()
			Exit
		EndIf

		If !Empty(SN5->N5_FILIAL)
			cFilAtu := STR0055 + " " + SN5->N5_FILIAL + "  "
		Endif

		cMoeda  := Str(mv_par05+1,1)
		nMoeda  := mv_par05+1
		nMesDe  := mv_par03
		nMesAte := mv_par04

		While ! SN5->(Eof()) .And. SN5->N5_FILIAL==xFilial("SN5") .And. SN5->N5_CONTA<=mv_par02

			If __lTabSld
				If !Empty(MV_PAR14) .And. MV_PAR14 <> '*' .And. Alltrim(SN5->N5_TPSALDO) != Alltrim(MV_PAR14)
					SN5->(DbSkip())
					Loop
				EndIf

				If MV_PAR15 <> 4 .And. !Empty(cTipoBem)  .And. ! ( Alltrim(SN5->N5_TPBEM) $ Alltrim(cTipoBem) )
					SN5->(DbSkip())
					Loop
				EndIf
			EndIf

			nFator := U_ChkFator( lInverte, SN5->N5_CONTA )

			If oReport:Cancel()
				Exit
			EndIf

			lInverte := .F.
			cConta := SN5->N5_CONTA
			nFirst := 0

			If lCtb
				dbSelectArea("CT1")
				dbSetOrder(1)
				If dbSeek(xFilial("CT1")+cConta)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ lInverte ‚ .T. se conta pertence ao grupo de contas Credoras (cGru-³
					//³ poPass),I1_NORMAL = "C", mas o saldo e devedor                     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If (CT1->CT1_NORMAL=="1" .And. SUBS(cConta,1,1)$cGrupoPass)
						lInverte := .T.
					Endif
				Endif
			Else
				dbSelectArea("SI1")
				dbSetOrder(1)
				If dbSeek(xFilial("SI1")+cConta)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ lInverte ‚ .T. se conta pertence ao grupo de contas Credoras (cGru-³
					//³ poPass),I1_NORMAL = "C", mas o saldo e devedor                     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If (SI1->I1_NORMAL=="D" .And. SUBS(cConta,1,1)$cGrupoPass)
						lInverte := .T.
					Endif
				Endif
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula Saldo Inicial.O saldo inicial nao muda de sinal, pois  ³
			//³na virada anual j  vem c/ o sinal correto de acordo com a condi-³
			//³‡„o da conta (I1_NORMAL).                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SN5")
			IF SN5->N5_TIPO == "0"
				aSaldos[1] := SN5->N5_VALOR1 * nFator
				aSaldos[2] := SN5->N5_VALOR2 * nFator
				aSaldos[3] := SN5->N5_VALOR3 * nFator
				aSaldos[4] := SN5->N5_VALOR4 * nFator
				aSaldos[5] := SN5->N5_VALOR5 * nFator
				SN5->( dbSkip())
			Else
				Afill( aSaldos, 0 )
			End

			Afill( aTotMeses, 0 )
			aSldConta := aClone( aSaldos )

			While !SN5->( Eof() ) .and. xFilial("SN5")==SN5->N5_FILIAL .And. SN5->N5_CONTA == cConta

				nFator := U_ChkFator( lInverte, SN5->N5_CONTA )
				If oReport:Cancel()
					Exit
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se nao ultrapassou o intervalo solicitado                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				IF (Month(SN5->N5_DATA) > nMesAte .and. Year(SN5->N5_DATA) >= Year(dDataBase)).or. Year(SN5->N5_DATA) > Year(dDataBase)
					SN5->(dbSkip())
					Loop
				Endif

				If __lTabSld
					If !Empty(MV_PAR14) .And. MV_PAR14 <> '*' .And. Alltrim(SN5->N5_TPSALDO) != Alltrim(MV_PAR14)
						SN5->(DbSkip())
						Loop
					EndIf

					If MV_PAR15 <> 4 .And. !Empty(cTipoBem)  .And. ! ( Alltrim(SN5->N5_TPBEM) $ Alltrim(cTipoBem) )
						SN5->(DbSkip())
						Loop
					EndIf
				EndIf


				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Acumula o saldo anterior. Neste caso, considero o lInverte pois es-³
				//³ tou gerando o saldo anterior lendo os registros de movimentos do   ³
				//³ SN5 e n„o o registro de saldo inicial.                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF Month( SN5->N5_DATA ) < nMesDe .or. Year( SN5->N5_DATA ) < Year( dDataBase )
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ N5_tipo == 0 +- Saldo Inicial ( D/C)        ³
					//³            1  + Imobilizacao                ³
					//³            2  + Ampliacao                   ³
					//³            3  + Reavaliacao                 ³
					//³            4  + Depreciacao                 ³
					//³            5  - Baixa                       ³
					//³            6  + Corr.Monet.                 ³
					//³            7  + Corr.Monet.Depr.            ³
					//³            8  - Transf.de                   ³
					//³            9  + Transf.para                 ³
					//³            A  - Imob Capital                ³
					//³            B  + Imob Capital                ³
					//³            C  + Baixa Capital               ³
					//³            D  - Baixa Capital c/Prejuizo    ³
					//³            E  - Amplia‡„o Capital           ³
					//³            F  + Amplia‡„o Capital Prejuizo  ³
					//³            G  + Transf DE Patrimonio        ³
					//³            H  - Transf DE Patrimonio Prej.  ³
					//³            I  - Transf P/ Patrimonio        ³
					//³            J  + Transf P/ Patrimonio Prej.  ³
					//³            K  + Deprec Acelerada Positiva   ³
					//³            L  - Deprec Acelerada Negativa   ³
					//³            M  + Equiv Patrimonial Positiva  ³
					//³            N  - Equiv Patrimonial Negativa  ³
					//³            O  - Correcao de capital  "SCA"  ³
					//³            P  +/- Invent rio                ³
					//³            Q  + Aquis por Transferencia     ³
					//³            R  - Baixa por Aquis por Transf  ³
					//³            S  - Transf de bem entre Filiais ³
					//³            T  + Transf p/ bem entre Filiais ³
					//³            U  + Transf de Patr entre Filiais³
					//³            V  - Transf p/ Patr entre Filiais³
					//³            Y  + Depreciacao Gerencial       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lNatCont
						lValor := nFator == 1
						aSaldos [ 1 ]        += SN5->N5_VALOR1 * nFator
						aSaldos [ nMoeda ]   += &('SN5->N5_VALOR'+cMoeda) * nFator

						aSldConta [ 1 ]      += SN5->N5_VALOR1 * nFator
						aSldConta [ nMoeda ] += &('SN5->N5_VALOR'+cMoeda) * nFator

					ElseIf lInverte
						If SN5->N5_TIPO $ "1234679BCFGJKPQSVY"
							aSaldos [ 1 ]        -= SN5->N5_VALOR1
							aSaldos [ nMoeda ]   -= &('SN5->N5_VALOR'+cMoeda)

							aSldConta [ 1 ]      -= SN5->N5_VALOR1
							aSldConta [ nMoeda ] -= &('SN5->N5_VALOR'+cMoeda)
						Else
							aSaldos [ 1 ]        += SN5->N5_VALOR1
							aSaldos [ nMoeda ]   += &('SN5->N5_VALOR'+cMoeda)

							aSldConta [ 1 ]      += SN5->N5_VALOR1
							aSldConta [ nMoeda ] += &('SN5->N5_VALOR'+cMoeda)
						Endif
					Else
						If SN5->N5_TIPO $ "1234679BCFGJKPQTUY"
							aSaldos [ 1 ]        += SN5->N5_VALOR1
							aSaldos [ nMoeda ]   += &('SN5->N5_VALOR'+cMoeda)

							aSldConta [ 1 ]      += SN5->N5_VALOR1
							aSldConta [ nMoeda ] += &('SN5->N5_VALOR'+cMoeda)
						Else
							aSaldos [ 1 ]        -= SN5->N5_VALOR1
							aSaldos [ nMoeda ]   -= &('SN5->N5_VALOR'+cMoeda)

							aSldConta [ 1 ]      -= SN5->N5_VALOR1
							aSldConta [ nMoeda ] -= &('SN5->N5_VALOR'+cMoeda)
						Endif
					Endif

					SN5->( dbSkip( ) )
					Loop
				Endif

				IF nFirst == 0
					nFirst++
					oSection1:Init()

					oSection1:Cell("N5_FILIAL"):SetValue( SN5->N5_FILIAL )
					oSection1:Cell("N5_CONTA"):SetValue( MascaraCTB(cConta,cMascara) )

					If lCtb
						dbSelectArea("CT1")
						dbSetOrder( 1 )
						dbSeek(cFilial+cConta)
						oSection1:Cell("CT1_DESC01"):SetValue( CT1->CT1_DESC01 )
					Else
						dbSelectArea("SI1")
						SI1->( dbSetOrder( 1 ) )
						SI1->( dbSeek( cFilial+cConta ) )
						oSection1:Cell("I1_DESC"):SetValue(SI1->I1_DESC)
					EndIf

					oSection1:Cell("SALDO ANTERIOR R$"):SetValue( aSaldos[1] )
					oSection1:Cell("SDO ANT MOEDA ATIVO"):SetValue( aSaldos[nMoeda] )

					oSection1:PrintLine()
					oSection1:Finish()
					dbSelectArea ( "SN5" )
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Impressao da movimentacao identificada                              ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cRefere := aMeses[Month(SN5->N5_DATA)]+"/"+Subs(StrZero(Year(SN5->N5_DATA),4),3,2)

				Afill( aSaldoDia, 0 )
				dDataAtu := SN5->N5_DATA
				dDataOri := SN5->N5_DATA
				cTipoAtu := SN5->N5_TIPO
				cTipoOri := SN5->N5_TIPO
				nTaxaOri	:= SN5->N5_TAXA
				cContaOri   := SN5->N5_CONTA

				lValor:=.F.
				If lNatCont
					lValor := SN5->N5_TIPO $"1234679ABCFGJKPQSVY"
				ElseIf lInverte
					If SN5->N5_TIPO $"1234679BCFGJKPQSVY"
						lValor := .T.
					Endif
				Else
					If SN5->N5_TIPO $"1234679BCFGJKPQTUY"
						lValor := .T.
					Endif
				Endif

				oSection11:Init()
				While !SN5->( Eof() ) .and. xFilial("SN5")==SN5->N5_FILIAL .And. SN5->N5_CONTA == cConta .And. SN5->N5_DATA == dDataAtu .And. SN5->N5_TIPO == cTipoAtu

					If __lTabSld
						If !Empty(MV_PAR14) .And. MV_PAR14 <> '*' .And. Alltrim(SN5->N5_TPSALDO) != Alltrim(MV_PAR14)
							SN5->(DbSkip())
							Loop
						EndIf

						If MV_PAR15 <> 4 .And. !Empty(cTipoBem)  .And. ! ( Alltrim(SN5->N5_TPBEM) $ Alltrim(cTipoBem) )
							SN5->(DbSkip())
							Loop
						EndIf
					EndIf

					nFator := If( !lValor, -1, 1 )
					aSaldoDia[1] 	    	+= SN5->N5_VALOR1 * nFator
					aSaldoDia[nMoeda]    += &('SN5->N5_VALOR'+cMoeda) * nFator
					aSaldos [ 1 ]        += SN5->N5_VALOR1 * nFator
					aSaldos [ nMoeda ]   += &('SN5->N5_VALOR'+cMoeda) * nFator
					aTotMeses [ 1 ]      += SN5->N5_VALOR1 * nFator
					aTotMeses [ nMoeda ] += &('SN5->N5_VALOR'+cMoeda) * nFator

					If lValor
						nTotAcresc += &('SN5->N5_VALOR'+cMoeda)
						nTacMes    += &('SN5->N5_VALOR'+cMoeda)
					Else
						nTotDimin  += &('SN5->N5_VALOR'+cMoeda)
						nTdimMes   += &('SN5->N5_VALOR'+cMoeda)
					EndIf

					dDataAtu := SN5->N5_DATA
					cTipoAtu := SN5->N5_TIPO
					dDataAtu 	:= SN5->N5_DATA
					cTipoAtu 	:= SN5->N5_TIPO
					dMesAtual   := SN5->N5_DATA
					cContaAtual := SN5->N5_CONTA

					SN5->(dbSkip())
				EndDo

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³  Imprime o valor registrado da ufir se o valor da ufir for registrada e            ³
				//³  se a moeda do relat¢rio for ufir.                                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If SN5->N5_TAXA # 0 .and. (mv_par05 + 1) = Val(cAtfMoeda)
					nMoedaX := nTaxaOri
				Else
					If nValorX == 0
						nMoedaX := IIF(aSaldos[nMoeda] <> 0, aSaldos[1] / aSaldos[nMoeda], 0)
					Else
						nMoedaX := aSaldoDia[1] / ABS( nValorX )
					Endif
				Endif

				oSection11:Cell("N5_DATA"):SetValue( dDataOri )
				oSection11:Cell("N5_TIPO"):SetValue( AFDescSal( cTipoOri ) )

				oSection11:Cell("N5_VALOR1"):SetValue( aSaldoDia[1] )
				oSection11:Cell("REFERENCIA"):SetValue( cRefere )
				oSection11:Cell("N5_TAXA"):SetValue( nMoedaX )

				If lValor
					oSection11:Cell("ACRESCIMO"):SetValue( ABS(aSaldoDia[nMoeda])  )
					oSection11:Cell("DECRESCIMO"):SetValue( 0 )
				Else
					oSection11:Cell("DECRESCIMO"):SetValue( ABS(aSaldoDia[nMoeda]) )
					oSection11:Cell("ACRESCIMO"):SetValue( 0 )
				EndIf
				oSection11:Cell("SALDO"):SetValue( aSaldos[nMoeda]  )
				oSection11:PrintLine()


				dMesAtual   := dDataOri
				cContaAtual := cConta

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Trata a quebra por mes                                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par07 == 1 .and. nFirst # 0

					If Month(SN5->N5_DATA)     # Month(dMesAtual)  .or. ;
						Year(SN5->N5_DATA)   # Year(dMesAtual)    .or. ;
						SN5->N5_CONTA # cConta

						oTotalDBF:Cell("TEXTO"):SetTitle(OemToAnsi(STR0038)+Iif(!Empty(dMesAtual), aMesExt[Month(dMesAtual)], "") )
						oTotalDBF:Init()
						oTotalDBF:Cell("N5_VALOR1"):SetValue( aTotMeses[1])
						oTotalDBF:Cell("ACRESCIMO"):SetValue( nTacMes )
						oTotalDBF:Cell("DECRESCIMO"):SetValue( nTdimMes  )
						oTotalDBF:PrintLine()
						oTotalDBF:Finish()
						// Atualiza Acumuladores.------------
						aSldConta[1]		+= aTotMeses[1]
						aSldConta[nMoeda]	+= aTotMeses[nMoeda]
						nSACMes				+= nTacMes
						nSDIMMes		   	+= nTDimMes
						nTacMes				:= 0
						nTdimMes		    	:= 0
						afill(aTotMeses ,0)
						// ----------------------------------
						oTotalDBF:Cell("TEXTO"):SetTitle(STR0054)
						oTotalDBF:Init()
						oTotalDBF:Cell("N5_VALOR1"):SetValue( aSldConta[1])
						oTotalDBF:Cell("ACRESCIMO"):SetValue( nSACMes )
						oTotalDBF:Cell("DECRESCIMO"):SetValue( nSDIMMes  )
						oTotalDBF:PrintLine()
						oTotalDBF:Finish()

					Endif

				Endif
			Enddo
			oSection11:Finish()

			IF nFirst != 0
				oTotalDBF:Cell("TEXTO"):SetTitle(STR0054)//"Acumulado na Conta"
				oTotalDBF:Init()
				If mv_par07 # 1
					oTotalDBF:Cell("N5_VALOR1"):SetValue( aSaldos[1] )
					oTotalDBF:Cell("ACRESCIMO"):SetValue( nTotAcresc )
					oTotalDBF:Cell("DECRESCIMO"):SetValue( nTotDimin  )
					oTotalDBF:Cell("SALDO"):SetValue( aSaldos[nMoeda]  )
				elseif	mv_par07 # 2 // Se houver quebra por mes.
					oTotalDBF:Cell("N5_VALOR1"):SetValue( aSldConta[1] )
					oTotalDBF:Cell("ACRESCIMO"):SetValue( nSACMes )
					oTotalDBF:Cell("DECRESCIMO"):SetValue( nSDIMMes  )
					oTotalDBF:Cell("SALDO"):SetValue( aSldConta[nMoeda]  )
				Endif
				oTotalDBF:PrintLine()
				oTotalDBF:Finish()

				nTotAcresc	:= 0
				nTotDimin	:= 0
				nSACMes		:= 0
				nSDIMMes	:= 0
				afill( aSldConta, 0 )
			Endif

			IF MV_PAR06 == 1
				oReport:EndPage()
			Endif
			dbSelectArea ( "SN5" )
		Enddo

		oReport:EndPage()
		If !lExclusivo
			Exit
		Endif
	EndIf
Next

// Restaura a filial
cFilAnt := cFilOld


SN5->( dbClearFilter() )
dbSelectArea( "SN5" )
SN5->( dbSetOrder( 1 ) )

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtfSaldoAntºAutor  ³Claudio D. de Souza º Data ³  18/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o saldo anterior de uma conta                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AtfSAldoAnt(cConta, cFil)
Local cAliasSn5 := "SN5"
Local cAliasCt		:= "CT1"
Local aRet := { 0,0,0,0,0 }
Local aAreaSN5 := SN5->(GetArea())
Local lInverte := .F.
Local cGrupoPass := GetMv("MV_GRPASS")
Local lNatCont := GetNewPar("MV_ATFNAT", "P") == "C"
Local cTipoBem			:= ""
Local cWhere
Local cCampoCt		:= "%CT1_NORMAL%"
Local nTamValor1 := TamSx3("N5_VALOR1")[1]
Local nDecValor1 := TamSx3("N5_VALOR1")[2]
Local nTamValor2 := TamSx3("N5_VALOR2")[1]
Local nDecValor2 := TamSx3("N5_VALOR2")[2]
Local nTamValor3 := TamSx3("N5_VALOR3")[1]
Local nDecValor3 := TamSx3("N5_VALOR3")[2]
Local nTamValor4 := TamSx3("N5_VALOR4")[1]
Local nDecValor4 := TamSx3("N5_VALOR4")[2]
Local nTamValor5 := TamSx3("N5_VALOR5")[1]
Local nDecValor5 := TamSx3("N5_VALOR5")[2]
Local cJoin
Local lCtb := CtbInUse()
Local cWhereTp := "%%"

If __lTabSld
	If MV_PAR15 == 1 //Fiscal
		cTipoBem := ATFXTpBem(1)
	ElseIf MV_PAR15 == 2 //Gerencial
		cTipoBem := ATFXTpBem(2)
	ElseIf MV_PAR15 == 3 //Incentivada
		cTipoBem := ATFXTpBem(3)
	EndIf
EndIf

	cWhere 	 := " N5_DATA <= '" + DTOS(FirstDay(Ctod("01/" + StrZero(mv_par03,2)+"/" + StrZero(Year(dDataBase),4))))  + "' "

	If __lTabSld
		If !Empty(MV_PAR14) .And. MV_PAR14 <> '*'
			cWhere	+= " AND N5_TPSALDO = '" + MV_PAR14 + "' "
		EndIf

		If MV_PAR15 <> 4 .And. !Empty(cTipoBem)
			cWhere	+= " AND N5_TPBEM IN " + FormatIn(cTipoBem,"/") + " "
			cWhereTp := "% AND N5_TPBEM IN " + FormatIn(cTipoBem,"/") + "%"
		EndIf

	EndIf
	cWhere  	:= "%" + cWhere + "%"

	cAliasSn5 := GetNextAlias()

	If lCtb
		cJoin := "LEFT JOIN " + RetSqlName("CT1") + " CT1 ON "
		cJoin += "CT1.CT1_FILIAL =  '" + xFilial("CT1") + "' "
		cJoin += "AND CT1.CT1_CONTA = SN5.N5_CONTA "
		cJoin += "AND CT1.D_E_L_E_T_ = ' ' "
	Else
		cAliasCt	:= "SI1"
		cCampoCt	:= "%I1_NORMAL%"
		cJoin := "LEFT JOIN " + RetSqlName("SI1") + " SI1 ON "
		cJoin += "SI1.I1_FILIAL =  '" + xFilial("SI1") + "' "
		cJoin += "AND SI1.I1_CODIGO = SN5.N5_CONTA "
		cJoin += "AND SI1.D_E_L_E_T_ = ' ' "
	Endif
	cJoin := "%" + cJoin + "%"

	BeginSql Alias cAliasSn5
		COLUMN N5_DATA   AS DATE
		COLUMN N5_VALOR1 AS NUMERIC(nTamValor1,nDecValor1)
		COLUMN N5_VALOR2 AS NUMERIC(nTamValor2,nDecValor2)
		COLUMN N5_VALOR3 AS NUMERIC(nTamValor3,nDecValor3)
		COLUMN N5_VALOR4 AS NUMERIC(nTamValor4,nDecValor4)
		COLUMN N5_VALOR5 AS NUMERIC(nTamValor5,nDecValor5)
		SELECT
			N5_FILIAL, N5_CONTA, N5_TIPO, N5_DATA, N5_VALOR1, N5_VALOR2, N5_VALOR3, N5_VALOR4, N5_VALOR5, %Exp:cCampoCt%
		FROM %table:SN5% SN5
		%Exp:cJoin%
		WHERE
   			SN5.N5_FILIAL = %Exp:cFil% AND
			SN5.N5_CONTA = %Exp:cConta% AND
			( (SN5.N5_TIPO = '0' %Exp:cWhereTp% ) OR
			%Exp:cWhere%) AND
			SN5.%notDel%
	EndSql

While (cAliasSn5)->(!Eof()) .And. ;
		(cAliasSn5)->N5_FILIAL == cFil .And.;
		(cAliasSn5)->N5_CONTA == cConta
	If (cAliasSn5)->N5_TIPO == "0" .Or.;
		Month( (cAliasSn5)->N5_DATA ) < mv_par03 .Or.;
		Year( (cAliasSn5)->N5_DATA ) < Year( dDataBase )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ lInverte ‚ .T. se conta pertence ao grupo de contas Credoras (cGru-³
		//³ poPass),I1_NORMAL = "D", mas o saldo e devedor                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lInverte := If(lCtb,(cAliasCt)->CT1_NORMAL=="1", (cAliasCt)->I1_NORMAL=="D") .And. SUBS(cConta,1,1)$cGrupoPass

        if lNatCont
			aRet[1] += (cAliasSn5)->N5_VALOR1 * U_ChkFator( lInverte, (cAliasSn5)->N5_CONTA )
			aRet[2] += (cAliasSn5)->N5_VALOR2 * U_ChkFator( lInverte, (cAliasSn5)->N5_CONTA )
			aRet[3] += (cAliasSn5)->N5_VALOR3 * U_ChkFator( lInverte, (cAliasSn5)->N5_CONTA )
			aRet[4] += (cAliasSn5)->N5_VALOR4 * U_ChkFator( lInverte, (cAliasSn5)->N5_CONTA )
			aRet[5] += (cAliasSn5)->N5_VALOR5 * U_ChkFator( lInverte, (cAliasSn5)->N5_CONTA )
        else
			aRet[1] += (cAliasSn5)->N5_VALOR1 * If(((cAliasSn5)->N5_TIPO $ "1234679BCFGJKPQSVY" .And. lInverte) .Or.;
			! (cAliasSn5)->N5_TIPO $ "01234679BCFGJKPQTUY", (-1), 1)

			aRet[2] += (cAliasSn5)->N5_VALOR2 * If(((cAliasSn5)->N5_TIPO $ "1234679BCFGJKPQSVY" .And. lInverte) .Or.;
			! (cAliasSn5)->N5_TIPO $ "01234679BCFGJKPQTUY", (-1), 1)

			aRet[3] += (cAliasSn5)->N5_VALOR3 * If(((cAliasSn5)->N5_TIPO $ "1234679BCFGJKPQSVY" .And. lInverte) .Or.;
			! (cAliasSn5)->N5_TIPO $ "01234679BCFGJKPQTUY", (-1), 1)

			aRet[4] += (cAliasSn5)->N5_VALOR4 * If(((cAliasSn5)->N5_TIPO $ "1234679BCFGJKPQSVY" .And. lInverte) .Or.;
			! (cAliasSn5)->N5_TIPO $ "01234679BCFGJKPQTUY", (-1), 1)

			aRet[5] += (cAliasSn5)->N5_VALOR5 * If(((cAliasSn5)->N5_TIPO $ "1234679BCFGJKPQSVY" .And. lInverte) .Or.;
			! (cAliasSn5)->N5_TIPO $ "01234679BCFGJKPQTUY", (-1), 1)
		endif


	Endif
	(cAliasSn5)->(DbSkip())
End

(cAliasSn5)->(DbCloseArea())

SN5->(RestArea(aAreaSN5))

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR130   ºAutor  ³Microsiga           º Data ³  08/21/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ChkFator( lInverte, cCONTA, cAcrDecr, cTipo )
Local lNatCont		:= GetNewPar("MV_ATFNAT", "P") == "C"
Local nChkFator		:= 1

Default cConta		:= SN5->N5_CONTA
Default lInverte	:= .F.
Default cAcrDecr	:= ''
Default cTipo	   := N5_TIPO

If lNatCont
	nChkFator := GetFator( cConta )
ElseIf	( lInverte .And. cTipo $ "1234679BCFGJKPQSVY" ) .or.;
	!N5_TIPO $ "01234679BCFGJKPQTUY"
	nChkFator := ( -1 )
Endif

if	((cAcrDecr == "ACRESCIMO" ) .and. (!cTipo $"1234679ABCFGJKPQTUY")) .or.;
	((cAcrDecr == "DECRESCIMO") .and. ( cTipo $"1234679ABCFGJKPQTUY"))
	nChkFator := 0
endif

Return nChkFator

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AtfDesc   ºAutor  ³ Totvs              º Data ³  05/09/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna a descricao do plano de contas                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AtfDesc( cCodigo )
	Local cReturn := ""

	If CtbInUse()
		DbSelectArea( "CT1" )
		DbSetOrder( 1 )
		If CT1->( DbSeek( xFilial( "CT1" ) + cCodigo ) )
			cReturn := CT1->CT1_DESC01
		EndIf
	Else
		DbSelectArea( "SI1" )
		DbSetOrder( 1 )
		If SI1->( DbSeek( xFilial( "SI1" ) + cCodigo ) )
			cReturn := SI1->I1_DESC
		EndIf
	EndIf

Return cReturn

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AdmAbreSM0³ Autor ³ Orizio                ³ Data ³ 22/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AdmAbreSM0()
	Local aArea			:= SM0->( GetArea() )
	Local aAux			:= {}
	Local aRetSM0		:= {}
	Local lFWLoadSM0	:= .T.
	Local lFWCodFilSM0 	:= .T.

	If lFWLoadSM0
		aRetSM0	:= FWLoadSM0()
	Else
		DbSelectArea( "SM0" )
		SM0->( DbGoTop() )
		While SM0->( !Eof() )
			aAux := { 	SM0->M0_CODIGO,;
						IIf( lFWCodFilSM0, FWGETCODFILIAL, SM0->M0_CODFIL ),;
						"",;
						"",;
						"",;
						SM0->M0_NOME,;
						SM0->M0_FILIAL }

			aAdd( aRetSM0, aClone( aAux ) )
			SM0->( DbSkip() )
		End
	EndIf

	RestArea( aArea )
Return aRetSM0

/*/{Protheus.doc} ATR130Metrics
	
	ATR130Metrics - Função utilizada para metricas no ATR130Metrics

	@type  Static Function
	@author user
	@since date
	@version version
	@param param, param_type, param_descr
	@return return, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function ATR130Metrics(cEvent, nStart, cSubEvent, cSubRoutine, nQtdReg)

Local cFunBkp	:= ""
Local cFunMet	:= ""

Local nFim := 0

Local cIdMetric  := ""
Local dDateSend := CtoD("") 
Local nLapTime := 0
Local cTotal := ""

Default cEvent := ""
Default nStart := Seconds()
Default cSubEvent := ""
Default cSubRoutine := Alltrim(ProcName(1))
Default nQtdReg := 0

//Só capturar metricas se a versão da lib for superior a 20210517
If __lMetric .And. !Empty(cEvent)
	
	//grava funname atual na variavel cFunBkp
	cFunBkp := FunName()

	If cEvent == "01" //Evento 01 - Metrica de tempo médio

		
		If cSubEvent == '001' // 001 = R4
			
			cFunMet := Iif(AllTrim(cFunBkp)=='RPC',"RPCATFR130",cFunBkp)
			SetFunName(cFunMet)

			nFim := Seconds() - nStart // Capturar tempo final | Diferença com o tempo inicial
			
			//atribuicao das variaveis que serao utilizadas pelo FwCustomMetrics
			
			cSubRoutine := Alltrim(cSubRoutine)
			cIdMetric  := "ativo-fixo--protheus_razao-auxiliar-tempo-total_seconds"
			cTotal := "1"
			dDateSend := LastDay( Date() )
			nLapTime := nFim

			// Metrica
			FWCustomMetrics():SetMetric(cSubRoutine, cIdMetric, cTotal, dDateSend, nLapTime)

		EndIf

	EndIf

	//Restaura setfunname a partir da variavel salva cFunBkp
	SetFunName(cFunBkp)
EndIf

Return 
