/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR150.CH"
#include "Protheus.ch"    

// TRADUCAO DE CH'S PARA PORTUGAL - 21/07/08
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR150  ³ Autor ³ Cesar C S Prado       ³ Data ³ 10.02.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Movimentos                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR150                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR150
Local oReport

oReport:=ReportDef()
oReport:PrintDialog()

Return 



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³12/09/2006³±±
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
Static Function ReportDef
Local oReport, oSection1, oSection2
Local cReport := "ATFR150"
Local cTitulo :=	STR0003 //"MOVIMENTOS"
Local cDescri :=	STR0001 + " " + STR0002 // "Este relatorio ira' imprimir a movimentac„o de"##"um bem em um determinado periodo."

Local bReport := { |oReport|	ReportPrint( oReport ) }
Local aOrd	  := { OemtoAnsi(STR0035), OemtoAnsi(STR0036) } // Por Bem, Por Conta
Local aPergs	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01        	// Do Bem                               ³
//³ mv_par02        	// Ate o Bem                            ³
//³ mv_par03        	// A partir da data                     ³
//³ mv_par04        	// Ate a Data                           ³
//³ mv_par05        	// A partir da conta                    ³
//³ mv_par06        	// Ate a conta                          ³
//³ mv_par07        	// Qual a Moeda                         ³
//³ mv_par08        	// Ordem dos Movimentos (1=Tipo/2=Ocorr)³
//³ mv_par09        	// Mostra C.Custo								 ³
//³ mv_par10        	// Mostra Item Ctb.							 ³
//³ mv_par11        	// Mostra Cl. Valor						    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte( "AFR150",.F. )

