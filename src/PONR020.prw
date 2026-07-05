/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR020.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PONR020  ³ Autor ³ R.H. - J. Ricardo     ³ Data ³ 10.04.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Totais dos codigos do ponto                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR020(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Leandro Dr. ³14/04/14³      ³Retirada de ajustes, database e FieldPos  ³±±
±±³            ³        ³      ³que nao serao utilizados na P12.		  ³±±
±±³Luis Artuso ³08/07/14³TPUWQD³Ajuste para imprimir os eventos autoriza- ³±±
±±³            ³        ³      ³quando houver troca de turno entre matri- ³±±
±±³            ³        ³      ³culas.                                	  ³±±
±±³Wag Mobile  ³14/11/14³TQWNQ0³Ajuste para carregar Horas Extras nao some³±±
±±³            ³        ³      ³nte quando há a quebra de filial,  mas  se³±±
±±³            ³        ³      ³houver quebra de turno também.   	      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR020()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1  := STR0001  // 'Totais dos Codigos do Ponto'
Local cDesc2  := STR0002  // 'Ser  impresso de acordo com os parametros solicitados pelo'
Local cDesc3  := STR0003  // 'usuario.'
Local cString := 'SRA' //-- Alias do arquivo principal (Base)
Local aOrd    := {STR0004 , STR0005 , STR0006 , STR0007 , STR0028  } // 'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo+Nome'
Local wnRel   := ''
Local aRegs   := {}
Local nFor	    := 0.00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0008 , 1, STR0009 , 2, 2, 1, '', 1} // 'Zebrado'###'Administra‡„o'
Private nomeprog := 'PONR020'
Private aLinha   := {}
Private nLastKey := 0
Private cPerg    := 'PNR020'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo   := OemToAnsi(STR0011 ) // 'Codigos do Ponto'
Private cCabec   := Titulo
Private AT_PRG   := 'PONR020'
Private wCabec0  := 1
Private wCabec1  := ''
Private CONTFL   := 1
Private LI       := 0
Private nTamanho := 'P'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nOrdem
Private aInfo := {}
Private aEmpP := {} //-- Empresa
Private aEmpD := {}
Private aFilP := {} //-- Filial
Private aFilD := {}
Private aCcP  := {} //-- Centro de Custo ou turno
Private aCcD  := {}
Private aFunP := {} //-- Funcionario
Private aFunD := {}
Private lRoda := .F.

