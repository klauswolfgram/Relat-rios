/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr572.ch"
#INCLUDE "MSOLE.CH"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR572
Relatorio do LTCAT

@author Denis Hyroshi de Souza
@since 08/04/2003

@return .T.
/*/
//---------------------------------------------------------------------
User Function MDTR572()

Local aNGBEGINPRM := NGBEGINPRM( )

Local cF3CC := "MDTPS4"  //SI3 apenas do cliente

Private lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
Private lMdtUmCC   := lMDT190UMCC()
Private aNfrisco   := {}
Private nSizeSI3   := IIf(( TAMSX3( "I3_CUSTO" ) [1] ) < 1, 9, ( TAMSX3( "I3_CUSTO" ) [1] ) )
Private cAliasCC   := "SI3"
Private cPerg      := "MDT572    "

Private lMdtUnix := IIf( GetRemoteType() == 2 .Or. isSRVunix(), .T., .F. ) //Verifica se servidor ou estacao é Linux

SG90PLACAO()//Adequação do Plano de Ação

If Alltrim( GETMV( "MV_MCONTAB" ) ) == "CTB"
	cAliasCC := "CTT"
	cF3CC    := "MDTPS6"  //CTT apenas do cliente
EndIf

If !MDT210UPD()//Verifica Aplicacao de Update
	NGRETURNPRM( aNGBEGINPRM )
	Return .F.
EndIf

cCliMdtps := ""

nTa1  := IIf( (TAMSX3( "A1_COD" ) [1] ) < 1, 6, ( TAMSX3( "A1_COD" ) [1] ) )
nTa1L := IIf( (TAMSX3( "A1_LOJA" ) [1] ) < 1, 2, ( TAMSX3( "A1_LOJA" ) [1] ) )
nSizeTD := nTa1+nTa1L


//------------------------------------------------------------------------
/*/ Perguntas MDT572
mv_par01   Laudo ?
mv_par02   Impressao ?
mv_par03   Arquivo Saida ?
mv_par04   Ordenar Riscos por: ?
					1 - Num. Risco
                    2 - Agente de Risco
					3 - Fonte Geradora
				  	4 - Centro de Custo
				  	5 - Funcao
mv_par05    Ordenar Equipamentos por: ?
					1 - Codigo
                    2 - Nome
mv_par06    Ordenar Plano de Ação por: ?
					1 - Código do Plano
                    2 - Centro de Custo
				   	3 - Func. Responsável
mv_par07    Centro de Custo?   * Opcional
/*/
//------------------------------------------------------------------------

If Pergunte( cPerg, .T. )
	RptStatus( {|lEnd| U_FIMP572()} )
EndIf

NGRETURNPRM( aNGBEGINPRM )

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_FIMP572()
Impressão do Relatório

@type Function
@author  Denis Hyroshi de Souza
@since   08/04/2003
@sample  U_FIMP572()
@return Lógico - Retorna verdadeiro caso validação esteja correta
/*/
//-------------------------------------------------------------------
User Function FIMP572()

Local cMemo   := " "
Local cTitulo := " "
Local cTexto  := " "
Local lEof    := .T.
Local strDia
Local strMes
Local strAno

Local cArqDot   := "ltcat.dot"
Local cPathDot  := Alltrim( GetMv( "MV_DIRACA" ) )
Local cBarraRem := "\"
Local cBarraSrv := "\"

Local cSMCOD := IIf( FindFunction( "FWGrpCompany" ), FWGrpCompany(), SM0->M0_CODIGO )
Local cSMFIL := IIf( FindFunction( "FWCodFil" ), FWCodFil(), SM0->M0_CODFIL )

Private cPathEst := Alltrim( GetMv( "MV_DIREST" ) )
Private cArqBmp  := "LGRL"+cSMCOD+cSMFIL+".BMP"
Private cArqBmp2 := "LGRL"+cSMCOD+".BMP"
Private cPathBmp := Alltrim( GetMv( "MV_DIRACA" ) )
Private cPathBm2 := cPathBmp

If lSigaMdtPS
	cArqBmp  := "LGRL"+mv_par01+mv_par02+".bmp"
	cArqBmp2 := "LGRL"+mv_par01+".bmp"
EndIf

If GetRemoteType() == 2  //Estação com sistema operacional unix
	cBarraRem := "/"
EndIf
If isSRVunix()  //Servidor da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
	cBarraSrv := "/"
EndIf

cPathDot += IIf( Substr( cPathDot, len( cPathDot ), 1 ) <> cBarraSrv, cBarraSrv, "" ) + cArqDot
cPathEst += IIf( Substr( cPathEst, len( cPathEst ), 1 ) <> cBarraRem, cBarraRem, "" )

cPathBmp += IIf( Substr( cPathBmp, len( cPathBmp ), 1 ) <> cBarraSrv, cBarraSrv, "" ) + cArqBmp
cPathBm2 += IIf( Substr( cPathBm2, len( cPathBm2 ), 1 ) <> cBarraSrv, cBarraSrv, "" ) + cArqBmp2

//Cria diretorio se não existir
MontaDir( cPathEst )

//Se existir .dot na estação, apaga!
If File( cPathEst + cArqDot )
	Ferase( cPathEst + cArqDot )
EndIf
If !File( cPathDot )
	MsgStop( STR0035 + chr( 10 ) + STR0036, STR0037 ) //"O arquivo ltcat.dot não foi encontrado no servidor."###"Verificar parâmetro 'MV_DIRACA'."###"ATENÇÃO"
	Return
EndIf

CpyS2T( cPathDot, cPathEst, .T. ) 	//Copia o DOT que esta no ROOTPATH Protheus para o PATH da estação

//Se existir .bmp na estação, apaga!
If File( cPathBmp )

	If File( cPathEst + cArqBmp )
		Ferase( cPathEst + cArqBmp )
	EndIf
	__copyfile( cPathBmp, cPathEst + cArqBmp )

ElseIf File( cPathBm2 )

	If File( cPathEst + cArqBmp2 )
		Ferase( cPathEst + cArqBmp2 )
	EndIf
	__copyfile( cPathBm2, cPathEst + cArqBmp2 )
	cArqBmp := cArqBmp2

EndIf

Private cVar   := "cVAR"
Private cVar1  := "cTIT"
Private cAlias := "SI3"
Private cDescr := "SI3->I3_DESC"
Private nVar   := 1
Private nVar1  := 1
Private lPrint := .T.
Private lPrin2 := .T.
Private lIdentar    := .F.
Private lMV_NGMDTPS := .F.
Private aTN0Combo := MDTCbox( "TN0_INDEXP", " ", 1 )

aStrMes := { STR0001, STR0002, STR0003, STR0004, STR0005, STR0006, STR0007, STR0008, STR0009, STR0010, STR0011, STR0012 } //"Janeiro"###"Fevereiro"###"Março"###"Abril"###"Maio"###"Junho"###"Julho"###"Agosto"###"Setembro"###"Outubro"###"Novembro"###"Dezembro"

If Alltrim( GETMV( "MV_MCONTAB" ) ) == "CTB"
	cAlias := "CTT"
	cDescr := "CTT->CTT_DESC01"
EndIf

If SuperGetMv( "MV_NGMDTPS", .F., "N" ) == "S"
	lMV_NGMDTPS := .T.
EndIf

