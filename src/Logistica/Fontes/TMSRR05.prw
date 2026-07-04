/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "tbiconn.ch"
#include "topconn.ch"
#include "TMSRR05.ch"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ TMSRR01	   ³ Autor ³ Andre Godoi		     ³ Data ³17/09/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Romaneio de entrega por redespachante		  						  ³±±
±±³			  ³																				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ 								                              		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function TMSRR05()
Local cDesc1  		:= STR0001		//--"Romaneio de entrega por redespachante"
Local cDesc2  		:= ""
Local cDesc3  		:= ""
Local cPict   		:= ""
Local titulo  		:= STR0001 // STR0002		//--"Documentos em poder do redespachante"
Local imprime 		:= .T.
Local aOrd    		:= {}
Local cPerg   		:= 'TMAR05'
Local aCposProtg	:= {}
Local aCpoAccess	:= {'A1_NOME'}

Private nLin         := 132
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 132
Private tamanho      := "M"
Private nTipo        := 18
Private NomeProg     := "TMSRR05" 	// Coloque aqui o nome do programa para impressao no cabecalho //"RELATORIO"
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1} //
Private nLastKey     := 0
Private pag          := 01
Private wnrel        := "TMSRR05" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString      := ""
Private m_pag        := 01
Private CONTFL       := 01
Private cbtxt        := Space(10)
Private cbcont       := 00

If ExistFunc('TMLGPDCpPr')
	aCposProtg := TMLGPDCpPr(aCpoAccess, "SA1")
	If ExistFunc('FWPDCanUse') .And. FWPDCanUse() .And. !Empty(aCposProtg)
		If Len(FwProtectedDataUtil():UsrAccessPDField( __CUSERID, aCposProtg )) < Len(aCposProtg)
			Help(" ",1,STR0023,,,5,11) //"LGPD - Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Para mais informações contate o Administrador do sistema !!"
			Return
		EndIf	
	EndIf
EndIf

If !Pergunte( cPerg, .T. )
	Return .T.
End	

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
RptStatus({|| TMSREXC(Titulo,nLin) },Titulo)

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
±±³Programa   ³ TMSREXC    ³ Autor ³ Andre Godoi	 		  ³ Data ³17/09/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ 																	 			  ³±±
±±³			  ³																				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ 								                              		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMSREXC(Titulo,nLin)

Local Cabec1  := STR0003		//-- "Documentos selecionados"
Local Cabec2  := ''
Local cAlias 	:= GetNextAlias()
Local cQuery	:=	''
Local lCmpDFV := DFV->(ColumnPos("DFV_FILORI")) > 0 .And. DFV->(ColumnPos("DFV_TIPVEI")) > 0

//-- Seleção de todos os Regisro que serão contidos no Relatório
cQuery := "SELECT DFV.DFV_NUMRED, DFV.DFV_FILDOC, DFV.DFV_DOC, DFV.DFV_SERIE, DFV.DFV_VALMER, DFV.DFV_QTDVOL,"
If lCmpDFV
	cQuery += " DFV.DFV_FILORI, "
EndIf
If SerieNfId("DFV",3,"DFV_SERIE")=="DFV_SDOC"
	cQuery += " DFV.DFV_SDOC, "
EndIf
cQuery += " 		SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_END, SA1.A1_BAIRRO,"
cQuery += " 		SA2.A2_COD, SA2.A2_LOJA, SA2.A2_NOME"
cQuery += " FROM " + RetSqlName( "DFV" ) + " DFV"
cQuery += " INNER JOIN "+RetSqlName("DT6") 	 + " DT6 ON"
cQuery += " DT6.DT6_FILIAL		= '" + xFilial("DT6") + "' AND"
cQuery += " DT6.DT6_FILDOC		= DFV.DFV_FILDOC	AND"
cQuery += " DT6.DT6_DOC	 		= DFV.DFV_DOC		AND"
cQuery += " DT6.DT6_SERIE 		= DFV.DFV_SERIE"

cQuery += " INNER JOIN "+RetSqlName("SA2") 	 + " SA2 ON"
cQuery += " SA2.A2_FILIAL	= '" + xFilial("SA2") + "' AND"
cQuery += " SA2.A2_LOJA		= DFV.DFV_LOJFOR	AND"
cQuery += " SA2.A2_COD 		= DFV.DFV_CODFOR"

cQuery += " INNER JOIN "+RetSqlName("SA1") 	 + " SA1 ON"
cQuery += " SA1.A1_FILIAL	= '" + xFilial("SA1") + "' AND"
cQuery += " SA1.A1_COD		= 	DT6.DT6_CLIDES		AND"
cQuery += " SA1.A1_LOJA	 	= 	DT6.DT6_LOJDES"

