/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR190.CH"
#Include "Protheus.ch"

#DEFINE H_SIM 1
#DEFINE H_TODOS  4

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³  DATA  ³ BOPS ³Program.³					ALTERACAO 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³12.08.98³xxxxxx³Alice   ³ Considerar as Filiais  bops 14645 A          ³±±
±±³02.03.99³xxxxxx³Alice   ³ Trazer os bens total/e depreciados no Mes e  ³±±
±±³        ³      ³        ³reposicionar as cols devido ao tamanho da Cta ³±±
±±³30.03.99³META  ³Julio   ³ Verificacao de Parametros de Tamanho do Rel. ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ATFR190()
Local oReport
Local nAreaAtual := Alias()

Private lMV_Par05 := .T. // Parâmetro existente desde a versão 11

DBSelectArea(nAreaAtual)

oReport:=ReportDef()
oReport:PrintDialog()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³09/06/2006³±±
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
Local oReport	:= Nil
Local oSection1	:= Nil
Local oSection2	:= Nil
Local oSecFil	:= Nil
Local cReport	:= "ATFR190"
Local cAlias1	:= "SN3"
Local cAlias2	:= "SN1"
Local cMoeda	:= GetMv("MV_ATFMOED")

Local cTitulo := OemToAnsi(STR0003) // "Lancamentos por Centro de Custo"
Local cDescri := OemToAnsi(STR0001)+" "+OemToAnsi(STR0002) // "Este programa ir  emitir a rela‡Æo de Lancamentos por Centro de Custo."

Pergunte( "ATR190" , .F. )
                   
oReport  := TReport():New( cReport, cTitulo, "ATR190" , { |oReport| ReportPrint( oReport, cAlias1, cAlias2 ) }, cDescri )

oReport:DisableOrientation()
oReport:SetUseGC(.F.)

oReport:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0008 + Subst(GetMv("MV_SIMB1"),1,5), {cAlias1,cAlias2} )		//"Valor em "
oSection1:lAutoSize := .F.
oSection1:SetLinesBefore(0)

