/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Mdtr715.ch"
#Include "Protheus.Ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR715
Relatório das ordens de servico da seguranca de trabalho

@type    function
@author  Liber De Esteban O. P.
@since   20/11/2003
@sample  U_MDTR715()

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR715()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM	:= NGBEGINPRM()
	Local cF3CC			:= "SI3001"

	Private nSizeCTT	:= IIf( ( TAMSX3( "CTT_CUSTO" )[1] ) < 1, 9, ( TAMSX3( "CTT_CUSTO" )[1] ) )
	Private cPerg		:= PADR( "MDT715", 10 )
	Private cTxtTit1	:= STR0002
	Private cTxtTit2	:= STR0003
	Private lPosTrab	:= .F.
	Private lTOBDepto	:= NGCADICBASE( "TOB_DEPTO", "A", "TOB", .F. )
	Private nIndTN0		:= 5
	Private nIndTOB		:= 1
	Private nInDToC		:= 1
	Private cCodFu1		:= "TN0->TN0_CODFUN"
	Private cCodFu2		:= "SRA->RA_CODFUNC"
	Private cCodFu3		:= "TOB->TOB_CODFUN"
	Private cCodFu4		:= "TOC->TOC_CODFUN"
	Private cDesFu1		:= "SRJ->RJ_DESC"
	Private nSizeSRJ	:= IIf( ( TAMSX3( "RJ_FUNCAO" )[1] ) < 1, 5, ( TAMSX3( "RJ_FUNCAO" )[1] ) )
	Private cTabFun		:= "SRJ"
	Private strFuncao	:= STR0031 //"Funcao"
	Private nSizeSI3	:= IIf( ( TAMSX3( "I3_CUSTO" )[1] ) < 1, 9, ( TAMSX3( "I3_CUSTO" )[1] ) )
	Private nTa1		:= IIf( ( TAMSX3( "A1_COD" )[1] ) < 1, 6, ( TAMSX3( "A1_COD" )[1] ) )
	Private nTa1L		:= IIf( ( TAMSX3( "A1_LOJA" )[1] ) < 1, 2, ( TAMSX3( "A1_LOJA" )[1] ) )
	Private nSizeTD		:= nTa1 + nTa1L
	Private cMVDeDep	:= ''
	Private	cMvAteDep	:= ''

	lDtDevol	:= NGCADICBASE( "TOC_DTFIM", "A", "TOC", .F. )
	lSigaMdtPS	:= SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"

	cAliasCC := "SI3"
	cDescCC	 := "SI3->I3_DESC"

	If AllTrim( GETMV( "MV_MCONTAB" ) ) == "CTB"
		cF3CC	 := "CTT001"
		cAliasCC := "CTT"
		cDescCC	 := "CTT->CTT_DESC01"
	EndIf

	/* Perguntas
	MDT715    ¦01      ¦Tipo Impressao ?
	MDT715    ¦02      ¦De Funcao ?
	MDT715    ¦03      ¦Ate Funcao ?
	MDT715    ¦04      ¦De Centro de Custo ?
	MDT715    ¦05      ¦Ate Centro de Custo ?
	MDT715    ¦06      ¦De Departamento ?
	MDT715    ¦07      ¦Até Departamento ?
	MDT715    ¦08      ¦De Funcionario ?
	MDT715    ¦09      ¦Ate Funcionario ?
	MDT715    ¦10      ¦Periodo De ?
	MDT715    ¦11      ¦Periodo Ate ?
	MDT715    ¦12      ¦Responsavel empresa ?
	MDT715    ¦13      ¦Descricao das Atividades ?
	MDT715    ¦14      ¦Buscar Informações ?
	MDT715    ¦15      ¦Quant. Agente ?
	MDT715    ¦16      ¦Endereco ?
	*/

	If lSigaMdtps

		/* Perguntas
		01       De Cliente ?
		02       Loja
		03       Até Cliente ?
		04       Loja
		MDT715    ¦05      ¦Tipo Impressao ?
		MDT715    ¦06      ¦De Funcao ?
		MDT715    ¦07      ¦Ate Funcao ?
		MDT715    ¦08      ¦De Centro de Custo ?
		MDT715    ¦09      ¦Ate Centro de Custo ?
		MDT715    ¦10      ¦De Funcionario ?
		MDT715    ¦11      ¦Ate Funcionario ?
		MDT715    ¦12      ¦Periodo De: ?
		MDT715    ¦13      ¦Periodo Ate: ?
		MDT715    ¦14      ¦Responsavel empresa ?
		MDT715    ¦15      ¦Descricao das Atividades
		MDT715    ¦16      ¦Buscar Informações ?
		MDT715    ¦17      ¦Quant. Agente ?
		*/
		cPerg := "MDT715PS  "

	EndIf

	fChkMDTSX1()

	If pergunte( cPerg, .T. )
		If lSigaMdtPs
			cMVDeCli   := mv_par01
			cMVDeLoj   := mv_par02
			cMVAteCli  := mv_par03
			cMVAteLoj  := mv_par04
			cMVTpImp   := mv_par05
			cMVDeFun   := mv_par06
			cMVAteFun  := mv_par07
			cMVDeCC    := mv_par08
			cMVAteCC   := mv_par09
			cMVDeFunc  := mv_par10
			cMVAtFunc  := mv_par11
			cMVDePer   := mv_par12
			cMVAtePer  := mv_par13
			cMVRespon  := mv_par14
			cMVDescAti := mv_par15
			cMVBuscInf := mv_par16
			cMVQntAgen := mv_par17
		Else
			cMVTpImp   := mv_par01
			cMVDeFun   := mv_par02
			cMVAteFun  := mv_par03
			cMVDeCC    := mv_par04
			cMVAteCC   := mv_par05
			cMVDeFunc  := mv_par06
			cMVAtFunc  := mv_par07
			cMVDePer   := mv_par08
			cMVAtePer  := mv_par09
			cMVRespon  := mv_par10
			cMVDescAti := mv_par11
			cMVBuscInf := mv_par12
			cMVQntAgen := mv_par13
			cMVEnderec := mv_par14
		EndIf

		dbSelectArea( "SX1" )
		dbSetOrder( 1 )
		If MsSeek( cPerg + "06" ) .And. "De Departamento" $ X1Pergunt()
			cMVDeDep   := mv_par06
			cMvAteDep  := mv_par07
			cMVDeFunc  := mv_par08
			cMVAtFunc  := mv_par09
			cMVDePer   := mv_par10
			cMVAtePer  := mv_par11
			cMVRespon  := mv_par12
			cMVDescAti := mv_par13
			cMVBuscInf := mv_par14
			cMVQntAgen := mv_par15
			cMVEnderec := mv_par16
		EndIf
		U_MDT715IMP()
	EndIf

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} function
Chamada do Relatório

@type    function
@author  Liber De Esteban O. P.
@since   20/11/2003
@sample  U_MDT715IMP()

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDT715IMP()

	Local oPrint
	Private lin    := 0
	Private lAgen  := IIf( !lSigaMdtps, cMVQntAgen == 1, .F. )
	Private oFont06
	Private oFont07
	Private oFont08
	Private oFont09
	Private oFont10p
	Private oFont10r
	Private oFont11
	Private oFont11b
	Private oFont11t
	Private oFont12
	Private oFont13
	Private oFont14
	Private oFont15

	oFont06	 := TFont():New( "Arial", 06, 06, , .F., , , , .F., .F. )
	oFont07	 := TFont():New( "Arial", 07, 07, , .F., , , , .F., .F. )
	oFont08	 := TFont():New( "Arial", 08, 08, , .F., , , , .F., .F. )
	oFont09	 := TFont():New( "Arial", 09, 09, , .T., , , , .F., .F. )
	oFont10r := TFont():New( "Arial", 10, 10, , .F., , , , .F., .F. )
	oFont10p := TFont():New( "Arial", 10, 10, , .T., , , , .F., .F. )
	oFont11b := TFont():New( "Arial", 11, 11, , .T., , , , .F., .F. )
	oFont11t := TFont():New( "Arial", 11, 11, , .F., , , , .F., .F. )
	oFont11	 := TFont():New( "Arial", 11, 11, , .T., , , , .T., .T. )
	oFont12	 := TFont():New( "Arial", 12, 12, , .T., , , , .T., .T. )
	oFont13	 := TFont():New( "Arial", 12, 12, , .F., , , , .F., .F. )
	oFont14	 := TFont():New( "Arial", 12, 12, , .T., , , , .F., .F. )
	oFont15  := TFont():New( "Arial", 15, 15, , .T., , , , .F., .F. )
	oFont15b := TFont():New( "Arial", 15, 15, , .F., , , , .F., .F. )

	oPrint := FwMsPrinter():New( OemToAnsi( STR0001 ) ) //"Ordem de serviço de segurança do trabalho"
	oPrint:SetPortrait()

	U_INDMDT715( oPrint )

	If cMVTpImp = 2
		oPrint:Print()
	Else
		oPrint:Preview()
	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} INDMDT715
