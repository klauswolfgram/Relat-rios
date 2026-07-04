/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR029.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#DEFINE CRLF CHR(13)+CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR029  ³ Autor ³ Rafael M. Quadrotti   ³ Data ³ 30/05/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Respostas de Scripts                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Call Center - Relatorios 			                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Andrea F. ³11/05/04³811   ³Revisao do Fonte e inclusao de novos campos ³±±
±±³          ³        ³      ³no cabecalho.                               ³±±
±±³Michel W. ³29/08/06³99199 ³Atualizacao relatorios release 4.           ³±±    
±±³Tatiana C.³06/10/06³109497³Chamada a variavel cAntPerg                 ³±±
±±³			 ³        ³		 ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/  
User Function TMKR029()
Local oReport	//Objeto relatorio TReport (Release 4)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK029",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                 			  ³
//³ mv_par01            // Do Atendimento                             ³
//³ mv_par02            // Ate o Atendimento                          ³
//³ mv_par03            // Entidade                                   ³
//³ mv_par04            // Da chave                                   ³
//³ mv_par05            // Ate a chave                                ³
//³ mv_par06            // Data Inicial                               ³
//³ mv_par07            // Data Final                                 ³
//³ mv_par08            // Operacao                                   ³
//³ mv_par09            // Produto                                    ³
//³ mv_par10 - Mv_par17 // Segmento 01 - 08                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog() 

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tk029ValAtend ³ Autor ³ Rafael M. Quadrotti³ Data ³21/06/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida o atendimento (data, cliente...)                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tk029ValAtend(cAtend,cCampanha,dAtend,cACI)                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMKR029                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tk029ValAtend(cAtend, cCampanha, dAtend, cACI, cFilSUO)
Local lRet		:= .F.
Local nOper	:= 0
Local aArea	:= GetArea()
Local cAlias	:= ""

Default cFilSUO	:= xFilial("SUO")

IF (cACI)->ACI_ROTINA=="1"
	cAlias := "SUC"
ElseIf (cACI)->ACI_ROTINA=="2"
	cAlias := "SUA"
ElseIf (cACI)->ACI_ROTINA=="3"
	cAlias := "ACF"
ElseIf ( Empty((cACI)->ACI_ROTINA) .AND. Empty((cACI)->ACI_ATEND) ) .or. (cACI)->ACI_ROTINA=="4" // O Script foi executado pela agenda do Operador.
	cAlias := "ACI"
EndIf

If cAlias <> "ACI"
	DbSelectArea(cAlias)
	DbSetOrder(1)
	MsSeek(xFilial(cAlias) + cAtend,.T.)
EndIf

If ((cACI)->ACI_DATA >= Mv_Par06) .AND. ((cACI)->ACI_DATA <= Mv_Par07)
	If cAlias == "SUC"
		nOper:= Val(SUC->UC_OPERACA)
		If (Mv_Par08 == 3) .Or. (nOper == Mv_Par08)
			
			If Tk029ValCli(cACI)
				If Tk029ValProd(cAtend,cAlias)
					dAtend   := (cACI)->ACI_DATA
					cCampanha:= (cACI)->ACI_CODCAM + " - " + Posicione("SUO",1,cFilSUO + (cACI)->ACI_CODCAM,"UO_DESC")
					lRet:= .T.
				EndIf
			EndIf
		EndIf
	ELSEIF cAlias == "SUA"
		
		If Tk029ValCli(cACI)
			If Tk029ValProd(cAtend,cAlias)
				dAtend   := (cACI)->ACI_DATA
				cCampanha:= (cACI)->ACI_CODCAM + " - " + Posicione("SUO",1,cFilSUO + (cACI)->ACI_CODCAM,"UO_DESC")
				lRet:= .T.
			EndIf
		EndIf
	ELSEIF cAlias == "ACF"
		If Tk029ValCli(cACI)
			dAtend   := (cACI)->ACI_DATA
			cCampanha:= (cACI)->ACI_CODCAM + " - " + Posicione("SUO",1,cFilSUO + (cACI)->ACI_CODCAM,"UO_DESC")
			lRet:= .T.
		EndIf
		
	ELSEIF cAlias == "ACI"
		lRet:= .T.
		DbSelectarea("SUA")
		MsSeek("@#$%¨&")	// posiciona em eof()
		DbSelectarea("SUC")
		MsSeek("@#$%¨&")	// posiciona em eof()
		DbSelectArea((cACI)->ACI_ENTIDA)
		DbSetOrder(1)
		MsSeek((cACI)->ACI_CHAVE)
	EndIf
