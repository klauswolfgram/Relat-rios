/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³  DATA  ³ BOPS ³Program.³					ALTERACAO 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³        ³      ³        ³                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
#INCLUDE "ATFR270.CH"
#Include "Protheus.ch"
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR270    ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 11.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Lancamentos por Item contabil                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR270()
Local oReport

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
Local oSecFil	:= Nil
Local cReport	:= "ATFR270"
Local cAlias1	:= "SN3"
Local cAlias2	:= "SN1"
Local cMoeda	:= GetMv("MV_ATFMOED")

Local cTitulo := OemToAnsi(STR0003) // "Lancamentos por Item Contabil"
Local cDescri := OemToAnsi(STR0001)+" "+OemToAnsi(STR0002) // "Este programa ir  emitir a rela‡Æo de Lancamentos por Item contabil."

Pergunte( "ATR270" , .F. )
                   
oReport  := TReport():New( cReport, cTitulo, "ATR270" , { |oReport| ReportPrint( oReport, cAlias1, cAlias2 ) }, cDescri )

oReport:DisableOrientation()
oReport:SetUseGC(.F.)

oReport:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0008 + Subst(GetMv("MV_SIMB" + AllTrim( Str( MV_PAR07 ) ) ),1,5), {cAlias1,cAlias2} )		//"Valor em "