Função responsavel pela impressão do Relatório

@type    function
@sample  U_INDMDT715( oPrint )
@author  Liber De Esteban O. P.
@since   02/04/2003
@param   oPrint, Objeto, Objeto de impressão

@return  Lógico, Sempre Verdadeiro
/*/
//---------------------------------------------------------------------
User Function INDMDT715( oPrint )

	Local nAltura	:= 100 	//Altura do Logo
	Local nLargura 	:= 500 	//Largura do Logo
	Local nX		:= 0 	//Contador 1
	Local nY		:= 0 	//Contador 2
	Local nLMemoAux := 0 	//Contador de linhas auxiliar para impressão dos blocos da OS
	Local nLINPIX	:= 35	//Tamanho em pixel de uma linha para utilização do SayAlign
	Local cSMCOD	:= IIf( FindFunction( "FWGrpCompany" ), FWGrpCompany(), SM0->M0_CODIGO )
	Local cSMFIL	:= IIf( FindFunction( "FWCodFil" ), FWCodFil(), SM0->M0_CODFIL )
	Local nCont
	Local cEnd		:= ""
	Local cBairro	:= ""
	Local cCidade	:= ""
	Local cMemoAux 	:= ""
	Local lPrintDesc := .T.
	Local aAgeAssAti := {} 	// Array dos Agentes Assosiados as Atividades
	Local aBloco	 := {} 	// Array com as informações de cada bloco da O.S.
	Local lPrestador := GetMv( "MV_NGMDTPS" ) = "S" //Se o Cliente for prestadora de Servico

	Private cEPI

	If lSigaMdtps
		//Consistencia da para impreção da descrição da função.
		If cMVDescAti == 2 .And. SRJ->( FieldPos( "RJ_MEMOATI" ) ) <= 0
			lPrintDesc := .F.
		EndIf

		dbSelectArea( "TOC" )
		dbSetOrder( 4 ) //TOC_FILIAL+TOC_CLIENT+TOC_LOJA+TOC_CODFUN+TOC_CC+TOC_MAT
		dbSeek( xFilial( "TOC" ) + cMVDeCli + cMVDeLoj, .T. )
		While !Eof() .And. TOC->TOC_Filial == xFilial( "TOC" ) .And. TOC->( TOC_CLIENT + TOC_LOJA ) <= cMVAteCli + cMVAteLoj

			If TOC->TOC_CODFUN < cMVDeFun .Or. TOC->TOC_CODFUN > cMVAteFun
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			If TOC->TOC_CC>cMVAteCC .Or. TOC->TOC_CC<cMVDeCC .Or. ;
					TOC->TOC_MAT>cMVAtFunc .Or. TOC->TOC_MAT<cMVDeFunc
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			If lDtDevol
				If !Empty( TOC->TOC_DTFIM ) .And. TOC->TOC_DTFIM < cMVDePer
					dbSelectArea( "TOC" )
					dbSkip()
					Loop
				EndIf

				If TOC->TOC_DTENT > cMVAtePer .And. TOC->TOC_DTFIM > cMVAtePer
					dbSelectArea( "TOC" )
					dbSkip()
					Loop
				EndIf
			Else
				If TOC->TOC_DTENT < cMVDePer .Or. TOC->TOC_DTENT > cMVAtePer
					dbSelectArea( "TOC" )
					dbSkip()
					Loop
				EndIf
			EndIf

			cEPI := " "
			dbSelectArea( "TOB" )
			dbSetOrder( 5 ) //TOB_FILIAL+TOB_CLIENT+TOB_LOJA+TOB_CODFUN+TOB_CC
			If !dbSeek( xFilial( "TOB" ) + TOC->( TOC_CLIENT + TOC_LOJA ) + &( cCodFu4 ) + TOC->TOC_CC )
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			If TOB->TOB_DTELAB > cMVAtePer .Or. TOB->TOB_DTELAB < cMVDePer
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			dbSelectArea( "SRA" )
			dbSetOrder( 01 )
			If !dbSeek( xFilial( "SRA" ) + TOC->TOC_MAT )
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			dbSelectArea( "SA1" )
			dbSetOrder( 1 )
			If !dbSeek( xFilial( "SA1" ) + TOC->( TOC_CLIENT + TOC_LOJA ) )
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			lin := 100
			oPrint:StartPage()

			oPrint:Box( lin, 50, 940, 2350 )
			oPrint:Line( 340, 50, 340, 2350 )
			oPrint:Line( 400, 50, 400, 2350 )
			oPrint:Line( 580, 50, 580, 2350 )
			oPrint:Line( 640, 50, 640, 2350 )
			oPrint:Line( 880, 50, 880, 2350 )
			oPrint:Line( 220, 1690, 220, 2350 )

			oPrint:Line( lin, 770, 340, 770 )
			oPrint:Line( lin, 1690, 340, 1690 )
			oPrint:Line( 400, 1630, 580, 1630 )
			oPrint:Line( 640, 1630, 880, 1630 )
			//oPrint:Line(880,1125,940,1125)

			If File( "LGRL" + cSMCOD + cSMFIL + ".BMP" )
				oPrint:SayBitMap( 105, 55, "LGRL" + cSMCOD + cSMFIL + ".BMP", 670, 210 )
			ElseIf File( "LGRL" + cSMCOD + ".BMP" )
				oPrint:SayBitMap( 105, 55, "LGRL" + cSMCOD + ".BMP", 670, 210 )
			EndIf

			oPrint:Say( 130, 930, cTxtTit1, oFont15 ) //"ORDEM DE SERVIÇO"
			oPrint:Say( 190, 920, cTxtTit2, oFont15 ) //"POR ATIVIDADE (O.S.)"
			oPrint:Say( 270, 850, STR0004, oFont15 ) //"SEGURANÇA DO TRABALHO"

			oPrint:Say( 142, 1705, STR0005, oFont11t ) //"Data Elaboração:"
			oPrint:Say( 142, 2000, DToC( TOB->TOB_DTELAB ), oFont09 )
			oPrint:Say( 262, 1705, STR0006, oFont11t ) //"Última Revisão:"
			oPrint:Say( 262, 2000, DToC( TOB->TOB_DTREVI ), oFont09 )

			oPrint:Say( 350, 1000, STR0007, oFont13 ) //"Dados da Empresa"

			oPrint:Say( 420, 65, STR0008, oFont11t ) //"Razão Social/Nome:"
			oPrint:Say( 470, 65, STR0009, oFont11t ) //"Endereço:"
			oPrint:Say( 520, 65, STR0010, oFont11t ) //"Cidade:"

			oPrint:Say( 420, 1645, STR0011, oFont11t ) //"CNPJ:"
			oPrint:Say( 470, 1645, STR0012, oFont11t ) //"CNAE:"
			oPrint:Say( 520, 1645, STR0013, oFont11t ) //"Bairro:"

			oPrint:Say( 420, 450, SubStr( SA1->A1_NOME, 1, 30 ), oFont09 )
			oPrint:Say( 470, 450, SubStr( SA1->A1_END, 1, 36 ), oFont09 )
			oPrint:Say( 520, 450, AllTrim( SA1->A1_MUN ) + IIf( !Empty( SA1->A1_EST ), "-" + SA1->A1_EST, " " ), oFont09 )
			oPrint:Say( 420, 1775, SA1->A1_CGC, oFont09 )
			oPrint:Say( 470, 1775, SA1->A1_ATIVIDA, oFont09 )
			oPrint:Say( 520, 1775, SubStr( A1_BAIRRO, 1, 16 ), oFont09 )

			oPrint:Say( 590, 960, STR0014, oFont13 ) //"Dados do Funcionário"

			oPrint:Say( 660, 65, STR0015, oFont11t ) //"Nome:"
			oPrint:Say( 660, 350, SRA->RA_NOME, oFont09 )

			dbSelectArea( cAliasCC )
			dbSetOrder( 01 )
			If cMVBuscInf == 1
				dbSeek( xFilial( cAliasCC ) + SRA->RA_CC )
			Else
				dbSeek( xFilial( cAliasCC ) + TOB->TOB_CC )
			EndIf
			oPrint:Say( 715, 65, STR0016, oFont11t ) //"Centro de Custo:"
			oPrint:Say( 715, 350, &( cDescCC ), oFont09 )

			dbSelectArea( cTabFun )
			dbSetOrder( 01 )
			If cMVBuscInf == 1
				dbSeek( xFilial( cTabFun ) + &( cCodFu2 ) )
			Else
				dbSeek( xFilial( cTabFun ) + &( cCodFu3 ) )
			EndIf

			oPrint:Say( 770, 65, STR0017, oFont11t ) //"Função:"
			oPrint:Say( 770, 350, &( cDesFu1 ), oFont09 )
			oPrint:Say( 830, 65, STR0018, oFont11t ) //"CTPS:"
			oPrint:Say( 830, 350, SRA->RA_NUMCP + SRA->RA_SERCP, oFont09 )

			oPrint:Say( 660, 1645, STR0019, oFont11t ) //"Matrícula:"
			oPrint:Say( 660, 2120, SRA->RA_MAT, oFont09 )
			oPrint:Say( 715, 1645, STR0020, oFont11t ) //"Data Admissão:"
			oPrint:Say( 715, 2120, DToC( SRA->RA_ADMISSA ), oFont09 )
			oPrint:Say( 770, 1645, STR0021, oFont11t ) //"Data Nascimento:"
			oPrint:Say( 770, 2120, DToC( SRA->RA_NASC ), oFont09 )
			oPrint:Say( 830, 1645, STR0022, oFont11t ) //"RG:"
			oPrint:Say( 830, 2120, SRA->RA_RG, oFont09 )

			dbSelectArea( cTabFun ) //SRJ-Funcao ou ZZI-Posto de Trabalho
			dbSetOrder( 01 )
			If cMVBuscInf == 1
				dbSeek( xFilial( cTabFun ) + &( cCodFu2 ) )
			Else
				dbSeek( xFilial( cTabFun ) + &( cCodFu3 ) )
			EndIf

			SomaLinha()
			oPrint:Say( 950, 1000, "Dados da O.S.", oFont13 ) //"Dados da O.S."

			If lPrintDesc
				lin := 940
				oPrint:line( lin, 50, lin, 2350 )
				oPrint:Say( lin + 10, 65, STR0023, oFont11t ) //"Descrição Função:"
				oPrint:line( lin, 50, lin + 60, 50 )
				oPrint:line( lin - 60, 2350, lin + 60, 2350 )
				oPrint:line( lin + 60, 50, lin + 60, 2350 )
			Else
				lin := 820
			EndIf
			cMemo := " "
			If cMVDescAti == 1 //Cargo
				If lPosTrab
					cMemo := RTrim( ZZI->ZZI_ATIV )
				Else
					cMemo := RTrim( MSMM( SQ3->Q3_DESCDET ) )
				EndIf
			ElseIf cMVDescAti == 2 //Função
				If SRJ->( FieldPos( "RJ_MEMOATI" ) ) > 0
					cMemo := RTrim( SRJ->RJ_MEMOATI )
				EndIf
				cEpiFun := fGetEpiFun( SRJ->RJ_FUNCAO )
				cEPI += cEpiFun
			ElseIf cMVDescAti == 3 //Tarefa
				cMemo := RTrim( DescTarefa( TOC->( TOC_CLIENT + TOC_LOJA ) ) )
			EndIf

			//Chama Função que verifica os Epis do Centro de Custo
			If cMVBuscInf == 1
				cEPI += fGetEpiCen( SRA->RA_CC, cEPI )//Pesquisa os Epis relacionados ao centro de custo
			Else
				cEPI += fGetEpiCen( TOB->TOB_CC, cEPI )
			EndIf

			nLMemo := MLCOUNT( cMemo, 102 )
			For nCont := 01 To nlMemo
				If nCont == 1
					SomaLinha( oPrint, 60 )
				Else
					SomaLinha( oPrint, 50 )
				EndIf
				oPrint:line( lin, 50, lin + 60, 50 )
				oPrint:line( lin, 2350, lin + 60, 2350 )
				oPrint:Say( lin + 10, 65, Memoline( cMemo, 102, nCont ), oFont10p )
			Next nCont
			If cMVQntAgen == 1
				SomaLinha( oPrint, 60 )
				oPrint:Line( lin, 50, lin, 2350 )
				oPrint:Say( lin + 10, 65, STR0024, oFont11t ) //"Agentes Associados às Atividades:"
				oPrint:line( lin, 50, lin + 60, 50 )
				oPrint:line( lin, 2350, lin + 60, 2350 )
				oPrint:line( lin + 60, 50, lin + 60, 2350 )
			EndIf

			//Funcao Funcionario //CC Funcionario
			aAgeAssAti := U_MDT715AR( RetDtRefer() )

			If Len( aAgeAssAti ) > 0
				SomaLinha( oPrint, 60 )
				oPrint:line( lin, 50, lin + 60, 50 )				//|
				oPrint:Say( lin + 10, 630, STR0062, oFont11b )		//|     Agente
				oPrint:line( lin, 1300, lin + 60, 1300 )            //|     Agente     |
				oPrint:Say( lin + 10, 1460, STR0063, oFont11b )		//|     Agente     |     Quantidade
				oPrint:line( lin, 1800, lin + 60, 1800 )			//|     Agente     |     Quantidade     |
				oPrint:Say( lin + 10, 2025, STR0064, oFont11b )		//|     Agente     |     Quantidade     |     Unidade
				oPrint:line( lin, 2350, lin + 60, 2350 )			//|     Agente     |     Quantidade     |     Unidade     |
				oPrint:line( lin + 60, 50, lin + 60, 2350 )			//_________________________________________________________

				SomaLinha( oPrint, 60 )
				For nCont := 1 To Len( aAgeAssAti )
					oPrint:line( lin, 50, lin + 60, 50 )							//|
					oPrint:Say( lin + 10, 65, aAgeAssAti[nCont][1], oFont11t )		//|     Agente
					oPrint:line( lin, 1300, lin + 60, 1300 )						//|     Agente     |
					oPrint:Say( lin + 10, 1315, aAgeAssAti[nCont][2], oFont11t )	//|     Agente     |     Quantidade
					oPrint:line( lin, 1800, lin + 60, 1800 )						//|     Agente     |     Quantidade     |
					oPrint:Say( lin + 10, 1815, aAgeAssAti[nCont][3], oFont11t )	//|     Agente     |     Quantidade     |     Unidade
					oPrint:line( lin, 2350, lin + 60, 2350 )						//|     Agente     |     Quantidade     |     Unidade     |
					oPrint:line( lin + 60, 50, lin + 60, 2350 )						//_________________________________________________________

					// É feito a verificação nCont <> Len(aAgeAssAti) para não ser impresso no ultimo
					// registro, se não ficará com um espaço em branco na tabela de impressao
					IIf( nCont <> Len( aAgeAssAti ), SomaLinha( oPrint, 60 ), Nil )
				Next nCont
			EndIf

			SomaLinha( oPrint, 60 )
			oPrint:Line( lin, 50, lin, 2350 )

			oPrint:Say( lin + 10, 65, STR0025, oFont11t ) //"EPI`s de Uso Obrigatório: "
			oPrint:line( lin, 50, lin + 60, 50 )
			oPrint:line( lin, 2350, lin + 60, 2350 )
			oPrint:line( lin + 60, 50, lin + 60, 2350 )
			If ( nPosicao := Rat( ";", cEPI ) ) > 1
				cEPI := SubStr( cEPI, 1, nPosicao - 1 ) + "."
			EndIf
			cMemo := RTrim( cEpi )
			nLMemo := MLCOUNT( cMemo, 102 )
			For nCont := 01 To nlMemo
				If nCont == 1
					SomaLinha( oPrint, 60 )
				Else
					SomaLinha( oPrint, 50 )
				EndIf
				oPrint:line( lin, 50, lin + 60, 50 )
				oPrint:line( lin, 2350, lin + 60, 2350 )
				oPrint:Say( lin + 10, 65, Memoline( cMemo, 102, nCont ), oFont10p )
			Next nCont

			SomaLinha( oPrint, 60 )
			oPrint:Line( lin, 50, lin, 2350 )

			oPrint:Say( lin + 10, 65, STR0026, oFont11t ) //"Recomendações: "
			oPrint:line( lin, 50, lin + 60, 50 )
			oPrint:line( lin, 2350, lin + 60, 2350 )
			oPrint:line( lin + 60, 50, lin + 60, 2350 )
			cMemo := RTrim( TOB->TOB_TEXTO )
			nLMemo := MLCOUNT( cMemo, 125 )
			For nCont := 01 To nlMemo
				If nCont == 1
					SomaLinha( oPrint, 60 )
				Else
					SomaLinha( oPrint, 50 )
				EndIf
				oPrint:line( lin, 50, lin + 60, 50 )
				oPrint:line( lin, 2350, lin + 60, 2350 )
				oPrint:Say( lin + 10, 65, Memoline( cMemo, 125, nCont ), oFont10p )
			Next nCont

			SomaLinha( oPrint, 60 )
			oPrint:Line( lin, 50, lin, 2350 )

			dbSelectArea( "TMZ" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMZ" ) + TOB->TOB_TERMO )

			oPrint:Say( lin + 10, 65, STR0027, oFont11t ) //"Termo de Responsabilidade: "
			oPrint:line( lin, 50, lin + 60, 50 )
			oPrint:line( lin, 2350, lin + 60, 2350 )
			oPrint:line( lin + 60, 50, lin + 60, 2350 )
			cMemo := RTrim( TMZ->TMZ_DESCRI )
			nLMemo := MLCOUNT( cMemo, 125 )
			For nCont := 01 To nlMemo
				If nCont == 1
					SomaLinha( oPrint, 60 )
				Else
					SomaLinha( oPrint, 50 )
				EndIf
				oPrint:line( lin, 50, lin + 60, 50 )
				oPrint:line( lin, 2350, lin + 60, 2350 )
				oPrint:Say( lin + 10, 65, Memoline( cMemo, 125, nCont ), oFont10p )
			Next nCont

			SomaLinha( oPrint, 60 )
			oPrint:Line( lin, 50, lin, 2350 )

			dbSelectArea( "TMK" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMK" ) + TOB->TOB_CODRES )

			cNOMERES := AllTrim( TMK->TMK_NOMUSU )
			nSize := IIf( Len( cNOMERES ) <= 34, Len( cNOMERES ), 34 )
			If Len( cNOMERES ) > 34
				cNOMERES := SubStr( cNOMERES, 1, 36 )
			EndIf
			nSize := 36 - nSize
			nTabu := 1
			If nSize > 1
				If (nSize % 2) != 0
					nSize++
					nTabu := (nSize / 2) - 1
				Else
					nTabu := nSize / 2
				EndIf
			EndIf
			cCRM := "  "
			nLin := 160
			If !Empty( TMK->TMK_NUMENT )
				cCRM := IIf( Empty( TMK->TMK_ENTCLA ), "CRM", AllTrim( TMK->TMK_ENTCLA ) ) + ": " + AllTrim( TMK->TMK_NUMENT )
				nLin := 200
			EndIf
			nSize2 := IIf( Len( cCRM ) <= 34, Len( cCRM ), 34 )
			If Len( cCRM ) > 34
				cCRM := SubStr( cCRM, 1, 34 )
			EndIf
			nSize2 := 34 - nSize2
			nTabu2 := 1
			If nSize2 > 1
				If (nSize2 % 2) != 0
					nSize2++
					nTabu2 := (nSize2 / 2) - 1
				Else
					nTabu2 := nSize2 / 2
				EndIf
			EndIf

			oPrint:Say( lin + 70, 65, STR0028, oFont13 ) //"Aprovação: "
			oPrint:Say( lin + 70, 700, "__________________________________", oFont11t )
			oPrint:Say( lin + 120, 700, Space( nTabu ) + cNOMERES, oFont10r )
			oPrint:Say( lin + 155, 700, Space( nTabu2 ) + cCRM, oFont10r )
			oPrint:Say( lin + 75, 1820, STR0029, oFont13 ) //"Data: "
			oPrint:Say( lin + 75, 1950, "  __/__/__  ", oFont15b )
			oPrint:line( lin, 50, lin + nLin, 50 )
			oPrint:line( lin, 2350, lin + nLin, 2350 )
			oPrint:Line( lin, 1800, lin + nLin, 1800 )

			SomaLinha( oPrint, nLin )

			dbSelectArea( "SRA" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "SRA" ) + cMVRespon )

			cNOMERES := AllTrim( SRA->RA_NOME )
			nSize3 := IIf( Len( cNOMERES ) <= 34, Len( cNOMERES ), 34 )
			If Len( cNOMERES ) > 34
				cNOMERES := SubStr( cNOMERES, 1, 34 )
			EndIf
			nSize3 := 34 - nSize3
			nTabu3 := 1
			If nSize3 > 1
				If (nSize3 % 2) != 0
					nSize3++
					nTabu3 := (nSize3 / 2) - 1
				Else
					nTabu3 := nSize3 / 2
				EndIf
			EndIf

			oPrint:line( lin, 50, lin, 2350 )
			oPrint:Say( lin + 60, 65, STR0030, oFont13 ) //"Responsável Empresa: "
			oPrint:Say( lin + 70, 700, "__________________________________", oFont11t )
			oPrint:Say( lin + 120, 700, Space( nTabu3 ) + cNOMERES, oFont10r )
			oPrint:Say( lin + 60, 1820, STR0029, oFont13 ) //"Data: "
			oPrint:Say( lin + 60, 1950, "  __/__/__  ", oFont15b )
			oPrint:line( lin, 50, lin + 160, 50 )
			oPrint:line( lin, 2350, lin + 160, 2350 )
			oPrint:Line( lin, 1800, lin + 160, 1800 )

			SomaLinha( oPrint, 160 )
			oPrint:Line( lin, 50, lin, 2350 )

			oPrint:EndPage()
			lin := 100
			dbSelectArea( "TOC" )
			dbSkip()
		End

	Else
		//Consistencia da para impreção da descrição da função.
		If cMVDescAti == 2 .And. SRJ->( FieldPos( "RJ_MEMOATI" ) ) <= 0
			lPrintDesc := .F.
		EndIf

		dbSelectArea( "TOC" )
		dbSetOrder( nInDToC )
		dbSeek( xFilial( "TOC" ) + cMVDeFun, .T. )
		While !Eof() .And. TOC->TOC_FILIAL == xFilial( "TOC" ) .And. &( cCodFu4 ) <= cMVAteFun

			If TOC->TOC_CC>cMVAteCC .Or. TOC->TOC_CC<cMVDeCC .Or. ;
					TOC->TOC_MAT>cMVAtFunc .Or. TOC->TOC_MAT<cMVDeFunc .Or. ;
					IIf( !Empty( cMvAteDep ), ( TOC->TOC_DEPTO > cMvAteDep .Or. TOC->TOC_DEPTO < cMVDeDep ), .F. )
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			If lDtDevol
				If !Empty( TOC->TOC_DTFIM ) .And. TOC->TOC_DTFIM < cMVDePer
					dbSelectArea( "TOC" )
					dbSkip()
					Loop
				EndIf

				If TOC->TOC_DTENT > cMVAtePer .And. TOC->TOC_DTFIM > cMVAtePer
					dbSelectArea( "TOC" )
					dbSkip()
					Loop
				EndIf

				If TOC->TOC_DTENT < cMVDePer
					If !Empty( TOC->TOC_DTFIM ) .And. TOC->TOC_DTFIM < cMVDePer
						dbSelectArea( "TOC" )
						dbSkip()
						Loop
					EndIf
				EndIf
			Else
				If TOC->TOC_DTENT < cMVDePer .Or. TOC->TOC_DTENT > cMVAtePer
					dbSelectArea( "TOC" )
					dbSkip()
					Loop
				EndIf
			EndIf

			If cMVEnderec == 1	//Se Cobrança usa os endereços de cobrança
				cEnd	:= SM0->M0_ENDCOB
				cBairro	:= SM0->M0_BAIRCOB
				cCidade	:= SM0->M0_CIDCOB
			Else //Se Entidade usa os endereços de entidade
				cEnd	:= SM0->M0_ENDENT
				cBairro	:= SM0->M0_BAIRENT
				cCidade	:= SM0->M0_CIDENT
			EndIf

			cEPI := ""
			dbSelectArea( "TOB" )
			dbSetOrder( nIndTOB )
			If !dbSeek( xFilial( "TOB" ) + &( cCodFu4 ) + TOC->TOC_CC )
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			If TOB->TOB_DTELAB > cMVAtePer .Or. TOB->TOB_DTELAB < cMVDePer
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			dbSelectArea( "SRA" )
			dbSetOrder( 01 )
			If !dbSeek( xFilial( "SRA" ) + TOC->TOC_MAT )
				dbSelectArea( "TOC" )
				dbSkip()
				Loop
			EndIf

			dbSelectArea( "TM0" )
			dbSetOrder( 03 )
			dbSeek( xFilial( "TM0" ) + SRA->RA_MAT )

			lSA1 :=.F.
			If lPrestador
				dbSelectArea( "SA1" )
				dbSetOrder( 1 )
				If dbSeek( xFilial( "SA1" ) + SubStr( SRA->RA_CC, 1, 6 ) )
					lSA1 := .T.
				Else
					dbSelectArea( "SA1" )
					dbSetOrder( 1 )
					If dbSeek( xFilial( "SA1" ) + SubStr( TM0->TM0_CC, 1, 6 ) )
						lSA1 := .T.
					Else
						dbSelectArea( "SA1" )
						dbSetOrder( 1 )
						If dbSeek( xFilial( "SA1" ) + TM0->TM0_Client )
							lSA1 := .T.
						EndIf
					EndIf
				EndIf
			EndIf

			lin := 100
			oPrint:StartPage()

			If lTOBDepto
				oPrint:Box( lin, 100, 1000, 2200 )
				oPrint:Line( 340, 100, 340, 2200 )
				oPrint:Line( 400, 100, 400, 2200 )
				oPrint:Line( 580, 100, 580, 2200 )
				oPrint:Line( 640, 100, 640, 2200 )
				oPrint:Line( 940, 100, 940, 2200 )
				oPrint:Line( 220, 1690, 220, 2200 )

				oPrint:Line( lin, 770, 340, 770 )
				oPrint:Line( lin, 1690, 340, 1690 )
				oPrint:Line( 400, 1630, 580, 1630 )
				oPrint:Line( 940, 100, 940, 2200 )
			Else
				oPrint:Box( lin, 100, 940, 2200 )
				oPrint:Line( 340, 100, 340, 2200 )
				oPrint:Line( 400, 100, 400, 2200 )
				oPrint:Line( 580, 100, 580, 2200 )
				oPrint:Line( 640, 100, 640, 2200 )
				oPrint:Line( 220, 1690, 220, 2200 )

				oPrint:Line( lin, 770, 340, 770 )
				oPrint:Line( lin, 1690, 340, 1690 )
				oPrint:Line( 400, 1630, 580, 1630 )
				oPrint:Line( 640, 1630, 880, 1630 )
				oPrint:Line( 880, 100, 880, 2200 )
			EndIf

			//Verifica o tamanho da imagem
			If FindFunction( "NGLocLogo" )
				If File( NGLocLogo() )
					oPrint:SayBitMap( 175, 185, NGLocLogo(), nLargura, nAltura )
				EndIf
			EndIf

			oPrint:Say( 150, 980, cTxtTit1, oFont15 ) //"ORDEM DE SERVIÇO"
			oPrint:Say( 210, 970, cTxtTit2, oFont15 ) //"POR ATIVIDADE (O.S.)"
			oPrint:Say( 290, 900, STR0004, oFont15 ) //"SEGURANÇA DO TRABALHO"

			oPrint:Say( 170, 1755, STR0005, oFont11t ) //"Data Elaboração:"
			oPrint:Say( 170, 2000, DToC( TOB->TOB_DTELAB ), oFont09 )
			oPrint:Say( 290, 1755, STR0006, oFont11t ) //"Última Revisão:"
			oPrint:Say( 290, 2000, DToC( TOB->TOB_DTREVI ), oFont09 )

			oPrint:Say( 380, 1050, STR0007, oFont13 ) //"Dados da Empresa"

			oPrint:Say( 450, 115, STR0008, oFont11t ) //"Razão Social/Nome:"
			oPrint:Say( 500, 115, STR0009, oFont11t ) //"Endereço:"
			oPrint:Say( 550, 115, STR0010, oFont11t ) //"Cidade:"

			oPrint:Say( 450, 1695, STR0011, oFont11t ) //"CNPJ:"
			oPrint:Say( 500, 1695, STR0012, oFont11t ) //"CNAE:"
			oPrint:Say( 550, 1695, STR0013, oFont11t ) //"Bairro:"

			If lSA1
				oPrint:Say( 450, 370, SubStr( SA1->A1_NOME, 1, 30 ), oFont09 )
				oPrint:Say( 500, 370, SubStr( SA1->A1_END, 1, 36 ), oFont09 )
				oPrint:Say( 550, 370, AllTrim( SA1->A1_MUN ) + IIf( !Empty( SA1->A1_EST ), "-" + SA1->A1_EST, " " ), oFont09 )
				oPrint:Say( 450, 1820, SA1->A1_CGC, oFont09 )
				oPrint:Say( 500, 1820, SA1->A1_ATIVIDA, oFont09 )
				oPrint:Say( 550, 1820, SubStr( A1_BAIRRO, 1, 16 ), oFont09 )
			Else
				oPrint:Say( 450, 500, SM0->M0_NOMECOM, oFont09 )
				oPrint:Say( 500, 500, cEnd, oFont09 )
				oPrint:Say( 550, 500, AllTrim( cCidade ) + IIf( !Empty( SM0->M0_ESTCOB ), "-" + SM0->M0_ESTCOB, " " ), oFont09 )
				oPrint:Say( 450, 1825, SM0->M0_CGC, oFont09 )
				oPrint:Say( 500, 1825, SM0->M0_CNAE, oFont09 )
				oPrint:Say( 550, 1825, cBairro, oFont09 )
			EndIf

			oPrint:Say( 620, 1010, STR0014, oFont13 ) //"Dados do Funcionário"

			oPrint:Say( 690, 115, STR0015, oFont11t ) //"Nome:"
			oPrint:Say( 690, 450, SRA->RA_NOME, oFont09 )

			dbSelectArea( cAliasCC )
			dbSetOrder( 01 )
			If cMVBuscInf == 1
				dbSeek( xFilial( cAliasCC ) + SRA->RA_CC )
			Else
				dbSeek( xFilial( cAliasCC ) + TOB->TOB_CC )
			EndIf

			If lTOBDepto
				dbSelectArea( "SQB" )
				dbSetOrder( 1 ) //QB_FILIAL+QB_DEPTO
				If cMVBuscInf == 1
					dbSeek( xFilial( "SQB" ) + SRA->RA_DEPTO )
				Else
					dbSeek( xFilial( "SQB" ) + TOB->TOB_DEPTO )
				EndIf
			EndIf

			oPrint:Say( 745, 115, STR0016, oFont11t ) //"Centro de Custo:"
			oPrint:Say( 745, 450, &( cDescCC ), oFont09 )

			dbSelectArea( cTabFun )
			dbSetOrder( 01 )
			If cMVBuscInf == 1
				dbSeek( xFilial( cTabFun ) + &( cCodFu2 ) )
			Else
				dbSeek( xFilial( cTabFun ) + &( cCodFu3 ) )
			EndIf

			If !lTOBDepto
				oPrint:Say( 800, 115, STR0017, oFont11t ) //"Função:"
				oPrint:Say( 800, 450, &( cDesFu1 ), oFont09 )
				oPrint:Say( 860, 115, STR0018, oFont11t ) //"CTPS:"
				oPrint:Say( 860, 450, SRA->RA_NUMCP + SRA->RA_SERCP, oFont09 )
			Else
				oPrint:Say( 800, 115, STR0077, oFont11t ) //"Departamento:"
				oPrint:Say( 800, 450, SQB->QB_DESCRIC, oFont09 )
				oPrint:Say( 860, 115, STR0017, oFont11t ) //"Função:"
				oPrint:Say( 860, 450, &( cDesFu1 ), oFont09 )
				oPrint:Say( 920, 115, STR0018, oFont11t ) //"CTPS:"
				oPrint:Say( 920, 450, SRA->RA_NUMCP + SRA->RA_SERCP, oFont09 )
			EndIf

			oPrint:Say( 690, 1695, STR0019, oFont11t ) //"Matrícula:"
			oPrint:Say( 690, 2020, SRA->RA_MAT, oFont09 )
			oPrint:Say( 745, 1695, STR0020, oFont11t ) //"Data Admissão:"
			oPrint:Say( 745, 2020, DToC( SRA->RA_ADMISSA ), oFont09 )
			oPrint:Say( 800, 1695, STR0021, oFont11t ) //"Data Nascimento:"
			oPrint:Say( 800, 2020, DToC( SRA->RA_NASC ), oFont09 )
			oPrint:Say( 860, 1695, STR0022, oFont11t ) //"RG:"
			oPrint:Say( 860, 2020, SRA->RA_RG, oFont09 )

			dbSelectArea( cTabFun ) //SRJ-Funcao ou ZZI-Posto de Trabalho
			dbSetOrder( 01 )
			If cMVBuscInf == 1
				dbSeek( xFilial( cTabFun ) + &( cCodFu2 ) )
			Else
				dbSeek( xFilial( cTabFun ) + &( cCodFu3 ) )
			EndIf

			If !lPosTrab
				dbSelectArea( "SQ3" )
				dbSetOrder( 01 )
				If !dbSeek( xFilial( "SQ3" ) + SRA->RA_CARGO )
					dbSeek( xFilial( "SQ3" ) + SRJ->RJ_CARGO )
				EndIf
			EndIf

			If lTOBDepto
				oPrint:Say( 980, 1050, "Dados da O.S.", oFont13 ) //"Dados da O.S."
			Else
				oPrint:Say( 920, 1050, "Dados da O.S.", oFont13 ) //"Dados da O.S."
			EndIf

			cMemo := " "
			aBloco := {}
			If cMVDescAti == 1
				If lPosTrab
					cMemo := RTrim( ZZI->ZZI_ATIV )
				Else
					cMemo := RTrim( MSMM( SQ3->Q3_DESCDET, , , , , , , , , "RDY" ) )
				EndIf
			ElseIf cMVDescAti == 2
				If SRJ->( FieldPos( "RJ_MEMOATI" ) ) > 0
					cMemo := RTrim( SRJ->RJ_MEMOATI )
				ElseIf !Empty( SRJ->RJ_DESCREQ )
					cMemo := RTrim( MSMM( SRJ->RJ_DESCREQ, , , , , , , , , "RDY" ) )
				EndIf
				cEpiFun := fGetEpiFun( SRJ->RJ_FUNCAO )
				cEPI += cEpiFun
			ElseIf cMVDescAti == 3
				cMemo := RTrim( DescTarefa() )
			EndIf

			aAdd( aBloco, { STR0023, cMemo } ) //"Descrição Função:"
			cMemo := ""

			// Funcao Funcionario //CC Funcionario
			aAgeAssAti := U_MDT715AR( RetDtRefer() )

			If Len( aAgeAssAti ) > 0
				aAdd( aBloco, { STR0024, aAgeAssAti } ) //"Agentes Associados às Atividades:"
			Else
				aAdd( aBloco, {} )
			EndIf

			//Chama Função que verifica os Epis do Centro de Custo
			If cMVBuscInf == 1
				cEPI += fGetEpiCen( SRA->RA_CC, cEPI )//Pesquisa os Epis relacionados ao centro de custo
			Else
				cEPI += fGetEpiCen( TOB->TOB_CC, cEPI )
			EndIf
			aAdd( aBloco, { STR0025, cEPI } ) //"EPI`s de Uso Obrigatório: "

			cMemo := RTrim( TOB->TOB_TEXTO )
			aAdd( aBloco, { STR0026, cMemo } )  //"Recomendações: "
			cMemo := ""

			dbSelectArea( "TMZ" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMZ" ) + TOB->TOB_TERMO )

			cMemo := RTrim( TMZ->TMZ_DESCRI )
			aAdd( aBloco, { STR0027, cMemo } )  //"Termo de Responsabilidade: "

			// Realiza a impressão dos blocos Descrição Função, Agentes Associados,
			// EPI's obrigatórios, Recomendações e Termo de Responsabilidade.

			lin := IIf( lTOBDepto, 1000, 940 )
			For nX := 1 To Len( aBloco )
				If nX == 2
					If Empty( aBloco[nX] )
						Loop
					EndIf
					aAgentes := aClone( aBloco[nX][2] )
					If Len( aAgentes ) > 0
						oPrint:line( lin, 100, lin + 60, 100 )		//|
						oPrint:line( lin, 1300, lin + 60, 1300 )    //|     	       |
						oPrint:line( lin, 1800, lin + 60, 1800 )	//|     	       |     		        |
						oPrint:line( lin, 2200, lin + 60, 2200 )	//|     	       |     		        |                 |

						oPrint:Say( lin + 40, 550, STR0062, oFont11b )	// Agente
						oPrint:Say( lin + 40, 1480, STR0063, oFont11b )	// Quantidade
						oPrint:Say( lin + 40, 1950, STR0064, oFont11b )	// Unidade

						SomaLinha( oPrint, 60 )
						oPrint:line( lin, 100, lin, 2200 ) 					//_________________________________________________________

						For nY := 1 To Len( aAgentes )
							oPrint:line( lin, 100, lin + 60, 100 )				//|
							oPrint:line( lin, 1300, lin + 60, 1300 )			//|                |
							oPrint:line( lin, 1800, lin + 60, 1800 )			//|                |                    |
							oPrint:line( lin, 2200, lin + 60, 2200 )			//|                |                    |                 |

							oPrint:Say( lin + 40, 115, aAgentes[nY][1], oFont11t ) //Agente
							oPrint:Say( lin + 40, 1315, aAgentes[nY][2], oFont11t )//Quantidade
							oPrint:Say( lin + 40, 1815, aAgentes[nY][3], oFont11t )//Unidade

							oPrint:line( lin + 60, 100, lin + 60, 2200 )				//_________________________________________________________

							SomaLinha( oPrint, 60 )
						Next nY
					EndIf
				Else
					cTitle 	:= aBloco[nX][1]
					cMemo	:= aBloco[nX][2]
					cMemoAux:= ""

					//Título do bloco
					oPrint:Say( lin + 40, 115, cTitle, oFont11t )
					oPrint:Line( lin, 0100, lin + 90, 0100 )
					oPrint:Line( lin, 2200, lin + 90, 2200 )
					SomaLinha( oPrint, 30 )
					oPrint:Line( lin + 20, 0100, lin + 20, 2200 )
					SomaLinha( oPrint, 20 )

					//Conteúdo do bloco
					If !Empty( cMemo )
						For nY := 1 To MLCOUNT( cMemo, 125 )
							SomaLinha( oPrint, 40 )
							oPrint:Say( lin + 20, 115, MemoLine( cMemo, 125, nY, , .T. ), oFont10p, 2000 ) //Imprime string parcial
							oPrint:Line( lin, 0100, lin + 41, 0100 )
							oPrint:Line( lin, 2200, lin + 41, 2200 )
						Next nY
						SomaLinha( oPrint, 40 )
						oPrint:Line( lin, 0100, lin, 2200 )
					EndIf
				EndIf
			Next nX

			dbSelectArea( "TMK" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMK" ) + TOB->TOB_CODRES )

			oPrint:Line( lin, 100, lin, 2200 )
			cNOMERES := AllTrim( TMK->TMK_NOMUSU )
			nSize := IIf( Len( cNOMERES ) <= 34, Len( cNOMERES ), 34 )
			If Len( cNOMERES ) > 34
				cNOMERES := SubStr( cNOMERES, 1, 36 )
			EndIf
			nSize := 36 - nSize
			nTabu := 1
			If nSize > 1
				If (nSize % 2) != 0
					nSize++
					nTabu := (nSize / 2) - 1
				Else
					nTabu := nSize / 2
				EndIf
			EndIf
			cCRM:="  "
			nLin:=160
			If !Empty( TMK->TMK_NUMENT )
				cCRM := IIf( Empty( TMK->TMK_ENTCLA ), "CRM", AllTrim( TMK->TMK_ENTCLA ) ) + ": " + AllTrim( TMK->TMK_NUMENT )
				nLin := 200
			EndIf
			nSize2 := IIf( Len( cCRM ) <= 34, Len( cCRM ), 34 )
			If Len( cCRM ) > 34
				cCRM := SubStr( cCRM, 1, 34 )
			EndIf
			nSize2 := 34 - nSize2
			nTabu2 := 1
			If nSize2 > 1
				If (nSize2 % 2) != 0
					nSize2++
					nTabu2 := (nSize2 / 2) - 1
				Else
					nTabu2 := nSize2 / 2
				EndIf
			EndIf

			oPrint:Say( lin + 70, 115, STR0028, oFont13 ) //"Aprovação: "
			oPrint:Say( lin + 90, 700, "__________________________________", oFont11t )
			oPrint:SayAlign( lin + 140, 650, Space( nTabu ) + cNOMERES, oFont10r, 500, 60, , 2 )
			oPrint:SayAlign( lin + 175, 650, Space( nTabu2 ) + cCRM, oFont10r, 500, 60, , 2 )
			oPrint:Say( lin + 100, 1820, STR0029, oFont13 ) //"Data: "
			oPrint:Say( lin + 100, 1950, "  __/__/__  ", oFont15b )
			oPrint:line( lin, 100, lin + nLin, 100 )
			oPrint:line( lin, 2200, lin + nLin, 2200 )
			oPrint:Line( lin, 1800, lin + nLin, 1800 )

			SomaLinha( oPrint, nLin )

			oPrint:Say( lin + 70, 115, STR0049, oFont13 ) //"Colaborador: "
			oPrint:Say( lin + 100, 700, "__________________________________", oFont11t )
			oPrint:SayAlign( lin + 155, 650, Space( nTabu ) + SRA->RA_NOME, oFont10r, 625, 60, , 2 )
			oPrint:Say( lin + 100, 1820, STR0029, oFont13 ) //"Data: "
			oPrint:Say( lin + 100, 1950, "  __/__/__  ", oFont15b )
			oPrint:line( lin, 100, lin + 200, 100 )
			oPrint:line( lin, 2200, lin + 200, 2200 )
			oPrint:Line( lin, 1800, lin + 200, 1800 )

			oPrint:line( lin + 30, 100, lin + 30, 2200 )

			SomaLinha( oPrint, 200 )

			dbSelectArea( "SRA" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "SRA" ) + cMVRespon )

			cNOMERES := AllTrim( SRA->RA_NOME )
			nSize3 := IIf( Len( cNOMERES ) <= 34, Len( cNOMERES ), 34 )
			If Len( cNOMERES ) > 34
				cNOMERES := SubStr( cNOMERES, 1, 34 )
			EndIf
			nSize3 := 34 - nSize3
			nTabu3 := 1
			If nSize3 > 1
				If (nSize3 % 2) != 0
					nSize3++
					nTabu3 := (nSize3 / 2) - 1
				Else
					nTabu3 := nSize3 / 2
				EndIf
			EndIf

			oPrint:line( lin, 100, lin, 2200 )
			oPrint:Say( lin + 60, 115, STR0030, oFont13 ) //"Responsável Empresa: "
			oPrint:Say( lin + 60, 700, "__________________________________", oFont11t )
			oPrint:SayAlign( lin + 110, 650, Space( nTabu3 ) + cNOMERES, oFont10r, 500, 60, , 2 )
			oPrint:Say( lin + 100, 1820, STR0029, oFont13 ) //"Data: "
			oPrint:Say( lin + 100, 1950, "  __/__/__  ", oFont15b )
			oPrint:line( lin, 100, lin + 160, 100 )
			oPrint:line( lin, 2200, lin + 160, 2200 )
			oPrint:Line( lin, 1800, lin + 160, 1800 )

			SomaLinha( oPrint, 160 )
			oPrint:Line( lin, 100, lin, 2200 )

			oPrint:EndPage()
			lin := 100
			dbSelectArea( "TOC" )
			dbSkip()
		End
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Inicia nova pagina

@type    function
@author  Liber De Esteban O. P.
@since   24/11/2003
@sample  SomaLinha( oPrint, 1554 )

@param   oPrint, Objeto, Objeto de impressão
@param   nLinha, Numérico, Número de linha atual

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function SomaLinha( oPrint, nLinha )

	lin += nLinha
	If lin >= 2700
		oPrint:Line( lin, 100, lin, 2200 )
		lin := 100
		oPrint:EndPage()
		oPrint:StartPage()
		oPrint:Line( lin, 100, lin, 2200 )
	EndIf

Return Nil

//------------------------------------------------------------------
/*/{Protheus.doc} MDT715AR
Busca os riscos em que o funcionário está exposto

