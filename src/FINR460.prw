/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR460.CH"
#INCLUDE "PROTHEUS.CH"

Static __lIsRmt64 := FindFunction("IsRmt64")
// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ FINR460	³ Autor ³ Paulo Boschetti		  ³ Data ³ 09.07.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impress„o de Cheques 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR460(void)															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 																			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FinR460()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define vari veis 	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL aCheque[10]
LOCAL nRet
LOCAL cNumCheq
LOCAL cNome 		:= Space(20)
LOCAL lEnd			:=.F.
LOCAL oDlg
LOCAL oCBXImp
Local cRet
Local cBenef 		:= ""
Local cHistor 	:= ""
Local nHdl460 	:= 0
Local nTamArq 	:= 0
Local nLidos  	:= 0
Local xBuffer 	:= Space(37)
Local cUser460	:= Space(15)
Local cImp460 	:= Space(20)
Local lF460MSG 	:= ExistBlock("F460MSG")
Local lF460OK 	:= ExistBlock("F460OK")
Local cLista 		:= " "
Local aImpChq 	:= {}
Local lLojaDll 	:= .F.  //Verifica se utiliza SigalojaDll
Local cTmpMun
Local lF460BXT 	:= ExistBlock("F460BXT")
Local lClosePort	:= .T.
Local lMovbco 	:= GetMv("MV_LIBCHEQ")="S"
Local aDados		:= {}
Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}
Local lImprimiu 	:= .F.
Local lAchouCh	:= .F.
Local nRecAnt		:= 0
Local nRegProx	:= 0
Local nRegOri		:= 0

Local oModelMov	:= FWLoadModel("FINM030")
Local oSubFK5
Local oSubFKA
Local cLog			:= ""
Local cCamposE5	:= ""
Local cChaveCH	:= ""
Local lRet := .T.
Local lGravaFKA	:= .F.
Local lF460BENEF  := ExistBlock("F460BENEF")
Local aHelpx65		:= {}
Local nBuildVer  := VAL(SUBSTR( GetBuild(.T.), 6, 2 ))
Local aTest :=  GetRmtInfo()

PRIVATE titulo 	:=OemToAnsi(STR0001)  //"Cheques Especiais"
PRIVATE cabec1
PRIVATE cabec2
PRIVATE aReturn	:= { OemToAnsi(STR0002), 1,OemToAnsi(STR0003), 1, 2, 1, "",1 }  //"Cheque"###"Administracao"
PRIVATE nomeprog	:="FINR460"
PRIVATE nLastKey	:= 0
PRIVATE cPerg		:="FIN460"
PRIVATE cImprVerso:= AllTrim( GetMv("MV_IMPVER") )
PRIVATE cDesc1 	:= OemToAnsi(STR0004)  //"Este programa ir  imprimir os Cheques do Banco Selecionado"
PRIVATE cDesc2 	:= OemToAnsi(STR0005)  //"na impressora padr„o selecionada."
PRIVATE nHdll

// ------------------------------------------------------------------------------
// Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso 
// aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
If RetGlbLGPD("EF_BENEF")
	Help(" ",1,"DADO_PROTEGIDO")
	RETURN
ENDIF
// ------------------------------------------------------------------------------

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Handle da biblioteca para impress„o serial        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nHdll := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN460",.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a existencia de arquivo INI para selecionar impres- ³
//³ sora de acordo com usuario. O arquivo devera ter a seguinte  ³
//³ configuracao:                            					     ³
//³                                         							  ³
//³ Descricao 			Tamanho		Pos Ini		Pos Fim 				  ³
//³ Usuario       	015			001			015					  ³
//³ Nome Impressora	020			016			036					  ³
//³                                   									  ³
//³ Cada linha deste arquivo dever  ser encerrada com CHR(10)+	  ³
//³ CHR(13)																		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF FILE("FINR460.INI")
	nHdl460 := fOpen("FINR460.INI")
	If nHdl460 > 0
		nTamArq := fSeek(nHdl460,0,2)
		fSeek(nHdl460,0,0)
		While nLidos <= nTamArq
			xBuffer := Space(37)
			fRead(nHdl460,@xBuffer,37)
			cUser460 := Substr(xBuffer,1, 15)
			cImp460  := Substr(xBuffer,16,20)
			If Trim(Upper(cUser460)) == Trim(Upper(cUsername))
				cNome := Substr(cImp460,1,20)
				Exit
			Endif
			nLidos+=37
		EndDo
	Endif
Endif

// SmartClient x64 incompativel com leitura de .Dll x32
If __lIsRmt64
	If IsRmt64()
		U_FR460Banner()
		return(.F.)
	Endif	
EndIf

// Preparação do array das impressoras de cheque
// Alimenta uma string com o nome de todas as impressoras, separadas por virgulas.
cLista := Space(2000)
CHListar(@cLista)
// Alimenta o Vetor com o nome das impressoras recuperadas
cLista := AllTrim(cLista)
While Len(cLista)<>0
	If (nPos:=at(",",cLista))<>0
		aAdd(aImpChq, Subs(cLista, 2, nPos-3))
		cLista := Subs(cLista, nPos+1 )
	Else
		If Left(cLista,1)=='"'
			aAdd(aImpChq, Subs(cLista, 2, len(cLista)-2) )
		Else
			aAdd(aImpChq, cLista )
		EndIf
		cLista := ""
	EndIf
Enddo

//Adiciono impressoras exclusivas do Financeiro
AADD(aImpChq,"NCR                 ")
AADD(aImpChq,"CHRONOS             ")
AADD(aImpChq,"CHECKCERTO URANO    ")
AADD(aImpChq,"OLIVETTI PR 45      ")
AADD(aImpChq,"SCHALTER            ")
AADD(aImpChq,"QUATTRO             ")
AADD(aImpChq,"AUTOCHECK           ")

SX1->(DbSetOrder(1))
SX1->(MsSeek( Padr( "FIN460" , Len( X1_GRUPO ) , ' ' ) + "01")) // Posiciona na primeira pergunta (Qual Porta?)

cPorta := AllTrim(SX1->&("X1_DEF"+StrZero(mv_par01,2))) // Obtem o nome da porta

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega impressora padrao para cheques		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(cNome)
	cNome := Substr(GetMV("MV_IMPESPE"),1,20)
Endif

DEFINE MSDIALOG oDlg FROM 173,9 TO 340,453 TITLE OemToAnsi(titulo) PIXEL

@ 005, 007 TO 075, 175 LABEL OemToAnsi(STR0006) OF oDlg PIXEL	//"Impressoras disponiveis no sistema"
@ 017, 014 SAY  OemToAnsi(STR0007) OF oDlg PIXEL  //"Modelo"
@ 015, 040 COMBOBOX oCBXImp VAR cNome ITEMS aImpChq SIZE 100, 90 OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End()	ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava dados no SX6									  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !SX6->(eof())
	dbSelectArea("SX6")
	PutMv("MV_IMPESPE", cNome)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ vari veis utilizadas para parametros								  ³
//³ mv_par01					// Porta (COM1,COM2) 					  ³
//³ mv_par02					// Codigo do Banco						  ³
//³ mv_par03					// Agencia									  ³
//³ mv_par04					// Conta 									  ³
//³ mv_par05					// Numera cheque automaticamente (S/N)³
//³ mv_par06					// numero do 1. cheque					  ³
//³ mv_par07					// Do Cheque								  ³
//³ mv_par08					// At‚ o Cheque							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey == 27
	Return
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Array que sera utilizado na impress„o do cheques  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCheque[1] := SPACE(3)					// Codigo do Banco
aCheque[2] := "#"         			 	// Simbolo da Moeda ou identificador
aCheque[3] := SPACE(30) 				// Favorecido
aCheque[4] := SPACE(30) 				// Cidade
aCheque[5] := dDatabase 				// Data de Emiss„o do Cheque
aCheque[6] := 0							// Valor
aCheque[7] := SPACE(15) 				// N£mero do Cheque
aCheque[8] := SPACE(80) 				// Primeira linha do hist¢rico
aCheque[9] := GetMv("MV_MENS") 		// Segunda  linha do hist¢rico
aCheque[10]:= SPACE(80) 				// Terceira Linha do hist¢rico

DbSelectArea("SA6")
DbSetOrder(1)
DbSeek( cFilial+MV_PAR02+MV_PAR03+MV_PAR04 )

cNumCheq := MV_PAR06

IF MV_PAR05 == 1 	//Numera automaticamente
	DbSelectArea( "SEF" )
	If !Empty( MV_PAR06 ) // Numero do primeiro cheque
		If (DbSeek( cFilial+MV_PAR02+MV_PAR03+MV_PAR04+MV_PAR06))
			Help(" ",1,"A460CHEQUE")
			Set Device To Screen
			Set Filter To
			Return
		End
	Else	
		IW_MsgBox(STR0028,STR0029,"STOP") //"Para numeração automática, deve-se informar o número do primeiro cheque"##"Atenção"
		Set Device To Screen
		Set Filter To
		Return
	Endif	
	DbSeek( cFilial+MV_PAR02+MV_PAR03+MV_PAR04 )
	cCond1:="EF_BANCO=MV_PAR02.and.EF_AGENCIA=MV_PAR03.and.EF_CONTA=MV_PAR04"
Else
	DbSelectArea("SEF")
	DbSeek( cFilial+MV_PAR02+MV_PAR03+MV_PAR04+MV_PAR07,.T.)
	cCond1:="EF_BANCO=MV_PAR02.and.EF_AGENCIA=MV_PAR03.and.EF_CONTA=MV_PAR04.and.EF_NUM<=MV_PAR08"
End

lImprimiu := .F.
lAchouCh  := .F.

