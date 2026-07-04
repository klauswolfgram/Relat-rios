/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'TOTVS.CH'
#INCLUDE 'MSOLE.CH'
#INCLUDE 'TECR894.CH'

Static aItens		:= {} //Array com os itens de Reimpressão selecionados

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR894
IMpressão do Termo de entrega

@author		Serviços
@since		11/06/2019
@version	P12.1.23
/*/
//------------------------------------------------------------------------------
User Function TECR894(aItProd,lAutomato)
Local lOk        	:= .F.
Local aSays      	:= {}
Local aButtons   	:= {}
Local aParams    	:= {}
Local cFuncDe    	:= TXC->TXC_CODTEC
Local cFuncAte   	:= TXC->TXC_CODTEC
Local cPathServer	:= Alltrim(SuperGetMv("MV_TECPATH"))	//Diretorio que estao os DOTS originais

Default aItProd		:= {}
Default lAutomato   := .F.

aItens := aClone(aItProd)

//Parametros para seleção utilizados na impressão
aAdd(aParams, {3, STR0001	, 1, {STR0002, STR0003}, 90,, .T.})		//-- MV_PAR01
aAdd(aParams, {3, STR0004	, 1, {STR0005, STR0006}, 90,, .T.})		//-- MV_PAR02
aAdd(aParams, {3, STR0007	, 1, {STR0008, STR0009}, 100,, .T.})	//-- MV_PAR03

If !lAutomato .And. ParamBox(aParams, STR0013)//'Parâmetros'
	// -----------------------------------------------------
	// Dialogo principal para parametrizacao
	// -----------------------------------------------------
	AAdd(aSays, STR0010)
	AAdd(aSays, STR0011)
	AAdd(aSays, STR0012 + cPathServer)
	AAdd(aButtons, {5, .T., {|| ParamBox(aParams, STR0013)}})
	AAdd(aButtons, {1, .T., {|o| lOk := .T.,o:oWnd:End()}})
	AAdd(aButtons, {2, .T., {|o| o:oWnd:End()}})

	FormBatch(STR0014, aSays, aButtons,,, 650)
else
	lOk := .T.
	ChkPerGrv()
Endif	

If lOk
		Processa({|lEnd| AtR894Prc(@lEnd,cFuncDe,cFuncAte,cPathServer,lAutomato)}, STR0015, STR0016, .T.)
EndIf


Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} AtR894Prc
Realiza a impressão do documento

@author		Serviços
@since		11/06/2019
@version	P12.1.23
/*/
//------------------------------------------------------------------------------
Static Function AtR894Prc(lEnd,cFuncDe,cFuncAte,cPathServer,lAutomato)
Local cAliasQry  := ''
Local lContinua  := .T.
Local cArqModel  := ''
Local cExtension := ''
Local cPathDest  := ''
Local cDestino   := MV_PAR01 
Local cSaveAs    := MV_PAR02
Local cVersWord  := MV_PAR03 
Local aDadosImp  := {}
Local nCountA    := 0
Local nCountB    := 0
Local nPosA      := 0
Local lRHProt	:= SuperGetMv("MV_GSXINT",.F., "2") == "2"
Local cArqTemp := ""
Local cNewFile := ""
Local cTempPath := IIF(!lAutomato,GetTempPath(),"")

Default lAutomato   := .F.

// --------------------------------------------
// TRATA A VERSAO DO MS WORD
// --------------------------------------------
If cVersWord == 1
	cArqModel := cPathServer + 'TECR894.DOT'
	//-- Se a versao do Ms Word for a 97/2003 nao permite
	//-- a saida do relatorio em PDF
	If cSaveAs == 1
		Aviso(STR0017, STR0018, {STR0019}, 2)//'Não é possível realizar a geração do documento no formato "PDF" para versao 97/2003 do Microsoft Word. O formato do documento será reajustado para "DOC"'
		cSaveAs := 2
	EndIf
Else
	cArqModel   := cPathServer + 'TECR894.DOTM'