@author Jackson Machado
@since  20/05/2015
@param  dDtRefer, Data, Data a ser considerada como referência para
busca dos riscos
@sample U_MDT715AR( '01/01/2015' )

@return aAgeAssAti, Array, Contém os agentes
/*/
//---------------------------------------------------------------------
User Function MDT715AR( dDtRefer )

	Local aAgeAssAti := {}

	Default dDtRefer := StoD( Space( 8 ) )

	If cMVBuscInf == 1
		MDTRETRIS( dDtRefer, , , { || fGetAgent( @aAgeAssAti ) }, , , , .F. )
	Else
		MDTRETRIS( dDtRefer, , , { || fGetAgent( @aAgeAssAti ) }, , , , .F., .T. )
	EndIf

Return aAgeAssAti

//------------------------------------------------------------------
/*/{Protheus.doc} fGetAgent
Salva os agentes e os EPI's necessários para o risco

@author Jackson Machado
@since  20/05/2015
@param  aAgeAssAti, Array, Contém os agentes
@sample fGetAgent( @{} )

@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function fGetAgent( aAgeAssAti )

	Local nIdx		:= 1
	Local cSeek		:= "xFilial('TNX')+TN0->TN0_NUMRIS"
	Local cCondWhl	:= ".T."
	Local aTamSX3	:= TAMSX3( "TN0_QTAGEN" )

	If lSigaMdtPs
		nIdx	 := 4
		cSeek	 := "xFilial('TNX')+cCliMdtps+TN0->TN0_NUMRIS"
		cCondWhl := "cCliMdtps == TNX->(TNX_CLIENT+TNX_LOJA)"
	EndIf

	dbSelectArea( "TMA" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "TMA" ) + TN0->TN0_AGENTE )

		If lAgen
			aAdd( aAgeAssAti, {	AllTrim( TMA->TMA_NOMAGE ), AllTrim( StrTran( Str( TN0->TN0_QTAGEN, aTamSX3[1], aTamSX3[2] ), ".", "," ) ), ;
			AllTrim( TN0->TN0_UNIMED ) } )
		EndIf

		dbSelectArea( "TNX" )
		dbSetOrder( nIdx )
		dbSeek( &( cSeek ) )
		While TNX->( !Eof() ) .And. xFilial( "TNX" ) == TNX->TNX_FILIAL .And. TN0->TN0_NUMRIS == TNX->TNX_NUMRIS .And. &( cCondWhl )
			dbSelectArea( "SB1" )
			dbSetOrder( 1 )
			If dbSeek( xFilial( "SB1" ) + TNX->TNX_EPI ) .And. !( AllTrim( SB1->B1_DESC ) $ cEPI )
				cEpi += AllTrim( SB1->B1_DESC ) + ";  "
			EndIf
			dbSelectArea( "TNX" )
			dbSkip()
		End
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} DescTarefa
Busca descrição da tarefa

