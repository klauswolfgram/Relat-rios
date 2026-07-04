/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER008.CH"

Static lTemCCT

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддддбддддддддддддбдддддддбддддддддддддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    	Ё GPER008    Ё Autor Ё Mauricio Takakura     	      Ё Data Ё 05/11/11 Ё╠╠
╠╠цдддддддддддддеддддддддддддадддддддаддддддддддддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o 	Ё Relatorio de Conferencia do Calculo de Planos de Saude       			Ё╠╠
╠╠цдддддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   	Ё U_GPER008()                                                    			Ё╠╠
╠╠цдддддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      	Ё Generico ( DOS e Windows )                                   			Ё╠╠
╠╠цдддддддддддддаддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё         ATUALIZACOES SOFRIDAS DESDE A CONSTRU─AO INICIAL.               			Ё╠╠
╠╠цдддддддддддддбддддддддддбддддддддддддддддбддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁProgramador  Ё Data     Ё FNC			Ё  Motivo da Alteracao                      Ё╠╠
╠╠цдддддддддддддеддддддддддеддддддддддддддддеддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁLeandro Dr.  Ё07/02/2012ЁM12RH01         ЁUnificacao da Folha.                  		Ё╠╠
╠╠Ё				Ё		   ЁRHU210_03_07	Ё       .									Ё╠╠
╠╠ЁRaquel Hager Ё05/06/2014ЁTPTBN8     	 	ЁInclusao de replicas versao 11  com itens  Ё╠╠
╠╠Ё             Ё          Ё                Ёdo eSocial.					            Ё╠╠
╠╠ЁWagner MobileЁ14/11/2014ЁTQHAQV  		ЁIncluido tratamento para Filtro do usuario.Ё╠╠
╠╠ЁWag Mobile   Ё30/01/2015ЁTRMQEG          ЁConsiderar registros com tipo de plano e/ouЁ╠╠
╠╠Ё				Ё		   Ё				Ёplano em branco referente a cooparticipacao ╠╠
╠╠ЁAllyson M    Ё19/02/2015ЁTRMQEG          ЁAjuste p/ nao gerar erro na impressao de   Ё╠╠
╠╠Ё				Ё		   Ё				Ёcoparticipacao/reembolso.					Ё╠╠
╠╠ЁHenrique V.  Ё26/05/2015ЁTSBXJV	    	ЁRИplica do chamado TSABHR. Ajuste na rotinaЁ╠╠
╠╠Ё				Ё		   Ё			    Ёpara que seja exibido o Agregado mesmo	    Ё╠╠
╠╠Ё				Ё		   Ё			    Ёque tenha sido excluМdo                    Ё╠╠
╠╠ЁCМcero Alves Ё10/12/2015ЁTTWWBG	    	ЁAlteraГЦo para apresentar o codigo do planoЁ╠╠
╠╠Ё				Ё		   Ё			    Ёpor faixa etАria correto 					Ё╠╠
╠╠ЁGabriel A.   Ё23/09/2016ЁTVEQT2          ЁAlteraГЦo para imprimir a descriГЦo do     Ё╠╠
╠╠Ё             Ё          Ё                Ёplano completa.                            Ё╠╠
╠╠юдддддддддддддаддддддддддаддддддддддддддддаддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ*/
User Function GPER008(cNomeArq)

	Local aArea		:= SRA->(GetArea())
	Local aOrd    	:= {OemToAnsi(STR0004), OemToAnsi(STR0006), OemToAnsi(STR0007)	} // "Centro de Custo + Matricula"###"Matricula"###"Nome"
	Local aPerAtual := {}
	Local aPerPla	:= {}

	Local cDesc1  	:= OemToAnsi( STR0001 ) // "Relatorio do Calculo de Planos de Saude"
	Local cDesc2  	:= OemToAnsi( STR0002 ) // "Sera impresso de acordo com os parametros solicitados "
	Local cDesc3  	:= OemToAnsi( STR0003 ) // "pelo usuario."
	Local cAliasSRA	:= "SRA"  				// Alias do arquivo principal (Base)
	Local cMesAtual	:= ""
	Local cMesPla	:= ""

	Default cNomeArq := "GPER008"
	
	Private aFldRot 	:= {'RA_NOME'}
	Private aOfusca	 	:= If(FindFunction('ChkOfusca'), ChkOfusca(), {.T.,.F.}) //[1] Acesso; [2]Ofusca
	Private lOfuscaNom 	:= .F. 
	Private aFldOfusca	:= {}
	Private lMovAberto	:= .T.

	If aOfusca[2]
		aFldOfusca := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRot ) // CAMPOS SEM ACESSO
		IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_NOME" } ) > 0
			lOfuscaNom := FwProtectedDataUtil():IsFieldInList( "RA_NOME" )
		ENDIF
	ENDIF

	If ( CTT->(LASTREC()) = 0 )
		
		MsgStop(STR0033)	// "NAO HA CENTRO DE CUSTO CADASTRADO"
		Return
	
	EndIf	

	/*
	здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	Ё Define Variaveis Private(Basicas)                            Ё
	юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	Private aReturn  := {"Zebrado",1,"Administracao",2,2,1,"",1 }	//"Zebrado"###"Administra┤└o"
	Private NomeProg := "GPER008"
	Private aLinha   := {}
	Private nLastKey := 0
	Private cPergn    := "GPER008"
	Private lCabec	 := .T.	
	Private lTemPergN:= .F.
	Private lNvPerg	 := .F.
	Private cCcDesc	 := ""
	Private cProcesso:= ""
	Private dDataRef := StoD("//")
	Private cFilRCJ	 := FwxFilial("RCJ")

	/*
	здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	Ё Define Variaveis Private(Programa)                           Ё
	юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	Private aInfo     := {}
	
	/*
	здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	Ё Variaveis Utilizadas na funcao IMPR                          Ё
	юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	Private Titulo
	Private AT_PRG   := "GPER008"
	
	Private wCabec0  := 1
	Private wCabec1  := OemToAnsi(STR0009) // "Tipo            Matr/Seq Nome                           Lancamento          Tp Fornec          Fornecedor               Tp Plano              Cod Plano         Vlr. Func        Vlr. Empresa    Total"
	Private Li       := 0
	Private nTamanho := "G"
	Private CONTFL	 := 1
	Private lCpoSdo  := RHO->(ColumnPos( "RHO_SALDO" )) > 0
	Private cPerg    := "GPER008"
	Private cCodCCT  := ""


	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica existencia da nova tabela Calculo do Plano de Saude - RHR.		Ё
	//Ё Se Nao Existir apresenta mensagem informando a necessidade da execucao	Ё
	//Ё do update para criacao e aborta o acesso ate que o update seja executadoЁ
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If Empty( RetTableName( "RHR" ) )
		Aviso( STR0028, STR0029, { STR0030 } ) // "AtenГЦo"## "Execute a opГЦo do compatibilizador referente ao Novo Plano de SaЗde. Para maiores informaГУes, verifique respectivo Boletim TИcnico." ## "OK"
		Return
	EndIf

	lTemPergN 	:= SX1->( dbSeek("GPER008N") )
	lNvPerg 	:= SX1->( dbSeek("GPER008P") )

	/*
	здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	Ё Verifica as perguntas selecionadas                           Ё
	юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	If lTemPergN
		cPerg := "GPER008N"
	EndIf

	If lNvPerg
		cPerg := "GPER008P"
		cRot 		:= fGetCalcRot('C')
		cProcesso 	:= mv_par01
		
		DEFAULT lTemCCT := fChkCCT()
	Else 
		lTemCCT := .F.
	EndIf

	If lTemCCT
		Aadd(aOrd, OemToAnsi(STR0040)) //CCT + Filial + Centro de Custos
	EndIf

	Pergunte(cPerg,.F.)
	
	Titulo := OemToAnsi( STR0001 ) // "Relatorio do Calculo de Planos de Saude"
	
	/*
	здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	Ё Envia controle para a funcao SETPRINT                        Ё
	юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	wnrel	:=	"GPER008"            //Nome Default do relatorio em Disco
	wnrel	:=	SetPrint(cAliasSRA, wnrel, cPerg, Titulo, cDesc1, cDesc2, cDesc3, .F., aOrd,,nTamanho)
	
	/*
	здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	Ё Carregando variaveis mv_par?? para Variaveis do Sistema.     Ё
	юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	nOrdem     	:= aReturn[8]

	If lNvPerg
		cRepProc  	:= mv_par01		// Processo 
		cRepPer   	:= cAnoMes	:= mv_par02		// PerМodo
		cRepNmPg  	:= mv_par03		// NЗmero de Pagamento
		cFilDe     	:= mv_par04 	// Filial De
		cFilAte    	:= mv_par05		// Filial Ate
		cMatDe     	:= mv_par06		// Matricula De
		cMatAte    	:= mv_par07		// Matricula Ate
		cNomeDe    	:= mv_par08		// Nome De
		cNomeAte   	:= mv_par09		// Nome Ate
		cCcDe      	:= mv_par10		// Centro de Custo De
		cCcAte     	:= mv_par11		// Centro de Custo Ate
		cCategoria 	:= mv_par12 	// Categoria do Funcionario
		cSituacao  	:= mv_par13		// Situacao do Funcionario
		lAnalitico	:= If(mv_par14==1,.T., .F.) // Se a impressao e analitica
		nTpPlan    	:= mv_par15		// Tipo 1-Assistencia MИdica, 2-Assistencia Odontologica ou 3-Ambos
		cForMedDe   := mv_par16		// Fornecedor Medico De
		cForMedAte  := mv_par17		// Fornecedor Medico Ate
		cForOdoDe   := mv_par18		// Fornecedor Odontologico De
		cForOdoAte  := mv_par19		// Fornecedor Odontologico Ate
		cTpPlanDe   := mv_par20		// Tipo de Plano De
		cPlanoDe    := mv_par21		// Cod. Plano De
		cPlanoAte   := mv_par22		// Cod. Plano Ate

		If lTemCCT
			MakeSqlExpr("GPER008P")
			cCodCCT := mv_par23
		EndIf
	Else
		dDataRef	:=	mv_par01	//	Data de Referencia - Competencia
		cAnoMes		:=	Substr(DTOS( dDataRef ), 1, 6)
		cFilDe     	:= mv_par02 	// Filial De
		cFilAte    	:= mv_par03		// Filial Ate
		cMatDe     	:= mv_par04		// Matricula De
		cMatAte    	:= mv_par05		// Matricula Ate
		cNomeDe    	:= mv_par06		// Nome De
		cNomeAte   	:= mv_par07		// Nome Ate
		cCcDe      	:= mv_par08		// Centro de Custo De
		cCcAte     	:= mv_par09		// Centro de Custo Ate
		cCategoria 	:= mv_par10 	// Categoria do Funcionario
		cSituacao  	:= mv_par11		// Situacao do Funcionario
		lAnalitico	:= If(mv_par12==1,.T., .F.) // Se a impressao e analitica
		nTpPlan    	:= mv_par13		// Tipo 1-Assistencia MИdica, 2-Assistencia Odontologica ou 3-Ambos
		cForMedDe   := mv_par14		// Fornecedor Medico De
		cForMedAte  := mv_par15		// Fornecedor Medico Ate
		cForOdoDe   := mv_par16		// Fornecedor Odontologico De
		cForOdoAte  := mv_par17		// Fornecedor Odontologico Ate
		cTpPlanDe   := mv_par18		// Tipo de Plano De
		If !lTemPergN
			cTpPlanAte  := mv_par19		// Tipo de Plano Ate
			cPlanoDe    := mv_par20		// Cod. Plano De
			cPlanoAte   := mv_par21		// Cod. Plano Ate
		Else
			cPlanoDe    := mv_par19		// Cod. Plano
			cPlanoAte   := mv_par20		// Cod. Plano Ate
		EndIf
	EndIf

	cTpPlanAte := IIf(Type( "cTpPlanAte" ) == "U", cTpPlanDe, cTpPlanAte)

	If lNvPerg
		lMovAberto	:= fPerBene(cRepProc, cRepPer, cRepNmpg, cRot)
	Else
		SRA->(DbSeek(xFilial("SRA",cFilDe)+cMatDe))
		fGetPerAtual( @aPerAtual, xFilial("RCH",cFilDe), (cAliasSRA)->RA_PROCES, fGetRotOrdinar() ) //Obtem ano e mes do periodo atual
		
		If !Empty(aPerAtual)
			cMesAtual := aPerAtual[1,5]+aPerAtual[1,4] //RCH_ANO + RCH-MES
		EndIf
		
		If cAnoMes < cMesAtual
			lMovAberto := .F.
		ElseIf cAnoMes == cMesAtual
			fGetPerAtual( @aPerPla, xFilial("RCH"), (cAliasSRA)->RA_PROCES, "PLA" )
			If !Empty(aPerPla)
				cMesPla := aPerPla[1,5]+aPerPla[1,4] //RCH_ANO + RCH-MES
				If cAnoMes < cMesPla
					lMovAberto := .F.
				EndIf
			EndIf
		EndIf
	EndIf
	
	If nLastKey = 27
		Return
	EndIf
	
	If IsBlind()
		aReturn[5] := 1
		aReturn[6] := cNomeArq
	EndIf	
	
	SetDefault(aReturn,cAliasSRA)
	
	If nLastKey = 27
		Return
	EndIf
	
	Titulo += "    "  + OemToAnsi(STR0027) + Substr(cAnoMes,5,2) + " / " + Substr(cAnoMes,1,4)
	
	RptStatus({|lEnd| ProcImp(@lEnd,wnRel,cAliasSRA)},Titulo)

	RestArea(aArea)

Return

/*                                	
зддддддддддбддддддддддддддддбдддддбдддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    Ё ProcImp		ЁAutorЁ Mauricio Takakura Ё Data Ё05/11/2011Ё
цддддддддддеддддддддддддддддадддддадддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁImpressao do Relatorio                                      Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁSintaxe   Ё< Vide Parametros Formais >									Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Uso      ЁALL			                                                Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Retorno  ЁaRotina														Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁParametrosЁ< Vide Parametros Formais >									Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function ProcImp(lEnd, WnRel, cAliasSRA)

	/*
	здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	Ё Define Variaveis Locais (Programa)                           Ё
	юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	Local cQuery	 	:= ""
	Local cOrder	 	:= ""
	Local cFilSRACTT	:= FWJoinFilial( "SRA", "CTT" )
	Local cFilter		:= aReturn[7]
	Local lImpCCT 		:= .F.
	Local cFilMat 		:= ""
	
	Private cAliasQ		:= "QSRA"
	Private cFilialAnt 	:= "  "
	Private cCcAnt     	:= Space(20)
	Private cMatAnt    	:= space(08)
	Private cTpOrigem	:= "" 
	Private cCodUsu		:= ""
	Private cAntMat 	:= ""

	Private aCC			:= {}
	Private aFil		:= {}
	Private aEmp		:= {}
	Private cAliasRHP 	:= "RHP"
	Private cAliasMov 	:= "RHR"
	Private cSvMov	 	:= "RHR"
	Private lTotal		:= .F.
	Private nCopDesc	:= 0

	If !lMovAberto
		cAliasMov := "RHS"
		cSvMov 	  := "RHS"
	EndIf
	
    DbSelectArea( "SRA" )

	If nOrdem == 1
		cOrder	:= "1, 4, 2, 8, 9, 10"
	ElseIf nOrdem == 2
		cOrder	:= "1, 2, 8, 9, 10"
	ElseIf nOrdem == 3
		cOrder	:= "1, 3, 8, 9, 10"
	ElseIf nOrdem == 4
		cOrder := "11, 1, 3, 8, 9, 10"
	EndIf

	//"Centro de Custo + Matricula"###"Matricula"###"Nome"
	
	// Converter string en condicao de IN (Query)
	cSituacao  	:= fSqlIN( cSituacao, 1 )	// Situacao do Funcionario
	cCategoria 	:= fSqlIN( cCategoria, 1 ) 	// Categoria do Funcionario

	//-- Monta query de selecao da informacao
	cQuery	:= "SELECT DISTINCT SRA.RA_FILIAL, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_CC, SRA.RA_ADMISSA, SRA.RA_NASC, SRA.R_E_C_N_O_ AS RA_RECNO, "
	cQuery	+= "CTT.CTT_CUSTO, CTT.CTT_DESC01 CTT_DESC01, MOV." + cAliasMov + "_ORIGEM ORIGEM, "
	If lTemCCT
		cQuery += "MOV." + cAliasMov + "_CODCCT, "
		cCodCCT := Replace(cCodCCT,"RCE_CCT", cAliasMov + "_CODCCT" )
	EndIf
	cQuery  += "MOV." + cAliasMov + "_CODIGO CODIGO, MOV." + cAliasMov + "_TPFORN TPFORN, MOV.* "
	cQuery	+= "FROM "+RetSqlName(cAliasMov)+" MOV "
	cQuery  += "INNER JOIN " + RetSqlName("SRA") + " SRA "
	cQuery  += "ON MOV." + cAliasMov + "_FILIAL = SRA.RA_FILIAL "
	cQuery  += "AND MOV." + cAliasMov + "_MAT = SRA.RA_MAT "
	cQuery  += "LEFT JOIN " + RetSqlName("CTT") + " CTT "

	If ! Empty( xFilial( "CTT" ) )
		cQuery  += "ON " + %exp:cFilSRACTT% + " AND "
	Else
		cQuery	+= "ON "
	EndIf

	cQuery	+= "SRA.RA_CC = CTT.CTT_CUSTO "
	cQuery	+= "WHERE SRA.RA_FILIAL BETWEEN '"	+ cFilDe	+"' AND '" + cFilAte	+ "' "
	cQuery	+=   "AND SRA.RA_MAT BETWEEN '"	+ cMatDe	+"' AND '" + cMatAte	+ "' "
	cQuery	+=   "AND SRA.RA_NOME BETWEEN '"	+ cNomeDe	+"' AND '" + cNomeAte	+ "' "
	cQuery	+=   "AND SRA.RA_CC BETWEEN '"	+ cCcDe		+"' AND '" + cCcAte		+ "' "
	cQuery	+=   "AND SRA.RA_SITFOLH IN("		+ cSituacao	+") "
	cQuery	+=   "AND SRA.RA_CATFUNC IN("		+ cCategoria+") "
	If nTpPlan == 1 .Or. nTpPlan == 2	// 1-Assistencia MИdica ou 2-Assistencia Odontologica
		cQuery	+= "AND MOV." + cAliasMov + "_TPFORN = '" + Str(nTpPlan, 1) + "' "
	EndIf 

	//-- Filtra o parametro de/AtИ de Assistencia mИdica de acordo com o tipo do plano
	cQuery	+= "AND CASE WHEN MOV." + cAliasMov + "_TPFORN = '1' THEN " +;
	               "CASE WHEN MOV." + cAliasMov + "_CODFOR BETWEEN '" + cForMedDe + "' AND '" + cForMedAte + "' THEN 1 ELSE 0 END ELSE 1 END = 1 "

	//-- Filtra o parametro de/AtИ de Assistencia Odontologica de acordo com o tipo do plano
	cQuery	+= "AND CASE WHEN MOV." + cAliasMov + "_TPFORN = '2' THEN " +;
	               "CASE WHEN MOV." + cAliasMov + "_CODFOR BETWEEN '" + cForOdoDe + "' AND '" + cForOdoAte + "' THEN 1 ELSE 0 END ELSE 1 END = 1 "
	
	// Filtra o parametro do tipo de plano de/atИ
	If !lTemPergN
		cQuery	+= "AND (MOV." + cAliasMov + "_TPPLAN BETWEEN '" + Str(cTpPlanDe, 1) + "' AND '" + Str(cTpPlanAte, 1) + "' OR MOV." + cAliasMov + "_TPPLAN = '') "
	Else
		cQuery	+= "AND (MOV." + cAliasMov + "_TPPLAN IN (" + fSqlIN( cTpPlanDe, 1 ) + ") OR MOV." + cAliasMov + "_TPPLAN = '') "
	EndIf

	// Filtra o parametro do CСdigo do Plano de/atИ
	cQuery	+= "AND (MOV." + cAliasMov + "_PLANO BETWEEN '" + cPlanoDe + "' AND '" + cPlanoAte + "' OR MOV." + cAliasMov + "_PLANO = '') "

	cQuery	+= "AND MOV." + cAliasMov + "_COMPPG = '" + cAnoMes + "' "

	If lTemCCT .and. !Empty(cCodCCT)
		cQuery += "AND " + cCodCCT + " "
	EndIf
	
	cQuery	+= "AND MOV.D_E_L_E_T_ = ' ' "
	cQuery	+= "AND SRA.D_E_L_E_T_ = ' ' "
	cQuery	+= "AND CTT.D_E_L_E_T_ = ' '  "
	cQuery	+= "ORDER BY " + cOrder

	cQuery	:= ChangeQuery( cQuery )
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasQ, .F., .T.)

	TcSetField(cAliasQ, "RA_NASC", "D", 8,0)
	dbSelectArea( cAliasQ )
	SetRegua((cAliasQ)->(RecCount()))
	
	cAntMat := ""
                              
	While !(cAliasQ)->(Eof())
		If ( !(Empty((cAliasQ)->RA_FILIAL)) .And. !(AllTrim((cAliasQ)->RA_FILIAL) $ fValidFil()) )
			dbSelectArea(cAliasQ)
			dbSkip()
			Loop
		EndIf
		cCcDesc	:= "" // Ao ocorrer a troca de filiais, nao sera 'carregado' a descricao do centro de custo utilizado anteriormente.
	
		/*
		здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		Ё Movimenta Regua Processamento                                Ё
		юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
		IncRegua()
		If ! Empty(cFilter)
			SRA->(DbGoto((cAliasQ)->(RA_RECNO))) 
			If ! SRA->(&(cFilter))
				(cAliasQ)->(DbSkip())
				Loop
			EndIf
		EndIf
	
		/*
		здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		Ё Cancela Impresфo ao se pressionar <ALT> + <A>                Ё
		юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
		If lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		EndIf
		
		If cAntMat <> ( cAliasQ )->RA_FILIAL + ( cAliasQ )->RA_MAT
			cAntMat := ( cAliasQ )->RA_FILIAL + ( cAliasQ )->RA_MAT
			cCodUsu		:= ""
			cTpOrigem	:= ""
			nCopDesc	:= 0
			//Se a competencia selecionada ja estiver fechada
			If !lMovAberto
				//-- Monta query de selecao da informacao
				cQuery	:= "SELECT *"
				cQuery	+= "FROM "+RetSqlName(cAliasRHP)+" RHP "
				cQuery	+= "WHERE "
				cQuery	+= "RHP.RHP_FILIAL = '"	+ ( cAliasQ )->RA_FILIAL +"'"
				cQuery	+= "AND RHP.RHP_MAT = '"	+ ( cAliasQ )->RA_MAT + "' "
				cQuery	+= "AND RHP.RHP_COMPPG = '" + cAnoMes + "' "

				If nTpPlan == 1 .Or. nTpPlan == 2	// 1-Assistencia MИdica ou 2-Assistencia Odontologica
					cQuery	+= "AND RHP.RHP_TPFORN = '" + Str(nTpPlan, 1) + "' "
				EndIf 
			
				//-- Filtra o parametro de/AtИ de Assistencia mИdica de acordo com o tipo do plano
				cQuery	+= "AND CASE WHEN RHP.RHP_TPFORN = '1' THEN " +;
				               "CASE WHEN RHP.RHP_CODFOR BETWEEN '" + cForMedDe + "' AND '" + cForMedAte + "' THEN 1 ELSE 0 END ELSE 1 END = 1 "

				//-- Filtra o parametro de/AtИ de Assistencia Odontologica de acordo com o tipo do plano
				cQuery	+= "AND CASE WHEN RHP.RHP_TPFORN = '2' THEN " +;
				               "CASE WHEN RHP.RHP_CODFOR BETWEEN '" + cForOdoDe + "' AND '" + cForOdoAte + "' THEN 1 ELSE 0 END ELSE 1 END = 1 "
							
				// Filtra o parametro do CСdigo do Plano de/atИ
				cQuery	+= "AND RHP.RHP_CODIGO BETWEEN '" + cPlanoDe + "' AND '" + cPlanoAte + "' "

				cQuery	+= "AND RHP.D_E_L_E_T_ = ' '"
		
				cQuery	:= ChangeQuery( cQuery )
				
				If Select("RHP") > 0
					(cAliasRHP)->(dbclosearea())
				EndIf
				
				dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasRHP, .F., .T.)
					
				While !(cAliasRHP)->(Eof())
					SRA->(DbSeek( ( cAliasQ )->RA_FILIAL + ( cAliasQ )->RA_MAT ))
					fImpFun(cAliasRHP, 2)
					fTestaTotal(2)
				End Do
				(cAliasRHP)->(dbclosearea())
				dbSelectArea( cAliasQ )
			EndIf 
		EndIf
	
		/*
		здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		Ё Impressao do Funcionario                                     Ё
		юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
		SRA->(DbSeek( ( cAliasQ )->RA_FILIAL + ( cAliasQ )->RA_MAT ))
		If lTemCCT .and. cFilMat <> ( cAliasQ )->RA_FILIAL + ( cAliasQ )->RA_MAT 
			lImpCCT := .T.
			cFilMat := ( cAliasQ )->RA_FILIAL + ( cAliasQ )->RA_MAT
		EndIf
		fImpFun(cAliasQ,1,@lImpCCT)
		
		fTestaTotal(1,@lImpCCT)
	EndDo
	/*
	здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	Ё Termino do Relatorio                                         Ё
	юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	(cAliasQ)->(dbclosearea())
	
	dbSelectArea("SRA")
	Set Filter to
	dbSetOrder(1)
	Set Device To Screen
	If aReturn[5] = 1
		Set Printer To
		Commit
		ourspool(wnrel)
	EndIf
	MS_FLUSH()

Return

/*                                	
зддддддддддбддддддддддддддддбдддддбдддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    Ё fImpFun		ЁAutorЁ Mauricio Takakura Ё Data Ё05/11/2011Ё
цддддддддддеддддддддддддддддадддддадддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁImpressao do Funcionario                                    Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁSintaxe   Ё< Vide Parametros Formais >									Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Uso      ЁALL			                                                Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Retorno  ЁaRotina														Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁParametrosЁ< Vide Parametros Formais >									Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fImpFun(cAliasImp, nOpcao, lImpCCT)
	
	Local nBusca
	Local cAux 
	Local cAtCodUsu 
	Local cNome			:= "" 
	Local cTab 			:= "S008"
	Local cTpPlan		:= ""
	Local nCol 			:= 13
    Local nPosTab
	Local lHasDep
	Local cMesAno		:= ""	
	Local cIdadeDesc	:= SuperGetMv( "MV_PLSBASI",, "1" )		
	Local aOrdem   		:= {}
	Local lFxSalEt 		:= .F. // VariАvel que verifica se И faixa Salarial/EtАria
	Local lFxSalTe 		:= .F. // VariАvel que verifica se И faixa Salarial/Tempo
	Local lNomeCont 	:= .F.
	Local lPriLin       := .F.
	
	DEFAULT nOpcao 		:= 1
	DEFAULT lImpCCT     := .F.

	//Tipo			Matr/Seq Nome							Lancamento  		Tp Fornec		  Fornecedor 			   Tp Plano              Cod Plano  	   Vlr. Func		Vlr. Empresa
	//1-Titular		xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxx  1-Co-participacao   1-Ass. Odontol.   xx-xxxxxxxxxxxxxxxxxxxx  x-Vlr Fixo por vida   xx-xxxxxxxxxxxxX  999,999,999.99   999,999,999.99
	//2-Dependente
	//3-Agregado

	If !Empty(cAnoMes)
		cMesAno := Substr(cAnoMes,5,6) + Substr(cAnoMes,1,4)
	EndIf
	
	If nOpcao == 1
		cAliasMov := cSvMov
	Else
		cAliasMov := cAliasRHP
	EndIf

	fTestaLinha()
	//-- Imprime o cabecalho inicial do primeiro registro a ser impresso.
	If Empty(cMatAnt) .And. Empty(cFilialAnt) .And. Empty(cCcAnt)
		fCabec(1,(cAliasQ)->RA_FILIAL)	//-- Filial
		If nOrdem == 1
			cCcDesc := (cAliasQ)->CTT_DESC01
			fCabec(2,(cAliasQ)->RA_CC,cCcDesc)	//-- Centro de custo
		EndIf
	EndIf

	If cMatAnt <> (cAliasQ)->RA_FILIAL + (cAliasQ)->RA_MAT
		lPriLin := .T. 
	EndIf

	cMatAnt	:= (cAliasQ)->RA_FILIAL + (cAliasQ)->RA_MAT
	
	If lAnalitico
		cDet := "" 
		
		// Impressao do Tipo
		If cTpOrigem <> (cAliasImp)->( &(cAliasMov + "_ORIGEM" ) )
			cTpOrigem	:= (cAliasImp)->( &(cAliasMov + "_ORIGEM" ) )
			cCodUsu		:= ""	// Ao trocar Origem limpa o Cod. Usuario para forcar impressao do 1o nome
			
			If cTpOrigem == "1" 
				cDet += cTpOrigem + "-" + OemToAnsi(STR0012) //"Titular"
			ElseIf cTpOrigem == "2" 
				cDet += cTpOrigem + "-" + OemToAnsi(STR0013) //"Dependente"
			Else
				cDet += cTpOrigem + "-" + OemToAnsi(STR0014) //"Agregado"
			EndIf
			cDet := If( Len(cDet) > 12, Substr(cDet,1,12), cDet+Space(12-Len(cDet)))
		Else
			cDet := Space(12)
		EndIf
		cDet += "  "

		// Impressao da matricula/Sequencia + Nome
		If cTpOrigem == "1" //Titular
			cAtCodUsu := (cAliasQ)->RA_MAT
		Else
			cAtCodUsu := (cAliasImp)->( &(cAliasMov + "_CODIGO" ) )
		EndIf

		If cCodUsu <> cAtCodUsu
			cCodUsu 	:= cAtCodUsu
			If cTpOrigem == "1" //Titular
				cNome := (cAliasQ)->RA_NOME
				cNome := If(lOfuscaNom,Replicate('*',15) + Space(len((cAliasQ)->RA_NOME)-15),cNome)
			ElseIf cTpOrigem == "2" //Dependente
				DbSelectArea( "SRB" )
				DbSetOrder( RetOrdem( "SRB", "RB_FILIAL+RB_MAT" ) )
				DbSeek( (cAliasQ)->RA_FILIAL + (cAliasQ)->RA_MAT, .F. )
				lHasDep := .F.
				While SRB->( !EOF() ) .and. SRB->RB_FILIAL + SRB->RB_MAT == (cAliasQ)->RA_FILIAL + (cAliasQ)->RA_MAT
					If SRB->RB_COD == cCodUsu
						lHasDep := .T.
						Exit
					EndIf
					SRB->( DbSkip() )
				EndDo
                cNome := SRB->RB_NOME
				cNome := If(lOfuscaNom,Replicate('*',15) + Space(len(SRB->RB_NOME)-15),cNome)
			Else
				DbSelectArea( "RHM" ) 
				DbSetOrder( RetOrdem( "RHM", "RHM_FILIAL+RHM_MAT+RHM_TPFORN+RHM_CODFOR+RHM_CODIGO"))
				DbSeek( (cAliasQ)->RA_FILIAL + (cAliasQ)->RA_MAT + (cAliasImp)->(&(cAliasMov + "_TPFORN")) + (cAliasImp)->(&(cAliasMov + "_CODFOR")) + (cAliasImp)->(&(cAliasMov + "_CODIGO")), .F.)
				If !Eof()
					cNome := RHM->RHM_NOME
					cNome := If(lOfuscaNom,Replicate('*',15),cNome)
				Else
					DbSelectArea( "RHN" ) 
					DbSetOrder( RetOrdem( "RHN", "RHN_FILIAL+RHN_MAT+DTOS(RHN_DATA)"))
					DbSeek( (cAliasQ)->RA_FILIAL + (cAliasQ)->RA_MAT , .F.)
					While !Eof() 
						If RHN->RHN_CODIGO == cCodUsu .And. RHN->RHN_ORIGEM == cTpOrigem .And. RHN->RHN_TPFORN + RHN->RHN_CODFOR + RHN_PERFIM == (cAliasImp)->(&(cAliasMov + "_TPFORN")) + (cAliasImp)->(&(cAliasMov + "_CODFOR")) + cMesAno
							Exit
						EndIf
						RHN->( DbSkip() )
					EndDo
					cNome := RHN->RHN_NOME
					cNome := If(lOfuscaNom,Replicate('*',15),cNome)
				EndIf
			EndIf
			cAux := cCodUsu + "-" + cNome
			If Len(cAux) > 39
				cAuxCont := Substr( cAux, 40, 69 )
				cAux := Substr( cAux, 01, 39 )
				lNomeCont := .T.
			Else
				cAux := cAux + Space( 39 - Len(cAux) )
			EndIf
			cDet += cAux
		Else 
			cDet += Space(39)
		EndIf
		cDet += "  "
		
		// Impressao do Tipo de Lancamentos 
		If nOpcao == 1
			If (cAliasImp)->( &(cAliasMov + "_TPLAN")) == "1"
				cAux := (cAliasImp)->( &(cAliasMov + "_TPLAN")) + "-" + OemToAnsi(STR0015) //Planos
			ElseIf (cAliasImp)->( &(cAliasMov + "_TPLAN")) == "2"
				cAux 		:= (cAliasImp)->( &(cAliasMov + "_TPLAN")) + "-" + OemToAnsi(STR0016) //Co-Participacao
				nCopDesc	+= (cAliasImp)->( &(cAliasMov + "_VLRFUN"))
			Else
				cAux := (cAliasImp)->( &(cAliasMov + "_TPLAN")) + "-" + OemToAnsi(STR0017) //Reembolso
			EndIf
		Else
			If (cAliasImp)->( &(cAliasMov + "_TPLAN")) == "1"
				cAux 		:= "2-" + OemToAnsi(STR0016) //Co-Participacao
				nCopDesc	+= (cAliasImp)->( &(cAliasMov + "_VLRFUN"))
			Else
				cAux := "3-" + OemToAnsi(STR0017) //Reembolso
			EndIf
		EndIf
		If Len(cAux) > 17
			cAux := Substr(cAux, 1, 17)
		Else
			cAux := cAux + Space( 17-Len(cAux) )
		EndIf
		cDet += cAux + "   "
		
		// Impressao do Tipo do Fornecedor
		If (cAliasImp)->( &(cAliasMov + "_TPFORN")) == "1"
			cAux := (cAliasImp)->( &(cAliasMov + "_TPFORN")) + "-" + OemToAnsi(STR0018) //"Ass. Medica"
		Else
			cAux := (cAliasImp)->( &(cAliasMov + "_TPFORN")) + "-" + OemToAnsi(STR0019) //"Ass. Odontol."
		EndIf
		If Len(cAux) > 15
			cAux := Substr(cAux, 1, 15)
		Else
			cAux := cAux + Space( 15-Len(cAux) )
		EndIf
		cDet += cAux + "   "
		
		// Impressao do Fornecedor 
		If (cAliasImp)->( &(cAliasMov + "_TPFORN")) == "1" 
			If ( nPosTab := fPosTab( "S016", (cAliasImp)->( &(cAliasMov + "_CODFOR")),"=", 4, ,,,,,,, (cAliasQ)->RA_FILIAL ) ) > 0
				cAux := fTabela("S016",nPosTab,5,,(cAliasQ)->RA_FILIAL)
			Else 
				cAux := " " 
			EndIf
		Else
			If ( nPosTab := fPosTab( "S017" , (cAliasImp)->( &(cAliasMov + "_CODFOR")),"=", 4, ,,,,,,, (cAliasQ)->RA_FILIAL ) ) > 0
				cAux := fTabela("S017",nPosTab,5,,(cAliasQ)->RA_FILIAL)
			Else 
				cAux := " " 
			EndIf
		EndIf
		cAux := (cAliasImp)->( &(cAliasMov + "_CODFOR")) + "-" + cAux
		If Len( cAux ) > 23
			cAux := Substr(cAux, 1, 23 )
		Else
			cAux := cAux + Space( 23 - Len(cAux) )
		EndIf
		cDet += cAux + "  "

		// Impressao do Tipo do Plano
		cAux 	:= ""
		cTpPlan	:= ""

		If nOpcao == 1
			cTpPlan	:= (cAliasImp)->( &(cAliasMov + "_TPPLAN"))
			If !Empty(cTpPlan)
				If cTpPlan == "1"
					cAux := cTpPlan + "-" + OemToAnsi(STR0020) //"Faixa Salarial"
				ElseIf cTpPlan == "2"
					cAux := cTpPlan + "-" + OemToAnsi(STR0021) //"Faixa Etaria"
				ElseIf cTpPlan == "3"
					cAux := cTpPlan + "-" + OemToAnsi(STR0022) //"Vlr Fixo por vida"
				ElseIf cTpPlan == "4"
					cAux := cTpPlan + "-" + OemToAnsi(STR0023) //"% Sobre salario"
				ElseIf cTpPlan == "5"
					cAux := cTpPlan + "-" + OemToAnsi(STR0034) //"Salarial/Etaria"
				ElseIf cTpPlan == "6"
					cAux := cTpPlan + "-" + OemToAnsi(STR0035) //"Salarial/Tempo"
				EndIf
			EndIf
		EndIf
		If Len(cAux) > 20
			cAux := Substr(cAux, 1, 20)
		Else
			cAux := cAux + Space( 20-Len(cAux) )
		EndIf
		cDet += cAux + "   "

		// Impressao do Plano
		cAux := ""
		If nOpcao == 1 .And. ! Empty(cTpPlan)
			If (cAliasImp)->( &(cAliasMov + "_TPFORN")) == "1" // Fornecedor Assistencia MИdica.
				If cTpPlan == "1"
					cTab := "S008"
					nCol := 13
				ElseIf cTpPlan $ "2*5" // Faixa EtАria ou Faixa Salarial/EtАria.
					If cTpPlan == "2"
						cTab := "S009"
						nCol := 13
						aOrdem := {1,2,3,7}
					Else
						cTab := "S059"
						nCol := 14
						aOrdem := {1,2,15,5,7,8}
						lFxSalEt := .T.
					EndIf	
					
					If cTpOrigem == "1" 
						nBusca := Year( dDataBase ) - Year( (cAliasQ)->RA_NASC )
						If Month( (cAliasQ)->RA_NASC ) > Month( dDataBase ) .OR. (cIdadeDesc == "2" .And. (Month( (cAliasQ)->RA_NASC )== Month( dDataBase )))
							nBusca--
						EndIf
					ElseIf cTpOrigem == "2" 
						nBusca := Year( dDataBase ) - Year( SRB->RB_DTNASC )
						If Month( SRB->RB_DTNASC ) > Month( dDataBase ) .OR. ( cIdadeDesc == "2" .And. ( Month( SRB->RB_DTNASC )== Month( dDataBase )))
							nBusca--
						EndIf
					Else
						nBusca := Year( dDataBase ) - Year( RHM->RHM_DTNASC )
						If Month( RHM->RHM_DTNASC ) > Month( dDataBase ) .OR. ( cIdadeDesc == "2" .And. (Month( RHM->RHM_DTNASC )== Month( dDataBase )))
							nBusca--
						EndIf
					EndIf
				ElseIf cTpPlan == "3"
					cTab := "S028"
					nCol := 12
				ElseIf cTpPlan == "4" 
					cTab := "S029" 
					nCol := 15 
				ElseIf cTpPlan == "6" 
					cTab 		:= "S140"
					nCol 		:= 14
					aOrdem 		:= {1,2,15,5,7,8}
					lFxSalTe 	:= .T.
				EndIf
			ElseIf (cAliasImp)->( &(cAliasMov + "_TPFORN")) == "2" // Fornecedor Assistencia OdontolСgica.
				If cTpPlan == "1" 
					cTab := "S013" 
					nCol := 13
				ElseIf cTpPlan $ "2*5" // Faixa EtАria ou Faixa Salarial/EtАria.
					If cTpPlan == "2"
						cTab := "S014"
						nCol := 13
						aOrdem := {1,2,3,7}
					Else
						cTab := "S060"
						nCol := 14
						aOrdem := {1,2,15,5,7,8}
						lFxSalEt := .T.
					EndIf

					//Calcula a Idade.
					If cTpOrigem == "1" 
						nBusca := Year( dDataBase ) - Year( (cAliasQ)->RA_NASC )
						If Month( (cAliasQ)->RA_NASC ) > Month( dDataBase ) .OR. (cIdadeDesc == "2" .And. (Month( (cAliasQ)->RA_NASC )== Month( dDataBase )))
							nBusca--
						EndIf
					ElseIf cTpOrigem == "2" 
						nBusca := Year( dDataBase ) - Year( SRB->RB_DTNASC )
						If Month( SRB->RB_DTNASC ) > Month( dDataBase ) .OR. ( cIdadeDesc == "2" .And. ( Month( SRB->RB_DTNASC )== Month( dDataBase )))
							nBusca--
						EndIf
					Else
						nBusca := Year( dDataBase ) - Year( RHM->RHM_DTNASC )
						If Month( RHM->RHM_DTNASC ) > Month( dDataBase ) .OR. ( cIdadeDesc == "2" .And. (Month( RHM->RHM_DTNASC )== Month( dDataBase )))
							nBusca--
						EndIf
					EndIf

				ElseIf cTpPlan == "3"
					cTab := "S030"
					nCol := 12
				ElseIf cTpPlan == "4"
					cTab := "S031"
					nCol := 15
				ElseIf cTpPlan == "6"
					cTab 		:= "S141"
					nCol 		:= 14
					aOrdem 		:= {1,2,15,5,7,8}
					lFxSalTe	:= .T.
				EndIf
			EndIf

			If (nPosTab := fPosTab(cTab, (cAliasImp)->( &(cAliasMov + "_CODFOR")), "=", nCol, (cAliasImp)->(&(cAliasMov + "_PLANO")), "=", 4,,,,,(cAliasQ)->RA_FILIAL, nBusca, "<=", If(lFxSalEt .Or. lFxSalTe,7,6), , aOrdem)) > 0
				cAux := fTabela(cTab, nPosTab, 5,dDataRef, (cAliasQ)->RA_FILIAL)
			Else
				cAux := " "
			EndIf

			cAux := (cAliasImp)->( &(cAliasMov + "_PLANO")) + "-" + cAux
		EndIf 
		
		cAux := cAux + Space( 23 - Len(cAux) )
		
		cDet += cAux + "  "

		cDet += Str( (cAliasImp)->( &(cAliasMov + "_VLRFUN")) , 12,2) + Space(3) 
		cDet += Str( (cAliasImp)->( &(cAliasMov + "_VLREMP")) , 12,2) + Space(4)
		
		cDet += Str( (cAliasImp)->( &(cAliasMov + "_VLRFUN")) + (cAliasImp)->( &(cAliasMov + "_VLREMP")), 12,2)
		
		If !lNomeCont .and. !lPriLin .and. lImpCCT
			fImpCCT((cAliasImp)->( &(cAliasMov + "_CODCCT")),@cDet)				
			lImpCCT := .F.
		EndIf

		Impr(cDet,"C")

		If lNomeCont
			cDet := ' '
			cDet += Space(16)
			cDet += cAuxCont
			Impr(cDet,"C")
			lNomeCont := .F.
		EndIf
	EndIf
	
	//-- Acumula Centro de custo / filial / empresa
	If ( nPos := Ascan(aCC,{|x| x[1] == (cAliasQ)->RA_CC}) ) > 0
		aCC[nPos,2]		+= 1
		aCC[nPos,3]		+= (cAliasImp)->( &(cAliasMov + "_VLRFUN"))
		aCC[nPos,4]		+= (cAliasImp)->( &(cAliasMov + "_VLREMP"))
	Else
		Aadd(aCC,{(cAliasQ)->RA_CC, 1, (cAliasImp)->( &(cAliasMov + "_VLRFUN")), (cAliasImp)->( &(cAliasMov + "_VLREMP"))})
	EndIf

	If ( nPos	:= Ascan(aFil,{|x| x[1] == (cAliasQ)->RA_FILIAL}) ) > 0
		aFil[nPos,2]	+= 1
		aFil[nPos,3]	+= (cAliasImp)->( &(cAliasMov + "_VLRFUN"))
		aFil[nPos,4]	+= (cAliasImp)->( &(cAliasMov + "_VLREMP"))
	Else
		Aadd(aFil,{(cAliasQ)->RA_FILIAL, 1, (cAliasImp)->( &(cAliasMov + "_VLRFUN")), (cAliasImp)->( &(cAliasMov + "_VLREMP"))})
	EndIf

	If ( nPos	:= Ascan(aEmp,{|X| X[1] == cEmpAnt}) ) > 0
		aEmp[nPos,2]	+= 1
		aEmp[nPos,3]	+= (cAliasImp)->( &(cAliasMov + "_VLRFUN"))
		aEmp[nPos,4]	+= (cAliasImp)->( &(cAliasMov + "_VLREMP"))
	Else
		Aadd(aEmp,{cEmpAnt, 1, (cAliasImp)->( &(cAliasMov + "_VLRFUN")), (cAliasImp)->( &(cAliasMov + "_VLREMP"))})
	EndIf

Return Nil

/*                                	
зддддддддддбддддддддддддддддбдддддбдддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    Ё fTestaTotal	ЁAutorЁ Mauricio Takakura Ё Data Ё05/11/2011Ё
цддддддддддеддддддддддддддддадддддадддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁImpressao do Totalizador                                    Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁSintaxe   Ё< Vide Parametros Formais >									Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Uso      ЁALL			                                                Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Retorno  ЁaRotina														Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁParametrosЁ< Vide Parametros Formais >									Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fTestaTotal(nOpcao,lImpCCT)
	
	Local nSaldoCop	:= 0
	Local cFilMat   := ""
	
	DEFAULT nOpcao 	:= 1
	DEFAULT lImpCCT := .F.
	
	If nOpcao == 1
		dbSelectArea( cAliasQ )
	Else
		dbSelectArea( cAliasRHP )
	EndIf
	
	cFilialAnt := (cAliasQ)->RA_FILIAL              // Iguala Variaveis
	cCcAnt     := (cAliasQ)->RA_CC
	cFilMat	   := (cAliasQ)->RA_FILIAL + (cAliasQ)->RA_MAT
	If lTemCCT .And. lImpCCT
		cCodCCT    := (cAliasQ)->( &(cAliasMov + "_CODCCT"))
	EndIf

	dbSkip()

	If lImpCCT .and. cFilMat <> ( cAliasQ )->RA_FILIAL + ( cAliasQ )->RA_MAT
		fImpCCT(cCodCCT)
		lImpCCT := .F.
	EndIf

	If lCpoSdo .And. nCopDesc > 0 .And. cAntMat != (cAliasQ)->RA_FILIAL+(cAliasQ)->RA_MAT
		nSaldoCop := fVerSCop(cAntMat)
		If lMovAberto
			nSaldoCop := Max( nSaldoCop - nCopDesc, 0 )
		EndIf
		fImprCop(nSaldoCop)
	EndIf

	If nOpcao == 1
		If Eof()
			fImpCc(cCcAnt)
			fTestaLinha()
			fImpFil(cFilialAnt)
			fImpEmp()
		Elseif cFilialAnt # (cAliasQ)->RA_FILIAL
			lCabec	:= .F.
			fImpCc(cCcAnt)
			lCabec	:= 	.T.
			fTestaLinha()
			fImpFil(cFilialAnt)
		Elseif cCcAnt # (cAliasQ)->RA_CC .and. nOrdem == 1
			fImpCc(cCcAnt)   
		Elseif lTotal
			If !(nOrdem == 1) 
				fImpCc(cCcAnt)
			Endif
			fTestaLinha()			
			fImpFil(cFilialAnt)		
			fImpEmp()
		EndIf
	Else
		fTestaLinha()
	EndIf

Return

/*                                	
зддддддддддбддддддддддддддддбдддддбдддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    Ё fImpCc     	ЁAutorЁ Mauricio Takakura Ё Data Ё05/11/2011Ё
цддддддддддеддддддддддддддддадддддадддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁImpressao do Totalizador por Centro de Custo                Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁSintaxe   Ё< Vide Parametros Formais >									Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Uso      ЁALL			                                                Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Retorno  ЁaRotina														Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁParametrosЁ< Vide Parametros Formais >									Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fImpCc(cCcAnt)
	Local cDet		:= ""	
	Local nPos		:= 0
	Local nPos1		:= 0
	Local nx		:= 0
	
	If nOrdem <> 1
		Return Nil
	EndIf
	
	If ( nPos	:= Ascan(aCC,{|X| X[1] == cCcAnt}) ) == 0
		Return Nil
	Endif
	
	cDet := Space(1)
	Impr(cDet,"C")
	
	cDet := OemToAnsi(STR0024)  //" T O T A L  C E N T R O  D E  C U S T O S" ## " FuncionАrio(s) "
	
	cDet += Space(126) + Transform(aCC[nPos,3],"@E 9,999,999.99") + " "
	cDet += Space(2) + Transform(aCC[nPos,4],"@E 9,999,999.99") + " "
	cDet += Space(3) + Transform(aCC[nPos,3]+aCC[nPos,4],"@E 9,999,999.99") + " "
	Impr(cDet,"C")
	
	cDet := Repl("-",220)
	Impr(cDet,"C")

	cDet := ""
	Impr(cDet,"C")
	Impr(cDet,"C")
	
	fTestaLinha()
	//-- Imprime cabecalho para o proximo centro de custos
	cCcDesc := (cAliasQ)->CTT_DESC01
	
	If ( lCabec )		
		fCabec(2,(cAliasQ)->RA_CC,cCcDesc)	//-- Centro de custo
	EndIf	
	aCc	:=	{} // Limpa o Array, para evitar que sejam somados Centro de Custo com o mesmo codigo, de outras filiais.

Return Nil

/*                                	
зддддддддддбддддддддддддддддбдддддбдддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    Ё fImpFil     	ЁAutorЁ Mauricio Takakura Ё Data Ё05/11/2011Ё
цддддддддддеддддддддддддддддадддддадддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁImpressao do Totalizador por Filial                         Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁSintaxe   Ё< Vide Parametros Formais >									Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Uso      ЁALL			                                                Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Retorno  ЁaRotina														Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁParametrosЁ< Vide Parametros Formais >									Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fImpFil(cFilialAnt)

	Local cDescFil
	Local cDet		:= ""
	Local nPos		:= 0
	Local aInfo		:= {}
	Local nx		:= 0
	
	If ( nPos	:= Ascan(aFil,{|x| x[1] == cFilialAnt}) ) == 0
		Return Nil
	EndIf
	fInfo(@aInfo,cFilialAnt)

	cDet := Space(1)
	Impr(cDet,"C")

	cDet := OemToAnsi(STR0010) + aFil[nPos,1] + " - " + aInfo[1] //"Filial : "
	Impr(cDet,"C")

	cDet := Space(1)
	Impr(cDet,"C")

	cDet :=  OemToAnsi(STR0026) //" T O T A L    D A    F I L I A L         " ### "Funcionarios: " 
	cDet += Space(126) + Transform(aFil[nPos,3],"@E 9,999,999.99") + " "
	cDet += Space(2) + Transform(aFil[nPos,4],"@E 9,999,999.99") + " "
	cDet += Space(3) + Transform(aFil[nPos,3]+aFil[nPos,4],"@E 9,999,999.99") + " "

	Impr(cDet,"C")

	cDet := Repl("-",220)
	Impr(cDet,"C")

	Impr("","P")

	//-- Imprime cabecalho da proxima filial
	fCabec(1,(cAliasQ)->RA_FILIAL)	//-- Filial
	If ( lCabec )
		fCabec(2,(cAliasQ)->RA_CC,cCcDesc)	//-- Centro de custo	
	EndIf

Return Nil

/*                                	
зддддддддддбддддддддддддддддбдддддбдддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    Ё fImpEmp    	ЁAutorЁ Mauricio Takakura Ё Data Ё05/11/2011Ё
цддддддддддеддддддддддддддддадддддадддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁImpressao do Totalizador por Empresa                        Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁSintaxe   Ё< Vide Parametros Formais >									Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Uso      ЁALL			                                                Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Retorno  ЁaRotina														Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁParametrosЁ< Vide Parametros Formais >									Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fImpEmp()

	Local cDet	:= ""
	Local nPos	:= 0
	Local aInfo	:= {}
	Local nx	:= 0

	If ( nPos	:= Ascan(aEmp,{|X| X[1] == cEmpAnt}) ) == 0
		Return Nil
	EndIf
	fInfo(@aInfo,aFil[len(aFil),1])

	cDet := Space(1)
	Impr(cDet,"C")

	cDet := OemToAnsi(STR0005)+aEmp[nPos,1]+" - "+aInfo[2] //"Empresa: "
	Impr(cDet,"C")

	cDet := Space(1)
	Impr(cDet,"C")

	cDet := OemToAnsi(STR0025)  //" T O T A L    D A    E M P R E S A       " ### "Funcionarios" 
	cDet += Space(126) + Transform(aEmp[nPos,3],"@E 9,999,999.99") + " "
	cDet += Space(2) + Transform(aEmp[nPos,4],"@E 9,999,999.99") + " "
	cDet += Space(3) + Transform(aEmp[nPos,3]+aEmp[nPos,4],"@E 9,999,999.99") + " "
	Impr(cDet,"C")

	cDet := Repl("-",220)
	Impr(cDet,"C")

	Impr("","F")

Return Nil

/*                                	
зддддддддддбддддддддддддддддбдддддбдддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    Ё fCabec			ЁAutorЁ Mauricio Takakura Ё Data Ё05/11/2011Ё
цддддддддддеддддддддддддддддадддддадддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁImpressao do Cabecalho                                      Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁSintaxe   Ё< Vide Parametros Formais >									Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Uso      ЁALL			                                                Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё Retorno  ЁaRotina														Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁParametrosЁ< Vide Parametros Formais >									Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function	fCabec(nTipo, cCod, cDesc)

	Local cDet	:= ""
	Local aInfo	:= {}

	If Empty(cCod)
		Return
	EndIf

	If nTipo == 1
		fInfo(@aInfo, cCod)
		cDet := OemToAnsi(STR0010) + cCod + " - " + aInfo[1] // " Filial : "
		Impr(cDet,"C")
		cDet := Space(1)
		Impr(cDet,"C")
	ElseIf nTipo == 2
		cDet := OemToAnsi(STR0011) + cCod + " - " + cDesc //"C.Custo: "
		Impr(cDet,"C")
		cDet := Space(1)
		Impr(cDet,"C")
	EndIf

Return

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁGPER008   ╨Autor  ЁLuis Artuso         ╨ Data Ё  10/17/12   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     Ё Efetua quebra na pagina para melhor visualizacao do relato-╨╠╠
╠╠╨          Ё rio.                                                       ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function fTestaLinha()

If Li > 55
	Li := 0
EndIf

Return

/*
{Protheus.doc} fPerBene
Verifica se perМodo estА aberto ou fechado 		
@author	raquel.andrade
@version	P12
@since	18/11/2021
*/
Static Function fPerBene(cBeneProc, cBenePer, cBeneNmpg, cBeneRot)
Local cFilRCH	   	:= xFilial("RCH")
Local lPerAberto	:= .T.

	DbSelectArea("RCH")
	RCH->( dbsetOrder( Retorder( "RCH" , "RCH_FILIAL+RCH_PROCES+RCH_PER+RCH_NUMPAG+RCH_ROTEIR" ) ) )
	RCH->( dbSeek( cFilRCH + cBeneProc + cBenePer + cBeneNmPg + cBeneRot, .F. ) )
	If RCH->( !Eof() )
		If !Empty(RCH->RCH_DTFECH)
		    lPerAberto  := .F.
		Else 
		    lPerAberto  := .T.
		EndIf
		dDataRef	:= RCH->RCH_DTFIM
	EndIf 

