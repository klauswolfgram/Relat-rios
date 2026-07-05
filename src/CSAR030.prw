/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.CH"
#INCLUDE "CSAR030.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CSAR030  ³ Autor ³ R.H. - Cristina Ogura       ³ Data ³ 19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Aumento Salarial conforme Tabela                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CSAR030(void)                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS       ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia Car.³30/07/14³TPZVV4      ³Incluido o fonte da 11 para a 12 e efetua-³±±
±±³            ³        ³            ³da a limpeza.                             ³±±
±±³Renan Borges³30/09/14³TQLXPD      ³Ajuste para corrigir reajuste salarial de ³±±
±±³            ³        ³            ³tabelas que possuem mais de um nível.     ³±±
±±³M. Silveira ³17/04/17³DRHPONTP-229³Ajuste na funcao Cria_RBR para tratar da  ³±±
±±³            ³        ³            ³forma correta codigos alfanumericos.      ³±±
±±³M. Silveira ³17/04/17³DRHPONTP    ³Criacao do P.E. CSR030CPO para adicionar  ³±±
±±³            ³        ³-1010       ³campos de usuario ao atualizar a Tab. RB6.³±±
±±³Oswaldo L   ³21/12/17³DRHPAG-9991 ³Tratar acessos diretos na SX2, pontuados  ³±±
±±³            ³        ³            ³pelo sonarqube                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function CSAR030()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis Locais(Basicas)                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cDesc1  	:= STR0001						//"Emiss„o do Aumento Salarial."
	Local cDesc2  	:= STR0002						//"Ser  impresso de acordo com os parametros solicitados pelo"
	Local cDesc3  	:= STR0003						//"usu rio."
	Local cString 	:= "SRA"						// Alias do arquivo principal (Base)
	Local aOrd 		:= {STR0004,STR0005,STR0006} 	//"Matricula"###"Centro de Custo"###"Funcao"
	Local aMsg 		:= {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis Private(Basicas)                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private aReturn := {STR0007, 1,STR0008, 2, 2, 1, "",1 }	//"Zebrado"###"Administra‡„o"
	Private NomeProg:= "CSAR030"
	Private aLinha  := {}
	Private aOfusca	:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {"",""} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
	Private nLastKey:= 0
	Private cPerg   := "CSR030"
	Private nOrdem  := 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis Private(Programa)                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private nAtualiza	:= 0
	Private nPerAum		:= 0
	Private nVlAum		:= 0
	Private nTipoRel	:= 0
	Private nCriterio	:= 0
	Private nArredonda	:= 0
	Private cTabela		:= ""
	Private cNivDe		:= ""
	Private cNivAte		:= ""
	Private cFilDe		:= ""
	Private cFilAte		:= ""
	Private cClasseDe	:= ""
	Private cClasseAte	:= ""
	Private cDataRef	:= ""
	Private cDataNova	:= ""
	Private lAtuDataNova := .F. // Caso já exista Tabela Salarial com a nova data de referencia, o usuario escolhe se deseja atualiza-lá ou não.
	Private lFaixaAlfa	:= (SUPERGETMV("MV_VDFFXSL", .F., "01") == "A")
	Private lHistorico	:= Iif( Getmv("MV_HISTSAL",,"2") = "1", .T., .F.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis Utilizadas na funcao IMPR                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private Titulo	:= ""
	Private AT_PRG  := "CSAR030"
	Private wCabec0 := 1
	Private wCabec1 := STR0009+Dtoc(dDataBase)		//"Data Base: "
	Private CONTFL  := 1
	Private LI      := 0
	Private nTamanho:= "M"

	//Tratamento de acesso a Dados Sensíveis
	If aOfusca[2] .AND. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( {"RA_SALARIO"} ) )
		//"Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
		Help(" ",1,aOfusca[3,1],,aOfusca[3,2],1,0)
		Return
	EndIf

	pergunte(cPerg,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas na pergunte                                 ³
	//³ mv_par01				// Atualizacao Tabela  1-Simulacao 2-Real³
	//³ mv_par02				// Tabela Salarial                       ³
	//³ mv_par03				// Nivel da Tabela De                    ³
	//³ mv_par04				// Nivel da Tabela Ate                   ³
	//³ mv_par05				// Filial De                             ³
	//³ mv_par06				// Filial Ate                            ³
	//³ mv_par07				// % Aumento                             ³
	//³ mv_par08				// Valor Aumento                         ³
	//³ mv_par09 				// Arred No Calculo  N„o / Normal / Acima³
	//³ mv_par10      			// Arredondamento Sobre o Calculo        ³
	//³ mv_par11				// Imprimir      1-Sintetico 2-Analitico ³
	//³ mv_par12				// Classe Salarial De 					 ³
	//³ mv_par13				// Classe Salarial Ate 					 ³
	//³ mv_par14				// Data de referência da tabela			 ³
	//³ mv_par15				// Data de referência da tabela			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Titulo := STR0010			// "RELACAO DE AUMENTO SALARIAL CONFORME TABELA"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel:="CSAR030"            //Nome Default do relatorio em Disco
	wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

	nAtualiza	:=	If(!Empty(mv_par01),mv_par01,1)
	cTabela		:=	If(!Empty(mv_par02),mv_par02,"  ")
	cNivDe		:=	If(!Empty(mv_par03),mv_par03,"  ")
	cNivAte		:=	If(!Empty(mv_par04),mv_par04,"99")
	cFilDe		:=	If(!Empty(mv_par05),mv_par05,Space(FWGetTamFilial))
	cFilAte		:=	If(!Empty(mv_par06),mv_par06,Space(FWGetTamFilial))
	nPerAum		:=	If(!Empty(mv_par07),mv_par07,0)
	nVlAum 		:=	If(!Empty(mv_par08),mv_par08,0)
	nCriterio 	:=	If(!Empty(mv_par09),mv_par09,2)
	nArredonda	:=	If(!Empty(mv_par10),mv_par10,0)
	nTipoRel	:=	If(!Empty(mv_par11),mv_par11,1)
	cClasseDe	:=	If(!Empty(mv_par12),mv_par12,"   ")
	cClasseAte	:=	If(!Empty(mv_par13),mv_par13,"999")
	cDataRef	:=	If(!Empty(mv_par14),mv_par14,CtoD("  /  /  "))
	cNovaRef	:=	If(!Empty(mv_par15),mv_par15,CtoD("  /  /  "))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Aviso caso o modo de acesso das tabelas seja exclusivo  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If FWModeAccess( "RB6", 3) == "E" .And. cFilDe <> cFilAte
		Aviso(STR0030,STR0031,{"OK"}) //"Atenção"#"Os parâmetros 'Filial De/Ate' devem ser preenchidos com a filial corrente já que a Tabela Salarial 'RBR/RB6' está em Modo de Acesso Exclusivo"
		Return .F.
	EndIf

	cFilDe := xFilial("RB6",cFilDe)

	nOrdem := aReturn[8]
	Titulo := STR0011			//"RELACAO DE AUMENTO SALARIAL"

	If nOrdem == 3
		Titulo := Titulo + "-"+ STR0025	//"POR FUNCAO"
	EndIf

	wCabec1+="  "
	wCabec1+="  "

	If nLastKey == 27
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	EndIf

	RptStatus({|lEnd| Cs030Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CSAR030  ³ Autor ³ R.H. - Cristina Ogura ³ Data ³ 19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Aumento Salarial                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CS030Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Cs030Imp(lEnd,WnRel,cString)
	Local nSalario  := 0
	Local nSalMes 	:= 0
	Local nSalDia 	:= 0
	Local nSalHora 	:= 0
	Local nVlTab	:= 0
	Local nValArre	:= 0
	Local nPos		:= 0
	Local nNovoSal	:= 0
	Local nHNovoSal := 0
	Local cAcessaRB6:= &("{ || " + ChkRH(FunName(),"RB6","2") + "}")
	Local cAcessaSRA:= &("{ || " + ChkRH(FunName(),"SRA","2") + "}")
	Local lTestar	:= .F.
	Local nTipoVl	:= 1
	Local cDataSeek := cDataRef

	Private aPosicao1	:= {}
	Private aTotFun1  	:= {}
	Private aTotCc1   	:= {}
	Private aTotFil1  	:= {}
	Private aTotEmp1  	:= {}
	Private aInfo     	:= {}
	Private aTabela	  	:= {}
	Private cInicio     := ""
	Private cFim		:= ""
	Private cFilialAnt 	:= Space(FWGetTamFilial)
	Private cCcAnt     	:= Space(9)
	Private cFuAnt     	:= Space(4)
	Private cFunAnt    	:= SPace(4)

	// Montar array com a tabela reajustado
	dbSelectArea("RB6")
	dbSetOrder(3)

	If Empty(cDataRef)
		Help("",1,".RHDTTABSAL.")
		Return
	EndIf

	If !dbSeek(xFilial("RB6")+cTabela+DTOS(cDataRef))
		Help("",1,"Cs030NOTAB")
		Return
	EndIf


	If !Empty(cNovaRef) .AND. RB6->RB6_DTREF > cNovaRef
		Help("",1,"CS03DTREF")
		return
	EndIf

	If !Empty(cNovaRef) .AND. dbSeek(xFilial("RB6")+cTabela+DTOS(cNovaRef))
		If !(MSGYESNO(STR0032, STR0030))
		Return
		EndIf
		lAtuDataNova := .T.
	EndIf

	dbSeek(xFilial("RB6")+cTabela+DTOS(cDataRef))

	nTipoVl	:= RB6->RB6_TIPOVL
	wCabec1	:= wCabec1 + STR0026+cTabela+"-"+RB6->RB6_DESCTA	//"Tabela Salarial: "

	If !Empty(cNovaRef) .AND. (RB6->RB6_DTREF < cNovaRef)
		If nAtualiza == 2
			Cria_RBR()
			dbSeek(xFilial("RB6")+cTabela+DTOS(cNovaRef))
			cDataSeek := cNovaRef
		Else
			dbSeek(xFilial("RB6")+cTabela+DTOS(cDataRef))
		End
	EndIf

	While !Eof() .And. xFilial("RB6")+cTabela+DTOS(cDataSeek) == RB6->RB6_FILIAL+RB6->RB6_TABELA+DTOS(RB6->RB6_DTREF)

		If 	RB6->RB6_NIVEL < cNivDe  .Or.;
			RB6->RB6_NIVEL > cNivAte .Or.;
			RB6->RB6_FILIAL < cFilDe .Or.;
			RB6->RB6_FILIAL > cFilAte .Or.;
			RB6->RB6_CLASSE < cClasseDe .Or.;
			RB6->RB6_CLASSE > cClasseAte .Or.;
			RB6->RB6_ATUAL <> "1"
			dbSkip()
			Loop
		EndIf

		If !Eval(cAcessaRB6)
			dbSkip()
			Loop
		EndIf

		nValArre:= 0
		nVlTab 	:= RB6->RB6_VALOR * (1+(nPerAum/100))
		nVlTab 	:= nVlTab + nVlAum

		If 	nCriterio == 1			// Nao Arredondar
			nVlTab:= NoRound(nVlTab)
		ElseIf nCriterio == 2		// Arredondamento Padrao
			nVlTab := Round(nVlTab,2)
		Else
			If 	nVlTab - Round(nVlTab,2) > 0.00
				nVlTab := NoRound((nVlTab+.01),2)
			Else
				nVlTab := Round(nVlTab,2)
			Endif
		EndIf

		nVlTab := Round(nVlTab,MsDecimais(1))

		If nArredonda # 0
			CalcArre(@nVlTab, @nArredonda, @nValArre)
		EndIf

		Aadd(aTabela,{RB6->RB6_NIVEL,RB6->RB6_FAIXA,nVlTab,nValArre,RB6->RB6_VALOR})		// {Nivel, Faixa, Valor, Arredondamento}

		// Atualiza a tabela com o aumento dos parametros
		If nAtualiza == 2
			RecLock("RB6",.F.)
				Replace RB6->RB6_VALOR With	nVlTab
			MsUnlock()
		EndIf

		lTestar := .T.

		dbSelectArea("RB6")
		dbSkip()
	EndDo

	If lTestar
		dbSelectArea( "SRA" )
		If nOrdem == 1
			dbSetOrder(1)
		ElseIf nOrdem == 2
			dbSetOrder(2)
		ElseIf nOrdem == 3
			dbSetOrder(7)
		Endif

		dbGoTop()
		dbSeek(cFilDe, .T. )
		cInicio := "SRA->RA_FILIAL"
		cFim 	:= cFilAte

		SetRegua(SRA->(RecCount()))

		While	!EOF() .And. &cInicio <= cFim

			If SRA->RA_FILIAL # cFilialAnt
				If !fInfo(@aInfo,SRA->RA_FILIAL)
					Exit
				EndIf
				dbSelectArea( "SRA" )
				cFilialAnt := SRA->RA_FILIAL
			EndIf

			If 	SRA->RA_SITFOLH == "D" 	.Or.;
				SRA->RA_TABELA # cTabela 	.Or.;
				SRA->RA_TABNIVE < cNivDe 	.Or.;
				SRA->RA_TABNIVE > cNivAte
				FTestaTotal()
				Loop
			EndIf

			If !Eval(cAcessaSRA)
				FTestaTotal()
				Loop
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Movimenta Regua Processamento                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncRegua()

			If lEnd
				@Prow()+1,0 PSAY cCancel
				Exit
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula Salario Mes , Dia , Hora do Funcionario              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fSalario(@nSalario,@nSalHora,@nSalDia,@nSalMes,"A")

			nPos 	 := 0
			nNovoSal := 0
			nHNovoSal:= 0
			nSalBase := 0
			nValArre := 0
			nPos 	 := Ascan(aTabela, { |x| x[1]+x[2]== SRA->RA_TABNIVE+SRA->RA_TABFAIX })
			If nPos > 0
				If  nTipoVl == 1 .Or. nTipoVl == 3 						//Valores Exatos
					nNovoSal := aTabela[nPos][3]
					nValArre := aTabela[nPos][4]
				Else                      				// Intervalo
					nNovoSal := SRA->RA_SALARIO *(1+(nPerAum/100))
					nNovoSal += nVlAum

					If 	nCriterio == 1			// Nao Arredondar
						nNovoSal := NoRound(nNovoSal)
					ElseIf nCriterio == 2		// Arredondamento Padrao
						nNovoSal := Round(nNovoSal,2)
					Else
						If 	nNovoSal - Round(nNovoSal,2) > 0.00
							nNovoSal := NoRound((nNovoSal+.01),2)
						Else
							nNovoSal := Round(nNovoSal,2)
						Endif
					EndIf
					nNovoSal := Round(nNovoSal,MsDecimais(1))
					If nArredonda # 0
						CalcArre(@nNovoSal, @nArredonda, @nValArre)
					EndIf
				EndIf
			EndIf

			If cPaisLoc == "PAR"
				nSalMes := Round(nSalMes,MsDecimais(1))
				nNovoSal := Round(nNovoSal,MsDecimais(1))
			EndIf

			If 	nOrdem # 3
				nSalBase := Round( IF( SRA->RA_CATFUNC $ "M*C*P*A*E*S", nSalMes , nSalHora ),MsDecimais(1) )
				nNovoSal := IF( SRA->RA_CATFUNC $ "M*C*P*A*E*S", nNovoSal , nNovoSal * SRA->RA_HRSMES )
				nHNovoSal:= IF( SRA->RA_CATFUNC $ "H*T*G"		, nNovoSal , nNovoSal / SRA->RA_HRSMES )
			Else
				dbSelectArea( "SRJ" )
				dbSeek( xFilial("SRJ",SRA->RA_FILIAL) + SRA->RA_CODFUNC )
				nSalBase := SRJ->RJ_SALARIO
				nSalHora := 0
				nHNovoSal:= 0
			EndIf

			If cPaisLoc == "PAR"
				nSalHora := Round(nSalHora,MsDecimais(1))
				nSalBase := Round(nSalBase,MsDecimais(1))
				nNovoSal := Round(nNovoSal,MsDecimais(1))
				nHNovoSal:= Round(nHNovoSal,MsDecimais(1))
			EndIf

			dbSelectArea("SRA")

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o Bloco para o Funcionario                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aPosicao1:={} // Limpa Arrays
			Aadd(aPosicao1,{0,0,0,0,0,0,0,0})

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualiza o Bloco para os Totalizadores                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nPos0 := nSalMes
			nPos1 := nSalHora
			nPos2 := nPerAum
			nPos3 := nVlAum
			nPos4 := Round(nNovoSal - nSalMes,MsDecimais(1))
			nPos5 := nNovoSal
			nPos6 := nHNovoSal
			nPos7 := nValArre

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Quando o Tipo de Pagamento For Semanal e as Categorias forem ³
			//³ Semanalista ou Tarefeiro, converte para o Salario da Semana  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF 	SRA->( RA_TIPOPGT = "S" .and. RA_CATFUNC $ "S*T" )
				nNovoSal := Round( ( ( nNovoSal / 30 ) * 7 ),MsDecimais(1))
			EndIF

			Atualiza(@aPosicao1,1,nPos0,nPos1,nPos2,nPos3,nPos4,nPos5,nPos6,nPos7)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualizando Totalizadores                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fAtuCont(@aToTFun1) // Funcao
			fAtuCont(@aToTCc1)  // Centro de Custo
			fAtuCont(@aTotFil1) // Filial
			fAtuCont(@aTotEmp1) // Empresa

			fImpFun()
			fTestaTotal()  // Quebras e Skips
		Enddo

		FImpTab()

	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Termino do relatorio                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("RB6")
	Set Filter To
	dbSetOrder(1)

	dbSelectArea("SRA")
	Set Filter To
	dbSetOrder(1)

	Set Device To Screen
	If aReturn[5] = 1
		Set Printer To
		Commit
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Spool caso Opcao seja de Relatorio, senao sai apresenta-lo.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ourspool(wnrel)
	Endif

	MS_FLUSH()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FTestaTotal  ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Testa as quebras do relatorio conforme ordem selecionada   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FTestaTotal()                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FTestaTotal()

dbSelectArea( "SRA" )
cFilialAnt := SRA->RA_FILIAL              // Iguala Variaveis
cCcAnt     := SRA->RA_CC
cFuAnt     := SRA->RA_CODFUNC
dbSkip()

If Eof() .Or. &cInicio > cFim
	fImpFu()
	fImpCc()
	fImpFil()
	fImpEmp()
Elseif cFilialAnt # SRA->RA_FILIAL
	fImpFu()
	fImpCc()
	fImpFil()
Elseif cCcAnt # SRA->RA_CC
	fImpCc()
Elseif cFuAnt # SRA->RA_CODFUNC
	fImpFu()
Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FImpFun      ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados dos funcionarios                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FImpFun()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FImpFun()
Local lRetu1	:= .T.
Local aFldRel	:= {"RA_NOME", "RA_ADMISSA"}

//Tratamento dados sensíveis
If aOfusca[2]
	aFldRel := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel )
	lOfuscaNom := aScan( aFldRel, {|x| x:cfield == "RA_NOME"}) > 0
	lOfuscaAdm := aScan( aFldRel, {|x| x:cfield == "RA_ADMISSA"}) > 0
EndIf

If nTipoRel == 2
	cDet := STR0012+SRA->RA_FILIAL+STR0013+SRA->RA_CC+STR0014+SRA->RA_MAT	//"FILIAL: "###" CCTO: "###" MAT: "
	cDet += STR0015+If(lOfuscaNom, Replicate('*',15),SRA->RA_NOME)+STR0016+If(lOfuscaAdm,Replicate('*',10),DtoC(SRA->RA_ADMISSA))				//" NOME: "###" DT.ADMISSAO: "
	Impr(cDet,"C")

	Impr("","C")

	lRetu1 := fImpComp(aPosicao1,1,.T.)

	cDet := Repl("-",132)
	Impr(cDet,"C")
	Impr("","C")
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FImpFu       ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados da funcao do funcionario                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FImpFu()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FImpFu()
Local lRetu1 := .T.

If Len(aTotFun1) == 0 .Or. nOrdem # 3
	Return Nil
Endif

cDet:=STR0017+cFilialAnt+STR0018+cFuAnt+" - "+DescFun(cFuAnt,cFilialAnt)	//"FILIAL: "###" FUNCAO: "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotFun1,1) // Imprime

aTotFun1 :={}      // Zera

cDet := Repl("=",132)
Impr(cDet,"C")
Impr("","C")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FImpCC       ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados do centro de custo                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FImpCC()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpCc()
Local lRetu1 := .T.

If Len(aTotCc1) == 0 .Or. nOrdem # 2
	Return Nil
Endif

cDet:=STR0019+cFilialAnt+STR0020+cCcAnt+" - "+DescCc(cCcAnt,cFilialAnt)	//"FILIAL: "###" CCTO: "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotCc1,1) // Imprime

aTotCc1 := {}      // Zera

cDet := Repl("=",132)
Impr(cDet,"C")
Impr("","C")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FImpFil      ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados da filial                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FImpFil()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FImpFil()
Local lRetu1 	:= .T.
Local cDescFil  := ""

If Len(aTotFil1) == 0
	Return Nil
Endif

cDescFil := aInfo[1] + Space(25)
cDet     := STR0021+cFilialAnt+" - "+cDescFil	//"FILIAL: "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotFil1,1) // Imprime

aTotFil1 := {}      // Zera

cDet := Repl("=",132)
Impr(cDet,"C")
Impr("","C")
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FImpEmp      ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados da Empresa                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FImpEmp()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FImpEmp()
Local lRetu1 := .T.

If Len(aTotEmp1) == 0
	Return Nil
Endif

cDet:=STR0022+aInfo[3]		//"EMPRESA: "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotEmp1,1) // Imprime

aTotEmp1 := {}      // Zera

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FImpComp     ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados ou do funcionario ou da funcao            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FImpFil(aArray, posicao)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FImpComp(aPosicao,nLugar)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ aPosicao = Array Contendo o que Vai ser Impresso            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCab1		:= cCab2 := ""
Local nResImp 	:= 0
Local lRet		:= .T.

AeVal(aPosicao,{ |X| nResImp += X[1] })  // Testa se a Soma == 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime se Possui Valores                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nResImp > 0
	If nOrdem # 3
		cDet := STR0023	//" SALARIO ANTIGO  SALARIO HORA ANTIGO  PERCENTUAL + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  SALARIO HORA NOVO  ARREDONDAMENTO"
		Impr(cDet,"C")
		cDet := "   "      +TRANSFORM(aPosicao[1,1],"@E 999999999.99")
		cDet += "         "+TRANSFORM(aPosicao[1,2],"@E 999999999.99")
		cDet += "  "       +TRANSFORM(aPosicao[1,3],"@E 999.999999")
		cDet += "      "   +TRANSFORM(aPosicao[1,4],"@E 999999999.99")
		cDet += "   "      +TRANSFORM(aPosicao[1,5],"@E 999999999.99")
		cDet += "  "       +TRANSFORM(aPosicao[1,6],"@E 999999999.99")
		cDet += "       "  +TRANSFORM(aPosicao[1,7],"@E 999999999.99")
		cDet += "    "     +TRANSFORM(aPosicao[1,8],"@E 999999999.99")
		Impr(cDet,"C")
	Else
		cDet := STR0024	//" SALARIO ANTIGO  PERCENTUAL + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  ARREDONDAMENTO"
		Impr(cDet,"C")
		cDet := "   "      +TRANSFORM(aPosicao[1,1],"@E 999999999.99")
		cDet += "  "       +TRANSFORM(aPosicao[1,3],"@E 999.999999")
		cDet += "      "   +TRANSFORM(aPosicao[1,4],"@E 999999999.99")
		cDet += "   "      +TRANSFORM(aPosicao[1,5],"@E 999999999.99")
		cDet += "  "       +TRANSFORM(aPosicao[1,6],"@E 999999999.99")
		cDet += "    "     +TRANSFORM(aPosicao[1,8],"@E 999999999.99")
		Impr(cDet,"C")
	Endif
	Li++
	lRet := .T.
Else
	lRet := .F.
Endif
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FAtuCont     ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Totaliza os arrays com os dados do funcionario             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FAtuCont(aArray)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FAtuCont(aArray1)
Local x := 0
Local z := 1
If  Len(aArray1) > 0
	For x:= 1 To 8
		If x != 3	// Soma Valores # Percentual
			aArray1[z,x] += aPosicao1[z,x]
		EndIf
	Next
Else
	aArray1 := aClone(aPosicao1)
EndIf
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CalcArre     ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula o arredondamento conforme parametro                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CalcArre()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CalcArre(nValor,nArred,nValArred)
Local nResto := 0

nResto := Mod(nValor,nArred)

If Round(nResto,2) > 0.00
	nValArred := nArred - nResto
	nValor    := nValor + nValArred
	If cPaisLoc == "PAR"
		nValor := Round(nValor,MsDecimais(1))
	EndIf
Else
	nValArred := 0.00
EndIf

Return( .T. )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Atualiza     ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega o array com os dados necessarios                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Atualiza()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Atualiza(aMatriz,nElem,nPos0,nPos1,nPos2,nPos3,nPos4,nPos5,nPos6,nPos7)

aMatriz[nElem,1] := nPos0
aMatriz[nElem,2] := nPos1
aMatriz[nElem,3] := nPos2
aMatriz[nElem,4] := nPos3
aMatriz[nElem,5] := nPos4
aMatriz[nElem,6] := nPos5
aMatriz[nElem,7] := nPos6
aMatriz[nElem,8] := nPos7
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FImpTab      ³ Autor ³ R.H- Cristina Ogura ³Data ³19/09/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados da tabela com os valores reajustados      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FImpTab())                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CSAR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FImpTab()
Local nx	:= 0

dbSelectArea("RB6")
dbSetOrder(1)
dbSeek(xFilial("RB6")+cTabela)

// Dados da tabela com o reajuste
IMPR("","P")
cDet := STR0027+ Transform(nPerAum,"999.999999")+ Space(05)+STR0028+ Transform(nVlAum,"999999999.99") 	//"% Aumento: "###"Valor Aumento: "
IMPR(cDet,"C")
IMPR("","C")

cDet :=	STR0029		//"Nivel Faixa   Vl. Reajustado   Vl. Anterior"
					//"   99    99     999999999999	  999999999999"
IMPR(cDet,"C")

For nx := 1 To Len(aTabela)
	cDet := ""
	cDet := Space(03)+aTabela[nx][1]
	cDet += Space(04)+aTabela[nx][2]
	cDet += Space(05)+Transform(aTabela[nx][3],"999999999.99")
	cDet += Space(03)+Transform(aTabela[nx][5],"999999999.99")
	IMPR(cDet,"C")
Next nx

IMPR("","F")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Cria_RBR	 ³ Autor ³ Renan Borges        ³ Data ³15.04.14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cria tabela RBR e RB6 caso seja informado uma 				³±±
±±³	nova data de referencia.						 								³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³CSAR030	                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function Cria_RBR()

Local cNivel := ""
Local nFaixa := 0
Local nNivel := 0
Local nReg   := 0
Local nX     := 0
Local aCpoAux := {}
Local aCpoAdd := {}
Local aCpoRB6 := {}
Local aCpoRBR := {}
Local aArea := GetArea()
Local cFaixaAnt := ""

//Adiciona campos criados pelo usuario atraves de Ponto de Entrada
If ExistBlock("CSR030CPO")
	aCpoAux := Execblock("CSR030CPO",.F.,.F.)
	If !Empty(aCpoAux)
		For nX := 1 To Len( aCpoAux )
			//Valida a existencia do campo no dicionario
			If CpoUsado( aCpoAux[nX] )
				Aadd( aCpoAdd, { aCpoAux[nX], ColumnPos(aCpoAux[nX]) } )
			EndIf
		Next nX
	EndIf
EndIf

While !Eof() .And. xFilial("RB6")+cTabela+DTOS(cDataRef) == RB6->RB6_FILIAL+RB6->RB6_TABELA+DTOS(RB6->RB6_DTREF)

			If !(cNivel == RB6->RB6_NIVEL)
				nNivel ++
				Aadd(aCpoRB6,{})
				cFaixaAnt := ''
				nFaixa := 0
				cNivel := RB6->RB6_NIVEL
			EndIf

			If lFaixaAlfa
				If !(cFaixaAnt == RB6->RB6_FAIXA)
					cFaixaAnt	:= RB6->RB6_FAIXA
					Aadd(aCpoRB6[nNivel],{})
					nFaixa := Len(aCpoRB6[nNivel])
				EndIf

			Else
				If !(nFaixa == Val(RB6->RB6_FAIXA))
					Aadd(aCpoRB6[nNivel],{})
					nFaixa := Val(RB6->RB6_FAIXA)
				EndIf

			EndIf

			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_FILIAL)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_TABELA)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_DESCTA)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_TIPOVL)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_NIVEL)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_FAIXA)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_VALOR)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_PTOMIN)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_PTOMAX)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_CLASSE)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_DTREF)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_COEFIC)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_REGIAO)
			Aadd(aCpoRB6[nNivel][nfaixa],RB6->RB6_ATUAL)

			//Adiciona campos criados pelo usuario
			If !Empty( aCpoAdd )
				For nX := 1 To Len(aCpoAdd)
					Aadd( aCpoRB6[nNivel][nfaixa], FieldGet(aCpoAdd[nX,2]) )
				Next nX
			EndIf

			dbSkip()

