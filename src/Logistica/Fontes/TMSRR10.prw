/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "tbiconn.ch"
#include "topconn.ch"
#include "TMSRR10.CH"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ TMSRR10	   ³ Autor ³ Andre Godoi		     ³ Data ³17/09/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Mercadoria em poder de redespachante                         ³±±
±±³			  ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³                                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function TMSRR10()
Local cDesc1  		:= STR0001		//-- "Mercadoria em poder de redespachante"
Local cDesc2  		:= ""
Local cDesc3  		:= ""
Local cPict   		:= ""
Local titulo  		:= STR0001		//-- "Mercadoria em poder de redespachante"
Local imprime 		:= .T.
Local aOrd    		:= {}
Local cPerg   		:= 'TMAR10'
Local aCposProtg	:= {}
Local aCpoAccess	:= {'A2_NOME'}

Private nLin        := 80
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nTipo       := ""
Private NomeProg    := "TMAR10" 	// Coloque aqui o nome do programa para impressao no cabecalho //"RELATORIO"
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1} //
Private nLastKey    := 0
Private pag         := 01
Private wnrel       := "TMAR10" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString     := ""
Private m_pag       := 01
Private CONTFL      := 01
Private cbtxt       := Space(10)
Private cbcont      := 00

If ExistFunc('TMLGPDCpPr')
	aCposProtg := TMLGPDCpPr(aCpoAccess, "SA2")
	If ExistFunc('FWPDCanUse') .And. FWPDCanUse() .And. !Empty(aCposProtg)
		If Len(FwProtectedDataUtil():UsrAccessPDField( __CUSERID, aCposProtg )) < Len(aCposProtg)
			Help(" ",1,STR0045,,,5,11) //"LGPD - Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Para mais informações contate o Administrador do sistema !!"
			Return
		EndIf	
	EndIf
EndIf

If !Pergunte( cPerg, .T. )
	Return .T.
End	

If MV_PAR07 == 3		//-- Ambos tipos de documentos.
	cDesc2 := STR0002		//-- "Documentos indicados para entrega e entregue"
ElseIf MV_PAR07 == 2	//-- Documentos entregue.
	cDesc2 := STR0003		//-- "Documentos entregue"
ElseIf MV_PAR07 == 1	//-- Documentos indicados p/ entrega.
	cDesc2 := STR0004		//-- "Documentos indicados para entrega"
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|| TMSRSEL(Titulo,nLin) },Titulo)

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return Nil
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ TMSREXC    ³ Autor ³ Andre Godoi		     ³ Data ³17/09/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ 																				  ³±±
±±³			  ³														  						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ 								                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMSRSEL(Titulo,nLin)

Local Cabec1  	:= STR0005		//-- "Documentos selecionados"
Local Cabec2  	:= ''
Local cAlias 	:= GetNextAlias()
Local cQuery	:=	''
Local cStatus	:= ''
Local lCmpDFV := DFV->(ColumnPos("DFV_FILORI")) > 0 .And. DFV->(ColumnPos("DFV_TIPVEI")) > 0

If MV_PAR07 == 3		//-- Ambos tipos de documentos.
	Cabec2 := STR0002		//-- "Documentos indicados para entrega e entregue"
ElseIf MV_PAR07 == 2	//-- Documentos entregue.
	Cabec2 := STR0003		//-- "Documentos entregue"
ElseIf MV_PAR07 == 1	//-- Documentos indicados p/ entrega.
	Cabec2 := STR0004		//-- "Documentos indicados para entrega"
EndIf	

//-- Seleção de todos os Regisro que serão contidos no Relatório
cQuery := "SELECT DFV.DFV_FILDOC, DFV.DFV_DOC, DFV.DFV_SERIE, DFV.DFV_VALMER, DFV.DFV_QTDVOL, DFV.DFV_NUMRED, "
If lCmpDFV
	cQuery += " DFV.DFV_FILORI, "
EndIf
If SerieNfId("DFV",3,"DFV_SERIE")=="DFV_SDOC"
	cQuery += "   DFV.DFV_SDOC, "
EndIf
cQuery += " 		SAD.A1_NOME NOME_SAD, SAR.A1_NOME NOME_SAR, "
cQuery += " 		SA2.A2_COD, SA2.A2_LOJA, SA2.A2_NOME, "
cQuery += " 		DT6.DT6_DATENT DATA_ENTREGA, DT6.DT6_DATEMI DATA_EMISSAO, DT6.DT6_PRZENT "
cQuery += " FROM " + RetSqlName( "DFV" ) + " DFV "