@type    function
@author  Denis Hyroshi
@since   21/03/2007
@sample  DescTarefa( '00101' )
@param   cCliMdtps, Caractere, Código do Cliente mais o Código da loja

@return  cRet, Caractere, Descrição da tarefa
/*/
//-------------------------------------------------------------------
Static Function DescTarefa( cCliMdtps )

	Local lNoJob := .T.
	Local dtIni  := dDataBase
	Local dtFim  := dDataBase+1
	Local cRet   := ""

	Local cSeekTN5	:= IIf( lSigaMdtPS, "xFilial('TN5') + cCliMdtps + TN6->TN6_CODTAR", "xFilial( 'TN5' ) + TN6->TN6_CODTAR" )
	Local nIndexTN5	:= IIf( lSigaMdtPS, 3, 1 )

	dbSelectArea( "TN6" )
	dbSetOrder( 2 )
	dbSeek( xFilial( "TN6" ) + SRA->RA_MAT )
	While !Eof() .And. xFilial( "TN6" ) == TN6->TN6_FILIAL .And. SRA->RA_MAT == TN6->TN6_MAT

		If TN6->TN6_DTINIC >= dtFim .Or. ( TN6->TN6_DTTERM < dtIni .And. !Empty( TN6->TN6_DTTERM ) )
			dbSelectArea( "TN6" )
			dbSkip()
			Loop
		EndIf

		If TN6->TN6_DTINIC == dtIni
			lStart  := .T.
		Elseif TN6->TN6_DTINIC < dtIni .And. ( TN6->TN6_DTTERM >= dtIni  .Or. Empty( TN6->TN6_DTTERM ) )
			lStart  := .T.
		EndIf

		If lStart
			dbSelectArea( "TN5" )
			dbSetOrder( nIndexTN5 ) //TN5_FILIAL(+TN5_CLIENT+TN5_LOJA)+TN5_CODTAR
			dbSeek( &cSeekTN5 )
			If !lNoJob
				cRet += chr( 13 ) + chr( 10 )
			EndIf
			If TN5->( FieldPos( "TN5_DESCRI" ) ) > 0
				If !Empty( TN5->TN5_DESCRI )
					cRet += AllTrim( TN5->TN5_DESCRI ) + chr( 13 ) + chr( 10 )
				EndIf
			Else
				If !Empty( TN5->TN5_DESTAR )
					cRet += AllTrim( TN5->TN5_DESTAR ) + chr( 13 ) + chr( 10 )
				EndIf
				If !Empty( TN5->TN5_DESCR1 )
					cRet += AllTrim( TN5->TN5_DESCR1 ) + chr( 13 ) + chr( 10 )
				EndIf
				If !Empty( TN5->TN5_DESCR2 )
					cRet += AllTrim( TN5->TN5_DESCR2 ) + chr( 13 ) + chr( 10 )
				EndIf
				If !Empty( TN5->TN5_DESCR3 )
					cRet += AllTrim( TN5->TN5_DESCR3 ) + chr( 13 ) + chr( 10 )
				EndIf
				If !Empty( TN5->TN5_DESCR4 )
					cRet += AllTrim( TN5->TN5_DESCR4 ) + chr( 13 ) + chr( 10 )
				EndIf
			EndIf
			lNoJob := .F.
		EndIf

		dbSelectArea( "TN6" )
		dbSkip()
	End

Return cRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT715SRA
Valida campo Codigo Representante

@type    function
@author  Denis Hyroshi
@since   21/03/2007
@sample  U_MDT715SRA()

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function MDT715SRA()

	If !Empty( Mv_par14 )
		If !ExCpoMDT( 'SRA', Mv_par14 )
			Return .F.
		ElseIf lSigaMdtPS
			If SubStr( SRA->RA_CC, 1, nSizeTD ) < Mv_par01 + Mv_par02 .Or. SubStr( SRA->RA_CC, 1, nSizeTD ) > Mv_par03 + Mv_par04
				Help( " ", 1, "REGNOIS" )
				Return .F.
			EndIf
		EndIf
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} RetDtRefer
Define data de referencia para avaliacao dos riscos, a partir da data
de Elaboracao e/ou Revisao. Caso haja data de revisao, sera considerada
prioritaria em relacao a de elaboracao.

@type    function
@author  Hugo R. Pereira
@since   08/10/2012
@sample  RetDtRefer( 35 )
@param   nRecTOB, Numérico, Número do registro da TOB

@return dDtRefer, Data, Referência da avaliação
/*/
//---------------------------------------------------------------------
Static Function RetDtRefer( nRecTOB )

	Local dDtRefer := CTOD( "" )
	Local lRecno   := .F.

	// Armazena areas de trabalho
	Local aArea    := {}
	Local aAreaTOB := {}

	Default nRecTOB := 0

	// Verifica se foi repassado recno
	If ( lRecno := ( nRecTOB > 0 ) )

		aArea    := GetArea()
		aAreaTOB := TOB->(GetArea())

		dbSelectArea( "TOB" )
		dbgoto( nRecTOB )

	EndIf

	// Caso haja data de revisao, desconsidera data de elaboracao
	dDtRefer := IIf( !Empty( TOB->TOB_DTREVI ), TOB->TOB_DTREVI, TOB->TOB_DTELAB )

	// Retorna areas de trabalho apenas se houve passagem de recno
	If lRecno
		RestArea( aAreaTOB )
		RestArea( aArea )
	EndIf

