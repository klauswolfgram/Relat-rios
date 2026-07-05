/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PONR140.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONCALEN.CH"

Static lPort1510 	:= Port1510() 	//Verifica se Portaria 1510/2009 esta em vigor.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PONR140  ³ Autor ³ Leandro Drumond       ³ Data ³ 11.11.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Espelho do Ponto (De acordo com Portaria 1510/2009)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR140(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia C.  ³21/05/14³TPQAN3³Incluido o fonte da 11 para a 12 e efetua-³±±
±±³            ³        ³      ³da a limpeza.                             ³±±
±±³Luis Artuso ³26/05/15³TSGSFC³Ajuste para nao imprimir o motivo de  mar-³±±
±±³            ³        ³      ³cacoes quando houver intervalo pre-assina-³±±
±±³            ³        ³      ³lado, conf. portaria 2233/09.             ³±±
±±³Luis Artuso ³21/07/15³TSXQSN³Ajuste para gerar nova linha, quando hou- ³±±
±±³            ³        ³      ³ver marcacoes efetuadas no mesmo dia para ³±±
±±³            ³        ³      ³outra jornada. As alteracoes efetuadas    ³±±
±±³            ³        ³      ³neste chamado atendem ao art. 89 da porta-³±±
±±³            ³        ³      ³ria 1510, que determina que jornadas que  ³±±
±±³            ³        ³      ³iniciem em um dia e terminem em outro,    ³±±
±±³            ³        ³      ³uma nova linha deve ser criada com a data ³±±
±±³            ³        ³      ³e os respectivos horarios 'alocados' de   ³±±
±±³            ³        ³      ³acordo com o tipo de marcacao. 	 		  ³±±
±±³            ³        ³      ³Para melhor entendimento, consulte o item ³±±
±±³            ³        ³      ³'c' do modelo de espelho de ponto, atraves³±±
±±³            ³        ³      ³do link: http://migre.me/qQt4l			  ³±±
±±³            ³        ³      ³Para uma consulta mais detalhada, acesse: ³±±
±±³            ³        ³      ³http://migre.me/qQtrY					  ³±±
±±³Oswaldo L.  ³03/04/17³DRHPONTP-164  ³Projeto cTree                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function Ponr140()

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define Variaveis Locais (Basicas)                            ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local aArea			:= GetArea()
Local cDesc1		:= STR0001  // 'Espelho do Ponto'
Local cDesc2		:= STR0002  // 'Ser  impresso de acordo com os parametros solicitados pelo'
Local cDesc3		:= STR0003  // 'usuario.'
Local cString		:= 'SRA' //-- Alias do arquivo principal (Base)
Local aOrd			:= {STR0031, STR0006, STR0004, STR0005+" + "+STR0031} // 'PIS', 'Nome', 'Matricula', 'Centro de Custo + PIS'
Local wnRel			:= ""
Local cHtml			:= ""
Local cMsg			:= ""
Local cAviso		:= ""
Local aFilesOpen	:= {"SP5", "SPN", "SP8", "SPG","SPB","SPL","SPC", "SPH", "SPF"}
Local bCloseFiles	:= {|cFiles| If( Select(cFiles) > 0, (cFiles)->( DbCloseArea() ), NIL) }
Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {"",""} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
Local aFldRel		:= {"RA_NOME", "RA_RACACOR"}
Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define Variaveis Private(Basicas)                            ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private aReturn  := {STR0008 , 1, STR0009 , 2, 2, 1, '',1 } // 'Zebrado'###'Administra‡„o'
Private nomeprog := 'PONR140'
Private aLinha   := {}
Private nLastKey := 0
Private cPerg    := 'PNR140'

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define variaveis Private utilizadas no programa RDMAKE ImpEsp³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private aImp      := {}
Private aHoras	  := {}
Private aTotais   := {}
Private aAbonados := {}
Private nImpHrs   := 0

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis Utilizadas na funcao IMPR                          ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private Titulo   := OemToAnsi(STR0001 ) // 'Espelho do Ponto'
Private cCabec   := ''
Private AT_PRG   := 'PONR140'
Private wCabec0  := 1
Private wCabec1  := ''
Private CONTFL   := 1
Private LI       := 0
Private nTamanho := 'G'

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define Variaveis Private(Programa)                           ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private dPerIni  := Ctod("//")
Private dPerFim  := Ctod("//")
Private cIndCond := ''
Private cFilSPA	 := IF(Len(Alltrim(xFilial("SPA"))) < FWGETTAMFILIAL,Space(FWGETTAMFILIAL),SRA->RA_FILIAL)
Private cFor     := ''
Private nOrdem   := 0
Private cAponFer := ''
Private aInfo    := {}
Private aTurnos  := {}
Private aPrtTurn := {}
Private nColunas := 0

//Tratamento de acesso a Dados Sensíveis
If lBlqAcesso
	//"Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
	Help(" ",1,aOfusca[3,1],,aOfusca[3,2],1,0)
	Return
EndIf

If lPort1510
	Titulo += fPortTit() //Complementa titulo da tela com dizeres referente a portaria.
EndIf

//Se Portaria estiver ativada, verifica se base esta OK
If lPort1510
	//-- Verifica se foi possivel abrir os arquivos sem exclusividade
	If ! Pn090Open(@cMsg, @cAviso)
		MsgStop( cMsg, cAviso )
		Return
	EndIf
EndIf


/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Parƒmetro MV_COLMARC										   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
nColunas := SuperGetmv("MV_COLMARC")
IF ( nColunas == NIL )
	Help("", 1, "MVCOLNCAD")
	Return( .F. )
EndIF

aReturn[4]	:= 1

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³O numero de colunas eh sempre aos pares					   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
nColunas *= 2

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Envia controle para a funcao SETPRINT                        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Nome Default do relatorio em Disco							   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
wnrel := "PONR140"
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Inicializa a SetPrint										   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
wnrel := SetPrint(cString, wnrel, cPerg, Titulo, cDesc1, cDesc2, cDesc3, .F., aOrd, ,nTamanho)

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define a Ordem do Arquivo Principal SRA                      ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
nOrdem := aReturn[8]

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Verifica as perguntas selecionadas                           ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Pergunte( "PNR140" , .F. )

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
FilialDe	:= mv_par01						//Filial  De
FilialAte	:= mv_par02						//Filial  Ate
CcDe		:= mv_par03						//Centro de Custo De
CcAte		:= mv_par04						//Centro de Custo Ate
TurDe		:= mv_par05						//Turno De
TurAte		:= mv_par06						//Turno Ate
MatDe		:= mv_par07						//Matricula De
MatAte		:= mv_par08						//Matricula Ate
NomDe		:= mv_par09						//Nome De
NomAte		:= mv_par10						//Nome Ate
cSit		:= mv_par11						//Situacao
cCat		:= mv_par12						//Categoria
nCopias		:= If(mv_par13>0,mv_par13,1)	//N£mero de C¢pias
lSemMarc	:= (mv_par14==1)				//Imprime para Funcion rios sem Marca‡oes
dPerIni     := mv_par15						//Data Contendo o Inicio do Periodo de Apontamento
dPerFim     := mv_par16						//Data Contendo o Fim  do Periodo de Apontamento

Begin Sequence

	IF !( nLastKey == 27 )

		SetDefault( aReturn , cString )

		IF Empty( dPerIni ) .or. Empty( dPerFim )
			Help(" ",1,"PONFORAPER" , , OemToAnsi( STR0015 ) , 5 , 0  )	//'Periodo de Apontamento Invalido.'
			Break
		EndIF

		IF !( nLastKey == 27 )

		    RptStatus( { |lEnd| Pnr140Imp(@lEnd, wNRel, cString ) } , Titulo )

		EndIF

	EndIF

End Sequence

Return( cHtml )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PNR140Imp³ Autor ³ Leandro Drumond       ³ Data ³ 11.11.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Espelho do Ponto                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Pnr140Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Pnr140Imp( lEnd , WnRel ,cString )

