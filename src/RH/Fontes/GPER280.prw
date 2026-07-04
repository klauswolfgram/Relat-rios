/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER280.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao      ³ GPER280  ³ Autor ³ Wiliam                    ³ Data ³ 30/01/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao   ³ Impressao de Cheques                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ FNC        ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Raquel Hager³13/03/13³M12RH01     ³Unificacao com fonte padrao - inclusao de ³±±
±±³            ³        ³RQ4503      ³pto de entrada e correcoes.               ³±±
±±³Gabriel A.  ³05/05/16³TUWNIV      ³Retirada da opção "Editar" quando a tabela³±±
±±³            ³        ³            ³SM3 não existe                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER280()

	Local aSays := {}, aButtons:= {}
	Local cCadastro := OemtoAnsi(STR0001) //"Impressão de Cheques"
	Local lExistSM3 := SM3->(ColumnPos( "M3_FILIAL" )) <> 0
	
	cContaCont := ""
	cItemCont  := ""
	cHistCont  := ""

	aAdd(aSays,OemToAnsi( STR0018 )) //"Para Emitir Títulos clique em Imprimir"
	aAdd(aSays,OemToAnsi( STR0019 )) //"Para acessar a rotina de Manutenção de Títulos clique em Editar"
	aAdd(aSays,OemToAnsi( STR0020 )) //"Clique em Cancelar para sair."

	If FWHasEAI("GPEA281",.T.,.F.,.T.) .And. SuperGetMv('MV_INTGTRB',.F.)
		aAdd(aButtons, { 5 ,.T.,{|| Pergunte("GPEA281",.T.) } } ) //Param.
	EndIf
	aAdd(aButtons, { 6 ,.T.,{|| FechaBatch(), PreProcess() } } ) //Imprimir
	If lExistSM3
		aAdd(aButtons, { 11,.T.,{|| FechaBatch(), GPEA281()    } } ) //Editar - Chama a rotina de manutenção de Cheques
	EndIf
	aAdd(aButtons, { 2 ,.T.,{|| FechaBatch()               } } ) //Cancelar
	
	FormBatch( cCadastro, aSays, aButtons )

Return( Nil )

/*/{Protheus.doc}PreProcess
Chama o processamento para emissão
@author Gabriel de Souza Almeida
@since 03/11/2015
@version P12
/*/
Static Function PreProcess()
	// Define Variaveis Locais do Programa
	Local oDlg1
	Local cDesc1 := STR0002 //"Este programa imprime os cheques com o valor liquido a receber"
	Local cDesc2 := STR0003 //"dos funcionarios."
	Local cString := "SRA" //Alias do arquivo principal (Base)
	Local aOrd := {} //Ordem do Relatorio
	Local lExistSM3 := SM3->(ColumnPos( "M3_FILIAL" )) <> 0

	// Define Variaveis Private(Basicas)
	Private aReturn  := {STR0016, 1,STR0017, 2, 2, 1, "",1 }	//"Zebrado"###"Administra‡„o"
	Private nomeprog :="Gper280"
	Private nLastKey := 0
	Private cPerg    :="GPER280"
	
	// Variaveis Utilizadas na funcao IMPR
	Private TITULO := OemToAnsi( STR0001 ) //"Impressao de Cheque" 
	Private AT_PRG := nomeprog 
	Private nTamanho := "M" 
	Private lMesNum
	
	If lExistSM3 .And. FWHasEAI("GPEA281",.T.,.F.,.T.) .And. SuperGetMv('MV_INTGTRB',.F.)
		Pergunte("GPEA281",.F.)

		cContaCont := MV_PAR01
		cItemCont  := MV_PAR02
		cHistCont  := MV_PAR03
	EndIf
	
	Pergunte(cPerg,.F.)
	
	// Envia controle para a funcao SETPRINT
	wnrel:="GPER280" //Nome Default do relatorio em Disco
	wnrel:=SetPrint(cString,wnrel,cPerg,@TITULO,cDesc1,cDesc2,,.F.,aOrd,,nTamanho,,.F.)
	
	IF nLastKey = 27
		Return
	EndIF
	
	SetDefault(aReturn,cString)
	
	IF nLastKey = 27
		Return
	EndIF
	
	RptStatus( {|lEnd| GPR280PROCESSA(@lEnd,wnRel,cString)}, TITULO )
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao      ³ GPR280PROCESSA ³ Autor ³ Equipe RH         ³ Data ³ --/--/-- ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao   ³ Impressao de Cheques.                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GPR280PROCESSA(lEnd,WnRel,cString)
//Define Variaveis Locais do Programa                          
Local aCodFol		:= {}
Local aInfo			:= {}
Local aValBenef     := {}   
Local aRet			:= {}
Local aParamPE		:= {}
Local lRet			:= .T.	
Local cFilialAnt	:= Space(FwGetTamFilial)
Local cFilGravar	:= Space(FwGetTamFilial)
Local cComConta
Local cBanco
Local cAgencia
Local cConta
Local cExclui		:= ""
Local nCntP              
Local nBusca
Local nValor
Local nOrdem   
Local nLayOut

