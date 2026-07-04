/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.CH"
#INCLUDE "GPER220.CH"
#INCLUDE "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER220  ³ Autor ³ R.H. - Marcos Stiefano  ³ Data ³ 03.04.13  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Recibo Vale Transporte                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER220(void)                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ FNC   ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia     ³ 03/04/13 ³RHU210 ³ Unificacao da Folha. Beneficios.         ³±±
±±³Cecilia     ³ 23/08/13 ³RHU210 ³ Unif.Folha. Beneficios-conversao do cal- ³±±
±±³            ³          ³       ³ culo dos beneficios para ser efeutado por³±±
±±³            ³          ³       ³ roteiro.                                 ³±±   
±±³Raquel Hager³ 17/01/13 ³M12RH01³ Unificacao da Folha. Beneficios Fase 2.  ³±±
±±³Raquel Hager³ 29/08/14 ³ TQJCZO³ Tratamento quebra por Filial.			 ³±±
±±³Gustavo M.  ³ 29/09/14 ³ TQPGTT³ Ajuste no retorno da verificao de periodo³±±
±±³Cícero Alves³ 06/04/15 ³ TSAFC6³ Alteração na validação do pergunte para  ³±±
±±³			   ³  		  ³ 	  ³ permitir periodos em aberto				 ³±±
±±³Cícero Alves³ 09/04/15 ³ TSAFC6³ Remoção das alterações feitas para o     ³±±
±±³			   ³  		  ³ 	  ³ chamado TSAFC6 							 ³±±
±±³Isabel N.   ³06/02/17 ³MRH-6261³ Adaptação das funções fVerifFilial() para³±±
±±³            ³         ³        ³U_Gp220VFil(),fVerifDemissao() p/U_Gp220VDem()³±±
±±³            ³         ³        ³e fVerifFilVale() p/U_Gp220VFiVl(), do fonte³±±
±±³            ³         ³        ³GPER210(V11.80), que não é mais utilizado.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER220()
Local oReport   
Local aArea 	:= GetArea()

Private cTitulo		:= OemToAnsi(STR0005)
Private cAliasQry 	:= "SRA"
Private _cCidade    := ""
Private aRoteiro  	:= {}
Private nTVerbas	:= 0
Private cRot		:= fGetCalcRot("8")
Private cPerg		:= "GPE220RVT"
Private lNovoCalc		:= NovoCalcBEN()

	If lNovoCalc
		cPerg := "GPR220RVT"
	EndIf
	
	Pergunte(cPerg,.F.)
	oReport := ReportDef()
	oReport:PrintDialog()

RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ ReportDef  ³ Autor ³ Tania Bronzeri        ³ Data ³11/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Recibo de Vale Transporte                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER220                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GPER220 - Generico - Release 4                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local cSimbMoeda	:=	GetMv("MV_SIMB1")
Local cDesc1		:=	OemToAnsi(STR0005) + OemToAnsi(STR0006) + OemToAnsi(STR0007)	
		//"Recibo de Vale Transporte      " ### "Ser  impresso de acordo com os parametros solicitados pelo"  ### "usu rio."
