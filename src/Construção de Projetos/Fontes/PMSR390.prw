/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "PMSR390.CH"
#DEFINE CRLF CHR(13) + CHR(10)

/*/{Protheus.doc} PMSR390
Relatorio de Rejeicoes

@return ${return}, ${return_description}

@author Microsiga
@since 24/04/12
@version 1.0
/*/
User Function PMSR390()
Local aArea	:= GetArea()
Local oReport	:= Nil
Local lValida	:= ValidaRel()

	If lValida

		oReport := ReportDef()

		oReport:PrintDialog()

	EndIf

	RestArea(aArea)

Return


/*/{Protheus.doc} ValidaRel
Funcao para validar as tabelas que serao utilizadas no relatorio.

@return ${return}, ${return_description}

@author Microsiga
@since 24/04/12
@version 1.0
/*/
Static Function ValidaRel()
Local aArea		:= GetArea()
Local aAreaX2		:= SX2->( GetArea() )
Local lRet 		:= .T.
Local cMsgAviso	:= ""
Local aTab			:= {}
Local nContTab	:= 0
Local nContFor	:= 0
Local cTitAviso	:= OemToAnsi( STR0001 )		//#"Relatório de Rejeições - Tabelas Utilizadas"

	dbSelectArea("SX2")
	dbSetOrder(1)

	If !dbSeek("ANB")
		lRet := .F.
		nContTab ++
		Aadd(aTab,"ANB")
	EndIf

	If !dbSeek("ANC")
		lRet := .F.
		nContTab ++
		Aadd(aTab,"ANC")
	EndIf

	If !dbSeek("AF9")
		lRet := .F.
		nContTab ++
		Aadd(aTab,"AF9")
	EndIf

	If !dbSeek("QI5")
		lRet := .F.
		nContTab ++
		Aadd(aTab,"QI5")
	EndIf

	If !dbSeek("QI2")
		lRet := .F.
		nContTab ++
		Aadd(aTab,"QI2")
	EndIf

	If !dbSeek("ADE")
		lRet := .F.
		nContTab ++
		Aadd(aTab,"ADE")
	EndIf

	If !lRet

		If nContTab == 1

			cMsgAviso := STR0002		//#"A tabela "
			cMsgAviso += aTab[1]
			cMsgAviso += STR0003		//#" não está corretamente criada no banco de dados."

		Else

			cMsgAviso := STR0004		//#"As tabelas "

			For nContFor:=1 to Len(aTab)
				If nContFor > 1
					cMsgAviso += ", "
				EndIf

				cMsgAviso += aTab[nContFor]

			Next nContFor

			cMsgAviso += STR0005		//#" não estão corretamente criadas no banco de dados."

		EndIf

		cMsgAviso := OemToAnsi( cMsgAviso )

		Aviso(cTitAviso , cMsgAviso , {STR0006})		//#"OK"

	EndIf

	RestArea(aAreaX2)
	RestArea(aArea)

Return lRet


/*/{Protheus.doc} ReportDef
Funcao para definicao Layout relatorio

@return ${return}, ${return_description}

@author Microsiga
@since 24/04/12
@version 1.0
/*/
Static Function ReportDef()
Local oReport		:= Nil 								 					//Objeto do relatorio
Local oBorder		:= Nil
Local cTitulo		:= OemToAnsi(STR0007)				 					//Titulo do relatorio #"Relatorio Rejeicoes"
Local cPerg		:= STR0008                         	   				//Descricao do Pergunte
Local cTitRept	:= STR0008				               					//Nome Relatorio #PMSR390"
Local nTipo		:= 0													//Tipo do relatorio: 01-Sustentacao / 02-Inovacao
Local lZLCRO		:= ADE->(FieldPos("ADE__ZLCRO") ) > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualizacao das perguntas utilizadas pelo relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTipo := Perg390(cPerg)

	If nTipo <> 0
		cTitulo += Iif( nTipo == 1  , STR0009 , STR0010 )			//#"-Sustentacao" #"-Inovacao"
		cTitulo := OemToAnsi(cTitulo)
	EndIf

	DEFINE REPORT oReport NAME cTitRept TITLE cTitulo PARAMETER cPerg ACTION {|oReport| ReportPrint(oReport,cPerg,nTipo)} DESCRIPTION OemtoAnsi(cTitulo)
	oReport:SetLandscape() //Padrao Paisagem
	oReport:lParamPage := .T. //Informa que tem parametros

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Diferencia grupo de perguntas dependendo do tipo de relatório³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Iif( nTipo == 1  , oReport:SetParam(cPerg+"A") , oReport:SetParam(cPerg+"B") )

	If nTipo == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Sustentacao   		    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		DEFINE SECTION oCabecalho		OF oReport 		TITLE OemToAnsi(STR0011)											//#"Sust_Projeto"
		DEFINE CELL NAME "PRODUTO"    	OF oCabecalho 	TITLE OemToAnsi(STR0012)		SIZE TamSX3("B1_COD")[1]			//#"Produto"
		DEFINE CELL NAME "CRITIC"  	   	OF oCabecalho 	TITLE OemToAnsi(STR0013)	 	SIZE 20							//#"Criticidade"
		DEFINE CELL NAME "CHAMADO"    	OF oCabecalho 	TITLE OemToAnsi(STR0014) 	SIZE TamSX3("ADE_CODIGO")[1]	//#"Chamado"
		DEFINE CELL NAME "FNC"	    	OF oCabecalho 	TITLE OemToAnsi(STR0015)		SIZE TamSX3("QI2_FNC")[1]		//#"FNC"
		DEFINE CELL NAME "RFNC"    	  	OF oCabecalho 	TITLE OemToAnsi(STR0016)		SIZE TamSX3("QI2_REV")[1]		//#"Rev. FNC"
		If lZLCRO 
			DEFINE CELL NAME "ROTINA"		OF oCabecalho 	TITLE OemToAnsi(STR0017)		SIZE TamSX3("ADE__ZLCRO")[1]	//#"Cod.Rotina"
		Else 
			DEFINE CELL NAME "ROTINA"		OF oCabecalho 	TITLE OemToAnsi(STR0017)		SIZE 20						//#"Cod.Rotina"
		EndIf
			
		DEFINE CELL NAME "DTSLO"    	OF oCabecalho 	TITLE OemToAnsi(STR0018)		SIZE TamSX3("QI2_CONPRE")[1]	//#"Data SLO"
		oCabecalho:SetLineStyle() //Impressao das celulas em linha

		DEFINE SECTION oDetalhes			OF oReport 	TITLE OemToAnsi(STR0019)												//#"Sust_Detalhes"
		DEFINE CELL NAME "TIPO"    		OF oDetalhes 	TITLE OemToAnsi(STR0020)			SIZE TamSX3("ANC_TIPERR")[1]	//#"Tipo Rejeicao"
		DEFINE CELL NAME "MOTIVO"		OF oDetalhes 	TITLE OemToAnsi(STR0021)			SIZE 30							//#"Motivo  Rejeicao"
		DEFINE CELL NAME "DTREJ"	 		OF oDetalhes 	TITLE OemToAnsi(STR0022)			SIZE TamSX3("QI5_REALIZ")[1]	//#"Data Rejeicao"
		DEFINE CELL NAME "ACAO"		  	OF oDetalhes 	TITLE OemToAnsi(STR0023)			SIZE TamSX3("QI5_CODIGO")[1]	//#"Cod. Acao"
		DEFINE CELL NAME "RVACAO"	 	OF oDetalhes 	TITLE OemToAnsi(STR0024)			SIZE TamSX3("QI5_REV")[1]		//#"Rev. Cod. Acao"
		DEFINE CELL NAME "TIORI"		 	OF oDetalhes 	TITLE OemToAnsi(STR0025)			SIZE TamSX3("QI5_MAT")[1]		//#"TI Origem"
		DEFINE CELL NAME "ETORI"			OF oDetalhes 	TITLE OemToAnsi(STR0026)		   	SIZE TamSX3("ANC_ETPEXE")[1]	//#"Etapa Origem"
		DEFINE CELL NAME "TIDES"	  		OF oDetalhes 	TITLE OemToAnsi(STR0027)			SIZE TamSX3("QI5_MAT")[1]		//#"TI Destino"
		DEFINE CELL NAME "ETDES"		 	OF oDetalhes 	TITLE OemToAnsi(STR0028)			SIZE TamSX3("ANC_ETPREJ")[1]	//#"Etapa Destino"
		DEFINE CELL NAME "STATUS"		OF oDetalhes 	TITLE OemToAnsi(STR0029)			SIZE 20							//#"Status"
		DEFINE CELL NAME "DTCONCL"		OF oDetalhes 	TITLE OemToAnsi(STR0030)			SIZE TamSX3("QI2_CONREA")[1]	//#"Data Conclusao"
		DEFINE CELL NAME "DTSLO"			OF oDetalhes 	TITLE OemToAnsi("")	   	  		SIZE TamSX3("QI2_CONPRE")[1]
		DEFINE CELL NAME "DTSLO"			OF oDetalhes 	TITLE OemToAnsi("")	   	  		AUTO SIZE

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Retira a borda da secao detalhes³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oBorder := TRBorder():New(oReport,5,,0,)
		oDetalhes:oHBrdBottom := oBorder
		oDetalhes:oHBrdLeft := oBorder
		oDetalhes:oHBrdRight := oBorder
		oDetalhes:oHBrdTop  := oBorder

	ElseIf nTipo == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Inovacao				 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		DEFINE SECTION oCabecalho  		OF oReport 	TITLE OemToAnsi(STR0031)											//#"Inov_Projeto"
		DEFINE CELL NAME "PROJETO"    	OF oCabecalho TITLE OemToAnsi(STR0032) 	SIZE TamSX3("AF8_PROJET")[1]	//#"Projeto"
		DEFINE CELL NAME "REQUISITO"   	OF oCabecalho TITLE OemToAnsi(STR0033)		SIZE TamSX3("AF9_EDTPAI")[1]	//#"Tarefa Requisito"
		DEFINE CELL NAME "DTFINAL"    	OF oCabecalho TITLE OemToAnsi(STR0034)		SIZE TamSX3("AFC_FINISH")[1]	//#"Data Finalizacao"
		DEFINE CELL NAME "DESCREQ"		OF oCabecalho TITLE OemToAnsi(STR0035)		SIZE TamSX3("AFC_DESCRI")[1]	//#"Desc. Requisito"
		oCabecalho:SetLineStyle() //Impressao das celulas em linha


		DEFINE SECTION oDetalhes			OF oReport 	TITLE OemToAnsi(STR0036)					//#"Inov_Detalhes"
		DEFINE CELL NAME "TIPO"    		OF oDetalhes 	TITLE OemToAnsi(STR0037)		AUTO SIZE 	//#"Tipo Rejeicao"
		DEFINE CELL NAME "MOTIVO"		OF oDetalhes 	TITLE OemToAnsi(STR0038)		SIZE 40	//#"Motivo  Rejeicao"
		DEFINE CELL NAME "DTREJ"			OF oDetalhes 	TITLE OemToAnsi(STR0039)		AUTO SIZE 	//#"Data Rejeicao"
		DEFINE CELL NAME "TIORI"		  	OF oDetalhes 	TITLE OemToAnsi(STR0025)		AUTO SIZE 	//#"TI Origem"
		DEFINE CELL NAME "TARORI"		OF oDetalhes 	TITLE OemToAnsi(STR0040)		AUTO SIZE 	//#"Tarefa Origem"
		DEFINE CELL NAME "DTARORI"		OF oDetalhes 	TITLE OemToAnsi(STR0041)		SIZE TamSX3("AF9_DESCRI")[1]	//#"Desc. Tarefa Origem"
		DEFINE CELL NAME "TIDES"		  	OF oDetalhes 	TITLE OemToAnsi(STR0027)		AUTO SIZE 	//#"TI Destino"
		DEFINE CELL NAME "TARDES"		OF oDetalhes 	TITLE OemToAnsi(STR0042)		AUTO SIZE 	//#"Tarefa Destino"
		DEFINE CELL NAME "DTARDES"		OF oDetalhes 	TITLE OemToAnsi(STR0043)		SIZE TamSX3("AN8_DATA")[1]	//#"Desc. Tarefa Destino"
		DEFINE CELL NAME "STATUS"		OF oDetalhes 	TITLE OemToAnsi(STR0029)		SIZE 12	//#"Status"
		DEFINE CELL NAME "DTCONCL"		OF oDetalhes 	TITLE OemToAnsi(STR0030)		AUTO SIZE	//#"Data Conclusao"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Retira a borda da secao detalhes³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oBorder := TRBorder():New(oReport,5,,0,)
		oDetalhes:oHBrdBottom := oBorder
		oDetalhes:oHBrdLeft   := oBorder
		oDetalhes:oHBrdRight  := oBorder
		oDetalhes:oHBrdTop    := oBorder

	EndIf

