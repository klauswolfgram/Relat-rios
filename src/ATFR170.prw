/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR170.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE CRLF CHR(13)+CHR(10)

Static _oATFR1701
Static _oATFR1702

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ATFR170  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 06.09.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo da Corre‡„o Monetaria					                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_ATFR170(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR170()
Local oReport

oReport := ReportDef()

oReport:PrintDialog()

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 06.09.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport		:= Nil
Local oSection1		:= Nil
Local nTamDesc		:= 0
Local nTamVal		:= 0
Local nMoeda		:= 0
Local lCtb			:= CtbInUse()
Local cMoeda		:= ""
Local cPict			:= ""
Local cPictSal		:= ""
Local cDescMoedA	:= ""
Local cDescMoed1	:= ""

oReport := TReport():New("ATFR170",STR0003,"AFR170",{|oReport| ReportPrint(oReport)},STR0001+STR0002)

oReport:SetUseGC(.F.)

pergunte("AFR170",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01            // Data Conta                        ³
//³ mv_par02            // Ate a Conta                       ³
//³ mv_par03            // Separa conta de depreciacao       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:SetPortrait(.T.)

cMoeda := GETMV("MV_ATFMOED") // Localiza a moeda do ativo
nMoeda := Val(cMoeda)
cPictSal	:= PesqPict("SN5","N5_VALOR"+cMoeda,18,nMoeda)

cDescMoedA:= Alltrim(Subs(GetMV("MV_MOEDA"+Alltrim(cMoeda)),1,6))
cDescMoed1  := Alltrim(Subs(GetMV("MV_MOEDA1"),1,6))

cDescMoedA:=Iif(Len(cDescMoedA)< 6,cDescMoedA+space(6 - Len(cDescMoedA)),cDescMoedA)
cDescMoed1:=Iif(Len(cDescMoed1)< 6,cDescMoed1+space(6 - Len(cDescMoed1)),cDescMoed1)

nTamDesc := If( lCtb, TamSX3("CT1_DESC01")[1], TamSX3("I1_DESC")[1] )
nTamVal	:= TamSX3("N3_VORIG1")[1]
cPict		:= PesqPict("SN3","N3_VORIG1")

oSection1 := TRSection():New(oReport,SubStr(STR0004,1,At(" ",STR0004)-1),{"cNomeArq","SN3"})
oSection1:SetAutoSize(.T.)
TRCell():New(oSection1,"N3_CCONTAB","SN3",STR0013+CRLF+STR0014,,,.F.,{|| cNomeArq->CONTA }) //"Contas sujeitas""a correcao"
TRCell():New(oSection1,"DESCRICAO",,STR0015,,nTamDesc,.F.,{|| cNomeArq->DESCRIC }) //"Descrição"
TRCell():New(oSection1,"SALDO",,STR0016+" "+cDescMoedA+CRLF+STR0017,cPictSal,18,.F.,{|| cNomeArq->SALDO },,,"RIGHT")  //"Saldo em Ufir""no Razão Auxiliar"
TRCell():New(oSection1,"SALD1",,STR0018+" "+cDescMoed1+CRLF+STR0019,cPict,nTamVal,.F.,{|| cNomeArq->SALD1 },,,"RIGHT")  //"Valores em Reais""corrigidos"
TRCell():New(oSection1,"DEVED",,STR0020+CRLF+STR0021,cPict,nTamVal,.F.,{|| cNomeArq->DEVED },,,"RIGHT")  //"Saldo da Correção""Acumulada Devedor"
TRCell():New(oSection1,"CREDO",,STR0020+CRLF+STR0022,cPict,nTamVal,.F.,{|| cNomeArq->CREDO },,,"RIGHT")  //"Saldo da Correção""Acumulada Credor"
TRCell():New(oSection1,"AMPLIA1",,STR0023+CRLF+STR0024,cPict,nTamVal,.F.,{|| cNomeArq->AMPLIA1 },,,"RIGHT")  //"Valor da""Ampliação"

Return oReport                                                                              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³10.07.06	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)
Local oSection1		:= oReport:Section(1)
Local cWhere 		:= ""
Local cOrdem 		:= ""
Local cAliasQry 	:= GetNextAlias()
Local oTotal		:= Nil
Local oImpDeve		:= Nil
Local oImpCred		:= Nil
Local cIndex		:= ""
Local cChave		:= ""
LOCAL dUltProc		:= Ctod("//") 
LOCAL dDataProx		:= Ctod("//") 
LOCAL nUfir			:= 0
LOCAL aCampos  		:={}
Local aTam			:={}
Local lCtb 			:= CtbInUse()
Local cMoeda		:= ""
Local cFilterUser	:= ""
Local aSelFil		:= {}
Local aSM0			:= {}
Local cTmpFil		:= ""
Local cFilSN3		:= ""
Local cFilSM0		:= ""
Local nRegSM0		:= 0
Local nPos			:= 0
Local nLenFil		:= 0
Local nTtlExer		:= 0
Local lSelFil		:= .F.

// Verificação da classificação de Ativo se sofre depreciação
Local lAtClDepr 	:= .F.

nRegSM0 := SM0->(Recno())

	aSM0 := FWLoadSM0()
	lSelFil := (FwSizeFilial() > 2)
	If lSelFil
		If MV_PAR04 == 1 
				AdmSelecFil("AFR170",04,.F.,@aSelFil,"SN3",.F.)
		Endif
		If Empty(aSelFil)
			Aadd(aSelFil,cFilAnt)
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Analiza contas de/ate'       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If	!Empty( mv_par01 ) // Data Conta
		cWhere += " AND N3_CCONTAB > '" + mv_par01 + "'"
		
		If mv_par03 == 1 // Separa conta de depreciacao? SIM/NAO
			cWhere += " AND N3_CCDEPR > '" + mv_par01 + "'"
		EndIf
	Endif

	If	!Empty( mv_par02 ) // Ate a Conta
		cWhere += " AND N3_CCONTAB < '" + mv_par02 + "'"
		
		If mv_par03 == 1 // Separa conta de depreciacao? SIM/NAO
			cWhere += " AND N3_CCDEPR < '" + mv_par02 + "'"
		EndIf
	Endif
	cFilterUser := oSection1:GetSqlExp("SN3")
	
	If !Empty(cFilterUser)
		cWhere := cWhere + " AND " + cFilterUser
	Endif	

	cOrdem := " ORDER BY " + SqlOrder( SN3->(IndexKey(1)) )
	
	cWhere := "% " + cWhere + cOrdem + " %"		
	
	If lSelFil
		MsgRun(STR0026,STR0003,{|| cFilSN3 := GetRngFil(aSelFil,"SN3",.T.,@cTmpFil)}) //"Favor Aguardar..."###""Resultado da Correcao Monetaria"
		cFilSN3 := "%N3_FILIAL " + cFilSN3 + "%"
	Else
		cFilSN3 := "%N3_FILIAL = '" + xFilial("SN3") + "'%"
	Endif

	BeginSql Alias cAliasQry
		SELECT N3_FILIAL,N3_CBASE, N3_ITEM, N3_CCONTAB, N3_AMPLIA1, N3_VRCACM1, N3_CCDEPR,
				N3_VORIG1, N3_VORIG2, N3_VORIG3, N3_VORIG4, N3_VORIG5,
				N3_VRDACM1, N3_VRDACM2, N3_VRDACM3, N3_VRDACM4, N3_VRDACM5,
				N3_AMPLIA1, N3_AMPLIA2, N3_AMPLIA3, N3_AMPLIA4, N3_AMPLIA5,
				N3_VRCDA1
		FROM %table:SN3% SN3
		WHERE %Exp:cFilSN3%
				AND SN3.N3_BAIXA = '0'
				AND SN3.%NotDel%
				%Exp:cWhere% 
	EndSQL

cMoeda := GETMV("MV_ATFMOED") // Localiza a moeda do ativo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza a Ufir do mes seguinte                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dUltProc 	:= GetMV("MV_ULTDEPR")			// Localiza a data do ultimo calculo
dDataProx 	:= LastDay( dUltProc ) + 1   
SM2->( dbSeek( dDataProx, .T. ) )
nUfir 		:= &('SM2->M2_MOEDA'+cMoeda)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo de Trabalho      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aCampos,{"FILIAL","C",FWSizeFilial(),0})
aTam := TamSX3("N5_CONTA")
AADD(aCampos,{"CONTA"	,"C"	,aTam[1],aTam[2]	} )
aTam := If(lCtb, TamSX3("CT1_DESC01"), TamSX3("I1_DESC") )
AADD(aCampos,{"DESCRIC"	,"C"	,aTam[1],aTam[2]	} )
AADD(aCampos,{"SALDO"	,"N"  ,16   ,4 } )
AADD(aCampos,{"SALD1"	,"N"  ,16   ,4 } )
AADD(aCampos,{"DEVED"	,"N"  ,16   ,4 } )
AADD(aCampos,{"CREDO"	,"N"  ,16   ,4 } )
AADD(aCampos,{"AMPLIA1"	,"N"  ,16   ,4 } )
AADD(aCampos,{"REGSM0"	,"N"  ,10   ,0 } )

