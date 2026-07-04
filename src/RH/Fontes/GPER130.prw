/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.ch"
#Include "GPER130.CH"

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё GPER130  Ё Autor Ё R.H. - Mauro          Ё Data Ё 26.04.95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Recibo de Ferias                                           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё U_GPER130(void)                                              Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё         ATUALIZACOES SOFRIDAS DESDE A CONSTRU─AO INICIAL.             Ё╠╠
╠╠цддддддддддддбддддддддбдддддддбддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁProgramador Ё Data   Ё BOPS  Ё  Motivo da Alteracao                    Ё╠╠
╠╠цддддддддддддеддддддддедддддддеддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁCarlos E. O.Ё11/11/13ЁM12RH01Ё Retirada da funcao AjustaSx1 para       Ё╠╠
╠╠Ё            Ё        Ё196704 Ё inclusao do fonte na P12.               Ё╠╠
╠╠ЁSidney O.   Ё27/08/14ЁTPZPWZ Ё Criada validacao para as datas do grupo Ё╠╠
╠╠Ё            Ё        Ё       Ё de perguntas GPR130.                    Ё╠╠
╠╠ЁFlavio Corr Ё16/06/15ЁTSPUL3 Ё CorreГЦo busca de ferias na SRF para    Ё╠╠
╠╠Ё            Ё        Ё       Ё aviso ferias calculadas                 Ё╠╠
╠╠ЁRenan BorgesЁ30/12/15ЁTUCPPB Ё Ajuste para imprimir recibo de abono de Ё╠╠
╠╠Ё            Ё        Ё       Ё fИrias corretamente independentemente   Ё╠╠
╠╠Ё            Ё        Ё       Ё do filtro utilizado nos parametros.     Ё╠╠
╠╠Ё            Ё        Ё       Ё aviso ferias calculadas                 Ё╠╠
╠╠ЁGustavo M.  Ё01/03/16ЁTUOZGY Ё Ajuste para posicionar corretamente ao  Ё╠╠
╠╠Ё            Ё        Ё       Ё dar o loop da SRA.					  Ё╠╠
╠╠ЁP. Pompeu   Ё04/04/16ЁTUUDL2 Ё CorreГЦo Valid. Pergunte Data Final     Ё╠╠
╠╠ЁGabriel A.  Ё21/09/16ЁTVYMFC Ё Ajuste para gerar as verbas de          Ё╠╠
╠╠Ё            Ё        Ё       Ё periculosidade no recibo de abono.      Ё╠╠
╠╠|Claudinei S.|28/04/17|MRH-482|Ajustada FImprAvi() para considerar corre|╠╠
╠╠|            |        |       |tamente as faltas dos funcionАrios com   |╠╠
╠╠|            |        |       |Regime de Tempo Parcial quando elas forem|╠╠
╠╠|            |        |       |inferiores a 8 faltas.                   |╠╠
╠╠юддддддддддддаддддддддадддддддаддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function GPER130(cAlias,nRecno,nOpc,nTpImpFer)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Locais (Basicas)                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local cString		:= "SRA"                // ALIAS DO ARQUIVO PRINCIPAL (BASE)
Local aOrd			:= {STR0001,STR0002,STR0010,STR0009} 	//" Matricula "###" C.Custo + Matric" ### "C.Custo + Nome" ### "Nome"
Local nTotregs,nMult,nPosAnt,nPosAtu,nPosCnt,cSav20,cSav7 // REGUA
Local cDesc1		:= STR0003	//"Aviso / Recibo de F┌rias "
Local cDesc2		:= STR0004	//"Ser═ impresso de acordo com os parametros solicitados pelo"
Local cDesc3		:= STR0005	//"usu═rio."
Local cSavAlias,nSavRec,nSavOrdem
Local lPnm070TamPE	:= ExistBlock( "PNM070TAM" )
Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {"",""} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
Local aFldRel		:= {"RA_NOME","RA_NUMCP","RA_SERCP","RA_ADMISSA"}
Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList(aFldRel) )
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Private(Basicas)                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private aReturn		:= {STR0006, 1,STR0007, 1, 2, 1, "",1 }	// "Zebrado"###"Administra┤└o"
Private nomeprog	:="GPER130"
Private anLinha		:= { },nLastKey := 0
Private cPerg		:="GPR130"
Private aStruSRF	:= {}
Private lImp		:= .F.
Private nTpImp		:= 0
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Private(Programa)                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private cPd13o		:= Space(3)
Private cPd13oMat	:= Space(3)	
Private aCodFol		:= {}     // Matriz com Codigo da folha

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis UtinLizadas na funcao IMPR                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private Titulo		:= STR0008		//"RECIBO E AVISO DE FERIAS"
Private AT_PRG		:= "GPER130"
Private wCabec0		:= 3
Private wCabec1		:= ""
Private wCabec2		:= ""
Private wCabec3		:= ""
Private CONTFL		:= 1
Private nLi			:= 0
Private nTamanho	:= "P"