Return oReport


/*/{Protheus.doc} ReportPrint

Impressao do Relatorio

@return ${return}, ${return_description}

@author Microsiga
@since 24/04/12
@version 1.0
/*/
Static Function ReportPrint(oReport,cPerg,nTipo)
Local oCabecalho	:= oReport:Section(1)		 	 			//Objeto Cabecalho
Local oDetalhes	:= oReport:Section(2)		   				//Objeto Detalhes
Local lTipoSust	:= Iif(nTipo == 1, .T. , .F. )	  			//Indica se o layout eh de sustentacao
Local aParam		:= MontaParam(nTipo)							//Array com os parametros
Local cDesc		:= ""                        				//Descricao cabecalho do relatorio
Local cQuery		:= ""						 	 				//Query busca dados relatorio
Local cAlias		:= GetNextAlias()          	  				//Alias para query
Local cProduto	:= ""											//Produto impressao atual
Local cProjeto	:= ""											//Projeto impressao atual
Local cRequisito	:= ""											//Requisito atual
Local cSubReq		:= ""											//SubRequisito atual
Local cDtSLO		:= ""											//Data SLO
Local cChamado	:= ""											//Chamado atual
Local cTIOri		:= ""											//TI Origem
Local cTIDest		:= ""											//TI Destino
Local cDtFinal	:= ""							 				//Data Final cabecalho do projeto
Local lDetProj	:= .F.							  				//Variavel de Controle finalizar Detalhes Projeto
Local cDtRej		:= ""						  					//Data rejeicao
Local cCtrolData	:= ""											//Controle da data de rejeicao
Local cCtrlSbReq	:= ""											//Controle do SubRequisito de rejeicao
Local cMemo		:= ""											//Conteudo campo Memo
Local cKey			:= ""											//Chave de pesquisa
Local cDescTar	:= ""											//Descricao da tarefa
Local cDtTar		:= ""											//Data conclusao tarefa
Local cStatus		:= ""											//Status da tarefa
Local nRow 		:= 0									  		//Linha atual
Local nCol 		:= 0                          				//Coluna Atual
Local nTotChan	:= 0                       	 				//Total de Chamados/Requisitos rejeitados
Local nTotal		:= 0                        				//Total Geral de Rejeitados
Local nTotTipo	:= 0											//Total de Tipos de Rejeicao
Local cTot1		:= ""                       				//String com o total de Chamados/Requisitos rejeitados
Local cTot2		:= ""	 										//String com o total Geral rejeitados
Local cTot3		:= ""	 										//String com o total tipos de rejeicao
Local lDados		:= .F.											//Indica se há dados para serem impressos.
Local nCountFor	:= 0   	  	              				//Contador For
Local aRejeicoes	:= {}											//Array com os tipos de rejeicoes e totalizador
Local lZLCRO		:= ADE->(FieldPos("ADE__ZLCRO") ) > 0


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Montagem/Impressao do Relatorio³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lTipoSust
		cQuery := MtQuerySust(aParam)
	Else
		cQuery := MtQueryInov(aParam)
	EndIf

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias, .T., .T.)

	If (cAlias)->( !EOF() )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Montagem/Impressao cabecalho do relatorio³
		//³Caso nao seja importacao para Excel		  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If oReport:nDevice <> 4

			If Len(aParam) > 0 .AND. ( aParam[1] == 1 )
				cDesc := STR0044 + ALLTRIM( aParam[2] ) + STR0045 +   ALLTRIM( aParam[3] )		//#"Codigo da Area: " #" ate: "
				cDesc += Space(50) + STR0046 + aParam[4] 	//#"Etapa de: "
				cDesc += Space(50) + STR0047 + aParam[5]	//#"Etapa Para: "
			ElseIf Len(aParam) > 0
				cDesc := STR0048 + ParamInov(01,aParam[2])	//#"Projetos: "
				cDesc += Space(50) + STR0049 + aParam[3]		//#"Tarefa de: "
				cDesc += Space(50) + STR0050 + aParam[4]		//#"Tarefa ate: "
			EndIf

			nRow := oReport:Row()
			nCol := oReport:Col()
			oReport:SkipLine()
			oReport:PrintText(cDesc,nRow,nCol+10,,,,)
			oReport:SkipLine()

		EndIf

		TipoRejeic(@aRejeicoes)

		If lTipoSust

			While (cAlias)->( !EOF() )

				If !ValidTIDest(01,(cAlias)->CODACAO,(cAlias)->REV,(cAlias)->ETPDEST,;
						aParam[16])
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³O TI destino nao esta no intervalo informado³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					(cAlias)->( dbSkip() )
					Loop
				ElseIf !lDados
					lDados := .T.
				EndIf

				If ( cProduto != (cAlias)->PRODUTO ) .OR. ( cChamado != (cAlias)->CHAMADO )

					If lDetProj
						oDetalhes:Finish()
						lDetProj := .F.
					EndIf

					cProduto := (cAlias)->PRODUTO
					cChamado := (cAlias)->CHAMADO

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Cabecalho Sustentacao³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oReport:SkipLine()

					oCabecalho:Init()

					oCabecalho:Cell("PRODUTO"):SetValue( ALLTRIM( (cAlias)->PRODUTO ) )
					oCabecalho:Cell("CRITIC"):SetValue( MontaSev( (cAlias)->CRIT ) )
					oCabecalho:Cell("CHAMADO"):SetValue( ALLTRIM( (cAlias)->CHAMADO ) )
					oCabecalho:Cell("FNC"):SetValue( ALLTRIM( (cAlias)->FNC ) )
					oCabecalho:Cell("RFNC"):SetValue( ALLTRIM( (cAlias)->REVFNC ) )

					If lZLCRO
						oCabecalho:Cell("ROTINA"):SetValue( ALLTRIM( (cAlias)->ROTINA ) )
					EndIf

					cDtSLO  := StoD((cAlias)->SLO)
					cDtSLO  := Iif( !Empty(cDtSLO) , DtoC(cDtSLO)  , "" )
					oCabecalho:Cell("DTSLO"):SetValue( cDtSLO )

					oReport:SkipLine()
					oReport:Fatline()

					oCabecalho:PrintLine()

					oReport:FatLine()

					oCabecalho:Finish()

					nTotChan++

					cCtrolData := ""
					cCtrolRev  := ""

				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Detalhes Sustentacao ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oDetalhes:Init()

				If !lDetProj
					lDetProj	:= .T.
				EndIF

				oDetalhes:Cell("TIPO"):SetValue( (cAlias)->TERRO )

				cMemo := BuscaMemo(01,(cAlias)->PROJET,(cAlias)->REVISA,(cAlias)->TAREFA,;
					(cAlias)->DATAR)
				oDetalhes:Cell("MOTIVO" ):SetValue( cMemo )

				cDtRej  := StoD((cAlias)->DATAR)
				cDtRej  := Iif( !Empty(cDtRej) , DtoC(cDtRej)  , "" )
				oDetalhes:Cell("DTREJ"):SetValue( cDtRej )

				oDetalhes:Cell("ACAO"):SetValue( ALLTRIM( (cAlias)->CODACAO ) )
				oDetalhes:Cell("RVACAO"):SetValue( ALLTRIM( (cAlias)->REV ) )

				cTIOri := ALLTRIM( (cAlias)->TIORI )
				cTIOri := SubStr ( cTIOri , 5 , Len(cTIOri) )
				oDetalhes:Cell("TIORI"):SetValue( cTIOri )

				oDetalhes:Cell("ETORI"):SetValue( ALLTRIM( (cAlias)->ETPORI ) )

				cTIDest := BuscaRec( 01, (cAlias)->CODACAO,(cAlias)->REV,(cAlias)->ETPDEST )
				oDetalhes:Cell("TIDES"):SetValue( cTIDest )

				oDetalhes:Cell("ETDES"):SetValue( ALLTRIM( (cAlias)->ETPDEST ) )

				cDtTar  := StoD((cAlias)->CONCL)
				cDtTar  := Iif( !Empty(cDtTar) , DtoC(cDtTar)  , "" )

				cStatus := Iif( Empty(cDtTar) , STR0051 , STR0052  ) 		//#"Em aberto" #"Concluido"

				oDetalhes:Cell("STATUS"):SetValue( cStatus )
				oDetalhes:Cell("DTCONCL"):SetValue( cDtTar )

				oDetalhes:PrintLine()

				TipoRejeic(@aRejeicoes,(cAlias)->TERRO,,lDados)

				If cCtrolData <> (cAlias)->DATAR

					nTotal++
					cCtrolData := (cAlias)->DATAR
					cCtrolRev	  := (cAlias)->REV

				ElseIf (cCtrolData == (cAlias)->DATAR) .AND. ( cCtrolRev <> (cAlias)->REV )
					nTotal++
					cCtrolRev  := (cAlias)->REV

				EndIf

				nTotTipo++

				(cAlias)->( dbSkip() )

			End

		Else

			While (cAlias)->( !EOF() )

				If !ValidTIDest(02,(cAlias)->PROJET,(cAlias)->TFDEST,, ;
						aParam[8])
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³O TI destino nao esta no intervalo informado³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					(cAlias)->( dbSkip() )
					Loop
				ElseIf !lDados
					lDados := .T.
				EndIf

				cSubReq := AllTrim( (cAlias)->TFORI )
				cSubReq := SubStr( cSubReq,1, ( Len(cSubReq) - 3 ) )

				If ( cProjeto != (cAlias)->PROJET ) .OR. ( cRequisito != (cAlias)->REQ ) .OR. ( cCtrlSbReq != cSubReq  )

					If lDetProj
						oDetalhes:Finish()
						lDetProj := .F.
					EndIf

					cProjeto   := (cAlias)->PROJET
					cRequisito := (cAlias)->REQ
					cCtrlSbReq := AllTrim( (cAlias)->TFORI )
					cCtrlSbReq := SubStr( cCtrlSbReq ,1, ( Len(cCtrlSbReq) - 3 ) )

					cKey := xFilial("AFC")
					cKey += Pad((cAlias)->PROJET,TamSX3("AFC_PROJET")[1])
					cKey += Pad((cAlias)->REVISA,TamSX3("AFC_REVISA")[1])
					cKey += Pad( (cAlias)->REQ , TamSX3("AFC_EDT")[1] )

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Cabecalho Inovacao³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oReport:SkipLine(2)

					oCabecalho:Init()

					oCabecalho:Cell("PROJETO"):SetValue( (cAlias)->PROJET )
					oCabecalho:Cell("REQUISITO"):SetValue( ALLTRIM( (cAlias)->REQ ) )

					cDtFinal := Posicione("AFC",1,cKey,"AFC_FINISH")
					cDtFinal := Iif( Empty(cDtFinal) , ""  , cDtFinal )
					oCabecalho:Cell("DTFINAL"):SetValue( cDtFinal )
					oCabecalho:Cell("DESCREQ"):SetValue( ALLTRIM( Posicione("AFC",1,cKey,"AFC_DESCRI") ) )

					oReport:SkipLine()
					oReport:FatLine()

					oCabecalho:PrintLine()

					oReport:FatLine()

					oCabecalho:Finish()

					nTotChan++

					cCtrolData := ""
					cCtrolRev  := ""

				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Detalhes Inovacao ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oDetalhes:Init()

				If !lDetProj
					lDetProj	:= .T.
				EndIF

				oDetalhes:Cell("TIPO"):SetValue( (cAlias)->TREJ )

				cMemo := BuscaMemo(02,(cAlias)->PROJET,(cAlias)->REVISA,(cAlias)->TFORI,(cAlias)->DATAR)

				oDetalhes:Cell("MOTIVO" ):SetValue( cMemo )

				cDtRej  := StoD((cAlias)->DATAR)

				cDtRej  := Iif( !Empty(cDtRej) , DtoC(cDtRej)  , "" )

				oDetalhes:Cell("DTREJ"):SetValue( cDtRej )
				oDetalhes:Cell("TIORI"):SetValue( (cAlias)->TIORI )
				oDetalhes:Cell("TARORI"):SetValue( (cAlias)->TFORI )

				cKey := xFilial("AF9")
				cKey += Pad((cAlias)->PROJET,TamSX3("AF9_PROJET")[1])
				cKey += Pad((cAlias)->REVISA,TamSX3("AF9_REVISA")[1])
				cKey += Pad((cAlias)->TFORI, TamSX3("AF9_TAREFA")[1])
				cDescTar := Posicione("AF9",1,cKey,"AF9_DESCRI")

				oDetalhes:Cell("DTARORI"):SetValue( ALLTRIM(cDescTar) )

				cTIDest := BuscaRec(02,(cAlias)->PROJET ,(cAlias)->TFDEST)

				oDetalhes:Cell("TIDES"):SetValue( cTIDest )
				oDetalhes:Cell("TARDES"):SetValue( (cAlias)->TFDEST )

				cKey := xFilial("AF9")
				cKey += Pad((cAlias)->PROJET,TamSX3("AF9_PROJET")[1])
				cKey += Pad((cAlias)->REVISA,TamSX3("AF9_REVISA")[1])
				cKey += Pad((cAlias)->TFDEST, TamSX3("AF9_TAREFA")[1])
				cDescTar := Posicione("AF9",1,cKey,"AF9_DESCRI")
				oDetalhes:Cell("DTARDES"):SetValue( ALLTRIM(cDescTar) )

				cDtTar := ""

				If VAL( (cAlias)->STATUSTAR ) == 3 //Somente tarefas concluidas
					cDtTar  := Posicione("AF9",1,cKey,"AF9_DTATUF")
				EndIf

				cDtTar  :=  Iif( !Empty(cDtTar) , DtoC(cDtTar)  , "" )

				If !Empty(cDtRej) .AND. !Empty(cDtTar) .AND. !(CtoD(cDtTar) > CtoD(cDtRej))
					cDtTar := ""
				EndIf

				cStatus := Iif( Empty(cDtTar) , STR0051 , STR0052  ) 		//#"Em aberto" #"Concluido"

				oDetalhes:Cell("STATUS"):SetValue( cStatus )
				oDetalhes:Cell("DTCONCL"):SetValue( cDtTar )

				oDetalhes:PrintLine()

				TipoRejeic(@aRejeicoes,(cAlias)->TREJ,,lDados)

				If cCtrolData <> (cAlias)->DATAR

					nTotal++
					cCtrolData := (cAlias)->DATAR
					cCtrolRev  := (cAlias)->REVISA

				ElseIf (cCtrolData == (cAlias)->DATAR) .AND. ( cCtrolRev <> (cAlias)->REVISA )
					nTotal++
					cCtrolRev  := (cAlias)->REVISA

				EndIf

				nTotTipo++

				(cAlias)->( dbSkip() )

			End

		EndIf

		If lDetProj
			oDetalhes:Finish()
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Montagem/Impressao totais do relatorio³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lTipoSust
			cTot1 := STR0053 + CValToChar( nTotChan )		//#"Total de Chamados Rejeitados: "
			cTot2 := STR0054 + CValToChar( nTotal )		//#"Total Geral de Rejeitados: "
			cTot3 := STR0055 + CValToChar( nTotTipo )	 	//#"Total por tipo de Rejeicao: "
		Else
			cTot1 := STR0056 + CValToChar( nTotChan )		//#"Total de Requisitos Rejeitados: "
			cTot2 := STR0057 + CValToChar( nTotal )		//#"Total Geral de Rejeitados: "
			cTot3 := STR0058 + CValToChar( nTotTipo )	 	//#"Total por tipo de Rejeicao: "
		EndIf

		oReport:SkipLine()
		oReport:ThinLine()
		nRow := oReport:Row()
		nCol := oReport:Col()
		oReport:PrintText(cTot1,nRow,nCol,,,,)

		oReport:SkipLine()
		oReport:ThinLine()
		nRow := oReport:Row()
		nCol := oReport:Col()
		oReport:PrintText(cTot2,nRow,nCol,,,,)

		oReport:SkipLine()
		oReport:ThinLine()
		nRow := oReport:Row()
		nCol := oReport:Col()
		oReport:PrintText(cTot3,nRow,nCol,,,,)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Montagem/Impressao da Legenda ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:SkipLine()
		oReport:ThinLine()

		TipoRejeic(@aRejeicoes,,nTotTipo,lDados)

		For nCountFor := 1 to Len(aRejeicoes)

			oReport:SkipLine()
			nRow := oReport:Row()
			nCol := oReport:Col()

			oReport:PrintText(aRejeicoes[nCountFor],nRow,nCol,,,,)

		Next nCountFor

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Define a barra de progresso para impressao do relatorio³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:SetMeter(300)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta a string de Processos para Impressao  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oCabecalho:Print()
		oDetalhes:Print()

	EndIf

	(cAlias)->( dbCloseArea() )