Begin Sequence

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte(cPerg, .F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnRel := 'PONR020' //-- Nome Default do relatorio em Disco
	wnRel := SetPrint(cString, wnRel, cPerg, @Titulo, cDesc1, cDesc2, cDesc3, .F., aOrd,,nTamanho)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordem do Relatorio                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nOrdem		:= aReturn[8]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carregando variaveis MV_PAR?? para Variaveis do Sistema.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	FilialDe	:= MV_PAR01										//  Filial  De
	FilialAte	:= MV_PAR02										//  Filial  Ate
	CcDe		:= MV_PAR03										//  Centro de Custo De
	CcAte		:= MV_PAR04										//  Centro de Custo Ate
	TurDe		:= MV_PAR05										//	Turno De
	TurAte		:= MV_PAR06										//	Turno Ate
	MatDe		:= MV_PAR07										//  Matricula De
	MatAte		:= MV_PAR08										//  Matricula Ate
	NomDe		:= MV_PAR09										//  Nome De
	NomAte		:= MV_PAR10										//  Nome Ate
	cSit		:= MV_PAR11										//  Situacao
	cCat		:= MV_PAR12										//  Categoria
	lSalta		:= IF(MV_PAR13 == 1, .T., .F.)					//  Imprime C.C em outra Pagina
	lImpDia		:= IF(MV_PAR14 == 1, .T., .F.)					//  Imprime Dia a Dia
	cSinAna		:= IF(MV_PAR15 == 1, "A", "S")					//  Sintetico ou Analitico
	lImpAbon	:= IF(MV_PAR16 == 1, .T., .F.)					//  Imprime Abonados
	cTipCod		:= StrZero(MV_PAR17,1)							//  Imprime Autorizados/N.Autorizados/Ambos
	dIniPer		:= MV_PAR18										//  Periodo Inicial
	dFimPer		:= MV_PAR19										//  Periodo Final
	lImpAcum	:= IF(MV_PAR20 == 1 , .F. ,.T.)					//  Impressao (Movimento/Acumulado)
	lTodos		:= IF(MV_PAR21 == 1 , .T. ,.F.)					//  Listar Eventos
	cEventos	:= ""
	For nFor := 1 To 60 Step 3
		IF !Empty( Subst( MV_PAR22 , nFor , 3 ) )
			cEventos += ( Subst( MV_PAR22 , nFor , 3 ) + "/" )	//  Eventos a Listar
		EndIF
	Next nFor
    For nFor := 1 To 60 Step 3
		IF !Empty( Subst( MV_PAR23 , nFor , 3 ) )
			cEventos += ( Subst( MV_PAR23 , nFor , 3 ) + "/" )	//  Continuacao dos Eventos a Listar
		EndIF
	Next nFor

    lSexaCent  := MV_PAR24

	If	nLastKey == 27
	    Break
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Break
	Endif

    RptStatus({|lEnd| PO020Imp(@lEnd,wnRel,cString)},Titulo)

End Sequence

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PO020Imp ³ Autor ³ R.H. - J. Ricardo     ³ Data ³ 10.04.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Folha de Pagamanto                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ PO020Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³Parametros³ cString     - Mensagem                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PO020Imp(lEnd,wnRel,cString)
Local cFil 		 := ''
Local cTno 		 := ''
Local cTurno	 := ''
Local lTrocFil	 := .F.	//Variável para verificar se houve quebra de filial
Local cAcessaSRA := &("{ || " + ChkRH("PONR020","SRA","2") + "}")
Local cAcessaSPH := &("{ || " + ChkRH("PONR020","SPH","2") + "}")
Local cAcessaSPC := &("{ || " + ChkRH("PONR020","SPC","2") + "}")

cAutorizado := ""

dInicio := CtoD('  /  /  ')
dFim    := CtoD('  /  /  ')

 If lImpAcum
	dInicio := dIniPer
	dFim	  := dFimPer
Else
	//-- Parƒmetro MV_PAPONTA
	If !PerAponta(@dInicio,@dFim)
		Return
	Endif
Endif

dbSelectArea( "SRA" )
dbGoTop()
DbSetOrder(nOrdem)
If nOrdem == 1
	dbSeek(FilialDe + MatDe,.T.)
   cInicio  := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim     := FilialAte + MatAte
ElseIf nOrdem == 2
	dbSeek(FilialDe + CcDe + MatDe,.T.)
   cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim     := FilialAte + CcAte + MatAte
ElseIf nOrdem == 3
	dbSeek(FilialDe + NomDe + MatDe,.T.)
   cInicio  := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim     := FilialAte + NomAte + MatAte
ElseIf nOrdem == 4
   dbSeek(FilialDe + TurDe,.T.)
   cInicio  := "SRA->RA_FILIAL + SRA->RA_TNOTRAB"
   cFim     := FilialAte + TurAte
ElseIf nOrdem == 5
	dbSetOrder(8)
	dbSeek(FilialDe + CcDe + NomDe,.T.)
	cInicio  := 'SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME'
	cFim     := FilialAte + CcAte + NomAte
Endif

SetRegua(SRA->(RecCount()))

cFilAnterior := Replicate("@", FWGETTAMFILIAL)
cCcAnt       := Replicate("@", GetSx3Cache("RA_CARGO", "X3_TAMANHO"))
cTurnoAnt    := Replicate("@", GetSx3Cache("RA_CARGO", "X3_TAMANHO"))

dbSelectArea('SRA')

While !EOF() .And. &cInicio <= cFim

	IncRegua()

	If lEnd
		IMPR(cCancela,"C")
		Exit
	EndIF

	lTrocFil := .F.

	IF SRA->RA_FILIAL != cFilAnterior
		lTrocFil := .T.
       If cFilAnterior != Replicate("@", FWGETTAMFILIAL)
			fImpFil()    // Totaliza Filial
	   Endif
  	   cFilAnterior := SRA->RA_FILIAL
  	   If ! fInfo(@aInfo,Sra->ra_FILIAL)
          Exit
       Endif
       cAutorizado := ""
       dbSelectArea("SP9")
	   dbSetOrder(1)
       If ! DbSeek((cFilAnterior,xFilial("SP9")))
      	  If ! DbSeek(Space(FWGETTAMFILIAL))
            Exit
          Endif
       Endif
       cFilCompara := SP9->P9_FILIAL
       While ! Eof() .AND. SP9->P9_FILIAL = cFilCompara
      	    If Subs(P9_IDPON,4,1) = "A"
               cAutorizado += P9_CODIGO+"A"
            Endif
            DbSkip()
       EndDo

	   //-- Varre o SP6 (Abonos)
	   Do While !SP6->(Eof())
		  If !Empty(SP6->P6_Evento)
			 If SP9->( dbSeek(xFilial('SP9', SRA->RA_FILIAL)+SP6->P6_EVENTO, .F.) )
				cAutorizado += SP6->P6_EVENTO + 'A'
			 EndIf
		  EndIf
		  SP6->(dbSkip(1))
	   Enddo

	Endif

	If	( lTrocFil ) .OR. ( SRA->RA_TNOTRAB != cTurno )	// Carregar as Horas Extras se houver quebra de filial ou de turno
		   //-- Varre o SP4 ( Horas Extras )
	   If SP4->( dbSeek( ( cFil := xFilial('SP4', SRA->RA_FILIAL) ) + ( cTno := SRA->RA_TNOTRAB ), .F.) ) .OR. ;
		  SP4->( dbSeek( ( cFil := xFilial('SP4', SRA->RA_FILIAL) ) + ( cTno := Space(3)        ), .F.) )
   		  Do While !SP4->(Eof()) .And. cFil + cTno == SP4->P4_FILIAL + SP4->P4_TURNO
			 If !Empty(SP4->P4_CodAut)
				If SP9->( dbSeek(xFilial('SP9', SRA->RA_FILIAL) + SP4->P4_CODAUT, .F.) )
				   cAutorizado += SP4->P4_CODAUT + 'A'
				EndIf
			 EndIf
			 SP4->(dbSkip(1))
		  Enddo
	   Endif
	   cTurno := SRA->RA_TNOTRAB
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SRA->( !(RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA) )
		fTestaTotal()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If (SRA->RA_Nome < NomDe) .Or. (SRA->RA_Nome > NomAte) .Or. ;
       (SRA->RA_Mat < MatDe)  .Or. (SRA->RA_Mat > MatAte)  .Or. ;
       (SRA->RA_CC < CcDe)    .Or. (SRA->RA_CC > CCAte) .OR. ;
       (Sra->RA_TNOTRAB < TurDe) .Or. (SRA->RA_TNOTRAB > TurAte)
	   fTestaTotal()
	   Loop
	Endif

    If (SRA->RA_DEMISSA < dInicio .AND. ! Empty(SRA->RA_DEMISSA))
  	   fTestaTotal()
       Loop
    Endif

    If !(SRA->RA_SitFolh $ cSit) .Or. !(SRA->RA_CatFunc $ cCat)
	   fTestaTotal()
	   Loop           // Testa Categoria e Situacao
	Endif

	If lImpAcum

	   dbSelectArea( "SPH" )
	   If dbSeek(SRA->RA_FILIAL + SRA->RA_Mat )
		  While !Eof() .And. SPH->PH_FILIAL+SPH->PH_Mat == SRA->RA_FILIAL+SRA->RA_Mat
			// Listar Apenas os Eventos Selecionados nos Parametros
		   	    IF !lTodos
				   IF ! ( IF(!Empty(SPH->PH_PDI),SPH->PH_PDI,SPH->PH_PD) $ cEventos )
				   	  dbSelectArea("SPH")
					  dbSkip()
					  Loop
				   EndIF
				EndIF
				If SPH->PH_DATA >= dInicio .And. SPH->PH_DATA <= dFim
				   If SPH->PH_QTAbono <= 0 .Or. ;
					  SPH->PH_QTAbono > 0 .And. lImpAbon

					  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					  //³ Consiste controle de acessos e filiais validas               ³
					  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					  If SPH->( !Eval(cAcessaSPH) )
						 SPH->(dbSkip())
						 Loop
					  EndIf

					  //-- C¢digos Autorizados
					  If If(!Empty(SPH->PH_PDI),SPH->PH_PDI,SPH->PH_PD) $ cAutorizado
						 If cTipCod $ '1ú3'
							fSoma(@aFunP,'SPH')
							fSoma(@aCcP ,'SPH')
							fSoma(@aFilP,'SPH')
							fSoma(@aEmpP,'SPH')
						 EndIf
					  Else //-- C¢digos n„o Autorizados
						 If cTipCod $ '2ú3'
						 	fSoma(@aFunD,'SPH')
							fSoma(@aCcD ,'SPH')
							fSoma(@aFilD,'SPH')
							fSoma(@aEmpD,'SPH')
						 EndIf
					  Endif
				   Endif
				EndIf
				dbSkip()
		  Enddo
	   Endif
	Else
		dbSelectArea( "SPC" )
		If dbSeek(SRA->RA_FILIAL + SRA->RA_Mat )
			While !Eof() .And. SPC->PC_FILIAL+SPC->PC_Mat == SRA->RA_FILIAL+SRA->RA_Mat
				// Listar Apenas os Eventos Selecionados nos Parametros
				IF !lTodos
					IF ! ( IF(!Empty(SPC->PC_PDI),SPC->PC_PDI,SPC->PC_PD) $ cEventos )
						dbSelectArea("SPC")
						dbSkip()
						Loop
					EndIF
				EndIF
				If SPC->PC_DATA >= dIniPer .And. SPC->PC_DATA <= dFimPer
					If SPC->PC_QTAbono <= 0 .Or. ;
						SPC->PC_QTAbono > 0 .And. lImpAbon

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Consiste controle de acessos e filiais validas               ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If SPC->( !Eval(cAcessaSPC) )
							SPC->(dbSkip())
							Loop
						EndIf

						//-- C¢digos Autorizados
						If If(!Empty(SPC->PC_PDI),SPC->PC_PDI,SPC->PC_PD) $ cAutorizado
							If cTipCod $ '1ú3'
								fSoma(@aFunP,'SPC')
							   	fSoma(@aCcP ,'SPC')
							    fSoma(@aFilP,'SPC')
							  	fSoma(@aEmpP,'SPC')
							EndIf
						Else //-- C¢digos n„o Autorizados
							If cTipCod $ '2ú3'
								fSoma(@aFunD,'SPC')
							  	fSoma(@aCcD ,'SPC')
							   	fSoma(@aFilD,'SPC')
							  	fSoma(@aEmpD,'SPC')
							EndIf
						Endif
					EndIf
				Endif
				dbSkip()
			Enddo
		Endif
	Endif

	If Len(aFunP) == 0 .And. Len(aFunD) == 0
		fTestaTotal()
		Loop
	Endif

	fImpFun()
	fTestaTotal()

Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime o Rodape ao Termino do Relatorio.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF lRoda
	IF Li < 58
		Li := 58
	EndIF
	Impr("","F")
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRA")
dbSetOrder(1)
Set Device To Screen
If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnRel)
Endif
MS_FLUSH()