cQuery += " INNER JOIN "+ RetSqlName("DT6") 	 + " DT6 ON "
cQuery += " DT6.DT6_FILIAL		= '" + xFilial("DT6") + "' AND "
cQuery += " DT6.DT6_FILDOC		= DFV.DFV_FILDOC	AND "
cQuery += " DT6.DT6_DOC	 		= DFV.DFV_DOC		AND "
cQuery += " DT6.DT6_SERIE 		= DFV.DFV_SERIE "

cQuery += " INNER JOIN "+ RetSqlName("SA2") 	 + " SA2 ON "
cQuery += " SA2.A2_FILIAL	= '" + xFilial("SA2") + "' AND "
cQuery += " SA2.A2_LOJA		= DFV.DFV_LOJFOR	AND "
cQuery += " SA2.A2_COD 		= DFV.DFV_CODFOR "

cQuery += " INNER JOIN "+ RetSqlName("SA1") 	 + " SAD ON "
cQuery += " SAD.A1_FILIAL	= '" + xFilial("SA1") + "' AND "
cQuery += " SAD.A1_COD		= 	DT6.DT6_CLIDES		AND "
cQuery += " SAD.A1_LOJA	 	= 	DT6.DT6_LOJDES "

cQuery += " INNER JOIN "+ RetSqlName("SA1") 	 + " SAR ON "
cQuery += " SAR.A1_FILIAL	= '" + xFilial("SA1") + "' AND "
cQuery += " SAR.A1_COD		= 	DT6.DT6_CLIREM		AND "
cQuery += " SAR.A1_LOJA	 	= 	DT6.DT6_LOJREM "

cQuery += " WHERE DFV.DFV_FILIAL = '" + xFilial("DFV") + "' AND"
cQuery += " 		SA2.A2_COD			>='" + MV_PAR01 + "' AND"
cQuery += " 		SA2.A2_LOJA 		>='" + MV_PAR02 + "' AND"
cQuery += " 		SA2.A2_COD			<='" + MV_PAR03 + "' AND"
cQuery += " 		SA2.A2_LOJA 		<='" + MV_PAR04 + "' AND"
cQuery += " 		DT6.DT6_DATEMI 	>='" + dTos(MV_PAR05) + "' AND"
cQuery += " 		DT6.DT6_DATEMI 	<='" + dTos(MV_PAR06) + "' AND"

If MV_PAR07 == 3		//-- Ambos tipos de documentos.
	cStatus := " (DFV.DFV_STATUS	= '2' OR DFV.DFV_STATUS	= '3') AND "
ElseIf MV_PAR07 == 2	//-- Documentos documento entregue.
	cStatus := " DFV.DFV_STATUS	= '3' AND "
ElseIf MV_PAR07 == 1	//-- Documentos indicados p/ entrega.
	cStatus := " DFV.DFV_STATUS	= '2' AND "
EndIf	

cQuery += cStatus
cQuery += " 		DFV.D_E_L_E_T_ 	= ' '	AND"
cQuery += " 		SAD.D_E_L_E_T_ 	= ' ' AND"
cQuery += " 		SAR.D_E_L_E_T_ 	= ' ' AND"
cQuery += " 		SA2.D_E_L_E_T_ 	= ' ' AND"
cQuery += " 		DT6.D_E_L_E_T_ 	= ' ' "
cQuery += " ORDER BY SA2.A2_COD, SA2.A2_LOJA, DFV.DFV_FILDOC, DFV.DFV_DOC, DFV.DFV_SERIE"

cQuery := ChangeQuery ( cQuery )

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAlias, .T., .F. )

If (cAlias)->(EOF())
	Aviso(STR0006, STR0007, {"Ok"} )		//-- "Atenção" // "Não existe informação para os parametros indicados !"
	(cAlias)->(DbCloseArea())
	Return Nil
EndIf

TMSRMNT(Cabec1,Cabec2,Titulo,nLin, cAlias)

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ TMSRMNT    ³ Autor ³ Andre Godoi		     ³ Data ³17/09/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ 														  						  ³±±
±±³			  ³																			  	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ 								                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMSRMNT(Cabec1,Cabec2,Titulo,nLin, cAlias)
Local cRedesp	:= ''
Local cAliasDua := ''  
Local cDtOcor	:= ''       
Local cOcorBx   := PadR(SuperGetMv('MV_OCORRDP',,""), TamSx3('DUA_CODOCO')[1])
Local cAliasDT2 := ''
Local cDescri	:= ''
Local cDtEntrada:= ''
Local cAliasDes := ''
Local lCmpDFV := DFV->(ColumnPos("DFV_FILORI")) > 0 .And. DFV->(ColumnPos("DFV_TIPVEI")) > 0

