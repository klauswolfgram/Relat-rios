/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "SGAR080.ch"
#INCLUDE "MSOLE.CH"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SGAR080  ³ Autor ³ Rafael Diogo Richter  ³ Data ³11/01/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Solicitacao da CETESB.                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tabelas   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function SGAR080()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)
Local oDlgPar
Local nOpca := 0
Local aCombEmp	:= {OemToAnsi(STR0001),; //"Não"
				   	 OemToAnsi(STR0002)} //"Sim"
Local aCombImp	:= {OemToAnsi(STR0003),; //"Impressora"
				   	 OemToAnsi(STR0004)} //"Arquivo"
Local lAccsResp	:= IIf( FindFunction( "MDTVldFldAcc" ), MDTVldFldAcc( "QAA_MAT" ), .T. )
Private aMark    := {}
Private oMark, oMarkSoli
Private lInverte:= .f.
Private cMarca  := GetMark()
Private lQuery  := .t.
Private cPerg := "SGR080"
Private cPathWord := GETMV("MV_NGSERVE")
Private cDesc := '', aCodFi := {}
Private oSoli, oResp, oFunc, oCad, oEmp, oData, oImp, oArq
Private cSoli	:= Space(3)
Private cResp	:= IIf( FindFunction( "MDTHideCpo" ), MDTHideCpo( cResp, "QAA_MAT" ), Space(10) )
Private cFunc	:= Space(10)
Private cCad	:= Space(20)
Private cEmp	:= Space(1)
Private dDat	:= dDataBase
Private cImp	:= Space(1)
Private cArq	:= Space(30)
Private aVETINR  := {}
Private lFirstSol := .T., lFirstFin := .T.
Private nSol := 0, aFin := Array(6)

If Substr(cPathWord,len(cPathWord),1) != "\"
	cPathWord += "\"
Endif

Define MsDialog oDlgPar Title OemToAnsi(STR0005) From 009,000 To 390,400 Of oMainWnd Pixel//"Parâmetros"

@ 35,008 Say OemToAnsi(STR0006) Size 50,7 Of oDlgPar Pixel //"Solicitação de?"
@ 35,060 MsGet oSoli Var cSoli Size 055,08 Of oDlgPar Pixel F3 "SGASOL" Picture "@!" When .t. HasButton

@ 50,008 Say OemToAnsi(STR0007) Size 50,7 Of oDlgPar Pixel //"Finalidade?"
@ 48,060 Button STR0008 Of oDlgPar Size 55,12 Pixel Action (U_Sgr080Ma()) //"&Buscar"

@ 65,008 Say OemToAnsi(STR0009) Size 50,7 Of oDlgPar Pixel  //"Responsável?"
@ 65,060 MsGet oResp Var cResp Size 055,08 Of oDlgPar Pixel F3 "QAA" Picture "@!" When lAccsResp HasButton

@ 80,008 Say OemToAnsi(STR0010) Size 50,7 Of oDlgPar Pixel  //"Func. Autorizado?"
@ 80,060 MsGet oFunc Var cFunc Size 055,08 Of oDlgPar Pixel F3 "QAA" Picture "@!" When .t. HasButton

@ 95,008 Say OemToAnsi(STR0011) Size 50,7 Of oDlgPar Pixel //"Cad. na CETESB?"
@ 95,060 MsGet oCad Var cCad Size 055,08 Of oDlgPar Pixel Picture "@!" When .t.

@ 110,008 Say OemToAnsi(STR0012) Size 55,7 Of oDlgPar Pixel //"Emp. Pequeno Porte?"
@ 110,060 ComboBox oEmp Var cEmp Items aCombEmp Size 055,08 Pixel Of oDlgPar

@ 125,008 Say OemToAnsi(STR0013) Size 50,7 Of oDlgPar Pixel //"Data da Vistoria?"
@ 125,060 MsGet oData Var dDat Size 055,08 Of oDlgPar Pixel Picture "@!" When .t. HasButton

