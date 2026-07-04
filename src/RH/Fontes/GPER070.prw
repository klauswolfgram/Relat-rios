/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GPER1070.CH"
#INCLUDE "PROTHEUS.CH"

STATIC lItemClvl := SuperGetMv("MV_ITMCLVL", .F., "2") $ "13" // VERIFICA SE UTILIZA ITEM CONTÁBIL E CLASSE DE VALOR
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER070  ³ Autor ³ Emerson Rosa de Souza ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao da Provisao de Ferias                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER070(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³PROGRAMADOR ³ DATA	³CHAMADO/REQ³  MOTIVO DA ALTERACAO                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Mohanad Odeh³20/12/13³RQ1020     ³UNIFICACAO DA FOLHA V12              ³±±
±±³            ³        ³M12RH01    ³                                     ³±± 
±±³Christiane V³17/04/14³M12RH01    ³UNIFICACAO DA FOLHA V12              ³±±
±±³            ³        ³RQ1021     ³                                     ³±± 
±±³Allyson M   ³24/07/14³TPZKBZ	    ³Ajuste p/ ordenacao e quebra do      ³±±
±±³	       	   ³  		³  	    	³relatorio por CC, Item e Classe.	  ³±±
±±³Renan Borges³14/01/15³TRHITA	    ³Ajuste para imprimir os relatórios de³±±
±±³			   ³		³			³provisão de férias e de 13° correta- ³±±
±±³			   ³		³			³mente quando o país for Brasil, inde-³±±
±±³			   ³		³			³pendentemente do parâmetro MV_CENT.  ³±±
±±³Victor A.   ³02/05/16³TUKZ84	    ³Ajuste para imprimir os dias de      ³±±
±±³			   ³		³			³férias corretamente quando a pergunta³±±
±±³			   ³		³			³Forma de Apresentação for igual a    ³±±
±±³			   ³		³			³"Resumida" 						  ³±±
±±³Renan Borges³24/06/16³TVIRBJ	    ³Ajuste para gerar relatório de provi-³±±
±±³			   ³		³			³são de férias apresentando os dias de³±±
±±³			   ³		³			³direitos nos campos de faltas e de to³±±
±±³			   ³		³			³tais corretamente.                   ³±±
±±ºRenan Borges³03/01/17³MRH-3280   ³Ajuste para imprimir relatorio Mensalº±±
±±º            ³        ³           ³com rateio com os valores na linha   º±±
±±º            ³        ³           ³certa.                               º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER070()
Local cString :="SRA"        	    // alias do arquivo principal (Base)
Local aAreaSRA:= SRA->( GetArea() )
Local aOrd	  := {STR0001,STR0002,STR0003,STR0004} //"Matricula"###"C.Custo"###"Nome"###"C.Custo+Nome"
Local cDesc1  := STR0005			//"Emiss„o da Provis„o de F‚rias."
Local cDesc2  := STR0006			//"ser  impresso de acordo com os parametros solicitados"
Local cDesc3  := STR0007			//"pelo usu rio."
Private aReturn  := {STR0008, 1,STR0009, 2, 2, 1, "",1 }		// "Zebrado"###"Administra‡„o"
Private nomeprog := "GPER070"
Private nLastKey := 0
Private cPerg	 := "GPR070"
Private cPict1  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 999,999,999.99",TM(999999999,14,MsDecimais(1)))  // "@E 99,999,999,999.99
Private cPict2  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 999999999.99"  ,TM(999999999,12,MsDecimais(1)))  // "@E 999999999.99
Private cPict3  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 9999999999.99" ,TM(9999999999,13,MsDecimais(1)))  // "@E 9999999999.99
Private cPict4  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 99999999999.99",TM(99999999999,14,MsDecimais(1)))  // "@E 99999999999.99
Private cPict5  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 9999999.99"  ,TM(9999999,10,MsDecimais(1)))  		// "@E 9999999.99
//VARIAVEIS UTILIZADAS NA FUNCAO IMPR
Private Titulo	 := STR0010			//"PROVISO DE FERIAS "
Private AT_PRG	 := "GPER070"
Private wCabec0  := 1
Private wCabec1  := STR0011 //"Data Base: "
Private CONTFL   :=1
Private LI		 :=0
Private nTamanho :="M"
Private lItemClVl:= SuperGetMv( "MV_ITMCLVL", .F., "2" ) $ "13"	// Determina se utiliza Item Contabil e Classe de Valores

Private aFldRot 	:= {'RA_NOME'}
Private aOfusca	 	:= If(FindFunction('ChkOfusca'), ChkOfusca(), {.T.,.F.}) //[1] Acesso; [2]Ofusca
Private lOfuscaNom 	:= .F. 
Private aFldOfusca	:= {}

If aOfusca[2]
	aFldOfusca := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRot ) // CAMPOS SEM ACESSO
	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_NOME" } ) > 0
		lOfuscaNom := FwProtectedDataUtil():IsFieldInList( "RA_NOME" )
	ENDIF
ENDIF

TCInternal(5,"*OFF") //DESLIGA REFRESH NO LOCK DO TOP

If lItemClVl
	aAdd( aOrd, STR0076 ) // "C.Custo + Item + Classe"
EndIf

If Type("cFilAntBkp") <> "U"
	cFilAnt := cFilAntBkp
	SM0->( DbSeek(cEmpAnt+cFilAnt) )
EndIf

//VERIFICA AS PERGUNTAS SELECIONADAS
pergunte("GPR070",.F.)

//ENVIA CONTROLE PARA A FUNCAO SETPRINT
wnrel:="GPER070"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

//CARREGA VARIAVEIS PRIVATES COMUNS A GPEA070,GPER070 E GPEM070
GPEProvisao(wnRel,cString,Titulo,,2)