Dbselectarea( "TO0" )
Dbsetorder(1)
If Dbseek(xFilial("TO0")+mv_par01)

	lImpress	:= If(mv_par02 == 1,.T.,.F.)	//Verifica se a saida sera em Tela ou Impressora
	cArqSaida	:= If(Empty(mv_par03),"Documento1",AllTrim(mv_par03))	// Nome do arquivo de saida

	oWord := OLE_CreateLink('TMsOleWord97')//Cria link como Word

	If lImpress //Impressao via Impressora
		OLE_SetProperty(oWord,oleWdVisible,  .F.)
		OLE_SetProperty(oWord,oleWdPrintBack,.T.)
	Else //Impressao na Tela(Arquivo)
		OLE_SetProperty(oWord,oleWdVisible,  .F.)
		OLE_SetProperty(oWord,oleWdPrintBack,.F.)
	EndIf
	cType := "ltcat| *.dot"
	OLE_NewFile(oWord,cPathEst + cArqDot) //Abrindo o arquivo modelo automaticamente

	//Imprime Logo
	cFileLogo := cPathEst + cArqBmp
	If !lMdtUnix //Se for windows
		If File(cFileLogo)
			OLE_SetDocumentVar(oWord,"Cria_Var",cFileLogo)
			OLE_ExecuteMacro(oWord,"Insere_logo")
		EndIf
	EndIf

	dbSelectArea("SM0")
	dbSeek(cSMCOD+cSMFIL)

	cCid := Alltrim(SM0->M0_CIDCOB)
	cCidade   := Alltrim(SM0->M0_CIDCOB)+If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")
	cEmp_Nome := SM0->M0_NOMECOM
	cEmp_Cnpj := SM0->M0_CGC
	cEmp_Endr := Alltrim(SM0->M0_ENDCOB)+space(5)+cCidade
	cEmp_Insc := SM0->M0_INSC
	If lMV_NGMDTPS  //Se for Prestador de Servico
		Dbselectarea("SA1")
		Dbsetorder(1)
		If Dbseek(xFilial("SA1")+TO0->TO0_CLIENT)
			cCidade   := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
			cEmp_Nome := SA1->A1_NOME
			cEmp_Cnpj := SA1->A1_CGC
			cEmp_Endr := Alltrim(SA1->A1_END)+space(5)+cCidade
			cEmp_Insc := SA1->A1_INSCR
		EndIf
	EndIf

	//Dados Empresa
	OLE_SetDocumentVar(oWord,"Emp_Nome",cEmp_Nome)
	OLE_SetDocumentVar(oWord,"Emp_Local",cEmp_Endr)
	OLE_SetDocumentVar(oWord,"Emp_cnpj",Transform(cEmp_Cnpj,"@!R NN.NNN.NNN/NNNN-99"))
	OLE_SetDocumentVar(oWord,"Emp_ie",cEmp_Insc)
	If lMdtUmCC
		Dbselectarea(cAlias)
		Dbsetorder(1)
		If Dbseek(xFilial(cAlias)+mv_par07) .And. !Empty(mv_par07)
			OLE_SetDocumentVar(oWord,"CapaCC",&(cDescr))
		EndIf
	EndIf

	//Objetivo do Laudo
	OLE_SetDocumentVar(oWord,"Lau_Obje",Alltrim(TO0->TO0_OBJETI)+" ")

	OLE_ExecuteMacro(oWord,"Somalinha")

	cMemo := Alltrim(TO0->TO0_DESCRI)
	If NGCADICBASE("TO0_MMSYP2","A","TO0",.F.)
		If !Empty(TO0->TO0_MMSYP2)
			cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
			If !Empty(cMMSYP2)
				If !Empty(cMemo)
					cMemo += Chr(13)+Chr(10)
				EndIf
				cMemo += cMMSYP2
			EndIf
		EndIf
	ElseIf NGCADICBASE("TO0_DESC2","A","TO0",.F.)
		If !Empty(TO0->TO0_DESC2)
			If !Empty(cMemo)
				cMemo += Chr(13)+Chr(10)
			EndIf
			cMemo += Alltrim(TO0->TO0_DESC2)
		EndIf
	EndIf

	SetRegua(100)
	nLenMemo := Len(cMemo)
	nPerMemo := 0
	While lEof
		OLE_ExecuteMacro(oWord,"Atualiza")

		If Empty(cMemo)  //Memo vazio
			lEof := .F.
			Exit
		Else
			nPos1 := At("#",cMemo) //Inicio de um Titulo
			fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
			If nPos1 > 1
				cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
				cMemo  := Alltrim(Substr(cMemo,nPos1))
				U_IMPTXT572(Alltrim(cTexto))
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
					lEof   := .F.
				EndIf
			Else //Nao existe #
				//IMPRIME TEXTO
				U_IMPTXT572(Alltrim(cMemo))
				lEof := .F.
				Exit
			EndIf


			//IMPRIME TITULO
			If !Empty(cTitulo)
				U_IMPCAB572(cTitulo)
			EndIf

			//IMPRIME TEXTO
			If !Empty(cTexto)
				lPrint := .T.
				lPrin2 := .T.
				U_IMPTXT572(Alltrim(cTexto))
			EndIf

		EndIf
		fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
	End

	Dbselectarea("TMK")
	Dbsetorder(1)
	Dbseek(xFilial("TMK")+TO0->TO0_CODUSU)

	strDia := Alltrim(Str(Day(Date())))
	strMes := aStrMes[Month(Date())]
	strAno := Alltrim(Str(Year(Date())))
	cCid += ", "+strDia+STR0038+strMes+STR0038+strAno //" de "###" de "
	OLE_ExecuteMacro(oWord,"Somalinha")
	U_IMPCAB572(cCid,.T.)
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Somalinha")
	U_IMPCAB572("{C}"+"___________________________________",.T.)
	U_IMPCAB572("{C}"+Alltrim(TMK->TMK_NOMUSU),.T.)
	U_IMPCAB572("{C}"+STR0039,.T.) //"Eng. Segurança do Trabalho"
	U_IMPCAB572("{C}"+Alltrim(TMK->TMK_ENTCLA)+": "+Alltrim(TMK->TMK_NUMENT),.T.)

	OLE_SetDocumentVar(oWord,"Tabela",Space(1))   //Limpa campo oculto do documento
	OLE_SetDocumentVar(oWord,"Linhas",Space(1))   //Limpa campo oculto do documento
	OLE_SetDocumentVar(oWord,"Cria_Var",Space(1)) //Limpa campo oculto do documento
	OLE_ExecuteMacro(oWord,"Atualiza") //Executa a macro que atualiza os campos do documento
	OLE_ExecuteMacro(oWord,"Begin_Text") //Posiciona o cursor no inicio do documento

	IF lImpress //Impressao via Impressora
		OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord, "ALL",,, 1 )
	Else //Impressao na Tela(Arquivo)
		OLE_SetProperty(oWord,oleWdVisible,.T.)
		OLE_ExecuteMacro(oWord,"Maximiza_Tela")
		If !lMdtUnix //Se for windows
			If U_DIRR572(cPathEst)
				OLE_SaveAsFile(oWord,cPathEst+cArqSaida,,,.F.,oleWdFormatDocument)
			EndIf
		EndIf
		MsgInfo(STR0013) //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
	EndIf
	OLE_CloseFile(oWord) //Fecha o documento
	OLE_CloseLink(oWord) //Fecha o documento
EndIf

Return .T.
//-------------------------------------------------------------------
/*/{Protheus.doc} U_DIRR572()
erifica se o diretorio existe.

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_DIRR572(cCaminho)
@param cCaminho, caracter

@return lDir, lógico
/*/
//-------------------------------------------------------------------
User Function DIRR572(cCaminho)

