/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "RWMAKE.CH"
#INCLUDE "PONQDHR.CH"
#IFNDEF CRLF
#DEFINE CRLF ( chr(13)+chr(10) )
#ENDIF
/*
ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿
³Fun‡…o    ³PONQDHR   ³ Autor ³ Marinaldo de Jesus    ³ Data ³17/07/2001³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´
³Descri‡…o ³ Quadro de Horario                                          ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Sintaxe   ³PONQDHR( lTerminal , cFilTerminal , cMatTerminal )  		³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Parametros³                                                            ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³ Uso      ³ Generico                                                   ³
ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Mauricio T. ³24/07/14³TQDQ59³Inclusao no Repositorio e no Projeto Ponto³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
User Function PONR200()

Local aArea		:= GetArea()
Local aOrd		:= {}
Local aRetPortal:= {}
Local cDesc1	:= STR0001 //"Quadro de Hor rio"
Local cDesc2	:= STR0002	//'Ser  impresso de acordo com os parametros solicitados pelo'
Local cDesc3	:= STR0003	//'usu rio.'
Local cString	:= 'SRA'	//-- Alias do arquivo principal (Base)
Local cPerg		:= 'PNQDHR'
Local wnRel		:= ""
Local cHtml		:= ""   
Local cAviso
Local lCentury	:= __SetCentury("on")
//-- Tratamento dos arquivos envolvidos no Fechamento Mensal (Para evitar que o processo nao seja finalizado)
Local aFilesOpen :={"SP5", "SPN", "SP8", "SPG","SPB","SPL","SPC", "SPH", "SPF"}
Local bCloseFiles:= {|cFiles| If( Select(cFiles) > 0, (cFiles)->( DbCloseArea() ), NIL) }

Private aReturn  := { STR0004 , 1, STR0005 , 2, 2, 1, '',1 } //'Zebrado'###'Administra‡„o'
Private aLinha   := {}
Private nomeprog := FunName()
Private Titulo   := cDesc1 + STR0006 //" de Trabalho"
Private cCabec   := ''
Private AT_PRG   := nomeprog
Private nTamanho := 'G'      
Private wCabec0  := 1
Private wCabec1  := ""
Private CONTFL   := 1
Private Li       := 0.00
Private nLastKey := 0.00
Private lEnd	 := .F.	

If IsInCallStack("GetScheduleChart")
	lTerminal 		:= Paramixb[1]
	cFilTerminal	:= Paramixb[2] 
	cMatTerminal	:= Paramixb[3] 
	lPortal			:= Paramixb[4] 
EndIf

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Chamada ao Processamento                                     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF !( lTerminal := IF( lTerminal == NIL , .F. , lTerminal ) )

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Envia controle para a funcao SETPRINT                        ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	wnrel := nomeprog
	wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,nTamanho)

	IF nLastKey == 27
		Return( NIL )
	EndIF

	SetDefault(aReturn,cString)

	IF nLastKey == 27
	   Return( NIL )
	EndIF

	RptStatus( { || PnQdHrImp(@lEnd,wNRel,cString,cPerg) } , Titulo )
	
	RestArea( aArea )
Else
	lPortal   := IF( lPortal == NIL , .F. , lPortal )
    //-- Verifica se foi possivel abrir os arquivos sem exclusividade
	If Pn090Open(@cHtml, @cAviso)
		cHtml := ""	
		cHtml := PnQdHrImp(@lEnd,wNRel,cString,cPerg,lTerminal,cFilTerminal,cMatTerminal,lPortal,aRetPortal)  
		 /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Apos a obtencao da consulta solicitada fecha os arquivos     ³
		³ utilizados no fechamento mensal para abertura exclusiva      ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	    Aeval(aFilesOpen, bCloseFiles) 
	Else
	   cHtml := HtmlDefault( cAviso , cHtml )   	    
	Endif
EndIF

__SetCentury( IF( lCentury , "on" , "off" ) )


Return( aRetPortal )

/*
ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿
³Fun‡…o    ³PnQdHrImp	³ Autor ³Marinaldo de Jesus   ³ Data ³17/07/2001³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´
³Descri‡…o ³Imprime o Quadro de Horario                                 ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Sintaxe   ³QuadroHorImp(lEnd,wnRel,cString)                            ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Parametros³ lEnd			- A‡Æo do Codelock                          ³
³          ³ wnRel			- T¡tulo do relat¢rio                       ³
³          ³ cString		- Mensagem			                        ³
³          ³ cPerg			- Grupo de Perguntas do Relatorio			³
³          ³ lTerminal		- Chamada via Web							³
³          ³ cFilTerminal	- Filial Quando Chamada via Web				³
³          ³ cMatTerminal	- Matricula Quando Chamada via Web			³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³ Uso      ³Impressao do Quadro de Horario                              ³
ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Static Function PnQdHrImp( lEnd , wnRel , cString , cPerg , lTerminal , cFilTerminal , cMatTerminal, lPortal, aRetPortal  )

Local aAreaSRA		:= SRA->( GetArea() )
Local aInfo			:= {}
Local aTabPadrao	:= {}
Local aTabCalend	:= {}
Local bEval			:= { |e| &(e) }
Local dPerIni		:= Ctod("//")
Local dPerFim		:= Ctod("//")
Local cAcessaSRA	:= ChkRH( FunName() , "SRA" , "2" )
Local cExclui		:= ""
Local cFilOld		:= ""
Local cTnoAnt		:= ""
Local cSeqTnoAnt	:= ""
Local cDescTurn		:= ""
Local cHtml			:= ""
Local cFilMask		:= ""
Local nColunas	 	:= IF( nTamanho == "P" , 80 , IF( nTamanho == "G" , 220 , 132 ) )
Local lRoda			:= .F.

lPortal   := IF( lPortal == NIL , .F. , lPortal )

lTerminal := IF( lTerminal == NIL , .F. , lTerminal )

cExclui += "(RA_FILIAL  < mv_par01 .or. RA_FILIAL	> mv_par02   ).or." //Filial 	De/Ate
cExclui += "(RA_TNOTRAB < mv_par03 .or. RA_TNOTRAB	> mv_par04   ).or." //Turno  	De/Ate
cExclui += "(RA_MAT		< mv_par05 .or. RA_MAT		> mv_par06   ).or." //Matricula De/Ate
cExclui += "!(RA_SITFOLH$mv_par07) .or.!(RA_CATFUNC$mv_par08)"			//Situacoes/Categorias

Pergunte(cPerg,.F.)

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Altera Variaveis do Grupo de Pergunta para uso no Terminal    ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF lTerminal
	mv_par01 := mv_par02 := cFilTerminal
	mv_par03 := mv_par04 := SRA->RA_TNOTRAB
	mv_par05 := mv_par06 := cMatTerminal
	mv_par07 := fSituacao( NIL , .F. )
	mv_par08 := fCategoria( NIL , .F. )	
	mv_par09 := mv_par10 := 02
EndIF

IF !lTerminal
	SRA->( SetRegua( RecCount() ) , dbSetOrder( 04 ) , dbSeek( mv_par01 + mv_par03 ,.T. ) ) //Filial + Turno + Seq. Turno + Matricula
EndIF

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Executa enquanto atender aos Parametros                       ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
While SRA->( !Eof() .and. Eval( bEval , "RA_FILIAL+RA_TNOTRAB" ) <= ( mv_par02+mv_par04 ) )


	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ So faz consistencia quando a Chamada nao for via Web         ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !lTerminal

		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Incrementa Regua de Processamento.                           ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IncRegua()
	
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Aborta o Processamento                                       ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF lEnd
			@ Prow()+1, 0 PSAY cCancel
			Exit  
		EndIF
	
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Consiste Intervalo das Perguntas De? Ate?                              ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF SRA->( Eval( bEval , cExclui ) )
			SRA->( dbSkip() )
			Loop
		EndIF
	
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Consiste Filiais e Acessos                                             ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	    IF ( !( SRA->RA_FILIAL $ fValidFil() ) .or. !Eval( bEval , cAcessaSRA ) )
	    	SRA->( dbSkip() )
	       	Loop
	    EndIF
	
	EndIF
	
	IF ( ( cFilOld + cTnoAnt + cSeqTnoAnt != SRA->( RA_FILIAL + RA_TNOTRAB + RA_SEQTURN ) ) .or. mv_par09 == 02 )
	
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Carrega o Periodo de Apontamento                                       ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF !( cFilOld == SRA->RA_FILIAL )
			IF !CheckPonMes( @dPerIni , @dPerFim , .F. , .T. , .F. , SRA->RA_FILIAL)
				Exit
			EndIF
		EndIF	

		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Cria o Calendario de Marcacoes Por Turno                               ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF !lTerminal .and. mv_par09 == 01 .and. !CriaCalend(	dPerIni			,;
																dPerFim			,;
																SRA->RA_TNOTRAB	,;
																SRA->RA_SEQTURN	,;
																@aTabPadrao		,;
																@aTabCalend		,;
																SRA->RA_FILIAL	 ;
															)
			SRA->( dbSkip() )
			Loop
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Cria o Calendario de Marcacoes Por Funcionario                         ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		ElseIF mv_par09 == 02 .and. !CriaCalend(	dPerIni			,;
							 						dPerFim			,;
													SRA->RA_TNOTRAB	,;
													SRA->RA_SEQTURN	,;
													@aTabPadrao		,;
													@aTabCalend		,;
													SRA->RA_FILIAL	,;
													SRA->RA_MAT		,;
													SRA->RA_CC		 ;
												)
			SRA->( dbSkip() )
			Loop
		EndIF
	
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Estrutura do Calendario de Marcacoes versao 7.10                       ³
		³ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³
		³aTabCalend[ nX , 01    ]	01 - Data									³
		³aTabCalend[ nX , 02    ]	02 - Ordem									³
		³aTabCalend[ nX , 03    ]	03 - Hora									³
		³aTabCalend[ nX , 04    ]	04 - Tipo Marc								³
		³aTabCalend[ nX , 05    ]	05 - No Marc.								³
		³aTabCalend[ nX , 06    ]	06 - Tipo Dia								³		
		³aTabCalend[ nX , 07    ]	07 - No Horas								³
		³aTabCalend[ nX , 08    ]	08 - Sequˆncia de Turno						³
		³aTabCalend[ nX , 09    ]	09 - Horas de Intervalo						³
		³aTabCalend[ nX , 10    ]	10 - Excecao (E-Excecao,#E-nao e excecao)	³
		³aTabCalend[ nX , 11    ]	11 - Motivo da Excecao						³
		³aTabCalend[ nX , 12    ]	12 - Tipo de Hora Extra Normal				³
		³aTabCalend[ nX , 13    ]	13 - Tipo de Hora Extra Noturna				³
		³aTabCalend[ nX , 14    ]	14 - Turno de Trabalho						³
		³aTabCalend[ nX , 15    ]	15 - Centro de Custo                 		³
		³aTabCalend[ nX , 16    ]	16 - Pagamento de Nona Hora					³
		³aTabCalend[ nX , 17    ]	17 - Limite de Marcacao Inicial/Final		³		
		³aTabCalend[ nX , 18    ]	18 - Codigo da Refeicao              		³
		³aTabCalend[ nX , 19    ]	19 - Dia eh Feriado                   		³
		³aTabCalend[ nX , 20    ]	20 - Tipo de Hora Extra Normal  Feriado		³
		³aTabCalend[ nX , 21    ]	21 - Tipo de Hora Extra Noturna Feriado		³
		³aTabCalend[ nX , 22    ]	22 - Descricao do Feriado               	³
		³aTabCalend[ nX , 23    ]	23 - Regra de Apontamento               	³
		³aTabCalend[ nX , 24    ]	24 - Funcionario Afastado               	³
		³aTabCalend[ nX , 25    ]	25 - Tipo de Afastamento                	³
		³aTabCalend[ nX , 26    ]	26 - Data Inicial do Afastamento        	³
		³aTabCalend[ nX , 27    ]	27 - Data Final do Afastamento          	³
		³aTabCalend[ nX , 28	]	28 - Inicio da Hora Noturna		          	³
		³aTabCalend[ nX , 29	]	29 - Final da Hora Noturna					³
		³aTabCalend[ nX , 30 	]	30 - Minutos da Hora Noturna				³
		³aTabCalend[ nX , 31 	]	31 - Funcionario Trabalha em Dias Feriados  ³
		³aTabCalend[ nX , 32 	]	32 - Se Aponta Quando Afastamento em Ferias ³
		³aTabCalend[ nX , 33 	]	33 - Tipo de hora extra normal (Ferias)		³
		³aTabCalend[ nX , 34 	]	34 - Tipo de hora extra noturna (Ferias)	³
		³aTabCalend[ nX , 35 	]	35 - Tipos Intervalos Pagos conforme Regra	³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		
		IF !( cFilOld == SRA->RA_FILIAL )

		    /*
	    	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      		³ Carrega Matriz Com Dados da Empresa da Filial Anterior                ³
		    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			IF !fInfo(@aInfo,SRA->RA_FILIAL)
				SRA->( dbSkip() )
				Loop
			EndIF

			wCabec1 := STR0007 + AllTrim( SRA->RA_FILIAL ) + " - " + AllTrim( aInfo[3] ) //"Filial:"
			
			Do Case
				Case aInfo[15] == 1
					cFilMask := Transform(aInfo[8],"@R ##########/##") //CEI
				Case aInfo[15] == 2
					cFilMask := Transform(aInfo[8],"@R ##.###.###/####-##") //CNPJ
				Case aInfo[15] == 3
					cFilMask := Transform(aInfo[8],"@R ###.###.###-##") //CPF
				Case aInfo[15] == 4
					cFilMask := Transform(aInfo[8],"@R ###.###.###.###-#") //INCRA
			EndCase			

			wCabec1 += STR0008 + cFilMask + STR0009 + aInfo[4] //" - CGC: "###" - End.: "

			IF !Empty( cFilOld ) .and. !lTerminal
				Impr( "" , "P") //Salta Pagina a Cada Filial 
			EndIF

		EndIF
    
		IF ( !Empty(cTnoAnt+cSeqTnoAnt) .and. cTnoAnt + cSeqTnoAnt != SRA->( RA_TNOTRAB + RA_SEQTURN ) ) .and. !lTerminal
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³Quebra a Cada Troca de Turno/Sequencia                                 ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			Impr("","P")
		EndIF

		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Posiciona na Regra de Apontamento                                      ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF mv_par09 == 02
			SPA->( MsSeek( fFilFunc("SPA") + SRA->RA_REGRA ) )
		EndIF	
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Imprime o Calendario de Marcacoes                                      ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If lPortal
			aAdd(aRetPortal, {aTabCalend, dPerIni, dPerFim})
		Else
			cHtml += fImpCalend( aTabCalend , nColunas , @cDescTurn , lTerminal , dPerIni , dPerFim )
		EndIf
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Atualiza Variaveis                                                     ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		SRA->( cFilOld := RA_FILIAL , cTnoAnt := RA_TNOTRAB , cSeqTnoAnt := RA_SEQTURN )

	EndIF

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Imprime os Dados dos Funcionarios                                      ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !lTerminal .and. ( mv_par09 == 2 .or. ( mv_par09 == 1 .and. mv_par10 == 2 ) )
		fImpFunc( ( mv_par09 == 02 ) , cDescTurn )
	EndIF

	lRoda := .T.
		
	IF lTerminal
		Exit
	EndIF

	SRA->( dbSkip() )

End While

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Finalizacao Padrao apenas quando nao for Web                 ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF !lTerminal

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Imprime Rodape na Ultima Pagina                              ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF lRoda
		IF Li < 58
			Li := 58
		EndIF
		Impr("","F")
	EndIF
	
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Termino do relatorio                                         ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	Set Device To Screen
	IF aReturn[5] == 1
		Set Printer To
		dbCommit()
		OurSpool(wnrel)
	EndIF
	MS_FLUSH()

EndIF
	
RestArea( aAreaSRA )

Return( cHtml )

/*
ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿
³Fun‡…o    ³fImpCalend  ³ Autor ³Marinaldo de Jesus   ³ Data ³17/07/2001³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´
³Descri‡…o ³Imprime o Calendario de Marcacoes                           ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Sintaxe   ³fImpCalend( aTabCalend )									³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Parametros³                                                            ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³ Uso      ³QuadroHr()                                                  ³
ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Static Function fImpCalend( aTabCalend , nColunas , cDescTurn , lTerminal , dPerIni , dPerFim )

Local cCab			:= STR0010 //"Data       |Dia      |1a. Entrada| 1a. Saida |2a. Entrada| 2a. Saida |3a. Entrada| 3a. Saida |4a. Entrada| 4a. Saida |  Tipo do Dia | Tipo H.E. Normal |Tipo H.E. Noturna |Excecao|Turno|Seq.|Hrs.Trab.|Hrs.Int.|Cod.Refeic."
Local cLin			:= Replicate( IF( lTerminal , chr(151) , "-" ) , nColunas )
Local cCol			:= "|"
Local cBrc			:= ""
Local cDet			:= ""                                                                     
Local cOrd			:= ""
Local cData			:= ""
Local cDia			:= ""
Local cTipoDia		:= ""
Local cHora			:= ""
Local cHrTrab		:= ""
Local cHrInte		:= ""
Local cHeNorm		:= ""
Local cHeNotu		:= ""
Local cExcecao  	:= ""
Local cTurno		:= ""
Local cSequenc		:= ""
Local cCodRef		:= ""
Local cDescRef		:= ""
Local cHtml			:= ""
Local lZebrado		:= 0.00
Local nHrTrab		:= 0.00
Local nHrInte		:= 0.00
Local nOrdIni		:= 0.00
Local nOrdFim		:= 0.00
Local nVezes		:= 0.00
Local nTab			:= 0.00
Local nPos			:= 0.00
Local nLen			:= Len( aTabCalend )
Local nTamCpoRef	:= Len( SP1->P1_DESC )
Local nX

lTerminal := IF( lTerminal == NIL , .F. , lTerminal )

cBrc := Space(11) + cCol
cBrc += Space(09) + cCol
cBrc += Space(11) + cCol
cBrc += Space(11) + cCol
cBrc += Space(11) + cCol
cBrc += Space(11) + cCol
cBrc += Space(11) + cCol
cBrc += Space(11) + cCol
cBrc += Space(11) + cCol
cBrc += Space(11) + cCol
cBrc += Space(14) + cCol
cBrc += Space(18) + cCol
cBrc += Space(18) + cCol
cBrc += Space(07) + cCol
cBrc += Space(05) + cCol
cBrc += Space(04) + cCol
cBrc += Space(09) + cCol
cBrc += Space(08) + cCol
cBrc += Space(11) + cCol

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Mascara do Relatorio (220 Colunas)                           ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
-----------+---------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+--------------+------------------+------------------+-------+-----+----+---------+--------+-----------
Data	   |Dia      |1a. Entrada| 1a. Saida |2a. Entrada| 2a. Saida |3a. Entrada| 3a. Saida |4a. Entrada| 4a. Saida |  Tipo do Dia | Tipo H.E. Normal |Tipo H.E. Noturna |Excecao|Turno|Seq.|Hrs.Trab.|Hrs.Int.|Cod.Refeic.
-----------+---------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+--------------+------------------+------------------+-------+-----+----+---------+--------+-----------
DD/MM/AAAA |XXXXXXXX |   999:99  |   999:99  |   999:99  |   999:99  |   999:99  |   999:99  |   999:99  |   999:99  |XXXXXXXXXXXXXX|XXXXXXXXXXXXXXXXXX|XXXXXXXXXXXXXXXXXX|  XXX  | xxx | XX | 999:99  | 999:99 |    XX     
-----------+---------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+--------------+------------------+------------------+-------+-----+----+---------+--------+-----------*/
cDescTurn := SRA->( STR0007 + RA_FILIAL + " - " + STR0019 + RA_TNOTRAB + "/" + RA_SEQTURN + " - " + fDesc("SR6",RA_TNOTRAB,"R6_DESC",,RA_FILIAL) ) //"Filial: ""Turno/Seq.: "