Local aComplPer		:= {}
Local aAbonosPer	:= {}
Local aEventos      := {}
Local cFil			:= ""
Local cMat			:= ""
Local cTno			:= ""
Local cLastFil		:= "__cLastFil__"
Local cAcessaSRA	:= &("{ || " + ChkRH("PONR140","SRA","2") + "}")
Local cSeq			:= ""
Local cTurno		:= ""
Local cHtml			:= ""
Local cFilRFE		:= ""
Local cIdFalta  	:= "007N*008A*009N*010A*033N*032A*035N*034A"
Local lSPJExclu		:= !Empty( xFilial("SPJ") )
Local lSP9Exclu		:= !Empty( xFilial("SP9") )
Local lRobo			:= IsBlind()
Local nCount		:= 0.00
Local nX			:= 0.00
Local lMvAbosEve	:= .F.
Local lMvSubAbAp	:= .F.

Local aRFEFields	:= RFE->( dbStruct() )
Local nRFEFields	:= Len( aRFEFields	)

Private aFuncFunc  := {SPACE(1), SPACE(1), SPACE(1), SPACE(1), SPACE(1), SPACE(1)}
Private aMarcacoes := {}
Private aTabPadrao := {}
Private aTabCalend := {}
Private aPeriodos  := {}
Private cHeader    := ""
Private cCodAtras  := ""
Private dIniCale   := Ctod("//")	//-- Data Inicial a considerar para o Calendario
Private dFimCale   := Ctod("//")	//-- Data Final a considerar para o calendario
Private dMarcIni   := Ctod("//")	//-- Data Inicial a Considerar para Recuperar as Marcacoes
Private dMarcFim   := Ctod("//")	//-- Data Final a Considerar para Recuperar as Marcacoes
Private dIniPonMes := Ctod("//")	//-- Data Inicial do Periodo em Aberto
Private dFimPonMes := Ctod("//")	//-- Data Final do Periodo em Aberto
Private lImpAcum   := .F.
Private oTmpARQREL
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Como a Cada Periodo Lido reinicializamos as Datas Inicial e Fi³
³nal preservamos-as nas variaveis: dCaleIni e dCaleFim.		   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
dIniCale   := dPerIni   //-- Data Inicial a considerar para o Calendario
dFimCale   := dPerFim   //-- Data Final a considerar para o calendario

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Inicializa Variaveis Static								   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
RstGetTabExtra()

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Seleciona a Ordem do Funcionario e Monta chave para  posiciona³
³namento													   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
dbSelectArea('SRA')
SRA->( dbSetOrder( RetOrder("SRA","RA_FILIAL+RA_MAT") ) )

cInicio  := 'RA_FILIAL + RA_MAT'
SRA->( MsSeek( FilialDe + MatDe , .T. ) )
cFim := FilialAte + MatAte