DEFAULT nTpImpFer	:= 0
DEFAULT cAlias		:= "SRA"
DEFAULT nRecno		:= 0
DEFAULT nOpc		:= 3

If !lBlqAcesso
	
	If nTpImpFer == 1 .And. FindFunction("fConfigSV") .And. fConfigSV()
		IF fCallFerSV(M->RH_FILIAL, M->RH_MAT, M->RH_DATAINI, M->RH_DTRECIB)
			Return
		EndIf
	EndIf
	
	SetMnemonicos(xFilial("RCA"),NIL,.T.,"P_REGPARCI")
	P_REGPARCI	:= If( Type("P_REGPARCI") == "U", .F. , P_REGPARCI)

	cSavAlias := Alias()
	nSavRec   := RecNo()
	nSavOrdem := IndexOrd()

	If lPnm070TamPE
		IF ( ValType( uRetBlock := ExecBlock("PNM070TAM",.F.,.F.))  == "C" )
			nTamanho := uRetBlock
		Endif
	EndIf

	Pergunte("GPR130",.F.)

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Envia controle para a funcao SETPRINT                        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	wnrel:="GPER130"            //Nome Default do relatorio em Disco
	lImp := If(nTpImpFer > 0, .T., .F.)
	If lImp
		nTpImp	:= nTpImpFer
		wnrel:= SetPrint(cString,wnrel,"",@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho,,.F.)
	Else
		wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)
	EndIf

	If nLastKey = 27
		Return
	Endif

 	/*
    ParБmetros do aReturn
    aReturn - Preenchido pelo SetPrint()
    aReturn[1] - Reservado para formulАrio
    aReturn[2] - Reservado para numero de vias
    aReturn[3] - DestinatАrio
    aReturn[4] - Formato 1=Paisagem 2=Retrato
    aReturn[5] - MМdia 1-Disco 2=Impressora
    aReturn[6] √ Porta ou arquivo
    aReturn[7] - ExpressЦo do filtro
    aReturn[8] - Ordem a ser selecionada
    aReturn[9] [10] [n] - Campos a processar se houver
    */
	If IsBlind() .Or. lImp
		aReturn[5] := 1
		aReturn[6] := "GPER130"
	EndIf

	SetDefault(aReturn,cString)

	//Se pressionar -ESC- encerra o programa
	If nLastKey = 27
		Return
	Endif

	RptStatus({|lEnd| GP130Imp(@lEnd,wnRel,cString)},Titulo)

	dbselectarea(cSavAlias)
	dbsetorder(nSavOrdem)
	dbgoto(nSavrec)
Else
	Help(" ",1,aOfusca[3][1],,aOfusca[3][2],1,0)
EndIf

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё GP130imp Ё Autor Ё R.H. - Mauro          Ё Data Ё 26.04.95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Recibo de Ferias                                           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё U_GPER130(void)                                              Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ*/
Static Function GP130IMP(lEnd,WnRel,cString)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Locais (Programa)                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//Arrays
Local aPeriodos  := {}

//Logicas
Local lTemCpoProg
Local lUltSemana
Local lImpFer	 := ExistBlock( "IMPFER",.F.,.T. )//variavel p/ PE "IMPFER"

//Numericas
Local nImprVias
Local nCnt
Local nCntTrf
Local i
Local nPosSem
Local nPosTbFer		:= 0
Local nTempoParc	:= 0

//Strings
Local cRot 			:= ""
Local cTipoRot 		:= ""
Local cPeriodo		:= ""
Local cSemana       := ""
Local cAnoMes       := ""
Local cFiliAtual	:= cFilAnt
Local nImpRecibo	:= 2
Local nImpAviso		:= 2
/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Variaveis de Acesso do Usuario                               Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER130" , "SRA" , "2" ) + " } " )
Local aTransfFun	:= {}

