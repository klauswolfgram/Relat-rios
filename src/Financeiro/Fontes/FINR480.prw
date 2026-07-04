/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR480.CH"
#INCLUDE "PROTHEUS.CH"

STATIC nColVlr
STATIC nLin1Ext
STATIC nCol1Ext
STATIC nLin2Ext
STATIC nCol2Ext
STATIC nLinFav
STATIC nColFav
STATIC nLinDat
STATIC nColVir
STATIC cExt
STATIC nCasas  :=0
STATIC nColAno :=0                           
STATIC nTamChq	:=0
STATIC nTamExt
STATIC nTamLin
STATIC cValor
STATIC nSalto
STATIC nComp
STATIC __lFirst	:=.T.
STATIC __lSetPrint := .F.
STATIC __lTeste := .F.
STATIC __cFunName := ""
STATIC __lMVPAR15 As Logical


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} FINR480
Impressao de Cheques 

@author    Wagner Xavier
@version   1.00
@since     09/07/1992
//------------------------------------------------------------------------------------------
/*/
User Function FinR480()

LOCAL cDesc1 := STR0001  //"Este programa ir  imprimir os Cheques do Banco, atrav‚s de"
LOCAL cDesc2 := STR0002  //"formul rio pr‚-impresso."
LOCAL cDesc3 :=""
LOCAL cString :="SEF"
Local cFormato := SuperGetMv("MV_RESETIM", .F., "3")
Local lExibPerg := .F.
Local lRet := .T.
Local aPergunte	 As Array
Local oFwSX1Util As Object

PRIVATE wnrel
PRIVATE titulo := STR0003  //"Emiss„o de Cheques em Formul rio Cont¡nuo"
PRIVATE cabec1
PRIVATE cabec2
PRIVATE aReturn := { STR0004, 1, STR0005, 1, 2, 1, "",1 }  //"Cheque"###"Administracao"
PRIVATE nomeprog:="FINR480"
PRIVATE nLastKey:= 0
PRIVATE cPerg   :="FIN480"
PRIVATE lComp   := .T.
PRIVATE lLayOut := .F.
PRIVATE lMesNum := .F.
PRIVATE nLinVlr := 0
PRIVATE cNumCheq
PRIVATE cBenef
PRIVATE lFA480MUN := ExistBlock("FA480MUN")
PRIVATE lReset := .F.

aPergunte	 := {}


// ------------------------------------------------------------------------------
// Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso 
// aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
If RetGlbLGPD('EF_BENEF')
	Help(" ",1,"DADO_PROTEGIDO")
	lRet := .F.
ENDIF
// ------------------------------------------------------------------------------
If __lMVPAR15 == Nil
	__lMVPAR15 := .F.
EndIf
If !__lMVPAR15 .And. cPaisLoc = 'BRA'
	oFwSX1Util := FwSX1Util():New()

	//Valida se ambiente está atualizado e possuí o MV_PAR10
	oFwSX1Util:AddGroup("FIN480")
	oFwSX1Util:SearchGroup()
	aPergunte := oFwSX1Util:GetGroup("FIN480")

	If Len(aPergunte) > 1 .And. Len(aPergunte[2]) >= 15 .And. Upper(AllTrim(aPergunte[2][15]:CX1_VAR01)) == "MV_PAR15"
		__lMVPAR15 := .T.
	EndIf

	FwFreeArray(aPergunte)
	FwFreeObj(oFwSX1Util)
	aPergunte := Nil
EndIf
If lRet
	nComp	:= GetMv("MV_COMP")

	If cPaisLoc $ "ARG|EQU|DOM" .AND. AllTrim(FUNNAME()) <> "FINA095"
		MsgAlert(STR0037,STR0036)		//"Para imprimir cheques, utilize a rotina de Controle de Cheques emitidos."###"Atencion"
		lRet := .F.
	EndIf

	// Verifica as perguntas selecionadas
	If lRet
		If cPaisLoc<>"ARG"
			If !Pergunte("FIN480",.T.)
				lRet := .F.
			EndIf
			lExibPerg := .T.
		Endif
		//-------------------------------------------------------------------
		// Variaveis utilizadas para parametros
		// mv_par01            // Codigo do Banco
		// mv_par02            // Agencia
		// mv_par03            // Conta
		// mv_par04            // Do Cheque
		// mv_par05            // Ate o Cheque
		// mv_par06            // Numera cheque automaticamente (S/N)
		// mv_par07            // Numero do 1.Cheque
		// mv_par08            // Data Inicial
		// mv_par09            // Data Final
		// mv_par10            // Imprime cheques para PAS
		// mv_par11            // LayOut do Cheque (Normal ou CPMF)
		// mv_par12            // Codigo do Banco Destino (CPMF)
		// mv_par13            // Agencia  Destino (CPMF)
		// mv_par14            // Conta  Destino (CPMF)
		// mv_par15            // Numero de linhas por pagina
		//--------------------------------------------------------------------
		If lRet
			If cPaisLoc <> "BRA" .AND. FUNNAME()=="FINA095"

				If !lExibPerg	// Caso o pergunte n?o foi exibido.
					pergunte("FIN480",.F.)
					mv_par01 := SEF->EF_BANCO
					mv_par02 := SEF->EF_AGENCIA
					mv_par03 := SEF->EF_CONTA
					mv_par04 := SEF->EF_TALAO
					mv_par05 := SEF->EF_NUM
					mv_par06 := SEF->EF_NUM
				EndIf

				// Variaveis utilizadas para parametros (Ecuador\Rep.Dominicana)
				// mv_par01            // Codigo do Banco
				// mv_par02            // Agencia
				// mv_par03            // Conta
				// mv_par04            // Talao
				// mv_par05            // Do Cheque
				// mv_par06            // Ate o Cheque

			Else  
				If ValType(MV_PAR06) <> "N"
					If MV_PAR06 == 1 .And. Empty(MV_PAR07)
						Help(" ",1,"CHEQSNUM")
						lRet := .F.
					Endif
				EndIf	
			Endif
		EndIf	
	EndIf	
EndIf
If lRet
	If cPaisloc <> 'BRA'

		// Envia controle para a funcao SETPRINT
		wnrel := "FINR480"            //Nome Default do relatorio em Disco
		wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,"M")
		
		If cFormato <> AllTrim(STR(aReturn[4])) 
			If MsgYesNo( STR0038 ) 
				lReset := .T.	
				cFormato :=  AllTrim(STR(aReturn[4]))
				DbSelectArea("SX6")
				PutMv("MV_RESETIM", cFormato)
			Else
				lRet := .F.
			EndIf
		EndIf
		If lRet 
			If nLastKey == 27
				lRet := .F.
			Endif
			If lRet
				SetDefault(aReturn,cString)
		
				If nLastKey == 27
					lRet := .F.
				Endif
				If lRet
					RptStatus({|lEnd| FA480Imp()},Titulo)
				EndIf	
			EndIf	
		EndIf
	Else
		FA480Imp()
	EndIf
EndIf	
Return lRet


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} FA480Imp
Impressao de Cheques 

@author    Marcos Patricio
@version   1.00
@since     20/12/1995
//------------------------------------------------------------------------------------------
/*/
Static Function FA480Imp()

LOCAL nRecAnt		:= 0
LOCAL nSavRec, nSavOrd := 0
Local aDriver		:= ReadDriver()
Local cMunic		:= ""
Local lFa480Bene	:= ExistBlock("FA480BENE")  
Local nQtdeChe		:= 0
Local lMostraMsg	:= .F.  
Local aCheques		:= {} //Array para impressão de cheques 'a la orden'  
Local lNoAlOrd		:= SuperGetMv( "MV_FINORDE" , .F. , "2")  == "1"
Local lChInm		:= .F.

If cPaisLoc	<>	"BRA"
	Private	aLayout	:=	{{0,0,""}}
	Private 	nMoeda:=1

	If !( "DEFAULT" $ Upper( __DRIVER ) )
		SetPrc(000,000)
	Endif
	
	If lReset 
		If GetMv("MV_COMP") == 15
			@ pRow(),pCol() PSAY &(If(aReturn[4]=1,aDriver[3],aDriver[4]))
		Else
			@ pRow(),pCol() PSAY &(aDriver[4])
		EndIf
	EndIF

Endif

// Verifica se existe o Banco
dbSelectArea("SA6")

IF !SA6->(dbSeek(xFilial("SA6")+mv_par01+mv_par02+mv_par03))
	Help(" ",1,"BCONOEXIST")
	Return
Endif

If cPaisLoc == "BRA" .and. !U_FR480CC(3)
	Help(" ",1,"BCODESTINO",,STR0026,1,1) //"Dados da Conta Corrente Destino do cheque CPMF são inválidos"
	Return
Endif

If cPaisLoc<>"BRA"
	nMoeda:=Iif(SA6->A6_MOEDA>0,SA6->A6_MOEDA,1)
Endif
If  cPaisLoc == "BRA"

	// Verifica se já existe o cheque inicial
	If mv_par06 == 1 .And. SubStr(mv_par07, 1, 1 ) != "*"
		dbSelectArea("SEF")
		If SEF->(dbSeek(xFilial("SEF")+mv_par01+mv_par02+mv_par03+mv_par07))
			Help( " ",1,"A460CHEQUE")
			Return
		EndIf
	EndIf
	cNumCheq  := mv_par07
EndIf
If cPaisLoc<>"ARG"
	If cPaisLoc $ "EQU|DOM" .and. FUNNAME()=="FINA095"
		mv_par04:=mv_par04+Space( TamSX3("EF_TALAO")[1]     - Len(mv_par04))   
		mv_par06:=mv_par06+Space( TamSX3("EF_NUM")[1]     - Len(mv_par06))
	Else
		mv_par04:=mv_par04+Space( TamSX3("EF_NUM")[1]     - Len(mv_par04))
	EndIf
	mv_par01:=mv_par01+Space( TamSX3("EF_BANCO")[1]   - Len(mv_par01))
	mv_par02:=mv_par02+Space( TamSX3("EF_AGENCIA")[1] - Len(mv_par02))
	mv_par03:=mv_par03+Space( TamSX3("EF_CONTA")[1]   - Len(mv_par03))
	mv_par05:=mv_par05+Space( TamSX3("EF_NUM")[1]     - Len(mv_par05))
Endif

cNumCheq 	:= mv_par07
lImprimiu	:= .F.
__lTeste 		:= .F. 
lMostraMsg	:= .T.
nQtdeChe	:= 0

If FUNNAME()=="FINA095"
	dbSelectArea("SEF")
	SEF->(dbSetOrder(1))
	SEF->(dbSeek( xFilial("SEF")+mv_par01+mv_par02+mv_par03+mv_par05,.T. ))
	cCond1:="SEF->EF_BANCO==mv_par01.and.SEF->EF_AGENCIA==mv_par02.and.SEF->EF_CONTA==mv_par03.and.SEF->EF_NUM<=mv_par05"	
ElseIf cPaisLoc<>"BRA"
	IF !Empty( mv_par07 ) .and. mv_par06 == 1   //Cheques n„o gerados
		dbSelectArea("SEF")
		SEF->(dbSetOrder(1))
		SEF->(DbGotop())
		SEF->(dbSeek( xFilial("SEF")+mv_par01+mv_par02+mv_par03 ))
		cCond1 := "SEF->EF_BANCO==mv_par01.and.SEF->EF_AGENCIA==mv_par02.and.SEF->EF_CONTA==mv_par03"
	Else
		dbSelectArea("SEF")
		SEF->(dbSeek( xFilial("SEF")+mv_par01+mv_par02+mv_par03+mv_par04,.T. ))
		cCond1:="SEF->EF_BANCO==mv_par01.and.SEF->EF_AGENCIA==mv_par02.and.SEF->EF_CONTA==mv_par03.and.EF_NUM<=mv_par05"
	EndIF