FATPDLogUser("PMSR390")
Return


/*/{Protheus.doc} MontaParam
Funcao para montagem dos parametros para serem utilizados no relatorio.                                               º±±

@param nTipo, numerico, define o tipo de relatorio
			 1- Manutençao
			 2- Inovacao

@return ${return}, ${return_description}

@author Microsiga
@since 24/04/12
@version 1.0
/*/
Static Function MontaParam(nTipo)
Local aParam := {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inclusão dos parametros - Sustentacao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTipo == 1

		Aadd(aParam,nTipo)
		Aadd(aParam,MV_PAR01)
		Aadd(aParam,MV_PAR02)
		Aadd(aParam,MV_PAR03)
		Aadd(aParam,MV_PAR04)
		Aadd(aParam,MV_PAR05)
		Aadd(aParam,MV_PAR06)
		Aadd(aParam,MV_PAR07)
		Aadd(aParam,MV_PAR08)
		Aadd(aParam,MV_PAR09)
		Aadd(aParam,MV_PAR10)
		Aadd(aParam,MV_PAR11)
		Aadd(aParam,MV_PAR12)
		Aadd(aParam,MV_PAR13)
		Aadd(aParam,MV_PAR14)
		Aadd(aParam,MV_PAR15)
		Aadd(aParam,MV_PAR16)
		Aadd(aParam,MV_PAR17)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inclusão dos parametros - Inovacao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Else

		Aadd(aParam,nTipo)
		Aadd(aParam,MV_PAR01)
		Aadd(aParam,MV_PAR02)
		Aadd(aParam,MV_PAR03)
		Aadd(aParam,MV_PAR04)
		Aadd(aParam,MV_PAR05)
		Aadd(aParam,MV_PAR06)
		Aadd(aParam,MV_PAR07)
		Aadd(aParam,MV_PAR08)
		Aadd(aParam,MV_PAR09)

	EndIF

Return aParam


/*/{Protheus.doc} MtQuerySust

Funcao para montagem da Query - Layout Sustentacao

@param aParam, array, contem os parametros de filtro do relatorio.

@return ${return}, ${return_description}

@author Microsiga
@since 05/02/12
@version 1.0
/*/
Static Function MtQuerySust(aParam)
Local cRet			:= ""
Local aProdDe		:= {}
Local aProdAte	:= {}
Local aTIOrigem	:= {}
Local aEtapa		:= {}
Local lZLCRO		:= ADE->(FieldPos("ADE__ZLCRO") ) > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Parametros Pergunte - Sustentacao                                              		   ³
	//³                                                                               		   ³
	//³aParam[1]: Tipo Relatorio	aParam[7]: Produto Ate:		aParam[13]: Rejeicao De:	   ³
	//³aParam[2]: Area De:			aParam[8]: Criticidade:		aParam[14]: Rejeicao Ate:      ³
	//³aParam[3]: Area Ate:			aParam[9]: Chamado De:		aParam[15]: TI Origem:         ³
	//³aParam[4]: Etapa De:	   	aParam[10]: Chamado Ate:	aParam[16]: TI Destino:   	       ³
	//³aParam[5]: Etapa Para:		aParam[11]: Rotina De:		aParam[17]: Tipo Rejeicao De:  ³
	//³aParam[6]: Produto De:		aParam[12]: Rotina Ate:		aParam[18]: Tipo Rejeicao Ate: ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet := "SELECT"
	cRet += " QI2.QI2_CODPRO PRODUTO, ADE.ADE_CODIGO CHAMADO ,ANC.ANC_TIPERR TERRO, QI5.QI5_REALIZ DATAR, QI5.QI5_CODIGO CODACAO,QI5.QI5_REV REV "
	cRet += ", QI5.QI5_MAT TIORI, ANC.ANC_ETPEXE ETPORI, ANC.ANC_ETPREJ ETPDEST, QI5.QI5_PROJET PROJET, QI5.QI5_REV REV, QI5.QI5_REVISA REVISA "
	cRet += ", QI5.QI5_TAREFA TAREFA, QI2.QI2_FNC FNC, QI2.QI2_REV REVFNC, QI2.QI2_CONPRE SLO, ADE.ADE_SEVCOD CRIT, QI2.QI2_CONREA CONCL "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Campo customizado para informar a rotina³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lZLCRO
		cRet += ", ADE.ADE__ZLCRO ROTINA "
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³QI5 - Acao Corretiva x Acoes ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += " FROM " + RetSQLName("QI5") + " QI5 "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³QI2 - Nao Conformidades      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += " INNER JOIN " + RetSQLName("QI2") + " QI2 ON "
	cRet += " ( QI2.QI2_FILIAL = '"+xFilial("QI2")+"' "
	cRet += " AND QI2.QI2_CODACA = QI5.QI5_CODIGO ) "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ANC - Motivos Rejeicoes de Planos ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += " LEFT JOIN " + RetSQLName("ANC") + " ANC ON	 "
	cRet += " (ANC.ANC_FILIAL = '"+xFilial("ANC")+"' "
	cRet += " AND ANC.ANC_PROJET = QI5.QI5_PROJET "
	cRet += " AND ANC.ANC_TAREFA = QI5.QI5_TAREFA) "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ADE - Chamados de Help Desk ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += " INNER JOIN " + RetSQLName("ADE") + " ADE ON "
	cRet += " (ADE.ADE_FILIAL = '"+xFilial("ADE")+"' "
	cRet += " AND ADE.ADE_CODSB1 = QI2.QI2_CODPRO "
	cRet += " AND ADE.ADE_FNC = QI2.QI2_FNC ) "

	//ÚÄÄÄÄÄÄÄÄÄ¿
	//³Condicoes³
	//ÀÄÄÄÄÄÄÄÄÄÙ
	cRet += " WHERE QI5.QI5_FILIAL = '" + xFilial("QI5") + "' "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Rejeicao de / Rejeicao ate³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam) >= 14
		If aParam[13] = aParam[14]
			cRet += " AND QI5.QI5_REALIZ = '" + DtoS(aParam[13]) + "' "
		Else
			cRet += " AND QI5.QI5_REALIZ BETWEEN '" + DtoS(aParam[13]) + "' AND '" + DtoS(aParam[14]) + "' "
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄ¿
	//³Etapa de ³
	//ÀÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam) >= 4 .AND. !Empty(aParam[4])
		aEtapa := Separa(aParam[4],";",.F.)
		cRet += " AND QI5.QI5_TPACAO " + ParamSust("03",aEtapa)
	EndIf

	cRet += " AND QI5.QI5_STATUS = '4' "
	cRet += " AND QI5.QI5_REJEIT = 'S' "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³TI de origem ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam) >= 15 .AND. !Empty(aParam[15])
		aTIOrigem	:= Separa(aParam[15],";",.F.)
		cRet += ParamSust("04",aTIOrigem)
	EndIf

	cRet += " AND QI5.D_E_L_E_T_ = ' ' "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Area de / Area ate³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( Len(aParam) >= 3)
		cRet += " AND QI2.QI2_DESDEP " + ParamSust("01",{aParam[2],aParam[3],"QI2_DESDEP"})
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Produto de / Produto ate³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( Len(aParam) >= 7)
		aProdDe	:= Separa(aParam[6],";",.F.)
		aProdAte	:= Separa(aParam[7],";",.F.)

		cRet += " AND QI2.QI2_CODPRO " + ParamSust("02",{aProdDe,aProdAte})

	EndIf

	cRet += " AND QI2.D_E_L_E_T_ = ' ' "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tipo de Erro de / Tipo de Erro Ate:³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( Len(aParam) >= 18) .AND. !Empty(aParam[17]) .AND. !Empty(aParam[18]) .AND. !( "ZZZ" $ Upper(aParam[18]))
		cRet += " AND ANC.ANC_TIPERR " + ParamSust("01",{aParam[17],aParam[18],"ANC_TIPERR"})
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Etapa para ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam) >= 5 .AND. !Empty(aParam[5]) .AND. !( "ZZZZ" $ Upper(aParam[5])  )
		aEtapa := Separa(aParam[5],";",.F.)
		cRet += " AND ANC.ANC_ETPREJ " + ParamSust("03",aEtapa)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Chamado de / Chamado Ate:³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( Len(aParam) >= 10)
		cRet += " AND ADE.ADE_CODIGO " + ParamSust("01",{aParam[09],aParam[10],"ADE_CODIGO"})
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criticidade ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( Len(aParam) >= 8) .AND. !Empty(aParam[8]) .AND. aParam[8] != 5
		If aParam[8] == 1
			cRet += " AND ADE.ADE_SEVCOD IN ('" + CValToChar(aParam[8]) + "','" + CValToChar(aParam[8]+1) + "') "
		Else
			cRet += " AND ADE.ADE_SEVCOD = '" + CValToChar(aParam[8]+1) + "' "
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Rotina de / Rotina Ate:³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lZLCRO .AND. ( Len(aParam) >= 12 )
		cRet += " AND ADE.ADE__ZLCRO " + ParamSust("01",{aParam[11],aParam[12],"ADE__ZLCRO"})
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Ordenar por: Produto, Chamado e Data³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += " ORDER BY ADE.ADE_CODSB1, ADE.ADE_CODIGO , QI5.QI5_REALIZ "

