/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "APWIZARD.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "FIVEWIN.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "PARMTYPE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "QIER270.CH"
#INCLUDE "RPTDEF.CH"                                      
#INCLUDE "TOTVS.CH"

#DEFINE IMP_SPOOL 2

#DEFINE ARR_APARAM_DATAENTR   4
#DEFINE ARR_APARAM_DESCPROD   3
#DEFINE ARR_APARAM_ETIQUETA   1
#DEFINE ARR_APARAM_PRODUTO    2
#DEFINE ARR_APARAM_VALLOTE    5
#DEFINE ARR_APARAM_SERINF     6
#DEFINE ARR_APARAM_SIZE       6	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QIER270	³ Autor ³ Antonio Aurelio       ³ Data ³ 30.08.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Etiqueta de Laudo                      					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QIER270(cProg)                                			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAQIE  												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ STR		 ³ Ultimo utilizado: 0012                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Vera        ³23/09/99³ÄÄÄÄÄÄ³ Impressao a pertir do vetor - import. ent³±±
±±³Paulo Emidio³18/05/00³------³Retirada da Funcao de ajuste do SX1       ³±±
±±³Paulo Emidio³25/05/01³META  ³ Alterado programa para que possa ser sele³±±
±±³       	   ³		³	   ³ cionado o Tipo da Nota Fiscal de Entrada ³±±
±±³       	   ³		³	   ³ sendo a mesma 1)Normal 2)Beneficiamento  ³±±
±±³       	   ³		³	   ³ 3)Devolucao.							  ³±±
±±³Paulo Emidio³01/06/01³009300³ Alterado programa para que nao seja efe- ³±±
±±³			   ³        ³      ³ tuado o salto de pagina ao termino da im-³±±
±±³			   ³		³	   ³ pressao das etiquetas.					  ³±±
±±³Aldo        ³30/01/02³------³ Incluido na IndRegua ".And." nos ultimos ³±±
±±³            ³        ³      ³ parametros.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QIER270(cProg,nMv_par11, nMv_par12,aVetQEK,lImpFic,lEtiqRast,nMv_par03,nMv_par04,nImpr2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Se for chamado pelo cadastro Entradas ou pelo menu, nao passa o vetor com ³ 
//³  a chave de cada Entrada												   ³ 
//³  Se for chamado pela importacao, passa o vetor com as Entradas para a im-  ³ 
//³  pressao das etiquetas.													   ³ 
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Par„metros para a fun‡„o SetPrint () ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   := "QIER270"
Local cString := "QEK"
Local cDesc1  := STR0001 //"Ser„o impressas as etiquetas de Laudo.          "
Local cDesc2  := STR0002 //"           "
Local cDesc3  := ""

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Guarda aquivo e indices correntes    ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cAlias    := Alias()
Local nOldOrder := IndexOrd()

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Par„metros para a fun‡„o SetPrint ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cTitulo	 := STR0003	// "Etiqueta de Laudo"
Private cTamanho := "P"
Private nPagina	 := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas pela fun‡„o SetDefault    ³
//³  e SetPrint                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aEtiquetas := {}
Private aReturn   := {STR0004, 1,STR0005,  1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private cPerg     := "QER270"
Private lEnd      := .F.
Private nLastKey  := 0
Private nLimite   := 80
Private nRecno    := QEK->(Recno())


Default cProg := "QIER270"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					     ³
//³ mv_par01			  // Fornecedor de					     ³
//³ mv_par02			  // Fornecedor ate		    		   	 ³
//³ mv_par03			  // Loja Fornecedor de	 				 ³
//³ mv_par04			  // Loja Fornecedor ate   				 ³
//³ mv_par05			  // Produto de							 ³
//³ mv_par06			  // Produto ate 						 ³
//³ mv_par07			  // Data Entrada de					 ³
//³ mv_par08           	  // Data Entrada ate                    ³
//³ mv_par09              // Lote de                             ³
//³ mv_par10              // Lote ate                            ³
//³ mv_par11              // Assumir Tam.Lote                    ³
//³ mv_par12              // N§ de Etiquetas se Nao Usar Tam.Lote³
//³ mv_par13              // Considera Entrada 1)Normal			 ³
//³											   2)Beneficiamento  ³
//³ 										   3)Devolucao       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cProg $ "QIER270"
	Pergunte(cPerg,.T.)
Else
	Pergunte(cPerg,.F.)
Endif

If cProg $ "QIEA200.QIER220"
	mv_par11 := nMv_par11
	mv_par12 := nMv_par12
	cPerg    := ""  // Desabilita a pergunte
EndIf

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Assume valores caso usu rio nao digite ou digite zero ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF(mv_par11<1,mv_par11:=1,)
IF(mv_par12<1,mv_par12:=1,)
IF(cProg == NIL, cProg := "",)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se apertou o botao cancela ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey == 27
	Return .F.
EndIf

If nLastKey == 27
	Return .F.
EndIf

RptStatus({|lEnd| A270Imp(@lEnd,cString,cProg,aVetQEK,lImpFic,lEtiqRast,nImpr2)},cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura o arq anterior             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAlias)
dbSetOrder(nOldOrder)
dbGoTo(nRecNo)

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ A270Imp  ³ Autor ³ Antonio Aurelio       ³ Data ³ 30.08.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime as Etiquetas dos Produtos da Entregua              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd  - Verifica se o foi cancelada a impressao            ³±±
±±³			 ³ wnRel - Usada na fun‡Æo OurSpool                           ³±±
±±³			 ³ cProg - Usada na verifica‡Æo do prmg chamador desta fun‡Æo ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ A200Imp(QIER200.PRW) e A210Imp(QIER210.PRW)				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A270Imp(lEnd,cString,cProg,aVetQEK,lImpFic,lEtiqRast,nImpr2)
Local lImp	  := .T.
Local nIEnt	  := 0
Local cIndex1 := ""
Local cFiltro := ""
Local cKey	  := ""

Private  cTamLot := ""
Private  nLin := 0

Setprc(00,00)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao a partir do menu de Relatorios ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !cProg $ "QIEA200.QIER220"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Indice Condicional nos arquivos utilizados ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cIndex1 := CriaTrab( Nil, .F. )

	dbSelectarea("QEK")
	dbSetOrder(1)
	cKey:=IndexKey()
	cFiltro := 'QEK_FILIAL == "'+xFilial("QEK") +'"'
	cFiltro += '.And. QEK_FORNEC >="'+mv_par01+'".And. QEK_FORNEC <="'+mv_par02+'".And.'
	cFiltro += 'QEK_LOJFOR >="'+mv_par03+'".And. QEK_LOJFOR <="'+mv_par04+'".And.'
	cFiltro += 'QEK_PRODUT >="'+mv_par05+'".And. QEK_PRODUT <="'+mv_par06+'".And.'
	cFiltro += 'DTOS(QEK_DTENTR) >="'+DTOS(mv_par07)+'".And.DTOS(QEK_DTENTR) <="'+DTOS(mv_par08)+'".And.'
	cFiltro += 'QEK_LOTE >="'+mv_par09+'".And. QEK_LOTE <="'+mv_par10+'"'

	If mv_par13	== 1
		cFiltro += ' .And. (QEK_TIPONF == "N"'+'.Or. QEK_TIPONF == " ")'
	ElseIf mv_par13 == 2
		cFiltro += ' .And. QEK_TIPONF == "B"'
	ElseIf mv_par13 == 3
		cFiltro += ' .And. QEK_TIPONF == "D"'
	EndIf

	IndRegua("QEK",cIndex1,cKey,,cFiltro,STR0006)	//"Selecionando Registros.."
	nIndex := RetIndex("QEK")

	dbSetOrder(nIndex+1)
	dbSeek( xFilial( "QEK" ) )
	A270ImEt(lEnd,cString,cProg,nImpr2)

Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao a partir do cadastro de Entradas ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aVetQEK == NIL

		// Reposiciona o QEK
		QEK->(dbGoTo(nRecNo))
		mv_par01 := QEK->QEK_FORNEC
		mv_par02 := QEK->QEK_FORNEC
		mv_par03 := QEK->QEK_LOJFOR
		mv_par04 := QEK->QEK_LOJFOR
		mv_par05 := QEK->QEK_PRODUT
		mv_par06 := QEK->QEK_PRODUT
		mv_par07 := QEK->QEK_DTENTR
		mv_par08 := QEK->QEK_DTENTR
		mv_par09 := QEK->QEK_LOTE
		mv_par10 := QEK->QEK_LOTE
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Utiliza o Tam.Lote corrente ou assume   ³
		//³   o informado na pergunte mv_par12      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par11 == 1
			cTamLot := QEK->QEK_TAMLOT
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Troca a virgula por ponto outros        ³
			//³   caracteres sao bloqueados no cadastro ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If AT(",",cTamLot) > 0
				cTamLot := StrTran(cTamLot,",",".")
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se o Tam.Lote nao for inteiro ‚ adicionado   ³
			//³  uma etiqueta a mais                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Int(SuperVal(cTamLot)) == SuperVal(cTamLot)
				mv_par12 := Int(SuperVal(cTamLot))
			Else
				mv_par12 := Int(SuperVal(cTamLot)) + 1
			EndIf
		EndIf
		lImp := .T.

		A270ImEt(lEnd,cString,cProg,nImpr2)

	Else

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao a partir da importacao de Entradas ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbselectArea("QEK")
		Dbsetorder(14)
		For nIEnt := 1 To Len(aVetQEK)
            //If !lImpFic .and. !lEtiqRast
			//	aVetQEK[nIEnt] := xFilial("QEK")+aVetQEK[nIEnt]
            //Endif
			// Posiciona o QEK
			If QEK->(dbSeek(aVetQEK[nIEnt]))
				mv_par01 := QEK->QEK_FORNEC
				mv_par02 := QEK->QEK_FORNEC
				mv_par03 := QEK->QEK_LOJFOR
				mv_par04 := QEK->QEK_LOJFOR
				mv_par05 := QEK->QEK_PRODUT
				mv_par06 := QEK->QEK_PRODUT
				mv_par07 := QEK->QEK_DTENTR
				mv_par08 := QEK->QEK_DTENTR
				mv_par09 := QEK->QEK_LOTE
				mv_par10 := QEK->QEK_LOTE
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Utiliza o Tam.Lote corrente ou assume   ³
				//³   o informado na pergunte mv_par12      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par11 == 1
					cTamLot := QEK->QEK_TAMLOT
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Troca a virgula por ponto outros        ³
					//³   caracteres sao bloqueados no cadastro ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If AT(",",cTamLot) > 0
						cTamLot := StrTran(cTamLot,",",".")
					EndIf
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Se o Tam.Lote nao for inteiro ‚ adicionado   ³
					//³  uma etiqueta a mais                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Int(SuperVal(cTamLot)) == SuperVal(cTamLot)
						mv_par12 := Int(SuperVal(cTamLot))
					Else
						mv_par12 := Int(SuperVal(cTamLot))+1
					EndIf
				EndIf
				lImp := .T.
				A270ImEt(lEnd,cString,cProg,nImpr2)
			EndIf
		Next
	EndIf
EndIf

MS_FLUSH()
Return(.T.)
        

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ A270ImEt ³ Autor ³ Antonio Aurelio       ³ Data ³ 04.05.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime as Etiquetas dos Produtos da Entrada               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd  - Verifica se o foi cancelada a impressao            ³±±
±±³			 ³ wnRel - Usada na fun‡Æo OurSpool                           ³±±
±±³			 ³ cProg - Usada na verifica‡Æo do prmg chamador desta fun‡Æo ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³   														  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ A270Imp                                         			  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A270ImEt(lEnd,cString,cProg,nImpr2)
Local aPergunte := {}
Local nImpr1    := 2
Local oObj      := FWSX1Util():New()

oObj:AddGroup(cPerg)
oObj:SearchGroup()
aPergunte := oObj:GetGroup(cPerg)

If Len(aPergunte[2]) < 16
	mv_par16 := ""
EndIf

nImpr1 := Iif(IsInCallStack("QIEA215"),nImpr2,SuperVal(mv_par16)) //Impressora Termica ?

IF nImpr1 == 1 .And. Len(aPergunte[2]) >= 16
	//Chama a impressão térmica
	fImpTermica(cProg)
Else
	//Chama a impressão normal
	fImpNormal(lEnd,cString,cProg)
Endif

Return(.T.)

/*/{Protheus.doc} ValidImpr
Verifica se a impressora está configurada e se está tudo Ok para a impressão
@type Static Function
@author Thiago Henrique Rover
@since 24/11/2021
@version P12
@param 01 cCodImpr , Caracter, Código da impressora que será usada
@param 03 cHelpErro, Caracter, Mensagem com o Help (Problema) ocorrido (passado por referência)
@param 04 cHelpSolu, Caracter, Mensagem com o Help (Solução) ocorrido (passado por referência)
/*/
Static Function ValidImpr(cCodImpr, cTpImpr,cHelpErro, cHelpSolu)

	Local nCount  := 0

	dbSelectArea("CB5")
    CB5->(dbSetOrder(1))
    If CB5->(dbSeek(xFilial("CB5")))
        nCount := 1

        CB5->(dbSkip())
        If !CB5->(EOF()) .And. CB5->CB5_FILIAL == xFilial("CB5")
            nCount := 2
        EndIf

        CB5->(dbSkip(-1))
    EndIf

	If nCount == 0
		Help( ,  , STR0013, ,  STR0014,; //"Help""Não existe impressora cadastrada."
			1, 0, , , , , , {STR0015}) //"Cadastre o local de impressão (ACDA060)."

	//Se existir somente uma impressora cadastrada, utilizar essa impressora
	ElseIf nCount == 1
		cCodImpr := CB5->CB5_CODIGO

	//Se existir mais de uma impressora cadastrada, exibir uma tela para que o usuário escolha qual modelo de impressora é o desejado
	ElseIf nCount > 1
		If ConPad1(,,,"CB5PCP",,, .F.)
			cCodImpr := CB5->CB5_CODIGO
		EndIf
	EndIf

	//Verifica se a impressora está cadastrada no ACDA060
	If cCodImpr <> CB5->CB5_CODIGO .Or. xFilial("CB5") <> CB5->CB5_FILIAL
		CB5->(dbSetOrder(1))
		If !CB5->(dbSeek(xFilial("CB5") + cCodImpr))
			cHelpErro := STR0016 + Trim(cCodImpr) + STR0017 				//"Impressora '" xxx "' não cadastrada."
			cHelpSolu := STR0018  //"Cadastre a impressora no programa Local de Impressão (ACDA060)."
			Return .F.
		EndIf
	EndIf

	//Verifica qual a fabricante para direcionar para a Função correta
	If MSCbModelo("ZPL", AllTRIM(CB5->CB5_MODELO))
		cTpImpr := "Z" //Zebra

	ElseIf MSCbModelo("DPL", AllTRIM(CB5->CB5_MODELO))
		cTpImpr := "D" //Datamax

	ElseIf MSCbModelo("IPL", AllTRIM(CB5->CB5_MODELO))
		cTpImpr := "I" //Intermec

	ElseIf MSCbModelo("EPL", AllTRIM(CB5->CB5_MODELO))
		cTpImpr := "E" //Eltron
	EndIf

	//Verifica se o modelo está cadastrado
	If Empty(cTpImpr)
		cHelpErro := STR0019 + Trim(CB5->CB5_MODELO) + STR0020 	//"Modelo '" XXXX "' não encontrado."
		cHelpSolu := STR0021 + Trim(cCodImpr) + STR0022         //"Verifique o modelo cadastrado para a impressora '" XXX "' no programa Local de Impressão (ACDA060)."
		Return .F.
	EndIf
	
Return .T.

/*/{Protheus.doc} ImprEti
Prepara a impressora e imprime as etiquetas dos produtos
@type Static Function
@author Thiago Henrique Rover
@since 10/07/2020
@version P12
@param 01 cCodImpr, Caracter, Código da impressora que será usada
@param 02 cTpImpr,  Caracter, Código do Tipo da Impressora que será usada
/*/
Static Function ImprEti(cCodImpr,cTpImpr)
    Local cBlockF   := "" 
	Local lOk       := .T.

	IF cTpImpr $ 'Z'
	   cBlockF := "Impr270Z()"  //Zebra
	ElseIf cTpImpr $ 'D'
		cBlockF := "Impr270D()" //Datamax
	ElseIf cTpImpr $ 'I'	
		cBlockF := "Impr270I()" //Intermec
	Else 
		cBlockF := "Impr270E()" //Eltron
	Endif

    //Prepara a impressora e instancia a classe para utilização da impressora
    If CB5SetImp(cCodImpr)

		//Chama a função que faz a impressão da etiqueta
		&(cBlockF)

        //Finaliza a impressão das etiquetas
        MSCBCLOSEPRINTER()
     Else
        Help( ,  , STR0013, ,  STR0023,; //"Help""Não foi possível preparar a impressora."
             1, 0, , , , , , {STR0024 +  Trim(cCodImpr) + STR0022}) //"Verifique o cadastro da impressora '" XXX "' no programa Local de Impressão (ACDA060)."
        lOk := .F.
    EndIf

Return lOk


/*/{Protheus.doc} GetRegsQEK
Carrega os produtos da QEK - Entradas
@type Static Function
@author Thiago Henrique Rover
@since 24/11/2021
@version P12
@param 01 cProg, Caracter, contei o nome da rotina
@return nQtdRegs, Numérico, Quantidade de produtos da QEK
/*/
Static Function GetRegsQEK(cProg)
    Local cAliasQry := GetNextAlias()
	Local cChaveQEK := ""
	Local cFor      := ""
	Local cLojFor   := ""
	Local lQReinsp	:= QieReinsp()
	Local nQtdRegs  := 0

	Default cProg := "QIER270"

    BeginSql Alias cAliasQry
      SELECT *
        FROM %Table:QEK% QEK,
        WHERE QEK.QEK_FILIAL   = %xfilial:QEK% AND
    		QEK.QEK_FORNEC  BetWeen %Exp:mv_par01%  AND %Exp:mv_par02% AND  
         	QEK.QEK_LOJFOR  BetWeen %Exp:mv_par03%  AND %Exp:mv_par04% AND  
        	QEK.QEK_PRODUT  BetWeen %Exp:mv_par05%  AND %Exp:mv_par06% AND
        	QEK.QEK_DTENTR  BetWeen %Exp:mv_par07%  AND %Exp:mv_par08% AND
        	QEK.QEK_LOTE    BetWeen %Exp:mv_par09%  AND %Exp:mv_par10% AND
			QEK.%notDel%
    EndSql

    While (cAliasQry)->(!Eof())
        nQtdRegs++

		cChaveQEK	:= (cAliasQry)->QEK_PRODUT+Inverte((cAliasQry)->QEK_REVI)
		cFor		:= (cAliasQry)->QEK_FORNEC
		cLojFor	    := (cAliasQry)->QEK_LOJFOR

		dbSelectArea("QE6")
		dbSetOrder(1)
		QE6->(dbSeek(xFilial("QE6")+cChaveQEK))

		If QE6->(!Found())
			// "Produto/Revisao nao cadastrados:
			Set Device to Screen
			Help(" ",1,"QE_NAOPRRV",,AllTrim((cAliasQry)->QEK_PRODUT)+" / "+(cAliasQry)->QEK_REVI,2,1)
			Set Device to Printer
			dbSelectArea("QEK")
			(cAliasQry)->(dbSkip())
			Loop
		EndIf

		cProduto := QE6->QE6_PRODUT+QE6->QE6_REVI

		If QE6->QE6_UNSHEL == "1"  // Dia
			nDias := QE6->QE6_SHLF
		Else
			If QE6->QE6_UNSHEL == "2" // Mes
				nDias := QE6->QE6_SHLF * 30
			Else
				nDias := QE6->QE6_SHLF * 365
			EndIf
		EndIf

		QEL->(dbSetOrder(3))
		cSeek := (cAliasQry)->QEK_FORNEC+(cAliasQry)->QEK_LOJFOR+(cAliasQry)->QEK_PRODUT+(cAliasQry)->QEK_NTFISC+(cAliasQry)->QEK_SERINF+(cAliasQry)->QEK_ITEMNF+(cAliasQry)->QEK_TIPONF+(cAliasQry)->QEK_DTENTR+(cAliasQry)->QEK_LOTE+;
		Space(TamSX3("QEL_LABOR")[1])
		If lQReinsp
			cSeek += (cAliasQry)->QEK_NUMSEQ
		Endif
		
		If	QEL->(dbSeek(xFilial("QEL")+cSeek))

			If lQReinsp 
				While QEL->(!Eof()) .And. ;
						QEL->(QEL_FILIAL+QEL_FORNEC+QEL_LOJFOR+QEL_PRODUT+DTOS(QEL_DTENTR)+QEL_LOTE)+Space(TamSX3("QEL_LABOR")[1]) == xFilial("QEL")+cSeek
					
					If QEL->QEL_NUMSEQ == (cAliasQry)->QEK_NUMSEQ
						Exit
					Endif
					
					QEL->(dbSkip())
				Enddo
			Endif

			If Empty(QEL->(QEL_NUMPER))
				If QED->(dbSeek(xFilial("QED")+QEL->QEL_LAUDO))
					cEtiq := AllTrim(QED->QED_DESCPO)
				Else
					cEtiq := STR0010 // EM INSPECAO
				EndIf
			Else
				QF2->(dbSetOrder(1))
				If QF2->(dbSeek(xFilial("QF2")+(cAliasQry)->QEK_FORNEC+(cAliasQry)->QEK_LOJFOR+;
						(cAliasQry)->QEK_PRODUT+Dtos((cAliasQry)->QEK_DTENTR)+(cAliasQry)->QEK_LOTE+;
						QEL->QEL_NUMPER))
					// Se a PU for Aprovada, o laudo a ser impresso e Liberado
					If QF2->QF2_STATUS == "A"
						cEtiq := STR0012	// "LIBERADO"
					Else
						// Permanece o laudo definido pelo usuario
						If QED->(dbSeek(xFilial("QED")+QEL->QEL_LAUDO))
							cEtiq := AllTrim(QED->QED_DESCPO)
						Else
							cEtiq := STR0010 // EM INSPECAO
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			cEtiq := STR0010 // EM INSPECAO
		EndIf

		If !cProg $ "QIEA200.QIER220"
			If mv_par11 == 1  // Assume o Tam. do Lote
				cTamLot := (cAliasQry)->QEK_TAMLOT
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Troca a virgula por ponto outros        ³
				//³   caracteres sao bloqueados no cadastro ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If AT(",",cTamLot) > 0
					cTamLot := StrTran(cTamLot,",",".")
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Se o Tam.Lote nao for inteiro ‚ adicionado   ³
				//³  uma etiqueta a mais                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Int(SuperVal(cTamLot)) == SuperVal(cTamLot)
					mv_par12 := Int(SuperVal(cTamLot))
				Else
					mv_par12 := Int(SuperVal(cTamLot)) + 1
				EndIf
			EndIf
		EndIf

		If mv_par11 == 1	
			nEtiqueta:= Int(SuperVal(cTamLot))
		Else	
			nEtiqueta:= mv_par12
		Endif

        aAdd(aEtiquetas, Array(ARR_APARAM_SIZE))	

        aEtiquetas[nQtdRegs][ARR_APARAM_ETIQUETA ] := cEtiq
        aEtiquetas[nQtdRegs][ARR_APARAM_PRODUTO  ] := Pad(AllTrim(TitSx3("QEK_PRODUT")[1]),11,".")+" : " +AllTrim((cAliasQry)->QEK_PRODUT)+" - " +(cAliasQry)->QEK_REVI
        aEtiquetas[nQtdRegs][ARR_APARAM_DESCPROD ] := QE6->QE6_DESCPO
        aEtiquetas[nQtdRegs][ARR_APARAM_DATAENTR ] := Pad(AllTrim(TitSx3("QEK_DTENTR")[1]),11,".")+" : "+(cAliasQry)->QEK_DTENTR+"  "+Pad(AllTrim(TitSx3("QEK_LOTE")[1]),10,".")+" : "+AllTrim((cAliasQry)->QEK_LOTE)
        
		SAH->(dbSetOrder(1))
		SAH->(dbSeek(xFilial("SAH")+(cAliasQry)->QEK_UNIMED))
		If !Empty(SAH->AH_UMRES)
			aEtiquetas[nQtdRegs][ARR_APARAM_VALLOTE ] := STR0011+"    "+DTOC(QEL->QEL_DTVAL)+"  "+Pad(AllTrim(TitSx3("QEK_TAMLOT")[1]),11,".")+" : "+AllTrim((cAliasQry)->QEK_TAMLOT)+" "+SAH->AH_UMRES 	// "Validade..: "       
		Else
			aEtiquetas[nQtdRegs][ARR_APARAM_VALLOTE ] := STR0011+"    "+DTOC(QEL->QEL_DTVAL)+"  "+Pad(AllTrim(TitSx3("QEK_TAMLOT")[1]),11,".")+" : "+AllTrim((cAliasQry)->QEK_TAMLOT)	       
		Endif	

		cSerie:= SerieNfId("QEK",3,"QEK_SERINF")
		If !Empty((cAliasQry)->(&cSerie))   		
			aEtiquetas[nQtdRegs][ARR_APARAM_SERINF ] := Pad(AllTrim(TitSx3("QEK_NTFISC")[1]),11,".")+" : "+AllTrim((cAliasQry)->QEK_NTFISC)+" - "+(cAliasQry)->(&cSerie)       		
		Else
			aEtiquetas[nQtdRegs][ARR_APARAM_SERINF ] := Pad(AllTrim(TitSx3("QEK_NTFISC")[1]),11,".")+" : "+AllTrim((cAliasQry)->QEK_NTFISC)    		
		EndIf

		If lEnd
			Exit
		EndIf

        (cAliasQry)->(dbSkip())
    EndDo

    (cAliasQry)->(dbCloseArea())

Return nQtdRegs

/*/{Protheus.doc} fImpNormal
Função expecialista em impressões normais
@type  Static Function
@author thiago.rover
@since 13/12/2021
/*/
Static Function fImpNormal(lEnd,cString,cProg)
	Local aAreas     := {QE6->(GetArea()), QED->(GetArea()), QEK->(GetArea()), QEL->(GetArea()), QF2->(GetArea()), SAH->(GetArea())}
	Local aDevice    := {}
	Local aMargin    := {}
	Local aOrdem 	 := {AllTrim(FWX3Titulo("QEK_FILIAL"))+' + '+AllTrim(FWX3Titulo("QEK_FORNEC"))+' + '+AllTrim(FWX3Titulo("QEK_LOJFOR")),;
						AllTrim(FWX3Titulo("QEK_FILIAL"))+' + '+AllTrim(FWX3Titulo("QEK_PRODUT")),;
						AllTrim(FWX3Titulo("QEK_FILIAL"))+' + '+AllTrim(FWX3Titulo("QEK_DTENTR")),;
						AllTrim(FWX3Titulo("QEK_FILIAL"))+' + '+AllTrim(FWX3Titulo("QEK_LOTE"  ))}
	Local bParam	 := {|| Pergunte("QER270", .T.)}
	Local cAliasQEK  := GetNextAlias()
	Local cChaveQEK1 := ""
	Local cDevice    := ""
	Local cDirectory := GetSrvProfString("StartPath","\system\")
	Local cDirPrint  := GetTempPath() // DirÚtorio Temporßrio
	Local cEtiq      := ""
	Local cFor		 := ""
	Local cLojFor	 := ""
	Local cNameFile  := "Etiquetas_Produto_Entrada"
	Local cOrdem     := ""
	Local cSeek      := ""
	Local cSerie     := ""
	Local cSession   := GetPrinterSession()
	Local lAdjust    := .T.
	Local lin        := 80
	Local lQReinsp	 := QieReinsp()
	Local nC         := 0
	Local nDias      := 0
	Local nEtiqueta  := 0
	Local nFlags     := PD_ISTOTVSPRINTER//+PD_DISABLEPAPERSIZE
	Local nLocal     := 1
	Local nOrdem 	 := 1
	Local nOrient    := 1
	Local nPrintType := 6
	Local nSaltPag   := 0
	Local oFont06    := TFont():New("Arial",06,09,,.T.,,,,.T.,.F.)
	Local oPrint     := NIL
	Local oSetup     := Nil

	AADD(aDevice,"DISCO") // 1
	AADD(aDevice,"SPOOL") // 2
	AADD(aDevice,"EMAIL") // 3
	AADD(aDevice,"EXCEL") // 4
	AADD(aDevice,"HTML" ) // 5
	AADD(aDevice,"PDF"  ) // 6

	//????????????????????????????????????????
	//? Nº de Etiquetas a serem impressas 	 ?
	//????????????????????????????????????????
	If !cProg $ "QIEA200.QIER220"
		SetRegua( QEK->(RecCount()) )  // Depende da selecao feita na pergunte
	Else
		If mv_par11 == 1  // Assume o tamanho do lote
			SetRegua(mv_par12 * QEK->(RecCount()))
		Else
			SetRegua(mv_par12 )  // Só o tamanho especificado
		EndIf
	EndIf

	dbSelectArea("QEK")

	cSession   := GetPrinterSession()
	// Obtem ultima configuracao de tipo de impressÒo (spool ou pdf) gravada no arquivo de configuracao
	cDevice	   := If(Empty(fwGetProfString(cSession,"PRINTTYPE","SPOOL",.T.)),"PDF",fwGetProfString(cSession,"PRINTTYPE","SPOOL",.T.))
	// Obtem ultima configuracao de orientacao de papel (retrato ou paisagem) gravada no arquivo de configuracao
	nOrient	   := If(fwGetProfString(cSession,"ORIENTATION","PORTRAIT",.T.)=="PORTRAIT",1,2)
	// Obtem ultima configuracao de destino (cliente ou servidor) gravada no arquivo de configuracao
	nLocal	   := If(fwGetProfString(cSession,"LOCAL","SERVER",.T.)=="SERVER",1,2 )
	nPrintType := aScan(aDevice,{|x| x == cDevice })     

	oPrint := FWMsPrinter():New(cNameFile,IMP_SPOOL,lAdjust,cDirectory,.T.,,, "PDF" )

	// Cria e exibe tela de Setup Customizavel - Utilizar include "FWPrintSetup.ch"
	oSetup := FWPrintSetup():New(nFlags,cNameFile)

	oSetup:SetPropert(PD_PRINTTYPE   , nPrintType)
	oSetup:SetPropert(PD_ORIENTATION , nOrient)
	oSetup:SetPropert(PD_DESTINATION , nLocal)
	oSetup:SetPropert(PD_MARGIN      , {0,0,0,0})
	//oSetup:SetPropert(PD_PAPERSIZE   , 2)
	oSetup:SetOrderParms(aOrdem,@nOrdem)
	oSetup:SetUserParms(bParam)

	If oSetup:Activate() == PD_OK 
		// Grava ultima configuracao de destino (cliente ou servidor) no arquivo de configuracao
		fwWriteProfString( cSession, "LOCAL"      , If(oSetup:GetProperty(PD_DESTINATION)==1 ,"SERVER"    ,"CLIENT"    ), .T. )
		// Grava ultima configuracao de tipo e impressao (spool ou pdf) no arquivo de configuracao
		fwWriteProfString( cSession, "PRINTTYPE"  , If(oSetup:GetProperty(PD_PRINTTYPE)==2   ,"SPOOL"     ,"PDF"       ), .T. )
		// Grava ultima configuracao de orientacao de papel (retrato ou paisagem) no arquivo de configuracao
		fwWriteProfString( cSession, "ORIENTATION", If(oSetup:GetProperty(PD_ORIENTATION)==1 ,"PORTRAIT"  ,"LANDSCAPE" ), .T. )
		// Atribui configuracao de destino (cliente ou servidor) ao objeto FwMsPrinter
		oPrint:lServer := oSetup:GetProperty(PD_DESTINATION) == AMB_SERVER
		// Atribui configuracao de tipo de impressao (spool ou pdf) ao objeto FwMsPrinter
		oPrint:SetDevice(oSetup:GetProperty(PD_PRINTTYPE))
		// Atribui configuracao de orientacao de papel (retrato ou paisagem) ao objeto FwMsPrinter
		If oSetup:GetProperty(PD_ORIENTATION) == 1
			oPrint:SetPortrait()
			nMaxLin	:= 800
			nMaxCol	:= 600
		Else 
			oPrint:SetLandscape()
			nMaxLin	:= 600
			nMaxCol	:= 800
		EndIf
		// Atribui configuracao de tamanho de papel ao objeto FwMsPrinter
		oPrint:SetPaperSize(oSetup:GetProperty(PD_PAPERSIZE))
		oPrint:setCopies(Val(oSetup:cQtdCopia))
		If oSetup:GetProperty(PD_PRINTTYPE) == IMP_SPOOL
			oPrint:nDevice := IMP_SPOOL
			fwWriteProfString(GetPrinterSession(),"DEFAULT", oSetup:aOptions[PD_VALUETYPE], .T.)
			oPrint:cPrinter := oSetup:aOptions[PD_VALUETYPE]
			aMargin := oSetup:GetProperty(PD_MARGIN)
			If aMargin[1] < 40
				aMargin[1] := 40
			EndIf
			oPrint:SetMargin(aMargin[1],aMargin[2],aMargin[3],aMargin[4])
		Else 
			oPrint:nDevice := IMP_PDF
			oPrint:cPathPDF := oSetup:aOptions[PD_VALUETYPE]
			oPrint:SetViewPDF(.T.)
		Endif

		oPrint:cPathPDF := cDirPrint  // Diret¾rio para o arquivo PDF
		oPrint:SetPortrait()
		oPrint:lServer := .F. 
		oPrint:SetMargin(50,50,0,0) // Seta as margens
		oPrint:SetPaperSize(DMPAPER_A4)
		oPrint:nDevice := IMP_SPOOL // Tipo de impressÒo

		If nOrdem == 1
			cOrdem := "%QEK.QEK_FILIAL,QEK.QEK_FORNEC,QEK.QEK_LOJFOR%"
		ElseIf nOrdem == 2
			cOrdem := "%QEK.QEK_FILIAL,QEK.QEK_PRODUT%"
		ElseIf nOrdem == 3
			cOrdem := "%QEK.QEK_FILIAL,QEK.QEK_DTENTR%"
		ElseIf nOrdem == 4
			cOrdem := "%QEK.QEK_FILIAL,QEK.QEK_LOTE%"
		Endif

		BeginSql alias cAliasQEK   
			SELECT * FROM %table:QEK% QEK
			WHERE  QEK.QEK_FILIAL =  %xFilial:QEK%  AND QEK.%NotDel% AND
				QEK.QEK_FORNEC >= %exp:mv_par01% AND QEK.QEK_FORNEC <= %exp:mv_par02% AND
				QEK.QEK_LOJFOR >= %exp:mv_par03% AND QEK.QEK_LOJFOR <= %exp:mv_par04% AND
				QEK.QEK_PRODUT >= %exp:mv_par05% AND QEK.QEK_PRODUT <= %exp:mv_par06% AND
				QEK.QEK_DTENTR >= %exp:mv_par07% AND QEK.QEK_DTENTR <= %exp:mv_par08% AND
				QEK.QEK_LOTE   >= %exp:mv_par09% AND QEK.QEK_LOTE   <= %exp:mv_par10%
			ORDER BY %exp:cOrdem%
		EndSql

		DBSELECTAREA(cAliasQEK)
		While !(cAliasQEK)->(Eof())

			QEK->(DBGOTO( (cAliasQEK)->(R_E_C_N_O_) ))
				
			cChaveQEK1	:= QEK->QEK_PRODUT+Inverte(QEK->QEK_REVI)
			cLojFor	    := QEK->QEK_LOJFOR
			cFor		:= QEK->QEK_FORNEC

			dbSelectArea("QE6")
			QE6->(dbSetOrder(1))
			If !QE6->(dbSeek(xFilial("QE6")+cChaveQEK1))
				// "Produto/Revisao nao cadastrados:
				Set Device to Screen
				Help(" ",1,"QE_NAOPRRV",,AllTrim(QEK->QEK_PRODUT)+" / "+QEK->QEK_REVI,2,1)
				Set Device to Printer
				dbSelectArea(cAliasQEK)
				(cAliasQEK)->(dbSkip())
				Loop
			EndIf

			cProduto := QE6->QE6_PRODUT+QE6->QE6_REVI

			If QE6->QE6_UNSHEL == "1"  // Dia
				nDias := QE6->QE6_SHLF
			Else
				If QE6->QE6_UNSHEL == "2" // Mes
					nDias := QE6->QE6_SHLF * 30
				Else
					nDias := QE6->QE6_SHLF * 365
				EndIf
			EndIf

			QEL->(dbSetOrder(3))
			cSeek := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+;
			Space(TamSX3("QEL_LABOR")[1])
			If lQReinsp
				cSeek += QEK->QEK_NUMSEQ
			Endif

			If	QEL->(dbSeek(xFilial("QEL")+cSeek))

				If lQReinsp 
					While QEL->(!Eof()) .And. ;
							QEL->(QEL_FILIAL+QEL_FORNEC+QEL_LOJFOR+QEL_PRODUT+DTOS(QEL_DTENTR)+QEL_LOTE)+Space(TamSX3("QEL_LABOR")[1]) == xFilial("QEL")+cSeek
						
						If QEL->QEL_NUMSEQ == QEK->QEK_NUMSEQ
							Exit
						Endif
						
						QEL->(dbSkip())
					Enddo
				Endif

				If Empty(QEL->(QEL_NUMPER))
					If QED->(dbSeek(xFilial("QED")+QEL->QEL_LAUDO))
						cEtiq := AllTrim(QED->QED_DESCPO)
					Else
						cEtiq := STR0010 // EM INSPECAO
					EndIf
				Else
					QF2->(dbSetOrder(1))
					If QF2->(dbSeek(xFilial("QF2")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+;
							QEK->QEK_PRODUT+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE+;
							QEL->QEL_NUMPER))
						// Se a PU for Aprovada, o laudo a ser impresso e Liberado
						If QF2->QF2_STATUS == "A"
							cEtiq := STR0012	// "LIBERADO"
						Else
							// Permanece o laudo definido pelo usuario
							If QED->(dbSeek(xFilial("QED")+QEL->QEL_LAUDO))
								cEtiq := AllTrim(QED->QED_DESCPO)
							Else
								cEtiq := STR0010 // EM INSPECAO
							EndIf
						EndIf
					EndIf
				EndIf
			Else
				cEtiq := STR0010 // EM INSPECAO
			EndIf


			If !cProg $ "QIEA200.QIER220"
				If mv_par11 == 1  // Assume o Tam. do Lote
					cTamLot := QEK->QEK_TAMLOT
					//???????????????????????????????????????????
					//? Troca a virgula por ponto outros        ?
					//?   caracteres sao bloqueados no cadastro ?
					//???????????????????????????????????????????
					If AT(",",cTamLot) > 0
						cTamLot := StrTran(cTamLot,",",".")
					EndIf
					//????????????????????????????????????????????????
					//? Se o Tam.Lote nao for inteiro é adicionado   ?
					//?  uma etiqueta a mais                         ?
					//????????????????????????????????????????????????
					If Int(SuperVal(cTamLot)) == SuperVal(cTamLot)
						mv_par12 := Int(SuperVal(cTamLot))
					Else
						mv_par12 := Int(SuperVal(cTamLot)) + 1
					EndIf
				EndIf
			EndIf

			If mv_par11 == 1	
				nEtiqueta:= Int(SuperVal(cTamLot))
			Else	
				nEtiqueta:= mv_par12
			Endif


			oPrint:StartPage() 		
			For nC := 1 To mv_par12

				IncRegua()

			If lEnd
					nLin := nLin + 1
					@ nLin ,001 PSAY STR0007  // "CANCELADO PELO OPERADOR"
					Exit
				EndIf

				nSaltPag:= nSaltPag + 1
				lin += 30

				oPrint:Say(lin,0020,cEtiq,oFont06)        
				lin += 30

				//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				//Produto....: 0123456789012345 - XX
				//              XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				//Data Entreg: 99/99/9999 Lote.....: 0123456789012345
				//Validade...: 99/99/9999 Tam.Lote.: 012345678 XXXXXXXXX
				//Nota Fiscal: 0123456789012 012
				// 			1			 2 		  3			4			 5 		  6			7			 8 		  9			10 		 11		  12			13
				//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

				oPrint:Say(lin,0020,Pad(AllTrim(TitSx3("QEK_PRODUT")[1]),11,".")+" : " +AllTrim(QEK->QEK_PRODUT)+" - " +QEK->QEK_REVI,oFont06)        
				lin += 30

				oPrint:Say(lin,0150,QE6->QE6_DESCPO,oFont06)        
				lin += 30

				oPrint:Say(lin,0020,Pad(AllTrim(TitSx3("QEK_DTENTR")[1]),11,".")+" : "+dtoc(QEK->QEK_DTENTR)+"  "+Pad(AllTrim(TitSx3("QEK_LOTE")[1]),10,".")+" : "+AllTrim(QEK->QEK_LOTE),oFont06)        
				lin += 30
				
				SAH->(dbSetOrder(1))
				SAH->(dbSeek(xFilial("SAH")+QEK->QEK_UNIMED))
				If !Empty(SAH->AH_UMRES)
					oPrint:Say(lin,0020,STR0011+"    "+dtoc(QEL->QEL_DTVAL)+"  "+Pad(AllTrim(TitSx3("QEK_TAMLOT")[1]),11,".")+" : "+AllTrim(QEK->QEK_TAMLOT)+" "+SAH->AH_UMRES,oFont06) 	// "Validade..: "       
				Else
					oPrint:Say(lin,0020,STR0011+"    "+dtoc(QEL->QEL_DTVAL)+"  "+Pad(AllTrim(TitSx3("QEK_TAMLOT")[1]),11,".")+" : "+AllTrim(QEK->QEK_TAMLOT),oFont06) 	       
				Endif		

				lin += 30
				cSerie:= SerieNfId("QEK",3,"QEK_SERINF")
				If !Empty(QEK->(&cSerie))   		
					oPrint:Say(lin,0020,Pad(AllTrim(TitSx3("QEK_NTFISC")[1]),11,".")+" : "+AllTrim(QEK->QEK_NTFISC)+" - "+QEK->(&cSerie),oFont06)        		
				Else
					oPrint:Say(lin,0020,Pad(AllTrim(TitSx3("QEK_NTFISC")[1]),11,".")+" : "+AllTrim(QEK->QEK_NTFISC),oFont06)        		
				EndIf
			
				If lin > 2500  
					oPrint:EndPage() 		
					lin := 80
					nSaltPag:= 0
				Else
					If nSaltPag == 	nEtiqueta // Pula de Pagina de acordo com o numero de etiquetas 
						If lin > 2500  
							oPrint:EndPage() 		
							lin := 80
							nSaltPag:= 0
							nSaltPag:= 0           
							oPrint:EndPage() 		
						Endif	
						lin += 100
					Else			
						lin += 100 
					EndIf
				Endif

			Next

			(cAliasQEK)->(DbSkip())

			If lEnd
				Exit
			EndIf

		EndDo
		(cAliasQEK)->(DBCLOSEAREA())
	Else 
		MsgInfo(STR0007)//"CANCELADO PELO OPERADOR"
		oPrint:Cancel()
	EndIf

	oPrint:EndPage() 
	oPrint:Print()  

	FreeObj(oPrint)

	//????????????????????????????????????????
	//? Restaura os índices dos arq. usados  ?
	//????????????????????????????????????????
	AEval(aAreas, {|aAreas| RestArea(aAreas)})

Return NIL

/*/{Protheus.doc} fImpTermica
Função expecialista em gerar etiquetas térmicas
@type  Static Function
@author user
@since 13/12/2021
@version version
/*/
Static Function fImpTermica(cProg)

	Local cCodImpr    := ""
	Local cHelpErro   := ""
	Local cHelpSolu   := ""
	Local cTpImpr     := ""
	Local lOk         := .T.
	Local aAreas      := {QED->(GetArea()), QEL->(GetArea()), QE6->(GetArea()),SAH->(GetArea())}


	//Função que carrega os dados da QEK para Impressão
	nQtdRegs := GetRegsQEK(cProg)

	//Validação da impressora
	ValidImpr(@cCodImpr, @cTpImpr, @cHelpErro, @cHelpSolu)

	//Se não tem mensagem de erro, manda para a impressão
	If Empty(cHelpErro)
		lOk := ImprEti(cCodImpr, cTpImpr)
	Else
		lOk := .F.
		Help( ,  , STR0013, ,  cHelpErro, 1, 0, , , , , , {cHelpSolu}) //"Help"
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ N§ de Etiquetas a serem impressas 	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !cProg $ "QIEA200.QIER220"
		SetRegua( QEK->(RecCount()) )  // Depende da selecao feita na pergunte
	Else
		If mv_par11 == 1  // Assume o tamanho do lote
			SetRegua(mv_par12 * QEK->(RecCount()))
		Else
			SetRegua(mv_par12 )  // S¢ o tamanho especificado
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Restaura os ¡ndices dos arq. usados  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aEval(aAreas, {|x| RestArea(x)})
	
Return Nil


/*
Padrão Zebra
Programa: Impr270Z
Autor: Thiago Henrique Rover
Data: 24/11/2021
Descricao: Geração de etiqueta Impressora Térmica Zebra
*/
Static Function Impr270Z()
	Local nCopias    := mv_par12
    Local nIndex     := 0

    For nIndex := 1 To nCopias

		MSCBLOADGRF("SIGA.GRF")
		MSCBBEGIN(1,6)
		MSCBGRAFIC(2,3,"SIGA")
        MSCBSAY(10,10,aEtiquetas[1][1],"N","A","040,030")
		MSCBSAY(10,15,aEtiquetas[1][2],"N","A","040,030")
		MSCBSAY(10,20,aEtiquetas[1][3],"N","A","040,030")
		MSCBSAY(10,25,aEtiquetas[1][4],"N","A","040,030")
		MSCBSAY(10,30,aEtiquetas[1][5],"N","A","040,030")
		MSCBSAY(10,35,aEtiquetas[1][6],"N","A","040,030")
		MSCBEND()

    Next
	
Return Nil


/*
Padrão Datamax
Programa: Impr270D
Autor: Thiago Henrique Rover
Data: 24/11/2021
Descricao: Geração de etiqueta Impressora Térmica Datamax
*/
Static Function Impr270D()
	Local nCopias    := mv_par12
    Local nIndex     := 0

    For nIndex := 1 To nCopias

        MSCBLOADGRF("SIGA.BMP")
        MSCBBEGIN(1,6)
        MSCBGRAFIC(2,29,"SIGA",.T.)
        MSCBSAY(10,10,aEtiquetas[1][1],"B","3","01,01")
		MSCBSAY(10,15,aEtiquetas[1][2],"B","3","01,01")
		MSCBSAY(10,20,aEtiquetas[1][3],"B","3","01,01")
		MSCBSAY(10,25,aEtiquetas[1][4],"B","3","01,01")
		MSCBSAY(10,30,aEtiquetas[1][5],"B","3","01,01")
		MSCBSAY(10,35,aEtiquetas[1][6],"B","3","01,01")
        MSCBEND()

    Next
Return Nil

/*
Padrão Intermec
Programa: Impr270I
Autor: Thiago Henrique Rover
Data: 24/11/2021
Descricao: Geração de etiqueta Impressora Térmica Intermec
*/
Static Function Impr270I()
	Local nCopias    := mv_par12
    Local nIndex     := 0

    For nIndex := 1 To nCopias

		MSCBBEGIN(1,3)
		MSCBCHKSTATUS(.F.)
        MSCBSAY(12,1,aEtiquetas[1][1],"R","2","01,01")
		MSCBSAY(12,5,aEtiquetas[1][2],"R","2","01,01")
		MSCBSAY(12,10,aEtiquetas[1][3],"R","2","01,01")
		MSCBSAY(12,15,aEtiquetas[1][4],"R","2","01,01")
		MSCBSAY(12,20,aEtiquetas[1][5],"R","2","01,01")
		MSCBSAY(12,25,aEtiquetas[1][6],"R","2","01,01")
		MSCBEND()

    Next

Return Nil

/*
Padrão Eltron
Programa: Impr270I
Autor: Thiago Henrique Rover
Data: 24/11/2021
Descricao: Geração de etiqueta Impressora Térmica Eltron
*/
Static Function Impr270E()
	Local nCopias    := mv_par12
    Local nIndex     := 0

    For nIndex := 1 To nCopias

		MSCBBEGIN(1,3)
		MSCBCHKSTATUS(.F.)
        MSCBSAY(12,1,aEtiquetas[1][1],"N","2","01,01")
		MSCBSAY(12,5,aEtiquetas[1][2],"N","2","01,01")
		MSCBSAY(12,10,aEtiquetas[1][3],"N","2","01,01")
		MSCBSAY(12,15,aEtiquetas[1][4],"N","2","01,01")
		MSCBSAY(12,20,aEtiquetas[1][5],"N","2","01,01")
		MSCBSAY(12,25,aEtiquetas[1][6],"N","2","01,01")
		MSCBEND()

    Next

Return Nil
