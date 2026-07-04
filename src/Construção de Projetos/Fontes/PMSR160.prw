/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PMSR160.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Pmsr160   ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 06.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao de informacoes para tomada de decisoes do projeto ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PmsR160()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1   := STR0001 //"Este relatorio ira imprimir informacoes"
Local cDesc2   := STR0002 //"do  projeto  baseado  no  historico  de"
Local cDesc3   := STR0003 //"acompanhamento para tomada de decisoes."
Local cString  := "AF8"
Local lDic     := .F.
Local lComp    := .T.
Local lFiltro  := .T.
Local wnrel    := "PMSR160"

Private nomeprog 	:= "PMSR160"
Private Cabec1 		:= STR0004
Private Cabec2 		:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso ultrapasse, utiliza o tamanho grande de Lay-Out                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo   := STR0005 //"Sistema de informacoes do Projeto"
Private Tamanho := "G"   // P/M/G
Private Limite  := 220 //80/132/220
Private nli     := 100 // Contador de Linhas
Private aOrdem  := {}  // Ordem do Relatorio
Private cPerg   := "PMR160"  // Pergunta do Relatorio
Private aReturn := { STR0006, 1,STR0007, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)

Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault

If PMSBLKINT()
	Return Nil
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³ MV_PAR01 : Projeto   de ?                                              ³
//³ MV_PAR02 : Ate?                                                        ³
//³ MV_PAR03 : Data projeto de                                    		   ³
//³ MV_PAR04 : Data projeto ate                                   		   ³
//³ MV_PAR05 : Versao ?		Branco = Todas, 1-2;3-3;5-5                    ³
//³ MV_PAR06 : Nivel ?                                                     ³
//³ MV_PAR07 : Fase ?                                                      ³
//³ MV_PAR08 : Data de referencia                                          ³
//³ MV_PAR09 : Cliente De                                                  ³
//³ MV_PAR10 : Loja De                                                     ³
//³ MV_PAR11 : Cliente Ate                                                 ³
//³ MV_PAR12 : Loja Ate                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrint                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif

// Propriedades do relatorio

/*
CODIGO E DESCRICAO                                                                          UM  CUSTO PRV.TER.  INDICE COTP     INDICE COTE     INDICE CRTE     VC   %  VP   %  EST. TERMINO  INDICE ECT      IDC  %  IDP  %

1            - TAREFA 1                                                                     %   999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999.99  999.99   99/99/9999   999,999,999.99  999.99  999.99
*/

PmrAddPropO("PROPRIEDADESIMPRESSAO",,;
			{ 	{ "INDICES:CUSTO_PREVISTOTERMINO", 096, "@E 999,999,999.99"	 	},;
				{ "INDICES:COTP"                 , 112, "@E 999,999,999.99"		},;
				{ "INDICES:COTE"                 , 128, "@E 999,999,999.99"		},;
				{ "INDICES:CRTE"                 , 145, "@E 999,999,999.99"		},;
				{ "INDICES:VC"                   , 159, "@E 9999.99"			},;
				{ "INDICES:VP"                   , 167, "@E 9999.99"			},;
				{ "INDICES:ESTIMATIVA_TERMINO"   , 177, "@D"         			},;
				{ "INDICES:ECT"                  , 190, "@E 999,999,999.99"		},;
				{ "INDICES:IDC"                  , 205, "@E 9999.99"			},;
				{ "INDICES:IDP"                  , 213, "@E 9999.99"			} })

PmrAddPropO("ROTINADETALHE",, "PmrDet160")
PmrAddPropO("ESTRUTURA_PROJETO",, {})
PmrAddPropO("TODA_MATRIZ_PROJETO",, .T.)
PmrAddPropO("INDICES",, .T.)
PmrAddPropO("INDREGUA","COMPLEMENTO" ,"AF8_CLIENTE  >= '" + mv_par09 + "' .and. AF8_LOJA >= '" + mv_par10 + "' .and. " + ;
								"AF8_CLIENTE <= '" + mv_par11 + "' .and. AF8_lOJA <= '" + mv_par12 + "'" )