TRCell():New( oSection1, "N3_CCUSTO"  , cAlias1 ,/*X3Titulo*/,/*Picture*/,Len(SN3->N3_CCUSTO) + 10/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de custo
TRCell():New( oSection1, "N3_CCONTAB" , cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Conta contabil
TRCell():New( oSection1, "SIMBMOEDA1" , 			 , STR0009    ,/*Picture*/,10 /*Tamanho*/,/*lPixel*/, {|| GetMV("MV_SIMB1") } )	//"Simbolo da Moeda"
TRCell():New( oSection1, "N3_VORIG1"  , cAlias1 ,/*X3Titulo*/,PesqPict("SN3","N3_VORIG1",18,1) /*Picture*/,18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor atual
TRCell():New( oSection1, "N3_VRDACM1" , cAlias1 ,/*X3Titulo*/,PesqPict("SN3","N3_VRDACM1",18,1) /*Picture*/,18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. Acumul
TRCell():New( oSection1, "N3_VRDMES1" , cAlias1 ,/*X3Titulo*/,PesqPict("SN3","N3_VRDMES1",18,1) /*Picture*/,18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. nos Mes
TRCell():New( oSection1, "N3_VRCDA1"  , cAlias1 ,/*X3Titulo*/,PesqPict("SN3","N3_VRCDA1",18,1) /*Picture*/,18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Correc. Depr. Acumul
TRCell():New( oSection1, "N3_VRCACM1" , cAlias1 ,/*X3Titulo*/,PesqPict("SN3","N3_VRCACM1",18,1) /*Picture*/,18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Correc. Monet. Acumulada

oSection1:SetHeaderPage()
/*
*/
oSection2 := TRSection():New( oReport, STR0008 + Subst(GetMv("MV_SIMB"+cMoeda),1,5), {cAlias1,cAlias2} )		//"Valor em "
oSection2:lAutoSize := .F.
oSection2:SetLinesBefore(0)

TRCell():New( oSection2, "ESPACO1"  ,  ,"",    /*Picture*/,Len(SN3->N3_CCUSTO) + 10/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection2, "ESPACO2"  ,  ,""     ,/*Picture*/,Len(SN3->N3_CCONTAB),/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection2, "SIMBMOEDA2"   		, 			 , STR0009 	  ,/*Picture*/,10 /*Tamanho*/,/*lPixel*/, {|| GetMv("MV_SIMB"+cMoeda) } )	//"Simbolo da Moeda"
TRCell():New( oSection2, "N3_VORIG"+cMoeda  , cAlias1 ,/*X3Titulo*/,PesqPict("SN3","N3_VORIG"+cMoeda,18,1) /*Picture*/,18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor atual
TRCell():New( oSection2, "N3_VRDACM"+cMoeda , cAlias1 ,/*X3Titulo*/,PesqPict("SN3","N3_VRDACM"+cMoeda,18,1) /*Picture*/,18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. Acumul
TRCell():New( oSection2, "N3_VRDMES"+cMoeda , cAlias1 ,/*X3Titulo*/,PesqPict("SN3","N3_VRDMES"+cMoeda,18,1) /*Picture*/,18 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. nos Mes

oSection2:SetHeaderSection(.F.)

/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SN3"})
oSecFil:SetAutoSize(.T.)
TRCell():New(oSecFil,"CODFIL" ,,STR0011,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0012,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0013,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Unidade de negócio"	
TRCell():New(oSecFil,"NOMEFIL",,STR0014,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Filial"
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Claudio D. de Souza º Data ³  05/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport, cAlias1, cAlias2 )
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSecFil	:= oReport:Section("SECFIL")

Local cQuery  := "SN3"
Local cAliasSn1 := "SN1"
Local cFiltro := ""
Local cChave  := ""
Local cWhere  := ""		
Local cAux    := ""		
Local cMoeda  := GetMv("MV_ATFMOED")
Local dUltDepr  := GetMv("MV_ULTDEPR")
/*-*/
Local aSelFil	:= {}
Local cTmpFil	:= ""
Local cFilSN3	:= ""
Local cFilSN1	:= ""
Local cTitulo 	:= ""
Local cFilAtu	:= ""
Local lSelFil	:= .F.
Local lCTTExFil	:= .F.
Local lCTTExUnN	:= .F.
Local lCTTExcl	:= .F.
Local aSM0		:= {}
Local nRegSM0	:= 0
Local nTamEmp	:= 0
Local nTamUnNeg	:= 0
Local nTamTit	:= 0
Local nX		:= 0
Local nLinha	:= 0
Local nLenSelFil:= 0
Local lTotFil	:= .F. 

// Acumuladores de Conta
LOCAL nCtaVlOri1:=nCtaDpAcm1:=nCtaDpMes1:=nCtaCrDep1:=nCtaCrMon1:= 0
LOCAL nCtaVlOri2:=nCtaDpAcm2:=nCtaDpMes2:=nCtaCrDep2:=nCtaCrMon2:= 0
LOCAL nCtaVlAmp1:=nCtaVlAmp2:=0

// Acumuladores de Centro de Custo
LOCAL nValOri1:=nDepAcm1:=nDepMes1:=nCorDep1:=nCorMon1:= 0
LOCAL nValOri2:=nDepAcm2:=nDepMes2:=nCorDep2:=nCorMon2:= 0
LOCAL nValAmp1:=nValAmp2:=0

// Acumuladores de filiais
LOCAL nFilOri1:=nFilDepA1:=nFilDepM1:=nFilCD1:=nFilCMon1:= 0
LOCAL nFilOri2:=nFilDepA2:=nFilDepM2:=nFilCD2:=nFilCMon2:= 0
LOCAL nFilAmp1:=nFilAmp2:=0

// Acumuladores Gerais
LOCAL nGerOri1:=nGerDepA1:=nGerDepM1:=nGerCD1:=nGerCMon1:= 0
LOCAL nGerOri2:=nGerDepA2:=nGerDepM2:=nGerCD2:=nGerCMon2:= 0
LOCAL nGerAmp1:=nGerAmp2:=0

LOCAL cCentroCus:=" ",cConta:=" " 

Local lAtfCusPrv := AFXAtCsPrv()

// Verificação da classificação de Ativo se sofre depreciação
Local lAtClDepr := .F.

Local aClassif := {}
Local cClassif := ""

If mv_par09 == 1
	aClassif := AdmGetClass()	
	If Len( aClassif ) <= 0
		Return
	EndIf 		
EndIf

	lSelFil := (FwSizeFilial() > 2)
	If lSelFil
		If MV_PAR11 == 1 
			If FindFunction("AdmSelecFil")
				AdmSelecFil("ATR190",11,.F.,@aSelFil,"SN3",.F.)
			Else
				aSelFil := AdmGetFil(.F.,.F.,"SN3")
			Endif
		Endif
		If Empty(aSelFil)
			Aadd(aSelFil,cFilAnt)
		Endif
		lCTTExcl := (FWModeAccess("CTT",1) == "E")
		cChave := SN3->(IndexKey(5))
		nX := At("N3_FILIAL",cChave)
		If lCTTExcl
			lCTTExFil := (FWModeAccess("CTT",3) == "E")
			lCTTExUnN := (FWModeAccess("CTT",2) == "E")
			nTamEmp := Len(AllTrim(xFilial("CTT")))
			If nX > 0
				cChave := "%" + SqlOrder("Substring(N3_FILIAL,1," + AllTrim(Str(nTamEmp)) + ")" + AllTrim(Substr(cChave,nX + 9))) + "%"
			Else
				cChave := "%" + SqlOrder("Substring(N3_FILIAL,1," + AllTrim(Str(nTamEmp)) + ")+" + AllTrim(cChave)) + "%"
			Endif
		Else
			If nX > 0
				cChave := "%" + SqlOrder(AllTrim(Substr(cChave,nX + 10))) + "%"
			Else
				cChave := "%" + SqlOrder(cChave) + "%"
			Endif
		Endif
	Else
		cChave := "%" + SqlOrder(SN3->(IndexKey(5))) + "%"
		lCTTExcl := .F.
		lCTTExFil := .F.
		lCTTExUnN := .F.
	Endif
	
	cQuery := GetNextAlias()
	cAliasSn1 := cQuery

	oSection1:BeginQuery()
			
	If lSelFil
		MsgRun(STR0016,STR0003,{|| cFilSN3 := GetRngFil(aSelFil,"SN3",.T.,@cTmpFil)}) //"Favor Aguardar..."###"Lancamentos por Centro de Custo"
		cFilSN3 := "%SN3.N3_FILIAL " + cFilSN3 + "%"
		cFilSN1 := "%SN1.N1_FILIAL = SN3.N3_FILIAL%"
	Else
		cFilSN1 := "%SN1.N1_FILIAL = '" + xFilial("SN1") + "'%"
		cFilSN3 := "%SN3.N3_FILIAL = '" + xFilial("SN3") + "'%"
	Endif

	if lMV_Par05 .and. MV_PAR05 == H_SIM
		cAux := cAux + "(N3_BAIXA < '1' Or "
		cAux := cAux + if( mv_par06 == H_TODOS,;
								"(N3_BAIXA >= '1' And ",;
								"(N3_BAIXA = '" + AllTrim(Str(mv_par06)) + "' And " )
		cAux := cAux + "N3_DTBAIXA >= '" + DTOS(mv_par07) + "' And "
		cAux := cAux + "N3_DTBAIXA <= '" + DTOS(mv_par08) + "')) "
	else	
		cAux := cAux + " N3_BAIXA < '1' " //Desconsidera Baixas
	endif
	
    If Len(aClassif) > 0
    	cAux +=  " And SN1.N1_PATRIM IN " + FormatClass(aClassif,.T.) + " "
    EndIf

	If lAtfCusPrv .And. MV_PAR10 == 2
		cAux += " AND SN3.N3_ATFCPR <> '1'  "
	EndIf 

	cWhere := "%"+ cAux + "%"

	BeginSql Alias cQuery
		SELECT
			N3_FILIAL,N3_CBASE, N3_ITEM, N3_TXDEPR1, N3_TIPO, N3_CCUSTO, N3_CCONTAB,
			N3_VORIG1, N3_VORIG2, N3_VORIG3, N3_VORIG4, N3_VORIG5,
			N3_VRCACM1, N3_VRDACM1, N3_VRDACM2, N3_VRDACM3, N3_VRDACM4, N3_VRDACM5,
			N3_VRCDA1, N3_AMPLIA1, N3_AMPLIA2, N3_AMPLIA3,
			N3_AMPLIA4,	N3_AMPLIA5, N3_VRDMES1, N3_VRDMES2, N3_VRDMES3, N3_VRDMES4, N3_VRDMES5, N1_DESCRIC, N1_PATRIM
		FROM 
			%table:SN3% SN3, %table:SN1% SN1
		WHERE
			%Exp:cFilSN3% AND
			SN3.N3_CCUSTO >= %Exp:mv_par01% AND 
			SN3.N3_CCUSTO <= %Exp:mv_par02% AND
			SN3.N3_CCONTAB >= %Exp:mv_par03% AND 
			SN3.N3_CCONTAB <= %Exp:mv_par04% AND
			(SN3.N3_CCUSTO <> ' ' OR SN3.N3_CDEPREC <> ' ' OR  SN3.N3_CDESP <> ' ' OR SN3.N3_CCDEPR <> ' ') AND
			%Exp:cWhere% AND
			SN3.%notDel% AND
			%Exp:cFilSN1% AND
			SN1.N1_CBASE = SN3.N3_CBASE AND
			SN1.N1_ITEM = SN3.N3_ITEM AND
			SN1.%notDel%
		ORDER BY %Exp:cChave%
	EndSql

	oSection1:EndQuery()

oSection1:Cell("SIMBMOEDA1"):SetTitle("")
oSection2:Cell("SIMBMOEDA2"):SetTitle("")

If lSelFil .And. Len(aSelFil) > 1
	If !((cQuery)->(Eof()))
		nRegSM0 := SM0->(Recno())
		aSM0 := FWLoadSM0()
		SM0->(DbGoTo(nRegSM0))
		oSecFil := oReport:Section("SECFIL")
		oSection1:SetHeaderSection(.F.)
		nTamEmp := Len(FWSM0LayOut(,1))
		nTamUnNeg := Len(FWSM0LayOut(,2))
		cTitulo := oReport:Title()
		oReport:SetTitle(cTitulo + " (" + STR0015 + ")")		//"Filiais selecionadas para o relatorio"
		nTamTit := Len(oReport:Title())
		oSecFil:Init()
		oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
		oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
		oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
		oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
		For nX := 1 To Len(aSelFil)
			nLinha := Ascan(aSM0,{|sm0| sm0[SM0_GRPEMP] == cEmpAnt .And. sm0[SM0_CODFIL] == aSelFil[nX]})
			If nLinha > 0
				cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
				oSecFil:PrintLine()
			Endif
		Next
		oReport:SetTitle(cTitulo)
		oSecFil:Finish()
		oSection1:SetHeaderSection(.T.)
		oReport:EndPage()
	Endif
Else
	lCTTExcl := .F.
Endif

oSection1:Init()
oSection2:Init()

cFilAtu := ""
nTamEmp := Len(AllTrim(xFilial("CTT")))
nLenSelFil := Len(aSelfil)
lTotFil := .F.
nX := 1 
While nx < nLenSelFil .And. !lTotFil
	nX++
	lTotFil := !(Substr(aSelFil[nx - 1],1,nTamEmp) == Substr(aSelFil[nX],1,nTamEmp))
Enddo

While (cQuery)->(!Eof()) .And. !oReport:Cancel()
        
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula por Centro de Custo  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCentroCus := (cQuery)->N3_CCUSTO
	If lCTTExcl
		If !(cFilAtu == Substr((cQuery)->N3_FILIAL,1,nTamEmp))
			cFilAtu := Substr((cQuery)->N3_FILIAL,1,nTamEmp)
			If lCTTExFil
				cTitulo := STR0014					//"Filial"
			Else
				cTitulo := STR0012					//"Empresa"
				If lCTTExUnN
					cTitulo += ("/" + STR0013)		//"Unidade de negócio"
				Endif
			Endif
			oReport:PrintText(cTitulo + ": " + cFilAtu)
			oReport:ThinLine()
		Endif
	Endif
	
	While (cQuery)->(!Eof()) .And.;
			(cQuery)->N3_CCUSTO == cCentroCus .And.;
			If(lCTTExcl,(Substr((cQuery)->N3_FILIAL,1,nTamEmp) == cFilAtu),.T.) .And. ;
			! oReport:Cancel() 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Acumula pela Conta Contabil do Bem ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cConta := N3_CCONTAB
		While (cQuery)->(!Eof()) .And.;
				(cQuery)->N3_CCUSTO == cCentroCus .And.;
				(cQuery)->N3_CCONTAB == cConta .And.;
				If(lCTTExcl,(Substr((cQuery)->N3_FILIAL,1,nTamEmp) == cFilAtu),.T.) .And. ;
				! oReport:Cancel()
                        // Verificação da classificação de Ativo se sofre depreciação
			lAtClDepr := Iif(FindFunction("AtClssVer"),AtClssVer((cAliasSn1)->N1_PATRIM),(cAliasSn1)->N1_PATRIM $ "NID")
                 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Conta em Moeda 1    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliasSn1)->N1_PATRIM $ " P"
				nCtaVlOri1+= (cQuery)->N3_VORIG1
				nCtaVlAmp1+= (cQuery)->N3_AMPLIA1
				nCtaDpAcm1+= (cQuery)->N3_VRDACM1 
				nCtaDpMes1+= (cQuery)->N3_VRDMES1 
				nCtaCrDep1+= (cQuery)->N3_VRCDA1  
				nCtaCrMon1+= (cQuery)->N3_VRCACM1 
			Else
				nCtaVlOri1-= (cQuery)->N3_VORIG1
				nCtaVlAmp1-= (cQuery)->N3_AMPLIA1
				nCtaDpAcm1-= (cQuery)->N3_VRDACM1 
				nCtaDpMes1-= (cQuery)->N3_VRDMES1 
				nCtaCrDep1-= (cQuery)->N3_VRCDA1  
				nCtaCrMon1-= (cQuery)->N3_VRCACM1 
			Endif
                 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Conta em Moeda do Ativo³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliasSn1)->N1_PATRIM $ " P"
				nCtaVlOri2+= (cQuery)->&("N3_VORIG"+cMoeda)
				nCtaVlAmp2+= (cQuery)->&("N3_AMPLIA"+cMoeda)
				nCtaDpAcm2+= (cQuery)->&("N3_VRDACM"+cMoeda)
				nCtaDpMes2+= (cQuery)->&("N3_VRDMES"+cMoeda)
				nCtaCrDep2+= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)  
				nCtaCrMon2+= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0) 
			Else
				nCtaVlOri2-= (cQuery)->&("N3_VORIG"+cMoeda)
				nCtaVlAmp2-= (cQuery)->&("N3_AMPLIA"+cMoeda)
				nCtaDpAcm2-= (cQuery)->&("N3_VRDACM"+cMoeda)
				nCtaDpMes2-= (cQuery)->&("N3_VRDMES"+cMoeda)
				nCtaCrDep2-= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)  
				nCtaCrMon2-= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0) 
			Endif
                 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Centro de Custo em Moeda 1 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliasSn1)->N1_PATRIM $ " P"
				nValOri1 += (cQuery)->N3_VORIG1
				nValAmp1 += (cQuery)->N3_AMPLIA1
				nDepAcm1 += (cQuery)->N3_VRDACM1
				nDepMes1 += (cQuery)->N3_VRDMES1
				nCorDep1 += (cQuery)->N3_VRCDA1 
				nCorMon1 += (cQuery)->N3_VRCACM1
			Else
				nValOri1 -= (cQuery)->N3_VORIG1
				nValAmp1 -= (cQuery)->N3_AMPLIA1
				nDepAcm1 -= (cQuery)->N3_VRDACM1
				nDepMes1 -= (cQuery)->N3_VRDMES1
				nCorDep1 -= (cQuery)->N3_VRCDA1 
				nCorMon1 -= (cQuery)->N3_VRCACM1
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Centro de Custo em Moeda do Ativo ³ 
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliasSn1)->N1_PATRIM $ " P"
				nValOri2 += (cQuery)->&("N3_VORIG"+cMoeda)
				nValAmp2 += (cQuery)->&("N3_AMPLIA"+cMoeda)
				nDepAcm2 += (cQuery)->&("N3_VRDACM"+cMoeda)
				nDepMes2 += (cQuery)->&("N3_VRDMES"+cMoeda)
				nCorDep2 += IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)
				nCorMon2 += IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0)
			Else
				nValOri2 -= (cQuery)->&("N3_VORIG"+cMoeda)
				nValAmp2 -= (cQuery)->&("N3_AMPLIA"+cMoeda)
				nDepAcm2 -= (cQuery)->&("N3_VRDACM"+cMoeda)
				nDepMes2 -= (cQuery)->&("N3_VRDMES"+cMoeda)
				nCorDep2 -= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)
				nCorMon2 -= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0)
			Endif
			dbSelectArea(cQuery)
			dbSkip()
		End
		
		oSection1:Cell("N3_CCUSTO"):SetBlock({|| cCentroCus } )
		oSection1:Cell("N3_CCONTAB"):SetBlock({|| cConta  } )
		
		oSection1:Cell("N3_VORIG1"):SetBlock({|| nCtaVlOri1+nCtaCrMon1+nCtaVlAmp1 } )
		oSection1:Cell("N3_VRDACM1"):SetBlock({|| nCtaDpAcm1 } )
		oSection1:Cell("N3_VRDMES1"):SetBlock({|| nCtaDpMes1 } )
		oSection1:Cell("N3_VRCDA1"):SetBlock({|| nCtaCrDep1 } )
		oSection1:Cell("N3_VRCACM1"):SetBlock({|| nCtaCrMon1 } )
		
		oSection2:Cell("N3_VORIG"+cMoeda):SetBlock( { || nCtaVlOri2+nCtaCrMon2+nCtaVlAmp2 } )
		oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nCtaDpAcm2 } )
		oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nCtaDpMes2 } )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ ImpressÆo dos dados em questÆo  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection1:PrintLine()
		If !(cMoeda == "1")
			oSection2:PrintLine()
		Endif
		
		dbSelectArea(cQuery)
		nCtaVlOri1:=nCtaDpAcm1:=nCtaDpMes1:=nCtaCrDep1:=nCtaCrMon1:= 0
		nCtaVlOri2:=nCtaDpAcm2:=nCtaDpMes2:=nCtaCrDep2:=nCtaCrMon2:= 0
		nCtaVlAmp1:=nCtaVlAmp2:=0
		
	End
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Mostra Total da Entidade Base ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nValOri1 != 0 .Or. nDepAcm1 != 0 .Or. nValOri2 != 0 .Or. nDepAcm2 != 0
	
		oSection1:Cell("N3_CCUSTO"):SetBlock({|| "Tot " + CtbSayApro("CTT")  } )
		oSection1:Cell("N3_CCONTAB"):SetBlock({|| cCentroCus } )
		
		oSection1:Cell("N3_VORIG1"):SetBlock({|| nValOri1+nCorMon1+nValAmp1 } )
		oSection1:Cell("N3_VRDACM1"):SetBlock({|| nDepAcm1 } )
		oSection1:Cell("N3_VRDMES1"):SetBlock({|| nDepMes1 } )
		oSection1:Cell("N3_VRCDA1"):SetBlock({|| nCorDep1 } )
		oSection1:Cell("N3_VRCACM1"):SetBlock({|| nCorMon1 } )
		
		oSection2:Cell("N3_VORIG"+cMoeda):SetBlock( { || nValOri2+nCorMon2+nValAmp2 } )
		oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nDepAcm2 } )
		oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nDepMes2 } )
		
		oReport:SkipLine()
		oSection1:PrintLine()
		If !(cMoeda == "1")
			oSection2:PrintLine()
		Endif
		oReport:SkipLine()
		oReport:SkipLine()
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula Total Geral em Moeda 1     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nGerOri1  += nValOri1+nValAmp1
	nGerDepA1 += nDepAcm1
	nGerDepM1 += nDepMes1
	nGerCD1   += nCorDep1
	nGerCMon1 += nCorMon1
      
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula Total Geral em Moeda do Ativo ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nGerOri2  += nValOri2
	nGerDepA2 += nDepAcm2
	nGerDepM2 += nDepMes2
	nGerCD2   += nCorDep2
	nGerCMon2 += nCorMon2
	
