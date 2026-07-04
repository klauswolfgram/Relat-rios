/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER490.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER490  ³ Autor ³ R.H. - Marcos Stiefano³ Data ³ 28.10.96    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Admitidos e Demitidos                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER490(void)                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS    ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Cecilia C. ³20/05/14³TPQAJ1   ³Incluido o fonte da 11 para a 12 e efetua-³±±
±±³            ³        ³         ³da a limpeza.                             ³±±
±±³ Paulo O.   ³27/07/17³DRHPAG-  ³Ajuste no layout do relatório devido      ³±±
±±³ Inzonha    ³        ³4156     ³alteração no tamanho de campo               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER490()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString		:= "SRA"        // Alias do arquivo principal (Base)
Local aOrd			:= {}           // Ordem
Local cDesc1		:= STR0001		//"Relatorio de Admitidos e Demitidos."
Local cDesc2		:= STR0002		//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3		:= STR0003		//"usu rio."
Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {"",""} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
Local aFldRel		:= {"RA_PIS", "RA_SEXO", "RA_RACACOR", "RA_DEFIFIS", "RA_NOME", "RA_NUMCP", "RA_SERCP"}
Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0004,1,STR0005,2,2,1,"",1 }		//"Zebrado"###"Administra‡„o"
Private NomeProg := "GPER490"
Private aLinha   := {}
Private nLastKey := 0
Private cPerg    := "GPR490"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aInfo    := {}
Private cAliasSRA:= "SRA"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo   := STR0006		//"RELATORIO DE ADMITIDOS E DEMITIDOS"
Private Colunas  := 132
Private AT_PRG   := "GPER490"
Private wCabec0  := 2
Private wCabec1  := ""
Private wCabec2  := ""
Private Contfl   := 1
Private Li       := 0
Private nTamanho := "M"
Private aListEmp := fGetSM0(.T.)

	If lBlqAcesso
		Help(" ",1,aOfusca[3,1],,aOfusca[3,2],1,0)
		//"Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica as perguntas selecionadas                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		pergunte("GPR490",.F.)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utilizadas para parametros                         ³
		//³ mv_par01        //  Filial  De                               ³
		//³ mv_par02        //  Filial  Ate                              ³
		//³ mv_par03        //  Data de Referencia                       ³
		//³ mv_par04        //  Mudou Endereco                           ³
		//³ mv_par05        //  Encerrou Atividade                       ³
		//³ mv_par06        //  Correcao Declaracao                      ³
		//³ mv_par07        //  Primeira Declaracao                      ³
		//³ mv_par08        //  Nome do Responsavel                      ³
		//³ mv_par09        //  D.D.D.                                   ³
		//³ mv_par10        //  Fone                                     ³
		//³ mv_par11        //  Ramal                                    ³
		//³ mv_par12        //  Numero Convenio                          ³
		//³ mv_par13        //  Verbas do SRD a serem somadas ao Salario ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Envia controle para a funcao SETPRINT                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		wnrel:="GPER490"            //Nome Default do relatorio em Disco
		wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,,nTamanho)

		If nLastKey = 27
			Return
		Endif
		SetDefault(aReturn,cString)
		If nLastKey = 27
			Return
		Endif

		RptStatus({|lEnd| GR490Imp(@lEnd,wnRel,cString)},Titulo)
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GR490IMP ³ Autor ³ R.H. - Marcos Stiefano³ Data ³ 28.10.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Empregados / R. E.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ GR490Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function gr490imp(lEnd,WnRel,cString )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local CbTxt       // Ambiente
Local CbCont
Local cSavFilDe	:= replicate("!", FWGETTAMFILIAL)
Local cAliasMov	:= "SRC"
Local nLinaux   := 0
Local nX		:= 0
Local nValAcl   := 0
Local nRegistro := 1
Local lInicio   := .T.
Local aSituacao := {} 			//-- Armazena a situacao do funcionario no mes referencia, ou seja,  se esta demitido, se foi transferido, etc.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de Transferencias             	 			     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private lRelCagede	:= .T. 							//-- Indica se e relatorio ou nao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Salario										 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aCodFol   := {}
Private aRoteiro  := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private (Programa)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Tipomov     := { |Process,Situacao,aSituacao,nX| Tipmovto(Process,Situacao, aSituacao, nX ) }
Private nLinha      := 21
Private nCont_Func	:= 0
Private Salario 	:= 0.00
Private SalHora 	:= 0.00
Private SalDia		:= 0.00
Private SalMes		:= 0.00
Private TRemp       := TPemp := TTranE := TAdmi := TTranS := TReint := 0
Private Tsjus       := Tcjus := Texpo  := Tapos := Tmort  := Tdesl  := TTCon:= 0
Private TpriDia     := 0
Private nNumFunc    := 0
Private nTipoCaged	:= 1
Private ULT_DIA     := 0
Private Referencia := ""
Private aEmpresa    := {}
Private aPd         := {}
Private aPdv        := {}
Private aPosicao 	:= {} 							//-- Armazena posicao do funcionario no Mes referencia ( qdo tem transferencia)
Private aAux_posicao:= {} 							//-- Armazena as Emp/filiais/mat/cc por onde o funcionario ja passou e que ja foram analisadas
Private dAdmissao	:= ctod("//")
Private dDemissao 	:= ctod("//")
Private dReintegra  := ctod("//")
Private lAdmissao   := .F.
Private lDemissao   := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilDe     := mv_par01
cFilAte    := mv_par02
dDtRef     := mv_par03
cMudEnd    := If(mv_par04 == 1 , "S" , "N" )
cEncAti    := If(mv_par05 == 1 , "S" , "N" )
CCorDec    := If(mv_par06 == 1 , "S" , "N" )
cPriDec    := If(mv_par07 == 1 , "S" , "N" )
cNomeResp  := Upper(mv_par08)
cDDD       := mv_par09
cFone      := mv_par10
cRamal     := mv_par11
cNumConv   := mv_par12
cVerbas    := mv_par13

