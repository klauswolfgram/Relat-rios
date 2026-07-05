/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"
#Include "CTBR015.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR015   ºAutor  ³Microsiga           º Data ³  07/15/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de tipificacao de entidades contabeis            º±±
±±º          ³ - tipificacao                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR015()
Local oCBoxEnt
Local cEntidade	:= Space(25)
Local nX		:= 0
Local nY		:= 0
Local lOkay		:= .F.
Local lTReport	:= TRepInUse()

Private oTp1, oTp2, oTp3, oTp4, oDlg, oSay1, oSay2, oSay3, oSay4
Private cTp1, cTp2, cTp3, cTp4
//Private cFili		:= Space(02)
Private aCBox1		:= { ' ' }
Private aCBox2		:= { STR0010 } //'Nenhuma'
Private aTab		:= { 'CT1', 'CTT', 'CTD', 'CTH' }	// Tabelas selecionaveis;
Private MV_TPO01	:= 0
Private MV_TPO02	:= 0
Private MV_TPO03	:= 0
Private MV_TPO04	:= 0


If !lTReport
	Help("  ",1,"AFR015R4",,STR0011,1,0) //"Função disponível apenas TReport, verificar parametro MV_TREPORT"
	Return
ENdIf

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³Carrega os das talebas no SX2³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( 'SX2' )
dbSetOrder(1)
For nX := 1 To Len( aTab )
	If dbSeek( aTab[nX] )
		aAdd( aCBox1,  aTab[nX] + ' - ' + AllTrim( X2Nome() ) )
	EndIf
Next nX

cEntidade:= aCBox1[1]

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³Monta o conteudo dos combos que serao apresentados para selecao;³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If CTR15CBox( cEntidade )
	DEFINE MSDIALOG oDlg TITLE OemToAnsi( STR0001 ) PIXEL FROM 0, 0 TO 290, 280 //"Parâmetros"
	
	@ 003, 003 SAY OemToAnsi( STR0002 ) OF oDlg PIXEL SIZE 080, 006 COLOR CLR_HBLUE //"Entidade: "
	@ 002, 035 MSCOMBOBOX oCBoxEnt VAR cEntidade ITEMS aCBox1 SIZE 080, 020 OF oDlg PIXEL ON CHANGE ( CTR15CBox( cEntidade ), CTR015TOk( cEntidade, 5 ) )
	
	DEFINE SBUTTON FROM 123, 045 TYPE 1 ACTION ( lOkay := CTR015TOk( cEntidade, 0 ), If( lOkay, oDlg:End(), Nil ) ) OF oDlg ENABLE PIXEL
	DEFINE SBUTTON FROM 123, 085 TYPE 2 ACTION ( oDlg:End() ) OF oDlg ENABLE PIXEL
	
	ACTIVATE DIALOG oDlg CENTERED
	
	If lOkay
		
		Do Case
			Case aTab[ Ascan( aTab, Left( cEntidade, 3 ) ) ] == 'CT1' // Entidade Plano de Contas
				Ctbr010(lTReport)
			Case aTab[ Ascan( aTab, Left( cEntidade, 3 ) ) ] == 'CTT' // Entidade Centro de Custo
				CTBR020(lTReport)
			Case aTab[ Ascan( aTab, Left( cEntidade, 3 ) ) ] == 'CTD' // Entidade Item contabil
				Ctbr030(lTReport)
			Case aTab[ Ascan( aTab, Left( cEntidade, 3 ) ) ] == 'CTH' // Entidade Classe de Valor
				Ctbr090()
		EndCase
	EndIf
EndIf
Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR015   ºAutor  ³Microsiga           º Data ³  07/15/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta e remonta o conteudo dos combos que serao apresentadosº±±
±±º          ³  para selecao                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTR15CBox( cEntidade )
Local aArea		:= GetArea()
Local aRet		:= { STR0010 } //'Nenhuma'
Local nX 		:= 0
Local nY		:= 0