Return lPerAberto

/*
{Protheus.doc} GpR008Per
Valida existЙncia do perМodo - pergunte PerМodo no GPER008P.
@author	raquel.andrade
@version	P12
@since	18/11/2021
*/
User Function  GpR008Per()
Local aArea 	:= GetArea()
Local cFil 		:= FWxFilial("RCH")
Local lRet 		:= .T.	
Local cPeriodo 	:= &(ReadVar())

DbSelectArea("RCH")
DbSetOrder(RetOrder ("RCH", "RCH_FILIAL+RCH_PROCES+RCH_ROTEIR+RCH_PER"))

lRet := DbSeek(cFil+mv_par01+cRot+cPeriodo)

If !lRet
	MsgAlert(OemToAnsi(STR0037), OemToAnsi(STR0028)) //"Periodo nao encontrado!"###"Atencao"
Endif

RestArea(aArea) 

Return lRet

/*
{Protheus.doc} Gpr008SetVar
Seta variАvel cProcesso para filtro do F3 RCH - pergunte Processo no GPER008P.
@author	raquel.andrade
@version	P12
@since	18/11/2021
*/
User Function Gpr008SetVar()

cProcesso  	:= &(ReadVar())
cFilRCJ		:= RCJ->RCJ_FILIAL

Return .T.