If _oATFR1701 <> Nil
	_oATFR1701:Delete()
	_oATFR1701 := Nil
Endif

_oATFR1701 := FWTemporaryTable():New( "cNomeArq" )  
_oATFR1701:SetFields(aCampos) 
_oATFR1701:AddIndex("1", {"FILIAL","CONTA"})

//------------------
//Criação da tabela temporaria
//------------------
_oATFR1701:Create()  

If !lSelFil
	oDesc	:= TRFunction():New(oSection1:Cell("DESCRICAO"),,"ONPRINT",,"",,{|| STR0009 },.T.,.F.,.F.) // "E X E R C I C I O"
	oTotal	:= TRFunction():New(oSection1:Cell("DEVED"),,"SUM",,"",,{|| cNomeArq->DEVED - cNomeArq->CREDO },.T.,.F.,.F.)
	oImpDeve:= TRFunction():New(oSection1:Cell("DEVED"),,"ONPRINT",,"",,{|| If(oTotal:GetValue()>0	,oTotal:GetValue()		,) },.T.,.F.,.F.)
	oImpCred:= TRFunction():New(oSection1:Cell("CREDO"),,"ONPRINT",,"",,{|| If(oTotal:GetValue()<=0	,Abs(oTotal:GetValue())	,) },.T.,.F.,.F.)
	
	oTotal:Disable()

	oSection1:SetTotalText({||""})

	oSection1:SetTotalInLine(.F.)
