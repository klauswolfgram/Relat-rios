/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr852.ch"
#INCLUDE "Protheus.ch"
#INCLUDE "MSOLE.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR852  ³ Autor ³ Denis Hyroshi Souza   ³ Data ³ 14.10.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Este programa emite relatorio do PCMAT                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR852()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM( )
Local lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
Local i := 1
Private nTipoDoc      := 1 //Indica que o documento é o PCMAT
Private cPathEst := Alltrim(GetMv("MV_DIREST")) 			// PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHO
Private aImagens := {}
Private aTipoInsc := fTipoINSC()//"C.G.C."
Private cInscCli := ""

MDTREL852()

For i:=1 to Len(aImagens)
	If File(aImagens[i][1]+"JPG")
		Ferase(aImagens[i][1]+"JPG")  //Apaga imagem extraida do repositorio
	Endif
	If File(aImagens[i][1]+"BMP")
		Ferase(aImagens[i][1]+"BMP")  //Apaga imagem extraida do repositorio
	Endif
Next i

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTREL852³ Autor ³ Denis                 ³ Data ³ 04.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de Impressao do PCMAT                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MDTREL852()
Local oRadOp,oDLGppra
Private cPathBmp := Alltrim(GetMv("MV_DIRACA"))	// Path do arquivo logo .bmp do cliente
PRIVATE lSigaMdtPS    := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
Private nModeloImp    := 1
PRIVATE cCliMdtPs     := " "
Private aFuncionarios := {}
Private aFuncRisco    := {}
PRIVATE nFuncRisco    := 0
Private lMdtUmCC      := lMDT190UMCC()
Private nSizeSI3      := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
Private nSizeCli      := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
Private nSizeLoj      := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
Private cAliasCC      := "SI3"
Private cDescrCC      := "SI3->I3_DESC"
Private aNfrisco      := {}
Private lMdtUnix := If( GetRemoteType() == 2 .or. isSRVunix() , .T. , .F. ) //Verifica se servidor ou estacao é Linux
PRIVATE titulo        := " "

titulo := STR0004 //"Programa de Condições do Meio Ambiente de Trabalho na Construção Civil"

//Campos da tela
Private cCli_O := Space(Len(SA1->A1_COD))
Private cLoj_O := Space(Len(SA1->A1_LOJA))
Private cNom_O := Space(Len(SA1->A1_NOME))

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cDescrCC := "CTT->CTT_DESC01"
Endif

lRet  := .f.

DEFINE MSDIALOG oDLGppra FROM  0,0 TO 150,320 TITLE STR0005 PIXEL //"Selecione o Modelo do Relatório"

@ 10,10 TO 55,150 LABEL STR0006 of oDLGppra Pixel //"Modelo do Relatório"
@ 20,14 RADIO oRadOp VAR nModeloImp ITEMS "Word",STR0007,STR0008 SIZE 70,15 PIXEL OF oDLGppra //"Padrão"###"Gráfico"

DEFINE SBUTTON FROM 59,90  TYPE 1 ENABLE OF oDLGppra ACTION EVAL({|| lRET := .T.,oDLGppra:END()})
DEFINE SBUTTON FROM 59,120 TYPE 2 ENABLE OF oDLGppra ACTION oDLGppra:END()

ACTIVATE MSDIALOG oDLGppra CENTERED

If lRet
	If nModeloImp == 1
		fMDT852WOR()
	Else
		fMDT852PDR()
	Endif
Endif

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDT852VTO0³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida Codigo do Laudo                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR852                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDT852VTO0(nTipo)
Local lRet := .t.
Local aArea := GetArea()

If nTipo == 1
	dbSelectArea("TO0")
	dbSetOrder(1)
	If dbSeek(xFilial("TO0")+mv_par01)
		If TO0->TO0_TIPREL != "7"
			MsgInfo(STR0009) //"O Tipo de Laudo não é PCMAT."
			lRet := .f.
		Else
			dbSelectArea("TLL")
			dbSetOrder(1)
			If !dbSeek(xFilial("TLL")+TO0->TO0_CC)
				MsgInfo(STR0010) //"O Centro de Custo informado no Laudo não está cadastrado como Obra."
				lRet := .f.
			Endif
		Endif
	Else
		Help(" ",1,"REGNOIS")
		lRet := .f.
	Endif
Else
	dbSelectArea("TO0")
	dbSetOrder(6)
	If dbSeek(xFilial("TO0")+mv_par01+mv_par02+Mv_par03)
		If TO0->TO0_TIPREL != "7"
			MsgInfo(STR0009) //"O Tipo de Laudo não é PCMAT."
			lRet := .f.
		Else
			dbSelectArea("TLL")
			dbSetOrder(1)
			If !dbSeek(xFilial("TLL")+TO0->TO0_CC)
				MsgInfo(STR0010) //"O Centro de Custo informado no Laudo não está cadastrado como Obra."
				lRet := .f.
			Endif
		Endif
	Else
		Help(" ",1,"REGNOIS")
		lRet := .f.
	Endif
Endif

RestArea(aArea)
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fMDT852PDR³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio padrao do PCMAT                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR852                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fMDT852PDR()

LOCAL wnrel   := "MDTR852"
LOCAL limite  := 132
LOCAL cDesc1
LOCAL cDesc2
LOCAL cDesc3
LOCAL cString := "TO0"
LOCAL cF3CC := "MDTPS4"  //SI3 apenas do cliente

cDesc1  := STR0011 //"PCMAT - Programa de Condições do Meio Ambiente de Trabalho na Construção Civil"
cDesc2  := STR0012 //"Atraves dos parametros selecionar os itens que devem ser considerados"
cDesc3  := STR0013 //"no Relatorio.                                                        "

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cF3CC := "MDTPS6"  //CTT apenas do cliente
Endif

PRIVATE nomeprog := "MDTR852"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0014, 1,STR0015, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    := If(!lSigaMdtps,"MDT852P   ","MDT852PPS ")
PRIVATE cabec1, cabec2