RestArea( aAreaSRA )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GP070imp ³ Autor ³ Emerson Rosa de Souza ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Provisao de Ferias                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GP070Imp(lEnd,WnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GP070IMP(lEnd,WnRel,cString)
Local cMapa       := 0
Local nLaco       := nByte := 0
Local cMascCus    := GetMv( "MV_MASCCUS" ) // Mascara do p/Niveis do C.Custo
Local cAcessaSRA  := "{ || " + ChkRH("GPER070","SRA","2") + "}"
Local aAreaSRA    := SRA->(GetArea())
Local nQ
Local nCnt2
Local nCnt1
Local nTemVal
Local lCalcula    := .T.
Local lFerias     := .T.
Local l13oSal     := .F.
Local cFiltro070	 := aReturn[7]
Private aFerVenc     := Array(_Linhas,_Colunas)
Private aFerProp     := Array(_Linhas,_Colunas)
Private aTotVePr     := Array(_Linhas,_Colunas)
Private aCabProv     := {}
Private aVerba  	 := {}
Private aTransf      := {}
Private aTotCc1      := {}
Private aTotCc2      := {}
Private aTotCc3      := {}
Private aTotFil1     := {}
Private aTotFil2     := {}
Private aTotFil3     := {}
Private aTotEmp1     := {}
Private aTotEmp2     := {}
Private aTotEmp3     := {}
Private aInfo	     := {}
Private aCodFol  	 := {}
Private aNiveis      := {} // Niveis do Centro de Custo
Private lQuebraCC  	 := .F.
Private lQuebraFil   := .F.
Private lSalInc    	 := .F.
Private lTrataTrf    := .F.
Private lCalcPis	 := .F.
Private nTamCC		 := TamSX3("RA_CC")[1]
//CARREGA VARIAVEIS MV_PARXX PARA VARIAVEIS DO SISTEMA

//Faz o tratamento abaixo pois o relatorio de rateio mensal da provisao ja utiliza a ordem 5
If IsInCallStack("GP056FER") //Se foi chamado pelo relatório de provisão rateada, altera o número da ordem pois as ordens de centro de custo e centro de custos mais nome foram excluídas.
	nOrdem		:= Iif( aReturn[8] == 2 , 3, If( aReturn[8] == 3, 5, aReturn[8] ) )
Else
	//Faz o tratamento abaixo pois o relatorio de rateio mensal da provisao ja utiliza a ordem 5
	nOrdem		:= Iif( IsInCallStack("GPER070") .And. aReturn[8] == 5 , 6, aReturn[8] )
EndIf
dDataRef   	:= mv_par01                             // Data de Referencia
cFilDe	   	:= mv_par02								//	Filial De
cFilAte    	:= mv_par03								//	Filial Ate
cCcDe	   	:= mv_par04								//	Centro de Custo De
cCcAte	   	:= mv_par05								//	Centro de Custo Ate
cMatDe	   	:= mv_par06								//	Matricula De
cMatAte     := mv_par07								//	Matricula Ate
cNomeDe     := mv_par08								//	Nome De
cNomeAte    := mv_par09								//	Nome Ate
nAnaSin     := mv_par10								//	Analitica / Sintetica
nGerRes     := mv_par11								//	Geral / Resumida
lImpNiv     := If(mv_par12 == 1,.T.,.F.)		    //  Imprimir Niveis C.Custo
cCateg	    := mv_par13								//	Categorias (Utilizada em fMonta_TPR)
lQuebraCC	:= Iif(ValType(mv_par14) == "N" .And. mv_par14 == 1, .T., .F.)//  Salta Pag. quebra C.Custo: 1=Sim; 2=Nao
lQuebraFil	:= Iif(ValType(mv_par15) == "N" .And. mv_par15 == 1, .T., .F.)//  Salta Pag. quebra Filial: 1=Sim; 2=Nao

Titulo  := STR0012+If(nAnaSin==1,STR0013,STR0014)+;		//"RELACAO DE PROVISAO DE FERIAS "###"ANALITICA"###"SINTETICA"
               " "+If(nGerRes == 1,STR0015,STR0016)		//"(GERAL)"###"(RESUMIDA)"

wCabec1 += Dtoc(dDataRef)
//aNiveis-ARMAZENA AS CHAVES DE QUEBRA
If lImpNiv
	aNiveis:= MontaMasc(cMascCus)
	//CRIAR OS ARRAYS COM OS NIVEIS DE QUEBRAS
    For nQ := 1 to Len(aNiveis)
        cQ := cValToChar(NQ)
        Private aTotCc1&cQ   := {} // Niveis dos Centro de Custo
        Private aTotCc2&cQ   := {}
		Private aTotCc3&cQ   := {}
        cCcAnt&cQ            := "" // Variaveis c.custo dos niveis de quebra
    Next nQ
Endif

//MONTA O ARQUIVO TEMPORARIO "TPR" A PARTIR DO SRA E SRE
Processa({ || fMonta_TPR("","",nOrdem,dDataRef,@lSalInc,@lTrataTrf,@aTransf,,cAcessaSRA,,, ,cFiltro070)},STR0010) //"PROVISO DE FERIAS "
                             
dbSelectArea("SRA")
dbSetOrder(1)

dbSelectArea(cTBLXPROV)
dbGoTop()

//CARREGA REGUA DE PROCESSAMENTO
SetRegua( RecCount() )
cFilialAnt := Replicate("!", FWGETTAMFILIAL)
cCcAnt	   := "!!!!!!!!!"
While !Eof()
	IncRegua() 	//MOVIMENTA REGUA DE PROCESSAMENTO
	//GARANTE O POSICIONAMENTO DO FUNCIONARIO NO SRA
	dbSelectArea("SRA")
	dbSeek((cTBLXPROV)->PR_FILIAL + (cTBLXPROV)->PR_MAT)
	dbSelectArea(cTBLXPROV)
	If lEnd
		@Prow()+1,0 PSAY cCancel
   		Exit
    Endif
	If (cTBLXPROV)->PR_FILIAL # cFilialAnt //QUEBRA DE FILIAL       
		If !Fp_CodFol(@aCodFol,(cTBLXPROV)->PR_FILIAL) .Or.;
		   !fInfo(@aInfo,(cTBLXPROV)->PR_FILIAL)
			Exit
		Endif
		cFilialAnt := (cTBLXPROV)->PR_FILIAL
		//CARREGA OS IDENTIFICADORES DA PROVISAO
		fIdentProv(@aVerba,aCodFol,.T.,.F.)
		//VERIFICA A EXISTENCIA DOS IDENTIFICADORES DO PIS
		lCalcPis := (!Empty(aCodFol[416,1]))
	Endif
	//LIMPA O ARRAY COM O CONTEUDO ESPECIFICADO NO 2º PARAMETRO
	fLimpaArray(@aTotVePr, 0)
	//BUSCA INFORMACOES DE CABECALHO NO SRT
	If !fBusCabSRT(dDataRef,@aCabProv)
		fTestaTotal(_FerVenc)
		Loop
	EndIf

	//BUSCA OS LANCAMENTOS DE FERIAS VENCIDAS E PROPORCIONAIS
	fQryDetSRT(aVerba,aTransf,dDataRef,lTrataTrf,lCalcula,lFerias,l13oSal)

	nTemVal := 0 //Se não possui valores de férias para o Centro de custo, é porque foi gerado para dar baixa no rateio do mês posterior, neste caso, não irá imprimir as informações do Centro de Custos
	
	//TOTALIZADOR -> VENCIDAS + PROPORCIONAIS
	For nCnt1 := 1 To _Linhas
		For nCnt2 := 1 To _Colunas
			aTotVePr[nCnt1,nCnt2] := aFerVenc[nCnt1,nCnt2]+aFerProp[nCnt1,nCnt2]
			nTemVal += aFerVenc[nCnt1,nCnt2]+aFerProp[nCnt1,nCnt2]
		Next nCnt2
	Next nCnt1

	//TOTALIZADORES DOS NIVEIS DE QUEBRA
	If nOrdem != 6 // Nao imprime niveis de c.custo na ordem de item + classe
		fTotNivCC(aFerVenc, aFerProp, aTotVePr) 							    // Niveis do Centro de Custo
	EndIf
	fAtuCont(@aToTCc1 , @aTotCc2 , @aTotCc3, aFerVenc, aFerProp, aTotVePr)  // Centro de Custo
	fAtuCont(@aTotFil1, @aTotFil2, @aTotFil3, aFerVenc, aFerProp, aTotVePr) // Filial
	fAtuCont(@aTotEmp1, @aTotEmp2, @aTotEmp3, aFerVenc, aFerProp, aTotVePr) // Empresa
	
	If nAnaSin == 1 .and. (nTemVal > 0 .Or. !IsInCallStack("GP056FER")) //Imprime apenas se existir valores no mês
		fImpFunFer() //IMPRIME O FUNCIONARIO
	EndIf	
	fTestaTotal(_FerVenc) //QUEBRAS E SKIPS
Enddo

//TERMINO DO RELATORIO
dbSelectArea("SRA")
Set Filter To
dbSetOrder(1)

If aReturn[5] == 1
	Set Printer To
	ourspool(wnrel)
EndIf

MS_FLUSH()

(cTBLXPROV)->(dbCloseArea())

//Elimina arquivo temporário de provisão
fDelTMPPRV()

//RETORNA AREA ORIGINAL DO CADASTRO DE FUNCIONARIOS
RestArea(aAreaSRA)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER090  ³ Autor ³ Emerson Rosa de Souza ³ Data ³ 25.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Provisao de 13º Salario                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER090(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER090()
Local cString := "SRA"        			// Alias do arquivo principal (Base)
Local aAreaSRA:= SRA->( GetArea() )
Local aOrd	  := {STR0001,STR0002,STR0003,STR0004}   //"Matricula"###"C.Custo"###"Nome"###"C.Custo+Nome"
Local cDesc1  := STR0059				//"Emiss„o de Provis„o de 13o Salario."
Local cDesc2  := STR0006				//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3  := STR0007				//"usu rio."
Private cPict1  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 999,999,999.99",TM(999999999,14,MsDecimais(1)))  // "@E 99,999,999,999.99
Private cPict2  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 999999999.99"  ,TM(999999999,12,MsDecimais(1)))  // "@E 999999999.99
Private cPict3  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 9999999999.99" ,TM(9999999999,13,MsDecimais(1)))  // "@E 9999999999.99
Private cPict4  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 99999999999.99",TM(99999999999,14,MsDecimais(1)))  // "@E 99999999999.99
Private cPict5  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 9999999.99"  ,TM(9999999,10,MsDecimais(1)))  		// "@E 9999999.99
Private aReturn  := {STR0008,1,STR0009, 2, 2, 1, "",1 }		// "Zebrado"###"Administra‡„o"
Private NomeProg := "GPER090"
Private nLastKey := 0
Private cPerg	 := "GPR090"
//VARIAVEIS UTILIZADAS NA FUNCAO IMPR
Private Titulo	 := STR0058		//"PROVISO DE 13o SALARIO"
Private AT_PRG	 := "GPER090"
Private wCabec0  := 1
Private wCabec1  := STR0011	//"Data Base: "
Private CONTFL	 := 1
Private LI		 := 0
Private nTamanho := "M"
Private lItemClVl:= SuperGetMv( "MV_ITMCLVL", .F., "2" ) $ "13"	// Determina se utiliza Item Contabil e Classe de Valores

TCInternal(5,"*OFF") //DESLIGA REFRESH NO LOCK DO TOP

If lItemClVl
	aAdd( aOrd, STR0076 ) // "C.Custo + Item + Classe"
EndIf

If Type("cFilAntBkp") <> "U"
	cFilAnt := cFilAntBkp
	SM0->( DbSeek(cEmpAnt+cFilAnt) )
EndIf

Pergunte("GPR090",.F.) //VERIFICA AS PERGUNTAS SELECIONADAS

//ENVIA CONTROLE PARA A FUNCAO SETPRINT
wnrel := "GPER090"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

//CARREGA VARIAVEIS PRIVATES COMUNS A GPEA070,GPER070 E GPEM070
GPEProvisao(wnRel,cString,Titulo,,3)

RestArea( aAreaSRA )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GP090imp ³ Autor ³ Emerson Rosa de Souza ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Provisao de 13º Salario                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GP090Imp(lEnd,WnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GP090IMP(lEnd,WnRel,cString)
Local cMapa      := 0
Local nLaco      := nByte := 0
Local cMascCus   := GetMv( "MV_MASCCUS" ) // Mascara do p/Niveis do C.Custo
Local cAcessaSRA := "{ || " + ChkRH("GPER090","SRA","2") + "}"
Local aAreaSRA   := SRA->(GetArea())
Local nQ
Local nCnt2
Local nCnt1
Local lCalcula    := .T.
Local lFerias     := .F.
Local l13oSal     := .T.
Local cFiltro070	:= aReturn[7]
Private a13Salar     := Array(_Linhas,_Colunas)
Private a14Salar     := Array(_Linhas,_Colunas)
Private aTot1314     := Array(_Linhas,_Colunas)
Private aCabProv     := {}
Private aVerba  	 := {}
Private aTransf      := {}
Private aTotCc1      := {}
Private aTotCc2      := {}
Private aTotCc3      := {}
Private aTotFil1     := {}
Private aTotFil2     := {}
Private aTotFil3     := {}
Private aTotEmp1     := {}
Private aTotEmp2     := {}
Private aTotEmp3     := {}
Private aInfo	     := {}
Private aCodFol  	 := {}
Private aNiveis      := {} // Niveis do Centro de Custo
Private lQuebraCC  	 := .F.
Private lQuebraFil   := .F.
Private lTrataTrf    := .F.
Private lSalInc    	 := .F.
Private lCalcPis	 := .F.
Private nTamCC		 := TamSX3("RA_CC")[1]
//CARREGANDO VARIAVEIS MV_PARXX PARA VARIAVEIS DO SISTEMA

If IsInCallStack("GP056DEC") //Se foi chamado pelo relatório de provisão rateada, altera o número da ordem pois as ordens de centro de custo e centro de custos mais nome foram excluídas.
	//Faz o tratamento abaixo pois o relatorio de rateio mensal da provisao ja utiliza a ordem 5
	nOrdem		:= Iif( aReturn[8] == 2 , 3, If( aReturn[8] == 3, 5, aReturn[8] ) )
Else
	//Faz o tratamento abaixo pois o relatorio de rateio mensal da provisao ja utiliza a ordem 5
	nOrdem		:= Iif( IsInCallStack("GPER090") .And. aReturn[8] == 5 , 6, aReturn[8] )
EndIf
dDataRef   	:= mv_par01                             // Data de Referencia
cFilDe	   	:= mv_par02								//	Filial De
cFilAte    	:= mv_par03								//	Filial Ate
cCcDe	   	:= mv_par04								//	Centro de Custo De
cCcAte	   	:= mv_par05								//	Centro de Custo Ate
cMatDe	   	:= mv_par06								//	Matricula De
cMatAte     := mv_par07								//	Matricula Ate
cNomeDe     := mv_par08								//	Nome De
cNomeAte    := mv_par09								//	Nome Ate
nAnaSin     := mv_par10								//	Sintetica / Analitica
nGerRes     := mv_par11								//	Resumida  / Geral
lImpNiv     := If(mv_par12 == 1,.T.,.F.)		    //  Imprimir Niveis C.Custo
cCateg	    := mv_par13								//	Categorias (Utilizada em fMonta_TPR)
lQuebraCC	:= Iif(ValType(mv_par14) == "N" .And. mv_par14 == 1, .T., .F.)//  Salta Pag. quebra C.Custo: 1=Sim; 2=Nao
lQuebraFil	:= Iif(ValType(mv_par15) == "N" .And. mv_par15 == 1, .T., .F.)//  Salta Pag. quebra Filial: 1=Sim; 2=Nao

Titulo  := STR0060+If(nAnaSin==1,STR0013,STR0014)+;		//"RELACAO DE PROVISAO DE 13o SALARIO "###"ANALITICA"###"SINTETICA"
               " "+If(nGerRes == 1,STR0015,STR0016)		//"(GERAL)"###"(RESUMIDA)"
wCabec1 += Dtoc(dDataRef)

//aNiveis - ARMAZENA AS CHAVES DE QUEBRA
If lImpNiv
	aNiveis:= MontaMasc(cMascCus)
	//CRIAR OS ARRAYS COM OS NIVEIS DE QUEBRAS
	For nQ := 1 to Len(aNiveis)
        cQ := cValToChar(NQ)
        Private aTotCc1&cQ   := {} // Niveis dos Centro de Custo
        Private aTotCc2&cQ   := {}
	    Private aTotCc3&cQ   := {}
        cCcAnt&cQ            := "" // Variaveis c.custo dos niveis de quebra
    Next nQ
Endif

//MONTA O ARQUIVO TEMPORARIO "TPR" A PARTIR DO SRA E SRE
Processa({ || fMonta_TPR("","",nOrdem,dDataRef,@lSalInc,@lTrataTrf,@aTransf,,cAcessaSRA,,, ,cFiltro070)},STR0058) //"PROVISO DE 13º SALARIO"

dbSelectArea("SRA")
dbSetOrder(1)

dbSelectArea(cTBLXPROV)
dbGoTop()

//CARREGA REGUA DE PROCESSAMENTO
SetRegua(RecCount())
cFilialAnt := Replicate("!",FWGETTAMFILIAL)
cCcAnt	   := "!!!!!!!!!"
While !Eof()
	IncRegua() //MOVIMENTA REGUA DE PROCESSAMENTO
	//GARANTE O POSICIONAMENTO DO FUNCIONARIO NO SRA
	dbSelectArea("SRA")
	dbSeek((cTBLXPROV)->PR_FILIAL + (cTBLXPROV)->PR_MAT)
	dbSelectArea(cTBLXPROV)
	If lEnd
		@Prow()+1,0 PSAY cCancel
   		Exit
    Endif
	If (cTBLXPROV)->PR_FILIAL # cFilialAnt //QUEBRA DE FILIAL       
		If !Fp_CodFol(@aCodFol,(cTBLXPROV)->PR_FILIAL) .Or.;
		   !fInfo(@aInfo,(cTBLXPROV)->PR_FILIAL)
			Exit
		Endif
		cFilialAnt := (cTBLXPROV)->PR_FILIAL
		//CARREGA OS IDENTIFICADORES DA PROVISAO
		fIdentProv(@aVerba,aCodFol,.F.,.T.)
		//VERIFICA A EXISTENCIA DOS IDENTIFICADORES DO PIS
		lCalcPis := ( !Empty( aCodFol[416,1] ) )
	Endif
	//LIMPA O ARRAY COM O CONTEUDO ESPECIFICADO NO 2º PARAMETRO
	fLimpaArray(@aTot1314, 0)
	//BUSCA INFORMACOES DE CABECALHO NO SRT
	If !fBusCabSRT(dDataRef,@aCabProv)
		fTestaTotal(_13Salar)
		Loop
	EndIf
	//BUSCA OS LANCAMENTOS DE 13º E 14º SALARIO
	fQryDetSRT(aVerba,aTransf,dDataRef,lTrataTrf,lCalcula,lFerias,l13oSal)
	//TOTALIZADOR (13º + 14º)
	For nCnt1 := 1 To _Linhas
		For nCnt2 := 1 To _Colunas
			aTot1314[nCnt1,nCnt2] := a13Salar[nCnt1,nCnt2]+a14Salar[nCnt1,nCnt2]
		Next nCnt2
	Next nCnt1
	//TOTALIZADORES DOS NIVEIS DE QUEBRA
    If nOrdem != 6 // Nao imprime niveis de c.custo na ordem de item + classe
    	fTotNivCC(a13Salar, a14Salar, aTot1314) 								// Niveis do Centro de Custo
    EndIf
	fAtuCont(@aToTCc1 , @aTotCc2 , @aTotCc3, a13Salar, a14Salar, aTot1314)  // Centro de Custo
	fAtuCont(@aTotFil1, @aTotFil2, @aTotFil3, a13Salar, a14Salar, aTot1314) // Filial
	fAtuCont(@aTotEmp1, @aTotEmp2, @aTotEmp3, a13Salar, a14Salar, aTot1314) // Empresa
	//IMPRIME O FUNCIONARIO
	If nAnaSin == 1
		fImpFun13o()
	EndIf

	//QUEBRAS E SKIPS
	fTestaTotal(_13Salar)
Enddo

//TERMINO DO RELATORIO
dbSelectArea("SRA")
Set Filter To
dbSetOrder(1)

If aReturn[5] == 1
	Set Printer To
	ourspool(wnrel)
Endif
MS_FLUSH()

RestArea(aAreaSRA)

(cTBLXPROV)->(dbCloseArea())

//Elimina arquivo temporário de provisão
fDelTMPPRV()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fAtuCont ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Atualiza Acumuladores                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fAtuCont(aTotal1,aTotal2,aTotal3,aValor1,aValor2,aValor3)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fAtuCont(aTotal1,aTotal2,aTotal3,aValor1,aValor2,aValor3)
Local x
Local z

If Len(aTotal1) > 0
	For x:= 1 To _Linhas
		For z:= 1 To _Colunas
			aTotal1[x,z] += aValor1[x,z]
			aTotal2[x,z] += aValor2[x,z]
			aTotal3[x,z] += aValor3[x,z]
		Next z
	Next x
Else
	aTotal1 := Aclone(aValor1)
	aTotal2 := Aclone(aValor2)
	aTotal3 := Aclone(aValor3)
Endif
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³fTestaTota³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Totalizadores                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fTestaTotal(nTipProv)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fTestaTotal(nTipProv)
Local cCusto
Local nQ

dbSelectArea(cTBLXPROV)
cFilialAnt := (cTBLXPROV)->PR_FILIAL
cCcAnt	   := If(nOrdem == 5, (cTBLXPROV)->PR_CCMVTO, (cTBLXPROV)->PR_CC )
If nOrdem == 6//"C.Custo + Item + Classe"
	cItAnt	   := (cTBLXPROV)->PR_ITEM
	cClAnt	   := (cTBLXPROV)->PR_CLVL
EndIf
dbSkip()

If lImpNiv .And. Len(aNiveis) > 0
    For nQ := 1 TO Len(aNiveis)
        cQ        := cValToChar(nQ)
        cCcAnt&cQ := Subs(cCcAnt,1,aNiveis[nQ])
    Next nQ
Endif

If Eof()
	cCusto := (cTBLXPROV)->PR_CC 
	fImpCc(nTipProv)
	fImpNiv(cCcAnt,.T.,nTipProv)
	If lQuebraFil
		Impr("", "P")
	EndIf
	fImpFil(nTipProv)
	If lQuebraFil
		Impr("", "P")
	EndIf
	fImpEmp(nTipProv)
Elseif cFilialAnt # (cTBLXPROV)->PR_FILIAL
	fImpCc(nTipProv)
    fImpNiv(cCcAnt,.T.,nTipProv)
	If lQuebraFil
		Impr("", "P")
	EndIf
	fImpFil(nTipProv)
	If lQuebraFil
		Impr("", "P")
	EndIf
ElseIf nOrdem == 6 .And. cCcAnt + cItAnt + cClAnt != (cTBLXPROV)->PR_CC + (cTBLXPROV)->PR_ITEM + (cTBLXPROV)->PR_CLVL//"C.Custo + Item + Classe"
	fImpCc(nTipProv)
ElseIf nOrdem == 5 .And. cCcAnt # (cTBLXPROV)->PR_CCMVTO
	cCusto := (cTBLXPROV)->PR_CCMVTO
	If lQuebraCC
		Impr("", "P")
	EndIf
	fImpCc(nTipProv)
	If lQuebraCC
		Impr("", "P")
	EndIf
    fImpNiv(cCusto,.F.,nTipProv)
Elseif nOrdem <> 5 .And. cCcAnt # (cTBLXPROV)->PR_CC
	cCusto := (cTBLXPROV)->PR_CC
	If lQuebraCC
		Impr("", "P")
	EndIf
	fImpCc(nTipProv)
	If lQuebraCC
		Impr("", "P")
	EndIf
	fImpNiv(cCusto,.F.,nTipProv)
Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³fImpFunFer³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao dos Funcionarios                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpFunFer()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpFunFer()
Local lRetu1   := .T.
Local lRetu2   := .T.             
Local cDemissa := If(MesAno((cTBLXPROV)->PR_DEMISSA) <= MesAno(dDataRef),(cTBLXPROV)->PR_DEMISSA,CTOD(""))
Local lRateio  := !Empty(cTpRtProv)

cSituacao := If(aCabProv[_MovProv] == _Cong_Fer .Or. aCabProv[_MovProv] == _Cong_F13,STR0048,If(aCabProv[_MovProv] == _Trfe_Sai,STR0047,"")) // CONGELADO##TRANSFERENCIA 
cSituacao := Left( Upper(cSituacao) + Space(27), 27)

If nTamCC <= 10
	cDET:=STR0017+(cTBLXPROV)->PR_FILIAL+STR0018+Subs(If(lRateio,(cTBLXPROV)->PR_CCMVTO,(cTBLXPROV)->PR_CC)+Space(10),1,10)+STR0019+Subs((cTBLXPROV)->PR_MAT,1,30) 	//"FILIAL: "###" CCTO: "###" MAT: "
	cDET+=STR0020+If(lOfuscaNom,Replicate('*',15),(cTBLXPROV)->PR_NOME)+STR0021+DtoC(aCabProv[_DBsProv])           									//" NOME: "###" DT.BASE FER: "
	cDET+=STR0022+AllTrim(TRANSFORM(aCabProv[_SalProv],cPict1))		 												//" SALARIO: "
Else
	cDET:=STR0017+(cTBLXPROV)->PR_FILIAL+STR0079+Subs(If(lRateio,(cTBLXPROV)->PR_CCMVTO,(cTBLXPROV)->PR_CC)+Space(nTamCC),1,nTamCC)+STR0019+Subs((cTBLXPROV)->PR_MAT,1,30) 	//"FILIAL: "###" CC: "###" MAT: "
	cDET+=STR0020+If(lOfuscaNom,Replicate('*',15),(cTBLXPROV)->PR_NOME)+STR0080+DtoC(aCabProv[_DBsProv])           									//" NOME: "###" DT.BASE: "
	cDET+=STR0081+AllTrim(TRANSFORM(aCabProv[_SalProv],cPict1))		 												//" SAL: "
EndIf
Impr(cDet,"C")
cDet:=Space(11)+cSituacao+STR0044+Dtoc((cTBLXPROV)->PR_ADMISSA)+SPACE(3)+STR0045+Dtoc(cDemissa)  //"DATA ADMISSAO: "###"DATA DEMISSAO: "
cDet+=Space(3)+STR0046+Transform(aCabProv[_DFerAnt],"999.9")	                          //"DIAS FERIAS ANTECIP.: "
Impr(cDet,"C")

lRetu1 := fImpComp(aFerVenc,1,.T.,_FerVenc)
lRetu2 := fImpComp(aFerProp,2,.T.,_FerVenc)

If lRetu1 .And. lRetu2
	fImpComp(aTotVePr,3,.T.,_FerVenc)
Endif

cDet := Repl("-",132)
Impr(cDet,"C")
Impr("","C")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³fImpFun13o³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao dos Funcionarios                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpFun13o()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpFun13o()
Local lRetu1   := .T.
Local lRetu2   := .T.
Local cDemissa := If(MesAno((cTBLXPROV)->PR_DEMISSA) <= MesAno(dDataRef),(cTBLXPROV)->PR_DEMISSA,CTOD(""))
Local lRateio  := !Empty(cTpRtProv)

cSituacao := If(aCabProv[_MovProv] == _Cong_13s .Or. aCabProv[_MovProv] == _Cong_F13,STR0048,If(aCabProv[_MovProv] == _Trfe_Sai,STR0047,"")) // CONGELADO##TRANSFERENCIA 
cSituacao := Left( Upper(cSituacao) + Space(27), 27)

cDET := STR0023+(cTBLXPROV)->PR_FILIAL+STR0024+Subs(If(lRateio,(cTBLXPROV)->PR_CCMVTO,(cTBLXPROV)->PR_CC)+Space(nTamCC),1,nTamCC)+STR0019+Subs((cTBLXPROV)->PR_MAT,1,30)	//"FILIAL: "###" CCTO: "###" MAT: "
cDET += STR0020+If(lOfuscaNom,Replicate('*',15),(cTBLXPROV)->PR_NOME)								//" NOME: "
cDET += STR0022+AllTrim(TRANSFORM(aCabProv[_SalProv],cPict1))					    //" SALARIO: "
Impr(cDet,"C")

cDet := Space(11)+cSituacao+STR0044+DtoC((cTBLXPROV)->PR_ADMISSA)+Space(3)+STR0045+Dtoc(cDemissa)  //" DT.ADMISSAO: "###" DATA DEMISSAO: "
Impr(cDet,"C")

lRetu1 := fImpComp(a13Salar,1,.T.,_13Salar)
lRetu2 := fImpComp(a14Salar,2,.T.,_13Salar)

If lRetu1 .And. lRetu2
	fImpComp(aTot1314,3,.T.,_13Salar)
Endif

cDet := Repl("-",132)
Impr(cDet,"C")
Impr("","C")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fImpCc   ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Totalizador do Centro de Custo                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpCc(nTipProv)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpCc(nTipProv)
Local cDescCl:= ""
Local cDescIt:= ""
Local lRetu1 := .T.
Local lRetu2 := .T.

If Len(aTotCc1) == 0 .Or. (nOrdem != 2 .And. nOrdem != 4 .And. nOrdem != 5 .And. nOrdem != 6)
	Return Nil
Endif

cDET:=STR0023+cFilialAnt+STR0024+cCcAnt+" - "+DescCc(cCcAnt,cFilialAnt)		//"FILIAL: "###" CCTO: "
If nOrdem == 6//"C.Custo + Item + Classe"
	cDescIt := AllTrim( fDesc( "CTD", cItAnt, "CTD_DESC01", Nil, cFilialAnt ) )
	cDescCl := AllTrim( fDesc( "CTH", cClAnt, "CTH_DESC01", Nil, cFilialAnt ) )
	cDET += " - " + STR0077 + AllTrim(cItAnt) + " - " + cDescIt + " - " + STR0078 + Alltrim(cClAnt) + " - " + cDescCl//"ITEM: "##"CLASSE: "	
EndIf
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotCc1,1,.F.,nTipProv)
lRetu2 := fImpComp(aTotCc2,2,.F.,nTipProv)
If lRetu1 .And. lRetu2
	fImpComp(aTotCc3,3,.F.,nTipProv)
Endif

aTotCc1 := {}
aTotCc2 := {}
aTotCc3 := {}

cDet := Repl("=",132)
Impr(cDet,"C")
Impr("","C")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fImpNiv  ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Totalizador dos niveis                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpNiv(cCusto,lGeral,nTipProv)                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpNiv(cCusto,lGeral,nTipProv)
Local lRetu1 := .T.
Local lRetu2 := .T.
Local nQ

If nOrdem # 2 .And. nOrdem # 4
	Return Nil
Endif

If lImpNiv .And. Len(aNiveis) > 0
	For nQ := Len(aNiveis) to 1 Step -1
		cQ := cValToChar(nQ)
	    //VERIFICA SE HOUVE QUEBRA DOS NIVEIS DE C.CUSTO
    	If Subs(cCusto,1,aNiveis[nQ]) # cCcAnt&cQ .Or. lGeral
			If (Len(aTotCc1&cQ) # 0 .Or. Len(aTotCc2&cQ) # 0 .Or. Len(aTotCc1&cQ) # 0)
				If cCcAnt&cQ # Nil
				   cDET:=STR0023+cFilialAnt+STR0024+cCcAnt&cQ+" - "+DescCc(cCcAnt&cQ,cFilialAnt)	//"FILIAL: "###" CCTO: "
				Else
				   cDET:=STR0023+cFilialAnt+STR0024+cCcAnt+" - "+DescCc(cCcAnt,cFilialAnt)		//"FILIAL: "###" CCTO: "
				EndIf
				Impr(cDet,"C")
				Impr("","C")
				lRetu1 := fImpComp(aTotCc1&cQ,1,.F.,nTipProv)
				lRetu2 := fImpComp(aTotCc2&cQ,2,.F.,nTipProv)
				If lRetu1 .And. lRetu2
					fImpComp(aTotCc3&cQ,3,.F.,nTipProv)
				Endif
                aTotCc1&cQ   := {} //Zera
	            aTotCc2&cQ   := {}
			    aTotCc3&cQ   := {}
				cDet := Repl("=",132)
				Impr(cDet,"C")
				Impr("","C")
			Endif
		Endif
	Next nQ
Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fImpFil  ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Totalizador da Filial                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpFil(nTipProv)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpFil(nTipProv)
Local lRetu1 := .T.
Local lRetu2 := .T.
Local cDescFil

If Len(aTotFil1) == 0
	Return Nil
Endif

cDescFil := aInfo[1] + Space(25)
cDET:=STR0023+cFilialAnt+" - "+cDescFil		//"FILIAL: "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotFil1,1,.F.,nTipProv)
lRetu2 := fImpComp(aTotFil2,2,.F.,nTipProv)
If lRetu1 .And. lRetu2
	fImpComp(aTotFil3,3,.F.,nTipProv)
Endif

aTotFil1 :={}
aTotFil2 :={}
aTotFil3 :={}

cDet := Repl("#",132)
Impr(cDet,"C")
Impr("","C")
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fImpEmp  ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Totalizador da Empresa                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpEmp(nTipProv)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpEmp(nTipProv)
Local lRetu1 := .T.
Local lRetu2 := .T.
If Len(aTotEmp1) == 0
	Retu Nil
Endif

cDET:=STR0101+FWGrpName()		//"Grupo de Empresas : "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotEmp1,1,.F.,nTipProv)
lRetu2 := fImpComp(aTotEmp2,2,.F.,nTipProv)
If lRetu1 .And. lRetu2
	fImpComp(aTotEmp3,3,.F.,nTipProv)
Endif

aTotEmp1 :={}
aTotEmp2 :={}
aTotEmp3 :={}
Impr("","F")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fImpComp ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Complemento da Impressao                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpComp(aPosicao,nNroArray,lImpFunc,nTipProv)             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpComp(aPosicao,nNroArray,lImpFunc,nTipProv)
Local lRet := .F.

If nTipProv == _FerVenc
	lRet := fCompFer(aPosicao,nNroArray,lImpFunc)
ElseIf nTipProv == _13Salar
	lRet := fComp13o(aPosicao,nNroArray,lImpFunc)
ElseIf nTipProv == _PlrSalar
	lRet := fCompPlr(aPosicao,nNroArray,lImpFunc)
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fCompFer ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Complemento da Impressao                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCompFer(aPosicao,nLugar,lImpFunc)                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCompFer(aPosicao,nNroArray,lImpFunc)
//aPosicao  = ARRAY CONTENDO O QUE SERA IMPRESSO     (Venc/Prop/Total)    
//nNroArray = POSICAO FISICA DOS GRUPOS DE IMPRESSAO (1-Venc,2-Prop,3-Tot)
Local cCab1,cCab2,Sub_C,nDiasImp
Local nValPro,nValAdi,nVal1Te,nValIns,nValFgt,nValPis,nTotFer,nTotEnc,nTotGer,nValSalV
Local nPosImp  := 0
Local lImpTxBx := .T.
Local nTotImp  := _Linhas - 1
Local bChkVal  := { |nArg| ( aPosicao[nArg,_Prov] + aPosicao[nArg,_Adic] + aPosicao[nArg,_1Ter] + aPosicao[nArg,_INSS] + aPosicao[nArg,_FGTS] == 0 ) }

lImpFunc := If(lImpFunc == Nil,.F.,lImpFunc) // SE VERDADEIRO, SERA IMPRESSO O FUNCIONARIO

//NAO IMPRIME NENHUMA DAS COLUNAS SE O VALOR FOR ZERO
If Eval(bChkVal,_Anter) .And. Eval(bChkVal,_NoMes).And. Eval(bChkVal,_Atual) .And. Eval(bChkVal,_BxTot)
	If nGerRes == 1
		Return .F.
	EndIf
Endif

If nGerRes == 1 .Or. (nGerRes == 2 .And. nNroArray == 1)
	Sub_C := If(nGerRes==2,Space(8),If(nNroArray==1,STR0026,If(nNroArray==2,STR0027,STR0028)))	//"VENCIDAS"###"A VENCER"###"TOTAL"
	   cDET  := Sub_C+SPACE(20)+STR0029+SPACE(3)+STR0030		//"VALOR"###"ADICIONAIS  1/3 CONSTIT.   TOTAL FERIAS"
	   If lCalcPis
		   cDET  += SPACE(5)+STR0031+SPACE(5)+STR0072 //"I.N.S.S. "###"F.G.T.S.        P.I.S.    TOTAL GERAL"
	   Else
		   cDET  += SPACE(5)+STR0031+SPACE(5)+STR0032 //"I.N.S.S. "###"F.G.T.S.  TOT.ENCARGOS    TOTAL GERAL"
	   EndIf
	IMPR(cDET,"C")
Endif

For nPosImp := 1 To nTotImp
	If nGerRes == 2
		cCab1:=If(nNroArray == 1,STR0033,If(nNroArray == 2,STR0034,STR0035))		//"Venc. "###"Prop. "###"Total "
		cCab2:=Space(6)
	Else    
		cCab1:= If(nPosImp == _Anter,STR0036,If(nPosImp == _Corre, Space(6),;
			     If(nPosImp == _NoMes,STR0037,If(nPosImp == _Atual,STR0038,If(nPosImp == _TrfEnt .Or. nPosImp == _TrfSai,STR0073,STR0049)))))	//"D.Fer "###"Faltas"###"Saldo "###"Val. Baixa"###"Transf.Saldo"
		cCab2:= If(nPosImp == _Anter,STR0039,If(nPosImp == _Corre,STR0040,;
				 If(nPosImp == _NoMes,STR0041,If(nPosImp == _Atual,STR0043,;
				 If(nPosImp == _BxTrf,STR0050,If(nPosImp == _BxFer,STR0051,;
				 If(nPosImp == _BxRes, STR0052,If(nPosImp == _TrfEnt,STR0074,If(nPosImp == _TrfSai,STR0075,""))))))))) //"Anter "###"Correc"###"No Mes"###"Atual "###"Transf"###"Ferias"###"Rescis"###"Entr."###"Saida"
	EndIf
	//NAO IMPRIME CORRECAO OU BAIXA SE O VALOR FOR ZERO
	If (nPosImp == _Corre .Or. nPosImp > _Atual) .And. Eval(bChkVal,nPosImp)
		Loop
	Endif
	
	If nPosImp == _Anter .Or. nPosImp == _NoMes .Or. nPosImp == _Corre .Or. nPosImp == _Atual
		If nPosImp == _Anter
			nDiasImp := aPosicao[_Atual,_Dias]+aPosicao[_NoMes,_Dias]
		Else
			nDiasImp := aPosicao[nPosImp,_Dias]
		EndIf
	   	cDet:= cCab1+" "+If(lImpFunc,Transform(nDiasImp,"999.9"),Space(05))+" "+cCab2+"  "
	Else
		If lImpTxBx .Or. nPosImp == _TrfEnt
	        cDet:= cCab1+"  "+cCab2+"  "
	     	lImpTxBx := .F.
	    Else
   	     	cDet:= Space(13)+cCab2+"  "
	    EndIf 	
	EndIf           	
	
	nValPro := aPosicao[nPosImp,_Prov]
	nValAdi := aPosicao[nPosImp,_Adic]
	nVal1Te := aPosicao[nPosImp,_1Ter]
    nTotFer := aPosicao[nPosImp,_Prov]+aPosicao[nPosImp,_Adic]+aPosicao[nPosImp,_1Ter]
    nValIns := aPosicao[nPosImp,_INSS]
    nValFgt := aPosicao[nPosImp,_FGTS]
    nValPis := aPosicao[nPosImp,_PIS]
    nValSalV:= aPosicao[nPosImp,_SalV]
	nTotEnc := aPosicao[nPosImp,_INSS]+aPosicao[nPosImp,_FGTS]
    nTotEnc := If(lCalcPis, nValPis, nTotEnc)
    nTotGer := nTotFer + nValIns + nValFgt + If(lCalcPis,nValPis,0)
	    
	cDet +=     TRANSFORM(nValPro,cPict2)
	cDet += " "+TRANSFORM(nValAdi,cPict2)  
	cDet += " "+TRANSFORM(nVal1Te,cPict3)
	cDet += " "+TRANSFORM(nTotFer,cPict4)
    cDet += " "+TRANSFORM(nValIns,cPict2)
    cDet += " "+TRANSFORM(nValFgt,cPict3) 
    cDet += " "+TRANSFORM(nTotEnc,cPict4)
	cDet += " "+TRANSFORM(nTotGer,cPict4)

	If nGerRes == 1 .Or. (nGerRes == 2 .And. nPosImp == _NoMes)
		Impr(cDet,"C")
	EndIf
Next

//MONTAGEM E IMPRESSAO DO VALOR QUE SERA CONTABILIZADO
If nNroArray == 3 .And. !lImpFunc
	If !Eval(bChkVal,_BxTot)
		nValPro := aPosicao[_NoMes,_Prov]-aPosicao[_BxTot,_Prov]
		nValAdi := aPosicao[_NoMes,_Adic]-aPosicao[_BxTot,_Adic]
		nVal1Te := aPosicao[_NoMes,_1Ter]-aPosicao[_BxTot,_1Ter]
   		nValSalV:= aPosicao[_NoMes,_SalV]-aPosicao[_BxTot,_Salv]
		nTotFer := nValPro + nValAdi + nVal1Te
		nValIns := aPosicao[_NoMes,_INSS]-aPosicao[_BxTot,_INSS]
		nValFgt := aPosicao[_NoMes,_FGTS]-aPosicao[_BxTot,_FGTS]
		nValPis := aPosicao[_NoMes,_PIS] -aPosicao[_BxTot,_PIS]
	    nTotEnc := nValIns + nValFgt
   	    nTotEnc := If(lCalcPis, nValPis, nTotEnc)
	    nTotGer := nTotFer + nValIns + nValFgt + If(lCalcPis,nValPis,0)
		cDet := STR0053+"         "  // NO MES-BAIXA
		cDet +=     TRANSFORM(nValPro,cPict2)
		cDet += " "+TRANSFORM(nValAdi,cPict2)
		cDet += " "+TRANSFORM(nVal1Te,cPict3)
		cDet += " "+TRANSFORM(nTotFer,cPict4)
	    cDet += " "+TRANSFORM(nValIns,cPict2)
	    cDet += " "+TRANSFORM(nValFgt,cPict3)
	    cDet += " "+TRANSFORM(nTotEnc,cPict4)
		cDet += " "+TRANSFORM(nTotGer,cPict4)
		Impr(cDet,"C")
	EndIf
EndIf
Li := If(nGerRes == 1 ,Li++,Li)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ fComp13o ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Complemento da Impressao                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fComp13o(aPosicao,nLugar,lImpFunc)                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fComp13o(aPosicao,nNroArray,lImpFunc)
//aPosicao  = ARRAY CONTENDO O QUE SERA IMPRESSO     (13§/14§/Total)
//nNroArray = POSICAO FISICA DOS GRUPOS DE IMPRESSAO (1-13o,2-14o,3-Tot)
Local cCab1,cCab2,cMes,Sub_C
Local nValPro,nValAdi,nVal1Pa,nValIns,nValFgt,nTotFer,nTotEnc,nTotGer
Local nPosImp  := 0
Local lImpTxBx := .T.
Local nTotImp  := _Linhas - 1
Local cTexTot  := If(nNroArray == 1, STR0062, If(nNroArray == 2, STR0063, STR0064)) //"ADICIONAIS    1o PARCELA      TOTAL 13o"##"ADICIONAIS    1o PARCELA      TOTAL 14o"##"ADICIONAIS    1o PARCELA      TOT 13/14"
Local bChkVal  := { |nArg| ( aPosicao[nArg,_Prov] + aPosicao[nArg,_Adic] + aPosicao[nArg,_1Par] + aPosicao[nArg,_INSS] + aPosicao[nArg,_FGTS] == 0 ) }

lImpFunc := If(lImpFunc == Nil,.F.,lImpFunc) // SE VERDADEIRO, SERA IMPRESSO O FUNCIONARIO

//NAO IMPRIME NENHUMA DAS COLUNAS SE O VALOR FOR ZERO
If Eval(bChkVal,_Anter) .And. Eval(bChkVal,_NoMes).And. Eval(bChkVal,_Atual) .And. Eval(bChkVal,_BxTot)
	If nGerRes == 1
		Return .F.
	EndIf
Endif

If nGerRes == 1 .Or. (nGerRes == 2 .And. nNroArray == 1)
	cDET:=SPACE(28)+STR0029+SPACE(3)+cTexTot	//"VALOR"###"ADICIONAIS    1o PARCELA      TOTAL 13o"
	If lCalcPis
		cDET+=SPACE(05)+STR0031+SPACE(5)+STR0072 //"I.N.S.S. "###"F.G.T.S.        P.I.S.    TOTAL GERAL"
	Else
		cDET+=SPACE(05)+STR0031+SPACE(5)+STR0065 //"I.N.S.S. "###"F.G.T.S.  TOT.ENCARGOS    TOTAL GERAL"
	EndIf
	IMPR(cDET,"C")
Endif

Sub_C := If(nGerRes==2,Space(5),If(nNroArray==1,If(lImpFunc,STR0061,STR0066),If(nNroArray==2,STR0067,Left(STR0028,5)))) //"MESES"##" 14 §"##"TOTAL"

For nPosImp := 1 To nTotImp
	If nGerRes == 2
		cCab1 := Space(5)
		cCab2 := Space(6)
	Else
		cCab1 := If(nPosImp == _NoMes, Sub_C, If(nPosImp == _TrfEnt .Or. nPosImp == _TrfSai,STR0073,If(nPosImp > _Atual,STR0049,Space(5)))) //"MESES"###"Val. Baixa"###"Transf.Saldo"
		cCab2 := If(nPosImp == _Anter,STR0039,If(nPosImp == _Corre,STR0040 ,;
				  If(nPosImp == _NoMes,STR0041,If(nPosImp == _Atual,STR0043,;
				  If(nPosImp == _BxTrf,STR0050,If(nPosImp == _BxRes,STR0052,;
				  If(nPosImp == _Bx13O .And. nNroArray <> 2 .And. nNroArray <> 3,STR0068,If(nPosImp == _TrfEnt,STR0074,If(nPosImp == _TrfSai,STR0075,If(nNroArray == 3, space(6), STR0067+" "))))))))))	//"Anter "###"Correc"###"No Mes"###"Atual "###"Transf"###"Rescis"###"13.Sal"###"Entr."###"Saida"
	EndIf
	//NAO IMPRIME CORRECAO OU BAIXA SE O VALOR FOR ZERO
	If (nPosImp == _Corre .Or. nPosImp > _Atual) .And. Eval(bChkVal,nPosImp)
		Loop
	Endif
	cMes := If(lImpFunc .And. nPosImp == _NoMes,Transform(aPosicao[_NoMes,_Avos],"99"),Space(02))
	cMes := If (Val(cMes) > 0 , cMes ,"  ")
	If nPosImp == _Anter .Or. nPosImp == _NoMes .Or. nPosImp == _Corre .Or. nPosImp == _Atual
		cDet := cCab1+" "+cMes+Space(5)+cCab2+"  "
	Else
		If lImpTxBx .Or. nPosImp == _TrfEnt
	        cDet:= cCab1+"  "+cCab2+"  "
	     	lImpTxBx := .F.
	    Else
   	     	cDet:= Space(13)+cCab2+"  "
	    EndIf 	
	EndIf

	nValPro := aPosicao[nPosImp,_Prov]
	nValAdi := aPosicao[nPosImp,_Adic]
	nVal1Pa := aPosicao[nPosImp,_1Par]
    nTotFer := aPosicao[nPosImp,_Prov]+aPosicao[nPosImp,_Adic]-aPosicao[nPosImp,_1Par]
    nValIns := aPosicao[nPosImp,_INSS]
    nValFgt := aPosicao[nPosImp,_FGTS]
    nValPis := aPosicao[nPosImp,_PIS]
    nTotEnc := aPosicao[nPosImp,_INSS]+aPosicao[nPosImp,_FGTS]
	nTotEnc := If(lCalcPis, nValPis, nTotEnc)
    nTotGer := nTotFer + nValIns + nValFgt + If(lCalcPis,nValPis,0)

	cDet +=     TRANSFORM(nValPro,cPict2)
	cDet += " "+TRANSFORM(nValAdi,cPict2)
	cDet += " "+TRANSFORM(nVal1Pa,cPict3)
	cDet += " "+TRANSFORM(nTotFer,cPict4)
	cDet += " "+TRANSFORM(nValIns,cPict2)
	cDet += " "+TRANSFORM(nValFgt,cPict3)
	cDet += " "+TRANSFORM(nTotEnc,cPict4)
	cDet += " "+TRANSFORM(nTotGer,cPict4)

	If nGerRes == 1 .Or. (nGerRes == 2 .And. nPosImp == _NoMes)
		Impr(cDet,"C")
	EndIf
Next

//MONTAGEM E IMPRESSAO DO VALOR QUE SERA CONTABILIZADO
If nNroArray == 3 .And. !lImpFunc
	If !Eval(bChkVal,_BxTot)
		nValPro := aPosicao[_NoMes,_Prov]-aPosicao[_BxTot,_Prov]
		nValAdi := aPosicao[_NoMes,_Adic]-aPosicao[_BxTot,_Adic]
		nVal1Te := aPosicao[_NoMes,_1Par]-aPosicao[_BxTot,_1Par]
		nTotFer := nValPro + nValAdi + nVal1Pa
		nValIns := aPosicao[_NoMes,_INSS]-aPosicao[_BxTot,_INSS]
		nValFgt := aPosicao[_NoMes,_FGTS]-aPosicao[_BxTot,_FGTS]
		nValPis := aPosicao[_NoMes,_PIS] -aPosicao[_BxTot,_PIS]
		nTotEnc := nValIns + nValFgt
		nTotEnc := If(lCalcPis, nValPis, nTotEnc)
	    nTotGer := nTotFer + nValIns + nValFgt + If(lCalcPis,nValPis,0)
		cDet := STR0053+"         "  // NO MES-BAIXA
		cDet +=     TRANSFORM(nValPro,cPict2)
		cDet += " "+TRANSFORM(nValAdi,cPict2)
		cDet += " "+TRANSFORM(nVal1Pa,cPict3)
		cDet += " "+TRANSFORM(nTotFer,cPict4)
		cDet += " "+TRANSFORM(nValIns,cPict2)
		cDet += " "+TRANSFORM(nValFgt,cPict3)
		cDet += " "+TRANSFORM(nTotEnc,cPict4)
		cDet += " "+TRANSFORM(nTotGer,cPict4)
		Impr(cDet,"C")
	EndIf
EndIf
Li := If(nGerRes == 1 ,Li++,Li)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³fTotNivCC ³ Autor ³ Equipe R.H.           ³ Data ³ 14.11.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Totaliza os niveis de Centro de Custo para Ferias e 13o Sal³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fTotNivCC(aNivCC1, aNivCC2, aNivCC3, aArray1, aArray2...)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fTotNivCC(aArray1, aArray2, aTot1e2)
Local aTotTmp1,aTotTmp2,aTotTmp3, nQ

If lImpNiv .And. Len(aNiveis) > 0
    For nQ :=1 To Len(aNiveis)
        cQ := cValToChar(nQ)
        aTotTmp1 := {}; aTotTmp2 := {}; aTotTmp3 := {}
        aTotTmp1 := Aclone(aTotCc1&cQ)
        aTotTmp2 := Aclone(aTotCc2&cQ)
        aTotTmp3 := Aclone(aTotCc3&cQ)
		fAtuCont(@aTotTmp1, @aTotTmp2, @aTotTmp3, aArray1, aArray2, aTot1e2)
		aTotCc1&cQ := Aclone(aTotTmp1)
		aTotCc2&cQ := Aclone(aTotTmp2)
		aTotCc3&cQ := Aclone(aTotTmp3)
    Next nQ
Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ GPER095	³ Autor ³ Emerson Rosa de Souza ³ Data ³ 25.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Provisao de PLR Salario									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_GPER095(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso 	 ³ Generico 										   		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 		ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER095()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString := "SRA"        			// Alias do arquivo principal (Base)
Local aAreaSRA:= SRA->( GetArea() )
Local aOrd	  := {STR0001,STR0002,STR0003,STR0004}   //"Matricula"###"C.Custo"###"Nome"###"C.Custo+Nome"
Local cDesc1  := STR0059				//"Emiss„o de Provis„o de 13o Salario."
Local cDesc2  := STR0006				//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3  := STR0007				//"usu rio."

Private cPict1  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 999,999,999.99",TM(999999999,14,MsDecimais(1)))  // "@E 99,999,999,999.99
Private cPict2  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 999999999.99"  ,TM(999999999,12,MsDecimais(1)))  // "@E 999999999.99
Private cPict3  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 9999999999.99" ,TM(9999999999,13,MsDecimais(1)))  // "@E 9999999999.99
Private cPict4  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 99999999999.99",TM(99999999999,14,MsDecimais(1)))  // "@E 99999999999.99
Private cPict5  := If (MsDecimais(1)== 2 .OR. cPaisLoc == "BRA","@E 9999999.99"  ,TM(9999999,10,MsDecimais(1)))  		// "@E 9999999.99

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0008,1,STR0009, 2, 2, 1, "",1 }		// "Zebrado"###"Administra‡„o"
Private NomeProg := "GPER095"
Private nLastKey := 0
Private cPerg	 := "GPR090"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR 						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo	 := STR0088		//"PROVISO DE PLR"
Private AT_PRG	 := "GPER095"
Private wCabec0  := 1
Private wCabec1  := STR0011	//"Data Base: "
Private CONTFL	 := 1
Private LI		 := 0
Private nTamanho := "M"
Private lItemClVl:= SuperGetMv( "MV_ITMCLVL", .F., "2" ) $ "13"	// Determina se utiliza Item Contabil e Classe de Valores

TCInternal(5,"*OFF")   // Desliga Refresh no Lock do Top

If lItemClVl
	aAdd( aOrd, STR0083 ) // "C.Custo + Item + Classe"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajuste Perguntas									  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("GPR090",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := "GPER095"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega variaveis privates comuns a GPEA070,GPER070 e GPEM070|
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GPEProvisao(wnRel,cString,Titulo,,8)

RestArea( aAreaSRA )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao	 ³ GP095imp ³ Autor ³ Emerson Rosa de Souza ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Provisao de 13§ Salario									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_GP090Imp(lEnd,WnRel,cString)								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso	 	 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GP095IMP(lEnd,WnRel,cString)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cMapa      := 0
Local nLaco      := nByte := 0
Local cMascCus   := GetMv( "MV_MASCCUS" ) // Mascara do p/Niveis do C.Custo
Local cAcessaSRA := ChkRH("GPER095","SRA","2")
Local aAreaSRA   := SRA->(GetArea())
Local nQ
Local nCnt2
Local nCnt1
Local lCalcula    := .T.
Local lFerias     := .F.
Local l13oSal     := .F.
Local lTodosCpos  := !(cAcessaSRA==".T.")
Local cFiltroRel  := aReturn[7]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)					  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aPlrSalar     := Array(_Linhas,_Colunas)
Private a14Salar := Array(_Linhas,_Colunas)
Private aTotPlr     := Array(_Linhas,_Colunas)
Private aCabProv     := {}
Private aVerba  	 := {}
Private aTransf      := {}
Private aTotCc1      := {}
Private aTotCc2      := {}
Private aTotCc3      := {}
Private aTotFil1     := {}
Private aTotFil2     := {}
Private aTotFil3     := {}
Private aTotEmp1     := {}
Private aTotEmp2     := {}
Private aTotEmp3     := {}
Private aInfo	     := {}
Private aCodFol  	 := {}
Private aNiveis      := {} // Niveis do Centro de Custo
Private lTrataTrf    := .F.
Private lSalInc    	 := .F.
Private lCalcPis	 := .F.
Private lQuebraCC  	 := .F.
Private lQuebraFil   := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Faz o tratamento abaixo pois o relatorio de rateio mensal da provisao ja utiliza a ordem 5
nOrdem		:= Iif( IsInCallStack("GPER095") .And. aReturn[8] == 5 , 6, aReturn[8] )
dDataRef   	:= mv_par01                             // Data de Referencia
cFilDe	   	:= mv_par02								//	Filial De
cFilAte    	:= mv_par03								//	Filial Ate
cCcDe	   	:= mv_par04								//	Centro de Custo De
cCcAte	   	:= mv_par05								//	Centro de Custo Ate
cMatDe	   	:= mv_par06								//	Matricula De
cMatAte     := mv_par07								//	Matricula Ate
cNomeDe     := mv_par08								//	Nome De
cNomeAte    := mv_par09								//	Nome Ate
nAnaSin     := mv_par10								//	Sintetica / Analitica
nGerRes     := mv_par11								//	Resumida  / Geral
lImpNiv     := If(mv_par12 == 1,.T.,.F.)		    //  Imprimir Niveis C.Custo
cCateg	    := mv_par13								//	Categorias (Utilizada em fMonta_TPR)

If !Empty( cFiltroRel )
	lTodosCpos  := .T.
	cAcessaSRA :=  "{ || " +ChkRH("GPER095","SRA","2") + " .And. " + cFiltroRel +"}"
Else
	cAcessaSRA := "{ || " + cAcessaSRA + "}"
Endif
If Empty(cTpRtProv)
	Titulo  := STR0088+If(nAnaSin==1,STR0013,STR0014)+;	//"RELACAO DE PROVISAO DE PLR "###"ANALITICA"###"SINTETICA"
	               " "+If(nGerRes == 1,STR0015,STR0016)		//"(GERAL)"###"(RESUMIDA)" 
Else
	Titulo  := STR0087+If(nAnaSin==1,STR0013,STR0014)+;	//"RELACAO DE PROVISAO MENSAL DE PLR "###"ANALITICA"###"SINTETICA"
	               " "+If(nGerRes == 1,STR0015,STR0016)		//"(GERAL)"###"(RESUMIDA)"
EndIf

wCabec1 += Dtoc(dDataRef)

If cPaisLoc == "ARG"
	cPict1	:=	If (MsDecimais(1)==2,"@E 999,999.99",TM(999999,10,MsDecimais(1)))  // "@E 999,999.99
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ aNiveis -  Armazena as chaves de quebra.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lImpNiv

	aNiveis:= MontaMasc(cMascCus)

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Criar os Arrays com os Niveis de Quebras					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nQ := 1 to Len(aNiveis)
        cQ := cValToChar(NQ)
        Private aTotCc1&cQ   := {} // Niveis dos Centro de Custo
        Private aTotCc2&cQ   := {}
	    Private aTotCc3&cQ   := {}
        cCcAnt&cQ            := "" // Variaveis c.custo dos niveis de quebra
    Next nQ
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o arquivo temporario "TPR" a partir do SRA e SRE     |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({ || fMonta_TPR("","",nOrdem,dDataRef,@lSalInc,@lTrataTrf,@aTransf,,cAcessaSRA,,lTodosCpos)},STR0089) //"PROVISO DE PLR"

dbSelectArea( "SRA" )
dbSetOrder(1)

dbSelectArea( cTBLXPROV )
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega regua de processamento							   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua( RecCount() )

cFilialAnt := Replicate("!", FWGETTAMFILIAL)
cCcAnt	   := "!!!!!!!!!"
While !Eof()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua de Processamento							 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Garante o Posicionamento do Funcionario no SRA				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SRA" )
	dbSeek( (cTBLXPROV)->PR_FILIAL + (cTBLXPROV)->PR_MAT )
	dbSelectArea( cTBLXPROV )

	If lEnd
		@Prow()+1,0 PSAY cCancel
   		Exit
    Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quebra de Filial											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cTBLXPROV)->PR_FILIAL # cFilialAnt       
	
		If !Fp_CodFol(@aCodFol,(cTBLXPROV)->PR_FILIAL) .Or.;
		   !fInfo(@aInfo,(cTBLXPROV)->PR_FILIAL)
			Exit
		Endif

		cFilialAnt := (cTBLXPROV)->PR_FILIAL
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carrega os identificadores da Provisaos						 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fIdentProv(@aVerba,aCodFol,.F.,.T.)

	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Limpa o array com o conteudo especificado no 2§ parametro    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fLimpaArray( @aTotPlr, 0 )
	fLimpaArray( @a14Salar, 0 )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca informacoes de cabecalho no SRT	 					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !fBusCabSRT(dDataRef,@aCabProv)
		fTestaTotal(_PlrSalar)
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca os lancamentos de PLR				     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fQryDetSRT(aVerba,aTransf,dDataRef,lTrataTrf,lCalcula,lFerias,l13oSal,,.T.)
	 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Totalizador (PLR)	                    			     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCnt1 := 1 To _Linhas
		For nCnt2 := 1 To _Colunas
			aTotPlr[nCnt1,nCnt2] := aPlrSalar[nCnt1,nCnt2]
		Next nCnt2
	Next nCnt1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Totalizadores dos Niveis de Quebra                           |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOrdem != 6 // Nao imprime niveis de c.custo na ordem de item + classe
	    fTotNivCC(aPlrSalar, a14Salar, aTotPLr) // Niveis do Centro de Custo
	EndIf
	fAtuCont(@aToTCc1 , @aTotCc2 , @aTotCc3, aPlrSalar, a14Salar, aTotPLr)  // Centro de Custo
	fAtuCont(@aTotFil1, @aTotFil2, @aTotFil3, aPlrSalar, a14Salar, aTotPLr) // Filial
	fAtuCont(@aTotEmp1, @aTotEmp2, @aTotEmp3, aPlrSalar, a14Salar, aTotPLr) // Empresa

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Imprime o funcionario                                        |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nAnaSin == 1
		fImpFunPlr()
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Quebras e Skips                                              |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fTestaTotal(_PlrSalar)
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio							   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA" )
Set Filter To
dbSetOrder(1)

If aReturn[5] == 1
	Set Printer To
	ourspool(wnrel)
Endif
MS_FLUSH()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna area original do cadastro de funcionarios		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aAreaSRA)

