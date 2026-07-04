/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr250.Ch"
#Include "PROTHEUS.Ch"

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

// 17/08/2009 -- Filial com mais de 2 caracteres


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr250 ³ Autor ³ Eduardo Nunes Cirqueira ³ Data ³ 06/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Comparativo de Saldos de Contas com Filiais	   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr250()                               			 		   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbR250()

Local cMensagem
Local lAtSlBase	   		:= Iif(	GETMV("MV_ATUSAL")=="S", .T., .F.	)
Local lRet				:= .T.
Local nDivide			:= 1
Local aRetVld			:= {}
Local lExclCT1	 		:= IIF(FindFunction("ADMTabExc"), ADMTabExc("CT1") , !Empty(xFilial("CT1") ))
Local lExclCT2	 		:= IIF(FindFunction("ADMTabExc"), ADMTabExc("CT2") , !Empty(xFilial("CT2") ))
Private cPerg			:= "CTR250"
Private NomeProg		:= "CTBR250"
Private nTamValor		:= TAMSX3("CT2_VALOR")[1]

// Acesso somente pelo SIGACTB
If lRet .And. (!AMIIn(34))
	lRet:=.F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra tela de aviso - processar exclusivo                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMensagem := OemToAnsi(STR0017)+chr(13)  		//"Caso nao atualize os saldos  basicos  na"
cMensagem += OemToAnsi(STR0018)+chr(13)  		//"digitacao dos lancamentos (MV_ATUSAL='N'),"
cMensagem += OemToAnsi(STR0019)+chr(13)  		//"rodar a rotina de atualizacao de saldos "
cMensagem += OemToAnsi(STR0020)+chr(13)  		//"para todas as filiais solicitadas nesse "
cMensagem += OemToAnsi(STR0021)+chr(13)  		//"relatorio."

IF lRet .And. !lAtSlBase
	If !MsgYesNo(cMensagem,OemToAnsi(STR0009))	//"ATEN€O"
		lRet:=.F.
	EndIf
Endif

If lRet
	Pergunte("CTR250",.T.)
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros								     ³
//³ mv_par01				// Data Inicial                  	  		  ³
//³ mv_par02				// Data Final                        		  ³
//³ mv_par03				// Conta Inicial                         	  ³
//³ mv_par04				// Conta Final  							        ³
//³ mv_par05				// Filial 01?                            	  ³
//³ mv_par06				// Filial 02?                            	  ³
//³ mv_par07				// Filial 03?                            	  ³
//³ mv_par08				// Filial 04?                            	  ³
//³ mv_par09				// Filial 05?                            	  ³
//³ mv_par10				// Filial 06?                            	  ³
//³ mv_par11				// Imprime Contas: Sintet/Analit/Ambas   	  ³
//³ mv_par12				// Set Of Books				    		        ³
//³ mv_par13				// Saldos Zerados?			     		        ³
//³ mv_par14				// Moeda?          			     		        ³
//³ mv_par15				// Pagina Inicial  		     		    	     ³
//³ mv_par16				// Saldos? Reais / Orcados	/Gerenciais   	  ³
//³ mv_par17				// Quebra por Grupo Contabil?		    	     ³
//³ mv_par18				// Filtra Segmento?					    	     ³
//³ mv_par19				// Conteudo Inicial Segmento?		   		  ³
//³ mv_par20				// Conteudo Final Segmento?		    		  ³
//³ mv_par21				// Conteudo Contido em?				    	     ³
//³ mv_par22				// Salta linha sintetica ?			    	     ³
//³ mv_par23				// Imprime valor 0.00    ?			    	     ³
//³ mv_par24				// Imprimir Codigo? Normal / Reduzido  	  ³
//³ mv_par25				// Divide por ?                   			  ³
//³ mv_par26				// Imprimir Ate o segmento?			   	  ³
//³ mv_par27				// Posicao Ant. L/P? Sim / Nao         	  ³
//³ mv_par28				// Data Lucros/Perdas?                 	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o plano de contas eh compartilhado.POR DEFINICAO, ³
//³ nao sera possivel emitir o relatorio com plano de contas      ³
//³ EXCLUSIVO !!!!                                   			 	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRet .And. !lExclCT2
	Help("  ",1,"CTR250CT2",,STR0029 ,1,0) //"Relatório apenas pode ser executado com os lançamentos contábeis exclusivos. Por favor, verifique."
	lRet := .F.
EndIf
If lRet
	aRetVld   := CTR250Vld()
	lRet      := aRetVld[1]
	nDivide   := aRetVld[2]
	aCtbMoeda := aRetVld[3]
