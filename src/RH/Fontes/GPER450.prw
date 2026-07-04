/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.ch"
#INCLUDE "GPER450.CH"

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё GPER450  Ё Autor Ё R.H.                  Ё Data Ё 15.10.96 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Relacao dos Salarios de Contribuicao                       Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё U_GPER450(void)                                              Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё         ATUALIZACOES SOFRIDAS DESDE A CONSTRU─AO INICIAL.             Ё╠╠
╠╠цддддддддддддбддддддддбдддддддбддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁProgramador Ё Data   Ё BOPS  Ё  Motivo da Alteracao                    Ё╠╠
╠╠цддддддддддддеддддддддедддддддеддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁCarlos E. O.Ё12/11/13ЁM12RH01Ё Retirada funcao AjustaSX1().            Ё╠╠
╠╠Ё            Ё        ЁRQ0320 Ё		  					              Ё╠╠
╠╠юддддддддддддаддддддддадддддддаддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/

User Function GPER450()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Locais (Basicas)                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local cString		:= "SRA"      // Alias do arquivo principal (Base)
Local aOrd			:= {STR0001,STR0002 ,STR0003}		//"Matricula"###"Centro de Custo"###"Nome"
Local cDesc1		:= STR0004		//"Relatorio dos Salarios de Contribui┤└o"
Local cDesc2		:= STR0005		//"Sera impresso de acordo com os parametros solicitados pelo"
Local cDesc3		:= STR0006		//"usuario."
Local aRegs			:= {}
Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {"",""} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
Local aFldRel		:= {"RA_NOMECMP", "RA_NOME", "RA_NUMCP", "RA_SERCP", "RA_CIC", "RA_PIS"}
Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Private(Basicas)                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private aReturn  := {STR0007, 1,STR0008, 2, 2, 1, "",1 }	//"Zebrado"###"Administra┤└o"
Private nomeprog := "GPER450"
Private aLinha   := {}
Private nLastKey := 0
Private cPerg    := "GPR450"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Private(Programa)                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private aInfo   := {}

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis Utilizadas na funcao IMPR                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private Titulo
Private Colunas  := 132
Private AT_PRG   := "GPER450"
Private wCabec0  := 2
Private wCabec1  := ""
Private wCabec2  := ""
Private Contfl   := 1
Private Li       := 0
Private nTamanho := "M"

	If lBlqAcesso
		Help(" ",1,aOfusca[3,1],,aOfusca[3,2],1,0)
		//"Dados Protegidos- Acesso Restrito: Este usuАrio nЦo possui permissЦo de acesso aos dados dessa rotina. Saiba mais em {link documentaГЦo centralizadora}"
	Else
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica as perguntas selecionadas                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		pergunte("GPR450",.F.)

		Titulo := STR0009		//"RELA─▌O DOS SALARIOS DE CONTRIBUI─▌O"

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Envia controle para a funcao SETPRINT                        Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		wnrel:="GPER450"            //Nome Default do relatorio em Disco
		wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

		If nLastKey = 27
			Return
		Endif
		SetDefault(aReturn,cString)
		If nLastKey = 27
			Return
		Endif

		RptStatus({|lEnd| GR450Imp(@lEnd,wnRel,cString)},Titulo)
	EndIf
Return

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё GPER450  Ё Autor Ё R.H.                  Ё Data Ё 15.10.96 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Relacao dos Salarios de Contribuicao                       Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe e Ё GR450Imp(lEnd,wnRel,cString)                               Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ lEnd        - A┤фo do Codelock                             Ё╠╠
╠╠Ё          Ё wnRel       - T║tulo do relat╒rio                          Ё╠╠
╠╠ЁParametrosЁ cString     - Mensagem			                          Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ*/
Static Function GR450Imp(lEnd,wnRel,cString)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Locais (Programa)                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local CbTxt       // Ambiente
Local CbCont
Local lCabecalho := .T.
Local aCodFol    := {}
Local aAumento   := {}
Local aAument1   := {}
Local cDescS     := ""
Local nSoma		 := 0
Local cMesRecol  := ""
Local cAnoRecol  := ""
Local aSalarios  := {}
Local aVerbas    := {}
Local aPaginas   := {}
Local cAnoPesq   := ""
Local cMesPesq 	 := ""
Local lImpTexto  := .F.
Local nMesPesq	 := 0
Local nAnoPesq	 := 0
Local nParcelas  := 0
Local nNroMeses  := 0
Local nCol       := 0
Local nPag1	     := 0
Local nPag2 	 := 0
Local nPos
Local cPd
Local nNu
Local Nx
Local Ny
Local Nz
Local Nk
Local nI
Local cMesPd
Local cAnoMesSal
Local nValTot
Local nValTotF
Local nValSal
Local cDtDe		 := ""
Local cMpesq	 := ""
Local cAcessaSRA := &("{ || " + ChkRH("GPER450","SRA","2") + "}")
Local cAcessaSRD := &("{ || " + ChkRH("GPER450","SRD","2") + "}")
Local cAcessaSR3 := &("{ || " + ChkRH("GPER450","SR3","2") + "}")
Local cVbs 	 	 := ''
Local cVbsBase 	 := ''