Local lDir := .F.
Local cBARRAS   := If(isSRVunix(),"/","\")
Local cBARRAD := If(isSRVunix(),"//","\\")

If !empty(cCaminho) .And. !(cBARRAD$cCaminho)
	cCaminho := alltrim(cCaminho)
	if Right(cCaminho,1) == cBARRAS
		cCaminho := SubStr(cCaminho,1,len(cCaminho)-1)
	EndIf
	lDir :=(Ascan( Directory(cCaminho,"D"),{|_Vet | "D" $ _Vet[5] } ) > 0)
EndIf
Return lDir

//-------------------------------------------------------------------
/*/{Protheus.doc} U_IMPTXT572()
Imprime o conteúdo do texto.

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_IMPTXT572(_cTexto)
@param _cTexto, caracter

@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function IMPTXT572(_cTexto)

Local lTexto := .T.
Local nPosTxt := 0
Local nArroba
Local cTitExe
Local cTextoNew := _cTexto
Local cTxtMemo := _cTexto

//Imprime texto

While lTexto
	nArroba := At("@",cTxtMemo)

	If nArroba > 1
		cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
		cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))
		U_IMPTXT572(Alltrim(cTextoNew))
		Loop
	ElseIf nArroba == 1 //Existe @
		cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))
		nArroba  := At("@",cTxtMemo)
		cTitExe  := Alltrim(Substr(cTxtMemo,1,nArroba-1))
		U_EXEC572TIT(cTitExe)
		cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))

		nArroba   := At("@",cTxtMemo)
		If nArroba > 0
			cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
			cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))
			U_IMPTXT572(Alltrim(cTextoNew))
			Loop
		EndIf
	EndIf

	If (nPosTxt := At(Chr(13)+Chr(10),cTxtMemo)) == 0
		lTexto := .F.
		cTextoNew :=  Alltrim(cTxtMemo)
	Else
		cTextoNew :=  Alltrim(Substr(cTxtMemo,1,nPosTxt-1))
		cTxtMemo  :=  Alltrim(Substr(cTxtMemo,nPosTxt+2))
	EndIf

	If !Empty(cTextoNew)
		cVar1 := "cTXT"+Strzero(nVar1,6)
		OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
		nVar1++

		If lPrint
			OLE_ExecuteMacro(oWord,"Somalinha")
			lPrint := .F.
		EndIf
		If lPrin2
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
		lPrin2 := .T.

		OLE_ExecuteMacro(oWord,"Cria_Texto")
		If lIdentar
			OLE_ExecuteMacro(oWord,"Identar")
		EndIf
		OLE_ExecuteMacro(oWord,"Sem_Negrito")
		OLE_SetDocumentVar(oWord,cVar1,cTextoNew)
	Else
		OLE_ExecuteMacro(oWord,"Identar")
	EndIf
End
Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_IMPCAB572()
Imprime o título do texto.

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_IMPCAB572(_cTit,lJump)
@param _cTit, caracter
@param lJump, lógico

@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function IMPCAB572(_cTit,lJump)

Local nPosTemp
Local _cTitulo := _cTit
Local cCNS := " "

cVar := "cTIT"+Strzero(nVar,6)
nVar++
OLE_SetDocumentVar(oWord,"Cria_Var",cVar)
If !lJump
	OLE_ExecuteMacro(oWord,"Somalinha")
EndIf
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Titulo")

If ("{" $ _cTitulo) .And.  ("}" $ _cTitulo)
	nPosTemp := At("}",_cTitulo)
	cCNS     := Substr(_cTitulo,1,nPosTemp)
	_cTitulo := Substr(_cTitulo,nPosTemp+1)
EndIf

If ("N" $ Upper(cCNS)) //N=Negrito
	OLE_ExecuteMacro(oWord,"Com_Negrito")
Else
	OLE_ExecuteMacro(oWord,"Sem_Negrito")
EndIf

If ("C" $ Upper(cCNS)) //C=Centralizar
	OLE_ExecuteMacro(oWord,"Centralizar")
Else
	OLE_ExecuteMacro(oWord,"Justificar")
EndIf

If ("S" $ Upper(cCNS)) //S=Sublinhar
	OLE_ExecuteMacro(oWord,"Com_Sublinhar")
Else
	OLE_ExecuteMacro(oWord,"Sem_Sublinhar")
EndIf

OLE_SetDocumentVar(oWord,cVar,_cTitulo)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_EXEC572TIT()
Imprime a tabela relacionada ao título.

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_EXEC572TIT("TN6")
@param _cTitExe, caracter
@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function EXEC572TIT(_cTitExe)

Local cTitExe := _cTitExe
Local nTipo   := 1
Local cTitTemp
Local nPos1

cTitTemp := _cTitExe
nPos1    := At("!",cTitTemp)
If nPos1 > 0
	cTitTemp := Alltrim(Substr(cTitTemp,nPos1+1))
	nPos1    := At("!",cTitTemp)
	If nPos1 > 0
		cTitTemp := Substr(cTitTemp,1,nPos1-1)
		nTipo := 2
	EndIf
EndIf

If nTipo == 1
	cTitTemp := _cTitExe
	nPos1    := At("%",cTitTemp)
	If nPos1 > 0
		cTitTemp := Alltrim(Substr(cTitTemp,nPos1+1))
		nPos1    := At("%",cTitTemp)
		If nPos1 > 0
			cTitTemp := Substr(cTitTemp,1,nPos1-1)
			nTipo := 3
		EndIf
	EndIf
EndIf

Begin Sequence

	If ExistBlock("MDTR8501") //Ponto de Entrada para executar atalhos customizados
		aRetPE := ExecBlock('MDTR8501',.F.,.F., {'4', 1, cTitExe})
		If ValType(aRetPE) == "A"
			nPosPE := aScan(aRetPE, {|x| Alltrim(x[1]) == Alltrim(cTitExe) .And. Alltrim(cTitExe) == Alltrim(x[1]) })
			If nPosPE > 0
				&(aRetPE[nPosPE,2])
				Break
			EndIf
		EndIf
	EndIf

	If nTipo == 2
		A572IMAGEM(cTitTemp)
	ElseIf nTipo == 3
		A572ARQUIVO(cTitTemp)
	ElseIf "LOCAIS" $ Upper(cTitExe) .Or. "LOCAL" $ Upper(cTitExe)
		U_A572LOCAL()
	ElseIf "RISCOS E ATIVIDADES" $ Upper(cTitExe)
		U_A572RISCO(2)
	ElseIf "RISCO" $ Upper(cTitExe)
		U_A572RISCO(1)
	ElseIf "QUADRO FUNCIONARIOS" $ Upper(cTitExe)
		U_A572QUADFUN()
	ElseIf "EQUIPAMENTO" $ Upper(cTitExe)
		U_A572EQUIP()
	ElseIf "CONTROLE" $ Upper(cTitExe)
		U_A572CONTR()
	ElseIf "EPI" $ Upper(cTitExe)
		U_A572EPIS()
	ElseIf "PLANO DE ACAO" $ Upper(cTitExe)
		U_A572PLANO()
	ElseIf "PAGINA"	$ Upper(cTitExe)
	  	OLE_ExecuteMacro(oWord,"NewPage")
	EndIf

End Sequence

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_A572LOCAL()
Verifica quais são os locais do laudo e chama a função que os imprime.

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_A572LOCAL()

@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function A572LOCAL()

Dbselectarea("TO5")
Dbsetorder(01)
Dbseek(xFilial("TO5")+TO0->TO0_LAUDO)
While !eof() .And. xFilial("TO5")+TO0->TO0_LAUDO == TO5->TO5_FILIAL+TO5->TO5_LAUDO

	Dbselectarea("TNE")
	Dbsetorder(1)
	If Dbseek(xFilial("TNE")+TO5->TO5_CODAMB)
		U_LOCAL572()
	EndIf
	Dbselectarea("TO5")
	Dbskip()

EndDo

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_A572RISCO()
Verifica quais são os riscos do laudo e chama a função que os imprime.

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_A572RISCO(1)
@param nOpcaoRisco, numérico
@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function A572RISCO(nOpcaoRisco)

Default nOpcaoRisco := 1

If lSigaMdtPS

	If mv_par06 == 1

		Dbselectarea("TO1")
		Dbsetorder(01)
		Dbseek(xFilial("TO1")+TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TO1")+TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO
			Dbselectarea("TN0")
			Dbsetorder(1)
			If Dbseek(xFilial("TN0")+TO1->TO1_NUMRIS)
				Dbselectarea("TMA")
				Dbsetorder(1)
				If Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)
		  			U_Ris572(nOpcaoRisco)
				EndIf
			EndIf
			Dbselectarea("TO1")
			Dbskip()
		End

	Else

		Dbselectarea("TN0")
		Do Case
			Case mv_par06 == 2
				Dbsetorder(2)	//"Cód. Agente de risco"
			Case mv_par06 == 3
				Dbsetorder(3)	//"Cód. Fonte geradora"
		 	Case mv_par06 == 4
		 		Dbsetorder(5)	//"Cód. Centro de custo"
			Case mv_par06 == 5
				Dbsetorder(7)	//"Cód. Função"
		EndCase

		Dbseek(xFilial("TN0"))
		While xFilial("TN0") == TN0->TN0_FILIAL .And. !EOF()

		    Dbselectarea("TO1")
			Dbsetorder(01)
			If !Dbseek(xFilial("TO1")+TO0->TO0_LAUDO+TN0->TN0_NUMRIS)
				DbselectArea("TN0") ; DbSkip() ; Loop
			EndIf

			Dbselectarea("TMA")
			Dbsetorder(1)
			If !Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)
				DbselectArea("TN0") ; DbSkip() ; Loop
			EndIf

			U_Ris572(nOpcaoRisco)

			DbselectArea("TN0") ; DbSkip()
		EndDo

	EndIf

Else

	If mv_par04 == 1

		Dbselectarea("TO1")
		Dbsetorder(01)
		Dbseek(xFilial("TO1")+TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TO1")+TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO
			Dbselectarea("TN0")
			Dbsetorder(1)
			If Dbseek(xFilial("TN0")+TO1->TO1_NUMRIS)
				Dbselectarea("TMA")
				Dbsetorder(1)
				If Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)
		  			U_Ris572(nOpcaoRisco)
				EndIf
			EndIf
			Dbselectarea("TO1")
			Dbskip()
		End

	Else

		Dbselectarea("TN0")
		Do Case
			Case mv_par04 == 2
				Dbsetorder(2)	//"Cód. Agente de risco"
			Case mv_par04 == 3
				Dbsetorder(3)	//"Cód. Fonte geradora"
		 	Case mv_par04 == 4
		 		Dbsetorder(5)	//"Cód. Centro de custo"
			Case mv_par04 == 5
				Dbsetorder(7)	//"Cód. Função"
		EndCase

		Dbseek(xFilial("TN0"))
		While xFilial("TN0") == TN0->TN0_FILIAL .And. !EOF()

		    Dbselectarea("TO1")
			Dbsetorder(01)
			If !Dbseek(xFilial("TO1")+TO0->TO0_LAUDO+TN0->TN0_NUMRIS)
				DbselectArea("TN0") ; DbSkip() ; Loop
			EndIf

			Dbselectarea("TMA")
			Dbsetorder(1)
			If !Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)
				DbselectArea("TN0") ; DbSkip() ; Loop
			EndIf

			U_Ris572(nOpcaoRisco)

			DbselectArea("TN0") ; DbSkip()
		EndDo

	EndIf

EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_A572QUADFUN()
Imprime listagem do número de funcionários do sexo masculino, feminino e
menors de idade.

@type    Function
@author  Liber Ee Esteban
@since   20/05/2005

@sample  U_A572QUADFUN()
@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function A572QUADFUN()

Local aArea  := GetArea()
Local cMemo  := ""
Local nMasc  := 0
Local nFemi  := 0
Local nMenor := 0

Dbselectarea("SRA")
Dbsetorder(01)
Dbseek(xFilial("SRA"))
While !eof() .And. xFilial("SRA") == SRA->RA_FILIAL

	If SRA->RA_SITFOLH == "D" .Or. !Empty(SRA->RA_DEMISSA)
		Dbskip()
		Loop
	End

	nIdade := Year(Date()) - Year(SRA->RA_NASC)
	If Month(Date()) < Month(SRA->RA_NASC)
		nIdade := nIdade - 1
	Elseif Month(Date()) == Month(SRA->RA_NASC)
		If Day(Date()) < Day(SRA->RA_NASC)
			nIdade := nIdade - 1
		EndIf
	EndIf

	If nIdade < 18
		nMenor++
	Else
		If SRA->RA_SEXO == "M"
			nMasc++
		Else
			nFemi++
		EndIf
	EndIf

	Dbselectarea("SRA")
	Dbskip()
End

cMemo:=STR(nMasc,5) + "#*"
cMemo+=STR(nFemi,5) + "#*"
cMemo+=STR(nMenor,5) + "#*"
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_SetDocumentVar(oWord,"Tabela",cMemo)
OLE_ExecuteMacro(oWord,"Quadro_Funcionario")
OLE_ExecuteMacro(oWord,"Somalinha")

RestArea(aArea)
Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_A572EQUIP()
Verifica quais sãos os equipamentos do laudo e chama a função que os imprime.

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_A572EQUIP()
@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function A572EQUIP()

Private cMemo := ""
Private nRegs := 0

If lSigaMdtPS

	If mv_par07 == 1

		Dbselectarea("TO2")
		Dbsetorder(01)
		Dbseek(xFilial("TO2")+TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TO2")+TO0->TO0_LAUDO == TO2->TO2_FILIAL+TO2->TO2_LAUDO
			Dbselectarea("TM7")
			Dbsetorder(1)
			If Dbseek(xFilial("TM7")+TO2->TO2_EQPTO)
	        	U_Equip572(1)
			EndIf
			Dbselectarea("TO2")
			Dbskip()
		End
		U_Equip572(2)

	Else

		DbSelectArea("TM7")
		Dbsetorder(02)
		DbSeek(xFilial("TM7"))
	    While !Eof() .And. xFilial("TM7") == TM7->TM7_FILIAL

	        Dbselectarea("TO2")
			Dbsetorder(01)
			If !Dbseek(xFilial("TO2")+TO0->TO0_LAUDO+TM7->TM7_EQPTO)
				DbSelectArea("TM7") ; DbSkip() ; Loop
			EndIf

	        U_Equip572(1)

	        DbSelectArea("TM7") ; DbSkip()
		EndDo
		U_Equip572(2)

	EndIf

Else

	If mv_par05 == 1

		Dbselectarea("TO2")
		Dbsetorder(01)
		Dbseek(xFilial("TO2")+TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TO2")+TO0->TO0_LAUDO == TO2->TO2_FILIAL+TO2->TO2_LAUDO
			Dbselectarea("TM7")
			Dbsetorder(1)
			If Dbseek(xFilial("TM7")+TO2->TO2_EQPTO)
	        	U_Equip572(1)
			EndIf
			Dbselectarea("TO2")
			Dbskip()
		End
		U_Equip572(2)

	Else

		DbSelectArea("TM7")
		Dbsetorder(02)
		DbSeek(xFilial("TM7"))
	    While !Eof() .And. xFilial("TM7") == TM7->TM7_FILIAL

	        Dbselectarea("TO2")
			Dbsetorder(01)
			If !Dbseek(xFilial("TO2")+TO0->TO0_LAUDO+TM7->TM7_EQPTO)
				DbSelectArea("TM7") ; DbSkip() ; Loop
			EndIf

	        U_Equip572(1)

	        DbSelectArea("TM7") ; DbSkip()
		EndDo
		U_Equip572(2)

	EndIf

EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_A572CONTR()
Imprime as medidas de controle do laudo.

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_A572CONTR()
@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function A572CONTR()

Dbselectarea("TO3")
Dbsetorder(01)
Dbseek(xFilial("TO3")+TO0->TO0_LAUDO)
While !eof() .And. xFilial("TO3")+TO0->TO0_LAUDO == TO3->TO3_FILIAL+TO3->TO3_LAUDO
	Dbselectarea("TO4")
	Dbsetorder(1)
	If Dbseek(xFilial("TO4")+TO3->TO3_CONTRO)
		lPrint := .T.
		U_IMPCAB572(Alltrim(TO4->TO4_NOMCTR))
		U_IMPTXT572(Alltrim(TO3->TO3_DESCRI))
	EndIf
	Dbselectarea("TO3")
	Dbskip()
End

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_A572EPIS()
Imprime os EPIs relacionados a função exercida pelo funcionário

@type    Function
@author  Denis Hyroshi de Souza
@since   08/04/2003

@sample  U_A572EPIS()
@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function A572EPIS()

Local cMemo := ""
Local nRegs := 0
Local aEpis := {}

Dbselectarea("TO1")
Dbsetorder(01)
Dbseek(xFilial("TO1")+TO0->TO0_LAUDO)
While !eof() .And. xFilial("TO1")+TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO

	Dbselectarea("TNX")
	Dbsetorder(1)
	Dbseek(xFilial("TNX")+TO1->TO1_NUMRIS)
	While !eof() .And. xFilial("TNX")+TO1->TO1_NUMRIS == TNX->TNX_FILIAL+TNX->TNX_NUMRIS

		Dbselectarea("TN3")
		Dbsetorder(2)
		If !Dbseek(xFilial("TN3")+TNX->TNX_EPI)
			Dbselectarea("TNX")
			Dbskip()
			Loop
		EndIf
		If aScan(aEpis,{|ABC| ABC[1]==TNX->TNX_EPI}) > 0
			Dbselectarea("TNX")
			Dbskip()
			Loop
		EndIf

		Dbselectarea("SB1")
		Dbsetorder(1)
		If Dbseek(xFilial("SB1")+TNX->TNX_EPI)
			Aadd(aEpis,{TNX->TNX_EPI})
			nRegs++
			cMemo += Substr(Alltrim(SB1->B1_DESC),1,25)+"#*"
			cMemo += Alltrim(TN3->TN3_NUMCAP)+"#*"
			cMemo += If(!Empty(TN3->TN3_DTAVAL),DTOC(TN3->TN3_DTAVAL),"__/__/__")+"#*"
			cMemo += Alltrim(Str(TN3->TN3_DURABI,5))+" dias"+"#*"
		EndIf

		Dbselectarea("TNX")
		Dbskip()
	End

	Dbselectarea("TO1")
	Dbskip()
End
If nRegs > 0
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_SetDocumentVar(oWord,"Tabela",cMemo)
	OLE_SetDocumentVar(oWord,"Linhas",nRegs)
	OLE_ExecuteMacro(oWord,"Table_Epis")
EndIf

Return .T.
//-------------------------------------------------------------------
/*/{Protheus.doc} U_A572PLANO()
Imprime os planos de ação relacionados ao risco.

@type    Function
@author  Liber De Esteban
@since   08/04/2003

@sample  572PLANO()
@return lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function A572PLANO()

Local aArea := GetArea()
Local svlPrint := lPrint
Local svlPrin2 := lPrin2
Private lAchou  := .F.
Private aPlanos := {}

If lSigaMdtPS

	//Plano de Acao
	DbSelectArea( "TAA" )
	Do Case
	    Case mv_par08 == 1
			DbSetOrder(1)	//TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_CODPLA
	    Case mv_par08 == 2
	    	DbSetOrder(2)	//TNI_FILIAL+TNI_CC
		Case mv_par08 == 3
			DbSetOrder(4)	//TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_FUNRES
	EndCase

	Set Filter To xFilial( "TAA" ) == TAA->TAA_FILIAL .And. TAA->(TAA_CLIENT+TAA_LOJA) = TO0->(TO0_CLIENT+TO0_LOJA)
	dbGoTop()

	While !Eof()

		//Plano de Acao por Risco
		Dbselectarea("TNJ")
		Dbsetorder(4)  //TNJ_FILIAL+TNJ_CLIENT+TNJ_LOJA+TNJ_CODPLA
		Dbseek(xFilial("TNJ")+TAA->(TAA_CLIENT+TAA_LOJA)+TAA->TAA_CODPLA)

		While !eof() .And. xFilial("TNJ")+TAA->TAA_CODPLA == TNJ->TNJ_FILIAL+TNJ->TNJ_CODPLA .And. TAA->(TAA_CLIENT+TAA_LOJA) == TNJ->(TNJ_CLIENT+TNJ_LOJA)

	  		//Laudos x Riscos
	  		Dbselectarea("TO1")
			Dbsetorder(03)  //TO1_FILIAL+TO1_CLIENT+TO1_LOJA+TO1_LAUDO+TO1_NUMRIS
			If !Dbseek(xFilial("TO1")+TO0->(TO0_CLIENT+TO0_LOJA)+TO0->TO0_LAUDO+TNJ->TNJ_NUMRIS)
				DbSelectArea("TNJ")
				DbSkip()
				Loop
			EndIf

			Dbselectarea("TN0")
			Dbsetorder(8)  //TN0_FILIAL+TN0_CODCLI+TN0_LOJACL+TN0_NUMRIS
			If !Dbseek(xFilial("TN0")+TO1->(TO1_CLIENT+TO1_LOJA)+TO1->TO1_NUMRIS)
				Dbselectarea("TNJ")
				Dbskip()
				Loop
			EndIf

			If aScan(aPlanos,{|x| x == TNJ->TNJ_CODPLA}) > 0
				DbSelectArea("TNJ")
				Dbskip()
				Loop
			EndIf

			Dbselectarea("TMK")
			Dbsetorder(1)
			Dbseek(xFilial("TMK")+TAA->TAA_MAT)
	        U_Plano572()

			Dbselectarea("TNJ")
			DbSkip()
		EndDo

		DbSelectArea( "TAA" )
		DbSkip()
	EndDo

Else

	DbSelectArea( "TAA" )
	Do Case
	    Case mv_par06 == 1
			DbSetOrder(1)
	    Case mv_par06 == 2
	    	DbSetOrder(2)
		Case mv_par06 == 3
			DbSetOrder(4)
	EndCase

	Dbseek(xFilial( "TAA" ) )
	While xFilial( "TAA" ) == TAA->TAA_FILIAL .And. !Eof()

		Dbselectarea("TNJ")
		Dbsetorder(2)
		Dbseek(xFilial("TNJ")+TAA->TAA_CODPLA)
		While !eof() .And. xFilial("TNJ")+TAA->TAA_CODPLA == TNJ->TNJ_FILIAL+TNJ->TNJ_CODPLA

	  		Dbselectarea("TO1")
			Dbsetorder(01)
			If !Dbseek(xFilial("TO1")+TO0->TO0_LAUDO+TNJ->TNJ_NUMRIS)
				DbSelectArea("TNJ") ; DbSkip() ; Loop
			EndIf

			Dbselectarea("TN0")
			Dbsetorder(1)
			If !Dbseek(xFilial("TN0")+TO1->TO1_NUMRIS)
				Dbselectarea("TNJ") ; Dbskip() ; Loop
			EndIf

			If aScan(aPlanos,{|x| x == TNJ->TNJ_CODPLA}) > 0
				DbSelectArea("TNJ") ; Dbskip() ; Loop
			EndIf

	        U_Plano572()

			Dbselectarea("TNJ") ; DbSkip()
		EndDo

		DbSelectArea( "TAA" ) ; DbSkip()
	EndDo

EndIf

lPrint := svlPrint
lPrin2 := svlPrin2

If lAchou
	Somalinha()
	Somalinha()
EndIf

RestArea(aArea)
Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_A572NFRISCO()
Funcionários expostos aos riscos

@type    Function
@author  Liber De Esteban
@since   08/10/2004

@sample  U_A572NFRISCO("*"","*"","*"","*"")
@param   cCusto, caracter, valor do centro de custo
@param   cFunc, caracter, valor da função
@param   cTar, caracter, valor da tarefa
@param   cDepto, caracter, valor do departamento

@return  nRet, nunérico, quantidade de funcionários expostos
/*/
//-------------------------------------------------------------------
User Function A572NFRISCO(cCusto,cFunc,cTar,cDepto)

Local nRet := 0
Local cMat := " "
Local lRet := .T.

If (nPos := aScan(aNfrisco,{|x| cCusto+cFunc+cTar+cDepto == x[1]+x[2]+x[3]+x[5]})) > 0
	Return aNfrisco[nPos,4]
EndIf

If Alltrim(cCusto) == "*"
	If Alltrim(cFunc) == "*"
		If Alltrim(cDepto) == "*"
			If Alltrim(cTar) == "*"
				dbSelectArea("SRA")
				dbSetOrder(01)
				dbSeek(xFilial("SRA"))
				While !EOF() .And. xFilial("SRA") == SRA->RA_FILIAL
					If SRA->RA_SITFOLH != "D"
						nRet++
					EndIf
					dbSelectArea("SRA")
					dbSkip()
				End
				lRet := .F.
			Else
				If lSigaMdtPS
					dbSelectArea("TN6")
					dbSetOrder(03)  //TN6_FILIAL+TN6_CLIENT+TN6_LOJA+TN6_CODTAR+TN6_MAT+DTOS(TN6_DTINIC)
					dbSeek(xFilial("TN6")+TN0->(TN0_CODCLI+TN0_LOJACL)+cTar)
					While !EOF() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. TN6->TN6_CODTAR == cTar .And. TN0->(TN0_CODCLI+TN0_LOJACL) = TN6->(TN6_CLIENT+TN6_LOJA)
						dbSelectArea("SRA")
						dbSetOrder(01)
						If dbSeek(xFilial("SRA")+TN6->TN6_MAT)  .And.;
						TN6->TN6_DTINIC <= dDatabase         .And.;
						(TN6->TN6_DTTERM >= dDatabase .Or. Empty(TN6->TN6_DTTERM))
							If SRA->RA_SITFOLH != "D"
								nRet++
							EndIf
						EndIf
						dbSelectArea("TN6")
						dbSkip()
					End
				Else
					dbSelectArea("TN6")
					dbSetOrder(01)
					dbSeek(xFilial("TN6")+cTar)
					While !EOF() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. TN6->TN6_CODTAR == cTar
						dbSelectArea("SRA")
						dbSetOrder(01)
						If dbSeek(xFilial("SRA")+TN6->TN6_MAT)  .And.;
						TN6->TN6_DTINIC <= dDatabase         .And.;
						(TN6->TN6_DTTERM >= dDatabase .Or. Empty(TN6->TN6_DTTERM))
							If SRA->RA_SITFOLH != "D"
								nRet++
							EndIf
						EndIf
						dbSelectArea("TN6")
						dbSkip()
					End
				EndIf
				lRet := .F.
			EndIf
		Else
			nInd   := 21 //Ordenar pelo Codigo do Departamento
			cSeek  := cDepto
			cField := "SRA->RA_DEPTO"
		EndIf
	Else
		nInd   := 7 //Ordenar pelo Codigo da Funcao
		cSeek  := cFunc
		cField := "SRA->RA_CODFUNC"
	EndIf
Else
	nInd   := 2 //Ordenar pelo Codigo do Centro de Custo
	cSeek  := cCusto
	cField := "SRA->RA_CC"
EndIf

If lRet
	dbSelectArea("SRA")
	dbSetOrder(nInd)
	dbSeek(xFilial("SRA")+cSeek)
	While !EOF() .And. xFilial("SRA") == SRA->RA_FILIAL .And. &cField == cSeek
		If SRA->RA_SITFOLH == "D"
			dbSkip()
			Loop
		EndIf
		lFunc := .F.
		If nInd == 7
			If Alltrim(cTar) == "*"
				nRet++
				dbSelectArea("SRA")
				dbSkip()
				Loop
			Else
				lFunc := .T.
			EndIf
		Else
			If SRA->RA_CODFUNC == cFunc .Or. Alltrim(cFunc) == "*"
				If Alltrim(cTar) == "*"
					nRet++
					dbSelectArea("SRA")
					dbSkip()
					Loop
				Else
					lFunc := .T.
				EndIf
			EndIf
		EndIf

		If lFunc
			dbSelectArea("TN6")
			dbSetOrder(01)
			dbSeek(xFilial("TN6")+cTar+SRA->RA_MAT)
			While !EOF() .And. xFilial("TN6") == TN6->TN6_FILIAL .And.;
			      TN6->TN6_MAT == SRA->RA_MAT .And. TN6->TN6_CODTAR == cTar
				If TN6->TN6_DTINIC <= dDatabase .And. (TN6->TN6_DTTERM >= dDatabase .Or. Empty(TN6->TN6_DTTERM))
					nRet++
					Exit
				EndIf
				dbSelectArea("TN6")
				dbSkip()
			End

		EndIf

		dbSelectArea("SRA")
		dbSkip()
	End
EndIf

AADD(aNfrisco,{cCusto,cFunc,cTar, nRet, cDepto})

Return nRet

//-------------------------------------------------------------------
/*/{Protheus.doc} U_LOCAL572()
Imprime as informacoes relacionadas ao local.

@type    Function
@author  Andre E. Perez Alvarez
@since   01/02/2006

@sample  U_LOCAL572()

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function LOCAL572()

lPrint := .T.
U_IMPCAB572(Alltrim(TNE->TNE_NOME))
U_IMPTXT572(Alltrim(TO5->TO5_DESCRI))
U_IMPTXT572(Alltrim(TNE->TNE_DESAMB)+" ")
If TNE->(FieldPos("TNE_DESAM1")) > 0
	If !Empty(TNE->TNE_DESAM1)
		U_IMPTXT572(Alltrim(TNE->TNE_DESAM1))
	EndIf
EndIf
If TNE->(FieldPos("TNE_DESAM2")) > 0
	If !Empty(TNE->TNE_DESAM2)
		U_IMPTXT572(Alltrim(TNE->TNE_DESAM2))
	EndIf
EndIf
If TNE->(FieldPos("TNE_DESAM3")) > 0
	If !Empty(TNE->TNE_DESAM3)
		U_IMPTXT572(Alltrim(TNE->TNE_DESAM3))
	EndIf
EndIf
If TNE->(FieldPos("TNE_DESAM4")) > 0
	If !Empty(TNE->TNE_DESAM4)
		U_IMPTXT572(Alltrim(TNE->TNE_DESAM4))
	EndIf
EndIf

Return .T.
//-------------------------------------------------------------------
/*/{Protheus.doc} U_Ris572(nOpcaoRisco)
Imprime as informacoes relacionadas ao risco.

@type    Function
@author  Andre E. Perez Alvarez
@since   03/02/2006

@sample  U_Ris572(1)
@param   nOpcao, Numérico

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function Ris572(nOpcaoRisco)

Local cIndExp := " "
Local CComExp := " "
Local lImpMed := .F.
Local lFunExp := .F.
Local lTecUti := .F.
Local lNR32	  := SuperGetMv("MV_NG2NR32",.F.,"2") == "2"
Local lDepto  := NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )

If lSigaMdtPS
	Dbselectarea("TN7")
	Dbsetorder(3)  //TN7_FILIAL+TN7_CLIENT+TN7_LOJA+TN7_FONTE
	Dbseek(xFilial("TN7")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_FONTE)
	Dbselectarea(cAlias)
	Dbsetorder(1)
	Dbseek(xFilial(cAlias)+TN0->TN0_CC)
	Dbselectarea("SRJ")
	Dbsetorder(1)
	Dbseek(xFilial("SRJ")+TN0->TN0_CODFUN)
	Dbselectarea("TN5")
	Dbsetorder(3)  //TN5_FILIAL+TN5_CLIENT+TN5_LOJA+TN5_CODTAR
	Dbseek(xFilial("TN5")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_CODTAR)
	Dbselectarea("TNE")
	Dbsetorder(3)  //TNE_FILIAL+TNE_CODCLI+TNE_LOJACL+TNE_CODAMB
	Dbseek(xFilial("TNE")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_CODAMB)
	If AliasInDic("TJF")
		DbSelectArea("TJF")
		DbSetOrder(2)
		DbSeek(xFilial("TJF") + TN0->(TN0_CODCLI+TN0_LOJACL) + TN0->TN0_NUMRIS)
	EndIf
Else
	Dbselectarea("TN7")
	Dbsetorder(1)
	Dbseek(xFilial("TN7")+TN0->TN0_FONTE)
	Dbselectarea(cAlias)
	Dbsetorder(1)
	Dbseek(xFilial(cAlias)+TN0->TN0_CC)
	Dbselectarea("SRJ")
	Dbsetorder(1)
	Dbseek(xFilial("SRJ")+TN0->TN0_CODFUN)
	Dbselectarea("TN5")
	Dbsetorder(1)
	Dbseek(xFilial("TN5")+TN0->TN0_CODTAR)
	Dbselectarea("TNE")
	Dbsetorder(1)
	Dbseek(xFilial("TNE")+TN0->TN0_CODAMB)
	If AliasInDic("TJF")
		Dbselectarea("TJF")
		Dbsetorder(1)  //TJF_FILIAL+TJF_CLIENT+TJF_LOJA+TJF_NUMRIS+TJF_MEDCON
		Dbseek(xFilial("TJF")+TN0->TN0_NUMRIS)
	EndIf
	If lDepto
		dbSelectArea("SQB")
		dbSetOrder(1)
		dbSeek( xFilial( "SQB" ) + TN0->TN0_DEPTO )
	EndIf
EndIf

lPrin2 := .F.
lPrint := .F.

//Agente
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,"Agente:")

cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Sem_Negrito")
OLE_SetDocumentVar(oWord,cVar1,TMA->TMA_NOMAGE)

//Fonte Geradora de Risco
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,"Fonte Geradora de Risco:")

cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Sem_Negrito")
OLE_SetDocumentVar(oWord,cVar1,TN7->TN7_NOMFON+" ")

//Centro de Custo
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,"Centro de Custo:")

cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Sem_Negrito")
OLE_SetDocumentVar(oWord,cVar1,If(Alltrim(TN0->TN0_CC)=="*","TODOS",Alltrim(&cDescr))+" ")

If Alltrim(TN0->TN0_CODFUN) != "*"
	//Funcao
	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Com_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,"Função:")

	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Sem_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,Alltrim(SRJ->RJ_DESC)+" ")
EndIf

If Alltrim(TN0->TN0_CODTAR) != "*"
	//Tarefa
	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Com_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,"Tarefa:")

	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Sem_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,Alltrim(TN5->TN5_NOMTAR)+" ")
EndIf

If lDepto .And. Alltrim(TN0->TN0_DEPTO) != "*"
	//Tarefa
	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Com_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,"Departamento:")

	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Sem_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,Alltrim(SQB->QB_DESCRIC)+" ")
EndIf

//Ambiente
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,If(lNR32,STR0043+":",STR0042+":")) //"Ambiente"//"Ambiente Físico do Risco"

cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Sem_Negrito")
OLE_SetDocumentVar(oWord,cVar1,Alltrim(TNE->TNE_NOME)+" ")

//Data de Reconhecimento
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,"Data de Avaliação:")

cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Sem_Negrito")
OLE_SetDocumentVar(oWord,cVar1,TN0->TN0_DTAVAL)

//Quantidade do Agente de Risco
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,"Quantidade do Agente de Risco:")

cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Sem_Negrito")
OLE_SetDocumentVar(oWord,cVar1,Alltrim(Str(TN0->TN0_QTAGEN)+" "+TN0->TN0_UNIMED))

//Tempo de Exposicao
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Somalinha")
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,"Tempo de Exposição:")

cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Sem_Negrito")
OLE_SetDocumentVar(oWord,cVar1,TN0->TN0_QTEXPO)

Dbselectarea("TN0")
//Tipo de Exposicao
If FieldPos("TN0_INDEXP") > 0
	If (nIND := aScan(aTN0Combo,{|x| Upper(Substr(x,1,1)) == Substr(TN0_INDEXP,1,1)})) > 0
		cIndExp := UPPER(Substr(aTN0Combo[nIND],3))
	EndIf

	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Com_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,"Tipo de Exposição:")

	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Sem_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,cIndExp)
EndIf

//Complemento de Exposição
If NGCADICBASE("TN0_COMEXP","A","TN0",.F.)
	If !Empty(TN0->TN0_COMEXP)
		CComExp := Alltrim(TN0->TN0_COMEXP)

		cVar1 := "cTXT"+Strzero(nVar1,6)
		OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
		nVar1++
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Cria_Texto")
		OLE_ExecuteMacro(oWord,"Com_Negrito")
		OLE_SetDocumentVar(oWord,cVar1,STR0044 + ":")  //"Compl. Exposição"

		cVar1 := "cTXT"+Strzero(nVar1,6)
		OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
		nVar1++
		OLE_ExecuteMacro(oWord,"Cria_Texto")
		OLE_ExecuteMacro(oWord,"Sem_Negrito")
		OLE_SetDocumentVar(oWord,cVar1,CComExp)
	EndIf
EndIf

If lNR32 .And. AliasInDic("TJF")
	lImpMed := fImpMedCon(TN0->TN0_NUMRIS)
EndIf

//Numero de Funcionarios Expostos ao Risco
Dbselectarea("TN0")
If FieldPos("TN0_INDEXP") > 0
	lFunExp := .T.
	cFuncRisco := U_A572NFRISCO(TN0->TN0_CC,TN0->TN0_CODFUN,TN0->TN0_CODTAR,If(lDepto,TN0->TN0_DEPTO,""))
	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	If !lImpMed
		OLE_ExecuteMacro(oWord,"Somalinha")
	EndIf
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Com_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,"Funcionários Expostos ao Risco:")

	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Sem_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,cFuncRisco)
EndIf

//Tecnica Utilizada
If FieldPos("TN0_TECUTI") > 0
	lTecUti := .T.
	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	If !lImpMed .Or. !lFunExp
		OLE_ExecuteMacro(oWord,"Somalinha")
	EndIf
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Com_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,"Tecnica Utilizada:")

	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Cria_Texto")
	OLE_ExecuteMacro(oWord,"Sem_Negrito")
	OLE_SetDocumentVar(oWord,cVar1,TN0->TN0_TECUTI)
EndIf

//Recomendação
cVar1 := "cTXT"+Strzero(nVar1,6)
OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
nVar1++
If !lImpMed .Or. !lFunExp .Or. !lTecUti
	OLE_ExecuteMacro(oWord,"Somalinha")
EndIf
OLE_ExecuteMacro(oWord,"Cria_Texto")
OLE_ExecuteMacro(oWord,"Com_Negrito")
OLE_SetDocumentVar(oWord,cVar1,"Recomendação:")

If nOpcaoRisco != 2
	If Alltrim( TN0->TN0_CC )     == "*" .Or. Empty( TN0->TN0_CC ) .Or.;
	Alltrim( TN0->TN0_CODFUN ) == "*" .Or. Empty( TN0->TN0_CODFUN ) .Or.;
	( lDepto .And. ( Alltrim( TN0->TN0_DEPTO )  == "*" .Or. Empty( TN0->TN0_DEPTO ) ) )
		If !Empty( Mv_par08 ) .And. Mv_par08 != 3
			a572NAOEXP()
		EndIf
	EndIf
EndIf

lPrin2 := .T.
lIdentar := .T.
U_IMPTXT572(Alltrim(TO1->TO1_RECOME))
lIdentar := .F.

Begin Sequence
	If nOpcaoRisco == 2
		If	Alltrim(TN0->TN0_CC)     == "*" .Or. Empty(TN0->TN0_CC) .Or.;
			Alltrim(TN0->TN0_CODFUN) == "*" .Or. Empty(TN0->TN0_CODFUN) .Or. ;
			( lDepto .And. ( Alltrim(TN0->TN0_DEPTO)  == "*" .Or. Empty(TN0->TN0_DEPTO) ) )

			Break
		EndIf

		Dbselectarea("SRJ")
		Dbsetorder(1)
		If !Dbseek(xFilial("SRJ")+TN0->TN0_CODFUN)
			Break
		EndIf

		If lDepto
			Dbselectarea("SQB")
			Dbsetorder(1)
			If !Dbseek(xFilial("SQB")+TN0->TN0_DEPTO)
				Break
			EndIf
		EndIf

		Dbselectarea("SQ3")
		Dbsetorder(1)
		If !Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO+TN0->TN0_CC)
			Dbselectarea("SQ3")
			Dbsetorder(1)
			If !Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)
				Break
			Else
				If Empty(MSMM(SQ3->Q3_DESCDET))
					Break
				EndIf
			EndIf
		EndIf

		//Descricao da Atividade de Risco
		cVar1 := "cTXT"+Strzero(nVar1,6)
		OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
		nVar1++
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Cria_Texto")
		OLE_ExecuteMacro(oWord,"Com_Sublinhar")
		OLE_ExecuteMacro(oWord,"Com_Negrito")
		OLE_SetDocumentVar(oWord,cVar1,"Descrição da Atividade de Risco:")

		lPrin2 := .T.
		lIdentar := .T.
		U_IMPTXT572(Alltrim(MSMM(SQ3->Q3_DESCDET)))
		lIdentar := .F.
	EndIf
End Sequence

Return .T.
//-------------------------------------------------------------------
/*/{Protheus.doc} U_Equip572()
Imprime as informacoes relacionadas ao equipamento.

@type    Function
@author  Andre E. Perez Alvarez
@since   03/02/2006

@sample  U_Equip572(1)
@param   nOpcao, Numérico

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function Equip572(nOpcao)

If nOpcao == 1
	nRegs++
	cMemo += Substr(Alltrim(TM7->TM7_NOEQTO),1,25)+"#*"
	cMemo += Substr(Alltrim(TM7->TM7_NOMFAB),1,15)+"#*"
	cMemo += If(!Empty(TM7->TM7_DTCALI),DTOC(TM7->TM7_DTCALI),"__/__/__")+"#*"
	cMemo += DTOC(TM7->TM7_DTAFER)+"#*"
Else
	If nRegs > 0
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_Equipamentos")
	EndIf
EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} Plano572
Imprime as informações relacionadas ao plano de ação.