cDet := cDescTurn

IF lTerminal
	cHtml += HtmlProcId() + CRLF
	cHtml += '<html>'  + CRLF
	cHtml += 	'<head>'  + CRLF
	cHtml += 		'<title>RH Online</title>'  + CRLF
	cHtml +=		'<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">'  + CRLF
	cHtml +=		'<link rel="stylesheet" href="css/rhonline.css" type="text/css">'  + CRLF
	cHtml +=	'</head>'  + CRLF
	cHtml +=	'<body bgcolor="#FFFFFF" text="#000000">'  + CRLF
	cHtml +=		'<table width="515" border="0" cellspacing="0" cellpadding="0">'  + CRLF
  	cHtml +=			'<tr>'  + CRLF
    cHtml +=				'<td class="titulo">'  + CRLF
    cHtml +=					'<p>'  + CRLF
    cHtml +=						'<img src="imagens/icone_titulo.gif" width="7" height="9">'  + CRLF
    cHtml +=							'<span class="titulo_opcao">'  + CRLF
    cHtml +=								STR0018 + CRLF //"Calend&aacute;rio de Marca&ccedil;&otilde;es"  
    cHtml +=							'</span>' + CRLF
    cHtml +=							'<br><br>' + CRLF
	cHtml +=					'</p>' + CRLF
	cHtml +=				'</td>' + CRLF
  	cHtml +=			'</tr>' + CRLF
  	cHtml +=			'<tr>' + CRLF
    cHtml +=				'<td>' + CRLF
    cHtml +=					'<p><img src="imagens/tabela_conteudo.gif" width="1012" height="12"></p>' + CRLF
    cHtml +=				'</td>' + CRLF
  	cHtml +=			'</tr>' + CRLF
  	cHtml +=			'<tr>' + CRLF
    cHtml +=				'<td>' + CRLF
    cHtml +=					'<table width="515" border="0" cellspacing="0" cellpadding="0">' + CRLF
    cHtml +=						'<tr>' + CRLF
    cHtml +=							'<td background="imagens/tabela_conteudo_1.gif" width="10">&nbsp;</td>' + CRLF
    cHtml +=							'<td class="titulo" width="498">' + CRLF
    cHtml +=								'<table width="498" border="0" cellspacing="2" cellpadding="1">' + CRLF
	cHtml +=									'<tr>' + CRLF
	cHtml +=										'<td colspan="19" class="etiquetas" bgcolor="#FAFBFC">' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												cDet + CRLF
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
	cHtml +=									'</tr>' + CRLF
	cHtml +=									'<tr>' + CRLF
	cHtml +=										'<td colspan="19" class="etiquetas">' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0020 + Dtoc( dPerIni ) + " a " + Dtoc( dPerFim ) + CRLF //"Per&iacute;odo de Apontamento: " 
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
	cHtml +=									'</tr>' + CRLF
    cHtml +=									'<tr>' + CRLF
    cHtml +=										'<td colspan="19" class="etiquetas_1" bgcolor="#FAFBFC"><hr size="1"></td>' + CRLF
    cHtml +=									'</tr>' + CRLF
	cHtml +=									'<tr>' + CRLF
	cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0021 + CRLF	//"Data"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0022 + CRLF	//"Dia"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0023 + CRLF	//"1&#170; Entrada"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0024 + CRLF	//"1&#170; Saida"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0025 + CRLF	//"2&#170; Entrada"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0026 + CRLF	//"2&#170; Saida"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0027 + CRLF	//"3&#170; Entrada"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0028 + CRLF	//"3&#170; Saida"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0029 + CRLF	//"4&#170; Entrada"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0030 + CRLF	//"4&#170; Saida"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0031 + CRLF	//"Tipo do Dia"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0032	+ CRLF	//"Tipo H.E. Normal"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0033 + CRLF //"Tipo H.E. Noturna"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0034 + CRLF	//"Exce&ccdil;&atilde;o"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0035 + CRLF	//"Turno"
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0036 + CRLF	//"Seq."
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0037 + CRLF //"Hrs.Trab."
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0038 + CRLF //"Hrs.Int."
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=											'<div align="center">' + CRLF
    cHtml +=												STR0039 + CRLF	//"Cod.Refeic."
    cHtml +=											'</div>' + CRLF
    cHtml +=										'</td>' + CRLF
    cHtml +=									'</tr>' + CRLF
    cHtml +=									'<tr>' + CRLF
    cHtml +=										'<td colspan="19" class="etiquetas_1" bgcolor="#FAFBFC"><hr size="1"></td>' + CRLF
    cHtml +=									'</tr>' + CRLF