(cTBLXPROV)->(dbCloseArea())

//Elimina arquivo temporário de provisão
fDelTMPPRV()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao	 ³fImpFunPlr³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao dos Funcionarios							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ fImpFun13o()     			             				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso	 	 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpFunPlr()
Local lRetu1   := .T.
Local cDemissa := If(MesAno((cTBLXPROV)->PR_DEMISSA) <= MesAno(dDataRef),(cTBLXPROV)->PR_DEMISSA,CTOD(""))

If Empty(cTpRtProv)
	cSituacao := If(aCabProv[_MovProv] == _Cong_13s .Or. aCabProv[_MovProv] == _Cong_F13,STR0048,If(aCabProv[_MovProv] == _Trfe_Sai,STR0047,"")) // CONGELADO##TRANSFERENCIA 
	cSituacao := Left( Upper(cSituacao) + Space(27), 27)
	
	cDET := STR0023+(cTBLXPROV)->PR_FILIAL+STR0024+Subs((cTBLXPROV)->PR_CC+Space(20),1,20)+STR0019+Subs((cTBLXPROV)->PR_MAT,1,30)	//"FILIAL: "###" CCTO: "###" MAT: "
	cDET += STR0020+If(lOfuscaNom,Replicate('*',15),(cTBLXPROV)->PR_NOME)	                       //" NOME: "
	cDET += STR0022+LTrim(TRANSFORM(aCabProv[_SalProv],cPict1))					           //" SALARIO: "
	Impr(cDet,"C")
	
	cDet := Space(17)+cSituacao+STR0044+DtoC((cTBLXPROV)->PR_ADMISSA)+Space(3)+STR0045+Dtoc(cDemissa)  //" DT.ADMISSAO: "###" DATA DEMISSAO: "
	Impr(cDet,"C")
	
	lRetu1 := fImpComp(aPlrSalar,1,.T.,_PlrSalar)
