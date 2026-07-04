/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR050.CH"
#INCLUDE "Protheus.ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.
// TRADUCAO DE CH'S PARA PORTUGAL
// TRADUCAO DE CH'S PARA PORTUGAL - 21/07/08



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR050    ³ Autor ³ Vinicius Barreira     ³ Data ³ 01.12.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Saldos a depreciar                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR050                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR050()
Local oReport

oReport:=ReportDef()
oReport:PrintDialog()

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
Local oReport,oSection1,oSection11
Local cReport := "ATFR050"
Local cAlias1 := "SN3"
Local cTitulo := STR0003 // "Saldo a depreciar"
Local cDescri := STR0001 + " " + STR0002 // "Este programa ir  emitir a rela‡Æo dos valores que ainda faltam depreciar para cada bem"
Local bReport := { |oReport|	oReport:SetTitle( oReport:Title() + OemToAnsi(STR0007)+; // " por "
										aOrd[oSection1:GetOrder()] ),;
									 	ReportPrint( oReport ) }
Local aOrd := {}



DbSelectArea("SN1") // Forca a abertura do SN1

aOrd  := {	OemToAnsi(STR0011),; // "Conta"
				OemToAnsi(STR0012)} // "C Custo"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualizacao das perguntas utilizadas pelo relatorio  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport  := TReport():New( cReport, cTitulo, "ATR050" , bReport, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0017, {cAlias1,"SN1","CT1","CTT"}, aOrd )	//"Dados da Entidade"

