/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR100.CH"
#Include "Protheus.ch"      

// TRADUCAO DE CH'S PARA PORTUGAL - 21/07/08  

Static cQryAlias := ""

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR100    ³ Autor ³ Cesar C S Prado       ³ Data ³ 14.08.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Transferˆncias                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR100                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³C. Denardi  ³06/10/03³66.785³1- Localizacao de casas decimais na Picture ³±±
±±³            ³        ³      ³   em todos os relatorios do Ativo Fixo     ³±±
±±³            ³        ³      ³2- Inclusao dos parametros mv_par03 e       ³±±
±±³            ³        ³      ³   mv_par04 no SX1 para o uso em pergunte() ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Manutencao Efetuada                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Pedro P Lima³18/10/07³134710³ Foi corrigida a selecao de valores para    ³±±
±±³  TI6434    ³        ³MP-912³ impressao do relatorio no campo 'C.Custo   ³±±
±±³            ³        ³      ³ Origem', pois o mesmo reportava o centro de³±±
±±³            ³        ³      ³ custo de destino.                          ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ATFR100()

Local oReport    


If TRepInUse()
	oReport:=ReportDef()
	oReport:ParamReadOnly()	
	oReport:PrintDialog()
Else
   Help(" ",1,"ATFR100R3",,STR0031,1,0)  //"Relatório somente disponivel para Treport"
Endif

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
Local oReport,oSection1, oSection11, oSection12, oSection13, oSection14
Local cReport	:= "ATFR100"
Local cAlias1	:= "SN4"
Local cTitulo	:= STR0003 // "TRANSFERENCIAS"
Local cDescri	:= STR0001 + " " + STR0002 // "Este relatorio ir   imprimir a movimenta‡„o de transferˆncia dos bens em um per¡odo."
Local bReport	:= { |oReport| ReportPrint( oReport ) }
Local nX		:= 0	

//variavel static para receber novo alias
cQryAlias := GetNextAlias()

DbSelectArea("SN1") // Forca a abertura do SN1

Pergunte( "AFR100" , .T. )
oReport  := TReport():New( cReport, cTitulo, "AFR100" , bReport, cDescri )