*--------------------------------------*
Static Function fSoma(aMatriz, cAlias)
*--------------------------------------*
// 1- Matriz onde os dados estao sendo armazenados
// 2- Tipo de Arquivo "C" ou "I"
// 3- Prov/Desc/Base a ser gravado
Local cPrefix	:= ''
Local nRet      := 0
Local nVal1 	:= nVal2 := 0
Local nDia 		:= 0
Local aAbonos	:= {}
Local nLenABO	:= 0
Local nW		:= 0

cPrefix := ( PrefixoCpo( cAlias ) + "_" )

cCod := If(!Empty( (cAlias)->&(cPrefix+"PDI") ),(cAlias)->&(cPrefix+"PDI"), (cAlias)->&(cPrefix+"PD") )

If lImpDia
   nDia := (cAlias)->&(cPrefix+"DATA")
Endif

nVal1 := (cAlias)->&(cPrefix+"QUANTI")
nVal2 := (cAlias)->&(cPrefix+"QUANTC")
nRet  := aScan( aMatriz,{|X| x[1] == cCod .AND. x[4] == nDia } )   // Testa se ja existe

If	nRet == 0
    Aadd (aMatriz,{cCod,nVal1,nVal2,nDia})  // se nao cria elemento
Else                                        // se ja so adiciona
    aMatriz[nRet,2] := SomaHoras(aMatriz[nRet,2],nVal1)
    aMatriz[nRet,3] := SomaHoras(aMatriz[nRet,3],nVal2)