/*-*/	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula Total Filial em Moeda 1    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nFilOri1  += nValOri1+nValAmp1
	nFilDepA1 += nDepAcm1
	nFilDepM1 += nDepMes1
	nFilCD1   += nCorDep1
	nFilCMon1 += nCorMon1
      
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula Total Filial em Moeda do Ativo ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nFilOri2  += nValOri2
	nFilDepA2 += nDepAcm2
	nFilDepM2 += nDepMes2
	nFilCD2   += nCorDep2
	nFilCMon2 += nCorMon2
      
	nValOri1:=nDepAcm1:=nDepMes1:=nCorDep1:=nCorMon1:= 0
	nValOri2:=nDepAcm2:=nDepMes2:=nCorDep2:=nCorMon2:= 0
	nValAmp1:=nValAmp2:=0
	
End

oReport:SkipLine()
oReport:ThinLine()
oSection1:Cell("N3_CCUSTO"):SetBlock({|| STR0007  } ) 	//"TOTAL GERAL       : "
oSection1:Cell("N3_CCONTAB"):SetBlock({|| ""  } )

oSection1:Cell("N3_VORIG1"):SetBlock({|| nGerOri1+nGerCMon1+nGerAmp1 } )
oSection1:Cell("N3_VRDACM1"):SetBlock({|| nGerDepA1 } )
oSection1:Cell("N3_VRDMES1"):SetBlock({|| nGerDepM1 } )
oSection1:Cell("N3_VRCDA1"):SetBlock({|| nGerCD1 } )
oSection1:Cell("N3_VRCACM1"):SetBlock({|| nGerCMon1 } )

oSection2:Cell("N3_VORIG"+cMoeda):SetBlock( { || nGerOri2+nGerCMon2+nGerAmp2 } )
oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nGerDepA2 } )
oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nGerDepM2 } )

oSection1:PrintLine()
If !(cMoeda == "1")
	oSection2:PrintLine()
Endif

oReport:ThinLine()

oSection1:Finish()
oSection2:Finish()

If !Empty(cTmpFil)
	MsgRun(STR0016,STR0003,{|| CtbTmpErase(cTmpFil)}) //"Favor Aguardar..."###"Lancamentos por Centro de Custo"
Endif

Return Nil