@author Andre E. Perez Alvarez
@since 03/02/2006
@return .T.
/*/
//---------------------------------------------------------------------
User Function Plano572()

Local aAreaTAA

aAdd(aPlanos,TNJ->TNJ_CODPLA)

lIdenold := lIdentar
lIdentar := .T.

U_IMPCAB572("{N}Plano de Ação:")
lPrint := .F.
lPrin2 := .F.
U_IMPTXT572(Alltrim(TAA->TAA_NOME))

U_IMPCAB572("{N}Responsável:",.T.)
lPrint := .F.
lPrin2 := .F.
aAreaTAA:= TAA->(GetArea())//Salva area da TAA
dbSelectArea("TC9")
dbSetOrder(1)
dbSeek(xFilial("TC9")+TAA->TAA_CODPLA)//Posiciona na tabela de Responsaveis
While TC9->(!Eof()) .And. TC9->TC9_FILIAL == xFilial("TC9") ;
						.And. TC9->TC9_CODPLA == TAA->TAA_CODPLA
	If TC9->TC9_TIPRES == "1"	//Tipo Usuário
		dbSelectArea("QAA")
		dbSetOrder(1)
		dbSeek(xFilial("QAA")+TC9->TC9_CODRES)
		U_IMPTXT572(Alltrim(QAA->QAA_NOME))
	ElseIf TC9->TC9_TIPRES == "2"	//Tipo Funcionário
		dbSelectArea("SRA")
		dbSetOrder(1)
		dbSeek(xFilial("SRA")+TC9->TC9_CODRES)
		U_IMPTXT572(Alltrim(SRA->RA_NOME))
	EndIf
	TC9->(dbSkip())//Vai para próximo registro
End
RestArea(aAreaTAA)

U_IMPCAB572("{N}O que ?",.T.)
lPrint := .F.
lPrin2 := .F.
U_IMPTXT572(Alltrim(TAA->TAA_OQUE))

U_IMPCAB572("{N}Onde ?",.T.)
lPrint := .F.
lPrin2 := .F.
U_IMPTXT572(Alltrim(TAA->TAA_ONDE))

U_IMPCAB572("{N}Por que ?",.T.)
lPrint := .F.
lPrin2 := .F.
U_IMPTXT572(Alltrim(TAA->TAA_PORQUE))

U_IMPCAB572("{N}Como ?",.T.)
lPrint := .F.
lPrin2 := .F.
U_IMPTXT572(Alltrim(TAA->TAA_COMO))

U_IMPCAB572("{N}Data Início:",.T.)
lPrint := .F.
lPrin2 := .F.
U_IMPTXT572("Prevista: "+DtoC(TAA->TAA_DTINPR)+"  Real: "+DtoC(TAA->TAA_DTINRE))

U_IMPCAB572("{N}Data Fim:",.T.)
lPrint := .F.
lPrin2 := .F.
U_IMPTXT572("Prevista: "+DtoC(TAA->TAA_DTFIPR)+"  Real: "+DtoC(TAA->TAA_DTFIRE))

If TAA->TAA_QTDATU > 0 .Or. TAA->TAA_META > 0 .Or. TAA->TAA_QTDFIM > 0
	U_IMPCAB572("{N}Quantidade:",.T.)
	lPrint := .F.
	lPrin2 := .F.
	U_IMPTXT572("Atual: "+Ltrim(Str(TAA->TAA_QTDATU,8,2))+"  "+"Meta: "+Ltrim(Str(TAA->TAA_META,8,2))+;
		"  "+"Final: "+Ltrim(Str(TAA->TAA_QTDFIM,8,2)))
EndIf

lIdentar := lIdenold

Return .T.
//-------------------------------------------------------------------
/*/{Protheus.doc} fReguaPPRA()
Processa régua