Else
	IF !Empty( mv_par07 ) .and. mv_par06 == 1   //Cheques n„o gerados
		dbSelectArea( "SEF" )
		SEF->(dbSetOrder(2))
		SEF->(dbSeek( xFilial("SEF")+mv_par01+mv_par02+mv_par03 ))
		cCond1 := "SEF->EF_BANCO==mv_par01.and.SEF->EF_AGENCIA==mv_par02.and.SEF->EF_CONTA==mv_par03"//".T."
	Else
		dbSelectArea("SEF")
		SEF->(dbSeek(  xFilial("SEF")+mv_par01+mv_par02+mv_par03+mv_par04,.T. ))
		cCond1:="SEF->EF_BANCO==mv_par01.and.SEF->EF_AGENCIA==mv_par02.and.SEF->EF_CONTA==mv_par03.and.SEF->EF_NUM<=mv_par05"	
	Endif
EndIF

If cPaisLoc <> "BRA
	SetRegua(RecCount())
Endif

If FUNNAME() == "FINA095" 
	If lNoAlOrd
		aCheques := U_FaVerEndos()
	Else 
		aCheques := {}		
	EndIf
EndIf

@ Prow(), PCol() PSAY Chr(27)+Chr(120)+Chr(64)  

While !SEF->(Eof()) .and. SEF->EF_FILIAL == xFilial("SEF") .and. &cCond1
	If cPaisLoc <> "BRA
		IncRegua()
	EndIf
	nPosTot:=1

	IF SEF->EF_IMPRESS $ "SAC"
		SEF->(dbSkip())
		Loop
	Endif

	If  FUNNAME() <> "FINA095"
		If Alltrim(SEF->EF_TIPO) $ MVPAGANT .and. mv_par10==2
			SEF->(dbSkip())
			Loop
		EndIf
	Endif

	If !Empty( EF_BANCO)
		If EF_BANCO != mv_par01
			dbSkip( )
			Loop
		EndIf
	EndIf

	If  FUNNAME() <> "FINA095"
	
		If mv_par06 == 2 .and. ( Empty( SEF->EF_NUM ) .or. SubStr( SEF->EF_NUM,1,1 ) = "*" )
			SEF->(dbSkip())
			Loop
		EndIf

		If SEF->EF_DATA < mv_par08 .or. SEF->EF_DATA > mv_par09
			dbSkip()
			Loop
		Endif

	Else
		If SEF->EF_STATUS $ "05|06"				                              
			MsgAlert(STR0028+ SEF->EF_NUM + STR0029)//"O Cheque número " + SEF->EF_NUM + " não pode ser emitido, pois foi substituido\anulado."	
			lMostraMsg := .F.
			SEF->(dbSkip())
			Loop			
		Else
			If SEF->EF_STATUS == "04"
				dbSelectArea("FRE")
				FRE->(dbSetOrder(3))
				If FRE->(dbSeek(xFilial("FRE")+SEF->EF_BANCO+SEF->EF_AGENCIA+SEF->EF_CONTA+SEF->EF_TALAO)) 
					If FRE->FRE_TIPO <> "1" //cheques comuns são gerados baixados --> a impressão pode ser efetuada após a baixa
						SEF->(dbSkip())
						Loop		
					Else
						lChInm := .T.	
					EndIf
				Else
					SEF->(dbSkip())
					Loop	
				EndIf
			ElseIf SEF->EF_STATUS<>"02"
				SEF->(dbSkip())
				Loop
			Endif
		EndIf

		If ALLTRIM(SEF->EF_TALAO)<>ALLTRIM(mv_par04)
			dbSkip()
			Loop  
	    EndIf    
	
	EndIf
	
	// Se for numeracao automatica e cheque já tenha sido gerado, não será impresso
	If  FUNNAME() <> "FINA095"
		If mv_par06 == 1 .and. (!Empty(SEF->EF_NUM) .and. Substr(SEF->EF_NUM,1,1) != "*" )
			SEF->(dbSkip())
			Loop
		EndIf
	Endif

	// Se houver selecao de banco, filtra o banco escolhido.
	If !Empty(SEF->EF_BANCO)
		If SEF->EF_BANCO # mv_par01 .or. ;
			SEF->EF_AGENCIA # mv_par02 .or. ;
			SEF->EF_CONTA # mv_par03
			SEF->(dbSkip())
			Loop
		Endif
	Endif

	// Recupera o extenso do cheque e monta as linhas
	nSavOrd := SEF->(IndexOrd())
	nRecAnt := Recno()
	dbSkip( )
	nSavRec := RecNo()
	dbGoto(nRecAnt)
	cBenef := SEF->EF_BENEF	

	// Ponto de entrada que permite alterar o beneficiario
	If lFa480Bene
		cBenef := ExecBlock("FA480BENE",.F.,.F.)
	Else
		IF Empty(SEF->EF_BENEF) .and. !(SEF->EF_ORIGEM $ "FINA390AVU#FINA100PAG")
		
			IF !Empty( SEF->EF_BANCO )
				dbSelectArea( "SA6" )
				dbSeek( xFilial() + SEF->EF_BANCO )
				cBenef := SA6->A6_NOME
			Else
				dbSelectArea( "SA2" )
				dbSeek( xFilial() + SEF->EF_FORNECE + SEF->EF_LOJA )
				cBenef := SA2->A2_NOME
			Endif
		Endif
	Endif
                                                                
	// Ponto de entrada para carga do municipio pelo cliente.
	If lFA480MUN
		cMunic := ExecBlock("FA480MUN",.F.,.F.)
	Else
		cMunic := SA6->A6_MUN
	Endif

	If cPaisLoc ==	"BRA"
		If !U_ImpCheq(mv_par01,mv_par02,mv_par03,.F.,xFilial("SE5"),mv_par11,cMunic,aDriver)
			lMostraMsg 	:= .F.
			Exit
		Endif
	Else
		If !U_ImpCheqLoc(mv_par01,mv_par02,mv_par03,.F.,xFilial("SE5"),IIf(cPaisLoc == "ARG",aCheques,Nil),lChInm)
			lMostraMsg := .F.
			Exit
		Endif
	Endif
	lImprimiu 		:= .T.
	lMostraMsg 	:= .F.
	lChInm			:= .F.
	nQtdeChe ++
	dbSelectArea( "SEF" )
	dbSetOrder(nSavOrd)
	dbGoTo( nSavRec )
Enddo

FinalImp(lImprimiu, lMostraMsg, nQtdeChe)

Return


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} ImpCheq
Imprime um determinado cheque 

@author    Wagner Xavier  
@version   1.00
@since     09/07/1992
//------------------------------------------------------------------------------------------
/*/
User Function ImpCheq(cBanco,cAgencia,cConta,lMovBco,cFilAtual,nLayOut,cMunic,aDriver)
Local lRet		:=	.F.
Local nLinLoc
Local nColLoc
Local nColDat
Local nColBco
Local nColCta            

nComp := IIF(nComp == NIL , GetMv("MV_COMP"), nComp)
nLayOut := IIF(nLayOut == NIL, 1, nLayOut)

DEFAULT cMunic := SA6->A6_MUN

If Empty(__cFunName)
	__cFunName := FunName()
EndIf	
If __cFunName == "GPER280"
	__lSetPrint := .T.
	wnRel := aReturn[6]
EndIF

// Verifica se cheque foi configurado.
IF (nLayOut == 1 .and. Empty( SA6->A6_LAYOUT )) .or. (nLayOut == 2 .and. Empty( SA6->A6_LAYIPMF ))
	Help(" ",1,"CHEQNAOCONF")
	Return .f.
Endif

If ! lLayout 
	If nLayOut == 1
		nTamChq :=Val(Substr(SA6->A6_LAYOUT,1,2))
		nSalto  :=Val(Substr(SA6->A6_LAYOUT,3,1))
		nLinVlr :=Val(SubStr(SA6->A6_LAYOUT,4,1))
		nColVlr :=Val(SubStr(SA6->A6_LAYOUT,25, 3))
		nColVlr :=IIF(nColVlr==0,93,nColVlr)
		nLin1Ext:=Val(SubStr(SA6->A6_LAYOUT,5,1))-nLinVlr
		nCol1Ext:=Val(SubStr(SA6->A6_LAYOUT,6,2))
		nLin2Ext:=Val(SubStr(SA6->A6_LAYOUT,8,1))-Val(SubStr(SA6->A6_LAYOUT,5,1))
		nCol2Ext:=Val(SubStr(SA6->A6_LAYOUT,9,2))
		nTamExt :=Val(SubStr(SA6->A6_LAYOUT,23, 2))
		nTamExt :=IIF(nTamExt==0,95,nTamExt)
		nLinFav :=Val(SubStr(SA6->A6_LAYOUT,11,2))-Val(SubStr(SA6->A6_LAYOUT,8,1))
		nColFav :=Val(SubStr(SA6->A6_LAYOUT,13,2))
		nLinDat :=Val(SubStr(SA6->A6_LAYOUT,15,2))-Val(SubStr(SA6->A6_LAYOUT,11,2))
		nColVir :=Val(SubStr(SA6->A6_LAYOUT,17,2))
		nCasas  :=Val(SubStr(SA6->A6_LAYOUT,19,1))
		nCasas  :=IIF(nCasas==0,2,nCasas)
		nColAno :=Val(SubStr(SA6->A6_LAYOUT,20,3))
		lComp   :=(SubStr(SA6->A6_LAYOUT,28, 1)=="S" .or. SubStr(SA6->A6_LAYOUT,28, 1)==" ")
		lMesNum :=(SubStr(SA6->A6_LAYOUT,29, 1)=="S" .and. SubStr(SA6->A6_LAYOUT,29, 1)<>" ")
	Else
		nTamChq :=Val(Substr(SA6->A6_LAYIPMF,1,2))
		nSalto  :=Val(Substr(SA6->A6_LAYIPMF,3,1))
		nLinVlr :=Val(SubStr(SA6->A6_LAYIPMF,4,1))
		nColVlr :=Val(SubStr(SA6->A6_LAYIPMF,25, 3))
		nColVlr :=IIF(nColVlr==0,93,nColVlr)
		nLin1Ext:=Val(SubStr(SA6->A6_LAYIPMF,5,1))-nLinVlr
		nCol1Ext:=Val(SubStr(SA6->A6_LAYIPMF,6,2))
		nLin2Ext:=Val(SubStr(SA6->A6_LAYIPMF,8,1))-Val(SubStr(SA6->A6_LAYIPMF,5,1))
		nCol2Ext:=Val(SubStr(SA6->A6_LAYIPMF,9,2))
		nTamExt :=Val(SubStr(SA6->A6_LAYIPMF,23, 2))
		nTamExt :=IIF(nTamExt==0,95,nTamExt)
		nLinLoc :=Val(SubStr(SA6->A6_LAYIPMF,11,2))//-Val(SubStr(SA6->A6_LAYIPMF,8,1))
		nColLoc :=Val(SubStr(SA6->A6_LAYIPMF,13,2))
		nColDat :=Val(SubStr(SA6->A6_LAYIPMF,15,2))//-Val(SubStr(SA6->A6_LAYIPMF,11,2))
		nColBco :=Val(SubStr(SA6->A6_LAYIPMF,17,2))
		nColCta :=Val(SubStr(SA6->A6_LAYIPMF,26,3))
		lComp   :=(SubStr(SA6->A6_LAYIPMF,28, 1)=="S" .or. SubStr(SA6->A6_LAYIPMF,28, 1)==" ")
		lMesNum :=(SubStr(SA6->A6_LAYIPMF,29, 1)=="S" .and. SubStr(SA6->A6_LAYIPMF,29, 1)<>" ")
	Endif
	lLayOut := .T.
	nLinVlr :=U_FA480Test(nColVlr,aDriver)

	If  nLinVlr == 99
		 Return .f.
	Endif

Endif

lRet := ImpcheqOK(cBanco,cAgencia,cConta,lMovBco,cFilAtual,nLayOut,cMunic,aDriver)


Return lRet

/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} FR480Grav
Faz as gravações necessarias após a impressao.

@author    Bruno Sobieski
@version   1.00
@since     15/06/2000
//------------------------------------------------------------------------------------------
/*/
Static Function FR480Grav(cBanco,cAgencia,cConta,lMovBco,cFilAtual)
LOCAL lGerar     := .F.
LOCAL cCheqAnt	 := ""
LOCAL nRecAnt    := 0
Local nRecSE2    := 0
LOCAL nRegProx	 := 0
LOCAL nRegCheq	 := 0
Local cHistor    := ""
Local nSEFpos    := 0
Local nSE5Pos    := SE5->( RecNo() )
Local lSpbInUse  := SpbInUse()
Local aAreaSEF   := {}
Local nProcesso  := ""   
Local nCheque    := ""     
Local nOrdPTrans := U_OrdProcTransf()
Local lTransf    := .F.
Local lLibCheq   := GetMv("MV_LIBCHEQ") == "S" 
Local lAtuSalBco := .F.
Local aAreaFKs   := {}
Local oModelMov	 := NIL
Local oSubFK5	 := NIL
Local oFKA		 := NIL
Local cProcFKs	 := ""
Local cCamposE5	 := ""
Local lRet 		 := .T.
Local lGravaFKA	 := .T.
Local cChaveCH   := SEF->EF_IDSEF
Local cTitulo	 := ""
Local cTabOri	 := ""
Local cCampo	 := ""

