/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER430.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao      ³ GPER430  ³ Autor ³ RH - Fernando Joly  ³ Data ³ 16/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao   ³ Declaracao de Encargos de Familia para fins de I.R.      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso         ³ Generico                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ FNC            ³  Motivo da Alteracao           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Raquel Hager|12/04/13³M12RH01   RQ3005³Unificacao Folhas de Pagamento. ³±±
±±³Raquel Hager|22/10/13³M12RH01   RQ3005³Compatibilizacao 11.80.         ³±±
±±³Raquel Hager|10/07/14³TPZUKG          ³Inclusao de replicas eSocial.   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER430()
	// Define Variaveis Locais (Basicas)
	Local aOrd    := {STR0004,STR0005} //'Matricula'###'Centro de Custo'
	Local cDesc1  := STR0001				//'Declaracao de Encargos de Familia para fins de I.R.'
	Local cDesc2  := STR0002				//'Ser  impresso de acordo com os parametros solicitados pelo'
	Local cDesc3  := STR0003				//'usuario.'
	Local cString := 'SRA'			 		// Alias do arquivo principal (Base)
	Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
	Local aMsg			:= aOfusca[3]
	Local aFldRel		:= {"RA_NOME", "RA_NUMCP", "RA_SERCP", "RA_CIC", "RA_RG", "RB_NOME", "RA_NUMENDE", "RA_COMPLEM", "RA_BAIRRO", "RA_MUNICIP", "RA_ESTADO", "RA_CEP", "RA_SEXO"}
	Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )

	// Define Variaveis Private(Basicas)
	Private aReturn  := {STR0006,1,STR0007,2,2,1,'',1 }	//'Zebrado'###'Administra‡„o'
	Private NomeProg := 'GPER430'
	Private aLinha   := {}
	Private nLastKey := 0
	Private cPerg    := 'GPR430'
	// Variaveis Utilizadas na funcao Principal do Programa
	Private Li       := 0
	Private nVezes   := 0
	Private aInfo    := {}
	Private aDepend  := {}
	Private lEnd     := .F.
	Private cFilAnte := Replicate("ú", FWGETTAMFILIAL)

	if !lBlqAcesso
		// Verifica as perguntas selecionadas
		Pergunte('GPR430',.F.)
		// Variaveis utinLizadas para parametros
		// mv_par01        //  FiLial De
		// mv_par02        //  FiLial Ate
		// mv_par03        //  Matricula De
		// mv_par04        //  Matricula Ate
		// mv_par05        //  Centro De Custo De
		// mv_par06        //  Centro De Custo Ate
		// mv_par07        //  N§ de Vias
		// mv_par08        //  Data
		// mv_par09        //  Situacao

		cTit := STR0008		//' DECLARACAO DE ENCARGOS DE FAMILIA PARA FINS DE I.R. '

		// Envia controle para a funcao SETPRINT
		WnRel :='GPER430' //-- Nome Default do relatorio em Disco.
		WnRel :=SetPrint(cString,WnRel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,'P')

		// Carregando variaveis mv_par?? para Variaveis do Sistema.
		nOrdem  := aReturn[8]
		If(!Empty(mv_par01),cFilDe :=mv_par01,cFilDe :=replicate("0",FWGETTAMFILIAL))
		If(!Empty(mv_par02),cFilAte:=mv_par02,cFilAte:=replicate("9",FWGETTAMFILIAL))
		If(!Empty(mv_par03),cMatDe := mv_par03,cMatDe :='00000')
		If(!Empty(mv_par04),cMatAte:= mv_par04,cMatAte:='99999')
		If(!Empty(mv_par05),cCCDe := mv_par05,cCCDe :='0        ')
		If(!Empty(mv_par06),cCCAte:= mv_par06,cCCAte:='999999999')
		If(!Empty(mv_par07),nVias:= If(mv_par07<=0,1,mv_par07),nVias:= 1)
		If(!Empty(mv_par08),dDtBase := If(Empty(mv_par08),dDataBase,mv_par08),dDtBase:=dDataBase)
		cSit     := mv_par09
		lSemDep	:= If( mv_par10 == 1 , .T. , .F. )	 //  Imprime Funcion rio sem Dependente

		Titulo  := STR0009			//'DECLARACAO DE ENCARGOS DE FAMILIA PARA FINS DE I.R.'

		If nLastKey == 27
			Return Nil
		EndIf

		SetDefault(aReturn,cString)

		If nLastKey == 27
			Return Nil
		EndIf

		RptStatus({|lEnd| gr430Imp(@lEnd,WnRel,cString)},titulo)
	Else
		Help(" ",1,aMsg[1],,aMsg[2],1,0)
	Endif

Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ gr430Imp ³ Autor ³ RH - Fernando Joly    ³ Data ³ 16/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Declaracao de Enc.de Familia para fins de I.R.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_gper430(lEnd,WnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - Acao do Codelock                             ³±±
±±³          ³ WnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER430                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function gr430Imp(lEnd,WnRel,cString)
Local cAcessaSRA  := &("{ || " + ChkRH("GPER430","SRA","2") + "}")
Local cTitCGC    := '| ' + Rtrim(RetTitle("A1_CGC")) + ' '
Local cTitCIC    := Rtrim(RetTitle("RA_CIC")) + " "
Local cTitRG     := Rtrim(RetTitle("RA_RG")) + " "
Local cTitDoc    := IIf(FieldPos("RA_NUMCP")>0,RetTitle("RA_NUMCP"),"") + " "
Local cTitUF     := ""
Local nLimIR1	  := 21
Local nLimIR2	  := 24
Local cPicCGC    := Alltrim(X3Picture("A1_CGC"))
Local cPicCEP    := Alltrim(X3Picture("A1_CEP"))
Local cPicCIC    := Alltrim(X3Picture("RA_CIC"))
Local nX
Local nY
Local nZ
Local nTam1
Local nTam2
Local nTam3
Local nTam5
Local nLen

	Do Case
		Case cPaisLoc == "CHI"
			cTitUF := "| RG: "
		Otherwise
			cTitUF := STR0025
	EndCase

	If cPaisLoc <> "BRA"
		nLimIR1	  := 18
		nLimIR2	  := -9999
	EndIf

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
	EndIf

	dbSelectArea( "SRA" )
	SetRegua(RecCount())

	While ! Eof() .And. &cInicio <= cFim

		// Incrementa Regua de Processamento.
		IncRegua()

		// Aborta Impresao ao se clicar em cancela
		If lEnd
			@ Prow()+1, 0 pSay cCancela
			Chave := 1
			Exit
		EndIf

		// Processa Quebra de Filial.
		If SRA->RA_FILIAL # cFilAnte
			If	!fInfo(@aInfo,SRA->RA_FILIAL)
				dbSelectArea( "SRA" )
				dbSkip()
				Loop
			EndIf
			cFilAnte := SRA->RA_FILIAL
		Endif

		// Verifica Situacao Funcionario
		If	!(SRA->RA_SITFOLH $ cSit)
			dbSelectArea( "SRA" )
			dbSkip()
			Loop
		EndIf

		// Consiste Parametrizacao do Intervalo de Impressao.
		If (SRA->RA_Filial < cFilDe) .Or. (SRA->RA_FILIAL > cFilAte) .Or. ;
			(SRA->RA_MAT < cMatDe)    .Or. (SRA->RA_MAT > cMatAte) .Or. ;
			(SRA->RA_CC < cCcDe)      .Or. (SRA->RA_CC > cCCAte)
			dbSelectArea( "SRA" )
			dbSkip()
			Loop
		EndIf

		// Consiste controle de acessos e filiais validas
		If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
			dbSelectArea( "SRA" )
			dbSkip()
			Loop
		EndIf



		// Pesquisa no arquivo de Dependentes.
		If SRB->(dbSeek(SRA->RA_Filial+SRA->RA_Mat,.F.))
			Do While SRB->RB_FILIAL+SRB->RB_MAT == SRA->RA_FILIAL+SRA->RA_MAT
				Iif(cPaisLoc <> "EQU", cCampo:= SRB->RB_TipIr, cCampo:= SRB->RB_DepPlr)
				If AnoMes(SRB->RB_DTBAIXA) >= AnoMes(dDtBase) .Or. Empty(SRB->RB_DTBAIXA)
					If (cCampo == '1') .Or.;
						(cCampo == '2' .And. DateDiffYear(dDtBase, SRB->RB_DtNasc) <= nLimIR1) .Or. ;
						(cCampo == '3' .And. DateDiffYear(dDtBase, SRB->RB_DtNasc) <= nLimIR2)
						If SRB->RB_GrauPar	   $'C/1'
							cGrDp:= STR0010
						ElseIF SRB->RB_GrauPar $'F/2'
							cGrDp:= STR0011
						ElseIF SRB->RB_GrauPar $'E/3'
							cGrDp:= STR0059
						ElseIF SRB->RB_GrauPar $'P/4'
							cGrDp:= STR0060
						Else
							cGrDp:=STR0012
						Endif
						aAdd(aDepend,{Left(AllTrim(SRB->RB_Nome),70),cGrDp,SRB->RB_DtNasc})
					EndIf
				EndIf
				SRB->(dbSkip())
			EndDo
		ElseIf !lSemDep
			SRA->(dbSkip(1))
			Loop
		EndIf

		aSort(aDepend,,, {|X,Y| DtoS(X[3]) < DtoS(Y[3]) })

		If Len(aDepend) <= 0 .And. !lSemDep
			SRA->(dbSkip(1))
			Loop
		ElseIf Len(aDepend) < 10
			nVezes := (10 - Len(aDepend))
			For Nx := 1 to nVezes
				aAdd(aDepend,{Space(30),Space(10),CtoD('  /  /    ')})
			Next Nx
		EndIf

		// Variaveis utilizadas na impressao.
		cE_Empresa  := Left(aInfo[3],40)
		cE_Endereco := Left(aInfo[4],30)
		cE_Cidade   := Left(aInfo[5],20)
		cE_Uf       := Left(aInfo[6],2)

		If cPaisLoc == "BRA"
			cE_Cgc := If( !Empty( Len(aInfo) >= 27 .And. aInfo[27] ), aInfo[27], Transform(aInfo[8],'@R ##.###.###/####-##') )
			cE_Cep := Transform(Left(aInfo[7],8),'@R #####-###')
		Else
			cE_Cgc := Transform(Left(aInfo[8],14),cPicCGC)
			cE_Cep := Transform(Left(aInfo[7],8),cPicCEP)
		EndIf

		If cPaisLoc == "BRA" .OR. cPaisLoc == "RUS"
			cE_IE       := Left(aInfo[9],14)
			cF_Nome     := Left(SRA->RA_Nome,57)
			cF_Endereco := Left(Alltrim(SRA->RA_Enderec),30)+','+alltrim(SRA->RA_NumEnde) + '-' + Left(SRA->RA_Complem,4) + '-' //No PERU e refeito este passo inserindo 10 espacos apos o endereco
			cF_Bairro 	:= If(! Empty(SRA->RA_Bairro),Left(SRA->RA_Bairro,15),'               ')
			cF_Cidade   := Left(SRA->RA_Municip,20) + '-'
			cF_Uf       := Left(SRA->RA_Estado,2)+' '
		Else
			cE_IE       := Left(aInfo[9],14)
			cF_Nome     := Left(SRA->RA_Nome,57)
			cF_Endereco := Left(Alltrim(SRA->RA_Enderec),30)+ ',' + Left(SRA->RA_Complem,4) + '-' //No PERU e refeito este passo inserindo 10 espacos apos o endereco
			cF_Bairro 	:= If(! Empty(SRA->RA_Bairro),Left(SRA->RA_Bairro,15),'               ')
			cF_Cidade   := Left(SRA->RA_Municip,20) + '-'
			cF_Uf       := Left(SRA->RA_Estado,2)+' '
		EndIf

		If cPaisLoc == "BRA"
			cF_Cep := Transform(Left(SRA->RA_Cep,8),'@R #####-###')
		Else
			cF_Cep := Transform(Left(SRA->RA_Cep,8),cPicCEP)
		EndIf

		cF_EstCiv   := Upper(Left(SRA->RA_EstCivi,1))

		If cPaisLoc == "BRA"
			cF_Sexo     := If(Sra->RA_Sexo=='M','o','a')
			If cF_EstCiv == 'C'
				cF_EstCiv := 'Casad' + cF_Sexo + '    '
			ElseIf cF_EstCiv == 'D'
				cF_EstCiv := 'Divorciad' + cF_Sexo
			ElseIf cF_EstCiv == 'M'
				cF_EstCiv :=  "Un.Estável"
			ElseIf cF_EstCiv == 'Q'
				cF_EstCiv := 'Desquitad' + cF_Sexo
			ElseIf cF_EstCiv == 'S'
				cF_EstCiv := 'Solteir' + cF_Sexo + '  '
			ElseIf cF_EstCiv == 'V'
				cF_EstCiv := 'Viuv' + cF_Sexo + '     '
			Else
				cF_EstCiv := Space(10)
			EndIf
		Else
			If cF_EstCiv == 'C'
				cF_EstCiv := STR0013		//'Casado(a) '
			ElseIf cF_EstCiv == 'D'
				cF_EstCiv := STR0014		//'Divorciado'
			ElseIf cF_EstCiv == 'M'
				cF_EstCiv := STR0015		//'Marital   '
			ElseIf cF_EstCiv == 'Q'
				cF_EstCiv := STR0016		//'Desquitado'
			ElseIf cF_EstCiv == 'S'
				cF_EstCiv := STR0017		//'Solteiro'
			ElseIf cF_EstCiv == 'V'
				cF_EstCiv := STR0018		//'Viuvo(a)'
			Else
				cF_EstCiv := Space(10)
			EndIf
		EndIf

		cF_CTPS		:= SRA->RA_NUMCP
		cF_UFCTPS	:= SRA->RA_UFCP
		cF_Serie	:= SRA->RA_SERCP
		cF_CIC		:= Left(SRA->RA_CIC,11)
		cF_RG		:= Left(SRA->RA_RG,15)
		cF_Mat		:= SRA->RA_Mat
		cF_Fil		:= Left(SRA->RA_Filial,FWGETTAMFILIAL)
		cF_CC		:= Left(SRA->RA_CC,16)

		Set Device to Print
		@ Li,00 pSay AvalImp(080)

		// Impressao da Declaracao de Enc.de Familia para fins de I.R.
		For Nx := 1 to nVias
			@ Li, 00 pSay STR0019	//'                 DECLARACAO DE ENCARGOS DE FAMILIA PARA FINS DE                 '
			fLi()
			If cPaisLoc == "ARG"
				@ Li, 00 pSay STR0056	//'                                IMPOSTO DE RENDA                                '
			Else
				@ Li, 00 pSay STR0020	//'                                IMPOSTO DE RENDA                                '
			Endif
			fLi()
			@ Li, 01 pSay Replicate('_',78)
			fLi()
			@ Li, 00 pSay STR0021 + cE_Empresa + Space(28) + '|' 	//'| Empresa: '
			fLi()
			@ Li, 00 pSay '|' + Replicate('_',78) + '|'
			fLi()
			@ Li, 00 pSay STR0023+cE_Endereco+Space(36)+' |'        	//'| Endereco: '
			fLi()
			@ Li, 00 pSay '|' + Replicate('_',78) + '|'
			fLi()
			@ Li, 00 pSay STR0024 + cE_Cidade
			@ Li, 48 pSay cTitUF  + cE_UF
			@ Li, 56 pSay STR0026 + cE_Cep
			@ Li, 79 pSay + '|'	//'| Cidade: '###'| UF: '###'    | CEP:  '
			fLi()
			@ Li, 00 pSay '|' + Replicate('_',47) + '|___________|__________________|'
			fLi()
			If cPaisLoc == "BRA"
				If aInfo[15] == 1 .Or. ( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ) )
					@ Li, 00 pSay STR0058 + cE_Cgc + STR0028 + cE_IE +  '  |'  	//'| C.G.C.: '###'             | Inscricao Estadual: '
				Else
					@ Li, 00 pSay STR0027 + cE_Cgc + STR0028 + cE_IE +  '  |'  	//'| C.G.C.: '###'             | Inscricao Estadual: '
				EndIf
				fLi()
				@ Li, 00 pSay '|' + Replicate('_',40) + '|' + Replicate('_',37) + '|'
			Else
				@ Li, 00 pSay cTitCGC + cE_Cgc  //'| C.G.C.: '###'
				@ Li, 79 pSay '|'
				fLi()
				@ Li, 00 pSay '|' + Replicate('_',78) + '|'
			EndIf
			fLi()
			@ Li, 00 pSay STR0031	//'|              DEPENDENTES CONSIDERADOS COMO ENCARGOS DE FAMILIA               |'
			fLi()
			@ Li, 00 pSay '|' + Replicate('_',78) + '|'
			fLi()
			@ Li, 00 pSay STR0032	//'|  No  |     NOME COMPLETO DOS DEPENDENTES      |  REL. DEPEND.  |  DATA NASC.  |'
			fLi()

			// Impressao do Termo de Responsabilidade (Detalhe).
			For Ny := 1 to Len(aDepend)
				If Li # 1 //-- Nao imprime o traco caso na linha acima este ja o tenha sido.
					@ Li, 00 pSay '|______|' + Replicate('_',39) + '|________________|______________|'
					fLi()
				EndIf
				If Len(aDepend[Ny, 1]) <= 37
					nLen := (37 - Len(aDepend[Ny,1]))
					@ Li, 00 pSay '|  ' + StrZero(Ny,2) + '  | ' + aDepend[Ny,1] + Space(nLen) + ' |   ' + aDepend[Ny,2] + '   |  ' + PadR(DtoC(aDepend[Ny,3]),10) + '  |'
					fLi()
				Else
					AAdd(aDepend[Ny], SubStr(aDepend[Ny, 1], 38, 70))
					aDepend[Ny, 1] := SubStr(aDepend[Ny, 1], 01, 37)
					@ Li, 00 pSay '|  ' + StrZero(Ny,2) + '  | ' + aDepend[Ny,1] + ' |   ' + aDepend[Ny,2] + '   |  ' + PadR(DtoC(aDepend[Ny,3]),10) + '  |'
					fLi()
					nLen := (38 - Len(aDepend[Ny,4]))
					@ Li, 00 pSay '|' + Space(6) + '|' + Space(1) + aDepend[Ny,4] + Space(nLen) + '|' + Space(16) + '|' + Space(14) + '|'
					fLi()
				EndIf
			Next Ny

			// Impressao do Termo de Responsabilidade (2a Parte).
			If Li # 1 //-- Nao imprime o traco caso na linha acima este ja o tenha sido.
				@ Li, 00 pSay '|______|' + Replicate('_',39) + '|________________|______________|'
				fLi()
			EndIf
			If Li > 38
				nVezes := 59 - li
				For Nz := 1 to nVezes
					@ Li, 00 Say '|' + Space(78) + '|'
					fLi()
				Next Nz
			EndIf
			@ Li, 00 pSay '|' + Space(78) + '|'
			Li ++
			@ Li, 00 pSay STR0055   //'| Ciente da proibicao da deducao de um mesmo dependente por ambos os conjuges,  |'
			Li ++
			@ Li, 00 pSay STR0033	//'| declaro sob pena da lei, que as informacoes aqui prestadas sao verdadeiras e |'
			Li ++
			@ Li, 00 pSay STR0034	//'| de minha inteira responsabilidade, nao cabendo a V. Sa.(s)  (fonte pagadora) |'
			Li ++
			@ Li, 00 pSay STR0035	//'| qualquer responsabilidade perante a fiscalizacao.                            |'
			Li ++
			@ Li, 00 pSay '|' + Space(78) + '|'
			Li ++
			@ Li, 00 pSay STR0036	//'|                      ____________________,____de___________________de ______ |'
			Li ++
			@ Li, 00 pSay '|' + Space(78) + '|'
			Li ++
			@ Li, 00 pSay '| ___________________________________      ___________________________________ |'
			Li ++
			@ Li, 00 pSay STR0037	//'|(CONJUGE, NO CASO DE DEPENDENTES COMUNS)     ( DECLARANTE )       |'
			Li ++
			@ Li, 00 pSay '|' + Replicate('_',78) + '|'
			Li ++
			nTam3 := 78 - (21 + IF(! Empty(cF_Nome),Len(cF_Nome), 0))  //9 e o tamanho que ocupa a String STR0038 em ANG|PTG
			@ Li, 00 pSay STR0038 + cF_Nome + Replicate(' ',nTam3) + '|'	//'| Nome do Declarante: '###'       | Matricula: '
			Li ++
			@ Li, 00 pSay '|' + Replicate('_',78) +  '|'
			Li ++
			nTam1 := 25 - (If( cPaisLoc $ "BRA",9,7) + IF(! Empty(cF_Fil),Len(cF_Fil), 0))  //9 e o tamanho que ocupa a String STR0041 em ANG|PTG
			nTam2 := 23 - (7 + IF(! Empty(cF_CC),Len(cF_CC), 0))   //7 e o tamanho que ocupa a String STR0057 em ANG|PTG
			nTam5 := 15 - Len(cF_Mat)

			@ Li, 00 pSay STR0039 + cF_Mat + Replicate(' ',nTam5) + STR0041 + cF_Fil + Replicate(' ',nTam1) + STR0057 + cF_CC + Replicate(' ',nTam2) + '|'	//'| Filial: '###' |  C.C.: '###' |'
			Li ++
			@ Li, 00 pSay '|' + Replicate('_',28) + '|' + Replicate('_',25) + '|' + Replicate('_',23) + '|'
			Li ++
			@ Li, 00 pSay STR0040 + Padr(Left(cF_Endereco,35),35) + "  " + cF_Bairro + Replicate(' ', 34 - Len(cF_Bairro)) + '|'	//'| Endereco: '###' | Filial: '
			Li ++
			@ Li, 00 pSay '|' + cF_Cidade + cF_Uf + Replicate(' ',72 - Len(cF_Cidade) + Len(cF_Uf)) + '|'	//'| Endereco: '###' | Filial: '
			Li ++
			@ Li, 00 pSay '|' + Replicate('_',78) + '|'
			Li ++
			If cPaisLoc == "BRA"
				@ Li, 00 pSay STR0045 + cF_Cep + STR0046 + cF_EstCiv + STR0047 + PadR( cF_Ctps, 11 ) + STR0048 + PadR( cF_Serie, 8 ) + '|'	//'| CEP: '###' | Estado Civil: '###' | Carteira de Trabalho : '###'    | Serie: '
			Else
				If !Empty(cTitDoc)
					@ Li, 00 pSay STR0045 + cF_Cep
					@ Li, 16 pSay STR0046 + cF_EstCiv
					@ Li, 43 pSay '| ' + cTitDoc + AllTrim(cF_Ctps)
					@ Li, 66 pSay AllTrim(STR0048) + cF_Serie  
					@ Li, 00 pSay '|'
				Else
					@ Li, 00 pSay STR0045 + cF_Cep
					@ Li, 16 pSay STR0046+cF_EstCiv
					@ Li, 43 pSay '|'
					@ Li, 66 pSay '|'
					@ Li, 00 pSay '|'
				EndIf
			EndIf
			Li ++
			If cPaisLoc == "BRA"
				@ Li, 00 pSay '|' + Replicate('_',15) + '|' + Replicate('_',26) + '|' + Replicate('_',18) + '|'+ Replicate('_',16) + '|'
				Li ++
				@ Li, 00 pSay STR0049 + cF_Cic + Space(23) +  STR0050 + cF_Rg + ' |'	//'| C.P.F. ( C.I.C. ): '###'| R.G.: '
				Li ++
				@ Li, 00 pSay '|' + Replicate('_',54) + '|' + Replicate('_',23) + '|'
			Else
				@ Li, 00 pSay '|' + Replicate('_',15) + '|' + Replicate('_',26) + '|' + Replicate('_',22) + '|'+ Replicate('_',12) + '|'
				Li ++
				@ Li, 00 pSay '| ' + cTitCIC + Transform(cF_Cic,cPicCIC)
				@ Li, 45 pSay '| ' + cTitRG  + cF_Rg
				@ Li, 79 pSay '|'
				Li ++
				@ Li, 00 pSay '|' + Replicate('_',44) + '|' + Replicate('_',33) + '|'
			EndIf
			Li ++
			@ Li, 00 pSay STR0051	//'|     RENOVAR ESTA DECLARACAO SEMPRE QUE OCORRER ALTERACAO NOS DADOS ACIMA     |'
			Li ++
			@ Li, 00 pSay STR0053	//'|     NO CASO DE DEPENDENTES COMUNS (FILHOS), ESTA DECLARACAO DEVERA SER       |'
			Li ++
			@ Li, 00 pSay STR0054	//'|     ASSINADA POR AMBOS OS CONJUGES                                           |'
			Li ++
			@ Li, 00 pSay '|' + Replicate('_',78) + '|'
			Li := 0
		Next Nx

		// Reinicializa Variaveis.
		Li      := 0
		aDepend := {}
		Sra->(dbSkip(1))

	EndDo

	// Termino do Relatorio.
	dbSelectArea( 'SRA' )
	Set Filter to
	RetIndex('SRA')
	dbSetOrder(1)

	Set Device To Screen
	If aReturn[5] == 1
		Set Printer To
		dbCommit()
		OurSpool(WnRel)
	EndIf

	MS_Flush()

Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fLi      ³ Autor ³ RH - Fernando Joly    ³ Data ³ 18/09/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Incrementa a variavel Li, e salta a pagina, caso Li = 60.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER430							                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fLi()

	If Li >= 58
		Li ++
		@ Li, 00 pSay '|' + Replicate('_',61) + STR0052	//'  continua...  __|'
		Li := 0
		@ Li, 01 pSay Replicate('_',78)
	EndIf
	Li ++

Return( Nil )
