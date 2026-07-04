/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR490.CH"
#include "PROTHEUS.ch"

Static lFWCodFil := FindFunction("FWCodFil")

//-------------------------------------------------------
/*/{Protheus.doc} FINR490
Cópia de cheque

@author Paulo Boschetti
@since 23/04/1992
@version P12
/*/
//-------------------------------------------------------
User Function FINR490()

LOCAL wnrel
LOCAL cDesc1 	:= STR0001  //"Este programa ir  imprimir as copias dos cheques emitidos."
LOCAL cDesc2 	:= STR0002  //"Ser  impresso 1 ou 2 cheques for folha."
LOCAL cDesc3 	:=""
LOCAL cString	:="SEF"

PRIVATE titulo   := STR0003  //"Copias de Cheques"
PRIVATE aReturn  := { STR0004, 1,STR0005, 4, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nLastKey :=0
PRIVATE nomeprog :="FINR490"
PRIVATE cPerg	 :="FIN490"
PRIVATE li		 :=1     
PRIVATE aFiliais := {}

// ------------------------------------------------------------------------------
// Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso 
// aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
If RetGlbLGPD('A1_NOME')
	Help(" ",1,"DADO_PROTEGIDO")
	RETURN 
ENDIF
// ------------------------------------------------------------------------------

// Verifica as perguntas selecionadas
pergunte("FIN490",.F.)

//--------------------------------------------------------------------------------
// Variaveis utilizadas para parametros
// mv_par01			// Codigo Do Banco
// mv_par02			// Da Agencia
// mv_par03			// Da Conta
// mv_par04			// Do Cheque
// mv_par05			// Ate o Cheque
// mv_par06			// Imprime composicao do cheque
// mv_par07			// Copias p/ pagina (1/2)
// mv_par08			// Imprime Numeracao Sequencial
// mv_par09			// Data Inicial
// mv_par10			// Data Final
// mv_par11			// Imprime linha única
// mv_par12			// Seleciona Filiais
//--------------------------------------------------------------------------------

// Envia controle para a funcao SETPRINT
wnrel := "FINR490"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,"P")

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| Fa490Imp(@lEnd,wnRel,cString)},titulo)

Return


//-------------------------------------------------------
/*/{Protheus.doc} FA490Imp
Impressão da Cópia de cheque

@param lEnd		- Ação do CodeBlock
@param wnRel	- Título do relatório
@param cString	- Mensagem

@author Paulo Boschetti
@since 23/04/1992
@version P12
/*/
//-------------------------------------------------------
Static Function FA490Imp(lEnd,wnRel,cString)

Local nJ		:= 0
Local nTipo		:= 18
Local nRec		:= 0
Local nContador := 0
Local cDocto	:= ""
Local lComprime := .T. //Configura compactacao na impressao
Local nCtrSaida := MV_PAR07    
Local nX		:= 1
Local lAchou	:= .F.
Local cFilPesq	:= cFilAnt
Local lSEFExcl	:= Iif(FWModeAccess("SEF",1) == "E" .AND. FWModeAccess("SEF",2) == "E" .AND. FWModeAccess("SEF",3) == "E", .T., .F.)
Local nQuebra	:= 60
Local nTamQuebra := 0
Local nI		:= 0
Local nCont		:= 0

If MV_PAR12 == 1
	If Empty(aFiliais)
		aFiliais := AdmGetFil()
		If Empty(aFiliais)
		   Aadd(aFiliais,cFilAnt)
		Endif
	Endif
Else
	Aadd(aFiliais,cFilAnt)
Endif                         

// Retirada a comparacao abaixo uma vez que o Protheus nao mais trabalha com normal e comprimido, mas com retrato e paisagem.
mv_par04:= Left(Alltrim(mv_par04)+Space(TamSx3("EF_NUM")[1]),TamSx3("EF_NUM")[1])

For nX := 1 to Len(aFiliais)
	// Verifica se existe o Banco
	DbSelectArea("SA6")
	If !DbSeek(xFilial("SA6",aFiliais[nX])+mv_par01+mv_par02+mv_par03)
		Set Device To Screen
		Help(" ",1,"BCONOEXIST")
		Return
	EndIF
Next nX