Endif

aAbonos:={}

//-- Adiciona Abonos … coluna de Autorizados
If cCod $ cAutorizado
	fAbonos((cAlias)->&(cPrefix+"DATA"),(cAlias)->&(cPrefix+"PD"),,@aAbonos,(cAlias)->&(cPrefix+"TPMARCA"),(cAlias)->&(cPrefix+"CC") )
	nLenABO:=Len(aAbonos)

	//-- Se Existirem Abonos
	If nLenAbo > 0
		//-- Corre Todos os Abonos e Somente Soma aqueles que tiverem eventos associados
		For nW:=1 TO nLenABO
			//-- Para Cada Abono procura pelo motivo
	    	If SP6->(dbSeek( fFilFunc('SP6') + aAbonos[nW,1], .F.))
	    	    //-- Se o motivo estiver associado a um evento soma-o
				If !Empty(SP6->P6_EVENTO)
					cCod  := SP6->P6_Evento
					nVal1 := aAbonos[nW,2]
					nVal2 := 0
					//-- Cria Elemento
					If	( nRet := aScan( aMatriz,{|X| x[1] == cCod .AND. x[4] == nDia } ) ) == 0
	    				Aadd (aMatriz,{cCod,nVal1,nVal2,nDia})
					Else //-- Adiciona Elemento
	    				aMatriz[nRet,2] := SomaHoras(aMatriz[nRet,2],nVal1)
	    				aMatriz[nRet,3] := SomaHoras(aMatriz[nRet,3],nVal2)
					Endif
				Endif
			Endif
		Next nW
	Endif