EndIf


// ---------------------------------------
// VERIFICA SE O ARQUIVO "MODELO" EXISTE
// ---------------------------------------
If !lAutomato .And. !File(cArqModel)
	lContinua := .F.
	Aviso(STR0017, STR0020 + cArqModel + STR0021, {STR0019}, 2)//'O arquivo ',' não existe! Entre em contato com o Administrador do sistema.'
EndIf


// ---------------------------------------
// TRATA GRAVACAO EM DISCO
// ---------------------------------------
If lContinua
	If cDestino == 2
		cExtension := If(cSaveAs == 1, '*.PDF', If(cVersWord == 1, '*.DOC', '*.DOCX'))
		cPathDest  := Alltrim(cGetFile(STR0022 + cExtension + '|' + cExtension +'|' , STR0023, 1, '', .T., GETF_LOCALHARD+GETF_RETDIRECTORY,.F.))
		If Empty(cPathDest)
			Aviso(STR0017, STR0024, {STR0019}, 2)
			lContinua := .F.
		Else
			lContinua := ChkPerGrv(cPathDest)
			If !lContinua
				Aviso(STR0017, STR0025, {STR0019}, 2)
			EndIf
		EndIf
	Endif
EndIf


// ------------------------------------------------
// TRANSFERE MODELO WORD DO SERVIDOR P/ ESTACAO
// ------------------------------------------------
If !lAutomato .And. lContinua 
	If !CpyS2T(cArqModel, AllTrim(cTempPath))
		lContinua := .F.
		Aviso(STR0017, STR0026, {STR0019}, 2)
	Else
		// --------------------------------------------------------
		// SE CONSEGUIU TRANSFERIR O ARQUIVO, RENOMEIA O MESMO
		// PARA PREVENIR, EM CASO DE ERRO, O TRAVAMENTO DO ARQUIVO
		// DE MODELO
		// --------------------------------------------------------
		cArqTemp  := GetNextAlias() + If(cVersWord == 1, '.dot', '.dotm')

		FRename(AllTrim(cTempPath) + If(Right(AllTrim(cTempPath), 1) == '\', '', '\') + 'TECR894' + If(cVersWord == 1, '.dot', '.dotm'),;
				AllTrim(cTempPath) + If(Right(AllTrim(cTempPath), 1) == '\', '', '\') + cArqTemp)

		cArqTemp := AllTrim(cTempPath) + If(Right(AllTrim(cTempPath), 1) == '\', '', '\') + cArqTemp

	EndIf
EndIf

// ------------------------------------------
// IMPRESSAO DO DOCUMENTO
// ------------------------------------------
If lContinua .And. Empty(aItens)
	// ------------------------------------------
	// PROCESSA QUERY PARA IMPRESSAO DO DOCUMENTO
	// ------------------------------------------
	cAliasQry := GetNextAlias()
	BeginSQL Alias cAliasQry
		SELECT TXD.TXD_CODTEC, AA1.AA1_NOMTEC , SRA.RA_CIC, TXD.TXD_CODPRO, SB1.B1_DESC, TXD.TXD_QTDE, TXD.TXD_DTVAL
		  FROM %Table:TXD% TXD
		  JOIN %Table:AA1% AA1
		    ON AA1.AA1_FILIAL = %xFilial:AA1%
		   AND AA1.AA1_CODTEC = TXD.TXD_CODTEC
		   AND AA1.%NotDel%
		  LEFT JOIN %Table:SRA% SRA
		    ON SRA.RA_FILIAL = AA1.AA1_FUNFIL
		   AND SRA.RA_MAT = AA1.AA1_CDFUNC
		   AND SRA.%NotDel%
		  JOIN %Table:SB1% SB1
		    ON SB1.B1_FILIAL = %xFilial:SB1%
		   AND SB1.B1_COD = TXD.TXD_CODPRO
		   AND SB1.%NotDel%
		 WHERE TXD.TXD_FILIAL = %xFilial:TXD%
		   AND TXD.TXD_CODTEC BETWEEN %Exp:cFuncDe% AND %Exp:cFuncAte%
		   AND TXD.TXD_DTENTR <> ' '
		   AND TXD.%NotDel%
	EndSQL

	If !(cAliasQry)->(Eof())
		While !(cAliasQry)->(Eof())
			nPosA := aScan(aDadosImp, {|x| x[1] == (cAliasQry)->TXD_CODTEC}) 
			If nPosA == 0
				aAdd(aDadosImp, {(cAliasQry)->TXD_CODTEC, (cAliasQry)->AA1_NOMTEC, IIF(lRHProt, Transform((cAliasQry)->RA_CIC, PesqPict('SRA', 'RA_CIC')), ""), {}})
				nPosA := Len(aDadosImp)
			EndIf
				aAdd(aDadosImp[nPosA, 4], {	AllTrim((cAliasQry)->TXD_CODPRO),;
											AllTrim((cAliasQry)->B1_DESC),;
											Transform((cAliasQry)->TXD_QTDE, PesqPict('TXD', 'TXD_QTDE')),;
											DtoC(StoD((cAliasQry)->TXD_DTVAL)) })								
			(cAliasQry)->(DbSkip())
		End
		
		(cAliasQry)->(DbSkip())
		
		For nCountA := 1 To Len(aDadosImp)
			//-- Arquivo que sera gerado:
			cNewFile := cPathDest + If(Right(cPathDest, 1) == '\', '', '\') + DtoS(dDataBase) + '_' + StrTran(Time(), ':', '') + '_TECR894' + StrTran(cExtension, '*', '')

			// --------------------------------------
			// ESTABELECE COMUNICACAO COM O MS WORD
			// --------------------------------------
			oWord := OLE_CreateLink()
			OLE_SetProperty(oWord, oleWdVisible, .F.)
			If oWord == "-1"
				Aviso(STR0017, STR0027, {STR0019}, 2)
				Exit
			Else

				// -----------------------------------
				// CARREGA MODELO
				// -----------------------------------
				OLE_NewFile(oWord, Alltrim(cArqTemp))

				// -------------------------------------------
				// REALIZA O PROCESSO DE MACRO SUBSTITUICAO
				// DOS CAMPOS DO MODELO WORD
				// -------------------------------------------
				OLE_SetDocumentVar(oWord, 'cNomeFunc'		, aDadosImp[nCountA, 2])
				OLE_SetDocumentVar(oWord, 'cCPF'			, aDadosImp[nCountA, 3])

				For nCountB := 1 To Len(aDadosImp[nCountA, 4])
					OLE_SetDocumentVar(oWord, 'cCodigo' + AllTrim(Str(nCountB))		, aDadosImp[nCountA, 4, nCountB, 1])					
					OLE_SetDocumentVar(oWord, 'cDescr' + AllTrim(Str(nCountB)) 		, aDadosImp[nCountA, 4, nCountB, 2])
					OLE_SetDocumentVar(oWord, 'nQtde' + AllTrim(Str(nCountB))		, aDadosImp[nCountA, 4, nCountB, 3])
					OLE_SetDocumentVar(oWord, 'dDtValidade' + AllTrim(Str(nCountB))	, aDadosImp[nCountA, 4, nCountB, 4])
				Next nCountB

				OLE_SetDocumentVar(oWord, 'nItens', AllTrim(Str(Len(aDadosImp[nCountA, 4]))))
				OLE_ExecuteMacro(oWord, "mcrUniformes")

				//-- Atualiza os campos
				OLE_UpDateFields(oWord)

				//-- Determina a saida do relatorio:
				If cDestino == 1
					OLE_PrintFile(oWord, cNewFile,,, 1)
					Sleep(1000)
				Else
					OLE_SaveAsFile(oWord, cNewFile,,,, If(cSaveAs == 1, '17', NIL)) //--Parametro '17' salva em pdf
				Endif

				//--Fecha link com MS-Word
				OLE_CloseFile(oWord)
				OLE_CloseLink(oWord)
			EndIf

		End
		MsgInfo(STR0028)

	Else
		MsgAlert(STR0029)

	EndIf
	

	
ElseIf lContinua
	For nCountA := 1 To Len(aItens)
		//-- Arquivo que sera gerado:
		cNewFile := cPathDest + If(Right(cPathDest, 1) == '\', '', '\') + DtoS(dDataBase) + '_' + StrTran(Time(), ':', '') + '_TECR894' + StrTran(cExtension, '*', '')

			// --------------------------------------
			// ESTABELECE COMUNICACAO COM O MS WORD
			// --------------------------------------
			oWord := OLE_CreateLink()
			OLE_SetProperty(oWord, oleWdVisible, .F.)
			If oWord == "-1"
				Aviso(STR0017, STR0030, {STR0019}, 2)
				Exit
			Else

				// -----------------------------------
				// CARREGA MODELO
				// -----------------------------------
				OLE_NewFile(oWord, Alltrim(cArqTemp))

				// -------------------------------------------
				// REALIZA O PROCESSO DE MACRO SUBSTITUICAO
				// DOS CAMPOS DO MODELO WORD
				// -------------------------------------------
				OLE_SetDocumentVar(oWord, 'cNomeFunc'		, aItens[nCountA, 2])
				OLE_SetDocumentVar(oWord, 'cCPF'			, aItens[nCountA, 3])

				For nCountB := 1 To Len(aItens[nCountA, 4])
					OLE_SetDocumentVar(oWord, 'cCodigo' + AllTrim(Str(nCountB))		, aItens[nCountA, 4, nCountB, 1])					
					OLE_SetDocumentVar(oWord, 'cDescr' + AllTrim(Str(nCountB)) 		, aItens[nCountA, 4, nCountB, 2])
					OLE_SetDocumentVar(oWord, 'nQtde' + AllTrim(Str(nCountB))		, aItens[nCountA, 4, nCountB, 3])
					OLE_SetDocumentVar(oWord, 'dDtValidade' + AllTrim(Str(nCountB))	, aItens[nCountA, 4, nCountB, 4])
				Next nCountB

				OLE_SetDocumentVar(oWord, 'nItens', AllTrim(Str(Len(aItens[nCountA, 4]))))
				OLE_ExecuteMacro(oWord, "mcrUniformes")

				//-- Atualiza os campos
				OLE_UpDateFields(oWord)

				//-- Determina a saida do relatorio:
				If cDestino == 1
					OLE_PrintFile(oWord, cNewFile,,, 1)
					Sleep(1000)
				Else
					OLE_SaveAsFile(oWord, cNewFile,,,, If(cSaveAs == 1, '17', NIL)) //--Parametro '17' salva em pdf
				Endif

				//--Fecha link com MS-Word
				OLE_CloseFile(oWord)
				OLE_CloseLink(oWord)
			EndIf

		End
		MsgInfo(STR0028)
	
EndIf

//-- Exclui arquivo modelo na estacao:
FErase(cArqTemp)

//Limpa a Variavel
aItens := {}

Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} ChkPerGrv
Checa permissao de gravacao na pasta indicada para geracao
do relatorio

@author		Serviços
@since		11/06/2019
@version	P12.1.23
/*/
//------------------------------------------------------------------------------
Static Function ChkPerGrv(cPath)
Local cFileTmp := CriaTrab(NIL, .F.)
Local nHdlTmp  := 0
Local lRet     := .F.

cPath   := AllTrim(cPath)
nHdlTmp := MSFCreate(cPath + If(Right(cPath, 1) <> '\', '\', '') + cFileTmp + '.TMP', 0)
If nHdlTmp <= 0
	lRet := .F.
Else
	lRet := .T.
	FClose(nHdlTmp)
	FErase(cPath + If(Right(cPath, 1) <> '\', '\', '') + cFileTmp + '.TMP')
EndIf

Return(lRet)