Return cRet


/*/{Protheus.doc} MtQueryInov
Funcao para montagem da Query - Layout Inovacao

@param aParam, array, (Descrição do parâmetro)
@return ${return}, ${return_description}

@author Microsiga
@since 05/02/12
@version 1.0
/*/
Static Function MtQueryInov(aParam)
Local cRet			:= ""
Local cProjet		:= ""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Parametros Pergunte - Inovacao                                 ³
	//³                                                      	      ³
	//³aParam[1]: Tipo Relatorio		aParam[6]: Rejeicao Ate:      ³
	//³aParam[2]: Projetos				aParam[7]: TI Origem:         ³
	//³aParam[3]: Tarefa De:			aParam[8]: TI Destino:		  ³
	//³aParam[4]: Tarefa Ate:			aParam[9]: Tipo Rejeicao De:  ³
	//³aParam[5]: Rejeicao De:			aParam[10]: Tipo Rejeicao Ate:³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cRet := "SELECT AN8.AN8_PROJET PROJET, ANB.ANB_TIPERR TREJ, ANB.ANB_MOTIVO MOTIVO, AN8.AN8_DATA DATAR, ANB.ANB_EXEC TIORI "
	cRet += ",AN8.AN8_TRFORI TFORI, AN8.AN8_TAREFA TFDEST, AN8.AN8_REVISA REVISA, AF9.AF9_EDTPAI REQ, AN8.AN8_STATUS STATUSTAR "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³AN8 - Historico de Rejeicoes ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += " FROM " + RetSQLName("AN8") + " AN8 "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ANB - Motivos das Rejeicoes³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += "LEFT JOIN " + RetSQLName("ANB") + " ANB ON "
	cRet += "(	ANB.ANB_FILIAL = '"+xFilial("ANB")+"' "
	cRet += " AND ANB.ANB_PROJET = AN8.AN8_PROJET "
	cRet += " AND ANB.ANB_REVISA = AN8.AN8_REVISA "
	cRet += " AND ANB.ANB_TAREFA = AN8.AN8_TAREFA "
	cRet += " AND ANB.ANB_DATA = AN8.AN8_DATA "
	cRet += " AND ANB.ANB_HORA = AN8.AN8_HORA) "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³AF9 - Tarefas do Projeto   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += "INNER JOIN " + RetSQLName("AF9") + " AF9 ON "
	cRet += " (AF9.AF9_FILIAL = '"+xFilial("AF9")+"' "
	cRet += " AND AF9.AF9_PROJET = AN8.AN8_PROJET "
	cRet += " AND AF9.AF9_REVISA = AN8.AN8_REVISA "
	cRet += " AND AF9.AF9_TAREFA = AN8.AN8_TAREFA) "

	//ÚÄÄÄÄÄÄÄÄÄ¿
	//³Condicoes³
	//ÀÄÄÄÄÄÄÄÄÄÙ
	cRet += " WHERE AN8.AN8_FILIAL = '" + xFilial("AN8") +"' "

	//ÚÄÄÄÄÄÄÄÄÄ¿
	//³Projetos ³
	//ÀÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam)>=2 .AND. !Empty(aParam[2])
		cProjet := ParamInov(02,aParam[2])
		cRet += " AND AN8.AN8_PROJET IN ( " + cProjet +" ) "
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tarefa de / Tarefa ate ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam)>=4
		cRet += " AND " + ParamInov(03,,{aParam[3],aParam[4]})
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Rejeicao de / Rejeicao ate ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam)>=6 .AND. !Empty(aParam[5]) .AND. !Empty(aParam[6])
		cRet += " AND ANB.ANB_DATA BETWEEN '" +DtoS(aParam[5])+ "'" + " AND " + "'" +DtoS(aParam[6])+ "' "
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³TI de Origem ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam)>=7 .AND. !Empty(aParam[7])
		cRet += 	" AND ANB.ANB_EXEC IN (" + ParamInov(05,aParam[7]) + ")	"
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tipo de Rejeicao de / Tipo de Rejeicao ate ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aParam)>=10
		cRet += "AND " + ParamInov(04,,{aParam[09],aParam[10]})
	EndIf

	cRet += " AND AN8.D_E_L_E_T_ = ' ' "
	cRet += " AND ANB.D_E_L_E_T_ = ' ' "
	cRet += " AND AF9.D_E_L_E_T_ = ' ' "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Ordenar por: Prjeto, tarea e Data³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet += "ORDER BY AN8.AN8_PROJET, AN8.AN8_TRFORI, AN8.AN8_DATA "

