/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER200.CH"

Static lIntegDef 	:= FindFunction("GETROTINTEG") .And. FindFunction("FWHASEAI")
Static lRHTAF		:= If(cPaisLoc == 'BRA' ,((SuperGetMv("MV_RHTAF",, .F.) == .T.) .AND. Val(SuperGetMv("MV_FASESOC",/*lHelp*/,' ')) >= 1 ), .F.)
Static lAutomato	:= Isblind()
Static lSalCCT		:= .F.
Static lTemCCT
Static lUsaRI4

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER200  ³ Autor ³ R.H. - Marcos Stiefano        ³ Data ³ 27/06/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Aumento Salarial                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER200(void)                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³CHAMADO/FNC³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±|Mohanad Odeh| 14/03/13 |M12RH01    |Unificacao dos fontes V12                  ³±±
±±|            |          |RQ4508     |                                           ³±±  
±±|Raquel Hager| 06/11/13 |M12RH01    |Ajutes na funcao fTestaTotal para quando   ³±±
±±|            |          |RQ4508     |pergunte de Matricula for inferior a matri ³±± 
±±|            |          |           |ja cadastrada.							  ³±±
±±|Esther      |15/04/2014|M_RH003    |Ajuste nas validações para chamada da funçã³±±
±±| Viveiro    |          |		      |o fGravaSRJ() necessitava de parenteses p/ ³±±
±±|            |          |		      |tratar corretamente .OR. e .AND.           ³±±
±±|Christiane V|15/10/2014|TQUPR7	  |Permitir a seleção de mais de um sindicato ³±±
±±|            |          |		      |para efetuar o reajuste salarial.          ³±±
±±|M. Silveira |31/10/2014|TQVQPC	  |Ajuste para tratar tambem os criterios de  ³±±
±±|            |          |		      |arredondamento no valor do reajuste.       ³±±
±±|Flavio Corr |19/03/15  |PCREQ-4163 |Integração Mensagem Unica                  ³±±
±±|Renan Borges|05/08/2015|TSVPFP	  |Ajuste para gerar relatório Salarial corre-³±±
±±|            |          |		      |tamente quando o código do sindicato possui³±±
±±|            |          |		      |apenas 1 digito numérico.                  ³±±
±±|Nivia Ferrei|28/10/15  |PCREQ-5350 |Produtização gestão pública V12            ³±±
±±|Cíceor Alves|16/12/2015|TTZNRZ	  |Ajuste para imprimir corretamente o		  ³±±
±±|            |          |		      |percentual de reajuste proporcional a      ³±±
±±|            |          |		      |admissao.						  		  ³±±
±±|Gabriel A.  |29/09/2016|TVVCYQ     |Ajuste para filtrar os dados por filial.   ³±±
±±|Jaqueline L.|03/01/2018|DRHPAG-9323|Retirado o dbgotop da SRA para não dispo-  ³±±
±±|Jaqueline L.|03/01/2018|DRHPAG-9323|cionar a filial que esta selecionadda.     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER200(aDadRobo, sNomeArq)

Local cDesc1  	:= STR0001		//"Emissao do Aumento Salarial."
Local cDesc2  	:= STR0002		//"Ser impresso de acordo com os parametros solicitados pelo"
Local cDesc3  	:= STR0003		//"usuario."
Local cString 	:= "SRA"						// Alias do arquivo principal (Base)
Local aOrd 		:= {STR0004,STR0005,STR0007}	//"Matricula"###"Centro de Custo"###"Função" 

Private aReturn := {STR0008, 1,STR0009, 2, 2, 1, "",1 }	//"Zebrado"###"Administracao"
	
Private NomeProg:= "GPER200"
Private aLinha	:= {}
Private nLastKey:= 0
Private cPerg	:= "GPR200"
Private nOrdem

Private aPosicao1 := {} // Array das posicoes
Private aTotFun1  := {}
Private aTotCc1   := {}
Private aTotFil1  := {}
Private aTotEmp1  := {}
Private aInfo     := {}
Private nAnaSin
Private nGerRes
Private aPDV	  := {} // Matriz Incidencia de Verbas Usado na Fvaloriza()
Private nPosAnt	  := nPosAtu := 6
Private Normal	  := Descanso := 0
Private nFunc	  := 0

Private Titulo
Private AT_PRG   := "GPER200"
Private wCabec0  := 1
Private wCabec1  := STR0010+Dtoc(dDataBase)	//"Data Base: "
Private CONTFL   := 1
Private LI       := 0
Private nTamanho := "M"

Private aFldRot 	:= {'RA_NOME'}
Private aOfusca	 	:= If(FindFunction('ChkOfusca'), ChkOfusca(), {.T.,.F.}) //[1] Acesso; [2]Ofusca
Private lOfuscaNom 	:= .F. 
Private aFldOfusca	:= {} 

DEFAULT lTemCCT := cPaisLoc == "BRA" .and. RCE->(ColumnPos("RCE_CCT")) > 0
DEFAULT lUsaRI4 := cPaisLoc == "BRA" .and. AliasInDic("RI4") .and. RI4->(ColumnPos( "RI4_SALARI" )) > 0

cPerg	:= If(lTemCCT,'GPR200B','GPR200')

If aOfusca[2]
	aFldOfusca := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRot ) // CAMPOS SEM ACESSO
	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_NOME" } ) > 0
		lOfuscaNom := FwProtectedDataUtil():IsFieldInList( "RA_NOME" )
	ENDIF
ENDIF

// Obtem os Percentuais de Aumento
Private aHeader := {}

Aadd(aHeader,{STR0016,"GPR200DE"  ,"@E 999,999,999,999.99", 15 , 2 , "positivo()" , "û" , "N" , "  "," " })			//"Faixa De"
Aadd(aHeader,{STR0017,"GPR200ATE" ,"@E 999,999,999,999.99", 15 , 2 , "positivo()" , "û" , "N" , "  "," " })			//"Faixa Ate"
Aadd(aHeader,{STR0018,"GPR200PERC","@E 999.999999"        , 10 , 6 , "positivo()" , "û" , "N" , "  "," " })			//"% Aumento"
Aadd(aHeader,{STR0019,"GPR200VAL" ,"@E 999,999,999,999.99", 15 , 2 , "positivo()" , "û" , "N" , "  "," " })			//"Valor do Aumento"
Aadd(aHeader,{STR0042,"GPR200DT1" ,""                     , 08 , 0 , "U_r200Dt1() " , "û" , "D" , "  "," ","",""})	//"Data Admissao de "
Aadd(aHeader,{STR0043,"GPR200DT2" ,""                     , 08 , 0 , "U_R200DT2() " , "û" , "D" , "  "," ","","" })	//"Data Admissao Ate"

aAlter := { "GPR200DE" , "GPR200ATE" , "GPR200PERC" , "GPR200VAL","GPR200DT1","GPR200DT2" }

// Inicializa 1§ Item
Private aTELA[0,0],aGETS[0]
Private nUsado	:= 7
Private aCols 	:= {}
Private aLog	:= {}
Private aTitle	:= {} 
Private aLogAlt := {}
Private cCatMensal 	:= "M*C*P*A*E*S*I"
Private lGestPubl 	:= if(ExistFunc("fUsaGFP"),fUsaGFP(),.f.)	//Verifica se utiliza o modulo de Gestao de Folha Publica - SIGAGFP

If lRHTAF .AND. !IsBlind()
	fAlertJob()
Endif

IF	lGestPubl //Se Gestao de Folha Publica - SIGAGFP	
    cCatMensal += "*0*1*2*3*4*5*6*7*8*9"
EndIf

IF !lAutomato
	Aadd( aCols, { 0.01, 0.00 , 0.00 , 0.00 ,ctod("//","DDMMYYYY"),ctod("//","DDMMYYYY"), .F. })
Else
	aCols := aDadRobo
Endif

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³       mv_par01      Filial De                                ³
//³       mv_par02      Filial Ate                               ³
//³       mv_par03      Centro de Custo De                       ³
//³       mv_par04      Centro de Custo Ate                      ³
//³       mv_par05      Matricula De                             ³
//³       mv_par06      Matricula Ate                            ³
//³       mv_par07      Funcao De                                ³
//³       mv_par08      Funcao Ate                               ³
//³       mv_par09      Aumento Sobre                            ³
//³       mv_par10      Tipo de Aumento                          ³
//³       mv_par11      Data Do Aumento                          ³
//³       mv_par12      Atualiza Cadastro                        ³
//³       mv_par13      Atualiza Funcao                          ³
//³       mv_par14      Atualiza Base Dissidio                   ³
//³       mv_par15      Proporcional Admissao                    ³
//³       mv_par16      Categoria                                ³
//³       mv_par17      Sindicato                                ³
//³       mv_par18      Arred. No Calculo  N„o / Normal / Acima  ³
//³       mv_par19      Arredondamento Sobre o Calculo           ³
//³       mv_par20      No.Meses p/Adm.Prop.                     ³
//³       mv_par21      Aplicar aumento para(Nao reajustados/    ³
//³                                          Reajustados/Ambos)  ³
//³       mv_par22      Piso Salarial.                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo := STR0020		// "Cálculo/Relatório Reajuste Salarial "

// Envia controle para a funcao SETPRINT
If !lAutomato .OR. Empty(sNomeArq)
	wnrel := "GPER200"	//Nome Default do relatorio em Disco	
Else
	wnrel := sNomeArq	//Nome Default do relatorio em Disco(Robô)
Endif

wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,nTamanho)

nOrdem      := aReturn[8]
cFilDe      :=  mv_par01		//Filial De                    
cFilAte     :=  mv_par02		//Filial Ate
cCcDe       :=  mv_par03		//Centro de Custo De
cCcAte      :=  mv_par04  		//Centro de Custo Ate
cMatDe      :=  mv_par05		//Matricula De
cMatAte     :=  mv_par06		//Matricula Ate
cFunDe      :=  mv_par07		//Funcao De
cFunAte     :=  mv_par08		//Funcao Ate
nTipAum     :=  mv_par09 		//Tipo de Aumento( 1-Dissidio;2-Antecipacao;3-Aumento Real)	
cTipAum     :=  mv_par10		//Codigo do tipo de aumento
dDatAum     :=  mv_par11		//Data do Aumento
nAtuCad     :=  mv_par12  		//Atualiza Cadastro(1-Nao;2-Sim)
nAtuFun     :=  mv_par13		//Atualiza Funcao( 1-Funcao Atribuida 2-Func.Nao Atribuida 3-Ambos 4-Nao)
nAtuDiss    :=  mv_par14 		//Atualiza Base Dissidio(1-Nao;2-Sim)
lProAdm     :=  If(mv_par15 == 1, .F. , .T.)//Proporcional Admissao(1-Nao;2-Sim)

If lTemCCT
	cCodCCT		:=  mv_par16
	cCategoria  :=  mv_par23
Else
	cCodCCT		:= ""
	cCategoria  :=  mv_par16 		//Categoria 
EndIf