/*
{Protheus.doc} fVerSCop
FunГЦo para pesquisar o saldo de coparticipaГЦo do funcionАrio
@author	Allyson Luiz Mesashi
@version	P12
@since	09/02/2022
*/
Static Function fVerSCop( cAntMat )

Local cAliasCop	:= ""
Local cPrefix	:= ""
Local nSaldoCop	:= 0

Default cAntMat	:= ""

If lMovAberto
	cAliasCop	:= "RHO"
	cPrefix		:= PrefixoCpo("RHO")
Else
	cAliasCop	:= "RHP"
	cPrefix		:= PrefixoCpo("RHP")
EndIf

If (cAliasCop)->( dbSeek( cAntMat ) )
	While (cAliasCop)->( !Eof() ) .And. (cAliasCop)->&(cPrefix+"_FILIAL")+(cAliasCop)->&(cPrefix+"_MAT") == cAntMat
		If (cAliasCop)->&(cPrefix+"_COMPPG") == cAnoMes .Or. (cAliasCop)->&(cPrefix+"_PERORI") == "2"
			If (cAliasCop)->&(cPrefix+"_TPLAN") == "1" .And. !Empty((cAliasCop)->&(cPrefix+"_SALDO"))
				nSaldoCop += (cAliasCop)->&(cPrefix+"_SALDO")
			EndIf
		EndIf
		(cAliasCop)->( dbSkip() )
	EndDo