While !(cAlias)->(EOF())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 PSAY STR0008		//-- "*** CANCELADO PELO OPERADOR ***"
		(cAlias)->(DbCloseArea())
		Exit
	Endif  
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If nLin > 55 .Or. cRedesp	<> (cAlias)->A2_COD + (cAlias)->A2_LOJA + (cAlias)->A2_NOME
		If nLin > 55 
			nLin := 5
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		EndIf

		//             1         2         3         4         5         6         7         8         9        100       110       120       130       140       150       160       170       180       190       200      210       220
		//   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		//  "Remetente :					 																													    																 	 99,999,999,999.99"
		//	 "Código		  Loja		Nome																													 "
		//	 "Filial  Doc.     Série  Nome Remet.              Nome Dest.               Dt.Entrada    Dt.Emissao   Prz.Entraga   Dt. Entrega   Dias atraso   Qtde Volume     Vl. Mercadoria     Dt.Redesp    NºRedesp  Ultima Ocorrencia"
	
		nLin	:= nLin + 3
		@ nLin,000 PSAY STR0009		//-- "'Redespachante:"
		nLin++
		
		@ nLin,000 PSAY STR0010		//-- "Código "
		@ nLin,012 PSAY STR0011		//-- "Loja "
		@ nLin,022 PSAY STR0012		//-- "Nome "
		nLin++
	
		@ nLin,000 PSAY (cAlias)->A2_COD
		@ nLin,012 PSAY (cAlias)->A2_LOJA
		@ nLin,022 PSAY (cAlias)->A2_NOME
		nLin	:= nLin + 2 
		
		@ nLin,000 PSAY STR0013		//-- "Filial"
		@ nLin,008 PSAY STR0014		//-- "Doc."
		@ nLin,019 PSAY STR0015		//-- "Série"
		@ nLin,025 PSAY STR0016		//-- "Nome Remet."
		@ nLin,046 PSAY STR0017		//-- "Nome Dest."
		@ nLin,066 PSAY STR0018		//-- "Dt. Entrada"
		@ nLin,078 PSAY STR0040		//-- "Dt. Entrada"
		@ nLin,090 PSAY STR0019		//-- "Prz. Entraga"
		@ nLin,103 PSAY STR0020		//-- "Dt. Entrega"
		@ nLin,115 PSAY STR0021		//-- "Dias atraso"
		@ nLin,127 PSAY STR0022		//-- "Qtde Volume"
		@ nLin,137 PSAY STR0023		//-- "Vl. Mercadoria"
		@ nLin,154 PSAY STR0041		//-- "Dt.Redesp"
		@ nLin,166 PSAY STR0044		//-- "Fil.Orig.Redesp"
		@ nLin,177 PSAY STR0042		//-- "NºRedesp"
		@ nLin,188 PSAY STR0043		//-- "Ultima Ocorrencia"
		
		nLin++
		@ nLin,000 PSAY Replicate("_",limite)
   EndIf


	//-- Seleciona a ultima data da ocorrencia de "Indicado p/ Entrega", Ocorrencia do parametro.
	//-- Esta e' a data de Despacho.
	cAliasDua := GetNextAlias()
	cQuery := "SELECT MAX(DUA.DUA_DATOCO) DUA_DATOCO, DUA.DUA_DOC, DUA.DUA_FILDOC, DUA.DUA_SERIE"
	cQuery += " FROM " + RetSqlName( "DUA" ) + " DUA "
	cQuery += " WHERE DUA.DUA_FILIAL ='" + xFilial("DUA") + "' "
	cQuery += "   AND DUA.DUA_FILDOC ='" + (cAlias)->DFV_FILDOC	+ "'"
	cQuery += "   AND DUA.DUA_DOC    ='" + (cAlias)->DFV_DOC 	+ "'"
	cQuery += "   AND DUA.DUA_SERIE  ='" + (cAlias)->DFV_SERIE 	+ "'"
	cQuery += "   AND DUA.DUA_CODOCO ='" + cOcorBx 	+ "'"
	cQuery += "   AND DUA.D_E_L_E_T_ <> '*'"
	cQuery += "   GROUP BY DUA.DUA_DOC, DUA.DUA_FILDOC, DUA.DUA_SERIE"
	cQuery := ChangeQuery ( cQuery )
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasDua, .T., .F. )

	If (cAliasDua)->(!EOF())
		cDtOcor := (cAliasDua)->DUA_DATOCO
	EndIf
	(cAliasDua)->(DbCloseArea())     

	//-- Query efetuada para selecionar o ultimo apontamento de ocorrencia do documento.
	cAliasDua := GetNextAlias()
	cQuery := " SELECT MAX(DUA_DATOCO) DUA_DATOCO "
	cQuery += " FROM " + RetSqlName( "DUA" ) + " DUA "
	cQuery += " WHERE DUA.DUA_FILIAL ='" + xFilial("DUA") + "' "
	cQuery += "   AND DUA.DUA_FILDOC ='" + (cAlias)->DFV_FILDOC	+ "'"
	cQuery += "   AND DUA.DUA_DOC    ='" + (cAlias)->DFV_DOC 	+ "'"
	cQuery += "   AND DUA.DUA_SERIE  ='" + (cAlias)->DFV_SERIE 	+ "'"
	cQuery += "   AND DUA.DUA_SERTMS ='" + StrZero(3, Len(DUA->DUA_SERTMS)) + "'"	
	cQuery += "   AND DUA.D_E_L_E_T_ <> '*'"
	cQuery := ChangeQuery ( cQuery )
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasDua, .T., .F. )

	//-- Seleciona a maior hora e a descricao da ocorrencia.
	If (cAliasDua)->(!EOF())
		cAliasDt2 := GetNextAlias()
		cQuery := "	SELECT MAX(DUA_HOROCO) DUA_HOROCO"
		cQuery += " FROM " + RetSqlName( "DUA" ) + " DUA, " + RetSqlName( "DT2" ) + " DT2 "
		cQuery += " WHERE DUA.DUA_FILIAL ='" + xFilial("DUA") + "' "
		cQuery += "   AND DUA.DUA_FILDOC ='" + (cAlias)->DFV_FILDOC	+ "'"
		cQuery += "   AND DUA.DUA_DOC    ='" + (cAlias)->DFV_DOC 	+ "'"
		cQuery += "   AND DUA.DUA_SERIE  ='" + (cAlias)->DFV_SERIE 	+ "'"
		cQuery += "   AND DUA.DUA_SERTMS ='" + StrZero(3, Len(DUA->DUA_SERTMS)) + "'"	
		cQuery += "   AND DUA.DUA_DATOCO ='" + (cAliasDua)->DUA_DATOCO + "'"
		cQuery += "   AND DUA.D_E_L_E_T_   <> '*'"
				
		cQuery += "   AND DT2.DT2_FILIAL ='" + xFilial("DT2") + "' "
		cQuery += "   AND DT2.DT2_CODOCO = DUA_CODOCO"
		cQuery += "   AND DT2.D_E_L_E_T_   <> '*'"
		cQuery := ChangeQuery ( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasDT2, .T., .F. )
			
		If (cAliasDT2)->(!EOF())
			cAliasDes := GetNextAlias()
			cQuery := "	SELECT DT2_DESCRI"
			cQuery += " FROM " + RetSqlName( "DUA" ) + " DUA, " + RetSqlName( "DT2" ) + " DT2 "
			cQuery += " WHERE DUA.DUA_FILIAL ='" + xFilial("DUA") + "' "
			cQuery += "   AND DUA.DUA_FILDOC ='" + (cAlias)->DFV_FILDOC	+ "'"
			cQuery += "   AND DUA.DUA_DOC    ='" + (cAlias)->DFV_DOC 	+ "'"
			cQuery += "   AND DUA.DUA_SERIE  ='" + (cAlias)->DFV_SERIE 	+ "'"
			cQuery += "   AND DUA.DUA_SERTMS ='" + StrZero(3, Len(DUA->DUA_SERTMS)) + "'"	
			cQuery += "   AND DUA.DUA_DATOCO ='" + (cAliasDua)->DUA_DATOCO + "'"
			cQuery += "   AND DUA.DUA_HOROCO ='" + (cAliasDT2)->DUA_HOROCO + "'"
			cQuery += "   AND DUA.D_E_L_E_T_   <> '*'"
					
			cQuery += "   AND DT2.DT2_FILIAL ='" + xFilial("DT2") + "' "
			cQuery += "   AND DT2.DT2_CODOCO = DUA_CODOCO"
			cQuery += "   AND DT2.D_E_L_E_T_   <> '*'"

			cQuery := ChangeQuery ( cQuery )
			dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasDes, .T., .F. )
			If (cAliasDT2)->(!EOF())
				cDescri	:= (cAliasDes)->(DT2_DESCRI)
			EndIf
		EndIf
		(cAliasDes)->(DbCloseArea())
		(cAliasDT2)->(DbCloseArea())
	EndIf
	(cAliasDUA)->(DbCloseArea())
	
	//-- Seleciona a data de entrada do Doc.
	cAliasDUA := GetNextAlias()
	cQuery := " SELECT DTC.DTC_DATENT DATA_ENTRADA"
	cQuery += " 	FROM " + RetSqlName("DTC") + " DTC"
	cQuery += " WHERE"
	cQuery += "     DTC.DTC_FILIAL ='" + xFilial("DTC") + "'"
	cQuery += " AND DTC.DTC_FILDOC ='" + (cAlias)->DFV_FILDOC + "'"
	cQuery += " AND DTC.DTC_DOC    ='" + (cAlias)->DFV_DOC + "'"
	cQuery += " AND DTC.DTC_SERIE  ='" + (cAlias)->DFV_SERIE + "'"
	cQuery += " AND DTC.D_E_L_E_T_ <> '*'"
	cQuery += " UNION"
	cQuery += " SELECT DTC.DTC_DATENT DATA_ENTRADA"
	cQuery += " 	FROM " + RetSqlName("DY4") + " DY4"
	cQuery += " 	JOIN " + RetSqlName("DTC") + " DTC ON"
	cQuery += "	DTC_FILIAL = DY4_FILIAL"
	cQuery += "	AND DTC_NUMNFC = DY4_NUMNFC"
	cQuery += "	AND DTC_SERNFC = DY4_SERNFC"
	cQuery += "	AND DTC_LOTNFC = DY4_LOTNFC"
	cQuery += "	AND DTC.D_E_L_E_T_ <> '*'"	
	cQuery += " WHERE"
	cQuery += "     DY4.DY4_FILIAL ='" + xFilial("DY4") + "'"
	cQuery += " AND DY4.DY4_FILDOC ='" + (cAlias)->DFV_FILDOC + "'"
	cQuery += " AND DY4.DY4_DOC    ='" + (cAlias)->DFV_DOC + "'"
	cQuery += " AND DY4.DY4_SERIE  ='" + (cAlias)->DFV_SERIE + "'"
	cQuery += " AND DY4.D_E_L_E_T_ <> '*'"
	cQuery := ChangeQuery ( cQuery )
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasDUA, .T., .F. )
	
	If (cAliasDUA)->(!EOF())
		cDtEntrada	:= (cAliasDUA)->(DATA_ENTRADA)
	EndIf
	(cAliasDUA)->(DbCloseArea())		
		
   nLin++
	@ nLin,001 PSAY (cAlias)->DFV_FILDOC
	@ nLin,008 PSAY (cAlias)->DFV_DOC
	@ nLin,019 PSAY SerieNfiD(cAlias,2,"DFV_SERIE")
	@ nLin,024 PSAY SubStr((cAlias)->NOME_SAR, 1, 20)
	@ nLin,045 PSAY SubStr((cAlias)->NOME_SAD, 1, 20)
	@ nLin,066 PSAY sTod(cDtEntrada)
	@ nLin,078 PSAY sTod((cAlias)->DATA_EMISSAO)
	@ nLin,090 PSAY sTod((cAlias)->DT6_PRZENT)
	@ nLin,102 PSAY sTod((cAlias)->DATA_ENTREGA)
	@ nLin,115 PSAY If (  Empty( sTod( (cAlias)->DATA_ENTREGA)  )   ,   date()  , sTod((cAlias)->DATA_ENTREGA)) - sTod((cAlias)->DT6_PRZENT)
	@ nLin,125 PSAY Transform((cAlias)->DFV_QTDVOL,"@E 99999")
	@ nLin,135 PSAY Transform((cAlias)->DFV_VALMER,"@E 99,999,999,999.99")
	@ nLin,155 PSAY sTod(cDtOcor)
	If lCmpDFV
		@ nLin,167 PSAY (cAlias)->DFV_FILORI
	EndIf
	@ nLin,177 PSAY (cAlias)->DFV_NUMRED
	@ nLin,189 PSAY SubStr(cDescri,1,19)
	
		cRedesp	:= (cAlias)->A2_COD + (cAlias)->A2_LOJA + (cAlias)->A2_NOME
	(cAlias)->(DbSkip())
EndDo


(cAlias)->(DbCloseArea())

Return Nil