EndIf

RestArea(aArea)

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tk029ValCli³ Autor ³ Rafael M. Quadrotti   ³ Data ³26/12/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida o cliente ()                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tk029ValCli(cACI)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMKR029                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tk029ValCli(cACI)

Local lRet  := .T.
Local aArea := GetArea()

If (cACI)->ACI_CHAVE >= Mv_Par04 .and. (cACI)->ACI_CHAVE <= Mv_Par05
	IF Trim(Mv_Par03) = "SA1" .or. Trim(Mv_Par03) = "SUS"
		If !Empty(Mv_Par10+Mv_Par11+Mv_Par12+Mv_Par13+Mv_Par14+Mv_Par15+Mv_Par16+Mv_Par17)
			DbSelectArea(Trim(Mv_Par03))
			DbSetOrder(1)
			If MsSeek(xFilial(Trim(Mv_Par03)) + (cACI)->ACI_CHAVE)
				
				If AllTrim(Mv_Par03) == "SA1"
					
					If !Empty(Mv_Par10) .and. SA1->A1_SATIV1 <> Mv_Par10
						lRet:= .F.
					ElseIf !Empty(Mv_Par11) .and. SA1->A1_SATIV2 <> Mv_Par11
						lRet:= .F.
					ElseIf !Empty(Mv_Par12) .and. SA1->A1_SATIV3 <> Mv_Par12
						lRet:= .F.
					ElseIf !Empty(Mv_Par13) .and. SA1->A1_SATIV4 <> Mv_Par13
						lRet:= .F.
					ElseIf !Empty(Mv_Par14) .and. SA1->A1_SATIV5 <> Mv_Par14
						lRet:= .F.
					ElseIf !Empty(Mv_Par15) .and. SA1->A1_SATIV6 <> Mv_Par15
						lRet:= .F.
					ElseIf !Empty(Mv_Par16) .and. SA1->A1_SATIV7 <> Mv_Par16
						lRet:= .F.
					ElseIf !Empty(Mv_Par17) .and. SA1->A1_SATIV8 <> Mv_Par17
						lRet:= .F.
					EndIf
					
				Else
					
					If !Empty(Mv_Par10) .and. SUS->US_SATIV <> Mv_Par10
						lRet:= .F.
					ElseIf !Empty(Mv_Par11) .and. SUS->US_SATIV2 <> Mv_Par11
						lRet:= .F.
					ElseIf !Empty(Mv_Par12) .and. SUS->US_SATIV3 <> Mv_Par12
						lRet:= .F.
					ElseIf !Empty(Mv_Par13) .and. SUS->US_SATIV4 <> Mv_Par13
						lRet:= .F.
					ElseIf !Empty(Mv_Par14) .and. SUS->US_SATIV5 <> Mv_Par14
						lRet:= .F.
					ElseIf !Empty(Mv_Par15) .and. SUS->US_SATIV6 <> Mv_Par15
						lRet:= .F.
					ElseIf !Empty(Mv_Par16) .and. SUS->US_SATIV7 <> Mv_Par16
						lRet:= .F.
					ElseIf !Empty(Mv_Par17) .and. SUS->US_SATIV8 <> Mv_Par17
						lRet:= .F.
					EndIf
					
				EndIF
				
			Else
				lRet:= .F.
			EndIf
		EndIf
	EndIf
	
EndIf