nCriterio   :=  mv_par18 		//Arred. No Calculo (1-N„o /2-Padrao/3-Acima)
nArredonda  :=  mv_par19  		// Vl. Arredondamento Sobre o Calculo
nMesProp    :=  Val(mv_par20) 	//No.Meses p/Adm.Prop             
nAplAument  := 	mv_par21		//Nao reajustados/Reajustados/Ambos)
nVlPiso	    :=	mv_par22		//Valor do Piso Salarial

////Se Gestao de Folha Publica - SIGAGFP
If  lGestPubl  .and. nAtuCad <> nAtuDiss
	MsgAlert(STR0064) //"Para Gestão Pública é obrigatório que as perguntas 'Atualiza Cadastro' e 'Atualiz.Base Dissidio' estejam configuras da mesma forma."
	Return
EndIf

MakeAdvplExpr(cPerg)

cSindicato 	:= Alltrim(mv_par17)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se a pergunta Atualiza funcao for "1-Func.Atribuida          ³
//³                                    2-Func.Nao Atribuida      ³
//³                                    3-Ambos              "    ³
//³ a ordem "Por funcao"  sera selecionada automaticamente para  ³
//³ que seja atualizado o cadastro de funcoes.                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := If(nAtuFun == 1 .or. nAtuFun == 2 .or. nAtuFun == 3 , 3 , nOrdem) 

If nOrdem # 3
	Titulo := STR0020+If(mv_par09==1,STR0021,If(mv_par09==2,STR0022,STR0023))	//"Cálculo/Relatório Reajuste Salarial " "###"  (DISSIDIO)  "###"  (ANTECIPACAO)  "###"  (AUMENTO REAL)  "	
Else
	Titulo := STR0024			//Cálculo/Relatório Reajuste Salarial por Função"
Endif	

wCabec1+="  "
wCabec1+="  "

If nLastKey == 27
	Return
Endif

If lAutomato
	aReturn[4] := 1
	aReturn[5] := 1
	aReturn[6] := sNomeArq
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

If !lAutomato .And. nAtuCad == 2
	AAdd(aTitle, OemToAnsi(STR0075 + DtoC(dDatAum) + STR0076)) //"Data do Aumento:"###"- Funcionários Processados:"
	AAdd(aLogAlt, {})
EndIf

RptStatus({|lEnd| GR200Imp(@lEnd,wnRel,cString)},Titulo)

IF !( lOk := Empty( aLog ))
	//"Ocorreram Inconsistências durante o Processo de Transferência. Deseja consultar o LOG"
	//Atenção
	IF ( MsgNoYes( OemToAnsi( STR0058 )  , OemToAnsi( STR0059 ) ) )
	  fMakeLog(aLog,aTitle,,,,STR0060,"M","P",,.F.) //"Log de ocorrencias
	EndIF
EndIF

If !lAutomato .And. nAtuCad == 2 .And. !Empty(aLogAlt[1])
	If MsgNoYes( OemToAnsi(STR0077), (STR0078) ) //"Deseja gerar Log?"###"Log de registros processados"
		fMakeLog(aLogAlt, aTitle, Nil, Nil, "GPER200_"+FWTimeStamp(), OemToAnsi(STR0060), "M", "P", Nil, .F.)
	EndIf	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER200  ³ Autor ³ R.H. - Marcos Stiefano³ Data ³ 27/06/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Aumento Salarial                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPR200Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³Parametros³ cString     - Mensagem			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GR200Imp(lEnd,WnRel,cString)
Local cRaCodFunc := ""
Local nPos0,nPos1,nPos2,nPos3,nPos4,nPos5,nPos6,nPos7
Local nPos      := 0
Local nPos8		:= 0 
Local nPos9		:= 0 
Local nPos10	:= 0
Local nPos11	:= 0
Local nSalario  := 0
Local nSalMes 	:= 0
Local nSalDia 	:= 0
Local nSalHora 	:= 0
Local nSalBase  := 0
Local nBaseDis  := 0
Local nNovoSal  := 0
Local nNovoDis  := 0
Local nReajSal  := 0
Local nReajDis  := 0
Local nBaseMes  := 0
Local nDiaAux   := 0
Local nMesAux   := 0
Local nValArre  := 0
Local nPerProp	:= 0
Local nSalAux 	:= 0
Local nSalFaixa := 0
Local nPosAux	:= 0

Local oGet
Local oDlg
Local lAtuSalAux := .T. 	
Local lAumento  := .F.
Local lGravaAum := .F. 
Local nPisoMes	:= 0 
Local nPisoHora	:= 0 
Local nPisoDia	:= 0 
Local lPiso		:= .F. 
Local lAltFunc	:= .T.
Local oProfile	:= FwProfile():New()
Local n 
Local aAdvSize		:= {} 
Local aInfoAdvSize	:= {} 
Local aObjSize		:= {} 
Local aObjCoords	:= {} 
Local aFuncoes 		:= {}
Local aParams   	:= {}
Local nPosFAtu		:= 0
Local nLoops		:= 0
Local nLoop			:= 0
Local cKey			:= ''				// variavel com os valores das chaves. (variavel para getdados da tabela RCP)
Local cFuncCCT 		:= ''
Local cSindAnt		:= ''
Local aArea	
Local lGpAltSal		:= ExistBlock( "GPALTSAL" )
Local lGpVldFun		:= ExistBlock("GPVLDFUN")

Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER200" , "SRA" , "2" ) + " } " ) 
Private aSraHeader 	:= {}
Private aSraVirtual	:= {}
Private aSraVisual 	:= {}
Private aSraCols	:= {}
Private aSraFields	:= {}
Private nSraUsado	:= 0.00 			// variavel que retorna a quantidade de campos da tabela. (variavel para getdados da tabela RCP)
Private aHeaderRCP	:= {}				// vetor com o cabecalho da GetDados RCP. (variavel para getdados da tabela RCP)
Private nPosRCP		:= 0
Private aModTraj	:= {}
Private aRCPCols	:= {}				// vetor com as colunas da GetDados RCP. (variavel para getdados da tabela RCP)
Private aRCPColsAnt	:= {}				// vetor com as colunas da GetDados RCP. (variavel para getdados da tabela RCP)
Private aSvSraCols	:= {}
Private aSraColsRec	:= {}				// vetor que contem os Recnos da tabela. (variavel para getdados da tabela RCP)
Private aTotRegs	:= array(19)
Private lLog   		:= .F.
Private aRotina 	:= MtnFakeaRot() // ajuste para versao 9.12 - chamada da funcao MenuDef() que contem aRotina
Private aFaixas     := {}      // Faixas Salariais
Private nPercDif    := 0
Private nValAum     := 0

If (Type("ALTERA") == "U")
	Private ALTERA := .T.
EndIf

aFill(aTotRegs,0)     

nPisoMes	:= nVlPiso 
nPisoDia	:= (nVlPiso) /30
nPisoHora	:= (nVlPiso) / 220

If Month( dDatAum ) == 1
	cAnoMesProp	:= strzero(Year( dDatAum )-1 ,4)+"12"
Else                       
	cAnoMesProp	:= Strzero( Year( dDatAum ),4 )+ strzero( month( dDatAum )-1,2)
EndIf

//Monta as Dimensoes dos Objetos
aAdvSize		:= MsAdvSize() 
aInfoAdvSize	:= { aAdvSize[1] , aAdvSize[2] , aAdvSize[3] , aAdvSize[4] , 0 , 0 } 
aAdd( aObjCoords , { 015 , 020 , .T. , .F. } ) 
aAdd( aObjCoords , { 000 , 000 , .T. , .T. } ) 
aObjSize		:= MsObjSize( aInfoAdvSize , aObjCoords ) 

While	.T. 
	nOpca := 0
	If !lAutomato
		oProfile:SetUser(RetCodUsr())
		oProfile:SetProgram("GPER200")
		oProfile:SetTask("GPER200PARAM")

		aParams := oProfile:Load()
		If Len(aParams) >= 4 .And. Len(aParams[1]) > 0 .and. Len(aParams[1][1])-1 == Len(aHeader)
			aCols     := aClone(aParams[1])
			nPisoMes  := aParams[2]
			nPisoHora := aParams[3]
			nPisoDia  := aParams[4]
		EndIf

		DEFINE FONT oFont  NAME "Arial" SIZE 0,-11 BOLD
		DEFINE MSDIALOG oDlg TITLE OemtoAnsi(STR0028) From aAdvSize[7],0 To aAdvSize[6],aAdvSize[5] OF oMainWnd PIXEL	//" Calcular para Sal rios "
	
		@ (aObjSize[1,1]+3) , aObjSize[1,2] GROUP oGroup TO ( aObjSize[1,3] + 20 ),(  aObjSize[1,4]  ) OF oDlg PIXEL				
		oGroup:oFont:= oFont
	
		@ (aObjSize[1,1]+08), (aObjSize[2,2]+05) 		say 	STR0044 SIZE 200,7 PIXEL FONT oFont COLOR CLR_HBLUE //"Piso Salarial: Valores calculados considerando 220h/mes."
	
		@ (aObjSize[2,1]+06), (aObjSize[2,2]+05)		say   	STR0045   SIZE 55,07 PIXEL FONT oFont of oDlg   //"Piso/Mes    :"
		@ (aObjSize[2,1]+02), (aObjSize[2,2]+05*10) 	MsGet 	nPisoMes  SIZE 57,11 OF oDlg PIXEL PICTURE "@E 999,999,999.99" when cCategoria $ cCatMensal valid U_r200Piso(nPisomes,@nPisoHora,@nPisoDia)
	
	
		@ (aObjSize[2,1]+06), (aObjSize[2,4]/3+5) 		say 	STR0046   SIZE 55,07 PIXEL FONT oFont of oDlg   //"Piso/Hora   :"
		@ (aObjSize[2,1]+02), (aObjSize[2,4]/3+5*10) 	MsGet 	nPisoHora SIZE 57,11 OF oDlg PIXEL PICTURE "@E 999,999,999.99" when cCategoria $ "H*T*G*J" valid U_r200Piso(@nPisomes,nPisoHora,@nPisoDia)
	
		@ (aObjSize[2,1]+06), (aObjSize[2,4]/3*2+5) 	say 	STR0047   SIZE 55,07 PIXEL FONT oFont of oDlg   //"Piso/Dia    :"
		@ (aObjSize[2,1]+02), (aObjSize[2,4]/3*2+5*10) MsGet 	nPisoDia  SIZE 57,11 OF oDlg PIXEL PICTURE "@E 999,999,999.99" when cCategoria $ "D" valid U_r200Piso(@nPisomes,@nPisoHora,nPisoDia)
	
		oGet  := MSGetDados():New(aObjSize[2,1]+20,aObjSize[2,2],aObjSize[2,3],aObjSize[2,4],3,"GPR200LinOk","GPR200TudOk","",.T.)

	
		ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpca:=1,If(oGet:TudoOk(),oDlg:End(),nOpca:=0)},{||oDlg:End()})
	Endif
	
	If	nOpca == 1 .OR. lAutomato
		Exit
	Else
		Return
	Endif
