/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "GPER080.CH"

Static cRot131
Static cRot132
Static cRotFER
Static cRotVerDiss
Static lTemRJKTP

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	   ³ GPER080  ³ Autor ³ Equipe RH		        ³ Data ³ 12/04/95  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao   ³ Demonstrativo de Medias								       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	   ³ U_GPER080()	     										       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	  ³ FNC          ³  Motivo da Alteracao				   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Raquel Hager³27/12/2013³M12RH01 RQ0911³Unificacao das Folhas de Pagamento.  ³±±
±±³Mariana M.  ³09/04/2015³TRETC7		 ³Replica chamado TRCNRI			   ³±±
±±³Esther V.   ³01/06/2016³TVFY37		 ³Incluido impressao da filial do func.³±±
±±³Gabriel A.  ³10/06/2016³TVH082        ³Ajuste para considerar os valores    ³±±
±±³            ³          ³              ³corretos no cálculo de médias.       ³±±
±±³Marcia Moura³06/07/16³TVMEN0          ³Criacao do controle para RA_HOJORVA, ³±±
±±³            ³        ³                ³controle de med. horas como sal base ³±±
±±|Claudinei S.|22/07/16|TVQQXK          |Ajuste em Gr080Imp() na chamada da,  |±±
±±|            |        |                |GPEXMED estava passando o lJorvar no |±±
±±|            |        |                |13º parâmetro e na verdade é o 14º.  |±±
±±|Isabel N.   |04/01/2017|MRH-3746      |Ajuste nos nomes dos campos conforme |±±
±±|            |          |              |cadastrados no ATUSX (RA_DEMISSAO p/ |±±
±±|            |          |              |RA_DEMISSA, RA_ADMISSAO p/ RA_ADMISSA|±±
±±|            |          |              |e RF_DATABASE para RF_DATABAS).      |±±
±±|Raquel Hager|19/01/2017|MRH-4655	     |Implementado Totalizador das verbas  |±±
±±|            |          |              |do Grupo 0 - Horista com Jornada     |±±
±±|            |          |              |Variável.  						   |±±
±±³Renan Borges³31/01/2017³MRH-5615	 	 ³Ajuste para no calculo da provisão   ³±±
±±³            ³          ³              ³quando houver férias e periculosidade³±±
±±³            ³          ³              ³paga nas ferias e na folha, seja gera³±±
±±³            ³          ³              ³do a baixa de adicionais corretamente³±±
±±³Raquel Hager³13/02/2017³MRH-4655	    ³Removido impressão de rodapé.         ³±±
±±³Gabriel A.  ³16/03/2017³MRH-8284      ³Ajuste para carregar o aPd de forma  ³±±
±±³            ³          ³              ³correta antes de chamar o GPEXMED.   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER080()
Local cDesc1 := STR0001		//"Demonstrativo de M‚dias"
Local cDesc2 := STR0002		//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3 := STR0003		//"usu rio."
Local cString:="SRA"					    // alias do arquivo principal (Base)
Local aOrd	 := {STR0004,STR0005,STR0006}	//"Matricula"###"Centro de Custo"###"Nome"

// Define Variaveis Private(Basicas)
Private aReturn     := {STR0007, 1,STR0008, 2, 2, 1, "",1 }		// "Zebrado"###"Administra‡„o"
Private nomeprog    :="gper080"
Private aLinha	    := { },nLastKey := 0
Private cPerg	    :="GPR080"
Private lImp13o     := .F.
Private lImpFer     := .F.
Private lTemJorVar	:= ( SRA->( Type("RA_HOJORVA") ) != "U" )
Private lJorVar		:= .F.

// Define Variaveis Private(Programa)
Private nOrdem
Private aInfo	 := {}
Private aFolBas[4] , aAdiBas[4] , aFerBas[4] , a13Bas[4]
Private aFolIR[4]  , aAdiIR[4]	, aFerIR[4]  , a13IR[4]
Private cAnoMes := ""
// Variaveis Utilizadas na funcao IMPR
Private titulo
Private AT_PRG	:= "GPER080"
Private wCabec0 := 1
Private wCabec1 := STR0009		//"DATA BASE: "
Private CONTFL	:= 1
Private LI		:= 0
Private nTamanho:= "M"

	// Carregar os Mnemonicos
	SetMnemonicos(Nil,Nil,.T.)

	// Verifica as perguntas selecionadas
	Pergunte("GPR080",.F.)


	// Variaveis utilizadas para parametros
	// mv_par01		//	Data Base (referencia)
	// mv_par02		//	Filial	De
	// mv_par03		//	Filial	Ate
	// mv_par04		//	Centro de Custo De
	// mv_par05		//	Centro de Custo Ate
	// mv_par06		//	Matricula De
	// mv_par07		//	Matricula Ate
	// mv_par08		//	Nome De
	// mv_par09		//	Nome Ate
	// mv_par10		//	Ferias, 13§ Salario, Aviso Previo, Todos
	// mv_par11		//	Situacao do Funcionario
	// mv_par12		//	Categoria do Funcionario
	// mv_par13		//	Considera Mes Atual do Acumulado
	// mv_par14		//	Imprime media de pagamento?
	// mv_par15		//	Apenas Histórico de Cálculo?

	Titulo := STR0010		//"DEMONSTRATIVO DE MEDIAS"
	wnrel:="GPER080"            //Nome Default do relatorio em Disco
	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

	/*	Teste para o ADVPR (Automação de Testes) - lRobo vem .T. do Caso de Teste	*/
	IF TYPE ("lRobo") == "L"
		If !lRobo
			nOrdem 		:= aReturn[8]
		Else
			nOrdem		:= nOrd
		Endif
	Else
		nOrdem 		:= aReturn[8]
	Endif

	dDtBase    := mv_par01
	cFilDe	   := mv_par02
	cFilAte    := mv_par03
	cCcDe	   := mv_par04
	cCcAte	   := mv_par05
	cMatDe	   := mv_par06
	cMatAte    := mv_par07
	cNomDe	   := mv_par08
	cNomAte    := mv_par09
	nTipoMed   := mv_par10
	cSituacao  := mv_par11
	cCategoria := mv_par12
	lMesAtu    := If(mv_par13 == 3, .F., .T.)  // 1 - Mensal  2 - Acumulado  3 - Nao
	lMovMensal := If(mv_par13 == 1, .T., .F.)
	wCabec1    += DTOC(dDtBase)
	lImpPgto   := If(mv_par14 == 2, .F., .T.)
	lHistCalc  := Iif( ValType(MV_PAR15) == "N" .And. MV_PAR15 == 1, .T., .F. ) //1=Sim / 2=Não
	cAnoMes    := strzero(year(dDtBase),4)+strzero(month(dDtBase),2)
    lImp13o    := (nTipoMed == 2 .Or. nTipoMed == 5)
    lImpFer    := (nTipoMed == 1 .Or. nTipoMed == 5)

	If nLastKey = 27
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey = 27
		Return
	EndIf

	RptStatus({|lEnd| GR080Imp(@lEnd,wnRel,cString)},Titulo)

	RstXMED() //Reinicializa statics do GPEXMED
	SetRotExec( "__cRotInExec" )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³ GR080Imp ³ Autor ³ R.H. - Jose Ricardo	³ Data ³ 12/04/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Demonstrativo de Medias.									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso	 	 ³ GPER080   												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gr080Imp(lEnd,WnRel,cString)

Local CbTxt
Local CbCont
Local Val_SalMin 	:= 0
Local dDt1,dDt3,dDt4,dDt6
Local cFilAnterior 	:= Replicate("!", FWGETTAMFILIAL)
Local nSalario		:= nSalMes := nSalDia := nSalHora := 0
Local cInicio, cFim	:= ""
Local cChaveSRF 	:= ""
Local cErro			:= ""
Local cNomeForm		:= ""
Local aHelpPor		:= {}
Local aPerAtual   	:= {}
Local aFalha		:= {}
Local aLastRegProc	:= {}
Local aLog			:= {}
Local aLogInit		:= {}
Local aTitLog		:= {}
Local lTrfExt       := .F.
Local nLoop   		:= 0
Local nRazaoDia   	:= 0
Local nRazaoHr    	:= 0
Local nRet			:= 0
Local nX			:= 0

// Variaveis de Acesso do Usuario
Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER080" , "SRA" , "2" ) + " } " )

// Variaveis para tratamento das data base de medias de ferias p/ demitidos
Local lSubsTp		:= "MSSQL" $  AllTrim( Upper( TcGetDb() ) ) .Or. AllTrim( Upper( TcGetDb() ) ) == 'SYBASE'
Local cSelBsFer		:= ""
Local cAliasQry		:= ""
Local cJnSRRSRV		:= ""
Local nRecSRF		:= 0

// Define Variaveis Privates (Programa)
c__Roteiro			:= "   "
Private aPdv		:= {} // Matriz Incidencia de Verbas Usado na Fvaloriza()
Private aCodFol		:= {}
Private aRoteiro	:= {}
Private APERIODO	:= {}
Private cComp13 	:= 'N'

Private aSalFer     := {}
Private aSal13      := {}
Private aSalAP      := {}
Private aSalFol     := {}

//------------ Variaveis usadas em GPEXMED ---------------
Private cProcesso
Private aPerFerias
Private nVal1Parc13	:= 0
Private cTipoRot	:= fGetTipoRot( GetRotExec() )