If Empty(__cFunName)
	__cFunName := FunName()
EndIf
cNatGpe := GETMV("MV_CHQGPE")
lF100Auto := If(Type('lF100Auto') == "U", .F.,lF100Auto)

lMovBco := Iif(lMovbco=Nil,.f.,lMovBco)

// Caso cheque n„o tenha sido gerado, ira gravar a movimentação bancária e atualizar cheque emitido
IF (Empty( SEF->EF_NUM ) .or. SubStr(SEF->EF_NUM, 1, 1 ) = "*") .Or. __cFunName == "GPER280"
 
	// Somente atualiza Movimentacao Bancaria caso cheque NÃO SEJA para um "PA" e esteja liberado pelo parametro MV_LIBCHEQ (=S)
	nSEFpos := Recno()
	lMovbco := GetMv("MV_LIBCHEQ")="S"
	lGerar  := .T.
	cCheqAnt := SEF->EF_NUM
	If __cFunName != "GPER280" .and. Empty(cCheqAnt)     // GPE, o cheque j  foi gerado pelo GPER280
	
		cChaveCH 	:= FWUUIDV4()
		Reclock( "SEF" )
		SEF->EF_NUM  	:= cNumCheq
		SEF->EF_BANCO   := mv_par01
		SEF->EF_AGENCIA := mv_par02
		SEF->EF_CONTA   := mv_par03
		SEF->EF_BENEF   := cBenef
		SEF->EF_LIBER	:= IF(lMovbco,'S','')
		If Empty(SEF->EF_IDSEF)
			SEF->EF_IDSEF	  := cChaveCH
		Else
			cChaveCH := SEF->EF_IDSEF	
		Endif
		MsUnlock( )
		lGravaFKA := (SEF->EF_TIPO $ MVPAGANT)
	Endif
	nRegCheq := RecNo()
	If (Empty(cCheqAnt)) .AND. !SEF->EF_TIPO $ MVRECANT+"/"+MV_CRNEG

		// Grava o numero do cheque no SE2 - para contabilizacao
		If __cFunName  != "GPER280"        //GPE
			dbSelectArea("SE2")
			SE2->( DbSetOrder( 1 ) )
			If SE2->(dbSeek(xFilial()+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO+SEF->EF_FORNECE+SEF->EF_LOJA))
				RecLock("SE2")
				SE2->E2_NUMBCO := cNumCheq
				MsUnlock()
				dbSelectArea("SE5")
				dbSetOrder(7)
				SE5->( dbSeek(xFilial()+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO))
				While ( SE5->(!Eof()) .And. xFilial("SE5") == SE5->E5_FILIAL .And.;
					SE2->E2_PREFIXO == SE5->E5_PREFIXO .And.;
					SE2->E2_NUM     == SE5->E5_NUMERO  .And.;
					SE2->E2_PARCELA == SE5->E5_PARCELA .And.;
					SE2->E2_TIPO    == SE5->E5_TIPO )
					If ( SE2->E2_FORNECE+SE2->E2_LOJA == SE5->E5_CLIFOR+SE5->E5_LOJA ) .and.;
						Iif( SE5->E5_TIPO $ MVPAGANT ,.T., SE5->E5_SEQ == SEF->EF_SEQUENC) .and. SE5->E5_TIPODOC != "CP"												
						If Empty(SE5->E5_NUMCHEQ)
						cHistor			 := SE5->E5_HISTOR							
						//Atualiza a SE5 com numero do cheque gerado
						RecLock("SE5",.F.)
							SE5->E5_NUMCHEQ	:= cNumCheq
						MsUnlock()
						//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
						If AllTrim( SE5->E5_TABORI ) == "FK5"
							aAreaFKs := GetArea()
							dbSelectArea( "FK5" )
							FK5->( DbSetOrder( 1 ) )
							If MsSeek( xFilial("FK5") + SE5->E5_IDORIG )
								
								//Verifica se possui ID se não ele cria
								dbSelectArea( "SEF" )
								dbSetOrder( 1 )
								If msSeek( xFilial("SEF")+mv_par01+mv_par02+mv_par03+SE2->E2_NUMCHEQ )
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
								oFKA := oModelMov:GetModel( "FKADETAIL" )	
								oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
								oFKA:SetValue( 'FKA_TABORI', 'SEF' )
								
								If !Empty(cProcFKs)
									oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
				  				Endif	 				
					  				
								//Informacoes do movimento
								oSubFK5 := oModelMov:GetModel("FK5DETAIL")
								oSubFK5:SetValue( "FK5_BANCO",	mv_par01 )
								oSubFK5:SetValue( "FK5_AGENCI", mv_par02 )
								oSubFK5:SetValue( "FK5_CONTA",	mv_par03 )
								oSubFK5:SetValue( "FK5_NUMCH",	cNumCheq )					
					
								If oModelMov:VldData()
					    			oModelMov:CommitData()
								Else
					    			lRet := .F.
					    			cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
					    			cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
					    			cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
						    
					    			Help( ,,"M030_FINR480",,cLog, 1, 0 )	  		    		
								Endif
								F480ClrObj(oModelMov)
							Else //Se não achou o registro na FK5
								lRet := .F.															
							Endif
							RestArea(aAreaFKs)
						Else //Se a origem do registro posicionado não for FK5
							lRet := .F.
						Endif
							
						Endif
					EndIf
					dbSelectArea("SE5")
					SE5->( dbSkip())
				EndDo
				dbSelectArea("SEF")
			Endif
		Endif
	EndIf

	If SEF->EF_TIPO $ MVRECANT+"/"+MV_CRNEG
		lMovBco := .T.

		// Neste caso o titulo veio de um Contas a Receber (SE1)
		dbSelectArea("SE1")
		dbSetOrder(1)
		dbSeek(xFilial()+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO)
		dbSelectArea("SE5")
		dbSetOrder(7)
		dbSeek(xFilial("SE5")+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO)

		While !Eof() .And. xFilial()+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO=;
			SE5->E5_FILIAL+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO
	
			IF	SE5->E5_MOTBX == "CMP"
				dbSkip()
				Loop
			Endif
						
			// Grvava o Nro do Cheque nos registros do SE5 se nao for caixa, considerando E5_SEQ
			If ( SE5->E5_CLIFOR+SE5->E5_LOJA == SE1->E1_CLIENTE+SE1->E1_LOJA ) .and. ;
				Substr(SE5->E5_BANCO,1,2) != "CX" .and. ;
				!(SE5->E5_BANCO $ GetMV("MV_CARTEIR")) .and.;
				SE5->E5_SEQ == SEF->EF_SEQUENC .And. SE5->E5_RECPAG == "P" .and. ;
				Empty (SE5->E5_NUMCHEQ)
				
				//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
				If AllTrim( SE5->E5_TABORI ) == "FK5"
					aAreaFKs := GetArea()
					dbSelectArea( "FK5" )
					FK5->( DbSetOrder( 1 ) )
					If MsSeek( xFilial("FK5") + SE5->E5_IDORIG )
									
						//Verifica se possui ID se não ele cria
						dbSelectArea( "SEF" )
						dbSetOrder( 1 )
						If msSeek(xFilial("SEF")+cBanco+cAgencia+cConta+SE5->E5_NUMCHEQ)
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
						oFKA := oModelMov:GetModel( "FKADETAIL" )	
						oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
						oFKA:SetValue( 'FKA_TABORI', 'SEF' )
						
						If !Empty(cProcFKs)
							oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
		  				Endif		  				
								  				
						//Informacoes do movimento
						oSubFK5 := oModelMov:GetModel("FK5DETAIL")
						oSubFK5:SetValue( "FK5_BANCO",	cBanco )
						oSubFK5:SetValue( "FK5_AGENCI", cAgencia )
						oSubFK5:SetValue( "FK5_CONTA",	cConta )
						oSubFK5:SetValue( "FK5_NUMCH",	cNumCheq )		
										
								
						If oModelMov:VldData()
							oModelMov:CommitData()
						Else
							lRet := .F.
						    cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
						    cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
						    cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
								    
						    Help( ,,"M030_FINR480",,cLog, 1, 0 )	  		    		
						Endif
						F480ClrObj(oModelMov)							
					Else //Se não achou o registro na FK5
						lRet := .F.															
					Endif
					RestArea(aAreaFKs)
				Else //Se a origem do registro posicionado não for FK5
					lRet := .F.
				Endif
					
			EndIf
			dbSkip()
		Enddo
	Endif

	// Caso cheque tenha sido gerado, irá regravar novo numero nos elementos do cheque. 
	If SubStr(cCheqAnt,1,1) = "*"
		dbSelectArea( "SEF" )
		dbSetOrder(1)
		SEF->( dbSeek( xFilial("SEF") + mv_par01 + mv_par02 + mv_par03 + cCheqAnt ))
		While SEF->( !Eof() ).and. mv_par01+mv_par02+mv_par03+cCheqAnt == EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM .And.;
				SEF->EF_FILIAL == xFilial("SEF")
			nRecAnt  := Recno()
			dbSkip( )
			nRegProx := RecNo()
			dbGoto(nRecAnt)
			Reclock( "SEF" )
			SEF->EF_NUM   := cNumCheq
			SEF->EF_BENEF := cBenef
			MsUnlock()

			// Grava o numero do cheque no SE2 - para contabilizacao
			If __cFunName != "GPER280" .and. !SEF->EF_TIPO $ MVRECANT +"/"+MV_CRNEG
				dbSelectArea( "SE2" )
				If SE2->(dbSeek(xFilial()+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO+SEF->EF_FORNECE+SEF->EF_LOJA))
					nRecSE2 := SE2->(Recno())
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
							
							//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
							If AllTrim( SE5->E5_TABORI ) == "FK5"
								aAreaFKs := GetArea()
								dbSelectArea( "FK5" )
								FK5->( DbSetOrder( 1 ) )
								If MsSeek( xFilial("FK5") + SE5->E5_IDORIG )
											
							//Verifica se possui ID se não ele cria
							dbSelectArea( "SEF" )
							dbSetOrder( 1 )
							If msSeek(xFilial("SEF")+mv_par01+mv_par02+mv_par03+SE2->E2_NUMCBO)
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
							oFKA := oModelMov:GetModel( "FKADETAIL" )	
							oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
							oFKA:SetValue( 'FKA_TABORI', 'SEF' )
							
							If !Empty(cProcFKs)
								oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
			  				Endif	 				
								  				
							//Informacoes do movimento
							oSubFK5 := oModelMov:GetModel("FK5DETAIL")
							oSubFK5:SetValue( "FK5_BANCO",	mv_par01 )
							oSubFK5:SetValue( "FK5_AGENCI", mv_par02 )
							oSubFK5:SetValue( "FK5_CONTA",	mv_par03 )
							oSubFK5:SetValue( "FK5_NUMCH",	SE5->E5_NUBCO )					
								
								If oModelMov:VldData()
									oModelMov:CommitData()
								Else
									lRet := .F.
								    cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
								    cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
								    cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
									    
								    Help( ,,"M030_FINR480",,cLog, 1, 0 )	  		    		
								Endif
								F480ClrObj(oModelMov)									
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
					// Trata caso o registro seja originário de uma movimentação 
					// bancária manual e atualiza o saldo bancário do cheque renumerado.
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
								lTransf := .T.
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
											
											If msSeek(xFilial("SEF") + cNumCheq + cNumCheq)
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
											oFKA := oModelMov:GetModel( "FKADETAIL" )	
											oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
											oFKA:SetValue( 'FKA_TABORI', 'SEF' )
											
											If !Empty(cProcFKs)
												oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
							  				Endif			  				
							  				
											//Informacoes do movimento
											oSubFK5 := oModelMov:GetModel("FK5DETAIL")
											oSubFK5:SetValue( "FK5_NUMCHEQ", cNumCheq )
											oSubFK5:SetValue( "FK5_DOC", cNumCheq )
											
											If	SE5->E5_RECPAG == "P"
												oSubFK5:SetValue( "FK5_NUMCH",	cNumCheq )
											Else					
												oSubFK5:SetValue( "FK5_DOC", cNumCheq )
											Endif
											
											If oModelMov:VldData()
							    				oModelMov:CommitData()
											Else
							    				lRet := .F.
							    				cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
							    				cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
							    				cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
								    
							    				Help( ,,"M030_FINR480",,cLog, 1, 0 )	  		    		
											Endif
											F480ClrObj(oModelMov)
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
									
									nProcesso := SE5->E5_ProcTra  
									nCheque   := SE5->E5_NUMCHEQ
									
								Endif
							Else
								If Substr(SE5->E5_NUMCHEQ,1,15) == Substr(cCheqAnt,1,15)
									
									//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
									If AllTrim( SE5->E5_TABORI ) == "FK5"
										aAreaFKs := GetArea()
										dbSelectArea( "FK5" )
										FK5->( DbSetOrder( 1 ) )
										If MsSeek( xFilial("FK5") + SE5->E5_NUMCHEQ )
										
											//Verifica se possui ID se não ele cria
											dbSelectArea( "SEF" )
											dbSetOrder( 1 )
											
											If msSeek(xFilial("SEF") + cNumCheq)
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
											oFKA := oModelMov:GetModel( "FKADETAIL" )	
											oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
											oFKA:SetValue( 'FKA_TABORI', 'SEF' )
											
											If !Empty(cProcFKs)
												oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
							  				Endif		  				
							  				
											//Informacoes do movimento
											oSubFK5 := oModelMov:GetModel("FK5DETAIL")
											oSubFK5:SetValue( "FK5_NUMCHEQ", cNumCheq )
											
											If oModelMov:VldData()
							    				oModelMov:CommitData()
											Else
							    				lRet := .F.
							    				cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
							    				cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
							    				cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
								    
							    				Help( ,,"M030_FINR480",,cLog, 1, 0 )	  		    		
											Endif
											F480ClrObj(oModelMov)
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
		EndDO
	Endif
	dbGoTo( nRegCheq )