//*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//*³Atraves da entidade, faz a busca no X3 verificando se os campos estao em uso, assim, adicionando-os no array de montagem dos combos;³
//*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Ascan( aTab, Left( cEntidade, 3 ) ) > 0
	
	SX3->( dbSetOrder(1) )
	SX3->( dbSeek( aTab[ Ascan( aTab, Left( cEntidade, 3 ) ) ] ) )
	While SX3->( !Eof() ) .And. SX3->X3_ARQUIVO == aTab[ Ascan( aTab, Left( cEntidade, 3 ) ) ]
		If X3Uso( SX3->X3_USADO ) .And. cNivel >= SX3->X3_NIVEL .And. Right( AllTrim( SX3->X3_CAMPO ), 5 ) $ Alltrim( 'TPO01|TPO02|TPO03|TPO04' )
			aAdd( aRet,  AllTrim( X3Titulo() ) )
		Endif
		SX3->( dbSkip() )
	Enddo
EndIf


//*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//*³Alimenta e realimenta o array responsavel pelo combobox³
//*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCBox2 := aClone( aRet )

//*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//*³Elimina da memoria a instancia dos objetos³
//*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ValType( oTp1 ) == 'O'
	FreeObj( oTp1 )
	FreeObj( oSay1 )
	cTp1 := ''
EndIf

If ValType( oTp2 ) == 'O'
	FreeObj( oTp2 )
	FreeObj( oSay2 )
	cTp2 := ''
EndIf

If ValType( oTp3 ) == 'O'
	FreeObj( oTp3 )
	FreeObj( oSay3 )
	cTp3 := ''
EndIf

If ValType( oTp4 ) == 'O'
	FreeObj( oTp4 )
	FreeObj( oSay4 )
	cTp4 := ''
EndIf

//*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//*³Recria os objetos de combobox com os novos conteudos³
//*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To Len( aCBox2 )
	If Alltrim(Upper(aCBox2[nx])) <> Alltrim(Upper(STR0010)) //'Nenhuma'
		nY++
		If nY == 1
			@ 043, 003 SAY oSay1 PROMPT OemToAnsi( STR0003 ) OF oDlg PIXEL SIZE 080,006 //"Coluna 1: "
			@ 042, 035 MSCOMBOBOX oTp1 VAR cTp1 ITEMS aCBox2 SIZE 045, 20 OF oDlg PIXEL Valid CTR015TOk( cEntidade, 1 )
		ElseIf nY == 2
			@ 063, 003 SAY oSay2 PROMPT OemToAnsi( STR0004 ) OF oDlg PIXEL SIZE 080,006//"Coluna 2: "
			@ 062, 035 MSCOMBOBOX oTp2 VAR cTp2 ITEMS aCBox2 SIZE 045, 20 OF oDlg PIXEL Valid CTR015TOk( cEntidade, 2 )
		ElseIf nY == 3
			@ 083, 003 SAY oSay3 PROMPT OemToAnsi( STR0005 ) OF oDlg PIXEL SIZE 080,006//"Coluna 3: "
			@ 082, 035 MSCOMBOBOX oTp3 VAR cTp3 ITEMS aCBox2 SIZE 045, 20 OF oDlg PIXEL Valid CTR015TOk( cEntidade, 3 )
		ElseIf nY == 4
			@ 103, 003 SAY oSay4 PROMPT OemToAnsi( STR0006 ) OF oDlg PIXEL SIZE 080,006 //"Coluna 4: "
			@ 102, 035 MSCOMBOBOX oTp4 VAR cTp4 ITEMS aCBox2 SIZE 045, 20 OF oDlg PIXEL Valid CTR015TOk( cEntidade, 4 )
		EndIf
	EndIf
Next nX

//*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//*³Forca a atualizacao dos objetos³
//*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ValType( oTp1 ) == 'O'
	oTp1:Disable(); oTp1:Refresh(); oTp1:Enable(); oTp1:Refresh()
	oSay1:Disable(); oSay1:Refresh(); oSay1:Enable(); oSay1:Refresh()
EndIf

If ValType( oTp2 ) == 'O'
	oTp2:Disable(); oTp2:Refresh(); oTp2:Enable(); oTp2:Refresh()
	oSay2:Disable(); oSay2:Refresh(); oSay2:Enable(); oSay2:Refresh()
EndIf

If ValType( oTp3 ) == 'O'
	oTp3:Disable(); oTp3:Refresh(); oTp3:Enable(); oTp3:Refresh()
	oSay3:Disable(); oSay3:Refresh(); oSay3:Enable(); oSay3:Refresh()
EndIf

If ValType( oTp4 ) == 'O'
	oTp4:Disable(); oTp4:Refresh(); oTp4:Enable(); oTp4:Refresh()
	oSay4:Disable(); oSay4:Refresh(); oSay4:Enable(); oSay4:Refresh()