// Localiza o 1.Cheque a ser impresso
For nX := 1 to Len(aFiliais)
	
	cFilAnt := aFiliais[nX]	
	dbSelectArea("SEF")  
	DbSetOrder(1)
	nRec := SEF->(Recno())	
	If MV_PAR12 == 1
		If SEF->(DbSeek(Iif(lSEFExcl,cFilAnt,xFilial("SEF")) +mv_par01+mv_par02+mv_par03+mv_par04,.T.)) .and. !lAchou		
			cFilPesq  := cFilAnt
			lAchou := .T.
		EndIf  
	Else
		If !SEF->(DbSeek(Iif(lSEFExcl,cFilAnt,xFilial("SEF")) +mv_par01+mv_par02+mv_par03+mv_par04,.T.))
			IF !lSEFExcl .AND. Empty(SEF->EF_FILIAL) .And. nRec > 0 .And. (Empty(mv_par04) .OR. !lAchou)
				SEF->(DbGoto(nRec))
				nRec := 0
			EndIf
		EndIf	
	EndIf  
	
	SetRegua(RecCount())		
		
	While  	SEF->(!Eof()) .And. ;
	      	EF_FILIAL + EF_BANCO == IIF(lSEFExcl, aFiliais[nX],xFilial("SEF")) + mv_par01 .And. ;
		  	EF_AGENCIA == mv_par02 .And. ;
		  	EF_CONTA == mv_par03 .And. ;
		  	EF_NUM <= mv_par05 .And. ;
		   	nCtrSaida > 0
				
		// Nao imprimir cheques que serao aglutinados.
		If Empty(EF_NUM)
			dbSkip()                                                                                                                                                                
			Loop
		EndIf
		
		If lEnd
			@Prow()+1,1 PSAY STR0006  //"Cancelado pelo operador"
			Exit
		EndIF
		
		IncRegua()
		
		If !Empty(mv_par09)
			If DToS(EF_DATA) < DToS(mv_par09)
				dbSkip()
				Loop
			EndIf
		EndIf
		
		If !Empty(mv_par10)
			If DToS(EF_DATA) > DToS(mv_par10)
				dbSkip()
				Loop
			EndIf
		EndIf
	
		IF EF_IMPRESS $ "AC" .or. SubStr(EF_TIPO,1,2) == "TB"
			dbSkip()
			Loop
		EndIF
		
		If EF_CART = "R"
			DbSkip()
			Loop
		EndIf
		
		IF mv_par07 == 1		//uma copia por folha
			li:=1
		Elseif li > 32	 		//so coube uma copia
			li:=1
		Else					//2 copias por folha
			IF nContador == 0
				li:=1
			Else
				li:=33
			EndIF
		EndIF
	
		// Envia comando para comprimir impressao
		If lComprime
			fa490Cabec( nTipo )
			lComprime := .F. // Necessario apenas no primeiro registro
		EndIf
		
		nContador++
		IF nContador>2;nContador:=1;li:=1;EndIF
		__LogPages()
		
		//Valida tamanho do Texto para não ultrapassar o limite da linha (79)
		If Len( Alltrim(SM0->M0_NOMECOM) + " - " + Alltrim(SM0->M0_FILIAL) + STR0007 ) <  79
			@li, 1 PSAY Alltrim(SM0->M0_NOMECOM) + " - " + Alltrim(SM0->M0_FILIAL) + STR0007  //"  -  COPIA DE CHEQUE"
			li++
		Else
			@li, 1 PSAY Alltrim(SM0->M0_NOMECOM)
			li++			
			@li, 1 PSAY Alltrim(SM0->M0_FILIAL) + STR0007  //"  -  COPIA DE CHEQUE"
			li++
		EndIf
		
		@li, 0 PSAY Replicate("-",80)
		li++
		@li, 0 PSAY STR0008  + EF_NUM  //"|  Numero Cheque "
		@li,35 PSAY STR0009  + Dtoc(EF_DATA)  //"Data da Emissao "
		@li,79 PSAY "|"
		li++
		@li, 0 PSAY STR0010 + EF_BANCO + " " + SUBSTR(SA6->A6_NREDUZ,1,20)  //"|  Banco "
		@li,35 PSAY STR0011 + " " + EF_AGENCIA + STR0012 + EF_CONTA  //"Agencia###"   Conta "
		@li,79 PSAY "|"
		li++
		@li, 0 PSAY STR0013 + Transform(EF_VALOR,"@E 9999,999,999.99")  //"|  Valor Cheque "
		@li,35 PSAY STR0014 + Dtoc(EF_DATA)  //"Data do Cheque  "
		@li,79 PSAY "|"
		li++
		@li, 0 PSAY STR0015 + EF_BENEF  //"|  Favorecido "
		@li,79 PSAY "|"
		li++
		
		nTamQuebra := Len(Alltrim(SEF->EF_HIST))
		nCont := 1
		ni := 0 
		While nCont <= nTamQuebra
			ni++
			nQuebra := If(ni == 1,60,60 + Len(STR0016) - 3  )
			@li, 0 PSAY If(ni ==1, STR0016,"|  ")+SubStr(SEF->EF_HIST,nCont,nQuebra)  //"|  Historico  "
			@li,79 PSAY "|"
			li++
			nCont += nQuebra
		EndDo
		
		If mv_par08 == 1
			
			//---------------------------------------------------------------
			// Pegar e gravar o proximo numero da Copia do Cheque
			// Posicionar no sx6 utilizando GetMv. Não Utilize Seek !!!
			//---------------------------------------------------------------
			cDocto := STRZERO(VAL(Getmv("MV_NUMCOP"))+1,6)
			dbSelectArea("SX6")
			PutMv("MV_NUMCOP", cDocto)
			
			dbSelectArea("SEF")
			
			@li, 0 PSAY STR0017 + cDocto  //"|  Copia de Cheque No. "
			@li,79 PSAY "|"
		Else
			@li, 0 PSAY "|"
			@li,79 PSAY "|"
		End
		li++
		@li, 0 PSAY STR0018  //"|  Vistos"
		@li,79 PSAY "|"
		li++
		@li, 0 PSAY "|"+Replicate("-",78)+"|"
		li++
		@li, 0 PSAY STR0019  //"|Observacoes      |Contas a Pagar|Gerente Financ|Contabilidade |Assinado por   |"
		li++
		@li, 0 PSAY "|-----------------|--------------|--------------|--------------|---------------|"
		li++
		For nJ := 1 to 3
			@li, 0 PSAY "|"
			@li,18 PSAY "|"
			@li,33 PSAY "|"
			@li,48 PSAY "|"
			@li,63 PSAY "|"
			@li,79 PSAY "|"
			li++
		Next nJ
		@li, 0 PSAY Replicate("-",80)
		nRec := RecNo()
		IF mv_par06 == 1
			fr490Cpos(SEF->EF_NUM)
		EndIF
		nCtrSaida--
		dbGoTo(nRec)
		If nCtrSaida < 1
			nCtrSaida := MV_PAR07
		Endif
		SEF->(DbSkip())
	EndDo