Endif

// posiciona corretamente o SE5
SE5->( DbGoTo( nSE5Pos ) )
SE2->( DbGoTo( nRecSE2 ) )

If cPaisLoc != "BRA" .AND. nSEFpos != 0 .AND. Alltrim(SEF->EF_ORIGEM) 	== "FINA085A"
	aArea:=GetArea()
	DbSelectArea("SEF")
	DbGoto(nSEFpos)
	DbSelectArea("SE2")
	DbSetOrder(1)
	If dbSeek(xFilial()+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO+SEF->EF_FORNECE+SEF->EF_LOJA)
		lMovBco := .F.
	EndIf
	RestArea(aArea)
Endif

If Empty(cCheqAnt)
	cCheqAnt := " "
Endif

If lMovBco .or. (SubStr(cCheqAnt, 1, 1 ) = "*" .and. !lTransf)
	dbSelectArea("SE5")
	dbSetOrder(1)
	If __cFunName == "GPER280" .or. ;  //Cheque vindo do GPE
  		!("FINA390TIT" $ SEF->EF_ORIGEM) //Cheque sobre titulo nao deve gerar movimento bancario (jah gerou)
	  		  	
	  	cHisto	:= if(!Empty(SEF->EF_HIST),SEF->EF_HIST,cHistor)	  	  	

		// Numeração Automática
		// Para posicionar o título para buscar a natureza e gravar na SE5/FK5
		If SEF->EF_TIPO $ MVRECANT+"/"+MV_CRNEG
			cTitulo	:= SEF->(EF_PREFIXO+EF_TITULO+EF_PARCELA+EF_TIPO)
			cTabOri	:= "SE1"
			cCampo	:= "E1_NATUREZ"
		Else
			cTitulo	:= SEF->(EF_PREFIXO+EF_TITULO+EF_PARCELA+EF_TIPO+EF_FORNECE+EF_LOJA)
			cTabOri	:= "SE2"
			cCampo	:= "E2_NATUREZ"
		Endif

	  	If !Empty(cCamposE5)
			cCamposE5 += "|"
		Endif
		cCamposE5 += "{"		
		cCamposE5 += " {'E5_DTDIGIT', SEF->EF_DATA}"
		cCamposE5 += ",{'E5_BENEF', SEF->EF_BENEF}"
		cCamposE5 += ",{'E5_DTDISPO', SEF->EF_DATA}"
		
		oModelMov := FWLoadModel("FINM030") //Recarrega o Model de movimentos para pegar o campo do relacionamento (SE5->E5_IDORIG)
		oModelMov:SetOperation( 3 ) //Inclusao
		oModelMov:Activate()
		oModelMov:SetValue( "MASTER", "E5_GRV", .T. ) //Informa se vai gravar SE5 ou não
		oModelMov:SetValue( "MASTER", "NOVOPROC", .T. ) //Informa que a inclusão será feita com um novo número de processo
		
		oSubFK5	:= oModelMov:GetModel("FK5DETAIL")
		cChaveFK5	:= FWUUIDV4()
		
		//Dados do Processo - Define a chave da FK5 no IDORIG
		oFKA := oModelMov:GetModel("FKADETAIL")
		If !oFKA:IsEmpty()
			oFKA:AddLine()
		Endif
		oFKA:SetValue( "FKA_IDORIG", cChaveFK5 )
		oFKA:SetValue( "FKA_TABORI", "FK5" )
				
		//Informacoes do movimento
		oSubFK5 := oModelMov:GetModel( "FK5DETAIL" )
		oSubFK5:SetValue( "FK5_BANCO",		cBanco )
		oSubFK5:SetValue( "FK5_AGENCI",		cAgencia )
		oSubFK5:SetValue( "FK5_CONTA",		cConta )
		oSubFK5:SetValue( "FK5_DATA",		SEF->EF_DATA )
		oSubFK5:SetValue( "FK5_NUMCH",		Iif(SubStr(cCheqAnt, 1, 1 ) <> "*" .And. !Empty(cCheqAnt),cCheqAnt, cNumCheq) )
		oSubFK5:SetValue( "FK5_HISTOR", 	LEFT(cHisto, 40) )
		oSubFK5:SetValue( "FK5_RECPAG", 	"P" )                               
		oSubFK5:SetValue( "FK5_TPDOC",		"CH" )
		oSubFK5:SetValue( "FK5_DTDISP",		SEF->EF_DATA )
		oSubFK5:SetValue( "FK5_VALOR", 		SEF->EF_VALOR )
		oSubFK5:SetValue( "FK5_MOEDA",		STRZERO(POSICIONE("SA6",1,xFilial("SA6")+cBanco+cAgencia+cConta,"A6_MOEDA"),2) )
		oSubFK5:SetValue( "FK5_FILORI", 	SEF->EF_FILORIG )
		oSubFK5:SetValue( "FK5_ORIGEM", 	FUNNAME() )
			
		If lLibCheq .And. SEF->EF_LIBER $ "S "
			cCamposE5 += ",{'E5_PREFIXO',	SEF->EF_PREFIXO}"
			cCamposE5 += ",{'E5_NUMERO', 	SEF->EF_TITULO}"
			cCamposE5 += ",{'E5_PARCELA',	SEF->EF_PARCELA}"
			cCamposE5 += ",{'E5_TIPO',		SEF->EF_TIPO}"
			cCamposE5 += ",{'E5_CLIFOR',	SEF->EF_FORNECE}"
			cCamposE5 += ",{'E5_LOJA',		SEF->EF_LOJA}"	
		Endif	
			
		If !Empty(nProcesso)
		   oSubFK5:SetValue( "FK5_PROTRA",		nProcesso  )
		Endif
		
		If __cFunName == "GPER280"     //GPE
			oSubFK5:SetValue( "FK5_NATURE",		&cNatGpe  )
		Else 
			oSubFK5:SetValue( "FK5_NATURE", 	POSICIONE(cTabOri,1,xFilial(cTabOri)+cTitulo, cCampo) )
		Endif
		
		//Se o cheque vem de uma ordem de pagamento, gravar o numero dela no SE5
		If cPaisLoc	<>	"BRA" .And. SEF->EF_TIPO == "ORP"
			cCamposE5 += ",{'E5_ORDREC',		Alltrim(SEF->EF_TITULO)}"
		Endif
		cCamposE5 += "}"
		oModelMov:SetValue( "MASTER", "E5_CAMPOS", cCamposE5 ) //Informa os campos da SE5 que serão gravados indepentes de FK5 
		
		If lSpbInuse
			oSubFK5:SetValue( "FK5_MODSPB",		"3"  )
		Endif
		
		If __cFunName != "GPER280"     //GPE		
			If !(SE2->(Eof())) 		
				oSubFK5:SetValue( "FK5_NATURE",		SE2->E2_NATUREZ  )				
			Endif
		Endif
		
		If lGravaFKA				
			If !oFKA:IsEmpty()
				oFKA:AddLine()
			Endif

			If Empty(SEF->EF_IDSEF) .Or. Empty(cChaveCH)
				cChaveCH 	:= FWUUIDV4()							
			Else
				cChaveCH := SEF->EF_IDSEF
			Endif

			oFKA:SetValue( "FKA_IDORIG", cChaveCH )
			oFKA:SetValue( "FKA_TABORI", "SEF" )
		Endif
		
		If oModelMov:VldData()
			oModelMov:CommitData()
		Else
			lRet := .F.
			cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
		    cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
		    cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
		    
		    Help( ,,"M030_FINR480",,cLog, 1, 0 )	            
		Endif
		F480ClrObj(oModelMov)				                     		                        
		lAtuSalBco := .T.    
	   //Cheque sobre Titulos	
	ElseIf "FINA390TIT" $ SEF->EF_ORIGEM  
		
		oModelMov := FWLoadModel("FINM030") //Recarrega o Model de movimentos para pegar o campo do relacionamento (SE5->E5_IDORIG)
		oModelMov:SetOperation( 4 ) //Alteração
		oModelMov:Activate()
		oModelMov:SetValue( "MASTER", "E5_GRV", .T. ) //habilita gravação de SE5 		
		
		//Posiciona a FKA com base no IDORIG da SE5 posicionada
		oFKA := oModelMov:GetModel( "FKADETAIL" )
		oFKA:SeekLine( { {"FKA_IDORIG", SE5->E5_IDORIG } } )
		
		//Dados do movimento
		oSubFK5 := oModelMov:GetModel( "FK5DETAIL" )
		oSubFK5:SetValue( "FK5_NUMCH", Iif(SubStr(cCheqAnt, 1, 1 ) <> "*" .And. !Empty(cCheqAnt),cCheqAnt, cNumCheq) )
				
		If oModelMov:VldData()
			oModelMov:CommitData()
		Else
		    lRet := .F.
		    cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
		    cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
		    cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
		    
		    If !lF100Auto      
		    	Help( ,,"M030VALID",,cLog, 1, 0 )
		    Endif	
		Endif
		F480ClrObj(oModelMov)	
				
		lAtuSalBco := .T.
	Endif	

	If	lAtuSalBco := .T.			
		If ExistBlock("FA480SAL")
			ExecBlock("FA480SAL",.F.,.F.)
		Endif
	
		If __cFunName != "GPER280" .Or. (__cFunName == "GPER280" .And. Select("SE8") > 0)   //GPE

			// Atualiza o Saldo Bancario
			AtuSalBco( cBanco,cAgencia,cConta,SEF->EF_DATA,SEF->EF_VALOR,"-")
		Endif 		
	EndIf 
   
