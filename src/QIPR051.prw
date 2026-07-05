/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIPR051.Ch"
#Include "PROTHEUS.Ch"

/*/              
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIPR051  ³ Autor ³ Leandro Sabino        ³ Data ³ 01.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Certificados de Qualidade II                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQIP                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³String    ³ Ultimo utilizado -> 0036       							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cicero Cruz ³25/05/06³Melhor³ Revisao do Fonte                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QIPR051()
Local oDlgGet
Local oListBox
Local nItem		:=0
Private lEnd	:=.F.
Private aListBox:={}
Private cPerg1	:="QPR051"
Private Li		:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Janela Principal                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,OemToAnsi(STR0004))		//" Texto Superior "
AADD(aListBox,OemToAnsi(STR0005))		//" Texto Inferior "
AADD(aListBox,OemToAnsi(STR0034))		//" Informacoes Complementares "
AADD(aListBox,OemToAnsi(STR0006))		//" Impressao "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa ListBox com opcoes para o array da configuracao          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlgGet TITLE STR0007 FROM  0,0	TO 217,297 OF oMainWnd PIXEL 	//"Certificado de Qualidade"
@ 01,05 SAY OemToAnsi(STR0008)	SIZE 100, 07 OF oDlgGet PIXEL					//"Itens de Configuracao"
@ 10,05 LISTBOX oListBox VAR nItem  ITEMS aListBox  ON DBLCLICK Iif(nItem<=3,R051TEXT(oListBox),Pergunte(cPerg1,.T.)) SIZE 110,90 PIXEL OF oDlgGet
DEFINE SBUTTON FROM 10, 120 TYPE 6 ACTION (R051IMP(),oDlgGet:End()) ENABLE OF oDlgGet
DEFINE SBUTTON FROM 26, 120 TYPE 2 ACTION oDlgGet:End() ENABLE OF oDlgGet

ACTIVATE MSDIALOG oDlgGet CENTERED
Return(.T.)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R051Text ³ Autor ³ Leandro Sabino        ³ Data ³ 01.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Tela para preenchimento do conteudo relacionado com o ³±±
±±³          ³ListBox.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIPR051                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R051Text(oListBox)
Local oDlgGet2
Local oTexto
Local cTexto 		:= ""
Local oFontDialog	:= TFont():New("Arial",6,15,,.T.)


nAt:=oListBox:nAt

cNomeArq := "X"
nHdl:=MSFCREATE(cNomeArq,0)
If nHdl <= -1
	HELP(" ",1,"NODIRCQ")
	Return .T.
Else
	If File(cNomeArq)
		FCLOSE(nHdl)
		FERASE(cNomeArq)
	Endif
Endif

cNomeArq := "QPR051"+Str(nAt,1)+".TXT"

While .T.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Le arquivo                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTexto:=MemoRead(cNomeArq)
	
	DEFINE MSDIALOG oDlgGet2 FROM	62,100 TO 345,610 TITLE  OemToAnsi(STR0008) PIXEL FONT oFontDialog		//"Itens de Configura‡Æo"
	@ 003, 004 TO 027, 250 LABEL "" 	OF oDlgGet2 PIXEL
	@ 040, 004 TO 110, 250				OF oDlgGet2 PIXEL
	
	@ 013, 010 MSGET aListBox[nAt]		             WHEN .F. SIZE 235, 010 OF oDlgGet2 PIXEL
	@ 050, 010 GET oTexto VAR cTexto MEMO NO VSCROLL WHEN .T. SIZE 235, 051 OF oDlgGet2 PIXEL
	
	DEFINE SBUTTON FROM 120,190 TYPE 1 ACTION (MemoWrit( cNomeArq,cTexto ),FCLOSE(cNomeArq),oDlgGet2:End()) ENABLE OF oDlgGet2
	DEFINE SBUTTON FROM 120,220 TYPE 2 ACTION oDlgGet2:End() ENABLE OF oDlgGet2
	
	ACTIVATE MSDIALOG oDlgGet2 CENTERED
	Exit
EndDo

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R051Imp  ³ Autor ³ Leandro Sabino        ³ Data ³ 01.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Certificado                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQIP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R051Imp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Par"metros para a fun‡"o SetPrint () ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel		:="QIPR051"
LOCAL cString	:="QPR"
LOCAL cDesc1	:=STR0009		//"Neste relatorio sera impresso os Certificados"
LOCAL cDesc2	:=""
LOCAL cDesc3	:=""
Local nVias     :=0
Local cNota     :=""
Local cSerie    :=""
Local nImpEns   :=0

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Par"metros para a fun‡"o Cabec()  ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cRevi       :=""
PRIVATE cTitulo 	:=STR0010	//"Certificado Qualidade"
PRIVATE cRelatorio	:="QIPR051"
PRIVATE nTamanho	:="M"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas pela fun‡"o SetDefault () ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aReturn 	:= {STR0011, 1,STR0012,  1, 2, 1, "",1 }		//"Zebrado"###"Administracao"
PRIVATE nLastKey 	:= 0
PRIVATE cPerg		:= "QPR052"
PRIVATE cPergR		:= "QPR50R"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01           // Cliente                                ³
//³ mv_par02           // Loja do Cliente                        ³
//³ mv_par03           // Produto de                             ³
//³ mv_par04           // Produto ate                            ³
//³ mv_par05           // Revisao de                             ³
//³ mv_par06           // Revisao ate                            ³                                                                   
//| mv_par07           // Ordem de Producao de                   ³
//| mv_par08           // Ordem de Producao ate                  ³
//| mv_par09           // Lote de                                ³
//| mv_par10           // Lote ate                               ³
//| mv_par11           // Data da Producao de                    ³
//| mv_par12           // Data da Producao ate                   ³
//| mv_par13           // Pedido de Venda de                     ³
//| mv_par14           // Pedido de Venda ate                    ³
//| mv_par15           // Numero de Serie                        ³
//| mv_par16           // Nr. de Vias/Copias                     ³
//| mv_par17           // Impr. Ensaio Texto (Primeira/Todas)    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                                                                                              //N

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If FunName() == "QIPA215"
	
	Pergunte(cPergR,.F.)
	wnrel := SetPrint(cString,wnrel,cPergR,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,nTamanho)
	
	//Salva variaveis do pergunte QIPR501
	nVias     :=mv_par01
	cRevi     :=mv_par02 //vERIFICAR
	nImpEns   :=mv_par03
	cNota     :=MV_PAR05
	cSerie    :=MV_PAR07
	
	Pergunte(cPerg,.F.)
	
	//Atualiza variaveis do pergunte padrao do relatorio QIPR051
	cRevi     :=Iif(Empty(AllTrim(mv_par02)),QA_UltRevEsp(QPK->QPK_PRODUT,,,,"QIP"),QPK->QPK_REVI)
	mv_par01 := cIPCLIENT        // Cliente
	mv_par02 := cIPLoj           // Loja do Cliente
	mv_par03 := QPK->QPK_PRODUT  // Produto
	
	//Pesquisa data da medição.
	dbSelectArea("QPR")
	dbSetOrder(9)
	If dbSeek(xFilial("QPR")+QPK->QPK_OP+QPK->QPK_LOTE+QPK->QPK_NUMSER)
		mv_par11 := QPR->QPR_DTENTR
	Else
		mv_par11 := QPK->QPK_DTPROD
	EndIf
	
	mv_par09 := QPK->QPK_LOTE	 // Lote 
	mv_par10 := QPK->QPK_LOTE	 
	mv_par15 := QPK->QPK_NUMSER // Numero do Lote
	mv_par16 := nVias           // Nr. de Vias
	MV_PAR05 := cRevi           // Revisao
	MV_PAR06 := cRevi           
	MV_PAR11 := nImpEns         // Impr. Ensaio Texto (Primeira/Todas)
	MV_PAR13 := "      "        // Pedido de Venda
	MV_PAR14 := "ZZZZZZ"        // Serie
	MV_PAR07 := QPK->QPK_OP     // Ordem de Produção
	MV_PAR08 := QPK->QPK_OP
Else
	wnrel := SetPrint(cString,wnrel,cPerg,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,nTamanho)
EndIF

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| A051Imp(@lEnd,wnRel,cString,cTitulo)},ctitulo)

TRB->(dbCloseArea())

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A051Imp  ³ Autor ³ Leandro Sabino        ³ Data ³ 01.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡Æo dos Certificados                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ A050Imp(lEnd,wnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQIP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A051Imp(lEnd,wnRel,cString,cTitulo)
Local oTempTable	:= NIL
Local aAreaQPR	:={}
Local aCampos		:={}
Local aCamposAux	:={}

Local nX := 0

Local cbCont		:= 0
Local nContador	:= 1
Local CbTxt
Local cNomArq		:= ""
Local lPula      	:= .T.
Local nPosQPR    	:= 0
Local nOrdQPR		:= 0
Local nPosQQ7		:= 0
Local nOrdQQ7		:= 0
Local nPosSA1		:= 0
Local nOrdSA1		:= 0
Local nPosQP6		:= 0
Local nOrdQP6		:= 0
Local nPosSC2		:= 0
Local nOrdSC2		:= 0
Local cOrdPrd   	:= ""
Local lValido		:= .T.  
Local cOpAnt		:= ""
Local cCpoAux	:= ""

Private cProduto  	:= ""
Private lEnsaio	 	:= .F.
Private cImpLinha	:= {}
Private cImpTxt	 	:= ""
Private cData	 	:= ""
Private cOp		 	:= MV_PAR07
Private cLote	 	:= ""
Private cRoteiro 	:= ""
Private cLabor	 	:= ""
Private cOperacao	:= ""
Private cCliente 	:= MV_PAR01
Private cLoja	 	:= MV_PAR02
Private Titulo 	 	:= cTitulo
Private Cabec1 	 	:= ""
Private Cabec2	 	:= ""
Private	nomeprog 	:= "QIPR051"
Private cTamanho 	:= "M"
Private nTipo	 	:= 0
Private nJust       := 0
Private nObs        := 0
Private nResul      := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo de Trabalho - ( TRB )                  		 ³
//³ Todos os campos sao caracter ou data, por isso               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCamposAux := {	"QPR_FILIAL","QPR_PRODUT","QPR_REVI","QPR_OP","QPR_OPERAC","QPR_DTENTR",	;
"QPR_LOTE","QPR_ENSAIO","QPR_CLIENT","QPR_LOJA","QPR_NUMSER","QPR_LABOR",  ;
"QPR_DTMEDI","QPR_HRMEDI","QPR_AMOSTR","QPR_ROTEIR"}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01           // Resultados:1-Minimo/Maximo 2-Vlr.Unico ³
//³ mv_par02           // Observacao da Entrega:  1-Sim 2-Nao    ³
//³ mv_par03           // Justificativa do Laudo: 1-Sim 2-Nao    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg1,.F.)
nJust       := mv_par03
nObs        := mv_par02
nResul      := mv_par01

Pergunte(cPerg,.F.)                    

For nX := 1 To Len(aCamposAux)
	cCpoAux	:= GetSx3Cache(aCamposAux[nX], "X3_CAMPO")
	If !Empty(cCpoAux)
		AADD(aCampos,{ "TRB" + Subs(cCpoAux,4,Len(cCpoAux) - 3), GetSx3Cache(cCpoAux, "X3_TIPO"), GetSx3Cache(cCpoAux, "X3_TAMANHO"), GetSx3Cache(cCpoAux, "X3_DECIMAL") })
	EndIf
Next

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"TRB_PRODUT"} )
oTempTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Funcao para gerar arquivo de Trabalho             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GeraTrab(aCampos)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa vari vel para controlar cursor de progress„o      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRB")

If BOF() .and. EOF()
	HELP(" ",1,"RECNO")
	oTempTable:Delete()
	dbSelectArea("QPR")
	Set Filter To
	Return .T.
EndIf

m_pag  := 1

SetRegua(TRB->(LastRec()))

TRB->(dbGoTop())

While !TRB->(Eof())
	
	If !Empty(mv_par13) .And. !Empty(mv_par14)
		dbSelectArea("SC6")
		dbSetOrder(7)
		If dbSeek(xFilial("SC6")+SubStr(TRB->TRB_OP,1,8))
        	If !(SC6->C6_NUM >= mv_par13 .AND. SC6->C6_NUM <= mv_par14)
	    		TRB->(DBSkip())
		    	Loop
			EndIf
		Else
	   		TRB->(DBSkip())
	    	Loop
	    EndIf
	EndIf
	
	IF cOpAnt<>TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER .And. !Empty(cOpAnt)
		R051ImpRodape()
    EndIF

	cOpAnt:= TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER
	
	DBSelectArea("QPR")
	DBSetOrder(9)
	If DBSeek(TRB->TRB_FILIAL+TRB->TRB_OP+TRB->TRB_LOTE+TRB->TRB_NUMSER+TRB->TRB_ROTEIR+TRB->TRB_OPERAC+TRB->TRB_LABOR+TRB->TRB_ENSAIO)
		//Posicionar Registros
		
		nPosQPR  := QPR->(RecNo())
		nOrdQPR  := QPR->(IndexOrd())
		
		dbSelectArea("SC2")
		dbSetOrder(1)
		dbSeek(xFilial("SC2")+QPR->QPR_OP)
		nPosSC2  := SC2->(RecNo())
		nOrdSC2  := SC2->(IndexOrd())
		
		cRoteiro := SC2->C2_ROTEIRO   

		dbSelectArea("QPK")
		dbSetOrder(1)
		dbSeek(xFilial("QPK")+QPR->QPR_OP+QPR->QPR_LOTE)
		nPosQPK  := QPK->(RecNo())
		nOrdQPK  := QPK->(IndexOrd())		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se existe amarração Cliente x Produto               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty(cCliente) .and. !Empty(QPR->QPR_CLIENT)
			cCliente := QPK->QPK_CLIENT
			cLoja    := QPK->QPK_LOJA			
		EndIF
		
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona em Registros de outros arquivos                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("QQ7")
		dbSetOrder(1)
		dbSeek(xFilial("QQ7")+QPR->QPR_PRODUT+cCliente+cLoja)
		nPosQQ7  := QQ7->(RecNo())
		nOrdQQ7  := QQ7->(IndexOrd())
		
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+cCliente+cLoja)
		nPosSA1  := SA1->(RecNo())
		nOrdSA1  := SA1->(IndexOrd())
		
		dbSelectArea("QP6")
		dbSetOrder(1)
		dbSeek(xFilial("QP6")+QPR->QPR_PRODUT+Inverte(QPR->QPR_REVI))
		nPosQP6  := QP6->(RecNo())
		nOrdQP6  := QP6->(IndexOrd())
		
		dbSelectArea("QPL")
		dbSetOrder(3)
		If dbSeek(xFilial("QPL")+QPK->QPK_OP+QPK->QPK_LOTE+QPK->QPK_NUMSER+cRoteiro+Space(TamSX3("QPL_OPERAC")[1])+Space(TamSX3("QPL_LABOR")[1]))
			dbSelectArea("QPD")
			dbSetOrder(1)
			If dbSeek(xFilial("QPD")+QPL->QPL_LAUDO)
				If QPD->QPD_CATEG == '4'
					MessageDlg(OemToAnsi(STR0035),OemToAnsi(STR0036),2)		//'Devido o laudo estar com Libera‡Æo Urgente, nÆo ser  poss¡vel emitir o Certificado de Qualidade.'###'Aten‡Æo'
					dbSelectArea("QPR")
					RetIndex("QPR")
					dbSetOrder(1)
					Set Filter To
					If File(cNomArq+OrdBagExt())
						Ferase(cNomArq+OrdBagExt())
					EndIf
					Return .T.
				EndIf
			EndIf
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inclusao do Certificado de qualidade ao Titulo.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cTitulo += " - " +QPK->QPK_CERQUA

		If Empty(MV_PAR16)
			MV_PAR16 := 1
		EndIf
		
		SetRegua(MV_PAR16)
		
		If lValido
			For nContador := 1 To MV_PAR16
				
				IncRegua(nContador)		//Incrementar a Regua
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				//li     := 80
				
				If nContador > 1
					//Retorna a Ordem/Posicao Atual dos arquivos para  executar uma  nova  impressao do certificado
					QPR->(DbGoto(nPosQPR))
					QPR->(DbSetOrder(nOrdQPR))
					QQ7->(DbGoto(nPosQQ7))
					QQ7->(DbSetOrder(nOrdQQ7))
					SA1->(DbGoto(nPosSA1))
					SA1->(DbSetOrder(nOrdSA1))
					QP6->(DbGoto(nPosQP6))
					QP6->(DbSetOrder(nOrdQP6))
					SC2->(DbGoto(nPosSC2))
					SC2->(DbSetOrder(nOrdSC2))
					cProduto  := ""
					cOrdPrd   := ""
					cOperacao := ""
					cLabor    := ""
					lEnsaio		:=.F.
				EndIf
				
				If  cProduto <> QPR->QPR_PRODUT .OR.;	// Verifico se houve mudanca de Produto
					cOp	    <> QPR->QPR_OP     .OR.;	// Ordem de Producao
					cLote   <> QPR->QPR_LOTE			// Lote
					cCliente := QPR->QPR_CLIENT
					cLoja    := QPR->QPR_LOJA
					cProduto 	:= QP6->QP6_PRODUT
					cOp			:= QPR->QPR_OP
					cLote		:= QPR->QPR_LOTE
					cOperacao 	:= ""
					cLabor    	:= ""
					R051ImpCabecalho()
					lPula    := .T.
				EndIf
				
				aAreaQPR := GetArea()
				
				If cOperacao <> QPR->QPR_OPERAC
					dDat		:= QPR->QPR_DTENTR
					cLote		:= QPR->QPR_LOTE
					cEnsaio		:= QPR->QPR_ENSAIO
					cOperacao   := QPR->QPR_OPERAC
					cLaborat    := ""
					Li++
					@Li,01 PSAY STR0033+QPR->QPR_OPERAC+ " - "+RetDesOper(QPR->QPR_OP,cOperacao,QPR->QPR_PRODUT,QPR->QPR_REVI)		// "OPERACAO : "
				EndIf
				
				If cLaborat <> QPR->QPR_LABOR
					cLaborat := QPR->QPR_LABOR
					dbSelectArea("QP1")
					dbSetOrder(1)
					If dbSeek(xFilial("QP1")+QPR->QPR_ENSAIO)
						
						If QP1->QP1_TPCART <> "X"
							If QP7->(dbSeek(xFilial("QP7")+QPR->QPR_PRODUT+QPR->QPR_REVI+cRoteiro+QPR->QPR_OPERAC+QPR->QPR_ENSAIO))
								If QP7->QP7_CERTIF == "S"
									lPula := .F.
									cLabor:= QPR->QPR_LABOR
								EndIf
							EndIf
						Else
							If QP8->(DbSeek(xFilial()+QPR->QPR_PRODUT+QPR->QPR_REVI+cRoteiro+QPR->QPR_OPERAC+QPR->QPR_ENSAIO))
								If QP8->QP8_CERTIF == "S"
									lPula := .F.
									cLabor:= QPR->QPR_LABOR
								EndIf
							EndIf
						EndIf
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Nao imprime ensaio que esta setado para nao constar no certificado. ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If lPula
							cLabor:= " "
							DbSelectArea("QPR")
							DbSkip()
							Loop
						EndIf
						
						Li++
						@Li,01 PSAY STR0015 + QPR->QPR_LABOR		//"LABORATORIO : "
						Li++
						
						lEnsaio:= .T.
						If nResul ==1 .And. QP1->QP1_TPCART <> "X"
							@Li,082 PSAY STR0016		//"Especificado"
							@Li,114 PSAY STR0017		//"Encontrados"
						Else
							If QP1->QP1_CARTA$"XBR/XBS/XMR/IND/HIS"
								@Li,082 PSAY STR0016		//"Especificado"
								@Li,114 PSAY STR0020		//"Encontrado"
							EndIf
						EndIf
					EndIf
					
					Li++
					If lEnsaio
						@Li,001 PSAY TitSX3("QPR_ENSAIO")[1]
						@Li,047 PSAY TitSX3("QP7_METODO")[1]
						If nResul == 1 .And. QP1->QP1_TPCART <> "X"
							@Li,065 PSAY Subs(TitSX3("QP7_UNIMED")[1],1,9)
							@Li,077 PSAY STR0018		//"Minimo"
							@Li,093 PSAY STR0019		//"Maximo"
							@Li,108 PSAY STR0018		//"Minimo"
							@Li,125 PSAY STR0019		//"Maximo"
						Else
							If QP1->QP1_CARTA$"XBR/XBS/XMR/IND/HIS"
								@Li,077 PSAY STR0018		//"Minimo"
								@Li,093 PSAY STR0019		//"Maximo"
								@Li,116 PSAY STR0042        //"Media"
							Else
								@Li,078 PSAY STR0016		//"Especificado"
								@Li,114 PSAY STR0020		//"Encontrado"
							EndIf
						EndIf
						Li++
						@Li,01 PSAY Replicate("=",130)
						Li++
					EndIf
					If Li > 55
						Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo,,.F.)
					EndIf
				EndIf
				
				R051GeraRelatorio()
				
				Li++
			Next nContador
			
		EndIf
		
	EndIf
	
	TRB->(DBSkip())
	
EndDo

R051ImpRodape()

If Li != 80
	roda(CbCont,cbtxt,nTamanho)
EnDif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QPR")
RetIndex("QPR")
dbSetOrder(1)
Set Filter To

If File(cNomArq+OrdBagExt())
	Ferase(cNomArq+OrdBagExt())
EndIf

Set device to Screen

If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R051GeraRe³ Autor ³ Leandro Sabino        ³ Data ³ 01.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina que gera o corpo do relatorio                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQIP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R051GeraRelatorio()
Local nC 			:=0
Local nX 			:=0
Local nVlrMin		:=0
Local nVlrMax		:=0
Local nVlrUnic		:=0
Local nV			:=1
Local nPorcent		:=0
Local nMedia        :=0
Local nAmostra		:=0
Local lUnic			:=.T.
Local lImpTxt       :=.T.
Local dDat			:=Ctod("  /  /  ")
Local cTxtRes		:=""
Local cTxt			:=""
Local cLaborat		:=""
Local cEnsaio		:=""
Local aTxtRes		:={}
Local aTexto		:={}
Local cChave		:=""

dbSelectArea("QP1")
dbSetOrder(1)
dbSeek(xFilial("QP1")+QPR->QPR_ENSAIO)
If QP1->QP1_TPCART <> "X"
	dbSelectArea("QP7")
	dbSetOrder(1)
	If dbSeek(xFilial("QP7")+QPR->QPR_PRODUT+QPR->QPR_REVI+cRoteiro+QPR->QPR_OPERAC+QPR->QPR_ENSAIO)
		If QP7->QP7_CERTIF == "S"
			@Li,01 PSAY QP1->QP1_DESCPO
			@Li,47 PSAY QP7->QP7_METODO
			If nResul = 1
				SAH->(dbSeek(xFilial("SAH")+QP7->QP7_UNIMED))
				@Li,65 PSAY SAH->AH_UMRES
				If QP7_MINMAX == "1"
					@Li,78 PSAY QP7->QP7_LIE
					@Li,93 PSAY QP7->QP7_LSE
				ElseIf QP7_MINMAX == "2"
					@Li,78 PSAY QP7->QP7_LIE
					@Li,93 PSAY ">>>"
				ElseIf QP7_MINMAX == "3"
					@Li,78 PSAY "<<<"
					@Li,93 PSAY QP7->QP7_LSE
				EndIf
			ElseIf QP1->QP1_CARTA$"XBR/XBS/XMR/IND/HIS"
				@Li,78 PSAY QP7->QP7_LIE
				@Li,93 PSAY QP7->QP7_LSE
			Else
				@ li,65 PSAY Padc(AllTrim(QP7->QP7_NOMINA), 38)
			Endif
			lEnsaio := .T.
		Else
			lEnsaio	:= .F.
		EndIf
	EndIf
Else
	dbSelectArea("QP8")
	dbSetOrder(1)
	If dbSeek(xFilial()+QPR->QPR_PRODUT+QPR->QPR_REVI+cRoteiro+QPR->QPR_OPERAC+QPR->QPR_ENSAIO)
		If QP8->QP8_CERTIF == "S"
			@Li,01 PSAY QP1->QP1_DESCPO
			@Li,47 PSAY QP8->QP8_METODO
		Else
			lEnsaio	:= .F.
		EndIf
	EndIf
EndIf

If Li > 55
	Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo,,.F.)
EndIf


cProduto	:= QPR->QPR_PRODUT
cRevi		:= QPR->QPR_REVI
dDat		:= QPR->QPR_DTENTR
cLote		:= QPR->QPR_LOTE
cLaborat	:= QPR->QPR_LABOR
cEnsaio		:= QPR->QPR_ENSAIO
cOp			:= QPR->QPR_OP
dbSelectArea("QPR")
dbSetOrder(6)
If dbSeek(xFilial("QPR")+cProduto+cRevi+dTos(dDat)+cLote+cOperacao+cLaborat)
	lImpTxt  := .T.
	nVlrUnic := ""
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Defini‡Æo das vari veis para impressÆo:                            ³
	//³Cartas:XBR,XBS,XMR,IND,HIS,C,NP,U,P : nVlrMin,nVlrMax,nVlrUnic     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !Eof() .And. xFilial("QPR") == QPR->QPR_FILIAL .And.;
		cProduto	== QPR->QPR_PRODUT	.And.	cRevi		== QPR->QPR_REVI .And.;
		dDat		== QPR->QPR_DTENTR	.And.	cLote		== QPR->QPR_LOTE .And.;
		cLaborat	== QPR->QPR_LABOR	.And. 	cOperacao	== QPR->QPR_OPERAC
		
		If cEnsaio	<> QPR->QPR_ENSAIO
			dbSkip()
			Loop
		EndIf
		
		If lEnsaio
			If li > 55
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo,,.F.)
			EndIf
			
			IncRegua()
			
			cChave:= QPR->QPR_CHAVE
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Os tipos de cartas:XBR|XBS|XMR|IND|HIS - Se o param. for "Minimo/  ³
			//³Maximo"-ira considerar o menor e o maior valor. Se o param. for    ³
			//³"Valor Unico-Ser  o maior valor encontrado ou menor fora da espec. ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If QP1->QP1_TPCART <> "X"
				If QP1->QP1_CARTA$"XBR/XBS/XMR/IND/HIS"
					dbSelectArea("QPS")
					dbSetOrder(1)
					If dbSeek(xFilial("QPS")+cChave)
						While !Eof() .And. 	QPS_FILIAL == xFilial("QPS") .And. ;
							QPS_CODMED == cChave
							
							nVlrMin:=IIF(SuperVal(QPS_MEDICA)<SuperVal(nVlrMin) .Or. ;
							SuperVal(nVlrMin)==0,QPS->QPS_MEDICA,nVlrMin)
							nVlrMax:=IIF(SuperVal(QPS_MEDICA)>SuperVal(nVlrMax),QPS->QPS_MEDICA,nVlrMax)
							
							If nResul == 2 // Valor Unico
								nVlrUnic := Alltrim(Str(SuperVal(nVlrUnic) + SuperVal(QPS->QPS_MEDICA)))
								nMedia ++
							EndIf
							
							dbSkip()
						EndDo
					EndIf
					
				ElseIf QP1->QP1_CARTA$"C  /NP "
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Os tipos de carta : C / NP -Se o param. for "Minimo/Maximo", o Mi- ³
					//³nimo ser  0, o M ximo ser  o maior valor da 1a. medicao do QPS p/  ³
					//³cada data/hora. Sempre existem 1 medi‡Æo para cada data/hora.      ³
					//³Se param. for "Valor Unico" - Ser  o maior valor do QPS.           ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("QPS")
					dbSetOrder(1)
					If dbSeek(xFilial("QPS")+cChave)
						While !Eof() .And. 	QPS_FILIAL == xFilial("QPS") .And. ;
							QPS_CODMED == cChave
							
							nVlrMax:=IIF(SuperVal(QPS_MEDICA)>SuperVal(nVlrMax),QPS_MEDICA,nVlrMax)
							
							dbSkip()
						EndDo
						If nResul == 2 // Valor Unico
							If SuperVal(nVlrMax) > SuperVal(QP7->QP7_LSE) .Or. SuperVal(nVlrUnic) == 0
								nVlrUnic:= nVlrMax
							EndIf
						EndIf
					EndIf
					
				ElseIf AllTrim(QP1->QP1_CARTA)=="U"
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³O  tipo  de carta : U      -Se o param. for "Minimo/Maximo", o Mi- ³
					//³nimo ser  0, o M ximo ser  o maior valor da 2a. medicao do QPS p/  ³
					//³cada data/hora. Sempre existem 2 regs. medi‡äes para cada data/hora³
					//³Se param. for "Valor Unico" - Ser  a 2a. medi‡Æo do QPS para a 1a. ³
					//³data/hora.                                                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("QPS")
					dbSetOrder(1)
					If dbSeek(xFilial("QPS")+cChave)
						While !Eof() .And. 	QPS_FILIAL == xFilial("QPS") .And. ;
							QPS_CODMED == cChave
							If nV == 2
								nVlrMax:=IIF(SuperVal(QPS_MEDICA)>SuperVal(nVlrMax),QPS_MEDICA,nVlrMax)
								nV:=0
								If nResul == 2 .And. lUnic
									nVlrUnic := QPS_MEDICA
									lUnic:= .F.
								EndIf
							EndIf
							nV++
							dbSkip()
						EndDo
					EndIf
					
				ElseIf AllTrim(QP1->QP1_CARTA)=="P"
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³O  tipo  de carta : P      -Se o param. for "Minimo/Maximo", o Mi- ³
					//³nimo ser  0, o M ximo ser  o maior valor de :                      ³
					//³Amostra * (Porcent./100)                                           ³
					//³Se param. for "Valor Unico" - Ser  o maior valor da Amostra:       ³
					//³Amostra * (Porcent./100)                                           ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("QPS")
					dbSetOrder(1)
					If dbSeek(xFilial("QPS")+cChave)
						While !Eof() .And. 	QPS_FILIAL == xFilial("QPS") .And. ;
							QPS_CODMED == cChave
							
							If QPS_INDMED == "A"
								nAmostra := QPS_MEDICA
							ElseIf QPS_INDMED == "P"
								nPorcent := QPS_MEDICA
							EndIf
							If !Empty(nAmostra) .And. !Empty(nPorcent)
								nVlrMax:= IIF(SuperVal(nAmostra) * (SuperVal(nPorcent) / 100 ) > SuperVal(nVlrMax),SuperVal(nAmostra) * (SuperVal(nPorcent) / 100 ),nVlrMax)
								nAmostra:= ""
								nPorcent:= ""
								If nResul == 2 // Valor Unico
									nVlrUnic:= Str(nVlrMax)
								EndIf
							EndIf
							dbSkip()
						EndDo
					EndIf
				EndIf
			Else

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³O tipo de Carta:TXT ir  o 1o. resultado encontrado ou Todas Med. ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If (Len(aTexto) == 0 .And. Len(aTxtRes) == 0) .Or. MV_PAR17 == 2
					
					If Len(aTexto) == 0
						cTxt := QP8->QP8_TEXTO
						While ! Empty(cTxt)
							Aadd(aTexto, Left(cTxt, 38))
							cTxt := Subs(cTxt, 39, Len(cTxt))
						EndDo
					EndIf
					
					If Len(aTxtRes) == 0
						dbSelectArea("QPQ")
						dbSetOrder(1)
						dbSeek(xFilial()+cChave)
						cTxtRes:= QPQ_MEDICA
						nX:=0
						
						While ! Empty(cTxtRes)
							Aadd(aTxtRes, Left(cTxtRes, 27))
							cTxtRes := Subs(cTxtRes, 28, Len(cTxtRes))
						EndDo
					EndIf
					
					nTot:= IIF(Len(aTexto)>Len(aTxtRes),Len(aTexto),Len(aTxtRes))
					
					For nC := 1 to nTot
						If lImpTxT
							If Len(aTexto) >= nC
								If	!Empty(aTexto[nC])
									@Li,065 PSAY Alltrim(aTexto[nC])
								EndIf
							EndIf
						EndIf
						If  Len(aTxtRes) >= nC
							If	!Empty(aTxtRes[nC])
								@Li,104 PSAY AllTrim(aTxtRes[nC])
							EndIf
						EndIf
						If Li > 55
							Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo,,.F.)
						EndIf
						Li++
					Next nC
					lImpTxt:= .F.
					aTxtRes:= {}
				EndIf
			EndIf
			If Li > 55
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo,,.F.)
			EndIf
		EndIf
		dbSelectArea("QPR")
		dbSkip()
	EndDo
EndIf

If QP1->QP1_CARTA$"XBR/XBS/XMR/IND/HIS" .and. nResul == 2 // Valor Unico
	nVlrUnic := Alltrim(Str(SuperVal(nVlrUnic) /nMedia))
EndIF

If lEnsaio
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Faz impressÆo de todas as cartas                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If QP1->QP1_TPCART <> "X"
		If QP1->QP1_CARTA$"XBR/XBS/XMR/IND/HIS"
			If nResul == 1
				@Li,113-Len(AllTrim(nVlrMin)) PSAY AllTrim(nVlrMin)
				@Li,130-Len(AllTrim(nVlrMax)) PSAY AllTrim(nVlrMax)
			Else
				@Li,104 PSAY Padc(AllTrim(nVlrUnic), 27)
			EndIf
			
		ElseIf AllTrim(QP1->QP1_CARTA)$"C/NP/U/P"
			If nResul == 1
				@Li,113 PSAY "0"
				If ValType(nVlrMax) = "N"
					@Li,130-Len(AllTrim(Str(nVlrMax))) PSAY AllTrim(Str(nVlrMax))
				Else
					@Li,130-Len(AllTrim(nVlrMax)) PSAY AllTrim(nVlrMax)
				EndIf
			Else
				@Li,104 PSAY Padc(AllTrim(nVlrUnic), 27)
			EndIf
		EndIf
	EndIf
	
	If QP1->QP1_TPCART == "X"
		aTexto:={}
		aTxtRes:={}
	Else
		nVlrMin :=0
		nVlrMax :=0
		nVlrUnic:=""
		lUnic   :=.T.
		nMedia  :=0
		Li++
	EndIf
EndIf
Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R051ImpCab³ Autor ³ Leandro Sabino        ³ Data ³ 01.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina que imprime o cabecalho do relatorio                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQIP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R051ImpCabecalho()
Local aMeses		:={STR0021,STR0022,STR0023,STR0024,STR0025,STR0026,STR0027,STR0028,STR0029,STR0030,STR0031,STR0032}	//"Janeiro"###"Fevereiro"###"Marco"###"Abril"###"Maio"###"Junho"###"Julho"###"Agosto"###"Setembro"###"Outubro"###"Novembro"###"Dezembro"
Local cAcentos		:="€ú‡úú"+chr(65533)+"ú…ú†úƒú ú"+chr(65533)+"úˆú‚ú¡ú“ú”ú¢ú™ú£ú",cAcSubst := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"
Local aLinha		:={}
Local cArqTxt		:=""
Local cTexto		:=""
Local nCount 		:= 0
Local nC			:= 0

cOperacao := ""
cLabor    := ""
lEnsaio	  :=.F.
m_pag := 1

Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo,,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Cabecalho ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cData := AllTrim(SM0->M0_CIDENT)+","+ Str(day(dDataBase)) + STR0014 + aMeses[month(dDataBase)] + STR0014 + StrZero(year(dDataBase),4)		//" de "###" de "
@ Li,132-Len(cData) PSAY cData
Li++
@Li,01 PSAY AllTrim(TitSX3("QPR_PRODUT")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QPR_PRODUT")[1])))+":"
@Li,27 PSAY AllTrim(QPR->QPR_PRODUT)+" - "+AllTrim(QP6->QP6_DESCPO) +" - "+QPR->QPR_REVI
Li++
@Li,01 PSAY AllTrim(TitSX3("A7_CLIENTE")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A7_CLIENTE")[1])))+":"
@Li,27 PSAY AllTrim(cCliente)+"/"+cLoja+" - "+SA1->A1_NOME
Li++
@Li,01 PSAY "Data da Producao"+Replicate(".",23-Len("Data da Producao"))+":"
@Li,27 PSAY QPR->QPR_DTENTR
@Li,52 PSAY AllTrim(TitSX3("QPR_LOTE")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QPR_LOTE")[1])))+":"
@Li,75 PSAY QPR->QPR_LOTE
If !Empty(QPR->QPR_NUMSER)
	@Li,94  PSAY AllTrim(TitSX3("QPR_NUMSER")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QPR_NUMSER")[1])))+":"
	@Li,115 PSAY QPR->QPR_NUMSER
EndIF

If !Empty(MV_PAR13) .or. !Empty(MV_PAR14)
	@Li,97 PSAY STR0040+Replicate(".",19-Len(STR0040))+":"
	@Li,120 PSAY MV_PAR13
EndIf

Li++
@Li,01 PSAY AllTrim(TitSX3("QPR_OP")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QPR_OP")[1])))+":"
@Li,27 PSAY QPR->QPR_OP
@Li,52 PSAY AllTrim(TitSX3("QEK_TAMLOT")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QEK_TAMLOT")[1])))+":"
SAH->(dbSeek(xFilial("SAH")+QPK->QPK_UM))
@Li,75 PSAY Alltrim(str(QPK->QPK_TAMLOT))+" "+SAH->AH_UMRES
If !Empty(MV_PAR13) .or. !Empty(MV_PAR14)
	@Li,97 PSAY STR0041+Replicate(".",19-Len(STR0041))+":"
	@Li,120 PSAY MV_PAR13
EndIf
Li+=2

cChave := QQ7->QQ7_CHAVE

If nObs == 1
	dbSelectArea("QA2")
	dbSetOrder(1)
	If dbSeek(xFilial("QA2")+"QIPA070 "+cChave)
		@Li,01 PSAY "OBS.: "
		While !Eof() .And. xFilial("QA2") == QA2->QA2_FILIAL .And. QA2->QA2_CHAVE == cChave
			If Li > 55
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			Endif
			@Li,08 PSAY StrTran(QA2_TEXTO, "\13\10", "")
			Li++
			dbSkip()
		EndDo
	EndIf
	Li++
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo do Texto superior                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cArqTxt := "QPR0511"+".TXT"
If File(cArqTxt)
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ""
		cImpLinha := ""
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
		@Li,01 PSAY cImpLinha
		Li++
	Next nC
EndIf
Li++

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo dos Ensaios especificado com Encontrado           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRevi		:= QPR->QPR_REVI

Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R051ImpRod³ Autor ³ Leandro Sabino        ³ Data ³ 01.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina que imprime o rodape do relatorio                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQIP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R051ImpRodape()
Local cAcentos		:="€ú‡úú"+chr(65533)+"ú…ú†úƒú ú"+chr(65533)+"úˆú‚ú¡ú“ú”ú¢ú™ú£ú",cAcSubst := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"
Local nCount := 0
Local nC     := 0

lEnsaio := .T.	//Flag para impressao dos ensaios

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Laudo da Ordem de Producao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QPL")
dbSetOrder(2)
If dbSeek(xFilial("QPL")+cOP+cLote)
	dbSelectArea("QPD")
	dbSetOrder(1)
	dbSeek(xFilial("QPD")+QPL->QPL_LAUDO)
	Li+=2
	@Li,01 PSAY AllTrim(TitSX3("QPL_LAUDO")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPL_LAUDO")[1])))+": "+QPD_DESCPO
	Li++
	@Li,01 PSAY AllTrim(TitSX3("QPL_DTLAUD")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPL_DTLAUD")[1])))+": "+Dtoc(QPL->QPL_DTLAUD)
	Li++
	If !Empty(QPL->QPL_QTREJ)
		SAH->(dbSeek(xFilial("SAH")+QPK->QPK_UM))
		@Li,01 PSAY AllTrim(TitSX3("QPL_QTREJ")[1])+;
		Replicate(".",15-Len(AllTrim(TitSX3("QPL_QTREJ")[1])))+": "+;
		QPL->QPL_QTREJ+" "+SAH->AH_UMRES
		Li++
	EndIf
	If nJust == 1
		@Li,01 PSAY AllTrim(TitSX3("QPL_JUSTLA")[1])+Replicate(".",15-Len(AllTrim(TitSX3("QPL_JUSTLA")[1])))+": "+QPL->QPL_JUSTLA
		Li++
	EndIf
EndIf

Li+=2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo das Informa‡äes Complementares   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTxt := "QPR0513"+".TXT"
If File(cArqTxt)
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ""
		cImpLinha := ""
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
		@Li,01 PSAY cImpLinha
		Li++
		If Li > 55
			Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo,,.F.)
		EndIf
	Next nC
EndIf

Li+=2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo do Texto inferior                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTxt := "QPR0512"+".TXT"
If File(cArqTxt)
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ""
		cImpLinha := ""
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
		@Li,01 PSAY cImpLinha
		Li++
		If Li > 55
			Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo,,.F.)
		EndIf
	Next nC
EndIf
Li++

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTrab  ³ Autor ³ Leandro Sabino        ³ Data ³ 01.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo de Trabalho                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GeraTrab()                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GeraTrab(aCampos)

Local cKey		:= ""
Local cNomArq	:= ""
Local cCond		:= ''
Local cAnt  	:= ''
dbSelectArea("QPR")
dbSetOrder(1)

If !Empty(dbFilter())
	cCond	:= dbFilter()
Endif

If !Empty(AllTrim(mv_par01))
	If !Empty(AllTrim(cCond))
		cCond	+= '.And.'
	EndIf
	cCond	+= 'QPR_CLIENT =="'+mv_par01+'" .And.QPR_LOJA =="'+mv_par02+'"'
EndIf
If !Empty(AllTrim(mv_par04))
	If !Empty(AllTrim(cCond))
		cCond	+= '.And.'
	EndIf
	cCond	+= 'QPR_PRODUT>="'+mv_par03+'" .And.QPR_PRODUT<="'+mv_par04+'"'
EndIf
If !Empty(AllTrim(mv_par06))
	If !Empty(AllTrim(cCond))
		cCond	+= '.And.'
	EndIf
	cCond	+= 'QPR_REVI>="'+mv_par05+'" .And.QPR_REVI<="'+mv_par06+'"'	
EndIf
If !Empty(AllTrim(mv_par08))
	If !Empty(AllTrim(cCond))
		cCond	+= '.And.'
	EndIf
	cCond	+= 'QPR_OP>="'+mv_par07+'" .And.QPR_OP<="'+mv_par08+'"'
EndIf
If !Empty(AllTrim(mv_par10))
	If !Empty(AllTrim(cCond))
		cCond	+= '.And.'
	EndIf                                                          
	cCond	+= 'QPR_LOTE>="'+mv_par09+'" .And.QPR_LOTE<="'+mv_par10+'"'
EndIf
If !Empty(mv_par12)
	If !Empty(AllTrim(cCond))
		cCond	+= '.And.'
	EndIf
	cCond	+= 'DTOS(QPR_DTENTR)>="'+DTOS(mv_par11)+'".And.DTOS(QPR_DTENTR)<="'+DTOS(mv_par12)+'"'
EndIf
If !Empty(mv_par15)
	If !Empty(AllTrim(cCond))
		cCond	+= '.And.'
	EndIf
	cCond	+= 'QPR_NUMSER>="'+mv_par15+'"'
EndIf

cKey	:= IndexKey()
cNomArq	:= CriaTrab(NIL,.F.)
IndRegua("QPR",cNomArq,cKey,,cCond,STR0016)		//"Selecionando Registros..."

SetRegua(RecCount())
QPR->(dbGoTop())

cAnt := ""

While QPR->(!Eof())
	
	If cAnt != QPR->QPR_FILIAL+QPR->QPR_OP+QPR_LOTE+QPR->QPR_OPERAC+QPR->QPR_LABOR+QPR->QPR_ENSAIO
		
		RecLock("TRB",.T.)
		
		TRB_FILIAL	:= QPR->QPR_FILIAL
		TRB_PRODUT	:= QPR->QPR_PRODUT
		TRB_REVI	:= QPR->QPR_REVI
		TRB_OP		:= QPR->QPR_OP
		TRB_OPERAC	:= QPR->QPR_OPERAC
		TRB_DTENTR	:= QPR->QPR_DTENTR
		TRB_LOTE	:= QPR->QPR_LOTE
		TRB_ENSAIO	:= QPR->QPR_ENSAIO
		TRB_CLIENT  := QPR->QPR_CLIENT
		TRB_LOJA    := QPR->QPR_LOJA
		TRB_NUMSER  := QPR->QPR_NUMSER
		TRB_CLIENT	:= QPR->QPR_CLIENT
		TRB_LOJA 	:= QPR->QPR_LOJA
		TRB_LABOR	:= QPR->QPR_LABOR
		TRB_DTMEDI	:= QPR->QPR_DTMEDI
		TRB_HRMEDI	:= QPR->QPR_HRMEDI
		TRB_AMOSTR	:= QPR->QPR_AMOSTR     
		TRB_ROTEIR	:= QPR->QPR_ROTEIR     
		
		MsUnLock()
		
		cAnt := QPR->QPR_FILIAL+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_OPERAC+QPR->QPR_LABOR+QPR->QPR_ENSAIO
	EndIf
	
	QPR->(dbSkip())
EndDo

dbSelectArea("QPR")
FErase(cNomArq+OrdBagExt())
dbSetOrder(1) 

Return .T.