U_fCriaArq(nOrdem)

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Inicializa R‚gua de Impress„o								   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
SetRegua( SRA->( RecCount() ) )

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Processa o Cadastro de Funcionarios						   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
While SRA->( !Eof() .and. &(cInicio) <= cFim )

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Incrementa a R‚gua de Impress„o							   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IncRegua()

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Cancela a Impress„o 										   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF ( lEnd )
		Impr( cCancela , 'C' )
		Exit
	EndIF

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Consiste controle de acessos e filiais validas               ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF SRA->( !( RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA ) )
		SRA->( dbSkip() )
		Loop
	EndIF

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Consiste Parametrizacao do Intervalo de Impressao            ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF SRA->(;
				(  RA_TNOTRAB	< Turde ) .or. ( 	RA_TNOTRAB	> TurAte ) .or. ;
				(  RA_NOME 		< NomDe ) .or. ( 	RA_NOME 	> NomAte ) .or. ;
				(  RA_MAT 		< MatDe ) .or. ( 	RA_MAT 		> MatAte ) .or. ;
				(  RA_CC 		< CCDe  ) .or. ( 	RA_CC 		> CCAte	 ) .or. ;
				!( RA_SITFOLH	$ cSit	) .or. !(	RA_CATFUNC	$ cCat	 );
			)
		SRA->( dbSkip() )
		Loop
	EndIF

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Consiste a data de Demiss„o								   ³
	³Se o Funcionario Foi Demitido Anteriormente ao Inicio do Perio³
	³do Solicitado Desconsidera-o								   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !Empty(SRA->RA_DEMISSA) .and. ( SRA->RA_DEMISSA < dIniCale )
		SRA->( dbSkip() )
		Loop
	EndIF

	cFilRFE		:= fFilFunc("RFE")

    /*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Verifica a Troca de Filial           						  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !( SRA->RA_FILIAL == cLastFil )

		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Alimenta as variaveis com o conteudo dos MV_'S correspondetes³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		lMvAbosEve	:= ( Upper(AllTrim(SuperGetMv("MV_ABOSEVE",NIL,"N",cLastFil))) == "S" )	//--Verifica se Deduz as horas abonadas das horas do evento Sem a necessidade de informa o Codigo do Evento no motivo de abono que abona horas
		lMvSubAbAp	:= ( Upper(AllTrim(SuperGetMv("MV_SUBABAP",NIL,"N",cLastFil))) == "S" )	//--Verifica se Quando Abono nao Abonar Horas e Possuir codigo de Evento, se devera Gera-lo em outro evento e abater suas horas das Horas Calculadas

	    /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Atualiza a Filial Corrente           						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		cLastFil := SRA->RA_FILIAL

	    /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega periodo de Apontamento Aberto						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF !CheckPonMes( @dPerIni , @dPerFim , .F. , .T. , .F. , cLastFil )
			Exit
		EndIF

    	/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Obtem datas do Periodo em Aberto							  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		GetPonMesDat( @dIniPonMes , @dFimPonMes , cLastFil )

	    /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega as Tabelas de Horario Padrao						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF ( lSPJExclu .or. Empty( aTabPadrao ) )
			aTabPadrao := {}
			fTabTurno( @aTabPadrao , IF( lSPJExclu , cLastFil , NIL ) )
		EndIF

		aEventos := {}

	EndIF

	If Empty(aEventos)
		aEventos  := GetEveIdPon( Nil , xFilial('SRA') , Nil )
		aEval( aEventos, { |x|	IF( x[1] $ cIdFalta , cCodAtras+= ( x[2] + "*" ), '' ) } )
	EndIf

   	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Retorna Periodos de Apontamentos Selecionados				  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	aPeriodos := Monta_per( dIniCale , dFimCale , cLastFil , SRA->RA_MAT , dPerIni , dPerFim )

   	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Corre Todos os Periodos 									  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	naPeriodos := Len( aPeriodos )
	For nX := 1 To naPeriodos

   		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Reinicializa as Datas Inicial e Final a cada Periodo Lido.	  ³
		³Os Valores de dPerIni e dPerFim foram preservados nas   varia³
		³veis: dCaleIni e dCaleFim.									  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
        dPerIni		:= aPeriodos[ nX , 1 ]
        dPerFim		:= aPeriodos[ nX , 2 ]

   		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Obtem as Datas para Recuperacao das Marcacoes				  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
        dMarcIni	:= aPeriodos[ nX , 3 ]
        dMarcFim	:= aPeriodos[ nX , 4 ]

   		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Verifica se Impressao eh de Acumulado						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		lImpAcum := ( dPerFim < dIniPonMes )

	    /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Retorna Turno/Sequencia das Marca‡”es Acumuladas			  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF ( lImpAcum )
			IF SPF->( dbSeek( SRA->( RA_FILIAL + RA_MAT ) + Dtos( dPerIni) ) ) .and. !Empty(SPF->PF_SEQUEPA)
				cTurno	:= SPF->PF_TURNOPA
				cSeq	:= SPF->PF_SEQUEPA
			Else
	    		/*
				ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				³ Tenta Achar a Sequencia Inicial utilizando RetSeq()³
				ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
				IF !RetSeq(cSeq,@cTurno,dPerIni,dPerFim,dDataBase,aTabPadrao,@cSeq) .or. Empty( cSeq )
	    			/*
					ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					³Tenta Achar a Sequencia Inicial utilizando fQualSeq()		  ³
					ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
					cSeq := fQualSeq( NIL , aTabPadrao , dPerIni , @cTurno )
				EndIF
			EndIF
		Else
   			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³Considera a Sequencia e Turno do Cadastro            		  ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			cTurno	:= SRA->RA_TNOTRAB
			cSeq	:= SRA->RA_SEQTURN
		EndIF

	    /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega Arrays com as Marca‡”es do Periodo (aMarcacoes), com³
		³o Calendario de Marca‡”es do Periodo (aTabCalend) e com    as³
		³Trocas de Turno do Funcionario (aTurnos)					  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		( aMarcacoes := {} , aTabCalend := {} , aTurnos := {} )
	    /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Importante: 												  ³
		³ O periodo fornecido abaixo para recuperar as marcacoes   cor³
		³ respondente ao periodo de apontamentoo Calendario de 	 Marca³
		³ ‡”es do Periodo ( aTabCalend ) e com  as Trocas de Turno  do³
		³ Funcionario ( aTurnos ) integral afim de criar o  calendario³
		³ com as ordens correspondentes as gravadas nas marcacoes	  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		GetMarcacoes(	@aMarcacoes					,;	//01 -> Marcacoes dos Funcionarios
						@aTabCalend					,;	//02 -> Calendario de Marcacoes
						@aTabPadrao					,;	//03 -> Tabela Padrao
						@aTurnos					,;	//04 -> Turnos de Trabalho
						dPerIni 					,;	//05 -> Periodo Inicial
						dPerFim						,;	//06 -> Periodo Final
						SRA->RA_FILIAL				,;	//07 -> Filial
						SRA->RA_MAT					,;	//08 -> Matricula
						cTurno						,;	//09 -> Turno
						cSeq						,;	//10 -> Sequencia de Turno
						SRA->RA_CC					,;	//11 -> Centro de Custo
						IF(lImpAcum,"SPG","SP8")	,;	//12 -> Alias para Carga das Marcacoes
						NIL							,;	//13 -> Se carrega Recno em aMarcacoes
						.T.							,;	//14 -> Se considera Apenas Ordenadas
					    .T.    						,;	//15 -> Se Verifica as Folgas Automaticas
					  	.F.    			 			,;	//16 -> Se Grava Evento de Folga Automatica Periodo Anterior
						NIL							,;	//17 -> Se Carrega as Marcacoes Automaticas
						NIL	    					,;	//18 -> Registros de Marcacoes Automaticas que deverao ser Desprezadas
						NIL							,;	//19 -> Bloco para avaliar as Marcacoes Automaticas que deverao ser Desprezadas
						NIL							,;	//20 -> Se Considera o Periodo de Apontamento das Marcacoes
						NIL							,;	//21 -> Se Efetua o Sincronismo dos Horarios na Criacao do Calendario
						.T.			 				 ;  //22 -> Se carrega as marcacoes desconsideradas (Uso com lPort1510)
				 	)

		If Empty(aMarcacoes) .and. !lSemMarc
			Loop
		EndIf

       	/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Monta a Query das Marcacoes mensais						   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		SetTempTab(aMarcacoes, dPerIni, dPerFim  )

		dbSelectArea("SRA")

	Next nX

    SRA->( dbSkip() )

End While

GetMarcTab(dPerIni, dPerFim)

//P140ApIndice(cArqNome)
dbSelectArea("ARQREL")
dbCloseArea()

If oTmpARQREL <> Nil
	oTmpARQREL:Delete()
	Freeobj(oTmpARQREL)
EndIf
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Termino do relatorio                                         ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

dbSelectArea('SRA')
dbSetOrder(1)

If lRobo
	Set Device To Screen
EndIf

IF ( aReturn[5] == 1 )
	Set Printer To
	dbCommit()
	OurSpool(wnrel)
EndIF

Ms_Flush()

Return( cHtml )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FImpFun   ³ Autor ³ Leandro Drumond       ³ Data ³ 11/11/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o espelho do ponto do funcionario                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpFun( aImp , nColunas , aHoras )

Local aLinOrg		:= {} //Marcações Originais
Local aLinJrn		:= {} //Jornada Realizada
Local aLinTrt		:= {} //Marcações Tratadas
Local cDet      	:= ""
Local cHtml			:= ""
Local cOcorr		:= ""
Local cAbHora		:= ""
Local cCodHor		:= ""
Local cLinOrg		:= ""
Local cLinJrn		:= ""
Local cLinTrt		:= ""
Local cSpaceMotivo 	:= Space( GetSx3Cache( "P8_MOTIVRG" , "X3_TAMANHO" ) )
Local dData			:= CtoD("//")
Local dDataApo		:= CtoD("//")
Local lZebrado		:= .F.
Local nLinOrg		:= 0
Local nLinJrn		:= 0
Local nLin			:= 0
Local nX        	:= 0.00
Local nY        	:= 0.00
Local nFor      	:= 0.00
Local nCol      	:= 0.00
Local nColMarc  	:= 0.00
Local nTamLin   	:= 0.00
Local nMin			:= 0.00
Local nLenImp		:= 0.00
Local nLenImpnX		:= 0.00
Local nTamAuxlin	:= 0.00
Local nAbHora		:= 0
Local nPos		 	:= 0
Local lAltData		:= .F.
Local lPrntHead		:= .T.
Local cOrdem		:= ""

//-- Define o tamanho da linha com base no MV_ColMarc.
aEval(aImp, { |x| nColMarc := If(Len(x)-3>nColMarc, Len(x)-3, nColMarc) } )
nColMarc += If(nColMarc%2 == 0, 0, 1)
//-- Calcula Tamanho e Tipo de Impressao de modo a conter integralmente o cabecalho.

nTamanho	:='G'
aReturn[4]	:= 1

//-- Calcula a Maior das Qtdes de Colunas existentes
nColunas := Max(nColunas, nColMarc)

//-- Define configura‡”es da impress„o
nTamLin    	:= 220

//-- Inicializa Li com 1 para n„o imprimir cabecalho padrao
Li := 01

// Atualiza o intervalo de data do período referente à data da primeira marcação com data de apontamento preenchida
nPos := AScan(aImp, {|x| !Empty(x[2])})
If (nPos > 0)
	UpdDtPer(aImp[nPos][2])
EndIf

//-- Imprime Cabecalho Especifico.
Imp_Cabec( nTamLin , nColunas ,  nTamanho , aHoras , aImp[Len(aImp),9] , aImp[Len(aImp),10] , aImp[Len(aImp),11])

//-- Imprime Marca‡”es
nLenImp := Len(aImp)
For nX := 1 To nLenImp

	dData    := aImp[nX,01]
	dDataApo := aImp[nX,02]

	cCodHor  := aImp[nX,08]

	If (cOrdem <> aImp[nX,03])
		aLinOrg		:= {} //Marcações Originais
		aLinJrn		:= {} //Jornada Realizada
		aLinTrt		:= {} //Marcações Tratadas
		nLinOrg		:= 0
		nLinJrn		:= 0

	Else

		If !( LEN(aLinOrg) == 0 )
			aLinOrg[LEN(aLinOrg) , 1]	:= NIL
		EndIf

		If !( LEN(aLinJrn) == 0 )
			aLinJrn[LEN(aLinJrn) , 1]	:= NIL
		EndIf

		If !( LEN(aLinTrt) == 0 )
			aLinTrt[LEN(aLinTrt) , 1]	:= NIL
		EndIf

	EndIf

	cDet := ""

	lFim	:= .F.
	Do While ( !(lFim) .AND. (nX <= nLenImp) )
		cOrdem	:= aImp[nX,03]
		//-- Verifica se a data da jornada e a data do apontamento da marcacao sao iguais,
		//-- ou se a ordem da marcacao eh a mesma da anterior (mesma jornada)
		If !(ValType(aImp[nX,04]) == "N")
			If nLinOrg == 0
				aAdd(aLinOrg,Array(04))
			EndIf
			Loop
		EndIf

		If aImp[nX,05] == "O"
			If nLinOrg == 0
				aAdd(aLinOrg,Array(04))
			EndIf

			nLinOrg++
			aLinOrg[Len(aLinOrg),nLinOrg] := aImp[nX,04]
		EndIf

		If !(aImp[nX,06] == "D")
			If nLinJrn == 0
				aAdd(aLinJrn,Array(07))
				aLinJrn[Len(aLinJrn),07] := aImp[nX,08]
			EndIf

			nLinJrn++
			aLinJrn[Len(aLinJrn),nLinJrn] := aImp[nX,04]
		EndIf

		If (aImp[nX,06] == "D")
			aAdd(aLinTrt, { aImp[nX,04] , aImp[nX,06] , aImp[nX,07] } )
		ElseIf (aImp[nX,05] == "I")
			aAdd(aLinTrt, { aImp[nX,04] , aImp[nX,05] , aImp[nX,07] } )
		ElseIf (aImp[nX,05] == "P")
			aAdd(aLinTrt, { aImp[nX,04] , aImp[nX,05] , cSpaceMotivo } )
		EndIf

		If nLinJrn == 6
			nLinJrn := 0
		EndIf

		If nLinOrg == 4
			nLinOrg := 0
		EndIf
		lFim	:= ( (nX < nLenImp) .AND. ( !(cOrdem == aImp[nX+1,03]) .OR. (lAltData) .Or. Empty(cOrdem)) )
		If !( lFim )
			nX++
		EndIf
	EndDo

	nLenImpnX := Max(Len(aLinOrg),Max(Len(aLinJrn),Len(aLinTrt)))

	For nY := 1 to nLenImpnX

		cLinOrg 	:= " "
		cLinJrn		:= " "
		cLinTrt 	:= " "
		cDet    	:= ""
		lPrntHead 	:= .T.

		If nY <= Len(aLinOrg) .and. ValType(aLinOrg[nY]) == "A"
			For nLin := 1 to Len(aLinOrg[nY])
				If ValType(aLinOrg[nY,nLin])=="U"
					cLinOrg += Space(05)//"     "
				Else
					cLinOrg += StrTran(StrZero(aLinOrg[nY,nLin],5,2),'.',':')
				EndIf

				cLinOrg += Space(01)//" "
			Next nLin
		EndIf

		If nY <= Len(aLinJrn) .and. ValType(aLinJrn[nY]) == "A"
			For nLin := 1 to Len(aLinJrn[nY])
				If ValType(aLinJrn[nY,nLin])=="U"
					If nLin % 2 == 0
						cLinJrn += Space(06)//"      "
					Else
						cLinJrn += Space(08)//"        "
					EndIf
				Else
					If nLin == 7
						cLinJrn += PADR(aLinJrn[nY,nLin],5)
					Else
						If nLin % 2 == 0
							cLinJrn += PADR(StrTran(StrZero(aLinJrn[nY,nLin],5,2),'.',':'),6)
						Else
							cLinJrn += PADR(StrTran(StrZero(aLinJrn[nY,nLin],5,2),'.',':'),8)
						EndIf
					EndIf
				EndIf

				If nLin < 7
					cLinJrn += "| "
				EndIf
			Next nLin
		Else
			cLinJrn := Space(09) + "|" + Space(07) + "|" + Space(09) + "|" + Space(07) + "|" + Space(09) + "|" + Space(07) + "| " + PADR(cCodHor,5)  //"         |       |         |       |         |       | " + PADR(cCodHor,5)
		EndIf

		If nY <= Len(aLinTrt) .and. ValType(aLinTrt[nY]) == "A"
			If ValType(aLinTrt[nY,1])=="U"
				cLinTrt += Space(08) + "| " //"        | "
			Else
				cLinTrt += StrTran(StrZero(aLinTrt[nY,1],5,2),'.',':') + "   | "
			EndIf

			If Empty(aLinTrt[nY,2])
				cLinTrt += "      | "
			Else
				cLinTrt += PADR(aLinTrt[nY,2],5) + " | "
			EndIf

			If ValType(aLinTrt[nY,3])=="U"
				cLinTrt += Space(99)//"                                                                                                   "
			Else
				If aLinTrt[nY,2] == "P"
					cLinTrt += PADR("",99)
				Else
					cLinTrt += PADR(aLinTrt[nY,3],99)
				EndIf
			EndIf
		Else
			cLinTrt := Space(09) + "|" + Space(07) + "|" + Space(100) //"         |       |                                                                                                    "
		EndIf

		// Verifica se a data de apontamento atual é maior que a data final do período
		// (significa que o registro atual é de um período diferente do período atual)
		If (dDataApo > dPerFim)
			// Atualiza o intervalo de data do período referente à marcação atual
			UpdDtPer(dDataApo)

			// Verifica se cabe na página a quebra por período (Li <= 51)
			// Se sim, faz a quebra por período
			If (Li <= 51)
				Impr(Space(nTamLin), 'C')

				cDet := STR0017 + DtoC(dPerIni) + ' - ' + DtoC(dPerFim)		// 'Período: DD/MM/AAAA - DD/MM/AAAA
				Impr(cDet, 'C')

				//--Inicio do Espelho de Ponto--//
				//'|   	 |                                |                                                     |      |                                                                                                                      |'
				cDet := "|" + Space(5) + "|" + Space(32) + "|" + Space(53) + "|" + Space(06) + "|" + Space(118) + "|"
				Impr(cDet, 'C')

				//'| Dia | Marcações registradas no ponto |                  Jornada realizada                  |  CH  |                                    Tratamentos efetuados sobre os dados originais                                    |'
				cDet := "| " + STR0016 + " | " + STR0022 + " | " + Space(17) + STR0023 + Space(18) + "|  CH  |" + Space(36) + STR0021 + " " + STR0024 + Space(36) + "|"
				Impr(cDet, 'C')

				//'|     |           eletrônico           | Entrada | Saída | Entrada | Saída | Entrada | Saída |      | Horário | Ocor. | Motivo                                                                                             |'
				cDet := "|" + Space(05) + "|" + Space(11) + STR0025 + Space(10) + " | " + STR0019 + " | " + STR0020 + " | " + STR0019 + " | " + STR0020 + " | " + STR0019 + " | " + STR0020 + " | " + Space(04) + " | " + STR0026 + " | " + STR0027 + " | " + STR0028 + Space(93) + "|"
				Impr(cDet, 'C')

			// Caso contrário e se Li <= 57, significa que não seria feita a quebra por cabeçalho
			// e não caberia a quebra por período, então é preciso forçar a quebra por cabeçalho (que faz a quebra por página junto)
			ElseIf (Li <= 57)
				Imp_Cabec( nTamLin , nColunas ,  nTamanho , aHoras , aImp[Len(aImp),9] , aImp[Len(aImp),10] , aImp[Len(aImp),11])

				// Flag para não imprimir 2 vezes o cabeçalho
				lPrntHead := .F.
			EndIf
		EndIf

		cDet := "| " + SubStr(DtoC(dData),1,2) + "  |" + PADR(cLinOrg,32) + "|" + cLinJrn + "|" + cLinTrt + "|"

		If Li > 57 .and. lPrntHead
			Imp_Cabec( nTamLin , nColunas ,  nTamanho , aHoras , aImp[Len(aImp),9] , aImp[Len(aImp),10] , aImp[Len(aImp),11])
		EndIf

		Impr(cDet,'C',NIL,NIL,NIL,NIL,NIL,{||},{||})
	Next

Next nX

Return( cHtml )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Imp_Cabec ³ Autor ³ Leandro Drumond       ³ Data ³ 11/11/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o cabecalho do espelho do ponto                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR140                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Imp_Cabec(nTamLin ,nColunas, nTamanho , aHoras , cPis , cNome , dDtAdmis)

Local cDet			:= ""
Local cEnt1			:= ""
Local cEnt2			:= ""
Local cSai1			:= ""
Local cSai2			:= ""
Local cHtml			:= ""
Local cPict			:= ""
Local cTipInsc		:= 0
Local cEmpregador	:= ""
Local cCNPJ			:= ""
Local nX			:= 0.00

//-- Inicializa a impress„o

@ 0,0 PSAY AvalImp(nTamLin )

//-- Inicializa Li com 1 para n„o imprimir cabecalho padrao
Li := 01

//-- Linha 01
//-- Relatório Espelho de Ponto Eletrônico
cDet := STR0029 // Relatório Espelho de Ponto Eletrônico
Impr(cDet,'C')

//-- Linha 02
//-- Empregador: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
If Len(aInfo)>0
	cTipInsc	:= aInfo[15]
	cCNPJ		:= aInfo[08]
	cEmpregador	:= aInfo[03]
Else
	cTipInsc    := SM0->M0_TpInsc
	cCNPJ 		:= SM0->M0_CGC
	cEmpregador	:= SM0->M0_NomeCom
Endif

//-- Define a Picture de identificador do Empregador
If cTipInsc == 1			// CEI
  cPict	 :="@R ###.###.###-##"
ElseIF cTipInsc == 3		// CPF
  cPict	 :="@R ###.###.###-##"
Else    //CNPJ
    cPict	 :="@!R NN.NNN.NNN/NNNN-99"
EndIf
//STR0037 "CNPJ/CEI/CPF"
cDet := STR0030  + 	STR0037 + SPACE(1) + Transform(cCNPJ,cPict) + ' - ' + PADR( cEmpregador , 50)  // 'Empregador: "
Impr(cDet,'C')

//-- Linha 03
//-- Endereço:   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
cDet := STR0010  + "  " + PADR( If(Len(aInfo)>0,aInfo[04],SM0->M0_EndCob) , 50)  // 'Endereço: "
Impr(cDet,'C')

//-- Linha 04
//-- Empregado:  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
cDet := STR0011  +  " " + STR0031 + SPACE(1) + cPis	 + " - " + cNome // 'Empregado: '
Impr(cDet,'C')

//-- Linha 05
//-- Admissao:   XX/XX/XXXX
cDet := STR0012 + "  " + DtoC(dDtAdmis)   // 'Admissão: '
Impr(cDet,'C')

//-- Linha 06
//-- Relatório Emitido em: XX/XX/XXXX
cDet := STR0013 + DtoC(dDataBase) // 'Relatório emitido em: '
Impr(cDet,'C')

Impr(Space(nTamLin),'C')
Impr(Space(nTamLin),'C')

//-- Linha 08
//-- Horários contratuais do empregado:
cDet := STR0014		// 'Horários contratuais do empregado: '
Impr(cDet,'C')

If Len(aHoras) > 0

	cDet := "| " + STR0018 + " | " + STR0019 + " | " + STR0020	 + " | " + STR0019 + " | " + STR0020 + " |" 	// '| Código de Horário (CH) | Entrada | Saída | Entrada | Saída |'
	Impr(cDet,'C')

	For nX := 1 to Len(aHoras)
		cEnt1 := If (ValType(aHoras [nX,02,01])=="U",Space(5),StrTran(StrZero(aHoras [nX,02,01],5,2),'.',':'))
		cSai1 := If (ValType(aHoras [nX,02,02])=="U",Space(5),StrTran(StrZero(aHoras [nX,02,02],5,2),'.',':'))
		cEnt2 := If (ValType(aHoras [nX,02,03])=="U",Space(5),StrTran(StrZero(aHoras [nX,02,03],5,2),'.',':'))
		cSai2 := If (ValType(aHoras [nX,02,04])=="U",Space(5),StrTran(StrZero(aHoras [nX,02,04],5,2),'.',':'))

		//-- Horários contratuais do empregado:
		cDet := "| " + aHoras[nX,01] + Space(18) + " | " + PADR(cEnt1,5) + Space(2) + " | " + PADR(cSai1,5) + " | " + PADR(cEnt2,5) + Space(2) + " | " + PADR(cSai2,5) + " |"
		Impr(cDet,'C')
	Next nX

EndIf

Impr(Space(nTamLin),'C')
Impr(Space(nTamLin),'C')

cDet := STR0017 + DtoC(dPerIni) + ' - ' + DtoC(dPerFim)		// 'Período: DD/MM/AAAA - DD/MM/AAAA
Impr(cDet,'C')

//--Inicio do Espelho de Ponto--//
//'|   	 |                                |                                                     |      |                                                                                                                      |'
cDet := "|" + Space(5) + "|" + Space(32) + "|" + Space(53) + "|" + Space(06) + "|" + Space(118) + "|"
Impr(cDet,'C')

//'| Dia | Marcações registradas no ponto |                  Jornada realizada                  |  CH  |                                    Tratamentos efetuados sobre os dados originais                                    |'
cDet := "| " + STR0016 + " | " + STR0022 + " | " + Space(17) + STR0023 + Space(18) + "|  CH  |" + Space(36) + STR0021 + " " + STR0024 + Space(36) + "|"
Impr(cDet,'C')

//'|     |           eletrônico           | Entrada | Saída | Entrada | Saída | Entrada | Saída |      | Horário | Ocor. | Motivo                                                                                             |'
cDet := "|" + Space(05) + "|" + Space(11) + STR0025 + Space(10) + " | " + STR0019 + " | " + STR0020 + " | " + STR0019 + " | " + STR0020 + " | " + STR0019 + " | " + STR0020 + " | " + Space(04) + " | " + STR0026 + " | " + STR0027 + " | " + STR0028 + Space(93) + "|"
Impr(cDet,'C')

Return( cHtml )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ Monta_Per³ Autor ³Equipe Advanced RH     ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/
Static Function Monta_Per( dDataIni , dDataFim , cFil , cMat , dIniAtu , dFimAtu )

Local aPeriodos := {}
Local cFilSPO	:= xFilial( "SPO" , cFil )
Local dAdmissa	:= SRA->RA_ADMISSA
Local dPerIni   := Ctod("//")
Local dPerFim   := Ctod("//")

SPO->( dbSetOrder( 1 ) )
SPO->( dbSeek( cFilSPO , .F. ) )
While SPO->( !Eof() .and. PO_FILIAL == cFilSPO )

    dPerIni := SPO->PO_DATAINI
    dPerFim := SPO->PO_DATAFIM

    //-- Filtra Periodos de Apontamento a Serem considerados em funcao do Periodo Solicitado
    IF dPerFim < dDataIni .OR. dPerIni > dDataFim
		SPO->( dbSkip() )
		Loop
    Endif

    //-- Somente Considera Periodos de Apontamentos com Data Final Superior a Data de Admissao
    IF ( dPerFim >= dAdmissa )
       aAdd( aPeriodos , { dPerIni , dPerFim , Max( dPerIni , dDataIni ) , Min( dPerFim , dDataFim ) } )
	Else
		Exit
	EndIF

	SPO->( dbSkip() )

End While

IF ( aScan( aPeriodos , { |x| x[1] == dIniAtu .and. x[2] == dFimAtu } ) == 0.00 )
	dPerIni := dIniAtu
	dPerFim	:= dFimAtu
	IF !(dPerFim < dDataIni .OR. dPerIni > dDataFim)
		IF ( dPerFim >= dAdmissa )
			aAdd(aPeriodos, { dPerIni, dPerFim, Max(dPerIni,dDataIni), Min(dPerFim,dDataFim) } )
		EndIF
    Endif
EndIF

Return( aPeriodos )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³SetTempTab³ Autor ³Leandro Drumond        ³ Data ³21/10/09  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cria temporario com as marcacoes de todos os funcionarios.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³SetTempTab()      										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³PONR140	 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function SetTempTab(aMarcacoes, dIniData, dFimData  )
Local aSpaInfo 	:= { "PA_FERIADO" }
Local nX		:= 0
Local nY		:= 0
Local cMat		:= SRA->RA_MAT
Local dDataApo
Local nHora
Local cCC
Local cTpMarca
Local cTipoReg
Local cIdOrg
Local cIntSREP
Local cTipoDia
Local cTurno
Local lDif			:= .F.
Local lTrbFeriado 	:= .F.

Local dDataAnt		:= Ctod("")
Local cSeqJrn		:= "!!"
Local nSeq			:= 0
Local cOrdem		:= "!!"
Local cOrdemAnt		:= "!!"
Local cCodHor		:= ''
Local nPos			:= 0
Local nPosHor		:= 0
Local nLenCalend	:= 	Len(aTabCalend)

Local nDias			:= 0
Local nTotDias		:= 0
Local nTab			:= 0
Local nCodHor		:= 0
Local dData			:= CtoD("")
Local aHorSREP		:= {}
Local aAponta		:= {}

dDataAnt			:= Ctod("")
cSeqJrn				:= "!!"
nSeq				:= 0

nTotDias := ( dFimData - dIniData )
aHorSREP := {/*Entrada Jornada*/,/*Saida Intervalo*/,/*Entrada Intervalo*/,/*Saida Jornada*/}