Elseif SEF->EF_TIPO $ MVPAGANT
	dbSelectArea("SE5")
	dbSetOrder(3)
	If dbSeek(xFilial()+SEF->EF_BANCO+SEF->EF_AGENCIA+SEF->EF_CONTA+SEF->EF_PREFIXO+SEF->EF_TITULO+SEF->EF_PARCELA+SEF->EF_TIPO)
				
		oModelMov := FWLoadModel("FINM030") //Recarrega o Model de movimentos para pegar o campo do relacionamento (SE5->E5_IDORIG)
		oModelMov:SetOperation( 4 ) //Alteração
		oModelMov:Activate()
		oModelMov:SetValue( "MASTER", "E5_GRV", .T. ) //habilita gravação de SE5 
				
		While SE5->(!Eof()) .And.;
				xFilial("SE5") == SE5->E5_FILIAL .And.;
				SEF->EF_PREFIXO == SE5->E5_PREFIXO .And.;
				SEF->EF_TITULO  == SE5->E5_NUMERO  .And.;
				SEF->EF_PARCELA == SE5->E5_PARCELA .And.;
				SEF->EF_TIPO    == SE5->E5_TIPO

			If SEF->EF_FORNECE+SEF->EF_LOJA == SE5->E5_CLIFOR+SE5->E5_LOJA .And.;
				SE5->E5_SEQ == SEF->EF_SEQUENC
				
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
				
						//Pega o número do processo e define no campo virtual do Model
						cProcFKs := FINProcFKs( SE5->E5_IDORIG, "FK5" )
						If !Empty(cProcFKs)
							oModelMov:SetValue( "MASTER", "NOVOPROC", .F. ) //Informa que a inclusão será feita com um novo número de processo
						Else
							oModelMov:SetValue( "MASTER", "NOVOPROC", .T. ) //Informa que a inclusão será feita com um novo número de processo
						EndIf
								
						//Dados do cheque	
						oFKA := oModelMov:GetModel( "FKADETAIL" )	
						oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
						oFKA:SetValue( 'FKA_TABORI', 'SEF' )		  		
								
						If !Empty(cProcFKs)
							oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
		  				Endif			
						
						If oModelMov:VldData()
							oModelMov:CommitData()
						Else
						    lRet := .F.
						    cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
						    cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
						    cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
						    
						    If !lF100Auto      
						    	Help( ,,"M030VALID",,cLog, 1, 0 )
						    Endif
						Endif
						F480ClrObj(oModelMov)
					Endif    
				Endif
			Endif
			SE5->(DbSkip()	)
		End
	Endif
Endif
If lMovBco .or. lGerar
	
	// Incrementa o Numero do Cheque caso houve movimentacao bancaria ou um novo cheque foi gerado
	While .T.
		cNumCheq:=Soma1(Trim(cNumCheq),Len(Trim(cNumCheq)))
		aAreaSEF := SEF->(GetArea())
		SEF->(dbSetOrder(1))
		If !(SEF->(dbSeek(xFilial("SEF")+cBanco+cAgencia+cConta+cNumCheq)))
			SEF->(RestArea(aAreaSEF))
			Exit
		Endif
	Enddo	
Endif

// PE FA480COM
// Utilizado para gravar dados complementares apos imprimir o cheque
If ExistBlock("FA480COM")
	ExecBlock("FA480COM",.F.,.F.)
Endif

dbSelectarea("SE5")   
// nProcesso só terá conteúdo se o tipo do processamento for Transferencia
If !Empty(nProcesso)	.And. nOrdPTrans > 0
	dbSetOrder(nOrdPTrans)	
	DbSeek(xFilial("SE5")+E5_ProcTra,.T.)
	While ! eof() .And. SE5->E5_ProcTra == nProcesso
		If Left(SE5->E5_DOCUMENT,1) == "*"
		   	
		   	//Posiciona a FK5 para mandar a operação de alteração com base no registro posicionado da SE5
			If AllTrim( SE5->E5_TABORI ) == "FK5"
				aAreaFKs := GetArea()
				dbSelectArea( "FK5" )
				FK5->( DbSetOrder( 1 ) )
				If MsSeek( xFilial("FK5") + SE5->E5_NUMCHEQ )
										
					//Verifica se possui ID se não ele cria
					dbSelectArea( "SEF" )
					dbSetOrder( 1 )
											
					If msSeek(xFilial("SEF") + nCheque + "" )
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
						oModelMov:SetValue( "MASTER", "IDPROC", cProcFKs )
					EndIf
			
					//Dados do cheque	
					oFKA := oModelMov:GetModel( "FKADETAIL" )
					oFKA:SetValue( 'FKA_IDORIG', cChaveCH )	
					oFKA:SetValue( 'FKA_TABORI', 'SEF' )		  		
						
					If !Empty(cProcFKs)
						oFKA:SetValue( 'FKA_IDPROC', cProcFKs )	  				
		  			Endif				  				
							  				
					//Informacoes do movimento
					oSubFK5 := oModelMov:GetModel("FK5DETAIL")
					oSubFK5:SetValue( "FK5_NUMCHEQ", nCheque )
					oSubFK5:SetValue( "FK5_DOC", "" )
																	
						If oModelMov:VldData()
							oModelMov:CommitData()
						Else
							lRet := .F.
							cLog := cValToChar(oModelMov:GetErrorMessage()[4]) + ' - '
							cLog += cValToChar(oModelMov:GetErrorMessage()[5]) + ' - '
							cLog += cValToChar(oModelMov:GetErrorMessage()[6])        	
								    
							Help( ,,"M030_FINR460",,cLog, 1, 0 )	  		    		
						Endif
						F480ClrObj(oModelMov)					
				Else //Se não achou o registro na FK5
					lRet := .F.															
				Endif
				RestArea(aAreaFKs)
			Else //Se a origem do registro posicionado não for FK5
				lRet := .F.
			Endif
		   		   
		Endif	
		DbSkip()
	Enddo
EndIf

Return .t.

/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} FA480TEST
Teste da emissao do cheque  

@author    Wagner Xavier
@version   1.00
@since     14/02/1992
//------------------------------------------------------------------------------------------
/*/
User Function FA480TEST(nColVlr,aDriver)

Local oDlg
Local oFont
Local cTextSay := ""
Local ni := 1
Local nOpca := 0
Local nAux := 0
LOCAL li:=nLinVlr
Local aSays:={}
Local aButtons:={}
Local lAutomato		:= IsBlind()

Default aDriver		:= ReadDriver()

AADD(aSays,STR0019 ) //"Antes de iniciar a impressão, verifique se o formulário contínuo está ajustado."
AADD(aSays, STR0018 ) //"Clique no botão Imprimir Teste para teste de posicionamento. "
AADD(aSays,STR0020 ) //"O teste será impresso na coluna do valor."
AADD(aSays, STR0021 )  //"Formul rio posicionado corretamente ?"
AADD(aSays,  STR0039 )  //"Clique em OK para imprimir o cheque."
AADD(aButtons,{"OK", {|| nOpca:= 1,oDlg:End()}}) // OK	
AADD(aButtons,{STR0040, {|| nOpca:= 0, li:=99,oDlg:End()}}) // Cancelar
AADD(aButtons,{STR0041, {|| nOpca:= 0, li:=CKIMP(nColVlr,aDriver)}}) //"Imprimir Teste"

DEFINE FONT oFont NAME "Arial" SIZE 0, -11
if !lAutomato
	DEFINE MSDIALOG oDlg TITLE STR0042 FROM 0,0 TO  250, 460 OF oMainWnd PIXEL STYLE DS_MODALFRAME

	@ 10,10 TO 90,220 OF oDlg PIXEL

	nAux:=20
	For ni:=1 to Len(aSays)
		cTextSay:= "{||'"+aSays[ni]+"'}"
		oSay := TSay():New( nAux, 20, MontaBlock(cTextSay),oDlg,, oFont, .F., .F., .F., .T.,,, 230, 10, .F., .F., .F., .F., .F. )
		nAux+= 10
	Next ni

	nAux := 90
	For ni:=1 to Len(aButtons)
		TButton():New(100,nAux,aButtons[ni][1],oDlg,aButtons[ni][2] ,40,12,,oFont,,.T.) //  Ok
		nAux += 45
	Next ni

	ACTIVATE MSDIALOG oDlg 
endif
Return li


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} CKIMP
Imprime caracter para teste   

@author    Marcos Patricio
@version   1.00
@since     20/12/1995
//------------------------------------------------------------------------------------------
/*/
Static Function CKIMP(nColVlr,aDriver)
LOCAL cTeste
LOCAL li :=nLinVlr


If cPaisLoc == "BRA"
	ImpCheqTst(nColVlr,aDriver)