RestArea(aArea)

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tk029ValProd  ³ Autor ³ Rafael M. Quadrotti³ Data ³26/12/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida o produto                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tk029ValProd(void)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMKR029                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tk029ValProd(cAtend,cAlias)  
Local lRet			:= .F.
Local aArea		:= GetArea()
Local cAli2		:= ""
Local cCampo		:= ""
Local cCampo2		:= ""
Local cCampo3		:= ""
Local cFilAli2	:= ""

If cAlias == "SUC"
	cAli2 := "SUD"
ElseIf cAlias == "SUA"
	cAli2 := "SUB"
EndIf

If !Empty(Mv_Par09)
	DbSelectArea(cAli2)
	DbSetOrder(1)
	cFilAli2	:= xFilial(cAli2)
	If MsSeek(cFilAli2 + cAtend)
		cCampo := SubStr(cAli2,2,2)+ "_FILIAL"
		cCampo2:= SubStr(cAli2,2,2)+ "_CODIGO"
		cCampo3:= SubStr(cAli2,2,2)+ "_PRODUTO"
		Do While !Eof() .AND. ((cAli2)->&cCampo) == cFilAli2 .AND. ((cAli2)->&cCampo2 == cAtend)
			If (cAli2)->&cCampo3 == Mv_Par09
				lRet:= .T.
				Exit
			EndIf
			DbSkip()
		EndDo
	EndIf
Else
	lRet:= .T.
EndIf

RestArea(aArea)