/*--------------------------------------
//PERGUNTAS PADRÃO						|
| Laudo ?									|
| Coordenador ?							|
| Impressao ?								|
| 											|
//PERGUNTAS DO PRESTADOR DE SERVIÇO	|
| Cliente ?								|
| Loja										|
| Laudo ?									|
| Coordenador ?							|
| Impressao ?								|
----------------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
    Set Filter to
    Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Set Filter to
   Return
Endif

If lSigaMdtps
	cCliMdtPs := Mv_par01+Mv_par02
Endif

If nModeloImp == 2
	RptStatus({|lEnd| R852Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
Else
	RptStatus({|lEnd| R852Grf(@lEnd,wnRel,titulo,tamanho)},titulo)
Endif

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R852Imp  ³ Autor ³ Thiago Olis Machado   ³ Data ³ 04/08/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio PADRAO                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR852                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R852Imp(lEnd,wnRel,titulo,tamanho)
Local cMemo := " ",cTitulo := " ",cTexto := " "
Local lEof := .t.
Local nX
Local nLenMemo := 0
Local nPerMemo := 0

Private lPrint := .t.
Private lPrin2 := .t.
Private lFirst := .t.
Private lJumpCab := .t.
Private lIdentar := .f.
Private aRiscos    := {}
Private aEpis      := {}
Private aExames    := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

cabec1 := " "
cabec2 := " "

dbSelectArea("SM0")
dbSetOrder(1)
dbSeek(cNumEmp)
If lSigaMdtps
	dbSelectArea("TO0")
	dbSetOrder(6)  //cli + loj + laudo
	dbSeek(xFilial("TO0")+cCliMdtps+mv_par03)
	dbSelectArea("TLL")
	dbSetOrder(1)
	dbSeek(xFilial("TLL")+TO0->TO0_CC)
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+cCliMdtps)
Else
	dbSelectArea("TO0")
	dbSetOrder(1)
	dbSeek(xFilial("TO0")+Mv_par01)
	dbSelectArea("TLL")
	dbSetOrder(1)
	dbSeek(xFilial("TLL")+TO0->TO0_CC)
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+TLL->TLL_CODCON+TLL->TLL_LOJCON)
Endif

cCidadeRe     := Capital(Alltrim(SA1->A1_MUN))
cEmp_Nome     := SA1->A1_NOME
If !Empty(SM0->M0_CGC)
	If SM0->M0_TPINSC != 2
		cEmp_Cnpj := Transform(SA1->A1_CGC,"@R 99.999.99999/99")
		cCNPJ_Cliente := Transform(SA1->A1_CGC,"@R 99.999.99999/99")
		cInscCli := STR0081 //"C.G.c. do Contratante"
	Else//CNPJ
		cEmp_Cnpj := Transform(SA1->A1_CGC,"@!R NN.NNN.NNN/NNNN-99")
		cCNPJ_Cliente := Transform(SA1->A1_CGC,"@!R NN.NNN.NNN/NNNN-99")
		cInscCli := STR0019 //"CNPJ do Contratante"
	Endif
Else
	cEmp_Cnpj     := SA1->A1_CGC
	cCNPJ_Cliente := SA1->A1_CGC
	cInscCli := STR0081 //"C.G.c. do Contratante"
Endif
cCidade       := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
cEnd_Obra     := TLL->TLL_ENDERE
cEnd_Cliente  := SA1->A1_END
cTipo_Obra    := Posicione("TLQ",1,xFilial("TLQ")+TLL->TLL_TIPO,"TLQ_DESTIP")
cDataInicio   := DtoC( If( Empty(TLL->TLL_DTINIR) , TLL->TLL_DTINIP , TLL->TLL_DTINIR ) )
cDataFim      := DtoC( If( Empty(TLL->TLL_DTFIMR) , TLL->TLL_DTFIMP , TLL->TLL_DTFIMR ) )
cNumMaximo    := Alltrim(Str(TLL->TLL_NUMERO,6))

SomaLinha()
SomaLinha()
SomaLinha()
SomaLinha()
@ LI,020 PSay STR0011 //"PCMAT - Programa de Condições do Meio Ambiente de Trabalho na Construção Civil"
Somalinha()
Somalinha()
Somalinha()
@ Li,000 Psay "1. "+STR0016 //"DADOS DA OBRA"
Somalinha()
Somalinha()
@ Li,000 Psay STR0017+": "+cEnd_Obra //"Endereço da Obra"
SomaLinha()
@ Li,000 Psay STR0018+": "+cEmp_Nome //"Razão Social do Contratante"
SomaLinha()
@ Li,000 Psay cInscCli+": "+cCNPJ_Cliente //"CNPJ do Contratante"
SomaLinha()
@ Li,000 Psay STR0020+": "+cEnd_Cliente //"Endereço do Contratante"
SomaLinha()
@ Li,000 Psay STR0021+": "+cTipo_Obra //"Tipo de Obra"
SomaLinha()
@ Li,000 Psay STR0022+": "+cDataInicio //"Data de Início da Obra"
SomaLinha()
@ Li,000 Psay STR0023+": "+cDataFim //"Data de Conclusão da Obra"
SomaLinha()
@ Li,000 Psay STR0024+": "+cNumMaximo //"Número máximo previsto de trabalhadores"
Somalinha()
SomaLinha()
SomaLinha()

cMemo := Alltrim(TO0->TO0_DESCRI)
If !Empty(TO0->TO0_MMSYP2)
	cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
	If !Empty(cMMSYP2)
		If !Empty(cMemo)
			cMemo += Chr(13)+Chr(10)
		Endif
		cMemo += cMMSYP2
	Endif

Endif

SetRegua(100)
nLenMemo := Len(cMemo)
nPerMemo := 0

While lEof

	If Empty(cMemo)  //Memo vazio
		lEof := .f.
		Exit
	Else
		nPos1 := At("#",cMemo) //Inicio de um Titulo

		If nPos1 > 1
			cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
			cMemo  := Alltrim(Substr(cMemo,nPos1))
			IMPDOC852(Alltrim(cTexto))
			fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
			Loop
		ElseIf nPos1 == 1 //Existe #
			cMemo   := Alltrim(Substr(cMemo,nPos1+1))
			nPos1   := At("#",cMemo)
			cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
			cMemo   := Alltrim(Substr(cMemo,nPos1+1))

			nPos1   := At("#",cMemo)
			If nPos1 > 0
				cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
				cMemo  := Alltrim(Substr(cMemo,nPos1))
			Else
				cTexto := Alltrim(cMemo)
				cMemo  := " "
				lEof   := .f.
			Endif
		Else //Nao existe #
			//IMPRIME TEXTO
			IMPDOC852(Alltrim(cMemo))
			lEof := .f.
			Exit
		Endif

		//IMPRIME TITULO
		If !Empty(cTitulo)
			IMPHEA852(cTitulo)
		Endif

		//IMPRIME TEXTO
		If !Empty(cTexto)
			lPrint := .t.
			lPrin2 := .t.
			IMPDOC852(Alltrim(cTexto))
		Endif

	Endif

	fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua

End

cTxtMemo := " "
dbSelectArea("TMZ")
dbSetOrder(1)
IF dbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
	cTxtMemo := TMZ->TMZ_DESCRI
Endif

dbSelectArea("TMK")
dbSetOrder(1)
If lSigaMdtps
	dbSeek(xFilial("TMK")+Mv_par04)
Else
	dbSeek(xFilial("TMK")+Mv_par02)
Endif

If Li != 6 //Se o cursor estiver na primeira linha nao eh necessario criar uma nova pagina
	li := 80
	Somalinha()
Endif

@li,048 Psay STR0025 //"RESPONSÁVEIS TÉCNICOS"
For nX := 1 to 3
	Somalinha()
Next nX

IMPDOC852(Alltrim(cTxtMemo))
Somalinha()
Somalinha()
Somalinha()
@li,000 Psay (STR0026+" "+ SubStr(Alltrim(TMK->TMK_NOMUSU),1,40)) //"COORDENADOR:"

Somalinha()
@li,000 Psay (STR0027+" "+Alltrim(TMK->TMK_REGMTB)) //"REG.SSST:"

Somalinha()
@li,000 Psay (If(Empty(TMK->TMK_ENTCLA),STR0028,Alltrim(TMK->TMK_ENTCLA))+": "+Alltrim(TMK->TMK_NUMENT)) //"CRM"

Somalinha()
@li,000 Psay (STR0029+" "+Alltrim(TMK->TMK_TELUSU)) //"FONE:"

Somalinha()
@li,000 Psay (STR0030+" "+Alltrim(TMK->TMK_ENDUSU)) //"ENDEREÇO:"

dbSelectArea("TMK")
dbSetOrder(1)
dbSeek(xFilial("TMK")+TO0->TO0_CODUSU)

SomaLinha()
SomaLinha()
@li,000 Psay (STR0031 + SubStr(Alltrim(TMK->TMK_NOMUSU),1,40)) //"RESPONSÁVEL: "
Somalinha()
@li,000 Psay (If(Empty(TMK->TMK_ENTCLA),STR0028,Alltrim(TMK->TMK_ENTCLA))+": "+Alltrim(TMK->TMK_NUMENT)) //"CRM"

Somalinha()
@li,000 Psay (STR0029+" "+Alltrim(TMK->TMK_TELUSU)) //"FONE:"

Somalinha()
@li,000 Psay (STR0030+" "+Alltrim(TMK->TMK_ENDUSU)) //"ENDEREÇO:"

For nX := 1 to 3
	Somalinha()
Next nX
@li,000 Psay cCidadeRe+", "+StrZero(Day(dDataBase),2)+STR0032+MesExtenso(dDataBase)+STR0032+; //" de "###" de "
			StrZero(Year(dDataBase),4)+"."

Somalinha()
@li,000 Psay (STR0033+" "+Alltrim(Transform(Date(),"99/99/9999"))) //"DATA:"
For nX := 1 to 5
	Somalinha()
Next nX

Somalinha()
@li,000 Psay (STR0034+"___________________________________________") //"Ass.: "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TO0")
Set Filter To
Set device to Screen
If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
MS_FLUSH()

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R852Grf  ³ Autor ³ Denis                 ³ Data ³ 04/03/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio GRAFICO                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR852                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R852Grf(lEnd,wnRel,titulo,tamanho)
Local cMemo := " ",cTitulo := " ",cTexto := " "
Local lEof := .t.
Local nLenMemo := 0
Local nPerMemo := 0
Local cSMCOD := FWGrpCompany()
Local cSMFIL := FWCodFil()

Private lPrint := .t.
Private lPrin2 := .t.
Private lFirst := .t.
Private lJumpCab := .t.
Private lIdentar := .f.
Private aRiscos    := {}
Private aEpis      := {}
Private aExames    := {}
Private nPaginaG   := 0

Private oFont08	 := TFont():New("Verdana",08,08,,.F.,,,,.F.,.F.)
Private oFont08b := TFont():New("Verdana",08,08,,.T.,,,,.F.,.F.)
Private oFont10b := TFont():New("Verdana",10,10,,.T.,,,,.F.,.F.)
Private oFont10	 := TFont():New("Verdana",10,10,,.F.,,,,.F.,.F.)
Private oFont12b := TFont():New("Verdana",12,12,,.T.,,,,.F.,.F.)
Private oFont12  := TFont():New("Verdana",12,12,,.F.,,,,.F.,.F.)
Private oFont12bs:= TFont():New("Verdana",12,12,,.T.,,,,.T.,.T.)
Private oFont12s := TFont():New("Verdana",12,12,,.F.,,,,.T.,.T.)
Private oFont13	 := TFont():New("Verdana",12,12,,.F.,,,,.F.,.F.)
Private oFont28b := TFont():New("Verdana",28,28,,.T.,,,,.F.,.F.)
Private oFont50b := TFont():New("Verdana",50,50,,.T.,,,,.F.,.F.)

oPrintPPRA	:= TMSPrinter():New(OemToAnsi(STR0011)) //"PCMAT - Programa de Condições do Meio Ambiente de Trabalho na Construção Civil"
oPrintPPRA:Setup()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE lin := 9999 ,m_pag := 1

//Caminho do logoppp.bmp
Private cStartDir := AllTrim(GetSrvProfString("StartPath","\"))
Private cStartLogo := " "
If lSigaMdtPS
	If File(cStartDir+"LGRL"+cCliMdtPs+".BMP")
		cStartLogo := cStartDir+"LGRL"+cCliMdtPs+".BMP"
	ElseIf File(cStartDir+"LGRL"+Substr(cCliMdtPs,1,nSizeCli)+".BMP")
		cStartLogo := cStartDir+"LGRL"+Substr(cCliMdtPs,1,nSizeCli)+".BMP"
	Endif
Else
	If File(cStartDir+"LGRL"+cSMCOD+cSMFIL+".BMP")
		cStartLogo := cStartDir+"LGRL"+cSMCOD+cSMFIL+".BMP"
	ElseIf File(cStartDir+"LGRL"+cSMCOD+".BMP")
		cStartLogo := cStartDir+"LGRL"+cSMCOD+".BMP"
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

cabec1 := " "
cabec2 := " "

dbSelectArea("SM0")
dbSetOrder(1)
dbSeek(cNumEmp)
If lSigaMdtps
	dbSelectArea("TO0")
	dbSetOrder(6)  //cli + loj + laudo
	dbSeek(xFilial("TO0")+cCliMdtps+mv_par03)
	dbSelectArea("TLL")
	dbSetOrder(1)
	dbSeek(xFilial("TLL")+TO0->TO0_CC)
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+cCliMdtps)
Else
	dbSelectArea("TO0")
	dbSetOrder(1)
	dbSeek(xFilial("TO0")+Mv_par01)
	dbSelectArea("TLL")
	dbSetOrder(1)
	dbSeek(xFilial("TLL")+TO0->TO0_CC)
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+TLL->TLL_CODCON+TLL->TLL_LOJCON)
Endif

If !Empty(SM0->M0_CGC)
	If SM0->M0_TPINSC != 2
		cEmp_Cnpj := Transform(SA1->A1_CGC,"@R 99.999.99999/99")
		cCNPJ_Cliente := Transform(SA1->A1_CGC,"@R 99.999.99999/99")
		cInscCli := STR0081 //"C.G.c. do Contratante"
	Else//CNPJ
		cEmp_Cnpj := Transform(SA1->A1_CGC,"@!R NN.NNN.NNN/NNNN-99")
		cCNPJ_Cliente := Transform(SA1->A1_CGC,"@!R NN.NNN.NNN/NNNN-99")
		cInscCli := STR0019 //"CNPJ do Contratante"
	Endif
Else
	cEmp_Cnpj     := SA1->A1_CGC
	cCNPJ_Cliente := SA1->A1_CGC
	cInscCli := STR0081 //"C.G.c. do Contratante"
Endif
cCidadeRe     := Capital(Alltrim(SA1->A1_MUN))
cEmp_Nome     := SA1->A1_NOME
cCidade       := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
cEnd_Obra     := TLL->TLL_ENDERE
cEnd_Cliente  := SA1->A1_END
cTipo_Obra    := Posicione("TLQ",1,xFilial("TLQ")+TLL->TLL_TIPO,"TLQ_DESTIP")
cDataInicio   := DtoC( If( Empty(TLL->TLL_DTINIR) , TLL->TLL_DTINIP , TLL->TLL_DTINIR ) )
cDataFim      := DtoC( If( Empty(TLL->TLL_DTFIMR) , TLL->TLL_DTFIMP , TLL->TLL_DTFIMR ) )
cNumMaximo    := Alltrim(Str(TLL->TLL_NUMERO,6))

cTitPPRA := STR0004 //"Programa de Condições do Meio Ambiente de Trabalho na Construção Civil"
SomaLinha(150)
oPrintPPRA:Say(700,900,"PCMAT",oFont50b)
oPrintPPRA:Say(1200,200,MemoLine(cTitPPRA,40,1),oFont28b)
oPrintPPRA:Say(1400,400,MemoLine(cTitPPRA,40,2),oFont28b)

oPrintPPRA:Say(2340,150,STR0035+":",oFont12b) //"EMPRESA"
oPrintPPRA:Say(2340,600,cEmp_Nome,oFont12)
oPrintPPRA:Say(2420,150,aTipoInsc[1],oFont12b) //"C.G.C."
oPrintPPRA:Say(2420,600,cEmp_Cnpj,oFont12)
oPrintPPRA:Say(2500,150,Upper(STR0037)+":",oFont12b) //"CIDADE"
oPrintPPRA:Say(2500,600,cCidade,oFont12)

lin := 9999 //Forçar quebra de pagina
Somalinha(150)
oPrintPPRA:Say(lin,150,"1. "+STR0016,oFont12b) //"DADOS DA OBRA"
Somalinha(80)
oPrintPPRA:Say(lin,150,STR0017+":",oFont12b) //"Endereço da Obra"
oPrintPPRA:Say(lin,620,cEnd_Obra,oFont12)
SomaLinha()
oPrintPPRA:Say(lin,150,STR0018+":",oFont12b) //"Razão Social do Contratante"
oPrintPPRA:Say(lin,900,cEmp_Nome,oFont12)
SomaLinha()
oPrintPPRA:Say(lin,150,cInscCli+":",oFont12b) //"CNPJ do Contratante"
oPrintPPRA:Say(lin,700,cCNPJ_Cliente,oFont12)
SomaLinha()
oPrintPPRA:Say(lin,150,STR0020+":",oFont12b) //"Endereço do Contratante"
oPrintPPRA:Say(lin,800,cEnd_Cliente,oFont12)
SomaLinha()
oPrintPPRA:Say(lin,150,STR0021+":",oFont12b) //"Tipo de Obra"
oPrintPPRA:Say(lin,500,cTipo_Obra,oFont12)
SomaLinha()
oPrintPPRA:Say(lin,150,STR0022+":",oFont12b) //"Data de Início da Obra"
oPrintPPRA:Say(lin,750,cDataInicio,oFont12)
SomaLinha()
oPrintPPRA:Say(lin,150,STR0023+":",oFont12b) //"Data de Conclusão da Obra"
oPrintPPRA:Say(lin,900,cDataFim,oFont12)
SomaLinha()
oPrintPPRA:Say(lin,150,STR0024+":",oFont12b) //"Número máximo previsto de trabalhadores"
oPrintPPRA:Say(lin,1250,cNumMaximo,oFont12)
Somalinha(180)

cMemo := Alltrim(TO0->TO0_DESCRI)
If !Empty(TO0->TO0_MMSYP2)
	cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
	If !Empty(cMMSYP2)
		If !Empty(cMemo)
			cMemo += Chr(13)+Chr(10)
		Endif
		cMemo += cMMSYP2
	Endif
Endif

SetRegua(100)
nLenMemo := Len(cMemo)
nPerMemo := 0

While lEof
	If Empty(cMemo)  //Memo vazio
		lEof := .f.
		Exit
	Else
		nPos1 := At("#",cMemo) //Inicio de um Titulo

		If nPos1 > 1
			cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
			cMemo  := Alltrim(Substr(cMemo,nPos1))
			IMPDOC852(Alltrim(cTexto))
			fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
			Loop
		ElseIf nPos1 == 1 //Existe #
			cMemo   := Alltrim(Substr(cMemo,nPos1+1))
			nPos1   := At("#",cMemo)
			cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
			cMemo   := Alltrim(Substr(cMemo,nPos1+1))

			nPos1   := At("#",cMemo)
			If nPos1 > 0
				cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
				cMemo  := Alltrim(Substr(cMemo,nPos1))
			Else
				cTexto := Alltrim(cMemo)
				cMemo  := " "
				lEof   := .f.
			Endif
		Else //Nao existe #
			//IMPRIME TEXTO
			IMPDOC852(Alltrim(cMemo))
			lEof := .f.
			Exit
		Endif

		//IMPRIME TITULO
		If !Empty(cTitulo)
			IMPHEA852(cTitulo)
		Endif

		//IMPRIME TEXTO
		If !Empty(cTexto)
			lPrint := .t.
			lPrin2 := .t.
			IMPDOC852(Alltrim(cTexto))
		Endif

	Endif

	fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua

End

cTxtMemo := " "
dbSelectArea("TMZ")
dbSetOrder(1)
IF dbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
	cTxtMemo := TMZ->TMZ_DESCRI
Endif

dbSelectArea("TMK")
dbSetOrder(1)
If lSigaMdtps
	dbSeek(xFilial("TMK")+Mv_par04)
Else
	dbSeek(xFilial("TMK")+Mv_par02)
Endif

If Lin != 100 //Se o cursor estiver na primeira linha nao eh necessario criar uma nova pagina
	Lin := 9999
	Somalinha()
Endif

oPrintPPRA:Say(lin,1000,STR0025,oFont12b) //"RESPONSÁVEIS TÉCNICOS"

Somalinha(180)
IMPDOC852(Alltrim(cTxtMemo))

Somalinha(180)
oPrintPPRA:Say(lin,100,STR0026,oFont12b) //"COORDENADOR:"
oPrintPPRA:Say(lin,600, SubStr(Alltrim(TMK->TMK_NOMUSU),1,40),oFont12)

Somalinha()
oPrintPPRA:Say(lin,100,STR0027,oFont12b) //"REG.SSST:"
oPrintPPRA:Say(lin,600,Alltrim(TMK->TMK_REGMTB),oFont12)

Somalinha()
oPrintPPRA:Say(lin,100,If(Empty(TMK->TMK_ENTCLA),STR0028,Alltrim(TMK->TMK_ENTCLA))+": ",oFont12b) //"CRM"
oPrintPPRA:Say(lin,600,Alltrim(TMK->TMK_NUMENT),oFont12)

Somalinha()
oPrintPPRA:Say(lin,100,STR0029,oFont12b) //"FONE:"
oPrintPPRA:Say(lin,600,Alltrim(TMK->TMK_TELUSU),oFont12)

Somalinha()
oPrintPPRA:Say(lin,100,STR0030,oFont12b) //"ENDEREÇO:"
oPrintPPRA:Say(lin,600,Alltrim(TMK->TMK_ENDUSU),oFont12)

dbSelectArea("TMK")
dbSetOrder(1)
dbSeek(xFilial("TMK")+TO0->TO0_CODUSU)

SomaLinha(120)
oPrintPPRA:Say(lin,100,STR0031,oFont12b) //"RESPONSÁVEL: "
oPrintPPRA:Say(lin,600, SubStr(Alltrim(TMK->TMK_NOMUSU),1,40),oFont12)
Somalinha()
oPrintPPRA:Say(lin,100,If(Empty(TMK->TMK_ENTCLA),STR0028,Alltrim(TMK->TMK_ENTCLA))+": ",oFont12b) //"CRM"
oPrintPPRA:Say(lin,600,Alltrim(TMK->TMK_NUMENT),oFont12)

Somalinha()
oPrintPPRA:Say(lin,100,STR0029,oFont12b) //"FONE:"
oPrintPPRA:Say(lin,600,Alltrim(TMK->TMK_TELUSU),oFont12)

Somalinha()
oPrintPPRA:Say(lin,100,STR0030,oFont12b) //"ENDEREÇO:"
oPrintPPRA:Say(lin,600,Alltrim(TMK->TMK_ENDUSU),oFont12)

Somalinha(180)
cTxtTmp := cCidadeRe+", "+StrZero(Day(dDataBase),2)+STR0032+MesExtenso(dDataBase)+STR0032+StrZero(Year(dDataBase),4)+"." //" de "###" de "
oPrintPPRA:Say(lin,100,cTxtTmp,oFont12b)

Somalinha()
oPrintPPRA:Say(lin,100,STR0033,oFont12b) //"DATA:"
oPrintPPRA:Say(lin,300,Alltrim(Transform(Date(),"99/99/9999")),oFont12)

Somalinha(300)
oPrintPPRA:Say(lin,100,STR0034+"___________________________________________",oFont12) //"Ass.: "

If aReturn[5] == 1
	oPrintPPRA:Preview()
Else
	oPrintPPRA:Print()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TO0")
Set Filter To

Return NIL

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha(nLin__)
If nModeloImp == 1
	OLE_ExecuteMacro(oWord,"Somalinha")
ElseIf nModeloImp == 2
    Li++
    If Li > 58
       Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo,,.f.)
    EndIf
ElseIf nModeloImp == 3
	If ValType(nLin__) == "N"
	    Lin += nLin__
	Else
		Lin += 60
	Endif
    If Lin > 3000
	    Lin := 300
	    If nPaginaG > 0
		    oPrintPPRA:EndPage()
		Endif
		oPrintPPRA:StartPage()
		nPaginaG++
		If nPaginaG != 1
			oPrintPPRA:Say(100,2320,Alltrim(Str(nPaginaG,10)),oFont08)
		Endif
		If !Empty(cStartLogo) .and. File(cStartLogo)
			oPrintPPRA:SayBitMap(100,150,cStartLogo,300,150)
	    EndIf
	Endif
Endif
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fMDT852WOR³ Autor ³Denis Hyroshi de Souza ³ Data ³ 17.09.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do PPRA (Word)                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fMDT852WOR()

PRIVATE cPerg := "MDT852W   "

If Pergunte(cPerg,.t.)
	If lSigaMdtps
		cCliMdtPs := Mv_par01+Mv_par02
	Endif
	RptStatus({|lEnd| fWORD852() },titulo)
Endif

Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fWORD852  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do relatorio (Word)                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fWORD852()

Local nLenMemo := 0
Local nPerMemo := 0
Local cMemo := " ",cTitulo := " ",cTexto := " "
Local lEof := .t.
Local nX
Local nLinha
Local cBarraRem := "\"
Local cBarraSrv := "\"
Local cSMCOD := FWGrpCompany()
Local cSMFIL := FWCodFil()

Private lCriaIndice := .f.

Private cArqDot  := "pcmat.dot"							// Nome do arquivo modelo do Word (Tem que ser .dot)
Private cArqBmp  := "LGRL"+cSMCOD+cSMFIL+".BMP"              // Nome do arquivo logo do cliente
Private cArqBmp2 := "LGRL"+cSMCOD+".BMP"          // Nome do arquivo logo do cliente
Private cPathDot := Alltrim(GetMv("MV_DIRACA"))			// Path do arquivo modelo do Word
Private cRootPath
Private cFileLogo
Private cPathBmp := Alltrim(GetMv("MV_DIRACA"))			// Path do arquivo logo .bmp do cliente
Private cPathBm2 := cPathBmp

If lSigaMdtPS
	cArqBmp  := "LGRL"+cCliMdtPs+".bmp"              // Nome do arquivo logo do cliente
	cArqBmp2 := "LGRL"+Substr(cCliMdtPs,1,nSizeCli)+".bmp" // Nome do arquivo logo do cliente
Endif

If GetRemoteType() == 2  //estacao com sistema operacional unix
	cBarraRem := "/"
Endif
If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
	cBarraSrv := "/"
Endif

cPathDot += If(Substr(cPathDot,len(cPathDot),1) != cBarraSrv,cBarraSrv,"") + cArqDot
cPathEst += If(Substr(cPathEst,len(cPathEst),1) != cBarraRem,cBarraRem,"")

cPathBmp += If(Substr(cPathBmp,len(cPathBmp),1) != cBarraSrv,cBarraSrv,"") + cArqBmp
cPathBm2 += If(Substr(cPathBm2,len(cPathBm2),1) != cBarraSrv,cBarraSrv,"") + cArqBmp2

//Cria diretorio se nao existir
MontaDir(cPathEst)

//Se existir .dot na estacao, apaga!
If File( cPathEst + cArqDot )
	Ferase( cPathEst + cArqDot )
EndIf
If !File(cPathDot)
	MsgStop(STR0038+chr(10)+STR0039,STR0040) //"O arquivo pcmat.dot não foi encontrado no servidor."###"Verificar o parâmetro 'MV_DIRACA'."###"ATENÇÃO"
	Return
EndIf
CpyS2T(cPathDot,cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario
// para que o wordview e o proprio word possam preparar o arquivo para impressao e
// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
// estacao , por exemplo C:\WORDTMP
//__copyfile(cPathDot,cPathEst+cArqDot)
//Logo
//Se existir .bmp na estacao, apaga!
If File(cPathBmp)
	If File( cPathEst + cArqBmp )
		Ferase( cPathEst + cArqBmp )
	EndIf
	__copyfile(cPathBmp,cPathEst+cArqBmp)
ElseIf File(cPathBm2)
	If File( cPathEst + cArqBmp2 )
		Ferase( cPathEst + cArqBmp2 )
	EndIf
	__copyfile(cPathBm2,cPathEst+cArqBmp2)
	cArqBmp := cArqBmp2
EndIf	// para que o wordview e o proprio word possam preparar o arquivo para impressao e
// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
// estacao , por exemplo C:\WORDTMP

Private cVar := "cVAR",nVar := 1
Private cVar1 := "cTIT",nVar1 := 1
Private lPrint := .t.
Private lPrin2 := .t.
Private lFirst := .t.
Private lJumpCab := .t.
Private lIdentar := .f.
Private aRiscos := {}
Private aEpis   := {}
Private aExames := {}
Private oWord

dbSelectArea("SM0")
dbSetOrder(1)
dbSeek(cNumEmp)
If lSigaMdtps
	dbSelectArea("TO0")
	dbSetOrder(6)  //cli + loj + laudo
	dbSeek(xFilial("TO0")+cCliMdtps+mv_par03)
	dbSelectArea("TLL")
	dbSetOrder(1)
	dbSeek(xFilial("TLL")+TO0->TO0_CC)
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+cCliMdtps)
Else
	dbSelectArea("TO0")
	dbSetOrder(1)
	dbSeek(xFilial("TO0")+Mv_par01)
	dbSelectArea("TLL")
	dbSetOrder(1)
	dbSeek(xFilial("TLL")+TO0->TO0_CC)
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+TLL->TLL_CODCON+TLL->TLL_LOJCON)
Endif

If !Empty(SM0->M0_CGC)
	If SM0->M0_TPINSC != 2
		cEmp_Cnpj := Transform(SA1->A1_CGC,"@R 99.999.99999/99")
		cCNPJ_Cliente := Transform(SA1->A1_CGC,"@R 99.999.99999/99")
		cInscCli := STR0081 //"C.G.c. do Contratante"
	Else//CNPJ
		cEmp_Cnpj := Transform(SA1->A1_CGC,"@!R NN.NNN.NNN/NNNN-99")
		cCNPJ_Cliente := Transform(SA1->A1_CGC,"@!R NN.NNN.NNN/NNNN-99")
		cInscCli := STR0019 //"CNPJ do Contratante"
	Endif
Else
	cEmp_Cnpj     := SA1->A1_CGC
	cCNPJ_Cliente := SA1->A1_CGC
	cInscCli := STR0081 //"C.G.c. do Contratante"
Endif
cCidadeRe     := Capital(Alltrim(SA1->A1_MUN))
cEmp_Nome     := SA1->A1_NOME
cCidade       := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
cEnd_Obra     := TLL->TLL_ENDERE
cEnd_Cliente  := SA1->A1_END
cTipo_Obra    := Posicione("TLQ",1,xFilial("TLQ")+TLL->TLL_TIPO,"TLQ_DESTIP")
cDataInicio   := DtoC( If( Empty(TLL->TLL_DTINIR) , TLL->TLL_DTINIP , TLL->TLL_DTINIR ) )
cDataFim      := DtoC( If( Empty(TLL->TLL_DTFIMR) , TLL->TLL_DTFIMP , TLL->TLL_DTFIMR ) )
cNumMaximo    := Alltrim(Str(TLL->TLL_NUMERO,6))

lImpress	  := .f.
cArqSaida	  := ""
If lSigaMdtps
	lImpress  := If(mv_par05 == 1,.t.,.f.)	//Verifica se a saida sera em Tela ou Impressora
	cArqSaida := If(Empty(mv_par06),"Documento1",AllTrim(mv_par06))	// Nome do arquivo de saida
Else
	lImpress  := If(mv_par03 == 1,.t.,.f.)	//Verifica se a saida sera em Tela ou Impressora
	cArqSaida := If(Empty(mv_par04),"Documento1",AllTrim(mv_par04))	// Nome do arquivo de saida
Endif
oWord := OLE_CreateLink('TMsOleWord97')//Cria link como Word

If lImpress //Impressao via Impressora
	OLE_SetProperty(oWord,oleWdVisible,  .F.)
	OLE_SetProperty(oWord,oleWdPrintBack,.T.)
Else //Impressao na Tela(Arquivo)
	OLE_SetProperty(oWord,oleWdVisible,  .F.)
	OLE_SetProperty(oWord,oleWdPrintBack,.F.)
EndIf

OLE_NewFile(oWord,cPathEst + cArqDot) //Abrindo o arquivo modelo automaticamente

//Imprime Logo
cFileLogo := cPathEst + cArqBmp
If !lMdtUnix //Se for windows
	If File( cFileLogo )
		OLE_SetDocumentVar(oWord,"Cria_Var",cFileLogo)
		OLE_ExecuteMacro(oWord,"Insere_logo")
	Endif
Endif

//Dados Empresa
OLE_SetDocumentVar(oWord,"Empresa",cEmp_Nome)
OLE_SetDocumentVar(oWord,"tipoInsc",aTipoInsc[1])
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,"CGC",cEmp_Cnpj)
OLE_SetDocumentVar(oWord,"Cidade",cCidade)

OLE_SetDocumentVar(oWord,"EndObra",cEnd_Obra)
OLE_SetDocumentVar(oWord,"RazaoObra",cEmp_Nome)
OLE_SetDocumentVar(oWord,"CgcObra",cCNPJ_Cliente)
OLE_SetDocumentVar(oWord,"EndCliente",cEnd_Cliente)
OLE_SetDocumentVar(oWord,"TipoObra",cTipo_Obra)
OLE_SetDocumentVar(oWord,"DataInicio",cDataInicio)
OLE_SetDocumentVar(oWord,"DataFim",cDataFim)
OLE_SetDocumentVar(oWord,"NumMaximo",cNumMaximo)

Somalinha()
Somalinha()

cMemo := Alltrim(TO0->TO0_DESCRI)
If !Empty(TO0->TO0_MMSYP2)
	cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
	If !Empty(cMMSYP2)
		If !Empty(cMemo)
			cMemo += Chr(13)+Chr(10)
		Endif
		cMemo += cMMSYP2
	Endif
Endif

SetRegua(100)
nLenMemo := Len(cMemo)
nPerMemo := 0

While lEof
	OLE_ExecuteMacro(oWord,"Atualiza")

	If Empty(cMemo)  //Memo vazio
		lEof := .f.
		Exit
	Else
		nPos1 := At("#",cMemo) //Inicio de um Titulo

		If nPos1 > 1
			cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
			cMemo  := Alltrim(Substr(cMemo,nPos1))
			IMPDOC852(Alltrim(cTexto))
			fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
			Loop
		ElseIf nPos1 == 1 //Existe #
			cMemo   := Alltrim(Substr(cMemo,nPos1+1))
			nPos1   := At("#",cMemo)
			cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
			cMemo   := Alltrim(Substr(cMemo,nPos1+1))

			nPos1   := At("#",cMemo)
			If nPos1 > 0
				cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
				cMemo  := Alltrim(Substr(cMemo,nPos1))
			Else
				cTexto := Alltrim(cMemo)
				cMemo  := " "
				lEof   := .f.
			Endif
		Else //Nao existe #
			//IMPRIME TEXTO
			IMPDOC852(Alltrim(cMemo))
			lEof := .f.
			Exit
		Endif


		//IMPRIME TITULO
		If !Empty(cTitulo)
	   		IMPHEA852(cTitulo,,.t.)
			If !Empty(cTexto)
				nTexto := 0
				nLinhasMemo := MLCOUNT(cTexto,10)
				For nLinha := 1 to nLinhasMemo
				    cTextTemp := MemoLine(cTexto,10,nLinha)
				    If !Empty(cTextTemp)
				    	nTexto := At("@",AllTrim(cTextTemp))
				    	Exit
				    Endif
				Next Linha

				If nTexto == 0
					OLE_ExecuteMacro(oWord,"SomaLinha")
					OLE_ExecuteMacro(oWord,"SomaLinha")
				Endif
			Endif
		Endif

		lPrint := .t.
		lPrin2 := .t.
		IMPDOC852(Alltrim(cTexto))

	Endif

	fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua

End

cTxtMemo := " "
dbSelectArea("TMZ")
dbSetOrder(1)
IF dbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
	cTxtMemo := TMZ->TMZ_DESCRI
Endif

dbSelectArea("TMK")
dbSetOrder(1)
If lSigaMdtps
	dbSeek(xFilial("TMK")+Mv_par04)
Else
	dbSeek(xFilial("TMK")+Mv_par02)
Endif

OLE_ExecuteMacro(oWord,"NewPage")
IMPHEA852("{CNS}"+STR0025,.t.) //"RESPONSÁVEIS TÉCNICOS"
For nX := 1 to 3
	OLE_ExecuteMacro(oWord,"Somalinha")
Next nX

IMPDOC852(Alltrim(cTxtMemo))

IMPHEA852("{N}"+STR0026) //"COORDENADOR:"
lPrint := .F.
lPrin2 := .F.
IMPDOC852( SubStr(Alltrim(TMK->TMK_NOMUSU),1,40) )

IMPHEA852("{N}"+STR0027,.t.) //"REG.SSST:"
lPrint := .F.
lPrin2 := .F.
IMPDOC852(Alltrim(TMK->TMK_REGMTB))

IMPHEA852("{N}"+If(Empty(TMK->TMK_ENTCLA),STR0028,Alltrim(TMK->TMK_ENTCLA))+": ",.t.) //"CRM"
lPrint := .F.
lPrin2 := .F.
IMPDOC852(Alltrim(TMK->TMK_NUMENT))

IMPHEA852("{N}"+STR0029,.t.) //"FONE:"
lPrint := .F.
lPrin2 := .F.
IMPDOC852(Alltrim(TMK->TMK_TELUSU))

IMPHEA852("{N}"+STR0030,.t.) //"ENDEREÇO:"
lPrint := .F.
lPrin2 := .F.
IMPDOC852(Alltrim(TMK->TMK_ENDUSU))

For nX := 1 to 3
	OLE_ExecuteMacro(oWord,"Somalinha")
Next nX

IMPHEA852("{N}"+STR0033,.t.) //"DATA:"
lPrint := .F.
lPrin2 := .F.
IMPDOC852(Alltrim(Transform(Date(),"99/99/9999")))
For nX := 1 to 5
	OLE_ExecuteMacro(oWord,"Somalinha")
Next nX

IMPHEA852("{N}"+STR0034+"___________________________________________") //"Ass.: "

OLE_SetDocumentVar(oWord,"Cria_Var",Space(1)) //Limpa campo oculto do documento
If lCriaIndice
	OLE_ExecuteMacro(oWord,"Cria_Indice")//"Cria o indice"
Endif
OLE_ExecuteMacro(oWord,"Atualiza") //Executa a macro que atualiza os campos do documento
If lCriaIndice
	OLE_ExecuteMacro(oWord, "AtualizaIndice")//"Atualiza Indice"
Endif
OLE_ExecuteMacro(oWord,"Begin_Text") //Posiciona o cursor no inicio do documento
cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "ERROR", GetADV97() )
cRootPath := IF( RIGHT(cRootPath,1) == cBarraSRV,SubStr(cRootPath,1,Len(cRootPath)-1), cRootPath)

IF lImpress //Impressao via Impressora
	OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord, "ALL",,, 1 )
Else //Impressao na Tela(Arquivo)
	OLE_SetProperty(oWord,oleWdVisible,.t.)
	OLE_ExecuteMacro(oWord,"Maximiza_Tela")
	If !lMdtUnix //Se for windows
		If fDIRR852(cRootPath+cBarraSRV+"SPOOL"+cBarraSRV)
			OLE_SaveAsFile(oWord,cRootPath+cBarraSRV+"SPOOL"+cBarraSRV+cArqSaida,,,.f.,oleWdFormatDocument)
		ElseIf fDIRR852(cPathEst)
			OLE_SaveAsFile(oWord,cPathEst+cArqSaida,,,.f.,oleWdFormatDocument)
		Else
			OLE_SaveAsFile(oWord,cPathEst+cArqSaida,,,.f.,oleWdFormatDocument)
		Endif
	Endif
	MsgInfo(STR0042) //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
EndIF
OLE_CloseFile(oWord) //Fecha o documento
OLE_CloseLink(oWord) //Fecha o documento

Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fDIRR852 ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se o diretorio existe.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fDIRR852(cCaminho)

Local lDir := .F.
Local cBARRAS   := If(isSRVunix(),"/","\")
Local cBARRAD := If(isSRVunix(),"//","\\")

If !empty(cCaminho) .and. !(cBARRAD$cCaminho)
	cCaminho := alltrim(cCaminho)
	if Right(cCaminho,1) == cBarras
		cCaminho := SubStr(cCaminho,1,len(cCaminho)-1)
	Endif
	lDir :=(Ascan( Directory(cCaminho,"D"),{|_Vet | "D" $ _Vet[5] } ) > 0)
EndIf

Return lDir

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³IMPDOC852 ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME O CONTEUDO DO TEXTO                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function IMPDOC852(_cTexto,lSaltaLin,lEsquerda,lBackSpc)
Local lTexto := .t.
Local nPosTxt := 0
Local cTitExe
Local cTextoNew := _cTexto
Local cTxtMemo := _cTexto
Local nArroba,LinhaCor
Local nPosTemp
Local cCNS := " "

Default lEsquerda := .F.  //Alinhar à esquerda
Default lBackSpc  := .F.
Private lFirst := .t.
//Imprime texto

lJumpCab := .f. //Somalinha do Titulo de Relatorio
While lTexto
	nArroba := At("@",cTxtMemo)

	If nArroba > 1
		cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
		cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))
		IMPDOC852(Alltrim(cTextoNew))
		Loop
	ElseIf nArroba == 1 //Existe @
		cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))
		nArroba  := At("@",cTxtMemo)
		cTitExe  := Alltrim(Substr(cTxtMemo,1,nArroba-1))
		PROC852TIT(cTitExe)
		cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))

		nArroba   := At("@",cTxtMemo)
		If nArroba > 0
			cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
			cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))
			IMPDOC852(Alltrim(cTextoNew))
			Loop
		Endif
	Endif

	If (nPosTxt := At(Chr(13)+Chr(10),cTxtMemo)) == 0
		lTexto := .f.
		cTextoNew :=  Alltrim(cTxtMemo)
	Else
		cTextoNew :=  Alltrim(Substr(cTxtMemo,1,nPosTxt-1))
		cTxtMemo  :=  Alltrim(Substr(cTxtMemo,nPosTxt+2))
		If Len(cTxtMemo) == 0
			lTexto := .f.
		Endif
	Endif
	If ("{" $ cTextoNew) .and.  ("}" $ cTextoNew)
		nPosTemp := At("}",cTextoNew)
		cCNS     := Substr(cTextoNew,1,nPosTemp)
		cTextoNew := Substr(cTextoNew,nPosTemp+1)
	Endif

	lImp852 := .t.
	If Empty(cTextoNew)
		cTextoNew := " "
	Endif

	If lImp852
		If nModeloImp == 2
			nAddLi := 0
			If lIdentar
				nAddLi := 5
			Endif
			lPrimeiro := .t.
			nLinhasMemo := MLCOUNT(cTextoNew,120)
			For LinhaCor := 1 to nLinhasMemo
			    If lPrimeiro
					@ Li,005+nAddLi PSAY (MemoLine(cTextoNew,120,LinhaCor))
					lPrimeiro := .f.
				Else
					@ Li,000+nAddLi PSAY (MemoLine(cTextoNew,120,LinhaCor))
				EndIf
				Somalinha()
			Next LinhaCor
		ElseIf nModeloImp == 1
			cVar1 := "cTXT"+Strzero(nVar1,6)
			OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
			nVar1++

			If lPrint .and. !lFirst
				OLE_ExecuteMacro(oWord,"Somalinha")
				lPrint := .f.
			Endif
			If lPrin2 .and. !lFirst
				OLE_ExecuteMacro(oWord,"Somalinha")
			Endif

			If lSaltaLin
				OLE_ExecuteMacro(oWord,"Somalinha")
			Endif

			If lIdentar .and. !lFirst
				OLE_ExecuteMacro(oWord,"Identar")
			Endif

			OLE_ExecuteMacro(oWord,"Cria_Texto")

			If ("N" $ Upper(cCNS)) //N=Negrito
				OLE_ExecuteMacro(oWord,"Com_Negrito")
			Else
				OLE_ExecuteMacro(oWord,"Sem_Negrito")
			Endif

			If ("C" $ Upper(cCNS)) //C=Centralizar
				OLE_ExecuteMacro(oWord,"Centralizar")
			Else
				OLE_ExecuteMacro(oWord,"Justificar")
			Endif

			If ("S" $ Upper(cCNS)) //S=Sublinhar
				OLE_ExecuteMacro(oWord,"Com_Sublinhar")
			Else
				OLE_ExecuteMacro(oWord,"Sem_Sublinhar")
			Endif

			If lBackSpc .and. lFirst
				OLE_ExecuteMacro(oWord,"BackSpace")
			Endif
			lPrin2 := .t.
			lFirst := .f.
			If lEsquerda
				OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
			Endif
			OLE_SetDocumentVar(oWord,cVar1,cTextoNew)
		ElseIf nModeloImp == 3
			nAddLi := 0
			If lIdentar
				nAddLi := 150
			Endif
			lPrimeiro := .t.
			nLinhasMemo := MLCOUNT(cTextoNew,120)
			For LinhaCor := 1 to nLinhasMemo
				Somalinha()
				If ("N" $ Upper(cCNS)) //N=Negrito
				    If lPrimeiro
				    	oPrintPPRA:Say(lin,300+nAddLi,MemoLine(cTextoNew,120,LinhaCor),oFont10b)
						lPrimeiro := .f.
					Else
						oPrintPPRA:Say(lin,150+nAddLi,MemoLine(cTextoNew,120,LinhaCor),oFont10b)
					EndIf
				Else
				    If lPrimeiro
				    	oPrintPPRA:Say(lin,300+nAddLi,MemoLine(cTextoNew,120,LinhaCor),oFont10)
						lPrimeiro := .f.
					Else
						oPrintPPRA:Say(lin,150+nAddLi,MemoLine(cTextoNew,120,LinhaCor),oFont10)
					EndIf
				Endif
			Next LinhaCor
		Endif
	Endif
End
Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³IMPHEA852 ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME O TITULO DO TEXTO                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function IMPHEA852(_cTit,lJump,lIndice)
Local nPosTemp
Local _cTitulo := _cTit
Local cCNS := " "
Local lJumper
Local nLinhasMemo
Local LinhaCor

Default lJump := .f.
Default lIndice := .f.
lJumper := If(!lJump,lJumpCab,lJump)

If nModeloImp == 2
	If ("{" $ _cTitulo) .and.  ("}" $ _cTitulo)
		nPosTemp := At("}",_cTitulo)
		cCNS     := Substr(_cTitulo,1,nPosTemp)
		_cTitulo := Substr(_cTitulo,nPosTemp+1)
	Endif
	Somalinha()
	@ Li,000 Psay _cTitulo
	Somalinha()
	Return .t.

ElseIf nModeloImp == 3

	If ("{" $ _cTitulo) .and.  ("}" $ _cTitulo)
		nPosTemp := At("}",_cTitulo)
		cCNS     := Substr(_cTitulo,1,nPosTemp)
		_cTitulo := Substr(_cTitulo,nPosTemp+1)
	Endif

	nLinhasMemo := MLCOUNT(_cTitulo,90)
	For LinhaCor := 1 to nLinhasMemo
		Somalinha()
		nColImp := 150
		cTxtImp := Alltrim(MemoLine(_cTitulo,90,LinhaCor))
		If ("C" $ Upper(cCNS)) //C=Centralizar
			nDiff := Round( (90 - Len(cTxtImp)) / 2 , 0 )
			If nDiff > 0
				nColImp := 150 + (nDiff*23.3)
			Endif
		Endif
		If ("N" $ Upper(cCNS)) //N=Negrito
			If ("S" $ Upper(cCNS)) //S=Sublinhar
				oPrintPPRA:Say(lin,nColImp,cTxtImp,oFont12bs)
			Else
				oPrintPPRA:Say(lin,nColImp,cTxtImp,oFont12b)
			Endif
		Else
			If ("S" $ Upper(cCNS)) //S=Sublinhar
				oPrintPPRA:Say(lin,nColImp,cTxtImp,oFont12s)
			Else
				oPrintPPRA:Say(lin,nColImp,cTxtImp,oFont12)
			Endif
		Endif
	Next LinhaCor
//	Somalinha()
	Return .t.
Else
	lFirst := .f.////Somalinha do texto

	cVar := "cTIT"+Strzero(nVar,6)
	nVar++
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar)
	If !lJumper
		OLE_ExecuteMacro(oWord,"Somalinha")
	Endif
	lJumpCab := .f.//Somalinha do Titulo de Relatorio
	OLE_ExecuteMacro(oWord,"Somalinha")

	If ("{" $ _cTitulo) .and.  ("}" $ _cTitulo)
		nPosTemp := At("}",_cTitulo)
		cCNS     := Substr(_cTitulo,1,nPosTemp)
		_cTitulo := Substr(_cTitulo,nPosTemp+1)
	Endif

	If lIndice
		If ("1" $Upper(cCNS))//Titulo 1
			lCriaIndice := .t.
			OLE_ExecuteMacro(oWord, "Cria_TituloUsuario")
		ElseIf("2" $Upper(cCNS))//2=Titulo 2
			lCriaIndice := .t.
			OLE_ExecuteMacro(oWord, "Cria_TituloUsuario2")
		ElseIf("3" $Upper(cCNS))//2=Titulo 3
			lCriaIndice := .t.
			OLE_ExecuteMacro(oWord, "Cria_TituloUsuario3")
		ElseIf("4" $Upper(cCNS))//2=Titulo 4
			lCriaIndice := .t.
			OLE_ExecuteMacro(oWord, "Cria_TituloUsuario4")
	    Else
	    	OLE_ExecuteMacro(oWord,"Cria_Titulo")
	    Endif
	Else
		OLE_ExecuteMacro(oWord,"Cria_Titulo")
	EndIf

	If ("N" $ Upper(cCNS)) //N=Negrito
		OLE_ExecuteMacro(oWord,"Com_Negrito")
	Else
		OLE_ExecuteMacro(oWord,"Sem_Negrito")
	Endif

	If ("C" $ Upper(cCNS)) //C=Centralizar
		OLE_ExecuteMacro(oWord,"Centralizar")
	Else
		OLE_ExecuteMacro(oWord,"Justificar")
	Endif

	If ("S" $ Upper(cCNS)) //S=Sublinhar
		OLE_ExecuteMacro(oWord,"Com_Sublinhar")
	Else
		OLE_ExecuteMacro(oWord,"Sem_Sublinhar")
	Endif

	OLE_SetDocumentVar(oWord,cVar,_cTitulo)
	If lIndice
		Somalinha()
	Endif
Endif

Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³EXEC852TIT³ Autor ³Denis Hyroshi de Souza ³ Data ³ 28.05.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME A TABELA RELACIONADA AO TITULO                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PROC852TIT(_cTitExe)
Local lVivencia := .F., lEquip := .F., lEPC := .F.
Local cTitExe := _cTitExe, nTipo := 1, cTitTemp, nPos1

cTitTemp := _cTitExe
nPos1    := At("!",cTitTemp)
If nPos1 > 0
	cTitTemp := Alltrim(Substr(cTitTemp,nPos1+1))
	nPos1    := At("!",cTitTemp)
	If nPos1 > 0
		cTitTemp := Substr(cTitTemp,1,nPos1-1)
		nTipo := 2
	Endif
Endif

If nTipo == 1
	cTitTemp := _cTitExe
	nPos1    := At("%",cTitTemp)
	If nPos1 > 0
		cTitTemp := Alltrim(Substr(cTitTemp,nPos1+1))
		nPos1    := At("%",cTitTemp)
		If nPos1 > 0
			cTitTemp := Substr(cTitTemp,1,nPos1-1)
			nTipo := 3
		Endif
	Endif
Endif

Begin Sequence
	If ExistBlock("MDTR8501") // Ponto de Entrada para executar atalhos customizados
		aRetPE := ExecBlock('MDTR8501',.F.,.F., {'7', nModeloImp, cTitExe})
		If ValType(aRetPE) == "A"
			nPosPE := aScan(aRetPE, {|x| Alltrim(x[1]) == Alltrim(cTitExe) .And. Alltrim(cTitExe) == Alltrim(x[1]) })
			If nPosPE > 0
				&(aRetPE[nPosPE,2])
				Break
			Endif
		Endif
	Endif

	If nTipo == 2
		A852IMAGEM(cTitTemp)
	ElseIf nTipo == 3
		A852ARQUIVO(cTitTemp)
	ElseIf "QUADRO FASE" $ Upper(cTitExe)
		A852RISQUA()
	ElseIf "FASES" $ Upper(cTitExe)
		lVivencia := .F.
		lEquip := .F.
		lEPC := .F.
		If "VIVENCIAS" $ Upper(cTitExe)
			lVivencia := .T.
		Endif
		If "EQUIPAMENTOS" $ Upper(cTitExe)
			lEquip := .T.
		Endif
		If "EPC'S"  $ Upper(cTitExe)
			lEPC := .T.
		Endif
		A852FASES(lVivencia, lEquip, lEPC)
	ElseIf "EQUIPAMENTO" $ Upper(cTitExe)
		A852EQUIP()
	ElseIf "CONTROLE" $ Upper(cTitExe)
		A852CONTR()
	ElseIf "FUNCOES" $ Upper(cTitExe)
		A852FUNCOES()
	ElseIf "CRONOGRAMA" $ Upper(cTitExe)
		A852CRONOGRAMA()
	ElseIf "VIVENCIA" $ Upper(cTitExe)
		A852VIVENCIA()
	ElseIf "ANEXOS" $ Upper(cTitExe)
		A852ANEXOS()
	ElseIf "QUADRO EPI" $ Upper(cTitExe)
		A852EPIQ()
	ElseIf "EPI X FUNCAO" $ Upper(cTitExe)
		A852EPIFUN()
	ElseIf "MEMO" $ Upper(cTitExe)
		If "LOCAL" $ Upper(cTitExe)
			If nModeloImp == 1
				Somalinha()
			Endif
			IMPDOC852( Alltrim(MSMM(TLL->TLL_DESCLO,80)) ,.T.,.T.)
		ElseIf "EMPREENDIMENTO" $ Upper(cTitExe)
			If nModeloImp == 1
				Somalinha()
			Endif
			IMPDOC852( Alltrim(MSMM(TLL->TLL_DESCEM,80)) ,.T.,.T.)
		ElseIf "ELETRICA" $ Upper(cTitExe)
			If nModeloImp == 1
				Somalinha()
			Endif
			IMPDOC852( Alltrim(MSMM(TLL->TLL_DESCIN,80)) ,.T.,.T.)
		ElseIf "EMERGENCIA" $ Upper(cTitExe)
			If nModeloImp == 1
				Somalinha()
			Endif
			IMPDOC852( Alltrim(MSMM(TLL->TLL_DESCPE,80)) ,.T.,.T.)
		ElseIf "SINALIZACAO" $ Upper(cTitExe)
			If nModeloImp == 1
				Somalinha()
			Endif
			IMPDOC852( Alltrim(MSMM(TLL->TLL_DESCSI,80)) ,.T.,.T.)
		Endif
	ElseIf "PAGINA"	$ Upper(cTitExe)
		SomaPag()
	Endif

End Sequence

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SomaPag   ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Salta pagina                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function SomaPag()
If nModeloImp == 2
	li := 80
	somalinha()
ElseIf nModeloImp == 3
	lin := 9999
	somalinha()
Else
	OLE_ExecuteMacro(oWord,"NewPage")
	lJumpCab := .t.
Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A852EQUIP  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³LISTA EQUIPAMENTOS  E MAQUINAS UTILIZADAS NA OBRA           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852EQUIP()
Local aArea := GetArea()
PRIVATE _1st := .t.
PRIVATE cMemo := ""
PRIVATE nRegs := 0

dbSelectArea("TLR")
dbSetOrder(1)
dbSeek( xFilial("TLR") + TLL->TLL_CC )
While !eof() .and. xFilial("TLR") + TLL->TLL_CC == TLR->TLR_FILIAL+TLR->TLR_CC
	dbSelectArea("TNH")
	dbSetOrder(1)
	If dbSeek(xFilial("TNH")+TLR->TLR_CODEQU)
		IMPHEA852("{N}"+Capital(TNH->TNH_DESOBJ))
		Somalinha()
		lIdentar := .f.
		cDesFun  := Alltrim( MSMM(TLR->TLR_OBSERV,80) )
		IMPDOC852(cDesFun , .t.)
		If nModeloImp == 3
			Somalinha()
		Endif
	Endif
	dbSelectArea("TLR")
	dbSkip()
End

RestArea(aArea)
Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A852VIVENCIA Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³LISTA AREAS DE VIVENCIA                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852VIVENCIA()
Local aArea := GetArea()
PRIVATE _1st := .t.

dbSelectArea("TLN")
dbSetOrder(1)
dbSeek( xFilial("TLN") + TLL->TLL_CC )
While !eof() .and. xFilial("TLN") + TLL->TLL_CC == TLN->TLN_FILIAL+TLN->TLN_CC
	dbSelectArea("TLS")
	dbSetOrder(1)
	If dbSeek(xFilial("TLS")+TLN->TLN_AREA)
		If _1st
			Somalinha()
			_1st := .f.
		Endif
		IMPHEA852("{N}"+Capital(TLS->TLS_DESVIV))
		Somalinha()
		lIdentar := .f.
		cDesFun  := Alltrim( MSMM(TLN->TLN_CARACT,80) )
		IMPDOC852(cDesFun , .t. )
		If nModeloImp == 3
			Somalinha()
		Endif
	Endif
	dbSelectArea("TLN")
	dbSkip()
End

RestArea(aArea)
Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    A852ANEXOS    Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³LISTA ANEXOS DA OBRA                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852ANEXOS()
Local aArea := GetArea()
Local l1st := .t.

If nModeloImp != 2

	dbSelectArea("TLO")
	dbSetOrder(1)
	dbSeek( xFilial("TLO") + TLL->TLL_CC )
	While !eof() .and. xFilial("TLO") + TLL->TLL_CC == TLO->TLO_FILIAL+TLO->TLO_CC

		If !Empty(TLO->TLO_BITMAP)

			If !l1st
				SomaPag()
			Endif
			l1st := .f.
			IMPHEA852("{N}"+Capital(TLO->TLO_TITULO))
			Somalinha()

			cImgPath := NGimgExtract( TLO->TLO_BITMAP, cPathEst )
			If !Empty( cImgPath )
				If nModeloImp == 3
					Somalinha()
					//Caso a página esteja no fim cria nova página para não truncar imagem
					If lin > 2160
						lin := 3001
						Somalinha()
					Endif
					cImgPath := Substr(cImgPath,1,At(".",cImgPath))
					If File(cImgPath+"JPG")
						oPrintPPRA:SayBitmap(lin+10,200,cImgPath+"JPG",,,,.t.)
					ElseIf File(cImgPath+"BMP")
						oPrintPPRA:SayBitmap(lin+10,200,cImgPath+"BMP",,,,.t.)
					Endif
					//Verifica os arquivos criados para deletar depois
					If aScan( aImagens,{|x| UPPER(TRIM(x[1])) == UPPER(TRIM(cImgPath)) }) == 0
						aADD( aImagens,{ cImgPath })
					Endif
					lin += 820
				Else
					cImgPath := Substr(cImgPath,1,At(".",cImgPath))
					If File(cImgPath+"JPG")
						cImgPath := cImgPath+"JPG"
					ElseIf File(cImgPath+"BMP")
						cImgPath := cImgPath+"BMP"
					Else
						dbSelectArea("TLO")
						dbSkip()
						Loop
					Endif
					OLE_ExecuteMacro(oWord,"Somalinha")
					OLE_SetDocumentVar(oWord,"Cria_Var",cImgPath)
					OLE_ExecuteMacro(oWord,"Insere_figura")    //Insere a imagem no documento Word
					If aScan( aImagens,{|x| UPPER(TRIM(x[1])) == UPPER(TRIM(cImgPath)) }) == 0
						aADD( aImagens,{ cImgPath })
					Endif
				Endif
			Endif
		Endif
		dbSelectArea("TLO")
		dbSkip()
	End
	RestArea(aArea)
Endif

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A852CONTR  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME AS MEDIDAS DE CONTROLE DO LAUDO                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852CONTR()

Local aArea := GetArea()


If lSigaMdtps

	dbSelectArea("TO3")
	dbSetOrder(3)
	dbSeek(xFilial("TO3") + cCliMdtPs + TO0->TO0_LAUDO)
	While !eof() .and. xFilial("TO3")+TO0->TO0_LAUDO == TO3->TO3_FILIAL+TO3->TO3_LAUDO .and. cCliMdtPs == TO3->TO3_CLIENT+TO3->TO3_LOJA
		dbSelectArea("TO4")
		dbSetOrder(1)
		If dbSeek(xFilial("TO4")+TO3->TO3_CONTRO)
			lPrint := .t.
			If nModeloImp != 1
				IMPDOC852(Capital(AllTrim(TO4->TO4_NOMCTR))+": "+Alltrim(TO3->TO3_DESCRI))
			Else
				cVar1 := "cTXT"+Strzero(nVar1,6)
				OLE_ExecuteMacro(oWord,"Nao_Identar")
				OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
				nVar1++
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
				OLE_ExecuteMacro(oWord,"Com_Negrito")
				OLE_SetDocumentVar(oWord,cVar1,Capital(AllTrim(TO4->TO4_NOMCTR))+": ")

				IMPDOC852(Alltrim(TO3->TO3_DESCRI),.F.,.T.)
			Endif
		Endif
		dbSelectArea("TO3")
		dbSkip()
	End

Else

	dbSelectArea("TO3")
	dbSetOrder(1)
	dbSeek(xFilial("TO3")+TO0->TO0_LAUDO)
	While !eof() .and. xFilial("TO3")+TO0->TO0_LAUDO == TO3->TO3_FILIAL+TO3->TO3_LAUDO
		dbSelectArea("TO4")
		dbSetOrder(1)
		If dbSeek(xFilial("TO4")+TO3->TO3_CONTRO)
			lPrint := .t.
			If nModeloImp != 1
				IMPDOC852(Capital(AllTrim(TO4->TO4_NOMCTR))+": "+Alltrim(TO3->TO3_DESCRI))
			Else
				cVar1 := "cTXT"+Strzero(nVar1,6)
				OLE_ExecuteMacro(oWord,"Nao_Identar")
				OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
				nVar1++
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
				OLE_ExecuteMacro(oWord,"Com_Negrito")
				OLE_SetDocumentVar(oWord,cVar1,Capital(AllTrim(TO4->TO4_NOMCTR))+": ")

				IMPDOC852(Alltrim(TO3->TO3_DESCRI),.F.,.T.)
			Endif
		Endif
		dbSelectArea("TO3")
		dbSkip()
	End

Endif

RestArea(aArea)
Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    A852FUNCOES  Autor ³Denis Hyroshi de Souza ³ Data ³ 11.08.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME LISTAGEM DOS FUNCIONARIOS POR FUNCAO                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852FUNCOES()
Local aArea := GetArea()
Local nContFun
Local cFuncao, cDesFun

If !lSigaMdtPs

	dbSelectArea("SRJ")
	dbSetOrder(3)
	dbSeek(xFilial("SRJ"))
	While !EOF() .AND. xFilial("SRJ") == SRJ->RJ_FILIAL

		nContFun := 0

		dbSelectArea("SRA")
		dbSetOrder(7)
		dbSeek(xFilial("SRA")+SRJ->RJ_FUNCAO)
		While !eof() .and. xFilial("SRA")+SRJ->RJ_FUNCAO == SRA->RA_FILIAL+SRA->RA_CODFUNC
			If SRA->RA_SITFOLH != "D" .And. SRA->RA_CC == TO0->TO0_CC
				nContFun++
				Exit
			Endif
			dbSkip()
		End

		If nContFun > 0

			IMPHEA852("{N}"+Capital(SRJ->RJ_DESC))
			If nModeloImp == 1
				OLE_ExecuteMacro(oWord,"Somalinha")
			Endif

			lIdentar := .f.
			IMPDOC852(STR0044+SRJ->RJ_MEMOATI) //"Objetivo do Cargo: "
			If nModeloImp == 3
				Somalinha()
			Endif

		Endif

		dbSelectArea("SRJ")
		dbSkip()
	End

Else

	dbSelectArea("TOS")
	dbSetOrder(2)
	dbSeek(xFilial("TOS")+cCliMdtPs)
	While !EOF() .AND. xFilial("TOS")+cCliMdtPs == TOS->(TOS_FILIAL+TOS_CLIENT+TOS_LOJA)

		nContFun := 0

		dbSelectArea("SRA")
		dbSetOrder(2)
		dbSeek(xFilial("SRA")+cCliMdtPs,.t.)
		While !eof() .and. xFilial("SRA")+cCliMdtPs == SRA->RA_FILIAL+Substr(SRA->RA_CC,1,nSizeCli+nSizeLoj)
			If SRA->RA_SITFOLH != "D" .and. TOS->TOS_CODFUN == SRA->RA_CODFUNC .And. SRA->RA_CC == TO0->TO0_CC
				nContFun++
				Exit
			Endif
			dbSkip()
		End

		If nContFun > 0

	        cFuncao := " "
	        cDesFun := " "
			If Empty(TOS->TOS_DESFUN)
				cFuncao := NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC")
				cDesFun := NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_MEMOATI")
				dbSelectArea("TOS")
			Else
				cFuncao := TOS->TOS_DESFUN
				lIdentar := .f.
				If Empty(TOS->TOS_DESCDE)
					cDesFun := NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_MEMOATI")
				Else
					cDesFun := TOS->TOS_DESCDE
				Endif
			Endif

			IMPHEA852("{N}"+Capital(cFuncao))
			If nModeloImp == 1
				OLE_ExecuteMacro(oWord,"Somalinha")
			Endif
			lIdentar := .f.
			IMPDOC852(STR0044+cDesFun) //"Objetivo do Cargo: "
			If nModeloImp == 3
				Somalinha()
			Endif

		Endif

		dbSelectArea("TOS")
		dbSkip()
	End
Endif

If nModeloImp == 2
	Somalinha()
ElseIf nModeloImp == 1
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Somalinha")
Endif

dbSelectArea("SRJ")
dbSetOrder(1)

RestArea(aArea)
Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A852RISQUA³ Autor ³Andre E. Perez Alvarez ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME OS RISCOS, ATIVIDADES, EPIS e EPCS                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852RISQUA()
Local nFor, nFor2, nPosZ
Local aDados := {}
Local dDtIni, cNFase, cNSubF, nPos2, cNTare, cTxtRis, cTxtEpi, cTxtEpc

If Len(aRiscos) == 0
	aRiscos := fBuscaRisco()
Endif

dbSelectArea("TLP")
dbSetOrder(1)
dbSeek( xFilial("TLP") + TLL->TLL_CC )
While !eof() .and. xFilial("TLP") + TLL->TLL_CC == TLP->TLP_FILIAL+TLP->TLP_CC

	dbSelectArea("TLM")
	dbSetOrder(1)
	If !dbSeek( xFilial("TLM") + TLL->TLL_CC + TLP->TLP_FASE + TLP->TLP_SUBFAS )
		dbSelectArea("TLP")
		dbSkip()
		Loop
	Endif

	cTxtRis := ""
	cTxtEpi := ""
	cTxtEpc := ""

	nPos2 := aScan(aRiscos, {|x| x[1] == TLP->TLP_CODTAR .and. x[2] == TLP->TLP_FASE .and. x[3] == TLP->TLP_SUBFAS })
	If nPos2 > 0
		For nFor := 1 To Len(aRiscos[nPos2,4])
			If !Empty(cTxtEpi)
				cTxtEpi += ", " + aRiscos[nPos2,4,nFor,2]
			Else
				cTxtEpi += aRiscos[nPos2,4,nFor,2]
			Endif
		Next nFor
		For nFor := 1 To Len(aRiscos[nPos2,7])
			If !Empty(cTxtEpi)
				cTxtEpi += ", " + aRiscos[nPos2,7,nFor,2]
			Else
				cTxtEpi += aRiscos[nPos2,7,nFor,2]
			Endif
		Next nFor
		For nFor := 1 To Len(aRiscos[nPos2,5])
			If !Empty(cTxtEpc)
				cTxtEpc += ", " + aRiscos[nPos2,5,nFor,2]
			Else
				cTxtEpc += aRiscos[nPos2,5,nFor,2]
			Endif
		Next nFor
		For nFor := 1 To Len(aRiscos[nPos2,6])
			If !Empty(cTxtRis)
				cTxtRis += ", " + aRiscos[nPos2,6,nFor,2]
			Else
				cTxtRis += aRiscos[nPos2,6,nFor,2]
			Endif
		Next nFor

		dDtIni := If( Empty(TLM->TLM_DTINIR) , TLM->TLM_DTINIP , TLM->TLM_DTINIR )
		nPosZ := aScan(aDados, {|x| x[1] == TLP->TLP_FASE })
		If nPosZ == 0
			aAdd( aDados , { TLP->TLP_FASE , dDtIni , {} } )
			nPosZ := Len(aDados)
		Endif

		cNTare := SubStr( Alltrim(Posicione("TN5",1,xFilial("TN5")+TLP->TLP_CODTAR,"TN5_NOMTAR")), 1 , 40 )
		cNFase := Alltrim(Posicione("TLZ",1,xFilial("TLZ")+TLM->TLM_FASE  ,"TLZ_DESCRI"))
		cNSubF := Alltrim(Posicione("TLZ",1,xFilial("TLZ")+TLP->TLP_SUBFAS,"TLZ_DESCRI"))

		aDados[nPosZ,2] := If( aDados[nPosZ,2] < dDtIni , aDados[nPosZ,2] , dDtIni )
		aAdd( aDados[nPosZ,3] , { TLM->TLM_FASE , TLP->TLP_SUBFAS , cNFase , cNSubF , cNTare , cTxtRis , cTxtEpi , cTxtEpc } )
	Endif

	dbSelectArea("TLP")
	dbSkip()
End

aSort( aDados,,, { |x,y| DtoS(x[2]) < DtoS(y[2]) } )
For nFor2 := 1 to Len(aDados)
	cOldChv := ""
	For nFor := 1 to Len(aDados[nFor2,3])
		If cOldChv <> aDados[nFor2,3,nFor,1] + aDados[nFor2,3,nFor,2]
			If nFor == 1
				If nModeloImp != 2
					Somalinha()
				Endif
				IMPHEA852("{N}"+Upper(aDados[nFor2,3,nFor,3]))
			Endif
			If !Empty(aDados[nFor2,3,nFor,2]) .and. aDados[nFor2,3,nFor,1] <> aDados[nFor2,3,nFor,2]
				If nModeloImp != 2
					Somalinha()
				Endif
				IMPHEA852("{N}"+Capital(aDados[nFor2,3,nFor,4]))
			Endif
		Endif
		cOldChv := aDados[nFor2,3,nFor,1] + aDados[nFor2,3,nFor,2]

		Somalinha()

		lIdentar := .f.
		If nModeloImp == 1
			TitNegTxt(STR0045+": " , Capital(aDados[nFor2,3,nFor,5]) ) //"ATIVIDADES E OPERAÇÕES"
		Else
			IMPDOC852(STR0045+": "+Capital(aDados[nFor2,3,nFor,5]) ) //"ATIVIDADES E OPERAÇÕES"
		Endif
		If nModeloImp == 1
			TitNegTxt(STR0046+": " , Capital(aDados[nFor2,3,nFor,6]) ) //"PRINCIPAIS RISCOS"
		Else
			IMPDOC852(STR0046+": "+Capital(aDados[nFor2,3,nFor,6]) ) //"PRINCIPAIS RISCOS"
		Endif
		If nModeloImp == 1
			TitNegTxt(STR0047+": " , Capital(aDados[nFor2,3,nFor,7]) ) //"EPI’S/Cuidados"
		Else
			IMPDOC852(STR0047+": "+Capital(aDados[nFor2,3,nFor,7]) ) //"EPI’S/Cuidados"
		Endif
		If nModeloImp == 1
			TitNegTxt(STR0048+": " , Capital(aDados[nFor2,3,nFor,8]) ) //"EPC’S/Prevenção"
		Else
			IMPDOC852(STR0048+": "+Capital(aDados[nFor2,3,nFor,8]) ) //"EPC’S/Prevenção"
		Endif
	Next nFor
Next nFor2

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³TitNegTxt  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimi titulo negrito e conteudo sem negrito na mesma linha³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TitNegTxt(cTxtTit,cTxtMemo)
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,cTxtTit)

cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Sem_Negrito")
OLE_SetDocumentVar(oWord,cVar1, cTxtMemo )
Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fBuscaRisco³ Autor ³Denis Hyroshi de Souza ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Busca os riscos da Obra                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fBuscaRisco()
Local aRet := {}, nPos

dbSelectArea("TN0")
dbSetOrder(5)
dbSeek(xFilial("TN0")+TLL->TLL_CC)
While !Eof() .and. xFilial("TN0")+TLL->TLL_CC == TN0->TN0_FILIAL+TN0->TN0_CC

	nPos := aScan(aRet, {|x| x[1] == TN0->TN0_CODTAR .and. x[2] == TN0->TN0_CODFAS .and. x[3] == TN0->TN0_SUBFAS })
	If nPos == 0
		aAdd( aRet , { TN0->TN0_CODTAR , TN0->TN0_CODFAS , TN0->TN0_SUBFAS , {} , {} , {} , {} } )
		nPos := Len(aRet)
	Endif

	dbSelectArea("TNX")
	dbSetOrder(1)
	dbSeek(xFilial("TNX")+TN0->TN0_NUMRIS)
	While !Eof() .and. xFilial("TNX")+TN0->TN0_NUMRIS == TNX->TNX_FILIAL+TNX->TNX_NUMRIS
		If aScan(aRet[nPos,4], {|x| x[1] == TNX->TNX_EPI }) == 0
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek(xFilial("SB1")+TNX->TNX_EPI)
			aAdd( aRet[nPos,4] , { TNX->TNX_EPI , Alltrim(SB1->B1_DESC) } )
			dbSelectArea("TNX")
		Endif
		dbSkip()
	End

	dbSelectArea("TO9")
	dbSetOrder(1)
	dbSeek(xFilial("TO9")+TN0->TN0_NUMRIS)
	While !Eof() .and. xFilial("TO9")+TN0->TN0_NUMRIS == TO9->TO9_FILIAL+TO9->TO9_NUMRIS
		If aScan(aRet[nPos,5], {|x| x[1] == TO9->TO9_EPC }) == 0
			dbSelectArea("ST9")
			dbSetOrder(1)
			dbSeek(xFilial("ST9")+TO9->TO9_EPC)
			aAdd( aRet[nPos,5] , { TO9->TO9_EPC , Alltrim(ST9->T9_NOME) } )
			dbSelectArea("TO9")
		Endif
		dbSkip()
	End

	If aScan(aRet[nPos,6], {|x| x[1] == TN0->TN0_AGENTE }) == 0
		dbSelectArea("TMA")
		dbSetOrder(1)
		dbSeek(xFilial("TMA")+TN0->TN0_AGENTE)
		aAdd( aRet[nPos,6] , { TN0->TN0_AGENTE , Alltrim(TMA->TMA_NOMAGE) } )
	Endif

	If aScan(aRet[nPos,7], {|x| x[1] == TN0->TN0_MEDCON }) == 0
		dbSelectArea("TO4")
		dbSetOrder(1)
		If dbSeek(xFilial("TO4")+TN0->TN0_MEDCON)
			aAdd( aRet[nPos,7] , { TN0->TN0_MEDCON , Alltrim(TO4->TO4_NOMCTR) } )
		Endif
	Endif

	dbSelectArea("TN0")
	dbSkip()
End

dbSelectArea("TLP")
dbSetOrder(1)
dbSeek( xFilial("TLP") + TLL->TLL_CC )
While !eof() .and. xFilial("TLP") + TLL->TLL_CC == TLP->TLP_FILIAL+TLP->TLP_CC
	nPos := aScan(aRet, {|x| x[1] == TLP->TLP_CODTAR .and. x[2] == TLP->TLP_FASE .and. x[3] == TLP->TLP_SUBFAS })
	If nPos == 0
		aAdd( aRet , { TLP->TLP_CODTAR , TLP->TLP_FASE , TLP->TLP_SUBFAS , {} , {} , {} , {} } )
		nPos := Len(aRet)
	Endif
	If (nPos1 := aScan(aRet, {|x| Alltrim(x[1]) == "*"    .and. x[2] == TLP->TLP_FASE .and. x[3] == TLP->TLP_SUBFAS })) > 0
		aRet[nPos] := fMesclar( aRet[nPos] , aRet[nPos1] )
	Endif
	If (nPos2 := aScan(aRet, {|x| Alltrim(x[1]) == "*"    .and. x[2] == TLP->TLP_FASE .and. Empty(x[3]) })) > 0
		aRet[nPos] := fMesclar( aRet[nPos] , aRet[nPos2] )
	Endif
	If (nPos3 := aScan(aRet, {|x| Alltrim(x[1]) == "*"    .and. Empty(x[2]) .and. Empty(x[3]) })) > 0
		aRet[nPos] := fMesclar( aRet[nPos] , aRet[nPos3] )
	Endif
	If (nPos4 := aScan(aRet, {|x| x[1] == TLP->TLP_CODTAR .and. x[2] == TLP->TLP_FASE .and. Empty(x[3]) })) > 0
		aRet[nPos] := fMesclar( aRet[nPos] , aRet[nPos4] )
	Endif
	If (nPos5 := aScan(aRet, {|x| x[1] == TLP->TLP_CODTAR .and. Empty(x[2]) .and. Empty(x[3]) })) > 0
		aRet[nPos] := fMesclar( aRet[nPos] , aRet[nPos5] )
	Endif
	dbSelectArea("TLP")
	dbSkip()
End

Return aRet
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o      fMesclar    Autor ³Denis H. Souza         ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Mescla dois array                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fMesclar( aRet0 , aRet1 )
Local aMesc := aRet0
Local nNiv, nX

For nNiv := 4 to 7
	If Len(aRet1[nNiv]) > 0
		For nX := 1 to Len(aRet1[nNiv])
			If aScan(aMesc[nNiv], {|x| x[1] == aRet1[nNiv,nX,1] }) == 0
				aAdd( aMesc[nNiv] , aRet1[nNiv,nX] )
			Endif
		Next nX
	Endif
Next nNiv

Return aMesc

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    A852CRONOGRAMA Autor ³Denis H. Souza         ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cronograma do PPRA                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852CRONOGRAMA()
Local aArea := GetArea()
Local aPlanos := {}
Local _1st := .t.
Local nRegs := 0
Local cMemo := ""
Local cPadrao := ""
Local cPadrao2 := ""
Local cPadrao3 := ""
Local nFor
Local dDtIniCro := cTod("//")
Local nAnoIni := 0
Local nMesIni := 0
Local nAnoFim := 0
Local nMesFim := 0
Local aMes    := {STR0066,STR0067,STR0068,STR0069,STR0070,STR0071,STR0072,STR0073,STR0074,STR0075,STR0076,STR0077,STR0066,STR0067,STR0068,STR0069,STR0070,STR0071,STR0072,STR0073,STR0074,STR0075,STR0076,STR0077} //"Jan/"###"Fev/"###"Mar/"###"Abr/"###"Mai/"###"Jun/"###"Jul/"###"Ago/"###"Set/"###"Out/"###"Nov/"###"Dez/"###"Jan/"###"Fev/"###"Mar/"###"Abr/"###"Mai/"###"Jun/"###"Jul/"###"Ago/"###"Set/"###"Out/"###"Nov/"###"Dez/"
Local dtFimReal
Local dtFimPrev
Local cMemo2 := ""
Local lAcao
Local lPrim1 := .T.
Local cAcoes := "", cAno := ""
Local nLinha := 0, LinhaCorrente := 0

SG90PLACAO()//Adequação do Plano de Ação.

If lSigaMdtps

	dbSelectArea("TOZ")
	dbSetOrder(3)
	dbSeek(xFilial("TOZ") + cCliMdtPs + TO0->TO0_LAUDO)
	While !eof() .and. xFilial("TOZ")+TO0->TO0_LAUDO == TOZ->TOZ_FILIAL+TOZ->TOZ_LAUDO .and. cCliMdtPs == TOZ->TOZ_CLIENT+TOZ->TOZ_LOJA

		dbSelectArea( cAliasPA )
		dbSetOrder( nIndexPA )
		If dbSeek(xFilial( cAliasPA )+cCliMdtPs+TOZ->TOZ_PLANO)

			If !Empty((cAliasPA)->&(aFieldPA[8])) .OR. !Empty((cAliasPA)->&(aFieldPA[6]))

				If !Empty((cAliasPA)->&(aFieldPA[7]))
					dtFimPrev := (cAliasPA)->&(aFieldPA[7])
				Else
					dtFimPrev := CtoD("01/01/2040")
				Endif

				If !Empty((cAliasPA)->&(aFieldPA[9]))
					dtFimReal := (cAliasPA)->&(aFieldPA[9])
				Else
					dtFimReal := CtoD("01/01/2040")
				Endif

				aADD(aPlanos,{(cAliasPA)->&(aFieldPA[3]),(cAliasPA)->&(aFieldPA[6]),dtFimPrev,(cAliasPA)->&(aFieldPA[9]),dtFimReal})
			Endif

		Endif
		dbSelectArea("TOZ")
		dbSkip()
	End

Else

	dbSelectArea("TOZ")
	dbSetOrder(1)
	dbSeek(xFilial("TOZ")+TO0->TO0_LAUDO)
	While !eof() .and. xFilial("TOZ")+TO0->TO0_LAUDO == TOZ->TOZ_FILIAL+TOZ->TOZ_LAUDO

		dbSelectArea( cAliasPA )
		dbSetOrder( nIndexPA )
		If dbSeek(xFilial( cAliasPA )+TOZ->TOZ_PLANO)

			If !Empty((cAliasPA)->&(aFieldPA[8])) .OR. !Empty((cAliasPA)->&(aFieldPA[6]))

				If !Empty((cAliasPA)->&(aFieldPA[7]))
					dtFimPrev := (cAliasPA)->&(aFieldPA[7])
				Else
					dtFimPrev := CtoD("01/01/2040")
				Endif

				If !Empty((cAliasPA)->&(aFieldPA[9]))
					dtFimReal := (cAliasPA)->&(aFieldPA[9])
				Else
					dtFimReal := CtoD("01/01/2040")
				Endif

				aADD(aPlanos,{(cAliasPA)->&(aFieldPA[3]),(cAliasPA)->&(aFieldPA[6]),dtFimPrev,(cAliasPA)->&(aFieldPA[9]),dtFimReal})
			Endif

		Endif
		dbSelectArea("TOZ")
		dbSkip()
	End

Endif

ASORT(aPlanos,,,{|x,y| x[2] < y[2] })
If Len(aPlanos) > 0
	dDtIniCro := TO0->TO0_DTINIC
	nAnoIni := Year(dDtIniCro)
	nMesIni := Month(dDtIniCro)
	nAnoFim := Year(dDtIniCro)+1
	nMesFim := Month(dDtIniCro)
Endif

For nFor := 1 to Len(aPlanos)
	If nFor == 1
		cMemo += STR0055+" #*"  //"AÇÕES / MÊS"
		cMemo += aMes[nMesIni]+SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+1]+SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+2]+SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+3]+SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+4]+SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+5]+SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+6]+SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+7]+SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+8]+SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+9]+SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+10]+SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+11]+SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2)+" #*"
		cMemo += aMes[nMesIni+12]+SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2)+" #*"

		cPadrao += STR0055+Space(22)
		cPadrao += aMes[nMesIni]+Space(2)
		cAno += SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+1]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+2]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+3]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+4]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+5]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+6]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+7]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+8]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+9]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+10]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+11]+Space(2)
		cAno += SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		cPadrao += aMes[nMesIni+12]
		cAno += SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
	Endif     //OK

	If nModeloImp == 2 .And. lPrim1// 2 - Padrão
    	Somalinha()
    	Somalinha()
		@ Li,001 Psay cPadrao
		Somalinha()
		@ Li,034 Psay cAno
		Somalinha()
		@ Li,001 Psay ("_______________________________________________________________________________________________________________")
	  	lPrim1 := .F.
		Somalinha()
	EndIf

 	If nModeloImp == 1 .Or. nModeloImp == 2
		lAcao := .F.
		If !(Year(aPlanos[nFor,2]) > nAnoFim .and. Month(aPlanos[nFor,2]) > nMesFim) //Se a data inicial prevista está dentro do cronograma

			cMemo += Sente_Upper(Alltrim(aPlanos[nFor,1])) +" #*"
			cAcoes := Sente_Upper(Alltrim(aPlanos[nFor,1]))
			lAcao := .T.
			//Mes 1
			cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 2
			cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 3
			cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 4
			cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 5
			cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 6
			cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 7
			cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 8
			cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 9
			cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 10
			cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 11
			cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 12
			cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+Space(5)
			//Mes 13
			cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")+"#*"
			cPadrao2 += If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X"," ")
	Else
		//Mes 1
		cMemo2 += " "+"#*"
		//Mes 2
		cMemo2 += " "+"#*"
		//Mes 3
		cMemo2 += " "+"#*"
		//Mes 4
		cMemo2 += " "+"#*"
		//Mes 5
		cMemo2 += " "+"#*"
		//Mes 6
		cMemo2 += " "+"#*"
		//Mes 7
		cMemo2 += " "+"#*"
		//Mes 8
		cMemo2 += " "+"#*"
		//Mes 9
		cMemo2 += " "+"#*"
		//Mes 10
		cMemo2 += " "+"#*"
		//Mes 11
		cMemo2 += " "+"#*"
		//Mes 12
		cMemo2 += " "+"#*"
		//Mes 13
		cMemo2 += " "+"#*"
	Endif

	If !(Year(aPlanos[nFor,4]) > nAnoFim .and. Month(aPlanos[nFor,4]) > nMesFim); //Se a data inicial real está dentro do cronograma
			.AND. !Empty(aPlanos[nFor,4]) //Dt Real Ini *e* Final preenchidas

		If !lAcao
			cMemo += Sente_Upper(Alltrim(aPlanos[nFor,1])) +" #*"
		Endif
		//Mes 1
			cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 2
			cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 3
			cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 4
			cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 5
			cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 6
			cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 7
			cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 8
			cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 9
			cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 10
			cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 11
			cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 12
			cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+Space(5)
			//Mes 13
			cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
			cMemo2 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")+"#*"
			cPadrao3 += If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X"," ")
		Else
			//Mes 1
			cMemo2 += " "+"#*"
			//Mes 2
			cMemo2 += " "+"#*"
			//Mes 3
			cMemo2 += " "+"#*"
			//Mes 4
			cMemo2 += " "+"#*"
			//Mes 5
			cMemo2 += " "+"#*"
			//Mes 6
			cMemo2 += " "+"#*"
			//Mes 7
			cMemo2 += " "+"#*"
			//Mes 8
			cMemo2 += " "+"#*"
			//Mes 9
			cMemo2 += " "+"#*"
			//Mes 10
			cMemo2 += " "+"#*"
			//Mes 11
			cMemo2 += " "+"#*"
			//Mes 12
			cMemo2 += " "+"#*"
			//Mes 13
			cMemo2 += " "+"#*"
		Endif

		If nModeloImp == 2 // 2 - Padrão
			Somalinha()
  		  	@ Li,000 Psay AllTrim(Str(nFor)+"-"+SubStr(cAcoes,1,30))
   		@ Li,033 Psay "P"//"Planejado"
	    	@ Li,035 Psay cPadrao2
   	 	Somalinha()
   	 	@ Li,033 Psay "E"//"Executado"
			@ Li,035 Psay cPadrao3
			Somalinha()
			cPadrao2 := ""
			cPadrao3 := ""
		EndIf
	EndIf
	If nModeloImp == 3  //3 - Gráfico
			Somalinha()
		If lPrim1
			oPrintPPRA:Say(lin+10,280,STR0055,oFont08b) //"AÇÕES / MÊS"
			oPrintPPRA:Box(lin,150,lin+60,2275)
			oPrintPPRA:Line(lin,650,lin+60,650)
			oPrintPPRA:Line(lin,775,lin+60,775)
			oPrintPPRA:Line(lin,900,lin+60,900)
			oPrintPPRA:Line(lin,1025,lin+60,1025)
			oPrintPPRA:Line(lin,1150,lin+60,1150)
			oPrintPPRA:Line(lin,1275,lin+60,1275)
			oPrintPPRA:Line(lin,1400,lin+60,1400)
			oPrintPPRA:Line(lin,1525,lin+60,1525)
	  		oPrintPPRA:Line(lin,1650,lin+60,1650)
	  		oPrintPPRA:Line(lin,1775,lin+60,1775)
	  		oPrintPPRA:Line(lin,1900,lin+60,1900)
	  		oPrintPPRA:Line(lin,2025,lin+60,2025)
	  		oPrintPPRA:Line(lin,2150,lin+60,2150)

  			oPrintPPRA:Say(lin,651,aMes[nMesIni]+SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,776,aMes[nMesIni+1]+SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,901,aMes[nMesIni+2]+SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,1026,aMes[nMesIni+3]+SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,1151,aMes[nMesIni+4]+SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,1276,aMes[nMesIni+5]+SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,1401,aMes[nMesIni+6]+SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,1526,aMes[nMesIni+7]+SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,1651,aMes[nMesIni+8]+SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,1776,aMes[nMesIni+9]+SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,1901,aMes[nMesIni+10]+SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,2026,aMes[nMesIni+11]+SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			oPrintPPRA:Say(lin,2151,aMes[nMesIni+12]+SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
  			Somalinha()
			lPrim1 := .F.
		EndIf

		lAcao := .F.
		If !(Year(aPlanos[nFor,2]) > nAnoFim .and. Month(aPlanos[nFor,2]) > nMesFim) //Se a data inicial prevista está dentro do cronograma

			cAcoes := Sente_Upper(Alltrim(aPlanos[nFor,1]))
			lAcao := .T.

			//Mes 1
			cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
			oPrintPPRA:Say(lin+15,713,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 2
			cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
			oPrintPPRA:Say(lin+15,838,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 3
			cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
			oPrintPPRA:Say(lin+15,963,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 4
			cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
			oPrintPPRA:Say(lin+15,1088,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 5
			cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
			oPrintPPRA:Say(lin+15,1213,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 6
			cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
			oPrintPPRA:Say(lin+15,1338,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 7
			cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
			oPrintPPRA:Say(lin+15,1463,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 8
			cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
			oPrintPPRA:Say(lin+15,1588,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 9
			cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
			oPrintPPRA:Say(lin+15,1713,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 10
			cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
			oPrintPPRA:Say(lin+15,1838,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 11
			cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
			oPrintPPRA:Say(lin+15,1963,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 12
			cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
			oPrintPPRA:Say(lin+15,2088,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
			//Mes 13
			cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
			oPrintPPRA:Say(lin+15,2213,If(cDtTemp >= aPlanos[nFor,2].and. cDtTemp <= aPlanos[nFor,3],"X",""),oFont08b)
		Endif

		If !(Year(aPlanos[nFor,4]) > nAnoFim .and. Month(aPlanos[nFor,4]) > nMesFim); //Se a data inicial real está dentro do cronograma
				.AND. !Empty(aPlanos[nFor,4]) //Dt Real Ini *e* Final preenchidas

			//Mes 1
			cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
			oPrintPPRA:Say(lin+75,713,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 2
			cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
			oPrintPPRA:Say(lin+75,838,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 3
			cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
			oPrintPPRA:Say(lin+75,963,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 4
			cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
			oPrintPPRA:Say(lin+75,1088,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 5
			cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
			oPrintPPRA:Say(lin+75,1213,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 6
			cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
			oPrintPPRA:Say(lin+75,1338,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 7
			cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
			oPrintPPRA:Say(lin+75,1463,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 8
			cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
			oPrintPPRA:Say(lin+75,1588,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 9
			cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
			oPrintPPRA:Say(lin+75,1713,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 10
			cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
			oPrintPPRA:Say(lin+75,1838,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 11
			cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
			oPrintPPRA:Say(lin+75,1963,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 12
			cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
			oPrintPPRA:Say(lin+75,2088,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
			//Mes 13
			cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
			oPrintPPRA:Say(lin+75,2213,If(cDtTemp >= aPlanos[nFor,4].and. cDtTemp <= aPlanos[nFor,5],"X",Space(1)),oFont08b)
		Endif

		If nModeloImp == 3  //3 - Gráfico
		  	//oPrintPPRA:Line(lin,800,lin,2300)
		  	oPrintPPRA:Line(lin,150,lin+60,150)
		  	oPrintPPRA:Line(lin,570,lin+60,570)
		  	oPrintPPRA:Line(lin,650,lin+60,650)
		  	oPrintPPRA:Line(lin,775,lin+60,775)
			oPrintPPRA:Line(lin,900,lin+60,900)
			oPrintPPRA:Line(lin,1025,lin+60,1025)
			oPrintPPRA:Line(lin,1150,lin+60,1150)
			oPrintPPRA:Line(lin,1275,lin+60,1275)
			oPrintPPRA:Line(lin,1400,lin+60,1400)
			oPrintPPRA:Line(lin,1525,lin+60,1525)
			oPrintPPRA:Line(lin,1650,lin+60,1650)
			oPrintPPRA:Line(lin,1775,lin+60,1775)
	  		oPrintPPRA:Line(lin,1900,lin+60,1900)
	  		oPrintPPRA:Line(lin,2025,lin+60,2025)
	  		oPrintPPRA:Line(lin,2150,lin+60,2150)
	  		oPrintPPRA:Line(lin,2275,lin+60,2275)
	  		//oPrintPPRA:Line(lin,2400,lin+60,2400)
	  		//oPrintPPRA:Line(lin,2300,lin+60,2300)
	  		oPrintPPRA:Line(lin,150,lin,2275)
	  		nLinhasMemo := MLCOUNT(AllTrim(cAcoes),17)
	  		oPrintPPRA:Say(lin,170,AllTrim(Str(nFor)+" - "),oFont08b)
	  		nLinha := lin
			For LinhaCorrente := 1 to nLinhasMemo
				If	LinhaCorrente > 2
					Exit
				EndIf
				If !empty( (MemoLine(cAcoes,17,LinhaCorrente)))
		   		oPrintPPRA:Say(nLinha,220,MemoLine(cAcoes,17,LinhaCorrente),oFont08b)
		   		nLinha := lin+40
				Endif
		    Next
	  		//oPrintPPRA:Say(lin,170,AllTrim(Str(nFor)+" - "+SubStr(cAcoes,1,30)),oFont08b)
	    	oPrintPPRA:Say(lin+10,600,"P",oFont08b)//"Planejado"
	      SomaLinha()
	      oPrintPPRA:Line(lin,575,lin,2275) //linhas
	      oPrintPPRA:Line(lin,150,lin+60,150)
		  	oPrintPPRA:Line(lin,570,lin+60,570)
	  		oPrintPPRA:Line(lin,650,lin+60,650)
		  	oPrintPPRA:Line(lin,775,lin+60,775)
			oPrintPPRA:Line(lin,900,lin+60,900)
			oPrintPPRA:Line(lin,1025,lin+60,1025)
			oPrintPPRA:Line(lin,1150,lin+60,1150)
			oPrintPPRA:Line(lin,1275,lin+60,1275)
			oPrintPPRA:Line(lin,1400,lin+60,1400)
			oPrintPPRA:Line(lin,1525,lin+60,1525)
			oPrintPPRA:Line(lin,1650,lin+60,1650)
			oPrintPPRA:Line(lin,1775,lin+60,1775)
	  		oPrintPPRA:Line(lin,1900,lin+60,1900)
	  		oPrintPPRA:Line(lin,2025,lin+60,2025)
	  		oPrintPPRA:Line(lin,2150,lin+60,2150)
	  		oPrintPPRA:Line(lin,2275,lin+60,2275)
			oPrintPPRA:Say(lin+10,600,"E",oFont08b)//"Executado"
		EndIf
	EndIf
Next nFor

nRegs := Len(aPlanos)
If nRegs > 0
	If nModeloImp == 1//Word


    	OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Tabela2",cMemo2)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_Cronograma")
		_lJumpCab := lJumpCab
		lJumpCab := .t.
		IMPHEA850("{CN}P: "+STR0056,.f.)  //"Planejado"
		lJumpCab := .t.
		IMPHEA850("{CN}E: "+STR0057,.f.)  //"Executado"
		lJumpCab := _lJumpCab
		OLE_ExecuteMacro(oWord,"Somalinha")
    	OLE_ExecuteMacro(oWord,"Somalinha")
	ELseIf nModeloImp == 2  //2 - Padrão
   	SomaLinha()
  		@ Li,055 Psay "P: "+STR0056
  		Somalinha()
		@ Li,055 Psay "E: "+STR0057
		Somalinha()
   ELseIf nModeloImp == 3  //3 - Gráfico
   	SomaLinha()
	  	oPrintPPRA:Line(lin,150,lin,2275)
		oPrintPPRA:Say(lin+10,1220,"P: "+STR0056,oFont08b)
	  	SomaLinha()
	  	oPrintPPRA:Say(lin+10,1220,"E: "+STR0057,oFont08b)
    EndIf
Else
	If nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
	Endif
Endif

RestArea(aArea)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MDTR852   ºAutor  ³Andre Perez Alvarez º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Transforma a primeira palavra de uma sentença em maiúsculaº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR852                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Sente_Upper(cTexto)

Local cTextoNew := SubSTR(cTexto,1,1) + Lower(SubStr(cTexto,2))
Local cTextoAux := ""

While .T.

	nPos := at(". ",cTextoNew)
	If nPos > 0
		cTextoAux += SubSTR(cTextoNew,1,nPos+1)
		cTextoNew := Upper(SubSTR(cTextoNew,nPos+2,1)) + SubSTR(cTextoNew,nPos+3)
	Else
		cTextoAux += cTextoNew
		Exit
	Endif

End

Return cTextoAux
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MDTR852   ºAutor  ³Andre Perez Alvarez º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Valida o centro de custo do cliente.                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR852                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDT852CCVL(cCodCC)

If SubStr(cCodCC,1,nTa1+nTa1L) <> cCliMdtps
	msgStop(STR0049) //"O centro de custo deve pertencer ao cliente selecionado."
	Return .F.
Endif

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fReguaPPRAºAutor  ³Denis               º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Processa regua                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR852                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fReguaPPRA( nLenMemo, nPerMemo, nLenAtual )
Local nLenOld := (100 - nPerMemo) * ( nLenMemo / 100 ) //Calcula Len anterior
Local nDiff := nLenOld - nLenAtual
Local nFor,nPercent
If nDiff > 0
	//Porcentagem que processou neste Loop
	nPercent := Round( (100 / nLenMemo) * nDiff , 0 )
	//Porcentagem processada
	nPerMemo += nPercent
	If nPercent >= 1 .and. nPercent <= 100
		For nFor := 1 To nPercent
			IncRegua()
		Next nFor
	Endif
Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A852EPIQ  ³ Autor ³Andre E. Perez Alvarez ³ Data ³ 03.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME OS EPIS RELACIONADOS AOS RISCOS EXISTENTES EM UMA   ³±±
±±³          ³TABELA QUE CONTEM O TIPO DE PROTECAO DO EPI E A SUA AREA    ³±±
±±³          ³DE UTILIZACAO                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852EPIQ()

Local cMemo := "",nRisco
Local nRegs := 0
Local _1st := .t.
Local aQuadEPI := {}
Local nX

aEpis      := {}

If lSigaMdtps

	dbSelectArea("TO1")
	dbSetOrder(3)
	dbSeek(xFilial("TO1") + cCliMdtPs + TO0->TO0_LAUDO)
	While !eof() .and. xFilial("TO1")+TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO .and. cCliMdtPs == TO1->TO1_CLIENT+TO1->TO1_LOJA


		dbSelectArea("TNX")
		dbSetOrder(4)  //TNX_FILIAL+TNX_CLIENT+TNX_LOJA+TNX_NUMRIS+TNX_EPI
		dbSeek(xFilial("TNX")+cCliMdtps+TO1->TO1_NUMRIS)
		While !Eof() .and. xFilial("TNX")+TO1->TO1_NUMRIS == TNX->TNX_FILIAL+TNX->TNX_NUMRIS .AND. cCliMdtps == TNX->(TNX_CLIENT+TNX_LOJA)

		    If aScan(aEpis,{|X| X[1] == TNX->TNX_EPI}) > 0
				dbSelectArea("TNX")
				dbSkip()
				Loop
			Endif

			dbSelectArea("TN3")
			dbSetOrder(4)
			If !dbSeek(xFilial("TN3")+cCliMdtPs+TNX->TNX_EPI)
				dbSelectArea("TNX")
				dbSkip()
				Loop
			Endif
			aAdd(aEpis,{TNX->TNX_EPI})

			dbSelectArea("SB1")
			dbSetOrder(1)
			If dbSeek(xFilial("SB1")+TNX->TNX_EPI)
				AADD (aQuadEPI, {TN3->TN3_TIPEPI, TN3->TN3_NUMCAP, SB1->B1_DESC, SubStr(TN3->TN3_AREEPI,1,40) } )
			Endif
			dbSelectArea("TNX")
			dbSkip()
		End

		dbSelectArea("TO1")
		dbSkip()
	End

Else

	dbSelectArea("TO1")
	dbSetOrder(1)
	dbSeek(xFilial("TO1")+TO0->TO0_LAUDO)
	While !eof() .and. xFilial("TO1")+TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO

		dbSelectArea("TNX")
		dbSetOrder(1)
		dbSeek(xFilial("TNX")+TO1->TO1_NUMRIS)
		While !Eof() .and. xFilial("TNX")+TO1->TO1_NUMRIS == TNX->TNX_FILIAL+TNX->TNX_NUMRIS

		    If aScan(aEpis,{|X| X[1] == TNX->TNX_EPI}) > 0
				dbSelectArea("TNX")
				dbSkip()
				Loop
			Endif

			dbSelectArea("TN3")
			dbSetOrder(2)
			If !dbSeek(xFilial("TN3")+TNX->TNX_EPI)
				dbSelectArea("TNX")
				dbSkip()
				Loop
			Endif
			aAdd(aEpis,{TNX->TNX_EPI})

			dbSelectArea("SB1")
			dbSetOrder(1)
			If dbSeek(xFilial("SB1")+TNX->TNX_EPI)
				// Os campos TN3_TIPEPI e TN3_AREEPI por enquanto soh existem no modo de Prestador-Padrao
				AADD (aQuadEPI, {TN3->TN3_TIPEPI, TN3->TN3_NUMCAP, SB1->B1_DESC, SubStr(TN3->TN3_AREEPI,1,40) } )
			Endif
			dbSelectArea("TNX")
			dbSkip()
		End

		dbSelectArea("TO1")
		dbSkip()
	End
Endif

If Len(aQuadEPI) > 0
	ASORT(aQuadEPI,,,{|x,y| x[1] < y[1] })

	If nModeloImp == 2
		nRegs++
		If _1st
			  //     1         2         3         4         5         6         7         8         9        10        11        12        13
                 //456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
			 //Tipo de Proteção:              C.A. Ref.:    Tipo de EPI:                              Área de Utilização:
			 //1234567890123456789012345      123456789012  123456789012345678901234567890123456789   1234567890123456789012345678901234567890
			Somalinha()
			@ Li,004 Psay STR0050 //"Tipo de Proteção:              C.A. Ref.:    Tipo de EPI:                              Tarefa Executada:"
			_1st := .f.
		Endif
		For nX := 1 To Len(aQuadEpi)
			Somalinha()
			@ Li,004 Psay aQuadEPI[nX][1]
			@ Li,035 Psay aQuadEPI[nX][2]
			@ Li,049 Psay aQuadEPI[nX][3]
			@ Li,091 Psay aQuadEPI[nX][4]
		Next nX
	ElseIf nModeloImp == 3
		For nX := 1 To Len(aQuadEpi)
			If nX == 1
				If lin+120 > 3000
					lin := 9999
				Endif
				Somalinha()
				oPrintPPRA:Line(lin,150,lin,2300)
				oPrintPPRA:Line(lin+60,150,lin+60,2300)
				oPrintPPRA:Line(lin,150,lin+60,150)
				oPrintPPRA:Say(lin+10,280,STR0051,oFont10b) //"Tipo de Proteção"
				oPrintPPRA:Line(lin,650,lin+60,650)
				oPrintPPRA:Say(lin+10,760,STR0052,oFont10b) //"C.A. Ref."
				oPrintPPRA:Line(lin,1050,lin+60,1050)
				oPrintPPRA:Say(lin+10,1240,STR0053,oFont10b) //"Tipo de EPI"
				oPrintPPRA:Line(lin,1650,lin+60,1650)
				oPrintPPRA:Say(lin+10,1800,STR0054,oFont10b) //"Tarefa Executada"
				oPrintPPRA:Line(lin,2300,lin+60,2300)
			Endif
			Somalinha()
			If lin == 300
				oPrintPPRA:Line(lin,150,lin,2300)
			Endif
			oPrintPPRA:Line(lin+60,150,lin+60,2300)
			oPrintPPRA:Line(lin,150,lin+60,150)
			oPrintPPRA:Say(lin+10,160,Substr(aQuadEPI[nX][1],1,30),oFont08)
			oPrintPPRA:Line(lin,650,lin+60,650)
			oPrintPPRA:Say(lin+10,660,aQuadEPI[nX][2],oFont08)
			oPrintPPRA:Line(lin,1050,lin+60,1050)
			oPrintPPRA:Say(lin+10,1060,Substr(aQuadEPI[nX][3],1,35),oFont08)
			oPrintPPRA:Line(lin,1650,lin+60,1650)
			oPrintPPRA:Say(lin+10,1660,Substr(aQuadEPI[nX][4],1,40),oFont08)
			oPrintPPRA:Line(lin,2300,lin+60,2300)
		Next nX
	Else
		For nX := 	1 To Len(aQuadEpi)
			nRegs++
			cMemo += Alltrim(aQuadEPI[nX][1])+"#*"
			cMemo += Alltrim(aQuadEPI[nX][2])+"#*"
			cMemo += Alltrim(aQuadEPI[nX][3])+"#*"
			cMemo += Alltrim(aQuadEPI[nX][4])+"#*"
		Next nX
	Endif

Endif

If nRegs > 0
	If nModeloImp != 1
		Somalinha()
	Else
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_EpiQuad")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
	Endif
Else
	If nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
	Endif
Endif

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o     A852EPIFUN  Autor ³Denis Hyroshi de Souza ³ Data ³ 11.08.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME LISTAGEM DOS EPIS x FUNCAO                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function A852EPIFUN()
Local aArea := GetArea()
Local cFuncao

If !lSigaMdtPs

	dbSelectArea("SRJ")
	dbSetOrder(3)
	dbSeek(xFilial("SRJ"))
	While !EOF() .AND. xFilial("SRJ") == SRJ->RJ_FILIAL

  		nContFun := 0

		dbSelectArea("SRA")
		dbSetOrder(7)
		dbSeek(xFilial("SRA")+SRJ->RJ_FUNCAO)
		While !eof() .and. xFilial("SRA")+SRJ->RJ_FUNCAO == SRA->RA_FILIAL+SRA->RA_CODFUNC
			If SRA->RA_SITFOLH != "D" .And. SRA->RA_CC == TO0->TO0_CC
				nContFun++
				Exit
			Endif
			dbSkip()
		End

		If nContFun = 0
			dbSelectArea("SRJ")
			dbSkip()
			Loop
		Endif

		cTxtEpi := ""
		dbSelectArea("TNB")
		dbSetOrder(1)
		dbSeek(xFilial("TNB")+SRJ->RJ_FUNCAO)
		While !eof() .and. xFilial("TNB")+SRJ->RJ_FUNCAO == TNB->TNB_FILIAL+TNB->TNB_CODFUN
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek(xFilial("SB1")+TNB->TNB_CODEPI)
			If !Empty(cTxtEpi)
				cTxtEpi += ", "
			Endif
			cTxtEpi += Alltrim(SB1->B1_DESC)
			dbSelectArea("TNB")
			dbSkip()
		End

		If !Empty(cTxtEpi)
			Somalinha()
			lIdentar := .f.
			If nModeloImp == 1
				TitNegTxt(Alltrim(SRJ->RJ_DESC)+": " , Capital(cTxtEpi) )
			Else
				IMPDOC852(Alltrim(SRJ->RJ_DESC)+": " + Capital(cTxtEpi) )
			Endif
		Endif

		dbSelectArea("SRJ")
		dbSkip()
	End

Else

	dbSelectArea("TOS")
	dbSetOrder(2)
	dbSeek(xFilial("TOS")+cCliMdtPs)
	While !EOF() .AND. xFilial("TOS")+cCliMdtPs == TOS->(TOS_FILIAL+TOS_CLIENT+TOS_LOJA)

		cTxtEpi := ""
		dbSelectArea("TNB")
		dbSetOrder(4) //TNB_FILIAL+TNB_CLIENT+TNB_LOJA+TNB_CODFUN+TNB_CODEPI
		dbSeek(xFilial("TNB")+cCliMdtPs+SRJ->RJ_FUNCAO)
		While !eof() .and. xFilial("TNB")+cCliMdtPs+SRJ->RJ_FUNCAO == TNB->(TNB_FILIAL+TNB_CLIENT+TNB_LOJA+TNB_CODFUN)
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek(xFilial("SB1")+TNB->TNB_CODEPI)
			If !Empty(cTxtEpi)
				cTxtEpi += ", "
			Endif
			cTxtEpi += SB1->B1_DESC
			dbSelectArea("TNB")
			dbSkip()
		End

		cFuncao := TOS->TOS_DESFUN
		If Empty(TOS->TOS_DESFUN)
			cFuncao := NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC")
		Endif
		If !Empty(cTxtEpi)
			lIdentar := .f.
			If nModeloImp == 1
				TitNegTxt(Alltrim(cFuncao)+": " , Capital(cTxtEpi) )
			Else
				IMPDOC852(Alltrim(cFuncao)+": " + Capital(cTxtEpi) )
			Endif
		Endif

		dbSelectArea("TOS")
		dbSkip()
	End
Endif

If nModeloImp == 2
	Somalinha()
ElseIf nModeloImp == 1
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Somalinha")
Endif

dbSelectArea("SRJ")
dbSetOrder(1)

RestArea(aArea)
Return .t.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A852FASES ºAutor  ³Roger Rodrigues     º Data ³  21/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime Vivencias, Equipamentos e EPC's da Fase da Obra     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³MDTR852                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A852FASES(lVivencia, lEquip, lEPC)
Local aArea := GetArea(), lImp := .F., cDescri := "", lFirst := .T.
Default lVivencia := .T.
Default lEquip := .T.
Default lEPC := .T.

dbSelectArea("TLM")
dbSetOrder(1)
dbSeek(xFilial("TLM")+TLL->TLL_CC)
While !eof() .and. xFilial("TLM")+TLL->TLL_CC == TLM->TLM_FILIAL+TLM->TLM_CC
	lImp := .T.
	If Empty(TLM->TLM_SUBFAS)
		IMPHEA852("{N}"+Upper(AllTrim(NGSEEK("TLZ",TLM->TLM_FASE,1,"TLZ_DESCRI"))))
	Else
		IMPHEA852("{N}"+Capital(AllTrim(NGSEEK("TLZ",TLM->TLM_SUBFAS,1,"TLZ_DESCRI"))))
	Endif

	//Imprime as vivencias relacionadas
	If lVivencia
		lFirst := .T.
		dbSelectArea("TK1")
		dbSetOrder(1)
		dbSeek(xFilial("TK1")+TLM->TLM_CC+TLM->TLM_FASE+TLM->TLM_SUBFAS)
		While !eof() .and. xFilial("TK1")+TLM->TLM_CC+TLM->TLM_FASE+TLM->TLM_SUBFAS == TK1->TK1_FILIAL+TK1->TK1_CC+TK1->TK1_FASE+TK1->TK1_SUBFAS
			lIdentar := .f.
			If lFirst
				IMPDOC852("{N}"+Capital(STR0078) ,.T.) //"Áreas de Vivência da Fase"
				lFirst := .F.
			Endif
			cDescri  := Alltrim( MSMM(TK1->TK1_CARACT,80) )
			IMPDOC852( Capital(AllTrim(NGSEEK("TLS",TK1->TK1_AREA,1,"TLS_DESVIV"))) +": "+cDescri ,.T.)
			If nModeloImp <> 1
				Somalinha()
			Else
				OLE_ExecuteMacro(oWord,"Somalinha")
			Endif
			dbSelectArea("TK1")
			dbSkip()
		End
		If nModeloImp <> 1
			Somalinha()
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
		Endif
	Endif
	//Imprime os equipamentos relacionadas
	If lEquip
		lFirst := .T.
		dbSelectArea("TK2")
		dbSetOrder(1)
		dbSeek(xFilial("TK2")+TLM->TLM_CC+TLM->TLM_FASE+TLM->TLM_SUBFAS)
		While !eof() .and. xFilial("TK2")+TLM->TLM_CC+TLM->TLM_FASE+TLM->TLM_SUBFAS == TK2->TK2_FILIAL+TK2->TK2_CC+TK2->TK2_FASE+TK2->TK2_SUBFAS
			lIdentar := .f.
			If lFirst
				IMPDOC852("{N}"+Capital(STR0079) ,.T.) //"Equipamentos da Fase"
				lFirst := .F.
			Endif
			cDescri  := Alltrim( MSMM(TK2->TK2_OBSERV,80) )
			IMPDOC852( Capital(AllTrim(NGSEEK("TNH",TK2->TK2_CODEQU,1,"TNH_DESOBJ"))) +": "+cDescri ,.T.)
			If nModeloImp <> 1
				Somalinha()
			Else
				OLE_ExecuteMacro(oWord,"Somalinha")
			Endif
			dbSelectArea("TK2")
			dbSkip()
		End
		If nModeloImp <> 1
			Somalinha()
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
		Endif
	Endif
	//Imprime as vivencias relacionadas
	If lEPC
		lFirst := .T.
		dbSelectArea("TK3")
		dbSetOrder(1)
		dbSeek(xFilial("TK3")+TLM->TLM_CC+TLM->TLM_FASE+TLM->TLM_SUBFAS)
		While !eof() .and. xFilial("TK3")+TLM->TLM_CC+TLM->TLM_FASE+TLM->TLM_SUBFAS == TK3->TK3_FILIAL+TK3->TK3_CC+TK3->TK3_FASE+TK3->TK3_SUBFAS
			lIdentar := .f.
			If lFirst
				IMPDOC852("{N}"+Capital(STR0080) ,.T.) //"EPC's da Fase"
				lFirst := .F.
			Endif
			cDescri  := Alltrim( MSMM(TK3->TK3_OBSERV,80) )
			IMPDOC852( Capital(AllTrim(NGSEEK("ST9",TK3->TK3_CODEPC,1,"T9_NOME"))) +": "+cDescri ,.T.)
			If nModeloImp <> 1
				Somalinha()
			Else
				OLE_ExecuteMacro(oWord,"Somalinha")
			Endif
			dbSelectArea("TK3")
			dbSkip()
		End
		If nModeloImp <> 1
			Somalinha()
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
		Endif
	Endif
	dbSelectArea("TLM")
	dbSkip()
End
If lImp
	If nModeloImp <> 1
		Somalinha()
	Else
		OLE_ExecuteMacro(oWord,"Somalinha")
	Endif
Endif

RestArea(aArea)
Return .T.


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A852IMAGEM³ Autor ³ Denis                 ³ Data ³ 04.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao para inserir imagem no doc                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR850 e MDTR851                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A852IMAGEM(cTitTemp)
Local cFileArq := "", nPos
Local cBarraSrv := "\"

If nModeloImp != 1 //Se nao for em formato WORD, nao imprime
	Return
Endif

If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
	cBarraSrv := "/"
Endif

nPos := Rat(cBarraSrv,cTitTemp)
If nPos > 0
	cFileArq := AllTrim(Substr(cTitTemp,nPos+1))
Endif

CpyS2T(Alltrim(cTitTemp),cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario

If File( cPathEst+cFileArq )
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_SetDocumentVar(oWord,"Cria_Var",cPathEst+cFileArq)
	OLE_ExecuteMacro(oWord,"Insere_img")
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³A852ARQUIVO³ Autor ³ Denis                 ³ Data ³ 04.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao para inserir documentos no doc                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR850 e MDTR851                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A852ARQUIVO(cTitTemp)
Local cFileArq := "", nPos
Local cBarraSrv := "\"

If nModeloImp != 1 //Se nao for em formato WORD, nao imprime
	Return
Endif

If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
	cBarraSrv := "/"
Endif

nPos := Rat(cBarraSrv,cTitTemp)
If nPos > 0
	cFileArq := AllTrim(Substr(cTitTemp,nPos+1))
Endif

CpyS2T(Alltrim(cTitTemp),cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario

If File( cPathEst+cFileArq )
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_SetDocumentVar(oWord,"Cria_Var",cPathEst+cFileArq)
	OLE_ExecuteMacro(oWord,"Insere_doc")
Endif

Return