Do While !Eof() .and. EF_FILIAL = cFilial .and. &cCond1
	
	IF lEnd
		@PROW()+1,001 PSAY OemToAnsi(STR0008)  //"CANCELADO PELO OPERADOR"
		Exit
	End
	
	IF EF_IMPRESS $ "SAC" .or. SubStr(EF_TIPO,1,2) = "TB"
		dbSkip( )
		Loop
	End
	
	IF MV_PAR05 == 2 .and. Empty( EF_NUM )
		DbSkip( )
		Loop
	End
	
	DbSkip( )
	nSavRec := RecNo()
	DbSkip( -1 )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³	Caso cheque não tenha sido gerado,								³ 
	//³	ira gravar o movimento bancario e atualizar cheque emitido	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Empty( SEF->EF_NUM ) 
		dbSelectArea( "SE2" )
		If (dbSeek(cFilial+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO+SEF->EF_FORNECE))
			If !Empty( E2_PORTADO )
				dbSelectArea( "SA6" )
				dbSeek( cFilial + SE2->E2_PORTADO )
				cBenef := A6_NOME
			Else
				dbSelectArea( "SA2" )
				dbSeek( cFilial + SE2->E2_FORNECE + SE2->E2_LOJA )
				cBenef := A2_NOME
			Endif
			RecLock("SE2")
			Replace E2_NUMBCO With  cNumCheq
			MsUnlock()
			dbSelectArea("SE5")
			dbSetOrder(4)
			dbSeek(xFilial()+SE2->E2_NATUREZ+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO,.T.)
			While ( !Eof() .And. xFilial("SE5") == SE5->E5_FILIAL .And.;
				SE2->E2_NATUREZ == SE5->E5_NATUREZ .And.;
				SE2->E2_PREFIXO == SE5->E5_PREFIXO .And.;
				SE2->E2_NUM     == SE5->E5_NUMERO  .And.;
				SE2->E2_PARCELA == SE5->E5_PARCELA .And.;
				SE2->E2_TIPO    == SE5->E5_TIPO )
				If ( SE2->E2_FORNECE+SE2->E2_LOJA == SE5->E5_CLIFOR+SE5->E5_LOJA )
				cHistor := SE5->E5_HISTOR           
												
				//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
				If AllTrim( SE5->E5_TABORI ) == "FK5"
					aAreaFKs := GetArea()
					dbSelectArea( "FK5" )
					FK5->( DbSetOrder( 1 ) )
					If MsSeek( xFilial("FK5") + SE5->E5_IDORIG )
					
						//Verifica se possui ID se não ele cria
						dbSelectArea( "SEF" )
						dbSetOrder( 1 )
						If msSeek(xFilial("SEF")+mv_par02+mv_par03+mv_par04+SE2->E2_NUMBCO)
							If Empty(SEF->EF_IDSEF)
								cChaveCH 	:= FWUUIDV4()
								
								Reclock( "SEF", .F. )
								SEF->EF_IDSEF	:= cChaveCH
								SEF->( msUnlock() )
							Else
								cChaveCH := SEF->EF_IDSEF
							Endif
						Endif
						
						oModelMov := FWLoadModel("FINM030") //Recarrega o Model de movimentos para pegar o campo do relacionamento (SE5->E5_IDORIG)
						oModelMov:SetOperation( 4 ) //Alteração
						oModelMov:Activate()
						oModelMov:SetValue( "MASTER", "E5_GRV", .T. )	//Informa se vai gravar SE5 ou não		
		  				
		  				//Pega o número do processo e define no campo virtual do Model
						cProcFKs := FINProcFKs( SE5->E5_IDORIG, "FK5" )
						If !Empty(cProcFKs)
							oModelMov:SetValue( "MASTER", "NOVOPROC", .F. ) //Informa que a inclusão será feita com um novo número de processo
						Else
							oModelMov:SetValue( "MASTER", "NOVOPROC", .T. ) //Informa que a inclusão será feita com um novo número de processo
						EndIf
				
						//Dados do cheque	
						oSubFKA := oModelMov:GetModel( "FKADETAIL" )	
						oSubFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
						oSubFKA:SetValue( 'FKA_TABORI', 'FK5' )
						
						If !Empty(cProcFKs)
							oSubFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
		  				Endif	

						//Informacoes do movimento
						oSubFK5 := oModelMov:GetModel("FK5DETAIL")
						oSubFK5:SetValue( "FK5_BANCO",	mv_par02 )
						oSubFK5:SetValue( "FK5_AGENCI", mv_par03 )
						oSubFK5:SetValue( "FK5_CONTA",	mv_par04 )
						oSubFK5:SetValue( "FK5_NUMCH",	SE2->E2_NUMBCO )	
						
						//Dados do Processo - Cheque
						If !oSubFKA:IsEmpty()
							oSubFKA:AddLine()
						Endif
						oSubFKA:SetValue( 'FKA_IDORIG', cChaveCH )			
						oSubFKA:SetValue( 'FKA_TABORI', 'FK5' )				
		
						If oModelMov:VldData()
		    				oModelMov:CommitData()
							oModelMov:DeActivate()
						Else
		    				lRet := .F.
		    				cLog := cValToChar (oModelMov:GetErrorMessage()[4]) + ' - '
		    				cLog += cValToChar (oModelMov:GetErrorMessage()[5]) + ' - '
		    				cLog += cValToChar (oModelMov:GetErrorMessage()[6])        	
			    
		    				Help( ,,"M030_FINR460",,cLog, 1, 0 )	  		    		
						Endif
					Else //Se não achou o registro na FK5
						lRet := .F.															
					Endif
					RestArea(aAreaFKs)
				Else //Se a origem do registro posicionado não for FK5
					lRet := .F.
				Endif
				
				Endif
				dbSelectArea("SE5")
				dbSkip()
			EndDo
	EndIf	
	Reclock( "SEF" )
	Replace EF_NUM		With cNumCheq,;
		  	EF_BANCO	With MV_PAR02,;
		  	EF_AGENCIA	With MV_PAR03,;
		  	EF_CONTA  	With MV_PAR04,;
		  	EF_BENEF  	With Iif( !Empty(cBenef),cBenef,SEF->EF_BENEF)		  
			If Empty(SEF->EF_IDSEF)
				cChaveCH 	:= FWUUIDV4()				
				SEF->EF_IDSEF	:= cChaveCH
			Else
				cChaveCH := SEF->EF_IDSEF 
			Endif
		  lGravaFKA := (SEF->EF_TIPO $ MVPAGANT)
	MsUnlock() 
	// Cria a movimentacao bancaria para o cheque impresso
	If lMovBco		
		FR460GrSE5(cHistor, cChaveCH, lGravaFKA)	
	EndIf	
	cNumCheq:=Soma1( Trim ( cNumCheq ) , Len( Trim( cNumCheq ) ) )
