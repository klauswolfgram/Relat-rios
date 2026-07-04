/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "ATFR080.CH"
#Include "Protheus.ch"
#Include "fwcommand.ch"

// TRADUCAO DE CH'S PARA PORTUGAL


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ Atfr080  ³ Autor ³ Claudinei M. Benzi    ³ Data ³ 03.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Listagem do Resumo por Conta                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Atfr080                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SigaAtf                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Atfr080()
Local oReport
/*
GESTAO - inicio */
Private aSelFil	:= {}
/* GESTAO - fim*/
  
	oReport:=ReportDef()

	/* Dialog é chamada apenas se o objeto oReport não estiver vazio*/
	If oReport <> nil
		oReport:PrintDialog()  
	EndIf

return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³23/06/2006³±±
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
Local oReport
Local oSection1 
Local oSection11
Local cReport  := "ATFR080"
Local cTitulo  :=	STR0005	//"Resumo por Conta Atualizado"
Local cDescri  :=	STR0001 + " " +;	// "Emiss„o de Resumo do Ativo Imobilizado por Conta"
						STR0002 + " "   	// "Cont bil e Centro de Custos."
Local bReport  := { |oReport|	ReportPrint( oReport ) }

Pergunte( "AFR080" , .F. )



If mv_par22 == 1 .And. Len( aSelFil ) <= 0 .And. !IsBlind() 
	aSelFil := AdmGetFil()

	/* Caso nenhuma filial seja selecionada */
	If Len( aSelFil ) <= 0  
		Return 	// Retorna o objeto oReport vazio
	EndIf 
EndIf 

oReport  := TReport():New( cReport, cTitulo, "AFR080" , bReport, cDescri )

//oReport:NoUserFilter()