cMesComp	 := Strzero( Month( dDtRef ), 2 ) + Strzero( Year( dDtRef ), 4 )

ULT_DIA    := F_ULTDIA(dDtRef)
Referencia := StrZero(Month(dDtRef),2) + SubStr(Str(Year(dDtRef),4),3,2)
cFilialAnt := replicate("!", FWGETTAMFILIAL)
cSavFilDe  := cFilDe
dDataIni   := CtoD("01"  + "/" + StrZero(Month(dDtRef),2) + "/" + STRZERO(YEAR(dDtRef),4),"DDMMYY")
dDataFim   := CtoD(StrZero(Ult_Dia,2) + "/" + StrZero(Month(dDtRef),2) + "/" + STRZERO(YEAR(dDtRef),4),"DDMMYY")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona as filiais que serao processadas 								³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fAdEmpresa( nTipoCaged , @aEmpresa)
If Len(aEmpresa) == 0
	Return
EndIf

aSort(aEmpresa,,,{ |x,y| x[1] < y[1] })

dbSelectArea( "SRA" )
dbGotop()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Regua Processamento								     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(SRA->(RecCount()))

While !SRA->(Eof())

	If lEnd
		Exit
	Endif

	If SRA->RA_FILIAL > cFilAte
		Exit
	Endif
	If lInicio
		dbSelectArea( "SRA" )
		dbSeek( cFilDe , .T. )
		lInicio := .F.
	Else
		SRA->( dbGoTo( nRegistro ) )
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste filiais validas               						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(SRA->RA_FILIAL $ fValidFil())
		dbSelectArea( "SRA" )
		dbSkip()
		nRegistro := SRA->(Recno())
		Loop
	EndIf

	If SRA->RA_FILIAL # cFilialAnt

		nEmpAtu := aScan(aEmpresa,{|x| x[2] == SRA->RA_FILIAL})
		nEmpAtu := If(nEmpAtu>0,nEmpAtu,1)

		If !fInfo(@aInfo,SRA->RA_FILIAL) .Or. ;
			!Fp_CodFol(@aCodFol,aEmpresa[nEmpAtu,2])
			Exit
		Endif

		dbSelectArea( "SRA" )
		cFilialAnt := SRA->RA_FILIAL
		nCont_Func	:= 0
	Endif

	cEmpresa	 := SubStr( aInfo[03] + Space(34) , 1 , 34 )
	cEndereco := SubStr( aInfo[04] + Space(40) , 1 , 40 )
	cCidade   := SubStr( aInfo[05] + Space(20) , 1 , 20 )
	cEstado   := SubStr( aInfo[06] + Space(02) , 1 , 02 )
	cCep      := SubStr( aInfo[07] + Space(08) , 1 , 08 )
	If aInfo[15] == 1 .Or. ( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ) )
		cCgc      := Left(If( !Empty( aInfo[27] ), aInfo[27], aInfo[8] ),14)
	Else
		cCgc      := Transform(aInfo[8],'@R ##.###.###/####-##')
	EndIf
	cBairro   := SubStr( aInfo[13] + Space(20) , 1 , 20 )
	cAtivEcon := SubStr( aInfo[16] + Space(07) , 1 , 07 )

	Tot_adm := Tot_dem := Tot_fun := 0
	nPagina := 1
	nFolhas := 0

	nRegistro := SRA->(Recno())

	TRemp   := TPemp   := TTranE := TAdmi := TTranS := TReint:= 0
	Tsjus   := Tcjus   := Texpo  := Tapos := Tmort  := Tdesl := TTCon := 0
	TpriDia := nNumFunc:= 0

	Set Device to Screen
	cFiAnt  := SRA->RA_FILIAL
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Informacoes do cabecalho                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !SRA->(Eof()) .And. SRA->RA_FILIAL == cFiAnt
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta Regua Processamento                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		Incregua(SRA->RA_FILIAL+" - "+SRA->RA_MAT+" - "+SRA->RA_NOME)

		IF lEnd
			Set Device to Print
        	@Prow()+1,0 PSAY cCancela
        	Set Device to Screen
        	Exit
		EndIF

		IF !fM400Filtro()
			SRA->(dbSkip())
			Loop
		EndIF

		IF SRA->RA_FILIAL > cFilAte
			Exit
		EndIF
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Datas de admissao e demissao.											³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dAdmissao := SRA->RA_ADMISSA
		dDemissao := SRA->RA_DEMISSA
		If	Type("SRA->RA_FECREI") # "U"
			dReintegra:= (cAliasSRA)->RA_FECREI
		EndIf
		aSituacao := {}
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se funcionario foi transferido no mes, qdo funcionario nao for ³
		//³ demitido, ou demissao for maior ou igual ao mes de referencia           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If  Empty(dDemissao)  .or. ( MesAno( dDemissao) >=  MesAno( dDtRef ) )
			fVerTran( SRA->RA_FILIAL, SRA->RA_MAT, SRA->RA_CC, dDtRef, aEmpresa,If( !Empty(dReintegra) .or. ( MesAno( dReintegra) >=  MesAno( dDtRef ) ), dReintegra, dAdmissao), dDemissao, @aSituacao )
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Funcionario nao deve ser considerado no mes referencia  				³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aSituacao) <= 0
			SRA->(dbSkip())
			Loop
		Endif

		For nX := 1 to len( aSituacao )

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Desconsidera funcion rios demitidos em meses Anteriores.				³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( !Empty( aSituacao[nx,5] ) .and.   MesAno( aSituacao[nx,5] ) < MesAno( dDtRef ) )
				Exit
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica situacao do funcionario                        				³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			lDemissao 	:= .F.
			lAdmissao 	:= .F.
			If MesAno(aSituacao[nx,4]) == MesAno(dDtRef)  .or. aSituacao[nx,2]
				lAdmissao 	:= .T.
			Endif

			If MesAno(aSituacao[nx,5]) == MesAno(dDtRef)  .or. aSituacao[nx,3]  .or. ;
		       (!(aSituacao[nx,3]) .and. !Empty(ddemissao) .and. MesAno(ddemissao) = MesAno( dDtRef  ) .and. ;
	            !SRA->RA_RESCRAI $ "30*31"  )

				lDemissao 	:= .T.
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Totaliza funcionarios do 1o. Dia Mes                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If aSituacao[nx,1]				//-- Conta inicio

				If MesAno(aSituacao[nx,4]) < MesAno(dDtRef)  .and. ;
				  ( Empty( aSituacao[nx,5]) .or.  MesAno( aSituacao[nx,5] ) > MesAno(dDtRef) ) .and. ;
				   !aSituacao[nx,2]
					TpriDia ++
					nLinha ++
					//aAdd( aLog , asituacao[nx,6]+ "  " + SRA->RA_MAT + " " + SRA->RA_NOME + " " + StrZero( Day( dAdmissao ), 2 ) + "/" + StrZero( Month( dAdmissao ), 2 ) + "/" + StrZero( Year( dAdmissao ), 4 ) )    //	"PIS Invalido ou nao Informado."
					//-- Saidas (Demissoes/Transf.) no mes e mes posterior
	        	ElseIf MesAno(aSituacao[nx,5]) >= MesAno(dDtRef)  .and. MesAno(aSituacao[nx,4])< MesAno(dDtRef)  				//-- Saidas (Demissoes/Transf.) no mes e mes posterior
					Tpridia ++
					nLinha ++
					//aAdd( aLog , asituacao[nx,6] + "  " + SRA->RA_MAT + " " + SRA->RA_NOME + " " + StrZero( Day( dAdmissao ), 2 ) + "/" + StrZero( Month( dAdmissao ), 2 ) + "/" + StrZero( Year( dAdmissao ), 4 ) )    //	"PIS Invalido ou nao Informado."
				Endif
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Efetua contagem  de todas as admissoes/demissoes/transferencias     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If MesAno(aSituacao[nx,4])= MesAno(dDtRef) .or. lAdmissao
				A := Eval(Tipomov,"C",Iif(SRA->RA_SITFOLH#"T",Space(1),"T"), aSituacao, nX )
				nNumFunc ++
			Endif
			If MesAno(aSituacao[nx,5]) = MesAno(dDtRef) .or. lDemissao
				A := Eval(Tipomov,"C",Iif(SRA->RA_SITFOLH#"T","D","T"), aSituacao, nX)
				nNumFunc ++
			Endif
		NEXT Nx
		SRA->(dbSkip())
	Enddo

	SRA->( dbGoTo( nRegistro ) )
	nFolhas := Int( nNumFunc / 10 )
	If nFolhas * 10 < nNumFunc
		nFolhas ++
	Endif

	Set Device To Print
	@ 0,0 PSay AvalImp(Colunas)
	Cabecalho( nPagina )
	nCont_Func := 0
	cFiAnt    := SRA->RA_FILIAL

	SetRegua(SRA->(LastRec()))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Informacoes do rodape                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !SRA->(Eof()) .And. SRA->RA_FILIAL == cFiAnt

		Set Device to Screen
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta Regua Processamento                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Incregua(SRA->RA_FILIAL+" - "+SRA->RA_MAT+" - "+SRA->RA_NOME)

		If lEnd
        	Set Device to Print
        	@Prow()+1,0 PSAY cCancela
        	Set Device to Screen
			Exit
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Desconsidera Funcion rios Diretores                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF !fM400Filtro()
			SRA->(dbSkip())
			Loop
		EndIF

		IF SRA->RA_FILIAL > cFilAte
			Exit
		EndIF


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Datas de admissao e demissao.											³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dAdmissao := SRA->RA_ADMISSA
		dDemissao := SRA->RA_DEMISSA
		If	Type("SRA->RA_FECREI") # "U"
			dReintegra:= (cAliasSRA)->RA_FECREI
		EndIf

		aSituacao := {}

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se funcionario foi transferido no mes, qdo funcionario nao for ³
		//³ demitido, ou demissao for maior ou igual ao mes de referencia           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If  Empty(dDemissao)  .or. ( MesAno( dDemissao) >=  MesAno( dDtRef ) )
			fVerTran( SRA->RA_FILIAL, SRA->RA_MAT, SRA->RA_CC, dDtRef, aEmpresa, If( !Empty(dReintegra) .or. (MesAno(dReintegra) >= MesAno(dDtRef)),dReintegra, dAdmissao), dDemissao, @aSituacao )
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Funcionario nao deve ser considerado no mes referencia  				³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aSituacao) <= 0
			SRA->(dbSkip())
			Loop
		Endif

		For nX := 1 to len(aSituacao)
			lDemissao 	:= .F.
			lAdmissao 	:= .F.
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Desconsidera funcion rios demitidos em meses Anteriores.				³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( !Empty( aSituacao[nx,5] ) .and.   MesAno( aSituacao[nx,5] ) < MesAno( dDtRef ) )
				Exit
			Endif

			If MesAno(aSituacao[nx,4]) == MesAno(dDtRef)  .or. aSituacao[nx,2]
				lAdmissao 	:= .T.
			Endif

			If MesAno(aSituacao[nx,5]) == MesAno(dDtRef)  .or.  aSituacao[nx,3] .or. ;
		      (  !(aSituacao[nx,3]) .and. !Empty(ddemissao) .and.  MesAno(ddemissao) = MesAno( dDtRef  ) .and. ;
		            !SRA->RA_RESCRAI $ "30*31"  )
				lDemissao 	:= .T.
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Buscar dados do funcionario somente se houve alguma        ³
			//³transferencia ou se for admissao ou demissao,caso contrario³
			//³so preciso verificar se o funcionario deve ser contado no  ³
			//³inicio do mes ou nao                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( nX = 1 .and. ( aSituacao[nX,02] .or. aSituacao[nX,03] )  )  .or. ;
				 lAdmissao .or. lDemissao

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se Existe Incorporacao de Salario                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				Salario := SalHora := SalDia := SalMes := 0.00
				fM400Salario( cAliasMov )

			Endif

			If lAdmissao
				nCont_Func ++
				Imprime(Space(1),SalMes, aSituacao, nX )
			Endif

			If lDemissao
				nCont_Func ++
				Imprime(If(SRA->RA_SITFOLH #"T" ,"D","T"),SalMes, aSituacao, nX )
			Endif
		Next nX
		nRegistro := SRA->(Recno())
		dbSelectArea( "SRA" )
		dbSkip()
	Enddo

	If nCont_Func > 0
		If SRA->(Eof()) .Or. SRA->RA_FILIAL # cFiAnt
			Set Device to Print
			RodaPe( nPagina , nLinha )
			Set Device to Screen
		Endif
	Endif

	// Quebra Filial
	dbSelectArea( "SRA" )
	nRegistro	:= Recno()
	cFilDe    	:= SRA->RA_FILIAL
	lInicio    	:= .T.
Enddo

cFilDe := cSavFilDe


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA" )
Set Filter to
dbSetOrder(1)
Set Device To Screen

If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()
Return

*--------------------------------*
Static Function Cabecalho(nPagaux)
*--------------------------------*
If nPagaux == 1
	@ 01,00 PSAY STR0007							//"    1 = CGC              2 = CEI       3 = Tot.Folhas     4 = No Folha     5 = Referencia              MTPS - MINISTERIO DO TRABALHO"
	@ 02,00 PSAY If(aInfo[15]<>1,cCgc+Space(19),Space(19)+cCgc) + "       " +Transform(nFolhas,"99999") + "             " + Transform(nPagina,"9999") + "              " + Transform(Referencia,"@r 99/99")
	@ 04,00 PSAY STR0008			//" 6 = CEP      7 = ATIVIDADE ECONOMICA (CNAE)      8 = 1a DECLARACAO      9 = ENCERRAMENTO                 E DA PREVIDENCIA SOCIAL"
	@ 05,00 PSAY SubStr(cCep,1,5) + "-" + SubStr(cCep,6,3) + Space(16) + cAtivEcon + Space(28) + Iif(cPriDec="S","X"," ") + Space(22) + Iif(cEncAti="S","X"," ")
	@ 07,00 PSAY STR0009			// "10 = MUDOU ENDERECO     11 = MUDOU ATIVIDADE     12 = CORRIGE ANTERIOR     13 = TOTAL 1o DIA           SISTEMA CADASTRO  LEI 4923/65"
	@ 08,00 PSAY Space(8) + Iif(cMudEnd="S","X"," ") + Space(25) + Iif(cEncAti="S","X"," ") + Space(25) + Iif(cCorDec="S","X"," ") + Space(20) + Transform(TPridia,"99999")
	@ 10,00 PSAY STR0010			//"            14 = ADMISSOES NO MES - 1o EMPREGO + REEMPREGO + ENT.TRANSF. + REINTEG. =  TOTAL              CARIMBO PADRONIZADO  CGC"
	@ 11,00 PSAY Space(39) + Transform(TPemp,"9999") + Space(8) + Transform(TRemp,"9999") + Space(8) + Transform(TTranE,"9999") + Space(8) + Transform(TReint,"9999") + Space(7) + Transform(TPemp+TRemp+TTranE+TReint,"99999") + "           -----------------------------"
	@ 12,00 PSAY STR0011			// "15 = DESLIGAMENTOS"
	@ 13,00 PSAY STR0012			// "S.JUSTA CAUSA + C.JUSTA CAUSA + A PEDIDO + APOS. + MORTE + SAI.TRANSF. + TERM.CONTR. = TOTAL"
	@ 14,00 PSAY Space(5) + Transform(Tsjus,"9999") + Space(10) + Transform(Tcjus,"9999") + Space(11) + Transform(Texpo,"9999") + Space(6) + Transform(Tapos,"99") + Space(6) + Transform(Tmort,"99") + Space(7) + Transform(TTranS,"9999") + Space(11) + Transform(TTCon,"9999")+ space(6) + Transform(Tsjus+Tcjus+Texpo+Tapos+Tmort+TTranS+TTCon,"99999")
	@ 16,00 PSAY STR0013 + Transform((TPridia+TPemp+TRemp+TTranE+TReint) - (Tsjus+Tcjus+Texpo+Tapos+Tmort+TTranS+TTCon),"99999")	//"                                            16 = TOTAL EMPREGADOS NO ULTIMO DIA        "
	@ 17,00 PSAY Replicate("-",132)
	@ 19,00 PSAY  "   17         18   19    20  21    22   23                             24                 25        26          27  28       29   30   "
	@ 20,00 PSAY STR0014			//"   PIS/PASEP  SEXO RACA GRAU CBO  DEFIC  NOME COMPLETO                  CTPS    SER   UF DATA  REMUNERACAO  HRS DATA     DESL TIPO"
	@ 21,00 PSAY STR0020           // "                   COR  INST      FISICO                                                 NASCIM.               ADMISSAO       MVTO"
Else

	@ 01,00 PSAY STR0015			// "    1 = CGC              2 = CEI       3 = Tot.Folhas     4 = No Folha     5 = Referencia              MTPS - MINISTERIO DO TRABALHO"
	@ 02,00 PSAY If(aInfo[15]<>1, cCgc+Space(19), Space(19)+cCgc ) + "         " +Transform(nFolhas,"99999") + "             " + Transform(nPagina,"9999") + "              " + Transform(Referencia,"@r 99/99")
	@ 04,00 PSAY STR0016			//"                                                                                                          E DA PREVIDENCIA SOCIAL"
	@ 07,00 PSAY STR0017			//"                                                                                                       SISTEMA CADASTRO  LEI 4923/65"
	@ 10,00 PSAY STR0018			//"                                                                                                          CARIMBO PADRONIZADO  CGC"
	@ 11,00 PSAY "                                                                                                       -----------------------------"
	@ 17,00 PSAY Replicate("-",132)
	@ 19,00 PSAY "   17         18   19    20  21    22   23                             24                 25        26          27  28       29   30   "
	@ 20,00 PSAY STR0019		    // "   PIS/PASEP  SEXO RACA GRAU CBO   DEFIC  NOME COMPLETO                  CTPS    SER   UF DATA     REMUNERACAO HRS DATA      DESL TIPO"
	@ 21,00 PSAY STR0020           //  "                   COR  INST       FISICO                                                 NASCIM.                  ADMISSAO       MVTO"
Endif
nLinha := 23
Return Nil


*------------------------------------*
Static Function RodaPe(nPagaux,nLnaux)
*------------------------------------*
nLnaux ++
If nPagaux == 1
	@ nLnaux,003 PSAY Replicate("-",125)
	nLnaux ++
	@ nLnaux,003 PSAY "31 - "+cEmpresa
	nLnaux ++
	@ nLnaux,003 PSAY "32 - "+cEndereco
	@ nLnaux,060 PSAY "33 - "+cBairro
	nLnaux ++
	@ nLnaux,003 PSAY "34 - "+cCidade
	@ nLnaux,060 PSAY "35 - "+cEstado
	nLnaux ++
	@ nLnaux,003 PSAY "36 - "+cNomeResp
	nLnaux ++
	@ nLnaux,003 PSAY "37 - "
	@ nLnaux,008 PSAY cNumConv Picture "@R 9999-9"
	@ nLnaux,060 PSAY "38 - "
	@ nLnaux,065 PSAY cDDD Picture "9999"
	@ nLnaux,071 PSAY "39 - "
	@ nLnaux,076 PSAY cFone
	@ nLnaux,087 PSAY "40 - "
	@ nLnaux,092 PSAY cRamal  Picture "9999"
	nLnaux ++
	@ nLnaux,003 PSAY Replicate("-",125)
Else
	@ nLnaux,003 PSAY Replicate("-",125)
	nLnaux += 6
	@ nLnaux,003 PSAY Replicate("-",125)
Endif
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Tipmovto  ºAutor  ³Microsiga           º Data ³  05/23/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tipmovto(Formato,;  				//--Determina se "C"- Conta ;"D"-Despreza funcionario na contagem
						 Sitfolha,;					//--Situacao do funcionario
						 aSituacao,;				//--Array da situacao do funcionario
						 nX )						//--Elemento do aSituacao analisado
If Pcount() <= 1
	Sitfolha := SRA->RA_SITFOLH
Endif

If MesAno(aSituacao[nx,4]) = MesAno(dDtRef)  .or.  aSituacao[nx,2]  .or. lAdmissao
   	If !Sitfolha $ "D*E"
		If Right( SRA->RA_TIPOADM , 1 ) = "A"
			If Formato = "C"
				TPemp ++
				TAdmi ++
			Endif
			Return("10")

		Elseif Right( SRA->RA_TIPOADM , 1 ) = "C"			//-- Entrada de transferencia
			If Formato = "C"
				TTranE ++
				TAdmi ++
			Endif
			Return("70")
	    Elseif  SRA->RA_TIPOADM = "4B"						//-- 35 - Reintegração
			If Formato = "C"
				TReint ++
				TAdmi ++
			Endif
			Return("35")
		Elseif aSituacao[nx,2] .or.  MesAno( aSituacao[nx,4] ) = MesAno( dDtRef )  //-- Reemprego
			If Formato = "C"
				TRemp ++
				TAdmi ++
			Endif
			Return("20")
		EndIf
	EndIf
EndIf

If MesAno(aSituacao[nx,5]) = MesAno(dDtRef)  .or.  aSituacao[nx,3]  .or. lDemissao

	If Sitfolha $ "D*E"
		If SRA->RA_RESCRAI $ "11*40*90"
			If Formato = "C"
				TSjus ++
			Endif
			Return("31")
		ElseIf SRA->RA_RESCRAI $ "10"
			If Formato = "C"
				TCjus ++
			Endif
			Return("32")
		ElseIf SRA->RA_RESCRAI $ "20*21"
			If Formato = "C"
				TExpo ++
			Endif
			Return("40")
		ElseIf SRA->RA_RESCRAI $ "12"
			If Formato = "C"
				TTCon ++
			Endif
			Return("45")
		ElseIf SRA->RA_RESCRAI $ "50*70*71*72*73*74*75*76"
			If Formato = "C"
				TApos ++
			Endif
			Return("50")
		ElseIf SRA->RA_RESCRAI $ "60*62*64"
			If Formato = "C"
				TMort ++
			Endif
			Return("60")
		ElseIf ( SRA->RA_RESCRAI $ "30" .and. !Empty(aSituacao[nx,5]) .and. MesAno(aSituacao[nx,5]) = MesAno( dDtRef  ) ) .or. ;		//30 - Com Onus p/Cedente ; normalmente tem  rescisao
		       ( SRA->RA_RESCRAI $ "31" .and. !Empty(aSituacao[nx,5]) .and. MesAno(aSituacao[nx,5]) = MesAno( dDtRef  ) ) .or. ;		//31 - Sem Onus p/ Cedente
		       (aSituacao[nx,3] .and. Empty(SRA->RA_RESCRAI) .and. !Empty(aSituacao[nx,5])  )
			If Formato = "C"
				TTranS ++
			Endif
			Return("80")
		Endif
	Endif
EndIf

Return

*-------------------------------------------------------------*
Static Function Imprime(Situacao,nSalMes, aSituacao, nX )
*-------------------------------------------------------------*
Local cGrauIns := " "
Set Device to Print
If nCont_Func > 10
	RodaPe( nPagina , nLinha )
	nPagina ++
	nCont_Func := 1
	Cabecalho(nPagina)
Endif

cGrauIns	:= fInstrucao()

@ nLinha,000 PSAY StrZero(nCont_Func,2) + " " + StrTran(StrTran(SRA->RA_PIS,".",""),"-","") + " " + Iif(SRA->RA_SEXO="M","1","2")
@ nLinha,020 PSAY SRA->RA_RACACOR+ Space(3) + cGrauIns + Space(3) + fCodCBO(SRA->RA_FILIAL,SRA->RA_CODFUNC,dDtRef) + SPACE(2) + If(SRA->RA_DEFIFIS="1","S","N")
@ nLinha,039 PSAY Left(SRA->RA_NOME,30)+ " " + SRA->RA_NUMCP +"-"+ SRA->RA_SERCP + " " + SRA->RA_UFCP + " "
@ nLinha,089 PSAY Dtoc(SRA->RA_NASC)+" " + Transform(nSalMes,"@E 9999,999.99") + " " + Transform(SRA->RA_HRSEMAN,"99")
@ nLinha,115 PSAY If(Transform(Eval(Tipomov,"D",Situacao, aSituacao, nX ),"99") == "35",DtoC(SRA->RA_FECREI) ,DtoC(SRA->RA_ADMISSA))
@ nLinha,126 PSAY If(lAdmissao,"  ",StrZero(Day(SRA->RA_DEMISSA),2) ) + "  " + Transform(Eval(Tipomov,"D",Situacao, aSituacao, nX ),"99")
lAdmissao  := .F.

//"   17         18   19   20   21    22     23                             24             25         26          27  28        29   30  "
//"   PIS/PASEP  SEXO RACA GRAU CBO   DEFIC  NOME COMPLETO                  CTPS    SER UF DATA       REMUNERACAO HRS DATA      DESL TIPO"
//"                   COR  INST       FISICO                                               NASCIM.                    ADMISSAO       MVTO"
// 99 99999999999 X    X   99   99999   X    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXX-XXX XX XX/XX/XXXX 9999,999.99 99  XX/XX/XXXX XX  XX

nLinha ++
nLinha ++
Return Nil