Private nSol13,nSolAb,nRecib,nRecAb,nRec13,cFilDe,cFilAte
Private cMatDe,cMatAte,cCcDe,cCcAte,cNomDe,cNomAte,cDtSt13
Private nFaltas	:= Val_Salmin:=0
Private Salario	:= SalHora := SalDia := SalMes := nSalPg := 0.00
Private lAchou		:= .F.
Private lTransf		:= .F.
Private aInfo		:= {}
Private aTabFer		:= {}    			// Tabela para calculo dos dias de ferias
Private aTabFer2	:= {}				// Tabela para calculo dos dias de ferias para regime de tempo parcial
Private aCodBenef	:= {}
Private nAviso,lImpAv,dDtfDe,dDtfAte,nImprDem, nVias

Private DaAuxI		:= Ctod("//")
Private DaAuxF		:= Ctod("//")
Private cAboAnt		:= If(GetMv("MV_ABOPEC")=="S","1","2") //-- Abono antes ferias
Private cAboPec		:= ""
Private nDBanco
Private lSomLiR		:= .F.
Private aVerbsAbo	:= {}
Private aVerbs13Abo	:= {}
Private nNumAvPg	:= 1 // Quantidade de avisos que serЦo impressos por pАgina
Private nQtdAvImp	:= 0 // Contador de Avisos jА impressos na execuГЦo atual

// VariАvel que indica que foi somente solicitada impressЦo pela VisualizaГЦo das FИrias
If lImp
	Do Case
		Case ( nTpImp == 1 ) ; ( nImpRecibo	:= 1 )	//"Recibo de FИrias"
		Case ( nTpImp == 2 ) ; ( nImpAviso	:= 1 )	//"Aviso de FИrias"
	End Case

	// Alterar Pergunte
	MV_PAR01	:=  2                  //-- Sol. 1╙Parc.13╨ Sal ?
	MV_PAR02	:=  2                  //-- Sol. Abono Pecun. ?
	MV_PAR03	:=  nImpAviso          //-- Aviso de Ferias ?
	MV_PAR04	:=  nImpRecibo            //-- Recibo de Ferias ?
	MV_PAR05	:=  2                  //-- Recibo de Abono ?
	MV_PAR06	:=  2                  //-- Recibo 1╙ Parc. 13╨ ?
	MV_PAR07	:=  1                  //-- Imp. Dt. Rec.Ferias ?
	MV_PAR08	:=  M->RH_DATAINI      //-- Periodo Ferias De ?
	MV_PAR09	:=  M->RH_DATAFIM      //-- Periodo Ferias Ate ?
	MV_PAR10	:=  M->RH_FILIAL       //-- Filial De ?
	MV_PAR11	:=  M->RH_FILIAL       //-- Filial Ate ?
	MV_PAR12	:=  M->RH_MAT          //-- Matricula De ?
	MV_PAR13	:=  M->RH_MAT          //-- Matricula Ate ?
	MV_PAR14	:=  SRA->RA_CC           //-- Centro de Custo De ?
	MV_PAR15	:=  SRA->RA_CC   	       //-- Centro de Custo Ate ?
	MV_PAR16	:=  Replicate("A",30)  //-- Nome De ?
	MV_PAR17	:=  Replicate("Z",30)  //-- Nome Ate ?
	MV_PAR18	:=  CToD("//") 		   //-- Dt. Solicitacao 13╨ ?
	MV_PAR19	:=  1                  //-- N╨ de Vias ?
	MV_PAR20	:=  M->RH_DTRECIB 	   //-- Data de Pagto De ?
	MV_PAR21	:=  M->RH_DTRECIB 	   //-- Data de Pagto Ate ?
	MV_PAR22		:=  2                  //-- Imprime Demitidos ?
	MV_PAR23	:=  15                 //-- Dias Previos P/ Ab. Pecun ?
	MV_PAR24	:=  2                  //-- Impr. dados bancАrios ?
	MV_PAR25	:=  2                  //-- Soma Lic. Rem ?
	MV_PAR26	:=  2                  //-- Imprime 2 avisos por pАgina ?