For nDias := 0 To nTotDias

    dData	:= dIniData + nDias

	//-- o Array aTabcalend ‚ setado para a 1a Entrada do dia em quest„o.
	IF ( nTab := aScan(aTabCalend, {|x| x[1] == dData .and. x[4] == '1E' }) ) == 0.00
		Loop
	EndIF

   	aSpaInfo 	:= { "PA_FERIADO" }
   	aSpaInfo	:= PosSPA( ( aTabCalend[ nTab , CALEND_POS_REGRA ] ) , cFilSPA , aSpaInfo , 01 , .F. )

    lTrbFeriado	:= ( aSpaInfo[1] == "S" )

	//-- o Array aMarcacoes ‚ setado para a 1a Marca‡„o do dia em quest„o.
	IF Empty(nX := aScan(aMarcacoes, { |x| x[3] == aTabCalend[nTab, 2] }))
		If Empty(aAponta)
			aAponta := fGetAponta( dPerIni , dPerFim , IF( lImpAcum , "SPH" , "SPC" ) )
		EndIf

		If fVerFalta(aAponta,dData)
			cTipoDia	:= IF( aTabCalend[ nTab , CALEND_POS_FERIADO ] , IF(  aTabCalend[ nTab , CALEND_POS_EXCECAO ]  == "E" , aTabCalend[ nTab , CALEND_POS_TIPO_DIA ] , IF(!lTrbFeriado,"F",aTabCalend[ nTab , CALEND_POS_TIPO_DIA ] ) ) , aTabCalend[ nTab , CALEND_POS_TIPO_DIA] )
			cIntSREP 	:= (  aTabCalend[ nTab , CALEND_POS_INTSREP   ] )
		    cIntSREP 	:= If(Empty(cIntSREP), "!!",cIntSREP)
		    aHorSREP	:= {/*Entrada Jornada*/,/*Saida Intervalo*/,/*Entrada Intervalo*/,/*Saida Jornada*/}
		    cCodHor		:= If(Empty(cCodHor),"0001",cCodHor)
			GravaARQREL({SRA->RA_PIS,dData,dData,' ',0,' ',' ',' ',cTipoDia,cTurno,'  ',cIntSREP,cCodHor,aHorSREP[1],aHorSREP[2],aHorSREP[3],aHorSREP[4],SRA->RA_NOME,SRA->RA_ADMISSA,SRA->RA_FILIAL, SRA->RA_MAT, SRA->RA_CC})
		EndIf
		Loop
	EndIF

	dDataApo	:= aMarcacoes[nX, AMARC_DATAAPO 	]	//-- Data de Apontamento
	cOrdem		:= aMarcacoes[nX, AMARC_ORDEM 		]	//-- Ordem da Marcacao

	While ( nX <= Len(aMarcacoes) .and. ( ( dDataApo <> NIL .and. dDataApo == aMarcacoes[nX, AMARC_DATAAPO] ) .or. (dDataApo == NIL .and. cOrdem == aMarcacoes[nX, AMARC_ORDEM] ) ) )

		dData		:= aMarcacoes[nX, AMARC_DATA 		]	//-- Data da Marcacao
		nHora		:= aMarcacoes[nX, AMARC_HORA 		] 	//-- Hora da Marcacao
		cCC			:= aMarcacoes[nX, AMARC_CC 			]	//-- Centro de Custos
		cTipoReg	:= aMarcacoes[nX, AMARC_TIPOREG 	]	//-- Tipo de Registro da Marcacao
		cREP		:= aMarcacoes[nX, AMARC_NUMREP	 	]	//-- Numero do REP
		cMotivRg	:= aMarcacoes[nX, AMARC_MOTIVRG	 	]	//-- Motivo de Registro de Incusao ou Desconsideracao
		cIdOrg		:= aMarcacoes[nX, AMARC_IDORG	 	]	//-- Identificacao da Origem da marcacao
		cTpMarca	:= aMarcacoes[nX, AMARC_TPMCREP		]	//-- Tipo de Marcacao

		If ( ( dDataApo	<> NIL  .and. dDataAnt <> dDataApo ) .or. ( dDataApo == NIL .and. cOrdemAnt <> cOrdem ) )
			cTipoDia	:= IF( aTabCalend[ nTab , CALEND_POS_FERIADO ] , IF(  aTabCalend[ nTab , CALEND_POS_EXCECAO ]  == "E" , aTabCalend[ nTab , CALEND_POS_TIPO_DIA ] , IF(!lTrbFeriado,"F",aTabCalend[ nTab , CALEND_POS_TIPO_DIA ] ) ) , aTabCalend[ nTab , CALEND_POS_TIPO_DIA] )
			cTurno		:= aTabCalend[nTab,CALEND_POS_TURNO]
		    cIntSREP 	:= (  aTabCalend[ nTab , CALEND_POS_INTSREP   ] )
		    cIntSREP 	:= If(Empty(cIntSREP), "!!",cIntSREP)

			aHorSREP	:= {/*Entrada Jornada*/,/*Saida Intervalo*/,/*Entrada Intervalo*/,/*Saida Jornada*/}

		    //-- Verifica o total de horas trabalhadas da jornada
		    If cTipoDia =='S'
		    	nY := nTab
				While cOrdem == aTabCalend[nY,CALEND_POS_ORDEM]
					fGerHorSREP(aTabCalend, nY, cIntSREP, aHorSREP, cOrdem, nLenCalend, "EJ.SI.EI.SJ", cTurno)
					nY++
			        IF nY > nLenCalend
			          Exit
			        Endif
				End While
		   	Endif
		   	lDif := .F.

			If !Empty(aHorSREP[1])
				IF ( nPosHor := aScan(aHoras, {|x| ( ArrayCompare( x[2] , aHorSREP ) ) } ) ) == 0.00
					nCodHor++
					cCodHor := StrZero( nCodHor , 4 )
					aAdd(aHoras,{cCodHor,aHorSREP})
				Else
					cCodHor := aHoras[nPosHor,1]
				EndIF
			Else
				cCodHor := "0000"
			EndIf

		EndIf

	    //-- Verifica a data de apontamento se houver
	    IF dDataApo	<> NIL
		    IF dDataAnt <> dDataApo
				dDataAnt	:= dDataApo 					//-- Data do Apontamento
			    cTpMarca	:= If(cTpMarca == "D","D","S")	//-- Para posterior alteracao
			    nSeq		:= 0
			Endif
	    Else
			//-- Verifica a ordem da marcacao
	        IF cOrdemAnt <> cOrdem
				cOrdemAnt	:= cOrdem
			    cTpMarca	:= If(cTpMarca == "D","D","S") //Para posterior alteracao
			    nSeq		:= 0
			Endif
	    Endif

		//-- Tipo de Marcacao
	    cTpMarca := IF(cTpMarca == "E", "S", If(cTpMarca == "S" , "E" , cTpMarca))

	    IF cTpMarca == "E"
		    //----- Gera numero sequencial de jornada
		    nSeq++
	   	 	cSeqJrn		:= Alltrim(Str(nSeq))
	   	Endif

	    IF cTpMarca == "D"
	   	 	cSeqJrn		:= Space(2)
	   	Endif


		GravaARQREL({SRA->RA_PIS,dData,dDataApo,cOrdem,nHora,cTipoReg,cTpMarca,cMotivRg,cTipoDia,cTurno,cSeqJrn,cIntSREP,cCodHor,aHorSREP[1],aHorSREP[2],aHorSREP[3],aHorSREP[4],SRA->RA_NOME,SRA->RA_ADMISSA,SRA->RA_FILIAL, SRA->RA_MAT, SRA->RA_CC})

		nX++

	End While