Return(lRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³Michel W. Mosca     ³ Data ³29/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Emissao de repostas de Script no release 4.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CALL CENTER                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()  
Local oReport					//Objeto relatorio TReport (Release 4)
Local oSection1				//Objeto secao 1 do relatorio (Cabecalho, dados da meta atendimento)
Local oSection2				//Relação de campanhas associadas a meta
Local cACI			:= "ACI"	//Alias da consulta Embedded SQL
Local aTamSX3		:= {}		//Array com os Campos x Tamanhos configurados no dicionário de dados
Local nTamCell	:= 0		//Tratativa do tamanho para a célula, obedecendo a configuração do tamanho dos campos no dicionário de dados
Local cFilSUZ		:= xFilial("SUZ")

aAdd(aTamSX3, {"U5_FCOM1",  GetSx3Cache("U5_FCOM1",  "X3_TAMANHO")})
aAdd(aTamSX3, {"U5_CONTAT", GetSx3Cache("U5_CONTAT", "X3_TAMANHO")})
aAdd(aTamSX3, {"U5_DDD",    GetSx3Cache("U5_DDD",    "X3_TAMANHO")})
aAdd(aTamSX3, {"U5_EMAIL",  GetSx3Cache("U5_EMAIL",  "X3_TAMANHO")})

cACI	:= GetNextAlias()						// Pega o proximo Alias Disponivel	

//"Emissão de Respostas de Scripts " # //"Este programa ira emitir uma relacao dos Atendimentos "
//"Call Center relacionados aos Scripts trabalhados e suas" # //"respectivas respostas."
DEFINE REPORT oReport NAME "TMKR029" TITLE STR0001 PARAMETER "TMK029" ACTION {|oReport| Tkr029PrtRpt( oReport, cACI )} DESCRIPTION STR0002 + STR0003 + STR0004

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0033 TABLES "ACI"		//Dados do Contato
DEFINE SECTION oSection2 OF oSection1 TITLE STR0034 TABLES "SUP"	//Itens do Script Dinamico	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime os dados do Contato .                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
nTamCell	:= aTamSX3[aScan(aTamSX3, {|x| x[01] == "U5_CONTAT"})][02]
If	nTamCell < 50
	nTamCell := 50  
EndIf
DEFINE CELL NAME "" OF oSection1 Alias "ACI" BLOCK{||ALLTRIM(TkDadosContato((cACI)->ACI_CODCON,6,.T.))}                          TITLE STR0012 SIZE nTamCell //"Contato"
DEFINE CELL NAME "" OF oSection1 Alias "ACI" BLOCK{||ALLTRIM(Posicione("SX2",1,(cACI)->ACI_ENTIDA,"X2NOME()"))}              TITLE STR0013 SIZE 40 //"Entidade"

nTamCell	:= ( aTamSX3[aScan(aTamSX3, {|x| x[01] == "U5_DDD"})][02] + aTamSX3[aScan(aTamSX3, {|x| x[01] == "U5_FCOM1"})][02] + 3)
If	nTamCell < 20
	nTamCell := 20  
EndIf
DEFINE CELL NAME "" OF oSection1 Alias "ACI" BLOCK{||ALLTRIM(TkDadosContato((cACI)->ACI_CODCON,8,.T.)) + " - " +;
                                                     ALLTRIM(TkDadosContato((cACI)->ACI_CODCON,4,.T.))}                          TITLE STR0027 SIZE nTamCell //DDD # "Fone Com.1"

DEFINE CELL NAME "" OF oSection1 Alias "ACI" BLOCK{||ALLTRIM(TkEntidade((cACI)->ACI_ENTIDA,(cACI)->ACI_CHAVE,1,Nil,.T.))}            TITLE STR0014 SIZE 50 //"Nome"

nTamCell	:= aTamSX3[aScan(aTamSX3, {|x| x[01] == "U5_EMAIL"})][02]  
If	nTamCell < 50
	nTamCell := 50
EndIf
DEFINE CELL NAME "" OF oSection1 Alias "ACI" BLOCK{||ALLTRIM(TkDadosContato((cACI)->ACI_CODCON,10,.T.))}                         TITLE STR0028 SIZE nTamCell //"E-Mail"
DEFINE CELL NAME "" OF oSection1 Alias "ACI" BLOCK{||ALLTRIM(TkEntidade((cACI)->ACI_ENTIDA,(cACI)->ACI_CHAVE,9,Nil,.T.)) + " - " +;
                                                     ALLTRIM(TkEntidade((cACI)->ACI_ENTIDA,(cACI)->ACI_CHAVE,6,Nil,.T.))}            TITLE STR0029 SIZE 20 //DDD ## "Telefone"
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime os dados do Atendimento .                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE CELL NAME ""         OF oSection1 Alias "ACI" BLOCK{||AllTrim((cACI)->ACI_ATEND) +;
                                                             IF((cACI)->ACI_ROTINA == "1", STR0016,;
                                                                IF((cACI)->ACI_ROTINA == "2", STR0017,;
                                                                   IF((cACI)->ACI_ROTINA == "3", STR0026,;
                                                                      IF(Empty((cACI)->ACI_ROTINA) .AND. Empty((cACI)->ACI_ATEND),STR0018,""))))}      TITLE STR0019 SIZE 30
DEFINE CELL NAME ""         OF oSection1 Alias "ACI" BLOCK{||TkEntidade((cACI)->ACI_ENTIDA,(cACI)->ACI_CHAVE,3)+ "/"+;
                                                             TkEntidade((cACI)->ACI_ENTIDA,(cACI)->ACI_CHAVE,4)}                                       TITLE STR0030 SIZE 40 //"Município"
DEFINE CELL NAME "S1DATEND" OF oSection1 Alias "ACI"                                                                                                   TITLE STR0020 SIZE 10 //"Data"
DEFINE CELL NAME "ACI_DATA" OF oSection1 Alias "ACI" //"Data da execução"
DEFINE CELL NAME "S1CCAMP"  OF oSection1 Alias "ACI"                                                                                                   TITLE STR0022 SIZE 40 //"Campanha"
DEFINE CELL NAME ""         OF oSection1 Alias "ACI" BLOCK{||AllTrim((cACI)->ACI_CODSCR + " - " +;
                                                             Posicione("SUZ",1,cFilSUZ + (cACI)->ACI_CODSCR,"UZ_DESC"))}                               TITLE STR0023 SIZE 60 //"Script"
DEFINE CELL NAME ""         OF oSection1 Alias "ACI" BLOCK{||IIf(Posicione("SUZ",1,cFilSUZ + (cACI)->ACI_CODSCR,"UZ_FORMATO")=="1", STR0009, STR0010)} TITLE STR0008 SIZE 20 // Atendimento // Pesquisa

DEFINE CELL NAME "S2QUESTION" OF oSection2 TITLE STR0031 SIZE 100 
DEFINE CELL NAME "S2SCORE"    OF oSection2 TITLE STR0032 SIZE 20  

aSize(aTamSX3,0)
aTamSX3	:= NIL

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr029PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³29/08/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de Emissao de³±±
±±³          ³Respostas de Scripts no release 4.                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr029PrtRept(ExpO1,ExpC2)                                 ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC2 = alias da query atual                               ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr029PrtRpt(	oReport, 	cACI,	cAntPerg)
Local oSection1 := oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, dados da meta atendimento)	
Local oSection2 := oSection1:Section(1) 	//Relaçãp de campanhas associadas a meta
Local dAtend   		:= CTOD("//")// Data do atendimento                                                                    
Local cAtend   		:= ""       // Codigo do atensdimento.
Local cCampanha		:= ""       // Codigo da campanha.       
Local nI			:= 0		// Contador
Local aLinhas		:= {}		// Recebe as linhas do memoLocal cPerg    		:= ""       // Codigo da pergunta
Local cResp    		:= ""       // Codigo da resposta
Local nScore   		:= 0        // Score das resposta
Local cWhere	:= ""						//String contendo condicoes da clausula Where para pesquisa em TOP
Local cTable	:= ""						//String para armazenar a tabela utilizada na verificação dos Segmentos de negócio
Local cQuery    := ""						//String para armazenar parametros de busca adicionais
Local nAux			:= 0