EndIf


RestArea( aArea )

Return( .T. )



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR015   ºAutor  ³Microsiga           º Data ³  07/15/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de verificacao 									  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTR015TOk( cEntidade, nType )
Local lRet	:= .T.

If EmpTy( cEntidade )
	Aviso( STR0007, STR0008, { "Ok" }, 2 )//"Atencao!"##"Primeiro selecione a entidade"
	lRet := .F.
EndIf

If nType > 0
	If lRet
		If nType == 1
			If Alltrim(Upper(cTp1)) <> Alltrim(Upper(STR0010)) .And. ( cTp1 == cTp2 .Or. cTp1 == cTp3 .Or. cTp1 == cTp4 ) //'Nenhuma'
				Aviso( STR0007, STR0009, { "Ok" }, 2 )//"Atencao!"// "Conteúdo já selecionado, por favor, selecione outro tipo"
				lRet := .F.
			ElseIf  Alltrim(Upper(cTp1)) <> Alltrim(Upper(STR0010))//'Nenhuma'
				MV_TPO01 := Val( Right( cTp1, 1 ) )
			EndIf
		ElseIf nType == 2
			If Alltrim(Upper(cTp2)) <> Alltrim(Upper(STR0010)) .And. ( cTp2 == cTp1 .Or. cTp2 == cTp3 .Or. cTp2 == cTp4 )
				Aviso( STR0007, STR0010, { "Ok" }, 2 )//"Atencao!"//"Conteúdo já selecionado, por favor, selecione outro tipo"
				lRet := .F.
			ElseIf  Alltrim(Upper(cTp2)) <> Alltrim(Upper(STR0010))//'Nenhuma'
				MV_TPO02 := Val( Right( cTp2, 1 ) )
			EndIf
		ElseIf nType == 3
			If Alltrim(Upper(cTp3)) <> Alltrim(Upper(STR0010)) .And. ( cTp3 == cTp1 .Or. cTp3 == cTp2 .Or. cTp3 == cTp4 )
				Aviso( STR0007, STR0009, { "Ok" }, 2 )//"Atencao!"//"Conteúdo já selecionado, por favor, selecione outro tipo"
				lRet := .F.
			ElseIf  cTp3 <> STR0010//'Nenhuma'
				MV_TPO03 := Val( Right( cTp3, 1 ) )
			EndIf
		ElseIf nType == 4
			If Alltrim(Upper(cTp4)) <> Alltrim(Upper(STR0010)) .And. ( cTp4 == cTp1 .Or. cTp4 == cTp2 .Or. cTp4 == cTp3 )
				Aviso( STR0007 , STR0009, { "Ok" }, 2 )//"Atencao!"//"Conteúdo já selecionado, por favor, selecione outro tipo"
				lRet := .F.
			ElseIf  cTp4 <> STR0010 //'Nenhuma'
				MV_TPO04 := Val( Right( cTp4, 1 ) )
			EndIf
		EndIf
	EndIf
	
	//*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//*³Ajusta os MV_TPO's para futura impressao³
	//*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( Empty( cTp1 ) .Or. Alltrim(Upper(cTp1)) == Alltrim(Upper(STR0010)) ) .And. MV_TPO01 > 0
		MV_TPO01 := 0
	EndIf
	
	If ( Empty( cTp2 ) .Or. Alltrim(Upper(cTp2)) == Alltrim(Upper(STR0010)) ) .And. MV_TPO02 > 0
		MV_TPO02 := 0
	EndIf
	
	If ( Empty( cTp3 ) .Or. Alltrim(Upper(cTp3)) == Alltrim(Upper(STR0010)) ) .And. MV_TPO03 > 0
		MV_TPO03 := 0
	EndIf
	
	If ( Empty( cTp4 ) .Or. Alltrim(Upper(cTp4)) == Alltrim(Upper(STR0010)) ) .And. MV_TPO04 > 0
		MV_TPO04 := 0
	EndIf
Else
	If Empty(MV_TPO01) .And. Empty(MV_TPO02) .And. Empty(MV_TPO03) .And. Empty(MV_TPO04)
		Aviso( STR0007, STR0012, { "Ok" }, 2 )//"Atencao!"// "Os campos de tipificação não estão usado, por favor verifique dicionário de dados"
		lRet := .F.
	EndIf
EndIf    

Return( lRet )
