/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER240.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QIER240	³ Autor ³ Antonio Aurelio       ³ Data ³ 04.07.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Etiqueta de Rastreabilidade            					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_QIER240(cProg)                                			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAQIE  												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ STR		 ³ Ultimo utilizado: 0011                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Vera        ³04/08/99³ÄÄÄÄÄÄ³ Inclusao funcao AjustaSX1()              ³±±
±±³Antonio     ³24/08/99³ÄÄÄÄÄÄ³ Inclusao funcao QA_AjusSX1() (QAXFUN.PRX)³±±
±±³            ³        ³      ³ Esta funcao corresponde a versao generica³±±
±±³            ³        ³      ³ da AjustaSX1                             ³±±
±±³Vera        ³23/09/99³ÄÄÄÄÄÄ³ Impressao a pertir do vetor - import. ent³±±
±±³Paulo Emidio³18/05/00³------³Retirada da Funcao de ajuste do SX1       ³±±
±±³Paulo Emidio³28/05/01³META  ³ Alterado programa para que possa ser sele³±±
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
User Function QIER240(cProg,nMv_par11,nMv_par12,aVetQEK,aGravDad,lImpFic)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se for chamado pelo cadastro Entradas ou pelo menu, nao passa o vetor com ³
//³ a chave de cada Entrada 												  ³ 
//³ Se for chamado pela importacao, passa o vetor com as Entradas para a im-  ³
//³ pressao das etiquetas. 													  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Par„metros para a fun‡„o SetPrint () 									  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel 	:= "QIER240"
Local cString	:= "QEK"
Local cDesc1	:= STR0001 //"Ser„o impressas as etiquetas de rastreabilidade "
Local cDesc2	:= STR0002 //"da Entrada."
Local cDesc3	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Guarda aquivo e indices correntes	 									  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cAlias    := Alias()
Local nOldOrder := IndexOrd()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Par„metros para a fun‡„o SetPrint	 									  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cTitulo	 := STR0003	// "Etiqueta de Rastreabilidade"
Private cTamanho := "P"
Private nPagina	 := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas pela fun‡„o SetDefault e SetPrint  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0004, 1,STR0005,  1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private nLastKey := 0
Private cPerg    := "QER240"
Private nRecno   := QEK->(Recno())
Private lEnd     := .F.
Private nLimite  := 80

Default cProg := "QIER240"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					      ³
//³ mv_par01			  // Fornecedor de					      ³
//³ mv_par02			  // Fornecedor ate		    		      ³
//³ mv_par03			  // Loja Fornecedor de	 			      ³
//³ mv_par04			  // Loja Fornecedor ate   			      ³
//³ mv_par05			  // Produto de						      ³
//³ mv_par06			  // Produto ate 					      ³
//³ mv_par07			  // Data Entrada de				      ³
//³ mv_par08              // Data Entrada ate                     ³
//³ mv_par09              // Lote de                              ³
//³ mv_par10              // Lote ate                             ³
//³ mv_par11              // Assumir Tam.Lote                     ³
//³ mv_par12              // N§ de Etiquetas se Nao Usar Tam.Lote ³
//³ mv_par13              // Considera Entradas? 1)Normal		  ³
//³           		      //  					 2)Beneficiamento ³
//³            			  //  					  3)Devolucao     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

If cProg $ "QIEA200.QIER220"	// Cad.Entradas ou importacao Entradas
	mv_par11 := nMv_par11
	mv_par12 := nMv_par12                                        
	mv_par13 := 1
	cPerg    := ""  // Desabilita a pergunte
Else
	mv_par13 := 1
EndIf

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Assume valores caso usu rio nao digite ou digite zero ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IIF(mv_par11<1,mv_par11:=1,)
IIF(mv_par12<1,mv_par12:=1,)

IIF(cProg== NIL, cProg := "",)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 				  		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,cTamanho,"",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se apertou o botao cancela ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey == 27
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Return .F.
EndIf

RptStatus({|lEnd| A240Imp(@lEnd,wnRel,cString,cProg,aVetQEK,aGravDad,lImpFic)},cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura o arq anterior             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAlias)
dbSetOrder(nOldOrder)
dbGoto(nRecNo)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ A240Imp  ³ Autor ³ Antonio Aurelio       ³ Data ³ 04.05.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime as Etiquetas dos Produtos da Entrada               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd  - Verifica se o foi cancelada a impressao            ³±±
±±³			 ³ wnRel - Usada na fun‡Æo OurSpool                           ³±±
±±³			 ³ cProg - Usada na verifica‡Æo do prmg chamador desta fun‡Æo ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ QIER240                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A240Imp(lEnd,wnRel,cString,cProg,aVetQEK,aGravDad,lImpFic)
Local lImp	   := .T.
Local nOrdQEK  := QEK->(IndexOrd())
Local nIEnt	   := 0
Local cIndex1			:= ""
Local cFiltro			:= ""
Local cKey				:= ""

Private nLin  := 0
Private cTamLot  := ""

SetPrc(00,00)