DEFAULT cRot131     := fGetCalcRot("5")
DEFAULT cRot132     := fGetCalcRot("6")
DEFAULT cRotFER     := fGetCalcRot("3")

	If Type("P_FERPAC") == "U"
		Private P_FERPAC:= "N"
        dbSelectArea("RCA")
        RCA->( dbSetOrder(1) )
		If RCA->( dbSeek( xFilial( "RCA" ) + "P_FERPAC" ) )
			P_FERPAC := AllTrim( RCA->RCA_CONTEU )
		EndIf
	EndIf
	//-------------------------------------------------------

	// Criar Arquivo de Medias Temporario
	Cria_TRP()

	dbSelectArea ("SRA")
	DbGoTop()
	If nOrdem == 1
		dbSetOrder(1)
		dbSeek( cFilDe + cMatDe,.T. )
		cInicio  := "SRA->RA_FILIAL + SRA->RA_MAT"
		cFim	 := cFilAte + cMatAte
	ElseIf nOrdem == 2
		dbSetOrder(2)
		dbSeek( cFilDe + cCcDe + cMatDe,.T. )
		cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
		cFim	 := cFilAte + cCcAte + cMatAte
	ElseIf nOrdem == 3
		dbSetOrder(3)
		dbSeek( cFilDe + cNomDe + cMatDe,.T. )
		cInicio  := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
		cFim	 := cFilAte + cNomAte + cMatAte
	EndIf

	If lSubsTp
		cSelBsFer := "% SUBSTRING(RR_NUMID,1,8) %"
	Else
		cSelBsFer := "% SUBSTR(RR_NUMID,1,8) %"
	EndIf

	cJnSRRSRV	:= "% " + FWJoinFilial( "SRR", "SRV" ) + " %"

	dbSelectArea("SRA")
	SetRegua(SRA->(RecCount()))

	Begin Sequence
	While !Eof() .And. &cInicio <= cFim

		IncRegua()

		If lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		Endif

		//Se já não encontrou Processo e período, pula registro
		If !Empty(aFalha) .and. ( Ascan(aFalha,{ |X| X[1]+X[2]+X[3] == xFilial("RCH",SRA->RA_FILIAL) + SRA->RA_PROCES + AnoMes(MV_PAR01) } ) ) > 0
			dbSelectArea( "SRA" )
			dbSkip()
			Loop
		EndIf

		// Consiste Parametrizacao do Intervalo de Impressao
		If (SRA->RA_NOME < cNomDe) .Or. (SRA->RA_NOME > cNomAte) .Or. ;
		   (SRA->RA_MAT < cMatDe)  .Or. (SRA->RA_MAT > cMatAte)  .Or. ;
			(SRA->RA_CC < cCcDe)	.Or. (SRA->RA_CC > cCcAte)
			SRA->(dbSkip(1))
			Loop
		EndIf

		// Consiste Filiais e Acessos
		If !( SRA->RA_FILIAL $ fValidFil() ) .Or. !Eval( cAcessaSRA )
			SRA->(DbSkip())
			Loop
		EndIf

		// Despreza conforme Situacao e Categoria dos funcionarios
		If	!( SRA->RA_SITFOLH $ cSituacao ) .Or. !( SRA->RA_CATFUNC $ cCategoria )
			dbSkip()
			Loop
		Endif

        If !lHistCalc
            // Quebra de Filial
            If cFilAnterior # SRA->RA_FILIAL
                cFilAnterior := SRA->RA_FILIAL
                // Carrega os mnemônicos de acordo com a filial do funcionário
                RstMnemonicos()
                SetMnemonicos(cFilAnterior, Nil, .T.)	
                
                c__Roteiro := "   "			
                lMesAtu    := If(mv_par13 == 3, .F., .T.)  // 1 - Mensal  2 - Acumulado  3 - Nao
                cAnoMes    := strzero(year(dDtBase),4)+strzero(month(dDtBase),2)			
                If !FP_CODFOL(@aCodFol,SRA->RA_FILIAL)
                    Return
                EndIf
            EndIf

            cProcesso	:= SRA->RA_PROCES
            aPerFerias	:= {}
            dDt1        := ""
            lTrfExt     := .F.

            If	nTipoMed == 1 .Or. nTipoMed == 5
                dbSelectArea( "SRF" )
                SRF->( dbSetOrder(2) )
                cChaveSRF := SRA->RA_FILIAL + SRA->RA_MAT + FGETCODFOL("0072")
                If SRF->( dbSeek( cChaveSRF ) )

                    cAliasQry := GetNextAlias()

                    If !Empty( SRA->RA_DEMISSA ) .And. SRA->RA_SITFOLH == "D"
                        BeginSql alias cAliasQry

                            SELECT DISTINCT %exp:cSelBsFer% RR_NUMID
                            FROM %table:SRR% SRR
                            INNER JOIN %table:SRG% SRG
                                ON		SRR.RR_FILIAL	=	SRG.RG_FILIAL
                                    AND	SRR.RR_MAT		=	SRG.RG_MAT
                                    AND	SRR.RR_DATA		=	SRG.RG_DTGERAR
                            INNER JOIN %table:SRV% SRV
                                ON		%exp:cJnSRRSRV%
                                    AND	SRR.RR_PD		=	SRV.RV_COD
                            WHERE		SRR.RR_FILIAL	=   %exp:Upper( SRA->RA_FILIAL )%
                                    AND SRR.RR_MAT		=   %exp:Upper( SRA->RA_MAT )%
                                    AND SRR.RR_TIPO3	=   %exp:Upper( 'R' )%
                                    AND SRR.RR_NUMID	<>	%exp:Upper( ' ' )%
                                    AND SRV.RV_CODFOL IN ( '0086', '0224', '0248' )
                                    AND	SRG.%notDel%
                                    AND SRV.%notDel%
                                    AND SRR.%notDel%
                            ORDER BY %exp:1%
                        EndSql

                        If ( cAliasQry )->( !Eof() )
                            dDt1 := SToD( ( cAliasQry )->RR_NUMID )
                        EndIf
                    EndIf

                    If Select( cAliasQry ) > 0
                        ( cAliasQry )->( dbCloseArea() )
                    EndIf

                    If Empty( dDt1 )
                        If ( !Empty( SRA->RA_DEMISSA ) .And. SRA->RA_SITFOLH == "D" )
                            lTrfExt := !fResTrf()
                        EndIf

                        dbSelectArea( "SRF" )
                        While !SRF->( Eof() ) .And. ( SRF->RF_FILIAL + SRF->RF_MAT + SRF->RF_PD == cChaveSRF )
                            If ( !Empty( SRA->RA_DEMISSA ) .And. SRA->RA_SITFOLH == "D" ) .And. !lTrfExt
                                dDt1 := SRF->RF_DATABAS
                                nRecSRF := SRF->(Recno())
                            ElseIf ( SRF->RF_STATUS == "1" )
                                dDt1 := SRF->RF_DATABAS
                                Exit
                            EndIf
                            SRF->( DbSkip() )
                        EndDo
                        If nRecSRF > 0
                            SRF->(dbGoto(nRecSRF))
                        EndIf
                    ElseIf ( !Empty( SRA->RA_DEMISSA ) .And. SRA->RA_SITFOLH == "D" )
                        SRF->( dbSetOrder(1) )
                        cChaveSRF := SRA->RA_FILIAL + SRA->RA_MAT + DTOS(dDt1)
                        SRF->( dbSeek( cChaveSRF ) )
                    EndIf
                Else
                    dDt1 := SRA->RA_ADMISSA
                EndIf
                SRF->( dbSetOrder(1) )
                DbSelectArea("SRA")
            EndIf

            dDt3 := If(nTipoMed == 2 .Or. nTipoMed == 5,dDtBase,"")
            dDt4 := If(nTipoMed == 3 .Or. nTipoMed == 5,dDtBase,"")
            dDt6 := If(nTipoMed >= 4 ,If(SRA->RA_SEXO == "M", "", dDtBase),"")

            nSalario := 0
            nSalMes  := 0
            nSalDia  := 0
            nSalHora := 0
            nRet	 := 0

            InitLogExecRot()
            fSalInc(@nSalario, @nSalMes, @nSalHora, @nSalDia, .T., Nil, Nil, Nil, mv_par01, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, @cNomeForm, @nRet)
            If nSalario == 0
                nRet := 0
                fSalInc(@nSalario, @nSalMes, @nSalHora, @nSalDia, .T., Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, @cNomeForm, @nRet)
            Endif

            If nRet == 2
                aAdd( aTitLog, STR0071 + " - " + cNomeForm)//"Cálculo finalizado pela FinalCalc() ou pela EndCalc()"
                aAdd( aLastRegProc, STR0072 )//"Último Registro Processado"
                aAdd( aLastRegProc, STR0073 )//"Filial - Matrícula "
                aAdd( aLastRegProc, SRA->RA_FILIAL + " - " + SRA->RA_MAT )
                aAdd( aLog, aClone( aLastRegProc ) )
                aLogInit := LogExecRot()
                For nLoop := 1 To Len( aLogInit )
                    IF !Empty( aLogInit[ nLoop, 2 ] ) .And. Len( aLogInit[ nLoop, 2 ] ) > 0
                        aAdd( aTitLog, aLogInit[ nLoop, 1 ] )
                        aAdd( aLog, aClone( aLogInit[ nLoop, 2 ] ) )
                    EndIf
                Next nLoop
                fMakeLog( aLog, aTitLog, FunName(), NIL, FunName()+"Log", STR0074 ) //"Log de Ocorrências"
                Break
            EndIf

            // Busca os valores de Rescisao e os carrega em aPd
            If lMovMensal .And. !Empty(SRA->RA_DEMISSA)
                aPd := {}		// Limpar aPd em caso de rescisao para nao duplicar os valores lancados no SRC que foram levados para rescisao
                fApdResc(dDtBase)
            EndIf
            //Verifica se e' funcionario horista com jornada variavel
            If lTemJorVar
                lJorVar := ( SRA->RA_CATFUNC == "H" .And. SRA->RA_HOJORVA == "1" )
            EndIf

            // Monta Media
            dbSelectArea(cTBLXMED)
            Zap

            nRazaoDia := Round(nSalMes / nSalDia, 0)
            nRazaoHr  := Round(nSalMes / nSalHora, 0)

            If !( U_fSalIncMed(@aSalFer,@aSal13,@aSalAP,@aSalFol,dDtBase,nSalario,nRazaoDia,nRazaoHr,nSalMes) )
                aAdd(aFalha, {xFilial("RCH",SRA->RA_FILIAL), SRA->RA_PROCES, AnoMes(MV_PAR01)})
                dbSelectArea( "SRA" )
                dbSkip()
                Loop
            EndIf

            If GPEXMED(dDt1,,dDt3,dDt4,dDtBase,nSalHora,Val_SalMin,aCodfol,lMesAtu,lMovMensal,,dDt6,,lJorVar)
                U_fImpr_Med(nSalMes,nSalDia,nSalHora,,lImpPgto)
            EndIf
		Else
            If fTemHist()
        	    U_fVerHistMed( Nil, Nil, Nil, Nil, cAnoMes, cAnoMes, .T., aClone(aReturn) )
            EndIf
        EndIf

		dbSelectArea( "SRA" )
		dbSkip()
	Enddo
	End	Sequence

	If !Empty(aFalha)
		aSort( aFalha ,,, { |X,Y| X[1]+ x[2] < Y[1]+y[2] } )
		cErro := ""
		For nX := 1 to Len(aFalha)
			cErro += STR0045 + aFalha[nX,1] + " " + STR0052 + aFalha[nX,2] + CRLF
		Next nX
		MsgInfo(STR0050 + CRLF + cErro) //"Não há período cadastrado para a competência."
	EndIf

	// Termino do relatorio
	dbSelectArea( "SRA" )
	Set Filter to
	dbSetOrder(1)

	If Empty( aTitLog )
		Set Device To Screen

		If aReturn[5] = 1
			Set Printer To
			Commit
			ourspool(wnrel)
		EndIf

		MS_FLUSH()
	EndIf
	fDelTMPMED()

Return( Nil )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³ fImpr_Med ³ Autor ³ Equipe RH        	³ Data ³ --/--/-- ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao das Medias.    								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso	 	 ³ GPER080   												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fImpr_Med(nSalMes,nSalDia,nSalHora,cTipoMov,lImpPgto)
Local aTipoRel := {STR0011,STR0012,STR0013,STR0014, STR0043 }		//"F‚rias Vencidas"###"F‚rias a Vencer"###"13o Sal rio"###"Aviso Pr‚vio"###"Lic.Maternidade"
Local nTipo    := 0
Local cTipo      := "0", cPd := "000"
Local cTitulo    := "",aTipMed,cTipoRel
Local cImpressas := ""
Local cPropVerba := ""
Local lAtuDatBse := .F.
Local dDtBasVen  := CToD("")
Local nCnt
Local nIndMes	 := 1
Local dDataAux   := CToD("")
Local aOfusca	 := If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F. }) //[2]Ofuscamento
Local aFldRel	 := If(aOfusca[2], FwProtectedDataUtil():UsrNoAccessFieldsInList( {"RA_NOME","RA_NUMCP","RA_SERCP"} ), {})
Local lOfuscaNom := .F.
Local lOfuscaNcp := .F.
Local lOfuscaScp := .F.
Local cDataarq	 := ""