EndIf
					
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso cheque tenha sido gerado, ir  regravar novo numero ³
	//³ nos elementos do cheque.                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCheqAnt := SEF->EF_NUM
	If SubStr(cCheqAnt,1,1) == "*"
		nRegOri := SEF->(Recno())
		dbSelectArea( "SEF" )
		dbSetOrder(1)
		SEF->( dbSeek( cFilial + mv_par02 + mv_par03 + mv_par04 + cCheqAnt ))
		While SEF->( !Eof() ).and. mv_par02+mv_par03+mv_par04+cCheqAnt == EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM .And.;
				SEF->EF_FILIAL == xFilial("SEF")
			nRecAnt  := Recno()
			dbSkip()
			nRegProx := RecNo()
			dbGoto(nRecAnt)
			If SE2->(MsSeek (cFilial+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO+SEF->EF_FORNECE))
				If !Empty( SE2->E2_PORTADO )
					SA6->(MsSeek( cFilial + SE2->E2_PORTADO ))
					cBenef := SA6->A6_NOME
				Else
					SA2->(MsSeek( cFilial + SE2->E2_FORNECE + SE2->E2_LOJA ))
					cBenef := SA2->A2_NOME
				Endif
			Endif
			Reclock( "SEF" )
			SEF->EF_NUM   := cNumCheq
			SEF->EF_BENEF := cBenef
			MsUnlock()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava o numero do cheque no SE2 - para contabilizacao   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !SEF->EF_TIPO $ MVRECANT +"/"+MV_CRNEG
				dbSelectArea( "SE2" )
				If SE2->(dbSeek(xFilial()+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO+SEF->EF_FORNECE+SEF->EF_LOJA))
					RecLock("SE2")
					SE2->E2_NUMBCO := cNumCheq
					MsUnlock()
					dbSelectArea("SE5")
					dbSetOrder(4)
					dbSeek(xFilial()+SE2->E2_NATUREZ+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO,.T.)
					While ( !Eof() .And. xFilial("SE5") == SE5->E5_FILIAL .And.;
							SE2->E2_NATUREZ == SE5->E5_NATUREZ .And.;
							SE2->E2_PREFIXO == SE5->E5_PREFIXO .And.;
							SE2->E2_NUM     == SE5->E5_NUMERO  .And.;
							SE2->E2_PARCELA == SE5->E5_PARCELA .And.;
							SE2->E2_TIPO    == SE5->E5_TIPO )
						If ( SE2->E2_FORNECE+SE2->E2_LOJA == SE5->E5_CLIFOR+SE5->E5_LOJA ) .and.;
							SE5->E5_SEQ == SEF->EF_SEQUENC
							cHistor := SE5->E5_HISTOR	
						
						//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
						If AllTrim( SE5->E5_TABORI ) == "FK5"
							aAreaFKs := GetArea()
							dbSelectArea( "FK5" )
							FK5->( DbSetOrder( 1 ) )
							If MsSeek( xFilial("FK5") + SE5->E5_IDORIG )
							
								//Verifica se possui ID se não ele cria
								dbSelectArea( "SEF" )
								dbSetOrder( 1 )
								If msSeek(xFilial("SEF")+mv_par02+mv_par03+mv_par04+SE2->E2_NUMBCO)
									If Empty(SEF->EF_IDSEF)
										cChaveCH 	:= FWUUIDV4()
										
										Reclock( "SEF", .F. )
										SEF->EF_IDSEF	:= cChaveCH
										SEF->( msUnlock() )
									Else
										cChaveCH := SEF->EF_IDSEF
									Endif
								Endif
						
								oModelMov := FWLoadModel("FINM030") //Recarrega o Model de movimentos para pegar o campo do relacionamento (SE5->E5_IDORIG)
								oModelMov:SetOperation( 4 ) //Alteração
								oModelMov:Activate()
								oModelMov:SetValue( "MASTER", "E5_GRV", .T. )	//Informa se vai gravar SE5 ou não		
				  				
				  				//Pega o número do processo e define no campo virtual do Model
								cProcFKs := FINProcFKs( SE5->E5_IDORIG, "FK5" )
								If !Empty(cProcFKs)
									oModelMov:SetValue( "MASTER", "NOVOPROC", .F. ) //Informa que a inclusão será feita com um novo número de processo
								Else
									oModelMov:SetValue( "MASTER", "NOVOPROC", .T. ) //Informa que a inclusão será feita com um novo número de processo
								EndIf
								
								//Dados do cheque	
								oSubFKA := oModelMov:GetModel( "FKADETAIL" )	
								oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
								oFKA:SetValue( 'FKA_TABORI', 'FK5' )		  		
								
								If !Empty(cProcFKs)
									oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
		  						Endif			
				  				
								//Informacoes do movimento
								oSubFK5 := oModelMov:GetModel("FK5DETAIL")
								oSubFK5:SetValue( "FK5_BANCO",	mv_par02 )
								oSubFK5:SetValue( "FK5_AGENCI", mv_par03 )
								oSubFK5:SetValue( "FK5_CONTA",	mv_par04 )
								oSubFK5:SetValue( "FK5_NUMCH",	SE2->E2_NUMBCO )					
				
								//Dados do Processo - Cheque
								If !oSubFKA:IsEmpty()
									oSubFKA:AddLine()
								Endif
								oSubFKA:SetValue( 'FKA_IDORIG', cChaveCH )			
								oSubFKA:SetValue( 'FKA_TABORI', 'FK5' )			
						
								If oModelMov:VldData()
				    				oModelMov:CommitData()
									oModelMov:DeActivate()
								Else
				    				lRet := .F.
				    				cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
				    				cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
				    				cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
					    
				    				Help( ,,"M030_FINR460",,cLog, 1, 0 )	  		    		
								Endif
							Else //Se não achou o registro na FK5
								lRet := .F.															
							Endif
							RestArea(aAreaFKs)
						Else //Se a origem do registro posicionado não for FK5
							lRet := .F.
						Endif
						
						EndIf
						dbSelectArea("SE5")
						dbSkip()
					EndDo
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Trata caso o registro seja originario de uma movimento	³
					//³ bancaria manual e atualiza o saldo bancario do cheque	³
					//³ renumerado.                                        		³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("SE5")
					dbSetOrder(1)
					If dbSeek(xFilial()+DtoS(SEF->EF_DATA)+SEF->EF_BANCO+SEF->EF_AGENCIA+SEF->EF_CONTA+cCheqAnt)
						lMovBco := .F.					
						While ! Eof() .And.SE5->E5_FILIAL== xFilial() .And.;
								DTOS(SE5->E5_DATA)== DtoS(SEF->EF_DATA) .And.;
								SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA) == SEF->(EF_BANCO+EF_AGENCIA+EF_CONTA)								
							If SE5->E5_SITUACA == "C" .Or. SE5->E5_TIPODOC == "TE" ;
									.Or. (SE5->E5_TIPODOC == "TR" .And. SE5->E5_MOEDA == "ES")
								dbSkip()
								Loop
							EndIf
							If SE5->E5_TIPODOC == "TR"
								If Substr(SE5->E5_NUMCHEQ,1,15) == Substr(cCheqAnt,1,15) .or. ;
									Substr(SE5->E5_DOCUMEN,1,15) == Substr(cCheqAnt,1,15)
									
								//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
								If AllTrim( SE5->E5_TABORI ) == "FK5"
									aAreaFKs := GetArea()
									dbSelectArea( "FK5" )
									FK5->( DbSetOrder( 1 ) )
									If MsSeek( xFilial("FK5") + SE5->E5_IDORIG )
									
										//Verifica se possui ID se não ele cria
										dbSelectArea( "SEF" )
										dbSetOrder( 1 )
										
										If msSeek(xFilial("SEF")+ cNumCheq + cNumCheq)
											If Empty(SEF->EF_IDSEF)
												cChaveCH 	:= FWUUIDV4()
												
												Reclock( "SEF", .F. )
												SEF->EF_IDSEF	:= cChaveCH
												SEF->( msUnlock() )
											Else
												cChaveCH := SEF->EF_IDSEF
											Endif
										Endif
						
										oModelMov := FWLoadModel("FINM030") //Recarrega o Model de movimentos para pegar o campo do relacionamento (SE5->E5_IDORIG)
										oModelMov:SetOperation( 4 ) //Alteração
										oModelMov:Activate()
										oModelMov:SetValue( "MASTER", "E5_GRV", .T. )	//Informa se vai gravar SE5 ou não		
						  				
						  				//Pega o número do processo e define no campo virtual do Model
										cProcFKs := FINProcFKs( SE5->E5_IDORIG, "FK5" )
										If !Empty(cProcFKs)
											oModelMov:SetValue( "MASTER", "NOVOPROC", .F. ) //Informa que a inclusão será feita com um novo número de processo
										Else
											oModelMov:SetValue( "MASTER", "NOVOPROC", .T. ) //Informa que a inclusão será feita com um novo número de processo
										EndIf
										
										//Dados do cheque	
										oSubFKA := oModelMov:GetModel( "FKADETAIL" )	
										oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
										oFKA:SetValue( 'FKA_TABORI', 'FK5' )		  		
										
										If !Empty(cProcFKs)
											oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
				  						Endif				
						  				
										//Informacoes do movimento
										oSubFK5 := oModelMov:GetModel("FK5DETAIL")
										oSubFK5:SetValue( "FK5_NUMCHEQ", cNumCheq )
										oSubFK5:SetValue( "FK5_DOC", cNumCheq )
										
										//Dados do Processo - Cheque
										If !oSubFKA:IsEmpty()
											oSubFKA:AddLine()
										Endif
										oSubFKA:SetValue( 'FKA_IDORIG', cChaveCH )			
										oSubFKA:SetValue( 'FKA_TABORI', 'FK5' )			
														
										If	SE5->E5_RECPAG == "P"
											oSubFK5:SetValue( "FK5_NUMCH",	cNumCheq )
										Else					
											oSubFK5:SetValue( "FK5_DOC", cNumCheq )
										Endif
										
										If oModelMov:VldData()
						    				oModelMov:CommitData()
											oModelMov:DeActivate()
										Else
						    				lRet := .F.
						    				cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
						    				cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
						    				cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
							    
						    				Help( ,,"M030_FINR460",,cLog, 1, 0 )	  		    		
										Endif
									Else //Se não achou o registro na FK5
										lRet := .F.															
									Endif
									RestArea(aAreaFKs)
								Else //Se a origem do registro posicionado não for FK5
									lRet := .F.
								Endif
									
									If SE5->E5_RECPAG == "P"
										AtuSalBco( SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DTDISPO,SE5->E5_VALOR,"-")
									Else
										AtuSalBco( SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DTDISPO,SE5->E5_VALOR,"+")
									EndIf			
								Endif
							Else
					
								If Substr(SE5->E5_NUMCHEQ,1,15) == Substr(cCheqAnt,1,15)
									
								//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
								If AllTrim( SE5->E5_TABORI ) == "FK5"
									aAreaFKs := GetArea()
									dbSelectArea( "FK5" )
									FK5->( DbSetOrder( 1 ) )
									If MsSeek( xFilial("FK5") + SE5->E5_IDORIG )
									
										//Verifica se possui ID se não ele cria
										dbSelectArea( "SEF" )
										dbSetOrder( 1 )
										If msSeek(xFilial("SEF")+ cNumCheq)
											If Empty(SEF->EF_IDSEF)
												cChaveCH 	:= FWUUIDV4()
												
												Reclock( "SEF", .F. )
												SEF->EF_IDSEF	:= cChaveCH
												SEF->( msUnlock() )
											Else
												cChaveCH := SEF->EF_IDSEF
											Endif
										Endif
						
										oModelMov := FWLoadModel("FINM030") //Recarrega o Model de movimentos para pegar o campo do relacionamento (SE5->E5_IDORIG)
										oModelMov:SetOperation( 4 ) //Alteração
										oModelMov:Activate()
										oModelMov:SetValue( "MASTER", "E5_GRV", .T. )	//Informa se vai gravar SE5 ou não		
						  				
						  				//Pega o número do processo e define no campo virtual do Model
										cProcFKs := FINProcFKs( SE5->E5_IDORIG, "FK5" )
										If !Empty(cProcFKs)
											oModelMov:SetValue( "MASTER", "NOVOPROC", .F. ) //Informa que a inclusão será feita com um novo número de processo
										Else
											oModelMov:SetValue( "MASTER", "NOVOPROC", .T. ) //Informa que a inclusão será feita com um novo número de processo
										EndIf
										
										//Dados do cheque	
										oSubFKA := oModelMov:GetModel( "FKADETAIL" )	
										oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
										oFKA:SetValue( 'FKA_TABORI', 'FK5' )		  		
										
										If !Empty(cProcFKs)
											oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
				  						Endif	
						  				
										//Informacoes do movimento
										oSubFK5 := oModelMov:GetModel("FK5DETAIL")
										oSubFK5:SetValue( "FK5_NUMCHEQ", cNumCheq )
										
										//Dados do Processo - Cheque
										If !oSubFKA:IsEmpty()
											oSubFKA:AddLine()
										Endif
										oSubFKA:SetValue( 'FKA_IDORIG', cChaveCH )			
										oSubFKA:SetValue( 'FKA_TABORI', 'FK5' )			
										
										If oModelMov:VldData()
						    				oModelMov:CommitData()
											oModelMov:DeActivate()
										Else
						    				lRet := .F.
						    				cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
						    				cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
						    				cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
							    
						    				Help( ,,"M030_FINR460",,cLog, 1, 0 )	  		    		
										Endif
									Else //Se não achou o registro na FK5
										lRet := .F.															
									Endif
									RestArea(aAreaFKs)
								Else //Se a origem do registro posicionado não for FK5
									lRet := .F.
								Endif
									
									If SE5->E5_RECPAG == "P"
										AtuSalBco( SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DTDISPO,SE5->E5_VALOR,"-")
									Else
										AtuSalBco( SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DTDISPO,SE5->E5_VALOR,"+")
									EndIf
								Endif
							EndIf
							dbSelectArea("SE5")
							dbSkip()
						EnddO
					Endif
				Endif
			Endif
			dbSelectArea( "SEF" )
			dbSetOrder(1)
			SEF->( dbGoTo( nRegProx ) )
		EndDo
		SEF->(dbGoTo( nRegOri ))
		// Cria a movimentacao bancaria para o cheque impresso
		If lMovBco
			FR460GrSE5(cHistor) 
		EndIf	
	Endif
	lAchouCh := .T.	    

	DbSelectArea("SA6") ; DbSetOrder(1)
	DbSeek( cFilial+MV_PAR02+MV_PAR03+MV_PAR04 )
	
	aCheque[1] := MV_PAR02
	aCheque[2] := "#"
	aCheque[3] := SEF->EF_BENEF			//Favorecido
	If ExistBlock("F460MUN")
		cTmpMun := ExecBlock("F460MUN")
		If !Empty(cTmpMun)
				If ValType(cTmpMun) == "C"
					aCheque[4] := Left(cTmpMun,30)
				EndIf
		EndIf
	Else
		aCheque[4] := SA6->A6_MUN				//Cidade	
	EndIf	
	
	If Empty(aCheque[4])
		IW_MsgBox(STR0030,STR0029,"STOP") //"O cheque não será impresso, pois a cidade no cadastro de bancos está em branco!"##"Atenção"
		Exit
	EndIf		
	
	//O ponto de entrada permite a manipulação do beneficiário a ser impresso no cheque.
	If lF460BENEF
		aCheque[3] := ExecBlock("F460BENEF", .F., .F.)	
	EndIf
	
	aCheque[5] := SEF->EF_DATA 			//Data de Emissao do Cheque
	aCheque[6] := SEF->EF_VALOR			//Valor do cheque
	aCheque[7] := SEF->EF_NUM				//n£mero do Cheque
	aCheque[8] := SEF->EF_HIST 			//hist¢rico

	If lF460MSG
		aCheque[9] := ExecBlock("F460MSG",.f.,.f.,{cNome})
	Endif

	lLojaDll := .F.
	If Alltrim(cNome) == "NCR"
		nRet := U_AutoCheck2( aCheque, @lEnd, nHdll )
	ElseIf Alltrim(cNome) == "CHRONOS"
		nRet := U_AutoCheck3( aCheque, @lEnd, nHdll )
	ElseIf Alltrim(cNome) == "CHECKCERTO URANO"
		nRet := U_AutoCheck5( aCheque, @lEnd, nHdll )
	ElseIf Alltrim(cNome) == "OLIVETTI PR 45"
		nRet := U_AutoCheck6( aCheque, @lEnd, nHdll )
	ElseIf Alltrim(cNome) == "SCHALTER"
		nRet := U_AutoCheck8( aCheque, @lEnd, nHdll )
	ElseIf Alltrim(cNome) == "QUATTRO"
		nRet := U_AutoCheck9( aCheque, @lEnd, nHdll )
	ElseIf Alltrim(cNome) == "AUTOCHECK"
		nRet := U_AutoCheckD( aCheque, @lEnd, nHdll )
	Else	
		If lClosePort
			nHdll := -1
			lClosePort := .F.
		Endif
		cRet := U_AutoCheckP( aCheque, @lEnd, @nHdll, Alltrim(cNome), cPorta )
		lLojaDll := .T.
	Endif

	If lLojaDll
		IF cRet == "9" // Cancelou
			// Se nao abriu a porta nenhuma vez marco como não inicializado.
			If nHdll < 0
				CHFECHAR(nHdll,cPorta)
				lClosePort := .T.
			Endif
			Exit
		ElseIf cRet == "1" 	// nao imprimiu
			Help(" ",1,"NOIMPCHEQ")
			Exit
		ElseIf cRet == "0"    // imprimiu
			dbSelectArea("SEF")
			RecLock("SEF",.F.)
			Replace SEF->EF_IMPRESS WITH "S"
			MsUnlock()

		   //Ponto de entrada para complemento de gravacao	
		   If lF460BXT	
			    ExecBlock("F460BXT",.F.,.F.)	
		   Endif	
		
		Endif
	Else
		
		If MsgYesNo(OemtoAnsi(STR0027),;	// O Cheque foi impresso corretamente
				OemToAnsi(STR0002))			// Cheque
			nRet := 0
		Else
			nRet := 9	// N„o imprimiu
		Endif
		
		If lF460OK
			lRet := ExecBlock("F460OK",.f.,.f.)
			If lRet
				nRet := 0 	// imprimiu
			Else
				nRet := -5	// cancelou
			Endif
		Endif
		IF	nRet == -1
			Help(" ",1,"NOPRINTDAT")
		ElseIf	nRet == -2
			Help(" ",1,"NOLINHA")
			Exit
		ElseIf	nRet == -4
			Help(" ",1,"NOLAYOUT")
			Exit
		ElseIf nRet == -5	//ver
			Exit
		ElseIf nRet == 0
			dbSelectArea("SEF")
			RecLock("SEF",.F.)
			Replace SEF->EF_IMPRESS WITH "S"
			MsUnlock()

		   //Ponto de entrada para complemento de gravacao	
		   If lF460BXT	
		    ExecBlock("F460BXT",.F.,.F.)	
		   Endif	

		Endif
	Endif
	lImprimiu := .T.
	dbSelectArea( "SEF" )
	dbGoTo( nSavRec )
