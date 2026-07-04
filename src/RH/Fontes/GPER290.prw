/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "FIVEWIN.CH"
#INCLUDE "GPER290.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER290  ³ Autor ³ Equipe RH             ³ Data ³ 04/01/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de Troco                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³Data    ³ FNC            ³ Motivo da Alteraca             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Mohanad Odeh³14/03/13³M12RH01   RQ4504³Unificacao dos fontes V12.      ³±±
±±³Raquel Hager³22/10/13³M12RH01   RQ4504³Compatibilizacao V12.
±±³Jaqueline L ³11/01/2018         DRHPAG-11436 Declarando cAcessaSRR     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER290()
Local aArea	  	:= GetArea()
Local aSRHArea	:= SRH->(GetArea())
Local aSRCArea	:= SRC->(GetArea())
Local cString 	:= "SRA"  // ALIAS DO ARQUIVO PRINCIPAL (BASE)
Local aOrd    	:= {STR0001,STR0002,STR0003,STR0027}	//"Matricula"###"Centro de Custo"###"Nome"###"Centro de Custo + Nome"
Local cDesc1  	:= STR0004								//"Relat¢rio de Troco"
Local cDesc2  	:= STR0005								//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3  	:= STR0006								//"usu rio."



Private aReturn	:= {STR0007,1,STR0008,2,2,1,"",1}	//"Zebrado"###"Administra‡„o"
Private nLastKey:= 0
Private cPerg   := "GPER290"

Private aInfo    := {}
Private nChave   := 0
Private nCedulas := 0
Private cFilialSv:= ""
Private cTit     := STR0009		//"RELATORIO DE TROCO"
Private TgCed	 := {}
Private wTgCcCed := {}
Private wTgFiCed := {}
Private wTgEmCed := {}

// Variaveis utilizadas na funcao Impr
Private Colunas  := 132
Private Titulo   := STR0009		//"RELATORIO DE TROCO"
Private wCabec0  := 2
Private wCabec1  := STR0010		//"FILIAL  C.CUSTO    MAT     N O M E                                       LIQUIDO"
Private wCabec2  := ""
Private Contfl   := 1
Private Li       := 0
Private nTamanho := "M"

	Pergunte("GPER290",.F.)

	//Envia controle para SetPrint
	wnrel:="GPER290" // Nome default do relatorio em disco
	wnrel:=SetPrint(cString,wnrel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

	If nLastKey = 27
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey = 27
		Return
	EndIf

	RptStatus({|lEnd| GR290Imp(@lEnd,wnRel,cString)},Titulo)

	RestArea( aArea )
	RestArea( aSRHArea )
	RestArea( aSRCArea )


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GR290IMP ³ Autor ³ Marcos Stiefano       ³ Data ³ 24/05/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de Troco                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - Acao do Codelock                             ³±±
±±³          ³ wnRel       - Titulo do relatorio                          ³±±
±±³          ³ cString     - Mensagem			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER290                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function gr290imp(lEnd,WnRel,cString )
Local aCedula		:= {}
Local aTipMoeda		:= {}
Local aOrdBag 		:= {}
Local CCT
Local FIL
Local cChave
Local cArqMov 		:= ""
Local cAliasMov 	:= ""
Local cSvProcesso	:= ""
Local cPict1 		:=  TM(999999999,14,MsDecimais(1)) 	//"@E 999,999,999.99"
Local cPict2		:=	TM(999999999999,18,MsDecimais(1))	//"@E 999,999,999,999.99"
Local lAllProc
Local nTam
Local nResiduo
Local nTgCc
Local nTgFi
Local nTgEm
Local nTamProc		:= GetSx3Cache( "RA_PROCES", "X3_TAMANHO" )
Local X 			:= 0

Local lOfuscaNom	:= .F.
Local lOfuscaMat	:= .F.

Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), {.T., .F., {}}) //[1] Acesso; [2]Ofusca; [3]Mensagem
LOCAL aFldRel		:= {"RA_MAT", "RA_NOME"}
LOCAL aFldOfusca 	:= {}
LOCAL lOfusca		:= aOfusca[2]