@type Static Function
@author  Denis Hyroshi de Souza
@since   27/10/2011

@sample  fReguaPPRA( nLenMemo, nPerMemo, nLenAtual )
@param   nLenMemo, Numérico
@param   nPerMemo, Numérico
@param   nLenAtual, Numérico
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function fReguaPPRA( nLenMemo, nPerMemo, nLenAtual )

Local nLenOld := (100 - nPerMemo) * ( nLenMemo / 100 ) //Calcula Len anterior
Local nDiff := nLenOld - nLenAtual
Local nFor
Local nPercent

If nDiff > 0
	//Porcentagem que processou neste Loop
	nPercent := Round( (100 / nLenMemo) * nDiff , 0 )
	//Porcentagem processada
	nPerMemo += nPercent
	If nPercent >= 1 .And. nPercent <= 100
		For nFor := 1 To nPercent
			IncRegua()
		Next nFor
	EndIf
EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A572IMAGEM()
Inserir imagens no arquivo

@type Static Function
@author  Denis Hyroshi de Souza
@since   04/08/2001

@sample  A572IMAGEM("Imagem")
@param   cTitTemp, caracter, imagem do documento
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function A572IMAGEM(cTitTemp)

Local cFileArq := ""
Local cBarraSrv := "\"
Local nPos

