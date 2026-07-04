/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "SGAR110.ch"
#INCLUDE "PROTHEUS.CH"
#Define _nVERSAO 02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SGAR110  ³ Autor ³ Rafael Diogo Richter  ³ Data ³03/10/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de automonitoramento de residuos solidos          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function SGAR110()
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)
Local oReport
Local aArea := GetArea()
Private cPERG := "SGR110    "
Private aPerg :={}
Private nTamFor := If(TAMSX3("A2_COD")[1] > 0, TAMSX3("A2_COD")[1], 6)
//Variaveis de TRB
Private lGera := .t.
Private aVetInr   := {}
Private cAliasTRB := GetNextAlias()
Private oTempTRB

nTamFor := If(NGCADICBASE("TBA_CODREC","A","TBA",.F.), TAMSX3("TBA_CODREC")[1] , nTamFor)

If FindFunction("TRepInUse") .And. TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:SetLandscape()  //Default Paisagem
	oReport:PrintDialog()
Else
	U_SGAR110R3()
EndIf
RestArea(aArea)

NGRETURNPRM(aNGBEGINPRM)
Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³ Rafael Diogo Richter  ³ Data ³12/12/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Define as sessoes impressas no relatorio.                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oCell

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
oReport := TReport():New("SGAR110",OemToAnsi(STR0003),"SGR110    ",{|oReport| ReportPrint(oReport)},STR0004+" "+STR0005) //"Relatório de Automonitoramento de Resíduos"###"O relatório apresentará uma listagem"###"do automonitoramento dos resíduos."

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para qarametros!                        ³
³ mv_par01     // De Roteiro                                   ³
³ mv_par02     // Ate Roteiro                                  ³
³ mv_par03     // De Plano                                     ³
³ mv_par04     // Ate Plano                                    ³
³ mv_par05     // De Servico                                   ³
³ mv_par06     // Ate Servico                                  ³
³ mv_par07     // De Data                                      ³
³ mv_par08     // Ate Data                                     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
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
oSection1 := TRSection():New(oReport,STR0006,{cAliasTRB,"SB1","SA2"}) //"Resíduos"
oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção
oCell := TRCell():New(oSection1,"(cAliasTRB)->CODRES"		,cAliasTRB,STR0007 ,"@!" ,18 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Resíduo"
oCell := TRCell():New(oSection1,"B1_DESC"			,"SB1",STR0008,"@!",38,/*lPixel*/) //"Descrição"
oCell := TRCell():New(oSection1,"SubStr(MESEXTENSO((cAliasTRB)->MES),1,3)",cAliasTRB,STR0009,"@!" ,4,/*lPixel*/) //"Mês"
oCell := TRCell():New(oSection1,"(cAliasTRB)->CODOCO"		,cAliasTRB,STR0010,"@!",09,/*lPixel*/) //"Ocorr."
oCell := TRCell():New(oSection1,"(cAliasTRB)->QTDE"			,cAliasTRB,STR0011,"@E 999,999.99",20,/*lPixel*/) //"Geração"
oCell := TRCell():New(oSection1,"(cAliasTRB)->QTDSAI"		,cAliasTRB,STR0012,"@E 999,999.99",20,/*lPixel*/) //"Destinação"
oCell := TRCell():New(oSection1,"DTOC((cAliasTRB)->DTTRAN)"	,cAliasTRB,STR0013,"",16,/*lPixel*/) //"Data"
oCell := TRCell():New(oSection1,"(cAliasTRB)->HRTRAN"		,cAliasTRB,STR0014,"@E 99:99",14,/*lPixel*/) //"Hora"
oCell := TRCell():New(oSection1,"(cAliasTRB)->DESFOR"		,cAliasTRB,STR0016,"@!",47,/*lPixel*/) //"Empresa Responsável pela Destinação"
oCell := TRCell():New(oSection1,"(cAliasTRB)->NUMLIC"		,cAliasTRB,STR0017,"@!",20,/*lPixel*/) //"Núm. CADRI"
TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1")+(cAliasTRB)->CODRES})
TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2")+(cAliasTRB)->FORNEC})
oSection1:Cell("(cAliasTRB)->QTDE"):SetHeaderAlign("RIGHT")
oSection1:Cell("(cAliasTRB)->QTDSAI"):SetHeaderAlign("CENTER")
oSection1:Cell("(cAliasTRB)->QTDSAI"):SetAlign(2)

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SGAR110R3 ³ Autor ³ Rafael Diogo Richter  ³ Data ³03/10/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de automonitoramento de residuos solidos          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function SGAR110R3()

Private NOMEPROG := "SGAR110"
Private TAMANHO  := "G"
Private aRETURN  := {STR0018,1,STR0019,1,2,1,"",1} //"Zebrado"###"Administracao"
Private TITULO   := STR0003 //"Relatório de Automonitoramento de Resíduos"
Private nTIPO    := 0
Private nLASTKEY := 0
Private CABEC1,CABEC2
Private aVETINR := {}

WNREL      := "SGAR110"
LIMITE     := 132
cDESC1     := STR0020 //"O relatório apresentará uma listagem "
cDESC2     := STR0021 //"do automonitoramento dos resíduos.   "
cDESC3     := ""
cSTRING    := "TB0"

Pergunte(cPERG,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WNREL:=SetPrint(cSTRING,WNREL,cPERG,TITULO,cDESC1,cDESC2,cDESC3,.F.,"")
If nLASTKEY = 27
	DbSelectArea("TB0")
	Return
EndIf

SetDefault(aReturn,cSTRING)
Processa({|lEND| U_SGR110IMP(@lEND,WNREL,TITULO,TAMANHO)},STR0022,STR0023) //"Aguarde..."###"Processando Registros..."

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    |SGR110IMP | Autor ³ Rafael Diogo Richter  ³ Data ³04/10/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Chamada do Relat¢rio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³SGAR110                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function SGR110IMP(lEND,WNREL,TITULO,TAMANHO)
Local i,j,x
Private cRODATXT := ""
Private nCNTIMPR := 0
Private li := 80 ,m_pag := 1
Private lFirst := .t.

nTIPO  := IIf(aReturn[4]==1,15,18)

Processa({|| U_SGR110TMP()}, STR0024, STR0025) //"Aguarde"###"Processando Arquivo..."

If !lGera
	oTempTRB:Delete()
	Return .f.
Endif

CABEC1 := STR0026 //"Resíduo          Descrição                                 Mês  Ocorr.      Geração     Data Comp. Carga      Hora    Destinação     Empresa Responsável pela Destinação            Núm. CADRI"
CABEC2 := ""

/*
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234
*****************************************************************************************************************************************************************************************
Resíduo          Descrição                                 Mês  Ocorr.      Geração     Data Comp. Carga    Hora    Destinação     Empresa Responsável pela Destinação            Núm. CADRI

XXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXX  XXXXXX  999.999.999 	 99/99/9999  			99:99   999.999.999    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXX
XXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXX  XXXXXX  999.999.999  	 99/99/9999  			99:99   999.999.999    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXX

*/
lFirst := .T.
cCodRes := ""
dbSelectArea(cAliasTRB)
dbSetOrder(1)
dbGoTop()
While !Eof()
	
	If lFirst
		NgSomaLi(58)
		lFirst := .F.
	EndIf
	
	IncProc()
		
	If cCodRes <> (cAliasTRB)->CODRES
		@ Li,000   Psay (cAliasTRB)->CODRES
		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek(xFilial("SB1")+(cAliasTRB)->CODRES)
		@ Li,017   Psay SubStr(SB1->B1_DESC,1,40)
		cCodRes := (cAliasTRB)->CODRES
	EndIf
	@ Li,059   Psay SubStr(MESEXTENSO((cAliasTRB)->MES),1,3)
	@ Li,064   Psay (cAliasTRB)->CODOCO
	@ Li,073   Psay (cAliasTRB)->QTDE Picture "@E 999,999.99"
	@ Li,094   Psay DTOC((cAliasTRB)->DTTRAN)
	@ Li,109   Psay (cAliasTRB)->HRTRAN
	@ Li,118   Psay (cAliasTRB)->QTDSAI Picture "@E 999,999.99"
	@ Li,133   Psay (cAliasTRB)->DESFOR
	@ Li,172   Psay (cAliasTRB)->NUMLIC
	NgSomaLi(58)
	
	dbSelectArea(cAliasTRB)
	dbSkip()
End

RODA(nCNTIMPR,cRODATXT,TAMANHO)

Set Device To Screen
If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(WNREL)
EndIf
MS_FLUSH()

oTempTRB:Delete()

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    |SGR110TMP | Autor ³ Rafael Diogo Richter  ³ Data ³05/10/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Geracao do arquivo temporario                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³SGAR110                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function SGR110TMP()
Local aDBF    := {}
Local cDesFor := ""
Local lTemTDJ := AliasInDic("TDJ")

aDBF :=	{{"CODRES"	,"C",	15,0},;
			{"DTOCO"	,"D",	10,0},;
			{"CODOCO"	,"C",	06,0},;
			{"MES"		,"N",	02,0},;
			{"HORA"	,"C",	05,0},;
			{"QTDE"	,"N",	09,2},;
			{"UNIMED"	,"C",	06,0},;
			{"QTDSAI"	,"N",	09,2},;
			{"DTTRAN"	,"D",	10,0},;
			{"HRTRAN"	,"C",	05,0},;
			{"FORNEC"	,"C",nTamFor,0},;
			{"DESFOR"	,"C",	45,2},;
			{"NUMLIC"	,"C",	20,0}}

oTempTRB := FWTemporaryTable():New( cAliasTRB, aDBF )
oTempTRB:AddIndex( "1", {"CODRES","MES","CODOCO","DTTRAN","HRTRAN","FORNEC"} )
oTempTRB:Create()

dbSelectArea("TB0")
dbSetOrder(3)
dbSeek(xFilial("TB0")+DTOS(MV_PAR01),.T.)
While TB0->( !Eof() ) .AND. TB0->TB0_DATA < MV_PAR02
	
	If lTemTDJ
		dbSelectArea("TDJ")
		dbSetOrder(2)
	Endif
	If lTemTDJ .AND. dbSeek(xFilial("TDJ")+TB0->TB0_CODOCO)
		While TDJ->( !Eof() ) .AND. xFilial("TDJ")+TB0->TB0_CODOCO == TDJ->TDJ_FILIAL+TDJ->TDJ_CODOCO
			dbSelectArea("TDI")
			dbSetOrder(1)
			dbSeek(xFilial("TDI")+TDJ->TDJ_CODCOM)
			
			dbSelectArea("TC4")
			dbSetOrder(1)
			dbSeek(xFilial("TC4")+TDI->TDI_CODREC+TB0->TB0_CODRES)
			
			cDesFor := ""
			cDesFor := SG280INFD(TDI->TDI_CODREC,"NOME")
			dbSelectArea(cAliasTRB)
			dbSetOrder(1)
			If !dbSeek(TB0->TB0_CODRES+AllTrim(Str(Month(TB0->TB0_DATA)))+TB0->TB0_CODOCO+DTOS(TDI->TDI_DTCOMP)+TDI->TDI_HRCOMP+TDI->TDI_CODREC)
				RecLock(cAliasTRB, .T.)
			Else
				RecLock(cAliasTRB, .F.)
			EndIf
			(cAliasTRB)->CODRES	:= TB0->TB0_CODRES
			(cAliasTRB)->CODOCO	:= TB0->TB0_CODOCO
			(cAliasTRB)->DTOCO	:= TB0->TB0_DATA
			(cAliasTRB)->MES		:= Month(TB0->TB0_DATA)
			(cAliasTRB)->QTDE		+= TB0->TB0_QTDE
			(cAliasTRB)->UNIMED	:= TB0->TB0_UNIMED
			(cAliasTRB)->QTDSAI	+= TDJ->TDJ_PESOUT
			(cAliasTRB)->HRTRAN	:= TDI->TDI_HRCOMP
			(cAliasTRB)->DTTRAN	:= TDI->TDI_DTCOMP
			(cAliasTRB)->FORNEC	:= TDI->TDI_CODREC
			(cAliasTRB)->DESFOR	:= cDesFor
			(cAliasTRB)->NUMLIC	:= TC4->TC4_NUMLIC
			MsUnLock(cAliasTRB)
			TDJ->(dbSkip())
		End
	Else
		dbSelectArea(cAliasTRB)
		dbSetOrder(1)
		If !dbSeek(TB0->TB0_CODRES+AllTrim(Str(Month(TB0->TB0_DATA)))+TB0->TB0_CODOCO)
			RecLock(cAliasTRB, .T.)
		Else
			RecLock(cAliasTRB, .F.)
		EndIf
		(cAliasTRB)->CODRES	:= TB0->TB0_CODRES
		(cAliasTRB)->CODOCO	:= TB0->TB0_CODOCO
		(cAliasTRB)->DTOCO	:= TB0->TB0_DATA
		(cAliasTRB)->MES		:= Month(TB0->TB0_DATA)
		(cAliasTRB)->QTDE		+= TB0->TB0_QTDE
		(cAliasTRB)->UNIMED	:= TB0->TB0_UNIMED
		(cAliasTRB)->QTDSAI	+= 0
		(cAliasTRB)->HRTRAN	:= ""
		(cAliasTRB)->DTTRAN	:= STOD("")
		(cAliasTRB)->FORNEC	:= ""
		(cAliasTRB)->DESFOR	:= ""
		(cAliasTRB)->NUMLIC	:= ""
		MsUnLock(cAliasTRB)		
	EndIf
	TB0->(dbSkip())
End

dbSelectArea(cAliasTRB)
dbGoTop()

If (cAliasTRB)->( Eof() )
	MsgInfo(STR0027,STR0028) //"Não existem dados para montar o relatório!"###"ATENÇÃO"
	lGera := .f.
	Return .F.
Endif

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportPrint³ Autor ³ Rafael Diogo Richter  ³ Data ³12/12/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Chamada do Relatorio.                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±± 
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local i,j,x
Private lFirst := .t.

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf

Processa({|| U_SGR110TMP()}, STR0024, STR0025) //"Aguarde"###"Processando Arquivo..."

If !lGera
	oTempTRB:Delete()
	Return .f.
Endif

dbSelectArea(cAliasTRB)
dbSetOrder(1)
oReport:SetMeter(RecCount())
DbGoTop()

lFirst := .T.
cCodRes := ""
oSection1:Init()
While !Eof() .And. !oReport:Cancel()
	
	oReport:IncMeter()
	
	If lFirst
		oReport:SkipLine()
		lFirst := .F.
	EndIf
	
	If cCodRes <> (cAliasTRB)->CODRES
		oSection1:Cell("(cAliasTRB)->CODRES"):Show()
		oSection1:Cell("B1_DESC"):Show()
		cCodRes := (cAliasTRB)->CODRES
	Else
		oSection1:Cell("(cAliasTRB)->CODRES"):Hide()
		oSection1:Cell("B1_DESC"):Hide()
	EndIf
	oSection1:PrintLine()
	
	dbSelectArea(cAliasTRB)
	dbSkip()
End
oSection1:Finish()

oTempTRB:Delete()

Return .T.