Endif	

oReport:NoUserFilter()
oReport:SetMeter((cAliasQry)->(Reccount()))

While (cAliasQry)->(!Eof())

	oReport:IncMeter()
		
	dbSelectArea("SN1")
	dbSetOrder(1)
	dbSeek(xFilial("SN1",(cAliasQry)->N3_FILIAL) + (cAliasQry)->N3_CBASE + (cAliasQry)->N3_ITEM)

	If lCtb
		dbSelectArea("CT1")
		dbSetOrder(1)
		dbSeek( xFilial("CT1",(cAliasQry)->N3_FILIAL) + (cAliasQry)->N3_CCONTAB )
	Else
		dbSelectArea("SI1")
		dbSetOrder(1)
		dbSeek( xFilial("SI1",(cAliasQry)->N3_FILIAL) + (cAliasQry)->N3_CCONTAB )
	Endif

	If	!cNomeArq->(dbSeek((cAliasQry)->N3_FILIAL + (cAliasQry)->N3_CCONTAB ) )
		RecLock( "cNomeArq" , .T. )
		cNomeArq->FILIAL := (cAliasQry)->N3_FILIAL	
		cNomeArq->CONTA := (cAliasQry)->N3_CCONTAB
		
		cFilSM0 := AllTrim((cAliasQry)->N3_FILIAL)
		nLenFil := Len(cFilSM0)
		If Empty(cFilSM0)
			nPos := Ascan(aSM0,{|sm0| sm0[SM0_GRPEMP] == cEmpAnt })
			cNomeArq->REGSM0 := aSM0[nPos,SM0_RECNO]
		Else
			nPos := Ascan(aSM0,{|sm0| sm0[SM0_GRPEMP] == cEmpAnt .And. Substr(sm0[SM0_CODFIL],1,nLenFil) == cFilSM0})
			cNomeArq->REGSM0 := aSM0[nPos,SM0_RECNO]
		EndIf		
		If lCtb
			cNomeArq->DESCRIC := CT1->CT1_DESC01
		Else
			cNomeArq->DESCRIC := SI1->I1_DESC
		Endif
	Else
		RecLock( "cNomeArq" )
	Endif
    
	// Verificação da classificação de Ativo se sofre depreciação
	lAtClDepr := AtClssVer(SN1->N1_PATRIM)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Saldo e':Valor original+Corre‡„o do Acumul-Deprec.Acumulada        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAtClDepr .OR. SN1->N1_PATRIM $ " P"
		cNomeArq->SALDO  += ( (cAliasQry)->&("(N3_VORIG"+cMoeda+"+N3_AMPLIA"+cMoeda+")") )  // Valor Original em Ufir
		cNomeArq->SALD1  += ( (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_AMPLIA1 + (cAliasQry)->N3_VRCACM1 )  // Valor Original em Moeda corrente
		cNomeArq->AMPLIA1+= (cAliasQry)->N3_AMPLIA1
	Else
		cNomeArq->SALDO  -= ( (cAliasQry)->&("(N3_VORIG"+cMoeda+"+N3_AMPLIA"+cMoeda+")") )  // Valor Original em Ufir
		cNomeArq->SALD1  -= ( (cAliasQry)->N3_VORIG1 + (cAliasQry)->N3_VRCACM1 )  // Valor Original em Moeda corrente	
		cNomeArq->AMPLIA1-= (cAliasQry)->N3_AMPLIA1
	Endif
      
	If lCtb
		If CT1->CT1_NORMAL == "1"
			cNomeArq->DEVED += ( (cAliasQry)->N3_VRCACM1 )  // VrcAcm1: Corre‡„o Acumulada Moeda
			Iif(mv_par03 = 2,cNomeArq->CREDO += ( (cAliasQry)->N3_VRCDA1  ),;
			                 cNomeArq->CREDO += 0 )      // Vrcda1: Corr.Depr.Acum
		Else
			cNomeArq->CREDO += ( (cAliasQry)->N3_VRCACM1 )  // VrcAcm1: Corre‡„o Acumulada Moeda
			Iif(mv_par03 = 2,cNomeArq->DEVED += ( (cAliasQry)->N3_VRCDA1  ),;
			                 cNomeArq->DEVED += 0)       // Vrcda1: Corr.Depr.Acum
		Endif
	Else
		If SI1->I1_NORMAL == "D"
			cNomeArq->DEVED += ( (cAliasQry)->N3_VRCACM1 )  // VrcAcm1: Corre‡„o Acumulada Moeda
			Iif(mv_par03 = 2,cNomeArq->CREDO += ( (cAliasQry)->N3_VRCDA1  ),;
			                 cNomeArq->CREDO += 0 )      // Vrcda1: Corr.Depr.Acum
		Else
			cNomeArq->CREDO += ( (cAliasQry)->N3_VRCACM1 )  // VrcAcm1: Corre‡„o Acumulada Moeda
			Iif(mv_par03 = 2,cNomeArq->DEVED += ( (cAliasQry)->N3_VRCDA1  ),;
			                 cNomeArq->DEVED += 0)       // Vrcda1: Corr.Depr.Acum
		Endif
	EndIf       

	If mv_par03 == 1 // Separa conta de depreciacao? SIM/NAO

		If !Empty((cAliasQry)->N3_CCDEPR)   //Verifico se a conta de deprec acum	
			If lCtb
				dbSelectArea("CT1")
				dbSetOrder(1)
				dbSeek( xFilial("CT1",(cAliasQry)->N3_FILIAL) + (cAliasQry)->N3_CCDEPR )
			Else
				dbSelectArea("SI1")
				dbSetOrder(1)
				dbSeek( xFilial("SI1",(cAliasQry)->N3_FILIAL) + (cAliasQry)->N3_CCDEPR )
			Endif
			dbSelectArea( "cNomeArq" )
			If	!cNomeArq->(dbSeek((cAliasQry)->N3_FILIAL +  (cAliasQry)->N3_CCDEPR ) )
				RecLock( "cNomeArq" , .T. )
				cNomeArq->FILIAL := (cAliasQry)->N3_FILIAL
				cNomeArq->CONTA := (cAliasQry)->N3_CCDEPR
		
				cFilSM0 := AllTrim((cAliasQry)->N3_FILIAL)
				nLenFil := Len(cFilSM0)
				nPos := Ascan(aSM0,{|sm0| sm0[SM0_GRPEMP] == cEmpAnt .And. Substr(sm0[SM0_CODFIL],1,nLenFil) == cFilSM0})
				cNomeArq->REGSM0 := aSM0[nPos,SM0_RECNO]
				
				If lCtb
					cNomeArq->DESCRIC := CT1->CT1_DESC01
				Else
					cNomeArq->DESCRIC := SI1->I1_DESC
				Endif
			Else
				RecLock( "cNomeArq" )
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Saldo e':Valor original+Corre‡„o do Acumul-Deprec.Acumulada        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cNomeArq->SALDO += ( (cAliasQry)->&('N3_VRDACM'+cMoeda) )  // Valor Original em Ufir
			cNomeArq->SALD1 += ( (cAliasQry)->N3_VRDACM1 + (cAliasQry)->N3_VRCDA1 )  // Valor Original em Moeda corrente
			If lCtb
				If CT1->CT1_NORMAL == "1"
					cNomeArq->CREDO += ( (cAliasQry)->N3_VRCDA1  )  // Vrcda1: Corr.Depr.Acum
				Else
					cNomeArq->DEVED += ( (cAliasQry)->N3_VRCDA1  )  // Vrcda1: Corr.Depr.Acum
				Endif
			Else
				If SI1->I1_NORMAL == "D"
					cNomeArq->CREDO += ( (cAliasQry)->N3_VRCDA1  )  // Vrcda1: Corr.Depr.Acum
				Else
					cNomeArq->DEVED += ( (cAliasQry)->N3_VRCDA1  )  // Vrcda1: Corr.Depr.Acum
				Endif
			Endif
		Endif
	Endif
	(cAliasQry)->(dbSkip())
End

If lSelFil
	cNomeArq->(DbGoTop())
	oSection1:Init()
	While !(cNomeArq->(Eof()))
		cFilSM0 := cNomeArq->FILIAL
		nTtlExer := 0
		SM0->(DbGoto(cNomeArq->REGSM0))
		While !(cNomeArq->(Eof())) .And. cNomeArq->FILIAL == cFilSM0 
			oSection1:PrintLine()
			nTtlExer += (cNomeArq->DEVED - cNomeArq->CREDO) 
			cNomeArq->(DbSkip())
		Enddo
		oSection1:Cell("N3_CCONTAB"):Hide()
		oSection1:Cell("DESCRICAO"):SetBlock({|| STR0009}) //// "E X E R C I C I O"
		oSection1:Cell("SALDO"):Hide()
		oSection1:Cell("SALD1"):Hide()
		oSection1:Cell("AMPLIA1"):Hide()
		If nTtlExer > 0
			oSection1:Cell("DEVED"):SetBlock({|| nTtlExer })
			oSection1:Cell("CREDO"):Hide()
		Else
			oSection1:Cell("DEVED"):Hide()
			oSection1:Cell("CREDO"):SetBlock({|| Abs(nTtlExer) })
		Endif
		oReport:ThinLine()
		oSection1:PrintLine()
		oSection1:Cell("N3_CCONTAB"):Show()
		oSection1:Cell("DESCRICAO"):SetBlock({|| cNomeArq->DESCRIC})
		oSection1:Cell("SALDO"):Show()
		oSection1:Cell("SALD1"):Show()
		oSection1:Cell("DEVED"):SetBlock({|| cNomeArq->DEVED })
		oSection1:Cell("DEVED"):Show()
		oSection1:Cell("CREDO"):SetBlock({|| cNomeArq->CREDO })
		oSection1:Cell("CREDO"):Show()
		oSection1:Cell("AMPLIA1"):Show()
		oReport:EndPage()
	Enddo
	oSection1:Finish()
Else
	oSection1:Print()
Endif

cNomeArq->(dbCloseArea())

//Deleta tabela temporaria do banco de dados
If _oATFR1701 <> Nil
	_oATFR1701:Delete()
	_oATFR1701 := Nil
Endif

SM0->(DbGoTo(nRegSM0))

If !Empty(cTmpFil)
	MsgRun(STR0026,STR0003,{|| CtbTmpErase(cTmpFil)}) //"Favor Aguardar..."###""Resultado da Correcao Monetaria"
Endif

Return()