Else
	Impr(cDet , "C"  ) ; cDet := ""
	Impr(cLin , "C" ) //Imprime o Separador do Calendario
	Impr(cCab , "C" ) //Imprime o Cabecalho do Calendario
	Impr(cLin , "C" ) //Imprime o Separador do Calendario
EndIF	

nOrdIni := Val( aTabCalend[  01  , 02 ] )
nOrdFim := Val( aTabCalend[ nLen , 02 ] )

nVezes := ( ( nOrdFim - nOrdIni ) + 1 )

For nX := nOrdIni To nVezes
	cOrd := StrZero( nX , 2 )
	nHrTrab 	:= 0.00
	nHrInte		:= 0.00
	lZebrado	:= ( nX%2 == 0.00 )
	IF ( nPos := aScan( aTabCalend , { |x| x[2] == cOrd .and. x[4] == "1E" } ) ) > 0.00
		aEval( aTabCalend , { |x| IF( x[2] == cOrd , ( nHrTrab := SomaHoras( nHrTrab , x[7] ), nHrInte := SomaHoras( nHrInte , x[9] ) ) , NIL ) } )
		For nTab := nPos To nLen
			IF aTabCalend[ nTab , 2 ] == cOrd
				IF nTab == nPos
					cData	:= Dtoc( aTabCalend[ nTab , 1 ] )
					cDet	:= cData + Space( 11 - Len( cData ) ) + cCol
					cDia	:= DiaSemana( aTabCalend[ nTab , 1 ] , 3 )
					cDet	+= cDia + Space( 09 - Len( cDia ) ) + cCol
					IF nHrTrab > 0.00
						cHora	:= Space(03) + StrTran(StrZero(aTabCalend[nTab,3],5,2),".",":") + Space(03) + cCol
						cDet	+= cHora
					EndIF
					IF !aTabCalend[ nTab , 19 ]	//Se Nao For Feriado
						IF aTabCalend[ nTab , 06 ]  == "S"
							cTipoDia := STR0011 //"Trabalhado"
						ElseIF aTabCalend[ nTab , 06 ]  == "N"
							cTipoDia := STR0012	//"Nao Trabalhado"
						ElseIF aTabCalend[ nTab , 06 ]  == "D"	
							cTipoDia := STR0013	//"D.S.R."
						ElseIF aTabCalend[ nTab , 06 ]  == "C"
							cTipoDia := STR0014	//"Compensado"
						EndIF
						fTipoExtra( aTabCalend[ nTab , 12 ] , @cHeNorm )
						fTipoExtra( aTabCalend[ nTab , 13 ] , @cHeNotu )
					Else
						IF mv_par09 == 1.00 .or. ( mv_par09 == 2 .and. SPA->PA_FERIADO != "S" )
							cTipoDia	:= STR0015	//"Feriado"
							fTipoExtra( aTabCalend[ nTab , 20 ] , @cHeNorm )
							fTipoExtra( aTabCalend[ nTab , 21 ] , @cHeNotu )
						Else
							cTipoDia := STR0011 //"Trabalhado"
							fTipoExtra( aTabCalend[ nTab , 12 ] , @cHeNorm )
							fTipoExtra( aTabCalend[ nTab , 13 ] , @cHeNotu )
						EndIF
					EndIF
					cTipoDia	+= Space( 14 - Len( cTipoDia)	)	+ cCol
					cHeNorm		+= Space( 18 - Len( cHeNorm )	)	+ cCol
					cHeNotu		+= Space( 18 - Len( cHeNotu )	)	+ cCol
					cExcecao	:= Space(02) + IF( aTabCalend[ nTab , 10 ] == "E" , "Sim" , "Nao" )
					cExcecao	+= Space( 07 - Len( cExcecao )	)	+ cCol
					cTurno		:= Space( 01 ) + aTabCalend[ nTab , 14 ]
					cTurno		+= Space( 05 - Len( cTurno   )	)	+ cCol
					cSequenc	:= Space( 01 ) + aTabCalend[ nTab , 08 ]
					cSequenc	+= Space( 04 - Len( cSequenc )	)	+ cCol
					cCodRef		:= Space( 04 ) + aTabCalend[ nTab , 18 ]
					IF lTerminal
						cDescRef := AllTrim( fDesc("SP1",aTabCalend[ nTab , 18 ],"P1_DESC") )
						cDescRef := StrTran( cDescRef , "@" , "" )
						cDescRef := Capital( cDescRef )
						cDescRef := cDescRef + Space( nTamCpoRef - Len( cDescRef ) )
						cCodRef += " - " + cDescRef
					EndIF	
				Else
					IF nHrTrab > 0.00
						cHora := Space(03) + StrTran(StrZero(aTabCalend[nTab,3],5,2),".",":") + Space(03) + cCol
						cDet += cHora
					EndIF
				EndIF	
			Else
				IF Len( cDet ) == 22
					cDet += Subst( cBrc , 23 , 117 - 21 )
				ElseIF Len( cDet ) == 46
					cDet += Subst( cBrc , 47 , 117 - 45 )
				ElseIF Len( cDet ) == 70
					cDet += Subst( cBrc , 71 , 117 - 69 )
				ElseIF Len( cDet ) == 94
					cDet += Subst( cBrc , 95 , 117 - 93 )
				EndIF
				cHrTrab  := Space(01) + StrTran(StrZero(nHrTrab,5,2),".",":") + Space(03) + cCol
				cHrInte  := Space(01) + StrTran(StrZero(nHrInte,5,2),".",":") + Space(03) + cCol
				cDet += cTipoDia
				cDet += cHeNorm
				cDet += cHeNorm
				cDet += cExcecao
				cDet += cTurno
				cDet += cSequenc
				cDet += cHrTrab
				cDet += cHrInte
				cDet += cCodRef
	
				IF lTerminal
					IF lZebrado
						cHtml += '<tr bgcolor="#FAFBFC">' + CRLF
						cHtml += '<td class="dados_1"><div align="center" bgcolor="#FAFBFC" nowrap>' + CRLF
						cHtml += StrTran( cDet , cCol ,'</td></div>' + CRLF + '<td class="dados_1" bgcolor="#FAFBFC" nowrap><div align="center">' + CRLF  )
					Else
						cHtml += '<tr>' + CRLF
						cHtml += '<td class="dados_1" nowrap><div align="center">' + CRLF
						cHtml += StrTran( cDet , cCol ,'</td></div>' + CRLF + '<td class="dados_1" nowrap><div align="center">' + CRLF )
					EndIF	
					cHtml += '</td>' + CRLF
					cHtml += '</tr>' + CRLF
				Else
					Impr( cDet , "C" )
				EndIF
				
				Exit
			EndIF
		Next nTab
	EndIF
