/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr875.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 3 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR875  ³ Autor ³ Denis Hyroshi de Souza³ Data ³ 03/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Permitir que o pessoal de segurança do trabalho possa       ³±±
±±³          ³relacionar os fornecedores que apresentam EPI, cujo a       ³±±
±±³          ³data de Renovacao do C.A. Esta vencida ou a vencer em       ³±±
±±³          ³determinado periodo.                                        ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR875(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR875
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

Local oReport
Local aArea := GetArea()

Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
Private nTa1 	:= If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
Private nTa1L 	:= If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
Private nSizeTD := nTa1+nTa1L
Private nSizeFil:= FwSizeFilial()
Private nSizeSB1:= If((TAMSX3("B1_COD")[1]) < 1,15,(TAMSX3("B1_COD")[1]))

Private cModoTN3:= NGSX2MODO("TN3")
Private cPerg := If(!lSigaMdtPS,"MDT875    ","MDT875PS  ")

/*---------------------------
//PADRÃO						|
| De  Fornecedor ?			|
| Ate Fornecedor ?			|
| Ate Data ?					|
| De Filial ?					|
| Ate Filial ?				|
| Ordernar EPI ?				|
| 								|
//PRESTADOR 					|
| De Cliente ?				|
| Loja							|
| Até Cliente ?				|
| Loja							|
| De  Fornecedor ?			|
| Ate Fornecedor ?			|
| Ate Data ?					|
| De Filial ?					|
| Ate Filial ?				|	
| Ordernar EPI ?				|
-----------------------------*/

If TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:SetLandscape()
	oReport:PrintDialog()
Else
	U_MDTR875R3()
EndIf

RestArea(aArea)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³Andre E. Perez Alvarez ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Define as secoes impressas no relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR550                                                    ³±±
±±|__________|____________________________________________________________|±± 
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function ReportDef()

Static oReport
Static oSection0
Static oSection1
Static oCell

//LAYOUT
/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
_______________________________________________________________________________________________________________________________________________
                                                       
                                       Fornecedores com Certificado de Aprovacao a Vencer
_______________________________________________________________________________________________________________________________________________

Fornecedor  Nome Fornecedor                           
____________________________________________________
xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Codigo Epi       Nome Epi                        C.A.          Data Venc.
_________________________________________________________________________
xxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx   xx/xx/xx		
xxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx   xx/xx/xx		
xxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx   xx/xx/xx		
xxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx   xx/xx/xx					

*/ 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("MDTR875",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint()},;  //"Fornecedores com Certificado de Aprovacao a Vencer"
           STR0001+" "+STR0002+" "+STR0003)

Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lSigaMdtps
	//********************* Secao 0 - Cliente
	oSection0 := TRSection():New (oReport,STR0018, {"TN3","SA1"} )  //"Cliente"
	//oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção                  	
	oCell := TRCell():New(oSection0, "TN3_CLIENT" , "TN3"  , STR0018, "@!", nTa1  )  //"Cliente"
	oCell := TRCell():New(oSection0, "TN3_LOJACL" , "TN3"  , STR0016, "@!", nTa1L  )  //"Loja"
	oCell := TRCell():New(oSection0, "A1_NOME"    , "SA1"  , STR0019, "@!", 40  ) //"Nome"
	TRPosition():New(oSection0, "SA1", 1, {|| xFilial("SA1") + TN3->TN3_CLIENT+TN3->TN3_LOJACL})
ElseIf cModoTN3 != "C"
	//********************* Secao 0 - Filial
	oSection0 := TRSection():New (oReport,STR0031, {"TN3"} )//"Filial"
	oCell := TRCell():New(oSection0, "TN3_FILIAL"	, "TN3"  , "Filial", "@!", nSizeFil )
	oCell := TRCell():New(oSection0, "NOMFIL"		, "TN3", STR0019, "@!", 40, /*lPixel*/, {|| cNomFil } ) //"Nome"
Endif