TRCell():New( oSection1, "N3_SUBCTA"  , cAlias1 ,/*X3Titulo()*/,/*Picture*/,Len(SN3->N3_SUBCTA) + 6,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de custo
TRCell():New( oSection1, "N3_CCUSTO"  , cAlias1 ,/*X3Titulo()*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de custo
TRCell():New( oSection1, "N3_CCONTAB" , cAlias1 ,/*X3Titulo()*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Conta contabil
TRCell():New( oSection1, "SIMBMOEDA1" ,         , STR0009      ,/*Picture*/,10 /*Tamanho*/,/*lPixel*/, {|| GetMV("MV_SIMB"+ AllTrim( Str( MV_PAR07 ) )) } )	//"Simbolo da Moeda"
TRCell():New( oSection1, "N3_VORIG1"  , cAlias1 ,STR0010,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor atual
TRCell():New( oSection1, "N3_VRDACM1" , cAlias1 ,STR0011,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. Acumul
TRCell():New( oSection1, "N3_VRDMES1" , cAlias1 ,STR0012,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. nos Mes
TRCell():New( oSection1, "N3_VRCDA1"  , cAlias1 ,STR0013,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Correc. Depr. Acumul
TRCell():New( oSection1, "N3_VRCACM1" , cAlias1 ,STR0014,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Correc. Monet. Acumulada

oSection1:SetHeaderPage()	//Define o cabecalho da secao como padrao
oSection1:SetNoFilter({cAlias1,cAlias2})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 2a. secao do relatorio							   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New( oReport, STR0008 + Subst(GetMv("MV_SIMB"+cMoeda),1,5), {cAlias1,cAlias2} )	//"Valor em "
oSection2:SetLinesBefore(0)

TRCell():New( oSection2, "N3_SUBCTA"  			 , cAlias1 ,/*X3Titulo()*/,/*Picture*/,Len(SN3->N3_SUBCTA) + 6,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de custo
TRCell():New( oSection2, "N3_CCUSTO"  			 , cAlias1 ,/*X3Titulo()*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Centro de custo
TRCell():New( oSection2, "N3_CCONTAB" 			 , cAlias1 ,/*X3Titulo()*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Conta contabil
TRCell():New( oSection2, "SIMBMOEDA2" 			 ,  	     , STR0009		  ,/*Picture*/,10 /*Tamanho*/,/*lPixel*/, {|| GetMv("MV_SIMB"+cMoeda) } )	//"Simbolo da Moeda"
TRCell():New( oSection2, "N3_VORIG" + cMoeda , cAlias1 ,X3Titulo(),/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor atual
TRCell():New( oSection2, "N3_VRDACM"+ cMoeda , cAlias1 ,/*X3Titulo()*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. Acumul
TRCell():New( oSection2, "N3_VRDMES"+ cMoeda , cAlias1 ,/*X3Titulo()*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// Deprec. nos Mes

oSection2:Cell("N3_SUBCTA" ):Hide()
oSection2:Cell("N3_CCUSTO" ):Hide()
oSection2:Cell("N3_CCONTAB"):Hide()

oSection2:SetHeaderSection(.F.)	//Define o cabecalho da secao como padrao
oSection2:SetNoFilter({cAlias1,cAlias2})

/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SN3"})
oSecFil:SetAutoSize(.T.)
TRCell():New(oSecFil,"CODFIL" ,,STR0015,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0016,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0017,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Unidade de negócio"	
TRCell():New(oSecFil,"NOMEFIL",,STR0018,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Filial"

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
Local oSection1		:= oReport:Section(1)
Local oSection2		:= oReport:Section(2)
Local oSecFil		:= oReport:Section("SECFIL")
Local cQuery		:= "SN3"
Local cAliaSN1		:= "SN1"
Local cFiltro		:= ""
Local cChave		:= ""
Local cWhere		:= ""		
Local cMoeda   		:= GetMv("MV_ATFMOED")
Local dUltDepr 		:= GetMv("MV_ULTDEPR")
Local cEntidade		:= ""
Local cCentroCus	:= ""
Local cConta		:= ""
/*-*/
Local aSelFil		:= {}
Local cTmpFil		:= ""
Local cFilSN3		:= ""
Local cFilSN1		:= ""
Local cTitulo 		:= ""
Local cFilAtu		:= ""
Local lSelFil		:= .F.
Local lCTDExFil		:= .F.
Local lCTDExUnN		:= .F.
Local lCTDExcl		:= .F.
Local aSM0			:= {}
Local nRegSM0		:= 0
Local nTamEmp		:= 0
Local nTamUnNeg		:= 0
Local nTamTit		:= 0
Local nX			:= 0
Local nLinha		:= 0
Local nLenSelFil	:= 0
Local lTotFil		:= .F. 


// Acumuladores de Conta
Local nCtaVlOri1	:=nCtaDpAcm1:=nCtaDpMes1:=nCtaCrDep1:=nCtaCrMon1:= 0
Local nCtaVlOri2	:=nCtaDpAcm2:=nCtaDpMes2:=nCtaCrDep2:=nCtaCrMon2:= 0
// Acumuladores de Item
Local nValOri1		:=nDepAcm1:=nDepMes1:=nCorDep1:=nCorMon1:= 0
Local nValOri2		:=nDepAcm2:=nDepMes2:=nCorDep2:=nCorMon2:= 0
// Acumuladores Gerais
Local nGerOri1		:=nGerDepA1:=nGerDepM1:=nGerCD1:=nGerCMon1:= 0
Local nGerOri2		:=nGerDepA2:=nGerDepM2:=nGerCD2:=nGerCMon2:= 0
// Acumuladores de filiais
LOCAL nFilOri1		:=nFilDepA1:=nFilDepM1:=nFilCD1:=nFilCMon1:= 0
LOCAL nFilOri2		:=nFilDepA2:=nFilDepM2:=nFilCD2:=nFilCMon2:= 0

// Verificação da classificação de Ativo se sofre depreciação
Local lAtClDepr 	:= .F.   

Local aClassif := {}
Local cClassif := "" 

//Ativo Custo/Provisao
Local lAtfCusPrv := AFXAtCsPrv()


If mv_par08 == 1
	aClassif := AdmGetClass()
	If Len( aClassif ) <= 0
		Return
	EndIf 			
EndIf

lSelFil := (FwSizeFilial() > 2)
If lSelFil
	If MV_PAR10 == 1 
		If FindFunction("AdmSelecFil")
			AdmSelecFil("ATR270",10,.F.,@aSelFil,"SN3",.F.)
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SN3")
		Endif
	Endif
	If Empty(aSelFil)
		Aadd(aSelFil,cFilAnt)
	Endif
	lCTDExcl := (FWModeAccess("CTD",1) == "E")
	cChave := SN3->(IndexKey(6))
	nX := At("N3_FILIAL",cChave)
	If lCTDExcl
		lCTDExFil := (FWModeAccess("CTD",3) == "E")
		lCTDExUnN := (FWModeAccess("CTD",2) == "E")
		nTamEmp := Len(AllTrim(xFilial("CTD")))
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
	cChave 	:= "%"+SqlOrder(SN3->(IndexKey(6)))+"%"
	lCTDExcl := .F.
	lCTDTExFil := .F.
	lCTDExUnN := .F.
Endif

cQuery 	:= GetNextAlias()
cAliaSN1 := cQuery

oSection1:BeginQuery()
		
If lSelFil
	MsgRun(STR0020,STR0003,{|| cFilSN3 := GetRngFil(aSelFil,"SN3",.T.,@cTmpFil)}) //"Favor Aguardar..."###"Lancamentos por Centro de Custo"
	cFilSN3 := "%SN3.N3_FILIAL " + cFilSN3 + "%"
	cFilSN1 := "%SN1.N1_FILIAL = SN3.N3_FILIAL%"
Else
	cFilSN1 := "%SN1.N1_FILIAL = '" + xFilial("SN1") + "'%"
	cFilSN3 := "%SN3.N3_FILIAL = '" + xFilial("SN3") + "'%"
Endif

cWhere := "(SN3.N3_BAIXA < '1' OR (SN3.N3_BAIXA >= '1' AND SN3.N3_DTBAIXA LIKE '" + Left(Dtos(dUltDepr), 6) + "%'))"    


//Verifica se filtra as classificações patrimoniais	
If Len(aClassif) > 0
	cWhere += " And SN1.N1_PATRIM IN " + FormatClass(aClassif,.T.) + " "
EndIf

//NÃO mostra ativo Custo/Provisao
If lAtfCusPrv .and. mv_par09 == 2
	cWhere += " And SN3.N3_ATFCPR <> '1' "
Endif

cWhere := "%"+ cWhere + "%"

BeginSql Alias cQuery
	SELECT *
	FROM 
		%table:SN3% SN3, %table:SN1% SN1
	WHERE
		%Exp:cFilSN3% AND
		SN3.N3_SUBCTA >= %Exp:mv_par01% AND 
		SN3.N3_SUBCTA <= %Exp:mv_par02% AND
		SN3.N3_CCUSTO >= %Exp:mv_par03% AND 
		SN3.N3_CCUSTO <= %Exp:mv_par04% AND
		SN3.N3_CCONTAB >= %Exp:mv_par05% AND 
		SN3.N3_CCONTAB <= %Exp:mv_par06% AND
		(SN3.N3_SUBCTA <> ' ' AND SN3.N3_CDEPREC <> ' ' AND SN3.N3_CCDEPR <> ' ') AND
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
		oReport:SetTitle(cTitulo + " (" + STR0019 + ")")		//"Filiais selecionadas para o relatorio"
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
	lCTDExcl := .F.
Endif

oSection1:Init()
oSection2:Init()

cFilAtu := ""
nTamEmp := Len(AllTrim(xFilial("CTD")))
nLenSelFil := Len(aSelfil)
lTotFil := .F.
nX := 1 
While nx < nLenSelFil .And. !lTotFil
	nX++
	lTotFil := !(Substr(aSelFil[nx - 1],1,nTamEmp) == Substr(aSelFil[nX],1,nTamEmp))
Enddo

While (cQuery)->(!Eof()) .And. !oReport:Cancel()
        
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula por Item Contabil ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cEntidade := (cQuery)->N3_SUBCTA
	If lCTDExcl
		If !(cFilAtu == Substr((cQuery)->N3_FILIAL,1,nTamEmp))
			cFilAtu := Substr((cQuery)->N3_FILIAL,1,nTamEmp)
			If lCTDExFil
				cTitulo := STR0018					//"Filial"
			Else
				cTitulo := STR0016					//"Empresa"
				If lCTDExUnN
					cTitulo += ("/" + STR0017)		//"Unidade de negócio"
				Endif
			Endif
			oReport:PrintText(cTitulo + ": " + cFilAtu)
			oReport:ThinLine()
		Endif
	Endif
	
	While (cQuery)->(!Eof()) .And. (cQuery)->N3_SUBCTA == cEntidade .And. If(lCTDExcl,(Substr((cQuery)->N3_FILIAL,1,nTamEmp) == cFilAtu),.T.) .And. !oReport:Cancel() 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Acumula pela Conta Contabil do Bem ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cCentroCus  := (cQuery)->N3_CUSTBEM
		cConta 		:= (cQuery)->N3_CCONTAB

		While (cQuery)->(!Eof()) .And.;
				(cQuery)->(N3_SUBCTA)  == cEntidade .And.;
			   (cQuery)->(N3_CUSTBEM) == cCentroCus .And.;
				(cQuery)->(N3_CCONTAB) == cConta .And.;
				If(lCTDExcl,(Substr((cQuery)->N3_FILIAL,1,nTamEmp) == cFilAtu),.T.) .And. ;
				! oReport:Cancel()
            
            // Verificação da classificação de Ativo se sofre depreciação
			lAtClDepr := Iif(FindFunction("AtClssVer"),AtClssVer((cAliaSN1)->N1_PATRIM),(cAliaSN1)->N1_PATRIM $ "NID")
          
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Conta em Moeda 1    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliaSN1)->N1_PATRIM $ " P"
				nCtaVlOri1+= &((cQuery)->("N3_VORIG" + AllTrim( Str( MV_PAR07 ) ) ) )
				nCtaDpAcm1+= &((cQuery)->("N3_VRDACM" + AllTrim( Str( MV_PAR07 ) ) ) )
				nCtaDpMes1+= &((cQuery)->("N3_VRDMES" + AllTrim( Str( MV_PAR07 ) ) ) )
				nCtaCrDep1+= (cQuery)->N3_VRCDA1  
				nCtaCrMon1+= (cQuery)->N3_VRCACM1 
			Else
				nCtaVlOri1-= &((cQuery)->("N3_VORIG" + AllTrim( Str( MV_PAR07 ) ) ) )
				nCtaDpAcm1-= &((cQuery)->("N3_VRDACM" + AllTrim( Str( MV_PAR07 ) ) ) )
				nCtaDpMes1-= &((cQuery)->("N3_VRDMES" + AllTrim( Str( MV_PAR07 ) ) ) )
				nCtaCrDep1-= (cQuery)->N3_VRCDA1  
				nCtaCrMon1-= (cQuery)->N3_VRCACM1 
			Endif
                 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Conta em Moeda do Ativo³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliaSN1)->N1_PATRIM $ " P"
				nCtaVlOri2+= &((cQuery)+"->N3_VORIG"+cMoeda)
				nCtaDpAcm2+= &((cQuery)+"->N3_VRDACM"+cMoeda)
				nCtaDpMes2+= &((cQuery)+"->N3_VRDMES"+cMoeda)
				nCtaCrDep2+= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)  
				nCtaCrMon2+= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0) 
			Else
				nCtaVlOri2-= &((cQuery)+"->N3_VORIG"+cMoeda)
				nCtaDpAcm2-= &((cQuery)+"->N3_VRDACM"+cMoeda)
				nCtaDpMes2-= &((cQuery)+"->N3_VRDMES"+cMoeda)
				nCtaCrDep2-= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)  
				nCtaCrMon2-= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0) 
			Endif
                 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Centro de Custo em Moeda 1 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliaSN1)->N1_PATRIM $ " P"
				nValOri1+= &((cQuery)->("N3_VORIG" + AllTrim( Str( MV_PAR07 ) ) ) )
				nDepAcm1+= &((cQuery)->("N3_VRDACM" + AllTrim( Str( MV_PAR07 ) ) ) )
				nDepMes1+= &((cQuery)->("N3_VRDMES" + AllTrim( Str( MV_PAR07 ) ) ) )
				nCorDep1 += (cQuery)->N3_VRCDA1 
				nCorMon1 += (cQuery)->N3_VRCACM1
			Else
				nValOri1-= &((cQuery)->("N3_VORIG" + AllTrim( Str( MV_PAR07 ) ) ) )
				nDepAcm1-= &((cQuery)->("N3_VRDACM" + AllTrim( Str( MV_PAR07 ) ) ) )
				nDepMes1-= &((cQuery)->("N3_VRDMES" + AllTrim( Str( MV_PAR07 ) ) ) )
				nCorDep1 -= (cQuery)->N3_VRCDA1 
				nCorMon1 -= (cQuery)->N3_VRCACM1
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Acumula Centro de Custo em Moeda do Ativo ³ 
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lAtClDepr .OR. (cAliaSN1)->N1_PATRIM $ " P"
				nValOri2 += &((cQuery)+"->N3_VORIG"+cMoeda)
				nDepAcm2 += &((cQuery)+"->N3_VRDACM"+cMoeda)
				nDepMes2 += &((cQuery)+"->N3_VRDMES"+cMoeda)
				nCorDep2 += IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)
				nCorMon2 += IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0)
			Else
				nValOri2 -= &((cQuery)+"->N3_VORIG"+cMoeda)
				nDepAcm2 -= &((cQuery)+"->N3_VRDACM"+cMoeda)
				nDepMes2 -= &((cQuery)+"->N3_VRDMES"+cMoeda)
				nCorDep2 -= IIf(cMoeda=="1",(cQuery)->N3_VRCDA1,0)
				nCorMon2 -= IIf(cMoeda=="1",(cQuery)->N3_VRCACM1,0)
			Endif
			dbSelectArea(cQuery)
			dbSkip()
		EndDo

		oSection1:Cell("N3_SUBCTA" ):SetBlock({|| cEntidade  } )
		oSection1:Cell("N3_CCUSTO" ):SetBlock({|| cCentroCus } )
		oSection1:Cell("N3_CCONTAB"):SetBlock({|| cConta     } )
		
		oSection1:Cell("N3_VORIG1" ):SetBlock({|| nCtaVlOri1 } )
		oSection1:Cell("N3_VRDACM1"):SetBlock({|| nCtaDpAcm1 } )
		oSection1:Cell("N3_VRDMES1"):SetBlock({|| nCtaDpMes1 } )
		oSection1:Cell("N3_VRCDA1" ):SetBlock({|| nCtaCrDep1 } )
		oSection1:Cell("N3_VRCACM1"):SetBlock({|| nCtaCrMon1 } )
		
		oSection2:Cell("N3_VORIG" +cMoeda):SetBlock( { || nCtaVlOri2 } )
		oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nCtaDpAcm2 } )
		oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nCtaDpMes2 } )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ ImpressÆo dos dados em questÆo  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection1:PrintLine()
		oSection2:PrintLine()
		
		dbSelectArea(cQuery)
		nCtaVlOri1:=nCtaDpAcm1:=nCtaDpMes1:=nCtaCrDep1:=nCtaCrMon1:= 0
		nCtaVlOri2:=nCtaDpAcm2:=nCtaDpMes2:=nCtaCrDep2:=nCtaCrMon2:= 0
	EndDo
  
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Mostra Total da Entidade Base ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nValOri1 != 0 .Or. nDepAcm1 != 0 .Or. nValOri2 != 0 .Or. nDepAcm2 != 0

		oSection1:Cell("N3_SUBCTA" ):SetBlock({|| STR0006 } )	//"Tot I.Contabil: "
		oSection1:Cell("N3_CCUSTO" ):SetBlock({|| cEntidade  } )
		oSection1:Cell("N3_CCONTAB"):SetBlock({|| ""  } )
		
		oSection1:Cell("N3_VORIG1" ):SetBlock({|| nValOri1 } )
		oSection1:Cell("N3_VRDACM1"):SetBlock({|| nDepAcm1 } )
		oSection1:Cell("N3_VRDMES1"):SetBlock({|| nDepMes1 } )
		oSection1:Cell("N3_VRCDA1" ):SetBlock({|| nCorDep1 } )
		oSection1:Cell("N3_VRCACM1"):SetBlock({|| nCorMon1 } )
		
		oSection2:Cell("N3_VORIG" +cMoeda):SetBlock( { || nValOri2 } )
		oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nDepAcm2 } )
		oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nDepMes2 } )
		
		oReport:SkipLine()
		oSection1:PrintLine()
		oSection2:PrintLine()
		oReport:SkipLine(2)

	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula Total Geral em Moeda 1     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nGerOri1  += nValOri1
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
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula Total Filial em Moeda 1    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nFilOri1  += nValOri1
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
	
	If lCTDExcl
		If lTotFil
			If !(Substr((cQuery)->N3_FILIAL,1,nTamEmp) == cFilAtu)
				oReport:ThinLine()
				oSection1:Cell("N3_SUBCTA" ):SetBlock({|| ""})
				oSection1:Cell("N3_CCUSTO"):SetBlock({|| ""})
				oSection1:Cell("N3_CCONTAB"):SetBlock({|| ""})

				oSection1:Cell("N3_VORIG1"):SetBlock({|| nFilOri1})
				oSection1:Cell("N3_VRDACM1"):SetBlock({|| nFilDepA1})
				oSection1:Cell("N3_VRDMES1"):SetBlock({|| nFilDepM1})
				oSection1:Cell("N3_VRCDA1"):SetBlock({|| nFilCD1})
				oSection1:Cell("N3_VRCACM1"):SetBlock({|| nFilCMon1})

				oSection2:Cell("N3_VORIG"+cMoeda):SetBlock({|| nFilOri2})
				oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock({|| nFilDepA2})
				oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock({|| nFilDepM2})

				oSection1:PrintLine()
				If !(cMoeda == "1")
					oSection2:PrintLine()
				Endif
				oReport:SkipLine(2)

				nFilOri1 := nFilDepA1 := nFilDepM1 := nFilCD1 := nFilCMon1 := nFilOri2 := 0 
				nFilDepA2 := nFilDepM2 := nFilCD2 := nFilCMon2 := nFilAmp1 := nFilAmp2 := 0			
			Endif
		Endif
	Endif
	