Next nX

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Imprime o Ultimo dia                                         ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF Len( cDet ) == 22
	cDet += Subst( cBrc , 23 , 117 - 21 )
ElseIF Len( cDet ) == 46
	cDet += Subst( cBrc , 47 , 117 - 45 )
ElseIF Len( cDet ) == 70
	cDet += Subst( cBrc , 71 , 117 - 69 )
ElseIF Len( cDet ) == 94
	cDet += Subst( cBrc , 95 , 117 - 93 )
EndIF
cHrTrab  := Space(01) + StrTran(StrZero(nHrTrab,5,2),".",":") + Space(03) + cCol
cHrInte  := Space(01) + StrTran(StrZero(nHrInte,5,2),".",":") + Space(03) + cCol
cDet += cTipoDia
cDet += cHeNorm		
cDet += cHeNorm
cDet += cExcecao
cDet += cTurno
cDet += cSequenc
cDet += cHrTrab
cDet += cHrInte
cDet += cCodRef

IF lTerminal
	IF lZebrado
		cHtml +=								'<tr bgcolor="#FAFBFC">' + CRLF
		cHtml += 									'<td class="dados_1"><div align="center" bgcolor="#FAFBFC" nowrap>' + CRLF
		cHtml += 										StrTran( cDet , cCol ,'</td></div>' + CRLF + '<td class="dados_1" bgcolor="#FAFBFC" nowrap><div align="center">' + CRLF  )
	Else
		cHtml += 								'<tr>' + CRLF
		cHtml += 									'<td class="dados_1" nowrap><div align="center">' + CRLF
		cHtml += 										StrTran( cDet , cCol ,'</td></div>' + CRLF + '<td class="dados_1" nowrap><div align="center">' + CRLF )
	EndIF	
	cHtml += 										'</td>' + CRLF
	cHtml +=									'</tr>' + CRLF
	cHtml +=								'</table>'
	cHtml +=								'<br>'
	cHtml +=							'</td>'
    cHtml +=							'<td background="imagens/tabela_conteudo_2.gif" width="7">&nbsp;</td>'
    cHtml +=						'</tr>'
    cHtml +=					'</table>'
    cHtml +=				'</td>'
  	cHtml +=			'</tr>'
  	cHtml +=			'<tr>' 
    cHtml +=				'<td><img src="imagens/tabela_conteudo_3.gif" width="1012" height="14"></td>'
  	cHtml +=			'</tr>'
	cHtml +=		'</table>'
	cHtml +=		'<p align="right"><a href="javascript:self.print()"><img src="imagens/imprimir.gif" width="90" height="28" hspace="20" border="0"></a></p>'
	cHtml +=	'</body>'
	cHtml += '</html>'