oReport  := TReport():New( cReport, cTitulo, "AFR150" , bReport, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0046, {"SN4"}, aOrd ) // "Dados do Bem"
TRCell():New( oSection1, "N3_CCONTAB"	, "SN3",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CBASE"		, "SN3",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_ITEM"	 	, "SN3",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_TIPO"  	, "SN3",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N1_DESCRIC"	, "SN1",/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:SetHeaderPage()
oSection1:SetNoFilter({"SN4"})
                                              		
oSection2 := TRSection():New( oReport, STR0047) // "Movimentos"
TRCell():New( oSection2, "N4_DATA"  	, "SN4"	,/*X3Titulo*/     ,/*Picture*/,TamSx3("N4_DATA")[1]+9, /*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N4_OCORR"		, "SN4"	, STR0051 /*X3Titulo*/     , /*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Tipo de movimentação"
TRCell():New( oSection2, "N4_MOTIVO"	, "SN4" 	, STR0050 /*X3Titulo*/     		, /*Picture*/, 16 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) // "Motivo movimento"
TRCell():New( oSection2, "N4_VLROC1"	, "SN4"  , GetMV( "MV_MOEDA1" ) /*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N4_VLROC"		, "SN4" ,  GetMV( "MV_MOEDA"+Str(mv_par07+1,1) )/*X3Titulo*/     ,/*Picture*/,TamSx3("N4_VLROC"+Str(mv_par07+1,1))[1] /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N4_QUANTD"	, "SN4" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N4_TXMEDIA"	, "SN4" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N4_TXDEPR"	, "SN4" ,/*X3Titulo*/     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection2:SetHeaderPage()

oSection3 := TRSection():New( oReport, STR0048 ) // "Entidades"
TRCell():New( oSection3, "N4_CCUSTO"	, "SN4" , /*X3Titulo*/     ,/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection3, "N4_SUBCTA"	, "SN4" , /*X3Titulo*/     ,/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection3, "N4_CLVL"		, "SN4" , /*X3Titulo*/     ,/*Picture*/, 40 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If mv_par09 != 1
	oSection3:Cell("N4_CCUSTO"):Disable()
EndIf
If mv_par10 != 1
	oSection3:Cell("N4_SUBCTA"):Disable()
EndIf
If mv_par11 != 1
	oSection3:Cell("N4_CLVL"):Disable()
EndIf
oSection3:SetLineStyle()
oSection3:SetCharSeparator("")

oSection4 := TRSection():New( oReport, STR0049 )// "Totais por Movimento"
TRCell():New( oSection4, "HISTORICO"	, "SN4" 	, STR0050 /*X3Titulo*/     	, /*Picture*/,	69 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Motivo movimento"
oSection4:Cell("HISTORICO"):SetAlign("RIGHT")

TRCell():New( oSection4, "N4_VLROC1"	, "SN4"  , GetMV( "MV_MOEDA1" ) /*X3Titulo*/    ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection4, "N4_VLROC"		, "SN4" 	, GetMV( "MV_MOEDA"+Str(mv_par07+1,1) )/*X3Titulo*/     ,/*Picture*/,TamSx3("N4_VLROC"+Str(mv_par07+1,1))[1] /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection4:SetHeaderSection(.F.)

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
Static Function ReportPrint( oReport, cApolIni,cApolFim,cSegIni,cSegFim )
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local oSection4 := oReport:Section(4)
LOCAL aTotMov:={}, aTotGeral := {}, aMovimento:={}  //Totais na moeda corrente (REAL)
LOCAL aMotivo  := {}
Local aTipoOco := {}
Local cMotivo
Local cContaAnt := " "
Local nOrdem := 0
Local cSeq   := Criavar("N3_SEQ")
Local cSeqReav:= Criavar("N3_SEQREAV")
Local cOcorre
Local aCodigo := { }, nPosicao
Local lTransfDe := .F., lTransfPa := .F.
Local lImp := .F.                        // Imprime se tiver vlr difer de zero
Local cConta   := " "
Local i
Local cCodigo
Local lFirst  := .T.
Local lImprimiu := .F.
Local aOrd	  := { OemtoAnsi(STR0035), OemtoAnsi(STR0036) } // Por Bem, Por Conta

Local aMovSN4	:= {}
Local nDet		:= 1
Local lAdLinGer	:= mv_par09 == 1 .or. mv_par10 == 1 .or. mv_par11 == 1

Local bCond1 	:= { || }

//Ativo Custo/Provisao
Local lAtfCusPrv := AFXAtCsPrv()
Local dDataIni   := MV_PAR03
Local dDataFin   := MV_PAR04
Local cBaseDe    := MV_PAR01
Local cBaseAte   := MV_PAR02
Local cContaDe   := MV_PAR05
Local cContaAte  := MV_PAR06
Local cQuery     := "" 
Local cAliasSN3  := ""
Local cAliasSN4  := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica tabela de motivos para baixa 									³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX5")
dbSeek(xFilial("SX5")+"16")
While SX5->X5_FILIAL+SX5->X5_TABELA == xFilial("SX5")+"16"
	AAdd( aMotivo, SubStr(SX5->X5_CHAVE,1,2 ) + "-" + SubStr(Capital(X5Descri()),1,12 ) )
	dbSkip()
Enddo

nOrdem := oSection1:GetOrder()

If nOrdem == 2
	oSection1:Cell("N3_CCONTAB"):Enable()
Else
	oSection1:Cell("N3_CCONTAB"):Disable()
Endif

oReport:SetTitle( oReport:Title() + OemToAnsi(STR0004)+; // " entre "
DTOC(mv_par03) + OemToAnsi(STR0005)+; //" a "
DTOC(mv_par04) + aOrd[nOrdem] )
						                            
GetTPMOV( aTipoOco )

For i := 1 to Len( aTipoOco )
	AADD( aMovimento, {0,0,Nil })  // { Vlr em R$, Vlr M Forte, Desc Movimento}
	AADD( aTotMov, {0,0})          // { Total na M1, Total M Forte }
	AADD( aTotGeral, {0,0})        // { Total Geral na Moeda1, Total Geral na Moeda Forte }
Next
				
oReport:SetMeter(SN3->(RecCount()))
oSection2:Cell("N4_VLROC"):SetTitle(GetMV( "MV_MOEDA"+Str(mv_par07+1,1) ))
oSection2:Cell("N4_VLROC"):SetPicture(PesqPict("SN4","N4_VLROC"+Str(mv_par07+1,1), 22 ))

oSection4:Cell("N4_VLROC"):SetTitle(GetMV( "MV_MOEDA"+Str(mv_par07+1,1) ))
oSection4:Cell("N4_VLROC"):SetPicture(PesqPict("SN4","N4_VLROC"+Str(mv_par07+1,1), 22 ))

cCodigo := " "

cQuery := "SELECT R_E_C_N_O_ , N3_SEQ, N3_CBASE, N3_CCONTAB FROM " + RetSqlName("SN3") + " SN3 "
cQuery += "WHERE SN3.D_E_L_E_T_ = ' '"                                   
cQuery += " AND N3_FILIAL = '" + XFilial("SN3")+ "'"
cQuery += " AND N3_CCONTAB <='" + cContaAte +"'"
cQuery += " AND N3_TIPO != '33'"
cQuery += " AND N3_CBASE BETWEEN '"	+ cBaseDe	+ "' AND '" + cBaseAte	+ "' "
If nOrdem == 1 
	cQuery += " ORDER BY N3_CBASE "
ElseIf nOrdem == 2
	cQuery += " ORDER BY N3_CCONTAB "
EndIf

cQuery := ChangeQuery(cQuery)
cAliasSN3 	:= GetNextAlias()
DBUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),cAliasSN3,.F.,.T.)

DbSelectArea("SN3")

Do While (cAliasSN3)->(!Eof()) .And. ! oReport:Cancel()
	
	SN3->(DbGoTo((cAliasSN3)->R_E_C_N_O_))
		
	cConta := SN3->N3_CCONTAB
	lFirst  := .T.
	lImprimiu := .F.
	
	oReport:IncMeter()
 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Guardo o registro for do tipo ="02", guardo o registro com a ³
	//³ mesma seq de reav para que nao processe o mesmo registro.    ³
	//³ Isto ocorre em reg com reav e baixas parciais. EX:           ³
	//³ CBASE  - ITEM - TIPO - SEQ - SEQ REAV                        ³
	//³ IMOB001- 0001 - 01   - 001 -                                 ³
	//³ IMOB001- 0001 - 02   - 002 - 01                              ³
	//³ IMOB001- 0001 - 02   - 003 - 02                              ³
	//³ Apos uma baixa parcial                                       ³	
	//³ CBASE  - ITEM - TIPO - SEQ - SEQ REAV                        ³
	//³ IMOB001- 0001 - 01   - 004 -                                 ³
	//³ IMOB001- 0001 - 02   - 005 - 01                              ³
	//³ IMOB001- 0001 - 02   - 006 - 02                              ³	
	//³ Os regs de bxs parciais com a mesma seq de reav sao do mesmo ³
	//³ reg que originaram a baixa, portanto nao posso passar por ele³
	//³ mais de uma vez.                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//NÃO mostra ativo Custo/Provisao
	If lAtfCusPrv .and. mv_par12 == 2 .And. SN3->N3_ATFCPR == '1'
		(cAliasSN3)->(dbSkip())
		Loop
	Endif
	
	If nOrdem == 2 .And. cContaAnt!= SN3->N3_CCONTAB
		For i := 1 to Len(aTotMov)
			If aTotMov[i][1] != 0
				lImp := .T.
				Exit
			Endif
		Next
		oSection4:Init()
		For i := 1 to Len(aTotMov)
			If aTotMov[i][1] != 0
				oSection4:Cell("HISTORICO"):SetBlock( { || OemToAnsi(STR0027) + aMovimento[i][3] } )
				oSection4:Cell("N4_VLROC1"):SetBlock( { || aTotMov[i][1] } )
				oSection4:Cell("N4_VLROC"):SetBlock( { || aTotMov[i][2] } )
				oSection4:PrintLine()
				aTotGeral[i][1]+= aTotMov[i][1]
				aTotGeral[i][2]+= aTotMov[i][2]
				aTotMov[i][1] := 0
				aTotMov[i][2] := 0
			Endif
		Next i
		oSection4:Finish()
	EndIf

	If cCodigo == SN3->N3_CBASE+SN3->N3_ITEM+SN3->N3_TIPO
		If SN3->N3_TIPO =="02"
			nPosicao := Ascan(aCodigo,{|x| x=SN3->N3_CBASE+SN3->N3_ITEM+SN3->N3_TIPO+SN3->N3_SEQREAV})
			If nPosicao > 0
				cCodigo := SN3->N3_CBASE+SN3->N3_ITEM+SN3->N3_TIPO
				(cAliasSN3)->(dbSkip())
				Loop
			EndIf
		Endif
	EndIf
	
	If SN3->N3_TIPO =="02"
		AADD(aCodigo,SN3->(N3_CBASE+N3_ITEM+N3_TIPO+N3_SEQREAV))
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza item no SN1                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SN1->(dbSetOrder(1))
	SN1->(MsSeek(xFilial("SN1")+SN3->N3_CBASE+SN3->N3_ITEM))

	SN4->(dbSetOrder(1))
	cBase    := SN3->N3_CBASE+SN3->N3_ITEM+SN3->N3_TIPO
	cSeq     := SN3->N3_SEQ
	cSeqReav := SN3->N3_SEQREAV
	lTransfDe := .F.
	lTransfPa := .F.
	aMovSN4   := {}
	oSection2:Init()
	If mv_par09 == 1 .Or.  mv_par10 == 1 .Or.  mv_par11 == 1
		oSection3:Init()
	Endif

	DbSelectArea("SN4")
	
	cQuery := "SELECT R_E_C_N_O_, N4_SEQREAV, N4_SEQ FROM " + RetSqlName("SN4") + " SN4 "
	cQuery += "WHERE SN4.D_E_L_E_T_ = ' ' "
	cQuery += " AND N4_FILIAL = '" + XFilial("SN4") + "'"
	cQuery += " AND N4_DATA	BETWEEN '"	+ DTOS(dDataIni)	+ "' AND '" + DTOS(dDataFin)	+ "'"
	cQuery += " AND N4_CBASE BETWEEN '"	+ cBaseDe	+ "' AND '" + cBaseAte	+ "'"
	cQuery += " AND N4_CONTA	BETWEEN '"	+ cContaDe	+ "' AND '" + cContaAte	+ "'"
	cQuery += " AND N4_CBASE = '" + SN3->N3_CBASE + "'"
	cQuery += " AND N4_ITEM = '" + SN3->N3_ITEM + "'"
	cQuery += " AND N4_TIPO = '" + SN3->N3_TIPO + "'"
	cQuery += " AND N4_TPSALDO = '" + SN3->N3_TPSALDO + "'"

	cQuery := ChangeQuery(cQuery)
	cAliasSN4 	:= GetNextAlias()
	DBUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),cAliasSN4,.F.,.T.)

	Do While (cAliasSN4)->(!Eof()) .And. ! oReport:Cancel()

		If cSeqReav != (cAliasSN4)->(N4_SEQREAV)
			(cAliasSN4)->(dbSkip())
			Loop
		EndIf

		If	(cAliasSN4)->(N4_SEQ) # (cAliasSN3)->(N3_SEQ)
			(cAliasSN4)->(dbSkip())
			Loop
		End

		SN4->(DbGoTo((cAliasSN4)->R_E_C_N_O_))
	
		cMotivo := AtfGetMtvo( aMotivo, SN4->N4_Motivo )

		lImprime := .T.
      
		If SN4->N4_OCORR = "06" .And. SN4->N4_TIPOCNT = "4"		// Depreciacao
			lImprime := .F.
		Endif

		If SN4->N4_OCORR = "07" .And. SN4->N4_TIPOCNT = "1"		// Correcao
			lImprime := .F.
		Endif
		
		If SN4->N4_OCORR = "08" .And. SN4->N4_TIPOCNT = "4"		// Correcao Depreciacao
			lImprime := .F.
		Endif
		
		If SN4->N4_OCORR = "13" .And. SN4->N4_TIPOCNT = "4"		// Inventario
			lImprime := .F.
		Endif

		If SN4->N4_OCORR $ "10,11,12" .And. SN4->N4_TIPOCNT = "4"		// Depreciacao Acelerada
			lImprime := .F.
		Endif

		If SN4->N4_OCORR = "20" .And. SN4->N4_TIPOCNT = "4"		// Depreciacao Gerencial
			lImprime := .F.
		Endif

		If lImprime
			lImprimiu := .T.
			If lFirst
				lFirst := .F.
				oSection1:Init()
				oSection1:PrintLine()
				oSection1:Finish()
			Endif
			cTxtCC	:= STR0037  //  "C. Custo:  "
			cTxtIT	:= STR0038	//	"Item Conta:"
			cTxtCL	:= STR0039	//	"Cl.Valor:  "

			cOcorre :=aTipoOco[Val(SN4->N4_OCORR)] + IIF(SN4->N4_OCORR $"03/04",Subst(SN4->N4_CONTA,1,20)," ")

			If SN4->N4_OCORR == "03"
				cTxtCC	:= STR0040  //  "C.Custo de "
				cTxtIT	:= STR0041	//	"Item de:   "
				cTxtCL	:= STR0042	//	"Cl.Vlr de: "
			ElseIf SN4->N4_OCORR == "04"
				cTxtCC	:= STR0043  //  "p/ C.Custo:"
				cTxtIT	:= STR0044	//	"para Item: "
				cTxtCL	:= STR0045	//	"p/ Cl.Vlr: "
			EndIf
			
			////////////////////////////////////////////////////////////////////////////////////////
			/// TRATAMENTO PARA IMPRIMIR OS REGISTROS ORIGEM E DESTINO NA SEQUENCIA EM QUE OCORRERAM
			////////////////////////////////////////////////////////////////////////////////////////
			If mv_par08 == 2
				aAdd(aMovSN4,{SN4->N4_TIPOCNT+STR(SN4->(Recno()),30)+SN4->N4_OCORR,SN4->N4_DATA,cOcorre,cMotivo,SN4->N4_VLROC1,SN4->&("N4_VLROC"+Str(mv_par07+1,1)),SN4->N4_QUANTD,SN4->N4_TXMEDIA,SN4->N4_TXDEPR,cTxtCC+SN4->N4_CCUSTO,cTxtIT+SN4->N4_SUBCTA,cTxtCL+SN4->N4_CLVL})
			Else
				oSection2:Cell("N4_DATA"):SetBlock( { || SN4->N4_DATA } )
				oSection2:Cell("N4_OCORR"):SetBlock( { || cOcorre } )
				oSection2:Cell("N4_MOTIVO"):SetBlock( { || cMotivo } )
				oSection2:Cell("N4_VLROC1"):SetBlock( { || SN4->N4_VLROC1 } )
				oSection2:Cell("N4_VLROC"):SetBlock( { || SN4->&("N4_VLROC"+Str(mv_par07+1,1)) } )
				oSection2:Cell("N4_QUANTD"):SetBlock( { || SN4->N4_QUANTD } )
				oSection2:Cell("N4_TXMEDIA"):SetBlock( { || SN4->N4_TXMEDIA } )
				oSection2:Cell("N4_TXDEPR"):SetBlock( { || SN4->N4_TXDEPR } )
				oSection2:PrintLine()
				If mv_par09 == 1 .Or. mv_par10 == 1 .Or. mv_par11 == 1
					oSection3:Cell("N4_CCUSTO"):SetTitle(cTxtCC)
					oSection3:Cell("N4_SUBCTA"):SetTitle(cTxtIT)
					oSection3:Cell("N4_CLVL"):SetTitle(cTxtCL)
					oSection3:Cell("N4_CCUSTO"):SetBlock( { || SN4->N4_CCUSTO } )
					oSection3:Cell("N4_SUBCTA"):SetBlock( { || SN4->N4_SUBCTA } )
					oSection3:Cell("N4_CLVL"):SetBlock( { || SN4->N4_CLVL } )
					oSection3:PrintLine()
				Endif
			EndIf
		Endif
		
		If SN4->N4_OCORR=="01" .And. SN4->N4_TIPOCNT=="1"  //Baixa
			aMovimento[1][1]+= SN4->N4_VLROC1
			aMovimento[1][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[1][3]:= aTipoOco[1] //" BAIXA"
		ElseIf SN4->N4_OCORR=="02" .And. SN4->N4_TIPOCNT=="1"  //Substitu
			aMovimento[2][1]+= SN4->N4_VLROC1
			aMovimento[2][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[2][3]:= aTipoOco[2]  //"SUBSTITUICAO"
		ElseIf SN4->N4_OCORR=="03" .And. SN4->N4_TIPOCNT=="1" .And. !lTransfDe //Transf de
			lTransfDe := .T.
			aMovimento[3][1]+= SN4->N4_VLROC1
			aMovimento[3][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[3][3]:= aTipoOco[3]  //" DEPRECIACAO"
		ElseIf SN4->N4_OCORR=="04" .And. SN4->N4_TIPOCNT=="1" .And. !lTransfPa  //Transf para
			lTransfPa := .T.
			aMovimento[4][1]+= SN4->N4_VLROC1
			aMovimento[4][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[4][3]:= aTipoOco[4] //"Transfer para"
		ElseIf SN4->N4_OCORR=="05" .And. SN4->N4_TIPOCNT="1" .And. SN4->N4_TIPO == "01" //Implantac
			aMovimento[5][1]:= SN4->N4_VLROC1
			aMovimento[5][2]:= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[5][3]:= aTipoOco[23]  //"Implantacao"
		ElseIf SN4->N4_OCORR=="06" .And. SN4->N4_TIPOCNT=="3"  //Depreciac
			aMovimento[6][1]+= SN4->N4_VLROC1
			aMovimento[6][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[6][3]:= aTipoOco[24]   //"DEPRECIACAO"
		ElseIf SN4->N4_OCORR=="07" .And. SN4->N4_TIPOCNT=="2" //Corre Bem
			aMovimento[7][1]+= SN4->N4_VLROC1
			aMovimento[7][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[7][3]:= aTipoOco[25] //"Correcao Bem"
		ElseIf SN4->N4_OCORR=="08" .And. SN4->N4_TIPOCNT=="5"  //Corre Depr
			aMovimento[8][1]+= SN4->N4_VLROC1
			aMovimento[8][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[8][3]:= aTipoOco[8] //"Correcao da Depr"
		ElseIf SN4->N4_OCORR=="09" .And. SN4->N4_TIPOCNT=="1"  //Ampliacao
			aMovimento[9][1]+= SN4->N4_VLROC1
			aMovimento[9][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[9][3]:= aTipoOco[9]  //"Ampliacao"
		ElseIf SN4->N4_OCORR=="10" .And. SN4->N4_TIPOCNT=="3"  //Dep Acel  esp SBPS
			aMovimento[10][1]+= SN4->N4_VLROC1
			aMovimento[10][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[10][3]:= aTipoOco[10]   //"Acelera positiva"
		ElseIf SN4->N4_OCORR=="11" .And. SN4->N4_TIPOCNT=="3" //Dep Acel Espe SBPS
			aMovimento[11][1]+= SN4->N4_VLROC1
			aMovimento[11][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[11][3]:= aTipoOco[11]  //"Aceleracao Negativa"
		ElseIf SN4->N4_OCORR=="12" .And. SN4->N4_TIPOCNT=="3"  //Dep. Incentivada Acelerada
			aMovimento[10][1]+= SN4->N4_VLROC1
			aMovimento[10][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[10][3]:= aTipoOco[10]   //"Acelera positiva"
		ElseIf SN4->N4_OCORR=="13" .And. SN4->N4_TIPOCNT=="4" //Ajuste inv
			aMovimento[12][1]+= SN4->N4_VLROC1
			aMovimento[12][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[12][3]:= aTipoOco[13]  //"Ajuste Invent"
		ElseIf SN4->N4_OCORR=="15" .And. SN4->N4_TIPOCNT=="1"  //Baixa Transf
			aMovimento[13][1]+= SN4->N4_VLROC1
			aMovimento[13][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[13][3]:= aTipoOco[15]   //"Baixa Transf"
		ElseIf SN4->N4_OCORR=="16" .And. SN4->N4_TIPOCNT=="1"  //Aquis Trans
			aMovimento[14][1]+= SN4->N4_VLROC1
			aMovimento[14][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[14][3]:= aTipoOco[16]  //"Aquis Transf"
		ElseIf cPaisLoc!="RUS" .And. SN4->N4_OCORR=="20" .And. SN4->N4_TIPOCNT=="3"  //Depr. Gerencial
			aMovimento[20][1]+= SN4->N4_VLROC1
			aMovimento[20][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[20][3]:= aTipoOco[20]  //"Depr. Gerencial"
		ElseIf SN4->N4_OCORR=="21" .And. SN4->N4_TIPOCNT=="1"  //Depr. Gerencial
			aMovimento[21][1]+= SN4->N4_VLROC1
			aMovimento[21][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[21][3]:= aTipoOco[21]  //"Taxa Perdida"
		ElseIf SN4->N4_OCORR=="22" .And. SN4->N4_TIPOCNT=="1"
			aMovimento[22][1]+= SN4->N4_VLROC1
			aMovimento[22][2]+= &('SN4->N4_VLROC'+Str(mv_par07+1,1))
			aMovimento[22][3]:= aTipoOco[22]  //"Mais/Menos Valia"
		EndIf
		
		(cAliasSN4)->(dbSkip())

	EndDo

	(cAliasSN4)->(DbCloseArea())

	////////////////////////////////////////////////////////////////////////////////////////
	/// TRATAMENTO PARA IMPRIMIR OS REGISTROS ORIGEM E DESTINO NA SEQUENCIA EM QUE OCORRERAM
	////////////////////////////////////////////////////////////////////////////////////////
	If mv_par08 == 2
		aSort(aMovSN4,,,{|x,y| x[1] < y[1]})
		//aAdd(aMovSN4,{SN4->N4_TIPOCNT+STR(SN4->(Recno()),30)+SN4->N4_OCORR,SN4->N4_DATA,cOcorre,cMotivo,SN4->N4_VLROC1,&('SN4->N4_VLROC'+cMoedaAux),SN4->N4_QUANTD,SN4->N4_TXMEDIA,SN4->N4_TXDEPR,SN4->N4_CCUSTO,SN4->N4_SUBCTA,SN4->N4_CLVL})
		//aAdd(aMovSN4,{SN4->N4_TIPOCNT,SN4->(Recno()),SN4->N4_OCORR,SN4->N4_DATA,cOcorre,cMotivo,SN4->N4_VLROC1,&('SN4->N4_VLROC'+cMoedaAux),SN4->N4_QUANTD,SN4->N4_TXMEDIA,SN4->N4_TXDEPR,SN4->N4_CCUSTO,SN4->N4_SUBCTA,SN4->N4_CLVL})
        			
		If Len(aMovSN4) > 0
			cTipoCnt := Left(aMovSN4[1][1],1)
			If mv_par09 == 1 .Or. mv_par10 == 1 .Or. mv_par11 == 1
				oSection3:Init()
			Endif
			For nDet := 1 to Len(aMovSN4)
				If cTipoCnt <> Left(aMovSN4[nDet][1],1)
					cTipoCnt := Left(aMovSN4[nDet][1],1)
				EndIf
				oSection2:Cell("N4_DATA"):SetBlock( { || aMovSN4[nDet][2] } )
				oSection2:Cell("N4_OCORR"):SetBlock( { || aMovSN4[nDet][3] } )
				oSection2:Cell("N4_MOTIVO"):SetBlock( { || aMovSN4[nDet][4] } )
				oSection2:Cell("N4_VLROC1"):SetBlock( { || aMovSN4[nDet][5] } )
				oSection2:Cell("N4_VLROC"):SetBlock( { || aMovSN4[nDet][6] } )
				oSection2:Cell("N4_QUANTD"):SetBlock( { || aMovSN4[nDet][7] } )
				oSection2:Cell("N4_TXMEDIA"):SetBlock( { || aMovSN4[nDet][8] } )
				oSection2:Cell("N4_TXDEPR"):SetBlock( { || aMovSN4[nDet][9] } )
				oSection2:PrintLine()
				If mv_par09 == 1 .Or. mv_par10 == 1 .Or. mv_par11 == 1
					oSection3:Cell("N4_CCUSTO"):SetTitle(cTxtCC)
					oSection3:Cell("N4_SUBCTA"):SetTitle(cTxtIT)
					oSection3:Cell("N4_CLVL"):SetTitle(cTxtCL)
					oSection3:Cell("N4_CCUSTO"):SetBlock( { || aMovSN4[nDet][10] } )
					oSection3:Cell("N4_SUBCTA"):SetBlock( { || aMovSN4[nDet][11] } )
					oSection3:Cell("N4_CLVL"):SetBlock( { || aMovSN4[nDet][12] } )
					oSection3:PrintLine()
				Endif
			Next
			If mv_par09 == 1 .Or. mv_par10 == 1 .Or. mv_par11 == 1
				oSection3:Finish()
			Endif
		EndIf
	EndIf

	oSection2:Finish()
	If (mv_par09 == 1 .Or.  mv_par10 == 1 .Or.  mv_par11 == 1) .And. mv_par08 != 2
		oSection3:Finish()
	Endif
	oSection4:Init()

	For i := 1 to 20
		If aMovimento[i][1] != 0
			oSection4:Cell("HISTORICO"):SetBlock( { || aMovimento[i][3] } )
			oSection4:Cell("N4_VLROC1"):SetBlock( { || aMovimento[i][1] } )
			oSection4:Cell("N4_VLROC"):SetBlock( { || aMovimento[i][2] } )
			oSection4:PrintLine()
			aTotMov[i][1]+= aMovimento[i][1]
			aTotMov[i][2]+= aMovimento[i][2]
			aMovimento[i][1]:=0
			aMovimento[i][2]:=0
		Endif
	
	Next i

	oSection4:Finish()
				
	dbSelectArea("SN3")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ cContab e utilizada qdo a ordem for 2 ( CONTA )    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCodigo    := SN3->N3_CBASE+SN3->N3_ITEM+SN3->N3_TIPO
	cContaAnt  := SN3->N3_CCONTAB
	dbSkip()
	
	lImp := .F.
	If nOrdem == 2 .And. cContaAnt!= SN3->N3_CCONTAB //( cContaAnt!= SN3->N3_CCONTAB .Or. (SN3->(!Eof()) .And. SN3->N3_FILIAL == xFilial("SN3") .And. Eval( bCond ) ) )
		For i := 1 to Len(aTotMov)
			If aTotMov[i][1] != 0
				lImp := .T.
				Exit
			Endif
		Next
		
		oSection4:Init()
		For i := 1 to Len(aTotMov)
			If aTotMov[i][1] != 0
				oSection4:Cell("HISTORICO"):SetBlock( { || OemToAnsi(STR0027) + aMovimento[i][3] } )
				oSection4:Cell("N4_VLROC1"):SetBlock( { || aTotMov[i][1] } )
				oSection4:Cell("N4_VLROC"):SetBlock( { || aTotMov[i][2] } )
				oSection4:PrintLine()
				aTotGeral[i][1]+= aTotMov[i][1]
				aTotGeral[i][2]+= aTotMov[i][2]
				aTotMov[i][1] := 0
				aTotMov[i][2] := 0
			Endif
		Next i
		oSection4:Finish()
	ElseIf nOrdem ==1
		For i := 1 to Len(aTotMov)
			aTotGeral[i][1]+= aTotMov[i][1]
			aTotGeral[i][2]+= aTotMov[i][2]
			aTotMov[i][1] := 0
			aTotMov[i][2] := 0
		Next
	EndIf

	(cAliasSN3)->(dbSkip())
	
EndDo

(cAliasSN3)->(DbCloseArea())

oSection4:Init()
For i := 1 to Len(aTotGeral)
	If aTotGeral[i][1] != 0
		oSection4:Cell("HISTORICO"):SetBlock( { || OemtoAnsi(STR0028) + aMovimento[i][3] } )
		oSection4:Cell("N4_VLROC1"):SetBlock( { || aTotGeral[i][1] } )
		oSection4:Cell("N4_VLROC"):SetBlock( { || aTotGeral[i][2] } )
		oSection4:PrintLine()
		aTotGeral[i][1]:=0
		aTotGeral[i][2]:=0
	Endif
Next i
oSection4:Finish()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³AtfGetMtvo³ Autor ³ Totvs                 ³ Data ³ 03.09.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna a descricao do motivo da baixa                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AtfGetMtvo( aMotBaixa, cMotivo )
	Local cReturn 	:= " "
	Local nPos		:= aScan( aMotBaixa, { |x| Left( x, 02 ) == cMotivo } )

	If nPos > 0
		cReturn := aMotBaixa[ nPos ]
	EndIf	
Return cReturn


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR150   ºAutor  ³Microsiga           º Data ³  12/23/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³ //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿             º±±
±±º          ³ //³ TIPOS DE MOVIMENTOS ( N4_OCORR )         ³             º±±
±±º          ³ //³ 01 - Baixa                               ³             º±±
±±º          ³ //³ 02 - Substituicao                        ³             º±±
±±º          ³ //³ 03 - Tranferencia de                     ³             º±±
±±º          ³ //³ 04 - Tranferencia para                   ³             º±±
±±º          ³ //³ 05 - Implantacao                         ³             º±±
±±º          ³ //³ 06 - Depreciacao                         ³             º±±
±±º          ³ //³ 07 - Correcao                            ³             º±±
±±º          ³ //³ 08 - Correcao da Depreciacao             ³             º±±
±±º          ³ //³ 09 - Ampliacao                           ³             º±±
±±º          ³ //³ 10 - Depr. Acelerada                     ³             º±±
±±º          ³ //³ 11 - Depr. Incentiv. Negativa            ³             º±±
±±º          ³ //³ 12 - Depr. Incentiv. Positiva            ³             º±±
±±º          ³ //³ 13 - Inventario                          ³             º±±
±±º          ³ //³ 14 - Reservado                           ³             º±±
±±º          ³ //³ 15 - Baixa por Transf.                   ³             º±±
±±º          ³ //³ 16 - Aquis. por Transf.                  ³             º±±
±±º          ³ //³ 17 - Depr. Correc. Monet. Mensal         ³             º±±
±±º          ³ //³ 18 - Depr. Acumul. Correc. Monet. Mensal ³             º±±
±±º          ³ //³ 20 - Depr. Gerencial                     ³             º±±
±±º          ³ //³ 21 - Taxa Perdida                        ³             º±±
±±º          ³ //³ 22 - Mais/Menos Valia                    ³             º±±
±±º          ³ //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetTPMOV( aArray )
aArray := {}
AADD( aArray, OemToAnsi(STR0010) ) // "Baixa           "                     01 - 01
AADD( aArray, OemToAnsi(STR0011) ) // "Substituicao    "                     02 - 02
AADD( aArray, OemToAnsi(STR0012) ) // "Transf. de "                          03 - 03
AADD( aArray, OemToAnsi(STR0013) ) // "Transf. p/ "                          04 - 04
AADD( aArray, OemToAnsi(STR0014) ) // "Implantac no mes"        	          05 - 05
AADD( aArray, OemToAnsi(STR0015) ) // "Depreciac no mes"                     06 - 06
AADD( aArray, OemToAnsi(STR0016) ) // "Correcao no mes "                     07 - 07
AADD( aArray, OemToAnsi(STR0017) ) // "Corr Monet Depre"                     08 - 08
AADD( aArray, OemToAnsi(STR0018) ) // "Ampliacao "                           09 - 09
AADD( aArray, OemToAnsi(STR0053) ) // "Depr. Acelerada"                      10 - 10
AADD( aArray, OemToAnsi(STR0054) ) // "Depr. Incentiv. Neg."                 11 - 11
AADD( aArray, OemToAnsi(STR0055) ) // "Depr. Incentiv. Pos."                 12 - 12
AADD( aArray, OemToAnsi(STR0032) ) // "Invent rio"                           13 - 13
AADD( aArray, OemToAnsi(STR0056) ) // "Reservado"                            14 - 14
AADD( aArray, OemToAnsi(STR0033) ) // "Baixa por Transf"                     15 - 15
AADD( aArray, OemToAnsi(STR0034) ) // "Aquis por Transf"                     16 - 16
AADD( aArray, OemToAnsi(STR0057) ) // "Depr. Correc. Monet. Mensal"          17 - 17
AADD( aArray, OemToAnsi(STR0058) ) // "Depr. Acumul. Correc. Monet. Mensal"  18 - 18
AADD( aArray, OemToAnsi(STR0056) ) // "Reservado"                            14 - 14
AADD( aArray, OemToAnsi(STR0059) ) // "Depr. Gerencial"                      20 - 20
AADD( aArray, OemToAnsi(STR0060) ) // "Taxa Perdida"                         21 - 21
AADD( aArray, OemToAnsi(STR0061) ) // "Mais/Menos Valia"                     22 - 22
AADD( aArray, OemToAnsi(STR0062) ) // "Implantac no periodo        	          23 - 23
AADD( aArray, OemToAnsi(STR0063) ) // "Depreciac no periodo"                 24 - 24
AADD( aArray, OemToAnsi(STR0064) ) // "Correcao no periodo"                  24 - 24

Return nil