Private nLinAux

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Carregando variaveis mv_par?? para Variaveis do Sistema.     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nOrdem    	:= aReturn[8]
cFilDe    	:= mv_par01				//--  Filial  De
cFilAte   	:= mv_par02				//--  Filial  Ate
cCcDe     	:= mv_par03				//--  Centro de Custo De
cCcAte    	:= mv_par04				//--  Centro de Custo Ate
cMatDe    	:= mv_par05				//--  Matricula De
cMatAte   	:= mv_par06				//--  Matricula Ate
cNomeDe   	:= mv_par07				//--  Nome De
cNomeAte  	:= mv_par08				//--  Nome Ate
cSituacao 	:= mv_par09				//--  Situacao
cCategoria	:= mv_par10				//--  Categorias
dAno      	:= mv_par11				//--  Data Referencia
cConvenio 	:= mv_par12				//--  Numero Convenio
cMatInss  	:= mv_par13				//--  Matricula INSS
cVerbas   	:= If( Empty(mv_par14),"", AllTrim(mv_par14) )	//-- Verbas do Acumulado
nNumSala  	:= mv_par15				//-- Numero de Salarios
nAumOuSal	:= mv_par16				//-- Relacao Salarial  - Aumentos/Salarios
nNumParc  	:= If( mv_par17 < 12, 12, mv_par17 )			//-- Numero de Parcelas
cVerbas		+= If( Empty(mv_par18),"", AllTrim(mv_par18) )	//-- Verbas do Acumulado
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta a string de verbas a serem incorporadas ao salario     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cPD := ""
nNu := 0
For nX := 1 to Len(cVerbas)
	nNu ++
	cPD += Subs(cVerbas,nX,1)
	If nNu == 3
		cPD += "*"
		nNu := 0
	EndIf
Next nX

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta Data Inicio da Pesquisa								 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nParcelas 	:= Max(nNumParc,nNumSala)
nAnoPesq 	:= Int(  Year(dAno) -  ( nParcelas / 12   ) )
nMesPesq 	:= (Year(dAno)*12) - (nAnoPesq*12 ) +  ( Month(dAno) - nParcelas )
nMesPesq 	:= nMesPesq + 1
If nMesPesq > 12
	nMesPesq	:= nMesPesq - 12
	nAnoPesq ++
Endif
cAnoPesq 	:= StrZero( nAnoPesq ,4 )
cMesPesq 	:= StrZero(nMesPesq ,2)

dbSelectArea( "SRA" )
If nOrdem == 1
	dbSetOrder( 1 )
ElseIf nOrdem == 2
	dbSetOrder( 2 )
ElseIf nOrdem == 3
	dbSetOrder( 3 )
Endif