EndDo

dbSelectArea( "SRA" )

If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(7)
Endif

dbGoTop()

If nOrdem == 1
	dbSeek( cFilDe + cMatDe , .T. )
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMAtAte
ElseIf nOrdem == 2
	dbSeek( cFilDe + cCcDe + cMatDe , .T. )
	cInicio := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim    := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	dbSeek( cFilDe + cFunDe , .T. )
	cInicio := "SRA->RA_FILIAL + SRA->RA_CODFUNC"
	cFim    := cFilAte + cFunAte
Endif

If Len(Acols) == 0
	return
Endif

// Desconsidera Faixas deletadas
aFaixas := {}
For N=1 To Len(aCols)
	If aCols[N,7] == .F.
		Aadd(aFaixas,{ aCols[N,1] , aCols[N,2] , aCols[N,3] , aCols[N,4] ,aCols[N,5],aCols[N,6], aCols[N,7] })
	Endif
Next N

If !lAutomato 	
	aParams := { aFaixas, nPisoMes, nPisoHora, nPisoDia }
    oProfile:SetProfile(aParams)
    oProfile:Save()
    oProfile:DeActivate()
EndIf

// P.E. para alterar percentual ou valor do aumento aplicado
cFilialAnt := Replicate("!", FWGETTAMFILIAL)
cCcAnt     := Space(9)
cFuAnt     := Space(4)
cfunAnt    := SPace(4)
If nAtuCad == 2	
	// Impressao do Funcionario
	PcoIniLan('000087')	
Endif

If !lAutomato
	SetRegua(SRA->(RecCount()))
Endif