Return cRet


/*/{Protheus.doc} ParamSust

Funcao para montar a condicao para query baseada nos parametros informados.

@param cTipo, character, (Descrição do parâmetro)
@param aParametro, array, (Descrição do parâmetro)

@return ${return}, ${return_description}

@author Microsiga
@since 05/02/12
@version 1.0
/*/
Static Function ParamSust(cTipo,aParametro)
Local cRet 		:= ""
Local cPar1		:= ""
Local cPar2		:= ""
Local aProdDe		:= {}
Local aProdAte	:= {}
Local nCountFor	:= 0
Local cAux			:= ""

	Do Case

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Realiza a comparacao entre os dois parametros ³
		//³Verificando se deve ser utilizado = ou BETWENN³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Case cTipo == "01"
			cPar1  := aParametro[1]
			cPar2 	:= aParametro[2]
			cCampo	:= aParametro[3]
	
			If !Empty(cPar2)
	
				If cPar1 == cPar2
					cRet := " = '" + ALLTRIM(cPar1) + "' "
				Else
					cRet := " BETWEEN '" + ALLTRIM(cPar1) + "' AND '" + ALLTRIM(cPar2) + "' "
				EndIF
	
			Else
				cRet := " BETWEEN '" + ALLTRIM(cPar1) + "' AND '" + Replicate ( "Z", TamSX3(cCampo)[1] ) + "' "
			EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Especifico para condicao de Produto ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Case cTipo == "02"
	
			aProdDe := aParametro[1]
			aProdAte:= aParametro[2]
	
			If Len(aProdDe) == 1
	
				If Len(aProdAte)>=1 .AND. !Empty(aProdAte[1]) .AND. aProdAte[1] != aProdDe[1]
					cRet := " BETWEEN '" + ALLTRIM(aProdDe[1]) + "' AND '" + ALLTRIM(aProdAte[1]) + "' "
	
				ElseIf Len(aProdAte)>=1 .AND. !Empty(aProdAte[1]) .AND. aProdAte[1] == aProdDe[1]
					cRet := " = '" + ALLTRIM(aProdDe[1]) + "' "
				Else
					cRet := " BETWEEN '" + ALLTRIM(aProdDe[1]) + "' AND '" + Replicate ( "Z", TamSX3("ADE_CODSB1")[1] ) + "' "
				EndIf
	
			Else
	
				cRet := "IN ( "
				For nCountFor := 1 to Len(aProdDe)
					If nCountFor > 1
						cRet +=" , "
					EndIf
	
					cRet +="'" + ALLTRIM(aProdDe[nCountFor]) + "'"
	
				Next nCountFor
	
				cRet += ")"
	
			EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Especifico para condicao TI Destino/Etapa ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Case cTipo == "03"
	
			If Len(aParametro)>1
				cRet := "IN ( "
				For nCountFor := 1 to Len(aParametro)
					If nCountFor > 1
						cRet +=" , "
					EndIf
	
					cRet +="'" + ALLTRIM(aParametro[nCountFor]) + "'"
	
				Next nCountFor
	
				cRet += ")"
	
			ElseIf Len(aParametro) == 1
	
				cRet := "= '" + ALLTRIM(aParametro[1])  + "'	"
	
			EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Especifico para condicao TI Origem   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Case cTipo == "04"
			If Len(aParametro)>1
	
				cAux := " QI5.QI5_MAT LIKE ('%"
				cRet := "AND ( " + cAux
	
				For nCountFor := 1 to Len(aParametro)
					If nCountFor > 1
						cRet +=" OR " + cAux
					EndIf
	
					cRet += ALLTRIM(aParametro[nCountFor]) + "') "
	
				Next nCountFor
	
				cRet += ")"
	
			ElseIf Len(aParametro)==1
	
				cRet := "AND QI5.QI5_MAT LIKE ('%" + ALLTRIM(aParametro[1])  + "') "
	
			EndIf

	EndCase