//********************* Secao 1 - Fornecedor/Epi
oSection1 := TRSection():New (oReport,STR0009, {"SA2","SB1"} )//"Fornecedor" //"TN3",
oCell := TRCell():New(oSection1, "FORNEC", /*"TN3"*/ , STR0009, "@!"         , nTa1+5    , , {|| cFornec }) //"Fornecedor"
oCell := TRCell():New(oSection1, "NOMEFO", /*"SA2"*/ , STR0010, "@!"         , 45        , , {|| cNomFor }) //"Nome do Fornecedor"
oCell := TRCell():New(oSection1, "CODEPI", /*"TN3"*/ , STR0011, "@!"         , nSizeSB1+5, , {|| cCodEPI }) //"Codigo EPI"
oCell := TRCell():New(oSection1, "DESCRI", /*"SB1"*/ , STR0012, "@!"         , 50        , , {|| cNomEPI }) //"Nome EPI"
oCell := TRCell():New(oSection1, "NUMCAP", /*"TN3"*/ , STR0013, "@!"         , 14        , , {|| cNumCA  }) //"C.A."
oCell := TRCell():New(oSection1, "DTVENC", /*"TN3"*/ , STR0014, "99/99/9999" , 10        , , {|| dDtVenc }) //"Data Venc."

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ReportPrint³ Autor ³ Andre E. Perez Alvarez³ Data ³ 08/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime o relatorio.                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function ReportPrint()
Local i
Local cCliente := "", cCodFil := ""
Local aEPI := R875ARRCAR()//Carrega array com informacoes

Private cCodEPI := "", cNumCA := "", dDtVenc := CTOD("  /  /  ")
Private cFornec := "", cNomEPI := "", cNomFor := ""

If lSigaMdtps
	oReport:SetMeter(Len(aEPI))
	For i:=1 to Len(aEPI)
		oReport:IncMeter()
		dbSelectArea("TN3")
		dbSetOrder(05)//TN3_FILIAL+TN3_CLIENT+TN3_LOJACL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP
		dbSeek(xFilial("TN3")+aEPI[i][1]+aEPI[i][2]+aEPI[i][3]+aEPI[i][4]+aEPI[i][5])
		
		//Imprime Cliente
		If cCliente <> TN3->(TN3_CLIENT+TN3_LOJACL)
			cCliente := TN3->(TN3_CLIENT+TN3_LOJACL)
			cFornec  := ""
			oSection0:Init()
			oSection0:PrintLine()
		Endif
		
		oSection1:Init()
		If cFornec != TN3->TN3_FORNEC
			cFornec := TN3->TN3_FORNEC
			oSection1:Cell("TN3_FORNEC"):Show()
			oSection1:Cell("A2_NOME"):Show()
		Else
			oSection1:Cell("TN3_FORNEC"):Hide()
			oSection1:Cell("A2_NOME"):Hide()
		EndIf
		oSection1:PrintLine()
		
		If i+1 > Len(aEPI) .or. aEPI[i+1][2] != cFornec .or. aEPI[i+1][1] != cCliente
			oSection1:Finish()
		Endif
		
		If i+1 > Len(aEPI) .or. aEPI[i+1][1] != cCliente
			oSection0:Finish()
		Endif
	Next i