Next nX

If MV_PAR12 == 1 .and. lAchou
	cFilAnt := cFilPesq
EndIf

If !lAchou
	cFilAnt := cFilPesq
EndIf

Set Device To Screen
Set Filter To

If aReturn[5] = 1
	Set Printer To
	dbCommit()
	ourspool(wnrel)
Endif

MS_FLUSH()


//-------------------------------------------------------
/*/{Protheus.doc} fr490Cpos³
Impressão da Cópia de cheque

@param cCheque	- número do cheque

@author Paulo Boschetti
@since 23/04/1992
@version P12
/*/
//-------------------------------------------------------
STATIC Function fr490Cpos(cCheque)

LOCAL nFirst		:= 0
Local lAglut		:= .F.
Local aColu			:= {}
Local aTam 			:= TamSX3("E2_FORNECE")
Local aTam2 		:= TamSX3("EF_TITULO")
Local cCabeca 		:= ""
Local cCabecb 		:= ""
Local nRegEmp		:= SM0->(Recno())
Local lExclusivo 	:= !Empty(FwFilial("SEF"))
Local nI			:= 0
Local aAreaAtual 	:= GetArea()  //Guarda area atual
Local cFilOrig 		:= ""
Local lModImp 		:= .F.  //Imprime linha unica. 
Local lImpresso		:= .F.
Local cCompEmp		:= FWModeAccess("SEF",3,cEmpAnt)   

If Type("aFiliais") == "U"
	aFiliais := {}
EndIf

If ValType( mv_par11 ) == 'N' .AND. mv_par11 == 1 .AND. aTam2[1] <= 9
	lModImp := .T.
EndIf	

DbSelectArea("SEF")
dbSeek (xFilial("SEF")+mv_par01+mv_par02+mv_par03+cCheque)