EndIf

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis Utilizadas para Parametros                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nOrdem  := aReturn[8]
nSol13  := mv_par01     //  SoLic. 1o. Parc. 13o.
nSolAb  := mv_par02     //  SoLic. Abono Pecun.
nAviso  := mv_par03     //  Aviso de Ferias
nRecib  := mv_par04     //  Recibo de Ferias
nRecAb  := mv_par05     //  Recibo de Abono
nRec13  := mv_par06     //  Recibo 1╕ parc. 13o.
nDtRec  := mv_par07     //  Imprime Periodo de Ferias
dDtfDe  := mv_par08     //  Periodo de Ferias De
dDtfAte := mv_par09     //  Periodo de Ferias Ate
cFilDe  := mv_par10     //  FiLial De
cFilAte := mv_par11     //  FiLial Ate
cMatDe  := mv_par12     //  Matricula De
cMatAte := mv_par13     //  Matricula Ate
cCcDe   := mv_par14     //  Centro De Custo De
cCcAte  := mv_par15     //  Centro De Custo Ate
cNomDe  := mv_par16     //  Nome De
cNomAte := mv_par17     //  Nome Ate
dDtSt13 := mv_par18     //  Data SoLic. 13o.
nVias   := mv_par19     //  No. de Vias
dDtPgDe := mv_par20	    //  Data de Pagamento De
dDtPgAte:= mv_par21	    //  Data de Pagamento Ate
nNumAvPg:= IIf(cPaisLoc == "BRA" .And. !Empty(mv_par26) .And. mv_par26 == 1, 2, 1)

If(Empty(dDtSt13) .and. nSol13 == 1 .and. cPaisLoc $ "BRA")
	Aviso(STR0016, STR0014, { STR0015 } )
	MS_FLUSH()
	Return
EndIf
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica a base instalada, se for Brasil utiliza o param,	Ё
//Ё caso contrario, fixa o param como 2 (Nao Imprime Demitidos)	Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nImprDem:= Iif( cPaisLoc == "BRA", mv_par22, 2 )
nDAbnPec:= IiF (cPaisLoc == "BRA", mv_par23, 15)
nDBanco := mv_par24		//  Imprime dados bancАrios
If !Empty(MV_PAR25) // Informa se deve somar os dias de licenГa remunerada ao perМodo de gozo das fИrias.
	If MV_PAR25 == 1
		lSomLiR := .T.
	Else
		lSomLiR := .F.
	Endif
EndIf
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica a existencia dos campos de programacao ferias no SRFЁ
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
lTemCpoProg := fTCpoProg()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Pocisiona No Primeiro Registro Selecionado                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SRA")

If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(8)
ElseIf nOrdem == 4
	dbSetOrder(3)
Endif