Else
	cTeste := "."
	If lComp .and. !Empty(nComp)
		cTeste:= CHR(nComp)+"."
	Endif
	@li,00      PSAY cTeste
	@li,nColVlr PSAY "."
	prnflush()
EndIf	
__lTeste := .T.
Return nColVlr


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} FA480CH
Ponto de entrada para teste do n§ cheque e outros

@author    Wagner Xavier 
@version   1.00
@since     24/06/1998
//------------------------------------------------------------------------------------------
/*/
User Function FA480CH()
LOCAL lRet := .T.
If !Execblock("FA480CH",.f.,.f.)
	lRet := .f.
Endif
Return lRet


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} ImpCheqLoc
Imprime um determinado cheque (Localizacoes) 

@author    Bruno Sobieski
@version   1.00
@since     15/06/2000
//------------------------------------------------------------------------------------------
/*/
User Function ImpCheqLoc(cBanco,cAgencia,cConta,lMovBco,cFilAtual,aCheques,lChInm)
Local cSeqFRF
Local lRet			:=	.F.
LOCAL cValor
LOCAL lFirst    	:=.T.
LOCAL aMes := { STR0006, STR0007, STR0008,;   //"Janeiro"###"Fevereiro"###"Marco"
				STR0009, STR0010, STR0011,;   //"Abril"###"Maio"###"Junho"
				STR0012, STR0013, STR0014,;   //"Julho"###"Agosto"###"Setembro"
				STR0015, STR0016, STR0017 }   //"Outubro"###"Novembro"###"Dezembro"
Local cExtenso := ""
Local nI
Local cExt1
Local cExt2
Local nPosExt1	:=	nPosExt2	:=	0
Local nLoop
Local nRepete
Local aLaySort	:=	{}
Local nDesplaza	:=	0
Local aArea:={}   
Local nPosIni   := 0
Local nPosFim   := 0
Local cSubst    := ""   
Local nPosChq := 0   
Local cEndosso	:= "" 
Local nTamExtenso := 2 

DEFAULT aCheques 	:= Nil
DEFAULT lChInm	:= .F.

// Verifica se cheque foi configurado.
IF Empty( SA6->A6_LAYOUT )
	Help(" ",1,"CHEQNAOCONF")
	Return .f.
Endif

If cPaisLoc=="PAR"  // Acertado pois no Paraguai nao pode imprimir a descricao 
	cExtenso:= Extenso( SEF->EF_VALOR,.F.,nMoeda,".")			
ElseIf cPaisLoc $ "EQU" 
	cExtenso:= Extenso( SEF->EF_VALOR,.F.,nMoeda,,,,.T.)
ElseIf cPaisLoc $ "DOM"                                  
	nCentavos := 0
	nCentavos := (SEF->EF_VALOR) - INT(SEF->EF_VALOR)
	If nCentavos > 0 
		cExtenso:= Extenso( SEF->EF_VALOR,.F.,nMoeda,,,,.T.,.T.,"2")		
	Else
		cExtenso:= Extenso( SEF->EF_VALOR,.F.,nMoeda)
	EndIf
	If Subs(CVALTOCHAR(SEF->EF_VALOR),2,6) == '000000' .AND. nMoeda == 1 // Se a moeda for Pesos e for milhões exatos,coloca o 'de' antes
		cExtenso:= StrTran(cExtenso,"PESOS","DE PESOS")    
	EndIf
Else
	cExtenso:= Extenso( SEF->EF_VALOR,.F.,nMoeda)
Endif 
//Moeda 01 igual a Dolar e Não Sucre, ajustar Extenso
If cPaisLoc $ "EQU" .and. AllTrim(MV_SIMB1) $ "US$"  
	nCentavos := 0    
    nCentavos := SEF->EF_VALOR - INT(SEF->EF_VALOR)
    If nCentavos <> 0        
    	nCentavos := nCentavos * 100
    EndIf	
    If nCentavos <> 0                 
    	cCentavos := ", "+Str(nCentavos,2)+"/100 DOLARES."
    	cExtenso := StrTran(cExtenso," SUCRES",cCentavos)   
		nPosIni := AT(".", cExtenso)
		nPosFim := Len(cExtenso)
		If nPosIni > 0
			cSubst   := Subs(cExtenso,nPosIni,nPosFim)
			cExtenso := StrTran(cExtenso,cSubst,".")
		EndIf	 
    Else
		cExtenso:= StrTran(cExtenso,"SUCRES","DOLARES.")    
    EndIf
EndIf    

If ! lLayout
	aLayout	:=	{}
	AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,4,1))	,IIF(Val(SubStr(SA6->A6_LAYOUT,25, 3))==0,93,Val(SubStr(SA6->A6_LAYOUT,25, 3))),"VALOR"})
	AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,5,1))	,Val(SubStr(SA6->A6_LAYOUT,6,2))	,"EXTENSO1"	})
	AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,8,1))	,Val(SubStr(SA6->A6_LAYOUT,9,2))	,"EXTENSO2"	})
	AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,11,2))	,Val(SubStr(SA6->A6_LAYOUT,13,2))	,"FAVORECI"	})
	If cPaisLoc $ "EQU"
		AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,15,2))	,Val(SubStr(SA6->A6_LAYOUT,17,2))  ,"MUNICIP"})
		AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,15,2))	,Val(SubStr(SA6->A6_LAYOUT,20,3))-3,"DIA"})
		AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,15,2))	,Val(SubStr(SA6->A6_LAYOUT,20,3))-6,"MES"})
	Else
		AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,15,2))	,Val(SubStr(SA6->A6_LAYOUT,17,2))-(1+Len(AllTrim(SA6->A6_MUN))) ,"MUNICIP"	})
		AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,15,2))	,Val(SubStr(SA6->A6_LAYOUT,17,2))+2,"DIA"})
		AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,15,2))	,Val(SubStr(SA6->A6_LAYOUT,17,2))+8,"MES"}) //2 do DIA + 6 de espaco para  o "  DE  " do cheque
	EndIf
	AAdd(aLayout,{Val(SubStr(SA6->A6_LAYOUT,15,2))	,Val(SubStr(SA6->A6_LAYOUT,20,3))	,"ANO"	})
	
	
	//Ordernar por linha + coluna
	aLaySort	:=	aSort(aLayout,,,{|x,y| IIf(x[1] == y[1],x[2] < y[2],x[1] < y[1] ) })
	aLayout	:=	AClone(aLaySort)
	
	//Arrumo todas as linhas para ficarem relativas a primeira, comeco da ultima.
	For nI	:=	Len(aLayout)	To	2	STEP -1
		aLayOut[nI][1]	:=	aLayOut[nI][1] - aLayOut[nI-1][1]
	Next		
	
	nTamChq :=Val(Substr(SA6->A6_LAYOUT,1,2))
	nSalto  :=Val(Substr(SA6->A6_LAYOUT,3,1))
	nTamExt :=Val(SubStr(SA6->A6_LAYOUT,23, 2))
	nTamExt :=IIF(nTamExt==0,95,nTamExt)
	nCasas  :=Val(SubStr(SA6->A6_LAYOUT,19,1))
	nCasas  :=IIF(nCasas==0,2,nCasas)
	lComp   :=(SubStr(SA6->A6_LAYOUT,28, 1)=="S" .or. SubStr(SA6->A6_LAYOUT,28, 1)==" ")
	lMesNum :=(SubStr(SA6->A6_LAYOUT,29, 1)=="S" .and. SubStr(SA6->A6_LAYOUT,29, 1)<>" ")
	
	//Forço o valor da nLinVlr porque dentro da funcao fa480test() referencia ela.
	nLinVlr  :=	aLayOut[1][1]
	nPrimCol	:=	aLayOut[1][2]
	
	aLayOut[1][1]	:=	U_FA480Test(nPrimCol)
	
	lLayOut := .T.
	
	If	aLayOut[1][1] == 99
		Return .f.
	Endif
	
Endif

//Vou Obter as Posicoes no Array de cada um dos campos que precisso
nPosExt1	:=	Ascan(aLayout,{|X| X[3] == "EXTENSO1" })
nPosExt2	:=	Ascan(aLayout,{|X| X[3] == "EXTENSO2" })

// Verifica se o extenso ultrapassa o tamanho de colunas
cExt1 := SubStr (cExtenso,1,nTamExt ) // 1.a linha do extenso
nLoop := Len(cExt1)
nTamExtenso:= IIf(cPaisLoc=="PAR",2,aLayout[nPosExt1][2])

While .T.
	
	If Len(cExtenso) == Len(cExt1) .And. Len(cExt1) + nTamExtenso <= nTamExt
		Exit
	EndIf
	
	If SubStr(cExtenso,Len(cExt1),1) == " " .And. Len(cExt1)+ nTamExtenso <= nTamExt
		Exit
	EndIf
	
	cExt1 := SubStr( cExtenso,1,nLoop )
	nLoop -- 
	If nLoop <= 0
		MsgAlert(STR0024) // "Erro na configuracao do cheque"+CHR(13)+"Verifique o tamanho das linhas de extenso"
		Return .f.
	Endif
Enddo

cExt2 := SubStr(cExtenso,Len(cExt1)+1,nTamExt) // 2.a linha do extenso
IF Empty(cExt2)
	
	// Se nao tem 2a. linha de extenso, completa 1a. com * (asterisco)
	cExt1 += Replicate( "*",nTamExt - Len(cExt1) - nTamExtenso )
Else

	// Se tem, completa a primeira linha com espaços entre as palavras
	cExt1 := StrTran(cExt1," ","  ",,nTamExt - Len(cExt1) - nTamExtenso + 1)
Endif

If !(cPaisLoc $ "DOM|EQU")
	cExt2 += Replicate( "*",nTamExt - Len(cExt2) - nTamExtenso )
EndIf

// Imprime o cheque
If lFirst
	@aLayout[1][1], 0 PSAY Chr(27)+Chr(64)
	If nSalto = 8
		@aLayout[1][1], 0 PSAY Chr(27)+Chr(48)
	Endif
	If lComp
		@aLayout[1][1],0 PSAY Chr(15)
	Endif
Endif

if cPaisLoc $ "PAR|BOL"
	cSimb:= " "
else 
	cSimb  :=GetMv("MV_SIMB"+alltrim(Str(nMoeda,2)))
EndIf 
cValor := cSimb + Alltrim(Transform(SEF->EF_VALOR,PesqPict("SEF","EF_VALOR",17)))

// Ajuste do posicionamento da impressora: 
// - compactada: 1 posição 
// - sem compactar: 2 posições
// - segunda impressão em diante: sem ajuste. 
// Lembrete: ajuste apenas no primeiro cheque.
__LogPages()

If lFirst
	If lComp
		nDesplaza	:=	1
	Else
		nDesplaza	:=	2
	Endif
	lFirst := .F.
Else
	nDesplaza	:=	0
Endif

