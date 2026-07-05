/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "OGR250.ch"
#include "protheus.ch"
 
/*
+--------+--------------------------------------------------------------+
| Funcao | U_OGR250( )                                                    |
| Autor  | Equipe Agroindustria                                               |
| Data   | 10/05/2012                                              |
| Descri | Imprime romaneio de carga e ou descarga em formulario.       |
+--------+--------------------------------------------------------------+
*/
User Function OGR250( cAlias, nReg, nAcao )
	Local cDesc1			:= STR0001 //"Este programa tem como objetivo imprimir relatorio "
	Local cDesc2			:= STR0002 //"de acordo com os parametros informados pelo usuario."
	Local cDesc3			:= STR0003 //" -Romaneio- "
	Local titulo			:= STR0004 //"Romaneio"
	Local Cabec1			:= ""
	Local Cabec2			:= ""
	Local aOrd				:= {}

	Private lEnd			:= .F.
	Private lAbortPrint		:= .F.
	Private limite			:= 80
	Private tamanho			:= "P"
	Private nomeprog		:= "OGR250"
	Private nTipo			:= 18
	Private aReturn			:= { STR0005, 1, STR0006, 2, 2, 1, "", 1} //"Zebrado"###"Administracao"
	Private nLastKey		:= 0
	Private cbtxt			:= Space(10)
	Private cbcont			:= 00
	Private CONTFL			:= 01
	Private m_pag			:= 01
	Private cPerg			:= "OGR250"
	Private wnrel			:= "OGR250"
	Private cString			:= "NJJ"
	Private cCodigo			:= NJJ->( NJJ_CODROM )
	Private cModelImp		:= 1
	Private lDireto			:= .F.

    dbSelectArea("NJJ")
	NJJ->( dbSetOrder( 1 ) )

	// Se estiver tentando imprimir um romaneio sem pesagem
	If NJJ->( NJJ_STSPES ) == '0' 
		If ! MsgNoYes( STR0059 + Chr(10) + Chr(13) + STR0060, STR0058 )  //"--- ROMANEIO SEM PESAGEM ---"+"Confirma a impressão do romaneio?"###"A T E N Ç Ã O ! ! !"
			Return( NIL )
		EndIf
	EndIf

	Pergunte( cPerg, .f. )

	If FunName() $ "OGA250|OGA251|OGA255|AGRA500"
		cPerg := ""
		lDireto := .t.
	EndIf

	wnrel := SetPrint( cString, NomeProg, cPerg, @titulo, cDesc1, cDesc2, cDesc3, .f., aOrd, .f., Tamanho, , .t. )
	
	If nLastKey == 27
		Return( Nil )
	Endif

	SetDefault( aReturn, cString )

	If nLastKey == 27
		Return( Nil )
	Endif

	RptStatus( {|| RunReport( Cabec1, Cabec2, Titulo ) }, Titulo )
Return( NIL )