ENDDO

nFaixa := 1
nNivel := 1

dbSelectArea("RBR")
dbSetOrder(1)

If !lAtuDataNova
	dbSeek(xFilial("RBR")+cTabela+DTOS(cDataRef))
	Aadd(aCpoRBR,RBR->RBR_FILIAL)
	Aadd(aCpoRBR,RBR->RBR_TABELA)
	Aadd(aCpoRBR,RBR->RBR_DESCTA)
	Aadd(aCpoRBR,RBR->RBR_DTREF)
	Aadd(aCpoRBR,RBR->RBR_VLREF)
	Aadd(aCpoRBR,RBR->RBR_USAPTO)
	Aadd(aCpoRBR,RBR->RBR_APLIC)
	Aadd(aCpoRBR,RBR->RBR_TIPOVL)

	RecLock("RBR",.T.)
		RBR->RBR_FILIAL := aCpoRBR[1]
		RBR->RBR_TABELA := aCpoRBR[2]
		RBR->RBR_DESCTA := aCpoRBR[3]
		RBR->RBR_DTREF := cNovaRef
		RBR->RBR_VLREF := aCpoRBR[5]
		RBR->RBR_USAPTO := aCpoRBR[6]
		RBR->RBR_APLIC:=	 aCpoRBR[7]
		RBR->RBR_TIPOVL:=	 aCpoRBR[8]
	MsUnlock()

	For nNivel := 1 To Len(aCpoRB6)
		For nFaixa := 1 To Len(aCpoRB6[nNivel])
			RecLock("RB6",.T.)
				RB6->RB6_FILIAL := aCpoRB6[nNivel,nFaixa,1]
				RB6->RB6_TABELA := aCpoRB6[nNivel,nFaixa,2]
				RB6->RB6_DESCTA := aCpoRB6[nNivel,nFaixa,3]
				RB6->RB6_TIPOVL := aCpoRB6[nNivel,nFaixa,4]
				RB6->RB6_NIVEL  := aCpoRB6[nNivel,nFaixa,5]
				RB6->RB6_FAIXA  := aCpoRB6[nNivel,nFaixa,6]
				RB6->RB6_VALOR  := aCpoRB6[nNivel,nFaixa,7]
				RB6->RB6_PTOMIN := aCpoRB6[nNivel,nFaixa,8]
				RB6->RB6_PTOMAX := aCpoRB6[nNivel,nFaixa,9]
				RB6->RB6_CLASSE := aCpoRB6[nNivel,nFaixa,10]
				RB6->RB6_DTREF  := cNovaRef
				RB6->RB6_COEFIC := aCpoRB6[nNivel,nFaixa,12]
				RB6->RB6_REGIAO := aCpoRB6[nNivel,nFaixa,13]
				RB6->RB6_ATUAL  := aCpoRB6[nNivel,nFaixa,14]

				//Adiciona campos criados pelo usuario
				If !Empty( aCpoAdd )
					For nX := 1 To Len(aCpoAdd)
						FieldPut( aCpoAdd[nX,2], aCpoRB6[nNivel,nFaixa,aCpoAdd[nX,2]] )
					Next nX
				EndIf

			MsUnlock()
		Next
	Next