If nOrdem == 1
	dbSeek( cFilDe + cMatDe,.T. )
	cInicio  := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim     := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek( cFilDe + cCcDe + cMatDe,.T. )
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim     := cFilAte + cCcAte + cMatAte
ElseIf nOrdem = 3
	dbSeek(cFilDe + cCcDe + cNomDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME"
	cFim     := cFilAte + cCcAte + cNomAte
ElseIf nOrdem = 4
	dbSeek(cFilDe + cNomDe + cMatDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim     := cFilAte + cNomAte + cMatAte
Endif

//--Setar impressora
@ 0,0 psay Avalimp(080)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Carrega Regua de Processamento                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetRegua(RecCount())

While !Eof() .And. &cInicio <= cFim

    nLi:= 0

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Movimenta Regua de Processamento                             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	IncRegua()

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Consiste Parametrizacao do Intervalo de Impressao            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If (SRA->RA_MAT < cMatDe) .Or. (SRA->RA_MAT > cMatAte) .Or. ;
		(SRA->RA_CC  < cCcDe ) .Or. (SRA->RA_CC  > cCcAte) .Or.;
		(SRA->RA_NOME < cNomDe) .Or. (SRA->RA_NOME > cNomAte)
		SRA->(dbSkip(1))
		Loop
	EndIf

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Consiste Situacao do Funcionario                             Ё
	//Ё Inclusao do tratamento para Imprime Demitidos S/N no Brasil. Ё
	//Ё Se nao for Brasil considera-se o param como 2 (Nao imprime)	 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If (SRA->RA_SITFOLH $ "D" .AND. nImprDem <> 1) .Or. ;// 1 - Imprime Demitido = Sim
		(cPaisLoc == "BRA" .And. SRA->RA_CATFUNC $ "A|P")
		SRA->(dbSkip(1))
		Loop
	Endif

	/*
	зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	ЁConsiste Filiais e Acessos                                             Ё
	юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
    If !( SRA->RA_FILIAL $ fValidFil() ) .Or. !Eval( cAcessaSRA )
		dbSelectArea("SRA")
		dbSkip()
		Loop
	EndIF
	cFilAnt := SRA->RA_FILIAL
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//| Carrega tabela para apuracao dos dias de ferias - aTabFer    |
	//| 1-Meses Periodo    2-Nro Periodos   3-Dias do Mes    4-Fator |
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

	cProcesso 	:= SRA->RA_PROCES
	cTipoRot	:= "3"
	cRot 		:= fGetCalcRot(cTipoRot)

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Carrega o periodo atual de calculo (aberto)                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	fGetLastPer( @cPeriodo,@cSemana , cProcesso, cRot , .T., .F., @cAnoMes )

	aPeriodo    := {}
	aVerbsAbo   := {}
	aVerbs13Abo := {}

	//Carrega todos os dados do periodo
	fCarPeriodo( cPeriodo , cRot , @aPeriodo, @lUltSemana, @nPosSem)

	If Len(aPeriodo) > 0
		dDataDe := aPeriodo[nPosSem,3]
		dDataAte := aPeriodo[nPosSem,4]
	EndIf

	fTab_Fer(@aTabFer,,@aTabFer2)

	//Se as horas semanais forem inferiores a 26, e o Mnemonico P_REGPARCI estiver ativo,
	//utiliza os dias de fИrias da tabela S065 - Tabela de fИrias tempo parcial (Artigo 130A da CLT)
	If cPaisLoc == "BRA"
		nTempoParc := SRA->RA_HRSEMAN
		If SRA->RA_HOPARC == "1" .And. nTempoParc <= 25 .And. nTempoParc  > 0 .And. Len(aTabFer2) > 0	.And. P_REGPARCI
			nPosTbFer := Ascan(aTabFer2, { |X|  nTempoParc <= X[6] .And. nTempoParc > X[5] })
			If nPosTbFer > 0
				aTabFer := aClone(aTabFer2[nPosTbFer])
			Endif
		Endif
	EndIf

	lAchou := .F.
	lImpAv := If(nAviso==1 .or. nSolAb==1 .or. nSol13==1,.T.,.F.)   // Imprime Aviso e/ou So.Abono e/ou Sol.1.Parc.13. s/Calcular

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Procura No Arquivo de Ferias o Periodo a Ser Listado         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	dbSelectArea("SRH" )
	If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
		aPeriodos := {}
		While !Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT == SRH->RH_FILIAL + SRH->RH_MAT
			If ( !(cPaisLoc $ "ANG") .And. (SRH->RH_DATAINI >= dDtfDe .And. SRH->RH_DATAINI <= dDtfAte) .And.;
			(SRH->RH_DTRECIB >= dDtPgDe .And. SRH->RH_DTRECIB <= dDtPgAte) ) .OR. ;
			( (cPaisLoc $ "ANG") .And. (SRH->RH_DTRECIB >= dDtPgDe .And. SRH->RH_DTRECIB <= dDtPgAte) )
				AAdd(aPeriodos, Recno() )
			EndIf
			dbSkip()
		Enddo

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime Aviso de Ferias Caso nao tenha calculado             Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If Len(aPeriodos) == 0
			dbSelectArea( "SRA" )
			If lImpAv
				FImprAvi(lTemCpoProg)
			Endif
			dbSelectArea( "SRA" )
			dbSkip()
			Loop
		Endif


        //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        //Ё Carrega InformaГУes das TransferЙncias                       Ё
        //юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
        aTransfFun 	:= {}
        fTransfAll( @aTransfFun,,,.T.)

		For nCnt := 1 To Len(aPeriodos)
			dbSelectArea( "SRH" )
			dbGoTo(aPeriodos[nCnt])


            //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
            //Ё Carrega Matriz Com Dados da Empresa                          Ё
            //юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

            For nCntTrf := 1 To Len(aTransfFun)
                lTranf := .F.
                If  aTransfFun[nCntTrf][7]>SRH->RH_DATAFIM
                    fInfo(@aInfo, aTransfFun[nCntTrf][8])
                    lTransf := .T.
                    Exit
                Endif
            Next cCntTrf

            If !lTransf
                fInfo(@aInfo,SRA->RA_FILIAL)
            Endif



			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Carrega Variaveis Codigos da Folha                           Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If !FP_CODFOL(@aCodFol,SRA->RA_FILIAL)
				Return
			Endif

			DaAuxI := SRH->RH_DATAINI
			DaAuxF := SRH->RH_DATAFIM

			If nRec13 == 1
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Monta a Variavel na Lista Para Nao Aparecer Recibo de Ferias Ё
				//Ё e Sim No Recibo De Abono e 13o.                              Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				cPd13o		:= aCodFol[22,1]
				cPd13oMat	:= aCodFol[1434,1]
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Busca os codigos de pensao definidos no cadastro beneficiarioЁ
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				fBusCadBenef(@aCodBenef, "131", {aCodfol[172,1]})
			Endif

			If nRecAb == 1 .AND. Empty(aVerbsAbo)

				//Verbas encontradas no GPEXIDC.PRX com 'abono' na descricao
				//
				aAdd(aVerbsAbo, aCodFol[74,1])
				aAdd(aVerbsAbo, aCodFol[205,1])
				aAdd(aVerbsAbo, aCodFol[617,1])
				aAdd(aVerbsAbo, aCodFol[622,1])
				aAdd(aVerbsAbo, aCodFol[623,1])

				For i := 632 To 635
					aAdd(aVerbsAbo, aCodFol[i,1])
				Next

				//Verbas encontradas no GPEXIDC1.PRX com 'abono' na descricao
				//
				For i := 1312 To 1327
					aAdd(aVerbsAbo, aCodFol[i,1])
				Next

				aAdd(aVerbsAbo, aCodFol[1330,1])
				aAdd(aVerbsAbo, aCodFol[1331,1])

				aAdd(aVerbsAbo, aCodFol[1407,1])
				aAdd(aVerbsAbo, aCodFol[1408,1])
				aAdd(aVerbsAbo, aCodFol[1409,1])
				aAdd(aVerbsAbo, aCodFol[1410,1])

				aAdd(aVerbs13Abo, aCodFol[79,1])
				aAdd(aVerbs13Abo, aCodFol[206,1])

			Endif

			lAchou := .T.
			nQtdAvImp := 0
			For nImprVias := 1 to nVias
				if lImpFer
					ExecBlock("IMPFER",.F.,.F.)
				else
					GPER990()
				endif
			Next nImprVias
			lImpAv := .F.
	    Next nCnt
    EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime Aviso de Ferias Caso nao tenha calculado             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If lImpAv
		FImprAvi(lTemCpoProg)
	Endif

	dbSelectArea("SRA")
	dbSkip()
Enddo
cFilAnt := cFiliAtual
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Termino do relatorio                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SRA")
Set Filter to
dbsetorder(1)

Set Device To Screen
If aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()

*-----------------------------
Static Function FImprAvi(lTemCpoProg)
*-----------------------------
Local dDtIniProg,nDiasAbono,nDiasFePro,nDiasDedFer,nPerc13Prog
Local nImprVias
Local cQry		:= ""
Local cData		:= dtos(dDtfDe)
Local cData1	:= dTos(dDtfAte)
Local nX		:= 1
Local nProg 	:= 0
Local lImpFer	 := ExistBlock( "IMPFER",.F.,.T. )//variavel p/ PE "IMPFER"
Local nDMes12  	:= 0
Local nDMes01 	:= 0
Local cDia2501  := SuperGetMv("MV_DIA2501", ,"N")
Local nDFerOrig	:= 0
Local nSaldoFer	:= 0
Local nFerAnt 	:= 0

Static lTemRF13

DEFAULT lTemRF13 := SRF->( ColumnPos( "RF_PER13S2" ) ) > 0

lMetadeFal := If( Type("lMetadeFal") == "U", .F. , lMetadeFal)
lTempoParc := If( Type("lTempoParc") == "U", .F. , lTempoParc)

If nAviso==1 .or. nSolAb==1 .or. nSol13==1 // Imprimi Aviso e/ou Sol.Abono e/ou Sol1.Parc.13. sem calcular

	aStruSRF  := If(Empty(aStruSRF),SRF->(dbStruct()),aStruSRF)

	cQry := GetNextAlias()
	BEGINSQL ALIAS cQry
			SELECT *
			FROM %table:SRF% SRF
			WHERE SRF.%notDel%
			AND RF_FILIAL= %exp:SRA->RA_FILIAL%
			AND RF_MAT=%exp:SRA->RA_MAT%
			AND RF_STATUS=%exp:'1'%
			AND ( (RF_DATAINI BETWEEN %exp:cData% AND %exp:cData1%) OR (RF_DATINI2 BETWEEN %exp:cData% AND %exp:cData1%)  OR (RF_DATINI3 BETWEEN %exp:cData% AND %exp:cData1%))
			ORDER BY RF_DATABAS
	ENDSQL
	For nX := 1 To Len(aStruSRF)
		If ( aStruSRF[nX][2] <> "C" )
			TcSetField(cQry,aStruSRF[nX][1],aStruSRF[nX][2],aStruSRF[nX][3],aStruSRF[nX][4])
		EndIf
	Next nX

	//-- Verifica se no Arquivo SRF Existe Periodo de Ferias
	If !(cQry)->(Eof())
		nFerAnt := 0
		For nProg := 1 to 3
			dDtIniProg := CTOD("")
			nDiasFePro := 0
			nDiasAbono := 0
			nPerc13Prog:= 0

			If nProg == 1
				If (cQry)->RF_DATAINI >= dDtfDe .And. (cQry)->RF_DATAINI <= dDtfAte
					dDtIniProg := (cQry)->RF_DATAINI
					nDiasFePro := If(lTemCpoProg, (cQry)->RF_DFEPRO1, 0)
					nDiasAbono := If(lTemCpoProg, (cQry)->RF_DABPRO1, 0)
					nPerc13Prog:= (cQry)->RF_PERC13S
				EndIf
			EndIf
			If lTemCpoProg
				If nProg == 2
					If (cQry)->RF_DATINI2 >= dDtfDe .And. (cQry)->RF_DATINI2 <= dDtfAte
						dDtIniProg := (cQry)->RF_DATINI2
						nDiasFePro := (cQry)->RF_DFEPRO2
						nDiasAbono := (cQry)->RF_DABPRO2
						nPerc13Prog:= If(lTemRF13, (cQry)->RF_PER13S2,(cQry)->RF_PERC13S)
					EndIf
				EndIf
				If nProg == 3
					If (cQry)->RF_DATINI3 >= dDtfDe .And. (cQry)->RF_DATINI3 <= dDtfAte
						dDtIniProg := (cQry)->RF_DATINI3
						nDiasFePro := (cQry)->RF_DFEPRO3
						nDiasAbono := (cQry)->RF_DABPRO3
						nPerc13Prog:= If(lTemRF13, (cQry)->RF_PER13S3,(cQry)->RF_PERC13S)
					EndIf
				EndIf
			EndIf
			If !Empty(dDtIniProg)
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Carrega Matriz Com Dados da Empresa                          Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				fInfo(@aInfo,SRA->RA_FILIAL)
				nDferven := nDferave := 0
				If (cQry)->RF_DVENPEN > 0 .And. !Empty((cQry)->RF_IVENPEN)
					M->RH_DATABAS := (cQry)->RF_IVENPEN
					M->RH_DBASEAT := (cQry)->RF_FVENPEN
					nDferven       := (cQry)->RF_DVENPEN
					nSaldoFer     := (cQry)->RF_DVENPEN
				Else
					M->RH_DATABAS := (cQry)->RF_DATABAS
					M->RH_DBASEAT := If( Empty((cQry)->RF_DATAFIM), fCalcFimAq((cQry)->RF_DATABAS), (cQry)->RF_DATAFIM )
					nSaldoFer     := (cQry)->RF_DFERVAT

					If nDiasFePro > 0
						nDferven := nDiasFePro
					Else
						//Calc_Fer(SRF->RF_DATABAS,dDatabase,@nDferven,@nDferave)
						nDferven := (cQry)->RF_DFERVAT
						nDferven := If (nDferVen <= 0,nDferave,nDferven)
					EndIf
				EndIf

				nDiasAviso 		:= GetNewPar("MV_AVISFER",aTabFer[3])  // Dias Aviso Ferias

				If !empty((cQry)->RF_ABOPEC)
					cAboPec := (cQry)->RF_ABOPEC
				Else
					cAboPec := cAboAnt		//-- cAboPec = 1 -> considera abono antes do periodo de gozo de ferias
				EndIf

				M->RH_DTAVISO  := fVerData(dDtIniProg - (If (nDiasAviso > 0, nDiasAviso,aTabFer[3])))
				M->RH_DFERIAS  := If( nDFerven > aTabFer[3] , aTabFer[3] , nDFerven )
				nDFerOrig	   := M->RH_DFERIAS
				M->RH_DTRECIB  := If(cAboPec=="1" .and. nDiasAbono > 0,DataValida(DataValida((dDtIniProg-nDiasAbono)-1,.F.)-1,.F.), DataValida(DataValida(dDtIniProg-1,.F.)-1,.F.))
				M->RF_TEMABPE  := (cQry)->RF_TEMABPE

				If (cQry)->RF_TEMABPE == "S" .And. !lTemCpoProg
					M->RH_DFERIAS -= If(nDiasAbono > 0, nDiasAbono, 10)
				Endif

				//--Abater dias de ferias Antecipadas
				If (cQry)->RF_DFERANT > 0
					M->RH_DFERIAS := Min(M->RH_DFERIAS, aTabFer[3]-(cQry)->RF_DFERANT)
				Endif

				// Abate Faltas  do cad. Provisoes
				If ( (cQry)->RF_DFALVAT + (cQry)->RF_DFALAAT ) > 5
					nDFaltaV := (cQry)->RF_DFALVAT + (cQry)->RF_DFALAAT
					TabFaltas(@nDFaltaV)

					If (nDFaltaV > 0 .And. nDiasAbono > 0 )

					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё  Se tiver faltas e abono, calcular os dias de ferias\abono proporcional as faltas.|
					//Ё	 Exemplo: 20 dias ferias                                                          |
					//Ё	          10 dias de abono e                                                      |
					//Ё 		  10 Faltas = deduzir 6 dias das ferias. 		 					      |
					//Ё           Regra do abono: 1/3 dos dias de ferias.                                 |
					//Ё			  Como funcionario teve 10 faltas, ele tem direito a apenas 24 dias de    |
					//Ё           ferias, e nao 30. Os dias de feria e abono devem ser proporcionais aos  |
					//Ё           dias de direito de ferias.                                              |
					//Ё           Dias de Direito = 24													  |
					//Ё           Dias de Abono   =  8 (24 / 3 = 1/3 dos dias de direito )                |
					//Ё           Dias de Ferias  = 16 (24 - 8 dias de abono) 							  |
					//Ё           Total de Ferias + Abono  = 24 Dias 									  |
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					
						M->RH_DFERIAS := nDiasFePro - ( ( nDFaltaV / nSaldoFer ) * nDiasFePro )	
					Else
						M->RH_DFERIAS := Min(M->RH_DFERIAS,(nSaldoFer - nDFaltaV - nFerAnt))
					EndIf
				Endif

				M->RH_PERC13S := nPerc13Prog

				DaAuxI := dDtIniProg
				DaAuxF := dDtIniProg + M->RH_DFERIAS - 1

				If cDia2501 == 'S'
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Verifica se Deve Considerar dias 24/12, 25/12, 31/12 e 01/01 Ё
					//| como licenca remunerada.                                     |
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					fChkLicRem( dDtIniProg, DaAuxF, @nDMes12, @nDMes01, cDia2501)
					If nDMes12 + nDMes01 > 0
						DaAuxF += nDMes12 + nDMes01
					EndIf
				Endif
				
				//Imprime relatСrio se dias calculados for POSITIVO ou em caso NEGATIVO, validar com os dias de direito
				If M->RH_DFERIAS > 0 .Or. (M->RH_DFERIAS <= 0 .And. aTabFer[3]+M->RH_DFERIAS > 0)
					If M->RH_DFERIAS <= 0
						M->RH_DFERIAS := Iif(nDFerOrig > aTabFer[3]+M->RH_DFERIAS, aTabFer[3]+M->RH_DFERIAS, nDFerOrig)
					EndIf
					nQtdAvImp := 0
					For nImprVias := 1 to nVias
						if lImpFer
							ExecBlock("IMPFER",.F.,.F.)
						else
							GPER990()
						endif
					Next
				Endif
				nFerAnt += M->RH_DFERIAS
			EndIf
		Next nProg
	Endif
	(cQry)->(dbCloseArea())
Endif

Return

/*/
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁFAbPecun	╨Autor  ЁGustavo M.			 ╨ Data Ё  22/06/2012 ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁAjuste de  perguntas.                                       ╨╠╠
╠╠╨          Ё                                                            ╨╠╠                                                k
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё GPER130                                                    ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠ /*/

User Function FAbPecun()

IF MV_PAR23 < 15
	MsgInfo( OemToAnsi(STR0012) )
	MV_PAR23 := 15
Endif

Return

/*/
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммямммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁG130ValData╨Autor  ЁEquipe RH           ╨ Data Ё  25/07/2014 ╨╠╠
╠╠лммммммммммьмммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁCompara datas                                                ╨╠╠
╠╠╨          Ё                                                             ╨╠╠                                                k
╠╠лммммммммммьммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё GPER130                                                     ╨╠╠
╠╠хммммммммммоммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠ /*/

User Function G130ValD(dDataIni, dDataFim)
	Local lRet

	If !Empty(dDataFim)
		lRet := dDataFim >= dDataIni

		If !lRet
			MsgInfo( STR0013 )
		Endif
	EndIf

Return lRet