For	nI	:=	1	To	Len(aLayout)
	If nI	==	1	//So o primeiro tem uma posicao absoluta, os outros sao relativos ao primeiro
		nRow	:=	0
	Else
		nRow	:=	PROW()
	Endif	
	Do Case	
	Case aLayout[nI][3] == "VALOR"
		nRepete := nDesplaza + aLayout[nI][2] +Len(cValor)+17-Len(cValor) - nTamExt
		If !(cPaisLoc $ "DOM|EQU")
			If nRepete > 0
				cValor += Replicate("*",17-Len(cValor)-nRepete)
			Else
				cValor += Replicate("*",17-Len(cValor))
			EndIf
		EndIf
		@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY cValor
		nDesplaza	:=	0
	Case aLayout[nI][3] == "EXTENSO1"
		@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY cExt1
		nDesplaza	:=	0
	Case aLayout[nI][3] == "EXTENSO2"
		@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY cExt2
		nDesplaza	:=	0
	Case aLayout[nI][3] == "FAVORECI"                                                                
		If cPaisLoc == "ARG" .And. Len(aCheques) > 0 
			nPosChq := ASCANX(aCheques,{|x| (x[2]+x[3]+x[4]+x[5]) == SEF->(EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM) })
            cEndosso := IIf(nPosChq > 0 .And. aCheques[nPosChq][1],STR0031,"")   // "NÃO À ORDEM"
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY Alltrim(IIF(cBenef==NIL,SEF->EF_BENEF,cBenef) + cEndosso)
		Else                                                                                             
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY IIF(cBenef==NIL,SEF->EF_BENEF,cBenef)
		EndIf
		nDesplaza	:=	0
	Case aLayout[nI][3] == "MUNICIP"
		@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY AllTrim(SA6->A6_MUN)
		nDesplaza	:=	0
	Case aLayout[nI][3] == "DIA"
		If cPaisLoc $ "DOM|EQU"
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY StrZero(Day(SEF->EF_DATA),2) + "/"
		Else
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY Day(SEF->EF_DATA) PICTURE "99"
		EndIf
		nDesplaza	:=	0
	Case aLayout[nI][3] == "MES"
		//Imprime o mes em valor numerico ou por extenso
		If lMesNum
			If cPaisLoc $ "DOM|EQU"
				@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY StrZero(Month(SEF->EF_DATA),2) + "/"
			Else
				@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY StrZero(Month(SEF->EF_DATA),2)
			EndIf
		Else
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2] PSAY aMes[Month(SEF->EF_DATA)]
		Endif	
		nDesplaza	:=	0
	Case aLayout[nI][3] == "ANO"
		IF nCasas == 1
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2]	PSAY SubStr(Str(Year(SEF->EF_DATA),4),4,1)
		Elseif nCasas == 2
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2]	PSAY SubStr(Str(Year(SEF->EF_DATA),4),3,2)
		Elseif nCasas == 3
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2]	PSAY SubStr(Str(Year(SEF->EF_DATA),4),2,3)
		Else
			@nRow + aLayout[nI][1], nDesplaza + aLayout[nI][2]	PSAY Str(Year(SEF->EF_DATA),4)
		Endif
		nDesplaza	:=	0
	Endcase	
Next

dbSelectArea("SEF")

aLayout[1][1]	+=	nTamChq

Reclock("SEF")
SEF->EF_IMPRESS := "S"
If FUNNAME()=="FINA095"
	//Cheques com debito inmediato ja são gerados baixados e a impressao é efetuada após da baixa
	If !lChInm
		SEF->EF_STATUS := "03"
	EndIf
	cSeqFRF := GetSx8Num("FRF","FRF_SEQ")
   	RecLock("FRF",.T.)
   	FRF->FRF_FILIAL		:= xFilial("FRF")
   	FRF->FRF_BANCO		:= SEF->EF_BANCO
   	FRF->FRF_AGENCIA	:= SEF->EF_AGENCIA
   	FRF->FRF_CONTA		:= SEF->EF_CONTA
   	FRF->FRF_NUM		:= SEF->EF_NUM 
   	FRF->FRF_PREFIX		:= SEF->EF_PREFIXO
   	FRF->FRF_CART		:= "P"
   	FRF->FRF_DATPAG		:= dDataBase
   	FRF->FRF_MOTIVO		:= "98"
   	FRF->FRF_DESCRI		:= STR0027
   	FRF->FRF_SEQ		:= cSeqFRF
   	FRF->(MsUnLock())
   	ConfirmSX8()
EndIf
MsUnlock( )

If FUNNAME()=="FINA095"
	lRet := .T.
Else
	lRet :=	Fr480Grav(cBanco,cAgencia,cConta,lMovBco,cFilAtual)

	If mv_par06 == 1 .and. lRet
		aArea:=GetArea()
		dbSelectArea("SEF")
		SEF->(DbSetOrder(1))
		If SEF->(dbSeek( xFilial("SEF")+mv_par01+mv_par02+mv_par03+cNumcheq))
			MsgAlert(STR0025+cNumcheq)
			lRet:=.F.	
		EndIf
		RestArea(aArea)
	Endif
EndIf
Return lRet


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} Fr480CC
Verificacao do Banco/Agencia/Conta destino do cheque CPMF das perguntas 12, 13 e 14 estão 
no SX1

@author    Mauricio Pequim Jr
@version   1.00
@since     24/06/2004
//------------------------------------------------------------------------------------------
/*/
User Function Fr480CC(nOpcao)

Local lRet := .T.
Local aArea := GetArea()

If cPaisLoc == "BRA" .and. mv_par11 == 2 .and. ((nOpcao == 1 .and. !Empty(mv_par12) .and. !CarregaSa6(mv_par12)) .or. ;
	(nOpcao == 2 .and. !Empty(mv_par12+mv_par13) .and. !CarregaSa6(mv_par12,mv_par13)) .or. ;
	(nOpcao == 3 .and. !Empty(mv_par12+mv_par13+mv_par14) .and. !CarregaSa6(mv_par12,mv_par13,mv_par14)))	
	lRet := .F.
Endif

RestArea(aArea)

Return lRet

/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} OrdProcTransf
Retorna qual o indice ref ao e5_proctra 

@author    Marcelo Celi Marques
@version   1.00
@since     08/09/2008
//------------------------------------------------------------------------------------------
/*/
User Function OrdProcTransf()
	Local nOrdPTransf := 1
	Local aArea := GetArea()
	dbSelectarea("SE5")
	If cPaisLoc $ "ANG|ARG|AUS|BOL|BRA|CHI|COL|COS|DOM|EQU|EUA|HAI|MEX|PAD|PAN|PAR|PER|POR|PTG|SAL|URU|VEN"		
	dbSelectArea("SIX")
	dbSeek("SE5",.T.)
	While SIX->INDICE == "SE5" .And. !Eof()
		If Alltrim(SIX->CHAVE) == "E5_FILIAL+E5_PROCTRA"			    				
			exit
		Endif
		nOrdPTransf++
	    dbSkip()	
	EndDo
		If Alltrim(SIX->CHAVE) <> "E5_FILIAL+E5_PROCTRA"			    				
			nOrdPTransf := 0
		Endif					
	Endif	
	RestArea(aArea)
Return nOrdPTransf
                                            

/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} FaVerEndos
Verifica quais cheques devem ser endossados 

@author    Rodrigo Gimenes
@version   1.00
@since     26/12/2011
//------------------------------------------------------------------------------------------
/*/
User Function FaVerEndos()  

Local aArea 	:= GetArea()
Local aAreaSEF 	:= {}
Local aCheques	:= {}  
Local oDlgChq	:= Nil
Local oCheques 	:= Nil 
Local oOK := LoadBitmap(GetResources(),'Checked')
Local oNO := LoadBitmap(GetResources(),'UnChecked')  
Local oBtn := Nil

dbSelectArea("SEF")
aAreaSEF 	:= SEF->(GetArea()) 

SEF->(dbSetOrder(1))
SEF->(DbSeek( xFilial("SEF") + mv_par01 + mv_par02 + mv_par03+ mv_par05))

While SEF->(!Eof()) .And. mv_par01+mv_par02+mv_par03 == SEF->(EF_BANCO+EF_AGENCIA+EF_CONTA) .And. ;
		SEF->EF_FILIAL == xFilial("SEF") .And. AllTrim(SEF->EF_NUM) >= AllTrim(mv_par05) .And. AllTrim(SEF->EF_NUM) <= AllTrim(mv_par06) 
		IF !(SEF->EF_IMPRESS $ "SAC") .And. !(SEF->EF_STATUS $ "05|06") .And. Iif(!Empty(ALLTRIM(mv_par04)),ALLTRIM(SEF->EF_TALAO) == ALLTRIM(mv_par04),.T.)				                              
			Aadd(aCheques,{.F.,SEF->EF_BANCO,SEF->EF_AGENCIA,SEF->EF_CONTA,SEF->EF_NUM})
		EndIf		
	SEF->(DbSkip())                                                                                           
EndDo                                 

If Len(aCheques) > 0 

	DEFINE MSDIALOG oDlgChq FROM 0,0 TO 300,500 PIXEL TITLE STR0032 //"Selecione o(s) cheque(s) para impressão  'NÃO À ORDEM'"    
	oCheques := TCBrowse():New( 01 , 01, 250, 130,,{'',STR0033,STR0034,STR0035,STR0004},{10,30,30,30,30},oDlgChq,,,,,{||},,,,,,,.F.,,.T.,,.F.,,,) // "Banco","Agência","Conta","Cheque"
	// Seta o vetor a ser utilizado
	oCheques:SetArray(aCheques)
	// Monta a linha a ser exibina no Browse
	oCheques:bLine := {||{ If(aCheques[oCheques:nAt,01],oOK,oNO),aCheques[oCheques:nAt,02],aCheques[oCheques:nAt,03],aCheques[oCheques:nAt,04],aCheques[oCheques:nAt,05]} }
	// Evento de DuploClick (troca o valor do primeiro elemento do Vetor)
	oCheques:bLDblClick := {|| aCheques[oCheques:nAt][1] :=!aCheques[oCheques:nAt][1],oCheques:DrawSelect() }
	
	oBtn := TButton():New( 135, 220,'Ok' , oDlgChq,{||oDlgChq:End()},030, 013,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE MSDIALOG oDlgChq CENTERED
	
EndIf

RestArea(aAreaSef)
RestArea(aArea)
         
Return(aCheques)

/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} F480ClrObj
Função para limpar o objeto oModelMov

@author    Simone Mie Sato Kakinoana
@version   1.00
@since     22/05/2019
/*/
//------------------------------------------------------------------------------------------
Static Function F480ClrObj(oModelMov)

oModelMov:DeActivate()
oModelMov:Destroy()
oModelMov:= NIL

Return  


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} ImpCheqOK
Função para imprimir o cheque oficial

@author    Karen Honda
@version   1.00
@since     07/08/2020
@param cBanco, character, Codigo do banco 
@param cAgencia, character, Codigo do banco
@param cConta, character, Codigo do banco
@param lMovBco, lógico, movimenta banco
@param cFilAtual, character, filial atual
@param nLayOut, numerico, 1-cheque normal 2 - CPMF
@param cMunic, character, nome do municipio

@return lRet, lógico, .T. se gerou o cheque