Else
	dbSelectArea("RB6")
	dbSetOrder(3)
	dbSeek(xFilial("RB6")+cTabela+DTOS(cNovaRef))
	While !Eof() .And. xFilial("RB6")+cTabela+DTOS(cNovaRef) == RB6->RB6_FILIAL+RB6->RB6_TABELA+DTOS(RB6->RB6_DTREF)
		RecLock("RB6",.F.)
			RB6->RB6_FILIAL := aCpoRB6[nNivel,nFaixa,1]
			RB6->RB6_TABELA := aCpoRB6[nNivel,nFaixa,2]
			RB6->RB6_DESCTA := aCpoRB6[nNivel,nFaixa,3]
			RB6->RB6_TIPOVL := aCpoRB6[nNivel,nFaixa,4]
			RB6->RB6_NIVEL  := aCpoRB6[nNivel,nFaixa,5]
			RB6->RB6_FAIXA  := aCpoRB6[nNivel,nFaixa,6]
			RB6->RB6_VALOR  := aCpoRB6[nNivel,nFaixa,7]
			RB6->RB6_PTOMIN := aCpoRB6[nNivel,nFaixa,8]
			RB6->RB6_PTOMAX := aCpoRB6[nNivel,nFaixa,9]
			RB6->RB6_CLASSE := aCpoRB6[nNivel,nFaixa,10]
			RB6->RB6_DTREF  := cNovaRef
			RB6->RB6_COEFIC := aCpoRB6[nNivel,nFaixa,12]
			RB6->RB6_REGIAO := aCpoRB6[nNivel,nFaixa,13]
			RB6->RB6_ATUAL  := aCpoRB6[nNivel,nFaixa,14]

			//Adiciona campos criados pelo usuario
			If !Empty( aCpoAdd )
				For nX := 1 To Len(aCpoAdd)
					FieldPut( aCpoAdd[nX,2], aCpoRB6[nNivel,nFaixa,aCpoAdd[nX,2]] )
				Next nX
			EndIf

		MsUnlock()
		dbSkip()
		If nNivel <> Val(RB6->RB6_NIVEL)
			nNivel := Val(RB6->RB6_NIVEL)
			nFaixa := 1
		Else
			nFaixa ++
		EndIf
	EndDo
EndIf

//-- Tratamento quando usar historico de tabela salarial para apagar o conteudo do campo RB6_ATUAL
//-- das versoes anteriores da tabela p/ indicar que os valores dessa tabela nao serao mais usados
If lHistorico
    If dbSeek(xFilial("RB6")+cTabela)
        While !EoF() .And. RB6->RB6_FILIAL+RB6->RB6_TABELA == xFilial("RB6")+cTabela
            If RB6->RB6_DTREF < cNovaRef
                RecLock("RB6", .F.)
                RB6->RB6_ATUAL := " "
                RB6->( MsUnlock() )
            EndIf
            dbSkip()
        EndDo
    EndIf
EndIf

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCsrDtRef	 ³ Autor ³ Renan Borges        ³ Data ³04.04.2017 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Valida "Data tabela Salarial?".                  			  ³±±
±±³                           					 						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³CSAR030	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function fCsrDtRef(cTab,cDt)
Local lRet	:= .F.

lRet := Existcpo("RB6",cTab+cDt,3)
Return lRet