EndIf

If lRet
	oReport := ReportDef(aCtbMoeda,nDivide)
	If !Empty( oReport:uParam )
		Pergunte( oReport:uParam, .F. )
	EndIf
	oReport:PrintDialog()
EndIf

//Limpa os arquivos temporários
CTBGerClean()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Eduardo Nunes      º Data ³  06/09/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ aCtbMoeda = Matriz ref. a moeda                            º±±
±±º          ³ nDivide   = Indice para divisao do valor (100,1000,1000000)º±±
±±º          ³ nPos      = Indica a posicao do digito na entidade         º±±
±±º          ³ nDigitos  = Indica quantos digitos serao filtrados         º±±
±±º          ³ lSchedule = Indica se esta executando em Schedule          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(aCtbMoeda,nDivide)

Local oReport
Local oSection1
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local nTamDescCta := Len(CriaVar("CT1->CT1_DESC"+mv_par14))
Local aSetOfBook	:= CTBSetOf(mv_par12)
Local cDesc1 		:= OemToAnsi(STR0001)	//"Este programa ira imprimir o Comparativo de Contas Contabeis de 2 ate "
Local cDesc2 		:= OemToansi(STR0002)  //" 6 filiais. Os valores sao ref. a movimentacao do periodo solicitado. "
Local cDesc3		:= ""
Local cDescMoeda
Local cString		:= "CT1"
Local cSeparador	:= ""
Local lPrintZero	:= Iif(mv_par23==1,.T.,.F.)
Local lNormal		:= Iif(mv_par24==1,.T.,.F.)
Local cMascara
Local nTamConta		:= 0


If Empty(aSetOfBook[2])
	cMascara	:= GetMv("MV_MASCARA")	
Else
	cMascara	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

cDescMoeda 	:= Alltrim(aCtbMoeda[2])
If !Empty(aCtbMoeda[6])
	cDescMoeda += OemToAnsi(STR0007) + aCtbMoeda[6]			// Indica o divisor
EndIf

//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascara)

//"Comparativo  de Contas Contabeiscom Filiais"
oReport := TReport():New(NomeProg,OemToAnsi(STR0003),cPerg,{|oReport| ReportPrint(oReport,aSetOfBook,cDescMoeda,nDivide,cMascara)},cDesc1+cDesc2+cDesc3)
oReport:ParamReadOnly()
oReport:SetTotalInLine(.F.)
oReport:SetLandScape(.T.)