//-----------------------------------------------------------------
// Definicao das colunas de impressao
// aTam[1] = Tamanho do codigo do fornecedor (6 ou 20)
// aTam2[1]= Tamanho do nro de titulo (6 ou 12)
//-----------------------------------------------------------------
If aTam[1] > 6
	aColu := {001,025,057,008,012,026,030,052}
	cCabeca	:= STR0025  //"|Fornec                  Nome Fornecedor                 Natureza              |"
	cCabecb	:= STR0024  //"|       Prf Numero        P   Vencto                  Valor do Titulo          |"
ElseIf aTam2[1] > 6 .AND. lModImp == .F.
	aColu := {001,011,043,008,012,026,030,052}
	cCabeca	:= STR0023  //"|Fornec    Nome Fornecedor                 Natureza                            |"
	cCabecb	:= STR0024  //"|       Prf Numero        P   Vencto                  Valor do Titulo          |"
Else
	aColu := {001,008,027,037,041,051,054,064}
	cCabeca	:= STR0026 // "|Fornec   Nome Fornecedor   Prf Numero    P| Natureza   Vencto     Valor Titulo|"
	cCabecb	:= ""
Endif

For nI := 1 to Len(aFiliais)
	
	cFilAnt := aFiliais[nI]
	
	SM0->(DbSeek(cEmpAnt + cFilAnt))

	While SM0->(!Eof()) .and. SM0->M0_CODIGO == cEmpAnt .and. IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ) == cFilAnt
		
		cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
			
		If lImpresso .AND. Empty( FwFilial("SEF") ) // caso seja filial compartilhada, executa somente 1 vez. Sistema duplicava de acordo com nro de empresas. CHAMADO TDL907
			dbSelectArea("SM0")
			dbSkip()
			Loop
		Endif
		
		DbSelectArea("SEF")
		If MsSeek (xFilial("SEF")+ mv_par01 + mv_par02 + mv_par03 + cCheque)
			While !Eof() .And. EF_FILIAL+EF_BANCO == xFilial("SEF")+mv_par01 .And. ;
				EF_AGENCIA == mv_par02 .And. EF_CONTA == mv_par03 .And. ;
				EF_NUM == cCheque
				
				If EF_CART = "R"
					DbSkip()
					Loop
				EndIf

				IF EF_IMPRESS == "C"
					dbSkip()
					Loop
				EndiF
				
				IF li > 58
					li:=1
					@li,0 PSAY STR0020 + cCheque + STR0021  //"COPIA DO CHEQUE : "###" - Continuacao"
					li++
				EndIF
				
				IF nFirst == 0
					IF EF_IMPRESS = "A"
						lAglut:=.T.
					EndIF

					IF !lAglut .and. (Empty(SEF->EF_TITULO) .or. (!Empty(SEF->EF_TITULO) .and. SEF->EF_TIPO $ MVPAGANT))
						dbSkip()
						Loop
					Endif

					li++
					@li,0 PSAY STR0022 + Replicate("-",55)+"|"  //"|- Composicao do Cheque "
					li++
					@li,0 PSAY cCabeca
					//---------------------------------------------------------------------
					// Verifica se sera necess rio imprimir em duas linhas os detalhes
					// Isso ocorre qdo E2_FORNECE > 6 pos ou EF_TITULO > 6 pos.  
					//---------------------------------------------------------------------
					IF aTam[1] > 6 .OR. (aTam2[1] > 6 .AND. lModImp == .F.)
						li++
						@li,0 PSAY cCabecb
					Endif
					li++
					@li,0 PSAY Replicate("-",80)
				EndIF
				IF (Empty(SEF->EF_TITULO) .or. (SEF->EF_IMPRESS != "A" .AND. !Empty(SEF->EF_TITULO) .and. SEF->EF_TIPO $ MVPAGANT))
					dbSkip()
					Loop
				End
				If aTam[1] == 6 .and. (aTam2[1] == 6 .OR. lModImp == .T.)
					nTam := 18
				Else
					nTam := 30
				Endif
				nFirst++
				li++
				
				If SEF->EF_TIPO $ MVRECANT+"/"+MV_CRNEG
					dbSelectArea("SA1")
					MsSeek(cFilial+SEF->EF_FORNECE+SEF->EF_LOJA)
					
					dbSelectArea("SE1")
					MsSeek(cFilial+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO+SEF->EF_FORNECE+SEF->EF_LOJA)
					
					@li, 0 PSAY "|"
					@li, aColu[1] PSAY E1_CLIENTE
					
					If SuperGetMV("MV_COPCHQF",,"1") == "1"
						@li, aColu[2] PSAY SubStr(E1_NOMCLI	   ,1,nTam)
					Else
						@li, aColu[2] PSAY SubStr(SA1->A1_NOME,1,nTam)
					EndIf
					
					@li, aColu[3] PSAY SE1->E1_NATUREZ
					
				Else
					
					dbSelectArea("SA2")
					MsSeek(cFilial+SEF->EF_FORNECE+SEF->EF_LOJA)
					
					//Faz a busca pelo campo FILORIG caso seja multifiliais
					If (( !Empty( SEF->EF_FILORIG ) .AND. !Empty(FwFilial("SEF"))) .And. cCompEmp == "E" )
						cFilOrig := SEF->EF_FILORIG
					else
						cFilOrig := xFilial("SE2")
					EndIf
	
					DbSelectArea("SE2")
					MsSeek(cFilOrig+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO+SEF->EF_FORNECE+SEF->EF_LOJA)
					
					@li, 0 PSAY "|"
					@li, aColu[1] PSAY SE2->E2_FORNECE
					If SuperGetMV("MV_COPCHQF",,"1") == "1"
						@li, aColu[2] PSAY SubStr(SE2->E2_NOMFOR	   ,1,nTam)
					Else
						@li, aColu[2] PSAY SubStr(SA2->A2_NOME,1,nTam)
					EndIf
					
					@li, aColu[3] PSAY SE2->E2_NATUREZ
					
				EndIf
				
				dbSelectArea("SEF")
				//------------------------------------------------------------------------
				// Verifica se será necessário imprimir em duas linhas os detalhes. 
				// Isso ocorre qdo E2_FORNECE ou EF_TITULO forem > 6 pos e lModImp == .F.
				//-------------------------------------------------------------------------
				IF aTam[1] > 6 .or. (aTam2[1] > 6 .AND. lModImp == .F.) 
					@li,79 PSAY "|"
					li++
					@li, 0 PSAY "|"
				Endif
				@li, aColu[4] PSAY EF_PREFIXO
				@li, aColu[5] PSAY EF_TITULO
				@li, aColu[6] PSAY EF_PARCELA
				
				@li, aColu[7] PSAY Iif(SEF->EF_TIPO $ MVRECANT+"/"+MV_CRNEG,SE1->E1_VENCREA, SE2->E2_VENCREA)
				
 				@li, aColu[8] PSAY EF_VALOR PicTure tm(EF_VALOR,15)
				@li,79 PSAY "|"	
	
				lImpresso := .T.

				dbSkip()
			EndDO
		Endif

		//Se o SEF for compartilhado eu leio apenas uma vez.
		If !lExclusivo
			Exit
		Else
			dbSelectArea("SM0")
			dbSkip()
		Endif
	Enddo
	//Se o SEF for compartilhado eu leio apenas uma vez.
	If !lExclusivo
		Exit
	Endif