RptStatus({|lEnd| PMRSelReg(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMRDet160   ³ Autor ³ Wagner Mobile Costa ³ Data ³06.08.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe da estrutura                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PmrDet160(cPar1, nPar1, aPar1)                        	   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³cPar1 = Nome do programa chamador                            ³±±
±±³          ³nPar1 = Linha para impressao                                 ³±±
±±³          ³aPar1 = Matriz o projeto corrente                            ³±±
±±³          ³ { { { CODIGO DA EDT/TAREFA, DESCRICAO, RECNO, TABELA } }    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function PmrDet160(NomeProg, nLi, aProjeto)

Local lSepTrac
Local nNewLiP := 0
Local aEstrutura
Local nIndice

For nIndice := 1 To Len(aProjeto)
	lSepTrac	:= .F.
	aEstrutura 	:= aProjeto[nIndice]

/*
CODIGO E DESCRICAO                                                                          UM  CUSTO PRV.TER.  INDICE COTP     INDICE COTE     INDICE CRTE     VC   %  VP   %  EST. TERMINO  INDICE ECT      IDC  %  IDP  %

1            - TAREFA 1                                                                     %   999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999.99  999.99   99/99/9999   999,999,999.99  999.99  999.99
*/    

	DbSelectArea(aEstrutura[4])
	DbGoto(aEstrutura[3])

	If ( nli > 60 )
		nli := cabec(Titulo,Cabec1,Cabec2,nomeprog,Tamanho,CHRCOMP)
		nli++
		nNewLiP := nLi
	Endif

 	If aEstrutura[4] = "AF8" .Or. nNewLiP = nLi
 		If aEstrutura[4] = "AF8"
			@ nli,000 PSAY Left(STR0008 + aEstrutura[1] + " - " + aEstrutura[2], 90) //"Definicao do projeto "
			nLi++
			@ nli,000 PSAY STR0010 + SA1->A1_COD + "  -  " + FATPDObfuscate(SA1->A1_NOME,"A1_NOME",Nil,.T.) //"Cliente :"
		Else
			(aEstrutura[4])->(MsGoTo(aEstrutura[3]))
			AF8->(DbSetOrder(1))
			AF8->(MsSeek(xFilial()+(aEstrutura[4])->&(aEstrutura[4]+"_PROJET")))
			@ nli,000 PSAY Left(STR0008 + AF8->AF8_PROJET + " - " + AF8->AF8_DESCRI, 90) //"Definicao do projeto "
			nLi++
			@ nli,000 PSAY STR0010 + SA1->A1_COD + "  -  " + FATPDObfuscate(SA1->A1_NOME,"A1_NOME",Nil,.T.) //"Cliente :"
			nLi++
		Endif
		lSepTrac := aEstrutura[4] # "AF8"
	ElseIf nIndice > 1 .And. (	aProjeto[nIndice - 1][4] = "AF8" .Or.;
								aProjeto[nIndice - 1][4] = "AFC" .Or.;
							   (aProjeto[nIndice - 1][4] = "AF9" .And.;
							    aEstrutura[4] = "AFC"))		// Anterior for Projeto ou EDT
    	@ nLi++,000 PSAY __PrtThinLine()				// Ou Atual EDT e anterior TAREFA
	Endif

	If aEstrutura[4] = "AFC" 		// Edt
		@ nli,000 PSAY Left(STR0009 + aEstrutura[1] + " - " + aEstrutura[2], 90) //"EDT "
	ElseIf aEstrutura[4] = "AF9" 	// Tarefa
		@ nli,000 PSAY Left(aEstrutura[1] + " - " + aEstrutura[2] , 90)
		@ nli,092 PSAY AF9->AF9_UM
	Endif
    	
	PMRCalcObjI(NomeProg, @nLi, aEstrutura)
   	
	If lSepTrac .Or. nIndice = Len(aProjeto)
	    @ nLi++,000 PSAY __PrtThinLine()
	Endif
Next	

Return .T.

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  