EndDo

dbSelectArea("SEF")
dbSetOrder(1)
Set Filter To
DbSelectArea("SA6")
dbSetOrder(1)
Set Filter To

//Fecho a porta - Sigaloja.dll
If lLojaDll .and. !lClosePort
	CHFECHAR(nHdll,cPorta)
Endif

If lAchouCh .AND. !lImprimiu .AND. cRet=="9" .AND. !Empty(aCheque[4])
	IW_MsgBox(STR0032,STR0029,"STOP") //"O operador informou que o cheque não foi impresso. Esse cheque continuará na base de para impressão futura."
Endif

If !lAchouCh
	IW_MsgBox(STR0031,STR0029,"STOP") //"Conforme os parâmetros informados, nenhum cheque foi encontrado para ser impresso"
Endif

Return(.T.)

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³AutoCheck2³ Autor ³ Erick Nori Barbosa	  ³ Data ³ 09/07/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime um cheque na impressora padr„o AUTOCHECK NCR. 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_AutoCheck2(ExpN1,ExpC1) 											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 - Valor do cheque a ser impresso.						  ³±±
±±³			 ³ ExpC1 - Codigo do Banco.											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AutoCheck2(aCheque,lEnd,nHdll)

LOCAL cBanco
LOCAL dEmissao
LOCAL nRet
LOCAL oDlg
Local lCheque := (ExistBlock("FINR460"))

cBanco	 := aCheque[1]
cFavorec := aCheque[3]
cCidade	:= aCheque[4]
dEmissao := aCheque[5]
cValor	 := Alltrim(Str(aCheque[6],15,2))
cValor	 := SubStr(cValor,1,Len(cValor)-3) + SubStr(cValor,Len(cValor)-1,2)
nCheque	:= aCheque[7]

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Formata a Serial e Envia caracteres 							³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nRet		:= 0

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Mostra a condi‡„o de impress„o do cheque e aceita o n£mero³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(titulo) PIXEL

@ 005, 007 TO 045, 175 LABEL OemToAnsi(STR0009) OF oDlg PIXEL	//"Dados Bancarios"
@ 050, 007 TO 080, 175 OF oDlg PIXEL

@ 029, 014 SAY  OemToAnsi(STR0010) OF oDlg PIXEL  //"Insira o Cheque"
@ 058, 014 SAY  OemToAnsi(cDesc1) SIZE 160, 11 OF oDlg PIXEL
@ 068, 014 SAY  OemToAnsi(cDesc2) SIZE 160, 11 OF oDlg PIXEL

DbSelectArea("SA6")
@ 016, 014 SAY  SA6->A6_COD + "  " + SubStr( SA6->A6_NOME, 1,20 ) SIZE 120, 11 OF oDlg PIXEL
@ 027, 055 MSGET nCheque	Picture "@X"         SIZE 60, 11 OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (oDlg:End(),lEnd:=.T.) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg

IF lEnd	.OR.	nLastKey == 27
	Return -5
Endif

MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")

MsWrite(nHdll,"b" + cBanco+chr(13)+chr(10))
MsWrite(nHdll,"c" + cCidade + "$" +chr(13)+chr(10))
MsWrite(nHdll,"d" + DtoC(dEmissao)+chr(13)+chr(10))
MsWrite(nHdll,"f" + cFavorec + "$" +chr(13)+chr(10))
MsWrite(nHdll,"P" +chr(13)+chr(10))
MsWrite(nHdll,"v" + cValor + "$"+chr(13)+chr(10))

If lCheque
	Execblock("FINR460",.f.,.f.,nHdll)
End

MsClosePort(nHdll)

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Imprime o hist¢rico do cheque se houver						³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF cImprVerso	$ "Ss" .and. ( !Empty(aCheque[8]) .or. !Empty(aCheque[9]) )
	
	DEFINE MSDIALOG oDlg FROM 173,9 TO 334,453 TITLE OemToAnsi(titulo) PIXEL
	
	@ 075, 007 TO 130, 175 OF oDlg PIXEL
	
	@ 071, 014 SAY  OemToAnsi(STR0011) OF oDlg PIXEL  //"Vire o cheque na impressora e clique no botao OK"
	@ 085, 014 SAY  OemToAnsi(STR0012) OF oDlg PIXEL  //"para imprimir o hist¢rico no verso.                      "
	
	DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
	
	ACTIVATE MSDIALOG oDlg
	
	If  nLastKey # 27
		
		MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")
		
		MsWrite(nHdll, space(10)+aCheque[8])
		MsWrite(nHdll, space(10)+aCheque[9])
		MsWrite(nHdll, space(10) + aCheque[10])
		
		MsClosePort(nHdll)
		
	Endif
	
Endif

Return nRet

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³AutoCheck3³ Autor ³ Antonio Maniero Jr.   ³ Data ³ 13/10/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime um cheque na impressora padr„o AUTOCHECK CHRONOS   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_AutoCheck2(ExpN1,ExpC1) 											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 - Valor do cheque a ser impresso.						  ³±±
±±³			 ³ ExpC1 - Codigo do Banco.											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AutoCheck3(aCheque,lEnd,nHdll)

LOCAL nPorta
LOCAL cBanco
LOCAL dEmissao
LOCAL nRet
LOCAL oDlg
Local nTam := 0
Local lCheque := (ExistBlock("FINR460"))
Local nOpca := 0

cBanco	 := aCheque[1]
cFavorec := aCheque[3]
cCidade	:= aCheque[4]
dEmissao := aCheque[5]
cValor	 := str(aCheque[6],12,2)
nCheque	:= aCheque[7]

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Acessa a parametriza‡„o do banco  ³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SA6")
dbSeek(cFilial+cBanco)

DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(titulo) PIXEL
@ 005, 007 TO 045, 175 LABEL OemToAnsi(STR0009) OF oDlg PIXEL	//"Dados Bancarios"
@ 050, 007 TO 080, 175 OF oDlg PIXEL

@ 029, 014 SAY  OemToAnsi(STR0010) OF oDlg PIXEL  //"Insira o Cheque"
@ 058, 014 SAY  OemToAnsi(cDesc1) SIZE 160, 11 OF oDlg PIXEL
@ 068, 014 SAY  OemToAnsi(cDesc2) SIZE 160, 11 OF oDlg PIXEL

DbSelectArea("SA6")
@ 016, 014 SAY  SA6->A6_COD + "  " + SubStr( SA6->A6_NOME, 1,20 ) SIZE 120, 11 OF oDlg PIXEL
@ 027, 055 MSGET nCheque	Picture "@X"         SIZE 60, 11 OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (oDlg:End(),lEnd:=.T.) ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg

IF lEnd	.OR.	nLastKey == 27
	Return -5
Endif

If ( MV_PAR01 <= 2 )
	MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")
Else
	nPorta := If( MV_PAR01 == 3 , "LPT1" , "LPT2" )
	Set Printer to &nPorta
	Set Printer on
	set device to printer
	InitPrint()
EndIf	

If ( MV_PAR01 <= 2 )
	MsWrite(nHdll,Chr(27)+Chr(162) + cBanco          +chr(13);
				 +Chr(27)+Chr(164) + left(dTOC(dEmissao),6)+Right(dTOC(dEmissao),2)  +chr(13);
				 +Chr(27)+Chr(160) + cFavorec        +chr(13);
			 	 +Chr(27)+Chr(161) + cCidade         +chr(13);
				 +Chr(27)+Chr(163) + cValor          +chr(13);
				 +Chr(27)+Chr(176))

	MsWrite(nHdll, chr(12))
Else	
	@ 0,0 PSAY chr(27) + Chr(162) + cBanco + Chr(13) + ;
				 chr(27) + Chr(164) + left(dTOC(dEmissao),6)+Right(dTOC(dEmissao),2) + Chr(13) + ;
				 chr(27) + Chr(160) + cFavorec + Chr(13) + ;
				 chr(27) + Chr(161) + cCidade + Chr(13) + ;
				 chr(27) + Chr(163) + cValor	+ Chr(13) + ;
				 chr(27) + Chr(176)
	Eject
	set device to screen
	set printer off
EndIf
If lCheque
	Execblock("FINR460",.f.,.f.,nHdll)
End

If ( MV_PAR01 <= 2 )
	MsClosePort(nHdll)	