Else

	If nOrdem == 5
		cImpCC1 := STR0082+Subs((cTBLXPROV)->PR_CCMVTO+Space(20),1,20) //"CC.MOVT: "
		cImpCC2 := Space(23)+STR0024+Subs((cTBLXPROV)->PR_CC+Space(20),1,20) // " CCTO: " ##
	Else
		cImpCC1 := STR0024+Subs((cTBLXPROV)->PR_CC+Space(20),1,20) // " CCTO: " ##
		cImpCC2 := Space(19)+STR0082+Subs((cTBLXPROV)->PR_CCMVTO+Space(20),1,20) // "CC.MOVT: "
	EndIf
	cDET:=STR0023+(cTBLXPROV)->PR_FILIAL+Space(5)+cImpCC1+Space(2)+STR0019+Subs((cTBLXPROV)->PR_MAT,1,30)+Space(3) 	//"FILIAL: "#####" CCTO: " ou "CC.MOVT.: "#####" MAT: "###
	cDET+=STR0020+If(lOfuscaNom,Replicate('*',15),(cTBLXPROV)->PR_NOME)+Space(5)          									                    //"NOME: "########
	cDET+=STR0022+LTrim(TRANSFORM(aCabProv[_SalProv],cPict1))		 			 	                    //" SALARIO: "
	Impr(cDet,"C")
	cDet:=cImpCC2+SPACE(3)+STR0044+Dtoc((cTBLXPROV)->PR_ADMISSA)+SPACE(3)+STR0045+Dtoc(cDemissa)   //"CC.MOVT.: " ou " CCTO: "###"DATA ADMISSAO: "###"DATA DEMISSAO: "
	Impr(cDet,"C")
	
	lRetu1 := fImpComp(aPlrSalar,1,.T.,_PlrSalar)
	