Return dDtRefer

//---------------------------------------------------------------------
/*{Protheus.doc} fGetEpiFun()
Busca os EPIs relacionados a função

@author  Bruno L. Souza
@since   26/07/2013
@sample  fGetEpiFun( '0001' )
@param   cCodFun, Caractere, Código da função

@return  cEpiFun, Caractere, Contém as decrições dos EPIs
*/
//---------------------------------------------------------------------
Static Function fGetEpiFun( cCodFun )

	Local cEpiFun := ""

	dbSelectArea( "TNB" )
	dbSetOrder( 2 )
	If dbSeek( xFilial( "TNB" ) + cCodFun )
		While( xFilial( "TNB" ) == TNB->TNB_FILIAL .And. cCodFun == TNB->TNB_CODFUN )
			cEpiFun += AllTrim( NGSEEK( "SB1", TNB->TNB_CODEPI, 1, "B1_DESC" ) ) + "; "
			dbSkip()
		End
	EndIf

Return cEpiFun

//---------------------------------------------------------------------
/*/{Protheus.doc} fGetEpiCen
Busca os Epis relacionados ao Centro de Custo.

@author Guilherme Freudenburg
@since  29/08/2014
@sample fGetEpiCen( '00001', '' )
@param  cCentro, Caractere, Código do Centro de Custo
@param  cEpi, Caractere, Descrição dos EPIs

@return cEpiFun, Caractere, Contém as descrições dos EPIs
/*/
//---------------------------------------------------------------------
Static Function fGetEpiCen( cCentro, cEpi )

	Local cEpiFun := ""
	Local cVerEpi := ""

	dbSelectArea( "TOH" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "TOH" ) + cCentro )
		While TOH->( !Eof() ) .And. xFilial( "TOH" ) == TOH->TOH_FILIAL .And. cCentro == TOH->TOH_CC
			cVerEpi := AllTrim( NGSEEK( "SB1", TOH->TOH_CODEPI, 1, "B1_DESC" ) ) + "; "
			If !( cVerEpi $ cEpi ) .Or. Empty( cEpi )
				cEpiFun += cVerEpi
			EndIf
			TOH->( dbSkip() )
		End
	EndIf