EndIf


Return Nil

*---------------------------*
Static Function fTestaTotal()      // Executa Quebras
*---------------------------*

cCcAnt  := SRA->RA_CC
cTurnoAnt := SRA->RA_TNOTRAB
cFilAnterior := SRA->RA_FILIAL

dbSelectArea( "SRA" )
dbSkip()
If	Eof() .Or. &cInicio > cFim
	fImpCc()
	fImpFil()
	fImpEmp()
Elseif cFilAnterior != SRA->RA_FILIAL
	fImpCc()
	fImpFil()
Elseif (cCcAnt != SRA->RA_Cc .AND. (nOrdem == 2 .OR. nOrdem == 5)) .Or. ;
       (cTurnoAnt != SRA->RA_TNOTRAB .AND. nOrdem == 4) .And. !Eof()
	fImpCc()
Endif
Return Nil

*---------------------*
Static Function fImpFun            // Imprime um Funcionario
*---------------------*
If	Len(aFunP) == 0 .And. Len(aFunD) == 0
	Return Nil
Endif
If cSinAna == "A"
   fImprime(aFunP,aFunD,1)
Endif
aFunP := {}
aFunD := {}
Return Nil

*--------------------*
Static Function fImpCc             // Imprime Centro de Custo
*--------------------*
If Len(aCcP) == 0 .And. Len(aCcD) == 0
	Return Nil