If isSRVunix()  //servidor é da família Unix (linux, solaris, free-bsd, hp-ux, etc.)
	cBarraSrv := "/"
EndIf

nPos := Rat(cBarraSrv,cTitTemp)
If nPos > 0
	cFileArq := AllTrim(Substr(cTitTemp,nPos+1))
EndIf

CpyS2T(Alltrim(cTitTemp),cPathEst,.T.) 	// Copia do Server para o Remote

If File( cPathEst+cFileArq )
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_SetDocumentVar(oWord,"Cria_Var",cPathEst+cFileArq)
	OLE_ExecuteMacro(oWord,"Insere_img")
EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A572ARQUIVO()
Inserir documentos no arquivo

@type Static Function
@author  Denis Hyroshi de Souza
@since   04/08/2001

@sample  A572ARQUIVO("Documento")
@param   cTitTemp, caracter, título do documento
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function A572ARQUIVO(cTitTemp)

Local cFileArq := ""
Local cBarraSrv := "\"
Local nPos

If isSRVunix()  //servidor é da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
	cBarraSrv := "/"
EndIf

nPos := Rat(cBarraSrv,cTitTemp)
If nPos > 0
	cFileArq := AllTrim(Substr(cTitTemp,nPos+1))
EndIf

CpyS2T(Alltrim(cTitTemp),cPathEst,.T.) 	// Copia do Server para o Remote, é necessario

If File( cPathEst+cFileArq )
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_SetDocumentVar(oWord,"Cria_Var",cPathEst+cFileArq)
	OLE_ExecuteMacro(oWord,"Insere_doc")
EndIf

Return
//-----------------------------------------------------------------------------
/*/{Protheus.doc} fImpMedCon
Funcao que imprime Medidas de controle para os riscos.

@type Static Function
@author Guilherme Benkendorf
@since 08/03/2013

@sample fImpMedCon("000000008")
@param cRisco, caracter, representa o número do risco
@return lImp, indica se houve impressão
/*/
//-------------------------------------------------------------------------------
Static Function fImpMedCon(cRisco)

Local lTitulo := .T.
Local lImp
Local cMemo	  := ""