Else
	oReport:SetMeter(Len(aEPI))
	For i:=1 to Len(aEPI)
		If !aEPI[i][8]
			oReport:IncMeter()
			dbSelectArea("TN3")
			dbSetOrder(1)//TN3_FILIAL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP
			dbSeek(xFilial("TN3",aEPI[i][1])+aEPI[i][2]+aEPI[i][3]+aEPI[i][4]+aEPI[i][5])
			
			//Imprime Filial
			If cModoTN3 != "C" .and. cCodFil <> TN3->TN3_FILIAL
				cCodFil := TN3->TN3_FILIAL
				cFornec := ""
				cNomFil := aEPI[i,7]
				oSection0:Init()
				oSection0:PrintLine()
			Endif
			
			oSection1:Init()
			cCodEPI := aEPI[i,4]
			cNomEPI := aEPI[i,6]
			cNumCA  := aEPI[i,5]      
			dDtVenc := TN3->TN3_DTVENC
			If cFornec != TN3->TN3_FORNEC 
				cFornec := TN3->TN3_FORNEC
				cNomFor := NGSEEK('SA2',aEPI[i][2]+aEPI[i][3],1,'A2_NOME')
				oSection1:Cell("FORNEC"):Show()
				oSection1:Cell("NOMEFO"):Show()
			Else
				oSection1:Cell("FORNEC"):Hide()
				oSection1:Cell("NOMEFO"):Hide()
			EndIf
			oSection1:PrintLine()
			
			If i+1 > Len(aEPI) .or. (cModoTN3 != "C" .and. aEPI[i+1][1] != cCodFil) .or. aEPI[i+1][2] <> cFornec
				oSection1:Finish()
			Endif
			
			If cModoTN3 != "C" .and. (i+1 > Len(aEPI) .or. aEPI[i+1][1] != cCodFil)
				oSection0:Finish()
			Endif
		Else
			oReport:IncMeter()
			dbSelectArea("TL0")
			dbSetOrder(01)
			dbSeek(xFilial("TL0")+aEPI[i][9]+aEPI[i][2]+aEPI[i][3]+aEPI[i][4]+aEPI[i][5])
			
			//Imprime Filial
			If cModoTN3 != "C" .and. cCodFil <> TL0->TL0_FILIAL
				cCodFil := TL0->TL0_FILIAL
				cFornec := ""
				cNomFil := aEPI[i,7]
				oSection0:Init()
				oSection0:PrintLine()
			Endif
			
			oSection1:Init()
	   		cCodEPI := aEPI[i,4]
			cNomEPI := aEPI[i,6]
			cNumCA  := aEPI[i,5]      
			dDtVenc := TL0->TL0_DTVENC
			If cFornec != TL0->TL0_FORNEC
				cFornec := TL0->TL0_FORNEC
				cNomFor := NGSEEK('SA2',aEPI[i][2]+aEPI[i][3],1,'A2_NOME')
				oSection1:Cell("FORNEC"):Show()
				oSection1:Cell("NOMEFO"):Show()
			Else
				oSection1:Cell("FORNEC"):Hide()
				oSection1:Cell("NOMEFO"):Hide()
			EndIf
			oSection1:PrintLine()
						
			If i+1 > Len(aEPI) .or. (cModoTN3 != "C" .and. aEPI[i+1][1] != cCodFil) .or. aEPI[i+1][2] <> cFornec
				oSection1:Finish()
			Endif
			
			If cModoTN3 != "C" .and. (i+1 > Len(aEPI) .or. aEPI[i+1][1] != cCodFil)
				oSection0:Finish()
			Endif
		EndIf		
	Next i
Endif

Return .T.   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR875R3³ Autor ³ Denis Hyroshi de Souza³ Data ³ 03/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Epi x C.A. Vencido (realese 3)                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR875                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR875R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cString := "TN3"
LOCAL wnrel   := "MDTR875"
LOCAL cDesc1  := STR0001 //"Relacionar os fornecedores que apresentam EPI, cujo"
LOCAL cDesc2  := STR0002 //"a data de Renovacao do C.A esta vencida ou a vencer"
LOCAL cDesc3  := STR0003 //"em determinado periodo."

PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog := "MDTR875"
PRIVATE tamanho  := "G"
PRIVATE titulo   := STR0006 //"Fornecedores com Certificado de Aprovacao a Vencer"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1   := STR0007//"Fornec.               Nome Fornecedor                           Codigo Epi                      Nome EPI                                           C.A.          Data Venc."
PRIVATE cabec2   := " "

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