oSection1 := TRSection():New( oReport, STR0017, {"SN3"}  )		//"Entidade Contabil"
TRCell():New( oSection1, "CT1_CONTA" ,"CT1",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "CT1_DESC01","CT1",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "CTT_CUSTO" ,"CTT",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "CTT_DESC01","CTT",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "CTD_ITEM"	  ,"CTD",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "CTD_DESC01","CTD",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "CTH_CLVL"	  ,"CTH",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection1, "CTH_DESC01","CTH",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 

oSection1:Cell("CTT_CUSTO" ):Disable()
oSection1:Cell("CTT_DESC01"):Disable()
oSection1:Cell("CTD_ITEM"  ):Disable()
oSection1:Cell("CTD_DESC01"):Disable()
oSection1:Cell("CTH_CLVL"  ):Disable()
oSection1:Cell("CTH_DESC01"):Disable()

oSection1:SetHeaderSection(.F.)

oSection11 := TRSection():New( oSection1, STR0018, {"SN3"} )		//"Valores"
	TRCell():New( oSection11, "SIMBMOEDA"		, ""	 ,STR0019	  	,/*Picture*/, 6  ,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Moeda"
	TRCell():New( oSection11, "N3_VRCMES1"		, "SN3",/*X3Titulo*/	,/*Picture*/, 14 ,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_VRDMES"		, ""	 ,STR0020		,/*Picture*/, 16 ,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Depreciação"
TRCell():New( oSection11, "N3_VRCDM1"		, "SN3",/*X3Titulo*/	,/*Picture*/, 16 ,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_VRCACM1"		, "SN3",/*X3Titulo*/	,/*Picture*/, 16 ,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New( oSection11, "N3_VRDACM"		, ""	 ,STR0021		,/*Picture*/, 17 ,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Depr. Acumulada"
TRCell():New( oSection11, "N3_VRCDA1"		, "SN3",/*X3Titulo*/	,/*Picture*/, 15 ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "DEPREC_CORREC"	, "SN3",STR0022		,/*Picture*/, 14 ,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Depr.Acum+Correção"
TRCell():New( oSection11, "VLATUALIZADO"	, "SN3",STR0023		,/*Picture*/, 14 ,/*lPixel*/,/*{|| code-block de impressao }*/) 	//"Valor Atualizado"
TRCell():New( oSection11, "VLLIQUIDO"		, "SN3",STR0024 		,/*Picture*/, 14 ,/*lPixel*/,/*{|| code-block de impressao }*/)	//"Valor Liquido" 
TRCell():New( oSection11, "N3_AMPLIA"		, "SN3",/*X3Titulo*/ ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 

oSection11:SetHeaderPage(.T.)
oSection11:SetColSpace(1)
/*
GESTAO - inicio */
oSection11:setLinesBefore(0)
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Claudio D. de Souza º Data ³  24/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao do relatorio                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR070                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local oSection1	 := oReport:Section(1)
Local oSection11	 := oReport:Section(1):Section(1)
Local cFilterUser  := oSection1:GetAdvplExp("SN3")
Local cDescrItem   := ""
Local cIndSN3    := ""
Local cChave     := ""
Local cCond      := ""
Local cMoeda     := ""
Local nA         := 0
Local nB         := 0
Local lImprime   := .F.
Local	cFilDe 	
Local	cFilAte	


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Arrays contendo os Valores por Moeda. Estrutura :                    ³
//³                                                                      ³
//³ aArray[n ,1] : Correcao                                              ³
//³ aArray[n ,2] : Depreciacao                                           ³
//³ aArray[n ,3] : Corr. / Depr.                                         ³
//³ aArray[n ,4] : Corr. Acumulada                                       ³
//³ aArray[n ,5] : Depr. Acumulada                                       ³
//³ aArray[n ,6] : Corr. / Depr. Acum.                                   ³
//³ aArray[n ,7] : Dep. Acum + Correc.                                   ³
//³ aArray[n ,8] : Valor Atual                                           ³
//³ aArray[n ,9] : Valor Liquido                                         ³
//³ aArray[n,10] : Valor Ampliacao                                       ³
//³                                                                      ³
//³ Onde n == 1 (Valores em Moeda 1)                                     ³
//³      n == 2 (Valores em Moeda 2)                                     ³
//³      n == 3 (Valores em Moeda 3)                                     ³
//³      n == 4 (Valores em Moeda 4)                                     ³
//³      n == 5 (Valores em Moeda 5)                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aItemMoeda   // Valor da Conta/Item
Local aContaMoeda  // Valor Total da Conta
Local aGeralMoeda  // Total Geral
Local aFilMoeda    // Total Por Filial

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Obtem o Nome das Moedas.                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cMoeda1 := AllTrim(GetMv("MV_MOEDA1"))
Local cMoeda2 := AllTrim(GetMv("MV_MOEDA2"))
Local cMoeda3 := AllTrim(GetMv("MV_MOEDA3"))
Local cMoeda4 := AllTrim(GetMv("MV_MOEDA4"))
Local cMoeda5 := AllTrim(GetMv("MV_MOEDA5"))
Local cCodReduz := Space(10)
Local cGrupoPass:= GetMv("MV_GRPASS")
Local lInverte 	:= .F.
lOCAL lCtb     	:= CtbInUse()
Local cDescCC	:= "",  nMoedas := 0
Local dUltDepr := Ctod("")
Local bCondBk	 	:= { || .T. } 
Local cCusto		:= ""
Local cItem			:= ""
Local cCLVL			:= ""
Local cDescCLVL	:= ""
Local cCondBk
Local nInc		:= 0
Local cFilOld   := cFilAnt
Local aSM0		:= FWLoadSM0()		/* GESTAO */
Local cTpGerenc	:= ""



// Verificação da classificação de Ativo se sofre depreciação
Local lAtClDepr := .F.  
Local aClassif := {}
Local cClassif := ""

Local cFilProc		:= ""
Local lExclusivo	:= AdmTabExc("SN3") //Analisa se a tabela esta exclusiva
Local lRealProv	:= AFXAtCsPrv()
Local nRegSN3  :=0
Local nNewSN3  :=0
Local nRgCtaN3 :=0
Local nNewRgCtaN3 :=0
Local lAutomato := IsBlind()

/*
GESTAO - inicio */
Local nTamEmp		:= 0
Local lTotEmp		:= .F.
Local aEmpMoeda		:= {}
/* GESTAO - fim
*/

Local cTotFilial := ""
Local cTotEmp	 := ""

IF mv_par23==1 //fiscal
	cTpGerenc	:= ATFXTpBem(1)
ElseIf mv_par23==2 //gerencial
	cTpGerenc	:= ATFXTpBem(2)
Else
	cTpGerenc	:= ATFXTpBem(1)
 	cTpGerenc	+= ATFXTpBem(2)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a condicao para quebra das entidades contabeis³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par14 == 1
	If Empty(cCondBk)
		cCondBk :=  "cCusto == SN3->N3_CCUSTO"
	Else
		cCondBk +=  " .and. cCusto == SN3->N3_CCUSTO"			
	EndIf
EndIf
If mv_par15 == 1
	If Empty(cCondBk)
		cCondBk :=  "cItem == SN3->N3_SUBCCON"
	Else
		cCondBk +=  " .and. cItem == SN3->N3_SUBCCON"
	EndIf
EndIf
If mv_par16 == 1
	If Empty(cCondBk)
		cCondBk :=  "cCLVL == SN3->N3_CLVLCON"		
	Else
		cCondBk +=  " .and. cCLVL == SN3->N3_CLVLCON"			
	EndIf
EndIf
If Empty(cCondBk)
	cCondBk := ".T."
EndIf 

/*
 * Verificação do campo para ativos de custo de provisão
 */
If Select("SN3") == 0
	DbSelectArea("SN3")	
EndIf

bCondBk :=  &("{ || " + cCondBk + "}")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa o Array contendo o Total Geral.                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aGeralMoeda := {  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
						{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
						{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
						{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
						{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } }
						
aFilMoeda := aClone(aGeralMoeda)
						
nMoedas += If(mv_par05 = 1, 1, 0)
nMoedas += If(mv_par06 = 1, 1, 0)
nMoedas += If(mv_par07 = 1, 1, 0)
nMoedas += If(mv_par08 = 1, 1, 0)
nMoedas += If(mv_par09 = 1, 1, 0)


If mv_par15 == 1
	oSection1:Cell("CTD_ITEM"):Enable()
	oSection1:Cell("CTD_DESC01"):Enable()
EndIf
If mv_par14 == 1
	oSection1:Cell("CTT_CUSTO"):Enable()
	oSection1:Cell("CTT_DESC01"):Enable()
EndIf
If mv_par16 == 1
	oSection1:Cell("CTH_CLVL"):Enable()
	oSection1:Cell("CTH_DESC01"):Enable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis ref a filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par17 == 2
	cFilDe  := cFilAnt
	cFilAte := cFilAnt
ELSE
	cFilDe := mv_par18	// Todas as filiais
	cFilAte:= mv_par19
Endif   

If mv_par20 == 1
	aClassif := AdmGetClass()	
	If Len( aClassif ) <= 0
		Return
	EndIf 
EndIf


//Verifica se filtra as classificações patrimoniais
If Len(aClassif) > 0
	cClassif := FormatClass(aClassif,.F.) 
EndIf
/*
GESTAO - inicio */
If MV_PAR22 == 1 .And. !lAutomato
	If Empty(aSelFil)
		If  FindFunction("AdmSelecFil")
			AdmSelecFil("AFR080",22,.F.,@aSelFil,"SN3",.F.)
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SN3")
			If Empty(aSelFil)
				Aadd(aSelFil,cFilAnt)
			Endif
		Endif
	Endif
Endif

If Empty(aSelFil)
	Aadd(aSelFil, cFilAnt)
EndIf

nLenSelFil := Len(aSelFil)
cFilDe := aSelFil[1]
cFilAte := aSelFil[nLenSelFil]
nTamEmp := Len(FWSM0LayOut(,1))
lTotEmp := .F.
aEmpMoeda := aClone(aGeralMoeda)
nInc := 0
/* Deixo na aSM0 somente as filiais selecionas para impressao. */
nLenSelFil := Len(aSM0) 
If  !lAutomato
	For nA := nLenSelFil To 1 Step(-1)
		If  Ascan(aSelFil,aSM0[nA,SM0_CODFIL]) == 0 
			Adel(aSM0,nA)
			nInc++
		Endif
	Next
Else
	For nA := nLenSelFil To 1 Step(-1)
		If  Ascan(aSelFil,AllTrim(aSM0[nA,SM0_CODFIL])) == 0 
			Adel(aSM0,nA)
			nInc++
		Endif
	Next
EndIf
If nInc > 0
	Asize(aSM0,Len(aSM0) - nInc)
Endif
/* Verifico se e necessario a impressao de total por empresa: se as filiais selecionadas pertencem a empresas distintas. */
nLenSelFil := Len(aSM0)
nA := 1 
While nA < nLenSelFil .And. !lTotEmp
	nA++
	lTotEmp := !(aSM0[nA - 1,SM0_EMPRESA] == aSM0[nA,SM0_EMPRESA])
Enddo
/*-*/
nLenSelFil := Len(aSelFil)
/* GESTAO - fim
*/
For nInc := 1 To Len( aSM0 )
	If aSM0[nInc][SM0_GRPEMP] == cEmpAnt .AND. aSM0[nInc][SM0_CODFIL] >= cFilDe .AND. aSM0[nInc][SM0_CODFIL] <= cFilAte		/* GESTAO */
		cFilAnt := aSM0[nInc][SM0_CODFIL]

		dUltDepr := GetMV("MV_ULTDEPR")

		//Tratamento Gestao Corporativa
		If Len(AllTrim(xFilial("SN3")) ) > 2
			If Alltrim(cFilProc) != Alltrim(xFilial("SN3"))
				cFilProc:= xFilial("SN3")
			Else
				Loop
			EndIf
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Indice Temporario p/ o Arquivo SN3.                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SN3")
		
		cIndSN3 := CriaTrab(Nil, .F.)
		cChave  := "N3_FILIAL + N3_CCONTAB "
		If mv_par15 == 1
			cChave += "+ N3_SUBCCON"
		EndIf
		If mv_par14 == 1
			cChave += "+ N3_CCUSTO"
		EndIf
		If mv_par16 == 1
			cChave += "+ N3_CLVLCON"
		EndIf
		cCond   :=         'N3_FILIAL  == "' +xFilial("SN3")+'" .And. '
		cCond   := cCond + 'N3_CCONTAB >= "' + mv_par01 + '"    .And. '
		cCond   := cCond + 'N3_CCONTAB <= "' + mv_par02 + '"    .And. '
		cCond   := cCond + 'N3_CCUSTO  >= "' + mv_par03 + '"    .And. '
	 	cCond   := cCond + 'N3_CCUSTO  <= "' + mv_par04 + '"'
	
	  	If !Empty(cFilterUser)  
		   	cCond += " .And. " + cFilterUser
		EndIf
	       
	    oSection11:SetFilter(cCond,cChave)
	
		IndRegua("SN3",cIndSN3,cChave,,cCond,STR0007)  //"Criando Indice..."
		nOrderSN3 := RetIndex("SN3") + 1
	
		#IFNDEF TOP
	  		SN3->( dbSetIndex( cIndSN3 + OrdBagExt() ) )
		#ENDIF
			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Lˆ o Arquivo SN3 p/ Impressao do Relatorio.                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SN3")
		dbSetOrder(nOrderSN3)
		oReport:SetMeter(RecCount())
		SN3->(dbGoTop())
	
		oSection1:Init()
		
		While	SN3->(!Eof()) .And. SN3->N3_FILIAL=xFilial("SN3")						
			cConta := SN3->N3_CCONTAB
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializa o Array contendo o Total da Conta.                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aContaMoeda :=  { { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } }
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Quebra por Filial + Conta.                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While	SN3->(!Eof()) .And. xFilial("SN3") + cConta == SN3->N3_FILIAL + SN3->N3_CCONTAB
				nRgCtaN3 := SN3->(Recno()) // Salva Recno Original da conta 
				cCLVL  := SN3->N3_CLVLCON
				cItem  := SN3->N3_SUBCCON
				cCusto := SN3->N3_CCUSTO
		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Inicializa o Array contendo o Total do Item.                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				aItemMoeda := {{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } }
		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Quebra por Filial + Conta + Item + Centro de Custo.        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				While	SN3->(!Eof()) .And. xFilial("SN3") == SN3->N3_FILIAL .and. cConta == SN3->N3_CCONTAB .and. Eval(bCondBk)
					nRegSN3 := SN3->(Recno()) // Salva Recno Original
					oReport:IncMeter()
		
	
					//*****************************
					// Tipos  de Ativos		      *
					//*****************************
					If !( SN3->N3_TIPO $ cTpGerenc )
						SN3->( DbSkip() )
						Loop
					EndIf

					//---------------------------------------------------------------
					//Desconsidero todos os bens baixados com data(mes/ano) anterior
					// ao ultimo calculo de depreciação
					//---------------------------------------------------------------
					If Val(SN3->N3_BAIXA) != 0
						If (MesAnoAtf(SN3->N3_DTBAIXA) < MesAnoAtf(dUltDepr))
							SN3->(dbSkip())
							Loop
						EndIf
					EndIf
					
					
					//---------------------------------------------------------------
					// Desconsidero os bens com baixa POSTERIOR ao ultimo calculo de
					// depreciação, caso o parametro Considera Baixa Pos Calculo 
					// (MV_PAR10) igual a NÂO
					//---------------------------------------------------------------
					If mv_par10 == 2
						If Val(SN3->N3_BAIXA) # 0
							SN3->(dbSkip())
							Loop
						EndIf
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Pesquisa o Arquivo SN1.                                    ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("SN1")
					dbSeek( xFilial() + SN3->N3_CBASE + SN3->N3_ITEM )
		
					If mv_par13 == 2 .And. MesAnoAtf(SN1->N1_AQUISIC) > MesAnoAtf(dUltDepr)
						SN3->(dbSkip())
						Loop
					EndIf
					
					//Verifica se filtra as classificações patrimoniais
					If Len(aClassif) > 0  
						If !(SN1->N1_PATRIM $ cClassif)
							SN3->(dbSkip())
							Loop 										
						EndIf
					EndIf 
					 
					If lRealProv .AND. MV_PAR21 == 2 .AND. SN3->N3_ATFCPR == '1'
						SN3->(dbSkip())
						Loop
				    EndIf
		
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Pesquisa a Conta no SI1/CT1                                ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lCtb
						dbSelectArea("CT1")
						dbSetOrder(1)
						dbSeek(xFilial()+SN3->N3_CCONTAB)
						If Subst(CT1->CT1_CONTA,1,1)$cGrupoPass .And. SN1->N1_PATRIM$"SCP"
							If CT1->CT1_NORMAL="1"
								lInverte:= .T.
							EndIf
						Endif
					Else
						dbSelectArea("SI1")
						dbSetOrder(1)
						dbSeek(xFilial()+SN3->N3_CCONTAB)
						If Subst(SI1->I1_CODIGO,1,1)$cGrupoPass .And. SN1->N1_PATRIM$"SCP"
							If SI1->I1_NORMAL="D"
								lInverte:= .T.
							EndIf
						Endif
					EndIf
		
					// Verificação da classificação de Ativo se sofre depreciação
					lAtClDepr := Iif(FindFunction("AtClssVer"),AtClssVer(SN1->N1_PATRIM),SN1->N1_PATRIM $ "NID")
					
					If lAtClDepr .OR. SN1->N1_PATRIM $ " P" .And. IIf(Len(aClassif) > 0,SN1->N1_PATRIM $ cClassif,.T.)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 1.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[1, 1] := aItemMoeda[1, 1] + SN3->N3_VRCMES1
						aItemMoeda[1, 2] := aItemMoeda[1, 2] + If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES1, 0)
						aItemMoeda[1, 3] := aItemMoeda[1, 3] + SN3->N3_VRCDM1
						aItemMoeda[1, 4] := aItemMoeda[1, 4] + SN3->N3_VRCACM1
						aItemMoeda[1, 5] := aItemMoeda[1, 5] + SN3->N3_VRDACM1
						aItemMoeda[1, 6] := aItemMoeda[1, 6] + SN3->N3_VRCDA1
						aItemMoeda[1, 7] := aItemMoeda[1, 7] + SN3->N3_VRDACM1 + SN3->N3_VRCDA1
						aItemMoeda[1, 8] := aItemMoeda[1, 8] + Iif(lInverte,(SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1)*(-1),SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1)
						aItemMoeda[1, 9] := aItemMoeda[1, 9] + IIf(lInverte,((SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1)-(SN3->N3_VRDACM1+SN3->N3_VRCDA1))*(-1),((SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1)-(SN3->N3_VRDACM1+SN3->N3_VRCDA1)))
						aItemMoeda[1,10] := aItemMoeda[1,10] + SN3->N3_AMPLIA1
		
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 2.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[2, 2] := aItemMoeda[2, 2] + If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES2, 0)
						aItemMoeda[2, 5] := aItemMoeda[2, 5] + SN3->N3_VRDACM2
						aItemMoeda[2, 8] := aItemMoeda[2, 8] + Iif(lInverte,(SN3->N3_VORIG2+SN3->N3_AMPLIA2)*(-1),SN3->N3_VORIG2+SN3->N3_AMPLIA2)
						aItemMoeda[2, 9] := aItemMoeda[2, 9] + Iif(lInverte,((SN3->N3_VORIG2+SN3->N3_AMPLIA2)-SN3->N3_VRDACM2)*(-1),(SN3->N3_VORIG2+SN3->N3_AMPLIA2)-SN3->N3_VRDACM2)
						aItemMoeda[2,10] := aItemMoeda[2,10] + SN3->N3_AMPLIA2
		
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 3.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[3, 2] := aItemMoeda[3, 2] + If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES3, 0)
						aItemMoeda[3, 5] := aItemMoeda[3, 5] + SN3->N3_VRDACM3
						aItemMoeda[3, 8] := aItemMoeda[3, 8] + Iif(lInverte,(SN3->N3_VORIG3+SN3->N3_AMPLIA3)*(-1),SN3->N3_VORIG3+SN3->N3_AMPLIA3)
						aItemMoeda[3, 9] := aItemMoeda[3, 9] + Iif(lInverte,((SN3->N3_VORIG3+SN3->N3_AMPLIA3)-SN3->N3_VRDACM3)*(-1),(SN3->N3_VORIG3+SN3->N3_AMPLIA3)-SN3->N3_VRDACM3)
						aItemMoeda[3,10] := aItemMoeda[3,10] + SN3->N3_AMPLIA3
		
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 4.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[4, 2] := aItemMoeda[4, 2] + If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES4, 0)
						aItemMoeda[4, 5] := aItemMoeda[4, 5] + SN3->N3_VRDACM4
						aItemMoeda[4, 8] := aItemMoeda[4, 8] + Iif(lInverte,(SN3->N3_VORIG4+SN3->N3_AMPLIA4)*(-1),SN3->N3_VORIG4+SN3->N3_AMPLIA4)
						aItemMoeda[4, 9] := aItemMoeda[4, 9] + Iif(lInverte,((SN3->N3_VORIG4+SN3->N3_AMPLIA4)-SN3->N3_VRDACM4)*(-1),(SN3->N3_VORIG4+SN3->N3_AMPLIA4)-SN3->N3_VRDACM4)
						aItemMoeda[4,10] := aItemMoeda[4,10] + SN3->N3_AMPLIA4
		
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 5.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[5, 2] := aItemMoeda[5, 2] + If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES5, 0)
						aItemMoeda[5, 5] := aItemMoeda[5, 5] + SN3->N3_VRDACM5
						aItemMoeda[5, 8] := aItemMoeda[5, 8] + Iif(lInverte,(SN3->N3_VORIG5+SN3->N3_AMPLIA5)*(-1),SN3->N3_VORIG5+SN3->N3_AMPLIA5)
						aItemMoeda[5, 9] := aItemMoeda[5, 9] + Iif(lInverte,((SN3->N3_VORIG5+SN3->N3_AMPLIA5)-SN3->N3_VRDACM5)*(-1),(SN3->N3_VORIG5+SN3->N3_AMPLIA5)-SN3->N3_VRDACM5)
						aItemMoeda[5,10] := aItemMoeda[5,10] + SN3->N3_AMPLIA5
					Else
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 1.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[1 ,1] := aItemMoeda[1, 1] - SN3->N3_VRCMES1
						aItemMoeda[1, 2] := aItemMoeda[1, 2] - If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES1, 0)
						aItemMoeda[1, 3] := aItemMoeda[1, 3] - SN3->N3_VRCDM1
						aItemMoeda[1, 4] := aItemMoeda[1, 4] - SN3->N3_VRCACM1
						aItemMoeda[1, 5] := aItemMoeda[1, 5] - SN3->N3_VRDACM1
						aItemMoeda[1, 6] := aItemMoeda[1, 6] - SN3->N3_VRCDA1
						aItemMoeda[1, 7] := aItemMoeda[1, 7] - (SN3->N3_VRDACM1 + SN3->N3_VRCDA1)
						aItemMoeda[1, 8] := aItemMoeda[1, 8] - Iif(lInverte,(SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1)*(-1),(SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1))
						aItemMoeda[1, 9] := aItemMoeda[1, 9] - Iif(lInverte,(SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1)*(-1),(SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1))
						aItemMoeda[1,10] := aItemMoeda[1,10] - SN3->N3_AMPLIA1
		
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 2.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[2, 2] := aItemMoeda[2, 2] - If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES2, 0)
						aItemMoeda[2, 5] := aItemMoeda[2, 5] - SN3->N3_VRDACM2
						aItemMoeda[2, 8] := aItemMoeda[2, 8] -Iif(lInverte,(SN3->N3_VORIG2+SN3->N3_AMPLIA2)*(-1),(SN3->N3_VORIG2+SN3->N3_AMPLIA2))
						aItemMoeda[2, 9] := aItemMoeda[2, 9] -Iif(lInverte,(SN3->N3_VORIG2+SN3->N3_AMPLIA2)*(-1),(SN3->N3_VORIG2+SN3->N3_AMPLIA2))
						aItemMoeda[2,10] := aItemMoeda[2,10] - SN3->N3_AMPLIA2
		
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 3.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[3, 2] := aItemMoeda[3, 2] - If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES3, 0)
						aItemMoeda[3, 5] := aItemMoeda[3, 5] - SN3->N3_VRDACM3
						aItemMoeda[3, 8] := aItemMoeda[3, 8] - Iif(lInverte,(SN3->N3_VORIG3+SN3->N3_AMPLIA3)*(-1),(SN3->N3_VORIG3+SN3->N3_AMPLIA3))
						aItemMoeda[3, 9] := aItemMoeda[3, 9] - Iif(lInverte,(SN3->N3_VORIG3+SN3->N3_AMPLIA3)*(-1),(SN3->N3_VORIG3+SN3->N3_AMPLIA3))
						aItemMoeda[3,10] := aItemMoeda[3,10] - SN3->N3_AMPLIA3
		
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 4.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[4, 2] := aItemMoeda[4, 2] - If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES4, 0)
						aItemMoeda[4, 5] := aItemMoeda[4, 5] - SN3->N3_VRDACM4
						aItemMoeda[4, 8] := aItemMoeda[4, 8] - Iif(lInverte,(SN3->N3_VORIG3+SN3->N3_AMPLIA3)*(-1),(SN3->N3_VORIG3+SN3->N3_AMPLIA3))
						aItemMoeda[4, 9] := aItemMoeda[4, 9] - Iif(lInverte,(SN3->N3_VORIG4+SN3->N3_AMPLIA4)*(-1),(SN3->N3_VORIG4+SN3->N3_AMPLIA4))
						aItemMoeda[4,10] := aItemMoeda[4,10] - SN3->N3_AMPLIA4
		
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Valores da Moeda 5.                                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aItemMoeda[5, 2] := aItemMoeda[5, 2] - If(Empty(SN1->N1_DTBLOQ) .Or. Dtos(SN1->N1_DTBLOQ) < Dtos(dUltDepr), SN3->N3_VRDMES5, 0)
						aItemMoeda[5, 5] := aItemMoeda[5, 5] - SN3->N3_VRDACM5
						aItemMoeda[5, 8] := aItemMoeda[5, 8] - Iif(lInverte,(SN3->N3_VORIG5+SN3->N3_AMPLIA5)*(-1),(SN3->N3_VORIG5+SN3->N3_AMPLIA5))
						aItemMoeda[5, 9] := aItemMoeda[5, 9] - Iif(lInverte,(SN3->N3_VORIG5+SN3->N3_AMPLIA5)*(-1),(SN3->N3_VORIG5+SN3->N3_AMPLIA5))
						aItemMoeda[5,10] := aItemMoeda[5,10] - SN3->N3_AMPLIA5
					EndIf
					lInverte := .F.
					SN3->(dbSkip())
				EndDo  // Quebra por Filial + Conta + Item + Centro de Custo + ClVl (de acordo com os parametros)
		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Pesquisa o Arquivo SID/CTD (Cad. de Itens) p/ obter a Des- ³
				//³ cao do Item.                                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lCtb
					If mv_par15 == 1
						dbSelectArea("CTD")
						dbSetOrder(1)
						If !Empty(cItem) .and. MsSeek(xFilial("CTD")+cItem,.F.)
							cDescrItem := CTD->CTD_DESC01
						Else
							cDescrItem := Space(20)
						EndIf
					EndIf
						
					If mv_par14 == 1
						dbSelectArea("CTT")
						dbSetOrder(1)
						If !Empty(cCusto) .and. MsSeek(xFilial("CTT")+cCusto,.F.)
							cDescCC := CTT->CTT_DESC01
						Else
							cDescCC := Space(20)
						EndIf
					EndIf
		
					If mv_par16 == 1
						dbSelectArea("CTH")
						dbSetOrder(1)
						If !Empty(cCLVL) .and. MsSeek(xFilial("CTH")+cCLVL,.F.)
							cDescClVl := CTH->CTH_DESC01
						Else
							cDescClVl := Space(20)
						EndIf
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Pesquisa o Arquivo CT1 (Plano de Contas) p/ obter a Descri-³
					//³ cao da Conta.                                              ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("CT1")
					dbSetOrder(1)
					MsSeek(xFilial("CT1")+cConta,.T.)
					cCodReduz := IIf(!Empty(CT1->CT1_RES),CT1->CT1_RES,cConta)
				Else
					dbSelectArea("SID")
					dbSetOrder(1)
					dbSeek( xFilial() + cItem )
		
					cDescrItem := Iif(Found() .And. !Empty(cItem), SID->ID_DESC, Space(20))
					
					dbSelectArea("SI3")
					dbSetOrder(1)
					dbSeek(xFilial() + cCusto)
					cDescCC := Iif(Found() .And. !Empty(cCusto), SI3->I3_DESC, Space(20))			
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Pesquisa o Arquivo SI1 (Plano de Contas) p/ obter a Descri-³
					//³ cao da Conta.                                              ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("SI1")
					dbSetOrder(1)
					dbSeek( xFilial() + cConta )
					cCodReduz := IIf(!Empty(SI1->I1_RES),SI1->I1_RES,cConta)
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se Existe Valor <> 0 no Total do Item.            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				lImprime := .F.
		
				For nA := 1 To Len(aItemMoeda)
					For nB := 1 To Len(aItemMoeda[nA])
						If !Empty(aItemMoeda[nA][nB])
							lImprime := .T.
		
							Exit
						EndIf
					Next nB
				Next nA
				nNewSN3 := SN3->(Recno()) //Salva SN3 para continuar o loop
				SN3->(dbGoTo(nRegSN3)) //Restaura o SN3 original para fims de campos adcionados pelo usuario 
				
		
				If lImprime
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao da Conta, Item, Centro de Custo e Descricao da   ³
					//³ Conta.                                                     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oSection1:Cell("CT1_CONTA"):SetBlock( {|| If( mv_par11 = 1, Mascara(cConta,,"C"), cCodReduz) } )
					oSection1:Cell("CT1_DESC01"):SetBlock( {|| If(lCtb,CT1->CT1_DESC01,SI1->I1_DESC) } )
					
					oSection1:Cell("CTT_CUSTO"):SetBlock( {|| cCusto } )
					oSection1:Cell("CTT_DESC01"):SetBlock( {|| cDescCC } )
					
					oSection1:Cell("CTD_ITEM"):SetBlock( {|| cItem } )
					oSection1:Cell("CTD_DESC01"):SetBlock( {|| cDescrItem } )
					
					oSection1:Cell("CTH_CLVL"):SetBlock( {|| cCLVL } )
					oSection1:Cell("CTH_DESC01"):SetBlock( {|| cDescCLVL } )
					
					oReport:SkipLine()
					oSection1:PrintLine()
					
					//oReport:ThinLine()
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao dos Valores de cada Moeda.                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oSection11:Init()
					For nA := 1 To 5
						Do Case
							Case nA == 1
								cMoeda := cMoeda1
		
							Case nA == 2
								cMoeda := cMoeda2
		
							Case nA == 3
								cMoeda := cMoeda3
		
							Case nA == 4
								cMoeda := cMoeda4
		
							Case nA == 5
								cMoeda := cMoeda5
						EndCase
		
						R080VlrR4(nA, cMoeda, aItemMoeda, oReport)
					Next nA
					oSection11:Finish()
		
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Atualiza o Total da Conta.                                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					For nA := 1 To Len(aItemMoeda)
						aContaMoeda[nA, 1] := aContaMoeda[nA, 1] + aItemMoeda[nA, 1]
						aContaMoeda[nA, 2] := aContaMoeda[nA, 2] + aItemMoeda[nA, 2]
						aContaMoeda[nA, 3] := aContaMoeda[nA, 3] + aItemMoeda[nA, 3]
						aContaMoeda[nA, 4] := aContaMoeda[nA, 4] + aItemMoeda[nA, 4]
						aContaMoeda[nA, 5] := aContaMoeda[nA, 5] + aItemMoeda[nA, 5]
						aContaMoeda[nA, 6] := aContaMoeda[nA, 6] + aItemMoeda[nA, 6]
						aContaMoeda[nA, 7] := aContaMoeda[nA, 7] + aItemMoeda[nA, 7]
						aContaMoeda[nA, 8] := aContaMoeda[nA, 8] + aItemMoeda[nA, 8]
						aContaMoeda[nA, 9] := aContaMoeda[nA, 9] + aItemMoeda[nA, 9]
						aContaMoeda[nA,10] := aContaMoeda[nA,10] + aItemMoeda[nA,10]
					Next nA
				EndIf
				
				SN3->(dbGoTo(nNewSN3)) //Restaura o proximo SN3 para loop do relatorio		
				dbSelectArea("SN3")
			EndDo  // Quebra por Filial + Conta
			nNewRgCtaN3 := SN3->(Recno()) //Salva SN3 para continuar o loop
			SN3->(dbGoTo(nRgCtaN3)) //Restaura o SN3 original para fims de campos adcionados pelo usuario 
			
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se Existe Valor <> 0 no Total da Conta.           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lImprime := .F.
		
			For nA := 1 To Len(aContaMoeda)
				For nB := 1 To Len(aContaMoeda[nA])
					If !Empty(aContaMoeda[nA][nB])
						lImprime := .T.
		
						Exit
					EndIf
				Next nB
			Next nA
		
			If lImprime
				If mv_par12 == 1  //Imprime total da conta
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao dos Valores do Total da Conta.                   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oReport:SkipLine()
					If !(oReport:nDevice == 4 .and. oReport:NEXCELPRINTTYPE == 3)
						oReport:PrintText(STR0014) //"Total Conta"
					Else
						oSection1:Cell("CT1_CONTA"):SetBlock( {|| STR0014 } )
						oSection1:Cell("CT1_DESC01"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTT_CUSTO"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTT_DESC01"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTD_ITEM"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTD_DESC01"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTH_CLVL"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTH_DESC01"):SetBlock( {|| '  ' } )
						oSection1:PrintLine()
					EndIf

					oReport:ThinLine()
		
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao dos Valores de cada Moeda.                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oSection11:Init()
					For nA := 1 To 5
						Do Case
							Case nA == 1
								cMoeda := cMoeda1
		
							Case nA == 2
								cMoeda := cMoeda2
		
							Case nA == 3
								cMoeda := cMoeda3
		
							Case nA == 4
								cMoeda := cMoeda4
		
							Case nA == 5
								cMoeda := cMoeda5
						EndCase
						R080VlrR4(nA, cMoeda, aContaMoeda, oReport)
					Next nA
					oSection11:Finish()
					oReport:SkipLine()
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualiza o Total Geral.                                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				For nA := 1 To Len(aContaMoeda)
					aGeralMoeda[nA, 1] := aGeralMoeda[nA, 1] + aContaMoeda[nA, 1]
					aGeralMoeda[nA, 2] := aGeralMoeda[nA, 2] + aContaMoeda[nA, 2]
					aGeralMoeda[nA, 3] := aGeralMoeda[nA, 3] + aContaMoeda[nA, 3]
					aGeralMoeda[nA, 4] := aGeralMoeda[nA, 4] + aContaMoeda[nA, 4]
					aGeralMoeda[nA, 5] := aGeralMoeda[nA, 5] + aContaMoeda[nA, 5]
					aGeralMoeda[nA, 6] := aGeralMoeda[nA, 6] + aContaMoeda[nA, 6]
					aGeralMoeda[nA, 7] := aGeralMoeda[nA, 7] + aContaMoeda[nA, 7]
					aGeralMoeda[nA, 8] := aGeralMoeda[nA, 8] + aContaMoeda[nA, 8]
					aGeralMoeda[nA, 9] := aGeralMoeda[nA, 9] + aContaMoeda[nA, 9]
					aGeralMoeda[nA,10] := aGeralMoeda[nA,10] + aContaMoeda[nA,10]
					
					aFilMoeda[nA, 1] += aContaMoeda[nA, 1]
					aFilMoeda[nA, 2] += aContaMoeda[nA, 2]
					aFilMoeda[nA, 3] += aContaMoeda[nA, 3]
					aFilMoeda[nA, 4] += aContaMoeda[nA, 4]
					aFilMoeda[nA, 5] += aContaMoeda[nA, 5]
					aFilMoeda[nA, 6] += aContaMoeda[nA, 6]
					aFilMoeda[nA, 7] += aContaMoeda[nA, 7]
					aFilMoeda[nA, 8] += aContaMoeda[nA, 8]
					aFilMoeda[nA, 9] += aContaMoeda[nA, 9]
					aFilMoeda[nA,10] += aContaMoeda[nA,10]
					/*
					GESTAO - inicio*/
					aEmpMoeda[nA, 1] += aContaMoeda[nA, 1]
					aEmpMoeda[nA, 2] += aContaMoeda[nA, 2]
					aEmpMoeda[nA, 3] += aContaMoeda[nA, 3]
					aEmpMoeda[nA, 4] += aContaMoeda[nA, 4]
					aEmpMoeda[nA, 5] += aContaMoeda[nA, 5]
					aEmpMoeda[nA, 6] += aContaMoeda[nA, 6]
					aEmpMoeda[nA, 7] += aContaMoeda[nA, 7]
					aEmpMoeda[nA, 8] += aContaMoeda[nA, 8]
					aEmpMoeda[nA, 9] += aContaMoeda[nA, 9]
					aEmpMoeda[nA,10] += aContaMoeda[nA,10]
					/* GESTAO - fim
					*/
				Next nA
	
			EndIf
			SN3->(dbGoTo(nNewRgCtaN3)) //Restaura o proximo SN3 para loop do relatorio		
			dbSelectArea("SN3")
		EndDo  // Quebra por Fim de Arquivo
		
		// Imprime o Total Por Filial
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se Existe Valor <> 0 no Total por Filial          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lImprime := .F.
		
		For nA := 1 To Len(aFilMoeda)
			For nB := 1 To Len(aFilMoeda[nA])
				If !Empty(aFilMoeda[nA][nB])
					lImprime := .T.
		
					Exit
				EndIf
			Next nB
		Next nA
		If lImprime .And. (nLenSelFil > 1 .Or. (mv_par17 == 1 .and. nInc > 1))		/* GESTAO */
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao do Total por Filial                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:SkipLine()
			
			cTotFilial := STR0025 + " " + Iif(nLenSelFil > 0 .Or. mv_par17==1,cFilAnt + " - " + AllTrim(aSM0[nInc][SM0_NOMRED]),"") //"T O T A L   F I L I A L ----> "

			If !(oReport:nDevice == 4 .and. oReport:NEXCELPRINTTYPE == 3)
				oReport:PrintText(cTotFilial)
			Else
				oSection1:Cell("CT1_CONTA"):SetBlock( {|| cTotFilial } )
				oSection1:Cell("CT1_DESC01"):SetBlock( {|| '  ' } )
				oSection1:Cell("CTT_CUSTO"):SetBlock( {|| '  ' } )
				oSection1:Cell("CTT_DESC01"):SetBlock( {|| '  ' } )
				oSection1:Cell("CTD_ITEM"):SetBlock( {|| '  ' } )
				oSection1:Cell("CTD_DESC01"):SetBlock( {|| '  ' } )
				oSection1:Cell("CTH_CLVL"):SetBlock( {|| '  ' } )
				oSection1:Cell("CTH_DESC01"):SetBlock( {|| '  ' } )
				oSection1:PrintLine()
			EndIf

			oReport:ThinLine()
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao dos Valores de cada Moeda.                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oSection11:Init()
			For nA := 1 To 5
				Do Case
					Case nA == 1
						cMoeda := cMoeda1
		
					Case nA == 2
						cMoeda := cMoeda2
		
					Case nA == 3
						cMoeda := cMoeda3
		
					Case nA == 4
						cMoeda := cMoeda4
		
					Case nA == 5
						cMoeda := cMoeda5
				EndCase
				R080VlrR4(nA, cMoeda, aFilMoeda, oReport)
			Next nA
			oSection11:Finish()
			oReport:SkipLine()
		EndIf
		aFilMoeda := {	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
							{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
							{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
							{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
							{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } }
		/*
		GESTAO - inicio
		Imprime o total por empresa
		*/
		If lTotEmp
			If nInc == Len(aSM0) .Or. !(Substr(aSM0[nInc,SM0_CODFIL],1,nTamEmp) == Substr(aSM0[nInc + 1,SM0_CODFIL],1,nTamEmp))
				lImprime := .F.
				nA := 0
				While (nA < Len(aEmpMoeda)) .And. !lImprime
					nA++
					nB := 0
					While (nB < Len(aEmpMoeda[nA])) .And. !lImprime
						nB++
						lImprime := !Empty(aEmpMoeda[nA][nB])
					Enddo
				Enddo
				If lImprime
					oReport:SkipLine()		
					
					cTotEmp := STR0026 + " " + aSM0[nInc,SM0_EMPRESA] + " " + AllTrim(aSM0[nInc,SM0_DESCEMP]) //"T O T A L   E M P R E S A -->"

					If !(oReport:nDevice == 4 .and. oReport:NEXCELPRINTTYPE == 3)
						oReport:PrintText(cTotEmp)
					Else
						oSection1:Cell("CT1_CONTA"):SetBlock( {|| cTotEmp } )
						oSection1:Cell("CT1_DESC01"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTT_CUSTO"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTT_DESC01"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTD_ITEM"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTD_DESC01"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTH_CLVL"):SetBlock( {|| '  ' } )
						oSection1:Cell("CTH_DESC01"):SetBlock( {|| '  ' } )
						oSection1:PrintLine()
					EndIf

					oReport:ThinLine()
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Impressao dos Valores de cada Moeda.                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oSection11:Init()
					For nA := 1 To 5
						Do Case
							Case nA == 1
								cMoeda := cMoeda1
							Case nA == 2
								cMoeda := cMoeda2
							Case nA == 3
								cMoeda := cMoeda3
							Case nA == 4
								cMoeda := cMoeda4
							Case nA == 5
								cMoeda := cMoeda5
						EndCase
						R080VlrR4(nA, cMoeda, aEmpMoeda, oReport)
					Next nA
					oSection11:Finish()
					oReport:SkipLine()
					aEmpMoeda := {	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },;
									{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } }
				Endif
			Endif
		Endif
		/* GESTAO - fim
		*/
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Restaura o Arquivo SN3.                                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SN3")
		RetIndex("SN3")
		FErase(cIndSN3 + OrdBagExt())
		If !lExclusivo
			Exit
		Endif
	EndIf
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se Existe Valor <> 0 no Total Geral.              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lImprime := .F.

For nA := 1 To Len(aGeralMoeda)
	For nB := 1 To Len(aGeralMoeda[nA])
		If !Empty(aGeralMoeda[nA][nB])
			lImprime := .T.

			Exit
		EndIf
	Next nB
Next nA

If lImprime
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Total Geral.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine()

	If !(oReport:nDevice == 4 .and. oReport:NEXCELPRINTTYPE == 3)
		oReport:PrintText(STR0015) //"Total Geral"
	Else
		oSection1:Cell("CT1_CONTA"):SetBlock( {|| STR0015 } )
		oSection1:Cell("CT1_DESC01"):SetBlock( {|| '  ' } )
		oSection1:Cell("CTT_CUSTO"):SetBlock( {|| '  ' } )
		oSection1:Cell("CTT_DESC01"):SetBlock( {|| '  ' } )
		oSection1:Cell("CTD_ITEM"):SetBlock( {|| '  ' } )
		oSection1:Cell("CTD_DESC01"):SetBlock( {|| '  ' } )
		oSection1:Cell("CTH_CLVL"):SetBlock( {|| '  ' } )
		oSection1:Cell("CTH_DESC01"):SetBlock( {|| '  ' } )
		oSection1:PrintLine()
	EndIf

	oReport:ThinLine()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao dos Valores de cada Moeda.                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection11:Init()
	For nA := 1 To 5
		Do Case
			Case nA == 1
				cMoeda := cMoeda1

			Case nA == 2
				cMoeda := cMoeda2

			Case nA == 3
				cMoeda := cMoeda3

			Case nA == 4
				cMoeda := cMoeda4

			Case nA == 5
				cMoeda := cMoeda5
		EndCase
		R080VlrR4(nA, cMoeda, aGeralMoeda, oReport)
	Next nA
	oSection11:Finish()
	oReport:ThinLine()
EndIf

oSection1:Finish()

cFilAnt := cFilOld

Return

Static Function R080VlrR4(nMoeda, cMoeda, aValor, oReport)

Local lImprime := .F.
Local cPicture := ""
Local nDecimal := MSdecimais(nMoeda) // Indica a quantidade de casas decimais da moeda em uso
Local nA	   := 0
Local oSection11	 := oReport:Section(1):Section(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a Moeda foi Selecionada.                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case nMoeda == 1 .And. mv_par05 == 1
		lImprime := .T.

	Case nMoeda == 2 .And. mv_par06 == 1
		lImprime := .T.

	Case nMoeda == 3 .And. mv_par07 == 1
		lImprime := .T.

	Case nMoeda == 4 .And. mv_par08 == 1
		lImprime := .T.

	Case nMoeda == 5 .And. mv_par09 == 1
		lImprime := .T.
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a Picture de acordo com a Moeda.                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nMoeda == 1
	cPicture := "@E 999,999,999,999"
Else
	cPicture := "@E 999,999,999,999"
EndIf

///////////////////////////////////////
// Acrescenta a qtde de casas decimais, 
// respeitando o configurado em MV_CENT
// Alteracao conforme BOPS 66.785
// Cristiano Denardi
For nA := 1 to nDecimal
	If ( nA = 1 ) 
		cPicture += "."
	Endif
	cPicture += "9"
Next nA

oSection11:Cell("N3_VRCMES1"):SetBlock({|| aValor[nMoeda, 1] })
oSection11:Cell("N3_VRCMES1"):SetPicture(cPicture)

oSection11:Cell("N3_VRDMES"):SetBlock({|| aValor[nMoeda, 2] })
oSection11:Cell("N3_VRDMES"):SetPicture(cPicture)

oSection11:Cell("N3_VRCDM1"):SetBlock({|| aValor[nMoeda, 3] })
oSection11:Cell("N3_VRCDM1"):SetPicture(cPicture)

oSection11:Cell("N3_VRCACM1"):SetBlock({|| aValor[nMoeda, 4] })
oSection11:Cell("N3_VRCACM1"):SetPicture(cPicture)

oSection11:Cell("N3_VRDACM"):SetBlock({|| aValor[nMoeda, 5] })
oSection11:Cell("N3_VRDACM"):SetPicture(cPicture)

oSection11:Cell("N3_VRCDA1"):SetBlock({|| aValor[nMoeda, 6] })
oSection11:Cell("N3_VRCDA1"):SetPicture(cPicture)

oSection11:Cell("DEPREC_CORREC"):SetBlock({|| aValor[nMoeda, 7] })
oSection11:Cell("DEPREC_CORREC"):SetPicture(cPicture)

oSection11:Cell("VLATUALIZADO"):SetBlock({|| aValor[nMoeda, 8] })
oSection11:Cell("VLATUALIZADO"):SetPicture(cPicture)

oSection11:Cell("VLLIQUIDO"):SetBlock({|| aValor[nMoeda, 9] })
oSection11:Cell("VLLIQUIDO"):SetPicture(cPicture)

oSection11:Cell("N3_AMPLIA"):SetBlock({|| aValor[nMoeda, 10] })
oSection11:Cell("N3_AMPLIA"):SetPicture(cPicture)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos Valores.                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lImprime
	oSection11:Cell("SIMBMOEDA"):SetBlock({||cMoeda})
	If nMoeda == 1
		oSection11:Cell("N3_VRCMES1"):SetBlock({|| aValor[nMoeda, 1] })
		oSection11:Cell("N3_VRCMES1"):SetPicture(cPicture)
		
		oSection11:Cell("N3_VRDMES"):SetBlock({|| aValor[nMoeda, 2] })
		oSection11:Cell("N3_VRDMES"):SetPicture(cPicture)
		
		oSection11:Cell("N3_VRCDM1"):SetBlock({|| aValor[nMoeda, 3] })
		oSection11:Cell("N3_VRCDM1"):SetPicture(cPicture)
		
		oSection11:Cell("N3_VRCACM1"):SetBlock({|| aValor[nMoeda, 4] })
		oSection11:Cell("N3_VRCACM1"):SetPicture(cPicture)
		
		oSection11:Cell("N3_VRDACM"):SetBlock({|| aValor[nMoeda, 5] })
		oSection11:Cell("N3_VRDACM"):SetPicture(cPicture)
		
		oSection11:Cell("N3_VRCDA1"):SetBlock({|| aValor[nMoeda, 6] })
		oSection11:Cell("N3_VRCDA1"):SetPicture(cPicture)
		
		oSection11:Cell("DEPREC_CORREC"):SetBlock({|| aValor[nMoeda, 7] })
		oSection11:Cell("DEPREC_CORREC"):SetPicture(cPicture)
		
		oSection11:Cell("VLATUALIZADO"):SetBlock({|| aValor[nMoeda, 8] })
		oSection11:Cell("VLATUALIZADO"):SetPicture(cPicture)
		
		oSection11:Cell("VLLIQUIDO"):SetBlock({|| aValor[nMoeda, 9] })
		oSection11:Cell("VLLIQUIDO"):SetPicture(cPicture)
		
		oSection11:Cell("N3_AMPLIA"):SetBlock({|| aValor[nMoeda, 10] })
		oSection11:Cell("N3_AMPLIA"):SetPicture(cPicture)
	Else
		oSection11:Cell("N3_VRCMES1"):SetBlock({|| "" })
		oSection11:Cell("N3_VRCMES1"):SetPicture("")
		
		oSection11:Cell("N3_VRDMES"):SetBlock({|| aValor[nMoeda, 2] })
		oSection11:Cell("N3_VRDMES"):SetPicture(cPicture)
		
		oSection11:Cell("N3_VRCDM1"):SetBlock({|| "" })
		oSection11:Cell("N3_VRCDM1"):SetPicture("")
		
		oSection11:Cell("N3_VRCACM1"):SetBlock({|| "" })
		oSection11:Cell("N3_VRCACM1"):SetPicture("")
		
		oSection11:Cell("N3_VRDACM"):SetBlock({|| aValor[nMoeda, 5] })
		oSection11:Cell("N3_VRDACM"):SetPicture(cPicture)
		
		oSection11:Cell("N3_VRCDA1"):SetBlock({|| "" })
		oSection11:Cell("N3_VRCDA1"):SetPicture("")
		
		oSection11:Cell("DEPREC_CORREC"):SetBlock({|| "" })
		oSection11:Cell("DEPREC_CORREC"):SetPicture("")
		
		oSection11:Cell("VLATUALIZADO"):SetBlock({|| aValor[nMoeda, 8] })
		oSection11:Cell("VLATUALIZADO"):SetPicture(cPicture)
		
		oSection11:Cell("VLLIQUIDO"):SetBlock({|| aValor[nMoeda, 9] })
		oSection11:Cell("VLLIQUIDO"):SetPicture(cPicture)
		
		oSection11:Cell("N3_AMPLIA"):SetBlock({|| aValor[nMoeda, 10] })
		oSection11:Cell("N3_AMPLIA"):SetPicture(cPicture)
	EndIf
	oSection11:PrintLine()
EndIf

Return Nil