Private cAcessaSRA	:= &( " { || " + ChkRH( "GPER290" , "SRA" , "2" ) + " } " )
Private cAcessaSRC	:= &( " { || " + ChkRH( "GPER290" , "SRC" , "2" ) + " } " )
Private cAcessaSRD	:= &( " { || " + ChkRH( "GPER290" , "SRD" , "2" ) + " } " )
Private cAcessaSRH	:= &( " { || " + ChkRH( "GPER290" , "SRH" , "2" ) + " } " )
Private cAcessaSRG	:= &( " { || " + ChkRH( "GPER290" , "SRG" , "2" ) + " } " )
Private cAcessaSR1	:= &( " { || " + ChkRH( "GPER290" , "SR1" , "2" ) + " } " )
Private cAcessaSRR	:= &( " { || " + ChkRH( "GPER290" , "SRR" , "2" ) + " } " )
Private aRoteiros	:= {}
Private lImprFunci  := .T.
Private lImprBenef  := .F.

IF lOfusca
	aFldOfusca 	:= FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) // CAMPOS SEM ACESSO
	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_NOME" } ) > 0
		lOfuscaNom	:= FwProtectedDataUtil():IsFieldInList( "RA_NOME" )
	ENDIF

	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_MAT" } ) > 0
		lOfuscaMat	:= FwProtectedDataUtil():IsFieldInList( "RA_MAT" )
	ENDIF
