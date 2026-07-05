/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER420.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER420  ³ Autor ³ R.H. - Fernando Joly  ³ Data ³ 16.09.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Termo de Responsabilidade                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER420(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Cecilia C. ³20/05/14³TPQAJ1³Incluido o fonte da 11 para a 12 e efetua-³±±
±±³            ³        ³      ³da a limpeza.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER420()
	Local cDesc1		:= STR0001				//'Termo de Responsabilidade'
	Local cDesc2		:= STR0002				//'Ser  impresso de acordo com os parametros solicitados pelo'
	Local cDesc3		:= STR0003				//'usuario.'
	Local cString		:= 'SRA' 					// Alias do arquivo principal (Base)
	Local aOrd			:= {STR0004,STR0005} 	//'Matricula'###'Centro de Custo'

	Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
	Local aMsg			:= aOfusca[3]
	Local aFldRel		:= {"RA_NOME","RA_NUMCP","RA_SERCP","RA_RG","RB_NOME"}
	Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )

	Private aReturn		:= {STR0006,1,STR0007,2,2,1,'',1 }	//'Zebrado'###'Administra‡„o'
	Private NomeProg	:= 'GPER420'
	Private aLinha		:= {}
	Private nLastKey	:= 0
	Private cPerg		:= 'GPR420'
	Private Li			:= 0
	Private nVezes		:= 0
	Private aInfo		:= {}
	Private aDepend		:= {}
	Private lEnd		:= .F.
	Private cFilAnte	:= Replicate("ú", FWGETTAMFILIAL)
	Private aDescri		:= { {' ',' '},{' ','B'},{'E','N'},{'E','F'},{'I','C'},;
							{'I','A'},{'R','I'},{'O','S'},{' ',' '},{' ',' '} }

	If !lBlqAcesso

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica as perguntas selecionadas                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		pergunte('GPR420',.F.)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utinLizadas para parametros                        ³
		//³ mv_par01        //  FiLial De                                ³
		//³ mv_par02        //  FiLial Ate                               ³
		//³ mv_par03        //  Matricula De                             ³
		//³ mv_par04        //  Matricula Ate                            ³
		//³ mv_par05        //  Centro De Custo De                       ³
		//³ mv_par06        //  Centro De Custo Ate                      ³
		//³ mv_par07        //  N§ de Vias                               ³
		//³ mv_par08        //  Data                                     ³
		//³ mv_par09        //  Situacao                                 ³
		//³ mv_par10        //  Imp.Func.S/Depend.                       |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		cTit := STR0008		//' TERMO DE RESPONSABILIDADE '

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Envia controle para a funcao SETPRINT                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		WnRel :='GPER420' //-- Nome Default do relatorio em Disco.
		WnRel :=SetPrint(cString,WnRel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,'P')

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nOrdem  := aReturn[8]
		If(Len(AllTrim(MV_PAR01)) > 0,cFilDe :=mv_par01,cFilDe :=replicate("0", FWGETTAMFILIAL))
		If(Len(AllTrim(MV_PAR02)) > 0,cFilAte:=mv_par02,cFilAte:=replicate("9", FWGETTAMFILIAL))
		If(!Empty(mv_par03),cMatDe := mv_par03,cMatDe :='00000')
		If(!Empty(mv_par04),cMatAte:= mv_par04,cMatAte:='99999')
		If(!Empty(mv_par05),cCCDe := mv_par05,cCCDe :='0        ')
		If(!Empty(mv_par06),cCCAte:= mv_par06,cCCAte:='999999999')
		If(!Empty(mv_par07),nVias:= If(mv_par07<=0,1,mv_par07),nVias:= 1)
		If(!Empty(mv_par08),dDtBase := If(Empty(mv_par08),dDataBase,mv_par08),dDtBase:=dDataBase)
		cSit     := mv_par09
		Titulo  	:= STR0009	//'TERMO DE RESPONSABILIDADE'

		lSemDep	:= If( mv_par10 == 1 , .T. , .F. )	//  Imprime Funcion rio sem Dependente

		If nLastKey == 27
			Return Nil
		Endif

		SetDefault(aReturn,cString)

		If nLastKey == 27
			Return Nil
		Endif

		RptStatus({|lEnd| GR420Imp(@lEnd,WnRel,cString)},titulo)
	Else
		Help(" ",1,aMsg[1],,aMsg[2],1,0)
	Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ GPER420  ³ Autor ³ R.H. - Fernando Joly  ³ Data ³ 16.09.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Termo de Responsabilidade                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER420(lEnd,WnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ WnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GR420Imp(lEnd,WnRel,cString)

Local cAcessaSRA  := &("{ || " + ChkRH("GPER420","SRA","2") + "}")
Local cTitDoc    := ""
Local nLimSF1	  := 14
Local nLimSF2    := -9999
Local nX
Local nY
Local nZ
Local nLen

If cPaisLoc <> "BRA"
	nLimSF1	:=	18
	If cPaisLoc == "CHI"
		nLimSF2	:=	24
	Endif
Endif

dbSelectArea( "SRA" )

If nOrdem == 1
   dbSetOrder( 1 )
   dbSeek(cFilDe + cMatDe,.T.)
   cInicio  := "SRA->RA_FILIAL + SRA->RA_MAT"
   cFim     := cFilAte + cMatAte
ElseIf nOrdem == 2
   dbSetOrder( 2 )
   dbSeek(cFilDe + cCcDe + cMatDe,.T.)
   cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
   cFim     := cFilAte + cCcAte + cMatAte
Endif

dbSelectArea( "SRA" )
SetRegua(RecCount())

While ! Eof() .And. &cInicio <= cFim
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Incrementa Regua de Processamento.                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Aborta Impresao ao se clicar em cancela						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lEnd
		@ Prow()+1, 0 pSay cCancela
		Chave := 1
		Exit
	EndIF
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa Quebra de Filial.                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SRA->RA_FILIAL # cFilAnte
		If	!fInfo(@aInfo,SRA->RA_FILIAL)
			dbSelectArea( "SRA" )
			dbSkip()
			Loop
		Endif
		cFilAnte := SRA->RA_FILIAL
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Situacao Funcionario                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If	!(SRA->RA_SITFOLH $ cSit)
		dbSelectArea( "SRA" )
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametriza‡Æo do Intervalo de ImpressÆo.           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_Filial < cFilDe) .Or. (SRA->RA_FILIAL > cFilAte) .Or. ;
		(SRA->RA_MAT < cMatDe)    .Or. (SRA->RA_MAT > cMatAte) .Or. ;
		(SRA->RA_CC < cCcDe)      .Or. (SRA->RA_CC > cCCAte)
		dbSelectArea( "SRA" )
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		dbSelectArea( "SRA" )
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pesquisa no arquivo de Dependentes.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SRB->(dbSeek(SRA->RA_Filial+SRA->RA_Mat,.F.))
		Do While SRB->RB_FILIAL+SRB->RB_MAT == SRA->RA_FILIAL+SRA->RA_MAT
			If (SRB->RB_TipSf == '1') .Or. ;
				(SRB->RB_TipSf == '2' .And. Year(dDtBase) - Year(SRB->RB_DtNasc) <= nLimSF1 .And. SRB->RB_DTBAIXA == CtoD('  /  /  ')) .Or.;
				(SRB->RB_TipSf == '3' .And. Year(dDtBase) - Year(SRB->RB_DtNasc) <= nLimSF2 .And. SRB->RB_DTBAIXA == CtoD('  /  /  '))
				aAdd(aDepend,{Alltrim(SRB->RB_Nome), SRB->RB_DtNasc})
			EndIf
			SRB->(dbSkip())
		EndDo
	ElseIf !lSemDep
		SRA->(dbSkip(1))
		Loop
	Endif
	aSort(aDepend,,, {|X,Y| DtoS(X[2]) < DtoS(Y[2]) })
	If Len(aDepend) <= 0 .And. !lSemDep
		SRA->(dbSkip(1))
		Loop
	ElseIf Len(aDepend) < 10
		nVezes := (10 - Len(aDepend))
		For Nx := 1 to nVezes
			aAdd(aDepend,{Space(30),CtoD('  /  /  ')})
		Next Nx
	EndIf
	If Len(aDepend) > 10
		nVezes := Len(aDepend) - 10
		For Nx := 1 to nVezes
			aAdd(aDescri,{' ',' '})
		Next Nx
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas na impressao.                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cEmpresa := Left(aInfo[3],40)
	cMatEmp  := PadR(If( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ), aInfo[27], aInfo[8] ),14)
	cNome    := Left(SRA->RA_Nome,40)
	cMat     := SRA->RA_Mat
	cFil     := Right(AllTrim(SRA->RA_Filial),2)
	cCC      := Left(SRA->RA_CC,12)
	cCtps    := If(Empty(SRA->RA_NumCp), Left(SRA->RA_Rg + ' ',16), ;
					Left(SRA->RA_NumCp+'-'+SRA->RA_SerCp+'/'+SRA->RA_UfCp,16) )
	If FieldPos("RA_NUMCP") > 0 .And. !Empty(SRA->RA_NumCp)
		cTitDoc := RetTitle("RA_NUMCP")
	Else
		cTitDoc := RetTitle("RA_RG")
	Endif

	Set Device to Print
	@ Li,00 pSay AvalImp(080)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Termo de Responsabilidade (1a Parte).           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For Nx := 1 to nVias
		@ Li, 01 pSay Replicate('_',78)
		fLi()
		@ Li, 00 pSay STR0010	//'|                          TERMO DE RESPONSABILIDADE                           |'
		fLi()
		If cPaisLoc == "BRA"
			@ Li, 00 pSay STR0011	//'|        ( Concessao de Salario-Familia - Portaria No. MPAS-3.040/82 )         |'
			fLi()
		Endif
		@ Li, 00 pSay '|' + Space(78) + '|'
		fLi()
		@ Li, 00 pSay '|' + Space(78) + '|'
		fLi()
		@ Li, 00 pSay '|' + Replicate('_',78) + '|'
		fLi()
		If cPaisLoc == "BRA"
			@ Li, 00 pSay STR0012 + cEmpresa + STR0034 + cMatEmp + ' |'	//'| Empresa: '###'  | Matricula: '
			fLi()
			@ Li, 00 pSay '|' + Replicate('_',50) + '|' + Replicate('_',27) + '|'
		Else
			@ Li, 00 pSay STR0012 + cEmpresa; @ Li,79 pSay '|'
			fLi()
			@ Li, 00 pSay '|' + Replicate('_',78) + '|'
		EndIf
		fLi()
		@ Li, 00 pSay STR0013 + cMat + " - " + cNome //'| Nome do Segurado: '
		@ Li, 79 pSay '|'
		fLi()
		@ Li, 00 pSay '|' + Replicate('_',78) + '|'
		fLi()
		If cPaisLoc == "BRA"
			@ Li, 00 pSay STR0014 + cCtps + STR0015 + cFil + ' / ' + cCC +  space(12-len(cCC)) + '|'	//'| CTPS ou doc. Identidade: '###'  | Filial / C.C.: '
		Else
			@ Li, 00 pSay "| " + cTitDoc + " " + cCtps + Space(12) + STR0015 + cFil + ' / ' + cCC + '   |'	//' Titulo do CTPS ou RG no SX3 '
		Endif
		fLi()
		@ Li, 00 pSay '|' + Replicate('_',44) + '|' + Replicate('_',33) + '|'
		fLi()
		@ Li, 00 pSay STR0016	//'|   |                    Nome do Filho                    | Data do Nascimento |'
		fLi()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do Termo de Responsabilidade (Detalhe).            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For Ny := 1 to Len(aDepend)
			@ Li, 00 pSay '| '+aDescri[Ny,1]+' |' + Replicate('_',53) + '|____________________|'
			fLi()
			If Len(aDepend[Ny, 1]) <= 50
				@ Li, 00 pSay '| '+aDescri[Ny,2]+' | ' + Padr(aDepend[Ny,1], 52, " ") + '|    ' + PadR(DtoC(aDepend[Ny,2]),10) + '      |'
				fLi()
			Else
				AAdd(aDepend[Ny], SubStr(aDepend[Ny, 1], 51, 70))
				aDepend[Ny, 1] := SubStr(aDepend[Ny, 1], 01, 50)
				@ Li, 00 pSay '| '+aDescri[Ny,2]+' | ' + aDepend[Ny,1] + Space(02)+ '|    ' + PadR(DtoC(aDepend[Ny,2]),10) + '      |'
				fLi()
				nLen := (52 - Len(aDepend[Ny,3]))
				@ Li, 00 pSay '| '+aDescri[Ny,2]+' | ' + aDepend[Ny,3] + Space(nLen)+ '|    ' +  Space(10) + '      |'
				fLi()
			EndIf
		Next Ny

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do Termo de Responsabilidade (2a Parte).           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Li # 1 //-- Nao imprime o traco caso na linha acima este ja o tenha sido.
			@ Li, 00 pSay '|___|' + Replicate('_',53) + '|____________________|'
			fLi()
		EndIf

		@ Li, 00 pSay '|' + Space(78) + '|'
		fLi()
		@ Li, 00 pSay STR0017	//'|     Pelo presente  TERMO DE RESPONSABILIDADE  declaro  estar ciente  de que  |'
		fLi()
		@ Li, 00 pSay STR0018	//'|  deverei  comunicar  de  imediato  a  ocorrencia  dos  seguintes  fatos  ou  |'
		fLi()
		@ Li, 00 pSay STR0019	//'|  ocorrencias que determinem a perda do direito ao salario familia :          |'
		fLi()
		@ Li, 00 pSay '|' + Space(78) + '|'
		fLi()
		@ Li, 00 pSay STR0020	//'|     - OBITO DE FILHO ;                                                       |'
		fLi()
		@ Li, 00 pSay STR0021	//'|     - CESSACAO DE INVALIDEZ DE FILHO INVALIDO ;                              |'
		fLi()
		@ Li, 00 pSay STR0022	//'|     - SENTENCA  JUDICIAL QUE  DETERMINE O  PAGAMENTO A  OUTREM  ( casos  de  |'
		fLi()
		@ Li, 00 pSay STR0023	//'|       desquite ou separacao, abandono de filho ou perda do patrio poder ).   |'
		fLi()
		@ Li, 00 pSay '|' + Space(78) + '|'
		fLi()
		@ Li, 00 pSay STR0024	//'|     Estou ciente, ainda, de que a falta de cumprimento  ora  assumido, alem  |'
		fLi()
		@ Li, 00 pSay STR0025	//'|  de   obrigar  a   devolucao   das  importancias  recebidas  indevidamente,  |'
		fLi()
		If cPaisLoc == "BRA"
			@ Li, 00 pSay STR0026	//'|  sujeitar-me-a  as penalidades  previstas no  art. 171 do Codigo  Penal e a  |'
			fLi()
			@ Li, 00 pSay STR0027	//'|  rescisao do contrato de trabalho, por justa causa, nos  termos do art. 482  |'
			fLi()
			@ Li, 00 pSay STR0028	//'|  da Consolidacao das Leis de Trabalho.                                       |'
			fLi()
		Else
			@ Li, 00 pSay STR0035	//'|  sujeitar-me-a as penalidades previstas na lei.                              |'
			fLi()
			@ Li, 00 pSay STR0036	//'|                                                                              |'
			fLi()
			@ Li, 00 pSay STR0036	//'|                                                                              |'
			fLi()
		Endif
		@ Li, 00 pSay '|' + Space(78) + '|'
		fLi()

		If Li > 52 //-- Reinicializa a impressao, caso a linha atual seja maior que a prevista.
			nVezes := 59 - Li
			For Nz := 1 to nVezes
				@ Li, 00 pSay '|' + Space(78) + '|'
				Li ++
			Next Nz
			@ Li, 00 pSay '|' + Replicate('_',61) + STR0029		//'  continua...  __|'
			Li := 0
			@ Li, 01 pSay Replicate('_',78)
			Li ++
		EndIf

		@ Li, 00 pSay STR0030	//'|                                                           Impressao  Digital |'
		Li ++
		@ Li, 00 pSay '|______________________________________________________________________________|'
		Li ++
		@ Li, 00 pSay '|                                                         |                    |'
		Li ++
		@ Li, 00 pSay '| '+Padr(RTrim(Left(aInfo[5],20))+', '+Str(Day(dDtBase),2)+ STR0031+RTrim(FDESC_MES(Month(dDtBase)))+ STR0031+Str(Year(dDtBase),4),45)+Space(11)+'|                    |'	//' de '###' de '
		Li ++
		@ Li, 00 pSay '|                                                         |                    |'
		Li ++
		@ Li, 00 pSay '|                                                         |                    |'
		Li ++
		@ Li, 00 pSay '|                                                         |                    |'
		Li ++
		@ Li, 00 pSay '|             _________________________________           |                    |'
		Li ++
		@ Li, 00 pSay STR0032	//'|                        Assinatura                       |                    |'
		Li ++
		@ Li, 00 pSay '|' + Replicate('_',57) + '|____________________|'
		Li := 0

	Next Nx

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Reinicializa Variaveis.                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Li      := 0
	aDepend := {}
	Sra->(dbSkip(1))

EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio.                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( 'SRA' )
Set Filter to
RetIndex('SRA')
dbSetOrder(1)

Set Device To Screen
If aReturn[5] == 1
	Set Printer To
	dbCommit()
	OurSpool(WnRel)
Endif
MS_Flush()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ fLi      ³ Autor ³ R.H. - Fernando Joly  ³ Data ³ 18.09.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Incrementa a variavel Li, e salta a pagina, caso Li = 60.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fLi()                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico do programa GPER420                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fLi()

If Li >= 58
	Li ++
	@ Li, 00 pSay '|' + Replicate('_',61) + STR0033	//'  continua...  __|'
	Li := 0
	@ Li, 01 pSay Replicate('_',78)
EndIf
Li ++

Return Nil