Local cContaCred := ""
Local lErro := .F.
Local nErros := 0
Local cFileLog := ""
Local lExistSM3 := SM3->(ColumnPos( "M3_FILIAL" )) <> 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³P.E. Existentes		             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local lGPR280GVBlock  :=  ExistBlock( "GPR280GV"	) 
	
	// Variaveis de Acesso do Usuario                               
	Private cAcessaSR1	:= &( " { || " + ChkRH( "GPER280" , "SR1" , "2" ) + " } " )
	Private cAcessaSRA	:= &( " { || " + ChkRH( "GPER280" , "SRA" , "2" ) + " } " )
	Private cAcessaSRC	:= &( " { || " + ChkRH( "GPER280" , "SRC" , "2" ) + " } " )
	Private cAcessaSRD	:= &( " { || " + ChkRH( "GPER280" , "SRD" , "2" ) + " } " )
	Private cAcessaSRG	:= &( " { || " + ChkRH( "GPER280" , "SRG" , "2" ) + " } " )
	Private cAcessaSRH	:= &( " { || " + ChkRH( "GPER280" , "SRH" , "2" ) + " } " )
	Private cAcessaSRR	:= &( " { || " + ChkRH( "GPER280" , "SRR" , "2" ) + " } " )

	Private aRoteiros	:= {} 
	Private cBenef
	Private cNumCheq
	Private titulo		:=	STR0012		//"Emiss„o de Cheques em Formul rio Cont¡nuo"
	Private lComp   	:= .T.
	Private lLayOut 	:= .F.
	Private lTeste		:= .F.		// Variavel usada ImpCheq
	Private nLinVlr 	:= 0 
	Private nTotDel 	:= 0       
    
	nLayOut:= Iif(nLayOut == Nil, 1, nLayOut)  

	// Bloco que definira a Consistencia da Parametrizacao dos Intervalos 
	// selecionados nas Perguntas De? Ate? para o Skip/Loop.                     
	cExclui := cExclui + "(RA_FILIAL	< cFilDe    .or. RA_FILIAL  > cFilAte    ).or."
	cExclui := cExclui + "(RA_MAT		< cMatDe    .or. RA_MAT     > cMatAte    ).or." 
	cExclui := cExclui + "(RA_NOME		< cNomDe    .or. RA_NOME    > cNomAte    ).or." 
	cExclui := cExclui + "(RA_CC		< cCcDe     .or. RA_CC      > cCcAte     ).or." 
	cExclui := cExclui + "!(			 	RA_SITFOLH $ cSituacao				 )"
	
	cExclui := &( "{||" + cExclui + "}" )

	// Recebe as Perguntas Selecionadas                             
	nOrdem     := mv_par04
	nLiqVer    := mv_par05
	cVerba     := mv_par06
	dDataDe    := mv_par07
	dDataAte   := mv_par08
	cComConta  := If(mv_par09 == 1,"C",(If(mv_par09 == 2,"S","A")))
	cFilDe     := mv_par10
	cFilAte    := mv_par11
	cCCDe      := mv_par12
	cCCAte     := mv_par13
	cMatDe     := mv_par14
	cMatAte    := mv_par15
	cNomDe	   := mv_par16
	cNomAte    := mv_par17
	cSituacao  := mv_par18
	cBanco     := mv_par19
	cAgencia   := mv_par20
	cConta     := mv_par21
	cNumCheq   := mv_par22
	nFunBenAmb := mv_par23  // 1-Funcionarios  2-Beneficiarias  3-Ambos
	
	// Carregando array aRoteiros com os roteiros selecionados      
	// em mvpar01, mvpar02 e mvpar03.                               
   	If Len(mv_par01) > 0 .Or. Len(mv_par02) > 0 .Or. Len(mv_par03) > 0
		SelecRoteiros(If(nLiqVer==1,Nil,cVerba))
   	EndIf
	
	// Se o Banco/Agencia/Conta nao estiverem Cadastrados           
	If !SA6->( dbSeek( xFilial("SA6")+cBanco+cAgencia+cConta ) )
		Help(" ",1,"BCONOEXIST")
		Return
	EndIf
	
	// Define se devera ser impresso Funcionarios ou Beneficiarios  
	dbSelectArea( "SRQ" )
	lImprFunci  := ( nFunBenAmb # 2 )
	lImprBenef  := ( nFunBenAmb # 1 .And. FieldPos( "RQ_BCDEPBE" ) # 0 .And. FieldPos( "RQ_CTDEPBE" ) # 0 )
	
	// Informa a nao existencia dos campos de bco/age/conta corrente
	If nFunBenAmb # 1 .And. !lImprBenef
		fAvisoBC()
		Return .F.
	EndIf
	
	// Procura primeiro funcionario                                 
	dbSelectArea( "SRA" )
	If nOrdem = 1
		dbSetOrder( 1 )
		dbSeek( cFilDe + cMatDe , .T. )
	ElseIf nOrdem = 2
		dbSetOrder( 2 )
		dbSeek( cFilDe + cCcDe + cMatDe , .T. )
	ElseIf nOrdem = 4
		dbSetOrder( 8 )
		dbSeek( cFilDe + cCcDe + cNomDe , .T. )
	Else
		dbSetOrder( 3 )
		dbSeek( cFilDe + cNomDe , .T. )
	EndIf	

	// Se ja Existir Numero de Cheque no SEF                        
	dbSelectArea("SEF")
	dbSetOrder(1)
	If (dbSeek(If(Empty(xFilial("SEF")),xFilial("SEF"),SRA->RA_FILIAL)+cBanco+cAgencia+cConta+cNumCheq))
		Help( " ",1,"A460CHEQUE") // "Este numero de cheque já se encontra cadastrado no sistema."    
	    Return
	EndIf
	dbSelectArea("SRA")
	
	//-- Preparar a Impressora 
	aDriver := LEDriver()
	SetPrc(000,000)
	If aReturn[4] == 1  // Comprimido
		@ 0,0 PSAY &(if(nTamanho=="P",aDriver[1],If(nTamanho=="G",aDriver[5],aDriver[3])))
	Else					  // Normal
		@ 0,0 PSAY &(if(nTamanho=="P",aDriver[2],If(nTamanho=="G",aDriver[6],aDriver[4])))
	Endif
	
	dbSelectArea( "SRA" )
	
	// Carrega Regua de Processamento                               
	SetRegua(SRA->(RecCount()))
	
	Begin Sequence
		While !EoF()
		
			// Movimenta Regua de Processamento                             
			IncRegua()
	
			If lEnd
				@Prow()+1,0 PSAY cCancel
				Exit
			EndIf

			// Zera valor do liquido e pensao                               
			nValor    := 0
			aValBenef := {}
	
			// Carrega codigos da folha                                     
			If SRA->RA_FILIAL # cFilialAnt
				If !FP_CODFOL(@aCodFol,SRA->RA_FILIAL) .Or. !fInfo(@aInfo,SRA->RA_FILIAL)
					Exit
				EndIf
				cFilialAnt := SRA->RA_FILIAL
			EndIf

	        // Consiste o De / Ate e Situacao da Folha                      
			If SRA->( Eval( cExclui ) )
				dbSelectArea('SRA')
				dbSkip()
				Loop
			EndIf   
	
			// Consiste Filiais e Acessos                                             
			If !( SRA->RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA )
				dbSelectArea("SRA")
			   	dbSkip()
		       	Loop
			EndIf
	
			// Consiste conta deposito salario                              
			If (cComConta = "C" .And. SRA->RA_CTDEPSA = SPACE(LEN(SRA->RA_CTDEPSA))) .Or.;
			   (cComConta = "S" .And. SRA->RA_CTDEPSA # SPACE(LEN(SRA->RA_CTDEPSA)))
				dbSkip()
				Loop
			EndIf
	        
   			If Len(aRoteiros) > 0
				// Busca os valores de Liquido e Pensao                         
				Gp020BuscaLiq(@nValor,@aValBenef,cVerba)	
				cTipo := aRoteiros[1,1]
            Else  
            	dbSkip()
				Loop
            EndIf
            
			// Consiste se existe liquido a ser gerado                      
	        cFilGravar := If(xFilial("SEF") == Space(FwGetTamFilial),xFilial("SEF"),SRA->RA_FILIAL)

			// Inclui o funcionario no array para emissao do cheque         
			If lImprFunci
				Aadd(aValBenef, {  SRA->RA_NOME, "", "", "", nValor } )
			EndIf

			// Ponto de Entrada antes da gravacao do Cheque                       
	        If lGPR280GVBlock  
		       
		       lRet			:= .T.
		       aParamPE    	:= { cFilGravar	, cNumCheq, aClone(aValBenef), cTipo, cBanco, cAgencia, cConta,;
		       					 dDataBase	, SRA->RA_MAT } 
		
		       //-- Verifica se o retorno do PE eh valido
			   If !( ValType( aRet := ExecBlock("GPR280GV",.F.,.F.,{aParamPE}) ) == "A" )
				   //-- Se o retorno nao eh valido prossegue com o processamento
				   lRet:= .T.
			   Else
			   	  //-- Verifica o retorno de cada informacao. Retorno invalido eh desconsiderado e o processamento
			   	  //-- prossegue como se fosse normal 
			   	  lRet		:= If (( Alltrim(Upper(ValType(aRet[1])) ) == "L"), aRet[1], .T. )
			   	  aValBenef	:= If (( Alltrim(Upper(ValType(aRet[2])) ) == "A"), aClone(aRet[2]), aParamPE[3] )
			   EndIf
			   
			   //-- Desconsidera o empregado/beneficiario a pedido do PE
	           If !lRet	
	       			dbSelectArea("SRA")
				   	dbSkip()
			       	Loop
	           EndIf
	           	
	        EndIf   
        
			If (nLayOut == 1 .And. Empty( SA6->A6_LAYOUT )) .Or. (nLayOut == 2 .And. Empty( SA6->A6_LAYIPMF ))
				 Help(" ",1,"CHEQNAOCONF")	// "Para que seja feita a emissao de cheques deste banco sera necessario que seja configurado     
				 Break                      // a formatacao neste banco no menu miscelanea/arquivos/cheques do Modulo Financeiro."   
			Else
				For nCntP := 1 To Len(aValBenef)
					//Verifica valor e banco/agencia dos beneficiarios
					If aValBenef[nCntP,5] > 0
						If lExistSM3
							cContaCred := Posicione("SA6", 1, xFilial("SA6",cFilGravar)+cBanco+cAgencia+cConta, "A6_CONTA")
							
							aDadosAuto:= {{'M3_FILIAL'  , xFilial("SM3",cFilGravar)  },;
											{'M3_BANCO'   , cBanco                     },;
											{'M3_AGENCIA' , cAgencia                   },;
											{'M3_CONTA'   , cConta                     },;
											{'M3_NUMCHEQ' , cNumCheq                   },;
											{'M3_DTEMISS' , dDataBase                  },;
											{'M3_VALOR'   , aValBenef[nCntP,5]         },;
											{'M3_TIPO'    , cTipo                      },;
											{'M3_BENEF'   , aValBenef[nCntP,1]         },;
											{'M3_MAT'     , SRA->RA_MAT                },;
											{'M3_IMPRESS' , "S"                        },;
											{'M3_CREDITO' , cContaCred                 },;
											{'M3_DEBITO'  , cContaCont                 },;
											{'M3_ITEMC'   , cItemCont                  },;
											{'M3_CODHIST' , cHistCont                  }}
	
							//Incluindo o cheque na SM3
							lErro := !fExecAut( 'SM3', aDadosAuto )
						
							If lErro
								nErros++
							EndIf
						EndIf
						
						If !lErro .Or. !lExistSM3
							RecLock( "SEF" , .T. )
							SEF->EF_FILIAL  := cFilGravar
							SEF->EF_NUM     := cNumCheq
							SEF->EF_TIPO    := cTipo
							SEF->EF_BANCO   := cBanco
							SEF->EF_AGENCIA := cAgencia
							SEF->EF_BENEF   := aValBenef[nCntP,1]
							SEF->EF_VALOR   := aValBenef[nCntP,5]
							SEF->EF_FORNECE := SRA->RA_MAT
							SEF->EF_CONTA   := cConta
							SEF->EF_DATA    := dDataBase
							DbSelectArea("SEF")
							MsUnlock()
							
							// Ponto de Entrada antes da Impressao de Cheque
							If ExistBlock("GP280CHQ")
								ExecBlock("GP280CHQ",.F.,.F.)
							EndIf
							
							//Impressao do Cheque
							If !ImpCheq(cBanco,cAgencia,cConta,.T.,cFilGravar,,,aDriver)
								Exit
							EndIf
						EndIf
					EndIf
				Next nCntP
			EndIf
			// Proximo Funcionario
			dbSelectArea( "SRA" )
			dbSkip()
		Enddo
	End Sequence
	// Termino do relatorio
	dbSelectArea( "SRA" )
	Set Filter to
	dbSetOrder(1)
	Set Device To Screen
	If aReturn[5] = 1
		Set Printer To
		Commit
		ourspool(wnrel)
	Endif
	MS_FLUSH()
	
	If nErros > 0
		cFileLog := NomeAutoLog()
		If cFileLog <> ""
			MostraErro("",cFileLog)
		EndIf
	EndIf

Return

/*/{Protheus.doc} fExecAut
Grava os cheques na SM3
@author Gabriel de Souza Almeida
@since 03/11/2015
@version P12
@param cMaster, varchar, Tabela onde os dados serão gravados
@param aCpoMaster, array, Campos e seus respectivos conteúdos
@return lRet
/*/
Static Function fExecAut( cMaster, aCpoMaster )
	Local oModel, oAux, oStruct
	Local nI        := 0
	Local nJ        := 0
	Local nPos      := 0
	Local lRet      := .T.
	Local aAux      := {}
	Local aC        := {}
	Local aH        := {}
	Local nItErro   := 0
	Local lAux      := .T.
	
	DbSelectArea( cMaster )
	DbSetOrder( 1 )
	
	// Instanciamento do modelo de dados (Model)
	oModel := FWLoadModel( 'GPEA281' )
	oModel:SetOperation( 3 )
	oModel:Activate()
	
	oAux := oModel:GetModel( "GPEA281_MSM3" )
	
	oStruct := oAux:GetStruct()
	aAux := oStruct:GetFields()
	
	If lRet
		For nI := 1 To Len( aCpoMaster )
			// Verifica se os campos passados existem na estrutura do cabeçalho
			If ( nPos := aScan( aAux, { |x| AllTrim( x[3] ) ==  AllTrim( aCpoMaster[nI][1] ) } ) ) > 0
				If !( lAux := oModel:SetValue( 'GPEA281_MSM3', aCpoMaster[nI][1], aCpoMaster[nI][2] ) )
					lRet := .F.
					Exit
				EndIf
			EndIf
		Next
	EndIf
	
	If lRet
		If ( lRet := oModel:VldData() )
			lRet := oModel:CommitData()
		EndIf
	EndIf
	
	If !lRet
		aErro := oModel:GetErrorMessage()
		lAutoErrNoFile := .F.
		// A estrutura do vetor com erro é:
		//  [1] Id do formulário de origem
		//  [2] Id do campo de origem
		//  [3] Id do formulário de erro
		//  [4] Id do campo de erro
		//  [5] Id do erro
		//  [6] mensagem do erro
		//  [7] mensagem da solução
		//  [8] Valor atribuido
		//  [9] Valor anterior

		AutoGrLog( "Id do formulário de origem:" + ' [' + AllToChar( aErro[1]  ) + ']' )
		AutoGrLog( "Id do campo de origem:     " + ' [' + AllToChar( aErro[2]  ) + ']' )
		AutoGrLog( "Id do formulário de erro:  " + ' [' + AllToChar( aErro[3]  ) + ']' )
		AutoGrLog( "Id do campo de erro:       " + ' [' + AllToChar( aErro[4]  ) + ']' )
		AutoGrLog( "Id do erro:                " + ' [' + AllToChar( aErro[5]  ) + ']' )
		AutoGrLog( "Mensagem do erro:          " + ' [' + AllToChar( aErro[6]  ) + ']' )
		AutoGrLog( "Mensagem da solução:       " + ' [' + AllToChar( aErro[7]  ) + ']' )
		AutoGrLog( "Valor atribuido:           " + ' [' + AllToChar( aErro[8]  ) + ']' )
		AutoGrLog( "Valor anterior:            " + ' [' + AllToChar( aErro[9]  ) + ']' )
	
		If nItErro > 0
			AutoGrLog( "Erro no Item:              " + ' [' + AllTrim( AllToChar( nItErro  ) ) + ']' )
		EndIf
	EndIf
	
	// Desativamos o Model
	oModel:DeActivate()
Return lRet