ENDIF

	// Carregando variaveis MV_PAR?? para variaveis do sistema
	nOrdem     := aReturn[8]
	// Variaveis utilizadas para parametros
	// mv_par01        //  Roteiro de Calculo
	// mv_par02        //  Processos
	// mv_par03        //  Quanto a Conta Corrente
	// mv_par04        //  Filial De
	// mv_par05        //  Filial Ate
	// mv_par06        //  Centro de Custo De
	// mv_par07        //  Centro de Custo Ate
	// mv_par08        //  Matricula De
	// mv_par09        //  Matricula Ate
	// mv_par10        //  Nome De
	// mv_par11        //  Nome Ate
	// mv_par12        //  Banco/Agencia De
	// mv_par13        //  Banco/Agencia Ate
	// mv_par14        //  Situacao
	// mv_par15        //  Categoria
	// mv_par16        //  Imprimir Sintetica/Analitica/Totais
	// mv_par17        //  C. Custo em Outra Pagina
	// mv_par18        //  Data de Pagamento De
	// mv_par19        //  Data de Pagamento Ate

	cRoteiro	:= mv_par01
	cProcesso	:= mv_par02
	cComConta  	:= If(mv_par03 == 1,"C",(If(mv_par03 == 2,"S","A")))
	cFilDe     	:= mv_par04
	cFilAte    	:= mv_par05
	cCcDe      	:= mv_par06
	cCcAte     	:= mv_par07
	cMatDe     	:= mv_par08
	cMatAte    	:= mv_par09
	cNomDe     	:= mv_par10
	cNomAte    	:= mv_par11
	cBcoDe     	:= mv_par12
	cBcoAte    	:= mv_par13
	cSituacao  	:= mv_par14
	cCategoria 	:= mv_par15
	nAnaSin    	:= mv_par16
	cSalta     	:= If(mv_par17 == 1,"S","N")
	dDataDe   	:= mv_par18
	dDataAte  	:= mv_par19

	//Desmembrar Processo e Roteiro de Calculo
	lAllProc 	:= AllTrim( cProcesso ) == "*"
	If !lAllProc
		cSvProcesso := cProcesso
		cProcesso 	:= "("
		nTam := Len(Alltrim(cSvProcesso))
		For X := 1 to nTam Step nTamProc
			cProcesso += "'" + Substr(cSvProcesso, X, nTamProc) + "',"
		Next X
		cProcesso := Substr( cProcesso, 1, Len(cProcesso)-1) + ")"
	EndIf

	// Armazena as verbas no array aRoteiros para buca de liquido
	SelecRoteiros(Nil,1)

	dbSelectArea( "SRA" )
	If nOrdem == 1
		dbSetOrder( 1 )
		cChave := cFilDe + cMatDe
		dbSeek(cChave,.T.)
		cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
		cFim    := cFilAte + cMatAte
	ElseIf nOrdem == 2
		dbSetOrder( 2 )
		cChave := cFilDe + cCcDe + cMatDe
		dbSeek(cChave,.T.)
		cInicio := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
		cFim    := cFilAte + cCcAte + cMatAte
	ElseIf nOrdem == 3
		dbSetOrder( 3 )
		cChave := cFilDe + cNomDe + cMatDe
		dbSeek(cChave,.T.)
		cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
		cFim    := cFilAte + cNomAte + cMatAte
	ElseIf nOrdem == 4
		dbSetOrder( 8 )
		cChave := cFilDe + cCcDe + cNomDe
		dbSeek(cChave, .T.)
		cInicio := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME"
		cFim    := "cFilAte + cCcAte + cNomAte"
	EndIf

	nCedulas 	:= 0
	cFilialSv 	:= Space(FWGETTAMFILIAL)
	nTgCc  		:= 0
	nTgFi   	:= 0
	nTgEm   	:= 0
	RestCc 		:= 0
	RestFil 	:= 0
	RestEmp 	:= 0

	dbSelectArea( "SRA" )
	SetRegua(SRA->(RecCount()))
	While !EOF() .And. nChave == 0

		CCT := SRA->RA_CC
		FIL := SRA->RA_FILIAL

		// Movimenta regua de processamento
		IncRegua()

		If lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		EndIf

		If SRA->RA_FILIAL # cFilialSv
			aCedula 	:= {}
			aTipMoeda	:= {}
			nCedulas	:= 0
			If 	!fInfo(@aInfo,SRA->RA_FILIAL)       .Or. ;
				!CarCedula(@aTipMoeda,@aCedula,SRA->RA_FILIAL)
				Exit
			EndIf
			TgCed 		:= Array(Len(aCedula))
			wTgFiCed	:= Array(Len(aCedula))
			wTgCcCed 	:= Array(Len(aCedula))
			aFill(wTgFiCed,0)
			If Empty(wTgEmCed)
				wTgEmCed	:= Array(Len(aCedula))
				aFill(wTgEmCed,0)
			EndIf
			dbSelectArea( "SRA" )
			cFilialSv  := SRA->RA_FILIAL
		EndIf

		// Consiste filiais e acessos
		IF !(SRA->RA_FILIAL $ fValidFil()) .OR. !Eval(cAcessaSRA)
			dbSelectArea("SRA")
	      	dbSkip()
	       	Loop
		EndIF

		If nOrdem = 1
			If SRA->RA_FILIAL > cFilAte .Or. SRA->RA_MAT > cMatAte
				Exit
			EndIf
		ElseIf nOrdem = 2
			IF SRA->RA_FILIAL > cFilAte .Or. SRA->RA_CC > cCcAte .Or. SRA->RA_MAT > cMatAte
				Exit
			EndIf
		ElseIf nOrdem = 3
			If SRA->RA_FILIAL > cFilAte .Or. SRA->RA_NOME > cNomAte .Or. SRA->RA_MAT > + cMatAte
				Exit
			EndIf
		ElseIf nOrdem = 4
		   If SRA->RA_FILIAL > cFilAte .Or. SRA->RA_CC > cCcAte .Or. SRA->RA_NOME > cNomAte
			   Exit
			EndIf
		EndIf

		aFill(wTgCcCed,0)

		While !Eof() .And. SRA->RA_FILIAL = FIL .And. If(nOrdem = 2, SRA->RA_CC = CCT, .T. )

			nValLiq 	:= 0

			If nOrdem == 1
				If SRA->RA_FILIAL + SRA->RA_MAT > cFilAte + cMatAte
					nChave := 1
					Exit
				EndIf
			ElseIf nOrdem == 2
				IF SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT  > cFilAte + cCcAte + cMatAte
					nChave := 1
					Exit
				EndIf
			ElseIf nOrdem = 3
				If SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT > cFilAte + cNomAte + cMatAte
					nChave := 1
					Exit
				EndIf
		   	ElseIf nOrdem = 4
		      If SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME > cFilAte + cCcAte + cNomAte
					nChave := 1
					Exit
				EndIf
			EndIf

			IncRegua()

			// Consiste Filiais e acessos
			If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
				dbSelectArea("SRA")
	      		dbSkip()
		       	Loop
			EndIf

			// Verifica processo do funcionario
			If !lAllProc .And. !(SRA->RA_PROCES $ cProcesso)
				dbSelectArea("SRA")
				dbSkip()
				Loop
			EndIf

			// Verifica situacao e categoria do funcionario
			If !(SRA->RA_SITFOLH $ cSituacao) .Or. !(SRA->RA_CATFUNC $ cCategoria)
				dbSelectArea("SRA")
				dbSkip()
				Loop
			EndIf

			// Consiste parametrizacao do intervalo de impressao
			If (SRA->RA_BCDEPSA < cBcoDe) .Or. (SRA->RA_BCDEPSA > cBcoAte) .Or. ;
			   (SRA->RA_NOME < cNomDe)    .Or. (SRA->RA_NOME > cNomAte)    .Or. ;
			   (SRA->RA_MAT < cMatDe)     .Or. (SRA->RA_MAT > cMatAte)     .Or. ;
			   (SRA->RA_CC < cCcDe)       .Or. (SRA->RA_CC > cCCAte)
				dbSelectArea("SRA")
				dbSkip()
				Loop
			EndIf

			// Verifica a opcao de Conta Corrente selecionada
			If (cComconta = "C" .And. SRA->RA_CTDEPSA = Space(Len(SRA->RA_CTDEPSA))) .Or.;
				(cComconta = "S" .And. SRA->RA_CTDEPSA # Space(Len(SRA->RA_CTDEPSA)))
				dbSelectArea("SRA")
				dbSkip()
				Loop
			EndIf

			// Busca valores de Liquido e Beneficios
			Gp020BuscaLiq(@nValLiq)

			If nValLiq <= 0.00
				dbSelectArea("SRA")
				dbSkip()
				Loop
			EndIf

			// Calcula as moedas/cedulas para compor o valor
			nResiduo	:= 0
			aFill(TgCed,0)

			Calc_Ced(Round(nValLiq,2),@aCedula,@TgCed,@nResiduo)

			// Se Analitico
			If nAnaSin == 2
				Det := Space(1) + SRA->RA_FILIAL + Space(12-Len(SRA->RA_FILIAL)) + Space(1) + SRA->RA_CC + Space(9-Len(SRA->RA_CC)) + Space(7)
				Det += If(lOfuscaMat,Replicate('*',LEN(SRA->RA_MAT)),OemToAnsi(SRA->RA_MAT)) + Space(2) + If(lOfuscaNom,Replicate('*',LEN(SRA->RA_NOME)),OemToAnsi(SRA->RA_NOME)) + Space(2)
				Det += ALLTRIM(Transform(nValLiq,cPict1))
				wpri := .T.
				For X := 1 To nCedulas
					If TgCed[X] # 0
						Moed := Iif(aTipMoeda[X]="M",STR0017,STR0018)		//" MOEDA"###"CEDULA"
						Moed := Iif(TgCed[X] = 1 , Moed + " " , Moed + "S" )
						Det += If(wpri=.T. , Space(3) , Space(87) ) +Transform(TgCed[X],cPict1) + " " + Moed + " " + STR0019 + Transform(aCedula[X],cPict1)	//" DE R$  "
						Impr(Det,"C")
						Det := ""
						wpri = .F.
					EndIf
				Next X
				If wpri = .T.
					Impr(Det,"C")
				EndIf
				If nResiduo # 0.00
					Det := Space(53)+STR0020 + Transform(nResiduo,cPict1)	//"RESIDUO:     R$  "
					Impr(det,"c")
					Restcc += nResiduo
				EndIf
				Impr(Replicate("-",Colunas),"C")
			EndIf

			For X := 1 To nCedulas
				wTgCcCed[x] += TgCed[x]
				wTgFiCed[x] += TgCed[x]
				wTgEmCed[x] += TgCed[x]
				TgCed[x]    := 0
			Next X

			AFILL(TgCed,0)
			nTgCc += Round(nValLiq,2)
			dbSelectArea("SRA")
			dbSkip()
		EndDo

		// Emite por Centro de Custo / Opcao Analitico e Sintetico
		If nAnaSin < 3 .And. nOrdem = 2 .and. nTgCc > 0
			If Eof() .Or. SRA->RA_CC # CCT .Or. SRA->RA_FILIAL # FIL
				Det := STR0021 + CCT + Space(9-Len(CCT)) +" -> " + DescCc(CCT,FIL) + Space(36-Len(DescCc(CCT,FIL))) + Space(3) //"TOTAL C.CUSTO:"
				Det += Transform(nTgCc,cPict2)
				wpri := .T.
				For X := 1 to nCedulas
					If wTgCcCed[X] # 0
						Moed := iif(aTipMoeda[X]="M",STR0017,STR0018)		//" MOEDA"###"CEDULA"
						Moed := iif(wTgCcCed[X] = 1 , Moed + " " , Moed + "S")
						DeT += IF(wpri=.T.,Space(3),Space(87))+Transform(wTgCcCed[X],cPict1)+" "+Moed + " " +STR0019 + Transform(aCedula[X],cPict1)	//" DE R$  "
						Impr(Det,"C")
						Det := ""
						wpri := .F.
					EndIf
				Next X
				If wpri = .T.
					Impr(Det,"C")
				EndIf
				If RestCc # 0
					Det := Space(53)+STR0020 + Transform(RestCc,cPict1)	//"RESIDUO:     R$  "
					Impr(Det,"C")
				EndIf
				Impr(Replicate("=",Colunas),"C")
			EndIf
		EndIf
		Afill(wTgCcCed,0)
		RestFil += RestCc
		nTgFi   += nTgCc
		nTgEm   += nTgCc
		nTgCc   := 0
		If (Eof() .Or. SRA->RA_FILIAL # FIL) .and. nTgFi > 0
			DescFil := aInfo[1] + Space(15-Len(aInfo[1]))
			Det := STR0024+ FIL + Space(12-Len(Fil))+ " --> " + alltrim(DescFil) + Space(12) 	//"TOTAL DA FILIAL: "
			Det += Transform(nTgFi,cPict2)
			wpri := .T.
			For X := 1 To nCedulas
				If wTgFiCed[x] # 0
					Moed := iif(aTipMoeda[X]="M",STR0017,STR0018)	//" MOEDA"###"CEDULA"
					Moed := iif(wTgFiCed[x] = 1 , Moed + " " , Moed + "S")
					DET += IF(wpri=.T.,Space(3),Space(87))+Transform(wTgFiCed[x],cPict1)+" "+Moed+ " " + STR0019 + Transform(aCedula[X],cPict1)	//" DE R$  "
					Impr(Det,"C")
					Det := ""
					wpri := .F.
				EndIf
			Next X
			If wpri = .T.
				Impr(Det,"C")
			EndIf
			If RestFil # 0
				Det := Space(53)+STR0020 + Transform(RestFil,cPict1)	//"RESIDUO:     R$  "
				Impr(Det,"C")
			EndIf
			AFILL(wTgFiCed,0)
			Restemp += RestFil

			nTgFi  := 0
			IMPR(REPLICATE("=",COLUNAS),"C")
		EndIf

		If ( Eof() .Or. &cInicio > cFim ) .and. nTgEm > 0
			IMPR("","P")
			DET := STR0026 + " --> " + SubStr(aInfo[3]+Space(60-Len(aInfo[3])),1,42) 	//"TOTAL DA EMPRESA"
			DET += Transform(nTgEm,cPict2)
			wpri := .T.
			For X := 1 To Len(wTgEmCed)
				If wTgEmCed[X] # 0
					Moed := iif(aTipMoeda[X]="M",STR0017,STR0018)		//" MOEDA"###"CEDULA"
					Moed := iif(wTgEmCed[X]=1,Moed+" ",Moed+"S")
					DET += IF(wpri=.T.,Space(1),Space(82))+Transform(wTgEmCed[X],cPict2)+" "+Moed+ " " + STR0019 + Transform(aCedula[x],cPict1)	//" DE R$  "
					IMPR(DET,"C")
					DET := ""
					wpri := .F.
				EndIf
			Next X
			If wpri = .T.
				Impr(Det,"C")
			EndIf
			If RestEmp # 0
				Det := Space(53)+STR0020 + Transform(RestEmp,cPict1)	//"RESIDUO:     R$  "
				Impr(Det,"C")
				Restemp  := 0
			EndIf
			Impr(Replicate("=",Colunas),"C")
			Afill(wTgEmCed,0)
			nTgEm := 0
			Li    := 0
		EndIf

		dbSelectArea("SRA")
		If nOrdem = 2 .And. cSalta = "S"
			Li := 0
		EndIf
	EndDo

	Impr("","F")

	// Seleciona arquivo default do Siga caso imp. mov. anteriores
	If !Empty(cAliasMov)
		fFimArqMov(cAliasMov, aOrdBag, cArqMov)
	EndIf

	// Termino do relatorio
	dbSelectArea("SRA")
	Set Filter to
	DbSetOrder(1)
	Set Device To Screen
	If aReturn[5] = 1
		Set Printer To
		Commit
		ourspool(wnrel)
	EndIf

	MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CarCedula ³ Autor ³ Equipe RH            ³ Data ³ 24/05/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Carga das Cedulas cadastradas em Manut. Tabelas.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER290                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CarCedula(aTipMoeda,aCedula,cFil)
Local aArea	:= GetArea()
Local nx	:= 0
Local aTab	:= {}

	// Verifica existencia de tabela
	fCarrTab(@aTab,"S080")
	If !Empty(aTab)
		For nx := 1 To Len(aTab)
			If aTab[nx][6] > 0
				Aadd(aTipMoeda,	aTab[nx][5])
				Aadd(aCedula,	aTab[nx][6])
				nCedulas++
			EndIf
		Next
	Else
		Set Device To Screen
		Help(" ",1,"GR290CEDUL")  // Tabela Moedas e Cedulas nao cadastrada.
		RestArea(aArea)
		Return(.F.)
	Endif

	RestArea(aArea)

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Calc_Ced ³ Autor ³ Equipe RH             ³ Data ³ 24/05/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Calculo do valor liquido com as cedulas e moedas.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER290                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Calc_Ced(nValor,nCed,nAcum,nResto)
Local nRestante := nValor
Local mm		:= 0

	// Comparar valor com valor de cedula
	For mm = nCedulas To 1 Step -1
		If nRestante >= nCed[mm]
			nResult   := (nRestante - Mod(nRestante, nCed[mm])) / nCed[mm]
			nAcum[mm] := nAcum[mm] + nResult
			nRestante := Round(Mod(nRestante,nCed[mm]),2)
		EndIf
		If nRestante == 0.00
			Exit
		EndIf
	Next mm

	nResto := nRestante

Return(.T.)