EndDo    

oReport:SkipLine()
oReport:ThinLine()

oSection1:Cell("N3_SUBCTA" ):SetBlock({|| STR0007  } )		//"TOTAL GERAL       : "
oSection1:Cell("N3_CCUSTO" ):SetBlock({|| ""  } )
oSection1:Cell("N3_CCONTAB"):SetBlock({|| ""  } )

oSection1:Cell("N3_VORIG1" ):SetBlock({|| nGerOri1  } )
oSection1:Cell("N3_VRDACM1"):SetBlock({|| nGerDepA1 } )
oSection1:Cell("N3_VRDMES1"):SetBlock({|| nGerDepM1 } )
oSection1:Cell("N3_VRCDA1" ):SetBlock({|| nGerCD1   } )
oSection1:Cell("N3_VRCACM1"):SetBlock({|| nGerCMon1 } )

oSection2:Cell("N3_VORIG" +cMoeda):SetBlock( { || nGerOri2  } )
oSection2:Cell("N3_VRDACM"+cMoeda):SetBlock( { || nGerDepA2 } )
oSection2:Cell("N3_VRDMES"+cMoeda):SetBlock( { || nGerDepM2 } )

oSection1:PrintLine()
oSection2:PrintLine()

oReport:ThinLine()

oSection1:Finish()
oSection2:Finish()

If !Empty(cTmpFil)
	MsgRun(STR0020,STR0003,{|| CtbTmpErase(cTmpFil)}) //"Favor Aguardar..."###"Lancamentos por Centro de Custo"
Endif


Return Nil