Endif

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Imprime o hist¢rico do cheque se houver  ³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF cImprVerso	$ "Ss" .and. ( !Empty(aCheque[8]) .or. !Empty(aCheque[9]) )

	nOpca := 0
	DEFINE MSDIALOG oDlg FROM 173,9 TO 334,453 TITLE OemToAnsi(titulo) PIXEL
	
	@ 050, 014 SAY  OemToAnsi(STR0011)	OF oDlg PIXEL	//"Vire o cheque na impressora e clique no botao OK"
	@ 060, 014 SAY  OemToAnsi(STR0026)	OF oDlg PIXEL	//"para imprimir o hist¢rico no verso."
	@ 040, 007 TO 075, 185 OF oDlg PIXEL

	DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION (nOpca:=1,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (nOpca:=2,oDlg:End()) ENABLE OF oDlg
	
	ACTIVATE MSDIALOG oDlg
	
	If nOpca == 1  // Se confirma impressao do verso
		If ( MV_PAR01 <= 2 )
			MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")
			nTam := (77 - Len(aCheque[9]))  // MV_MENS
			MsWrite(nHdll, Space(5) + aCheque[9] + Space(nTam))
			MsWrite(nHdll, Space(82))
			nTam := (77 - Len(aCheque[8]))  // EF_HIST
			MsWrite(nHdll, Space(5) + aCheque[8] + Space(nTam))
			MsWrite(nHdll, Space(82))
			MsWrite(nHdll, space(10) + aCheque[10])
			MsWrite(nHdll, chr(12))
			MsClosePort(nHdll)
		Else
			set Printer on
			set Device to Printer
			@ 0,0 Say Space(5) + aCheque[9]
			@ 3,0 Say Space(5) + aCheque[8]
			@ 5,0 Say Space(5) + aCheque[10]
			Eject

			Set Device to Screen
			Set Printer off
			Set Console On				
		EndIf		
	Endif
EndIf  

nRet := 0

Return nRet

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³AutoCheck5³ Autor ³ Raul Carlos Capeleti  ³ Data ³ 19/06/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime um cheque na impressora padr„o checkcerto URANO	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_AutoCheck5(ExpN1,ExpC1) 											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 - Valor do cheque a ser impresso.						  ³±±
±±³			 ³ ExpC1 - Codigo do Banco.											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AutoCheck5(aCheque,lEnd,nHdll)
LOCAL cBanco
LOCAL dEmissao
LOCAL A1
LOCAL A2
LOCAL A3
LOCAL A11
LOCAL A21
LOCAL A31
LOCAL nRet
LOCAL oDlg
Local lCheque := (ExistBlock("FINR460"))

cBanco	 := aCheque[1]
cFavorec := aCheque[3]
cCidade	:= aCheque[4]
dEmissao := aCheque[5]
cValor	 := strzero(aCheque[6],15,2)
nCheque	:= aCheque[7]

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Mostra a condi‡„o de impress„o do cheque e aceita o n£mero³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(titulo) PIXEL

@ 005, 007 TO 045, 175 LABEL OemToAnsi(STR0009) OF oDlg PIXEL	//"Dados Bancarios"
@ 050, 007 TO 080, 175 OF oDlg PIXEL

@ 029, 014 SAY  OemToAnsi(STR0010)	 OF oDlg PIXEL  //"Insira o Cheque"
@ 058, 014 SAY  OemToAnsi(cDesc1) SIZE 160, 11 OF oDlg PIXEL
@ 068, 014 SAY  OemToAnsi(cDesc2) SIZE 160, 11 OF oDlg PIXEL

DbSelectArea("SA6")
@ 016, 014 SAY  SA6->A6_COD + "  " + SubStr( SA6->A6_NOME, 1,20 )  SIZE 120, 11 OF oDlg PIXEL
@ 027, 055 MSGET nCheque	Picture "@X"              SIZE 60, 11  OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End()			 ENABLE OF oDlg
DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (oDlg:End(),lEnd:=.T.) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg

IF lEnd	.OR.	nLastKey == 27
	Return -5
Endif

MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")

MsWrite(nHdll,CHR(170)+CHR(1)+cCidade+CHR(128))
MsWrite(nHdll,CHR(170)+CHR(3)+cFavorec+CHR(128))

// CONVERSAO DA DATA
c01:= Substr(Dtoc(dEmissao),1,2)+Substr(Dtoc(dEmissao),4,2)+substr(Dtoc(dEmissao),7,2)
n02:= Val(c01)
A1:=INT(n02/10000)
A2:=INT(n02/100)-A1*100
A3:=n02-A1*10000-A2*100
A11:=(INT(A1/10)*16)+(A1-(INT(A1/10)*10))
A21:=(INT(A2/10)*16)+(A2-(INT(A2/10)*10))
A31:=(INT(A3/10)*16)+(A3-(INT(A3/10)*10))

//CONVERSAO DO VALOR
b1:=Val(Substr(cValor,1,2))
b2:=Val(Substr(cValor,3,2))
b3:=Val(Substr(cValor,5,2))
b4:=Val(Substr(cValor,7,2))
b5:=Val(Substr(cValor,9,2))
b6:=Val(Substr(cValor,11,2))
b7:=Val(Substr(cValor,14,2))

B11:=(INT(B1/10)*16)+(B1-(INT(B1/10)*10))
B21:=(INT(B2/10)*16)+(B2-(INT(B2/10)*10))
B31:=(INT(B3/10)*16)+(B3-(INT(B3/10)*10))
B41:=(INT(B4/10)*16)+(B4-(INT(B4/10)*10))
B51:=(INT(B5/10)*16)+(B5-(INT(B5/10)*10))
B61:=(INT(B6/10)*16)+(B6-(INT(B6/10)*10))
B71:=(INT(B7/10)*16)+(B7-(INT(B7/10)*10))
MsWrite(nHdll,CHR(170)+CHR(2)+CHR(A11)+CHR(A21)+CHR(A31))
MsWrite(nHdll,CHR(170)+CHR(5)+CHR(B11)+CHR(B21)+CHR(B31)+CHR(B41)+CHR(B51)+CHR(B61)+CHR(B71))

// CONVERSAO DO CODIGO DO BANCO
A = INT(val(cBanco)/256)
B = (Val(cBanco)/256-A)*256
MsWrite(nHdll,CHR(170)+CHR(4)+CHR(A)+CHR(B)+CHR(128))

If lCheque
	Execblock("FINR460",.f.,.f.,nHdll)
Endif

MsClosePort(nHdll)

nRet := 0
Return nRet

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³AutoCheck6³ Autor ³ Antonio Maniero Jr.   ³ Data ³ 09/07/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime um cheque na impressora padr„o olivetti pr45		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_AutoCheck6(ExpN1,ExpC1) 											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1 - Matriz com os dados do cheque. 						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AutoCheck6(aCheque,lEnd,nHdll)
LOCAL nValor
LOCAL cBanco
LOCAL dEmissao
LOCAL nLinVlr
LOCAL nLin1Ext
LOCAL nCol1Ext
LOCAL nLin2Ext
LOCAL nCol2Ext
LOCAL nLinFav
LOCAL nColFav
LOCAL nLinDat
LOCAL nColVir
LOCAL nTamLin
LOCAL cExt
LOCAL nPosAnt
LOCAL aLinhas :={}
LOCAL nTamAnt :=0
LOCAL nDif
LOCAL nCnt		:=0
LOCAL cValor
LOCAL nPosTot :=0
LOCAL cLin1
LOCAL cLin2
LOCAL cLin3
LOCAL cLin4
LOCAL cLin5
LOCAL nRet
LOCAL nCasas	:=0
LOCAL nColAno :=0
LOCAL aMes		:={ OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015),;  //"Janeiro    "###"Fevereiro  "###"Marco      "
OemToAnsi(STR0016),OemToAnsi(STR0017),OemToAnsi(STR0018),;  //"Abril      "###"Maio       "###"Junho      "
OemToAnsi(STR0019),OemToAnsi(STR0020),OemToAnsi(STR0021),;  //"Julho      "###"Agosto     "###"Setembro   "
OemToAnsi(STR0022),OemToAnsi(STR0023),OemToAnsi(STR0024) }  //"Outubro    "###"Novembro   "###"Dezembro   "
LOCAL oDlg
Local lCheque := (ExistBlock("FINR460"))
Local I

cBanco		:= aCheque[1]
cCurrency	:= aCheque[2]
cFavorec 	:= aCheque[3]
cCidade		:= aCheque[4]
dEmissao 	:= aCheque[5]
nValor		:= aCheque[6]
cValor		:= strzero(aCheque[6],12,2)
nCheque		:= aCheque[7]

DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(titulo) PIXEL

@ 005, 007 TO 045, 175 LABEL OemToAnsi(STR0009) OF oDlg PIXEL	//"Dados Bancarios"
@ 050, 007 TO 080, 175 OF oDlg PIXEL

@ 029, 014 SAY  OemToAnsi(STR0010) OF oDlg PIXEL  //"Insira o Cheque"
@ 058, 014 SAY  OemToAnsi(cDesc1) SIZE 160, 11 OF oDlg PIXEL
@ 068, 014 SAY  OemToAnsi(cDesc2) SIZE 160, 11 OF oDlg PIXEL

DbSelectArea("SA6")
@ 016, 014 SAY  SA6->A6_COD + "  " + SubStr( SA6->A6_NOME, 1,20 ) SIZE 120, 11 OF oDlg PIXEL
@ 027, 055 MSGET nCheque	Picture "@X"         SIZE 60, 11 OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (oDlg:End(),lEnd:=.T.) ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg

IF lEnd	.OR.	nLastKey == 27
	Return -5
Endif

MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,e,8,2")

msWrite(nHdll,CHR(27)+CHR(48))
msWrite(nHdll,CHR(27)+CHR(83)+"5")
msWrite(nHdll,Chr(27)+Chr(62))
msWrite(nHdll,CHR(27)+CHR(48))

SA6->(dbSeek(xFilial("SA6")+aCheque[1]))
cCfgChk	:= Iif(Empty(SA6->A6_LAYOUT),"208120030004000551285 7090 S",SA6->A6_LAYOUT)
nLinVlr	:= Val(SubStr(cCfgChk, 4, 1))
nColVlr	:= Val(SubStr(cCfgChk,25, 3))
nColVlr	:= IIF(nColVlr==0,93,nColVlr)
nLin1Ext := Val(SubStr(cCfgChk, 5, 1))
nCol1Ext := Val(SubStr(cCfgChk, 6, 2))
nLin2Ext := Val(SubStr(cCfgChk, 8, 1))
nCol2Ext := Val(SubStr(cCfgChk, 9, 2))
nTamExt	:= Val(SubStr(cCfgChk,23, 2))
nTamExt	:= IIF(nTamExt==0,70,nTamExt)
nLinFav	:= Val(SubStr(cCfgChk,11, 2))
nColFav	:= Val(SubStr(cCfgChk,13, 2))
nLinDat	:= Val(SubStr(cCfgChk,15, 2))
nColVir	:= Val(SubStr(cCfgChk,17, 2))
nColAno	:= Val(SubStr(cCfgChk,20,3))
nCasas		:= Val(SubStr(cCfgChk,19, 1))
nCasas		:= IIF(nCasas==0,2,nCasas)
lComp 		:= (SubStr(cCfgChk,28, 1)=="S" .or. SubStr(cCfgChk,28, 1)==" ")

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Recupera o extenso do cheque e monta as linhas			³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cExtenso := Extenso(nValor,.F.,1)+" "
nPosAnt	:= 1

While .T.
	
	nTamLin :=70-IIF(nPosAnt==1,nCol1Ext,nCol2Ext)
	cExt	:= SubStr(cExtenso,nPosAnt,nTamLin)
	
	IF SubStr(cExtenso,(nPosAnt+nTamLin)-1,1)==" " .OR. SubStr(cExtenso,(nPosAnt+nTamLin),1)==" "
		nPosTot += Len(cExt)
		nPosAnt+=Len(cExt)
	Else
		nTamAnt := Len(cExt)
		nPosTot += Len(cExt)+1
		cExt:=SubStr(cExt,1,RAT(" ",cExt)-1)
		nPosAnt+=Len(cExt)+1
		nDif:=nTamAnt-Len(cExt)
		FOR i:= 1 TO LEN(cExt)
			IF nCnt >= nDif;Exit;End
			IF SubStr(cExt,i,1) == " "
				cExt:=SubStr(cExt,1,i)+" "+SubStr(cExt,i+1,Len(cExt))
				i++
				nCnt++
			EndIF
		Next i
	ENDIF
	AADD(aLinhas,cExt)
	IF nPosTot >= Len(cExtenso)
		Exit
	Endif