/*/
//------------------------------------------------------------------------------------------

Static Function ImpCheqOK(cBanco as Character,cAgencia as Character,cConta as Character,lMovBco as Logical ,cFilAtual as Character,nLayOut as Numeric,cMunic as Character,aDriver as Array)
LOCAL cValor as Character
LOCAL aMes as Array
Local cExtenso as Character
Local cExt1 as Character
Local cExt2 as Character
Local nTamanho as Numeric
Local nLoop as Numeric
Local nRepete as Numeric
LOCAL lFa480Dat as Logical
LOCAL cDesc1 as Character
LOCAL cDesc2 as Character
LOCAL cDesc3 as Character
LOCAL cString as Character
Local cFormato as Character
Local lRet as Logical

cValor := ""

aMes := { STR0006,STR0007,STR0008,;   //"Janeiro"###"Fevereiro"###"Marco"
		STR0009,STR0010,STR0011,;   //"Abril"###"Maio"###"Junho"
		STR0012,STR0013,STR0014,;   //"Julho"###"Agosto"###"Setembro"
		STR0015,STR0016,STR0017 }   //"Outubro"###"Novembro"###"Dezembro"
cExtenso := Extenso( SEF->EF_VALOR,.F.,1 )
cExt1 := ""
cExt2 := ""
nTamanho := 0
nLoop := 0
nRepete := 0
lFa480Dat := ExistBlock("FA480DAT")
cDesc1 := STR0001  //"Este programa ir  imprimir os Cheques do Banco, atrav‚s de"
cDesc2 := STR0002  //"formul rio pr‚-impresso."
cDesc3 :=""
cString :="SEF"
cFormato := SuperGetMv("MV_RESETIM", .F., "3")
lRet := .F.

If !__lSetPrint .and. __lFirst
	If __cFunName != "GPER280"
		wnrel := "FINR480"            //Nome Default do relatorio em Disco
	EndIf	
	wnrel := SetPrint(cString,wnrel,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,"M")

	If nLastKey == 27
		Return lRet
	Endif

	If cFormato <> AllTrim(STR(aReturn[4])) 
		If MsgYesNo(STR0038) 
			lReset := .T.	
			cFormato :=  AllTrim(STR(aReturn[4]))
			DbSelectArea("SX6")
			PutMv("MV_RESETIM", cFormato)				
		Else
			Return lRet
		EndIf
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return lRet
	Endif

	If !( "DEFAULT" $ Upper( __DRIVER ) )
		SetPrc(000,000)
	Endif

	If lReset 
		If GetMv("MV_COMP") == 15
			@ pRow(),pCol() PSAY &(If(aReturn[4]=1,aDriver[3],aDriver[4]))
		Else
			@ pRow(),pCol() PSAY &(aDriver[4])
		EndIf
	EndIF
EndIf

// Verifica se o extenso ultrapassa o tamanho de colunas
cExt1 := SubStr (cExtenso,1,nTamExt ) // 1.a linha do extenso
nLoop := Len(cExt1)

While .T.

	If Len(cExtenso) == Len(cExt1) .and. Len(cExt1)+nCol1Ext <= nTamExt
		Exit
	EndIf

	If SubStr(cExtenso,Len(cExt1),1) == " " .and. Len(cExt1)+nCol1Ext <= nTamExt
		Exit
	EndIf

	cExt1 := SubStr( cExtenso,1,nLoop )
	nLoop --
	If nLoop <= 0
		MsgAlert(STR0024) // "Erro na configuracao do cheque"+CHR(13)+"Verifique o tamanho das linhas de extenso"
		Return lRet
	Endif
Enddo

If cPaisLoc = 'BRA' .And. __lMVPAR15
	If MV_PAR15 > 0 .And. nLinVlr >= MV_PAR15
		PrnFlush()
		nLinVlr := 2
	EndIf
EndIf

cExt2 := SubStr(cExtenso,Len(cExt1)+1,nTamExt) // 2.a linha do extenso
IF Empty(cExt2)

	// Se nao tem 2a. linha de extenso, completa 1a. com * (asterisco)
	cExt1 += Replicate( "*",nTamExt - Len(cExt1) - nCol1Ext )
Else
	// Se tem, completa a primeira linha com espaços entre as palavras
	cExt1 := StrTran(cExt1," ","  ",,nTamExt - Len(cExt1) - nCol1Ext + 1)
Endif
cExt2 += Replicate( "*",nTamExt - Len(cExt2) - nCol2Ext )

// Imprime o cheque
If __lFirst 
	If __lTeste  // SE FOI IMPRESSO TESTE
      	SetPrc(0,0)
		@ 0,0 PSAY Chr(27)+Chr(64)
		If nSalto = 8
         SetPrc(0,0)
			@0,0 PSAY Chr(27)+Chr(120)+Chr(48)
		Endif
		If lComp .and. !Empty(nComp)
         SetPrc(0,0)
			@ 0,0 PSAY CHR(nComp)
		Endif
		nLinVlr := PROW()
	Else	
		If lComp
			@nLinVlr, 0 PSAY Chr(27)+Chr(64)
			@nLinVlr, Pcol() PSAY Chr(27)+Chr(120)+Chr(48)
			If !Empty(nComp)
				@nLinVlr,0 PSAY CHR(nComp)
			Else
				@nLinVlr,0 PSAY &(If(aReturn[4]=1,aDriver[3],aDriver[4]))
			EndIf
		Else
			@nLinVlr,0 PSAY &(aDriver[4])
		EndIf
		@nLinVlr, Pcol() PSAY Chr(27)+Chr(48)
	Endif
Endif

cSimb  :=GETMV("MV_SIMB1")
cValor :=Alltrim(Transform(SEF->EF_VALOR,PesqPict("SEF","EF_VALOR",17)))

// Ajuste do posicionamento da impressora: 
// - compactada: 1 posição 
// - sem compactar: 2 posições
// - segunda impressão em diante: sem ajuste. 
// Lembrete: ajuste apenas no primeiro cheque.
__LogPages()
If __lFirst
	If lComp
      SetPrc(nLinVlr,0)
		@nLinVlr,nColVlr+1 PSAY cSimb
	Else
      SetPrc(nLinVlr,0)
		@nLinVlr,nColVlr+2 PSAY cSimb
	Endif
	__lFirst := .F.
Else
	@nLinVlr,nColVlr PSAY cSimb
Endif

nRepete := pCol()+Len(cValor)+17-Len(cValor) - nTamExt

If nRepete > 0
	cValor += Replicate("*",17-Len(cValor)-nRepete)
Else
	cValor += Replicate("*",17-Len(cValor))
EndIf

@nLinVlr,PCOL()             PSAY cValor
@Prow()+nLin1Ext,nCol1Ext   PSAY cExt1
@Prow()+nLin2Ext,nCol2Ext   PSAY cExt2

If nLayOut == 1 //Cheque Normal
	@Prow()+nLinFav ,nColFav    PSAY IIF(cBenef==NIL,SEF->EF_BENEF,cBenef)
	nTamanho    :=1+Len(Trim(cMunic))
	@Prow()+nLinDat,nColVir-nTamanho  PSAY IIF(!Empty(cMunic),Trim(cMunic)," ")
	@Prow(),nColVir+1           PSAY Day(SEF->EF_DATA)  PicTure "99"
	//Imprime o mes em valor numerico ou por extenso
	If lMesNum
		@Prow(),Pcol()+6 PSAY StrZero(Month(SEF->EF_DATA),2)
	Else
		@Prow(),Pcol()+6 PSAY aMes[Month(SEF->EF_DATA)]
	Endif

	IF nCasas == 1
		@Prow(),nColAno         PSAY SubStr(Str(Year(SEF->EF_DATA),4),4,1)
	Elseif nCasas == 2
		@Prow(),nColAno         PSAY SubStr(Str(Year(SEF->EF_DATA),4),3,2)
	Elseif nCasas == 3
		@Prow(),nColAno         PSAY SubStr(Str(Year(SEF->EF_DATA),4),2,3)
	Else
		@Prow(),nColAno         PSAY Str(Year(SEF->EF_DATA),4)
	Endif
Else
	@ nLinLoc,nColLoc  PSAY IIF(!Empty(cMunic),AllTrim(cMunic)," ")
	@ nLinLoc,nColDat	 PSAY SUBSTR(DTOC(SEF->EF_DATA),1,6)+Str(Year(SEF->EF_DATA),4)
	@ nLinLoc,nColBco	 PSAY Alltrim(mv_par12)+"-"+AllTrim(mv_par13)
	@ nLinLoc,nColCta	 PSAY AllTrim(mv_par14)
Endif	

If lFA480DAT
	ExecBlock("FA480DAT",.F.,.F.)
Endif

@Prow()+1,0 PSAY " "   // Para descarregar buffer Windows 95

dbSelectArea("SEF")
nLinVlr+=nTamChq

@nLinVLr,0 PSAY " "		// Para avancar at‚ o fim do cheque
SetPrc(nLinVlr,0)
Reclock("SEF")
SEF->EF_IMPRESS := "S"
MsUnlock( )
lRet	:=	Fr480Grav(cBanco,cAgencia,cConta,lMovBco,cFilAtual)

Return lRet

/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} FinalImp
Função para finalizar a impressão do cheque oficial, exibindo a tela

@author    Karen Honda
@version   1.00
@since     07/08/2020
@param lImprimiu, logico, .T. houve a geração do cheque
@param lMostraMsg, logico, .T. para exibir mensagem caso tenha erro 
@param nQtdeChe, numeric, quantidade de cheques impressos
//------------------------------------------------------------------------------------------
/*/
Static Function FinalImp(lImprimiu as Logical, lMostraMsg as Logical, nQtdeChe as Numeric)

If lImprimiu 
	@ Prow(), PCol() PSAY Chr(27)+Chr(64)  // (48 = 1/8)  (64 = 1/6)
	@ Prow(), PCol() PSAY Chr(18)+" "
Endif
	
Set Device To Screen
dbSelectArea("SEF")
SEF->(dbSetOrder(1))
dbSelectArea("SA6")
SA6->(dbSetOrder(1))
Set Filter To

Set Device To Screen
SetPgEject(.F.)     

If  nQtdeChe > 0 
	If aReturn[5] = 1
		Set Printer To
		Commit
		Ourspool(wnrel)
	Endif
ElseIf  nQtdeChe == 0 .AND. lMostraMsg
	MsgAlert(STR0030) //"Nenhum cheque foi encontado para emissão."
EndIf

MS_FLUSH()

Return


/*/
//------------------------------------------------------------------------------------------
{Protheus.doc} ImpCheqTst
Função para imprimir o cheque teste para posicionamento

@author    Karen Honda
@version   1.00
@since     07/08/2020
@param nColVlr, numeric, coluna onde será impresso o valor 
//------------------------------------------------------------------------------------------
/*/
Static Function ImpCheqTst(nColVlr as Numeric,aDriver as Array)
LOCAL cTeste as Character
LOCAL li as Numeric

cTeste := ""
li := nLinVlr

If !__lSetPrint
	
	If __cFunName != "GPER280"
		wnrel := "FINR480T"            //Nome Default do relatorio em Disco
	EndIf	
	wnrel := SetPrint("SEF",wnrel,"",STR0043,STR0044,"","",.F.,"",,"M") //"Impressão Teste de cheque"
	
	If nLastKey == 27
		Return
	Endif
	
	SetDefault(aReturn,"SEF")

	If nLastKey == 27
		Return
	Endif

	If !( "DEFAULT" $ Upper( __DRIVER ) )
		SetPrc(000,000)
	Endif
	
	If GetMv("MV_COMP") == 15
		@ pRow(),pCol() PSAY &(If(aReturn[4]=1,aDriver[3],aDriver[4]))
	Else
		@ pRow(),pCol() PSAY &(aDriver[4])
	EndIf
	
EndIf	

__lSetPrint := .F.
cTeste := "."
If lComp .and. !Empty(nComp)
	cTeste:= CHR(nComp)+"."
Endif
@li,00      PSAY cTeste
@li,nColVlr PSAY "."

Set Device To Screen
SetPgEject(.F.)     

If aReturn[5] = 1
	Set Printer To
	Ourspool(wnrel)
Endif	

MS_FLUSH()

Return
