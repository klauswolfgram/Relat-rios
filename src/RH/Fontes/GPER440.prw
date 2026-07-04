/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER440.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ gper440  ³ Autor ³ R.H. - Aldo Marini    ³ Data ³ 07.02.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ficha de Salario-Familia                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_gper440(void)                                              ³±±
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
User Function gper440()
	Local cDesc1		:= STR0001				//'Ficha de Salario-Famila.'
	Local cDesc2		:= STR0002				//'Ser  impresso de acordo com os parametros solicitados pelo'
	Local cDesc3		:= STR0003				//'usuario.'
	Local cString		:= 'SRA' 					//-- alias do arquivo principal (Base)
	Local aOrd			:= {STR0004,STR0005}	//'Matricula'###'Centro de Custo'
	Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {} }) //[1] Acesso; [2]Ofusca; [3]Mensagem
	Local aMsg			:= aOfusca[3]
	Local aFldRel		:= {"RA_NOME", "RA_NUMCP", "RA_SERCP", "RA_CIC", "RA_RG", "RB_NOME", "RB_NREGCAR", "RB_NUMLIVR", "RB_NUMFOLH", "RB_NUMAT",;
							"RA_BAIRRO", "RA_MUNICIP", "RA_ESTADO", "RA_CEP", "RA_ADMISSA", "RA_DEMISSA"}
	Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis Private(Basicas)                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private aReturn  	:= {STR0006,1,STR0007,2,2,1,'',1 }	//'Zebrado'###'Administra‡„o'
	Private NomeProg 	:= 'GPER440'
	Private aLinha   	:= {}
	Private nLastKey 	:= 0
	Private cPerg    	:= 'GPR440'
	Private nTamanho 	:= "M"
	Private cSituacao 	:= ""
	Private cCategoria	:= ""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis Utilizadas na funcao Principal do Programa         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private Li       := 0
	Private nVezes   := 0
	Private aInfo    := {}
	Private aDepend  := {}
	Private lEnd     := .F.
	Private cFilAnte := replicate("ú",FWGETTAMFILIAL)

	if !lBlqAcesso

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica as perguntas selecionadas                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		pergunte('GPR440',.F.)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utinLizadas para parametros                        ³
		//³ mv_par01        //  FiLial De                                ³
		//³ mv_par02        //  FiLial Ate                               ³
		//³ mv_par03        //  Matricula De                             ³
		//³ mv_par04        //  Matricula Ate                            ³
		//³ mv_par05        //  Centro De Custo De                       ³
		//³ mv_par06        //  Centro De Custo Ate                      ³
		//³ mv_par07        //  N§ de Vias                               ³
		//³ mv_par08        //  Situação                                 ³
		//³ mv_par09        //  Tipo de pagamento                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		cTit := STR0008		//'FICHA DE SALARIO - FAMILIA'

		If cPaisLoc == "BRA"
			nTamanho := "G"
		Else
			nTamanho := "M"
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Envia controle para a funcao SETPRINT                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		WnRel :='GPER440' //-- Nome Default do relatorio em Disco.
		WnRel :=SetPrint(cString,WnRel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,.f.,nTamanho)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nOrdem  := aReturn[8]

		If(!Empty(mv_par01),cFilDe :=mv_par01,cFilDe :=	replicate("0", FWGETTAMFILIAL))
		If(!Empty(mv_par02),cFilAte:=mv_par02,cFilAte:= replicate("9", FWGETTAMFILIAL))
		If(!Empty(mv_par03),cMatDe := mv_par03,cMatDe :='00000')
		If(!Empty(mv_par04),cMatAte:= mv_par04,cMatAte:='99999')
		If(!Empty(mv_par05),cCCDe := mv_par05,cCCDe :='0        ')
		If(!Empty(mv_par06),cCCAte:= mv_par06,cCCAte:='999999999')
		If(!Empty(mv_par07),nVias:= If(mv_par07<=0,1,mv_par07),nVias:= 1)
		IF(!Empty(mv_par08),cSituacao := mv_par08, cSituacao := "" )
		IF(!Empty(mv_par09),cCategoria := mv_par09, cCategoria := "" )

		Titulo  := STR0008	//'FICHA DE SALARIO - FAMILIA'

		If nLastKey == 27
			Return Nil
		Endif

		SetDefault(aReturn,cString)

		If nLastKey == 27
			Return Nil
		Endif

		RptStatus({|lEnd| gr440Imp(@lEnd,WnRel,cString)},titulo)
	Else
		Help(" ",1,aMsg[1],,aMsg[2],1,0)
	Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ GPER440  ³ Autor ³ R.H. - Aldo Marini    ³ Data ³ 07.02.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Ficha Salario-Familia                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER440(lEnd,WnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ WnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function gr440Imp(lEnd,WnRel,cString)

Local cAcessaSRA  := &("{ || " + ChkRH("GPER440","SRA","2") + "}")
Local cDepend		:=	"1*2"
Local cTitUF     	:= ""
Local cTitCGC    	:= RetTitle("A1_CGC")
Local cTitCtps   	:= IIf(FieldPos("RA_NUMCP")>0,RetTitle("RA_NUMCP"),"") + " "

Local cPicCGC    := Alltrim(X3Picture("A1_CGC"))
Local cPicCEP    := Alltrim(X3Picture("A1_CEP"))
Local cPicIE     := Alltrim(X3Picture("A1_INSCR"))
Local nX
Local nY
Local nZ
Local nLen

Do Case
	Case cPaisLoc $ "PAR|COL|URU"
		cTitUF := "DP: "
	Case cPaisLoc == "CHI"
		cTitUF := "RG: "
	Case cPaisLoc == "MEX"
		cTitUF := "ES: "
	Otherwise
		cTitUF := STR0025
EndCase
If cPaisLoc == "CHI"
	cDepend	:=	"23"
Endif

dbSelectArea('SRA')
dbSetOrder(nOrdem)
SetRegua(RecCount())
dbGotop()

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

//--Setar impressora
If cPaisLoc == "BRA"
	@ Li,00 pSay AvalImp(220)
Else
	@ Li,00 pSay AvalImp(132)
Endif

Do While !SRA->(Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Incrementa Regua de Processamento.                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Aborta Impresao ao se clicar em cancela 		       	        ³
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
	//³ Verifica a situação do funcionário.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !SRA->RA_SITFOLH $ cSituacao
		dbSelectArea("SRA")
		SRA->(dbSkip())
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica a categoria do funcionário.                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !SRA->RA_CATFUNC $ cCategoria
		dbSelectArea("SRA")
		SRA->(dbSkip())
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

	cLcnasc  := space(12)
	cCarto   := space(12)
	cNregcar := space(8)
	cNumliv  := space(7)
	cNumfol  := space(7)
	cNumMat	 := space(37)
	cDtent   := ctod("  /  /    ")
	cDtbaixa := ctod("  /  /    ")
	If SRB->(dbSeek(SRA->RA_Filial+SRA->RA_Mat,.F.))
		Do While SRB->RB_FILIAL+SRB->RB_MAT == SRA->RA_FILIAL+SRA->RA_MAT
			If (SRB->RB_TipSf $ cDepend) .And. (SRB->RB_GrauPar $ 'F/E')
				If cPaisLoc == "BRA"
					cLnome   := Substr(SRB->RB_NOME,1,70)
					dNasc    := SRB->RB_DTNASC
					cLcnasc  := Substr(SRB->RB_LOCNASC,1,12)
					cCarto   := Substr(SRB->RB_CARTORI,1,12)
					cNregcar := Padr(SRB->RB_NREGCAR,8," ")
					cNumliv  := Padr(SRB->RB_NUMLIVR,7," ")
					cNumfol  := Padr(SRB->RB_NUMFOLH,7," ")
					cNumMat	 := Substr(SRB->RB_NUMAT,1,37)
					cDtent   := SRB->RB_DTENTRA
					cDtbaixa := SRB->RB_DTBAIXA
					aAdd(aDepend,{Left(SRB->RB_NOME,70),SRB->RB_DTNASC,cLcNasc,cCarto,cNRegCar,cNumLiv,cNumFol,cDtEnt,cDtBaixa,cNumMat})
				Else
					aAdd(aDepend,{Left(SRB->RB_Nome,30),SRB->RB_DtNasc})
				Endif
			EndIf
			SRB->(dbSkip())
		EndDo
	Else
		SRA->(dbSkip(1))
		Loop
	Endif
	aSort(aDepend,,, {|X,Y| DtoS(X[2]) < DtoS(Y[2]) })
	If Len(aDepend) <= 0
		SRA->(dbSkip(1))
		Loop
	ElseIf Len(aDepend) < 13
		nVezes := (13 - Len(aDepend))
		For Nx := 1 to nVezes
			If cPaisLoc == "BRA"
				aAdd(aDepend,{Space(30),CtoD("  /  /    "),SPACE(12),SPACE(12),SPACE(8),SPACE(7),SPACE(7),CTOD("  /  /    "),CTOD("  /  /    "), SPACE(37)})
			Else
				aAdd(aDepend,{Space(30),CtoD('  /  /  ')})
			Endif
		Next Nx
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas na impressao.                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cE_Empresa  := Left(aInfo[3],40)
	cE_Endereco := Left(aInfo[4],30)
	cE_Cidade   := Left(aInfo[5],20)
	cE_Uf       := Left(aInfo[6],2)
	cE_Bairro   := Left(aInfo[13],20)

	If cPaisLoc == "BRA"
		cE_Cep := Transform(Left(aInfo[7],8),'@R #####-###')
		cE_Cgc := Left(If( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ), aInfo[27], aInfo[8] ),14)
		cE_IE  := Left(Transform(Val(aInfo[9]),'@E 99,999,999,999,999'),14)
	Else
		cE_Cep := Transform(Left(aInfo[7],8),cPicCEP)
		cE_Cgc := Transform(Left(aInfo[8],14),cPicCGC)
		cE_IE  := Transform(Val(aInfo[9]),cPicIE)
	Endif

	cF_Nome     := Left(SRA->RA_Nome,30)
	cF_Endereco := Left(SRA->RA_Enderec,30) + ' ' + Left(SRA->RA_Complem,3)
	cF_Bairro   := Left(SRA->RA_Bairro,15)
	cF_Cidade   := Left(SRA->RA_MUNICIP,16)
	cF_Uf       := Left(SRA->RA_Estado,2)
	If cPaisLoc == "BRA"
		cF_Cep := Transform(Left(SRA->RA_Cep,8),'@R #####-###')
	Else
		cF_Cep := Transform(Left(SRA->RA_Cep,8),cPicCEP)
	Endif

	cF_CTPS     := Left(SRA->RA_NumCp,7)
	cF_UFCTPS   := Left(SRA->RA_UFCP,2)
	cF_Serie    := Left(SRA->RA_SerCp,5)
	cF_CIC      := Left(SRA->RA_CIC,11)
	cF_RG       := Left(SRA->RA_RG,15)
	cF_Mat      := SRA->RA_Mat
	cF_Fil      := Left(SRA->RA_Filial,FWGETTAMFILIAL)
	cF_CC       := Left(SRA->RA_CC,9)
	cF_admissa  := DtoC(SRA->RA_Admissa)
	cF_demissa  := DtoC(SRA->RA_Demissa)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicionamento das colunas da Ficha de Salario-Famila        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//           1         2         3         4         5         6         7         8         9         0         1         2         3
	// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//   Empresa: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                                      CGC/Matricula No INPS: 99.999.999/9999-99
	//   Endereco: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      Bairro: xxxxxxxxxxxxxxxxxxxx  CEP: 99999-999  Cidade: xxxxxxxxxxxxxxxxxxxx  UF: xx
	//   Empregado: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     CTPS: xxxxxxx Serie: xxxxx    Dt.Admissao: 99/99/99          Dt.Demissao: 99/99/99
	//   Endereco: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxx  Bairro: xxxxxxxxxxxxxxx       CEP: 99999-999  Cidade: xxxxxxxxxxxxxxxx      UF: xx
	// +----------------------------------------------------------------------------------------------------------------------------------+
	// |No. |          NOME DO FILHO         | DT.NASC. |  LOCAL DO  |  CARTORIO  | N.REG. |  No.  |   No. | DT.   | DT.DA |    VISTO     |
	// |Ord.|                                |          | NASCIMENTO |            |        | LIVRO | FOLHA | ENTR. | BAIXA | FISCAL IAPAS |
	// |----|--------------------------------|----------|------------|------------|--------|-------|-------|-------|-------|--------------|
	// | 99 | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX | 99/99/99 |            |            |        |       |       |       |       |              |
	// |----|--------------------------------|----------|------------|------------|--------|-------|-------|-------|-------|--------------|
	//                                                                                        ___________________________________________
	//                                                                                                          ASSINATURA

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao da Ficha de Salario-Famila                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For Nx := 1 to nVias


		If cPaisLoc == "BRA"
			@ Li, 97 pSay STR0009		//'FICHA DE SALARIO - FAMILIA'
			Li+=3
			@ Li, 02 pSay STR0010 + cE_Empresa + Space(128) + STR0011 + cE_Cgc	//'Empresa: '###'CGC/Matricula No INPS: '
			Li+=1
			@ Li, 02 pSay STR0012 + cE_Endereco + space(32)+ STR0013+cE_Bairro + space(20) + STR0014 + cE_Cep + STR0015 + cE_Cidade + Space(28) + cTitUF + cE_UF	//'Endereco: '###'Bairro: '###'  CEP: '###'  Cidade: '###'  UF: '
			Li+=1
			@ Li, 02 pSay STR0034 + cF_Nome + space(31)+ STR0017+ cF_Ctps + STR0018 + cF_Serie + space(20)+ STR0019+ cF_Admissa +space(53)+ STR0020 +cF_demissa	//'Empregado: '###'CTPS: '###' Serie: '###'    Dt.Admissao: '###'Dt.Demissao: '
			Li+=1
			@ Li, 02 pSay STR0021 + cF_Endereco+ space(26)+STR0022 + cF_Bairro + space(27) + STR0023 + cF_Cep + STR0024 + cF_Cidade + space(34) + cTitUF + cF_UF	//'Endereco: '###'  Bairro: '###'CEP: '###'  Cidade: '###'UF: '
			Li+=1
			@ Li, 00 PSAY '+' + Replicate('-',218) + '+'
		Else
			@ Li, 54 pSay STR0009		//'FICHA DE SALARIO - FAMILIA'
	   		Li+=3
			@ Li, 02 pSay STR0010 + cE_Empresa + Space(38) + cTitCGC + cE_Cgc	//'Empresa: '###'CGC/Matricula No INPS: '
			Li+=1
	   		@ Li, 02 pSay STR0012 + cE_Endereco + space(5)+ STR0013+cE_Bairro + space(2) + STR0014 + cE_Cep + STR0015 + cE_Cidade + Space(02) + cTitUF + cE_UF	//'Endereco: '###'Bairro: '###'  CEP: '###'  Cidade: '###'  UF: '
	   		Li+=1
			If !Empty(cTitCtps)
				@ Li, 02 pSay STR0034 + cF_Nome + space(5) + cTitCtps + cF_Ctps + STR0018 + cF_Serie + STR0019+ cF_Admissa +space(6)+ STR0020 +cF_demissa	//'Empregado: '###'CTPS: '###' Serie: '###'    Dt.Admissao: '###'Dt.Demissao: '
			Else
				@ Li, 02 pSay STR0034 + cF_Nome + space(31) + STR0019 + cF_Admissa + space(6)+ STR0020 +cF_demissa	//'Empregado: '###'CTPS: '###' Serie: '###'    Dt.Admissao: '###'Dt.Demissao: '
			Endif
			Li+=1
			@ Li, 02 pSay STR0021 + cF_Endereco+ space(2)+STR0022 + cF_Bairro + space(5) + STR0023 + cF_Cep + STR0024 + cF_Cidade + space(7) + cTitUF + cF_UF	//'Endereco: '###'  Bairro: '###'CEP: '###'  Cidade: '###'UF: '
			Li+=1
			@ Li, 00 pSay '+' + Replicate('-',130) + '+'
		Endif
		Li++
		@ Li, 00 pSay '|'
		If cPaisLoc == "BRA"
			@ Li, 38 pSay STR0035	//'FILHOS MENORES DE 14 ANOS - (Dados extraidos das certidoes)'
			@ Li,219 PSAY '|'
			Li++
			@ Li, 00 PSAY '+' + Replicate('-',218) + '+'
		Else
			@ Li, 38 pSay STR0035	//'FILHOS MENORES DE IDADE   - (Dados extraidos das certidoes)'
			@ Li,131 pSay '|'
			Li++
			@ Li, 00 pSay '+' + Replicate('-',130) + '+'
		Endif

		Li++
		If cPaisLoc == "BRA"
       		@ Li, 00 PSAY STR0036	//'|No. |          NOME DO FILHO         | DT.NASC. |  LOCAL DO  |  CARTORIO  | N.REG. |  No.  |   No. | DT.      | DT.DA    |  VISTO   |'
       		Li := Li+1
       		@ Li, 00 PSAY STR0037	//'|Ord.|                                |          | NASCIMENTO |            |        | LIVRO | FOLHA | ENTR.    | BAIXA    |FISC.IAPAS|'
       		Li := Li+1
       		@ Li, 00 PSAY '|----|----------------------------------------|----------|--------------------------------|------------|--------|-------|-------|-------------------------------------|----------|----------|------------------------------|'
		Else
			@ Li, 00 pSay STR0027	//'|No. |          NOME DO FILHO         | DT.NASC. |  LOCAL DO  |  CARTORIO  | N.REG. |  No.  |   No. | DT.   | DT.DA |    VISTO     |'
			Li++
			@ Li, 00 pSay STR0028	//'|Ord.|                                |          | NASCIMENTO |            |        | LIVRO | FOLHA | ENTR. | BAIXA | FISCAL IAPAS |'
			Li++
			@ Li, 00 pSay '|----|--------------------------------|----------|------------|------------|--------|-------|-------|-------|-------|--------------|'
		Endif
		Li++      //14

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao da Ficha Salario-Familia (Detalhe).                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For Ny := 1 to Len(aDepend)
			If Ny # 1
				If cPaisLoc == "BRA"
					@ Li, 00 PSAY '|----|----------------------------------------|----------|--------------------------------|------------|--------|-------|-------|-------------------------------------|----------|----------|------------------------------|'
				Else
					@ Li, 00 pSay '|----|--------------------------------|----------|------------|------------|--------|-------|-------|-------|-------|--------------|'
				Endif
				Li++
			Endif
			If cPaisLoc == "BRA"
				If (Len(aDepend[Ny,1]) <= 30 )
		   			@ Li, 00 PSAY '| ' + If(!Empty(aDepend[Ny,1]),StrZero(Ny,2),space(2)) + ' |' + aDepend[Ny,1]+space(10) + '|' + PadR(DtoC(aDepend[Ny,2]),10)+ '|'+ aDepend[Ny,3]+space(20) +'|'+aDepend[Ny,4]+'|'+ If(Empty(aDepend[Ny,10]),aDepend[Ny,5],space(8)) +'|'+ If(Empty(aDepend[Ny,10]), aDepend[Ny,6], Space(7))+'|'+ If(Empty(aDepend[Ny,10]), aDepend[Ny,7], space(7))+'|'+ aDepend[Ny,10] +'|'+PadR(Dtoc(aDepend[Ny,8]),10)+'|'+PadR(DtoC(aDepend[Ny,9]),10)+'|'+'                              |'
				Else
					AAdd(aDepend[Ny], SubStr(aDepend[Ny, 1], 31, 70))
					aDepend[Ny, 1] := SubStr(aDepend[Ny, 1], 01, 30)

					nLen := (40 - Len(aDepend[Ny,11]))
					@ Li, 00 PSAY '| ' + If(!Empty(aDepend[Ny,1]),StrZero(Ny,2),space(2)) + ' |' + aDepend[Ny,1]+space(10) + '|' + PadR(DtoC(aDepend[Ny,2]),10)+ '|'+ aDepend[Ny,3]+space(20) +'|'+aDepend[Ny,4]+'|'+ If(Empty(aDepend[Ny,10]),aDepend[Ny,5],space(8)) +'|'+ If(Empty(aDepend[Ny,10]), aDepend[Ny,6], Space(7))+'|'+ If(Empty(aDepend[Ny,10]), aDepend[Ny,7], space(7))+'|'+ aDepend[Ny,10] +'|'+PadR(Dtoc(aDepend[Ny,8]),10)+'|'+PadR(DtoC(aDepend[Ny,9]),10)+'|'+'                              |'
					Li++
					@ Li, 00 PSAY '|' + space(4) + '|' + (aDepend[Ny,11]) + space(nLen) + '|' + space(10) + '|' + space(32) + '|' + space(12) + '|' + space(8) + '|' + space(7) + '|' + space(7) + '|' + space(37) + '|' + space(10) +'|' + space(10) + '|' + space(30) + '|' + '                              |'
				EndIf
			Else
				@ Li, 00 pSay '| ' + If(!Empty(aDepend[Ny,1]),StrZero(Ny,2),space(2)) + ' | ' + aDepend[Ny,1] + ' |' + PadR(DtoC(aDepend[Ny,2]),10)+ '|            |            |        |       |       |       |       |              |'
			Endif
			Li++
		Next Ny
		If cPaisLoc == "BRA"
			@ Li, 00 PSAY '+' + Replicate('-',218) + '+'
	       Li := Li+1
	       @ Li, 00 PSAY '+' + Replicate('-',218) + '+'
	       Li := Li+1
	       @ Li, 00 PSAY STR0042	//'| VALOR DE UM SALARIO-FAMILIA                                     | VALOR TOTAL DOS SALARIOS-FAMILIA A PAGAR                       |'
	       Li := Li+1
	       @ Li, 00 PSAY '|'
	       @ Li, 74 PSAY '|'
	       @ Li,146 PSAY '|'
	       @ Li,219 PSAY '|'
	       Li := Li+1
	       @ Li, 00 PSAY STR0038	//'| Em          ___ de __________________ de _____  R$ ____________ | A partir de ___ de _________________ de _____  R$ ____________ |'
	       Li := Li+1

	       For Nz:=1 to 5
	           @ Li, 00 PSAY STR0039	//'| Alterado em ___ de __________________ de _____  R$ ____________ | A partir de ___ de _________________ de _____  R$ ____________ |'
		        li := li+1
	       Next
	       @ Li, 00 PSAY '+' + Replicate('-',218) + '+'
	       Li := Li+1
	       @ Li, 60 PSAY STR0040
	        Li := Li+1
	       @ Li, 00 PSAY '+' + Replicate('-',218) + '+'
	        Li := Li+1
	       @ Li, 00 PSAY STR0041
	       Li := Li+1
	        @ Li, 00 PSAY '|---------------------------|--------------------------|---------------------------|--------------------------|---------------------------|--------------------------|---------------------------|-------------------------|'
	       Li := Li+1
	       	For Nz:=1 to 5
	       		@ Li, 00 PSAY '|---------------------------|--------------------------|---------------------------|--------------------------|---------------------------|--------------------------|---------------------------|-------------------------|'
	        	Li := Li+1
	        Next
	        @ Li, 00 PSAY '+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+'
	       li := li+1
	       @ Li, 00 PSAY STR0032		//'RECEBI OS DOCUMENTOS ACIMA'
	       Li := Li+3
	       @ Li, 175 PSAY '___________________________________________'
	       Li := Li+1
	       @ Li,191 PSAY STR0033		//'ASSINATURA'
		Else
			@ Li, 00 pSay '+' + Replicate('-',130) + '+'
			Li++
			@ Li, 00 pSay '+' + Replicate('-',130) + '+'
			Li++
			@ Li, 00 pSay STR0029	//'| VALOR DE UM SALARIO-FAMILIA                                     | VALOR TOTAL DOS SALARIOS-FAMILIA A PAGAR                       |'
			Li++
			@ Li, 00 pSay '|'
			@ Li, 66 pSay '|'
			@ Li,131 pSay '|'
			Li++

			@ Li, 00 pSay STR0030	//'| Em          ___ de __________________ de 19___  R$ ____________ | A partir de ___ de _________________ de 19___  R$ ____________ |'
			Li++
			For Nz:=1 to 5
				@ Li, 00 pSay STR0031	//'| Alterado em ___ de __________________ de 19___  R$ ____________ | A partir de ___ de _________________ de 19___  R$ ____________ |'
				Li++
			next nZ
			@ Li, 00 pSay '+' + Replicate('-',130) + '+'
			Li++
			@ Li, 00 pSay STR0032	//'RECEBI OS DOCUMENTOS ACIMA'
			Li+=3
			@ Li, 87 pSay '___________________________________________'
			Li++
			@ Li,103 pSay STR0033	//'ASSINATURA'
		Endif
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
Set FIlter to
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