Private aOrd		:= {OemToAnsi(STR0001),OemToAnsi(STR0002),OemToAnsi(STR0003),OemToAnsi(STR0004)}	//"Matricula","C.Custo","Nome","C.Custo + Nome"
Private cCodVT		:= ""

	DEFINE REPORT oReport NAME "GPER220" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| R220Imp(oReport)} DESCRIPTION OemtoAnsi(STR0027)
			//"Emite Recibo do vale-transporte por funcionario."
	
		DEFINE SECTION oSection1 OF oReport TABLES "SRA" TITLE OemToAnsi(STR0031)  ORDERS aOrd	//Funcionarios
	
			DEFINE CELL NAME "ESPACO1"		OF oSection1 TITLE  " "  SIZE 1 CELL BREAK
			DEFINE CELL NAME "REFERENCIA" 	OF oSection1 TITLE OemToAnsi(STR0010)+OemToAnsi(STR0012) SIZE 15	CELL BREAK		//"RECIBO DE VALE TRANSPORTE" ### "  -  REF.: "
			DEFINE CELL NAME "ESPACO2"		OF oSection1 TITLE  " "  SIZE 1 CELL BREAK
			DEFINE CELL NAME "RA_FILIAL"  	OF oSection1 ALIAS "SRA"
			DEFINE CELL NAME "RA_MAT"	  	OF oSection1 ALIAS "SRA"
			DEFINE CELL NAME "RA_CC"	  	OF oSection1 ALIAS "SRA"
			DEFINE CELL NAME "RA_NOME"	  	OF oSection1 ALIAS "SRA" CELL BREAK
			DEFINE CELL NAME "ESPACO3"		OF oSection1 TITLE  " "   ALIAS "   " SIZE 1 CELL BREAK
			DEFINE CELL NAME "TEXTO"		OF oSection1 ALIAS "   " TITLE OEmToAnsi(STR0028) SIZE 60	;	//"RECEBI DE "
		 								                 BLOCK {||U_fRazSocial() }
			oSection1:SetLineStyle()
			oSection1:SetCharSeparator("")
	
		DEFINE SECTION oSection2 OF oSection1 TABLES "RG2", "SRN" TITLE OemToAnsi(STR0032)	//Meios de Transporte
	
			DEFINE CELL NAME "NVIAGEM"		  	OF oSection2 PICTURE "999" SIZE 3 TITLE " "
			DEFINE CELL NAME "VTCODIGO"   		OF oSection2 			          TITLE OemToAnsi(" -"+STR0019)	//"PASSES "
			DEFINE CELL NAME "RN_DESC"	 	  	OF oSection2 ALIAS "SRN"          TITLE " - "
			DEFINE CELL NAME "NVALUNITARIO" 	OF oSection2                      TITLE OEmToAnsi(STR0020) + cSimbMoeda	PICTURE "@E 9,999,999.99"	SIZE 14	// " a  "
			DEFINE CELL NAME "NVALTOT"		 	OF oSection2                      TITLE " =  " + cSimbMoeda 				PICTURE "@E 9,999,999.99"	SIZE 14
	
			oSection2:SetLineStyle()
			oSection2:SetCharSeparator("")
	
			TRPosition():New(oSection2,"SRN",1,{|| xFilial("SRN")+cCodVT},.T.)

		DEFINE SECTION oSection3 OF oSection1 TABLES "SRA"	TITLE OemToAnsi(STR0033) //Totais
	
			DEFINE CELL NAME "NVALTOTAL"	OF oSection3 TITLE OemToAnsi(STR0029) + cSimbMoeda PICTURE "@E 9,999,999.99"	SIZE 14				//"VALOR TOTAL  "
			DEFINE CELL NAME "NCUSTFUN"		OF oSection3 TITLE OemToAnsi(STR0022) + cSimbMoeda PICTURE "@E 9,999,999.99"	SIZE 14 CELL BREAK	// "   |   VALOR DO FUNCIONARIO  "
			DEFINE CELL NAME "NSALBASE" 	OF oSection3 TITLE OemToAnsi(STR0030) + cSimbMoeda PICTURE "@E 9,999,999.99"	SIZE 14				//"SALARIO BASE "
			DEFINE CELL NAME "NCUSTEMP"		OF oSection3 TITLE OemToAnsi(STR0024) + cSimbMoeda PICTURE "@E 9,999,999.99" 	SIZE 14 CELL BREAK	//"   |   VALOR EMPRESA         "
			DEFINE CELL NAME "ESPACO4"		OF oSection3 TITLE  " "   SIZE 1 CELL BREAK
			DEFINE CELL NAME "ESPACO5"		OF oSection3 TITLE  " "   SIZE 1 CELL BREAK
			DEFINE CELL NAME "ASSINATURA"	OF oSection3 TITLE  " "   SIZE 53 BLOCK {||UPPER(_cCidade) + " " +OemToAnsi(STR0025)}	//"___/___/___  ASSINATURA:____________________________"
			DEFINE CELL NAME "ESPACO6"		OF oSection3 TITLE  " "   SIZE 1 CELL BREAK
	
			oSection3:SetLineStyle()
			oSection3:SetCharSeparator("")
		
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ R220Imp  ºAutor  ³Microsiga           º Data ³  10/12/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao do relatorio.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER220                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R220Imp(oReport)
Local oSection1		:= oReport:Section(1)
Local oSection2 	:= oReport:Section(1):Section(1)
Local oSection3		:= oReport:Section(1):Section(2)
Local nCodMeio    	:= ""
Local nValUnitario	:= 0
Local nSalMes      	:= 0
Local nViagem	    := nValUnAn := nValUnAt := 0 
Local nValTot	 	:= 0
Local nPos	 	   	:= 0
Local lResImp	    := .T.
Local lAceita  		:= .F.
Local nPos0,nPos1,nPos2,nPos3,nPos4,nPos5,nPos6
Local nReg			:= 0
Local cTitFil		:= ""
Local cTitCc		:= ""
Local cTitFunc		:= ""
Local cDesMeio
Local cIndCond		:= ""
Local cFiltro      	:= ""
Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER220" , "SRA" , "2" ) + " } " )
Local cAcessaRG2	:= &( " { || " + ChkRH( "GPER220" , "RG2" , "2" ) + " } " )
Local cAcessaSR0	:= &( " { || " + ChkRH( "GPER220" , "SR0" , "2" ) + " } " )
Local cPed			:= ""
Local cFilOld		:= ""