Return cRet


/*/{Protheus.doc} ParamInov
Funcao para montar a condicao para query baseada nos parametros informados.

@param nOpcao, numérico, (Descrição do parâmetro)
@param cParams, character, (Descrição do parâmetro)
@param aParametro, array, (Descrição do parâmetro)
@return ${return}, ${return_description}

@author Microsiga
@since  05/02/12
@version 1.0

/*/
Static Function ParamInov(nOpcao,cParams,aParametro)
Local aParam   	:= {}
Local cRet			:= ""
Local nCountFor	:= 0
Local cTarfDe 	:= ""
Local cTarfAte	:= ""
Local cTI			:= ""

	Do Case

		Case ( nOpcao == 1 ) .OR. ( nOpcao == 2 ) .OR. ( nOpcao == 5 )

			aParam := Separa(cParams,";",.F.)

			For nCountFor:=1 to Len(aParam)

				If nCountFor > 1
					cRet += ", "
				EndIf

				If nOpcao == 1
					cRet += ALLTRIM(aParam[nCountFor])

				ElseIf nOpcao == 5

					cTI := AllTrim( aParam[nCountFor] )

					If Len(cTI) > 6
						cTI := SubStr ( cTI , 5 , Len(cTI) )
					EndIf

					cRet += "'" + cTI + "'"

				Else

					cRet += "'" + AllTrim(aParam[nCountFor]) + "'"

				EndIf

			Next nCountFor

		Case nOpcao == 3

			cTarfDe := aParametro[1]
			cTarfAte := aParametro[2]

			If !Empty(cTarfAte)

				If cTarfDe == cTarfAte
					cRet := " AN8.AN8_TAREFA LIKE '" + ALLTRIM(cTarfDe) + "%' "
				Else
					cRet := " AN8.AN8_TAREFA BETWEEN '" + ALLTRIM(cTarfDe) + "' AND '" + ALLTRIM(cTarfAte) + "' "
				EndIF

			Else
				cRet := " AN8.AN8_TAREFA BETWEEN '" + ALLTRIM(cTarfDe) + "' AND '" + Replicate ( "Z", TamSX3("AN8_TAREFA")[1] ) + "' "
			EndIf

		Case nOpcao == 4

			cTpRejDe  := aParametro[1]
			cTpRejAte := aParametro[2]

			If !Empty(cTpRejAte)

				If cTpRejDe == cTpRejAte
					cRet := " ANB.ANB_TIPERR = '" + ALLTRIM(cTpRejAte) + "' "
				Else
					cRet := " ANB.ANB_TIPERR BETWEEN '" + ALLTRIM(cTpRejDe) + "' AND '" + ALLTRIM(cTpRejAte) + "' "
				EndIF

			Else
				cRet := " ANB.ANB_TIPERR BETWEEN '" + ALLTRIM(cTpRejDe) + "' AND '" + Replicate ( "Z", TamSX3("ANC_TIPERR")[1] ) + "' "
			EndIf

	EndCase