Private A1COLUNA 	:= {}
Private A2COLUNA 	:= {}
Private	LI    		:= 0
Private nMes        := nDia := nHor := 0
Default cTipoMov	:= " "
Default lImpPgto	 := .T.

	If aOfusca[2] .And. Len(aFldRel) > 0
		lOfuscaNom := aScan( aFldRel, {|x| x:cfield == "RA_NOME" }) > 0
		lOfuscaNcp := aScan( aFldRel, {|x| x:cfield == "RA_NUMCP"}) > 0
		lOfuscaScp := aScan( aFldRel, {|x| x:cfield == "RA_SERCP"}) > 0
	EndIf

	If FunName()== "GPEM030"
		If Type("wCabec1") <> "U"
			dDataAux := DToC(RH_DATAINI)
			wCabec1  := STR0009 + dDataAux
		EndIf
		dDtBasVen := RH_DATABAS
	Else
		dDtBasVen := SRF->RF_DATABAS
	EndIf

	nMes := nSalMes
	nDia := nSalDia
	nHor := nSalhora

	// Ponto para alterar variaveis do de salario do cabecalho
	If ExistBlock("GP080ALT")
		Execblock("GP080ALT",.F.,.F.)
	EndIf

	cColuna := "A1COLUNA"
	dbSelectArea( cTBLXMED )

	// Tipos de Medias a Imprimir:
	// 1-Ferias Vencidas 1o Periodo
	// 2-Ferias a Vencer
	// 3-13o Salario
	// 4-Aviso Previo
	// 5 a 9-Ferias Vencidas Periodos 2o,3o,4o...
	// A-Licenca Maternidade
	aTipMed    := { "1","5","6","7","8","9","2","3","4","A" }
	For nCnt := 1 To Len(aTipMed)
		If !dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + aTipMed[nCnt] )
			Loop
		ElseIf !(aTipMed[nCnt] $ "3*4*A") // 13o.Salario e Aviso Previo
			cImpressas += aTipMed[nCnt] + "*"
		EndIf

		fDsrHrsAtiv(aTipMed[nCnt],aCodFol) //Calculo do DSR / Horas Atividade de professores
		
		// Identificacao de existencia de periodo de ferias vencido
		If cTipoRot == "4"
			// 350 = 365 - 15 dias, pois precisa so de 15 dias do ultimo 'mes' p/ ser ferias vencidas
			lTemVenc := dDataDem - SRF->RF_DATABAS > 349
		ElseIf cTipoRot == "3"
			lTemVenc := M->RH_DFERVEN > 0
		Else
			// 350 = 365 - 15 dias, pois precisa so de 15 dias do ultimo 'mes' p/ ser ferias vencidas
			lTemVenc := Stod( MesAno(dDtBase) + Alltrim( Str( f_UltDia(dDtBase) ) ) ) - SRF->RF_DATABAS > ( SRF->(RF_DATAFIM - RF_DATABAS) - 15 )
		EndIf

		// Se for impressao a partir das ferias e nao tiver 1a.parcela
		// nao imprime o demonstrativo de medias de 13o.salario.
		If cTipoMov == "F"
			If M->RH_PERC13S == 0 .And. aTipMed[nCnt] == "3"
				Loop
			EndIf
		EndIf

		// Se houver mais de um periodo de vencida atualiza a data base
		lAtuDatBse := .F.
		Aeval( aTipMed, { |x| If( x $ cImpressas .And. ( ( x # aTipMed[nCnt] .Or. aTipMed[nCnt] == "2" ) .And. 	lTemVenc ), lAtuDatBse := .T., "" ) } )
		If aTipMed[nCnt] $ "2*5*6*7*8*9" .And. lAtuDatBse .And. (FunName() <> "GPEM030")
			If SRF->(RF_DATAFIM - RF_DATABAS) + 1 < 365 //Se o período aquisitivo for menor que 1 ano significa que houve troca de data base em virtude de férias coletivas
				dDtBasVen := dDtBasVen + SRF->(RF_DATAFIM - RF_DATABAS) + 1
			Else
				dDtBasVen := fCalcFimAq(dDtBasVen)+1 // Inicio do proximo periodo
			EndIf
		EndIf

		If Len(A1COLUNA) # 0
			U_DESCARREGA()
			cColuna := "A1COLUNA"
			IMPR(" ","C")
		EndIf

		cTipo := (cTBLXMED)->RP_TIPO
		LI    := 0
		cDataarq := ""
		While !Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT+cTipo = (cTBLXMED)->RP_FILIAL+(cTBLXMED)->RP_MAT+(cTBLXMED)->RP_TIPO

			//Exibe a media de acordo com a configuracao da verba - Peru
			If cPaisLoc == "PER"
				cPropVerba := PosSRV( (cTBLXMED)->RP_PD, SRA->RA_FILIAL, "RV_REMCOMP" )
		    	If cPropVerba $ "1|2|3"
					nIndMes	:= 2
	 			Else
					nIndMes	:= 1
	    		EndIf
			EndIf

			// Inicio da Impressao Das Linhas Detalhes
			If LI = 0
		  		nTipo    := If( cTipo=="A",5,If( cTipo>"4",1,Val(cTipo)))
				cTipoRel := aTipoRel[nTipo]+If( nTipo==1, "("+Str(nCnt,1)+")", "" )
				TITULO := STR0015+cTipoRel+ " ***"		//"*** DEMONSTRATIVO DE MEDIA DE HORAS EXTRAS E ADICIONAIS PARA "
				IMPR(" "+REPL("_",130),"C")
				DET := "| " + OemToAnsi(STR0045) + " " + SRA->RA_FILIAL + " - " + FWFilialName(, SRA->RA_FILIAL,1)
				DET := AllTrim(DET)+SPACE(131-Len(AllTrim(DET)))+"|"
				IMPR(DET,"C")
				DET := PADR(STR0016, 19)+If(lOfuscaNom, Replicate('*',30), Left(SRA->RA_NOME,30))+SPACE(2)+STR0017+If(lOfuscaNcp, Replicate('*',7), SRA->RA_NUMCP)+" - "+If(lOfuscaScp, Replicate('*',5), SRA->RA_SERCP)+SPACE(2)+PADR(STR0018, 10) //"| Funcionario....: "###"Cart.Trab.:"###"Registro: "
				DET += SRA->RA_MAT+SPACE(2)+STR0019				//"Admissao:"
				DET += PADR(DTOC(SRA->RA_ADMISSA),10)
				DET := AllTrim(DET)+SPACE(131-Len(AllTrim(DET)))+"|"
				IMPR(DET,"C")
				DET := "| " + STR0020+Subs(SRA->RA_CC+Space(20),1,20)+" - "+DescCC(SRA->RA_CC,SRA->RA_FILIAL,40)+Space(1)		//"| Centro de Custo: "
				DET += STR0021+SRA->RA_CODFUNC + " - " + DescFun(SRA->RA_CODFUNC,SRA->RA_FILIAL,30) //"Funcao....: "
				DET := AllTrim(DET)+SPACE(131-Len(AllTrim(DET)))+"|"
				IMPR(DET,"C")
				DET := "| "+IF(nTipo<3,STR0022+If(nCnt==1 .and. !Empty(SRF->RF_IVENPEN), ;
				                              PADR(DTOC(SRF->RF_IVENPEN),10),  ;
				                              PADR(DTOC(dDtBasVen),10) )  ,SPACE(20))+SPACE(09)										//"Base Fer:"
				If !(AllTrim(cTipo) $ "A/4/3") .And. Type("aSalFer") <> "U" .And. Len(aSalFer) > 0
					DET += PADR(STR0044, 21) + TRANSFORM(aSalFer[1][1],"@E 999,999,999.99") + STR0024 + SPACE(2) + TRANSFORM(aSalFer[1][2],"@E 999,999,999.99")+STR0025		//"| Salario Base...: "###" por mes"###" por dia"
					DET += SPACE(5) + TRANSFORM(aSalFer[1][3],"@E 999,999,999.99") + STR0026+SPACE(5)	//" por hora"
				ElseIf (AllTrim(cTipo) $ "4") .And. Type("aSalAP") <> "U" .And. Len(aSalAP) > 0
					DET += PADR(STR0044, 21)+TRANSFORM(aSalAP[1][1],"@E 999,999,999.99")+STR0024+SPACE(2)+TRANSFORM(aSalAP[1][2],"@E 999,999,999.99")+STR0025		//"| Salario Base...: "###" por mes"###" por dia"
					DET += SPACE(5)+TRANSFORM(aSalAP[1][3],"@E 999,999,999.99") + STR0026+SPACE(5)	//" por hora"
				ElseIf (AllTrim(cTipo) $ "3").And. Type("aSal13") <> "U" .And. Len(aSal13) > 0
					DET += PADR(STR0044, 21)+TRANSFORM(aSal13[1][1],"@E 999,999,999.99")+STR0024+SPACE(2)+TRANSFORM(aSal13[1][2],"@E 999,999,999.99")+STR0025		//"| Salario Base...: "###" por mes"###" por dia"
					DET += SPACE(5)+TRANSFORM(aSal13[1][3],"@E 999,999,999.99") + STR0026+SPACE(5)	//" por hora"
				ElseIf Type("aSalFol") <> "U" .And. Len(aSalFol) > 0 .And. aSalFol[1,1] >= nMes
					DET += PADR(STR0044, 21)+TRANSFORM(aSalFol[1][1],"@E 999,999,999.99")+STR0024+SPACE(2)+TRANSFORM(aSalFol[1][2],"@E 999,999,999.99")+STR0025		//"| Salario Base...: "###" por mes"###" por dia"
					DET += SPACE(5)+TRANSFORM(aSalFol[1][3],"@E 999,999,999.99") + STR0026+SPACE(5)	//" por hora"
				Else
					DET += PADR(STR0044, 21)+TRANSFORM(nMes,"@E 999,999,999.99")+STR0024+SPACE(2)+TRANSFORM(nDia,"@E 999,999,999.99")+STR0025		//"| Salario Base...: "###" por mes"###" por dia"
					DET += SPACE(5)+TRANSFORM(nHor,"@E 999,999,999.99") + STR0026 + SPACE(5)	//" por hora"
				EndIf

				DET := AllTrim(DET)+SPACE(131-Len(AllTrim(DET)))+"|"
				IMPR(DET,"C")
				IMPR("|"+REPL("_",130)+"|","C")
			Endif

			If (cTBLXMED)->RP_PD # cPd
				IF !Empty(cDataarq) .and. cDataarq > (cTBLXMED)->RP_DATARQ .And. (cPd <> "998" .And. cPd <> "997")
					U_FTrocaColuna()
				EndIf

				nTipo    := If( cTipo=="A",5,If( cTipo>"4",1,Val(cTipo)))
				cTipoRel := aTipoRel[nTipo]+If( nTipo==1, "("+Str(nCnt,1)+")", "" )
				cTitulo  := If((cTBLXMED)->RP_PD="999",STR0027+cTipoRel,If((cTBLXMED)->RP_PD="998",STR0028+cTipoRel,;					//"TOTAIS - "###"TOTAL FALTAS - "
						        If((cTBLXMED)->RP_PD="997",STR0029+cTipoRel,If((cTBLXMED)->RP_PD="995", STR0046+cTipoRel, (cTBLXMED)->RP_PD+" - "+DescPd((cTBLXMED)->RP_PD,SRA->RA_FILIAL,20)))))	//"TOTAL ADTO. -  " ### //"TOTAL GRUPO 0. -  "
				DET := SPACE(12)+"*** "+ cTitulo + " ***" + SPACE(42-Len(cTitulo))
				AADD(&(cColuna),DET)
				If (cTBLXMED)->RP_PD = "998"
					DET := SPACE(21)+STR0030+SPACE(37)		//"DIAS"
				ElseIf (cTBLXMED)->RP_PD = "997"
					DET := SPACE(57)+STR0031					//"VALOR"
				Else
					DET := STR0032		//"REF.    DATA PGT     HORAS      VALOR ORIG.        VALOR ATUAL"
				EndIf
				AADD(&(cColuna),DET)
				DET := REPL("_",62)
				AADD(&(cColuna),DET)
				cPd := (cTBLXMED)->RP_PD

			EndIf

			// | REF.    DATA PGT     HORAS      VALOR ORIG.        VALOR ATUAL |
			// | 99/9999 99/99/9999 9999.99   999.999.999.99   9.999.999.999.99 |
			// | ** TOTAL           9999,99           500,00             500,00 |
			// | ** MEDIA     (12)  9999,99            41,67              41,67 |
			// | ** MEDIA PGTO(12)  9999,99            41,67              41,67 |
			// | * TOT OUTROS       9999,99         2.480,90           2.480,90 |
			// | * MED OUTROS       9999,99           206,75             206,75 |
			// | * OUTROS PGTO      9999,99           206,75             206,75 |
			// | * TOT H.EXT        9999,99             0,00               0,00 |
			// | * MED H.EXT        9999,99             0,00               0,00 |
			// | * H.EXT PGTO       9999,99             0,00               0,00 |
			// | ** TOTAL           9999,99         2.480,90           2.480,90 |
			// | ** MEDIA           9999,99           206,75             206,75 |
			// | ** MEDIA PGTO      9999,99           206,75             206,75 |
			// | NO PERIODO         9999,99

			If (cTBLXMED)->RP_DATARQ = "9798  "
				DET := STR0033
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;		//"* TOT OUTROS"
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9799  "
				DET := STR0034
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD=="999","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* MED OUTROS  "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "97MD  "
				DET := STR0035
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI/nIndMes,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* OUTROS PGTO "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9898  "
				DET := STR0036
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* TOT H.EXT "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9899  "
				DET := STR0037
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* MED H.EXT   "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "98MD  "
				DET := STR0038
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* H.EXT PGTO  "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9598  "
				DET := iif(cPd='995',STR0047,STR0039)
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;		//"* TOT GRUPO 0" //"** TOTAL      "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
				U_FTrocaColuna()
			ElseIf (cTBLXMED)->RP_DATARQ = "9599  "
				DET := STR0048
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD=="995","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* MED GRUPO 0  "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "95MD  "
				DET := STR0049
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD == "995","","("+StrZero((cTBLXMED)->RP_MESMEDI/nIndMes,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* GRUPO 0 PGTO "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
				U_FTrocaColuna()
			ElseIf (cTBLXMED)->RP_DATARQ = "9998  "
				DET := STR0039
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"** TOTAL      "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9999  "
				DET := STR0040+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"** MEDIA     "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "99MD  "
				If lImpPgto
					DET := STR0041+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI/nIndMes,2)+") ")
					DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM(Round((cTBLXMED)->RP_VALOR,2),"@E 999,999,999.99")+;	//"** MEDIA PGTO"
					SPACE(3)+TRANSFORM(Round((cTBLXMED)->RP_VALATU,2),"@E 9,999,999,999.99")
					AADD(&(cColuna),DET)
				EndIf
				
			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "ZZ01"
				DET := STR0061 //"*** TOT INSALUB"
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"*** TOT INSALUB"
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "ZZ02"
				DET := STR0062//"*** TOT PERICUL"
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"*** TOT PERICUL"
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "ZZ03"
				DET := STR0063//"*** TOT DSR "
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"*** TOT DSR "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "ZZ04"
				DET := STR0064//"*** TOT DSRHATIV "
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"*** TOT DSRHATIV "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_PD = "998"
				If (cTBLXMED)->RP_TIPO="3" .and. !(cTBLXMED)->RP_DATARQ = "9698"
					DET := RIGHT((cTBLXMED)->RP_DATARQ,2)+"/"
					DET += PADR(IF(nTData==8,SubStr((cTBLXMED)->RP_DATARQ,3,2),Left((cTBLXMED)->RP_DATARQ,4)),7)
				Else
					DET := STR0042		//"NO PERIODO"
				Endif
				DET += SPACE(10)+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(35)
				AADD(&(cColuna),DET)

			ElseIf (cTBLXMED)->RP_PD = "997"
				DET := SPACE(46)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			Else
				DET := PADR(RIGHT((cTBLXMED)->RP_DATARQ,2)+"/"+IF(nTData==8,SubStr((cTBLXMED)->RP_DATARQ,3,2),Left((cTBLXMED)->RP_DATARQ,4)),8)
				DET += PADR(DTOC((cTBLXMED)->RP_DATPGT),10)+SPACE(1)+;
					TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			Endif
			dbSelectArea( cTBLXMED )
			cDataarq := (cTBLXMED)->RP_DATARQ
			dbSkip()
		EndDo
	Next nCnt

	If Len(A1COLUNA) # 0
		U_DESCARREGA()
		Li := 0
	EndIf

Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³ DESCARREGA³ Autor ³ Equipe RH        	³ Data ³ --/--/-- ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao dos vetores contendo detalhes da impressao.      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso	 	 ³ GPER080   												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function DESCARREGA
Local x

	If Len(A1COLUNA) > Len(A2COLUNA)
		cColuna = "A1COLUNA"
		ASIZE(A2COLUNA,Len(A1COLUNA))
	Else
		cColuna = "A2COLUNA"
		ASIZE(A1COLUNA,Len(A2COLUNA))
	EndIf

	For x = 1 TO Len(&(cColuna))
		DET = "| "+IF(A1COLUNA[x]=NIL,SPACE(62),A1COLUNA[x])+" || "+IF(A2COLUNA[x]=NIL,SPACE(62),A2COLUNA[x])+" |"
		IMPR(DET,"C")
	Next x

	IMPR("|"+REPL("_",130)+"|","C")
	ASIZE(A1COLUNA,0)
	ASIZE(A2COLUNA,0)

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³ FTrocaColuna ³ Autor ³ Equipe RH        	³ Data ³ --/--/-- ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Troca de Coluna.										      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso	 	 ³ GPER080   												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FTrocaColuna()

	If cColuna = "A2COLUNA"
		U_DESCARREGA()
		cColuna = "A1COLUNA"
	Else
		cColuna = "A2COLUNA"
	EndIf

Return( Nil )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fApdResc | Autor ³ Equipe RH             ³ Data ³ 27/04/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verifica se deve incluir as medias do mes atual no         ³±±
±±³          ³ demonstrativo de medias.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER080                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fApdResc(dDtBase)
Local aArea := GetArea()

	dbSelectArea( "SRG" )
	dbSeek( SRA->RA_FILIAL+SRA->RA_MAT )
	While !Eof() .And. SRG->RG_FILIAL+SRG->RG_MAT == SRA->RA_FILIAL+SRA->RA_MAT
		If MesAno(SRG->RG_DTGERAR) == MesAno(dDtBase) .And. SRG->RG_MEDATU == "S"
			dbSelectArea("SRR")
			dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "R" )
			While !Eof() .And. RR_FILIAL + RR_MAT == SRA->RA_FILIAL + SRA->RA_MAT
				If SRR->RR_TIPO3 == "R"
					nPos := Ascan(aPd,{ |X| X[1] = SRR->RR_PD } )
					If nPos = 0
						fMatriz(SRR->RR_PD,SRR->RR_VALOR,SRR->RR_HORAS,"","",SRR->RR_TIPO1,SRR->RR_TIPO2,0,,SRR->RR_DATA)
					Else
						aPd[nPos,5] += SRR->RR_VALOR
					Endif
				EndIf
				dbSkip()
			Enddo
			Exit
		EndIf
		dbSelectArea( "SRG" )
		dbSkip()
	EndDo
	RestArea(aArea)

Return( Nil )

/*/{Protheus.doc}fSalIncMed
Carrega arrays com os salários incorporados para as médias
@author Gabriel de Souza Almeida
@since 08/06/2016
@version P12
/*/
User Function fSalIncMed(aFER, a13, aAP, aFOL, dDataRef, nSalMes, nRazD, nRazH, nSalInc)
	Local cQuery     := ""
	Local cAliasQry  := ""
	Local nSalDia    := 0
	Local nSalHr     := 0
	Local nAux       := 0
	Local aArea      := GetArea()
	Local nAuxMes    := nSalMes
	Local lExist	 := .F.
	Local cPeriodo   := AnoMes(MV_PAR01)
	Local aPeriodo   := {}
	Local lUltSemana := .F.
	Local nPosSem    := 0
	Local lIncCompl  := If ( Type("P_INCCOMPL") == "U",.F.,P_INCCOMPL)
	Local cModFunc	 := If (SRA->RA_REGIME == "2","GFP","GPE")
	Local dDtFimRef	 := CtoD("01/01/" +AllTrim(Str(Year(dDataRef))))
	Local nAvosAf    := 0
	Local lAchou 	 := .F.
	Local cChaveRJK  := ""

	Private cTipoRot := "6"

	DEFAULT nSalInc := nSalMes

	If SRA->RA_CATFUNC $ "A*P"
		fCarPeriodo( cPeriodo , cModFunc, @aPeriodo, @lUltSemana, @nPosSem,,xFilial("RCH",SRA->RA_FILIAL))
	Else
		fCarPeriodo( cPeriodo , fGetCalcRot("1",cModFunc) , @aPeriodo, @lUltSemana, @nPosSem,,xFilial("RCH",SRA->RA_FILIAL))
	EndIf

	If Len(aPeriodo) > 0
		nDiasC := If(aPeriodo[nPosSem,16]=="02" .And. !P_PGSALFEV .And. (!Empty(SRA->RA_SITFOLH) .Or. (Day(SRA->RA_ADMISSA) > 01 .And. (Month(SRA->RA_ADMISSA)==2 .And. Year(SRA->RA_ADMISSA) == Val(aPeriodo[nPosSem,15])))),aPeriodo[nPosSem,18], aPeriodo[nPosSem,20])
	Else
		Return .F.
	EndIf

	aFER := {}
	a13  := {}
	aAP  := {}
	aFOL := {}

	lExist	:= .F.
	lAchou 	:= .F.

	//Férias
	cChaveRJK := SRA->RA_FILIAL+SRA->RA_PROCES+SRA->RA_MAT+cPeriodo+cSemana+"FER"
	If ( lAchou := fBuscaRJK(cChaveRJK, @nSalMes, @nSalHr, @nSalDia, nRazH, nRazD) )
		lExist := .T.
	EndIf
	
	If !lAchou 
		cAliasQry := GetNextAlias()
		cQuery := "SELECT "
		cQuery += "SRR.RR_FILIAL, SRR.RR_MAT, SRR.RR_PD, SRR.RR_VALOR, SRR.RR_PERIODO, SRR.RR_ROTEIR, SRR.RR_VALORBA "
		cQuery += "FROM "
		cQuery += RetSqlName("SRR") + " SRR "
		cQuery += "INNER JOIN " + RetSqlName("SRV") + " SRV ON SRV.RV_FILIAL = '" + xFilial("SRV", SRA->RA_FILIAL) + "' AND SRV.RV_COD = SRR.RR_PD "
		cQuery += "WHERE "
		cQuery += "SRR.RR_FILIAL='" + SRA->RA_FILIAL + "' AND "
		cQuery += "SRR.RR_MAT='" + AllTrim(SRA->RA_MAT) + "' AND "
		cQuery += "SRR.RR_PERIODO='" + AnoMes(dDataRef) + "' AND "
		cQuery += "SRR.RR_ROTEIR = '" + fGetCalcRot("4",cModFunc) + "' AND "
		cQuery += "SRV.RV_INCORP = 'S' AND "
		cQuery += "SRR.D_E_L_E_T_=' ' AND "
		cQuery += "SRV.D_E_L_E_T_=' ' "
		cQuery := ChangeQuery(cQuery)

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

		While !((cAliasQry)->(Eof()))
			lExist	:= .T.
			nAux    := (cAliasQry)->RR_VALOR / Round(SRA->RA_HRSDIA * nDiasC,2)
			nSalHr  := nSalMes / nRazH
			nSalMes += (cAliasQry)->RR_VALOR
			nSalDia := nSalMes / nRazD
			nSalHr  += nAux
			(cAliasQry)->(DbSkip())
		EndDo
		
		DbSelectArea(cAliasQry)
		(cAliasQry)->(DbCloseArea())

	EndIf
	If lExist
		aAdd( aFER, {nSalMes, nSalDia, nSalHr})
	EndIf

	lExist	:= .F.
	lAchou 	:= .F.
	nSalMes := nAuxMes

	//Av. Prévio
	cChaveRJK := SRA->RA_FILIAL+SRA->RA_PROCES+SRA->RA_MAT+cPeriodo+cSemana+"RES"
	If ( lAchou := fBuscaRJK(cChaveRJK, @nSalMes, @nSalHr, @nSalDia, nRazH, nRazD) )
		lExist := .T.
	EndIf

	If !lAchou 
		cAliasQry := GetNextAlias()
		cQuery := "SELECT "
		cQuery += "SRR.RR_FILIAL, SRR.RR_MAT, SRR.RR_PD, SRR.RR_VALOR, SRR.RR_PERIODO, SRR.RR_ROTEIR, SRR.RR_VALORBA "
		cQuery += "FROM "
		cQuery += RetSqlName("SRR") + " SRR "
		cQuery += "INNER JOIN " + RetSqlName("SRV") + " SRV ON SRV.RV_FILIAL = '" + xFilial("SRV", SRA->RA_FILIAL) + "' AND SRV.RV_COD = SRR.RR_PD "
		cQuery += "WHERE "
		cQuery += "SRR.RR_FILIAL='" + SRA->RA_FILIAL + "' AND "
		cQuery += "SRR.RR_MAT='" + AllTrim(SRA->RA_MAT) + "' AND "
		cQuery += "SRR.RR_PERIODO='" + AnoMes(dDataRef) + "' AND "
		cQuery += "SRR.RR_ROTEIR = '" + fGetCalcRot("4") + "' AND "
		cQuery += "SRV.RV_INCORP = 'S' AND "
		cQuery += "SRR.D_E_L_E_T_=' ' AND "
		cQuery += "SRV.D_E_L_E_T_=' ' "

		cQuery := ChangeQuery(cQuery)

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

		While !((cAliasQry)->(Eof()))
			lExist	:= .T.
			nAux    := (cAliasQry)->RR_VALOR / Round(SRA->RA_HRSDIA * nDiasC,2)
			nSalHr  := nSalMes / nRazH
			nSalMes += (cAliasQry)->RR_VALOR
			nSalDia := nSalMes / nRazD
			nSalHr  += nAux
			(cAliasQry)->(DbSkip())
		EndDo

		DbSelectArea(cAliasQry)
		(cAliasQry)->(DbCloseArea())
	EndIf
	
	If lExist
		aAdd( aAP, {nSalMes, nSalDia, nSalHr})
	EndIf

	lExist	:= .F.
	lAchou 	:= .F.
	nSalMes := nAuxMes

	//13º
	cChaveRJK := SRA->RA_FILIAL+SRA->RA_PROCES+SRA->RA_MAT+cPeriodo+cSemana+"132"
	If ( lAchou := fBuscaRJK(cChaveRJK, @nSalMes, @nSalHr, @nSalDia, nRazH, nRazD) )
		lExist := .T.
	EndIf

	If !lAchou 
		cAliasQry := GetNextAlias()

		cQuery := "SELECT "
		cQuery += "SRC.RC_FILIAL, SRC.RC_MAT, SRC.RC_PD, SRC.RC_VALOR, SRC.RC_PERIODO, SRC.RC_ROTEIR, SRC.RC_VALORBA "
		cQuery += "FROM "
		cQuery += RetSqlName("SRC") + " SRC "
		cQuery += "INNER JOIN " + RetSqlName("SRV") + " SRV ON SRV.RV_FILIAL = '" + xFilial("SRV", SRA->RA_FILIAL) + "' AND SRV.RV_COD = SRC.RC_PD "
		cQuery += "WHERE "
		cQuery += "SRC.RC_FILIAL='" + SRA->RA_FILIAL + "' AND "
		cQuery += "SRC.RC_MAT='" + AllTrim(SRA->RA_MAT) + "' AND "
		cQuery += "SRC.RC_PERIODO='" + AnoMes(dDataRef) + "' AND "
		If lIncCompl .And. Month(dDataRef) == 12
			cQuery += "( SRC.RC_ROTEIR = '" + fGetCalcRot("5",cModFunc) +"' OR SRC.RC_ROTEIR = '" + fGetCalcRot("6",cModFunc) + "' OR (SRC.RC_ROTEIR = '"+fGetCalcRot("1",cModFunc)+"' AND SRC.RC_TIPO2 = 'I') ) AND "
		Else
			cQuery += "(SRC.RC_ROTEIR = '" + fGetCalcRot("6",cModFunc) +"') AND "
		EndIf
		cQuery += "SRV.RV_INCORP = 'S' AND "
		cQuery += "SRC.D_E_L_E_T_=' ' AND "
		cQuery += "SRV.D_E_L_E_T_=' ' "

		cQuery += "UNION "

		cQuery += "SELECT "
		cQuery += "SRD.RD_FILIAL, SRD.RD_MAT, SRD.RD_PD, SRD.RD_VALOR, SRD.RD_PERIODO, SRD.RD_ROTEIR, SRD.RD_VALORBA "
		cQuery += "FROM "
		cQuery += RetSqlName("SRD") + " SRD "
		cQuery += "INNER JOIN " + RetSqlName("SRV") + " SRV ON SRV.RV_FILIAL = '" + xFilial("SRV", SRA->RA_FILIAL) + "' AND SRV.RV_COD = SRD.RD_PD "
		cQuery += "WHERE "
		cQuery += "SRD.RD_FILIAL='" + SRA->RA_FILIAL + "' AND "
		cQuery += "SRD.RD_MAT='" + AllTrim(SRA->RA_MAT) + "' AND "
		cQuery += "(SRD.RD_PERIODO='" + AnoMes(dDataRef) + "' AND " + "SRD.RD_PERIODO>='" + AnoMes(dDtFimRef) + "') AND"
		cQuery += "(SRD.RD_ROTEIR = '" + fGetCalcRot("6",cModFunc) + "') AND "
		cQuery += "SRV.RV_INCORP = 'S' AND "
		cQuery += "SRD.D_E_L_E_T_=' ' AND "
		cQuery += "SRV.D_E_L_E_T_=' ' "

		cQuery := ChangeQuery(cQuery)

		fRetAfas( Max( SRA->RA_ADMISSA, dDtFimRef ),CToD("31/12/" + SUBSTR(cPeriodo,1,4)),"13",@nAvosAf )

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

		While !((cAliasQry)->(Eof()))
			lExist	:= .T.
			nAux    := (cAliasQry)->RC_VALOR/ Round(SRA->RA_HRSDIA * nDiasC,2)
			nSalHr  := nSalMes / nRazH

			If nAvosAf > 0
				nSalMes += ( (cAliasQry)->RC_VALOR / (12 - nAvosAf) ) * 12
			Else
				nSalMes += (cAliasQry)->RC_VALOR
			EndIf

			nSalDia := nSalMes / nRazD
			nSalHr  += nAux
			(cAliasQry)->(DbSkip())
		EndDo

		DbSelectArea(cAliasQry)
		(cAliasQry)->(DbCloseArea())
	EndIf
	
	If lExist
		aAdd( a13, {nSalMes, nSalDia, nSalHr})
	EndIf

	lExist	:= .F.
	lAchou 	:= .F.
	nSalMes := nAuxMes

	//Licença Matern.
	cChaveRJK := SRA->RA_FILIAL+SRA->RA_PROCES+SRA->RA_MAT+cPeriodo+cSemana+"FOL"
	If ( lAchou := fBuscaRJK(cChaveRJK, @nSalMes, @nSalHr, @nSalDia, nRazH, nRazD) )
		lExist := .T.
	EndIf

	If !lAchou 
		cAliasQry := GetNextAlias()

		cQuery := "SELECT "
		cQuery += "SRC.RC_FILIAL, SRC.RC_MAT, SRC.RC_PD, SRC.RC_VALOR, SRC.RC_PERIODO, SRC.RC_ROTEIR, SRC.RC_VALORBA "
		cQuery += "FROM "
		cQuery += RetSqlName("SRC") + " SRC "
		cQuery += "INNER JOIN " + RetSqlName("SRV") + " SRV ON SRV.RV_FILIAL = '" + xFilial("SRV", SRA->RA_FILIAL) + "' AND SRV.RV_COD = SRC.RC_PD "
		cQuery += "WHERE "
		cQuery += "SRC.RC_FILIAL='" + SRA->RA_FILIAL + "' AND "
		cQuery += "SRC.RC_MAT='" + AllTrim(SRA->RA_MAT) + "' AND "
		cQuery += "SRC.RC_PERIODO='" + AnoMes(dDataRef) + "' AND "
		cQuery += "SRC.RC_ROTEIR = '" + fGetCalcRot("1",cModFunc) + "' AND "
		cQuery += "SRV.RV_INCORP = 'S' AND SRV.RV_REFFER <> 'S' AND "
		cQuery += "SRC.D_E_L_E_T_=' ' AND "
		cQuery += "SRV.D_E_L_E_T_=' ' "

		cQuery += "UNION "

		cQuery += "SELECT "
		cQuery += "SRD.RD_FILIAL, SRD.RD_MAT, SRD.RD_PD, SRD.RD_VALOR, SRD.RD_PERIODO, SRD.RD_ROTEIR, SRD.RD_VALORBA "
		cQuery += "FROM "
		cQuery += RetSqlName("SRD") + " SRD "
		cQuery += "INNER JOIN " + RetSqlName("SRV") + " SRV ON SRV.RV_FILIAL = '" + xFilial("SRV", SRA->RA_FILIAL) + "' AND SRV.RV_COD = SRD.RD_PD "
		cQuery += "WHERE "
		cQuery += "SRD.RD_FILIAL='" + SRA->RA_FILIAL + "' AND "
		cQuery += "SRD.RD_MAT='" + AllTrim(SRA->RA_MAT) + "' AND "
		cQuery += "SRD.RD_PERIODO='" + AnoMes(dDataRef) + "' AND "
		cQuery += "(SRD.RD_ROTEIR = '" + fGetCalcRot("6",cModFunc) + "') AND "
		cQuery += "SRV.RV_INCORP = 'S' AND SRV.RV_REFFER <> 'S' AND "
		cQuery += "SRD.D_E_L_E_T_=' ' AND "
		cQuery += "SRV.D_E_L_E_T_=' ' "

		cQuery := ChangeQuery(cQuery)

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

		While !((cAliasQry)->(Eof()))
			lExist	:= .T.
			nAux    := (cAliasQry)->RC_VALOR / Round(SRA->RA_HRSDIA * nDiasC,2)
			nSalHr  := nSalMes / nRazH
			nSalMes += (cAliasQry)->RC_VALOR
			nSalDia := nSalMes / nRazD
			nSalHr  += nAux
			(cAliasQry)->(DbSkip())
		EndDo

		DbSelectArea(cAliasQry)
		(cAliasQry)->(DbCloseArea())

	EndIf
	
	If lExist
		aAdd( aFOL, {nSalMes, nSalDia, nSalHr})
	EndIf

	RestArea(aArea)
Return .T.


/*/{Protheus.doc} fVerHistMed
/Chamada relatorio de medias novo
@author flavio.scorrea
@since 23/10/2019
/*/
User Function fVerHistMed(cTipo, dDtref, lTemTransf, lGPEM690, cPerIni, cPerFim, lGPER080, aRetClone)

Local aOrd		:= {}               			//Ordem do Relatorio

Local cDesc1	:= OemToAnsi(STR0001)			//"Demonstrativo de M‚dias"
Local cDesc2	:= OemToAnsi(STR0002)			//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3	:= OemToAnsi(STR0003)			//"usu rio."
Local cString	:= "SRA"						//alias do arquivo principal (Base)
Local cMens   	:= ""
Local nSvRecno	:= SRA->( Recno() )			//Salva posicao do SRA para Restaurar apos SetPrint()
Local lImpPgto 	:= .F.
Local lImpParam	:= .F.

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define Variaveis Private(Basicas)							  ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private cPerg	 	:=  ""
Private aReturn		:= {OemToAnsi(STR0007), 1,OemToAnsi(STR0008), 2, 2, 1, "",1 }	//"Zebrado"###"Administra‡„o"
Private nomeprog	:= "fVerHistMed"
Private aLinha		:= {}
Private nLastKey	:= 0

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define Variaveis Private(Programa)						 ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private aInfo	:=	{}
Private aFolBas[4] , aAdiBas[4] , aFerBas[4] , a13Bas[4]
Private aFolIR[4]  , aAdiIR[4]	, aFerIR[4]  , a13IR[4]

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis Utilizadas na funcao IMPR 					   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private TITULO		:= OemToAnsi(STR0010)	//"DEMONSTRATIVO DE MEDIAS"
Private AT_PRG		:= nomeprog
Private wCabec0		:= 1
Private wCabec1		:= ""
Private CONTFL		:= 1
Private LI			:= 0
Private nTamanho	:= "M"

Default lTemTransf	:= .F.
Default lGPEM690	:= .F.
Default cPerIni		:= ""
Default cPerFim		:= ""
Default lGPER080	:= .F.
Default aRetClone	:= {}

wCabec1	:= Iif( !lGPEM690 .And. !lGPER080, STR0009 + DtoC(dDtref), "")//Adiciona a Data de Referencia ao Cabecalho do Relatorio	//"DATA BASE: "

cMens := OemToAnsi(STR0067)+chr(13) //"Deseja imprimir a linha de médias de"
cMens += OemToAnsi(STR0068)+chr(13) //"pagamento?"

If !lGPER080
    lImpPgto := MsgYesNo(cMens,STR0069)//"Atenção"

    lImpParam := MsgYesNo(OemToAnsi(STR0066),STR0069)//"Deseja imprimir a página de parâmetros?"##"Atenção"

    /*
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ Envia controle para a funcao SETPRINT						   ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
    wnrel := "DEM_MED" //Nome DEFAULT do relatorio em Disco
    wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho,,.F.)
Else
    aReturn     := aClone(aRetClone)
    lImpPgto    := Iif( MV_PAR14 == 2, .F., .T. )
EndIf

SRA->( dbGoto( nSvRecno ) )

Begin Sequence

	If ( nLastKey == 27 )
		Break
	EndIf

	If !lGPER080
        SetDEFAULT(aReturn, cString)

	    RptStatus( { |lEnd| fImpMedN( @lEnd, wnRel, cString, cTipo, lImpPgto, lImpParam, lTemTransf, lGPEM690, cPerIni, cPerFim ) }, TITULO )
    Else
        fImpMedN( Nil, wnRel, cString, cTipo, lImpPgto, lImpParam, lTemTransf, lGPEM690, cPerIni, cPerFim, lGPER080 )
    EndIf

End Sequence

Return( Nil )

/*/{Protheus.doc} fImpMedN
/Chamada relatorio de medias novo
@author flavio.scorrea
@since 23/10/2019
/*/
Static Function fImpMedN( lEnd, WnRel, cString, cTipo, lImpPgto, lImpParam, lTemTransf, lGPEM690, cPerIni, cPerFim, lGPER080 )

Local lContinua		:= .T.

Default lTemTransf 	:= .F.
Default lGPEM690 	:= .F.
Default cPerIni 	:= ""
Default cPerFim 	:= ""
Default lGPER080 	:= .F.

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Imprime Demonstrativo	U_fImpr_Med() em GPER080.PRX		      ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If ExistBlock("GPM04MED") // Ponto para chamada de funcao especifica para impressao
	Execblock("GPM04MED",.F.,.F.)
Else
	While lContinua
		If lGPER080
            wCabec1	:= STR0009 + dToC( RJK->RJK_DTREF )//Adiciona a Data de Referencia ao Cabecalho do Relatorio	//"DATA BASE: "
        End
        U_fImpr_MedN(cTipo, lImpPgto, lImpParam, lTemTransf, lGPER080)
		dbSelectArea( cTBLXMED )
		ZAP		
		If !lGPEM690 .And. !lGPER080
			Exit
		Else
			lContinua := fVerRJK( cPerFim, lGPEM690, lGPER080 )
		EndIf
	End
EndIf

If !lGPER080
    Set Device To Screen

    If aReturn[5] = 1
        Set Printer To
        Commit
        Ourspool(wnrel)
    EndIf

    MS_FLUSH()
EndIf

Return( Nil )

/*/{Protheus.doc} fImpr_MedN
/Chamada relatorio de medias novo
@author flavio.scorrea
@since 23/10/2019
/*/
User Function fImpr_MedN(cTipoMov, lImpPgto, lImpParam, lTemTransf, lGPER080)

Local aAreaSRD		:= SRD->( GetArea() )
Local aTipoRel 		:= {STR0011,STR0012,STR0013,STR0014, STR0043 }		//"F‚rias Vencidas"###"F‚rias a Vencer"###"13o Sal rio"###"Aviso Pr‚vio"###"Lic.Maternidade"
Local nTipo    		:= 0
Local cTipo     	:= "0", cPd := "000"
Local cTitulo    	:= "",aTipMed,cTipoRel
Local cPropVerba 	:= ""
Local dDtBasVen  	:= RJK->RJK_BASFER
Local dDPagSRC  	:= cToD("//")
Local lDsrHE		:= .F.
Local nCnt
Local nCont			:= 0
Local nIndMes	 	:= 1
Local cDataarq	 	:= ""
Local cTpAux        := ""
Local aParam		:= {}
Local nI			:= 1
Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F. }) //[2]Ofuscamento
Local aFldRel		:= If(aOfusca[2], FwProtectedDataUtil():UsrNoAccessFieldsInList( {"RA_NOME","RA_NUMCP","RA_SERCP"} ), {})
Local lOfuscaNom	:= .F.
Local lOfuscaNcp	:= .F.
Local lOfuscaScp	:= .F.
Local lMudaBasVen	:= .F.
Local cFilMat		:= SRA->RA_FILIAL+SRA->RA_MAT

Private A1COLUNA 	:= {}
Private A2COLUNA 	:= {}
Private	LI    		:= 0
Private nMes        := nDia := nHor := 0

DEFAULT cTipoMov	:= " "
DEFAULT lImpPgto	:= .F.
DEFAULT lImpParam	:= .F.
DEFAULT lTemTransf	:= .F.
DEFAULT lGPER080	:= .F.
DEFAULT lTemRJKTP   := RJK->(ColumnPos( "RJK_TIPO" )) > 0

	SRD->( dbSetOrder(4) )//RD_FILIAL+RD_MAT+DTOS(RD_DATPGT)+RD_PD+RD_SEMANA+RD_SEQ+RD_CC
	
	If lTemTransf
		cFilMat	:= RJK->RJK_FILIAL+RJK->RJK_MAT
	EndIf
	
	If aOfusca[2] .And. Len(aFldRel) > 0
		lOfuscaNom := aScan( aFldRel, {|x| x:cfield == "RA_NOME" }) > 0
		lOfuscaNcp := aScan( aFldRel, {|x| x:cfield == "RA_NUMCP"}) > 0
		lOfuscaScp := aScan( aFldRel, {|x| x:cfield == "RA_SERCP"}) > 0
	EndIf

	nMes := RJK->RJK_SALBAS
	nDia := RJK->RJK_SALDIA
	nHor := RJK->RJK_SALHOR

	// Ponto para alterar variaveis do de salario do cabecalho
	If ExistBlock("GP080ALT")
		Execblock("GP080ALT",.F.,.F.)
	EndIf

	cColuna := "A1COLUNA"
	fGetHMed(RJK->RJK_ID, lTemTransf, cTipoMov)

	If lTemRJKTP
		cTpAux := RJK->RJK_TIPO 
	EndIf

	dbSelectArea( cTBLXMED )

	If lImpParam .And. !Empty(RJK->RJK_MNEMO1)
		aParam := separa(RJK->RJK_MNEMO1,chr(10)+chr(13))
		For nI := 1 To Len(aParam)
			IMPR(aParam[nI])
		Next nI
	EndIf

	// Tipos de Medias a Imprimir:
	// 1-Ferias Vencidas 1o Periodo
	// 2-Ferias a Vencer
	// 3-13o Salario
	// 4-Aviso Previo
	// 5 a 9-Ferias Vencidas Periodos 2o,3o,4o...
	// A-Licenca Maternidade
	If cTipoMov == "F"
		aTipMed    := { "1","5","6","7","8","9","2"}
	Else
		aTipMed    := { "1","5","6","7","8","9","2","3","4","A" }
	EndIf
	For nCnt := 1 To Len(aTipMed)
		If !dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + aTipMed[nCnt] )
			If lTemTransf
				If !dbSeek( cFilMat + aTipMed[nCnt] )
					Loop
				Endif
			Else
				Loop
			EndIf
		EndIf

        If lGPER080
            If !( ( aTipMed[nCnt] == "3" .And. lImp13o ) .Or. ( aTipMed[nCnt] $ "1/2/5/6/7/8/9" .And. lImpFer ) )
                Loop
            EndIf
        EndIf

		If !Empty(cTpAux)
			fTrocaRJK(aTipMed[nCnt], cTpAux)
		EndIf

		If Len(A1COLUNA) # 0
			U_DESCARREGA()
			cColuna := "A1COLUNA"
			IMPR(" ","C")
		EndIf

		cTipo := (cTBLXMED)->RP_TIPO
		LI    := 0
		cDataarq := ""
		While !Eof() .And. cFilMat+cTipo = (cTBLXMED)->RP_FILIAL+(cTBLXMED)->RP_MAT+(cTBLXMED)->RP_TIPO
			If !Empty(cDataarq) .and. cDataarq > (cTBLXMED)->RP_DATARQ .And. (cPd <> "998" .And. cPd <> "997")
				U_FTrocaColuna()
			EndIf
			//Exibe a media de acordo com a configuracao da verba - Peru
			If cPaisLoc == "PER"
				cPropVerba := PosSRV( (cTBLXMED)->RP_PD, SRA->RA_FILIAL, "RV_REMCOMP" )
		    	If cPropVerba $ "1|2|3"
					nIndMes	:= 2
	 			Else
					nIndMes	:= 1
	    		EndIf
			EndIf
			dDPagSRC  	:= cToD("//")
			nCont++
			lMudaBasVen := .F.
			// Inicio da Impressao Das Linhas Detalhes
			If LI = 0
		  		nTipo    := If( cTipo=="A",5,If( cTipo>"4",1,Val(cTipo)))
				cTipoRel := aTipoRel[nTipo]+If( nTipo==1, "("+Str(nCnt,1)+")", "" )
				TITULO := STR0015+cTipoRel+ " ***"		//"*** DEMONSTRATIVO DE MEDIA DE HORAS EXTRAS E ADICIONAIS PARA "
				IMPR(" "+REPL("_",130),"C")
				DET := "| " + OemToAnsi(STR0045) + " " + SRA->RA_FILIAL + " - " + FWFilialName(, SRA->RA_FILIAL,1)
				DET := AllTrim(DET)+SPACE(131-Len(AllTrim(DET)))+"|"
				IMPR(DET,"C")
				DET := PADR(STR0016, 19)+If(lOfuscaNom, Replicate('*',30), Left(SRA->RA_NOME,30))+SPACE(2)+STR0017+If(lOfuscaNcp, Replicate('*',7), SRA->RA_NUMCP)+" - "+If(lOfuscaScp, Replicate('*',5), SRA->RA_SERCP)+SPACE(2)+PADR(STR0018, 10) //"| Funcionario....: "###"Cart.Trab.:"###"Registro: "
				DET += SRA->RA_MAT+SPACE(2)+STR0019				//"Admissao:"
				DET += PADR(DTOC(SRA->RA_ADMISSA),10)
				DET := AllTrim(DET)+SPACE(131-Len(AllTrim(DET)))+"|"
				IMPR(DET,"C")
				DET := "| " + STR0020+Subs(RJK->RJK_CC+Space(20),1,20)+" - "+DescCC(RJK->RJK_CC,SRA->RA_FILIAL,40)+Space(1)		//"| Centro de Custo: "
				DET += STR0021+RJK->RJK_CODFUN + " - " + DescFun(RJK->RJK_CODFUN,SRA->RA_FILIAL,30) //"Funcao....: "
				DET := AllTrim(DET)+SPACE(131-Len(AllTrim(DET)))+"|"
				IMPR(DET,"C")

				If nTipo == 2 .and. nCont == 1 .and. Type("aPerFerias") == "A" .and. Len(aPerFerias) > 1//Verifica se existe período aquisitivo anterior quitado ou sem médias para pagar
					If aPerFerias[1][1] == dDtBasVen .and. aPerFerias[1][3] > 0 .and. aPerFerias[1][4] == 0 //Se período estiver vencido, e nTipo == 2, indica que não houve pagamento de médias, altera data para o período proporcional
						lMudaBasVen := .T.
					EndIf
				EndIf

				//salarios
				DET := "| "+IF(nTipo<3,STR0022+Iif(nTipo==2 .And. ( nCont > 1 .or. lMudaBasVen ), dToC(fBasFerAVen(@dDtBasVen)), dToC(RJK->RJK_BASFER)),SPACE(19))+SPACE(09)//"Base Fer:"
				DET += PADR(STR0044, 21) + TRANSFORM(nMes,"@E 999,999,999.99") + SPACE(5) + STR0053  + TRANSFORM(RJK->RJK_SALINC,"@E 999,999,999.99")	//"| Salario Base...: "###"Salario Incorp..:"
				DET := AllTrim(DET) + SPACE(131-Len(AllTrim(DET))) + "|"
				IMPR(DET,"C")

				DET := "| " + STR0054 + SPACE(2) + TRANSFORM(nDia,"@E 999,999,999.99") + Space(5) + STR0055 + TRANSFORM(nHor,"@E 999,999,999.99") 	//"  "Sal Dia.....: " #"Sal Hora.....:"
				DET := AllTrim(DET) + SPACE(131-Len(AllTrim(DET))) + "|"
				IMPR(DET,"C")

				DET := "| " + STR0056 + SPACE(2) + TRANSFORM(RJK->RJK_PERIC,"@E 999,999,999.99")  + Space(5) + STR0057 + TRANSFORM(RJK->RJK_INSAL,"@E 999,999,999.99") + Space(5) + STR0058 + TRANSFORM(RJK->RJK_CONF,"@E 999,999,999.99") // "Peric.......: "#"Insal........:"##"Conf............:"
				DET := AllTrim(DET) + SPACE(131-Len(AllTrim(DET))) + "|"
				IMPR(DET,"C")

				DET := "| " + STR0059 + SPACE(2) + TRANSFORM(RJK->RJK_TRANSF,"@E 999,999,999.99") + Space(5) + STR0060 + TRANSFORM(RJK->RJK_ATS,"@E 999,999,999.99") // "Trans.......: "##"ATS..........:"
				DET := AllTrim(DET) + SPACE(131-Len(AllTrim(DET))) + "|"
				IMPR(DET,"C")

				IMPR("|"+REPL("_",130)+"|","C")
			Endif

			If (cTBLXMED)->RP_PD # cPd
				If cPd = "998" .Or. cPd = "997"
					U_FTrocaColuna()
				EndIf

				nTipo    := If( cTipo=="A",5,If( cTipo>"4",1,Val(cTipo)))
				cTipoRel := aTipoRel[nTipo]+If( nTipo==1, "("+Str(nCnt,1)+")", "" )
				cTitulo  := If((cTBLXMED)->RP_PD="999",STR0027+cTipoRel,If((cTBLXMED)->RP_PD="998",STR0028+cTipoRel,;					//"TOTAIS - "###"TOTAL FALTAS - "
						        If((cTBLXMED)->RP_PD="997",STR0029+cTipoRel,If((cTBLXMED)->RP_PD="995", STR0046+cTipoRel, (cTBLXMED)->RP_PD+" - "+DescPd((cTBLXMED)->RP_PD,SRA->RA_FILIAL,20)))))	//"TOTAL ADTO. -  " ### //"TOTAL GRUPO 0. -  "
				DET := SPACE(12)+"*** "+ cTitulo + " ***" + SPACE(42-Len(cTitulo))
				AADD(&(cColuna),DET)
				If (cTBLXMED)->RP_PD = "998"
					DET := SPACE(21)+STR0030+SPACE(37)		//"DIAS"
				ElseIf (cTBLXMED)->RP_PD = "997"
					DET := SPACE(57)+STR0031					//"VALOR"
				Else
					DET := STR0032		//"REF.    DATA PGT     HORAS      VALOR ORIG.        VALOR ATUAL"
				EndIf
				AADD(&(cColuna),DET)
				DET := REPL("_",62)
				AADD(&(cColuna),DET)
				cPd := (cTBLXMED)->RP_PD

			EndIf

			// | REF.    DATA PGT     HORAS      VALOR ORIG.        VALOR ATUAL |
			// | 99/9999 99/99/9999 9999.99   999.999.999.99   9.999.999.999.99 |
			// | ** TOTAL           9999,99           500,00             500,00 |
			// | ** MEDIA     (12)  9999,99            41,67              41,67 |
			// | ** MEDIA PGTO(12)  9999,99            41,67              41,67 |
			// | * TOT OUTROS       9999,99         2.480,90           2.480,90 |
			// | * MED OUTROS       9999,99           206,75             206,75 |
			// | * OUTROS PGTO      9999,99           206,75             206,75 |
			// | * TOT H.EXT        9999,99             0,00               0,00 |
			// | * MED H.EXT        9999,99             0,00               0,00 |
			// | * H.EXT PGTO       9999,99             0,00               0,00 |
			// | ** TOTAL           9999,99         2.480,90           2.480,90 |
			// | ** MEDIA           9999,99           206,75             206,75 |
			// | ** MEDIA PGTO      9999,99           206,75             206,75 |
			// | NO PERIODO         9999,99

			If (cTBLXMED)->RP_DATARQ = "9798  "
				DET := STR0033
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;		//"* TOT OUTROS"
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9799  "
				DET := STR0034
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD=="999","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* MED OUTROS  "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "97MD  "
				DET := STR0035
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI/nIndMes,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* OUTROS PGTO "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9898  "
				DET := STR0036
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* TOT H.EXT "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9899  "
				DET := STR0037
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* MED H.EXT   "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "98MD  "
				DET := STR0038
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* H.EXT PGTO  "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9598  "
				DET := STR0047
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;		//"* TOT GRUPO 0"
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9599  "
				DET := STR0048
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD=="995","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* MED GRUPO 0  "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "95MD  "
				DET := STR0049
				DET += SPACE(19-Len(DET))+If((cTBLXMED)->RP_PD == "995","","("+StrZero((cTBLXMED)->RP_MESMEDI/nIndMes,2)+") ")+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* GRUPO 0 PGTO "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
				U_FTrocaColuna()
			ElseIf (cTBLXMED)->RP_DATARQ = "9998  "
				DET := Iif((cTBLXMED)->RP_PD == "998", STR0070, STR0039)//"** AVOS DEDUZIDOS"##"** TOTAL      "
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "9999  "
				DET := STR0040+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI,2)+") ")
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"** MEDIA     "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_DATARQ = "99MD  "
				If lImpPgto
					DET := STR0041+If((cTBLXMED)->RP_PD == "999","","("+StrZero((cTBLXMED)->RP_MESMEDI/nIndMes,2)+") ")
					DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM(Round((cTBLXMED)->RP_VALOR,2),"@E 999,999,999.99")+;	//"** MEDIA PGTO"
					SPACE(3)+TRANSFORM(Round((cTBLXMED)->RP_VALATU,2),"@E 9,999,999,999.99")
					AADD(&(cColuna),DET)
				EndIf

			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "ZZ01"
				DET := STR0061 //"*** TOT INSALUB"
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"*** TOT INSALUB"
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "ZZ02"
				DET := STR0062//"*** TOT PERICUL"
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"*** TOT PERICUL"
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "ZZ03"
				DET := STR0063//"*** TOT DSR "
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"*** TOT DSR "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "ZZ04"
				DET := STR0064//"*** TOT DSRHATIV "
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"*** TOT DSRHATIV "
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf Alltrim((cTBLXMED)->RP_DATARQ) == "8891"
				DET := STR0065//"* BASE MEDIA ATS"
				DET += SPACE(19-Len(DET))+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;	//"* BASE MEDIA ATS"
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			ElseIf (cTBLXMED)->RP_PD = "998"
				If (cTBLXMED)->RP_TIPO="3" .and. !(cTBLXMED)->RP_DATARQ = "9698"
					If Empty((cTBLXMED)->RP_DATPGT)
						DET := RIGHT((cTBLXMED)->RP_DATARQ,2)+"/"
						DET += PADR(IF(nTData==8,SubStr((cTBLXMED)->RP_DATARQ,3,2),Left((cTBLXMED)->RP_DATARQ,4)),7)
					Else
						DET := SubStr(dToS((cTBLXMED)->RP_DATPGT), 5, 2)+"/"
						DET += SubStr(dToS((cTBLXMED)->RP_DATPGT), 1, 4) + Space(3)
					EndIf
				Else
					DET := STR0042		//"NO PERIODO"
				Endif
				DET += SPACE(10)+TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(35)
				AADD(&(cColuna),DET)

			ElseIf (cTBLXMED)->RP_PD = "997"
				DET := SPACE(46)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			Else
				lDsrHE	:= ( RetValSRV( (cTBLXMED)->RP_PD, SRA->RA_FILIAL, "RV_CODFOL")  == "0035" )
				DET := PADR( Iif( RIGHT( (cTBLXMED)->RP_DATARQ, 2 ) == SPACE(2) .Or. Empty( (cTBLXMED)->RP_DATPGT ) .Or. lDsrHE, fBuscaDtMed(@dDPagSRC), RIGHT( (cTBLXMED)->RP_DATARQ, 2 ) ) +"/"+Iif( nTData == 8 ,SubStr( (cTBLXMED)->RP_DATARQ, 3, 2 ), Left( (cTBLXMED)->RP_DATARQ, 4 ) ), 8 )
				DET += PADR( Iif( !Empty( (cTBLXMED)->RP_DATPGT ) .And. !lDsrHE, DTOC( (cTBLXMED)->RP_DATPGT ), DTOC( dDPagSRC ) ), 10 )+SPACE(1)+;
					TRANSFORM((cTBLXMED)->RP_HORAS,"@E 9999.99")+SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALOR,"@E 999,999,999.99")+;
					SPACE(3)+TRANSFORM((cTBLXMED)->RP_VALATU,"@E 9,999,999,999.99")
				AADD(&(cColuna),DET)
			Endif
			dbSelectArea( cTBLXMED )
			cDataarq := (cTBLXMED)->RP_DATARQ
			dbSkip()
		EndDo
	Next nCnt

	If Len(A1COLUNA) # 0
		U_DESCARREGA()
		Li := 0
	EndIf

RestArea( aAreaSRD )

Return( Nil )


/*/{Protheus.doc}fBuscaDtMed
Caso o campo RP_DATARQ n?o contenha o m?s de referencia faz a busca na SRD
@author Fernando Luis Guilherme
@since 04/08/2020
@version P12
/*/

Static Function fBuscaDtMed( dDtSRC )

Local cTempQry  := ""
Local cMes      := ""
Local cFilSRD   := xFilial("SRD")
Local cMatSRD   := SRA->RA_MAT
Local cFilMatIN := ""
Local dDataMed  := DTOS((cTBLXMED)->RP_DATPGT)
Local cPd       := (cTBLXMED)->RP_PD
Local nCont 	:= 0

Static cFilMatT
Static aTrfSRD	:= {}

DEFAULT dDtSRC		:= cToD("//")
DEFAULT cFilMatT 	:= ""

If SRD->( dbSeek( cFilSRD + cMatSRD + dDataMed + cPd ) )
	cMes  	:= SRD->RD_MES
	dDtSRC 	:= (cTBLXMED)->RP_DATPGT
Else
	If cFilSRD + cMatSRD <> cFilMatT
		fTransfAll(@aTrfSRD)
		cFilMatT := cFilSRD + cMatSRD
	EndIf

	cFilMatIN := "(SRD.RD_FILIAL = '" + cFilSRD + "' AND SRD.RD_MAT = '" + cMatSRD + "')" 

	If Len(aTrfSRD) > 0
		For nCont := 1 To Len(aTrfSRD)
			If AnoMes(aTrfSRD[nCont, 7]) >= SubStr(dDataMed,1,6)
				cFilMatIN += " OR (SRD.RD_FILIAL = '" + aTrfSRD[nCont,8] + "' AND SRD.RD_MAT = '" + aTrfSRD[nCont,9] + "')" 
			EndIf
		Next nCont
	EndIf

	cFilMatIN := "%(" + cFilMatIN + ")%"

	cTempQry := GetNextAlias()

	BeginSql alias cTempQry

		SELECT  SRD.RD_MES 
		FROM   %table:SRD% SRD 
		WHERE  %exp:cFilMatIN%
		AND SRD.RD_DATPGT = %exp:dDataMed%
		AND SRD.RD_PD = %exp:cPd%
		AND SRD.D_E_L_E_T_=' '

	EndSql

	If (cTempQry)->(!EOF())
		cMes  	:= (cTempQry)->RD_MES
		dDtSRC 	:= (cTBLXMED)->RP_DATPGT
	Endif
EndIf

If(Empty(cMes) .and. !RIGHT( (cTBLXMED)->RP_DATARQ, 2 ) == SPACE(2) .and. Type("cPeriodo") == "U")
	cPeriodo := (cTBLXMED)->RP_DATARQ
EndIf

If Empty(cMes) .and. ( RIGHT( (cTBLXMED)->RP_DATARQ, 2 ) == SPACE(2) .or. (cTBLXMED)->RP_DATARQ < cPeriodo )
	(cTempQry)->(DbCloseArea())
	BeginSql alias cTempQry

		SELECT  SRC.RC_PERIODO, SRC.RC_DATA
		FROM   %table:SRC% SRC
		WHERE  SRC.RC_FILIAL= %exp:cFilSRD%
		AND SRC.RC_MAT = %exp:cMatSRD%
		AND SRC.RC_PD = %exp:cPd%
		AND SRC.D_E_L_E_T_=' '

	EndSql

	If (cTempQry)->(!EOF())
		cMes 	:= Right( (cTempQry)->RC_PERIODO, 2 )
		dDtSRC	:= sToD( (cTempQry)->RC_DATA )
	Endif
EndIf

If Empty(cMes)
	dDtSRC 	:= StoD(cPeriodo+"01" )
	cMes 	:= Right( cPeriodo, 2 )
EndIf

If !Empty( cTempQry ) .And. Select( cTempQry ) > 0
	(cTempQry)->(DbCloseArea())
EndIf

Return cMes

/*/{Protheus.doc} fBasFerAVen
/Busca data base de férias a vencer
@author Allyson Mesashi
@since 30/07/2021
/*/
Static Function fBasFerAVen(dDtBasVen)

dDtBasVen := fCalcFimAq(dDtBasVen)+1

Return dDtBasVen

/*/{Protheus.doc} fBuscaRJK
/Busca Salário na RJK
@author Emerson Grassi Rocha
@since 22/09/2022
/*/
Static Function fBuscaRJK(cChave, nSalMes, nSalHr, nSalDia, nRazH, nRazD)
Local aArea  := GetArea()
Local lAchou := .F.

dbSelectArea("RJK")
RJK->(dbSetOrder(1))//RJK_FILIAL+RJK_PROCES+RJK_MAT+RJK_PERIOD+RJK_SEMANA+RJK_ROTEIR+DTOS(RJK_DTREF)+RJK_DISSI
If lAchou := RJK->(dbSeek(cChave))
	nSalMes := IF(RJK_SALINC > RJK_SALBAS, (RJK_SALBAS + RJK_INSAL + RJK_ATS + RJK_PERIC + RJK_CONF + RJK_TRANSF), RJK_SALBAS)
	nSalHr  := nSalMes / nRazH
	nSalDia := nSalMes / nRazD
EndIf

RestArea(aArea)
Return lAchou

/*/{Protheus.doc} fVerRJK
Verifica se há outros históricos de médias a serem impressos na consulta de cálculo do Dissídio
@author Allyson Luiz Mesashi
@since 16/01/2023
/*/
Static Function fVerRJK( cPerFim, lGPEM690, lGPER080 )

Local lAchou 		:= .F.

DEFAULT cRot132     := fGetCalcRot("6")
DEFAULT cRotFER     := fGetCalcRot("3")
DEFAULT cRotVerDiss	:= cRot132+"/"+cRotFER

RJK->( dbSkip() )

While RJK->( !EoF() ) .And. RJK->RJK_FILIAL+RJK->RJK_PROCES+RJK->RJK_MAT == SRA->RA_FILIAL+SRA->RA_PROCES+SRA->RA_MAT
	If RJK->RJK_PERIOD <= cPerFim .And. ( ( lGPEM690 .And. RJK->RJK_DISSI == "1" .And. RJK->RJK_ROTEIR $ cRotVerDiss ) .Or. ( lGPER080 .And. RJK->RJK_DISSI == "2" .And. ( ( lImpFer .And. RJK->RJK_ROTEIR == cRotFER ) .Or. ( lImp13o .And. RJK->RJK_ROTEIR == cRot132 ) ) ) )
		lAchou := .T.
		Exit
	EndIf
	RJK->( dbSkip() )
End

Return lAchou

/*/{Protheus.doc} fTemHist
Verifica se há históricos de médias a serem impressos
@author Allyson Luiz Mesashi
@since 06/04/2023
/*/
Static Function fTemHist()

Local lTemHist  := .F.

If RJK->( dbSeek( SRA->RA_FILIAL+SRA->RA_PROCES+SRA->RA_MAT+cAnoMes )  )
    While RJK->( !EoF() ) .And. RJK->RJK_FILIAL+RJK->RJK_PROCES+RJK->RJK_MAT+RJK->RJK_PERIOD == SRA->RA_FILIAL+SRA->RA_PROCES+SRA->RA_MAT+cAnoMes
        If ( ( lImpFer .And. RJK->RJK_ROTEIR == cRotFER ) .Or. ( lImp13o .And. (RJK->RJK_ROTEIR == cRot132 .Or. RJK->RJK_ROTEIR == cRot131)) ) .And. RJK->RJK_DISSI == "2"
            lTemHist := .T.
            Exit
        EndIf
        RJK->( dbSkip() )
    End
EndIf

Return lTemHist

/*/{Protheus.doc} fResTrf
Verifica se há rescisão ou transferência para o funcionário
@author Allyson Luiz Mesashi
@since 16/05/2023
/*/
Static Function fResTrf()

Local aAreaSRE  := SRE->( GetArea() )
Local aAreaSRG  := SRG->( GetArea() )
Local lAchou    := .F.

SRE->( dbSetOrder( 2 ) )//RE_EMPP+RE_FILIALP+RE_MATP+DTOS(RE_DATA)
SRG->( dbSetOrder( 3 ) )//RG_FILIAL+RG_MAT+DTOS(RG_DATADEM)+DTOS(RG_DATAHOM)+RG_EFETIVA

lAchou := SRE->( dbSeek( cEmpAnt + SRA->RA_FILIAL + SRA->RA_MAT + dToS( SRA->RA_DEMISSA ) ) )
If !lAchou
    lAchou := SRG->( dbSeek(  SRA->RA_FILIAL + SRA->RA_MAT + dToS( SRA->RA_DEMISSA ) ) )
EndIf

RestArea( aAreaSRE )
RestArea( aAreaSRG )

Return lAchou

/*/{Protheus.doc} fTrocaRJK
Posiciona na RJK especifica do tipo de média que será impresso (RJK_TIPO)
@author Leandro Drumond
@since 14/08/2025
/*/
Static Function fTrocaRJK(cTipo, cTpAnt)
Local cChave  := RJK->(RJK_FILIAL + RJK_PROCES + RJK_MAT + RJK_PERIOD + RJK_SEMANA + RJK_ROTEIR + DtoS(RJK_DTREF) + RJK_DISSI)

If !RJK->( dbSeek( cChave + cTipo )  )
	RJK->( dbSeek( cChave + cTpAnt )  ) //Se não encontrar, retorna para o anterior
EndIf

Return Nil

/*/{Protheus.doc} RJKGetBox
Itens possíveis de seleção no campo RJK_TIPO
@author Leandro Drumond
@since 15/08/2025
/*/
User Function RJKGetBox()
Local cComboBox 	:= ""

	cComboBox := "1=" + STR0011 + ";" // Férias Vencidas
	cComboBox += "2=" + STR0012	+ ";" // Férias a Vencer
	cComboBox += "3=" + STR0013	+ ";" // 13º Salário
	cComboBox += "4=" + STR0014	+ ";" // Aviso Prévio
	cComboBox += "5=" + STR0011	+ " 2o;" // Férias Vencidas
	cComboBox += "6=" + STR0011 + " 3o;" // Férias Vencidas
	cComboBox += "7=" + STR0011 + " 4o;" // Férias Vencidas
	cComboBox += "8=" + STR0011 + " 5o;" // Férias Vencidas
	cComboBox += "9=" + STR0011 + " 6o;" // Férias Vencidas
	cComboBox += "A=" + STR0043 + ";" // Licença Maternidade

Return cComboBox