Local cFilACI		:= xFilial("ACI")
Local cFilSUK		:= xFilial("SUK")
Local cFilSUP		:= xFilial("SUP")
Local cFilSUO		:= xFilial("SUO")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMK029") 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamo a funcao que monta a parte da query para validar os segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Mv_Par03 == "SA1" .or. Mv_Par03 == "SUS"
	TKSegmento(	Mv_Par10,	Mv_Par11,	Mv_Par12,	Mv_Par13,;
				Mv_Par14,	Mv_Par15,	Mv_Par16,	Mv_Par17,;
				Mv_Par03,	"",			@cWhere)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query a validacao dos segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cWhere)
	cTable := "%, " + RetSqlName(Mv_Par11) + " " + Mv_Par11 + " %"
Else
	cTable := "%%"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query a validacao dos segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cWhere)
	cWhere =+ "% "
	cWhere += " AND "
Else
	cWhere := "% "
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Selecao do ACI³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
Iif(!Empty(mv_par03),cWhere += " ACI_ENTIDA = '" + ALLTRIM(Mv_Par03) + "' AND",)
cWhere += " ACI_DATA 	BETWEEN 	'" + DTOS(Mv_Par06) + "' AND '" + DTOS(Mv_Par07) + "' 	AND "
cWhere += " %"

BEGIN REPORT QUERY oSection1 
 	BeginSQL alias cACI
           SELECT	ACI_FILIAL,		ACI_ATEND,		ACI_CHAVE,		ACI_ENTIDA,
					ACI_CODIGO,		ACI_CODSCR,		ACI_CODCON,		ACI_ROTINA,
					ACI_DATA,		ACI_CODCAM	            	           			      			
           FROM     %table:ACI% ACI %exp:cTable% 
           WHERE  	ACI_FILIAL = %xfilial:ACI% 									AND
			 		ACI_ATEND 	BETWEEN		%exp:mv_par01% AND %exp:mv_par02% 	AND
			 		ACI_CHAVE 	BETWEEN 	%exp:Mv_Par04% AND %exp:Mv_Par05% 	AND			 			
					%exp:cWhere%
					ACI.%notDel% 	           							 			           
           ORDER BY %order:ACI%
    EndSql    
END REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quebra a linha, caso existam muitas colunas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1:SetLineStyle()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Init()

