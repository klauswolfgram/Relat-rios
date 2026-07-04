/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'QIPR150.CH'
#Include 'PROTHEUS.Ch'
#Include "REPORT.Ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIPR150  ³ Autor ³     Marcelo Pimentel  ³ Data ³ 18.10.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Notifica‡„o de n„o conformidade.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQIP                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 				      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo Pim.³26/03/01³------³Inclusao da impressao grafica no relatorio³±±
±±³Marcelo Pim.³21/08/02³------³Melhoria na apresentacao da Tela de Para- ³±±
±±³            ³        ³      ³metros.                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QiPR150()
Local oDlgGet                           
Local oListBox
Local aArea		:= {Alias(),IndexOrd(),Recno()}
Local nItem		:= 0

Private	cPerg	:= 'QPR150'
Private	cPerg1	:= 'QPR151'
Private lEnd	:=.F.
Private lEdit	:= .t.	// Para editar os textos
Private aListBox:= {}

Private nJustif		:= 0		//Parametro Justificativa 	  - QPR151 01 
Private nCronica	:= 0		//Parametro Cronica			  - QPR151 02
Private nSegParte	:= 0		//Parametro 2a. Parte		  - QPR151 03
Private nMedicoes	:= 0		//Parametro Medicoes		  - QPR151 04
Private nFatZero	:= 0		//Parametro Impressao Fator 0 - QPR151 05
Private  __cPRODUTO := CriaVar("QP6_PRODUT") //Codigo do Produto, quando a Especificacao for em Grupo      
Private lProduto    := .F.
Private lFase3      := IIF(QP6->(FieldPos("QP6_SITREV"))<>0,.T.,.F.)

AADD(aListBox,OemToAnsi(STR0003))	//'Texto Superior Capa '
AADD(aListBox,OemToAnsi(STR0004))	//'Texto Inferior Capa '
AADD(aListBox,OemToAnsi(STR0005))	//'Justificativas '
AADD(aListBox,OemToAnsi(STR0006))	//'Instrucoes - Digitacao'
AADD(aListBox,OemToAnsi(STR0007))	//'Texto Analise Interna '
AADD(aListBox,OemToAnsi(STR0008))	//'Impressao'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa ListBox com opcoes para o array da configuracao          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlgGet TITLE OemtoAnsi(STR0001) FROM 0,0 TO 217,297 OF oMainWnd  PIXEL  //"Notifica‡„o de N„o Conformidade"
@ 01,05 SAY Oemtoansi(STR0041) SIZE 100, 07 OF oDlgGet PIXEL //"Itens de Configurac„o"
@ 10,05 LISTBOX oListBox VAR nItem ITEMS aListBox  ON DBLCLICK Iif(nItem<=5,R150TEXT(nItem),Pergunte(cPerg1,.T.)) SIZE 110,90 PIXEL OF oDlgGet
DEFINE SBUTTON FROM 10, 120 TYPE 6 ACTION (oDlgGet:End(),R150IMP()) ENABLE OF oDlgGet
DEFINE SBUTTON FROM 26, 120 TYPE 2  ACTION (oDlgGet:End()) ENABLE OF oDlgGet

ACTIVATE MSDIALOG oDlgGet CENTERED
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura area                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(aArea[1]);dbSetOrder(aArea[2]);dbGoto(aArea[3])
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R150Text    ³Autor³ Marcelo Pimentel      ³ Data ³ 18.10.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Tela para preenchimento do conteudo relacionado com o ³±±
±±³          ³ListBox.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIPR150                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R150Text(nItem)
Local cTexto := ''
Local oFontMet   := TFont():New('Courier New',6,0)
Local oDlgGet2,oTexto
Local oFontDialog:= TFont():New('Arial',6,15,,.T.)

cNomeArq := 'X'

nHdl:=MSFCREATE(cNomeArq,0)
If nHdl <= -1
	HELP(' ',1,'NODIRCQ')
	Return .T.
Else
	If File(cNomeArq)
		FCLOSE(nHdl)
		FERASE(cNomeArq)
	Endif
Endif

cNomeArq := 'QPR150'+Str(nItem+1,1)+'.TXT'

While .T.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Le arquivo                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTexto:=MemoRead(cNomeArq)

	DEFINE MSDIALOG oDlgGet2 FROM	62,100 TO 345,610 TITLE  OemToAnsi(STR0041) PIXEL FONT oFontDialog		//'Itens de Configura‡Æo'
	@ 003, 004 TO 027, 250 LABEL '' 	OF oDlgGet2 PIXEL
	@ 040, 004 TO 110, 250				OF oDlgGet2 PIXEL
	@ 013, 010 MSGET aListBox[nItem]	WHEN .F. SIZE 235, 010 OF oDlgGet2 PIXEL
	@ 050, 010 GET oTexto VAR cTexto MEMO NO VSCROLL WHEN lEdit SIZE 235, 051 OF oDlgGet2 PIXEL
	oTexto:oFont := oFontMet
	DEFINE SBUTTON FROM 120,190 TYPE 1 ACTION (MemoWrit( cNomeArq,cTexto ),oDlgGet2:End()) ENABLE OF oDlgGet2
	DEFINE SBUTTON FROM 120,220 TYPE 2 ACTION oDlgGet2:End() ENABLE OF oDlgGet2
	ACTIVATE MSDIALOG oDlgGet2 CENTERED
	Exit
EndDo
Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R150IMP  ³ Autor ³ Marcelo Pimentel      ³ Data ³ 18/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ficha de entrega de produtos                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R150IMP()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQIP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R150IMP()

Local oReport	
Private cAliasQEK  :="QPK"

If TRepInUse()   
	Pergunte(cPerg,.F.)
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	R150IMPR3()
EndIf   

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ReportDef  ºAutor  ³Cleber Souza        º Data ³  07/17/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicoes do relatorio de Formulas R4.		              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIPR150                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()

Local cPrograma  :='QIPR150'
LOCAL cDesc1	 :=STR0011	//'Neste relatorio sera impresso a Notificacao de Nao Conformidade.'
Local cTitulo    :=	OemToAnsi(STR0012)  //'Notificacao De Nao Conformidade' 

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)

DEFINE SECTION oSection1 OF oReport TITLE STR0045//Data 
DEFINE CELL NAME "cAbre"     OF oSection1  TITLE " " SIZE 0  

DEFINE SECTION oSection2 OF oReport TITLE TitSX3('QP7_ENSAIO')[1] TABLES "QPR"//Ensaio
DEFINE CELL NAME "cEnsaio"        OF oSection2  TITLE TitSX3('QP7_ENSAIO')[1]           	SIZE TamSX3("QP7_DESENS")[1]  
DEFINE CELL NAME "cNum"           OF oSection2  TITLE " "									SIZE 6  
DEFINE CELL NAME "cLIE"           OF oSection2  TITLE AllTrim(TitSX3('QP7_LIE')[1])  		AUTO SIZE
DEFINE CELL NAME "cLSE"           OF oSection2  TITLE AllTrim(TitSX3('QP7_LSE')[1])  		AUTO SIZE
DEFINE CELL NAME "cUNIMED"        OF oSection2  TITLE Subs(TitSX3('QP7_UNIMED')[1],1,10)   AUTO SIZE
DEFINE CELL NAME "cResultados"    OF oSection2  TITLE STR0028								SIZE 60 //'Resultados'             

DEFINE SECTION oSection3 OF oReport TITLE STR0028 //'Resultados'
DEFINE CELL NAME "cEnsaio"        OF oSection3  TITLE TitSX3('QP7_ENSAIO')[1]       	    AUTO SIZE   
DEFINE CELL NAME "cNum"           OF oSection3  											SIZE 6
DEFINE CELL NAME "cEspecificado"  OF oSection3  TITLE STR0044								SIZE 50 //'Especificado'  
DEFINE CELL NAME "cResultados"    OF oSection3  TITLE STR0028								SIZE 50 //'Resultados'  