cQuery += " WHERE DFV.DFV_FILIAL = '" + xFilial("DFV") + "' AND"
If lCmpDFV
	cQuery += " DFV.DFV_FILORI 	='" + MV_PAR02 + "' AND" 
EndIf	
cQuery += " DFV.DFV_NUMRED 	='" + MV_PAR01 + "' AND"
cQuery += " DFV.DFV_STATUS 	<>'" + StrZero( 9, Len( DFV->DFV_STATUS ) ) + "' AND"

cQuery += " DFV.D_E_L_E_T_ 	= ' '	AND"
cQuery += " DT6.D_E_L_E_T_ 	= ' ' AND"
cQuery += " SA1.D_E_L_E_T_ 	= ' ' AND"
cQuery += " SA2.D_E_L_E_T_ 	= ' '"

cQuery := ChangeQuery ( cQuery )

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAlias, .T., .F. )

If (cAlias)->(EOF())
	Aviso( STR0004,	STR0005, {"Ok"} )			//-- "Atenção" // "Não existe informação para os parametro indicados !"
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
±±³Descricao  ³ 																				  ³±±
±±³		  	  ³																		  	  	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ 								                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TMSRMNT(Cabec1,Cabec2,Titulo,nLin, cAlias)
	
While !(cAlias)->(EOF())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 PSAY STR0006					//-- "*** CANCELADO PELO OPERADOR ***"
		(cAlias)->(DbCloseArea())
		Exit
	Endif  

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
		nLin := 8
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nLin,000 PSAY STR0007				//-- "Redespachante:"
		nLin++
		
		@ nLin,000 PSAY STR0008				//-- "Código "
		@ nLin,012 PSAY STR0009				//-- "Loja"
		@ nLin,022 PSAY STR0010				//-- "Nome"
		@ nLin,115 PSAY "Redespacho"
		nLin++

		@ nLin,000 PSAY (cAlias)->A2_COD
		@ nLin,012 PSAY (cAlias)->A2_LOJA
		@ nLin,022 PSAY (cAlias)->A2_NOME
		@ nLin,115 PSAY (cAlias)->DFV_NUMRED
		nLin++
		nLin++		

		@ nLin,000 PSAY STR0011			//-- "Filial"
		@ nLin,009 PSAY STR0012			//-- "Doc."
		@ nLin,018 PSAY STR0013			//-- "Serie"
		@ nLin,027 PSAY STR0014			//-- "Destinatário"
		@ nLin,049 PSAY STR0015			//-- "Endereço"
		@ nLin,075 PSAY STR0016			//-- "Bairro"
		@ nLin,096 PSAY STR0017			//-- "Quantidade"
		@ nLin,115 PSAY STR0018			//-- "Valor da Mercadoria"
		nLin++
		@nLin,000 PSAY Replicate("_",limite)
		nLin++
	Endif

//             1         2         3         4         5         6         7         8         9        100       110       120       130       140       150       160       170       180       190       200      210       220
//   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//  "Remetente :					 																														99,999,999,999.99																 "
//	 "Código		  Loja		Nome																													 "
//	 "Filial    Doc.    Série    Destinatário          Endereço                  Bairro               Quantidade         Valor Mercadoria"
	 


	@ nLin,001 PSAY (cAlias)->DFV_FILDOC
	@ nLin,009 PSAY (cAlias)->DFV_DOC
	@ nLin,018 PSAY SerieNfId(cAlias,2,"DFV_SERIE")
	@ nLin,027 PSAY SubStr((cAlias)->A1_NOME, 1, 22)
	@ nLin,049 PSAY SubStr((cAlias)->A1_END, 1, 24)
	@ nLin,075 PSAY SubStr((cAlias)->A1_BAIRRO, 1, 21 )
	@ nLin,096 PSAY AllTRim(Str((cAlias)->DFV_QTDVOL))
	@ nLin,123 PSAY LTrim(Transform((cAlias)->DFV_VALMER,"@E 99,999,999,999.99")) 
	nLin++
	
	(cAlias)->(DbSkip())
EndDo


nLin+= 10
@ nLin,000 PSAY		STR0019			//-- "Data _______________________________                _____________________________________________"

nLin+= 3
@ nLin,000 PSAY		STR0020			//-- "Obs: Documentos entregue ao redespachante"
(cAlias)->(DbCloseArea())

Return Nil