Begin Transaction
	
	While	!EOF() .And. &cInicio <= cFim
		
		If !lAutomato
			// Movimenta Regua Processamento
			IncRegua()
		Endif
	
		If lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		Endif
	
		// Nao permite Dt. Alteracao Salarial menor que Dt.Admissao
		If !Empty(dDatAum) .And. dDatAum < SRA->RA_ADMISSA
	 		fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)  
			Loop
		EndIf  
		
		If SRA->RA_FILIAL # cFilialAnt
			If !fInfo(@aInfo,SRA->RA_FILIAL)
				Exit
			Endif
			dbSelectArea( "SRA" )
			cFilialAnt := SRA->RA_FILIAL
		Endif
	   
		If cFunAnt # SRA->RA_CODFUNC
	      	lAumento  := .F.
	      	lGravaAum := .F.
			cFunAnt := SRA->RA_CODFUNC
		Endif 
	
		// Consiste Parametrizacao do Intervalo de Impressao
		If	( SRA->RA_MAT     < cMatDe ) .Or. ( SRA->RA_MAT     > cMatAte ) .Or. ;
			( SRA->RA_CC      < cCcDe  ) .Or. ( SRA->RA_CC      > cCcAte  ) .Or. ;
			( SRA->RA_CODFUNC < cFunDe ) .Or. ( SRA->RA_CODFUNC > cFunAte ) .Or. ;
			( SRA->RA_FILIAL  < cFilde ) .Or. ( SRA->RA_FILIAL  > cFilAte )
			fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)
			Loop
		EndIf
	
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se Gestao de Folha Publica - SIGAGFP, nao permite reajuste quando ha tabela no SRA  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  lGestPubl  .and. !empty(SRA->RA_TABELA)
			fTestaTotal()
			Loop
		EndIf
	
		// Consiste Filiais e Acessos
		IF !( SRA->RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA )
			fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)
			Loop
		EndIF
	
		// Verifica a Categoria e Situacao do Funcionario
		If !( SRA->RA_CATFUNC  $ cCategoria ) .Or. !( SRA->RA_SITFOLH $ " *F*A*I" )
			fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)
			Loop
		Endif

		// Ponto de Entrada para não considerar o funcionario caso
		// o retorno seja .T. para a condição criada no PE.
		If lGpVldFun
        	If Execblock("GPVLDFUN", .F., .F.,)
        		fTestaTotal(@lGravaAum, @lAumento, @nNovoSal)
        		Loop
        	EndIf
		Endif

		If !Empty(cCodCCT) //Se sindicato não pertence a CCT selecionada, pula.
			If Empty(SRA->RA_SINDICA) .or. (RCE->(DbSeek(xFilial("RCE", SRA->RA_FILIAL) + SRA->RA_SINDICA)) .and. RCE->RCE_CCT <> cCodCCT)
				fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)
				Loop
			EndIf
		EndIf
	
		If !Empty(cSindicato)
			If !SRA->(&(cSindicato))
				fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)
				Loop
	       EndIf
		EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o funcionario ja foi reajustado nesta data e de  ³
		//³ acordo com a pergunta "Aplicar aumento para( nao reajustados/³ 
		//³ reajustados/Ambos) , se deve ou nao aplicar aumento.         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SR7->( dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + Dtos(dDatAum) ) )
			If nAplAument == 1  // Nao reajustados
				fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)
				Loop
			EndIF	
		Else
			If nAplAument == 2  // Reajustados
				fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)
				Loop
			EndIF	
		EndIf 
	    
		cAnoMes	:= MesAno(dDatAum)
		// Calcula Salario Mes , Dia , Hora do Funcionario
		fSalario(@nSalario,@nSalHora,@nSalDia,@nSalMes,"A",cAnoMes, , SRA->RA_CATFUNC)
				
		If cPaisLoc == "MEX"
			nSalMes := SRA->RA_SALMES
			nSalHora:= SRA->RA_SALHORA
			nSalDia := SRA->RA_SALDIA	
	
			SRA->(RegtoMemory("SRA",.F.,.F.,.F.) )
			
			// Monta os Dados para a Enchoice
			aArea		:= GetArea()
			dbSelectArea("SRA")
			dbSetOrder(1)
			cKey		:= ( SRA->(RA_FILIAL+ RA_MAT ))
			aSRACols	:= SRA->( GdMontaCols(@aSraHeader,@nSraUsado,@aSraVirtual,	@aSraVisual,"SRA",aSraFields,@aSRAColsRec,"SRA",cKey))				
		
			aSvSraCols	:= aClone( aSraCols )
		
			For nLoop := 1 To nLoops
				aAdd( aSraFields , aSraHeader[ nLoop , 02 ] )
				SetMemVar( aSraHeader[ nLoop , 02 ] , aSraCols[ 1 , nLoop ] , .T. , .T. )
			Next nLoop
	   		RestArea(aArea)
		Endif

		lAltFunc := .T.

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica a Faixa em Que o Salario Vai Entrar                 ³
		//³ Verifica se a data de admissao esta dentro da faixa.         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nOrdem # 3
			IF nTipAum == 1 //Dissidio
				nSalFaixa := 0
				fSalBase(@nSalFaixa, cAnoMes, , SRA->RA_CATFUNC)
			else
				nSalFaixa := nSalMes
			EndIf
			nPos := Ascan(aFaixas, { |X| (nSalFaixa >= X[1] .And. nSalFaixa <= X[2]) .AND.;
			 							  IF(!empty(x[5]),(SRA->RA_ADMISSA >=X[5] .AND. SRA->RA_ADMISSA <=X[6]),.T.)})					  
		Else
			dbSelectArea( "SRJ" )
			If dbSeek( xFilial("SRJ", SRA->RA_FILIAL) + SRA->RA_CODFUNC )
				cFuncCCT := ""
                If lAtuSalAux .OR. (cRaCodFunc != SRA->RA_CODFUNC) .OR. lUsaRI4
                    nSalAux 	:= fGetSalFunc(@cFuncCCT)
                EndIf 
				nPos 			:= Ascan(aFaixas, { |X| (nSalAux >= X[1] .And. nSalAux <= X[2] ) .AND. If(!Empty(x[5]),(SRA->RA_ADMISSA >=X[5] .AND. SRA->RA_ADMISSA <=X[6]),.T.)})
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Armazena a funcoes que sofrerao os aumentos  dentro dos inter³
				//³ valos escolhidos                                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nPos8 := Ascan(aFaixas, { |X| (nSalAux >= X[1] .And. nSalAux <= X[2] ) }) 
				nPos9 := ascan(aFuncoes, {|X| X[1]+X[2]+X[4]==SRJ->(RJ_FILIAL+RJ_FUNCAO)+cFuncCCT }) 
				If nPos8 > 0  .and. nPos9 <= 0 
					aadd(aFuncoes,{ SRJ->RJ_FILIAL, SRJ->RJ_FUNCAO, If(Empty(cFuncCCT),SRJ->RJ_SALARIO,nSalAux), cFuncCCT } ) 
				Endif 
				If nTipAum == 3 .And. (nAtuFun == 1 .Or. nAtuFun == 3) .And. nAtuCad == 2
					nPosAux  := 0
					lAltFunc := (nPosAux := Ascan(aFaixas, {|X| (nSalMes >= X[1] .And. nSalMes <= X[2] ) .AND. If(!Empty(x[5]), (SRA->RA_ADMISSA >= X[5] .AND. SRA->RA_ADMISSA <= X[6]), .T.)})) > 0
					nPos     := If(nPos == 0, nPosAux, nPos)
				EndIf
			Endif
		Endif			
	
		dbSelectArea( "SRA" )
		//Se o salário não entrar nas faixas, ler o próximo funcionário
		If nPos == 0 
			dbSelectArea( "SRA" )
			fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)
			Loop
		Endif
		
		nPerProp := 0
		nSalBase := 0
		nBaseDis := 0
		nNovoSal := 0
		nNovoDis := 0
        nPercDif := 0
        nValAum  := 0
	
	   	If ExistBlock("GPM690PERC") 
	   		ExecBlock("GPM690PERC",.F.,.F.) 
		Endif
	
		// Calculo do Reajuste e Salario Novo
		If  nAtuFun <> 2
			If nOrdem # 3 //nao e por funcao
				If nTipAum == 1  //Dissidio
					IF  SRA->RA_CATFUNC $ cCatMensal				
						nSalBase := nSalMes            
					ElseIf SRA->RA_CATFUNC $ "D"
						nSalBase := nSalDia
					Else
						nSalBase := nSalHora 
					EndIf
					
					nBaseDis := SRA->RA_ANTEAUM
					nNovoDis := nBaseDis
					nNovoSal := nSalBase
					nNovoDis := nBaseDis * ( 1 + ( IIF (nPercDif > 0 , nPercDif, aFaixas[nPos,3])  / 100 ) ) 
					nNovoDis := nNovoDis + IIF (nValAum > 0 , nValAum , aFaixas[nPos,4])
				ElseIf nTipAum == 2 //Antecipacao
					IF  SRA->RA_CATFUNC $ cCatMensal
						nSalBase := nSalMes            
					ElseIf SRA->RA_CATFUNC $ "D"
						nSalBase := nSalDia
					Else
						nSalBase := nSalHora 
					EndIf
	
					nBaseDis := SRA->RA_ANTEAUM
					nNovoDis := nBaseDis
					nNovoSal := nSalBase
					nNovoSal := nSalBase * ( 1 + ( IIF (nPercDif > 0 , nPercDif, aFaixas[nPos,3]) / 100 ) ) 
					nNovoSal := nNovoSal + IIF (nValAum > 0 , nValAum , aFaixas[nPos,4])
				ElseIf nTipAum == 3 // Aumento Real
					IF  SRA->RA_CATFUNC $ cCatMensal				
						nSalBase := nSalMes            
					ElseIf SRA->RA_CATFUNC $ "D"
						nSalBase := nSalDia
					Else
						nSalBase := nSalHora 
					EndIf
					nNovoSal := nSalBase * ( 1 + ( IIF (nPercDif > 0 , nPercDif, aFaixas[nPos,3]) / 100 ) ) 
					nNovoSal := nNovoSal + IIF (nValAum > 0 , nValAum , aFaixas[nPos,4])
					nNovoDis := nNovoSal
					nBaseDis := Max(SRA->RA_ANTEAUM, nSalBase)
				Endif
			Else
				If ( nPosFAtu := aScan( aFuncoes, { |X| X[1]+X[2]+X[4] == SRJ->(RJ_FILIAL + RJ_FUNCAO)+cFuncCCT } ) ) > 0
					nSalBase := aFuncoes[ nPosFAtu, 3 ]
					nNovoSal := aFuncoes[ nPosFAtu, 3 ]
				Else
					nSalBase := fGetSalFunc()
					nNovoSal := fGetSalFunc()				
				EndIf
				fCalcNewSal( nSalBase, aFaixas, nPos, lAumento, @nNovoSal, @nBaseDis, @nNovoDis )
			Endif					
	
			// Calculo Proporcional do Aumento Salario
			If lProAdm .And. nOrdem # 3
				nBaseMes  := ((val(substr(cAnoMesProp,1,4)) * 12) + val(substr(cAnoMesProp,5,2))) - ((Year(SRA->RA_ADMISSA) * 12) + Month(SRA->RA_ADMISSA))
				nBaseMes  := If(nBaseMes < 0,0, nBaseMes) 				
				nMesAux   := StrZero(Month(SRA->RA_ADMISSA),2)
				If nMesAux $ "01*03*05*07*08*10*12"
					nDiaAux = 31
				ElseIf nMesAux $ "04*06*09*11"
					nDiaAux = 30
				Else
					If Mod(Year(SRA->RA_ADMISSA),4) = 0
						nDiaAux = 29
					Else
						nDiAaux = 28
					Endif
				Endif
				If nDiaAux - Day(SRA->RA_ADMISSA) + 1 >= 15
					nBaseMes := nBaseMes + 1
				Endif
	
				// P.E. para alterar os meses proporcionais  - nBaseMes
				If ExistBlock("GPREAJPROP") 
					ExecBlock("GPREAJPROP",.F.,.F.) 
				Endif
	
			Else
				nBaseMes := 12
			Endif
	
			If nBaseMes < nMesProp   
				nReajSal := ( ( nNovoSal - nSalBase ) * nBaseMes ) / nMesProp
				nReajDis := ( ( nNovoDis - nBaseDis ) * nBaseMes ) / nMesProp
				nNovoSal := ( nSalBase + nReajSal )
				nNovoDis := ( nBaseDis + nReajDis )
				nPerProp := ( IIF (nPercDif > 0 , nPercDif, aFaixas[nPos,3]) * nBaseMes ) / nMesProp
			Else
				nReajSal := nNovoSal - nSalBase
				nReajDis := nNovoDis - nBaseDis
			Endif
	        
			If SRA->RA_CATFUNC $ cCatMensal		
				nNovoSal := If( lPiso :=( nNovoSal > 0 .and. nPisoMes > nNovoSal), nPisoMes, nNovoSal)
				nNovoDis := If( nNovoDis > 0 .and. nPisoMes > nNovoDis, nPisoMes, nNovoDis)
				nReajSal := If( nNovoSal == nPisoMes,nNovoSal - nSalBase,nReajSal)
				nReajDis := If( nNovoDis == nPisoMes,nNovoDis - nBaseDis,nReajDis)
			ElseIf SRA->RA_CATFUNC $ "D"
				nNovoSal := If( lPiso:=(nNovoSal>0 .and. nPisoDia > nNovoSal), nPisoDia, nNovoSal)
				nNovoDis := If( nNovoDis>0 .and. nPisoDia > nNovoDis, nPisoDia, nNovoDis)
				nReajSal := If( nNovoSal == nPisoDia,nNovoSal - nSalBase,nReajSal)
				nReajDis := If( nNovoDis == nPisoDia,nNovoDis - nBaseDis,nReajDis)
			Else	
				nNovoSal := If( lPiso := (nNovoSal>0 .and. nPisoHora > nNovoSal), nPisoHora, nNovoSal)
				nNovoDis := If( nNovoDis > 0 .and. nPisoHora > nNovoDis, nPisoHora, nNovoDis)
				nReajSal := If( nNovoSal == nPisoHora,nNovoSal - nSalBase,nReajSal)
				nReajDis := If( nNovoDis == nPisoHora,nNovoDis - nBaseDis,nReajDis)
			EndIf

			// Calcula com os Criterios de Arredondamento
			If nOrdem # 3
				If nCriterio == 1
					nNovoDis := NoRound(nNovoDis)
					nReajDis := NoRound(nReajDis)
					nNovoSal := NoRound(nNovoSal)
					nReajSal := NoRound(nReajSal)
				ElseIf nCriterio == 2
					nNovoDis := Round(nNovoDis,MsDecimais(1))
					nReajDis := Round(nReajDis,MsDecimais(1))
					nNovoSal := Round(nNovoSal,MsDecimais(1))
					nReajSal := Round(nReajSal,MsDecimais(1))
				Else	
					If nNovoDis - Round(nNovoDis,MsDecimais(1)) > 0.00
						nNovoDis := NoRound((nNovoDis + .01),MsDecimais(1))
					Else
						nNovoDis := Round(nNovoDis,MsDecimais(1))
						nReajDis := Round(nReajDis,MsDecimais(1))
					Endif
					If nNovoSal - Round(nNovoSal,MsDecimais(1)) > 0.00
						nNovoSal := NoRound((nNovoSal + .01),MsDecimais(1))
					Else
						nNovoSal := Round(nNovoSal,MsDecimais(1))
						nReajSal := Round(nReajSal,MsDecimais(1))
					Endif
				Endif

				If nArredonda # 0
					nValArre := 0
					CalcArre(@nNovoDis, nArredonda, @nValArre)
					CalcArre(@nNovoSal, nArredonda, @nValArre)
				Endif
			Else
				If cPaisLoc == "CHI"
					If nCriterio == 1
						nNovoSal := NoRound(nNovoSal)
						nReajSal := NoRound(nReajSal)
						nNovoDis := NoRound(nNovoDis)
					ElseIf nCriterio == 2
						nNovoSal := Round(nNovoSal,MsDecimais(1))
						nReajSal := Round(nReajSal,MsDecimais(1))
						nNovoDis := Round(nNovoDis,MsDecimais(1))
				   Endif
				Endif

				If nArredonda # 0
					nValArre := 0
					CalcArre(@nNovoDis, nArredonda , nValArre)
					CalcArre(@nNovoSal, nArredonda, @nValArre)
				Else
					If nCriterio == 1
						nNovoDis := NoRound(nNovoDis)
						nReajDis := NoRound(nReajDis)
						nNovoSal := NoRound(nNovoSal)
						nReajSal := NoRound(nReajSal)
					ElseIf nCriterio == 2
						nNovoDis := Round(nNovoDis,MsDecimais(1))
						nReajDis := Round(nReajDis,MsDecimais(1))
						nNovoSal := Round(nNovoSal,MsDecimais(1))
						nReajSal := Round(nReajSal,MsDecimais(1))
					Else	
						If nNovoDis - Round(nNovoDis,MsDecimais(1)) > 0.00
							nNovoDis := NoRound((nNovoDis + .01),MsDecimais(1))
						Else
							nNovoDis := Round(nNovoDis,MsDecimais(1))
							nReajDis := Round(nReajDis,MsDecimais(1))
						Endif
						If nNovoSal - Round(nNovoSal,MsDecimais(1)) > 0.00
							nNovoSal := NoRound((nNovoSal + .01),MsDecimais(1))
						Else
							nNovoSal := Round(nNovoSal,MsDecimais(1))
							nReajSal := Round(nReajSal,MsDecimais(1))
						Endif
					Endif
				Endif
			Endif
			
			//Executa a formula para calculo de outros salarios
			If cPaisLoc == "MEX"
				M->RA_SALARIO := If(nNovoDis > nNovoSal , nNovoDis , nNovoSal)
				If Gp010ValSal()
					CalcSDI("327SDI", .F.)
				Endif	
			Endif			
			// Calcula o Bloco para o Funcionario
			aPosicao1:={} // Limpa Arrays
			Aadd(aPosicao1,{0,0,0,0,0,0,0,0,0,0})
			nPerProp := If( nPerProp > 0, nPerProp, IIF (nPercDif > 0 , nPercDif, aFaixas[nPos,3]) )
	
			// Atualiza o Bloco para os Totalizadores
			If nOrdem # 3		
				If nTipAum # 1 // diferente de dissidio
					nPos0 := nSalMes
					nPos1 := nSalHora
					nPos2 := nPerProp
					nPos3 := IIF (nValAum > 0 , nValAum , aFaixas[nPos,4])
					nPos4 := nReajSal
					If SRA->RA_CATFUNC $ cCatMensal				
						nPos5 := nNovoSal
					ElseIf SRA->RA_CATFUNC $ "D"
						nPos5 := nNovoSal * 30
					Else
						nPos5 := nNovoSal * SRA->RA_HRSMES
					EndIf	
	
	   				If SRA->RA_CATFUNC $ "H*T*G*J"
	   					nPos6 := nNovoSal 
	   				ElseIf SRA->RA_CATFUNC $ "D"
	   				 	nPos6 := (nNovoSal* 30 ) / SRA->RA_HRSMES
	   				Else
	   					nPos6 := nNovoSal / SRA->RA_HRSMES 
	   				EndIf
	   					
					nPos7 := nValArre
				Else //dissidio
					nPos0 := SRA->( IF( RA_CATFUNC $ cCatMensal, nBaseDis , nBaseDis * SRA->RA_HRSMES ))
					nPos1 := SRA->( IF( RA_CATFUNC $ "H*T*G*J"		 , nBaseDis , nBaseDis / SRA->RA_HRSMES ))
					nPos2 := nPerProp
					nPos3 := IIF (nValAum > 0 , nValAum , aFaixas[nPos,4])
					nPos4 := nReajDis
					If SRA->RA_CATFUNC $ cCatMensal				
						nPos5 := nNovoDis 
					ElseIf SRA->RA_CATFUNC $ "D"
						nPos5 := nNovoDis*30 	
					Else
						nPos5 := nNovoDis * SRA->RA_HRSMES 
					EndIf
						
					If SRA->RA_CATFUNC $ "H*T*G*J"
						nPos6 := nNovoDis
	   				ElseIf SRA->RA_CATFUNC $ "D"
	   				 	nPos6 := (nNovoDis *30)/SRA->RA_HRSMES
	   				Else                        
						nPos6 := nNovoDis / SRA->RA_HRSMES 
					EndIf	
					nPos7 := nValArre
				Endif
				If cPaisLoc == "MEX"
					nPos10 := GetMemVar("RA_SALINTA")  //Salario Diario Integrado Anterior
					nPos11 := GetMemVar("RA_SALINT")   //Salario Diario Integrado
				Endif
			Else
				nPos0 := fGetSalFunc()
				nPos0 := IF (nPosFAtu > 0, aFuncoes[ nPosFAtu, 3 ], fGetSalFunc() )
				nPos1 := 0
				nPos2 := nPerProp
				nPos3 := IIF (nValAum > 0 , nValAum , aFaixas[nPos,4])
				nPos4 := nReajSal
				nPos5 := nNovoSal
				nPos6 := 0
				nPos7 := nValArre
				nFunc ++
			Endif			
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Quando o Tipo de Pagamento For Semanal e as Categorias forem ³
			//³ Semanalista ou Tarefeiro, converte para o Salario da Semana  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		    IF SRA->( RA_TIPOPGT = "S" .and. RA_CATFUNC $ "S*T" )
	    		nNovoSal := ( ( nNovoSal / 30 ) * 7 ) 
				nNovoDis := ( ( nNovoDis / 30 ) * 7 ) 						
			EndIF
	
			If cPaisLoc == "MEX"
				Atualiza(@aPosicao1,1,nPos0,nPos1,nPerProp,nPos3,nPos4,nPos5,nPos6,nPos7,nPos10,nPos11)
			Else
				Atualiza(@aPosicao1,1,nPos0,nPos1,nPerProp,nPos3,nPos4,nPos5,nPos6,nPos7)
			EndIf
	
			// Atualizando Totalizadores
			fAtuCont(@aToTFun1) // Funcao
			fAtuCont(@aToTCc1)  // Centro de Custo
			fAtuCont(@aTotFil1) // Filial
			fAtuCont(@aTotEmp1) // Empresa
	
			If nAtuCad == 1
				// Impressao do Funcionario
				fImpFun()
			ElseIf nAtuCad == 2
	
				// Valida trajetoria Laboral e grava informaçoes no RCP
				If cPaisLoc == "MEX"
					M->RA_TIPOALT 	:= cTipAum
					M->RA_DATAALT	:= dDatAum
					Gp010Adm(.T., NIL, SRA->RA_FILIAL)	
					If Len(aModTraj) > 0 .And. Empty(aLog)
					   GravaRCP()
					Endif   
				Endif
				
				If Empty(aLog) 

					If lAltFunc 
						// Variaveis de memoria para uso em fGravaSr3()
						M->RA_CC      := SRA->RA_CC
						M->RA_CARGO   := SRA->RA_CARGO              
						M->RA_ANTEAUM := SRA->RA_ANTEAUM
						M->RA_SALARIO := SRA->RA_SALARIO
						
						// desativa restricao de acesso para garantir a gravação correta das tabelas.
						If FindFunction("SPFilTerOff")
							SPFilTerOff( { "SR3", "SR7" } )
						Endif
		
						// Grava as Informacoes no SR3 e SR7
						fGravaSr3(dDatAum, cTipAum, If(nTipAum # 1, If(nNovoDis > nNovoSal, nNovoDis, nNovoSal), nNovoDis), nAtuCad,, nAtuDiss)
						
						// Ativa novamente a restrição de acesso.
						If FindFunction("SPFilTerOff")
							SPFilTerOff( { "SR3", "SR7" }, .F. )
						Endif
		
						// Ponto de Entrada para atualizar tabela personalizada
						If lGpAltSal
							Execblock("GPALTSAL",.F.,.F.,)
						Endif
		
						// Atualizando SRA
						dbSelectArea( "SRA" )
						RecLock( "SRA" , .F. )
						SRA->RA_SALARIO := If(nNovoDis > nNovoSal , nNovoDis , nNovoSal)
						
						If  lGestPubl  //Se Gestao de Folha Publica - SIGAGFP, atualiza tambem o subsidio de carreira e Dissidio
							SRA->RA_SUBCARR := If(nNovoDis > nNovoSal , nNovoDis , nNovoSal)
							SRA->RA_ANTEAUM := nNovoDis
						EndIf
						
						If cPaisLoc == "MEX"
							SRA->RA_SALINT	:= GetMemVar("RA_SALINT")
							SRA->RA_SALMES 	:= GetMemVar("RA_SALMES")
							SRA->RA_SALDIA 	:= GetMemVar("RA_SALDIA")
							SRA->RA_SALHOR	:= GetMemVar("RA_SALHOR")
							SRA->RA_SALIVC	:= GetMemVar("RA_SALIVC")
							SRA->RA_SALINS	:= GetMemVar("RA_SALINS")
							SRA->RA_SALMESA	:= GetMemVar("RA_SALMESA")
							SRA->RA_SALDIAA	:= GetMemVar("RA_SALDIAA")
							SRA->RA_SALHORA	:= GetMemVar("RA_SALHORA")
							SRA->RA_SALINTA	:= GetMemVar("RA_SALINTA")
							SRA->RA_SALIVCA	:= GetMemVar("RA_SALIVCA")
							SRA->RA_SALINSA	:= GetMemVar("RA_SALINSA")
						Endif
						If nAtuDiss == 2 
							SRA->RA_ANTEAUM := If(!Empty(nNovoDis),nNovoDis,SRA->RA_SALARIO)
						Endif
						MsUnlock()      
						
						// Ponto de Entrada executado apos atualizacao dos cadastros
						If ExistBlock("GPR200ATU")
							Execblock("GPR200ATU",.F.,.F.,)
						Endif	
					EndIf

					// Atualizando SRJ
					If ( nAtuFun == 1 .or. nAtuFun == 3 ) .and. nNovoSal > 0	//-- Funcao Atribuida / Ambos 
						fGravaSRJ(@lGravaAum,@lAumento, nNovoSal, SRA->RA_CODFUNC )
						cRaCodFunc 	:= SRA->RA_CODFUNC
						lAtuSalAux 	:= .F. 
						lGravaAum 	:= .F.
						lAumento  	:= .F.
					Endif
				EndIf	

				If !lAutomato
					If lAltFunc .And. M->RA_SALARIO != SRA->RA_SALARIO
						aAdd(aLogAlt[1], STR0081 + SRA->RA_FILIAL + STR0082 + SRA->RA_MAT + STR0083 + SRA->RA_NOME) //"Filial: "###"- Matrícula: "###"- Nome: "
						aAdd(aLogAlt[1], STR0084 + cValToChar(AllTrim(Transform(M->RA_SALARIO, "@E 999,999,999.99"))) + STR0085 + cValToChar(AllTrim(Transform(SRA->RA_SALARIO, "@E 999,999,999.99"))) + ".") //"Salário antigo: "###" | Salário atualizado: "
						If nAtuDiss == 2 
							aAdd(aLogAlt[1], STR0086 + cValToChar(AllTrim(Transform(M->RA_ANTEAUM , "@E 999,999,999.99"))) + STR0087 + cValToChar(AllTrim(Transform(SRA->RA_ANTEAUM, "@E 999,999,999.99"))) + ".")//"Salário dissídio antigo: "###| Salário dissídio atualizado: 
						Endif
						If ( nAtuFun == 1 .or. nAtuFun == 3 ) .And. nNovoSal > 0 .And. !lAtuSalAux
							aAdd(aLogAlt[1], STR0088 + AllTrim(SRJ->RJ_FUNCAO) + STR0089 + cValToChar(AllTrim(Transform(nSalBase, "@E 999,999,999.99"))) + STR0090 + AllTrim(SRJ->RJ_FUNCAO) + STR0091 + cValToChar(AllTrim(Transform(nNovoSal, "@E 999,999,999.99"))) + ".") //"Salário da função "###" antigo: "###" | Salário da função"###"atualizado:"
						EndIf
						aAdd(aLogAlt[1], "")
					ElseIf !lAltFunc .And. (nAtuFun == 1 .Or. nAtuFun == 3) .And. nNovoSal > 0 .And. !lAtuSalAux
						aAdd(aLogAlt[1], STR0081 + SRA->RA_FILIAL + STR0082 + SRA->RA_MAT + STR0083 + SRA->RA_NOME)
						aAdd(aLogAlt[1], STR0088 + AllTrim(SRJ->RJ_FUNCAO) + STR0089 + cValToChar(AllTrim(Transform(nSalBase, "@E 999,999,999.99"))) + STR0090 + AllTrim(SRJ->RJ_FUNCAO) + STR0091 + cValToChar(AllTrim(Transform(nNovoSal, "@E 999,999,999.99"))) + ".")
						aAdd(aLogAlt[1], "")
					EndIf	
				EndIf	
			Endif
		Endif

		cSindAnt := SRA->RA_SINDICA
		
		fTestaTotal(@lGravaAum,@lAumento, @nNovoSal)  	// Quebras e Skips
	
		If ( nAtuFun == 1 .or. nAtuFun == 3 ) .and. nNovoSal > 0 	//-- Funcao Atribuida 
			fGravaSRJ(@lGravaAum,@lAumento, nNovoSal, cFuAnt, cFilialAnt, .F., cSindAnt)
			lGravaAum := .F.
			lAumento  := .F.
			nNovoSal := 0
		Endif

    	If lIntegDef
	    	SetRotInteg("GPEA250")
		    FwIntegDef("GPEA250")
	    EndIf
		
	Enddo
	If nAtuCad == 2
		PcoFinLan('000087')	
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Aplica aumento para os codigos de funcao que nao estao atri- ³
	//³ buidos a nenhum  funcionario e de acordo c/parametrizacao    ³
	//³ Valido somente quando for por ordem  de funcao (Ordem 03)    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nAtuFun <> 1 
		fAtualSRJ( aFuncoes, aFaixas ) 
	Endif 

End Transaction

dbSelectArea( "SRA" )
Set Filter To
dbSetOrder(1)

Set Device To Screen
If aReturn[5] = 1
	Set Printer To
	Commit
	// Spool caso Opcao seja de Relatorio, senao sai apresenta-lo
	If nAtuCad == 1
		ourspool(wnrel)
	Endif
Endif

MS_FLUSH()
Return	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³GPR200LinOk³ Autor ³ Marcos A. Stiefano    ³ Data ³ 27/06/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³Critica linha digitada                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³ Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPR200LinOk()
Local lRet     := .T.
Local nX	   := 0 	
Local dDtIni   := aCols[n,5]
Local dDtFim   := aCols[n,6]	
Local nFxIni	:= aCols[n,1]
Local nFxFim	:= aCols[n,2]
		
// Desconsidera Faixas deletadas
If aCols[n,7] == .F.
	If aCols[n,1] > aCols[n,2]
		Help(" ",1,"GR200FAIXA")
		lRet := .F.
		Return( lRet )
	Endif
	
	If n > 1
		If empty(aCols[n,5]) .and. empty(aCols[n,6])
			If (aCols[n,1] <= aCols[n-1,2]) .and. !aCols[n-1,7]
				Help(,, OemToAnsi(STR0059),, + CRLF + OemToAnsi(STR0079), 1, 0,,,,,, { + CRLF + OemToAnsi(STR0080)})//"Atencao" ## "Valor inicial menor ou igual o valor final da faixa anterior" ## "O valor inicial deve ser maior que o valor final da faixa anterior"
				lRet := .F.
				Return( lRet )
			EndIf	
		Endif
	EndIf
	
	If ( aCols[n,3] = 0 ) .And. ( aCols[n,4] = 0 )
		Help(" ",1,"GR200ZEROS")
		lRet := .F.
		Return( lRet )
	Endif
	
	If !empty(aCols[n,5]) .and. empty(aCols[n,6]) .or. ;
		empty(aCols[n,5]) .and. !empty(aCols[n,6])
		Aviso(STR0048,STR0049,{"OK"},,STR0050) //"Atencao"###"Preencha a data de admissao"###"Data em Branco"
		lRet := .F.
		Return( lRet )
	EndIf	
	
	For nX := 1 to len(aCols)
		If nX # n .and. aCols[nX,7] == .F. .and. n > nX .and. !empty(aCols[nX,5]) .and. !empty(aCols[nX,6])
			If	(dDtIni < aCols[nX,5] .and. dDtFim < aCols[nX,5]) .or.	;
				(dDtIni > aCols[nX,6])
				lRet := .T.
			Else
				If	(nFxIni < aCols[nX,1] .and. nFxFim < aCols[nX,1]) .or. ;
					(nFxIni > aCols[nX,2])
					lRet	:= .T.
				Else
					Aviso(STR0048,STR0051,{"OK"},,STR0052) //"Atencao"###"Informe uma data que esteja fora dos periodos ja informados"###"Data Invalida."
					lRet := .F.
					Exit
				EndIf
	    	EndIf
		EndIf    
	Next nX	
	
	If !empty(aCols[n,6]) .and. aCols[n,7] == .F.
		If aCols[n,6] < aCols[n,5]
			Aviso(STR0048,STR0053,{"OK"},,STR0052) //"Atencao"###"Data de Admissao Inicial maior que a data final"###"Data Invalida."
			lRet := .F.
		EndIf	
	EndIf	
	  	
Endif

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³GPR200TudOk³ Autor ³ Marcos A. Stiefano    ³ Data ³ 27/06/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³ Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function GPR200TudOk()
Local lRetorna  := .T.
Continua := .F.

Return lRetorna

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Atualiza(aMatriz,nElem,nPos0,nPos1,nPos2,nPos3,nPos4,nPos5,nPos6,nPos7,nPos10,nPos11)
aMatriz[nElem,1] := nPos0
aMatriz[nElem,2] := nPos1
aMatriz[nElem,3] := nPos2
aMatriz[nElem,4] := nPos3
aMatriz[nElem,5] := nPos4
aMatriz[nElem,6] := nPos5
aMatriz[nElem,7] := nPos6
aMatriz[nElem,8] := nPos7
If cPaisLoc == "MEX"
	aMatriz[nElem,9] := nPos10
	aMatriz[nElem,10]:= nPos11                         
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³fTestaTotalºAutor  ³Microsiga          º Data ³  09/09/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Testa as quebras do relatório para imprimir as totalizacoes º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fTestaTotal(lGravaAum,lAumento, nNovoSal)

Default lGravaAum   := .F.
Default lAumento	:= .F.
Default nNovoSal	:= 0

dbSelectArea( "SRA" )
cFilialAnt := SRA->RA_FILIAL              // Iguala Variaveis
cCcAnt     := SRA->RA_CC
cFuAnt     := SRA->RA_CODFUNC
dbSkip()


// Nao Imprime Totais caso seja Atualizacao
If nAtuCad == 2
	Return Nil
Endif

If Eof() .Or. &cInicio > cFim  
	If Empty(aInfo)   
		fInfo(@aInfo,SRA->RA_FILIAL)
	EndIf
	fImpFu(.T.,cFilialAnt,cFuAnt,.T. )
	fImpCc(.T.)
  	fImpFil(.T.)
	fImpEmp(.T.)
Elseif cFilialAnt # SRA->RA_FILIAL
	fImpFu(.T.,cFilialAnt,cFuAnt )
	fImpCc()
 	fImpFil()
Elseif (cCcAnt # SRA->RA_CC) .and. nOrdem == 2
	fImpCc()
Elseif (cFuAnt # SRA->RA_CODFUNC) .and. nOrdem == 3
	fImpFu(.T.,cFilialAnt,cFuAnt )
Endif

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fImpFun()
Local lRetu1  := .T.
Local nTamMat := Len(AllTrim(SRA->RA_MAT)) - 6

nTamMat := 30 - IIf(nTamMat < 0,0,nTamMat)

cDet := STR0031+SRA->RA_FILIAL+STR0032+SUBS(SRA->RA_CC+SPACE(15),1,15)+STR0033 + AllTrim(SRA->RA_MAT) //"FILIAL: "###" CCTO: "###" MAT: "
cDet += STR0034+SUBS(If(lOfuscaNom,Replicate('*',15),SRA->RA_NOME)+SPACE(nTamMat),1,nTamMat)+AllTrim(STR0035)+DtoC(SRA->RA_ADMISSA)    //" NOME: "###" DT.ADMISSAO: "
cDet += STR0036+SRA->RA_CATFUNC+IIf(cPaisLoc=="BRA"," "+AllTrim(STR0037)+SRA->RA_SINDICA,"")          //" CATEGORIA: "###" SINDICATO: "
Impr(cDet,"C")

Impr("","C")

lRetu1 := fImpComp(aPosicao1,1)

cDet := Repl("-",132)
Impr(cDet,"C")
Impr("","C")
return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fImpFu(lTotalFun,cFilialAnt,cFuAnt, lTot)
Local lRetu1 := .T.

DEFAULT lTotalFun	:= .F.
DEFAULT lTot			:= .F.

If Len(aTotFun1) == 0 .Or. nOrdem # 3 
	return
Endif

cDet:=STR0031+cFilialAnt+STR0038+cFuAnt+" - "+DescFun(cFuAnt,cFilialAnt)	//"FILIAL: "###" FUNCAO: "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotFun1,1,lTotalFun, lTot) // Imprime

aTotFun1 :={}      // Zera

cDet := Repl("=",132)
Impr(cDet,"C")
Impr("","C")
return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fImpCc(lTot)
Local lRetu1 := .T.
DEFAULT lTot			:= .F.

If Len(aTotCc1) == 0 .Or. nOrdem # 2
	return
Endif

cDet:=STR0031+cFilialAnt+STR0032+cCcAnt+" - "+DescCc(cCcAnt,cFilialAnt)	//"FILIAL: "###" CCTO: "
Impr(cDet,"C")
Impr("","C")

lRetu1 	:=	fImpComp(aTotCc1,1,,lTot) // Imprime

aTotCc1 :=	{}      // Zera

cDet 	:= 	Repl("=",132)
Impr(cDet,"C")
Impr("","C")
return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fImpFil(lTot)
Local lRetu1 := .T.
Local cDescFil
DEFAULT lTot			:= .F.

If Len(aTotFil1) == 0
	return
Endif

If (li + 4) > 58
	Impr("","P")
Endif 
cDescFil := aInfo[1] + Space(25)
cDet     := STR0031+cFilialAnt+" - "+cDescFil	//"FILIAL: "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotFil1,1,,lTot) // Imprime

aTotFil1 :={}      // Zera

cDet := Repl("#",132)
Impr(cDet,"C")
Impr("","C")
return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fImpEmp(lTot)
Local lRetu1 := .T.
DEFAULT lTot			:= .F.

If Len(aTotEmp1) == 0
	return
Endif

If (li + 4) > 58
	Impr("","P")
Endif 
cDet:=STR0039+aInfo[3]		//"Empresa: "
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotEmp1,1,,lTot) // Imprime

aTotEmp1 :={}      // Zera

Impr("","F")
return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fImpComp(aPosicao,nLugar,lTotalFun,lTot)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ aPosicao = Array Contendo o que Vai ser Impresso            ³
//³ nLugar   = Posicao Fisica dos Grupos de Impressao           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nResImp := 0

AeVal(aPosicao,{ |X| nResImp += X[1] })  // Testa se a Soma == 0
// Imprime se Possui Valores
If nResImp > 0 
	If nOrdem # 3
		If cPaisLoc <> "MEX"
			If !lTot
				cDet := STR0040	//" SALARIO ANTIGO  SALARIO HORA ANTIGO  PERCENTUAL + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  SALARIO HORA NOVO  ARREDONDAMENTO"
			Else
				cDet := STR0061	//" SALARIO ANTIGO  SALARIO HORA ANTIGO + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  SALARIO HORA NOVO  ARREDONDAMENTO"				
			EndIf
		Else
			If !lTot 
				cDet:= STR0057    //" SALARIO ANTIGO  SAL.DIARIO INT. ANT  PERCENTUAL + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  SAL.DIA.INT. NOVO  ARREDONDAMENTO"
			Else
				cDet:= STR0062    //" SALÁRIO ANTIGO  SAL. DIARIO  INT.  ANT  + VALOR ADICIONAL   =   REAJUSTE  SALÁRIO NOVO  SAL.DIA.INT.  NOVO   ARREDONDAMENTO"
			EndIf				
		Endif
		Impr(cDet,"C")		
		cDet := "   "      +TRANSFORM(aPosicao[1,1],"@E 999999999.99")
		If cPaisLoc <> "MEX"
			cDet += "         "+TRANSFORM(aPosicao[1,2],"@E 999999999.99")
		Else
			cDet += "         "+TRANSFORM(aPosicao[1,9],"@E 999999999.99")
		Endif	
		If !lTot
			cDet += "  "       +TRANSFORM(aPosicao[1,3],"@E 999.999999")
		EndIf
		cDet += "      "   +TRANSFORM(aPosicao[1,4],"@E 999999999.99")
		cDet += "   "      +TRANSFORM(aPosicao[1,5],"@E 999999999.99")
		cDet += "  "       +TRANSFORM(aPosicao[1,6],"@E 999999999.99")
		If cPaisLoc <> "MEX"
			cDet += "       "  +TRANSFORM(aPosicao[1,7],"@E 999999999.99")
		Else
			cDet += "       "  +TRANSFORM(aPosicao[1,10],"@E 999999999.99")
		Endif	
		cDet += "    "     +TRANSFORM(aPosicao[1,8],"@E 999999999.99")
		Impr(cDet,"C")
	Else
		If lTotalFun
			If !lTot
				cDet := STR0041	//" SALARIO ANTIGO  PERCENTUAL + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  ARREDONDAMENTO"
			Else
				cDet := STR0063	//" SALARIO ANTIGO   + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  ARREDONDAMENTO"
			EndIf
			Impr(cDet,"C")		
			cDet := "   "      +TRANSFORM(aPosicao1[1,1],"@E 999999999.99")
			If !lTot
				cDet += "  "       +TRANSFORM(aPosicao1[1,3],"@E 999.999999")
			EndIf				
			cDet += "      "   +TRANSFORM(aPosicao1[1,4],"@E 999999999.99")
			cDet += "   "      +TRANSFORM(aPosicao1[1,5],"@E 999999999.99")
			cDet += "  "       +TRANSFORM(aPosicao1[1,6],"@E 999999999.99")
			cDet += "    "     +TRANSFORM(aPosicao1[1,8],"@E 999999999.99")
			Impr(cDet,"C")
			Impr("","C") 

			cDet := STR0054+ALLTRIM(str(nFunc)) + STR0055 //"== > T O T A I S  P A R A  "###"  F U N C I O N A R I O(S):"
			Impr(cDet,"C")
			Impr("","C")  
			nFunc := 0
		EndIf		
		If !lTot	
			cDet := STR0041	//" SALARIO ANTIGO  PERCENTUAL + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  ARREDONDAMENTO"
		Else
			cDet := STR0063	//" SALARIO ANTIGO   + VALOR ADICIONAL   =   REAJUSTE  SALARIO NOVO  ARREDONDAMENTO"
		EndIf
			
		Impr(cDet,"C")		
		cDet := "   "      +TRANSFORM(aPosicao[1,1],"@E 999999999.99")
		If !lTot
			cDet += "  " +TRANSFORM(aPosicao[1,3],"@E 999.999999")
		EndIf
		cDet += "      "   +TRANSFORM(aPosicao[1,4],"@E 999999999.99")
		cDet += "   "      +TRANSFORM(aPosicao[1,5],"@E 999999999.99")
		cDet += "  "       +TRANSFORM(aPosicao[1,6],"@E 999999999.99")
		cDet += "    "     +TRANSFORM(aPosicao[1,8],"@E 999999999.99")
		Impr(cDet,"C")
	Endif
	Li++
	Return( .T. )
Else
	Return( .F. )
Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fAtuCont(aArray1)
Local x := 0
Local z := 1
Local nAte := 0

nAte := If( cPaisLoc == "MEX",10,8)

If  Len(aArray1) > 0
	For x:= 1 To nAte
			aArray1[z,x] += aPosicao1[z,x]
	Next x
Else
	aArray1 := Aclone(aPosicao1)
Endif
return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function CalcArre(nValor,nArred,nValArred)
Local nResto := 0

nResto := Mod(nValor,nArred)

If Round(nResto,MsDecimais(1)) > 0.00
	nValArred := nArred - nResto
	nValor    := nValor + nValArred
Else
	nValArred := 0.00
Endif
Return( .T. )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function r200Dt1()
Local lRet := .T.

If !empty(aCols[n,6]) .and. aCols[n,7] == .F.
	If aCols[n,6] < M->GPR200DT1
		lRet := .F.
	EndIf	
Endif
Return( lRet )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³           ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso     ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function r200Dt2()
Local lRet := .T.

If  !empty(aCols[n,6]).and. aCols[n,7] == .F.
	If aCols[n,5] > M->GPR200DT2
		lRet := .F.
	EndIf	
Endif
Return( lRet )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER200   ºAutor  ³Microsiga           º Data ³  06/12/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula o valor do piso salarial em mes/horas/dias conformeº±±
±±º          ³categoria funcional escolhida.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function r200Piso(nPisoMes,nPisoHora,nPisoDia)
If  cCategoria $ cCatMensal
	nPisoHora 	:= nPisoMes/220
	nPisoDia  	:= nPisoMes/30	
ElseIf cCategoria $ "H*T*G*J"
	nPisoMes 	:= nPisoHora *220
	nPisoDia 	:= (nPisoHora*220)/30	
ElseIf cCategoria $ "D"              
	nPisoMes	:= nPisoDia * 30
	nPisoHora 	:= (nPisoDia*30)/220
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fAtualSRJ ºAutor  ³Microsiga           º Data ³  06/22/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Efetua o reajuste salarial para os codigos de funcao que naoº±±
±±º          ³estao atribuidas aos funcionarios.                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/ 
Static Function fAtualSRJ(aFuncoes, aFaixas ) 
Local nBaseDis 		:= 0 
Local nNovoDis 		:= 0 
Local nSalBase 		:= 0	
Local nNovoSal 		:= 0
Local nReajSal  	:= 0
Local nValArre  	:= 0
Local nPos 			:= 0  
Local cFunAnt		:= Space(4)
Local cDet			:= ""
Local cFilDeSRJ 	:= xFilial("SRJ", cFilDe)
Local cFilAteSRJ	:= xFilial("SRJ", cFilAte) 
Local cInicio 		:= "SRJ->RJ_FILIAL + SRJ->RJ_FUNCAO"
Local cFim   		:= cFilAteSRJ + cFunAte
Local lAumento  	:= .F.
Local lGravaAum 	:= .F.
Local lFirst 		:= .T. 
Local nPisoMes		:= nVlPiso 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Aplica aumento para os codigos de funcao que nao estao atri- ³
//³ buidos a nenhum  funcionario                                 ³
//³ Valido somente quando for por ordem  de funcao               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 3 
	SRJ->( dbSeek( cFilDeSRJ + cFunDe , .T. )) 
	While !( SRJ->(Eof() )) .And. &cInicio <= cFim 

		If (nPos:= ascan(aFuncoes, {|x| SRJ->(RJ_FILIAL+ RJ_FUNCAO ) == x[1]+ x[2] }   ))  <= 0
			If cFunAnt #  SRJ->(RJ_FILIAL+ RJ_FUNCAO )
				lAumento  	:= .F.
				lGravaAum 	:= .F.
				cFunAnt 	:= SRJ->(RJ_FILIAL+ RJ_FUNCAO )
			Endif 
			// Aplica Percentual/Valor do aumento
			aPosicao1:=	{} 
			nBaseDis := 0 
			nNovoDis := 0 
			nSalBase := SRJ->RJ_SALARIO
			nNovoSal := SRJ->RJ_SALARIO
			nPos :=  Ascan(aFaixas, { |X| (SRJ->RJ_SALARIO >= X[1] .And. SRJ->RJ_SALARIO <= X[2] )  }) 
			If nPos  > 0 
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ O Piso salarial nao sera aplicado para este calculo  pois no ³
				//³ SRJ nao podemos identificar em qual unidade esta cadastrado  ³				
				//³ o valor ( Mensal/semanal/Diario,etc)                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                
				fCalcNewSal( nSalBase, aFaixas, nPos , lAumento, @nNovoSal, @nBaseDis, @nNovoDis ) 
				nNovoSal := If(( nNovoSal > 0 .and. nPisoMes > nNovoSal), nPisoMes, nNovoSal)	
				nReajSal := nNovoSal - nSalBase 
				If nArredonda # 0 
					nValArre := 0 
					CalcArre(@nNovoSal, @nArredonda, @nValArre)  
				Endif 

				// Calcula o Bloco para o Funcionario
				Aadd(aPosicao1,{SRJ->RJ_SALARIO,0,IIF (nPercDif > 0 , nPercDif, aFaixas[nPos,3]),IIF (nValAum > 0 , nValAum , aFaixas[nPos,4]),nReajSal,nNovoSal,0,nValArre,0,0})
				fAtuCont(@aToTFun1) 
				// Impressao dos reajustes por Funcao
				If lFirst 
					fImpCab() 
					lFirst 	:= .F.
				Endif	
				fImpFu(.F.,SRJ->RJ_FILIAL,SRJ->RJ_FUNCAO ) 
				If ( nAtuFun == 2 .or. nAtuFun == 3 ) 	//-- Atualiza Cadastro  de Funcoes
					// Atualizando SRJ
					fGravaSRJ(lGravaAum,lAumento, nNovoSal, SRJ->RJ_FUNCAO, SRJ->RJ_FILIAL, .T. )
				Endif
				
			Endif
		Endif
		SRJ->(dbSkip()) 
	Enddo 
Endif 
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCalcNewSalºAutor ³Microsiga           º Data ³  06/21/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Aplica o Valor percentual e/ou acrescenta o valor do aumentoº±±
±±º          ³informado                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCalcNewSal( nSalBase, aFaixas, nPos, lAumento, nNovoSal, nBaseDis, nNovoDis )
If nTipAum # 2 // diferente de antecipacao
	nBaseDis := SRA->RA_ANTEAUM
	nNovoDis := nBaseDis * ( 1 + ( IIF (nPercDif > 0 , nPercDif, aFaixas[nPos,3])  / 100 ) ) 
	nNovoDis := nNovoDis + IIF (nValAum > 0 , nValAum , aFaixas[nPos,4])
EndIf

// Calcular aumento apenas uma vez p/ atualizacao no Cad.Funcoes
If !lAumento .Or. nAtuFun == 4
	nNovoSal := nSalBase * ( 1 + ( IIF (nPercDif > 0 , nPercDif, aFaixas[nPos,3])  / 100 ) ) 
	nNovoSal := nNovoSal + IIF (nValAum > 0 , nValAum , aFaixas[nPos,4])
	If nAtuFun <> 4 .And. SRA->RA_SALARIO > nNovoSal .And. SRA->RA_SALARIO > nNovoDis
		nNovoDis := SRA->RA_SALARIO * ( 1 + (IIF(nPercDif > 0, nPercDif, aFaixas[nPos,3])  / 100)) 
		nNovoDis := SRA->RA_SALARIO + IIF(nValAum > 0, nValAum, aFaixas[nPos,4])
	EndIf
Endif 

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGravaSRJ ºAutor  ³Microsiga           º Data ³  06/22/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Efetua a gravacao do aumento no Cadastro de Funcoes         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fGravaSRJ(lGravaAum,lAumento, nNovoSal, cCodFunc, cFilialAnt, lNAtrib, cSindic ) 
Local aArea		:= GetArea()
Local cFilSRJ	:= xFilial("SRJ",cFilialAnt)

DEFAULT lNAtrib := .F.
DEFAULT cSindic := SRA->RA_SINDICA

If nOrdem == 3 .And. !lGravaAum	 .and. ;
  (nAtuFun == 1 .or. nAtuFun == 2 .or. nAtuFun == 3 )			//-- Atualiza se for Ordem 3 ( fil+funcao), se atualiza funcao 
	lAumento :=.T.
	lGravaAum :=.T.
	
	dbSelectArea( "SRJ" )
	If dbSeek( xFilial("SRJ",cFilialAnt) + cCodFunc )
		If !lSalCCT .or. lNAtrib
			RecLock( "SRJ" , .F. )
			SRJ->RJ_SALARIO := nNovoSal
			MsUnlock()
		Else 
			RCE->(DbSeek(xFilial("RCE",cFilialAnt) + cSindic))

			RI4->(DbSetOrder(2)) //RI4_FILSRJ + RI4_CODSRJ
			
			RI4->(DbSeek(cFilSRJ + cCodFunc))
			
			While RI4->(!Eof() .And. RI4_FILSRJ + RI4_CODSRJ == cFilSRJ + cCodFunc)
				If RI4->RI4_CODCCT == RCE->RCE_CCT
					RecLock("RI4", .F.)
					RI4->RI4_SALARI := nNovoSal 
					MsUnLock()
					Exit
				EndIf
				RI4->(DbSkip())
			EndDo 
		EndIf
	EndIf
EndIf           

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpCab   ºAutor  ³Microsiga           º Data ³  06/23/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Efetua a impressao de cabecalho dos codigos de funcao que   º±±
±±º          ³sofreram  aumento salarial ( funcoes nao atribuidas)        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpCab()
Local cDet	:= OemToAnsi(STR0056) 			//-- "Rela‡„o das Fun‡”es Reajustadas ( nao atribu¡das aos funcion rios)"
Impr("","P")
Impr(cDet,"C") 
Impr("","C")
Return

/*                                	
ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿
³Fun‡„o    ³ MenuDef		³Autor³  Luiz Gustavo     ³ Data ³18/12/2006³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´
³Descri‡„o ³Isola opcoes de menu para que as opcoes da rotina possam    ³
³          ³ser lidas pelas bibliotecas Framework da Versao 9.12 .      ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Sintaxe   ³< Vide Parametros Formais >									³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³ Uso      ³GPER200                                                     ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³ Retorno  ³aRotina														³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Parametros³< Vide Parametros Formais >									³
ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/   
Static Function MtnFakeaRot()

Local aRotina :=   {{ STR0011, "        ", 0 , 1,,.F.},;	//"Pesquisar"
						{ STR0012, "        ", 0 , 2},;		//"Visualizar"
						{ STR0013, "        ", 0 , 3},;		//"Incluir"
						{ STR0014, "        ", 0 , 4},;		//"Alterar"
						{ STR0015, "        ", 0 , 5} }		//"Excluir"

Return aRotina



//-------------------------------------------------------------------
/*/{Protheus.doc} fAlertJob
Função para exibição de alerta e link para o TDN com orientação sobre
envio de alterações salariais
@author  Rafael Reis
@since   29/10/2018
@version 1
/*/
//-------------------------------------------------------------------
Static Function fAlertJob()
Local oButton1
Local oCheckBo1
Local lCheckBo1 := .F.
Local oGroup1
Local oPanel1
Local oSay1
Local oSay2
Local cSession	:= "AlertaAltSalarial"
Local lChkMsg := fwGetProfString(cSession,"MSG_JOBALTSAL_" + cUserName,'',.T.) == ""
Static oDlg

If lChkMsg

	DEFINE MSDIALOG oDlg TITLE OemToAnsi(STR0001) FROM 000, 000  TO 200, 500 COLORS 0, 16777215 PIXEL //#STR0001 = "Emissão do Aumento Salarial"

		@ 000, 000 MSPANEL oPanel1 SIZE 300, 150 OF oDlg COLORS 0, 16777215 RAISED
		@ 005, 012 GROUP oGroup1 TO 055, 237 PROMPT OemToAnsi(STR0072) OF oPanel1 COLOR 0, 16777215 PIXEL //#STR0072 = "Atenção"
		@ 022, 017 SAY oSay1 PROMPT OemToAnsi(STR0073) SIZE 215, 025 OF oPanel1 COLORS 0, 16777215 PIXEL //#STR0073 = "As alterações salariais serão integradas com o TAF através da execução do JOB, conforme orientações no link abaixo."
		@ 063, 012 SAY oSay2 PROMPT "http://tdn.totvs.com/x/dQdFFw" SIZE 095, 007 OF oPanel1 COLORS 0, 16777215 PIXEL
		@ 080, 012 CHECKBOX oCheckBo1 VAR lCheckBo1 PROMPT OEMToAnsi(STR0074) SIZE 067, 008 OF oPanel1 COLORS 0, 16777215 PIXEL //#STR0074 = "Não exibir novamente"
		@ 070, 200 BUTTON oButton1 PROMPT "OK" SIZE 037, 012 OF oPanel1 PIXEL

		oSay2:bLClicked := {|| ShellExecute("open","http://tdn.totvs.com/x/dQdFFw","","",1) }

		oButton1:bLClicked := {|| oDlg:End() }

	ACTIVATE MSDIALOG oDlg CENTERED

	If lCheckBo1
		fwWriteProfString(cSession,"MSG_JOBALTSAL_" + cUserName, 'CHECKED', .T.)
	Endif
	
Endif

Return


/*/{Protheus.doc} fSalBase
	(Similar a fSalario(), porém ao invés de usar o "RA_SALARIO", utiliza a "RA_ANTEAUM" 
	para retornar o "Salário Base Dissidio" para filtro para calculo do dissidio.)
	@type  Static Function
	@author Emerson Grassi Rocha
	@since 06/05/2022
	@version version
	@param param_name, param_type, param_descr
	@return return_var, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
/*/
Static Function fSalBase(SalMes,cAnMes,cNroPagto, cCatMensal)
Local aArea			:= GetArea()
Local cKeySeek		:= ""
Local dData			:= CtoD("//")
Local lMAprendiz  	:= GetMvRH("MV_MAPREND",,.F.)
Local nDiasCalc		:= 0
Local nHrsCalc		:= 0
Local nValor		:= 0
Local cMes			:= ""
Local cAno			:= ""
Local nNumSemana	:= 0
Local nDiasSem		:= 7
Local nUltDia 		:= 0

DEFAULT cCatMensal  := "M"
DEFAULT cAnMes      := If(Empty(cAnMes),(If(Type("cAnoMes") # "U", cAnoMes, MesAno(dDataBase))), cAnMes)
DEFAULT cNroPagto	:= If(Empty(cNroPagto),(If(Type("cSemana") # "U", cSemana, "01")), cNroPagto)

cCatMensal += IIf(ExistFunc("fUsaGFP") .and. fUsaGFP(), "*0*1*2*3*4*5*6*7*8*9", "")

If cPaisLoc == "BRA" .And. SRA->RA_CATFUNC == "S"
	SetMnemonicos(xFilial("RCA"),NIL,.T.,"P_NTOTDIAS")
	nDiasSem := P_NTOTDIAS
EndIf

cMes			:= SubStr(cAnMes,5,2)
cAno			:= SubStr(cAnMes,1,4)
dData			:= CtoD("01/" + cMes + "/" + cAno)

dbSelectArea("RCF")
dbSetOrder(5)  // RCF_FILIAL+RCF_PER+RCF_SEMANA+RCF_ANO+RCF_MES+RCF_PROCES+DTOS(RCF_DTINI)+DTOS(RCF_DTFIM)+RCF_MODULO
cKeySeek	:= cAnMes + cNroPagto + cAno + cMes + SRA->RA_PROCES
If RCF->( dbSeek(xFilial("RCF") + cKeySeek) )
	nDiasCalc	:= RCF->RCF_DCALCM
EndIf

nHrsCalc := IIf(nDiasCalc > 0 .And. SRA->RA_HRSDIA > 0, Round((SRA->RA_HRSDIA * nDiasCalc),2), IIf(SRA->RA_HRSMES > 0, SRA->RA_HRSMES, 0))

// Menor Aprendiz
If SRA->RA_CATEG = '07' .And. lMAprendiz

	nHrsCalc 	:= IIf(nDiasCalc > 0 .And. SRA->RA_HRSMES > 0, SRA->RA_HRSMES, nHrsCalc)
	nUltDia 	:= F_ULTDIA(dData)
	nNumSemana := IIf(nUltDia == 31, 4.428571, IIf(nUltDia == 30, 4.285714, IIf(nUltDia == 29, 4.142857, 4 ) ))

	If SRA->RA_CATFUNC = "H"
		nValor :=  nHrsCalc  / 5
		nValor := (nValor * nNumSemana) * SRA->RA_ANTEAUM
		SalMes := (nValor * 7 ) / 6
	ElseIf SRA->RA_CATFUNC $ cCatMensal
		Salmes := SRA->RA_ANTEAUM
	EndIf

Else
	SalMes := 	IIf(SRA->RA_CATFUNC $ cCatMensal, SRA->RA_ANTEAUM,;
				IIf(SRA->RA_CATFUNC $ "C*P*A*E" .And. SRA->RA_TIPOPGT == "S", ( SRA->RA_ANTEAUM / 7 ) * nDiasCalc,;
				IIf(SRA->RA_CATFUNC $ "C*P*A*E" .And. SRA->RA_TIPOPGT == "M", SRA->RA_ANTEAUM,;
				IIf(SRA->RA_CATFUNC $ "H*G*T", SRA->RA_ANTEAUM * nHrsCalc,;
				IIf(SRA->RA_CATFUNC == "D", SRA->RA_ANTEAUM * nDiasCalc,;
				IIf(SRA->RA_CATFUNC == "S", ( SRA->RA_ANTEAUM / nDiasSem  ) * nDiasCalc, SalMes) ) ) )) )
EndIf
RestArea(aArea)
Return

/*/{Protheus.doc} fGetSalFunc
	Obtém o salário da função de acordo com CCT, se houver.
	@type  Static Function
	@author Leandro Drumond
	@since 09/04/2024
/*/
Static Function fGetSalFunc(cFuncCCT)
Local nRet		:= SRJ->RJ_SALARIO

Static __cFilFunc
Static __nValSal

DEFAULT cFilFunc  := ""
DEFAULT cFuncCCT  := ""

If lUsaRI4
	If __cFilFunc == SRA->RA_FILIAL + SRA->RA_MAT 
		nRet := __nValSal 
	Else
		lSalCCT := .F.
		If !Empty(SRA->RA_SINDICA) .and. RCE->(DbSeek(xFilial("RCE",SRA->RA_FILIAL) + SRA->RA_SINDICA)) .and. !Empty(RCE->RCE_CCT)
			RI4->(DbSetOrder(2)) //RI4_FILSRJ + RI4_CODSRJ
			If RI4->(DbSeek(SRJ->RJ_FILIAL + SRJ->RJ_FUNCAO))
				While RI4->(!Eof() .And. RI4_FILSRJ + RI4_CODSRJ == SRJ->RJ_FILIAL + SRJ->RJ_FUNCAO)
					If RI4->RI4_CODCCT == RCE->RCE_CCT 
						If RI4->RI4_SALARI > 0
							nRet     := RI4->RI4_SALARI
							cFuncCCT := RCE->RCE_CCT 
							lSalCCT  := .T.
						EndIf
						Exit
					EndIf
					RI4->(DbSkip())
				EndDo 
			EndIf
		EndIf

		__cFilFunc := SRA->RA_FILIAL + SRA->RA_MAT 
		__nValSal  := nRet
	EndIf
EndIf

Return nRet