// Secao 1
oSection1 := TRSection():New(oReport,STR0027,{"cArqTmp","CT1"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	//"C O N T A"
oSection1:SetTotalInLine(.F.)

TRCell():New(oSection1,"CONTA    "	,"cArqTmp",,/*Picture*/, nTamConta	,/*lPixel*/,{||	EntidadeCTB( If(lNormal .Or. cArqTmp->TIPOCONTA=="1",cArqTmp->CONTA,cArqTmp->CTARES),0,0,nTamConta,.F.,cMascara,cSeparador,,,,,.F.) })	// Codigo da Conta
TRCell():New(oSection1,"DESCRICAO"	,"cArqTmp",,/*Picture*/, nTamDescCta	,/*lPixel*/,{||	Substr(cArqTmp->DESCCTA,1,31) })	//	Descricao da Conta
TRCell():New(oSection1,"FILIAL_01"	,"cArqTmp",,/*Picture*/, nTamValor+2	,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	Movimento da Filial 01
TRCell():New(oSection1,"FILIAL_02"	,"cArqTmp",,/*Picture*/, nTamValor+2	,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	Movimento da Filial 02
TRCell():New(oSection1,"FILIAL_03"	,"cArqTmp",,/*Picture*/, nTamValor+2	,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	Movimento da Filial 03
TRCell():New(oSection1,"FILIAL_04"	,"cArqTmp",,/*Picture*/, nTamValor+2	,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	Movimento da Filial 04
TRCell():New(oSection1,"FILIAL_05"	,"cArqTmp",,/*Picture*/, nTamValor+2	,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	Movimento da Filial 05
TRCell():New(oSection1,"FILIAL_06"	,"cArqTmp",,/*Picture*/, nTamValor+2	,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	Movimento da Filial 06
TRCell():New(oSection1,"TOTAL"	  	,"cArqTmp",,/*Picture*/, nTamValor+2	,/*lPixel*/,/*{|| bloco-de-impressao }*/,"RIGHT",,"RIGHT")	//	Total da Linha

oSection1:SetHeaderPage()

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F250Soma  ºAutor  ³Eduardo Nunes       º Data ³  06/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR250                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F250Soma(nColuna,cSegAte)

Local cCampo 	:= "COLUNA"+Str(nColuna,1)
Local nRetorno	:= 0
Local nPosCpo 	:= cArqTmp->(FieldPos(cCampo))

If nPosCpo > 0
	If mv_par11 == 1					// So imprime Sinteticas - Soma Sinteticas
		If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
			nRetorno := cArqTmp->(FieldGet(nPosCpo))
		EndIf
	Else									// Soma Analiticas
		If Empty(cSegAte)			//	Se nao tiver filtragem ate o nivel
			If cArqTmp->TIPOCONTA == "2"
				nRetorno := cArqTmp->(FieldGet(nPosCpo))
			EndIf
		Else							//Se tiver filtragem, somo somente as sinteticas
			If cArqTmp->TIPOCONTA == "1" .And. cArqTmp->NIVEL1
				nRetorno := cArqTmp->(FieldGet(nPosCpo))
			EndIf
    	Endif
	EndIf
EndIf

Return nRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F250Fil   ºAutor  ³Eduardo Nunes       º Data ³  06/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Faz a filtragem para impressao, validando o registro       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR370                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function F250Fil(cSegAte,nDigitAte)
Local lDeixa	:= .T.

	If mv_par11 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCONTA == "2"
			lDeixa	:= .F.
		EndIf
	ElseIf mv_par11 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCONTA == "1"
			lDeixa	:= .F.
		EndIf
	EndIf

	//Filtragem ate o Segmento ( antigo nivel do SIGACON)
	If lDeixa .And. !Empty(cSegAte)
		If Len(Alltrim(cArqTmp->CONTA)) > nDigitAte
			lDeixa	:= .F.
		Endif
	EndIf

	If lDeixa .And. (	Abs(cArqTmp->COLUNA1)+Abs(cArqTmp->COLUNA2)+Abs(cArqTmp->COLUNA3)+;
							Abs(cArqTmp->COLUNA4)+Abs(cArqTmp->COLUNA5)+Abs(cArqTmp->COLUNA6)	) == 0

		If mv_par13 == 2					// Saldos Zerados nao serao impressos
			lDeixa	:= .F.
		ElseIf mv_par13 == 1				//	Se imprime saldos zerados, verificar a data de existencia da entidade
			If CtbExDtFim("CT1")
				dbSelectArea("CT1")
				dbSetOrder(1)
				If MsSeek(xFilial()+cArqTmp->CONTA)
					If !CtbVlDtFim("CT1",mv_par01)
						lDeixa	:= .F.
					EndIf
				EndIf
				dbSelectArea("cArqTmp")
				dbSetOrder(1)
			EndIf
		EndIf

   EndIf

Return lDeixa


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint³ Autor ³ Eduardo Nunes      ³ Data ³  06/09/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR250                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport,aSetOfBook,cDescMoeda,nDivide,cMascara)

Local oSection1 	:= oReport:Section(1)
Local cFiltro		:= oSection1:GetAdvplExp()  /*aReturn[7]*/
Local oBreakGrupo
Local oBreak

Local oTotFil1, oTotFil2, oTotFil3, oTotFil4, oTotFil5, oTotFil6, oTotGeral
Local nTotFil1, nTotFil2, nTotFil3, nTotFil4, nTotFil5, nTotFil6, nTotGeral

Local oTotGrp1, oTotGrp2, oTotGrp3, oTotGrp4, oTotGrp5, oTotGrp6, oTotGrpGeral
Local nTotGrp1, nTotGrp2, nTotGrp3, nTotGrp4, nTotGrp5, nTotGrp6, nTotGrpGeral

Local bLineCond
Local lImprime

Local cArqTmp
Local cGrupo		:= ""
Local cGrupoAnt		:= ""
Local cTipoAnt		:= ""

Local lPula			:= Iif(mv_par22==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par23==1,.T.,.F.)
Local cSegAte 	   := mv_par26		// Imprimir ate o Segmento?
Local nDigitAte	:= 0
Local lImpAntLP	:= Iif(mv_par27 == 1,.T.,.F.)
Local dDataLP		:= mv_par28
Local cPicture		:= aSetOfBook[4]
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par14)

Local nCont
Local cPergFil
Local nPergFil		:= 4 //Definido com 4, porque a primeira perg. de filial eh o mv_par05
Local aFiliais		:= {}
Local aDescFil		:= {}
Local Titulo		:= ""
Local lRet        := .T.
Local aRetVld     := {}
Local cDescFil		:= ""
Local aAreaSM0		:= SM0->(GetArea())
Local aFilAux     := {}
Local cFilantAux  := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Davi Torchio - 10/07/2007                                     ³
//³Controle de numeração de pagina para o relatorio personalizado³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nPagIni		:= MV_PAR15 // parametro da pagina inicial
Private nPagFim		:= 999999 	// parametro da pagina final
Private nReinicia	:= 0    	// parametro de reinicio de pagina
Private l1StQb		:= .T.		// primeira quebra
Private lNewVars	:= .T.		// inicializa as variaveis
Private m_pag		:= MV_PAR15 // controle de numeração de pagina
Private nBloco      := 1		// controle do bloco a ser impresso
Private nBlCount	:= 0		// contador do bloco impresso

If lRet
	aRetVld   := CTR250Vld()
	lRet      := aRetVld[1]
	nDivide   := aRetVld[2]
	aCtbMoeda := aRetVld[3]
EndIf

If lRet
	cDescMoeda 	:= Alltrim(aCtbMoeda[2])
	If !Empty(aCtbMoeda[6])
		cDescMoeda += OemToAnsi(STR0007) + aCtbMoeda[6]			// Indica o divisor
	EndIf
EndIf

If !lRet
	oReport:CancelPrint()
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If OREPORT:CTITLE != OemToAnsi(STR0003)
	Titulo:= oReport:cTitle    + " "
ElseIf mv_par11 == 1
	Titulo:=	OemToAnsi(STR0008)	//"COMPARATIVO DE FILIAIS SINTETICO DE "
ElseIf mv_par11 == 2
	Titulo:=	OemToAnsi(STR0005)	//"COMPARATIVO DE FILIAIS ANALITICO DE "
ElseIf mv_par11 == 3
	Titulo:=	OemToAnsi(STR0012)	//"COMPARATIVO DE "
EndIf

Titulo += 	DTOC(mv_par01) + OemToAnsi(STR0006) + Dtoc(mv_par02) + ;
				OemToAnsi(STR0007) + cDescMoeda


oReport:SetPageNumber( MV_PAR15 )
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDatabase,titulo,,,,,oReport) } )

If mv_par16 > "1"
	Titulo += " (" + Tabela("SL", mv_par16, .F.) + ")"
Endif


For nCont := 1 to 6
	cPergFil	:= &("mv_par"+Strzero(nPergFil+nCont,2))
	If Empty(cPergFil)
		AADD(aFiliais,"")
	Else
		AADD(aFiliais,cPergFil)
	EndIf
Next

cFilAntAux := cFilAnt
For nCont := 1 to Len(aFiliais)
	If (!Empty(aFiliais[nCont]))
		If FindFunction("FWFilialName")
			cDescFil := FWFilialName(cEmpAnt, aFiliais[nCont], 1)
		Else
		 SM0->(MsSeek(cEmpAnt+Subs(aFiliais[nCont],1,2)))
			 cDescFil := SM0->M0_FILIAL
		EndIf
		If !Empty(cDescFil)
			AADD(aDescFil,cDescFil)
		Else
			AADD(aDescFil,Space(15))
		EndIf
		cFilAnt := aFiliais[nCont]
		AADD(aFilAux, xFilial("CT7"))
	Else
		AADD(aDescFil,Space(15))
		AADD(aFilAux, Space(Len(xFilial("CT7"))))
	EndIf
Next
cFilAnt := cFilantAux

// Verifica Se existe filtragem Ate o Segmento
If !Empty(cSegAte)
	nDigitAte := CtbRelDig(cSegAte,cMascara)
EndIf

bLineCond	:= {|| F250Fil( cSegAte,nDigitAte ) }

// Setando os titulos das celulas
oSection1:Cell("CONTA    "):SetTitle(STR0022)
oSection1:Cell("DESCRICAO"):SetTitle(STR0023)
oSection1:Cell("FILIAL_01"):SetTitle("     "+STR0024+" 01"	+Iif(!Empty(aDescFil[1]),CRLF+aDescFil[1],""))
oSection1:Cell("FILIAL_02"):SetTitle("     "+STR0024+" 02"	+Iif(!Empty(aDescFil[2]),CRLF+aDescFil[2],""))
oSection1:Cell("FILIAL_03"):SetTitle("     "+STR0024+" 03"	+Iif(!Empty(aDescFil[3]),CRLF+aDescFil[3],""))
oSection1:Cell("FILIAL_04"):SetTitle("     "+STR0024+" 04"	+Iif(!Empty(aDescFil[4]),CRLF+aDescFil[4],""))
oSection1:Cell("FILIAL_05"):SetTitle("     "+STR0024+" 05"	+Iif(!Empty(aDescFil[5]),CRLF+aDescFil[5],""))
oSection1:Cell("FILIAL_06"):SetTitle("     "+STR0024+" 06"	+Iif(!Empty(aDescFil[6]),CRLF+aDescFil[6],""))
oSection1:Cell("TOTAL"):SetTitle("     "+STR0025)

// Setando os blocos para impressao dos valores das celulas
IF !EMPTY(MV_PAR05)
	oSection1:Cell("FILIAL_01"):SetBlock({|| ValorCTB(cArqTmp->COLUNA1,,,nTamValor,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})	//	Movimento da Filial 01
ENDIF
IF !EMPTY(MV_PAR06)
	oSection1:Cell("FILIAL_02"):SetBlock({|| ValorCTB(cArqTmp->COLUNA2,,,nTamValor,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})	//	Movimento da Filial 02
ENDIF
IF !EMPTY(MV_PAR07)
	oSection1:Cell("FILIAL_03"):SetBlock({|| ValorCTB(cArqTmp->COLUNA3,,,nTamValor,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})	//	Movimento da Filial 03
ENDIF
IF !EMPTY(MV_PAR08)
	oSection1:Cell("FILIAL_04"):SetBlock({|| ValorCTB(cArqTmp->COLUNA4,,,nTamValor,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})	//	Movimento da Filial 04
ENDIF
IF !EMPTY(MV_PAR09)
	oSection1:Cell("FILIAL_05"):SetBlock({|| ValorCTB(cArqTmp->COLUNA5,,,nTamValor,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})	//	Movimento da Filial 05
ENDIF
IF !EMPTY(MV_PAR10)
	oSection1:Cell("FILIAL_06"):SetBlock({|| ValorCTB(cArqTmp->COLUNA6,,,nTamValor,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})	//	Movimento da Filial 06
ENDIF
oSection1:Cell("TOTAL"):SetBlock({|| ValorCTB(cArqTmp->(IF(!EMPTY(MV_PAR05),COLUNA1,0)+IF(! EMPTY(MV_PAR06),COLUNA2,0)+IF(!EMPTY(MV_PAR07),COLUNA3,0)+IF(! EMPTY(MV_PAR08),COLUNA4,0)+IF(! EMPTY(MV_PAR09),COLUNA5,0)+IF( ! EMPTY(MV_PAR10),COLUNA6,0)),,,nTamValor,nDecimais,.T.,cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})	//	Total da Linha


oSection1:OnPrintLine( {|| ( IIf(lPula .And. cTipoAnt == "1" ,oReport:SkipLine(),NIL) ) } )

oBreak:= TRBreak():New(oReport, {|| .T. }, STR0011 )  //"T O T A I S  D O  P E R I O D O: "

If mv_par17 == 1				// Grupo Diferente
	oBreakGrupo := TRBreak():New(oSection1, {|| cArqTMP->GRUPO },{||STR0026+": "+cGrupoAnt })  //"Grupo "
	oBreakGrupo:SetPageBreak()
EndIf

// Total da Filial 1
IF !EMPTY(MV_PAR05)
	oTotFil1 :=	TRFunction():New(oSection1:Cell("FILIAL_01"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ || F250Soma(1,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_01"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil1 := oTotFil1:GetValue(),StrTran(ValorCTB(nTotFil1,,,nTamValor+Iif(nTotFil1==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_01"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil1 := oTotFil1:GetValue(),ValorCTB(nTotFil1,,,nTamValor+Iif(nTotFil1==0,2,0),nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	Endif
	oTotFil1:Disable()
ENDIF

IF !EMPTY(MV_PAR06)
	// Total da Filial 2
	oTotFil2 :=	TRFunction():New(oSection1:Cell("FILIAL_02"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ || F250Soma(2,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_02"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil2 := oTotFil2:GetValue(), StrTran(ValorCTB(nTotFil2,,,nTamValor+Iif(nTotFil2==0,2,0),nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_02"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil2 := oTotFil2:GetValue(), ValorCTB(nTotFil2,,,nTamValor+Iif(nTotFil2==0,2,0),nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
		EndIF
	oTotFil2:Disable()
ENDIF

IF !EMPTY(MV_PAR07)
	// Total da Filial 3
	oTotFil3 :=	TRFunction():New(oSection1:Cell("FILIAL_03"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ || F250Soma(3,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_03"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil3 := oTotFil3:GetValue(),StrTran(ValorCTB(nTotFil3,,,nTamValor+Iif(nTotFil3==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_03"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil3 := oTotFil3:GetValue(),ValorCTB(nTotFil3,,,nTamValor+Iif(nTotFil3==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotFil3:Disable()
ENDIF

IF !EMPTY(MV_PAR08)
	// Total da Filial 4
	oTotFil4 :=	TRFunction():New(oSection1:Cell("FILIAL_04"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ || F250Soma(4,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_04"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil4 := oTotFil4:GetValue(),StrTran(ValorCTB(nTotFil4,,,nTamValor+Iif(nTotFil4==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_04"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil4 := oTotFil4:GetValue(),ValorCTB(nTotFil4,,,nTamValor+Iif(nTotFil4==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotFil4:Disable()
ENDIF

IF !EMPTY(MV_PAR09)
	// Total da Filial 5
	oTotFil5 :=	TRFunction():New(oSection1:Cell("FILIAL_05"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ || F250Soma(5,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_05"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil5 := oTotFil5:GetValue(),StrTran(ValorCTB(nTotFil5,,,nTamValor+Iif(nTotFil5==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_05"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil5 := oTotFil5:GetValue(),ValorCTB(nTotFil5,,,nTamValor+Iif(nTotFil5==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotFil5:Disable()
ENDIF

IF !EMPTY(MV_PAR10)
	// Total da Filial 6
	oTotFil6 :=	TRFunction():New(oSection1:Cell("FILIAL_06"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ || F250Soma(6,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_06"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil6 := oTotFil6:GetValue(),StrTran(ValorCTB(nTotFil6,,,nTamValor+Iif(nTotFil6==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_06"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,;
			{ || (nTotFil6 := oTotFil6:GetValue(),ValorCTB(nTotFil6,,,nTamValor+Iif(nTotFil6==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotFil6:Disable()
ENDIF

// Total Geral
oTotGeral := TRFunction():New(oSection1:Cell("TOTAL"),nil,"SUM"		,oBreak,/*Titulo*/,/*cPicture*/,{ ||IF(! EMPTY(MV_PAR05),F250Soma(1,cSegAte),0)+ IF( ! EMPTY(MV_PAR06),F250Soma(2,cSegAte),0)+IF( ! EMPTY(MV_PAR07),F250Soma(3,cSegAte),0)+;
	IF( ! EMPTY(MV_PAR08),F250Soma(4,cSegAte),0)+ IF( ! EMPTY(MV_PAR09),F250Soma(5,cSegAte),0)+ IF( ! EMPTY(MV_PAR10),F250Soma(6,cSegAte),0)},.F.,.F.,.F.,oSection1)
If lIsRedStor
	TRFunction():New(oSection1:Cell("TOTAL"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,{ || (nTotGeral := oTotGeral:GetValue(),;
		StrTran(ValorCTB(nTotGeral,,,nTamValor+Iif(nTotGeral==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
Else
	TRFunction():New(oSection1:Cell("TOTAL"),nil,"ONPRINT"	,oBreak,/*Titulo*/,/*cPicture*/,{ || (nTotGeral := oTotGeral:GetValue(),;
		ValorCTB(nTotGeral,,,nTamValor+Iif(nTotGeral==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
EndIF

// Desabilitando, pois a quebra sera feita pelo oBreak

oTotGeral:Disable()

IF !EMPTY(MV_PAR05)
	// Total Grupo Filial 01
	oTotGrp1	:=	TRFunction():New(oSection1:Cell("FILIAL_01"),nil,"SUM"		,oBreakGrupo,/*Titulo*/,/*cPicture*/,{ || F250Soma(1,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_01"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp1 := iif(oTotGrp1:GetValue()==nil,0,oTotGrp1:GetValue()),StrTran(ValorCTB(nTotGrp1,,,nTamValor+Iif(nTotGrp1==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_01"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp1 := iif(oTotGrp1:GetValue()==nil,0,oTotGrp1:GetValue()),ValorCTB(nTotGrp1,,,nTamValor+Iif(nTotGrp1==0,2,0),nDecimais,.T.,cPicture,"1",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotGrp1:Disable()
ENDIF

IF !EMPTY(MV_PAR06)
	// Total Grupo Filial 02
	oTotGrp2 :=	TRFunction():New(oSection1:Cell("FILIAL_02"),nil,"SUM"		,oBreakGrupo,/*Titulo*/,/*cPicture*/,{ || F250Soma(2,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_02"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp2 := iif(oTotGrp2:GetValue()==nil,0,oTotGrp2:GetValue()),StrTran(ValorCTB(nTotGrp2,,,nTamValor+Iif(nTotGrp2==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_02"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp2 := iif(oTotGrp2:GetValue()==nil,0,oTotGrp2:GetValue()),ValorCTB(nTotGrp2,,,nTamValor+Iif(nTotGrp2==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotGrp2:Disable()
ENDIF

IF !EMPTY(MV_PAR07)
	// Total Grupo Filial 03
	oTotGrp3 :=	TRFunction():New(oSection1:Cell("FILIAL_03"),nil,"SUM"		,oBreakGrupo,/*Titulo*/,/*cPicture*/,{ || F250Soma(3,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_03"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp3 := iif(oTotGrp3:GetValue()==nil,0,oTotGrp3:GetValue()),StrTran(ValorCTB(nTotGrp3,,,nTamValor+Iif(nTotGrp3==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_03"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp3 := iif(oTotGrp3:GetValue()==nil,0,oTotGrp3:GetValue()),ValorCTB(nTotGrp3,,,nTamValor+Iif(nTotGrp3==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotGrp3:Disable()
ENDIF

IF !EMPTY(MV_PAR08)
	// Total Grupo Filial 04
	oTotGrp4 :=	TRFunction():New(oSection1:Cell("FILIAL_04"),nil,"SUM"		,oBreakGrupo,/*Titulo*/,/*cPicture*/,{ || F250Soma(4,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_04"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp4 := iif(oTotGrp4:GetValue()==nil,0,oTotGrp4:GetValue()),StrTran(ValorCTB(nTotGrp4,,,nTamValor+Iif(nTotGrp4==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_04"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp4 := iif(oTotGrp4:GetValue()==nil,0,oTotGrp4:GetValue()),ValorCTB(nTotGrp4,,,nTamValor+Iif(nTotGrp4==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotGrp4:Disable()
ENDIF

IF !EMPTY(MV_PAR09)
	// Total Grupo Filial 05
	oTotGrp5 :=	TRFunction():New(oSection1:Cell("FILIAL_05"),nil,"SUM"		,oBreakGrupo,/*Titulo*/,/*cPicture*/,{ || F250Soma(5,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_05"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp5 := iif(oTotGrp5:GetValue()==nil,0,oTotGrp5:GetValue()),StrTran(ValorCTB(nTotGrp5,,,nTamValor+Iif(nTotGrp5==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_05"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp5 := iif(oTotGrp5:GetValue()==nil,0,oTotGrp5:GetValue()),ValorCTB(nTotGrp5,,,nTamValor+Iif(nTotGrp5==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotGrp5:Disable()
ENDIF

IF !EMPTY(MV_PAR10)
	// Total Grupo Filial 06
	oTotGrp6 :=	TRFunction():New(oSection1:Cell("FILIAL_06"),nil,"SUM"		,oBreakGrupo,/*Titulo*/,/*cPicture*/,{ || F250Soma(6,cSegAte) },.F.,.F.,.F.,oSection1)
	If lIsRedStor
		TRFunction():New(oSection1:Cell("FILIAL_06"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp6 := iif(oTotGrp6:GetValue()==nil,0,oTotGrp6:GetValue()),StrTran(ValorCTB(nTotGrp6,,,nTamValor+Iif(nTotGrp6==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
	Else
		TRFunction():New(oSection1:Cell("FILIAL_06"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
			{ || (nTotGrp6 := iif(oTotGrp6:GetValue()==nil,0,oTotGrp6:GetValue()),ValorCTB(nTotGrp6,,,nTamValor+Iif(nTotGrp6==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
	EndIF
	oTotGrp6:Disable()
ENDIF

// Total Geral por Grupo
oTotGrpGeral :=	TRFunction():New(oSection1:Cell("TOTAL"),nil,"SUM"		,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
	{ ||	IF(! EMPTY(MV_PAR05),F250Soma(1,cSegAte),0)+ IF( ! EMPTY(MV_PAR06),F250Soma(2,cSegAte),0)+IF( ! EMPTY(MV_PAR07),F250Soma(3,cSegAte),0)+;
	IF( ! EMPTY(MV_PAR08),F250Soma(4,cSegAte),0)+ IF( ! EMPTY(MV_PAR09),F250Soma(5,cSegAte),0)+ IF( ! EMPTY(MV_PAR10),F250Soma(6,cSegAte),0)},.F.,.F.,.F.,oSection1)
If lIsRedStor
	TRFunction():New(oSection1:Cell("TOTAL"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
		{ || (nTotGrpGeral := iif(oTotGrpGeral:GetValue()==nil,0,oTotGrpGeral:GetValue()),StrTran(ValorCTB(nTotGrpGeral,,,nTamValor+Iif(nTotGrpGeral==0,2,0),nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.F.,.F.,.F.,oSection1)
Else
	TRFunction():New(oSection1:Cell("TOTAL"),nil,"ONPRINT"	,oBreakGrupo,/*Titulo*/,/*cPicture*/,;
		{ || (nTotGrpGeral := iif(oTotGrpGeral:GetValue()==nil,0,oTotGrpGeral:GetValue()),ValorCTB(nTotGrpGeral,,,nTamValor+Iif(nTotGrpGeral==0,2,0),nDecimais,.T.,cPicture,"2",,,,,,lPrintZero,.F.)) },.F.,.F.,.F.,oSection1)
EndIF

// Desabilitando, pois a quebra sera feita pelo oBreakGrupo
oTotGrpGeral:Disable()

#IFNDEF TOP
	If !Empty(cFiltro)
		CT1->( dbSetFilter( { || &cFiltro }, cFiltro ) )
	EndIf
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
				mv_par01,mv_par02,"CT7","",mv_par03,mv_par04,,,,,,,mv_par14,;
				mv_par16,aSetOfBook,mv_par18,mv_par19,mv_par20,mv_par21,;
				.F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,"M",.T.,aFilAux/*aFiliais*/,,,,,,.T.,,cFiltro)},;
				OemToAnsi(OemToAnsi(STR0015)),;  //"Criando Arquivo Tempor rio..."
				OemToAnsi(STR0003))  				//"Comparativo de Contas Contabeis com Filiais"

If Select("cArqTmp") == 0
	oReport:CancelPrint()
	Return
EndIf

// Desabilita processamento do filtro pelo objeto, pois o arquivo temporario jah vem filtrado
oReport:NoUserFilter()

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])
	dbCloseArea()
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
	oReport:CancelPrint()
	Return
Endif

oReport:SetMeter(RecCount())

dbSelectArea("cArqTmp")
cGrupo    := cArqTmp->GRUPO
cGrupoAnt := cArqTmp->GRUPO

oSection1:Init()

While !Eof()

	If oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()

	lImprime := Eval(bLineCond)
	If lImprime

		cGrupoAnt	:= If(	cGrupo <> cArqTmp->GRUPO .Or. EOF(),	cGrupo,	cGrupoAnt	)
		cGrupo 		:= If(	!EOF(),	cArqTmp->GRUPO,	cGrupo	)
		cTipoAnt	:= cArqTmp->TIPOCONTA

		If mv_par17 != 1 .And. cArqTmp->NIVEL1
			oReport:EndPage()
		EndIf

		oSection1:PrintLine()

	EndIf

	dbSelectArea("cArqTmp")
	dbSkip()

EndDo

If mv_par17 == 1
	oBreakGrupo:SetPageBreak(.F.)
EndIf

cGrupoAnt := cGrupo


dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase(cArqTmp+OrdBagExt())
EndIF
dbselectArea("CT2")

RestArea(aAreaSM0)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CTR250VLD ³ Autor ³ Felipe Aurelio de Melo³ Data ³ 28.10.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Responsavel pela validacao de alguns parametros            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CTR250Vld()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1   - lRet                                             ³±±
±±³          ³ ExpN1   - nDivideo                                         ³±±
±±³          ³ ExpA1   - aCtbMoeda                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CTR250VLD()

Local lRet      := .T.
Local lLoop     := .T.
Local nDivide   :=  1
Local aCtbMoeda := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano ³
//³ Gerencial -> montagem especifica para impressao)			      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do While lLoop
	If lRet .And. !Ct040Valid(mv_par12)
		lRet := .F.
	EndIf

	If lRet
		If mv_par25 == 2			// Divide por cem
			nDivide := 100
		ElseIf mv_par25 == 3		// Divide por mil
			nDivide := 1000
		ElseIf mv_par25 == 4		// Divide por milhao
			nDivide := 1000000
		EndIf

		aCtbMoeda := CtbMoeda(mv_par14,nDivide)
		If Empty(aCtbMoeda[1])
			Help(" ",1,"NOMOEDA")
			lRet := .F.
		Endif
	Endif
	If lRet
		lLoop := .F.
	Else
		lLoop := Pergunte("CTR250",.T.)
		lRet := lLoop
	EndIf
EndDo

Return({lRet,nDivide,aCtbMoeda})