EndIf

Return nSaldoCop

/*
{Protheus.doc} fImprCop
ImpressЦo do totalizador do saldo da coparticipaГЦo
@author	Allyson Luiz Mesashi
@version	P12
@since	09/02/2022
*/
Static Function fImprCop( nSaldoCop )

Local cDet			:= ""

Default nSaldoCop	:= 0

cDet := OemToAnsi(STR0038)//"  Saldo remanescente de coparticipaГЦo: R$ "
cDet += Transform(nSaldoCop, "@E 9,999,999.99") + " "
Impr( cDet, "C" )

Impr( Space(1), "C" )

Return

/*/{Protheus.doc} fChkCCT
//Verifica se a pergunta e campos da CCT existem
@author Leandro Drumond
@since 06/07/2022
/*/
Static Function fChkCCT()
Local lRet 		:= .F.
Local oSX1

If RHR->(ColumnPos("RHR_CODCCT")) > 0
	oSX1 := FWSX1Util():New()
	oSX1:AddGroup("GPER008P")
	oSX1:SearchGroup()
	
	If (Len(oSX1:aGrupo) >= 1 .And. Len(oSX1:aGrupo[1][2]) >= 23)
		lRet := .T.
	EndIf

	FreeObj(oSX1)
EndIf

Return lRet

/*/{Protheus.doc} fImpCCT
Inclui dados da CCT na segunda linha impressa
@author Leandro Drumond
@since 07/07/2022
/*/
Static Function fImpCCT(cCodCCT,cDet)
Local cAux 		:= ""

DEFAULT cDet 	:= ""

If !Empty(cCodCCT)
	cAux := Space(5) + STR0039 + cCodCCT //"ConvenГЦo Coletiva de Trabalho: "

	If !Empty(cDet)
		cDet := Replace(cDet, Space(Len(cAux)),cAux)
	Else
		Impr(cAux,"C")
	EndIf
EndIf

Return Nil