oReport:SetUseGC(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0025, {cAlias1,cQryAlias} ) // "Dados do Bem"
oSection1:SetHeaderPage(.T.)
oSection1:SetAutoSize(.T.)
TRCell():New( oSection1, "N4_CBASE" 	, "SN1",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N4_ITEM"  	, "SN1",STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	 // "Item"     		 
TRCell():New( oSection1, "N4_TIPO"  	, "SN4",STR0023,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Tp"     			 
TRCell():New( oSection1, "N1_DESCRIC"	, "SN1",/*X3Titulo*/     ,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N1_AQUISIC"	, "SN1",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection1, "N4_DATA"	, "SN4",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N4_NOTA"	, "SN4",/*X3TITULO*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,/*"RIGHT"*/) // Numero da Nota
TRCell():New( oSection1, "N4_SERIE"	, "SN4",/*X3TITULO*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,/*"RIGHT"*/) // Serie da Nota	
TRCell():New( oSection1, "N4_VALOR"	, "SN4",STR0024,"",20,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT") // "Valor da Transferência"

For nX := 1 To Len(oSection1:aCell)
	oSection1:Cell(nX):SetBorder("BOTTOM")
Next

oSection11 := TRSection():New( oSection1, STR0026, {cAlias1} ) // "Conta"
oSection11:SetHeaderPage(.T.)
oSection11:SetLinesBefore(0)
oSection11:SetAutoSize(.T.)
TRCell():New( oSection11, "TEXTOCONTA", "SN1" ,STR0026,"",25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // Conta
TRCell():New( oSection11, "N3_CCONTAB", "SN3" ,STR0027,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Conta do Bem" 
TRCell():New( oSection11, "N3_CCORREC", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_CDEPREC", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_CCDEPR" , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_CDESP"  , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

If mv_par04 != 1		
	TRCell():New( oSection11, "N3_CCUSTO" , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Endif 

TRCell():New( oSection11, "N1_LOCAL"  , "SN1" ,/*X3titulo*/	  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection12 := TRSection():New( oSection1, STR0028, {cAlias1} ) // "Centro de Custo"
oSection12:SetLinesBefore(0)
oSection12:SetAutoSize(.T.)
TRCell():New( oSection12, "TEXTOCC", "SN1"    ,STR0028,"",25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Centro de Custo"
TRCell():New( oSection12, "N3_CCONTAB", "SN3" ,STR0027/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection12, "N3_CCORREC", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection12, "N3_CDEPREC", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection12, "N3_CCDEPR" , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection12, "N3_CDESP"  , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

If mv_par04 != 1		
	TRCell():New( oSection12, "N3_CCUSTO" , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
		oSection12:Cell("N3_CCUSTO"):Hide()
Endif

TRCell():New( oSection12, "N1_LOCAL"  , "SN1" ,/*X3titulo*/	  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
		oSection12:Cell("N1_LOCAL"):Hide()

oSection13 := TRSection():New( oSection1, STR0029, {cAlias1} ) // "Item contabil"
oSection13:SetLinesBefore(0)
oSection13:SetAutoSize(.T.)
TRCell():New( oSection13, "TEXTOITEM" , "SN1" ,STR0029,"",25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Item contabil"
TRCell():New( oSection13, "N3_CCONTAB", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection13, "N3_CCORREC", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection13, "N3_CDEPREC", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection13, "N3_CCDEPR" , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection13, "N3_CDESP"  , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

If mv_par04 != 1		
	TRCell():New( oSection13, "N3_CCUSTO" , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
		oSection13:Cell("N3_CCUSTO"):Hide()
Endif

TRCell():New( oSection13, "N1_LOCAL"  , "SN1" ,/*X3titulo*/	  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection13:Cell("N1_LOCAL"):Hide()
	
oSection14 := TRSection():New( oSection1, STR0030, {cAlias1} ) // "Classe de valor"
oSection14:SetLinesBefore(0)
oSection14:SetAutoSize(.T.)
TRCell():New( oSection14, "TEXTOCLVL" , "SN1" ,STR0030,"",25/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Classe de valor"
TRCell():New( oSection14, "N3_CCONTAB", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection14, "N3_CCORREC", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection14, "N3_CDEPREC", "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection14, "N3_CCDEPR" , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection14, "N3_CDESP"  , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

If mv_par04 != 1		
	TRCell():New( oSection14, "N3_CCUSTO" , "SN3" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection14:Cell("N3_CCUSTO"):Hide()
Endif 

TRCell():New( oSection14, "N1_LOCAL"  , "SN1     " ,/*X3titulo*/	  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection14:Cell("N1_LOCAL"):Hide()

oTotais := TRSection():New( oReport,STR0025,,, .F., .F. ) //"Total"
oTotais:SetLinesBefore(0)
TRCell():New( oTotais	,"TOT"			,		,STR0012		 ,/*Picture*/,100/*Size*/ ,/*lPixel*/,/*{|| code-block de impressao }*/)

oTotalFil := TRSection():New( oReport,STR0025,,, .F., .F. ) //"Total"
oTotalFil:SetLinesBefore(0)
TRCell():New( oTotalFil	,"TOTFIL"		,		,STR0012		 ,/*Picture*/,100/*Size*/ ,/*lPixel*/,/*{|| code-block de impressao }*/)

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
Local oSection1		:= oReport:Section(1)
Local oSection11	:= oReport:Section(1):Section(1)
Local oSection12	:= oReport:Section(1):Section(2)
Local oSection13	:= oReport:Section(1):Section(3)
Local oSection14	:= oReport:Section(1):Section(4)
Local oTotais		:= oReport:Section(2)
Local oTotalFil		:= oReport:Section(3)
Local cChave		:= "N4_CBASE+N4_ITEM+N4_TIPO+N4_SEQ+DTOS(N4_DATA)"
Local cAliasQry		:= "SN4"
Local cAliasSn3		:= "SN3"
Local cAliasSn1		:= "SN1"
Local cMoeda		:= Alltrim(Str(mv_par03))
Local cValor		:= ""
Local nX			:= 0
Local cPicture		:= "@E 9,999,999,999,999"
Local nDecimal		:= 0
Local cFilSN3		:= ""
Local lAchouSN1		:= .F.
Local aAreaM0		:= {}
Local cFilCorr		:= cFilAnt
Local cBase		:= ""
Local cItem		:= ""
Local cTipo		:= ""
Local dData		:= Ctod("//")
Local cNota		:= ""
Local cSerie		:= ""
Local cSeq		:= ""
Local nI		:= 0
Local cTipoSn3		:= ""
Local cDescric		:= ""
Local dAquisic		:= Ctod("//")
Local nTipoCNT		:= 0
Local cFiltro		:= ""
Local aGeren		:= {}
Local cLocAnt		:= ""
Local cFilterUser	:= ""
Local nInc			:= 0
Local aSM0			:= {}
Local nRegSM0		:= 0
Local cFilDe		:= ""
Local cFilAte		:= ""
Local nTransfTot	:= 0
Local nTotTrfFil	:= 0
Local aClassif		:= {}
Local cClassif		:= ""
Local cFilProc		:= ""
Local lAtfCusPrv	:= AFXAtCsPrv()
Local lSelFil		:= .F.
Local aSelFil		:= {}
Local nRecSN4Ant    := 0 
Local lSN1Exclus	:= AdmTabExc("SN1") //Analisa se a tabela esta exclusiva
Local lSN3Exclus	:= AdmTabExc("SN3") //Analisa se a tabela esta exclusiva
Local lSN4Exclus	:= AdmTabExc("SN4") //Analisa se a tabela esta exclusiva
Local aStru     := SN4->(dbStruct())
Local aGerenAux		:={}
Local lHaTranCC		:= .F.
Local lHaTranIT		:= .F.
Local lHaTranCL		:= .F.

lSelFil := (FwSizeFilial() > 2)

nRegSM0 := SM0->(Recno())

If lSelFil
	If MV_PAR12 == 1 
		If !isBlind()
			AdmSelecFil("AFR100",12,.F.,@aSelFil,"SN1",.F.)
		Else
			If FindFunction("GetParAuto")
				aSelFil := GetParAuto("ATFR100TestCase")
			EndIf
		EndIf
	Endif
	
	If Empty(aSelFil)
		Aadd(aSelFil,cFilAnt)
	Endif
	aSM0 := FWLoadSM0()
	nI := 0
	For nX := Len(aSM0) To 1 Step -1
		If Ascan(aSelFil,{|sm0| aSM0[nX,SM0_GRPEMP] == cEmpAnt .And. aSM0[nX,SM0_CODFIL] == sm0}) == 0
			Adel(aSM0,nX)
			nI:= nI+1
		Endif
	Next
	If nI > 0
		aSize(aSM0,Len(aSM0) - nI)
	Endif
	cFilDe := aSM0[1,SM0_CODFIL]
	cFilAte := aSM0[Len(aSM0),SM0_CODFIL]
	SM0->(DbGoTo(nRegSM0))
Else
	aSM0 := AdmAbreSM0()
	SM0->(DbGoto(nRegSM0))
	If mv_par07 == 2
		cFilDe  := cFilAnt
		cFilAte := cFilAnt
	ELSE
		cFilDe := mv_par08	// Todas as filiais
		cFilAte:= mv_par09
	Endif
Endif

If mv_par10 == 1
	aClassif := AdmGetClass()
	If Len( aClassif ) <= 0
		Return
	EndIf
EndIf

///////////////////////////////////////
// Acrescenta a qtde de casas decimais, 
// respeitando o configurado em MV_CENT
// Alteracao conforme BOPS 66.785
// Cristiano Denardi
nDecimal := MSdecimais(mv_par03)
For nX := 1 to nDecimal
	If ( nX = 1 )
		cPicture += "."
	Endif
	cPicture += "9"
Next

For nInc := 1 To Len( aSM0 )
	If aSM0[nInc][1] == cEmpAnt .And. aSM0[nInc][2] >= cFilDe .And. aSM0[nInc][2] <= cFilAte
		cFilAnt := aSM0[nInc][2]

		//Tratamento Gestao Corporativa
		If Len(AllTrim(xFilial("SN4")) ) > 2
			If Alltrim(cFilProc) != Alltrim(xFilial("SN4"))
				cFilProc:= xFilial("SN4")
			Else
				Loop
			EndIf
		EndIf
		
		cChave 		:= "N4_CBASE+N4_ITEM+N4_TIPO+N4_SEQ+DTOS(N4_DATA)"
		nTotTrfFil 	:= 0
			
		cAliasQry 	:= cQryAlias       //GetNextAlias()
		cAliasSn3	:= cAliasQry
		cAliasSn1	:= cAliasQry
		
		cQuery := "SELECT	N4_CBASE, N4_ITEM, N4_TIPO, N4_DATA, N4_CONTA, N4_CCUSTO, N4_SUBCTA, N4_CLVL, N4_LOCAL, N4_IDMOV, "
		cQuery += "			N4_TIPOCNT,N4_VLROC"+cMoeda+", N4_OCORR, N4_SEQ, SN4.R_E_C_N_O_ RECNOSN4, N3_CCONTAB, N3_CCORREC, N3_CDEPREC,"
		cQuery += "N3_CUSTBEM,N3_CCCORR,N3_CCDESP,N3_CCCDEP,N3_CCCDES,"
		cQuery += "N3_SUBCCON,N3_SUBCCOR,N3_SUBCDEP,N3_SUBCCDE,N3_SUBCDES,"
		cQuery += "N3_CLVLCON,N3_CLVLCOR,N3_CLVLDEP,N3_CLVLCDE,N3_CLVLDES,"
		cQuery += "			N3_CCDEPR,N3_CDESP, N3_CCUSTO, N3_TIPO, N1_LOCAL, N1_DESCRIC, N4_NOTA, N4_SERIE, "
		cQuery += "			N1_AQUISIC,N4_FILIAL,N4_FILORIG "
		cQuery += "FROM "+RetSqlName("SN4")+" SN4,"
		cQuery +=         RetSqlName("SN1")+" SN1,"
		cQuery +=         RetSqlName("SN3")+" SN3 "
		cQuery += "WHERE "
		If !lSN4Exclus
			cQuery += "N4_FILIAL = '"+xFilial("SN4")+"' AND "
		EndIf													/// RETIRADA A CLAUSULA DA FILIAL (EM FUNCAO DAS TRANSF. ENTRE FILIAIS)
		If Len(aClassif) > 0
			cQuery += " SN1.N1_PATRIM IN " + FORMATCLAS(aClassif,.T.) + " AND "
		EndIf
		
		If lAtfCusPrv .And. MV_PAR11 == 2
			cQuery += " SN3.N3_ATFCPR <> '1' AND "
		EndIf
		cQuery += "N4_DATA  >= '"+Dtos(MV_PAR01)+"' AND "
		cQuery += "N4_DATA  <= '"+Dtos(MV_PAR02)+"' AND "
		cQuery += "( (N4_OCORR IN ( '03', '04') AND N4_FILIAL = '"+xFilial("SN4")+"') OR "
		cQuery += "  (N4_OCORR IN ( '03', '04') AND N4_FILORIG = '"+xFilial("SN4")+"' ) ) AND "
		cQuery += "N1_FILIAL= N4_FILIAL AND "
		cQuery += "N1_CBASE = N4_CBASE AND "
		cQuery += "N1_ITEM  = N4_ITEM  AND "
		cQuery += "N3_FILIAL= N4_FILIAL AND "
		cQuery += "N3_CBASE = N4_CBASE AND "
		cQuery += "N3_ITEM  = N4_ITEM  AND "
		cQuery += "N3_TIPO  = N4_TIPO  AND "
		cQuery += "N3_SEQ   = N4_SEQ   AND "

		cFilterUser := oSection1:GetSqlExp("SN4")
		
		If !Empty(cFilterUser)
			cQuery += cFilterUser + " AND "
		Endif
		cQuery += "SN4.D_E_L_E_T_=' '  AND "
		cQuery += "SN1.D_E_L_E_T_=' '  AND "
		cQuery += "SN3.D_E_L_E_T_=' ' "
		cQuery += " ORDER BY N4_CBASE,N4_ITEM,N3_TIPO,N4_SEQ,N4_DATA,SN4.R_E_C_N_O_ "

		cQuery := ChangeQuery(cQuery)
	
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
		aEval(aStru, {|e| If(e[2]!= "C" .And. (cAliasQry)->(FieldPos(Alltrim(e[1]))) > 0, TCSetField(cAliasQry, e[1], e[2],e[3],e[4]),Nil)})
		TcSetField(cAliasQry,"N1_AQUISIC","D",8,0)
	
		oSection1:Cell("N4_VALOR"	):SetBlock( {|| aTransf[1][8] } ) 		// Valor da transferencias na moeda x
		oSection1:Cell("N4_VALOR"	):SetPicture(cPicture)
	   //	TRFunction():New(oSection1:Cell("N4_VALOR") , , "SUM" ,,,,, .F. ,  )
		
		oSection1:Cell("N4_CBASE"	):SetBlock( {|| cBase } )
		oSection1:Cell("N4_ITEM"	):SetBlock( {|| cItem } )
		oSection1:Cell("N4_TIPO"	):SetBlock( {|| cTipo } )
		oSection1:Cell("N1_DESCRIC"	):SetBlock( {|| Left(cDescric,40) } )
		oSection1:Cell("N1_AQUISIC"	):SetBlock( {|| dAquisic } )
		oSection1:Cell("N4_DATA"	):SetBlock( {|| dData } )
		
		oSection1:Cell("N4_NOTA" ):SetBlock( {|| cNota } )
		oSection1:Cell("N4_SERIE"):SetBlock( {|| cSerie } )
		
		oSection11:Cell("TEXTOCONTA"):SetBlock( {|| If(nX==1,STR0008,STR0009) } )
		oSection11:Cell("N3_CCONTAB"):SetBlock( {|| aTransf[nX][1] } )
		oSection11:Cell("N3_CCORREC"):SetBlock( {|| aTransf[nX][2] } )
		oSection11:Cell("N3_CDEPREC"):SetBlock( {|| aTransf[nX][3] } )
		oSection11:Cell("N3_CCDEPR"	):SetBlock( {|| aTransf[nX][4] } )
		oSection11:Cell("N3_CDESP"	):SetBlock( {|| aTransf[nX][5] } )
		If mv_par04 != 1				
			oSection11:Cell("N3_CCUSTO"	):SetBlock( {|| aTransf[nX][6] } )
		Endif
		oSection11:Cell("N1_LOCAL"	):SetBlock( {|| aTransf[nX][7] } )
		
		oSection12:Cell("TEXTOCC"	):SetBlock( {|| If(nX==1,STR0016,STR0017) } )
		oSection12:Cell("N3_CCONTAB"):SetBlock( {|| aGeren[1][nX][1] } )
		oSection12:Cell("N3_CCORREC"):SetBlock( {|| aGeren[1][nX][2] } )
		oSection12:Cell("N3_CDEPREC"):SetBlock( {|| aGeren[1][nX][3] } )
		oSection12:Cell("N3_CCDEPR"	):SetBlock( {|| aGeren[1][nX][4] } )
		oSection12:Cell("N3_CDESP"	):SetBlock( {|| aGeren[1][nX][5] } )
		
		oSection13:Cell("TEXTOITEM"	):SetBlock( {|| If(nX==1,STR0018,STR0019) } )
		oSection13:Cell("N3_CCONTAB"):SetBlock( {|| aGeren[2][nX][1] } )
		oSection13:Cell("N3_CCORREC"):SetBlock( {|| aGeren[2][nX][2] } )
		oSection13:Cell("N3_CDEPREC"):SetBlock( {|| aGeren[2][nX][3] } )
		oSection13:Cell("N3_CCDEPR"	):SetBlock( {|| aGeren[2][nX][4]} )
		oSection13:Cell("N3_CDESP"	):SetBlock( {|| aGeren[2][nX][5] } )
		
		oSection14:Cell("TEXTOCLVL"	):SetBlock( {|| If(nX==1,STR0020,STR0021) } )
		oSection14:Cell("N3_CCONTAB"):SetBlock( {|| aGeren[3][nX][1] } )
		oSection14:Cell("N3_CCORREC"):SetBlock( {|| aGeren[3][nX][2] } )
		oSection14:Cell("N3_CDEPREC"):SetBlock( {|| aGeren[3][nX][3] } )
		oSection14:Cell("N3_CCDEPR"	):SetBlock( {|| aGeren[3][nX][4]} )
		oSection14:Cell("N3_CDESP"	):SetBlock( {|| aGeren[3][nX][5] } )
		
		oReport:NoUserFilter()
		oReport:SetMeter((cAliasQry)->(LastRec()))
		
		While (cAliasQry)->(!Eof())
			
			oReport:IncMeter()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Passa para array informa‡”es da transferˆncia de e transferˆncia para  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cBase  := (cAliasQry)->N4_CBASE
			cItem  := (cAliasQry)->N4_ITEM
 			cTipo  := (cAliasQry)->N4_TIPO
			dData  := (cAliasQry)->N4_DATA
			cNota	:= (cAliasQry)->N4_NOTA
			cSerie	:= (cAliasQry)->N4_SERIE
			cSeq	:= (cAliasQry)->N4_SEQ
			nI     := 1
			cTipoSn3 := (cAliasSn3)->N3_TIPO
			cDescric := SubStr((cAliasSn1)->N1_DESCRIC,1,40)
			dAquisic := (cAliasSn1)->N1_AQUISIC
			
			// Foi inserido o campo N4_VLROC1, referente a alteracao p/ Prada
			aTransf:= {	{ (cAliasSn3)->N3_CCONTAB, (cAliasSn3)->N3_CCORREC, (cAliasSn3)->N3_CDEPREC, (cAliasSn3)->N3_CCDEPR, (cAliasSn3)->N3_CDESP, (cAliasQry)->N4_CCUSTO, (cAliasSn1)->N1_LOCAL, (cAliasQry)->&("N4_VLROC"+cMoeda)},;
				      	   	{ (cAliasSn3)->N3_CCONTAB, (cAliasSn3)->N3_CCORREC, (cAliasSn3)->N3_CDEPREC, (cAliasSn3)->N3_CCDEPR, (cAliasSn3)->N3_CDESP, (cAliasSn3)->N3_CCUSTO, (cAliasSn1)->N1_LOCAL, NIL}}
			
	
			
			//				 { { "N3_CCONTAB", "N3_CCORREC", "N3_CDEPREC", "N3_CCDEPR",  "N3_CDESP", "N3_CCUSTO", "SN1->N1_LOCAL" } }
			//	Aadd(aCpDigit, { "", "", "", "", "" })
			
			aGeren := {}
			aAdd(aGeren,{{"","","","",""},{"","","","",""}})		/// aGeren[1] == C.Custo
			aAdd(aGeren,{{"","","","",""},{"","","","",""}})		/// aGeren[2] == Item Contabil
			aAdd(aGeren,{{"","","","",""},{"","","","",""}})		/// aGeren[3] == Classe de Valor
			aAdd(aGerenAux,{{"","","","",""},{"","","","",""}})
			aAdd(aGerenAux,{{"","","","",""},{"","","","",""}})
			aAdd(aGerenAux,{{"","","","",""},{"","","","",""}})
						
			While (cAliasQry)->(!Eof()) .And. (cAliasQry)->N4_CBASE == cBase .And. ;
				(cAliasQry)->N4_ITEM == cItem .And. (cAliasQry)->N4_TIPO == cTipo .And.;
					(cAliasQry)->N4_OCORR $ "03/04" .And. (cAliasQry)->N4_SEQ == cSeq
				
				
				
				nI 						:= IIF((cAliasQry)->N4_OCORR == "03", 1,2)
				nTipoCNT 				:= Val((cAliasQry)->N4_TIPOCNT)
				aTransf[nI][nTipoCNT]	:= (cAliasQry)->N4_CONTA
				aTransf[nI][6] 			:= (cAliasQry)->N4_CCUSTO
				aTransf[nI][7]			:= (cAliasQry)->N4_LOCAL

				If (cAliasQry)->N4_OCORR =="04" //somente quantifica na movimentacao - destino
					If (cAliasQry)->N4_TIPOCNT == '1' //TIPO CONTA DO BEM
						
						aTransf[1][8]	:= (cAliasQry)->&("N4_VLROC"+cMoeda)
												
					EndIf
					
					nTransfTot += (cAliasQry)->&("N4_VLROC"+cMoeda) //soma do valor total
  					nTotTrfFil += (cAliasQry)->&("N4_VLROC"+cMoeda)
  					 
  				EndIf
									
				//caso faz pela query tem que gravar o ultimo registro posicionado
				nRecSN4Ant := (cAliasQry)->RECNOSN4				
				
				dbSelectArea("SN1")
				dbSetOrder(1)		/// SE FOR UMA TRANSFERENCIA ENTRE FILIAIS USA DESCRICAO DO CADASTRO DESTINO (PODEM HAVER CODIGOS IGUAIS)
				If !Empty((cAliasQry)->N4_FILORIG) .and. MsSeek((cAliasQry)->(N4_FILIAL+N4_CBASE+N4_ITEM),.F.)
					cDescric := SubStr(SN1->N1_DESCRIC,1,40)
				EndIf
				
				If mv_par04 == 1		/// Se mostra C.Custo
					//Origem  aAdd(aGeren[1],{(cAliasSn3)->N3_CUSTBEM,(cAliasSn3)->N3_CCCORR,(cAliasSn3)->N3_CCDESP,(cAliasSn3)->N3_CCCDEP,(cAliasSn3)->N3_CCCDES})
					//Destino aAdd(aGeren[1],{(cAliasSn3)->N3_CUSTBEM,(cAliasSn3)->N3_CCCORR,(cAliasSn3)->N3_CCDESP,(cAliasSn3)->N3_CCCDEP,(cAliasSn3)->N3_CCCDES})
					aGeren[1][nI][nTipoCNT] := (cAliasQry)->N4_CCUSTO
				EndIf
				
				If mv_par05 == 1		/// Se mostra Item Contabil
					//Origem aAdd(aGeren[2],{(cAliasSn3)->N3_SUBCCON,(cAliasSn3)->N3_SUBCCOR,(cAliasSn3)->N3_SUBCDEP,(cAliasSn3)->N3_SUBCCDE,(cAliasSn3)->N3_SUBCDES})
					//Destino aAdd(aGeren[2],{(cAliasSn3)->N3_SUBCCON,(cAliasSn3)->N3_SUBCCOR,(cAliasSn3)->N3_SUBCDEP,(cAliasSn3)->N3_SUBCCDE,(cAliasSn3)->N3_SUBCDES})
					aGeren[2][nI][nTipoCNT] := (cAliasQry)->N4_SUBCTA
				EndIf
				
				If mv_par06 == 1		/// Se mostra Classe de Valor
					//Origem aAdd(aGeren[3],{(cAliasSn3)->N3_CLVLCON,(cAliasSn3)->N3_CLVLCOR,(cAliasSn3)->N3_CLVLDEP,(cAliasSn3)->N3_CLVLCDE,(cAliasSn3)->N3_CLVLDES})
					//Destino aAdd(aGeren[3],{(cAliasSn3)->N3_CLVLCON,(cAliasSn3)->N3_CLVLCOR,(cAliasSn3)->N3_CLVLDEP,(cAliasSn3)->N3_CLVLCDE,(cAliasSn3)->N3_CLVLDES})
					aGeren[3][nI][nTipoCNT] := (cAliasQry)->N4_CLVL
				EndIf
				
				If nI == 1 
					If mv_par04 == 1	
						aGerenAux[1][1] := {(cAliasQry)->N3_CUSTBEM,(cAliasQry)->N3_CCCORR,(cAliasQry)->N3_CCDESP,(cAliasQry)->N3_CCCDEP,(cAliasQry)->N3_CCCDES}
					EndIf
					If mv_par05 == 1 	
						aGerenAux[2][1] := {(cAliasQry)->N3_SUBCCON,(cAliasQry)->N3_SUBCCOR,(cAliasQry)->N3_SUBCDEP,(cAliasQry)->N3_SUBCCDE,(cAliasQry)->N3_SUBCDES}	
					EndIf
					If mv_par06 == 1 	
						aGerenAux[3][1] := {(cAliasQry)->N3_CLVLCON,(cAliasQry)->N3_CLVLCOR,(cAliasQry)->N3_CLVLDEP,(cAliasQry)->N3_CLVLCDE,(cAliasQry)->N3_CLVLDES}
					EndIf
				Else
					If mv_par04 == 1	
						aGerenAux[1][2] := {(cAliasQry)->N3_CUSTBEM,(cAliasQry)->N3_CCCORR,(cAliasQry)->N3_CCDESP,(cAliasQry)->N3_CCCDEP,(cAliasQry)->N3_CCCDES}
					EndIf
					If mv_par05 == 1 	
						aGerenAux[2][2] := {(cAliasQry)->N3_SUBCCON,(cAliasQry)->N3_SUBCCOR,(cAliasQry)->N3_SUBCDEP,(cAliasQry)->N3_SUBCCDE,(cAliasQry)->N3_SUBCDES}	
					EndIf
					If mv_par06 == 1 	
						aGerenAux[3][2] := {(cAliasQry)->N3_CLVLCON,(cAliasQry)->N3_CLVLCOR,(cAliasQry)->N3_CLVLDEP,(cAliasQry)->N3_CLVLCDE,(cAliasQry)->N3_CLVLDES}
					EndIf 	 
				EndIf
				
				cLocAnt := (cAliasSn1)->N1_LOCAL
				(cAliasQry)->( dbSkip() )
				If nI == 2 .and. (cAliasQry)->N4_OCORR <> "04"		/// SE SAIU DO TIPO DESTINO
					For nX := 1 To 5  // Quando não houver alteração de nenhuma entidade do relatório
						If mv_par04 == 1 .And. !(aGeren[1][1][nX] == aGeren[1][2][nX])
							lHaTranCC := .T.
						EndIf
						If mv_par05 == 1 .And. !(aGeren[2][1][nX] == aGeren[2][2][nX])
							lHaTranIT := .T.
						EndIf
						If mv_par06 == 1 .And. !(aGeren[3][1][nX] == aGeren[3][2][nX])
							lHaTranCL := .T.
						EndIf
						If lHaTranCC .Or. lHaTranIT .Or. lHaTranCL
							Exit
						EndIf 							
					Next
					
					If lHaTranCC .Or. lHaTranIT .Or. lHaTranCL // Quando houver alteração de uma entidade e não contém movimento na SN4, por não ter sido alterada.
						For nX := 1 To 5  
							If mv_par04 == 1 .And. (aGeren[1][1][nX] == aGeren[1][2][nX] .And. Empty(aGeren[1][2][nX])) 
								aGeren[1][1][nX] := aGerenAux[1][1][nX]
								aGeren[1][2][nX] := aGerenAux[1][2][nX]
							EndIf
							If mv_par05 == 1 .And. (aGeren[2][1][nX] == aGeren[2][2][nX] .And. Empty(aGeren[2][2][nX]))
								aGeren[2][1][nX] := aGerenAux[2][1][nX]
								aGeren[2][2][nX] := aGerenAux[2][2][nX]
							EndIf
							If mv_par06 == 1 .And. (aGeren[3][1][nX] == aGeren[3][2][nX] .And. Empty(aGeren[3][2][nX]))
								aGeren[3][1][nX] := aGerenAux[3][1][nX]
								aGeren[3][2][nX] := aGerenAux[3][2][nX]
							EndIf	
						Next										
					EndIf 
					
					If !lHaTranCC .And. mv_par04 == 1
						aGeren[1] := {aGerenAux[1][1], aGerenAux[1][2]}		
					EndIf 
					
					If !lHaTranIT .And. mv_par05 == 1
						aGeren[2] := {aGerenAux[2][1], aGerenAux[2][2]}
					EndIf 
					
					If !lHaTranCL .And. mv_par06 == 1
						aGeren[3] := {aGerenAux[3][1], aGerenAux[3][2]}
					EndIf
					
					aGerenAux := {}
					aGerenAux := {}
					aGerenAux := {} 
				
					Exit
				EndIf
			Enddo
			If (cAliasQry)->N4_CBASE <> cBase .or. (cAliasQry)->N4_ITEM <> cItem .or. (cAliasQry)->N4_TIPO <> cTipo .or. (cAliasQry)->N4_SEQ <> cSeq
				/// (NA ULTIMA TRANSFERENCIA COLOCA A GRAVADA NO SN1) NO CASO DE TRANSFERENCIA SOMENTE DE LOCAL (NÃO GERA SN4)
				If nI == 2 .and. aTransf[nI][7] <> cLocAnt
					aTransf[nI][7] := cLocAnt
				EndIf
			EndIf
			
			oSection1:Init()			
			SN4->( dbGoto( nRecSN4Ant ) )
			dbSelectArea(cAliasQry)

			oSection1:PrintLine()
			oSection11:Init()
			
			For nX := 1 To 2
				oSection11:PrintLine()
				If mv_par04 == 1			/// Se Mostra C.Custo
					oSection12:SetHeaderSection(.F.)
					oSection12:Init()
				EndIf
				If mv_par05 == 1			/// Se Mostra Item Contabil
					oSection13:SetHeaderSection(.F.)
					oSection13:Init()
				EndIf
				If mv_par06 == 1			/// Se Mostra Classe de Valor
					oSection14:SetHeaderSection(.F.)
					oSection14:Init()
				EndIf
				If mv_par04 == 1			/// Se Mostra C.Custo
					oSection12:PrintLine()
				EndIf
				If mv_par05 == 1			/// Se Mostra Item Contabil
					oSection13:PrintLine()
				EndIf
				If mv_par06 == 1			/// Se Mostra Classe de Valor
					oSection14:PrintLine()
				EndIf
				If mv_par04 == 1			/// Se Mostra C.Custo
					oSection12:Finish()
				EndIf
				If mv_par05 == 1			/// Se Mostra Item Contabil
					oSection13:Finish()
				EndIf
				If mv_par06 == 1			/// Se Mostra Classe de Valor
					oSection14:Finish()
				EndIf
			Next
			
			oSection1:Finish()
			oSection11:Finish()
			
			dbSelectArea(cAliasQry)
		Enddo
		
		If nTotTrfFil <> 0
			If If(lSelFil,(Len(aSelFil) > 1),(mv_par07==1))
				oTotalFil:SetHeaderSection(.F.)
				cValor := Transform(nTotTrfFil,cPicture) //PesqPict("SN3","N3_VORIG1"))
				nTotTrfFil := 0
				oTotalFil:Cell("TOTFIL"):SetSize(Len(StrTran(OemToAnsi(STR0012),"---->","") + " F I L I A L ----> "+" "+(cFilAnt+" - " + AllTrim(aSM0[nInc][7])) + cValor))
				oTotalFil:Cell("TOTFIL"):SetBlock({||StrTran(OemToAnsi(STR0012),"---->","") + " F I L I A L ----> "+" "+(cFilAnt+" - " + AllTrim(aSM0[nInc][7])) + cValor})
				oTotalFil:Init()
				oReport:SkipLine()
				oReport:ThinLine()
				oTotalFil:PrintLine()
				oReport:SkipLine(2)
				oTotalFil:Finish()
			Endif
		EndIf
		dbSelectArea(cAliasQry)
		dbCloseArea()				
	EndIf
Next

dbSelectArea("SN4")	
	
//imprime o total das transferencias 
oTotais:SetHeaderSection(.F.)
oTotais:Cell("TOT"):SetBlock({||Alltrim(STR0012)+ " " + Transform(nTransfTot,cPicture)})
oTotais:Init()
If If(lSelFil,(Len(aSelFil) > 1),(mv_par07==1))
	oReport:SkipLine(2)
Endif
oReport:SkipLine()
oReport:ThinLine()
oTotais:PrintLine()
oTotais:Finish()

SM0->(DbGoTo(nRegSM0))
cFilAnt := cFilCorr

Return Nil

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