EndIf

cDet := Repl("-",132)
Impr(cDet,"C")
Impr("","C")

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao	 ³ fCompPlr ³ Autor ³ Equipe R.H.           ³ Data ³ 16.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Complemento da Impressao								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ fComp13o(aPosicao,nLugar,lImpFunc)       				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso	 	 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCompPlr(aPosicao,nNroArray,lImpFunc)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| aPosicao  = Array contendo o que sera impresso     (13§/14§/Total)       |
//| nNroArray = Posicao fisica dos grupos de impressao (1-13o,2-14o,3-Tot)   |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCab1,cCab2,cMes,Sub_C
Local nValPro,nValAdi,nVal1Pa,nValIns,nValFgt,nTotFer,nTotEnc,nTotGer
Local nPosImp  := 0
Local lImpTxBx := .T.
Local nTotImp  := _Linhas - 1
Local bChkVal  := { |nArg| ( aPosicao[nArg,_Prov] == 0 ) }

lImpFunc := If(lImpFunc == Nil,.F.,lImpFunc) // Se verdadeiro, sera impresso o funcionario

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nao Imprime Nenhuma das Colunas se o Valor for Zero 		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Eval(bChkVal,_Anter) .And. Eval(bChkVal,_Atual) .And. Eval(bChkVal,_BxTot)
	If nGerRes == 1
		Return .F.
	EndIf