Endif
If nOrdem ==  2 .OR. nOrdem == 4 .Or. nOrdem == 5
   FImprime(aCcP,aCcD,2) // Imprime
Endif
aCcP := {}
aCcD := {}
Return Nil

*---------------------*
Static Function fImpFil            // Imprime Filial
*---------------------*
If  Len(aFilP) == 0 .And. Len(aFilD) == 0
	Return Nil
Endif
fImprime(aFilP,aFilD,3)
aFilP := {}
aFilD := {}
Return Nil

*---------------------*
Static Function fImpEmp            // Imprime Empresa
*---------------------*
If Len(aEmpP) == 0 .And. Len(aEmpD) == 0
	Return Nil
Endif
fImprime(aEmpP,aEmpD,4)
aEmpP := {}
aEmpD := {}

Return Nil

*-----------------------------------------------*
Static Function fImprime(aProv,aDesc,nTipo)
*-----------------------------------------------*
// nTipo: 1- Funcionario
//        2- Centro de Custo ou Turno
//		  3- Filial
//		  4- Empresa

Local nMaximo
Local nConta
Local nTAC := nTNC := 0   // Totais de Calculado
Local nTAI := nTNI := 0   // Referencias

Local aFldRot 	 := {'RA_NOME', 'RA_CODFUNC', 'RA_DESCFUN'}

Local aOfusca	 := If(FindFunction('ChkOfusca'), ChkOfusca(), {.T.,.F.}) //[1] Acesso; [2]Ofusca
Local lOfuscaNom := .F. //RA_NOME
Local lOfuscaFun := .F. //RA_CODFUNC
Local lOfuscDFun := .F. //RA_DESCFUN

Local  aFldOfusca := {}

If aOfusca[2]
	aFldOfusca := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRot ) // CAMPOS SEM ACESSO
	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_NOME" } ) > 0
		lOfuscaNom := FwProtectedDataUtil():IsFieldInList( "RA_NOME" )
	ENDIF
	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_CODFUNC" } ) > 0
		lOfuscaFun := FwProtectedDataUtil():IsFieldInList( "RA_CODFUNC" )
	ENDIF
	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_DESCFUN" } ) > 0
		lOfuscDFun := FwProtectedDataUtil():IsFieldInList( "RA_DESCFUN" )
	ENDIF
EndIf

//-- Ordenando os Arrays de Provento / Desconto
If lImpDia
	aProv := ASort (aProv,,,{|x,y| DtoS(x[4])+x[1] < DtoS(y[4])+y[1] })
	aDesc := ASort (aDesc,,,{|x,y| DtoS(x[4])+x[1] < DtoS(y[4])+y[1] })
Else
	aProv := ASort (aProv,,,{|x,y| x[1] < y[1] })
	aDesc := ASort (aDesc,,,{|x,y| x[1] < y[1] })
EndIf

nMaximo:= MAX(Len(aProv),Len(aDesc))
If	nTipo == 1
	If	Li + nMaximo + 4 >= 60	// Testa somente quando e funcionario
		Impr("","P")            // Salta Pagina caso nao caiba
	Endif
Elseif nTipo == 2
	If lSalta
		Impr("","P")
	Endif
Else
	Impr("","P")
Endif

WCabec1 := STR0012  + DTOC(dInicio) + " - " + DTOC(dFim) // "Periodo de: "