@ 140,008 Say OemToAnsi(STR0014) Size 50,7 Of oDlgPar Pixel //"Impressão?"
@ 140,060 ComboBox oEmp Var cImp Items aCombImp Size 055,08 Pixel Of oDlgPar

@ 155,008 Say OemToAnsi(STR0015) Size 50,7 Of oDlgPar Pixel //"Arquivo Saída?"
@ 155,060 MsGet oArq Var cArq Size 055,08 Of oDlgPar Pixel Picture "@!" When .t.

Activate MsDialog oDlgPar On Init EnchoiceBar(oDlgPar,{|| nOpca := 1,oDlgPar:End()},{||oDlgPar:End()}) Centered

If nOpca == 1
	U_Sg080Word()
EndIf

/*
If Pergunte(cPerg,.t.)
	U_Sg080Word()
Endif
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)
Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SGR080MARK³ Autor ³ Rafael Diogo Richter  ³ Data ³11/01/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta um MarkBrowse com as Finalidades do Formulario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tabelas   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         Atualizacoes Sofridas Desde a Construcao Inicial.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Sgr080Ma()
Local oDlg
Local cTitulo := OemToAnsi(STR0016)                                        //"Selecione a(s) Finalidade(s)"
Local nOpc := 0
Local x
Local oDlgMar
Local oTempTRBX
Local nPos := 0
Local cCheck := '', aDesc := {{"001", STR0017},; //"Novo Estabelecimento"
										 {"002", STR0018},; //"Edifício Existente"
										 {"003", STR0019},; //"Ampliação"
										 {"004", STR0020},; //"Novos Equipamentos"
										 {"005", STR0021},;   //"Reforma ou Modificação"
										 {"006", STR0022}} //"Transporte de Lodo"

Private cCod := ''

Define MsDialog oDlg Title cTitulo From 009,000 To 021,055 Of oMainWnd

aDbf := {}
aAdd(aDbf,{ "TRB_OK"       , "C" ,02, 0 })
aAdd(aDBF,{ "TRB_CODIGO"   , "C" ,03, 0 })
aAdd(aDBF,{ "TRB_DESCRI"   , "C" ,45, 0 })

oTempTRBX := FWTemporaryTable():New( "Trbx", aDBF )
oTempTRBX:AddIndex( "1", {"TRB_CODIGO"} )
oTempTRBX:Create()

aMark    := {}

aAdd(aMark,{"TRB_OK"       ,NIL," ",})
aAdd(aMark,{"TRB_DESCRI"   ,NIL,STR0023 ,}) //"Finalidade"

For x := 1 to Len(aDesc)
	RecLock('TRBX',.t.)
	nPos := aScan( aFin, { |y| y == x })
	If lFirstFin == .F. .And. nPos > 0
		TRBX->TRB_OK      := cMarca
	Else
		TRBX->TRB_OK      := cCheck
	EndIf
	TRBX->TRB_CODIGO  := aDesc[x][1]
	TRBX->TRB_DESCRI  := aDesc[x][2]
	MsUnLock('TRBX')
Next x

TRBX->(DbGoTop())

oMark := MsSelect():New("TRBX","TRB_OK",,aMark,@lInverte,@cMarca,{12,0,150,150})
oMark:oBrowse:lHasMark = .f.
oMark:oBrowse:lCanAllMark := .f.
oMark:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT

Activate MsDialog oDlg On Init EnchoiceBar(oDlg,{|| nOpc := 1,oDlg:End()},{||oDlg:End()}) Centered

If nOpc == 1
	aFin := Array(6)
	DbSelectArea("TRBX")
	DbGoTop()
	Do While !Eof()
	   If !Empty(TRBX->TRB_OK)
	   	aFin[TRBX->(Recno())] := TRBX->(Recno())
	   	cCod := TRBX->TRB_CODIGO
	   	aAdd(aCodFi,TRBX->TRB_CODIGO)
	   EndIf
	   DbSkip()
	EndDo
EndIF

oTempTRBX:Delete()
lFirstFin := .F.

Return .T.

User Function Sgr080Mr()
cCod := TRBX->TRB_CODIGO

Return cCod

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SGR080SOLI³ Autor ³ Rafael Diogo Richter  ³ Data ³11/01/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta um MarkBrowse com as solicitacoes da CETESB.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tabelas   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         Atualizacoes Sofridas Desde a Construcao Inicial.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Sgr080li()
Local oDlg
Local cTitulo := OemToAnsi(STR0024)                                        //"Selecione o Formulário de Solicitação"
Local nOpc := 0
Local x
Local oDlgMar
Local oTempTRBY
Local cCheck := '', aDesc := {{"001", STR0025},; //"Certif. Aprov. Dest. Res. Industriais - CADRI"
										 {"002", STR0026},; //"Licenciamento Lei 1817/78"
										 {"003", STR0027},; //"Licença de Instalação - LI"
										 {"004", STR0028},; //"Licença de Operação - LO"
										 {"005", STR0029},; //"Licença Instalação Desmembramento"
										 {"006", STR0030},; //"Licença Operação Desmembramento"
										 {"007", STR0031},; //"Licença Instalaçao Loteamento"
										 {"008", STR0032},; //"Licença Operação Loteamento"
										 {"009", STR0033},; //"Licença Prévia e de Instalação - LP/LI"
										 {"010", STR0034},; //"Licença Prévia"
										 {"011", STR0035},; //"LP/LI Desmembramento"
										 {"012", STR0036},; //"LP/LI de Loteamento"
										 {"013", STR0037},; //"Parecer Técnico: Alteração de Projeto"
										 {"014", STR0038},; //"Parecer Técnico: Decreto 9714/77 - APM"
										 {"015", STR0039},; //"Parecer Técnico: Enquadramento (Lei 1817/78)"
										 {"016", STR0040},; //"Parecer Técnico: GRAPROHAB"
										 {"017", STR0041},; //"Parecer Técnico: Viabilidade de Localização"
										 {"018", STR0042},; //"Parecer Técnico: Outros ____________________"
										 {"019", STR0043}}										  //"Renovação de Licença de Operação"
Public _cTrbyCod_ := ''

Define MsDialog oDlg Title cTitulo From 009,000 To 037,055 Of oMainWnd

aDbf := {}
aAdd(aDbf,{ "TRB_OK"       , "C" ,02, 0 })
aAdd(aDBF,{ "TRB_CODIGO"   , "C" ,03, 0 })
aAdd(aDBF,{ "TRB_DESCRI"   , "C" ,55, 0 })

oTempTRBY := FWTemporaryTable():New( "Trby", aDBF )
oTempTRBY:AddIndex( "1", {"TRB_CODIGO"} )
oTempTRBY:Create()

aMark    := {}

aAdd(aMark,{"TRB_OK"       ,NIL," ",})
aAdd(aMark,{"TRB_DESCRI"   ,NIL,STR0044 ,}) //"Solicitação de"

For x := 1 to Len(aDesc)
	RecLock('TRBY',.t.)
	If lFirstSol == .F. .And. nSol == x
		TRBY->TRB_OK      := cMarca
	Else
		TRBY->TRB_OK      := cCheck
	EndIf
	TRBY->TRB_CODIGO  := aDesc[x][1]
	TRBY->TRB_DESCRI  := aDesc[x][2]
	MsUnLock('TRBY')
Next x

TRBY->(DbGoTop())

oMarkSoli := MsSelect():New("TRBY","TRB_OK",,aMark,@lInverte,@cMarca,{12,0,200,200})
oMarkSoli:oBrowse:lHasMark = .f.
oMarkSoli:oBrowse:lCanAllMark := .f.
oMarkSoli:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
oMarkSoli:bMark := { || U_Sgr080VM1(cMarca) }

Activate MsDialog oDlg On Init EnchoiceBar(oDlg,{|| nOpc := 1,oDlg:End()},{||oDlg:End()}) Centered

If nOpc == 1
	DbSelectArea("TRBY")
	DbGoTop()
	Do While !Eof()
	   If !Empty(TRBY->TRB_OK)
	   	nSol := TRBY->(Recno())
			_cTrbyCod_:=	TRBY->TRB_CODIGO
			cDesc:=		TRBY->TRB_DESCRI
			cSoli:=		TRBY->TRB_CODIGO
	   EndIf
	   DbSkip()
	EndDo
EndIF
oTempTRBY:Delete()
oSoli:Refresh()

lFirstSol := .F.

Return .T.

User Function Sgr080Lr()

Return _cTrbyCod_


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SG080Word ³ Autor ³ Rafael Diogo Richter  ³ Data ³12/01/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera o relatorio de Solicitacao no Word.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tabelas   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         Atualizacoes Sofridas Desde a Construcao Inicial.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Sg080Word()
Local cArqDot  := "cadri.dot"							// Nome do arquivo modelo do Word (Tem que ser .dot)
Local cPathDot := Alltrim(GetMv("MV_DIRACA"))			// Path do arquivo modelo do Word
Local cPathEst := Alltrim(GetMv("MV_DIREST")) 			// PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHOZ
Local cRootPath
Local x

cPathDot += If(Substr(cPathDot,len(cPathDot),1) != "\","\","") + cArqDot
cPathEst += If(Substr(cPathEst,len(cPathEst),1) != "\","\","")

//Cria diretorio se nao existir
MontaDir(cPathEst)

//Se existir .dot na estacao, apaga!
If File( cPathEst + cArqDot )
	Ferase( cPathEst + cArqDot )
EndIf
If !File(cPathDot)
	MsgStop(STR0047+CRLF+STR0048,STR0049) //"O arquivo cadri.dot não foi encontrado no servidor."##"Favor verificar o parâmetro 'MV_DIRACA'."##"ATENÇÃO"
	Return
EndIf
CpyS2T(cPathDot,cPathEst,.T.) 	// Copia do Server para o Remote, e necessario
// para que o wordview e o proprio word possam preparar o arquivo para impressao e
// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
// estacao , por exemplo C:\WORDTMP


lImpress	:= If(cImp == STR0003,.t.,.f.)	//Verifica se a saida sera em Tela ou Impressora //"Impressora"
cArqSaida	:= If(Empty(cArq),"Documento1",AllTrim(cArq))	// Nome do arquivo de saida

oWord := OLE_CreateLink('TMsOleWord97') //Cria link com o Microsoft Word

If lImpress //Impressao via Impressora
	OLE_SetProperty(oWord,oleWdVisible,  .F.)
	OLE_SetProperty(oWord,oleWdPrintBack,.T.)
Else //Impressao em Tela(Arquivo)
	OLE_SetProperty(oWord,oleWdVisible,  .F.)
	OLE_SetProperty(oWord,oleWdPrintBack,.F.)
EndIf

cType := "cadri| *.dot"

OLE_NewFile(oWord,cPathEst + cArqDot) //Abrindo o arquivo modelo automaticamente
/*
If File(cPathWord+"CADRI.dot")
	cRootPath := GetPvProfString(GetEnvServer(),"RootPath","",GetADV97())
	If Subs(cPathWord,1,1) == "\"
		If Rat("\",cRootPath) == Len(Alltrim(cRootPath))
			cRootPath := Substr(cRootPath,1,Len(Alltrim(cRootPath))-1)
		Endif
		cPathWord := cRootPath + cPathWord
	Endif
	OLE_NewFile(oWord,cPathWord+"CADRI.dot") //Abrindo o arquivo modelo automaticamente
Else
	cArquivo := cGetFile(cType,OemToAnsi(STR0045+Subs(cType,1,4)),0,,.T.,GETF_LOCALFLOPPY+GETF_LOCALHARD+GETF_NETWORKDRIVE) //"Selecione arquivo "
	cRootPath := GetPvProfString(GetEnvServer(),"RootPath","",GetADV97())
	If Subs(cArquivo,1,1) == "\"
		If Rat("\",cRootPath) == Len(Alltrim(cRootPath))
			cRootPath := Substr(cRootPath,1,Len(Alltrim(cRootPath))-1)
		Endif
		cArquivo := cRootPath + cArquivo
	Endif
	OLE_NewFile(oWord,cArquivo)
Endif
*/

	cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "ERROR", GetADV97() )
	cRootPath := IF( RIGHT(cRootPath,1) == "\",SubStr(cRootPath,1,Len(cRootPath)-1), cRootPath)

	//Titulo Solicitacao de
	OLE_SetDocumentVar(oWord,"cSolicitacao",cDesc)

	//Finalidade
	OLE_SetDocumentVar(oWord,"chk01","")
	OLE_SetDocumentVar(oWord,"chk02","")
	OLE_SetDocumentVar(oWord,"chk03","")
	OLE_SetDocumentVar(oWord,"chk04","")
	OLE_SetDocumentVar(oWord,"chk05","")
	OLE_SetDocumentVar(oWord,"chk06","")
	For x := 1 to Len(aCodFi)
		If aCodFi[x] == "001"
			OLE_SetDocumentVar(oWord,"chk01","X")
		ElseIf aCodFi[x] == "002"
			OLE_SetDocumentVar(oWord,"chk02","X")
		ElseIf aCodFi[x] == "003"
			OLE_SetDocumentVar(oWord,"chk03","X")
		ElseIf aCodFi[x] == "004"
			OLE_SetDocumentVar(oWord,"chk04","X")
		ElseIf aCodFi[x] == "005"
			OLE_SetDocumentVar(oWord,"chk05","X")
		ElseIf aCodFi[x] == "006"
			OLE_SetDocumentVar(oWord,"chk06","X")
		EndIf
	Next x

	//Data de Entrada
	OLE_SetDocumentVar(oWord,"DataEntrada",DtoC(dDataBase))

	//Dados do Empreendimento
	OLE_SetDocumentVar(oWord,"EmpNome",SM0->M0_NOMECOM)
	OLE_SetDocumentVar(oWord,"EmpCnpj",Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99"))
	OLE_SetDocumentVar(oWord,"EmpInscEst",SM0->M0_INSC)
	OLE_SetDocumentVar(oWord,"EmpCadCetesb",cCad)
	OLE_SetDocumentVar(oWord,"EmpLog",SM0->M0_ENDENT)
	OLE_SetDocumentVar(oWord,"EmpComp",SM0->M0_COMPENT)
	OLE_SetDocumentVar(oWord,"EmpBairro",SM0->M0_BAIRENT)
	OLE_SetDocumentVar(oWord,"EmpCep",SM0->M0_CEPENT)
	OLE_SetDocumentVar(oWord,"EmpMun",SM0->M0_CIDENT)
	OLE_SetDocumentVar(oWord,"EmpFone",SM0->M0_TEL)
	If cEmp == "Não"
		OLE_SetDocumentVar(oWord,"EmpEpp","Não")
	ElseIf cEmp == "Sim"
		OLE_SetDocumentVar(oWord,"EmpEpp","Sim")
	Else
		OLE_SetDocumentVar(oWord,"EmpEpp","")
	EndIf

	//Dados do Responsável e do Usuário Autorizado
	DbSelectArea("QAA")
	DbSetOrder(1)
	If DbSeek(xFilial("QAA")+cResp)
		OLE_SetDocumentVar(oWord,"RespNome",QAA->QAA_NOME)
		OLE_SetDocumentVar(oWord,"RespEmail",QAA->QAA_EMAIL)
		OLE_SetDocumentVar(oWord,"RespRg","Não Disponível")
		OLE_SetDocumentVar(oWord,"RespFone",QAA->QAA_FONE)
	EndIf
	If DbSeek(xFilial("QAA")+cFunc)
		OLE_SetDocumentVar(oWord,"FuncNome",QAA->QAA_NOME)
		OLE_SetDocumentVar(oWord,"FuncRg","Não Disponível")
		OLE_SetDocumentVar(oWord,"FuncEmail",QAA->QAA_EMAIL)
		OLE_SetDocumentVar(oWord,"FuncFone",QAA->QAA_FONE)
	EndIf
	DbSelectArea("QAC")
	DbSetOrder(1)
	If DbSeek(xFilial("QAC")+QAA->QAA_CODFUN)
		OLE_SetDocumentVar(oWord,"FuncCargo",QAC->QAC_DESC)
	EndIf

	//Data da Vistoria
	OLE_SetDocumentVar(oWord,"DataVist",dDat)

   //Data da Declaracao
   OLE_SetDocumentVar(oWord,"DataDec",DtoC(dDataBase))

	OLE_ExecuteMacro(oWord,"Atualiza") //Executa a macro que atualiza os campos do documento
	OLE_ExecuteMacro(oWord,"Begin_Text") //Posiciona o cursor no inicio do documento

	IF lImpress //Impressao via Impressora
		OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord, "ALL",,, 1 )
	Else //Impressao na Tela(Arquivo)
		OLE_SetProperty(oWord,oleWdVisible,.t.)
		OLE_ExecuteMacro(oWord,"Maximiza_Tela")

		If U_DIRR080(cRootPath+"\RELATO\")
			OLE_SaveAsFile(oWord,cRootPath+"\RELATO\"+cArqSaida,,,.f.,oleWdFormatDocument)
		Else
			OLE_SaveAsFile(oWord,cPathEst+cArqSaida,,,.f.,oleWdFormatDocument)
		Endif

		MsgInfo(STR0046)  //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
	EndIf

	OLE_CloseLink(oWord) //Fecha o documento

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Sgr080VM1 ³ Autor ³ Rafael Diogo Richter  ³ Data ³19/01/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera o relatorio de Solicitacao no Word.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tabelas   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaSGA                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         Atualizacoes Sofridas Desde a Construcao Inicial.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Sgr080VM1()
Local cFieldMarca := "TRB_OK"

If IsMark(cFieldMarca,cMarca,lInverte)
   nRecno := Recno()

   DbSelectArea('TRBY')
   DbGotop()
   Do While !Eof()
   	If !Empty( TRBY->TRB_OK )
     	   RecLock('TRBY',.f.)
   	   TRBY->TRB_OK := Space(02)
   	   MsUnLock('TRBY')
   	EndIf
   	Dbskip()
   EndDo

   DbGoTo(nRecno)
	RecLock('TRBY',.f.)
   TRBY->TRB_OK := cMarca
   MsUnLock('TRBY')
   oMarkSoli:oBrowse:Refresh()
EndIf
Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DIRR080  ³ Autor ³Rafael Diogo Richter   ³ Data ³11/07/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se o diretorio existe.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function DIRR080(cCaminho)
Local lDir := .F.

If !Empty(cCaminho) .and. !("\\"$cCaminho)
	cCaminho := alltrim(cCaminho)
	if Right(cCaminho,1) == "\"
		cCaminho := SubStr(cCaminho,1,len(cCaminho)-1)
	Endif
	lDir :=(Ascan( Directory(cCaminho,"D"),{|_Vet | "D" $ _Vet[5] } ) > 0)
EndIf

Return lDir
