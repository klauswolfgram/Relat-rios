/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PCOR540.ch"
#include "protheus.ch"

/*/
_F_U_N_C_ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ PCOR540  ³ AUTOR ³ Paulo Carnelossi      ³ DATA ³ 03/04/06   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Programa de impressao de relatorios pre-configurados         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ USO      ³ SIGAPCO                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³_DOCUMEN_ ³ PCOR540                                                      ³±±
±±³_DESCRI_  ³ Programa de impressao de relatorios pre-configurados         ³±±
±±³_FUNC_    ³ Esta funcao podera ser utilizada com a sua chamada normal    ³±±
±±³          ³ partir do Menu ou a partir de uma funcao pulando assim o     ³±±
±±³          ³ browse principal e executando a chamada direta da rotina     ³±±
±±³          ³ selecionada.                                                 ³±±
±±³          ³ Exemplo: U_PCOR540(3,"PCOR520","1234") - Executa a chamada da  ³±±
±±³          ³          funcao de Impressao do relatorio PCOR520 Cfg 1234.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³_PARAMETR_³ ExpN1 : Chamada direta sem passar pela mBrowse               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PCOR540(nCallOpcx,cCodRel,cCfgRel)
Local bBlock
Local nPos
Private cCadastro	:= STR0001 //"Relatorios Pre-Configurados"
Private aRotina 	:= {	{ STR0002,		"AxPesqui" , 0 , 1},;  //"Pesquisar"
							{ STR0003,		"A240DLG" , 0 , 2},;  //"Visualizar"
							{ STR0004, 	    "Pco540Imp", 0 , 3} }   //"Imprimir"

Private aCposVisual
Private cImpRel 						
Private lImprime := .F.
Private M->AKR_ORCAME := Replicate("Z", Len(AKR->AKR_ORCAME)) //nao retirar pois eh utilizado em alguma consulta padrao F3

Default cCodRel := ""
Default cCfgRel := ""

cImpRel := PadR(cCodRel,Len(ALF->ALF_PRGREL))+PadR(cCfgRel,Len(ALF->ALF_CFGREL))

If AMIIn(57) // AMIIn do modulo SIGAPCO ( 57 )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Adiciona botoes do usuario no Browse                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ExistBlock( "PCOR5401" )
		//P_EÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//P_E³ Ponto de entrada utilizado para inclusao de funcoes de usuarios no     ³
		//P_E³ browse da tela de Centros Orcamentarios                                            ³
		//P_E³ Parametros : Nenhum                                                    ³
		//P_E³ Retorno    : Array contendo as rotinas a serem adicionados na enchoice ³
		//P_E³               Ex. :  User Function PCOC5401                            ³
		//P_E³                      Return {{"Titulo", {|| U_Teste() } }}             ³
		//P_EÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ValType( aUsRotina := ExecBlock( "PCOR5401", .F., .F. ) ) == "A"
			AEval( aUsRotina, { |x| AAdd( aRotina, x ) } )
		EndIf
	EndIf
	
	If nCallOpcx != NIL .And. !Empty(cImpRel)
		dbSelectArea("ALG")
		dbSetOrder(1)
		lImprime := dbSeek(xFilial("ALG")+cImpRel)
		
        If lImprime
			dbSelectArea("ALF")
			dbSetOrder(1)
			lImprime := dbSeek(xFilial("ALF")+cImpRel)
		EndIf
		
	EndIf

	If nCallOpcx <> Nil .And. lImprime
		nPos := Ascan(aRotina,{|x| x[4]== nCallOpcx})
		If ( nPos # 0 )
			bBlock := &( "{ |x,y,z,k,w,a,b,c,d,e,f,g| " + aRotina[ nPos,2 ] + "(x,y,z,k,w,a,b,c,d,e,f,g) }" )
			Eval( bBlock,Alias(),ALF->(Recno()),nPos,,,.T.)
		EndIf
	Else
		mBrowse(6,1,22,75,"ALF")
	EndIf

EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Pco540Imp ºAutor  ³Paulo Carnelossi    º Data ³  03/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que imprime o relatorio pre-configurado, ou melhor,  º±±
±±º          ³que faz a chamada aos relatorios passando pergunte que pode º±±
±±º          ³ser customizado por usuario.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Pco540Imp(cAlias,nRecno,nOpcx,cR1,cR2,lAuto)
Local cFuncRel
Private aPerg

If SuperGetMV("MV_PCO_ALF",.F.,"2")!="1"  //1-Verifica acesso por entidade
	lOk := .T.                        // 2-Nao verifica o acesso por entidade
Else
	nDirAcesso := PcoDirEnt_User("ALF", ALF->ALF_PRGREL+ALF->ALF_CFGREL, __cUserID, .F.)
    If nDirAcesso == 0 //0=bloqueado
		Aviso(STR0005,STR0006,{STR0007},2) //"Atenção"###"Usuario sem acesso a impressao do relatorio. "###"Fechar"
		lOk := .F.
	Else
   		lOk := .T.
	EndIf
EndIf

//impressao do relatorio
If lOk

	aPerg    := U_R540CargaPerg()

	DEFAULT lAuto := .F.

	cFuncRel := Alltrim(ALF->ALF_PRGREL)

	If !lAuto
		lImprime := .T.
	EndIf	

	If Len(aPerg) == 0
		Aviso(STR0005, STR0008, {"Ok"}) //"Atencao"##"Nao Informado os parametros do relatorio. Verifique! "
		Return
	EndIf

	dbSelectArea("ALH")
	dbSetOrder(1)
	lImprime := dbSeek(xFilial("ALH")+ALF->ALF_PRGREL)
	dbSelectArea("ALF")
	
	If lImprime
		&(cFuncRel+Alltrim(ALH->ALH_PRGPAR))
	EndIf
	
EndIf

Return

User Function R540CargaPerg()
Local xValue 
Local aPerg := {}
Local aProprSX1
Local aParam_Box := {}
Local nX
Local lPergBox := .F.

dbSelectArea("ALG")
dbSetOrder(1)

If dbSeek(xFilial("ALG")+ALF->ALF_PRGREL+ALF->ALF_CFGREL)

	While ALG->(!Eof().And.ALG_FILIAL+ALG_PRGREL+ALG_CFGREL==;
							xFilial("ALG")+ALF->ALF_PRGREL+ALF->ALF_CFGREL)
		
		aProprSX1 := A540TpEdic(ALF->ALF_GRPERG+ALG->ALG_ORDPER)
		
		If ALG->ALG_EXECUC == "2"
			cTipoEdt := aProprSX1[1]
			xValue := Alltrim( StrTran(ALG->ALG_CNTPER,'"','') )
			
            If Empty(xValue) .And. !Empty(ALG->ALG_FORMUL)
            	xValue := Formula(ALG->ALG_FORMUL)
            	If aProprSX1[4]=="C" .And. ValType(xValue)=="N"
            		xValue := Str(xValue, 1)
            	EndIf
            	If xValue == NIL
            		xValue := ""
            	EndIf	
			EndIf
			
			If aProprSX1[4]=="C"  //se for combo box
				If "]"$xValue
					xValue := Subs(xValue,2,1)
				EndIf	
			EndIf
		
			If Empty(xValue)
				If 		cTipoEdt == "C"
					xValue := Space(aProprSX1[2])
				ElseIf 	cTipoEdt == "D"
					xValue := CtoD("  /  /  ")
				Else
					xValue := If(aProprSX1[3]==0, 0, Val( "0."+Repl("0", aProprSX1[3]) ) )
				EndIf
			Else
				If 		cTipoEdt == "C"
					xValue := PadR(xValue, aProprSX1[2])
				ElseIf 	cTipoEdt == "D"
					If valtype(xValue) == "C"
						xValue := CtoD(xValue)
					EndIf	
				Else
					If valtype(xValue) == "C"
						xValue := Val(xValue)
					EndIf	
				EndIf
			EndIf
			aAdd(aParam_Box, {ALG->ALG_ORDPER, ALG->ALG_OBRIGA, StrTran(ALG->ALG_DESPER,"?",""), aClone(aProprSX1), xValue, ALG->ALG_EXECUC})
		Else	
			xValue := NIL
			aAdd(aParam_Box, {ALG->ALG_ORDPER, ALG->ALG_OBRIGA, ALG->ALG_DESPER, aClone(aProprSX1), xValue, ALG->ALG_EXECUC})
			lPergBox := .T.
		EndIf
		
		aAdd(aPerg, xValue)
		ALG->(dbSkip())
		
	End
	
	If lPergBox .And. Len(aParam_Box) > 0
	   	lRet := R540ParBox(aParam_Box)
	   	If lRet
		   For nX := 1 TO Len(aParam_Box)
		   		aPerg[Val(aParam_Box[nX, 1])] := aParam_Box[nX, 5]
		   Next
		Else
			aPerg := {}   
		EndIf
	EndIf

EndIf

Return(aPerg)

Static Function A540TpEdic(cChave)
Local aArea := GetArea()
Local aAreaSX1 := SX1->(GetArea())
Local cTipoEdt := ""
Local nTamanho := 0
Local nDecimal := 0
Local nGerCombo := ""
Local aCombo := {}, cFunc := "", nX, cCombo,cF3,cValid

cChave := Padr( cChave , Len( x1_grupo ) , ' ' )

dbSelectArea("SX1")

dbSelectArea("SX1")
dbSetOrder(1)
If dbSeek(cChave)
	cTipoEdt 	:= SX1->X1_TIPO
	nTamanho 	:= SX1->X1_TAMANHO
	nDecimal 	:= SX1->X1_DECIMAL
	cF3         := SX1->X1_F3
	cValid      := SX1->X1_VALID
	cGerCombo 	:= SX1->X1_GSC
	If cGerCombo == "C"
		For nX := 1 TO 5
			cFunc := "X1DEF"+StrZero(nX,2)+"()"
			cCombo := &(cFunc)
			If !Empty(cCombo)
				aAdd(aCombo, cCombo)
			EndIf
		Next
		If Empty(aCombo)
			aAdd(aCombo, STR0009)//"Opcao 1"
		EndIf								
	EndIf
EndIf

RestArea(aAreaSX1)
RestArea(aArea)

Return( { cTipoEdt, nTamanho, nDecimal, cGerCombo, aCombo, cF3, cValid} )

Static Function R540ParBox(aParam_Box)
Local aParametros := {}
Local aConfig := {}
Local nX
Local lRet := .F.
Local cTipoEdt
Local xValue
Local cValid

For nX := 1 TO Len(aParam_Box)

	aProprSX1 := aClone(aParam_Box[nX, 4])
	
	cTipoEdt := aProprSX1[1]
	cValid   := aProprSX1[7]

	If !Empty(aParam_Box[nX, 5])
		xValue := aParam_Box[nX, 5]
	ElseIf 	cTipoEdt == "C"
		xValue := Space(aProprSX1[2])
	ElseIf 	cTipoEdt == "D"
		xValue := CtoD("  /  /  ")
	Else
		xValue := If(aProprSX1[3]==0, 0, Val( "0."+Repl("0", aProprSX1[3]) ) )
	EndIf

	If aProprSX1[4]=="C"  //se for combo box
		aAdd(aParametros, {2,aParam_Box[nX, 3],xValue,aProprSX1[5],50,"",.T.,If(aParam_Box[nX, 6]=="1",.T.,.F.)})
    Else
        aAdd(aParametros, { 1 , aParam_Box[nX, 3],xValue ,"@!" 	 ,cValid,If(Empty(aProprSX1[6]),"",aProprSX1[6]) ,If(aParam_Box[nX, 6]=="1",".T.",".F.") ,50 ,If(aParam_Box[nX, 2]=="1",.T.,.F.) })
	EndIf	        

Next

lRet := ParamBox(aParametros , STR0010, aConfig,,,.F.,120,3, , , .F.,)//"Parametros Relatorio"

If lRet
	For nX := 1 TO Len(aParam_Box)
		aProprSX1 := aClone(aParam_Box[nX, 4])
		
		If aParam_Box[nX, 6]  == "1"
			If aProprSX1[4]=="C"  //se for combo box
            	If ValType(aConfig[nX]) != "N"
	            	xValue := ASCAN(aProprSX1[5], aConfig[nX])
	            	aConfig[nX] := xValue
	            EndIf
	        EndIf  
			aParam_Box[nX, 5] := aConfig[nX]
		EndIf	
	Next
EndIf

Return lRet

//exemplos de chamada direta do menu
User Function _ImpDiret()

U_PCOR540(3,"PCOR530","0001")
//onde 3 = opcao imprimir do mbrowse
//     PCOR530 = relatorio a imprimir (nome do fonte)
//     0001 = configuracao do relatorio
Return

User Function _Imp1Diret()
U_PCOR540(3,"PCOR010","0001")
Return