If nTipo == 1
    cDet := STR0013  + SRA->RA_FILIAL + "-" + SRA->RA_MAT + "-" + If(lOfuscaNom,Replicate('*',15),OemToAnsi(SRA->RA_NOME)) // "Func..: "
    cDet += SPACE(5) +STR0014  + SRA->RA_CHAPA // "  Chapa "
    IMPR(cDet,"C")
    cDet := STR0015  + SUBS(SRA->RA_CC+SPACE(20),1,20)+ SPACE(10) //" ### C.C.: "
    cDet += STR0016  + If(lOfuscaFun,Replicate('*',15),OemToAnsi(SRA->RA_CODFUNC)) + "-"+ If(lOfuscDFun,Replicate('*',15),OemToAnsi( DescFun(SRA->RA_CodFunc,SRA->RA_FILIAL) )) // "Funcao: "
    IMPR(cDet,"C")
    cDet := STR0017  + STR(SRA->RA_HRSMES,6,2) +STR0018  + DescCateg(SRA->RA_CATFUNC,13) // "  Hr.Mes: "###" Categ.: "
    cDet += STR0019  + SRA->RA_TNOTRAB // "Tur.: "
Elseif nTipo == 2 .and. (nOrdem == 2 .Or. nOrdem == 5)
    cDet:= STR0020  + cFilAnterior + STR0021  + cCcAnt + DescCc(cCcAnt,SRA->RA_FILIAL) // "Filial: "###" C.Custo: "
Elseif nTipo == 2 .and. nOrdem == 4
    cDet:= STR0020  + cFilAnterior + STR0022  + cTurnoAnt  // "Filial: "###" Turno: "
Elseif nTipo == 3
    cDet:= STR0020  + cFilAnterior + " " + aInfo[1] // "Filial: "
Elseif nTipo == 4
    cDet:= STR0023  + Sm0->m0_Nomecom // "Empresa: "
Endif
IMPR(cDet,"C")

IMPR("","C")

cDet:= SPACE(10)+STR0024 +SPACE(15)+STR0025  // "A U T O R I Z A D O"###"N A O   A U T O R I Z A D O"
IMPR(cDet,"C")
IMPR(Repl("-",80),"C")

/*
|DD COD DESCRICAO        Calc.    Infor.|DD Cod Descricao        Calc.    Infor.
|99 XXX 123456789012 999999.99 999999.99|99 XXX 123456789012 999999.99 999999.99
*/

cDet := If(lImpDia,"DD","  ")+STR0026  // " Cod Descricao        Calc.    Infor.|"
cDet += If(lImpDia,"DD","  ")+STR0027  // " Cod Descricao        Calc.    Infor."
//       DD 123 123456789012 999999.99 999999.99
IMPR(cDet,"C")

For nConta :=1 To nMaximo
    cDet := If (nConta > Len(aProv),Space(39),If(ValType(aProv[nConta,4])#'D','  ',;
            StrZero(Day(aProv[nConta,4]),2)) + ' ' + ;
            aProv[nConta,1]+" "+Left(DescPdPon(aProv[nConta,1]),12)+" "+;
            Transform(If( lSexaCent==2, fConvHr(aProv[nConta,3],'D'), aProv[nConta,3] ),'999999.99' )+" "+;
            Transform(If( lSexaCent==2, fConvHr(aProv[nConta,2],'D'), aProv[nConta,2] ),'999999.99' ))+"|"
    cDet += If(nConta > Len(aDesc),Space(39),If(ValType(aDesc[nConta,4])#'D','  ',;
            StrZero(Day(aDesc[nConta,4]),2)) + ' ' + ;
            aDesc[nConta,1]+" "+Left(DescPdPon(aDesc[nConta,1]),12) + ' ' + ;
            Transform(If( lSexaCent==2, fConvHr(aDesc[nConta,3],'D'), aDesc[nConta,3] ),'999999.99' ) + ' ' + ;
            Transform(If( lSexaCent==2, fConvHr(aDesc[nConta,2],'D'), aDesc[nConta,2] ),'999999.99' ))
    Impr(cDet,'C')
NEXT

IMPR(Repl("-",80),"C")

If nTipo # 1
    IMPR(REPL("=",80),"C")   // Salta Pagina apos Quebra Cc/Filial/Empresa
	If nTipo # 2 .Or. (nTipo == 2 .And. lSalta)
		Impr("","P")
	Else
		Impr("","C")
	Endif
Endif

lRoda := .T.

Return( NIL )