Return cEpiFun

//---------------------------------------------------------------------
/*/{Protheus.doc} fChkMDTSX1
Busca Informações para o relatório

@author Guilherme Benkendorf
@since  29/09/2015
@sample fChkMDTSX1( )

@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function fChkMDTSX1( )

	dbSelectArea( "TM0" )
	If  TM0->( FieldPos( "TM0_CODPOS" ) ) > 0 .And. SRA->( FieldPos( "RA_POSTO" ) ) > 0 .And. TN0->( FieldPos( "TN0_CODPOS" ) ) > 0 .And. ;
		( TAMSX3( "ZZI_COD" )[1] ) > 0

		cTxtTit1 := "   PROCEDIMENTO"
		cTxtTit2 := "    DE SEGURANÇA"
		lPosTrab := .T.
		nIndTN0  := 8
		nIndTOB  := 4
		nInDToC  := 3
		cCodFu1  := "TN0->TN0_CODPOS"
		cCodFu2  := "SRA->RA_POSTO"
		cCodFu3  := "TOB->TOB_CODPOS"
		cCodFu4  := "TOC->TOC_CODPOS"
		cDesFu1  := "ZZI->ZZI_DESC"
		nSizeSRJ := ( TAMSX3( "ZZI_COD" )[1] )
		cTabFun  := "ZZI"
		strFuncao := STR0048 //"Posto Trab."
	EndIf

Return Nil