EndDO

FOR I:= 1 TO LEN(aLinhas)
	nTamLin:=70-IIF(I==1,nCol1Ext,nCol2Ext)
	IF Len(aLinhas[I]) < nTamLin
		aLinhas[I] := aLinhas[I]+Replicate("*",nTamLin-Len(aLinhas[I]))
	ENDIF
NEXT I

IF Len(aLinhas)==1
	AADD(aLinhas,Replicate("*",70-nCol2Ext))
EndIF

cLin1:=cCurrency+LTRIM(Transform(nValor,"@E 999,999,999,999.99"))
cLin2:=aLinhas[1]
cLin3:=IIF(Len(aLinhas)>1,aLinhas[2],Replicate("*",70))
cLin4:=SUBSTR(aLinhas[IIF(Len(aLinhas)>2,3,2)],1,70)
cLin5:=If(GetMV("MV_FAVOR"),cFavorec,Space(Len(cFavorec)))
cPiva:=strzero(80-Len(cLin1),3)

MsWrite(nHdll,Chr(27)+Chr(83)+"4")

MsgAlert(OemToAnsi(STR0025),OemToAnsi(STR0001))  //"Insira o cheque na impressora."###"Cheques Especiais"

msWrite(nHdll,Chr(27)+Chr(55)+Chr(27)+Chr(55)+Chr(27)+Chr(55)+Chr(27)+Chr(55)+Chr(27)+Chr(55))
msWrite(nHdll,Chr(27)+Chr(62))
msWrite(nHdll,Chr(27)+Chr(74)+ cPiva + cLin1)
msWrite(nHdll,Chr(10)+Chr(10))
msWrite(nHdll,Chr(27)+Chr(74)+"010" + "("+SUBST(cLin2,1,70))
msWrite(nHdll,Chr(10)+Chr(10))
msWrite(nHdll,Chr(27)+Chr(74)+"010" + SUBSTR(cLin3 ,1,69)+")")
msWrite(nHdll,Chr(10)+Chr(10))
msWrite(nHdll,Chr(27)+Chr(74)+"010" + subs(cLin5 ,1,70))
msWrite(nHdll,Chr(10)+Chr(10))
msWrite(nHdll,Chr(27)+Chr(74)+"036" + ALLTRIM(cCidade)      + Chr(13) +;
	Chr(27)+Chr(74)+"057" + STR(Day(dEmissao))    + Chr(13) +;
	Chr(27)+Chr(74)+"066" + aMes[Month(dEmissao)] + Chr(13) +;
	Chr(27)+Chr(74)+"078" + SubStr(Str(Year(dEmissao),4),3,2)+Chr(13))
msWrite(nHdll,Chr(27)+Chr(79))

If lCheque
	Execblock("FINR460",.f.,.f.,nHdll)
End

MsClosePort(nHdll)

nRet := 0
Return nRet

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³AutoCheck8³ Autor ³ Erick Nori Barbosa	  ³ Data ³ 09/07/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Imprime um cheque na impressora padr„o SCHALTER				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³U_AutoCheck2(ExpN1,ExpC1)												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 - Valor do cheque a ser impresso.						  ³±±
±±³			 ³ ExpC1 - Codigo do Banco.											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AutoCheck8(aCheque,lEnd,nHdll)

LOCAL cBanco
LOCAL dEmissao
LOCAL nRet
LOCAL oDlg
LOCAL lOk			:= .F.
LOCAL cLinOneVer	:= aCheque[8]
LOCAL cLinTwoVer	:= aCheque[9]
LOCAL cLinTreeVer := aCheque[10]
Local lCheque := (ExistBlock("FINR460"))

cBanco	 := aCheque[1]
cFavorec  := aCheque[3]
cCidade	 := aCheque[4]
dEmissao  := aCheque[5]
cValor	 := Alltrim(Str(aCheque[6],15,2))
cValor	 := SubStr(cValor,1,Len(cValor)-3) + SubStr(cValor,Len(cValor)-1,2)
nCheque	 := aCheque[7]

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Mostra a condi‡„o de impress„o do cheque e aceita o n£mero³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(titulo) PIXEL

@ 005, 007 TO 045, 175 LABEL OemToAnsi("Dados Bancarios") OF oDlg PIXEL
@ 050, 007 TO 080, 175 OF oDlg PIXEL

@ 029, 014 SAY  OemToAnsi("Insira o Cheque") OF oDlg PIXEL
@ 058, 014 SAY  OemToAnsi(cDesc1) SIZE 160, 11 OF oDlg PIXEL
@ 068, 014 SAY  OemToAnsi(cDesc2) SIZE 160, 11 OF oDlg PIXEL

DbSelectArea("SA6")
@ 016, 014 SAY  SA6->A6_COD + "  " + SubStr( SA6->A6_NOME, 1,20 ) SIZE 120, 11 OF oDlg PIXEL
@ 027, 055 MSGET nCheque	Picture "@X"         SIZE 60, 11 OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (oDlg:End(),lEnd:=.T.) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg

IF lEnd .OR. nLastKey == 27
	Return -5
Endif

nRet := 0

MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")