Next nDias

Return (Nil)

 /*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GravaARQREL³ Autor ³ Leandro Drumond     ³ Data ³ 12/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava os dados no arquivo temporario                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GravaARQREL(aLinha)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³  						                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ U_PONR140()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GravaARQREL(aCampos)
Local lRet		:= .T.
Local aOldAlias := GetArea()

dbSelectArea("ARQREL")

ARQREL->( RecLock("ARQREL", .T.))

ARQREL->ARQ_PIS     := aCampos[1]
ARQREL->ARQ_DATA    := aCampos[2]
ARQREL->ARQ_DATAAP  := aCampos[3]
ARQREL->ARQ_ORDEM   := aCampos[4]
ARQREL->ARQ_HORA    := aCampos[5]
ARQREL->ARQ_TPREG   := aCampos[6]
ARQREL->ARQ_TPMARC  := aCampos[7]
ARQREL->ARQ_MOTIVO  := aCampos[8]
ARQREL->ARQ_TPDIA   := aCampos[9]
ARQREL->ARQ_TURNO   := aCampos[10]
ARQREL->ARQ_SEQJRN  := aCampos[11]
ARQREL->ARQ_INTREP  := aCampos[12]
ARQREL->ARQ_CODHOR  := aCampos[13]
ARQREL->ARQ_HOR1    := aCampos[14]
ARQREL->ARQ_HOR2    := aCampos[15]
ARQREL->ARQ_HOR3    := aCampos[16]
ARQREL->ARQ_HOR4    := aCampos[17]
ARQREL->ARQ_NOME    := aCampos[18]
ARQREL->ARQ_DTADMI  := aCampos[19]
ARQREL->ARQ_FILIAL  := aCampos[20]
ARQREL->ARQ_MAT		:= aCampos[21]
ARQREL->ARQ_CC		:= aCampos[22]

ARQREL->( MsUnlock() )

RestArea(aOldAlias)

Return( lRet )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³fCriaArq  ³ Autor ³ Leandro Drumond       ³ Data ³ 12/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se existe o arquivo e cria se necessario			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³            												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ PONR410  												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function fCriaArq( nOrdem)

Local aStru  :={}
Local cInd
Local nVezes := 0
Local aLstIndices := {}
Local aLista := {}

Default nOrdem := 1

If nOrdem == 1
	cInd	:= "ARQ_PIS + ARQ_DATA + ARQ_HORA"
ElseIf nOrdem == 2
	cInd	:= "ARQ_NOME + ARQ_DATA + ARQ_HORA"
ElseIf nOrdem == 3
	cInd	:= "ARQ_FILIAL + ARQ_MAT + ARQ_DATA + ARQ_HORA"
ElseIf nOrdem == 4
	cInd	:= "ARQ_FILIAL + ARQ_CC + ARQ_PIS + ARQ_DATA + ARQ_HORA"
EndIf

aLista :=StrToArray(cInd,"+")
AAdd( aLstIndices, aLista)

aStru 	:= {;
			 {	"ARQ_PIS"		, "C" 	, 012 , 0 },;
			 {	"ARQ_DATA"		, "D" 	, 008 , 0 },;
			 {	"ARQ_DATAAP"   	, "D" 	, 008 , 0 },;
			 {	"ARQ_ORDEM" 	, "C" 	, 002 , 0 },;
			 {	"ARQ_HORA"		, "N" 	, 005 , 2 },;
			 {	"ARQ_TPREG"		, "C"	, 001 , 0 },;
			 {	"ARQ_TPMARC"	, "C" 	, 001 , 0 },;
			 {	"ARQ_MOTIVO"	, "C" 	, 100 , 0 },;
		 	 {	"ARQ_TPDIA"		, "C" 	, 001 , 0 },;
			 {	"ARQ_TURNO"		, "C" 	, 003 , 0 },;
			 {	"ARQ_SEQJRN"	, "C" 	, 002 , 0 },;
			 {	"ARQ_INTREP"	, "C"	, 002 , 0 },;
			 {	"ARQ_CODHOR"	, "C" 	, 004 , 0 },;
			 {	"ARQ_HOR1"  	, "N" 	, 005 , 2 },;
		 	 {	"ARQ_HOR2"	    , "N" 	, 005 , 2 },;
			 {	"ARQ_HOR3"		, "N" 	, 005 , 2 },;
			 {	"ARQ_HOR4"	    , "N"	, 005 , 2 },;
		 	 {	"ARQ_NOME"	    , "C" 	, 030 , 0 },;
			 {	"ARQ_DTADMI" 	, "D" 	, 008 , 0 },;
			 {	"ARQ_FILIAL" 	, "C" 	, FWGETTAMFILIAL , 0 },;
			 {	"ARQ_MAT" 		, "C" 	, TamSx3("RA_MAT")[1] , 0 }, ;
			 {	"ARQ_CC" 		, "C" 	, TamSx3("RA_CC")[1] , 0 }}


oTmpARQREL := RhCriaTrab('ARQREL', aStru, aLstIndices)


Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³GetMarcTab³ Autor ³Leandro Drumond        ³ Data ³21/10/09  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtem as marcacoes para o periodo informado a partir do Ca- ³±±
±±³          ³lendario.                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³GetMarc()													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³PONR140	 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function GetMarcTab(dIniData, dFimData )
Local aSpaInfo 	:= { "PA_FERIADO" }
Local nX		:= 0
Local nY		:= 0
Local dDataApo
Local nHora
Local cCC
Local cTpMarca
Local cTipoReg
Local cIdOrg
Local cIntSREP
Local cTipoDia
Local cTurno
Local lDif			:= .F.
Local lTrbFeriado 	:= .F.

Local dDataAnt		:= Ctod("")
Local cSeqJrn		:= "!!"
Local nSeq			:= 0
Local cOrdem		:= "!!"
Local cOrdemAnt		:= "!!"
Local cCodHor		:= ''
Local cPis			:= ""
Local cNome			:= ""
Local cFilFun		:= ""
Local cCnpj			:= ""
Local cCnpjAnt		:= ""

Local dDataAdmis	:= Ctod("")
Local nPos			:= 0
Local nPosHor		:= 0
Local nCount		:= 0
Local nHor1			:= 0
Local nHor2			:= 0
Local nHor3			:= 0
Local nHor4			:= 0

Local nDias			:= 0
Local nTotDias		:= 0
Local nTab			:= 0
Local nCodHor		:= 0
Local dData			:= CtoD("")
Local aHoras		:= {}
Local aHorSREP		:= {}

dDataAnt			:= Ctod("")
cSeqJrn				:= "!!"
nSeq				:= 0

DbSelectArea("ARQREL")
dbSetOrder(1)
ARQREL->(dbGoTop())

cPis  		:= ARQREL->ARQ_PIS
cNome 		:= ARQREL->ARQ_NOME
dDataAdmis 	:= ARQREL->ARQ_DTADMI
cFilFun		:= ARQREL->ARQ_FILIAL	//-- Filial do Funcionario

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Atualiza o Array de Informa‡”es sobre a Empresa.			  ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
aInfo := {}
fInfo( @aInfo , cFilFun )

cCnpjAnt := aInfo[08]
cCnpj 	 := aInfo[08]


While ARQREL->(!Eof())

		If AllTrim(cPis)+AllTrim(cCnpjAnt) <> AllTrim(ARQREL->ARQ_PIS)+AllTrim(cCnpj)
		    /*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³Imprime o Espelho para um Funcionario.						  ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			For nCount := 1 To nCopias
				fImpFun( aImp , nColunas , aHoras )
			Next nCount

			aImp   		:= {}
			aHoras 		:= {}
			cPis  		:= ARQREL->ARQ_PIS
			cNome 		:= ARQREL->ARQ_NOME
			dDataAdmis 	:= ARQREL->ARQ_DTADMI
			cCnpjAnt 	:= cCnpj

		EndIf

		If cFilFun <> ARQREL->ARQ_FILIAL

			cFilFun := ARQREL->ARQ_FILIAL
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³Atualiza o Array de Informa‡”es sobre a Empresa.			  ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			aInfo 	:= {}
			fInfo( @aInfo , cFilFun )
			cCnpj 	:= aInfo[08]
			cCnpjAnt:= cCnpj
		EndIf

		dData		:= ARQREL->ARQ_DATA		//-- Data da Marcacao
		dDataApo	:= ARQREL->ARQ_DATAAP	//-- Data de apontamento
		cOrdem		:= ARQREL->ARQ_ORDEM	//-- Ordem
		nHora		:= ARQREL->ARQ_HORA 	//-- Hora da Marcacao
		cTipoReg	:= ARQREL->ARQ_TPREG	//-- Tipo de Registro da Marcacao
		cTpMarca	:= ARQREL->ARQ_TPMARC	//-- Tipo de Marcacao
		cMotivRg	:= ARQREL->ARQ_MOTIVO	//-- Motivo de Registro de Incusao ou Desconsideracao
		cTipoDia	:= ARQREL->ARQ_TPDIA	//-- Tipo de Dia
		cTurno  	:= ARQREL->ARQ_TURNO	//-- Turno
		cSeqJorn	:= ARQREL->ARQ_SEQJRN	//-- Sequencia da jornada
		cIntSREP	:= ARQREL->ARQ_INTREP	//-- Intervalo
		cCodHor		:= ARQREL->ARQ_CODHOR	//-- Codigo do horario
		nHor1		:= ARQREL->ARQ_HOR1		//-- Entrada 1
		nHor2		:= ARQREL->ARQ_HOR2		//-- Saida 1
		nHor3       := ARQREL->ARQ_HOR3		//-- Entrada 2
		nHor4       := ARQREL->ARQ_HOR4		//-- Saida 2

		If !Empty(nHor1)
			aHorSREP := {nHor1,nHor2,nHor3,nHor4}
		Else
			aHorSREP := {,,,}
		EndIf

		If cCodHor != "0000"
			If !Empty(aHorSREP[1])
				If Empty(aHoras)
					aAdd(aHoras,{cCodHor,aHorSREP})
				ElseIf ( nPosHor := aScan(aHoras, {|x| ( ArrayCompare( x[2] , aHorSREP ) ) } ) ) == 0.00
					aAdd(aHoras,{cCodHor,aHorSREP})
				EndIF
			EndIf
		EndIf

		aAdd(aImp,{dData,dDataApo,cOrdem,nHora,cTipoReg,cTpMarca,cMotivRg,cCodHor,cPis,cNome,dDataAdmis})

		ARQREL->(dbSkip())
EndDo

//Imprime ultimo funcionario
If !Empty(aImp)
	fImpFun( aImp , nColunas , aHoras )
EndIf

Return (Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncai    ³P410ApIndiceºAutor  ³Leandro Drumond   º Data ³  12/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Apaga o indice do arquivo ARQREL ao sair da rotina         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PONR140                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function P140ApIndice(cArqNome)
Local nVezes := 0
Local cArquivo := FileNoExt(cArqNome)+"1"+OrdBagExt()

dbSelectArea("ARQREL")
dbCloseArea()

While File(cArquivo)
	nVezes ++
   	If nVezes >= 10
		Return
	EndIf
	FErase(FileNoExt(cArqNome)+"1"+OrdBagExt())
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fGerHorSREP  ³ Autor ³ Mauricio MR        ³ Data ³ 31/10/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Identifica as marcacoes do horario contratual 	          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/
Static Function fGerHorSREP(aTabCalend, nPosDiaApo, cIntSREP, aHorSREP, cOrdem, nLenCalend, cTipo, cTurno)
Local nPosSub1	:= 0
Local nPosProx  := 0
Local nIntSREP  := 0

//-- Obtem os Horarios Contratuais para Efeito do SREP
IF ( aTabCalend[ nPosDiaApo , CALEND_POS_TIPO_MARC ] == "1E" ) .and. ("EJ"$cTipo)    // Entrada de Jornada
		aHorSREP[1]:= aTabCalend[nPosDiaApo,CALEND_POS_HORA]
ElseIF ( SubStr( aTabCalend[ nPosDiaApo , CALEND_POS_TIPO_MARC ] , -1 ) == "E" ) .and. ("EI"$cTipo) // Entrada de Intervalo (Retorno do Intervalo)
	nPosSub1 := ( nPosDiaApo - 1 )
	nIntSREP := Val(SubSTR(cIntSREP,1,1))
	nIntSREP++
	IF( aTabCalend[ Max( nPosSub1 , 1 ) , CALEND_POS_HRS_INTER ] > 0 .and. ;
		( SubStr( aTabCalend[ nPosDiaApo , CALEND_POS_TIPO_MARC ] , 1 ,1 ) $ STR(nIntSREP) );
	  )
		aHorSREP[3]:= aTabCalend[nPosDiaApo,CALEND_POS_HORA]
	Endif
ElseIF (  (aTabCalend[ nPosDiaApo , CALEND_POS_HRS_INTER ] > 0 ) .and. ;   // Saida para o intervalo (Saida Intervalo)
		( SubStr( aTabCalend[ nPosDiaApo , CALEND_POS_TIPO_MARC ] , 1 ,1 ) $ cIntSREP ) ;
	  )	.and. ("SI"$cTipo)
		aHorSREP[2]:= aTabCalend[nPosDiaApo,CALEND_POS_HORA]
ElseIF ("SJ"$cTipo) //Verifica a Saida de Jornada
	nPosProx	:= nPosDiaApo + 1
	IF ( nPosProx  > nLenCalend )
			aHorSREP[4]				:= aTabCalend[nPosDiaApo,CALEND_POS_HORA]
	ElseIF ( aTabCalend[nPosProx, CALEND_POS_ORDEM ] <> cOrdem )
     		aHorSREP[4]				:= aTabCalend[nPosDiaApo,CALEND_POS_HORA]
	Endif
EndIF

Return (Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³fGetAponta³ Autor ³ Leandro Drumond       ³ Data ³ 30/03/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtem informacaoes do apontamento.          				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³            												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ PONR140  												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fGetAponta( dPerIni , dPerFim , cAlias )
Local aRet 		:= {}
Local aArea		:= GetArea()
Local cPrefixo  := ( PrefixoCpo( Upper( AllTrim( cAlias ) ) ) + "_" )
Local cQuery	:= ''
Local cAliasQry := ''
Local lQueryOk  := .F.

cAliasQry := GetNextAlias()

cQuery := "SELECT "+ cPrefixo + "DATA, " + cPrefixo + "PD, " + cPrefixo + "QUANTC, " + cPrefixo + "QTABONO"
cQuery += " FROM " + InitSqlName( cAlias )
cQuery += " WHERE " + cPrefixo + "DATA >= '" + Dtos(dPerIni) + "' AND "
cQuery +=            cPrefixo + "DATA <= '" + DtoS(dPerFim) + "' AND "
cQuery +=            cPrefixo + "MAT = '" + SRA->RA_MAT + "' AND"
cQuery += " D_E_L_E_T_=' ' "

cQuery := ChangeQuery( cQuery )

If Select(cAliasQry) > 0
	(cAliasQry)->(dbCloseArea())
EndIf

lQueryOk := ( MsOpenDbf(.T.,"TOPCONN",TcGenQry(NIL,NIL,cQuery),cAliasQry,.F.,.T.) )

If lQueryOk
	While (cAliasQry)->(!Eof())

		aAdd( aRet , {(cAliasQry)->( &(cPrefixo+"DATA") ) , (cAliasQry)->( &(cPrefixo+"PD") ) , (cAliasQry)->( &(cPrefixo+"QUANTC") ) , (cAliasQry)->( &(cPrefixo+"QTABONO") )} )
		(cAliasQry)->(dbSkip())
	EndDo
	(cAliasQry)->(dbCloseArea())
EndIf

RestArea(aArea)

Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³fVerFalta ³ Autor ³ Leandro Drumond       ³ Data ³ 30/03/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica a existencia de faltas nao abonadas				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³            												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ PONR140  												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fVerFalta(aResult,dData)
Local lRet  := .F.

aEval( aResult, { |x|	IF( x[1] == DtoS(dData) .and. x[2] $ cCodAtras .and. !(x[4] == x[3]) , lRet := .T. , '' ) } )

Return lRet

/*/{Protheus.doc} UpdDtPer
	Atualiza a data inicial e final do período de apontamento.
	@type Function
	@version 12.1.2210
	@author arthur.sales
	@since 28/12/2023
	@param dDate, Date, Data da marcação
	@return Variant, Retorno nulo pré-fixado
/*/
Static Function UpdDtPer(dDate As Date) As Variant
	// Declaração das variáveis locais
	Local nPeriod As Numeric // Contador de períodos

	// Definição dos valores padrão dos parâmetros
	DEFAULT dDate := CToD("")

	// Inicialização das variáveis
	nPeriod := 0

	// Percorre o vetor de períodos para encontrar o período referente à marcação atual
	If (Type("aPeriodos") == "A")
		For nPeriod := 1 To Len(aPeriodos)
			If (dDate >= aPeriodos[nPeriod][1] .and. dDate <= aPeriodos[nPeriod][2])
				dPerIni := aPeriodos[nPeriod][1]
				dPerFim := aPeriodos[nPeriod][2]
			EndIf
		Next nPeriod
	EndIf
Return NIL