#IFDEF WINDOWS
	RptStatus({|lEnd| R875Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
#ELSE
	R875Imp(.F.,wnRel,titulo,tamanho)
#ENDIF
Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R875Imp  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 03/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR875                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R875Imp(lEnd,wnRel,titulo,tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cRodaTxt := ""
Local nCntImpr := 0
Local i
Local cCliente := "", cFornec := "", cEpi := "", cCliAtu := "", cLojAtu := "", cNumCap := ""
Local lFornec  := .T., cCodFil:= "", cFilAtu := ""
Local dDtAtu := CTOD('')
Local aEPI     := R875ARRCAR()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*
Fornec.               Nome Fornecedor                           Codigo Epi                      Nome EPI                                           C.A.          Data Venc.
0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx  99/99/99
                                                                xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx  99/99/99

*/

If lSigaMdtps
	SetRegua(Len(aEPI))
	For i:=1 to Len(aEPI)
		IncRegua()
		If !aEPI[i][7]
			dbSelectArea("TN3")
			dbSetOrder(05)//TN3_FILIAL+TN3_CLIENT+TN3_LOJACL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP
			dbSeek(xFilial("TN3")+aEPI[i][1]+aEPI[i][2]+aEPI[i][3]+aEPI[i][4]+aEPI[i][5])
			
			cFornec := TN3->TN3_FORNEC
			cEpi    := TN3->TN3_CODEPI
			cCliAtu := TN3->TN3_CLIENT
			cLojAtu := TN3->TN3_LOJACL
			cNumCap := TN3->TN3_NUMCAP
			dDtAtu  := TN3->TN3_DTVENC
		Else
			dbSelectArea("TL0") //Arrumar chave e indice <<<<<<<
			dbSetOrder(04)
			dbSeek(xFilial("TL0")+aEPI[i][1]+aEPI[i][8]+aEPI[i][2]+aEPI[i][3]+aEPI[i][4])
			
			cFornec := TL0->TL0_FORNEC
			cEpi    := TL0->TL0_EPIFIL
			cCliAtu := TL0->TL0_CLIENT
			cLojAtu := TL0->TL0_LOJACL
			cNumCap := TL0->TL0_NUMCAP
			dDtAtu  := TL0->TL0_DTVENC
		EndIf
		
		//Imprime Cliente
		If cCliente <> cCliAtu+cLojAtu
			lFornec := .t.
			cCliente := If(!aEPI[i][7],TN3->(TN3_CLIENT+TN3_LOJACL),TL0->(TL0_CLIENT+TL0_LOJACL))
			Somalinha()
			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+cCliente)
			@Li,000 PSAY STR0020 + Alltrim(cCliAtu) + "-" + Alltrim(cLojAtu) + " - " + AllTrim(SA1->A1_NOME)  //"Cliente: "
			Somalinha()
		Endif
				
		Somalinha()
		If lFornec
			@ Li,000 Psay cFornec
			DbSelectArea("SA2")
			DbSetOrder(1)
			DbSeek(xFilial("SA2")+cFornec)
			@ Li,022 Psay SubStr(SA2->A2_NOME,1,40)
			lFornec := .f.
		Endif
		@ Li,064 Psay cEpi
        
		@ Li,096 pSay Substr(aEPI[i][6],1,50) Picture "@!"
		@ Li,147 Psay cNumCap
		@ Li,161 Psay dDtAtu Picture "99/99/9999"
		
		If i+1 > Len(aEPI) .or. aEPI[i+1][2] != cFornec .or. aEPI[i+1][1] != cCliente
			lFornec = .t.
		Endif
		
		If i+1 > Len(aEPI) .or. aEPI[i+1][1] != cCliente
			Somalinha()
			@Li,000 pSay __PrtThinLine()
		Endif
	Next i		
Else
	SetRegua(Len(aEPI))
	For i:=1 to Len(aEPI)
		IncRegua()
		If !aEPI[i][8]
			dbSelectArea("TN3")
			dbSetOrder(1)//TN3_FILIAL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP
			dbSeek(xFilial("TN3",aEPI[i][1])+aEPI[i][2]+aEPI[i][3]+aEPI[i][4]+aEPI[i][5])
			
			cFornec := TN3->TN3_FORNEC
			cEpi    := TN3->TN3_CODEPI
			cFilAtu := TN3->TN3_FILIAL
			cNumCap := TN3->TN3_NUMCAP
			dDtAtu  := TN3->TN3_DTVENC
		Else
			dbSelectArea("TL0")
			dbSetOrder(01)
			dbSeek(xFilial("TL0")+aEPI[i][9]+aEPI[i][2]+aEPI[i][3]+aEPI[i][4]+aEPI[i][5])
			
			cFornec := TL0->TL0_FORNEC
			cEpi    := TL0->TL0_EPIFIL
			cFilAtu := TL0->TL0_FILIAL
			cNumCap := TL0->TL0_NUMCAP
			dDtAtu  := TL0->TL0_DTVENC
		EndIf

		//Imprime Filial
		If cModoTN3 != "C" .and. cCodFil <> cFilAtu
			cCodFil := If(!aEPI[i][8],TN3->TN3_FILIAL,TL0->TL0_FILIAL)
			lFornec := .T.
			Somalinha()
			@Li,000 PSAY STR0031+": "+AllTrim(cFilAtu)+" - "+aEPI[i,7]//"Filial"
			Somalinha()
		Endif
				
		Somalinha()
		If lFornec
			@ Li,000 Psay cFornec
			DbSelectArea("SA2")
			DbSetOrder(1)
			DbSeek(xFilial("SA2",aEPI[i][1])+cFornec)
			@ Li,022 Psay SubStr(SA2->A2_NOME,1,40)
			lFornec := .f.
		Endif
		@ Li,064 Psay cEpi
        
		@ Li,096 pSay Substr(aEPI[i][6],1,50) Picture "@!"
		@ Li,147 Psay cNumCap
		@ Li,161 Psay dDtAtu Picture "99/99/9999"
		
		If i+1 > Len(aEPI) .or. aEPI[i+1][2] != cFornec .or. (cModoTN3 != "C" .and. aEPI[i+1][1] != cCodFil)
			lFornec = .t.
		Endif

		If cModoTN3 != "C" .and. (i+1 > Len(aEPI) .or. aEPI[i+1][1] != cCodFil)
			Somalinha()
			@Li,000 pSay __PrtThinLine()
		Endif
	Next i
Endif

If Len(aEPI) == 0
	MsgStop(STR0032, STR0028)//"Não existem dados para montar o relatório."##"Atenção"
	Return .F.
Endif
Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TN3")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()
              
dbSelectArea("TN3")
dbSetOrder(01)

Return NIL
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³Denis Hyroshi de Souza ³ Data ³ 03/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR875                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R875ARRCARºAutor  ³Roger Rodrigues     º Data ³  06/09/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Carrega array com Epi's para ordenacao                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³MDTR875                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R875ARRCAR()
Local aArray := {}
Local aFiliais := {}
Local i

If lSigaMdtps
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TN3 para ler os  Fornecedores de EPI              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	dbSelectArea("TN3")
	dbSetOrder(05)//TN3_FILIAL+TN3_CLIENT+TN3_LOJACL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP
	dbSeek(xFilial("TN3") + mv_par01+mv_par02, .T. )
	ProcRegua(TN3->(RecCount()))
	While !Eof() .AND. TN3->TN3_FILIAL == xFilial("TN3") .AND.;
		TN3->(TN3_CLIENT+TN3_LOJACL) >= mv_par01+mv_par02 .and. TN3->(TN3_CLIENT+TN3_LOJACL) <= mv_par03+mv_par04
		
		IncProc()
		If TN3->TN3_FORNEC < MV_PAR05 .or. TN3->TN3_FORNEC > MV_PAR06
			dbSelectArea("TN3")
			dbSkip()
			Loop
		Endif
		If TN3->TN3_GENERI == '1' //Verifica se não é EPI genérico
			If TN3->TN3_DTVENC > MV_PAR07
				dbSelectArea("TN3")
				dbSkip()
				Loop
			Endif
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek(xFilial("SB1")+TN3->TN3_CODEPI)
			If aScan(aArray, {|x| x[1]+x[2]+x[3] == TN3->(TN3_CLIENT+TN3_LOJACL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP) }) == 0
				aAdd(aArray, {TN3->(TN3_CLIENT+TN3_LOJACL), TN3->TN3_FORNEC, TN3->TN3_LOJA, TN3->TN3_CODEPI, TN3->TN3_NUMCAP,AllTrim(SB1->B1_DESC),.F.})
			Endif
		Else  //Se genérico busca todos os filhos relacionados
			dbSelectArea("TL0")
			dbSetOrder(4)
			dbSeek(xFilial("TL0")+TN3->(TN3_CLIENT+TN3_LOJACL+TN3_CODEPI+TN3_FORNEC+TN3_LOJA))
			While TL0->(!Eof()) .and. TL0->(TL0_CLIENT+TL0_LOJACL+TL0_EPIGEN+TL0_FORNEC+TL0_LOJA) == TN3->(TN3_CLIENT+TN3_LOJACL+TN3_CODEPI+TN3_FORNEC+TN3_LOJA)
				If TL0->TL0_DTVENC > MV_PAR07
					dbSelectArea("TL0")
					TL0->(dbSkip())
				EndIf
				dbSelectArea("SB1")
				dbSetOrder(1)
				dbSeek(xFilial("SB1")+TL0->TL0_EPIFIL)
				If aScan(aArray, {|x| x[1]+x[2]+x[3] == TL0->(TL0_CLIENT+TL0_LOJACL+TL0_FORNEC+TL0_LOJA+TL0_EPIFIL+TL0_NUMCAP) }) == 0
					aAdd(aArray, {TL0->(TL0_CLIENT+TL0_LOJACL), TL0->TL0_FORNEC, TL0->TL0_LOJA, TL0->TL0_EPIFIL, TL0->TL0_NUMCAP,AllTrim(SB1->B1_DESC),.T.,TN3->TN3_CODEPI})
				Endif
				dbSelectArea("TL0")
				TL0->(dbSkip())
			End
		EndIf
		//Realiza Ordenacao
		If MV_PAR08 == 2
			ASORT(aArray,,,{|x,y| x[1]+x[2]+x[3]+x[6] < y[1]+y[2]+y[3]+y[6] })
		Else
			ASORT(aArray,,,{|x,y| x[1]+x[2]+x[3]+x[4] < y[1]+y[2]+y[3]+y[4] })
		Endif
		dbSelectArea("TN3")
		dbSkip()
	End
Else
	aFiliais := MDTRETFIL("TN3", MV_PAR04, MV_PAR05)
	
	For i:=1 to Len(aFiliais)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Correr TN3 para ler os  Fornecedores de EPI              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("TN3")
		dbSetOrder(01)
		dbSeek(xFilial("TN3",aFiliais[i,1]) + mv_par01, .T. )
		ProcRegua(TN3->(RecCount()))
		While !Eof() .AND. TN3->TN3_FILIAL == xFilial("TN3",aFiliais[i,1]) .AND. TN3->TN3_FORNEC <= MV_PAR02
			IncProc()
			//Verifica NUMCAP para EPIs filhos
			If TN3->TN3_GENERI == '1' //Verifica se o EPI não é genérico
				If TN3->TN3_DTVENC > MV_PAR03
					dbSelectArea("TN3")
					dbSkip()
					Loop
				Endif
				
				dbSelectArea("SB1")
				dbSetOrder(1)
				dbSeek(xFilial("SB1", aFiliais[i,1])+TN3->TN3_CODEPI)
				If aScan(aArray, {|x| x[1]+x[2]+x[3] == TN3->(TN3_FILIAL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP) }) == 0
					aAdd(aArray, {TN3->TN3_FILIAL, TN3->TN3_FORNEC, TN3->TN3_LOJA, TN3->TN3_CODEPI, TN3->TN3_NUMCAP,AllTrim(SB1->B1_DESC),;
											aFiliais[i,2],.F.})
				Endif
			Else //Se for genérico busca os EPIs filhos
				dbSelectArea("TL0")
				dbSetOrder(1)
				dbSeek(xFilial("TL0", aFiliais[i,1])+TN3->(TN3_CODEPI+TN3_FORNEC+TN3_LOJA))
				While TL0->(!Eof()) .and. TL0->(TL0_EPIGEN+TL0_FORNEC+TL0_LOJA) == TN3->(TN3_CODEPI+TN3_FORNEC+TN3_LOJA)
					If TL0->TL0_DTVENC > MV_PAR03
						dbSelectArea("TL0")
						TL0->(dbSkip())
						Loop
					EndIf
					dbSelectArea("SB1")
					dbSetOrder(1)
					dbSeek(xFilial("SB1", aFiliais[i,1])+TL0->TL0_EPIFIL)
					If aScan(aArray, {|x| x[1]+x[2]+x[3] == TL0->(TL0_FORNEC+TL0_LOJA+TL0_EPIFIL+TL0_NUMCAP) }) == 0
						aAdd(aArray, {TL0->TL0_FILIAL, TL0->TL0_FORNEC, TL0->TL0_LOJA, TL0->TL0_EPIFIL, TL0->TL0_NUMCAP,AllTrim(SB1->B1_DESC),;
									  aFiliais[i,2],.T.,TN3->TN3_CODEPI})
					Endif
					dbSelectArea("TL0")
					TL0->(dbSkip())
				End
			EndIf
			dbSelectArea("TN3")
			dbSkip()
		End
	Next i
	//Realiza Ordenacao
	If MV_PAR06 == 2
		ASORT(aArray,,,{|x,y| x[1]+x[2]+x[3]+x[6] < y[1]+y[2]+y[3]+y[6]})
	Else
		ASORT(aArray,,,{|x,y| x[1]+x[2]+x[3]+x[4] < y[1]+y[2]+y[3]+y[4]})
	Endif
Endif

Return aArray