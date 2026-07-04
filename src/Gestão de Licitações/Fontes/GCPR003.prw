/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'PROTHEUS.CH'
#include 'FWMVCDEF.CH'
#INCLUDE "MSOLE.CH" 
#INCLUDE "GCPR003.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GCPR003  บAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Geracao do Extrato de Homologacao                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GCP - Gestใo de Compras Publicas                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GCPR003(cNumPro,cCodEdt)
Local aDados	:= {}
Local aRet		:= {}                               
Local aItemEdt	:= {}                           
Local aDadosWord:= {}
Local aSldItem  := {}
Local lRet		:= .T.
//-- Integracao Word
Local cArquivo	:= AllTrim(GETMV("MV_GCPHOMG",,"GCP_EXTHOM"))
Local cArqDest	:= "" //cArquivo
Local cArqDot	:= cArquivo+".DOT"     // Nome do Arquivo MODELO do Word
Local cPathDot	:= AllTrim(GETMV("MV_GCPDOT",,"\samples\documents\gcp\dot\")) // PATH DO ARQUIVO MODELO WORD
//-- Define variaveis que devem sair no documento
Local cCnpj		:= ""
Local cDescProd	:= ""
Local cNomFornec:= ""
Local cLote	:= ""
//NO SERVIDOR ; CONFIGURAR PATH ABAIXO DO ROOTPATH PROTHEUS E INFORMAR NO PARAMETRO
Local cPathDoc	:= AllTrim(GETMV("MV_GCPDOC",,"\samples\documents\gcp\doc\")) + AllTrim(cCodEdt)+"\" // PATH PARA GRAVACAO DOS ARQUIVO WORD GERADOS
Local cAliasCO2	:= ""
Local nCntFor	:= 0     
Local nX		:= 1


Private oWord
Private nCntLin := 0 ; nCntCol := 0
Private cPathEst:= Alltrim(GetNewPar("MV_GCPDEST","C:\WORDTMP\")) + AllTrim(cCodEdt)+"\" // PATH DO ARQUIVO A SER ARMAZENADO NA
Private cPerg	:= "GCR003"

Default cNumPro := CriaVar("CO1_NUMPRO",.T.)
Default cCodEdt	:= CriaVar("CO1_CODEDT",.T.)


//Caso a chamada seja feita pelo EDITAL
If FunName() == "GCPA002"
	cCodEdt := CO1->CO1_CODEDT
	cNumPro := CO1->CO1_NUMPRO
Else
	If Pergunte(cPerg,.T.)
		cCodEdt   := MV_PAR01
		cNumPro   := MV_PAR02
	
		DbSelectArea("CO1")
		DbSetOrder(1)
		If !DbSeek(xFilial("CO1")+cCodEdt+cNumPro)
	   		Help(" ",1,"GCPR03EDT")//"Edital nใo encontrado"
			Return(.F.)
		EndIf
		
		If CO1->CO1_ETAPA $ 'PE/PR'
			HELP("   ",1,"GCPRELREV",,STR0002 ,1)//"Edital Revogado/Cancelado, nใo ้ possํvel emitir o relat๓rio"
			Return(.F.)
		EndIf
	Else
		Return(.T.)
	EndIf
EndIf
	
cAlias := If(CO1->CO1_MODALI == "LL","SA1","SA2")
cAval  := CO1->CO1_AVAL

DbSelectArea("SM0")
SM0->(MsSeek(cEmpAnt+cFilAnt))
cCNPJ := Transform(SM0->M0_CGC, "@R 99.999.999/9999-99")
cNomeEmp := SM0->M0_NOMECOM

MsgRun(STR0001,,{|| aDados := GCPA009()})//"Verificando ganhadores..."

If Len(aDados) == 0    
	HELP("   ",1,"GCPNOGAN",,STR0003 ,1)//"Na etapa atual do Edital, nใo hแ vencedores selecionados "
	Return(.T.)
Endif	

For nX := 1 To Len(aDados)
	cPartic := aDados[nX,1]
	cLoja   := aDados[nX,2]
	cCodpro := aDados[nX,3]
	nQuant  := aDados[nX,4]
	nVlUnit := aDados[nX,5]
	cLote	:= aDados[nX,Len(aDados[nx])]

	aSldItem := {cCodEdt,cNumPro,cCodPro}
	GCPSldItem("3",aSldItem)
	//-- Se nao efetuou a entrega total, abate a quantidade ja entregue (CO2_QUANT - C7_QUJE)
	//-- Se efetuou a entrega total devera permanecer com a quantidade original CO2_QUANT
	If	aSldItem[1]<nQuant
		nQuant -= aSldItem[1]
	EndIf		

	SB1->(DbSetOrder(1))
	SB1->(DbSeek(xFilial("SB1")+cCodPro))

	DbSelectArea(cAlias)
	DbSetOrder(1)
	DbSeek(xFilial(cAlias)+cPartic+cLoja)
	cCampo := SubStr(cAlias,2,2)+"_NOME"
	cNomFornec := &(cCampo)

	If	cAval=="2" .Or. cAval=="3"

		nItem := AScan(aItemEdt,{|x|x[1]+x[2]+x[8]==cPartic+cLoja+cLote})
		
		If	nItem == 0
			AAdd(aItemEdt,{cPartic,cLoja,cNomFornec,cCodPro,AllTrim(SB1->B1_DESC),0,nVlUnit,Iif(cAval=="2",cLote,Space(TamSX3("CO3_LOTE")[1]))})
			nItem := Len(aItemEdt)
	  	Else
			AAdd(aItemEdt,{cPartic,cLoja," ",cCodPro,AllTrim(SB1->B1_DESC),0," "," "})
		EndIf            
		aItemEdt[nItem,6] += nQuant
	Else
		nItem := AScan(aItemEdt,{|x|x[1]+x[2]==cPartic+cLoja})
		AAdd(aItemEdt,{cPartic,cLoja,cNomFornec,cCodPro,AllTrim(SB1->B1_DESC),nQuant,(nQuant * nVlUnit)," "})
	EndIf
Next

If	lRet

	If Empty(cArquivo)
		Return("")
	Endif
	oWord := OLE_CreateLink()
	
	If Empty(cPathEst)
		cPathEst := "C:\WORDTMP\" + AllTrim(cCodEdt)+"\"
	EndIf
		
	MontaDir(cPathEst)
	
	If !File(cPathDot + cArqDot) // Verifica a existencia do DOT no ROOTPATH Protheus / Servidor 
		cMsg := "Atencao... " + cPathDot + cArqDot + " nao encontrado no Servidor" 
		Help("",1,"GCPARQ","",cMsg,1,0)
		Return(.F.)
	EndIf
	
	// Caso encontre arquivo ja gerado na estacao
	//com o mesmo nome apaga primeiramente antes de gerar a nova impressao
	If File( cPathEst + cArqDot )
		Ferase( cPathEst + cArqDot )
	EndIf
	
	CopiaArq(cPathDot,cPathEst,cArqDot)
	//CpyS2T(cPathDot,cPathEst,.T.) // Copia do Server para o Remote, eh necessario
	//para que o wordview e o proprio word possam preparar o arquivo para impressao e
	// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
	// estacao , por exemplo C:\WORDTMP       
	
	cArqDest := cArquivo+Alltrim(cCodEdt)+cNumPro
	
	//Cria novo arquivo no Word na estacao
	OLE_NewFile( oWord, cPathEst + cArqDot)
	
	//Salva o arquivo com o novo nome na estacao
	OLE_SaveAsFile( oWord, cPathEst + cArqDest+".DOT", , , .F., oleWdFormatDocument )

	//--- Cabecalho
	// Preenche Variaveis do .DOT
	OLE_SetDocumentVar(oWord, "cCnpj"	, cCNPJ		)
	OLE_SetDocumentVar(oWord, "cNomeEmp", cNomeEmp	)
	OLE_SetDocumentVar(oWord, "cCodEdt"	, cCodEdt	)
	OLE_SetDocumentVar(oWord, "cNumPro"	, cNumPro	)
                                                            

	OLE_SetDocumentVar(oWord, "nTotItens", Str(Len(aItemEdt)) )  //Str(Len(aDados)) )  

	MsgRun(STR0005,,{|| aDados := GCPA009()})//"Verificando ganhadores..."
                               
	//-- Executa a macro para preenchimento do cabecalho
	OLE_SetDocumentVar(oWord, "nTotItens", Str(Len(aDados)) )

	//-- Montagem das variaveis dos itens
	For nCntFor := 1 To Len(aItemEdt)
		OLE_SetDocumentVar(oWord,"cDescProd"+AllTrim(Str(nCntFor)),aItemEdt[nCntFor,5])
		OLE_SetDocumentVar(oWord,"cNomFornec"+AllTrim(Str(nCntFor)),aItemEdt[nCntFor,3])//aDados[nCntFor,1])
		If	Empty(aItemEdt[nCntFor,7])
			OLE_SetDocumentVar(oWord,"nValor"+AllTrim(Str(nCntFor)),aItemEdt[nCntFor,7])
		Else
			OLE_SetDocumentVar(oWord,"nValor"+AllTrim(Str(nCntFor)),Transform(aItemEdt[nCntFor,7], "@E 9,999,999,999.99"))
		EndIf
		OLE_SetDocumentVar(oWord,"cLote"+AllTrim(Str(nCntFor)),aItemEdt[nCntFor,8])
	Next
	
	//-- Executa a macro de grid
	OLE_ExecuteMacro(oWord,"tabitens")

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualizando as variaveis do documento do Word                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	OLE_UpdateFields(oWord)
	OLE_SaveAsFile( oWord, cPathEst + cArqDest+".DOC", , , .F., oleWdFormatDocument )
	                                                 
	While .T.
		Aviso("Emissao Extrato de Homologa็ใo","Deseja fechar o documento ?",{"Sim"}) 
			OLE_CloseFile(oWord)	
			OLE_CloseLink(oWord)
			Exit
	EndDo
	
	If File(cPathEst + cArqDest+".DOT")
		FErase(cPathEst + cArqDest+".DOT")
	EndIf
	
	//Caso nao exista, cria o diretorio no servidor
	MontaDir(cPathDoc)
	
	// Caso encontre arquivo ja gerado no Servidor
	//com o mesmo nome apaga primeiramente antes de gerar a nova impressao
	If File( cPathDoc + cArqDest+".DOC" )
		Ferase( cPathDoc + cArqDest+".DOC" )
	EndIf
	
	//COPIA O ARQUIVO GERADO NO SERVIDOR
	CopiaArq(cPathEst,cPathDoc,cArqDest+".DOC")
	
EndIf
DbSelectArea("CO1")


Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CopiaArq บAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Realiza a copia de arquivo do servidor para o remote       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CopiaArq(cAtuDir,cNomeDir,cArquivo)

cNomeDir := Alltrim(cNomeDir)
__COPYFILE(cAtuDir+cArquivo,cNomeDir+cArquivo)
	

Return .T.