TRCell():New( oSection1, "CT1_FILIAL"	, "CT1",/*X3Titulo*/,/*Picture*/,Len(SN3->N3_FILIAL)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "CTT_FILIAL"	, "CTT",/*X3Titulo*/,/*Picture*/,Len(SN3->N3_FILIAL)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCONTAB"	, cAlias1,/*X3Titulo*/,/*Picture*/,Len(SN3->N3_CCONTAB + " - " + CT1->CT1_DESC01)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCUSTO" 	, cAlias1,/*X3Titulo*/,/*Picture*/,Len(SN3->N3_CCUSTO + " - " + CTT->CTT_DESC01)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection11 := TRSection():New( oSection1, STR0018, {cAlias1,"SN1"} )	//"Dados do Bem"


TRCell():New( oSection11, "N3_FILIAL"  	, cAlias1,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_CBASE"  	, cAlias1,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_ITEM"   	, cAlias1,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_TIPO"   	, cAlias1,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N1_DESCRIC"	, "SN1"  ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_SALDO1"	, "SN3"  ,AllTrim(GetMV("MV_SIMB1")),PesqPict("SN3","N3_VORIG1",18,1)/*Picture*/,18/*Tamanho*/,/*lPixel*/,{|| (N3_VORIG1 + N3_VRCACM1 + N3_AMPLIA1) - (N3_VRDACM1 + N3_VRCDA1) },/*"RIGHT"*/,,"RIGHT",,,.F.  )
TRCell():New( oSection11, "N3_SALDO2"	, "SN3"  ,AllTrim(GetMV("MV_SIMB2")),PesqPict("SN3","N3_VORIG1",18,2)/*Picture*/,18/*Tamanho*/,/*lPixel*/,{|| (N3_VORIG2 + N3_AMPLIA2) - N3_VRDACM2 },/*"RIGHT"*/,,"RIGHT" )
TRCell():New( oSection11, "N3_SALDO3"	, "SN3"  ,AllTrim(GetMV("MV_SIMB3")),PesqPict("SN3","N3_VORIG1",18,3)/*Picture*/,18/*Tamanho*/,/*lPixel*/,{|| (N3_VORIG3 + N3_AMPLIA3) - N3_VRDACM3 },/*"RIGHT"*/,,"RIGHT" )
TRCell():New( oSection11, "N3_SALDO4"	, "SN3"  ,AllTrim(GetMV("MV_SIMB4")),PesqPict("SN3","N3_VORIG1",18,4)/*Picture*/,18/*Tamanho*/,/*lPixel*/,{|| (N3_VORIG4 + N3_AMPLIA4) - N3_VRDACM4 },/*"RIGHT"*/,,"RIGHT" )
TRCell():New( oSection11, "N3_SALDO5"	, "SN3"  ,AllTrim(GetMV("MV_SIMB5")),PesqPict("SN3","N3_VORIG1",18,5)/*Picture*/,18/*Tamanho*/,/*lPixel*/,{|| (N3_VORIG5 + N3_AMPLIA5) - N3_VRDACM5 },/*"RIGHT"*/,,"RIGHT" )

oSection11:Cell("N3_CBASE"):lHeaderSize	:= .F.
oSection11:Cell("N3_ITEM"):lHeaderSize	:= .F.
oSection11:Cell("N3_TIPO"):lHeaderSize	:= .F.
oSection11:Cell("N1_DESCRIC"):lHeaderSize	:= .F.
oSection11:Cell("N3_SALDO1"):lHeaderSize	:= .F.
oSection11:Cell("N3_SALDO2"):lHeaderSize	:= .F.
oSection11:Cell("N3_SALDO3"):lHeaderSize	:= .F.
oSection11:Cell("N3_SALDO4"):lHeaderSize	:= .F.
oSection11:Cell("N3_SALDO5"):lHeaderSize	:= .F.

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
Local oSection1  := oReport:Section(1)
Local oSection11 := oReport:Section(1):Section(1)
Local oPerg	     := FWSX1Util():New()
Local cChave
Local cQuery		:= "SN3"
Local cAliasCT1	:= "CT1"
Local cAliasCTT	:= "CTT"
Local nOrder   := oSection1:GetOrder()
Local cWhere	:= ""
Local cQuebra	:= .T.
//*****************************
// Tipos de Ativos gerenciais *
//*****************************
Local aTiposF	:= ATFXTpBem(1,.T.)
Local aTiposG	:= ATFXTpBem(2,.T.)
lOCAL cTipos	:= ''
Local nX        := 0
Local cWhereAux	:= ""
Local i			:= 0

Local aClassif := {}

Local lRealProv	:= .F.

Local cAtivAgrup := ""
Local cFunDB	 := ""
Local nTamEmp	 := 0
Local nTamUnit	 := 0
Local nTamFil	 := 0
Local cCt1Fil    := ""
Local cCttFil 	 := ""
Local lCmpEmpCT1 := .F.
Local lCmpUniCT1 := .F.
Local lCmpFilCT1 := .F.
Local lCmpEmpCTT := .F.
Local lCmpUniCTT := .F.
Local lCmpFilCTT := .F.
Local cJoin 	 := "% LEFT %"
Local lAgrBens   := .F.
Local lMultiFil  := .F.
Local aPergunte  := {}

Pergunte( "ATR050" , .F. )

oPerg:AddGroup("ATR050")
oPerg:SearchGroup()
aPergunte := oPerg:GetGroup("ATR050")

If (Len(aPergunte[2]) >= 15 .and. "FILIAL"$Upper(aPergunte[2][15]['CX1_PERGUNT'])) //Verifica se já tem os novos parâmetros na base
	lMultiFil := (MV_PAR14 == 1)
	lAgrBens  := FindFunction("A036AgrBens") .And. !Empty(MV_PAR13)
EndIf

If lMultiFil .and. Empty(MV_PAR16)
	FWAlertWarning(STR0025, STR0023) //"Quando considera filias for Sim (Filial até) não pode ser vazio" // "Atenção"
	Return .F.
EndIf

If lAgrBens
	cAtivAgrup := A036AgrBens(MV_PAR13)

	If cAtivAgrup == "-1"
		FWAlertWarning(STR0021 + MV_PAR13 + STR0022, STR0023) // "O agrupador selecionado " // " está inativo ou fora da validade." // "Atenção"
		Return .F.
	ElseIf cAtivAgrup == "-2"
		FWAlertWarning(STR0021 + MV_PAR13 + STR0026, STR0023) // "O agrupador selecionado" // " não foi encontrado na base de dados." // Atenção"
		Return .F.
	EndIf
EndIf

If mv_par09 == 1 .And. FindFunction("AdmGetClass")
	aClassif := AdmGetClass()
	If Len( aClassif ) <= 0
		Return
	EndIf
EndIf
If MV_PAR11 = 1
	cTipos := "'"
	For nx := 1 to Len(aTiposG)
		cTipos += aTiposG[nX]

		If nx != Len(aTiposG)
			cTipos += "','"
		EndIf
	Next nX
	cTipos += "'"
ElseIf MV_PAR11 = 2
	cTipos := "'"
	For nx := 1 to Len(aTiposF)
		cTipos += aTiposF[nX]

		If nx != Len(aTiposF)
			cTipos += "','"
		EndIf
	Next nX
	cTipos += "'"
EndIf

If !Empty(MV_PAR13)
	MV_PAR01 := ""
	MV_PAR02 := ""
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza registro inicial                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF nOrder == 1
	SN3->(dbSetOrder(2))
	cWhere := "N3_CCONTAB <> ' ' AND "	
	oSection1:Cell("CTT_FILIAL"):Disable()	
	oSection1:Cell("N3_CCUSTO"):Disable()
	oSection11:SetTotalText({ || STR0019 + cQuebra } )		//"Total da Conta: "
	oSection1:Cell("N3_CCONTAB"):SetBlock( { || Mascara(N3_CCONTAB) + " - " + (cAliasCT1)->CT1_DESC01 } )
ElseIF nOrder == 2
	SN3->(dbSetOrder(3))
	cWhere := "N3_CCUSTO <> ' ' AND "	
	oSection1:Cell("CT1_FILIAL"):Disable()	
	oSection1:Cell("N3_CCONTAB"):Disable()
	oSection1:Cell("N3_CCUSTO"):SetBlock( { || N3_CCUSTO + " - " + (cAliasCTT)->CTT_DESC01 } )
	oSection11:SetTotalText( {|| STR0020 + cQuebra } )		//"Total do Centro de Custo: "
	cJoin := StrTran( cJoin, "LEFT", "INNER" )
End

If !lMultiFil
	oSection1:Cell("CT1_FILIAL"):Disable()	
	oSection1:Cell("CTT_FILIAL"):Disable()	
	oSection11:Cell("N3_FILIAL"):Disable()
EndIf

cChave := SN3->(IndexKey())

/*
 * Verificação do campo para ativos de custo de provisão
 */
lRealProv := SN3->(FieldPos("N3_ATFCPR")) > 0

cQuery 		:= Criatrab( , .F. )
cAliasCT1	:= cQuery
cAliasCTT	:= cQuery

If lMultiFil .Or. lAgrBens

	IiF(TcGetDb() $ "ORACLE" ,cFunDB := "SUBSTR",cFunDB := "SUBSTRING")
	Iif(nOrder == 1 ,cChave := StrTran( cChave, "N3_FILIAL", "CT1_FILIAL" ) , cChave := StrTran( cChave, "N3_FILIAL", "CTT_FILIAL" ))
	nTamEmp	 := Len(FWCodEmp("CT1"))
	nTamUnit := Len(FWUnitBusiness("CT1"))
	nTamFil  := FwSizeFIlial()

	lCmpEmpCT1	:= (FWModeAccess("CT1",1) == "E" .AND. FWModeAccess("SN3",1) == "E")
	lCmpUniCT1	:= (FWModeAccess("CT1",2) == "E" .AND. FWModeAccess("SN3",2) == "E")
	lCmpFilCT1	:= (FWModeAccess("CT1",3) == "E" .AND. FWModeAccess("SN3",3) == "E")

	lCmpEmpCTT	:= (FWModeAccess("CTT",1) == "E" .AND. FWModeAccess("SN3",1) == "E")
	lCmpUniCTT	:= (FWModeAccess("CTT",2) == "E" .AND. FWModeAccess("SN3",2) == "E")
	lCmpFilCTT	:= (FWModeAccess("CTT",3) == "E" .AND. FWModeAccess("SN3",3) == "E")

	//compartilhamento CT1 sn3
	If (lCmpEmpCT1 .and. lCmpUniCT1 .and. lCmpFilCT1 )
		cCt1Fil := " CT1.CT1_FILIAL = SN3.N3_FILIAL AND "
	Else
		If !lCmpFilCT1 .and. lCmpUniCT1 .and. lCmpEmpCT1
			cCt1Fil := cFunDB+"(CT1.CT1_FILIAL, 1, "+cValToChar(nTamEmp+nTamUnit)+") = "+cFunDB+"(SN3.N3_FILIAL, 1, "+cValToChar(nTamEmp+nTamUnit)+") AND "						
		ElseIf !lCmpUniCT1 .and. lCmpEmpCT1
			cCt1Fil := cFunDB+"(CT1.CT1_FILIAL, 1, "+cValToChar(nTamEmp)+") = "+cFunDB+"(SN3.N3_FILIAL, 1, "+cValToChar(nTamEmp)+") AND "							
		EndIf
	EndIf

	nTamEmp	 := Len(FWCodEmp("CTT"))
	nTamUnit := Len(FWUnitBusiness("CTT"))

	//compartilhamento CTT sn3
	If (lCmpEmpCTT .and. lCmpUniCTT .and. lCmpFilCTT )
		cCttFil := " CTT.CTT_FILIAL = SN3.N3_FILIAL AND "
	Else
		If !lCmpFilCTT .and. lCmpUniCTT .and. lCmpEmpCTT			
			cCttFil := cFunDB+"(CTT.CTT_FILIAL,1,"+cValToChar(nTamEmp+nTamUnit)+") = "+cFunDB+"(SN3.N3_FILIAL, 1, "+cValToChar(nTamEmp+nTamUnit)+") AND "			
		ElseIf !lCmpUniCTT .and. lCmpEmpCTT
			cCttFil := cFunDB+"(CTT.CTT_FILIAL,1,"+cValToChar(nTamEmp)+") = "+cFunDB+"(SN3.N3_FILIAL, 1, "+cValToChar(nTamEmp)+") AND "
		EndIf

	EndIf
EndIf

If !lAgrBens
	If lMultiFil
		//Para ficar na ordem do índice
		cWhere := " SN3.N3_FILIAL BETWEEN '"+MV_PAR15+"' AND '"+MV_PAR16+"' AND "+;
				  " SN3.N3_CBASE >= '"+mv_par01+"' AND "+;
				  " SN3.N3_CBASE <= '"+mv_par02+"' AND "+;
				  cWhere

	Else
		cCt1Fil := " CT1.CT1_FILIAL = '"+xFilial("CT1")+"' AND "
		cCttFil := " CTT.CTT_FILIAL = '"+xFilial("CTT")+"' AND "		
		//Para ficar na ordem do índice
		cWhere  := " SN3.N3_FILIAL = '"+xFilial("SN3")+"' AND "+;
				   " SN3.N3_CBASE >= '"+mv_par01+"' AND "+;
			 	   " SN3.N3_CBASE <= '"+mv_par02+"' AND "+;
				   cWhere 
	EndIf
EndIf

cCt1Fil	:= "%" + cCt1Fil + "%"
cCttFil	:= "%" + cCttFil + "%"

cChave 	:= "%"+SqlOrder(cChave)+"%"

cWhere 	+=	" SN3.N3_BAIXA = '0' AND "

//Tratativa realizada para os bens que possuem taxa de depreciação igual a zero
If Len (aPergunte[2]) > 11
	If MV_PAR12 == 2 // Não considera bens com taxa de depreciação = 0 (zero).
		cWhere 	+=	" SN3.N3_TXDEPR1 <> 0 AND "
	Endif
Else
	cWhere 	+=	" SN3.N3_TXDEPR1 <> 0 AND "
Endif

IF MV_PAR08 == 2 // Somente bens com saldo a depreciar
	For i := 3 To 7
		If	&("mv_par0" + ALLTRIM(STR(i))) == 1	//Se a moeda foi escolhida pelo usuario
			If !Empty( cWhereAux )
				cWhereAux += " OR "
			EndIf
			cWhereAux += "( SN3.N3_VRDACM"+ALLTRIM(STR(i-2))+" < (SN3.N3_VORIG"+ALLTRIM(STR(i-2))+" + SN3.N3_AMPLIA"+ALLTRIM(STR(i-2))+") )"
		EndIf
	Next i

	If !Empty( cWhereAux )
		cWhere += "( " + cWhereAux + " ) AND"
	EndIf
ENDIF

//Verifica se filtra as classificações patrimoniais
If Len(aClassif) > 0  .And.  FindFunction("FormatClas")
	cWhereAux := ""
	cWhereAux += " SN1.N1_PATRIM IN " + FORMATCLAS(aClassif,.T.)
	If !Empty( cWhereAux )
		cWhere += "( " + cWhereAux + " ) AND"
	EndIf
EndIf

If lRealProv .AND. MV_PAR10 == 2
	cWhere += " (SN3.N3_ATFCPR = '2' OR SN3.N3_ATFCPR = ' ') AND "
EndIf

cWhere 	+=	"(SN3.N3_CDEPREC <> ' ' OR "
cWhere 	+=	" SN3.N3_CDESP <> ' ' OR "
cWhere 	+=  " SN3.N3_CCDEPR <> ' ' ) AND "
If MV_PAR11 != 3
	cWhere 	+=  " SN3.N3_TIPO NOT IN (" + cTipos + ") AND "
EndIf

If lAgrBens
	cWhere += " EXISTS (" + ;
			cAtivAgrup + ;
			" AND FM4_FILORI = N3_FILIAL " + ;
			" AND FM4_CBASE = N3_CBASE " + ;
			" AND FM4_ITEM = N3_ITEM) AND "	
EndIf

cWhere	:= "%" + cWhere + "%"

oSection1:BeginQuery()

BeginSql Alias cQuery
	SELECT
		CT1_FILIAL, CTT_FILIAL, N3_FILIAL, N3_TIPO ,N3_CBASE, N3_ITEM, N3_CCUSTO, N3_CCONTAB, N3_VORIG1, N3_AMPLIA1, N3_VRCACM1, N3_VRDACM1, N3_VRCDA1,
		N3_VORIG2, N3_AMPLIA2, N3_VRDACM2, N3_VORIG3, N3_AMPLIA3, N3_VRDACM3, N3_VORIG4, N3_AMPLIA4, N3_VRDACM4,
		N3_VORIG5, N3_AMPLIA5, N3_VRDACM5, N3_CDEPREC, N3_CCDEPR, N1_DESCRIC, CTT_DESC01, CT1_DESC01, N1_PATRIM
	FROM %table:SN3% SN3
		JOIN %table:SN1% SN1 ON
		SN1.N1_FILIAL = SN3.N3_FILIAL
		AND SN1.N1_CBASE = SN3.N3_CBASE
		AND SN1.N1_ITEM = SN3.N3_ITEM
		AND SN1.%notDel%
		INNER JOIN %table:CT1% CT1 ON
		%Exp:cCt1Fil%
		CT1.CT1_CONTA = SN3.N3_CCONTAB
		AND CT1.%notDel%
		%Exp:cJoin% JOIN %table:CTT% CTT ON
		%Exp:cCttFil%
		CTT.CTT_CUSTO = SN3.N3_CCUSTO
		AND CTT.%notDel%
	WHERE
		%Exp:cWhere%
		SN3.%notDel%
	ORDER BY %Exp:cChave%
EndSql

oSection1:EndQuery()
oSection11:SetParentQuery()

// Cria variável a ser usada para impressao do texto da quebra da secao

//****************************************************************************
// Tipos de Ativos gerenciais
// Deixar a linha comentada abaixo- Ideal é criar pergunta para selecionar
// os tipos de ativo a serem considerados
//****************************************************************************
oSection11:SetLineCondition( { || If(nOrder==1, cQuebra := (Mascara(N3_CCONTAB) + " - " + (cAliasCT1)->CT1_DESC01), cQuebra := (N3_CCUSTO + " - " + (cAliasCTT)->CTT_DESC01)) } )
oSection11:SetTotalInLine(.F.)
oReport:SetTotalInLine(.F.)
oReport:SetTotalText(STR0010)  //"T O T A I S"

If nOrder == 1
	oSection11:SetParentFilter({|cParam| (cQuery)->N3_CCONTAB == cParam },{|| (cQuery)->N3_CCONTAB })
Else
	oSection11:SetParentFilter({|cParam| (cQuery)->N3_CCUSTO == cParam },{|| (cQuery)->N3_CCUSTO })
Endif

// Desabilita as celulas conforme parametros
If	mv_par03 == 2
	oSection11:Cell("N3_SALDO1"):Disable()
Else
	TRFunction():New(oSection11:Cell("N3_SALDO1"),,"SUM",,,,, .T., .T. )
Endif
If	mv_par04 == 2
	oSection11:Cell("N3_SALDO2"):Disable()
Else
	TRFunction():New(oSection11:Cell("N3_SALDO2"),,"SUM",,,,, .T., .T. )
Endif
If	mv_par05 == 2
	oSection11:Cell("N3_SALDO3"):Disable()
Else
	TRFunction():New(oSection11:Cell("N3_SALDO3"),,"SUM",,,,, .T., .T. )
Endif
If	mv_par06 == 2
	oSection11:Cell("N3_SALDO4"):Disable()
Else
	TRFunction():New(oSection11:Cell("N3_SALDO4"),,"SUM",,,,, .T., .T. )
Endif
If mv_par07 == 2
	oSection11:Cell("N3_SALDO5"):Disable()
Else
	TRFunction():New(oSection11:Cell("N3_SALDO5"),,"SUM",,,,, .T., .T. )
Endif

oSection1:Print()


Return Nil