DEFINE SECTION oSection4 OF oReport TITLE STR0046 //"Nao Conformidade"
DEFINE CELL NAME "cNaoConf"       OF oSection4  TITLE STR0031								SIZE TamSX3("QPU_DESNCO")[1] //'Nao Conformidade(s) encontrada(s)'             
DEFINE CELL NAME "cNumero"     	  OF oSection4  TITLE STR0032								SIZE 6   //'No.'
DEFINE CELL NAME "cClasse"        OF oSection4  TITLE STR0033								SIZE 20 //'Classe'
DEFINE CELL NAME "cFator"	      OF oSection4  TITLE STR0034								SIZE 20 //'Fator Criticidade'
DEFINE CELL NAME "cReincid"       OF oSection4  TITLE STR0035						   		SIZE 20 //'Reincidencia'

Return oReport   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReport ºAutor  ³Cleber Souza      º Data ³  07/21/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Impressao do relatorio de Nao conformidades R4            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIPR150                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
Local oSection1 :=oReport:Section(1)
Local oSection2 :=oReport:Section(2)  
Local oSection3 :=oReport:Section(3)  
Local oSection4 :=oReport:Section(4)  
Local aLinha	:= {},cImpTxt:= '',cImpLinha := '',cTexto:= ''
Local cArqTxt	:= '',cData:= '',lImpNNC := .T.,nConf,nContNNC:= 0
Local cAcentos  := '€ú‡úú'+chr(65533)+'ú…ú†úƒú ú'+chr(65533)+'úˆú‚ú¡ú“ú”ú¢ú™ú£ú'
Local cAcSubst  := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"
Local aMeses	:= {STR0015,STR0016,STR0017,STR0018,STR0019,STR0020,STR0021,STR0022,STR0023,STR0024,STR0025,STR0026}		//'Janeiro'###'Fevereiro'###'Marco'###'Abril'###'Maio'###'Junho'###'Julho'###'Agosto'###'Setembro'###'Outubro'###'Novembro'###'Dezembro'
Local aTxt		:= {},nCont:= 0,cTxt:= ''
Local cNNC		:= ''                                        
Local cResult   := ""
Local nOrdQPR	:= QPR->(IndexOrd())
Local nOrdQPL	:= QPL->(IndexOrd())
Local aAreaQPR	:= NIL
Local nAux		:= 0
Local nCount    := 0
Local nC        := 0
Local nT        := 0
Local nA        := 0
Local nP        := 0

Private cChave := ''

Pergunte(cPerg1,.F.)
nJustif		:= mv_par01		//Parametro Justificativa 	  - QPR151 01 
nCronica	:= mv_par02		//Parametro Cronica			  - QPR151 02
nSegParte	:= mv_par03		//Parametro 2a. Parte		  - QPR151 03
nMedicoes	:= mv_par04		//Parametro Medicoes		  - QPR151 04
nFatZero	:= mv_par05		//Parametro Impressao Fator 0 - QPR151 05

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a producao existe³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPR')
dbSetOrder(6)
IF !dbSeek(xFilial('QPR')+mv_par01+mv_par02+Dtos(mv_par03)+mv_par04)
	Set Device to Screen
	Help(' ',1,'QP_NAOPROD')	// 'Producao nao cadastrada.'
	dbSelectArea('QPR')
	dbSetOrder(nOrdQPR)
	Return
EndIf

aAreaQPR := {Alias(),IndexOrd(),Recno()}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona em registros de outros Arquivos 					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QP6')
dbSetOrder(1)
dbSeek(xFilial('QP6')+QPR->QPR_PRODUT+Inverte(QPR->QPR_REVI))  

dbSelectArea('SC2')
dbSetOrder(1)
dbSeek(xFilial('SC2')+QPR->QPR_OP)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a entrega tem laudo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPL')
dbSetOrder(3)
If !dbSeek(xFilial('QPL' )+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER+SC2->C2_ROTEIRO+Space(TamSX3('QPL_OPERAC')[1])+Space(TamSX3('QPL_LABOR' )[1]))
	MessageDlg(STR0043,,13)		//'Produ‡Æo nÆo tem Laudo.'
	dbSetOrder(nOrdQPL)
	Return
EndIf

dbSelectArea('QP7')
dbSetOrder(1)

dbSelectArea('QPK')
dbSetOrder(1)
dbSeek(xFilial('QPK')+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da funcao onde armazenar  array's com NConformidades.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aEnsaio := {}
Private nEns	:= 1
Private aNConf	:= {}
Private aResTXT	:= {}
Private aResult	:= {}
R150NNC(.T., oReport)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Flag para verificar se ir  imprimir as Nao Conformidades en- ³
//³ contradas de acordo c/o paramentro:Imprime NC com Fator 0    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nFatZero == 2
	If Len(aNConf) > 0
		For nConf:= 1 to Len(aNConf)
			If AllTrim(aNConf[nConf,6]) == '0'
				lImpNNC	:= .F.
				nContNNC++
			EndIf
		Next nConf
	Else
		lImpNNC := .F.
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao tiver NC associada nao serah impresso.                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aNConf) == 0
	Set Device to Screen
	Help(' ',1,'Q_PRDNAONC')	// 'Produc„o n„o apresenta N„o Conformidades.'
	dbSelectArea('QPR')
	dbSetOrder(1)
	Return
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se o parametro Imprime NC com Fator 0 == Nao e o fator de to-³
//³ das as nao conformidades estiver com 0, nao ser  impresso.   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nFatZero == 2 .and. nContNNC == Len(aNConf)
	If !lImpNNC .And. GetMv('MV_ESNC') == 'N'
		Set Device to Screen
		Help(' ',1,'Q_PRDNAONC')	// 'Produc„o n„o apresenta N„o Conformidades.'
		dbSelectArea('QPR')
		dbSetOrder(1)
		Return
	Endif
EndIf

Begin Transaction
If Empty(QPK->QPK_CERQUA)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Faz a gera‡Æo autom tica do c¢digo da Notif.de NÆo Conformid. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNNC := QA_SEQUSX6('QIP_NNCO',TamSX3('QPK_CERQUA')[1],"S",OemToAnsi(STR0027)) 	//'Notifica‡„o N„o Conformidade'
	
	RecLock('QPK',.F.)
	QPK->QPK_CERQUA	:= cNNC
	MsUnlock()
Else
	cNNC := QPK->QPK_CERQUA
EndIf
End Transaction 


// SM0: Campos do arquivo SIGAMAT.EMP      
cData := AllTrim(SM0->M0_CIDENT)+','+ Alltrim(Str(day(dDataBase))) + STR0042 + aMeses[month(dDataBase)] + STR0042 + StrZero(year(dDataBase),4)	//' de '###' de '
oSection1:Init()
oSection1:PrintLine()
oSection1:Finish()

oSection1:Cell("cAbre"):SetValue(cData)
oReport:PrintText (cData, oReport:ROW(),1600)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
oReport:SkipLine ( )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo do Texto superior da Capa        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTxt := 'QPR1502'+'.TXT'
If File(cArqTxt)
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ''
		cImpLinha := ''
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
		oReport:PrintText (cImpLinha, oReport:ROW(),020)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		oReport:SkipLine ( )
	Next nC
EndIf
oReport:SkipLine ( )