Private aPosicao1 	:= {} // Array das posicoes
Private aTotCc1   	:= {}
Private aTotFil1  	:= {}
Private aTotEmp1  	:= {}
Private aCodFol   	:= {}
Private aInfo		:= {}
Private nAnaSin,nGerRes
Private nLinAux   	:= 0
Private nComis	  	:= 0
Private nTot1	   	:= nTot2 := nTot3 := nTot4 := nTot5 := 0
Private lImprime	:= .T.
Private lFechado	:= .T.

Private nOrdem 		:= oSection1:GetOrder()
Private cProces     := mv_par01 //Processo
Private cPeriodo    := mv_par02 //Periodo
Private cNumPag     := mv_par03 //Nro Pagamento
Private nMapDif		:= mv_par08 //Imprime Recibo De (Vale ou Diferenca ou Ambos_ 
Private nImpSal		:= mv_par09 //Imprime Salario
Private lPorFolha	:= If(mv_par10 == 1,.T.,.F.)	//Imprime um recibo por folha
Private lPorFili	:= .F.							//Quebra após totalizador por filial e quando não couber na página atual
Private dDataRef	:= Ctod("01/"+Right(cPeriodo,2)+"/"+Left(cPeriodo,4))	//Data de Referencia

	If lNovoCalc
		lPorFili := If( Empty(mv_par12), .F., If( mv_par12 == 1, .T., .F.) )
	Else
		lPorFili := If( Empty(mv_par11), .F., If( mv_par11 == 1, .T., .F.) )
	EndIf

	// Quebrar e Totalizar por Filial
	DEFINE BREAK oBreakFil OF oSection1 WHEN oSection1:Cell("RA_FILIAL") TITLE OemToAnsi(STR0034) // "Total Filial"
	
		DEFINE FUNCTION FROM oSection1:Cell("RA_MAT")	FUNCTION COUNT BREAK oBreakFil NO END REPORT NO END SECTION
	
		oBreakFil:OnBreak({|x,y|U_fBreakFil(y),cTitFil:=OemToAnsi(STR0034)+x})	//"TOTAL FILIAL "
		oBreakFil:SetTotalText({||cTitFil})

	If lPorFolha
		DEFINE BREAK oBreakFun OF oSection1 WHEN oSection1:Cell("RA_MAT") PAGE BREAK
	Else
		oBreakFil:SetPageBreak(lPorFili)
	EndIf
	
	// Condicao de impressao do Funcionario
	oSection1:SetLineCondition({||U_Gp220VFil() .And. U_Gp220VDem() .And. lImprime}) 
	
	// Condicao de impressao do Vale
	oSection2:SetLineCondition({||U_Gp220VFiVl() .And. lImprime}) 
	
	// Query
	cAliasQry := GetNextAlias()
	
	// Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr(cPerg)
	
	oSection1:BeginQuery()
	If nOrdem == 1
		cIndCond:= "%SRA.RA_FILIAL,SRA.RA_MAT%"
	ElseIf nOrdem == 2
		cIndCond:= "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
	ElseIf nOrdem == 3
		cIndCond:= "%SRA.RA_FILIAL,SRA.RA_NOME,SRA.RA_MAT%"
	ElseIf nOrdem == 4
		cIndCond:= "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_NOME%"
	EndIf
	
	BEGIN REPORT QUERY oSection1
		BeginSql alias cAliasQry
			SELECT SRA.*
			FROM %table:SRA% SRA
			WHERE SRA.%notDel%
			  AND SRA.RA_PROCES = %exp:mv_par01%
			ORDER BY %exp:cIndCond%
		EndSql
	END REPORT QUERY oSection1 PARAM mv_par04, mv_par05, mv_par06, mv_par07
	
	oSection1:EndQuery()
	
	// Personaliza titulos
	cTitulo := If(AllTrim(oReport:Title())==AllTrim(cTitulo),OemToAnsi(STR0005),oReport:Title()  )  + " "   //-- RECIBO VALE TRANSPORTE
	cTitulo += If(nMapDif==1,STR0037,If(nMapDif==2,STR0035,STR0036))	//" RECIBO DE VALE TRANSPORTE "###"( NORMAL )"###"( DIFERENCA )"###"( NORMAL + DIFERENCA )"
	cTitulo += ")"
	oReport:SetTitle(cTitulo)
	
	cFilialAnt 	:= Space(FWGETTAMFILIAL)
	cCcAnt  	:= Space(9)
	
	// Incializa impressao
	oSection1:Init()
	oSection2:Init()
	oSection3:Init()
	
	// Movimenta Regua Processamento
	oReport:SetMeter( (cAliasQry)->( RecCount() )) 
	
	dbSelectArea(cAliasQry)
	While !(cAliasQry)->(EOF() )
		
		If cFilOld != (cAliasQry)->RA_FILIAL
			cFilOld := xFilial("RCH",(cAliasQry)->RA_FILIAL)
			DbSelectArea("RCH")
			RCH->( dbsetOrder( Retorder( "RCH" , "RCH_FILIAL+RCH_PROCES+RCH_ROTEIR+RCH_PER+RCH_NUMPAG" ) ) )
			RCH->( dbSeek( cFilOld + cProces + "VTR" + cPeriodo + cNumPag ) )
			
			If Empty(RCH->RCH_DTFECH)
				lFechado := .F.
			EndIf
			
			If lNovoCalc
				MakeadvplExpr(cPerg)
				cPed  	:= mv_par11
				
				If !lFechado
					cPed := Replace(cPed,"RG2","R0")
				EndIf
			EndIf
		EndIf
		
		// Cancela impressao
		If oReport:Cancel()
			Exit
		EndIf 
	
		// Movimenta Regua Processamento
		oReport:IncMeter(1)
	
		// Verifica se func. tem  V.T.
		If lFechado
			DbSelectArea("RG2")
			RG2->(dbSetOrder(RetOrder("RG2", "RG2_FILIAL+RG2_PERIOD+RG2_NROPGT+RG2_ROTEIR+RG2_MAT+RG2_TPVALE+RG2_CODIGO")))
			If !(RG2->(dbSeek((cAliasQry)->RA_FILIAL + cPeriodo + cNumPag + 'VTR' + (cAliasQry)->RA_MAT  + '0'))) 	    
				 dbSelectArea(cAliasQry)
				 dbSkip()
				 Loop
			EndIf
		Else
			If !Empty(RCH->RCH_DTFIM)
				DbSelectArea("SR0")
				SR0->(DbSetOrder(RetOrder("SR0","R0_FILIAL+R0_MAT+R0_TPVALE+R0_CODIGO")))
				If !(SR0->(dbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT + '0')));
					.Or. ((SR0->(dbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT + '0'))) .And. !Empty((cAliasQry)->RA_DEMISSA) .And. (AnoMes((cAliasQry)->RA_DEMISSA) < AnoMes(RCH->RCH_DTFIM)))
					 DbSelectArea(cAliasQry)
					 DbSkip()
					 Loop
				EndIf
			Else
			 	DbSelectArea(cAliasQry)
			 	DbSkip()
			 	Loop
			EndIf
		EndIf
		
		// Posiciono a matric.no SRA quando estiver usando Top Connect  
		dbSelectArea( "SRA" )
		If SRA->(RA_FILIAL+RA_MAT) != (cAliasQry)->(RA_FILIAL+RA_MAT)
			SRA->(DbSetOrder(1))
			SRA->(DbSeek((cAliasQry)->(RA_FILIAL+RA_MAT)))
		EndIf

		// Limpa os Arrays para o Funcionario e Totalizador
		aPosicao1:={} // Limpa Arrays
		lAceita  := .F.
			
		nTotCust := 0
		AeVal(aPosicao1,{ |X| nTotCust += X[5]})	// Acumula Referencias
		
		If lFechado
			DbSelectArea("RG2")
			RG2->(dbSetOrder(RetOrder("RG2", "RG2_FILIAL+RG2_PERIOD+RG2_NROPGT+RG2_ROTEIR+RG2_MAT+RG2_TPVALE+RG2_CODIGO")))
			If (RG2->(dbSeek((cAliasQry)->RA_FILIAL + cPeriodo + cNumPag + 'VTR'+ (cAliasQry)->RA_MAT + '0')))
				While !Eof() .And. ( (CAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT + cPeriodo + cNumPag + 'VTR' = RG2->RG2_FILIAL + RG2->RG2_MAT +RG2->RG2_PERIOD + RG2->RG2_NROPGT + RG2->RG2_ROTEIR)
					If RG2->RG2_TPVALE == '0'
						lAceita = .T.
	
						If !( RG2->RG2_FILIAL $ fValidFil() ) .or. !Eval( cAcessaRG2 ) 
							dbSelectArea ("RG2")
							RG2->( dbSkip() ) 
							Loop
						EndIf
			
						If !Empty(cPed) .And. !RG2->(&cPed)
							dbSelectArea("RG2")
							RG2->( dbSkip()) 
							Loop
						EndIf
			
						dbSelectArea( "SRN" ) 
						If dbSeek( xFilial("SRN",RG2->RG2_FILIAL) + RG2->RG2_CODIGO)
							nCodMeio := SRN->RN_COD
							cDesMeio := SRN->RN_DESC
							nValUnAn := SRN->RN_VUNIANT
							nValUnAt := SRN->RN_VUNIATU
						EndIf
		
						nViagem := If(nMapDif == 2, RG2->RG2_DIADIF ,If(nMapDif == 1, RG2->RG2_DIACAL,RG2->RG2_DIACAL+RG2->RG2_DIADIF))
						nValTot := If(nMapDif == 1, RG2->RG2_VALCAL ,If(nMapDif == 2, RG2->RG2_VALDIF,RG2->RG2_VALCAL+RG2->RG2_VALDIF))			
		
						If nMapDif == 3
							nValUnitario := ( nValUnAn + ( nValUnAt - nValUnAn ) )
							If nValUnitario = 0
								nValUnitario := nValUnAt
							EndIf
						ElseIf nMapDif == 2
							nValUnitario := nValUnAt - nValUnAn
							If nValUnitario = 0
								nValUnitario := nValUnAt
							EndIf
						Else
							nValUnitario := nValUnAt
						EndIf
					
						aAdd( aPosicao1 , { nCodMeio,cDesMeio, nViagem , nValUnitario,nValTot,RG2->(RG2_CUSFUN+RG2_CFUNDF),RG2->(RG2_CUSEMP+RG2_CEMPDF) } )	    		
						nSalMes := RG2->RG2_SALBSE	
					Endif
					
					RG2->( dbSkip() )
				Enddo
			EndIf
		Else
			DbSelectArea("SR0")
			SR0->(DbSetOrder(RetOrder("SR0","R0_FILIAL+R0_MAT+R0_TPVALE+R0_CODIGO")))
			If (SR0->(dbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT + '0')))
				While !Eof() .And. ( (CAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT + '0' == SR0->R0_FILIAL + SR0->R0_MAT + SR0->R0_TPVALE)
					If SR0->R0_TPVALE == '0' 
						lAceita = .T.
	
						If !( SR0->R0_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSR0 ) 
							dbSelectArea ("SR0")
							SR0->( dbSkip() ) 
							Loop
						EndIf
			
						If !Empty(cPed) .And. !SR0->(&cPed)
							dbSelectArea("SR0")
							SR0->( dbSkip()) 
							Loop
						EndIf

						dbSelectArea( "SRN" )
						If dbSeek( xFilial("SRN",SR0->R0_FILIAL) + SR0->R0_CODIGO)
							nCodMeio := SRN->RN_COD
							cDesMeio := SRN->RN_DESC
							nValUnAn := SRN->RN_VUNIANT
							nValUnAt := SRN->RN_VUNIATU
						EndIf
		
						nViagem := If(nMapDif == 2, SR0->R0_QDIADIF ,If(nMapDif == 1, SR0->R0_QDIACAL,SR0->R0_QDIACAL+SR0->R0_QDIADIF))
						nValTot := If(nMapDif == 1, SR0->R0_VALCAL ,If(nMapDif == 2, SR0->R0_VALDIF,SR0->R0_VALCAL+SR0->R0_VALDIF))
		
						If nMapDif == 3
							nValUnitario := ( nValUnAn + ( nValUnAt - nValUnAn ) )
							If nValUnitario = 0
								nValUnitario := nValUnAt
							EndIf
						ElseIf nMapDif == 2
							nValUnitario := nValUnAt - nValUnAn
							If nValUnitario = 0
								nValUnitario := nValUnAt
							EndIf
						Else
							nValUnitario := nValUnAt
						EndIf
					
						aAdd( aPosicao1 , { nCodMeio,cDesMeio, nViagem , nValUnitario,nValTot,SR0->(R0_VLRFUNC+R0_CFUNDF),SR0->(R0_VLREMP+R0_CEMPDF) } )	    		
						nSalMes := SR0->R0_SALBASE
					Endif
					
					SR0->( dbSkip() )
				Enddo
			EndIf
		EndIf
		
		If lAceita == .T.
			lResImp	:= fImpComp	(@aPosicao1,	;
								(cAliasQry)->RA_FILIAL,	;
								(cAliasQry)->RA_MAT,	;
								(cAliasQry)->RA_CC,		;
								(cAliasQry)->RA_NOME,	;
								   nSalMes)
	
			// Imprime se Possui Valores
			If lResImp
				oReport:FatLine()
				If nMapDif == 1
					oSection1:Cell("REFERENCIA"):SetValue(MesExtenso(dDataRef)+"/"+STR(YEAR(dDataRef),4))
				ElseIf nMapDif == 2 
					oSection1:Cell("REFERENCIA"):SetValue(MesExtenso(dDataRef)+"/"+STR(YEAR(dDataRef),4))
				ElseIf nMapDif == 3 
					oSection1:Cell("REFERENCIA"):SetValue(MesExtenso(dDataRef)+"/"+STR(YEAR(dDataRef),4))
				EndIf
				
				//Quebra página caso recibo não caiba na página atual
				If lPorFili .And. oReport:ChkIncRow( 13 + 2*Len(aPosicao1), .T. )
					oReport:EndPage()
				EndIf
			
				oSection1:PrintLine()
				
				For nPos = 1 To Len(aPosicao1)
					cCodVT := aPosicao1[nPos,1]
					oSection2:Cell("NVIAGEM"		):SetValue(aPosicao1[nPos,3])
					oSection2:Cell("VTCODIGO"		):SetValue(aPosicao1[nPos,1])
					oSection2:Cell("RN_DESC"		):SetValue(aPosicao1[nPos,2])
					oSection2:Cell("NVALUNITARIO"	):SetValue(aPosicao1[nPos,4])
					oSection2:Cell("NVALTOT"		):SetValue(aPosicao1[nPos,5])
					oSection2:PrintLine()
				Next
			
				oReport:SkipLine()
				oSection3:Cell("NVALTOTAL"):SetValue(nTot3)
				oSection3:Cell("NCUSTFUN" ):SetValue(nTot4)
				oSection3:Cell("NSALBASE" ):SetValue(If(nImpSal=1,nSalMes,0.00))
				oSection3:Cell("NCUSTEMP" ):SetValue(nTot5)
				oSection3:PrintLine()
				oReport:ThinLine()
			EndIf
			
		EndIf
		cFilialANT := (cAliasQry)->RA_FILIAL // Iguala Variaveis
		cCcAnt     := (cAliasQry)->RA_CC
		(cAliasQry)->( dbSkip()) 
	Enddo

	// Finaliza impressao inicializada pelo metodo Init
	oSection1:Finish()
	oSection2:Finish()
	oSection3:Finish()
	
	// Termino do relatorio
	dbSelectArea("SRA")
	Set Filter To
	dbSetOrder(1)

	Set Device To Screen
	Set Printer To
	MS_FLUSH()


Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ fImpComp ºAutor  ³Microsiga           º Data ³  //         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao do relatorio.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER220                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpComp(aPosicao,cFil,cMat,cCc,cNome,nSalMes)
Local x         	:= 0
Local z         	:= 0
Local i
Local nContador  	:= 1
Local nResImp    	:= 0
Local aAux       	:= {5,6,7}
Local cRazao
Local cCgc
Local cCidade
Local lRet			:= .F.

	nTot1     := nTot2 := nTot3 := nTot4 := nTot5 := 0
	
	fInfo(@aInfo,SRA->RA_FILIAL)
	cRazao    := Subs(aInfo[3]+Space(40),1,30)       // Razao Social
	cCgc      := aInfo[8]                         // CGC
	cCidade   := Subs(aInfo[5],1,20)
	
	For z:= 1 To 3
		AeVal(aPosicao,{ |X| nResImp += X[aAux[z]] }) // Testa se a Soma == 0
	Next
	
	AeVal(aPosicao,{ |X| nTot1 += X[3]})
	AeVal(aPosicao,{ |X| nTot2 += X[4]})
	AeVal(aPosicao,{ |X| nTot3 += X[5]})
	AeVal(aPosicao,{ |X| nTot4 += X[6]})
	AeVal(aPosicao,{ |X| nTot5 += X[7]})
	
	If nResImp > 0
		lRet := .T.
	Else
		lRet := .F.
	EndIf

Return( lRet )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fRazSocial    ³ Autor ³ Tania Bronzeri   ³ Data ³ 11/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Busca Razao Social para imprimir no Recibo.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fRazSocial()

	fInfo(@aInfo,SRA->RA_FILIAL)
	_cCidade 	:= (Subs(alltrim(aInfo[5]),1,20))
	_cRazao		:= (Subs(aInfo[3]+Space(40),1,30))

Return(_cRazao)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³ Gpr220Per  ³ Autor ³ Equipe RH Inovacao    ³ Data ³23/08/13³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Valida os campos periodo e numero de pagamento da pergunte.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nTipo - 1=Periodo e 2=Numero Pagamento  					  ³±±
±±³    		 ³                   cPergPro - processo                      ³±±
±±³    		 ³                   cPergPer - Periodo                       ³±±
±±³    		 ³                   cPergPag - Numero de Pagamento           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Pergunte GPER220  		 	                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */
User Function Gpr220Per( nTipo, cPergProc, cPergPer, cPergPag)	// 1 - Campo RCH_PER e 2 - RCH_NUMPAG
Local cOldAlias := Alias()
Local cFilRCH	:= xFilial("RCH")
Local cMsg
Local lRet 		:= .T.

	Begin Sequence
	
		If ( nTipo == 1 )
			If !( lRet := NaoVazio() )
				Break
			EndIf
		EndIf
	
		DbSelectArea("RCH")
		If ( nTipo == 1 )
			RCH->( dbsetOrder( Retorder( "RCH" , "RCH_FILIAL+RCH_PROCES+RCH_ROTEIR+RCH_PER+RCH_NUMPAG" ) ) )
			RCH->( dbSeek( cFilRCH + cPergProc + "VTR" + cPergPer + SPACE(2) , .T. ) )
			While RCH->(!Eof())  	
				If RCH_FILIAL+RCH_PROCES+RCH_PER+RCH_ROTEIR	== cFilRCH+cPergProc+cPergPer+'VTR'	
					Exit
				EndIf
				RCH->( dbSkip() )
			EndDo
		Else
			RCH->( dbsetOrder( Retorder( "RCH" , "RCH_FILIAL+RCH_PROCES+RCH_PER+RCH_NUMPAG+RCH_ROTEIR" ) ) )
			RCH->( dbSeek( cFilRCH + cPergProc + cPergPer + cPergPag + "VTR", .F. ) )
		EndIf
		If RCH->( Eof() )
			lRet := .F.
			If nTipo == 1
				cMsg := STR0039	// "Periodo nao Cadastrado!"
				MsgInfo( cMsg, STR0038)
			Else
				cMsg := STR0040	// "No. Pagamento nao Cadastrado para este Periodo!"
				MsgInfo( cMsg, STR0038)	
			EndIf
	 	EndIf
	
	End Sequence
	
	DbSelectArea(cOldAlias)

Return( lRet )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fBreakFil      ³ Autor ³ Tania Bronzeri   ³ Data ³09/04/2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Bloco a ser executado na quebra da Filial                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ A partir do Release 4                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fBreakFil(cFilial_Atu) 
Default cFilial_Atu :=  (cAliasQry)->RA_FILIAL 

	// Verificar se o SRV é exclusivo, caso sim, nao deixar passar em branco.
	If At( "SRVE", cArqTab ) > 0 .And. Empty(cFilial_Atu)
		Return
	Endif

	If !Fp_CodFol(@aCodFol,(cFilial_Atu)) .Or. !fInfo(@aInfo,cFilial_Atu) 
		Return
	Endif
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função    ³   Gp220VFil   ³ Autoria ³ Isabel N.  ³   Data ³ 06/02/2017 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Bloco a ser executado no line condition                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   Uso    ³ Renomeada a partir da 12.1.14, trazida do GPER210(V11.80), ³±±
±±³          ³ onde até a versão 12.1.7 era chamada fVerifFilial().       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Gp220VFil()
Local lRet	:= .T.

IF !((cAliasQry)->RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA )
	lRet	:=	.F.
EndIF      

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função    ³   Gp220VDem   ³ Autoria ³ Isabel N.  ³   Data ³ 06/02/2017 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Bloco a ser executado no line condition                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   Uso    ³ Renomeada a partir da 12.1.14, trazida do GPER210(V11.80), ³±±
±±³          ³ onde até a versão 12.1.7 era chamada fVerifDemissao().     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Gp220VDem()
Local lRet	:= .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa se Funcionario demitido no mes/ano de referencia       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( ((cAliasQry)->RA_SITFOLH $"D") .and. MesAno((cAliasQry)->RA_DEMISSA) < MesAno(dDataRef) ).or. ;	//se demitido fora do mes corrente e dt demissao ref mes anterior
	MesAno((cAliasQry)->RA_ADMISSA) > MesAno(dDataRef)														//se admitido apos mes de referencia
	lRet	:= .F.
Endif 

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função    ³   Gp220VFiVl   ³ Autoria ³ Isabel N.  ³  Data ³ 06/02/2017 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Bloco a ser executado no line condition                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   Uso    ³ Renomeada a partir da 12.1.14, trazida do GPER210(V11.80), ³±±
±±³          ³ onde até a versão 12.1.7 era chamada fVerifFilVale().      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Gp220VFiVl()
Local lRet		:= .T.
Local cAliasTab	:= cAliasQry

IF !( (cAliasTab)->R0_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSR0 )
	lRet	:= .F.
EndIF

Return lRet