Endif

If nGerRes == 1 .Or. (nGerRes == 2 .And. nNroArray == 1)
   cDET:=SPACE(28)+STR0029	//"VALOR"
   IMPR(cDET,"C")
Endif

Sub_C := If(nGerRes==2,Space(5),If(nNroArray==1,If(lImpFunc,Space(5),STR0086),If(nNroArray==2,STR0067,Left(STR0028,5)))) //"MESES"##" 14 §"##"TOTAL"

For nPosImp := 1 To nTotImp
	
	If nGerRes == 2
		cCab1 := Space(5)
		cCab2 := Space(6)
	Else
		If !Empty(cTpRtProv)
			cCab1 := Space(4)
		Else
			cCab1 := If(nPosImp == _NoMes, Sub_C, If(nPosImp == _TrfEnt .Or. nPosImp == _TrfSai,STR0073,If(nPosImp > _Atual,STR0049,Space(5)))) //"MESES"###"Val. Baixa"###"Transf.Saldo"
		EndIf
		cCab2 := If(nPosImp == _Anter,STR0039,If(nPosImp == _Corre,STR0040 ,;
				  If(nPosImp == _NoMes,STR0041,If(nPosImp == _Atual,STR0043,;
				  If(nPosImp == _BxTrf,STR0050,If(nPosImp == _BxRes,STR0052,;
				  If(nPosImp == _BxPlr,STR0086+space(1),If(nPosImp == _TrfEnt,STR0074,If(nPosImp == _TrfSai,STR0075,"")))))))))	//"Anter "###"Correc"###"No Mes"###"Atual "###"Transf"###"Rescis"###"13.Sal"###"Entr."###"Saida"
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nao Imprime Correcao ou Baixa se o Valor for Zero    		 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nPosImp == _Corre .Or. nPosImp > _Atual) .And. Eval(bChkVal,nPosImp)
		Loop
	Endif
	
	//cMes := If(lImpFunc .And. nPosImp == _NoMes,Transform(aPosicao[_NoMes,_Avos],"99"),Space(02))
	//cMes := If (Val(cMes) > 0 , cMes ,"  ")
 	cMes := "  "
	If nPosImp == _Anter .Or. nPosImp == _NoMes .Or. nPosImp == _Corre .Or. nPosImp == _Atual .Or. cTpRtProv == "RP13"
		cDet := cCab1+" "+cMes+Space(5)+cCab2+"  "
	Else
		If lImpTxBx .Or. nPosImp == _TrfEnt
	        cDet:= cCab1+"  "+cCab2+"  "
	     	lImpTxBx := .F.
	    Else
   	     	cDet:= Space(13)+cCab2+"  "
	    EndIf 	
	EndIf
	
	nValPro := aPosicao[nPosImp,_Prov]
    
	cDet +=     TRANSFORM(nValPro,cPict2)

	If nGerRes == 1 .Or. (nGerRes == 2 .And. nPosImp == _NoMes) .Or. (nGerRes == 2 .And. cTpRtProv == "RP13")
		Impr(cDet,"C")
	EndIf
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem e impressao do valor que sera contabilizado 		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nNroArray == 3 .And. !lImpFunc
	If !Eval(bChkVal,_BxTot)
		nValPro := aPosicao[_NoMes,_Prov]-aPosicao[_BxTot,_Prov]
	
		cDet := STR0053+"         "  // No Mes-Baixa
		cDet +=     TRANSFORM(nValPro,cPict2)
		Impr(cDet,"C")
	EndIf
EndIf
Li := If(nGerRes == 1 ,Li++,Li)

Return .T.