dbSelectArea("QEK")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao a partir do menu de Relatorios ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !cProg $ "QIEA200.QIER220"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Indice Condicional nos arquivos utilizados ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cIndex1 := CriaTrab( Nil, .F. )

	cKey:=IndexKey()
	cFiltro := 'QEK_FILIAL == "'+xFilial("QEK") +'"'
	cFiltro += '.And. QEK_FORNEC >="'+mv_par01+'".And. QEK_FORNEC <="'+mv_par02+'".And.'
	cFiltro += 'QEK_LOJFOR >="'+mv_par03+'".And. QEK_LOJFOR <="'+mv_par04+'".And.'
	cFiltro += 'QEK_PRODUT >="'+mv_par05+'".And. QEK_PRODUT <="'+mv_par06+'".And.'
	cFiltro += 'DTOS(QEK_DTENTR) >="'+DTOS(mv_par07)+'".And.DTOS(QEK_DTENTR) <="'+DTOS(mv_par08)+'".And.'
	cFiltro += 'QEK_LOTE >="'+mv_par09+'".And. QEK_LOTE <="'+mv_par10+'"'

	//Filtra o tipo da Entrada
	If mv_par13 == 1
		cFiltro += ' .And. (QEK_TIPONF == "N"'+'.Or.QEK_TIPONF == " ")'
	ElseIf mv_par13 == 2
		cFiltro += ' .And. QEK_TIPONF == "B"'
	ElseIf mv_par13 == 3
		cFiltro += ' .And. QEK_TIPONF == "D"'
	EndIf	

	IndRegua("QEK",cIndex1,cKey,,cFiltro,STR0006)	//"Selecionando Registros.."
	nIndex := RetIndex("QEK")

 	dbSetOrder(nIndex+1)
	dbSeek( xFilial( "QEK" ) )
			
	A240ImEt(lEnd,wnRel,cString,cProg)

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
		A240ImEt(lEnd,wnRel,cString,cProg)

	Else

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao a partir da importacao de Entradas ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbselectArea("QEK")
		Dbsetorder(14)
		For nIEnt := 1 To Len(aVetQEK)
            //If !lImpFic  
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
						mv_par12 := Int(SuperVal(cTamLot)) + 1
					EndIf
				EndIf
				lImp := .T.
				A240ImEt(lEnd,wnRel,cString,cProg)
			EndIf
		Next
	EndIf
EndIf

RetIndex("QEK")                                         
Set Filter to
dbSelectArea("QEK")
dbSetOrder(nOrdQEK)
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ A240ImEt ³ Autor ³ Antonio Aurelio       ³ Data ³ 04.05.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime as Etiquetas dos Produtos da Entrada               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd  - Verifica se o foi cancelada a impressao            ³±±
±±³			 ³	wnRel - Usada na fun‡Æo OurSpool                          ³±±
±±³			 ³	cProg - Usada na verifica‡Æo do prmg chamador desta fun‡Æo³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ A240Imp                                         			  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A240ImEt(lEnd,wnRel,cString,cProg)
Local cFor		 := ""
Local cLojFor	 := ""
Local nC         := 0
Local cChaveQEK1 := ""
Local nDias      := 0
Local nOrdQE6	 := QE6->(IndexOrd())
Local nOrdSAH	 := SAH->(IndexOrd())
Local nSaltPag   := 0
Local oPrint
Local oFont06
Local cNF
Local nEtiqueta  
Local lin := 80
Local cSerie