/*
+--------+--------------------------------------------------------------+
| Funcao | RunReport()                                                  |
| Autor  | Equipe Agroindustria                                               |
| Data   | 10/05/2012                                              |
| Descri | Impressao do relatorio.                                      |
+--------+--------------------------------------------------------------+
*/
Static Function RunReport( Cabec1, Cabec2, Titulo )
	Local nLin		:= 0 //Linha inicial da pagina
	Local nCol		:= 0 //Coluna inicial da pagina
	Local cInscr  	:= ""
	Local cCGC 		:= ""
	Local cTpPessoa := "" 
	Local cTipoRes	:= ""
	Local cClass    := ""
	Local cPeso3    := ""
	Local cNrMov	:= ""
	Local cCdOper	:= ""
	Local cUsrName  := UsrRetName(RetCodUsr())

	@ nLin, nCol PSay AvalImp( 80 )

	If .Not. lDireto
		cCodigo 	:= MV_PAR01
		cModelImp 	:= MV_PAR02
	EndIf

	dbSelectArea( 'NJJ' ) // Romaneio
	dbSetOrder( 1 )
	dbSeek( xFilial( 'NJJ' ) + cCodigo )

	dbSelectArea( 'NJM' ) // Comercializações do romaneio
	dbSetOrder( 1 )
	dbSeek( xFilial( 'NJM' ) + NJJ->( NJJ_CODROM ) )

	While .Not. NJM->( Eof( ) ) .And. NJM->( NJM_FILIAL ) + NJM->( NJM_CODROM ) == xFilial( 'NJM' ) + NJJ->( NJJ_CODROM )

		If nLin > 0
			Eject  //pula pagina
		EndIf

		nLin := 0
		nCol := 0

		SetPrc( nLin, nCol )

		dbSelectArea( "NJ0" ) // Entidade
		dbSetOrder( 1 )
		dbSeek( xFilial( "NJ0" ) + NJM->( NJM_CODENT ) + NJM->( NJM_LOJENT ) )

		dbSelectArea( "SA1" ) // Cliente
		dbSetOrder( 1 )
		dbSeek( xFilial( "SA1" ) + NJ0->( NJ0_CODCLI ) + NJ0->( NJ0_LOJCLI ) )

		dbSelectArea( "SA2" ) // Fornecedor
		dbSetOrder( 1 )
		dbSeek( xFilial( "SA2" ) + NJ0->( NJ0_CODFOR ) + NJ0->( NJ0_LOJFOR ) )

		dbSelectArea( "SX5" ) // Tabelas genéricas - K5: descriçao do tipo de romaneio
		dbSetOrder( 1 )
		dbSeek( xFilial( "SX5" ) + "K5" + NJJ->( NJJ_TIPO ) ) 

		dbSelectArea( "NJU" ) // Safra
		dbSetOrder( 1 )
		dbSeek( xFilial( "NJU" ) + NJJ->( NJJ_CODSAF ) )

		dbSelectArea( "NJR" ) // Contrato
		dbSetOrder( 1 )
		dbSeek( xFilial( "NJR" ) + NJM->( NJM_CODCTR ) )

		If NJJ->( NJJ_TPCLAS ) = "1" .Or. NJJ->( NJJ_TPCLAS ) = ""
			cClass := STR0063 //Física
		Else
			cClass := STR0064 //Fiscal
		EndIf

		cAux1 := STR0007 //"[ Dados da Empresa ]"
		@ nLin, nCol   PSay OemToAnsi( cAux1 ) + Replicate( "-", 80 - Len( cAux1 ) ); nLin++
		@ nLin, nCol+3 PSay AllTrim( SM0->( M0_NOMECOM ) ); nLin++
		@ nLin, nCol+3 PSay AllTrim( SM0->( M0_ENDENT ) ); nLin++
		@ nLin, nCol+3 PSay AllTrim( SM0->( M0_CEPENT ) ) + " - " + AllTrim( SM0->( M0_CIDENT ) ) + " - " + AllTrim( SM0->( M0_ESTENT ) ); nLin++
		@ nLin, nCol+3 PSay STR0008 + AllTrim( SM0->( M0_CGC ) ) + STR0009 + AllTrim( SM0->( M0_INSC ) ); nLin++ 			//"CNPJ.: "###"   IE.: "
		@ nLin, nCol+3 PSay STR0010 + SM0->( M0_TEL ); nLin++ 																//"Telefone.: "

		cCdOper := Posicione('N92', 1, FWxFilial('N92')+NJJ->NJJ_TOETAP,'N92_CDOPER')

		nLin++
		cAux1 := STR0011 //"[ Dados da Operacao e Produto ]"
		@ nLin, nCol    PSay OemToAnsi( cAux1 ) + Replicate( "-", 80 - Len( cAux1 ) ); nLin++
		@ nLin, nCol+3  PSay STR0012 + NJJ->( NJJ_CODROM ) 														//"Romaneio.: "
		@ nLin, nCol+40 PSay STR0013 + NJJ->( NJJ_TIPO ) + "  - " + SX5->( X5Descri( ) ); nLin++				//"Tipo.: "
		@ nLin, nCol+3  PSay STR0014 + AllTrim( NJU->NJU_DESCRI) 												//"Safra....: "
		@ nLin, nCol+40 PSay STR0076 + AllTrim( NJM->NJM_LOCAL) + " - " + AllTrim( Posicione('NNR',1,xFilial('NNR')+NJM->(NJM_LOCAL),'NNR_DESCRI')) ; nLin++	//"Local....: "	
		@ nLin, nCol+3  PSay STR0015 + AllTrim(NJJ->NJJ_CODPRO) + " - " + AllTrim( Posicione('SB1',1,xFilial('SB1')+NJJ->(NJJ_CODPRO),'B1_DESC')) 	//"Produto.: "
		@ nLin, nCol+72 PSay STR0016 + NJJ->( NJJ_UM1PRO ); nLin++ 												//"UM.: "
		@ nLin, nCol+3  PSay STR0061 + cClass 																	//"Class...: "
		
		@ nLin, nCol+40 PSay STR0065 + AllTrim(NJJ->NJJ_NUMOP); nLin++											//"OP: "
		@ nLin, nCol+3  PSay STR0066 + AllTrim(NJJ->NJJ_CODVAR) + " - " + AllTrim(Posicione('NNV',1,FWxFilial('NNV')+NJJ->NJJ_CODPRO+NJJ->NJJ_CODVAR,'NNV_DESCRI'))	//"Variedade: "
		@ nLin, nCol+40 PSay STR0067 + AllTrim(NJJ->NJJ_ORDCLT); nLin++											//"Ordem Colheita: "
		@ nLin, nCol+3  PSay STR0069 + AllTrim(NJM->NJM_CODAUT)													//"Aut. Carregamento: "
		@ nLin, nCol+40 PSay STR0070 + AllTrim(NJM->NJM_PEDIDO); nLin++											//"Pedido: "		
		@ nLin, nCol+3  PSay STR0068 + AllTrim(NJM->NJM_CODINE); nLin++											//"Instrução: "
		@ nLin, nCol+3  PSay STR0074 + AllTrim(Posicione("SX5", 1, FWxFilial("SX5")+"K5"+NJJ->NJJ_TIPO, "X5_DESCRI" )); nLin++	//"Oper. Balança: "		
	
		@ nLin, nCol+3  PSay STR0075 + AllTrim(cCdOper) + " - " + AllTrim(Posicione("GVC", 1, FWxFilial("GVC")+cCdOper, "GVC_DSOPER")); nLin++	//"Oper. Portaria: "        "
		
		nLin++
		cAux1 := STR0017 //"[ Dados da Pesagem e Classificacao ]"
		@ nLin, nCol    PSay OemToAnsi( cAux1 ) + Replicate( "-", 80 - Len( cAux1 ) ); nLin++

		If NJJ->( NJJ_STSPES ) == '0' 
			@ nLin, nCol    PSay __PrtCenter( STR0058 ); nLin++ 												//"A T E N Ç Ã O ! ! !"
			@ nLin, nCol    PSay __PrtCenter( STR0059 ); nLin++; nLin++											//"--- ROMANEIO SEM PESAGEM ---"
		EndIf

		@ nLin, nCol+3  PSay STR0018  																			//"Primeira Pesagem..: "
		@ nLin, nCol+25 PSay Transform( NJJ->( NJJ_PESO1 ), PesqPict('NJJ',"NJJ_PESO1") )+" Kg"
		@ nLin, nCol+42 PSay STR0019 + DtoC( NJJ->( NJJ_DATPS1 ) ) + STR0020 + NJJ->( NJJ_HORPS1 ) 				//"Data.: "###" Hora.: "
		nLin++

		@ nLin, nCol+3  PSay STR0021 																			//"Segunda Pesagem...: "
		@ nLin, nCol+25 PSay Transform( NJJ->( NJJ_PESO2 ), PesqPict('NJJ',"NJJ_PESO2") )+" Kg"
		@ nLin, nCol+42 PSay STR0019 + DtoC( NJJ->( NJJ_DATPS2 ) ) + STR0020 + NJJ->( NJJ_HORPS2 ) 				//"Data.: "###" Hora.: "
		nLin++

		@ nLin, nCol+3  PSay STR0022 																			//"Sub Total.........: "
		@ nLin, nCol+25 PSay Transform( NJJ->( NJJ_PSSUBT ), PesqPict('NJJ',"NJJ_PSSUBT") )+" Kg"
		nLin++

		@ nLin, nCol+3 PSay STR0062 + cPeso3                                                                    //"Qtd. Física.......: "
		@ nLin, nCol+23 PSay Transform( NJJ->( NJJ_PESO3 ), PesqPict('NJJ',"NJJ_PESO3") )+" Kg"
		nLin++

		dbSelectArea( "NJK" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "NJK" ) + NJJ->( NJJ_CODROM ) )
		While .Not. Eof( ) .And. NJK_FILIAL = xFilial( "NJK" ) .And. NJK_CODROM = NJJ->( NJJ_CODROM )

			cAux1 := AllTrim( SubStr( POSICIONE('NNH',1,XFILIAL('NNH')+NJK->(NJK_CODDES),'NNH_DESCRI') , 1, 14 ) )
			@ nLin, nCol+3 PSay "(-) " + cAux1 + Replicate( ".", 14 - Len( cAux1 ) ) + ": " 	
			If cModelImp = 1 .Or. lDireto
				@ nLin, nCol+23 PSay Transform( NJK->( NJK_QTDDES ), PesqPict( "NJK", "NJK_QTDDES" ) )+" Kg"	

				cTipoRes := Posicione( "NNJ", 1, xFilial("NNJ") + NJJ->NJJ_TABELA + NJK->NJK_CODDES, "NNJ_TIPRES" )			
				//-- Se o Tipo do Resultado for Faixa [F]
				If cTipoRes == "F"
					@ nLin, nCol+42 PSay Transform( NJK->( NJK_PERDES ), PesqPict( "NJK", "NJK_PERDES" ) )
					//-- Se o Tipo do Resultado for Percentual [P]
				Else
					@ nLin, nCol+42 PSay Transform( NJK->( NJK_PERDES ), PesqPict( "NJK", "NJK_PERDES" ) ) + " %"

				EndIf
				@ nLin, nCol + 55 PSay SubStr( NJK->( NJK_DESRES ), 1, 31 )
			Else
				@ nLin, nCol+42 PSay Replicate( "_", 10 ) + " %"
			EndIf
			nLin++

			dbSelectArea( "NJK" )
			dbSkip()
		EndDo
		dbSelectArea( "NJJ" )

		@ nLin, nCol+3  PSay STR0054 																						//"Total de Descontos: "
		@ nLin, nCol+25 PSay Transform( NJJ->( NJJ_PSSUBT ) - NJJ->( NJJ_PSBASE ), PesqPict( "NJJ", "NJJ_PSSUBT" ) )+" Kg"
		nLin++
		@ nLin, nCol+3  PSay STR0023 																						//"Base..............: "
		@ nLin, nCol+25 PSay Transform( NJJ->( NJJ_PSBASE ), PesqPict( "NJJ", "NJJ_PSBASE" ) )+" Kg"
		nLin++
		@ nLin, nCol+3  PSay STR0025 																						//"(-) Extras........: "
		@ nLin, nCol+25 PSay Transform( NJJ->( NJJ_PSEXTR ), PesqPict( "NJJ", "NJJ_PSEXTR" ) )+" Kg"
		nLin++
		@ nLin, nCol+3  PSay STR0026 																						//"Liquido...........: "
		@ nLin, nCol+25 PSay Transform( NJJ->( NJJ_PSLIQU ), PesqPict( "NJJ", "NJJ_PSLIQU" ) )+" Kg"
		@ nLin, nCol+42 PSay STR0027 + NJJ->( NJJ_TKTCLA ) 																	//"Ticket Classificacao.: "
		nLin++

		//Retorna o Cliente ou Fornecedor, conforme o tipo do movimento do romaneio
		aRetClFr 	:= OGA250ClFr( NJM->( NJM_CODENT ), NJM->( NJM_LOJENT ), NJM->( NJM_TES ), NJM->( NJM_TIPO ), NJM->( NJM_QTDFIS ) )
		cTipo		:= aRetClFr[ 1 ]
		cCliFor	:= aRetClFr[ 2 ]
		cLoja 		:= aRetClFr[ 3 ]
		cAliasClFr	:= aRetClFr[ 4 ]

		If cAliasClFr == "SA1" // Cliente
			cEnd	 	:= SA1->( A1_END )
			cEndComp	:= SA1->( A1_COMPLEM )
			cMunic		:= SA1->( A1_MUN )
			cEst		:= SA1->( A1_EST )
			cCEP		:= SA1->( A1_CEP )
			cInscr 	:= SA1->( A1_INSCR )
			cCGC		:= SA1->( A1_CGC )
			cTpPessoa	:= SA1->( A1_PESSOA )
		Else // Fornecedor
			cEnd	 	:= SA2->( A2_END )
			cEndComp	:= SA2->( A2_ENDCOMP )
			cMunic		:= SA2->( A2_MUN )
			cEst		:= SA2->( A2_EST )
			cCEP		:= SA2->( A2_CEP )
			cInscr 	:= SA2->( A2_INSCR )
			cCGC		:= SA2->( A2_CGC )
			cTpPessoa	:= SA2->( A2_TIPO )
		EndIf

		nLin++
		cAux1 := STR0028 //"[ Dados Da Entidade / Contrato ]"
		@ nLin, nCol    PSay OemToAnsi( cAux1 ) + Replicate( "-", 80 - Len( cAux1 ) ); nLin++
		@ nLin, nCol+3  PSay STR0029  + NJ0->( NJ0_CODENT ) + "-" + NJ0->( NJ0_LOJENT ) + " - " + AllTrim( NJ0->( NJ0_NOME ) ); nLin++ 					//"Entidade.: "
		@ nLin, nCol+3  PSay Space( Len( STR0029 + NJ0->( NJ0_CODENT ) + "-" + NJ0->( NJ0_LOJENT ) + " - ") ) + AllTrim( NJ0->( NJ0_NOMLOJ ) ); nLin++ 
		@ nLin, nCol+3  PSay STR0030 + AllTrim( cEnd ) + " - " + AllTrim( cEndComp ); nLin++ 															//"Endereço.: "
		@ nLin, nCol+3  PSay STR0031 + AllTrim( cMunic ) + " - " + cEst  																				//"Municipio: "
		@ nLin, nCol+40 PSay STR0032 + cCEP; nLin++ 																									//" Cep.: "
		If cTpPessoa = 'F'
			@ nLin, nCol+3  PSay STR0051 + cCGC 					//"CPF......: "
			@ nLin, nCol+40 PSay STR0053 + cInscr; nLin++ 			//" I.E.: "
		ElseIf cTpPessoa = 'J'
			@ nLin, nCol+3  PSay STR0052 + cCGC 					//"CNPJ.....: "
			@ nLin, nCol+40 PSay STR0053 + cInscr; nLin++ 			//" I.E.: "
		EndIf

		nLin++
		@ nLin, nCol+3  PSay STR0033 + NJM->( NJM_CODCTR ) + STR0034 + Posicione( "NJR", 1, xFilial( "NJR" ) + NJM->( NJM_CODCTR ), "NJR_DESCRI" ); nLin++ 	//"Contrato.: "###" Descricao.: "
		@ nLin, nCol+3  PSay STR0055 + Transform( NJM->( NJM_PERDIV ), PesqPict( "NJM", "NJM_PERDIV" ) ) 													//"% de Rateio: "
		@ nLin, nCol+33 PSay STR0056 + Alltrim( Transform( NJM->( NJM_QTDFIS ), PesqPict( "NJM", "NJM_QTDFIS" ) ) )+" Kg"; nLin++ 							//"Qtd. Fisica: "

		nLin++
		cAux1 := STR0036 //"[ Dados Fiscais ]"
		@ nLin, nCol     PSay OemToAnsi( cAux1 ) + Replicate( "-", 80 - Len( cAux1 ) ); nLin++
		@ nLin, nCol+3   PSay STR0037 + Alltrim( NJM->( NJM_DOCNUM ) ) + "/" + AllTrim( NJM->( NJM_DOCSER ) );nLin++ 			//"Nota Fiscal / Série: "
		@ nLin, nCol+3   PSay STR0038 + Alltrim( Transform( NJM->( NJM_QTDFIS ), PesqPict( "NJM", "NJM_QTDFIS" ) ) )+" Kg" 		//"Qtd. Fiscal: "
		@ nLin, pCol()+5 PSay STR0039 + Alltrim( Transform( NJM->( NJM_VLRUNI ), PesqPict( "NJM", "NJM_VLRUNI" ) ) )		 	//"V.Uni.: "
		@ nLin, pCol()+5 PSay STR0040 + Alltrim( Transform( NJM->( NJM_VLRTOT ), PesqPict( "NJM", "NJM_VLRTOT" ) ) ); nLin++ 	//"V.Tot.: "
		If .Not. Empty( NJM->( NJM_NFPNUM ) )
			@ nLin, nCol+3  PSay STR0041 	+ Alltrim( NJM->( NJM_NFPNUM ) ) + "/" + AllTrim( NJM->( NJM_NFPSER ) );nLin++ 		//"Nota Fiscal do Produtor (No./S.).: "
		EndIf

		cNrMov := Posicione("GWV",1,FWxFilial("GWV")+NJJ->NJJ_NRAGEN,"GWV_NRMOV")        

		nLin++
		cAux1 := STR0071 //"[ Dados Agendamento ]"
		@ nLin, nCol    PSay OemToAnsi( cAux1 ) + Replicate( "-", 80 - Len( cAux1 ) ); nLin++
		@ nLin, nCol+3  PSay STR0019 + dToc(NJJ->(NJJ_DTAGEN)) 														//"Data: "
		@ nLin, nCol+22 PSay STR0020 + Transform(NJJ->NJJ_HRAGEN, PesqPict('NJJ',"NJJ_HRAGEN"))						//"Hora: "
		@ nLin, nCol+40 PSay STR0077 + Transform(Posicione("GX4",4,FWxFilial("GX4")+cNrMov+"001","GX4_HRENTR"), PesqPict('GX4',"GX4_HRENTR"));nLin++ 	//"Ent. Portaria: "
		
		nLin++
		cAux1 := STR0042 //"[ Dados Complementares ]"
		@ nLin, nCol    PSay OemToAnsi( cAux1 ) + Replicate( "-", 80 - Len( cAux1 ) ); nLin++
		@ nLin, nCol+3  PSay STR0043 + NJJ->NJJ_PLACA + " - " + POSICIONE("DA3",3,FWxFilial('DA3')+NJJ->NJJ_PLACA,"DA3_DESC"); nLin++					//"Placa.: "
		@ nLin, nCol+3  PSay STR0050 + NJJ->( NJJ_CODTRA ) + " - " + AllTrim( POSICIONE('SA4',1,XFILIAL('SA4')+NJJ->( NJJ_CODTRA ),'A4_NOME')); nLin++ 	//"Transport.: "
		@ nLin, nCol+3  PSay STR0044 + NJJ->( NJJ_CODMOT ) + " - " + AllTrim( POSICIONE('DA4',1,XFILIAL('DA4')+NJJ->( NJJ_CODMOT ),'DA4_NOME')); nLin++ //"Motorista.: "
		@ nLin, nCol+3  PSay STR0072 + AllTrim(POSICIONE('DA4',1,FWXFILIAL('DA4')+NJJ->NJJ_CODMOT,'DA4_NUMCNH')) 										//"CNH.......: "
		@ nLin, nCol+22 PSay STR0073 + AllTrim(POSICIONE('DA4',1,FWXFILIAL('DA4')+NJJ->NJJ_CODMOT,'DA4_CGC')); nLin++									//"CPF/CNPJ..: "
		@ nLin, nCol+3  PSay STR0045 + NJJ->( NJJ_OBS );nLin++ 																							//"Observ...: "
		
		nLin++
		cAux1 := STR0046 + cUsrName + " ]" //"[ Responsavel...: "
		@ nLin, nCol    PSay cAux1 + Replicate( "_", 80 - Len( cAux1 ) ); nLin++

		NJM->( dbSkip() )
	EndDo

	Set Device To Screen

	If aReturn[ 5 ] == 1
		dbCommitAll( )
		Set Printer To
		OurSpool( wnrel )
	Endif
	MS_FLUSH()
Return( )