Return cRet


/*/{Protheus.doc} ValidTIDest

Funcao para verificar se o TI destino esta sendo respeitado

@param nTipo, numérico, (Descrição do parâmetro)
@param cCodigo, character, (Descrição do parâmetro)
@param cREV, character, (Descrição do parâmetro)
@param cTpRej, character, (Descrição do parâmetro)
@param cTIDest, character, (Descrição do parâmetro)
@return ${return}, ${return_description}

@author Microsiga
@since 05/02/12
@version 1.0
/*/
Static Function ValidTIDest(nTipo ,cCodigo , cREV, cTpRej, cTIDest)
Local lRet			:= .F.
Local aArea		:= GetArea()
Local aAreaQI5	:= QI5->( GetArea() )
Local cKey			:= ""
Local aTIs			:= {}
Local nCount		:= 0
Local cQuery		:= ""
Local cAlias		:= GetNextAlias()
Local cProjeto	:= cCodigo
Local cTarefa		:= cRev

	If Empty(cTIDest) .OR. ( "ZZZ" $ Upper(cTIDest))

		lRet := .T.

	ElseIf nTipo == 01

		aTIs := Separa(cTIDest,";",.F.)

		cKey := xFilial("QI5")
		cKey += Pad( ALLTRIM( cCodigo ) 		, TamSX3("QI5_CODIGO")[1]	)
		cKey += Pad( ALLTRIM( Soma1(cREV) )	, TamSX3("QI5_REV")[1]		)
		cKey += Pad( ALLTRIM( cTpRej )			, TamSX3("QI5_TPACAO")[1]	)

		dbSelectArea("QI5")
		dbSetOrder(4)
		If dbSeek(cKey)

			For nCount:= 1 to Len(aTIs)

				If ALLTRIM( aTIs[nCount] ) $ (QI5->QI5_MAT )
					lRet := .T.
					Exit
				EndIf

			Next nCount

		EndIf

	ElseIf nTipo == 02

		aTIs := Separa(cTIDest,";",.F.)

		cQuery := "SELECT AFA.AFA_RECURS RECURSO "
		cQuery += "FROM " + RetSQLName("AFA") + " AFA "
		cQuery += "WHERE AFA.AFA_FILIAL = '" + xFilial("AFA") + "' "
		cQuery += "AND AFA.AFA_PROJET = '" + cProjeto +  "' "
		cQuery += "AND AFA.AFA_TAREFA = '" + cTarefa + "' "
		cQuery += "AND AFA.D_E_L_E_T_ = ' ' "

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias, .T., .T.)

		While (cAlias)->( !EOF() ) .AND. !lRet

			For nCount:= 1 to Len(aTIs)

				If ALLTRIM(aTIs[nCount]) $ ALLTRIM((cAlias)->RECURSO)
					lRet := .T.
					Exit
				EndIf
			Next nCount

			(cAlias)->( dbSkip() )

		End

		(cAlias)->( dbCloseArea() )


	EndIf

	RestArea(aArea)
	RestArea(aAreaQI5)

Return lRet


/*/{Protheus.doc} BuscaRec
Funcao para buscar o TI

@param nTipo, numérico, (Descrição do parâmetro)
@param cCodigo, character, (Descrição do parâmetro)
@param cRev, character, (Descrição do parâmetro)
@param cTpRej, character, (Descrição do parâmetro)
@return ${return}, ${return_description}

@author Microsiga
@since 05/02/12
@version 1.0
/*/
Static Function BuscaRec(nTipo, cCodigo,cRev,cTpRej)
Local cRecurso	:=""
Local aArea		:= GetArea()
Local aAreaQI5	:= QI5->( GetArea() )
Local cKey			:= ""
Local cQuery		:= ""
Local cAlias		:= GetNextAlias()
Local cProjeto	:= cCodigo
Local cTarefa		:= cRev

	If nTipo = 01

		cKey := xFilial("QI5")
		cKey += Pad( ALLTRIM( cCodigo ),		TamSX3("QI5_CODIGO")[1]	)
		cKey += Pad( ALLTRIM( SOMA1(cRev) ),	TamSX3("QI5_REV")[1]		)
		cKey += Pad( ALLTRIM( cTpRej ),			TamSX3("QI5_TPACAO")[1]	)

		dbSelectArea("QI5")
		dbSetOrder(4)

		If dbSeek(cKey)
			cRecurso := ALLTRIM( QI5->QI5_MAT )
			cRecurso := SubStr ( cRecurso , 5 , Len(cRecurso) )
		EndIf

	ElseIf nTipo = 02

		cQuery := "SELECT AFA.AFA_RECURS RECURSO "
		cQuery += "FROM " + RetSQLName("AFA") + " AFA "
		cQuery += "WHERE AFA.AFA_FILIAL = '" + xFilial("AFA") + "' "
		cQuery += "AND AFA.AFA_PROJET = '" + ALLTRIM(cProjeto) +  "' "
		cQuery += "AND AFA.AFA_TAREFA = '" + ALLTRIM(cTarefa) + "' "
		cQuery += "AND AFA.D_E_L_E_T_ = ' ' "

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias, .T., .T.)

		If (cAlias)->( !EOF() )
			cRecurso :=  ALLTRIM( (cAlias)->RECURSO )
		EndIf

		(cAlias)->( dbCloseArea() )

	EndIf

	RestArea( aAreaQI5 )
	RestArea( aArea )

Return cRecurso