While	(!Eof()) 						.AND.;
		((cACI)->ACI_FILIAL == cFilACI)
	
	oReport:IncMeter()
	
	If oReport:Cancel()
		Exit
	EndIf
	
	cAtend 	:= (cACI)->ACI_ATEND
	cEntChave 	:= (cACI)->ACI_ENTIDA+(cACI)->ACI_CHAVE

	If !Tk029ValAtend(cAtend, @cCampanha, @dAtend, cACI, cFilSUO)
		DbSelectArea(cACI)
		DbSkip()
		Loop
	EndIf
    
	oSection1:Cell("S1DATEND"):SetValue(DTOC(dAtend))
	oSection1:Cell("S1CCAMP"):SetValue(cCampanha)	
	oSection1:SetPageBreak()
	oSection1:PrintLine()		
	oSection2:Init()	
	DbSelectArea("SUK")
	DbSetOrder(1)
	If MsSeek(cFilSUK + (cACI)->ACI_CODIGO)
		While 	!Eof() 						.AND.;
			SUK->UK_FILIAL == cFilSUK  		.AND.;
			SUK->UK_CODIGO == (cACI)->ACI_CODIGO
			                     
			oSection2:Cell("S2QUESTION"):SetValue("")
			oSection2:Cell("S2SCORE"):SetValue("")
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Caso seja resposta do Tipo Multipla Escolha(checkbox) a pergunta não sera ³
			//³impressa mais de uma vez.                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF (Posicione("SUP",2,cFilSUP + (cACI)->ACI_CODSCR + SUK->UK_CODPERG,"UP_TIPOOBJ") == "2")
				If cAntPerg <> SUK->UK_CODPERG
					cPerg:= AllTrim(Posicione("SUP",2,cFilSUP + (cACI)->ACI_CODSCR + SUK->UK_CODPERG,"UP_DESC"))
					oSection2:Cell("S2QUESTION"):SetValue(cPerg)
					cAntPerg := SUK->UK_CODPERG
				EndIf
			Else
				cPerg:= AllTrim(Posicione("SUP",2,cFilSUP + (cACI)->ACI_CODSCR + SUK->UK_CODPERG,"UP_DESC"))
				oSection2:Cell("S2QUESTION"):SetValue(cPerg)
				cAntPerg := SUK->UK_CODPERG
			EndIf	 
			//IMPRIME A PERGUNTA
			oSection2:SetLeftMargin(2)
			oSection2:PrintLine()			
			cResp:= AllTrim(Posicione("SUP",2,cFilSUP + (cACI)->ACI_CODSCR + SUK->UK_CODRESP,"UP_DESC")) + iif(Empty(SUK->UK_COMPRES),""," - ") +;
					AllTrim(SUK->UK_COMPRES) 
			
			If(!Empty(SUK->UK_CODMEMO)) 
				aLinhas := TkMemo(SUK->UK_CODMEMO, 170)
				nAux	:= Len(aLinhas)
				For nI := 1 to nAux
					cResp+= aLinhas[nI]+CRLF+SPACE(10)
				Next nI           
				cResp+= CRLF
			EndIf	          
			oSection2:Cell("S2QUESTION"):SetValue("R: "+ cResp)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Respostas dissertativas nao imprimem a pontuacao.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			If Empty(SUK->UK_CODMEMO)
				oSection2:Cell("S2SCORE"):SetValue(Transform(SUK->UK_SCORE,PesqPict("SUK","UK_SCORE")))				
			EndIf
			nScore+= SUK->UK_SCORE				

			oSection2:SetLeftMargin(4)
			//IMPRIME A RESPOSTA
			oSection2:PrintLine()
				
			DbSelectArea("SUK")
			DbSkip()
		End
		
	EndIf	 
    oReport:SkipLine()                
    oSection2:SetLeftMargin(2) 
	oSection2:Cell("S2QUESTION"):SetValue(STR0011 + Transform(nScore,PesqPict("SUK","UK_SCORE")))//"Score Total   : "
	oSection2:Cell("S2SCORE"):SetValue("")	
	oSection2:PrintLine()
	nScore:= 0	
    oSection2:Finish()
    oReport:EndPage()
	DbSelectArea(cACI)  
	DbSkip()
End		
oSection1:Finish()

Return(.T.)