Local cSeekPS	:= IIf(lSigaMdtPS,cCliMdtPs, "")
Local cWhileTJF := "TJF->TJF_FILIAL + TJF->TJF_NUMRIS"
Local cWhileTO4 := "TO4->TO4_FILIAL + TO4->TO4_CONTRO"
Local nIndTJF 	:= 1
Local nIndTO4 	:= 1
Local nReg	    := 1

If lSigaMdtPS
	cWhileTJF := "TJF->TJF_FILIAL + TJF->TJF_CLIENT + TJF->TJF_LOJA + TJF->TJF_NUMRIS"
	nIndTJF   := 2
End

//Procura Medidas de controle relacionado aos Riscos
DbSelectArea("TJF")
DbSetOrder(nIndTJF)
DbSeek(xFilial("TJF") + cSeekPS + cRisco)
While xFilial("TJF") + cSeekPS + cRisco == &cWhileTJF.
	DbSelectArea("TO4")
	DbSetOrder(nIndTO4)
	DbSeek(xFilial("TO4") + TJF->TJF_MEDCON)
	While xFilial("TO4") + TJF->TJF_MEDCON == &cWhileTO4.
		If lTitulo
			lTitulo := .F.
			//Imprime Titulo

			cVar1 := "cTXT"+Strzero(nVar1,6)
			OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
			nVar1++
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Cria_Texto")
			OLE_ExecuteMacro(oWord,"Com_Negrito")
			OLE_SetDocumentVar(oWord,cVar1,STR0040 + ":")  //"Medidas de Controle"

			cMemo += STR0021 + "#*" //Codigo
			cMemo += STR0041 + "#*" //Descrição
		EndIf

		cMemo += Alltrim(TO4->TO4_CONTRO) + "#*"
		cMemo += Alltrim(TO4->TO4_NOMCTR) + "#*"
		nReg++

		DbSelectArea("TO4")
		DbSkip()
	End
	DbSelectArea("TJF")
	DbSkip()
End

lImp := !Empty(cMemo)//Verifica se houve impressão

If lImp
	StrTran(cMemo,"#*#*","#* #*")
	cVar1 := "cTXT"+Strzero(nVar1,6)
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
	nVar1++
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_SetDocumentVar ( oWord , "Tabela",cMemo			)
	OLE_SetDocumentVar ( oWord , "Linhas",nReg			)
	OLE_ExecuteMacro   ( oWord , "Table_MedidaControle"	)
EndIf

Return lImp