dbSelectArea(aAreaQPR[1]);dbSetOrder(aAreaQPR[2]);dbGoTo(aAreaQPR[3])

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo dos dados da Entrega             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:PrintText (AllTrim(TitSX3('QPR_PRODUT')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_PRODUT')[1])))+':', oReport:ROW(),020)  
oReport:PrintText (AllTrim(QPR->QPR_PRODUT) + ' - ' + QP6->QP6_DESCPO, oReport:ROW(),370)  
oReport:SkipLine ( )

oReport:PrintText (AllTrim(TitSX3('QPR_DTENTR')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_DTENTR')[1])))+':', oReport:ROW(),020)  
oReport:PrintText (DTOC(QPR->QPR_DTENTR), oReport:ROW(),370)  
oReport:PrintText (AllTrim(TitSX3('QPR_LOTE')[1])+Replicate('.',19-Len(AllTrim(TitSX3('QPR_LOTE')[1])))+':', oReport:ROW(),1220)  
oReport:PrintText (QPR->QPR_LOTE, oReport:ROW(),1520)  
oReport:SkipLine ( )

oReport:PrintText (AllTrim(TitSX3('QPR_OP')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_OP')[1])))+':', oReport:ROW(),020)  
oReport:PrintText (QPR->QPR_OP, oReport:ROW(),370)  
oReport:PrintText (AllTrim(TitSX3('QPL_TAMLOT')[1])+Replicate('.',19-Len(AllTrim(TitSX3('QPL_TAMLOT')[1])))+':', oReport:ROW(),1220)  
SAH->(dbSetOrder(1))
SAH->(dbSeek(xFilial('SAH')+QPK->QPK_UM))
oReport:PrintText (AllTrim(Str(QPK->QPK_TAMLOT)) + '  ' + SAH->AH_UMRES, oReport:ROW(),1520)  
oReport:SkipLine ( )
oReport:SkipLine ( )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  VERIFICACAO DO PARAMETRO DE MEDICOES            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nMedicoes == 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe medi‡äes <> TXT               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aEnsaio) > 0 .And. Len(aEnsaio) <> Len(aResTxt)

		oSection2:Init()
		oReport:SetMeter(Len(aEnsaio))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a impressao dos resultados                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nC := 1 to Len(aEnsaio)
			If aEnsaio[nC,6] != 'TXT'
				dbSelectArea('QP1')
				dbSetOrder(1)
				dbSeek(xFilial('QP1')+aEnsaio[nC,2])
				oSection2:Cell("cEnsaio"):SetValue(QP1_DESCPO)
				oSection2:Cell("cNum"):SetValue('(' + StrZero(aEnsaio[nC,1],2) + ')')

				QP7->(dbSetOrder(1))
				QP7->(dbSeek(xFilial('QP7')+QPR->QPR_PRODUT+QPR->QPR_REVI+SC2->C2_ROTEIRO+aEnsaio[nC,7]+aEnsaio[nC,2]))

				If QP7->QP7_MINMAX == '1'
					oSection2:Cell("cLIE"):SetValue(aEnsaio[nC,3])
					oSection2:Cell("cLSE"):SetValue(aEnsaio[nC,4])
				ElseIf QP7->QP7_MINMAX == '2'
					oSection2:Cell("cLIE"):SetValue(aEnsaio[nC,3])
					oSection2:Cell("cLSE"):SetValue('>>>')
				ElseIf QP7->QP7_MINMAX == '3'
					oSection2:Cell("cLIE"):SetValue('<<<')
					oSection2:Cell("cLSE"):SetValue(aEnsaio[nC,4])
				EndIf

				// Busca Descricao resumida da Unidade Medida
				SAH->(dbSetOrder(1))
				SAH->(dbSeek(xFilial('SAH')+aEnsaio[nC,5]))
				oSection2:Cell("cUNIMED"):SetValue(SAH->AH_UMRES)
                
				cResult   := ""
				For nCont := 1 to Len(aResult)
					If nC == nCont
						cResult += aResult[nCont,2]
					EndIF
				Next nCont     
				oSection2:Cell("cResultados"):SetValue(cResult)
			EndIf  
			oSection2:PrintLine()
			oReport:IncMeter()
		Next nC
	EndIf
	oSection2:Finish()
	
  	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe medi‡äes no formato TXT       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	If Len(aResTxt) > 0
 
		oSection3:Init()
		oReport:SetMeter(Len(aEnsaio))

		x:= 1
		cTxt := ''
		For nP:= 1 to Len(aResTxt)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta array de acordo com o tamanho do texto.    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nA := 1 to 100
				cTxt += Substr(aResTxt[nP,1],nA,1)
				x++
				If x == 34
					While x >= 0
						x--
						If Substr(cTxt , x , 1 ) == ' '
							If !Empty(cTxt)
								AADD(aTxt,cTxt)
							EndIf
							cTxt := ''
							x:= 1
							Exit
						EndIf
					EndDo
					If x < 0
						If !Empty(cTxt)
							AADD(aTxt,cTxt)
						EndIf
						cTxt := ''
						x:= 1
					EndIf
				EndIf
			Next nA

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a medi‡Æo no formato txt de acordo com o ³
			//³ o array aTxt.                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nT := 1 to Len(aTxt)
				oSection3:Cell("cEnsaio"):Hide()
				oSection3:Cell("cNum"):Hide()
				oSection3:Cell("cEspecificado"):Hide()
				oSection3:Cell("cResultados"):Hide()

				If nT == 1
					oSection3:Cell("cEnsaio"):SetValue(aResTxt[nP,3])
					oSection3:Cell("cEnsaio"):Show()
					oSection3:Cell("cNum"):SetValue('(' + StrZero(aResTxt[nP,4],2) + ')')
					oSection3:Cell("cNum"):Show()
					oSection3:Cell("cEspecificado"):SetValue(aTxt[nT])
					oSection3:Cell("cEspecificado"):Show()
					oSection3:Cell("cResultados"):SetValue(aResTxt[nP,2])
					oSection3:Cell("cResultados"):Show()
				Else
					oSection3:Cell("cEspecificado"):SetValue(aTxt[nT])
					oSection3:Cell("cResultados"):Show()
				Endif
				oSection3:PrintLine()
			Next nT
			aTxt := {}
		Next nP
	Endif 
	oSection3:Finish()
EndIf

If Len(aNConf) > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Relacionamento com as Nao Conformidades encontradas          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	oSection4:Init()
	oReport:SetMeter(Len(aEnsaio))
	nAux := TamSX3('QPU_NUMNC')[1]
	For nC := 1 to Len(aNConf)
		If nFatZero == 2 .and. AllTrim(aNConf[nC,6]) == '0'
			Loop
		EndIf

		oSection4:Cell("cNaoConf"):SetValue('('+StrZero(aNConf[nC,1],2)+')  '+aNConf[nC,2])
		oSection4:Cell("cNumero"):SetValue(Str(aNConf[nC,3],nAux))
		oSection4:Cell("cClasse"):SetValue(AllTrim(aNConf[nC,4]))

		If aNConf[nC,8] == 'S'
			oSection4:Cell("cFator"):SetValue(STR0037 + AllTrim(aNConf[nC,6]) + STR0038)	//'Sim -'###' pontos'
		Else
	   		oSection4:Cell("cFator"):SetValue(STR0039)//'Nao'
		EndIf
		If aNConf[nC,7] > 1
	   		oSection4:Cell("cReincid"):SetValue(AllTrim(Str(aNConf[nC,7] - 1)) + ' a.') 
		EndIf    
		oSection4:PrintLine()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  VERIFICACAO DO PARAMETRO DE CRONICA             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nCronica == 1
			dbSelectArea('QA2')
			dbSetOrder(1)
			If	dbSeek(xFilial('QA2')+'QIPA210C'+aNConf[nC,5])
				While !Eof() .And. xFilial('QA2') == QA2->QA2_FILIAL .And. ;
					QA2->QA2_CHAVE == aNConf[nC,5] .And.;
					QA2->QA2_ESPEC == 'QIPA210C'
					If !Empty(QA2_TEXTO)
						oReport:PrintText (StrTran(QA2_TEXTO, "\13\10", ""), oReport:ROW(),050)  
						oReport:SkipLine ( )
					EndIf	
					dbSkip()
				EndDo
			EndIf
		EndIf
	Next nC
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  IMPRESSAO DO LAUDO DA PRODUCAO ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPL')
dbSetOrder(3)
If dbSeek(xFilial('QPL' )+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER+SC2->C2_ROTEIRO+Space(TamSX3('QPL_OPERAC')[1])+Space(TamSX3('QPL_LABOR' )[1]))
	oReport:SkipLine ( )
	oReport:PrintText (AllTrim(TitSX3('QPL_LAUDO')[1])+Replicate('.',30-Len(AllTrim(TitSX3('QPL_LAUDO')[1])))+':', oReport:ROW(),100)  
	dbSelectArea('QPD')
	dbSetOrder(1)
	If dbSeek(xFilial('QPD')+QPL->QPL_LAUDO)
		oReport:PrintText (QPL->QPL_LAUDO + ' - ' + QPD_DESCPO, oReport:ROW(),550)  
	EndIf
	oReport:SkipLine ( )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica parametro para imprimir a Justificativa do Laudo  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nJustif == 1
		oReport:PrintText (AllTrim(TitSX3('QPL_JUSTLA')[1])+Replicate('.',30-Len(AllTrim(TitSX3('QPL_JUSTLA')[1])))+':', oReport:ROW(),100)  
		oReport:PrintText (QPL->QPL_JUSTLA, oReport:ROW(),550)  
		oReport:SkipLine ( )
	EndIf

	oReport:PrintText (AllTrim(TitSX3('QPL_QTREJ')[1])+Replicate('.',30-Len(AllTrim(TitSX3('QPL_QTREJ')[1])))+':', oReport:ROW(),100)  
	SAH->(dbSetOrder(1))
	SAH->(dbSeek(xFilial('SAH')+QPK->QPK_UM))
	oReport:PrintText (AllTrim(QPL->QPL_QTREJ) +' '+ SAH->AH_UMRES, oReport:ROW(),550)  
	oReport:SkipLine ( )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo do Texto inferior da Capa        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTxt := 'QPR1503'+'.TXT'
If File(cArqTxt)
	oReport:SkipLine ( )
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ''
		cImpLinha := ''
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
		oReport:PrintText (cImpLinha,oReport:ROW(),020)  
		oReport:SkipLine ( )
	Next nC
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  VERIFICACAO DO PARAMETRO PARA A IMPRESSAO       ³
//³  DA 2a. PARTE DA CARTA                           ³
//³  OBS.:SERA IMPRESSO SOMENTE NA 1a.VIA            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nSegParte == 1
	oReport:EndPage()
	oSection1:Init()
	oSection1:PrintLine()
	oSection1:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo dos dados da Entrega             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:PrintText (AllTrim(TitSX3('QPR_PRODUT')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_PRODUT')[1])))+':', oReport:ROW(),020)  
	oReport:PrintText (AllTrim(QPR->QPR_PRODUT) + ' - ' + QP6->QP6_DESCPO, oReport:ROW(),370)  
	oReport:SkipLine ( )
	
	oReport:PrintText (AllTrim(TitSX3('QPR_DTENTR')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_DTENTR')[1])))+':', oReport:ROW(),020)  
	oReport:PrintText (DTOC(QPR->QPR_DTENTR), oReport:ROW(),370)  
	oReport:PrintText (AllTrim(TitSX3('QPR_LOTE')[1])+Replicate('.',19-Len(AllTrim(TitSX3('QPR_LOTE')[1])))+':', oReport:ROW(),1220)  
	oReport:PrintText (QPR->QPR_LOTE, oReport:ROW(),1520)  
	oReport:SkipLine ( )
	
	oReport:PrintText (AllTrim(TitSX3('QPR_OP')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_OP')[1])))+':', oReport:ROW(),020)  
	oReport:PrintText (QPR->QPR_OP, oReport:ROW(),370)  
	oReport:PrintText (AllTrim(TitSX3('QPL_TAMLOT')[1])+Replicate('.',19-Len(AllTrim(TitSX3('QPL_TAMLOT')[1])))+':', oReport:ROW(),1220)  
	SAH->(dbSetOrder(1))
	SAH->(dbSeek(xFilial('SAH')+QPK->QPK_UM))
	oReport:PrintText (AllTrim(Str(QPK->QPK_TAMLOT)) + '  ' + SAH->AH_UMRES, oReport:ROW(),1520)  
	oReport:SkipLine ( )
	oReport:SkipLine ( )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto Justificativas          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTxt := 'QPR1504'+'.TXT'
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha := MEMOLINE(cTexto,130,nC)
			cImpTxt   := ''
			cImpLinha := ''
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			oReport:PrintText (cImpLinha, oReport:ROW(),020)  
			oReport:SkipLine ( )
		Next nC
	EndIf

	oReport:SkipLine ( )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto Instrucoes - Digita‡Æo  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTxt := 'QPR1505'+'.TXT'
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha := MEMOLINE(cTexto,130,nC)
			cImpTxt   := ''
			cImpLinha := ''
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			oReport:PrintText (cImpLinha, oReport:ROW(),020)  
			oReport:SkipLine ( )
		Next nC
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo da Data da Garantia da Qualidade ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine ( )
	oReport:PrintText (STR0040, oReport:ROW(),1600)  //'Garantia da Qualidade       /     /    '
	oReport:SkipLine ( )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto An lise Interna         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine ( )
	cArqTxt := 'QPR1506'+'.TXT'
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha := MEMOLINE(cTexto,130,nC)
			cImpTxt   := ''
			cImpLinha := ''
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			oReport:PrintText (cImpLinha, oReport:ROW(),020)  
			oReport:SkipLine ( )
		Next nC
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPR')
Set Filter To
dbSetOrder(1)
dbSelectArea('QPK')
dbSetOrder(1)
dbSelectArea('QP6')
dbSetOrder(1)
dbSelectArea('QPL')
dbSetOrder(1)
dbSelectArea('QP1')
dbSetOrder(1)
dbSelectArea('QPD')
dbSetOrder(1)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R150IMPR3 ³ Autor ³ Marcelo Pimentel      ³ Data ³ 18/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ficha de entrega de produtos                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ R150IMPR3()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQIP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R150IMPR3()
// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Par„metros para a fun‡„o SetPrint () ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel			:='QIPR150'
LOCAL cString		:='QPR'
LOCAL cDesc1		:=STR0011	//'Neste relatorio sera impresso a Notificacao de Nao Conformidade.'
LOCAL cDesc2		:=''
LOCAL cDesc3		:=''
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Par„metros para a fun‡„o Cabec()  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cTitulo 	:=	OemToAnsi(STR0012)	//'Notificacao De Nao Conformidade'
PRIVATE cRelatorio:=	'QIPR150'
PRIVATE nTamanho	:= 'M'
PRIVATE nlimite 	:= 132
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas pela fun‡„o SetDefault () ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aReturn 	:= {OemToAnsi(STR0013), 1,OemToAnsi(STR0014),  1, 2, 1, '',1 }		//'Zebrado'###'Administrativo'
PRIVATE nLastKey  :=0,cPerg := 'QPR150',cPerg1	:= 'QPR151'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza variaveis de perguntas para utilizacao no momento da impressao do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg1	,.F.)
nJustif		:= mv_par01		//Parametro Justificativa 	  - QPR151 01 
nCronica	:= mv_par02		//Parametro Cronica			  - QPR151 02
nSegParte	:= mv_par03		//Parametro 2a. Parte		  - QPR151 03
nMedicoes	:= mv_par04		//Parametro Medicoes		  - QPR151 04
nFatZero	:= mv_par05		//Parametro Impressao Fator 0 - QPR151 05

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,'',.T.,nTamanho)

If nLastKey == 27
	Set Filter To
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif
RptStatus({|lEnd| A150Imp(@lEnd,wnRel,cString)},cTitulo)
Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A150Imp  ³ Autor ³ Marcelo Pimentel      ³ Data ³ 18/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Notificacao de Nao Conformidades                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ A150Imp(lEnd,wnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd     -  A‡Æo do CodeBlock                              ³±±
±±³          ³ wnRel    -  T¡tulo do relat¢rio                            ³±±
±±³          ³ cString  -  Mensagem                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQIP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A150Imp(lEnd,wnRel,cString)
Local aLinha	:= {},cImpTxt:= '',cImpLinha := '',cTexto:= ''
Local cArqTxt	:= '',cData:= '',lImpNNC := .T.,nConf,nContNNC:= 0
Local cAcentos := '€ú‡úú'+chr(65533)+'ú…ú†úƒú ú'+chr(65533)+'úˆú‚ú¡ú“ú”ú¢ú™ú£ú'
Local cAcSubst := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"
Local aMeses	:= {STR0015,STR0016,STR0017,STR0018,STR0019,STR0020,STR0021,STR0022,STR0023,STR0024,STR0025,STR0026}		//'Janeiro'###'Fevereiro'###'Marco'###'Abril'###'Maio'###'Junho'###'Julho'###'Agosto'###'Setembro'###'Outubro'###'Novembro'###'Dezembro'
Local aTxt		:= {},nPos:= 1,nCont:= 0,nCol:= 85,cTxt:= ''
Local cNNC		:= ''
Local nOrdQPR	:= QPR->(IndexOrd())
Local nOrdQPL	:= QPL->(IndexOrd())
Local aAreaQPR	:= NIL
Local nAux		:= 0
Local nCount    := 0
Local nC        := 0
Local nT        := 0
Local nA        := 0
Local nP        := 0

Private cChave := ''
Private Titulo 	 := cTitulo
Private Cabec1 	 := ""
Private Cabec2	 := ""
Private	nomeprog := "QIPR150"
Private cTamanho := "M"
Private nTipo	 := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a producao existe³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPR')
dbSetOrder(6)
IF !dbSeek(xFilial('QPR')+mv_par01+mv_par02+Dtos(mv_par03)+mv_par04)
	Set Device to Screen
	Help(' ',1,'QP_NAOPROD')	// 'Producao nao cadastrada.'
	dbSelectArea('QPR')
	dbSetOrder(nOrdQPR)
	Return
EndIf

aAreaQPR := {Alias(),IndexOrd(),Recno()}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona em registros de outros Arquivos 					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QP6')
dbSetOrder(1)
dbSeek(xFilial('QP6')+QPR->QPR_PRODUT+Inverte(QPR->QPR_REVI))  

dbSelectArea('SC2')
dbSetOrder(1)
dbSeek(xFilial('SC2')+QPR->QPR_OP)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a entrega tem laudo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPL')
dbSetOrder(3)
If !dbSeek(xFilial('QPL' )+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER+SC2->C2_ROTEIRO+Space(TamSX3('QPL_OPERAC')[1])+Space(TamSX3('QPL_LABOR' )[1]))
	MessageDlg(STR0043,,13)		//'Produ‡Æo nÆo tem Laudo.'
	dbSetOrder(nOrdQPL)
	Return
EndIf

dbSelectArea('QP7')
dbSetOrder(1)

dbSelectArea('QPK')
dbSetOrder(1)
dbSeek(xFilial('QPK')+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Li      := 80
m_pag   := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da funcao onde armazenar  array's com NConformidades.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aEnsaio := {}
Private nEns	:= 1
Private aNConf	:= {}
Private aResTXT	:= {}
Private aResult	:= {}
R150NNC()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Flag para verificar se ir  imprimir as Nao Conformidades en- ³
//³ contradas de acordo c/o paramentro:Imprime NC com Fator 0    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nFatZero == 2
	If Len(aNConf) > 0
		For nConf:= 1 to Len(aNConf)
			If AllTrim(aNConf[nConf,6]) == '0'
				lImpNNC	:= .F.
				nContNNC++
			EndIf
		Next nConf
	Else
		lImpNNC := .F.
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao tiver NC associada nao serah impresso.                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aNConf) == 0
	Set Device to Screen
	Help(' ',1,'Q_PRDNAONC')	// 'Produc„o n„o apresenta N„o Conformidades.'
	dbSelectArea('QPR')
	dbSetOrder(1)
	Return
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se o parametro Imprime NC com Fator 0 == Nao e o fator de to-³
//³ das as nao conformidades estiver com 0, nao ser  impresso.   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nFatZero == 2 .and. nContNNC == Len(aNConf)
	If !lImpNNC .And. GetMv('MV_ESNC') == 'N'
		Set Device to Screen
		Help(' ',1,'Q_PRDNAONC')	// 'Produc„o n„o apresenta N„o Conformidades.'
		dbSelectArea('QPR')
		dbSetOrder(1)
		Return
	Endif
EndIf

Begin Transaction
If Empty(QPK->QPK_CERQUA)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Faz a gera‡Æo autom tica do c¢digo da Notif.de NÆo Conformid. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNNC := QA_SEQUSX6('QIP_NNCO',TamSX3('QPK_CERQUA')[1],"S",OemToAnsi(STR0027)) 	//'Notifica‡„o N„o Conformidade'
	
	RecLock('QPK',.F.)
	QPK->QPK_CERQUA	:= cNNC
	MsUnlock()
Else
	cNNC := QPK->QPK_CERQUA
EndIf
End Transaction

If li > 55
	Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
EndIf

// SM0: Campos do arquivo SIGAMAT.EMP      
cData := AllTrim(SM0->M0_CIDENT)+','+ Str(day(dDataBase)) + STR0042 + aMeses[month(dDataBase)] + STR0042 + StrZero(year(dDataBase),4)	//' de '###' de '
@ Li,nLimite-Len(cData) PSAY cData
Li++

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo do Texto superior da Capa        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTxt := 'QPR1502'+'.TXT'
If File(cArqTxt)
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ''
		cImpLinha := ''
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

dbSelectArea(aAreaQPR[1]);dbSetOrder(aAreaQPR[2]);dbGoTo(aAreaQPR[3])

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo dos dados da Entrega             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@Li,01 PSAY AllTrim(TitSX3('QPR_PRODUT')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_PRODUT')[1])))+':'
@Li,27 PSAY AllTrim(QPR->QPR_PRODUT) + ' - ' + QP6->QP6_DESCPO
Li++
@Li,01 PSAY AllTrim(TitSX3('QPR_DTENTR')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_DTENTR')[1])))+':'
@Li,27 PSAY QPR->QPR_DTENTR
@Li,62 PSAY AllTrim(TitSX3('QPR_LOTE')[1])+Replicate('.',19-Len(AllTrim(TitSX3('QPR_LOTE')[1])))+':'
@Li,85 PSAY QPR->QPR_LOTE
Li++
@Li,01 PSAY AllTrim(TitSX3('QPR_OP')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_OP')[1])))+':'
@Li,27 PSAY QPR->QPR_OP
@Li,62 PSAY AllTrim(TitSX3('QPL_TAMLOT')[1])+Replicate('.',19-Len(AllTrim(TitSX3('QPL_TAMLOT')[1])))+':'
SAH->(dbSetOrder(1))
SAH->(dbSeek(xFilial('SAH')+QPK->QPK_UM))
@Li,85 PSAY AllTrim(Str(QPK->QPK_TAMLOT)) + '  ' + SAH->AH_UMRES
Li+=2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  VERIFICACAO DO PARAMETRO DE MEDICOES            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nMedicoes == 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe medi‡äes <> TXT               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aEnsaio) > 0 .And. Len(aEnsaio) <> Len(aResTxt)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ CABECALHO DOS RESULTADOS NAO ENCONTRADOS      	 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//Ensaio                                               LIE       LSE    Un.Me.    Resultados
		//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXX   XXXXXXXX  XXXXXXXX  XXXXXXXX    XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a impressao do cabe‡alho                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li,00 PSAY Replicate('=',132)
		Li++
		@ Li,01 PSAY TitSX3('QP7_ENSAIO')[1]
		@ Li,51 PSAY AllTrim(TitSX3('QP7_LIE')[1])
		@ Li,60 PSAY AllTrim(TitSX3('QP7_LSE')[1])
		@ Li,72 PSAY Subs(TitSX3('QP7_UNIMED')[1],1,10)
		@ Li,85 PSAY STR0028	//'Resultados'
		Li++
		@ Li,00 PSAY Replicate('=',132)
		Li++

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a impressao dos resultados                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nC := 1 to Len(aEnsaio)
			If aEnsaio[nC,6] != 'TXT'
				dbSelectArea('QP1')
				dbSetOrder(1)
				dbSeek(xFilial('QP1')+aEnsaio[nC,2])
				@Li,01 PSAY QP1_DESCPO
				@Li,41 PSAY '(' + StrZero(aEnsaio[nC,1],2) + ')'
				QP7->(dbSetOrder(1))
				QP7->(dbSeek(xFilial('QP7')+QPR->QPR_PRODUT+QPR->QPR_REVI+SC2->C2_ROTEIRO+aEnsaio[nC,7]+aEnsaio[nC,2]))

				If QP7->QP7_MINMAX == '1'
					@Li,51 PSAY aEnsaio[nC,3]
					@Li,60 PSAY aEnsaio[nC,4]
				ElseIf QP7->QP7_MINMAX == '2'
					@Li,51 PSAY aEnsaio[nC,3]
					@Li,65 PSAY '>>>'
				ElseIf QP7->QP7_MINMAX == '3'
					@Li,56 PSAY '<<<'
					@Li,60 PSAY aEnsaio[nC,4]
				EndIf

				// Busca Descricao resumida da Unidade Medida
				SAH->(dbSetOrder(1))
				SAH->(dbSeek(xFilial('SAH')+aEnsaio[nC,5]))
				@Li,72 PSAY SAH->AH_UMRES

				For nCont := 1 to Len(aResult)
					If nC == nCont
						If nPos == 6
							Li++
							nCol := 85
							nPos:= 1
						EndIf
						@Li,nCol PSAY aResult[nCont,2]
						nCol+=9
						nPos++
					EndIf
				Next nCont
				nCol:= 85
				nPos:= 1
				Li++
				@ Li,00 PSAY Replicate('-',132)
				Li++
			EndIf
		Next nC
	EndIf
	Li++

	If li > 55
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ CABECALHO DOS ENSAIOS TEXTO - TXT  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Ensaio                                        ESPECIFICADO                        RESULTADOS
	//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXX
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe medi‡äes no formato TXT       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aResTxt) > 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a impressao do cabe‡alho                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li,00 PSAY Replicate('=',132)
		Li++
		@ Li,01 PSAY TitSX3('QP7_ENSAIO')[1]
		@ Li,46 PSAY STR0044	//'Especificado'
		@ Li,82 PSAY STR0028	//'Resultados'
		Li++
		@ Li,00 PSAY Replicate('=',132)
		Li++
		x:= 1
		cTxt := ''
		For nP:= 1 to Len(aResTxt)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta array de acordo com o tamanho do texto.    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nA := 1 to 100
				cTxt += Substr(aResTxt[nP,1],nA,1)
				x++
				If x == 34
					While x >= 0
						x--
						If Substr(cTxt , x , 1 ) == ' '
							If !Empty(cTxt)
								AADD(aTxt,cTxt)
							EndIf
							cTxt := ''
							x:= 1
							Exit
						EndIf
					EndDo
					If x < 0
						If !Empty(cTxt)
							AADD(aTxt,cTxt)
						EndIf
						cTxt := ''
						x:= 1
					EndIf
				EndIf
			Next nA

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a medi‡Æo no formato txt de acordo com o ³
			//³ o array aTxt.                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nT := 1 to Len(aTxt)
				If nT == 1
					@Li,01 PSAY aResTxt[nP,3]
					@Li,41 PSAY '(' + StrZero(aResTxt[nP,4],2) + ')'
					@Li,46 PSAY aTxt[nT]
					@Li,82 PSAY aResTxt[nP,2]
					Li++
				Else
					@Li,46 PSAY aTxt[nT]
					Li++
				Endif
			Next nT
			aTxt := {}
		Next nP
	Endif
	Li+=2
EndIf

If Len(aNConf) > 0
	If li > 55
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Relacionamento com as Nao Conformidades encontradas          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ CABECALHO DAS NAO CONFORMIDADES ENCONTRADAS      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Nao Conformidade(s) encontrada(s)              No.       Classe                 Fator Criticidade    Reincidencia
	//---------------------------------------------  -----     --------------------   -----------------    ------------

	@ Li,000 PSAY STR0031	//'Nao Conformidade(s) encontrada(s)'
	@ Li,047 PSAY STR0032	//'No.'
	@ Li,057 PSAY STR0033	//'Classe'
	@ Li,083 PSAY STR0034	//'Fator Criticidade'
	@ Li,104 PSAY STR0035	//'Reincidencia'
	Li++
	@ Li,000 PSAY Replicate('-',45)
	@ Li,047 PSAY '-----'
	@ Li,057 PSAY Replicate('-',23)
	@ Li,083 PSAY Replicate('-',17)
	@ Li,104 PSAY Replicate('-',12)
	Li++

	If li > 55
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
		@ Li,50 PSAY STR0036		//'(  Continuacao dos Resultados encontrados  )'
		Li+=2
		@ Li,000 PSAY STR0031	//'Nao Conformidade(s) encontrada(s)'
		@ Li,047 PSAY STR0032	//'No.'
		@ Li,057 PSAY STR0033	//'Classe'
		@ Li,083 PSAY STR0034	//'Fator Criticidade'
		@ Li,104 PSAY STR0035	//'Reincidencia'
		Li++
		@ Li,00 PSAY Replicate('-',45)
		@ Li,47 PSAY '-----'
		@ Li,57 PSAY Replicate('-',23)
		@ Li,083 PSAY Replicate('-',17)
		@ Li,104 PSAY Replicate('-',12)
		Li++
	EndIf

	nAux := TamSX3('QPU_NUMNC')[1]
	For nC := 1 to Len(aNConf)
		If nFatZero == 2 .and. AllTrim(aNConf[nC,6]) == '0'
			Loop
		EndIf
		@Li,00 PSAY '('+StrZero(aNConf[nC,1],2)+')'
		@Li,05 PSAY aNConf[nC,2]
		@Li,47 PSAY Str(aNConf[nC,3],nAux)
		@Li,57 PSAY AllTrim(aNConf[nC,4])
		If aNConf[nC,8] == 'S'
			@Li,083 PSAY STR0037 + AllTrim(aNConf[nC,6]) + STR0038		//'Sim -'###' pontos'
		Else
			@Li,083 PSAY STR0039	//'Nao'
		EndIf
		If aNConf[nC,7] > 1
			@Li,104 PSAY AllTrim(Str(aNConf[nC,7] - 1)) + ' a.'
		EndIf
		Li++
		If li > 55
			Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			@ Li,50 PSAY STR0036	//'(  Continuacao dos Resultados encontrados  )'
			Li+=2
			@ Li,000 PSAY STR0031	//'Nao Conformidade(s) encontrada(s)'
			@ Li,047 PSAY STR0032	//'No.'
			@ Li,057 PSAY STR0033	//'Classe'
			@ Li,083 PSAY STR0034	//'Fator Criticidade'
			@ Li,104 PSAY STR0035	//'Reincidencia'
			Li++
			@ Li,00 PSAY Replicate('-',45)
			@ Li,47 PSAY '-----'
			@ Li,57 PSAY Replicate('-',23)
			@ Li,083 PSAY Replicate('-',17)
			@ Li,104 PSAY Replicate('-',12)
			Li++
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  VERIFICACAO DO PARAMETRO DE CRONICA             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nCronica == 1
			dbSelectArea('QA2')
			dbSetOrder(1)
			If	dbSeek(xFilial('QA2')+'QIPA210C'+aNConf[nC,5])
				While !Eof() .And. xFilial('QA2') == QA2->QA2_FILIAL .And. ;
					QA2->QA2_CHAVE == aNConf[nC,5] .And.;
					QA2->QA2_ESPEC == 'QIPA210C'
					If !Empty(QA2_TEXTO)
						@Li,05 PSAY StrTran(QA2_TEXTO, "\13\10", "")
						Li++
						If li > 55
							Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
						EndIf
					EndIf	
					dbSkip()
				EndDo
			EndIf
		EndIf
	Next nC
EndIf

Li+=2
If li > 55
	Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  IMPRESSAO DO LAUDO DA PRODUCAO ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPL')
dbSetOrder(3)
If dbSeek(xFilial('QPL' )+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER+SC2->C2_ROTEIRO+Space(TamSX3('QPL_OPERAC')[1])+Space(TamSX3('QPL_LABOR' )[1]))
	@Li,05 PSAY AllTrim(TitSX3('QPL_LAUDO')[1])+Replicate('.',30-Len(AllTrim(TitSX3('QPL_LAUDO')[1])))+':'
	dbSelectArea('QPD')
	dbSetOrder(1)
	If dbSeek(xFilial('QPD')+QPL->QPL_LAUDO)
		@Li,42 PSAY QPL->QPL_LAUDO + ' - ' + QPD_DESCPO
	EndIf
	Li++

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica parametro para imprimir a Justificativa do Laudo  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nJustif == 1
		@Li,05 PSAY AllTrim(TitSX3('QPL_JUSTLA')[1])+Replicate('.',30-Len(AllTrim(TitSX3('QPL_JUSTLA')[1])))+':'
		@Li,42 PSAY QPL->QPL_JUSTLA
		Li++
	EndIf

	@Li,05 PSAY AllTrim(TitSX3('QPL_QTREJ')[1])+Replicate('.',30-Len(AllTrim(TitSX3('QPL_QTREJ')[1])))+':'
	SAH->(dbSetOrder(1))
	SAH->(dbSeek(xFilial('SAH')+QPK->QPK_UM))
	@Li,42 PSAY AllTrim(QPL->QPL_QTREJ) +' '+ SAH->AH_UMRES
	Li++
EndIf

Li+=2
If li > 55
	Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo do Texto inferior da Capa        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTxt := 'QPR1503'+'.TXT'
If File(cArqTxt)
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ''
		cImpLinha := ''
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  VERIFICACAO DO PARAMETRO PARA A IMPRESSAO       ³
//³  DA 2a. PARTE DA CARTA                           ³
//³  OBS.:SERA IMPRESSO SOMENTE NA 1a.VIA            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nSegParte == 1
	Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo dos dados da Producao na 2a. parte da Carta  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@Li,11 PSAY AllTrim(TitSX3('QPR_PRODUT')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_PRODUT')[1])))+':'
	@Li,37 PSAY AllTrim(QPR->QPR_PRODUT) + ' - ' + QP6->QP6_DESCPO
	Li++
	@Li,11 PSAY AllTrim(TitSX3('QPR_DTENTR')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_DTENTR')[1])))+':'
	@Li,37 PSAY QPR->QPR_DTENTR
	Li++
	@Li,11 PSAY AllTrim(TitSX3('QPR_OP')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_OP')[1])))+':'
	@Li,37 PSAY QPR->QPR_OP
	Li++
	@Li,11 PSAY AllTrim(TitSX3('QPR_LOTE')[1])+Replicate('.',23-Len(AllTrim(TitSX3('QPR_LOTE')[1])))+':'
	@Li,37 PSAY QPR->QPR_LOTE
	Li+=2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto Justificativas          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTxt := 'QPR1504'+'.TXT'
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha := MEMOLINE(cTexto,130,nC)
			cImpTxt   := ''
			cImpLinha := ''
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			@Li,01 PSAY cImpLinha
			Li++
			If li > 55
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			EndIf
		Next nC
	EndIf

	Li+=2
	If li > 55
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto Instrucoes - Digita‡Æo  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTxt := 'QPR1505'+'.TXT'
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha := MEMOLINE(cTexto,130,nC)
			cImpTxt   := ''
			cImpLinha := ''
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			@Li,01 PSAY cImpLinha
			Li++
			If li > 55
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			EndIf
		Next nC
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo da Data da Garantia da Qualidade ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@Li,nLimite-Len('Garantia da Qualidade       /     /    ') PSAY STR0040		//'Garantia da Qualidade       /     /    '

	Li+=2
	If li > 55
		Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a ImpressÆo do Texto An lise Interna         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTxt := 'QPR1506'+'.TXT'
	If File(cArqTxt)
		cTexto:=MemoRead(cArqTxt)
		For nC := 1 To MLCOUNT(cTexto,130)
			aLinha := MEMOLINE(cTexto,130,nC)
			cImpTxt   := ''
			cImpLinha := ''
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			@Li,01 PSAY cImpLinha
			Li++
			If li > 55
				Cabec(cTitulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			EndIf
		Next nC
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPR')
Set Filter To
dbSetOrder(1)
dbSelectArea('QPK')
dbSetOrder(1)
dbSelectArea('QP6')
dbSetOrder(1)
dbSelectArea('QPL')
dbSetOrder(1)
dbSelectArea('QP1')
dbSetOrder(1)
dbSelectArea('QPD')
dbSetOrder(1)

Set device to Screen
If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()
Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R150NNC     ³Autor³ Marcelo Pimentel      ³ Data ³ 18/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se existe Nao Conformidade.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIPR150                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R150NNC(lR4, oReport)

Local nOcor:= 0
Local cProduto	:= QPR->QPR_PRODUT
Local cRevisao	:= QPR->QPR_REVI
Local dDataProd := QPR->QPR_DTENTR
Local cLote		:= QPR->QPR_LOTE
Local aAreaQPU  := NIL
Local aAreaQPR  := NIL
Local cMedica
Local cCondR4 	:= ''
Local cMVQPRESNC := GetMV('MV_QPRESNC')
Default lR4  	:= .F.
Default oReport	:= Nil


dbSelectArea('QPR')
aAreaQPR := {Alias(),IndexOrd(),Recno()}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verif. cada resultado da producao se possui NC ou se esta fora espec ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea('QPR')
dbSetOrder(6)
dbSeek(xFilial('QPR')+cProduto+cRevisao+Dtos(dDataProd)+cLote)

If lR4 
	If !Empty(AllTrim(oReport:Section(2):GetAdvplExp("QPR")))
		cCondR4 += oReport:Section(2):GetAdvplExp("QPR")
	EndIf
EndIf


While !QPR->(Eof()) .And. QPR->QPR_FILIAL == xFilial('QPR') .And.;
	QPR->QPR_PRODUT+QPR->QPR_REVI+Dtos(QPR->QPR_DTENTR)+QPR->QPR_LOTE ==	;
	cProduto+cRevisao+Dtos(dDataProd)+cLote
    
	If !Empty(cCondR4)
		If !QPR->(&(cCondR4))
			QPR->(DbSkip())
			loop
		Endif
	Endif				

	aAreaQPR := { Alias(),IndexOrd(),Recno()}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chave de ligacao com o QPU - Nao Conformidades das Entregas  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cChave := QPR->QPR_CHAVE

	QP1->(dbSetOrder(1))
	If QP1->(dbSeek(xFilial('QP1')+QPR->QPR_ENSAIO))
		dbSelectArea('QPU')
		dbSetOrder(1)
		If dbSeek(xFilial('QPU')+cChave)
			aAreaQPU1 := { Alias(),IndexOrd(),Recno() }
			While !Eof() .And. xFilial('QPU') == 	QPU_FILIAL .And. ;
				cChave == QPU_CODMED
				aAreaQPU := { Alias(),IndexOrd(),Recno() }
				cNConf:= QPU_NAOCON
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta array com nao conformidades encontradas                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				SAG->(dbSetOrder(1))
				If SAG->(dbSeek(xFilial('SAG')+cNConf))
					QEE->(dbSetOrder(1))
					If QEE->(dbSeek(xFilial('QEE')+QPU->QPU_CLASSE))
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Ser  Calculado o nr. de ocorrencias encontradas              ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						dbSelectArea(aAreaQPR[1]);dbSetOrder(aAreaQPR[2]);dbGoTo(aAreaQPR[3])
						nOcor := R150OCOR(QPU->QPU_NAOCON,QPR->QPR_OP)
						DbSelectArea(aAreaQPU[1]);DbSetOrder(aAreaQPU[2]);DbGoto(aAreaQPU[3])
						AADD(aNConf,{nENS,SAG->AG_DESCPO,QPU->QPU_NUMNC,QEE->QEE_DESCPO,QPU->QPU_CHAVE,Str(QEE->QEE_PONTOS,2),nOcor,QPU->QPU_DEMIQI})
					EndIf
				Endif
				QPU->(DbSkip())
			EndDo
			nOcor := 0

			dbSelectArea(aAreaQPR[1]);dbSetOrder(aAreaQPR[2]);dbGoTo(aAreaQPR[3])
			If QP1->QP1_CARTA <> 'TXT'
				QPS->(dbSetOrder(1))
				If QPS->(dbSeek(xFilial('QPS')+cChave))
					cMedica := ""
					While !QPS->(EOF()) .And. QPS->QPS_FILIAL == xFilial('QPS') .and.;
							QPS->QPS_CODMED == cChave
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Monta array c/ os valores de medicoes mensur veis(QPS)    ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						cMedica += Alltrim(QPS->QPS_MEDICA)+" " 	
							    
						QPS->(dbSkip())
					EndDo
					
					AADD(aResult,{nEns,cMedica})
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Monta array c/ os ensaios mensur veis dos produtos(QP7)      ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					QP7->(dbSetOrder(1))
					QP7->(dbSeek(xFilial('QP7')+QPR->QPR_PRODUT+QPR->QPR_REVI+SC2->C2_ROTEIRO+QPR->QPR_OPERAC+QPR->QPR_ENSAIO))
					AADD(aEnsaio,{nEns,QPR->QPR_ENSAIO,QP7->QP7_LIE,QP7->QP7_LSE,QP7->QP7_UNIMED,'NTXT',QPR->QPR_OPERAC})
				EndIf
			Else
				QP8->(dbSetOrder(1))
				QP8->(dbSeek(xFilial('QP8')+QPR->QPR_PRODUT+QPR->QPR_REVI+SC2->C2_ROTEIRO+QPR->QPR_OPERAC+QPR->QPR_ENSAIO))
				cTxt := QP8->QP8_TEXTO
				QPQ->(dbSetOrder(1))
				QPQ->(dbSeek(xFilial('QPQ')+cChave))
				cTxtRes := QPQ->QPQ_MEDICA
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta £nico array com Ensaios textos e valores de medic.(QPQ)³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				AADD(aResTXT,{QP8->QP8_TEXTO,QPQ->QPQ_MEDICA,QPR->QPR_ENSAIO,nEns,QPR->QPR_OPERAC})
				AADD(aEnsaio,{nEns,,,,,'TXT' })
			Endif
			nEns++
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se há medicoes fora da especificacao ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			// So verifica se nao tiver NC, porque se tiver, ja relacionou o ensaio
			// e seus resultados
			If cMVQPRESNC == 'S'	// Ind. se considera med. fora espec. como NC
				If QPR->QPR_RESULT == 'R'	// Fora espec. e da tolerancia
					If QP1->QP1_CARTA <> 'TXT'

						QPS->(dbSetOrder(1))
						If QPS->(dbSeek(xFilial('QPS')+cChave))
							While !QPS->(EOF()) .And. QPS->QPS_FILIAL == xFilial('QPS') .and.;
									QPS->QPS_CODMED == cChave
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Monta array c/ os valores de medicoes mensur veis(QPS)    ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								AADD(aResult,{nEns,QPS->QPS_MEDICA})
								QPS->(dbSkip())
							EndDo
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Monta array c/ os ensaios mensur veis dos produtos(QP7)      ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							QP7->(dbSetOrder(1))
							QP7->(dbSeek(xFilial('QP7')+QPR->QPR_PRODUT+QPR->QPR_REVI+QPR->QPR_ENSAIO))
							AADD(aEnsaio,{nEns,QPR->QPR_ENSAIO,QP7->QP7_LIE,QP7->QP7_LSE,QP7->QP7_UNIMED,'NTXT'})
						EndIf
					Else
						QP8->(dbSetOrder(1))
						QP8->(dbSeek(xFilial('QP8')+QPR->QPR_PRODUT+QPR->QPR_REVI+QPR->QPR_ENSAIO))
						cTxt := QP8->QP8_TEXTO
						QPQ->(dbSetOrder(1))
						QPQ->(dbSeek(xFilial('QPQ')+cChave))
						cTxtRes := QPQ->QPQ_MEDICA

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Monta £nico array com Ensaios textos e valores de medic.(QPQ)³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						AADD(aResTXT,{QP8->QP8_TEXTO,QPQ->QPQ_MEDICA,QPR->QPR_ENSAIO,nEns})
						AADD(aEnsaio,{nEns,,,,,'TXT' })
						EndIf
					nEns++
				EndIf
			EndIf
		EndIf
	EndIf
	dbSelectArea(aAreaQPR[1]);dbSetOrder(aAreaQPR[2]);dbGoTo(aAreaQPR[3])
	QPR->(dbSkip())
EndDo
Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R150OCOR ³ Autor ³ Marcelo Pimentel      ³ Data ³ 18/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula a reicidencia da NC para o Produto                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R150OCOR()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIPR150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R150OCOR(cNConf,cOP)
Local nOcor		:= 0
Local aAreaQPK	:= {}
Local aAreaQPR	:= {}
Local cCh		:= ''
Local cProduto	:= QPR->QPR_PRODUT
Local cRevisao	:= QPR->QPR_REVI
Local dDtLimite

dbSelectArea('QPR')
aAreaQPR := {Alias(),IndexOrd(),Recno()}

nDias			:= GetMv('MV_QDIREIN')
dDtLimite		:= QPR->QPR_DTENTR - nDias

dbSelectArea('QPK')
aAreaQPK := {Alias(),IndexOrd(),Recno()}
QPK->(dbSetOrder(2))
If QPK->(DbSeek(xFilial("QPK")+QPR->QPR_PRODUT+Dtos(dDtLimite),.T.))
	While !QPK->(Eof()) .And. QPK->QPK_FILIAL == xFilial('QPK') .And.;
		QPK->QPK_PRODUT == cProduto
		If QPK->QPK_REVI == cRevisao .AND. QPK->QPK_OP == cOP
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Seleciona os resultados da producao                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			QPR->(dbSetOrder(5))
			If QPR->(dbSeek(xFilial('QPR')+QPK->QPK_PRODUT+QPK->QPK_REVI))
				While !QPR->(Eof()) .And. QPR->QPR_FILIAL == xFilial('QPR') .And.;
					QPR->QPR_PRODUT+QPR->QPR_REVI == cProduto+cRevisao
	
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Obtem chave de ligacao da medicao com os outros arquivos     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cCh := QPR->QPR_CHAVE
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se a medicao tem NC                                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					QPU->(dbSetOrder(1))
					QPU->(dbSeek(xFilial('QPU')+cCh))
					While !QPU->(eof()) .And. QPU->QPU_FILIAL == xFilial('QPU') .And.;
						QPU->QPU_CODMED == cCh
						If QPU->QPU_NAOCON == cNConf
							nOcor++
						EndIf
						QPU->(dbSkip())
					EndDo
					QPR->(dbSkip())
				EndDo
			EndIf
		EndIf
		QPK->(dbSkip())
	EndDo
EndIf

dbSelectArea(aAreaQPK[1]);dbSetOrder(aAreaQPK[2]);dbGoTo(aAreaQPK[3])
dbSelectArea(aAreaQPR[1]);dbSetOrder(aAreaQPR[2]);dbGoTo(aAreaQPR[3])
Return(nOcor)