/*/{Protheus.doc} BuscaMemo
Funcao para busca do conteudo dos campos memos

@param nTipo, numérico, (Descrição do parâmetro)
@param cProjet, character, (Descrição do parâmetro)
@param cRevisa, character, (Descrição do parâmetro)
@param cTarefa, character, (Descrição do parâmetro)
@param cData, character, (Descrição do parâmetro)
@return ${return}, ${return_description}

@author Microsiga
@since 05/02/12
@version 1.0
/*/
Static Function BuscaMemo(nTipo, cProjet, cRevisa, cTarefa, cData)
Local aArea		:= GetArea()
Local aAreaANB	:= ANB->( GetArea() )
Local aAreaANC	:= ANC->( GetArea() )
Local cMemo		:= ""
Local cQuery		:= ""
Local cAlias		:= GetNextAlias()

	If nTipo == 1

		cQuery := "SELECT ANC.R_E_C_N_O_ RECNOANC "
		cQuery += "FROM " + RetSQLName("ANC") + " ANC "
		cQuery += " WHERE	ANC.ANC_FILIAL = '" + xFilial("ANC") + "' "
		cQuery += " AND ANC.ANC_PROJET = '" + ALLTRIM(cProjet) + "' "
		cQuery += " AND ANC.ANC_REVISA = '" + ALLTRIM(cRevisa) + "' "
		cQuery += " AND ANC.ANC_TAREFA = '" + ALLTRIM(cTarefa) + "' "
		cQuery += " AND ANC.ANC_DATA = '" + ALLTRIM(cData) + "' "
		cQuery += " AND ANC.D_E_L_E_T_ = ' ' "

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias, .T., .T.)

		If (cAlias)->( !EOF() )

			dbSelectArea("ANC")
			dbSetOrder(1)
			ANC->( dbGoTo( (cAlias)->RECNOANC ) )

			cMemo := ALLTRIM(ANC->ANC_MOTIVO)

		EndIf

	ElseIf nTipo == 2

		cQuery := "SELECT ANB.R_E_C_N_O_ RECNOANB "
		cQuery += " FROM " + RetSQLName("ANB") + " ANB "
		cQuery += " WHERE	ANB_FILIAL = '" + xFilial("ANB") + "' "
		cQuery += " AND ANB.ANB_PROJET = '" + ALLTRIM(cProjet) + "' "
		cQuery += " AND ANB.ANB_REVISA = '" + ALLTRIM(cRevisa) + "' "
		cQuery += " AND ANB.ANB_TRFORI = '" + ALLTRIM(cTarefa) + "' "
		cQuery += " AND ANB.ANB_DATA = '" + ALLTRIM(cData) + "' "
		cQuery += " AND ANB.D_E_L_E_T_ = ' ' "

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias, .T., .T.)

		If (cAlias)->( !EOF() )

			dbSelectArea("ANB")
			dbSetOrder(1)
			ANB->( dbGoTo( (cAlias)->RECNOANB ) )

			cMemo := ALLTRIM(ANB->ANB_MOTIVO)

		EndIf

	EndIf

	(cAlias)->( dbCloseArea() )

	RestArea(aAreaANB)
	RestArea(aAreaANC)
	RestArea(aArea)

Return cMemo


/*/{Protheus.doc} MontaSev
Funcao para buscar a descricao da criticiadade utilizando o combo box do SX3

@param cSev, character, (Descrição do parâmetro)
@return ${return}, ${return_description}

@author Microsiga
@since 05/02/12
@version 1.0
/*/
Static Function MontaSev( cSev )
Local aArea	:= GetArea()
Local aAreaX3	:= SX3->( GetArea() )
Local aCrit	:= {}
Local aX3CBox	:= {}
Local nCount	:= 0
Local cCrit 	:= ""

	dbSelectArea("SX3")
	dbSetOrder(2)
	If dbSeek("ADE_SEVCOD")

		aX3CBox := Separa(SX3->X3_CBOX,";",.F.)

		For nCount:=1 to Len(aX3CBox)

			Aadd( aCrit , { SubStr(aX3CBox[nCount],1,1)  , SubStr(aX3CBox[nCount],3,Len(aX3CBox[nCount]) )  }  )

		Next nCount

		For nCount:=1 to Len(aCrit)

			If ALLTRIM(aCrit[nCount][1]) == ALLTRIM(cSev)
				cCrit := ALLTRIM(aCrit[nCount][2])
				Exit
			EndIf

		Next nCount

	EndIf

	RestArea(aArea)
	RestArea(aAreaX3)

Return cCrit


/*/{Protheus.doc} TipoRejeic
Funcao para montagem dos tipos de rejeicao e totalizador por tipo de rejeicao.

@param aRejeicoes, array, (Descrição do parâmetro)
@param cTipo, character, (Descrição do parâmetro)
@param nTot, numérico, (Descrição do parâmetro)
@param lDados, ${param_type}, (Descrição do parâmetro)

@return ${return}, ${return_description}

@author Microsiga
@since 05/02/12
@version 1.0
/*/
Static Function TipoRejeic(aRejeicoes,cTipo,nTot,lDados)
Local aArea		:= GetArea()
Local aAreaANA	:= ANA->( GetArea() )
Local nPorcent	:= 0
Local nCountFor	:= 0
Local aAux			:= {}
Local cVazio		:= ""
Local cString		:= ""
Local nTam			:= 0
Local nSpace		:= 50

	Default lDados := .F.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta o array com os tipos³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aRejeicoes) == 0
		dbSelectArea("ANA")
		dbSetOrder(1)

		While ANA->( !EOF() )

			Aadd(aRejeicoes,{ ALLTRIM(ANA->ANA_CODIGO) , ALLTRIM(ANA->ANA_DESCRI) , 0 })

			ANA->( dbSkip() )

		End

		cVazio := Pad(cVazio,TamSX3("ANA_CODIGO")[1])

		Aadd(aRejeicoes,{ cVazio , STR0059 , 0 })		//#"SEM TIPO DE REJEICAO"


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Insere o tipo da rejeicao no contador   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ElseIf Empty(nTot) .AND. lDados

		For nCountFor:=1 to Len(aRejeicoes)

			If ALLTRIM(aRejeicoes[nCountFor][1]) == ALLTRIM(cTipo)
				aRejeicoes[nCountFor][3]++
				Exit
			EndIf

		Next nCountFor

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Realiza o calculo da porcentagem para cada tipo de rejeicao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Else
		aAux := AClone(aRejeicoes)
		aRejeicoes := {}

		Aadd(aRejeicoes, STR0060)		//#"LEGENDA:"

		nTam := Len(aAux[1][1]) + Len(aAux[1][2])
		nTam := nSpace - nTam

		cString := STR0061 + Space(nTam)		//#"Descricao tipo de Rejeicao"
		cString += STR0062 + Space(5)			//#"Quantidade"
		cString += STR0063						//#"Porcentagem"

		Aadd(aRejeicoes,cString)

		For nCountFor:=1 to Len(aAux)

			If lDados

				nPorcent := aAux[nCountFor][3]
				nPorcent := (nPorcent/nTot) * 100
				nPorcent := Round(nPorcent,2)

			Else

				nPorcent := 0

			EndIf

			nTam := Len(aAux[nCountFor][1]) + Len(aAux[nCountFor][2])
			nTam := nSpace - nTam

			cString	:= aAux[nCountFor][1]
			cString	+= " - " + aAux[nCountFor][2]
			cString  += Space(nTam+3) + CValToChar(aAux[nCountFor][3])
			cString  += Space(Len(STR0062)+1) + Transform(nPorcent, "@E 999.99") + "%"			//#"Quantidade"

			Aadd(aRejeicoes, cString )

		Next nCountFor

	EndIf

	RestArea(aAreaANA)
	RestArea(aArea)

Return


/*/{Protheus.doc} Perg390
Funcao para fazer os perguntes necessarios

@param 
cPerg, character, (Descrição do parâmetro)
@return ${return}, ${return_description}

@author Microsiga
@since 04/24/12
@version 1.0
/*/

//PMSR390

Static Function Perg390(cPerg)
Local nRet		:= 0
Local cPerg1	:= cPerg + "A"
Local cPerg2 	:= cPerg + "B"
Local aHelpPor := {}

	Pergunte(cPerg,.T.)

	nRet := MV_PAR01

	If nRet == 1
		Pergunte(cPerg1,.F.)
	Else
		Pergunte(cPerg2,.F.)
	EndIf

Return nRet

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLogUser
    @description
    Realiza o log dos dados acessados, de acordo com as informações enviadas, 
    quando a regra de auditoria de rotinas com campos sensíveis ou pessoais estiver habilitada
	Remover essa função quando não houver releases menor que 12.1.27

   @type  Function
    @sample FATPDLogUser(cFunction, nOpc)
    @author Squad CRM & Faturamento
    @since 06/01/2020
    @version P12
    @param cFunction, Caracter, Rotina que será utilizada no log das tabelas
    @param nOpc, Numerico, Opção atribuída a função em execução - Default=0

    @return lRet, Logico, Retorna se o log dos dados foi executado. 
    Caso o log esteja desligado ou a melhoria não esteja aplicada, também retorna falso.

/*/
//-----------------------------------------------------------------------------
Static Function FATPDLogUser(cFunction, nOpc)

	Local lRet := .F.

	If FATPDActive()
		lRet := FTPDLogUser(cFunction, nOpc)
	EndIf 

Return lRet  

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  

