/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR110.CH"
#INCLUDE "PONCALEN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PONR110  ³ Autor ³ R.H. - Priscila       ³ Data ³ 02.08.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio para Autorizacoes                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR110(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ FNC  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Leandro Dr. ³14/04/14³      ³Retirada de ajustes, database e FieldPos  ³±±
±±³            ³        ³      ³que nao serao utilizados na P12.		  ³±±
±±³Luis Artuso ³10/07/14³TPVTLC³Ajuste para considerar o periodo de aponta³±±
±±³            ³        ³      ³mento informado nos parâmetros "DataIni/Da³±±
±±³            ³        ³      ³taFim.                                    ³±±
±±³Luis Artuso ³15/08/14³TQDLSV³Ajuste para totalizar os eventos,ao apon- ³±±
±±³            ³        ³      ³por tipo de marcacao.                     ³±±
±±³Renan Borges³22/05/15³TSEZFC³Ajuste para imprimir o relatório de autori³±±
±±³            ³        ³      ³zações corretamente sempre que houver mais³±±
±±³            ³        ³      ³de uma página, e marcações informadas com ³±±
±±³            ³        ³      ³os próprios eventos, somando corretamente ³±±
±±³            ³        ³      ³os valores respectivas a cada marcação.   ³±±
±±³Gabriel A.  ³27/01/17³MRH-  ³Ajuste na impressão do relatório sintético³±±
±±³            ³        ³5215  ³para agrupar corretamente os eventos.     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR110()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1		:= STR0001  // "Relatorio para Autorizacoes"
Local cDesc2		:= STR0002  // "Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3		:= STR0003  // "usuario."
Local cString		:="SRA"        // alias do arquivo principal (Base)
Local aOrd			:= {STR0004 ,STR0005 ,STR0006 ,STR0007 ,STR0020 } // "Matricula"###"Centro de Custo"###"Nome"###"Turno"###"C.Custo+Nome"
Local wnRel
Local dFimRel		:= cToD("//")
Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {"",""} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
Local aFldRel		:= {"RA_NOME", "RA_RACACOR"}
Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis PRIVATE(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aReturn := { STR0008 , 1,STR0009 , 1, 2, 1, "",1 } // "Zebrado"###"Administracao"
PRIVATE nomeprog:="PONR110"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   := "PNR110"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE Titulo  :=OemToAnsi(STR0001 ) // "Relatorio para Autorizacoes
PRIVATE AT_PRG  := "PONR110"
PRIVATE wCabec0 := 2
PRIVATE wCabec1 :=" "
PRIVATE wCabec2 :=" "
PRIVATE CONTFL  :=1
PRIVATE Li      := 0
PRIVATE nTamanho:="N"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis PRIVATE(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nOrdem
PRIVATE aInfo   :={}
PRIVATE lPrevisao:= .F.

//-- Periodo de Apontamento
Private dPerIni := CTOD("")
Private dPerFim := CTOD("")

//Tratamento de acesso a Dados Sensíveis
If lBlqAcesso
	//"Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
	Help(" ",1,aOfusca[3,1],,aOfusca[3,2],1,0)
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial  De                               ³
//³ MV_PAR02        //  Filial  Ate                              ³
//³ MV_PAR03        //  Centro de Custo De                       ³
//³ MV_PAR04        //  Centro de Custo Ate                      ³
//³ MV_PAR05        //  Turno De                                 ³
//³ MV_PAR06        //  Turno Ate                                ³
//³ MV_PAR07        //  Matricula De                             ³
//³ MV_PAR08        //  Matricula Ate                            ³
//³ MV_PAR09        //  Nome De                                  ³
//³ MV_PAR10        //  Nome Ate                                 ³
//³ MV_PAR11        //  Situacao                                 ³
//³ MV_PAR12        //  Categoria                                ³
//³ MV_PAR13        //  Imprime C.C em outra Pagina              ³
//³ MV_PAR14        //  Dia Inicial                              ³
//³ MV_PAR15        //  Dia Final                                ³
//³ MV_PAR16        //  Imprimir Abonados                        ³
//³ MV_PAR17        //  Imprimir Todos Eventos                   ³
//³ MV_PAR18        //  Impr. Eventos                            ³
//³ MV_PAR19        //  Continuacao Impr. Eventos                ³
//³ MV_PAR20        //  Continuacao Impr. Eventos                ³
//³ MV_PAR21        //  Relatorio                                ³
//³ MV_PAR22        //  Func. em outra pagina                    ³
//³ MV_PAR23        //  Impr. Motivo Abono                       ³
//³ MV_PAR24        //  Impr. Marcacoes                          ³
//³ MV_PAR25        //  Regra De                                 ³
//³ MV_PAR26        //  Regra Ate                                ³
//³ MV_PAR27        //  Impr. Horario Previsto                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="PONR110"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

If	nLastKey = 27
	Return Nil
Endif

SetDefault(aReturn,cString)

dFimRel	:= MV_PAR15
If !PerAponta(@dPerIni,@dPerFim,dFimRel)
	Return Nil
Endif

If nLastKey = 27
	Return Nil
Endif
cCabec  := STR0001  // "Relatorio para Autorizacoes"

RptStatus({|lEnd| PO110Imp(@lEnd,wnRel,cString)},Titulo)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PO110Imp ³ Autor ³ R.H. - Priscila       ³ Data ³ 02.07.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio para Autorizacoes                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ PO110Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³Parametros³ cString     - Mensagem                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PO110Imp(lEnd,WnRel,cString)

Local aCodigos  	:= {}
Local aJustifica   	:= {}	//-- retorna Justificativa de abono
Local xQuant       	:= 0
Local nPos         	:= 0
Local cPD          	:= Space(03)
Local cAcessaSRA 	:= &("{ || " + ChkRH("PONR110","SRA","2") + "}")
Local cAcessaSPC 	:= &("{ || " + ChkRH("PONR110","SPC","2") + "}")
Local nTab	     	:=0
Local nPosTab	 	:=0
Local nLenCalend 	:=0
Local aPrevFun   	:={}
Local cOrdem	 	:=''
Local nLimite    	:= 0
Local nFor			:= 0
Local nX		 	:= 0
Local cCol1      	:= ''
Local cCol2      	:= ''
Local cFilCompara	:= Space(FWGETTAMFILIAL)
Local X				:= 0
Local aPDI 			:= {} // Armazena eventos informados
Local dDataAux		:= CTod('//')
Local cTpEnt		:= ''
Local cCCust		:= ''
Local cInicio		:= ""
Local cFim			:= ""

Private cDet	 	:= ''
Private cDet1  	 	:= ''
Private cDet2	 	:= ''
Private cDet3	 	:= ''
Private nVez	 	:= 0
Private cItem    	:= ''
Private lImpLinhas	:= ''
Private aDet       	:= {}
Private lCabec     	:= .F.
Private lCabecCC   	:= .F.
Private lCabecTT   	:= .F.
Private aMarcFun   	:= {}
Private aTabPadrao 	:= {}
Private aTabCalend 	:= {}
Private nPosMarc   	:= 0
Private nLenMarc   	:= 0
Private cCabec  	:= 	STR0001  // "Relatorio para Autorizacoes"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis MV_PAR?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem   := If (Empty(aReturn[8]), 1, aReturn[8])
FilialDe := MV_PAR01
FilialAte:= MV_PAR02
CcDe     := MV_PAR03
CcAte    := MV_PAR04
TurDe    := MV_PAR05
TurAte   := MV_PAR06
MatDe    := MV_PAR07
MatAte   := MV_PAR08
NomDe    := MV_PAR09
NomAte   := MV_PAR10
cSit     := MV_PAR11
cCat     := MV_PAR12
lCC      := If(MV_PAR13 == 1,.T.,.F.)
dInicio  := MV_PAR14
dFim     := MV_PAR15
lImpAbon := If(MV_PAR16 == 1,.T.,.F.)      // Imprimir Abonados
lTodEvent:= If(MV_PAR17 == 1,.T.,.F.) 		//Seleciona "S" ou "N" todos os Eventos do Ponto //
cEventos := MV_PAR18						//Seleciona os Codigos dos Eventos //
cCont1	 := MV_PAR19						//Continuacao dos Codigos dos Eventos //
cCont2	 := MV_PAR20 						//Continuacao dos Codigos dos Eventos //
nSinAna  := MV_PAR21 						//Relatorio Sintetico ou Analitico//
lImpFol	 := If(MV_PAR22 == 1,.T.,.F.)
lImpMot  := IF(MV_PAR23 == 1,.T.,.F.)
lImpMar	 := If(MV_PAR24 == 1,.T.,.F.)
RegDe    := MV_PAR25
RegAte   := MV_PAR26
lPrevisao:= IF(MV_PAR27 == 1,.T.,.F.) 		 //.T. - Lista Horario Previsto

If MV_PAR14 > MV_PAR15  	 				//Data Inicial /Data Final
	Help(" ",1,"PNR110DATA")
	Return Nil
Endif

//-- Para Relatorio Sintetico nao imprime Previsao e/ou Marcacao
If nSinAna==1
	lPrevisao:=.F.
	lImpMar	:=.F.
Endif

cCodigos :=""
For X = 1 To 30 Step 3
	cCodigos	+= SubStr(cEventos,X,3)
	cCodigos	+= "*"
	cCodigos	+= SubStr(cCont1,X,3)
	cCodigos	+= "*"
	cCodigos	+= SubStr(cCont2,X,3)
	cCodigos	+= "*"
Next

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
	lCabecCC := IF(!lImpFol,.T.,.F.)
ElseIf nOrdem == 3
	dbSeek(FilialDe + NomDe + MatDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim     := FilialAte + NomAte + MatAte
ElseIf nOrdem == 4
	dbSeek(FilialDe + TurDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_TNOTRAB"
	cFim     := FilialAte + TurAte
	lCabecTT := IF(!lImpFol,.T.,.F.)
ElseIf nOrdem == 5
	dbSetOrder(8)
	dbSeek(FilialDe + CcDe + NomDe,.T.)
	cInicio  := 'SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME'
	cFim     := FilialAte + CcAte + NomAte
Endif


//--Numero de registros a serem processados na Regua
SetRegua(SRA->(RecCount()))

cTnoAnt      := Replicate("ú", GetSx3Cache("RA_TNOTRAB", "X3_TAMANHO"))
cSeqAnt      := Replicate("ú", GetSx3Cache("RA_SEQTURN", "X3_TAMANHO"))
aTabCalend   := {}
cTurnoant    := Replicate("@", GetSx3Cache("RA_TNOTRAB", "X3_TAMANHO"))
cFilAnterior := Replicate("@", FWGETTAMFILIAL)
cCcAnt       := Replicate("@", GetSx3Cache("RA_CC", "X3_TAMANHO"))

dbSelectArea( "SRA" )
While !EOF() .And. &cInicio <= cFim

	//--Movimenta regua de processamento
	IncRegua()

	//--Botao cancela da impressao
	If lEnd
		IMPR(cCancela,"C")
		Exit
	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		SRA->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_Nome < NomDe)    .Or. (SRA->RA_Nome > NomAte) .Or. ;
		(SRA->RA_Mat < MatDe)     .Or. (SRA->RA_Mat > MatAte)  .Or. ;
		(SRA->RA_CC < CcDe)       .Or. (SRA->RA_CC > CCAte) .OR. ;
		(Sra->RA_TNOTRAB < TurDe) .Or. (SRA->RA_TNOTRAB > TurAte) .Or. ;
		(Sra->RA_REGRA < RegDe)   .Or. (SRA->RA_REGRA > RegAte)
		Sra->(dbSkip())
		Loop
	Endif

	If  (SRA->RA_DEMISSA < dInicio .AND. ! Empty(SRA->RA_DEMISSA))
		SRA->(DbSkip())
		Loop
	Endif

	If !(Sra->Ra_SitFolh $ cSit) .Or. !(Sra->Ra_CatFunc $ cCat)
		DbSkip()
		Loop           // Testa Categoria e Situacao
	Endif

	If SRA->RA_FILIAL != cFilAnterior // quebra filial
		lCabec := .T.
		cFilAnterior:= SRA->RA_FILIAL
		cTurnoAnt	:= Replicate("@", GetSx3Cache("RA_TNOTRAB", "X3_TAMANHO"))
		cCcAnt		:= Replicate("@", GetSx3Cache("RA_CC", "X3_TAMANHO"))

		//--Carrega array com os eventos do Ponto a cada troca de Filial
		dbSelectArea("SP9")
		If (Empty(xFilial("SP9")) .AND. Empty(aCodigos) ) .OR. ;
		   (!Empty(xFilial("SP9")) .AND. (cFilAnterior != cFilCompara) )

			If !DbSeek(cFilAnterior)
				If !DbSeek(xFilial( "SP9", cFilAnterior ))
					Exit
				Endif
			Endif
			cFilCompara := SP9->P9_FILIAL
			aCodigos := {}
			While ! Eof() .AND. SP9->P9_FILIAL = cFilCompara

				If lTodEvent .Or. (SP9->P9_CODIGO $ cCodigos)
					Aadd(aCodigos,{Left(SP9->P9_CODIGO,3),P9_DESC})
				Endif
				DbSkip()
			EndDo
		Endif
	Endif

	//--Verifica Quebra de Turno na Impressão Ordem por Turno
	If nOrdem == 4 .And. cTurnoAnt != SRA->RA_TNOTRAB
		If !lImpFol
			lCabecTT := .T.
		Endif
		cCcAnt    := Replicate("@", GetSx3Cache("RA_CC", "X3_TAMANHO"))
		cTurnoAnt := SRA->RA_TNOTRAB
	Endif

	//--Verifica Quebra de C.Custo na Impressão Ordem por C.Custo
	If (nOrdem == 2 .Or. nOrdem == 5) .AND. SRA->RA_CC != cCcAnt
		If lCc
			lCabec := .T.
		Endif
		lCabecCC := .T.
	Endif
	cCcAnt := SRA->RA_CC
	cTurnoAnt := SRA->RA_TNOTRAB
	dDtMarc:=CtoD("  /  /  ")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Calendario de Marca‡oes do Periodo                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cTnoAnt + cSeqAnt != SRA->RA_TNOTRAB + SRA->RA_SEQTURN
		cTnoAnt    := SRA->RA_TNOTRAB
		cSeqAnt    := SRA->RA_SEQTURN
	Endif

	//-- Cria Calendario com o periodo completo com Trocas de Turno
	aTabCalend := {} ; aTurnos   := {} ; aMarcacoes := {}

	//-- Carrega as Marcacoes do Periodo
	IF !GetMarcacoes( @aMarcacoes ,;		//Marcacoes dos Funcionarios
		@aTabCalend		,;					//Calendario de Marcacoes
		@aTabPadrao		,;					//Tabela Padrao
		@aTurnos		,; 					//Turnos de Trabalho
		dPerIni 		,; 					//Periodo Inicial
		dPerFim			,;					//Periodo Final
		SRA->RA_FILIAL	,;					//Filial
		SRA->RA_MAT		,; 					//Matricula
		SRA->RA_TNOTRAB	,; 					//Turno
		SRA->RA_SEQTURN	,; 					//Sequencia de Turno
		SRA->RA_CC		,;					//Centro de Custo
		"SP8"			,; 					//Alias para Carga das Marcacoes
		.F.    			,; 					//Se carrega Recno em aMarcacoes
		.T.      		,;					//Se considera Apenas Ordenadas
		.T.      		,;					//Se Verifica as Folgas Automaticas
		.F.      		 ;					//Se Grava Evento de Folga Automatica Periodo Anterior
		)
		cTnoAnt := Replicate("ú", GetSx3Cache("RA_TNOTRAB", "X3_TAMANHO"))
		cSeqAnt := Replicate("ú", GetSx3Cache("RA_SEQTURN", "X3_TAMANHO"))
		SRA->(dbSkip())
		Loop
	EndIF

	//-- Obtem Qtde de Marcacoes
	nLenMarc:=Len(aMarcacoes)

	aDet := {}

	// 1 - Data
	// 2 - Codigo do Evento
	// 3 - Descricao do Evento
	// 4 - Numero de Horas
	// 5 - Descricao do Abono
	// 6 - Quantidade de horas Abonadas
	// 7 - Marcacoes

	dbSelectArea( "SPC" )
	If DbSeek(SRA->RA_FILIAL + SRA->RA_Mat )
		While !Eof() .And. SPC->PC_FILIAL+SPC->PC_Mat == SRA->RA_FILIAL+SRA->RA_Mat

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste controle de acessos e filiais validas               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Eval(cAcessaSPC)
				SPC->(dbSkip())
				Loop
			EndIf

			//-- Verifica o Periodo Solicitado
			If Empty(SPC->PC_DATA) .OR. SPC->PC_DATA < dInicio .OR. SPC->PC_DATA > dFim
				DbSkip()
				Loop
			Endif

			//-- Verifica se Deve Imprimir os Abonados
			If !lImpAbon .And. SPC->PC_QTABONO > 0
				dbSkip()
				Loop
			Endif

			//-- Utiliza o codigo informado qdo houver
			If !( Empty(SPC->PC_PDI) )
				cPd := SPC->PC_PDI
				nPos	:= Ascan( aPdi , cPd )
				If ( nPos == 0 )
					AADD(aPdi , cPd)
				EndIf
			Else
				cPd	:= SPC->PC_PD
			EndIf
			cCodTot:=cPD
			//-- Verifica se e um codigo contido na relacao de codigos
			//-- definidas segundo avariavel cCodigos
			nPos := Ascan(aCodigos,{ |x| x[1] = cPD })
			//-- Se o Codigo do Evento apontado  eh Valido
			If nPos > 0
				//-- Obtem a quantidade do evento apontando
				xQuant := If(SPC->PC_QUANTI>0,SPC->PC_QUANTI,SPC->PC_QUANTC)
				//-- Posiciona na TabCalend para a Data Lida
				nTab := Ascan(aTabCalend, {|x| x[CALEND_POS_DATA_APO] == SPC->PC_DATA .And. x[CALEND_POS_TIPO_MARC] == '1E' })
				//-- Se existir calendario para o apontamento
				//-- Obs.: Se um apontamento for digitado pode ocorrer de nao ter
				//--       uma data correspondente na TabCalend ???
				aMarcFun:={}
				aPrevFun:={}
				If nTab>0
					//-- Obtem a Ordem para a Data Lida
					cOrdem    := aTabCalend[nTab,CALEND_POS_ORDEM] //-- Ordem

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Obtem as Previsoes Cadastradas p/a Ordem Lida  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lPrevisao
						nLenCalend:=Len(aTabCalend)
						nPosTab:=nTab
						//-- Corre as Previsoes de mesma Ordem
						While cOrdem == aTabCalend[nPosTab,CALEND_POS_ORDEM]
							If aTabCalend[nPosTab,CALEND_POS_TIPO_DIA] == "C"
								Aadd(aPrevFun,STR0036)//"Compensado"
								Exit
							ElseIF aTabCalend[nPosTab,CALEND_POS_TIPO_DIA] == "D"
								Aadd(aPrevFun,STR0037)//"D.S.R"
								Exit
							ElseIF aTabCalend[nPosTab,CALEND_POS_TIPO_DIA] == "N"
								Aadd(aPrevFun,STR0038)//"Nao trabalhado"
								Exit
							Else
								Aadd(aPrevFun,StrTran(StrZero(aTabCalend[nPosTab,CALEND_POS_HORA],5,2),'.',':'))
								//-- Obtem novo Horario
								nPosTab ++
								If	nPosTab > nLenCalend
									Exit
								Endif
							EndIf
						EndDo
					Endif

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Obtem as Marcacoes Realizadas para a Ordem Lida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lImpMar
						//-- A aMarcacoes ‚ setado para a 1a Marca‡„o do dia em quest„o.
						//-- de acordo com a ordem da tabela
						nPosMarc:=Ascan(aMarcacoes,{|x| x[3]==cOrdem})
						//-- Se Existir Marcacao para o Dia
						If !Empty(nPosMarc)
							//--  Corre Todas as marcacoes enquanto a mesma ordem
							While cOrdem == aMarcacoes[nPosMarc,3]
								//-- Monta o array com as Marcacoes do funcionario para a ordem.
								Aadd(aMarcFun,StrTran(StrZero(aMarcacoes[nPosMarc,2],5,2),'.',':'))
								nPosMarc++
								//-- Se o contador ultrapassar o total de Marcacoes abandona loop
								If nPosMarc>nLenMarc
									Exit
								Endif
							EndDo
						Endif
					Endif
				Endif

				aJustifica := {}
				If lImpMot
					//-- Verifica se existe abonos e posiciona registro de abono
					fAbonos(SPC->PC_DATA, aCodigos[nPos,1],,@aJustifica,SPC->PC_TPMARCA,SPC->PC_CC)
				Endif

				If nSinAna == 1	// Sintetica
					//-- Sintetiza por Evento
					If (nPosDet:=Ascan(aDet,{ |x| x[2] = cPD .And. x[11] == SPC->PC_ABONO })) > 0
						aDet[nPosDet,4]:=SomaHoras(aDet[nPosDet,4],xQuant)
	                    //-- Acumula Abonado somente se Nao for imprimir os motivos do mesmo
						aDet[nPosDet,6]		:=If(Empty(aDet[nPosDet,6]),SomaHoras(aDet[nPosDet,6],SPC->PC_QTABONO),aDet[nPosDet,6])
						aDet[nPosDet,12]	:='A' //Ordem para Obrigar que esse seja o primeiro elemento
						//apos o Sort do aDet
					Endif

					//-- Acrescenta os motivos de abono para o evento
					If Len(aJustifica) > 0 .And. lImpMot
						For nX := 1 To Len(aJustifica)
							//-- Totaliza cada motivo para o mesmo evento
							If (nPosDet:=Ascan(aDet,{ |x| x[2] = cPD .AND. x[11]==aJustifica[nX,1]})) > 0
								//-- Totaliza Abonos para mesmo motivo
								aDet[nPosDet,6]:=SomaHoras(aDet[nPosDet,6],aJustifica[nX,2])
							Else
								aAdd(aDet,{ SPC->PC_DATA, aCodigos[nPos,1], aCodigos[nPos,2] ,xQuant,;
								PADR(DescAbono(aJustifica[nX,1],'C'),25),;
								aJustifica[nX,2],aMarcFun,aPrevFun,SPC->PC_TPMARCA,SPC->PC_CC,	aJustifica[nX,1],'Z'})
							Endif
						Next nX
					Else
						If nPosDet==0
							aAdd(aDet,{ SPC->PC_DATA, aCodigos[nPos,1], aCodigos[nPos,2] ,	xQuant,;
							SPACE(25),0,aMarcFun,aPrevFun,SPC->PC_TPMARCA,SPC->PC_CC,SPACE(3),'Z'})
						Endif
					Endif
				Else
					If Len(aJustifica) > 0 .And. lImpMot
						For nX := 1 To Len(aJustifica)
							aAdd(aDet,{ SPC->PC_DATA, aCodigos[nPos,1], aCodigos[nPos,2] , xQuant,;
							PADR(DescAbono(aJustifica[nX,1],'C'),25),aJustifica[nX,2],aMarcFun,aPrevFun,SPC->PC_TPMARCA,SPC->PC_CC,SPACE(3),'A' })
						Next nX
					Else
						aAdd(aDet,{ SPC->PC_DATA, aCodigos[nPos,1], aCodigos[nPos,2] ,	xQuant,;
						SPACE(25),0,aMarcFun,aPrevFun,SPC->PC_TPMARCA,SPC->PC_CC,SPACE(3),'A'  })
					Endif
				Endif
			Endif
			dbSelectArea("SPC")
			DbSkip()
		EndDo

		If Len(aDet) > 0
			//-- O Sort para Analitico e por Data e ordem
			If nSinAna==2
				aSort(aDet,,,{|x,y| Dtos(x[1])+x[12]+x[2] < Dtos(y[1])+y[12]+y[2]}) //Data+ordem de leitura+cod.evento
			Else
				//-- O Sort no Sintetico e por Evento
				aSort(aDet,,,{|x,y|x[2]+x[12] < y[2]+y[12]}) //Data+ordem de leitura
			Endif

			dDtMarc:=CtoD("  /  /  ")
			//-- Corre Cada Apontamento
			For nFor := 1 To Len(aDet)
				cDet :=""

				//Verifica a Quebra de Data
				If  dDtMarc<>aDet[nFor,1]
					//-- Monta Inicio das linhas
					//-- se previsoes e/ou marcacoes forem impressas  a Cada Data
					dDtMarc:=aDet[nFor,1]
					nVez:=0
				    aData  :="!!"
					nData  :=aData
					If lImpMar .OR. lPrevisao
						cDet1:=""	// Impressao da Continuacao das Marcacoes/Previsoes
						cDet2:=""	// Impressao da Continuacao das Marcacoes/Previsoes
						cDet3:=""	// Impressao da Continuacao das Marcacoes/Previsoes
						nVez :=0    // Contador auxiliar para apontar as cDet's
						aMarc  :=aDet[nFor,7]
						aPrev  :=aDet[nFor,8]
						aData  :=SubStr(Dtos(aDet[nFor,1]),7,2)+"/"+SubStr(Dtos(aDet[nFor,1]),5,2)+" "
						nPrev  :=Len(aPrev)
						nMarc  :=Len(aMarc)
					    nLimite:=Max(nPrev,nMarc)
						cCol1  := ''
						cCol2  := ''
                        cCol0  := ''
				        If nLimite == 0
							cCol0:=aData
					    	cDet+=Padr(cCol0,5)+"| "
					    	cCol0  := ''
					    EndIf
						For nX:=1 to nLimite
							//-- Imprime Marcacao, mas nao imprime Previsao//
							If !lPrevisao .AND. lImpMar
								cCol0 :=If(nData==aData,,aData)+" "
								If nX > 8
								    If nX == 0 .Or. nX == 1
										cDet1+=Padr(cCol0,5)+"| "
									Endif
									cDet1+=aMarc[nX]+" "
								Else
									If nX ==1
										cDet+=Padr(cCol0,5)+"| "
									Endif
									cDet+=aMarc[nX]+" "
								Endif
								//-- Imprime Previsao, mas nao imprime Marcacao//
							ElseIf lPrevisao .AND. !lImpMar
								cCol0 :=If(nData==aData,,aData)+" "
								If nX > 8
									If nX ==1
										cDet+=Padr(cCol0,5)+"| "
									Endif
									cDet1+=aPrev[nX]+" "
								Else
									If nX ==1
										cDet+=Padr(cCol0,5)+"| "
									Endif
									cDet+=aPrev[nX]+" "
								Endif
								//-- Imprime Previsao e Marcacao//
							Else
								//-- Monta Cada Coluna ao Total de 4 marcacoes cada uma//
								cCol0 :=If(nData==aData,,aData)+" "
								cCol1 +=If(nX<=nPrev,aPrev[nX],SPACE(5)) +" "
								cCol2 +=If(nX<=nMarc,aMarc[nX],SPACE(5)) +" "
								Do Case
									//-- A Cada Multiplo de 4 ou se Ultima Marcacao e Linha
									//-- Vazia Preenche-a

									Case nX =4 .OR. (nX == nLimite .AND. Empty(cDet))
										cDet:=Padr(cCol0,5)+"| "+Padr(cCol1,24)+"| "+Padr(cCol2,24)
										cCol1:=cCol2:=''
									Case nX =8 .OR. (nX == nLimite .AND. Empty(cDet1))
										cDet1:=Padr(cCol0,5)+"| "+Padr(cCol1,24)+"| "+Padr(cCol2,24)
										cCol1:=cCol2:=''
									Case nX =12 .OR. (nX == nLimite .AND. Empty(cDet2))
										cDet2:=Padr(cCol0,5)+"| "+Padr(cCol1,24)+"| "+Padr(cCol2,24)
										cCol1:=cCol2:=''
									Case nX =16 .OR. (nX == nLimite .AND. Empty(cDet3))
										cDet3:=Padr(cCol0,5)+"| "+Padr(cCol1,24)+"| "+Padr(cCol2,24)
										cCol1:=cCol2:=''
								EndCase
							Endif
						Next
						cDet :=Padr(cDet,56)
						cDet1:=Padr(cDet1,56)
						cDet2:=Padr(cDet2,56)
						cDet3:=Padr(cDet3,56)
					Else
						//--Reinicializa Variaveis se nao for imprimir previsoes/marcacoes
						cDet1:=""	// Impressao da Continuacao das Marcacoes/Previsoes
						cDet2:=""	// Impressao da Continuacao das Marcacoes/Previsoes
						cDet3:=""	// Impressao da Continuacao das Marcacoes/Previsoes
					Endif
				Endif

				//-- Se nao for a 1a. vez, altera o inicio das linhas referentes as marcacoes/previsoes
				//-- Acrescenta as Marcacoes/Previsoes
				If nVez>0

					If nVez<4 //- Imprime as Demais cDet
						cItem		:=Alltrim(STR(nVez,0))
						cDet		:=Padr(cDet&cItem,90)
						cDet&cItem	:=''
					Endif
				Else
					nVez++
				Endif

				//-- Acrescenta Data/CodEvento/DescEvento/Hora
				If nvez>3 //Apos imprimir Todas as possiveis marcacoes/previsoes
					cDet := If(nSinAna == 1,Space(90),Space(51)+'|'+Space(39))
				Else
					cDet :=Padr(cDet,56)
					//-- Se o Tipo de Apontamento for mesmo que o anterior nao imprime
					//-- Data/CodEvento/DescEvento/Hora
					If nFor > 1 .And.;
						((nSinAna == 2 	.AND. aDet[nFor-1,1] == aDet[nFor,1] ;  	//Data
						.AND. aDet[nFor-1,2] == aDet[nFor,2];  	//Evento
						.AND. aDet[nFor-1,9] == aDet[nFor,9];  	//Tp.Marcacao
						.AND. aDet[nFor-1,10] == aDet[nFor,10]);  //C.C.
						.OR.  ;
						(nSinAna == 1 	.AND. ( aDet[nFor-1,2] == aDet[nFor,2] .And. aDet[nFor-1,11] == aDet[nFor,11] ) ))  //Evento
						cDet+=If(nSinAna == 1,'','|')+Space(39)
					Else
						dDataAux:= aDet[nFor,1]
						cPd		:= aDet[nFor,2]
						cTpEnt	:= aDet[nFor,9]
						cCCust := aDet[nFor,10]
						nPos	:= Ascan( aPdi , cPd )
						If !( nPos == 0 )
							xQuant	:= 0
							aEval( aDet , { |x| If(x[1] = dDataAux .And. x[2] == cPd .And. x[9] == cTpEnt .And. x[10] == cCCust, xQuant:=SomaHoras(xQuant,x[4]) , 0 ) } )
							xQuant := StrZero(xQuant,6,2)
						Else
							xQuant := StrZero(aDet[nFor,4],6,2)
						EndIf
						xQuant := STRTRAN(xQuant,".",":")
						cDet += Space(1) + "  " + aDet[nFor,2] + " " + aDet[nFor,3] + " "+ xquant + " "
					Endif
				Endif

				//-- Acrescenta Motivo ou Traco para Justificativa
				If lImpMot
					If !Empty(aDet[nFor,5]) //-- Evento Com Abonos a Imprimir na Data Lida
						//-- Motivo do Abono
						cDet +=aDet[nFor,5] + Space(2)
						If aDet[nFor,6] > 0
							cDet+= " "+ STRTRAN(StrZero(aDet[nFor,6],6,2),".",":")
						Endif
					Else
						cDet+= Repl("_",24) + Space(2) + Repl("_",15)
					Endif
				Else
					cDet+= Repl("_",24) + Space(2) + Repl("_",15)
				Endif

				If Li <> 58 .And. nFor > 1
					Impr(" ","C")
				Endif

				//--Imprime Nome Somente na 1a. Linha Detalhe
				U_F110ImprL(cDet,if(nFor > 1 .And. aDet[nFor-1,1] == aDet[nFor,1],.F.,.T.), nFor)

				//--Forca a Impressao das Marcacoes/Previsoes se Nao houver abonos e for o ultimo apontamento
				//--ou se o proximo apontamento for de outra Data
				If nFor+1<len(aDet)
					lImpLinhas:=If(Empty(aDet[nFor,5]) .AND. aDet[nFor+1,1]<>dDtMarc,.T.,.F.)
				Else
					lImpLinhas:=If(Empty(aDet[nFor,5]),.T.,.F.)
				Endif

				//--Imprime as Marcacoes/Previsoes se Nao Deseja imprimir o motivo do abono
				//-- ou forca a impressao das linhas
				If !lImpMot  .OR. lImpLinhas
					If !Empty(cDet1)
						U_F110ImprL(cDet1,.F.,nFor)
						cDet1:=''
					Endif
					If !Empty(cDet2)
						U_F110ImprL(cDet2,.F., nFor)
						cDet2:=''
					Endif
					If !Empty(cDet3)
						U_F110ImprL(cDet3,.F., nFor)
						cDet3:=''
					Endif
				Endif

			Next nFor

			If Li <> 58
				Impr(Repl("-",132),"C")
			Endif

			If lImpFol
				Impr("","P")
				lCabec:=.T.
			Endif
		Endif
	Endif
	dbSelectArea("SRA")
	dbSkip()
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SP8" )
dbSetOrder(1)

dbSelectArea("SRA")
dbSetOrder(1)
Set Device To Screen
If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Imp_Cabec ³ Autor ³ J.Ricardo             ³ Data ³ 09/04/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o cabecalho do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR030IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Imp_Cabec

//====================================================================================================
//Chapa Matr.  Funcionario                    Data   Cod Descricao            Horas Justificativa                 Visto"
//====================================================================================================
//Filial: 01-123456789012345  Turno: 001-12345678901234567890    C.C: 123456789-1234567890123456789012
//====================================================================================================
//12345 123456 123456789012345678901234567890
//99:99 99:99 99:99 99:99 99:99 99:99 99:99   99/99  999 1234567890123456789 999.99 12345678901234567890123456789 12345678901234567890



If  nSinAna == 2
	wCabec1 := STR0017 + SRA->RA_FILIAL + "-" + Left(SM0->M0_Nome+Space(15),15) //"Filial: "
	//-- Altera Relatorio se Previsao e/ou Marcacao forem ou nao impressas

	Li   := 0
	If lImpFol
		wCabec1+= STR0018+SRA->RA_TNOTRAB // " Turno: "
		wCabec1+= STR0019+ SUBSTR(SRA->RA_CC+SPACE(20),1,20) + "-" +; // "    C.C: "
	    Left(DescCc(SRA->RA_CC,SRA->RA_FILIAL,30)+Space(30),30)
	Endif
ElseIf nSinAna == 1

	wCabec1 := STR0017 + SRA->RA_FILIAL + "-" + Left(SM0->M0_Nome+Space(15),15) //"Filial: "
	wCabec2 := STR0012 + " " +STR0013+ "  " +STR0014+ SPACE(35)+STR0011
	//-- Altera Relatorio se Previsao e/ou Marcacao forem ou nao impressas

	Li   := 0
	If lImpFol
		wCabec1+= STR0018+SRA->RA_TNOTRAB // " Turno: "
		wCabec1+= STR0019+ SUBSTR(SRA->RA_CC+SPACE(20),1,20) + "-" +; // "    C.C: "
	    Left(DescCc(SRA->RA_CC,SRA->RA_FILIAL,30)+Space(30),30)
	Endif
Endif
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³f110ImprL ³ Autor ³ Aldo Marini Junior    ³ Data ³ 30/09/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime detalhe verificando a necessidade de pulo de pagina³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_f110ImprL(cString)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function f110ImprL(cString,lImpNome, nFor)

Local cNome:=SRA->RA_CHAPA + " " + SRA->RA_MAT + " " + Left(SRA->RA_NOME,30) + " "
Local lCab:=.F.
Local cDet1:=" "
Local lImpString	:=	.F.
//-- Altera o SubCabec se analitico com impressao de previsao ou de marcacoes
If 	  nSinAna == 2  .AND. (lPrevisao .OR. lImpMar)
	  cNome:=STR0021+SRA->RA_CHAPA + " " + STR0022+SRA->RA_MAT + " " + STR0023+Left(SRA->RA_NOME,30) + SPACE(5)
Endif
//-- Deve imprimir o nome ?
lImpNome := If(lImpNome == Nil, .T., lImpNome)

// Caso seja primeira linha do Detalhe , imprime o Nome do Func.
If nFor == 1 .Or. Li == 58 .Or. Li == 8
	If Li == 58
		lCabec:=.T.

		If !lImpFol
			If nOrdem == 2 .Or. nOrdem == 5
				lCabecCC:=.T.
			Endif
			If nOrdem = 4
				lCabecTT := .T.
			Endif
		Endif
	Endif

	If (lImpMar .OR. lPrevisao) .And. nSinAna == 2
		lCab:=.T.
	Else

		cString := SubStr(cString,50,Len(cString)-49)
		cString := cNome+Space(05)+cString
	Endif
Endif

If lCabec
	Imp_Cabec()
	lCabec := .F.
Endif

If lCabecCC
	cDet1 := STR0015 + SUBSTR(SRA->RA_CC+SPACE(20),1,20) + "-" +; // "C.C: "
		Left(DescCc(SRA->RA_CC,SRA->RA_FILIAL,30)+Space(30),30)
	IMPR(cDet1,"C")
	If Li <> 58
		IMPR(REPLICATE("-",132),"C")
	Endif
	lCabecCC := .F.
Endif

If lCabecTT
	cDet1 := STR0018+SRA->RA_TNOTRAB +"-"+ fDescTno(SRA->RA_FILIAL,SRA->RA_TNOTRAB) // " Turno: "
	IMPR(cDet1,"C")
	If Li <> 58
		IMPR(REPLICATE("-",132),"C")
	Endif
	lCabecTT := .F.
Endif

If Li < 58
	If lCab .And. lImpNome
		If Li >= 54
			Imp_Cabec()
		EndIf
		IMPR(cNome,"C")
		lCab:=.F.
		IMPR(Repl("-",132),"")
		//-- Altera Relatorio se Previsao e/ou Marcacao forem ou nao impressas
		cDet :=If(lPrevisao  .AND.  lImpMar ,PADR(STR0026+SPACE(3)+STR0024+SPACE(17)+STR0025,59)+STR0011,;
		       If(lPrevisao  .AND. !lImpMar ,PADR(STR0026+SPACE(3)+STR0024,59)+STR0011,;
		       If(!lPrevisao .AND.  lImpMar ,PADR(STR0026+SPACE(3)+STR0025,59)+STR0011,;
		           Padr(STR0012+SPACE(1)+STR0013+SPACE(2)+STR0014,51)+STR0011)))
		IMPR(cDet,"C")
		IMPR(Repl("-",132),"")
	EndIf
EndIf

If Li == 58
	Imp_Cabec()
	If (nOrdem == 2 .Or. nOrdem == 5).And. !lImpFol
		cDet1 := STR0015 + SUBSTR(SRA->RA_CC+SPACE(20),1,20) + "-" +; // "C.C: "
		Left(DescCc(SRA->RA_CC,SRA->RA_FILIAL,30)+Space(30),30)
		IMPR(cDet1,"C")
		IMPR(REPLICATE("-",132),"C")
	Endif

	If nOrdem == 4 .And. !lImpFol
		cDet1 := STR0018+SRA->RA_TNOTRAB +"-"+ fDescTno(SRA->RA_FILIAL,SRA->RA_TNOTRAB) // " Turno: "
		IMPR(cDet1,"C")
		If Li <> 58
			IMPR(REPLICATE("-",132),"C")
		Endif
	Endif

	If (lImpMar .OR. lPrevisao) .And. nSinAna == 2
		IMPR(cNome,"C")
	Else
		cString := SubStr(cString,50,Len(cString)-49)
		cString := cNome+Space(05)+cString
	Endif
Endif

lImpString	:=	ALLTRIM( STRTRAN(cString , "_" , "") ) <> "|"
// Inibe a impressão de linha sem conteudo. Ex:         |    ____________

If ( lImpString )
	IMPR(cString,"C")
EndIf

Return