oFont06		:= TFont():New("Arial",06,08,,.F.,,,,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ N§ de Etiquetas a serem impressas    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !cProg $ "QIEA200.QIER220"
	SetRegua(RecCount())  // Depende da selecao feita na pergunte
Else
	If mv_par11 == 1 // Assume o tamanho do lote
		SetRegua( mv_par12 * RecCount() )
	Else
        SetRegua(mv_par12)  // S¢ o tamanho especificado
	EndIf
EndIf


dbSelectArea("QEK")

oPrint := TMSPrinter():New("")
oPrint:SetPortrait()

While QEK->(!Eof()) .And. xFilial("QEK") == QEK->QEK_FILIAL .And. ;
		QEK->QEK_FORNEC >= mv_par01 .And. QEK->QEK_FORNEC <= mv_par02 .And.;
		QEK->QEK_LOJFOR >= mv_par03 .And. QEK->QEK_LOJFOR <= mv_par04 .And.;
		QEK->QEK_PRODUT >= mv_par05 .And. QEK->QEK_PRODUT <= mv_par06 .And.;
		QEK->QEK_DTENTR >= mv_par07 .And. QEK->QEK_DTENTR <= mv_par08 .And.;
		QEK->QEK_LOTE   >= mv_par09 .And. QEK->QEK_LOTE   <= mv_par10

   	IncRegua()

	cChaveQEK1 := QEK->QEK_PRODUT+Inverte(QEK->QEK_REVI)
	cFor	   := QEK->QEK_FORNEC
	cLojFor	   := QEK->QEK_LOJFOR

	dbSelectArea("QE6")
	dbSetOrder(1)
	dbSeek(xFilial("QE6")+cChaveQEK1)

	If QE6->(!Found())
		Set Device to Screen
		Help(" ",1,"QE_NAOPRRV",,AllTrim(QEK->QEK_PRODUT)+" / "+QEK->QEK_REVI,2,1) // "Produto/Revisao nao cadastrados:
		Set Device to Printer
		dbSelectArea("QEK")
		QEK->(dbSkip())
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

	If !cProg $ "QIEA200.QIER220"
		If mv_par11 == 1  // Assume o Tam. do Lote
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
	EndIf

	If mv_par11 == 1	
		nEtiqueta:= Int(SuperVal(cTamLot))
	Else	
		nEtiqueta:= mv_par12
    Endif
    
	oPrint:StartPage() 		

	For nC := 1 To mv_par12

	   If lEnd
			nLin := nLin + 1
			@ nLin ,001 PSAY STR0007  // "CANCELADO PELO OPERADOR"
			Exit
		EndIf

		nSaltPag:= nSaltPag + 1

		oPrint:Say(lin,0020,STR0010,oFont06)// Rastreabilidade        		
		lin += 30 

		//           R A S T R E A B I L I D A D E
		//Produto....: 0123456789012345 - XX
		//              XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		//Data Entreg: 99/99/9999 Lote.....: 0123456789012345
		//Validade...: 99/99/9999 Tam.Lote.: 012345678 XXXXXXXXX
		//Nota Fiscal: 0123456789012 012
		// 			1			 2 		  3			4			 5 		  6			7			 8 		  9			10 		 11		  12			13
		//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

		//Produto
		oPrint:Say(lin,0020,Pad(AllTrim(TitSx3("QEK_PRODUT")[1]),11,".")+": "+AllTrim(QEK->QEK_PRODUT)+" - "+QEK->QEK_REVI,oFont06)        
		lin += 30
		oPrint:Say(lin,0140,QE6->QE6_DESCPO,oFont06)        		
		lin += 30 

		//Data Entrega + Lote
		oPrint:Say(lin,0020,Pad(AllTrim(TitSx3("QEK_DTENTR")[1]),11,".")+":  "+Dtoc(QEK->QEK_DTENTR)+"  "+Pad(AllTrim(TitSx3("QEK_LOTE")[1]),10,".")+" : "+QEK->QEK_LOTE,oFont06)        
		lin += 30 

        //Validade
		SAH->(dbSetOrder(1))
		SAH->(dbSeek(xFilial("SAH")+QEK->QEK_UNIMED))
		QEL->(dbSetOrder(1))
		If QEL->(dbSeek(xFilial("QEL")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE+Space(6)))
			If !Empty(SAH->AH_UMRES)
				oPrint:Say(lin,0020,STR0011+"    "+Dtoc(QEL->QEL_DTVAL )+"  "+Pad(AllTrim(TitSx3("QEK_TAMLOT")[1]),10,".")+":  "+QEK->QEK_TAMLOT+" "+SAH->AH_UMRES,oFont06)        
			Else
				oPrint:Say(lin,0020,STR0011+"    "+Dtoc(QEL->QEL_DTVAL )+"  "+Pad(AllTrim(TitSx3("QEK_TAMLOT")[1]),10,".")+":  "+QEK->QEK_TAMLOT,oFont06)        
			Endif				
	    Else
			If !Empty(SAH->AH_UMRES)
				oPrint:Say(lin,0020,STR0011+"    "+Dtoc(QEK->QEK_DTENTR + nDias)+"  "+Pad(AllTrim(TitSx3("QEK_TAMLOT")[1]),10,".")+":  "+QEK->QEK_TAMLOT+" "+SAH->AH_UMRES,oFont06)        
			Else
				oPrint:Say(lin,0020,STR0011+"    "+Dtoc(QEK->QEK_DTENTR + nDias)+"  "+Pad(AllTrim(TitSx3("QEK_TAMLOT")[1]),10,".")+":  "+QEK->QEK_TAMLOT,oFont06)        
			Endif	
	    Endif
		lin += 30                  

		//NF
		cSerie:= SerieNfId("QEK",3,"QEK_SERINF")
		If !Empty(QEK->(&cserie))
			 cNF:= Pad(AllTrim(TitSx3("QEK_NTFISC")[1]),11,".")+": "+AllTrim(QEK->QEK_NTFISC)+" - "+QEK->(&cserie)
		Else
		     cNF:= Pad(AllTrim(TitSx3("QEK_NTFISC")[1]),11,".")+": "+AllTrim(QEK->QEK_NTFISC)
		EndIf
		oPrint:Say(lin,0020,cNF,oFont06)        
		lin += 30 
        
		If lin > 2500  
			oPrint:EndPage() 		
			lin := 80
			nSaltPag:= 0
		Else
			If nSaltPag == nEtiqueta // Pula de Pagina de acordo com o numero de etiquetas 
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

	QEK->(dbSkip())

	If lEnd
		Exit
	EndIf

EndDo

oPrint:Preview()  	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura os ¡ndices dos arq. usados  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QE6")
dbSetOrder(nOrdQE6)
dbSelectArea("SAH")
dbSetOrder(nOrdSAH)

Return 