dbGoTop()
If nOrdem == 1
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + cCcDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim    := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	dbSeek(cFilDe + cNomeDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomeAte + cMatAte
Endif

cFilialAnt := replicate("!",FWGETTAMFILIAL)

SetRegua(SRA->(RecCount()))

While SRA->(!Eof()) .And. &cInicio <= cFim
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Movimenta Regua Processamento                                Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	IncRegua()

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
    Endif

    If SRA->RA_FILIAL # cFilialAnt
		If !Fp_CodFol(@aCodFol,SRA->RA_FILIAL) .Or. !fInfo(@aInfo,SRA->RA_FILIAL)
			Exit
		Endif
		cFilialAnt := SRA->RA_FILIAL
	Endif

	If nOrdem == 1
		If SRA->RA_FILIAL + SRA->RA_MAT > cFilAte + cMatAte
			Exit
		Endif
	Elseif nOrdem == 2
		If SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT  > cFilAte + cCcAte + cMatAte
			Exit
		Endif
	Elseif nOrdem == 3
		If SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT > cFilAte + cNomeAte + cMatAte
			Exit
		Endif
	Endif

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Consiste Parametrizacao do Intervalo de Impressao            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If ( FTAcento( SRA->RA_NOME ) < cNomeDe )  .Or. ( FTAcento( SRA->RA_NOME ) > cNomeAte )  .Or. ;
		( SRA->RA_MAT < cMatDe )   .Or. ( SRA->RA_MAT > cMatAte )   .Or. ;
		( SRA->RA_CC < cCcDe )     .Or. ( SRA->RA_CC > cCcAte )
		SRA->(dbSkip())
		Loop
	EndIf

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Consiste controle de acessos e filiais validas               Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		SRA->(dbSkip())
		Loop
	EndIf

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica Situacao e Categoria do Funcionario                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If !( SRA->RA_SITFOLH $ cSituacao ) .OR. !( SRA->RA_CATFUNC $ cCategoria )
		SRA->(dbSkip())
		Loop
	Endif

	cEmpNom := SubStr( aInfo[03] + Space(60) , 1 , 60 )
	cEmpEnd := SubStr( aInfo[04] + Space(60) , 1 , 60 )
	cCgcLoc := If( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ), aInfo[27]+Space(4), Transform(aInfo[8],'@R ##.###.###/####-##') )

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Limpa o array para uma nova busca						     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aSalarios := {}
	aVerbas   := {}
	nValTotF  := 0

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta Arrays com os ultimos 'n' Meses	                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	dbSelectArea( "SRD" )
	dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + cAnoPesq + cMesPesq, .T. )
	While !Eof() .And. SRD->RD_FILIAL + SRD->RD_MAT == SRA->RA_FILIAL + SRA->RA_MAT

		// -- Verifica se data menor que data de pesquisa
		If SRD->RD_DATARQ > MesAno(dAno)
			Exit
		EndIf

		// -- Despreza os lanctos de transferencias de outras empresas
        If SRD->RD_EMPRESA # cEmpAnt .And. !Empty(SRD->RD_EMPRESA)
			dbSkip()
			Loop
		Endif

		// -- Despreza os lanctos de 13.Salario
      	If SubStr(SRD->RD_DATARQ,5,2) == "13"
			dbSkip()
			Loop
		Endif

		//Verbas de base e desconto
		cVbs := aCodFol[013,1] +"/"+ aCodFol[221,1] +"/"+ aCodFol[019,1] +"/"+ aCodFol[064,1] +"/"+ aCodFol[065,1] +"/"+ aCodFol[070,1] +"/"+ aCodFol[222,1]
		cVbsBase := aCodFol[013,1] +"/"+ aCodFol[221,1] +"/"+ aCodFol[019,1]

		If SRD->RD_PD $ cVbs
			cAnoRecol := SubStr(SRD->RD_DATARQ,1,4)
			cMesRecol := StrZero( Val(SubStr(SRD->RD_DATARQ,5,2)) + 1 , 2)
			//--Data de Recolhimento sempre no mes seguinte a Competencia
			If cMesRecol == "13"
				cMesRecol := "01"
				cAnoRecol := StrZero(Val(SubStr(SRD->RD_DATARQ,1,4)) + 1 , 4 )
			Endif

			//Base
			cMesPd := Subs(SRD->RD_DATARQ,5,2)+"/"+Subs(SRD->RD_DATARQ,1,4)
			nPos   := Ascan(aSalarios,{ |x| x[1] == cMesPd })
			If nPos > 0
				If SRD->RD_PD $ cVbsBase //verbas de base
					aSalarios[nPos,2] += SRD->RD_VALOR
				Else
					aSalarios[nPos,5] += SRD->RD_VALOR
				EndIf
			Else
				If SRD->RD_PD $ cVbsBase //verbas de base
					Aadd(aSalarios,{ cMesPd,SRD->RD_VALOR,cMesRecol+"/"+cAnoRecol, SRD->RD_DATARQ, 0 } )
				Else
					Aadd(aSalarios,{ cMesPd,0,cMesRecol+"/"+cAnoRecol, SRD->RD_DATARQ, SRD->RD_VALOR } )
				Endif
			EndIf
		ElseIf SRD->RD_PD $ cPD .And. nAumOuSal == 2 // ParБmetros de Acumulados MV_PAR14
			nPos := Ascan(aVerbas,{ |x| x[1] == SRD->RD_DATARQ })
			If nPos > 0
				aVerbas[nPos,2] += SRD->RD_VALOR
			Else
				Aadd(aVerbas,{ SRD->RD_DATARQ, SRD->RD_VALOR } )
			Endif
		EndIf
		dbSkip()
	Enddo
	aSort( aSalarios,,,{ |x,y| x[4] < y[4] } )

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Buscar no SR3 os Ultimos 'n' Aumentos P/ Calcular Percentual Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aAumento := {}
	dbSelectArea( "SR3" )
	dbSetOrder(2)
	If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
		While !Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT == SR3->R3_FILIAL + SR3->R3_MAT
			If SR3->R3_PD <> "000"
				dbSkip()
				Loop
			EndIf
			dbSelectArea( "SX5" )
			If dbSeek( xFilial( "SX5" ) + "41" + SR3->R3_TIPO )
				cDescS := fTAcento( SubStr(SX5->X5_DESCRI,1,15) )
			Else
				cDescS := STR0014		//"Nao Cad.Tab. 41"
			Endif
			nPos := Ascan(aAumento,{ |x| left(x[1],6) == MesAno(SR3->R3_DATA) } )
			If nPos == 0
				Aadd( aAumento , { DtoS(SR3->R3_DATA) , cDescS , SR3->R3_VALOR , 0 } )
            Else
  				aAumento[nPos,3] :=  SR3->R3_VALOR
			Endif
			dbSelectArea( "SR3" )
			dbSkip()
		Enddo
	Endif

	If Len( aAumento ) > 0
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula o percentual de aumento							     |
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nAumOuSal == 1
			For Ny := 1 To Len( aAumento )
				aAumento[Ny,4] := If( Ny > 1 , aAumento[Ny,3] / aAumento[Ny-1,3] , 0 )
				aAumento[Ny,4] := If( nY > 1 , ( aAumento[Ny,4] - 1 ) * 100 , 0 )
			Next Ny
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Busca os salarios dos ultimos "n" meses						 |
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		Else
			cAnoMesSal := StrZero(Year(dAno),4) + StrZero(Month(dAno),2)
			For Ny  := 1 To nNumSala
				cAnoMesSal := If(Val(Right(cAnoMesSal,2))-1 == 0,StrZero(Val(Left(cAnoMesSal,4))-1,4)+"12",Left(cAnoMesSal,4)+;
							   StrZero(Val(Right(cAnoMesSal,2))-1,2))
		        If (Ascan (aAumento,{ |x| left(x[1],6) ==  cAnoMesSal}) )  == 0
					If MesAno(SRA->RA_ADMISSA) <= cAnoMesSal
						nValSal	:= 0
						fBuscaSlr(@nValSal, cAnoMesSal, 2)
						Aadd( aAumento , { cAnoMesSal + "01", "" , If(nValsal= 0,SRA->RA_SALARIO, nValSal) , 0 } )
					Endif
				EndIf
			Next Ny
		Endif
	EndIf

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Montar array com os elementos a serem impressos				 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aAument1 := {}
	If Len( aAumento ) > 0
        aSort( aAumento,,,{ |x,y| x[1] > y[1] } )
		NiAte := Min( Len( aAumento ), nNumSala )
        For Ni := 1 To NiAte

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Verificar se existem verbas a serem somadas ao salario.      |
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If nAumOuSal == 2
				nPos := Ascan(aVerbas,{ |x| x[1] == Left(aAumento[Ni,1],6) })
				If nPos > 0
					aAumento[Ni,3] += aVerbas[nPos,2]
				EndIf
				aAumento[Ni,2] := STR0031 //"SALARIO DO MES"
    		EndIf

            Aadd( aAument1 , { aAumento[Ni,1],aAumento[Ni,2],aAumento[Ni,3],aAumento[Ni,4] } )

        Next Ni
        aSort( aAument1,,,{ |x,y| x[1] < y[1] } )
	Endif

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprimir Corpo do Relatorio                                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Set Device To Printer

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime Cabecalho                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Cabec(aInfo,.T.)

	lCabecalho := .F.
	nNroMeses  := Len(aSalarios)
	aPaginas   := {} // Numero de paginas a imprimir

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Total de meses na primeira pagina - 60		                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nPag1 := Min( nNroMeses, 60 )
	nCol  := Int(nPag1/2)
	nCol  += If((nPag1/2)-nCol # 0, 1, 0)
	Aadd(aPaginas, { 01, nCol+1, nCol }) // Primeira Pagina

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Total de meses nas paginas seguintes - 104 		             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nMesesRest := nNroMeses - nPag1
	While nMesesRest > 0
		nPag2 := Min(nMesesRest, 104)
		nCol  := Int(nPag2/2)
		nCol  += If((nPag2/2)-nCol # 0, 1, 0)
		Aadd(aPaginas, { 01, nCol+1, nCol }) // Demais Paginas
		nMesesRest -= nPag2
	EndDo

	nIniPag := 01
	For Ny  := 1 To Len(aPaginas)

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Copiar os itens da primeira pagina para o array auxiliar	 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nTotPag := aPaginas[Ny,3]*2
 		aPagImp := Array(nTotPag)
		ACOPY(aSalarios, aPagImp, nIniPag, nTotPag )
		If Ny == 1
			nIniPag := nTotPag+1
		Else
			nIniPag += nTotPag
		EndIf

		If Ny > 1
			nLinAux++
			@ nLinAux,95 PSAY STR0033 // "Continua na Proxima Pagina..."
			Cabec(aInfo,.F.)
			@ nLinAux,01 PSAY "+-----------+-----------------------------+-------------------+-----------+-----------------------------+-------------------+"
			nLinAux++
		EndIf
		@ nLinAux,01 PSAY STR0037 + " |"
		nLinAux ++
		@ nLinAux,01 PSAY "+-----------+----------------+----------------+---------------+-----------+----------------+----------------+---------------+"
		nLinAux ++

    	nValTot := 0
		For Nx := 1 To aPaginas[Ny,3]
	        cImp      := ""
			For Nz := 1 To 2
				nColImp := aPaginas[Ny,Nz]
				If nColImp > Len(aPagImp) .Or. aPagImp[nColImp] == Nil
					cImp += "|" + Space(11) + "|" + Space(16) + "|" + Space(16) + "|" + Space(15)
				Else
	    		    cImp += "|  "+ aPagImp[nColImp,1]+ "  |" + ;
	    		   	Transform(aPagImp[nColImp,2],"@E 999,999,999.99") + Space(16 - Len(cValToChar(Transform(aPagImp[nColImp,2],"@E 999,999,999.99")))) + "|" +;
			 		Transform(aPagImp[nColImp,5],"@E 999,999,999.99") + Space(16 - Len(cValToChar(Transform(aPagImp[nColImp,5],"@E 999,999,999.99")))) + "|" + ;
			 		Space(04) + aPagImp[nColImp,3] + Space(11 - Len(aPagImp[nColImp,3]))
					nValTot   += aPagImp[nColImp,2]
				EndIf
			Next Nz
			@ nLinAux,01 PSAY cImp + "|"
			nLinAux 	    ++
			aPaginas[Ny,1] ++
			aPaginas[Ny,2] ++
		Next Nx

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime Valor Total da Pagina                                Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		@ nLinAux,01 PSAY "+-----------+----------------+----------------+---------------+-----------+----------------+----------------+---------------+"
		nLinAux ++
		@ nLinAux,01 PSAY "|" + SPACE(56)+ STR0012 + SPACE(7)+ Transform(nValTot,"@E 999,999,999.99") + Space(8) + "|" + Space(19) + "|" //"TOTAL DA PAGINA  |"
		nLinAux ++
		@ nLinAux,01 PSAY "+-------------------------------------------------------------------------+-----------------------------+-------------------+"

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime Valor Total Geral                                    Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nValTotF += nValTot
		If Ny == Len(aPaginas)
			nLinAux ++
			@ nLinAux,01 PSAY "|" + SPACE(61)+ STR0032 + SPACE(7)+ Transform(nValTotF,"@E 999,999,999.99") + Space(8) + "|" + Space(19) + "|" //"TOTAL GERAL |"
			nLinAux ++
			@ nLinAux,01 PSAY "+-------------------------------------------------------------------------+-----------------------------+-------------------+"
		Endif
	Next Ny

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Impressao dos Aumentos Salariais							 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nLinAux += 2
	If nLinAux > 50
		@ nLinAux,95 PSAY STR0033 // "Continua na Proxima Pagina..."
		Cabec(aInfo,.F.)
	EndIf
	@ nLinAux,01 PSAY "+---------------------------------------------------------------------------------------------------------------------------+"
	nLinAux ++
	If nAumOuSal == 1
		@ nLinAux,01 PSAY "|" + Space(52) + STR0015 + Space(52) + "|" // "AUMENTOS SALARIAIS"
	Else
		@ nLinAux,01 PSAY "|" + Space(51) + STR0030 + Space(52) + "|" // "RELACAO DOS SALARIOS"
	EndIf
	nLinAux ++
	@ nLinAux,01 PSAY "+---------------+--------------------------------------------------------------------------------------+--------------------+"
	nLinAux ++
	If nAumOuSal == 1
		@ nLinAux,01 PSAY STR0016 // "|   2-MES/ANO   |                                        MOTIVO                                        |     PERCENTUAL     |"
	Else
		@ nLinAux,01 PSAY STR0029 // "|   2-MES/ANO   |                                       DESCRICAO                                      |       VALOR        |"
	EndIf
	nLinAux ++
	@ nLinAux,01 PSAY "+---------------+--------------------------------------------------------------------------------------+--------------------+"
	nLinAux ++
	For Nk := 1 To Len(aAument1)
		@ nLinAux,01 PSAY "|    "+SubStr(aAument1[Nk,1],5,2)+"/"+SubStr(aAument1[Nk,1],1,4)+"    | "+;
					  SubStr(aAument1[Nk,2]+Space(85),1,85)+"|     "+;
                      If(nAumOuSal == 1,Transform(aAument1[Nk,4],"@E 9999.9999999") +"   |",;
                                        Transform(aAument1[Nk,3],"@E  999,999,999.99") +" |")
		nLinAux ++
		@ nLinAux,01 PSAY "+---------------+--------------------------------------------------------------------------------------+--------------------+"
		nLinAux ++
		If nLinAux > 57
			@ nLinAux,95 PSAY STR0033 // "Continua na Proxima Pagina..."
			Cabec(aInfo,.F.)
			@ nLinAux,01 PSAY "+---------------+--------------------------------------------------------------------------------------+--------------------+"
			nLinAux ++
			If nAumOuSal == 1
				@ nLinAux,01 PSAY STR0016 // "|   2-MES/ANO   |                                        MOTIVO                                        |     PERCENTUAL     |"
			Else
				@ nLinAux,01 PSAY STR0029 // "|   2-MES/ANO   |                                       DESCRICAO                                      |       VALOR        |"
			EndIf
			nLinAux ++
			@ nLinAux,01 PSAY "+---------------+--------------------------------------------------------------------------------------+--------------------+"
			nLinAux ++
		EndIf
	Next Nk
	If nLinAux > 50
		nLinAux ++
		@ nLinAux,95 PSAY STR0033 // "Continua na Proxima Pagina..."
		Cabec(aInfo,.F.)
	EndIf
	nLinAux += 2
	@ nLinAux,08 PSAY RTRIM(SUBS(aInfo[5],1,20))+",  "+DTOC(dDatabase)
	nLinAux ++
	@ nLinAux,08 PSAY "----------------------------------------------                  ----------------------------------------------"
	nLinAux ++
	@ nLinAux,08 PSAY STR0017 + Space(46) + STR0018 //"LOCALIDADE E DATA###ASSINATURA DO RESPONSAVEL E CARIMBO DA EMPRESA"
	nLinAux += 3
	@ nLinAux,01 PSAY STR0019+RTRIM(cConvenio)+"."	//"DOCUMENTO EMITIDO CONFORME AUTORIZACAO DA DIVISAO DE CONCESSAO DE BENEFICIOS DE ACORDO COM O PT "
	nLinAux ++
	@ nLinAux,01 PSAY STR0020	//"A INEXATIDAO DAS DECLARACOES CONSTANTES DESTE DOCUMENTO CONSTITUI CRIME PREVISTO NOS ARTIGOS 171 E 299 DO CODIGO PENAL."
	Set Device To Screen
	dbSelectArea( "SRA" )
	dbSkip()
Enddo

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Termino do relatorio                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea( "SRA" )
Set FIlter to
RetIndex( "SRA" )
dbSetOrder(1)

Set Device To Screen
If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()

*---------------------------*
Static Function Cabec(aInfo,lImpCab)
*---------------------------*

@ Li,00 pSay AvalImp(Colunas)

Cab01()
If lImpCab

	cNomecmp := If(!empty(SRA->RA_NOMECMP),SRA->RA_NOMECMP,SRA->RA_NOME)

	If aInfo[15] == 1 .Or. ( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ) )
		@ 08,01 PSAY STR0036	//"|    EMPRESA                                                                                           |    No CEI          |"
	Else
		@ 08,01 PSAY STR0021	//"|    EMPRESA                                                                                           |    No CNPJ         |"
	EndIf
	@ 09,01 PSAY "+------------------------------------------------------------------------------------------------------+--------------------+"
	@ 10,01 PSAY "|    " + cEmpNom + Space(38) + "| " + cCgcLoc + " |"
	@ 11,01 PSAY "+------------------------------------------------------------------------------------------------------+--------------------+"
	@ 12,01 PSAY STR0023	//"|    ENDERECO                                                                                          |    MATR. INSS      |"
	@ 13,01 PSAY "+------------------------------------------------------------------------------------------------------+--------------------+"
	@ 14,01 PSAY "|    " + cEmpEnd + Space(38) + "|  " + cMatInss + "|"
	@ 15,01 PSAY "+-------------------------------------------------+----------------------------------------------------+--------------------+"
	@ 16,01 PSAY STR0034	+ Space(5) + STR0025+SRA->RA_FILIAL + STR0026 + SRA->RA_MAT + STR0027 + Subs(SRA->RA_CC+Space(10),1,10) + Space(13 - Len(Subs(SRA->RA_CC+Space(10),1,10))) + STR0035 //"|    NOME DO SEGURADO   | ### "FIL: "###" - MAT: "###" - CC: "  ### "|    No CPF          |"
	@ 17,01 PSAY "+-------------------------------------------------+----------------------------------------------------+--------------------+"
	@ 18,01 PSAY "|    " + SubStr(cNomecmp + Space(70) , 1 , 70) + Space(26) + "  |  " + Transform(SRA->RA_CIC,"@R 999.999.999-99") +  "    |"
	@ 19,01 PSAY "+--------------------------------+-------------------------------------------+-------------------------+--------------------+"
	@ 20,01 PSAY STR0028	//"|    DOC.INSCRICAO No e SERIE    |    DATA ADMISSAO / INICIO CONTRIBUICAO    |    DATA DESLIGAMENTO    |    No PIS/PASEP    |"
	@ 21,01 PSAY "+--------------------------------+-------------------------------------------+-------------------------+--------------------+"
	@ 22,01 PSAY "|       " + SRA->RA_NUMCP + " / " + SRA->RA_SERCP + Space(10) + "|" + Space(16) + PADR(DtoC(SRA->RA_ADMISSA),10) + Space(17) + "|" + Space(08) + PADR(DtoC(SRA->RA_DEMISSA),10) + Space(07) + "|  " + Transform(AllTrim(SRA->RA_PIS),"@R 999.999.999-99") + "    |"
	@ 23,01 PSAY "+--------------------------------+-------------------------------------------+-------------------------+--------------------+"

	nLinAux := 24
EndIf

Return Nil


*-----------------*
Static Function Cab01()
*-----------------*
@ 01,01 PSAY "+---------------------------------------------------------------------------------------------------------------------------+"
@ 02,01 PSAY "|                                                                                                                           |"
@ 03,01 PSAY "|    P R E V I D E N C I A  S O C I A L                                                         RELACAO DOS SALARIOS-DE-    |"
@ 04,01 PSAY "|                                                                                                      CONTRIBUICAO         |"
@ 05,01 PSAY "|    INSTITUTO NACIONAL DO SEGURO SOCIAL                                                                                    |"
@ 06,01 PSAY "|                                                                                                                           |"
@ 07,01 PSAY "+---------------------------------------------------------------------------------------------------------------------------+"

nLinAux := 8

Return Nil