MsWrite(nHdll,chr(27)+ "b" + cBanco)
MsWrite(nHdll,chr(27)+ "c" + AllTrim(cCidade) + "$")
MsWrite(nHdll,chr(27)+ "d" + strzero(day(dEmissao),2) +strzero(month(dEmissao),2) +Substr(strzero(year(dEmissao),4),3,2))
MsWrite(nHdll,chr(27)+ "f" + If(GetMV("MV_FAVOR"),cFavorec,Space(Len(cFavorec))) + "$")
MsWrite(nHdll,chr(27)+ "v" + cValor + "$")

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Imprime o hist¢rico do cheque se houver ³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cImprVerso	$ "Ss" .and. ( !Empty(aCheque[8]) .or. !Empty(aCheque[9]) )
	DEFINE MSDIALOG oDlg FROM 173,9 TO 334,453 TITLE OemToAnsi(titulo) PIXEL
	@ 005, 007 TO 77, 180 OF oDlg PIXEL
	@ 015, 014 SAY  OemToAnsi("Vire o cheque na impressora e clique no botao OK") SIZE 120, 10 OF oDlg PIXEL
	@ 025, 014 SAY  OemToAnsi("para imprimir o hist¢rico no verso.") SIZE 100, 10 OF oDlg PIXEL
	DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION (lOk := .T. ,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 22, 187 TYPE 2 ACTION (lOk := .F. ,oDlg:End()) ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg
	If lOk
		MsWrite(nHdll,Chr(32) + Chr(32) + Chr(32) + Chr(32) + Chr(32) +;
			Chr(32) + Chr(32) + Chr(32) + Chr(32) + Chr(32) + cLinOneVer +;
			Chr(10) + Chr(32) + Chr(32) + Chr(32) + Chr(32) + Chr(32) +;
			Chr(32) + Chr(32) + Chr(32) + Chr(32) + Chr(32) + cLinTwoVer +;
			Chr(10) + Chr(32) + Chr(32) + Chr(32) + Chr(32) + Chr(32) +;
			Chr(32) + Chr(32) + Chr(32) + Chr(32) + Chr(32) + cLinTreeVer +;
			Chr(10) + Chr(12))
	EndIf
EndIf

If lCheque
	Execblock("FINR460",.f.,.f.,nHdll)
End

MsClosePort(nHdll)

Return nRet

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³AutoCheck9³ Autor ³ Antonio Maniero Jr.   ³ Data ³ 13/10/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime um cheque na impressora padr„o AUTOCHECK QUATTRO   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_AutoCheck9(ExpN1,ExpC1) 											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 - Valor do cheque a ser impresso.						  ³±±
±±³			 ³ ExpC1 - Codigo do Banco.											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AutoCheck9(aCheque,lEnd,nHdll)

LOCAL cBanco
LOCAL dEmissao
LOCAL nRet
LOCAL oDlg
Local lCheque := (ExistBlock("FINR460"))
Local lOk

cBanco	 := aCheque[1]
cFavorec := aCheque[3]
cCidade	:= aCheque[4]
dEmissao := aCheque[5]
cValor	 := str(aCheque[6],12,2)
nCheque	:= aCheque[7]

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Acessa a parametriza‡„o do banco 		 ³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SA6")
dbSeek(cFilial+cBanco)

DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(titulo) PIXEL
@ 005, 007 TO 045, 175 LABEL OemToAnsi(STR0009) OF oDlg PIXEL	//"Dados Bancarios"
@ 050, 007 TO 080, 175 OF oDlg PIXEL

@ 029, 014 SAY  OemToAnsi(STR0010) OF oDlg PIXEL  //"Insira o Cheque"
@ 058, 014 SAY  OemToAnsi(cDesc1) SIZE 160, 11 OF oDlg PIXEL
@ 068, 014 SAY  OemToAnsi(cDesc2) SIZE 160, 11 OF oDlg PIXEL

DbSelectArea("SA6")
@ 016, 014 SAY  SA6->A6_COD + "  " + SubStr( SA6->A6_NOME, 1,20 ) SIZE 120, 11 OF oDlg PIXEL
@ 027, 055 MSGET nCheque	Picture "@X"         SIZE 60, 11 OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (oDlg:End(),lEnd:=.T.) ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg

IF lEnd	.OR.	nLastKey == 27
	Return -5
Endif

If ( MV_PAR01 <= 2 )
	MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")
Else
	cPorta := If( MV_PAR01 == 3 , "LPT1" , "LPT2" )                                     
	nHdll := CBOpenPort(cPorta)
EndIf	

If ( MV_PAR01 <= 2 )
	MsWrite(nHdll,Chr(27)+Chr(162) + cBanco          +chr(13);
				 +Chr(27)+Chr(164) + left(dTOC(dEmissao),6)+Right(dTOC(dEmissao),2)  +chr(13);
				 +Chr(27)+Chr(160) + cFavorec        +chr(13);
			 	 +Chr(27)+Chr(161) + cCidade         +chr(13);
				 +Chr(27)+Chr(163) + cValor          +chr(13);
				 +Chr(27)+Chr(176))

	MsWrite(nHdll, chr(12))

Else	
	CBWritePort(nHdll,Chr(27)+Chr(162) + cBanco          +chr(13);
				 +Chr(27)+Chr(164) + left(dTOC(dEmissao),2)+ SubStr(DTOC(dEmissao),4,2) +Right(dTOC(dEmissao),2)  +chr(13);
				 +Chr(27)+Chr(160) + cFavorec        +chr(13);
			 	 +Chr(27)+Chr(161) + cCidade         +chr(13);
				 +Chr(27)+Chr(163) + cValor          +chr(13);
				 +Chr(27)+Chr(176),.f.)

EndIf

If lCheque
	Execblock("FINR460",.f.,.f.,nHdll)
Endif

If ( MV_PAR01 <= 2 )
	MsClosePort(nHdll)
Else
	CBClosePort(nHdll)	
EndIf	


*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Imprime o hist¢rico do cheque se houver						³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF cImprVerso	$ "Ss" .and. ( !Empty(aCheque[8]) .or. !Empty(aCheque[9]) )

	If MsgYesNo(STR0011+CRLF+STR0026+CRLF,"Impressao de verso de cheque - QUATTRO")
		If MV_PAR01 <= 2
			MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")
			MsWrite(nHdll, space(10) + aCheque[8])
			MsWrite(nHdll, space(10) + aCheque[9])
			MsWrite(nHdll, space(10) + aCheque[10])
			
			MsClosePort(nHdll)

		Else
			nHdll := CBOpenPort(cPorta)

			CBWritePort(nHdll,Chr(27)+".5905"+ LEFT(ALLTRIM(aCheque[8]),60)+"}",.f.)
			CBWritePort(nHdll,Chr(27)+".5906"+ LEFT(ALLTRIM(aCheque[9]),60)+"}",.f.)

			CBWritePort(nHdll,Chr(27)+".5910}",.F.)
			CBClosePort(nHdll)										

		EndIf		
		
	Endif
Endif

nRet := 0
Return nRet

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³AutoCheckD³ Autor ³ Erick Nori Barbosa	  ³ Data ³ 09/07/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime um cheque na impressora padr„o AUTOCHECK			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_AutoCheck2(ExpN1,ExpC1) 											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 - Valor do cheque a ser impresso.						  ³±±
±±³			 ³ ExpC1 - Codigo do Banco.											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AutoCheckD(aCheque,lEnd,nHdll)
LOCAL cBanco
LOCAL dEmissao
LOCAL nRet
LOCAL oDlg
Local wData
Local lCheque := (ExistBlock("FINR460"))
Local cPrintStr := ""

cBanco	 := aCheque[1]
cFavorec := aCheque[3]
cCidade	:= aCheque[4]
dEmissao := aCheque[5]
cValor	 := Alltrim(Str(aCheque[6],15,2))
cValor	 := SubStr(cValor,1,Len(cValor)-3) + SubStr(cValor,Len(cValor)-1,2)
nCheque	:= aCheque[7]

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Formata a Serial e Envia caracteres 							³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nRet	:=0

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Mostra a condi‡„o de impress„o do cheque e aceita o n£mero³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(titulo) PIXEL

@ 005, 007 TO 045, 175 LABEL OemToAnsi(STR0009) OF oDlg PIXEL	//"Dados Bancarios"
@ 050, 007 TO 080, 175 OF oDlg PIXEL

@ 029, 014 SAY  OemToAnsi(STR0010) OF oDlg PIXEL  //"Insira o Cheque"
@ 058, 014 SAY  OemToAnsi(cDesc1) SIZE 160, 11 OF oDlg PIXEL
@ 068, 014 SAY  OemToAnsi(cDesc2) SIZE 160, 11 OF oDlg PIXEL

DbSelectArea("SA6")
@ 016, 014 SAY  SA6->A6_COD + "  " + SubStr( SA6->A6_NOME, 1,20 ) SIZE 120, 11 OF oDlg PIXEL
@ 027, 055 MSGET nCheque	Picture "@X"         SIZE 60, 11 OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (oDlg:End(),lEnd:=.T.) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg

IF lEnd	.OR.	nLastKey == 27
	Return -5
Endif

MsOpenPort(nHdll,Iif(mv_par01==1,"COM1","COM2")+":9600,n,8,1")
wdata := dtoc(dEmissao)
wdata := left(wdata,2) + substr(wdata,4,2) + right(wdata,2)

cPrintStr := chr(27) +'r' 				// Limpeza de Buffer
cPrintStr += chr(27) +'b'+ cBanco
cPrintStr += chr(27) +"f"+ If(GetMV("MV_FAVOR"),cFavorec,Space(Len(cFavorec))) + "$"
cPrintStr += chr(27) +"c"+ AllTrim(cCidade) + "$"
cPrintStr += chr(27) +"d"+ Wdata
cPrintStr += chr(27) +"v"+ cValor + "$"

MsWrite(nHdll,cPrintStr)

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³ Nesta impressora n„o descobrimos como imprimir o verso   ³
*³ visto que ela somente imprime cheque (n„o texto livre)   ³
*³ Desta forma, abrimos um ponto de entrada com a porta se- ³
*³ rial aberta para que eventualmente possa ser customizado.³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lCheque
	Execblock("FINR460",.f.,.f.,nHdll)
End

MsClosePort(nHdll)

Return nRet

//-------------------------------------------------------------------
/*/{Protheus.doc} AutoCheckP
Imprime um cheque na impressora padrão PERTOCHEK

@sample		cRet := U_AutoCheckP( aCheque, @lEnd, @nHdll, Alltrim(cNome), cPorta )
@Return		cRet - Indica se a função conseguiu imprimir ou não.
@author		Mauricio Pequim Jr
@since		25.07.2001
@version	12
/*/
//-------------------------------------------------------------------

User Function AutoCheckP(aCheque, lEnd, nHdll, cNome, cPorta )

	Local cBanco	:= ""
	Local cRet		:= ""
	Local cMensagem	:= ""
	Local cVerso	:= ""
	Local dEmissao	:= CToD("  /  /    ")
	Local oDlg		:= Nil
	Local oDig  	:= Nil

	cBanco		:= aCheque[1]
	cFavorec	:= F460TrCEsp( FwNoAccent( aCheque[3] ) )
	cCidade		:= F460TrCEsp( FwNoAccent( aCheque[4] ) )
	dEmissao	:= aCheque[5]
	cValor		:= STRZERO( aCheque[6], 12, 2 )
	nCheque		:= aCheque[7]

	// Mostra a condi‡„o de impress„o do cheque e aceita o n£mero
	DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(titulo) PIXEL

		@ 005, 007 TO 045, 175 LABEL OemToAnsi(STR0009) OF oDlg PIXEL			//"Dados Bancarios"
		@ 050, 007 TO 080, 175 OF oDlg PIXEL

		@ 029, 014 SAY OemToAnsi(STR0010) OF oDlg PIXEL						//"Insira o Cheque"
		@ 058, 014 SAY OemToAnsi(cDesc1) SIZE 160, 11 OF oDlg PIXEL
		@ 068, 014 SAY OemToAnsi(cDesc2) SIZE 160, 11 OF oDlg PIXEL

		DbSelectArea("SA6")
		@ 016, 014 SAY SA6->A6_COD + "  " + SubStr( SA6->A6_NOME, 1,20 ) SIZE 120, 11 OF oDlg PIXEL
		@ 027, 055 MSGET nCheque Picture "@X" SIZE 60, 11 OF oDlg PIXEL

		DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
		DEFINE SBUTTON FROM 20, 187 TYPE 2 ACTION (oDlg:End(),lEnd:=.T.) ENABLE OF oDlg

	ACTIVATE MSDIALOG oDlg

	If lEnd	.OR.	nLastKey == 27
		Return "9"
	EndIf

	If nHdll < 0
		nHdll := CHABRIR(cNome,cPorta)
	EndIf

	If nHdll < 0
		Return "9"
	EndIf

	If ExistBlock("F460VER")
		cVerso:=	Execblock("F460VER",.f.,.f.,{cNome})
	EndIf

	If ExistBlock("F460MSG")
		cMensagem := Execblock("F460MSG",.f.,.f.,{cNome})
	EndIf

	cBanco		:= aCheque[1]
	cFavorec	:= F460TrCEsp( FwNoAccent( aCheque[3] ) )
	cCidade		:= F460TrCEsp( FwNoAccent( aCheque[4] ) )
	dEmissao	:= aCheque[5]
	cValor		:= STRZERO( aCheque[6], 12, 2 )
	nCheque		:= aCheque[7]

	If mv_par09 == 1   //Cheque layout normal
		cRet := STR(CHImprime   ( nHdll, cBanco, cValor, cFavorec, cCidade, DTOS(dEmissao), cMensagem, cVerso, , , If( mv_par09 == 2, mv_par11, ), If( mv_par09 == 2, mv_par12, ) ) )
	Else					 //Cheque layout transferencia (apenas BEMATECH)
		cRet := STR(CHImprTransf( nHdll, cBanco, cValor, cCidade, DTOS(dEmissao), If(mv_par09==2,mv_par11,), If(mv_par09==2,mv_par12,), cMensagem ))
	EndIf

	If !MsgYesNo( OemtoAnsi(STR0027), OemToAnsi(STR0002) )	//STR0027 - O Cheque foi impresso corretamente # STR0002 - Cheque
		cRet := "9"	// Não imprimiu
	EndIf

Return Alltrim(cRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FR460CC  ³ Autor ³ Mauricio Pequim Jr    ³ Data ³ 24.06.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verificacao do Banco/Agencia/Conta destino do cheque CPMF  ³±±
±±³          ³ das perguntas 12, 13 e 14. Se encontra no SX1      		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FR460CC()	                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Finr480                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fr460CC(nOpcao)

Local lRet := .T.
Local aArea := GetArea()

If cPaisLoc == "BRA" .and. mv_par09 == 2 .and. ((nOpcao == 1 .and. !Empty(mv_par10) .and. !CarregaSa6(mv_par10)) .or. ;
	(nOpcao == 2 .and. !Empty(mv_par10+mv_par11) .and. !CarregaSa6(mv_par10,mv_par11)) .or. ;
	(nOpcao == 3 .and. !Empty(mv_par10+mv_par11+mv_par12) .and. !CarregaSa6(mv_par10,mv_par11,mv_par12)))
	lRet := .F.
Endif

RestArea(aArea)

Return lRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FR460GrSE5º Autor ³ Gustavo Henrique   º Data ³  29/06/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Cria o registro de movimentacao bancaria para o cheque     º±±
±±º          ³ que sera impresso                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Historico do cheque impresso caso nao exista no    º±±
±±º          ³         registro da SEF                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR460GrSE5(cHistor, cChaveCH, lGravaFKA)
//REESTRUTURAÇÃO - SE5
Local oModelMov
Local oSubFK5
Local oFKA
Local cChaveFK5	:= ""
Local cCamposE5	:= ""
Local lRet			:= .T.
Local nOrdSA6		:= 1
Local cMoedaBco	:= 1
Local nRegCheq		:= 0
Local cHisto		:= Iif(!Empty(SEF->EF_HIST),SEF->EF_HIST,cHistor)

Default cHistor := ""
Default lGravaFKA := .T.


/*
Reclock("SE5",.T. )
SE5->E5_FILIAL	:= cFilial 
SE5->E5_BANCO 	:= MV_PAR02
SE5->E5_AGENCIA	:= MV_PAR03
SE5->E5_CONTA		:= MV_PAR04
SE5->E5_BENEF		:= SEF->EF_BENEF
SE5->E5_DATA		:= SEF->EF_DATA
SE5->E5_NUMCHEQ	:= SEF->EF_NUM
SE5->E5_DTDIGIT	:= SEF->EF_DATA
SE5->E5_HISTOR	:= Iif(!Empty(SEF->EF_HIST),SEF->EF_HIST,cHistor)
SE5->E5_RECPAG	:= "P"
SE5->E5_TIPODOC	:= "CH"
SE5->E5_VALOR		:= SEF->EF_VALOR
SE5->E5_NATUREZ	:= SE2->E2_NATUREZ
SE5->E5_DTDISPO	:= SEF->EF_DATA
SE5->(MsUnlock())
*/


nOrdSA6:=SA6->( IndexOrd() )
DbSetOrder( 1 )
SA6->( msSeek( xFilial("SA6") + MV_PAR02 + MV_PAR03 + MV_PAR04 ) )
cMoedaBco := STRZERO( Max( SA6->A6_MOEDA, 1 ), 2 ) 
SA6->( DbSetOrder( nOrdSA6 ) )
				
//Define os campos que não existem nas FKs e que serão gravados apenas na E5, para que a gravação da E5 continue igual
If !Empty(cCamposE5)
	cCamposE5 += "|"
Endif
cCamposE5 += "{"
cCamposE5 += "	 {'E5_BENEF'		, SEF->EF_BENEF}"
cCamposE5 += "	,{'E5_DTDIGIT'	, SEF->EF_DATA}"
cCamposE5 += "}"

oModelMov	:= FWLoadModel("FINM030") //Mov. Bancario
oModelMov:SetOperation( 3 ) //Inclusao
oModelMov:Activate()	
oModelMov:SetValue( "MASTER", "E5_GRV", .T. ) //Informa se vai gravar SE5 ou não
oModelMov:SetValue( "MASTER", "NOVOPROC", .T. ) //Informa que a inclusão será feita com um novo número de processo				
oModelMov:SetValue( "MASTER", "E5_CAMPOS", cCamposE5 ) //Informa os campos da SE5 que serão gravados indepentes de FK5

oSubFK5	:= oModelMov:GetModel("FK5DETAIL")
cChaveFK5	:= FWUUIDV4()

//Dados do Processo - Define a chave da FK5 no IDORIG
oFKA := oModelMov:GetModel("FKADETAIL")
If !oFKA:IsEmpty()
	oFKA:AddLine()
Endif
oFKA:SetValue( "FKA_IDORIG", cChaveFK5 )
oFKA:SetValue( "FKA_TABORI", "FK5" )
	
//Dados da baixa a pagar
oSubFK5:SetValue( "FK5_BANCO"	, MV_PAR02 )
oSubFK5:SetValue( "FK5_AGENCI"	, MV_PAR03 )
oSubFK5:SetValue( "FK5_CONTA"	, MV_PAR04 )
oSubFK5:SetValue( "FK5_DATA"		, SEF->EF_DATA )
oSubFK5:SetValue( "FK5_NUMCH"	, SEF->EF_NUM )
oSubFK5:SetValue( "FK5_HISTOR"	, LEFT(cHisto, 40) )
oSubFK5:SetValue( "FK5_RECPAG"	, "P" )
oSubFK5:SetValue( "FK5_TPDOC"	, "CH" )
oSubFK5:SetValue( "FK5_VALOR"	, SEF->EF_VALOR )
oSubFK5:SetValue( "FK5_NATURE"	, SE2->E2_NATUREZ )
oSubFK5:SetValue( "FK5_DTDISP"	, SEF->EF_DATA )
oSubFK5:SetValue( "FK5_MOEDA"	, STRZERO(POSICIONE("SA6",1,xFilial("SA6")+MV_PAR02+MV_PAR03+MV_PAR04,"A6_MOEDA"),2) )
oSubFK5:SetValue( "FK5_FILORI"	, SEF->EF_FILORIG )
oSubFK5:SetValue( "FK5_ORIGEM"	, FUNNAME() )

If lGravaFKA
	If !oFKA:IsEmpty()
		oFKA:AddLine()
	Endif
	oFKA:SetValue( "FKA_IDORIG", cChaveCH )
	oFKA:SetValue( "FKA_TABORI", "SEF" )
Endif

If oModelMov:VldData()
    oModelMov:CommitData()
	oModelMov:DeActivate()
Else
	lRet := .F.
    cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
    cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
    cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
    
    Help( ,,"M030VALID",,cLog, 1, 0 )
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao for um pagamento antecipado ira atualizar o Saldo³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !SE2->E2_TIPO $ MVPAGANT
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza o Saldo Banc rio		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AtuSalBco( MV_PAR02,MV_PAR03,MV_PAR04,SEF->EF_DATA,SEF->EF_VALOR,"-")
Endif

Return

//----------------------------------------------------------------------
/*/{Protheus.doc} FR460Banner

Função responsavel por mostrar um banner contendo as principais duvidas
dos processos estabelecidos dentro da rotina

@param Nil

@return Nil

@author Luiz Henrique 
@since 10/07/2019
/*/
//------------------------------------------------------------------------

User Function FR460Banner()
	Local	nLin	as	numeric
	Local	ncol	as	numeric
	Local	oDlg	as	object
	Local	oLayer	as	object
	Local	oSay	as	object
	Local	oFont 	as	object
	Local	cTxt	as	char
	Local   cMargiPri as Character
	Local   cMargiSec as Character

	cTxt			:=	''
	oFont 			:= 	TFont():New('Arial',,-12,.T.)
	oLayer 			:= 	FWLayer():New()
	nLin			:=	0
	nCol			:=	610
	nLin			:=	435
	cMargiPri		:= "margin-top:40px;"
	cMargiSec		:= "margin-top:20px;"
	
	cTxt	:= '<h1><strong>'+STR0033+'</strong></h1><br>'//"Smartclient Incompatível"
	cTxt	+= '<h2><strong>'+STR0034+'</strong></h2>'//"Ocorrencia:"
	cTxt	+= '<p style="'+cMargiSec+'">'+STR0035+'</p>'//"O SmartClient utilizado esta na versao 64 bits"
	cTxt	+= '<h2 style="'+cMargiPri+'"><strong>'+STR0036+'</strong></h2>'//"Solucao:"
	cTxt	+= '<p style="'+cMargiSec+'">'+STR0037+'</p>'//"Para o correto funcionamento dessa rotina, sera necessario alterar a versao do"
	cTxt	+= '<p>'+STR0038+'</p>'//"SmartClient para Lobo Guara 32 bits."
	cTxt    += '<p style="'+cMargiSec+'">'+STR0039+'</p>'//"Obs. Os arquivos estao disponiveis no Portal do Cliente"

	oDlg := MsDialog():New( 0, 0, nLin, nCol, "",,,, nOr( WS_VISIBLE, WS_POPUP ),,,,, .T.,,,, .F. )
	oLayer:Init( oDlg, .T. )
	oLayer:AddLine( "LINE01", 100 )
	oLayer:AddCollumn( "BOX01", 100,, "LINE01" )
	oLayer:AddWindow( "BOX01", "PANEL01", 'FINR460 - Cheques Especiais.', 100, .F.,,, "LINE01" )

	oSay	:=	TSay():New(10,10,{|| cTxt },oLayer:GetWinPanel ( 'BOX01' , 'PANEL01', 'LINE01' ),,oFont,,,,.T.,,,380,nLin,,,,,,.T.)
	oSay:lWordWrap = .T.

	oDlg:Activate(,,,.T.)

Return

//----------------------------------------------------------------------
/*/{Protheus.doc} F460TrCEsp

Função responsavel por retirar os caracteres especiais

@param	cTexto	- String a ser tratada
@return	cRet	- String tratada
@author	Rodrigo A. Pirolo
@since	06/12/2019
/*/
//------------------------------------------------------------------------

Static Function F460TrCEsp( cTexto )

	Local cRet := cTexto

	cRet := StrTran( cRet, "á", "a" )
	cRet := StrTran( cRet, "é", "e" )
	cRet := StrTran( cRet, "í", "i" )
	cRet := StrTran( cRet, "ó", "o" )
	cRet := StrTran( cRet, "ú", "u" )
	cRet := StrTran( cRet, "Á", "A" )
	cRet := StrTran( cRet, "É", "E" )
	cRet := StrTran( cRet, "Í", "I" )
	cRet := StrTran( cRet, "Ó", "O" )
	cRet := StrTran( cRet, "Ú", "U" )
	cRet := StrTran( cRet, "ã", "a" )
	cRet := StrTran( cRet, "õ", "o" )
	cRet := StrTran( cRet, "Ã", "A" )
	cRet := StrTran( cRet, "Õ", "O" )
	cRet := StrTran( cRet, "â", "a" )
	cRet := StrTran( cRet, "ê", "e" )
	cRet := StrTran( cRet, "î", "i" )
	cRet := StrTran( cRet, "ô", "o" )
	cRet := StrTran( cRet, "û", "u" )
	cRet := StrTran( cRet, "Â", "A" )
	cRet := StrTran( cRet, "Ê", "E" )
	cRet := StrTran( cRet, "Î", "I" )
	cRet := StrTran( cRet, "Ô", "O" )
	cRet := StrTran( cRet, "Û", "U" )
	cRet := StrTran( cRet, "ç", "c" )
	cRet := StrTran( cRet, "Ç", "C" )
	cRet := StrTran( cRet, "à", "a" )
	cRet := StrTran( cRet, "À", "A" )
	cRet := StrTran( cRet, "è", "e" )
	cRet := StrTran( cRet, "È", "E" )
	cRet := StrTran( cRet, "ì", "i" )
	cRet := StrTran( cRet, "Ì", "I" )
	cRet := StrTran( cRet, "ò", "o" )
	cRet := StrTran( cRet, "Ò", "O" )
	cRet := StrTran( cRet, "ò", "o" )
	cRet := StrTran( cRet, "Ò", "O" )
	cRet := StrTran( cRet, "ä", "a" )
	cRet := StrTran( cRet, "Ä", "A" )
	cRet := StrTran( cRet, "ë", "e" )
	cRet := StrTran( cRet, "Ë", "E" )
	cRet := StrTran( cRet, "ï", "i" )
	cRet := StrTran( cRet, "Ï", "I" )
	cRet := StrTran( cRet, "ö", "o" )
	cRet := StrTran( cRet, "Ö", "O" )
	cRet := StrTran( cRet, "ü", "u" )
	cRet := StrTran( cRet, "Ü", "U" )
	cRet := StrTran( cRet, "º", "." )
	cRet := StrTran( cRet, "ª", "." )
	cRet := StrTran( cRet, "¹", "1" )
	cRet := StrTran( cRet, "²", "2" )
	cRet := StrTran( cRet, "³", "3" )
	cRet := StrTran( cRet, "°", "." )
	cRet := StrTran( cRet, "_", "-" )
	cRet := StrTran( cRet, "$", "." )
	cRet := StrTran( cRet, "*", "." )
	cRet := StrTran( cRet, "%", "." )
	cRet := StrTran( cRet, "$", "." )
	cRet := StrTran( cRet, "\", "." )
	cRet := StrTran( cRet, "|", "." )
	cRet := StrTran( cRet, "/", "." )
	cRet := StrTran( cRet, "{", "." )
	cRet := StrTran( cRet, "}", "." )
	cRet := StrTran( cRet, "[", "." )
	cRet := StrTran( cRet, "]", "." )
	cRet := StrTran( cRet, "~", "." )
	cRet := StrTran( cRet, "§", "." )
	cRet := StrTran( cRet, "¬", "." )
	cRet := StrTran( cRet, "£", "." )
	cRet := StrTran( cRet, "¢", "." )
	cRet := StrTran( cRet, "'", "." )
	cRet := StrTran( cRet, '"', "." )
	cRet := StrTran( cRet, "@", "." )
	cRet := StrTran( cRet, '#', "." )
	cRet := StrTran( cRet, "%", "." )
	cRet := StrTran( cRet, '¨', "." )
	cRet := StrTran( cRet, "^", "." )
	cRet := StrTran( cRet, '<', "." )
	cRet := StrTran( cRet, ">", "." )
	cRet := StrTran( cRet, '¨', "." )
 
Return cRet