Next
SM0->(dbGoTo(nRegEmp))
cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )

IF nFirst>0
	li++
	@li, 0 PSAY Replicate("-",80)
EndIF 

RestArea( aAreaAtual ) //Restaura a area do chamador.

Return .T.


//-------------------------------------------------------
/*/{Protheus.doc} Fa490Cabec
Cabeçalho do relatório

@param nChar . 15-Comprimido , 18-Normal

@author Alessandro B. Freire
@since 18/12/1996
@version P12
/*/
//-------------------------------------------------------
Static Function Fa490cabec(nChar)

LOCAL cTamanho := "P"
LOCAL aDriver := ReadDriver()

If !( "DEFAULT" $ Upper( __DRIVER ) )
	SetPrc(000,000)
Endif

if nChar == NIL
	@ pRow(),pCol() PSAY &(if(cTamanho=="P",aDriver[1],if(cTamanho=="G",aDriver[5],aDriver[3])))
else
	if nChar == 15
		@pRow(),pCol() PSAY &(if(cTamanho=="P",aDriver[1],if(cTamanho=="G",aDriver[5],aDriver[3])))
	else
		@pRow(),pCol() PSAY &(if(cTamanho=="P",aDriver[2],if(cTamanho=="G",aDriver[6],aDriver[4])))
	endif
endif

Return(.T.)