Else

	Impr( cDet , "C" )	//Imprime a Ultima Ordem
	Impr( cLin , "C" )	//Imprime Ultimo Separador
	Impr( ""   , "C" )	//Incrementa Linha

EndIF	

Return( cHtml )

/*
ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿
³Fun‡…o    ³fImpFunc    ³ Autor ³Marinaldo de Jesus   ³ Data ³17/07/2001³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´
³Descri‡…o ³Imprime o Calendario de Marcacoes                           ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Sintaxe   ³fImpFunc( lSalta , cDescTurn , lTerminal )					³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Parametros³                                                            ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³ Uso      ³QuadroHr()                                                  ³
ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Static Function fImpFunc( lSalta , cDescTurn )

Local cDet		:= ""
Local cSpace_01 := Space( 01 )

Static cCabecFun
Static cFilTurnSeq

IF cCabecFun == NIL .or. cFilTurnSeq != SRA->( RA_FILIAL+RA_TNOTRAB+RA_SEQTURN ) .or. Li == 58 .or. lSalta
	IF cCabecFun == NIL
		cCabecFun := Padr( AllTrim( STR0016 ) , 15 )	//"Mat."	
		cCabecFun += cSpace_01
		cCabecFun += Padr( AllTrim( STR0040 ) , 30 )	//"Nome"
		cCabecFun += cSpace_01
		cCabecFun += Padr( AllTrim( STR0041 ) , 10 )	//"Admissao"
		cCabecFun += cSpace_01
		cCabecFun += Padr( AllTrim( STR0042 ) , 25 )	//"Cargo/Descricao"
		cCabecFun += cSpace_01		
		cCabecFun += Padr( AllTrim( STR0043 ) , 37 )	//"Centro de Custo/Descricao"
		cCabecFun += cSpace_01
		cCabecFun += Padr( AllTrim( STR0044 ) , 13 )	//"Categoria"
		cCabecFun += cSpace_01
		cCabecFun += Padr( AllTrim( STR0045 ) , 17 )	//"Situacao"
		cCabecFun += cSpace_01
		cCabecFun += Padr( AllTrim( STR0046 ) , 55 )	//"Turno Atual/Descricao"
		cCabecFun += cSpace_01
		cCabecFun += Padr( AllTrim( STR0047 ) , 09 )	//"Seq.Atual"
	EndIF
	IF cFilTurnSeq != SRA->( RA_FILIAL+RA_TNOTRAB+RA_SEQTURN )
		cFilTurnSeq := SRA->( RA_FILIAL+RA_TNOTRAB+RA_SEQTURN )
	EndIF
	IF Li == 58
		Impr( cDescTurn , "C")
		Impr( ""	 	, "C")
	EndIF
	Impr( cCabecFun , "C")
	Impr( ""	 , "C")
EndIF

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Mascara do Relatorio (220 Colunas)                           ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Mat.   Nome                           Admissao   Cargo/Descricao           Centro de Custo/Descricao             		  Categoria     Situacao          Turno Atual/Descricao                            		   Seq.Atual
999999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX DD/MM/AAAA XXXX/XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXXX X/XXXXXXXXXXX X/XXXXXXXXXXXXXXX XXXX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX     XX
123456 123456789012345678901234567890 1234567890 1234567890123456789012345 1234567890123456789012345678901234567890123456 1234567890123 12345678901234567 1234567890123456789012345678901234567890123456789012345  123456789
1    6 1	   10	     20        30 1       10 1       10        20   25 1       10        20        30        40    46 1       10 13 1       10     17 1       10        20        30        40        50   55  1	   9
*/                                                                                              
                                                                                                        