//-------------------------------------------------------------------
/*/{Protheus.doc} a572NAOEXP
Busca e imprime as informações do atalho dos funcionarios não
expostos aos riscos do laudo

@type Function
@author Gabriel Sokacheski
@since 23/03/2021

/*/
//-------------------------------------------------------------------
Static Function a572NAOEXP()

	Local aFun := {}
	Local aRiscos := {}
	Local aFunRis := {}

	Local cFun := ''
	Local cTar := ''
	Local cDep := ''
	Local cLaudo := TO0->TO0_LAUDO
	Local cCenCus := ''
	Local cAliasRis := GetNextAlias()
	Local cAliasFun := GetNextAlias()
	Local cListaFun := ''
	Local cCenCusFil := IIf( Empty( mv_par07 ), 'NULL', mv_par07 )

	Local dAteLaudo := IIf( !Empty( TO0->TO0_DTFIM ), TO0->TO0_DTFIM, dDatabase )

	Local nI := 0
	Local nX := 0
	Local nTipo := mv_par08

	BeginSQL Alias cAliasRis
		SELECT
			TN0.TN0_NUMRIS, TMA.TMA_NOMAGE, TMA.TMA_GRISCO, TN7.TN7_NOMFON, CTT.CTT_DESC01, SRJ.RJ_DESC,
			TN5.TN5_NOMTAR, SQB.QB_DESCRIC, TNE.TNE_NOME, TN0.TN0_DTAVAL, TN0.TN0_QTAGEN, V3F.V3F_DESCRI,
			TN0.TN0_INDEXP, TN0.TN0_CC, TN0.TN0_CODFUN, TN0.TN0_CODTAR, TN0.TN0_DEPTO, TO1.TO1_RECOME
		FROM 
			%table:TO0% TO0
			INNER JOIN %table:TO1% TO1 ON
				TO0.TO0_LAUDO = TO1.TO1_LAUDO
				AND %xFilial:TO1% = TO1.TO1_FILIAL
				AND TO1.%NotDel%
			INNER JOIN %table:TN0% TN0 ON
				TO1.TO1_NUMRIS = TN0.TN0_NUMRIS
				AND %xFilial:TN0% = TN0.TN0_FILIAL
				AND ( TN0.TN0_CC = %exp:cCenCusFil% OR TN0.TN0_CC = '*' )
				AND TN0.TN0_MAPRIS != '1'
				AND TN0.%NotDel%
			INNER JOIN %table:TMA% TMA ON
				TN0.TN0_AGENTE = TMA.TMA_AGENTE
				AND %xFilial:TMA% = TMA.TMA_FILIAL
				AND TMA.%NotDel%
			INNER JOIN %table:TN7% TN7 ON
				TN0.TN0_FONTE = TN7.TN7_FONTE
				AND %xFilial:TN7% = TN7.TN7_FILIAL
				AND TN7.%NotDel%
			LEFT JOIN %table:CTT% CTT ON
				TN0.TN0_CC = CTT.CTT_CUSTO
				AND %xFilial:CTT% = CTT.CTT_FILIAL
				AND CTT.%NotDel%
			LEFT JOIN %table:SRJ% SRJ ON
				TN0.TN0_CODFUN = SRJ.RJ_FUNCAO
				AND %xFilial:SRJ% = SRJ.RJ_FILIAL
				AND SRJ.%NotDel%
			LEFT JOIN %table:TN5% TN5 ON
				TN0.TN0_CODTAR = TN5.TN5_CODTAR
				AND %xFilial:TN5% = TN5.TN5_FILIAL
				AND TN5.%NotDel%
			LEFT JOIN %table:SQB% SQB ON
				TN0.TN0_DEPTO = SQB.QB_DEPTO
				AND %xFilial:SQB% = SQB.QB_FILIAL
				AND SQB.%NotDel%
			LEFT JOIN %table:TNE% TNE ON
				TN0.TN0_CODAMB = TNE.TNE_CODAMB
				AND %xFilial:TNE% = TNE.TNE_FILIAL
				AND TNE.%NotDel%
			LEFT JOIN %table:V3F% V3F ON
				TN0.TN0_UNIMED = V3F.V3F_CODIGO
				AND %xFilial:V3F% = V3F.V3F_FILIAL
				AND V3F.%NotDel%
		WHERE
			TO0.TO0_FILIAL = %xFilial:TO0%
			AND TO0.TO0_LAUDO = %exp:cLaudo%
			AND TO0.TO0_TIPREL = '4'
			AND ( TN0.TN0_CC = CTT.CTT_CUSTO OR TN0.TN0_CC = '*' )
			AND ( TN0.TN0_CODFUN = SRJ.RJ_FUNCAO OR TN0.TN0_CODFUN = '*' )
			AND ( TN0.TN0_CODTAR = TN5.TN5_CODTAR OR TN0.TN0_CODTAR = '*' )
			AND ( TN0.TN0_DEPTO = SQB.QB_DEPTO OR TN0.TN0_DEPTO = '*' )
			AND TO0.%NotDel%
		ORDER BY TN0.TN0_NUMRIS
	EndSQL

	dbSelectArea( cAliasRis )
	dbGoTop()

	While !Eof()

		If aScan( aRiscos, { | x | x[ 1 ] == TN0_NUMRIS } ) == 0

			cFun := IIf( AllTrim( TN0_CODFUN ) == '*', STR0063, RJ_DESC ) // "Todas"
			cTar := IIf( AllTrim( TN0_CODTAR ) == '*', STR0063, TN5_NOMTAR ) // "Todas"
			cDep := IIf( AllTrim( TN0_DEPTO ) == '*', STR0062, QB_DESCRIC ) // "Todos"
			cCenCus := IIf( AllTrim( TN0_CC ) == '*', STR0062, CTT_DESC01 ) // "Todos"

			aAdd( aRiscos, {;
				TN0_NUMRIS,;
				TMA_NOMAGE,;
				TMA_GRISCO,;
				TN7_NOMFON,;
				cCenCus,;
				cFun,;
				cTar,;
				cDep,;
				TNE_NOME,;
				TN0_DTAVAL,;
				TN0_QTAGEN,;
				TN0_INDEXP,;
				TO1_RECOME,;
				V3F_DESCRI;
			} )

		EndIf

		( cAliasRis )->( dbSkip() )

	End

	( cAliasRis )->( dbCloseArea() )

	BeginSQL Alias cAliasFun
		SELECT 
			TN0.TN0_NUMRIS, TM0.TM0_NUMFIC, SRA.RA_MAT, SRA.RA_NOME
		FROM 
			%table:SRA% SRA
				INNER JOIN %table:TO0% TO0 ON
					%exp:cLaudo% = TO0.TO0_LAUDO
					AND %xFilial:TO0% = TO0.TO0_FILIAL
					AND TO0.TO0_TIPREL = '4'
					AND TO0.%NotDel%
				INNER JOIN %table:TO1% TO1 ON
					TO0.TO0_LAUDO = TO1.TO1_LAUDO
					AND %xFilial:TO1% = TO1.TO1_FILIAL
					AND TO1.%NotDel%
				INNER JOIN %table:TN0% TN0 ON
					TO1.TO1_NUMRIS = TN0.TN0_NUMRIS
					AND %xFilial:TN0% = TN0.TN0_FILIAL
					AND ( TN0.TN0_CC = %exp:cCenCusFil% OR TN0.TN0_CC = '*' )
					AND TN0.TN0_MAPRIS != '1'
					AND TN0.%NotDel%
				LEFT JOIN %table:TM0% TM0 ON
					SRA.RA_MAT = TM0.TM0_MAT
					AND %xFilial:TM0% = TM0.TM0_FILIAL
					AND TM0.%NotDel%
		WHERE
			SRA.RA_FILIAL = %xFilial:SRA%
			AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
			AND ( SRA.RA_CC = TN0.TN0_CC OR TN0.TN0_CC = '*' )
			AND SRA.RA_ADMISSA < %exp:dAteLaudo%
			AND SRA.%NotDel%
			AND CONCAT( SRA.RA_MAT, TN0.TN0_NUMRIS ) NOT IN (
				SELECT
					CONCAT( SRA.RA_MAT, TN0.TN0_NUMRIS )
				FROM
					%table:SRA% SRA
						INNER JOIN %table:TO0% TO0 ON
							%exp:cLaudo% = TO0.TO0_LAUDO
							AND %xFilial:TO0% = TO0.TO0_FILIAL
							AND TO0.TO0_TIPREL = '4'
							AND TO0.%NotDel%
						INNER JOIN %table:TO1% TO1 ON
							TO0.TO0_LAUDO = TO1.TO1_LAUDO
							AND %xFilial:TO1% = TO1.TO1_FILIAL
							AND TO1.%NotDel%
						INNER JOIN %table:TN0% TN0 ON
							TO1.TO1_NUMRIS = TN0.TN0_NUMRIS
							AND %xFilial:TN0% = TN0.TN0_FILIAL
							AND ( TN0.TN0_CC = %exp:cCenCusFil% OR TN0.TN0_CC = '*' )
							AND TN0.TN0_MAPRIS != '1'
							AND TN0.%NotDel%
						LEFT JOIN %table:TN6% TN6 ON
							SRA.RA_MAT = TN6.TN6_MAT
							AND %xFilial:TN6% = TN6.TN6_FILIAL
							AND TN6.TN6_CODTAR = TN0.TN0_CODTAR
							AND (
								( TN6.TN6_DTTERM = '' AND TN0.TN0_DTELIM = '' )
								OR ( TN6.TN6_DTTERM != '' AND TN0.TN0_DTELIM != ''
									AND NOT(
										( TN6.TN6_DTINIC < TN0.TN0_DTAVAL AND TN6.TN6_DTTERM < TN0.TN0_DTAVAL )
										OR ( TN6.TN6_DTINIC > TN0.TN0_DTELIM AND TN6.TN6_DTTERM > TN0.TN0_DTELIM )
									)
								)
								OR (
									TN6.TN6_DTTERM != ''
									AND TN0.TN0_DTELIM = ''
									AND NOT ( TN6.TN6_DTINIC < TN0.TN0_DTAVAL AND TN6.TN6_DTTERM < TN0.TN0_DTAVAL )
								)
								OR (
									TN6.TN6_DTTERM = ''
									AND TN0.TN0_DTELIM != ''
									AND NOT ( TN0.TN0_DTAVAL < TN6.TN6_DTINIC AND TN0.TN0_DTELIM < TN6.TN6_DTINIC )
								)
							)
							AND TN6.%NotDel%
				WHERE
					SRA.RA_FILIAL = %xFilial:SRA%
					AND SRA.RA_SITFOLH != 'D'
					AND SRA.RA_DEMISSA = ''
					AND ( SRA.RA_ADMISSA <= TN0.TN0_DTELIM OR TN0.TN0_DTELIM = '' )
					AND ( SRA.RA_CC = TN0.TN0_CC OR TN0.TN0_CC = '*' )
					AND ( SRA.RA_CODFUNC = TN0.TN0_CODFUN OR TN0.TN0_CODFUN = '*' )
					AND ( SRA.RA_DEPTO = TN0.TN0_DEPTO OR TN0.TN0_DEPTO = '*' )
					AND ( TN6.TN6_CODTAR = TN0.TN0_CODTAR OR TN0.TN0_CODTAR = '*' )
					AND SRA.%NotDel%
			)
		GROUP BY TN0.TN0_NUMRIS, TM0.TM0_NUMFIC, SRA.RA_MAT, SRA.RA_NOME
		ORDER BY TN0.TN0_NUMRIS
	EndSQL

	dbSelectArea( cAliasFun )
	dbGoTop()

	While !Eof()

		aAdd( aFun, {;
			TN0_NUMRIS,;
			TM0_NUMFIC,;
			RA_MAT,;
			RA_NOME;
		} )

		( cAliasFun )->( dbSkip() )

	End

	( cAliasFun )->( dbCloseArea() )

	For nI := 1 To Len( aRiscos )

		aFunRis := {}

		For nX := 1 To Len( aFun )

			If aFun[ nX, 1 ] == aRiscos[ nI, 1 ]
				aAdd( aFunRis, aFun[ nX ] )
			EndIf

		Next

		aAdd( aRiscos[ nI ], AllTrim( Str( Len( aFunRis ) ) ) ) // Quantidade de funcionários
		aAdd( aRiscos[ nI ], aFunRis ) // Informações dos funcionários

	Next

	If mv_par04 == 2
		aSort( aRiscos, /*nInicio*/, /*nCont*/, { | x, y | x[ 2 ] < y[ 2 ] } ) // Agente de risco
	ElseIf mv_par04 == 3
		aSort( aRiscos, /*nInicio*/, /*nCont*/, { | x, y | x[ 4 ] < y[ 4 ] } ) // Fonte geradora
	ElseIf mv_par04 == 4
		aSort( aRiscos, /*nInicio*/, /*nCont*/, { | x, y | x[ 5 ] < y[ 5 ] } ) // Centro de custo
	ElseIf mv_par04 == 5
		aSort( aRiscos, /*nInicio*/, /*nCont*/, { | x, y | x[ 6 ] < y[ 6 ] } ) // Função
	EndIf

	For nI := 1 To Len( aRiscos )

		// Só imprime os riscos que contém funcionários não expostos
		If Val( aRiscos[ nI, 15 ] ) > 0

			cListaFun := ''

			OLE_SetDocumentVar( oWord, 'cAgente', AllTrim( aRiscos[ nI, 2 ] ) )

			If aRiscos[ nI, 3 ] == '1'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0049 )
			ElseIf aRiscos[ nI, 3 ] == '2'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0050 )
			ElseIf aRiscos[ nI, 3 ]== '3'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0051 )
			ElseIf aRiscos[ nI, 3 ]== '4'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0052 )
			ElseIf aRiscos[ nI, 3 ] == '5'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0053 )
			ElseIf aRiscos[ nI, 3 ] == '6'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0054 )
			ElseIf aRiscos[ nI, 3 ] == '7'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0055 )
			ElseIf aRiscos[ nI, 3 ] == '8'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0064 )
			EndIf

			OLE_SetDocumentVar( oWord, 'cFonte', AllTrim( aRiscos[ nI, 4 ] ) )
			OLE_SetDocumentVar( oWord, 'cCenCus', AllTrim( aRiscos[ nI, 5 ] ) )
			OLE_SetDocumentVar( oWord, 'cFuncao', AllTrim( aRiscos[ nI, 6 ] ) )
			OLE_SetDocumentVar( oWord, 'cTarefa', AllTrim( aRiscos[ nI, 7 ] ) )
			OLE_SetDocumentVar( oWord, 'cDep', AllTrim( aRiscos[ nI, 8 ] ) )

			If Empty( aRiscos[ nI, 9 ] )
				OLE_SetDocumentVar( oWord, 'cAmb', STR0056 )
			Else
				OLE_SetDocumentVar( oWord, 'cAmb', AllTrim( aRiscos[ nI, 9 ] ) )
			EndIf

			OLE_SetDocumentVar( oWord, 'dDtAval', Dtoc( Stod( aRiscos[ nI, 10 ] ) ) )

			If aRiscos[ nI, 11 ] > 0
				If Empty( aRiscos[ nI, 14 ] )
					OLE_SetDocumentVar( oWord, 'cQtdAgen', AllTrim( cValToChar( aRiscos[ nI, 11 ] ) ) )
				Else
					OLE_SetDocumentVar( oWord, 'cQtdAgen', AllTrim( cValToChar( aRiscos[ nI, 11 ] ) ) + ' (' + AllTrim( aRiscos[ nI, 14 ] ) + ')' )
				EndIf
			Else
				OLE_SetDocumentVar( oWord, 'cQtdAgen', AllTrim( cValToChar( aRiscos[ nI, 11 ] ) ) )
			EndIf

			If aRiscos[ nI, 12 ] == '1'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0057 )
			ElseIf aRiscos[ nI, 12 ] == '2'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0058 )
			ElseIf aRiscos[ nI, 12 ] == '3'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0059 )
			ElseIf aRiscos[ nI, 12 ] == '4'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0060 )
			ElseIf aRiscos[ nI, 12 ] == '5'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0061 )
			Else
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0056 )
			EndIf

			If Empty( aRiscos[ nI, 13 ] )
				OLE_SetDocumentVar( oWord, 'cRec', STR0056 )
			Else
				OLE_SetDocumentVar( oWord, 'cRec', AllTrim( aRiscos[ nI, 13 ] ) )
			EndIf

			If nTipo == 1 // Sintético

				OLE_SetDocumentVar( oWord, 'nQtdLin', 12 ) // Quantidade de linhas necessárias para a tabela
				OLE_SetDocumentVar( oWord, 'cFun', aRiscos[ nI, 15 ] )

				OLE_ExecuteMacro( oWord, 'nao_expostos_sintetico' )
			Else
				// Funcionários
				For nX := 1 To Len( aRiscos[ nI, 16 ] )

					If Empty( aRiscos[ nI, 16, nX, 2 ] )
						cListaFun += STR0056 + '*' + AllTrim( aRiscos[ nI, 16, nX, 3 ] ) + '*' + AllTrim( aRiscos[ nI, 16, nX, 4 ] ) + '#'
					Else
						cListaFun += AllTrim( aRiscos[ nI, 16, nX, 2 ] ) + '*' + AllTrim( aRiscos[ nI, 16, nX, 3 ] ) + '*' + AllTrim( aRiscos[ nI, 16, nX, 4 ] ) + '#'
					EndIf

				Next

				OLE_SetDocumentVar( oWord, 'nQtdLin', 13 + Val( aRiscos[ nI, 15 ] ) ) // Quantidade de linhas necessárias para a tabela
				OLE_SetDocumentVar( oWord, 'cFun', cListaFun )

				OLE_ExecuteMacro( oWord, 'nao_expostos_analitico' )

			EndIf

		EndIf

	Next

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fSubCateg
Carrega no array os tipos de categoria do funcionario

@function Static Function
@author  Rodrigo Soledade
@since   15/09/2011

@param   cCateg, Caractere, Categorias separadas por barra
@sample  fSubCateg(M)
@return  aCateg, Array, Contém as categorias do funcionário
/*/
//-------------------------------------------------------------------
Static Function fSubCateg(cCateg)

	Local aCateg := {}
	Local nPos

	If !Empty( cCateg )
		If Substr( cCateg, 1, 1 ) == "/"
			cCateg := Substr( cCateg, 2 )
		EndIf
		If Substr( cCateg, Len( cCateg ), 1 ) <> "/"
			cCateg += "/"
		EndIf
		cCateg := AllTrim( cCateg )

		While .T.
			nPos := At( "/", cCateg )
			If nPos > 0
				If !Empty( Substr( cCateg, 1, nPos-1 ) ) .And. Substr( cCateg, 1, nPos-1 ) != "/"
					aADD( aCateg, Substr( cCateg, 1 ,nPos-1 ) )
				EndIf
				cCateg := Substr( cCateg, nPos+1 )
			Else
				Exit
			EndIf
		EndDo
	EndIf

Return aCateg