cDet := SubStr( SRA->RA_MAT  , 1 , 15 )									//001 a 015
cDet += cSpace_01														//016
cDet += SubStr( SRA->RA_NOME , 1 , 30 )									//017 a 046
cDet += cSpace_01														//047
cDet += Dtoc( SRA->RA_ADMISSA )											//048 a 057
cDet += Space( IF( Len( Dtoc( SRA->RA_ADMISSA ) ) == 8 , 3 , 1 ) )		//058
cDet += SubStr( SRA->RA_CODFUNC , 1 , 4 )								//059 a 062
cDet += "/"																//063	
cDet += fDesc("SRJ",SRA->RA_CODFUNC,"RJ_DESC",20,SRA->RA_FILIAL)		//064 a 083
cDet += cSpace_01														//084
cDet += SubStr( SRA->RA_CC , 1 , 9 )									//085 a 093
cDet += "/"																//094
cDet += fDesc("SI3",SRA->RA_CC,"I3_DESC",25,SRA->RA_FILIAL)				//095 a 119
cDet += Space(03)														//120 a 122
cDet += SubStr( SRA->RA_CATFUNC , 1 ,1 )								//123
cDet += "/"																//124
cDet += fDesc("SX5","28"+SRA->RA_CATFUNC,"X5_DESCRI",11,SRA->RA_FILIAL)	//125 a 135
cDet += cSpace_01														//136
cDet += SubStr( SRA->RA_SITFOLH , 1 , 1 )								//137
cDet += "/"																//138
cDet += fDesc("SX5","31"+SRA->RA_SITFOLH,"X5_DESCRI",15,SRA->RA_FILIAL)	//139 a 153
cDet += cSpace_01														//154
cDet += SubStr( SRA->RA_TNOTRAB , 1 , 4 )								//155 a 157
cDet += "/"																//158
cDet += fDesc("SR6",SRA->RA_TNOTRAB,"R6_DESC",50,SRA->RA_FILIAL)		//159 a 208
cDet += ( cSpace_01 + cSpace_01 + cSpace_01 + cSpace_01 )				//209 a 212
cDet += SRA->RA_SEQTURN													//213 a 214

Impr( cDet )

IF lSalta
	Impr( "" , "P" )
EndIF

Return( NIL )
